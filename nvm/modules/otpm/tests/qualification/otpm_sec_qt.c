/*****************************************************************************
 Copyright 2017-2021 Broadcom Limited.  All rights reserved.

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
#include <svc.h>
#include <bcm_test.h>
#include <otpm_test.h>
#include "otpm_qt.h"
#include <osil/otp_module_osil.h>
#include <otp_module.h>
#include <module.h>
#include <module_helper.h>
#include <bcm_utils.h>
#include <8957x/otpm_sec_test_data.h>

#define EXECUTE_TEST(case, func, expecRet)                                      \
        BCM_SetTestCase(case);                                                  \
        RetVal = func;                                                          \
        if (expecRet == RetVal) {                                               \
            BCM_SetTestResult(BCM_ERR_OK);                                      \
        } else {                                                                \
            BCM_SetTestResult(BCM_ERR_UNKNOWN);                                 \
            ULOG_ERR("OTPM_QT: Err case: %x, RetVal: %x at: %d\n",               \
                                            case, RetVal, __LINE__);            \
            OtpQtErrCnt++;                                                      \
        }                                                                       \

#define REPORT_RESULT(case, condition)                                          \
        BCM_SetTestCase(case);                                                  \
        if (condition) {                                                        \
            BCM_SetTestResult(BCM_ERR_OK);                                      \
        } else {                                                                \
            BCM_SetTestResult(BCM_ERR_UNKNOWN);                                 \
            ULOG_ERR("OTPM_QT: Err case: %x, at line : %d\n", case, __LINE__);   \
            OtpQtErrCnt++;                                                      \
        }                                                                       \

#define GetModuleLogLevel()     ULOG_LVL_INFO

static int32_t OtpQtRunState = BCM_AT_NOT_STARTED;
static uint32_t OtpQtErrCnt;
static int32_t OtpQtResult;
static uint32_t OtpQtIdx;
static uint32_t RetVal;


const uint8_t lPubKeyByte0 = 0xAE;
const uint8_t lPubKeyByteLast = 0x9B;

static const MODULE_Type* const SYS_ModuleFnTable[MODULE_COUNT_MAX] = {
    &OTPM_Module,
};

const uint32_t *OTPM_test_sec_data[] = {
    OTPM_test_sec_seq_0,
    OTPM_test_sec_seq_1,
};

#ifdef OTPM_ALT_MEM_ROWS_COUNT
static  uint32_t OTPM_test_data_size = sizeof(OTPM_test_sec_seq_0);
#endif

void OTPM_TestSecureSeq0(void)
{
    uint8_t pubKey[300];
    uint32_t pubKeyLen;
    uint32_t pubKeyType;

    EXECUTE_TEST(BRCM_SWQTSEQ_OTPM_SECURE_0,
                        OTPM_ReadPubKey(pubKey, sizeof(pubKey), &pubKeyType, &pubKeyLen), BCM_ERR_NOT_FOUND)

    if (OtpQtErrCnt > 0UL) {
        OtpQtResult = BCM_ERR_CUSTOM;
    }
}

void OTPM_TestSecureSeq1(void)
{
    uint8_t pubKey[300];
    uint32_t pubKeyLen = 0UL;
    uint32_t pubKeyType;

    EXECUTE_TEST(BRCM_SWQTSEQ_OTPM_SECURE_1,
                        OTPM_ReadPubKey(pubKey, sizeof(pubKey), &pubKeyType, &pubKeyLen), BCM_ERR_OK)
    REPORT_RESULT(BRCM_SWQTSEQ_OTPM_SECURE_1, (pubKeyLen == 256UL))
    REPORT_RESULT(BRCM_SWQTSEQ_OTPM_SECURE_1, (lPubKeyByte0 == pubKey[0]))
    REPORT_RESULT(BRCM_SWQTSEQ_OTPM_SECURE_1, (lPubKeyByteLast == pubKey[pubKeyLen - 1UL]))

    if (OtpQtErrCnt > 0UL) {
        OtpQtResult = BCM_ERR_CUSTOM;
    }
}

TASK(OTPMSECQT_Task)
{
    int32_t retVal;
    BCM_TestStart(BCM_OTP_ID);
    BCM_SetTestSeq(OtpQtIdx);
    OtpQtErrCnt = 0;

    OtpQtResult = BCM_ERR_OK;

#ifdef OTPM_ALT_MEM_ROWS_COUNT
    OTPM_AltMemHdrType otpAltMemHdr;
    BCM_MemCpy((void *)&otpAltMemHdr, OTPM_AltMem, sizeof(OTPM_AltMemHdrType));
    otpAltMemHdr.magic = 0x4f545041UL;

    BCM_MemCpy(OTPM_AltMem, (void *)&otpAltMemHdr, sizeof(OTPM_AltMemHdrType));
    BCM_MemCpy((void *)OTPM_AltMem + sizeof(OTPM_AltMemHdrType), (void *)OTPM_test_sec_data[OtpQtIdx & 0x000F] + sizeof(OTPM_AltMemHdrType), OTPM_test_data_size - sizeof(OTPM_AltMemHdrType));
#endif

    /* Validate state transitions (UNINIT->INIT)*/
    retVal = MODULE_ResetStateHandler(SYS_ModuleFnTable,1UL);
    if (BCM_ERR_OK == retVal) {

        /* Validate state transitions (INIT->READY)*/
        retVal = MODULE_InitStateHandler(SYS_ModuleFnTable, 1UL);
        if (BCM_ERR_OK == retVal) {

            /* Validate state transitions (READY->RUN)*/
            retVal = MODULE_ReadyStateHandler(SYS_ModuleFnTable, 1UL, BCM_STATE_RUN);
        }
    }

    if (BCM_STATE_RUN == OTPM_Module.context->state) {

        switch (OtpQtIdx) {
            case BRCM_SWQTSEQ_OTPM_SECURE_0:
                OTPM_TestSecureSeq0();
                break;
            case BRCM_SWQTSEQ_OTPM_SECURE_1:
#ifdef OTPM_ALT_MEM_ROWS_COUNT
                OTPM_TestSecureSeq1();
#endif
                break;
            default:
                OtpQtResult = BCM_ERR_UNKNOWN;
                break;
        }

        retVal = MODULE_RunStateHandler(SYS_ModuleFnTable, 1UL, BCM_STATE_UNINIT);
        if (BCM_STATE_UNINIT != OTPM_Module.context->state) {
            OtpQtResult = BCM_ERR_INVAL_STATE;
        }

    } else {
        OtpQtResult = BCM_ERR_INVAL_STATE;
    }

    (void)BCM_TerminateTask();
}

static int32_t OTPM_ExecuteSecQtInternal(uint32_t aTestIdx)
{
    int32_t retVal;
    StatusType retOS = E_OK;
    TaskStateType taskState = SUSPENDED;
    TaskStateRefType taskStatePtr = &taskState;

    retOS = GetTaskState(OTPMSECQT_Task, taskStatePtr);
    if (BCM_ERR_OK == retOS) {
        if (SUSPENDED == taskState) {
            OtpQtRunState = BCM_AT_EXECUTING;
            OtpQtIdx = aTestIdx;
            retVal = BCM_ActivateTask(OTPMSECQT_Task);
            if (BCM_ERR_OK != retVal) {
                retVal = BCM_AT_NOT_STARTED;
                OtpQtRunState = BCM_AT_NOT_STARTED;
                ULOG_ERR("OTPMSECQT_Task activation failed, error: %d\n\r", retVal);
            }
        } else {
            retVal = BCM_AT_EXECUTING;
            ULOG_ERR("OTPMSECQT_Task is already running \n\r");
        }
    } else {
        retVal = BCM_ERR_UNKNOWN;
        ULOG_ERR("GetTaskState in OTPM_ExecuteSecQt failed Error: %d\n\r", retOS);
    }

    return retVal;
}

int32_t OTPM_ExecuteSecQt(uint32_t aTestIdx)
{
    int32_t retVal = BCM_ERR_OK;

    switch (aTestIdx) {
        case BRCM_SWQTSEQ_OTPM_SECURE_0:
            retVal = OTPM_ExecuteSecQtInternal(aTestIdx);
            break;
        case BRCM_SWQTSEQ_OTPM_SECURE_1:
            retVal = OTPM_ExecuteSecQtInternal(aTestIdx);
            break;
        default:
            retVal = BCM_AT_NOT_AVAILABLE;
            break;
    }

    return retVal;
}

static int32_t OTPM_GetStatusSecQtInternal(uint32_t aTestIdx)
{
    int32_t retVal;
    StatusType retOS = E_OK;
    TaskStateType taskState = RUNNING;
    TaskStateRefType taskStatePtr = &taskState;

    if (OtpQtIdx == aTestIdx) {
        retOS = GetTaskState(OTPMSECQT_Task, taskStatePtr);
        if (BCM_ERR_OK == retOS) {
            if ((SUSPENDED == taskState) &&
                (BCM_AT_EXECUTING == OtpQtRunState)) {
                OtpQtRunState = BCM_AT_NOT_STARTED;
                retVal = OtpQtResult;
            } else {
                retVal = BCM_AT_EXECUTING;
            }
        } else {
            retVal = BCM_ERR_UNKNOWN;
            ULOG_ERR("GetTaskState in OTPM_GetStatusSecQt failed Error: %d\n\r", retOS);
        }
    } else {
        retVal = BCM_AT_NOT_AVAILABLE;
    }

    return retVal;
}

int32_t OTPM_GetStatusSecQt(uint32_t aTestIdx)
{
    int32_t retVal;

    switch (aTestIdx) {
        case BRCM_SWQTSEQ_OTPM_SECURE_0:
            retVal = OTPM_GetStatusSecQtInternal(aTestIdx);
            break;
        case BRCM_SWQTSEQ_OTPM_SECURE_1:
            retVal = OTPM_GetStatusSecQtInternal(aTestIdx);
            break;
        default:
            retVal = BCM_AT_NOT_AVAILABLE;
            break;
    }

    return retVal;
}
