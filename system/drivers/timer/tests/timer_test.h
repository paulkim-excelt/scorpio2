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
    constitutes the valuable trade secretVals of Broadcom, and you shall use all
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
    @defgroup grp_timer_test Timer Test
    @ingroup grp_timedrv

    @addtogroup grp_timer_test
    @{

    @file timer_test.h
    @brief Timer Tests
    This source file contains timer test top level APIs for qt, it and probes.
    @version 0.1 Initial draft
*/

#ifndef TIMER_TEST_H
#define TIMER_TEST_H

#include <osil/bcm_osil.h>

#define TIMER_MS_TO_TICKS(div, t)   (t * ((TIM_CLOCK)/((div) * (1000))))
#define TIMER_SEC_TO_TICKS(div, t)  (t * ((TIM_CLOCK)/(div)))

#define TIMER_TICKS_DIV_16_10MS  TIMER_MS_TO_TICKS(16, 10)
#define TIMER_TICKS_DIV_16_1MS   TIMER_MS_TO_TICKS(16, 1)
#define TIMER_TICKS_DIV_1_1MS    TIMER_MS_TO_TICKS(1, 1)
#define TIMER_TICKS_DIV_16_1S    TIMER_SEC_TO_TICKS(16, 1)
#define TIMER_TICKS_DIV_1_10MS   TIMER_MS_TO_TICKS(1, 10)
#define TIMER_TICKS_DIV_1_1MS    TIMER_MS_TO_TICKS(1, 1)
#define TIMER_TICKS_DIV_256_10MS TIMER_MS_TO_TICKS(256, 10)
#define TIMER_TICKS_DIV_256_1MS  TIMER_MS_TO_TICKS(256, 1)

#define TIMER_TEST_SVC_CMD_IRQ_HANDLER0             (1UL)
#define TIMER_TEST_SVC_CMD_IRQ_HANDLER_INVAL_CH     (2UL)
#define TIMER_TEST_SVC_CMD_GET_TIME_RAW             (3UL)
#define TIMER_TEST_SVC_CMD_SYS_GET_TIME             (4UL)
#define TIMER_TEST_SVC_CMD_SYS_EN_NOTIF             (5UL)
#define TIMER_TEST_SVC_CMD_SYS_DIS_NOTIF            (6UL)
#define TIMER_TEST_SVC_CMD_SYS_START_TIM            (7UL)
#define TIMER_TEST_SVC_CMD_SYS_STOP_TIM             (8UL)

extern uint32_t          TIMER_TestCh0EvtCnt;
extern uint32_t          TIMER_TestCh1EvtCnt;
extern BCM_TaskType      TIMER_TestTask;
extern BCM_EventMaskType TIMER_TestCh0Event;
extern BCM_EventMaskType TIMER_TestCh1Event;
extern int32_t           TIMER_TestResult;

typedef struct sTIMER_TEST_SVC_IOType {
    int32_t       retVal;
    uint32_t      channel;
    uint64_t      currTime;
    TIM_TickType  ticks;
} TIMER_TEST_SVC_IOType;

int32_t TIMER_ExecuteQt(uint32_t aTestIdx);
int32_t TIMER_GetStatusQt(uint32_t aTestIdx);

#ifdef ENABLE_TIMER_IT
int32_t TIMER_ExecuteIt (uint32_t aTestIdx);
int32_t TIMER_GetStatusIt(uint32_t aTestIdx);
#endif

#ifdef ENABLE_TIMER_COVERAGE
int32_t TIMER_ExecuteCt(uint32_t aIndex);
int32_t TIMER_GetStatusCt(uint32_t aTestIdx);
#endif

#endif /* TIMER_TEST_H */

/** @} */