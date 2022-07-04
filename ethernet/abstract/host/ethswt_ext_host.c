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
    @defgroup grp_ethsrv_swt_ext_host_impl Switch Security Helpers Design
    @ingroup grp_ethernet_abstract

    @addtogroup grp_ethsrv_swt_ext_host_impl
    @{

    @file ethswtm_ext_host.c

    @brief Switch Host Security Command Helper

    @version 0.1 Initial version
*/
#include <stdio.h>
#include <string.h>
#include <module_msg.h>
#include <bcm_comp.h>
#include <bcm_utils.h>
#include <cpu_utils.h>
#include <ethernet_swt_ext.h>
#include <ethswt_host_common.h>

/**
    @name Ethernet switch Security Helper Design ID's
    @{
    @brief Ethernet switch Security Helper Design ID's
*/

/** @} */
#define BRCM_SWDSGN_ETHSWT_SWT_SECURITY_ACTIONTOSTR_PROC           (0xC2C1U)   /**< @brief #ETHSWT_SWTsecurityActionToStr         */
#define BRCM_SWDSGN_ETHSWT_SWT_VLAN_SETHOP_HELPER_HDLR_PROC        (0xC2C2U)   /**< @brief #ETHSWT_SWTVlanSetHopHelperHdlr        */
#define BRCM_SWDSGN_ETHSWT_SWT_VLAN_GETHOP_HELPER_HDLR_PROC        (0xC2C3U)   /**< @brief #ETHSWT_SWTVlanGetHopHelperHdlr        */
#define BRCM_SWDSGN_ETHSWT_SWT_ARL_SET_PORTLIMITHELPER_HDLR_PROC   (0xC2C4U)   /**< @brief #ETHSWT_SWTArlSetPortLimitHelperHdlr   */
#define BRCM_SWDSGN_ETHSWT_SWT_ARL_GET_PORTLIMITHELPER_HDLR_PROC   (0xC2C5U)   /**< @brief #ETHSWT_SWTArlGetPortLimitHelperHdlr   */
#define BRCM_SWDSGN_ETHSWT_SWT_ARL_SET_STICKYHELPER_HDLR_PROC      (0xC2C6U)   /**< @brief #ETHSWT_SWTArlSetStickyHelperHdlr      */
#define BRCM_SWDSGN_ETHSWT_SWT_ARL_GET_STICKYHELPER_HDLR_PROC      (0xC2C7U)   /**< @brief #ETHSWT_SWTArlGetStickyHelperHdlr      */
#define BRCM_SWDSGN_ETHSWT_SWT_ARL_SET_MVDETHELPER_HDLR_PROC       (0xC2C8U)   /**< @brief #ETHSWT_SWTArlSetMvDetHelperHdlr       */
#define BRCM_SWDSGN_ETHSWT_SWT_ARL_GET_MVDETHELPER_HDLR_PROC       (0xC2C9U)   /**< @brief #ETHSWT_SWTArlGetMvDetHelperHdlr       */
#define BRCM_SWDSGN_ETHSWT_SWT_ARL_SET_TOTALLIMITHELPER_HDLR_PROC  (0xC2CAU)   /**< @brief #ETHSWT_SWTArlSetTotalLimitHelperHdlr  */
#define BRCM_SWDSGN_ETHSWT_SWT_ARL_GET_TOTALLIMITHELPER_HDLR_PROC  (0xC2CBU)   /**< @brief #ETHSWT_SWTArlGetTotalLimitHelperHdlr  */

/**
    @brief print security action

    @trace #BRCM_SWARCH_ETHSWT_SWTHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
static void ETHSWT_SWTsecurityActionToStr(ETHSWT_SecurityActionType aAction)
{
    switch (aAction) {
        case ETHSWT_SECURITY_ACTION_DISABLED:
            (void)MODULE_HostHelperLog("Disabled\n");
            break;
        case ETHSWT_SECURITY_ACTION_DROP_PKT:
            (void)MODULE_HostHelperLog("Drop Packet\n");
            break;
        case ETHSWT_SECURITY_ACTION_NORMAL:
            (void)MODULE_HostHelperLog("Normal\n");
            break;
        case ETHSWT_SECURITY_ACTION_REDIRECT_TO_CPU:
            (void)MODULE_HostHelperLog("Redirect to CPU\n");
            break;
        case ETHSWT_SECURITY_ACTION_COPY_TO_CPU:
            (void)MODULE_HostHelperLog("Copy to CPU\n");
            break;
        default:
            (void)MODULE_HostHelperLog("Invalid\n");
            break;
    }
}

/**
    @brief VLAN Set Hop handler

    @trace #BRCM_SWARCH_ETHSWT_SWTHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
int32_t ETHSWT_SWTVlanSetHopHelperHdlr(BCM_CmdType   *aMsg,
                                       uint8_t       *aBuff,
                                       uint32_t       aInputLen,
                                       uint32_t      *aOutLen,
                                       uint32_t       aMaxLength,
                                       int32_t        aResponse,
                                       ETHSWT_SWTHelperCtxType *aCtx)
{
    int32_t retVal = BCM_ERR_UNKNOWN;
    ETHSWT_ExtMsgUnionType cmdMsg;
    BCM_MemCpy(cmdMsg.data, aBuff, aInputLen);
    switch(aCtx->modCtx.substate) {
        case BCM_STATE_SUB_STATE_STAGE0:
            cmdMsg.vlanHoppingAction = CPU_NativeToLE32(aCtx->ctx.msg.vlanHoppingAction);
            *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_SWT_ID, ETHSWT_EXTCMDID_VLAN_HOPPING_DETECTION_SET);
            *aOutLen = sizeof(aCtx->ctx.msg.vlanHoppingAction);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            retVal = BCM_ERR_OK;
            break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Failed to set vlan hop_detect action, ret = %d\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(aCtx->ctx.msg.vlanHoppingAction))) {
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
    @brief VLAN Get Hop handler

    @trace #BRCM_SWARCH_ETHSWT_SWTHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
int32_t ETHSWT_SWTVlanGetHopHelperHdlr(BCM_CmdType   *aMsg,
                                       uint8_t       *aBuff,
                                       uint32_t       aInputLen,
                                       uint32_t      *aOutLen,
                                       uint32_t       aMaxLength,
                                       int32_t        aResponse,
                                       ETHSWT_SWTHelperCtxType *aCtx)
{
    int32_t retVal = BCM_ERR_UNKNOWN;
    ETHSWT_ExtMsgUnionType respMsg;
    BCM_MemCpy(respMsg.data, aBuff, aInputLen);
    switch(aCtx->modCtx.substate) {
        case BCM_STATE_SUB_STATE_STAGE0:
            *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_SWT_ID, ETHSWT_EXTCMDID_VLAN_HOPPING_DETECTION_GET);
            *aOutLen = sizeof(aCtx->ctx.msg.vlanHoppingAction);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            retVal = BCM_ERR_OK;
            break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Failed to get vlan hop_detect action, retVal = %d\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(aCtx->ctx.msg.vlanHoppingAction))) {
                (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                retVal = BCM_ERR_UNKNOWN;
            } else {
                (void)MODULE_HostHelperLog("vlan hop_detect action : ");
                aCtx->ctx.msg.vlanHoppingAction = CPU_LEToNative32(respMsg.vlanHoppingAction);
                ETHSWT_SWTsecurityActionToStr(aCtx->ctx.msg.vlanHoppingAction);
                aCtx->modCtx.substate = BCM_STATE_SUB_STATE_DONE;
                retVal = BCM_ERR_OK;
            }
        default:
            break;
    }

    return retVal;
}

/**
    @brief switch ARL Port Limit Set Helper handler

    @trace #BRCM_SWARCH_ETHSWT_SWTHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
int32_t ETHSWT_SWTArlSetPortLimitHelperHdlr(BCM_CmdType   *aMsg,
                                            uint8_t       *aBuff,
                                            uint32_t       aInputLen,
                                            uint32_t      *aOutLen,
                                            uint32_t       aMaxLength,
                                            int32_t        aResponse,
                                            ETHSWT_SWTHelperCtxType *aCtx)
{
    int32_t retVal = BCM_ERR_UNKNOWN;
    ETHSWT_ExtMsgUnionType cmdMsg;

    BCM_MemCpy(cmdMsg.data, aBuff, aInputLen);
    switch(aCtx->modCtx.substate) {
        case BCM_STATE_SUB_STATE_STAGE0:
            cmdMsg.addrLimit.port = CPU_NativeToLE32(aCtx->ctx.msg.addrLimit.port);
            cmdMsg.addrLimit.addressLimitInfo.overLimitAction =
                              aCtx->ctx.msg.addrLimit.addressLimitInfo.overLimitAction;
            cmdMsg.addrLimit.addressLimitInfo.macLearningLimit =
                              CPU_NativeToLE16(aCtx->ctx.msg.addrLimit.addressLimitInfo.macLearningLimit);
            *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_SWT_ID, ETHSWT_EXTCMDID_PORT_ADDRESS_LIMITING_SET);
            *aOutLen = sizeof(ETHSWT_ExtPortAddressLimitType);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            retVal = BCM_ERR_OK;
            break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Failed to set port port_limit info, ret = %d\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(ETHSWT_ExtPortAddressLimitType))) {
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
    @brief switch ARL Port Limit Get Helper handler

    @trace #BRCM_SWARCH_ETHSWT_SWTHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
int32_t ETHSWT_SWTArlGetPortLimitHelperHdlr(BCM_CmdType   *aMsg,
                                            uint8_t       *aBuff,
                                            uint32_t       aInputLen,
                                            uint32_t      *aOutLen,
                                            uint32_t       aMaxLength,
                                            int32_t        aResponse,
                                            ETHSWT_SWTHelperCtxType *aCtx)
{
    int32_t retVal = BCM_ERR_UNKNOWN;
    ETHSWT_ExtMsgUnionType cmdMsg;
    ETHSWT_ExtMsgUnionType respMsg;

    BCM_MemCpy(cmdMsg.data, aBuff, aInputLen);
    BCM_MemCpy(respMsg.data, aBuff, aInputLen);
    switch(aCtx->modCtx.substate) {
        case BCM_STATE_SUB_STATE_STAGE0:
            cmdMsg.addrLimit.port = CPU_NativeToLE32(aCtx->ctx.msg.addrLimit.port);
            *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_SWT_ID, ETHSWT_EXTCMDID_PORT_ADDRESS_LIMITING_GET);
            *aOutLen = sizeof(ETHSWT_ExtPortAddressLimitType);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            retVal = BCM_ERR_OK;
            break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Failed to get port port_limit info, retVal = %d\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(ETHSWT_ExtPortAddressLimitType))) {
                (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                retVal = BCM_ERR_UNKNOWN;
            } else {
                aCtx->ctx.msg.addrLimit.addressLimitInfo.overLimitAction  = respMsg.addrLimit.addressLimitInfo.overLimitAction;
                aCtx->ctx.msg.addrLimit.addressLimitInfo.macLearningLimit = CPU_LEToNative16(respMsg.addrLimit.addressLimitInfo.macLearningLimit);
                aCtx->ctx.msg.addrLimit.portLearnedCounter = CPU_LEToNative16(respMsg.addrLimit.portLearnedCounter);
                aCtx->ctx.msg.addrLimit.portOverLimitCounter = CPU_LEToNative32(respMsg.addrLimit.portOverLimitCounter);
                (void)MODULE_HostHelperLog("port_limit action  : ");
                ETHSWT_SWTsecurityActionToStr(aCtx->ctx.msg.addrLimit.addressLimitInfo.overLimitAction);
                (void)MODULE_HostHelperLog("limit              : %hu\n", aCtx->ctx.msg.addrLimit.addressLimitInfo.macLearningLimit);
                (void)MODULE_HostHelperLog("LearnedCounter     : %hu\n", aCtx->ctx.msg.addrLimit.portLearnedCounter);
                (void)MODULE_HostHelperLog("OverLimitCounter   : %lu\n", aCtx->ctx.msg.addrLimit.portOverLimitCounter);

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
    @brief switch ARL Set Sticky Helper handler

    @trace #BRCM_SWARCH_ETHSWT_SWTHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
int32_t ETHSWT_SWTArlSetStickyHelperHdlr(BCM_CmdType   *aMsg,
                                         uint8_t       *aBuff,
                                         uint32_t       aInputLen,
                                         uint32_t      *aOutLen,
                                         uint32_t       aMaxLength,
                                         int32_t        aResponse,
                                         ETHSWT_SWTHelperCtxType *aCtx)
{
    int32_t retVal = BCM_ERR_UNKNOWN;
    ETHSWT_ExtMsgUnionType cmdMsg;

    BCM_MemCpy(cmdMsg.data, aBuff, aInputLen);
    switch(aCtx->modCtx.substate) {
        case BCM_STATE_SUB_STATE_STAGE0:
            cmdMsg.stickyMAC.port = CPU_NativeToLE32(aCtx->ctx.msg.stickyMAC.port);
            cmdMsg.stickyMAC.stickyMACAction = aCtx->ctx.msg.stickyMAC.stickyMACAction;

            *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_SWT_ID, ETHSWT_EXTCMDID_STICKY_MAC_ADDRESS_SET);
            *aOutLen = sizeof(ETHSWT_ExtStickyMACType);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            retVal = BCM_ERR_OK;
            break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Failed to set sticky action, ret = %d\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(ETHSWT_ExtStickyMACType))) {
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
    @brief switch ARL Get Sticky Helper handler

    @trace #BRCM_SWARCH_ETHSWT_SWTHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
int32_t ETHSWT_SWTArlGetStickyHelperHdlr(BCM_CmdType   *aMsg,
                                          uint8_t       *aBuff,
                                          uint32_t       aInputLen,
                                          uint32_t      *aOutLen,
                                          uint32_t       aMaxLength,
                                          int32_t        aResponse,
                                          ETHSWT_SWTHelperCtxType *aCtx)
{
    int32_t retVal = BCM_ERR_UNKNOWN;
    ETHSWT_ExtMsgUnionType cmdMsg;
    ETHSWT_ExtMsgUnionType respMsg;

    BCM_MemCpy(cmdMsg.data, aBuff, aInputLen);
    BCM_MemCpy(respMsg.data, aBuff, aInputLen);
    switch(aCtx->modCtx.substate) {
        case BCM_STATE_SUB_STATE_STAGE0:
            cmdMsg.stickyMAC.port = CPU_NativeToLE32(aCtx->ctx.msg.stickyMAC.port);

            *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_SWT_ID, ETHSWT_EXTCMDID_STICKY_MAC_ADDRESS_GET);
            *aOutLen = sizeof(ETHSWT_ExtStickyMACType);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            retVal = BCM_ERR_OK;
            break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Failed to get sticky action, retVal = %d\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(ETHSWT_ExtStickyMACType))) {
                (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                retVal = BCM_ERR_UNKNOWN;
            } else {
                aCtx->ctx.msg.stickyMAC.stickyMACAction  = respMsg.stickyMAC.stickyMACAction;
                (void)MODULE_HostHelperLog("sticky action : ");
                ETHSWT_SWTsecurityActionToStr(aCtx->ctx.msg.stickyMAC.stickyMACAction);
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
    @brief switch ARL Move Detect Set Helper handler

    @trace #BRCM_SWARCH_ETHSWT_SWTHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
int32_t ETHSWT_SWTArlSetMvDetHelperHdlr(BCM_CmdType   *aMsg,
                                        uint8_t       *aBuff,
                                        uint32_t       aInputLen,
                                        uint32_t      *aOutLen,
                                        uint32_t       aMaxLength,
                                        int32_t        aResponse,
                                        ETHSWT_SWTHelperCtxType *aCtx)
{
    int32_t retVal = BCM_ERR_UNKNOWN;
    ETHSWT_ExtMsgUnionType cmdMsg;

    BCM_MemCpy(cmdMsg.data, aBuff, aInputLen);
    switch(aCtx->modCtx.substate) {
        case BCM_STATE_SUB_STATE_STAGE0:
            cmdMsg.stationMove.port = CPU_NativeToLE32(aCtx->ctx.msg.stationMove.port);
            cmdMsg.stationMove.stationMoveAction = aCtx->ctx.msg.stationMove.stationMoveAction;
            *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_SWT_ID, ETHSWT_EXTCMDID_STATION_MOVE_DETECT_SET);
            *aOutLen = sizeof(ETHSWT_ExtStationMovementType);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            retVal = BCM_ERR_OK;
            break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Failed to set move_detect action, ret = %d\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(ETHSWT_ExtStationMovementType))) {
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
    @brief switch ARL Move Detect Get Helper handler

    @trace #BRCM_SWARCH_ETHSWT_SWTHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
int32_t ETHSWT_SWTArlGetMvDetHelperHdlr(BCM_CmdType   *aMsg,
                                        uint8_t       *aBuff,
                                        uint32_t       aInputLen,
                                        uint32_t      *aOutLen,
                                        uint32_t       aMaxLength,
                                        int32_t        aResponse,
                                        ETHSWT_SWTHelperCtxType *aCtx)
{
    int32_t retVal = BCM_ERR_UNKNOWN;
    ETHSWT_ExtMsgUnionType cmdMsg;
    ETHSWT_ExtMsgUnionType respMsg;

    BCM_MemCpy(cmdMsg.data, aBuff, aInputLen);
    BCM_MemCpy(respMsg.data, aBuff, aInputLen);
    switch(aCtx->modCtx.substate) {
        case BCM_STATE_SUB_STATE_STAGE0:
            cmdMsg.stationMove.port = CPU_NativeToLE32(aCtx->ctx.msg.stationMove.port);
            *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_SWT_ID, ETHSWT_EXTCMDID_STATION_MOVE_DETECT_GET);
            *aOutLen = sizeof(ETHSWT_ExtStationMovementType);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            retVal = BCM_ERR_OK;
            break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Failed to get move_detect action, retVal = %d\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(ETHSWT_ExtStationMovementType))) {
                (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                retVal = BCM_ERR_UNKNOWN;
            } else {
                aCtx->ctx.msg.stationMove.stationMoveAction  = respMsg.stationMove.stationMoveAction;
                ETHSWT_SWTsecurityActionToStr(aCtx->ctx.msg.stationMove.stationMoveAction);
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
    @brief switch ARL Total Limit Set Helper handler

    @trace #BRCM_SWARCH_ETHSWT_SWTHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
int32_t ETHSWT_SWTArlSetTotalLimitHelperHdlr(BCM_CmdType   *aMsg,
                                          uint8_t       *aBuff,
                                          uint32_t       aInputLen,
                                          uint32_t      *aOutLen,
                                          uint32_t       aMaxLength,
                                          int32_t        aResponse,
                                          ETHSWT_SWTHelperCtxType *aCtx)
{
    int32_t retVal = BCM_ERR_UNKNOWN;
    ETHSWT_ExtMsgUnionType cmdMsg;

    BCM_MemCpy(cmdMsg.data, aBuff, aInputLen);
    switch(aCtx->modCtx.substate) {
        case BCM_STATE_SUB_STATE_STAGE0:
            cmdMsg.totalAddressLimit.totalMACLearningLimit =
                           CPU_NativeToLE16(aCtx->ctx.msg.totalAddressLimit.totalMACLearningLimit);

            *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_SWT_ID, ETHSWT_EXTCMDID_TOTAL_ADDRESS_LIMIT_SET);
            *aOutLen = sizeof(ETHSWT_ExtTotalMACLearningLimitType);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            retVal = BCM_ERR_OK;
            break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Failed to set total_limit info, ret = %d\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(ETHSWT_ExtTotalMACLearningLimitType))) {
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
    @brief Switch ARL Total Limit Get Helper handler

    @trace #BRCM_SWARCH_ETHSWT_SWTHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
int32_t ETHSWT_SWTArlGetTotalLimitHelperHdlr(BCM_CmdType   *aMsg,
                                          uint8_t       *aBuff,
                                          uint32_t       aInputLen,
                                          uint32_t      *aOutLen,
                                          uint32_t       aMaxLength,
                                          int32_t        aResponse,
                                          ETHSWT_SWTHelperCtxType *aCtx)
{
    int32_t retVal = BCM_ERR_UNKNOWN;
    ETHSWT_ExtMsgUnionType respMsg;

    BCM_MemCpy(respMsg.data, aBuff, aInputLen);
    switch(aCtx->modCtx.substate) {
        case BCM_STATE_SUB_STATE_STAGE0:
            *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_SWT_ID, ETHSWT_EXTCMDID_TOTAL_ADDRESS_LIMIT_GET);
            *aOutLen = sizeof(ETHSWT_ExtTotalMACLearningLimitType);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            retVal = BCM_ERR_OK;
            break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Failed to get total_limit info, retVal = %d\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(ETHSWT_ExtTotalMACLearningLimitType))) {
                (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                retVal = BCM_ERR_UNKNOWN;
            } else {
                aCtx->ctx.msg.totalAddressLimit.totalMACLearningLimit = CPU_LEToNative16(respMsg.totalAddressLimit.totalMACLearningLimit);
                aCtx->ctx.msg.totalAddressLimit.totalLearnedCounter   = CPU_LEToNative16(respMsg.totalAddressLimit.totalLearnedCounter);
                (void)MODULE_HostHelperLog("totalMACLearningLimit:  %hu\n", aCtx->ctx.msg.totalAddressLimit.totalMACLearningLimit);
                (void)MODULE_HostHelperLog("totalLearnedCounter  :  %hu\n", aCtx->ctx.msg.totalAddressLimit.totalLearnedCounter);
                aCtx->modCtx.substate = BCM_STATE_SUB_STATE_DONE;
                retVal = BCM_ERR_OK;
            }
        default:
            break;
    }
    BCM_MemCpy(aBuff, respMsg.data, *aOutLen);
    return retVal;
}
/** @} */
