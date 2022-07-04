/*****************************************************************************
 Copyright 2016-2021 Broadcom Limited.  All rights reserved.

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

    @file sp804.c
    @brief TIM driver implementation
    @version 0.30 Imported from docx
*/

#include <string.h>
#include <bcm_err.h>
#include <svc.h>
#include <bcm_utils.h>
#include <interrupt.h>
#include <tim_osil.h>
#include <tim_rdb.h>
#include <tim_osil.h>

/**
    @name TIM driver design IDs
    @{
    @brief Design IDs for TIM driver
*/
#define BRCM_SWDSGN_TIM_CONTROL_TYPE                      (0xB301U)    /**< @brief #TIM_ControlType               */
#define BRCM_SWDSGN_TIM_DRV_REPORTERROR_PROC              (0xB302U)    /**< @brief #TIM_DrvReportError            */
#define BRCM_SWDSGN_TIM_MAX_VALUE_MACRO                   (0xB303U)    /**< @brief #TIM_MAX_VALUE                 */
#define BRCM_SWDSGN_TIM_DRV_CHANSTATE_TYPE                (0xB304U)    /**< @brief #TIM_DrvChanStateType          */
#define BRCM_SWDSGN_TIM_DRV_DEV_TYPE                      (0xB305U)    /**< @brief #TIM_DrvDevType                */
#define BRCM_SWDSGN_TIM_DRV_DEV_GLOBAL                    (0xB306U)    /**< @brief #TIM_DrvDev                    */
#define BRCM_SWDSGN_TIM_SP804_REGS_GLOBAL                 (0xB307U)    /**< @brief #TIM_SP804_Regs                */
#define BRCM_SWDSGN_TIM_SP804_GETTIMEELAPSED_PROC         (0xB308U)    /**< @brief #TIM_SP804GetTimeElapsed       */
#define BRCM_SWDSGN_TIM_SP804_INIT_PROC                   (0xB309U)    /**< @brief #TIM_SP804Init                 */
#define BRCM_SWDSGN_TIM_SP804_IRQHANDLER_PROC             (0xB30AU)    /**< @brief #TIM_SP804IRQHandler           */
#define BRCM_SWDSGN_TIM_DRV_GETFREERUNNINGTIME_PROC       (0xB30BU)    /**< @brief #TIM_DrvGetFreeRunningTime     */
#define BRCM_SWDSGN_TIM_DRV_DISABLENOTIFICATION_PROC      (0xB30CU)    /**< @brief #TIM_DrvDisableNotification    */
#define BRCM_SWDSGN_TIM_SYSTEMDISABLENOTIFICATION_PROC    (0xB30DU)    /**< @brief #TIM_SystemDisableNotification */
#define BRCM_SWDSGN_TIM_DRV_ENABLENOTIFICATION_PROC       (0xB30EU)    /**< @brief #TIM_DrvEnableNotification     */
#define BRCM_SWDSGN_TIM_SYSTEMENABLENOTIFICATION_PROC     (0xB30FU)    /**< @brief #TIM_SystemEnableNotification  */
#define BRCM_SWDSGN_TIM_DRV_GETTIMEREMAINING_PROC         (0xB310U)    /**< @brief #TIM_DrvGetTimeRemaining       */
#define BRCM_SWDSGN_TIM_DRV_GETTIMEELAPSED_PROC           (0xB311U)    /**< @brief #TIM_DrvGetTimeElapsed         */
#define BRCM_SWDSGN_TIM_DRV_STOPTIMER_PROC                (0xB312U)    /**< @brief #TIM_DrvStopTimer              */
#define BRCM_SWDSGN_TIM_SYSTEM_STOPTIMER_PROC             (0xB313U)    /**< @brief #TIM_SystemStopTimer           */
#define BRCM_SWDSGN_TIM_DRV_STARTTIMER_PROC               (0xB314U)    /**< @brief #TIM_DrvStartTimer             */
#define BRCM_SWDSGN_TIM_SYSTEM_STARTTIMER_PROC            (0xB315U)    /**< @brief #TIM_SystemStartTimer          */
#define BRCM_SWDSGN_TIM_DRV_DEINIT_PROC                   (0xB316U)    /**< @brief #TIM_DrvDeInit                 */
#define BRCM_SWDSGN_TIM_DRV_INIT_PROC                     (0xB317U)    /**< @brief #TIM_DrvInit                   */
#define BRCM_SWDSGN_TIM_SVCIO_TYPE                        (0xB318U)    /**< @brief #TIM_SVCIOType                 */
#define BRCM_SWDSGN_TIM_SYSCMDHANDLER_PROC                (0xB319U)    /**< @brief #TIM_SysCmdHandler             */
#define BRCM_SWDSGN_TIM_IRQHANDLER_PROC                   (0xB31AU)    /**< @brief #TIM_IRQHandler                */
#define BRCM_SWDSGN_TIM_SYSTEMGETTIME_PROC                (0xB31BU)    /**< @brief #TIM_SystemGetTime             */
#define BRCM_SWDSGN_TIM_GETTIMERAW_PROC                   (0xB31CU)    /**< @brief #TIM_GetTimeRaw                */
/** @} */

/**
    @name TIM_ControlType
    @{
    @brief TIM_ControlType

    @trace #BRCM_SWARCH_TIM_INIT_PROC
    @trace #BRCM_SWARCH_TIM_STARTTIMER_PROC
    @trace #BRCM_SWARCH_TIM_STOPTIMER_PROC
    @trace #BRCM_SWARCH_TIM_DEINIT_PROC
    @trace #BRCM_SWARCH_TIM_DISABLENOTIFICATION_PROC
    @trace #BRCM_SWARCH_TIM_ENABLENOTIFICATION_PROC
    @trace #BRCM_SWREQ_TIM
*/
typedef uint32_t TIM_ControlType;                       /**< @brief Register values                     */
#define TIM_CONTROL_TIMER_EN_MASK             (0x80UL)  /**< @brief TIM_CONTROL_TIMER_EN_MASK           */
#define TIM_CONTROL_TIMER_EN_SHIFT            (7UL)     /**< @brief TIM_CONTROL_TIMER_EN_SHIFT          */
#define TIM_CONTROL_MODE_PERIOD_MASK          (0x40UL)  /**< @brief TIM_CONTROL_MODE_PERIOD_MASK        */
#define TIM_CONTROL_MODE_PERIOD_SHIFT         (6UL)     /**< @brief TIM_CONTROL_MODE_PERIOD_SHIFT       */
#define TIM_CONTROL_INT_EN_MASK               (0x20UL)  /**< @brief TIM_CONTROL_INT_EN_MASK             */
#define TIM_CONTROL_INT_EN_SHIFT              (5UL)     /**< @brief TIM_CONTROL_INT_EN_SHIFT            */
#define TIM_CONTROL_PRESCALE_MASK             (0xCUL)   /**< @brief TIM_CONTROL_PRESCALE_MASK           */
#define TIM_CONTROL_PRESCALE_SHIFT            (2UL)     /**< @brief TIM_CONTROL_PRESCALE_SHIFT          */
#define TIM_CONTROL_PRESCALE_STAGE_0          (0UL)     /**< @brief TIM_CONTROL_PRESCALE_STAGE_0        */
#define TIM_CONTROL_PRESCALE_STAGE_4          (1UL)     /**< @brief TIM_CONTROL_PRESCALE_STAGE_4        */
#define TIM_CONTROL_PRESCALE_STAGE_8          (2UL)     /**< @brief TIM_CONTROL_PRESCALE_STAGE_8        */
#define TIM_CONTROL_SIZE_32_BIT_MASK          (0x2UL)   /**< @brief TIM_CONTROL_SIZE_32_BIT_MASK        */
#define TIM_CONTROL_SIZE_32_BIT_SHIFT         (1UL)     /**< @brief TIM_CONTROL_SIZE_32_BIT_SHIFT       */
#define TIM_CONTROL_ONE_SHOT_MODE_MASK        (0x1UL)   /**< @brief TIM_CONTROL_ONE_SHOT_MODE_MASK      */
#define TIM_CONTROL_ONE_SHOT_MODE_SHIFT       (0UL)     /**< @brief TIM_CONTROL_ONE_SHOT_MODE_SHIFT     */
#define TIM_CONTROL_INT_CLR_MASK              (0x1UL)   /**< @brief TIM_CONTROL_INT_CLR_MASK            */

/** @} */

/**
    @trace #BRCM_SWARCH_TIM_GETFREERUNNINGTIME_PROC
    @trace #BRCM_SWARCH_TIM_GETTIME_PROC
    @trace #BRCM_SWARCH_TIM_DISABLENOTIFICATION_PROC
    @trace #BRCM_SWARCH_TIM_ENABLENOTIFICATION_PROC
    @trace #BRCM_SWARCH_TIM_GETTIMEREMAINING_PROC
    @trace #BRCM_SWARCH_TIM_GETTIMEELAPSED_PROC
    @trace #BRCM_SWARCH_TIM_STOPTIMER_PROC
    @trace #BRCM_SWARCH_TIM_STARTTIMER_PROC
    @trace #BRCM_SWARCH_TIM_DEINIT_PROC
    @trace #BRCM_SWARCH_TIM_INIT_PROC
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

/**
    @trace #BRCM_SWARCH_TIM_INIT_PROC
    @trace #BRCM_SWARCH_TIM_STARTTIMER_PROC
    @trace #BRCM_SWREQ_TIM
*/
#define TIM_MAX_VALUE(timerWidth) \
    ((TIM_WIDTH_32_BIT == (timerWidth)) ? 0xFFFFFFFFUL : 0xFFFFUL)

/**
    @trace #BRCM_SWARCH_TIM_IRQHANDLER_PROC
    @trace #BRCM_SWARCH_TIM_GETFREERUNNINGTIME_PROC
    @trace #BRCM_SWARCH_TIM_GETTIME_PROC
    @trace #BRCM_SWARCH_TIM_DISABLENOTIFICATION_PROC
    @trace #BRCM_SWARCH_TIM_ENABLENOTIFICATION_PROC
    @trace #BRCM_SWARCH_TIM_GETTIMEREMAINING_PROC
    @trace #BRCM_SWARCH_TIM_GETTIMEELAPSED_PROC
    @trace #BRCM_SWARCH_TIM_STOPTIMER_PROC
    @trace #BRCM_SWARCH_TIM_STARTTIMER_PROC
    @trace #BRCM_SWARCH_TIM_DEINIT_PROC
    @trace #BRCM_SWARCH_TIM_INIT_PROC
    @trace #BRCM_SWREQ_TIM
*/
typedef uint32_t TIM_DrvChanStateType;          /**< @brief TIM_DrvChanStateType        */
#define TIM_DRV_CHANSTATE_UNINIT       (0UL)    /**< @brief TIM_DRV_CHANSTATE_UNINIT    */
#define TIM_DRV_CHANSTATE_INIT         (1UL)    /**< @brief TIM_DRV_CHANSTATE_INIT      */
#define TIM_DRV_CHANSTATE_RUNNING      (2UL)    /**< @brief TIM_DRV_CHANSTATE_RUNNING   */
#define TIM_DRV_CHANSTATE_STOPPED      (3UL)    /**< @brief TIM_DRV_CHANSTATE_STOPPED   */

/**
    @trace #BRCM_SWARCH_TIM_IRQHANDLER_PROC
    @trace #BRCM_SWARCH_TIM_GETFREERUNNINGTIME_PROC
    @trace #BRCM_SWARCH_TIM_GETTIME_PROC
    @trace #BRCM_SWARCH_TIM_DISABLENOTIFICATION_PROC
    @trace #BRCM_SWARCH_TIM_ENABLENOTIFICATION_PROC
    @trace #BRCM_SWARCH_TIM_GETTIMEREMAINING_PROC
    @trace #BRCM_SWARCH_TIM_GETTIMEELAPSED_PROC
    @trace #BRCM_SWARCH_TIM_STOPTIMER_PROC
    @trace #BRCM_SWARCH_TIM_STARTTIMER_PROC
    @trace #BRCM_SWARCH_TIM_DEINIT_PROC
    @trace #BRCM_SWARCH_TIM_INIT_PROC
    @trace #BRCM_SWREQ_TIM
*/
typedef struct sTIM_DrvDevType {
    uint32_t                loadValue;             /**< @brief loadValue    */
    uint32_t                divisor;               /**< @brief divisor      */
    uint32_t                sysTimeEn;             /**< @brief sysTimeEn    */
    uint64_t                sysTimeCnt;            /**< @brief sysTimeCnt   */
    TIM_DrvChanStateType    state;                 /**< @brief state        */
    TIM_ChanModeType        chanMode;              /**< @brief chanMode     */
    TIM_WidthType           width;                 /**< @brief width        */
} TIM_DrvDevType;

/**
    @trace #BRCM_SWARCH_TIM_IRQHANDLER_PROC
    @trace #BRCM_SWARCH_TIM_GETFREERUNNINGTIME_PROC
    @trace #BRCM_SWARCH_TIM_GETTIME_PROC
    @trace #BRCM_SWARCH_TIM_DISABLENOTIFICATION_PROC
    @trace #BRCM_SWARCH_TIM_ENABLENOTIFICATION_PROC
    @trace #BRCM_SWARCH_TIM_GETTIMEREMAINING_PROC
    @trace #BRCM_SWARCH_TIM_GETTIMEELAPSED_PROC
    @trace #BRCM_SWARCH_TIM_STOPTIMER_PROC
    @trace #BRCM_SWARCH_TIM_STARTTIMER_PROC
    @trace #BRCM_SWARCH_TIM_DEINIT_PROC
    @trace #BRCM_SWARCH_TIM_INIT_PROC
    @trace #BRCM_SWREQ_TIM
*/
static TIM_DrvDevType TIM_DrvDev[TIM_MAX_CHANNELS] COMP_SECTION(".bss.drivers");

/**
    @trace #BRCM_SWARCH_TIM_INIT_PROC
    @trace #BRCM_SWARCH_TIM_DEINIT_PROC
    @trace #BRCM_SWARCH_TIM_GETTIMEREMAINING_PROC
    @trace #BRCM_SWARCH_TIM_GETFREERUNNINGTIME_PROC
    @trace #BRCM_SWARCH_TIM_GETTIME_PROC
    @trace #BRCM_SWARCH_TIM_GETTIMERAW_PROC
    @trace #BRCM_SWARCH_TIM_GETTIMEELAPSED_PROC
    @trace #BRCM_SWARCH_TIM_STOPTIMER_PROC
    @trace #BRCM_SWARCH_TIM_STARTTIMER_PROC
    @trace #BRCM_SWARCH_TIM_ENABLENOTIFICATION_PROC
    @trace #BRCM_SWARCH_TIM_DISABLENOTIFICATION_PROC
    @trace #BRCM_SWARCH_TIM_IRQHANDLER_PROC
    @trace #BRCM_SWREQ_TIM
*/
static TIM_RDBType *const TIM_SP804_Regs = (TIM_RDBType *)TIM_BASE;

/**
    @trace #BRCM_SWARCH_TIM_GETFREERUNNINGTIME_PROC
    @trace #BRCM_SWARCH_TIM_GETTIME_PROC
    @trace #BRCM_SWARCH_TIM_GETTIMERAW_PROC
    @trace #BRCM_SWARCH_TIM_GETTIMEELAPSED_PROC
    @trace #BRCM_SWREQ_TIM
*/
static TIM_TickType TIM_SP804GetTimeElapsed(TIM_ChanIDType aChanID)
{
    uint32_t targetTime;
    uint32_t currTime;
    TIM_TickType timeElapsed;

    targetTime = TIM_SP804_Regs->tim_chan_regs[aChanID].timer1load;
    currTime = TIM_SP804_Regs->tim_chan_regs[aChanID].timer1value;
    timeElapsed = targetTime - currTime;

    return timeElapsed;
}

/**
    @trace #BRCM_SWARCH_TIM_INIT_PROC
    @trace #BRCM_SWREQ_TIM
*/
static int32_t TIM_SP804Init(const TIM_ConfigType *const aConfig)
{
    int32_t retVal = BCM_ERR_OK;
    uint32_t prescale;
    TIM_ChanIDType chanID = aConfig->chanID;

    /* Disable interrupts and timer module */
    TIM_SP804_Regs->tim_chan_regs[chanID].timer1control &= ~(TIM_CONTROL_INT_EN_MASK
            | TIM_CONTROL_TIMER_EN_MASK);
    /* Clear the interrupt */
    TIM_SP804_Regs->tim_chan_regs[chanID].timer1intclr |= TIM_CONTROL_INT_CLR_MASK;
    /* Set the timer mode */
    switch (aConfig->chanMode) {
    case TIM_CHAN_MODE_ONE_SHOT:
        TIM_SP804_Regs->tim_chan_regs[chanID].timer1control |= TIM_CONTROL_ONE_SHOT_MODE_MASK;
        break;
    case TIM_CHAN_MODE_FREE_RUNNING:
        TIM_SP804_Regs->tim_chan_regs[chanID].timer1control &= ~(TIM_CONTROL_ONE_SHOT_MODE_MASK
                    | TIM_CONTROL_MODE_PERIOD_MASK);
        break;
    case TIM_CHAN_MODE_PERIODIC:
        TIM_SP804_Regs->tim_chan_regs[chanID].timer1control |= TIM_CONTROL_MODE_PERIOD_MASK;
        TIM_SP804_Regs->tim_chan_regs[chanID].timer1control &= ~TIM_CONTROL_ONE_SHOT_MODE_MASK;
        break;
    default:
        retVal = BCM_ERR_INVAL_PARAMS;
        break;
    }
    if (BCM_ERR_OK != retVal) {
        goto err;
    }
    /* Set the prescale value */
    switch (aConfig->prescale) {
    case TIM_PRESCALE_DIV_1:
        prescale = TIM_CONTROL_PRESCALE_STAGE_0;
        break;
    case TIM_PRESCALE_DIV_16:
        prescale = TIM_CONTROL_PRESCALE_STAGE_4;
        break;
    case TIM_PRESCALE_DIV_256:
        prescale = TIM_CONTROL_PRESCALE_STAGE_8;
        break;
    default:
        retVal = BCM_ERR_INVAL_PARAMS;
        break;
    }
    if (BCM_ERR_OK != retVal) {
        goto err;
    }
    TIM_SP804_Regs->tim_chan_regs[chanID].timer1control &= ~TIM_CONTROL_PRESCALE_MASK;
    TIM_SP804_Regs->tim_chan_regs[chanID].timer1control |=
        ((prescale << TIM_CONTROL_PRESCALE_SHIFT) & TIM_CONTROL_PRESCALE_MASK);
    /* Set the size of the timer */
    switch (aConfig->width) {
    case TIM_WIDTH_16_BIT:
        TIM_SP804_Regs->tim_chan_regs[chanID].timer1control &= ~TIM_CONTROL_SIZE_32_BIT_MASK;
        break;
    case TIM_WIDTH_32_BIT:
        TIM_SP804_Regs->tim_chan_regs[chanID].timer1control |= TIM_CONTROL_SIZE_32_BIT_MASK;
        break;
    default:
        retVal = BCM_ERR_INVAL_PARAMS;
        break;
    }

err:
    return retVal;
}

/**
    @trace #BRCM_SWARCH_TIM_IRQHANDLER_PROC
    @trace #BRCM_SWREQ_TIM_KERNEL_HANDLER
*/
static void TIM_SP804IRQHandler(TIM_ChanIDType aChanID)
{
    TIM_CbType callBackFunc = TIM_CallBackTable[aChanID];

    /* Clear the interrupt */
    TIM_SP804_Regs->tim_chan_regs[aChanID].timer1intclr |= TIM_CONTROL_INT_CLR_MASK;

    if (TRUE == TIM_DrvDev[aChanID].sysTimeEn) {
        TIM_DrvDev[aChanID].sysTimeCnt++;
    }

    if (TIM_DRV_CHANSTATE_RUNNING == TIM_DrvDev[aChanID].state) {
        if (TIM_CHAN_MODE_ONE_SHOT == TIM_DrvDev[aChanID].chanMode) {
            TIM_DrvDev[aChanID].state = TIM_DRV_CHANSTATE_STOPPED;
        }

        /* BCM_TEST_ADD_PROBE(BCM_SPT_ID, BRCM_SWPTSEQ_TIMER_PERIODIC_TEST,
                BRCM_SWPTST_TIM_IRQHANDLER_NEG_NULL_CB,
                callBackFunc = NULL) */
        if (NULL != callBackFunc) {
            callBackFunc();
        }
    }
}

/**
    @trace #BRCM_SWARCH_TIM_GETFREERUNNINGTIME_PROC
    @trace #BRCM_SWREQ_TIM
*/
static TIM_TickType TIM_DrvGetFreeRunningTime(TIM_ChanIDType aChanID)
{
    int32_t retVal = BCM_ERR_OK;
    TIM_TickType elapsedTime = 0UL;

    if (TIM_MAX_CHANNELS <= aChanID) {
        retVal = BCM_ERR_INVAL_PARAMS;
        goto err;
    }
    if (TIM_DRV_CHANSTATE_UNINIT == TIM_DrvDev[aChanID].state) {
        retVal = BCM_ERR_UNINIT;
        goto err;
    }
    if (TIM_CHAN_MODE_FREE_RUNNING != TIM_DrvDev[aChanID].chanMode) {
        retVal = BCM_ERR_NOT_FOUND;
        goto err;
    }
    elapsedTime = TIM_SP804GetTimeElapsed(aChanID);

err:
    if (BCM_ERR_OK != retVal) {
        TIM_DrvReportError(aChanID, BRCM_SWDSGN_TIM_DRV_GETFREERUNNINGTIME_PROC,
                retVal, 0UL, 0UL, 0UL, 0UL);
    }
    return elapsedTime;
}

/**
    @trace #BRCM_SWARCH_TIM_GETTIME_PROC
    @trace #BRCM_SWREQ_TIM
*/
uint64_t TIM_SystemGetTime(void)
{
    uint32_t i;
    uint32_t ticks;
    uint64_t sysTime = 0ULL;
    INTR_FlagType flag;
    uint64_t nsPerTick;

    for (i = 0UL; i < TIM_MAX_CHANNELS; i++) {
        if (TRUE == TIM_DrvDev[i].sysTimeEn) {
            flag = INTR_Suspend();
            ticks = TIM_SP804GetTimeElapsed(i);

            _Static_assert(0UL == (1000000000UL % TIM_CLOCK), "Clock resolution is not in ns");

            nsPerTick = TIM_DrvDev[i].divisor * (1000000000ULL / TIM_CLOCK);
            sysTime = ((TIM_DrvDev[i].sysTimeCnt * TIM_DrvDev[i].loadValue) + ticks) * nsPerTick;
            INTR_Resume(flag);
            break;
        }
    }
    if (TIM_MAX_CHANNELS == i) {
        TIM_DrvReportError(i, BRCM_SWDSGN_TIM_SYSTEMGETTIME_PROC, BCM_ERR_NOT_FOUND, 0UL,
                0UL, 0UL, 0UL);
    }

    return sysTime;
}

/**
    @trace #BRCM_SWARCH_TIM_GETTIMERAW_PROC
    @trace #BRCM_SWREQ_TIM
*/
uint64_t TIM_GetTimeRaw(TIM_ChanIDType aChanID)
{
    uint32_t ticks;
    uint32_t control;
    uint32_t prescale;
    uint32_t divisor;
    uint64_t sysTime = 0ULL;
    INTR_FlagType flag;
    int32_t retVal = BCM_ERR_OK;
    uint64_t nsPerTick;

    if (TIM_MAX_CHANNELS <= aChanID) {
        retVal = BCM_ERR_INVAL_PARAMS;
        goto err;
    }

    flag = INTR_Suspend();
    control = TIM_SP804_Regs->tim_chan_regs[aChanID].timer1control;

    prescale = (control & TIM_CONTROL_PRESCALE_MASK) >> TIM_CONTROL_PRESCALE_SHIFT;
    if (TIM_PRESCALE_DIV_1 == prescale) {
        divisor = 1UL;
    } else if (TIM_PRESCALE_DIV_16 == prescale) {
        divisor = 16UL;
    } else {
        divisor = 256UL;
    }

    ticks = TIM_SP804GetTimeElapsed(aChanID);

    _Static_assert(0UL == (1000000000UL % TIM_CLOCK), "Clock resolution is not in ns");

    nsPerTick = divisor * (1000000000ULL / TIM_CLOCK);
    sysTime = ticks * nsPerTick;
    INTR_Resume(flag);

err:
    if (BCM_ERR_OK != retVal) {
        TIM_DrvReportError(aChanID, BRCM_SWDSGN_TIM_GETTIMERAW_PROC, retVal,
                0UL, 0UL, 0UL, 0UL);
    }

    return sysTime;
}

/**
    @trace #BRCM_SWARCH_TIM_DISABLENOTIFICATION_PROC
    @trace #BRCM_SWREQ_TIM_NOTIFICATION
*/
static int32_t TIM_DrvDisableNotification(TIM_ChanIDType aChanID)
{
    int32_t retVal = BCM_ERR_OK;
    TIM_CbType callBackFunc;

    if (TIM_MAX_CHANNELS <= aChanID) {
        retVal = BCM_ERR_INVAL_PARAMS;
        goto err;
    }
    if (TIM_DRV_CHANSTATE_UNINIT == TIM_DrvDev[aChanID].state) {
        retVal = BCM_ERR_UNINIT;
        goto err;
    }
    if (TIM_CHAN_MODE_FREE_RUNNING == TIM_DrvDev[aChanID].chanMode) {
        retVal = BCM_ERR_NOSUPPORT;
        goto err;
    }

    callBackFunc = TIM_CallBackTable[aChanID];
    /* BCM_TEST_ADD_PROBE(BCM_SPT_ID, BRCM_SWPTSEQ_TIMER_PERIODIC_TEST,
            BRCM_SWPTST_TIM_DISABLENOTIFICATION_NEG_NULL_CB,
            callBackFunc = NULL) */
    if (NULL == callBackFunc) {
        retVal = BCM_ERR_UNKNOWN;
        goto err;
    }

    /* Disable interrupt */
    TIM_SP804_Regs->tim_chan_regs[aChanID].timer1control &= ~TIM_CONTROL_INT_EN_MASK;

err:
    if (BCM_ERR_OK != retVal) {
        TIM_DrvReportError(aChanID, BRCM_SWDSGN_TIM_DRV_DISABLENOTIFICATION_PROC, retVal,
                0UL, 0UL, 0UL, 0UL);
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_TIM_SYSTEMDISABLENOTIFICATION_PROC
    @trace #BRCM_SWREQ_TIM_NOTIFICATION
*/
int32_t TIM_SystemDisableNotification(TIM_ChanIDType aChanID)
{
    return TIM_DrvDisableNotification(aChanID);
}

/**
    @trace #BRCM_SWARCH_TIM_ENABLENOTIFICATION_PROC
    @trace #BRCM_SWREQ_TIM_NOTIFICATION
*/
static int32_t TIM_DrvEnableNotification(TIM_ChanIDType aChanID)
{
    int32_t retVal = BCM_ERR_OK;
    TIM_CbType callBackFunc;

    if (TIM_MAX_CHANNELS <= aChanID) {
        retVal = BCM_ERR_INVAL_PARAMS;
        goto err;
    }
    if (TIM_DRV_CHANSTATE_UNINIT == TIM_DrvDev[aChanID].state) {
        retVal = BCM_ERR_UNINIT;
        goto err;
    }
    if (TIM_CHAN_MODE_FREE_RUNNING == TIM_DrvDev[aChanID].chanMode) {
        retVal = BCM_ERR_NOSUPPORT;
        goto err;
    }

    callBackFunc = TIM_CallBackTable[aChanID];
    /* BCM_TEST_ADD_PROBE(BCM_SPT_ID, BRCM_SWPTSEQ_TIMER_PERIODIC_TEST,
            BRCM_SWPTST_TIM_ENABLENOTIFICATION_NEG_NULL_CB,
            callBackFunc = NULL) */
    if (NULL == callBackFunc) {
        retVal = BCM_ERR_UNKNOWN;
        goto err;
    }

    /* Enable interrupt */
    TIM_SP804_Regs->tim_chan_regs[aChanID].timer1control |= TIM_CONTROL_INT_EN_MASK;

err:
    if (BCM_ERR_OK != retVal) {
        TIM_DrvReportError(aChanID, BRCM_SWDSGN_TIM_DRV_ENABLENOTIFICATION_PROC, retVal,
                0UL, 0UL, 0UL, 0UL);
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_TIM_SYSTEMENABLENOTIFICATION_PROC
    @trace #BRCM_SWREQ_TIM_NOTIFICATION
*/
int32_t TIM_SystemEnableNotification(TIM_ChanIDType aChanID)
{
    return TIM_DrvEnableNotification(aChanID);
}

/**
    @trace #BRCM_SWARCH_TIM_GETTIMEREMAINING_PROC
    @trace #BRCM_SWREQ_TIM
*/
static TIM_TickType TIM_DrvGetTimeRemaining(TIM_ChanIDType aChanID)
{
    int32_t retVal = BCM_ERR_OK;
    TIM_TickType remainingTime = 0UL;

    if (TIM_MAX_CHANNELS <= aChanID) {
        retVal = BCM_ERR_INVAL_PARAMS;
        goto err;
    }
    if (TIM_DRV_CHANSTATE_UNINIT == TIM_DrvDev[aChanID].state) {
        retVal = BCM_ERR_UNINIT;
        goto err;
    }
    if (TIM_CHAN_MODE_FREE_RUNNING == TIM_DrvDev[aChanID].chanMode) {
        retVal = BCM_ERR_NOSUPPORT;
        goto err;
    }
    if (TIM_DRV_CHANSTATE_INIT == TIM_DrvDev[aChanID].state) {
        retVal = BCM_ERR_OK;
        goto err;
    }
    remainingTime = TIM_SP804_Regs->tim_chan_regs[aChanID].timer1value;

err:
    if (BCM_ERR_OK != retVal) {
        TIM_DrvReportError(aChanID, BRCM_SWDSGN_TIM_DRV_GETTIMEREMAINING_PROC, retVal,
                0UL, 0UL, 0UL, 0UL);
    }
    return remainingTime;
}

/**
    @trace #BRCM_SWARCH_TIM_GETTIMEELAPSED_PROC
    @trace #BRCM_SWREQ_TIM
*/
static TIM_TickType TIM_DrvGetTimeElapsed(TIM_ChanIDType aChanID)
{
    int32_t retVal = BCM_ERR_OK;
    TIM_TickType elapsedTime = 0UL;

    if (TIM_MAX_CHANNELS <= aChanID) {
        retVal = BCM_ERR_INVAL_PARAMS;
        goto err;
    }
    if (TIM_DRV_CHANSTATE_UNINIT == TIM_DrvDev[aChanID].state) {
        retVal = BCM_ERR_UNINIT;
        goto err;
    }
    if (TIM_CHAN_MODE_FREE_RUNNING == TIM_DrvDev[aChanID].chanMode) {
        retVal = BCM_ERR_NOSUPPORT;
        goto err;
    }
    if (TIM_DRV_CHANSTATE_INIT == TIM_DrvDev[aChanID].state) {
        retVal = BCM_ERR_OK;
        goto err;
    }
    elapsedTime = TIM_SP804GetTimeElapsed(aChanID);

err:
    if (BCM_ERR_OK != retVal) {
        TIM_DrvReportError(aChanID, BRCM_SWDSGN_TIM_DRV_GETTIMEELAPSED_PROC, retVal, 0UL,
                0UL, 0UL, 0UL);
    }
    return elapsedTime;
}

/**
    @trace #BRCM_SWARCH_TIM_STOPTIMER_PROC
    @trace #BRCM_SWREQ_TIM
*/
static int32_t TIM_DrvStopTimer(TIM_ChanIDType aChanID)
{
    int32_t retVal = BCM_ERR_OK;

    if (TIM_MAX_CHANNELS <= aChanID) {
        retVal = BCM_ERR_INVAL_PARAMS;
        goto err;
    }
    if (TIM_DRV_CHANSTATE_UNINIT == TIM_DrvDev[aChanID].state) {
        retVal = BCM_ERR_UNINIT;
        goto err;
    }
    if (TIM_CHAN_MODE_FREE_RUNNING == TIM_DrvDev[aChanID].chanMode) {
        retVal = BCM_ERR_NOSUPPORT;
        goto err;
    }
    if (TIM_DRV_CHANSTATE_RUNNING != TIM_DrvDev[aChanID].state) {
        retVal = BCM_ERR_OK;
        goto err;
    }

    /* Disable Timer module */
    TIM_SP804_Regs->tim_chan_regs[aChanID].timer1control &= ~TIM_CONTROL_TIMER_EN_MASK;

    TIM_DrvDev[aChanID].state = TIM_DRV_CHANSTATE_STOPPED;

err:
    if (BCM_ERR_OK != retVal) {
        TIM_DrvReportError(aChanID, BRCM_SWDSGN_TIM_DRV_STOPTIMER_PROC, retVal, 0UL, 0UL,
                0UL, 0UL);
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_TIM_SYSTEMSTOPTIMER_PROC
    @trace #BRCM_SWREQ_TIM
*/
int32_t TIM_SystemStopTimer(TIM_ChanIDType aChanID)
{
    return TIM_DrvStopTimer(aChanID);
}

/**
    @trace #BRCM_SWARCH_TIM_STARTTIMER_PROC
    @trace #BRCM_SWREQ_TIM
*/
static int32_t TIM_DrvStartTimer(TIM_ChanIDType aChanID,
                       TIM_TickType aValue)
{
    int32_t retVal = BCM_ERR_OK;

    if (TIM_MAX_CHANNELS <= aChanID) {
        retVal = BCM_ERR_INVAL_PARAMS;
        goto err;
    }
    if (TIM_DRV_CHANSTATE_UNINIT == TIM_DrvDev[aChanID].state) {
        retVal = BCM_ERR_UNINIT;
        goto err;
    }
    if (TIM_CHAN_MODE_FREE_RUNNING == TIM_DrvDev[aChanID].chanMode) {
        retVal = BCM_ERR_NOSUPPORT;
        goto err;
    }
    if (TIM_DRV_CHANSTATE_RUNNING == TIM_DrvDev[aChanID].state) {
        retVal = BCM_ERR_BUSY;
        goto err;
    }
    if ((0UL == aValue) || (TIM_MAX_VALUE(TIM_DrvDev[aChanID].width) < aValue)) {
        retVal = BCM_ERR_INVAL_PARAMS;
        goto err;
    }
    /* Disable Timer module */
    TIM_SP804_Regs->tim_chan_regs[aChanID].timer1control &= ~TIM_CONTROL_TIMER_EN_MASK;
    /* Load the value */
    TIM_SP804_Regs->tim_chan_regs[aChanID].timer1load = aValue;
    /* Clear the interrupt */
    TIM_SP804_Regs->tim_chan_regs[aChanID].timer1intclr |= TIM_CONTROL_INT_CLR_MASK;
    /* Enable Timer module */
    TIM_SP804_Regs->tim_chan_regs[aChanID].timer1control |= TIM_CONTROL_TIMER_EN_MASK;

    TIM_DrvDev[aChanID].state = TIM_DRV_CHANSTATE_RUNNING;
    TIM_DrvDev[aChanID].loadValue = aValue;

err:
    if (BCM_ERR_OK != retVal) {
        TIM_DrvReportError(aChanID, BRCM_SWDSGN_TIM_DRV_STARTTIMER_PROC, retVal,
                aValue, 0UL, 0UL, 0UL);
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_TIM_SYSTEMSTARTTIMER_PROC
    @trace #BRCM_SWREQ_TIM
*/
int32_t TIM_SystemStartTimer(TIM_ChanIDType aChanID,
                       TIM_TickType aValue)
{
    return TIM_DrvStartTimer(aChanID, aValue);
}

/**
    @trace #BRCM_SWARCH_TIM_DEINIT_PROC
    @trace #BRCM_SWREQ_TIM
*/
static int32_t TIM_DrvDeInit(TIM_ChanIDType aChanID)
{
    int32_t retVal = BCM_ERR_OK;

    if (TIM_MAX_CHANNELS <= aChanID) {
        retVal = BCM_ERR_INVAL_PARAMS;
        goto err;
    }
    if (TIM_DRV_CHANSTATE_UNINIT == TIM_DrvDev[aChanID].state) {
        retVal = BCM_ERR_UNINIT;
        goto err;
    }
    if ((TIM_DRV_CHANSTATE_RUNNING == TIM_DrvDev[aChanID].state) &&
            (TIM_CHAN_MODE_FREE_RUNNING != TIM_DrvDev[aChanID].chanMode)) {
        retVal = BCM_ERR_BUSY;
        goto err;
    }

    /* Disable interrupts and timer module */
    TIM_SP804_Regs->tim_chan_regs[aChanID].timer1control &= ~(TIM_CONTROL_INT_EN_MASK
            | TIM_CONTROL_TIMER_EN_MASK);

    TIM_DrvDev[aChanID].state = TIM_DRV_CHANSTATE_UNINIT;

err:
    if (BCM_ERR_OK != retVal) {
        TIM_DrvReportError(aChanID, BRCM_SWDSGN_TIM_DRV_DEINIT_PROC, retVal, 0UL,
                0UL, 0UL, 0UL);
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_TIM_INIT_PROC
    @trace #BRCM_SWREQ_TIM_NOTIFICATION
*/
static int32_t TIM_DrvInit(TIM_ChanIDType aChanID,
                           const TIM_ConfigType *const aConfig)
{
    int32_t retVal = BCM_ERR_UNINIT;
    uint32_t divisor;
    TIM_CbType callBackFunc;

    if (NULL == aConfig) {
        retVal = BCM_ERR_INVAL_PARAMS;
        goto err;
    }
    if (TIM_MAX_CHANNELS <= aChanID) {
        retVal = BCM_ERR_INVAL_PARAMS;
        goto err;
    }
    if (aChanID != aConfig->chanID) {
        retVal = BCM_ERR_INVAL_PARAMS;
        goto err;
    }

    callBackFunc = TIM_CallBackTable[aChanID];
    /* BCM_TEST_ADD_PROBE(BCM_SPT_ID, BRCM_SWPTSEQ_TIMER_PERIODIC_TEST,
            BRCM_SWPTST_TIM_INIT_NEG_NULL_CB,
            callBackFunc = NULL) */
    if ((TIM_CHAN_MODE_FREE_RUNNING != aConfig->chanMode) &&
        (NULL == callBackFunc)) {
        retVal = BCM_ERR_UNKNOWN;
        goto err;
    }

    if (TIM_DRV_CHANSTATE_UNINIT == TIM_DrvDev[aChanID].state) {
        retVal = TIM_SP804Init(aConfig);
        if (BCM_ERR_OK == retVal) {
            TIM_DrvDev[aChanID].state = TIM_DRV_CHANSTATE_INIT;
            TIM_DrvDev[aChanID].chanMode = aConfig->chanMode;
            TIM_DrvDev[aChanID].width = aConfig->width;
            TIM_DrvDev[aChanID].sysTimeEn = aConfig->sysTimeEn;
            switch (aConfig->prescale) {
            case TIM_PRESCALE_DIV_1:
                divisor = 1UL;
                break;
            case TIM_PRESCALE_DIV_16:
                divisor = 16UL;
                break;
            default:
                divisor = 256UL;
                break;
            }
            TIM_DrvDev[aChanID].divisor = divisor;
            if (TIM_CHAN_MODE_FREE_RUNNING == aConfig->chanMode) {
                /* Disable Timer module */
                TIM_SP804_Regs->tim_chan_regs[aChanID].timer1control &= ~TIM_CONTROL_TIMER_EN_MASK;
                /* Load the value */
                TIM_SP804_Regs->tim_chan_regs[aChanID].timer1load = TIM_MAX_VALUE(aConfig->width);
                /* Clear the interrupt */
                TIM_SP804_Regs->tim_chan_regs[aChanID].timer1intclr |= TIM_CONTROL_INT_CLR_MASK;
                /* Enable Timer module */
                TIM_SP804_Regs->tim_chan_regs[aChanID].timer1control |= TIM_CONTROL_TIMER_EN_MASK;
                TIM_DrvDev[aChanID].state = TIM_DRV_CHANSTATE_RUNNING;
            }
        }
    }

err:
    if (BCM_ERR_OK != retVal) {
        TIM_DrvReportError(aChanID, BRCM_SWDSGN_TIM_DRV_INIT_PROC, retVal, 0UL,
                0UL, 0UL, 0UL);
    }

    return retVal;
}

/**
    @brief Union to avoid MISRA Required error
    for Type conversion

    @trace #BRCM_SWARCH_TIM_SYSCMDHANDLER_PROC
    @trace #BRCM_SWREQ_TIM_KERNEL_HANDLER
*/
typedef union uTIM_SVCIOType {
    uint8_t     *data;
    TIM_IOType  *io;
} TIM_SVCIOType;

/**
    @trace #BRCM_SWARCH_TIM_SYSCMDHANDLER_PROC
    @trace #BRCM_SWREQ_TIM_KERNEL_HANDLER

    @code{.c}
    if aSysIO.timIO is not NULL
        if aMagicID is SVC_MAGIC_SPT_ID
            timIO->retVal = TIM_CmdHandler(aCmd, timIO)
        else
            timIO->retVal = BCM_ERR_INVAL_MAGIC
    @endcode
*/
void TIM_SysCmdHandler(uint32_t aMagicID, uint32_t aCmd, uint8_t * aSysIO)
{
    TIM_SVCIOType tim;
    tim.data = aSysIO;
    int32_t retVal = BCM_ERR_OK;

    if (aSysIO != NULL) {
        if (aMagicID == SVC_MAGIC_SPT_ID) {
            switch (aCmd) {
            case TIM_CMD_INIT:
                retVal = TIM_DrvInit(tim.io->chanID, tim.io->config);
                break;
            case TIM_CMD_GET_TIME:
                tim.io->sysTime = TIM_SystemGetTime();
                break;
            case TIM_CMD_DEINIT:
                retVal = TIM_DrvDeInit(tim.io->chanID);
                break;
            case TIM_CMD_GET_TIME_ELAPSED:
                tim.io->elapsedTime = TIM_DrvGetTimeElapsed(tim.io->chanID);
                break;
            case TIM_CMD_GET_TIME_REMAINING:
                tim.io->remainingTime = TIM_DrvGetTimeRemaining(tim.io->chanID);
                break;
            case TIM_CMD_START_TIMER:
                retVal = TIM_DrvStartTimer(tim.io->chanID, tim.io->targetTime);
                break;
            case TIM_CMD_STOP_TIMER:
                retVal = TIM_DrvStopTimer(tim.io->chanID);
                break;
            case TIM_CMD_ENABLE_NOTIFICATION:
                retVal = TIM_DrvEnableNotification(tim.io->chanID);
                break;
            case TIM_CMD_DISABLE_NOTIFICATION:
                retVal = TIM_DrvDisableNotification(tim.io->chanID);
                break;
            case TIM_CMD_GET_FREE_RUNNING_TIME:
                tim.io->elapsedTime = TIM_DrvGetFreeRunningTime(tim.io->chanID);
                break;
            default:
                retVal = BCM_ERR_INVAL_PARAMS;
                break;
            }
        } else {
            retVal = BCM_ERR_INVAL_MAGIC;
        }
        tim.io->retVal = retVal;
    } else {
        retVal = BCM_ERR_INVAL_PARAMS;
    }

    if (BCM_ERR_OK != retVal) {
        const uint32_t values[4] = {aMagicID, aCmd, (uint32_t)aSysIO, 0UL};
        BCM_ReportError(BCM_SPT_ID, (uint8_t)0xFFU, BRCM_SWARCH_TIM_SYSCMDHANDLER_PROC, retVal,
                        4UL, values);
    }
}

/**
    @trace #BRCM_SWARCH_TIM_IRQHANDLER_PROC
    @trace #BRCM_SWREQ_TIM_KERNEL_HANDLER
*/
void TIM_IRQHandler(TIM_ChanIDType aChanID)
{
    if (TIM_MAX_CHANNELS > aChanID) {
        TIM_SP804IRQHandler(aChanID);
    }
}

/** @} */
