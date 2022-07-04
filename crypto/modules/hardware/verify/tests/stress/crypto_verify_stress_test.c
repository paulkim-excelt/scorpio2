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
#include <ee.h>
#include <bcm_utils.h>
#include <bcm_osil.h>
#include <bcm_test.h>
#include <pt_utils.h>
#include <crc.h>
#include <module.h>
#include <module_helper.h>
#include <crypto_module.h>
#include <crypto_verify.h>
#include <osil/time_module_osil.h>

#define CRYPTOTEST_MODULE_COUNT_MAX         (2UL)

typedef struct sCRYPTOTEST_MsgChunkDesc {
    uint32_t offset;
    uint32_t size;
} CRYPTOTEST_MsgChunkDesc;

typedef struct sCRYPTOTEST_ParamsType {
    CRYPTO_AlgoType keyAlgo;
    uint32_t msgSize;
    uint32_t msg[512UL / 4UL];
    uint32_t sig[256UL / 4UL];
    int32_t expectedResult;
} CRYPTOTEST_ParamsType;

volatile int32_t CRYPTOTEST_FailLine = 0UL;
volatile int32_t CRYPTOTEST_Result = BCM_AT_NOT_AVAILABLE;

volatile int32_t CRYPTOTEST_ParamsAvailable;
volatile int32_t CRYPTOTEST_ExecStatus;
volatile CRYPTOTEST_ParamsType CRYPTOTEST_Params;

const MODULE_Type* const CRYPTOTEST_Modules[CRYPTOTEST_MODULE_COUNT_MAX] = {
    &TIME_Module,
    &CRYPTO_VerifyModule,
};

void CRYPTO_GetServer(int32_t *aServerTask, uint32_t *aServerEvent)
{
    *aServerTask = CRYPTOTEST_ServerTask;
    *aServerEvent = MODULE_EVENT;
}

TASK(CRYPTOTEST_ServerTask)
{
    int32_t ret;
    BCM_EventMaskType mask;
    const uint32_t eventMask = MODULE_GetEventMask(CRYPTOTEST_Modules, CRYPTOTEST_MODULE_COUNT_MAX);

    ret = MODULE_ResetStateHandler(CRYPTOTEST_Modules, CRYPTOTEST_MODULE_COUNT_MAX);
    BCM_SetEvent(CRYPTOTEST_Task, SystemEvent0);
    if (BCM_ERR_OK != ret) {
        CRYPTOTEST_Result = ret;
        goto exit;
    }

    while(1UL) {
        BCM_WaitEvent(eventMask);
        BCM_GetEvent(CRYPTOTEST_ServerTask, &mask);
        BCM_ClearEvent(mask);
        MODULE_EventHandler(CRYPTOTEST_Modules, CRYPTOTEST_MODULE_COUNT_MAX, mask);
    }

exit:
    BCM_TerminateTask();
}

TASK(CRYPTOTEST_Task)
{
    uint32_t i;
    MSGQ_HdlType msgQCtx;
    MSGQ_HdlType jobHdl;
    int32_t ret = BCM_ERR_OK;
    int32_t status = BCM_ERR_OK;
    BCM_EventMaskType mask;
    CRYPTO_VerifyInitType ctxInitParams;

    BCM_ActivateTask(CRYPTOTEST_ServerTask);

    BCM_WaitEvent(SystemEvent0);
    BCM_GetEvent(CRYPTOTEST_Task, &mask);
    BCM_ClearEvent(mask);

    while (1UL) {
        /* Wait for the debugger to finish uploading the data */
        CRYPTOTEST_ExecStatus = BCM_AT_NOT_STARTED;
        while (0UL == CRYPTOTEST_ParamsAvailable);

        CRYPTOTEST_Result = BCM_ERR_INVAL_STATE;
        CRYPTOTEST_ExecStatus = BCM_AT_EXECUTING;
        CRYPTOTEST_ParamsAvailable = 0UL;

        /* Initialize context */
        if (CRYPTO_ALGO_RSA2K == CRYPTOTEST_Params.keyAlgo) {
            ctxInitParams.algo = CRYPTO_ALGO_RSA2K;
            ctxInitParams.hash = CRYPTO_ALGO_SHA256;
            ctxInitParams.padding = CRYPTO_ALGO_PKCS21;
            ctxInitParams.sigLen = 256UL;
        } else {
            ctxInitParams.algo = CRYPTO_ALGO_ECDSA384;
            ctxInitParams.hash = CRYPTO_ALGO_SHA384;
            ctxInitParams.padding = 0UL;
            ctxInitParams.sigLen = 96UL;
        }

        ctxInitParams.signature = (uint8_t *) &CRYPTOTEST_Params.sig;
        ctxInitParams.msgLength = CRYPTOTEST_Params.msgSize;

        ret = CRYPTO_VerifyInit(&ctxInitParams, SystemEvent0,
                                &msgQCtx,
                                &jobHdl);

        if (BCM_ERR_OK == ret) {
            /* Wait for the init to resolve */
            BCM_WaitEvent(SystemEvent0);
            BCM_GetEvent(CRYPTOTEST_Task, &mask);
            BCM_ClearEvent(mask);

            ret = CRYPTO_VerifyStatus(msgQCtx, jobHdl, &status);
            if ((BCM_ERR_OK == ret) && (BCM_ERR_BUSY == status)) {
                /* Issue update calls */
                const uint32_t chunkCount = CRYPTOTEST_Params.msgSize / 128UL;
                for (i = 0UL; (i < chunkCount) && (BCM_ERR_OK == ret); i++) {
                    CRYPTO_VerifyUpdateType update;
                    update.chunkSize = 128UL;
                    update.chunkData = (uint8_t *) CRYPTOTEST_Params.msg + (i * 128UL);

                    ret = CRYPTO_VerifyUpdate(msgQCtx, &update, &jobHdl);
                    if (BCM_ERR_OK == ret) {
                        BCM_WaitEvent(SystemEvent0);
                        BCM_GetEvent(CRYPTOTEST_Task, &mask);
                        BCM_ClearEvent(mask);

                        ret = CRYPTO_VerifyStatus(msgQCtx, jobHdl, &status);
                        if (BCM_ERR_OK == ret) {
                            if (((chunkCount - 1UL) != i) && (BCM_ERR_BUSY != status)) {
                                /*
                                    Status should never be anything other than busy
                                    while we have a message buffer yet to process
                                */
                                CRYPTOTEST_FailLine = __LINE__;
                                ret = BCM_ERR_UNKNOWN;
                            } else if ((chunkCount - 1UL) == i) {
                                if (status == CRYPTOTEST_Params.expectedResult) {
                                    /* Test passed */
                                    CRYPTOTEST_Result = BCM_ERR_OK;
                                } else {
                                    /* Test failed */
                                    CRYPTOTEST_FailLine = __LINE__;
                                    ret = BCM_ERR_UNKNOWN;
                                }
                            } else {
                                /* Do nothing */
                            }

                        } else {
                            /* Verify status failed */
                            CRYPTOTEST_FailLine = __LINE__;
                        }
                    } else {
                        /* Update failed */
                        CRYPTOTEST_FailLine = __LINE__;
                    }
                }
            } else {
                /* Init resolved with inval status */
                CRYPTOTEST_FailLine = __LINE__;
            }
        } else {
            /* Init failed */
            CRYPTOTEST_FailLine = __LINE__;
        }
    }

    return;
}

int32_t BCM_ExecuteAT(uint32_t aIndex)
{
    return BCM_AT_EXECUTING;
}

int32_t BCM_GetResultAT(uint32_t aIndex)
{
    return BCM_AT_NOT_AVAILABLE;
}

