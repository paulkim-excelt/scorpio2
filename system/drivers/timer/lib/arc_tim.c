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
    @defgroup grp_timdrv_impl Implementation
    @ingroup grp_timdrv

    @addtogroup grp_timdrv_impl
    @{

    @file arc_tim.c
    @brief TIM driver implementation
    @version 0.30 Imported from docx
*/

#include <stdbool.h>
#include <string.h>
#include <bcm_err.h>
#include <svc.h>
#include <bcm_utils.h>
#include <tim_osil.h>
#include <arc_timer.h>

/**
    @name TIM driver design IDs
    @{
    @brief Design IDs for TIM driver
*/
#define BRCM_SWDSGN_TIM_DRV_CHANSTATE_TYPE              (0xB001U)   /**< @brief #TIM_DrvChanStateType           */
#define BRCM_SWDSGN_TIM_DRV_DEV_TYPE                    (0xB002U)   /**< @brief #TIM_DrvDevType                 */
#define BRCM_SWDSGN_TIM_SVC_IO_TYPE                     (0xB003U)   /**< @brief #TIM_SVCIOType                  */
#define BRCM_SWDSGN_TIM_DRV_DEV_GLOBAL                  (0xB004U)   /**< @brief #TIM_DrvDev                     */
#define BRCM_SWDSGN_TIM_DRV_REPORT_ERROR_PROC           (0xB005U)   /**< @brief #TIM_DrvReportError             */
#define BRCM_SWDSGN_TIM_GET_ARC_TIMER_ID_FROM_CHAN_PROC (0xB006U)   /**< @brief #TIM_GetArcTimerIdFromChan      */
#define BRCM_SWDSGN_TIM_DRV_VALIDATE_CONFIG_PROC        (0xB007U)   /**< @brief #TIM_DrvValidateConfig          */
#define BRCM_SWDSGN_TIM_DRV_INIT_PROC                   (0xB008U)   /**< @brief #TIM_DrvInit                    */
#define BRCM_SWDSGN_TIM_DRV_DEINIT_PROC                 (0xB009U)   /**< @brief #TIM_DrvDeInit                  */
#define BRCM_SWDSGN_TIM_DRV_GET_TIME_ELAPSED_PROC       (0xB00AU)   /**< @brief #TIM_DrvGetTimeElapsed          */
#define BRCM_SWDSGN_TIM_DRV_GET_TIME_REMAINING_PROC     (0xB00BU)   /**< @brief #TIM_DrvGetTimeRemaining        */
#define BRCM_SWDSGN_TIM_DRV_START_TIMER_PROC            (0xB00CU)   /**< @brief #TIM_DrvStartTimer              */
#define BRCM_SWDSGN_TIM_DRV_STOP_TIMER_PROC             (0xB00DU)   /**< @brief #TIM_DrvStopTimer               */
#define BRCM_SWDSGN_TIM_DRV_ENABLE_NOTIFICATION_PROC    (0xB00EU)   /**< @brief #TIM_DrvEnableNotification      */
#define BRCM_SWDSGN_TIM_DRV_DISABLE_NOTIFICATION_PROC   (0xB00FU)   /**< @brief #TIM_DrvDisableNotification     */
#define BRCM_SWDSGN_TIM_DRV_GET_FREE_RUNNING_TIME_PROC  (0xB010U)   /**< @brief #TIM_DrvGetFreeRunningTime      */
#define BRCM_SWDSGN_TIM_DRV_GET_TIME_PROC               (0xB011U)   /**< @brief #TIM_DrvGetTime                 */
#define BRCM_SWDSGN_TIM_DRV_SYSTEM_GET_TIME_PROC        (0xB012U)   /**< @brief #TIM_SystemGetTime              */
#define BRCM_SWDSGN_TIM_DRV_GET_TIME_RAW_PROC           (0xB013U)   /**< @brief #TIM_GetTimeRaw                 */
#define BRCM_SWDSGN_TIM_SYSTEM_START_TIMER_PROC         (0xB014U)   /**< @brief #TIM_SystemStartTimer           */
#define BRCM_SWDSGN_TIM_SYSTEM_STOP_TIMER_PROC          (0xB015U)   /**< @brief #TIM_SystemStopTimer            */
#define BRCM_SWDSGN_TIM_SYSTEM_ENABLE_NOTIFICATION_PROC (0xB016U)   /**< @brief #TIM_SystemEnableNotification   */
#define BRCM_SWDSGN_TIM_SYSTEM_DISABLE_NOTIFICATION_PROC (0xB017U)  /**< @brief #TIM_SystemDisableNotification  */
#define BRCM_SWDSGN_TIM_SYS_CMD_HANDLER_PROC            (0xB018U)   /**< @brief #TIM_SysCmdHandler              */
#define BRCM_SWDSGN_TIM_IRQ_HANDLER_PROC                (0xB019U)   /**< @brief #TIM_IRQHandler                 */
/** @} */

/** @brief Timer channel state type

    @{
    @trace #BRCM_SWARCH_TIM_SYSCMDHANDLER_PROC
    @trace #BRCM_SWARCH_TIM_IRQHANDLER_PROC
    @trace #BRCM_SWREQ_TIM_ARC
*/
typedef uint32_t TIM_DrvChanStateType;          /**< @brief TIM_DrvChanStateType        */
#define TIM_DRV_CHANSTATE_UNINIT        (0UL)   /**< @brief TIM_DRV_CHANSTATE_UNINIT    */
#define TIM_DRV_CHANSTATE_INIT          (1UL)   /**< @brief TIM_DRV_CHANSTATE_INIT      */
#define TIM_DRV_CHANSTATE_RUNNING       (2UL)   /**< @brief TIM_DRV_CHANSTATE_RUNNING   */
#define TIM_DRV_CHANSTATE_STOPPED       (3UL)   /**< @brief TIM_DRV_CHANSTATE_STOPPED   */
/** @} */

/** @brief Per channel driver state type

    @trace #BRCM_SWARCH_TIM_SYSCMDHANDLER_PROC
    @trace #BRCM_SWARCH_TIM_IRQHANDLER_PROC
    @trace #BRCM_SWREQ_TIM_ARC
*/
typedef struct sTIM_DrvDevType {
    bool                    notifEn;    /**< @brief Enable notification                             */
    TIM_DrvChanStateType    state;      /**< @brief state                                           */
    TIM_ChanModeType        chanMode;   /**< @brief chanMode                                        */
    TIM_TickType            targetTime; /**< @brief Target time supplied to @ref TIM_StartTimer     */
    TIM_TickType            stopTime;   /**< @brief Timer value in ticks when the timer was stopped */
} TIM_DrvDevType;

/** @brief Union to avoid MISRA Required error for Type conversion

    @trace #BRCM_SWARCH_TIM_SYSCMDHANDLER_PROC
    @trace #BRCM_SWREQ_TIM_KERNEL_HANDLER_ARC
*/
typedef union uTIM_SVCIOType {
    uint8_t     *data;
    TIM_IOType  *io;
} TIM_SVCIOType;

/** @brief Timer channel states

    @trace #BRCM_SWARCH_TIM_SYSCMDHANDLER_PROC
    @trace #BRCM_SWARCH_TIM_IRQHANDLER_PROC
    @trace #BRCM_SWREQ_TIM_ARC
*/
static TIM_DrvDevType TIM_DrvDev[TIM_MAX_CHANNELS] COMP_SECTION(".bss.drivers");

/** @brief Error reporting helper

    @trace #BRCM_SWARCH_TIM_SYSCMDHANDLER_PROC
    @trace #BRCM_SWREQ_TIM_KERNEL_INTERFACE
*/
static void TIM_DrvReportError(uint32_t aInstanceID, uint16_t aApiID,
                                int32_t aErr, uint32_t aVal0, uint32_t aVal1, uint32_t aVal2,
                                uint32_t aVal3)
{
    const uint32_t values[4] = {aVal0, aVal1, aVal2, aVal3};
    BCM_ReportError(BCM_SPT_ID, (uint8_t)aInstanceID, aApiID, aErr, 4UL,
            values);
}

/** @brief Get ARC timer ID from the timer channel ID

    @behavior Sync, reentrant

    @pre None

    @param[in]      aChanID             Timer channel ID. Assumed
                                        to be valid

    @return ARC timer ID associated with the timer channel

    @trace #BRCM_SWARCH_TIM_SYSCMDHANDLER_PROC
    @trace #BRCM_SWREQ_TIM_ARC
*/
static ARC_TimerIdType TIM_GetArcTimerIdFromChan(const TIM_ChanIDType aChanID)
{
    return (ARC_TimerIdType) aChanID;
}

/** @brief Validate the timer configurarion

    The following features are not supported in this instance
    of the timer driver:
        -# FREE_RUNNING timers
        -# Prescales TIM_PRESCALE_DIV_N when N is greater than 1
        -# 16 bit timers
        -# Systime on a particular timer channel

    This routine checks if the requested configuration is trying to
    enable any of the above features and returns an error if it is
    true.

    @behavior Sync, reentrant

    @pre None

    @param[in]      aChanID                 Timer channel ID
    @param[in]      aConfig                 Config to validate

    @retval         #BCM_ERR_INVAL_PARAMS   Timer configuration invalid
    @retval         #BCM_ERR_OK             Timer configuration OK

    @trace #BRCM_SWARCH_TIM_SYSCMDHANDLER_PROC
    @trace #BRCM_SWREQ_TIM_ARC
*/
static int32_t TIM_DrvValidateConfig(const TIM_ChanIDType aChanID, const TIM_ConfigType *const aConfig)
{
    int32_t ret;

    if (aChanID != aConfig->chanID) {
        /* Invalid chanID */
        ret = BCM_ERR_INVAL_PARAMS;
    } else if (
        (TIM_CHAN_MODE_PERIODIC != aConfig->chanMode) &&
        (TIM_CHAN_MODE_ONE_SHOT != aConfig->chanMode)) {
        /* We do not support free running channels */
        ret = BCM_ERR_INVAL_PARAMS;
    } else if (TIM_PRESCALE_DIV_1 != aConfig->prescale) {
        /* We do not support pre-scaling */
        ret = BCM_ERR_INVAL_PARAMS;
    } else if (TIM_WIDTH_32_BIT != aConfig->width) {
        /* Only 32 bit counter width is supported */
        ret = BCM_ERR_INVAL_PARAMS;
    } else if (FALSE != aConfig->sysTimeEn) {
        /*
            We don't need to set aside a channel for sys time.
            ARC's RTC clock can be used instead
        */
        ret = BCM_ERR_OK;
    } else {
        /* All good */
        ret = BCM_ERR_OK;
    }

    return ret;
}

/**
    @code{.unparsed}
    if ((NULL == aConfig) || (TIM_MAX_CHANNELS <= aChanID))
        return BCM_ERR_INVAL_PARAMS

    if (TIM_DRV_CHANSTATE_UNINIT != TIM_DrvDev[aChanID].state)
        return BCM_ERR_UNINIT

    if (BCM_ERR_OK != TIM_DrvValidateConfig(aChanID, aConfig))
        return BCM_ERR_INVAL_PARAMS

    if (NULL == TIM_CallBackTable[aChanID])
        return BCM_ERR_UNKNOWN

    arcTimerId = TIM_GetArcTimerIdFromChan(aChanID)
    ARC_TimerDeinit(arcTimerId)

    TIM_DrvDev[aChanID].notifEn = false
    TIM_DrvDev[aChanID].chanMode = aConfig->chanMode
    TIM_DrvDev[aChanID].state = TIM_DRV_CHANSTATE_INIT
    return BCM_ERR_OK
    @endcode

    @trace #BRCM_SWARCH_TIM_SYSCMDHANDLER_PROC
    @trace #BRCM_SWREQ_TIM_NOTIFICATION_ARC
*/
static int32_t TIM_DrvInit(TIM_ChanIDType aChanID, const TIM_ConfigType *const aConfig)
{
    int32_t ret;

    if ((NULL == aConfig) || (TIM_MAX_CHANNELS <= aChanID)) {
        /* Inval API params */
        ret = BCM_ERR_INVAL_PARAMS;
    } else if (TIM_DRV_CHANSTATE_UNINIT != TIM_DrvDev[aChanID].state) {
        /* Invalid channel state */
        ret = BCM_ERR_UNINIT;
    } else if (BCM_ERR_OK != TIM_DrvValidateConfig(aChanID, aConfig)) {
        /* Configuration validation failed */
        ret = BCM_ERR_INVAL_PARAMS;
    } else if (NULL == TIM_CallBackTable[aChanID]) {
        /*
            We do not support free-running mode.
            So, a callback must have been installed
        */
        ret = BCM_ERR_UNKNOWN;
    } else {
        /*
            All OK. Put the timer channel in the init state.
            Also, reset the timer
        */
        const ARC_TimerIdType arcTimerId = TIM_GetArcTimerIdFromChan(aChanID);
        (void) ARC_TimerDeinit(arcTimerId);

        TIM_DrvDev[aChanID].notifEn = false;
        TIM_DrvDev[aChanID].chanMode = aConfig->chanMode;
        TIM_DrvDev[aChanID].state = TIM_DRV_CHANSTATE_INIT;
        ret = BCM_ERR_OK;
    }

    if (BCM_ERR_OK != ret) {
        TIM_DrvReportError(aChanID, BRCM_SWDSGN_TIM_DRV_INIT_PROC, ret, 0UL,
                0UL, 0UL, 0UL);
    }

    return ret;
}

/**
    @code{.unparsed}
    if (TIM_MAX_CHANNELS <= aChanID)
        return BCM_ERR_INVAL_PARAMS

    if (TIM_DRV_CHANSTATE_UNINIT == TIM_DrvDev[aChanID].state)
        return BCM_ERR_UNINIT

    if (TIM_DRV_CHANSTATE_RUNNING == TIM_DrvDev[aChanID].state)
        return BCM_ERR_BUSY

    TIM_DrvDev[aChanID].state = TIM_DRV_CHANSTATE_UNINIT
    return BCM_ERR_OK
    @endcode

    @trace #BRCM_SWARCH_TIM_SYSCMDHANDLER_PROC
    @trace #BRCM_SWREQ_TIM_ARC
*/
static int32_t TIM_DrvDeInit(TIM_ChanIDType aChanID)
{
    int32_t ret;

    if (TIM_MAX_CHANNELS <= aChanID) {
        /* Invalid channel ID */
        ret = BCM_ERR_INVAL_PARAMS;
    } else if (TIM_DRV_CHANSTATE_UNINIT == TIM_DrvDev[aChanID].state) {
        /* Nothing to do */
        ret = BCM_ERR_UNINIT;
    } else if (TIM_DRV_CHANSTATE_RUNNING == TIM_DrvDev[aChanID].state) {
        /* Cannot de-init a channel while it is running */
        ret = BCM_ERR_BUSY;
    } else {
        /*
            Transition the channel state to UNINIT. There is no need
            to call into any ARC timer API at this point.
        */
        TIM_DrvDev[aChanID].state = TIM_DRV_CHANSTATE_UNINIT;
        ret = BCM_ERR_OK;
    }

    if (BCM_ERR_OK != ret) {
        TIM_DrvReportError(aChanID, BRCM_SWDSGN_TIM_DRV_DEINIT_PROC, ret, 0UL,
                0UL, 0UL, 0UL);
    }

    return ret;
}

/**
    @code{.unparsed}
    if ((TIM_MAX_CHANNELS <= aChanID) ||
        (TIM_DRV_CHANSTATE_UNINIT == TIM_DrvDev[aChanID].state) ||
        (TIM_DRV_CHANSTATE_INIT   == TIM_DrvDev[aChanID].state))
        return 0

    if (TIM_DRV_CHANSTATE_STOPPED == TIM_DrvDev[aChanID].state)
        return TIM_DrvDev[aChanID].stopTime

    arcTimerId = TIM_GetArcTimerIdFromChan(aChanID)
    return ARC_TimerGetTickCnt(arcTimerId)
    @endcode

    @trace #BRCM_SWARCH_TIM_SYSCMDHANDLER_PROC
    @trace #BRCM_SWREQ_TIM_ARC
*/
static TIM_TickType TIM_DrvGetTimeElapsed(TIM_ChanIDType aChanID)
{
    int32_t ret;
    TIM_TickType elapsedTime;

    if (TIM_MAX_CHANNELS <= aChanID) {
        /* Invalid channel ID */
        elapsedTime = 0UL;
        ret = BCM_ERR_INVAL_PARAMS;
    } else if (TIM_DRV_CHANSTATE_UNINIT == TIM_DrvDev[aChanID].state) {
        /* Log BCM_ERR_UNINIT in this state  */
        elapsedTime = 0UL;
        ret = BCM_ERR_UNINIT;
    } else if (TIM_DRV_CHANSTATE_INIT == TIM_DrvDev[aChanID].state) {
        /* Return 0 elapsedTime  */
        elapsedTime = 0UL;
        ret = BCM_ERR_OK;
    } else if (TIM_DRV_CHANSTATE_STOPPED == TIM_DrvDev[aChanID].state) {
        /*
            Timer has stopped (explicitly or because one-shot timer expired).
            Return the stop time
        */
        elapsedTime = TIM_DrvDev[aChanID].stopTime;
        ret = BCM_ERR_OK;
    } else {
        /*
            Timer is running.
            Read the elapsed tickcnt from the HW
        */
        const ARC_TimerIdType arcTimerId = TIM_GetArcTimerIdFromChan(aChanID);

        elapsedTime = 0UL;
        ret = ARC_TimerGetTickCnt(arcTimerId, &elapsedTime);
    }

    if (BCM_ERR_OK != ret) {
        TIM_DrvReportError(aChanID, BRCM_SWDSGN_TIM_DRV_GET_TIME_ELAPSED_PROC, ret, 0UL,
                0UL, 0UL, 0UL);
    }

    return elapsedTime;
}

/**
    @code{.unparsed}
    if ((TIM_MAX_CHANNELS <= aChanID) ||
        (TIM_DRV_CHANSTATE_UNINIT == TIM_DrvDev[aChanID].state) ||
        (TIM_DRV_CHANSTATE_INIT   == TIM_DrvDev[aChanID].state))
        return 0

    if (TIM_DRV_CHANSTATE_STOPPED == TIM_DrvDev[aChanID].state)
        return TIM_DrvDev[aChanID].targetTime - TIM_DrvDev[aChanID].stopTime

    arcTimerId = TIM_GetArcTimerIdFromChan(aChanID)
    return TIM_DrvDev[aChanID].targetTime - ARC_TimerGetTickCnt(arcTimerId)
    @endcode

    @trace #BRCM_SWARCH_TIM_SYSCMDHANDLER_PROC
    @trace #BRCM_SWREQ_TIM_ARC
*/
static TIM_TickType TIM_DrvGetTimeRemaining(TIM_ChanIDType aChanID)
{
    int32_t ret;
    TIM_TickType remainingTime;

    if (TIM_MAX_CHANNELS <= aChanID) {
        /* Invalid channel ID */
        remainingTime = 0UL;
        ret = BCM_ERR_INVAL_PARAMS;
    } else if (TIM_DRV_CHANSTATE_UNINIT == TIM_DrvDev[aChanID].state) {
        /* Log BCM_ERR_UNINIT in this state */
        remainingTime = 0UL;
        ret = BCM_ERR_UNINIT;
    } else if (TIM_DRV_CHANSTATE_INIT == TIM_DrvDev[aChanID].state) {
        /*
            We are expected to return
                remainingTime = 0
            if the channel is in the INIT state. This is not an error.
        */
        remainingTime = 0UL;
        ret = BCM_ERR_OK;
    } else if (TIM_DRV_CHANSTATE_STOPPED == TIM_DrvDev[aChanID].state) {
        /*
            If the timer has been stopped (explicitly or because one-shot
            timer expired) return (target - stop) time
        */
        remainingTime = TIM_DrvDev[aChanID].targetTime - TIM_DrvDev[aChanID].stopTime;
        ret = BCM_ERR_OK;
    } else {
        /* Timer is running. Read the elapsed tick count from the HW */
        uint32_t elapsedTime = 0UL;
        const ARC_TimerIdType arcTimerId = TIM_GetArcTimerIdFromChan(aChanID);

        ret = ARC_TimerGetTickCnt(arcTimerId, &elapsedTime);
        if (BCM_ERR_OK == ret) {
            remainingTime = TIM_DrvDev[aChanID].targetTime - elapsedTime;
        } else {
            remainingTime = 0UL;
        }
    }

    if (BCM_ERR_OK != ret) {
        TIM_DrvReportError(aChanID, BRCM_SWDSGN_TIM_DRV_GET_TIME_REMAINING_PROC, ret, 0UL,
                0UL, 0UL, 0UL);
    }

    return remainingTime;
}

/**
    @code{.unparsed}
    if (TIM_MAX_CHANNELS <= aChanID)
        return BCM_ERR_INVAL_PARAMS

    if (TIM_DRV_CHANSTATE_UNINIT == TIM_DrvDev[aChanID].state)
        return BCM_ERR_UNINIT

    if (TIM_DRV_CHANSTATE_RUNNING == TIM_DrvDev[aChanID].state)
        return BCM_ERR_BUSY

    arcTimerId = TIM_GetArcTimerIdFromChan(aChanID)
    TIM_DrvDev[aChanID].targetTime = aValue
    TIM_DrvDev[aChanID].state = TIM_DRV_CHANSTATE_RUNNING
    ARC_TimerInit(arcTimerId, aValue)
    return BCM_ERR_OK
    @endcode

    @trace #BRCM_SWARCH_TIM_SYSTEMSTARTTIMER_PROC
    @trace #BRCM_SWARCH_TIM_SYSCMDHANDLER_PROC
    @trace #BRCM_SWREQ_TIM_ARC
*/
static int32_t TIM_DrvStartTimer(TIM_ChanIDType aChanID, TIM_TickType aValue)
{
    int32_t ret;

    if (TIM_MAX_CHANNELS <= aChanID) {
        /* Invalid channel ID */
        ret = BCM_ERR_INVAL_PARAMS;
    } else if (TIM_DRV_CHANSTATE_UNINIT == TIM_DrvDev[aChanID].state) {
        /* Timer channel not in the right state */
        ret = BCM_ERR_UNINIT;
    } else if (TIM_DRV_CHANSTATE_RUNNING == TIM_DrvDev[aChanID].state) {
        /* Cannot start a timer channel that's already running */
        ret = BCM_ERR_BUSY;
    } else {
        /* All good. Program the HW and update the driver state */
        const ARC_TimerIdType arcTimerId = TIM_GetArcTimerIdFromChan(aChanID);
        TIM_DrvDev[aChanID].targetTime = aValue;
        TIM_DrvDev[aChanID].state = TIM_DRV_CHANSTATE_RUNNING;
        ret = ARC_TimerInit(arcTimerId, aValue);

        BCM_ASSERT(BCM_ERR_OK == ret)
    }

    if (BCM_ERR_OK != ret) {
        TIM_DrvReportError(aChanID, BRCM_SWDSGN_TIM_DRV_START_TIMER_PROC, ret,
                aValue, 0UL, 0UL, 0UL);
    }

    return ret;
}

/**
    @code{.unparsed}
    if (TIM_MAX_CHANNELS <= aChanID)
        return BCM_ERR_INVAL_PARAMS

    if (TIM_DRV_CHANSTATE_UNINIT == TIM_DrvDev[aChanID].state)
        return BCM_ERR_UNINIT

    if (TIM_DRV_CHANSTATE_RUNNING != TIM_DrvDev[aChanID].state)
        return BCM_ERR_OK

    arcTimerId = TIM_GetArcTimerIdFromChan(aChanID)
    TIM_DrvDev[aChanID].stopTime = ARC_TimerGetTickCnt(arcTimerId)
    ARC_TimerDeinit(arcTimerId)
    TIM_DrvDev[aChanID].state = TIM_DRV_CHANSTATE_STOPPED
    return BCM_ERR_OK
    @endcode

    @trace #BRCM_SWARCH_TIM_SYSTEMSTOPTIMER_PROC
    @trace #BRCM_SWARCH_TIM_SYSCMDHANDLER_PROC
    @trace #BRCM_SWREQ_TIM_ARC
*/
static int32_t TIM_DrvStopTimer(TIM_ChanIDType aChanID)
{
    int32_t ret;

    if (TIM_MAX_CHANNELS <= aChanID) {
        /* Invalid channel ID */
        ret = BCM_ERR_INVAL_PARAMS;
    } else if (TIM_DRV_CHANSTATE_UNINIT == TIM_DrvDev[aChanID].state) {
        /* Timer channel not in the right state */
        ret = BCM_ERR_UNINIT;
    } else if (TIM_DRV_CHANSTATE_RUNNING != TIM_DrvDev[aChanID].state) {
        /* Nothing to stop */
        ret = BCM_ERR_OK;
    } else {
        /* Timer is running. Stop it and record the stop time */
        const ARC_TimerIdType arcTimerId = TIM_GetArcTimerIdFromChan(aChanID);
        ret = ARC_TimerGetTickCnt(arcTimerId, &TIM_DrvDev[aChanID].stopTime);
        BCM_ASSERT(BCM_ERR_OK == ret)

        ret = ARC_TimerDeinit(arcTimerId);
        BCM_ASSERT(BCM_ERR_OK == ret)
        TIM_DrvDev[aChanID].state = TIM_DRV_CHANSTATE_STOPPED;
        ret = BCM_ERR_OK;
    }

    if (BCM_ERR_OK != ret) {
        TIM_DrvReportError(aChanID, BRCM_SWDSGN_TIM_DRV_STOP_TIMER_PROC, ret, 0UL, 0UL,
                0UL, 0UL);
    }

    return ret;
}

/**
    @code{.unparsed}
    if (TIM_MAX_CHANNELS <= aChanID)
        return BCM_ERR_INVAL_PARAMS

    if (TIM_DRV_CHANSTATE_UNINIT == TIM_DrvDev[aChanID].state)
        return BCM_ERR_UNINIT

    TIM_DrvDev[aChanID].notifEn = true
    return BCM_ERR_OK
    @endcode

    @trace #BRCM_SWARCH_TIM_SYSTEMENABLENOTIFICATION_PROC
    @trace #BRCM_SWARCH_TIM_SYSCMDHANDLER_PROC
    @trace #BRCM_SWREQ_TIM_NOTIFICATION_ARC
*/
static int32_t TIM_DrvEnableNotification(TIM_ChanIDType aChanID)
{
    int32_t ret;

    if (TIM_MAX_CHANNELS <= aChanID) {
        /* Invalid channel ID */
        ret = BCM_ERR_INVAL_PARAMS;
    } else if (TIM_DRV_CHANSTATE_UNINIT == TIM_DrvDev[aChanID].state) {
        /* Timer channel not in the right state */
        ret = BCM_ERR_UNINIT;
    } else {
        /* All OK. Turn the notifications on  */
        TIM_DrvDev[aChanID].notifEn = true;
        ret = BCM_ERR_OK;
    }

    if (BCM_ERR_OK != ret) {
        TIM_DrvReportError(aChanID, BRCM_SWDSGN_TIM_DRV_ENABLE_NOTIFICATION_PROC, ret,
                0UL, 0UL, 0UL, 0UL);
    }

    return ret;
}

/**
    @code{.unparsed}
    if (TIM_MAX_CHANNELS <= aChanID)
        return BCM_ERR_INVAL_PARAMS

    if (TIM_DRV_CHANSTATE_UNINIT == TIM_DrvDev[aChanID].state)
        return BCM_ERR_UNINIT

    TIM_DrvDev[aChanID].notifEn = false
    return BCM_ERR_OK
    @endcode

    @trace #BRCM_SWARCH_TIM_SYSTEMDISABLENOTIFICATION_PROC
    @trace #BRCM_SWARCH_TIM_SYSCMDHANDLER_PROC
    @trace #BRCM_SWREQ_TIM_NOTIFICATION_ARC
*/
static int32_t TIM_DrvDisableNotification(TIM_ChanIDType aChanID)
{
    int32_t ret;

    if (TIM_MAX_CHANNELS <= aChanID) {
        /* Invalid channel ID */
        ret = BCM_ERR_INVAL_PARAMS;
    } else if (TIM_DRV_CHANSTATE_UNINIT == TIM_DrvDev[aChanID].state) {
        /* Timer channel not in the right state */
        ret = BCM_ERR_UNINIT;
    } else {
        /* All OK. Turn the notifications off  */
        TIM_DrvDev[aChanID].notifEn = false;
        ret = BCM_ERR_OK;
    }

    if (BCM_ERR_OK != ret) {
        TIM_DrvReportError(aChanID, BRCM_SWDSGN_TIM_DRV_DISABLE_NOTIFICATION_PROC, ret,
                0UL, 0UL, 0UL, 0UL);
    }

    return ret;
}

/**
    @code{.unparsed}
    return 0
    @endcode

    @trace #BRCM_SWARCH_TIM_SYSCMDHANDLER_PROC
    @trace #BRCM_SWREQ_TIM_ARC
*/
static TIM_TickType TIM_DrvGetFreeRunningTime(TIM_ChanIDType aChanID)
{
    int32_t ret;
    TIM_TickType runningTime;

    /* Channel ID validation */
    if (TIM_MAX_CHANNELS <= aChanID) {
        /* Invalid channel ID */
        ret = BCM_ERR_INVAL_PARAMS;
        runningTime = 0UL;
    } else {
        /* We do not support free running timers. So nothing to do here */
        ret = BCM_ERR_OK;
        runningTime = 0UL;
    }

    if (BCM_ERR_OK != ret) {
        TIM_DrvReportError(aChanID, BRCM_SWDSGN_TIM_DRV_GET_FREE_RUNNING_TIME_PROC, ret,
                0UL, 0UL, 0UL, 0UL);
    }

    return runningTime;
}

/**
    @code{.unparsed}
    return BCM_GetNsFromCpuCycles(ARC_TimerGetTickCntRTC())
    @endcode

    @trace #BRCM_SWARCH_TIM_SYSTEMGETTIME_PROC
    @trace #BRCM_SWARCH_TIM_SYSCMDHANDLER_PROC
    @trace #BRCM_SWREQ_TIM_ARC
*/
uint64_t TIM_DrvGetTime(void)
{
    return BCM_GetNsFromCpuCycles(ARC_TimerGetTickCntRTC());
}

/**
    @code{.unparsed}
    return TIM_DrvGetTime()
    @endcode

    @trace #BRCM_SWARCH_TIM_SYSTEMGETTIME_PROC
    @trace #BRCM_SWREQ_TIM_ARC
*/
uint64_t TIM_SystemGetTime(void)
{
    return TIM_DrvGetTime();
}

/**
    @code{.unparsed}
    return 0
    @endcode

    @trace #BRCM_SWARCH_TIM_GETTIMERAW_PROC
    @trace #BRCM_SWREQ_TIM_ARC
*/
uint64_t TIM_GetTimeRaw(TIM_ChanIDType aChanID)
{
    return 0ULL;
}

/**
    @code{.unparsed}
    return TIM_DrvStartTimer()
    @endcode

    @trace #BRCM_SWARCH_TIM_SYSTEMSTARTTIMER_PROC
    @trace #BRCM_SWREQ_TIM_ARC
*/
int32_t TIM_SystemStartTimer(TIM_ChanIDType aChanID, TIM_TickType aValue)
{
    return TIM_DrvStartTimer(aChanID, aValue);
}

/**
    @code{.unparsed}
    return TIM_DrvStopTimer()
    @endcode

    @trace #BRCM_SWARCH_TIM_SYSTEMSTOPTIMER_PROC
    @trace #BRCM_SWREQ_TIM_ARC
*/
int32_t TIM_SystemStopTimer(TIM_ChanIDType aChanID)
{
    return TIM_DrvStopTimer(aChanID);
}

/**
    @code{.unparsed}
    return TIM_DrvEnableNotification()
    @endcode

    @trace #BRCM_SWARCH_TIM_SYSTEMENABLENOTIFICATION_PROC
    @trace #BRCM_SWREQ_TIM_NOTIFICATION_ARC
*/
int32_t TIM_SystemEnableNotification(TIM_ChanIDType aChanID)
{
    return TIM_DrvEnableNotification(aChanID);
}

/**
    @code{.unparsed}
    return TIM_SystemDisableNotification()
    @endcode

    @trace #BRCM_SWARCH_TIM_SYSTEMDISABLENOTIFICATION_PROC
    @trace #BRCM_SWREQ_TIM_NOTIFICATION_ARC
*/
int32_t TIM_SystemDisableNotification(TIM_ChanIDType aChanID)
{
    return TIM_DrvDisableNotification(aChanID);
}

/**
    @code{.unparsed}
    if (NULL == aSysIO)
        return BCM_ERR_INVAL_PARAMS

    if (aMagicID == SVC_MAGIC_SPT_ID)
        return BCM_ERR_INVAL_MAGIC

    switch (aCmd) {
        case ANY_VALID_COMMAND:
            call the appropriate helper function
            break;
        default:
            return BCM_ERR_INVAL_PARAMS
    }
    @endcode

    @trace #BRCM_SWARCH_TIM_SYSCMDHANDLER_PROC
    @trace #BRCM_SWREQ_TIM_KERNEL_HANDLER_ARC
*/
void TIM_SysCmdHandler(uint32_t aMagicID, uint32_t aCmd, uint8_t * aSysIO)
{
    TIM_SVCIOType tim;
    tim.data = aSysIO;
    int32_t ret = BCM_ERR_OK;

    if (aSysIO != NULL) {
        if (aMagicID == SVC_MAGIC_SPT_ID) {
            switch (aCmd) {
                case TIM_CMD_INIT:
                    ret = TIM_DrvInit(tim.io->chanID, tim.io->config);
                    break;
                case TIM_CMD_DEINIT:
                    ret = TIM_DrvDeInit(tim.io->chanID);
                    break;
                case TIM_CMD_GET_TIME_ELAPSED:
                    tim.io->elapsedTime = TIM_DrvGetTimeElapsed(tim.io->chanID);
                    break;
                case TIM_CMD_GET_TIME_REMAINING:
                    tim.io->remainingTime = TIM_DrvGetTimeRemaining(tim.io->chanID);
                    break;
                case TIM_CMD_START_TIMER:
                    ret = TIM_DrvStartTimer(tim.io->chanID, tim.io->targetTime);
                    break;
                case TIM_CMD_STOP_TIMER:
                    ret = TIM_DrvStopTimer(tim.io->chanID);
                    break;
                case TIM_CMD_ENABLE_NOTIFICATION:
                    ret = TIM_DrvEnableNotification(tim.io->chanID);
                    break;
                case TIM_CMD_DISABLE_NOTIFICATION:
                    ret = TIM_DrvDisableNotification(tim.io->chanID);
                    break;
                case TIM_CMD_GET_FREE_RUNNING_TIME:
                    tim.io->elapsedTime = TIM_DrvGetFreeRunningTime(tim.io->chanID);
                    break;
                case TIM_CMD_GET_TIME:
                    tim.io->sysTime = TIM_DrvGetTime();
                    break;
               default:
                    ret = BCM_ERR_INVAL_PARAMS;
                    break;
            }
        } else {
            ret = BCM_ERR_INVAL_MAGIC;
        }

        tim.io->retVal = ret;

    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }

    if (BCM_ERR_OK != ret) {
        const uint32_t values[4] = {aMagicID, aCmd, (uint32_t)aSysIO, 0UL};
        BCM_ReportError(BCM_SPT_ID, (uint8_t)0xFFU, BRCM_SWDSGN_TIM_SYS_CMD_HANDLER_PROC, ret,
                        4UL, values);
    }
}

/**
    @code{.unparsed}
    fireCallback = (TIM_DRV_CHANSTATE_RUNNING == TIM_DrvDev[aChanID].state) &&
                   (true == TIM_DrvDev[aChanID].notifEn)

    arcTimerId = TIM_GetArcTimerIdFromChan(aChanID)
    if (TIM_DRV_CHANSTATE_RUNNING != TIM_DrvDev[aChanID].state)
        ARC_TimerDeinit(arcTimerId)
    else if (TIM_CHAN_MODE_ONE_SHOT == TIM_DrvDev[aChanID].chanMode)
        TIM_DrvDev[aChanID].state = TIM_DRV_CHANSTATE_STOPPED
        TIM_DrvDev[aChanID].stopTime = TIM_DrvDev[aChanID].targetTime
        ARC_TimerDeinit(arcTimerId)
    else
        ARC_TimerHandleInterrupt(arcTimerId);

    if (fireCallback)
        TIM_CallBackTable[aChanID]()
    @endcode

    @trace #BRCM_SWARCH_TIM_IRQHANDLER_PROC
    @trace #BRCM_SWREQ_TIM_KERNEL_HANDLER_ARC
*/
void TIM_IRQHandler(TIM_ChanIDType aChanID)
{
    BCM_ASSERT(TIM_MAX_CHANNELS > aChanID);

    const uint32_t fireCallback =
        (TIM_DRV_CHANSTATE_RUNNING == TIM_DrvDev[aChanID].state) &&
        (true == TIM_DrvDev[aChanID].notifEn)
    ;
    const ARC_TimerIdType arcTimerId = TIM_GetArcTimerIdFromChan(aChanID);

    /* Handle the interrupt */
    if (TIM_DRV_CHANSTATE_RUNNING != TIM_DrvDev[aChanID].state) {
        /*
            This can only mean that the timer has been kicked off
            by someone else (not this driver)...

            Reset the timer.
        */
        (void) ARC_TimerDeinit(arcTimerId);
    } else if (TIM_CHAN_MODE_ONE_SHOT == TIM_DrvDev[aChanID].chanMode) {
        /* One shot timer expired */
        TIM_DrvDev[aChanID].state = TIM_DRV_CHANSTATE_STOPPED;
        TIM_DrvDev[aChanID].stopTime = TIM_DrvDev[aChanID].targetTime;
        (void) ARC_TimerDeinit(arcTimerId);
    } else {
        /* Handle the interrupt */
        ARC_TimerHandleInterrupt(arcTimerId);
    }

    /* Fire callback if needed */
    if (1UL == fireCallback) {
        TIM_CallBackTable[aChanID]();
    }

    return;
}

/** @} */
