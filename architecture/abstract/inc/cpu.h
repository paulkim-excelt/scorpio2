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

 2. TO THE COMP_MAXIMUM EXTENT PERMITTED BY LAW, THE SOFTWARE IS PROVIDED "AS IS"
    AND WITH ALL FAULTS AND BROADCOM MAKES NO PROMISES, REPRESENTATIONS OR
    WARRANTIES, EITHER EXPRESS, IMPLIED, STATUTORY, OR OTHERWISE, WITH RESPECT
    TO THE SOFTWARE.  BROADCOM SPECIFICALLY DISCLAIMS ANY AND ALL IMPLIED
    WARRANTIES OF TITLE, MERCHANTABILITY, NONINFRINGEMENT, FITNESS FOR A
    PARTICULAR PURPOSE, LACK OF VIRUSES, ACCURACY OR COMPLETENESS,
    QUIET ENJOYMENT, QUIET POSSESSION OR CORRESPONDENCE TO DESCRIPTION.
    YOU ASSUME THE ENTIRE RISK ARISING OUT OF USE OR PERFORMANCE OF THE
    SOFTWARE.

 3. TO THE COMP_MAXIMUM EXTENT PERMITTED BY LAW, IN NO EVENT SHALL BROADCOM OR ITS
    LICENSORS BE LIABLE FOR (i) CONSEQUENTIAL, INCIDENTAL, SPECIAL, INDIRECT,
    OR EXEMPLARY DAMAGES WHATSOEVER ARISING OUT OF OR IN ANY WAY RELATING TO
    YOUR USE OF OR INABILITY TO USE THE SOFTWARE EVEN IF BROADCOM HAS BEEN
    ADVISED OF THE POSSIBILITY OF SUCH DAMAGES; OR (ii) ANY AMOUNT IN EXCESS
    OF THE AMOUNT ACTUALLY PAID FOR THE SOFTWARE ITSELF OR U.S. $1, WHICHEVER
    IS GREATER. THESE LIMITATIONS SHALL APPLY NOTWITHSTANDING ANY FAILURE OF
    ESSENTIAL PURPOSE OF ANY LIMITED REMEDY.
******************************************************************************/

/**
    @defgroup grp_cpu_abstract CPU Abstraction interface
    @ingroup grp_abstract

    @addtogroup grp_cpu_abstract
    @{

    @file cpu.h
    @brief This file contains CPU Abstraction API interfaces

    @version 0.1 Initial Version
*/

#ifndef CPU_H
#define CPU_H

#include <inttypes.h>
#include <stdint.h>

/**
    @name CPU abstraction Architecture IDs
    @{
    @brief Architecture IDs for CPU abstraction
*/
#define BRCM_SWARCH_CPU_PRIVILEGE_LEVEL_TYPE         (0x8A00U)    /**< @brief #CPU_PrivilegeLevelType */
#define BRCM_SWARCH_CPU_GET_PRIVILEGE_PROC           (0x8A01U)    /**< @brief #CPU_GetPrivilegeLevel  */
#define BRCM_SWARCH_CPU_MEMORY_BARRIER_PROC          (0x8A02U)    /**< @brief #CPU_MemoryBarrier      */
#define BRCM_SWARCH_CPU_DATA_SYNC_BARRIER_PROC       (0x8A03U)    /**< @brief #CPU_DataSyncBarrier    */
#define BRCM_SWARCH_CPU_INSTRUCTION_BARRIER_PROC     (0x8A04U)    /**< @brief #CPU_InstructionBarrier */
#define BRCM_SWARCH_CPU_CLZ_PROC                     (0x8A05U)    /**< @brief #CPU_Clz                */
#define BRCM_SWARCH_CPU_BITREVERSE_PROC              (0x8A06U)    /**< @brief #CPU_BitReverse         */
#define BRCM_SWARCH_CPU_BREAKPOINT_PROC              (0x8A07U)    /**< @brief #CPU_Breakpoint         */
#define BRCM_SWARCH_CPU_VIC_INT_ENABLE_PROC          (0x8A08U)    /**< @brief #CPU_VICInterruptEnable */
#define BRCM_SWARCH_CPU_VIC_INT_DISABLE_PROC         (0x8A09U)    /**< @brief #CPU_VICInterruptDisable */
/** @} */

/**
   @name CPU Privilege levels
   @{
   @brief CPU Privilege levels

   @trace  #BRCM_SWREQ_CPU_ABSTRACTION
*/
typedef uint32_t CPU_PrivilegeLevelType;
#define CPU_PRIVILEGE_LEVEL_USER      0U
#define CPU_PRIVILEGE_LEVEL_HANDLER   1U
/** @} */

/** @brief Get current CPU privilege level

    Get the current CPU privilege level

    @behavior Sync, Non-reentrant

    @pre None

    @retval CPU_PRIVILEGE_LEVEL_USER - Currently in user mode
    @retval CPU_PRIVILEGE_LEVEL_HANDLER - Currently in handler mode

    @post None

    @trace  #BRCM_SWREQ_CPU_ABSTRACTION

    @limitations None
*/
CPU_PrivilegeLevelType CPU_GetPrivilegeLevel(void);

/** @brief Trigger a SW breakpoint

    @behavior Sync, Non-reentrant

    @pre None

    @return void

    @post Breakpoint is triggered. The behaviour after
        the breakpoint is triggered is system specific

    @trace  #BRCM_SWREQ_CPU_ABSTRACTION

    @limitations None
*/
void CPU_Breakpoint(void);

/** @brief Memory barrier

    Executes the CPU specific memory barrier instruction

    @behavior Sync, Non-reentrant

    @pre None

    @returns None

    @post Memory access after this point will wait for
          all the memory access before this point

    @trace  #BRCM_SWREQ_CPU_ABSTRACTION

    @limitations None
*/
void CPU_MemoryBarrier(void);

/** @brief Data synchronization barrier

    Executes the CPU specific data sync barrier instruction

    @behavior Sync, Non-reentrant

    @pre None

    @returns None

    @post All the memory access before this point is committed

    @trace  #BRCM_SWREQ_CPU_ABSTRACTION

    @limitations None
*/
void CPU_DataSyncBarrier(void);

/** @brief Instruction synchronization barrier

    Executes the CPU specific data sync barrier instruction

    @behavior Sync, Non-reentrant

    @pre None

    @returns None

    @post Instruction pipe is cleared

    @trace  #BRCM_SWREQ_CPU_ABSTRACTION

    @limitations None
*/
void CPU_InstructionBarrier(void);

/** @brief Count of leading zeroes

    returns the count of leading zeroes

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]  aValue      Input value which needs
                            to be used to determine
                            count of leading zeroes

    @returns    uint32_t    Count of leading zeroes

    @post None

    @trace  #BRCM_SWREQ_CPU_ABSTRACTION

    @limitations None
*/
uint32_t CPU_Clz(uint32_t aValue);

/** @brief Reverse the bits

    Reverses the order of bits in the passed vale

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]  aValue      Input value whose bits
                            need to be reversed

    @returns    uint32_t    Value with bits reversed

    @post None

    @trace  #BRCM_SWREQ_CPU_ABSTRACTION

    @limitations None
*/
uint32_t CPU_BitReverse(uint32_t aValue);

/** @brief Enable an interrupt line

    This API enables the given interrupt line

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aIntNum                 Interrupt line number to enable

    @retval         #BCM_ERR_INVAL_PARAMS   Invalid interrupt line
    @retval         #BCM_ERR_OK             Interrupt enabled

    @post The interrupt line is enabled

    @trace  #BRCM_SWREQ_CPU_ABSTRACTION
*/
int32_t CPU_VICInterruptEnable(uint32_t aIntNum);

/** @brief Disable an interrupt line

    This API disables an interrupt line

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aLineNo                 Interrupt line number to disable

    @retval         #BCM_ERR_INVAL_PARAMS   Invalid interrupt line
    @retval         #BCM_ERR_OK             Interrupt disabled

    @post The specified interrupt line is disabled

    @trace  #BRCM_SWREQ_CPU_ABSTRACTION
*/
int32_t CPU_VICInterruptDisable(uint32_t aLineNo);

#endif /* CPU_H */

/** @} */
