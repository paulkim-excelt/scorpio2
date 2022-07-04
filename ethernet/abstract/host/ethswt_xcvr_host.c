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
    @defgroup grp_ethsrv_swt_xcvr_host_impl Switch XCVR Helpers Design
    @ingroup grp_ethernet_abstract

    @addtogroup grp_ethsrv_swt_xcvr_host_impl
    @{

    @file ethswtm_xcvr_host.c

    @brief Switch Host XCVR Command Helper

    @version 0.1 Initial version
*/
#include <stdio.h>
#include <string.h>
#include <module_msg.h>
#include <bcm_comp.h>
#include <bcm_utils.h>
#include <cpu_utils.h>
#include <ethernet_swt_debug.h>
#include <ethswt_host_common.h>

/**
    @name Ethernet switch XCVR Helper Design ID's
    @{
    @brief Ethernet switch XCVR Helper Design ID's
*/
#define BRCM_SWDSGN_ETHSWT_SWT_DBG_CONVERTMIBSINT_PROC               (0xC281U)  /**< @brief #ETHSWT_SWTDbgConvertMibsInt          */
#define BRCM_SWDSGN_ETHSWT_SWT_DBG_PRINTMIBS_STATS_PROC              (0xC282U)  /**< @brief #ETHSWT_SWTDbgPrintMibsStats          */
#define BRCM_SWDSGN_ETHSWT_SWT_DBG_CLEARPORTMIBS_HELPERHDLR_PROC     (0xC283U)  /**< @brief #ETHSWT_SWTDbgClearPortMibsHelperHdlr */
#define BRCM_SWDSGN_ETHSWT_SWT_DBG_GETPORTMIBS_HELPERHDLR_PROC       (0xC284U)  /**< @brief #ETHSWT_SWTDbgGetPortMibsHelperHdlr   */
#define BRCM_SWDSGN_ETHSWT_SWT_CTRLR_SETAGETIME_HELPERHDLR_PROC      (0xC285U)  /**< @brief #ETHSWT_SWTCtrlrSetAgeTimeHelperHdlr  */
#define BRCM_SWDSGN_ETHSWT_SWT_CTRLR_GETAGETIME_HELPERHDLR_PROC      (0xC286U)  /**< @brief #ETHSWT_SWTCtrlrGetAgeTimeHelperHdlr  */
#define BRCM_SWDSGN_ETHSWT_SWT_CTRLR_SETDUMPFWD_HELPERHDLR_PROC      (0xC287U)  /**< @brief #ETHSWT_SWTCtrlrSetDumpFwdHelperHdlr  */
#define BRCM_SWDSGN_ETHSWT_SWT_CTRLR_GETDUMBFWD_HELPERHDLR_PROC      (0xC288U)  /**< @brief #ETHSWT_SWTCtrlrGetDumbFwdHelperHdlr  */
#define BRCM_SWDSGN_ETHSWT_SWT_CTRLR_SETBRCMHDR_HELPERHDLR_PROC      (0xC289U)  /**< @brief #ETHSWT_SWTCtrlrSetBRCMHdrHelperHdlr  */
#define BRCM_SWDSGN_ETHSWT_SWT_CTRLR_GETBRCMHDR_HELPERHDLR_PROC      (0xC28AU)  /**< @brief #ETHSWT_SWTCtrlrGetBRCMHdrHelperHdlr  */
#define BRCM_SWDSGN_ETHSWT_SWT_CTRLR_SETMGMT_HELPERHDLR_PROC         (0xC28BU)  /**< @brief #ETHSWT_SWTCtrlrSetMgmtHelperHdlr     */
#define BRCM_SWDSGN_ETHSWT_SWT_CTRLR_GETMGMT_HELPERHDLR_PROC         (0xC28CU)  /**< @brief #ETHSWT_SWTCtrlrGetMgmtHelperHdlr     */
#define BRCM_SWDSGN_ETHSWT_SWT_CTRLR_SETIFILTER_HELPERHDLR_PROC      (0xC28DU)  /**< @brief #ETHSWT_SWTCtrlrSetIfilterHelperHdlr  */
#define BRCM_SWDSGN_ETHSWT_SWT_CTRLR_GETIFILTER_HELPERHDLR_PROC      (0xC28EU)  /**< @brief #ETHSWT_SWTCtrlrGetIFilterHelperHdlr  */
#define BRCM_SWDSGN_ETHSWT_SWT_CTRLR_READ_HELPERHDLR_PROC            (0xC28FU)  /**< @brief #ETHSWT_SWTCtrlrReadHelperHdlr        */
#define BRCM_SWDSGN_ETHSWT_SWT_CTRLR_WRITE_HELPERHDLR_PROC           (0xC290U)  /**< @brief #ETHSWT_SWTCtrlrWriteHelperHdlr       */
/** @} */

/**
    @brief Convert Port Mibs Endianness to Native

    @trace #BRCM_SWARCH_ETHSWT_SWTHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
static void ETHSWT_SWTDbgConvertMibsInt(ETHSWT_DebugMibType *aMibs,
                                        ETHSWT_SWTDbgHelperCtxType *aCtx)
{
    aCtx->ctx.msg.mib.port = CPU_LEToNative32(aMibs->port);
    aCtx->ctx.msg.mib.rxStats.gdPkts = CPU_LEToNative32(aMibs->rxStats.gdPkts);
    aCtx->ctx.msg.mib.rxStats.octetsLow = CPU_LEToNative32(aMibs->rxStats.octetsLow);
    aCtx->ctx.msg.mib.rxStats.octetsHigh = CPU_LEToNative32(aMibs->rxStats.octetsHigh);
    aCtx->ctx.msg.mib.rxStats.allPkts = CPU_LEToNative32(aMibs->rxStats.allPkts);
    aCtx->ctx.msg.mib.rxStats.brdCast = CPU_LEToNative32(aMibs->rxStats.brdCast);
    aCtx->ctx.msg.mib.rxStats.mutCast = CPU_LEToNative32(aMibs->rxStats.mutCast);
    aCtx->ctx.msg.mib.rxStats.uniCast = CPU_LEToNative32(aMibs->rxStats.uniCast);
    aCtx->ctx.msg.mib.rxStats.pkts64 = CPU_LEToNative32(aMibs->rxStats.pkts64);
    aCtx->ctx.msg.mib.rxStats.pkts65_127 = CPU_LEToNative32(aMibs->rxStats.pkts65_127);
    aCtx->ctx.msg.mib.rxStats.pkts128_255 = CPU_LEToNative32(aMibs->rxStats.pkts128_255);
    aCtx->ctx.msg.mib.rxStats.pkts256_511 = CPU_LEToNative32(aMibs->rxStats.pkts256_511);
    aCtx->ctx.msg.mib.rxStats.pkts512_1023 = CPU_LEToNative32(aMibs->rxStats.pkts512_1023);
    aCtx->ctx.msg.mib.rxStats.pkts1024_MAX = CPU_LEToNative32(aMibs->rxStats.pkts1024_MAX);
    aCtx->ctx.msg.mib.rxStats.pkts1024_1522 = CPU_LEToNative32(aMibs->rxStats.pkts1024_1522);
    aCtx->ctx.msg.mib.rxStats.pkts1523_2047 = CPU_LEToNative32(aMibs->rxStats.pkts1523_2047);
    aCtx->ctx.msg.mib.rxStats.pkts2048_4095 = CPU_LEToNative32(aMibs->rxStats.pkts2048_4095);
    aCtx->ctx.msg.mib.rxStats.pkts4096_8191 = CPU_LEToNative32(aMibs->rxStats.pkts4096_8191);
    aCtx->ctx.msg.mib.rxStats.pkts8192_MAX = CPU_LEToNative32(aMibs->rxStats.pkts8192_MAX);
    aCtx->ctx.msg.mib.rxStats.pktsJabber = CPU_LEToNative32(aMibs->rxStats.pktsJabber);
    aCtx->ctx.msg.mib.rxStats.pktsOvrSz = CPU_LEToNative32(aMibs->rxStats.pktsOvrSz);
    aCtx->ctx.msg.mib.rxStats.pktsFrag = CPU_LEToNative32(aMibs->rxStats.pktsFrag);
    aCtx->ctx.msg.mib.rxStats.pktsRxDrop = CPU_LEToNative32(aMibs->rxStats.pktsRxDrop);
    aCtx->ctx.msg.mib.rxStats.pktsCrcAlignErr = CPU_LEToNative32(aMibs->rxStats.pktsCrcAlignErr);
    aCtx->ctx.msg.mib.rxStats.pktsUndSz = CPU_LEToNative32(aMibs->rxStats.pktsUndSz);
    aCtx->ctx.msg.mib.rxStats.pktsCrcErr = CPU_LEToNative32(aMibs->rxStats.pktsCrcErr);
    aCtx->ctx.msg.mib.rxStats.pktsRxDiscard = CPU_LEToNative32(aMibs->rxStats.pktsRxDiscard);
    aCtx->ctx.msg.mib.rxStats.rxPause = CPU_LEToNative32(aMibs->rxStats.rxPause);

    aCtx->ctx.msg.mib.txStats.octets = CPU_LEToNative32(aMibs->txStats.octets);
    aCtx->ctx.msg.mib.txStats.brdCast = CPU_LEToNative32(aMibs->txStats.brdCast);
    aCtx->ctx.msg.mib.txStats.mutCast = CPU_LEToNative32(aMibs->txStats.mutCast);
    aCtx->ctx.msg.mib.txStats.uniCast = CPU_LEToNative32(aMibs->txStats.uniCast);
    aCtx->ctx.msg.mib.txStats.txDropped = CPU_LEToNative32(aMibs->txStats.txDropped);
    aCtx->ctx.msg.mib.txStats.txDroppedErr = CPU_LEToNative32(aMibs->txStats.txDroppedErr);
    aCtx->ctx.msg.mib.txStats.txCollision = CPU_LEToNative32(aMibs->txStats.txCollision);
    aCtx->ctx.msg.mib.txStats.txCollisionSingle = CPU_LEToNative32(aMibs->txStats.txCollisionSingle);
    aCtx->ctx.msg.mib.txStats.txCollisionMulti = CPU_LEToNative32(aMibs->txStats.txCollisionMulti);
    aCtx->ctx.msg.mib.txStats.txLateCollision = CPU_LEToNative32(aMibs->txStats.txLateCollision);
    aCtx->ctx.msg.mib.txStats.txExcessiveCollision = CPU_LEToNative32(aMibs->txStats.txExcessiveCollision);
    aCtx->ctx.msg.mib.txStats.txDeferredTransmit = CPU_LEToNative32(aMibs->txStats.txDeferredTransmit);
    aCtx->ctx.msg.mib.txStats.txFrameInDiscard = CPU_LEToNative32(aMibs->txStats.txFrameInDiscard);
    aCtx->ctx.msg.mib.txStats.txPause = CPU_LEToNative32(aMibs->txStats.txPause);
    aCtx->ctx.msg.mib.txStats.txQ0 = CPU_LEToNative32(aMibs->txStats.txQ0);
    aCtx->ctx.msg.mib.txStats.txQ1 = CPU_LEToNative32(aMibs->txStats.txQ1);
    aCtx->ctx.msg.mib.txStats.txQ2 = CPU_LEToNative32(aMibs->txStats.txQ2);
    aCtx->ctx.msg.mib.txStats.txQ3 = CPU_LEToNative32(aMibs->txStats.txQ3);
    aCtx->ctx.msg.mib.txStats.txQ4 = CPU_LEToNative32(aMibs->txStats.txQ4);
    aCtx->ctx.msg.mib.txStats.txQ5 = CPU_LEToNative32(aMibs->txStats.txQ5);
    aCtx->ctx.msg.mib.txStats.txQ6 = CPU_LEToNative32(aMibs->txStats.txQ6);
    aCtx->ctx.msg.mib.txStats.txQ7 = CPU_LEToNative32(aMibs->txStats.txQ7);
    aCtx->ctx.msg.mib.txStats.pkts64 = CPU_LEToNative32(aMibs->txStats.pkts64);
    aCtx->ctx.msg.mib.txStats.pkts65_127 = CPU_LEToNative32(aMibs->txStats.pkts65_127);
    aCtx->ctx.msg.mib.txStats.pkts128_255 = CPU_LEToNative32(aMibs->txStats.pkts128_255);
    aCtx->ctx.msg.mib.txStats.pkts256_511 = CPU_LEToNative32(aMibs->txStats.pkts256_511);
    aCtx->ctx.msg.mib.txStats.pkts512_1023 = CPU_LEToNative32(aMibs->txStats.pkts512_1023);
    aCtx->ctx.msg.mib.txStats.pkts1024_MAX = CPU_LEToNative32(aMibs->txStats.pkts1024_MAX);
}

/**
    @brief Print Mibs Stats

    @trace #BRCM_SWARCH_ETHSWT_SWTHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
static void ETHSWT_SWTDbgPrintMibsStats(ETHSWT_SWTDbgHelperCtxType *aCtx)
{
    /*    Rx Stats    */
    (void)MODULE_HostHelperLog("******Rx Stats******\n");
    (void)MODULE_HostHelperLog("*** RX PKT STATS ***\n");
    (void)MODULE_HostHelperLog("\t gdPkts : 0x%x\n", aCtx->ctx.msg.mib.rxStats.gdPkts );
    (void)MODULE_HostHelperLog("\t octets: %" PRIx64 "\n",
            ((uint64_t)aCtx->ctx.msg.mib.rxStats.octetsHigh << 32UL) | aCtx->ctx.msg.mib.rxStats.octetsLow);
    (void)MODULE_HostHelperLog("\t allPkts: 0x%x\n", aCtx->ctx.msg.mib.rxStats.allPkts);
    (void)MODULE_HostHelperLog("\t brdCast: 0x%x\n", aCtx->ctx.msg.mib.rxStats.brdCast);
    (void)MODULE_HostHelperLog("\t multicast: 0x%x\n", aCtx->ctx.msg.mib.rxStats.mutCast);
    (void)MODULE_HostHelperLog("\t unicast: 0x%x\n", aCtx->ctx.msg.mib.rxStats.uniCast);
    (void)MODULE_HostHelperLog("\t pkts64: 0x%x\n", aCtx->ctx.msg.mib.rxStats.pkts64);
    (void)MODULE_HostHelperLog("\t pkts65_127: 0x%x\n", aCtx->ctx.msg.mib.rxStats.pkts65_127);
    (void)MODULE_HostHelperLog("\t pkts128_255: 0x%x\n", aCtx->ctx.msg.mib.rxStats.pkts128_255);
    (void)MODULE_HostHelperLog("\t pkts256_511: 0x%x\n", aCtx->ctx.msg.mib.rxStats.pkts256_511);
    (void)MODULE_HostHelperLog("\t pkts512_1023: 0x%x\n", aCtx->ctx.msg.mib.rxStats.pkts512_1023);
    (void)MODULE_HostHelperLog("\t pkts1024_1522: 0x%x\n", aCtx->ctx.msg.mib.rxStats.pkts1024_1522);
    (void)MODULE_HostHelperLog("\t pkts1024_MAX: 0x%x\n", aCtx->ctx.msg.mib.rxStats.pkts1024_MAX);
    (void)MODULE_HostHelperLog("\t pkts1523_2047: 0x%x\n", aCtx->ctx.msg.mib.rxStats.pkts1523_2047);
    (void)MODULE_HostHelperLog("\t pkts2048_4095: 0x%x\n", aCtx->ctx.msg.mib.rxStats.pkts2048_4095);
    (void)MODULE_HostHelperLog("\t pkts4096_8191: 0x%x\n", aCtx->ctx.msg.mib.rxStats.pkts4096_8191);
    (void)MODULE_HostHelperLog("\t pkts8192_MAX: 0x%x\n", aCtx->ctx.msg.mib.rxStats.pkts8192_MAX);
    (void)MODULE_HostHelperLog("\t pktsOvrSz: 0x%x\n", aCtx->ctx.msg.mib.rxStats.pktsOvrSz);
    (void)MODULE_HostHelperLog("\t pktsRxDrop: 0x%x\n", aCtx->ctx.msg.mib.rxStats.pktsRxDrop);
    (void)MODULE_HostHelperLog("\t pktsCrcErr: 0x%x\n", aCtx->ctx.msg.mib.rxStats.pktsCrcErr);
    (void)MODULE_HostHelperLog("\t pktsCrcAlignErr: 0x%x\n", aCtx->ctx.msg.mib.rxStats.pktsCrcAlignErr);
    (void)MODULE_HostHelperLog("\t pktsJabber: 0x%x\n", aCtx->ctx.msg.mib.rxStats.pktsJabber);
    (void)MODULE_HostHelperLog("\t pktsFrag: 0x%x\n", aCtx->ctx.msg.mib.rxStats.pktsFrag);
    (void)MODULE_HostHelperLog("\t pktsUndSz: 0x%x\n", aCtx->ctx.msg.mib.rxStats.pktsUndSz);
    (void)MODULE_HostHelperLog("\t pktsRxDiscard: 0x%x\n", aCtx->ctx.msg.mib.rxStats.pktsRxDiscard);
    (void)MODULE_HostHelperLog("\t rxPause: 0x%x\n", aCtx->ctx.msg.mib.rxStats.rxPause);

    /*    Tx Stats    */
    (void)MODULE_HostHelperLog("******Tx Stats******\n");
    (void)MODULE_HostHelperLog("*** TX PKT STATS ***\n");
    (void)MODULE_HostHelperLog("\t octets: 0x%x\n", aCtx->ctx.msg.mib.txStats.octets);
    (void)MODULE_HostHelperLog("\t brdCast: 0x%x\n", aCtx->ctx.msg.mib.txStats.brdCast);
    (void)MODULE_HostHelperLog("\t multicast: 0x%x\n", aCtx->ctx.msg.mib.txStats.mutCast);
    (void)MODULE_HostHelperLog("\t unicast: 0x%x\n", aCtx->ctx.msg.mib.txStats.uniCast);
    (void)MODULE_HostHelperLog("\t txDropped: 0x%x\n", aCtx->ctx.msg.mib.txStats.txDropped);
    (void)MODULE_HostHelperLog("\t txDroppedErr: 0x%x\n", aCtx->ctx.msg.mib.txStats.txDroppedErr);
    (void)MODULE_HostHelperLog("\t txCollision: 0x%x\n", aCtx->ctx.msg.mib.txStats.txCollision);
    (void)MODULE_HostHelperLog("\t txCollisionSingle: 0x%x\n", aCtx->ctx.msg.mib.txStats.txCollisionSingle);
    (void)MODULE_HostHelperLog("\t txCollisionMulti: 0x%x\n", aCtx->ctx.msg.mib.txStats.txCollisionMulti);
    (void)MODULE_HostHelperLog("\t txLateCollision: 0x%x\n", aCtx->ctx.msg.mib.txStats.txLateCollision);
    (void)MODULE_HostHelperLog("\t txExcessiveCollision: 0x%x\n", aCtx->ctx.msg.mib.txStats.txExcessiveCollision);
    (void)MODULE_HostHelperLog("\t txDeferredTransmit: 0x%x\n", aCtx->ctx.msg.mib.txStats.txDeferredTransmit);
    (void)MODULE_HostHelperLog("\t txFrameInDiscard: 0x%x\n", aCtx->ctx.msg.mib.txStats.txFrameInDiscard);
    (void)MODULE_HostHelperLog("\t txPause: 0x%x\n", aCtx->ctx.msg.mib.txStats.txPause);
    (void)MODULE_HostHelperLog("\t txQ0: 0x%x\n", aCtx->ctx.msg.mib.txStats.txQ0);
    (void)MODULE_HostHelperLog("\t txQ1: 0x%x\n", aCtx->ctx.msg.mib.txStats.txQ1);
    (void)MODULE_HostHelperLog("\t txQ2: 0x%x\n", aCtx->ctx.msg.mib.txStats.txQ2);
    (void)MODULE_HostHelperLog("\t txQ3: 0x%x\n", aCtx->ctx.msg.mib.txStats.txQ3);
    (void)MODULE_HostHelperLog("\t txQ4: 0x%x\n", aCtx->ctx.msg.mib.txStats.txQ4);
    (void)MODULE_HostHelperLog("\t txQ5: 0x%x\n", aCtx->ctx.msg.mib.txStats.txQ5);
    (void)MODULE_HostHelperLog("\t txQ6: 0x%x\n", aCtx->ctx.msg.mib.txStats.txQ6);
    (void)MODULE_HostHelperLog("\t txQ7: 0x%x\n", aCtx->ctx.msg.mib.txStats.txQ7);
    (void)MODULE_HostHelperLog("\t pkts64: 0x%x\n", aCtx->ctx.msg.mib.txStats.pkts64);
    (void)MODULE_HostHelperLog("\t pkts65_127: 0x%x\n", aCtx->ctx.msg.mib.txStats.pkts65_127);
    (void)MODULE_HostHelperLog("\t pkts128_255: 0x%x\n", aCtx->ctx.msg.mib.txStats.pkts128_255);
    (void)MODULE_HostHelperLog("\t pkts256_511: 0x%x\n", aCtx->ctx.msg.mib.txStats.pkts256_511);
    (void)MODULE_HostHelperLog("\t pkts512_1023: 0x%x\n", aCtx->ctx.msg.mib.txStats.pkts512_1023);
    (void)MODULE_HostHelperLog("\t pkts1024_MAX: 0x%x\n", aCtx->ctx.msg.mib.txStats.pkts1024_MAX);
}

/**
    @brief Switch Controller Clear Port mibs handler

    @trace #BRCM_SWARCH_ETHSWT_SWTHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
int32_t ETHSWT_SWTDbgClearPortMibsHelperHdlr(BCM_CmdType   *aMsg,
                                             uint8_t       *aBuff,
                                             uint32_t       aInputLen,
                                             uint32_t      *aOutLen,
                                             uint32_t       aMaxLength,
                                             int32_t        aResponse,
                                             ETHSWT_SWTDbgHelperCtxType *aCtx)
{
    int32_t retVal = BCM_ERR_UNKNOWN;
    ETHSWT_DebugMsgUnionType cmdMsg;

    BCM_MemCpy(cmdMsg.data, aBuff, aInputLen);
    switch(aCtx->modCtx.substate) {
        case BCM_STATE_SUB_STATE_STAGE0:
            /* Get Port Info */
            cmdMsg.mib.port = CPU_NativeToLE32(aCtx->ctx.msg.mib.port);
            *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_DBG_ID, ETHSWT_DEBUGCMDID_MIBS_CLEAR);
            *aOutLen = sizeof(ETHSWT_DebugMibType);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            retVal = BCM_ERR_OK;
            break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Failed to clear mibs for port=%u, retVal=%d\n",
                                                          aCtx->ctx.msg.mib.port, aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(ETHSWT_DebugMibType))) {
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
    @brief Switch Controller Get Port mibs handler

    @trace #BRCM_SWARCH_ETHSWT_SWTHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
int32_t ETHSWT_SWTDbgGetPortMibsHelperHdlr(BCM_CmdType   *aMsg,
                                           uint8_t       *aBuff,
                                           uint32_t       aInputLen,
                                           uint32_t      *aOutLen,
                                           uint32_t       aMaxLength,
                                           int32_t        aResponse,
                                           ETHSWT_SWTDbgHelperCtxType *aCtx)
{
    int32_t retVal = BCM_ERR_UNKNOWN;
    ETHSWT_DebugMsgUnionType cmdMsg;
    BCM_MemCpy(cmdMsg.data, aBuff, aInputLen);

    switch(aCtx->modCtx.substate) {
        case BCM_STATE_SUB_STATE_STAGE0:
            /* Get Port Info */
            cmdMsg.mib.port = CPU_NativeToLE32(aCtx->ctx.msg.mib.port);
            *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_DBG_ID, ETHSWT_DEBUGCMDID_MIBS);
            *aOutLen = sizeof(ETHSWT_DebugMibType);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            retVal = BCM_ERR_OK;
            break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Failed to retrieve mibs for port=%u, retVal=%d\n",
                                                          aCtx->ctx.msg.mib.port, aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(ETHSWT_DebugMibType))) {
                (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                retVal = BCM_ERR_UNKNOWN;
            } else {
                ETHSWT_SWTDbgConvertMibsInt(&cmdMsg.mib,aCtx);
                ETHSWT_SWTDbgPrintMibsStats(aCtx);
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
    @brief Switch Controller Set Age Time handler

    @trace #BRCM_SWARCH_ETHSWT_SWTHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
int32_t ETHSWT_SWTCtrlrSetAgeTimeHelperHdlr(BCM_CmdType   *aMsg,
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
            /* Get Switch Info */
            *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_SWT_ID, ETHSWT_EXTCMDID_SWITCH_INFO_GET);
            *aOutLen = sizeof(ETHSWT_ExtSwitchInfoType);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            retVal = BCM_ERR_OK;
            break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Failed to set AGE time, retVal = %d\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(ETHSWT_ExtSwitchInfoType))) {
                (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                retVal = BCM_ERR_UNKNOWN;
            } else {
                cmdMsg.switchInfo.ageTime = CPU_NativeToLE32(aCtx->ctx.msg.switchInfo.ageTime);
                *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_SWT_ID, ETHSWT_EXTCMDID_SWITCH_INFO_SET);
                *aOutLen = sizeof(ETHSWT_ExtSwitchInfoType);
                aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE2;
                retVal = BCM_ERR_OK;
            }
            break;
        case BCM_STATE_SUB_STATE_STAGE2:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Failed to set AGE time, retVal = %d\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(ETHSWT_ExtSwitchInfoType))) {
                (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                retVal = BCM_ERR_UNKNOWN;
            } else {
                (void)MODULE_HostHelperLog("Switch FDB age timeout set to = %d secs\n",aCtx->ctx.msg.switchInfo.ageTime);
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
    @brief Switch Controller Get Age Time handler

    @trace #BRCM_SWARCH_ETHSWT_SWTHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
int32_t ETHSWT_SWTCtrlrGetAgeTimeHelperHdlr(BCM_CmdType   *aMsg,
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
            /* Get Switch Info */
            *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_SWT_ID, ETHSWT_EXTCMDID_SWITCH_INFO_GET);
            *aOutLen = sizeof(ETHSWT_ExtSwitchInfoType);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            retVal = BCM_ERR_OK;
            break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Failed to get AGE time, retVal = %d\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(ETHSWT_ExtSwitchInfoType))) {
                (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                retVal = BCM_ERR_UNKNOWN;
            } else {
                aCtx->ctx.msg.switchInfo.ageTime = CPU_LEToNative32(cmdMsg.switchInfo.ageTime);
                (void)MODULE_HostHelperLog("Switch FDB age timeout (secs) =%d\n", aCtx->ctx.msg.switchInfo.ageTime);
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
    @brief Switch Controller set Dumb Forward Mode handler

    @trace #BRCM_SWARCH_ETHSWT_SWTHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
int32_t ETHSWT_SWTCtrlrSetDumpFwdHelperHdlr(BCM_CmdType   *aMsg,
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
            /* Get Switch Info */
            *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_SWT_ID, ETHSWT_EXTCMDID_SWITCH_INFO_GET);
            *aOutLen = sizeof(ETHSWT_ExtSwitchInfoType);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            retVal = BCM_ERR_OK;
            break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Failed to set P8 Dumb Forward mode, retVal = %d\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(ETHSWT_ExtSwitchInfoType))) {
                (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                retVal = BCM_ERR_UNKNOWN;
            } else {
                cmdMsg.switchInfo.dumbFwdMode = CPU_NativeToLE32(aCtx->ctx.msg.switchInfo.dumbFwdMode);
                *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_SWT_ID, ETHSWT_EXTCMDID_SWITCH_INFO_SET);
                *aOutLen = sizeof(ETHSWT_ExtSwitchInfoType);
                aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE2;
                retVal = BCM_ERR_OK;
            }
            break;
        case BCM_STATE_SUB_STATE_STAGE2:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Failed to set P8 Dumb Forward mode, retVal = %d\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(ETHSWT_ExtSwitchInfoType))) {
                (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                retVal = BCM_ERR_UNKNOWN;
            } else {
                (void)MODULE_HostHelperLog("P8 Dumb Forwarding %s\n", (aCtx->ctx.msg.switchInfo.dumbFwdMode == ETHSWT_DUMBFWD_ENABLE) ? "Enabled" : "Disabled");
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
    @brief Switch Controller Get Dumb Forward Mode handler

    @trace #BRCM_SWARCH_ETHSWT_SWTHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
int32_t ETHSWT_SWTCtrlrGetDumbFwdHelperHdlr(BCM_CmdType   *aMsg,
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
            /* Get Switch Info */
            *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_SWT_ID, ETHSWT_EXTCMDID_SWITCH_INFO_GET);
            *aOutLen = sizeof(ETHSWT_ExtSwitchInfoType);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            retVal = BCM_ERR_OK;
            break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Failed to get P8 Dumb Forwarding  Mode, retVal = %d\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(ETHSWT_ExtSwitchInfoType))) {
                (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                retVal = BCM_ERR_UNKNOWN;
            } else {
                aCtx->ctx.msg.switchInfo.dumbFwdMode = CPU_LEToNative32(cmdMsg.switchInfo.dumbFwdMode);
                (void)MODULE_HostHelperLog("P8 Dumb Forwarding is %s\n", (aCtx->ctx.msg.switchInfo.dumbFwdMode == ETHSWT_DUMBFWD_ENABLE) ? "Enabled" : "Disabled");
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
    @brief Switch Controller set Brcm Header handler

    @trace #BRCM_SWARCH_ETHSWT_SWTHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
int32_t ETHSWT_SWTCtrlrSetBRCMHdrHelperHdlr(BCM_CmdType   *aMsg,
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
            /* Get Switch Info */
            *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_SWT_ID, ETHSWT_EXTCMDID_SWITCH_INFO_GET);
            *aOutLen = sizeof(ETHSWT_ExtSwitchInfoType);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            retVal = BCM_ERR_OK;
            break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Failed to set IMP Broadcom Header mode, retVal = %d\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(ETHSWT_ExtSwitchInfoType))) {
                (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                retVal = BCM_ERR_UNKNOWN;
            } else {
                cmdMsg.switchInfo.brcmHdrMode = CPU_NativeToLE32(aCtx->ctx.msg.switchInfo.brcmHdrMode);
                *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_SWT_ID, ETHSWT_EXTCMDID_SWITCH_INFO_SET);
                *aOutLen = sizeof(ETHSWT_ExtSwitchInfoType);
                aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE2;
                retVal = BCM_ERR_OK;
            }
            break;
        case BCM_STATE_SUB_STATE_STAGE2:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Failed to set IMP Broadcom Header mode, retVal = %d\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(ETHSWT_ExtSwitchInfoType))) {
                (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                retVal = BCM_ERR_UNKNOWN;
            } else {
                (void)MODULE_HostHelperLog("IMP Broadcom Header mode %s\n", (aCtx->ctx.msg.switchInfo.brcmHdrMode == ETHSWT_BRCMHDR_ENABLE) ? "Enabled" : "Disabled");
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
    @brief Switch Controller Get Brcm Header handler

    @trace #BRCM_SWARCH_ETHSWT_SWTHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
int32_t ETHSWT_SWTCtrlrGetBRCMHdrHelperHdlr(BCM_CmdType   *aMsg,
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
            /* Get Switch Info */
            *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_SWT_ID, ETHSWT_EXTCMDID_SWITCH_INFO_GET);
            *aOutLen = sizeof(ETHSWT_ExtSwitchInfoType);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            retVal = BCM_ERR_OK;
            break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Failed to get IMP Broadcom Header Mode, retVal = %d\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(ETHSWT_ExtSwitchInfoType))) {
                (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                retVal = BCM_ERR_UNKNOWN;
            } else {
                aCtx->ctx.msg.switchInfo.brcmHdrMode = CPU_LEToNative32(cmdMsg.switchInfo.brcmHdrMode);
                (void)MODULE_HostHelperLog("IMP Broadcom Header Mode is %s\n", (aCtx->ctx.msg.switchInfo.brcmHdrMode == ETHSWT_BRCMHDR_ENABLE) ? "Enabled" : "Disabled");
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
    @brief Switch Controller Set Management handler

    @trace #BRCM_SWARCH_ETHSWT_SWTHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
int32_t ETHSWT_SWTCtrlrSetMgmtHelperHdlr(BCM_CmdType   *aMsg,
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
            /* Get Switch Info */
            *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_SWT_ID, ETHSWT_EXTCMDID_SWITCH_INFO_GET);
            *aOutLen = sizeof(ETHSWT_ExtSwitchInfoType);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            retVal = BCM_ERR_OK;
            break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Failed to set management mode, retVal = %d\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(ETHSWT_ExtSwitchInfoType))) {
                (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                retVal = BCM_ERR_UNKNOWN;
            } else {
                cmdMsg.switchInfo.mgmtMode = CPU_NativeToLE32(aCtx->ctx.msg.switchInfo.mgmtMode);
                *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_SWT_ID, ETHSWT_EXTCMDID_SWITCH_INFO_SET);
                *aOutLen = sizeof(ETHSWT_ExtSwitchInfoType);
                aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE2;
                retVal = BCM_ERR_OK;
            }
            break;
        case BCM_STATE_SUB_STATE_STAGE2:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Failed to set management mode, retVal = %d\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(ETHSWT_ExtSwitchInfoType))) {
                (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                retVal = BCM_ERR_UNKNOWN;
            } else {
                (void)MODULE_HostHelperLog("Management mode %s\n", (aCtx->ctx.msg.switchInfo.mgmtMode == ETHSWT_MGMTMODE_ENABLE) ? "Enabled" : "Disabled");
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
    @brief Switch Controller Get Management handler

    @trace #BRCM_SWARCH_ETHSWT_SWTHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
int32_t ETHSWT_SWTCtrlrGetMgmtHelperHdlr(BCM_CmdType   *aMsg,
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
            /* Get Switch Info */
            *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_SWT_ID, ETHSWT_EXTCMDID_SWITCH_INFO_GET);
            *aOutLen = sizeof(ETHSWT_ExtSwitchInfoType);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            retVal = BCM_ERR_OK;
            break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Failed to get Management Mode, retVal = %d\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(ETHSWT_ExtSwitchInfoType))) {
                (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                retVal = BCM_ERR_UNKNOWN;
            } else {
                aCtx->ctx.msg.switchInfo.mgmtMode = CPU_LEToNative32(cmdMsg.switchInfo.mgmtMode);
                (void)MODULE_HostHelperLog("Management Mode is %s\n", (aCtx->ctx.msg.switchInfo.mgmtMode == ETHSWT_MGMTMODE_ENABLE) ? "Enabled" : "Disabled");
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
    @brief Switch Controller Set iFilter handler

    @trace #BRCM_SWARCH_ETHSWT_SWTHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
int32_t ETHSWT_SWTCtrlrSetIfilterHelperHdlr(BCM_CmdType   *aMsg,
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
            /* Get Switch Info */
            *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_SWT_ID, ETHSWT_EXTCMDID_SWITCH_INFO_GET);
            *aOutLen = sizeof(ETHSWT_ExtSwitchInfoType);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            retVal = BCM_ERR_OK;
            break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Failed to set the VLAN ingress filter, ret = %d\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(ETHSWT_ExtSwitchInfoType))) {
                (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                retVal = BCM_ERR_UNKNOWN;
            } else {
                cmdMsg.switchInfo.iFilter = CPU_NativeToLE32(aCtx->ctx.msg.switchInfo.iFilter);
                *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_SWT_ID, ETHSWT_EXTCMDID_SWITCH_INFO_SET);
                *aOutLen = sizeof(ETHSWT_ExtSwitchInfoType);
                aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE2;
                retVal = BCM_ERR_OK;
            }
            break;
        case BCM_STATE_SUB_STATE_STAGE2:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Failed to set the VLAN ingress filter, ret = %d\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(ETHSWT_ExtSwitchInfoType))) {
                (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                retVal = BCM_ERR_UNKNOWN;
            } else {
                (void)MODULE_HostHelperLog("VLAN ingress filter has been ");
                if (aCtx->ctx.msg.switchInfo.iFilter == ETHSWT_VLAN_INGRESS_FILTER_MODE_ENABLED) {
                    (void)MODULE_HostHelperLog("Enabled\n");
                } else {
                    (void)MODULE_HostHelperLog("Disabled\n");
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
    @brief Switch Controller Get iFilter handler

    @trace #BRCM_SWARCH_ETHSWT_SWTHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
int32_t ETHSWT_SWTCtrlrGetIFilterHelperHdlr(BCM_CmdType   *aMsg,
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
            /* Get Switch Info */
            *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_SWT_ID, ETHSWT_EXTCMDID_SWITCH_INFO_GET);
            *aOutLen = sizeof(ETHSWT_ExtSwitchInfoType);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            retVal = BCM_ERR_OK;
            break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Failed to get Management Mode, retVal = %d\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(ETHSWT_ExtSwitchInfoType))) {
                (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                retVal = BCM_ERR_UNKNOWN;
            } else {
                aCtx->ctx.msg.switchInfo.iFilter = CPU_LEToNative32(cmdMsg.switchInfo.iFilter);
                (void)MODULE_HostHelperLog("VLAN ingress filter is ");
                if (aCtx->ctx.msg.switchInfo.iFilter == ETHSWT_VLAN_INGRESS_FILTER_MODE_ENABLED) {
                    (void)MODULE_HostHelperLog("Enabled\n");
                } else if (aCtx->ctx.msg.switchInfo.iFilter == ETHSWT_VLAN_INGRESS_FILTER_MODE_DISABLED) {
                    (void)MODULE_HostHelperLog("Disabled\n");
                } else {
                    (void)MODULE_HostHelperLog("Unknown\n");
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
    @brief Switch Controller Register Read handler

    @trace #BRCM_SWARCH_ETHSWT_SWTHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
int32_t ETHSWT_SWTCtrlrReadHelperHdlr(BCM_CmdType   *aMsg,
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
            cmdMsg.regAccess.addr = CPU_NativeToLE32(aCtx->ctx.msg.regAccess.addr);
            cmdMsg.regAccess.len = CPU_NativeToLE32(aCtx->ctx.msg.regAccess.len);
            cmdMsg.regAccess.deviceID = CPU_NativeToLE32(aCtx->ctx.msg.regAccess.deviceID);
            *(uint64_t *)aCtx->ctx.msg.regAccess.data = 0ULL;
            *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_CRE_ID, ETHSWT_CORECMDID_READ);
            *aOutLen = sizeof(ETHSWT_CoreRegAccessType);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            retVal = BCM_ERR_OK;
            break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Error in switch read 0x%x\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(ETHSWT_CoreRegAccessType))) {
                (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                retVal = BCM_ERR_UNKNOWN;
            } else {
                /* copy 64 bit data */
                *(uint64_t *)aCtx->ctx.msg.regAccess.data = CPU_LEToNative64(*(uint64_t *)&cmdMsg.regAccess.data[0]);
                (void)MODULE_HostHelperLog("0x%016" PRIX64 "\n", (*(uint64_t *)aCtx->ctx.msg.regAccess.data));
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
    @brief Switch Controller Register Write handler

    @trace #BRCM_SWARCH_ETHSWT_SWTHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
int32_t ETHSWT_SWTCtrlrWriteHelperHdlr(BCM_CmdType   *aMsg,
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
            cmdMsg.regAccess.addr = CPU_NativeToLE32(aCtx->ctx.msg.regAccess.addr);
            cmdMsg.regAccess.len = CPU_NativeToLE32(aCtx->ctx.msg.regAccess.len);
            cmdMsg.regAccess.deviceID = CPU_NativeToLE32(aCtx->ctx.msg.regAccess.deviceID);
            *(uint64_t *)&cmdMsg.regAccess.data[0] = CPU_NativeToLE64(*(uint64_t *)aCtx->ctx.msg.regAccess.data);
                        //*(uint64_t *)aCtx->ctx.msg.regAccess.data = CPU_LEToNative64(*(uint64_t *)&cmdMsg.regAccess.data[0]);
            *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_CRE_ID, ETHSWT_CORECMDID_WRITE);
            *aOutLen = sizeof(ETHSWT_CoreRegAccessType);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            retVal = BCM_ERR_OK;
            break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Error in switch write 0x%x\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(ETHSWT_CoreRegAccessType))) {
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
