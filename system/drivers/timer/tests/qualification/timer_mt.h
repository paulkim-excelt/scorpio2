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

/**
    @defgroup grp_timer_qt Timer manual qualification Test
    @ingroup grp_timdrv

    @addtogroup grp_timer_mt
    @{

    @file timer_mt.h

    @board

    @brief Timer manual qualification Test
    This source file contains the manual qualification test for Timer
    @version 0.1 Initial draft
*/

#ifndef TIMER_MT_H
#define TIMER_MT_H

/**
    @brief Start periodic timer with 1s interval and wait for 10 iterations

    @pre Timer is in de-init state

    @test Initialize and start timer in periodic mode for 1s
          Wait for 10 timer expiry events.

    @post Test should come out of loop succesfully and timer should be
          De-initialized.

    @functional Yes

    @type pos

    @trace #BRCM_SWREQ_TIM
*/
#define BRCM_SWQTST_TIM_PERIODIC_1S_MODE_10_ITERATION                 (0x4001UL)

/** @brief Manual test sequence for verifying 10 sec interval with periodic mode.
    This test will take 10 sec to complete which should be verified manually against
    real time.
    Manual steps,
        - run test sequence and note the start time
        - wait for test to complete
        - once test is completed successfully , capture the end time
        - elapsed time should be between 9.5 sec to 10.5 sec
    Hint: OneUI script shows the time taken by test sequrnces too and can be
          used for this verification.
    Mark the test Pass or Fail manually in the test report.

    @code{.c}

    Test Case #BRCM_SWQTST_TIM_PERIODIC_1S_MODE_10_ITERATION

    Test code calls TIM_Init()
    Initialize ch 0 as periodic timer

    Test code calls TIM_EnableNotification()
    Enable timer notifications for channel 0

    Test code calls TIM_StartTimer()
    Start timer with 1s equivalent of ticks. Macro TIMER_SEC_TO_TICKS gets the
    number of ticks required from seconds and is valid across platforms.

    Test code waits for timer notification callback for 10 times. In each callback,
    event is triggered to test code thread which accumulates 1sec time counter.

    Test code calls TIM_StopTimer()
    Stop timer as part of #BRCM_SWQTST_TIM_STOPTIMER_SYSTEM_CH0

    Test code calls TIM_DeInit()
    De-initialize timer

    Manual Step
        Verify test execution has taken time between 9.5 sec to 10.5 sec

    @endcode

    @auto           No

    @type           Sanity

    @executetime    11s

    @analyzetime    1h
*/
#define BRCM_SWQTSEQ_TIMER_PERIODIC_MANUAL                            (0x4001UL)

#endif /* TIMER_MT_H */

/** @} */