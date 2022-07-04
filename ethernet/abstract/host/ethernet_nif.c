/*****************************************************************************
 Copyright 2022 Broadcom Limited.  All rights reserved.

 This program is the proprietary software of Broadcom Limited and/or its
 licensors, and may only be used, duplicated, modified or distributed pursuant
 to the terms and conditions of a separate, written license agreement executed
 between you and Broadcom (an "Authorized License").

 Except as set forth in an Authorized License, Broadcom grants no license
 (express or implied), right to use, or waiver of any kind with respect to the
 Software, and Broadcom expressly reserves all rights in and to the Software
 and all intellectual property rights therein.  IF YOU HAVE NO AUTHORIZED
 LICENSE, THEN YOU HAVE NO RIGHT TO USE THIS SOFTWARE IN ANY WAY, AND SHOULD
 IMMEDIATELY NOTIFY BROADCOM AND DISCONTINUE ALL USE OF THE SOFTWARE.

  Except as expressly set forth in the Authorized License,
 1. This program, including its structure, sequence and organization,
    constitutes the valuable trade secrets of Broadcom, and you shall use all
    reasonable efforts to protect the confidentiality thereof, and to use this
    information only in connection with your use of Broadcom integrated
    circuit products.

 2. TO THE MAXIMUM EXTENT PERMITTED BY LAW, THE SOFTWARE IS PROVIDED "AS IS"
    AND WITH ALL FAULTS AND BROADCOM MAKES NO PROMISES, REPRESENTATIONS OR
    WARRANTIES, EITHER EXPRESS, IMPLIED, STATUTORY, OR OTHERWISE, WITH RESPECT
    TO THE SOFTWARE.  BROADCOM SPECIFICALLY DISCLAIMS ANY AND ALL IMPLIED
    WARRANTIES OF TITLE, MERCHANTABILITY, NONINFRINGEMENT, FITNESS FOR A
    PARTICULAR PURPOSE, LACK OF VIRUSES, ACCURACY OR COMPLETENESS,
    QUIET ENJOYMENT, QUIET POSSESSION OR CORRESPONDENCE TO DESCRIPTION.
    YOU ASSUME THE ENTIRE RISK ARISING OUT OF USE OR PERFORMANCE OF THE
    SOFTWARE.

 3. TO THE MAXIMUM EXTENT PERMITTED BY LAW, IN NO EVENT SHALL BROADCOM OR ITS
    LICENSORS BE LIABLE FOR (i) CONSEQUENTIAL, INCIDENTAL, SPECIAL, INDIRECT,
    OR EXEMPLARY DAMAGES WHATSOEVER ARISING OUT OF OR IN ANY WAY RELATING TO
    YOUR USE OF OR INABILITY TO USE THE SOFTWARE EVEN IF BROADCOM HAS BEEN
    ADVISED OF THE POSSIBILITY OF SUCH DAMAGES; OR (ii) ANY AMOUNT IN EXCESS
    OF THE AMOUNT ACTUALLY PAID FOR THE SOFTWARE ITSELF OR U.S. $1, WHICHEVER
    IS GREATER. THESE LIMITATIONS SHALL APPLY NOTWITHSTANDING ANY FAILURE OF
    ESSENTIAL PURPOSE OF ANY LIMITED REMEDY.
******************************************************************************/
/**
    @defgroup grp_ethernet_nif_host_impl Controller Helper Design
    @ingroup grp_ethernet_abstract

    @addtogroup grp_ethernet_nif_host_impl
    @{

    @file ethernet_nif.c
    @brief NIF Helper Implementation

    @version 1.0 Initial version
*/
#include <stdio.h>
#include <unistd.h>
#include <module_msg.h>
#include <bcm_comp.h>
#include <bcm_utils.h>
#include <cpu_utils.h>
#include <string.h>
#include <ethernet_nif.h>

/**
    @name Controller Helper Design IDs
    @{
    @brief Controller Helper Design IDs
*/
#define BRCM_SWDSGN_ETHER_MDIOHELPERCTX_TYPE           (0xBC01U)   /**< @brief #ETHER_MDIOHelperCtxType   */
#define BRCM_SWDSGN_ETHER_MDIOHELPER_CTX_GLOBAL        (0xBC02U)   /**< @brief #ETHER_MDIOHelperCtx       */
#define BRCM_SWDSGN_ETHER_MDIOHELPCMDS_GLOBAL          (0xBD03U)   /**< @brief #ETHER_MDIOHelpCmds        */
#define BRCM_SWDSGN_ETHER_MDIOHELPERPREP_CTX_PROC      (0xBC03U)   /**< @brief #ETHER_MDIOHelperPrepCtx   */
#define BRCM_SWDSGN_ETHER_MDIOREADHELPERHDLR_PROC      (0xBC04U)   /**< @brief #ETHER_MDIOReadHelperHdlr  */
#define BRCM_SWDSGN_ETHER_MDIOWRITEHELPERHDLR_PROC     (0xBC05U)   /**< @brief #ETHER_MDIOWriteHelperHdlr */
#define BRCM_SWDSGN_ETHER_MDIOHELPERPROCESS_PROC       (0xBC06U)   /**< @brief #ETHER_MDIOHelperProcess   */
#define BRCM_SWDSGN_ETHER_MDIOHELPER_GLOBAL            (0xBC07U)   /**< @brief #ETHER_MDIOHelper          */
#define BRCM_SWDSGN_ETHER_HOSTCONTEXTSETUP_PROC        (0xBC08U)   /**< @brief #ETHER_HostContextSetup    */
#define BRCM_SWDSGN_ETHER_HOSTCONTEXTPROCESS_PROC      (0xBC09U)   /**< @brief #ETHER_HostContextProcess  */
/** @} */

/**
    @brief NIF Helper Module Context Type

    @trace #BRCM_SWARCH_ETHER_MDIOHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHER
*/
typedef struct sETHER_MDIOHelperCtxType {
    MODULE_MsgContextType      modCtx;    /**< @brief Helper interface Context */
    ETHER_HostContextType   ctx;       /**< @brief Abstract interface Context */
} ETHER_MDIOHelperCtxType;

/**
    @brief MDIO Helper Module Context

    @trace #BRCM_SWARCH_ETHER_MDIOHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHER
*/
ETHER_MDIOHelperCtxType ETHER_MDIOHelperCtx;

/**
    @brief MDIO Supported commands

    @trace #BRCM_SWARCH_ETHER_MDIOHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHER
*/
static const char ETHER_MDIOHelpCmds[] =
"cl22 read <mdioHwID> <phy> <reg> <0:master|1:slave>\n"
"cl22 write <mdioHwID> <phy> <reg> <data> <0:master|1:slave>\n"
"cl45 read <mdioHwID> <phy> <devType> <reg> <0:master|1:slave>\n"
"cl45 write <mdioHwID> <phy> <devType> <reg> <data> <0:master|1:slave>\n"
;

/**
    @brief Prepare MDIO Helper context

    @trace #BRCM_SWARCH_ETHER_MDIOHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHER

    @code{.unparsed}
    @endcode
*/
int32_t ETHER_MDIOHelperPrepCtx(char          *aStr,
                                uint32_t      *aStrLen,
                                ETHER_MDIOHelperCtxType *aCtx)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    int32_t  parseStatus = 0;
    uint32_t write;
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    if(NULL != aStr) {
        currStr = aStr;
        currStrLen = *aStrLen;
        /* skip the first string which is validated in the above layer */
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        if ((remStr != NULL) && (remStrLen > 1UL)) {
            currStr = remStr;
            currStrLen = remStrLen;
            MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
            if (!strncmp(currStr, "cl22", 4)) {
                aCtx->ctx.msg.mdioAccess.pkt.regAccMode = ETHER_MDIOREGACCESS_CL22;
            } else if (!strncmp(currStr, "cl45", 4)) {
                aCtx->ctx.msg.mdioAccess.pkt.regAccMode = ETHER_MDIOREGACCESS_CL45;
            } else {
                goto done;
            }

            currStr = remStr;
            currStrLen = remStrLen;

            MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
            if ((remStr == NULL) || (remStrLen == 0)) {
                goto done;
            }

            if (!strncmp(currStr, "read", 4)) {
                write = FALSE;
            } else if (!strncmp(currStr, "write", 5)) {
                write = TRUE;
            } else {
                goto done;
            }

            currStr = remStr;
            currStrLen = remStrLen;
            /* Fetch the mdio hw ID */
            MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
            if ((remStr == NULL) || (remStrLen == 0)) {
                goto done;
            }
            aCtx->ctx.msg.mdioAccess.mdioHwID = MODULE_MsgParseInt(currStr, &parseStatus);
            if(BCM_ERR_OK != parseStatus) {
                goto done;
            }

            currStr = remStr;
            currStrLen = remStrLen;
            /* Fetch the phy address into phy */
            MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
            if ((remStr == NULL) || (remStrLen == 0)) {
                goto done;
            }
            aCtx->ctx.msg.mdioAccess.pkt.slaveAddr = MODULE_MsgParseInt(currStr, &parseStatus);
            if(BCM_ERR_OK != parseStatus) {
                goto done;
            }

            if (ETHER_MDIOREGACCESS_CL45 == aCtx->ctx.msg.mdioAccess.pkt.regAccMode) {
                currStr = remStr;
                currStrLen = remStrLen;
                /* Fetch the dev address into dev */
                MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
                if ((remStr == NULL) || (remStrLen == 0)) {
                    goto done;
                }
                aCtx->ctx.msg.mdioAccess.pkt.deviceType = MODULE_MsgParseInt(currStr, &parseStatus);
                if(BCM_ERR_OK != parseStatus) {
                    goto done;
                }
            }

            currStr = remStr;
            currStrLen = remStrLen;
            /* Fetch the register address */
            MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
            if ((remStr == NULL) || (remStrLen == 0)) {
                goto done;
            }
            aCtx->ctx.msg.mdioAccess.pkt.regAddr = MODULE_MsgParseInt(currStr, &parseStatus);
            if(BCM_ERR_OK != parseStatus) {
                goto done;
            }

            currStr = remStr;
            currStrLen = remStrLen;

            if (write == FALSE) {
                MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
                if ((remStr != NULL) || (remStrLen != 0)) {
                    goto done;
                }

                /* Fetch device Type[master or slave] */
                aCtx->ctx.msg.mdioAccess.deviceID = MODULE_MsgParseInt(currStr, &parseStatus);
                if(BCM_ERR_OK != parseStatus) {
                    goto done;
                }
                aCtx->ctx.id = ETHER_CMDID_MDIO_READ;
                retVal = BCM_ERR_OK;
            } else {
                /* Fetch register value */
                MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
                if ((remStr == NULL) || (remStrLen == 0)) {
                    goto done;
                }

                aCtx->ctx.msg.mdioAccess.pkt.regData = MODULE_MsgParseInt(currStr, &parseStatus);
                if(BCM_ERR_OK != parseStatus) {
                    goto done;
                }

                currStr = remStr;
                currStrLen = remStrLen;
                /* Fetch device Type master or slave] */
                MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
                if ((remStr != NULL) || (remStrLen != 0)) {
                    goto done;
                }
                aCtx->ctx.msg.mdioAccess.deviceID  = MODULE_MsgParseInt(currStr, &parseStatus);
                if(BCM_ERR_OK != parseStatus) {
                    goto done;
                }
                aCtx->ctx.id = ETHER_CMDID_MDIO_WRITE;
                retVal = BCM_ERR_OK;
            }
        } else {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
    }

done:
    return retVal;
}

/**
    @brief MDIO Read Helper handler

    @trace #BRCM_SWARCH_ETHER_MDIOHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHER

    @code{.unparsed}
    @endcode
*/
int32_t ETHER_MDIOReadHelperHdlr(BCM_CmdType    *aMsg,
                                 uint8_t       *aBuff,
                                 uint32_t       aInputLen,
                                 uint32_t      *aOutLen,
                                 uint32_t       aMaxLength,
                                 int32_t        aResponse,
                                 ETHER_MDIOHelperCtxType *aCtx)
{
    int32_t retVal = BCM_ERR_UNKNOWN;
    ETHER_MsgUnionType cmdMsg;
    ETHER_MsgUnionType respMsg;

    BCM_MemCpy(cmdMsg.data, aBuff, aInputLen);
    BCM_MemCpy(respMsg.data, aBuff, aInputLen);
    switch(aCtx->modCtx.substate) {
        case BCM_STATE_SUB_STATE_STAGE0:
            cmdMsg.mdioAccess.pkt.regAccMode = aCtx->ctx.msg.mdioAccess.pkt.regAccMode;
            cmdMsg.mdioAccess.pkt.slaveAddr  = aCtx->ctx.msg.mdioAccess.pkt.slaveAddr;
            cmdMsg.mdioAccess.pkt.deviceType = aCtx->ctx.msg.mdioAccess.pkt.deviceType;
            cmdMsg.mdioAccess.pkt.regAddr    = CPU_NativeToLE16(aCtx->ctx.msg.mdioAccess.pkt.regAddr);
            cmdMsg.mdioAccess.deviceID       = CPU_NativeToLE32(aCtx->ctx.msg.mdioAccess.deviceID);
            cmdMsg.mdioAccess.mdioHwID       = CPU_NativeToLE32(aCtx->ctx.msg.mdioAccess.mdioHwID);
            *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_ETH_ID, ETHER_CMDID_MDIO_READ);
            *aOutLen = sizeof(ETHER_MDIOAccessType);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            retVal = BCM_ERR_OK;
            break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Error in read function err:0x%x\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(ETHER_MDIOAccessType))) {
                (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                retVal = BCM_ERR_UNKNOWN;
            } else {
                aCtx->ctx.msg.mdioAccess.pkt.regData = CPU_LEToNative16(respMsg.mdioAccess.pkt.regData);
                (void)MODULE_HostHelperLog("0x%04X\n", aCtx->ctx.msg.mdioAccess.pkt.regData);
                aCtx->modCtx.substate = BCM_STATE_SUB_STATE_DONE;
                retVal = BCM_ERR_OK;
            }
            break;
        default:
            break;
    }
    BCM_MemCpy(aBuff, cmdMsg.data, *aOutLen);
    return retVal;
}


/**
    @brief MDIO Write Helper handler

    @trace #BRCM_SWARCH_ETHER_MDIOHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHER

    @code{.unparsed}
    @endcode
*/
int32_t ETHER_MDIOWriteHelperHdlr(BCM_CmdType    *aMsg,
                                  uint8_t       *aBuff,
                                  uint32_t       aInputLen,
                                  uint32_t      *aOutLen,
                                  uint32_t       aMaxLength,
                                  int32_t        aResponse,
                                  ETHER_MDIOHelperCtxType *aCtx)
{
    int32_t retVal = BCM_ERR_UNKNOWN;
    ETHER_MsgUnionType cmdMsg;

    BCM_MemCpy(cmdMsg.data, aBuff, aInputLen);
    switch(aCtx->modCtx.substate) {
        case BCM_STATE_SUB_STATE_STAGE0:
            cmdMsg.mdioAccess.pkt.regAccMode = aCtx->ctx.msg.mdioAccess.pkt.regAccMode;
            cmdMsg.mdioAccess.pkt.slaveAddr  = aCtx->ctx.msg.mdioAccess.pkt.slaveAddr;
            cmdMsg.mdioAccess.pkt.deviceType = aCtx->ctx.msg.mdioAccess.pkt.deviceType;
            cmdMsg.mdioAccess.pkt.regAddr    = CPU_NativeToLE16(aCtx->ctx.msg.mdioAccess.pkt.regAddr);
            cmdMsg.mdioAccess.pkt.regData    = CPU_NativeToLE16(aCtx->ctx.msg.mdioAccess.pkt.regData);
            cmdMsg.mdioAccess.deviceID       = CPU_NativeToLE32(aCtx->ctx.msg.mdioAccess.deviceID);
            cmdMsg.mdioAccess.mdioHwID       = CPU_NativeToLE32(aCtx->ctx.msg.mdioAccess.mdioHwID);
            *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_ETH_ID, ETHER_CMDID_MDIO_WRITE);
            *aOutLen = sizeof(ETHER_MDIOAccessType);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            retVal = BCM_ERR_OK;
            break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Error in memory write 0x%x\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else {
                aCtx->modCtx.substate = BCM_STATE_SUB_STATE_DONE;
                retVal = BCM_ERR_OK;
            }
            break;
        default:
            break;
    }
    BCM_MemCpy(aBuff, cmdMsg.data, *aOutLen);
    return retVal;
}

/** @brief Process MDIO request string or response byte array

    @trace #BRCM_SWARCH_ETHER_MDIOHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHER

    @code{.unparsed}
    @endcode
*/
static int32_t ETHER_MDIOHelperProcess(BCM_CmdType   *aMsg,
                                      char          *aStr,
                                      uint32_t      *aStrLen,
                                      uint8_t       *aInOut,
                                      uint32_t       aInputLen,
                                      uint32_t      *aOutLen,
                                      uint32_t       aMaxLength,
                                      int32_t        aResponse)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    if(BCM_STATE_SUB_STATE_RESET == ETHER_MDIOHelperCtx.modCtx.substate) {
        retVal = ETHER_MDIOHelperPrepCtx(aStr, aStrLen,
                                          &ETHER_MDIOHelperCtx);
        if(BCM_ERR_OK ==retVal) {
            ETHER_MDIOHelperCtx.modCtx.substate = BCM_STATE_SUB_STATE_STAGE0;
        }
    }

    switch(ETHER_MDIOHelperCtx.ctx.id) {
        case ETHER_CMDID_MDIO_READ:
                retVal = ETHER_MDIOReadHelperHdlr(aMsg, aInOut, aInputLen,
                                                     aOutLen, aMaxLength, aResponse,
                                                     &ETHER_MDIOHelperCtx);
            break;
        case ETHER_CMDID_MDIO_WRITE:
                retVal = ETHER_MDIOWriteHelperHdlr(aMsg, aInOut, aInputLen,
                                                      aOutLen, aMaxLength, aResponse,
                                                      &ETHER_MDIOHelperCtx);
            break;
        default:
            break;
    }

    return retVal;
}

/** @brief NIF Setup function

    @trace #BRCM_SWARCH_ETHER_MDIOHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHER

    @code{.unparsed}
    @endcode
*/
int32_t ETHER_HostContextSetup(ETHER_HostContextType *aContext, ETHER_CmdIdType aCmdID,
                               const ETHER_MsgUnionType *aMsgPayload)
{
    return BCM_ERR_NOSUPPORT;
}

/** @brief NIF Process function

    @trace #BRCM_SWARCH_ETHER_MDIOHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHER

    @code{.unparsed}
    @endcode
*/
int32_t ETHER_HostContextProcess(ETHER_HostContextType *aContext, int32_t aResponse,
                                 BCM_CmdType aInMsgID, const uint8_t *aInMsgPayload,
                                 BCM_CmdType *aOutMsgId, uint8_t *aOutMsgPayload)
{
    return BCM_ERR_NOSUPPORT;
}

/**
    @brief MDIO Access Helper

    @trace #BRCM_SWARCH_ETHER_MDIOHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHER
*/
const MODULE_MsgConverterType ETHER_MDIOHelper = {
    .helpstr = ETHER_MDIOHelpCmds,
    .context = &ETHER_MDIOHelperCtx.modCtx,
    .process = ETHER_MDIOHelperProcess,
};

/** @} */
