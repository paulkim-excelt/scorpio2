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
    @defgroup grp_hsm_drv_sched_ifc Interface
    @ingroup grp_hsm_drv_sched

    @addtogroup grp_hsm_drv_sched_ifc

    @{
    HSM drv job scheduler interfaces

    @file hsm_drv_sched_lib.h
    @brief HSM drv job scheduler interfaces
    This header contains structure definitions and function declarations
    for the HSM drv job scheduler library
    @version 0.1 Initial Version
*/

#ifndef HSM_DRV_SCHED_LIB_H
#define HSM_DRV_SCHED_LIB_H

/**
    @name HSM drv job scheduler interface Architecture IDs
    @{
    @brief Architecture IDs for the HSM drv job scheduler
*/
#define BRCM_SWARCH_HSMDRVSCHED_JOB_STATE_SIZE_MACRO              (0x8101U)    /**< @brief #HSMDRVSCHED_JOB_STATE_SIZE           */
#define BRCM_SWARCH_HSMDRVSCHED_JOB_QUEUE_SIZE_MACRO              (0x8102U)    /**< @brief #HSMDRVSCHED_JOB_QUEUE_SIZE           */
#define BRCM_SWARCH_HSMDRVSCHED_JOB_STATE_TYPE                    (0x8103U)    /**< @brief #HSMDRVSCHED_JobStateType             */
#define BRCM_SWARCH_HSMDRVSCHED_JOB_SCHED_STATE_TYPE              (0x8104U)    /**< @brief #HSMDRVSCHED_JobSchedStateType        */
#define BRCM_SWARCH_HSMDRVSCHED_JOB_QUEUE_TYPE                    (0x8105U)    /**< @brief #HSMDRVSCHED_JobQueueType             */
#define BRCM_SWARCH_HSMDRVSCHED_JOB_ABORT_FNPTR_TYPE              (0x8106U)    /**< @brief #HSMDRVSCHED_JobAbortFnPtrType        */
#define BRCM_SWARCH_HSMDRVSCHED_JOB_ADVANCE_FNPTR_TYPE            (0x8107U)    /**< @brief #HSMDRVSCHED_JobAdvanceFnPtrType      */
#define BRCM_SWARCH_HSMDRVSCHED_GET_HWSTATUS_FNPTR_TYPE           (0x8108U)    /**< @brief #HSMDRVSCHED_GetHwStatusFnPtrType     */
#define BRCM_SWARCH_HSMDRVSCHED_NOTIFY_JOB_START_FNPTR_TYPE       (0x8109U)    /**< @brief #HSMDRVSCHED_NotifyJobStartFnPtrType  */
#define BRCM_SWARCH_HSMDRVSCHED_NOTIFY_JOB_COMPLETE_FNPTR_TYPE    (0x810AU)    /**< @brief #HSMDRVSCHED_NotifyJobCompleFnPtrType */
#define BRCM_SWARCH_HSMDRVSCHED_DRIVER_CALLBACKS_TYPE             (0x810BU)    /**< @brief #HSMDRVSCHED_DriverCallbacksType      */
#define BRCM_SWARCH_HSMDRVSCHED_INIT_JOB_QUEUE_PROC               (0x810CU)    /**< @brief #HSMDRVSCHED_InitJobQueue             */
#define BRCM_SWARCH_HSMDRVSCHED_DEINIT_JOB_QUEUE_PROC             (0x810DU)    /**< @brief #HSMDRVSCHED_DeinitJobQueue           */
#define BRCM_SWARCH_HSMDRVSCHED_GET_JOBSTATE_INSTANCE_PROC        (0x810EU)    /**< @brief #HSMDRVSCHED_GetJobStateInstance      */
#define BRCM_SWARCH_HSMDRVSCHED_DISCARD_JOBSTATE_INSTANCE_PROC    (0x810FU)    /**< @brief #HSMDRVSCHED_DiscardJobStateInstance  */
#define BRCM_SWARCH_HSMDRVSCHED_ENQUEUE_JOB_PROC                  (0x8110U)    /**< @brief #HSMDRVSCHED_EnqueueJob               */
#define BRCM_SWARCH_HSMDRVSCHED_SCHED_NUDGE_PROC                  (0x8111U)    /**< @brief #HSMDRVSCHED_SchedNudge               */
#define BRCM_SWARCH_HSMDRVSCHED_JOB_QUEUE_GET_STATUS_PROC         (0x8112U)    /**< @brief #HSMDRVSCHED_JobQueueGetStatus        */
/** @} */

#include <stdint.h>
#include <stddef.h>
#include <stdalign.h>

#include <lw_queue.h>

/**
    @brief Job state state storage size

    @trace #BRCM_SWREQ_HSMDRVSCHED_LIBRARY
 */
#define HSMDRVSCHED_JOB_STATE_SIZE              (64UL)

/**
    @brief Job state state storage size

    @trace #BRCM_SWREQ_HSMDRVSCHED_LIBRARY
 */
#define HSMDRVSCHED_JOB_QUEUE_SIZE              (LWQ_BUFFER_MAX_LENGTH)

/**
    @brief Opaque job state

    The client driver is free to use this piece of memory as it sees fit.
    Typically, this is used to cache the job execution state.

    @trace #BRCM_SWREQ_HSMDRVSCHED_LIBRARY
 */
typedef struct sHSMDRVSCHED_JobStateType {
    alignas(max_align_t) uint8_t jobStateData[HSMDRVSCHED_JOB_STATE_SIZE];  /**< @brief Job state storage space   */
} HSMDRVSCHED_JobStateType;

/**
    @{
    @brief Data structure to maintain the job's sched state

    @trace #BRCM_SWREQ_HSMDRVSCHED_LIBRARY
 */
typedef struct sHSMDRVSCHED_JobSchedStateType {
    uint32_t state;                 /**< @brief Job sched state                                             */
    uint64_t taskId;                /**< @brief Task Id                                                     */
    uint32_t jobSubmitId;           /**< @brief Snapshot of @ref jobSubmitCounter when job was submitted    */
    int32_t jobExecResult;          /**< @brief Job execution result to be returned to the client           */
} HSMDRVSCHED_JobSchedStateType;
#define HSMDRVSCHED_JOB_SCHED_STATE_FREE        (0UL)
#define HSMDRVSCHED_JOB_SCHED_STATE_ALLOC       (1UL)
#define HSMDRVSCHED_JOB_SCHED_STATE_ENQUEUED    (2UL)
#define HSMDRVSCHED_JOB_SCHED_STATE_STARTED     (3UL)
#define HSMDRVSCHED_JOB_SCHED_STATE_DONE        (4UL)
/** @} */

/**
    @brief The job queue

    Client drivers are expected to own one or more instances
    of this data structure, but should not directly manipulate
    them. The API's in this header should be used instead.

    @trace #BRCM_SWREQ_HSMDRVSCHED_LIBRARY
 */
typedef struct sHSMDRVSCHED_JobQueueType {
    uint16_t clientMagic;                                                       /**< @brief Client driver magic                                 */
    uint32_t jobSubmitCounter;                                                  /**< @brief Counter that is incremented on every job submission */
    LWQ_BufferType jobFreeQueue;                                                /**< @brief Jobs on the free queue                              */
    LWQ_BufferType jobSubmitQueue;                                              /**< @brief Jobs on the submit queue                            */
    HSMDRVSCHED_JobStateType jobStates[HSMDRVSCHED_JOB_QUEUE_SIZE];             /**< @brief Array of job states                                 */
    HSMDRVSCHED_JobSchedStateType jobSchedStates[HSMDRVSCHED_JOB_QUEUE_SIZE];   /**< @brief Array of job states corresponding to the jobs       */
} HSMDRVSCHED_JobQueueType;

/** @brief Abort the job execution

    A function implementing this interface is supplied by the client
    driver in an @ref HSMDRVSCHED_DriverCallbacksType instance.

    The scheduler invokes this supplied function when an invocation to the
    client driver supplied @ref HSMDRVSCHED_GetHwStatusFnPtrType invocation results
    in any error other than #BCM_ERR_OK or #BCM_ERR_BUSY.
    See @ref HSMDRVSCHED_GetHwStatusFnPtrType for furthur details. Inside this call,
    the client driver is expected to abort the job execution and free any resources
    it is holding on to.

    Upon returning from this function, the scheduler marks the corresponding
    job as complete, and the error returned by this function is ultimately
    returned to the client of this library when @ref HSMDRVSCHED_JobQueueGetStatus
    is called.

    @behavior Sync, Non-reentrant

    @param[in]      aHwStatus           The result of the invocation of the supplied
                                        @ref HSMDRVSCHED_GetHwStatusFnPtrType function
    @param[inout]   aJobState           The job state

    Return values are documented in reverse-chronological order
    @retval         All                 All the error codes except #BCM_ERR_BUSY are allowed.
                                        The error is specific to the job being run.

    @post None

    @trace #BRCM_SWREQ_HSMDRVSCHED_LIBRARY
*/
typedef int32_t (*HSMDRVSCHED_JobAbortFnPtrType)(const int32_t aHwStatus, HSMDRVSCHED_JobStateType *const aJobState);

/** @brief Advance the job execution

    A function implementing this interface is supplied by the client
    driver in an @ref HSMDRVSCHED_DriverCallbacksType instance.

    To execute a given job, several HW invocations might be necessary.
    The design of this interface facilitates this.

    The scheduler starts a new job with an invocation of this supplied function.
    The client driver is then expected to perform any HW operations it needs,
    update the job state reflecting the progress made, and return #BCM_ERR_BUSY
    indicating that the HW is now executing the issued work.

    When the HW finishes the execution of the work submitted above, the client
    driver should call @ref HSMDRVSCHED_SchedNext (perhaps from an ISR). The scheduler
    then invokes this routine again.

    At this point, the client driver may perform any furthur HW operations and
    return #BCM_ERR_BUSY. In this case, the client driver is again expected to
    call @ref HSMDRVSCHED_SchedNext once the submitted work finishes executing
    on the HW and the cycle repeats. Or, the client driver return any other error
    code - which tells the scheduler that the job may be marked as completed, and
    the error returned here is ultimately returned to the client of this library when
    @ref HSMDRVSCHED_JobQueueGetStatus is called. The client driver is expected to
    perform any necessary cleanup before returning to the scheduler in the second
    case.

    @behavior Sync, Non-reentrant

    @param[inout]   aJobState           The job state

    Return values are documented in reverse-chronological order
    @retval         #BCM_ERR_BUSY       Work has been submitted to the HW. Job is in progress
    @retval         Others              Signals the scheduler that the job execution completed
                                        with the error returned

    @post None

    @trace #BRCM_SWREQ_HSMDRVSCHED_LIBRARY
*/
typedef int32_t (*HSMDRVSCHED_JobAdvanceFnPtrType)(HSMDRVSCHED_JobStateType *const aJobState);

/** @brief Get HW status

    A function implementing this interface is supplied by the client
    driver in an @ref HSMDRVSCHED_DriverCallbacksType instance.

    Upon invocation by this library, this function call should return the
    HW status. The interpretation of the return codes is explained in the
    return values section.

    Also refer to the documentation of @ref HSMDRVSCHED_SchedNext.

    @behavior Sync, Non-reentrant

    Return values are documented in reverse-chronological order
    @retval         #BCM_ERR_BUSY       HW is still executing the previosly submitted work.
    @retval         #BCM_ERR_OK         HW is idle and is ready to accept more work
    @retval         Others              Execution of the work previosly sumbitted resulted in
                                        a HW error. Job execution is cancelled by the scheduler
                                        in this case
    @post None

    @trace #BRCM_SWREQ_HSMDRVSCHED_LIBRARY
*/
typedef int32_t (*HSMDRVSCHED_GetHwStatusFnPtrType)(void);

/** @brief Notify job start

    A function implementing this interface is supplied by the client
    driver in an @ref HSMDRVSCHED_DriverCallbacksType instance.

    This function is invoked by this library just before the job
    is scheduled to run.

    @behavior Sync, Non-reentrant

    @param[in]      aJobHdl             ID of the job being scheduled to run
    @param[in]      aTaskId             ID of the task that submitted this job

    @return void

    @post None

    @trace #BRCM_SWREQ_HSMDRVSCHED_LIBRARY
*/
typedef void (*HSMDRVSCHED_NotifyJobStartFnPtrType)(const uint64_t aJobHdl, const uint64_t aTaskId);

/** @brief Notify job complete

    A function implementing this interface is supplied by the client
    driver in an @ref HSMDRVSCHED_DriverCallbacksType instance.

    This function is invoked by this library when a job execution completes.
    The clients may then perform any OS related work during this
    function call.

    @behavior Sync, Non-reentrant

    @param[in]      aJobHdl             ID of the job whose execution has finished
    @param[in]      aTaskId             ID of the task that submitted this job

    @return void

    @post None

    @trace #BRCM_SWREQ_HSMDRVSCHED_LIBRARY
*/
typedef void (*HSMDRVSCHED_NotifyJobCompleFnPtrType)(const uint64_t aJobHdl, const uint64_t aTaskId);

/**
    @brief Driver callbacks

    Drivers using this library are expected to pass an instance of
    this type when calling various functions supplied by this library

    @trace #BRCM_SWREQ_HSMDRVSCHED_LIBRARY
 */
typedef struct sHSMDRVSCHED_DriverCallbacksType {
    HSMDRVSCHED_JobAbortFnPtrType jobAbortFn;               /**< @brief Job abort function pointer                      */
    HSMDRVSCHED_JobAdvanceFnPtrType jobAdvanceFn;           /**< @brief Job advance function pointer                    */
    HSMDRVSCHED_GetHwStatusFnPtrType getHwStatusFn;         /**< @brief Get HW status function pointer                  */
    HSMDRVSCHED_NotifyJobStartFnPtrType jobStartFn;         /**< @brief Job start notification callback function        */
    HSMDRVSCHED_NotifyJobCompleFnPtrType jobCompleteFn;     /**< @brief Job completion notification callback function   */
} HSMDRVSCHED_DriverCallbacksType;

/** @brief Initialize the job queue

    @behavior Sync, Non-reentrant

    @param[in]      aJobQueue               Job queue to be initialized
    @param[in]      aClientMagic            Client driver magic

    Return values are documented in reverse-chronological order
    @retval         #BCM_ERR_INVAL_PARAMS   aJobQueue is null
    @retval         #BCM_ERR_OK             On successful initialization

    @post None

    @trace #BRCM_SWREQ_HSMDRVSCHED_LIBRARY
*/
int32_t HSMDRVSCHED_InitJobQueue(HSMDRVSCHED_JobQueueType *const aJobQueue, const uint16_t aClientMagic);

/** @brief Deinit the job queue

    @behavior Sync, Non-reentrant

    @param[in]      aJobQueue               Job queue to deinit

    Return values are documented in reverse-chronological order
    @retval         #BCM_ERR_INVAL_PARAMS   aJobQueue is null
    @retval         #BCM_ERR_BUSY           aJobQueue has jobs in-flight
    @retval         #BCM_ERR_OK             On successful deinit

    @post None

    @trace #BRCM_SWREQ_HSMDRVSCHED_LIBRARY
*/
int32_t HSMDRVSCHED_DeinitJobQueue(HSMDRVSCHED_JobQueueType *const aJobQueue);

/** @brief Get an instance of @ref HSMDRVSCHED_JobStateType

    @behavior Sync, Non-reentrant

    @param[in]      aJobQueue               Job queue
    @param[inout]   aJobState               A free @ref HSMDRVSCHED_JobStateType instance to be
                                            populated

    Return values are documented in reverse-chronological order
    @retval         #BCM_ERR_INVAL_PARAMS   aJobQueue is null or aJobState is NULL
    @retval         #BCM_ERR_NOMEM          No free instances available
    @retval         #BCM_ERR_OK             aJob parameter is populated and points to
                                            a free @ref HSMDRVSCHED_JobStateType instance
    @post None

    @trace #BRCM_SWREQ_HSMDRVSCHED_LIBRARY
*/
int32_t HSMDRVSCHED_GetJobStateInstance(HSMDRVSCHED_JobQueueType *const aJobQueue, HSMDRVSCHED_JobStateType **aJobState);

/** @brief Discard an instance of @ref HSMDRVSCHED_JobStateType

    @behavior Sync, Non-reentrant

    @param[in]      aJobQueue               Job queue
    @param[inout]   aJob                    A free @ref HSMDRVSCHED_JobStateType instance obtained by
                                            a call to @ref HSMDRVSCHED_GetJob

    Return values are documented in reverse-chronological order
    @retval         #BCM_ERR_INVAL_PARAMS   aJobQueue is null, aJob is NULL or an invalid pointer
    @retval         #BCM_ERR_OK             On success

    @post None

    @trace #BRCM_SWREQ_HSMDRVSCHED_LIBRARY
*/
int32_t HSMDRVSCHED_DiscardJobStateInstance(HSMDRVSCHED_JobQueueType *const aJobQueue, const HSMDRVSCHED_JobStateType *const aJobState);

/** @brief Enqueue a job

    @behavior Sync, Non-reentrant

    @param[in]      aJobQueue               Job queue
    @param[in]      aReqTaskId              ID of the task that is submitting this job
    @param[in]      aDriverCallbacks        Driver callbacks
    @param[in]      aJobState               A @ref HSMDRVSCHED_JobStateType instance that was obtained by
                                            a call to @ref HSMDRVSCHED_GetJobState and has been filled up
                                            appropriately
    @param[out]     aJobHdl                 Handle to the submitted job

    Return values are documented in reverse-chronological order
    @retval         #BCM_ERR_INVAL_PARAMS   aJobQueue is NULL, aDriverCallbacks is NULL or is in invalid
                                            state, aJobState invalid, aJobHdl NULL
    @retval         #BCM_ERR_OK             On success

    @post None

    @trace #BRCM_SWREQ_HSMDRVSCHED_LIBRARY
*/
int32_t HSMDRVSCHED_EnqueueJob(HSMDRVSCHED_JobQueueType *const aJobQueue, const uint64_t aReqTaskId, const HSMDRVSCHED_DriverCallbacksType *const aDriverCallbacks, const HSMDRVSCHED_JobStateType *const aJobState, uint64_t *aJobHdl);

/**
    @brief Nudge the scheduler

    Advances or cancels the current job and schedules the next job
    if the current job execution is done.

    @behavior Sync, Non-Reentrant

    @pre None

    @param[in]      aJobQueue                   Job queue
    @param[in]      aDriverCallbacks            Driver callbacks

    Return values are documented in reverse-chronological order
    @retval         #BCM_ERR_INVAL_PARAMS       aJobQueue is NULL, aDriverCallbacks is NULL or is
                                                in invalid state
    @retval         #BCM_ERR_OK                 Success


    @post If the jobHdl passed in was valid, and the corresponding job execution finished, this jobHdl
            is invalidated.

    @trace #BRCM_SWREQ_HSMDRVSCHED_LIBRARY
*/
int32_t HSMDRVSCHED_SchedNudge(HSMDRVSCHED_JobQueueType *const aJobQueue, const HSMDRVSCHED_DriverCallbacksType *const aDriverCallbacks);

/**
    @brief Get status of the submitted job

    @behavior Sync, Non-Reentrant

    @pre None

    @param[in]      aJobQueue                   Job queue
    @param[in]      aReqTaskId                  ID of the task that is submitting this job
    @param[in]      aJobHdl                     Handle to the submitted job whose status is
                                                being queried
    @param[inout]   aJobExecResult              Result of the job execution

    Return values are documented in reverse-chronological order
    @retval         #BCM_ERR_OK                 Success
    @retval         #BCM_ERR_INVAL_PARAMS       aJobQueue is NULL, aJobExecResult is NULL, aJobHdl invalid,
                                                aReqTaskId does not match the task ID with which the job was
                                                submitted

    @post If the jobHdl passed in was valid, and the corresponding job execution finished, this jobHdl
            is invalidated.

    @trace #BRCM_SWREQ_HSMDRVSCHED_LIBRARY
*/
int32_t HSMDRVSCHED_JobQueueGetStatus(HSMDRVSCHED_JobQueueType *const aJobQueue, const uint64_t aReqTaskId, const uint64_t aJobHdl, int32_t *aJobExecResult);

#endif /* HSM_DRV_SCHED_LIB_H */
/** @} */
