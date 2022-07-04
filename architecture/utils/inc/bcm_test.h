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
/**
    @defgroup grp_utils_bcm_test BCM Test Interface
    @ingroup grp_utils

    @addtogroup grp_utils_bcm_test
    @{
    @section sec_bcm_test_overview Overview
    Provides APIs for adding test references for all components.

    @file bcm_test.h
    @brief BCM Test Functions
    This file provides test interface functions.

    @version 0.1 Initial Version
*/
#ifndef BCM_TEST_H
#define BCM_TEST_H

#include <stdint.h>
#include <bcm_err.h>
#include <msg_queue.h>
#include <pt_utils.h>

/**
    @name BCM Test Architecture IDs
    @{
    @brief Architecture IDs for BCM Test APIs

*/
#define BRCM_SWARCH_BCM_TESTSTART_PROC                (0x8701U)    /**< @brief #BCM_TestStart             */
#define BRCM_SWARCH_BCM_SETTESTCASE_PROC              (0x8702U)    /**< @brief #BCM_SetTestCase           */
#define BRCM_SWARCH_BCM_SETTESTSEQ_PROC               (0x8703U)    /**< @brief #BCM_SetTestSeq            */
#define BRCM_SWARCH_BCM_SETTESTPROBESTATUS_PROC       (0x8704U)    /**< @brief #BCM_SetTestProbeStatus    */
#define BRCM_SWARCH_BCM_GETTESTPROBESTATUS_PROC       (0x8705U)    /**< @brief #BCM_GetTestProbeStatus    */
#define BRCM_SWARCH_BCM_SETTESTRESULT_PROC            (0x8706U)    /**< @brief #BCM_SetTestResult         */
#define BRCM_SWARCH_BCM_GETTESTCASE_PROC              (0x8707U)    /**< @brief #BCM_GetTestCase           */
#define BRCM_SWARCH_BCM_GETTESTSEQ_PROC               (0x8708U)    /**< @brief #BCM_GetTestSeq            */
#define BRCM_SWARCH_BCM_TESTSTOP_PROC                 (0x8709U)    /**< @brief #BCM_TestStop              */
#define BRCM_SWARCH_BCM_TEST_RESULT_TYPE              (0x870AU)    /**< @brief #BCM_TestResultType        */
#define BRCM_SWARCH_BCM_TEST_CASE_ID_TYPE             (0x870BU)    /**< @brief #BCM_TestCaseIdType        */
#define BRCM_SWARCH_BCM_TEST_PROBE_STATUS_TYPE        (0x870CU)    /**< @brief #BCM_TestProbeStatusType   */
#define BRCM_SWARCH_BCM_TEST_SEQ_ID_TYPE              (0x870DU)    /**< @brief #BCM_TestSeqIdType         */
#define BRCM_SWARCH_BCM_TEST_ADD_PROBE_MACRO          (0x870EU)    /**< @brief #BCM_TEST_ADD_PROBE        */
#define BRCM_SWARCH_BCM_AT_TYPE                       (0x870FU)    /**< @brief #BCM_ATStateType           */
#define BRCM_SWARCH_BCM_EXECUTEAT_PROC                (0x8710U)    /**< @brief #BCM_ExecuteAT             */
#define BRCM_SWARCH_BCM_GETRESULT_PROC                (0x8711U)    /**< @brief #BCM_GetResultAT           */
#define BRCM_SWARCH_BCM_IS_PROBE_PROC                 (0x8712U)    /**< @brief #BCM_IsProbeTestCase       */
#define BRCM_SWARCH_BCM_TESTINFO_TYPE                 (0x8713U)    /**< @brief #BCM_TestQType             */
#define BRCM_SWARCH_BCM_TESTRESULTDATA_TYPE           (0x8714U)    /**< @brief #BCM_TestResultDataType    */
#define BRCM_SWARCH_BCM_TESTRESARRAYLEN_MACRO         (0x8715U)    /**< @brief #BCM_TEST_RESULT_ARRAY_LEN */
#define BRCM_SWARCH_BCM_TESTMAGIC_MACRO               (0x8716U)    /**< @brief #BCM_TESTQ_MAGIC           */
#define BRCM_SWARCH_BCM_TESTINFO_GLOBAL               (0x8717U)    /**< @brief #BCM_TestInfo              */
#define BRCM_SWARCH_BCM_TESTRESULTQ_GLOBAL            (0x8718U)    /**< @brief #BCM_TestResultQ           */
#define BRCM_SWARCH_BCM_IS_COMP_PROBE_PROC            (0x8719U)    /**< @brief #BCM_IsCompProbeTestCase   */
#define BRCM_SWARCH_BCM_TESTMSGHANDLER_PROC           (0x871AU)    /**< @brief #BCM_TestMsgHandler        */
#define BRCM_SWARCH_BCM_SETREADYFORTEST_PROC          (0x871BU)    /**< @brief #BCM_SetReadyForTest       */
#define BRCM_SWARCH_BCM_TEST_VER_TYPE                 (0x871CU)    /**< @brief #BCM_TestVersionType       */
#define BRCM_SWARCH_BCM_TEST_MSG_MAGIC_TYPE           (0x871DU)    /**< @brief #BCM_TestMsgMagicType      */
#define BRCM_SWARCH_BCM_TEST_MSG_FIFO_TYPE            (0x871EU)    /**< @brief #BCM_TestMsgFifoType       */
#define BRCM_SWARCH_BCM_MSG_TYPE                      (0x871FU)    /**< @brief #BCM_MsgType               */
#define BRCM_SWARCH_BCM_TESTMSGHDR_TYPE               (0x8720U)    /**< @brief #BCM_TestMsgHdrType        */
#define BRCM_SWARCH_BCM_TESTRESPDATA_TYPE             (0x8721U)    /**< @brief #BCM_TestRespDataType      */
#define BRCM_SWARCH_BCM_TESTPAYLOAD_TYPE              (0x8722U)    /**< @brief #BCM_TestPayloadType       */
#define BRCM_SWARCH_BCM_TESTMSG_TYPE                  (0x8723U)    /**< @brief #BCM_TestMsgType           */
#define BRCM_SWARCH_BCM_TESTVERINFO_TYPE              (0x8724U)    /**< @brief #BCM_TestVerInfoType       */
#define BRCM_SWARCH_BCM_TESTSIZEINFO_TYPE             (0x8725U)    /**< @brief #BCM_TestSizeInfoType      */
#define BRCM_SWARCH_BCM_TESTCMDDATA_TYPE              (0x8726U)    /**< @brief #BCM_TestCmdDataType       */
#define BRCM_SWARCH_BCM_TEST_ID_TYPE                  (0x8727U)    /**< @brief #BCM_TestIdType            */
#define BRCM_SWARCH_BCM_TESTLOADIMG_PROC              (0x8728U)    /**< @brief #BCM_TestLoadImg           */
#define BRCM_SWARCH_BCM_TESTLOADIMGRAW_PROC           (0x8729U)    /**< @brief #BCM_TestLoadRawImg        */
#define BRCM_SWARCH_BCM_TESTGETLOADIMGSTATUS_PROC     (0x872AU)    /**< @brief #BCM_TestGetLoadImgStatus  */
#define BRCM_SWARCH_BCM_TESTQUEUE_TYPE                (0x872BU)    /**< @brief #BCM_TestQType             */
#define BRCM_SWARCH_BCM_TESTIMGLREQDATA_TYPE          (0x872CU)    /**< @brief #BCM_TestImglReqDataType   */
#define BRCM_SWARCH_BCM_TESTIMGLRESPDATA_TYPE         (0x872DU)    /**< @brief #BCM_TestImglResDataType   */
/** @} */

/**
    @name Test version type
    @{
    @brief Major and Minor version of test infrastructure

    @trace #BRCM_SWREQ_BCM_TEST
*/
typedef uint8_t BCM_TestVersionType;  /**< @brief Test version typedef */
#define BCM_TEST_VER_MAJOR_V0  (0U)
#define BCM_TEST_VER_MINOR_V1  (1U)
/** @} */

/**
    @name Autotest error codes
    @{
    @brief Error codes for Autotest

    @trace #BRCM_SWREQ_BCM_TEST
*/
typedef int32_t BCM_ATStateType;
#define BCM_AT_NOT_AVAILABLE    (-1)   /**< Auto test not available  */
#define BCM_AT_NOT_STARTED      (-2)   /**< Auto test not started    */
#define BCM_AT_EXECUTING        (-3)   /**< Auto test running        */
/** @} */

/**
    @name BCM Test Probe Status
    @{
    @brief Probe Status whether enabled or disabled.

    @trace #BRCM_SWREQ_BCM_TEST
*/
typedef uint16_t BCM_TestProbeStatusType;    /**< @brief Test Probe status typedef     */
#define BCM_TEST_PROBE_STATUS_DIS   (0x0U)   /**< @brief Probe is enabled              */
#define BCM_TEST_PROBE_STATUS_EN    (0x1U)   /**< @brief Probe is disabled             */
/** @} */

/**
    @name Test ID Type
    @{
    @brief Test ID Type is defined by bits 15:12 of test case or seq value.

    @trace #BRCM_SWREQ_BCM_TEST
*/
typedef uint32_t BCM_TestIdType;        /**< @brief 32-bit Test ID */
#define BCM_TEST_ID_TYPE_MASK          (0xF000UL)
#define BCM_TEST_ID_TYPE_SHIFT         (12UL)
#define BCM_TEST_ID_TYPE_QT            (0x0UL)
#define BCM_TEST_ID_TYPE_IT            (0x1UL)
#define BCM_TEST_ID_TYPE_COV           (0x2UL)
#define BCM_TEST_ID_TYPE_PRB           (0x3UL)
#define BCM_TEST_ID_TYPE_MANUAL_QT     (0x4UL)

/**
    @name BCM_TestImgReqFlagType
    @{
    @brief BCM Test image load request flag type.

    @trace #BRCM_SWREQ_BCM_TEST
*/
typedef uint8_t BCM_TestImglReqFlagType;
#define BCM_TEST_IMGLREQ_FLAG_FULL      (0U)    /**< @brief load complete image */
#define BCM_TEST_IMGLREQ_FLAG_PARTIAL   (1U)    /**< @brief load partial image (in chunks) */
/** @} */

/**
    @name Test Case ID

    @brief 32-bit test case ID for all test cases of a component.
    This will be used for logging the result of the test case and also for
    enabling the probe.

    @trace #BRCM_SWREQ_BCM_TEST
*/
typedef uint32_t BCM_TestCaseIdType;   /**< @brief 32-bit Test Case Id */

/**
    @name Test Seq ID
    @{
    @brief 32-bit test sequence ID for all test sequences of a component.
    This will be used for logging the result of the test case and also for
    enabling the probe.

    @trace #BRCM_SWREQ_BCM_TEST
*/
typedef uint32_t BCM_TestSeqIdType;   /**< @brief 32-bit Test Seq ID */
#define BCM_TEST_SEQ_TYPE_MASK          (0xF000UL)
#define BCM_TEST_SEQ_TYPE_SHIFT         (12UL)
#define BCM_TEST_SEQ_TYPE_QT            (0x0UL)
#define BCM_TEST_SEQ_TYPE_IT            (0x1UL)
#define BCM_TEST_SEQ_TYPE_COV           (0x2UL)
#define BCM_TEST_SEQ_TYPE_PRB           (0x3UL)
#define BCM_TEST_SEQ_TYPE_MANUAL_QT     (0x4UL)
/** @} */

/**
    @name Probe Statement Macro with Comp-ID

    @brief Defines the test probe format. This macro is used in component source
    file wherever probe is needed for the test component.
    Probe is enabled only if component-id, test-seq and test-case of the probe
    matches current test component, seq and case.

    @param[in]   aCompId     Component ID.
    @param[in]   aSeqId      Test sequence.
    @param[in]   aCaseId     Test case.
    @param[in]   aCode       Actual probe code which should be inserted.

    @trace #BRCM_SWREQ_BCM_TEST
*/
#define BCM_TEST_ADD_PROBE(aCompId, aSeqId, aCaseId, aCode)      \
             if (BCM_IsProbeTestCase(aCompId, aSeqId, aCaseId)) { aCode; }

/**
    @name BCM Test Message ID Type
    @{
    @brief Message Id details.

    @trace #BRCM_SWREQ_BCM_TEST
*/
typedef uint32_t BCM_MsgType;
#define BCM_MSG_RESPONSE_MASK  (BCM_CMD_RESPONSE_MASK)                             /**< @brief Msg resp mask      */
#define BCM_MSG_GROUP_ID_MASK  ((uint32_t)BCM_GROUPID_TEST << BCM_CMD_GROUP_SHIFT) /**< @brief Msg group ID mask  */
#define BCM_MSG_START_TEST     (0x1U)                                              /**< @brief Test Start Message */
#define BCM_MSG_IMGL_LOAD      (0x2U | BCM_CMD_ASYNC_MASK)                         /**< @brief Image load async command */
/** @} */

/**
    @name BCM_TestQIDType
    @{
    @brief Test Queue types.

    @trace #BRCM_SWREQ_BCM_TEST
*/
typedef uint32_t BCM_TestQIDType;
#define BCM_TEST_Q_CMD_ID        (0UL)
#define BCM_TEST_Q_STREAM_ID     (1UL)
#define BCM_TEST_Q_RESULT_ID     (2UL)
#define BCM_TEST_Q_ID_MAX        (BCM_TEST_Q_RESULT_ID)
/** @} */

/**
    @name BCM Test message FIFO
    @{
    @brief Msg FIFO length and index details

    @trace #BRCM_SWREQ_BCM_TEST
*/
typedef uint8_t BCM_TestQFifoLenType;
#ifndef BCM_TESTQ_CMDQ_FIFO_LOG2_LEN
#define BCM_TESTQ_CMDQ_FIFO_LOG2_LEN            (3U)
#endif

#ifndef BCM_TESTQ_STREAMQ_FIFO_LOG2_LEN
#define BCM_TESTQ_STREAMQ_FIFO_LOG2_LEN         (3U)
#endif

#ifndef BCM_TESTQ_RESULTQ_FIFO_LOG2_LEN
#define BCM_TESTQ_RESULTQ_FIFO_LOG2_LEN         (4U)
#endif
/** @} */

/**
    @name BCM Test message magic
    @{
    @brief Magic word for test message between host and target. This is placed at
    the beginning of each message as part of message header.

    @trace #BRCM_SWREQ_BCM_TEST
*/
typedef uint32_t BCM_TestMsgMagicType;
#define BCM_TEST_MSG_MAGIC             (0x544D5347UL)    /**< @brief TMSG: Test Message  */
/** @} */

/**
    @name Test message header

    @brief 16 Byte header for test messages

    @trace #BRCM_SWREQ_BCM_TEST
*/
typedef struct sBCM_TestMsgHdrType {
    BCM_TestMsgMagicType    magic;
    uint32_t                reserved;
    BCM_MsgType             msgId;
    uint32_t                len;
} BCM_TestMsgHdrType;

/**
    @name Test message response payload

    @brief Response payload details for response message

    @trace #BRCM_SWREQ_BCM_TEST
*/
typedef struct sBCM_TestRespDataType {
    int32_t             result;          /**< @brief Test result of sequence */
    BCM_TestSeqIdType   seq;             /**< @brief Test sequence           */
    uint32_t            failedCnt;       /**< @brief Test failed count       */
    uint32_t            passedCnt;       /**< @brief Test passed count       */
    BCM_CompIDType      compId;          /**< @brief 16-Bit component Id     */
} BCM_TestRespDataType;

/**
    @name Test message command payload

    @brief Command payload details for command message

    @trace #BRCM_SWREQ_BCM_TEST
*/
typedef struct sBCM_TestCmdDataType {
    BCM_TestSeqIdType        seq;       /**< @brief Test sequence */
} BCM_TestCmdDataType;

/**
    @name Test Result Data format.

    @brief Result data format which is stored in an array.

    @trace #BRCM_SWREQ_BCM_TEST
*/
typedef struct sBCM_TestResultDataType {
    BCM_TestCaseIdType caseId;             /**< @brief 32-Bit Test Case ID   */
    int32_t result;                        /**< @brief Test Result    */
} BCM_TestResultDataType;

/**
    @name BCM_TestImglReqType

    @brief image load request payload type

    @trace #BRCM_SWREQ_BCM_TEST
*/
typedef struct sBCM_TestImglReqDataType {
    BCM_TestImglReqFlagType  flags;      /**< @brief Request flags */
    uint8_t                  pid;        /**< @brief partition ID */
    uint16_t                 imgID;      /**< @brief image ID */
    uint32_t                 offset;     /**< @breif image offset */
    uint32_t                 loadAddr;   /**< @brief Load address (target memory where this image
                                                     shall be loaded) */
    uint32_t                 maxSize;    /**< @brief maximum memory size (debugger shall load
                                                     image at loadAddr only if
                                                     image size < maxSize) */
} BCM_TestImglReqDataType;

/**
    @name BCM_TestImglResDataType

    @brief image load request payload type

    @trace #BRCM_SWREQ_BCM_TEST
*/
typedef struct sBCM_TestImglResDataType {
    int32_t     result;                 /**< @brief result of last image request */
    uint32_t    imgSz;                  /**< @brief actual size of the image being requested */
    uint32_t    size;                   /**< @brief number of bytes actually loaded at
                                                    BCM_TestImgReqType::loadAddr.
                                                    if BCM_TestImgReqType:flags set to
                                                    BCM_TEST_IMGLREQ_FLAG_FULL, complete
                                                    image shall be loaded in once and imgSz
                                                    shall be equal to size.
                                                    if BCM_TestImgReqType:flags is set to
                                                    BCM_TEST_IMGLREQ_FLAG_PARTIAL, imgSz
                                                    shall be set to size of the actual image
                                                    and size shall be set to number of bytes
                                                    actually loaded at the BCM_TestImglReqDataType::loadAddr. */
} BCM_TestImglResDataType;

/**
    @name Test message payload

    @brief 48 Byte message payload

    @trace #BRCM_SWREQ_BCM_TEST
*/
typedef union uBCM_TestPayloadType {
    uint32_t                    data[12];       /**< @brief payload buffer */
    BCM_TestCmdDataType         cmd;            /**< @brief payload test command data */
    BCM_TestRespDataType        resp;           /**< @brief payload test response data */
    BCM_TestResultDataType      testResult;     /**< @brief test result payload data */
    BCM_TestImglReqDataType     imglCmd;        /**< @brief image load command data */
    BCM_TestImglResDataType     imglResp;       /**< @brief image load response data */
} BCM_TestPayloadType;

/**
    @name Test message type

    @brief 64 Byte message payload with 16 byte header and 48 byte payload

    @trace #BRCM_SWREQ_BCM_TEST
*/
typedef struct sBCM_TestMsgType {
    BCM_TestMsgHdrType  msgHdr;
    BCM_TestPayloadType msgData;
} BCM_TestMsgType;

/**
    @name BCM_TestQType

    @brief Test Queue type respresenting host to target
           buffer and target to host buffer and corresponding
           indices

    @todo  This strucutre contains some variables which will not change run time
           and other variables which will change.
           We should split this structure with respect constant vs non-constant
           behavior of variables. This will help avoiding some of Coverity warnings.
           Updating this will need updation of host side script as well.

    @trace #BRCM_SWREQ_BCM_TEST
*/
typedef volatile struct sBCM_TestQType {
    uint32_t                magic;               /**< @brief Test Magic Num */
    uint8_t                 majorVer;            /**< @brief Major version */
    uint8_t                 minorVer;            /**< @brief Minor version */
    uint8_t                 msgSzLog2;           /**< @brief Message length */
    uint8_t                 fifoLenLog2;         /**< @brief Message FIFO Depth */
    uint16_t                rollOverMask;        /**< @brief index rollover mask */
    uint16_t                rsvd;                /**< @brief reserved for future */
    uint32_t                tRdIdx;              /**< @brief target read index */
    uint32_t                tWrIdx;              /**< @brief target write index */
    uint32_t                hRdIdx;              /**< @brief host read index */
    uint32_t                hWrIdx;              /**< @brief host write index */
    uint32_t                h2tDropCnt;          /**< @brief host to target drop count.
                                                              Incremented by host when
                                                              h2tBuf buffer is full and
                                                              host is not able to post
                                                              message */
    uint32_t                t2hDropCnt;          /**< @brief target to host drop count.
                                                              Incremented by target when
                                                              t2hBuf buffer is full and
                                                              target is not able to post
                                                              message */
    uint8_t                 *h2tBuf;             /**< @brief host to target buffer */
    uint8_t                 *t2hBuf;             /**< @brief target to host buffer */

} BCM_TestQType;

/**
    @name BCM test Q magic

    @brief Magic word to be placed at begining of BCM Test Q structure

    Until magic is updated with this value, target is not ready
    for test. Debugger should poll for this magic before starting the test.

    @trace #BRCM_SWREQ_BCM_TEST
*/
#define BCM_TESTQ_MAGIC  (0x42545354UL)   /**< @brief magic number 'BTST' */

/**
    @name BCM_TESTQ_ISNEWMSG

    @brief check for new message in Queue

    @trace #BRCM_SWREQ_BCM_TEST
*/
#define BCM_TESTQ_ISNEWMSG(q) ((q)->hWrIdx != (q)->tRdIdx)

/**
    @name BCM_TESTQ_NOTFULL

    @brief check if Queue is full or not

    @trace #BRCM_SWREQ_BCM_TEST
*/
#define BCM_TESTQ_NOTFULL(q)       \
    ((((q)->hRdIdx + (1UL << (uint32_t)(q)->fifoLenLog2)) & (q)->rollOverMask) != (q)->tWrIdx)

/**
    @name BCM_TESTQ_INCRIDX

    @brief Increment the given index of the queue

    @trace #BRCM_SWREQ_BCM_TEST
*/
#define BCM_TESTQ_INCRIDX(q, idx)  ((q)->idx = (((q)->idx + 1UL) & (q)->rollOverMask))

/**
    @name BCM_TESTQ_INIT

    @brief Initialize Queue params

    @trace #BRCM_SWREQ_BCM_TEST
*/
#define BCM_TESTQ_INIT(major, minor, depth, msgLen, rollMask, hBuf, tBuf) {\
            .magic  = 0, \
            .tRdIdx = 0, \
            .tWrIdx = 0, \
            .hRdIdx = 0, \
            .hWrIdx = 0, \
            .h2tDropCnt = 0, \
            .t2hDropCnt = 0, \
            .majorVer = major, \
            .minorVer = minor, \
            .fifoLenLog2 = depth, \
            .rollOverMask = rollMask, \
            .msgSzLog2 = msgLen,    \
            .h2tBuf = hBuf, \
            .t2hBuf = tBuf, \
    }

/**
    @name BCM_TESTQ_DEFINE_V0

    @brief Define Queue (Version 0)

    @trace #BRCM_SWREQ_BCM_TEST
*/
#define BCM_TESTQ_DEFINE_V0(name, major, minor, depth, msgLen, rollMask, hBuf, tBuf) \
    static const BCM_TestQType (name) = BCM_TESTQ_INIT((major), (minor), (depth), (msgLen), (rollMask), (hBuf), (tBuf));

/**
    @name BCM_TESTQ_SET_READY

    @brief Marks a queue in ready state (host shall
    wait for Queue ready before posting message in
    the Queue)

    @trace #BRCM_SWREQ_BCM_TEST
*/
#define BCM_TESTQ_SET_READY(q)  ((q)->magic = BCM_TESTQ_MAGIC)

/**
    @name BCM_TestCmdQ

    @brief Test Command Q (test execution related
    commands are posted/processed in this Q)

    @trace #BRCM_SWREQ_BCM_TEST
*/
extern BCM_TestQType BCM_TestCmdQ;

/**
    @name BCM_TestStreamQ

    @brief Stream related command (like image
    load request) are posted and processed
    in this Q.

    @trace #BRCM_SWREQ_BCM_TEST
*/
extern BCM_TestQType BCM_TestStreamQ;

/**
    @name BCM_TestResultQ

    @brief Test case results are posted
    in this Q by the target.

    @trace #BRCM_SWREQ_BCM_TEST
*/
extern BCM_TestQType BCM_TestResultQ;

/** @brief Sets Test Case ID. This must be called before executing actual test
    in a test case to set the test case.

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aTestCaseId     32-bit Test Case ID

    @return void

    @post None

    @trace #BRCM_SWREQ_BCM_TEST

    @limitations None
*/
void BCM_SetTestCase(BCM_TestCaseIdType aTestCaseId);

/** @brief Returns current Test Case ID.

    @behavior Sync, Non-reentrant

    @pre None

    @param[in] void

    @return  32-bit Test Case ID

    @post None

    @trace #BRCM_SWREQ_BCM_TEST

    @limitations None
*/
BCM_TestCaseIdType BCM_GetTestCase(void);

/** @brief Sets Test Sequence ID. This must be called before executing first test
    case of a test sequence to set the test sequence ID.

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aTestSeqId     32-bit Test Sequence ID

    @return void

    @post None

    @trace #BRCM_SWREQ_BCM_TEST

    @limitations None
*/
void BCM_SetTestSeq(BCM_TestSeqIdType aTestSeqId);

/** @brief Returns current Test Sequence ID.

    @behavior Sync, Non-reentrant

    @pre None

    @param[in] void

    @return  32-bit Test Sequence ID

    @post None

    @trace #BRCM_SWREQ_BCM_TEST

    @limitations None
*/
BCM_TestSeqIdType BCM_GetTestSeq(void);

/** @brief Enables Probe point for all test cases.

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aProbeStatus      Enable or Disable

    @return void

    @post None

    @trace #BRCM_SWREQ_BCM_TEST

    @limitations None
*/
void BCM_SetTestProbeStatus(BCM_TestProbeStatusType aProbeStatus);

/** @brief Disables Probe point for all test cases.

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      None

    @return Enable or Disable (BCM_TestProbeStatusType)

    @post None

    @trace #BRCM_SWREQ_BCM_TEST

    @limitations None
*/
BCM_TestProbeStatusType BCM_GetTestProbeStatus(void);

/** @brief Checks if the probe is applicable for current component, test seq and
    test case.

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aCompId    16-bit Component ID
    @param[in]      aSeqId     32-bit Test Sequence ID
    @param[in]      aCaseId    32-bit Test Case ID

    @return         TRUE       If probe is enabled and compId, seqId and caseId
                               matches
    @return         FALSE      If probe is disabled or any of compId, seqId and
                               caseId does not match

    @post None

    @trace #BRCM_SWREQ_BCM_TEST

    @limitations None
*/
uint32_t BCM_IsProbeTestCase(BCM_CompIDType aCompId,
                                 BCM_TestSeqIdType aSeqId,
                                 BCM_TestCaseIdType aCaseId);

/** @brief Initilizes test module.

    This API is used to initialize the test module.

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aCompId     16-bit Component ID
    @param[in]      aTestType   32-bit Test type QT or IT

    @return None

    @post None

    @trace #BRCM_SWREQ_BCM_TEST

    @limitations None
*/
void BCM_TestStart(BCM_CompIDType aCompId);

/** @brief Logs the result of the test case.
    This also logs current test sequence ID and test case ID.

    This API is called by each test case after execution of actual test.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      int32_t            Result of Test Case.

    @return void

    @post None

    @trace #BRCM_SWREQ_BCM_TEST

    @limitations None
*/
void BCM_SetTestResult(int32_t aResult);

/** @brief Marks test done.

    This API is used to mark test done.

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      None

    @return None

    @post None

    @trace #BRCM_SWREQ_BCM_TEST

    @limitations None
*/
void BCM_TestStop(void);

/** @brief Handles message to and from host.

    This API is used to receive and send messages over debugger interface.

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      None

    @return None

    @post None

    @trace #BRCM_SWREQ_BCM_TEST

    @limitations None
*/
void BCM_TestMsgHandler(void);

/** @brief Marks Target as ready for test.

    This API sets the magic which host polls before starting the test.

    This API should be called from suitable place when system has
    initialized all dependent modules related to component under test.

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      None

    @return None

    @post None

    @trace #BRCM_SWREQ_BCM_TEST

    @limitations None
*/
void BCM_SetReadyForTest(void);

/** @brief Execute an automated test

    @behavior Async, Non-reentrant

    @pre None

    @param[in]      aIndex      32-bit Test Index

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Test execution started
    @retval     Others                  As in Autotest error codes

    @post None

    @trace #BRCM_SWREQ_BCM_TEST

    @limitations None
*/
int32_t BCM_ExecuteAT(uint32_t aIndex);

/** @brief Get test result

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aIndex      32-bit Test Index

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Test execution successful
    @retval     #BCM_AT_EXECUTING       Test is executing
    @retval     #BCM_AT_NOT_STARTED     If test is not started
    @retval     #BCM_AT_NOT_AVAILABLE   Test is not supported
    @retval     Others                  Test completed with this error

    @post None

    @trace #BRCM_SWREQ_BCM_TEST

    @limitations None
*/
int32_t BCM_GetResultAT(uint32_t aIndex);

/** @brief Load image request

    This API sends a async command to host to
    load a given image (aImgID) from config partition.
    After image is loaded, caller will be signalled and
    it shall call BCM_TestGetLoadImgStatus() API to
    find the status of the loaded image and its actual
    size.

    @behavior Async, Non-reentrant

    @pre None

    @param[in]      aImgID          Image ID
    @param[in]      aAddr           Memory address where this image will be loaded
    @param[in]      aBufSize        Lenght of the buffer (aAddr)
    @param[in]      aClientMask     Signal mask which will be triggered
                                    when image is loaded
    @param[out]     aHdr            MSGQ header (shall be used later to query the
                                    status by calling BCM_TestGetLoadImgStatus().


    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Request is accepted. Caller will be signaled
                                        when image loading completes
    @retval     #BCM_ERR_INVAL_PARAMS   aAddr is NULL or
                                        aBufSize is 0
    @retVal     #BCM_ERR_BUSY           Previous request is pending

    @post None

    @trace #BRCM_SWREQ_BCM_TEST

    @limitations None
*/
int32_t BCM_TestLoadImg(uint16_t aImgID, uint8_t *const aAddr,
                        uint32_t aBufSize, const uint32_t aClientMask,
                        const MSGQ_MsgHdrType** const aHdr);

/** @brief Load raw image request

    This API sends a async command to host to
    load a raw image from given partition (aPID).
    After image is loaded, caller will be signalled and
    it shall call BCM_TestGetLoadImgStatus() API to
    find the status of the loaded image and its actual
    size.

    @behavior Async, Non-reentrant

    @pre None

    @param[in]      aPID            Partition ID
    @param[in]      aImgID          Image ID
    @param[in]      aAddr           Memory address where this image will be loaded
    @param[in]      aOffset         Offset within image
    @param[in]      aBufSize        Lenght of the buffer (aAddr)
    @param[in]      aClientMask     Signal mask which will be triggered
                                    when image is loaded
    @param[out]     aHdr            MSGQ header (shall be used later to query the
                                    status by calling BCM_TestGetLoadImgStatus().

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Request is accepted. Caller will be signaled
                                        when image loading completes
    @retval     #BCM_ERR_INVAL_PARAMS   aAddr is NULL or
                                        aBufSize is 0
    @retVal     #BCM_ERR_BUSY           Previous request is pending

    @post None

    @trace #BRCM_SWREQ_BCM_TEST

    @limitations None

*/
int32_t BCM_TestLoadRawImg(PTBL_IdType aPid, uint16_t aImgID, uint8_t *const aAddr,
                           uint32_t aOffset, uint32_t aBufSize, const uint32_t aClientMask,
                           const MSGQ_MsgHdrType** const aHdr);

/** @brief Get status of the image load request

    This APIs returns the status of the load image
    request and actual size of the image loaded.

    @behavior Sync, Non-reentrant

    @pre None

    @param[out]      aSize            Actual size of the image loaded
    @param[int]      aHdr             MSGQ header


    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             image is loaded successfully
                                        and actual size of the image
                                        is returned in aSize.
    @retval     #BCM_ERR_INVAL_PARAMS   aSize is NULL
    @retVal     #BCM_ERR_BUSY           Request is pending (image is
                                        being loaded)

    @post None

    @trace #BRCM_SWREQ_BCM_TEST

    @limitations None
*/
int32_t BCM_TestGetLoadImgStatus(const MSGQ_MsgHdrType *const aHdr, uint32_t *const aSize);

#endif  /* BCM_TEST_H */
/** @} */
