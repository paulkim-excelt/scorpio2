/*****************************************************************************
 Copyright 2021 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_ethsrv_swt_mirror_host_impl Mirror Host Helpers Design
    @ingroup grp_ethernet_abstract

    @addtogroup grp_ethsrv_swt_mirror_host_impl
    @{

    @file ethswtm_mirror_host.c

    @brief Ethernet Switch Mirror Host Command Helper

    @version 0.1 Initial version
*/
#include <stdio.h>
#include <string.h>
#include <module_msg.h>
#include <bcm_comp.h>
#include <bcm_utils.h>
#include <cpu_utils.h>
#include <ethernet_swt_debug.h>

/**
    @name Ethernet Switch Mirror Helper Design ID's
    @{
    @brief Ethernet Switch Mirror Helper Design ID's
*/
#define BRCM_SWDSGN_ETHSWT_DEBUG_MIRROR_HELPER_CTX_GLOBAL        (0xC101U)   /**< @brief #ETHSWT_DebugMirrorHelperCtx        */
#define BRCM_SWDSGN_ETHSWT_DEBUG_MIRROR_HELPCOMMANDS_GLOBAL      (0xC102U)   /**< @brief #ETHSWT_DebugMirrorHelpCmds         */
#define BRCM_SWDSGN_ETHSWT_DEBUG_MIRROR_HELPERPREP_CTX_PROC      (0xC103U)   /**< @brief #ETHSWT_DebugMirrorHelperPrepCtx    */
#define BRCM_SWDSGN_ETHSWT_DEBUG_MIRROR_ENABLE_HELPER_HDLR_PROC  (0xC104U)   /**< @brief #ETHSWT_DebugMirrorEnHelperHdlr     */
#define BRCM_SWDSGN_ETHSWT_DEBUG_MIRROR_DISABLE_HELPER_HDLR_PROC (0xC105U)   /**< @brief #ETHSWT_DebugMirrorDisHelperHdlr    */
#define BRCM_SWDSGN_ETHSWT_DEBUG_MIRROR_STATUS_HELPER_HDLR_PROC  (0xC106U)   /**< @brief #ETHSWT_DebugMirrorStatusHelperHdlr */
#define BRCM_SWDSGN_ETHSWT_DEBUG_MIRROR_PROCESS_PROC             (0xC107U)   /**< @brief #ETHSWT_DebugMirrorProcess          */
#define BRCM_SWDSGN_ETHSWT_DEBUG_MIRROR_HELPER_GLOBAL            (0xC108U)   /**< @brief #ETHSWT_DebugMirrorHelper           */
#define BRCM_SWDSGN_ETHSWT_DEBUGMIRRORHELPERCTX_TYPE             (0xC109U)   /**< @brief #ETHSWT_DebugMirrorHelperCtxType    */
/** @} */

/**
    @brief Switch Debug Helper Context Type

    @trace #BRCM_SWARCH_ETHSWT_DEBUGHOSTCONTEXT_TYPE
    @trace #BRCM_SWREQ_ETHSWT
*/
typedef struct sETHSWT_DebugMirrorHelperCtxType {
    MODULE_MsgContextType       modCtx;   /**< @brief Helper interface Context     */
    ETHSWT_DebugHostContextType ctx;      /**< @brief Abstract interface Context   */
} ETHSWT_DebugMirrorHelperCtxType;

/**
    @brief Switch Mirror Helper Module Context

    @trace #BRCM_SWARCH_ETHSWT_DEBUGHOSTCONTEXT_TYPE
    @trace #BRCM_SWREQ_ETHSWT
*/
ETHSWT_DebugMirrorHelperCtxType ETHSWT_DebugMirrorHelperCtx;

/**
    @brief Switch Mirror Supported commands

    @trace #BRCM_SWARCH_ETHSWT_DEBUGMIRRORHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT
*/
static const char ETHSWT_DebugMirrorHelpCmds[] =
"enable <port bitmap> <probe port> <ingress|egress> [packetDivider]\n"
"disable\n"
"status\n"
;

/**
    @brief Prepare Switch Mirror context

    @trace #BRCM_SWARCH_ETHSWT_DEBUGMIRRORHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
int32_t ETHSWT_DebugMirrorHelperPrepCtx(char          *aStr,
                                        uint32_t      *aStrLen,
                                        ETHSWT_DebugMirrorHelperCtxType *aCtx)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    int32_t  parseStatus = 0;
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
            MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen); /* mirror */
            if ((remStr != NULL) && (remStrLen > 1UL)) {
                currStr = remStr;
                currStrLen = remStrLen;
                MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
                if ((currStr != NULL) && (currStrLen > 1UL)) {
                    if (!strncmp(currStr, "enable", 6)) {
                        if ((remStr == NULL) || (remStrLen == 0)) {
                            goto done;
                        }

                        currStr = remStr;
                        currStrLen = remStrLen;
                        aCtx->ctx.msg.mirrorEnable.mirrorCfg.portMask = MODULE_MsgParseInt(currStr, &parseStatus); /* port bitmap */
                        if(BCM_ERR_OK != parseStatus) {
                            goto done;
                        }
                        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
                        if ((remStr == NULL) || (remStrLen == 0)) {
                            goto done;
                        }

                        currStr = remStr;
                        currStrLen = remStrLen;
                        aCtx->ctx.msg.mirrorEnable.probePort = MODULE_MsgParseInt(currStr, &parseStatus); /* probe port */
                        if(BCM_ERR_OK != parseStatus) {
                            goto done;
                        }


                        /* make sure the port bitmap is non-zero and
                           don't allow the probe port in the port bitmap
                           TODO: Validate this check with active slaveID??
                        */
                        if ((aCtx->ctx.msg.mirrorEnable.mirrorCfg.portMask == 0x0)
                                || ((aCtx->ctx.msg.mirrorEnable.mirrorCfg.portMask & (1 << aCtx->ctx.msg.mirrorEnable.probePort)) != 0x0)) {
                            (void)MODULE_HostHelperLog("Invalid port bitmap or conflicting probe port\n");
                            goto done;
                        }


                        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
                        if ((remStr == NULL) || (remStrLen == 0)) {
                            goto done;
                        }
                        currStr = remStr;
                        currStrLen = remStrLen;

                        if(!strncmp(currStr, "ingress", 7)){
                            aCtx->ctx.msg.mirrorEnable.direction = ETHSWT_TRAFFICDIR_INGRESS;
                        }else if(!strncmp(currStr, "egress", 6)){
                            aCtx->ctx.msg.mirrorEnable.direction = ETHSWT_TRAFFICDIR_EGRESS;
                        }else{
                            goto done;
                        }

                        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
                        if ((remStr != NULL) && (remStrLen != 0)) {
                            aCtx->ctx.msg.mirrorEnable.mirrorCfg.packetDivider = MODULE_MsgParseInt(remStr, &parseStatus); /* packetDivider */
                            if(BCM_ERR_OK != parseStatus) {
                                goto done;
                            }
                            currStr = remStr;
                            currStrLen = remStrLen;
                            MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
                        }
                        if ((remStr != NULL) || (remStrLen != 0)) {
                            goto done;
                        }
                        aCtx->ctx.id = ETHSWT_DEBUGCMDID_MIRROR_ENABLE;
                        retVal = BCM_ERR_OK;
                    }else if (!strncmp(currStr,"disable", 7)) {
                        if ((remStr == NULL) && (remStrLen == 0)) {
                            aCtx->ctx.id = ETHSWT_DEBUGCMDID_MIRROR_DISABLE;
                            retVal = BCM_ERR_OK;
                        }
                    }else if (!strncmp(currStr, "status", 6)) {
                        if ((remStr == NULL) && (remStrLen == 0)) {
                            aCtx->ctx.id = ETHSWT_DEBUGCMDID_MIRROR_STATUS;
                            retVal = BCM_ERR_OK;
                        }
                    } else {
                        retVal = BCM_ERR_INVAL_PARAMS;
                    }
                }
            }

        }
    }

done:
    return retVal;
}

/**
    @brief Switch Mirror Enable Helper handler

    @trace #BRCM_SWARCH_ETHSWT_DEBUGMIRRORHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
int32_t ETHSWT_DebugMirrorEnHelperHdlr(BCM_CmdType    *aMsg,
                                       uint8_t       *aBuff,
                                       uint32_t       aInputLen,
                                       uint32_t      *aOutLen,
                                       uint32_t       aMaxLength,
                                       int32_t        aResponse,
                                       ETHSWT_DebugMirrorHelperCtxType *aCtx)
{
    int32_t retVal = BCM_ERR_UNKNOWN;
    ETHSWT_DebugMsgUnionType cmdMsg;
    BCM_MemCpy(cmdMsg.data, aBuff, aInputLen);
    switch(aCtx->modCtx.substate) {
        case BCM_STATE_SUB_STATE_STAGE0:
            cmdMsg.mirrorEnable.probePort = CPU_NativeToLE32(aCtx->ctx.msg.mirrorEnable.probePort);
            cmdMsg.mirrorEnable.mirrorCfg.portMask = CPU_NativeToLE16(aCtx->ctx.msg.mirrorEnable.mirrorCfg.portMask);
            cmdMsg.mirrorEnable.direction = aCtx->ctx.msg.mirrorEnable.direction;
            cmdMsg.mirrorEnable.mirrorCfg.packetDivider = CPU_NativeToLE16(aCtx->ctx.msg.mirrorEnable.mirrorCfg.packetDivider);
            BCM_MemSet(cmdMsg.mirrorEnable.mirrorCfg.destMacAddrFilter, 0U, sizeof(cmdMsg.mirrorEnable.mirrorCfg.destMacAddrFilter));
            BCM_MemSet(cmdMsg.mirrorEnable.mirrorCfg.srcMacAddrFilter, 0U, sizeof(cmdMsg.mirrorEnable.mirrorCfg.srcMacAddrFilter));

            *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_DBG_ID, ETHSWT_DEBUGCMDID_MIRROR_ENABLE);
            *aOutLen = sizeof(ETHSWT_DebugMirrorEnableType);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            retVal = BCM_ERR_OK;
            break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Failed to enable mirroring mode, retVal = %d\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(ETHSWT_DebugMirrorEnableType))) {
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
    @brief Switch Mirror Disable Helper handler

    @trace #BRCM_SWARCH_ETHSWT_DEBUGMIRRORHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
int32_t ETHSWT_DebugMirrorDisHelperHdlr(BCM_CmdType    *aMsg,
                                        uint8_t       *aBuff,
                                        uint32_t       aInputLen,
                                        uint32_t      *aOutLen,
                                        uint32_t       aMaxLength,
                                        int32_t        aResponse,
                                        ETHSWT_DebugMirrorHelperCtxType *aCtx)
{
    int32_t retVal = BCM_ERR_UNKNOWN;

    switch(aCtx->modCtx.substate) {
        case BCM_STATE_SUB_STATE_STAGE0:
            *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_DBG_ID, ETHSWT_DEBUGCMDID_MIRROR_DISABLE);
            *aOutLen = 0UL;
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            retVal = BCM_ERR_OK;
            break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Failed to disable mirroring mode, retVal = %d\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else {
                aCtx->modCtx.substate = BCM_STATE_SUB_STATE_DONE;
                retVal = BCM_ERR_OK;
            }
        default:
            break;
    }

    return retVal;
}

/**
    @brief Switch Mirror Status Helper handler

    @trace #BRCM_SWARCH_ETHSWT_DEBUGMIRRORHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
int32_t ETHSWT_DebugMirrorStatusHelperHdlr(BCM_CmdType    *aMsg,
                                           uint8_t       *aBuff,
                                           uint32_t       aInputLen,
                                           uint32_t      *aOutLen,
                                           uint32_t       aMaxLength,
                                           int32_t        aResponse,
                                           ETHSWT_DebugMirrorHelperCtxType *aCtx)
{
    int32_t retVal = BCM_ERR_UNKNOWN;
    ETHSWT_DebugMsgUnionType respMsg;
    BCM_MemCpy(respMsg.data, aBuff, aInputLen);

    switch(aCtx->modCtx.substate) {
        case BCM_STATE_SUB_STATE_STAGE0:
            *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_DBG_ID, ETHSWT_DEBUGCMDID_MIRROR_STATUS);
            *aOutLen = sizeof(ETHSWT_DebugMirrorStatusType);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            retVal = BCM_ERR_OK;
            break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Failed to get mirror status, retVal = %d\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(ETHSWT_DebugMirrorStatusType))) {
                (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                retVal = BCM_ERR_UNKNOWN;
            } else {
                aCtx->ctx.msg.mirrorStatus.state = CPU_LEToNative32(respMsg.mirrorStatus.state);
                aCtx->ctx.msg.mirrorStatus.ingressMirrorCfg.portMask = CPU_LEToNative16(respMsg.mirrorStatus.ingressMirrorCfg.portMask);
                aCtx->ctx.msg.mirrorStatus.egressMirrorCfg.portMask = CPU_LEToNative16(respMsg.mirrorStatus.egressMirrorCfg.portMask);
                aCtx->ctx.msg.mirrorStatus.probePort = CPU_LEToNative32(respMsg.mirrorStatus.probePort);

                if (ETHSWT_PORTMIRRORSTATE_ENABLED == aCtx->ctx.msg.mirrorStatus.state) {
                    (void)MODULE_HostHelperLog("Mirroring is enabled for ingress_port_bitmap=0x%x, egress_port_bitmap=0x%x and probe_port=%d\n",
                             aCtx->ctx.msg.mirrorStatus.ingressMirrorCfg.portMask, aCtx->ctx.msg.mirrorStatus.egressMirrorCfg.portMask, aCtx->ctx.msg.mirrorStatus.probePort);
                } else {
                    (void)MODULE_HostHelperLog("Mirroring is disabled\n");
                }
                aCtx->modCtx.substate = BCM_STATE_SUB_STATE_DONE;
                retVal = BCM_ERR_OK;
            }
        default:
            break;
    }
    BCM_MemCpy(aBuff, respMsg.data, *aOutLen);
    return retVal;
}

/** @brief Process Switch Mirror string or response byte array

    @trace #BRCM_SWARCH_ETHSWT_DEBUGMIRRORHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
static int32_t ETHSWT_DebugMirrorProcess(BCM_CmdType   *aMsg,
                                         char          *aStr,
                                         uint32_t      *aStrLen,
                                         uint8_t       *aInOut,
                                         uint32_t       aInputLen,
                                         uint32_t      *aOutLen,
                                         uint32_t       aMaxLength,
                                         int32_t        aResponse)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    if(BCM_STATE_SUB_STATE_RESET == ETHSWT_DebugMirrorHelperCtx.modCtx.substate) {
        retVal = ETHSWT_DebugMirrorHelperPrepCtx(aStr, aStrLen,
                                          &ETHSWT_DebugMirrorHelperCtx);
        if(BCM_ERR_OK ==retVal) {
            ETHSWT_DebugMirrorHelperCtx.modCtx.substate = BCM_STATE_SUB_STATE_STAGE0;
        }
    }

    switch(ETHSWT_DebugMirrorHelperCtx.ctx.id) {
        case ETHSWT_DEBUGCMDID_MIRROR_ENABLE:
            retVal = ETHSWT_DebugMirrorEnHelperHdlr(aMsg, aInOut, aInputLen,
                                             aOutLen, aMaxLength, aResponse,
                                             &ETHSWT_DebugMirrorHelperCtx);
        break;
        case ETHSWT_DEBUGCMDID_MIRROR_DISABLE:
            retVal = ETHSWT_DebugMirrorDisHelperHdlr(aMsg, aInOut, aInputLen,
                                             aOutLen, aMaxLength, aResponse,
                                             &ETHSWT_DebugMirrorHelperCtx);
        break;
        case ETHSWT_DEBUGCMDID_MIRROR_STATUS:
            retVal = ETHSWT_DebugMirrorStatusHelperHdlr(aMsg, aInOut, aInputLen,
                                             aOutLen, aMaxLength, aResponse,
                                             &ETHSWT_DebugMirrorHelperCtx);
        break;
        default:
            if(BCM_ERR_OK == retVal) {
                retVal = BCM_ERR_UNKNOWN;
            }
            break;
    }

    return retVal;
}

/**
    @brief Switch Mirror Helper

    @trace #BRCM_SWARCH_ETHSWT_DEBUGMIRRORHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT
*/
const MODULE_MsgConverterType ETHSWT_DebugMirrorHelper = {
    .groupId = BCM_GROUPID_ETHSRV,
    .compId  = BCM_DBG_ID,
    .helpstr = ETHSWT_DebugMirrorHelpCmds,
    .context = &ETHSWT_DebugMirrorHelperCtx.modCtx,
    .process = ETHSWT_DebugMirrorProcess,
};
/** @} */
