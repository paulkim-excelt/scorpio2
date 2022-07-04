/*****************************************************************************
 Copyright 2019-2022 Broadcom Limited.  All rights reserved.

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

#include "pka_lib.h"
#include "secutils.h"

#if defined(PKA_FEATURE_FLAG_ECDSA_SIGN) || defined(PKA_FEATURE_FLAG_ECDHE)
#include <secure_heap.h>
#endif

#include "g_pka_qt_test_data.h"

#if defined(PKAQT_RUN_TARGETED_TESTS)
#include "pka_qt_targeted_test_data.h"
#endif

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

#define PKA_MAX_NUM_INFLIGHT_JOBS   (15UL)

#define PKAQT_MODULE_INIT_COUNT     (1UL)

const MODULE_Type* const PKAQT_Modules[PKAQT_MODULE_INIT_COUNT] = {
    &TIME_Module,
};

typedef struct sPkaQtEcdsaSignJobScratchType {
    uint32_t secheapHdl;
} PkaQtEcdsaSignJobScratchType;

typedef struct sPkaQtEcdheJobScratchType {
    uint32_t privKeyHdl;
    uint32_t sharedSecretHdl;
} PkaQtEcdheJobScratchType;

typedef union uPkaQtJobScratchType {
    PkaQtEcdsaSignJobScratchType ecdsaSignJobScratchSpace;
    PkaQtEcdheJobScratchType ecdheJobScratchSpace;
} PkaQtJobScratchType;

int32_t failLine;
int32_t pka_qt_result1 = BCM_AT_NOT_STARTED;

#if defined(PKA_FEATURE_FLAG_ECDSA_SIGN) || defined(PKA_FEATURE_FLAG_ECDHE)
static uint32_t PKA_QT_SCRATCH_SPACE[64UL];
static SECUTILS_BigUintType scratchBigInts[4UL];
#endif

#if defined(PKAQT_RUN_TARGETED_TESTS)
static PkaQtJobScratchType targetedJobScratchSpace;
#endif
static PkaQtJobScratchType perfJobScratchSpace;
static PkaQtJobScratchType funcJobScratchSpaceArray[PKA_FUNC_TESTCASES_NUM_ELTS];
static BCM_TimeType profTestTimes[PKA_PROF_TESTCASES_NUM_ELTS];

static int32_t PKA_IssueJob(const PkaTestCaseType *const aTestCase, uint64_t *const aJobId, PkaQtJobScratchType *const aJobScratchSpace)
{
    int32_t ret;

    switch (aTestCase->tag) {
#if defined(PKA_FEATURE_FLAG_RSA_OPS)
        case PKA_TEST_CASE_RSA_VERIFY: {
            const PkaRsaVerifyTestCaseType *rsaVerifyTestCase = &aTestCase->rsaVerify;
            ret = PKA_RsaVerify(
                rsaVerifyTestCase->sigScheme,
                &rsaVerifyTestCase->rsaModulus,
                &rsaVerifyTestCase->rsaExponent,
                &rsaVerifyTestCase->signature,
                rsaVerifyTestCase->msgDigestAlg,
                &rsaVerifyTestCase->msgHash,
                aJobId);
            } break;
#endif
#if defined(PKA_FEATURE_FLAG_ECDSA_SIGN)
        case PKA_TEST_CASE_ECDSA_SIGN: {
            const PkaEcdsaSignTestCaseType *ecdsaSignTestCase = &aTestCase->ecdsaSign;

            ret = SECHEAP_Create(ecdsaSignTestCase->privKey.numLimbs * 4UL, 0UL,
                (uint8_t*)ecdsaSignTestCase->privKey.limbs,
                &aJobScratchSpace->ecdsaSignJobScratchSpace.secheapHdl
                );

            scratchBigInts[0].numLimbs = ecdsaSignTestCase->signatureR.numLimbs;
            scratchBigInts[0].limbs = PKA_QT_SCRATCH_SPACE;

            scratchBigInts[1].numLimbs = ecdsaSignTestCase->signatureS.numLimbs;
            scratchBigInts[1].limbs = PKA_QT_SCRATCH_SPACE + ecdsaSignTestCase->signatureR.numLimbs;

            if (BCM_ERR_OK == ret) {
                ret = PKA_EcdsaSign(
                    ecdsaSignTestCase->ecGroup,
                    aJobScratchSpace->ecdsaSignJobScratchSpace.secheapHdl,
                    &ecdsaSignTestCase->randNonce,
                    &ecdsaSignTestCase->msgHash,
                    &scratchBigInts[0],
                    &scratchBigInts[1],
                    aJobId);
            }

            } break;
#endif
#if defined(PKA_FEATURE_FLAG_ECDSA_VERIFY)
        case PKA_TEST_CASE_ECDSA_VERIFY: {
            const PkaEcdsaVerifyTestCaseType *ecdsaVerifyTestCase = &aTestCase->ecdsaVerify;
            ret = PKA_EcdsaVerify(
                ecdsaVerifyTestCase->ecGroup,
                &ecdsaVerifyTestCase->pubKeyX,
                &ecdsaVerifyTestCase->pubKeyY,
                &ecdsaVerifyTestCase->msgHash,
                &ecdsaVerifyTestCase->signatureR,
                &ecdsaVerifyTestCase->signatureS,
                aJobId);
            } break;
#endif
#if defined(PKA_FEATURE_FLAG_ECDHE)
        case PKA_TEST_CASE_ECDHE: {
            const PkaEcdheTestCaseType *ecdheTestCase = &aTestCase->ecdhe;

            ret = SECHEAP_Create(
                ecdheTestCase->privKey.numLimbs * 4UL, 0UL,
                (uint8_t*)ecdheTestCase->privKey.limbs,
                &aJobScratchSpace->ecdheJobScratchSpace.privKeyHdl
            );

            scratchBigInts[0].numLimbs = ecdheTestCase->localPubKeyX.numLimbs;
            scratchBigInts[0].limbs = PKA_QT_SCRATCH_SPACE;

            scratchBigInts[1].numLimbs = ecdheTestCase->localPubKeyY.numLimbs;
            scratchBigInts[1].limbs = PKA_QT_SCRATCH_SPACE + scratchBigInts[0].numLimbs;

            if (BCM_ERR_OK == ret) {
                ret = PKA_Ecdhe(PKA_ECGROUP_SECP_256R1,
                    aJobScratchSpace->ecdheJobScratchSpace.privKeyHdl,
                    &ecdheTestCase->remotePubKeyX,
                    &ecdheTestCase->remotePubKeyY,
                    &scratchBigInts[0],
                    &scratchBigInts[1],
                    &aJobScratchSpace->ecdheJobScratchSpace.sharedSecretHdl,
                    aJobId
                );
            }
        } break;
        case PKA_TEST_CASE_ECDH: {
            const PkaEcdhTestCaseType *ecdhTestCase = &aTestCase->ecdh;

            ret = SECHEAP_Create(
                ecdhTestCase->privKey.numLimbs * 4UL, 0UL,
                (uint8_t*)ecdhTestCase->privKey.limbs,
                &aJobScratchSpace->ecdheJobScratchSpace.privKeyHdl
            );

            if (BCM_ERR_OK == ret) {
                ret = PKA_Ecdhe(PKA_ECGROUP_SECP_256R1,
                    aJobScratchSpace->ecdheJobScratchSpace.privKeyHdl,
                    &ecdhTestCase->remotePubKeyX,
                    &ecdhTestCase->remotePubKeyY,
                    NULL,
                    NULL,
                    &aJobScratchSpace->ecdheJobScratchSpace.sharedSecretHdl,
                    aJobId
                );
            }
        } break;
#endif
        default:
            ret = BCM_ERR_NOSUPPORT;
            break;
    }

    return ret;
}

static int32_t PKA_JobPostOps(const PkaTestCaseType *const aTestCase, PkaQtJobScratchType *const aJobScratchSpace)
{
    int32_t ret;

    switch (aTestCase->tag) {
#if defined(PKA_FEATURE_FLAG_ECDSA_SIGN)
        case PKA_TEST_CASE_ECDSA_SIGN: {
            int32_t retVal1, retVal2;

            if (BCM_ERR_OK == aTestCase->expectedRet) {
                const PkaEcdsaSignTestCaseType *ecdsaSignTestCase = &aTestCase->ecdsaSign;
                retVal1 = memcmp(
                    PKA_QT_SCRATCH_SPACE,
                    ecdsaSignTestCase->signatureR.limbs,
                    ecdsaSignTestCase->signatureR.numLimbs * 4UL);
                retVal2 = memcmp(
                    PKA_QT_SCRATCH_SPACE + ecdsaSignTestCase->signatureR.numLimbs,
                    ecdsaSignTestCase->signatureS.limbs,
                    ecdsaSignTestCase->signatureS.numLimbs * 4UL);
            } else {
                retVal1 = BCM_ERR_OK;
                retVal2 = BCM_ERR_OK;
            }

            const int32_t retVal3 = SECHEAP_Free(aJobScratchSpace->ecdsaSignJobScratchSpace.secheapHdl);

            if ((0UL == retVal1) && (0UL == retVal2) && (BCM_ERR_OK == retVal3)) {
                ret = BCM_ERR_OK;
            } else {
                ret = BCM_ERR_INVAL_STATE;
            }

        } break;
#endif
#if defined(PKA_FEATURE_FLAG_ECDHE)
        case PKA_TEST_CASE_ECDHE: {
            int32_t retVal1, retVal2, retVal3;
            const PkaEcdheTestCaseType *ecdheTestCase = &aTestCase->ecdhe;

            if (BCM_ERR_OK == aTestCase->expectedRet) {
                retVal1 = memcmp(
                    PKA_QT_SCRATCH_SPACE,
                    ecdheTestCase->localPubKeyX.limbs,
                    ecdheTestCase->localPubKeyX.numLimbs * 4UL);
                retVal2 = memcmp(
                    PKA_QT_SCRATCH_SPACE + ecdheTestCase->localPubKeyX.numLimbs,
                    ecdheTestCase->localPubKeyY.limbs,
                    ecdheTestCase->localPubKeyY.numLimbs * 4UL);
                retVal3 = SECHEAP_Memcmp(
                    aJobScratchSpace->ecdheJobScratchSpace.sharedSecretHdl,
                    (const uint8_t*)ecdheTestCase->sharedSecret, 32UL);
            } else {
                retVal1 = 0UL;
                retVal2 = 0UL;
                retVal3 = 0UL;
            }

            (void) SECHEAP_Free(aJobScratchSpace->ecdheJobScratchSpace.privKeyHdl);
            (void) SECHEAP_Free(aJobScratchSpace->ecdheJobScratchSpace.sharedSecretHdl);

            if ((0UL == retVal1) && (0UL == retVal2) && (0UL == retVal3)) {
                ret = BCM_ERR_OK;
            } else {
                ret = BCM_ERR_INVAL_STATE;
            }

        } break;
        case PKA_TEST_CASE_ECDH: {
            int32_t retVal;
            const PkaEcdhTestCaseType *ecdhTestCase = &aTestCase->ecdh;

            if (BCM_ERR_OK == aTestCase->expectedRet) {
                retVal = SECHEAP_Memcmp(
                    aJobScratchSpace->ecdheJobScratchSpace.sharedSecretHdl,
                    (const uint8_t*)ecdhTestCase->sharedSecret, 32UL);
            } else {
                retVal = 0UL;
            }

            (void) SECHEAP_Free(aJobScratchSpace->ecdheJobScratchSpace.privKeyHdl);
            (void) SECHEAP_Free(aJobScratchSpace->ecdheJobScratchSpace.sharedSecretHdl);

            if (0UL == retVal) {
                ret = BCM_ERR_OK;
            } else {
                ret = BCM_ERR_INVAL_STATE;
            }

        } break;
#endif
        default:
            ret = BCM_ERR_OK;
            break;
    }

    return ret;
}

static int32_t PKA_RunFuncTests()
{
    #define PKA_WAIT_COMPLETE(jobId)                            \
        do {                                                    \
            retVal = PKA_GetAlgExecResult(jobId, &ret);         \
            CHECK_COND(BCM_ERR_OK == retVal);                   \
        } while (BCM_ERR_BUSY == ret);

    _Static_assert(PKA_FUNC_TESTCASES_NUM_ELTS > PKA_MAX_NUM_INFLIGHT_JOBS + 2UL,
        "Not enough functional test cases!");

    int32_t i;
    int32_t ret;
    int32_t retVal = 0;
    uint64_t jobIds[PKA_MAX_NUM_INFLIGHT_JOBS + 1UL];

    failLine = 0UL;

    /* Submit jobs that just about fill up the job queue */
    for (i = 0UL; i < PKA_MAX_NUM_INFLIGHT_JOBS; i++) {
        CHECKED_FUNC_CALL(PKA_IssueJob, &PKA_FUNC_TESTCASES[i], &jobIds[i], &funcJobScratchSpaceArray[i]);
    }

    /* This submission should fail */
    CHECKED_FUNC_CALL_EXPECT_ERR(BCM_ERR_NOMEM, PKA_IssueJob,
        &PKA_FUNC_TESTCASES[PKA_MAX_NUM_INFLIGHT_JOBS], &jobIds[PKA_MAX_NUM_INFLIGHT_JOBS],
        &funcJobScratchSpaceArray[PKA_MAX_NUM_INFLIGHT_JOBS]
        );

    /* Check the status of the first job */
    i = 0UL;
    PKA_WAIT_COMPLETE(jobIds[0]);
    CHECK_COND(PKA_FUNC_TESTCASES[0UL].expectedRet == ret);
    CHECKED_FUNC_CALL(PKA_JobPostOps, &PKA_FUNC_TESTCASES[0UL], &funcJobScratchSpaceArray[0UL]);

    /* This submission should go through */
    i = PKA_MAX_NUM_INFLIGHT_JOBS;
    CHECKED_FUNC_CALL(PKA_IssueJob, &PKA_FUNC_TESTCASES[PKA_MAX_NUM_INFLIGHT_JOBS],
        &jobIds[PKA_MAX_NUM_INFLIGHT_JOBS],
        &funcJobScratchSpaceArray[PKA_MAX_NUM_INFLIGHT_JOBS]
    );

    /* Check the results of all the jobs submitted thus far */
    for (i = 1UL; i <= PKA_MAX_NUM_INFLIGHT_JOBS; i++) {
        PKA_WAIT_COMPLETE(jobIds[i]);
        CHECK_COND(PKA_FUNC_TESTCASES[i].expectedRet == ret);
        CHECKED_FUNC_CALL(PKA_JobPostOps, &PKA_FUNC_TESTCASES[i], &funcJobScratchSpaceArray[i]);
    }

    /* For the rest of the jobs, submit one job at a time and verify the results */
    BCM_ClearEvent(PKAEvent);
    for (i = PKA_MAX_NUM_INFLIGHT_JOBS + 1UL; i < PKA_FUNC_TESTCASES_NUM_ELTS; i++) {
        uint64_t jobId = 0ULL;
        const PkaTestCaseType *const testCase = &PKA_FUNC_TESTCASES[i];

        CHECKED_FUNC_CALL(PKA_IssueJob, testCase, &jobId, &funcJobScratchSpaceArray[i])

        BCM_WaitEvent(PKAEvent);
        BCM_ClearEvent(PKAEvent);

        CHECKED_FUNC_CALL(PKA_GetAlgExecResult, jobId, &retVal);
        CHECK_COND(testCase->expectedRet == retVal);
        CHECKED_FUNC_CALL(PKA_JobPostOps, testCase, &funcJobScratchSpaceArray[i]);
    }

exit:
    if (0 != failLine) {
        ret = BCM_ERR_INVAL_STATE;
    } else {
        ret = BCM_ERR_OK;
    }

    return ret;

    #undef PKA_WAIT_COMPLETE
}

static int32_t PKA_RunProfTests(void)
{
    int32_t i;
    int32_t ret = BCM_ERR_OK;

    failLine = 0UL;
    BCM_ClearEvent(PKAEvent);

    for (i = 0UL; i < PKA_PROF_TESTCASES_NUM_ELTS; i++) {
        uint64_t jobId = 0ULL;
        int32_t retVal = BCM_ERR_OK;
        BCM_TimeType beginTime = {};
        BCM_TimeType endTime = {};
        BCM_TimeType elapsedTime = {};

        BCM_GetTime(&beginTime);

        CHECKED_FUNC_CALL(PKA_IssueJob, &PKA_PROF_TESTCASES[i], &jobId, &perfJobScratchSpace);
        BCM_WaitEvent(PKAEvent);
        BCM_ClearEvent(PKAEvent);

        BCM_GetTime(&endTime);
        elapsedTime = BCM_GetTimeAbsDiff(endTime, beginTime);

        CHECKED_FUNC_CALL(PKA_GetAlgExecResult, jobId, &retVal);
        CHECK_COND(PKA_PROF_TESTCASES[i].expectedRet == retVal);
        CHECKED_FUNC_CALL(PKA_JobPostOps, &PKA_PROF_TESTCASES[i], &perfJobScratchSpace);

        profTestTimes[i] = elapsedTime;
    }

exit:
    if (0 != failLine) {
        ret = BCM_ERR_INVAL_STATE;
    } else {
        ret = BCM_ERR_OK;
    }

    return ret;
}

#if defined(PKAQT_RUN_TARGETED_TESTS)
COMP_NEVER_INLINE int32_t PKA_RunTargetedTests(void)
{
    int32_t ret;
    uint32_t i;

    failLine = 0UL;

    for (i = 0UL; i < PKA_TARGETED_TESTCASES_NUM_ELTS; i++) {
        uint64_t jobId = 0ULL;
        int32_t retVal = BCM_ERR_OK;
        const PkaTestCaseType *const testCase = &PKA_TARGETED_TESTCASES[i];

        CHECKED_FUNC_CALL(PKA_IssueJob, testCase, &jobId, &targetedJobScratchSpace)

        BCM_WaitEvent(PKAEvent);
        BCM_ClearEvent(PKAEvent);

        CHECKED_FUNC_CALL(PKA_GetAlgExecResult, jobId, &retVal);
        CHECK_COND(testCase->expectedRet == retVal);
        CHECKED_FUNC_CALL(PKA_JobPostOps, testCase, &targetedJobScratchSpace);
    }

exit:
    if (0 != failLine) {
        ret = BCM_ERR_INVAL_STATE;
    } else {
        ret = BCM_ERR_OK;
    }

    return ret;
}
#endif

static int32_t PKA_SystemInit(void)
{
    int32_t ret;

    failLine = 0UL;

    CHECKED_FUNC_CALL(MODULE_ResetStateHandler, PKAQT_Modules, PKAQT_MODULE_INIT_COUNT);
    PKA_Init();

exit:
    if (0 != failLine) {
        ret = BCM_ERR_INVAL_STATE;
    } else {
        ret = BCM_ERR_OK;
    }

    return ret;
}

static int32_t PKA_SystemDeInit(void)
{
    int32_t ret;

    failLine = 0UL;

    CHECKED_FUNC_CALL(PKA_Deinit);

exit:
    if (0 != failLine) {
        ret = BCM_ERR_INVAL_STATE;
    } else {
        ret = BCM_ERR_OK;
    }

    return ret;
}

TASK(PkaQT)
{
    int32_t ret;
    int32_t failLine = 0;

    CHECKED_FUNC_CALL(PKA_SystemInit);
    CHECKED_FUNC_CALL(PKA_RunFuncTests);
    CHECKED_FUNC_CALL(PKA_RunProfTests);

#if defined(PKAQT_RUN_TARGETED_TESTS)
    CHECKED_FUNC_CALL(PKA_RunTargetedTests);
#endif

    CHECKED_FUNC_CALL(PKA_SystemDeInit);

exit:
    (void) failLine;
    pka_qt_result1 = ret;
    BCM_TerminateTask();
}

int32_t BCM_ExecuteAT(uint32_t aIndex)
{
    int32_t ret = BCM_AT_NOT_AVAILABLE;

    if ((1UL == aIndex) && (BCM_AT_EXECUTING != pka_qt_result1)) {
        pka_qt_result1 = BCM_AT_EXECUTING;
        BCM_ActivateTask(PkaQT);
        ret = BCM_ERR_OK;
    }

    return ret;
}

int32_t BCM_GetResultAT(uint32_t aIndex)
{
    int32_t ret = BCM_AT_NOT_AVAILABLE;

    if (1UL == aIndex) {
        ret = pka_qt_result1;
    }

    return ret;
}

