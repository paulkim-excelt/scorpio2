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
#include <shell.h>
#include <bcm_err.h>
#include <bcm_test.h>
#include <bcm_comp.h>
#include <bcm_utils.h>
#include <ee.h>
#include <ulog.h>
#include <rpc_mem.h>
#include <rpc_interface.h>
#include <rpc_mem_osil.h>
#include <rpc_ipc_slave_osil.h>
#include <rpc_ipc_common.h>
#include <ipc.h>
#include <ipc_hwif.h>

#define GetModuleLogLevel()         (ULOG_LVL_INFO)

/** Qualification Test Number Enumeration */
typedef uint32_t RPC_TestSeqNumType;
#define RPC_TEST1        (0x0001UL)         /**< Message Test sequence */
#define RPC_TEST2        (0x0002UL)         /**< Stream Test Sequence */
#define RPC_TEST_MAX     (RPC_TEST2)        /**< Test max value */

static uint32_t RPC_TestIndex;
static int32_t RPC_TestResult = BCM_AT_NOT_STARTED;

#define RPC_TEST_STREAM_MAX_SIZE     (4UL * 1024UL)
#define RPC_TEST_IPC_STREAM_PKT_SIZE (384UL)

typedef uint32_t RPC_TestSVCType;
#define RPC_TEST_SENDCMDMSG            (0UL)
#define RPC_TEST_RECV_RESPONSE         (1UL)
#define RPC_TEST_RECV_ASYNC_REQ        (2UL)
#define RPC_TEST_SEND_STREAM_DATA      (3UL)
#define RPC_TEST_SEND_UNKNOWN_CMD      (4UL)
#define RPC_TEST_RECV_LEGACY_RESPONSE  (5UL)
#define RPC_TEST_SEND_IMGL_PING        (6UL)
#define RPC_TEST_SEND_IMGL_PING_RESP   (7UL)
#define RPC_TEST_DRAIN_QUEUE           (8UL)

static RPC_MemMsgType RPC_TestResponse;
static RPC_MemMsgType RPC_TestCmd;
static uint8_t streamTestData[RPC_TEST_STREAM_MAX_SIZE];
static uint32_t imgDataLenOffset = 0UL;
static uint8_t streamPacketBuf[512];
static uint8_t streamReadBackBuf[RPC_TEST_STREAM_MAX_SIZE];
static uint32_t streamReadBackBufOffset = 0UL;
RPC_DwnldHdrV2Type imgHdr;
RPC_DwnldImageType img;

extern int32_t IPC_HostPlatGetBuffInfo(IPC_ChannIDType aID, uint8_t **const aBuff, uint16_t *const aCnt,
                                       uint8_t *const aCntRollOverMask, uint16_t *const aSize);
extern int32_t IPC_PlatSetIntr(IPC_ChannIDType aID);

typedef struct sIPC_BuffInfoType {
   uint8_t *buffer;
   uint16_t msgCount;
   uint16_t msgSize;
   uint16_t rolloverMask;
} IPC_BuffInfoType;

uint32_t Host_IPCDrvCalChecksum(uint32_t aMagic, uint32_t aCmd, uint32_t *aMsg, uint32_t aLen)
{
    uint32_t i;
    uint32_t chksum = 0UL;
    for (i = 0UL; i < (aLen >> 2UL); i++) {
        chksum += aMsg[i];
    }
    chksum += aMagic;
    chksum += aLen;
    chksum += aCmd;
    return (~chksum) + 1UL;
}

int32_t IPC_HostSend(IPC_ChannIDType aID, uint32_t aCmd, uint8_t *aMsg, uint32_t aLen)
{
    uint16_t wPtr;
    uint16_t rPtr;
    uint32_t idx;
    uint32_t *ipcBuf;
    uint8_t *ipcBufBase;
    uint16_t ipcMsgCnt;
    uint16_t ipcMsgSz;
    uint16_t hostReg;
    uint16_t targetReg;
    uint8_t  cntRollOverMask;
    uint32_t buffer[128];
    int32_t  ret = BCM_ERR_OK;
    uint32_t cnt = 0UL;
    uint32_t alignedLen = aLen;
    alignedLen += 3UL;
    alignedLen &= ~3UL;

    ret = IPC_HostPlatGetBuffInfo(aID, &ipcBufBase, &ipcMsgCnt, &cntRollOverMask, &ipcMsgSz);
    if (ret != BCM_ERR_OK) {
        goto err;
    }

    targetReg = *((volatile uint16_t *)IPC_TARGET_STAT_REG);
    hostReg = *((volatile uint16_t *)IPC_HOST_STAT_REG);
    rPtr = (targetReg & IPC_TARGET_STAT_RD_MASK) >> IPC_TARGET_STAT_RD_SHIFT;
    wPtr = (hostReg & IPC_HOST_STAT_WR_MASK) >> IPC_HOST_STAT_WR_SHIFT;
    idx = (wPtr & (ipcMsgCnt - 1));

    /* Check if there a slot available for send */
    if (((rPtr + ipcMsgCnt) & IPC_MAX_PTR_MASK) != wPtr) {
        ipcBuf = buffer;
        BCM_MemSet(ipcBuf, 0U, sizeof(buffer));
        BCM_MemCpy(&ipcBuf[IPC_MSG_HDR_SIZE >> 2UL], aMsg, aLen);
        ipcBuf[IPC_HDR_MAGIC_INDEX] = 0xa5a5a5a5UL;
        ipcBuf[IPC_HDR_CHKSUM_INDEX] = Host_IPCDrvCalChecksum(ipcBuf[IPC_HDR_MAGIC_INDEX], aCmd,
                                            &ipcBuf[IPC_HDR_LAST_INDEX], aLen);
        ipcBuf[IPC_HDR_COMMAND_INDEX] = aCmd;
        ipcBuf[IPC_HDR_LENGTH_INDEX] = aLen;

        cnt = 0UL;
        uint32_t tempAddr = (uint32_t)&ipcBufBase[idx * ipcMsgSz];
        uint8_t * dataPtr = (uint8_t*)ipcBuf;

        /* Copy the data */
        do {
            *((volatile uint32_t *)tempAddr) =  *((volatile uint32_t *)dataPtr);
            dataPtr += 4UL;
            tempAddr += 4UL;
            cnt += 4UL;
        } while (cnt < (alignedLen + IPC_MSG_HDR_SIZE));

        /* Update write pointer in register */
        wPtr++;
        wPtr &= cntRollOverMask;

        hostReg &= ~IPC_HOST_STAT_WR_MASK;
        hostReg |= ((wPtr << IPC_HOST_STAT_WR_SHIFT) & IPC_HOST_STAT_WR_MASK);
        *((volatile uint16_t *)IPC_HOST_STAT_REG) =  *((volatile uint16_t *)&hostReg);

        /* Raise a signal */
        IPC_PlatSetIntr(aID);
    } else {
        ret = BCM_ERR_NOMEM;
    }

err:
    return ret;
}

int32_t IPC_HostRecv(IPC_ChannIDType aID, uint32_t *aCmd, uint8_t *aMsg, uint32_t aInLen, uint32_t *aOutLen)
{
    uint16_t wPtr;
    uint16_t rPtr;
    uint32_t idx;
    uint32_t *ipcBuf;
    uint8_t *ipcBufBase;
    uint16_t ipcMsgCnt;
    uint16_t ipcMsgSz;
    uint16_t hostReg;
    uint16_t targetReg;
    uint8_t  cntRollOverMask;
    uint32_t msgLen;
    uint32_t chksum;
    uint32_t header[IPC_HDR_LAST_INDEX];
    int32_t  ret = BCM_ERR_OK;
    uint32_t cnt = 0UL;

    ret = IPC_HostPlatGetBuffInfo(aID, &ipcBufBase, &ipcMsgCnt, &cntRollOverMask, &ipcMsgSz);
    if (ret != BCM_ERR_OK) {
        goto err;
    }

    targetReg = *((volatile uint16_t *)IPC_TARGET_STAT_REG);
    hostReg = *((volatile uint16_t *)IPC_HOST_STAT_REG);

    wPtr = (targetReg & IPC_TARGET_STAT_WR_MASK) >> IPC_TARGET_STAT_WR_SHIFT;
    rPtr = (hostReg & IPC_HOST_STAT_RD_MASK) >> IPC_HOST_STAT_RD_SHIFT;
    idx = (rPtr & (ipcMsgCnt - 1)) + ipcMsgCnt;

    if (rPtr != wPtr) {
        /* read the header first */
        ipcBuf = (uint32_t *)&ipcBufBase[(idx * ipcMsgSz)];

        header[IPC_HDR_MAGIC_INDEX] = *((volatile uint32_t *)ipcBuf);
        header[IPC_HDR_CHKSUM_INDEX] = *((volatile uint32_t *)ipcBuf+1);
        header[IPC_HDR_COMMAND_INDEX] = *((volatile uint32_t *)ipcBuf+2);
        header[IPC_HDR_LENGTH_INDEX] = *((volatile uint32_t *)ipcBuf+3);

        if (0x5a5a5a5aUL != header[IPC_HDR_MAGIC_INDEX]) {
            ret = BCM_ERR_INVAL_MAGIC;
            goto err;
        }

        msgLen = header[IPC_HDR_LENGTH_INDEX];
        /* read the payload */
        if (aInLen >= msgLen) {

            cnt = 0UL;
            uint32_t tempAddr = (uint32_t)aMsg;
            uint8_t * dataPtr = (uint8_t*)(((uint32_t)(intptr_t)ipcBuf) + sizeof(header));

            /* Fetch the data */
            do {
                *((volatile uint32_t *)tempAddr) =  *((volatile uint32_t *)dataPtr);
                dataPtr += 4UL;
                tempAddr += 4UL;
                cnt += 4UL;
            } while (cnt < msgLen);

            /* Validate the checksum */
            chksum = Host_IPCDrvCalChecksum(header[IPC_HDR_MAGIC_INDEX],
                                            header[IPC_HDR_COMMAND_INDEX],
                                            (uint32_t*)aMsg,
                                            header[IPC_HDR_LENGTH_INDEX]);
            if (chksum == header[IPC_HDR_CHKSUM_INDEX]) {
                *aCmd = header[IPC_HDR_COMMAND_INDEX];
                *aOutLen = header[IPC_HDR_LENGTH_INDEX];
            } else {
                ret = BCM_ERR_DATA_INTEG;
            }

            /* Update read pointer */
            rPtr++;
            rPtr &= cntRollOverMask;
            hostReg &= ~IPC_HOST_STAT_RD_MASK;
            hostReg |= (rPtr << IPC_HOST_STAT_RD_SHIFT) & IPC_HOST_STAT_RD_MASK;
            *((volatile uint16_t *)IPC_HOST_STAT_REG) =  *((volatile uint16_t *)&hostReg);
        } else {
            ret = BCM_ERR_INVAL_PARAMS;
        }
    } else {
        ret = BCM_ERR_NOMEM;
    }
err:
    if ((BCM_ERR_OK != ret) && (BCM_ERR_NOMEM != ret)) {
        /* Log error */
    }
    return ret;
}

void SVC_TestSvcHandler(uint32_t aMagicID, uint32_t aCmd, uint8_t *aSysIO)
{
    int32_t retVal;
    BCM_CmdType recvCmd;
    uint32_t outLen;
    uint32_t copyLen = 0UL;
    uint32_t sampleVal = 0x90;
    uint32_t idx;
    int32_t ackRespCode;

    switch(aCmd) {
        case RPC_TEST_SENDCMDMSG:
            RPC_TestCmd.magic = RPC_MEMMSG_MAGIC;
            RPC_TestCmd.cmd = BCM_CMDID(BCM_GROUPID_TEST, BCM_SWT_ID, 0U);
            RPC_TestCmd.len = RPC_MEM_MSG_PAYLOAD_SZ;
            RPC_TestCmd.response = BCM_ERR_CUSTOM;
            for (idx = 0UL; idx < RPC_MEM_MSG_PAYLOAD_SZ; idx++) {
                RPC_TestCmd.payload[idx] = sampleVal++;
            }
            retVal = IPC_HostSend(0U, RPC_TestCmd.cmd, (uint8_t*)&RPC_TestCmd, sizeof(RPC_TestCmd));
            if (BCM_ERR_OK != retVal) {
                RPC_TestResult = retVal;
            }
            break;
        case RPC_TEST_SEND_IMGL_PING:
            RPC_TestCmd.magic = RPC_MEMMSG_MAGIC;
            RPC_TestCmd.cmd = BCM_CMDID(BCM_GROUPID_IMGL, 0U, 1U);
            RPC_TestCmd.len = 0UL;
            RPC_TestCmd.response = BCM_ERR_CUSTOM;
            retVal = IPC_HostSend(0U, RPC_TestCmd.cmd, (uint8_t*)&RPC_TestCmd, sizeof(RPC_TestCmd));
            if (BCM_ERR_OK != retVal) {
                RPC_TestResult = retVal;
            }
            break;
        case RPC_TEST_RECV_RESPONSE:
            retVal = IPC_HostRecv(0U, &recvCmd, (uint8_t*)&RPC_TestResponse, sizeof(RPC_TestResponse), &outLen);
            if (BCM_ERR_OK != retVal) {
                RPC_TestResult = retVal;
            } else  if (outLen != sizeof(RPC_TestResponse)) {
                RPC_TestResult = BCM_ERR_DATA_INTEG;
            } else {
                /* Verify response payload */
                if(0L != memcmp(RPC_TestResponse.payload, RPC_TestCmd.payload, RPC_TestResponse.len)) {
                    /* Log error */
                    RPC_TestResult = BCM_ERR_DATA_INTEG;
                }
            }
            break;
        case RPC_TEST_SEND_IMGL_PING_RESP:
            retVal = IPC_HostRecv(0U, &recvCmd, (uint8_t*)&RPC_TestResponse, sizeof(RPC_TestResponse), &outLen);
            if (BCM_ERR_OK != retVal) {
                RPC_TestResult = retVal;
            }
            break;
        case RPC_TEST_RECV_LEGACY_RESPONSE:
            retVal = IPC_HostRecv(0U, &recvCmd, (uint8_t*)&RPC_TestResponse, sizeof(RPC_TestResponse), &outLen);
            if (BCM_ERR_OK != retVal) {
                RPC_TestResult = retVal;
            } else  if (outLen != sizeof(uint32_t)) {
                RPC_TestResult = BCM_ERR_DATA_INTEG;
            } else {
                /* Nothing */
            }
            break;
        case RPC_TEST_RECV_ASYNC_REQ:
            outLen = 0UL;
            retVal = IPC_HostRecv(0U, &recvCmd, (uint8_t*)streamPacketBuf, sizeof(streamPacketBuf), &outLen);
            if (0UL < outLen) {
                /* Got Async Request */
                if (recvCmd == (RPC_CMDIDVAL_IMAGE_FETCH_V2 | BCM_CMD_ASYNC_MASK)) {
                    RPC_ImgReqV2Type *imgReq = (RPC_ImgReqV2Type *)streamPacketBuf;
                    imgHdr.imgSize = RPC_TEST_STREAM_MAX_SIZE;
                    imgHdr.targetStrmHdl = imgReq->targetStrmHdl;
                    retVal = IPC_HostSend(0U, RPC_CMDIDVAL_DWNLD_IMG_HDR_V2, (uint8_t*)&imgHdr, sizeof(imgHdr));
                    if (BCM_ERR_OK != retVal) {
                        RPC_TestResult = retVal;
                    }
                    /* Prepare test image data */
                    for (idx = 0UL; idx < RPC_TEST_STREAM_MAX_SIZE; idx++) {
                        streamTestData[idx] = sampleVal++;
                    }
                    imgDataLenOffset = 0UL;
                } else if (recvCmd == (RPC_CMDIDVAL_IMAGE_PART_FETCH_V2 | BCM_CMD_ASYNC_MASK)) {
                    /* TODO */
                } else {
                    /* Nothing */
                }
            } else {
                RPC_TestResult = BCM_ERR_NOT_FOUND;
            }
            break;
        case RPC_TEST_SEND_STREAM_DATA:
            retVal = IPC_HostRecv(0U, &recvCmd, (uint8_t*)streamPacketBuf, sizeof(streamPacketBuf), &outLen);
            if ((0UL < outLen) && (imgDataLenOffset < RPC_TEST_STREAM_MAX_SIZE)) {
                if (0UL == imgDataLenOffset) {
                    /* Check ACK for last IMGH sent */
                    RPC_DwnldHdrV2Type *imgHdrAck = (RPC_DwnldHdrV2Type *)streamPacketBuf;
                    ackRespCode = imgHdrAck->response;
                } else {
                    /* Check ACK for last DATA packet sent */
                    RPC_DwnldImageType *imgDataAck = (RPC_DwnldImageType *)streamPacketBuf;
                    ackRespCode = imgDataAck->response;
                }
                if (BCM_ERR_OK != ackRespCode) {
                    RPC_TestResult = ackRespCode;
                } else {
                    img.targetStrmHdl = imgHdr.targetStrmHdl;
                    if (RPC_TEST_STREAM_MAX_SIZE < (RPC_TEST_IPC_STREAM_PKT_SIZE + imgDataLenOffset)) {
                        copyLen = RPC_TEST_STREAM_MAX_SIZE - imgDataLenOffset;
                    } else {
                        copyLen = RPC_TEST_IPC_STREAM_PKT_SIZE;
                    }
                    BCM_MemCpy(img.imgData, &streamTestData[imgDataLenOffset], copyLen);
                    img.len = copyLen;
                    imgDataLenOffset += copyLen;
                    retVal = IPC_HostSend(0U, RPC_CMDIDVAL_DWNLD_IMG_V2, (uint8_t*)&img, sizeof(img));
                    if (BCM_ERR_OK != retVal) {
                        RPC_TestResult = retVal;
                    }
                }
            }
            break;
        case RPC_TEST_SEND_UNKNOWN_CMD:
            RPC_TestCmd.magic = RPC_MEMMSG_MAGIC;
            RPC_TestCmd.cmd = BCM_CMDID(BCM_GROUPID_APP, BCM_SWT_ID, 0U);
            RPC_TestCmd.len = RPC_MEM_MSG_PAYLOAD_SZ;
            RPC_TestCmd.response = BCM_ERR_CUSTOM;
            for (idx = 0UL; idx < RPC_MEM_MSG_PAYLOAD_SZ; idx++) {
                RPC_TestCmd.payload[idx] = sampleVal++;
            }
            retVal = IPC_HostSend(0U, RPC_TestCmd.cmd, (uint8_t*)&RPC_TestCmd, sizeof(RPC_TestCmd));
            if (BCM_ERR_OK != retVal) {
                RPC_TestResult = retVal;
            }
            break;
        case RPC_TEST_DRAIN_QUEUE:
            do {
                retVal = IPC_HostRecv(0U, &recvCmd, (uint8_t*)&RPC_TestResponse, sizeof(RPC_TestResponse), &outLen);
            } while (BCM_ERR_OK == retVal);
            break;
        default:
            break;
    }

    return;
}

const RPC_InterfaceType RPC_Master = {
    .type          = RPC_IFC_CHAN_MSGQ,
    .mode          = RPC_IFC_CHAN_MODE_MASTER,
    .assoc         = RPC_ASSOCIATIONINDEX_0,
};

const RPC_InterfaceType* const RPC_Interfaces[RPC_INTERFACEID_MAX] = {
    &RPC_IPCSlaveIfc,
    &RPC_Master,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
};

const RPC_InterfaceType* const * RPC_GetModInterfaces()
{
    return RPC_Interfaces;
}

int32_t RPC_TestSequence0(void)
{
    /*
        COMMANDS:

        1. IPC_HostSend(command message in new message format)
        2. Invoke RecvMsg(aHdl)
           RecvMsg should return valid aHdl
           invoke RecvMsg again and make sure it returns ERR_NOT_FOUND
           check for command payload recvd
           release(aHdl)
        3. Allocate aRespHdl
           Prepare response and invoke SendMsg(aRespHdl)
           check for ERR_OK
        4. IPC_HostRecv(response) should come back with response payload
           Check and validate the response payload
        5. Repeat steps 1-4 with message in legacy format
    */

    int32_t retVal;
    RPC_MemMsgType *outMsg = NULL;
    RPC_HdlType outHdl = 0UL;

    /* Drain old messages in queue */
    SVC_RunTestSvc(RPC_TEST_DRAIN_QUEUE, NULL);

    /* Initialize the RPC Memory */
    RPC_MemInit();

    /* COMMAND HANDLING CHECKS */
    retVal = RPC_IPCSlaveIfc.init();
    if (BCM_ERR_OK != retVal) {
        goto done;
    }

    /* Verify other interfaces */
    retVal = RPC_IPCSlaveIfc.connect();
    if (BCM_ERR_OK != retVal) {
        goto done;
    }

    retVal = RPC_IPCSlaveIfc.isConnected();
    if (TRUE != retVal) {
        goto done;
    }

    (void)RPC_IPCSlaveIfc.getEventMask();

    /* Send a message to the IPC driver at target */
    SVC_RunTestSvc(RPC_TEST_SENDCMDMSG, NULL);

    retVal = RPC_IPCSlaveIfc.recvMsg(&outHdl);
    if (BCM_ERR_OK != retVal) {
        goto done;
    }

    outMsg = RPC_MsgGet(outHdl);
    if(NULL == outMsg) {
        retVal = BCM_ERR_INVAL_PARAMS;
        goto done;
    }

    if(0L != memcmp(outMsg->payload, RPC_TestCmd.payload, RPC_MEM_MSG_PAYLOAD_SZ)) {
        retVal = BCM_ERR_DATA_INTEG;
        goto done;
    }

    /* Free the message handle */
    RPC_Release(outHdl);

    /* Check that interface does not return any other buffer */
    retVal = RPC_IPCSlaveIfc.recvMsg(&outHdl);
    if (BCM_ERR_NOT_FOUND != retVal) {
        goto done;
    }

    /* Verify sending response - Allocate a message handle */
    retVal = RPC_MsgAlloc(RPC_HDL_INVALID, RPC_INTERFACEID_0, RPC_INTERFACEID_1,
                          RPC_ASSOCIATIONINDEX_1, &outHdl);
    if(BCM_ERR_OK != retVal) {
        goto done;
    }
    outMsg = RPC_MsgGet(outHdl);
    outMsg->cmd =  RPC_TestCmd.cmd;
    outMsg->len =  RPC_TestCmd.len;
    BCM_MemCpy(outMsg->payload, RPC_TestCmd.payload, RPC_MEM_MSG_PAYLOAD_SZ);

    /* Send test response */
    retVal = RPC_IPCSlaveIfc.sendMsg(outHdl);
    if (BCM_ERR_OK != retVal) {
        goto done;
    }

    /* Poll and verify response message sent by IPC Slave interface */
    SVC_RunTestSvc(RPC_TEST_RECV_RESPONSE, (uint8_t*)outMsg);

    /* Send legacy test response */
    retVal = RPC_MsgAlloc(RPC_HDL_INVALID, RPC_INTERFACEID_0, RPC_INTERFACEID_1,
                          RPC_ASSOCIATIONINDEX_1, &outHdl);
    if(BCM_ERR_OK != retVal) {
        goto done;
    }
    outMsg = RPC_MsgGet(outHdl);
    outMsg->cmd =  RPC_TestCmd.cmd;
    outMsg->len =  0UL;
    outMsg->rsvd = TRUE;

    /* Check with invalid argument */
    retVal = RPC_IPCSlaveIfc.sendMsg(0UL);
    if (BCM_ERR_UNKNOWN != retVal) {
        goto done;
    }

    retVal = RPC_IPCSlaveIfc.sendMsg(outHdl);
    if (BCM_ERR_OK != retVal) {
        goto done;
    }

    /* Poll and verify legacy response message sent by IPC Slave interface */
    SVC_RunTestSvc(RPC_TEST_RECV_LEGACY_RESPONSE, (uint8_t*)outMsg);

    /* Send IMGL-PING command to IPC slave */
    SVC_RunTestSvc(RPC_TEST_SEND_IMGL_PING, NULL);

    retVal = RPC_IPCSlaveIfc.recvMsg(&outHdl);
    if (BCM_ERR_BUSY != retVal) {
        goto done;
    }

    /* Poll and verify IMGL PING response */
    SVC_RunTestSvc(RPC_TEST_SEND_IMGL_PING_RESP, (uint8_t*)outMsg);

    /* Check for return error */
    retVal = RPC_IPCSlaveIfc.recvMsg(NULL);
    if (BCM_ERR_UNKNOWN != retVal) {
        goto done;
    }

    retVal = RPC_IPCSlaveIfc.disconnect();
    if (BCM_ERR_OK != retVal) {
        goto done;
    }

    RPC_IPCSlaveIfc.deinit();

    /* De-Initialize the RPC Memory */
    RPC_MemDeinit();

done:

    return retVal;
}

int32_t RPC_TestSequence1(void)
{
    /*
        STREAMS:

        1. StreamAlloc(aStrmHdl)
           populate PID and IMGID
        2. ProcessStream(aStrmHdl) to send ASYNC request
        3. IPC_HostRecv(async) and make sure ASYNC request is got
        4. IPC_HostSend(IMG Hdr)
        5. Loop {
            Invoke RecvMsg() and ProcessStream() of the interface repeatedly
            IPC_HostRecv(wait for IMG Hdr ACK)
            IPC_HostSend(IMG data)
           }
        6. When streamHandle is filled, verify stream payload fetched by IPC slave interface
    */

    int32_t retVal;
    int32_t ret;
    RPC_HdlType strmHdl = 0UL;
    RPC_HdlType outHdl = 0UL;
    RPC_StrmCfgType strmCfg;
    uint32_t outSize;
    uint32_t totalSize;

    /* Drain old messages in queue */
    SVC_RunTestSvc(RPC_TEST_DRAIN_QUEUE, NULL);

    /* Initialize the RPC Memory */
    RPC_MemInit();

    /* STREAM HANDLING CHECKS */
    retVal = RPC_IPCSlaveIfc.init();
    if (BCM_ERR_OK != retVal) {
        goto done;
    }

    strmCfg.pid = 0x100;
    strmCfg.imgId = 0x20;
    strmCfg.offset = 0UL;
    strmCfg.isTbl = 0UL;
    strmCfg.xferSize = RPC_TEST_STREAM_MAX_SIZE;
    strmCfg.blkSize = RPC_TEST_STREAM_MAX_SIZE/2UL;
    strmCfg.isRead = 0UL;

    /* Allocate a stream handle handle */
    retVal = RPC_StrmAlloc(&strmCfg, RPC_INTERFACEID_0,
                           RPC_INTERFACEID_2, RPC_ASSOCIATIONINDEX_0,
                           &strmHdl);
    if(BCM_ERR_OK != retVal) {
        goto done;
    }

    /* Let the IPC Slave start stream processing - ASYNC request should go out */
    retVal = RPC_IPCSlaveIfc.processStrm(strmHdl, 0UL);
    if (BCM_ERR_BUSY != retVal) {
        goto done;
    }

    /* Poll and verify ASYNC request sent by IPC Slave interface */
    /* This will also send the IMG header for stream request  */
    SVC_RunTestSvc(RPC_TEST_RECV_ASYNC_REQ, NULL);

    /* Reset value before starting stream processing */
    streamReadBackBufOffset = 0UL;

    do {
        retVal = RPC_IPCSlaveIfc.recvMsg(&outHdl);
        if (BCM_ERR_UNKNOWN == retVal) {
            goto done;
        }
        retVal = RPC_IPCSlaveIfc.processStrm(strmHdl, 0UL);
        if ((BCM_ERR_BUSY != retVal) && (BCM_ERR_OK != retVal)) {
            goto done;
        }

        outSize = 0UL;
        ret = RPC_StrmGetFilledSz(strmHdl, &outSize, &totalSize);
        if ((BCM_ERR_OK == ret) && (0UL < outSize)) {
            /* Fetch the stream data filled by interface */
            ret = RPC_StrmRead(strmHdl, &streamReadBackBuf[streamReadBackBufOffset],
                               outSize, &outSize);
            if (0UL < outSize) {
                streamReadBackBufOffset += outSize;
            }
        }

        SVC_RunTestSvc(RPC_TEST_SEND_STREAM_DATA, NULL);
         /* Compare stream data when processStream returns BCM_ERR_OK */
        if (streamReadBackBufOffset == RPC_TEST_STREAM_MAX_SIZE) {
            if (0L != memcmp(streamReadBackBuf, streamTestData, RPC_TEST_STREAM_MAX_SIZE)) {
                retVal = BCM_ERR_DATA_INTEG;
            } else {
                retVal = BCM_ERR_OK;
            }
            break;
        }
    } while (BCM_ERR_OK != retVal);

    RPC_Release(strmHdl);

    /* Check for partial fetch request */
    strmCfg.pid = 0x100;
    strmCfg.imgId = 0x20;
    strmCfg.offset = 256;
    strmCfg.isTbl = 0UL;
    strmCfg.xferSize = RPC_TEST_STREAM_MAX_SIZE;
    strmCfg.blkSize = RPC_TEST_STREAM_MAX_SIZE/2UL;
    strmCfg.isRead = 0UL;
    strmCfg.partial = TRUE;

    /* Allocate a stream handle handle */
    retVal = RPC_StrmAlloc(&strmCfg, RPC_INTERFACEID_0,
                           RPC_INTERFACEID_2, RPC_ASSOCIATIONINDEX_0,
                           &strmHdl);
    if(BCM_ERR_OK != retVal) {
        goto done;
    }

    retVal = RPC_IPCSlaveIfc.processStrm(strmHdl, 0UL);
    if (BCM_ERR_BUSY != retVal) {
        goto done;
    }

    /* Verify the part fetch request sent */
    SVC_RunTestSvc(RPC_TEST_RECV_ASYNC_REQ, NULL);

    /* Indicate peer response as DONE */
    retVal = RPC_IPCSlaveIfc.processStrm(strmHdl, BCM_STATE_SUB_STATE_DONE);
    if (BCM_ERR_OK != retVal) {
        goto done;
    }

    RPC_IPCSlaveIfc.deinit();

     /* De-Initialize the RPC Memory */
    RPC_MemDeinit();

done:
    return retVal;
}

TASK(RPC_TestTask)
{
    int32_t retVal;

    if(RPC_TEST1 == RPC_TestIndex) {
        retVal = RPC_TestSequence0();
    } else if(RPC_TEST2 == RPC_TestIndex) {
        retVal = RPC_TestSequence1();
    } else {
        retVal = BCM_ERR_UNKNOWN;
    }

    if(BCM_AT_EXECUTING == RPC_TestResult) {
        RPC_TestResult = retVal;
    }
    ULOG_ERR("\n Test %d completed\n", RPC_TestIndex);
    (void)BCM_TerminateTask();
}

int32_t BCM_ExecuteAT(uint32_t aIndex)
{
    int32_t retVal;

    if ((RPC_TEST_MAX >= aIndex) && (0UL < aIndex)) {
        if (BCM_AT_EXECUTING != RPC_TestResult) {
            RPC_TestIndex = aIndex;
            RPC_TestResult = BCM_AT_EXECUTING;
            retVal = (int32_t)BCM_ActivateTask(RPC_TestTask);
            if (BCM_ERR_OK != retVal) {
                ULOG_ERR("%s:%d Activation failed Err:%d\n", __func__, __LINE__, retVal);
                RPC_TestResult = BCM_AT_NOT_STARTED;
                retVal = BCM_ERR_INVAL_STATE;
            }
        } else {
            retVal = BCM_ERR_OK;
        }
    } else {
        retVal = BCM_AT_NOT_AVAILABLE;
    }

    return retVal;
}

int32_t BCM_GetResultAT(uint32_t aIndex)
{
    int32_t retVal = BCM_AT_NOT_AVAILABLE;

    if ((RPC_TEST_MAX >= aIndex) && (0UL < aIndex)) {
        if(RPC_TestIndex == aIndex) {
            retVal = RPC_TestResult;
        }
    }
    return retVal;
}
