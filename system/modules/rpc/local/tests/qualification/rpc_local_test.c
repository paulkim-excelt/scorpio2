/*****************************************************************************
 Copyright 2021-2022 Broadcom Limited.  All rights reserved.

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
#include <rpc_local.h>
#include <rpc_local_osil.h>
#include <rpc_master_loader.h>
#include <rpc_loadrawtest.h>
#include <bcm_time.h>
#include <module_helper.h>
#include <time_module_osil.h>

#define GetModuleLogLevel()         (ULOG_LVL_INFO)

/** Qualification Test Number Enumeration */
typedef uint32_t RPC_LocalTestSeqNumType;
#define RPC_TEST1        (0x0001UL)  /**< Local Master Message Test Sequence */
#define RPC_TEST2        (0x0002UL)  /**< Local Master Stream Test Sequence */
#define RPC_TEST3        (0x0003UL)  /**< Local Slave Message Test Sequence */
#define RPC_TEST4        (0x0004UL)  /**< Local Slave Message Test Sequence */
#define RPC_TEST5        (0x0005UL)  /**< Local Slave stream Test Sequence */
#define RPC_TEST6        (0x0006UL)  /**< Local Master Message Test Sequence */
#define RPC_TEST7        (0x0007UL)  /**< Negative cases */
#define RPC_TEST_MAX     (RPC_TEST7) /**< Total tests */

#define RPC_MSGQ_RAW_STRM_SIZE    (8192UL) /* 7.5k data + 512bytes space for IMGH */

static uint32_t RPC_LocalTestIndex;
static int32_t RPC_LocalTestResult = BCM_AT_NOT_STARTED;

/************ SEQ 1 & 2 : RPC MessageQ Master Test *************/
#define RPC_LOCAL_TEST_TIMEOUT (1UL)
#define RPC_MSGQ_MASTER_SREAM_MAX_SIZE (0x2000UL)
#define RPC_CMD_MSGQ_TEST_COUNT        (4UL)

typedef struct sRPC_LocalTestCmdType {
    uint32_t    cmdId;
    uint8_t     cmdBuff[RPC_MEM_MSG_PAYLOAD_SZ];
    uint32_t    len;
    uint32_t appinfo;
} RPC_LocalTestCmdType;

typedef struct sRPC_TestCmdRespType {
    uint8_t                cmdID;                           /**< @brief Switch/Ethernet command identifier */
    BCM_CompIDType         compID;                          /**< @brief Component identifier */
    int32_t                ret;                             /**< @brief Return status */
    uint32_t               payloadLen;                      /**< @brief Length of command payload in bytes */
    uint8_t                payload[RPC_MEM_MSG_PAYLOAD_SZ]; /**< @brief Space for command response payload */
} RPC_TestCmdRespType;

static RPC_HdlType RPC_LocalTestInHdl;
static RPC_HdlType RPC_LocalTestOutHdl;
static RPC_HdlType RPC_LocalTestRespHdl;
static RPC_HdlType RPC_LocalTestAsyncHdl;
static uint32_t RPC_LocalTestTimeoutMs;
static RPC_TestCmdRespType RPC_LocalTestRespEntry;
static RPC_LocalTestCmdType RPC_LocalTestCmd;  /* Seq 3,5 */
#ifdef ENABLE_RPC_MASTER_STREAM_SUPPORT
static uint8_t RPC_LocalTestStrmWrBuf[RPC_MSGQ_MASTER_SREAM_MAX_SIZE];
static uint8_t RPC_LocalTestStrmRdBuf[RPC_MSGQ_MASTER_SREAM_MAX_SIZE];
static uint8_t RPC_LocalTestRdBuffer[RPC_MSGQ_RAW_STRM_SIZE];
#endif
static RPC_TestCmdRespType  RPC_LocalTestEthSrvCmds[RPC_CMD_MSGQ_TEST_COUNT];
void* RPC_TestCmdGetMessage(uint32_t idx);

MSGQ_DEFINE_V3(RPC_TestCmdQRPC, RPC_CMD_MSGQ_TEST_COUNT, RPC_TestTask, SystemEvent7,
               MSGQ_CLIENT_SIGNAL_ENABLE, RPC_TestCmdRespType, RPC_TestCmdHdrQRPC,
               RPC_TestCmdGetMessage, ".data.ethsrv");

const RPC_InterfaceType RPC_LocalTestSlaveIfc = {
    .type          = RPC_IFC_CHAN_IPC,
    .mode          = RPC_IFC_CHAN_MODE_SLAVE,
    .assoc         = RPC_ASSOCIATIONINDEX_0,
};

const RPC_InterfaceType RPC_LocalTestMasterIfc = {
    .type          = RPC_IFC_CHAN_IPC,
    .mode          = RPC_IFC_CHAN_MODE_MASTER,
    .assoc         = RPC_ASSOCIATIONINDEX_1,
};

static const RPC_InterfaceType* const RPC_Interfaces[RPC_INTERFACEID_MAX] = {
    &RPC_LocalTestSlaveIfc,
    &RPC_LocalTestMasterIfc,
    &RPC_SlaveIfc,
    &RPC_MasterIfc,
    NULL,
    NULL,
    NULL,
    NULL,
};

const ITBL_Type RPC_TestITBL;

const MSGQ_MsgHdrType *RPC_LocalTestMsgHdrPtr;

const RPC_InterfaceType* const * RPC_GetModInterfaces()
{
    return RPC_Interfaces;
}

/******** SEQ3 & SEQ4: Slave Module Test ************/
#define RPC_TEST_STREAM_MAX_SIZE     (4UL * 1024UL)
#define RPC_TEST_IPC_STREAM_PKT_SIZE (384UL)

/************ SEQ1: MessageQ Master Test *************/
void* RPC_TestCmdGetMessage(uint32_t idx)
{
    void* pRet = NULL;

    if (idx < RPC_CMD_MSGQ_TEST_COUNT) {

        pRet = (void *)(&RPC_LocalTestEthSrvCmds[idx]);
    }
    return pRet;
}

static void RPC_LocalTestPrepareCmd(void)
{
    uint32_t i;
    uint8_t   cmdID;
    uint8_t   groupID;
    uint16_t  compID;
    uint32_t sampleVal = 0x90;

    cmdID =0U;
    groupID =BCM_GROUPID_TEST;
    compID=BCM_SWT_ID;
    RPC_LocalTestCmd.cmdId = BCM_CMDID(groupID, compID, cmdID);
    RPC_LocalTestCmd.len = RPC_MEM_MSG_PAYLOAD_SZ;
    for (i = 0UL; i < RPC_MEM_MSG_PAYLOAD_SZ; i++) {
        RPC_LocalTestCmd.cmdBuff[i] = sampleVal++;
    }
}

static int32_t RPC_LocalTestSendCmd(BCM_CmdType aCmd, uint32_t aLen, const uint8_t *aCmdData,
                                BCM_HandleType *aHandle, uint32_t *aForwardToSlaves)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;
    RPC_TestCmdRespType cmdEntry;
    uint32_t cmdID;
    BCM_CompIDType compID;

    cmdID   = (uint8_t)BCM_GET_CMDID(aCmd);
    compID  = (uint16_t)BCM_GET_COMP(aCmd);

    if ((aCmdData != NULL) && (aHandle != NULL) && (aForwardToSlaves != NULL)
        && (RPC_MEM_MSG_PAYLOAD_SZ >= aLen)){
        switch(compID) {
        case BCM_SWT_ID:
            cmdEntry.compID = compID;
            cmdEntry.cmdID = cmdID;
            cmdEntry.ret = BCM_ERR_UNKNOWN;
            cmdEntry.payloadLen = aLen;
            BCM_MemCpy(cmdEntry.payload, aCmdData, aLen);
            retVal = MSGQ_SendMsgv2(&RPC_TestCmdQRPC, (uint8_t *)&cmdEntry, RPC_MSGQ_MASTER_EVENT, aHandle);
            break;
        default:
            retVal = BCM_ERR_NOSUPPORT;
            break;
        }
    }
    if (BCM_ERR_OK != retVal) {
        ULOG_ERR("%s line:%d\n", __func__, __LINE__);
    }

    return retVal;
}

static int32_t RPC_TestGetCmdStatus(BCM_HandleType aHandle, BCM_CmdType aReplyID, uint32_t aInLen,
                                     uint8_t *aReplyData, uint32_t *aReplyDataLen)
{
    int32_t  retVal = BCM_ERR_OK;
    BCM_CompIDType compID;

    compID  = (uint16_t)BCM_GET_COMP(aReplyID);

    if ((aReplyData != NULL) && (aReplyDataLen != NULL)) {
        switch(compID) {
            case BCM_SWT_ID:
            retVal = MSGQ_RecvMsgv2(&RPC_TestCmdQRPC, aHandle, (uint8_t *)&RPC_LocalTestRespEntry);
            if ((BCM_ERR_OK != retVal) && (BCM_ERR_BUSY != retVal)) {
                retVal = RPC_LocalTestRespEntry.ret;
                ULOG_ERR("%s retVal=%d line:%d\n", __func__, retVal, __LINE__);
            } else if (BCM_ERR_OK == retVal) {
                if(RPC_MEM_MSG_PAYLOAD_SZ >= RPC_LocalTestRespEntry.payloadLen){
                    /* Copy the response payload */
                    BCM_MemCpy(aReplyData, RPC_LocalTestRespEntry.payload, RPC_LocalTestRespEntry.payloadLen);
                    *aReplyDataLen = RPC_LocalTestRespEntry.payloadLen;
                } else {
                    /* Case when the response payload is incorrect */
                    RPC_LocalTestRespEntry.ret = BCM_ERR_INVAL_PARAMS;
                }

                /* Copy the response status */
                if (BCM_ERR_BUSY != RPC_LocalTestRespEntry.ret) {
                    retVal = RPC_LocalTestRespEntry.ret;
                } else {
                    retVal = BCM_ERR_UNKNOWN;
                }
            }
                break;
            default:
                retVal = BCM_ERR_NOSUPPORT;
                break;
        }
    } else {
        retVal = BCM_ERR_INVAL_PARAMS;
    }

    return retVal;
}

const SERVICE_Type RPC_LocalTestIfc = {
    .group = BCM_GROUPID_TEST,
    .server = {
        .groupID = BCM_GROUPID_TEST,
        .sendCmd = RPC_LocalTestSendCmd,
        .getResp = RPC_TestGetCmdStatus,
    },
};

static int32_t RPC_LocalInit()
{
    int32_t retVal;
    uint32_t temp;

    RPC_MemInit();
    retVal = RPC_MasterIfc.init();
    if (BCM_ERR_OK != retVal) {
        goto done;
    }

    retVal = RPC_MasterIfc.connect();
    if (BCM_ERR_OK != retVal) {
        goto done;
    }

    temp = RPC_MasterIfc.getMsgSize();
    if (RPC_MEM_MSG_PAYLOAD_SZ != temp) {
        goto done;
    }

    temp = RPC_MasterIfc.isConnected();
    if (TRUE != temp) {
        goto done;
    }

done:
    return retVal;
}

static int32_t RPC_LocalTestMasterSendMsg()
{
    int32_t retVal;
    RPC_MemMsgType *msg;

    RPC_LocalTestInHdl = RPC_HDL_INVALID;
    retVal = RPC_MsgAlloc(RPC_LocalTestInHdl, RPC_INTERFACEID_0, RPC_INTERFACEID_1,
                                  RPC_ASSOCIATIONINDEX_0, &RPC_LocalTestOutHdl);
    if(BCM_ERR_OK != retVal) {
        goto done;
    }
    msg = RPC_MsgGet(RPC_LocalTestOutHdl);
    msg->cmd =  RPC_LocalTestCmd.cmdId;
    msg->len =  RPC_LocalTestCmd.len;
    msg->timeoutMs = RPC_LocalTestTimeoutMs;
    BCM_MemCpy(msg->payload, RPC_LocalTestCmd.cmdBuff,RPC_MEM_MSG_PAYLOAD_SZ);

    retVal = RPC_MasterIfc.sendMsg(RPC_LocalTestOutHdl);
    if (BCM_ERR_OK != retVal) {
        goto done;
    }
done:
    return retVal;
}

static int32_t RPC_LocalTestMsgRecvResp(void)
{
    int32_t retVal;
    RPC_MemMsgType *inMsg;
    RPC_MemMsgType *outMsg;

    retVal = RPC_MasterIfc.recvMsg(&RPC_LocalTestRespHdl);
    if (BCM_ERR_OK != retVal) {
        goto done;
    } else {
        inMsg = RPC_MsgGet(RPC_LocalTestOutHdl);
        outMsg = RPC_MsgGet(RPC_LocalTestRespHdl);
        if(0L != memcmp(inMsg->payload, outMsg->payload, RPC_MEM_MSG_PAYLOAD_SZ)) {
            retVal = BCM_ERR_UNKNOWN;
        }
    }
done:
    return retVal;
}

static void RPC_LocalTestCompleteMsg(void)
{
    uint32_t cmdMsgIdx = 0UL;
    int32_t retVal;

    ULOG_ERR("%s line:%d\n", __func__, __LINE__);
    retVal = MSGQ_GetMsgIdx(&RPC_TestCmdQRPC, &cmdMsgIdx);
    if (BCM_ERR_OK == retVal) {
        (void)MSGQ_CompleteMsgIdx(&RPC_TestCmdQRPC, cmdMsgIdx);
    }
}

#ifdef ENABLE_RPC_MASTER_STREAM_SUPPORT
static int32_t RPC_LocalTestStrmLoad(uint32_t aIdx)
{
    int32_t retVal = BCM_ERR_OK;
    uint32_t offset = 0UL;
    uint16_t imgID = 0UL;
    uint32_t bufSize = RPC_MSGQ_MASTER_SREAM_MAX_SIZE;

    RPC_LocalTestMsgHdrPtr = NULL;
    BCM_MemSet(RPC_LocalTestStrmRdBuf, 0U, sizeof(RPC_LocalTestStrmRdBuf));

    switch (aIdx) {
    case 0UL:
        retVal = RPC_MasterImgHandler.readImg(IMGL_CHANNEL_IDX1, PTBL_ID_SYSCFG, imgID, 0UL, RPC_LocalTestStrmRdBuf,
                                              offset, bufSize, RPC_MSGQ_MASTER_LOADER_EVENT, &RPC_LocalTestMsgHdrPtr);
        break;
    case 1UL:
        retVal = RPC_MasterImgHandler.readPTBL(IMGL_CHANNEL_IDX1, 0UL, RPC_LocalTestStrmRdBuf,
                                               bufSize, RPC_MSGQ_MASTER_LOADER_EVENT, &RPC_LocalTestMsgHdrPtr);
        break;
    case 2UL:
        retVal = RPC_MasterImgHandler.readITBL(IMGL_CHANNEL_IDX1, PTBL_ID_SYSCFG, 0UL, RPC_LocalTestStrmRdBuf,
                                               bufSize, RPC_MSGQ_MASTER_LOADER_EVENT, &RPC_LocalTestMsgHdrPtr);
        break;
    default:
        retVal = BCM_ERR_INVAL_PARAMS;
        break;
    }

    return retVal;
}

static int32_t RPC_LocalTestStrmProcess(void)
{
    uint32_t i;
    uint32_t wrSize;
    uint32_t totalWrSize;
    RPC_HdlType strmHdl = 0UL;
    int32_t retVal = BCM_ERR_OK;
    BCM_SubStateType slaveIfcStatus = BCM_STATE_SUB_STATE_DONE;
    BCM_SubStateType masterIfcStatus = BCM_STATE_SUB_STATE_DONE;
    RPC_StrmCfgType cfg;

    for(i=0; i<RPC_MSGQ_MASTER_SREAM_MAX_SIZE; i++) {
        RPC_LocalTestStrmWrBuf[i]= i;
    }

    retVal = RPC_MasterIfc.detectStrm(&strmHdl);
    if(BCM_ERR_OK == retVal) {
        do {
            (void)RPC_StrmGetFreeSz(strmHdl, &wrSize, &totalWrSize);
            (void)RPC_StrmGetCfg(strmHdl, &cfg);
            if ((cfg.xferSize - totalWrSize) < wrSize) {
                wrSize = cfg.xferSize - totalWrSize;
            }
            retVal = RPC_StrmWrite(strmHdl, (RPC_LocalTestStrmWrBuf+totalWrSize), wrSize);
            if((BCM_ERR_NOMEM == retVal) || (BCM_ERR_OK == retVal)) {
                (void)RPC_GetStreamStatus(strmHdl, &slaveIfcStatus, &masterIfcStatus);
                retVal = RPC_MasterIfc.processStrm(strmHdl, slaveIfcStatus);
            } else {
                break;
            }

            uint32_t size;
            retVal = RPC_MasterImgHandler.getStatus(RPC_LocalTestMsgHdrPtr, &size);
            if ((BCM_ERR_BUSY != retVal) && (BCM_ERR_OK != retVal) && (BCM_ERR_NOMEM != retVal)) {
                ULOG_ERR("%s:%d err: %d\n", __func__, __LINE__, retVal);
                break;
            }
        } while(BCM_ERR_BUSY == retVal);
        if(0L != memcmp(RPC_LocalTestStrmWrBuf, RPC_LocalTestStrmRdBuf, cfg.xferSize)) {
            ULOG_ERR("%s Error: %d line:%d\n", __func__, retVal, __LINE__);
        } else {
            ULOG_ERR("Completed\n");
        }
        (void)RPC_Release(strmHdl);
    }

    return retVal;
}
#endif

static void RPC_LocalTestDeinit(void)
{
    uint32_t retVal;

    retVal = RPC_MasterIfc.disconnect();
    if (BCM_ERR_OK != retVal) {
        ULOG_ERR("%s: Master disconnect failed err:%d\n", retVal);
    }

    RPC_MemDeinit();
    RPC_MasterIfc.deinit();
}

static int32_t RPC_LocalTestSequence1(void)
{
    int32_t retVal = BCM_ERR_UNKNOWN;
    BCM_EventMaskType eventMask = 0UL;
    RPC_MemMsgType *outMsg;

    RPC_LocalTestPrepareCmd();

    retVal = RPC_LocalInit();
    if (BCM_ERR_OK != retVal) {
        goto done;
    }

    retVal = RPC_LocalTestMasterSendMsg();
    if(BCM_ERR_OK == retVal) {
        BCM_WaitEvent(RPC_MasterIfc.getEventMask());
        BCM_GetEvent(RPC_TestTask, &eventMask);
        BCM_ClearEvent(eventMask);

        retVal = RPC_MasterIfc.processMsg();
        if (BCM_ERR_OK != retVal) {
            goto done;
        }

        /* call RecvResp */
        retVal = RPC_MasterIfc.recvMsg(&RPC_LocalTestRespHdl);

        /* call RecvResp */
        retVal = RPC_MasterIfc.recvMsg(&RPC_LocalTestRespHdl);

        RPC_LocalTestCompleteMsg();

        BCM_WaitEvent(SystemEvent7);
        BCM_GetEvent(RPC_TestTask, &eventMask);
        BCM_ClearEvent(eventMask);

        retVal = RPC_LocalTestMsgRecvResp();
        (void)RPC_Release(RPC_LocalTestOutHdl);
    }

    /* Send an ASYNC message and verify */
    retVal = RPC_AsyncEventToHost(BCM_GROUPID_ETHSRV, BCM_COM_ID, 0x32U, NULL, 0UL);
    if (BCM_ERR_OK == retVal) {
        retVal = RPC_MasterIfc.recvMsg(&RPC_LocalTestAsyncHdl);
        if (BCM_ERR_OK != retVal) {
            goto done;
        } else {
            outMsg = RPC_MsgGet(RPC_LocalTestAsyncHdl);
            if(1U != ((outMsg->cmd >> BCM_CMD_ASYNC_SHIFT) & 1U)) {
                retVal = BCM_ERR_INVAL_PARAMS;
            }
        }
        (void)RPC_Release(RPC_LocalTestAsyncHdl);
    }

done:
    RPC_LocalTestDeinit();
    return retVal;
}

#ifdef ENABLE_RPC_MASTER_STREAM_SUPPORT
/************ SEQ2: MessageQ Master Test *************/
static int32_t RPC_LocalTestSequence2(void)
{
    int32_t retVal = BCM_ERR_UNKNOWN;
    BCM_EventMaskType eventMask = 0UL;
    uint32_t i;

    RPC_MemInit();
    retVal = RPC_MasterIfc.init();
    if (BCM_ERR_OK != retVal) {
        ULOG_ERR("%s Error: %d line:%d\n", __func__, retVal, __LINE__);
        goto done;
    }

    for (i = 0UL; i < 3UL; i++) {
        retVal = RPC_LocalTestStrmLoad(i);
        if(BCM_ERR_OK == retVal) {
            BCM_WaitEvent(RPC_MSGQ_MASTER_LOADER_EVENT);
            BCM_GetEvent(RPC_TestTask, &eventMask);
            BCM_ClearEvent(eventMask);
            retVal = RPC_LocalTestStrmProcess();
            if(BCM_ERR_OK != retVal) {
                break;
            }
        } else {
            break;
        }
    }
    RPC_LocalTestDeinit();

done:
    return retVal;
}
#endif

static RPC_HdlType cmdHdl;

/************ SEQ3: RPC Message Slave Test *************/
static int32_t RPC_LocalTestSendMsgToSlave(void)
{
    int32_t retVal;
    RPC_MemMsgType *cmdmsg;
    uint32_t temp;

    RPC_MemInit();
    retVal = RPC_SlaveIfc.init();
    if (BCM_ERR_OK != retVal) {
        goto done;
    }

    retVal = RPC_SlaveIfc.connect();
    if (BCM_ERR_OK != retVal) {
        goto done;
    }

    temp = RPC_SlaveIfc.getMsgSize();
    if (RPC_MEM_MSG_PAYLOAD_SZ != temp) {
        goto done;
    }

    temp = RPC_SlaveIfc.isConnected();
    if (TRUE != temp) {
        goto done;
    }

    retVal = RPC_MsgAlloc(RPC_HDL_INVALID, RPC_INTERFACEID_0, RPC_INTERFACEID_2,
                                  RPC_ASSOCIATIONINDEX_0, &cmdHdl);
    if(BCM_ERR_OK != retVal) {
        goto done;
    }
    cmdmsg = RPC_MsgGet(cmdHdl);
    cmdmsg->cmd =  RPC_LocalTestCmd.cmdId;
    cmdmsg->len =  RPC_LocalTestCmd.len;
    BCM_MemCpy(cmdmsg->payload, RPC_LocalTestCmd.cmdBuff,RPC_MEM_MSG_PAYLOAD_SZ);

    retVal = RPC_SendToSlave(cmdHdl, &RPC_LocalTestCmd.appinfo);
    if (BCM_ERR_OK != retVal) {
        goto done;
    } else {
        retVal = RPC_Release(cmdHdl);
        if (BCM_ERR_OK != retVal) {
            goto done;
        }
    }

done:

    return retVal;
}

/* Test the Command receiving from MsgQ Master
   Send command to LWQ and receive response from LWQ */
static int32_t RPC_LocalTestSequence3(void)
{
    int32_t retVal;

    RPC_HdlType tempHdl;
    RPC_MemMsgType *inCmdmsg;
    RPC_MemMsgType *outCmdmsg;
    RPC_HdlType masterHdl;

    RPC_LocalTestPrepareCmd();
    retVal = RPC_LocalTestSendMsgToSlave();
    if(BCM_ERR_OK == retVal) {
        retVal = RPC_SlaveIfc.processMsg();
        if (BCM_ERR_OK != retVal) {
            goto done;
        }

        retVal = RPC_SlaveIfc.recvMsg(&RPC_LocalTestOutHdl);
        if(BCM_ERR_OK != retVal) {
            /* Failed to receive message */
            goto done;
        }
    } else {
       /* Failed to send command request on LWQ */
        goto done;
    }

    retVal = RPC_RecvFromSlave(&RPC_LocalTestRespHdl, &masterHdl);
    if(BCM_ERR_NOT_FOUND != retVal) {
       /* The response is not yet received */
        goto done;
    }

    /* Clone the handle to use as a response for test */
    retVal = RPC_MsgAlloc(RPC_LocalTestOutHdl, RPC_INTERFACEID_0, RPC_INTERFACEID_1,
                                  RPC_ASSOCIATIONINDEX_1, &tempHdl);
    if(BCM_ERR_OK == retVal) {
        (void)RPC_MsgPushAppInfo(RPC_MsgGet(tempHdl), RPC_LocalTestOutHdl);
        retVal = RPC_SlaveIfc.sendMsg(tempHdl);
        if(BCM_ERR_OK == retVal) {
            retVal = RPC_RecvFromSlave(&RPC_LocalTestRespHdl, &masterHdl);
            if(BCM_ERR_OK == retVal) {
                inCmdmsg = RPC_MsgGet(RPC_LocalTestOutHdl);
                outCmdmsg = RPC_MsgGet(RPC_LocalTestRespHdl);
                /* compare the  sent data(command) and response on slave interface
                   This test expectes the response as the same data as sent */
                if(0L != memcmp(inCmdmsg->payload, outCmdmsg->payload, sizeof(RPC_MEM_MSG_PAYLOAD_SZ))) {
                    retVal = BCM_ERR_UNKNOWN;
                    goto done;
                } else {
                    (void)RPC_Release(tempHdl);
                    (void)RPC_Release(RPC_LocalTestOutHdl);
                    (void)RPC_Release(RPC_LocalTestRespHdl);
                    retVal = RPC_Release(RPC_LocalTestOutHdl);
                    if(BCM_ERR_OK == retVal) {
                        /* The Handle should not be a valid */
                        goto done;
                    }
                    (void)RPC_Release(RPC_LocalTestRespHdl);
                    if(BCM_ERR_OK == retVal) {
                        /* The Handle should not be a valid */
                        goto done;
                    }
                }
            } else {
               /* The response is not yet received */
                goto done;
            }
        } else {
           /* Send Response is Failed */
            goto done;
        }
    } else {
       /* Message allocation is failed */
        goto done;
    }

    retVal = RPC_SlaveIfc.disconnect();
    if (BCM_ERR_OK != retVal) {
        goto done;
    }

    RPC_MemDeinit();
    RPC_SlaveIfc.deinit();
    retVal = BCM_ERR_OK;
done:

    return retVal;
}

/******* SEQ4:Test Local Command and Response ************/
static int32_t RPC_LocalTestSequence4(void)
{
    int32_t retVal;
    uint32_t size;
    int32_t  status = BCM_ERR_OK;
    BCM_EventMaskType eventMask = 0UL;

    RPC_HdlType tempHdl;
    RPC_MemMsgType *outCmdmsg;
    const MSGQ_MsgHdrType *hdr;
    RPC_LocalTestOutHdl = RPC_HDL_INVALID;
    tempHdl = RPC_HDL_INVALID;

    RPC_MemInit();
    retVal = RPC_SlaveIfc.init();
    if (BCM_ERR_OK != retVal) {
        goto done;
    }
    RPC_LocalTestPrepareCmd();
    retVal = RPC_SlaveSendLocalCmd(BCM_GROUPID_TEST, BCM_SWT_ID,
                                   0U,
                                   RPC_LocalTestCmd.cmdBuff,
                                   RPC_LocalTestCmd.len, 0UL,
                                   RPC_SLAVE_EVENT,
                                   &hdr);

    if(BCM_ERR_OK == retVal) {
        BCM_WaitEvent(RPC_SLAVE_EVENT);
        BCM_GetEvent(RPC_TestTask, &eventMask);
        BCM_ClearEvent(eventMask);
        retVal = RPC_SlaveIfc.recvMsg(&RPC_LocalTestOutHdl);
        if(BCM_ERR_OK != retVal) {
            /* Failed to receive message */
            goto done;
        }
    }

    BCM_MemSet(&RPC_LocalTestCmd,0U,sizeof(RPC_LocalTestCmdType));
    retVal = RPC_SlaveGetLocalResp(hdr, &status,
                                   RPC_LocalTestCmd.cmdBuff,
                                   &size);
    if(BCM_ERR_OK == retVal) {
        /* The response is not yet received */
        goto done;
    }

    /* Clone the handle to use as a response for test */
    retVal = RPC_MsgAlloc(RPC_LocalTestOutHdl, RPC_INTERFACEID_0, RPC_INTERFACEID_1,
                                  RPC_ASSOCIATIONINDEX_1, &tempHdl);
    if(BCM_ERR_OK == retVal) {
        (void)RPC_MsgPushAppInfo(RPC_MsgGet(tempHdl), tempHdl);
        retVal = RPC_SlaveIfc.sendMsg(tempHdl);
        if(BCM_ERR_OK == retVal) {
            retVal = RPC_SlaveGetLocalResp(hdr, &status,
                                           RPC_LocalTestCmd.cmdBuff,
                                           &size);
            if(BCM_ERR_OK != retVal) {
                /* The response is not yet received */
                goto done;
            } else {
                /* compare the  sent data(command) and response on slave interface
                   This test expectes the response as the same data as sent */
                outCmdmsg = RPC_MsgGet(RPC_LocalTestOutHdl);
                if(0L != memcmp(outCmdmsg->payload, RPC_LocalTestCmd.cmdBuff, size)) {
                    retVal = BCM_ERR_UNKNOWN;
                    goto done;
                }
            }
        } else {
           /* Send Response is Failed */
            goto done;
        }
    } else {
        /* Send Response is Failed */
        goto done;
    }

    (void)RPC_Release(RPC_LocalTestOutHdl);
    RPC_MemDeinit();
    RPC_SlaveIfc.deinit();
done:

    return retVal;
}

/************ SEQ5: RPC Message Slave Stream Test *************/
int32_t RPC_LoadRawImg(PTBL_IdType aPid, uint16_t aImgID, uint8_t *const aAddr,
                            uint32_t aOffset, uint32_t aBufSize, const uint32_t aClientMask,
                            const MSGQ_MsgHdrType** const aHdr)
{
    return BCM_TestLoadRawImg(aPid, aImgID, aAddr, aOffset, aBufSize, aClientMask, aHdr);
}

int32_t RPC_LoadGetStatus(const MSGQ_MsgHdrType* const aHdr, uint32_t *const aSize)
{
    return BCM_TestGetLoadImgStatus(aHdr, aSize);
}

int32_t RPC_LoadCancel(const MSGQ_MsgHdrType* const aHdr)
{
    return BCM_ERR_OK;
}

const ITBL_Type *RPC_GetImgTbl(PTBL_IdType aPid)
{
    return &RPC_TestITBL;
}

#ifdef ENABLE_RPC_SLAVE_STREAM_SUPPORT
static int32_t RPC_LocalTestSequence5(void)
{
    int32_t retVal;
    uint32_t rdSize = 0;
    uint32_t filledSize = 0;
    uint32_t totalRdSize =0;

    RPC_HdlType RPC_LocalTestOutHdl;
    RPC_StrmCfgType cfg;
    BCM_EventMaskType eventMask = 0UL;
    BCM_SubStateType slaveIfcStatus = BCM_STATE_SUB_STATE_DONE;
    BCM_SubStateType masterIfcStatus = BCM_STATE_SUB_STATE_DONE;

    cfg.pid = 0x5;
    cfg.imgId = 0xFF00;
    cfg.offset = 0x0;
    cfg.isTbl = FALSE;
    cfg.xferSize = sizeof(RPC_LoadRawData) + 512; /* Extra 512 bytes for IMGH */
    cfg.blkSize = 0x400;
    cfg.isRead = TRUE;

    BCM_MemSet(RPC_LocalTestRdBuffer, 0U, RPC_MSGQ_RAW_STRM_SIZE);

    RPC_MemInit();
    retVal = RPC_SlaveIfc.init();
    if (BCM_ERR_OK != retVal) {
        goto done;
    }

    retVal = RPC_SlaveIfc.detectStrm(&RPC_LocalTestOutHdl);
    if (BCM_ERR_UNKNOWN != retVal) {
        goto done;
    }

    retVal = RPC_StrmAlloc(&cfg, RPC_INTERFACEID_4,
                            RPC_INTERFACEID_5, RPC_ASSOCIATIONINDEX_1,
                            &RPC_LocalTestOutHdl);
    if(BCM_ERR_OK != retVal) {
        goto done;
    }

    /* Fetch the image */
    do {
        (void)RPC_GetStreamStatus(RPC_LocalTestOutHdl, &slaveIfcStatus, &masterIfcStatus);
        retVal = RPC_SlaveIfc.processStrm(RPC_LocalTestOutHdl, masterIfcStatus);
        if (BCM_ERR_BUSY == retVal) {
            BCM_WaitEvent(RPC_SlaveIfc.getEventMask());
            BCM_GetEvent(RPC_TestTask, &eventMask);
            BCM_ClearEvent(eventMask);
            retVal = RPC_SlaveIfc.processStrm(RPC_LocalTestOutHdl, masterIfcStatus);
            if(BCM_ERR_UNKNOWN == retVal) {
                goto done;
            }
        }

        if((BCM_ERR_OK == retVal) || (BCM_ERR_NOMEM == retVal)) {
            (void)RPC_StrmGetFilledSz(RPC_LocalTestOutHdl, &rdSize, &totalRdSize);
            retVal = RPC_StrmRead(RPC_LocalTestOutHdl, (RPC_LocalTestRdBuffer + totalRdSize) , rdSize, &filledSize);
            if(BCM_ERR_NOMEM == retVal) {
                continue;
            }
        }
    } while(BCM_ERR_OK != retVal);

    /* Ignore the first 512bytes of IMGH */
    if(0L != memcmp(RPC_LocalTestRdBuffer + 512, RPC_LoadRawData, sizeof(RPC_LoadRawData))) {
        retVal = BCM_ERR_UNKNOWN;
    }
    (void)RPC_Release(RPC_LocalTestOutHdl);

    RPC_LocalTestDeinit();
done:
    return retVal;
}
#endif

#define RPC_IT_LOG(result)          RPC_LocalTestLogResult(result, __LINE__)
#define RPC_LOCALTEST_MAX_TESTS     (32UL)
static uint16_t RPC_LocalTestErrorLines[RPC_LOCALTEST_MAX_TESTS];
static uint16_t RPC_LocalTestLastExecLine;
static uint8_t RPC_LocalTestErrorCount;

static void RPC_LocalTestLogResult(uint8_t aResult, uint32_t lineNum)
{
    if(FALSE == aResult) {
        RPC_LocalTestErrorLines[RPC_LocalTestErrorCount] = lineNum;
        RPC_LocalTestErrorCount = (RPC_LocalTestErrorCount + 1) % RPC_LOCALTEST_MAX_TESTS;
    }
    RPC_LocalTestLastExecLine = lineNum;
}

int32_t RPC_LocalTestSendCmdTimeout()
{
    int32_t retVal = BCM_ERR_UNKNOWN;

    RPC_LocalTestPrepareCmd();

    RPC_LocalTestTimeoutMs = 1UL;
    /* should return BCM_ERR_UNKNOWN */
    retVal = RPC_LocalTestMasterSendMsg();
    if(BCM_ERR_OK == retVal) {
        do {
            /* call RecvResp */
            retVal = RPC_MasterIfc.recvMsg(&RPC_LocalTestRespHdl);
        } while (BCM_ERR_OK != retVal);
        if (RPC_LocalTestRespHdl != RPC_LocalTestOutHdl) {
            retVal = BCM_ERR_UNKNOWN;
        }
        (void)RPC_Release(RPC_LocalTestOutHdl);
    }

    return retVal;
}

int32_t RPC_LocalTestSendCmdInvGrp()
{
    int32_t retVal = BCM_ERR_UNKNOWN;

    RPC_LocalTestPrepareCmd();

    /* invalid group ID */
    RPC_LocalTestCmd.cmdId = BCM_CMDID(BCM_GROUPID_INVALID, 0U, 0U);

    /* should return BCM_ERR_UNKNOWN */
    retVal = RPC_LocalTestMasterSendMsg();
    if(BCM_ERR_OK == retVal) {
        do {
            /* call RecvResp */
            retVal = RPC_MasterIfc.recvMsg(&RPC_LocalTestRespHdl);
        } while (BCM_ERR_OK != retVal);
        (void)RPC_Release(RPC_LocalTestOutHdl);
        if (RPC_LocalTestRespHdl != RPC_LocalTestOutHdl) {
            retVal = BCM_ERR_UNKNOWN;
        }
    }

    return retVal;
}

static int32_t RPC_LocalTestSlaveSendAsyncInvGrp()
{
    int32_t retVal;
    RPC_MemMsgType *msg;

    RPC_LocalTestInHdl = RPC_HDL_INVALID;
    retVal = RPC_MsgAlloc(RPC_LocalTestInHdl, RPC_INTERFACEID_0, RPC_INTERFACEID_1,
                                  RPC_ASSOCIATIONINDEX_0, &RPC_LocalTestOutHdl);
    if(BCM_ERR_OK != retVal) {
        goto done;
    }
    msg = RPC_MsgGet(RPC_LocalTestOutHdl);
    msg->cmd = BCM_ASYNCID(BCM_GROUPID_INVALID, 0U, 0U) | BCM_CMD_ASYNC_MASK;
    msg->len = RPC_LocalTestCmd.len;
    msg->timeoutMs = RPC_LocalTestTimeoutMs;
    BCM_MemCpy(msg->payload, RPC_LocalTestCmd.cmdBuff,RPC_MEM_MSG_PAYLOAD_SZ);

    retVal = RPC_SlaveIfc.sendMsg(RPC_LocalTestOutHdl);
    (void)RPC_Release(RPC_LocalTestOutHdl);
done:
    return retVal;
}

static int32_t RPC_LocalTestSequence7()
{
    int32_t retVal;
    uint32_t temp = 0x12345678;

    retVal = RPC_LocalInit();
    if (BCM_ERR_OK != retVal) {
        goto done;
    }

#ifdef ENABLE_RPC_MASTER_STREAM_SUPPORT
    /* Invalid aAddr */
    RPC_IT_LOG(BCM_ERR_INVAL_PARAMS == RPC_MasterImgHandler.readImg(IMGL_CHANNEL_IDX1, PTBL_ID_SYSCFG, 0U, 0UL,
                                        NULL, 0UL, 1UL, RPC_MSGQ_MASTER_LOADER_EVENT, (const MSGQ_MsgHdrType**)&temp));
    /* Invalid aBufSize */
    RPC_IT_LOG(BCM_ERR_INVAL_PARAMS == RPC_MasterImgHandler.readImg(IMGL_CHANNEL_IDX1, PTBL_ID_SYSCFG, 0U, 0UL,
                                        (uint8_t *)&temp, 0UL, 0UL, RPC_MSGQ_MASTER_LOADER_EVENT, (const MSGQ_MsgHdrType**)&temp));
    /* Invalid aHdr*/
    RPC_IT_LOG(BCM_ERR_INVAL_PARAMS == RPC_MasterImgHandler.readImg(IMGL_CHANNEL_IDX1, PTBL_ID_SYSCFG, 0U, 0UL,
                                        (uint8_t *)&temp, 0UL, 1UL, RPC_MSGQ_MASTER_LOADER_EVENT, NULL));

    /* Invalid aDownloadAddress */
    RPC_IT_LOG(BCM_ERR_INVAL_PARAMS == RPC_MasterImgHandler.readPTBL(IMGL_CHANNEL_IDX1, 0UL,
                                        NULL, 10UL, RPC_MSGQ_MASTER_LOADER_EVENT, (const MSGQ_MsgHdrType**)temp));
    /* Invalid aMaxSize */
    RPC_IT_LOG(BCM_ERR_INVAL_PARAMS == RPC_MasterImgHandler.readPTBL(IMGL_CHANNEL_IDX1, 0UL,
                                        (uint8_t *)&temp, 0UL, RPC_MSGQ_MASTER_LOADER_EVENT, (const MSGQ_MsgHdrType**)&temp));
    /* Invalid aHdr */
    RPC_IT_LOG(BCM_ERR_INVAL_PARAMS == RPC_MasterImgHandler.readPTBL(IMGL_CHANNEL_IDX1, 0UL,
                                        (uint8_t *)&temp, 1UL, RPC_MSGQ_MASTER_LOADER_EVENT, NULL));

    /* Invalid aDownloadAddress */
    RPC_IT_LOG(BCM_ERR_INVAL_PARAMS == RPC_MasterImgHandler.readITBL(IMGL_CHANNEL_IDX1, PTBL_ID_SYSCFG, 0UL,
                                        NULL, 10UL, RPC_MSGQ_MASTER_LOADER_EVENT, (const MSGQ_MsgHdrType**)&temp));
    /* Invalid aMaxSize */
    RPC_IT_LOG(BCM_ERR_INVAL_PARAMS == RPC_MasterImgHandler.readITBL(IMGL_CHANNEL_IDX1, PTBL_ID_SYSCFG, 0UL,
                                        (uint8_t *)&temp, 0UL, RPC_MSGQ_MASTER_LOADER_EVENT, (const MSGQ_MsgHdrType**)&temp));
    /* Invalid aHdr */
    RPC_IT_LOG(BCM_ERR_INVAL_PARAMS == RPC_MasterImgHandler.readITBL(IMGL_CHANNEL_IDX1, PTBL_ID_SYSCFG, 0UL,
                                        (uint8_t *)&temp, 10UL, RPC_MSGQ_MASTER_LOADER_EVENT, NULL));
#endif

    RPC_IT_LOG(BCM_ERR_UNKNOWN == RPC_MasterIfc.sendMsg(0UL));

    RPC_IT_LOG(BCM_ERR_INVAL_PARAMS == RPC_AsyncEventToHost(BCM_GROUPID_ETHSRV, BCM_COM_ID, 0x32U,
                                            NULL, 1UL));
    RPC_IT_LOG(BCM_ERR_INVAL_PARAMS == RPC_AsyncEventToHost(BCM_GROUPID_ETHSRV, BCM_COM_ID, 0x32U,
                                            (const uint8_t *)&temp, (RPC_MEM_MSG_PAYLOAD_SZ + 1UL)));

    RPC_IT_LOG(BCM_ERR_OK == RPC_LocalTestSendCmdInvGrp());
    RPC_IT_LOG(BCM_ERR_OK == RPC_LocalTestSendCmdTimeout());

    RPC_IT_LOG(BCM_ERR_INVAL_PARAMS == RPC_SlaveGetLocalResp(NULL,
                                        (int32_t *)&temp, (uint8_t *)&temp, (uint32_t *)&temp));
    RPC_IT_LOG(BCM_ERR_INVAL_PARAMS == RPC_SlaveGetLocalResp((MSGQ_MsgHdrType *)&temp,
                                        NULL, (uint8_t *)&temp, (uint32_t *)&temp));
    temp = 1UL;
    RPC_IT_LOG(BCM_ERR_INVAL_PARAMS == RPC_SlaveGetLocalResp((MSGQ_MsgHdrType *)&temp,
                                        (int32_t *)&temp, NULL, (uint32_t *)&temp));
    RPC_IT_LOG(BCM_ERR_INVAL_PARAMS == RPC_SlaveGetLocalResp((MSGQ_MsgHdrType *)&temp,
                                        (int32_t *)&temp, (uint8_t *)&temp, NULL));

    RPC_IT_LOG(BCM_ERR_UNKNOWN == RPC_SlaveIfc.sendMsg(RPC_HDL_INVALID));

    RPC_IT_LOG(BCM_ERR_UNKNOWN == RPC_LocalTestSlaveSendAsyncInvGrp());

    if (0UL == RPC_LocalTestErrorCount) {
        retVal = BCM_ERR_OK;
    } else {
        retVal = BCM_ERR_UNKNOWN;
    }

    RPC_LocalTestDeinit();

done:
    return retVal;
}

TASK(RPC_TestTask)
{
    int32_t retVal;

    if(RPC_TEST1 == RPC_LocalTestIndex) {
        RPC_LocalTestTimeoutMs = 0UL;
        retVal = RPC_LocalTestSequence1();
    } else if(RPC_TEST2 == RPC_LocalTestIndex) {
#ifdef ENABLE_RPC_MASTER_STREAM_SUPPORT
        retVal = RPC_LocalTestSequence2();
#else
        retVal = BCM_ERR_OK;
#endif
    } else if(RPC_TEST3 == RPC_LocalTestIndex) {
        retVal = RPC_LocalTestSequence3();
    } else if(RPC_TEST4 == RPC_LocalTestIndex) {
#ifdef RPC_SLAVE_ENABLE_LOCALCMD_SUPPORT
        retVal = RPC_LocalTestSequence4();
#else
        retVal = BCM_ERR_OK;
#endif
    } else if(RPC_TEST5 == RPC_LocalTestIndex) {
#ifdef ENABLE_RPC_SLAVE_STREAM_SUPPORT
        retVal = RPC_LocalTestSequence5();
#else
        retVal = BCM_ERR_OK;
#endif
    } else if(RPC_TEST6 == RPC_LocalTestIndex) {
        RPC_LocalTestTimeoutMs = 10UL;
        retVal = RPC_LocalTestSequence1();
    } else if(RPC_TEST7 == RPC_LocalTestIndex) {
        retVal = RPC_LocalTestSequence7();
    } else {
        retVal = BCM_ERR_UNKNOWN;
    }

    if(BCM_AT_EXECUTING == RPC_LocalTestResult) {
        RPC_LocalTestResult = retVal;
    }
    ULOG_ERR("\n Test %d completed\n", RPC_LocalTestIndex);
    (void)BCM_TerminateTask();
}

int32_t BCM_ExecuteAT(uint32_t aIndex)
{
    int32_t retVal;

    if ((RPC_TEST_MAX >= aIndex) && (0UL < aIndex)) {
        if (BCM_AT_EXECUTING != RPC_LocalTestResult) {
            RPC_LocalTestIndex = aIndex;
            RPC_LocalTestResult = BCM_AT_EXECUTING;
            retVal = (int32_t)BCM_ActivateTask(RPC_TestTask);
            if (BCM_ERR_OK != retVal) {
                ULOG_ERR("%s:%d Activation failed Err:%d\n", __func__, __LINE__, retVal);
                RPC_LocalTestResult = BCM_AT_NOT_STARTED;
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
        if(RPC_LocalTestIndex == aIndex) {
            retVal = RPC_LocalTestResult;
        }
    }
    return retVal;
}

void APP_Init(void)
{
    /* Dummy Init */
}
