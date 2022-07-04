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
#include <bcm_test.h>
#include <bcm_err.h>
#include <bcm_time.h>
#include <osil/bcm_osil.h>
#include <module.h>
#include <module_helper.h>
#include <osil/time_module_osil.h>

#include <secure_heap.h>
#include "spum_lib.h"
#include "g_spum_qt_test_data_openssl.h"

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

#define SPUM_MODULE_INIT_COUNT     (1UL)
const MODULE_Type* const SPUM_Modules[SPUM_MODULE_INIT_COUNT] = {
    &TIME_Module,
};

typedef struct sSPUM_ProfTestResultsType {
    const char *testName;
    uint64_t val;
} SPUM_ProfTestResultsType;

int32_t failLine;
uint32_t numProfTestsExecuted = 0UL;
static int32_t spum_qt_result1 = BCM_AT_NOT_STARTED;

#define SPUM_MAX_NUM_PROF_TESTS             (64UL)
SPUM_ProfTestResultsType SPUM_PROF_TEST_RESULTS[SPUM_MAX_NUM_PROF_TESTS];

#define PROF_TEST_RECORD_RES(name, profRes)                             \
    if (numProfTestsExecuted < SPUM_MAX_NUM_PROF_TESTS) {               \
        const uint32_t i = numProfTestsExecuted;                        \
        SPUM_PROF_TEST_RESULTS[i].testName = (name);                    \
        SPUM_PROF_TEST_RESULTS[i].val = (profRes);                      \
        numProfTestsExecuted++;                                         \
    }

static uint8_t SPUM_AUTH_OUT0[64UL];
static uint8_t SPUM_AUTH_OUT1[64UL];
static uint8_t SPUM_CRYPT_OUT0[4096U] COMP_SECTION("secureheap.SPUM_CRYPT_OUT0");
static uint8_t SPUM_CRYPT_OUT1[4096U] COMP_SECTION("secureheap.SPUM_CRYPT_OUT1");
static uint8_t SPUM_CRYPT_OUT2[4096U] COMP_SECTION("secureheap.SPUM_CRYPT_OUT2");
static uint8_t SPUM_CRYPT_OUT3[4096U] COMP_SECTION("secureheap.SPUM_CRYPT_OUT3");

static uint32_t failIdx;
static int32_t failRet;

COMP_NEVER_INLINE int32_t SPUM_TestAesCbc(void)
{
    int32_t i;
    int32_t ret;
    uint32_t key128Hdl = 0UL;
    uint32_t key256Hdl = 0UL;
    SPUM_ContextHandleType aes128CbcEncryptCtx = 0ULL;
    SPUM_ContextHandleType aes128CbcDecryptCtx = 0ULL;
    SPUM_ContextHandleType aes256CbcEncryptCtx = 0ULL;
    SPUM_ContextHandleType aes256CbcDecryptCtx = 0ULL;

    /* Initialize keys */
    CHECKED_FUNC_CALL(SECHEAP_Create, SPUM_AES_KEY_128_NUM_BYTES, 0UL, SPUM_AES_KEY_128, &key128Hdl)
    CHECKED_FUNC_CALL(SECHEAP_Create, SPUM_AES_KEY_256_NUM_BYTES, 0UL, SPUM_AES_KEY_256, &key256Hdl)

    /* Initialize contexts */
    const SPUM_CryptOpsType aes128CbcEncryptOps = {
        .cryptOp = SPUM_CRYPT_OP_ENCRYPT,
        .cryptAlg = SPUM_CIPHER_ALG_AES128,
        .cipherMode = SPUM_CIPHER_MODE_CBC,
        .keySecheapHdl = key128Hdl,
        .iv = SPUM_AES_IV,
    };

    const SPUM_CryptOpsType aes128CbcDecryptOps = {
        .cryptOp = SPUM_CRYPT_OP_DECRYPT,
        .cryptAlg = SPUM_CIPHER_ALG_AES128,
        .cipherMode = SPUM_CIPHER_MODE_CBC,
        .keySecheapHdl = key128Hdl,
        .iv = SPUM_AES_IV,
    };

    const SPUM_CryptOpsType aes256CbcEncryptOps = {
        .cryptOp = SPUM_CRYPT_OP_ENCRYPT,
        .cryptAlg = SPUM_CIPHER_ALG_AES256,
        .cipherMode = SPUM_CIPHER_MODE_CBC,
        .keySecheapHdl = key256Hdl,
        .iv = SPUM_AES_IV,
    };

    const SPUM_CryptOpsType aes256CbcDecryptOps = {
        .cryptOp = SPUM_CRYPT_OP_DECRYPT,
        .cryptAlg = SPUM_CIPHER_ALG_AES256,
        .cipherMode = SPUM_CIPHER_MODE_CBC,
        .keySecheapHdl = key256Hdl,
        .iv = SPUM_AES_IV,
    };

    CHECKED_FUNC_CALL(SPUM_CreateContext, &aes128CbcEncryptOps, NULL, SPUM_CRYPT_AUTH_ORDER_NONE, 0UL, NULL, &aes128CbcEncryptCtx)
    CHECKED_FUNC_CALL(SPUM_CreateContext, &aes128CbcDecryptOps, NULL, SPUM_CRYPT_AUTH_ORDER_NONE, 0UL, NULL, &aes128CbcDecryptCtx)
    CHECKED_FUNC_CALL(SPUM_CreateContext, &aes256CbcEncryptOps, NULL, SPUM_CRYPT_AUTH_ORDER_NONE, 0UL, NULL, &aes256CbcEncryptCtx)
    CHECKED_FUNC_CALL(SPUM_CreateContext, &aes256CbcDecryptOps, NULL, SPUM_CRYPT_AUTH_ORDER_NONE, 0UL, NULL, &aes256CbcDecryptCtx)

    BCM_ClearEvent(SPUMEvent);

    for (i = 0; i < 4; i++) {
        const uint32_t offset = (uint32_t)(1024 * i);
        bool jobResolved[4UL] = {false, false, false, false};
        SPUM_JobIdType spumJobIds[4UL] = {0ULL, 0ULL, 0ULL, 0ULL};
        int32_t (*fnPtr)(const SPUM_ContextHandleType aCtxHdl, const uint32_t aDataInSizeInOctets, const uint8_t *aDataIn, uint8_t *aCryptOut, SPUM_JobIdType *aJobId);
        fnPtr = ((3 == i) ? SPUM_Finish : SPUM_Update);

        CHECKED_FUNC_CALL(fnPtr, aes128CbcEncryptCtx, 1024UL, SPUM_PLAIN_TEXT + offset, SPUM_CRYPT_OUT0 + offset, &spumJobIds[0])
        CHECKED_FUNC_CALL(fnPtr, aes128CbcDecryptCtx, 1024UL, SPUM_CIPHER_TEXT_AES_128_CBC + offset, SPUM_CRYPT_OUT1 + offset, &spumJobIds[1])
        CHECKED_FUNC_CALL(fnPtr, aes256CbcEncryptCtx, 1024UL, SPUM_PLAIN_TEXT + offset, SPUM_CRYPT_OUT2 + offset, &spumJobIds[2])
        CHECKED_FUNC_CALL(fnPtr, aes256CbcDecryptCtx, 1024UL, SPUM_CIPHER_TEXT_AES_256_CBC + offset, SPUM_CRYPT_OUT3 + offset, &spumJobIds[3])

        while (true) {
            uint32_t j;
            BCM_WaitEvent(SPUMEvent);
            BCM_ClearEvent(SPUMEvent);

            for (j = 0UL; j < 4UL; j++) {
                if (false == jobResolved[j]) {
                    int32_t algExecResult = BCM_ERR_BUSY;
                    CHECKED_FUNC_CALL(SPUM_GetJobExecResult, spumJobIds[j], &algExecResult)
                    if (BCM_ERR_BUSY == algExecResult) {
                        break;
                    } else {
                        failIdx = j;
                        failRet = algExecResult;
                        CHECK_COND(BCM_ERR_OK == algExecResult)
                        jobResolved[j] = true;
                    }
                }
            }

            if (4UL == j) {
                break;
            }
        }
    }

    /* Compare results */
    CHECKED_FUNC_CALL(memcmp, SPUM_CRYPT_OUT0, SPUM_CIPHER_TEXT_AES_128_CBC, 4096UL);
    CHECKED_FUNC_CALL(memcmp, SPUM_CRYPT_OUT1, SPUM_PLAIN_TEXT, 4096UL);
    CHECKED_FUNC_CALL(memcmp, SPUM_CRYPT_OUT2, SPUM_CIPHER_TEXT_AES_256_CBC, 4096UL);
    CHECKED_FUNC_CALL(memcmp, SPUM_CRYPT_OUT3, SPUM_PLAIN_TEXT, 4096UL);

    /* Free up handles */
    CHECKED_FUNC_CALL(SECHEAP_Free, key128Hdl)
    CHECKED_FUNC_CALL(SECHEAP_Free, key256Hdl)

exit:
    if (0UL != failLine) {
        ret = BCM_ERR_INVAL_STATE;
    } else {
        ret = BCM_ERR_OK;
    }

    return ret;
}

static int32_t SPUM_TestAesCbcOneShotAndProf(void)
{
    int32_t ret;
    int32_t jobExecResult;
    uint32_t key128Hdl = 0UL;
    uint32_t key256Hdl = 0UL;
    BCM_TimeType beginTime = {};
    BCM_TimeType endTime = {};
    BCM_TimeType elapsedTime = {};
    SPUM_JobIdType jobId = 0ULL;
    SPUM_ContextHandleType aes128CbcEncryptCtx = 0ULL;
    SPUM_ContextHandleType aes128CbcDecryptCtx = 0ULL;
    SPUM_ContextHandleType aes256CbcEncryptCtx = 0ULL;
    SPUM_ContextHandleType aes256CbcDecryptCtx = 0ULL;

    /* Initialize keys */
    CHECKED_FUNC_CALL(SECHEAP_Create, SPUM_AES_KEY_128_NUM_BYTES, 0UL, SPUM_AES_KEY_128, &key128Hdl)
    CHECKED_FUNC_CALL(SECHEAP_Create, SPUM_AES_KEY_256_NUM_BYTES, 0UL, SPUM_AES_KEY_256, &key256Hdl)

    /* Initialize contexts */
    const SPUM_CryptOpsType aes128CbcEncryptOps = {
        .cryptOp = SPUM_CRYPT_OP_ENCRYPT,
        .cryptAlg = SPUM_CIPHER_ALG_AES128,
        .cipherMode = SPUM_CIPHER_MODE_CBC,
        .keySecheapHdl = key128Hdl,
        .iv = SPUM_AES_IV,
    };

    const SPUM_CryptOpsType aes128CbcDecryptOps = {
        .cryptOp = SPUM_CRYPT_OP_DECRYPT,
        .cryptAlg = SPUM_CIPHER_ALG_AES128,
        .cipherMode = SPUM_CIPHER_MODE_CBC,
        .keySecheapHdl = key128Hdl,
        .iv = SPUM_AES_IV,
    };

    const SPUM_CryptOpsType aes256CbcEncryptOps = {
        .cryptOp = SPUM_CRYPT_OP_ENCRYPT,
        .cryptAlg = SPUM_CIPHER_ALG_AES256,
        .cipherMode = SPUM_CIPHER_MODE_CBC,
        .keySecheapHdl = key256Hdl,
        .iv = SPUM_AES_IV,
    };

    const SPUM_CryptOpsType aes256CbcDecryptOps = {
        .cryptOp = SPUM_CRYPT_OP_DECRYPT,
        .cryptAlg = SPUM_CIPHER_ALG_AES256,
        .cipherMode = SPUM_CIPHER_MODE_CBC,
        .keySecheapHdl = key256Hdl,
        .iv = SPUM_AES_IV,
    };

    /* Create contexts */
    CHECKED_FUNC_CALL(SPUM_CreateContext, &aes128CbcEncryptOps, NULL, SPUM_CRYPT_AUTH_ORDER_NONE, 0UL, NULL, &aes128CbcEncryptCtx)
    CHECKED_FUNC_CALL(SPUM_CreateContext, &aes128CbcDecryptOps, NULL, SPUM_CRYPT_AUTH_ORDER_NONE, 0UL, NULL, &aes128CbcDecryptCtx)
    CHECKED_FUNC_CALL(SPUM_CreateContext, &aes256CbcEncryptOps, NULL, SPUM_CRYPT_AUTH_ORDER_NONE, 0UL, NULL, &aes256CbcEncryptCtx)
    CHECKED_FUNC_CALL(SPUM_CreateContext, &aes256CbcDecryptOps, NULL, SPUM_CRYPT_AUTH_ORDER_NONE, 0UL, NULL, &aes256CbcDecryptCtx)

    /* Inplace crypt testing */
    (void) memcpy(SPUM_CRYPT_OUT0, SPUM_PLAIN_TEXT, 4096UL);
    (void) memcpy(SPUM_CRYPT_OUT1, SPUM_CIPHER_TEXT_AES_128_CBC, 4096UL);
    (void) memcpy(SPUM_CRYPT_OUT2, SPUM_PLAIN_TEXT, 4096UL);
    (void) memcpy(SPUM_CRYPT_OUT3, SPUM_CIPHER_TEXT_AES_256_CBC, 4096UL);

    #define TEST_AND_PROF_AES_CBC(name, ctx, buf, gold)                             \
        jobExecResult = BCM_ERR_BUSY;                                               \
        BCM_GetTime(&beginTime);                                                    \
        CHECKED_FUNC_CALL(SPUM_Finish, (ctx), 4096UL, (buf), (buf), &jobId);        \
        BCM_WaitEvent(SPUMEvent);                                                   \
        BCM_ClearEvent(SPUMEvent);                                                  \
        BCM_GetTime(&endTime);                                                      \
        elapsedTime = BCM_GetTimeAbsDiff(endTime, beginTime);                       \
        CHECKED_FUNC_CALL(SPUM_GetJobExecResult, jobId, &jobExecResult)             \
        CHECK_COND(BCM_ERR_OK == jobExecResult)                                     \
        CHECKED_FUNC_CALL(memcmp, (buf), (gold), 4096UL);                           \
        PROF_TEST_RECORD_RES((name), ((4096ULL * 1000ULL) / elapsedTime.ns))

    TEST_AND_PROF_AES_CBC("AES128_CBC_ENCR", aes128CbcEncryptCtx, SPUM_CRYPT_OUT0, SPUM_CIPHER_TEXT_AES_128_CBC)
    TEST_AND_PROF_AES_CBC("AES128_CBC_DECR", aes128CbcDecryptCtx, SPUM_CRYPT_OUT1, SPUM_PLAIN_TEXT)
    TEST_AND_PROF_AES_CBC("AES256_CBC_ENCR", aes256CbcEncryptCtx, SPUM_CRYPT_OUT2, SPUM_CIPHER_TEXT_AES_256_CBC)
    TEST_AND_PROF_AES_CBC("AES256_CBC_DECR", aes256CbcDecryptCtx, SPUM_CRYPT_OUT3, SPUM_PLAIN_TEXT)

    #undef TEST_AND_PROF_AES_CBC

    /* Test one shot update followed by an empty finish */
    CHECKED_FUNC_CALL(SPUM_CreateContext, &aes128CbcEncryptOps, NULL, SPUM_CRYPT_AUTH_ORDER_NONE, 0UL, NULL, &aes128CbcEncryptCtx)

    (void) memcpy(SPUM_CRYPT_OUT0, SPUM_PLAIN_TEXT, 4096UL);
    CHECKED_FUNC_CALL(SPUM_Update, aes128CbcEncryptCtx, 4096UL, SPUM_CRYPT_OUT0, SPUM_CRYPT_OUT0, &jobId);

    BCM_WaitEvent(SPUMEvent);
    BCM_ClearEvent(SPUMEvent);

    CHECKED_FUNC_CALL(SPUM_GetJobExecResult, jobId, &jobExecResult)
    CHECK_COND(BCM_ERR_OK == jobExecResult)

    CHECKED_FUNC_CALL(SPUM_Finish, aes128CbcEncryptCtx, 0UL, NULL, NULL, &jobId);

    BCM_WaitEvent(SPUMEvent);
    BCM_ClearEvent(SPUMEvent);

    CHECKED_FUNC_CALL(SPUM_GetJobExecResult, jobId, &jobExecResult)
    CHECK_COND(BCM_ERR_OK == jobExecResult)

    CHECKED_FUNC_CALL(memcmp, SPUM_CRYPT_OUT0, SPUM_CIPHER_TEXT_AES_128_CBC, 4096UL);

    /* Free up handles */
    CHECKED_FUNC_CALL(SECHEAP_Free, key128Hdl)
    CHECKED_FUNC_CALL(SECHEAP_Free, key256Hdl)

exit:
    if (0UL != failLine) {
        ret = BCM_ERR_INVAL_STATE;
    } else {
        ret = BCM_ERR_OK;
    }

    return ret;
}

static int32_t SPUM_TestAesCtr(void)
{
    int32_t i;
    int32_t ret;
    uint32_t key128Hdl = 0UL;
    uint32_t key256Hdl = 0UL;
    SPUM_ContextHandleType aes128CtrEncryptCtx = 0ULL;
    SPUM_ContextHandleType aes128CtrDecryptCtx = 0ULL;
    SPUM_ContextHandleType aes256CtrEncryptCtx = 0ULL;
    SPUM_ContextHandleType aes256CtrDecryptCtx = 0ULL;

    _Static_assert(3436UL == SPUM_SOME_RANDOM_SIZE, "The loop submitting jobs makes this assumption!");

    /* Initialize keys */
    CHECKED_FUNC_CALL(SECHEAP_Create, SPUM_AES_KEY_128_NUM_BYTES, 0UL, SPUM_AES_KEY_128, &key128Hdl)
    CHECKED_FUNC_CALL(SECHEAP_Create, SPUM_AES_KEY_256_NUM_BYTES, 0UL, SPUM_AES_KEY_256, &key256Hdl)

    /* Initialize contexts */
    const SPUM_CryptOpsType aes128CtrEncryptOps = {
        .cryptOp = SPUM_CRYPT_OP_ENCRYPT,
        .cryptAlg = SPUM_CIPHER_ALG_AES128,
        .cipherMode = SPUM_CIPHER_MODE_CTR,
        .keySecheapHdl = key128Hdl,
        .iv = SPUM_AES_IV,
    };

    const SPUM_CryptOpsType aes128CtrDecryptOps = {
        .cryptOp = SPUM_CRYPT_OP_DECRYPT,
        .cryptAlg = SPUM_CIPHER_ALG_AES128,
        .cipherMode = SPUM_CIPHER_MODE_CTR,
        .keySecheapHdl = key128Hdl,
        .iv = SPUM_AES_IV,
    };

    const SPUM_CryptOpsType aes256CtrEncryptOps = {
        .cryptOp = SPUM_CRYPT_OP_ENCRYPT,
        .cryptAlg = SPUM_CIPHER_ALG_AES256,
        .cipherMode = SPUM_CIPHER_MODE_CTR,
        .keySecheapHdl = key256Hdl,
        .iv = SPUM_AES_IV,
    };

    const SPUM_CryptOpsType aes256CtrDecryptOps = {
        .cryptOp = SPUM_CRYPT_OP_DECRYPT,
        .cryptAlg = SPUM_CIPHER_ALG_AES256,
        .cipherMode = SPUM_CIPHER_MODE_CTR,
        .keySecheapHdl = key256Hdl,
        .iv = SPUM_AES_IV,
    };

    CHECKED_FUNC_CALL(SPUM_CreateContext, &aes128CtrEncryptOps, NULL, SPUM_CRYPT_AUTH_ORDER_NONE, 0UL, NULL, &aes128CtrEncryptCtx)
    CHECKED_FUNC_CALL(SPUM_CreateContext, &aes128CtrDecryptOps, NULL, SPUM_CRYPT_AUTH_ORDER_NONE, 0UL, NULL, &aes128CtrDecryptCtx)
    CHECKED_FUNC_CALL(SPUM_CreateContext, &aes256CtrEncryptOps, NULL, SPUM_CRYPT_AUTH_ORDER_NONE, 0UL, NULL, &aes256CtrEncryptCtx)
    CHECKED_FUNC_CALL(SPUM_CreateContext, &aes256CtrDecryptOps, NULL, SPUM_CRYPT_AUTH_ORDER_NONE, 0UL, NULL, &aes256CtrDecryptCtx)

    BCM_ClearEvent(SPUMEvent);

    for (i = 0; i < 4; i++) {
        uint32_t cryptSize;
        const uint32_t offset = (uint32_t)(1024 * i);
        bool jobResolved[4UL] = {false, false, false, false};
        SPUM_JobIdType spumJobIds[4UL] = {0ULL, 0ULL, 0ULL, 0ULL};
        int32_t (*fnPtr)(const SPUM_ContextHandleType aCtxHdl, const uint32_t aDataInSizeInOctets, const uint8_t *aDataIn, uint8_t *aCryptOut, SPUM_JobIdType *aJobId);

        if (3 == i) {
            cryptSize = 364UL;
            fnPtr = SPUM_Finish;
        } else {
            cryptSize = 1024UL;
            fnPtr = SPUM_Update;
        }

        CHECKED_FUNC_CALL(fnPtr, aes128CtrEncryptCtx, cryptSize, SPUM_PLAIN_TEXT + offset, SPUM_CRYPT_OUT0 + offset, &spumJobIds[0])
        CHECKED_FUNC_CALL(fnPtr, aes128CtrDecryptCtx, cryptSize, SPUM_CIPHER_TEXT_AES_128_CTR + offset, SPUM_CRYPT_OUT1 + offset, &spumJobIds[1])
        CHECKED_FUNC_CALL(fnPtr, aes256CtrEncryptCtx, cryptSize, SPUM_PLAIN_TEXT + offset, SPUM_CRYPT_OUT2 + offset, &spumJobIds[2])
        CHECKED_FUNC_CALL(fnPtr, aes256CtrDecryptCtx, cryptSize, SPUM_CIPHER_TEXT_AES_256_CTR + offset, SPUM_CRYPT_OUT3 + offset, &spumJobIds[3])

        while (true) {
            uint32_t j;
            BCM_WaitEvent(SPUMEvent);
            BCM_ClearEvent(SPUMEvent);

            for (j = 0UL; j < 4UL; j++) {
                if (false == jobResolved[j]) {
                    int32_t algExecResult = BCM_ERR_BUSY;
                    CHECKED_FUNC_CALL(SPUM_GetJobExecResult, spumJobIds[j], &algExecResult)
                    if (BCM_ERR_BUSY == algExecResult) {
                        break;
                    } else {
                        CHECK_COND(BCM_ERR_OK == algExecResult)
                        jobResolved[j] = true;
                    }
                }
            }

            if (4UL == j) {
                break;
            }
        }
    }

    /* Compare results */
    CHECKED_FUNC_CALL(memcmp, SPUM_CRYPT_OUT0, SPUM_CIPHER_TEXT_AES_128_CTR, 3436UL);
    CHECKED_FUNC_CALL(memcmp, SPUM_CRYPT_OUT1, SPUM_PLAIN_TEXT, 3436UL);
    CHECKED_FUNC_CALL(memcmp, SPUM_CRYPT_OUT2, SPUM_CIPHER_TEXT_AES_256_CTR, 3436UL);
    CHECKED_FUNC_CALL(memcmp, SPUM_CRYPT_OUT3, SPUM_PLAIN_TEXT, 3436UL);

    /* Free up handles */
    CHECKED_FUNC_CALL(SECHEAP_Free, key128Hdl)
    CHECKED_FUNC_CALL(SECHEAP_Free, key256Hdl)

exit:
    if (0UL != failLine) {
        ret = BCM_ERR_INVAL_STATE;
    } else {
        ret = BCM_ERR_OK;
    }

    return ret;
}

static int32_t SPUM_TestAesCtrOneShotAndProf(void)
{
    int32_t ret;
    int32_t jobExecResult;
    uint32_t key128Hdl = 0UL;
    uint32_t key256Hdl = 0UL;
    BCM_TimeType beginTime = {};
    BCM_TimeType endTime = {};
    BCM_TimeType elapsedTime = {};
    SPUM_JobIdType jobId = 0ULL;
    SPUM_ContextHandleType aes128CtrEncryptCtx = 0ULL;
    SPUM_ContextHandleType aes128CtrDecryptCtx = 0ULL;
    SPUM_ContextHandleType aes256CtrEncryptCtx = 0ULL;
    SPUM_ContextHandleType aes256CtrDecryptCtx = 0ULL;

    _Static_assert(3436UL == SPUM_SOME_RANDOM_SIZE, "The loop submitting jobs makes this assumption!");

    /* Initialize keys */
    CHECKED_FUNC_CALL(SECHEAP_Create, SPUM_AES_KEY_128_NUM_BYTES, 0UL, SPUM_AES_KEY_128, &key128Hdl)
    CHECKED_FUNC_CALL(SECHEAP_Create, SPUM_AES_KEY_256_NUM_BYTES, 0UL, SPUM_AES_KEY_256, &key256Hdl)

    /* Initialize contexts */
    const SPUM_CryptOpsType aes128CtrEncryptOps = {
        .cryptOp = SPUM_CRYPT_OP_ENCRYPT,
        .cryptAlg = SPUM_CIPHER_ALG_AES128,
        .cipherMode = SPUM_CIPHER_MODE_CTR,
        .keySecheapHdl = key128Hdl,
        .iv = SPUM_AES_IV,
    };

    const SPUM_CryptOpsType aes128CtrDecryptOps = {
        .cryptOp = SPUM_CRYPT_OP_DECRYPT,
        .cryptAlg = SPUM_CIPHER_ALG_AES128,
        .cipherMode = SPUM_CIPHER_MODE_CTR,
        .keySecheapHdl = key128Hdl,
        .iv = SPUM_AES_IV,
    };

    const SPUM_CryptOpsType aes256CtrEncryptOps = {
        .cryptOp = SPUM_CRYPT_OP_ENCRYPT,
        .cryptAlg = SPUM_CIPHER_ALG_AES256,
        .cipherMode = SPUM_CIPHER_MODE_CTR,
        .keySecheapHdl = key256Hdl,
        .iv = SPUM_AES_IV,
    };

    const SPUM_CryptOpsType aes256CtrDecryptOps = {
        .cryptOp = SPUM_CRYPT_OP_DECRYPT,
        .cryptAlg = SPUM_CIPHER_ALG_AES256,
        .cipherMode = SPUM_CIPHER_MODE_CTR,
        .keySecheapHdl = key256Hdl,
        .iv = SPUM_AES_IV,
    };

    CHECKED_FUNC_CALL(SPUM_CreateContext, &aes128CtrEncryptOps, NULL, SPUM_CRYPT_AUTH_ORDER_NONE, 0UL, NULL, &aes128CtrEncryptCtx)
    CHECKED_FUNC_CALL(SPUM_CreateContext, &aes128CtrDecryptOps, NULL, SPUM_CRYPT_AUTH_ORDER_NONE, 0UL, NULL, &aes128CtrDecryptCtx)
    CHECKED_FUNC_CALL(SPUM_CreateContext, &aes256CtrEncryptOps, NULL, SPUM_CRYPT_AUTH_ORDER_NONE, 0UL, NULL, &aes256CtrEncryptCtx)
    CHECKED_FUNC_CALL(SPUM_CreateContext, &aes256CtrDecryptOps, NULL, SPUM_CRYPT_AUTH_ORDER_NONE, 0UL, NULL, &aes256CtrDecryptCtx)

    /* Inplace crypt testing */
    (void) memcpy(SPUM_CRYPT_OUT0, SPUM_PLAIN_TEXT, 4096UL);
    (void) memcpy(SPUM_CRYPT_OUT1, SPUM_CIPHER_TEXT_AES_128_CTR, 4096UL);
    (void) memcpy(SPUM_CRYPT_OUT2, SPUM_PLAIN_TEXT, 4096UL);
    (void) memcpy(SPUM_CRYPT_OUT3, SPUM_CIPHER_TEXT_AES_256_CTR, 4096UL);

    #define TEST_AND_PROF_AES_CTR(name, ctx, buf, gold)                             \
        jobExecResult = BCM_ERR_BUSY;                                               \
        BCM_GetTime(&beginTime);                                                    \
        CHECKED_FUNC_CALL(SPUM_Finish, (ctx), 4096UL, (buf), (buf), &jobId);        \
        BCM_WaitEvent(SPUMEvent);                                                   \
        BCM_ClearEvent(SPUMEvent);                                                  \
        BCM_GetTime(&endTime);                                                      \
        elapsedTime = BCM_GetTimeAbsDiff(endTime, beginTime);                       \
        CHECKED_FUNC_CALL(SPUM_GetJobExecResult, jobId, &jobExecResult)             \
        CHECK_COND(BCM_ERR_OK == jobExecResult)                                     \
        CHECKED_FUNC_CALL(memcmp, (buf), (gold), 4096UL);                           \
        PROF_TEST_RECORD_RES((name), ((4096ULL * 1000ULL) / elapsedTime.ns))

    TEST_AND_PROF_AES_CTR("AES128_CTR_ENCR", aes128CtrEncryptCtx, SPUM_CRYPT_OUT0, SPUM_CIPHER_TEXT_AES_128_CTR)
    TEST_AND_PROF_AES_CTR("AES128_CTR_DECR", aes128CtrDecryptCtx, SPUM_CRYPT_OUT1, SPUM_PLAIN_TEXT)
    TEST_AND_PROF_AES_CTR("AES256_CTR_ENCR", aes256CtrEncryptCtx, SPUM_CRYPT_OUT2, SPUM_CIPHER_TEXT_AES_256_CTR)
    TEST_AND_PROF_AES_CTR("AES256_CTR_DECR", aes256CtrDecryptCtx, SPUM_CRYPT_OUT3, SPUM_PLAIN_TEXT)

    #undef TEST_AND_PROF_AES_CTR

    /* Free up handles */
    CHECKED_FUNC_CALL(SECHEAP_Free, key128Hdl)
    CHECKED_FUNC_CALL(SECHEAP_Free, key256Hdl)

exit:
    if (0UL != failLine) {
        ret = BCM_ERR_INVAL_STATE;
    } else {
        ret = BCM_ERR_OK;
    }

    return ret;
}

static int32_t SPUM_TestSha256(const uint32_t aComputeMac)
{
    int32_t i;
    int32_t ret;
    uint32_t hmacKeyHdl = 0UL;
    int32_t algExecResult = BCM_ERR_BUSY;
    SPUM_JobIdType spumJobId = 0ULL;
    SPUM_ContextHandleType sha256Len512Ctx  = 0ULL;
    SPUM_ContextHandleType sha256Len3436Ctx = 0ULL;

    /* Initialize keys */
    if (1UL == aComputeMac) {
        CHECKED_FUNC_CALL(SECHEAP_Create, SPUM_HMAC_KEY_256_NUM_BYTES, 0UL, SPUM_HMAC_KEY_256, &hmacKeyHdl)
    }

    const SPUM_AuthOpsType authOps = {
        .hashAlg = (1UL == aComputeMac) ? SPUM_HASH_ALG_HMAC_SHA256 : SPUM_HASH_ALG_SHA256,
        .keySecheapHdl = hmacKeyHdl
    };

    /* Create contexts */
    CHECKED_FUNC_CALL(SPUM_CreateContext, NULL, &authOps, SPUM_CRYPT_AUTH_ORDER_NONE, 32UL, SPUM_AUTH_OUT0, &sha256Len512Ctx)
    CHECKED_FUNC_CALL(SPUM_CreateContext, NULL, &authOps, SPUM_CRYPT_AUTH_ORDER_NONE, 32UL, SPUM_AUTH_OUT1, &sha256Len3436Ctx)

    BCM_ClearEvent(SPUMEvent);

    /* Hash 512 bytes   */
    CHECKED_FUNC_CALL(SPUM_Finish, sha256Len512Ctx, 512UL, SPUM_PLAIN_TEXT, NULL, &spumJobId)

    BCM_WaitEvent(SPUMEvent);
    BCM_ClearEvent(SPUMEvent);

    CHECKED_FUNC_CALL(SPUM_GetJobExecResult, spumJobId, &algExecResult)
    CHECK_COND(BCM_ERR_OK == algExecResult)

    /* Hash 3436 bytes  */
    for (i = 0; i < 4; i++) {
        uint32_t authSize;
        const uint32_t offset = (uint32_t)(1024 * i);
        int32_t (*fnPtr)(const SPUM_ContextHandleType aCtxHdl, const uint32_t aDataInSizeInOctets, const uint8_t *aDataIn, uint8_t *aCryptOut, SPUM_JobIdType *aJobId);

        if (3 == i) {
            authSize = 364UL;
            fnPtr = SPUM_Finish;
        } else {
            authSize = 1024UL;
            fnPtr = SPUM_Update;
        }

        CHECKED_FUNC_CALL(fnPtr, sha256Len3436Ctx, authSize, SPUM_PLAIN_TEXT + offset, NULL, &spumJobId)

        BCM_WaitEvent(SPUMEvent);
        BCM_ClearEvent(SPUMEvent);

        CHECKED_FUNC_CALL(SPUM_GetJobExecResult, spumJobId, &algExecResult)
        CHECK_COND(BCM_ERR_OK == algExecResult)
    }

    /* Compare results */
    if (1UL == aComputeMac) {
        CHECKED_FUNC_CALL(memcmp, SPUM_HMAC_SHA256_PLAIN_TEXT_512_BYTES,  SPUM_AUTH_OUT0, 32UL)
        CHECKED_FUNC_CALL(memcmp, SPUM_HMAC_SHA256_PLAIN_TEXT_3436_BYTES, SPUM_AUTH_OUT1, 32UL)
    } else {
        CHECKED_FUNC_CALL(memcmp, SPUM_HASH_SHA256_PLAIN_TEXT_512_BYTES,  SPUM_AUTH_OUT0, 32UL)
        CHECKED_FUNC_CALL(memcmp, SPUM_HASH_SHA256_PLAIN_TEXT_3436_BYTES, SPUM_AUTH_OUT1, 32UL)
    }

    if (1UL == aComputeMac) {
        CHECKED_FUNC_CALL(SECHEAP_Free, hmacKeyHdl)
    }

exit:
    if (0UL != failLine) {
        ret = BCM_ERR_INVAL_STATE;
    } else {
        ret = BCM_ERR_OK;
    }

    return ret;
}

static int32_t SPUM_TestSha256OneShotAndProf(const uint32_t aComputeMac)
{
    int32_t ret;
    uint32_t hmacKeyHdl = 0UL;
    BCM_TimeType beginTime = {};
    BCM_TimeType endTime = {};
    BCM_TimeType elapsedTime = {};
    SPUM_JobIdType jobId = 0ULL;
    int32_t jobExecResult = BCM_ERR_BUSY;

    /* Initialize keys */
    if (1UL == aComputeMac) {
        CHECKED_FUNC_CALL(SECHEAP_Create, SPUM_HMAC_KEY_256_NUM_BYTES, 0UL, SPUM_HMAC_KEY_256, &hmacKeyHdl)
    }

    SPUM_ContextHandleType sha256Len4096Ctx = 0ULL;

    const SPUM_AuthOpsType authOps = {
        .hashAlg = (1UL == aComputeMac) ? SPUM_HASH_ALG_HMAC_SHA256 : SPUM_HASH_ALG_SHA256,
        .keySecheapHdl = hmacKeyHdl
    };

    /* One shot SPUM finish */
    CHECKED_FUNC_CALL(SPUM_CreateContext, NULL, &authOps, SPUM_CRYPT_AUTH_ORDER_NONE, 32UL, SPUM_AUTH_OUT0, &sha256Len4096Ctx)

    /* Issue hash computation command and wait */
    BCM_GetTime(&beginTime);
    CHECKED_FUNC_CALL(SPUM_Finish, sha256Len4096Ctx, 4096UL, SPUM_PLAIN_TEXT, NULL, &jobId)

    BCM_WaitEvent(SPUMEvent);
    BCM_ClearEvent(SPUMEvent);

    BCM_GetTime(&endTime);
    elapsedTime = BCM_GetTimeAbsDiff(endTime, beginTime);

    /* Check if evrything is OK */
    CHECKED_FUNC_CALL(SPUM_GetJobExecResult, jobId, &jobExecResult)
    CHECK_COND(BCM_ERR_OK == jobExecResult)

    if (1UL == aComputeMac) {
        CHECKED_FUNC_CALL(memcmp, SPUM_AUTH_OUT0, SPUM_HMAC_SHA256_PLAIN_TEXT_4096_BYTES, 32UL);
    } else {
        CHECKED_FUNC_CALL(memcmp, SPUM_AUTH_OUT0, SPUM_HASH_SHA256_PLAIN_TEXT_4096_BYTES, 32UL);
    }

    const char *const testName = (1UL == aComputeMac) ? "HMAC_SHA256" : "HASH_SHA256";
    PROF_TEST_RECORD_RES(testName, ((4096ULL * 1000ULL) / elapsedTime.ns))

    /* One shot SPUM update followed by a finish of size 0 */
    CHECKED_FUNC_CALL(SPUM_CreateContext, NULL, &authOps, SPUM_CRYPT_AUTH_ORDER_NONE, 32UL, SPUM_AUTH_OUT0, &sha256Len4096Ctx)

    /* Issue hash computation command and wait */
    CHECKED_FUNC_CALL(SPUM_Update, sha256Len4096Ctx, 4096UL, SPUM_PLAIN_TEXT, NULL, &jobId)

    BCM_WaitEvent(SPUMEvent);
    BCM_ClearEvent(SPUMEvent);

    /* Check if evrything is OK */
    CHECKED_FUNC_CALL(SPUM_GetJobExecResult, jobId, &jobExecResult)
    CHECK_COND(BCM_ERR_OK == jobExecResult)

    CHECKED_FUNC_CALL(SPUM_Finish, sha256Len4096Ctx, 0UL, NULL, NULL, &jobId)

    BCM_WaitEvent(SPUMEvent);
    BCM_ClearEvent(SPUMEvent);

    CHECKED_FUNC_CALL(SPUM_GetJobExecResult, jobId, &jobExecResult)
    CHECK_COND(BCM_ERR_OK == jobExecResult)

    if (1UL == aComputeMac) {
        CHECKED_FUNC_CALL(memcmp, SPUM_AUTH_OUT0, SPUM_HMAC_SHA256_PLAIN_TEXT_4096_BYTES, 32UL);
    } else {
        CHECKED_FUNC_CALL(memcmp, SPUM_AUTH_OUT0, SPUM_HASH_SHA256_PLAIN_TEXT_4096_BYTES, 32UL);
    }

    if (1UL == aComputeMac) {
        CHECKED_FUNC_CALL(SECHEAP_Free, hmacKeyHdl)
    }

exit:
    if (0UL != failLine) {
        ret = BCM_ERR_INVAL_STATE;
    } else {
        ret = BCM_ERR_OK;
    }

    return ret;
}

static int32_t SPUM_TestAesAndAuth(void)
{
    int32_t i;
    int32_t ret;
    uint32_t key128Hdl = 0UL;
    uint32_t key192Hdl = 0UL;
    uint32_t hmacKeyHdl = 0UL;
    SPUM_ContextHandleType authThenCryptCtx = 0ULL;
    SPUM_ContextHandleType cryptThenAuthCtx = 0ULL;

    /* Initialize keys */
    CHECKED_FUNC_CALL(SECHEAP_Create, SPUM_AES_KEY_128_NUM_BYTES, 0UL, SPUM_AES_KEY_128, &key128Hdl)
    CHECKED_FUNC_CALL(SECHEAP_Create, SPUM_AES_KEY_192_NUM_BYTES, 0UL, SPUM_AES_KEY_192, &key192Hdl)
    CHECKED_FUNC_CALL(SECHEAP_Create, SPUM_HMAC_KEY_256_NUM_BYTES, 0UL, SPUM_HMAC_KEY_256, &hmacKeyHdl)

    const SPUM_AuthOpsType authOpsAuthThenCrypt = {
        .hashAlg = SPUM_HASH_ALG_SHA256,
    };

    const SPUM_AuthOpsType authOpsCryptThenAuth = {
        .hashAlg = SPUM_HASH_ALG_HMAC_SHA256,
        .keySecheapHdl = hmacKeyHdl
    };

    const SPUM_CryptOpsType cryptOpsAuthThenCrypt = {
        .cryptOp = SPUM_CRYPT_OP_ENCRYPT,
        .cryptAlg = SPUM_CIPHER_ALG_AES128,
        .cipherMode = SPUM_CIPHER_MODE_CBC,
        .keySecheapHdl = key128Hdl,
        .iv = SPUM_AES_IV,
    };

    const SPUM_CryptOpsType cryptOpsCryptThenAuth = {
        .cryptOp = SPUM_CRYPT_OP_DECRYPT,
        .cryptAlg = SPUM_CIPHER_ALG_AES192,
        .cipherMode = SPUM_CIPHER_MODE_CTR,
        .keySecheapHdl = key192Hdl,
        .iv = SPUM_AES_IV,
    };

    /* Create contexts */
    CHECKED_FUNC_CALL(SPUM_CreateContext, &cryptOpsAuthThenCrypt, &authOpsAuthThenCrypt, SPUM_CRYPT_AUTH_ORDER_AUTH_THEN_CRYPT, 32UL, SPUM_AUTH_OUT0, &authThenCryptCtx)
    CHECKED_FUNC_CALL(SPUM_CreateContext, &cryptOpsCryptThenAuth, &authOpsCryptThenAuth, SPUM_CRYPT_AUTH_ORDER_CRYPT_THEN_AUTH, 32UL, SPUM_AUTH_OUT1, &cryptThenAuthCtx)

    BCM_ClearEvent(SPUMEvent);

    for (i = 0; i < 4; i++) {
        uint32_t dataSize0;
        uint32_t dataSize1;
        const uint32_t offset = (uint32_t)(1024 * i);
        bool jobResolved[2UL] = {false, false};
        SPUM_JobIdType spumJobIds[2UL] = {0ULL, 0ULL};
        int32_t (*fnPtr)(const SPUM_ContextHandleType aCtxHdl, const uint32_t aDataInSizeInOctets, const uint8_t *aDataIn, uint8_t *aCryptOut, SPUM_JobIdType *aJobId);

        if (3 == i) {
            dataSize0 = 1024UL;
            dataSize1 = 364UL;
            fnPtr = SPUM_Finish;
        } else {
            dataSize0 = 1024UL;
            dataSize1 = 1024UL;
            fnPtr = SPUM_Update;
        }

        CHECKED_FUNC_CALL(fnPtr, authThenCryptCtx, dataSize0, SPUM_PLAIN_TEXT + offset, SPUM_CRYPT_OUT0 + offset, &spumJobIds[0])
        CHECKED_FUNC_CALL(fnPtr, cryptThenAuthCtx, dataSize1, SPUM_CIPHER_TEXT_AES_192_CTR + offset, SPUM_CRYPT_OUT1 + offset, &spumJobIds[1])

        while (true) {
            uint32_t j;
            BCM_WaitEvent(SPUMEvent);
            BCM_ClearEvent(SPUMEvent);

            for (j = 0UL; j < 2UL; j++) {
                if (false == jobResolved[j]) {
                    int32_t algExecResult = BCM_ERR_BUSY;
                    CHECKED_FUNC_CALL(SPUM_GetJobExecResult, spumJobIds[j], &algExecResult)
                    if (BCM_ERR_BUSY == algExecResult) {
                        break;
                    } else {
                        CHECK_COND(BCM_ERR_OK == algExecResult)
                        jobResolved[j] = true;
                    }
                }
            }

            if (2UL == j) {
                break;
            }
        }
    }

    /* Compare results */
    CHECKED_FUNC_CALL(memcmp, SPUM_CRYPT_OUT0, SPUM_CIPHER_TEXT_AES_128_CBC, 4096UL);
    CHECKED_FUNC_CALL(memcmp, SPUM_CRYPT_OUT1, SPUM_PLAIN_TEXT, 3436UL);

    CHECKED_FUNC_CALL(memcmp, SPUM_AUTH_OUT0, SPUM_HASH_SHA256_PLAIN_TEXT_4096_BYTES, 32UL);
    CHECKED_FUNC_CALL(memcmp, SPUM_AUTH_OUT1, SPUM_HMAC_SHA256_PLAIN_TEXT_3436_BYTES, 32UL);

    /* Free up handles */
    CHECKED_FUNC_CALL(SECHEAP_Free, key128Hdl)
    CHECKED_FUNC_CALL(SECHEAP_Free, key192Hdl)
    CHECKED_FUNC_CALL(SECHEAP_Free, hmacKeyHdl)

exit:
    if (0UL != failLine) {
        ret = BCM_ERR_INVAL_STATE;
    } else {
        ret = BCM_ERR_OK;
    }

    return ret;
}

static int32_t SPUM_TestAesAndAuthOneShotAndProf(void)
{
    int32_t ret;
    int32_t jobExecResult;
    uint32_t key128Hdl = 0UL;
    uint32_t key192Hdl = 0UL;
    BCM_TimeType beginTime = {};
    BCM_TimeType endTime = {};
    BCM_TimeType elapsedTime = {};
    SPUM_JobIdType jobId = 0ULL;

    SPUM_ContextHandleType authThenCryptCtx = 0ULL;
    SPUM_ContextHandleType cryptThenAuthCtx = 0ULL;

    /* Initialize keys */
    CHECKED_FUNC_CALL(SECHEAP_Create, SPUM_AES_KEY_128_NUM_BYTES, 0UL, SPUM_AES_KEY_128, &key128Hdl)
    CHECKED_FUNC_CALL(SECHEAP_Create, SPUM_AES_KEY_192_NUM_BYTES, 0UL, SPUM_AES_KEY_192, &key192Hdl)

    const SPUM_AuthOpsType authOps = {
        .hashAlg = SPUM_HASH_ALG_SHA256,
    };

    const SPUM_CryptOpsType cryptOpsAuthThenCrypt = {
        .cryptOp = SPUM_CRYPT_OP_ENCRYPT,
        .cryptAlg = SPUM_CIPHER_ALG_AES128,
        .cipherMode = SPUM_CIPHER_MODE_CBC,
        .keySecheapHdl = key128Hdl,
        .iv = SPUM_AES_IV,
    };

    const SPUM_CryptOpsType cryptOpsCryptThenAuth = {
        .cryptOp = SPUM_CRYPT_OP_DECRYPT,
        .cryptAlg = SPUM_CIPHER_ALG_AES192,
        .cipherMode = SPUM_CIPHER_MODE_CTR,
        .keySecheapHdl = key192Hdl,
        .iv = SPUM_AES_IV,
    };

    /* Create contexts */
    CHECKED_FUNC_CALL(SPUM_CreateContext, &cryptOpsAuthThenCrypt, &authOps, SPUM_CRYPT_AUTH_ORDER_AUTH_THEN_CRYPT, 32UL, SPUM_AUTH_OUT0, &authThenCryptCtx)
    CHECKED_FUNC_CALL(SPUM_CreateContext, &cryptOpsCryptThenAuth, &authOps, SPUM_CRYPT_AUTH_ORDER_CRYPT_THEN_AUTH, 32UL, SPUM_AUTH_OUT1, &cryptThenAuthCtx)

    BCM_ClearEvent(SPUMEvent);

    /* Inplace testing */
    (void) memcpy(SPUM_CRYPT_OUT2, SPUM_PLAIN_TEXT, 4096UL);
    (void) memcpy(SPUM_CRYPT_OUT3, SPUM_CIPHER_TEXT_AES_192_CTR, 4096UL);

    #define TEST_AND_PROF_CRYPT_AND_AUTH(name, ctx, cryptbuf, hashbuf, cryptgold, hashgold) \
        jobExecResult = BCM_ERR_BUSY;                                                       \
        BCM_GetTime(&beginTime);                                                            \
        CHECKED_FUNC_CALL(SPUM_Finish, (ctx), 4096UL, (cryptbuf), (cryptbuf), &jobId);      \
        BCM_WaitEvent(SPUMEvent);                                                           \
        BCM_ClearEvent(SPUMEvent);                                                          \
        BCM_GetTime(&endTime);                                                              \
        elapsedTime = BCM_GetTimeAbsDiff(endTime, beginTime);                               \
        CHECKED_FUNC_CALL(SPUM_GetJobExecResult, jobId, &jobExecResult)                     \
        CHECK_COND(BCM_ERR_OK == jobExecResult)                                             \
        CHECKED_FUNC_CALL(memcmp, (cryptbuf), (cryptgold), 4096UL);                         \
        CHECKED_FUNC_CALL(memcmp, (hashbuf), (hashgold), 32UL)                              \
        PROF_TEST_RECORD_RES((name), ((4096ULL * 1000ULL) / elapsedTime.ns))

    TEST_AND_PROF_CRYPT_AND_AUTH("AES128_CBC_ENCR_SHA256", authThenCryptCtx, SPUM_CRYPT_OUT2,
        SPUM_AUTH_OUT0, SPUM_CIPHER_TEXT_AES_128_CBC, SPUM_HASH_SHA256_PLAIN_TEXT_4096_BYTES)

    TEST_AND_PROF_CRYPT_AND_AUTH("AES192_CTR_DECR_SHA256", cryptThenAuthCtx, SPUM_CRYPT_OUT3,
        SPUM_AUTH_OUT1, SPUM_PLAIN_TEXT, SPUM_HASH_SHA256_PLAIN_TEXT_4096_BYTES)

    #undef TEST_AND_PROF_CRYPT_AND_AUTH

    /* One shot update followed by an empty finish */
    CHECKED_FUNC_CALL(SPUM_CreateContext, &cryptOpsAuthThenCrypt, &authOps, SPUM_CRYPT_AUTH_ORDER_AUTH_THEN_CRYPT, 32UL, SPUM_AUTH_OUT0, &authThenCryptCtx)

    (void) memcpy(SPUM_CRYPT_OUT2, SPUM_PLAIN_TEXT, 4096UL);

    CHECKED_FUNC_CALL(SPUM_Update, authThenCryptCtx, 4096UL, SPUM_CRYPT_OUT2, SPUM_CRYPT_OUT2, &jobId);

    BCM_WaitEvent(SPUMEvent);
    BCM_ClearEvent(SPUMEvent);

    CHECKED_FUNC_CALL(SPUM_GetJobExecResult, jobId, &jobExecResult)
    CHECK_COND(BCM_ERR_OK == jobExecResult)

    CHECKED_FUNC_CALL(SPUM_Finish, authThenCryptCtx, 0UL, NULL, NULL, &jobId);

    BCM_WaitEvent(SPUMEvent);
    BCM_ClearEvent(SPUMEvent);

    CHECKED_FUNC_CALL(SPUM_GetJobExecResult, jobId, &jobExecResult)
    CHECK_COND(BCM_ERR_OK == jobExecResult)

    CHECKED_FUNC_CALL(memcmp, SPUM_CRYPT_OUT2, SPUM_CIPHER_TEXT_AES_128_CBC, 4096UL);
    CHECKED_FUNC_CALL(memcmp, SPUM_AUTH_OUT0, SPUM_HASH_SHA256_PLAIN_TEXT_4096_BYTES, 32UL)

    /* Free up handles */
    CHECKED_FUNC_CALL(SECHEAP_Free, key128Hdl)
    CHECKED_FUNC_CALL(SECHEAP_Free, key192Hdl)

exit:
    if (0UL != failLine) {
        ret = BCM_ERR_INVAL_STATE;
    } else {
        ret = BCM_ERR_OK;
    }

    return ret;
}

static int32_t SPUM_TestAes(void)
{
    int32_t ret;
    CHECKED_FUNC_CALL(SPUM_TestAesCbc);
    CHECKED_FUNC_CALL(SPUM_TestAesCbcOneShotAndProf);
    CHECKED_FUNC_CALL(SPUM_TestAesCtr);
    CHECKED_FUNC_CALL(SPUM_TestAesCtrOneShotAndProf);
exit:
    return ret;
}

static int32_t SPUM_TestAuth(void)
{
    int32_t ret;
    CHECKED_FUNC_CALL(SPUM_TestSha256, 0UL);
    CHECKED_FUNC_CALL(SPUM_TestSha256, 1UL);
    CHECKED_FUNC_CALL(SPUM_TestSha256OneShotAndProf, 0UL);
    CHECKED_FUNC_CALL(SPUM_TestSha256OneShotAndProf, 1UL);

exit:
    return ret;
}

static int32_t SPUM_TestContextDestroy(void)
{
    int32_t ret;
    uint32_t key128Hdl = 0UL;
    SPUM_JobIdType jobId = 0ULL;
    int32_t algExecResult = BCM_ERR_BUSY;

    SPUM_ContextHandleType aes128CbcEncryptCtx = 0ULL;
    SPUM_ContextHandleType aes128CbcDecryptCtx = 0ULL;

    /* Initialize keys */
    CHECKED_FUNC_CALL(SECHEAP_Create, SPUM_AES_KEY_128_NUM_BYTES, 0UL, SPUM_AES_KEY_128, &key128Hdl)

    /* Initialize contexts */
    const SPUM_CryptOpsType aes128CbcEncryptOps = {
        .cryptOp = SPUM_CRYPT_OP_ENCRYPT,
        .cryptAlg = SPUM_CIPHER_ALG_AES128,
        .cipherMode = SPUM_CIPHER_MODE_CBC,
        .keySecheapHdl = key128Hdl,
        .iv = SPUM_AES_IV,
    };

    const SPUM_CryptOpsType aes128CbcDecryptOps = {
        .cryptOp = SPUM_CRYPT_OP_DECRYPT,
        .cryptAlg = SPUM_CIPHER_ALG_AES128,
        .cipherMode = SPUM_CIPHER_MODE_CBC,
        .keySecheapHdl = key128Hdl,
        .iv = SPUM_AES_IV,
    };

    /* Create contexts */
    CHECKED_FUNC_CALL(SPUM_CreateContext, &aes128CbcEncryptOps, NULL, SPUM_CRYPT_AUTH_ORDER_NONE, 0UL, NULL, &aes128CbcEncryptCtx)
    CHECKED_FUNC_CALL(SPUM_CreateContext, &aes128CbcDecryptOps, NULL, SPUM_CRYPT_AUTH_ORDER_NONE, 0UL, NULL, &aes128CbcDecryptCtx)

    /* Destroy the first context. This should return OK */
    CHECKED_FUNC_CALL(SPUM_DestroyContext, aes128CbcEncryptCtx)

    BCM_ClearEvent(SPUMEvent);

    /* Issue one job against the second context */
    CHECKED_FUNC_CALL(SPUM_Update, aes128CbcDecryptCtx, 1024UL, SPUM_CIPHER_TEXT_AES_128_CBC, SPUM_CRYPT_OUT1, &jobId);

    BCM_WaitEvent(SPUMEvent);
    BCM_ClearEvent(SPUMEvent);

    CHECKED_FUNC_CALL(SPUM_GetJobExecResult, jobId, &algExecResult)
    CHECK_COND(BCM_ERR_OK == algExecResult)

    /* Destroy this context */
    CHECKED_FUNC_CALL(SPUM_DestroyContext, aes128CbcDecryptCtx)

    /* Try issuing another update call */
    CHECKED_FUNC_CALL_EXPECT_ERR(BCM_ERR_INVAL_PARAMS, SPUM_Update, aes128CbcDecryptCtx, 1024UL, SPUM_CIPHER_TEXT_AES_128_CBC + 1024UL, SPUM_CRYPT_OUT1 + 1024UL, &jobId);

exit:
    if (0UL != failLine) {
        ret = BCM_ERR_INVAL_STATE;
    } else {
        ret = BCM_ERR_OK;
    }

    return ret;
}

TASK(SpumQT)
{
    int32_t ret;

    CHECKED_FUNC_CALL(MODULE_ResetStateHandler, SPUM_Modules, SPUM_MODULE_INIT_COUNT);
    SPUM_Init();

    CHECKED_FUNC_CALL(SPUM_TestAes)
    CHECKED_FUNC_CALL(SPUM_TestAuth)
    CHECKED_FUNC_CALL(SPUM_TestAesAndAuth)
    CHECKED_FUNC_CALL(SPUM_TestAesAndAuthOneShotAndProf)
    CHECKED_FUNC_CALL(SPUM_TestContextDestroy)

exit:
    spum_qt_result1 = ret;
    BCM_TerminateTask();
}

int32_t BCM_ExecuteAT(uint32_t aIndex)
{
    int32_t ret = BCM_AT_NOT_AVAILABLE;

    if ((1UL == aIndex) && (BCM_AT_EXECUTING != spum_qt_result1)) {
        spum_qt_result1 = BCM_AT_EXECUTING;
        BCM_ActivateTask(SpumQT);
        ret = BCM_ERR_OK;
    }

    return ret;
}

int32_t BCM_GetResultAT(uint32_t aIndex)
{
    int32_t ret = BCM_AT_NOT_AVAILABLE;

    if (1UL == aIndex) {
        ret = spum_qt_result1;
    }

    return ret;
}

void APP_Init()
{
    return;
}

