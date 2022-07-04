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
#include <bcm_err.h>
#include <ulog.h>
#include <bcm_utils.h>
#include <osil/bcm_osil.h>
#include <bcm_test.h>
#include <module.h>
#include <module_helper.h>
#include <bcm_utils.h>
#include <io_module_osil.h>
#include <iom_qt.h>
#include <osil/time_module_osil.h>

#define REPORT_RESULT(case, condition)                                          \
    BCM_SetTestCase(case);                                                  \
    if (condition) {                                                        \
        BCM_SetTestResult(BCM_ERR_OK);                                      \
    } else {                                                                \
        BCM_SetTestResult(BCM_ERR_UNKNOWN);                                 \
        ULOG_ERR("IOM_QT: Err case: %x, at line : %d\n", case, __LINE__);   \
        IOMQtErrCnt++;                                                      \
        break;                                                              \
    }                                                                       \

#define GetModuleLogLevel()     ULOG_LVL_INFO

static int32_t IOMQtRunState = BCM_AT_NOT_STARTED;
static uint32_t IOMQtErrCnt;
static int32_t IOMQtResult;
static uint32_t IOMQtIdx;

static const MODULE_Type* const SYSTEM_ModuleFnTables[MODULE_COUNT_MAX] = {
    &IOM_Module,
};

TASK(IOMQT_Task)
{
    int32_t retVal = BCM_ERR_OK;
    uint32_t exitTask = FALSE;
    BCM_TestStart(0);
    BCM_SetTestSeq(IOMQtIdx);
    IOMQtErrCnt = 0;

    BCM_StateType state = BCM_STATE_UNINIT;
    BCM_StateType prevState;

    IOMQtResult = BCM_ERR_OK;
    uint32_t IOM_TaskCompleted = FALSE;

    BCM_EventMaskType mask = 0UL;
    BCM_EventMaskType modMask = 0UL;

    modMask = MODULE_GetEventMask(SYSTEM_ModuleFnTables, MODULE_COUNT_MAX);

    do {
        do {
            prevState = state;
            switch(state) {
                case BCM_STATE_UNINIT:
                    retVal = MODULE_ResetStateHandler(SYSTEM_ModuleFnTables, MODULE_COUNT_MAX);
                    if (BCM_ERR_OK == retVal) {
                        state = BCM_STATE_INIT;
                    }
                    break;
                case BCM_STATE_INIT:
                    retVal = MODULE_InitStateHandler(SYSTEM_ModuleFnTables, MODULE_COUNT_MAX);
                    if (BCM_ERR_OK == retVal) {
                        state = BCM_STATE_READY;
                    }
                    break;
                case BCM_STATE_READY:
                    retVal = MODULE_ReadyStateHandler(SYSTEM_ModuleFnTables, MODULE_COUNT_MAX, BCM_STATE_RUN);
                    if (BCM_ERR_OK == retVal) {
                        state = BCM_STATE_RUN;
                    }

                    break;
                case BCM_STATE_RUN:
                    if (TRUE == IOM_TaskCompleted) {
                        retVal = MODULE_RunStateHandler(SYSTEM_ModuleFnTables, MODULE_COUNT_MAX, BCM_STATE_UNINIT);
                        if (BCM_ERR_OK == retVal) {
                            exitTask = TRUE;
                        }
                    }
                    break;
                default:
                    break;
            }
        } while (prevState != state);

        if ((retVal != BCM_ERR_OK) && (retVal != BCM_ERR_BUSY)) {
            exitTask = TRUE;
            IOMQtResult = retVal;
        }

        if (exitTask != TRUE) {
            if (BCM_STATE_RUN == state) {
#ifdef ENABLE_IOM_GPIO_MONITOR
                BCM_WaitEvent(modMask);
                BCM_GetEvent(IOMQT_Task, &mask);
                BCM_ClearEvent(mask);
                MODULE_EventHandler(SYSTEM_ModuleFnTables, MODULE_COUNT_MAX, mask);
#endif
                IOM_TaskCompleted = TRUE;
            }
        }


    } while (exitTask != TRUE);


    (void)BCM_TerminateTask();
}

static int32_t IOM_ExecuteQtInternal(uint32_t aTestIdx)
{
    int32_t retVal;
    StatusType retOS = E_OK;
    TaskStateType taskState = SUSPENDED;
    TaskStateRefType taskStatePtr = &taskState;

    retOS = GetTaskState(IOMQT_Task, taskStatePtr);
    if (BCM_ERR_OK == retOS) {
        if (SUSPENDED == taskState) {
            IOMQtRunState = BCM_AT_EXECUTING;
            IOMQtIdx = aTestIdx;
            retVal = BCM_ActivateTask(IOMQT_Task);
            if (BCM_ERR_OK != retVal) {
                retVal = BCM_AT_NOT_STARTED;
                IOMQtRunState = BCM_AT_NOT_STARTED;
                ULOG_ERR("IOMQT_Task activation failed, error: %d\n\r", retVal);
            }
        } else {
            retVal = BCM_AT_EXECUTING;
            ULOG_ERR("IOMQT_Task is already running \n\r");
        }
    } else {
        retVal = BCM_ERR_UNKNOWN;
        ULOG_ERR("GetTaskState in IOM_ExecuteQt failed Error: %d\n\r", retOS);
    }

    return retVal;
}

int32_t IOM_ExecuteQt(uint32_t aTestIdx)
{
    int32_t retVal = BCM_ERR_OK;

    switch (aTestIdx) {
        case BRCM_SWQTSEQ_IOM_0:
            retVal = IOM_ExecuteQtInternal(aTestIdx);
            break;
        default:
            retVal = BCM_AT_NOT_AVAILABLE;
            break;
    }

    return retVal;
}

static int32_t IOM_GetStatusQtInternal(uint32_t aTestIdx)
{
    int32_t retVal;
    StatusType retOS = E_OK;
    TaskStateType taskState = RUNNING;
    TaskStateRefType taskStatePtr = &taskState;

    if (IOMQtIdx == aTestIdx) {
        retOS = GetTaskState(IOMQT_Task, taskStatePtr);
        if (BCM_ERR_OK == retOS) {
            if ((SUSPENDED == taskState) &&
                    (BCM_AT_EXECUTING == IOMQtRunState)) {
                IOMQtRunState = BCM_AT_NOT_STARTED;
                retVal = IOMQtResult;
            } else {
                retVal = BCM_AT_EXECUTING;
            }
        } else {
            retVal = BCM_ERR_UNKNOWN;
            ULOG_ERR("GetTaskState in IOM_GetStatusQt failed Error: %d\n\r", retOS);
        }
    } else {
        retVal = BCM_AT_NOT_AVAILABLE;
    }

    return retVal;
}

int32_t IOM_GetStatusQt(uint32_t aTestIdx)
{
    int32_t retVal;

    switch (aTestIdx) {
        case BRCM_SWQTSEQ_IOM_0:
            retVal = IOM_GetStatusQtInternal(aTestIdx);
            break;
        default:
            retVal = BCM_AT_NOT_AVAILABLE;
            break;
    }

    return retVal;
}

