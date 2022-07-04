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

#include <stdbool.h>
#include <stdlib.h>
#include <string.h>
#include <ee.h>
#include <bcm_utils.h>
#include <bcm_test.h>
#include <bcm_err.h>
#include <osil/bcm_osil.h>

#include <compiler.h>
#include "hsm_drv_sched_lib.h"

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

#define HSMDRVSCHEDQT_MAX_NUM_JOBS          (32UL)

typedef struct sHSMDRVSCHEDQT_JobDescType {
    bool hwError;
    uint32_t numStates;
    int32_t finalResult;
} HSMDRVSCHEDQT_JobDescType;

typedef struct sHSMDRVSCHEDQT_JobStateType {
    uint32_t descIdx;
    uint32_t state;
} HSMDRVSCHEDQT_JobStateType;

typedef struct sHSMDRVSCHEDQT_JobResolutionType {
    bool aborted;
    uint64_t jobHdl;
    uint32_t numStates;
    uint32_t finalResult;
} HSMDRVSCHEDQT_JobResolutionType;

typedef struct sHSMDRVSCHEDQT_JobStateNotificationType {
    uint32_t numTimesCalled;
    uint64_t jobHdl;
} HSMDRVSCHEDQT_JobStateNotificationType;

static const HSMDRVSCHEDQT_JobDescType HSMDRVSCHEDQT_JobDescs[HSMDRVSCHEDQT_MAX_NUM_JOBS] = {
   { .hwError = false, .finalResult = BCM_ERR_OK          , .numStates = 15UL, },
   { .hwError = false, .finalResult = BCM_ERR_OK          , .numStates = 5UL,  },
   { .hwError = false, .finalResult = BCM_ERR_OK          , .numStates = 7UL,  },
   { .hwError = false, .finalResult = BCM_ERR_OK          , .numStates = 1UL,  },
   { .hwError = true , .finalResult = BCM_ERR_INVAL_PARAMS, .numStates = 2UL,  },
   { .hwError = false, .finalResult = BCM_ERR_OK          , .numStates = 13UL, },
   { .hwError = false, .finalResult = BCM_ERR_OK          , .numStates = 9UL,  },
   { .hwError = false, .finalResult = BCM_ERR_INVAL_PARAMS, .numStates = 15UL, },
   { .hwError = true , .finalResult = BCM_ERR_INVAL_PARAMS, .numStates = 14UL, },
   { .hwError = false, .finalResult = BCM_ERR_INVAL_PARAMS, .numStates = 2UL,  },
   { .hwError = false, .finalResult = BCM_ERR_OK          , .numStates = 13UL, },
   { .hwError = false, .finalResult = BCM_ERR_AUTH_FAILED , .numStates = 5UL,  },
   { .hwError = false, .finalResult = BCM_ERR_OK          , .numStates = 13UL, },
   { .hwError = true , .finalResult = BCM_ERR_AUTH_FAILED , .numStates = 5UL,  },
   { .hwError = false, .finalResult = BCM_ERR_INVAL_PARAMS, .numStates = 14UL, },
   { .hwError = false, .finalResult = BCM_ERR_INVAL_STATE , .numStates = 9UL,  },
   { .hwError = false, .finalResult = BCM_ERR_INVAL_STATE , .numStates = 10UL, },
   { .hwError = false, .finalResult = BCM_ERR_INVAL_STATE , .numStates = 11UL, },
   { .hwError = false, .finalResult = BCM_ERR_INVAL_STATE , .numStates = 7UL,  },
   { .hwError = false, .finalResult = BCM_ERR_AUTH_FAILED , .numStates = 16UL, },
   { .hwError = false, .finalResult = BCM_ERR_OK          , .numStates = 4UL,  },
   { .hwError = false, .finalResult = BCM_ERR_OK          , .numStates = 6UL,  },
   { .hwError = false, .finalResult = BCM_ERR_INVAL_STATE , .numStates = 5UL,  },
   { .hwError = false, .finalResult = BCM_ERR_INVAL_PARAMS, .numStates = 3UL,  },
   { .hwError = true , .finalResult = BCM_ERR_AUTH_FAILED , .numStates = 15UL, },
   { .hwError = false, .finalResult = BCM_ERR_INVAL_PARAMS, .numStates = 8UL,  },
   { .hwError = false, .finalResult = BCM_ERR_INVAL_PARAMS, .numStates = 3UL,  },
   { .hwError = false, .finalResult = BCM_ERR_INVAL_STATE , .numStates = 8UL,  },
   { .hwError = false, .finalResult = BCM_ERR_INVAL_STATE , .numStates = 11UL, },
   { .hwError = true , .finalResult = BCM_ERR_INVAL_PARAMS, .numStates = 8UL,  },
   { .hwError = false, .finalResult = BCM_ERR_AUTH_FAILED , .numStates = 7UL,  },
   { .hwError = false, .finalResult = BCM_ERR_AUTH_FAILED , .numStates = 6UL,  },
};

static int32_t failLine;
static int32_t hsm_drv_sched_qt_result1 = BCM_AT_NOT_STARTED;

static bool hsm_drv_sched_qt_simulate_hw_error;

static uint32_t HSMDRVSCHEDQT_GetHwStatusCtr;
static uint32_t HSMDRVSCHEDQT_EnqueueJobCtr;

static HSMDRVSCHED_JobQueueType HSMDRVSCHEDQT_JobQueue;
static HSMDRVSCHEDQT_JobStateNotificationType HSMDRVSCHEDQT_StartNofifications[HSMDRVSCHEDQT_MAX_NUM_JOBS];
static HSMDRVSCHEDQT_JobStateNotificationType HSMDRVSCHEDQT_CompleteNofifications[HSMDRVSCHEDQT_MAX_NUM_JOBS];
static HSMDRVSCHEDQT_JobResolutionType HSMDRVSCHEDQT_JobResolutions[HSMDRVSCHEDQT_MAX_NUM_JOBS];

static void HSMDRVSCHEDQT_ResetGlobals(void)
{
    HSMDRVSCHEDQT_GetHwStatusCtr = 1UL;
    HSMDRVSCHEDQT_EnqueueJobCtr = 0UL;
}

static int32_t HSMDRVSCHEDQT_AdvanceJob(HSMDRVSCHED_JobStateType *const aJobState)
{
    int32_t ret;
    HSMDRVSCHEDQT_JobStateType *const jobState = (HSMDRVSCHEDQT_JobStateType*)(aJobState);
    const uint32_t jobDescIdx = jobState->descIdx;

    if (jobState->state == HSMDRVSCHEDQT_JobDescs[jobDescIdx].numStates) {
        HSMDRVSCHEDQT_JobResolutions[jobDescIdx].numStates = jobState->state;
        ret = HSMDRVSCHEDQT_JobDescs[jobDescIdx].finalResult;
    } else if (jobState->state == (HSMDRVSCHEDQT_JobDescs[jobDescIdx].numStates - 1UL)) {
        ret = BCM_ERR_BUSY;
        jobState->state++;
        hsm_drv_sched_qt_simulate_hw_error = HSMDRVSCHEDQT_JobDescs[jobDescIdx].hwError;
    } else {
        ret = BCM_ERR_BUSY;
        jobState->state++;
    }

    return ret;
}

static int32_t HSMDRVSCHEDQT_AbortJob(const int32_t aHwStatus, HSMDRVSCHED_JobStateType *const aJobState)
{
    HSMDRVSCHEDQT_JobStateType *const jobState = (HSMDRVSCHEDQT_JobStateType*)(aJobState);
    const uint32_t jobDescIdx = jobState->descIdx;

    hsm_drv_sched_qt_simulate_hw_error = false;

    HSMDRVSCHEDQT_JobResolutions[jobDescIdx].aborted = true;
    HSMDRVSCHEDQT_JobResolutions[jobDescIdx].numStates = jobState->state;

    return HSMDRVSCHEDQT_JobDescs[jobDescIdx].finalResult;
}

static void HSMDRVSCHEDQT_NotifyStart(const uint64_t aJobHdl, const uint64_t aTaskId)
{
    if (aTaskId < HSMDRVSCHEDQT_MAX_NUM_JOBS) {
        HSMDRVSCHEDQT_StartNofifications[aTaskId].numTimesCalled++;
        HSMDRVSCHEDQT_StartNofifications[aTaskId].jobHdl = aJobHdl;
    }
    return;
}

static void HSMDRVSCHEDQT_NotifyComplete(const uint64_t aJobHdl, const uint64_t aTaskId)
{
    if (aTaskId < HSMDRVSCHEDQT_MAX_NUM_JOBS) {
        HSMDRVSCHEDQT_CompleteNofifications[aTaskId].numTimesCalled++;
        HSMDRVSCHEDQT_CompleteNofifications[aTaskId].jobHdl = aJobHdl;
    }
    return;
}

static int32_t HSMDRVSCHEDQT_GetHwStatus(void)
{
    int32_t ret;

    if (HSMDRVSCHEDQT_GetHwStatusCtr < 5UL) {
        /*
            Simulate the case where the scheduler calls this function but
            the HW is still processing the previous job.
        */
        HSMDRVSCHEDQT_GetHwStatusCtr++;
        ret = BCM_ERR_BUSY;
    } else {
        HSMDRVSCHEDQT_GetHwStatusCtr = 1UL;

        if (true == hsm_drv_sched_qt_simulate_hw_error) {
            /* HW error simulation. Scheduler should call the cancel function */
            ret = BCM_ERR_INVAL_STATE;
        } else {
            /* HW sucessfully processed the job. Scheduler should call the advance function */
            ret = BCM_ERR_OK;
        }
    }

    return ret;
}

static HSMDRVSCHED_DriverCallbacksType HSMDRVSCHEDQT_DriverCallbacks = {
    .jobAbortFn = HSMDRVSCHEDQT_AbortJob,
    .jobAdvanceFn = HSMDRVSCHEDQT_AdvanceJob,
    .getHwStatusFn = HSMDRVSCHEDQT_GetHwStatus,
    .jobStartFn = HSMDRVSCHEDQT_NotifyStart,
    .jobCompleteFn = HSMDRVSCHEDQT_NotifyComplete,
};

static int32_t HSMDRVSCHEDQT_EnqueueAndDiscardTests(HSMDRVSCHED_JobQueueType *const aJobQueue)
{
    int32_t ret;
    uint64_t jobHdl = 0UL;
    HSMDRVSCHED_JobStateType *jobState = NULL;

    failLine = 0;

    /* HSMDRVSCHED_GetJobStateInstance with inval params */
    CHECKED_FUNC_CALL_EXPECT_ERR(BCM_ERR_INVAL_PARAMS, HSMDRVSCHED_GetJobStateInstance, NULL, &jobState);
    CHECKED_FUNC_CALL_EXPECT_ERR(BCM_ERR_INVAL_PARAMS, HSMDRVSCHED_GetJobStateInstance, aJobQueue, NULL);

    /* Get a job state instance */
    CHECKED_FUNC_CALL(HSMDRVSCHED_GetJobStateInstance, aJobQueue, &jobState);

    /* Enqueue with inval params */
    CHECKED_FUNC_CALL_EXPECT_ERR(BCM_ERR_INVAL_PARAMS, HSMDRVSCHED_EnqueueJob, aJobQueue, 0UL, NULL, jobState, &jobHdl);
    CHECKED_FUNC_CALL_EXPECT_ERR(BCM_ERR_INVAL_PARAMS, HSMDRVSCHED_EnqueueJob, aJobQueue, 0UL, &HSMDRVSCHEDQT_DriverCallbacks, NULL, &jobHdl);
    CHECKED_FUNC_CALL_EXPECT_ERR(BCM_ERR_INVAL_PARAMS, HSMDRVSCHED_EnqueueJob, aJobQueue, 0UL, &HSMDRVSCHEDQT_DriverCallbacks, jobState, NULL);

    /* Enqueue with inalid jobState pointer */
    CHECKED_FUNC_CALL_EXPECT_ERR(BCM_ERR_INVAL_PARAMS, HSMDRVSCHED_EnqueueJob, aJobQueue, 0UL, &HSMDRVSCHEDQT_DriverCallbacks, aJobQueue->jobStates - 1UL, &jobHdl);
    CHECKED_FUNC_CALL_EXPECT_ERR(BCM_ERR_INVAL_PARAMS, HSMDRVSCHED_EnqueueJob, aJobQueue, 0UL, &HSMDRVSCHEDQT_DriverCallbacks, aJobQueue->jobStates + HSMDRVSCHED_JOB_QUEUE_SIZE, &jobHdl);
    CHECKED_FUNC_CALL_EXPECT_ERR(BCM_ERR_INVAL_PARAMS, HSMDRVSCHED_EnqueueJob, aJobQueue, 0UL, &HSMDRVSCHEDQT_DriverCallbacks,
        (HSMDRVSCHED_JobStateType *)(void*)((((char*)(void*)jobState)) + 1UL),
        &jobHdl);

    /* Discard with invalid parama */
    CHECKED_FUNC_CALL_EXPECT_ERR(BCM_ERR_INVAL_PARAMS, HSMDRVSCHED_DiscardJobStateInstance, NULL, jobState)
    CHECKED_FUNC_CALL_EXPECT_ERR(BCM_ERR_INVAL_PARAMS, HSMDRVSCHED_DiscardJobStateInstance, aJobQueue, NULL)
    CHECKED_FUNC_CALL_EXPECT_ERR(BCM_ERR_INVAL_PARAMS, HSMDRVSCHED_DiscardJobStateInstance, aJobQueue,
        (HSMDRVSCHED_JobStateType *)(void*)((((char*)(void*)jobState)) + 1UL)
    )

    /* Finally, discard the job instance */
    CHECKED_FUNC_CALL(HSMDRVSCHED_DiscardJobStateInstance, aJobQueue, jobState)

exit:
    if (0 != failLine) {
        ret = BCM_ERR_INVAL_STATE;
    } else {
        ret = BCM_ERR_OK;
    }

    return ret;
}

static int32_t HSMDRVSCHEDQT_EnqueueJob(HSMDRVSCHED_JobQueueType *const aJobQueue, uint64_t *const aJobHdl)
{
    int32_t ret;
    HSMDRVSCHED_JobStateType *jobState = NULL;

    failLine = 0;

    ret = HSMDRVSCHED_GetJobStateInstance(aJobQueue, &jobState);
    if (BCM_ERR_OK == ret) {
        HSMDRVSCHEDQT_JobStateType *qtJobState = (HSMDRVSCHEDQT_JobStateType*)jobState;
        qtJobState->descIdx = HSMDRVSCHEDQT_EnqueueJobCtr;
        qtJobState->state = 0UL;

        ret = HSMDRVSCHED_EnqueueJob(aJobQueue, HSMDRVSCHEDQT_EnqueueJobCtr, &HSMDRVSCHEDQT_DriverCallbacks, jobState, aJobHdl);
        if (BCM_ERR_OK == ret) {
            HSMDRVSCHEDQT_EnqueueJobCtr++;
        }
    }

    return ret;
}

static int32_t HSMDRVSCHEDQT_DriveSched(HSMDRVSCHED_JobQueueType *const aJobQueue, const uint32_t aBeginIdx, const uint32_t aEndIdx)
{
    int32_t ret;
    uint32_t i;
    uint32_t idx = aBeginIdx;

    failLine = 0;

    /* Check the status of all the enqueue'd jobs */
    for (i = aBeginIdx; i <= aEndIdx; i++) {
        int32_t status = BCM_ERR_OK;
        const uint64_t jobHdl = HSMDRVSCHEDQT_JobResolutions[i].jobHdl;

        CHECKED_FUNC_CALL(HSMDRVSCHED_JobQueueGetStatus, aJobQueue, i, jobHdl, &status);
        CHECK_COND(BCM_ERR_BUSY == status)
    }

    /* Keep nudging the scheduler until all the jobs are resolved */
    while (idx <= aEndIdx) {
        int32_t finalResult = BCM_ERR_BUSY;
        HSMDRVSCHED_DriverCallbacksType callbacks;
        const uint64_t jobHdl = HSMDRVSCHEDQT_JobResolutions[idx].jobHdl;

        /* Nudge with invalid params */
        CHECKED_FUNC_CALL_EXPECT_ERR(BCM_ERR_INVAL_PARAMS, HSMDRVSCHED_SchedNudge, &HSMDRVSCHEDQT_JobQueue, NULL);
        CHECKED_FUNC_CALL_EXPECT_ERR(BCM_ERR_INVAL_PARAMS, HSMDRVSCHED_SchedNudge, NULL, &HSMDRVSCHEDQT_DriverCallbacks);

        #define HSMDRVSCHEDQT_NUDGE_WITH_INVAL_FNPTR(fnPtrName) \
            callbacks = HSMDRVSCHEDQT_DriverCallbacks;          \
            callbacks.fnPtrName = NULL;                         \
            CHECKED_FUNC_CALL_EXPECT_ERR(                       \
                BCM_ERR_INVAL_PARAMS, HSMDRVSCHED_SchedNudge,   \
                &HSMDRVSCHEDQT_JobQueue, &callbacks);

        HSMDRVSCHEDQT_NUDGE_WITH_INVAL_FNPTR(jobAbortFn)
        HSMDRVSCHEDQT_NUDGE_WITH_INVAL_FNPTR(jobAdvanceFn)
        HSMDRVSCHEDQT_NUDGE_WITH_INVAL_FNPTR(getHwStatusFn)
        HSMDRVSCHEDQT_NUDGE_WITH_INVAL_FNPTR(jobStartFn)
        HSMDRVSCHEDQT_NUDGE_WITH_INVAL_FNPTR(jobCompleteFn)

        /* Really nudge */
        CHECKED_FUNC_CALL(HSMDRVSCHED_SchedNudge, aJobQueue, &HSMDRVSCHEDQT_DriverCallbacks);

        /* Call HSMDRVSCHED_JobQueueGetStatus with inval args */
        CHECKED_FUNC_CALL_EXPECT_ERR(BCM_ERR_INVAL_PARAMS, HSMDRVSCHED_JobQueueGetStatus, NULL, idx, jobHdl, &finalResult)
        CHECKED_FUNC_CALL_EXPECT_ERR(BCM_ERR_INVAL_PARAMS, HSMDRVSCHED_JobQueueGetStatus, aJobQueue, idx - 1UL, jobHdl, &finalResult)
        CHECKED_FUNC_CALL_EXPECT_ERR(BCM_ERR_INVAL_PARAMS, HSMDRVSCHED_JobQueueGetStatus, aJobQueue, idx, jobHdl, NULL)

        CHECKED_FUNC_CALL_EXPECT_ERR(BCM_ERR_INVAL_PARAMS, HSMDRVSCHED_JobQueueGetStatus,
            aJobQueue, idx, (jobHdl ^ 0x00000000FFFFFFFFULL), &finalResult)
        CHECKED_FUNC_CALL_EXPECT_ERR(BCM_ERR_INVAL_PARAMS, HSMDRVSCHED_JobQueueGetStatus,
            aJobQueue, idx, (jobHdl ^ 0x0000FFFF00000000ULL), &finalResult)
        CHECKED_FUNC_CALL_EXPECT_ERR(BCM_ERR_INVAL_PARAMS, HSMDRVSCHED_JobQueueGetStatus,
            aJobQueue, idx, (jobHdl ^ 0xFFFF000000000000ULL), &finalResult)

        /* Real job queue get status */
        CHECKED_FUNC_CALL(HSMDRVSCHED_JobQueueGetStatus, aJobQueue, idx, jobHdl, &finalResult);
        if (BCM_ERR_BUSY != finalResult) {
            HSMDRVSCHEDQT_JobResolutions[idx].finalResult = finalResult;
            idx++;
        }
    }

exit:
    if (0 != failLine) {
        ret = BCM_ERR_INVAL_STATE;
    } else {
        ret = BCM_ERR_OK;
    }

    return ret;
}

static int32_t HSMDRVSCHEDQT_RunJobStateTransitionTests(void)
{
    _Static_assert((sizeof(HSMDRVSCHEDQT_JobDescs) / sizeof(HSMDRVSCHEDQT_JobDescType)) >= HSMDRVSCHED_JOB_QUEUE_SIZE,
        "We expect to run atleast HSMDRVSCHED_JOB_QUEUE_SIZE number of test cases!");

    _Static_assert((sizeof(HSMDRVSCHEDQT_JobDescs) / sizeof(HSMDRVSCHEDQT_JobDescType)) <= HSMDRVSCHEDQT_MAX_NUM_JOBS,
        "We do not expect to see more than HSMDRVSCHEDQT_MAX_NUM_JOBS number of test cases!");

    int32_t ret;
    uint32_t idx;
    const uint16_t clientMagic = 0xA10CU;
    const uint32_t numJobs = sizeof(HSMDRVSCHEDQT_JobDescs) / sizeof(HSMDRVSCHEDQT_JobDescType);

    failLine = 0;

    /* Initialize the data structures */
    hsm_drv_sched_qt_simulate_hw_error = false;
    (void) memset(HSMDRVSCHEDQT_StartNofifications, 0x00, HSMDRVSCHEDQT_MAX_NUM_JOBS * sizeof(HSMDRVSCHEDQT_JobStateNotificationType));
    (void) memset(HSMDRVSCHEDQT_CompleteNofifications, 0x00, HSMDRVSCHEDQT_MAX_NUM_JOBS * sizeof(HSMDRVSCHEDQT_JobStateNotificationType));
    (void) memset(HSMDRVSCHEDQT_JobResolutions, 0x00, HSMDRVSCHEDQT_MAX_NUM_JOBS * sizeof(HSMDRVSCHEDQT_JobResolutionType));

    /* Init with inval params and then really init the queue */
    CHECKED_FUNC_CALL_EXPECT_ERR(BCM_ERR_INVAL_PARAMS, HSMDRVSCHED_InitJobQueue, NULL, clientMagic);
    CHECKED_FUNC_CALL(HSMDRVSCHED_InitJobQueue, &HSMDRVSCHEDQT_JobQueue, clientMagic);
    HSMDRVSCHEDQT_ResetGlobals();

    /* Run some enqueue and discard tests */
    CHECKED_FUNC_CALL(HSMDRVSCHEDQT_EnqueueAndDiscardTests, &HSMDRVSCHEDQT_JobQueue);

    /* These enqueues should go through */
    for (idx = 0UL; idx < HSMDRVSCHED_JOB_QUEUE_SIZE; idx++) {
        CHECKED_FUNC_CALL(HSMDRVSCHEDQT_EnqueueJob, &HSMDRVSCHEDQT_JobQueue, &HSMDRVSCHEDQT_JobResolutions[idx].jobHdl);
    }

    /* This enqueue command should fail */
    CHECKED_FUNC_CALL_EXPECT_ERR(BCM_ERR_NOMEM, HSMDRVSCHEDQT_EnqueueJob, &HSMDRVSCHEDQT_JobQueue, &HSMDRVSCHEDQT_JobResolutions[idx].jobHdl);

    /* Drive all the submitted jobs to completion */
    CHECKED_FUNC_CALL(HSMDRVSCHEDQT_DriveSched, &HSMDRVSCHEDQT_JobQueue, 0, HSMDRVSCHED_JOB_QUEUE_SIZE - 1UL);

    /* Queue the rest and drive them to completion */
    for (idx = HSMDRVSCHED_JOB_QUEUE_SIZE; idx < numJobs; idx++) {
        /* Enqueue job */
        CHECKED_FUNC_CALL(HSMDRVSCHEDQT_EnqueueJob, &HSMDRVSCHEDQT_JobQueue, &HSMDRVSCHEDQT_JobResolutions[idx].jobHdl);

        /* Attempt queue deinit. This should fail */
        CHECKED_FUNC_CALL_EXPECT_ERR(BCM_ERR_BUSY, HSMDRVSCHED_DeinitJobQueue, &HSMDRVSCHEDQT_JobQueue);

        /* Drive the job to completion */
        CHECKED_FUNC_CALL(HSMDRVSCHEDQT_DriveSched, &HSMDRVSCHEDQT_JobQueue, idx, idx);
    }

    /* Verify the results */
    for (idx = 0UL; idx < numJobs; idx++) {
        const HSMDRVSCHEDQT_JobDescType *const jobDesc = &HSMDRVSCHEDQT_JobDescs[idx];
        const HSMDRVSCHEDQT_JobResolutionType *const jobResolution = &HSMDRVSCHEDQT_JobResolutions[idx];

        CHECK_COND(jobDesc->hwError == jobResolution->aborted);
        CHECK_COND(jobDesc->numStates == jobResolution->numStates);
        CHECK_COND(jobDesc->finalResult == jobResolution->finalResult);
        CHECK_COND(1UL == HSMDRVSCHEDQT_StartNofifications[idx].numTimesCalled);
        CHECK_COND(1UL == HSMDRVSCHEDQT_CompleteNofifications[idx].numTimesCalled);
        CHECK_COND(jobResolution->jobHdl == HSMDRVSCHEDQT_StartNofifications[idx].jobHdl);
        CHECK_COND(jobResolution->jobHdl == HSMDRVSCHEDQT_CompleteNofifications[idx].jobHdl);
    }

    /* Deinit the queue */
    CHECKED_FUNC_CALL_EXPECT_ERR(BCM_ERR_INVAL_PARAMS, HSMDRVSCHED_DeinitJobQueue, NULL);
    CHECKED_FUNC_CALL(HSMDRVSCHED_DeinitJobQueue, &HSMDRVSCHEDQT_JobQueue);

exit:
    if (0 != failLine) {
        ret = BCM_ERR_INVAL_STATE;
    } else {
        ret = BCM_ERR_OK;
    }

    return ret;
}

TASK(HsmDrvSchedQT)
{
    int32_t ret;
    int32_t failLine = 0UL;

    /*
        Run state transition tests twice to make sure that the deinit was clean
        the first time around
    */
    CHECKED_FUNC_CALL(HSMDRVSCHEDQT_RunJobStateTransitionTests);
    CHECKED_FUNC_CALL(HSMDRVSCHEDQT_RunJobStateTransitionTests);

exit:
    (void) failLine;
    hsm_drv_sched_qt_result1 = ret;
    BCM_TerminateTask();
}

int32_t BCM_ExecuteAT(uint32_t aIndex)
{
    int32_t ret = BCM_AT_NOT_AVAILABLE;

    if ((1UL == aIndex) && (BCM_AT_EXECUTING != hsm_drv_sched_qt_result1)) {
        hsm_drv_sched_qt_result1 = BCM_AT_EXECUTING;
        BCM_ActivateTask(HsmDrvSchedQT);
        ret = BCM_ERR_OK;
    }

    return ret;
}

int32_t BCM_GetResultAT(uint32_t aIndex)
{
    int32_t ret;

    if (1UL == aIndex) {
        ret = hsm_drv_sched_qt_result1;
    } else {
        ret = BCM_AT_NOT_AVAILABLE;
    }

    return ret;
}

void APP_Init()
{
    return;
}

