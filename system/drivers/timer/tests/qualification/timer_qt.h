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
    @defgroup grp_timer_qt Timer qualification Test
    @ingroup grp_timdrv

    @addtogroup grp_timer_qt
    @{

    @file timer_qt.h

    @board

    @brief Timer qualification Test
    This source file contains the qualification test for Timer
    @version 0.1 Initial draft
*/

#ifndef TIMER_QT_H
#define TIMER_QT_H

/**
    @brief Initialize free running timer on channel 0

    @pre Timer is in de-init state

    @test Call TIM_Init

    @post BCM_ERR_OK should be returned
          Timer is initialized as free running on channel 0

    @functional Yes

    @type pos

    @trace #BRCM_SWREQ_TIM
*/
#define BRCM_SWQTST_TIM_INIT_FREE_RUNNING_CH0                         (0x0001UL)

/**
    @brief Initialize periodic timer on channel 1

    @pre Timer is in de-init state

    @test Call TIM_Init

    @post BCM_ERR_OK should be returned
          Timer is initialized as periodic for channel 1

    @functional Yes

    @type pos

    @trace #BRCM_SWREQ_TIM
*/
#define BRCM_SWQTST_TIM_INIT_PERIODIC_CH1                             (0x0002UL)

/**
    @brief Initialize periodic timer on channel 0

    @pre Timer is in de-init state

    @test Call TIM_Init

    @post BCM_ERR_OK should be returned
          Timer is initialized as periodic for channel 0

    @functional Yes

    @type pos

    @trace #BRCM_SWREQ_TIM
*/
#define BRCM_SWQTST_TIM_INIT_PERIODIC_CH0                             (0x0003UL)

/**
    @brief Initialize one-shot timer on channel-1

    @pre Timer is in de-init state

    @test Call TIM_Init

    @post BCM_ERR_OK should be returned
          Timer is initialized as one-shot for channel 1

    @functional Yes

    @type pos

    @trace #BRCM_SWREQ_TIM
*/
#define BRCM_SWQTST_TIM_INIT_ONE_SHOT_CH1                             (0x0004UL)

/**
    @brief Initialize system periodic timer on channel 0
    To be called from previleged mode.

    @pre Timer is in de-init state

    @test Call TIM_Init

    @post BCM_ERR_OK should be returned
          Timer is initialized as system periodic for channel 0

    @functional Yes

    @type pos

    @trace #BRCM_SWREQ_TIM
*/
#define BRCM_SWQTST_TIM_INIT_SYSTEM_PERIODIC_CH0                      (0x0005UL)

/**
    @brief Enable notification for system periodic timer
    on channel 0.

    @pre Timer is in init state

    @test Call TIM_EnableNotification

    @post BCM_ERR_OK should be returned
          Timer notification is enabled for channel 0

    @functional Yes

    @type pos

    @trace #BRCM_SWREQ_TIM_NOTIFICATION
*/
#define BRCM_SWQTST_TIM_ENABLENOTIFICATION_SYS_PERIODIC_CH0           (0x0006UL)

/**
    @brief Enable notification for one shot timer in channel 1.

    @pre Timer is in init state

    @test Call TIM_EnableNotification

    @post BCM_ERR_OK should be returned
          Timer notification is enabled for channel 1

    @functional Yes

    @type pos

    @trace #BRCM_SWREQ_TIM_NOTIFICATION
*/
#define BRCM_SWQTST_TIM_ENABLENOTIFICATION_ONE_SHOT_CH1               (0x0007UL)

/**
    @brief Enable notification for periodic timer in channel 0.

    @pre Timer is in init state

    @test Call TIM_EnableNotification

    @post BCM_ERR_OK should be returned
          Timer notification is enabled for channel 0

    @functional Yes

    @type pos

    @trace #BRCM_SWREQ_TIM_NOTIFICATION
*/
#define BRCM_SWQTST_TIM_ENABLENOTIFICATION_PERIODIC_CH0               (0x0008UL)

/**
    @brief Enable notification for periodic timer in channel 1.

    @pre Timer is in init state

    @test Call TIM_EnableNotification

    @post BCM_ERR_OK should be returned
          Timer notification is enabled for channel 1

    @functional Yes

    @type pos

    @trace #BRCM_SWREQ_TIM_NOTIFICATION
*/
#define BRCM_SWQTST_TIM_ENABLENOTIFICATION_PERIODIC_CH1               (0x0009UL)

/**
    @brief Start periodic timer on channel 1

    @pre Timer is in init state

    @test Call TIM_StartTimer

    @post BCM_ERR_OK should be returned

    @functional Yes

    @type pos

    @trace #BRCM_SWREQ_TIM
*/
#define BRCM_SWQTST_TIM_STARTTIMER_PERIODIC_CH1                       (0x000AUL)

/**
    @brief Stop periodic timer on channel 1

    @pre Timer is in running state

    @test Call TIM_StopTimer

    @post BCM_ERR_OK should be returned

    @functional Yes

    @type pos

    @trace #BRCM_SWREQ_TIM
*/
#define BRCM_SWQTST_TIM_STOPTIMER_PERIODIC_CH1                        (0x000BUL)

/**
    @brief Start one shot timer on channel 1

    @pre Timer is in init state

    @test Call TIM_StartTimer

    @post BCM_ERR_OK should be returned

    @functional Yes

    @type pos

    @trace #BRCM_SWREQ_TIM
*/
#define BRCM_SWQTST_TIM_STARTTIMER_ONESHOT_CH1                        (0x000CUL)

/**
    @brief Start periodic timer on channel 0

    @pre Timer is in init state

    @test Call TIM_StartTimer

    @post BCM_ERR_OK should be returned

    @functional Yes

    @type pos

    @trace #BRCM_SWREQ_TIM
*/
#define BRCM_SWQTST_TIM_STARTTIMER_PERIODIC_CH0                       (0x000DUL)

/**
    @brief Stop periodic timer on channel 0

    @pre Timer is in init state

    @test Call TIM_StopTimer

    @post BCM_ERR_OK should be returned

    @functional Yes

    @type pos

    @trace #BRCM_SWREQ_TIM
*/
#define BRCM_SWQTST_TIM_STOPTIMER_PERIODIC_CH0                        (0x000EUL)

/**
    @brief Start system timer on channel 0

    @pre Timer is in init state

    @test Call TIM_StartTimer

    @post BCM_ERR_OK should be returned

    @functional Yes

    @type pos

    @trace #BRCM_SWREQ_TIM
*/
#define BRCM_SWQTST_TIM_STARTTIMER_SYSTEM_CH0                         (0x000FUL)

/**
    @brief Stop system timer on channel 0

    @pre Timer is in init state

    @test Call TIM_StopTimer

    @post BCM_ERR_OK should be returned

    @functional Yes

    @type pos

    @trace #BRCM_SWREQ_TIM
*/
#define BRCM_SWQTST_TIM_STOPTIMER_SYSTEM_CH0                          (0x0010UL)

/**
    @brief De-Init free running timer on channel 0

    @pre Timer is in init state

    @test Call TIM_DeInit

    @post BCM_ERR_OK should be returned
          Timer is de-initialized

    @functional Yes

    @type pos

    @trace #BRCM_SWREQ_TIM
*/
#define BRCM_SWQTST_TIM_DEINIT_FREE_RUNNING_CH0                       (0x0011UL)

/**
    @brief De-Init periodic timer on channel 1

    @pre Timer is in init state

    @test Call TIM_DeInit

    @post BCM_ERR_OK should be returned
          Timer is de-initialized

    @functional Yes

    @type pos

    @trace #BRCM_SWREQ_TIM
*/
#define BRCM_SWQTST_TIM_DEINIT_PERIODIC_CH1                           (0x0012UL)

/**
    @brief De-Init periodic timer on channel 0

    @pre Timer is in init state

    @test Call TIM_DeInit

    @post BCM_ERR_OK should be returned
          Timer is de-initialized

    @functional Yes

    @type pos

    @trace #BRCM_SWREQ_TIM
*/
#define BRCM_SWQTST_TIM_DEINIT_PERIODIC_CH0                           (0x0013UL)

/**
    @brief De-Init one-shot timer on channel-1

    @pre Timer is in init state

    @test Call TIM_DeInit

    @post BCM_ERR_OK should be returned
          Timer is de-initialized

    @functional Yes

    @type pos

    @trace #BRCM_SWREQ_TIM
*/
#define BRCM_SWQTST_TIM_DEINIT_ONE_SHOT_CH1                           (0x0014UL)

/**
    @brief Stop periodic timer on channel 0 and verify no
           call back occurs post stopping.

    @pre Timer is in stopped state

    @test Verify call back counter after waiting for 5ms
          since stopping.

    @post No change in state.
          There should not be any call back

    @functional Yes

    @type pos

    @trace #BRCM_SWREQ_TIM
*/
#define BRCM_SWQTST_TIM_STOPTIMER_PERIODIC_VERIFY                     (0x0015UL)

/**
    @brief De-Init system periodic timer on channel 0
    To be called from previleged mode.

    @pre Timer is in init state

    @test Call TIM_DeInit

    @post BCM_ERR_OK should be returned
          Timer is de-initialized

    @functional Yes

    @type pos

    @trace #BRCM_SWREQ_TIM
*/
#define BRCM_SWQTST_TIM_DEINIT_SYSTEM_PERIODIC_CH0                    (0x0016UL)

/**
    @brief Enable notification using privileged API.

    @pre Timer is in init state

    @test Call TIM_SystemEnableNotification

    @post BCM_ERR_OK should be returned
          Timer notification is enabled

    @functional Yes

    @type pos

    @trace #BRCM_SWREQ_TIM_NOTIFICATION
*/
#define BRCM_SWQTST_TIM_SYSTEMENABLENOTIFICATION_SYS_TIM              (0x0017UL)

/**
    @brief Disable notification using privileged API.

    @pre Timer is in init state

    @test Call TIM_SystemDisableNotification

    @post BCM_ERR_OK should be returned
          Timer notification is enabled

    @functional Yes

    @type pos

    @trace #BRCM_SWREQ_TIM_NOTIFICATION
*/
#define BRCM_SWQTST_TIM_SYSTEMDISABLENOTIFICATION_SYS_TIM             (0x0018UL)

/**
    @brief Start timer using privileged API.

    @pre Timer is in init state

    @test Call TIM_SystemStartTimer

    @post BCM_ERR_OK should be returned
          Timer is running

    @functional Yes

    @type pos

    @trace #BRCM_SWREQ_TIM_NOTIFICATION
*/
#define BRCM_SWQTST_TIM_SYSTEMSTARTTIMER_SYS_TIM                      (0x0019UL)

/**
    @brief Stop timer using privileged API.

    @pre Timer is in running state

    @test Call TIM_SystemStopTimer

    @post BCM_ERR_OK should be returned
          Timer is running

    @functional Yes

    @type pos

    @trace #BRCM_SWREQ_TIM_NOTIFICATION
*/
#define BRCM_SWQTST_TIM_SYSTEMSTOPTIMER_SYS_TIM                       (0x001AUL)

/** @brief Qualification test sequence for testing periodic timer on
    channel ID 1.

    @code{.c}

    Call TIM_Init() to Initialize timers including free running timer.
    Check Expected Result for #BRCM_SWQTST_TIM_INIT_FREE_RUNNING_CH0
    Check Expected Result for #BRCM_SWQTST_TIM_INIT_PERIODIC_CH1

    Call TIM_EnableNotification() to enable notifications for channel 1
    Check Expected Result for #BRCM_SWQTST_TIM_ENABLENOTIFICATION_PERIODIC_CH1

    Call TIM_StartTimer() to start timer
    Check Expected Result for #BRCM_SWQTST_TIM_STARTTIMER_PERIODIC_CH1

    Call TIM_GetFreeRunningTime()
    Get free running time stamp for channel 1

    Wait for notification event and capture timestamp for each periodic event

    Call TIM_StopTimer() to stop timer
    Check Expected Result for #BRCM_SWQTST_TIM_STARTTIMER_PERIODIC_CH1

    Call TIM_GetFreeRunningTime()
    Compare the time stamps and verify if free running timer is still running
    Compare periodicCbCount and verify for expected number of periodic events
    Compare the time stamps and verify free running time has expected difference

    Call TIM_DeInit() to De-initialize timer
    Check Expected Result for #BRCM_SWQTST_TIM_DEINIT_FREE_RUNNING_CH0
    Check Expected Result for #BRCM_SWQTST_TIM_DEINIT_PERIODIC_CH1

    @endcode

    @auto           Yes

    @type           Sanity

    @executetime    1s

    @analyzetime    1h
*/
#define BRCM_SWQTSEQ_TIMER_PERIODIC_CH1                               (0x0001UL)

/** @brief Qualification test sequence for testing oneshot timer on
    channel ID 1.

    @code{.c}

    Call TIM_Init() to Initialize timers for one shot and
    periodic configurations
    Check Expected Result for #BRCM_SWQTST_TIM_INIT_PERIODIC_CH0
    Check Expected Result for #BRCM_SWQTST_TIM_INIT_ONE_SHOT_CH1

    Call TIM_EnableNotification() to Enable notifications for channel 1
    Check Expected Result for #BRCM_SWQTST_TIM_ENABLENOTIFICATION_ONE_SHOT_CH1

    Call TIM_StartTimer() to Start one shot timer
    Check Expected Result for #BRCM_SWQTST_TIM_STARTTIMER_ONESHOT_CH1

    Call TIM_EnableNotification() to enable notifications for channel 0
    Check Expected Result for #BRCM_SWQTST_TIM_ENABLENOTIFICATION_PERIODIC_CH0

    Call TIM_StartTimer() to Start periodic timer
    Check Expected Result for #BRCM_SWQTST_TIM_STARTTIMER_PERIODIC_CH0

    Wait for notification from one shot event
    Wait for notification from periodic event

    Validate event counters

    Call TIM_StopTimer() to Stop timer
    Check Expected Result for #BRCM_SWQTST_TIM_STOPTIMER_PERIODIC_CH0
    Check Expected Result for #BRCM_SWQTST_TIM_STOPTIMER_PERIODIC_VERIFY

    Call TIM_DeInit() to De-initialize timers
    Check Expected Result for #BRCM_SWQTST_TIM_DEINIT_PERIODIC_CH0
    Check Expected Result for #BRCM_SWQTST_TIM_DEINIT_ONE_SHOT_CH1

    @endcode

    @auto           Yes

    @type           Sanity

    @executetime    1s

    @analyzetime    1h
*/
#define BRCM_SWQTSEQ_TIMER_ONESHOT_CH1_PERIODIC_CH0                   (0x0002UL)

/** @brief Qualification test sequence for testing system timer on
    channel ID 0.

    @code{.c}

    Call TIM_Init() to Initialize ch 0 as system timer
    Check Expected Result for #BRCM_SWQTST_TIM_INIT_SYSTEM_PERIODIC_CH0

    Call TIM_EnableNotification() to Enable notifications for channel 0
    Check Expected Result for #BRCM_SWQTST_TIM_ENABLENOTIFICATION_SYS_PERIODIC_CH0

    Call TIM_StartTimer() to Start system timer
    Check Expected Result for #BRCM_SWQTST_TIM_STARTTIMER_SYSTEM_CH0

    Wait for event
    Capture time stamp

    Again Wait for event
    Capture time stamp

    Compare time stamps and validate

    Call TIM_StopTimer() to Stop timer
    Check Expected Result for #BRCM_SWQTST_TIM_STOPTIMER_SYSTEM_CH0

    Call TIM_DeInit() to De-initialize timer
    Check Expected Result for #BRCM_SWQTST_TIM_DEINIT_SYSTEM_PERIODIC_CH0

    @endcode

    @auto           Yes

    @type           Sanity

    @executetime    1s

    @analyzetime    1h
*/
#define BRCM_SWQTSEQ_TIMER_SYSTEM_CH0                                 (0x0003UL)

/** @brief Qualification test sequence for testing privileged mode APIs

    @code{.c}

    Call TIM_Init() with system mode enabled

    Call TIM_SystemEnableNotification() from privileged mode
    Check Expected Result for #BRCM_SWQTST_TIM_SYSTEMENABLENOTIFICATION_SYS_TIM

    Call TIM_SystemStartTimer() from privileged mode
    Check Expected Result for #BRCM_SWQTST_TIM_SYSTEMSTARTTIMER_SYS_TIM

    Call TIM_SystemStopTimer() from privileged mode
    Check Expected Result for #BRCM_SWQTST_TIM_SYSTEMSTOPTIMER_SYS_TIM

    Call TIM_SystemDisableNotification() from privileged mode
    Check Expected Result for #BRCM_SWQTST_TIM_SYSTEMDISABLENOTIFICATION_SYS_TIM

    Call TIM_DeInit()

    @endcode

    @auto           Yes

    @type           Sanity

    @executetime    1s

    @analyzetime    1h
*/
#define BRCM_SWQTSEQ_TIMER_SYSTEM_TEST                                (0x0004UL)

#endif /* TIMER_QT_H */

/** @} */