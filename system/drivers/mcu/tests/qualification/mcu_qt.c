/*****************************************************************************
 Copyright 2017-2021 Broadcom Limited.  All rights reserved.

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
#include <mcu.h>
#include <osil/bcm_osil.h>
#include <svc.h>
#include <mcu_pad_cntrl.h>
#include <bcm_test.h>
#include <mcu_test.h>
#include <mcu_switch_ext.h>
#include "mcu_qt.h"

#define EXECUTE_TEST(case, func, expecRet)                                      \
        BCM_SetTestCase(case);                                                  \
        RetVal = func;                                                          \
        if (expecRet == RetVal) {                                               \
            BCM_SetTestResult(BCM_ERR_OK);                                      \
        } else {                                                                \
            BCM_SetTestResult(BCM_ERR_UNKNOWN);                                 \
            ULOG_ERR("MCU_QT: Err case: %x, RetVal: %x at: %d\n",               \
                                            case, RetVal, __LINE__);            \
            McuQtErrCnt++;                                                      \
        }                                                                       \

#define REPORT_RESULT(case, condition)                                          \
        BCM_SetTestCase(case);                                                  \
        if (condition) {                                                        \
            BCM_SetTestResult(BCM_ERR_OK);                                      \
        } else {                                                                \
            BCM_SetTestResult(BCM_ERR_UNKNOWN);                                 \
            ULOG_ERR("MCU_QT: Err case: %x, at line : %d\n", case, __LINE__);   \
            McuQtErrCnt++;                                                      \
        }                                                                       \

#define GetModuleLogLevel()     ULOG_LVL_INFO
#define MCU_TEST     (1UL)

static int32_t McuQtRunState = BCM_AT_NOT_STARTED;
static uint32_t McuQtErrCnt;
static int32_t McuQtResult;
static uint32_t McuQtIdx;
static int32_t RetVal;

#ifdef BRCM_SWQTSEQ_MCU_MISC
static void MCU_TestMisc(void )
{
#ifdef ENABLE_MCU_PADCFG_TEST
    MCU_TEST_SVC_IOType mcuQtSvcIo;
    SVC_RunTestSvc(MCU_TEST_SVC_CMD_PADCFG_TEST, (uint8_t *)&mcuQtSvcIo);
#endif
}
#endif /* BRCM_SWQTSEQ_MCU_MISC */

#ifdef BRCM_SWQTSEQ_MCU_INIT
static void MCU_TestInit(void)
{
    MCU_VersionType version = {0};

#ifdef ENABLE_MCU_BCM8958X_TEST
    MCU_TEST_SVC_IOType mcuQtSvcIo;
    MCU_ConfigType mcuTestConfig;
    mcuQtSvcIo.config = &mcuTestConfig;
    SVC_RunTestSvc(MCU_TEST_SVC_CMD_MCU_INIT, (uint8_t *)&mcuQtSvcIo);
    REPORT_RESULT(BRCM_SWQTST_MCU_INIT, (TRUE))
#endif /* ENABLE_MCU_BCM8958X_TEST */

    MCU_GetVersion(&version);
    REPORT_RESULT(BRCM_SWQTST_MCU_GET_VERSION, ((0UL != version.manuf) &&
                                                (0UL != version.model)))
}
#endif /* BRCM_SWQTSEQ_MCU_INIT */

#ifdef BRCM_SWQTSEQ_MCU_SET_GET_INFO
static void MCU_TestSetGetInfo(void)
{
    MCU_InfoType info;

    info.stackingEn = 0U;
    info.mstSlvMode = MCU_DEVICE_MASTER;
    info.stackPort0 = 1U;
    info.stackPort1 = 2U;
    info.vlan       = 0x1234U;
    EXECUTE_TEST(BRCM_SWQTST_MCU_SET_INFO,
            MCU_SetInfo(&info), BCM_ERR_OK)
    BCM_MemSet(&info, 0U, sizeof(MCU_InfoType));
    EXECUTE_TEST(BRCM_SWQTST_MCU_GET_INFO,
            MCU_GetInfo(&info), BCM_ERR_OK)
    REPORT_RESULT(BRCM_SWQTST_MCU_GET_INFO,
            ((0x1234U == info.vlan) && (2U == info.stackPort1)))
}
#endif /* BRCM_SWQTSEQ_MCU_SET_GET_INFO */

#ifdef BRCM_SWQTSEQ_MCU_SET_NETWORK
void MCU_TestSetNetwork(void)
{
#ifdef ENABLE_MCU_BCM8958X_TEST
    EXECUTE_TEST(BRCM_SWQTST_MCU_ENABLE_NETWORK_PORT,
        MCU_EnableEthTraffic(), BCM_ERR_OK)

    EXECUTE_TEST(BRCM_SWQTST_MCU_DISABLE_NETWORK_PORT,
        MCU_DisableEthTraffic(), BCM_ERR_OK)
#endif /* ENABLE_MCU_BCM8958X_TEST */
}
#endif /* BRCM_SWQTSEQ_MCU_SET_NETWORK */

TASK(MCUQT_Task)
{
    BCM_TestStart(BCM_MCU_ID);
    BCM_SetTestSeq(McuQtIdx);
    McuQtErrCnt = 0;

    McuQtResult = BCM_ERR_OK;

    switch (McuQtIdx) {
#ifdef BRCM_SWQTSEQ_MCU_INIT
        case BRCM_SWQTSEQ_MCU_INIT:
            MCU_TestInit();
            break;
#endif
#ifdef BRCM_SWQTSEQ_MCU_SET_GET_INFO
        case BRCM_SWQTSEQ_MCU_SET_GET_INFO:
            MCU_TestSetGetInfo();
            break;
#endif
#ifdef BRCM_SWQTSEQ_MCU_SET_NETWORK
        case BRCM_SWQTSEQ_MCU_SET_NETWORK:
            MCU_TestSetNetwork();
            break;
#endif
#ifdef BRCM_SWQTSEQ_MCU_MISC
        case BRCM_SWQTSEQ_MCU_MISC:
            MCU_TestMisc();
            break;
#endif
        default:
            McuQtResult = BCM_ERR_UNKNOWN;
            break;
    }

    (void)BCM_TerminateTask();
}

static int32_t MCU_ExecuteQtInternal(uint32_t aTestIdx)
{
    int32_t retVal;
    StatusType retOS = E_OK;
    TaskStateType taskState = SUSPENDED;
    TaskStateRefType taskStatePtr = &taskState;

    retOS = GetTaskState(MCUQT_Task, taskStatePtr);
    if (BCM_ERR_OK == retOS) {
        if (SUSPENDED == taskState) {
            McuQtRunState = BCM_AT_EXECUTING;
            McuQtIdx = aTestIdx;
            retVal = BCM_ActivateTask(MCUQT_Task);
            if (BCM_ERR_OK != retVal) {
                retVal = BCM_AT_NOT_STARTED;
                McuQtRunState = BCM_AT_NOT_STARTED;
                ULOG_ERR("MCUQT_Task activation failed, error: %d\n\r", retVal);
            }
        } else {
            retVal = BCM_AT_EXECUTING;
            ULOG_ERR("MCUQT_Task is already running \n\r");
        }
    } else {
        retVal = BCM_ERR_UNKNOWN;
        ULOG_ERR("GetTaskState in MCU_ExecuteQt failed Error: %d\n\r", retOS);
    }

    return retVal;
}

int32_t MCU_ExecuteQt(uint32_t aTestIdx)
{
    int32_t retVal = BCM_ERR_OK;

    switch (aTestIdx) {
#ifdef BRCM_SWQTSEQ_MCU_INIT
        case BRCM_SWQTSEQ_MCU_INIT:
            retVal = MCU_ExecuteQtInternal(aTestIdx);
            break;
#endif
#ifdef BRCM_SWQTSEQ_MCU_SET_GET_INFO
        case BRCM_SWQTSEQ_MCU_SET_GET_INFO:
            retVal = MCU_ExecuteQtInternal(aTestIdx);
            break;
#endif
#ifdef BRCM_SWQTSEQ_MCU_SET_NETWORK
        case BRCM_SWQTSEQ_MCU_SET_NETWORK:
            retVal = MCU_ExecuteQtInternal(aTestIdx);
            break;
#endif
#ifdef BRCM_SWQTSEQ_MCU_MISC
        case BRCM_SWQTSEQ_MCU_MISC:
            retVal = MCU_ExecuteQtInternal(aTestIdx);
            break;
#endif
        default:
            retVal = BCM_AT_NOT_AVAILABLE;
            break;
    }

    return retVal;
}

static int32_t MCU_GetStatusQtInternal(uint32_t aTestIdx)
{
    int32_t retVal;
    StatusType retOS = E_OK;
    TaskStateType taskState = RUNNING;
    TaskStateRefType taskStatePtr = &taskState;

    if (McuQtIdx == aTestIdx) {
        retOS = GetTaskState(MCUQT_Task, taskStatePtr);
        if (BCM_ERR_OK == retOS) {
            if ((SUSPENDED == taskState) &&
                (BCM_AT_EXECUTING == McuQtRunState)) {
                McuQtRunState = BCM_AT_NOT_STARTED;
                retVal = McuQtResult;
            } else {
                retVal = BCM_AT_EXECUTING;
            }
        } else {
            retVal = BCM_ERR_UNKNOWN;
            ULOG_ERR("GetTaskState in MCU_GetStatusQt failed Error: %d\n\r", retOS);
        }
    } else {
        retVal = BCM_AT_NOT_AVAILABLE;
    }

    return retVal;
}

int32_t MCU_GetStatusQt(uint32_t aTestIdx)
{
    int32_t retVal;

    switch (aTestIdx) {
#ifdef BRCM_SWQTSEQ_MCU_INIT
        case BRCM_SWQTSEQ_MCU_INIT:
            retVal = MCU_GetStatusQtInternal(aTestIdx);
            break;
#endif
#ifdef BRCM_SWQTSEQ_MCU_SET_GET_INFO
        case BRCM_SWQTSEQ_MCU_SET_GET_INFO:
            retVal = MCU_GetStatusQtInternal(aTestIdx);
            break;
#endif
#ifdef BRCM_SWQTSEQ_MCU_SET_NETWORK
        case BRCM_SWQTSEQ_MCU_SET_NETWORK:
            retVal = MCU_GetStatusQtInternal(aTestIdx);
            break;
#endif
#ifdef BRCM_SWQTSEQ_MCU_MISC
        case BRCM_SWQTSEQ_MCU_MISC:
            retVal = MCU_GetStatusQtInternal(aTestIdx);
            break;
#endif
        default:
            retVal = BCM_AT_NOT_AVAILABLE;
            break;
    }

    return retVal;
}
