/*****************************************************************************
 Copyright 2022 Broadcom Limited.  All rights reserved.

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
#include <stdbool.h>
#include <stdlib.h>
#include <string.h>
#include <ee.h>
#include <bcm_utils.h>
#include <bcm_err.h>
#include <osil/bcm_osil.h>
#include <osil/time_module_osil.h>
#include <module.h>
#include <module_helper.h>
#include <bcm_test.h>
#include <bcm_time.h>

#define CHECKED_FUNC_CALL_EXPECT_ERR(err, fn, ...)                      \
    ret = (fn)(__VA_ARGS__);                                            \
    if (err != ret) {                                                   \
        if (0 == failLine) {                                            \
            failLine = __LINE__;                                        \
        }                                                               \
        goto exit;                                                      \
    }

#define CHECKED_FUNC_CALL(fn, ...)                                      \
    CHECKED_FUNC_CALL_EXPECT_ERR(BCM_ERR_OK, fn, __VA_ARGS__)

#define CHECK_COND(cond)                                                \
    if (!(cond)) {                                                      \
        ret = BCM_ERR_INVAL_STATE;                                      \
        if (0 == failLine) {                                            \
            failLine = __LINE__;                                        \
        }                                                               \
        goto exit;                                                      \
    }

#define BASETEST_MODULE_INIT_COUNT          (1UL)

int32_t failLine;
int32_t base_test_result1 = BCM_AT_NOT_STARTED;

uint32_t task0_cnt;
uint32_t task1_cnt;

const MODULE_Type* const BASETEST_Modules[BASETEST_MODULE_INIT_COUNT] = {
    &TIME_Module,
};

void BaseTaskSwitchCb(void)
{
    (void)SetEvent(Task0, TriggerEvent0);
    return;
}

void BaseTestCounterDriverCb(void)
{
    IncrementCounterHardware(32UL);
    IncrementCounterHardware(BaseTestCounter);
    SetEvent(Task2, TriggerEvent3);
}

void BaseTestAlarmCb(void)
{
    SetEvent(Task2, TriggerEvent4);
}

TASK(Task0)
{
    int32_t ret;
    TaskType tid = 0UL;
    EE_TYPESTATUS tStat = READY;
    BCM_EventMaskType mask = 0UL;
    const uint32_t taskSwitchCnt = 5UL;

    failLine = 0UL;
    base_test_result1 = BCM_AT_EXECUTING;

    task0_cnt = 0UL;
    task1_cnt = 0UL;

    CHECKED_FUNC_CALL(MODULE_ResetStateHandler, BASETEST_Modules, BASETEST_MODULE_INIT_COUNT);

    /* Activate task calls */
    CHECKED_FUNC_CALL_EXPECT_ERR(BCM_ERR_INVAL_PARAMS, BCM_ActivateTask, -1)
    CHECKED_FUNC_CALL_EXPECT_ERR(BCM_ERR_INVAL_PARAMS, BCM_ActivateTask, Task1 + 256UL)

    CHECKED_FUNC_CALL(BCM_ActivateTask, Task1);
    CHECKED_FUNC_CALL_EXPECT_ERR(BCM_ERR_INVAL_STATE, BCM_ActivateTask, Task1);

    /* Set event invalid calls */
    CHECKED_FUNC_CALL_EXPECT_ERR(BCM_ERR_INVAL_PARAMS, BCM_SetEvent, -1, TriggerEvent5)
    CHECKED_FUNC_CALL_EXPECT_ERR(BCM_ERR_INVAL_PARAMS, BCM_SetEvent, BASE_NUM_TASKS, TriggerEvent5)

    do {
        BCM_WaitEvent(TriggerEvent0);
        BCM_GetEvent(Task0, &mask);
        BCM_ClearEvent(TriggerEvent0);

        (void)BCM_SetEvent(Task1, TriggerEvent5);
        (void)BCM_SetEvent(Task1, TriggerEvent1);

        BCM_WaitEvent(TriggerEvent2);
        BCM_GetEvent(Task0, &mask);
        BCM_ClearEvent(TriggerEvent2);

        task0_cnt++;
    } while(task0_cnt <= taskSwitchCnt);

    if (task0_cnt == task1_cnt) {
        ret = BCM_ERR_OK;
    } else {
        ret = BCM_ERR_UNKNOWN;
    }

    /* Wait for Task2 to complete */
    BCM_WaitEvent(TriggerEvent3 | TriggerEvent4);

    CHECKED_FUNC_CALL_EXPECT_ERR(BCM_ERR_INVAL_PARAMS, BCM_GetEvent, -1, &mask)
    CHECKED_FUNC_CALL_EXPECT_ERR(BCM_ERR_INVAL_PARAMS, BCM_GetEvent, BASE_NUM_TASKS, &mask)
    CHECKED_FUNC_CALL(BCM_GetEvent, Task0, &mask)
    BCM_ClearEvent(TriggerEvent3 | TriggerEvent4);
    CHECK_COND(0UL != (mask & TriggerEvent3))

    /* Few more misc tests */
    CHECKED_FUNC_CALL_EXPECT_ERR(E_OS_ILLEGAL_ADDRESS, GetTaskID, NULL)
    CHECKED_FUNC_CALL(GetTaskID, &tid);
    CHECK_COND(tid == Task0)

    /* Validate Task states */
    CHECKED_FUNC_CALL_EXPECT_ERR(E_OS_VALUE, GetTaskState, BASE_NUM_TASKS, &tStat)
    CHECKED_FUNC_CALL_EXPECT_ERR(E_OS_ILLEGAL_ADDRESS, GetTaskState, Task0, NULL)

    CHECKED_FUNC_CALL(GetTaskState, Task0, &tStat)
    CHECK_COND(tStat == RUNNING)

    CHECKED_FUNC_CALL(GetTaskState, IDLE_Task, &tStat)
    CHECK_COND(tStat == READY)

    CHECKED_FUNC_CALL(GetTaskState, Task1, &tStat)
    CHECK_COND(tStat == WAITING)

    CHECKED_FUNC_CALL(GetTaskState, Task2, &tStat)
    CHECK_COND(tStat == SUSPENDED)

exit:
    if (0 != failLine) {
        ret = BCM_ERR_INVAL_STATE;
    } else {
        ret = BCM_ERR_OK;
    }

    base_test_result1 = ret;
}

TASK(Task1)
{
    BCM_EventMaskType mask = 0UL;

    while (1UL) {
        BCM_WaitEvent(TriggerEvent1);
        BCM_GetEvent(Task1, &mask);
        BCM_ClearEvent(TriggerEvent1);

        task1_cnt++;
        (void)BCM_SetEvent(Task0, TriggerEvent2);
    };
}

TASK(Task2)
{
    int32_t ret;
    int32_t failLine = 0;

    /* Wait for the first TestDriverCb to trigger */
    BCM_WaitEvent(TriggerEvent3);
    BCM_ClearEvent(TriggerEvent3);

    /* Test BCM_SetRelAlarm */
    CHECKED_FUNC_CALL_EXPECT_ERR(BCM_ERR_INVAL_PARAMS, BCM_SetRelAlarm, BaseTestAlarm, 1, 1);
    CHECKED_FUNC_CALL_EXPECT_ERR(BCM_ERR_INVAL_PARAMS, BCM_SetRelAlarm, BaseTestAlarm, 1, 16);
    CHECKED_FUNC_CALL_EXPECT_ERR(BCM_ERR_INVAL_PARAMS, BCM_SetRelAlarm, BaseTestAlarm, 0, 3);
    CHECKED_FUNC_CALL_EXPECT_ERR(BCM_ERR_INVAL_PARAMS, BCM_SetRelAlarm, BaseTestAlarm, 16, 3);
    CHECKED_FUNC_CALL_EXPECT_ERR(BCM_ERR_INVAL_PARAMS, BCM_SetRelAlarm, BaseTestAlarm + 16UL, 1, 3);
    CHECKED_FUNC_CALL_EXPECT_ERR(BCM_ERR_INVAL_PARAMS, BCM_SetRelAlarm, BaseTestAlarm | 0xFF000000UL, 1, 3);

    CHECKED_FUNC_CALL(BCM_SetRelAlarm, BaseTestAlarm, 1, 0);
    BCM_WaitEvent(TriggerEvent4);
    BCM_ClearEvent(TriggerEvent4);

    /* Test BCM_CancelAlarm */
    CHECKED_FUNC_CALL_EXPECT_ERR(BCM_ERR_INVAL_PARAMS, BCM_CancelAlarm, BaseTestAlarm + 16UL)
    CHECKED_FUNC_CALL_EXPECT_ERR(BCM_ERR_INVAL_PARAMS, BCM_CancelAlarm, BaseTestAlarm | 0xFF000000UL)
    CHECKED_FUNC_CALL(BCM_CancelAlarm, BaseTestAlarm)

exit:
    if (0 != failLine) {
        (void)BCM_SetEvent(Task0, TriggerEvent4);
    } else {
        (void)BCM_SetEvent(Task0, TriggerEvent3);
    }
}

int32_t BCM_ExecuteAT(uint32_t aIndex)
{
    int32_t ret = BCM_AT_NOT_AVAILABLE;

    if ((1UL == aIndex) && (BCM_AT_EXECUTING != base_test_result1)) {
        base_test_result1 = BCM_AT_EXECUTING;
        BCM_ActivateTask(Task0);
        ret = BCM_ERR_OK;
    }

    return ret;
}

int32_t BCM_GetResultAT(uint32_t aIndex)
{
    int32_t ret = BCM_AT_NOT_AVAILABLE;

    if (1UL == aIndex) {
        ret = base_test_result1;
    }

    return ret;
}
