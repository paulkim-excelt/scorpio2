/*****************************************************************************
 Copyright 2020-2021 Broadcom Limited.  All rights reserved.

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

/** @brief BRCM_SWQTSEQ_MSGQ_DIS_NOTIF_3
 *
 * This file implements BRCM_SWQTSEQ_MSGQ_DIS_NOTIF_3, which tests the message queue with
 * configurable number of items and with client notifcation disabled.
 *
 * In the test, two clients sends 'n' messages each to the server. This test
 * shall pass if the server receives all the messages sent from both the
 * clients.
 */

#include "ee.h"
#include <ulog.h>
#include <msg_queue.h>
#include <bcm_err.h>
#include <bcm_test.h>
#include <osil/bcm_osil.h>
#include <bcm_utils.h>

#include "msg_queue_qt.h"

#define GetModuleLogLevel() ULOG_LVL_ERROR

/* Maximum number of messages one client shall send to the server */
#define CLIENT_MSG_CNT      (2UL)
/* ID of Client 1 */
#define CLIENT1             (0UL)
/* ID of Client 2 */
#define CLIENT2             (1UL)
#define MAX_CLIENT          CLIENT2
/* Number of clients */
#define NUM_CLIENT          (MAX_CLIENT + 1UL)
#define PKT_PASS            ((1UL <<(NUM_CLIENT * CLIENT_MSG_CNT)) - 1UL)
#define PKT_FAIL            (PKT_PASS + 1UL)
#define CUSTOM_MSGQ_SIZE    (5UL)

#define MARK_FAIL(aRetVal, aLineNum, aStatus) {              \
ULOG_ERR("\nError: %d \t line %d", aRetVal ,aLineNum);       \
    PktStatus[NUM_CLIENT * CLIENT_MSG_CNT] = 1;              \
    if (BCM_AT_EXECUTING == (aStatus)) {                     \
        (aStatus) = (aRetVal);                               \
    }                                                        \
}

static uint8_t PktStatus[32U] = {0U};
static volatile int32_t MsgQQT3_ServerStatus = BCM_AT_NOT_STARTED;
static volatile int32_t MsgQQT3_Client1Status = BCM_AT_NOT_STARTED;
static volatile int32_t MsgQQT3_Client2Status = BCM_AT_NOT_STARTED;
static volatile int32_t MsgQQT3_TestStatus = BCM_AT_NOT_STARTED;

/* Structure to hold the actual message */
typedef struct {
    uint32_t clientID;
    uint32_t pktNo;
} Msg_t;

/* Actual Array of messages */
static Msg_t MsgQQT3_MsgArray[CUSTOM_MSGQ_SIZE];

static uint32_t MsgQBytetoBitStatus (uint8_t * aData)
{
    uint32_t dataBit = 0UL;
    uint32_t i;
    for (i = 0; i < 32UL; i++) {
        dataBit |= aData[i] << i;
    }
    return dataBit;
}

/* GetMessage */
static void * MsgQQT3_GetMessage (uint32_t aIdx)
{
    void *pMsg;

    if (aIdx < MSGQ_SIZE) {
        pMsg = (void *)(&MsgQQT3_MsgArray[aIdx]);
    } else {
        pMsg = (void *) NULL;
    }

    return pMsg;
}

/* Allocate the Message queue */
MSGQ_DEFINE_V3(MsgQQT3_MsgQ, CUSTOM_MSGQ_SIZE, MsgQQT3_ServerTask, MsgQQT3_TriggerServer,
          MSGQ_CLIENT_SIGNAL_DISABLE, Msg_t, MsgQQT3_msgHdrQ, MsgQQT3_GetMessage, ".data.MsgQQT3_msgHdrQ");

TASK(MsgQQT3_ServerTask)
{
    int32_t ret;
    BCM_EventMaskType mask = 0UL;
    uint32_t idx, statusBit;
    Msg_t msg;

    do {
        /* Wait for message reception signal from queue */
        (void)BCM_WaitEvent(MsgQQT3_TriggerServer);
        (void)BCM_GetEvent(MsgQQT3_ServerTask, &mask);
        (void)BCM_ClearEvent(MsgQQT3_TriggerServer);
        if ((MsgQQT3_TriggerServer & mask) == MsgQQT3_TriggerServer) {
            /* Get message from queue */
            ret = MSGQ_GetMsgIdx(&MsgQQT3_MsgQ, &idx);
            if ((BCM_ERR_OK != ret) && (BCM_ERR_BUSY != ret)) {
                 MARK_FAIL(ret, __LINE__, MsgQQT3_ServerStatus);
            }
            while (BCM_ERR_OK == ret) {
                msg = MsgQQT3_MsgArray[idx];
                statusBit = ((msg.clientID * CLIENT_MSG_CNT) + msg.pktNo);
                PktStatus[statusBit] = 1U;
                /* Mark the message as completed */
                ret = MSGQ_CompleteMsgIdx(&MsgQQT3_MsgQ, idx);
                if (BCM_ERR_OK != ret) {
                    MARK_FAIL(ret, __LINE__, MsgQQT3_ServerStatus);
                }
                /* Check if there are any more messages to be processed */
                ret = MSGQ_GetMsgIdx(&MsgQQT3_MsgQ, &idx);
                if ((BCM_ERR_OK != ret) && (BCM_ERR_BUSY != ret)) {
                    MARK_FAIL(ret, __LINE__, MsgQQT3_ServerStatus);
                }
            }
        }
    } while (PKT_PASS > MsgQBytetoBitStatus(PktStatus));

    if (PKT_PASS == MsgQBytetoBitStatus(PktStatus)) {
        if(BCM_AT_EXECUTING == MsgQQT3_TestStatus){
            MsgQQT3_TestStatus = BCM_ERR_OK;
        }
    } else {
        if(BCM_AT_EXECUTING == MsgQQT3_TestStatus){
            MsgQQT3_TestStatus = BCM_ERR_UNKNOWN;
        }
    }
    (void)BCM_TerminateTask();
}

TASK(MsgQQT3_TaskClient1)
{
    int32_t ret;
    Msg_t msg;
    MSGQ_MsgHdrType* pHdr = NULL;
    uint32_t i;

    for(i = 0; i < CLIENT_MSG_CNT; ++i) {
        msg.clientID = CLIENT1;
        msg.pktNo = i;
        ret = MSGQ_SendMsgv2(&MsgQQT3_MsgQ, (uint8_t *)&msg, 0UL, pHdr);
        if (BCM_ERR_OK != ret) {
            MARK_FAIL(ret, __LINE__, MsgQQT3_Client1Status);
            goto err;
        }
    }

err:
    (void)BCM_TerminateTask();
}

TASK(MsgQQT3_TaskClient2)
{
    int32_t ret;
    Msg_t msg;
    MSGQ_MsgHdrType testHdr;
    MSGQ_MsgHdrType* pHdr = &testHdr;

    uint32_t i;

    for(i = 0; i < CLIENT_MSG_CNT; ++i) {
        msg.clientID = CLIENT2;
        msg.pktNo = i;
        ret = MSGQ_SendMsgv2(&MsgQQT3_MsgQ, (uint8_t *)&msg, 0UL, pHdr);
        if (BCM_ERR_OK != ret) {
            MARK_FAIL(ret, __LINE__, MsgQQT3_Client2Status);
            goto err;
        }
    }

err:
    (void)BCM_TerminateTask();
}

extern void MsgQQT3_Start(void)
{
    MsgQQT3_TestStatus = BCM_AT_EXECUTING;
    _Static_assert(32UL > (NUM_CLIENT * CLIENT_MSG_CNT), "Number of msg more than 32");

    BCM_MemSet(PktStatus, 0U, sizeof(PktStatus));
    (void)BCM_ActivateTask(MsgQQT3_ServerTask);
    /* Activate the client task */
    (void)BCM_ActivateTask(MsgQQT3_TaskClient1);
    (void)BCM_ActivateTask(MsgQQT3_TaskClient2);
}

int32_t MsgQQT3_GetResult(void)
{
    return MsgQQT3_TestStatus;
}