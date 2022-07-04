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

#include "ee.h"
#include <ulog.h>
#include <bcm_time.h>
#include <bcm_err.h>
#include <bcm_test.h>
#include <osil/bcm_osil.h>
#include <time_test.h>
#include <mcu.h>
#include <bcm_utils.h>
#include <module.h>
#include <module_helper.h>
#include <time_module_osil.h>

#define TASK_SWITCH_TEST_CNT        (5UL)
#define GetModuleLogLevel() ULOG_LVL_INFO

static uint32_t task0_cnt;
static uint32_t task1_cnt;

static int32_t TestStatus = BCM_AT_NOT_STARTED;
static uint32_t timeTestId = TIME_TESTID_QT;

const MODULE_Type* const SYS_ModuleFnTable[MODULE_COUNT_MAX] = {
    &TIME_Module,
};

TASK(Task0)
{
    int32_t ret;

    BCM_EventMaskType mask = 0UL;
    MCU_InfoType switchInfo;

    MCU_GetInfo(&switchInfo);
    ULOG_INFO("Task0 switchInfo.stackingen: %d\n\r", switchInfo.stackingEn);

    ret = MCU_SetInfo(&switchInfo);
    if (BCM_ERR_OK != ret) {
        ULOG_INFO("Task0 ret: %d\n\r", ret);
    }

    do {
        BCM_WaitEvent(TriggerEvent0);
        BCM_GetEvent(Task0, &mask);
        if (mask & TriggerEvent0) {
            BCM_ClearEvent(TriggerEvent0);
        }
        ULOG_INFO("Task0 run: %d\n\r", task0_cnt++);
        (void)BCM_SetEvent(Task1, TriggerEvent1);
    } while(task0_cnt <= TASK_SWITCH_TEST_CNT);

    BCM_TerminateTask();
}

static void TIMEQT_Execute(void) {
    BCM_EventMaskType mask = 0UL;
    do {
        BCM_WaitEvent(TriggerEvent1);
        BCM_GetEvent(Task1, &mask);
        if (mask & TriggerEvent1) {
            BCM_ClearEvent(TriggerEvent1);
        }
        ULOG_INFO("Task1 run: %d\n\r", task1_cnt++);
    } while(task1_cnt <= TASK_SWITCH_TEST_CNT);

    if ((task0_cnt >= TASK_SWITCH_TEST_CNT) &&
            (task1_cnt >= TASK_SWITCH_TEST_CNT)) {
        TestStatus = BCM_ERR_OK;
    } else {
        TestStatus = BCM_ERR_UNKNOWN;
    }
}

TASK(Task1)
{
    if (TIME_TESTID_QT == timeTestId) {
        TIMEQT_Execute();
    }
#ifdef ENABLE_TIME_IT
    else if (TIME_TESTID_IT == timeTestId) {
        TIMEIT_Execute();
    }
#endif /* ENABLE_TIME_IT */
    BCM_TerminateTask();
}

TASK(Task2)
{
    uint32_t const testDelay[] = { 10000UL, 100000UL, 1000000UL, 5555555UL, 1000000000UL };
    uint32_t testNum;
    uint32_t const numTests = sizeof(testDelay)/sizeof(*testDelay);

    for  (testNum = 0; testNum < numTests; testNum++)
    {
        uint64_t time1;
        uint64_t time2;
        uint32_t actualDelay;
        uint32_t diff;

        time1 = BCM_GetTimeNs();
        BCM_CpuNDelay(testDelay[testNum]);
        time2 = BCM_GetTimeNs();
        actualDelay = time2-time1;

        ULOG_ERR("Delay %d / %d\n", testDelay[testNum], actualDelay);

        if (actualDelay > testDelay[testNum]) {
            diff = actualDelay - testDelay[testNum];
            diff = (diff*100UL)/actualDelay;
            /* More than 20% error */
            if (diff > 20UL) {
                ULOG_ERR("Delay is not matching\n");
                TestStatus = BCM_ERR_UNKNOWN;
            }
        } else {
            ULOG_ERR("Delay is less than the provided value\n");
            TestStatus = BCM_ERR_UNKNOWN;
        }
    }
    if (BCM_ERR_UNKNOWN != TestStatus) {
        TestStatus = BCM_ERR_OK;
    }
    BCM_TerminateTask();
}

/* Start Test */
int32_t BCM_ExecuteAT(uint32_t aIndex)
{
    int32_t retVal = BCM_ERR_OK;

    /* Start timer module (UNINIT->INIT)*/
    retVal = MODULE_ResetStateHandler(SYS_ModuleFnTable,1UL);
    if (BCM_STATE_INIT != TIME_Module.context->state) {
        goto err;
    }

    switch(aIndex)
    {
        case 1UL:
            timeTestId = TIME_TESTID_QT;
            TestStatus = BCM_AT_EXECUTING;
            task0_cnt = 0UL;
            task1_cnt = 0UL;
            BCM_ActivateTask(Task0);
            BCM_ActivateTask(Task1);
            break;
        case 2UL:
            BCM_ActivateTask(Task2);
            break;
#ifdef ENABLE_TIME_IT
        case 3UL:
            timeTestId = TIME_TESTID_IT;
            BCM_ActivateTask(Task1);
            break;
#endif /* ENABLE_TIME_IT */
        default:
            retVal = BCM_AT_NOT_AVAILABLE;
            break;
    }
err:
    return retVal;
}

/* Get Test results */
int32_t BCM_GetResultAT(uint32_t aIndex)
{
    int32_t retVal = BCM_ERR_OK;
    switch(aIndex)
    {
        case 1UL:
        case 2UL:
            retVal = TestStatus;
            break;
#ifdef ENABLE_TIME_IT
        case 3UL:
            retVal = TIMEIT_GetResult();
            break;
#endif /* ENABLE_TIME_IT */
        default:
            retVal = BCM_AT_NOT_AVAILABLE;
            break;
    }
    return retVal;
}

void APP_Init()
{
    /* dummy */
}

void TaskSwitchCb()
{
    (void)SetEvent(Task0, TriggerEvent0);
}
