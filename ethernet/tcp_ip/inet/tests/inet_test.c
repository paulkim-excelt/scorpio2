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

#include <ee.h>
#include <bcm_test.h>
#include <ulog.h>
#include <bcm_err.h>
#include <bcm_time.h>
#include <bcm_osil.h>
#include <shell.h>
#include <inet_test.h>
#include "dhcp.h"
#include <module_helper.h>
#include <time_module_osil.h>
#include <inet_cfg.h>
#include <nif.h>
#include <netif.h>
#include <inet_osil.h>

#define GetModuleLogLevel()  ULOG_LVL_ERROR
#ifndef SYSTEM_TASK_INET_TEST
const MODULE_Type* const SYS_ModuleFnTable[MODULE_COUNT_MAX] = {
    &TIME_Module,
};
#endif

static uint32_t INET_CurrentTest;
static int32_t INET_CurrentState = BCM_AT_NOT_STARTED;

void SVC_TestSvcHandler(uint32_t aMagicID, uint32_t aCmd, uint8_t *aSysIO)
{
    NIF_TEST_SVC_IOType *ethTstSvc;
    ethTstSvc = (NIF_TEST_SVC_IOType *)aSysIO;

    switch(aCmd) {
    case NIF_TEST_SVC_CMD_IRQ_HANDLER:
        ETHER_IntIRQHandler(ethTstSvc->id, ethTstSvc->irqEventMap);
        ethTstSvc->retVal = BCM_ERR_OK;
        break;
    default:
        ethTstSvc->retVal = BCM_ERR_INVAL_PARAMS;
        break;
    }
}

int32_t INET_TestCommonInit(const uint8_t *aMac, const ETHER_CfgType *aEthCfg)
{
    static uint32_t init = FALSE;
    int32_t retVal;

    ETHER_Init(ETHER_HW_ID_0, aEthCfg);

    /* Loopback at UNIMAC level */
    ETHER_EnableLoopBack(ETHER_HW_ID_0);

    retVal = ETHER_SetMacAddr(ETHER_HW_ID_0, aMac);
    if (BCM_ERR_OK != retVal) {
        goto done;
    }

    retVal = ETHER_SetMode(ETHER_HW_ID_0, ETHER_MODE_ACTIVE);
    if (BCM_ERR_OK != retVal) {
        goto done;
    }

    if (TRUE != init) {
        retVal = NIF_Init();
        if (BCM_ERR_OK != retVal) {
            goto done;
        }

        INET_Init();
        init = TRUE;
    }

done:
    return retVal;
}

int32_t INET_TestCommonDeInit(void)
{
    int32_t retVal;

    retVal = ETHER_DeInit(ETHER_HW_ID_0);

    return retVal;
}

TASK(Test1Task)
{
    int32_t ret;
#ifndef SYSTEM_TASK_INET_TEST
    /* Start timer module (UNINIT->INIT)*/
    ret = MODULE_ResetStateHandler(SYS_ModuleFnTable,1UL);
    if (BCM_STATE_INIT != TIME_Module.context->state) {
        goto err;
    }
#endif
    switch (INET_CurrentTest) {
    case INET_UDP_QT:
        ret = UDP_ExecuteQT();
        break;
#ifdef ENABLE_INET_IT
    case INET_IT:
        ret = INET_ExecuteIT();
        break;
    case INET_DHCP_IT:
        ret = DHCP_ExecuteIT();
        break;
#endif
    default:
        ret = BCM_ERR_UNKNOWN;
        break;
    }

#ifndef SYSTEM_TASK_INET_TEST
err:
#endif
    INET_CurrentState = ret;

    (void)BCM_TerminateTask();
}

int32_t BCM_ExecuteAT(uint32_t aIndex)
{
    int32_t ret;
    StatusType retOS = E_OK;
    TaskStateType taskState = SUSPENDED;

    switch(aIndex)
    {
    case INET_UDP_QT:
#ifdef ENABLE_INET_IT
    case INET_IT:
    case INET_DHCP_IT:
#endif
        retOS = GetTaskState(Test1Task, &taskState);
        if (E_OK == retOS) {
            if (SUSPENDED == taskState) {
                INET_CurrentTest = aIndex;
                if (BCM_AT_EXECUTING != INET_CurrentState) {
                    INET_CurrentState = BCM_AT_EXECUTING;
                    ret = BCM_ActivateTask(Test1Task);
                    if (BCM_ERR_OK != ret) {
                        INET_CurrentState = BCM_AT_NOT_STARTED;
                        ULOG_ERR("Task activation failed, error: %d\n", ret);
                    }
                }
                ret = BCM_ERR_OK;
            } else {
                INET_CurrentState = BCM_AT_EXECUTING;
                ULOG_ERR("Test is already running\n");
                ret = BCM_ERR_OK;
            }
        } else {
            ret = BCM_ERR_UNKNOWN;
        }
        break;
    default:
        ret = BCM_AT_NOT_AVAILABLE;
        break;
    }

    return ret;
}

int32_t BCM_GetResultAT(uint32_t aIndex)
{
    int32_t ret;

    switch (aIndex) {
    case INET_UDP_QT:
        ret = UDP_GetResultQT();
        break;
#ifdef ENABLE_INET_IT
    case INET_IT:
        ret = INET_GetResultIT();
        break;
    case INET_DHCP_IT:
        ret = DHCP_GetResultIT();
        break;
#endif
    default:
        ret = BCM_AT_NOT_AVAILABLE;
        break;
    }

    return ret;
}

void DHCPTest_Timeout_Callback(void)
{
    (void)SetEvent(Test1Task, SystemEvent4);
}

void DHCP_OfferReceivedCallback(uint32_t aOfferNum)
{
    (void)DHCP_SelectOffer(aOfferNum);
}

void DHCP_BoundCallback(void)
{
    (void)BCM_SetEvent(Test1Task, SystemEvent1);
}

void DHCP_UnBoundCallback(void)
{
}
