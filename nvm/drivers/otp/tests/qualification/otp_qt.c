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

#include "ee.h"
#include <string.h>
#include <ulog.h>
#include <bcm_err.h>
#include <bcm_test.h>
#include <otp.h>
#include <bcm_utils.h>
#include <osil/bcm_osil.h>

/* Test IDs */
#define BRCM_SWQTSEQ_OTP_0       (0x0001UL)
#define BRCM_SWQTST_OTP_INIT     (0UL)
#define BRCM_SWQTST_OTP_READ     (1UL)

#define EXECUTE_TEST(case, func, expecRet)                                      \
        BCM_SetTestCase(case);                                                  \
        RetVal = func;                                                          \
        if (expecRet == RetVal) {                                               \
            BCM_SetTestResult(BCM_ERR_OK);                                      \
        } else {                                                                \
            BCM_SetTestResult(BCM_ERR_UNKNOWN);                                 \
            ULOG_ERR("OTPM_QT: Err case: %x, RetVal: %x at: %d\n",              \
                                            case, RetVal, __LINE__);            \
            OtpQtErrCnt++;                                                      \
        }                                                                       \

#define REPORT_RESULT(case, condition)                                          \
        BCM_SetTestCase(case);                                                  \
        if (condition) {                                                        \
            BCM_SetTestResult(BCM_ERR_OK);                                      \
        } else {                                                                \
            BCM_SetTestResult(BCM_ERR_UNKNOWN);                                 \
            ULOG_ERR("OTPM_QT: Err case: %x, at line : %d\n", case, __LINE__);  \
            OtpQtErrCnt++;                                                      \
        }                                                                       \

#define GetModuleLogLevel()     ULOG_LVL_INFO

static int32_t  OtpQtRunState = BCM_AT_NOT_STARTED;
static uint32_t OtpQtErrCnt;
static int32_t  OtpQtResult;
static uint32_t OtpQtIdx;
static uint32_t RetVal;

#define OTP_HW_ID_0     (0UL)

#define OTP_TEST_ROW_BASE_ADDR  (0x41UL)

/* Test the otp */
static void OTP_TestSeq0(void)
{
    uint32_t data, otpAddr;

	otpAddr = OTP_TEST_ROW_BASE_ADDR;

    /* Initialize OTP */
    EXECUTE_TEST(BRCM_SWQTST_OTP_INIT,
            OTP_Init(OTP_HW_ID_0), BCM_ERR_OK)

    /* Read OTP */
    EXECUTE_TEST(BRCM_SWQTST_OTP_READ,
            OTP_Read(OTP_HW_ID_0, otpAddr, &data), BCM_ERR_OK)

    /* DeInitialize OTP */
    (void)OTP_DeInit(OTP_HW_ID_0);

    return;
}

/* Task for OTPQT  */
TASK(OTPQT_Task)
{
	BCM_TestStart(OTP_HW_ID_0);
    BCM_SetTestSeq(OtpQtIdx);
    OtpQtErrCnt = 0;
    OtpQtResult = BCM_ERR_OK;


    switch (OtpQtIdx) {
    case BRCM_SWQTSEQ_OTP_0:
        OTP_TestSeq0();
        break;
    default:
        OtpQtResult = BCM_ERR_UNKNOWN;
        break;
    }

	if (OtpQtErrCnt > 0UL) {
        OtpQtResult = BCM_ERR_CUSTOM;
    }

    (void)BCM_TerminateTask();
}


static int32_t OTP_ExecuteQtInternal(uint32_t aTestIdx)
{
    int32_t retVal;
    StatusType retOS = E_OK;
    TaskStateType taskState = SUSPENDED;
    TaskStateRefType taskStatePtr = &taskState;

    retOS = GetTaskState(OTPQT_Task, taskStatePtr);
    if (BCM_ERR_OK == retOS) {
        if (SUSPENDED == taskState) {
            OtpQtRunState = BCM_AT_EXECUTING;
            OtpQtIdx = aTestIdx;
            retVal = BCM_ActivateTask(OTPQT_Task);
            if (BCM_ERR_OK != retVal) {
                retVal = BCM_AT_NOT_STARTED;
                OtpQtRunState = BCM_AT_NOT_STARTED;
                ULOG_ERR("OTPQT_Task activation failed, error: %d\n\r", retVal);
            }
        } else {
            retVal = BCM_AT_EXECUTING;
            ULOG_ERR("OTPQT_Task is already running \n\r");
        }
    } else {
        retVal = BCM_ERR_UNKNOWN;
        ULOG_ERR("GetTaskState in OTP_ExecuteQt failed Error: %d\n\r", retOS);
    }

    return retVal;
}

int32_t OTP_ExecuteQt(uint32_t aTestIdx)
{
    int32_t retVal = BCM_ERR_OK;

    switch (aTestIdx) {
        case BRCM_SWQTSEQ_OTP_0:
            retVal = OTP_ExecuteQtInternal(aTestIdx);
            break;
        default:
            retVal = BCM_AT_NOT_AVAILABLE;
            break;
    }

    return retVal;
}

static int32_t OTP_GetStatusQtInternal(uint32_t aTestIdx)
{
    int32_t retVal;
    StatusType retOS = E_OK;
    TaskStateType taskState = RUNNING;
    TaskStateRefType taskStatePtr = &taskState;

    if (OtpQtIdx == aTestIdx) {
        retOS = GetTaskState(OTPQT_Task, taskStatePtr);
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
            ULOG_ERR("GetTaskState in OTP_GetStatusQt failed Error: %d\n\r", retOS);
        }
    } else {
        retVal = BCM_AT_NOT_AVAILABLE;
    }

    return retVal;
}

int32_t OTP_GetStatusQt(uint32_t aTestIdx)
{
    int32_t retVal;

    switch (aTestIdx) {
        case BRCM_SWQTSEQ_OTP_0:
            retVal = OTP_GetStatusQtInternal(aTestIdx);
            break;
        default:
            retVal = BCM_AT_NOT_AVAILABLE;
            break;
    }

    return retVal;
}
