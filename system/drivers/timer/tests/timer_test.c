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
#include <bcm_err.h>
#include <bcm_test.h>
#include "ee.h"

#include <tim_osil.h>
#include "timer_test.h"

uint32_t          TIMER_TestCh0EvtCnt;
uint32_t          TIMER_TestCh1EvtCnt;
BCM_TaskType      TIMER_TestTask;
BCM_EventMaskType TIMER_TestCh0Event;
BCM_EventMaskType TIMER_TestCh1Event;
int32_t           TIMER_TestResult;

void TIM_Chann0Cb(void)
{
    StatusType retOS = E_OK;
    TIMER_TestCh0EvtCnt++;
    retOS = SetEvent(TIMER_TestTask, TIMER_TestCh0Event);
    if (E_OK != retOS) {
        TIMER_TestResult = BCM_ERR_UNKNOWN;
    }
}

void TIM_Chann1Cb(void)
{
    StatusType retOS = E_OK;
    TIMER_TestCh1EvtCnt++;
    retOS = SetEvent(TIMER_TestTask, TIMER_TestCh1Event);
    if (E_OK != retOS) {
        TIMER_TestResult = BCM_ERR_UNKNOWN;
    }
}

void SVC_TestSvcHandler(uint32_t aMagicID, uint32_t aCmd, uint8_t *aSysIO)
{
    TIMER_TEST_SVC_IOType *timTstSvc;
    timTstSvc = (void *)aSysIO;

    switch (aCmd) {
        case TIMER_TEST_SVC_CMD_IRQ_HANDLER0:
            TIM_IRQHandler(0UL);
            break;
        case TIMER_TEST_SVC_CMD_IRQ_HANDLER_INVAL_CH:
            TIM_IRQHandler(0xFFFFUL);
            break;
        case TIMER_TEST_SVC_CMD_GET_TIME_RAW:
            timTstSvc->currTime = TIM_GetTimeRaw(timTstSvc->channel);
            break;
        case TIMER_TEST_SVC_CMD_SYS_GET_TIME:
            timTstSvc->currTime = TIM_SystemGetTime();
            break;
        case TIMER_TEST_SVC_CMD_SYS_EN_NOTIF:
            timTstSvc->retVal = TIM_SystemEnableNotification(timTstSvc->channel);
            break;
        case TIMER_TEST_SVC_CMD_SYS_DIS_NOTIF:
            timTstSvc->retVal = TIM_SystemDisableNotification(timTstSvc->channel);
            break;
        case TIMER_TEST_SVC_CMD_SYS_START_TIM:
            timTstSvc->retVal = TIM_SystemStartTimer(timTstSvc->channel,
                                                     timTstSvc->ticks);
            break;
        case TIMER_TEST_SVC_CMD_SYS_STOP_TIM:
            timTstSvc->retVal = TIM_SystemStopTimer(timTstSvc->channel);
            break;
        default:
            timTstSvc->retVal = BCM_ERR_INVAL_PARAMS;
            break;
    }
}

int32_t BCM_ExecuteAT(uint32_t aIndex)
{
    int32_t retVal = BCM_ERR_OK;
    uint32_t testType;

    testType = ((aIndex & BCM_TEST_SEQ_TYPE_MASK) >> (BCM_TEST_SEQ_TYPE_SHIFT));

    switch (testType) {
        case BCM_TEST_SEQ_TYPE_QT:
            retVal = TIMER_ExecuteQt(aIndex);
            break;
        case BCM_TEST_SEQ_TYPE_MANUAL_QT:
            retVal = TIMER_ExecuteQt(aIndex);
            break;
#ifdef ENABLE_TIMER_IT
        case BCM_TEST_SEQ_TYPE_IT:
            retVal = TIMER_ExecuteIt(aIndex);
            break;
#endif /* ENABLE_TIMER_IT */
#ifdef ENABLE_TIMER_COVERAGE
        case BCM_TEST_SEQ_TYPE_COV:
            retVal = TIMER_ExecuteCt(aIndex);
            break;
        case BCM_TEST_SEQ_TYPE_PRB:
            retVal = TIMER_ExecuteCt(aIndex);
            break;
#endif /* ENABLE_TIMER_COVERAGE */
        default:
            retVal = BCM_AT_NOT_AVAILABLE;
            break;
    }

    return retVal;
}

int32_t BCM_GetResultAT(uint32_t aIndex)
{
    int32_t retVal = BCM_AT_NOT_AVAILABLE;
    uint32_t testType;

    testType = ((aIndex & BCM_TEST_SEQ_TYPE_MASK) >> (BCM_TEST_SEQ_TYPE_SHIFT));

    switch (testType) {
        case BCM_TEST_SEQ_TYPE_QT:
            retVal = TIMER_GetStatusQt(aIndex);
            break;
        case BCM_TEST_SEQ_TYPE_MANUAL_QT:
            retVal = TIMER_GetStatusQt(aIndex);
            break;
#ifdef ENABLE_TIMER_IT
        case BCM_TEST_SEQ_TYPE_IT:
            retVal = TIMER_GetStatusIt(aIndex);
            break;
#endif /* ENABLE_TIMER_IT */
#ifdef ENABLE_TIMER_COVERAGE
        case BCM_TEST_SEQ_TYPE_COV:
            retVal = TIMER_GetStatusCt(aIndex);
            break;
        case BCM_TEST_SEQ_TYPE_PRB:
            retVal = TIMER_GetStatusCt(aIndex);
            break;
#endif /* ENABLE_TIMER_COVERAGE */
        default:
            retVal = BCM_AT_NOT_AVAILABLE;
            break;
    }

    return retVal;
}
