/*****************************************************************************
 Copyright 2022 Broadcom Limited.  All rights reserved.

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
#include "ee.h"
#include <bcm_utils.h>
#include <ulog.h>
#include <bcm_err.h>
#include <bcm_test.h>
#include <module_helper.h>
#include <nvm_service_osil.h>
#include <nvm_service.h>
#include <nvm_flash.h>

#include "nvm_service_test.h"
#include "nvm_service_qt.h"

#define GetModuleLogLevel()     ULOG_LVL_ERROR

#define CALL(func)                                                               \
        retVal = func;                                                           \
        if (BCM_ERR_OK != retVal) {                                              \
            NVMSrvQtResult = retVal;                                             \
            NVMSrvQtErrCnt++;                                                    \
        }                                                                        \

#define EXECUTE_TEST(case, func, expecRet)                                       \
        BCM_SetTestCase(case);                                                   \
        retVal = func;                                                           \
        if (expecRet == retVal) {                                                \
            BCM_SetTestResult(BCM_ERR_OK);                                       \
        } else {                                                                 \
            BCM_SetTestResult(BCM_ERR_UNKNOWN);                                  \
            ULOG_ERR("NVMSRV_QT: Err case: %x, retVal: %x at: %d\n",             \
                                            case, retVal, __LINE__);             \
            NVMSrvQtErrCnt++;                                                    \
        }                                                                        \

#define REPORT_RESULT(case, condition)                                           \
        BCM_SetTestCase(case);                                                   \
        if (condition) {                                                         \
            BCM_SetTestResult(BCM_ERR_OK);                                       \
        } else {                                                                 \
            BCM_SetTestResult(BCM_ERR_UNKNOWN);                                  \
            ULOG_ERR("NVMSRV_QT: Err case: %x, at line : %d\n", case, __LINE__); \
            NVMSrvQtErrCnt++;                                                    \
            goto bcm_err;                                                        \
        }                                                                        \

static int32_t  NVMSrvQtRunState = BCM_AT_NOT_STARTED;
static uint32_t NVMSrvQtIdx      = 0UL;
static int32_t  NVMSrvQtResult;
static uint32_t NVMSrvQtErrCnt;

static int32_t NVMSRV_TestQT1(void)
{
    int32_t retVal = BCM_ERR_OK;
    MODULE_ContextType *context = NVM_Service.server.context;

    BCM_HandleType handle;
    uint32_t forwardToSlaves;
    uint32_t replyLen;
    uint32_t currMask;




    do {
        retVal = NVM_Service.client.resetStateHandler(BCM_STATE_INIT);
        if (BCM_ERR_BUSY != retVal) {
            break;
        }
        (void)BCM_WaitEvent(MODULE_Event);
        (void)BCM_GetEvent(NVMSRVQT_Task, &currMask);
        (void)BCM_ClearEvent(currMask);
    } while(BCM_ERR_BUSY == retVal);

    do {
        retVal = NVM_Service.client.initStateHandler(BCM_STATE_READY);
        if (BCM_ERR_BUSY != retVal) {
            break;
        }
        (void)BCM_WaitEvent(MODULE_Event);
        (void)BCM_GetEvent(NVMSRVQT_Task, &currMask);
        (void)BCM_ClearEvent(currMask);
    } while(BCM_ERR_BUSY == retVal);

    do {
        retVal = NVM_Service.client.readyStateHandler(BCM_STATE_RUN);
        if (BCM_ERR_BUSY != retVal) {
            break;
        }
        (void)BCM_WaitEvent(MODULE_Event);
        (void)BCM_GetEvent(NVMSRVQT_Task, &currMask);
        (void)BCM_ClearEvent(currMask);
    } while(BCM_ERR_BUSY == retVal);

    REPORT_RESULT(BRCM_SWQTST_NVM_SERVICE_SERVER_GET_RESP_NOSUPPORT,
                  (context->state == BCM_STATE_RUN))

    FLASH_RpcWriteInfoType writeCmd;
    static uint8_t FLASHMQT_TxBuf[256];

    writeCmd.hwID = 0UL;
    writeCmd.addr = 1024*1024;
    writeCmd.len = 256UL;
    BCM_MemSet(FLASHMQT_TxBuf, 0xA5, sizeof(FLASHMQT_TxBuf));
    BCM_MemCpy(writeCmd.bufIn, FLASHMQT_TxBuf, sizeof(writeCmd.bufIn));

    retVal = NVM_Service.server.sendCmd( BCM_CMDID(BCM_GROUPID_NVM, BCM_FLM_ID, FLASH_CMD_RPC_WRITE),
            sizeof(FLASH_RpcWriteInfoType),
            (const uint8_t*)&writeCmd,
            &handle,
            &forwardToSlaves);
    do {
    (void)BCM_WaitEvent(MODULE_Event);
    (void)BCM_GetEvent(NVMSRVQT_Task, &currMask);
    (void)BCM_ClearEvent(currMask);
    retVal = NVM_Service.server.getResp(handle,
                                        BCM_CMDID(BCM_GROUPID_NVM, BCM_FLM_ID, FLASH_CMD_RPC_WRITE),
                                        sizeof(FLASH_RpcWriteInfoType),
                                        (uint8_t*)&writeCmd,
                                        &replyLen);
    } while (BCM_ERR_BUSY == retVal);

    REPORT_RESULT(BRCM_SWQTST_NVM_SERVICE_SERVER_GET_RESP_NOSUPPORT,
                  (replyLen == sizeof(FLASH_RpcWriteInfoType)))

    do {
        retVal = NVM_Service.client.runStateHandler(BCM_STATE_UNINIT);
        if (BCM_ERR_BUSY != retVal) {
            break;
        }
        (void)BCM_WaitEvent(MODULE_Event);
        (void)BCM_GetEvent(NVMSRVQT_Task, &currMask);
        (void)BCM_ClearEvent(currMask);
    } while(BCM_ERR_BUSY == retVal);

    REPORT_RESULT(BRCM_SWQTST_NVM_SERVICE_SERVER_GET_RESP_NOSUPPORT,
                  (context->state == BCM_STATE_UNINIT))

bcm_err:

    if (NVMSrvQtErrCnt > 0UL){
        retVal = BCM_ERR_UNKNOWN;
    } else {
        retVal = BCM_ERR_OK;
    }
    return retVal;
}

TASK(NVMSRVQT_Task)
{
    BCM_TestStart(BCM_SPT_ID);
    BCM_SetTestSeq(NVMSrvQtIdx);
    NVMSrvQtErrCnt = 0;

    if (BRCM_SWQTSEQ_NVM_SERVICE_SEQ0 == NVMSrvQtIdx) {
        NVMSrvQtResult = NVMSRV_TestQT1();
    } else {
        NVMSrvQtResult = BCM_ERR_UNKNOWN;
    }

    (void)BCM_TerminateTask();
}

static int32_t NVMSRV_ExecuteQtInternal(uint32_t aTestIdx)
{
    int32_t retVal;
    StatusType retOS = E_OK;
    TaskStateType taskState = SUSPENDED;
    TaskStateRefType taskStatePtr = &taskState;

    BCM_ActivateTask(NVM_Service_Task);

    retOS = GetTaskState(NVMSRVQT_Task, taskStatePtr);
    if (BCM_ERR_OK == retOS) {
        if (SUSPENDED == taskState) {
            NVMSrvQtRunState = BCM_AT_EXECUTING;
            NVMSrvQtIdx = aTestIdx;
            retVal = BCM_ActivateTask(NVMSRVQT_Task);
            if (BCM_ERR_OK != retVal) {
                retVal = BCM_AT_NOT_STARTED;
                NVMSrvQtRunState = BCM_AT_NOT_STARTED;
                ULOG_ERR("NVMSRVQT_Task activation failed, error: %d\n\r", retVal);
            }
        } else {
            retVal = BCM_AT_EXECUTING;
            ULOG_ERR("NVMSRVQT_Task is already running \n\r");
        }
    } else {
        retVal = BCM_ERR_UNKNOWN;
        ULOG_ERR("GetTaskState in NVMSRV_ExecuteQt failed Error: %d\n\r", retOS);
    }

    return retVal;
}

int32_t NVMSRV_ExecuteQt(uint32_t aTestIdx)
{
    int32_t retVal = BCM_ERR_OK;

    switch (aTestIdx) {
#ifdef BRCM_SWQTSEQ_NVM_SERVICE_SEQ0
        case BRCM_SWQTSEQ_NVM_SERVICE_SEQ0:
            retVal = NVMSRV_ExecuteQtInternal(aTestIdx);
            break;
#endif
        default:
            retVal = BCM_AT_NOT_AVAILABLE;
            break;
    }

    return retVal;
}

static int32_t NVMSRV_GetStatusQtInternal(uint32_t aTestIdx)
{
    int32_t retVal;
    StatusType retOS = E_OK;
    TaskStateType taskState = RUNNING;
    TaskStateRefType taskStatePtr = &taskState;

    if (NVMSrvQtIdx == aTestIdx) {
        retOS = GetTaskState(NVMSRVQT_Task, taskStatePtr);
        if (BCM_ERR_OK == retOS) {
            if ((SUSPENDED == taskState) &&
                (BCM_AT_EXECUTING == NVMSrvQtRunState)) {
                NVMSrvQtRunState = BCM_AT_NOT_STARTED;
                retVal = NVMSrvQtResult;
            } else {
                retVal = BCM_AT_EXECUTING;
            }
        } else {
            retVal = BCM_ERR_UNKNOWN;
            ULOG_ERR("GetTaskState in NVMSRV_GetStatusQt failed Error: %d\n\r", retOS);
        }
    } else {
        retVal = BCM_AT_NOT_AVAILABLE;
    }

    return retVal;
}

int32_t NVMSRV_GetStatusQt(uint32_t aTestIdx)
{
    int32_t retVal;

    switch (aTestIdx) {
#ifdef BRCM_SWQTSEQ_NVM_SERVICE_SEQ0
        case BRCM_SWQTSEQ_NVM_SERVICE_SEQ0:
            retVal = NVMSRV_GetStatusQtInternal(aTestIdx);
            break;
#endif
        default:
            retVal = BCM_AT_NOT_AVAILABLE;
            break;
    }

    return retVal;
}
