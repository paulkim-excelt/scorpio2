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
    @defgroup grp_ethsrv_swt_misc_host_impl Switch Host Port Helpers Design
    @ingroup grp_ethernet_abstract

    @addtogroup grp_ethsrv_swt_misc_host_impl
    @{

    @file ethswtm_misc_host.c

    @brief Switch Host Port Command Helper

    @version 0.1 Initial version
*/
#include <stdio.h>
#include <string.h>
#include <module_msg.h>
#include <bcm_comp.h>
#include <bcm_utils.h>
#include <cpu_utils.h>
#include <ethernet_swt_debug.h>
#include <ethernet_swt_ext.h>
#include <ethswt_host_common.h>

/**
    @name Ethernet switch Helper Design ID's
    @{
    @brief Ethernet switch Helper Design ID's
*/
#define BRCM_SWDSGN_ETHSWT_SWT_CONVERT_PORTINFOINT_PROC              (0xC241U)  /**< @brief #ETHSWT_SWTConvertPortInfoInt            */
#define BRCM_SWDSGN_ETHSWT_SWT_PRINT_PORTINFOINT_PROC                (0xC242U)  /**< @brief #ETHSWT_SWTPrintPortInfoInt              */
#define BRCM_SWDSGN_ETHSWT_SWT_PORTINFO_HELPERHDLR_PROC              (0xC243U)  /**< @brief #ETHSWT_SWTPortInfoHelperHdlr            */
#define BRCM_SWDSGN_ETHSWT_SWT_SETADMINMODE_HELPERHDLR_PROC          (0xC244U)  /**< @brief #ETHSWT_SWTSetAdminModeHelperHdlr        */
#define BRCM_SWDSGN_ETHSWT_SWT_GETADMINMODE_HELPERHDLR_PROC          (0xC245U)  /**< @brief #ETHSWT_SWTGetAdminModeHelperHdlr        */
#define BRCM_SWDSGN_ETHSWT_SWT_GETPORTSPEED_HELPERHDLR_PROC          (0xC246U)  /**< @brief #ETHSWT_SWTGetPortSpeedHelperHdlr        */
#define BRCM_SWDSGN_ETHSWT_SWT_SETMASTERSLAVE_HELPERHDLR_PROC        (0xC247U)  /**< @brief #ETHSWT_SWTSetMasterSlaveHelperHdlr      */
#define BRCM_SWDSGN_ETHSWT_SWT_GETMASTERSLAVE_HELPERHDLR_PROC        (0xC248U)  /**< @brief #ETHSWT_SWTGetMasterSlaveHelperHdlr      */
#define BRCM_SWDSGN_ETHSWT_SWT_SETPHYLBMODE_HELPERHDLR_PROC          (0xC249U)  /**< @brief #ETHSWT_SWTSetPhyLbModeHelperHdlr        */
#define BRCM_SWDSGN_ETHSWT_SWT_GETPHYLBMODE_HELPERHDLR_PROC          (0xC24AU)  /**< @brief #ETHSWT_SWTGetPhyLbModeHelperHdlr        */
#define BRCM_SWDSGN_ETHSWT_SWT_SETJUMBOFRAME_HELPERHDLR_PROC         (0xC24BU)  /**< @brief #ETHSWT_SWTSetJumboFrameHelperHdlr       */
#define BRCM_SWDSGN_ETHSWT_SWT_GETJUMBOFRAME_HELPERHDLR_PROC         (0xC24CU)  /**< @brief #ETHSWT_SWTGetJumboFrameHelperHdlr       */
#define BRCM_SWDSGN_ETHSWT_SWT_GETTC10WAKEUPMODE_HELPERHDLR_PROC     (0xC24DU)  /**< @brief #ETHSWT_SWTGetTC10WakeUpModeHelperHdlr   */
#define BRCM_SWDSGN_ETHSWT_SWT_GETTC10WAKEUPREASON_HELPERHDLR_PROC   (0xC24EU)  /**< @brief #ETHSWT_SWTGetTC10WakeUpReasonHelperHdlr */
#define BRCM_SWDSGN_ETHSWT_SWT_GETLINKSQI_HELPERHDLR_PROC            (0xC24FU)  /**< @brief #ETHSWT_SWTGetLinkSQIHelperHdlr          */
#define BRCM_SWDSGN_ETHSWT_SWT_GETLINKSQIPORT_HELPERHDLR_PROC        (0xC250U)  /**< @brief #ETHSWT_SWTGetLinkSQIPortHelperHdlr      */
#define BRCM_SWDSGN_ETHSWT_SWT_SETPVID_HELPERHDLR_PROC               (0xC251U)  /**< @brief #ETHSWT_SWTSetPvidHelperHdlr        */
/** @} */

/**
    @brief Convert Port Info Endianness to Native

    @trace #BRCM_SWARCH_ETHSWT_SWTHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
static void ETHSWT_SWTConvertPortInfoInt(ETHSWT_ExtPortInfoType *aPortInfo,
                                         ETHSWT_SWTHelperCtxType *aCtx)
{
    aCtx->ctx.msg.portInfo.port               = CPU_LEToNative32(aPortInfo->port);
    aCtx->ctx.msg.portInfo.adminMode          = aPortInfo->adminMode;
    aCtx->ctx.msg.portInfo.linkStatus         = aPortInfo->linkStatus;
    aCtx->ctx.msg.portInfo.speed              = aPortInfo->speed;
    aCtx->ctx.msg.portInfo.masterEnable       = aPortInfo->masterEnable;
    aCtx->ctx.msg.portInfo.jumboEnable        = aPortInfo->jumboEnable;
    aCtx->ctx.msg.portInfo.loopbackEnable     = aPortInfo->loopbackEnable;
    aCtx->ctx.msg.portInfo.autonegEnable      = aPortInfo->autonegEnable;
    aCtx->ctx.msg.portInfo.autonegComplete    = aPortInfo->autonegComplete;
    aCtx->ctx.msg.portInfo.duplex             = aPortInfo->duplex;
    aCtx->ctx.msg.portInfo.led                = CPU_LEToNative32 (aPortInfo->led);
    aCtx->ctx.msg.portInfo.linkStateChangeCnt = CPU_LEToNative32 (aPortInfo->linkStateChangeCnt);
    aCtx->ctx.msg.portInfo.busMode            = aPortInfo->busMode;
    aCtx->ctx.msg.portInfo.phyMedia           = aPortInfo->phyMedia;
    aCtx->ctx.msg.portInfo.linkSQI            = CPU_LEToNative32(aPortInfo->linkSQI);
    aCtx->ctx.msg.portInfo.pvid               = CPU_LEToNative32(aPortInfo->pvid);
    aCtx->ctx.msg.portInfo.prio               = CPU_LEToNative32(aPortInfo->prio);
}

/**
    @brief Print Port Info

    @trace #BRCM_SWARCH_ETHSWT_SWTHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
static void ETHSWT_SWTPrintPortInfoInt(ETHSWT_SWTHelperCtxType *aCtx)
{
    (void)MODULE_HostHelperLog("Port : %u\n", aCtx->ctx.msg.portInfo.port);
    (void)MODULE_HostHelperLog("AdminMode : ");
    switch (aCtx->ctx.msg.portInfo.adminMode) {
    case ETHXCVR_MODE_ACTIVE:
        (void)MODULE_HostHelperLog("Active\n");
        break;
    case ETHXCVR_MODE_DOWN:
        (void)MODULE_HostHelperLog("Down\n");
        break;
    case ETHXCVR_MODE_ISOLATE:
        (void)MODULE_HostHelperLog("Isolate\n");
        break;
    default:
        break;
    }
    (void)MODULE_HostHelperLog("LinkStatus : %s\n", (aCtx->ctx.msg.portInfo.linkStatus ==
                ETHXCVR_LINKSTATE_ACTIVE) ? "Up" : "Down");
    switch (aCtx->ctx.msg.portInfo.speed) {
    case ETHXCVR_SPEED_10MBPS:
        (void)MODULE_HostHelperLog("Speed : 10Mbps\n");
        break;
    case ETHXCVR_SPEED_100MBPS:
        (void)MODULE_HostHelperLog("Speed : 100Mbps\n");
        break;
    case ETHXCVR_SPEED_1000MBPS:
        (void)MODULE_HostHelperLog("Speed : 1000Mbps\n");
        break;
    case ETHXCVR_SPEED_2500MBPS:
        (void)MODULE_HostHelperLog("Speed: 2500Mbps\n");
        break;
    case ETHXCVR_SPEED_5000MBPS:
        (void)MODULE_HostHelperLog("Speed: 5000Mbps\n");
        break;
    default:
        (void)MODULE_HostHelperLog("Speed : Invalid\n");
        break;
    }
    if ((aCtx->ctx.msg.portInfo.phyMedia == ETHXCVR_PHYMEDIA_10BASET1) ||
        (aCtx->ctx.msg.portInfo.phyMedia == ETHXCVR_PHYMEDIA_100BASET1) ||
        (aCtx->ctx.msg.portInfo.phyMedia == ETHXCVR_PHYMEDIA_1000BASET1)) {
        (void)MODULE_HostHelperLog("BrMode : %s\n",
                (aCtx->ctx.msg.portInfo.masterEnable == ETHXCVR_BOOLEAN_TRUE) ?
                "Master" : "Slave");
    }
    (void)MODULE_HostHelperLog("JumboFrameMode : %s\n", (aCtx->ctx.msg.portInfo.jumboEnable ==
                ETHXCVR_BOOLEAN_TRUE) ? "Enabled" : "Disabled");
    (void)MODULE_HostHelperLog("LoopBackMode : %s\n", (aCtx->ctx.msg.portInfo.loopbackEnable ==
                ETHXCVR_BOOLEAN_TRUE) ? "Enabled" : "Disabled");
    (void)MODULE_HostHelperLog("Autoneg : %s\n", (aCtx->ctx.msg.portInfo.autonegEnable ==
                ETHXCVR_BOOLEAN_TRUE) ? "Enabled" : "Disabled");
    switch (aCtx->ctx.msg.portInfo.autonegComplete) {
    case ETHXCVR_AUTONEGSTATUS_NO_ABILITY:
        (void)MODULE_HostHelperLog("AutonegComplete : No ability\n");
        break;
    case ETHXCVR_AUTONEGSTATUS_INCOMPLETE:
        (void)MODULE_HostHelperLog("AutonegComplete : Incomplete\n");
        break;
    case ETHXCVR_AUTONEGSTATUS_COMPLETE:
        (void)MODULE_HostHelperLog("AutonegComplete : Complete\n");
        break;
    default:
        (void)MODULE_HostHelperLog("AutonegComplete : Invalid\n");
        break;
    }
    (void)MODULE_HostHelperLog("Duplex : %s\n", (aCtx->ctx.msg.portInfo.duplex ==
                ETHXCVR_DUPLEXMODE_FULL) ? "Full" : "Half" );
    (void)MODULE_HostHelperLog("LED : %s\n", aCtx->ctx.msg.portInfo.led ? "On" : "Off");
    (void)MODULE_HostHelperLog("LinkStateChangeCnt : %u\n", aCtx->ctx.msg.portInfo.linkStateChangeCnt);
    switch (aCtx->ctx.msg.portInfo.busMode) {
    case ETHXCVR_BUSMODE_INTG:
        (void)MODULE_HostHelperLog("Bus Mode : Integrated\n");
        break;
    case ETHXCVR_BUSMODE_RGMII:
        (void)MODULE_HostHelperLog("Bus Mode : RGMII\n");
        break;
    case ETHXCVR_BUSMODE_RVMII:
        (void)MODULE_HostHelperLog("Bus Mode : RVMII\n");
        break;
    case ETHXCVR_BUSMODE_RMII:
        (void)MODULE_HostHelperLog("Bus Mode : RMII\n");
        break;
    case ETHXCVR_BUSMODE_MII:
        (void)MODULE_HostHelperLog("Bus Mode : MII\n");
        break;
    case ETHXCVR_BUSMODE_SGMII:
        (void)MODULE_HostHelperLog("Bus Mode : SGMII\n");
        break;
    case ETHXCVR_BUSMODE_PCIE:
        (void)MODULE_HostHelperLog("Bus Mode : PCIE\n");
        break;
    default:
        (void)MODULE_HostHelperLog("Bus Mode: Unknown\n");
        break;
    }
    switch (aCtx->ctx.msg.portInfo.phyMedia) {
    case ETHXCVR_PHYMEDIA_10BASET1:
        (void)MODULE_HostHelperLog("Phy Media : 10Base-T1\n");
        break;
    case ETHXCVR_PHYMEDIA_10BASET:
        (void)MODULE_HostHelperLog("Phy Media : 10Base-T\n");
        break;
    case ETHXCVR_PHYMEDIA_100BASET1:
        (void)MODULE_HostHelperLog("Phy Media : 100Base-T1\n");
        break;
    case ETHXCVR_PHYMEDIA_100BASETX:
        (void)MODULE_HostHelperLog("Phy Media : 100Base-Tx\n");
        break;
    case ETHXCVR_PHYMEDIA_1000BASET1:
        (void)MODULE_HostHelperLog("Phy Media : 1000Base-T1\n");
        break;
    case ETHXCVR_PHYMEDIA_1000BASET:
        (void)MODULE_HostHelperLog("Phy Media : 1000Base-T\n");
        break;
    case ETHXCVR_PHYMEDIA_1000BASEX:
        (void)MODULE_HostHelperLog("Phy Media : 1000Base-X\n");
        break;
    default:
        break;
    }
    (void)MODULE_HostHelperLog("LinkSQI : %u\n", aCtx->ctx.msg.portInfo.linkSQI);
    (void)MODULE_HostHelperLog("PVID : %u\n", aCtx->ctx.msg.portInfo.pvid);
    (void)MODULE_HostHelperLog("Prio : %u\n", aCtx->ctx.msg.portInfo.prio);
}

/**
    @brief Switch Get Port Info handler

    @trace #BRCM_SWARCH_ETHSWT_SWTHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
int32_t ETHSWT_SWTPortInfoHelperHdlr(BCM_CmdType   *aMsg,
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
            /* Get Port Info */
            cmdMsg.portInfo.port = CPU_NativeToLE32(aCtx->ctx.msg.portInfo.port);
            *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_SWT_ID, ETHSWT_EXTCMDID_PORT_INFO_GET);
            *aOutLen = sizeof(ETHSWT_ExtPortInfoType);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            retVal = BCM_ERR_OK;
            break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Failed to get port info, retVal = %d\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(ETHSWT_ExtPortInfoType))) {
                (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                retVal = BCM_ERR_UNKNOWN;
            } else {
                ETHSWT_SWTConvertPortInfoInt(&cmdMsg.portInfo, aCtx);
                ETHSWT_SWTPrintPortInfoInt(aCtx);
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
    @brief Switch Set Admin mode handler

    @trace #BRCM_SWARCH_ETHSWT_SWTHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
int32_t ETHSWT_SWTSetAdminModeHelperHdlr(BCM_CmdType   *aMsg,
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
            /* Get Port Info */
            cmdMsg.portInfo.port = CPU_NativeToLE32(aCtx->ctx.msg.portInfo.port);
            *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_SWT_ID, ETHSWT_EXTCMDID_PORT_INFO_GET);
            *aOutLen = sizeof(ETHSWT_ExtPortInfoType);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            retVal = BCM_ERR_OK;
            break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Failed to set admin mode, ret = %d\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(ETHSWT_ExtPortInfoType))) {
                (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                retVal = BCM_ERR_UNKNOWN;
            } else {
                cmdMsg.portInfo.port = CPU_NativeToLE32(aCtx->ctx.msg.portInfo.port);
                cmdMsg.portInfo.adminMode = aCtx->ctx.msg.portInfo.adminMode;
                *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_SWT_ID, ETHSWT_EXTCMDID_PORT_INFO_SET);
                *aOutLen = sizeof(ETHSWT_ExtPortInfoType);
                aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE2;
                retVal = BCM_ERR_OK;
            }
            break;
        case BCM_STATE_SUB_STATE_STAGE2:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Failed to set admin mode, ret = %d\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(ETHSWT_ExtPortInfoType))) {
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
    @brief Switch Get Admin mode handler

    @trace #BRCM_SWARCH_ETHSWT_SWTHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
int32_t ETHSWT_SWTGetAdminModeHelperHdlr(BCM_CmdType   *aMsg,
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
            /* Get Port Info */
            cmdMsg.portInfo.port = CPU_NativeToLE32(aCtx->ctx.msg.portInfo.port);
            *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_SWT_ID, ETHSWT_EXTCMDID_PORT_INFO_GET);
            *aOutLen = sizeof(ETHSWT_ExtPortInfoType);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            retVal = BCM_ERR_OK;
            break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Failed to get admin mode, retVal = %d\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(ETHSWT_ExtPortInfoType))) {
                (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                retVal = BCM_ERR_UNKNOWN;
            } else {
                aCtx->ctx.msg.portInfo.adminMode = cmdMsg.portInfo.adminMode;;
                (void)MODULE_HostHelperLog("Admin mode: %s\n", (aCtx->ctx.msg.portInfo.adminMode == ETHXCVR_MODE_ACTIVE) ? "Enabled" : "Disabled");
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
    @brief Switch Get Port Speed handler

    @trace #BRCM_SWARCH_ETHSWT_SWTHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
int32_t ETHSWT_SWTGetPortSpeedHelperHdlr(BCM_CmdType   *aMsg,
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
            /* Get Port Info */
            cmdMsg.portInfo.port = CPU_NativeToLE32(aCtx->ctx.msg.portInfo.port);
            *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_SWT_ID, ETHSWT_EXTCMDID_PORT_INFO_GET);
            *aOutLen = sizeof(ETHSWT_ExtPortInfoType);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            retVal = BCM_ERR_OK;
            break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Failed to get speed, retVal = %d\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(ETHSWT_ExtPortInfoType))) {
                (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                retVal = BCM_ERR_UNKNOWN;
            } else {
                aCtx->ctx.msg.portInfo.speed = cmdMsg.portInfo.speed;
                aCtx->modCtx.substate = BCM_STATE_SUB_STATE_DONE;
                retVal = BCM_ERR_OK;
                switch (aCtx->ctx.msg.portInfo.speed) {
                case ETHXCVR_SPEED_10MBPS:
                    (void)MODULE_HostHelperLog("Speed: 10mbps\n");
                    break;
                case ETHXCVR_SPEED_100MBPS:
                    (void)MODULE_HostHelperLog("Speed: 100mbps\n");
                    break;
                case ETHXCVR_SPEED_1000MBPS:
                    (void)MODULE_HostHelperLog("Speed: 1000mbps\n");
                    break;
                case ETHXCVR_SPEED_2500MBPS:
                    (void)MODULE_HostHelperLog("Speed: 2500mbps\n");
                    break;
                case ETHXCVR_SPEED_5000MBPS:
                    (void)MODULE_HostHelperLog("Speed: 5000mbps\n");
                    break;
                default:
                    (void)MODULE_HostHelperLog("Speed: Invalid\n");
                    retVal = BCM_ERR_UNKNOWN;
                    break;
                }
            }
        default:
            break;
    }

    return retVal;
}

/**
    @brief Switch Set Master Or Slave Mode handler

    @trace #BRCM_SWARCH_ETHSWT_SWTHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
int32_t ETHSWT_SWTSetMasterSlaveHelperHdlr(BCM_CmdType   *aMsg,
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
            /* Get Port Info */
            cmdMsg.portInfo.port = CPU_NativeToLE32(aCtx->ctx.msg.portInfo.port);
            *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_SWT_ID, ETHSWT_EXTCMDID_PORT_INFO_GET);
            *aOutLen = sizeof(ETHSWT_ExtPortInfoType);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            retVal = BCM_ERR_OK;
            break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Failed to set BR mode, ret = %d\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(ETHSWT_ExtPortInfoType))) {
                (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                retVal = BCM_ERR_UNKNOWN;
            } else {
                cmdMsg.portInfo.port = CPU_NativeToLE32(aCtx->ctx.msg.portInfo.port);
                cmdMsg.portInfo.masterEnable = aCtx->ctx.msg.portInfo.masterEnable;
                *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_SWT_ID, ETHSWT_EXTCMDID_PORT_INFO_SET);
                *aOutLen = sizeof(ETHSWT_ExtPortInfoType);
                aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE2;
                retVal = BCM_ERR_OK;
            }
            break;
        case BCM_STATE_SUB_STATE_STAGE2:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Failed to set BR mode, ret = %d\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(ETHSWT_ExtPortInfoType))) {
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
    @brief Switch Get Master Or Slave Mode handler

    @trace #BRCM_SWARCH_ETHSWT_SWTHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
int32_t ETHSWT_SWTGetMasterSlaveHelperHdlr(BCM_CmdType   *aMsg,
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
            /* Get Port Info */
            cmdMsg.portInfo.port = CPU_NativeToLE32(aCtx->ctx.msg.portInfo.port);
            *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_SWT_ID, ETHSWT_EXTCMDID_PORT_INFO_GET);
            *aOutLen = sizeof(ETHSWT_ExtPortInfoType);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            retVal = BCM_ERR_OK;
            break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Failed to get master/slave mode, retVal = %d\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(ETHSWT_ExtPortInfoType))) {
                (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                retVal = BCM_ERR_UNKNOWN;
            } else {
                aCtx->ctx.msg.portInfo.masterEnable = cmdMsg.portInfo.masterEnable;
                aCtx->modCtx.substate = BCM_STATE_SUB_STATE_DONE;
                retVal = BCM_ERR_OK;
                switch (aCtx->ctx.msg.portInfo.masterEnable) {
                case ETHXCVR_BOOLEAN_TRUE:
                    (void)MODULE_HostHelperLog("Master/Slave: Master\n");
                    break;
                case ETHXCVR_BOOLEAN_FALSE:
                    (void)MODULE_HostHelperLog("Master/Slave: Slave\n");
                    break;
                default:
                    (void)MODULE_HostHelperLog("Master/Slave: Invalid\n");
                    retVal = BCM_ERR_UNKNOWN;
                    break;
                }
            }
        default:
            break;
    }
    BCM_MemCpy(aBuff, cmdMsg.data, *aOutLen);
    return retVal;
}

/**
    @brief Switch Set Phy LoopBack Mode handler

    @trace #BRCM_SWARCH_ETHSWT_SWTHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
int32_t ETHSWT_SWTSetPhyLbModeHelperHdlr(BCM_CmdType   *aMsg,
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
            /* Get Port Info */
            cmdMsg.portInfo.port = CPU_NativeToLE32(aCtx->ctx.msg.portInfo.port);
            *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_SWT_ID, ETHSWT_EXTCMDID_PORT_INFO_GET);
            *aOutLen = sizeof(ETHSWT_ExtPortInfoType);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            retVal = BCM_ERR_OK;
            break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Failed to set phy loop back mode, ret = %d\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(ETHSWT_ExtPortInfoType))) {
                (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                retVal = BCM_ERR_UNKNOWN;
            } else {
                cmdMsg.portInfo.port = CPU_NativeToLE32(aCtx->ctx.msg.portInfo.port);
                cmdMsg.portInfo.loopbackEnable = aCtx->ctx.msg.portInfo.loopbackEnable;
                *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_SWT_ID, ETHSWT_EXTCMDID_PORT_INFO_SET);
                *aOutLen = sizeof(ETHSWT_ExtPortInfoType);
                aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE2;
                retVal = BCM_ERR_OK;
            }
            break;
        case BCM_STATE_SUB_STATE_STAGE2:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Failed to set phy loop back mode, ret = %d\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(ETHSWT_ExtPortInfoType))) {
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
    @brief Switch Get Phy LoopBack Mode handler

    @trace #BRCM_SWARCH_ETHSWT_SWTHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
int32_t ETHSWT_SWTGetPhyLbModeHelperHdlr(BCM_CmdType   *aMsg,
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
            /* Get Port Info */
            cmdMsg.portInfo.port = CPU_NativeToLE32(aCtx->ctx.msg.portInfo.port);
            *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_SWT_ID, ETHSWT_EXTCMDID_PORT_INFO_GET);
            *aOutLen = sizeof(ETHSWT_ExtPortInfoType);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            retVal = BCM_ERR_OK;
            break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Failed to get phy_lb mode, retVal = %d\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(ETHSWT_ExtPortInfoType))) {
                (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                retVal = BCM_ERR_UNKNOWN;
            } else {
                aCtx->ctx.msg.portInfo.loopbackEnable = cmdMsg.portInfo.loopbackEnable;
                (void)MODULE_HostHelperLog("Phy_lb mode: %s\n", (aCtx->ctx.msg.portInfo.loopbackEnable == ETHXCVR_BOOLEAN_TRUE) ? "Enabled" : "Disabled");
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
    @brief Switch Set Jumbo Frame handler

    @trace #BRCM_SWARCH_ETHSWT_SWTHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
int32_t ETHSWT_SWTSetJumboFrameHelperHdlr(BCM_CmdType   *aMsg,
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
            /* Get Port Info */
            cmdMsg.portInfo.port = CPU_NativeToLE32(aCtx->ctx.msg.portInfo.port);
            *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_SWT_ID, ETHSWT_EXTCMDID_PORT_INFO_GET);
            *aOutLen = sizeof(ETHSWT_ExtPortInfoType);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            retVal = BCM_ERR_OK;
            break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Failed to set jumbo frame mode, ret = %d\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(ETHSWT_ExtPortInfoType))) {
                (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                retVal = BCM_ERR_UNKNOWN;
            } else {
                cmdMsg.portInfo.port = CPU_NativeToLE32(aCtx->ctx.msg.portInfo.port);
                cmdMsg.portInfo.jumboEnable = aCtx->ctx.msg.portInfo.jumboEnable;
                *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_SWT_ID, ETHSWT_EXTCMDID_PORT_INFO_SET);
                *aOutLen = sizeof(ETHSWT_ExtPortInfoType);
                aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE2;
                retVal = BCM_ERR_OK;
            }
            break;
        case BCM_STATE_SUB_STATE_STAGE2:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Failed to set jumbo frame mode, ret = %d\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(ETHSWT_ExtPortInfoType))) {
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
    @brief Switch Get Jumbo Frame handler

    @trace #BRCM_SWARCH_ETHSWT_SWTHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
int32_t ETHSWT_SWTGetJumboFrameHelperHdlr(BCM_CmdType   *aMsg,
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
            /* Get Port Info */
            cmdMsg.portInfo.port = CPU_NativeToLE32(aCtx->ctx.msg.portInfo.port);
            *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_SWT_ID, ETHSWT_EXTCMDID_PORT_INFO_GET);
            *aOutLen = sizeof(ETHSWT_ExtPortInfoType);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            retVal = BCM_ERR_OK;
            break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Failed to get jumbo frame mode, retVal = %d\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(ETHSWT_ExtPortInfoType))) {
                (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                retVal = BCM_ERR_UNKNOWN;
            } else {
                aCtx->ctx.msg.portInfo.jumboEnable = cmdMsg.portInfo.jumboEnable;
                (void)MODULE_HostHelperLog("Jumbo frame mode: %s\n", (aCtx->ctx.msg.portInfo.jumboEnable == ETHXCVR_BOOLEAN_TRUE) ? "Enabled" : "Disabled");
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
    @brief Switch Get TC10 WakeUp Mode handler

    @trace #BRCM_SWARCH_ETHSWT_SWTHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
int32_t ETHSWT_SWTGetTC10WakeUpModeHelperHdlr(BCM_CmdType   *aMsg,
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
            cmdMsg.tc10Wake.port = CPU_NativeToLE32(aCtx->ctx.msg.tc10Wake.port);
            *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_SWT_ID, ETHSWT_EXTCMDID_GETWAKEUPMODE);
            *aOutLen = sizeof(ETHSWT_ExtTc10WakeUpType);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            retVal = BCM_ERR_OK;
            break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Failed to Get wakeup Mode, retVal = %d\n",aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(ETHSWT_ExtTc10WakeUpType))) {
                (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                retVal = BCM_ERR_UNKNOWN;
            } else {
                aCtx->ctx.msg.tc10Wake.mode = CPU_LEToNative32(cmdMsg.tc10Wake.reason);
                if(ETHXCVR_BOOLEAN_TRUE == aCtx->ctx.msg.tc10Wake.mode) {
                    (void)MODULE_HostHelperLog("WakeUp Mode Enabled\n");
                } else {
                    (void)MODULE_HostHelperLog("WakeUp Mode Disabled\n");
                }
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
    @brief Switch Get TC10 WakeUp Reason handler

    @trace #BRCM_SWARCH_ETHSWT_SWTHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
int32_t ETHSWT_SWTGetTC10WakeUpReasonHelperHdlr(BCM_CmdType   *aMsg,
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
            cmdMsg.tc10Wake.port = CPU_NativeToLE32(aCtx->ctx.msg.tc10Wake.port);
            *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_SWT_ID, ETHSWT_EXTCMDID_GETWAKEUPREASON);
            *aOutLen = sizeof(ETHSWT_ExtTc10WakeUpType);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            retVal = BCM_ERR_OK;
            break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Failed to Get wakeup reason, retVal = %d\n",aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(ETHSWT_ExtTc10WakeUpType))) {
                (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                retVal = BCM_ERR_UNKNOWN;
            } else {
                aCtx->ctx.msg.tc10Wake.reason = CPU_LEToNative32(cmdMsg.tc10Wake.reason);
                switch (aCtx->ctx.msg.tc10Wake.reason) {
                    case ETHXCVR_WAKEUPREASON_NONE:
                        (void)MODULE_HostHelperLog("No WakeUp Detected\n");
                        break;
                    case ETHXCVR_WAKEUPREASON_UNKNOWN:
                        (void)MODULE_HostHelperLog("No WakeUp Reason Detected\n");
                        break;
                    case ETHXCVR_WAKEUPREASON_REMOTE:
                        (void)MODULE_HostHelperLog(" WakeUp On Remote Request\n");
                        break;
                    case ETHXCVR_WAKEUPREASON_LOCAL:
                        (void)MODULE_HostHelperLog("WakeUp On Local Request\n");
                        break;
                    case ETHXCVR_WAKEUPREASON_POWER_ON:
                        (void)MODULE_HostHelperLog("PowerOn WakeUp Detected\n");
                        break;
                    case ETHXCVR_WAKEUPREASON_PIN:
                        (void)MODULE_HostHelperLog("WakeUp On PIN \n");
                        break;
                    default:
                        break;
                }
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
    @brief Switch Get Link SQI handler

    @trace #BRCM_SWARCH_ETHSWT_SWTHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
int32_t ETHSWT_SWTGetLinkSQIHelperHdlr(BCM_CmdType   *aMsg,
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
            aCtx->portIdx = 0UL;
            /* Get Port Info */
            cmdMsg.portInfo.port = CPU_NativeToLE32(aCtx->portIdx);
            (void)MODULE_HostHelperLog("--------------------\n");
            (void)MODULE_HostHelperLog("%7s %10s\n", "Port", "SQI");
            (void)MODULE_HostHelperLog("--------------------\n");
            *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_SWT_ID, ETHSWT_EXTCMDID_PORT_INFO_GET);
            *aOutLen = sizeof(ETHSWT_ExtPortInfoType);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            retVal = BCM_ERR_OK;
            break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Failed to get Signal Quality Indicator(SQI) value, retVal = %d\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(ETHSWT_ExtPortInfoType))) {
                (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                retVal = BCM_ERR_UNKNOWN;
            } else {
                if (cmdMsg.portInfo.linkStatus == ETHXCVR_LINKSTATE_DOWN) {
                    (void)MODULE_HostHelperLog("%7d %10d\n", aCtx->portIdx, CPU_LEToNative32(cmdMsg.portInfo.linkSQI));
                }
                aCtx->portIdx++;
                if(HOST_MAX_NUM_PORTS == aCtx->portIdx) {
                    aCtx->modCtx.substate = BCM_STATE_SUB_STATE_DONE;
                    retVal = BCM_ERR_OK;
                } else {
                    cmdMsg.portInfo.port = CPU_NativeToLE32(aCtx->portIdx);
                    *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_SWT_ID, ETHSWT_EXTCMDID_PORT_INFO_GET);
                    *aOutLen = sizeof(ETHSWT_ExtPortInfoType);
                    aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
                    retVal = BCM_ERR_OK;
                }
            }
            break;
        default:
            break;
    }
    BCM_MemCpy(aBuff, cmdMsg.data, *aOutLen);
    return retVal;
}

/**
    @brief Switch Get Link SQI for Port handler

    @trace #BRCM_SWARCH_ETHSWT_SWTHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
int32_t ETHSWT_SWTGetLinkSQIPortHelperHdlr(BCM_CmdType   *aMsg,
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
            /* Get Port Info */
            cmdMsg.portInfo.port = CPU_NativeToLE32(aCtx->ctx.msg.portInfo.port);
            *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_SWT_ID, ETHSWT_EXTCMDID_PORT_INFO_GET);
            *aOutLen = sizeof(ETHSWT_ExtPortInfoType);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            retVal = BCM_ERR_OK;
            break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Failed to get Signal Quality Indicator(SQI) value, retVal = %d\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(ETHSWT_ExtPortInfoType))) {
                (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                retVal = BCM_ERR_UNKNOWN;
            } else {
                aCtx->ctx.msg.portInfo.linkSQI = CPU_LEToNative32(cmdMsg.portInfo.linkSQI);
                (void)MODULE_HostHelperLog("Signal Quality Indicator(SQI) value of port %d is %d\n",
                                                               aCtx->ctx.msg.portInfo.port, aCtx->ctx.msg.portInfo.linkSQI);
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
    @briefSwitch Controller Set PVID handler

    @trace #BRCM_SWARCH_ETHSWT_SWTHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
int32_t ETHSWT_SWTSetPvidHelperHdlr(BCM_CmdType   *aMsg,
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
            /* Get Port Info */
            cmdMsg.portInfo.port = CPU_NativeToLE32(aCtx->ctx.msg.portInfo.port);
            *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_SWT_ID, ETHSWT_EXTCMDID_PORT_INFO_GET);
            *aOutLen = sizeof(ETHSWT_ExtPortInfoType);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            retVal = BCM_ERR_OK;
            break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Failed to set the PVID, retVal = %d\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(ETHSWT_ExtPortInfoType))) {
                (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                retVal = BCM_ERR_UNKNOWN;
            } else {
                cmdMsg.portInfo.port = CPU_NativeToLE32(aCtx->ctx.msg.portInfo.port);
                cmdMsg.portInfo.pvid = CPU_NativeToLE32(aCtx->ctx.msg.portInfo.pvid);
                cmdMsg.portInfo.prio = CPU_NativeToLE32(aCtx->ctx.msg.portInfo.prio);
                *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_SWT_ID, ETHSWT_EXTCMDID_PORT_INFO_SET);
                *aOutLen = sizeof(ETHSWT_ExtPortInfoType);
                aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE2;
                retVal = BCM_ERR_OK;
            }
            break;
        case BCM_STATE_SUB_STATE_STAGE2:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Failed to set the PVID, retVal = %d\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(ETHSWT_ExtPortInfoType))) {
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
/** @} */

