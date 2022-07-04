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

#include <stdbool.h>
#include <stdlib.h>
#include <string.h>
#include <ee.h>
#include <bcm_utils.h>
#include <bcm_test.h>
#include <bcm_err.h>
#include <bcm_time.h>
#include <osil/bcm_osil.h>

#include <secure_heap.h>
#include "rand_lib.h"

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

void SYS_SLEEP_AlarmCb()
{
    SetEvent(RandQT, SystemEvent0);
}

void Sleep(const uint32_t delayMs)
{
    const uint32_t alarmTicks = ((delayMs * 1000UL)/ SYS_TICK_US) +
        ((0UL == ((delayMs * 1000UL) % SYS_TICK_US))? 0UL : 1UL);

    BCM_SetRelAlarm(SYS_SLEEP_Alarm, alarmTicks, 0);

    (void)BCM_WaitEvent(SystemEvent0);
    (void)BCM_ClearEvent(SystemEvent0);
}

int32_t failLine;
int32_t rand_qt_result1 = BCM_AT_NOT_STARTED;
int32_t rand_qt_result9 = BCM_AT_NOT_STARTED;

static int32_t rand_qt_testIdx;

static int32_t RAND_RunSanityTestGetBits(void)
{
    /*
        Perform basic sanity tests. The quality of RBG will be evaluated with
        statistical test suites
    */
    int32_t ret;

    uint32_t i;
    uint32_t randBits = 0UL;
    uint32_t prevRandBits = 0UL;

    for (i = 0UL; i < 1024UL; i++) {
        RAND_JobIdType jobId = 0UL;
        int32_t retVal = BCM_ERR_OK;
        RAND_OutputType output = {
            .tag = RAND_OUTPUT_TAG_CLIENT_BUFFER,
            .numWords = 1UL,
            .outputBuffer = &randBits
        };

        CHECKED_FUNC_CALL(RAND_GetRandUInt, NULL, NULL, &output, &jobId)

        BCM_WaitEvent(RandEvent);
        BCM_ClearEvent(RandEvent);

        CHECKED_FUNC_CALL(RAND_GetJobExecResult, jobId, &retVal);
        CHECK_COND(BCM_ERR_OK == retVal)

        /*
            The probability of this happening is vanishingly small (1/2^32)
            if our RBG works correctly
        */
        CHECK_COND(prevRandBits != randBits)
        prevRandBits = randBits;
    }

exit:
    if (0 != failLine) {
        ret = BCM_ERR_INVAL_STATE;
    } else {
        ret = BCM_ERR_OK;
    }

    return ret;
}

static int32_t RAND_RunSanityTestGetUint(void)
{
    int32_t ret;

    uint32_t i, j;
    uint32_t limbs0[8UL];
    uint32_t limbs1[8UL];
    uint32_t limbsOut[8UL];

    for (i = 0UL; i < 16UL; i++) {
        for (j = 1UL; j <= 8UL; j++) {
            RAND_JobIdType jobId = 0UL;
            int32_t retVal = BCM_ERR_OK;
            const uint32_t numWords = j;

            /* Generate two sequences of random bits */
            RAND_OutputType outRandBitSeq = {
                .tag = RAND_OUTPUT_TAG_CLIENT_BUFFER,
                .numWords = numWords
            };

            /* The first sequence */
            outRandBitSeq.outputBuffer = limbs0;

            CHECKED_FUNC_CALL(RAND_GetRandUInt, NULL, NULL, &outRandBitSeq, &jobId)

            BCM_WaitEvent(RandEvent);
            BCM_ClearEvent(RandEvent);

            CHECKED_FUNC_CALL(RAND_GetJobExecResult, jobId, &retVal);
            CHECK_COND(BCM_ERR_OK == retVal)

            /* The second sequence */
            outRandBitSeq.outputBuffer = limbs1;

            CHECKED_FUNC_CALL(RAND_GetRandUInt, NULL, NULL, &outRandBitSeq, &jobId)

            BCM_WaitEvent(RandEvent);
            BCM_ClearEvent(RandEvent);

            CHECKED_FUNC_CALL(RAND_GetJobExecResult, jobId, &retVal);
            CHECK_COND(BCM_ERR_OK == retVal)

            /*
                Interpret these bit sequences as numbers, and generate the aLo
                and aHi arguments for the RAND_GetRandUInt API
            */
            const SECUTILS_ConstBigUintType *loPtr;
            const SECUTILS_ConstBigUintType *hiPtr;

            const SECUTILS_ConstBigUintType bigUint0 = {
                .numLimbs = numWords,
                .limbs = limbs0
            };

            const SECUTILS_ConstBigUintType bigUint1 = {
                .numLimbs = numWords,
                .limbs = limbs1
            };

            SECUTILS_BigUintType bigUint2 = {
                .numLimbs = numWords,
                .limbs = limbsOut
            };

            retVal = SECUTILS_BigUintSub(&bigUint0, &bigUint1, &bigUint2);
            if (BCM_ERR_NOMEM == retVal) {
                /* bigNum1 is bigger than bignum0 */
                retVal = SECUTILS_BigUintSub(&bigUint1, &bigUint0, &bigUint2);
                loPtr = &bigUint0;
                hiPtr = &bigUint1;
            } else {
                loPtr = &bigUint1;
                hiPtr = &bigUint0;
            }
            CHECK_COND(BCM_ERR_OK == retVal)

            /*
                Also, make sure that aHi - aLo > 0
            */
            SECUTILS_BigUintOrderingType ord = SECUTILS_BIGUINT_ORDERING_EQ;
            CHECKED_FUNC_CALL(SECUTILS_BigUintCmp,
                SECUTILS_GetConstBigUint(&bigUint2), SECUTILS_ConstZero, &ord)

            if (SECUTILS_BIGUINT_ORDERING_GT == ord) {
                /* We are finally ready to issue the RAND_GetRandUInt API */
                RAND_JobIdType jobId = 0UL;
                int32_t retVal = BCM_ERR_OK;

                const RAND_InputType lo = {
                    .tag = RAND_INPUT_TAG_CLIENT_BUFFER,
                    .numWords = numWords,
                    .inputBuffer = loPtr->limbs
                };

                const RAND_InputType hi = {
                    .tag = RAND_INPUT_TAG_CLIENT_BUFFER,
                    .numWords = numWords,
                    .inputBuffer = hiPtr->limbs
                };

                RAND_OutputType output = {
                    .tag = RAND_OUTPUT_TAG_CLIENT_BUFFER,
                    .numWords = numWords,
                    .outputBuffer = limbsOut
                };

                /* Issue random number generation job */
                CHECKED_FUNC_CALL(RAND_GetRandUInt, &lo, &hi, &output, &jobId);

                BCM_WaitEvent(RandEvent);
                BCM_ClearEvent(RandEvent);

                CHECKED_FUNC_CALL(RAND_GetJobExecResult, jobId, &retVal);
                CHECK_COND(BCM_ERR_OK == retVal)

                /* Validate the output's range */
                CHECKED_FUNC_CALL(SECUTILS_BigUintCmp,
                    SECUTILS_GetConstBigUint(&bigUint2), loPtr, &ord)
                CHECK_COND(SECUTILS_BIGUINT_ORDERING_LT != ord)

                CHECKED_FUNC_CALL(SECUTILS_BigUintCmp,
                    SECUTILS_GetConstBigUint(&bigUint2), hiPtr, &ord)
                CHECK_COND(SECUTILS_BIGUINT_ORDERING_GT != ord)

            }
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

static int32_t RAND_RunSanityTests(void)
{
    int32_t ret;

    CHECKED_FUNC_CALL(RAND_RunSanityTestGetBits)
    CHECKED_FUNC_CALL(RAND_RunSanityTestGetUint)

exit:
    (void) failLine;
    return ret;
}

static int32_t RAND_DumpBitsForExternalStatSuite(void)
{
#if 0
    int32_t ret;
    int32_t failLine = 0;
    RAND_JobIdType jobId = 0UL;
    int32_t retVal = BCM_ERR_OK;
    const uint32_t numIter = 2048UL;
    static uint32_t outputBits[RAND_MAX_NUM_RAND_WORDS];

    uint32_t i;
    for (i = 0UL; i < numIter; i++) {
        uint32_t j;
        RAND_OutputType outRandBitSeq = {
            .tag = RAND_OUTPUT_TAG_CLIENT_BUFFER,
            .numWords = RAND_MAX_NUM_RAND_WORDS,
            .outputBuffer = outputBits
        };

        CHECKED_FUNC_CALL(RAND_GetRandUInt, NULL, NULL, &outRandBitSeq, &jobId)

        BCM_WaitEvent(RandEvent);
        BCM_ClearEvent(RandEvent);

        CHECKED_FUNC_CALL(RAND_GetJobExecResult, jobId, &retVal);
        CHECK_COND(BCM_ERR_OK == retVal)

        /* Write bits to UART */
        for (j = 0UL; j < RAND_MAX_NUM_RAND_WORDS / 8UL; j++) {
            const uint32_t sleepIdx = RAND_MAX_NUM_RAND_WORDS / 16UL;
            uint32_t *const basePtr = &outputBits[8UL * j];

            if (0UL == (j % sleepIdx)) {
                /* Sleep to make sure that all bits are properly flushed out */
                Sleep(100);
            }

            ULOG_INFO("0x%x, 0x%x, 0x%x, 0x%x, 0x%x, 0x%x, 0x%x, 0x%x,\n",
                basePtr[0UL], basePtr[1UL], basePtr[2UL], basePtr[3UL],
                basePtr[4UL], basePtr[5UL], basePtr[6UL], basePtr[7UL]
            );
        }
    }

exit:
    (void) failLine;
    if (BCM_ERR_OK == ret) {
        ULOG_INFO("\n");
    }
    return ret;
#else
    return BCM_ERR_OK;
#endif
}

TASK(RandQT)
{
    RAND_Init();

    if (1UL == rand_qt_testIdx) {
        rand_qt_result1 = RAND_RunSanityTests();
    } else if (9UL == rand_qt_testIdx) {
        rand_qt_result9 = RAND_DumpBitsForExternalStatSuite();
    }

    RAND_Deinit();
    BCM_TerminateTask();
}

int32_t BCM_ExecuteAT(uint32_t aIndex)
{
    int32_t ret = BCM_AT_NOT_AVAILABLE;
    const uint32_t taskIdle = (BCM_AT_EXECUTING != rand_qt_result1) &&
                              (BCM_AT_EXECUTING != rand_qt_result9);

    if (0UL != taskIdle) {
        uint32_t idxValid = 1UL;

        if (1UL == aIndex) {
            rand_qt_result1 = BCM_AT_EXECUTING;
        } else if (9UL == aIndex) {
            rand_qt_result9 = BCM_AT_EXECUTING;
        } else {
            idxValid = 0UL;
        }

        if (0UL != idxValid) {
            rand_qt_testIdx = aIndex;
            BCM_ActivateTask(RandQT);
            ret = BCM_ERR_OK;
        }
    }

    return ret;
}

int32_t BCM_GetResultAT(uint32_t aIndex)
{
    int32_t ret;

    if (1UL == aIndex) {
        ret = rand_qt_result1;
    } else if (9UL == aIndex) {
        ret = rand_qt_result9;
    } else {
        ret = BCM_AT_NOT_AVAILABLE;
    }

    return ret;
}

void APP_Init()
{
    return;
}

