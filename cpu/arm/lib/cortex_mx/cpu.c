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
    @defgroup grp_cortex_mx_cpu ARM Cortex-Mx CPU Primitives
    @addtogroup grp_cortex
    @{
    @section sec_cortex_cpu ARM Cortex-Mx CPU Primitives Overview

    This file implements the CPU Primitive functions for the
    Cortex-Mx architecture

    @file cpu.c
    @brief CPU Primitive functions

    @version 0.1 Initial version
*/
#include <compiler.h>
#include <cortex_mx.h>
#include <cpu.h>

/**
    @name CPU Primitives Architecture IDs
    @{
    @brief Architecture IDs for ARM Cortex-Mx CPU Primitives
*/
#define BRCM_SWDSGN_CPU_PRIVILEGE_LEVEL_PROC            (0xBA00U)    /**< @brief #CPU_GetPrivilegeLevel   */
#define BRCM_SWDSGN_CPU_VIC_INT_ENABLE_PROC             (0xBA01U)    /**< @brief #CPU_VICInterruptEnable  */
#define BRCM_SWDSGN_CPU_VIC_INT_DISABLE_PROC            (0xBA02U)    /**< @brief #CPU_VICInterruptDisable */
/** @} */


/**
    @code{.unparsed}
    if IPSR is non zero or
       Thread privilege bit is zero in CONTROL register :
        level = CPU_PRIVILEGE_LEVEL_HANDLER
    else
        level = CPU_PRIVILEGE_LEVEL_USER
    return level
    @endcode

    @trace  #BRCM_SWARCH_CPU_GET_PRIVILEGE_PROC
    @trace  #BRCM_SWREQ_CPU_ABSTRACTION_CORTEX
*/
CPU_PrivilegeLevelType CPU_GetPrivilegeLevel(void)
{
    CPU_PrivilegeLevelType level;
    uint32_t ctrlVal;
    uint32_t psrVal;

    COMP_ASM("    MRS %0, CONTROL     \n"
             "    MRS %1, IPSR        \n"
             : "=r" (ctrlVal), "=r" (psrVal));

    if ((0U != psrVal) || (0U == (ctrlVal & 1U))) {
        level = CPU_PRIVILEGE_LEVEL_HANDLER;
    } else {
        level = CPU_PRIVILEGE_LEVEL_USER;
    }
    return level;
}

/**
    @trace  #BRCM_SWARCH_CPU_VIC_INT_ENABLE_PROC
    @trace  #BRCM_SWREQ_CPU_ABSTRACTION_CORTEX_MX
*/
int32_t CPU_VICInterruptEnable(uint32_t aIntNum)
{
    return CORTEX_MX_INTREnableLine(aIntNum);
}

/**
    @trace  #BRCM_SWARCH_CPU_VIC_INT_DISABLE_PROC
    @trace  #BRCM_SWREQ_CPU_ABSTRACTION_CORTEX_MX
*/
int32_t CPU_VICInterruptDisable(uint32_t aIntNum)
{
    return CORTEX_MX_INTRDisableLine(aIntNum);
}

/** @} */
