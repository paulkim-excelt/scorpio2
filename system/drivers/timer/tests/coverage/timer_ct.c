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

/** @brief Integration test for Timer driver */

#include "ee.h"
#include <tim.h>
#include <bcm_utils.h>
#include <ulog.h>
#include <bcm_err.h>
#include <bcm_test.h>
#include <tim_rdb.h>
#include <shell.h>
#include <osil/bcm_osil.h>
#include <tim.h>
#include <osil/tim_osil.h>

#include "timer_test.h"
#include "timer_pt.h"

#define BRCM_SWPTST_TIM_DEFAULT_CASE                                  (0x3000UL)

#define CALL(func)                                                              \
        retVal = func;                                                          \
        if (BCM_ERR_OK != retVal) {                                             \
            TimerCtResult = retVal;                                             \
            TimerCtErrorCount++;                                                \
        }                                                                       \

#define EXECUTE_TEST(case, func, expecRet)                                      \
        BCM_SetTestCase(case);                                                  \
        retVal = func;                                                          \
        if (expecRet == retVal) {                                               \
            BCM_SetTestResult(BCM_ERR_OK);                                      \
        } else {                                                                \
            BCM_SetTestResult(BCM_ERR_UNKNOWN);                                 \
            ULOG_ERR("TIM_CT: Err case: %x, retVal: %x at: %d\n",               \
                                            case, retVal, __LINE__);            \
            TimerCtErrorCount++;                                                \
        }                                                                       \

#define REPORT_RESULT(case, condition)                                          \
        BCM_SetTestCase(case);                                                  \
        if (condition) {                                                        \
            BCM_SetTestResult(BCM_ERR_OK);                                      \
        } else {                                                                \
            BCM_SetTestResult(BCM_ERR_UNKNOWN);                                 \
            ULOG_ERR("TIM_CT: Err case: %x, at line : %d\n", case, __LINE__);   \
            TimerCtErrorCount++;                                                \
        }

#define GetModuleLogLevel()         ULOG_LVL_ERROR

static uint8_t TimerCtErrorCount;
static int32_t TimerCtResult;
static uint32_t TimerCtIdx;
static int32_t TimerCtRunState = BCM_AT_NOT_STARTED;

static int32_t TIMER_CT_SysCmdProbe(void)
{
    int32_t retVal;
    TIM_IOType timerIO;
    timerIO.retVal = BCM_ERR_UNKNOWN;

    EXECUTE_TEST(BRCM_SWPTST_TIM_SYSCMDREQ_INVAL_SYSREQID,
                 TIM_SysCmdReq(0xFFFFUL, &timerIO),
                 BCM_ERR_INVAL_PARAMS);
    EXECUTE_TEST(BRCM_SWPTST_TIM_SYSCMDREQ_INVAL_RESPONSE,
                 TIM_SysCmdReq(0xFFFFUL, &timerIO),
                 BCM_ERR_INVAL_PARAMS);

    if (0UL != TimerCtErrorCount) {
        TimerCtResult = BCM_ERR_UNKNOWN;
    }

    return TimerCtResult;
}

static int32_t TIMER_CT_GetTime(void)
{
    int32_t retVal;

    EXECUTE_TEST(BRCM_SWPTST_TIM_GETTIMEELAPSED_NEG,
                 TIM_GetTimeElapsed(0UL), 0UL);

    EXECUTE_TEST(BRCM_SWPTST_TIM_GETTIMEREMAINING_NEG,
                 TIM_GetTimeRemaining(0UL), 0UL);

    EXECUTE_TEST(BRCM_SWPTST_TIM_GETFREERUNNINGTIME_NEG,
                 TIM_GetFreeRunningTime(0UL), 0UL);

    EXECUTE_TEST(BRCM_SWPTST_TIM_GETTIME_NEG,
                 TIM_GetTime(), 0UL);

    if (0UL != TimerCtErrorCount) {
        TimerCtResult = BCM_ERR_UNKNOWN;
    }

    return TimerCtResult;
}

static int32_t TIMER_CT_PeriodicTest(void)
{
    int32_t retVal;
    TIM_ConfigType testCfgPeriodic = {
        .prescale = TIM_PRESCALE_DIV_16,
        .chanID = 0UL,
        .sysTimeEn = FALSE,
        .chanMode = TIM_CHAN_MODE_PERIODIC,
        .width = TIM_WIDTH_16_BIT,
    };

    TIMER_TestCh0EvtCnt = 0UL;
    EXECUTE_TEST(BRCM_SWPTST_TIM_INIT_NEG_NULL_CB,
                 TIM_Init(0UL, &testCfgPeriodic), BCM_ERR_UNKNOWN);
    BCM_SetTestCase(BRCM_SWPTST_TIM_DEFAULT_CASE);
    CALL(TIM_Init(0UL, &testCfgPeriodic))
    EXECUTE_TEST(BRCM_SWPTST_TIM_ENABLENOTIFICATION_NEG_NULL_CB,
                 TIM_EnableNotification(0UL), BCM_ERR_UNKNOWN);
    BCM_SetTestCase(BRCM_SWPTST_TIM_DEFAULT_CASE);
    CALL(TIM_EnableNotification(0UL))
    BCM_SetTestCase(BRCM_SWPTST_TIM_IRQHANDLER_NEG_NULL_CB);
    CALL(TIM_StartTimer(0UL, TIMER_TICKS_DIV_16_1MS))      /* Start periodic */
    BCM_CpuNDelay(2000000);                                /* Wait 2ms */
    REPORT_RESULT(BRCM_SWPTST_TIM_IRQHANDLER_NEG_NULL_CB,
                            (0UL == TIMER_TestCh0EvtCnt))
    EXECUTE_TEST(BRCM_SWPTST_TIM_DISABLENOTIFICATION_NEG_NULL_CB,
                 TIM_DisableNotification(0UL), BCM_ERR_UNKNOWN);
    BCM_SetTestCase(BRCM_SWPTST_TIM_DEFAULT_CASE);
    CALL(TIM_DisableNotification(0UL))
    CALL(TIM_StopTimer(0UL))
    CALL(TIM_DeInit(0UL))

    return TimerCtResult;
}

TASK(TIMERCT_Task)
{
    TIMER_TestTask = TIMERCT_Task;
    TIMER_TestCh0Event = TimerCtCh0Event;
    TIMER_TestCh1Event = TimerCtCh1Event;
    BCM_TestStart(BCM_SPT_ID);
    BCM_SetTestSeq(TimerCtIdx);
    TimerCtErrorCount = 0UL;
    TimerCtResult = BCM_ERR_OK;

    if (BRCM_SWPTSEQ_TIMER_SYS_CMD_TEST == TimerCtIdx) {
        TimerCtResult = TIMER_CT_SysCmdProbe();
    } else if (BRCM_SWPTSEQ_TIMER_GET_TIME == TimerCtIdx) {
        TimerCtResult = TIMER_CT_GetTime();
    } else if (BRCM_SWPTSEQ_TIMER_PERIODIC_TEST == TimerCtIdx) {
        TimerCtResult = TIMER_CT_PeriodicTest();
    } else {
        TimerCtResult = BCM_ERR_UNKNOWN;
    }

    (void)BCM_TerminateTask();
}

static int32_t TIMER_ExecuteCtInternal(uint32_t aTestIdx)
{
    int32_t retVal;
    StatusType retOS = E_OK;
    TaskStateType taskState = SUSPENDED;
    TaskStateRefType taskStatePtr = &taskState;

    retOS = GetTaskState(TIMERCT_Task, taskStatePtr);
    if (BCM_ERR_OK == retOS) {
        if (SUSPENDED == taskState) {
            TimerCtRunState = BCM_AT_EXECUTING;
            TimerCtIdx = aTestIdx;
            retVal = BCM_ActivateTask(TIMERCT_Task);
            if (BCM_ERR_OK != retVal) {
                retVal = BCM_AT_NOT_STARTED;
                TimerCtRunState = BCM_AT_NOT_STARTED;
                ULOG_ERR("TIMERCT_Task activation failed, error: %d\n\r", retVal);
            }
        } else {
            retVal = BCM_AT_EXECUTING;
            ULOG_ERR("TIMERCT_Task is already running \n\r");
        }
    } else {
        retVal = BCM_ERR_UNKNOWN;
        ULOG_ERR("GetTaskState in TIMER_ExecuteQt failed Error: %d\n\r", retOS);
    }

    return retVal;
}

int32_t TIMER_ExecuteCt(uint32_t aTestIdx)
{
    int32_t retVal = BCM_ERR_OK;

    switch (aTestIdx) {
#ifdef BRCM_SWPTSEQ_TIMER_SYS_CMD_TEST
        case BRCM_SWPTSEQ_TIMER_SYS_CMD_TEST:
            retVal = TIMER_ExecuteCtInternal(aTestIdx);
            break;
#endif
#ifdef BRCM_SWPTSEQ_TIMER_GET_TIME
        case BRCM_SWPTSEQ_TIMER_GET_TIME:
            retVal = TIMER_ExecuteCtInternal(aTestIdx);
            break;
#endif
#ifdef BRCM_SWPTSEQ_TIMER_PERIODIC_TEST
        case BRCM_SWPTSEQ_TIMER_PERIODIC_TEST:
            retVal = TIMER_ExecuteCtInternal(aTestIdx);
            break;
#endif
        default:
            retVal = BCM_AT_NOT_AVAILABLE;
            break;
    }

    return retVal;
}

static int32_t TIMER_GetStatusCtInternal(uint32_t aTestIdx)
{
    int32_t retVal;
    StatusType retOS = E_OK;
    TaskStateType taskState = RUNNING;
    TaskStateRefType taskStatePtr = &taskState;

    if (TimerCtIdx == aTestIdx) {
        retOS = GetTaskState(TIMERCT_Task, taskStatePtr);
        if (BCM_ERR_OK == retOS) {
            if ((SUSPENDED == taskState) &&
                (BCM_AT_EXECUTING == TimerCtRunState)) {
                TimerCtRunState = BCM_AT_NOT_STARTED;
                retVal = TimerCtResult;
            } else {
                retVal = BCM_AT_EXECUTING;
            }
        } else {
            retVal = BCM_ERR_UNKNOWN;
            ULOG_ERR("GetTaskState in TIMER_GetStatusIt failed Error: %d\n\r", retOS);
        }
    } else {
        retVal = BCM_AT_NOT_AVAILABLE;
    }

    return retVal;
}

int32_t TIMER_GetStatusCt(uint32_t aTestIdx)
{
    int32_t retVal;

    switch (aTestIdx) {
#ifdef BRCM_SWPTSEQ_TIMER_SYS_CMD_TEST
        case BRCM_SWPTSEQ_TIMER_SYS_CMD_TEST:
            retVal = TIMER_GetStatusCtInternal(aTestIdx);
            break;
#endif
#ifdef BRCM_SWPTSEQ_TIMER_GET_TIME
        case BRCM_SWPTSEQ_TIMER_GET_TIME:
            retVal = TIMER_GetStatusCtInternal(aTestIdx);
            break;
#endif
#ifdef BRCM_SWPTSEQ_TIMER_PERIODIC_TEST
        case BRCM_SWPTSEQ_TIMER_PERIODIC_TEST:
            retVal = TIMER_GetStatusCtInternal(aTestIdx);
            break;
#endif
        default:
            retVal = BCM_AT_NOT_AVAILABLE;
            break;
    }

    return retVal;
}
