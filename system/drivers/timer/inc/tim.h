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

/**
    @defgroup grp_timdrv_ifc Interface
    @ingroup grp_timdrv

    @addtogroup grp_timdrv_ifc
    @{
    @section sec_tim_overview Overview
    @image html tim_overview.jpg "Driver Overview Diagram"
    TIM driver provides APIs to start/stop the timer and to get the time
    elapsed/remaining. It also provides APIs to enable/disable notifications at
    runtime.

    The driver supports the following three timer modes:
    - Free running
    - Periodic
    - One shot

    @section sec_tim_fsm State Machine
    @image html tim_state_machine.jpg "Timer state machine"

    @section sec_tim_freerun_seq Sequence Diagrams
    @tagseq tim_freerun_seq_diagram.svg "TIM Free Running Seq"
    @startseq
    group {label = ""; color = "#EFFFFF"; "TIM Client"};
    group {label = ""; color = "#FFFFEF"; "TIM Driver"};
    "TIM Client"  => "TIM Driver" [label = "TIM_Init"];
    "TIM Client"  => "TIM Driver" [label = "TIM_GetTime"];
    "TIM Client"  => "TIM Driver" [label = "TIM_DeInit"];
    @endseq
    Sequence for free running mode of timer.

    @section sec_tim_oneshot_seq Sequence Diagrams
    @tagseq tim_oneshot_seq_diagram.svg "TIM One Shot Seq"
    @startseq
    span_width = 200;
    group {label = ""; color = "#EFFFFF"; "TIM Client"};
    group {label = ""; color = "#FFFFEF"; "TIM Driver"};
    "TIM Client"  => "TIM Driver" [label = "TIM_Init"];
    "TIM Client"  => "TIM Driver" [label = "TIM_EnableNotification"];
    "TIM Client"  => "TIM Driver" [label = "TIM_StartTimer"];
    "TIM Client"  => "TIM Driver" [label = "TIM_GetTimeRemaining"];
    "TIM Client"  => "TIM Driver" [label = "TIM_GetTimeElapsed"];
    "TIM Driver"  => "TIM Client" [label = "TIM_Chann0Cb/TIM_Chann1Cb", rightnote = "Timer Expiry", color = blue];
    "TIM Client"  => "TIM Driver" [label = "TIM_StartTimer"];
    "TIM Driver"  => "TIM Client" [label = "TIM_Chann0Cb/TIM_Chann1Cb", rightnote = "Timer Expiry", color = blue];
    "TIM Client"  => "TIM Driver" [label = "TIM_DeInit"];
    @endseq
    Sequence for oneshot mode of timer.

    @section sec_tim_periodic_seq Sequence Diagrams
    @tagseq tim_periodic_seq_diagram.svg "TIM Periodic Seq"
    @startseq
    span_width = 200;
    group {label = ""; color = "#EFFFFF"; "TIM Client"};
    group {label = ""; color = "#FFFFEF"; "TIM Driver"};
    "TIM Client"  => "TIM Driver" [label = "TIM_Init"];
    "TIM Client"  => "TIM Driver" [label = "TIM_EnableNotification"];
    "TIM Client"  => "TIM Driver" [label = "TIM_StartTimer"];
    "TIM Client"  => "TIM Driver" [label = "TIM_GetTimeRemaining"];
    "TIM Client"  => "TIM Driver" [label = "TIM_GetTimeElapsed"];
    "TIM Driver"  => "TIM Client" [label = "TIM_Chann0Cb/TIM_Chann1Cb", rightnote = "Timer Expiry", color = blue];
    "TIM Driver"  => "TIM Client" [label = "TIM_Chann0Cb/TIM_Chann1Cb", rightnote = "Timer Expiry", color = blue];
    "TIM Client"  => "TIM Driver" [label = "TIM_StopTimer"];
    "TIM Client"  => "TIM Driver" [label = "TIM_DeInit"];
    @endseq
    Sequence for periodic mode of timer.

    @section sec_tim_perf Performance & Memory

    | Performance       | Description                                       |
    |:-----------------:|:-------------------------------------------------:|
    | CPU Load          |   NA                                              |
    | Memory Bandwidth  |   NA                                              |
    | HW Utilization    |   NA                                              |

    @includedoc drivers_tim.dep

    @limitations None

    @file tim.h
    @brief TIM driver application interface
    This header file contains the interfaces for TIM driver
    @version 0.30 Imported from docx
*/

#ifndef TIM_H
#define TIM_H

#include <stdint.h>
#include <bcm_err.h>

/**
    @name TIM driver API IDs
    @{
    @brief API IDs for TIM driver
*/
#define BRCM_SWARCH_TIM_CHANID_TYPE                       (0x8101U)    /**< @brief #TIM_ChanIDType                */
#define BRCM_SWARCH_TIM_WIDTH_TYPE                        (0x8102U)    /**< @brief #TIM_WidthType                 */
#define BRCM_SWARCH_TIM_TICK_TYPE                         (0x8103U)    /**< @brief #TIM_TickType                  */
#define BRCM_SWARCH_TIM_CHAN_MODE_TYPE                    (0x8104U)    /**< @brief #TIM_ChanModeType              */
#define BRCM_SWARCH_TIM_PRESCALE_TYPE                     (0x8105U)    /**< @brief #TIM_PrescaleType              */
#define BRCM_SWARCH_TIM_CONFIG_TYPE                       (0x8106U)    /**< @brief #TIM_ConfigType                */
#define BRCM_SWARCH_TIM_INIT_PROC                         (0x8107U)    /**< @brief #TIM_Init                      */
#define BRCM_SWARCH_TIM_DEINIT_PROC                       (0x8108U)    /**< @brief #TIM_DeInit                    */
#define BRCM_SWARCH_TIM_GETTIMEELAPSED_PROC               (0x8109U)    /**< @brief #TIM_GetTimeElapsed            */
#define BRCM_SWARCH_TIM_GETTIMEREMAINING_PROC             (0x810AU)    /**< @brief #TIM_GetTimeRemaining          */
#define BRCM_SWARCH_TIM_STARTTIMER_PROC                   (0x810BU)    /**< @brief #TIM_StartTimer                */
#define BRCM_SWARCH_TIM_STOPTIMER_PROC                    (0x810CU)    /**< @brief #TIM_StopTimer                 */
#define BRCM_SWARCH_TIM_ENABLENOTIFICATION_PROC           (0x810DU)    /**< @brief #TIM_EnableNotification        */
#define BRCM_SWARCH_TIM_DISABLENOTIFICATION_PROC          (0x810EU)    /**< @brief #TIM_DisableNotification       */
#define BRCM_SWARCH_TIM_GETFREERUNNINGTIME_PROC           (0x810FU)    /**< @brief #TIM_GetFreeRunningTime        */
#define BRCM_SWARCH_TIM_GETTIME_PROC                      (0x8110U)    /**< @brief #TIM_GetTime                   */
#define BRCM_SWARCH_TIM_SYSTEMGETTIME_PROC                (0x8111U)    /**< @brief #TIM_SystemGetTime             */
#define BRCM_SWARCH_TIM_GETTIMERAW_PROC                   (0x8112U)    /**< @brief #TIM_GetTimeRaw                */
#define BRCM_SWARCH_TIM_SYSTEMSTARTTIMER_PROC             (0x8113U)    /**< @brief #TIM_SystemStartTimer          */
#define BRCM_SWARCH_TIM_SYSTEMSTOPTIMER_PROC              (0x8114U)    /**< @brief #TIM_SystemStopTimer           */
#define BRCM_SWARCH_TIM_SYSTEMENABLENOTIFICATION_PROC     (0x8115U)    /**< @brief #TIM_SystemEnableNotification  */
#define BRCM_SWARCH_TIM_SYSTEMDISABLENOTIFICATION_PROC    (0x8116U)    /**< @brief #TIM_SystemDisableNotification */
/** @} */

/**
    @brief Index of the Timer channel

    Index of the Timer channel (shall be less than #TIM_MAX_HW_ID).

    @trace #BRCM_SWREQ_TIM_KERNEL_INTERFACE
*/
typedef uint32_t TIM_ChanIDType;        /**< @brief Timer HW Channel ID Type */

/**
    @name TIM_WidthType
    @{
    @brief Width of the Timer counter

    @trace #BRCM_SWREQ_TIM_KERNEL_INTERFACE
*/
typedef uint32_t TIM_WidthType;             /**< @brief Timer counter width type */
#define TIM_WIDTH_16_BIT            (0UL)   /**< @brief 16 bit counter */
#define TIM_WIDTH_32_BIT            (1UL)   /**< @brief 32 bit counter */
/** @} */

/**
    @brief Timer ticks

    Timer ticks type

    @trace #BRCM_SWREQ_TIM_KERNEL_INTERFACE
*/
typedef uint32_t TIM_TickType;

/**
    @name TIM_ChanModeType
    @{
    @brief Mode of the timer channel

    @trace #BRCM_SWREQ_TIM_KERNEL_INTERFACE
*/
typedef uint32_t TIM_ChanModeType;         /**< @brief Timer channel mode type */
#define TIM_CHAN_MODE_FREE_RUNNING  (0UL)   /**< @brief Free running mode. The
                                                timer runs continuously and
                                                restarts each time when it
                                                reaches the max value
                                                (0xFFFFFFFF if its 32 bit timer
                                                or 0xFFFF if its 16 bit timer). */
#define TIM_CHAN_MODE_PERIODIC      (1UL)   /**< @brief Periodic mode. The timer
                                                runs continuously and restarts
                                                each time when it reaches
                                                target value. */
#define TIM_CHAN_MODE_ONE_SHOT      (2UL)   /**< @brief One shot mode. The timer
                                                runs till it reaches the target
                                                value and then stops. */
/** @} */

/**
    @name Timer pre-scaler
    @{
    @brief Prescale division values

    @trace #BRCM_SWREQ_TIM_KERNEL_INTERFACE
*/
typedef uint32_t TIM_PrescaleType;
#define TIM_PRESCALE_DIV_1      (0UL)   /**< @brief Division by 1 */
#define TIM_PRESCALE_DIV_16     (1UL)   /**< @brief Division by 16 */
#define TIM_PRESCALE_DIV_256    (2UL)   /**< @brief Division by 256 */
/** @} */

/**
    @brief Timer configuration

    @trace #BRCM_SWREQ_TIM_KERNEL_INTERFACE
*/
typedef struct sTIM_ConfigType {
    uint32_t prescale;          /**< @brief Prescale division value
                                     - #TIM_PRESCALE_DIV_1
                                     - #TIM_PRESCALE_DIV_16
                                     - #TIM_PRESCALE_DIV_256 */
    uint32_t sysTimeEn;         /**< @brief Flag to indicate the timer usage
                                     - #TRUE
                                     - #FALSE */
    TIM_ChanIDType chanID;      /**< @brief Channel ID */
    TIM_ChanModeType chanMode;  /**< @brief Channel mode */
    TIM_WidthType width;        /**< @brief Timer counter width */
} TIM_ConfigType;

/** @brief Initialize timer channel

    This API initializes the given Timer channel with the given configuration.

    @note If any channel is configured for free running mode, it is
    automatically started during initialization. The client shall not call
    #TIM_StartTimer explicitly.

    @note If any channel is configured for one-shot/periodic mode, the client
    shall implement the callback functions #TIM_Chann0Cb or #TIM_Chann0Cb and
    define the macros #ENABLE_TIM_CHANN0_CB or #ENABLE_TIM_CHANN1_CB for the
    respective channel.

    @behavior Sync, Non-reentrant

    @pre Timer is un-initialized.

    @param[in]  aChanID                 Timer channel ID
    @param[in]  aConfig                 Timer Configuration structure

    @retval     #BCM_ERR_OK             if succesfull
    @retval     #BCM_ERR_INVAL_PARAMS   invalid aConfig->width
    @retval     #BCM_ERR_INVAL_PARAMS   invalid aConfig->prescale
    @retval     #BCM_ERR_INVAL_PARAMS   invalid aConfig->chanMode
    @retval     #BCM_ERR_UNINIT         if already Initialized
    @retval     #BCM_ERR_UNKNOWN        if aConfig->chanMode is periodic/one-shot
                                        and callback fucntionality is not
                                        implemented by the client by enabling
                                        #ENABLE_TIM_CHANN0_CB or
                                        #ENABLE_TIM_CHANN1_CB
    @retval     #BCM_ERR_INVAL_PARAMS   aChanID != aConfig->chanID
    @retval     #BCM_ERR_INVAL_PARAMS   invalid aChanID
    @retval     #BCM_ERR_INVAL_PARAMS   aConfig is NULL

    @post Timer is initialized if return is #BCM_ERR_OK.
          System timer will start running.

    @trace  #BRCM_SWREQ_TIM

    @limitations None
*/
extern int32_t TIM_Init(TIM_ChanIDType aChanID,
                     const TIM_ConfigType *const aConfig);

/** @brief De-initialize timer channel

    This API de-initializes the given Timer channel.

    @note
    -# All timers (except timers in free running mode) shall either be
    stopped explicitly or expire by itself before de-initialization.
    -# If the timer is running (except free running timers), this API shall
    return without taking any action.

    @behavior Sync, Non-reentrant

    @pre Timer should be in initialized state

    @param[in]  aChanID                 Timer channel ID

    @retval     #BCM_ERR_OK             if succesfull
    @retval     #BCM_ERR_BUSY           if periodic or one-shot timer is running
    @retval     #BCM_ERR_UNINIT         if already un-initialized
    @retval     #BCM_ERR_INVAL_PARAMS   invalid aChanID

    @post Timer should be in de-initialized state

    @trace  #BRCM_SWREQ_TIM

    @limitations None
*/
extern int32_t TIM_DeInit(TIM_ChanIDType aChanID);

/** @brief Get time already elapsed

    This API returns the time already elapsed

    @behavior Sync, Re-entrant

    @pre Timer should be initialized as periodic or one-shot mode.

    @param[in]  aChanID             Timer channel ID

    @retval     #TIM_TickType       Returns
                                    - Elapsed time in ticks if timer is
                                      running. In continuous mode elapsed time
                                      is relative to last recurrence or start time
                                      before first occurance.
                                    - Elapsed time in ticks at the moment of
                                      stopping if timer was already stopped
                                    - Target time (which was passed during
                                      #TIM_StartTimer) in ticks if timer has
                                      already expired for one-shot mode.
    @retval     0UL                 If
                                    - Timer initialized but not started
                                    - Timer driver not initialized
                                    - Timer configured for free running mode
                                    - Invalid channel ID

    @post No change in timer driver state

    @trace  #BRCM_SWREQ_TIM

    @limitations None
*/
extern TIM_TickType TIM_GetTimeElapsed(TIM_ChanIDType aChanID);

/** @brief Get timer value remaining

    This API returns the timer value remaining until the target time will be
    reached next time.

    @behavior Sync, Re-entrant

    @pre Timer should be initialized as periodic or one-shot mode.

    @param[in]  aChanID                 Timer channel ID

    @retval     #TIM_TickType           Returns
                                        - Remaining time in ticks if timer is
                                        running
                                        - Remaining time in ticks at the moment
                                        of stopping if timer was already stopped
    @retval     0UL                     If
                                        - Timer expired
                                        - Timer initialized but not started
                                        - Timer driver not initialized
                                        - Timer configured for free running mode
                                        - Invalid channel ID

    @post No change in timer driver state

    @trace  #BRCM_SWREQ_TIM

    @limitations None
*/
extern TIM_TickType TIM_GetTimeRemaining(TIM_ChanIDType aChanID);

/** @brief Starts the selected timer channel

    This API starts the selected timer channel with the defined target time.

    @note If timer is configured for free running mode, this API has no effect.

    @behavior Sync, Re-entrant for different aChanID

    @pre Timer should be initialized as periodic or one-shot mode.

    @param[in]  aChanID                 Timer channel ID
    @param[in]  aValue                  Target time in number of ticks

    @retval     #BCM_ERR_OK             if succesfull
    @retval     #BCM_ERR_INVAL_PARAMS   if aValue is 0 or more than max
    @retval     #BCM_ERR_BUSY           if timer is already running
    @retval     #BCM_ERR_NOSUPPORT      if configured as free running mode
    @retval     #BCM_ERR_UNINIT         if timer is de-initialized
    @retval     #BCM_ERR_INVAL_PARAMS   if invalid aChanID

    @post Timer should be in runnning state.

    @trace  #BRCM_SWREQ_TIM

    @limitations None
*/
extern int32_t TIM_StartTimer(TIM_ChanIDType aChanID,
                           TIM_TickType aValue);

/** @brief Stop the selected timer channel

    This API stops the selected timer channel.

    @note If timer is configured for free running mode, this API has no effect.

    @behavior Sync, Re-entrant for different aChanID

    @pre Timer should be initialized as periodic or one-shot mode.

    @param[in]  aChanID                 Timer channel ID

    @retval     #BCM_ERR_OK             if succesfull or already stopped
    @retval     #BCM_ERR_NOSUPPORT      if configured as free running mode
    @retval     #BCM_ERR_UNINIT         if timer is de-initialized
    @retval     #BCM_ERR_INVAL_PARAMS   if invalid aChanID

    @post Timer should be in stopped state.

    @trace  #BRCM_SWREQ_TIM

    @limitations None
*/
extern int32_t TIM_StopTimer(TIM_ChanIDType aChanID);

/** @brief Enable notification

    This API enables the interrupt notification of the selected channel
    (aChanID). If timer is configured for either one shot or periodic mode, the
    client gets a callback notification when the target time is reached.

    @note If timer (aChanID) is configured for free running mode, this API has
    no effect.

    @behavior Sync, Re-entrant for different aChanID

    @pre Timer should be initialized as periodic or one-shot mode.

    @param[in]  aChanID                 Timer channel ID

    @retval     #BCM_ERR_OK             if succesfull
    @retval     #BCM_ERR_UNKNOWN        if callback fucntionality is not
                                        implemented by the client by enabling
                                        ENABLE_TIM_CHANN0_CB and/or
                                        ENABLE_TIM_CHANN1_CB
    @retval     #BCM_ERR_NOSUPPORT      if configured as free running mode
    @retval     #BCM_ERR_UNINIT         if not initialized
    @retval     #BCM_ERR_INVAL_PARAMS   if invalid aChanID

    @post Timer interrupt should be enabled.

    @trace  #BRCM_SWREQ_TIM_NOTIFICATION

    @limitations None
*/
extern int32_t TIM_EnableNotification(TIM_ChanIDType aChanID);

/** @brief Disable notification

    This API disables the interrupt notification of the selected channel
    (aChanID). The client will not get a callback notification when the target
    time is reached.

    @behavior Sync, Re-entrant for different aChanID

    @pre Timer should be initialized as periodic or one-shot mode.

    @param[in]  aChanID                 Timer channel ID

    @retval     #BCM_ERR_OK             if succesfull
    @retval     #BCM_ERR_UNKNOWN        if callback fucntionality is not
                                        implemented by the client by enabling
                                        ENABLE_TIM_CHANN0_CB and/or
                                        ENABLE_TIM_CHANN1_CB
    @retval     #BCM_ERR_NOSUPPORT      if configured as free running mode
    @retval     #BCM_ERR_UNINIT         if not initialized
    @retval     #BCM_ERR_INVAL_PARAMS   if invalid aChanID

    @post Timer interrupt should be disabled.

    @trace  #BRCM_SWREQ_TIM_NOTIFICATION

    @limitations None
*/
extern int32_t TIM_DisableNotification(TIM_ChanIDType aChanID);

/** @brief Get current time of the free running timer

    This API returns the current time of the free running timer. When the timer
    counter is wrapped around, the elapsed time from the timer max value is
    returned.

    @behavior Sync, Re-entrant

    @pre Timer should be initialized as system free running mode.

    @param[in]  aChanID                 Timer channel ID

    @retval     #TIM_TickType           Current time in ticks
    @retval     0UL                     - Timer driver not initialized
                                        - It’s not a free running timer
                                        - Invalid channel ID

    @post No change in driver's state

    @trace  #BRCM_SWREQ_TIM

    @limitations None
*/
extern TIM_TickType TIM_GetFreeRunningTime(TIM_ChanIDType aChanID);

/** @brief Get current time of system timer

    This API returns the current time of the timer which is configured for
    system time usage.

    @behavior Sync, Re-entrant

    @pre Timer should be initialized as system periodic mode and
         notifications must be enabled.

    @param      void

    @retval     uint64_t                Current time in ns
    @retval     0UL                     If no timer is configured for system
                                        time usage

    @post No change in driver's state.

    @trace  #BRCM_SWREQ_TIM

    @limitations None
*/
extern uint64_t TIM_GetTime(void);

/** @brief Get current time of system timer

    This API returns the current time of the timer which is configured for
    system time usage

    @behavior Sync, Re-entrant

    @pre Timer should be initialized as system periodic mode and
         notifications must be enabled.

    @param      void

    @retval     uint64_t            Current time in ns
    @retval     0UL                 If no timer is configured for system
                                    time usage

    @post No change in driver's state.

    @trace  #BRCM_SWREQ_TIM

    @limitations This API shall be called only in privileged context.
*/
extern uint64_t TIM_SystemGetTime(void);

/** @brief Get the raw value of the timer in ns

    This API returns the raw value of the timer hardware in nano seconds.
    This API can be called without initialization of the timer
    (without calling TIM_Init())

    @behavior Sync, Re-entrant

    @pre

    @param[in]  aChanID             Timer channel ID

    @retval     uint64_t            Current time in ns
    @retval     0UL                 if invalid channel ID

    @post No change in driver's state.

    @trace  #BRCM_SWREQ_TIM

    @limitations This is a privileged API and can be called only when processor
                 is running in privileged mode.
*/
extern uint64_t TIM_GetTimeRaw(TIM_ChanIDType aChanID);

/** @brief Starts the selected timer channel

    This priviledged API starts the selected timer channel with the defined
    target time.

    @note If timer is configured for free running mode, this API has no effect.

    @behavior Sync, Re-entrant for different aChanID

    @pre Timer should be initialized as periodic or one-shot mode.

    @param[in]  aChanID                 Timer channel ID
    @param[in]  aValue                  Target time in number of ticks

    @retval     #BCM_ERR_OK             if succesfull
    @retval     #BCM_ERR_INVAL_PARAMS   if aValue is 0 or more than max
    @retval     #BCM_ERR_BUSY           if timer is already running
    @retval     #BCM_ERR_NOSUPPORT      if configured as free running mode
    @retval     #BCM_ERR_UNINIT         if already Initialized
    @retval     #BCM_ERR_INVAL_PARAMS   if invalid aChanID

    @post Timer should be running.

    @trace  #BRCM_SWREQ_TIM

    @limitations None
*/
extern int32_t TIM_SystemStartTimer(TIM_ChanIDType aChanID,
                           TIM_TickType aValue);

/** @brief Stop the selected timer channel

    This priviledged API stops the selected timer channel.

    @note If timer is configured for free running mode, this API has no effect.

    @behavior Sync, Re-entrant for different aChanID

    @pre Timer should be initialized as periodic or one-shot mode.

    @param[in]  aChanID                 Timer channel ID

    @retval     #BCM_ERR_OK             if succesfull or already stopped
    @retval     #BCM_ERR_NOSUPPORT      if configured as free running mode
    @retval     #BCM_ERR_UNINIT         if already Initialized
    @retval     #BCM_ERR_INVAL_PARAMS   if invalid aChanID

    @post Timer should be stopped

    @trace  #BRCM_SWREQ_TIM

    @limitations None
*/
extern int32_t TIM_SystemStopTimer(TIM_ChanIDType aChanID);

/** @brief Enable notification

    This priviledged API enables the interrupt notification of the selected
    channel(aChanID). If timer is configured for either one shot or periodic
    mode, the client gets a callback notification when the target time is
    reached.

    @note If timer (aChanID) is configured for free running mode, this API has
    no effect.

    @behavior Sync, Re-entrant for different aChanID

    @pre Timer should be initialized as periodic or one-shot mode.

    @param[in]  aChanID                 Timer channel ID

    @retval     #BCM_ERR_OK             if succesfull
    @retval     #BCM_ERR_UNKNOWN        if callback fucntionality is not
                                        implemented by the client by enabling
                                        ENABLE_TIM_CHANN0_CB and/or
                                        ENABLE_TIM_CHANN1_CB
    @retval     #BCM_ERR_NOSUPPORT      if configured as free running mode
    @retval     #BCM_ERR_UNINIT         if not initialized
    @retval     #BCM_ERR_INVAL_PARAMS   if invalid aChanID

    @post Timer interrupt should be enabled.

    @trace  #BRCM_SWREQ_TIM_NOTIFICATION

    @limitations None
*/
extern int32_t TIM_SystemEnableNotification(TIM_ChanIDType aChanID);

/** @brief Disable notification

    This priviledged API disables the interrupt notification of the selected
    channel(aChanID). The client will not get a callback notification when the
    target time is reached.

    @behavior Sync, Re-entrant for different aChanID

    @pre Timer should be initialized as periodic or one-shot mode.

    @param[in]  aChanID                 Timer channel ID

    @retval     #BCM_ERR_OK             if succesfull
    @retval     #BCM_ERR_UNKNOWN        if callback fucntionality is not
                                        implemented by the client by enabling
                                        ENABLE_TIM_CHANN0_CB and/or
                                        ENABLE_TIM_CHANN1_CB
    @retval     #BCM_ERR_NOSUPPORT      if configured as free running mode
    @retval     #BCM_ERR_UNINIT         if not initialized
    @retval     #BCM_ERR_INVAL_PARAMS   if invalid aChanID

    @post Timer interrupt should be disabled.

    @trace  #BRCM_SWREQ_TIM_NOTIFICATION

    @limitations None
*/
extern int32_t TIM_SystemDisableNotification(TIM_ChanIDType aChanID);

#endif /* TIM_H */
/** @} */
