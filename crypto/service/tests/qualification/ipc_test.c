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
#include <bcm_time.h>
#include <ipc.h>
#include <ipc_osil.h>
#if CRPTST_IPC_LOOP_BACK == 1
#include "ipc_test_plat.h"
#endif

#define IPCT_MSG_MAX_PAYLOAD       1024U
#define IPCT_TEST_BUF_INFO_SET      0
#define IPCT_TEST_BUF_INFO_GET      1
#define IPCT_TEST_MSG_SEND          2
#define IPCT_TEST_MSG_RECV          3
#define IPCT_TEST_MSG_RESET         4

#if CRPTST_IPC_LOOP_BACK == 1

typedef struct sIPCT_MsgInfoType {
    IPC_MagicType   magic;
    uint32_t        checksum;
    uint32_t        cmd;
    uint32_t        len;
    uint8_t         data[IPCT_MSG_MAX_PAYLOAD];
    IPC_ChannIDType chNum;
    IPC_ChannModeType mode;
    int32_t status;
} IPCT_MsgInfoType;

IPC_BuffInfoType IPCT_BufInfo;
IPC_BuffStatusType IPCT_SimBuf;
IPC_BuffStatusType IPCT_ActBuf;

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

    msgInfo->status = BCM_ERR_UNKNOWN;

    if (IPCT_TEST_BUF_INFO_SET == aCmd) {
        IPCT_PlatSetBuffInfo(msgInfo->chNum);
        msgInfo->status = BCM_ERR_OK;
    } else if (IPCT_TEST_BUF_INFO_GET == aCmd) {
        IPCT_PlatGetBuffInfo(msgInfo->chNum, &IPCT_BufInfo);
        BCM_MemSet(&IPCT_SimBuf, 0, sizeof(IPCT_SimBuf));
        msgInfo->status = BCM_ERR_OK;
    } else if (IPCT_TEST_MSG_SEND == aCmd) {
        IPCT_PlatGetRemoteStatus(msgInfo->chNum, &IPCT_ActBuf);
        uint32_t maxWriteIndex = (IPCT_ActBuf.readIndex + IPCT_BufInfo.msgCount) & IPCT_BufInfo.rolloverMask;
        if (maxWriteIndex != IPCT_SimBuf.writeIndex) {
            index = IPCT_SimBuf.writeIndex&(IPCT_BufInfo.msgCount-1);
            if (IPC_CHANN_MODE_SLAVE == msgInfo->mode) {
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
            IPCT_PlatSetLocalStatus(msgInfo->chNum, &IPCT_SimBuf);
            IPCT_PlatSetIntr(msgInfo->chNum);
            msgInfo->status = BCM_ERR_OK;
        } else {
            msgInfo->status = BCM_ERR_NOMEM;
        }
    } else if (IPCT_TEST_MSG_RECV == aCmd) {
        IPCT_PlatGetRemoteStatus(msgInfo->chNum, &IPCT_ActBuf);
        if (IPCT_ActBuf.writeIndex != IPCT_SimBuf.readIndex) {
            index = IPCT_SimBuf.readIndex&(IPCT_BufInfo.msgCount-1);
            if (IPC_CHANN_MODE_MASTER == msgInfo->mode) {
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
            IPCT_PlatSetLocalStatus(msgInfo->chNum, &IPCT_SimBuf);
            msgInfo->status = BCM_ERR_OK;
        } else {
            msgInfo->status = BCM_ERR_NOMEM;
        }
    } else if (IPCT_TEST_MSG_RESET == aCmd) {
        IPCT_PlatReset(msgInfo->chNum);
    }
}
#endif

int32_t IPCT_Reset(IPC_ChannIDType aChNum)
{
#if CRPTST_IPC_LOOP_BACK == 1
    static IPCT_MsgInfoType msgInfo;
    msgInfo.chNum = aChNum;
    return SVC_RunTestSvc(IPCT_TEST_MSG_RESET, (uint8_t *)&msgInfo);
#else
    return BCM_ERR_OK;
#endif
}

int32_t IPCT_PreInit(IPC_ChannIDType aChNum)
{
#if CRPTST_IPC_LOOP_BACK == 1
    static IPCT_MsgInfoType msgInfo;
    msgInfo.chNum = aChNum;
    return SVC_RunTestSvc(IPCT_TEST_BUF_INFO_SET, (uint8_t *)&msgInfo);
#else
    return BCM_ERR_OK;
#endif
}

int32_t IPCT_PostInit(IPC_ChannIDType aChNum)
{
#if CRPTST_IPC_LOOP_BACK == 1
    static IPCT_MsgInfoType msgInfo;
    msgInfo.chNum = aChNum;
    return SVC_RunTestSvc(IPCT_TEST_BUF_INFO_GET, (uint8_t *)&msgInfo);
#else
    IPC_Init(aChNum);
    return BCM_ERR_OK;
#endif
}

int32_t IPCT_Send(IPC_ChannIDType aChNum, IPC_ChannModeType aMode, uint32_t aCmd, uint8_t *aData, uint32_t aLen)
{
#if CRPTST_IPC_LOOP_BACK == 1
    static IPCT_MsgInfoType msgInfo;
    uint32_t i;

    msgInfo.magic = IPC_MAGIC_CMD;
    msgInfo.cmd = aCmd;
    msgInfo.len = aLen;
    msgInfo.chNum = aChNum;
    msgInfo.mode = aMode;
    BCM_MemCpy(msgInfo.data, aData, aLen);

    for(i = aLen; 0U != (i&3U); i++) {
        msgInfo.data[i] = 0;
    }
    msgInfo.checksum = 0;
    msgInfo.checksum = IPCT_CalcChecksum((uint32_t *)&msgInfo, msgInfo.len);
    SVC_RunTestSvc(IPCT_TEST_MSG_SEND, (uint8_t *)&msgInfo);
    return msgInfo.status;
#else
    return IPC_Send(aChNum, aCmd, aData, aLen);
#endif
}

int32_t IPCT_Recv(IPC_ChannIDType aChNum, IPC_ChannModeType aMode, uint32_t *aCmd, uint8_t *aData, uint32_t *aLen)
{
#if CRPTST_IPC_LOOP_BACK == 1
    static IPCT_MsgInfoType msgInfo;

    msgInfo.chNum = aChNum;
    msgInfo.mode = aMode;
    msgInfo.len = 0;
    SVC_RunTestSvc(IPCT_TEST_MSG_RECV, (uint8_t *)&msgInfo);

    *aLen = msgInfo.len;
    *aCmd = msgInfo.cmd;
    BCM_MemCpy(aData, msgInfo.data, msgInfo.len);

    return msgInfo.status;
#else
    return IPC_Receive(aChNum, aCmd, aData, IPCT_MSG_MAX_PAYLOAD, aLen);
#endif
}