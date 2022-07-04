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
#include "ee.h"
#include <bcm_utils.h>
#include <bcm_err.h>
#include <bcm_test.h>
#include <osil/bcm_osil.h>
#include <module.h>
#include <module_helper.h>
#include <bcm_time.h>
#include <time_module_osil.h>
#include <svc.h>

#define GetModuleLogLevel()             (ULOG_LVL_ERROR)

extern void TIMEIT_Execute(uint32_t aIndex);
extern int32_t TIMEIT_GetResult(uint32_t aIndex);

#define TIMEMOD_QT1                           (1UL)
#define TIMEMOD_IT1                           (0x1001UL)

#define TIMEMOD_TESTID_QT                     (1UL)

#define TIMEMOD_TEST_ST_ALARM_EVENT         (SystemEvent2)
#define TIMEMOD_TEST_HRT_ALARM_EVENT        (SystemEvent3)

#define TIMEMOD_TEST_START_HRT              (0UL)
#define TIMEMOD_TEST_STOP_HRT               (1UL)
#define TIMEMOD_TEST_GET_TIME               (2UL)

static uint32_t TIMEMOD_TestId = TIMEMOD_TESTID_QT;
static int32_t TIMEMODQT1_Status = BCM_AT_NOT_STARTED;

const MODULE_Type* const SYS_ModuleFnTable[MODULE_COUNT_MAX] = {
    &TIME_Module,
};

void TIMEMOD_TestSystemTimerAlarmCb(void)
{
    (void)SetEvent(TIMEMODIT_Task, TIMEMOD_TEST_ST_ALARM_EVENT);
}

void TIMEMOD_TestHRTimerAlarmCb(void)
{
    (void)SetEvent(TIMEMODIT_Task, TIMEMOD_TEST_HRT_ALARM_EVENT);
}

void SVC_TestSvcHandler(uint32_t aMagicID, uint32_t aCmd, uint8_t *aSysIO)
{

#if defined(BCM_HRTIMER_CHANID)
    if (TIMEMOD_TEST_START_HRT == aCmd) {
        /* enable HR timer */
        BCM_SystemHRTimerStart();
    } else if (TIMEMOD_TEST_STOP_HRT == aCmd) {
        BCM_SystemHRTimerStop();
    }
#endif
    if (TIMEMOD_TEST_GET_TIME == aCmd) {
        BCM_TimeType* time = (void *) aSysIO;
        BCM_GetSystemTime(time);
    }

    BCM_DelayNs(10000UL);
    BCM_DelayUs(10UL);
    (void)BCM_GetSystemTimeNs();
}

void TIMEMOD_ExecuteQT(void)
{
    uint32_t i;
    int32_t retVal = BCM_ERR_OK;
    int32_t  allMask = 0UL;
    BCM_EventMaskType mask;
    BCM_TimeType time;
    uint64_t timeNs;

    BCM_MemSet(TIME_Module.context, 0U, sizeof(MODULE_ContextType));


    /* run twice to check init after uninit */
    for (i = 0UL; i < 2UL; i++) {
        /* Get the event masks for all modules and submodules */

        allMask = MODULE_GetEventMask(SYS_ModuleFnTable, 1UL);
        if (0UL != allMask) {
            retVal = BCM_ERR_UNKNOWN;
            goto err_exit;
        }

        /* Process the events */
        MODULE_EventHandler(SYS_ModuleFnTable, 1UL, allMask);

        /* Validate state transitions (UNINIT->INIT)*/
        retVal = MODULE_ResetStateHandler(SYS_ModuleFnTable,1UL);
        if (BCM_STATE_INIT != TIME_Module.context->state) {
            retVal = BCM_ERR_INVAL_STATE;
            goto err_exit;
        }

        /* Validate state transitions (INIT->READY)*/
        retVal = MODULE_InitStateHandler(SYS_ModuleFnTable, 1UL);
        if (BCM_STATE_READY != TIME_Module.context->state) {
            retVal = BCM_ERR_INVAL_STATE;
            goto err_exit;
        }

        /* Validate state transitions (READY->RUN)*/
        retVal = MODULE_ReadyStateHandler(SYS_ModuleFnTable, 1UL, BCM_STATE_RUN);
        if (BCM_STATE_RUN != TIME_Module.context->state) {
            retVal = BCM_ERR_INVAL_STATE;
            goto err_exit;
        }


        /* set the alarm */
        BCM_SetRelAlarm(TestSystemTimer, 3, 0);

        /* wait for the event */
        (void)BCM_WaitEvent(TIMEMOD_TEST_ST_ALARM_EVENT);
        (void)BCM_GetEvent(TIMEMODIT_Task,&mask);
        (void)BCM_ClearEvent(mask);

        BCM_CancelAlarm(TestSystemTimer);

#if defined(BCM_HRTIMER_CHANID)
        SVC_RunTestSvc(TIMEMOD_TEST_START_HRT, NULL);
        SVC_RunTestSvc(TIMEMOD_TEST_START_HRT, NULL);

        /* set the alarm */
        BCM_SetRelAlarm(TestHRTimer, 10, 0);

        /* wait for the event */
        (void)BCM_WaitEvent(TIMEMOD_TEST_HRT_ALARM_EVENT);
        (void)BCM_GetEvent(TIMEMODIT_Task,&mask);
        (void)BCM_ClearEvent(mask);

        BCM_CancelAlarm(TestHRTimer);

        SVC_RunTestSvc(TIMEMOD_TEST_STOP_HRT, NULL);
        SVC_RunTestSvc(TIMEMOD_TEST_STOP_HRT, NULL);
#endif

        time.s = 0UL;
        time.ns = 0UL;
        BCM_GetTime(&time);

        if ((0UL == time.s) && (0UL == time.ns)) {
            retVal = BCM_ERR_AUTH_FAILED;
            goto err_exit;
        }

        time.s = 0UL;
        time.ns = 0UL;
        SVC_RunTestSvc(TIMEMOD_TEST_GET_TIME, (uint8_t *)&time);
        if ((0UL == time.s) && (0UL == time.ns)) {
            retVal = BCM_ERR_AUTH_FAILED;
            goto err_exit;
        }

        timeNs = BCM_GetTimeNs();
        if (0UL == timeNs) {
            retVal = BCM_ERR_AUTH_FAILED;
            goto err_exit;
        }

        retVal = MODULE_RunStateHandler(SYS_ModuleFnTable, 1UL, BCM_STATE_UNINIT);
        if (BCM_STATE_UNINIT != TIME_Module.context->state) {
            retVal = BCM_ERR_INVAL_STATE;
            goto err_exit;
        }

    }
err_exit:

    if (BCM_AT_EXECUTING == TIMEMODQT1_Status) {
        TIMEMODQT1_Status = retVal;
    }
}

TASK(TIMEMODIT_Task)
{
    if (TIMEMOD_TESTID_QT == TIMEMOD_TestId) {
        TIMEMOD_ExecuteQT();
    }

    BCM_TerminateTask();
}

int32_t BCM_ExecuteAT(uint32_t aIndex)
{
    int32_t retVal = BCM_ERR_OK;

    switch(aIndex) {
        case TIMEMOD_QT1:
            if(BCM_AT_EXECUTING != TIMEMODQT1_Status) {
                TIMEMODQT1_Status = BCM_AT_EXECUTING;
                TIMEMOD_TestId = TIMEMOD_TESTID_QT;
                (void)BCM_ActivateTask(TIMEMODIT_Task);
            }
            break;
#ifdef ENABLE_TIME_MOD_IT
        case TIMEMOD_IT1:
            TIMEIT_Execute(aIndex);
            break;
#endif /* ENABLE_TIME_MOD_IT */
        default:
            retVal = BCM_AT_NOT_AVAILABLE;
            break;
    }

    return retVal;
}

int32_t BCM_GetResultAT(uint32_t aIndex)
{
    int32_t retVal;

    switch(aIndex) {
    case TIMEMOD_QT1:
        retVal = TIMEMODQT1_Status;
        break;
#ifdef ENABLE_TIME_MOD_IT
    case TIMEMOD_IT1:
        retVal = TIMEIT_GetResult(aIndex);
        break;
#endif /* ENABLE_TIME_MOD_IT */
    default:
        retVal = BCM_AT_NOT_AVAILABLE;
        break;
    }

    return retVal;
}
