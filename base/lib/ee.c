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
    @addtogroup grp_base_impl
    @{
    This source file provides function implementations
    that are necessary for BASE to be compatible with Erika

    @todo This file is not traced
    @file ee.c
    @version 0.1 Initial Version
*/

#include <ee.h>
#include <base_kernel_services.h>
#include "kernel.h"

int32_t GetTaskID(TaskRefType aTaskIDRef)
{
    int32_t ret;

    _Static_assert(sizeof(TaskType) >= sizeof(uint32_t),
        "We expect this condition to be true!");

    if (NULL != aTaskIDRef) {
        *aTaskIDRef = BASE_CurTaskId;
        ret = E_OK;
    } else {
        ret = E_OS_ILLEGAL_ADDRESS;
    }

    return ret;
}

int32_t GetTaskState(const TaskType aTaskId, EE_TYPESTATUS *aTaskStatus)
{
    int32_t ret;

    if (NULL == aTaskStatus) {
        ret = E_OS_ILLEGAL_ADDRESS;
    } else if (aTaskId >= BASE_NUM_TASKS) {
        ret = E_OS_VALUE;
    } else {
        ret = E_OK;

        switch (BASE_TaskStates[aTaskId].taskSchedState) {
            case BASE_TASK_SCHED_STATE_RUNNABLE:
                if (BASE_CurTaskId == aTaskId) {
                    *aTaskStatus = RUNNING;
                } else {
                    *aTaskStatus = READY;
                }
                break;
            case BASE_TASK_SCHED_STATE_BLOCKED:
                *aTaskStatus = WAITING;
                break;
            case BASE_TASK_SCHED_STATE_DEACTIVATED:
            default:
                *aTaskStatus = SUSPENDED;
                break;
        }
    }

    return ret;
}

int32_t SetEvent(const BCM_TaskType aTaskID, const BCM_EventMaskType aEventMask)
{
    return BASE_SetEvent(aTaskID, aEventMask);
}

int32_t IncrementCounterHardware(const uint32_t aCounter)
{
    return BASE_IncrementCounter(aCounter);
}

