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

/** @brief MSGQ_EN_NOTIF_QT1
 *
 * This file implements BRCM_SWQTSEQ_MSGQ_EN_NOTIF_4, which tests the message queue with
 * client notifcation enabled.
 */

#include <ulog.h>
#include <msg_queue.h>
#include <bcm_err.h>
#include <bcm_test.h>
#include <osil/bcm_osil.h>
#include "ee.h"

#include "msg_queue_qt.h"

#define GetModuleLogLevel()     ULOG_LVL_ERROR
#define CLIENT1_PKT_STATUS_BIT  (0UL)
#define CLIENT2_PKT_STATUS_BIT  (1UL)
#define PKT_STATUS_OK           (3UL)

#define REPORT_RESULT(case, condition)                                          \
        BCM_SetTestCase(case);                                                  \
        if (condition) {                                                        \
            BCM_SetTestResult(BCM_ERR_OK);                                      \
        } else {                                                                \
            BCM_SetTestResult(BCM_ERR_UNKNOWN);                                 \
            ULOG_ERR("MSGQ_QT: Err case: %x, at line : %d\n", case, __LINE__);  \
        }                                                                       \

static volatile int32_t MsgQQT4_ServerStatus = BCM_AT_NOT_STARTED;
static volatile int32_t MsgQQT4_Client1Status = BCM_AT_NOT_STARTED;
static volatile int32_t MsgQQT4_Client2Status = BCM_AT_NOT_STARTED;
static volatile uint32_t PktCnt_Status1 = 0UL;
static volatile uint32_t PktCnt_Status2 = 0UL;

/* define message struct */
typedef struct {
    uint32_t cmd;
    uint32_t resp;
} Msg;

#define MSGQ_TEST_CTX_LOG2_CNT   (1UL)
#define MSGQ_TEST_CTX_CNT   (1UL << MSGQ_TEST_CTX_LOG2_CNT)
static Msg MsgQQT4_msg[MSGQ_TEST_CTX_CNT][MSGQ_SIZE];


/* Define GetMessage function */
static uint8_t* MsgQQT4_GetMessage(uint32_t ctxIdx, uint32_t msgIdx)
{
    void* pRet;

    if ((ctxIdx < MSGQ_TEST_CTX_CNT) && (msgIdx < MSGQ_SIZE)) {
        pRet = (uint8_t *)(&MsgQQT4_msg[ctxIdx][msgIdx]);
    } else {
        pRet = (uint8_t *) NULL;
    }
    return pRet;
}

/* Allocate the Message queue */
MSGQ_DEFINE_WITH_CONTEXT(MsgQQT4_msgQ, 4UL, MSGQ_TEST_CTX_LOG2_CNT, MsgQQT4_ServerTask, MsgQQT4_TriggerServer,
            Msg, MsgQQT4_msgHdrQ, MsgQQT4_GetMessage, ".bss.MsgQQT4_msgHdrQ");

/* Global variables */
static uint32_t server_resp = 500000;
static uint32_t client1_msg = 0;
static uint32_t client2_msg = 10000;

TASK(MsgQQT4_ServerTask)
{
    int32_t ret;
    BCM_EventMaskType mask;
    uint32_t idx,i;
    uint32_t whileCondition = 1UL;

    do {
        /* Wait for message reception signal from queue */
        (void)BCM_WaitEvent(MsgQQT4_TriggerServer);
        (void)BCM_GetEvent(MsgQQT4_ServerTask, &mask);
        (void)BCM_ClearEvent(mask);
        if (0UL != (mask & MsgQQT4_TriggerServer)) {
            for (i = 0UL; i < MSGQ_TEST_CTX_CNT; i++ ) {
                /* Get message from queue */
                ret = MSGQ_CtxGetMsgIdx(&MsgQQT4_msgQ, i,&idx);
                if (ret == BCM_ERR_OK) {
                    REPORT_RESULT(BRCM_SWQTST_MSGQ_CTX_GET_MSG_IDX_POS, ret == BCM_ERR_OK)
                    /* Process the message - Change the data */
                    MsgQQT4_msg[i][idx].resp = server_resp;
                    server_resp++;

                    /* Mark the message as completed */
                    ret = MSGQ_CtxCompleteMsgIdx(&MsgQQT4_msgQ, i, idx);
                    REPORT_RESULT(BRCM_SWQTST_MSGQ_CTX_COMPLETE_MSG_IDX_POS, ret == BCM_ERR_OK)
                    if (BCM_ERR_OK != ret) {
                        whileCondition = 0UL;
                        /*break;
                        * Since while condition is now false, so break statement is not required*/
                    }
                } else if (BCM_ERR_UNINIT == ret) {
                    continue;
                } else if (BCM_ERR_BUSY != ret) {
                    REPORT_RESULT(BRCM_SWQTST_MSGQ_CTX_GET_MSG_IDX_POS, ret == BCM_ERR_BUSY)
                    whileCondition = 0UL;
                    /*break;
                    * Since while condition is now false, so break statement is not required*/
                } else {
                    continue;
                }
            }
        }
    } while(1UL == whileCondition);
    (void)BCM_TerminateTask();
}

TASK(MsgQQT4_TaskClient1)
{
    int32_t ret;
    BCM_EventMaskType mask = 0UL;
    Msg msgCmd;
    Msg msgResp;
    MSGQ_HdlType msgHdl;
    MSGQ_HdlType ctxHdl;

    ret = MSGQ_CtxCreate(&MsgQQT4_msgQ, MsgQQT4_TriggerClient1, &ctxHdl);
    REPORT_RESULT(BRCM_SWQTST_MSGQ_CTX_CREATE_POS, ret == BCM_ERR_OK)
    if (BCM_ERR_OK == ret) {
        do {
            /* Set cmd = 1, resp = 0 */
            msgCmd.cmd = client1_msg;
            msgCmd.resp = 0;
            client1_msg++;

            /* Send message to server/queue */
            ret = MSGQ_CtxSendMsg(&MsgQQT4_msgQ, ctxHdl, (const uint8_t*)&msgCmd, &msgHdl);
            REPORT_RESULT(BRCM_SWQTST_MSGQ_CTX_SEND_POS, ret == BCM_ERR_OK)
            if (ret == BCM_ERR_OK) {
                /* Wait for message completion signal from server/queue */
                (void)BCM_WaitEvent(MsgQQT4_TriggerClient1);
                (void)BCM_GetEvent(MsgQQT4_TaskClient1, &mask);
                (void)BCM_ClearEvent(MsgQQT4_TriggerClient1);

                /* Receive response from server/queue */
                ret = MSGQ_CtxRecvMsg(&MsgQQT4_msgQ, ctxHdl, msgHdl, (uint8_t*)&msgResp);
                REPORT_RESULT(BRCM_SWQTST_MSGQ_CTX_RECV_POS, ret == BCM_ERR_OK)
            }
            if (ret != BCM_ERR_OK) {
                break;
            }
        } while(client1_msg < 10UL);
        ret = MSGQ_CtxDestroy(&MsgQQT4_msgQ, ctxHdl);
        REPORT_RESULT(BRCM_SWQTST_MSGQ_CTX_DESTROY_POS, ret == BCM_ERR_OK)
    }
    if (client1_msg == 10UL) {
        PktCnt_Status1 = 1UL;
    } else {
        ULOG_ERR("Client1 failed at (%u)\n", client1_msg);
    }
    (void)BCM_TerminateTask();
}

TASK(MsgQQT4_TaskClient2)
{
    int32_t ret;
    BCM_EventMaskType mask = 0UL;
    Msg msgCmd;
    Msg msgResp;
    MSGQ_HdlType msgHdl;
    MSGQ_HdlType ctxHdl;

    ret = MSGQ_CtxCreate(&MsgQQT4_msgQ, MsgQQT4_TriggerClient2, &ctxHdl);
    REPORT_RESULT(BRCM_SWQTST_MSGQ_CTX_CREATE_POS_2, ret == BCM_ERR_OK)
    if (BCM_ERR_OK == ret) {
        do {
            /* Set cmd = 1, resp = 0 */
            msgCmd.cmd = client2_msg;
            msgCmd.resp = 0;
            client2_msg++;

            /* Send message to server/queue */
            ret = MSGQ_CtxSendMsg(&MsgQQT4_msgQ, ctxHdl, (const uint8_t*)&msgCmd, &msgHdl);
            REPORT_RESULT(BRCM_SWQTST_MSGQ_CTX_SEND_POS_2, ret == BCM_ERR_OK)
            if (ret == BCM_ERR_OK) {
                /* Wait for message completion signal from server/queue */
                (void)BCM_WaitEvent(MsgQQT4_TriggerClient2);
                (void)BCM_GetEvent(MsgQQT4_TaskClient2, &mask);
                (void)BCM_ClearEvent(MsgQQT4_TriggerClient2);

                /* Receive response from server/queue */
                ret = MSGQ_CtxRecvMsg(&MsgQQT4_msgQ, ctxHdl, msgHdl, (uint8_t*)&msgResp);
                REPORT_RESULT(BRCM_SWQTST_MSGQ_CTX_RECV_POS_2, ret == BCM_ERR_OK)
            }
            if (ret != BCM_ERR_OK) {
                break;
            }
        } while(client2_msg < 10010UL);
        ret = MSGQ_CtxDestroy(&MsgQQT4_msgQ, ctxHdl);
        REPORT_RESULT(BRCM_SWQTST_MSGQ_CTX_DESTROY_POS_2, ret == BCM_ERR_OK)
    }
    if (client2_msg == 10010UL) {
        PktCnt_Status2 = 1UL;
    } else {
        ULOG_ERR("Client2 failed at (%u)\n", client2_msg);
    }
    (void)BCM_TerminateTask();
}

extern void MsgQQT4_Start(void)
{
    server_resp = 500000;
    client1_msg = 0UL;
    client2_msg = 10000UL;
    MsgQQT4_ServerStatus = BCM_AT_EXECUTING;
    (void)BCM_ActivateTask(MsgQQT4_ServerTask);
    /* Activate the client task */
    MsgQQT4_Client1Status = BCM_AT_EXECUTING;
    (void)BCM_ActivateTask(MsgQQT4_TaskClient1);
    MsgQQT4_Client2Status = BCM_AT_EXECUTING;
    (void)BCM_ActivateTask(MsgQQT4_TaskClient2);
}

int32_t MsgQQT4_GetResult(void)
{
    int32_t ret;

    if (BCM_AT_EXECUTING != MsgQQT4_ServerStatus) {
        ret = MsgQQT4_ServerStatus;
    } else if (BCM_AT_EXECUTING != MsgQQT4_Client1Status) {
        ret = MsgQQT4_Client1Status;
    } else if (BCM_AT_EXECUTING != MsgQQT4_Client2Status) {
        ret = MsgQQT4_Client2Status;
    } else {
        ret = BCM_AT_EXECUTING;
    }

    if (BCM_AT_EXECUTING == ret) {
        if ((1UL == PktCnt_Status1) && (1UL == PktCnt_Status2)) {
            ret = BCM_ERR_OK;
        } else {
            ret = BCM_ERR_UNKNOWN;
        }
    }
    return ret;
}
