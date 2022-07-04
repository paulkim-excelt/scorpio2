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
#include <io_service_osil.h>
#include <io_service.h>

#include "io_service_test.h"
#include "io_service_qt.h"

#define GetModuleLogLevel()     ULOG_LVL_ERROR

#define CALL(func)                                                               \
        retVal = func;                                                           \
        if (BCM_ERR_OK != retVal) {                                              \
            IOSrvQtResult = retVal;                                             \
            IOSrvQtErrCnt++;                                                    \
        }                                                                        \

#define EXECUTE_TEST(case, func, expecRet)                                       \
        BCM_SetTestCase(case);                                                   \
        retVal = func;                                                           \
        if (expecRet == retVal) {                                                \
            BCM_SetTestResult(BCM_ERR_OK);                                       \
        } else {                                                                 \
            BCM_SetTestResult(BCM_ERR_UNKNOWN);                                  \
            ULOG_ERR("IOSRV_QT: Err case: %x, retVal: %x at: %d\n",             \
                                            case, retVal, __LINE__);             \
            IOSrvQtErrCnt++;                                                    \
        }                                                                        \

#define REPORT_RESULT(case, condition)                                           \
        BCM_SetTestCase(case);                                                   \
        if (condition) {                                                         \
            BCM_SetTestResult(BCM_ERR_OK);                                       \
        } else {                                                                 \
            BCM_SetTestResult(BCM_ERR_UNKNOWN);                                  \
            ULOG_ERR("IOSRV_QT: Err case: %x, at line : %d\n", case, __LINE__); \
            IOSrvQtErrCnt++;                                                    \
            goto bcm_err;                                                        \
        }                                                                        \

static int32_t  IOSrvQtRunState = BCM_AT_NOT_STARTED;
static uint32_t IOSrvQtIdx      = 0UL;
static int32_t  IOSrvQtResult;
static uint32_t IOSrvQtErrCnt;

#define IOSRV_QT_BUFF_SIZE            256U
typedef struct sMODULE_QtMsgContextType {
    BCM_SubStateType  substate;
    uint32_t          val;
} MODULE_QtMsgContextType;

typedef struct sIOSRV_QtHelperCtxType {
    MODULE_QtMsgContextType modCtx;     /**< @brief Module's Context */
    BCM_CmdType cmd;                    /**< @brief command which is in process */
    uint8_t buff[IOSRV_QT_BUFF_SIZE];   /**< @brief Buffer to store the file data */
} IOSRV_QtHelperCtxType;

static int32_t IOSRV_TestQT1(void)
{
    int32_t retVal = BCM_ERR_OK;
    IOSRV_QtHelperCtxType IOSRV_QtHelperCtx;
    BCM_HandleType handle;
    uint32_t forwardToSlaves;
    uint32_t replyLen;
    uint32_t mask;
    /* Since there are no modules added to this empty service framework,
       there will be no handler to catch this message and execute requested action,
       hence the testcases are implemented to test only the empty service framework */

    /* Once the desired modules are added the below test cases should be updated accordingly */

    do {
        retVal = IOS_SERVICE.client.resetStateHandler(BCM_STATE_INIT);
        if (retVal == BCM_ERR_BUSY) {
            (void)BCM_WaitEvent(MODULE_EVENT);
            (void)BCM_GetEvent(IOSRVQT_Task, &mask);
            (void)BCM_ClearEvent(mask);
        } else {
            REPORT_RESULT(BRCM_SWQTST_IOSRV_CLIENT_INIT,
                          retVal == BCM_ERR_OK)
            break;
        }
    } while (retVal == BCM_ERR_BUSY);

    do {
        retVal = IOS_SERVICE.client.initStateHandler(BCM_STATE_READY);
        if (retVal == BCM_ERR_BUSY) {
            (void)BCM_WaitEvent(MODULE_EVENT);
            (void)BCM_GetEvent(IOSRVQT_Task, &mask);
            (void)BCM_ClearEvent(mask);
        } else {
            REPORT_RESULT(BRCM_SWQTST_IOSRV_CLIENT_READY,
                          retVal == BCM_ERR_OK)
            break;
        }
    } while (retVal == BCM_ERR_BUSY);

    do {
        retVal = IOS_SERVICE.client.readyStateHandler(BCM_STATE_RUN);
        if (retVal == BCM_ERR_BUSY) {
            (void)BCM_WaitEvent(MODULE_EVENT);
            (void)BCM_GetEvent(IOSRVQT_Task, &mask);
            (void)BCM_ClearEvent(mask);
        } else {
            REPORT_RESULT(BRCM_SWQTST_IOSRV_CLIENT_READY_TO_RUN,
                          retVal == BCM_ERR_OK)
            break;
        }
    } while (retVal == BCM_ERR_BUSY);

    IOSRV_QtHelperCtx.cmd = 1U;
    EXECUTE_TEST(BRCM_SWQTST_IOSRV_SERVER_SEND_CMD_NOSUPPORT,
                 IOS_SERVICE.server.sendCmd(BCM_CMDID(BCM_GROUPID_IO, BCM_BCP_ID, 1U),
                                      IOSRV_QT_BUFF_SIZE,
                                      (const uint8_t*)&IOSRV_QtHelperCtx,
                                      &handle,
                                      &forwardToSlaves),
                 BCM_ERR_NOSUPPORT)

    EXECUTE_TEST(BRCM_SWQTST_IOSRV_SERVER_GET_RESP_NOSUPPORT,
                 IOS_SERVICE.server.getResp(handle,
                                      BCM_CMDID(BCM_GROUPID_IO, BCM_BCP_ID, 1U),
                                      IOSRV_QT_BUFF_SIZE,
                                      (uint8_t*)&IOSRV_QtHelperCtx,
                                      &replyLen),
                 BCM_ERR_NOSUPPORT)

    do {
        retVal = IOS_SERVICE.client.runStateHandler(BCM_STATE_READY);
        if (retVal == BCM_ERR_BUSY) {
            (void)BCM_WaitEvent(MODULE_EVENT);
            (void)BCM_GetEvent(IOSRVQT_Task, &mask);
            (void)BCM_ClearEvent(mask);
        } else {
            REPORT_RESULT(BRCM_SWQTST_IOSRV_CLIENT_RUN_TO_READY,
                          retVal == BCM_ERR_OK)
            break;
        }
    } while (retVal == BCM_ERR_BUSY);

    do {
        retVal = IOS_SERVICE.client.readyStateHandler(BCM_STATE_UNINIT);
        if (retVal == BCM_ERR_BUSY) {
            (void)BCM_WaitEvent(MODULE_EVENT);
            (void)BCM_GetEvent(IOSRVQT_Task, &mask);
            (void)BCM_ClearEvent(mask);
        } else {
            REPORT_RESULT(BRCM_SWQTST_IOSRV_CLIENT_UINIT,
                          retVal == BCM_ERR_OK)
            break;
        }
    } while (retVal == BCM_ERR_BUSY);

bcm_err:

    if (IOSrvQtErrCnt > 0UL){
        retVal = BCM_ERR_UNKNOWN;
    } else {
        retVal = BCM_ERR_OK;
    }
    return retVal;
}

TASK(IOSRVQT_Task)
{
    BCM_TestStart(BCM_SPT_ID);
    BCM_SetTestSeq(IOSrvQtIdx);
    IOSrvQtErrCnt = 0;

    if (BRCM_SWQTSEQ_IOSRV_SEQ0 == IOSrvQtIdx) {
        IOSrvQtResult = IOSRV_TestQT1();
    } else {
        IOSrvQtResult = BCM_ERR_UNKNOWN;
    }

    (void)BCM_TerminateTask();
}

static int32_t IOSRV_ExecuteQtInternal(uint32_t aTestIdx)
{
    int32_t retVal;
    StatusType retOS = E_OK;
    TaskStateType taskState = SUSPENDED;
    TaskStateRefType taskStatePtr = &taskState;

    retOS = GetTaskState(IOSRVQT_Task, taskStatePtr);
    if (BCM_ERR_OK == retOS) {
        if (SUSPENDED == taskState) {
            IOSrvQtRunState = BCM_AT_EXECUTING;
            IOSrvQtIdx = aTestIdx;
            retVal = BCM_ActivateTask(IOSRVQT_Task);
            if (BCM_ERR_OK != retVal) {
                retVal = BCM_AT_NOT_STARTED;
                IOSrvQtRunState = BCM_AT_NOT_STARTED;
                ULOG_ERR("IOSRVQT_Task activation failed, error: %d\n\r", retVal);
            }
        } else {
            retVal = BCM_AT_EXECUTING;
            ULOG_ERR("IOSRVQT_Task is already running \n\r");
        }
    } else {
        retVal = BCM_ERR_UNKNOWN;
        ULOG_ERR("GetTaskState in IOSRV_ExecuteQt failed Error: %d\n\r", retOS);
    }

    return retVal;
}

int32_t IOSRV_ExecuteQt(uint32_t aTestIdx)
{
    int32_t retVal = BCM_ERR_OK;

    switch (aTestIdx) {
#ifdef BRCM_SWQTSEQ_IOSRV_SEQ0
        case BRCM_SWQTSEQ_IOSRV_SEQ0:
            retVal = IOSRV_ExecuteQtInternal(aTestIdx);
            break;
#endif
        default:
            retVal = BCM_AT_NOT_AVAILABLE;
            break;
    }

    return retVal;
}

static int32_t IOSRV_GetStatusQtInternal(uint32_t aTestIdx)
{
    int32_t retVal;
    StatusType retOS = E_OK;
    TaskStateType taskState = RUNNING;
    TaskStateRefType taskStatePtr = &taskState;

    if (IOSrvQtIdx == aTestIdx) {
        retOS = GetTaskState(IOSRVQT_Task, taskStatePtr);
        if (BCM_ERR_OK == retOS) {
            if ((SUSPENDED == taskState) &&
                (BCM_AT_EXECUTING == IOSrvQtRunState)) {
                IOSrvQtRunState = BCM_AT_NOT_STARTED;
                retVal = IOSrvQtResult;
            } else {
                retVal = BCM_AT_EXECUTING;
            }
        } else {
            retVal = BCM_ERR_UNKNOWN;
            ULOG_ERR("GetTaskState in IOSRV_GetStatusQt failed Error: %d\n\r", retOS);
        }
    } else {
        retVal = BCM_AT_NOT_AVAILABLE;
    }

    return retVal;
}

int32_t IOSRV_GetStatusQt(uint32_t aTestIdx)
{
    int32_t retVal;

    switch (aTestIdx) {
#ifdef BRCM_SWQTSEQ_IOSRV_SEQ0
        case BRCM_SWQTSEQ_IOSRV_SEQ0:
            retVal = IOSRV_GetStatusQtInternal(aTestIdx);
            break;
#endif
        default:
            retVal = BCM_AT_NOT_AVAILABLE;
            break;
    }

    return retVal;
}