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
#include <module.h>
#include <module_helper.h>
#include <bcm_utils.h>
//#include <otpm_sec_test_data.h>
#include <crc.h>
#include <mpu.h>

#define GetModuleLogLevel()     ULOG_LVL_INFO

#define OTPM_CRC32_POLY                  (0x04C11DB7UL)

#define OTPMT_CHECK(check)                 \
        if (!(check)) {                    \
            if (!OTPMT_ErrLine) {          \
                OTPMT_ErrLine = __LINE__;  \
            }                              \
            OTPMT_Result = BCM_ERR_CUSTOM; \
        }

uint32_t OTPMT_ErrLine;
uint32_t OTPMT_Result;
uint32_t OTPMT_TestNum;
uint32_t OTPMT_State;

static const MODULE_Type* const SYS_ModuleFnTable[MODULE_COUNT_MAX] = {
    &OTPM_Module,
};

static uint32_t OTPMT_CheckKey0[] = {
0x09ff87ae, 0x055cc29e, 0x78f7aa84, 0x734c320f, 0x54d7bc48, 0x3cc998d9, 0xbbecd494, 0x0a614cef,
0x51649f17, 0x54ed5f2b, 0xca70457a, 0xbb8eae0a, 0x8beb4aa5, 0xbdfbaa0f, 0x88a163d1, 0xba135548,
0xdba1fc35, 0x4ed6b1c3, 0x9d9379d2, 0x7556ac5f, 0xb326b70c, 0x43067b3e, 0xeb1c19b3, 0x201af18c,
0x9bdf68c4, 0x55a03068, 0x57555add, 0x3ea698e8, 0xe1bc2842, 0xc044a8d8, 0xf88fb942, 0x3ccd6ab7,
0xc625a4df, 0x47c8f3a1, 0x74c2bb72, 0x893374b4, 0x69ba9580, 0xe0d2216a, 0x03335daa, 0xcf13f80f,
0x06f929eb, 0xe15a0a4d, 0x3d50c3fa, 0x774d9646, 0xe9525aef, 0xaeaf0408, 0x76a0b73a, 0xf1663e8a,
0xf87123c3, 0x55545364, 0xe0cea5a1, 0xdeefe67f, 0xea59554c, 0xa4f11c0d, 0x7df6ca10, 0x21d57c4c,
0x3af4410c, 0x2a7b4339, 0x51e7868f, 0xe99d78f0, 0x5c6018f7, 0xe3739950, 0x347bf250, 0x9bd04607,
};

#define OTPMT_SEC_BOOT_IDX      (58*4-16)
#define OTPMT_PUB_KEY_IDX       (59*4-16)

static const uint8_t OTPMT_AltMemData[1024*4-16] = {
/* RSA Key Magic : 0x52531010 */
[OTPMT_SEC_BOOT_IDX+0] = 0x10,
[OTPMT_SEC_BOOT_IDX+1] = 0x10,
[OTPMT_SEC_BOOT_IDX+2] = 0x53,
[OTPMT_SEC_BOOT_IDX+3] = 0x52,
[OTPMT_PUB_KEY_IDX] =
    0x00,  0x01,  0x02,  0x03,  0x04,  0x05,  0x06,  0x07,  0x08,  0x09,  0x0A,  0x0B,  0x0C,  0x0D,  0x0E,  0x0F,
    0x10,  0x11,  0x12,  0x13,  0x14,  0x15,  0x16,  0x17,  0x18,  0x19,  0x1A,  0x1B,  0x1C,  0x1D,  0x1E,  0x1F,
    0x20,  0x21,  0x22,  0x23,  0x24,  0x25,  0x26,  0x27,  0x28,  0x29,  0x2A,  0x2B,  0x2C,  0x2D,  0x2E,  0x2F,
    0x30,  0x31,  0x32,  0x33,  0x34,  0x35,  0x36,  0x37,  0x38,  0x39,  0x3A,  0x3B,  0x3C,  0x3D,  0x3E,  0x3F,
    0x40,  0x41,  0x42,  0x43,  0x44,  0x45,  0x46,  0x47,  0x48,  0x49,  0x4A,  0x4B,  0x4C,  0x4D,  0x4E,  0x4F,
    0x50,  0x51,  0x52,  0x53,  0x54,  0x55,  0x56,  0x57,  0x58,  0x59,  0x5A,  0x5B,  0x5C,  0x5D,  0x5E,  0x5F,
    0x60,  0x61,  0x62,  0x63,  0x64,  0x65,  0x66,  0x67,  0x68,  0x69,  0x6A,  0x6B,  0x6C,  0x6D,  0x6E,  0x6F,
    0x70,  0x71,  0x72,  0x73,  0x74,  0x75,  0x76,  0x77,  0x78,  0x79,  0x7A,  0x7B,  0x7C,  0x7D,  0x7E,  0x7F,
    0x80,  0x81,  0x82,  0x83,  0x84,  0x85,  0x86,  0x87,  0x88,  0x89,  0x8A,  0x8B,  0x8C,  0x8D,  0x8E,  0x8F,
    0x90,  0x91,  0x92,  0x93,  0x94,  0x95,  0x96,  0x97,  0x98,  0x99,  0x9A,  0x9B,  0x9C,  0x9D,  0x9E,  0x9F,
    0xA0,  0xA1,  0xA2,  0xA3,  0xA4,  0xA5,  0xA6,  0xA7,  0xA8,  0xA9,  0xAA,  0xAB,  0xAC,  0xAD,  0xAE,  0xAF,
    0xB0,  0xB1,  0xB2,  0xB3,  0xB4,  0xB5,  0xB6,  0xB7,  0xB8,  0xB9,  0xBA,  0xBB,  0xBC,  0xBD,  0xBE,  0xBF,
    0xC0,  0xC1,  0xC2,  0xC3,  0xC4,  0xC5,  0xC6,  0xC7,  0xC8,  0xC9,  0xCA,  0xCB,  0xCC,  0xCD,  0xCE,  0xCF,
    0xD0,  0xD1,  0xD2,  0xD3,  0xD4,  0xD5,  0xD6,  0xD7,  0xD8,  0xD9,  0xDA,  0xDB,  0xDC,  0xDD,  0xDE,  0xDF,
    0xE0,  0xE1,  0xE2,  0xE3,  0xE4,  0xE5,  0xE6,  0xE7,  0xE8,  0xE9,  0xEA,  0xEB,  0xEC,  0xED,  0xEE,  0xEF,
    0xF0,  0xF1,  0xF2,  0xF3,  0xF4,  0xF5,  0xF6,  0xF7,  0xF8,  0xF9,  0xFA,  0xFB,  0xFC,  0xFD,  0xFE,  0xFF,
};

void SVC_TestSvcHandler(uint32_t aMagicID, uint32_t aCmd, uint8_t *aSysIO)
{
    if (aCmd == 1U) {
        MPU_Disable();
        OTPM_AltMemHdrType * const otpAltMemHdr = (void *)OTPM_AltMem;
        otpAltMemHdr->magic = 0x4f545041UL;
        otpAltMemHdr->crc = BCM_CRC32(OTPMT_AltMemData, sizeof(OTPMT_AltMemData), OTPM_CRC32_POLY);
        otpAltMemHdr->reserved[0] = 0U;
        otpAltMemHdr->reserved[1] = 0U;
        BCM_MemCpy((uint8_t *)OTPM_AltMem + sizeof(OTPM_AltMemHdrType), OTPMT_AltMemData, sizeof(OTPMT_AltMemData));
        MPU_Enable();
    } else if (aCmd == 2U) {
        MPU_Disable();
        BCM_MemSet((uint8_t *)OTPM_AltMem, 0, sizeof(OTPM_AltMemHdrType));
        MPU_Enable();

    }
}

void OTPM_TestSecureSeq(uint32_t aUseAltMem)
{
    uint8_t pubKey[300];
    uint32_t pubKeyLen;
    uint32_t pubKeyType;

    OTPMT_CHECK(OTPM_ReadPubKey(pubKey, sizeof(pubKey), &pubKeyType, &pubKeyLen) == BCM_ERR_OK);
    OTPMT_CHECK(pubKeyLen == sizeof(OTPMT_CheckKey0));
    if (aUseAltMem) {
        OTPMT_CHECK(memcmp(pubKey, &OTPMT_AltMemData[OTPMT_PUB_KEY_IDX], pubKeyLen) == 0);
    } else {
        OTPMT_CHECK(memcmp(pubKey, OTPMT_CheckKey0, pubKeyLen) == 0);
    }
}

TASK(OTPMQT_Task)
{
    int32_t retVal;
    OTPMT_Result = BCM_ERR_OK;

    if (BRCM_SWQTSEQ_OTPM_SECURE_1 == OTPMT_TestNum) {
        SVC_RunTestSvc(1, NULL);
    } else {
        SVC_RunTestSvc(2, NULL);
    }

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

        switch (OTPMT_TestNum) {
            case BRCM_SWQTSEQ_OTPM_SECURE_0:
                OTPM_TestSecureSeq(0);
                break;
            case BRCM_SWQTSEQ_OTPM_SECURE_1:
                OTPM_TestSecureSeq(1);
                break;
            default:
                OTPMT_Result = BCM_ERR_UNKNOWN;
                break;
        }

        retVal = MODULE_RunStateHandler(SYS_ModuleFnTable, 1UL, BCM_STATE_UNINIT);
        if (BCM_STATE_UNINIT != OTPM_Module.context->state) {
            OTPMT_Result = BCM_ERR_INVAL_STATE;
        }

    } else {
        OTPMT_Result = BCM_ERR_INVAL_STATE;
    }

    (void)BCM_TerminateTask();
}

static int32_t OTPM_ExecuteSecQtInternal(uint32_t aTestIdx)
{
    int32_t retVal;
    StatusType retOS = E_OK;
    TaskStateType taskState = SUSPENDED;
    TaskStateRefType taskStatePtr = &taskState;

    retOS = GetTaskState(OTPMQT_Task, taskStatePtr);
    if (BCM_ERR_OK == retOS) {
        if (SUSPENDED == taskState) {
            OTPMT_State = BCM_AT_EXECUTING;
            OTPMT_TestNum = aTestIdx;
            retVal = BCM_ActivateTask(OTPMQT_Task);
            if (BCM_ERR_OK != retVal) {
                retVal = BCM_AT_NOT_STARTED;
                OTPMT_State = BCM_AT_NOT_STARTED;
                ULOG_ERR("OTPMQT_Task activation failed, error: %d\n\r", retVal);
            }
        } else {
            retVal = BCM_AT_EXECUTING;
            ULOG_ERR("OTPMQT_Task is already running \n\r");
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

    if (OTPMT_TestNum == aTestIdx) {
        retOS = GetTaskState(OTPMQT_Task, taskStatePtr);
        if (BCM_ERR_OK == retOS) {
            if ((SUSPENDED == taskState) &&
                (BCM_AT_EXECUTING == OTPMT_State)) {
                OTPMT_State = BCM_AT_NOT_STARTED;
                retVal = OTPMT_Result;
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

int32_t OTPM_ExecuteQt(uint32_t aTestIdx)
{
    return BCM_AT_NOT_AVAILABLE;
}

int32_t OTPM_GetStatusQt(uint32_t aTestIdx)
{
    return BCM_AT_NOT_AVAILABLE;
}

