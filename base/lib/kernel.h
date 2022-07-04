/*****************************************************************************
 Copyright 2020 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_base_impl BASE Implementation
    @ingroup grp_base

    @addtogroup grp_base_impl
    @{
    This header provides the definitions of various kernel
    data structures used by the BASE implementatioin.

    @file kernel.h
    @brief BASE kernel data structures
    @version 0.1 Initial Version
*/

#ifndef KERNEL_H
#define KERNEL_H

#include <base.h>
#include <bcm_utils.h>
#include "prof_data.h"

/**
    @name BASE kernel Architecture IDs
    @{
    @brief Architecture IDs for the BASE kernel
*/
#define BRCM_SWARCH_BASE_KERNEL_ASSERT_MACRO                        (0x8101U)    /**< @brief #BASE_KERNEL_ASSERT                     */
#define BRCM_SWARCH_BASE_TASK_ENTRYPT_FNPTR_TYPE                    (0x8102U)    /**< @brief #BASE_TaskEntryPtFnPtrType              */
#define BRCM_SWARCH_BASE_ALARMCB_FNPTR_TYPE                         (0x8103U)    /**< @brief #BASE_AlarmCbFnPtrType                  */
#define BRCM_SWARCH_BASE_TASK_SCHED_STATE_TYPE                      (0x8104U)    /**< @brief #BASE_TaskSchedStateType                */
#define BRCM_SWARCH_BASE_ALARM_OP_STATE_TYPE                        (0x8105U)    /**< @brief #BASE_AlarmOpStateType                  */
#define BRCM_SWARCH_BASE_ALARM_COUNTER_IDX_MACRO                    (0x8106U)    /**< @brief #BASE_ALARM_COUNTER_IDX_MASK            */
#define BRCM_SWARCH_BASE_ALARM_ARRAY_IDX_MACRO                      (0x8107U)    /**< @brief #BASE_ALARM_ARRAY_IDX_MASK              */
#define BRCM_SWARCH_BASE_EXTRACT_COUNTER_IDX_FROM_ALARM_ID_MACRO    (0x8108U)    /**< @brief #BASE_EXTRACT_COUNTER_IDX_FROM_ALARM_ID */
#define BRCM_SWARCH_BASE_EXTRACT_ARRAY_IDX_FROM_ALARM_ID_MACRO      (0x8109U)    /**< @brief #BASE_EXTRACT_ARRAY_IDX_FROM_ALARM_ID   */
#define BRCM_SWARCH_BASE_TASK_STATE_TYPE                            (0x810AU)    /**< @brief #BASE_TaskStateType                     */
#define BRCM_SWARCH_BASE_TASK_CONST_STATE_TYPE                      (0x810BU)    /**< @brief #BASE_TaskConstStateType                */
#define BRCM_SWARCH_BASE_RUN_QUEUE_CONST_STATE_TYPE                 (0x810CU)    /**< @brief #BASE_RunQueueConstStateType            */
#define BRCM_SWARCH_BASE_ALARM_STATE_TYPE                           (0x810DU)    /**< @brief #BASE_AlarmStateType                    */
#define BRCM_SWARCH_BASE_ALARM_CONST_STATE_TYPE                     (0x810EU)    /**< @brief #BASE_AlarmConstStateType               */
#define BRCM_SWARCH_BASE_COUNTER_DESC_TYPE                          (0x810FU)    /**< @brief #BASE_CounterDescType                   */
#define BRCM_SWARCH_BASE_CUR_TASKID_GLOBAL                          (0x8110U)    /**< @brief #BASE_CurTaskId                         */
#define BRCM_SWARCH_BASE_TICKCOUNT_LAST_TASK_SWITCH_GLOBAL          (0x8111U)    /**< @brief #BASE_TickCountLastTaskSwitch           */
#define BRCM_SWARCH_BASE_TASK_STATES_GLOBAL                         (0x8112U)    /**< @brief #BASE_TaskStates                        */
#define BRCM_SWARCH_BASE_TASK_CONST_STATES_GLOBAL                   (0x8113U)    /**< @brief #BASE_TaskConstStates                   */
#define BRCM_SWARCH_BASE_RUN_QUEUES_GLOBAL                          (0x8114U)    /**< @brief #BASE_RunQueues                         */
#define BRCM_SWARCH_BASE_RUN_QUEUE_CONST_STATES_GLOBAL              (0x8115U)    /**< @brief #BASE_RunQueueConstStates               */
#define BRCM_SWARCH_BASE_COUNTERS_GLOBAL                            (0x8116U)    /**< @brief #BASE_Counters                          */
#define BRCM_SWARCH_BASE_TASK_STATES_SP_STRIDES_GLOBAL              (0x8117U)    /**< @brief #BASE_TaskStatesSpStride                */
#define BRCM_SWARCH_BASE_TASK_STATES_FIRST_SP_ADDR_GLOBAL           (0x8118U)    /**< @brief #BASE_TaskStatesFirstSpAddr             */
#define BRCM_SWARCH_BASE_TASK_SWITCH_POST_OPS_PROC                  (0x8119U)    /**< @brief #BASE_TaskSwitchPostOps                 */
#define BRCM_SWARCH_BASE_GET_NEXT_TASK_TO_SCHED_PROC                (0x811AU)    /**< @brief #BASE_GetNextTaskToSched                */
#define BRCM_SWARCH_BASE_ARCH_START_OS_PROC                         (0x811BU)    /**< @brief #BASE_ArchStartOS                       */
#define BRCM_SWARCH_BASE_ARCH_RESET_TASK_STATE_PROC                 (0x811CU)    /**< @brief #BASE_ArchResetTaskState                */
#define BRCM_SWARCH_BASE_ARCH_RUN_SCHED_AT_EXIT_PROC                (0x811DU)    /**< @brief #BASE_ArchRunSchedAtExit                */
/** @} */

/** @brief Base kernel assert macro

    @behavior Sync, Non-reentrant

    @return void

    @trace #BRCM_SWREQ_BASE
*/
#define BASE_KERNEL_ASSERT BCM_ASSERT

/** @brief Task entry point function prototype

    @behavior Sync, Non-reentrant

    @return void

    @trace #BRCM_SWREQ_BASE
*/
typedef void (*BASE_TaskEntryPtFnPtrType)(void);

/** @brief Alarm callback function prototype

    @behavior Sync, Non-reentrant

    @return void

    @trace #BRCM_SWREQ_BASE
*/
typedef void (*BASE_AlarmCbFnPtrType)(void);

/**
    @{
    @brief Task sched states

    @trace #BRCM_SWREQ_BASE
*/
typedef uint32_t BASE_TaskSchedStateType;
#define BASE_TASK_SCHED_STATE_DEACTIVATED   (0UL)
#define BASE_TASK_SCHED_STATE_RUNNABLE      (1UL)
#define BASE_TASK_SCHED_STATE_BLOCKED       (2UL)
/** @} */

/**
    @{
    @brief Alarm states

    @trace #BRCM_SWREQ_BASE
*/
typedef uint32_t BASE_AlarmOpStateType;
#define BASE_ALARM_OP_STATE_ACTIVE          (0UL)
#define BASE_ALARM_OP_STATE_DORMANT         (1UL)
/** @} */

/**
    @{
    @brief Mask and shift to extract the counter IDX from alarm ID

    @trace #BRCM_SWREQ_BASE
*/
#define BASE_ALARM_COUNTER_IDX_MASK         (0xFF000000UL)
#define BASE_ALARM_COUNTER_IDX_SHIFT        (24UL)
/** @} */

/**
    @{
    @brief Mask and shift to extract the alarm array IDX from alarm ID

    @trace #BRCM_SWREQ_BASE
*/
#define BASE_ALARM_ARRAY_IDX_MASK           (0x00FFFFFFUL)
#define BASE_ALARM_ARRAY_IDX_SHIFT          (0UL)
/** @} */

/**
    @brief Helper to extract the counter idx from the alarm ID

    @trace #BRCM_SWREQ_BASE
*/
#define BASE_EXTRACT_COUNTER_IDX_FROM_ALARM_ID(aId) \
    (((aId) & BASE_ALARM_COUNTER_IDX_MASK) >> BASE_ALARM_COUNTER_IDX_SHIFT)

/**
    @brief Helper to extract the alarm array idx from the alarm ID

    @trace #BRCM_SWREQ_BASE
*/
#define BASE_EXTRACT_ARRAY_IDX_FROM_ALARM_ID(aId)   \
    (((aId) & BASE_ALARM_ARRAY_IDX_MASK) >> BASE_ALARM_ARRAY_IDX_SHIFT)

/**
    @brief Task mutable state

    @trace #BRCM_SWREQ_BASE
*/
typedef struct sBASE_TaskStateType {
    void *sp;                                       /**< @brief Stack top                       */
    BCM_EventMaskType awaitedEventMask;             /**< @brief Events being waited upon        */
    BCM_EventMaskType pendingEventMask;             /**< @brief Events set against this task    */
    BASE_TaskSchedStateType taskSchedState;         /**< @brief Task sched state                */
} BASE_TaskStateType;

/**
    @brief Task const state

    @trace #BRCM_SWREQ_BASE
*/
typedef struct sBASE_TaskConstStateType {
    uint32_t runQueueIdx;                           /**< @brief Run queue index corresponding to this task  */
    uint8_t  runQueueObjName;                       /**< @brief Alias for this task on the run queue        */
    const struct BRCM_TaskInfoType *taskInfo;       /**< @brief Task info                                   */
    BASE_TaskSchedStateType initState;              /**< @brief Task sched state on OS start                */
    BASE_TaskEntryPtFnPtrType taskEntryPtFnPtr;     /**< @brief Task entry point                            */
} BASE_TaskConstStateType;

/**
    @brief Run queue const state

    @trace #BRCM_SWREQ_BASE
*/
typedef struct sBASE_RunQueueConstStateType {
    uint32_t numTasks;
    const uint32_t *objNameToTaskIdMap;
} BASE_RunQueueConstStateType;

/**
    @brief Alarm mutable state

    @trace #BRCM_SWREQ_BASE
*/
typedef struct sBASE_AlarmStateType {
    BCM_TickType cycleCnt;                          /**< @brief Refer to @ref BASE_SetRelAlarm  */
    BCM_TickType numTicksPending;                   /**< @brief Outstanding counter increments before raising the callback  */
    BASE_AlarmOpStateType alarmOpState;             /**< @brief Alarm state                     */
} BASE_AlarmStateType;

/**
    @brief Alarm const state

    @trace #BRCM_SWREQ_BASE
*/
typedef struct sBASE_AlarmConstStateType {
    BCM_AlarmType alarmId;                          /**< @brief Alarm ID                        */
    const char *alarmName;                          /**< @brief Alarm name                      */
    BASE_AlarmCbFnPtrType alarmCbFnPtr;             /**< @brief Alarm callback function pointer */
    const uint32_t initCycleCnt;                    /**< @brief Initial cycle count on OS start */
    const uint32_t initNumTicks;                    /**< @brief Initial numticks on OS start    */
    const BASE_AlarmOpStateType initState;          /**< @brief Initial alarm state on OS start */
} BASE_AlarmConstStateType;

/**
    @brief Counter description

    @trace #BRCM_SWREQ_BASE
*/
typedef struct sBASE_CounterDescType {
    uint32_t numAlarms;                             /**< @brief Num alarms associated with this counter                             */
    uint32_t minCycleCnt;                           /**< @brief Min cycle count supported by the alarms attached to this counter    */
    uint32_t maxAllowedVal;                         /**< @brief Maximum allowed aIncrement and aCycle in @ref BASE_SetRelAlarm      */
    BASE_AlarmStateType *alarmStates;               /**< @brief Array of mutable alarm states attached to this counter              */
    const BASE_AlarmConstStateType *alarmConstStates;   /**< @brief Array of immutable alarm states attached to this counter        */
} BASE_CounterDescType;

/**
    @brief Current task ID

    @trace #BRCM_SWREQ_BASE
*/
extern uint32_t BASE_CurTaskId;

/**
    @brief Tick count when the last task switch was executed

    @trace #BRCM_SWREQ_BASE
*/
extern uint64_t BASE_TickCountLastTaskSwitch;

/**
    @brief Global array holding the task mutable states

    @trace #BRCM_SWREQ_BASE
*/
extern BASE_TaskStateType BASE_TaskStates[BASE_NUM_TASKS + 1UL];

/**
    @brief Global array holding the task immutable states

    @trace #BRCM_SWREQ_BASE
*/
extern const BASE_TaskConstStateType BASE_TaskConstStates[BASE_NUM_TASKS];

/**
    @brief Run queues global

    @trace #BRCM_SWREQ_BASE
*/
extern LWQ_BufferType BASE_RunQueues[BASE_NUM_TASK_SCHED_GROUPS];

/**
    @brief Const states assosiated with the run queues

    @trace #BRCM_SWREQ_BASE
*/
extern const BASE_RunQueueConstStateType BASE_RunQueueConstStates[BASE_NUM_TASK_SCHED_GROUPS];

/**
    @brief Global array describing the available counters in the system

    @trace #BRCM_SWREQ_BASE
*/
extern const BASE_CounterDescType BASE_Counters[BASE_NUM_COUNTERS];

/**
    @brief Size of an @ref BASE_TaskStateType instance

    @trace #BRCM_SWREQ_BASE
*/
extern const uint32_t BASE_TaskStatesSpStride;

/**
    @brief Address of the sp member in the first element of @ref BASE_TaskStates

    @trace #BRCM_SWREQ_BASE
*/
extern const uint32_t BASE_TaskStatesFirstSpAddr;

/**
    @brief Task switch post ops

    The context switching routine is expected to issue a
    call to this function when a task switch is performed.

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aNewTaskId              ID of the task that is scheduled to run next
    @param[in]      aOldTaskId              ID of the task that has been scheduled out

    return void

    @post None

    @trace #BRCM_SWREQ_BASE
*/
void BASE_TaskSwitchPostOps(const uint32_t aNewTaskId, const uint32_t aOldTaskId);

/**
    @brief Get the task ID of the next task to schedule

    @behavior Sync, Non-reentrant

    @pre None

    @return Task ID of the next task to run

    @post None

    @trace #BRCM_SWREQ_BASE
*/
uint32_t BASE_GetNextTaskToSched(void);

/**
    @brief Function implementing the arch specific start OS ops

    @behavior Sync, Non-reentrant

    @pre None

    @return void

    @post None

    @trace #BRCM_SWREQ_BASE
*/
void BASE_ArchStartOS(void);

/**
    @brief Function implementing the arch specific task state reset ops

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aTaskIdx                Idx of the task to perform
                                            reset ops on

    return void

    @post None

    @trace #BRCM_SWREQ_BASE
*/
void BASE_ArchResetTaskState(const uint32_t aTaskIdx);

/**
    @brief Run the task scheduler at exception exit point

    @behavior Sync, Non-reentrant

    @pre None

    return void

    @post Task Scheduler will be invoked at the exception exit
        point

    @trace #BRCM_SWREQ_BASE
*/
void BASE_ArchRunSchedAtExit(void);

#endif  /* KERNEL_H */
/** @} */
