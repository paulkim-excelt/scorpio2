/*****************************************************************************
 Copyright 2016-2021 Broadcom Limited.  All rights reserved.

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

/** @brief Integration test for Ethernet driver
 */

#include "ee.h"
#include <string.h>
#include <ulog.h>
#include <bcm_utils.h>
#include <ethernet.h>
#include <osil/eth_osil.h>
#include <bcm_err.h>
#include <bcm_test.h>
#include <osil/bcm_osil.h>
#include <bcm_time.h>
#ifndef __BCM8958X__
#include <p1588_rdb.h>
#endif
#include <ethernet_qt.h>

#define GetModuleLogLevel()     ULOG_LVL_ERROR

#define ETHER_HW_ID             (0UL)
#define ETHERNET_TX_IT1         (1UL)
#define ETHERNET_TX_IT2         (2UL)
#define ETHIT1_PKT_LEN          (52UL)
#define ETHIT1_FIXED_PKT_LEN    (51UL)
#define ETHIT1_PKT_CNT          (10UL)
#define CLOCK_TICK_TO_NS        (3125000ULL)  /* 3.125ms * 1000 * 1000 */
#define TIME_CONVERT_TIMESTAMP_2_NSECS(_ts, _nsecs) \
        (_nsecs) = (_ts).seconds * (uint64_t)BCM_NS_PER_SEC \
                    + (uint64_t) ((_ts).nanoseconds);
#define CLOCK_TICK_DELAY (30ULL)
#define ETHER_GET_TIME_DELAY_NS (8600UL)
#define ETHER_TIME_SW_DELTA_UPDATE_THRESHOLD_NS (40000000UL * 2UL)

#ifdef ETHER_TIME_HW_CLOCK_UPDATE
#define ETHER_TIME_DELTA_UPDATE_THRESHOLD_NS (ETHER_TIME_HW_DELTA_UPDATE_THRESHOLD_NS * 2UL)
#else
#define ETHER_TIME_DELTA_UPDATE_THRESHOLD_NS ETHER_TIME_SW_DELTA_UPDATE_THRESHOLD_NS
#endif /* ifdef(ETHER_TIME_HW_CLOCK_UPDATE) */

#define MARK_ERR(ret, line) {ULOG_ERR("\nError: %ld, \tline %d", ret, line); EthIT1_Status = ret;}

#if defined(__BCM8953X__)
#define ETHER_NEGATIVE_TIME_CORRECT_LOOP_COUNT (2UL)
#else
#define ETHER_NEGATIVE_TIME_CORRECT_LOOP_COUNT (1UL)
#endif

static const uint8_t EthIT1_MacAddr[6] = {0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF};

#ifndef __BCM8958X__
static ETHER_TimeCfgType EthIT1_TimeConfig[] = {
    {
        .hwIdx = 0UL,
        .portEnableMask = P1588_PORT_MASK,
#if defined(__BCM8910X__)
        .sync = ETHER_TIMESYNC_NONE,
#endif
#if defined(__BCM8953X__) || defined(__BCM8956X__) || defined(__BCM8957X__)
        .sync = ETHER_TIMESYNC_INTERNAL,
#endif
    },
};

ETHER_TimeCfgType *const ETHER_TimeCfg = EthIT1_TimeConfig;
const uint32_t ETHER_TimeCfgSize = sizeof(EthIT1_TimeConfig)/
                                    sizeof(ETHER_TimeCfgType);
#endif

static const ETHER_CfgType EthIT1_Config = {
    .hwID = 0UL,
    .speed = ETHER_SPEED_100MBPS,
    .duplexMode = ETHER_DUPLEX_MODE_FULL,
    .maxRxFrmLen = 1522UL,
    .macAddr = EthIT1_MacAddr,
#if defined(__BCM8908X__)
    .prioChanMap[0] = 0UL,
    .prioChanMap[1] = 0UL,
    .prioChanMap[2] = 1UL,
    .prioChanMap[3] = 1UL,
    .prioChanMap[4] = 2UL,
    .prioChanMap[5] = 2UL,
    .prioChanMap[6] = 3UL,
    .prioChanMap[7] = 3UL,
#endif
#if defined(__BCM8910X__)
    .prioChanMap[0] = 0UL,
    .prioChanMap[1] = 0UL,
    .prioChanMap[2] = 1UL,
    .prioChanMap[3] = 1UL,
    .prioChanMap[4] = 2UL,
    .prioChanMap[5] = 2UL,
    .prioChanMap[6] = 3UL,
    .prioChanMap[7] = 3UL,
#endif
#if defined(__BCM8953X__)
    .prioChanMap[0] = 0UL,
    .prioChanMap[1] = 0UL,
    .prioChanMap[2] = 0UL,
    .prioChanMap[3] = 0UL,
    .prioChanMap[4] = 0UL,
    .prioChanMap[5] = 0UL,
    .prioChanMap[6] = 0UL,
    .prioChanMap[7] = 0UL,
#endif
};


static const uint8_t EthIT1_FixedPktPattern[ETHIT1_FIXED_PKT_LEN] = {
    0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x00, 0x00, 0x00, 0x00, 0x9F, 0x18,
    0x08, 0x00, 0x45, 0x74, 0x68, 0x65, 0x72, 0x6E, 0x65, 0x74, 0x20, 0x54,
    0x65, 0x73, 0x74, 0x20, 0x41, 0x50, 0x50, 0x3A, 0x20, 0x54, 0x65, 0x73,
    0x74, 0x20, 0x50, 0x61, 0x63, 0x6B, 0x65, 0x74, 0x20, 0x43, 0x44, 0x55,
    0x11, 0x55, 0xAA,
};

static uint32_t EthIT1_TxCbCnt = 0UL;
static uint32_t EthIT1_RxCbCnt = 0UL;
static uint32_t EthIT1_TxPktCnt = 0UL;

#define ETHIT1_TIMEOUT_CNT_MAX  (10UL)

static volatile int32_t EthIT1_Status = BCM_AT_NOT_STARTED;

static uint32_t EthIT1_PatCompOffset = 0UL;

#define ETHIT1_WAIT_FOR_EVENTS (ETHER_PKT_EVENT)

uint32_t ETHIT_Current;

void EthIT1_WaitEvent(void)
{
    uint32_t waitMask = ETHIT1_WAIT_FOR_EVENTS;
    uint32_t mask = 0UL;

    do {
        BCM_WaitEvent(waitMask);
        BCM_GetEvent(EthIT1_Client, &mask);
        BCM_ClearEvent(mask);

        if (ETHER_PKT_EVENT == (mask & ETHER_PKT_EVENT)) {
            /* Process Ethernet */
            while (EthIT1_RxCbCnt != EthIT1_TxPktCnt) {
                ETHER_ProcessPkts(0UL);
            }
            break;
        }
    } while (1);

    return;
}
/* Rx Callback */
void ETHER_RxInd (ETHER_HwIDType aID, const uint8_t *const aBuf,
                uint32_t aLen, const uint8_t *const aSrcMacAddr,
                const uint8_t *const aDestMacAddr)
{
    int32_t retVal;
    uint32_t pktNum;
    /* Compare source address */
    retVal =  memcmp(aSrcMacAddr, &EthIT1_MacAddr, ETHER_MAC_ADDR_SIZE);
    if (0UL != retVal) {
        retVal = BCM_ERR_DATA_INTEG;
        MARK_ERR(retVal, __LINE__);
    }

    /* Compare destination address */
    retVal =  memcmp(aDestMacAddr, &EthIT1_FixedPktPattern[6UL], ETHER_MAC_ADDR_SIZE);
    if (0UL != retVal) {
        retVal = BCM_ERR_DATA_INTEG;
        MARK_ERR(retVal, __LINE__);
   }

    retVal = memcmp((void *)aBuf, &EthIT1_FixedPktPattern[EthIT1_PatCompOffset],
            aLen - EthIT1_PatCompOffset - 1UL);
    if (0 == retVal) {
        pktNum = aBuf[aLen - 1UL];
        if (pktNum == (EthIT1_RxCbCnt & 0xFF) ) {
            EthIT1_RxCbCnt++;
        } else {
            retVal = BCM_ERR_DATA_INTEG;
            ULOG_ERR("pktNum:0x%x, EthIT1_RxCbCnt:0x%x", pktNum, EthIT1_RxCbCnt);
            MARK_ERR(retVal, __LINE__);
        }
    } else {
        retVal = BCM_ERR_DATA_INTEG;
        MARK_ERR(retVal, __LINE__);
    }
}
/* Tx Callback */
void ETHER_TxDoneInd (ETHER_HwIDType aID, uint32_t aBufIndx,
                    ETHER_ResultType aResult)
{
    if (ETHER_RESULT_SUCCESS != aResult) {
        MARK_ERR(BCM_ERR_DATA_INTEG, __LINE__);
    }

    EthIT1_TxCbCnt++;
}

/* Helper function to set Ethernet controller to Active */
int32_t EthIT_SetModeActive(void)
{
    int32_t retVal;
    ETHER_ModeType mode;

    retVal = ETHER_SetMode(ETHER_HW_ID, ETHER_MODE_ACTIVE);
    if (BCM_ERR_OK == retVal) {
        retVal = ETHER_GetMode(ETHER_HW_ID, &mode);
        if (BCM_ERR_OK == retVal) {
            if (ETHER_MODE_ACTIVE != mode) {
                retVal = BCM_ERR_INVAL_STATE;
            }
        }
    }

    if (BCM_ERR_OK != retVal) {
        MARK_ERR(retVal, __LINE__);
    }

    return retVal;
}

int32_t EthIT1_Transmit(ETHER_HwIDType aHwID, ETHER_PrioType aPriority)
{
    int32_t retVal;
    uint32_t i, bufIdx;
    uint32_t pktLen;
    uint8_t *pktBuf;

    for (i = 0UL; i < ETHIT1_PKT_CNT; ++i) {
        /* Get buffer from Ethernet Driver */
        pktLen = ETHIT1_PKT_LEN;
        retVal = ETHER_GetTxBuffer(aHwID, aPriority, &bufIdx, &pktBuf,
                                   &pktLen);
        if (BCM_ERR_OK != retVal) {
            MARK_ERR(retVal, __LINE__);
            goto err;
        }

        /* Copy the packet to be send, into the buffer */
        memcpy((void *)pktBuf, EthIT1_FixedPktPattern, pktLen - 1UL);
        pktBuf[pktLen - 1UL] = (uint8_t)EthIT1_TxPktCnt;

        /* Send the packet */
        retVal = ETHER_Send(aHwID, 1UL, bufIdx, pktLen,
                            &EthIT1_FixedPktPattern[6UL]);
        if (BCM_ERR_OK != retVal) {
            MARK_ERR(retVal, __LINE__);
            goto err;
        } else {
            EthIT1_TxPktCnt++;
        }
        EthIT1_WaitEvent();
    }
err:
    return retVal;
}

int32_t EthIT1_TransmitTest(ETHER_HwIDType aHwID)
{
    int32_t retVal;
    ETHER_PrioType priority;

    for (priority = 0UL; priority <= ETHER_PRIO_MAX; priority++) {
        /* Channel equal to priority for this test case */
        retVal = EthIT1_Transmit(aHwID, priority);
        if (BCM_ERR_OK != retVal) {
            break;
        }
    }
    return retVal;
}

void ETHIT1_Case()
{
    int32_t retVal;
    EthIT1_TxCbCnt = 0UL;
    EthIT1_RxCbCnt = 0UL;
    EthIT1_TxPktCnt = 0UL;

    /* Initialize Ethernet driver */
    ETHER_Init(ETHER_HW_ID, &EthIT1_Config);

    /* Enable Ethernet Loopback */
    ETHER_EnableLoopBack(ETHER_HW_ID_0);

    /* Set controller mode to Active */
    retVal = EthIT_SetModeActive();
    if (BCM_ERR_OK != retVal) {
        MARK_ERR(retVal, __LINE__);
        goto err;
    }
    /* Transmit packets */
    retVal = EthIT1_TransmitTest(ETHER_HW_ID);
    if (BCM_ERR_OK != retVal) {
        MARK_ERR(retVal, __LINE__);
        goto err;
    }

#ifndef __BCM8958X__
    /* Disable time related tests for ROM */
    ETHER_TimestampType     ts1   = {0ULL, 0UL};
    ETHER_TimestampType     ts2   = {0ULL, 0UL};
    ETHER_TimestampQualType qual = ETHER_TIMESTAMPQUAL_INVALID;
    ETHER_TimestampDiffType timeDiff;
    ETHER_RateRatioType     rateRatio;
    ETHER_TimeCfgType ethTimeCfg;
    uint64_t timestamp_ns1;
    uint64_t timestamp_ns2;

    rateRatio.localDiff.isNegative = FALSE;
    rateRatio.grandMasterDiff.isNegative = FALSE;
    rateRatio.localDiff.absTimestampDiff.seconds = 0ULL;
    rateRatio.grandMasterDiff.absTimestampDiff.seconds = 0ULL;
    /* Set equal non-zero value so that the rate ratio gets computed as 1.0 */
    rateRatio.localDiff.absTimestampDiff.nanoseconds = 1UL;
    rateRatio.grandMasterDiff.absTimestampDiff.nanoseconds = 1UL;

    BCM_MemCpy(&ethTimeCfg, ETHER_TimeCfg, sizeof(ETHER_TimeCfgType));

    ETHER_TimeInit(ETHER_HW_ID, &ethTimeCfg);
    ETHER_TimeInitStateHandler(ETHER_HW_ID, ETHER_TIMEINITCMD_0, 0ULL,  NULL);
    ETHER_TimeInitStateHandler(ETHER_HW_ID, ETHER_TIMEINITCMD_2, 0ULL, NULL);

    retVal = ETHER_GetTime(ETHER_HW_ID, &ts1, &qual);
    if (BCM_ERR_OK != retVal) {
        MARK_ERR(retVal, __LINE__);
        goto err;
    } else {
        ULOG_ERR("ts.s = %llu ts.ns = %lu\n", ts1.seconds, ts1.nanoseconds);
    }
    /* Now wait for upto 30 ticks */
    /* 30 ms delay */
    BCM_CpuNDelay(CLOCK_TICK_DELAY * CLOCK_TICK_TO_NS);
    retVal = ETHER_GetTime(ETHER_HW_ID, &ts2, &qual);
    if (BCM_ERR_OK != retVal) {
        MARK_ERR(retVal, __LINE__);
        goto err;
    } else {
        ULOG_ERR("ts.s = %llu ts.ns = %lu\n", ts2.seconds, ts2.nanoseconds);
    }
    TIME_CONVERT_TIMESTAMP_2_NSECS(ts1, timestamp_ns1);
    TIME_CONVERT_TIMESTAMP_2_NSECS(ts2, timestamp_ns2);
    if((timestamp_ns2 - timestamp_ns1) <= ((CLOCK_TICK_DELAY - 1ULL) * CLOCK_TICK_TO_NS)) {
        MARK_ERR(BCM_ERR_UNKNOWN, __LINE__);
        goto err;
    }
    ts1.seconds = 123456ULL;
    ts1.nanoseconds = 0UL;
    retVal = ETHER_SetTime(ETHER_HW_ID, &ts1);
    if (BCM_ERR_OK != retVal) {
        MARK_ERR(retVal, __LINE__);
        goto err;
    }
    /* 30 ms delay */
    BCM_CpuNDelay(CLOCK_TICK_DELAY * CLOCK_TICK_TO_NS);
    retVal = ETHER_GetTime(ETHER_HW_ID, &ts2, &qual);
    if (BCM_ERR_OK != retVal) {
        MARK_ERR(retVal, __LINE__);
        goto err;
    } else {
        ULOG_ERR("ts.s = %llu ts.ns = %lu\n", ts2.seconds, ts2.nanoseconds);
    }
    TIME_CONVERT_TIMESTAMP_2_NSECS(ts1, timestamp_ns1);
    TIME_CONVERT_TIMESTAMP_2_NSECS(ts2, timestamp_ns2);
    if(((timestamp_ns2 - timestamp_ns1) <= ((CLOCK_TICK_DELAY - 1ULL) * CLOCK_TICK_TO_NS)) ||
        (ts2.seconds != ts1.seconds)) {
        MARK_ERR(BCM_ERR_UNKNOWN, __LINE__);
        goto err;
    }
    timeDiff.isNegative = 0UL;
    timeDiff.absTimestampDiff.seconds = 0ULL;
    timeDiff.absTimestampDiff.nanoseconds = ETHER_TIME_DELTA_UPDATE_THRESHOLD_NS;

    retVal = ETHER_GetTime(ETHER_HW_ID, &ts1, &qual);
    if (BCM_ERR_OK != retVal) {
        MARK_ERR(retVal, __LINE__);
        goto err;
    } else {
        ULOG_ERR("before +%lu set correction : ts.s = %llu ts.ns = %lu\n", timeDiff.absTimestampDiff.nanoseconds, ts1.seconds, ts1.nanoseconds);
    }
    retVal = ETHER_SetCorrectionTime(ETHER_HW_ID, &timeDiff, &rateRatio);
    if (BCM_ERR_OK != retVal) {
        MARK_ERR(retVal, __LINE__);
        goto err;
    }
    retVal = ETHER_GetTime(ETHER_HW_ID, &ts2, &qual);
    if (BCM_ERR_OK != retVal) {
        MARK_ERR(retVal, __LINE__);
        goto err;
    } else {
        ULOG_ERR("after +%lu set correction : ts.s = %llu ts.ns = %lu\n", timeDiff.absTimestampDiff.nanoseconds, ts2.seconds, ts2.nanoseconds);
    }
    TIME_CONVERT_TIMESTAMP_2_NSECS(ts1, timestamp_ns1);
    TIME_CONVERT_TIMESTAMP_2_NSECS(ts2, timestamp_ns2);
    if((timestamp_ns2 - timestamp_ns1) <= (timeDiff.absTimestampDiff.nanoseconds)) {
        MARK_ERR(BCM_ERR_UNKNOWN, __LINE__);
        goto err;
    }
    timeDiff.isNegative = 1UL;

    retVal = ETHER_GetTime(ETHER_HW_ID, &ts1, &qual);
    if (BCM_ERR_OK != retVal) {
        MARK_ERR(retVal, __LINE__);
        goto err;
    } else {
        ULOG_ERR("before -%lu set correction : ts.s = %llu ts.ns = %lu\n", timeDiff.absTimestampDiff.nanoseconds, ts1.seconds, ts1.nanoseconds);
    }
    for(uint32_t i = 0UL; i < ETHER_NEGATIVE_TIME_CORRECT_LOOP_COUNT; i++) {
        retVal = ETHER_SetCorrectionTime(ETHER_HW_ID, &timeDiff, &rateRatio);
        if (BCM_ERR_OK != retVal) {
            MARK_ERR(retVal, __LINE__);
            goto err;
        }
    }
    retVal = ETHER_GetTime(ETHER_HW_ID, &ts2, &qual);
    if (BCM_ERR_OK != retVal) {
        MARK_ERR(retVal, __LINE__);
        goto err;
    } else {
        ULOG_ERR("after -%lu set correction : ts.s = %llu ts.ns = %lu\n", timeDiff.absTimestampDiff.nanoseconds, ts2.seconds, ts2.nanoseconds);
    }
    TIME_CONVERT_TIMESTAMP_2_NSECS(ts1, timestamp_ns1);
    TIME_CONVERT_TIMESTAMP_2_NSECS(ts2, timestamp_ns2);
    if (timestamp_ns1 < timestamp_ns2) {
        MARK_ERR(BCM_ERR_UNKNOWN, __LINE__);
        goto err;
    }
#endif

    /* Deinitialize Ethernet driver */
    ETHER_DeInit(ETHER_HW_ID);

    if ((EthIT1_RxCbCnt == EthIT1_TxCbCnt) && (EthIT1_RxCbCnt != 0UL)){
        EthIT1_Status = BCM_ERR_OK;
    } else {
        MARK_ERR(BCM_ERR_UNKNOWN, __LINE__);
        goto err;
    }

err:
    return;
}

TASK(EthIT1_Client)
{
    if (ETHERNET_TX_IT1 == ETHIT_Current) {
        ETHIT1_Case();
#ifdef ENABLE_ETHERNET_IT
    } else {
        (void)ETHERNET_ExecuteIt(ETHIT_Current);
#endif
    }

    (void)BCM_TerminateTask();
}

int32_t EthIT1_GetResult(void)
{
    return EthIT1_Status;
}

int32_t BCM_ExecuteAT(uint32_t aIndex)
{
    int32_t ret;
    StatusType retOS = E_OK;
    TaskStateType taskState = SUSPENDED;

    switch(aIndex)
    {
    case ETHERNET_TX_IT1:
    case ETHERNET_TX_IT2:
        retOS = GetTaskState(EthIT1_Client, &taskState);
        if (E_OK == retOS) {
            if (SUSPENDED == taskState) {
                ETHIT_Current = aIndex;
                if (BCM_AT_EXECUTING != EthIT1_Status) {
                    EthIT1_Status = BCM_AT_EXECUTING;
                    ret = BCM_ActivateTask(EthIT1_Client);
                    if (BCM_ERR_OK != ret) {
                        EthIT1_Status = BCM_AT_NOT_STARTED;
                        ULOG_ERR("Task activation failed, error: %d\n",
                                ret);
                    }
                }
                ret = BCM_ERR_OK;
            } else {
                EthIT1_Status = BCM_AT_EXECUTING;
                ULOG_ERR("Test is already running\n");
                ret = BCM_ERR_OK;
            }
        } else {
            MARK_ERR(BCM_ERR_UNKNOWN, __LINE__);
            ret = BCM_ERR_UNKNOWN;
        }
        break;
    default:
        ret = BCM_AT_NOT_AVAILABLE;
    }

    return ret;
}

int32_t BCM_GetResultAT(uint32_t aIndex)
{
    int32_t ret;

    switch(aIndex)
    {
    case ETHERNET_TX_IT1:
        ret = EthIT1_GetResult();
        break;
#ifdef ENABLE_ETHERNET_IT
    case ETHERNET_TX_IT2:
        ret = ETHERNET_GetStatusIt(aIndex);
        break;
#endif
    default:
        ret = BCM_AT_NOT_AVAILABLE;
    }

    return ret;
}
