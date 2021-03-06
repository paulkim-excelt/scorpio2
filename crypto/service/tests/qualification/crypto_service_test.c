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
#include <stdint.h>
#include <string.h>
#include <bcm_err.h>
#include <ipc.h>
#include <bcm_utils.h>
#include <osil/bcm_osil.h>
#include <bcm_test.h>
#include <bcm_time.h>
#include <ipc.h>
#include <crypto_service.h>
#include <rpc_module_v2.h>
#include <ipc_osil.h>
#include <rpc_mem.h>
#include <module.h>
#include <module_helper.h>
#include <crypto_module.h>
#include <crypto_verify.h>
#include <otp_module_osil.h>
#include "ipc_test.h"
#include "ee.h"

#define CRPTST_LOG(result, expec)                  \
    do {                                           \
        if ((result) != (expec)) {                 \
                CRPTST_ErrorValue = result;        \
                CRPTST_ErrorLine = __LINE__;       \
                CRPTST_SetResult(BCM_ERR_UNKNOWN); \
        } else {                                   \
            CRPTST_Progress =  __LINE__;           \
        }                                          \
    } while(0)

#define CRPTST_NUM_CTX     2U

#if CRPTST_IPC_LOOP_BACK == 1
#define CRPTST_ADDR_TRANS(aAddr)        (aAddr)
#else
#define CRPTST_ADDR_TRANS(aAddr)        (void *)((((uint32_t)(aAddr))&0x0FFFFFFFUL)|0x90000000UL)
#endif

int32_t CRPTST_TestResult = BCM_AT_NOT_STARTED;
uint32_t CRPTST_ErrorLine;
uint32_t CRPTST_ErrorValue;
uint32_t CRPTST_Progress;
uint32_t volatile CRPTST_TestNum;

static const int32_t CRPTST_SigResult[] = { BCM_ERR_OK, BCM_ERR_AUTH_FAILED };

static uint8_t CRPTST_Msg[2][128];
static const uint8_t CRPTST_ConstMsg[2][128] = {
    {
        0x33,0x30,0x37,0x38,0x36,0x32,0x33,0x34,0x33,0x31,0x33,0x32,0x36,0x35,0x36,0x36,
        0x36,0x36,0x33,0x30,0x36,0x32,0x33,0x36,0x33,0x39,0x33,0x30,0x36,0x32,0x33,0x38,
        0x36,0x32,0x33,0x39,0x36,0x31,0x33,0x34,0x36,0x33,0x36,0x34,0x36,0x31,0x33,0x37,
        0x36,0x35,0x33,0x31,0x33,0x32,0x36,0x33,0x33,0x36,0x33,0x35,0x33,0x33,0x33,0x33,
        0x36,0x33,0x36,0x36,0x33,0x38,0x33,0x37,0x33,0x35,0x33,0x38,0x36,0x33,0x33,0x38,
        0x33,0x31,0x36,0x35,0x33,0x32,0x36,0x36,0x33,0x33,0x33,0x37,0x33,0x38,0x36,0x34,
        0x36,0x32,0x33,0x38,0x33,0x36,0x33,0x37,0x33,0x38,0x36,0x36,0x36,0x31,0x33,0x38,
        0x33,0x39,0x33,0x39,0x33,0x39,0x33,0x38,0x33,0x37,0x36,0x32,0x33,0x37,0x33,0x38
    },
    {
        0x33,0x30,0x00,0x38,0x36,0x32,0x33,0x34,0x33,0x31,0x33,0x32,0x36,0x35,0x36,0x36,
        0x36,0x36,0x33,0x30,0x36,0x32,0x33,0x36,0x33,0x39,0x33,0x30,0x36,0x32,0x33,0x38,
        0x36,0x32,0x33,0x39,0x36,0x31,0x33,0x34,0x36,0x33,0x36,0x34,0x36,0x31,0x33,0x37,
        0x36,0x35,0x33,0x31,0x33,0x32,0x36,0x33,0x33,0x36,0x33,0x35,0x33,0x33,0x33,0x33,
        0x36,0x33,0x36,0x36,0x33,0x38,0x33,0x37,0x33,0x35,0x33,0x38,0x36,0x33,0x33,0x38,
        0x33,0x31,0x36,0x35,0x33,0x32,0x36,0x36,0x33,0x33,0x33,0x37,0x33,0x38,0x36,0x34,
        0x36,0x32,0x33,0x38,0x33,0x36,0x33,0x37,0x33,0x38,0x36,0x36,0x36,0x31,0x33,0x38,
        0x33,0x39,0x33,0x39,0x33,0x39,0x33,0x38,0x33,0x37,0x36,0x32,0x33,0x37,0x33,0x38
    }
};

static uint8_t CRPTST_Signature[2][256];
static const uint8_t CRPTST_ConstSignature[2][256] = {
    {
        0x6a,0x9c,0x90,0x26,0x98,0x9f,0x35,0xd6,0x96,0xd7,0xa9,0x4a,0xb9,0x49,0x70,0xb1,
        0x31,0xaf,0xd2,0x56,0x39,0xc6,0x26,0x76,0x79,0x2a,0x05,0x9a,0x16,0xb0,0xdf,0xe8,
        0x31,0xb5,0xc9,0x7e,0xba,0x95,0xa5,0x30,0x05,0x0c,0x44,0x57,0x7e,0x88,0x83,0x58,
        0x4e,0x52,0x48,0x84,0x96,0x02,0x0c,0x26,0x0f,0xa6,0x9a,0xf6,0xe0,0x4b,0x31,0x28,
        0x1a,0xb9,0xbc,0x0b,0x65,0x97,0x61,0xa9,0xb6,0x81,0x7c,0x61,0xcd,0xb8,0xab,0x9b,
        0xde,0xcb,0xec,0xc0,0x04,0x5b,0x97,0xae,0x0f,0x26,0x51,0xf7,0xf9,0x40,0x92,0x4c,
        0x68,0x44,0x2c,0x05,0x3d,0x5c,0x82,0x12,0xf8,0xb4,0x07,0x9a,0xc8,0xbe,0x1b,0x01,
        0xee,0x7b,0x12,0xe5,0x15,0x5a,0x83,0x29,0x8e,0xba,0xf3,0x27,0x2a,0x80,0x95,0x12,
        0xac,0x9c,0x68,0x25,0xbc,0x8c,0xd8,0x1a,0x44,0x1b,0x68,0x38,0xaf,0xa2,0x2d,0xcd,
        0xc0,0x07,0xf6,0x3c,0x8f,0x10,0xce,0x81,0x58,0xd7,0x6b,0x8c,0x82,0x46,0x9f,0x14,
        0x1e,0xfe,0x45,0xf6,0x1d,0x67,0x2a,0x33,0xbc,0xa9,0x61,0xd4,0xc3,0x92,0x5f,0x23,
        0x26,0x9f,0x64,0x45,0x7d,0x74,0xb6,0xd5,0x78,0xb1,0xad,0x53,0x36,0xd1,0xe6,0xd7,
        0x10,0x10,0xa1,0xd5,0xa1,0xdb,0xcc,0x2b,0x2b,0x45,0x88,0xe1,0xe0,0x13,0x66,0x42,
        0x1f,0x21,0x3b,0x73,0xef,0x5f,0x0d,0xdb,0x10,0x69,0x67,0x79,0xac,0x97,0xb1,0xe9,
        0x6b,0x9d,0xd8,0xa0,0xd9,0x2e,0x90,0x25,0x2b,0x5d,0x0c,0xcd,0x7f,0x1d,0xaf,0xfa,
        0x45,0x90,0x5d,0x53,0x22,0x40,0xa4,0x7e,0x85,0xea,0x9e,0xb8,0x41,0x76,0x58,0x58
    },
    {
        0x6a,0x9c,0x90,0x26,0x98,0x9f,0x35,0xd6,0x96,0xd7,0xa9,0x4a,0xb9,0x49,0x70,0xb1,
        0x31,0xaf,0xd2,0x56,0x39,0xc6,0x26,0x76,0x79,0x2a,0x05,0x9a,0x16,0xb0,0xdf,0xe8,
        0x31,0xb5,0xc9,0x7e,0xba,0x95,0xa5,0x30,0x05,0x0c,0x44,0x57,0x7e,0x88,0x83,0x58,
        0x4e,0x52,0x48,0x84,0x96,0x02,0x0c,0x26,0x0f,0xa6,0x9a,0xf6,0xe0,0x4b,0x31,0x28,
        0x1a,0xb9,0xbc,0x0b,0x65,0x97,0x61,0xa9,0xb6,0x81,0x7c,0x61,0xcd,0xb8,0xab,0x9b,
        0xde,0xcb,0xec,0xc0,0x04,0x5b,0x97,0xae,0x0f,0x26,0x51,0xf7,0xf9,0x40,0x92,0x4c,
        0x68,0x44,0x2c,0x05,0x3d,0x5c,0x82,0x12,0xf8,0xb4,0x07,0x9a,0xc8,0xbe,0x1b,0x01,
        0xee,0x7b,0x12,0xe5,0x15,0x5a,0x83,0x29,0x8e,0xba,0xf3,0x27,0x2a,0x80,0x95,0x12,
        0xac,0x9c,0x68,0x25,0xbc,0x8c,0xd8,0x1a,0x44,0x1b,0x68,0x38,0xaf,0xa2,0x2d,0xcd,
        0xc0,0x07,0xf6,0x3c,0x8f,0x10,0xce,0x81,0x58,0xd7,0x6b,0x8c,0x82,0x46,0x9f,0x14,
        0x1e,0xfe,0x45,0xf6,0x1d,0x67,0x2a,0x33,0xbc,0xa9,0x61,0xd4,0xc3,0x92,0x5f,0x23,
        0x26,0x9f,0x64,0x45,0x7d,0x74,0xb6,0xd5,0x78,0xb1,0xad,0x53,0x36,0xd1,0xe6,0xd7,
        0x10,0x10,0xa1,0xd5,0xa1,0xdb,0xcc,0x2b,0x2b,0x45,0x88,0xe1,0xe0,0x13,0x66,0x42,
        0x1f,0x21,0x3b,0x73,0xef,0x5f,0x0d,0xdb,0x10,0x69,0x67,0x79,0xac,0x97,0xb1,0xe9,
        0x6b,0x9d,0xd8,0xa0,0xd9,0x2e,0x90,0x25,0x2b,0x5d,0x0c,0xcd,0x7f,0x1d,0xaf,0xfa,
        0x45,0x90,0x5d,0x53,0x22,0x40,0xa4,0x7e,0x85,0xea,0x9e,0xb8,0x41,0x76,0x58,0x58
    },
};

RPC_MemMsgType CRPTST_MsgSent;
RPC_MemMsgType CRPTST_MsgRcvd;
uint32_t CRPTST_RcvCmd;
uint32_t CRPTST_RcvLen;
uint32_t CRPTST_KeepAlive;

const MODULE_Type* const CRPTST_Modules[MODULE_COUNT_MAX] = {
    &OTPM_Module,
    &CRYPTO_Service.client,
    &RPC_Module,
};

void CRPTST_SetResult(int32_t aResult)
{
    CRPTST_TestResult = aResult;
    CRPTST_KeepAlive = FALSE;
#if CRPTST_ENABLE_SLAVE == 1
    BCM_SetEvent(CRPTST_RPCTask, MODULE_EVENT);
#endif
    BCM_TerminateTask();
}

#if CRPTST_ENABLE_SLAVE == 1
TASK(CRPTST_RPCTask)
{
    int32_t ret;
    uint32_t allMask;
    uint32_t mask;

    IPCT_Reset(CRPTST_CHANNEL);

    allMask = MODULE_GetEventMask(CRPTST_Modules, MODULE_COUNT_MAX);
    do {
        ret = MODULE_ResetStateHandler(CRPTST_Modules, MODULE_COUNT_MAX);
    } while (BCM_ERR_BUSY == ret);

    CRPTST_LOG(ret, BCM_ERR_OK);

    while(CRPTST_KeepAlive) {
        MODULE_EventHandler(CRPTST_Modules, MODULE_COUNT_MAX, mask);
        BCM_WaitEvent(allMask);
        BCM_GetEvent(CRPTST_RPCTask, &mask);
        BCM_ClearEvent(mask);
    }
    BCM_TerminateTask();
}
#endif

int32_t CRPTST_GetStatus(int32_t *aStatus, BCM_HandleType *aCtx)
{
    int ret;
    do {
        ret = IPCT_Recv(CRPTST_CHANNEL,
                        IPC_CHANN_MODE_MASTER,
                        &CRPTST_RcvCmd,
                        (void *)&CRPTST_MsgRcvd,
                        &CRPTST_RcvLen);
    } while(ret != BCM_ERR_OK);

    if (CRPTST_MsgRcvd.response == BCM_ERR_OK) {
        CRYPTO_VerifyResponseType * const response = (void *)CRPTST_MsgRcvd.payload;
        *aStatus = response->status;
        *aCtx = response->ctxHdl;
    }

    return CRPTST_MsgRcvd.response;
}

BCM_HandleType ctxHdl[CRPTST_NUM_CTX];

TASK(CRPTST_Task)
{
    CRYPTO_VerifyInitType *initData;
    CRYPTO_VerifyUpdateType *updateData;
    int32_t ret;
    int32_t status;
    uint32_t i;
    BCM_HandleType tmpCtx;

    memcpy(CRPTST_Msg, CRPTST_ConstMsg, sizeof(CRPTST_Msg));
    memcpy(CRPTST_Signature, CRPTST_ConstSignature, sizeof(CRPTST_Signature));

    IPCT_PostInit(CRPTST_CHANNEL);

    for (i = 0; i < CRPTST_NUM_CTX; i++) {
        CRPTST_MsgSent.magic = RPC_MEMMSG_MAGIC;
        CRPTST_MsgSent.cmd = BCM_CMDID(BCM_GROUPID_CRYPTO, BCM_CVM_ID, CRYPTO_VERIFY_INIT);
        CRPTST_MsgSent.len = sizeof(*initData);
        initData = (void *)CRPTST_MsgSent.payload;
        initData->keyHdl = CRYPTO_KEY_HDL_MVK;
        initData->algo = CRYPTO_ALGO_RSA2K;
        initData->hash = CRYPTO_ALGO_SHA256;
        initData->padding = CRYPTO_ALGO_PKCS21;
        initData->sigLen = sizeof(CRPTST_Signature[i]);
        initData->msgLength = sizeof(CRPTST_Msg[i]);
        initData->signature = CRPTST_ADDR_TRANS(CRPTST_Signature[i]);

        ret = IPCT_Send(CRPTST_CHANNEL,
                IPC_CHANN_MODE_MASTER,
                CRPTST_MsgSent.cmd,
                (void *)&CRPTST_MsgSent,
                sizeof(CRPTST_MsgSent));
        CRPTST_LOG(ret, BCM_ERR_OK);

        ret = CRPTST_GetStatus(&status, &ctxHdl[i]);
        CRPTST_LOG(ret, BCM_ERR_OK);
        CRPTST_LOG(status, BCM_ERR_BUSY);
    }

    for (i = 0; i < CRPTST_NUM_CTX; i++) {
        CRPTST_MsgSent.magic = RPC_MEMMSG_MAGIC;
        CRPTST_MsgSent.cmd = BCM_CMDID(BCM_GROUPID_CRYPTO, BCM_CVM_ID, CRYPTO_VERIFY_UPDATE);
        CRPTST_MsgSent.len = sizeof(*updateData);
        updateData = (void *)CRPTST_MsgSent.payload;
        updateData->ctxHdl = ctxHdl[i];
        updateData->chunkSize = sizeof(CRPTST_Msg[i]);
        updateData->chunkData = CRPTST_ADDR_TRANS(CRPTST_Msg[i]);
        ret = IPCT_Send(CRPTST_CHANNEL,
                IPC_CHANN_MODE_MASTER,
                CRPTST_MsgSent.cmd,
                (void *)&CRPTST_MsgSent,
                sizeof(CRPTST_MsgSent));
        CRPTST_LOG(ret, BCM_ERR_OK);

        ret = CRPTST_GetStatus(&status, &tmpCtx);
        CRPTST_LOG(ret, BCM_ERR_OK);
        //CRPTST_LOG(tmpCtx, ctxHdl[i]);
        CRPTST_LOG(status, CRPTST_SigResult[i]);
    }

    CRPTST_SetResult(BCM_ERR_OK); /* All tests are passing */
}

/* Start Test */
int32_t BCM_ExecuteAT(uint32_t aIndex)
{
    int32_t retVal = BCM_ERR_OK;

    switch(aIndex) {
    case 1U:
        CRPTST_TestNum = 0;
        CRPTST_TestResult = BCM_AT_EXECUTING;
        CRPTST_KeepAlive = TRUE;
#if CRPTST_ENABLE_SLAVE == 1
        retVal = BCM_ActivateTask(CRPTST_RPCTask);
#endif
#if CRPTST_ENABLE_MASTER == 1
        retVal = BCM_ActivateTask(CRPTST_Task);
#endif
        break;

    default:
        retVal = BCM_AT_NOT_AVAILABLE;
        break;
    }

    return retVal;
}

/* Get Test results */
int32_t BCM_GetResultAT(uint32_t aIndex)
{
    int32_t retVal = BCM_ERR_OK;

    switch(aIndex) {
    case 1U:
        retVal = CRPTST_TestResult;
        break;
    default:
        retVal = BCM_AT_NOT_AVAILABLE;
        break;
    }
    return retVal;
}

void APP_Init(void)
{
}