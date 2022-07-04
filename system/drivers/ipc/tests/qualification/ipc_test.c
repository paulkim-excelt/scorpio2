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
#include <ulog.h>
#include <bcm_err.h>
#include <ipc.h>
#include <bcm_utils.h>
#include <osil/bcm_osil.h>
#include <bcm_test.h>
#include <ipc.h>
#include <ipc_osil.h>
#include "ipc_test_plat.h"
#include "ee.h"

#define GetModuleLogLevel()    ULOG_LVL_INFO

#define IPCT_TEST_LOG(result, expec)           \
    do {                                       \
        IPCT_ProgLine = __LINE__;             \
        if ((result) != (expec)) {             \
                IPCT_ErrorValue = result;      \
                IPCT_ErrorLine = __LINE__;     \
                IPCT_Result = BCM_ERR_UNKNOWN; \
                BCM_TerminateTask();           \
        }                                      \
    } while(0)

#define IPCT_SLAVE_CHANNEL     0U
#define IPCT_MASTER_CHANNEL    1U

#define IPCT_MSG_MAX_PAYLOAD   1024U
#define IPCT_TEST_BUF_INFO_SET      0
#define IPCT_TEST_BUF_INFO_GET      1
#define IPCT_TEST_MSG_SEND          2
#define IPCT_TEST_MSG_RECV          3

typedef struct sIPCT_MsgInfoType {
    IPC_MagicType   magic;
    uint32_t        checksum;
    uint32_t        cmd;
    uint32_t        len;
    uint8_t         data[IPCT_MSG_MAX_PAYLOAD];
} IPCT_MsgInfoType;

IPCT_MsgInfoType IPCT_SimMsg;
IPCT_MsgInfoType IPCT_ActMsg;
int32_t IPCT_Result = BCM_AT_NOT_STARTED;
uint32_t IPCT_ProgLine;
uint32_t IPCT_ErrorLine;
uint32_t IPCT_ErrorValue;
IPC_BuffInfoType IPCT_BufInfo;
IPC_BuffStatusType IPCT_SimBuf;
IPC_BuffStatusType IPCT_ActBuf;
uint32_t IPCT_TestChannel = IPCT_SLAVE_CHANNEL;
IPC_ChannModeType IPCT_TestChMode = IPC_CHANN_MODE_SLAVE;
uint32_t IPCT_TestChEvent = IPC_CHANN0_EVENT;

static uint32_t IPCT_CalcChecksum(uint32_t *aMsg, uint32_t aLen)
{
    uint32_t i;
    uint32_t chksum = 0UL;
    uint32_t words = BCM_DIV_CEIL(aLen + IPC_MSG_HDR_SIZE, 4U);
    for (i = 0UL; i < words; i++) {
        chksum += aMsg[i];
    }
    return (~chksum) + 1UL;
}

void SVC_TestSvcHandler(uint32_t aMagicID, uint32_t aCmd, uint8_t *aSysIO)
{
    IPCT_MsgInfoType *msgInfo = (IPCT_MsgInfoType *)(void *)aSysIO;
    uint32_t index;
    IPC_MsgHdrType *msgHdr;
    uint8_t *msgData;

    if (IPCT_TEST_BUF_INFO_SET == aCmd) {
        IPCT_PlatReset(IPCT_TestChannel);
        IPCT_PlatSetBuffInfo(IPCT_TestChannel);
    } else if (IPCT_TEST_BUF_INFO_GET == aCmd) {
        IPCT_PlatGetBuffInfo(IPCT_TestChannel, &IPCT_BufInfo);
        BCM_MemSet(&IPCT_SimBuf, 0, sizeof(IPCT_SimBuf));
    } else if (IPCT_TEST_MSG_SEND == aCmd) {
        index = IPCT_SimBuf.writeIndex&(IPCT_BufInfo.msgCount-1);
        if (IPC_CHANN_MODE_MASTER == IPCT_TestChMode) {
            index += IPCT_BufInfo.msgCount; /* bottom half */
        }
        index = index*IPCT_BufInfo.msgSize;
        msgHdr = (IPC_MsgHdrType *)(void *)&IPCT_BufInfo.buffer[index];
        msgData = &IPCT_BufInfo.buffer[index+sizeof(IPC_MsgHdrType)];

        msgHdr->magic = msgInfo->magic;
        msgHdr->cmd = msgInfo->cmd;
        msgHdr->len = msgInfo->len;
        msgHdr->checksum = msgInfo->checksum;
        BCM_MemCpy(msgData, msgInfo->data, msgInfo->len);
        IPCT_SimBuf.writeIndex = (IPCT_SimBuf.writeIndex+1U) & IPCT_BufInfo.rolloverMask;
        IPCT_PlatSetLocalStatus(IPCT_TestChannel, &IPCT_SimBuf);
        IPCT_PlatSetIntr(IPCT_TestChannel);
    } else if (IPCT_TEST_MSG_RECV == aCmd) {
        IPCT_PlatGetRemoteStatus(IPCT_TestChannel, &IPCT_ActBuf);
        if (IPCT_ActBuf.writeIndex != IPCT_SimBuf.readIndex) {
            index = IPCT_SimBuf.readIndex&(IPCT_BufInfo.msgCount-1);
            if (IPC_CHANN_MODE_SLAVE == IPCT_TestChMode) {
                index += IPCT_BufInfo.msgCount; /* bottom half */
            }
            index = index*IPCT_BufInfo.msgSize;
            msgHdr = (IPC_MsgHdrType *)(void *)&IPCT_BufInfo.buffer[index];
            msgData = &IPCT_BufInfo.buffer[index+sizeof(IPC_MsgHdrType)];
            msgInfo->cmd = msgHdr->cmd;
            msgInfo->len = msgHdr->len;
            msgInfo->checksum = msgHdr->checksum;
            msgInfo->magic = msgHdr->magic;
            BCM_MemCpy(msgInfo->data, msgData, msgHdr->len);
            IPCT_SimBuf.readIndex = (IPCT_SimBuf.readIndex+1U) & IPCT_BufInfo.rolloverMask;
            IPCT_PlatSetLocalStatus(IPCT_TestChannel, &IPCT_SimBuf);
        }
    }
}

void IPCT_FillMessage(IPC_ChannModeType aMode, uint8_t aId, IPCT_MsgInfoType *aMsgInfo)
{
    uint32_t i;
    uint32_t maxSize = IPCT_BufInfo.msgSize - IPC_MSG_HDR_SIZE;

    if (aMode == IPC_CHANN_MODE_MASTER) {
        aMsgInfo->magic = IPC_MAGIC_CMD;
        aMsgInfo->cmd = 0x76543210 + aId;
        aMsgInfo->len = aId < 4 ? aId * 10 : maxSize - (aId-4)*10;
    } else {
        aMsgInfo->magic = IPC_MAGIC_RESP;
        aMsgInfo->cmd = 0x01234567 + aId;
        aMsgInfo->len = aId < 4 ? aId * 8 : maxSize - (aId-4)*8;
    }
    for (i = 0; i < aMsgInfo->len; i++) {
        if (aMode == IPC_CHANN_MODE_MASTER) {
            aMsgInfo->data[i] = (aId + i + 1);
        } else {
            aMsgInfo->data[i] = ~(aId + i + 1);
        }
    }

    for(; i < aMsgInfo->len + 4 && i < sizeof(aMsgInfo->data); i++) {
        aMsgInfo->data[i] = 0;
    }

    aMsgInfo->checksum = 0;
    aMsgInfo->checksum = IPCT_CalcChecksum((uint32_t *)aMsgInfo, aMsgInfo->len);
}

void IPCT_CheckMsg(IPC_ChannModeType aMode, uint8_t aId, IPCT_MsgInfoType *aMsg)
{
    IPCT_MsgInfoType orgMsg;

    IPCT_FillMessage(aMode, aId, &orgMsg);
    if (IPCT_TestChMode == aMode) {
        IPCT_TEST_LOG(aMsg->magic, orgMsg.magic);
        IPCT_TEST_LOG(aMsg->checksum, orgMsg.checksum);
    }
    IPCT_TEST_LOG(aMsg->cmd, orgMsg.cmd);
    IPCT_TEST_LOG(aMsg->len, orgMsg.len);
    IPCT_TEST_LOG(memcmp(aMsg->data, orgMsg.data, aMsg->len), 0);
}

void IPCT_TestSend(uint8_t aId, uint8_t aCount)
{
    uint32_t i;
    IPC_ChannModeType mode;
    if (IPCT_TestChMode == IPC_CHANN_MODE_SLAVE) {
        mode = IPC_CHANN_MODE_MASTER;
    } else {
        mode = IPC_CHANN_MODE_SLAVE;
    }
    for (i = 0; i < aCount; i++) {
        IPCT_FillMessage(mode, aId+i, &IPCT_SimMsg);
        SVC_RunTestSvc(IPCT_TEST_MSG_SEND, (uint8_t *)&IPCT_SimMsg);
    }
}

void IPCT_TestRecvCheck(uint8_t aId, uint8_t aCount)
{
    uint32_t i;
    for (i = 0; i < aCount; i++) {
        BCM_MemSet(&IPCT_SimMsg, 0, sizeof(IPCT_SimMsg));
        SVC_RunTestSvc(IPCT_TEST_MSG_RECV, (uint8_t *)&IPCT_SimMsg);

        IPCT_CheckMsg(IPCT_TestChMode, aId+i, &IPCT_SimMsg);
    }
}

void IPCT_RecvCheck(uint8_t aId, uint8_t aCount)
{
    IPCT_MsgInfoType *const msg = &IPCT_ActMsg;
    BCM_EventMaskType events;
    uint32_t i;
    int32_t ret;
    IPC_ChannModeType mode;
    if (IPCT_TestChMode == IPC_CHANN_MODE_SLAVE) {
        mode = IPC_CHANN_MODE_MASTER;
    } else {
        mode = IPC_CHANN_MODE_SLAVE;
    }

    ret = BCM_GetEvent(IPCT_SlaveTask, &events);
    IPCT_TEST_LOG(ret, BCM_ERR_OK);
    IPCT_TEST_LOG((events&IPCT_TestChEvent), IPCT_TestChEvent);

    ret = BCM_ClearEvent(IPCT_TestChEvent);
    IPCT_TEST_LOG(ret, BCM_ERR_OK);

    for (i = 0; i < aCount; i++) {
        BCM_MemSet(msg, 0, sizeof(*msg));
        ret = IPC_Receive(IPCT_TestChannel, &msg->cmd, msg->data, sizeof(msg->data), &msg->len);
        IPCT_TEST_LOG(ret, BCM_ERR_OK);

        IPCT_CheckMsg(mode, aId+i, &IPCT_ActMsg);
    }

    ret = IPC_Receive(IPCT_TestChannel, &msg->cmd, msg->data, sizeof(msg->data), &msg->len);
    IPCT_TEST_LOG(ret, BCM_ERR_NOMEM);
}

void IPCT_Send(uint8_t aId, uint8_t aCount)
{
    int32_t ret;
    IPCT_MsgInfoType *const msg = &IPCT_ActMsg;
    uint32_t i;

    for (i = 0; i < aCount; i++) {
        IPCT_FillMessage(IPCT_TestChMode, aId+i, msg);
        ret = IPC_Send(IPCT_TestChannel, msg->cmd, msg->data, msg->len);
        IPCT_TEST_LOG(ret, BCM_ERR_OK);
    }
}

void IPCT_RunTest(IPC_ChannIDType aChnn, IPC_ChannModeType aMode, uint32_t aEvent)
{
    int32_t ret;

    IPCT_TestChannel = aChnn;
    IPCT_TestChMode = aMode;
    IPCT_TestChEvent = aEvent;

    SVC_RunTestSvc(IPCT_TEST_BUF_INFO_SET, NULL);

    IPC_Init(IPCT_TestChannel);

    SVC_RunTestSvc(IPCT_TEST_BUF_INFO_GET, NULL);

    IPCT_TestSend(0, 1);
    IPCT_RecvCheck(0, 1);

    IPCT_TestSend(1, 3);
    IPCT_RecvCheck(1, 3);

    IPCT_TestSend(4, IPCT_BufInfo.msgCount);
    IPCT_RecvCheck(4, IPCT_BufInfo.msgCount);

    IPCT_TestSend(10, 4);

    IPCT_Send(0, 1);
    IPCT_TestRecvCheck(0, 1);

    IPCT_Send(1, IPCT_BufInfo.msgCount);
    ret = IPC_Send(IPCT_TestChannel, IPCT_ActMsg.cmd, IPCT_ActMsg.data, IPCT_ActMsg.len);
    IPCT_TEST_LOG(ret, BCM_ERR_NOMEM);
    IPCT_TestRecvCheck(1, IPCT_BufInfo.msgCount);

    IPCT_Send(1, 5);

    IPCT_RecvCheck(10, 4);

    IPCT_TestRecvCheck(1, 5);

    ret = IPC_DeInit(IPCT_TestChannel);
    IPCT_TEST_LOG(ret, BCM_ERR_OK);

    IPCT_TestSend(5, 4);
#if 0
    /* After deinit, events should not be set */
    BCM_EventMaskType events;
    ret = BCM_GetEvent(IPCT_SlaveTask, &events);
    IPCT_TEST_LOG(ret, BCM_ERR_OK);
    IPCT_TEST_LOG((events&IPCT_TestChEvent), 0);
#endif
    IPC_Init(IPCT_TestChannel);
    IPCT_RecvCheck(5, 4);

    ret = IPC_DeInit(IPCT_TestChannel);
    IPCT_TEST_LOG(ret, BCM_ERR_OK);
}

TASK(IPCT_SlaveTask)
{
    IPCT_RunTest(IPCT_SLAVE_CHANNEL, IPC_CHANN_MODE_SLAVE, IPC_CHANN0_EVENT);
#if IPC_MAX_CHANNELS > 1
    IPCT_RunTest(IPCT_MASTER_CHANNEL, IPC_CHANN_MODE_MASTER, IPC_CHANN1_EVENT);
#endif
    IPCT_Result = BCM_ERR_OK; /* All tests are passing */

    BCM_TerminateTask();
}

void APP_Init()
{
}

int32_t BCM_ExecuteAT(uint32_t aIndex)
{
    if ((aIndex >= 2U) || (aIndex < 1U)) {
        return  BCM_AT_NOT_AVAILABLE;
    }

    IPCT_Result = BCM_AT_EXECUTING;
    BCM_ActivateTask(IPCT_SlaveTask);
    return BCM_ERR_OK;
}

int32_t BCM_GetResultAT(uint32_t aIndex)
{
    if ((aIndex >= 2U) || (aIndex < 1U)) {
        return  BCM_AT_NOT_AVAILABLE;
    }

    return IPCT_Result;
}
