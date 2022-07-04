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
#include "crypto_verify_test.h"

#define CRYPTOTEST_MSG_CHUNK_CNT      (CRYPTOTEST_MSG_SIZE / CRYPTOTEST_MSG_CHUNK_SIZE)

BCM_TaskType CRYPTOQT_TaskId;
const MODULE_Type* CRYPTOQT_Modules[CRYPTOTEST_MODULE_COUNT_MAX];
static int32_t  CryptoQtSrvTaskActv;
static int32_t  CryptoQtKeepAlive = FALSE;

#ifndef ENABLE_CRYPTO_PROXY
void CRYPTO_GetServer(int32_t *aServerTask, uint32_t *aServerEvent)
{
    *aServerTask = CRYPTOQT_ServerTask;
    *aServerEvent = MODULE_EVENT;
}
#endif

TASK(CRYPTOQT_ServerTask)
{
    int32_t ret;
    BCM_EventMaskType mask;
    const uint32_t eventMask = MODULE_GetEventMask(CRYPTOQT_Modules, CRYPTOTEST_MODULE_COUNT_MAX);

    ret = MODULE_ResetStateHandler(CRYPTOQT_Modules, CRYPTOTEST_MODULE_COUNT_MAX);
    BCM_SetEvent(CRYPTOQT_TaskId, SystemEvent0);
    if (BCM_ERR_OK != ret) {
        CryptoQtSrvTaskActv = ret;
        goto exit;
    }

    while(CryptoQtKeepAlive) {
        BCM_WaitEvent(eventMask);
        BCM_GetEvent(CRYPTOQT_ServerTask, &mask);
        BCM_ClearEvent(mask);
        if (CryptoQtKeepAlive) {
            MODULE_EventHandler(CRYPTOQT_Modules, CRYPTOTEST_MODULE_COUNT_MAX, mask);
        }
    }
exit:
    BCM_TerminateTask();
}

int32_t CRYPTO_VerifyTest(BCM_TaskType aTaskID, uint8_t *aData[],
                          uint8_t *aSignature[], const MODULE_Type* const aModules[])
{
    uint32_t i,j,k;
    int32_t ret = BCM_ERR_OK;
    int32_t status = BCM_ERR_OK;
    MSGQ_HdlType msgQCtx[CRYPTOTEST_NUM_CONTEXTS];
    MSGQ_HdlType jobHdl[CRYPTOTEST_NUM_CONTEXTS];

    int32_t result[CRYPTOTEST_NUM_CONTEXTS] = {
#if CRYPTOTEST_NUM_CONTEXTS > 2UL
        BCM_ERR_OK,
        BCM_ERR_OK,
        BCM_ERR_AUTH_FAILED,
        BCM_ERR_AUTH_FAILED
#else
        BCM_ERR_OK,
        BCM_ERR_AUTH_FAILED
#endif
    };

    for (i=0; i<CRYPTOTEST_MODULE_COUNT_MAX; i++) {
        CRYPTOQT_Modules[i] = aModules[i];
    }

    BCM_EventMaskType mask;
    CRYPTOQT_TaskId = aTaskID;
    CryptoQtKeepAlive = TRUE;
    CryptoQtSrvTaskActv = BCM_AT_EXECUTING;

    BCM_ActivateTask(CRYPTOQT_ServerTask);

    BCM_WaitEvent(SystemEvent0);
    BCM_GetEvent(CRYPTOQT_TaskId, &mask);
    BCM_ClearEvent(mask);

    if (BCM_AT_EXECUTING != CryptoQtSrvTaskActv) {
        ret = BCM_ERR_UNKNOWN;
        goto err;
    }
    /* Run it twice to check the context allocation and destruction */
    for (j = 0UL; j < 2UL; j++) {
        uint32_t nonSecureBoard = FALSE;
        MSGQ_HdlType *jobHdlPtr[CRYPTOTEST_NUM_CONTEXTS];

        for (i = 0UL; i < CRYPTOTEST_NUM_CONTEXTS; i++) {
            jobHdl[i] = MSGQ_HDL_INVALID;
            jobHdlPtr[i] = (j == 0) ? &jobHdl[i] : NULL;
        }

        for (i = 0UL; (i < CRYPTOTEST_NUM_CONTEXTS) && (BCM_ERR_OK == ret); i++) {
            CRYPTO_VerifyInitType init;
            init.keyAuthLen = 0;
            init.keyAuth = NULL;
            init.keyHdl = CRYPTO_KEY_HDL_MVK;
            init.algo = CRYPTO_ALGO_RSA2K;
            init.hash = CRYPTO_ALGO_SHA256;
            init.padding = CRYPTO_ALGO_PKCS21;
            init.sigLen = 256UL;
            init.signature = aSignature[i];
            init.msgLength = CRYPTOTEST_MSG_SIZE;
            ret = CRYPTO_VerifyInit(&init, SystemEvent0,
                                    &msgQCtx[i],
                                    jobHdlPtr[i]);
        }

        if (BCM_ERR_OK == ret) {
            BCM_WaitEvent(SystemEvent0);
            BCM_GetEvent(CRYPTOQT_TaskId, &mask);
            BCM_ClearEvent(mask);
        }

        for (i = 0UL; (i < CRYPTOTEST_NUM_CONTEXTS) && (BCM_ERR_OK == ret); i++) {
            ret = CRYPTO_VerifyStatus(msgQCtx[i], jobHdl[i], &status);
            if (BCM_ERR_OK == ret) {
                if (BCM_ERR_NOT_FOUND == status) {
                    nonSecureBoard = TRUE;
                } else if (BCM_ERR_BUSY != status) {
                    /* Error */
                    ret = BCM_ERR_UNKNOWN;
                }
            }
        }

        if (TRUE == nonSecureBoard) {
            continue;
        }

        for (k = 0UL; (k < CRYPTOTEST_MSG_CHUNK_CNT) && (BCM_ERR_OK == ret); k++) {
            for (i = 0UL; (i < CRYPTOTEST_NUM_CONTEXTS) && (BCM_ERR_OK == ret); i++) {
                CRYPTO_VerifyUpdateType update;
                update.chunkSize = CRYPTOTEST_MSG_CHUNK_SIZE;
                update.chunkData = aData[i] + (k * CRYPTOTEST_MSG_CHUNK_SIZE);
                ret = CRYPTO_VerifyUpdate(msgQCtx[i], &update, jobHdlPtr[i]);

                if (BCM_ERR_OK == ret) {
                    BCM_WaitEvent(SystemEvent0);
                    BCM_GetEvent(CRYPTOQT_TaskId, &mask);
                    BCM_ClearEvent(mask);
                }

                ret = CRYPTO_VerifyStatus(msgQCtx[i], jobHdl[i], &status);
                if (BCM_ERR_OK == ret) {
                     if ((CRYPTOTEST_MSG_CHUNK_CNT - 1UL) == k) {
                        /* Last chunk */
                        if (result[i] != status) {
                            ret = BCM_ERR_UNKNOWN;
                        }
                     } else {
                        if (BCM_ERR_BUSY != status) {
                            ret = BCM_ERR_UNKNOWN;
                        }
                     }
                }
            }
        }

        /* Test cancel API */
        for (i = 0UL; (i < CRYPTOTEST_NUM_CONTEXTS) && (BCM_ERR_OK == ret); i++) {
            CRYPTO_VerifyInitType init;
            init.keyAuthLen = 0;
            init.keyAuth = NULL;
            init.keyHdl = CRYPTO_KEY_HDL_MVK;
            init.algo = CRYPTO_ALGO_RSA2K;
            init.hash = CRYPTO_ALGO_SHA256;
            init.padding = CRYPTO_ALGO_PKCS21;
            init.sigLen = 256UL;
            init.signature = aSignature[i];
            init.msgLength = CRYPTOTEST_MSG_SIZE;
            ret = CRYPTO_VerifyInit(&init, SystemEvent0,
                                    &msgQCtx[i],
                                    jobHdlPtr[i]);
        }

        for (i = 0UL; (i < CRYPTOTEST_NUM_CONTEXTS) && (BCM_ERR_OK == ret); i++) {
            ret = CRYPTO_VerifyCancel(msgQCtx[i]);
        }
    }

err:
    CryptoQtKeepAlive = FALSE;
    BCM_SetEvent(CRYPTOQT_ServerTask, MODULE_EVENT);
    return ret;
}