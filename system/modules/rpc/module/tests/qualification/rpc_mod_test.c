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
#include <rpc_module_v2.h>
#include <rpc_mod_test.h>

#define GetModuleLogLevel()         (ULOG_LVL_INFO)

static uint32_t RPC_ModuleTestIndex;
static int32_t RPC_ModuleTestResult = BCM_AT_NOT_STARTED;

static int32_t RPC_ModuleTestSequence0 (void)
{
    int32_t retVal;
    uint32_t eventMask = 0UL;

    BCM_StateType state = BCM_STATE_UNINIT;

    retVal = RPC_Module.resetStateHandler(state);

    if(BCM_ERR_OK == retVal) {
        state = BCM_STATE_INIT;
        retVal = RPC_Module.runStateHandler(state);
    }

    if(BCM_ERR_OK == retVal) {
        eventMask = RPC_Module.getEventMask();
        if(eventMask != 0UL) {
            RPC_Module.eventHandler(eventMask);
            state = BCM_STATE_UNINIT;
            retVal = RPC_Module.readyStateHandler(state);
        } else {
            retVal = BCM_ERR_UNKNOWN;
        }
    }

    return retVal;
}

static int32_t RPC_ModuleTestSequence1 (void)
{
    int32_t retVal;

    BCM_StateType state = BCM_STATE_UNINIT;

    /* Verify with initialization Error */
    retVal = RPC_Module.resetStateHandler(state);
    if(BCM_ERR_UNKNOWN == retVal) {
        RPC_Module.eventHandler(0UL);
        retVal = BCM_ERR_OK;
    }

    return retVal;
}

TASK(RPC_ModTestTask)
{
    int32_t retVal;

    if(RPC_MODULE_TEST1 == RPC_ModuleTestIndex) {
        /* All Positive Test case */
        RPC_ModTestFlag = RPC_MODTESTFLAG_1;
        retVal = RPC_ModuleTestSequence0();
    } else if(RPC_MODULE_TEST2 == RPC_ModuleTestIndex){
        /* RPC_MODTESTFLAG_2: Valid message handle on Slave recvMsg
                            : Valid detect stream on slave
                            : Valid Process stream on slave
                            : Valid message handle on Master recvMsg
                            : Valid detect stream on Master
                            : Valid Process stream on slave    */
        RPC_ModTestFlag = RPC_MODTESTFLAG_2;
        retVal = RPC_ModuleTestSequence0();
    } else if(RPC_MODULE_TEST3 == RPC_ModuleTestIndex){
        /* RPC_MODTESTFLAG_3: Detect stream on master
                            : return error on master process stream
                            : Detect stream error on slave
                            : Process stream error on master  */
        RPC_ModTestFlag = RPC_MODTESTFLAG_3;
        retVal = RPC_ModuleTestSequence0();
    } else if(RPC_MODULE_TEST4 == RPC_ModuleTestIndex){
       /* RPC_MODTESTFLAG_4: return error as UNKNOWN while initialize */
        RPC_ModTestFlag = RPC_MODTESTFLAG_4;
        retVal = RPC_ModuleTestSequence1();
    } else if(RPC_MODULE_TEST5 == RPC_ModuleTestIndex){
       /* RPC_MODTESTFLAG_5 : set the interfaces as NULL */
        RPC_ModTestFlag = RPC_MODTESTFLAG_5;
        /* Call all Functions with interfaces as NULL */
        retVal = RPC_ModuleTestSequence0();
    } else {
        retVal = BCM_ERR_UNKNOWN;
    }

    if(BCM_AT_EXECUTING == RPC_ModuleTestResult) {
        RPC_ModuleTestResult = retVal;
    }
    ULOG_ERR("\n Test %d completed\n", RPC_ModuleTestIndex);
    (void)BCM_TerminateTask();
}

int32_t BCM_ExecuteAT(uint32_t aIndex)
{
    int32_t retVal;

    if ((RPC_MODULE_TEST_MAX >= aIndex) && (0UL < aIndex)) {
        if (BCM_AT_EXECUTING != RPC_ModuleTestResult) {
            RPC_ModuleTestIndex = aIndex;
            RPC_ModuleTestResult = BCM_AT_EXECUTING;
            retVal = (int32_t)BCM_ActivateTask(RPC_ModTestTask);
            if (BCM_ERR_OK != retVal) {
                ULOG_ERR("%s:%d Activation failed Err:%d\n", __func__, __LINE__, retVal);
                RPC_ModuleTestResult = BCM_AT_NOT_STARTED;
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

    if ((RPC_MODULE_TEST_MAX >= aIndex) && (0UL < aIndex)) {
        if(RPC_ModuleTestIndex == aIndex) {
            retVal = RPC_ModuleTestResult;
        }
    }
    return retVal;
}

void APP_Init(void)
{
    /* Dummy Init */
}
