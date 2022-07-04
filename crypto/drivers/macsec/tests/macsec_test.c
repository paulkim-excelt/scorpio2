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

#include "macsec_test.h"

void SVC_TestSvcHandler(uint32_t aMagicID, uint32_t aCmd, uint8_t *aSysIO)
{
#if 0
    TIMER_TEST_SVC_IOType *timTstSvc;
    timTstSvc = (TIMER_TEST_SVC_IOType *)aSysIO;

    switch (aCmd) {
        case TIMER_TEST_SVC_CMD_IRQ_HANDLER0:
            TIM_IRQHandler(0UL);
            break;
        case TIMER_TEST_SVC_CMD_IRQ_HANDLER1:
            TIM_IRQHandler(0UL);
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
#endif
}

int32_t BCM_ExecuteAT(uint32_t aIndex)
{
    int32_t retVal = BCM_ERR_OK;
    uint32_t testType;

    testType = ((aIndex & BCM_TEST_SEQ_TYPE_MASK) >> (BCM_TEST_SEQ_TYPE_SHIFT));

    switch (testType) {
        case BCM_TEST_SEQ_TYPE_QT:
            retVal = MACSEC_ExecuteQt(aIndex);
            break;
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
            retVal = MACSEC_GetStatusQt(aIndex);
            break;
        default:
            retVal = BCM_AT_NOT_AVAILABLE;
            break;
    }

    return retVal;
}
