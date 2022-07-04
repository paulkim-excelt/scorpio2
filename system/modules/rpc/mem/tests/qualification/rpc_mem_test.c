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

#define GetModuleLogLevel()         (ULOG_LVL_INFO)

/** Qualification Test Number Enumeration */
typedef uint32_t RPC_TestSeqNumType;
#define RPC_TEST1        (0x0001UL)         /**< Message Memory Test sequence */
#define RPC_TEST2        (0x0002UL)         /**< Stream Memory Test Sequence */
#define RPC_TEST_MAX     (RPC_TEST2)        /**< Test max value */

static uint32_t RPC_TestIndex;
static int32_t RPC_TestResult = BCM_AT_NOT_STARTED;

/************ SEQ 1 & 2 : RPC Message Memory Test *************/
#define RPC_MEM_STRM_XFERSIZE    (4096UL)    /**< Total Transfer size */
#define RPC_MSGQ_RAW_STRM_SIZE   (8192UL)
static uint8_t RPC_WrBuffer[RPC_MSGQ_RAW_STRM_SIZE];
static uint8_t RPC_RdBuffer[RPC_MSGQ_RAW_STRM_SIZE];

const RPC_InterfaceType RPC_IPCSlaveIfc = {
    .type          = RPC_IFC_CHAN_IPC,
    .mode          = RPC_IFC_CHAN_MODE_SLAVE,
    .assoc         = RPC_ASSOCIATIONINDEX_0,
};

const RPC_InterfaceType RPC_MasterIfc = {
    .type          = RPC_IFC_CHAN_MSGQ,
    .mode          = RPC_IFC_CHAN_MODE_MASTER,
    .assoc         = RPC_ASSOCIATIONINDEX_0,
};

const RPC_InterfaceType* const RPC_Interfaces[RPC_INTERFACEID_MAX] = {
    &RPC_IPCSlaveIfc,
    &RPC_MasterIfc,
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

/************ SEQ0: RPC Message Memory Test *************/
static int32_t RPC_TestSequence0(void)
{
    int32_t retVal;
    uint32_t i;
    uint32_t appInfo;

    RPC_HdlType hdl;
    RPC_HdlType inHdl;
    RPC_HdlType outHdl;
    RPC_HdlType outHdlPool[RPC_MEM_MSG_COUNT];
    RPC_HdlType validHdl = RPC_HDL_INVALID;
    RPC_MemMsgType *msg1;
    RPC_MemMsgType *msg2;
    RPC_MemMsgType *msg3;
    RPC_AssociationIndexType assocId = RPC_ASSOCIATIONINDEX_0;
    const RPC_InterfaceType * const *interfaces = RPC_GetModInterfaces();
    RPC_InterfaceIdType slaveIfcID;
    RPC_InterfaceIdType masterIfcID;

    /* Prepare the handle to validate the stale handle */
    hdl = (((RPC_INTERFACEID_0 << RPC_HDL_SLAVEID_SHIFT) & RPC_HDL_SLAVEID_MASK)
                | (( RPC_INTERFACEID_1<< RPC_HDL_MASTERID_SHIFT) & RPC_HDL_MASTERID_MASK)
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
        inHdl = validHdl;
        if(i == (RPC_Memory.msgCnt/RPC_ASSOCIATIONINDEX_MAX)) {
            assocId = RPC_ASSOCIATIONINDEX_1;
        }
        retVal = RPC_MsgAlloc(inHdl, RPC_INTERFACEID_0, RPC_INTERFACEID_1,
                                      assocId, &outHdlPool[i]);
        if((RPC_Memory.msgCnt > i) && (BCM_ERR_OK != retVal)) {
            ULOG_ERR("Fail =%d i=%d\n",retVal,i);
            goto done;
        } else if((RPC_Memory.msgCnt <= i) && (BCM_ERR_NOMEM != retVal)) {
            ULOG_ERR("Fail =%d i=%d\n",retVal,i);
            goto done;
        } else {
            /* Store handle to veridy message cloning during next allocation */
            validHdl = outHdlPool[i];
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
    retVal = RPC_MsgAlloc(inHdl, RPC_INTERFACEID_0, RPC_INTERFACEID_1,
                                  RPC_ASSOCIATIONINDEX_0, &outHdl);
    if(BCM_ERR_OK != retVal) {
        ULOG_ERR("Fail =%d\n",retVal);
        goto done;
    } else {
        ULOG_ERR("Done\n");
    }

    /* Check the handle query interfaces */
    if (RPC_HDL_TYPE_MSG != RPC_MemGetType(outHdl)) {
        retVal = BCM_ERR_INVAL_PARAMS;
        ULOG_ERR("Fail =%d\n",retVal);
        goto done;
    }

    if (RPC_MEM_MSG_COUNT < RPC_MemGetIndex(outHdl)) {
        retVal = BCM_ERR_INVAL_PARAMS;
        ULOG_ERR("Fail =%d\n",retVal);
        goto done;
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

    RPC_MsgInit(msg2);

    /* Acquire same handle and release */
    retVal = RPC_Acquire(outHdl);
    if(BCM_ERR_OK != retVal) {
        ULOG_ERR("Fail =%d\n",retVal);
        goto done;
    }
    retVal = RPC_Release(outHdl);
    if(BCM_ERR_OK != retVal) {
        ULOG_ERR("Fail =%d\n",retVal);
        goto done;
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

    /* Check for scratch memory allocation */
    msg3 = RPC_MsgScratch();
    if(NULL == msg3) {
        retVal = BCM_ERR_UNKNOWN;
        ULOG_ERR("Fail\n");
        goto done;
    } else {
        ULOG_ERR("Done\n");
    }

    /* Allocate a New Handle using NULL argument for outHdl */
    inHdl = RPC_HDL_INVALID;
    retVal = RPC_MsgAlloc(inHdl, RPC_INTERFACEID_0, RPC_INTERFACEID_1,
                                  RPC_ASSOCIATIONINDEX_0, NULL);
    if(BCM_ERR_INVAL_PARAMS != retVal) {
        ULOG_ERR("Fail =%d\n",retVal);
        goto done;
    } else {
        ULOG_ERR("Done\n");
    }

    /* Force validation failure for invalid input handle */
    inHdl = hdl;
    retVal = RPC_MsgAlloc(inHdl, RPC_INTERFACEID_0, RPC_INTERFACEID_1,
                          RPC_ASSOCIATIONINDEX_0, &outHdl);
    if(BCM_ERR_INVAL_PARAMS != retVal) {
        ULOG_ERR("Fail =%d\n",retVal);
        goto done;
    } else {
        ULOG_ERR("Done\n");
    }

    /* Tests for appInfo push/peek/pop */
    inHdl = RPC_HDL_INVALID;
    retVal = RPC_MsgAlloc(inHdl, RPC_INTERFACEID_0, RPC_INTERFACEID_1,
                          RPC_ASSOCIATIONINDEX_0, &outHdl);
    if(BCM_ERR_OK != retVal) {
        ULOG_ERR("Fail =%d\n",retVal);
        goto done;
    } else {
        ULOG_ERR("Done\n");
    }

    msg2 = RPC_MsgGet(outHdl);
    if(NULL == msg2) {
        ULOG_ERR("Fail\n");
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    }

    /* Peek before pushing any appInfo and make sure it returns error */
    retVal = RPC_MemPeekAppInfo(msg2, &appInfo);
    if (BCM_ERR_NOMEM != retVal) {
        ULOG_ERR("Fail =%d\n",retVal);
        goto done;
    }

    /* Push max entries and peek on them */
    for (i = 0UL; i <= RPC_MEM_MAX_CNT_APPINFO; i++) {
        retVal = RPC_MemPushAppInfo(outHdl, i);
        if ((BCM_ERR_OK != retVal) && (RPC_MEM_MAX_CNT_APPINFO > i)) {
            ULOG_ERR("Fail =%d\n",retVal);
            goto done;
        }

        retVal = RPC_MemPeekAppInfo(msg2, &appInfo);
        if ((BCM_ERR_OK != retVal) && (RPC_MEM_MAX_CNT_APPINFO > i)) {
            ULOG_ERR("Fail =%d\n",retVal);
            goto done;
        }
    }

    /* Pop all entries */
    for (i = 0UL; i < RPC_MEM_MAX_CNT_APPINFO; i++) {
        retVal = RPC_MemPopAppInfo(outHdl, &appInfo);
        if (BCM_ERR_OK != retVal) {
            ULOG_ERR("Fail =%d\n",retVal);
            goto done;
        }
    }

    /* Push entries using the #RPC_MsgPushAppInfo */
    for (i = 0UL; i <= RPC_MEM_MAX_CNT_APPINFO; i++) {
        retVal = RPC_MsgPushAppInfo(msg2, i);
        if (BCM_ERR_OK != retVal) {
            ULOG_ERR("Fail =%d\n",retVal);
            goto done;
        }
    }

    /* Push entries using the #RPC_MsgPopAppInfo */
    for (i = 0UL; i < RPC_MEM_MAX_CNT_APPINFO; i++) {
        retVal = RPC_MsgPopAppInfo(msg2, &appInfo);
        if (BCM_ERR_OK != retVal) {
            ULOG_ERR("Fail =%d\n",retVal);
            goto done;
        }
    }

    retVal = RPC_Release(outHdl);
    if(BCM_ERR_OK != retVal) {
        ULOG_ERR("Fail =%d\n",retVal);
        goto done;
    } else {
        ULOG_ERR("Done\n");
    }

    /* De-Initialize the RPC Memory */
    ULOG_ERR("SEQ1.Step9...");
    RPC_MemDeinit();
    ULOG_ERR("Done\n");

    /* RPC interface list test */
    retVal = RPC_GetModIfcAndAssoc(interfaces[0], &slaveIfcID, &masterIfcID, &assocId);
    if (BCM_ERR_OK != retVal) {
        ULOG_ERR("Fail =%d\n",retVal);
        goto done;
    }

    if (slaveIfcID != RPC_GetSlaveIfcIdx(assocId, IMGL_CHANNEL_ID_RPC_IPC)) {
        retVal = BCM_ERR_UNKNOWN;
        ULOG_ERR("Fail =%d\n",retVal);
        goto done;
    }
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
    RPC_MemStrmClientInfoType *clientInfo;
    BCM_SubStateType slaveState = 0UL, masterState = 0UL;


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
        retVal = RPC_StrmAlloc(&inCfg, RPC_INTERFACEID_0,
                                RPC_INTERFACEID_1, RPC_ASSOCIATIONINDEX_0,
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

    /* Pass NULL outHdl */
    retVal = RPC_StrmAlloc(&inCfg, RPC_INTERFACEID_0,
                           RPC_INTERFACEID_1, RPC_ASSOCIATIONINDEX_0,
                           NULL);
    if(BCM_ERR_INVAL_PARAMS != retVal) {
        ULOG_ERR("Fail\n");
        goto done;
    }

    /* Initialize the RPC Memory */
    ULOG_ERR("SEQ2.Step4...");
    retVal = RPC_StrmAlloc(&inCfg, RPC_INTERFACEID_0,
                            RPC_INTERFACEID_1, RPC_ASSOCIATIONINDEX_0,
                            &outHdl);
    if(BCM_ERR_OK != retVal) {
        ULOG_ERR("Fail\n");
        goto done;
    } else {
        ULOG_ERR("Done\n");
    }

    /* Pass NULL config argument */
    retVal = RPC_StrmGetCfg(outHdl, NULL);
    if(BCM_ERR_INVAL_PARAMS != retVal) {
        ULOG_ERR("Fail\n");
        goto done;
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
    RPC_StrmPeek(outHdl, (RPC_RdBuffer + totalRdSize) , size, &filledSize);
    if(BCM_ERR_OK != retVal) {
        ULOG_ERR("Fail =%d\n",retVal);
        goto done;
    }

    retVal = RPC_StrmRead(outHdl, (RPC_RdBuffer + totalRdSize) , size, &filledSize);
    if(BCM_ERR_OK != retVal) {
        ULOG_ERR("Fail =%d\n",retVal);
        goto done;
    } else {
        ULOG_ERR("Done\n");
    }

    /* Verify the total write size */
    ULOG_ERR("SEQ2.Step18...");
    /* Check with NULL arguments */
    retVal = RPC_StrmGetFreeSz(outHdl, &wrSize, NULL);
    if(BCM_ERR_INVAL_PARAMS != retVal) {
        ULOG_ERR("Fail\n");
        goto done;
    }

    retVal = RPC_StrmGetFreeSz(outHdl, &wrSize, &totalWrSize);
    if((BCM_ERR_OK != retVal)
         ||(RPC_Memory.strmSize != wrSize) ||(inCfg.xferSize != totalWrSize)) {
        ULOG_ERR("Fail retVal=%d, wrSize=%d, totalWrSize=%d\n",retVal,wrSize,totalWrSize);
    } else {
        ULOG_ERR("Done\n");
    }

    /* Verify the total read size */
    ULOG_ERR("SEQ2.Step19...");
    /* Check with NULL arguments */
    retVal = RPC_StrmGetFilledSz(outHdl, &rdSize, NULL);
    if(BCM_ERR_INVAL_PARAMS != retVal) {
        ULOG_ERR("Fail\n");
        goto done;
    }

    retVal = RPC_StrmGetFilledSz(outHdl, &rdSize, &totalRdSize);
    if((BCM_ERR_OK != retVal)
         ||(0UL != rdSize) ||(inCfg.xferSize != totalRdSize)
         || (inCfg.xferSize != totalRdSize)) {
        ULOG_ERR("Fail retVal=%d, wrSize=%d totalWrSize =%d",retVal,wrSize,totalWrSize);
        ULOG_ERR("rdSize =%d totalRdSize=%d\n",rdSize, totalRdSize);
    } else {
        ULOG_ERR("Done\n");
    }

    retVal = RPC_StrmSetXferSize(outHdl, RPC_MEM_STRM_XFERSIZE);
    if(BCM_ERR_OK != retVal) {
        ULOG_ERR("Fail\n");
        goto done;
    } else {
        ULOG_ERR("Done\n");
    }

    /* Check by fetching the client information */
    clientInfo = RPC_StrmGetSlaveClientInfo(outHdl);
    if ((BCM_ERR_OK != retVal) || (NULL == clientInfo)) {
        ULOG_ERR("Fail\n");
        goto done;
    }

    clientInfo = RPC_StrmGetMasterClientInfo(outHdl);
    if ((BCM_ERR_OK != retVal) || (NULL == clientInfo)) {
        ULOG_ERR("Fail\n");
        goto done;
    }

    /* Test the stream status, positive and negative tests */
    retVal = RPC_GetStreamStatus(outHdl, &slaveState, &masterState);
    if(BCM_ERR_OK != retVal) {
        ULOG_ERR("Fail\n");
        goto done;
    }

    retVal = RPC_GetStreamStatus(0UL, &slaveState, &masterState);
    if(BCM_ERR_INVAL_PARAMS != retVal) {
        ULOG_ERR("Fail\n");
        goto done;
    }

    retVal = RPC_GetStreamStatus(outHdl, NULL, &masterState);
    if(BCM_ERR_INVAL_PARAMS != retVal) {
        ULOG_ERR("Fail\n");
        goto done;
    }

    retVal = RPC_GetStreamStatus(outHdl, &slaveState, NULL);
    if(BCM_ERR_INVAL_PARAMS != retVal) {
        ULOG_ERR("Fail\n");
        goto done;
    }

    /* validate the data */
    if(0L != memcmp(RPC_WrBuffer,RPC_RdBuffer,RPC_MEM_STRM_XFERSIZE))
    {
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    }

    /* Acquire same handle and release */
    retVal = RPC_Acquire(outHdl);
    if(BCM_ERR_OK != retVal) {
        ULOG_ERR("Fail =%d\n",retVal);
        goto done;
    }
    retVal = RPC_Release(outHdl);
    if(BCM_ERR_OK != retVal) {
        ULOG_ERR("Fail =%d\n",retVal);
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
