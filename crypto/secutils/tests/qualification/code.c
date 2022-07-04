/*****************************************************************************
 Copyright 2019-2021 Broadcom Limited.  All rights reserved.

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

#include <stdlib.h>
#include <string.h>
#include <ee.h>
#include <bcm_utils.h>
#include <bcm_test.h>
#include <bcm_err.h>
#include <osil/bcm_osil.h>
#include <secutils.h>

#define CHECKED_FUNC_CALL_EXPECT_ERR(err, fn, ...)                      \
    ret = (fn)(__VA_ARGS__);                                            \
    if (err != ret) {                                                   \
        failLine = __LINE__;                                            \
        goto exit;                                                      \
    } else {                                                            \
        ret = BCM_ERR_OK;                                               \
    }

#define CHECKED_FUNC_CALL(fn, ...)                                      \
    CHECKED_FUNC_CALL_EXPECT_ERR(BCM_ERR_OK, fn, __VA_ARGS__)

#define CHECK_COND(cond)                                                \
    if (!(cond)) {                                                      \
        ret = BCM_ERR_INVAL_STATE;                                      \
        failLine = __LINE__;                                            \
        goto exit;                                                      \
    }

int32_t failLine;
static int32_t secutils_qt_result1 = BCM_AT_NOT_STARTED;

static int32_t SECUTILS_RunPosImportBigUintTests(void)
{
    #define NUM_TEST_WORDS (4UL)

    int32_t ret;
    const uint32_t testWords[NUM_TEST_WORDS] = {0xA0A1A2A3UL, 0xB0B1B2B3UL, 0xC0C1C2C3UL, 0xD0D1D2D3UL};
    uint32_t testWordsOut[NUM_TEST_WORDS];
    SECUTILS_BigUintType dst = { .numLimbs = NUM_TEST_WORDS, .limbs = testWordsOut };

    failLine = 0;

    #define POS_TEST_BIGUINT_IMPORT(endianness, digit_order, ...)                                       \
    {                                                                                                   \
        const uint32_t expectedOutput[NUM_TEST_WORDS] = {__VA_ARGS__};                                  \
        CHECKED_FUNC_CALL(SECUTILS_ImportBigUint, SECUTILS_DIGIT_ENDIANNESS_ ## endianness,             \
            SECUTILS_DIGIT_ORDER_ ## digit_order, NUM_TEST_WORDS, testWords, &dst);                     \
        CHECK_COND(0UL == memcmp(expectedOutput, testWordsOut, NUM_TEST_WORDS * sizeof(uint32_t)));     \
    }

    POS_TEST_BIGUINT_IMPORT(LITTLE, LEAST_SIGNIFICANT, 0xA0A1A2A3UL, 0xB0B1B2B3UL, 0xC0C1C2C3UL, 0xD0D1D2D3UL)
    POS_TEST_BIGUINT_IMPORT(LITTLE, MOST_SIGNIFICANT,  0xD0D1D2D3UL, 0xC0C1C2C3UL, 0xB0B1B2B3UL, 0xA0A1A2A3UL)
    POS_TEST_BIGUINT_IMPORT(BIG,    LEAST_SIGNIFICANT, 0xA3A2A1A0UL, 0xB3B2B1B0UL, 0xC3C2C1C0UL, 0xD3D2D1D0UL)
    POS_TEST_BIGUINT_IMPORT(BIG,    MOST_SIGNIFICANT,  0xD3D2D1D0UL, 0xC3C2C1C0UL, 0xB3B2B1B0UL, 0xA3A2A1A0UL)
    ret = BCM_ERR_OK;

exit:
    if (0 != failLine) {
        ret = BCM_ERR_INVAL_STATE;
    } else {
        ret = BCM_ERR_OK;
    }

    return ret;

    #undef POS_TEST_BIGUINT_IMPORT
    #undef NUM_TEST_WORDS
}

static int32_t SECUTILS_RunNegImportBigUintTests(void)
{
    #define NUM_TEST_WORDS (4UL)

    int32_t ret;
    const uint32_t testWords[NUM_TEST_WORDS] = {0xA0A1A2A3UL, 0xB0B1B2B3UL, 0xC0C1C2C3UL, 0xD0D1D2D3UL};
    uint32_t testWordsOut[NUM_TEST_WORDS];
    SECUTILS_BigUintType dst = { .numLimbs = NUM_TEST_WORDS, .limbs = testWordsOut };

    failLine = 0;

    /* Invalid endianness */
    CHECKED_FUNC_CALL_EXPECT_ERR(BCM_ERR_INVAL_PARAMS, SECUTILS_ImportBigUint, 3UL, SECUTILS_DIGIT_ORDER_LEAST_SIGNIFICANT,
        NUM_TEST_WORDS, testWords, &dst);

    /* Invalid digit order */
    CHECKED_FUNC_CALL_EXPECT_ERR(BCM_ERR_INVAL_PARAMS, SECUTILS_ImportBigUint, SECUTILS_DIGIT_ENDIANNESS_LITTLE, 3UL,
        NUM_TEST_WORDS, testWords, &dst);

    /* Invalid num src words */
    CHECKED_FUNC_CALL_EXPECT_ERR(BCM_ERR_INVAL_PARAMS, SECUTILS_ImportBigUint, SECUTILS_DIGIT_ENDIANNESS_LITTLE, SECUTILS_DIGIT_ORDER_LEAST_SIGNIFICANT,
        0UL, testWords, &dst);

    /* Invalid src buffer */
    CHECKED_FUNC_CALL_EXPECT_ERR(BCM_ERR_INVAL_PARAMS, SECUTILS_ImportBigUint, SECUTILS_DIGIT_ENDIANNESS_LITTLE, SECUTILS_DIGIT_ORDER_LEAST_SIGNIFICANT,
        NUM_TEST_WORDS, NULL, &dst);

    /* Invalid dst state */
    dst.numLimbs = 0UL;
    CHECKED_FUNC_CALL_EXPECT_ERR(BCM_ERR_INVAL_PARAMS, SECUTILS_ImportBigUint, SECUTILS_DIGIT_ENDIANNESS_LITTLE, SECUTILS_DIGIT_ORDER_LEAST_SIGNIFICANT,
        NUM_TEST_WORDS, testWords, &dst);

    dst.numLimbs = 4UL;
    dst.limbs = NULL;
    CHECKED_FUNC_CALL_EXPECT_ERR(BCM_ERR_INVAL_PARAMS, SECUTILS_ImportBigUint, SECUTILS_DIGIT_ENDIANNESS_LITTLE, SECUTILS_DIGIT_ORDER_LEAST_SIGNIFICANT,
        NUM_TEST_WORDS, testWords, &dst);

    ret = BCM_ERR_OK;

exit:
    if (0 != failLine) {
        ret = BCM_ERR_INVAL_STATE;
    } else {
        ret = BCM_ERR_OK;
    }

    return ret;

    #undef NUM_TEST_WORDS
}

static int32_t SECUTILS_RunBigUintCmpTests(void)
{
    int32_t ret;
    uint32_t limbs0[3UL] = {0UL, 0UL, 0UL};
    uint32_t limbs1[5UL] = {0UL, 0UL, 0UL, 0UL, 0UL};
    SECUTILS_BigUintOrderingType res = SECUTILS_BIGUINT_ORDERING_EQ;
    SECUTILS_BigUintType bigUint0 = { .numLimbs = 0UL, .limbs = limbs0 };
    SECUTILS_BigUintType bigUint1 = { .numLimbs = 0UL, .limbs = limbs1 };

    failLine = 0;

    /* Test for equality: Case1 */
    bigUint0.numLimbs = 0UL;
    bigUint1.numLimbs = 2UL;
    limbs1[0UL] = 0UL;
    limbs1[1UL] = 0UL;

    CHECKED_FUNC_CALL(SECUTILS_BigUintCmp,
        SECUTILS_GetConstBigUint(&bigUint0),
        SECUTILS_GetConstBigUint(&bigUint1),
        &res
    );
    CHECK_COND(SECUTILS_BIGUINT_ORDERING_EQ == res)

    /* Test for equality: Case2 */
    bigUint0.numLimbs = 3UL;
    bigUint1.numLimbs = 4UL;

    limbs0[0UL] = 0xFEFE00A0UL; limbs0[1UL] = 0xEA12C7A0UL; limbs0[2UL] = 0xA0BC1234UL;
    limbs1[0UL] = 0xFEFE00A0UL; limbs1[1UL] = 0xEA12C7A0UL; limbs1[2UL] = 0xA0BC1234UL;

    CHECKED_FUNC_CALL(SECUTILS_BigUintCmp,
        SECUTILS_GetConstBigUint(&bigUint0),
        SECUTILS_GetConstBigUint(&bigUint1),
        &res
    );
    CHECK_COND(SECUTILS_BIGUINT_ORDERING_EQ == res)

    /* Test GT */
    bigUint0.numLimbs = 3UL;
    bigUint1.numLimbs = 2UL;

    limbs0[0UL] = 0xFEFE00A0UL; limbs0[1UL] = 0xEA12C7A0UL; limbs0[2UL] = 0xA0BC1234UL;
    limbs1[0UL] = 0xFEFE00A0UL; limbs1[1UL] = 0xEA12C7A0UL;

    CHECKED_FUNC_CALL(SECUTILS_BigUintCmp,
        SECUTILS_GetConstBigUint(&bigUint0),
        SECUTILS_GetConstBigUint(&bigUint1),
        &res
    );
    CHECK_COND(SECUTILS_BIGUINT_ORDERING_GT == res)

    /* Test LT */
    bigUint0.numLimbs = 3UL;
    bigUint1.numLimbs = 3UL;

    limbs0[0UL] = 0xFEFE00A0UL; limbs0[1UL] = 0xEA12C7A0UL; limbs0[2UL] = 0xA0BC1234UL;
    limbs1[0UL] = 0xFEFE00A0UL; limbs1[1UL] = 0xEA12C7A0UL; limbs1[2UL] = 0xFEBC1234UL;

    CHECKED_FUNC_CALL(SECUTILS_BigUintCmp,
        SECUTILS_GetConstBigUint(&bigUint0),
        SECUTILS_GetConstBigUint(&bigUint1),
        &res
    );
    CHECK_COND(SECUTILS_BIGUINT_ORDERING_LT == res)

    /* A few negative tests */
    CHECKED_FUNC_CALL_EXPECT_ERR(BCM_ERR_INVAL_PARAMS, SECUTILS_BigUintCmp, NULL, SECUTILS_GetConstBigUint(&bigUint1), &res)
    CHECKED_FUNC_CALL_EXPECT_ERR(BCM_ERR_INVAL_PARAMS, SECUTILS_BigUintCmp, SECUTILS_GetConstBigUint(&bigUint0), NULL, &res)
    CHECKED_FUNC_CALL_EXPECT_ERR(BCM_ERR_INVAL_PARAMS, SECUTILS_BigUintCmp,
        SECUTILS_GetConstBigUint(&bigUint0),
        SECUTILS_GetConstBigUint(&bigUint1),
        NULL);

exit:
    if (0 != failLine) {
        ret = BCM_ERR_INVAL_STATE;
    } else {
        ret = BCM_ERR_OK;
    }

    return ret;
}

static int32_t SECUTILS_RunNInvMod32Tests(void)
{
    int32_t ret;
    uint32_t res = 0UL;

    failLine = 0;

    const SECUTILS_ConstBigUintType N1 = {
        .numLimbs = 2UL,
        .limbs = (const uint32_t[]) { 0x3456F31EUL, 0xA0B3421AUL }
    };

    const SECUTILS_ConstBigUintType N2 = {
        .numLimbs = 2UL,
        .limbs = (const uint32_t[]) { 0x3456F31FUL, 0xA0B3421AUL }
    };
    const uint32_t posN2Inv2pow32 = 0x9D6EC8DFUL;
    const uint32_t negN2Inv2pow32 = 0x62913721UL;

    CHECKED_FUNC_CALL_EXPECT_ERR(BCM_ERR_INVAL_PARAMS, SECUTILS_ComputeNInvMod2Pow32, &N1, 0UL, &res);

    CHECKED_FUNC_CALL(SECUTILS_ComputeNInvMod2Pow32, &N2, 0UL, &res);
    CHECK_COND(posN2Inv2pow32 == res);

    CHECKED_FUNC_CALL(SECUTILS_ComputeNInvMod2Pow32, &N2, 1UL, &res);
    CHECK_COND(negN2Inv2pow32 == res);

exit:
    if (0 != failLine) {
        ret = BCM_ERR_INVAL_STATE;
    } else {
        ret = BCM_ERR_OK;
    }

    return ret;
}

static int32_t SECUTILS_RunMontInitTests(void)
{
    int32_t ret;
    uint32_t rLimbs[4UL];
    uint32_t rrLimbs[5UL];
    SECUTILS_BigUintMontCtxType montCtx;

    failLine = 0;

    SECUTILS_ConstBigUintType N1 = {
        .numLimbs = 3UL,
        .limbs = (const uint32_t[]) { 0x3456F31FUL, 0xF3A01234UL, 0xA0B3421AUL }
    };
    const uint32_t rModNExpected1[]  = {0xCBA90CE1UL, 0x0C5FEDCBUL, 0x5F4CBDE5UL, 0x00000000UL};
    const uint32_t rrModNExpected1[] = {0x5B52FACDUL, 0x5C2FD992UL, 0x3B0C881EUL, 0x00000000UL, 0x00000000UL};

    SECUTILS_ConstBigUintType N2 = {
        .numLimbs = 2UL,
        .limbs = (const uint32_t[]) { 0x3456F31FUL, 0x21AUL }
    };
    const uint32_t rModNExpected2[]  = {0xDEF58F71UL, 0x000001FCUL, 0x00000000UL, 0x00000000UL};
    const uint32_t rrModNExpected2[] = {0x32E21D74UL, 0x0000001EUL, 0x00000000UL, 0x00000000UL, 0x00000000UL};

    CHECKED_FUNC_CALL(SECUTILS_BigUintComputeMontCtx, &N1, rLimbs, 4UL,
        rrLimbs, 5UL, NULL, 0UL, &montCtx);

    CHECK_COND(montCtx.N.numLimbs == 3UL);
    CHECK_COND(montCtx.N.limbs == N1.limbs);
    CHECK_COND(montCtx.rModN.numLimbs == 3UL);
    CHECK_COND(montCtx.rModN.limbs == rLimbs);
    CHECK_COND(montCtx.rrModN.numLimbs == 3UL);
    CHECK_COND(montCtx.rrModN.limbs == rrLimbs);

    CHECKED_FUNC_CALL(memcmp, rLimbs, rModNExpected1, 4UL * 4UL);
    CHECKED_FUNC_CALL(memcmp, rrLimbs, rrModNExpected1, 4UL * 5UL);

    CHECKED_FUNC_CALL(SECUTILS_BigUintComputeMontCtx, &N2, rLimbs, 4UL,
        rrLimbs, 5UL, NULL, 0UL, &montCtx);

    CHECK_COND(montCtx.N.numLimbs == 2UL);
    CHECK_COND(montCtx.N.limbs == N2.limbs);
    CHECK_COND(montCtx.rModN.numLimbs == 2UL);
    CHECK_COND(montCtx.rModN.limbs == rLimbs);
    CHECK_COND(montCtx.rrModN.numLimbs == 2UL);
    CHECK_COND(montCtx.rrModN.limbs == rrLimbs);

    CHECKED_FUNC_CALL(memcmp, rLimbs, rModNExpected2, 4UL * 4UL);
    CHECKED_FUNC_CALL(memcmp, rrLimbs, rrModNExpected2, 4UL * 5UL);

exit:
    if (0 != failLine) {
        ret = BCM_ERR_INVAL_STATE;
    } else {
        ret = BCM_ERR_OK;
    }

    return ret;
}

static int32_t SECUTILS_RunMontXformAndReduceTests(void)
{
    int32_t ret;
    uint32_t rLimbs[4UL];
    uint32_t rrLimbs[5UL];
    uint32_t scratchLimbs[8UL];
    SECUTILS_BigUintMontCtxType montCtx;

    failLine = 0;

    SECUTILS_ConstBigUintType N1 = {
        .numLimbs = 3UL,
        .limbs = (const uint32_t[]) { 0x3456F31FUL, 0xF3A01234UL, 0xA0B3421AUL }
    };

    SECUTILS_ConstBigUintType N2 = {
        .numLimbs = 2UL,
        .limbs = (const uint32_t[]) { 0x3456F31FUL, 0x21AUL }
    };

    SECUTILS_ConstBigUintType X1 = {
        .numLimbs = 2UL,
        .limbs = (const uint32_t[]) { 0xA123BA1FUL, 0xF3A01234UL }
    };
    const uint32_t X1HatExpected[] = { 0xDC6A8A19UL, 0x894F0EEFUL, 0x78E1B071UL, 0x00000000UL };

    SECUTILS_ConstBigUintType X2 = {
        .numLimbs = 3UL,
        .limbs = (const uint32_t[]) { 0x3456F31FUL, 0xF3A01234UL, 0x80B3421AUL }
    };
    const uint32_t X2HatExpected[] = { 0x48363BD2UL, 0x4FD60BA1UL, 0x34E1A7C6UL, 0x00000000UL };

    SECUTILS_ConstBigUintType X3 = {
        .numLimbs = 2UL,
        .limbs = (const uint32_t[]) { 0x3456F31FUL, 0xAUL }
    };
    const uint32_t X3HatExpected[] = { 0x95e20888UL, 0x00000003UL, 0x00000000UL, 0x00000000UL };

    uint32_t XOutLimbs[4UL];
    SECUTILS_BigUintType XOut = {
        .numLimbs = 4UL,
        .limbs = XOutLimbs,
    };

    /* Transform and reduce against N1 */
    CHECKED_FUNC_CALL(SECUTILS_BigUintComputeMontCtx, &N1, rLimbs, 4UL,
        rrLimbs, 5UL, NULL, 0UL, &montCtx);

    CHECKED_FUNC_CALL(SECUTILS_BigUintMontXform, &montCtx, scratchLimbs, 8UL,
        &X1, &XOut);
    CHECKED_FUNC_CALL(memcmp, XOutLimbs, X1HatExpected, 4UL * 4UL);

    CHECKED_FUNC_CALL(SECUTILS_BigUintMontReduce, &montCtx, scratchLimbs, 8UL,
        SECUTILS_GetConstBigUint(&XOut), &XOut);
    CHECKED_FUNC_CALL(memcmp, XOutLimbs, X1.limbs, 4UL * 2UL);
    CHECK_COND((0UL == XOutLimbs[2UL]) && (0UL == XOutLimbs[3UL]));



    CHECKED_FUNC_CALL(SECUTILS_BigUintMontXform, &montCtx, scratchLimbs, 8UL,
        &X2, &XOut);
    CHECKED_FUNC_CALL(memcmp, XOutLimbs, X2HatExpected, 4UL * 4UL);

    CHECKED_FUNC_CALL(SECUTILS_BigUintMontReduce, &montCtx, scratchLimbs, 8UL,
        SECUTILS_GetConstBigUint(&XOut), &XOut);
    CHECKED_FUNC_CALL(memcmp, XOutLimbs, X2.limbs, 4UL * 3UL);
    CHECK_COND(0UL == XOutLimbs[3UL]);



    /* Transform and reduce against N2 */
    CHECKED_FUNC_CALL(SECUTILS_BigUintComputeMontCtx, &N2, rLimbs, 4UL,
        rrLimbs, 5UL, NULL, 0UL, &montCtx);

    CHECKED_FUNC_CALL(SECUTILS_BigUintMontXform, &montCtx, scratchLimbs, 8UL,
        &X3, &XOut);
    CHECKED_FUNC_CALL(memcmp, XOutLimbs, X3HatExpected, 4UL * 4UL);

    CHECKED_FUNC_CALL(SECUTILS_BigUintMontReduce, &montCtx, scratchLimbs, 8UL,
        SECUTILS_GetConstBigUint(&XOut), &XOut);
    CHECKED_FUNC_CALL(memcmp, XOutLimbs, X3.limbs, 4UL * 2UL);
    CHECK_COND((0UL == XOutLimbs[2UL]) && (0UL == XOutLimbs[3UL]));



    /* Test in-place xform */
    XOutLimbs[0UL] = X3.limbs[0UL];
    XOutLimbs[1UL] = X3.limbs[1UL];
    XOutLimbs[2UL] = 0UL;
    XOutLimbs[3UL] = 0UL;

    CHECKED_FUNC_CALL(SECUTILS_BigUintMontXform, &montCtx, scratchLimbs, 8UL,
        SECUTILS_GetConstBigUint(&XOut), &XOut);
    CHECKED_FUNC_CALL(memcmp, XOutLimbs, X3HatExpected, 4UL * 4UL);

exit:
    if (0 != failLine) {
        ret = BCM_ERR_INVAL_STATE;
    } else {
        ret = BCM_ERR_OK;
    }

    return ret;
}

static int32_t SECUTILS_RunMontExpTests(void)
{
    int32_t ret;
    uint32_t rLimbs[4UL];
    uint32_t rrLimbs[5UL];
    uint32_t scratchLimbs[8UL];
    SECUTILS_BigUintMontCtxType montCtx;

    failLine = 0;

    const SECUTILS_ConstBigUintType N1 = {
        .numLimbs = 3UL,
        .limbs = (const uint32_t[]) { 0x3456F31FUL, 0xF3A01234UL, 0xA0B3421AUL }
    };

    const SECUTILS_ConstBigUintType N2 = {
        .numLimbs = 2UL,
        .limbs = (const uint32_t[]) { 0x3456F31FUL, 0x21AUL }
    };

    const SECUTILS_ConstBigUintType X1 = {
        .numLimbs = 2UL,
        .limbs = (const uint32_t[]) { 0xA123BA1FUL, 0xF3A01234UL }
    };

    const SECUTILS_ConstBigUintType exp1 = {
        .numLimbs = 1UL,
        .limbs = (const uint32_t[]) { 0UL }
    };

    const uint32_t X1Exp1ModN1Expected[] = { 0x00000001UL, 0x00000000UL, 0x00000000UL, 0x00000000UL };

    const SECUTILS_ConstBigUintType X2 = {
        .numLimbs = 3UL,
        .limbs = (const uint32_t[]) { 0x3456F31FUL, 0xF3A01234UL, 0x80B3421AUL }
    };

    const SECUTILS_ConstBigUintType exp2 = {
        .numLimbs = 1UL,
        .limbs = (const uint32_t[]) { 0x11UL }
    };
    const uint32_t X2Exp2ModN1Expected[] = { 0x638C4A2AUL, 0x1E8B0C9CUL, 0x4D373E1BUL, 0x00000000UL };

    const SECUTILS_ConstBigUintType X3 = {
        .numLimbs = 2UL,
        .limbs = (const uint32_t[]) { 0x3456F31FUL, 0xAUL }
    };

    const SECUTILS_ConstBigUintType exp3 = {
        .numLimbs = 1UL,
        .limbs = (const uint32_t[]) { 0xFUL }
    };
    const uint32_t X3Exp3ModN2Expected[] = {0x02815F9BUL, 0x000000A7UL, 0x00000000UL, 0x00000000UL};

    uint32_t XOutLimbs[4UL];
    SECUTILS_BigUintType XOut = {
        .numLimbs = 4UL,
        .limbs = XOutLimbs,
    };

    uint32_t XTempLimbs[4UL];
    SECUTILS_BigUintType XTemp = {
        .numLimbs = 4UL,
        .limbs = XTempLimbs,
    };

    /* Transform and reduce against N1 */
    CHECKED_FUNC_CALL(SECUTILS_BigUintComputeMontCtx, &N1, rLimbs, 4UL,
        rrLimbs, 5UL, NULL, 0UL, &montCtx);

    CHECKED_FUNC_CALL(SECUTILS_BigUintMontXform, &montCtx, scratchLimbs, 8UL,
        &X1, &XTemp);
    CHECKED_FUNC_CALL(SECUTILS_BigUintMontExp, &montCtx, scratchLimbs, 8UL,
        SECUTILS_GetConstBigUint(&XTemp), &exp1, &XOut);
    CHECKED_FUNC_CALL(SECUTILS_BigUintMontReduce, &montCtx, scratchLimbs, 8UL,
        SECUTILS_GetConstBigUint(&XOut), &XOut);
    CHECKED_FUNC_CALL(memcmp, XOutLimbs, X1Exp1ModN1Expected, 4UL * 4UL);

    CHECKED_FUNC_CALL(SECUTILS_BigUintMontXform, &montCtx, scratchLimbs, 8UL,
        &X2, &XTemp);
    CHECKED_FUNC_CALL(SECUTILS_BigUintMontExp, &montCtx, scratchLimbs, 8UL,
        SECUTILS_GetConstBigUint(&XTemp), &exp2, &XOut);
    CHECKED_FUNC_CALL(SECUTILS_BigUintMontReduce, &montCtx, scratchLimbs, 8UL,
        SECUTILS_GetConstBigUint(&XOut), &XOut);
    CHECKED_FUNC_CALL(memcmp, XOutLimbs, X2Exp2ModN1Expected, 4UL * 4UL);


    CHECKED_FUNC_CALL(SECUTILS_BigUintComputeMontCtx, &N2, rLimbs, 4UL,
        rrLimbs, 5UL, NULL, 0UL, &montCtx);

    CHECKED_FUNC_CALL(SECUTILS_BigUintMontXform, &montCtx, scratchLimbs, 8UL,
        &X3, &XTemp);
    CHECKED_FUNC_CALL(SECUTILS_BigUintMontExp, &montCtx, scratchLimbs, 8UL,
        SECUTILS_GetConstBigUint(&XTemp), &exp3, &XOut);
    CHECKED_FUNC_CALL(SECUTILS_BigUintMontReduce, &montCtx, scratchLimbs, 8UL,
        SECUTILS_GetConstBigUint(&XOut), &XOut);
    CHECKED_FUNC_CALL(memcmp, XOutLimbs, X3Exp3ModN2Expected, 4UL * 4UL);


exit:
    if (0 != failLine) {
        ret = BCM_ERR_INVAL_STATE;
    } else {
        ret = BCM_ERR_OK;
    }

    return ret;
}

static int32_t SECUTILS_RunBigUintAddSubTests(void)
{
    int32_t ret;
    uint32_t opOutLimbs[16UL];
    SECUTILS_BigUintOrderingType ord = SECUTILS_BIGUINT_ORDERING_EQ;

    failLine = 0;

    const SECUTILS_ConstBigUintType b0 = {
        .numLimbs = 3,
        .limbs = (const uint32_t[]) { 0xFFFFFFFFUL, 0xFFFFFFFFUL, 0x00000000UL }
    };

    const SECUTILS_ConstBigUintType b1 = {
        .numLimbs = 2,
        .limbs = (const uint32_t[]) { 0x00000001UL, 0x00000000UL }
    };

    const SECUTILS_ConstBigUintType b2 = {
        .numLimbs = 3,
        .limbs = (const uint32_t[]) { 0x00000000UL, 0x00000000UL, 0x00000001UL }
    };

    const SECUTILS_ConstBigUintType b3 = {
        .numLimbs = 3,
        .limbs = (const uint32_t[]) { 0xFFFFFFFEUL, 0xFFFFFFFFUL, 0x00000000UL }
    };

    const SECUTILS_ConstBigUintType b4 = {
        .numLimbs = 0,
        .limbs = NULL
    };

    const SECUTILS_ConstBigUintType b5 = {
        .numLimbs = 5UL,
        .limbs = NULL
    };

    SECUTILS_BigUintType opOut = {
        .numLimbs = 16UL,
        .limbs = opOutLimbs
    };

    /* Addition test 1 */
    CHECKED_FUNC_CALL(SECUTILS_BigUintAdd, &b0, &b1, &opOut)
    CHECKED_FUNC_CALL(SECUTILS_BigUintCmp,
        SECUTILS_GetConstBigUint(&opOut),
        &b2, &ord
    )
    CHECK_COND(ord == SECUTILS_BIGUINT_ORDERING_EQ)

    /* Addition test 2 */
    CHECKED_FUNC_CALL(SECUTILS_BigUintAdd, &b0, &b4, &opOut)
    CHECKED_FUNC_CALL(SECUTILS_BigUintCmp,
        SECUTILS_GetConstBigUint(&opOut),
        &b0, &ord
    )
    CHECK_COND(ord == SECUTILS_BIGUINT_ORDERING_EQ)

    /* Addition overflow test */
    opOut.numLimbs = 2UL;
    CHECKED_FUNC_CALL_EXPECT_ERR(BCM_ERR_NOMEM, SECUTILS_BigUintAdd, &b0, &b1, &opOut)
    opOut.numLimbs = 16UL;

    /* Subtraction test 1 */
    CHECKED_FUNC_CALL(SECUTILS_BigUintSub, &b0, &b1, &opOut)
    CHECKED_FUNC_CALL(SECUTILS_BigUintCmp,
        SECUTILS_GetConstBigUint(&opOut),
        &b3, &ord
    )
    CHECK_COND(ord == SECUTILS_BIGUINT_ORDERING_EQ)

    /* Subtraction test 2 */
    CHECKED_FUNC_CALL(SECUTILS_BigUintSub, &b2, &b1, &opOut)
    CHECKED_FUNC_CALL(SECUTILS_BigUintCmp,
        SECUTILS_GetConstBigUint(&opOut),
        &b0, &ord
    )
    CHECK_COND(ord == SECUTILS_BIGUINT_ORDERING_EQ)

    /* Subtraction test 3 */
    CHECKED_FUNC_CALL(SECUTILS_BigUintSub, &b2, &b4, &opOut)
    CHECKED_FUNC_CALL(SECUTILS_BigUintCmp,
        SECUTILS_GetConstBigUint(&opOut),
        &b2, &ord
    )
    CHECK_COND(ord == SECUTILS_BIGUINT_ORDERING_EQ)

    /* Subtraction test 4 */
    opOut.numLimbs = 1UL;
    CHECKED_FUNC_CALL(SECUTILS_BigUintSub, &b0, &b3, &opOut)
    CHECKED_FUNC_CALL(SECUTILS_BigUintCmp,
        SECUTILS_GetConstBigUint(&opOut),
        &b1, &ord
    )
    CHECK_COND(ord == SECUTILS_BIGUINT_ORDERING_EQ)
    opOut.numLimbs = 16UL;

    /* Subtraction underflow 1 */
    CHECKED_FUNC_CALL_EXPECT_ERR(BCM_ERR_NOMEM, SECUTILS_BigUintSub, &b1, &b0, &opOut)

    /* Subtraction underflow 2 */
    opOut.numLimbs = 1UL;
    CHECKED_FUNC_CALL_EXPECT_ERR(BCM_ERR_NOMEM, SECUTILS_BigUintSub, &b2, &b1, &opOut)
    opOut.numLimbs = 16UL;

    /* A negative test */
    CHECKED_FUNC_CALL_EXPECT_ERR(BCM_ERR_INVAL_PARAMS, SECUTILS_BigUintSub, &b1, &b5, &opOut)

exit:
    if (0 != failLine) {
        ret = BCM_ERR_INVAL_STATE;
    } else {
        ret = BCM_ERR_OK;
    }

    return ret;
}

static int32_t SECUTILS_RunOnesComplementTests(void)
{
    int32_t ret;
    uint32_t opOutLimbs[16UL];
    SECUTILS_BigUintOrderingType ord = SECUTILS_BIGUINT_ORDERING_EQ;

    failLine = 0;

    const SECUTILS_ConstBigUintType b0 = {
        .numLimbs = 3,
        .limbs = (const uint32_t[]) { 0xFFFFFFFFUL, 0xFFFFFFFFUL, 0x00000000UL }
    };

    const SECUTILS_ConstBigUintType b1 = {
        .numLimbs = 4,
        .limbs = (const uint32_t[]) { 0x00000000UL, 0x00000000UL, 0xFFFFFFFFUL, 0xFFFFFFFFUL }
    };

    const SECUTILS_ConstBigUintType b2 = {
        .numLimbs = 0,
        .limbs = NULL
    };

    const SECUTILS_ConstBigUintType b3 = {
        .numLimbs = 4,
        .limbs = (const uint32_t[]) { 0xFFFFFFFFUL, 0xFFFFFFFFUL, 0xFFFFFFFFUL, 0xFFFFFFFFUL }
    };

    SECUTILS_BigUintType opOut = {
        .numLimbs = 4UL,
        .limbs = opOutLimbs
    };

    /* Test 0 */
    CHECKED_FUNC_CALL(SECUTILS_BigUintOnesComplement, &b0, &opOut)
    CHECKED_FUNC_CALL(SECUTILS_BigUintCmp,
        SECUTILS_GetConstBigUint(&opOut),
        &b1, &ord
    )
    CHECK_COND(ord == SECUTILS_BIGUINT_ORDERING_EQ)

    /* Test 1 */
    CHECKED_FUNC_CALL(SECUTILS_BigUintOnesComplement, &b2, &opOut)
    CHECKED_FUNC_CALL(SECUTILS_BigUintCmp,
        SECUTILS_GetConstBigUint(&opOut),
        &b3, &ord
    )
    CHECK_COND(ord == SECUTILS_BIGUINT_ORDERING_EQ)

exit:
    if (0 != failLine) {
        ret = BCM_ERR_INVAL_STATE;
    } else {
        ret = BCM_ERR_OK;
    }

    return ret;
}

static int32_t SECUTILS_RunGetMSWordAndBitIdxTests(void)
{
    int32_t ret;
    uint32_t msWordIdx = 0UL;
    uint32_t msBitIdx = 0UL;

    failLine = 0;

    const SECUTILS_ConstBigUintType b0 = {
        .numLimbs = 3,
        .limbs = (const uint32_t[]) { 0xFFFFFFFFUL, 0xFFFFFFFFUL, 0x00000000UL }
    };

    const SECUTILS_ConstBigUintType b1 = {
        .numLimbs = 2,
        .limbs = (const uint32_t[]) { 0x00000001UL, 0x00000000UL }
    };

    const SECUTILS_ConstBigUintType b2 = {
        .numLimbs = 3,
        .limbs = (const uint32_t[]) { 0x00000000UL, 0x00000000UL, 0x0000000FUL }
    };

    const SECUTILS_ConstBigUintType b3 = {
        .numLimbs = 0,
        .limbs = NULL
    };

    CHECKED_FUNC_CALL(SECUTILS_BigUintGetMSWordAndBitIdx, &b0, &msWordIdx, &msBitIdx)
    CHECK_COND(1UL == msWordIdx)
    CHECK_COND(31UL == msBitIdx)

    CHECKED_FUNC_CALL(SECUTILS_BigUintGetMSWordAndBitIdx, &b1, &msWordIdx, &msBitIdx)
    CHECK_COND(0UL == msWordIdx)
    CHECK_COND(0UL == msBitIdx)

    CHECKED_FUNC_CALL(SECUTILS_BigUintGetMSWordAndBitIdx, &b2, &msWordIdx, &msBitIdx)
    CHECK_COND(2UL == msWordIdx)
    CHECK_COND(3UL == msBitIdx)

    CHECKED_FUNC_CALL(SECUTILS_BigUintGetMSWordAndBitIdx, &b3, &msWordIdx, &msBitIdx)
    CHECK_COND(0UL == msWordIdx)
    CHECK_COND(0UL == msBitIdx)

exit:
    if (0 != failLine) {
        ret = BCM_ERR_INVAL_STATE;
    } else {
        ret = BCM_ERR_OK;
    }

    return ret;
}

TASK(SecutilsQT)
{
    int32_t ret;
    int32_t failLine = 0;

    CHECKED_FUNC_CALL(SECUTILS_RunPosImportBigUintTests)
    CHECKED_FUNC_CALL(SECUTILS_RunNegImportBigUintTests)
    CHECKED_FUNC_CALL(SECUTILS_RunBigUintCmpTests)
    CHECKED_FUNC_CALL(SECUTILS_RunNInvMod32Tests)
    CHECKED_FUNC_CALL(SECUTILS_RunMontInitTests)
    CHECKED_FUNC_CALL(SECUTILS_RunMontXformAndReduceTests)
    CHECKED_FUNC_CALL(SECUTILS_RunMontExpTests)
    CHECKED_FUNC_CALL(SECUTILS_RunBigUintAddSubTests)
    CHECKED_FUNC_CALL(SECUTILS_RunOnesComplementTests)
    CHECKED_FUNC_CALL(SECUTILS_RunGetMSWordAndBitIdxTests)

exit:
    (void) failLine;
    secutils_qt_result1 = ret;
    BCM_TerminateTask();
}

int32_t BCM_ExecuteAT(uint32_t aIndex)
{
    int32_t ret = BCM_AT_NOT_AVAILABLE;

    if ((1UL == aIndex) && (BCM_AT_EXECUTING != secutils_qt_result1)) {
        secutils_qt_result1 = BCM_AT_EXECUTING;
        BCM_ActivateTask(SecutilsQT);
        ret = BCM_ERR_OK;
    }

    return ret;
}

int32_t BCM_GetResultAT(uint32_t aIndex)
{
    int32_t ret = BCM_AT_NOT_AVAILABLE;

    if (1UL == aIndex) {
        ret = secutils_qt_result1;
    }

    return ret;
}

void APP_Init()
{
    return;
}

