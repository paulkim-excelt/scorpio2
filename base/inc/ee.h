/*****************************************************************************
 Copyright 2020-2021 Broadcom Limited.  All rights reserved.

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
    @addtogroup grp_base_ifc
    @{
    This header file provides the function prototypes and macros
    that are necessary for BASE to be compatible with Erika

    @todo This file is not traced
    @file ee.h
    @version 0.1 Initial Version
*/
#ifndef EE_H
#define EE_H
#include <base.h>

#define INVALID_TASK                BASE_NUM_TASKS
#define EE_MAX_TASK                 BASE_NUM_TASKS
#define EE_BRCM_SYSTEM_TOS_SIZE     BASE_NUM_TASKS

#define ISR2(f)                                 \
COMP_NEVER_INLINE void f(void)

#define TASK(f)                                 \
void BASE_TASK_ ## f(void);                     \
void BASE_TASK_ENTRYPT_ ## f(void);             \
void BASE_TASK_ENTRYPT_ ## f(void)              \
{                                               \
    BASE_TASK_prestub();                        \
    BASE_TASK_ ## f();                          \
    BASE_TASK_poststub();                       \
}                                               \
COMP_NEVER_INLINE void BASE_TASK_ ## f(void)

#define ALARMCALLBACK(cb)                       \
void cb (void)

#ifndef STATUSTYPEDEFINED
#define STATUSTYPEDEFINED
typedef unsigned char StatusType;
#define E_OK                        ((StatusType)0U)
#endif

#define E_OS_ACCESS                 ((StatusType)1U)
#define E_OS_CALLEVEL               ((StatusType)2U)
#define E_OS_ID                     ((StatusType)3U)
#define E_OS_LIMIT                  ((StatusType)4U)
#define E_OS_NOFUNC                 ((StatusType)5U)
#define E_OS_RESOURCE               ((StatusType)6U)
#define E_OS_STATE                  ((StatusType)7U)
#define E_OS_VALUE                  ((StatusType)8U)
#define E_OS_SERVICEID              ((StatusType)9U)
#define E_OS_ILLEGAL_ADDRESS        ((StatusType)10U)
#define E_OS_MISSINGEND             ((StatusType)11U)
#define E_OS_DISABLEDINT            ((StatusType)12U)
#define E_OS_STACKFAULT             ((StatusType)13U)
#define E_OS_PARAM_POINTER          ((StatusType)14U)
#define E_OS_PROTECTION_MEMORY      ((StatusType)15U)
#define E_OS_PROTECTION_TIME        ((StatusType)16U)
#define E_OS_PROTECTION_ARRIVAL     ((StatusType)17U)
#define E_OS_PROTECTION_LOCKED      ((StatusType)18U)
#define E_OS_PROTECTION_EXCEPTION   ((StatusType)19U)
/* Spinlocks errors */
#define E_OS_SPINLOCK               ((StatusType)20U)
#define E_OS_INTERFERENCE_DEADLOCK  ((StatusType)21U)
#define E_OS_NESTING_DEADLOCK       ((StatusType)22U)
/* RPC errors */
#define E_OS_CORE                   ((StatusType)23U)

/* Implementation specific errors: they must start with E_OS_SYS_ */
/* Error during StartOS */
#define E_OS_SYS_INIT               ((StatusType)24U)

typedef uint32_t EE_TYPESTATUS;
typedef uint32_t TaskStateType;
typedef EE_TYPESTATUS *TaskStateRefType;
/* Constant of data type TaskStateType for task state running. */
#define RUNNING   ((EE_TYPESTATUS)0U)

/* Constant of data type TaskStateType for task state waiting. */
#define WAITING   ((EE_TYPESTATUS)1U)

/* Constant of data type TaskStateType for task state ready. */
#define READY     ((EE_TYPESTATUS)2U)

/* Constant of data type TaskStateType for task state suspended. */
#define SUSPENDED ((EE_TYPESTATUS)3U)

typedef uint32_t EE_TID;
typedef uint32_t EventMaskType;

/* This data type identifies a task. */
typedef EE_TID TaskType;

/* This data type points to a variable of TaskType. */
typedef EE_TID *TaskRefType;

int32_t GetTaskID(TaskRefType aTaskIDRef);
int32_t GetTaskState(const TaskType aTaskId, EE_TYPESTATUS *aTaskStatus);
int32_t SetEvent(const BCM_TaskType aTaskID, const BCM_EventMaskType aEventMask);
int32_t IncrementCounterHardware(const uint32_t aCounter);


#endif

