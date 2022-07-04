/*****************************************************************************
 Copyright 2020-2022 Broadcom Limited.  All rights reserved.

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
    @addtogroup grp_base_impl
    @{
    The BASE kernel implementation

    @file kernel_common.c
    @brief BASE kernel implementation
    @version 0.1 Initial Version
*/

#include <base.h>
#include <base_kernel_services.h>
#include <bcm_thread_safety.h>

#include "kernel.h"

/**
    @name BASE kernel design IDs
    @{
    @brief Design IDs for the BASE kernel
*/
#define BRCM_SWDSGN_BASE_ADD_TASK_TO_RUN_QUEUE_PROC         (0xB101U)    /**< @brief #BASE_AddTaskToRunQueue      */
#define BRCM_SWDSGN_BASE_REMOVE_TASK_FROM_RUN_QUEUE_PROC    (0xB102U)    /**< @brief #BASE_RemoveTaskFromRunQueue */
#define BRCM_SWDSGN_BASE_GET_NEXT_TASK_TO_SCHED_PROC        (0xB103U)    /**< @brief #BASE_GetNextTaskToSched     */
#define BRCM_SWDSGN_BASE_TASK_SWITCH_POST_OPS_PROC          (0xB104U)    /**< @brief #BASE_TaskSwitchPostOps      */
#define BRCM_SWDSGN_BASE_TASK_PRESTUP_PROC                  (0xB105U)    /**< @brief #BASE_TASK_prestub           */
#define BRCM_SWDSGN_BASE_TASK_POSTSTUB_PROC                 (0xB106U)    /**< @brief #BASE_TASK_poststub          */
#define BRCM_SWDSGN_BASE_ACTIVATE_TASK_PROC                 (0xB107U)    /**< @brief #BASE_ActivateTask           */
#define BRCM_SWDSGN_BASE_TERMINATE_TASK_PROC                (0xB108U)    /**< @brief #BASE_TerminateTask          */
#define BRCM_SWDSGN_BASE_START_OS_PROC                      (0xB109U)    /**< @brief #BASE_StartOS                */
#define BRCM_SWDSGN_BASE_GET_EVENT_PROC                     (0xB10AU)    /**< @brief #BASE_GetEvent               */
#define BRCM_SWDSGN_BASE_SET_EVENT_PROC                     (0xB10BU)    /**< @brief #BASE_SetEvent               */
#define BRCM_SWDSGN_BASE_CLEAR_EVENT_PROC                   (0xB10CU)    /**< @brief #BASE_ClearEvent             */
#define BRCM_SWDSGN_BASE_WAIT_EVENT_PROC                    (0xB10DU)    /**< @brief #BASE_WaitEvent              */
#define BRCM_SWDSGN_BASE_INCREMENT_COUNTER_PROC             (0xB10EU)    /**< @brief #BASE_IncrementCounter       */
#define BRCM_SWDSGN_BASE_SET_REL_ALARM_PROC                 (0xB10FU)    /**< @brief #BASE_SetRelAlarm            */
#define BRCM_SWDSGN_BASE_CANCEL_ALARM_PROC                  (0xB110U)    /**< @brief #BASE_CancelAlarm            */
#define BRCM_SWDSGN_BASE_PROFILE_DATA_GLOBAL                (0xB111U)    /**< @brief #BASE_ProfileData            */
/** @} */

/**
    @brief Add a task to the appropriate run queue

    This routine transitions a task to the runnable state and queues
    it on an appropriate run queue

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aTaskId         ID of the task to be added to the run queue

    return void

    @post Task with ID aTaskId is made runnable and is added to the
        appropriate run queue

    @trace #BRCM_SWARCH_BASE_ACTIVATE_TASK_PROC
    @trace #BRCM_SWARCH_BASE_START_OS_PROC
    @trace #BRCM_SWARCH_BASE_SET_EVENT_PROC
    @trace #BRCM_SWREQ_BASE
*/
static void BASE_AddTaskToRunQueue(const uint32_t aTaskId)
{
    BASE_TaskStateType *const taskState = &BASE_TaskStates[aTaskId];
    const BASE_TaskConstStateType *const taskConstState = &BASE_TaskConstStates[aTaskId];

    LWQ_BufferType *const runQueue = &BASE_RunQueues[taskConstState->runQueueIdx];

    const uint32_t ret = LWQ_Push(runQueue, taskConstState->runQueueObjName);
    BASE_KERNEL_ASSERT(BCM_ERR_OK == ret)

    taskState->taskSchedState = BASE_TASK_SCHED_STATE_RUNNABLE;
    return;
}

/**
    @brief Remove a task from the appropriate run queue

    This routine transitions a task to the blocked state and dequeues
    it from an appropriate run queue

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aTaskId         ID of the task to be removed from the run queue

    return void

    @post Task with ID aTaskId is transitioned to blocked state and is removed
        from the appropriate run queue

    @trace #BRCM_SWARCH_BASE_WAIT_EVENT_PROC
    @trace #BRCM_SWREQ_BASE
*/
static void BASE_RemoveTaskFromRunQueue(const uint32_t aTaskId)
{
    uint8_t popVal = 0U;
    BASE_TaskStateType *const taskState = &BASE_TaskStates[aTaskId];
    const BASE_TaskConstStateType *const taskConstState = &BASE_TaskConstStates[aTaskId];
    LWQ_BufferType *const runQueue = &BASE_RunQueues[taskConstState->runQueueIdx];

    const uint32_t ret = LWQ_Pop(runQueue, &popVal);
    BASE_KERNEL_ASSERT(BCM_ERR_OK == ret)
    BASE_KERNEL_ASSERT(taskConstState->runQueueObjName == popVal)

    taskState->taskSchedState = BASE_TASK_SCHED_STATE_BLOCKED;
    return;
}

/**
    @trace #BRCM_SWARCH_BASE_GET_NEXT_TASK_TO_SCHED_PROC
    @trace #BRCM_SWREQ_BASE
*/
uint32_t BASE_GetNextTaskToSched(void)
{
    uint32_t runQueueIdx;
    uint32_t nextTask = BASE_NUM_TASKS;

    for (runQueueIdx = 0UL; runQueueIdx < BASE_NUM_TASK_SCHED_GROUPS; runQueueIdx++) {
        const LWQ_BufferType runQueue = BASE_RunQueues[runQueueIdx];
        if (0UL != LWQ_Length(runQueue)) {
            const uint8_t runQueueObj = LWQ_PeekFirst(runQueue);
            const BASE_RunQueueConstStateType *const runQueueConstState =
                &BASE_RunQueueConstStates[runQueueIdx];

            nextTask = runQueueConstState->objNameToTaskIdMap[runQueueObj];
            break;
        }
    }

    return nextTask;
}

/**
    @trace #BRCM_SWARCH_BASE_TASK_SWITCH_POST_OPS_PROC
    @trace #BRCM_SWREQ_BASE
*/
volatile uint64_t BASE_ProfileData[BASE_NUM_PROFILE_TASKS];

/**
    @trace #BRCM_SWARCH_BASE_TASK_SWITCH_POST_OPS_PROC
    @trace #BRCM_SWREQ_BASE
*/
void BASE_TaskSwitchPostOps(const uint32_t aNewTaskId, const uint32_t aOldTaskId)
{
    const uint64_t curTickCount = BASE_PLATFORM_GET_TICKS();

    /* Update the prof data */
    if (BASE_NUM_PROFILE_TASKS > aOldTaskId) {
        BASE_ProfileData[aOldTaskId] += (curTickCount - BASE_TickCountLastTaskSwitch);
    }

    /* Update the tick count */
    BASE_TickCountLastTaskSwitch = curTickCount;

#if defined(ENABLE_THREAD_PROTECTION)
    /* Update the MPU config for the new task */
    BCM_AddTaskMPUEntry(aNewTaskId);
#endif

    return;
}

/**
    @trace #BRCM_SWARCH_BASE_TASK_PRESTUB_PROC
    @trace #BRCM_SWREQ_BASE
*/
void BASE_TASK_prestub(void)
{
    /* Do nothing */
}

/**
    @trace #BRCM_SWARCH_BASE_TASK_POSTSTUB_PROC
    @trace #BRCM_SWREQ_BASE
*/
void BASE_TASK_poststub(void)
{
    BCM_TerminateTask();
}

/**
    @trace #BRCM_SWARCH_BASE_ACTIVATE_TASK_PROC
    @trace #BRCM_SWREQ_BASE
*/
int32_t BASE_ActivateTask(const BCM_TaskType aTaskID)
{
    int32_t ret;

    if ((0 <= aTaskID) && (((BCM_TaskType)BASE_NUM_TASKS) > aTaskID)) {
        BASE_TaskStateType *const taskState = &BASE_TaskStates[aTaskID];

        if (BASE_TASK_SCHED_STATE_DEACTIVATED == taskState->taskSchedState) {

            taskState->sp = NULL;
            taskState->awaitedEventMask = 0UL;
            taskState->pendingEventMask = 0UL;

            BASE_ArchResetTaskState(aTaskID);
            BASE_AddTaskToRunQueue(aTaskID);
            BASE_ArchRunSchedAtExit();
            ret = BCM_ERR_OK;

        } else {
            ret = BCM_ERR_INVAL_STATE;
        }

    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }

    return ret;
}

/**
    @trace #BRCM_SWARCH_BASE_TERMINATE_TASK_PROC
    @trace #BRCM_SWREQ_BASE
*/
int32_t BASE_TerminateTask(void)
{
    int32_t ret;
    BASE_TaskStateType *const taskState = &BASE_TaskStates[BASE_CurTaskId];

    if (BASE_TASK_SCHED_STATE_RUNNABLE == taskState->taskSchedState) {
        BASE_RemoveTaskFromRunQueue(BASE_CurTaskId);
        BASE_ArchRunSchedAtExit();
        taskState->taskSchedState = BASE_TASK_SCHED_STATE_DEACTIVATED;
        ret = BCM_ERR_OK;
    } else {
        ret = BCM_ERR_INVAL_STATE;
    }

    return ret;
}

/**
    @trace #BRCM_SWARCH_BASE_START_OS_PROC
    @trace #BRCM_SWREQ_BASE
*/
int32_t BASE_StartOS(const BCM_AppModeType aMode)
{
    (void) aMode;
    uint32_t idx;

    /* Initialize the run queues */
    for (idx = 0UL; idx < BASE_NUM_TASK_SCHED_GROUPS; idx++) {
        LWQ_Init(&BASE_RunQueues[idx]);
    }

    /* Initialize task data structures */
    for (idx = 0UL; idx < BASE_NUM_TASKS; idx++) {
        BASE_TaskStateType *const taskState = &BASE_TaskStates[idx];
        const BASE_TaskConstStateType *const taskConstState = &BASE_TaskConstStates[idx];

        taskState->sp = NULL;
        taskState->awaitedEventMask = 0UL;
        taskState->pendingEventMask = 0UL;
        taskState->taskSchedState = taskConstState->initState;

        if (BASE_TASK_SCHED_STATE_RUNNABLE == taskState->taskSchedState) {
            BASE_AddTaskToRunQueue(idx);
            BASE_ArchResetTaskState(idx);
        }
    }

    /* Initialize alarm data structures */
    for (idx = 0UL; idx < BASE_NUM_COUNTERS; idx++) {
        uint32_t aIdx;
        const BASE_CounterDescType *const counterDesc = &BASE_Counters[idx];

        for (aIdx = 0UL; aIdx < counterDesc->numAlarms; aIdx++) {
            BASE_AlarmStateType *const alarmState = &counterDesc->alarmStates[aIdx];
            const BASE_AlarmConstStateType *const alarmConstState =
                &counterDesc->alarmConstStates[aIdx];

            alarmState->cycleCnt = alarmConstState->initCycleCnt;
            alarmState->numTicksPending = alarmConstState->initNumTicks;
            alarmState->alarmOpState = alarmConstState->initState;
        }
    }

    /* Arch specific init */
    BASE_ArchStartOS();

    return BCM_ERR_OK;
}

/**
    @trace #BRCM_SWARCH_BASE_GET_EVENT_PROC
    @trace #BRCM_SWREQ_BASE
*/
int32_t BASE_GetEvent(const BCM_TaskType aTaskID, BCM_EventMaskType *const aEventMask)
{
    int32_t ret;

    if ((0 <= aTaskID) && (((BCM_TaskType)BASE_NUM_TASKS) > aTaskID) && (NULL != aEventMask)) {
        BASE_TaskStateType *const taskState = &BASE_TaskStates[aTaskID];
        *aEventMask = taskState->pendingEventMask;
        ret = BCM_ERR_OK;
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }

    return ret;
}

/**
    @trace #BRCM_SWARCH_BASE_SET_EVENT_PROC
    @trace #BRCM_SWREQ_BASE
*/
int32_t BASE_SetEvent(const BCM_TaskType aTaskID, const BCM_EventMaskType aEventMask)
{
    int32_t ret;

    if ((0 <= aTaskID) && (((BCM_TaskType)BASE_NUM_TASKS) > aTaskID)) {
        BASE_TaskStateType *const taskState = &BASE_TaskStates[aTaskID];

        if (BASE_TASK_SCHED_STATE_DEACTIVATED != taskState->taskSchedState) {
            taskState->pendingEventMask |= aEventMask;

            if ((BASE_TASK_SCHED_STATE_RUNNABLE != taskState->taskSchedState) &&
                (taskState->awaitedEventMask & taskState->pendingEventMask)) {
                BASE_AddTaskToRunQueue(aTaskID);
                BASE_ArchRunSchedAtExit();
                taskState->awaitedEventMask = 0UL;
            }

            ret = BCM_ERR_OK;
        } else {
            ret = BCM_ERR_INVAL_STATE;
        }

    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }

    return ret;
}

/**
    @trace #BRCM_SWARCH_BASE_CLEAR_EVENT_PROC
    @trace #BRCM_SWREQ_BASE
*/
int32_t BASE_ClearEvent(const BCM_EventMaskType aEventMask)
{
    int32_t ret;
    BASE_TaskStateType *const taskState = &BASE_TaskStates[BASE_CurTaskId];

    if (BASE_TASK_SCHED_STATE_RUNNABLE == taskState->taskSchedState) {
        taskState->pendingEventMask &= ~(aEventMask);
        ret = BCM_ERR_OK;
    } else {
        ret = BCM_ERR_INVAL_STATE;
    }

    return ret;
}

/**
    @trace #BRCM_SWARCH_BASE_WAIT_EVENT_PROC
    @trace #BRCM_SWREQ_BASE
*/
int32_t BASE_WaitEvent(const BCM_EventMaskType aEventMask)
{
    int32_t ret;
    BASE_TaskStateType *const taskState = &BASE_TaskStates[BASE_CurTaskId];

    if (BASE_TASK_SCHED_STATE_RUNNABLE == taskState->taskSchedState) {

        if (0UL == (aEventMask & taskState->pendingEventMask)) {
            taskState->awaitedEventMask = aEventMask;
            BASE_RemoveTaskFromRunQueue(BASE_CurTaskId);
            BASE_ArchRunSchedAtExit();
        }

        ret = BCM_ERR_OK;

    } else {
        ret = BCM_ERR_INVAL_STATE;
    }

    return ret;
}

/**
    @trace #BRCM_SWARCH_BASE_INCREMENT_COUNTER_PROC
    @trace #BRCM_SWREQ_BASE
*/
int32_t BASE_IncrementCounter(const uint32_t aCounterID)
{
    int32_t ret;

    if (BASE_NUM_COUNTERS > aCounterID) {
        uint32_t idx;
        const BASE_CounterDescType *const counterDesc = &BASE_Counters[aCounterID];

        /* Process the active alarms attached to this counter */
        for (idx = 0UL; idx < counterDesc->numAlarms; idx++) {
            BASE_AlarmStateType *const alarmState = &counterDesc->alarmStates[idx];
            const BASE_AlarmConstStateType *const alarmConstState =
                &counterDesc->alarmConstStates[idx];

            if (BASE_ALARM_OP_STATE_ACTIVE == alarmState->alarmOpState) {
                alarmState->numTicksPending -= 1UL;

                if (0UL == alarmState->numTicksPending) {
                    /* Fire the callback */
                    alarmConstState->alarmCbFnPtr();

                    /* Stop the alarm or reload the counter */
                    if (0UL == alarmState->cycleCnt) {
                        alarmState->alarmOpState = BASE_ALARM_OP_STATE_DORMANT;
                    } else {
                        alarmState->numTicksPending = alarmState->cycleCnt;
                    }
                }
            }
        }

        ret = BCM_ERR_OK;
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }

    return ret;
}

/**
    @trace #BRCM_SWARCH_BASE_SET_REL_ALARM_PROC
    @trace #BRCM_SWREQ_BASE
*/
int32_t BASE_SetRelAlarm(const BCM_AlarmType aAlarmID, const BCM_TickType aIncrement, const BCM_TickType aCycle)
{
    int32_t ret;
    const uint32_t ctrIdx = BASE_EXTRACT_COUNTER_IDX_FROM_ALARM_ID(aAlarmID);

    /* Validate counter index */
    if (BASE_NUM_COUNTERS > ctrIdx) {
        const uint32_t arrIdx = BASE_EXTRACT_ARRAY_IDX_FROM_ALARM_ID(aAlarmID);
        const BASE_CounterDescType *const counterDesc = &BASE_Counters[ctrIdx];

        /* Validate array index and other params */
        if ((counterDesc->numAlarms > arrIdx) &&
            (0 < aIncrement) &&
            (counterDesc->maxAllowedVal >= aIncrement) &&
            ((0UL == aCycle) || (counterDesc->minCycleCnt <= aCycle)) &&
            (counterDesc->maxAllowedVal >= aCycle)) {

            /* All good. Setup the alarm state */
            BASE_AlarmStateType *const alarmState = &counterDesc->alarmStates[arrIdx];

            alarmState->cycleCnt = aCycle;
            alarmState->numTicksPending = aIncrement;
            alarmState->alarmOpState = BASE_ALARM_OP_STATE_ACTIVE;

            ret = BCM_ERR_OK;

        } else {
            ret = BCM_ERR_INVAL_PARAMS;
        }

    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }

    return ret;
}

/**
    @trace #BRCM_SWARCH_BASE_CANCEL_ALARM_PROC
    @trace #BRCM_SWREQ_BASE
*/
int32_t BASE_CancelAlarm(const BCM_AlarmType aAlarmID)
{
    int32_t ret;
    const uint32_t ctrIdx = BASE_EXTRACT_COUNTER_IDX_FROM_ALARM_ID(aAlarmID);

    /* Validate counter index */
    if (BASE_NUM_COUNTERS > ctrIdx) {
        const uint32_t arrIdx = BASE_EXTRACT_ARRAY_IDX_FROM_ALARM_ID(aAlarmID);
        const BASE_CounterDescType *const counterDesc = &BASE_Counters[ctrIdx];

        /* Validate array index */
        if (counterDesc->numAlarms > arrIdx) {
            counterDesc->alarmStates[arrIdx].alarmOpState = BASE_ALARM_OP_STATE_DORMANT;
            ret = BCM_ERR_OK;
        } else {
            ret = BCM_ERR_INVAL_PARAMS;
        }

    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }

    return ret;
}
/** @} */
