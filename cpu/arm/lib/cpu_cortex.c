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
    @defgroup grp_cortex_cpu ARM Cortex CPU Primitives
    @addtogroup grp_cortex
    @{
    @section sec_cortex_cpu ARM Cortex CPU Primitives Overview

    This file implements the CPU Primitive functions for the
    ARM Cortex architecture

    @file cpu.c
    @brief CPU Primitive functions

    @version 0.1 Initial version
*/
#include <compiler.h>
#include <cpu.h>

/**
    @name ARM Cortex Primitives Architecture IDs
    @{
    @brief Architecture IDs for ARM Cortex Primitives
*/
#define BRCM_SWDSGN_CPU_MEMORY_BARRIER_PROC         (0xBC00U)    /**< @brief #CPU_MemoryBarrier      */
#define BRCM_SWDSGN_CPU_DATA_SYNC_BARRIER_PROC      (0xBC01U)    /**< @brief #CPU_DataSyncBarrier    */
#define BRCM_SWDSGN_CPU_INSTRUCTION_BARRIER_PROC    (0xBC02U)    /**< @brief #CPU_InstructionBarrier */
#define BRCM_SWDSGN_CPU_CLZ_PROC                    (0xBC03U)    /**< @brief #CPU_Clz */
#define BRCM_SWDSGN_CPU_BITREVERSE_PROC             (0xBC04U)    /**< @brief #CPU_BitReverse */
#define BRCM_SWDSGN_CPU_BREAKPOINT_PROC             (0xBC05U)    /**< @brief #CPU_Breakpoint        */
/** @} */

/**
    @trace  #BRCM_SWARCH_CPU_MEMORY_BARRIER_PROC
    @trace  #BRCM_SWREQ_CPU_ABSTRACTION_CORTEX
*/
void CPU_MemoryBarrier(void)
{
    COMP_ASM("DMB");
}

/**
    @trace  #BRCM_SWARCH_CPU_DATA_SYNC_BARRIER_PROC
    @trace  #BRCM_SWREQ_CPU_ABSTRACTION_CORTEX
*/
void CPU_DataSyncBarrier(void)
{
    COMP_ASM("DSB");
}

/**
    @trace  #BRCM_SWARCH_CPU_DATA_SYNC_BARRIER_PROC
    @trace  #BRCM_SWREQ_CPU_ABSTRACTION_CORTEX
*/
void CPU_InstructionBarrier(void)
{
    COMP_ASM("ISB");
}

/** @brief Compute Leading Zeros

    @trace  #BRCM_SWARCH_CPU_CLZ_PROC
    @trace  #BRCM_SWREQ_CPU_ABSTRACTION_CORTEX
*/
uint32_t CPU_Clz(uint32_t aValue)
{
#if defined (__GHSCC__)
    return (uint32_t)__CLZ32(aValue);
#else
    return (uint32_t)__builtin_clz(aValue);
#endif
}

/** @brief Perform Bit Position Reversal

    @trace  #BRCM_SWARCH_CPU_BITREVERSE_PROC
    @trace  #BRCM_SWREQ_CPU_ABSTRACTION_CORTEX
*/
uint32_t CPU_BitReverse(uint32_t aValue)
{
    uint32_t val;

#if defined(GNU) || defined(ARMCC) || defined(GHS)
    COMP_ASM( "rbit %0, %1"
                :"=r"(val)
                :"r"(aValue)
                :"cc");
#else
#error Unsupported compiler
#endif
    return val;
}

/**
    @trace  #BRCM_SWARCH_CPU_BREAKPOINT_PROC
    @trace  #BRCM_SWREQ_CPU_ABSTRACTION_CORTEX
*/
void CPU_Breakpoint(void)
{
    COMP_ASM("bkpt 0 \n");
}
/** @} */
