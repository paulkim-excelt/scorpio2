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
#include "otpm_qt.h"
#include <osil/otp_module_osil.h>
#include <otp_module.h>
#include <mcu.h>
#include <module.h>
#include <module_helper.h>
#include <bcm_utils.h>
#include <otpm_common.h>
#if 0
#ifdef __BCM8958X__
#include <8958x/otpm_test_data.h>
#else
#include <8957x/otpm_test_data.h>
#endif
#include <crc.h>
#include <mpu.h>

#ifdef __BCM8958X__
#define OTPM_ROW_COUNT  (1024UL)
#else
#define OTPM_ROW_COUNT  (640UL)
#endif

#define OTPM_CRC32_POLY                  (0x04C11DB7UL)
#endif

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
static uint32_t OtpQtIdx;
static uint32_t RetVal;
int32_t OtpQtResult = BCM_ERR_OK;

#ifdef __BCM8958X__
const uint8_t lMacAddr0[6] = {0x00, 0x00, 0x00, 0x03, 0x02, 0x01};
const uint8_t lMacAddr1[6] = {0x66, 0x55, 0x44, 0x33, 0x22, 0x11};
#else
const uint8_t lMacAddr0[6] = {0x00, 0x00, 0x00, 0x04, 0x05, 0x06};
const uint8_t lMacAddr1[6] = {0x11, 0x22, 0x33, 0x44, 0x55, 0x66};
#endif
const uint32_t lIPAddr0 = 0x0A7B220BUL;
const uint32_t lGWIPAddr0 = 0xC67A4201UL;
const uint32_t lNetMask0 = 0x0A;
const uint32_t lAppInfo0 = 0xf54593;
const uint32_t lTftpIPAddr0 = 0xa0b0c0d0;

const uint32_t lIPAddr1 = 0x7F000001UL;;
const uint32_t lGWIPAddr1 = 0x0C0D0E0FUL;
const uint32_t lNetMask1 = 0x0B;
const uint32_t lAppInfo1 = 0x010203;
const uint32_t lTftpIPAddr1 = 0xafbfcfdf;

const uint32_t lTC10Row0 = 0xffffff7f;

const uint32_t lVlan = 1552;
#ifdef __BCM8958X__
const uint32_t lVlan1 = 168;
#endif




static const MODULE_Type* const SYS_ModuleFnTable[MODULE_COUNT_MAX] = {
    &OTPM_Module,
};
#if 0
const uint32_t *OTPM_test_data[] = {
    OTPM_test_seq_0,
    OTPM_test_seq_1,
    OTPM_test_seq_2,
};

#ifdef OTPM_ALT_MEM_ROWS_COUNT
static uint32_t OTPM_test_data_size = sizeof(OTPM_test_seq_0);
static uint32_t OTPM_test_data_count = BCM_ARRAY_LEN(OTPM_test_data);
#endif

void SVC_TestSvcHandler(uint32_t aMagicID, uint32_t aCmd, uint8_t *aSysIO)
{
    if (aCmd < OTPM_test_data_count) {
        uint32_t otp_size;

        CORTEX_MX_MPUDisable();
        OTPM_AltMemHdrType * const otpAltMemHdr = (void *)OTPM_AltMem;
        otpAltMemHdr->magic = 0x4f545041UL;
        if (aCmd != 1U) {
            otp_size = (OTPM_ROW_COUNT * 4) - sizeof(OTPM_AltMemHdrType);
            otpAltMemHdr->crc = BCM_CRC32((uint8_t*)OTPM_test_data[aCmd] + sizeof(OTPM_AltMemHdrType), otp_size, OTPM_CRC32_POLY);
        }
        otpAltMemHdr->reserved[0] = 0U;
        otpAltMemHdr->reserved[1] = 0U;
        BCM_MemCpy((uint8_t *)OTPM_AltMem + sizeof(OTPM_AltMemHdrType), (uint8_t*)OTPM_test_data[aCmd] + sizeof(OTPM_AltMemHdrType), OTPM_test_data_size - sizeof(OTPM_AltMemHdrType));
        CORTEX_MX_MPUEnable();
    }
}
#endif
void OTPM_TestSeq0(void)
{
    uint32_t retVal;
    MCU_InfoType info;
    uint32_t tc10Data[50];
    uint32_t tc10Len;

    EXECUTE_TEST(BRCM_SWQTST_OTPM_READ_TC10,
            OTPM_ReadTC10Config(tc10Data, sizeof(tc10Data), &tc10Len), BCM_ERR_OK)

    REPORT_RESULT(BRCM_SWQTST_OTPM_READ_TC10, (lTC10Row0 == tc10Data[0]))


    BCM_MemSet(&info, 0U, sizeof(MCU_InfoType));
    retVal = MCU_GetInfo(&info);
    if (BCM_ERR_OK == retVal) {
        REPORT_RESULT(BRCM_SWQTST_OTPM_READ_MAC_CASE0, (lMacAddr0[3] == info.macAddr[3]))
        REPORT_RESULT(BRCM_SWQTST_OTPM_READ_IP_CASE0, (lIPAddr0 == info.ipAddr))
        REPORT_RESULT(BRCM_SWQTST_OTPM_READ_IP_CASE0, (lGWIPAddr0 == info.gwIPAddr))
        REPORT_RESULT(BRCM_SWQTST_OTPM_READ_IP_CASE0, (lNetMask0 == info.netmask))
        REPORT_RESULT(BRCM_SWQTST_OTPM_READ_IP_CASE0, (lAppInfo0 == info.bootInfo))
        REPORT_RESULT(BRCM_SWQTST_OTPM_READ_IP_CASE0, (lTftpIPAddr0 == info.tftpServerAddr))
        REPORT_RESULT(BRCM_SWQTST_OTPM_READ_IP_CASE0, (lVlan == info.vlan))
    } else {
        OtpQtResult = retVal;
    }

    if (OtpQtErrCnt > 0UL) {
        OtpQtResult = BCM_ERR_CUSTOM;
    }
}

void OTPM_TestSeq1(void)
{
    uint32_t retVal;
    MCU_InfoType info;
    OTPM_BootModeType aBootModes;

    EXECUTE_TEST(BRCM_SWQTST_OTPM_GET_EN_BOOTMODE,
            OTPM_GetEnabledBootModes(&aBootModes), BCM_ERR_OK)
    BCM_MemSet(&info, 0U, sizeof(MCU_InfoType));
    retVal = MCU_GetInfo(&info);
    if (BCM_ERR_OK == retVal) {
        REPORT_RESULT(BRCM_SWQTST_OTPM_READ_MAC_CASE1, (lMacAddr1[3] == info.macAddr[3]))
        REPORT_RESULT(BRCM_SWQTST_OTPM_READ_IP_CASE1, (lIPAddr1 == info.ipAddr))
        REPORT_RESULT(BRCM_SWQTST_OTPM_READ_IP_CASE1, (lGWIPAddr1 == info.gwIPAddr))
        REPORT_RESULT(BRCM_SWQTST_OTPM_READ_IP_CASE1, (lNetMask1 == info.netmask))
        REPORT_RESULT(BRCM_SWQTST_OTPM_READ_IP_CASE1, (lAppInfo1 == info.bootInfo))
        REPORT_RESULT(BRCM_SWQTST_OTPM_READ_IP_CASE1, (lTftpIPAddr1 == info.tftpServerAddr))
#ifdef __BCM8958X__
        REPORT_RESULT(BRCM_SWQTST_OTPM_READ_IP_CASE0, (lVlan1 == info.vlan))
#endif
    } else {
        OtpQtResult = retVal;
    }

    if (OtpQtErrCnt > 0UL) {
        OtpQtResult = BCM_ERR_CUSTOM;
    }
}

void OTPM_TestSeq2(void)
{
    uint32_t retVal;
    MCU_InfoType info;

    BCM_MemSet(&info, 0U, sizeof(MCU_InfoType));
    retVal = MCU_GetInfo(&info);
    if (BCM_ERR_OK == retVal) {
        REPORT_RESULT(BRCM_SWQTST_OTPM_READ_MAC_CASE2, (0x0 == info.macAddr[3]))
        REPORT_RESULT(BRCM_SWQTST_OTPM_READ_IP_CASE2, (0x0 == info.ipAddr))
        REPORT_RESULT(BRCM_SWQTST_OTPM_READ_IP_CASE2, (0x0 == info.gwIPAddr))
        REPORT_RESULT(BRCM_SWQTST_OTPM_READ_IP_CASE2, (0x0 == info.netmask))
        REPORT_RESULT(BRCM_SWQTST_OTPM_READ_IP_CASE2, (0x0 == info.bootInfo))
        REPORT_RESULT(BRCM_SWQTST_OTPM_READ_IP_CASE0, (0x0 == info.vlan))
    } else {
        OtpQtResult = retVal;
    }

    if (OtpQtErrCnt > 0UL) {
        OtpQtResult = BCM_ERR_CUSTOM;
    }
}

void OTPM_NegTestSeqs(void)
{
    switch (OtpQtIdx) {
        case BRCM_SWQTSEQ_OTPM_NEG_0:
            OTPM_NegTestSeq0();
            break;
        case BRCM_SWQTSEQ_OTPM_NEG_1:
            OTPM_NegTestSeq1();
            break;
    }
}

TASK(OTPMQT_Task)
{
    int32_t retVal;
    BCM_TestStart(BCM_OTP_ID);
    BCM_SetTestSeq(OtpQtIdx);
    OtpQtErrCnt = 0;

    OtpQtResult = BCM_ERR_OK;

    /*Negative test sequence*/
    OTPM_NegTestSeqs();

#ifdef OTPM_ALT_MEM_ROWS_COUNT
    SVC_RunTestSvc(OtpQtIdx-1, NULL);
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

#ifdef OTPM_ALT_MEM_ROWS_COUNT
        switch (OtpQtIdx) {
            case BRCM_SWQTSEQ_OTPM_0:
                OTPM_TestSeq0();
                break;
            case BRCM_SWQTSEQ_OTPM_1:
                OTPM_TestSeq1();
                break;
            case BRCM_SWQTSEQ_OTPM_2:
                OTPM_TestSeq2();
                break;
        }
#endif

        retVal = MODULE_RunStateHandler(SYS_ModuleFnTable, 1UL, BCM_STATE_UNINIT);
        if (BCM_STATE_UNINIT != OTPM_Module.context->state) {
            OtpQtResult = BCM_ERR_INVAL_STATE;
        }

    } else {
        OtpQtResult = BCM_ERR_INVAL_STATE;
    }

    (void)BCM_TerminateTask();
}

static int32_t OTPM_ExecuteQtInternal(uint32_t aTestIdx)
{
    int32_t retVal;
    StatusType retOS = E_OK;
    TaskStateType taskState = SUSPENDED;
    TaskStateRefType taskStatePtr = &taskState;

    retOS = GetTaskState(OTPMQT_Task, taskStatePtr);
    if (BCM_ERR_OK == retOS) {
        if (SUSPENDED == taskState) {
            OtpQtRunState = BCM_AT_EXECUTING;
            OtpQtIdx = aTestIdx;
            retVal = BCM_ActivateTask(OTPMQT_Task);
            if (BCM_ERR_OK != retVal) {
                retVal = BCM_AT_NOT_STARTED;
                OtpQtRunState = BCM_AT_NOT_STARTED;
                ULOG_ERR("OTPMQT_Task activation failed, error: %d\n\r", retVal);
            }
        } else {
            retVal = BCM_AT_EXECUTING;
            ULOG_ERR("OTPMQT_Task is already running \n\r");
        }
    } else {
        retVal = BCM_ERR_UNKNOWN;
        ULOG_ERR("GetTaskState in OTPM_ExecuteQt failed Error: %d\n\r", retOS);
    }

    return retVal;
}

int32_t OTPM_ExecuteQt(uint32_t aTestIdx)
{
    int32_t retVal = BCM_ERR_OK;

    switch (aTestIdx) {
        case BRCM_SWQTSEQ_OTPM_0:
            retVal = OTPM_ExecuteQtInternal(aTestIdx);
            break;
        case BRCM_SWQTSEQ_OTPM_1:
            retVal = OTPM_ExecuteQtInternal(aTestIdx);
            break;
        case BRCM_SWQTSEQ_OTPM_2:
            retVal = OTPM_ExecuteQtInternal(aTestIdx);
            break;
        case BRCM_SWQTSEQ_OTPM_NEG_0:
            retVal = OTPM_ExecuteQtInternal(aTestIdx);
            break;
        case BRCM_SWQTSEQ_OTPM_NEG_1:
            retVal = OTPM_ExecuteQtInternal(aTestIdx);
            break;
        default:
            retVal = BCM_AT_NOT_AVAILABLE;
            break;
    }

    return retVal;
}

static int32_t OTPM_GetStatusQtInternal(uint32_t aTestIdx)
{
    int32_t retVal;
    StatusType retOS = E_OK;
    TaskStateType taskState = RUNNING;
    TaskStateRefType taskStatePtr = &taskState;

    if (OtpQtIdx == aTestIdx) {
        retOS = GetTaskState(OTPMQT_Task, taskStatePtr);
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
            ULOG_ERR("GetTaskState in OTPM_GetStatusQt failed Error: %d\n\r", retOS);
        }
    } else {
        retVal = BCM_AT_NOT_AVAILABLE;
    }

    return retVal;
}

int32_t OTPM_GetStatusQt(uint32_t aTestIdx)
{
    int32_t retVal;

    switch (aTestIdx) {
        case BRCM_SWQTSEQ_OTPM_0:
            retVal = OTPM_GetStatusQtInternal(aTestIdx);
            break;
        case BRCM_SWQTSEQ_OTPM_1:
            retVal = OTPM_GetStatusQtInternal(aTestIdx);
            break;
        case BRCM_SWQTSEQ_OTPM_2:
            retVal = OTPM_GetStatusQtInternal(aTestIdx);
            break;
        case BRCM_SWQTSEQ_OTPM_NEG_0:
            retVal = OTPM_GetStatusQtInternal(aTestIdx);
            break;
        case BRCM_SWQTSEQ_OTPM_NEG_1:
            retVal = OTPM_GetStatusQtInternal(aTestIdx);
            break;
        default:
            retVal = BCM_AT_NOT_AVAILABLE;
            break;
    }

    return retVal;
}

#ifdef __BCM8958X__
int32_t OTPM_ExecuteSecQt(uint32_t aTestIdx)
{
    return BCM_AT_NOT_AVAILABLE;
}

int32_t OTPM_GetStatusSecQt(uint32_t aTestIdx)
{
    return BCM_AT_NOT_AVAILABLE;
}
#endif
