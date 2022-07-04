/*****************************************************************************
 Copyright 2019-2022 Broadcom Limited.  All rights reserved.

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

#include <stdlib.h>
#include <string.h>

#include "ee.h"
#include "eecfg.h"

#include <ulog.h>
#include <bcm_err.h>
#include <console.h>
#include <bcm_test.h>
#include <bcm_utils.h>
#include <osil/bcm_osil.h>

#include "wdg.h"
#include "wdg_osil.h"
#include <wdt.h>
#include "wdg_test.h"

#define GetModuleLogLevel() ULOG_LVL_VERBOSE

#define WDG_QT  (1UL)
#ifdef ENABLE_INTEGRATION_TEST
#define WDG_IT  (2UL)
#endif /* ENABLE_INTEGRATION_TEST */

static volatile int32_t wdg_qt1_result = BCM_AT_NOT_STARTED;
static volatile int8_t wdgMonitorError = 0U;

static const uint8_t Test_SE_1_graph[3U][1U] = {{1U},{2U},{0U}};
static const uint8_t Test_SE_2_graph[4U][2U] = {{1U, 2U}, {2U, 3U}, {3U, WDG_INVALID_GRAPH_BUF_ENTRY}, {0U, WDG_INVALID_GRAPH_BUF_ENTRY}};
static const uint8_t Test_SE_3_graph[1U][1U] = {{0U}};

void WDG_QT_ErrCallback(const char * aName, int32_t aError,
                       const WDG_MonitorType *aMonitor, uint32_t aMaxAllowedErrors)
{
    wdgMonitorError = 1U;
    ULOG_ERR("WDG QT > Name %s aError 0x%x \n",aName,aError);
}

uint64_t countAlarm = 0ULL;
void WDGTestAlarm_cb()
{
    if (countAlarm % 2UL == 0UL) {
        (void)SetEvent(WDGTest1, SystemEvent0);
        (void)SetEvent(WDGTest2, SystemEvent0);
        (void)SetEvent(WDGTest3, SystemEvent0);
    }
    if (countAlarm % 5UL == 0UL) {
        (void)SetEvent(WDGTestMonitor, SystemEvent0);
    }
    countAlarm++;
}

TASK(WDGTest1)
{
    int32_t retVal = BCM_ERR_OK;
    uint8_t count = 0U;
    BCM_EventMaskType mask = 0UL;
    WDG_ConfigType seConfig11 = {WDG_MODE_LOGICAL, 60UL, 2UL, 3UL, 0U, 2U};

    BCM_MemCpy(SE1.buffer, Test_SE_1_graph, sizeof(Test_SE_1_graph));

    retVal = WDG_EnableSE(&SE1, &seConfig11);
    if (BCM_ERR_OK != retVal) {
        ULOG_ERR("WDG_EnableSE 0 Failed %x \n",retVal);
        wdg_qt1_result = retVal;
        goto error;
    }

    /* Clear any pending event */
    (void)BCM_GetEvent(WDGTest1, &mask);
    (void)BCM_ClearEvent(mask);

    while (1) {
        (void)BCM_WaitEvent(SystemEvent0);
        (void)BCM_GetEvent(WDGTest1, &mask);
        (void)BCM_ClearEvent(mask);

        if (countAlarm >= 100UL) {
            break;
        }

        for (count = 0U; count < SE1.maxState; count++) {
            retVal = WDG_NotifyState(&SE1, count);
            if (BCM_ERR_OK != retVal) {
                ULOG_ERR("WDG_NotifyState Failed %x \n",retVal);
                wdg_qt1_result = retVal;
                goto error;
            }
        }
    }

    retVal = WDG_DisableSE(&SE1);
    if (BCM_ERR_OK != retVal) {
        ULOG_ERR("WDG_DisableSE 0 Failed %x \n",retVal);
        wdg_qt1_result = retVal;
        goto error;
    }

error:
    BCM_TerminateTask();
}

TASK(WDGTest2)
{
    int32_t retVal = BCM_ERR_OK;
    uint8_t count = 0U;
    BCM_EventMaskType mask = 0UL;
    uint32_t negativeTest = 0UL;
    WDG_ConfigType seConfig12 = {WDG_MODE_FREQ | WDG_MODE_LOGICAL | WDG_MODE_DEADLINE, 60UL, 2UL, 3UL, 0U, 3U};

    uint32_t Test_SE_12_cnt = 0UL;
    uint8_t Test_SE_12_state[3][5] = {{0U, 2U, 3U, 0xFFU, 0xFFU},
                                      {0U, 1U, 3U, 0xFFU, 0xFFU},
                                      {0U, 1U, 2U, 3U,    0xFFU}};

    BCM_MemCpy(SE2.buffer, Test_SE_2_graph, sizeof(Test_SE_2_graph));

    retVal = WDG_EnableSE(&SE2, &seConfig12);
    if (BCM_ERR_OK != retVal) {
        ULOG_ERR("WDG_EnableSE 1 Failed %x \n",retVal);
        wdg_qt1_result = retVal;
        goto error;
    }

    /* Clear any pending event */
    (void)BCM_GetEvent(WDGTest2, &mask);
    (void)BCM_ClearEvent(mask);

    while (1) {
        (void)BCM_WaitEvent(SystemEvent0);
        (void)BCM_GetEvent(WDGTest2, &mask);
        (void)BCM_ClearEvent(mask);

        if (countAlarm >= 100UL) {
            /* Start negative test cases */
            if (0UL == negativeTest) {
                ULOG_ERR("WDG_QT > Start of negative tests (error logs are expected) \n",retVal);
                negativeTest = 1UL;
                retVal = WDG_NotifyState(&SE2, 0U);
                if (BCM_ERR_OK == retVal) {
                    /* Notify an invalid checkpoint for logical error detection */
                    retVal = WDG_NotifyState(&SE2, 3U);
                    if (BCM_ERR_OK == retVal) {
                        /* Notify start checkpoint for deadline monitoring to start */
                        retVal = WDG_NotifyState(&SE2, 0U);
                        if (BCM_ERR_OK == retVal) {
                            retVal = WDG_NotifyState(&SE2, 2U);
                        }
                    }
                }
                if (BCM_ERR_OK != retVal) {
                    wdg_qt1_result = retVal;
                    goto error;
                }
            } else {
                if (countAlarm >= 120UL) {
                    break;
                } else {
                    continue;
                }
            }
        }

        for (count = 0U; (count < SE2.maxState) && (0UL == negativeTest); count++) {
            uint8_t gState = Test_SE_12_state[Test_SE_12_cnt][count];
            if (0xFFU != gState) {
                retVal = WDG_NotifyState(&SE2, gState);
                if (BCM_ERR_OK != retVal) {
                    ULOG_ERR("WDG_NotifyState Failed %x \n",retVal);
                    wdg_qt1_result = retVal;
                    goto error;
                }
            }
        }
        Test_SE_12_cnt = (Test_SE_12_cnt+1UL) % 3UL;
    }

    retVal = WDG_DisableSE(&SE2);
    if (BCM_ERR_OK != retVal) {
        ULOG_ERR("WDG_DisableSE 1 Failed %x \n",retVal);
        wdg_qt1_result = retVal;
        goto error;
    }

error:
    BCM_TerminateTask();
}

TASK(WDGTest3)
{
    int32_t retVal = BCM_ERR_OK;
    uint8_t count = 0U;
    BCM_EventMaskType mask = 0UL;
    WDG_ConfigType seConfig13 = {WDG_MODE_FREQ | WDG_MODE_LOGICAL | WDG_MODE_DEADLINE, 60UL, 2UL, 3UL, 0U, 0U};

    BCM_MemCpy(SE3.buffer, Test_SE_3_graph, sizeof(Test_SE_3_graph));

    retVal = WDG_EnableSE(&SE3, &seConfig13);
    if (BCM_ERR_OK != retVal) {
        ULOG_ERR("WDG_EnableSE 0 Failed %x \n",retVal);
        wdg_qt1_result = retVal;
        goto error;
    }

    /* Clear any pending event */
    (void)BCM_GetEvent(WDGTest3, &mask);
    (void)BCM_ClearEvent(mask);

    while (1) {
        (void)BCM_WaitEvent(SystemEvent0);
        (void)BCM_GetEvent(WDGTest3, &mask);
        (void)BCM_ClearEvent(mask);

        if (countAlarm >= 100UL) {
            break;
        }

        for (count = 0U; count < SE3.maxState; count++) {
            retVal = WDG_NotifyState(&SE3, count);
            if (BCM_ERR_OK != retVal) {
                ULOG_ERR("WDG_NotifyState Failed %x \n",retVal);
                wdg_qt1_result = retVal;
                goto error;
            }
        }
    }

    retVal = WDG_DisableSE(&SE3);
    if (BCM_ERR_OK != retVal) {
        ULOG_ERR("WDG_DisableSE 0 Failed %x \n",retVal);
        wdg_qt1_result = retVal;
        goto error;
    }

error:
    BCM_TerminateTask();
}

TASK(WDGTestMonitor)
{
    int32_t retVal = BCM_ERR_OK;
    BCM_EventMaskType mask = 0UL;
    uint32_t negativeTest = 0UL;

    /* Enable the WDT driver to active state */
    retVal = WDT_SetMode(0UL, WDT_MODE_ACTIVE);
    if (BCM_ERR_OK != retVal) {
        ULOG_ERR("WDT_SetMode Failed %x \n",retVal);
        wdg_qt1_result = retVal;
        goto error;
    }

    /* Set the WDT timer duration based on the configuration to WDG */
    retVal = WDT_SetTriggerCondition(0UL, WDG_CHECK_TIME_US/1000UL);
    if (BCM_ERR_OK != retVal) {
        ULOG_ERR("WDT_SetTriggerCondition Failed %x \n",retVal);
        wdg_qt1_result = retVal;
        goto error;
    }

    retVal = WDG_Module.resetStateHandler(BCM_STATE_INIT);
    if (BCM_ERR_OK != retVal) {
        ULOG_ERR("WDG_Init Failed %x \n",retVal);
        wdg_qt1_result = retVal;
        goto error;
    }

    /* Clear any pending event */
    (void)BCM_GetEvent(WDGTestMonitor, &mask);
    (void)BCM_ClearEvent(mask);

    while (1) {
        (void)BCM_WaitEvent(SystemEvent0);
        (void)BCM_GetEvent(WDGTestMonitor, &mask);
        (void)BCM_ClearEvent(mask);
        WDG_Module.eventHandler(0UL);
        /* Check If Monitoring is failed for any Task */
        if (0UL == negativeTest) {
            if(0UL != wdgMonitorError) {
                ULOG_ERR("WDG_Monitor Failed %x \n",retVal);
                wdg_qt1_result = retVal;
                break;
            }
        } else {
            if ((0UL < SE2.monitor->lErrorCnt) &&
                (0UL < SE2.monitor->fErrorCnt) &&
                (0UL < SE2.monitor->dErrorCnt)) {
                wdg_qt1_result = BCM_ERR_OK;
                break;
            } else {
                wdg_qt1_result = BCM_ERR_UNKNOWN;
            }
        }

        if (countAlarm >= 100UL) {
            negativeTest = 1UL;
            /* We dont want the negative test to reset chip */
            WDT_Service(0UL);
            if (countAlarm >= 120UL) {
                break;
            } else {
                continue;
            }
        }
    }

    retVal = WDG_Module.runStateHandler(BCM_STATE_UNINIT);
    if (BCM_ERR_OK != retVal) {
        ULOG_ERR("WDG_DeInit Failed \n");
        wdg_qt1_result = retVal;
        goto error;
    }

    /* Disable the WDT driver */
    retVal = WDT_SetMode(0UL, WDT_MODE_OFF);
    if (BCM_ERR_OK != retVal) {
        ULOG_ERR("WDT_SetMode Failed \n");
        wdg_qt1_result = retVal;
        goto error;
    }

error:
    if (BCM_AT_EXECUTING == wdg_qt1_result) {
        wdg_qt1_result = BCM_ERR_OK;
        ULOG_ERR("WDG_IT1 Passed\n");
    }

    BCM_TerminateTask();
    return;
}


int32_t BCM_ExecuteAT(uint32_t aIndex)
{
    int32_t ret = BCM_ERR_OK;

    switch (aIndex) {
    case WDG_QT:
        wdg_qt1_result = BCM_AT_EXECUTING;
        ULOG_INFO("\nTest started\n");
        BCM_ActivateTask(WDGTestMonitor);
        BCM_ActivateTask(WDGTest1);
        BCM_ActivateTask(WDGTest2);
        BCM_ActivateTask(WDGTest3);
        countAlarm = 0ULL;
        break;
#ifdef ENABLE_INTEGRATION_TEST
    case WDG_IT:
        WDGIT_Execute();
        break;
#endif /* ENABLE_INTEGRATION_TEST */
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
    case WDG_QT:
        ret = wdg_qt1_result;
        break;
#ifdef ENABLE_INTEGRATION_TEST
    case WDG_IT:
        ret = WDGIT_GetResult();
        break;
#endif /* ENABLE_INTEGRATION_TEST */
    default:
        ret = BCM_AT_NOT_AVAILABLE;
        break;
    }
    return ret;
}

void APP_Init()
{
    return;
}

