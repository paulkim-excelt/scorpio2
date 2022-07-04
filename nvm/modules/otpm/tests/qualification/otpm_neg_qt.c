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
#include "ee.h"
#include <bcm_err.h>
#include <ulog.h>
#include <bcm_utils.h>
#include <osil/bcm_osil.h>
#include <bcm_test.h>
#include "otpm_qt.h"
#include <osil/otp_module_osil.h>
#include <otp_module.h>
#include <otpm_common.h>
#include <svc.h>
#include <bcm_test.h>
#include <module.h>
#include <module_helper.h>
#include <otp.h>



#define EXECUTE_TEST(case, func, expecRet)                                      \
        BCM_SetTestCase(case);                                                  \
        RetVal = func;                                                          \
        if (expecRet == RetVal) {                                               \
            BCM_SetTestResult(BCM_ERR_OK);                                      \
        } else {                                                                \
            BCM_SetTestResult(BCM_ERR_UNKNOWN);                                 \
            OtpNegQtErrCnt++;                                                      \
			ULOG_ERR("OTPM_QT: Err case: %x, RetVal: %x at: %d\n",              \
                                            case, RetVal, __LINE__);            \
        }                                                                       \

#define REPORT_RESULT(case, condition)                                          \
        BCM_SetTestCase(case);                                                  \
        if (condition) {                                                        \
            BCM_SetTestResult(BCM_ERR_OK);                                      \
        } else {                                                                \
            BCM_SetTestResult(BCM_ERR_UNKNOWN);                                 \
			ULOG_ERR("OTPM_QT: Err case: %x, at line : %d\n", case, __LINE__);  \
            OtpNegQtErrCnt++;                                                      \
        }                                                                       \

#define GetModuleLogLevel()     ULOG_LVL_INFO

static uint32_t OtpNegQtErrCnt;
static uint32_t RetVal;

static const MODULE_Type* const SYS_ModuleFnTable[MODULE_COUNT_MAX] = {
    &OTPM_Module,
};

#ifdef __BCM8958X__ /*Call TC10 for ECC error in 8958x*/
static void OTPM_ProbeDeInit()
{
	EXECUTE_TEST(BRCM_SWQTST_OTPM_GET_EN_BOOTMODE_NEG_CASE0,
            MODULE_InitStateHandler(SYS_ModuleFnTable,1UL), BCM_ERR_OK)
	EXECUTE_TEST(BRCM_SWQTST_OTPM_GET_EN_BOOTMODE_NEG_CASE0,
            MODULE_ReadyStateHandler(SYS_ModuleFnTable,1UL,BCM_STATE_UNINIT), BCM_ERR_OK)
}
#endif

void OTPM_NegTestSeq0(void)
{
	OtpNegQtErrCnt = 0UL;
    OTPM_BootModeType aBootModes;
    uint32_t aMemAddr[150];
    uint32_t aFilledSize;
	(void)RetVal;

    EXECUTE_TEST(BRCM_SWQTST_OTPM_GET_EN_BOOTMODE_NEG_CASE0,
            OTPM_GetEnabledBootModes(NULL), BCM_ERR_INVAL_PARAMS)
    EXECUTE_TEST(BRCM_SWQTST_OTPM_GET_EN_BOOTMODE_NEG_CASE1,
            OTPM_GetEnabledBootModes(&aBootModes), BCM_ERR_UNINIT)

    EXECUTE_TEST(BRCM_SWQTST_OTPM_READ_TC10_NEG_CASE0,
            OTPM_ReadTC10Config(NULL, sizeof(aMemAddr), &aFilledSize), BCM_ERR_INVAL_PARAMS)
    EXECUTE_TEST(BRCM_SWQTST_OTPM_READ_TC10_NEG_CASE1,
            OTPM_ReadTC10Config(aMemAddr, sizeof(aMemAddr), NULL), BCM_ERR_INVAL_PARAMS)
    EXECUTE_TEST(BRCM_SWQTST_OTPM_READ_TC10_NEG_CASE2,
            OTPM_ReadTC10Config(aMemAddr, 10, &aFilledSize), BCM_ERR_NOMEM)
#ifdef __BCM8958X__ /*Call TC10 for ECC error in 8958x*/
#ifdef OTPM_ALT_MEM_ROWS_COUNT
    SVC_RunTestSvc(0x1001UL, NULL);
#endif
	EXECUTE_TEST(BRCM_SWQTST_OTPM_READ_TC10_NEG_CASE3,
            MODULE_ResetStateHandler(SYS_ModuleFnTable,1UL), BCM_ERR_OK)
    EXECUTE_TEST(BRCM_SWQTST_OTPM_READ_TC10_NEG_CASE3,
            OTPM_ReadTC10Config(aMemAddr, sizeof(aMemAddr), &aFilledSize), BCM_ERR_DATA_INTEG)
    OTPM_ProbeDeInit();
#endif

    OTP_Init(0UL);
	EXECUTE_TEST(BRCM_SWQTST_OTPM_READ_TC10_NEG_CASE3,
            MODULE_ResetStateHandler(SYS_ModuleFnTable,1UL), BCM_ERR_INVAL_STATE)
    OTP_DeInit(0UL);
    OTPM_Module.context->state = BCM_STATE_UNINIT;

    EXECUTE_TEST(BRCM_SWQTST_OTPM_READ_TC10_NEG_CASE4,
            OTPM_ReadTC10Config(aMemAddr, sizeof(aMemAddr), &aFilledSize), BCM_ERR_UNINIT)

    if (OtpNegQtErrCnt > 0UL) {
        OtpQtResult = BCM_ERR_CUSTOM;
    }
}

void OTPM_NegTestSeq1(void)
{
	OtpNegQtErrCnt = 0UL;
#if 0
    uint8_t pubKey[300];
    uint32_t pubKeyLen;
    uint32_t pubKeyType;

    EXECUTE_TEST(BRCM_SWQTST_OTPM_READ_PUBKEY_NEG_CASE0,
                        OTPM_ReadPubKey(NULL, sizeof(pubKey), &pubKeyType, &pubKeyLen), BCM_ERR_INVAL_PARAMS)
    EXECUTE_TEST(BRCM_SWQTST_OTPM_READ_PUBKEY_NEG_CASE1,
                        OTPM_ReadPubKey(pubKey, sizeof(pubKey), NULL, &pubKeyLen), BCM_ERR_INVAL_PARAMS)
    EXECUTE_TEST(BRCM_SWQTST_OTPM_READ_PUBKEY_NEG_CASE2,
                        OTPM_ReadPubKey(pubKey, sizeof(pubKey), &pubKeyType, NULL), BCM_ERR_INVAL_PARAMS)
    EXECUTE_TEST(BRCM_SWQTST_OTPM_READ_PUBKEY_NEG_CASE3,
                        OTPM_ReadPubKey(pubKey, 10, &pubKeyType, &pubKeyLen), BCM_ERR_NOMEM)
    EXECUTE_TEST(BRCM_SWQTST_OTPM_READ_PUBKEY_NEG_CASE4,
                        OTPM_ReadPubKey(pubKey, sizeof(pubKey), &pubKeyType, &pubKeyLen), BCM_ERR_DATA_INTEG)
#endif

    if (OtpNegQtErrCnt > 0UL) {
        OtpQtResult = BCM_ERR_CUSTOM;
    }
}



