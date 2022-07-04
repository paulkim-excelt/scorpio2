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

/** @defgroup grp_timdrv_il Integration Guide
    @ingroup grp_timdrv

    @addtogroup grp_timdrv_il
    @{
    @section sec_tim_integration Integration Guide

    @section sec_tim_il_seq Sequence Diagram
    @tagseq tim_svc_seq_diagram.svg "TIM SVC Seq"
    @startseq
    node_width = 200;
    group {label = ""; color = "#EFFFFF"; "TIM Client"};
    group {label = ""; color = "#FFFFEF"; "TIM Driver Interface"};
    group {label = ""; color = "#FFEFFF"; "SVC Layer"};
    group {label = ""; color = "#FFFFEF"; "TIM Driver"};
    "TIM Client"  -> "TIM Driver Interface" [label = "TIM_Init"];
    "TIM Driver Interface"  -> "SVC Layer" [label = "TIM_SysCmdReq"];
    "SVC Layer"  -> "TIM Driver" [label = "TIM_SysCmdHandler"];
    "SVC Layer"  <-- "TIM Driver";
    "TIM Driver Interface"  <-- "SVC Layer"
    "TIM Client"  <-- "TIM Driver Interface"
    @endseq
    Call Sequence of timer with SVC.

    @file tim_osil.h
    @brief TIM driver Integration Interfaces
    This header file contains the integration interface for TIM driver
    @version 0.30 Imported from docx
*/

#ifndef TIM_OSIL_H
#define TIM_OSIL_H

#include <svc.h>
#include <tim_rdb.h>
#include <tim.h>

/**
    @name TIM driver interface IDs
    @{
    @brief Interface IDs for TIM driver
*/
#define BRCM_SWARCH_TIM_CMD_TYPE              (0x9101U)    /**< @brief #TIM_CmdType       */
#define BRCM_SWARCH_TIM_IO_TYPE               (0x9102U)    /**< @brief #TIM_IOType        */
#define BRCM_SWARCH_TIM_SYSCMDHANDLER_PROC    (0x9103U)    /**< @brief #TIM_SysCmdHandler */
#define BRCM_SWARCH_TIM_SYSCMDREQ_PROC        (0x9104U)    /**< @brief #TIM_SysCmdReq     */
#define BRCM_SWARCH_TIM_IRQHANDLER_PROC       (0x9105U)    /**< @brief #TIM_IRQHandler    */
#define BRCM_SWARCH_TIM_IRQHANDLER0_PROC      (0x9106U)    /**< @brief #TIM_IRQHandler0   */
#define BRCM_SWARCH_TIM_IRQHANDLER1_PROC      (0x9107U)    /**< @brief #TIM_IRQHandler1   */
#define BRCM_SWARCH_TIM_CALLBACK0_PROC        (0x9108U)    /**< @brief #TIM_Chann0Cb      */
#define BRCM_SWARCH_TIM_CALLBACK1_PROC        (0x9109U)    /**< @brief #TIM_Chann1Cb      */
#define BRCM_SWARCH_TIM_CB_PROC               (0x910AU)    /**< @brief #TIM_CbType        */
#define BRCM_SWARCH_TIM_CALLBACKTABLE_GLOBAL  (0x910BU)    /**< @brief #TIM_CallBackTable */
/** @} */

/**
    @name TIM_CmdType
    @{
    @brief Timer command type

    @trace #BRCM_SWREQ_TIM_KERNEL_INTERFACE
*/
typedef uint32_t TIM_CmdType;                   /**< @brief Timer command type */
#define TIM_CMD_INIT                    (0x0UL) /**< @brief Timer command for initialization */
#define TIM_CMD_DEINIT                  (0x1UL) /**< @brief Timer command for de-initialization */
#define TIM_CMD_GET_TIME_ELAPSED        (0x2UL) /**< @brief Timer command to get the time elapsed */
#define TIM_CMD_GET_TIME_REMAINING      (0x3UL) /**< @brief Timer command to get the time remaining */
#define TIM_CMD_START_TIMER             (0x4UL) /**< @brief Timer command to start the timer */
#define TIM_CMD_STOP_TIMER              (0x5UL) /**< @brief Timer command to stop the timer */
#define TIM_CMD_ENABLE_NOTIFICATION     (0x6UL) /**< @brief Timer command to enable notification */
#define TIM_CMD_DISABLE_NOTIFICATION    (0x7UL) /**< @brief Timer command to disable notification */
#define TIM_CMD_GET_FREE_RUNNING_TIME   (0x8UL) /**< @brief Timer command to get current time of free running timer */
#define TIM_CMD_GET_TIME                (0x9UL) /**< @brief Timer command to get current time */
/** @} */

/** @brief Timer expiry callback for channel-0

    Callback interface to notify that the timer has expired for channel-0.
    It is mandatory for clients to implement this function and define the macro
    #ENABLE_TIM_CHANN0_CB by the client to use notification functionality on
    timer channel-0.

    @behavior Sync, Re-entrant

    @pre TBD

    @param      void

    @return     void

    @post TBD

    @note
        -# This function shall be implemented by the the client.
        -# This callback is raised in interrupt context, so callback function
           shall return as soon as possible (and avoid any heavy processing in
           the callback).

    @trace  #BRCM_SWREQ_TIM_NOTIFICATION

    @limitations None
*/
extern void TIM_Chann0Cb(void);

/** @brief Timer expiry callback for channel-1

    Callback interface to notify that the timer has expired for channel 1.
    It is mandatory for clients to implement this function and define the macro
    #ENABLE_TIM_CHANN1_CB by the client to use notification functionality on
    timer channel-1.

    @behavior Sync, Re-entrant

    @pre TBD

    @param      void

    @return     void

    @post TBD

    @note
        -# This function shall be implemented by the the client.
        -# This callback is raised in interrupt context, so callback function
           shall return as soon as possible (and avoid any heavy processing in
           the callback).

    @trace  #BRCM_SWREQ_TIM_NOTIFICATION

    @limitations None
*/
extern void TIM_Chann1Cb(void);

/**
    @trace  #BRCM_SWREQ_TIM_NOTIFICATION
*/
typedef void (*TIM_CbType)(void);

/**
    @trace  #BRCM_SWREQ_TIM_NOTIFICATION
*/
extern const TIM_CbType TIM_CallBackTable[TIM_MAX_CHANNELS];

/**
    @brief GTP IO structure

    Structure for Timer SVC interface

    @trace #BRCM_SWREQ_TIM_KERNEL_INTERFACE
*/
typedef struct sTIM_IOType {
    int32_t retVal;                 /**< @brief SVC response */
    TIM_ChanIDType chanID;          /**< @brief Timer channel ID */
    TIM_TickType elapsedTime;       /**< @brief Time elapsed */
    TIM_TickType remainingTime;     /**< @brief Time remaining */
    TIM_TickType targetTime;        /**< @brief Target time */
    uint64_t sysTime;               /**< @brief Time(in ms) of the timer
                                         configured for system time usage */
    uint64_t sysTimeRaw;            /**< @brief Time(in ns) of the timer */
    const TIM_ConfigType *config;   /**< @brief Timer configuration data */
} TIM_IOType;

/** @brief Timer system command request

    Interface for Timer system command request.

    @behavior Sync, Re-entrant

    @pre TBD

    @param[in]      aCmd        Timer command
    @param[inout]   aIO         Pointer to Timer IO

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Timer command operation success
    @retval     #BCM_ERR_INVAL_MAGIC    Invalid magic number
    @retval     Others                  Error values specific to the command
                                        raised
    @retval     #BCM_ERR_INVAL_PARAMS   aIO is NULL

    @post TBD

    @note This interface shall be implemented by the integrator.

    @trace  #BRCM_SWREQ_TIM_KERNEL_INTERFACE

    @limitations None
*/
extern int32_t TIM_SysCmdReq(TIM_CmdType aCmd,
                             TIM_IOType *const aIO);

/** @brief Timer system command handler

    This interface handles all the Timer driver commands requested from
    #SysCmdReq.

    @behavior Sync, Re-entrant

    @pre TBD

    @param[in]      aMagicID    Magic ID for Timer
    @param[in]      aCmd        System command request
    @param[inout]   aSysIO      Pointer to system request IO

    @return     void

    @post TBD

    @note This interface shall be implemented by the integrator and shall hook
    it to SVC layer.

    @trace  #BRCM_SWREQ_TIM_KERNEL_HANDLER

    @limitations None
*/
extern void TIM_SysCmdHandler(uint32_t aMagicID,
                              uint32_t aCmd,
                              uint8_t *aSysIO);

/** @brief Handle timer interrupts

    This interface handles Timer interrupts.

    @behavior Sync, Non-reentrant

    @pre TBD

    @param[in]      aChanID     Timer Channel ID

    @return     void

    @post TBD

    @note This interface shall be called from ISR handler for TIM driver.

    @limitations None

    @trace  #BRCM_SWREQ_TIM_KERNEL_HANDLER

    @snippet tim_osil.c Usage of TIM_IRQHandler
*/
extern void TIM_IRQHandler(TIM_ChanIDType aChanID);

/** @brief TIME Interrupt Handler

    TIME Interrupt Handler 0.

    @behavior Sync, Re-entrant

    @pre TBD

    @param[in]      None

    @retval         None

    @post TBD

    @trace #BRCM_SWREQ_TIM_KERNEL_HANDLER

    @limitations None
*/
extern void TIM_IRQHandler0(void);

/** @brief TIME Interrupt Handler

    TIME Interrupt Handler 1.

    @behavior Sync, Re-entrant

    @pre TBD

    @param[in]      None

    @retval         None

    @post TBD

    @trace #BRCM_SWREQ_TIM_KERNEL_HANDLER

    @limitations None
*/
extern void TIM_IRQHandler1(void);

#endif
/** @} */
