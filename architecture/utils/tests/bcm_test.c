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

 2. TO THE MAXIMUM EXTENT PERMITTED BY LAW, THE SOFTWARE IS PROVIdED "AS IS"
    AND WITH ALL FAULTS AND BROADCOM MAKES NO PROMISES, REPRESENTATIONS OR
    WARRANTIES, EITHER EXPRESS, IMPLIED, STATUTORY, OR OTHERWISE, WITH RESPECT
    TO THE SOFTWARE.  BROADCOM SPECIFICALLY DISCLAIMS ANY AND ALL IMPLIED
    WARRANTIES OF TITLE, MERCHANTABILITY, NONINFRINGEMENT, FITNESS FOR A
    PARTICULAR PURPOSE, LACK OF VIRUSES, ACCURACY OR COMPLETENESS,
    QUIET ENJOYMENT, QUIET POSSESSION OR CORRESPONDENCE TO DESCRIPTION.
    YOU ASSUME THE ENTIRE RISK ARISING OUT OF USE OR PERFORMANCE OF THE
    SOFTWARE.

 3. TO THE MAXIMUM EXTENT PERMITTED BY LAW, IN NO EVENT SHALL BROADCOM OR ITS
    LICENSORS BE LIABLE FOR (i) CONSEQUENTIAL, INCIdENTAL, SPECIAL, INDIRECT,
    OR EXEMPLARY DAMAGES WHATSOEVER ARISING OUT OF OR IN ANY WAY RELATING TO
    YOUR USE OF OR INABILITY TO USE THE SOFTWARE EVEN IF BROADCOM HAS BEEN
    ADVISED OF THE POSSIBILITY OF SUCH DAMAGES; OR (ii) ANY AMOUNT IN EXCESS
    OF THE AMOUNT ACTUALLY PAId FOR THE SOFTWARE ITSELF OR U.S. $1, WHICHEVER
    IS GREATER. THESE LIMITATIONS SHALL APPLY NOTWITHSTANDING ANY FAILURE OF
    ESSENTIAL PURPOSE OF ANY LIMITED REMEDY.
******************************************************************************/

/**
    @defgroup grp_utils_bcm_test_impl BCM Test Implementation
    @ingroup grp_utils

    @addtogroup grp_utils_bcm_test_impl
    @{

    @file bcm_test.c
    @brief BCM Test Implementation

    @version 0.1 Initial version
*/

#include <bcm_utils.h>
#include <bcm_test.h>
#include "ee.h"
#ifdef BCM_TEST_CONFIG_LOADER
#include <module.h>
#include <module_osil.h>
#endif

/**
    @name BCM Test Design Ids
    @{
    @brief Design Ids for BCM Test APIs
*/
#define BRCM_SWDSGN_BCM_TEST_START_PROC               (0xA101U)    /**< @brief #BCM_TestStart           */
#define BRCM_SWDSGN_BCM_SET_TEST_CASE_PROC            (0xA102U)    /**< @brief #BCM_SetTestCase         */
#define BRCM_SWDSGN_BCM_SET_TEST_SEQ_PROC             (0xA103U)    /**< @brief #BCM_SetTestSeq          */
#define BRCM_SWDSGN_BCM_SET_TEST_PROBE_STATUS_PROC    (0xA104U)    /**< @brief #BCM_SetTestProbeStatus  */
#define BRCM_SWDSGN_BCM_GET_TEST_PROBE_STATUS_PROC    (0xA105U)    /**< @brief #BCM_GetTestProbeStatus  */
#define BRCM_SWDSGN_BCM_SET_TEST_RESULT_PROC          (0xA106U)    /**< @brief #BCM_SetTestResult       */
#define BRCM_SWDSGN_BCM_GET_TEST_CASE_PROC            (0xA107U)    /**< @brief #BCM_GetTestCase         */
#define BRCM_SWDSGN_BCM_GET_TEST_SEQ_PROC             (0xA108U)    /**< @brief #BCM_GetTestSeq          */
#define BRCM_SWDSGN_BCM_IS_PORBE_PROC                 (0xA109U)    /**< @brief #BCM_IsProbeTestCase     */
#define BRCM_SWDSGN_BCM_TEST_STOP_PROC                (0xA10AU)    /**< @brief #BCM_TestStop            */
#define BRCM_SWDSGN_BCM_TEST_INFO_GLOBAL              (0xA10BU)    /**< @brief #BCM_TestCmdQInfo        */
#define BRCM_SWDSGN_BCM_TEST_STATUS_TYPE              (0xA10CU)    /**< @brief #BCM_TestStatusType      */
#define BRCM_SWDSGN_BCM_TEST_STATE_TYPE               (0xA10DU)    /**< @brief #BCM_TestStateType       */
#define BRCM_SWDSGN_BCM_TEST_STATUS_GLOBAL            (0xA10EU)    /**< @brief #BCM_TestStatus          */
#define BRCM_SWDSGN_BCM_TEST_SEND_MSG_PROC            (0xA10FU)    /**< @brief #BCM_TestSendMsg         */
#define BRCM_SWDSGN_BCM_TEST_RECVMSG_PROC             (0xA110U)    /**< @brief #BCM_TestRecvMsg         */
#define BRCM_SWDSGN_BCM_SET_RDY_TEST_PROC             (0xA111U)    /**< @brief #BCM_SetReadyForTest     */
#define BRCM_SWDSGN_BCM_TEST_MSG_HANDLER_PROC         (0xA112U)    /**< @brief #BCM_TestMsgHandler      */
#define BRCM_SWDSGN_BCM_TEST_ASYNCQ_HANDLER_PROC      (0xA113U)    /**< @brief #BCM_TestStreamQHandler  */
/** @} */

static BCM_TestMsgType COMP_SECTION(".testq.data") BCM_TestCmdQ_HBuf[1 << BCM_TESTQ_CMDQ_FIFO_LOG2_LEN];
static BCM_TestMsgType COMP_SECTION(".testq.data") BCM_TestCmdQ_TBuf[1 << BCM_TESTQ_CMDQ_FIFO_LOG2_LEN];

static BCM_TestMsgType COMP_SECTION(".testq.data") BCM_TestSQ_HBuf[1 << BCM_TESTQ_STREAMQ_FIFO_LOG2_LEN];
static BCM_TestMsgType COMP_SECTION(".testq.data") BCM_TestSQ_TBuf[1 << BCM_TESTQ_STREAMQ_FIFO_LOG2_LEN];

static BCM_TestMsgType COMP_SECTION(".testq.data") BCM_TestRQ_TBuf[1 << BCM_TESTQ_RESULTQ_FIFO_LOG2_LEN];

BCM_TESTQ_DEFINE_V0(BCM_TestRefCmdQ, BCM_TEST_VER_MAJOR_V0, BCM_TEST_VER_MINOR_V1, BCM_TESTQ_CMDQ_FIFO_LOG2_LEN,
         6, 0xFU, (uint8_t *)BCM_TestCmdQ_HBuf, (uint8_t *)BCM_TestCmdQ_TBuf);

BCM_TESTQ_DEFINE_V0(BCM_TestRefStreamQ, BCM_TEST_VER_MAJOR_V0, BCM_TEST_VER_MINOR_V1, BCM_TESTQ_STREAMQ_FIFO_LOG2_LEN,\
         6, 0xFU, (uint8_t *)BCM_TestSQ_HBuf, (uint8_t *)BCM_TestSQ_TBuf);

BCM_TESTQ_DEFINE_V0(BCM_TestRefResultQ, BCM_TEST_VER_MAJOR_V0, BCM_TEST_VER_MINOR_V1, BCM_TESTQ_RESULTQ_FIFO_LOG2_LEN,\
         6, 0x1FU, NULL, (uint8_t *)BCM_TestRQ_TBuf);

/* Reference queues in read only memory. Values is copied to real queues */
static const BCM_TestQType *const BCM_TestRefQs[BCM_TEST_Q_ID_MAX + 1] = {
    [BCM_TEST_Q_CMD_ID] = &BCM_TestRefCmdQ,
    [BCM_TEST_Q_STREAM_ID] = &BCM_TestRefStreamQ,
    [BCM_TEST_Q_RESULT_ID] = &BCM_TestRefResultQ,
};

/* Real test queues */
BCM_TestQType COMP_SECTION(".testq.data") BCM_TestCmdQ;
BCM_TestQType COMP_SECTION(".testq.data") BCM_TestStreamQ;
BCM_TestQType COMP_SECTION(".testq.data") BCM_TestResultQ;

static BCM_TestQType *const BCM_TestQs[BCM_TEST_Q_ID_MAX + 1] = {
    [BCM_TEST_Q_CMD_ID] = &BCM_TestCmdQ,
    [BCM_TEST_Q_STREAM_ID] = &BCM_TestStreamQ,
    [BCM_TEST_Q_RESULT_ID] = &BCM_TestResultQ,
};

/**
    @name BCM Test State
    @{
    @brief Test state running ot idle.

    @trace #BRCM_SWARCH_BCM_TESTMSGHANDLER_PROC
    @trace #BRCM_SWREQ_BCM_TEST
*/
typedef uint32_t BCM_TestStateType;          /**< @brief Test Probe status typedef   */
#define BCM_TEST_STATE_IDLE        (0x0UL)   /**< @brief Probe is enabled            */
#define BCM_TEST_STATE_RUNNING     (0x1UL)   /**< @brief Probe is disabled           */
/** @} */

/**
    @name BCM Test internal state data

    @brief BCM Test global data type to store various states.

    @trace #BRCM_SWARCH_BCM_TESTMSGHANDLER_PROC
    @trace #BRCM_SWREQ_BCM_TEST
*/
typedef struct sBCM_TestStatusType {
    BCM_TestProbeStatusType prbState;
    BCM_TestCaseIdType      currCase;
    BCM_TestStateType       runState;
    BCM_TestSeqIdType       currSeq;
    uint32_t                failedCnt;
    uint32_t                passedCnt;
    BCM_CompIDType          compId;
    uint32_t                ready;
} BCM_TestStatusType;

/**
    @name BCM Test internal state data

    @brief BCM Test global data to store varius status.

    @trace #BRCM_SWARCH_BCM_TESTMSGHANDLER_PROC
    @trace #BRCM_SWREQ_BCM_TEST
*/
static BCM_TestStatusType BCM_TestStatus;

/**
    @trace #BRCM_SWDSGN_BCM_TEST_RECVMSG_PROC
    @trace #BRCM_SWREQ_BCM_TEST

    @code{.c}
    @endcode
*/
static int32_t BCM_TestRecvMsg(BCM_TestQIDType aID, BCM_MsgType *aMsgID, uint8_t *aMsg, uint32_t aInLen, uint32_t *aOutLen)
{
    BCM_TestQType *queue = NULL;
    int32_t ret = BCM_ERR_NOMEM;
    BCM_TestMsgHdrType *hdr;
    uint8_t *payload;
    uint32_t tRdIdx;
    uint32_t msgSz;

    if (aID <= BCM_TEST_Q_ID_MAX) {
        queue = BCM_TestQs[aID];
        msgSz = 1UL << queue->msgSzLog2;

        if (BCM_TESTQ_ISNEWMSG(queue)) {
            tRdIdx = queue->tRdIdx & ((1UL << queue->fifoLenLog2) - 1UL);
            /* coverity[misra_c_2012_rule_11_3_violation] pointer type mismatch */
            hdr = (void *) &queue->h2tBuf[tRdIdx * msgSz];
            if (BCM_TEST_MSG_MAGIC == hdr->magic) {
                if (aInLen >= hdr->len) {
                    *aMsgID = hdr->msgId;
                    payload = (uint8_t *)hdr + sizeof(BCM_TestMsgHdrType);
                    BCM_MemCpy(aMsg, payload, hdr->len);
                    *aOutLen = hdr->len;
                    BCM_TESTQ_INCRIDX(queue, tRdIdx);
                    ret = BCM_ERR_OK;
                } else {
                    ret = BCM_ERR_INVAL_PARAMS;
                }
            } else {
                ret = BCM_ERR_INVAL_MAGIC;
            }
        }
    }
    return ret;
}

/**
    @trace #BRCM_SWDSGN_BCM_TEST_SEND_MSG_PROC
    @trace #BRCM_SWREQ_BCM_TEST

    @code{.c}
    @endcode
*/

static void BCM_TestSendMsg(BCM_TestQIDType aID, BCM_MsgType aMsgID, const uint8_t *const aMsg, uint32_t aLen)
{
    BCM_TestQType *queue = NULL;
    BCM_TestMsgHdrType *hdr;
    uint8_t *payload;
    uint32_t tWrIdx;
    uint32_t msgSz;

    if (aID <= BCM_TEST_Q_ID_MAX) {
        queue = BCM_TestQs[aID];
        msgSz = 1UL << queue->msgSzLog2;

        tWrIdx = queue->tWrIdx & ((1UL << queue->fifoLenLog2) - 1UL);

        if (BCM_TESTQ_NOTFULL(queue) && (aLen <= (1UL << queue->msgSzLog2))) {
            /* coverity[misra_c_2012_rule_11_3_violation] pointer type mismatch */
            hdr = (void *) &queue->t2hBuf[tWrIdx * msgSz];
            hdr->magic = BCM_TEST_MSG_MAGIC;
            hdr->msgId = aMsgID;
            payload = (uint8_t *)hdr + sizeof(BCM_TestMsgHdrType);
            BCM_MemCpy(payload, aMsg, aLen);
            hdr->len = aLen;
            BCM_TESTQ_INCRIDX(queue, tWrIdx);
        } else {
            queue->t2hDropCnt++;
        }
    }
}


/**
    @trace #BRCM_SWARCH_BCM_TESTSTART_PROC
    @trace #BRCM_SWREQ_BCM_TEST

    @code{.c}

    BCM_TestStatus.compId = aCompId
    BCM_TestStatus.failedCnt = 0UL
    BCM_TestStatus.passedCnt = 0UL
    if coverage enabled
        BCM_TestStatus.prbState = BCM_TEST_PROBE_STATUS_EN;
    else
        BCM_TestStatus.prbState = BCM_TEST_PROBE_STATUS_DIS;

    @endcode
*/
extern void BCM_TestStart(BCM_CompIDType aCompId)
{
    BCM_TestStatus.compId    = aCompId;
    BCM_TestStatus.failedCnt = 0UL;
    BCM_TestStatus.passedCnt = 0UL;

#ifdef BCM_ENABLE_COVERAGE
    BCM_TestStatus.prbState = BCM_TEST_PROBE_STATUS_EN;
#else
    BCM_TestStatus.prbState = BCM_TEST_PROBE_STATUS_DIS;
#endif
}

/**
    @trace #BRCM_SWARCH_BCM_SETTESTCASE_PROC
    @trace #BRCM_SWREQ_BCM_TEST

    @code{.c}

    BCM_TestStatus.currCase = aTestCaseId

    @endcode
*/
void BCM_SetTestCase(BCM_TestCaseIdType aTestCaseId)
{
    BCM_TestStatus.currCase = aTestCaseId;
}

/**
    @trace #BRCM_SWARCH_BCM_GETTESTCASE_PROC
    @trace #BRCM_SWREQ_BCM_TEST

    @code{.c}

    return BCM_TestStatus.currCase

    @endcode
*/
BCM_TestCaseIdType BCM_GetTestCase(void)
{
    return BCM_TestStatus.currCase;
}

/**
    @trace #BRCM_SWARCH_BCM_SETTESTSEQ_PROC
    @trace #BRCM_SWREQ_BCM_TEST

    @code{.c}

    BCM_TestStatus.currSeq = aTestSeqId

    @endcode
*/
void BCM_SetTestSeq(BCM_TestSeqIdType aTestSeqId)
{
    BCM_TestStatus.currSeq = aTestSeqId;
}

/**
    @trace #BRCM_SWARCH_BCM_GETTESTSEQ_PROC
    @trace #BRCM_SWREQ_BCM_TEST

    @code{.c}

    return BCM_TestStatus.currSeq

    @endcode
*/
BCM_TestSeqIdType BCM_GetTestSeq(void)
{
    return BCM_TestStatus.currSeq;
}

/**
    @trace #BRCM_SWARCH_BCM_GETTESTSEQ_PROC
    @trace #BRCM_SWREQ_BCM_TEST

    @code{.c}

    return BCM_TEST_PROBE_STATUS_EN == BCM_TestStatus.prbState
            and aCompId == BCM_TestStatus.compId
            and aSeqId == BCM_TestStatus.currSeq
            and aCaseId == BCM_TestStatus.currCase

    @endcode
*/
uint32_t BCM_IsProbeTestCase(BCM_CompIDType aCompId,
                                 BCM_TestSeqIdType aSeqId,
                                 BCM_TestCaseIdType aCaseId)
{
    return (uint32_t)(((BCM_TEST_PROBE_STATUS_EN) == BCM_TestStatus.prbState)
            && (aCompId == BCM_TestStatus.compId)
            && (aSeqId == BCM_TestStatus.currSeq)
            && (aCaseId == BCM_TestStatus.currCase));
}

/**
    @trace #BRCM_SWARCH_BCM_SETTESTPROBESTATUS_PROC
    @trace #BRCM_SWREQ_BCM_TEST

    @code{.c}

    BCM_TestStatus.prbState = aProbeStatus

    @endcode
*/
void BCM_SetTestProbeStatus(BCM_TestProbeStatusType aProbeStatus)
{
    BCM_TestStatus.prbState = aProbeStatus;
}

/**
    @trace #BRCM_SWARCH_BCM_GETTESTPROBESTATUS_PROC
    @trace #BRCM_SWREQ_BCM_TEST

    @code{.c}

    return BCM_TestStatus.prbState

    @endcode
*/
BCM_TestProbeStatusType BCM_GetTestProbeStatus(void)
{
    return BCM_TestStatus.prbState;
}

/**
    @trace #BRCM_SWARCH_BCM_SETTESTRESULT_PROC
    @trace #BRCM_SWREQ_BCM_TEST

    @code{.c}

    BCM_TestResultDataType resultData
    resultData.caseId = BCM_TestStatus.currCase
    resultData.result = aResult

    if (BCM_ERR_OK != aResult)
        BCM_TestStatus.failedCnt++
    else
        BCM_TestStatus.passedCnt++

    Post result in result Q
    BCM_TestSendMsg(resultData)

    @endcode
*/
void BCM_SetTestResult(int32_t aResult)
{
    BCM_TestResultDataType resultData;

    resultData.caseId = BCM_TestStatus.currCase;
    resultData.result = aResult;

    if (BCM_ERR_OK != aResult) {
        BCM_TestStatus.failedCnt++;
    } else {
        BCM_TestStatus.passedCnt++;
    }
    BCM_TestSendMsg(BCM_TEST_Q_RESULT_ID, 0UL, (uint8_t *)&resultData, sizeof(resultData));
}

/**
    @trace #BRCM_SWARCH_BCM_TESTSTOP_PROC
    @trace #BRCM_SWREQ_BCM_TEST

    @code{.c}

    @endcode
*/
void BCM_TestStop(void)
{

}


/**
    @trace #BRCM_SWDSGN_BCM_SET_RDY_TEST_PROC
    @trace #BRCM_SWREQ_BCM_TEST

    @code{.c}
    @endcode
*/
void BCM_SetReadyForTest(void)
{
    extern uint8_t __test_q_start__[];
    extern uint8_t __test_q_end__[];
    uint32_t i;

    if (0UL == BCM_TestStatus.ready) {
        /* Clear test related memory */
        BCM_MemSet(__test_q_start__, 0U, (uint32_t)__test_q_end__ - (uint32_t)__test_q_start__);

        /* Copy data from reference queues and mark all queues as ready */
        for (i = 0; i < BCM_TEST_Q_ID_MAX + 1UL; i++) {
            BCM_MemCpy((void *)BCM_TestQs[i], (const void *)BCM_TestRefQs[i], sizeof(BCM_TestQType));
            BCM_TESTQ_SET_READY(BCM_TestQs[i]);
        }

        BCM_TestStatus.ready = 1UL;
    }
}

#ifdef BCM_TEST_CONFIG_LOADER

int32_t MODULE_LoadCfg(const MODULE_Type * const aModEntry)
{
    int32_t retVal = BCM_ERR_OK;
    const MSGQ_MsgHdrType* status;
    if (((0U != aModEntry->configImgID) && (0UL < aModEntry->configImgSize)) &&
        (FALSE == aModEntry->context->isCfgLoaded)) {
        if (BCM_STATE_SUB_STATE_RESET == aModEntry->context->cfgLoadState) {
            BCM_MemSet(aModEntry->configImgData, 0U, aModEntry->configImgSize);
            retVal = BCM_TestLoadImg(aModEntry->configImgID,
                                  aModEntry->configImgData,
                                  aModEntry->configImgSize,
                                  MODULE_Event,
                                  &status);
            if (BCM_ERR_OK == retVal) {
                retVal = BCM_ERR_BUSY;
                aModEntry->context->cfgLoadSize = 0UL;
                aModEntry->context->handle = (uint32_t)status;
                aModEntry->context->cfgLoadState = BCM_STATE_SUB_STATE_STAGE0;
            } else {
                aModEntry->context->cfgLoadState = BCM_STATE_SUB_STATE_RESET;
                /* Report error */
                retVal = BCM_ERR_UNKNOWN;
            }
        } else {
            uint32_t size = 0UL;
            status = (const MSGQ_MsgHdrType *)((uint32_t)(aModEntry->context->handle));
            retVal  = BCM_TestGetLoadImgStatus(status, &size);
            if (BCM_ERR_BUSY == retVal) {
                /* Check again on an event */
            } else {
                aModEntry->context->cfgLoadSize = size;
                aModEntry->context->cfgLoadState = BCM_STATE_SUB_STATE_RESET;
                aModEntry->context->isCfgLoaded = TRUE;
                if (retVal != BCM_ERR_OK) {
                    retVal = BCM_ERR_UNKNOWN;
                    aModEntry->context->cfgLoadState = BCM_STATE_SUB_STATE_RESET;
                    BCM_MemSet(aModEntry->configImgData, 0U, aModEntry->configImgSize);
                }
            }
        }
    }

    return retVal;
}
#endif

typedef struct sBCM_TestImglMsgType {
    uint32_t pending;
    uint8_t  pid;               /**< @brief Partition ID */
    uint16_t imgID;             /**< @brief Image ID */
    uint8_t* imgLoadAddrBuf;    /**< @brief Address buffer where image shall be
                                     loaded by RPC (shall be set to address
                                     passed in #RPC_LoadImg API) */
    uint32_t imgOffset;         /**< @brief offset from where the image need to be loaded */
    uint32_t inLen;             /**< @brief Length of the buffer (shall be set
                                     to length passed in #RPC_LoadImg API) */
    uint32_t imgActualLen;      /**< @brief Actual length of the image (actual
                                     length of the image loaded by RPC). */
    int32_t  result;             /**< @brief Result of the last request */
    uint32_t raw;         /**< @brief Current offset */
} BCM_TestImglMsgType;

static BCM_TestImglMsgType BCM_TestImglMsgs[MSGQ_SIZE];

static void* BCM_TestImglGetMessage(uint32_t idx)
{
    void* msg = NULL;

    if (idx < MSGQ_SIZE) {
        msg = (void *)(&BCM_TestImglMsgs[idx]);
    }
    return msg;
}

MSGQ_DEFINE_V2(BCM_TestImglMsgQ,
        (int32_t)IDLE_Task,
        BCM_TEST_LOAD_EVENT,
        MSGQ_CLIENT_SIGNAL_ENABLE,
        BCM_TestImglMsgType,
        BCM_TestImglMsgQHdr,
        BCM_TestImglGetMessage,
        ".data.imgl");

static void BCM_TestImglStateHandler(BCM_TestImglResDataType *const aResp)
{
    int32_t retVal;
    BCM_TestImglMsgType *msg;
    BCM_TestImglReqDataType testMsg;
    uint32_t idx = 0;

    retVal = MSGQ_GetMsgIdx(&BCM_TestImglMsgQ, &idx);
    if (BCM_ERR_OK == retVal) {
        msg = &BCM_TestImglMsgs[idx];

        if (FALSE == msg->pending) {
            if (1UL == msg->raw) {
                testMsg.flags = BCM_TEST_IMGLREQ_FLAG_PARTIAL;
            } else {
                testMsg.flags = BCM_TEST_IMGLREQ_FLAG_FULL;
            }
            testMsg.pid = msg->pid;
            testMsg.imgID = msg->imgID;
            testMsg.offset = msg->imgOffset;
            testMsg.loadAddr = (uint32_t)msg->imgLoadAddrBuf;
            testMsg.maxSize = msg->inLen;
            BCM_TestSendMsg(BCM_TEST_Q_STREAM_ID, BCM_MSG_IMGL_LOAD, (uint8_t *)&testMsg, sizeof(testMsg));
            msg->pending = TRUE;
        } else {
            if ((TRUE == msg->pending) && (NULL != aResp)) {
                msg->result = aResp->result;
                msg->imgActualLen = aResp->size;
                (void)MSGQ_CompleteMsgIdx(&BCM_TestImglMsgQ, idx);
            }
        }
    }
}

static int32_t BCM_TestImglLoadImgInternal(PTBL_IdType aPid, uint16_t aImgID, uint8_t *const aAddr,
                                    uint32_t aOffset, uint32_t aBufSize, uint32_t aRaw, const uint32_t aClientMask,
                                    const MSGQ_MsgHdrType** const aHdr)
{
    int32_t retVal;
    BCM_TestImglMsgType msg;

    if ((NULL == aAddr) || (0UL == aBufSize) || (NULL == aHdr)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        BCM_MemSet(&msg, 0, sizeof(BCM_TestImglMsgType));
        msg.pid =  (uint8_t)aPid;
        msg.imgID = aImgID;
        msg.imgLoadAddrBuf = aAddr;
        msg.imgOffset = aOffset;
        msg.raw = aRaw;
        msg.inLen = aBufSize;
        msg.result = BCM_ERR_UNKNOWN;
        msg.imgActualLen = 0UL;
        retVal = MSGQ_SendMsg(&BCM_TestImglMsgQ, &msg, aClientMask, aHdr);
    }
    return retVal;
}

int32_t BCM_TestLoadImg(uint16_t aImgID, uint8_t *const aAddr,
        uint32_t aBufSize, const uint32_t aClientMask,
        const MSGQ_MsgHdrType** const aHdr)
{
    return BCM_TestImglLoadImgInternal(PTBL_ID_SYSCFG, aImgID, aAddr, 0,
                                       aBufSize, 0UL, aClientMask, aHdr);
}

int32_t BCM_TestLoadRawImg(PTBL_IdType aPid, uint16_t aImgID, uint8_t *const aAddr,
                        uint32_t aOffset, uint32_t aBufSize, const uint32_t aClientMask,
                        const MSGQ_MsgHdrType** const aHdr)
{
    return BCM_TestImglLoadImgInternal(aPid, aImgID, aAddr, aOffset, aBufSize, 1UL, aClientMask, aHdr);
}

int32_t BCM_TestGetLoadImgStatus(const MSGQ_MsgHdrType *const aHdr, uint32_t *const aSize)
{
    int32_t retVal;
    int32_t status;
    BCM_TestImglMsgType msg;

    retVal = MSGQ_RecvMsg(&BCM_TestImglMsgQ, aHdr, &msg);
    if (BCM_ERR_OK == retVal) {
        *aSize = msg.imgActualLen;
        status = msg.result;
    } else {
        status = BCM_ERR_BUSY;
    }

    return status;
}

/**
    @trace #BRCM_SWDSGN_BCM_TEST_LOADIMG_PROC
    @trace #BRCM_SWREQ_BCM_TEST

    @code{.c}
    @endcode
*/
static void BCM_TestStreamQHandler(void)
{
    int32_t ret;
    BCM_MsgType msgID;
    BCM_TestImglResDataType resp;
    uint32_t inSize = sizeof(resp);
    uint32_t outSize;

    ret = BCM_TestRecvMsg(BCM_TEST_Q_STREAM_ID, &msgID, (uint8_t *)&resp, inSize, &outSize);
    if ((BCM_ERR_OK == ret) && ((BCM_MSG_IMGL_LOAD | BCM_MSG_RESPONSE_MASK) == msgID) &&
        (inSize == outSize)) {
        BCM_TestImglStateHandler(&resp);
    } else {
        BCM_TestImglStateHandler(NULL);
    }
}

/**
    @trace #BRCM_SWDSGN_BCM_TEST_MSG_HANDLER_PROC
    @trace #BRCM_SWREQ_BCM_TEST

    @code{.c}
    @endcode
*/
void BCM_TestMsgHandler(void)
{
    int32_t ret;
    BCM_MsgType msgId;
    BCM_TestCmdDataType  cmd;
    BCM_TestRespDataType resp;
    uint32_t cmdOutLen;
    uint32_t sendResponse = 0UL;
    BCM_DbgMsgType dbgMsg;

    /* Check for new message from host if state is idle */
    if (BCM_TEST_STATE_IDLE == BCM_TestStatus.runState) {
        ret = BCM_TestRecvMsg(BCM_TEST_Q_CMD_ID, &msgId, (uint8_t *)&cmd, sizeof(cmd), &cmdOutLen);
        if (BCM_ERR_OK == ret) {
            if (BCM_MSG_START_TEST == msgId) {
                do {
                    ret = BCM_GetError(&dbgMsg);
                } while (BCM_ERR_OK == ret);
                BCM_TestStatus.currSeq = cmd.seq;
                ret = BCM_ExecuteAT(cmd.seq);
                if (BCM_ERR_OK == ret) {
                    BCM_TestStatus.runState = BCM_TEST_STATE_RUNNING;
                } else {
                    sendResponse = 1UL;
                }
            } else {
                /* TODO: Report Error */
            }
        }
    } else if (BCM_TEST_STATE_RUNNING == BCM_TestStatus.runState) {
        ret = BCM_GetResultAT(BCM_TestStatus.currSeq);
        if (BCM_AT_EXECUTING != ret) {
            BCM_TestStatus.runState = BCM_TEST_STATE_IDLE;
            sendResponse = 1UL;
        }
    } else {
        /* TODO: Report Error */
    }

    if (1UL == sendResponse) {
        msgId = BCM_MSG_START_TEST | BCM_MSG_RESPONSE_MASK | BCM_MSG_GROUP_ID_MASK;
        resp.result = ret;
        resp.seq = BCM_TestStatus.currSeq;
        resp.failedCnt = BCM_TestStatus.failedCnt;
        resp.passedCnt = BCM_TestStatus.passedCnt;
        resp.compId = BCM_TestStatus.compId;
        BCM_TestSendMsg(BCM_TEST_Q_CMD_ID, msgId, (uint8_t *)&resp, sizeof(resp));
    }
    BCM_TestStreamQHandler();
}

/** @} */
