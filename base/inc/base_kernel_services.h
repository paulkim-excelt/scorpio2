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
    @addtogroup grp_base_ifc
    @{
    This header file provides the function prototypes which can be used
    to request various kernel services

    @file base_kernel_services.h
    @brief BASE kernel services Interface File
    Function prototypes for the kernel services offered by base
    @version 0.1 Initial Version
*/
#ifndef BASE_KERNEL_SERVICES_H
#define BASE_KERNEL_SERVICES_H

#include <stdint.h>
#include <osil/bcm_osil.h>
#include <osil/bcm_osil_svc.h>

/**
    @name BASE kernel services Architecture IDs
    @{
    @brief Architecture IDs for BASE kernel services
*/
#define BRCM_SWARCH_BASE_ACTIVATE_TASK_PROC        (0x8501U)    /**< @brief #BASE_ActivateTask     */
#define BRCM_SWARCH_BASE_TERMINATE_TASK_PROC       (0x8502U)    /**< @brief #BASE_TerminateTask    */
#define BRCM_SWARCH_BASE_START_OS_PROC             (0x8503U)    /**< @brief #BASE_StartOS          */
#define BRCM_SWARCH_BASE_GET_EVENT_PROC            (0x8504U)    /**< @brief #BASE_GetEvent         */
#define BRCM_SWARCH_BASE_SET_EVENT_PROC            (0x8505U)    /**< @brief #BASE_SetEvent         */
#define BRCM_SWARCH_BASE_CLEAR_EVENT_PROC          (0x8506U)    /**< @brief #BASE_ClearEvent       */
#define BRCM_SWARCH_BASE_WAIT_EVENT_PROC           (0x8507U)    /**< @brief #BASE_WaitEvent        */
#define BRCM_SWARCH_BASE_INCREMENT_COUNTER_PROC    (0x8508U)    /**< @brief #BASE_IncrementCounter */
#define BRCM_SWARCH_BASE_SET_REL_ALARM_PROC        (0x8509U)    /**< @brief #BASE_SetRelAlarm      */
#define BRCM_SWARCH_BASE_CANCEL_ALARM_PROC         (0x850AU)    /**< @brief #BASE_CancelAlarm      */
#define BRCM_SWARCH_BASE_EXEC_HANDOVER_PROC        (0x850BU)    /**< @brief #BASE_ExecHandover     */

/** @} */

/**
    @brief Activate a task

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aTaskId                 ID of the task to activate

    Return values are documented in reverse-chronological order
    @retval         #BCM_ERR_OK             Requested task activated
    @retval         #BCM_ERR_INVAL_STATE    The task is not in termitated state
    @retval         #BCM_ERR_INVAL_PARAMS   The task id is invalid

    @limitations Should only be called from a privilaged execution mode

    @trace #BRCM_SWREQ_BASE
*/
int32_t BASE_ActivateTask(const BCM_TaskType aTaskID);

/**
    @brief Terminate the currently running task

    @behavior Sync, Non-reentrant

    @pre None

    Return values are documented in reverse-chronological order
    @retval         #BCM_ERR_OK             Task terminated
    @retval         #BCM_ERR_INVAL_STATE    The current task cannot be terminated
                                            in the current state

    @limitations Should only be called from a privilaged execution mode
    @todo Rework the conditions under which the #BCM_ERR_INVAL_STATE is returned

    @trace #BRCM_SWREQ_BASE
*/
int32_t BASE_TerminateTask(void);

/**
    @brief Initialize BASE and kickoff the first task

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aMode                   Reserved for future use

    Return values are documented in reverse-chronological order
    @retval         #BCM_ERR_OK             OS sucessfully inited

    @limitations Should only be called from a privilaged execution mode
        and at the system bootup time

    @trace #BRCM_SWREQ_BASE
*/
int32_t BASE_StartOS(const BCM_AppModeType aMode);

/**
    @brief Get events set against a given task ID

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aTaskId                 Task ID
    @param[inout]   aEventMask              Bitmask of events set against
                                            the task with ID aTaskId

    Return values are documented in reverse-chronological order
    @retval         #BCM_ERR_OK             Set events have been filled into aEventMask
    @retval         #BCM_ERR_INVAL_STATE    The task is in the terminated state
    @retval         #BCM_ERR_INVAL_PARAMS   Invalid aTaskID or aEventMask is NULL

    @limitations Should only be called from a privilaged execution mode

    @trace #BRCM_SWREQ_BASE
*/
int32_t BASE_GetEvent(const BCM_TaskType aTaskID, BCM_EventMaskType *const aEventMask);

/**
    @brief Set events set against a given task ID

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aTaskId                 Task ID
    @param[inout]   aEventMask              Bitmask of events to set against
                                            the task with ID aTaskId

    Return values are documented in reverse-chronological order
    @retval         #BCM_ERR_OK             Set event done
    @retval         #BCM_ERR_INVAL_STATE    The task is in terminated state
    @retval         #BCM_ERR_INVAL_PARAMS   Invalid aTaskID

    @limitations Should only be called from a privilaged execution mode

    @trace #BRCM_SWREQ_BASE
*/
int32_t BASE_SetEvent(const BCM_TaskType aTaskID, const BCM_EventMaskType aEventMask);

/**
    @brief Set events set against a given task ID

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aTaskId                 Task ID
    @param[inout]   aEventMask              Bitmask of events to set against
                                            the task with ID aTaskId

    Return values are documented in reverse-chronological order
    @retval         #BCM_ERR_OK             Set event done
    @retval         #BCM_ERR_INVAL_STATE    The task is in terminated state
    @retval         #BCM_ERR_INVAL_PARAMS   Invalid aTaskID

    @limitations Should only be called from a privilaged execution mode

    @trace #BRCM_SWREQ_BASE
*/
int32_t BASE_ClearEvent(const BCM_EventMaskType aEventMask);

/**
    @brief Suspend the current task until an event is set against it

    @behavior Sync, Non-reentrant

    @pre None

    @param[inout]   aEventMask              Bitmask of events. The current task will
                                            be un-suspended if atleast one event amongst
                                            the events indicated by this parameter is set

    Return values are documented in reverse-chronological order
    @retval         #BCM_ERR_OK             Task woken up after suspension.
    @retval         #BCM_ERR_INVAL_STATE    The task is in terminated state

    @limitations Should only be called from a privilaged execution mode

    @trace #BRCM_SWREQ_BASE
*/
int32_t BASE_WaitEvent(const BCM_EventMaskType aEventMask);

/**
    @brief Increment a counter

    This may internally trigger alarm callbacks registered against
    the counter being incremented

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aCounterID              ID of a counter to increment

    Return values are documented in reverse-chronological order
    @retval         #BCM_ERR_OK             Counter increment done
    @retval         #BCM_ERR_INVAL_PARAMS   Invalid aCounter

    @limitations Should only be called from a privilaged execution mode

    @trace #BRCM_SWREQ_BASE
*/
int32_t BASE_IncrementCounter(const uint32_t aCounterID);

/**
    @brief Activate an alarm

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aAlarmID                ID of the alarm to activate
    @param[in]      aIncrement              Counter increments after which a
                                            pre-registered callback is to be triggered
    @param[in]      aCycle                  If set to zero, the alarm is deactivated after
                                            the first callback is triggered. Else, the alarm
                                            callback is triggered periodically after aCycle
                                            counter increments

    Return values are documented in reverse-chronological order
    @retval         #BCM_ERR_OK             Alarm activated
    @retval         #BCM_ERR_INVAL_PARAMS   aAlarmID invalid,
                                            aIncrement is zero or too large,
                                            aCycle is too small or too large
                                            (but zero is allowed)

    @limitations Should only be called from a privilaged execution mode

    @trace #BRCM_SWREQ_BASE
*/
int32_t BASE_SetRelAlarm(const BCM_AlarmType aAlarmID, const BCM_TickType aIncrement, const BCM_TickType aCycle);

/**
    @brief Cancel an alarm

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aAlarmID                ID of the alarm to cancel

    Return values are documented in reverse-chronological order
    @retval         #BCM_ERR_OK             Alarm cancelled
    @retval         #BCM_ERR_INVAL_PARAMS   aAlarmID invalid

    @limitations Should only be called from a privilaged execution mode

    @trace #BRCM_SWREQ_BASE
*/
int32_t BASE_CancelAlarm(const BCM_AlarmType aAlarmID);

/** @brief Handover execution from ROM to bootloader or bootloader to firmware

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]   aEntryPt              Entry Point

    @return      void

    @post This function does not return

    @trace  #BRCM_SWREQ_BASE
*/
extern void BASE_ExecHandover(const BCM_EntryPtType aEntryPt);

#endif  /* BASE_KERNEL_SERVICES_H */
/** @} */
