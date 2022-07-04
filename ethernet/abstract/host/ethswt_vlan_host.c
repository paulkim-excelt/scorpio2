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
    @defgroup grp_ethswt_vlan_host_impl VLAN Host Helpers Design
    @ingroup grp_ethernet_abstract

    @addtogroup grp_ethswt_vlan_host_impl
    @{

    @file ethswt_vlan_host.c

    @brief Ethernet VLAN Command Helper

    @version 0.1 Initial version
*/
#include <stdio.h>
#include <string.h>
#include <module_msg.h>
#include <bcm_comp.h>
#include <bcm_utils.h>
#include <cpu_utils.h>
#include <ethernet_swt_vlan.h>

/**
    @name Ethernet switch VLAN Helper Design ID's
    @{
    @brief Ethernet switch VLAN Helper Design ID's
*/
#define BRCM_SWDSGN_ETHSWT_VLANHELPERCTX_GLOBAL            (0xBE01U)    /**< @brief #ETHSWT_VLANHelperCtx           */
#define BRCM_SWDSGN_ETHSWT_VLANHELPCMDS_GLOBAL             (0xBE02U)    /**< @brief #ETHSWT_VLANHelpCmds            */
#define BRCM_SWDSGN_ETHSWT_VLAN_GETCTXINT_PROC             (0xBE03U)    /**< @brief #ETHSWT_VLANGetCtxInt           */
#define BRCM_SWDSGN_ETHSWT_VLAN_ADDCTXINT_PROC             (0xBE04U)    /**< @brief #ETHSWT_VLANAddCtxInt           */
#define BRCM_SWDSGN_ETHSWT_VLAN_DELCTXINT_PROC             (0xBE05U)    /**< @brief #ETHSWT_VLANDelCtxInt           */
#define BRCM_SWDSGN_ETHSWT_VLAN_HOPCTRLCTXINT_PROC         (0xBE06U)    /**< @brief #ETHSWT_VLANHopCtrlCtxInt       */
#define BRCM_SWDSGN_ETHSWT_VLAN_HELPERPREP_CTX_PROC        (0xBE07U)    /**< @brief #ETHSWT_VLANHelperPrepCtx       */
#define BRCM_SWDSGN_ETHSWT_VLAN_GET_HELPER_HDLR_PROC       (0xBE08U)    /**< @brief #ETHSWT_VLANGetHelperHdlr       */
#define BRCM_SWDSGN_ETHSWT_VLAN_ADD_HELPER_HDLR_PROC       (0xBE09U)    /**< @brief #ETHSWT_VLANAddHelperHdlr       */
#define BRCM_SWDSGN_ETHSWT_VLAN_DEL_HELPER_HDLR_PROC       (0xBE0AU)    /**< @brief #ETHSWT_VLANDelHelperHdlr       */
#define BRCM_SWDSGN_ETHSWT_VLANHELPERPROCESS_PROC          (0xBE0BU)    /**< @brief #ETHSWT_VLANHelperProcess       */
#define BRCM_SWDSGN_ETHSWT_VLANHELPER_GLOBAL               (0xBE0CU)    /**< @brief #ETHSWT_VLANHelper              */
#define BRCM_SWDSGN_ETHSWT_VLANCONTEXT_TYPE                (0xBE0DU)    /**< @brief #ETHSWT_VLANContextType         */
#define BRCM_SWDSGN_ETHSWT_VLANHOSTCONTEXTSETUP_PROC       (0xBE0EU)    /**< @brief #ETHSWT_VLANHostContextSetup    */
#define BRCM_SWDSGN_ETHSWT_VLANHOSTCONTEXTPROCESS_PROC     (0xBE0FU)    /**< @brief #ETHSWT_VLANHostContextProcess  */
/** @} */

/**
    @brief VLAN Helper Module Context Type

    @trace #BRCM_SWARCH_ETHSWT_VLANHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT
*/
typedef struct sETHSWT_VLANContextType {
    MODULE_MsgContextType modCtx;      /**< @brief Helper interface Context */
    ETHSWT_VLANHostContextType ctx;    /**< @brief Abstract interface Context */
} ETHSWT_VLANContextType;

/**
    @brief VLAN Helper Module Context

    @trace #BRCM_SWARCH_ETHSWT_VLANHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT
*/
ETHSWT_VLANContextType ETHSWT_VLANHelperCtx;

/**
    @brief VLAN Supported commands

    @trace #BRCM_SWARCH_ETHSWT_VLANHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT
*/
static const char ETHSWT_VLANHelpCmds[] =
"get <vlan id>\n"
"add <vlan id> <portMask> <tagMask>\n"
"del <vlan id> <portMask>\n"
;

/**
    @brief Prepare VLAN Get context

    @trace #BRCM_SWARCH_ETHSWT_VLANHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
static int32_t ETHSWT_VLANGetCtxInt(char        *aStr,
                                    uint32_t     aStrLen,
                                    ETHSWT_VLANContextType *aCtx)
{
    char *remStr;
    uint32_t remStrLen;
    int32_t  parseStatus = 0;
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
    if ((remStr != NULL) || (remStrLen != 0)) {
        goto done;
    }
    aCtx->ctx.msg.vlanPort.vlan = MODULE_MsgParseInt(aStr, &parseStatus); /* vlan ID */
    if(BCM_ERR_OK != parseStatus) {
        goto done;
    }
    aCtx->ctx.id = ETHSWT_VLANCMDID_GET;
    retVal = BCM_ERR_OK;

done:
    return retVal;
}


/**
    @brief VLAN Get handler

    @trace #BRCM_SWARCH_ETHSWT_VLANHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
int32_t ETHSWT_VLANGetHelperHdlr(BCM_CmdType   *aMsg,
                                 uint8_t       *aBuff,
                                 uint32_t       aInputLen,
                                 uint32_t      *aOutLen,
                                 uint32_t       aMaxLength,
                                 int32_t        aResponse,
                                 ETHSWT_VLANContextType *aCtx)
{
    int32_t retVal = BCM_ERR_UNKNOWN;
    ETHSWT_VLANMsgUnionType payloadMsg;
    BCM_MemCpy(payloadMsg.data, aBuff, aInputLen);

    switch(aCtx->modCtx.substate) {
        case BCM_STATE_SUB_STATE_STAGE0:
            payloadMsg.vlanPort.vlan = CPU_NativeToLE16(aCtx->ctx.msg.vlanPort.vlan);
            *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_VLN_ID, ETHSWT_VLANCMDID_GET);
            *aOutLen = sizeof(ETHSWT_VLANPortType);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            retVal = BCM_ERR_OK;
            break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Failed to get VLAN information retVal = %d\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(ETHSWT_VLANPortType))) {
                (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                retVal = BCM_ERR_UNKNOWN;
            } else {
                aCtx->ctx.msg.vlanPort.vlan           = CPU_LEToNative16(payloadMsg.vlanPort.vlan);
                aCtx->ctx.msg.vlanPort.portMask        = CPU_LEToNative32(payloadMsg.vlanPort.portMask);
                aCtx->ctx.msg.vlanPort.tagMask        = CPU_LEToNative32(payloadMsg.vlanPort.tagMask);
                aCtx->ctx.msg.vlanPort.staticPortMask = CPU_LEToNative32(payloadMsg.vlanPort.staticPortMask);
                (void)MODULE_HostHelperLog("VLAN %u PortMask : 0x%x\n",
                                          aCtx->ctx.msg.vlanPort.vlan,
                                          aCtx->ctx.msg.vlanPort.portMask);
                (void)MODULE_HostHelperLog("VLAN %u Tagged Port Mask: 0x%x\n",
                                          aCtx->ctx.msg.vlanPort.vlan,
                                          aCtx->ctx.msg.vlanPort.tagMask);
                (void)MODULE_HostHelperLog("VLAN %u Static Port Mask: 0x%x\n",
                                          aCtx->ctx.msg.vlanPort.vlan,
                                          aCtx->ctx.msg.vlanPort.staticPortMask);
                aCtx->modCtx.substate = BCM_STATE_SUB_STATE_DONE;
                retVal = BCM_ERR_OK;
            }
        default:
            break;
    }
    BCM_MemCpy(aBuff, payloadMsg.data, *aOutLen);
    return retVal;
}

/**
    @brief Prepare VLAN Add context

    @trace #BRCM_SWARCH_ETHSWT_VLANHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
 static int32_t ETHSWT_VLANAddCtxInt(char          *aStr,
                                     uint32_t      aStrLen,
                                     ETHSWT_VLANContextType *aCtx)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    int32_t  parseStatus = 0;
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
    if ((remStr == NULL) || (remStrLen == 0)) {
        goto done;
    }

    aCtx->ctx.msg.vlanPort.vlan = MODULE_MsgParseInt(aStr, &parseStatus); /* vlan */
    if(BCM_ERR_OK != parseStatus) {
        goto done;
    }

    currStr = remStr;
    currStrLen = remStrLen;
    MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
    aCtx->ctx.msg.vlanPort.portMask = MODULE_MsgParseInt(currStr, &parseStatus); /* portMask */
    if(BCM_ERR_OK != parseStatus) {
        goto done;
    }

    if ((remStr == NULL) || (remStrLen == 0)) {
        goto done;
    }
    currStr = remStr;
    currStrLen = remStrLen;
    MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);

    aCtx->ctx.msg.vlanPort.tagMask = MODULE_MsgParseInt(currStr, &parseStatus); /* Tag Mask */
    if(BCM_ERR_OK != parseStatus) {
        goto done;
    }

    if ((remStr != NULL) || (remStrLen != 0)) {
        goto done;
    }
    aCtx->ctx.id = ETHSWT_VLANCMDID_PORT_ADD;
    retVal = BCM_ERR_OK;

done:
    return retVal;
}

/**
    @brief VLAN Add handler

    @trace #BRCM_SWARCH_ETHSWT_VLANHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
int32_t ETHSWT_VLANAddHelperHdlr(BCM_CmdType   *aMsg,
                                 uint8_t       *aBuff,
                                 uint32_t       aInputLen,
                                 uint32_t      *aOutLen,
                                 uint32_t       aMaxLength,
                                 int32_t        aResponse,
                                 ETHSWT_VLANContextType *aCtx)
{
    int32_t retVal = BCM_ERR_UNKNOWN;
    ETHSWT_VLANMsgUnionType cmdMsg;

    switch(aCtx->modCtx.substate) {
        case BCM_STATE_SUB_STATE_STAGE0:
            cmdMsg.vlanPort.vlan = CPU_NativeToLE16(aCtx->ctx.msg.vlanPort.vlan);
            cmdMsg.vlanPort.portMask = CPU_NativeToLE32(aCtx->ctx.msg.vlanPort.portMask);
            cmdMsg.vlanPort.tagMask = CPU_NativeToLE32(aCtx->ctx.msg.vlanPort.tagMask);
            *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_VLN_ID, ETHSWT_VLANCMDID_PORT_ADD);
            *aOutLen = sizeof(ETHSWT_VLANPortType);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            retVal = BCM_ERR_OK;
            break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Failed to add the port to the VLAN, ret = %d\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(ETHSWT_VLANPortType))) {
                (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                retVal = BCM_ERR_UNKNOWN;
            } else {
                aCtx->modCtx.substate = BCM_STATE_SUB_STATE_DONE;
                retVal = BCM_ERR_OK;
            }
        default:
            break;
    }
    BCM_MemCpy(aBuff, cmdMsg.data, *aOutLen);
    return retVal;
}

/**
    @brief Prepare VLAN Delete context

    @trace #BRCM_SWARCH_ETHSWT_VLANHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
static int32_t ETHSWT_VLANDelCtxInt(char         *aStr,
                                    uint32_t      aStrLen,
                                    ETHSWT_VLANContextType *aCtx)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    int32_t  parseStatus = 0;
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);

    aCtx->ctx.msg.vlanPort.vlan = MODULE_MsgParseInt(aStr, &parseStatus); /* vlan */
    if(BCM_ERR_OK != parseStatus) {
        goto done;
    }

    if ((remStr == NULL) || (remStrLen == 0)) {
        goto done;
    }
    currStr = remStr;
    currStrLen = remStrLen;
    MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);

    aCtx->ctx.msg.vlanPort.portMask = MODULE_MsgParseInt(currStr, &parseStatus); /* portMask */
    if(BCM_ERR_OK != parseStatus) {
        goto done;
    }
    if ((remStr != NULL) || (remStrLen != 0)) {
        goto done;
    }
    aCtx->ctx.id = ETHSWT_VLANCMDID_PORT_REMOVE;
    retVal = BCM_ERR_OK;

done:
    return retVal;
}

/**
    @brief VLAN Delete handler

    @trace #BRCM_SWARCH_ETHSWT_VLANHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
int32_t ETHSWT_VLANDelHelperHdlr(BCM_CmdType   *aMsg,
                                 uint8_t       *aBuff,
                                 uint32_t       aInputLen,
                                 uint32_t      *aOutLen,
                                 uint32_t       aMaxLength,
                                 int32_t        aResponse,
                                 ETHSWT_VLANContextType *aCtx)
{
    int32_t retVal = BCM_ERR_UNKNOWN;
    ETHSWT_VLANMsgUnionType cmdMsg;

    switch(aCtx->modCtx.substate) {
        case BCM_STATE_SUB_STATE_STAGE0:
            cmdMsg.vlanPort.vlan = CPU_NativeToLE16(aCtx->ctx.msg.vlanPort.vlan);
            cmdMsg.vlanPort.portMask = CPU_NativeToLE32(aCtx->ctx.msg.vlanPort.portMask);
            *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_VLN_ID, ETHSWT_VLANCMDID_PORT_REMOVE);
            *aOutLen = sizeof(ETHSWT_VLANPortType);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            retVal = BCM_ERR_OK;
            break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Permission denied to delete static port from the VLAN\n");
                retVal = BCM_ERR_UNKNOWN;
            } else if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Failed to delete the port from the VLAN, ret = %d\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(ETHSWT_VLANPortType))) {
                (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                retVal = BCM_ERR_UNKNOWN;
            } else {
                aCtx->modCtx.substate = BCM_STATE_SUB_STATE_DONE;
                retVal = BCM_ERR_OK;
            }
        default:
            break;
    }
    BCM_MemCpy(aBuff, cmdMsg.data, *aOutLen);
    return retVal;
}

/**
    @brief Prepare VLAN Helper context

    @trace #BRCM_SWARCH_ETHSWT_VLANHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
int32_t ETHSWT_VLANHelperPrepCtx(char          *aStr,
                                 uint32_t      *aStrLen,
                                 ETHSWT_VLANContextType *aCtx)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    if(NULL != aStr) {
        currStr = aStr;
        currStrLen = *aStrLen;
        aCtx->modCtx.substate = BCM_STATE_SUB_STATE_DONE;
        /* skip the first 2 strings which are checked in the above layer */
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen); /* switch */
        if ((remStr != NULL) && (remStrLen > 1UL)) {
            currStr = remStr;
            currStrLen = remStrLen;
            MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen); /* vlan */
            if ((remStr != NULL) && (remStrLen > 1UL)) {
                currStr = remStr;
                currStrLen = remStrLen;
                MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
                if ((remStr != NULL) && (remStrLen > 1UL)) {
                    if (!strncmp(currStr, "get", 3)) {
                        retVal = ETHSWT_VLANGetCtxInt(remStr, remStrLen, aCtx);
                    } else if (!strncmp(currStr, "add", 3)) {
                        retVal = ETHSWT_VLANAddCtxInt(remStr, remStrLen, aCtx);
                    } else if (!strncmp(currStr, "del", 3)) {
                        retVal = ETHSWT_VLANDelCtxInt(remStr, remStrLen, aCtx);
                    } else {
                        retVal = BCM_ERR_INVAL_PARAMS;
                    }
                }
            }
        }
    }

    return retVal;
}

/** @brief Process VLAN request string or response byte array

    @trace #BRCM_SWARCH_ETHSWT_VLANHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
static int32_t ETHSWT_VLANHelperProcess(BCM_CmdType   *aMsg,
                                        char          *aStr,
                                        uint32_t      *aStrLen,
                                        uint8_t       *aInOut,
                                        uint32_t       aInputLen,
                                        uint32_t      *aOutLen,
                                        uint32_t       aMaxLength,
                                        int32_t        aResponse)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    if(BCM_STATE_SUB_STATE_RESET == ETHSWT_VLANHelperCtx.modCtx.substate) {
        retVal = ETHSWT_VLANHelperPrepCtx(aStr, aStrLen,
                                          &ETHSWT_VLANHelperCtx);
        if(BCM_ERR_OK ==retVal) {
            ETHSWT_VLANHelperCtx.modCtx.substate = BCM_STATE_SUB_STATE_STAGE0;
        }
    }

    switch(ETHSWT_VLANHelperCtx.ctx.id) {
        case ETHSWT_VLANCMDID_GET:
            retVal = ETHSWT_VLANGetHelperHdlr(aMsg, aInOut, aInputLen,
                                              aOutLen, aMaxLength, aResponse,
                                              &ETHSWT_VLANHelperCtx);
            break;
        case ETHSWT_VLANCMDID_PORT_ADD:
            retVal = ETHSWT_VLANAddHelperHdlr(aMsg, aInOut, aInputLen,
                                              aOutLen, aMaxLength, aResponse,
                                              &ETHSWT_VLANHelperCtx);
            break;
        case ETHSWT_VLANCMDID_PORT_REMOVE:
            retVal = ETHSWT_VLANDelHelperHdlr(aMsg, aInOut, aInputLen,
                                              aOutLen, aMaxLength, aResponse,
                                              &ETHSWT_VLANHelperCtx);
            break;
        default:
            if(BCM_ERR_OK == retVal) {
                retVal = BCM_ERR_UNKNOWN;
            }
            break;
    }

    return retVal;
}

/** @brief VLAN Setup function

    @trace #BRCM_SWARCH_ETHSWT_VLANHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
int32_t ETHSWT_VLANHostContextSetup(ETHSWT_VLANHostContextType *aContext, ETHSWT_VLANCmdIdType aCmdID,
                                    const ETHSWT_VLANMsgUnionType *aMsgPayload)
{
    return BCM_ERR_NOSUPPORT;
}

/** @brief VLAN Process function

    @trace #BRCM_SWARCH_ETHSWT_VLANHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
int32_t ETHSWT_VLANHostContextProcess(ETHSWT_VLANHostContextType *aContext, int32_t aResponse,
                                      BCM_CmdType aInMsgID, const uint8_t *aInMsgPayload,
                                      BCM_CmdType *aOutMsgId, uint8_t *aOutMsgPayload)
{
    return BCM_ERR_NOSUPPORT;
}

/**
    @brief Switch VLAN Helper

    @trace #BRCM_SWARCH_ETHSWT_VLANHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT
*/
const MODULE_MsgConverterType ETHSWT_VLANHelper = {
    .groupId = BCM_GROUPID_ETHSRV,
    .compId  = BCM_VLN_ID,
    .helpstr = ETHSWT_VLANHelpCmds,
    .context = &ETHSWT_VLANHelperCtx.modCtx,
    .process = ETHSWT_VLANHelperProcess,
};
/** @} */
