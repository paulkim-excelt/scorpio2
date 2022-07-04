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
#include <svc.h>
#include <bcm_test.h>
#include <otpm_test.h>
#include <osil/otp_module_osil.h>
#include <otp_module.h>
#include <module.h>
#include <module_helper.h>
#include <bcm_utils.h>
#include "otpm_ct.h"
#include <mcu.h>


#define EXECUTE_TEST(case, func, expecRet)                                      \
        BCM_SetTestCase(case);                                                  \
        RetVal = func;                                                          \
        if (expecRet == RetVal) {                                               \
            BCM_SetTestResult(BCM_ERR_OK);                                      \
        } else {                                                                \
            BCM_SetTestResult(BCM_ERR_UNKNOWN);                                 \
            ULOG_ERR("OTPM_Ct: Err case: %x, RetVal: %x at: %d\n",               \
                                            case, RetVal, __LINE__);            \
            OtpCtErrCnt++;                                                      \
        }                                                                       \

#define REPORT_RESULT(case, condition)                                          \
        BCM_SetTestCase(case);                                                  \
        if (condition) {                                                        \
            BCM_SetTestResult(BCM_ERR_OK);                                      \
        } else {                                                                \
            BCM_SetTestResult(BCM_ERR_UNKNOWN);                                 \
            ULOG_ERR("OTPM_Ct: Err case: %x, at line : %d\n", case, __LINE__);   \
            OtpCtErrCnt++;                                                      \
        }                                                                       \

#define GetModuleLogLevel()     ULOG_LVL_INFO

static int32_t OtpCtRunState = BCM_AT_NOT_STARTED;
static uint32_t OtpCtErrCnt;
static uint32_t OtpCtIdx;
static uint32_t RetVal;
int32_t OtpCtResult = BCM_ERR_OK;
static MCU_InfoType info;
static const uint32_t lIPAddr0 = 0x0A7B220BUL;
static const uint32_t lGWIPAddr0 = 0xC67A4201UL;
#ifdef __BCM8958X__
static const uint8_t lMacAddr0[6] = {0x00, 0x00, 0x00, 0x03, 0x02, 0x01};
static const uint8_t lMacAddr1[6] = {0x66, 0x55, 0x44, 0x33, 0x22, 0x11};
#else
static const uint8_t lMacAddr0[6] = {0x00, 0x00, 0x00, 0x04, 0x05, 0x06};
static const uint8_t lMacAddr1[6] = {0x11, 0x22, 0x33, 0x44, 0x55, 0x66};
#endif

static const MODULE_Type* const SYS_ModuleFnTable[MODULE_COUNT_MAX] = {
    &OTPM_Module,
};

void OTPM_ProbeDeInit()
{
	EXECUTE_TEST(BRCM_SWPTST_OTPM_READ_VALIDCFG_PROBE_CASE0,
            MODULE_InitStateHandler(SYS_ModuleFnTable,1UL), BCM_ERR_OK)
	EXECUTE_TEST(BRCM_SWPTST_OTPM_READ_VALIDCFG_PROBE_CASE0,
            MODULE_ReadyStateHandler(SYS_ModuleFnTable,1UL,BCM_STATE_UNINIT), BCM_ERR_OK)
}

void OTPM_ProbeTestSeq0(void)
{
	EXECUTE_TEST(BRCM_SWPTST_OTPM_READ_VALIDCFG_PROBE_CASE0,
            MODULE_ResetStateHandler(SYS_ModuleFnTable,1UL), BCM_ERR_OK)
    OTPM_ProbeDeInit();

	EXECUTE_TEST(BRCM_SWPTST_OTPM_READ_VALIDCFG_PROBE_CASE1,
            MODULE_ResetStateHandler(SYS_ModuleFnTable,1UL), BCM_ERR_OK)
	EXECUTE_TEST(BRCM_SWPTST_OTPM_READ_VALIDCFG_PROBE_CASE1,
            MCU_GetInfo(&info), BCM_ERR_OK)
    REPORT_RESULT(BRCM_SWPTST_OTPM_READ_VALIDCFG_PROBE_CASE1, (lIPAddr0 == info.ipAddr))
    OTPM_ProbeDeInit();

	EXECUTE_TEST(BRCM_SWPTST_OTPM_READ_VALIDCFG_PROBE_CASE2,
            MODULE_ResetStateHandler(SYS_ModuleFnTable,1UL), BCM_ERR_OK)
	EXECUTE_TEST(BRCM_SWPTST_OTPM_READ_VALIDCFG_PROBE_CASE2,
            MCU_GetInfo(&info), BCM_ERR_OK)
    REPORT_RESULT(BRCM_SWPTST_OTPM_READ_VALIDCFG_PROBE_CASE2, (0UL == info.ipAddr))
    OTPM_ProbeDeInit();
}

void OTPM_ProbeTestSeq1(void)
{
    uint32_t aMemAddr[150];
    uint32_t aFilledSize;

    EXECUTE_TEST(BRCM_SWPTST_OTPM_READ_ROW_PROBE_CASE0,
            MODULE_ResetStateHandler(SYS_ModuleFnTable,1UL), BCM_ERR_OK)
	EXECUTE_TEST(BRCM_SWPTST_OTPM_READ_ROW_PROBE_CASE0,
            MODULE_InitStateHandler(SYS_ModuleFnTable,1UL), BCM_ERR_OK)
	EXECUTE_TEST(BRCM_SWPTST_OTPM_READ_ROW_PROBE_CASE0,
            MODULE_ReadyStateHandler(SYS_ModuleFnTable,1UL,BCM_STATE_RUN), BCM_ERR_OK)
	EXECUTE_TEST(BRCM_SWPTST_OTPM_READ_ROW_PROBE_CASE0,
            MCU_GetInfo(&info), BCM_ERR_OK)
    REPORT_RESULT(BRCM_SWPTST_OTPM_READ_ROW_PROBE_CASE0, (0UL == info.ipAddr))
	EXECUTE_TEST(BRCM_SWPTST_OTPM_READ_ROW_PROBE_CASE0,
            MODULE_RunStateHandler(SYS_ModuleFnTable,1UL,BCM_STATE_READY), BCM_ERR_OK)
	EXECUTE_TEST(BRCM_SWPTST_OTPM_READ_ROW_PROBE_CASE0,
            MODULE_ReadyStateHandler(SYS_ModuleFnTable,1UL,BCM_STATE_UNINIT), BCM_ERR_OK)

    EXECUTE_TEST(BRCM_SWPTST_OTPM_READ_ROW_PROBE_CASE1,
            OTPM_ReadTC10Config(aMemAddr, sizeof(aMemAddr), &aFilledSize), BCM_ERR_UNKNOWN)

    EXECUTE_TEST(BRCM_SWPTST_OTPM_READ_ROW_PROBE_CASE2,
            MODULE_ResetStateHandler(SYS_ModuleFnTable,1UL), BCM_ERR_OK)
	EXECUTE_TEST(BRCM_SWPTST_OTPM_READ_ROW_PROBE_CASE2,
            MCU_GetInfo(&info), BCM_ERR_OK)
    REPORT_RESULT(BRCM_SWPTST_OTPM_READ_ROW_PROBE_CASE2, (lIPAddr0 == info.ipAddr))
    REPORT_RESULT(BRCM_SWPTST_OTPM_READ_ROW_PROBE_CASE2, ((lGWIPAddr0&0xFFFFUL) == info.gwIPAddr))
    OTPM_ProbeDeInit();

    EXECUTE_TEST(BRCM_SWPTST_OTPM_READ_ROW_PROBE_CASE3,
            MODULE_ResetStateHandler(SYS_ModuleFnTable,1UL), BCM_ERR_OK)
	EXECUTE_TEST(BRCM_SWPTST_OTPM_READ_ROW_PROBE_CASE3,
            MCU_GetInfo(&info), BCM_ERR_OK)
    REPORT_RESULT(BRCM_SWPTST_OTPM_READ_ROW_PROBE_CASE3, (0UL == info.macAddr[2]))
    OTPM_ProbeDeInit();
}

void OTPM_ProbeTestSeq2(void)
{
    OTPM_BootModeType aBootModes;

    EXECUTE_TEST(BRCM_SWPTST_OTPM_READ_MACADDR_PROBE_CASE0,
            MODULE_ResetStateHandler(SYS_ModuleFnTable,1UL), BCM_ERR_OK)
	EXECUTE_TEST(BRCM_SWPTST_OTPM_READ_MACADDR_PROBE_CASE0,
            MCU_GetInfo(&info), BCM_ERR_OK)
    REPORT_RESULT(BRCM_SWPTST_OTPM_READ_MACADDR_PROBE_CASE0, (lIPAddr0 == info.ipAddr))
    REPORT_RESULT(BRCM_SWPTST_OTPM_READ_MACADDR_PROBE_CASE0, (0UL == info.macAddr[3]))
    OTPM_ProbeDeInit();

    EXECUTE_TEST(BRCM_SWPTST_OTPM_READ_MACADDR_PROBE_CASE1,
            MODULE_ResetStateHandler(SYS_ModuleFnTable,1UL), BCM_ERR_OK)
	EXECUTE_TEST(BRCM_SWPTST_OTPM_READ_MACADDR_PROBE_CASE1,
            MCU_GetInfo(&info), BCM_ERR_OK)
    REPORT_RESULT(BRCM_SWPTST_OTPM_READ_MACADDR_PROBE_CASE1, (lMacAddr0[3] == info.macAddr[3]))
    REPORT_RESULT(BRCM_SWPTST_OTPM_READ_MACADDR_PROBE_CASE1, (lMacAddr0[4] == info.macAddr[4]))
    OTPM_ProbeDeInit();

    EXECUTE_TEST(BRCM_SWQTST_OTPM_GET_EN_BOOT_MODE_PROBE_CASE0,
            OTPM_GetEnabledBootModes(&aBootModes), BCM_ERR_OK)
    REPORT_RESULT(BRCM_SWQTST_OTPM_GET_EN_BOOT_MODE_PROBE_CASE0, (0x07 == aBootModes))
    OTPM_Module.context->state = BCM_STATE_UNINIT;

    EXECUTE_TEST(BRCM_SWQTST_OTPM_GET_EN_BOOT_MODE_PROBE_CASE1,
            MODULE_ResetStateHandler(SYS_ModuleFnTable,1UL), BCM_ERR_OK)
    EXECUTE_TEST(BRCM_SWQTST_OTPM_GET_EN_BOOT_MODE_PROBE_CASE1,
            OTPM_GetEnabledBootModes(&aBootModes), BCM_ERR_OK)
    REPORT_RESULT(BRCM_SWQTST_OTPM_GET_EN_BOOT_MODE_PROBE_CASE1, (0x07 == aBootModes))
    OTPM_ProbeDeInit();
}

void OTPM_ProbeTestSeq3(void)
{
    EXECUTE_TEST(BRCM_SWQTST_OTPM_RESET_HANDLER_PROBE_CASE0,
            MODULE_ResetStateHandler(SYS_ModuleFnTable,1UL), BCM_ERR_OK)
    OTPM_ProbeDeInit();
}

TASK(OTPMCT_Task)
{
    (void)RetVal;
    BCM_TestStart(BCM_OTP_ID);
    BCM_SetTestSeq(OtpCtIdx);
    OtpCtErrCnt = 0;
    OtpCtResult = BCM_ERR_OK;

#ifdef OTPM_ALT_MEM_ROWS_COUNT
    SVC_RunTestSvc(0, NULL);
#endif

    switch (OtpCtIdx) {
        case BRCM_SWPTSEQ_OTPM_0:
            OTPM_ProbeTestSeq0();
            break;
        case BRCM_SWPTSEQ_OTPM_1:
            OTPM_ProbeTestSeq1();
            break;
        case BRCM_SWPTSEQ_OTPM_2:
            OTPM_ProbeTestSeq2();
            break;
        case BRCM_SWPTSEQ_OTPM_3:
            OTPM_ProbeTestSeq3();
            break;
	}

    if (OtpCtErrCnt > 0UL) {
        OtpCtResult = BCM_ERR_CUSTOM;
    }

    (void)BCM_TerminateTask();
}

static int32_t OTPM_ExecuteCtInternal(uint32_t aTestIdx)
{
    int32_t retVal;
    StatusType retOS = E_OK;
    TaskStateType taskState = SUSPENDED;
    TaskStateRefType taskStatePtr = &taskState;

    retOS = GetTaskState(OTPMCT_Task, taskStatePtr);
    if (BCM_ERR_OK == retOS) {
        if (SUSPENDED == taskState) {
            OtpCtRunState = BCM_AT_EXECUTING;
            OtpCtIdx = aTestIdx;
            retVal = BCM_ActivateTask(OTPMCT_Task);
            if (BCM_ERR_OK != retVal) {
                retVal = BCM_AT_NOT_STARTED;
                OtpCtRunState = BCM_AT_NOT_STARTED;
                ULOG_ERR("OTPMCT_Task activation failed, error: %d\n\r", retVal);
            }
        } else {
            retVal = BCM_AT_EXECUTING;
            ULOG_ERR("OTPMCT_Task is already running \n\r");
        }
    } else {
        retVal = BCM_ERR_UNKNOWN;
        ULOG_ERR("GetTaskState in OTPM_ExecuteCt failed Error: %d\n\r", retOS);
    }

    return retVal;
}

int32_t OTPM_ExecuteCt(uint32_t aTestIdx)
{
    int32_t retVal = BCM_ERR_OK;

    switch (aTestIdx) {
        case BRCM_SWPTSEQ_OTPM_0:
            retVal = OTPM_ExecuteCtInternal(aTestIdx);
            break;
        case BRCM_SWPTSEQ_OTPM_1:
            retVal = OTPM_ExecuteCtInternal(aTestIdx);
            break;
        case BRCM_SWPTSEQ_OTPM_2:
            retVal = OTPM_ExecuteCtInternal(aTestIdx);
            break;
        case BRCM_SWPTSEQ_OTPM_3:
            retVal = OTPM_ExecuteCtInternal(aTestIdx);
            break;
        default:
            retVal = BCM_AT_NOT_AVAILABLE;
            break;
    }

    return retVal;
}

static int32_t OTPM_GetStatusCtInternal(uint32_t aTestIdx)
{
    int32_t retVal;
    StatusType retOS = E_OK;
    TaskStateType taskState = RUNNING;
    TaskStateRefType taskStatePtr = &taskState;

    if (OtpCtIdx == aTestIdx) {
        retOS = GetTaskState(OTPMCT_Task, taskStatePtr);
        if (BCM_ERR_OK == retOS) {
            if ((SUSPENDED == taskState) &&
                (BCM_AT_EXECUTING == OtpCtRunState)) {
                OtpCtRunState = BCM_AT_NOT_STARTED;
                retVal = OtpCtResult;
            } else {
                retVal = BCM_AT_EXECUTING;
            }
        } else {
            retVal = BCM_ERR_UNKNOWN;
            ULOG_ERR("GetTaskState in OTPM_GetStatusCt failed Error: %d\n\r", retOS);
        }
    } else {
        retVal = BCM_AT_NOT_AVAILABLE;
    }

    return retVal;
}

int32_t OTPM_GetStatusCt(uint32_t aTestIdx)
{
    int32_t retVal;

    switch (aTestIdx) {
        case BRCM_SWPTSEQ_OTPM_0:
            retVal = OTPM_GetStatusCtInternal(aTestIdx);
            break;
        case BRCM_SWPTSEQ_OTPM_1:
            retVal = OTPM_GetStatusCtInternal(aTestIdx);
            break;
        case BRCM_SWPTSEQ_OTPM_2:
            retVal = OTPM_GetStatusCtInternal(aTestIdx);
            break;
        case BRCM_SWPTSEQ_OTPM_3:
            retVal = OTPM_GetStatusCtInternal(aTestIdx);
            break;
        default:
            retVal = BCM_AT_NOT_AVAILABLE;
            break;
    }

    return retVal;
}
