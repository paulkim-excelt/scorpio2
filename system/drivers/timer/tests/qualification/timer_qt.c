/*****************************************************************************
 Copyright 2017-2022 Broadcom Limited.  All rights reserved.

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
#include "ee.h"
#include <bcm_utils.h>
#include <ulog.h>
#include <bcm_err.h>
#include <bcm_test.h>
#include <tim_rdb.h>
#include <shell.h>
#include <osil/bcm_osil.h>
#include <osil/tim_osil.h>

#include "timer_qt.h"
#include "timer_mt.h"
#include "timer_test.h"

#define GetModuleLogLevel()     ULOG_LVL_ERROR

#define CALL(func)                                                              \
        retVal = func;                                                          \
        if (BCM_ERR_OK != retVal) {                                             \
            TimerQtResult = retVal;                                             \
            TimerQtErrCnt++;                                                    \
        }                                                                       \

#define EXECUTE_TEST(case, func, expecRet)                                      \
        BCM_SetTestCase(case);                                                  \
        retVal = func;                                                          \
        if (expecRet == retVal) {                                               \
            BCM_SetTestResult(BCM_ERR_OK);                                      \
        } else {                                                                \
            BCM_SetTestResult(BCM_ERR_UNKNOWN);                                 \
            ULOG_ERR("TIM_QT: Err case: %x, retVal: %x at: %d\n",               \
                                            case, retVal, __LINE__);            \
            TimerQtErrCnt++;                                                    \
        }                                                                       \

#define REPORT_RESULT(case, condition)                                          \
        BCM_SetTestCase(case);                                                  \
        if (condition) {                                                        \
            BCM_SetTestResult(BCM_ERR_OK);                                      \
        } else {                                                                \
            BCM_SetTestResult(BCM_ERR_UNKNOWN);                                 \
            ULOG_ERR("TIM_QT: Err case: %x, at line : %d\n", case, __LINE__);   \
            TimerQtErrCnt++;                                                    \
        }                                                                       \

#define TIMER_CH_ID_0           (0UL)
#define TIMER_CH_ID_1           (1UL)
#define MAX_PERIODIC_TEST_CNT   (3UL)
#define MIN_SYSTEM_TEST_CNT     (2UL)
#define QT1_FREE_RUN_CH_ID      (TIMER_CH_ID_0)
#define QT1_PERIODIC_CH_ID      (TIMER_CH_ID_1)
#define QT2_PERIODIC_CH_ID      (TIMER_CH_ID_0)
#define QT2_ONE_SHOT_CH_ID      (TIMER_CH_ID_1)
#define QT3_SYS_TIMER_CH_ID     (TIMER_CH_ID_0)
#define MAX_PERIODIC_MANUAL_TEST_CNT  (10UL)  /* 10 sec */

static int32_t TimerQtRunState = BCM_AT_NOT_STARTED;
static uint32_t TimerQtIdx = 0UL;
static int32_t TimerQtResult;
static uint32_t TimerQtErrCnt;

static const TIM_ConfigType TIM_Config1[] = {
    {
        .prescale = TIM_PRESCALE_DIV_16,
        .sysTimeEn = FALSE,
        .chanID = QT1_FREE_RUN_CH_ID,
        .chanMode = TIM_CHAN_MODE_FREE_RUNNING,
        .width = TIM_WIDTH_32_BIT,
    },
    {
        .prescale = TIM_PRESCALE_DIV_16,
        .sysTimeEn = FALSE,
        .chanID = QT1_PERIODIC_CH_ID,
        .chanMode = TIM_CHAN_MODE_PERIODIC,
        .width = TIM_WIDTH_32_BIT,
    },
};
static const TIM_ConfigType TIM_Config2[] = {
    {
        .prescale = TIM_PRESCALE_DIV_16,
        .sysTimeEn = FALSE,
        .chanID = QT2_PERIODIC_CH_ID,
        .chanMode = TIM_CHAN_MODE_PERIODIC,
        .width = TIM_WIDTH_32_BIT,
    },
    {
        .prescale = TIM_PRESCALE_DIV_16,
        .sysTimeEn = FALSE,
        .chanID = QT2_ONE_SHOT_CH_ID,
        .chanMode = TIM_CHAN_MODE_ONE_SHOT,
        .width = TIM_WIDTH_16_BIT,
    },
};
static const TIM_ConfigType SysTimer = {
    .prescale = TIM_PRESCALE_DIV_1,
    .sysTimeEn = TRUE,
    .chanID = QT3_SYS_TIMER_CH_ID,
    .chanMode = TIM_CHAN_MODE_PERIODIC,
    .width = TIM_WIDTH_32_BIT,
};

static const TIM_ConfigType PeriodicManualTest = {
    .prescale = TIM_PRESCALE_DIV_16,
    .sysTimeEn = FALSE,
    .chanID = QT2_PERIODIC_CH_ID,
    .chanMode = TIM_CHAN_MODE_PERIODIC,
    .width = TIM_WIDTH_32_BIT,
};

static void TIMER_PeriodicManualTest(void)
{
    TimerQtResult = BCM_ERR_OK;
    TIMER_TestCh0EvtCnt = 0UL;

    /* Initialize timers */
    TIM_Init(PeriodicManualTest.chanID, &PeriodicManualTest);

    TIM_EnableNotification(PeriodicManualTest.chanID);

    /* Start periodic timer with 1s interval */
    TIM_StartTimer(PeriodicManualTest.chanID, TIMER_TICKS_DIV_16_1S);

    while (MAX_PERIODIC_MANUAL_TEST_CNT > TIMER_TestCh0EvtCnt) {
            (void)BCM_WaitEvent(TimerQtCh0Event);
            (void)BCM_ClearEvent(TimerQtCh0Event);
    }

    /* Verify if call back counts are proper */
    if (MAX_PERIODIC_MANUAL_TEST_CNT > TIMER_TestCh0EvtCnt) {
        TimerQtResult = BCM_ERR_UNKNOWN;
        ULOG_ERR("TIMER_PeriodicManualTest count error, Periodic:%d \n", TIMER_TestCh0EvtCnt);
    }

    /* De-Initialize timers */
    TIM_DeInit(PeriodicManualTest.chanID);
}

static void TIMER_SystemTest(void)
{
    uint32_t value = SYS_TICK_US *100UL;
    int32_t retVal;
    TIMER_TEST_SVC_IOType timerQtSvcIo;

    /* Initialize timer */
    CALL(TIM_Init(SysTimer.chanID, &SysTimer))

    timerQtSvcIo.channel = SysTimer.chanID;
    SVC_RunTestSvc(TIMER_TEST_SVC_CMD_SYS_EN_NOTIF, (uint8_t *)&timerQtSvcIo);
    REPORT_RESULT(BRCM_SWQTST_TIM_SYSTEMENABLENOTIFICATION_SYS_TIM,
                            (BCM_ERR_OK == timerQtSvcIo.retVal))

    timerQtSvcIo.channel = SysTimer.chanID;
    timerQtSvcIo.ticks = value;
    SVC_RunTestSvc(TIMER_TEST_SVC_CMD_SYS_START_TIM, (uint8_t *)&timerQtSvcIo);
    REPORT_RESULT(BRCM_SWQTST_TIM_SYSTEMSTARTTIMER_SYS_TIM,
                            (BCM_ERR_OK == timerQtSvcIo.retVal))

    timerQtSvcIo.channel = SysTimer.chanID;
    SVC_RunTestSvc(TIMER_TEST_SVC_CMD_SYS_STOP_TIM, (uint8_t *)&timerQtSvcIo);
    REPORT_RESULT(BRCM_SWQTST_TIM_SYSTEMSTOPTIMER_SYS_TIM,
                            (BCM_ERR_OK == timerQtSvcIo.retVal))

    timerQtSvcIo.channel = SysTimer.chanID;
    SVC_RunTestSvc(TIMER_TEST_SVC_CMD_SYS_DIS_NOTIF, (uint8_t *)&timerQtSvcIo);
    REPORT_RESULT(BRCM_SWQTST_TIM_SYSTEMDISABLENOTIFICATION_SYS_TIM,
                            (BCM_ERR_OK == timerQtSvcIo.retVal))

    CALL(TIM_DeInit(SysTimer.chanID))

    if (TimerQtErrCnt > 0UL){
        TimerQtResult = BCM_ERR_UNKNOWN;
    }
}

static void TIMER_SysTimerTest(void)
{
    uint32_t value = SYS_TICK_US;
    ULOG_INFO("value:%d\n", value);
    uint64_t getTimeStamp1;
    uint64_t getRawTimeStamp1;
    uint64_t systemGetTimeStamp1;
    uint64_t getTimeStamp2;
    uint64_t getRawTimeStamp2;
    uint64_t systemGetTimeStamp2;
    int32_t retVal;
    TIMER_TEST_SVC_IOType timerQtSvcIo;

    TIMER_TestCh0EvtCnt = 0UL;

    /* Initialize timer */
    EXECUTE_TEST(BRCM_SWQTST_TIM_INIT_SYSTEM_PERIODIC_CH0,
            TIM_Init(SysTimer.chanID, &SysTimer), BCM_ERR_OK)
    EXECUTE_TEST(BRCM_SWQTST_TIM_ENABLENOTIFICATION_SYS_PERIODIC_CH0,
            TIM_EnableNotification(SysTimer.chanID), BCM_ERR_OK)

    EXECUTE_TEST(BRCM_SWQTST_TIM_STARTTIMER_SYSTEM_CH0,
            TIM_StartTimer(SysTimer.chanID, value), BCM_ERR_OK)

    timerQtSvcIo.currTime = 0ULL;
    timerQtSvcIo.channel = 0UL;
    SVC_RunTestSvc(TIMER_TEST_SVC_CMD_GET_TIME_RAW, (uint8_t *)&timerQtSvcIo);
    getRawTimeStamp1 = timerQtSvcIo.currTime;
    timerQtSvcIo.currTime = 0ULL;
    SVC_RunTestSvc(TIMER_TEST_SVC_CMD_GET_TIME_RAW, (uint8_t *)&timerQtSvcIo);
    getRawTimeStamp2 = timerQtSvcIo.currTime;

    (void)BCM_WaitEvent(TimerQtCh0Event);
    (void)BCM_ClearEvent(TimerQtCh0Event);

    getTimeStamp1 = TIM_GetTime();
    timerQtSvcIo.currTime = 0ULL;
    SVC_RunTestSvc(TIMER_TEST_SVC_CMD_SYS_GET_TIME, (uint8_t *)&timerQtSvcIo);
    systemGetTimeStamp1 = timerQtSvcIo.currTime;
    if ((0UL != getTimeStamp1) && (0UL != systemGetTimeStamp1) &&
        (getRawTimeStamp2 > getRawTimeStamp1)) {
        (void)BCM_WaitEvent(TimerQtCh0Event);
        (void)BCM_ClearEvent(TimerQtCh0Event);
        getTimeStamp2 = TIM_GetTime();
        timerQtSvcIo.currTime = 0ULL;
        SVC_RunTestSvc(TIMER_TEST_SVC_CMD_SYS_GET_TIME, (uint8_t *)&timerQtSvcIo);
        systemGetTimeStamp2 = timerQtSvcIo.currTime;
        if ((0UL == getTimeStamp2) || (0UL == systemGetTimeStamp2)) {
           TimerQtResult = BCM_ERR_UNKNOWN;
        }
        if ((getTimeStamp2 <= getTimeStamp1) ||
            (systemGetTimeStamp2 <= systemGetTimeStamp1)) {
           TimerQtResult = BCM_ERR_UNKNOWN;
        }
        if (MIN_SYSTEM_TEST_CNT > TIMER_TestCh0EvtCnt) {
           TimerQtResult = BCM_ERR_UNKNOWN;
        }
    } else {
        TimerQtResult = BCM_ERR_UNKNOWN;
    }

    EXECUTE_TEST(BRCM_SWQTST_TIM_STOPTIMER_SYSTEM_CH0,
            TIM_StopTimer(SysTimer.chanID), BCM_ERR_OK)

    EXECUTE_TEST(BRCM_SWQTST_TIM_DEINIT_SYSTEM_PERIODIC_CH0,
            TIM_DeInit(SysTimer.chanID), BCM_ERR_OK)

    if (TimerQtErrCnt > 0UL){
        TimerQtResult = BCM_ERR_UNKNOWN;
    }
}

static void TIMER_TestQT2(void)
{
    int32_t retVal;

    TIMER_TestCh0EvtCnt = 0UL;
    TIMER_TestCh1EvtCnt = 0UL;

    /* Initialize timers */
    EXECUTE_TEST(BRCM_SWQTST_TIM_INIT_PERIODIC_CH0,
            TIM_Init(TIM_Config2[0].chanID, &TIM_Config2[0]), BCM_ERR_OK)
    EXECUTE_TEST(BRCM_SWQTST_TIM_INIT_ONE_SHOT_CH1,
            TIM_Init(TIM_Config2[1].chanID, &TIM_Config2[1]), BCM_ERR_OK)

    EXECUTE_TEST(BRCM_SWQTST_TIM_ENABLENOTIFICATION_ONE_SHOT_CH1,
            TIM_EnableNotification(QT2_ONE_SHOT_CH_ID), BCM_ERR_OK)

    /* Start One shot timer for 1ms interval*/
    EXECUTE_TEST(BRCM_SWQTST_TIM_STARTTIMER_ONESHOT_CH1,
            TIM_StartTimer(QT2_ONE_SHOT_CH_ID, TIMER_TICKS_DIV_16_1MS), BCM_ERR_OK)

    EXECUTE_TEST(BRCM_SWQTST_TIM_ENABLENOTIFICATION_PERIODIC_CH0,
            TIM_EnableNotification(QT2_PERIODIC_CH_ID), BCM_ERR_OK)

    /* Start Periodic timer for 1MS interval*/
    EXECUTE_TEST(BRCM_SWQTST_TIM_STARTTIMER_PERIODIC_CH0,
            TIM_StartTimer(QT2_PERIODIC_CH_ID, TIMER_TICKS_DIV_16_1MS), BCM_ERR_OK)

    /* Wait for One-Shot event */
    (void)BCM_WaitEvent(TimerQtCh1Event);
    (void)BCM_ClearEvent(TimerQtCh1Event);

    while (MAX_PERIODIC_TEST_CNT > TIMER_TestCh0EvtCnt) {
        (void)BCM_WaitEvent(TimerQtCh0Event);
        (void)BCM_ClearEvent(TimerQtCh0Event);
    }

    /* Verify if call back counts are proper */
    if (1UL != TIMER_TestCh1EvtCnt ||
        MAX_PERIODIC_TEST_CNT > TIMER_TestCh0EvtCnt) {
        TimerQtResult = BCM_ERR_UNKNOWN;
        TimerQtErrCnt++;
        ULOG_ERR("Timer call back count error, OneShot:%d  Periodic:%d \n",
                                                TIMER_TestCh0EvtCnt, TIMER_TestCh1EvtCnt);
    }

    /* Periodic timer has to be stopped before de-initializing */
    EXECUTE_TEST(BRCM_SWQTST_TIM_STOPTIMER_PERIODIC_CH0,
            TIM_StopTimer(QT2_PERIODIC_CH_ID), BCM_ERR_OK)

    TIMER_TestCh0EvtCnt = 0UL;
    BCM_CpuNDelay(2000000UL);  /* Wait 2ms to see if there is no call back */
    REPORT_RESULT(BRCM_SWQTST_TIM_STOPTIMER_PERIODIC_VERIFY,
                                (0UL == TIMER_TestCh0EvtCnt))

    /* De-Initialize timers */
    EXECUTE_TEST(BRCM_SWQTST_TIM_DEINIT_PERIODIC_CH0,
            TIM_DeInit(TIM_Config2[0].chanID), BCM_ERR_OK)
    EXECUTE_TEST(BRCM_SWQTST_TIM_DEINIT_ONE_SHOT_CH1,
            TIM_DeInit(TIM_Config2[1].chanID), BCM_ERR_OK)

    if (TimerQtErrCnt > 0UL){
        TimerQtResult = BCM_ERR_UNKNOWN;
    }
}

static void TIMER_TestQT1(void)
{
    TIM_TickType freeTimeStamp1;
    TIM_TickType freeTimeStamp2;
    TIM_TickType periodicTimeStamp[MAX_PERIODIC_TEST_CNT];
    int32_t retVal;

    TIMER_TestCh1EvtCnt = 0UL;

    /* Initialize timers */
    EXECUTE_TEST(BRCM_SWQTST_TIM_INIT_FREE_RUNNING_CH0,
            TIM_Init(TIM_Config1[0].chanID, &TIM_Config1[0]), BCM_ERR_OK)
    EXECUTE_TEST(BRCM_SWQTST_TIM_INIT_PERIODIC_CH1,
            TIM_Init(TIM_Config1[1].chanID, &TIM_Config1[1]), BCM_ERR_OK)

    EXECUTE_TEST(BRCM_SWQTST_TIM_ENABLENOTIFICATION_PERIODIC_CH1,
            TIM_EnableNotification(QT1_PERIODIC_CH_ID), BCM_ERR_OK)

    /* Start Periodic timer */
    EXECUTE_TEST(BRCM_SWQTST_TIM_STARTTIMER_PERIODIC_CH1,
            TIM_StartTimer(QT1_PERIODIC_CH_ID, TIMER_TICKS_DIV_16_1MS), BCM_ERR_OK)

    /* Get free running times */
    freeTimeStamp1 = TIM_GetFreeRunningTime(QT1_FREE_RUN_CH_ID);
    ULOG_INFO("Free Running Timestamps before : %d\n", freeTimeStamp1);

    while (MAX_PERIODIC_TEST_CNT > TIMER_TestCh1EvtCnt) {
        (void)BCM_WaitEvent(TimerQtCh1Event);
        (void)BCM_ClearEvent(TimerQtCh1Event);
        periodicTimeStamp[TIMER_TestCh1EvtCnt] = TIM_GetFreeRunningTime(QT1_FREE_RUN_CH_ID);
        (void)periodicTimeStamp[TIMER_TestCh1EvtCnt];
    }

    /* Periodic timer has to be stopped before de-initializing */
    EXECUTE_TEST(BRCM_SWQTST_TIM_STOPTIMER_PERIODIC_CH1,
            TIM_StopTimer(QT1_PERIODIC_CH_ID), BCM_ERR_OK)

    ULOG_INFO("Periodic Time Stamps %d, %d, %d, %d, %d\n", periodicTimeStamp[0],
                                                           periodicTimeStamp[1],
                                                           periodicTimeStamp[2],
                                                           periodicTimeStamp[3],
                                                           periodicTimeStamp[4]);

    /* Verify free running timer again */
    freeTimeStamp2 = TIM_GetFreeRunningTime(QT1_FREE_RUN_CH_ID);
    ULOG_INFO("Free Running Timestamps after: %d\n", freeTimeStamp2);
    if (freeTimeStamp2 <= freeTimeStamp1) {
        TimerQtResult = BCM_ERR_UNKNOWN;
        ULOG_ERR("Freerunning timer not running after periodic !!\n");
        goto bcm_err;
    }
    /* Verify if Periodic call back count is proper */
    if (MAX_PERIODIC_TEST_CNT > TIMER_TestCh1EvtCnt) {
        TimerQtResult = BCM_ERR_UNKNOWN;
        ULOG_ERR("Callback count error, cb count %d\n", TIMER_TestCh1EvtCnt);
        goto bcm_err;
    }
    /* Verify if free running counts are proper */
    if ((freeTimeStamp2 - freeTimeStamp1) < (TIMER_TICKS_DIV_16_1MS * MAX_PERIODIC_TEST_CNT)) {
        TimerQtResult = BCM_ERR_UNKNOWN;
        ULOG_ERR("Timer tick mismatch. Before:%d after:%d \n", freeTimeStamp1, freeTimeStamp2);
        goto bcm_err;
    }

bcm_err:

    EXECUTE_TEST(BRCM_SWQTST_TIM_DEINIT_FREE_RUNNING_CH0,
            TIM_DeInit(TIM_Config1[0].chanID), BCM_ERR_OK)
    EXECUTE_TEST(BRCM_SWQTST_TIM_DEINIT_PERIODIC_CH1,
            TIM_DeInit(TIM_Config1[1].chanID), BCM_ERR_OK)

    if (TimerQtErrCnt > 0UL){
        TimerQtResult = BCM_ERR_UNKNOWN;
    }
}

TASK(TIMERQT_Task)
{
    TIMER_TestTask = TIMERQT_Task;
    TIMER_TestCh0Event = TimerQtCh0Event;
    TIMER_TestCh1Event = TimerQtCh1Event;
    BCM_TestStart(BCM_SPT_ID);
    BCM_SetTestSeq(TimerQtIdx);
    TimerQtErrCnt = 0;

    TimerQtResult = BCM_ERR_OK;
    if (BRCM_SWQTSEQ_TIMER_PERIODIC_CH1 == TimerQtIdx) {
        TIMER_TestQT1();
    } else if (BRCM_SWQTSEQ_TIMER_ONESHOT_CH1_PERIODIC_CH0 == TimerQtIdx) {
        TIMER_TestQT2();
    } else if (BRCM_SWQTSEQ_TIMER_SYSTEM_CH0 == TimerQtIdx) {
        TIMER_SysTimerTest();
    } else if (BRCM_SWQTSEQ_TIMER_SYSTEM_TEST == TimerQtIdx) {
        TIMER_SystemTest();
    } else if (BRCM_SWQTSEQ_TIMER_PERIODIC_MANUAL == TimerQtIdx) {
        TIMER_PeriodicManualTest();
    } else {
        TimerQtResult = BCM_ERR_UNKNOWN;
    }

    (void)BCM_TerminateTask();
}

static int32_t TIMER_ExecuteQtInternal(uint32_t aTestIdx)
{
    int32_t retVal;
    StatusType retOS = E_OK;
    TaskStateType taskState = SUSPENDED;
    TaskStateRefType taskStatePtr = &taskState;

    retOS = GetTaskState(TIMERQT_Task, taskStatePtr);
    if (BCM_ERR_OK == retOS) {
        if (SUSPENDED == taskState) {
            TimerQtRunState = BCM_AT_EXECUTING;
            TimerQtIdx = aTestIdx;
            retVal = BCM_ActivateTask(TIMERQT_Task);
            if (BCM_ERR_OK != retVal) {
                retVal = BCM_AT_NOT_STARTED;
                TimerQtRunState = BCM_AT_NOT_STARTED;
                ULOG_ERR("TIMERQT_Task activation failed, error: %d\n\r", retVal);
            }
        } else {
            retVal = BCM_AT_EXECUTING;
            ULOG_ERR("TIMERQT_Task is already running \n\r");
        }
    } else {
        retVal = BCM_ERR_UNKNOWN;
        ULOG_ERR("GetTaskState in TIMER_ExecuteQt failed Error: %d\n\r", retOS);
    }

    return retVal;
}

int32_t TIMER_ExecuteQt(uint32_t aTestIdx)
{
    int32_t retVal = BCM_ERR_OK;

    switch (aTestIdx) {
#ifdef BRCM_SWQTSEQ_TIMER_PERIODIC_CH1
        case BRCM_SWQTSEQ_TIMER_PERIODIC_CH1:
            retVal = TIMER_ExecuteQtInternal(aTestIdx);
            break;
#endif
#ifdef BRCM_SWQTSEQ_TIMER_ONESHOT_CH1_PERIODIC_CH0
        case BRCM_SWQTSEQ_TIMER_ONESHOT_CH1_PERIODIC_CH0:
            retVal = TIMER_ExecuteQtInternal(aTestIdx);
            break;
#endif
#ifdef BRCM_SWQTSEQ_TIMER_SYSTEM_CH0
        case BRCM_SWQTSEQ_TIMER_SYSTEM_CH0:
            retVal = TIMER_ExecuteQtInternal(aTestIdx);
            break;
#endif
#ifdef BRCM_SWQTSEQ_TIMER_SYSTEM_TEST
        case BRCM_SWQTSEQ_TIMER_SYSTEM_TEST:
            retVal = TIMER_ExecuteQtInternal(aTestIdx);
            break;
#endif
#ifdef BRCM_SWQTSEQ_TIMER_PERIODIC_MANUAL
        case BRCM_SWQTSEQ_TIMER_PERIODIC_MANUAL:
            retVal = TIMER_ExecuteQtInternal(aTestIdx);
            break;
#endif
        default:
            retVal = BCM_AT_NOT_AVAILABLE;
            break;
    }

    return retVal;
}

static int32_t TIMER_GetStatusQtInternal(uint32_t aTestIdx)
{
    int32_t retVal;
    StatusType retOS = E_OK;
    TaskStateType taskState = RUNNING;
    TaskStateRefType taskStatePtr = &taskState;

    if (TimerQtIdx == aTestIdx) {
        retOS = GetTaskState(TIMERQT_Task, taskStatePtr);
        if (BCM_ERR_OK == retOS) {
            if ((SUSPENDED == taskState) &&
                (BCM_AT_EXECUTING == TimerQtRunState)) {
                TimerQtRunState = BCM_AT_NOT_STARTED;
                retVal = TimerQtResult;
            } else {
                retVal = BCM_AT_EXECUTING;
            }
        } else {
            retVal = BCM_ERR_UNKNOWN;
            ULOG_ERR("GetTaskState in TIMER_GetStatusQt failed Error: %d\n\r", retOS);
        }
    } else {
        retVal = BCM_AT_NOT_AVAILABLE;
    }

    return retVal;
}

int32_t TIMER_GetStatusQt(uint32_t aTestIdx)
{
    int32_t retVal;

    switch (aTestIdx) {
#ifdef BRCM_SWQTSEQ_TIMER_PERIODIC_CH1
        case BRCM_SWQTSEQ_TIMER_PERIODIC_CH1:
            retVal = TIMER_GetStatusQtInternal(aTestIdx);
            break;
#endif
#ifdef BRCM_SWQTSEQ_TIMER_ONESHOT_CH1_PERIODIC_CH0
        case BRCM_SWQTSEQ_TIMER_ONESHOT_CH1_PERIODIC_CH0:
            retVal = TIMER_GetStatusQtInternal(aTestIdx);
            break;
#endif
#ifdef BRCM_SWQTSEQ_TIMER_SYSTEM_CH0
        case BRCM_SWQTSEQ_TIMER_SYSTEM_CH0:
            retVal = TIMER_GetStatusQtInternal(aTestIdx);
            break;
#endif
#ifdef BRCM_SWQTSEQ_TIMER_SYSTEM_TEST
        case BRCM_SWQTSEQ_TIMER_SYSTEM_TEST:
            retVal = TIMER_GetStatusQtInternal(aTestIdx);
            break;
#endif
#ifdef BRCM_SWQTSEQ_TIMER_PERIODIC_MANUAL
        case BRCM_SWQTSEQ_TIMER_PERIODIC_MANUAL:
            retVal = TIMER_GetStatusQtInternal(aTestIdx);
            break;
#endif
        default:
            retVal = BCM_AT_NOT_AVAILABLE;
            break;
    }

    return retVal;
}
