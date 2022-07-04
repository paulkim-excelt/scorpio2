/*****************************************************************************
 Copyright 2022 Broadcom Limited.  All rights reserved.

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

#include <ee.h>
#include <svc.h>

#include <compiler.h>
#include <bcm_test.h>
#include <bcm_time.h>
#include <bcm_utils.h>
#include <aes.h>

#include <osil/time_module_osil.h>
#include <module.h>
#include <module_helper.h>

int32_t failLine;
int32_t aes_qt_result = BCM_AT_NOT_STARTED;
int32_t aes_qt_priv_test_exec_result = BCM_AT_NOT_STARTED;

#define CHECKED_FUNC_CALL_EXPECT_ERR(err, fn, ...)                      \
    ret = (fn)(__VA_ARGS__);                                            \
    if (err != ret) {                                                   \
        if (0 == failLine) {                                            \
            failLine = __LINE__;                                        \
        }                                                               \
        goto exit;                                                      \
    } else {                                                            \
        ret = BCM_ERR_OK;                                               \
    }

#define CHECKED_FUNC_CALL(fn, ...)                                      \
    CHECKED_FUNC_CALL_EXPECT_ERR(BCM_ERR_OK, fn, __VA_ARGS__)

#define CHECK_COND(cond)                                                \
    if (!(cond)) {                                                      \
        if (0 == failLine) {                                            \
            failLine = __LINE__;                                        \
        }                                                               \
        ret = BCM_ERR_INVAL_STATE;                                      \
        goto exit;                                                      \
    } else {                                                            \
        ret = BCM_ERR_OK;                                               \
    }

COMP_NEVER_INLINE int32_t AES_ECBEncryptTests(void)
{
    int32_t ret;
    uint8_t output[16UL];

    /* FIPS vectors */
    const uint8_t plainText[16UL] = {
        0x00U, 0x11U, 0x22U, 0x33U, 0x44U, 0x55U, 0x66U, 0x77U,
        0x88U, 0x99U, 0xaaU, 0xbbU, 0xccU, 0xddU, 0xeeU, 0xffU,
    };

    const uint8_t cipherKey[32UL] = {
        0x00U, 0x01U, 0x02U, 0x03U, 0x04U, 0x05U, 0x06U, 0x07U,
        0x08U, 0x09U, 0x0aU, 0x0bU, 0x0cU, 0x0dU, 0x0eU, 0x0fU,
        0x10U, 0x11U, 0x12U, 0x13U, 0x14U, 0x15U, 0x16U, 0x17U,
        0x18U, 0x19U, 0x1aU, 0x1bU, 0x1cU, 0x1dU, 0x1eU, 0x1fU,
    };

    const uint8_t cipherText128[16UL] = {
        0x69U, 0xc4U, 0xe0U, 0xd8U, 0x6aU, 0x7bU, 0x04U, 0x30U,
        0xd8U, 0xcdU, 0xb7U, 0x80U, 0x70U, 0xb4U, 0xc5U, 0x5aU,
    };

    const uint8_t cipherText192[16UL] = {
        0xddU, 0xa9U, 0x7cU, 0xa4U, 0x86U, 0x4cU, 0xdfU, 0xe0U,
        0x6eU, 0xafU, 0x70U, 0xa0U, 0xecU, 0x0dU, 0x71U, 0x91U,
    };

    const uint8_t cipherText256[16UL] = {
        0x8eU, 0xa2U, 0xb7U, 0xcaU, 0x51U, 0x67U, 0x45U, 0xbfU,
        0xeaU, 0xfcU, 0x49U, 0x90U, 0x4bU, 0x49U, 0x60U, 0x89U,
    };

    /* Negative tests */
    CHECKED_FUNC_CALL_EXPECT_ERR(BCM_ERR_INVAL_PARAMS, AES_ECBEncryptBlock, CRYPTO_KEY_INVALID, cipherKey, plainText, output)
    CHECKED_FUNC_CALL_EXPECT_ERR(BCM_ERR_INVAL_PARAMS, AES_ECBEncryptBlock, CRYPTO_KEY_AES128, NULL, plainText, output)
    CHECKED_FUNC_CALL_EXPECT_ERR(BCM_ERR_INVAL_PARAMS, AES_ECBEncryptBlock, CRYPTO_KEY_AES128, cipherKey, NULL, output)
    CHECKED_FUNC_CALL_EXPECT_ERR(BCM_ERR_INVAL_PARAMS, AES_ECBEncryptBlock, CRYPTO_KEY_AES128, cipherKey, plainText, NULL)

    CHECKED_FUNC_CALL_EXPECT_ERR(BCM_ERR_INVAL_PARAMS, AES_ECBDecryptBlock, CRYPTO_KEY_INVALID, cipherKey, cipherText128, output)
    CHECKED_FUNC_CALL_EXPECT_ERR(BCM_ERR_INVAL_PARAMS, AES_ECBDecryptBlock, CRYPTO_KEY_AES128, NULL, cipherText128, output)
    CHECKED_FUNC_CALL_EXPECT_ERR(BCM_ERR_INVAL_PARAMS, AES_ECBDecryptBlock, CRYPTO_KEY_AES128, cipherKey, NULL, output)
    CHECKED_FUNC_CALL_EXPECT_ERR(BCM_ERR_INVAL_PARAMS, AES_ECBDecryptBlock, CRYPTO_KEY_AES128, cipherKey, cipherText128, NULL)

    /* Positive tests */
    CHECKED_FUNC_CALL(AES_ECBEncryptBlock, CRYPTO_KEY_AES128, cipherKey, plainText, output)
    CHECKED_FUNC_CALL(memcmp, output, cipherText128, 16UL)

    CHECKED_FUNC_CALL(AES_ECBEncryptBlock, CRYPTO_KEY_AES192, cipherKey, plainText, output)
    CHECKED_FUNC_CALL(memcmp, output, cipherText192, 16UL)

    CHECKED_FUNC_CALL(AES_ECBEncryptBlock, CRYPTO_KEY_AES256, cipherKey, plainText, output)
    CHECKED_FUNC_CALL(memcmp, output, cipherText256, 16UL)

    CHECKED_FUNC_CALL(AES_ECBDecryptBlock, CRYPTO_KEY_AES128, cipherKey, cipherText128, output)
    CHECKED_FUNC_CALL(memcmp, output, plainText, 16UL)

    CHECKED_FUNC_CALL(AES_ECBDecryptBlock, CRYPTO_KEY_AES192, cipherKey, cipherText192, output)
    CHECKED_FUNC_CALL(memcmp, output, plainText, 16UL)

    CHECKED_FUNC_CALL(AES_ECBDecryptBlock, CRYPTO_KEY_AES256, cipherKey, cipherText256, output)
    CHECKED_FUNC_CALL(memcmp, output, plainText, 16UL)

exit:
    if (0 != failLine) {
        ret = BCM_ERR_INVAL_STATE;
    } else {
        ret = BCM_ERR_OK;
    }

    return ret;
}

TASK(AesQT)
{
    int32_t ret;

    /* Init the timer module */
    const MODULE_Type* const AESQT_Modules[1UL] = {
        &TIME_Module,
    };
    CHECKED_FUNC_CALL(MODULE_ResetStateHandler, AESQT_Modules, 1UL);

    CHECKED_FUNC_CALL(AES_ECBEncryptTests)

exit:
    aes_qt_result = ret;
}

int32_t BCM_ExecuteAT(uint32_t aIndex)
{
    int32_t ret = BCM_AT_NOT_AVAILABLE;

    if ((1UL == aIndex) && (BCM_AT_EXECUTING != aes_qt_result)) {
        aes_qt_result = BCM_AT_EXECUTING;
        BCM_ActivateTask(AesQT);
        ret = BCM_ERR_OK;
    }

    return ret;
}

int32_t BCM_GetResultAT(uint32_t aIndex)
{
    int32_t ret = BCM_AT_NOT_AVAILABLE;

    if (1UL == aIndex) {
        ret = aes_qt_result;
    }

    return ret;
}

