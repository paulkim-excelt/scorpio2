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
    Header file for the ARMv7M specific BASE kernel routines

    @file armv7m_kernel.h
    @brief ARMv7M specific BASE kernel routines
    @version 0.1 Initial Version
*/

#ifndef ARMV7M_KERNEL_H
#define ARMV7M_KERNEL_H

#include "../../kernel.h"

/**
    @name BASE kernel ARMv7M Architecture IDs
    @{
    @brief Architecture IDs for the BASE kernel ARMv7M port
*/
#define BRCM_SWARCH_BASE_ARMV7M_PENDSV_HANDLER_PROC    (0x8301U)    /**< @brief #BASE_ARMv7mPendSVHandler */
#define BRCM_SWARCH_BASE_ARMV7M_SVC_HANDLER_PROC       (0x8302U)    /**< @brief #BASE_ARMv7mSVCHandler    */
#define BRCM_SWARCH_BASE_ARMV7M_PLATFORM_INIT_PROC     (0x8303U)    /**< @brief #BASE_ARMv7mPlatformInit  */
/** @} */

/**
    @brief ARMv7M PendSV handler proc

    PendSV implements the task switching logic for the ARMv7M
    port of the BASE kernel

    @behavior Sync, Non-reentrant

    @pre None

    @return void

    @post None

    @trace #BRCM_SWREQ_BASE_CORTEX_MX
*/
void BASE_ARMv7mPendSVHandler(void);

/**
    @brief ARMv7M SVC handler proc

    @behavior Sync, Non-reentrant

    @pre None

    @param[inout]   aSysReqIO             SVC parameters
    @param[in]      aSysReqID             SVC Request ID

    @return void

    @post None

    @trace #BRCM_SWREQ_BASE_CORTEX_MX
*/
void BASE_ARMv7mSVCHandler(SVC_RequestType *const aSysReqIo, const uint32_t aSysReqID);

/**
    @brief Function to perform platform specific initializations

    @behavior Sync, Non-reentrant

    @pre None

    @return void

    @post None

    @trace #BRCM_SWREQ_BASE_CORTEX_MX
*/
void BASE_ARMv7mPlatformInit(void);

#endif
/** @} */
