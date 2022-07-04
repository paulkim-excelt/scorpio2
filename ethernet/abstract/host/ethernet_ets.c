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
    @defgroup grp_ets_host_impl ETS Host Helpers Design
    @ingroup grp_ets

    @addtogroup grp_ets_host_impl
    @{

    @file module_hostets.c

    @brief Ethernet HOST host helpers Design

    @version 0.1 Initial version
*/
#include <stdio.h>
#include <string.h>
#include <module_msg.h>
#include <bcm_comp.h>
#include <cpu_utils.h>
#include <ethernet_ets.h>
#include <bcm_utils.h>

/**
    @name Ethernet switch ETS Helper Design ID's
    @{
    @brief Ethernet switch ETS Helper Design ID's
*/
#define BRCM_SWDSGN_ETS_HELPER_CTX_GLOBAL               (0xBE01U)     /**< @brief #ETS_HelperCtx             */
#define BRCM_SWDSGN_ETS_HELP_GLOBAL                     (0xBE02U)     /**< @brief #ETS_HelpCmds              */
#define BRCM_SWDSGN_ETS_HOSTMSGTOINDEX_PROC             (0xBE03U)     /**< @brief #ETS_HostMsgToIndex        */
#define BRCM_SWDSGN_ETS_COPYPORTSTATSTOCTX_PROC         (0xBE04U)     /**< @brief #ETS_CopyPortStatsToCtx    */
#define BRCM_SWDSGN_ETS_PRINTPORTSTATS_PROC             (0xBE05U)     /**< @brief #ETS_PrintPortStats        */
#define BRCM_SWDSGN_ETS_PRINTPORTROLE_PROC              (0xBE06U)     /**< @brief #ETS_PrintPortRole         */
#define BRCM_SWDSGN_ETS_COPYSTATUSTOCTX_PROC            (0xBE07U)     /**< @brief #ETS_CopyStatusToCtx       */
#define BRCM_SWDSGN_ETS_PRINTSTATUS_PROC                (0xBE08U)     /**< @brief #ETS_PrintStatus           */
#define BRCM_SWDSGN_ETS_PRINTGMSTATUS_PROC              (0xBE09U)     /**< @brief #ETS_PrintGmStatus         */
#define BRCM_SWDSGN_ETS_COPYDOMAINSTATUSTOCTX_PROC      (0xBE0AU)     /**< @brief #ETS_CopyDomainStatusToCtx */
#define BRCM_SWDSGN_ETS_PRINTDOMAINSTATUS_PROC          (0xBE0BU)     /**< @brief #ETS_PrintDomainStatus     */
#define BRCM_SWDSGN_ETS_COPYGLOBALSTATUSTOCTX_PROC      (0xBE0CU)     /**< @brief #ETS_CopyGlobalStatusToCtx */
#define BRCM_SWDSGN_ETS_PRINTGLOBALSTATUS_PROC          (0xBE0DU)     /**< @brief #ETS_PrintGlobalStatus     */
#define BRCM_SWDSGN_ETS_COPYPORTSTATUSTOCTX_PRO         (0xBE0EU)     /**< @brief #ETS_CopyPortStatusToCtx   */
#define BRCM_SWDSGN_ETS_PRINTPORTSTATUS_PROC            (0xBE0FU)     /**< @brief #ETS_PrintPortStatus       */
#define BRCM_SWDSGN_ETS_ADMINMODEPREPCTXINT_PROC        (0xBE10U)     /**< @brief #ETS_AdminModePrepCtxInt   */
#define BRCM_SWDSGN_ETS_ADMINMODEHDLR_PROC              (0xBE11U)     /**< @brief #ETS_AdminModeHdlr         */
#define BRCM_SWDSGN_ETS_GETSTATSCTXINT_PROC             (0xBE12U)     /**< @brief #ETS_GetStatsCtxInt        */
#define BRCM_SWDSGN_ETS_GETSTATSHDLR_PROC               (0xBE13U)     /**< @brief #ETS_GetStatsHdlr          */
#define BRCM_SWDSGN_ETS_CLEARSTATSCTXINT_PROC           (0xBE14U)     /**< @brief #ETS_ClearStatsCtxInt      */
#define BRCM_SWDSGN_ETS_CLEARSTATSHDLR_PROC             (0xBE15U)     /**< @brief #ETS_ClearStatsHdlr        */
#define BRCM_SWDSGN_ETS_GETSTATUSPREPCTXINT_PROC        (0xBE16U)     /**< @brief #ETS_GetStatusPrepCtxInt   */
#define BRCM_SWDSGN_ETS_GETDOMAINSTATUSHDLR_PROC        (0xBE17U)     /**< @brief #ETS_GetDomainStatusHdlr   */
#define BRCM_SWDSGN_ETS_GETGLOBALSTATUSHDLR_PROC        (0xBE18U)     /**< @brief #ETS_GetGlobalStatusHdlr   */
#define BRCM_SWDSGN_ETS_PORTSTATUSPREPCTXINT_PROC       (0xBE19U)     /**< @brief #ETS_PortStatusPrepCtxInt  */
#define BRCM_SWDSGN_ETS_PORTSTATUSHDLR_PROC             (0xBE1AU)     /**< @brief #ETS_PortStatusHdlr        */
#define BRCM_SWDSGN_ETS_PORTENABLECTXINT_PROC           (0xBE1BU)     /**< @brief #ETS_PortEnableCtxInt      */
#define BRCM_SWDSGN_ETS_PORTENABLEHDLR_PROC             (0xBE1CU)     /**< @brief #ETS_PortEnableHdlr        */
#define BRCM_SWDSGN_ETS_SETTIMECTXINT_PROC              (0xBE1DU)     /**< @brief #ETS_SetTimeCtxInt         */
#define BRCM_SWDSGN_ETS_RECORDSCTRLCTX_PROC             (0xBE1EU)     /**< @brief #ETS_RecordsCtrlCtxInt     */
#define BRCM_SWDSGN_ETS_SETTIMEHDLR_PROC                (0xBE1FU)     /**< @brief #ETS_SetTimeHdlr           */
#define BRCM_SWDSGN_ETS_RECORDSCTRLHDLR_PROC            (0xBE20U)     /**< @brief #ETS_RecordsCtrlHdlr       */
#define BRCM_SWDSGN_ETS_RECORDSCACHEHDLR_PROC           (0xBE21U)     /**< @brief #ETS_RecordsCacheHdlr      */
#define BRCM_SWDSGN_ETS_HELPERPREPCTX_PROC              (0xBE22U)     /**< @brief #ETS_HelperPrepCtx         */
#define BRCM_SWDSGN_ETS_HELPERPROCESS_PROC              (0xBE23U)     /**< @brief #ETS_HelperProcess         */
#define BRCM_SWDSGN_ETS_PRINTHELPER_GLOBAL              (0xBE24U)     /**< @brief #ETS_PrintHelper           */
#define BRCM_SWDSGN_ETS_HELPER_GLOBAL                   (0xBE25U)     /**< @brief #ETS_Helper                */
#define BRCM_SWDSGN_ETS_HOSTCONTEXTSETUP_PROC           (0xBE27U)     /**< @brief #ETS_HostContextSetup      */
#define BRCM_SWDSGN_ETS_HOSTCONTEXTPROCESS_PROC         (0xBE28U)     /**< @brief #ETS_HostContextProcess    */
/** @} */

/**
    @brief ETS Helper Module Context

    @trace #BRCM_SWARCH_ETS_HELPER_GLOBAL
    @trace #BRCM_SWREQ_ETS_COMMON
*/
ETS_HelperCtxType ETS_HelperCtx;

/**
    @brief ETS Supported commands

    @trace #BRCM_SWARCH_ETS_HELPER_GLOBAL
    @trace #BRCM_SWREQ_ETS_COMMON
*/
static const char ETS_HelpCmds[] =
"admin_mode <disable|enable>\n"
"stats <port> [domain]\n"
"clearstats <port> [domain]\n"
"status [domain]\n"
"portstatus <port> [domain]\n"
"portenable <port> <true|false> [domain]\n"
"time set <sec> <nanosec>\n"
"start notification\n"
"stop notification\n"
;

/**
    @brief Convert ETS Message to Index

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aMsgType        Messsage Type
    @param[out]     aMsgIdx         Converted message Index Number

    Return values are documented in reverse-chronological order
    @retval     void

    @post None

    @limitations None

    @trace #BRCM_SWARCH_ETS_HELPER_GLOBAL
    @trace #BRCM_SWREQ_ETS_COMMON

    @code{.unparsed}
    @endcode
*/
static int32_t ETS_HostMsgToIndex(ETS_MsgType aMsgType, uint32_t* aMsgIdx)
{
    int32_t retVal = BCM_ERR_OK;
    switch (aMsgType) {
        case ETS_MSG_SYNC:
            *aMsgIdx = 0UL;
            break;
        case ETS_MSG_FOLLOWUP:
            *aMsgIdx = 1UL;
            break;
        case ETS_MSG_PDELAY_REQ:
            *aMsgIdx = 2UL ;
            break;
        case ETS_MSG_PDELAY_RESP:
            *aMsgIdx = 3UL ;
            break;
        case ETS_MSG_PDELAY_RESP_FOLLOWUP:
            *aMsgIdx = 4UL ;
            break;
        default:
            *aMsgIdx = 0xFFFFFFFF;
            retVal = BCM_ERR_INVAL_PARAMS;
            break;
    }
    return retVal;
}

/**
    @brief Copy statistics to Context

    This API Convert the endianness to Native and copy to context

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aStatus            Received Stats
    @param[out]     aCtxStatus         Context stats which are Converted

    Return values are documented in reverse-chronological order
    @retval     void

    @post None

    @limitations None

    @trace #BRCM_SWARCH_ETS_HELPER_GLOBAL
    @trace #BRCM_SWREQ_ETS_COMMON

    @code{.unparsed}
    @endcode
*/
static void ETS_CopyPortStatsToCtx (ETS_PerDomainPortStatusType *aStatus,
                                    ETS_PerDomainPortStatusType *aCtxStatus)
{
    aCtxStatus->stats.magicId                     = CPU_LEToNative32(aStatus->stats.magicId);
    aCtxStatus->stats.syncTxCount                 = CPU_LEToNative32(aStatus->stats.syncTxCount);
    aCtxStatus->stats.syncRxCount                 = CPU_LEToNative32(aStatus->stats.syncRxCount);
    aCtxStatus->stats.syncTransmitTimeouts        = CPU_LEToNative32(aStatus->stats.syncTransmitTimeouts);
    aCtxStatus->stats.syncRxDiscards              = CPU_LEToNative32(aStatus->stats.syncRxDiscards);
    aCtxStatus->stats.followUpTxCount             = CPU_LEToNative32(aStatus->stats.followUpTxCount);
    aCtxStatus->stats.followUpRxCount             = CPU_LEToNative32(aStatus->stats.followUpRxCount);
    aCtxStatus->stats.followUpRxDiscards          = CPU_LEToNative32(aStatus->stats.followUpRxDiscards);
    aCtxStatus->stats.signalingTxCount            = CPU_LEToNative32(aStatus->stats.signalingTxCount);
    aCtxStatus->stats.signalingRxCount            = CPU_LEToNative32(aStatus->stats.signalingRxCount);
    aCtxStatus->stats.signalingRxDiscards         = CPU_LEToNative32(aStatus->stats.signalingRxDiscards);
    aCtxStatus->stats.announceTxCount             = CPU_LEToNative32(aStatus->stats.announceTxCount);
    aCtxStatus->stats.announceRxCount             = CPU_LEToNative32(aStatus->stats.announceRxCount);
    aCtxStatus->stats.announceRxDiscards          = CPU_LEToNative32(aStatus->stats.announceRxDiscards);
    aCtxStatus->stats.announceReceiptTimeouts     = CPU_LEToNative32(aStatus->stats.announceReceiptTimeouts);
    aCtxStatus->stats.pDelayReqTxCount            = CPU_LEToNative32(aStatus->stats.pDelayReqTxCount);
    aCtxStatus->stats.pDelayReqRxCount            = CPU_LEToNative32(aStatus->stats.pDelayReqRxCount);
    aCtxStatus->stats.pDelayReqRxDiscards         = CPU_LEToNative32(aStatus->stats.pDelayReqRxDiscards);
    aCtxStatus->stats.pDelayRespTxCount           = CPU_LEToNative32(aStatus->stats.pDelayRespTxCount);
    aCtxStatus->stats.pDelayRespRxCount           = CPU_LEToNative32(aStatus->stats.pDelayRespRxCount);
    aCtxStatus->stats.pDelayRespRxDiscards        = CPU_LEToNative32(aStatus->stats.pDelayRespRxDiscards);
    aCtxStatus->stats.pDelayRespFollowUpTxCount   = CPU_LEToNative32(aStatus->stats.pDelayRespFollowUpTxCount);
    aCtxStatus->stats.pDelayRespFollowUpRxCount   = CPU_LEToNative32(aStatus->stats.pDelayRespFollowUpRxCount);
    aCtxStatus->stats.syncReceiptTimeouts         = CPU_LEToNative32(aStatus->stats.syncReceiptTimeouts);
    aCtxStatus->stats.followupReceiptTimeouts     = CPU_LEToNative32(aStatus->stats.followupReceiptTimeouts);
    aCtxStatus->stats.pDelayReceiptTimeouts       = CPU_LEToNative32(aStatus->stats.pDelayReceiptTimeouts);
    aCtxStatus->stats.badPdelayValues             = CPU_LEToNative32(aStatus->stats.badPdelayValues);
    aCtxStatus->stats.txErrors                    = CPU_LEToNative32(aStatus->stats.txErrors);
    aCtxStatus->stats.tsErrors                    = CPU_LEToNative32(aStatus->stats.tsErrors);
    aCtxStatus->stats.ptpDiscardCount             = CPU_LEToNative32(aStatus->stats.ptpDiscardCount);
    aCtxStatus->stats.parseFailed                 = CPU_LEToNative32(aStatus->stats.parseFailed);
    aCtxStatus->stats.txConf                      = CPU_LEToNative32(aStatus->stats.txConf);
    aCtxStatus->stats.pDelayLostResponsesExceeded = CPU_LEToNative32(aStatus->stats.pDelayLostResponsesExceeded);
    aCtxStatus->stats.setTimeCount                = CPU_LEToNative32(aStatus->stats.setTimeCount);
    aCtxStatus->stats.deltaTime0NsTo10Ns          = CPU_LEToNative32(aStatus->stats.deltaTime0NsTo10Ns);
    aCtxStatus->stats.deltaTime11NsTo40Ns         = CPU_LEToNative32(aStatus->stats.deltaTime11NsTo40Ns);
    aCtxStatus->stats.deltaTime41NsTo80Ns         = CPU_LEToNative32(aStatus->stats.deltaTime41NsTo80Ns);
    aCtxStatus->stats.deltaTime81NsTo100Ns        = CPU_LEToNative32(aStatus->stats.deltaTime81NsTo100Ns);
    aCtxStatus->stats.deltaTime101NsTo1000Ns      = CPU_LEToNative32(aStatus->stats.deltaTime101NsTo1000Ns);
    aCtxStatus->stats.deltaTime1001NsTo10000Ns    = CPU_LEToNative32(aStatus->stats.deltaTime1001NsTo10000Ns);
    aCtxStatus->stats.deltaTime10001NsToMax       = CPU_LEToNative32(aStatus->stats.deltaTime10001NsToMax);
}

/**
    @brief Print ets statistics

    This API prints the statistics of port and domain

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aStats        Port Or Domain statistics

    Return values are documented in reverse-chronological order
    @retval     void

    @post None

    @limitations None

    @trace #BRCM_SWARCH_ETS_HELPER_GLOBAL
    @trace #BRCM_SWREQ_ETS_COMMON

    @code{.unparsed}
    @endcode
*/
static void ETS_PrintPortStats(ETS_StatsType *aStats)
{
   (void)MODULE_HostHelperLog("\n");
   (void)MODULE_HostHelperLog("Sync Rx                        : %d\n",aStats->syncRxCount);
   (void)MODULE_HostHelperLog("Sync Tx                        : %d\n",aStats->syncTxCount);
   (void)MODULE_HostHelperLog("Sync Tx Resends                : %d\n",aStats->syncTransmitTimeouts);
   (void)MODULE_HostHelperLog("Followup Rx                    : %d\n",aStats->followUpRxCount);
   (void)MODULE_HostHelperLog("Followup Tx                    : %d\n",aStats->followUpTxCount);
   (void)MODULE_HostHelperLog("Sync Rx Timeouts               : %d\n",aStats->syncReceiptTimeouts);
   (void)MODULE_HostHelperLog("FollowUp Rx Timeouts           : %d\n",aStats->followupReceiptTimeouts);
   (void)MODULE_HostHelperLog("Sync Discards                  : %d\n",aStats->syncRxDiscards);
   (void)MODULE_HostHelperLog("FollowUp Rx Discards           : %d\n",aStats->followUpRxDiscards);

   (void)MODULE_HostHelperLog("\n");
   (void)MODULE_HostHelperLog("Pdelay Req Rx                  : %d\n",aStats->pDelayReqRxCount);
   (void)MODULE_HostHelperLog("Pdelay Req Tx                  : %d\n",aStats->pDelayReqTxCount);
   (void)MODULE_HostHelperLog("Pdelay Resp Rx                 : %d\n",aStats->pDelayRespRxCount);
   (void)MODULE_HostHelperLog("Pdelay Resp Tx                 : %d\n",aStats->pDelayRespTxCount);
   (void)MODULE_HostHelperLog("Pdelay Resp FollowUp Rx        : %d\n",aStats->pDelayRespFollowUpRxCount);
   (void)MODULE_HostHelperLog("Pdelay Resp FollowUp Tx        : %d\n",aStats->pDelayRespFollowUpTxCount);
   (void)MODULE_HostHelperLog("Pdelay Req Rx Discards         : %d\n",aStats->pDelayReqRxDiscards);
   (void)MODULE_HostHelperLog("Pdelay Resp Rx Discards        : %d\n",aStats->pDelayRespRxDiscards);
   (void)MODULE_HostHelperLog("Pdelay Rx Timeouts             : %d\n",aStats->pDelayReceiptTimeouts);
   (void)MODULE_HostHelperLog("Bad Pdelay Values              : %d\n",aStats->badPdelayValues);
   (void)MODULE_HostHelperLog("Pdelay Lost Resp Exceeded      : %d\n",aStats->pDelayLostResponsesExceeded);
   (void)MODULE_HostHelperLog("Pdelay Rx Discards             : %d\n",aStats->pDelayReqRxDiscards
                                                                       + aStats->pDelayRespRxDiscards);

   (void)MODULE_HostHelperLog("\n");
   (void)MODULE_HostHelperLog("Announce Rx                    : %d\n",aStats->announceRxCount);
   (void)MODULE_HostHelperLog("Announce Tx                    : %d\n",aStats->announceTxCount);
   (void)MODULE_HostHelperLog("Announce Discards              : %d\n",aStats->announceRxDiscards);
   (void)MODULE_HostHelperLog("Announce Rx Timeouts           : %d\n",aStats->announceReceiptTimeouts);

   (void)MODULE_HostHelperLog("\n");
   (void)MODULE_HostHelperLog("Signaling Rx                   : %d\n",aStats->signalingRxCount);
   (void)MODULE_HostHelperLog("Signaling Tx                   : %d\n",aStats->signalingTxCount);
   (void)MODULE_HostHelperLog("Signaling Discards             : %d\n",aStats->signalingRxDiscards);

   (void)MODULE_HostHelperLog("\n");
   (void)MODULE_HostHelperLog("Tx Errors                      : %d\n",aStats->txErrors);
   (void)MODULE_HostHelperLog("Timestamp Errors               : %d\n",aStats->tsErrors);
   (void)MODULE_HostHelperLog("Bad headers                    : %d\n",aStats->parseFailed);
   (void)MODULE_HostHelperLog("PTP Discards                   : %d\n",aStats->ptpDiscardCount);
   (void)MODULE_HostHelperLog("Tx Total                       : %d\n",aStats->txConf);

   (void)MODULE_HostHelperLog("\n");
   (void)MODULE_HostHelperLog("Set Time Count                 : %d\n",aStats->setTimeCount);
   (void)MODULE_HostHelperLog("Time Correction 0ns-10ns       : %d\n",aStats->deltaTime0NsTo10Ns);
   (void)MODULE_HostHelperLog("Time Correction 11ns-40ns      : %d\n",aStats->deltaTime11NsTo40Ns);
   (void)MODULE_HostHelperLog("Time Correction 41ns-80ns      : %d\n",aStats->deltaTime41NsTo80Ns);
   (void)MODULE_HostHelperLog("Time Correction 81ns-100ns     : %d\n",aStats->deltaTime81NsTo100Ns);
   (void)MODULE_HostHelperLog("Time Correction 101ns-1000ns   : %d\n",aStats->deltaTime101NsTo1000Ns);
   (void)MODULE_HostHelperLog("Time Correction 1001ns-10000ns : %d\n",aStats->deltaTime1001NsTo10000Ns);
   (void)MODULE_HostHelperLog("Time Correction 10001ns-MAX    : %d\n",aStats->deltaTime10001NsToMax);
}

/**
    @brief Print Port Role

    This API prints the Port role

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aRole        Port Role

    Return values are documented in reverse-chronological order
    @retval     void

    @post None

    @limitations None

    @trace #BRCM_SWARCH_ETS_HELPER_GLOBAL
    @trace #BRCM_SWREQ_ETS_COMMON

    @code{.unparsed}
    @endcode
*/
static void ETS_PrintPortRole(ETS_RoleType aRole)
{

    switch (aRole) {
    case ETS_ROLE_MASTER:
        (void)MODULE_HostHelperLog("Port Role              : Master\n");
        break;
    case ETS_ROLE_SLAVE:
        (void)MODULE_HostHelperLog("Port Role              : Slave\n");
        break;
    case ETS_ROLE_DISABLED:
        (void)MODULE_HostHelperLog("Port Role              : Disabled\n");
        break;
    case ETS_ROLE_PASSIVE:
        (void)MODULE_HostHelperLog("Port Role              : Passive\n");
        break;
    default:
        (void)MODULE_HostHelperLog("Port Role              : Invalid\n");
        break;
    }
}

/**
    @brief Copy status to Context

    This API Convert the endianness to Native and copy to context

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aStatus       Received Stats
    @param[out]     aCtxStatus    Context stats which are Converted

    Return values are documented in reverse-chronological order
    @retval     void

    @post None

    @limitations None

    @trace #BRCM_SWARCH_ETS_HELPER_GLOBAL
    @trace #BRCM_SWREQ_ETS_COMMON

    @code{.unparsed}
    @endcode
*/
static void ETS_CopyStatusToCtx (ETS_PerDomainPortStatusType *aStatus,
                                 ETS_PerDomainPortStatusType *aCtxStatus)
{
    aCtxStatus->status.magicId                    = CPU_LEToNative32(aStatus->status.magicId);
    aCtxStatus->status.role                       = aStatus->status.role;
    aCtxStatus->status.currentLogSyncIntvl        = CPU_LEToNative32(aStatus->status.currentLogSyncIntvl);
    aCtxStatus->status.syncReceiptTimeoutIntvl    = CPU_LEToNative32(aStatus->status.syncReceiptTimeoutIntvl);
    aCtxStatus->status.syncInfoAvailable          = CPU_LEToNative32(aStatus->status.syncInfoAvailable);
    aCtxStatus->status.syncSeqNum                 = CPU_LEToNative16(aStatus->status.syncSeqNum);
    aCtxStatus->status.txFollowupCorrection       = CPU_LEToNative64(aStatus->status.txFollowupCorrection);
    aCtxStatus->status.syncState                  = CPU_LEToNative32(aStatus->status.syncState);
    aCtxStatus->status.syncTimestamp.seconds      = CPU_LEToNative64(aStatus->status.syncTimestamp.seconds);
    aCtxStatus->status.syncTimestamp.nanoseconds  = CPU_LEToNative32(aStatus->status.syncTimestamp.nanoseconds);
    aCtxStatus->status.announceSeqNum             = CPU_LEToNative16(aStatus->status.announceSeqNum);
    aCtxStatus->status.currentLogAnnIntvl         = CPU_LEToNative32(aStatus->status.currentLogAnnIntvl);
    aCtxStatus->status.annReceiptTimeoutIntvl     = CPU_LEToNative32(aStatus->status.annReceiptTimeoutIntvl);
    aCtxStatus->status.currentLogGptpCapIntvl     = CPU_LEToNative32(aStatus->status.currentLogGptpCapIntvl);
    aCtxStatus->status.gPTPCapReceiptTimeoutIntvl = CPU_LEToNative32(aStatus->status.gPTPCapReceiptTimeoutIntvl);
}

/**
    @brief Print Port status

    This API prints the status of port and domain

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aStatus        Port Or Domain status

    Return values are documented in reverse-chronological order
    @retval     void

    @post None

    @limitations None

    @trace #BRCM_SWARCH_ETS_HELPER_GLOBAL
    @trace #BRCM_SWREQ_ETS_COMMON

    @code{.unparsed}
    @endcode
*/
static void ETS_PrintStatus(ETS_DomainPortStatusType *aStatus)
{
    (void)MODULE_HostHelperLog("\n");
    ETS_PrintPortRole(aStatus->role);
    (void)MODULE_HostHelperLog("Sync interval                : %d\n", aStatus->currentLogSyncIntvl);
    (void)MODULE_HostHelperLog("Sync receipt timeout         : %u\n", aStatus->syncReceiptTimeoutIntvl);
    (void)MODULE_HostHelperLog("Sync Info Available          : %u\n", aStatus->syncInfoAvailable);
    (void)MODULE_HostHelperLog("Sync Sequence Number         : %u\n", aStatus->syncSeqNum);
    (void)MODULE_HostHelperLog("Tx Correction                : %" PRIu64 "\n", aStatus->txFollowupCorrection);
    (void)MODULE_HostHelperLog("Sync state                   : %d\n", aStatus->syncState);
    (void)MODULE_HostHelperLog("Sync Timestamp               : %" PRIu64 ".%09u\n", aStatus->syncTimestamp.seconds,
                                                                aStatus->syncTimestamp.nanoseconds);
    (void)MODULE_HostHelperLog("Announce Sequence Number     : %u\n", aStatus->announceSeqNum);
    (void)MODULE_HostHelperLog("Announce interval            : %d\n", aStatus->currentLogAnnIntvl);
    (void)MODULE_HostHelperLog("Announce receipt timeout     : %u\n", aStatus->annReceiptTimeoutIntvl);
    (void)MODULE_HostHelperLog("gPTP capable interval        : %d\n", aStatus->currentLogGptpCapIntvl);
    (void)MODULE_HostHelperLog("gPTP capable receipt timeout : %u\n", aStatus->gPTPCapReceiptTimeoutIntvl);
}

/**
    @brief Print Port GM Status

    This API prints the Port Grand Master Status

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aGmStatus        Grans Master status

    Return values are documented in reverse-chronological order
    @retval     void

    @post None

    @limitations None

    @trace #BRCM_SWARCH_ETS_HELPER_GLOBAL
    @trace #BRCM_SWREQ_ETS_COMMON

    @code{.unparsed}
    @endcode
*/
static void ETS_PrintGmStatus(ETS_GMStatusType aGmStatus)
{
    switch (aGmStatus){
        case ETS_GMSTATUS_STARTUP_ABSENT:
            (void)MODULE_HostHelperLog("GM Status                 : Absent At Startup\n");
            break;
        case ETS_GMSTATUS_OPER_ABSENT:
            (void)MODULE_HostHelperLog("GM Status                 : Absent\n");
            break;
        case ETS_GMSTATUS_UNDETERMINED:
            (void)MODULE_HostHelperLog("GM Status                 : Undetermined\n");
            break;
        case ETS_GMSTATUS_DISABLED:
            (void)MODULE_HostHelperLog("GM Status                 : Disabled\n");
            break;
        case ETS_GMSTATUS_NO_SLAVEPORT:
            (void)MODULE_HostHelperLog("GM Status                 : No slave port\n");
            break;
        case ETS_GMSTATUS_PRESENT:
            (void)MODULE_HostHelperLog("GM Status                 : Present\n");
            break;
        default:
            (void)MODULE_HostHelperLog("GM Status                 : Invalid\n");
            break;
    }
}

/**
    @brief Copy Domain Status to Context

    This API Convert the endianness to Native and copy to context

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aStatus            Received Domain status
    @param[out]     aCtxStatus         Context status which are Converted

    Return values are documented in reverse-chronological order
    @retval     void

    @post None

    @limitations None

    @trace #BRCM_SWARCH_ETS_HELPER_GLOBAL
    @trace #BRCM_SWREQ_ETS_COMMON

    @code{.unparsed}
    @endcode
*/
static void ETS_CopyDomainStatusToCtx (ETS_DomainNumAndStatusType *aStatus,
                                       ETS_DomainNumAndStatusType *aCtxStatus)
{
    uint32_t i;

    aCtxStatus->status.magicId                  = CPU_LEToNative32(aStatus->status.magicId);
    aCtxStatus->status.clockState               = CPU_LEToNative32(aStatus->status.clockState);
    aCtxStatus->status.gmStatus                 = CPU_LEToNative32(aStatus->status.gmStatus);
    aCtxStatus->status.rateRatioIn              = CPU_LEToNative32(aStatus->status.rateRatioIn);
    aCtxStatus->status.gmRateRatio              = CPU_LEToNative32(aStatus->status.gmRateRatio);
    aCtxStatus->status.slavePort                = CPU_LEToNative32(aStatus->status.slavePort);
    aCtxStatus->status.signalingTxSeqId         = CPU_LEToNative16(aStatus->status.signalingTxSeqId);
    aCtxStatus->status.reqSyncLogInterval       = CPU_LEToNative32(aStatus->status.reqSyncLogInterval);
    aCtxStatus->status.isSignalingTimerStarted  = CPU_LEToNative32(aStatus->status.isSignalingTimerStarted);
    aCtxStatus->status.isSyncReceived           = CPU_LEToNative32(aStatus->status.isSyncReceived);
    aCtxStatus->status.rxFollowupCorrection     = CPU_LEToNative64(aStatus->status.rxFollowupCorrection);
    aCtxStatus->status.rxPOT.seconds            = CPU_LEToNative64(aStatus->status.rxPOT.seconds);
    aCtxStatus->status.rxPOT.nanoseconds        = CPU_LEToNative32(aStatus->status.rxPOT.nanoseconds);
    aCtxStatus->status.gmIdentifier.stepsRemoved= CPU_LEToNative16(aStatus->status.gmIdentifier.stepsRemoved);

    memcpy(&aCtxStatus->status.gmIdentifier.clockId,
           &aStatus->status.gmIdentifier.clockId,
           sizeof(ETS_ClockIdentityType));

    aCtxStatus->status.gmIdentifier.systemId.priority1 =
        aStatus->status.gmIdentifier.systemId.priority1;

    aCtxStatus->status.gmIdentifier.systemId.clockClass =
        aStatus->status.gmIdentifier.systemId.clockClass;

    aCtxStatus->status.gmIdentifier.systemId.clockAccuracy =
        aStatus->status.gmIdentifier.systemId.clockAccuracy;

    aCtxStatus->status.gmIdentifier.systemId.offsetScaledLogVariance =
        CPU_LEToNative16(aStatus->status.gmIdentifier.systemId.offsetScaledLogVariance);

    aCtxStatus->status.gmIdentifier.systemId.priority2 =
        aStatus->status.gmIdentifier.systemId.priority2;

    aCtxStatus->status.gmIdentifier.timeSource       = aStatus->status.gmIdentifier.timeSource;
    aCtxStatus->status.gmIdentifier.pathTrace.type   = CPU_LEToNative16(aStatus->status.gmIdentifier.pathTrace.type);
    aCtxStatus->status.gmIdentifier.pathTrace.length = CPU_LEToNative16(aStatus->status.gmIdentifier.pathTrace.length);

    for (i = 0UL; i < ETS_MAX_HOPS_PER_DOMAIN; ++i) {
        memcpy(&aCtxStatus->status.gmIdentifier.pathTrace.clkID[i],
               &aStatus->status.gmIdentifier.pathTrace.clkID[i],
               sizeof(ETS_ClockIdentityType));
    }

    aCtxStatus->status.gmIdentifier.utcOffset = CPU_LEToNative16(aStatus->status.gmIdentifier.utcOffset);
    aCtxStatus->status.gmIdentifier.flags     = CPU_LEToNative16(aStatus->status.gmIdentifier.flags);
    aCtxStatus->status.gmChangeCount          = CPU_LEToNative32(aStatus->status.gmChangeCount);
    aCtxStatus->status.parentId.port          = CPU_LEToNative16(aStatus->status.parentId.port);

    memcpy(&aCtxStatus->status.parentId.clockID,
           &aStatus->status.parentId.clockID,
           sizeof(ETS_ClockIdentityType));

    aCtxStatus->status.domainState = aStatus->status.domainState;
}

/**
    @brief Print Domain Status from context

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aStats       Context Domain status

    Return values are documented in reverse-chronological order
    @retval     void

    @post None

    @limitations None

    @trace #BRCM_SWARCH_ETS_HELPER_GLOBAL
    @trace #BRCM_SWREQ_ETS_COMMON

    @code{.unparsed}
    @endcode
*/
static void ETS_PrintDomainStatus (ETS_DomainNumAndStatusType *aCtxStatus)
{
    (void)MODULE_HostHelperLog("\n");
    switch (aCtxStatus->status.clockState) {
    case ETS_CLOCKSTATE_INIT_GM:
        (void)MODULE_HostHelperLog("Clock state : Yet to be initialized as GM\n");
        break;
    case ETS_CLOCKSTATE_UPDATE_GM:
        (void)MODULE_HostHelperLog("Clock state : Initialized as GM\n");
        break;
    case ETS_CLOCKSTATE_INIT_SLAVE:
        (void)MODULE_HostHelperLog("Clock state : Yet to be initialized as slave\n");
        break;
    case ETS_CLOCKSTATE_UPDATE_SLAVE:
        (void)MODULE_HostHelperLog("Clock state : Initialized as slave\n");
        break;
    default:
        (void)MODULE_HostHelperLog("Clock state : Invalid\n");
        break;
    }

    if ((aCtxStatus->status.clockState == ETS_CLOCKSTATE_INIT_SLAVE) ||
        (aCtxStatus->status.clockState == ETS_CLOCKSTATE_UPDATE_SLAVE)) {
        ETS_PrintGmStatus(aCtxStatus->status.gmStatus);
        (void)MODULE_HostHelperLog("Slave Port                : %d\n", aCtxStatus->status.slavePort);
        (void)MODULE_HostHelperLog("Rate Ratio (In)           : 0x%x\n", aCtxStatus->status.rateRatioIn);
        (void)MODULE_HostHelperLog("Rate Ratio (Out)          : 0x%x\n", aCtxStatus->status.gmRateRatio);
        (void)MODULE_HostHelperLog("Is Sync Received          : %u\n", aCtxStatus->status.isSyncReceived);
        (void)MODULE_HostHelperLog("Signaling Sequence Number : %u\n", aCtxStatus->status.signalingTxSeqId);
        (void)MODULE_HostHelperLog("Requested Sync Interval   : %d\n", aCtxStatus->status.reqSyncLogInterval);
        (void)MODULE_HostHelperLog("Is Signaling Timer Started: %u\n", aCtxStatus->status.isSignalingTimerStarted);
        (void)MODULE_HostHelperLog("Rx Correction             : %" PRIu64 "\n", aCtxStatus->status.rxFollowupCorrection);
        (void)MODULE_HostHelperLog("Precise Origin TimeStamp  : %" PRIu64 ".%09u\n", aCtxStatus->status.rxPOT.seconds,
                aCtxStatus->status.rxPOT.nanoseconds);

        (void)MODULE_HostHelperLog("GM Clock Id               : ");
        (void)MODULE_HostHelperLog("%02x:%02x:%02x:%02x:%02x:%02x:%02x:%02x\n",
                aCtxStatus->status.gmIdentifier.clockId.id[0],
                aCtxStatus->status.gmIdentifier.clockId.id[1],
                aCtxStatus->status.gmIdentifier.clockId.id[2],
                aCtxStatus->status.gmIdentifier.clockId.id[3],
                aCtxStatus->status.gmIdentifier.clockId.id[4],
                aCtxStatus->status.gmIdentifier.clockId.id[5],
                aCtxStatus->status.gmIdentifier.clockId.id[6],
                aCtxStatus->status.gmIdentifier.clockId.id[7]);

        (void)MODULE_HostHelperLog("GM priority1              : %u\n", aCtxStatus->status.gmIdentifier.systemId.priority1);
        (void)MODULE_HostHelperLog("GM clock class            : %u\n", aCtxStatus->status.gmIdentifier.systemId.clockClass);
        (void)MODULE_HostHelperLog("GM clock accuracy         : %u\n", aCtxStatus->status.gmIdentifier.systemId.clockAccuracy);
        (void)MODULE_HostHelperLog("GM offset scaled log var  : %u\n", aCtxStatus->status.gmIdentifier.systemId.offsetScaledLogVariance);
        (void)MODULE_HostHelperLog("GM priority2              : %u\n", aCtxStatus->status.gmIdentifier.systemId.priority2);
        (void)MODULE_HostHelperLog("GM steps removed          : %u\n", aCtxStatus->status.gmIdentifier.stepsRemoved);
        (void)MODULE_HostHelperLog("GM time source            : 0x%x\n", aCtxStatus->status.gmIdentifier.timeSource);
        (void)MODULE_HostHelperLog("GM UTC offset             : %u\n", aCtxStatus->status.gmIdentifier.utcOffset);
        (void)MODULE_HostHelperLog("GM Flags                  : 0x%x\n", aCtxStatus->status.gmIdentifier.flags);
        if (aCtxStatus->status.gmIdentifier.pathTrace.length > 0U) {
            uint32_t numPaths = (aCtxStatus->status.gmIdentifier.pathTrace.length / ETS_CLOCK_ID_LEN);
            uint32_t i = 0UL;

            (void)MODULE_HostHelperLog("Path trace                : ");
            for (; i < numPaths; ++i) {
                (void)MODULE_HostHelperLog("\nPath Element %u            : ", i+1);
                (void)MODULE_HostHelperLog("%02x:%02x:%02x:%02x:%02x:%02x:%02x:%02x",
                        aCtxStatus->status.gmIdentifier.pathTrace.clkID[i].id[0],
                        aCtxStatus->status.gmIdentifier.pathTrace.clkID[i].id[1],
                        aCtxStatus->status.gmIdentifier.pathTrace.clkID[i].id[2],
                        aCtxStatus->status.gmIdentifier.pathTrace.clkID[i].id[3],
                        aCtxStatus->status.gmIdentifier.pathTrace.clkID[i].id[4],
                        aCtxStatus->status.gmIdentifier.pathTrace.clkID[i].id[5],
                        aCtxStatus->status.gmIdentifier.pathTrace.clkID[i].id[6],
                        aCtxStatus->status.gmIdentifier.pathTrace.clkID[i].id[7]);
            }
        }
        (void)MODULE_HostHelperLog("\nGM change count           : %u\n", aCtxStatus->status.gmChangeCount);
        (void)MODULE_HostHelperLog("Parent Clock Id           : ");
        (void)MODULE_HostHelperLog("%02x:%02x:%02x:%02x:%02x:%02x:%02x:%02x\n",
                aCtxStatus->status.parentId.clockID.id[0],
                aCtxStatus->status.parentId.clockID.id[1],
                aCtxStatus->status.parentId.clockID.id[2],
                aCtxStatus->status.parentId.clockID.id[3],
                aCtxStatus->status.parentId.clockID.id[4],
                aCtxStatus->status.parentId.clockID.id[5],
                aCtxStatus->status.parentId.clockID.id[6],
                aCtxStatus->status.parentId.clockID.id[7]);
        (void)MODULE_HostHelperLog("Parent Port Id            : %u\n", aCtxStatus->status.parentId.port);

    }
}

/**
    @brief Copy Global Status to Context

    This API Convert the endianness to Native and copy to context

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aStatus            Received Global status
    @param[out]     aCtxStatus         Context status which are Converted

    Return values are documented in reverse-chronological order
    @retval     void

    @post None

    @limitations None

    @trace #BRCM_SWARCH_ETS_HELPER_GLOBAL
    @trace #BRCM_SWREQ_ETS_COMMON

    @code{.unparsed}
    @endcode
*/
static void ETS_CopyGlobalStatusToCtx (ETS_GlobalStatusType *aStatus,
                                       ETS_GlobalStatusType *aCtxStatus)
{
    aCtxStatus->magicId                 = CPU_LEToNative32(aStatus->magicId);
    memcpy(&aCtxStatus->clockId.id[0], &aStatus->clockId.id[0], sizeof(ETS_ClockIdentityType));
    aCtxStatus->networkTime.seconds     = CPU_LEToNative64(aStatus->networkTime.seconds);
    aCtxStatus->networkTime.nanoseconds = CPU_LEToNative32(aStatus->networkTime.nanoseconds);
    aCtxStatus->networkTimeState        = CPU_LEToNative32(aStatus->networkTimeState);
    aCtxStatus->activeDomainNum         = aStatus->activeDomainNum;
}

/**
    @brief Print Global Status from context

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aStats       Context Global status

    Return values are documented in reverse-chronological order
    @retval     void

    @post None

    @limitations None

    @trace #BRCM_SWARCH_ETS_HELPER_GLOBAL
    @trace #BRCM_SWREQ_ETS_COMMON

    @code{.unparsed}
    @endcode
*/
static void ETS_PrintGlobalStatus(ETS_GlobalStatusType *aCtxStatus)
{
    (void)MODULE_HostHelperLog("\n");
    (void)MODULE_HostHelperLog("Local clock id            : %02x:%02x:%02x:%02x:%02x:%02x:%02x:%02x\n",
                                               aCtxStatus->clockId.id[0],
                                               aCtxStatus->clockId.id[1],
                                               aCtxStatus->clockId.id[2],
                                               aCtxStatus->clockId.id[3],
                                               aCtxStatus->clockId.id[4],
                                               aCtxStatus->clockId.id[5],
                                               aCtxStatus->clockId.id[6],
                                               aCtxStatus->clockId.id[7]);

    (void)MODULE_HostHelperLog("BridgeLocalTime           : %" PRIu64 ".%09u\n",
            aCtxStatus->networkTime.seconds, aCtxStatus->networkTime.nanoseconds);
    switch (aCtxStatus->networkTimeState) {
    case ETS_TIMESTATE_SYNC:
        (void)MODULE_HostHelperLog("NetworkTimeState          : Network clock is synced to GM\n");
        break;
    case ETS_TIMESTATE_UNSYNC:
        (void)MODULE_HostHelperLog("NetworkTimeState          : Network clock is not synced to GM\n");
        break;
    case ETS_TIMESTATE_UNCERTAIN:
        (void)MODULE_HostHelperLog("NetworkTimeState          : Network clock is in holdover\n");
        break;
    default:
        (void)MODULE_HostHelperLog("NetworkTimeState          : Invalid\n");
        break;
    }
    (void)MODULE_HostHelperLog("Active domain number      : %u\n", aCtxStatus->activeDomainNum);
}

/**
    @brief Copy Port Status to Context

    This API Convert the endianness to Native and copy to context

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aStatus              Received Port status
    @param[out]     aCtxPortStatus       Context status which are Converted

    Return values are documented in reverse-chronological order
    @retval     void

    @post None

    @limitations None

    @trace #BRCM_SWARCH_ETS_HELPER_GLOBAL
    @trace #BRCM_SWREQ_ETS_COMMON

    @code{.unparsed}
    @endcode
*/
static void ETS_CopyPortStatusToCtx (ETS_PortStatusType *aStatus,
                                     ETS_PortStatusType *aCtxPortStatus)
{
    aCtxPortStatus->magicId                 = CPU_LEToNative32(aStatus->magicId);
    aCtxPortStatus->nbrPropDelay            = CPU_LEToNative32(aStatus->nbrPropDelay);
    aCtxPortStatus->nbrRateRatio            = CPU_LEToNative32(aStatus->nbrRateRatio);
    aCtxPortStatus->isMeasuringPdelay       = CPU_LEToNative32(aStatus->isMeasuringPdelay);
    aCtxPortStatus->isAVnuPdelayConfigSaved = CPU_LEToNative32(aStatus->isAVnuPdelayConfigSaved);
    aCtxPortStatus->currentLogPdelayIntvl   = CPU_LEToNative32(aStatus->currentLogPdelayIntvl);
    memcpy(&aCtxPortStatus->partnerId, &aStatus->partnerId, sizeof(aCtxPortStatus->partnerId));
    aCtxPortStatus->partnerId.port          = CPU_LEToNative16(aCtxPortStatus->partnerId.port);
    aCtxPortStatus->pDelayTxSeqId           = CPU_LEToNative16(aStatus->pDelayTxSeqId);
    aCtxPortStatus->numPdelayRespLost       = CPU_LEToNative32(aStatus->numPdelayRespLost);
    aCtxPortStatus->pDelayReqState          = CPU_LEToNative32(aStatus->pDelayReqState);
    aCtxPortStatus->pDelayRespState         = CPU_LEToNative32(aStatus->pDelayRespState);
    aCtxPortStatus->pDelayT1.seconds        = CPU_LEToNative64(aStatus->pDelayT1.seconds);
    aCtxPortStatus->pDelayT1.nanoseconds    = CPU_LEToNative32(aStatus->pDelayT1.nanoseconds);
    aCtxPortStatus->pDelayT2.seconds        = CPU_LEToNative64(aStatus->pDelayT2.seconds);
    aCtxPortStatus->pDelayT2.nanoseconds    = CPU_LEToNative32(aStatus->pDelayT2.nanoseconds);
    aCtxPortStatus->pDelayT3.seconds        = CPU_LEToNative64(aStatus->pDelayT3.seconds);
    aCtxPortStatus->pDelayT3.nanoseconds    = CPU_LEToNative32(aStatus->pDelayT3.nanoseconds);
    aCtxPortStatus->pDelayT4.seconds        = CPU_LEToNative64(aStatus->pDelayT4.seconds);
    aCtxPortStatus->pDelayT4.nanoseconds    = CPU_LEToNative32(aStatus->pDelayT4.nanoseconds);
    aCtxPortStatus->asCapableAcrossDomains  = CPU_LEToNative32(aStatus->asCapableAcrossDomains);
}

/**
    @brief Print Port Status from context

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aCtxPortStatus       Context Port status

    Return values are documented in reverse-chronological order
    @retval     void

    @post None

    @limitations None

    @trace #BRCM_SWARCH_ETS_HELPER_GLOBAL
    @trace #BRCM_SWREQ_ETS_COMMON

    @code{.unparsed}
    @endcode
*/
static void ETS_PrintPortStatus(ETS_PortStatusType *aCtxPortStatus)
{
    (void)MODULE_HostHelperLog("\n");
    (void)MODULE_HostHelperLog("Peer delay                : %d\n", aCtxPortStatus->nbrPropDelay);
    (void)MODULE_HostHelperLog("Rate ratio                : 0x%08x\n", aCtxPortStatus->nbrRateRatio);
    (void)MODULE_HostHelperLog("Is measuring delay        : %s\n", aCtxPortStatus->isMeasuringPdelay ? "True" : "False");
    (void)MODULE_HostHelperLog("Is AVnu Config Saved      : %u\n", aCtxPortStatus->isAVnuPdelayConfigSaved);
    (void)MODULE_HostHelperLog("Pdelay interval           : %d\n", aCtxPortStatus->currentLogPdelayIntvl);

    (void)MODULE_HostHelperLog("Partner Clock Id          : ");
    (void)MODULE_HostHelperLog("%02x:%02x:%02x:%02x:%02x:%02x:%02x:%02x\n",
            aCtxPortStatus->partnerId.clockID.id[0],
            aCtxPortStatus->partnerId.clockID.id[1],
            aCtxPortStatus->partnerId.clockID.id[2],
            aCtxPortStatus->partnerId.clockID.id[3],
            aCtxPortStatus->partnerId.clockID.id[4],
            aCtxPortStatus->partnerId.clockID.id[5],
            aCtxPortStatus->partnerId.clockID.id[6],
            aCtxPortStatus->partnerId.clockID.id[7]);

    (void)MODULE_HostHelperLog("Partner Port Id           : %u\n", aCtxPortStatus->partnerId.port);
    (void)MODULE_HostHelperLog("Pdelay Sequence Number    : %u\n", aCtxPortStatus->pDelayTxSeqId);
    (void)MODULE_HostHelperLog("Number of lost responses  : %u\n", aCtxPortStatus->numPdelayRespLost);
    (void)MODULE_HostHelperLog("Peer delay request state  : %d\n", aCtxPortStatus->pDelayReqState);
    (void)MODULE_HostHelperLog("Peer delay response state : %d\n", aCtxPortStatus->pDelayRespState);
    (void)MODULE_HostHelperLog("PDelay Timestamp T1       : %" PRIu64 ".%09u\n", aCtxPortStatus->pDelayT1.seconds, aCtxPortStatus->pDelayT1.nanoseconds);
    (void)MODULE_HostHelperLog("PDelay Timestamp T2       : %" PRIu64 ".%09u\n", aCtxPortStatus->pDelayT2.seconds, aCtxPortStatus->pDelayT2.nanoseconds);
    (void)MODULE_HostHelperLog("PDelay Timestamp T3       : %" PRIu64 ".%09u\n", aCtxPortStatus->pDelayT3.seconds, aCtxPortStatus->pDelayT3.nanoseconds);
    (void)MODULE_HostHelperLog("PDelay Timestamp T4       : %" PRIu64 ".%09u\n", aCtxPortStatus->pDelayT4.seconds, aCtxPortStatus->pDelayT4.nanoseconds);
    (void)MODULE_HostHelperLog("asCapable across domains  : %u\n", aCtxPortStatus->asCapableAcrossDomains);
}

/**
    @brief Prepare ETS Admin Mode context

    @trace #BRCM_SWARCH_ETS_HELPER_GLOBAL
    @trace #BRCM_SWREQ_ETS_COMMON

    @code{.unparsed}
    @endcode
*/
static int32_t ETS_AdminModePrepCtxInt(char          *aStr,
                                       uint32_t      aStrLen,
                                       ETS_HelperCtxType *aCtx)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
    if ((remStr != NULL) && (remStrLen != 0)) {
        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        if ((remStr == NULL) && (remStrLen == 0)) {
            if ((!strncmp(currStr, "enable", 6)) || (!strncmp(currStr, "disable", 7))) {
                if(!strncmp(currStr, "enable", 6)) {
                    aCtx->ctx.msg.globalEnable = TRUE;
                } else {
                    aCtx->ctx.msg.globalEnable = FALSE;
                }
                aCtx->ctx.id = ETS_CMD_SETGLOBALENABLE;
                retVal = BCM_ERR_OK;
            }
        }
    }

return retVal;
}

/**
    @brief ETS Set Admin Mode Host Handler

    @trace #BRCM_SWARCH_ETS_HELPER_GLOBAL
    @trace #BRCM_SWREQ_ETS_COMMON

    @code{.unparsed}
    @endcode
*/
int32_t ETS_AdminModeHdlr(BCM_CmdType    *aMsg,
                          uint8_t       *aBuff,
                          uint32_t       aInputLen,
                          uint32_t      *aOutLen,
                          uint32_t       aMaxLength,
                          int32_t        aResponse,
                          ETS_HelperCtxType *aCtx)
{
    int32_t retVal = BCM_ERR_UNKNOWN;
    ETS_MsgUnionType cmdMsg;

    BCM_MemCpy(cmdMsg.data, aBuff, aInputLen);
    switch(aCtx->modCtx.substate) {
        case BCM_STATE_SUB_STATE_STAGE0:
            cmdMsg.globalEnable = CPU_NativeToLE32(aCtx->ctx.msg.globalEnable);
            *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_ETS_ID, ETS_CMD_SETGLOBALENABLE);
            *aOutLen = sizeof(aCtx->ctx.msg.globalEnable);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            retVal = BCM_ERR_OK;
            break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("ets global admin mode set failed, ret = %d\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            }else {
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
    @brief Prepare ETS Get Stats context

    @trace #BRCM_SWARCH_ETS_HELPER_GLOBAL
    @trace #BRCM_SWREQ_ETS_COMMON

    @code{.unparsed}
    @endcode
*/
static int32_t ETS_GetStatsCtxInt (char          *aStr,
                                   uint32_t      aStrLen,
                                   ETS_HelperCtxType *aCtx)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    int32_t  parseStatus = 0;
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
    if ((remStr != NULL) && (remStrLen != 0)) {
        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        memset(&aCtx->ctx.msg.domainPortStatus, 0U, sizeof(ETS_PerDomainPortStatusType));
        aCtx->ctx.msg.domainPortStatus.portNum = MODULE_MsgParseInt(currStr, &parseStatus); /* port */
        if(BCM_ERR_OK != parseStatus) {
            goto done;
        }
        /* Updated incase of domain is also requested */
        aCtx->ctx.msg.domainPortStatus.domain = 0UL;
        if ((remStr != NULL) && (remStrLen != 0)) {
            currStr = remStr;
            currStrLen = remStrLen;
            MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
            aCtx->ctx.msg.domainPortStatus.domain = MODULE_MsgParseInt(currStr, &parseStatus); /* domain number*/
            if(BCM_ERR_OK == parseStatus) {
                if ((remStr != NULL) || (remStrLen != 0)) {
                    goto done;
                }
            }
        }
        /* 'isPortStats' is set to TRUE to indicate the request is for status */
        aCtx->isPortStats = TRUE;
        aCtx->ctx.id = ETS_CMD_GETDOMAINPORTSTATUS;
        retVal = BCM_ERR_OK;
    }

done:
    return retVal;
}

/**
    @brief ETS Get Stats Handler

    @trace #BRCM_SWARCH_ETS_HELPER_GLOBAL
    @trace #BRCM_SWREQ_ETS_COMMON

    @code{.unparsed}
    @endcode
*/
int32_t ETS_GetStatsHdlr(BCM_CmdType    *aMsg,
                         uint8_t       *aBuff,
                         uint32_t       aInputLen,
                         uint32_t      *aOutLen,
                         uint32_t       aMaxLength,
                         int32_t        aResponse,
                         ETS_HelperCtxType *aCtx)
{
    int32_t retVal = BCM_ERR_UNKNOWN;
    ETS_MsgUnionType cmdMsg;
    ETS_MsgUnionType respMsg;

    BCM_MemCpy(cmdMsg.data, aBuff, aInputLen);
    BCM_MemCpy(respMsg.data, aBuff, aInputLen);
    switch(aCtx->modCtx.substate) {
        case BCM_STATE_SUB_STATE_STAGE0:
            cmdMsg.domainPortStatus.portNum = CPU_NativeToLE32(aCtx->ctx.msg.domainPortStatus.portNum);
            cmdMsg.domainPortStatus.domain = aCtx->ctx.msg.domainPortStatus.domain;
            *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_ETS_ID, ETS_CMD_GETDOMAINPORTSTATUS);
            *aOutLen = sizeof(ETS_PerDomainPortStatusType);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            retVal = BCM_ERR_OK;
            break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                if(TRUE == aCtx->isPortStats) {
                    /* PORT STATISTICS */
                    (void)MODULE_HostHelperLog("ets stats get  failed, retVal = %d\n",
                                                              aResponse);
                } else {
                    /* PORT STATUS */
                    (void)MODULE_HostHelperLog("Error: Could not get ets port status, retVal = %d\n",
                                                              aResponse);
                }
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(ETS_PerDomainPortStatusType))) {
                (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                retVal = BCM_ERR_UNKNOWN;
            } else {
                if(TRUE == aCtx->isPortStats) {
                    /* PORT STATISTICS */
                    ETS_CopyPortStatsToCtx(&respMsg.domainPortStatus, &aCtx->ctx.msg.domainPortStatus);
                    ETS_PrintPortStats(&aCtx->ctx.msg.domainPortStatus.stats);
                }    else {
                    /* PORT STATUS */
                    ETS_CopyStatusToCtx(&respMsg.domainPortStatus, &aCtx->ctx.msg.domainPortStatus);
                    ETS_PrintStatus(&aCtx->ctx.msg.domainPortStatus.status);
                }
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
    @brief Prepare ETS Clear Stats context

    @trace #BRCM_SWARCH_ETS_HELPER_GLOBAL
    @trace #BRCM_SWREQ_ETS_COMMON

    @code{.unparsed}
    @endcode
*/
static int32_t ETS_ClearStatsCtxInt(char          *aStr,
                                        uint32_t      aStrLen,
                                        ETS_HelperCtxType *aCtx)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    int32_t  parseStatus = 0;
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
    if ((remStr != NULL) && (remStrLen != 0)) {
        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        aCtx->ctx.msg.domainPortStatus.portNum = MODULE_MsgParseInt(currStr, &parseStatus); /* port */
        if(BCM_ERR_OK != parseStatus) {
            goto done;
        }
        /* Update incase of domain is also requested only */
        aCtx->ctx.msg.domainPortStatus.domain = 0UL;
        if ((remStr != NULL) && (remStrLen != 0)) {
            currStr = remStr;
            currStrLen = remStrLen;
            MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
            aCtx->ctx.msg.domainPortStatus.domain  = MODULE_MsgParseInt(currStr, &parseStatus); /* domain number*/
            if(BCM_ERR_OK == parseStatus) {
                if ((remStr != NULL) || (remStrLen != 0)) {
                    goto done;
                }
            }
        }
        aCtx->ctx.id = ETS_CMD_RESETSTATS;
        retVal = BCM_ERR_OK;
    }

done:
    return retVal;
}

/**
    @brief ETS Clear Stats Handler

    @trace #BRCM_SWARCH_ETS_HELPER_GLOBAL
    @trace #BRCM_SWREQ_ETS_COMMON

    @code{.unparsed}
    @endcode
*/
int32_t ETS_ClearStatsHdlr(BCM_CmdType    *aMsg,
                           uint8_t       *aBuff,
                           uint32_t       aInputLen,
                           uint32_t      *aOutLen,
                           uint32_t       aMaxLength,
                           int32_t        aResponse,
                           ETS_HelperCtxType *aCtx)
{
    int32_t retVal = BCM_ERR_UNKNOWN;
    ETS_MsgUnionType cmdMsg;

    BCM_MemCpy(cmdMsg.data, aBuff, aInputLen);
    switch(aCtx->modCtx.substate) {
        case BCM_STATE_SUB_STATE_STAGE0:
            cmdMsg.domainPortStatus.portNum = CPU_NativeToLE32(aCtx->ctx.msg.domainPortStatus.portNum);
            cmdMsg.domainPortStatus.domain = aCtx->ctx.msg.domainPortStatus.domain;
            *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_ETS_ID, ETS_CMD_RESETSTATS);
            *aOutLen = sizeof(ETS_PerDomainPortStatusType);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            retVal = BCM_ERR_OK;
            break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("ets stats clear  failed, retVal = %d\n",
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

/**
    @brief Prepare ETS Get Status context

    @trace #BRCM_SWARCH_ETS_HELPER_GLOBAL
    @trace #BRCM_SWREQ_ETS_COMMON

    @code{.unparsed}
    @endcode
*/
static int32_t ETS_GetStatusPrepCtxInt(char          *aStr,
                                       uint32_t      aStrLen,
                                       ETS_HelperCtxType *aCtx)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    int32_t  parseStatus = 0;
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
    if ((remStr != NULL) && (remStrLen != 0)) {
        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        memset(&aCtx->ctx.msg.domainStatus, 0U, sizeof(ETS_GlobalStatusType));
        aCtx->ctx.msg.domainStatus.num = MODULE_MsgParseInt(currStr, &parseStatus); /* domain number*/
        if(BCM_ERR_OK == parseStatus) {
            if ((remStr != NULL) || (remStrLen != 0)) {
                goto done;
            }
            aCtx->ctx.id = ETS_CMD_GETDOMAINSTATUS;
            retVal = BCM_ERR_OK;
        }
    } else {
        memset(&aCtx->ctx.msg.globalStatus, 0U, sizeof(ETS_GlobalStatusType));
        aCtx->ctx.id = ETS_CMD_GETGLOBALSTATUS;
        retVal = BCM_ERR_OK;
    }

done:
    return retVal;
}

/**
    @brief ETS Get Domaon Status Handler

    @trace #BRCM_SWARCH_ETS_HELPER_GLOBAL
    @trace #BRCM_SWREQ_ETS_COMMON

    @code{.unparsed}
    @endcode
*/
int32_t ETS_GetDomainStatusHdlr(BCM_CmdType    *aMsg,
                                  uint8_t       *aBuff,
                                  uint32_t       aInputLen,
                                  uint32_t      *aOutLen,
                                  uint32_t       aMaxLength,
                                  int32_t        aResponse,
                                  ETS_HelperCtxType *aCtx)
{
    int32_t retVal = BCM_ERR_UNKNOWN;
    ETS_MsgUnionType cmdMsg;
    ETS_MsgUnionType respMsg;

    BCM_MemCpy(cmdMsg.data, aBuff, aInputLen);
    BCM_MemCpy(respMsg.data, aBuff, aInputLen);
    switch(aCtx->modCtx.substate) {
        case BCM_STATE_SUB_STATE_STAGE0:
            cmdMsg.domainStatus.num = aCtx->ctx.msg.domainStatus.num;
            *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_ETS_ID, ETS_CMD_GETDOMAINSTATUS);
            *aOutLen = sizeof(ETS_DomainNumAndStatusType);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            retVal = BCM_ERR_OK;
            break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Error: Could not get ETS domain Status\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(ETS_DomainNumAndStatusType))) {
                (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                retVal = BCM_ERR_UNKNOWN;
            } else {
                ETS_CopyDomainStatusToCtx(&respMsg.domainStatus, &aCtx->ctx.msg.domainStatus);
                ETS_PrintDomainStatus(&aCtx->ctx.msg.domainStatus);
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
    @brief ETS Get Global Status Handler

    @trace #BRCM_SWARCH_ETS_HELPER_GLOBAL
    @trace #BRCM_SWREQ_ETS_COMMON

    @code{.unparsed}
    @endcode
*/
int32_t ETS_GetGlobalStatusHdlr(BCM_CmdType    *aMsg,
                                  uint8_t       *aBuff,
                                  uint32_t       aInputLen,
                                  uint32_t      *aOutLen,
                                  uint32_t       aMaxLength,
                                  int32_t        aResponse,
                                  ETS_HelperCtxType *aCtx)
{
    int32_t retVal = BCM_ERR_UNKNOWN;
    ETS_MsgUnionType respMsg;
    BCM_MemCpy(respMsg.data, aBuff, aInputLen);
    switch(aCtx->modCtx.substate) {
        case BCM_STATE_SUB_STATE_STAGE0:
            *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_ETS_ID, ETS_CMD_GETGLOBALSTATUS);
            *aOutLen = sizeof(ETS_GlobalStatusType);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            retVal = BCM_ERR_OK;
            break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Error: Could not get ETS Global Status\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(ETS_GlobalStatusType))) {
                (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                retVal = BCM_ERR_UNKNOWN;
            } else {
                ETS_CopyGlobalStatusToCtx(&respMsg.globalStatus, &aCtx->ctx.msg.globalStatus);
                ETS_PrintGlobalStatus(&aCtx->ctx.msg.globalStatus);
                aCtx->modCtx.substate = BCM_STATE_SUB_STATE_DONE;
                retVal = BCM_ERR_OK;
            }
            break;
        default:
            break;
    }

    return retVal;
}

/**
    @brief Prepare ETS Port Status context

    @trace #BRCM_SWARCH_ETS_HELPER_GLOBAL
    @trace #BRCM_SWREQ_ETS_COMMON

    @code{.unparsed}
    @endcode
*/
static int32_t ETS_PortStatusPrepCtxInt(char          *aStr,
                                        int32_t      aStrLen,
                                        ETS_HelperCtxType *aCtx)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    int32_t  parseStatus = 0;
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
    if ((remStr != NULL) && (remStrLen != 0)) {
        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        if ((remStr != NULL) && (remStrLen != 0)) {
            memset(&aCtx->ctx.msg.domainPortStatus, 0U, sizeof(ETS_PerDomainPortStatusType));
            aCtx->ctx.msg.domainPortStatus.portNum = MODULE_MsgParseInt(currStr, &parseStatus); /* port */
            if(BCM_ERR_OK != parseStatus) {
                goto done;
            }
            aCtx->ctx.msg.domainPortStatus.domain = 0UL;

            currStr = remStr;
            currStrLen = remStrLen;
            MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
            aCtx->ctx.msg.domainPortStatus.domain = MODULE_MsgParseInt(currStr, &parseStatus); /* domain number*/
            if(BCM_ERR_OK == parseStatus) {
                if ((remStr != NULL) || (remStrLen != 0)) {
                    goto done;
                }
                /* 'isPortStats' is set to FALSE to indicate the request is for status */
                aCtx->isPortStats = FALSE;
                aCtx->ctx.id = ETS_CMD_GETDOMAINPORTSTATUS;
                retVal = BCM_ERR_OK;
            }
        } else {
            memset(&aCtx->ctx.msg.portStatus, 0U, sizeof(ETS_PerDomainPortStatusType));
            aCtx->ctx.msg.portStatus.num = MODULE_MsgParseInt(currStr, &parseStatus); /* port */
            if(BCM_ERR_OK != parseStatus) {
                goto done;
            }
            aCtx->ctx.id = ETS_CMD_GETPORTSTATUS;
            retVal = BCM_ERR_OK;
        }
    }

done:
    return retVal;
}

/**
    @brief ETS Get Port Status Handler

    @trace #BRCM_SWARCH_ETS_HELPER_GLOBAL
    @trace #BRCM_SWREQ_ETS_COMMON

    @code{.unparsed}
    @endcode
*/
int32_t ETS_PortStatusHdlr(BCM_CmdType    *aMsg,
                           uint8_t       *aBuff,
                           uint32_t       aInputLen,
                           uint32_t      *aOutLen,
                           uint32_t       aMaxLength,
                           int32_t        aResponse,
                           ETS_HelperCtxType *aCtx)
{
    int32_t retVal = BCM_ERR_UNKNOWN;
    ETS_MsgUnionType cmdMsg;
    ETS_MsgUnionType respMsg;

    BCM_MemCpy(cmdMsg.data, aBuff, aInputLen);
    BCM_MemCpy(respMsg.data, aBuff, aInputLen);
    switch(aCtx->modCtx.substate) {
        case BCM_STATE_SUB_STATE_STAGE0:
            cmdMsg.portStatus.num = CPU_NativeToLE32(aCtx->ctx.msg.portStatus.num);
            *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_ETS_ID, ETS_CMD_GETPORTSTATUS);
            *aOutLen = sizeof(ETS_PortNumAndStatusType);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            retVal = BCM_ERR_OK;
            break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Error: Could not get ets port status\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(ETS_PortNumAndStatusType))) {
                (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                retVal = BCM_ERR_UNKNOWN;
            } else {
                ETS_CopyPortStatusToCtx(&respMsg.portStatus.status, &aCtx->ctx.msg.portStatus.status);
                ETS_PrintPortStatus(&aCtx->ctx.msg.portStatus.status);
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
    @brief Prepare ETS Port Enable context

    @trace #BRCM_SWARCH_ETS_HELPER_GLOBAL
    @trace #BRCM_SWREQ_ETS_COMMON

    @code{.unparsed}
    @endcode
*/
static int32_t ETS_PortEnableCtxInt(char          *aStr,
                                    uint32_t      aStrLen,
                                    ETS_HelperCtxType *aCtx)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    int32_t  parseStatus = 0;
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
    if ((remStr != NULL) && (remStrLen != 0)) {

        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);

        aCtx->ctx.msg.portEnable.num = MODULE_MsgParseInt(currStr, &parseStatus); /* port number */
        if(BCM_ERR_OK != parseStatus) {
            goto done;
        }

        if ((remStr != NULL) && (remStrLen != 0)) {
            currStr = remStr;
            currStrLen = remStrLen;
            MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);

            if (!strncmp(currStr, "true", 4)){
                aCtx->ctx.msg.portEnable.portEnable = TRUE;
            } else if (!strncmp(currStr, "false", 5)){
                aCtx->ctx.msg.portEnable.portEnable = FALSE;
            } else {
                (void)MODULE_HostHelperLog("ets portenable <port> <true|false> [domain]\n");
                goto done;
            }

            if ((remStr != NULL) && (remStrLen != 0)) {
                currStr = remStr;
                currStrLen = remStrLen;
                MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);

                aCtx->ctx.msg.portEnable.domain = MODULE_MsgParseInt(currStr, &parseStatus); /* domain number */
                if(BCM_ERR_OK != parseStatus) {
                    goto done;
                }
            }
            aCtx->ctx.id = ETS_CMD_SETPORTENABLE;
            retVal = BCM_ERR_OK;
        }
    }

done:
    return retVal;
}

/**
    @brief ETS Port Enable control Handler

    @trace #BRCM_SWARCH_ETS_HELPER_GLOBAL
    @trace #BRCM_SWREQ_ETS_COMMON

    @code{.unparsed}
    @endcode
*/
int32_t ETS_PortEnableHdlr(BCM_CmdType    *aMsg,
                           uint8_t       *aBuff,
                           uint32_t       aInputLen,
                           uint32_t      *aOutLen,
                           uint32_t       aMaxLength,
                           int32_t        aResponse,
                           ETS_HelperCtxType *aCtx)
{
    int32_t retVal = BCM_ERR_UNKNOWN;
    ETS_MsgUnionType cmdMsg;

    BCM_MemCpy(cmdMsg.data, aBuff, aInputLen);
    switch(aCtx->modCtx.substate) {
        case BCM_STATE_SUB_STATE_STAGE0:
            cmdMsg.portEnable.num = CPU_NativeToLE32(aCtx->ctx.msg.portEnable.num);
            cmdMsg.portEnable.portEnable = CPU_NativeToLE32(aCtx->ctx.msg.portEnable.portEnable);
            cmdMsg.portEnable.domain = aCtx->ctx.msg.portEnable.domain;
            *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_ETS_ID, ETS_CMD_SETPORTENABLE);
            *aOutLen = sizeof(ETS_PortEnableType);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            retVal = BCM_ERR_OK;
            break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Error in configuring port enable, ret = %d \n",
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

/**
    @brief Prepare ETS Set Time context

    @trace #BRCM_SWARCH_ETS_HELPER_GLOBAL
    @trace #BRCM_SWREQ_ETS_COMMON

    @code{.unparsed}
    @endcode
*/
static int32_t ETS_SetTimeCtxInt(char          *aStr,
                                 uint32_t      aStrLen,
                                 ETS_HelperCtxType *aCtx)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    int32_t  parseStatus = 0;
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
    if ((remStr != NULL) && (remStrLen != 0)) {
        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);

        if (!strncmp(currStr, "set", 3)) {
            if ((remStr != NULL) && (remStrLen != 0)) {
                currStr = remStr;
                currStrLen = remStrLen;
                MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
                aCtx->ctx.msg.time.seconds  = MODULE_MsgParseInt(currStr, &parseStatus); /* sec_low32 */
                if(BCM_ERR_OK != parseStatus) {
                    goto done;
                }
                if ((remStr != NULL) && (remStrLen != 0)) {
                    currStr = remStr;
                    currStrLen = remStrLen;
                    MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);

                    aCtx->ctx.msg.time.nanoseconds = MODULE_MsgParseInt(currStr, &parseStatus); /* nanosec */
                    if(BCM_ERR_OK != parseStatus) {
                        goto done;
                    }
                    if ((remStr == NULL) && (remStrLen == 0)) {
                        aCtx->ctx.id = ETS_CMD_SETGLOBALTIME;
                        retVal = BCM_ERR_OK;
                    }
                }
            }
        }
    }

done:
    return retVal;
}

/**
    @brief ETS Set Time Handler

    @trace #BRCM_SWARCH_ETS_HELPER_GLOBAL
    @trace #BRCM_SWREQ_ETS_COMMON

    @code{.unparsed}
    @endcode
*/
int32_t ETS_SetTimeHdlr(BCM_CmdType    *aMsg,
                        uint8_t       *aBuff,
                        uint32_t       aInputLen,
                        uint32_t      *aOutLen,
                        uint32_t       aMaxLength,
                        int32_t        aResponse,
                        ETS_HelperCtxType *aCtx)
{
    int32_t retVal = BCM_ERR_UNKNOWN;
    ETS_MsgUnionType cmdMsg;

    BCM_MemCpy(cmdMsg.data, aBuff, aInputLen);
    switch(aCtx->modCtx.substate) {
        case BCM_STATE_SUB_STATE_STAGE0:
            cmdMsg.time.seconds = CPU_NativeToLE64(aCtx->ctx.msg.time.seconds);
            cmdMsg.time.nanoseconds = CPU_NativeToLE32(aCtx->ctx.msg.time.nanoseconds);
            *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_ETS_ID, ETS_CMD_SETGLOBALTIME);
            *aOutLen = sizeof(ETS_TimeType);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            retVal = BCM_ERR_OK;
            break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("ets time set failed, retVal = %d\n",
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

/**
    @brief Prepare ETS Records control context

    @trace #BRCM_SWARCH_ETS_HELPER_GLOBAL
    @trace #BRCM_SWREQ_ETS_COMMON

    @code{.unparsed}
    @endcode
*/
static int32_t ETS_RecordsCtrlCtxInt(char          *aStr,
                                      uint32_t      aStrLen,
                                      ETS_HelperCtxType *aCtx)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    aCtx->ctx.msg.isNotifyingRecord = !strncmp(aStr, "start", 5);
    MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
    if ((remStr != NULL) && (remStrLen != 0)) {
        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        if (!strncmp(currStr, "notification", 11)) {
            if ((remStr == NULL) && (remStrLen == 0)) {
                aCtx->ctx.id = ETS_CMD_NOTIFY_RECORD;
                retVal = BCM_ERR_OK;
            }
        }
    }

    return retVal;
}

/**
    @brief ETS Records control Handler

    @trace #BRCM_SWARCH_ETS_HELPER_GLOBAL
    @trace #BRCM_SWREQ_ETS_COMMON

    @code{.unparsed}
    @endcode
*/
int32_t ETS_RecordsCtrlHdlr(BCM_CmdType    *aMsg,
                            uint8_t       *aBuff,
                            uint32_t       aInputLen,
                            uint32_t      *aOutLen,
                            uint32_t       aMaxLength,
                            int32_t        aResponse,
                            ETS_HelperCtxType *aCtx)
{
    int32_t retVal = BCM_ERR_UNKNOWN;
    ETS_MsgUnionType cmdMsg;

    BCM_MemCpy(cmdMsg.data, aBuff, aInputLen);
    switch(aCtx->modCtx.substate) {
        case BCM_STATE_SUB_STATE_STAGE0:
            cmdMsg.isNotifyingRecord = CPU_NativeToLE32(aCtx->ctx.msg.isNotifyingRecord);
            *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_ETS_ID, ETS_CMD_NOTIFY_RECORD);
            *aOutLen = sizeof(cmdMsg.isNotifyingRecord);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            retVal = BCM_ERR_OK;
            break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                if(FALSE == aCtx->ctx.msg.isNotifyingRecord) {
                    (void)MODULE_HostHelperLog("ets stop notification failed, retVal = %d\n",
                                                              aResponse);
                } else {
                    (void)MODULE_HostHelperLog("ets start notification failed, retVal = %d\n",
                                                              aResponse);
                }
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

/**
    @brief Prepare ETS Helper context

    @trace #BRCM_SWARCH_ETS_HELPER_GLOBAL
    @trace #BRCM_SWREQ_ETS_COMMON

    @code{.unparsed}
    @endcode
*/
int32_t ETS_HelperPrepCtx(char          *aStr,
                          uint32_t      *aStrLen,
                          ETS_HelperCtxType *aCtx)

{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    if(NULL != aStr) {
        currStr = aStr;
        currStrLen = *aStrLen;
        /* skip the first string which is validated in the above layer */
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        if ((remStr != NULL) && (remStrLen > 1UL)) {
            if (!strncmp(remStr, "admin_mode", 10)) {
                retVal = ETS_AdminModePrepCtxInt(remStr, remStrLen, aCtx);
            } else if (!strncmp(remStr, "stats", 5)) {
                retVal = ETS_GetStatsCtxInt(remStr, remStrLen, aCtx);
            } else if (!strncmp(remStr, "clearstats", 10)) {
                retVal = ETS_ClearStatsCtxInt(remStr, remStrLen, aCtx);
            } else if (!strncmp(remStr, "status", 6)) {
                retVal = ETS_GetStatusPrepCtxInt(remStr, remStrLen, aCtx);
            } else if (!strncmp(remStr, "portstatus", 10)) {
                retVal = ETS_PortStatusPrepCtxInt(remStr, remStrLen, aCtx);
            } else if (!strncmp(remStr, "portenable", 9)) {
                retVal = ETS_PortEnableCtxInt(remStr, remStrLen, aCtx);
            } else if (!strncmp(remStr, "time", 4)) {
                retVal = ETS_SetTimeCtxInt(remStr, remStrLen, aCtx);
            } else if ((!strncmp(remStr, "start", 5)) || (!strncmp(remStr, "stop", 4))) {
                retVal = ETS_RecordsCtrlCtxInt(remStr, remStrLen, aCtx);
            } else {
                retVal = BCM_ERR_INVAL_PARAMS;
            }
        } else {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
    }

    return retVal;
}

/** @brief Process ETS request string or response byte array

    @trace #BRCM_SWARCH_ETS_HELPER_GLOBAL
    @trace #BRCM_SWREQ_ETS_COMMON

    @code{.unparsed}
    @endcode
*/
static int32_t ETS_HelperProcess(BCM_CmdType    *aMsg,
                                  char          *aStr,
                                  uint32_t      *aStrLen,
                                  uint8_t       *aInOut,
                                  uint32_t       aInputLen,
                                  uint32_t      *aOutLen,
                                  uint32_t       aMaxLength,
                                  int32_t        aResponse)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    if(BCM_STATE_SUB_STATE_RESET == ETS_HelperCtx.modCtx.substate) {
        retVal = ETS_HelperPrepCtx(aStr, aStrLen,
                                          &ETS_HelperCtx);
        if(BCM_ERR_OK ==retVal) {
            ETS_HelperCtx.modCtx.substate = BCM_STATE_SUB_STATE_STAGE0;
        }
    }

    switch(ETS_HelperCtx.ctx.id) {
        case ETS_CMD_SETGLOBALENABLE:
            retVal = ETS_AdminModeHdlr(aMsg, aInOut, aInputLen,
                                       aOutLen, aMaxLength, aResponse,
                                       &ETS_HelperCtx);
            break;
        case ETS_CMD_GETDOMAINPORTSTATUS:
            retVal = ETS_GetStatsHdlr(aMsg, aInOut, aInputLen,
                                      aOutLen, aMaxLength, aResponse,
                                      &ETS_HelperCtx);
            break;
        case ETS_CMD_RESETSTATS:
            retVal = ETS_ClearStatsHdlr(aMsg, aInOut, aInputLen,
                                        aOutLen, aMaxLength, aResponse,
                                        &ETS_HelperCtx);
            break;
        case ETS_CMD_GETDOMAINSTATUS:
            retVal = ETS_GetDomainStatusHdlr(aMsg, aInOut, aInputLen,
                                             aOutLen, aMaxLength, aResponse,
                                             &ETS_HelperCtx);
            break;
        case ETS_CMD_GETGLOBALSTATUS:
            retVal = ETS_GetGlobalStatusHdlr(aMsg, aInOut, aInputLen,
                                             aOutLen, aMaxLength, aResponse,
                                             &ETS_HelperCtx);
            break;
        case ETS_CMD_GETPORTSTATUS:
            retVal = ETS_PortStatusHdlr(aMsg, aInOut, aInputLen,
                                        aOutLen, aMaxLength, aResponse,
                                        &ETS_HelperCtx);
            break;
        case ETS_CMD_SETPORTENABLE:
            retVal = ETS_PortEnableHdlr(aMsg, aInOut, aInputLen,
                                        aOutLen, aMaxLength, aResponse,
                                        &ETS_HelperCtx);
            break;
        case ETS_CMD_SETGLOBALTIME:
            retVal = ETS_SetTimeHdlr(aMsg, aInOut, aInputLen,
                                     aOutLen, aMaxLength, aResponse,
                                     &ETS_HelperCtx);
            break;
        case ETS_CMD_NOTIFY_RECORD:
            retVal = ETS_RecordsCtrlHdlr(aMsg, aInOut, aInputLen,
                                         aOutLen, aMaxLength, aResponse,
                                         &ETS_HelperCtx);
            break;
        default:
            break;
    }

    return retVal;
}

/**
    @brief ETS Records cache Handler

    @trace #BRCM_SWARCH_ETS_HELPER_GLOBAL
    @trace #BRCM_SWREQ_ETS_COMMON

    @code{.unparsed}
    @endcode
*/
int32_t ETS_RecordsCacheHdlr(BCM_CmdType   *aMsg,
                             uint8_t       *aBuff,
                             uint32_t       aInputLen,
                             uint32_t      *aOutLen,
                             uint32_t       aMaxLength,
                             int32_t        aResponse,
                             ETS_HelperCtxType *aCtx)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;
    uint32_t portIdx;
    uint32_t i;
    uint32_t validRecords;
    uint32_t msgIdx;
    uint32_t flag;
    uint32_t portAndRecNum;
    uint8_t notificationId;
    ETS_MsgUnionType respMsg;

    if (NULL != aMsg) {
        BCM_MemCpy(respMsg.data, aBuff, aInputLen);
        if (0UL != (*aMsg & BCM_CMD_ASYNC_MASK)) {
            notificationId = BCM_GET_CMDID(*aMsg);

            if(ETS_EVENT_IF_RECORD == notificationId) {
                validRecords = CPU_LEToNative32(respMsg.records.numRecords);
                for (i = 0UL; i < validRecords; ++i) {
                    /* Cache the latest record for each port */
                    portAndRecNum = CPU_LEToNative32(respMsg.records.records[i].portAndRecNum);
                    portIdx = (portAndRecNum & ETS_RECORDDEFS_PORT_NUM_MASK) >> ETS_RECORDDEFS_PORT_NUM_SHIFT;
                    if (portIdx >= ETS_HOST_MAX_PORTS) {
                        retVal = BCM_ERR_INVAL_PARAMS;
                        (void)MODULE_HostHelperLog("%s :: portIdx is: %lu , which is greater than max allowed value: %lu \n",
                                __FUNCTION__, portIdx, (ETS_HOST_MAX_PORTS - 1UL));
                    } else {
                        flag = CPU_LEToNative32(respMsg.records.records[i].flag);
                        retVal = ETS_HostMsgToIndex((flag & ETS_RECORDDEFS_PACKET_TYPE_MASK) >> ETS_RECORDDEFS_PACKET_TYPE_SHIFT,
                                                                                                                        &msgIdx);
                        if (retVal != BCM_ERR_OK) {
                            (void)MODULE_HostHelperLog("%s :: msgIdx invalid: %lu\n", __FUNCTION__, msgIdx);
                        } else {
                            ETS_HelperCtx.record[portIdx][msgIdx].gmTime.s             = CPU_LEToNative32(respMsg.records.records[i].gmTime.s);
                            ETS_HelperCtx.record[portIdx][msgIdx].gmTime.ns            = CPU_LEToNative32(respMsg.records.records[i].gmTime.ns);
                            ETS_HelperCtx.record[portIdx][msgIdx].localTime.s          = CPU_LEToNative32(respMsg.records.records[i].localTime.s);
                            ETS_HelperCtx.record[portIdx][msgIdx].localTime.ns         = CPU_LEToNative32(respMsg.records.records[i].localTime.ns);
                            ETS_HelperCtx.record[portIdx][msgIdx].followupTimestamp.s  = CPU_LEToNative32(respMsg.records.records[i].followupTimestamp.s);
                            ETS_HelperCtx.record[portIdx][msgIdx].followupTimestamp.ns = CPU_LEToNative32(respMsg.records.records[i].followupTimestamp.ns);
                            ETS_HelperCtx.record[portIdx][msgIdx].portAndRecNum        = portAndRecNum;
                            ETS_HelperCtx.record[portIdx][msgIdx].flag                 = flag;
                            ETS_HelperCtx.record[portIdx][msgIdx].srcPortIdentity.port = CPU_LEToNative16(respMsg.records.records[i].srcPortIdentity.port);
                            memcpy(ETS_HelperCtx.record[portIdx][msgIdx].srcPortIdentity.clockID.id,
                                    respMsg.records.records[i].srcPortIdentity.clockID.id,
                                              sizeof(ETS_ClockIdentityType));
                            ETS_HelperCtx.record[portIdx][msgIdx].pDelay               = CPU_LEToNative32(respMsg.records.records[i].pDelay);
                            ETS_HelperCtx.record[portIdx][msgIdx].deltaCorrectionTime  = CPU_LEToNative64(respMsg.records.records[i].deltaCorrectionTime);
                        }
                    }
                }
            }
        }
    }

return retVal;
}

/** @brief ETS Print Helper

    Print ETS Responses

    @trace #BRCM_SWARCH_ETS_HELPER_GLOBAL
    @trace #BRCM_SWREQ_ETS_COMMON

    @code{.unparsed}
    @endcode
*/
static int32_t ETS_PrintHelper(BCM_CmdType    aCmd,
                               uint8_t *aMsg, uint32_t aSize)
{
    int32_t retVal = BCM_ERR_UNKNOWN;
    uint8_t notificationId;
    uint32_t i;
    ETS_MsgType pktType;
    ETS_RecordType record[ETS_NUM_RECORDS_PER_PORT];
    ETS_MsgUnionType respMsg;

    if (NULL != aMsg) {
        if (0UL != (aCmd & BCM_CMD_ASYNC_MASK)) {
            notificationId = BCM_GET_CMDID(aCmd);
            BCM_MemCpy(respMsg.data, aMsg, aSize);

            switch (notificationId) {
            case ETS_EVENT_IF_UP:
                (void)MODULE_HostHelperLog("ETS Notification: Interface:%u Up\n",  CPU_LEToNative32(respMsg.portNum));
                retVal = BCM_ERR_OK;
                break;
            case ETS_EVENT_IF_DOWN:
                (void)MODULE_HostHelperLog("ETS Notification: Interface:%u Down\n",  CPU_LEToNative32(respMsg.portNum));
                retVal = BCM_ERR_OK;
                break;
            case ETS_EVENT_SYNC:
                (void)MODULE_HostHelperLog("ETS Notification: Sync\n");
                retVal = BCM_ERR_OK;
                break;
            case ETS_EVENT_SYNC_LOST:
                (void)MODULE_HostHelperLog("ETS Notification: Sync Lost\n");
                retVal = BCM_ERR_OK;
                break;
            case ETS_EVENT_IF_LOST_RESP_EXCEEDED:
                (void)MODULE_HostHelperLog("ETS Notification: Interface:%u Lost response exceeded\n",
                         CPU_LEToNative32(respMsg.portNum));
                retVal = BCM_ERR_OK;
                break;
            case ETS_EVENT_IF_LOST_RESP_RECOVERED:
                (void)MODULE_HostHelperLog("ETS Notification: Interface:%u Lost response recovered\n",
                         CPU_LEToNative32(respMsg.portNum));
                retVal = BCM_ERR_OK;
                break;
            case ETS_EVENT_IF_PDELAY_CHANGED:
                (void)MODULE_HostHelperLog("ETS Notification: Interface:%u PDelay changed to %u NBRR 0x%x\n",
                         CPU_LEToNative32(respMsg.pDelayNBRR.port),
                        CPU_LEToNative32(respMsg.pDelayNBRR.pDelay), CPU_LEToNative32(respMsg.pDelayNBRR.nbrr));
                retVal = BCM_ERR_OK;
                break;
            case ETS_EVENT_IF_RECORD:
                /* Print the requested port record */
                if((0UL == aSize) && (0xFFUL != ETS_HelperCtx.ctx.msg.portNum)) {
                    memcpy(record, &ETS_HelperCtx.record[ETS_HelperCtx.ctx.msg.portNum] , (ETS_NUM_RECORDS_PER_PORT * sizeof(ETS_RecordType)));
                    (void)MODULE_HostHelperLog("Port %u ::\n", ETS_HelperCtx.ctx.msg.portNum);
                    for (i = 0UL; i < ETS_NUM_RECORDS_PER_PORT; ++i) {
                        if (((record[i].flag & ETS_RECORDDEFS_IS_VALID_MASK) >> ETS_RECORDDEFS_IS_VALID_SHIFT) == 1UL) {
                            (void)MODULE_HostHelperLog("\n============Record %u==============\n", i);
                            pktType =  (record[i].flag & ETS_RECORDDEFS_PACKET_TYPE_MASK) >> ETS_RECORDDEFS_PACKET_TYPE_SHIFT;
                            (void)MODULE_HostHelperLog("Packet Type            : %lu\n", pktType);
                            (void)MODULE_HostHelperLog("Sequence Number        : %u\n", (record[i].flag  & ETS_RECORDDEFS_SEQ_NUM_MASK) >> ETS_RECORDDEFS_SEQ_NUM_SHIFT);
                            (void)MODULE_HostHelperLog("GM Time                : %lus:%09luns\n", (record[i].gmTime.s),
                                                                        (record[i].gmTime.ns));
                            (void)MODULE_HostHelperLog("Local Time             : %lus:%09luns\n", (record[i].localTime.s),
                                                                        (record[i].localTime.ns));
                            if ((ETS_MSG_PDELAY_RESP == pktType) || (ETS_MSG_PDELAY_RESP_FOLLOWUP == pktType)) {
                                (void)MODULE_HostHelperLog("Followup Timestamp     : %lus:%09luns\n", (record[i].followupTimestamp.s),
                                                                         (record[i].followupTimestamp.ns));
                            }
                            (void)MODULE_HostHelperLog("Source Port Identity   : ");
                            (void)MODULE_HostHelperLog("%02x:%02x:%02x:%02x:%02x:%02x:%02x:%02x:%04x\n",
                                record[i].srcPortIdentity.clockID.id[0], record[i].srcPortIdentity.clockID.id[1],
                                record[i].srcPortIdentity.clockID.id[2], record[i].srcPortIdentity.clockID.id[3],
                                record[i].srcPortIdentity.clockID.id[4], record[i].srcPortIdentity.clockID.id[5],
                                record[i].srcPortIdentity.clockID.id[6], record[i].srcPortIdentity.clockID.id[7],
                                record[i].srcPortIdentity.port);
                            ETS_PrintPortRole((record[i].flag & ETS_RECORDDEFS_ROLE_MASK) >> ETS_RECORDDEFS_ROLE_SHIFT);
                            ETS_PrintGmStatus((record[i].flag & ETS_RECORDDEFS_GM_STATUS_MASK) >> ETS_RECORDDEFS_GM_STATUS_SHIFT);
                            (void)MODULE_HostHelperLog("Record Number          : %u\n", (record[i].portAndRecNum & ETS_RECORDDEFS_NUM_MASK) >> ETS_RECORDDEFS_NUM_SHIFT);
                            (void)MODULE_HostHelperLog("LinkUp Status          : %u\n", (record[i].flag & ETS_RECORDDEFS_IS_LINK_UP_MASK) >> ETS_RECORDDEFS_IS_LINK_UP_SHIFT);
                            (void)MODULE_HostHelperLog("IsTx                   : %u\n", (record[i].flag & ETS_RECORDDEFS_IS_TX_MASK) >> ETS_RECORDDEFS_IS_TX_SHIFT);
                            (void)MODULE_HostHelperLog("pDelay Value           : %u\n", record[i].pDelay);
                            (void)MODULE_HostHelperLog("Delta Correction Time  : %" PRIu64 "\n", record[i].deltaCorrectionTime);
                        }
                    }
                } /* Port Index check */
                retVal = BCM_ERR_OK;
                break;
            default:
                (void)MODULE_HostHelperLog("%s: Invalid parameter notificationId:0x%x size=%d\n",
                    __func__, notificationId, aSize);
                break;
            }
        }
    }

    return retVal;
}

/** @brief ETS Host Setup function

    @trace #BRCM_SWARCH_ETS_HELPER_GLOBAL
    @trace #BRCM_SWREQ_ETS_COMMON

    @code{.unparsed}
    @endcode
*/
int32_t ETS_HostContextSetup(ETS_HostContextType *aContext, ETS_CmdType aCmdID,
                             const ETS_MsgUnionType *aMsgPayload)
{
    return BCM_ERR_NOSUPPORT;
}

/** @brief ETS Host Process function

    @trace #BRCM_SWARCH_ETS_HELPER_GLOBAL
    @trace #BRCM_SWREQ_ETS_COMMON

    @code{.unparsed}
    @endcode
*/
int32_t ETS_HostContextProcess(ETS_HostContextType *aContext, int32_t aResponse,
                               BCM_CmdType aInMsgID, const uint8_t *aInMsgPayload,
                               BCM_CmdType *aOutMsgId, uint8_t *aOutMsgPayload)
{
    return BCM_ERR_NOSUPPORT;
}

/**
    @brief Switch ETS Helper

    @trace #BRCM_SWARCH_ETS_HELPER_GLOBAL
    @trace #BRCM_SWREQ_ETS_COMMON
*/
const MODULE_MsgConverterType ETS_Helper = {
    .groupId = BCM_GROUPID_ETHSRV,
    .compId  = BCM_ETS_ID,
    .helpstr = ETS_HelpCmds,
    .context = &ETS_HelperCtx.modCtx,
    .process = ETS_HelperProcess,
    .print   = ETS_PrintHelper,
};
/** @} */
