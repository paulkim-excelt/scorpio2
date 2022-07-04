/*****************************************************************************
 Copyright 2021 Broadcom Limited.  All rights reserved.

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
    WARRANTIES, EITHER EXPRESS, IPPLIED, STATUTORY, OR OTHERWISE, WITH RESPECT
    TO THE SOFTWARE.  BROADCOM SPECIFICALLY DISCLAIMS ANY AND ALL IPPLIED
    WARRANTIES OF TITLE, MERCHANTABILITY, NONINFRINGEMENT, FITNESS FOR A
    PARTICULAR PURPOSE, LACK OF VIRUSES, ACCURACY OR COPPLETENESS,
    QUIET ENJOYMENT, QUIET POSSESSION OR CORRESPONDENCE TO DESCRIPTION.
    YOU ASSUME THE ENTIRE RISK ARISING OUT OF USE OR PERFORMANCE OF THE
    SOFTWARE.

 3. TO THE MAXIMUM EXTENT PERMITTED BY LAW, IN NO EVENT SHALL BROADCOM OR ITS
    LICENSORS BE LIABLE FOR (i) CONSEQUENTIAL, INCIDENTAL, SPECIAL, INDIRECT,
    OR EXEPPLARY DAMAGES WHATSOEVER ARISING OUT OF OR IN ANY WAY RELATING TO
    YOUR USE OF OR INABILITY TO USE THE SOFTWARE EVEN IF BROADCOM HAS BEEN
    ADVISED OF THE POSSIBILITY OF SUCH DAMAGES; OR (ii) ANY AMOUNT IN EXCESS
    OF THE AMOUNT ACTUALLY PAID FOR THE SOFTWARE ITSELF OR U.S. $1, WHICHEVER
    IS GREATER. THESE LIMITATIONS SHALL APPLY NOTWITHSTANDING ANY FAILURE OF
    ESSENTIAL PURPOSE OF ANY LIMITED REMEDY.
******************************************************************************/
#include <bcm_utils.h>
#include <bcm_err.h>
#include <string.h>
#include <bcm_test.h>
#include <ee.h>

#define BCM_UTILS_TEST1       (0x1UL)
#define BCM_UTILS_TEST_MAX    (BCM_UTILS_TEST1)

static uint32_t BCM_UtilsTestIndex;
static int32_t BCM_UtilsTestResult = BCM_AT_NOT_STARTED;

static int32_t BCM_MemCpyTest(void)
{
    char src[40UL] = "This is a BCM_MemCpy test";
    char dest[40UL];
    int32_t retVal = BCM_ERR_UNKNOWN;

    BCM_MemCpy(dest, src, sizeof(src));
    if (0UL == memcmp(dest, src, sizeof(src))) {
        retVal = BCM_ERR_OK;
    }

    return retVal;
}

static int32_t BCM_MemSetTest(void)
{
    char testStr[40UL] = "tttttttttttttttttttttttttttttttttttttttt";
    char dest[40UL];
    int32_t retVal = BCM_ERR_UNKNOWN;

    BCM_MemSet(dest, 't', sizeof(dest));
    if(0UL == memcmp(dest, testStr, sizeof(testStr))) {
        retVal = BCM_ERR_OK;
    }

    return retVal;
}

static int32_t BCM_MemMoveTest(void)
{
    char dest[50UL] = "This is a BCM_MemMove test";
    char memOverlapStr[50UL] = "This This is a BCM_MemMove test";
    int32_t retVal = BCM_ERR_UNKNOWN;

    BCM_MemMove(dest+5UL, dest, strlen(dest)+1UL);
    if(0UL == memcmp(dest, memOverlapStr, sizeof(dest))) {
        retVal = BCM_ERR_OK;
    }

    return retVal;
}

static int32_t BCM_StrnCpyTest(void)
{
    char src[40UL] = "This is a BCM_StrnCpy test";
    char dest[40UL];
    int32_t retVal = BCM_ERR_UNKNOWN;

    BCM_StrnCpy(dest, src, 4UL);
    if(0UL != memcmp(dest, src, 6UL)) {
        if(0UL == memcmp(dest, src, 4UL)) {
            retVal = BCM_ERR_OK;
        }
    }

    return retVal;
}

static int32_t BCM_StrToLongTest(void)
{
    char posNum[50UL] = "20303000000";
    char negNum[50UL] = "-2030300000000";
    char num[50UL] = "203030";
    char hexNum[20UL] = "0x1234";
    uint32_t base;
    char *ptr;
    int32_t intValue;
    uint32_t hexNumber;
    int32_t retVal = BCM_ERR_UNKNOWN;

    base = 10UL;
    /* Large positive Number to test buffer overflow */
    intValue = BCM_StrToLong(posNum, &ptr, base);
    if (LONG_MAX != intValue){
        goto done;
    }

    /* Large negative number to test buffer overflow */
    intValue = BCM_StrToLong(negNum, &ptr, base);
    if (LONG_MIN != intValue){
        goto done;
    }

    intValue = BCM_StrToLong(num, &ptr, base);
    if (203030 != intValue){
        goto done;
    }

    base = 16UL;
    hexNumber = BCM_StrToLong(hexNum, &ptr, base);
    if (0x1234UL == hexNumber){
        retVal = BCM_ERR_OK;
    }

done:
    return retVal;
}

static int32_t BCM_IncAndDecModTest(void)
{
    uint32_t maxValue = 10UL;
    uint32_t retVal = BCM_ERR_OK;
    uint32_t val;

    /* BCM_IncMod */
    val = BCM_IncMod(0UL, maxValue);
    if (1UL != val){
        retVal = BCM_ERR_UNKNOWN;
    }
    if(BCM_ERR_OK == retVal) {
       /* When the next value is maxValue, then it should wrap to '0' */
        val = BCM_IncMod((maxValue - 1UL), maxValue);
        if (0UL != val){
            retVal = BCM_ERR_UNKNOWN;
        }
    }

    if(BCM_ERR_OK == retVal) {
        val = BCM_DecMod(1UL, maxValue);
        if (0UL != val){
            retVal = BCM_ERR_UNKNOWN;
        } else {
           /* When reaching to '0' then it should wrap to maxValue */
            val = BCM_DecMod(0UL, maxValue);
            if ((maxValue - 1UL) != val) {
                retVal = BCM_ERR_UNKNOWN;
            }
        }
    }

    return retVal;
}

static int32_t BCM_GCDTest(void)
{
    uint32_t gcdInput[5UL][2UL] = {{2UL, 3UL}, {56UL, 98UL}, {12UL, 18UL}, {42UL, 56UL}, {48UL, 180UL}};
    uint32_t gcdOutput[5UL] = {1UL, 14UL, 6UL, 14UL, 12UL};
    uint32_t retVal = BCM_ERR_OK;
    uint32_t i;

    for (i = 0UL; i < 5UL; i++){
        if(gcdOutput[i] != BCM_GCD(gcdInput[i][0UL], gcdInput[i][1UL])) {
            retVal = BCM_ERR_UNKNOWN;
        }
    }

    return retVal;
}

static int32_t BCM_RoundUpPowerTwoTest(void){
    uint32_t input[10UL] = {4UL, 5UL, 6UL, 7UL, 8UL, 9UL, 57UL, 120UL, 250UL, 950UL};
    uint32_t output[10UL] = {4UL, 8UL, 8UL, 8UL, 8UL, 16UL, 64UL, 128UL, 256UL, 1024UL};
    uint32_t retVal = BCM_ERR_OK;
    uint32_t i;

    for (i = 0UL; i < 10UL; i++){
        if(output[i] != BCM_RoundUpPowerTwo(input[i])) {
            retVal = BCM_ERR_UNKNOWN;
        }
    }

    return retVal;
}

static int32_t BCM_StrnLenTest(void){
    char str[30UL] = "This is a test string";
    uint32_t maxValue = 10UL;
    uint32_t retVal = BCM_ERR_OK;
    uint32_t val;

    val = BCM_StrnLen(str, maxValue);
    if (10UL != val){
        retVal = BCM_ERR_UNKNOWN;
    }

    if(BCM_ERR_OK == retVal) {
        maxValue = 30UL;
        val = BCM_StrnLen(str, maxValue);
        if (val != strlen(str)) {
            retVal = BCM_ERR_UNKNOWN;
        }
    }

    return retVal;
}

int32_t BCM_UtilsTestSeq1 (void)
{
    int32_t retVal;

    retVal = BCM_MemCpyTest();

    if(BCM_ERR_OK == retVal) {
        retVal = BCM_MemSetTest();
    }

    if(BCM_ERR_OK == retVal) {
        retVal = BCM_MemMoveTest();
    }

    if(BCM_ERR_OK == retVal) {
        retVal = BCM_StrnCpyTest();
    }

    if(BCM_ERR_OK == retVal) {
        retVal = BCM_StrToLongTest();
    }

    if(BCM_ERR_OK == retVal) {
        retVal = BCM_IncAndDecModTest();
    }

    if(BCM_ERR_OK == retVal) {
        retVal = BCM_GCDTest();
    }

    if(BCM_ERR_OK == retVal) {
        retVal = BCM_RoundUpPowerTwoTest();
    }

    if(BCM_ERR_OK == retVal) {
        retVal = BCM_StrnLenTest();
    }

    return retVal;
}

TASK(BCM_UtilsTestTask)
{
    int32_t retVal = BCM_ERR_UNKNOWN;

    if(BCM_UTILS_TEST1 == BCM_UtilsTestIndex) {
        retVal = BCM_UtilsTestSeq1();
    }

    if(BCM_AT_EXECUTING == BCM_UtilsTestResult) {
        BCM_UtilsTestResult = retVal;
    }
    (void)BCM_TerminateTask();
}

int32_t BCM_ExecuteAT(uint32_t aIndex)
{
    int32_t retVal;

    if ((BCM_UTILS_TEST_MAX >= aIndex) && (0UL < aIndex)) {
        if (BCM_AT_EXECUTING != BCM_UtilsTestResult) {
            BCM_UtilsTestIndex = aIndex;
            BCM_UtilsTestResult = BCM_AT_EXECUTING;
            retVal = (int32_t)BCM_ActivateTask(BCM_UtilsTestTask);
            if (BCM_ERR_OK != retVal) {
                BCM_UtilsTestResult = BCM_AT_NOT_STARTED;
                retVal = BCM_ERR_INVAL_STATE;
            }
        } else {
            retVal = BCM_ERR_OK;
        }
    } else {
        retVal = BCM_AT_NOT_AVAILABLE;
    }

    return retVal;
}

int32_t BCM_GetResultAT(uint32_t aIndex)
{
    int32_t retVal = BCM_AT_NOT_AVAILABLE;

    if ((BCM_UTILS_TEST_MAX >= aIndex) && (0UL < aIndex)) {
        if(BCM_UtilsTestIndex == aIndex) {
            retVal = BCM_UtilsTestResult;
        }
    }
    return retVal;
}
