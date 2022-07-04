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
#include <rpc_local.h>
#include <rpc_local_osil.h>
#include <rpc_master_loader.h>
#include <rpc_loadrawtest.h>
#include <rpc_ipc_slave_osil.h>
#include <rpc_ipc_common.h>
#include <ipc.h>
#include <ipc_hwif.h>

#define GetModuleLogLevel()         (ULOG_LVL_INFO)

/** Qualification Test Number Enumeration */
typedef uint32_t RPC_TestSeqNumType;
#define RPC_TEST1        (0x0001UL)         /**< Message Memory Test sequence */
#define RPC_TEST2        (0x0002UL)         /**< Stream Memory Test Sequence */
#define RPC_TEST5        (0x0005UL)         /**< RPC IPC Slave Module Command test */
#define RPC_TEST6        (0x0006UL)         /**< RPC IPC Slave Module Stream test */
#define RPC_TEST7        (0x0007UL)         /**< RPC Module Command and resposne Test */
#define RPC_TEST8        (0x0008UL)         /**< RPC Module Streams Test */
#define RPC_MASTER_TESTS (RPC_TEST8)        /**< RPC Module Test */
#define RPC_TEST_MAX  (RPC_MASTER_TESTS)           /**< Max tests for Master*/
static uint32_t RPC_TestIndex;
static int32_t RPC_TestResult = BCM_AT_NOT_STARTED;

/************ SEQ 5 & 6 : RPC MessageQ Slave Test *************/
#define RPC_MSGQ_RAW_STRM_SIZE    (8192UL)

/************ SEQ 1 & 2 : RPC Message Memory Test *************/
#define RPC_MEM_STRM_XFERSIZE    (4096UL)    /**< Total Transfer size */
static uint8_t RPC_WrBuffer[RPC_MSGQ_RAW_STRM_SIZE];
static uint8_t RPC_RdBuffer[RPC_MSGQ_RAW_STRM_SIZE];

/************ SEQ 3 & 4 : RPC MessageQ Master Test *************/
#define RPC_MSGQ_MASTER_SREAM_MAX_SIZE (0x2000UL)
#define RPC_CMD_MSGQ_TEST_COUNT        (4UL)

typedef struct sRPC_MsgQTestCmdType {
    uint32_t    cmdId;
    uint8_t     cmdBuff[RPC_MEM_MSG_PAYLOAD_SZ];
    uint32_t    len;
    uint32_t appinfo;
} RPC_MsgQTestCmdType;

typedef struct sRPC_TestCmdRespType {
    uint8_t                cmdID;                           /**< @brief Switch/Ethernet command identifier */
    BCM_CompIDType         compID;                          /**< @brief Component identifier */
    int32_t                ret;                             /**< @brief Return status */
    uint32_t               payloadLen;                      /**< @brief Length of command payload in bytes */
    uint8_t                payload[RPC_MEM_MSG_PAYLOAD_SZ]; /**< @brief Space for command response payload */
} RPC_TestCmdRespType;

static RPC_HdlType inHdl;
static RPC_HdlType outHdl;
static RPC_HdlType respHdl;
static RPC_HdlType asyncHdl;
static RPC_TestCmdRespType respEntry;
static RPC_MsgQTestCmdType RPC_MsgQTestCmd;  /* Seq 3,5 */
static uint8_t streamWrBuff[RPC_MSGQ_MASTER_SREAM_MAX_SIZE];
static uint8_t streamRdBuff[RPC_MSGQ_MASTER_SREAM_MAX_SIZE];
static RPC_TestCmdRespType  ethsrvCmds[RPC_CMD_MSGQ_TEST_COUNT];
void* RPC_TestCmdGetMessage(uint32_t idx);

MSGQ_DEFINE_V3(RPC_TestCmdQRPC, RPC_CMD_MSGQ_TEST_COUNT, RPC_TestTask, SystemEvent7,
               MSGQ_CLIENT_SIGNAL_ENABLE, RPC_TestCmdRespType, RPC_TestCmdHdrQRPC,
               RPC_TestCmdGetMessage, ".data.ethsrv");

/******** SEQ8 & SEQ9: IPC Slave Module Test ************/
#define RPC_TEST_STREAM_MAX_SIZE     (4UL * 1024UL)
#define RPC_TEST_IPC_STREAM_PKT_SIZE (384UL)

typedef uint32_t RPC_TestSVCType;
#define RPC_TEST_SENDCMDMSG         (0UL)
#define RPC_TEST_RECV_RESPONSE      (1UL)
#define RPC_TEST_RECV_ASYNC_REQ     (2UL)
#define RPC_TEST_SEND_STREAM_DATA   (3UL)
#define RPC_TEST_SEND_UNKNOWN_CMD   (4UL)

static RPC_MemMsgType RPC_TestResponse;
static RPC_MemMsgType RPC_TestCmd;
static uint8_t streamTestData[RPC_TEST_STREAM_MAX_SIZE];
static uint32_t imgDataLenOffset = 0UL;
static uint8_t streamPacketBuf[512];
static uint8_t streamReadBackBuf[RPC_TEST_STREAM_MAX_SIZE];
static uint32_t streamReadBackBufOffset = 0UL;
RPC_DwnldHdrV2Type imgHdr;
RPC_DwnldImageType img;

extern int32_t IPC_PlatGetBuffInfo(IPC_ChannIDType aID, uint8_t **const aBuff, uint16_t *const aCnt,
                                   uint8_t *const aCntRollOverMask, uint16_t *const aSize);
extern int32_t IPC_PlatSetIntr(IPC_ChannIDType aID);

/************ SEQ0: RPC Message Memory Test *************/
static int32_t RPC_TestSequence0(void)
{
    int32_t retVal;
    uint32_t i;

    RPC_HdlType hdl;
    RPC_HdlType inHdl;
    RPC_HdlType outHdl;
    RPC_HdlType outHdlPool[RPC_MEM_MSG_COUNT];
    RPC_MemMsgType *msg1;
    RPC_MemMsgType *msg2;
    RPC_MemMsgType *msg3;
    RPC_AssociationIndexType assocId = RPC_ASSOCIATIONINDEX_0;

    /* Prepare the handle to validate the stale handle */
    hdl = (((RPC_INTERFACEID_0 << RPC_HDL_SLAVEID_SHIFT) & RPC_HDL_SLAVEID_MASK)
                | (( RPC_INTERFACEID_2<< RPC_HDL_MASTERID_SHIFT) & RPC_HDL_MASTERID_MASK)
                | (RPC_HDL_TYPE_MSG  << RPC_HDL_TYPE_SHIFT)
                | ((1UL << RPC_HDL_IDX_SHIFT) & RPC_HDL_IDX_MASK));

    /* Initialize the RPC Memory */
    ULOG_ERR("SEQ1.Step1...");
    RPC_MemInit();
    ULOG_ERR("Done\n");

    /* Try to get the message with Stale Handle */
    ULOG_ERR("SEQ1.Step2...");
    inHdl = hdl;
    msg1 = RPC_MsgGet(inHdl);
    if(NULL == msg1) {
        ULOG_ERR("Done\n");
    } else {
        retVal = BCM_ERR_UNKNOWN;
        ULOG_ERR("Fail\n");
        goto done;
    }

    ULOG_ERR("SEQ1.Step3...");
    /* Allocate all the handles */
    for(i=0; i<(RPC_Memory.msgCnt+1UL); i++) {
        inHdl = RPC_HDL_INVALID;
    //RPC_INTERFACEID_0 : IPC Slave
    //RPC_INTERFACEID_2 : RPC Master
        if(i == (RPC_Memory.msgCnt/RPC_ASSOCIATIONINDEX_MAX)) {
            assocId = RPC_ASSOCIATIONINDEX_1;
        }
        retVal = RPC_MsgAlloc(inHdl, RPC_INTERFACEID_0, RPC_INTERFACEID_2,
                                      assocId, &outHdlPool[i]);
        if((RPC_Memory.msgCnt > i) && (BCM_ERR_OK != retVal)) {
            ULOG_ERR("Fail =%d i=%d\n",retVal,i);
            goto done;
        } else if((RPC_Memory.msgCnt <= i) && (BCM_ERR_NOMEM != retVal)) {
            ULOG_ERR("Fail =%d i=%d\n",retVal,i);
            goto done;
        } else {
            /* Do Nothing */
        }
    }
    ULOG_ERR("Done\n");

    ULOG_ERR("SEQ1.Step4...");
    /* Release all the handles */
    for(i=0; i<(RPC_Memory.msgCnt+1UL); i++) {
        retVal = RPC_Release(outHdlPool[i]);
        if((RPC_Memory.msgCnt > i) && (BCM_ERR_OK != retVal)) {
            ULOG_ERR("Fail =%d i=%d\n",retVal,i);
            goto done;
        } else if((RPC_Memory.msgCnt <= i) && (BCM_ERR_INVAL_PARAMS != retVal)) {
            ULOG_ERR("Fail =%d i=%d\n",retVal,i);
            goto done;
        } else {
            /* Do Nothing */
        }
    }
    ULOG_ERR("Done\n");

    /* Allocate a New Handle using RPC_HDL_INVALID */
    ULOG_ERR("SEQ1.Step5...");
    inHdl = RPC_HDL_INVALID;
    //RPC_INTERFACEID_0 : IPC Slave
    //RPC_INTERFACEID_2 : RPC Master
    retVal = RPC_MsgAlloc(inHdl, RPC_INTERFACEID_0, RPC_INTERFACEID_2,
                                  RPC_ASSOCIATIONINDEX_0, &outHdl);
    if(BCM_ERR_OK != retVal) {
        ULOG_ERR("Fail =%d\n",retVal);
        goto done;
    } else {
        ULOG_ERR("Done\n");
    }

    /* Get the Message using the valid handle */
    ULOG_ERR("SEQ1.Step6...");
    msg2 = RPC_MsgGet(outHdl);
    if(NULL == msg2) {
        ULOG_ERR("Fail\n");
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    } else {
        ULOG_ERR("Done\n");
    }

    /* Release the Handle */
    ULOG_ERR("SEQ1.Step7...");
    retVal = RPC_Release(outHdl);
    if(BCM_ERR_OK != retVal) {
        ULOG_ERR("Fail =%d\n",retVal);
        goto done;
    } else {
        ULOG_ERR("Done\n");
    }

    /* Try to get the message using the released handle */
    ULOG_ERR("SEQ1.Step8...");
    msg3 = RPC_MsgGet(outHdl);
    if(NULL == msg3) {
        ULOG_ERR("Done\n");
    } else {
        retVal = BCM_ERR_UNKNOWN;
        ULOG_ERR("Fail\n");
        goto done;
    }

    /* De-Initialize the RPC Memory */
    ULOG_ERR("SEQ1.Step9...");
    RPC_MemDeinit();
    ULOG_ERR("Done\n");

done:
    return retVal;
}

/************ SEQ1: RPC Stream Memory Test *************/
static int32_t RPC_TestSequence1(void)
{
    int32_t retVal;
    uint32_t i;
    uint32_t size = 0;
    uint32_t wrSize = 0;
    uint32_t rdSize = 0;
    uint32_t filledSize = 0;
    uint32_t totalWrSize = 0;
    uint32_t totalRdSize =0;

    RPC_HdlType outHdl;
    RPC_StrmCfgType inCfg;
    RPC_StrmCfgType outCfg;
    RPC_HdlType outHdlPool[RPC_MEM_STREAM_COUNT];


    /* set inCfg.xferSize to 2K */
    inCfg.pid = 0x5;
    inCfg.imgId = 0xBC10;
    inCfg.offset = 0xA;
    inCfg.isTbl = FALSE;
    inCfg.xferSize = RPC_MEM_STRM_XFERSIZE;
    inCfg.blkSize = 1024;
    inCfg.isRead = TRUE;

    BCM_MemSet(RPC_WrBuffer,0U,RPC_MEM_STRM_XFERSIZE);
    BCM_MemSet(RPC_RdBuffer,0U,RPC_MEM_STRM_XFERSIZE);

    /* Initialize the RPC Memory */
    ULOG_ERR("SEQ2..Step1...");
    RPC_MemInit();
    ULOG_ERR("Done\n");

    ULOG_ERR("SEQ2.Step2...");
    /* Allocate all the handles */
    for(i=0; i<(RPC_Memory.strmCnt+1UL); i++) {
    //RPC_INTERFACEID_0 : IPC Slave
    //RPC_INTERFACEID_2 : RPC Master
        retVal = RPC_StrmAlloc(&inCfg, RPC_INTERFACEID_0,
                                RPC_INTERFACEID_2, RPC_ASSOCIATIONINDEX_0,
                                &outHdlPool[i]);
        if((RPC_Memory.strmCnt > i) && (BCM_ERR_OK != retVal)) {
            ULOG_ERR("Fail =%d i=%d\n",retVal,i);
            goto done;
        } else if((RPC_Memory.strmCnt <= i) && (BCM_ERR_NOMEM != retVal)) {
            ULOG_ERR("Fail =%d i=%d\n",retVal,i);
            goto done;
        } else {
            /* Do Nothing */
        }
    }
    ULOG_ERR("Done\n");

    ULOG_ERR("SEQ2.Step3...");
    /* Release all the handles */
    for(i=0; i<(RPC_Memory.strmCnt+1UL); i++) {
        retVal = RPC_Release(outHdlPool[i]);
        if((RPC_Memory.strmCnt > i) && (BCM_ERR_OK != retVal)) {
            ULOG_ERR("Fail =%d i=%d\n",retVal,i);
            goto done;
        } else if((RPC_Memory.strmCnt <= i) && (BCM_ERR_INVAL_PARAMS != retVal)) {
            ULOG_ERR("Fail =%d i=%d\n",retVal,i);
            goto done;
        } else {
            /* Do Nothing */
        }
    }
    ULOG_ERR("Done\n");

    /* Initialize the RPC Memory */
    ULOG_ERR("SEQ2.Step4...");
    //RPC_INTERFACEID_0 : IPC Slave
    //RPC_INTERFACEID_2 : RPC Master
    retVal = RPC_StrmAlloc(&inCfg, RPC_INTERFACEID_0,
                            RPC_INTERFACEID_2, RPC_ASSOCIATIONINDEX_0,
                            &outHdl);
    if(BCM_ERR_OK != retVal) {
        ULOG_ERR("Fail\n");
        goto done;
    } else {
        ULOG_ERR("Done\n");
    }

    /* Retrieve the configuration from the allocated handle and validate */
    ULOG_ERR("SEQ2.Step5...");
    retVal = RPC_StrmGetCfg(outHdl, &outCfg);
    if(BCM_ERR_OK != retVal) {
        ULOG_ERR("Fail retVal = %d\n",retVal);
        goto done;
    } else {
        if(0L != memcmp(&inCfg, &outCfg, sizeof(RPC_StrmCfgType))) {
            ULOG_ERR("Fail\n");
            goto done;
        } else {
            ULOG_ERR("Done\n");
        }
    }

    /* Get the available size to write */
    ULOG_ERR("SEQ2.Step6...");
    retVal = RPC_StrmGetFreeSz(outHdl, &wrSize, &totalWrSize);
    if((BCM_ERR_OK != retVal)
         ||(RPC_Memory.strmSize != wrSize) ||(0UL != totalWrSize)) {
        ULOG_ERR("Fail retVal=%d, wrSize=%d, totalWrSize=%d\n",retVal,wrSize,totalWrSize);
    } else {
        ULOG_ERR("Done\n");
    }

    /* Get the available data to read */
    ULOG_ERR("SEQ2.Step7...");
    retVal = RPC_StrmGetFilledSz(outHdl, &rdSize, &totalRdSize);
    if((BCM_ERR_OK != retVal)
         ||(0UL != rdSize) ||(0UL != totalRdSize)) {
        ULOG_ERR("Fail retVal=%d, wrSize=%d, totalRdSize=%d\n",retVal,wrSize,totalRdSize);
    } else {
        ULOG_ERR("Done\n");
    }

    /* Prepare the buffer */
    for(i=0; i<RPC_MEM_STRM_XFERSIZE; i++) {
    RPC_WrBuffer[i] = (uint8_t)i;
    }

    /* Write 1024 Bytes of Data */
    size = 1024;
    ULOG_ERR("SEQ2.Step8...");
    (void)RPC_StrmGetFreeSz(outHdl, &wrSize, &totalWrSize);
    retVal = RPC_StrmWrite(outHdl, (RPC_WrBuffer+totalWrSize), size);
    if(BCM_ERR_NOMEM != retVal) {
        ULOG_ERR("Fail =%d\n",retVal);
        goto done;
    } else {
        ULOG_ERR("Done\n");
    }


    /* Write next 1024 Bytes of Data */
    ULOG_ERR("SEQ2.Step9...");
    (void)RPC_StrmGetFreeSz(outHdl, &wrSize, &totalWrSize);
    retVal = RPC_StrmWrite(outHdl, (RPC_WrBuffer+totalWrSize), size);
    if(BCM_ERR_NOMEM != retVal) {
        ULOG_ERR("Fail =%d\n",retVal);
        goto done;
    } else {
        ULOG_ERR("Done\n");
    }

    /* Try to write next data. Since buffer is full, it just return BCM_ERR_UNKNOWN */
    ULOG_ERR("SEQ2.Step10...");
    (void)RPC_StrmGetFreeSz(outHdl, &wrSize, &totalWrSize);
    retVal = RPC_StrmWrite(outHdl, (RPC_WrBuffer + totalWrSize), size);
    if(BCM_ERR_UNKNOWN != retVal) {
        ULOG_ERR("Fail =%d\n",retVal);
        goto done;
    } else {
        ULOG_ERR("Done\n");
    }


    /* Read 1024 bytes of the data */
    ULOG_ERR("SEQ2.Step11...");
    (void)RPC_StrmGetFilledSz(outHdl, &rdSize, &totalRdSize);
    retVal = RPC_StrmRead(outHdl, (RPC_RdBuffer + totalRdSize) , size, &filledSize);
    if(BCM_ERR_NOMEM != retVal) {
        ULOG_ERR("Fail =%d\n",retVal);
        goto done;
    } else {
        ULOG_ERR("Done\n");
    }


    /* Write next 1024 Bytes of Data. Since the data is read, it writes in circular */
    ULOG_ERR("SEQ2.Step12...");
    (void)RPC_StrmGetFreeSz(outHdl, &wrSize, &totalWrSize);
    retVal = RPC_StrmWrite(outHdl, (RPC_WrBuffer+totalWrSize), size);
    if(BCM_ERR_NOMEM != retVal) {
        ULOG_ERR("Fail =%d\n",retVal);
        goto done;
    } else {
        ULOG_ERR("Done\n");
    }


    /* Try to write next data. Since buffer is full, it just return BCM_ERR_UNKNOWN */
    ULOG_ERR("SEQ2.Step13...");
    (void)RPC_StrmGetFreeSz(outHdl, &wrSize, &totalWrSize);
    retVal = RPC_StrmWrite(outHdl, (RPC_WrBuffer+totalWrSize), size);
    if(BCM_ERR_UNKNOWN != retVal) {
        ULOG_ERR("Fail =%d\n",retVal);
        goto done;
    } else {
        ULOG_ERR("Done\n");
    }

    /* Read next 1024 bytes of the data */
    ULOG_ERR("SEQ2.Step14...");
    (void)RPC_StrmGetFilledSz(outHdl, &rdSize, &totalRdSize);
    retVal = RPC_StrmRead(outHdl, (RPC_RdBuffer + totalRdSize) , size, &filledSize);
    if(BCM_ERR_NOMEM != retVal) {
        ULOG_ERR("Fail =%d\n",retVal);
        goto done;
    } else {
        ULOG_ERR("Done\n");
    }


    /* Read next 1024 bytes of the data in circular*/
    ULOG_ERR("SEQ2.Step15...");
    (void)RPC_StrmGetFilledSz(outHdl, &rdSize, &totalRdSize);
    retVal = RPC_StrmRead(outHdl, (RPC_RdBuffer + totalRdSize) , size, &filledSize);
    if(BCM_ERR_NOMEM != retVal) {
        ULOG_ERR("Fail =%d\n",retVal);
        goto done;
    } else {
        ULOG_ERR("Done\n");
    }

    /* Write last 1024 Bytes of Data. Since the data is read, it writes in circular */
    ULOG_ERR("SEQ2.Step16...");
    (void)RPC_StrmGetFreeSz(outHdl, &wrSize, &totalWrSize);
    retVal = RPC_StrmWrite(outHdl, (RPC_WrBuffer+totalWrSize), size);
    if(BCM_ERR_OK != retVal) {
        ULOG_ERR("Fail =%d\n",retVal);
        goto done;
    } else {
        ULOG_ERR("Done\n");
    }


    /* Read last 1024 bytes of the data in circular*/
    ULOG_ERR("SEQ2.Step17...");
    (void)RPC_StrmGetFilledSz(outHdl, &rdSize, &totalRdSize);
    retVal = RPC_StrmRead(outHdl, (RPC_RdBuffer + totalRdSize) , size, &filledSize);
    if(BCM_ERR_OK != retVal) {
        ULOG_ERR("Fail =%d\n",retVal);
        goto done;
    } else {
        ULOG_ERR("Done\n");
    }

    /* Verify the total write size */
    ULOG_ERR("SEQ2.Step18...");
    retVal = RPC_StrmGetFreeSz(outHdl, &wrSize, &totalWrSize);
    if((BCM_ERR_OK != retVal)
         ||(RPC_Memory.strmSize != wrSize) ||(inCfg.xferSize != totalWrSize)) {
        ULOG_ERR("Fail retVal=%d, wrSize=%d, totalWrSize=%d\n",retVal,wrSize,totalWrSize);
    } else {
        ULOG_ERR("Done\n");
    }

    /* Verify the total read size */
    ULOG_ERR("SEQ2.Step19...");
    retVal = RPC_StrmGetFilledSz(outHdl, &rdSize, &totalRdSize);
    if((BCM_ERR_OK != retVal)
         ||(0UL != rdSize) ||(inCfg.xferSize != totalRdSize)
         || (inCfg.xferSize != totalRdSize)) {
        ULOG_ERR("Fail retVal=%d, wrSize=%d totalWrSize =%d",retVal,wrSize,totalWrSize);
        ULOG_ERR("rdSize =%d totalRdSize=%d\n",rdSize, totalRdSize);
    } else {
        ULOG_ERR("Done\n");
    }

    /* validate the data */
    if(0L != memcmp(RPC_WrBuffer,RPC_RdBuffer,RPC_MEM_STRM_XFERSIZE))
    {
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    }

    /* Rlease the Stream Handle */
    ULOG_ERR("SEQ2.Step20...");
    retVal = RPC_Release(outHdl);
    if(BCM_ERR_OK != retVal) {
        ULOG_ERR("Fail\n");
        goto done;
    } else {
        ULOG_ERR("Done\n");
    }

    /* De-Initiallize the Memory */
    ULOG_ERR("SEQ2.Step21...");
    RPC_MemDeinit();
    ULOG_ERR("Done\n");

done:
    return retVal;
}

/************ SEQ3: MessageQ Master Test *************/
void* RPC_TestCmdGetMessage(uint32_t idx)
{
    void* pRet = NULL;

    if (idx < RPC_CMD_MSGQ_TEST_COUNT) {

        pRet = (void *)(&ethsrvCmds[idx]);
    }
    return pRet;
}

static void RPC_MsgQPrepareTestCmd(void)
{
    uint32_t i;
    uint8_t   cmdID;
    uint8_t   groupID;
    uint16_t  compID;
    uint32_t sampleVal = 0x90;

    cmdID =0U;
    groupID =BCM_GROUPID_TEST;
    compID=BCM_SWT_ID;
    RPC_MsgQTestCmd.cmdId = BCM_CMDID(groupID, compID, cmdID);
    RPC_MsgQTestCmd.len = RPC_MEM_MSG_PAYLOAD_SZ;
    for (i = 0UL; i < RPC_MEM_MSG_PAYLOAD_SZ; i++) {
        RPC_MsgQTestCmd.cmdBuff[i] = sampleVal++;
    }
}

static int32_t RPC_TestSendCmd(uint8_t aCmdID, BCM_CompIDType aCompID,
                             const uint8_t *aCmd, uint32_t aLen,
                             const uint32_t aClientMask,
                             const MSGQ_MsgHdrType** const pHdr,
                             uint32_t *aForwardToSlaves)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;
    RPC_TestCmdRespType cmdEntry;

    if ((aCmd != NULL) && (pHdr != NULL) && (aForwardToSlaves != NULL)
        && (aClientMask != 0UL) && (RPC_MEM_MSG_PAYLOAD_SZ >= aLen)){
        switch(aCompID) {
            case BCM_SWT_ID:
                cmdEntry.compID = aCompID;
                cmdEntry.cmdID = aCmdID;
                cmdEntry.ret = BCM_ERR_UNKNOWN;
                cmdEntry.payloadLen = aLen;
                BCM_MemCpy(cmdEntry.payload, aCmd, aLen);
                retVal = MSGQ_SendMsg(&RPC_TestCmdQRPC, &cmdEntry, aClientMask, pHdr);
                break;
            default:
                retVal = BCM_ERR_NOSUPPORT;
                break;
        }
    }
    if ((BCM_ERR_OK != retVal) || (*pHdr == NULL)) {
        ULOG_ERR("%s line:%d\n", __func__, __LINE__);
    }

    return retVal;
}

static int32_t RPC_TestGetCmdStatus(const MSGQ_MsgHdrType* const pHdr,
                                  BCM_CompIDType aCompID, uint8_t* const aCmdID,
                                  uint8_t *aReply, uint32_t *aReplyLen)
{
    int32_t  retVal = BCM_ERR_OK;

    if ((pHdr != NULL) && (aReply != NULL) && (aReplyLen != NULL)) {
        switch(aCompID) {
            case BCM_SWT_ID:
            retVal = MSGQ_RecvMsg(&RPC_TestCmdQRPC, pHdr, &respEntry);
            if ((BCM_ERR_OK != retVal) && (BCM_ERR_BUSY != retVal)) {
                retVal = respEntry.ret;
                ULOG_ERR("%s retVal=%d line:%d\n", __func__, retVal, __LINE__);
            } else if (BCM_ERR_OK == retVal) {
                *aCmdID  = respEntry.cmdID;

                if(RPC_MEM_MSG_PAYLOAD_SZ >= respEntry.payloadLen){
                    /* Copy the response payload */
                    BCM_MemCpy(aReply, respEntry.payload, respEntry.payloadLen);
                    *aReplyLen = respEntry.payloadLen;
                } else {
                    /* Case when the response payload is incorrect */
                    respEntry.ret = BCM_ERR_INVAL_PARAMS;
                }

                /* Copy the response status */
                if (BCM_ERR_BUSY != respEntry.ret) {
                    retVal = respEntry.ret;
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

const RPC_MasterIfcType RPC_MsgQTestIfc = {
    .groupID = BCM_GROUPID_TEST,
    .sendCmd = RPC_TestSendCmd,
    .getStatus = RPC_TestGetCmdStatus,
};

static void RPC_MsgQCmpleteMsg(void)
{
    uint32_t cmdMsgIdx = 0UL;
    int32_t retVal;

    ULOG_ERR("%s line:%d\n", __func__, __LINE__);
    retVal = MSGQ_GetMsgIdx(&RPC_TestCmdQRPC, &cmdMsgIdx);
    if (BCM_ERR_OK == retVal) {
        (void)MSGQ_CompleteMsgIdx(&RPC_TestCmdQRPC, cmdMsgIdx);
    }
}


/************ SEQ4 & SEQ 5: RPC IPC Slave Module tests *************/

static uint32_t Host_IPCDrvCalChecksum(uint32_t aMagic, uint32_t aCmd, uint32_t *aMsg, uint32_t aLen)
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

static int32_t IPC_HostSend(IPC_ChannIDType aID, uint32_t aCmd, uint8_t *aMsg, uint32_t aLen)
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

    ret = IPC_PlatGetBuffInfo(aID, &ipcBufBase, &ipcMsgCnt, &cntRollOverMask, &ipcMsgSz);
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
        ipcBuf[IPC_HDR_MAGIC_INDEX] = IPC_CMDRESPMAGIC_CMD;
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

static int32_t IPC_HostRecv(IPC_ChannIDType aID, uint32_t *aCmd, uint8_t *aMsg, uint32_t aInLen, uint32_t *aOutLen)
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

    ret = IPC_PlatGetBuffInfo(aID, &ipcBufBase, &ipcMsgCnt, &cntRollOverMask, &ipcMsgSz);
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

        if (IPC_CMDRESPMAGIC_RESP != header[IPC_HDR_MAGIC_INDEX]) {
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
                /* Check for ACK response code of last packet */
                BCM_MemCpy(&ackRespCode, streamPacketBuf, 4UL);
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
        default:
            break;
    }

    return;
}

static int32_t RPC_TestSequence4(void)
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

    /* Initialize the RPC Memory */
    RPC_MemInit();

    /* COMMAND HANDLING CHECKS */
    retVal = RPC_IPCSlaveIfc.init();
    if (BCM_ERR_OK != retVal) {
        goto done;
    }

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
    //RPC_INTERFACEID_4 : RPC Slave
    //RPC_INTERFACEID_5 : UDP Master 0
    retVal = RPC_MsgAlloc(RPC_HDL_INVALID, RPC_INTERFACEID_4, RPC_INTERFACEID_5,
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

    RPC_IPCSlaveIfc.deinit();

    /* De-Initialize the RPC Memory */
    RPC_MemDeinit();

done:

    return retVal;
}

/******* SEQ5: IPC Slave Test ************/
static int32_t RPC_TestSequence5(void)
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
    RPC_StrmCfgType strmCfg;
    uint32_t outSize;
    uint32_t totalSize;

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
    //RPC_INTERFACEID_0 : IPC Slave
    //RPC_INTERFACEID_2 : RPC Master
    retVal = RPC_StrmAlloc(&strmCfg, RPC_INTERFACEID_0,
                            RPC_INTERFACEID_2, RPC_ASSOCIATIONINDEX_0,
                            &strmHdl);
    if(BCM_ERR_OK != retVal) {
        goto done;
    }

    /* Let the IPC Slave start stream processing - ASYNC request should go out */
    retVal = RPC_IPCSlaveIfc.processStrm(strmHdl);
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
        retVal = RPC_IPCSlaveIfc.processStrm(strmHdl);
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

    RPC_IPCSlaveIfc.deinit();

     /* De-Initialize the RPC Memory */
    RPC_MemDeinit();

done:

    return retVal;
}

/******* SEQ6: RPC Module Command Response************/
 int32_t RPC_TestSequence6(void)
{
    int32_t retVal;
    uint32_t state = 0UL;
    BCM_EventMaskType eventMask = 0UL;

    RPC_MemMsgType *outMsg = NULL;

    /* Initialize the RPC Memory */
    RPC_MemInit();

    retVal = RPC_Module.resetStateHandler(state);
    if (BCM_ERR_OK != retVal) {
        goto done;
    }

    /* CASE: Try to send more than max allowed the commands */
    /* Send a message to the IPC driver at target */
    SVC_RunTestSvc(RPC_TEST_SEND_UNKNOWN_CMD, NULL);
    (void)RPC_Module.eventHandler(eventMask);

    /* Send a message to the IPC driver at target */
    SVC_RunTestSvc(RPC_TEST_SEND_UNKNOWN_CMD, NULL);
    (void)RPC_Module.eventHandler(eventMask);

    /* Send a message to the IPC driver at target */
    SVC_RunTestSvc(RPC_TEST_SEND_UNKNOWN_CMD, NULL);
    (void)RPC_Module.eventHandler(eventMask);

    /* Send a message to the IPC driver at target */
    SVC_RunTestSvc(RPC_TEST_SEND_UNKNOWN_CMD, NULL);
    (void)RPC_Module.eventHandler(eventMask);

    /* Messages can not be allocated as the
       allowed messages per association is Empty
       This test Considering RPC_MEM_MSG_COUNT = 8UL */
    retVal = RPC_IPCSlaveIfc.recvMsg(&outHdl);
    if (BCM_ERR_NOT_FOUND != retVal) {
        goto done;
    }

    /* Reset the memory by De-Init and Init */
    /* De-Initialize the RPC Memory */
    RPC_MemDeinit();

    /* Initialize the RPC Memory */
    RPC_MemInit();

    /* Send a message to the IPC driver at target */
    SVC_RunTestSvc(RPC_TEST_SENDCMDMSG, NULL);
    (void)RPC_Module.eventHandler(eventMask);

    BCM_WaitEvent(RPC_MasterIfc.getEventMask());
    BCM_GetEvent(RPC_TestTask, &eventMask);
    BCM_ClearEvent(eventMask);

    RPC_MsgQCmpleteMsg();

    (void)RPC_Module.eventHandler(eventMask);

    /* Poll and verify response*/
    SVC_RunTestSvc(RPC_TEST_RECV_RESPONSE, (uint8_t*)outMsg);

    /* De-Init the all the available interfaces */
    RPC_MasterIfc.deinit();
    RPC_IPCSlaveIfc.deinit();

    /* De-Initialize the RPC Memory */
    RPC_MemDeinit();

    retVal = BCM_ERR_OK;
done:
    return retVal;
}

/******* SEQ7: RPC Module stream test ************/
static int32_t RPC_TestSequence7(void)
{
    int32_t retVal;
    uint32_t state = 0UL;
    uint32_t offset = 0UL;
    uint16_t imgID = 0UL;
    uint32_t bufSize = RPC_TEST_STREAM_MAX_SIZE;
    const MSGQ_MsgHdrType *hdr;
    BCM_EventMaskType eventMask = 0UL;

    RPC_MemInit();

    retVal = RPC_Module.resetStateHandler(state);
    if (BCM_ERR_OK != retVal) {
        goto done;
    }

    imgDataLenOffset = 0UL;

    BCM_MemSet(streamRdBuff,0U,RPC_MSGQ_MASTER_SREAM_MAX_SIZE);

    hdr = NULL;
    retVal = RPC_MasterImgHandler.readImg(IMGL_CHANNEL_IDX0, PTBL_ID_SYSCFG, imgID, 0UL, streamRdBuff,
                                          offset, bufSize, RPC_MSGQ_MASTER_LOADER_EVENT, &hdr);
    if (BCM_ERR_OK != retVal) {
        goto done;
    }

    BCM_WaitEvent(RPC_MSGQ_MASTER_LOADER_EVENT);
    BCM_GetEvent(RPC_TestTask, &eventMask);
    BCM_ClearEvent(eventMask);
    (void)RPC_Module.eventHandler(eventMask);
    SVC_RunTestSvc(RPC_TEST_RECV_ASYNC_REQ, NULL);
    (void)RPC_Module.eventHandler(eventMask);

    do {
        /* Check for IMG ACK and send new image data packet */
        SVC_RunTestSvc(RPC_TEST_SEND_STREAM_DATA, NULL);
        (void)RPC_Module.eventHandler(eventMask);
    } while(imgDataLenOffset <RPC_TEST_STREAM_MAX_SIZE);

    if (0L != memcmp(streamRdBuff, streamTestData, RPC_TEST_STREAM_MAX_SIZE)) {
        retVal = BCM_ERR_DATA_INTEG;
    } else {
        retVal = BCM_ERR_OK;
    }

    /* De-Init the all the available interfaces */
    RPC_MasterIfc.deinit();
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
    } else if(RPC_TEST5 == RPC_TestIndex) {
        retVal = RPC_TestSequence4();
    } else if(RPC_TEST6 == RPC_TestIndex) {
        retVal = RPC_TestSequence5();
    } else if(RPC_TEST7 == RPC_TestIndex) {
        retVal = RPC_TestSequence6();
    } else if(RPC_TEST8 == RPC_TestIndex) {
        retVal = RPC_TestSequence7();
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

void APP_Init(void)
{
    /* Dummy Init */
}
