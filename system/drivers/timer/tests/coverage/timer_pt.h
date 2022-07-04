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
    @defgroup grp_timer_coverage Timer coverage test with probe
    @ingroup grp_timdrv

    @addtogroup grp_timer_coverage
    @{

    @file timer_pt.h

    @board

    @brief Timer coverage Test with probe
    This source file contains the probe based coverage test for Timer
    @version 0.1 Initial draft
*/

#ifndef TIMER_PT_H
#define TIMER_PT_H

/**
    @brief Call TIM_SysCmdReq with probe to set invalid sysReqID in
           function TIM_SysCmdReq.

    @pre NA

    @test Call TIM_SysCmdReq with probe

    @post #BCM_ERR_INVAL_PARAMS should be returned

    @functional No

    @type Neg

    @trace #BRCM_SWARCH_TIM_SYSCMDREQ_PROC
    @trace #BRCM_SWREQ_TIM_KERNEL_INTERFACE
*/
#define BRCM_SWPTST_TIM_SYSCMDREQ_INVAL_SYSREQID                      (0x3001UL)

/**
    @brief Call TIM_SysCmdReq with probe to probe to set invalid
           return response from SVC_Request in function TIM_SysCmdReq.

    @pre NA

    @test Call TIM_SysCmdReq with probe

    @post #BCM_ERR_INVAL_PARAMS should be returned

    @functional No

    @type Neg

    @trace #BRCM_SWARCH_TIM_SYSCMDREQ_PROC
    @trace #BRCM_SWREQ_TIM_KERNEL_INTERFACE
*/
#define BRCM_SWPTST_TIM_SYSCMDREQ_INVAL_RESPONSE                      (0x3002UL)

/**
    @brief Get elapsed time with probe to set return err from
           TIM_SysCmdReq

    @pre NA

    @test Call TIM_GetTimeElapsed

    @post return value should be 0UL

    @functional No

    @type Neg

    @trace #BRCM_SWARCH_TIM_GETTIMEELAPSED_PROC
*/
#define BRCM_SWPTST_TIM_GETTIMEELAPSED_NEG                            (0x3003UL)

/**
    @brief Get remaining time with probe to set return err from
           TIM_SysCmdReq

    @pre NA

    @test Call TIM_GetTimeRemaining

    @post return value should be 0UL

    @functional No

    @type Neg

    @trace #BRCM_SWARCH_TIM_GETTIMEREMAINING_PROC
*/
#define BRCM_SWPTST_TIM_GETTIMEREMAINING_NEG                          (0x3004UL)

/**
    @brief Get free running time with probe to set return err from
           TIM_SysCmdReq

    @pre NA

    @test Call TIM_GetFreeRunningTime

    @post return value should be 0UL

    @functional No

    @type Neg

    @trace #BRCM_SWARCH_TIM_GETFREERUNNINGTIME_PROC
*/
#define BRCM_SWPTST_TIM_GETFREERUNNINGTIME_NEG                        (0x3005UL)

/**
    @brief Get free running time with probe to set return err from
           TIM_SysCmdReq

    @pre NA

    @test Call TIM_GetTime

    @post return value should be 0UL

    @functional No

    @type Neg

    @trace #BRCM_SWARCH_TIM_GETTIME_PROC
*/
#define BRCM_SWPTST_TIM_GETTIME_NEG                                   (0x3006UL)

/**
    @brief Initialize timer with probe to set call back function
           to NULL with periodic mode

    @pre Timer is un-initialized

    @test Call TIM_Init

    @post #BCM_ERR_UNKNOWN should be returned

    @functional Yes

    @type Neg

    @trace #BRCM_SWARCH_TIM_INIT_PROC
*/
#define BRCM_SWPTST_TIM_INIT_NEG_NULL_CB                              (0x3007UL)

/**
    @brief Enable notification with probe to set call back function
           to NULL

    @pre Timer is initialized as periodic mode

    @test Call TIM_EnableNotification

    @post #BCM_ERR_UNKNOWN should be returned

    @functional Yes

    @type Neg

    @trace #BRCM_SWARCH_TIM_ENABLENOTIFICATION_PROC
*/
#define BRCM_SWPTST_TIM_ENABLENOTIFICATION_NEG_NULL_CB                (0x3008UL)

/**
    @brief Enable interrupt with probe to set call back function
           to NULL

    @pre Timer is initialized as periodic mode

    @test Start timer with active probe test case

    @post Notification call back should not be called

    @functional Yes

    @type Neg

    @trace #BRCM_SWARCH_TIM_IRQHANDLER_PROC
*/
#define BRCM_SWPTST_TIM_IRQHANDLER_NEG_NULL_CB                        (0x3009UL)

/**
    @brief Disable notification with probe to set call back function
           to NULL

    @pre Timer is initialized as periodic mode

    @test Call TIM_DisableNotification

    @post #BCM_ERR_UNKNOWN should be returned

    @functional Yes

    @type Neg

    @trace #BRCM_SWARCH_TIM_DISABLENOTIFICATION_PROC
*/
#define BRCM_SWPTST_TIM_DISABLENOTIFICATION_NEG_NULL_CB               (0x300aUL)

/** @brief Probe test sequence for SysCmdReq.

    @code{.c}

    Call TIM_SysCmdReq with probe
    Check Expected Result for #BRCM_SWPTST_TIM_SYSCMDREQ_INVAL_SYSREQID

    Call TIM_SysCmdReq with probe
    Check Expected Result for #BRCM_SWPTST_TIM_SYSCMDREQ_INVAL_RESPONSE

    @endcode

    @auto           Yes

    @type           Sanity

    @executetime    1s

    @analyzetime    1h
*/
#define BRCM_SWPTSEQ_TIMER_SYS_CMD_TEST                               (0x3001UL)

/** @brief Probe test sequence for SysCmdReq.

    @code{.c}

    Call TIM_GetTimeElapsed with probe
    Check Expected Result for #BRCM_SWPTST_TIM_GETTIMEELAPSED_NEG

    Call TIM_GetTimeRemaining with probe
    Check Expected Result for #BRCM_SWPTST_TIM_GETTIMEREMAINING_NEG

    Call TIM_GetTimeRemaining with probe
    Check Expected Result for #BRCM_SWPTST_TIM_GETFREERUNNINGTIME_NEG

    Call TIM_GetTime with probe
    Check Expected Result for #BRCM_SWPTST_TIM_GETTIME_NEG

    @endcode

    @auto           Yes

    @type           Sanity

    @executetime    1s

    @analyzetime    1h
*/
#define BRCM_SWPTSEQ_TIMER_GET_TIME                                   (0x3002UL)

/** @brief Probe test sequence for SysCmdReq.

    @code{.c}

    Call TIM_Init with probe
    Check Expected Result for #BRCM_SWPTST_TIM_INIT_NEG_NULL_CB

    Call TIM_Init as periodic

    Call TIM_EnableNotification with probe
    Check Expected Result for #BRCM_SWPTST_TIM_ENABLENOTIFICATION_NEG_NULL_CB

    Call TIM_EnableNotification
    Set Test case to #BRCM_SWPTST_TIM_IRQHANDLER_NEG_NULL_CB

    Call TIM_StartTimer with 1ms interval
    wait for 2ms
    Check if there was a call back notification
    Check Expected Result for #BRCM_SWPTST_TIM_IRQHANDLER_NEG_NULL_CB

    Call TIM_DisableNotification with probe
    Check Expected Result for #BRCM_SWPTST_TIM_DISABLENOTIFICATION_NEG_NULL_CB

    Call TIM_DisableNotification
    Call TIM_StopTimer
    Call TIM_DeInit

    @endcode

    @auto           Yes

    @type           Sanity

    @executetime    1s

    @analyzetime    1h
*/
#define BRCM_SWPTSEQ_TIMER_PERIODIC_TEST                              (0x3003UL)

#endif /* TIMER_PT_H */

/** @} */