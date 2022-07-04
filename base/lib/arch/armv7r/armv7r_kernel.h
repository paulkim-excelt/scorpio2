/*****************************************************************************
 Copyright 2020 Broadcom Limited.  All rights reserved.

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
    @addtogroup grp_base_impl
    @{
    Header file for the ARMv7R specific BASE kernel routines

    @file armv7r_kernel.h
    @brief ARMv7R specific BASE kernel routines
    @version 0.1 Initial Version
*/

#ifndef ARMV7R_KERNEL_H
#define ARMV7R_KERNEL_H

#include "../../kernel.h"

/**
    @name BASE kernel ARMv7R Architecture IDs
    @{
    @brief Architecture IDs for the BASE kernel ARMv7R port
*/
#define BRCM_SWARCH_BASE_ARMV7R_RUN_SCHED_ON_EXIT_GLOBAL    (0x8201U)    /**< @brief #BASE_ARMv7rRunSchedOnExit */
#define BRCM_SWARCH_BASE_ARMV7R_IRQ_HANDLER_PROC            (0x8202U)    /**< @brief #BASE_ARMv7rIrqHandler     */
#define BRCM_SWARCH_BASE_ARMV7R_SVC_HANDLER_PROC            (0x8203U)    /**< @brief #BASE_ARMv7rSVCHandler     */
#define BRCM_SWARCH_BASE_ARMV7R_PLATFORM_INIT_PROC          (0x8204U)    /**< @brief #BASE_ARMv7rPlatformInit   */
/** @} */

/**
    @brief Boolean that indicates whether or not to run the task scheduler on exception exit

    @trace #BRCM_SWREQ_BASE_CORTEX_RX
*/
extern uint32_t BASE_ARMv7rRunSchedOnExit;

/**
    @brief ARMv7R IRQ exception handler proc

    @behavior Sync, Non-reentrant

    @pre None

    @return void

    @post None

    @trace #BRCM_SWREQ_BASE_CORTEX_RX
*/
void BASE_ARMv7rIrqHandler(void);

/**
    @brief ARMv7R SVC exception handler proc

    @behavior Sync, Non-reentrant

    @pre None

    @param[inout]   aSysReqIO             SVC parameters
    @param[in]      aSysReqID             SVC Request ID

    @return void

    @post None

    @trace #BRCM_SWREQ_BASE_CORTEX_RX
*/
void BASE_ARMv7rSVCHandler(SVC_RequestType *const aSysReqIo, const uint32_t aSysReqID);

/**
    @brief Function to perform platform specific initializations

    @behavior Sync, Non-reentrant

    @pre None

    @return void

    @post None

    @trace #BRCM_SWREQ_BASE_CORTEX_RX
*/
void BASE_ARMv7rPlatformInit(void);
#endif
/** @} */
