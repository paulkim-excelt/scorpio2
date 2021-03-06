/*****************************************************************************
 Copyright 2017-2021 Broadcom Limited.  All rights reserved.

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
#include <string.h>
#include <compiler.h>
#include <bcm_utils.h>
#include <bcm_time.h>
#include <bcm_err.h>
#include <interrupt.h>
#include <ethernet.h>
#include <eth_osil.h>
#include <mcu.h>
#include "eth_cntlr.h"
#include "p1588_rdb.h"
#include "io_rdb.h"
#include "brphy_core_rdb.h"

/**
    @name Ethernet time driver API IDs
    @{
    @brief API IDs for Ethernet time driver
*/
#define BRCM_SWDSGN_ETHER_TIMECONVERTNSECS2TIMESTAMP_MACRO      (0xBA01U)    /**< @brief #ETHER_TIMECONVERTNSECS2TIMESTAMP    */
#define BRCM_SWDSGN_ETHER_TIMECONVERTTIMESTAMP2NSECS_MACRO      (0xBA02U)    /**< @brief #ETHER_TIMECONVERTTIMESTAMP2NSECS    */
#define BRCM_SWDSGN_ETHER_TIMETXCONFWAITQSIZE_MACRO             (0xBA03U)    /**< @brief #ETHER_TIMETXCONFWAITQSIZE           */
#define BRCM_SWDSGN_ETHER_TIMERXTIMESTAMP_MACRO                 (0xBA04U)    /**< @brief #ETHER_TIMERXTIMESTAMP               */
#define BRCM_SWDSGN_ETHER_TIMETXTIMESTAMP_MACRO                 (0xBA05U)    /**< @brief #ETHER_TIMETXTIMESTAMP               */
#define BRCM_SWDSGN_ETHER_TIMEISPORTENABLED_MACRO               (0xBA06U)    /**< @brief #ETHER_TIMEISPORTENABLED             */
#define BRCM_SWDSGN_ETHER_TIMEPORT2HWIDX_MACRO                  (0xBA07U)    /**< @brief #ETHER_TIMEPORT2HWIDX                */
#define BRCM_SWDSGN_ETHER_TIMEPORT2PORTIDX_MACRO                (0xBA08U)    /**< @brief #ETHER_TIMEPORT2PORTIDX              */
#define BRCM_SWDSGN_ETHER_P1588REGS_TYPE                        (0xBA09U)    /**< @brief #ETHER_P1588REGS                     */
#define BRCM_SWDSGN_ETHER_TIMETXCONFWAITQENTRYSTATE_TYPE        (0xBA0AU)    /**< @brief #ETHER_TimeTxConfWaitQEntryStateType */
#define BRCM_SWDSGN_ETHER_TIMETXCONFWAITQENTRY_TYPE             (0xBA0BU)    /**< @brief #ETHER_TimeTxConfWaitQEntryType      */
#define BRCM_SWDSGN_ETHER_TIMETSINFO_TYPE                       (0xBA0CU)    /**< @brief #ETHER_TimeTSInfoType                */
#define BRCM_SWDSGN_ETHER_TIMEPORTINFO_TYPE                     (0xBA0DU)    /**< @brief #ETHER_TimePortInfoType              */
#define BRCM_SWDSGN_ETHER_TIMEP1588INFO_TYPE                    (0xBA0EU)    /**< @brief #ETHER_TimeP1588InfoType             */
#define BRCM_SWDSGN_ETHER_TIMESTATE_TYPE                        (0xBA0FU)    /**< @brief #ETHER_TimeStateType                 */
#define BRCM_SWDSGN_ETHER_TIMERWDATA_TYPE                       (0xBA10U)    /**< @brief #ETHER_TimeRWDataType                */
#define BRCM_SWDSGN_ETHER_P1588HW0PORT0_GLOBAL                  (0xBA11U)    /**< @brief #ETHER_P1588HW0Port0                 */
#define BRCM_SWDSGN_ETHER_P1588HW0PORT1_GLOBAL                  (0xBA12U)    /**< @brief #ETHER_P1588HW0Port1                 */
#define BRCM_SWDSGN_ETHER_P1588HW0PORT2_GLOBAL                  (0xBA13U)    /**< @brief #ETHER_P1588HW0Port2                 */
#define BRCM_SWDSGN_ETHER_P1588HW0PORT3_GLOBAL                  (0xBA14U)    /**< @brief #ETHER_P1588HW0Port3                 */
#define BRCM_SWDSGN_ETHER_P1588HW0PORT4_GLOBAL                  (0xBA15U)    /**< @brief #ETHER_P1588HW0Port4                 */
#define BRCM_SWDSGN_ETHER_P1588HW1PORT0_GLOBAL                  (0xBA16U)    /**< @brief #ETHER_P1588HW1Port0                 */
#define BRCM_SWDSGN_ETHER_P1588HW1PORT1_GLOBAL                  (0xBA17U)    /**< @brief #ETHER_P1588HW1Port1                 */
#define BRCM_SWDSGN_ETHER_P1588HW1PORT2_GLOBAL                  (0xBA18U)    /**< @brief #ETHER_P1588HW1Port2                 */
#define BRCM_SWDSGN_ETHER_P1588HW1PORT3_GLOBAL                  (0xBA19U)    /**< @brief #ETHER_P1588HW1Port3                 */
#define BRCM_SWDSGN_ETHER_P1588HW1PORT4_GLOBAL                  (0xBA1AU)    /**< @brief #ETHER_P1588HW1Port4                 */
#define BRCM_SWDSGN_ETHER_TIMEINITPORTINFO_MACRO                (0xBA1BU)    /**< @brief #ETHER_TIMEINITPORTINFO              */
#define BRCM_SWDSGN_ETHER_TIMEINITP1588HWINFO_MACRO             (0xBA1CU)    /**< @brief #ETHER_TIMEINITP1588HWINFO           */
#define BRCM_SWDSGN_ETHER_TIMERWDATA_GLOBAL                     (0xBA1DU)    /**< @brief #ETHER_TimeRWData                    */
#define BRCM_SWDSGN_ETHER_TIMEHBPOLLTIMEOUT_MACRO               (0xBA1EU)    /**< @brief #ETHER_TIMEHBPOLLTIMEOUT             */
#define BRCM_SWDSGN_ETHER_TIME2COMPLEMENT_MACRO                 (0xBA1FU)    /**< @brief #ETHER_TIME_2_COMPLEMENT             */
#define BRCM_SWDSGN_ETHER_TIMEIO_REGS_GLOBAL                    (0xBA20U)    /**< @brief #ETHER_TIMEIO_REGS                   */
#define BRCM_SWDSGN_ETHER_TIMEREPORTERROR_PROC                  (0xBA21U)    /**< @brief #ETHER_TimeReportError               */
#define BRCM_SWDSGN_ETHER_TIMEGETHBTIME_PROC                    (0xBA22U)    /**< @brief #ETHER_TimeGetHBTime                 */
#define BRCM_SWDSGN_ETHER_TIMEREADTS_PROC                       (0xBA23U)    /**< @brief #ETHER_TimeReadTS                    */
#define BRCM_SWDSGN_ETHER_TIMEFREETXWAITQENTRY_PROC             (0xBA24U)    /**< @brief #ETHER_TimeFreeTxWaitQEntry          */
#define BRCM_SWDSGN_ETHER_TIMERETRIEVESEQTYPE_PROC              (0xBA25U)    /**< @brief #ETHER_TimeRetrieveSeqType           */
#define BRCM_SWDSGN_ETHER_TIMEPARSESEQTYPE_PROC                 (0xBA26U)    /**< @brief #ETHER_TimeParseSeqType              */
#define BRCM_SWDSGN_ETHER_TIMEADDTXCONFWAITQENTRY_PROC          (0xBA27U)    /**< @brief #ETHER_TimeAddTxConfWaitQEntry       */
#define BRCM_SWDSGN_ETHER_TIMEREMOVETXCONFWAITQENTRY_PROC       (0xBA28U)    /**< @brief #ETHER_TimeRemoveTxConfWaitQEntry    */
#define BRCM_SWDSGN_ETHER_TIMEUPDATETXCONFWAITQENTRY_PROC       (0xBA29U)    /**< @brief #ETHER_TimeUpdateTxConfWaitQEntry    */
#define BRCM_SWDSGN_ETHER_TIMEADDGLOBALSYSTIMEDIFF_PROC         (0xBA2AU)    /**< @brief #ETHER_TimeAddGlobalSystimeDiff      */
#define BRCM_SWDSGN_ETHER_TIMEPROCESSTS_PROC                    (0xBA2BU)    /**< @brief #ETHER_TimeProcessTS                 */
#define BRCM_SWDSGN_ETHER_TIMEGENINTERNALSYNC_PROC              (0xBA2CU)    /**< @brief #ETHER_TimeGenInternalSync           */
#define BRCM_SWDSGN_ETHER_TIMEINITSYNCPREP_PROC                 (0xBA2DU)    /**< @brief #ETHER_TimeInitSyncPrep              */
#define BRCM_SWDSGN_ETHER_TIMEINITPREPHBREAD_PROC               (0xBA2EU)    /**< @brief #ETHER_TimeInitPrepHBRead            */
#define BRCM_SWDSGN_ETHER_TIMEINITREADHB_PROC                   (0xBA2FU)    /**< @brief #ETHER_TimeInitReadHB                */
#define BRCM_SWDSGN_ETHER_TIMEINIT1_PROC                        (0xBA30U)    /**< @brief #ETHER_TimeInit1                     */
#define BRCM_SWDSGN_ETHER_TIMEINIT2_PROC                        (0xBA31U)    /**< @brief #ETHER_TimeInit2                     */
#define BRCM_SWDSGN_ETHER_TIMEINTINIT_PROC                      (0xBA32U)    /**< @brief #ETHER_TimeIntInit                   */
#define BRCM_SWDSGN_ETHER_TIMEINITCFGSTATEHANDLER_PROC          (0xBA33U)    /**< @brief #ETHER_TimeInitCfgStateHandler       */
#define BRCM_SWDSGN_ETHER_TIMEINIT0STATEHANDLER_PROC            (0xBA34U)    /**< @brief #ETHER_TimeInit0StateHandler         */
#define BRCM_SWDSGN_ETHER_TIMESYNCPREPSTATEHANDLER_PROC         (0xBA35U)    /**< @brief #ETHER_TimeSyncPrepStateHandler      */
#define BRCM_SWDSGN_ETHER_TIMEPREPHBREADSTATEHANDLER_PROC       (0xBA36U)    /**< @brief #ETHER_TimePrepHBReadStateHandler    */
#define BRCM_SWDSGN_ETHER_TIMEREADHBSTATEHANDLER_PROC           (0xBA37U)    /**< @brief #ETHER_TimeReadHBStateHandler        */
#define BRCM_SWDSGN_ETHER_TIMEINIT1STATEHANDLER_PROC            (0xBA38U)    /**< @brief #ETHER_TimeInit1StateHandler         */
#define BRCM_SWDSGN_ETHER_TIMEINTINITSTATEHANDLER_PROC          (0xBA39U)    /**< @brief #ETHER_TimeIntInitStateHandler       */
#define BRCM_SWDSGN_ETHER_TIMEENABLEEGRESSTS_PROC               (0xBA3AU)    /**< @brief #ETHER_TimeEnableEgressTS            */
#define BRCM_SWDSGN_ETHER_TIMEUPDATEEGRESSPKTINFO_PROC          (0xBA3BU)    /**< @brief #ETHER_TimeUpdateEgressPktInfo       */
#define BRCM_SWDSGN_ETHER_TIMEDISABLEEGRESSTS_PROC              (0xBA3CU)    /**< @brief #ETHER_TimeDisableEgressTS           */
#define BRCM_SWDSGN_ETHER_TIMEGETEGRESSTS_PROC                  (0xBA3DU)    /**< @brief #ETHER_TimeGetEgressTS               */
#define BRCM_SWDSGN_ETHER_TIMEGETINGRESSTS_PROC                 (0xBA3EU)    /**< @brief #ETHER_TimeGetIngressTS              */
#define BRCM_SWDSGN_ETHER_TIMESETTIME_PROC                      (0xBA3FU)    /**< @brief #ETHER_TimeSetTime                   */
#define BRCM_SWDSGN_ETHER_TIMEGETTIME_PROC                      (0xBA40U)    /**< @brief #ETHER_TimeGetTime                   */
#define BRCM_SWDSGN_ETHER_TIMESETCORRECTIONTIME_PROC            (0xBA41U)    /**< @brief #ETHER_TimeSetCorrectionTime         */
#define BRCM_SWDSGN_ETHER_TIMEFRAMESYNCIRQHANDLER_PROC          (0xBA42U)    /**< @brief #ETHER_TimeFrameSyncIRQHandler       */
#define BRCM_SWDSGN_ETHER_TIMEREADTIMEHWSTAMPFIFO_PROC          (0xBA43U)    /**< @brief #ETHER_TimeReadTimeHWStampFIFO       */
#define BRCM_SWDSGN_ETHER_TIMEPACKETTIMESTAMPIRQHANDLER_PROC    (0xBA44U)    /**< @brief #ETHER_TimePacketTimeStampIRQHandler */
#define BRCM_SWDSGN_ETHER_TIMESTAMPIRQHANDLER_PROC              (0xBA45U)    /**< @brief #ETHER_TimestampIRQHandler           */
#define BRCM_SWDSGN_ETHER_TIMECMDHANDLER_PROC                   (0xBA46U)    /**< @brief #ETHER_TimeCmdHandler                */
#define BRCM_SWDSGN_ETHER_TIMESVCIO_TYPE                        (0xBA47U)    /**< @brief #ETHER_TimeSVCIOType                 */
#define BRCM_SWDSGN_ETHER_TIMESYSCMDHANDLER_PROC                (0xBA48U)    /**< @brief #ETHER_TimeSysCmdHandler             */
#define BRCM_SWDSGN_ETHER_TIMEQTIMEOUTS_GLOBAL                  (0xBA49U)    /**< @brief #ETHER_TimeQTimeOuts                 */
/** @} */

/**
 * @trace #BRCM_SWARCH_ETHER_SETCORRECTIONTIME_PROC
 * @trace #BRCM_SWREQ_ETHER_TIME
 */
#define ETHER_TIME_2_COMPLEMENT(x) ((uint16_t)~x + 1U)

/**
 * @trace #BRCM_SWARCH_ETHER_SETTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_SETCORRECTIONTIME_PROC
 * @trace #BRCM_SWREQ_ETHER_TIME
 */
#define ETHER_TIMECONVERTNSECS2TIMESTAMP(_ts, _nsecs) \
        (_ts).seconds     = (_nsecs) / BCM_NS_PER_SEC; \
        (_ts).nanoseconds = (uint32_t)((_nsecs) % BCM_NS_PER_SEC);

/**
 * @trace #BRCM_SWARCH_ETHER_GETTXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_GETRXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_GETTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_SETCORRECTIONTIME_PROC
 * @trace #BRCM_SWREQ_ETHER_TIME
 */
#define ETHER_TIMECONVERTTIMESTAMP2NSECS(_ts, _nsecs) \
        (_nsecs) = (_ts).seconds * (uint64_t)BCM_NS_PER_SEC \
                    + (uint64_t) ((_ts).nanoseconds);

/* FIXME: Increase the Tx conf waitQ size, make it same as the max number
 * of buffers allocated by ethernet controller driver */
/**
 * @trace #BRCM_SWARCH_ETHER_GETTXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_PROCESSTIMESTAMPS_PROC
 * @trace #BRCM_SWARCH_ETHER_GETRXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_GETTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_SETTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_ENABLETXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_SEND_PROC
 * @trace #BRCM_SWARCH_ETHER_TIMEINITSTATEHANDLER_PROC
 * @trace #BRCM_SWARCH_ETHER_SETCORRECTIONTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_TIMESTAMPIRQHANDLER_PROC
 * @trace #BRCM_SWREQ_ETHER_TIME
 */
#define ETHER_TIMETXCONFWAITQSIZE       (16UL)

/**
 * @trace #BRCM_SWARCH_ETHER_GETRXTIMESTAMP_PROC
 * @trace #BRCM_SWREQ_ETHER_TIME
 */
#define ETHER_TIMERXTIMESTAMP 0UL

/**
 * @trace #BRCM_SWARCH_ETHER_GETTXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_PROCESSTIMESTAMPS_PROC
 * @trace #BRCM_SWREQ_ETHER_TIME
 */
#define ETHER_TIMETXTIMESTAMP 1UL

/**
 * @trace #BRCM_SWARCH_ETHER_ENABLETXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_GETTXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_GETRXTIMESTAMP_PROC
 * @trace #BRCM_SWREQ_ETHER_TIME
 */
#define ETHER_TIMEISPORTENABLED(aHwIdx, aPortIdx) \
    (0UL != (ETHER_TimeRWData.portEnMask & (0x1UL << ((8UL * (aHwIdx)) + (aPortIdx)))))

/**
 * @trace #BRCM_SWARCH_ETHER_ENABLETXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_GETTXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_GETRXTIMESTAMP_PROC
 * @trace #BRCM_SWREQ_ETHER_TIME
 */
#define ETHER_TIMEPORT2HWIDX(aPortIdx)        ((0x10UL & (aPortIdx)) >> 4UL)

/**
 * @trace #BRCM_SWARCH_ETHER_ENABLETXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_GETTXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_GETRXTIMESTAMP_PROC
 * @trace #BRCM_SWREQ_ETHER_TIME
 */
#define ETHER_TIMEPORT2PORTIDX(aPortIdx)      (0xFUL & (aPortIdx))

/**
 * @trace #BRCM_SWARCH_ETHER_GETTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_SETTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_TIMEINITSTATEHANDLER_PROC
 * @trace #BRCM_SWARCH_ETHER_TIMESTAMPIRQHANDLER_PROC
 * @trace #BRCM_SWREQ_ETHER_TIME
 */
static P1588_RDBType * const ETHER_P1588REGS[P1588_MAX_TIMEHW_ID] = {
#if (P1588_MAX_TIMEHW_ID == 0UL)
#error "P1588_MAX_TIMEHW_ID == 0UL"
#endif
    (P1588_RDBType *const)P1588_0_BASE,
#if (P1588_MAX_TIMEHW_ID > 1UL)
    (P1588_RDBType *const)P1588_1_BASE,
#endif
#if (P1588_MAX_TIMEHW_ID > 2UL)
#error "P1588_MAX_TIMEHW_ID > 2UL"
#endif
};

/**
 * @{
 * @trace #BRCM_SWARCH_ETHER_GETTXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_PROCESSTIMESTAMPS_PROC
 * @trace #BRCM_SWARCH_ETHER_GETRXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_GETTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_SETTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_ENABLETXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_SEND_PROC
 * @trace #BRCM_SWARCH_ETHER_TIMEINITSTATEHANDLER_PROC
 * @trace #BRCM_SWARCH_ETHER_SETCORRECTIONTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_TIMESTAMPIRQHANDLER_PROC
 * @trace #BRCM_SWREQ_ETHER_TIME
 */
typedef uint32_t ETHER_TimeTxConfWaitQEntryStateType;
#define ETHER_TIMETXCONFWAITQENTRYSTATE_FREE      (0UL) /* @brief Time confimration wait Queue state - Free */
#define ETHER_TIMETXCONFWAITQENTRYSTATE_ALLOC     (1UL) /* @brief Time confimration wait Queue state - Allocated */
#define ETHER_TIMETXCONFWAITQENTRYSTATE_QUEUED    (2UL) /* @brief Time confimration wait Queue state - Queued */
#define ETHER_TIMETXCONFWAITQENTRYSTATE_DEQUEUED  (3UL) /* @brief Time confimration wait Queue state - Dequeued */
/** @} */

/**
 * @brief  Structure to hold one entry of the 1588 transmit confirmation wait queue
 *
 * @trace #BRCM_SWARCH_ETHER_GETTXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_PROCESSTIMESTAMPS_PROC
 * @trace #BRCM_SWARCH_ETHER_GETRXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_GETTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_SETTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_ENABLETXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_SEND_PROC
 * @trace #BRCM_SWARCH_ETHER_TIMEINITSTATEHANDLER_PROC
 * @trace #BRCM_SWARCH_ETHER_SETCORRECTIONTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_TIMESTAMPIRQHANDLER_PROC
 * @trace #BRCM_SWREQ_ETHER_TIME
 */
typedef struct sETHER_TimeTxConfWaitQEntryType {
    uint64_t ts;            /**< @brief Timestamp of system time captured only
                                        to determine time-out */
    uint32_t state;         /**< @brief Indicates state */
    uint32_t p1588Idx;      /**< @brief P1588 identifier */
    uint32_t portIdx;       /**< @brief Transmit port identifier */
    uint32_t bufIdx;        /**< @brief Transmit buffer identifier */
    uint32_t type;          /**< @brief Type of gPTP packet */
    uint16_t seqId;         /**< @brief Sequence number of gPTP packet */
} ETHER_TimeTxConfWaitQEntryType;

/**
 * @trace #BRCM_SWARCH_ETHER_GETTXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_PROCESSTIMESTAMPS_PROC
 * @trace #BRCM_SWARCH_ETHER_GETRXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_GETTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_SETTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_ENABLETXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_SEND_PROC
 * @trace #BRCM_SWARCH_ETHER_TIMEINITSTATEHANDLER_PROC
 * @trace #BRCM_SWARCH_ETHER_SETCORRECTIONTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_TIMESTAMPIRQHANDLER_PROC
 * @trace #BRCM_SWREQ_ETHER_TIME
 */
typedef struct sETHER_TimeTSInfoType {
    uint64_t seconds;    /**< @brief Seconds value of the timestamp */
    uint32_t nanoseconds;/**< @brief Nanoseconds value of the timestamp */
    uint32_t rxtx;       /**< @brief Whether messages was rx or tx */
    uint32_t msgType;    /**< @brief Message type associated with this timestamp */
    uint16_t sequenceId; /**< @brief Sequence ID associated with this timestamp */
} ETHER_TimeTSInfoType;

/**
 * @trace #BRCM_SWARCH_ETHER_GETTXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_PROCESSTIMESTAMPS_PROC
 * @trace #BRCM_SWARCH_ETHER_GETRXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_GETTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_SETTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_ENABLETXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_SEND_PROC
 * @trace #BRCM_SWARCH_ETHER_TIMEINITSTATEHANDLER_PROC
 * @trace #BRCM_SWARCH_ETHER_SETCORRECTIONTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_TIMESTAMPIRQHANDLER_PROC
 * @trace #BRCM_SWREQ_ETHER_TIME
 */
typedef struct sETHER_TimePortInfoType {
    ETHER_TimeTSInfoType  tsInfo[P1588_FIFO_DEPTH];/**< @brief Timestamp FIFO */
    uint8_t             curTSIdx;                /**< @brief Current timestamp index */
    uint32_t            pktTSIntrCnt;            /**< @brief Packet TS interrupt count */
    uint16_t            prevTS0;
    uint16_t            prevTS1;
    uint16_t            prevTS2;
    uint16_t            prevTS3;
    uint16_t            prevTSInfo1;
    uint16_t            prevTSInfo2;
} ETHER_TimePortInfoType;

/**
 * @trace #BRCM_SWARCH_ETHER_GETTXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_PROCESSTIMESTAMPS_PROC
 * @trace #BRCM_SWARCH_ETHER_GETRXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_GETTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_SETTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_ENABLETXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_SEND_PROC
 * @trace #BRCM_SWARCH_ETHER_TIMEINITSTATEHANDLER_PROC
 * @trace #BRCM_SWARCH_ETHER_SETCORRECTIONTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_TIMESTAMPIRQHANDLER_PROC
 * @trace #BRCM_SWREQ_ETHER_TIME
 */
typedef struct sETHER_TimeP1588InfoType {
    ETHER_TimePortInfoType *portInfo[P1588_PORT_COUNT]; /**< @brief Port information */
    uint32_t                frmSyncIntrCnt; /**< @brief Frame sync interrupt count */
} ETHER_TimeP1588InfoType;

/**
 * @trace #BRCM_SWARCH_ETHER_GETTXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_PROCESSTIMESTAMPS_PROC
 * @trace #BRCM_SWARCH_ETHER_GETRXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_GETTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_SETTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_ENABLETXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_SEND_PROC
 * @trace #BRCM_SWARCH_ETHER_TIMEINITSTATEHANDLER_PROC
 * @trace #BRCM_SWARCH_ETHER_SETCORRECTIONTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_TIMESTAMPIRQHANDLER_PROC
 * @trace #BRCM_SWREQ_ETHER_TIME
 */
typedef uint32_t ETHER_TimeStateType;
#define ETHER_TIMESTATE_UNINIT               (0UL) /**< @brief Value must be zero*/
#define ETHER_TIMESTATE_INIT_CFG_DONE        (1UL)
#define ETHER_TIMESTATE_INIT0_DONE           (2UL)
#define ETHER_TIMESTATE_SYNC_PREP_DONE       (3UL)
#define ETHER_TIMESTATE_PREP_HB_READ_DONE    (4UL)
#define ETHER_TIMESTATE_READ_HB_DONE         (5UL)
#define ETHER_TIMESTATE_INIT1                (6UL)
#define ETHER_TIMESTATE_INIT2                (7UL)

/**
 * @trace #BRCM_SWARCH_ETHER_GETTXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_PROCESSTIMESTAMPS_PROC
 * @trace #BRCM_SWARCH_ETHER_GETRXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_GETTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_SETTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_ENABLETXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_SEND_PROC
 * @trace #BRCM_SWARCH_ETHER_TIMEINITSTATEHANDLER_PROC
 * @trace #BRCM_SWARCH_ETHER_SETCORRECTIONTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_TIMESTAMPIRQHANDLER_PROC
 * @trace #BRCM_SWREQ_ETHER_TIME
 */
typedef struct sETHER_TimeRWDataType {
    ETHER_TimeP1588InfoType     p1588Info[P1588_MAX_TIMEHW_ID]; /**< @brief P1588 information */
    ETHER_TimeTxConfWaitQEntryType  txConfWaitQ[ETHER_TIMETXCONFWAITQSIZE]; /**< @brief Common transmit confirmation wait queue for all the port */
    ETHER_RateRatioType         globalRateRatio; /**< @brief Global rate ratio */
    ETHER_TimestampDiffType     globalSysTimeDiff; /**< @brief Global system time difference */
    uint64_t                    hbDiff; /**< @brief EthTime blocks heart beat sync ticks diff */
    uint64_t                    sysTimeDiffNs; /**< @brief System time to network time diff in nano seconds */
    ETHER_TimeStateType         state; /**< @brief EthTime state */
    uint32_t                    portEnMask; /**< @brief EthTime P1588 port enable mask */
    uint32_t                    totalIntrCnt; /**< @brief EthTime Interrupt count */
    ETHER_TimeSyncType          sync; /**< @brief EthTime Sync config */
    uint32_t                    hbReadCnt; /**< @brief Heart beat count */
} ETHER_TimeRWDataType;

/**
 * @trace #BRCM_SWARCH_ETHER_GETTXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_PROCESSTIMESTAMPS_PROC
 * @trace #BRCM_SWARCH_ETHER_GETRXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_GETTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_SETTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_ENABLETXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_SEND_PROC
 * @trace #BRCM_SWARCH_ETHER_TIMEINITSTATEHANDLER_PROC
 * @trace #BRCM_SWARCH_ETHER_SETCORRECTIONTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_TIMESTAMPIRQHANDLER_PROC
 * @trace #BRCM_SWREQ_ETHER_TIME
 */
#define ETHER_TIMEINITPORTINFO(aPortName)   \
    static ETHER_TimePortInfoType aPortName COMP_SECTION(".bss.drivers");

#if P1588_MAX_TIMEHW_ID >= 1UL
#if (0UL != (P1588_PORT_MASK & 0x1UL))
/**
 * @trace #BRCM_SWARCH_ETHER_GETTXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_PROCESSTIMESTAMPS_PROC
 * @trace #BRCM_SWARCH_ETHER_GETRXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_GETTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_SETTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_ENABLETXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_SEND_PROC
 * @trace #BRCM_SWARCH_ETHER_TIMEINITSTATEHANDLER_PROC
 * @trace #BRCM_SWARCH_ETHER_SETCORRECTIONTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_TIMESTAMPIRQHANDLER_PROC
 * @trace #BRCM_SWREQ_ETHER_TIME
 */
ETHER_TIMEINITPORTINFO(ETHER_P1588HW0Port0)
#endif
#if (0UL != (P1588_PORT_MASK & 0x2UL))
/**
 * @trace #BRCM_SWARCH_ETHER_GETTXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_PROCESSTIMESTAMPS_PROC
 * @trace #BRCM_SWARCH_ETHER_GETRXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_GETTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_SETTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_ENABLETXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_SEND_PROC
 * @trace #BRCM_SWARCH_ETHER_TIMEINITSTATEHANDLER_PROC
 * @trace #BRCM_SWARCH_ETHER_SETCORRECTIONTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_TIMESTAMPIRQHANDLER_PROC
 * @trace #BRCM_SWREQ_ETHER_TIME
 */
ETHER_TIMEINITPORTINFO(ETHER_P1588HW0Port1)
#endif
#if (0UL != (P1588_PORT_MASK & 0x4UL))
/**
 * @trace #BRCM_SWARCH_ETHER_GETTXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_PROCESSTIMESTAMPS_PROC
 * @trace #BRCM_SWARCH_ETHER_GETRXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_GETTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_SETTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_ENABLETXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_SEND_PROC
 * @trace #BRCM_SWARCH_ETHER_TIMEINITSTATEHANDLER_PROC
 * @trace #BRCM_SWARCH_ETHER_SETCORRECTIONTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_TIMESTAMPIRQHANDLER_PROC
 * @trace #BRCM_SWREQ_ETHER_TIME
 */
ETHER_TIMEINITPORTINFO(ETHER_P1588HW0Port2)
#endif
#if (0UL != (P1588_PORT_MASK & 0x8UL))
/**
 * @trace #BRCM_SWARCH_ETHER_GETTXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_PROCESSTIMESTAMPS_PROC
 * @trace #BRCM_SWARCH_ETHER_GETRXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_GETTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_SETTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_ENABLETXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_SEND_PROC
 * @trace #BRCM_SWARCH_ETHER_TIMEINITSTATEHANDLER_PROC
 * @trace #BRCM_SWARCH_ETHER_SETCORRECTIONTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_TIMESTAMPIRQHANDLER_PROC
 * @trace #BRCM_SWREQ_ETHER_TIME
 */
ETHER_TIMEINITPORTINFO(ETHER_P1588HW0Port3)
#endif
#if (0UL != (P1588_PORT_MASK & 0x10UL))
/**
 * @trace #BRCM_SWARCH_ETHER_GETTXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_PROCESSTIMESTAMPS_PROC
 * @trace #BRCM_SWARCH_ETHER_GETRXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_GETTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_SETTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_ENABLETXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_SEND_PROC
 * @trace #BRCM_SWARCH_ETHER_TIMEINITSTATEHANDLER_PROC
 * @trace #BRCM_SWARCH_ETHER_SETCORRECTIONTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_TIMESTAMPIRQHANDLER_PROC
 * @trace #BRCM_SWREQ_ETHER_TIME
 */
ETHER_TIMEINITPORTINFO(ETHER_P1588HW0Port4)
#endif
#if (0UL != (P1588_PORT_MASK & 0x20UL))
/**
 * @trace #BRCM_SWARCH_ETHER_GETTXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_PROCESSTIMESTAMPS_PROC
 * @trace #BRCM_SWARCH_ETHER_GETRXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_GETTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_SETTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_ENABLETXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_SEND_PROC
 * @trace #BRCM_SWARCH_ETHER_TIMEINITSTATEHANDLER_PROC
 * @trace #BRCM_SWARCH_ETHER_SETCORRECTIONTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_TIMESTAMPIRQHANDLER_PROC
 * @trace #BRCM_SWREQ_ETHER_TIME
 */
ETHER_TIMEINITPORTINFO(ETHER_P1588HW0Port5)
#endif
#if (0UL != (P1588_PORT_MASK & 0x40UL))
/**
 * @trace #BRCM_SWARCH_ETHER_GETTXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_PROCESSTIMESTAMPS_PROC
 * @trace #BRCM_SWARCH_ETHER_GETRXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_GETTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_SETTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_ENABLETXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_SEND_PROC
 * @trace #BRCM_SWARCH_ETHER_TIMEINITSTATEHANDLER_PROC
 * @trace #BRCM_SWARCH_ETHER_SETCORRECTIONTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_TIMESTAMPIRQHANDLER_PROC
 * @trace #BRCM_SWREQ_ETHER_TIME
 */
ETHER_TIMEINITPORTINFO(ETHER_P1588HW0Port6)
#endif
#if (0UL != (P1588_PORT_MASK & 0x80UL))
/**
 * @trace #BRCM_SWARCH_ETHER_GETTXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_PROCESSTIMESTAMPS_PROC
 * @trace #BRCM_SWARCH_ETHER_GETRXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_GETTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_SETTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_ENABLETXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_SEND_PROC
 * @trace #BRCM_SWARCH_ETHER_TIMEINITSTATEHANDLER_PROC
 * @trace #BRCM_SWARCH_ETHER_SETCORRECTIONTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_TIMESTAMPIRQHANDLER_PROC
 * @trace #BRCM_SWREQ_ETHER_TIME
 */
ETHER_TIMEINITPORTINFO(ETHER_P1588HW0Port7)
#endif
#endif /* P1588_MAX_TIMEHW_ID >= 1UL */

#if P1588_MAX_TIMEHW_ID >= 2UL
#if (0UL != (P1588_PORT_MASK & 0x100UL))
/**
 * @trace #BRCM_SWARCH_ETHER_GETTXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_PROCESSTIMESTAMPS_PROC
 * @trace #BRCM_SWARCH_ETHER_GETRXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_GETTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_SETTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_ENABLETXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_SEND_PROC
 * @trace #BRCM_SWARCH_ETHER_TIMEINITSTATEHANDLER_PROC
 * @trace #BRCM_SWARCH_ETHER_SETCORRECTIONTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_TIMESTAMPIRQHANDLER_PROC
 * @trace #BRCM_SWREQ_ETHER_TIME
 */
ETHER_TIMEINITPORTINFO(ETHER_P1588HW1Port0)
#endif
#if (0UL != (P1588_PORT_MASK & 0x200UL))
/**
 * @trace #BRCM_SWARCH_ETHER_GETTXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_PROCESSTIMESTAMPS_PROC
 * @trace #BRCM_SWARCH_ETHER_GETRXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_GETTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_SETTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_ENABLETXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_SEND_PROC
 * @trace #BRCM_SWARCH_ETHER_TIMEINITSTATEHANDLER_PROC
 * @trace #BRCM_SWARCH_ETHER_SETCORRECTIONTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_TIMESTAMPIRQHANDLER_PROC
 * @trace #BRCM_SWREQ_ETHER_TIME
 */
ETHER_TIMEINITPORTINFO(ETHER_P1588HW1Port1)
#endif
#if (0UL != (P1588_PORT_MASK & 0x400UL))
/**
 * @trace #BRCM_SWARCH_ETHER_GETTXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_PROCESSTIMESTAMPS_PROC
 * @trace #BRCM_SWARCH_ETHER_GETRXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_GETTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_SETTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_ENABLETXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_SEND_PROC
 * @trace #BRCM_SWARCH_ETHER_TIMEINITSTATEHANDLER_PROC
 * @trace #BRCM_SWARCH_ETHER_SETCORRECTIONTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_TIMESTAMPIRQHANDLER_PROC
 * @trace #BRCM_SWREQ_ETHER_TIME
 */
ETHER_TIMEINITPORTINFO(ETHER_P1588HW1Port2)
#endif
#if (0UL != (P1588_PORT_MASK & 0x800UL))
/**
 * @trace #BRCM_SWARCH_ETHER_GETTXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_PROCESSTIMESTAMPS_PROC
 * @trace #BRCM_SWARCH_ETHER_GETRXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_GETTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_SETTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_ENABLETXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_SEND_PROC
 * @trace #BRCM_SWARCH_ETHER_TIMEINITSTATEHANDLER_PROC
 * @trace #BRCM_SWARCH_ETHER_SETCORRECTIONTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_TIMESTAMPIRQHANDLER_PROC
 * @trace #BRCM_SWREQ_ETHER_TIME
 */
ETHER_TIMEINITPORTINFO(ETHER_P1588HW1Port3)
#endif
#if (0UL != (P1588_PORT_MASK & 0x1000UL))
/**
 * @trace #BRCM_SWARCH_ETHER_GETTXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_PROCESSTIMESTAMPS_PROC
 * @trace #BRCM_SWARCH_ETHER_GETRXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_GETTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_SETTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_ENABLETXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_SEND_PROC
 * @trace #BRCM_SWARCH_ETHER_TIMEINITSTATEHANDLER_PROC
 * @trace #BRCM_SWARCH_ETHER_SETCORRECTIONTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_TIMESTAMPIRQHANDLER_PROC
 * @trace #BRCM_SWREQ_ETHER_TIME
 */
ETHER_TIMEINITPORTINFO(ETHER_P1588HW1Port4)
#endif
#if (0UL != (P1588_PORT_MASK & 0xE000UL))
#error "P1588_1 wrong port enabled"
#endif
#endif /* P1588_MAX_TIMEHW_ID >= 2UL */

/**
 * @trace #BRCM_SWARCH_ETHER_GETTXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_PROCESSTIMESTAMPS_PROC
 * @trace #BRCM_SWARCH_ETHER_GETRXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_GETTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_SETTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_ENABLETXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_SEND_PROC
 * @trace #BRCM_SWARCH_ETHER_TIMEINITSTATEHANDLER_PROC
 * @trace #BRCM_SWARCH_ETHER_SETCORRECTIONTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_TIMESTAMPIRQHANDLER_PROC
 * @trace #BRCM_SWREQ_ETHER_TIME
 */
#define ETHER_TIMEINITP1588HWINFO(aPort0InfoAddr, aPort1InfoAddr,       \
        aPort2InfoAddr, aPort3InfoAddr, aPort4InfoAddr, aPort5InfoAddr, \
        aPort6InfoAddr, aPort7InfoAddr)                                 \
{                                                                       \
    .portInfo[0] = (aPort0InfoAddr),            \
    .portInfo[1] = (aPort1InfoAddr),            \
    .portInfo[2] = (aPort2InfoAddr),            \
    .portInfo[3] = (aPort3InfoAddr),            \
    .portInfo[4] = (aPort4InfoAddr),            \
    .portInfo[5] = (aPort5InfoAddr),            \
    .portInfo[6] = (aPort6InfoAddr),            \
    .portInfo[7] = (aPort7InfoAddr),            \
}

/**
 * @trace #BRCM_SWARCH_ETHER_GETTXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_PROCESSTIMESTAMPS_PROC
 * @trace #BRCM_SWARCH_ETHER_GETRXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_GETTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_SETTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_ENABLETXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_SEND_PROC
 * @trace #BRCM_SWARCH_ETHER_TIMEINITSTATEHANDLER_PROC
 * @trace #BRCM_SWARCH_ETHER_SETCORRECTIONTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_TIMESTAMPIRQHANDLER_PROC
 * @trace #BRCM_SWREQ_ETHER_TIME
 */
static ETHER_TimeRWDataType ETHER_TimeRWData COMP_SECTION(".bss.drivers");

/**
 * @trace #BRCM_SWARCH_ETHER_GETTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_SETTIME_PROC
 * @trace #BRCM_SWREQ_ETHER_TIME
 */
#define ETHER_TIMEHBPOLLTIMEOUT (100UL)

/**
 * @trace #BRCM_SWARCH_ETHER_GETTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_SETTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_TIMEINITSTATEHANDLER_PROC
 * @trace #BRCM_SWREQ_ETHER_TIME
 */
static volatile IO_RDBType* const ETHER_TIMEIO_REGS = (IO_RDBType *const) IO_BASE;

/**
 * @trace #BRCM_SWARCH_ETHER_PROCESSTIMESTAMPS_PROC
 * @trace #BRCM_SWREQ_ETHER_TIME
 */
static uint32_t ETHER_TimeQTimeOuts COMP_SECTION(".bss.drivers") = 0UL;

/**
 * @trace #BRCM_SWARCH_ETHER_GETTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_SETTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_TIMEINITSTATEHANDLER_PROC
 * @trace #BRCM_SWARCH_ETHER_TIMEINITSTATEHANDLER_PROC
 * @trace #BRCM_SWARCH_ETHER_SYSCMDHANDLER_PROC
 * @trace #BRCM_SWREQ_ETHER_TIME
 */
static void ETHER_TimeReportError(uint32_t aInstanceID, uint16_t aApiID, int32_t aErr,
        uint32_t aVal0, uint32_t aVal1, uint32_t aVal2, uint32_t aVal3)
{
    const uint32_t values[4] = {aVal0, aVal1, aVal2, aVal3};
    BCM_ReportError(BCM_AMC_ID, (uint8_t)aInstanceID, aApiID, aErr, 4UL, values);
}

#ifdef ETHER_TIME_USES_HB_TIME
/**
 * @trace #BRCM_SWARCH_ETHER_GETTIME_PROC
 * @trace #BRCM_SWARCH_ETHER_SETTIME_PROC
 * @trace #BRCM_SWREQ_ETHER_TIME
 */
static int32_t ETHER_TimeGetHBTime(ETHER_TimestampType* const time)
{
    uint16_t regVal;
    uint32_t i;
    uint32_t pollCount = 0UL;
    int32_t retVal = BCM_ERR_OK;
    ETHER_TimestampType times[P1588_MAX_TIMEHW_ID];
    uint64_t timeNS = 0ULL;
    uint64_t minTimeNS = BCM_UINT64_MAX, maxTimeNS = 0ULL;

    /* Enable SYNC_GEN for both TOP_1588 and BR_1588 blocks */
    ETHER_TIMEIO_REGS->p1588_sync_gen = (IO_P1588_SYNC_GEN_HW0_IN1_MASK
            | IO_P1588_SYNC_GEN_HW0_IN0_MASK |
              IO_P1588_SYNC_GEN_HW1_IN1_MASK | IO_P1588_SYNC_GEN_HW1_IN0_MASK);
    while (pollCount < ETHER_TIMEHBPOLLTIMEOUT) {
        regVal = ETHER_P1588REGS[0UL]->int_stat;
        if (P1588_INT_STAT_INTC_FSYNC_MASK == (regVal & P1588_INT_STAT_INTC_FSYNC_MASK)) {
            break;
        }
        pollCount++;
    }

    if (ETHER_TIMEHBPOLLTIMEOUT == pollCount) {
        retVal = BCM_ERR_TIME_OUT;
        ETHER_TimeReportError(0UL, BRCM_SWDSGN_ETHER_TIMEGETHBTIME_PROC,
                retVal, (uint32_t) regVal, 0UL, 0UL, 0UL);
    }

    for (i = 0; i < P1588_MAX_TIMEHW_ID; ++i) {
        /* Even on timeout we would like to set the end bit to ensure that */
        /* the interrupt gets cleared                                      */
        ETHER_P1588REGS[i]->cntr_dbg = P1588_CNTR_DBG_HB_CNTL_END_MASK;
        ETHER_P1588REGS[i]->cntr_dbg = P1588_CNTR_DBG_HB_CNTL_START_MASK;

        times[i].seconds = ((uint64_t)ETHER_P1588REGS[0UL]->heartbeat_4 << 32ULL) |
                           ((uint64_t)ETHER_P1588REGS[0UL]->heartbeat_3 << 16ULL) |
                           ((uint64_t)ETHER_P1588REGS[0UL]->heartbeat_2);

        times[i].nanoseconds = (uint32_t)(ETHER_P1588REGS[0UL]->heartbeat_1 << 16UL) |
                               (uint32_t)(ETHER_P1588REGS[0UL]->heartbeat_0);

        ETHER_P1588REGS[i]->cntr_dbg = P1588_CNTR_DBG_HB_CNTL_END_MASK;

        timeNS = (times[i].seconds * (uint64_t)BCM_NS_PER_SEC) + times[i].nanoseconds;

        if (timeNS > maxTimeNS) {
            maxTimeNS = timeNS;
        }
        if (timeNS < minTimeNS) {
            minTimeNS = timeNS;
        }
    }

    /* Report an error if the TIME across 1588 blocks is > 8ns */
    if ((maxTimeNS - minTimeNS) > 8ULL) {
        retVal = BCM_ERR_UNKNOWN;
        ETHER_TimeReportError(0UL, BRCM_SWDSGN_ETHER_TIMEGETHBTIME_PROC,
        retVal, (uint32_t)minTimeNS, (uint32_t)maxTimeNS, P1588_MAX_TIMEHW_ID, __LINE__);
    }
    else {
        /* times[0] is guaranteed to exist, so use it */
        time->seconds = times[0].seconds;
        time->nanoseconds = times[0].nanoseconds;
    }
    return retVal;
}
#endif

/**
 * @trace #BRCM_SWARCH_ETHER_GETTXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_PROCESSTIMESTAMPS_PROC
 * @trace #BRCM_SWARCH_ETHER_GETRXTIMESTAMP_PROC
 * @trace #BRCM_SWREQ_ETHER_TIME
 */
static int32_t ETHER_TimeReadTS(uint32_t aHwIdx, uint32_t aPortIdx,
                            ETHER_TimeTSInfoType *const aTSInfo)
{
    uint32_t index;
    INTR_FlagType intFlags;
    ETHER_TimeTSInfoType tsInfo;
    int32_t retVal = BCM_ERR_NOT_FOUND;
    ETHER_TimeP1588InfoType *p1588Info = &ETHER_TimeRWData.p1588Info[aHwIdx];
    ETHER_TimePortInfoType *portInfo = p1588Info->portInfo[aPortIdx];

    /* Find the matching timestamp in the FIFO */
    for (index = 0UL; index < P1588_FIFO_DEPTH; index++) {
        intFlags = INTR_Suspend();
        tsInfo = portInfo->tsInfo[index];
        INTR_Resume(intFlags);
        if ((tsInfo.sequenceId == aTSInfo->sequenceId)
                && (tsInfo.msgType == aTSInfo->msgType)
                && (tsInfo.rxtx == aTSInfo->rxtx)) {
            aTSInfo->seconds  = tsInfo.seconds;
            aTSInfo->nanoseconds = tsInfo.nanoseconds;
            retVal = BCM_ERR_OK;
            break;
        }
    }

    return retVal;
}

/**
 * @trace #BRCM_SWARCH_ETHER_GETTXTIMESTAMP_PROC
 * @trace #BRCM_SWREQ_ETHER_TIME
 */
static void ETHER_TimeFreeTxWaitQEntry(uint32_t aBufIdx,
                                ETHER_TimeTSInfoType *const aTSInfo)
{
    uint32_t index;
    ETHER_TimeTxConfWaitQEntryType * txConfWaitQ = ETHER_TimeRWData.txConfWaitQ;

    for (index = 0UL; index < ETHER_TIMETXCONFWAITQSIZE; ++index) {
        if ((ETHER_TIMETXCONFWAITQENTRYSTATE_DEQUEUED == txConfWaitQ[index].state)
                && (txConfWaitQ[index].bufIdx == aBufIdx)
                && (txConfWaitQ[index].seqId == aTSInfo->sequenceId)
                && (txConfWaitQ[index].type == aTSInfo->msgType)) {
            /* Clear the entry */
            txConfWaitQ[index].state = ETHER_TIMETXCONFWAITQENTRYSTATE_FREE;
            break;
        }
    }
}

/**
 * @trace #BRCM_SWARCH_ETHER_GETTXTIMESTAMP_PROC
 * @trace #BRCM_SWREQ_ETHER_TIME
 */
static int32_t ETHER_TimeRetrieveSeqType(uint32_t aBufIdx,
                                        uint16_t* const aSeqId,
                                        uint32_t* const aType)
{
    uint32_t i;
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    /* Fetch the timestamp from the S/W FIFO */
    for(i = 0UL; i < ETHER_TIMETXCONFWAITQSIZE; ++i) {
        if ((ETHER_TIMETXCONFWAITQENTRYSTATE_DEQUEUED
                    == ETHER_TimeRWData.txConfWaitQ[i].state)
                && (aBufIdx == ETHER_TimeRWData.txConfWaitQ[i].bufIdx)) {
            *aSeqId = ETHER_TimeRWData.txConfWaitQ[i].seqId;
            *aType  = ETHER_TimeRWData.txConfWaitQ[i].type;
            retVal = BCM_ERR_OK;
            break;
        }
    }
    return retVal;
}

/**
 * @trace #BRCM_SWARCH_ETHER_SEND_PROC
 * @trace #BRCM_SWARCH_ETHER_GETRXTIMESTAMP_PROC
 * @trace #BRCM_SWREQ_ETHER_TIME
 */
static int32_t ETHER_TimeParseSeqType(const uint8_t* const aPktBuf,
                                    uint16_t* const aSeq,
                                    uint32_t* const aType)
{
    int32_t retVal;
    ETHER_EtherType ethType;

    ethType = *((ETHER_EtherType * const)(&aPktBuf[ETHER_1588_ETHTYPE_OFFSET]));
    ethType = CPU_BEToNative16(ethType);

    if (ethType != ETHER_ETHERTYPE_GPTP) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        *aType = ((uint32_t)aPktBuf[ETHER_1588_PKTTYPE_OFFSET]) &
            ((uint32_t)ETHER_1588_PKTTYPE_MASK);
        *aSeq = *(uint16_t *const)(&aPktBuf[ETHER_1588_SEQID_OFFSET]);
        *aSeq = CPU_BEToNative16(*aSeq);
        if (((*aType) != ETHER_1588_PKTTYPE_SYNC)
                && ((*aType) != ETHER_1588_PKTTYPE_PDELAY_REQ)
                && ((*aType) != ETHER_1588_PKTTYPE_PDELAY_RESP)) {
            retVal = BCM_ERR_INVAL_PARAMS;
        } else {
            retVal = BCM_ERR_OK;
        }
    }
    return retVal;
}

/**
 * @trace #BRCM_SWARCH_ETHER_ENABLETXTIMESTAMP_PROC
 * @trace #BRCM_SWREQ_ETHER_TIME
 */
static int32_t ETHER_TimeAddTxConfWaitQEntry(uint32_t aHwIdx,
                                        uint32_t aPortIdx,
                                        uint32_t aBufIdx)
{
    uint32_t i;
    int32_t retVal = BCM_ERR_INVAL_PARAMS;
    ETHER_TimeTxConfWaitQEntryType *txConfWaitQ =  ETHER_TimeRWData.txConfWaitQ;

    /* Push an entry into the transmit confirmation wait queue */
    for (i = 0UL; i < ETHER_TIMETXCONFWAITQSIZE; ++i) {
        if (txConfWaitQ[i].state == ETHER_TIMETXCONFWAITQENTRYSTATE_FREE) {
            txConfWaitQ[i].state = ETHER_TIMETXCONFWAITQENTRYSTATE_ALLOC;
            txConfWaitQ[i].bufIdx = aBufIdx;
            txConfWaitQ[i].portIdx = aPortIdx;
            txConfWaitQ[i].p1588Idx = aHwIdx;
            retVal = BCM_ERR_OK;
            break;
        }
    }

    if (i == ETHER_TIMETXCONFWAITQSIZE) {
        retVal = BCM_ERR_BUSY;
    }

    return retVal;
}

/**
 * @trace #BRCM_SWARCH_ETHER_SEND_PROC
 * @trace #BRCM_SWREQ_ETHER_TIME
 */
static int32_t ETHER_TimeRemoveTxConfWaitQEntry(uint32_t aBufIdx)
{
    uint32_t i;
    int32_t retVal = BCM_ERR_NOT_FOUND;
    ETHER_TimeTxConfWaitQEntryType *txConfWaitQ = ETHER_TimeRWData.txConfWaitQ;

    for (i = 0UL; i < ETHER_TIMETXCONFWAITQSIZE; ++i) {
        if (((ETHER_TIMETXCONFWAITQENTRYSTATE_ALLOC == txConfWaitQ[i].state)
                    || (ETHER_TIMETXCONFWAITQENTRYSTATE_DEQUEUED
                        == txConfWaitQ[i].state))
                && (txConfWaitQ[i].bufIdx == aBufIdx)) {
            txConfWaitQ[i].state = ETHER_TIMETXCONFWAITQENTRYSTATE_FREE;
            retVal = BCM_ERR_OK;
        }
    }

    return retVal;
}

/**
 * @trace #BRCM_SWARCH_ETHER_SEND_PROC
 * @trace #BRCM_SWREQ_ETHER_TIME
 */
static int32_t ETHER_TimeUpdateTxConfWaitQEntry(uint32_t aBufIdx,
                                        const uint8_t *const aPktBuf)
{
    uint32_t i;
    uint32_t msgType;
    uint16_t seqId;
    int32_t retVal;
    ETHER_TimeTxConfWaitQEntryType *txConfWaitQ =  ETHER_TimeRWData.txConfWaitQ;

    retVal = ETHER_TimeParseSeqType(aPktBuf, &seqId, &msgType);
    if (retVal == BCM_ERR_OK) {
        /* Push an entry into the transmit confirmation wait queue */
        for (i = 0UL; i < ETHER_TIMETXCONFWAITQSIZE; ++i) {
            if ((txConfWaitQ[i].bufIdx == aBufIdx)
                    && (ETHER_TIMETXCONFWAITQENTRYSTATE_ALLOC == txConfWaitQ[i].state)) {
                txConfWaitQ[i].seqId = seqId;
                txConfWaitQ[i].type = msgType;
                txConfWaitQ[i].state = ETHER_TIMETXCONFWAITQENTRYSTATE_QUEUED;
                txConfWaitQ[i].ts = BCM_GetSystemTimeNs();
                retVal = BCM_ERR_OK;
                break;
            }
        }

        if(i == ETHER_TIMETXCONFWAITQSIZE) {
            retVal = BCM_ERR_BUSY;
        }
    } else {
        retVal = ETHER_TimeRemoveTxConfWaitQEntry(aBufIdx);
    }

    return retVal;
}

/**
 * @trace #BRCM_SWARCH_ETHER_GETTXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_GETRXTIMESTAMP_PROC
 * @trace #BRCM_SWARCH_ETHER_GETTIME_PROC
 * @trace #BRCM_SWREQ_ETHER_TIME
 */
static void ETHER_TimeAddGlobalSystimeDiff(ETHER_TimestampType *const timestamp)
{
#ifndef ETHER_TIME_HW_CLOCK_UPDATE
    uint64_t timestamp_ns;
    uint64_t globalTime_ns;

    ETHER_TIMECONVERTTIMESTAMP2NSECS(*timestamp, timestamp_ns);
    ETHER_TIMECONVERTTIMESTAMP2NSECS(ETHER_TimeRWData.globalSysTimeDiff.absTimestampDiff,
                        globalTime_ns);
    if (1UL == ETHER_TimeRWData.globalSysTimeDiff.isNegative) {
        timestamp_ns -= globalTime_ns;
    } else {
        timestamp_ns += globalTime_ns;
    }

    ETHER_TIMECONVERTNSECS2TIMESTAMP(*timestamp, timestamp_ns);
#endif
}

/**
 * @trace #BRCM_SWARCH_ETHER_PROCESSTIMESTAMPS_PROC
 * @trace #BRCM_SWREQ_ETHER_TIME
 */
static int32_t ETHER_TimeProcessTS(uint32_t aID, uint32_t * const aBufIdx)
{
    int32_t  retVal = BCM_ERR_EAGAIN;
    uint32_t i, hwIdx, portIdx, j;
    ETHER_TimeTSInfoType tsInfo;
    ETHER_TimeTxConfWaitQEntryType *txConfWaitQ = ETHER_TimeRWData.txConfWaitQ;
    uint64_t timeout = 1000*1000; /* 1ms */
    uint64_t latestToHold = BCM_GetSystemTimeNs() - timeout;

    if((ETHER_TIMEHWIDMAX <= aID) || (NULL == aBufIdx)) {
        retVal = BCM_ERR_INVAL_PARAMS;
        goto err;
    }

    if (ETHER_TIMESTATE_INIT2 == ETHER_TimeRWData.state) {
        for(i = 0UL; i < ETHER_TIMETXCONFWAITQSIZE; ++i) {
            if (ETHER_TIMETXCONFWAITQENTRYSTATE_QUEUED == txConfWaitQ[i].state) {
                hwIdx = txConfWaitQ[i].p1588Idx;
                portIdx = txConfWaitQ[i].portIdx;
                tsInfo.sequenceId = txConfWaitQ[i].seqId;
                tsInfo.msgType = txConfWaitQ[i].type;
                tsInfo.rxtx = ETHER_TIMETXTIMESTAMP;
                retVal = ETHER_TimeReadTS(hwIdx, portIdx, &tsInfo);
                if(BCM_ERR_OK == retVal) {
                    /* If we were able to get the timestamp for this entry then all others */
                    /* (that are still in queued state) for the same port+msgType should be*/
                    /* treated as stale                                                    */
                    for (j = 0UL; j < ETHER_TIMETXCONFWAITQSIZE; ++j) {
                        if ((i != j) &&
                            (ETHER_TIMETXCONFWAITQENTRYSTATE_QUEUED == txConfWaitQ[j].state) &&
                            (txConfWaitQ[i].p1588Idx == txConfWaitQ[j].p1588Idx) &&
                            (txConfWaitQ[i].portIdx == txConfWaitQ[j].portIdx) &&
                            (txConfWaitQ[i].type == txConfWaitQ[j].type)) {
                            /* First report the stale entry so that it can be freed */
                            *aBufIdx = txConfWaitQ[j].bufIdx;
                            txConfWaitQ[j].state = ETHER_TIMETXCONFWAITQENTRYSTATE_DEQUEUED;
                            break;
                        }
                    }

                    if (j == ETHER_TIMETXCONFWAITQSIZE) {
                        /* No stale entries found, the current one can be reported */
                        *aBufIdx = txConfWaitQ[i].bufIdx;
                        txConfWaitQ[i].state = ETHER_TIMETXCONFWAITQENTRYSTATE_DEQUEUED;
                    }
                    break;
                } else {
                    /* check if the packet has timed out and move the state to DEQUEUED */
                    if (txConfWaitQ[i].ts < latestToHold) {
                        txConfWaitQ[i].state = ETHER_TIMETXCONFWAITQENTRYSTATE_DEQUEUED;
                        *aBufIdx = txConfWaitQ[i].bufIdx;
                        ETHER_TimeReportError(0UL, BRCM_SWARCH_ETHER_PROCESSTIMESTAMPS_PROC,
                                BCM_ERR_TIME_OUT, txConfWaitQ[i].bufIdx, (uint32_t)(txConfWaitQ[i].ts >> 32UL),
                                                  (uint32_t)txConfWaitQ[i].ts, (uint32_t)latestToHold);
                        retVal = BCM_ERR_OK;

                        /* for debug */
                        ETHER_TimeQTimeOuts++;
                        txConfWaitQ[i].ts = 0ULL;
                        break;
                    }
                }
            }
        }
    }
err:
    return retVal;
}

/**
 * @trace #BRCM_SWARCH_ETHER_TIMEINITSTATEHANDLER_PROC
 * @trace #BRCM_SWREQ_ETHER_TIME
 */
static void ETHER_TimeGenInternalSync(void)
{
    /* top_gen_frmsync */
    ETHER_TIMEIO_REGS->p1588_sync_gen = (IO_P1588_SYNC_GEN_HW0_IN1_MASK
                                        | IO_P1588_SYNC_GEN_HW0_IN0_MASK
                                        | IO_P1588_SYNC_GEN_HW1_IN1_MASK
                                        | IO_P1588_SYNC_GEN_HW1_IN0_MASK);
}

/**
 * @trace #BRCM_SWARCH_ETHER_TIMEINITSTATEHANDLER_PROC
 * @trace #BRCM_SWREQ_ETHER_TIME
 */
static void ETHER_TimeInitSyncPrep(void)
{
    uint32_t i;
    MCU_InfoType mcuInfo;
    uint16_t regVal;
    volatile uint16_t *const brphy_gphy_core_expf5_reg[BRPHY_CORE_MAX_HW_ID] = {
        &((BRPHY_CORE_RDBType *const)BRPHYBLK0_CORE_BASE)->expf5,
        &((BRPHY_CORE_RDBType *const)BRPHYBLK1_CORE_BASE)->expf5,
        &((BRPHY_CORE_RDBType *const)BRPHYBLK2_CORE_BASE)->expf5,
        &((BRPHY_CORE_RDBType *const)BRPHYBLK3_CORE_BASE)->expf5,
#if (BRPHY_CORE_MAX_HW_ID > 4UL)
        &((BRPHY_CORE_RDBType *const)BRPHYBLK4_CORE_BASE)->expf5,
#endif
    };

    (void)MCU_GetInfo(&mcuInfo);

    for (i = 0UL; i < BRPHY_CORE_MAX_HW_ID; i++) {
        /* en_time_sync */
        (*brphy_gphy_core_expf5_reg[i]) |=
            BRPHY_CORE_EXPF5_TIMESYNC_EN_MASK;
    }

    for (i = 0UL; i < P1588_MAX_TIMEHW_ID; i++) {
        /* en_1588_rxtx_BR1 */
        ETHER_P1588REGS[i]->slice_enable = 0xFFFFU;
        /* en_1588_disable_dpll_BR1 */
        ETHER_P1588REGS[i]->dpll_db_sel = 0x0060U;
    }

    for (i = 0UL; i < P1588_MAX_TIMEHW_ID; i++) {
        ETHER_P1588REGS[i]->nse_nco_2_2 = 0x0U;
        ETHER_P1588REGS[i]->nse_nco_2_1 = 0x0U;
        ETHER_P1588REGS[i]->nse_nco_2_0 = 0x0U;

        /* Set time code 0000 */
        ETHER_P1588REGS[i]->time_code_0 = 0x0U;
        ETHER_P1588REGS[i]->time_code_1 = 0x0U;
        ETHER_P1588REGS[i]->time_code_2 = 0x0U;
        ETHER_P1588REGS[i]->time_code_3 = 0x0U;
        ETHER_P1588REGS[i]->time_code_4 = 0x0U;

        /* en_shadow_cnt_ld_BR0 */
        ETHER_P1588REGS[i]->shd_ctl = (P1588_SHD_CTL_F8_C_MASK | P1588_SHD_CTL_F11_C_MASK);
        ETHER_P1588REGS[i]->shd_ld = (P1588_SHD_LD_F8_L_MASK | P1588_SHD_LD_F11_L_MASK);

        regVal = (P1588_NSE_NCO_6_GMODE_MASK
                | P1588_NSE_NCO_6_TS_CAPTURE_MASK
                | P1588_NSE_NCO_6_NSE_INIT_MASK
                | P1588_NSE_NCO_6_FRAMESYN_MODE_SYNCIN1_MASK);

        if ((mcuInfo.stackingEn == 1U) && (mcuInfo.mstSlvMode != MCU_DEVICE_MASTER)) {
            /* Do not enable output pulse for slaves */
        } else {
            regVal |= P1588_NSE_NCO_6_SYNCOUT_MODE_1_OP_PULSE_MASK;
        }
        /* en_gsm3_sim2_som0_BR0 */
        ETHER_P1588REGS[i]->nse_nco_6 = regVal;
    }
}

/**
 * @trace #BRCM_SWARCH_ETHER_TIMEINITSTATEHANDLER_PROC
 * @trace #BRCM_SWREQ_ETHER_TIME
 */
static void ETHER_TimeInitPrepHBRead(void)
{
    uint32_t i;
    uint16_t regVal = (P1588_NSE_NCO_6_GMODE_MASK
            | P1588_NSE_NCO_6_TS_CAPTURE_MASK
            | P1588_NSE_NCO_6_FRAMESYN_MODE_SYNCIN1_MASK);
    MCU_InfoType mcuInfo;

    (void)MCU_GetInfo(&mcuInfo);

    if ((mcuInfo.stackingEn == 1U) && (mcuInfo.mstSlvMode != MCU_DEVICE_MASTER)) {
        /* Do not enable output pulse for slaves */
    } else {
        regVal |= P1588_NSE_NCO_6_SYNCOUT_MODE_1_OP_PULSE_MASK;
    }

    for (i = 0UL; i < P1588_MAX_TIMEHW_ID; i++) {
        /* ds_init_shadow_ld_BR0 */
        ETHER_P1588REGS[i]->nse_nco_6 = regVal;
        ETHER_P1588REGS[i]->shd_ld = 0x0000U;
    }
}

/**
 * @trace #BRCM_SWARCH_ETHER_TIMEINITSTATEHANDLER_PROC
 * @trace #BRCM_SWREQ_ETHER_TIME
 */
static void ETHER_TimeInitReadHB(uint16_t *const aHB1Time,
                                    uint16_t *const aHB2Time)
{
    uint32_t i;
    uint16_t *const hb[2UL] = {aHB1Time, aHB2Time};

    for (i = 0UL; i < P1588_MAX_TIMEHW_ID; i++) {

        /* rd_local_time_1times_BR0 */
        ETHER_P1588REGS[i]->cntr_dbg = P1588_CNTR_DBG_HB_CNTL_START_MASK;

        hb[i][3UL] = ETHER_P1588REGS[i]->heartbeat_3;
        hb[i][2UL] = ETHER_P1588REGS[i]->heartbeat_2;
        hb[i][1UL] = ETHER_P1588REGS[i]->heartbeat_1;
        hb[i][0UL] = ETHER_P1588REGS[i]->heartbeat_0;

        ETHER_P1588REGS[i]->cntr_dbg = P1588_CNTR_DBG_HB_CNTL_END_MASK;
    }
}

/**
 * @trace #BRCM_SWARCH_ETHER_TIMEINITSTATEHANDLER_PROC
 * @trace #BRCM_SWREQ_ETHER_TIME
 */
static void ETHER_TimeInit1(void)
{
    uint32_t i, portEnMask;
    uint16_t port;

    if (ETHER_TimeRWData.hbDiff > 8ULL) {
        ETHER_TimeReportError(0UL, (uint8_t)BRCM_SWDSGN_ETHER_TIMEINIT1_PROC,
                BCM_ERR_INVAL_STATE, 0UL, 0UL, 0UL, __LINE__);
    }

    for (i = 0UL; i < P1588_MAX_TIMEHW_ID; i++) {

        /* Enable 802.1AS packet detection on rx and tx  */
        ETHER_P1588REGS[i]->tx_ctl = P1588_TX_CTL_AS_EN_MASK;
        ETHER_P1588REGS[i]->rx_ctl = P1588_RX_CTL_AS_EN_MASK;

        /* Disable CRC check in Tx/Rx directions. In the Tx direction the
         * CRC is inserted by the MAC so there is no reason the check
         * should fail. In the Rx direction the MAC will perform the check
         * and drop the packet so there will be no Rx Indication
         */
        ETHER_P1588REGS[i]->rx_tx_ctl &= (~(P1588_RX_TX_CTL_TX_CRC_EN_MASK |
                                        P1588_RX_TX_CTL_RX_CRC_EN_MASK));

        portEnMask = ((ETHER_TimeRWData.portEnMask >> (8UL * i)) & 0xFFUL);

        for (port = 0U; (port < P1588_PORT_COUNT) ; port++) {
            if (0UL != (portEnMask & (0x1UL << port))) {
                /* Enable 1588 on the port for Tx & Rx direction */
                ETHER_P1588REGS[i]->slice_enable |=
                    ((P1588_SLICE_ENABLE_TX_SLICE_1588_EN_PORT0_MASK
                      | P1588_SLICE_ENABLE_RX_SLICE_1588_EN_PORT0_MASK) << port);

                /* Enable Tx SOP timestamp capture the port */
                ETHER_P1588REGS[i]->tx_ts_cap |= (P1588_TX_TS_CAP_PORT0_MASK << port);

                /* Enable Rx SOP timestamp capture the port */
                ETHER_P1588REGS[i]->rx_ts_cap |= (P1588_RX_TS_CAP_PORT0_MASK << port);

                /* Enable IEEE 64 bit timecode for ingress and egress timestamps */
                ETHER_P1588REGS[i]->timecode_sel |=
                    (P1588_TIMECODE_SEL_TX_PORT0_MASK << port);
                ETHER_P1588REGS[i]->timecode_sel |=
                    (P1588_TIMECODE_SEL_RX_PORT0_MASK << port);

                /* Enable internal 1588 SOP instead of GPHY SOP for Tx & Rx direction */
                ETHER_P1588REGS[i]->sop_sel |=
                    (P1588_SOP_SEL_INTERNAL_1588_VAL << (port + P1588_SOP_SEL_TX_PORT0_SHIFT))
                    | (P1588_SOP_SEL_INTERNAL_1588_VAL << (port + P1588_SOP_SEL_RX_PORT0_SHIFT));
            }
        }
    }
}

/**
 * @trace #BRCM_SWARCH_ETHER_TIMEINITSTATEHANDLER_PROC
 * @trace #BRCM_SWREQ_ETHER_TIME
 */
static void ETHER_TimeInit2(void)
{
}

/**
 * @trace #BRCM_SWARCH_ETHER_TIMEINIT_PROC
 * @trace #BRCM_SWREQ_ETHER_TIME
 */
static int32_t ETHER_TimeIntInit(uint32_t aID,
                            ETHER_TimeCfgType *const aCfg)
{
    int32_t retVal = BCM_ERR_OK;

    if ((ETHER_TIMEHWIDMAX <= aID) || (NULL == aCfg)) {
        retVal = BCM_ERR_INVAL_PARAMS;
        goto exit;
    }

    /* Verify configurations */
    if ((aCfg->sync != ETHER_TIMESYNC_NONE)
            && (aCfg->sync != ETHER_TIMESYNC_INTERNAL)
            && (aCfg->sync != ETHER_TIMESYNC_EXTERNAL)) {
        retVal = BCM_ERR_INVAL_PARAMS;
        goto exit;
    }

    if ((aCfg->portEnableMask & P1588_PORT_MASK) == 0UL) {
        retVal = BCM_ERR_INVAL_PARAMS;
        goto exit;
    }

    if (ETHER_TIMESTATE_UNINIT != ETHER_TimeRWData.state) {
        retVal = BCM_ERR_INVAL_STATE;
        goto exit;
    }

#if P1588_MAX_TIMEHW_ID == 0UL
#error "P1588_MAX_TIMEHW_ID == 0UL"
#endif
#if (0x1FUL == (P1588_PORT_MASK & 0xFFUL))
    ETHER_TimeRWData.p1588Info[0].portInfo[0] = &ETHER_P1588HW0Port0;
    ETHER_TimeRWData.p1588Info[0].portInfo[1] = &ETHER_P1588HW0Port1;
    ETHER_TimeRWData.p1588Info[0].portInfo[2] = &ETHER_P1588HW0Port2;
    ETHER_TimeRWData.p1588Info[0].portInfo[3] = &ETHER_P1588HW0Port3;
    ETHER_TimeRWData.p1588Info[0].portInfo[4] = &ETHER_P1588HW0Port4;
#elif (0xFFUL == (P1588_PORT_MASK & 0xFFUL))
    ETHER_TimeRWData.p1588Info[0].portInfo[0] = &ETHER_P1588HW0Port0;
    ETHER_TimeRWData.p1588Info[0].portInfo[1] = &ETHER_P1588HW0Port1;
    ETHER_TimeRWData.p1588Info[0].portInfo[2] = &ETHER_P1588HW0Port2;
    ETHER_TimeRWData.p1588Info[0].portInfo[3] = &ETHER_P1588HW0Port3;
    ETHER_TimeRWData.p1588Info[0].portInfo[4] = &ETHER_P1588HW0Port4;
    ETHER_TimeRWData.p1588Info[0].portInfo[5] = &ETHER_P1588HW0Port5;
    ETHER_TimeRWData.p1588Info[0].portInfo[6] = &ETHER_P1588HW0Port6;
    ETHER_TimeRWData.p1588Info[0].portInfo[7] = &ETHER_P1588HW0Port7;
#else
#error "P1588_0 wrong port enabled, expected 0x1FUL or 0xFFUL"
#endif

#if P1588_MAX_TIMEHW_ID > 1UL
#if (0x0100UL == (P1588_PORT_MASK & 0xFF00UL))
    ETHER_TimeRWData.p1588Info[1].portInfo[0] = &ETHER_P1588HW1Port0;
#elif (0x1F00UL == (P1588_PORT_MASK & 0xFF00UL))
    ETHER_TimeRWData.p1588Info[1].portInfo[0] = &ETHER_P1588HW1Port0;
    ETHER_TimeRWData.p1588Info[1].portInfo[1] = &ETHER_P1588HW1Port1;
    ETHER_TimeRWData.p1588Info[1].portInfo[2] = &ETHER_P1588HW1Port2;
    ETHER_TimeRWData.p1588Info[1].portInfo[3] = &ETHER_P1588HW1Port3;
    ETHER_TimeRWData.p1588Info[1].portInfo[4] = &ETHER_P1588HW1Port4;
#else
#error "P1588_1 wrong port enabled, expected 0x01UL or 0x1FUL"
#endif
#endif
#if P1588_MAX_TIMEHW_ID > 2UL
#error "P1588_MAX_TIMEHW_ID > 2UL"
#endif
    ETHER_TimeRWData.sync = aCfg->sync;
    ETHER_TimeRWData.portEnMask = aCfg->portEnableMask;

    ETHER_TimeRWData.state = ETHER_TIMESTATE_INIT_CFG_DONE;

exit:
    return retVal;
}

/**
 * @trace #BRCM_SWARCH_ETHER_TIMEINITSTATEHANDLER_PROC
 * @trace #BRCM_SWREQ_ETHER_TIME
 */
static int32_t ETHER_TimeInitCfgStateHandler(ETHER_TimeInitCmdType aCmd)
{
    int32_t retVal = BCM_ERR_OK;
    uint32_t i;
    MCU_InfoType mcuInfo;

    (void)MCU_GetInfo(&mcuInfo);

    if (ETHER_TIMESTATE_INIT_CFG_DONE != ETHER_TimeRWData.state) {
        retVal = BCM_ERR_INVAL_STATE;
        goto exit;
    }

    if (ETHER_TIMEINITCMD_0 != aCmd) {
        retVal = BCM_ERR_INVAL_PARAMS;
        goto exit;
    }

    /* Mask P1588 frame sync interrupt */
    for (i = 0UL; i < P1588_MAX_TIMEHW_ID; i++) {
        ETHER_P1588REGS[i]->int_mask = 0U;
        ETHER_P1588REGS[i]->int_mask |= P1588_INT_MASK_INTC_FSYNC_MASK_MASK;
    }

    ETHER_TimeRWData.state = ETHER_TIMESTATE_INIT0_DONE;

    if ((mcuInfo.stackingEn == 1U) && (MCU_DEVICE_MASTER == mcuInfo.mstSlvMode)) {
        ETHER_TIMEIO_REGS->p1588_config = IO_P1588_CONFIG_SYNCOUT_SEL_VAL;
    }

    if (ETHER_TIMESYNC_INTERNAL == ETHER_TimeRWData.sync) {
        retVal = BCM_ERR_EAGAIN;
    }
exit:
    return retVal;
}

/**
 * @trace #BRCM_SWARCH_ETHER_TIMEINITSTATEHANDLER_PROC
 * @trace #BRCM_SWREQ_ETHER_TIME
 */
static int32_t ETHER_TimeInit0StateHandler(ETHER_TimeInitCmdType aCmd)
{
    int32_t retVal = BCM_ERR_OK;

    if (ETHER_TIMESTATE_INIT0_DONE != ETHER_TimeRWData.state) {
        retVal = BCM_ERR_INVAL_STATE;
        goto exit;
    }

    if (ETHER_TIMESYNC_EXTERNAL == ETHER_TimeRWData.sync) {
        if (ETHER_TIMEINITCMD_PREP_SYNC != aCmd) {
            retVal = BCM_ERR_INVAL_PARAMS;
            goto exit;
        }

        ETHER_TimeInitSyncPrep();
        ETHER_TimeRWData.state = ETHER_TIMESTATE_SYNC_PREP_DONE;
    } else if (ETHER_TIMESYNC_INTERNAL == ETHER_TimeRWData.sync) {
        ETHER_TimeInitSyncPrep();
        ETHER_TimeRWData.state = ETHER_TIMESTATE_SYNC_PREP_DONE;
        retVal = BCM_ERR_EAGAIN;
    } else if (ETHER_TIMESYNC_NONE == ETHER_TimeRWData.sync) {
        ETHER_TimeInit1();
        ETHER_TimeRWData.state = ETHER_TIMESTATE_INIT1;
        retVal = BCM_ERR_EAGAIN;
    } else {
        retVal = BCM_ERR_UNKNOWN;
    }

exit:
    return retVal;
}

/**
 * @trace #BRCM_SWARCH_ETHER_TIMEINITSTATEHANDLER_PROC
 * @trace #BRCM_SWREQ_ETHER_TIME
 */
static int32_t ETHER_TimeSyncPrepStateHandler(ETHER_TimeInitCmdType aCmd)
{
    int32_t retVal = BCM_ERR_OK;

    if (ETHER_TIMESTATE_SYNC_PREP_DONE != ETHER_TimeRWData.state) {
        retVal = BCM_ERR_INVAL_STATE;
        goto exit;
    }

    if (ETHER_TIMESYNC_EXTERNAL == ETHER_TimeRWData.sync) {
        if (ETHER_TIMEINITCMD_PREP_HB_READ != aCmd) {
            retVal = BCM_ERR_INVAL_PARAMS;
            goto exit;
        }

        ETHER_TimeInitPrepHBRead();
        ETHER_TimeRWData.state = ETHER_TIMESTATE_PREP_HB_READ_DONE;
    } else if (ETHER_TIMESYNC_INTERNAL == ETHER_TimeRWData.sync) {

        ETHER_TimeGenInternalSync();
        BCM_CpuNDelay(10000UL);
        ETHER_TimeGenInternalSync();
        BCM_CpuNDelay(10000UL);
        ETHER_TimeInitPrepHBRead();
        ETHER_TimeGenInternalSync();
        ETHER_TimeRWData.state = ETHER_TIMESTATE_PREP_HB_READ_DONE;
        retVal = BCM_ERR_EAGAIN;
    } else if (ETHER_TIMESYNC_NONE == ETHER_TimeRWData.sync) {
        retVal = BCM_ERR_INVAL_STATE;
    } else {
        retVal = BCM_ERR_UNKNOWN;
    }

exit:
    return retVal;
}

/**
 * @trace #BRCM_SWARCH_ETHER_TIMEINITSTATEHANDLER_PROC
 * @trace #BRCM_SWREQ_ETHER_TIME
 */
static int32_t ETHER_TimePrepHBReadStateHandler(ETHER_TimeInitCmdType aCmd,
                                    ETHER_TimeInitOutType *const aOutput)
{
    int32_t retVal = BCM_ERR_OK;
    uint16_t hb0[ETHER_HEART_BEAT_CNT_MAX] = {0U};
    uint16_t hb1[ETHER_HEART_BEAT_CNT_MAX] = {0U};
    uint64_t heartbeat0, heartbeat1, hbDiff = 0ULL;

    if (ETHER_TIMESTATE_PREP_HB_READ_DONE != ETHER_TimeRWData.state) {
        retVal = BCM_ERR_INVAL_STATE;
        goto exit;
    }

    if (ETHER_TIMESYNC_EXTERNAL == ETHER_TimeRWData.sync) {
        if ((ETHER_TIMEINITCMD_GET_HB != aCmd) || (NULL == aOutput)) {
            retVal = BCM_ERR_INVAL_PARAMS;
            goto exit;
        }

        ETHER_TimeInitReadHB(hb0, hb1);
        BCM_MemCpy(aOutput->heartBeat0, hb0, sizeof(hb0));
        BCM_MemCpy(aOutput->heartBeat1, hb1, sizeof(hb1));
        ETHER_TimeRWData.state = ETHER_TIMESTATE_READ_HB_DONE;
    } else if (ETHER_TIMESYNC_INTERNAL == ETHER_TimeRWData.sync) {
        ETHER_TimeGenInternalSync();
        ETHER_TimeInitReadHB(hb0, hb1);
        BCM_CpuNDelay(10000UL);
        ETHER_TimeRWData.hbReadCnt++;
        heartbeat0 = hb0[0] | (uint64_t)hb0[1] << 16
                            | (uint64_t)hb0[2] << 32;
        heartbeat1 = hb1[0] | (uint64_t)hb1[1] << 16
                            | (uint64_t)hb1[2] << 32;
        hbDiff = (heartbeat0 >= heartbeat1)
            ? (heartbeat0 - heartbeat1)
            : (heartbeat1 - heartbeat0);

        /* Error condition, should NEVER happen */
        if (ETHER_TimeRWData.hbReadCnt >= 8UL) {
            retVal = BCM_ERR_MAX_ATTEMPS;
            ETHER_TimeReportError(0x0U, BRCM_SWDSGN_ETHER_TIMEPREPHBREADSTATEHANDLER_PROC,
                                  retVal, (uint32_t)hbDiff,(uint32_t)heartbeat0,
                                  (uint32_t)heartbeat1, __LINE__);
        } else {
            if (hbDiff <= 8ULL) {
                ETHER_TimeReportError(0x0U, BRCM_SWDSGN_ETHER_TIMEPREPHBREADSTATEHANDLER_PROC,
                                      retVal, (uint32_t)hbDiff,(uint32_t)heartbeat0,
                                      (uint32_t)heartbeat1, __LINE__);
                BCM_MemCpy(aOutput->heartBeat0, hb0, sizeof(hb0));
                BCM_MemCpy(aOutput->heartBeat1, hb1, sizeof(hb1));
                ETHER_TimeRWData.state = ETHER_TIMESTATE_READ_HB_DONE;
            }
            retVal = BCM_ERR_EAGAIN;
        }
    } else if (ETHER_TIMESYNC_NONE == ETHER_TimeRWData.sync) {
        retVal = BCM_ERR_INVAL_STATE;
    } else {
        retVal = BCM_ERR_UNKNOWN;
    }

exit:
    return retVal;
}

/**
 * @trace #BRCM_SWARCH_ETHER_TIMEINITSTATEHANDLER_PROC
 * @trace #BRCM_SWREQ_ETHER_TIME
 */
static int32_t ETHER_TimeReadHBStateHandler(ETHER_TimeInitCmdType aCmd)
{
    int32_t retVal = BCM_ERR_OK;

    if (ETHER_TIMESTATE_READ_HB_DONE != ETHER_TimeRWData.state) {
        retVal = BCM_ERR_INVAL_STATE;
        goto exit;
    }

    if (ETHER_TIMESYNC_EXTERNAL == ETHER_TimeRWData.sync) {
        if (ETHER_TIMEINITCMD_PREP_SYNC == aCmd) {
            ETHER_TimeRWData.state = ETHER_TIMESTATE_INIT0_DONE;
            retVal = ETHER_TimeInit0StateHandler(aCmd);
        } else if (ETHER_TIMEINITCMD_1 == aCmd) {
            ETHER_TimeInit1();
            ETHER_TimeRWData.state = ETHER_TIMESTATE_INIT1;
        } else {
            retVal = BCM_ERR_INVAL_PARAMS;
            goto exit;
        }
    } else if (ETHER_TIMESYNC_INTERNAL == ETHER_TimeRWData.sync) {
        ETHER_TimeInit1();
        ETHER_TimeRWData.state = ETHER_TIMESTATE_INIT1;
    } else if (ETHER_TIMESYNC_NONE == ETHER_TimeRWData.sync) {
        retVal = BCM_ERR_INVAL_STATE;
    } else {
        retVal = BCM_ERR_UNKNOWN;
    }

exit:
    return retVal;
}

/**
 * @trace #BRCM_SWARCH_ETHER_TIMEINITSTATEHANDLER_PROC
 * @trace #BRCM_SWREQ_ETHER_TIME
 */
static int32_t ETHER_TimeInit1StateHandler(ETHER_TimeInitCmdType aCmd)
{
    int32_t retVal = BCM_ERR_OK;

    if (ETHER_TIMESTATE_INIT1 != ETHER_TimeRWData.state) {
        retVal = BCM_ERR_INVAL_STATE;
        goto exit;
    }

    if (ETHER_TIMEINITCMD_2 != aCmd) {
        retVal = BCM_ERR_INVAL_PARAMS;
        goto exit;
    }

    ETHER_TimeInit2();
    ETHER_TimeRWData.state = ETHER_TIMESTATE_INIT2;

exit:
    return retVal;
}

/**
 * @trace #BRCM_SWARCH_ETHER_TIMEINITSTATEHANDLER_PROC
 * @trace #BRCM_SWREQ_ETHER_TIME
 */
static int32_t ETHER_TimeIntInitStateHandler(uint32_t aID,
                            ETHER_TimeInitCmdType aCmd,
                            uint64_t aSysTimeDiffNs,
                            ETHER_TimeInitOutType *const aOutput)
{
    int32_t retVal = BCM_ERR_OK;
    if (ETHER_TIMEHWIDMAX <= aID) {
        retVal = BCM_ERR_INVAL_PARAMS;
        goto exit;
    }

    switch(ETHER_TimeRWData.state) {
        case ETHER_TIMESTATE_INIT_CFG_DONE:
            retVal = ETHER_TimeInitCfgStateHandler(aCmd);
            break;
        case ETHER_TIMESTATE_INIT0_DONE:
            retVal = ETHER_TimeInit0StateHandler(aCmd);
            break;
        case ETHER_TIMESTATE_SYNC_PREP_DONE:
            retVal = ETHER_TimeSyncPrepStateHandler(aCmd);
            break;
        case ETHER_TIMESTATE_PREP_HB_READ_DONE:
            retVal = ETHER_TimePrepHBReadStateHandler(aCmd, aOutput);
            break;
        case ETHER_TIMESTATE_READ_HB_DONE:
            retVal = ETHER_TimeReadHBStateHandler(aCmd);
            break;
        case ETHER_TIMESTATE_INIT1:
            retVal = ETHER_TimeInit1StateHandler(aCmd);
            if (BCM_ERR_OK == retVal) {
                ETHER_TimeRWData.sysTimeDiffNs = aSysTimeDiffNs;
            }
            break;
        default:
            ETHER_TimeReportError(aID,
                    BRCM_SWDSGN_ETHER_TIMEINTINITSTATEHANDLER_PROC,
                    retVal, 0UL, 0UL, 0UL, __LINE__);
            break;
    }

exit:
    return retVal;
}

/**
 * @trace #BRCM_SWARCH_ETHER_ENABLETXTIMESTAMP_PROC
 * @trace #BRCM_SWREQ_ETHER_TIME
 */
static int32_t ETHER_TimeEnableEgressTS(uint32_t aID,
                                      uint32_t aPortIdx,
                                      uint32_t aBufIdx)
{
    int32_t retVal;
    uint32_t hwIdx = ETHER_TIMEPORT2HWIDX(aPortIdx);
    uint32_t portIdx = ETHER_TIMEPORT2PORTIDX(aPortIdx);


    if ((ETHER_TIMEHWIDMAX <= aID)
            || (P1588_MAX_TIMEHW_ID <= hwIdx)
            || (P1588_PORT_COUNT <= portIdx)) {
        retVal = BCM_ERR_INVAL_PARAMS;
        goto exit;
    }

    if (ETHER_TIMESTATE_INIT2 != ETHER_TimeRWData.state) {
        retVal = BCM_ERR_UNINIT;
        goto exit;
    }

    if (!ETHER_TIMEISPORTENABLED(hwIdx, portIdx)) {
        retVal = BCM_ERR_INVAL_PARAMS;
        goto exit;
    }

    retVal = ETHER_TimeAddTxConfWaitQEntry(hwIdx, portIdx, aBufIdx);

exit:
    return retVal;
}

/**
 * @trace #BRCM_SWARCH_ETHER_SEND_PROC
 * @trace #BRCM_SWREQ_ETHER_TIME
 */
static int32_t ETHER_TimeUpdateEgressPktInfo(uint32_t aID,
                                      uint32_t aBufIdx,
                                      const uint8_t *const aPktBuf)
{
    int32_t retVal;

    if ((ETHER_TIMEHWIDMAX <= aID)
            || (NULL == aPktBuf)) {
        retVal = BCM_ERR_INVAL_PARAMS;
        goto exit;
    }

    if (ETHER_TIMESTATE_INIT2 != ETHER_TimeRWData.state) {
        retVal = BCM_ERR_UNINIT;
        goto exit;
    }

    retVal = ETHER_TimeUpdateTxConfWaitQEntry(aBufIdx, aPktBuf);

exit:
    return retVal;
}

/**
 * @trace #BRCM_SWARCH_ETHER_SEND_PROC
 * @trace #BRCM_SWREQ_ETHER_TIME
 */
static int32_t ETHER_TimeDisableEgressTS(uint32_t aID,
                                    uint32_t aBufIdx)
{
    int32_t retVal;

    if (ETHER_TIMEHWIDMAX <= aID) {
        retVal = BCM_ERR_INVAL_PARAMS;
        goto exit;
    }

    if (ETHER_TIMESTATE_INIT2 != ETHER_TimeRWData.state) {
        retVal = BCM_ERR_UNINIT;
        goto exit;
    }

    retVal = ETHER_TimeRemoveTxConfWaitQEntry(aBufIdx);

exit:
    return retVal;
}

/**
 * @trace #BRCM_SWARCH_ETHER_GETTXTIMESTAMP_PROC
 * @trace #BRCM_SWREQ_ETHER_TIME
 */
int32_t ETHER_TimeGetEgressTS(uint32_t aID,
                                   uint32_t aPortIdx,
                                   uint32_t aBufIdx,
                                   ETHER_TimestampType* const aTS,
                                   ETHER_TimestampQualType* const aTSQual)
{
    int32_t             retVal;
    ETHER_TimeTSInfoType  tsInfo;
    uint32_t            hwIdx = ETHER_TIMEPORT2HWIDX(aPortIdx);
    uint32_t            portIdx = ETHER_TIMEPORT2PORTIDX(aPortIdx);

    if ((ETHER_TIMEHWIDMAX <= aID)
            || (NULL == aTS)
            || (NULL == aTSQual)
            || (P1588_MAX_TIMEHW_ID <= hwIdx)
            || (P1588_PORT_COUNT <= portIdx)) {
        retVal = BCM_ERR_INVAL_PARAMS;
        goto exit;
    }

    if (ETHER_TIMESTATE_INIT2 != ETHER_TimeRWData.state) {
        retVal = BCM_ERR_UNINIT;
        goto exit;
    }

    if (!ETHER_TIMEISPORTENABLED(hwIdx, portIdx)) {
        retVal = BCM_ERR_INVAL_PARAMS;
        goto exit;
    }

    retVal = ETHER_TimeRetrieveSeqType(aBufIdx, &(tsInfo.sequenceId),
                                    &(tsInfo.msgType));
    if (BCM_ERR_OK != retVal) {
        goto exit;
    }

    tsInfo.rxtx = ETHER_TIMETXTIMESTAMP;
    retVal = ETHER_TimeReadTS(hwIdx, portIdx, &tsInfo);
    if (BCM_ERR_OK == retVal) {
        *aTSQual = ETHER_TIMESTAMPQUAL_VALID;
        /*
         * Convert the timestamp to global time from ether hardware time.
         */
        aTS->seconds = tsInfo.seconds + (ETHER_TimeRWData.sysTimeDiffNs / BCM_NS_PER_SEC);
        /* TODO: what if it jumps to the next second? */
        aTS->nanoseconds = tsInfo.nanoseconds
            + (uint32_t)(ETHER_TimeRWData.sysTimeDiffNs % BCM_NS_PER_SEC);
        ETHER_TimeAddGlobalSystimeDiff(aTS);
    } else {
        *aTSQual = ETHER_TIMESTAMPQUAL_INVALID;
        aTS->seconds = 0ULL;
        aTS->nanoseconds = 0UL;
        retVal = BCM_ERR_OK;
    }
    ETHER_TimeFreeTxWaitQEntry(aBufIdx, &tsInfo);

exit:
    return retVal;
}

/**
 * @trace #BRCM_SWARCH_ETHER_GETRXTIMESTAMP_PROC
 * @trace #BRCM_SWREQ_ETHER_TIME
 */
int32_t ETHER_TimeGetIngressTS(uint32_t aID,
                                    uint32_t aPortIdx,
                                    const uint8_t* const aPktBuf,
                                    ETHER_TimestampType* const aTS,
                                    ETHER_TimestampQualType* const aTSQual)
{
    int32_t             retVal;
    ETHER_TimeTSInfoType  tsInfo;
    uint32_t            hwIdx = ETHER_TIMEPORT2HWIDX(aPortIdx);
    uint32_t            portIdx = ETHER_TIMEPORT2PORTIDX(aPortIdx);

    if ((ETHER_TIMEHWIDMAX <= aID)
            || (NULL == aPktBuf)
            || (NULL == aTS)
            || (NULL == aTSQual)
            || (P1588_MAX_TIMEHW_ID <= hwIdx)
            || (P1588_PORT_COUNT <= portIdx)) {
        retVal = BCM_ERR_INVAL_PARAMS;
        goto exit;
    }

    if (ETHER_TIMESTATE_INIT2 != ETHER_TimeRWData.state) {
        retVal = BCM_ERR_UNINIT;
        goto exit;
    }

    if (!ETHER_TIMEISPORTENABLED(hwIdx, portIdx)) {
       retVal = BCM_ERR_INVAL_PARAMS;
        goto exit;
    }

    retVal = ETHER_TimeParseSeqType(aPktBuf, &(tsInfo.sequenceId),
                                    &(tsInfo.msgType));
    if (BCM_ERR_OK == retVal) {
        /* Fetch the timestamp from the S/W FIFO */
        tsInfo.rxtx = ETHER_TIMERXTIMESTAMP;
        retVal = ETHER_TimeReadTS(hwIdx, portIdx, &tsInfo);
        if (BCM_ERR_OK == retVal) {
            *aTSQual = ETHER_TIMESTAMPQUAL_VALID;
            /*
             * Convert the timestamp to global time from ether hardware time.
             */
            aTS->seconds = tsInfo.seconds + (ETHER_TimeRWData.sysTimeDiffNs / BCM_NS_PER_SEC);
            aTS->nanoseconds = tsInfo.nanoseconds
                            + (uint32_t)(ETHER_TimeRWData.sysTimeDiffNs % BCM_NS_PER_SEC);
            ETHER_TimeAddGlobalSystimeDiff(aTS);
        } else {
            *aTSQual = ETHER_TIMESTAMPQUAL_INVALID;
            aTS->seconds = 0ULL;
            aTS->nanoseconds = 0UL;
            retVal = BCM_ERR_OK;
        }
    }

exit:
    return retVal;
}

/**
 * @trace #BRCM_SWARCH_ETHER_SETTIME_PROC
 * @trace #BRCM_SWREQ_ETHER_TIME
 */
static int32_t ETHER_TimeSetTime(uint32_t aID,
                               const ETHER_TimestampType *const aTS)
{
    int32_t             retVal = BCM_ERR_OK;
#ifdef ETHER_TIME_HW_CLOCK_UPDATE
    uint32_t            i;
#else
#ifdef ETHER_TIME_USES_HB_TIME
    ETHER_TimestampType ethTimeHB;
#else
    BCM_TimeType        ethTimeSys;
#endif
    uint64_t            ethTime_ns;
    uint64_t            globalTime_ns;
#endif

    if ((ETHER_TIMEHWIDMAX <= aID)
            || (NULL == aTS)) {
        retVal = BCM_ERR_INVAL_PARAMS;
        goto exit;
    }

    if (ETHER_TIMESTATE_INIT2 != ETHER_TimeRWData.state) {
        retVal = BCM_ERR_UNINIT;
        goto exit;
    }

#ifdef ETHER_TIME_HW_CLOCK_UPDATE
    for (i = 0UL; i < P1588_MAX_TIMEHW_ID; i++) {
        /* Set time codei*/
        ETHER_P1588REGS[i]->time_code_0 = (uint16_t)aTS->nanoseconds;
        ETHER_P1588REGS[i]->time_code_1 = (uint16_t)(aTS->nanoseconds >> 16U);
        ETHER_P1588REGS[i]->time_code_2 = (uint16_t)(aTS->seconds);
        ETHER_P1588REGS[i]->time_code_3 = (uint16_t)(aTS->seconds >> 16U);
        ETHER_P1588REGS[i]->time_code_4 = (uint16_t)(aTS->seconds >> 32U);

        /* en_shadow_cnt_ld_BR0 */
        ETHER_P1588REGS[i]->shd_ctl = (P1588_SHD_CTL_F8_C_MASK | P1588_SHD_CTL_F11_C_MASK);
        ETHER_P1588REGS[i]->shd_ld = (P1588_SHD_LD_F8_L_MASK | P1588_SHD_LD_F11_L_MASK);

        ETHER_P1588REGS[i]->nse_nco_6 |= P1588_NSE_NCO_6_NSE_INIT_MASK;
    }

    ETHER_TimeGenInternalSync();
    for (i = 0UL; i < P1588_MAX_TIMEHW_ID; i++) {
        ETHER_P1588REGS[i]->shd_ld = 0U;
        ETHER_P1588REGS[i]->nse_nco_6 &= ~P1588_NSE_NCO_6_NSE_INIT_MASK;
    }
    ETHER_TIMEIO_REGS->p1588_sync_gen = 0U;
#else /* SW clock update */
#ifdef ETHER_TIME_USES_HB_TIME
    retVal = ETHER_TimeGetHBTime(&ethTimeHB);
#else
    /* Get the sytem time */
    BCM_GetSystemTime(&ethTimeSys);
    ethTimeHB.seconds = ethTimeSys.s;
    ethTimeHB.nanoseconds = ethTimeSys.ns;
#endif
    if (BCM_ERR_OK == retVal) {
        ETHER_TIMECONVERTTIMESTAMP2NSECS(ethTimeHB, ethTime_ns);
        ETHER_TIMECONVERTTIMESTAMP2NSECS(*aTS, globalTime_ns);

        if (ethTime_ns > globalTime_ns) {
            ETHER_TimeRWData.globalSysTimeDiff.isNegative = 1UL;
            ethTime_ns -= globalTime_ns;
            ETHER_TIMECONVERTNSECS2TIMESTAMP(ETHER_TimeRWData.globalSysTimeDiff.absTimestampDiff, ethTime_ns);
        } else {
            ETHER_TimeRWData.globalSysTimeDiff.isNegative = 0UL;
            globalTime_ns -= ethTime_ns;
            ETHER_TIMECONVERTNSECS2TIMESTAMP(ETHER_TimeRWData.globalSysTimeDiff.absTimestampDiff, globalTime_ns);
        }
    }
#endif

exit:
    return retVal;
}

/**
 * @trace #BRCM_SWARCH_ETHER_GETTIME_PROC
 * @trace #BRCM_SWREQ_ETHER_TIME
 */
static int32_t ETHER_TimeGetTime(uint32_t aID,
                               ETHER_TimestampType *const aTS,
                               ETHER_TimestampQualType *const aTSQual)
{
    int32_t             retVal = BCM_ERR_OK;
#ifndef ETHER_TIME_USES_HB_TIME
    BCM_TimeType        ethTime;
#endif

    if ((ETHER_TIMEHWIDMAX <= aID)
            || (NULL == aTS)
            || (NULL == aTSQual)) {
        retVal = BCM_ERR_INVAL_PARAMS;
        goto exit;
    }

    if (ETHER_TIMESTATE_INIT2 != ETHER_TimeRWData.state) {
        retVal = BCM_ERR_UNINIT;
        goto exit;
    }

    /* Get the system or heartbeat time */
#ifdef ETHER_TIME_USES_HB_TIME
    retVal = ETHER_TimeGetHBTime(aTS);
#else
    BCM_GetSystemTime(&ethTime);
    aTS->seconds = ethTime.s;
    aTS->nanoseconds = ethTime.ns;
#endif
    if (BCM_ERR_OK == retVal) {
        ETHER_TimeAddGlobalSystimeDiff(aTS);
        *aTSQual = ETHER_TIMESTAMPQUAL_VALID;
    }

exit:
    return retVal;
}

/**
 * @trace #BRCM_SWARCH_ETHER_SETCORRECTIONTIME_PROC
 * @trace #BRCM_SWREQ_ETHER_TIME
 */
static int32_t ETHER_TimeSetCorrectionTime(uint32_t aID,
                                       const ETHER_TimestampDiffType *const aTD,
                                       const ETHER_RateRatioType *const aRR)
{
    int32_t             retVal = BCM_ERR_OK;
#ifdef ETHER_TIME_HW_CLOCK_UPDATE
    ETHER_TimestampType currentTime;
    uint64_t            currentTime_ns;
#else
    uint64_t            globalTime_ns;
#endif
    uint64_t            correctionOffset_ns;

    if ((ETHER_TIMEHWIDMAX <= aID)
            || (NULL == aTD)
            || (NULL == aRR)) {
        retVal = BCM_ERR_INVAL_PARAMS;
        goto exit;
    }

    if (ETHER_TIMESTATE_INIT2 != ETHER_TimeRWData.state) {
        retVal = BCM_ERR_UNINIT;
        goto exit;
    }

#ifdef ETHER_TIME_HW_CLOCK_UPDATE
    /* Check if it makes sense to perform a delta update or not */
    ETHER_TIMECONVERTTIMESTAMP2NSECS(aTD->absTimestampDiff, correctionOffset_ns);
    if (correctionOffset_ns > ETHER_TIME_HW_DELTA_UPDATE_THRESHOLD_NS) {
        /* Fetch current time */
        retVal = ETHER_TimeGetHBTime(&currentTime);
        if (BCM_ERR_OK == retVal) {
            ETHER_TIMECONVERTTIMESTAMP2NSECS(currentTime, currentTime_ns);
            if (aTD->isNegative == TRUE) {
                currentTime_ns -= correctionOffset_ns;
            } else {
                currentTime_ns += correctionOffset_ns;
            }
            ETHER_TIMECONVERTNSECS2TIMESTAMP(currentTime, currentTime_ns);
            /* Invoke a SetTime */
            retVal = ETHER_TimeSetTime(aID, &currentTime);
        }
    } else {
        uint32_t i;
        uint16_t regVal;
        uint64_t newRate = ((aRR->grandMasterDiff.absTimestampDiff.nanoseconds * P1588_NSE_REG_NCO_FREQCNTRL) / aRR->localDiff.absTimestampDiff.nanoseconds);
        for (i = 0UL;i < P1588_MAX_TIMEHW_ID; i++) {
            ETHER_P1588REGS[i]->nse_nco_1_lsb = (uint16_t)newRate;
            ETHER_P1588REGS[i]->nse_nco_1_msb = (uint16_t)(newRate >> 16ULL);
        }

        while (correctionOffset_ns >= P1588_MAX_DELTA_VALUE) {
            regVal = P1588_MAX_DELTA_VALUE;
            correctionOffset_ns -= P1588_MAX_DELTA_VALUE;

            if (aTD->isNegative == TRUE) {
                /* Convert to two's complement */
                regVal = ETHER_TIME_2_COMPLEMENT(P1588_MAX_DELTA_VALUE);
            }

            /* Update to the 80 bit counter */
            regVal |= P1588_TIMESTAMP_DELTA_DELTA1_MASK;

            for (i = 0UL;i < P1588_MAX_TIMEHW_ID; i++) {
                ETHER_P1588REGS[i]->timestamp_delta = regVal;
            }
        }

        if (correctionOffset_ns > 0ULL) {
            regVal = correctionOffset_ns;
            if (aTD->isNegative == TRUE) {
                /* Convert to two's complement */
                regVal = ETHER_TIME_2_COMPLEMENT(regVal);
            }

            /* Update to the 80 bit counter */
            regVal |= P1588_TIMESTAMP_DELTA_DELTA1_MASK;

            for (i = 0UL;i < P1588_MAX_TIMEHW_ID; i++) {
                ETHER_P1588REGS[i]->timestamp_delta = regVal;
            }
        }
    }
#else
    /* Keep accumulating the correction offset */
    if (aTD->isNegative == ETHER_TimeRWData.globalSysTimeDiff.isNegative) {
        /*
         * Signs match so we can do addition and not worry about the
         * sign.
         */
        ETHER_TimeRWData.globalSysTimeDiff.absTimestampDiff.seconds +=
            aTD->absTimestampDiff.seconds;
        ETHER_TimeRWData.globalSysTimeDiff.absTimestampDiff.nanoseconds +=
            aTD->absTimestampDiff.nanoseconds;
        /* check overflow in nanoseconds field */
        if (ETHER_TimeRWData.globalSysTimeDiff.absTimestampDiff.nanoseconds
                >= BCM_NS_PER_SEC) {
            ETHER_TimeRWData.globalSysTimeDiff.absTimestampDiff.seconds++;
            ETHER_TimeRWData.globalSysTimeDiff.absTimestampDiff.nanoseconds
                -= BCM_NS_PER_SEC;
        }
    } else {
        /* Figure out whose absolute value is greater */
        ETHER_TIMECONVERTTIMESTAMP2NSECS(ETHER_TimeRWData.globalSysTimeDiff.absTimestampDiff,
                            globalTime_ns);
        ETHER_TIMECONVERTTIMESTAMP2NSECS(aTD->absTimestampDiff, correctionOffset_ns);
        if (globalTime_ns > correctionOffset_ns) {
            /* Sign remains the same, only the absolute value changes */
            globalTime_ns -= correctionOffset_ns;
        } else {
            /* Sign changes */
            ETHER_TimeRWData.globalSysTimeDiff.isNegative += 1UL;
            if (ETHER_TimeRWData.globalSysTimeDiff.isNegative > 1UL) {
                ETHER_TimeRWData.globalSysTimeDiff.isNegative = 0UL;
            }

            globalTime_ns = correctionOffset_ns - globalTime_ns;
        }

        ETHER_TIMECONVERTNSECS2TIMESTAMP(ETHER_TimeRWData.globalSysTimeDiff.absTimestampDiff, globalTime_ns);
    }
#endif
    ETHER_TimeRWData.globalRateRatio = *aRR;

exit:
    return retVal;
}

/**
    @trace  #BRCM_SWARCH_ETHER_TIMESTAMPIRQHANDLER_PROC
    @trace  #BRCM_SWREQ_ETHER_KERNEL_HANDLER
*/
static void ETHER_TimeFrameSyncIRQHandler(uint32_t aID, uint16_t aIRQStatus)
{
    ETHER_TimeP1588InfoType * p1588Info = &(ETHER_TimeRWData.p1588Info[aID]);

    if (P1588_INT_STAT_INTC_FSYNC_MASK == (aIRQStatus & P1588_INT_STAT_INTC_FSYNC_MASK)) {
        /* Read Heartbeat register to clear the interrupt */
        ETHER_P1588REGS[aID]->cntr_dbg = P1588_CNTR_DBG_HB_CNTL_START_MASK;
        ETHER_P1588REGS[aID]->heartbeat_0 |= 0U;
        ETHER_P1588REGS[aID]->heartbeat_1 |= 0U;
        ETHER_P1588REGS[aID]->heartbeat_2 |= 0U;
        ETHER_P1588REGS[aID]->cntr_dbg = P1588_CNTR_DBG_HB_CNTL_END_MASK;
        p1588Info->frmSyncIntrCnt++;
    }
}

/**
    @trace  #BRCM_SWARCH_ETHER_TIMESTAMPIRQHANDLER_PROC
    @trace  #BRCM_SWREQ_ETHER_KERNEL_HANDLER
*/
static void ETHER_TimeReadTimeHWStampFIFO(uint32_t aHwIdx, uint32_t aPort)
{
    uint32_t i;
    uint16_t ts0, ts1, ts2, ts3, ts_info1, ts_info2;
    ETHER_TimeTSInfoType *pTimestamp;
    ETHER_TimeP1588InfoType * p1588Info = &(ETHER_TimeRWData.p1588Info[aHwIdx]);
    ETHER_TimePortInfoType * portInfo = p1588Info->portInfo[aPort];
    portInfo->pktTSIntrCnt++;

    /* Read the timestamp from the FIFO, one at a time */
    for (i = 0UL; i < P1588_FIFO_DEPTH; i++) {
        /* Enable TS_SLICE_SEL for the port */
        ETHER_P1588REGS[aHwIdx]->cntr_dbg &= ~(P1588_CNTR_DBG_TS_SLICE_SEL_MASK);
        ETHER_P1588REGS[aHwIdx]->cntr_dbg |= ((aPort << P1588_CNTR_DBG_TS_SLICE_SEL_SHIFT)
                                        & P1588_CNTR_DBG_TS_SLICE_SEL_MASK);

        /* Set the start bit to read the timestamp */
        ETHER_P1588REGS[aHwIdx]->ts_read_start_end =
            (P1588_TS_READ_START_END_PORT0_START_MASK << (2UL * aPort));
        ETHER_P1588REGS[aHwIdx]->ts_read_start_end =
            P1588_TS_READ_START_END_PORT_TS_MASK;

        /* Read the timestamp */
        ts0 = ETHER_P1588REGS[aHwIdx]->time_stamp_0;
        ts1 = ETHER_P1588REGS[aHwIdx]->time_stamp_1;
        ts2 = ETHER_P1588REGS[aHwIdx]->time_stamp_2;
        ts3 = ETHER_P1588REGS[aHwIdx]->time_stamp_3;

        ts_info1 = ETHER_P1588REGS[aHwIdx]->time_stamp_info_1;
        ts_info2 = ETHER_P1588REGS[aHwIdx]->time_stamp_info_2;

        /* Set the end bit */
        ETHER_P1588REGS[aHwIdx]->ts_read_start_end =
            (P1588_TS_READ_START_END_PORT0_END_MASK << (2UL * aPort));
        ETHER_P1588REGS[aHwIdx]->ts_read_start_end =
            P1588_TS_READ_START_END_PORT_TS_MASK;

        /* Store the timestamp only if it is different from
         * previous read */
        if ((ts0 != portInfo->prevTS0) ||
                (ts1 != portInfo->prevTS1) ||
                (ts2 != portInfo->prevTS2) ||
                (ts3 != portInfo->prevTS3) ||
                (portInfo->prevTSInfo1 != ts_info1) ||
                (portInfo->prevTSInfo2 != ts_info2))
        {
            portInfo->prevTS0 = ts0;
            portInfo->prevTS1 = ts1;
            portInfo->prevTS2 = ts2;
            portInfo->prevTS3 = ts3;
            portInfo->prevTSInfo1 = ts_info1;
            portInfo->prevTSInfo2 = ts_info2;

            pTimestamp = &portInfo->tsInfo[portInfo->curTSIdx];
            pTimestamp->seconds =
                ((uint64_t)ts3 << (uint64_t)ETHER_1588_TS_3_NS_OFFSET)
                | (uint64_t)ts2;
            pTimestamp->nanoseconds =
                ((uint32_t)ts1 << (uint32_t)ETHER_1588_TS_1_SECS_OFFSET)
                | (uint32_t)ts0;

            pTimestamp->sequenceId = ts_info2;

            pTimestamp->msgType =
                (uint32_t)((ts_info1 & P1588_TIME_STAMP_INFO_1_MSGTYPE_MASK)
                        >> P1588_TIME_STAMP_INFO_1_MSGTYPE_OFFSET);

            pTimestamp->rxtx = ((ts_info1 & P1588_TIME_STAMP_INFO_1_RXTX_MASK) != 0U)
                                ? 1UL : 0UL;

            portInfo->curTSIdx++;
            if (portInfo->curTSIdx >= P1588_FIFO_DEPTH) {
                portInfo->curTSIdx = 0U;
            }
        }
    }
}

/**
    @trace  #BRCM_SWARCH_ETHER_TIMESTAMPIRQHANDLER_PROC
    @trace  #BRCM_SWREQ_ETHER_KERNEL_HANDLER
*/
static void ETHER_TimePacketTimeStampIRQHandler(uint32_t aHwIdx, uint16_t aIRQStatus)
{
    uint32_t port;
    uint16_t mask;

    for (port = 0UL; port < P1588_PORT_COUNT; port++) {
        mask = P1588_INT_STAT_INTC_SOP_PORT0_MASK << port;
        if ((mask == (aIRQStatus & mask))
                && (0UL != (P1588_PORT_MASK
                        & (0x1UL << ((8UL * aHwIdx) + port))))) {
                ETHER_TimeReadTimeHWStampFIFO(aHwIdx, port);
        }
    }
}

/**
    @trace  #BRCM_SWARCH_ETHER_TIMESTAMPIRQHANDLER_PROC
    @trace  #BRCM_SWREQ_ETHER_KERNEL_HANDLER
*/
void ETHER_TimestampIRQHandler(uint32_t aID)
{
    uint16_t regVal;
    uint32_t i;

    ETHER_TimeRWData.totalIntrCnt++;

    if (ETHER_TIMEHWIDMAX > aID) {
        /* Check interrupt status for timestamp */
        for (i = 0UL; i < P1588_MAX_TIMEHW_ID; i++) {
            regVal = ETHER_P1588REGS[i]->int_stat;

            /* Process frame sync interrupt */
            ETHER_TimeFrameSyncIRQHandler(i, regVal);

            /* Process packet time stamp interrupt */
            ETHER_TimePacketTimeStampIRQHandler(i, regVal);
        }
    }
}

/**
    @trace  #BRCM_SWARCH_ETHER_SYSCMDHANDLER_PROC
    @trace  #BRCM_SWREQ_ETHER_KERNEL_HANDLER
*/
static int32_t ETHER_TimeCmdHandler(ETHER_TimeIOCmdType aCmd,
                                    ETHER_TimeIOType *const aIO)
{
    int32_t retVal;

    if (NULL != aIO) {
        switch (aCmd) {
        case ETHER_TIMEIOCMD_TIME_INIT:
            retVal = ETHER_TimeIntInit(aIO->hwID, aIO->timeCfg);
            break;
        case ETHER_TIMEIOCMD_TIME_INIT_STATE_HANDLER:
            retVal = ETHER_TimeIntInitStateHandler(aIO->hwID,
                                            aIO->initCmd,
                                            aIO->sysTimeDiffNs,
                                            aIO->timeVal);
            break;
        case ETHER_TIMEIOCMD_ENABLE_EGRESS_TIMESTAMP:
            retVal = ETHER_TimeEnableEgressTS(aIO->hwID,
                                            aIO->portIdx,
                                            *(aIO->buffIdxInOut));
            break;
        case ETHER_TIMEIOCMD_DISABLE_EGRESS_TIMESTAMP:
            retVal = ETHER_TimeDisableEgressTS(aIO->hwID,
                                            *(aIO->buffIdxInOut));
            break;
        case ETHER_TIMEIOCMD_UPDATE_EGRESS_PKT_INFO:
            retVal = ETHER_TimeUpdateEgressPktInfo(aIO->hwID,
                                            *(aIO->buffIdxInOut),
                                            aIO->pktBuf);
            break;
        case ETHER_TIMEIOCMD_GET_EGRESS_TIMESTAMP:
            retVal = ETHER_TimeGetEgressTS(aIO->hwID,
                                        aIO->portIdx,
                                        *(aIO->buffIdxInOut),
                                        aIO->timestamp,
                                        aIO->tsQuality);
            break;
        case ETHER_TIMEIOCMD_GET_INGRESS_TIMESTAMP:
            retVal = ETHER_TimeGetIngressTS(aIO->hwID,
                                        aIO->portIdx,
                                        aIO->pktBuf,
                                        aIO->timestamp,
                                        aIO->tsQuality);
            break;
        case ETHER_TIMEIOCMD_GET_TIME:
            retVal = ETHER_TimeGetTime(aIO->hwID,
                                    aIO->timestamp,
                                    aIO->tsQuality);
            break;
        case ETHER_TIMEIOCMD_SET_TIME:
            retVal = ETHER_TimeSetTime(aIO->hwID, aIO->roTimestamp);
            break;
        case ETHER_TIMEIOCMD_SET_CORRECTION_TIME:
            retVal = ETHER_TimeSetCorrectionTime(aIO->hwID,
                                            aIO->tsDiff,
                                            aIO->roRateRatio);
            break;
        case ETHER_TIMEIOCMD_PROCESS_TS:
            retVal = ETHER_TimeProcessTS(aIO->hwID,
                                         aIO->buffIdxInOut);
            break;
        default:
            retVal = BCM_ERR_INVAL_PARAMS;
            ETHER_TimeReportError(aIO->hwID,
                                BRCM_SWDSGN_ETHER_TIMECMDHANDLER_PROC,
                                retVal, aCmd, 0UL, 0UL, 0UL);
            break;
        }
    } else {
        retVal = BCM_ERR_UNKNOWN;
    }

    return retVal;
}

/**
    @brief Union to avoid MISRA Required error
    for Type conversion

    @trace  #BRCM_SWARCH_ETHER_SYSCMDREQ_PROC
    @trace  #BRCM_SWARCH_ETHER_SYSCMDHANDLER_PROC
    @trace  #BRCM_SWREQ_ETHER_KERNEL_INTERFACE
*/
typedef union uETHER_TimeSVCIOType {
    uint8_t *data;
    ETHER_TimeIOType *io;
} ETHER_TimeSVCIOType;

/**
    @code{.c}
    if aSysIO.ethIO is not NULL
        if aMagicID is SVC_MAGIC_AMC_ID
            aSysIO.ethIO.retVal = ETHER_TimeCmdHandler(aCmd, aSysIO.ethIO)
        else
            aSysIO.ethIO.retVal = BCM_ERR_INVAL_MAGIC
    @endcode

    @trace  #BRCM_SWARCH_ETHER_SYSCMDHANDLER_PROC
    @trace  #BRCM_SWREQ_ETHER_KERNEL_HANDLER
*/
//! [Usage of ETHER_TimeCmdHandler]
void ETHER_TimeSysCmdHandler(uint32_t aMagicID, uint32_t aCmd, uint8_t * aSysIO)
{
    ETHER_TimeSVCIOType ether;
    ether.data = aSysIO;

    if (NULL != aSysIO) {
        if (SVC_MAGIC_ETT_ID == aMagicID) {
            ether.io->retVal = ETHER_TimeCmdHandler(aCmd, ether.io);
        } else {
            ether.io->retVal = BCM_ERR_INVAL_MAGIC;
        }
    }
}
//! [Usage of ETHER_CmdHandler]

/* Nothing past this line */
