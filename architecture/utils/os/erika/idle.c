/*****************************************************************************
 Copyright 2017-2022 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_idle_impl IDLE Task Implementation
    @ingroup grp_utils

    @addtogroup grp_idle_impl
    @{

    @file idle.c
    @brief IDLE Task Implementation
    This source file contains the implementation of IDLE Task
    @version 0.1 Initial version
*/
#include <stdlib.h>
#include <string.h>
#if defined(__CORTEX_MX__) || defined(__CORTEX_RX__)
#include <cortex.h>
#include <bcm_test.h>
#endif
#include <ee.h>
#include <idle.h>
#include <osil/bcm_osil.h>
#ifndef ENABLE_WFI
#include <bcm_test.h>
#endif

/**
    @name IDLE Task Design IDs
    @{
    @brief Design IDs for IDLE Task
*/
#define BRCM_SWDSGN_IDLE_TASK_PROC    (0xE101U)    /**< @brief #IDLE_Task */
#define BRCM_SWDSGN_IDLE_INIT_PROC    (0xE102U)    /**< @brief #IDLE_Init */
/** @} */

/** @brief IDLE Task Function

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      void

    @return void (for void functions)

    @post None

    @trace #BRCM_SWARCH_IDLE_INIT_PROC
    @trace #BRCM_SWREQ_IDLE_TASK

    @limitations None

*/

TASK(IDLE_Task)
{

#ifndef ENABLE_WFI
    BCM_SetReadyForTest();
#endif
    /* @event            Infinite loop
       @issue            while (1UL) never exit
       @risk             No risk
       @justification    The infinite loop is intentional  */

    /* coverity[no_escape] */
    /* coverity[loop_top] */
    do {
#ifdef ENABLE_WFI
#if defined(__CORTEX_MX__) || defined(__CORTEX_RX__)
        CORTEX_WFI();
#else
        COMP_ASM("wevt");
#endif
#else
        BCM_TestMsgHandler();
#endif
    /* coverity[loop_bottom] */
    } while (TRUE == TRUE);
}

/** @} */
