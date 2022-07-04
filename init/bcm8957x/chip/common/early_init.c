/*****************************************************************************
 Copyright 2021-2022 Broadcom Limited.  All rights reserved.

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
    @addtogroup grp_bcm8957x_init
    @{

    @file early_init.c
    @brief Early Init implementation.
    This source file implements Early Init Code
 */
#include <cortex_mx.h>
#include <bcm_err.h>
#include <bcm_utils.h>
#include <mcu.h>
#if defined(ENABLE_ETH)
#include <osil/eth_osil.h>
#endif
#ifdef ENABLE_FW_LOAD
#include <tim.h>
#endif
#include <build_info.h>
#include <mcu_clk.h>
#include <bcm_utils.h>
#include <interrupt.h>
#include <compiler.h>
#include "ee.h"
#include "ee_internal.h"

/**
  @name Implementation IDs
  @{
  @brief BCM8957X Internal Functions

*/
#define BRCM_SWDSGN_BCM8957X_EARLY_INIT_TIME_GLOBAL                 (0xB101U)    /**< @brief #BCM8957X_EarlyInitTime */
#define BRCM_SWDSGN_BCM8957X_EARLY_INIT_PROC                        (0xB102U)    /**< @brief #BCM8957X_EarlyInit */
#define BRCM_SWDSGN_BCM8957X_MCU_INIT_PROC                          (0xB103U)    /**< @brief #BCM8957X_MCUInit */
#define BRCM_SWDSGN_BCM8957X_CPU_INIT_PROC                          (0xB104U)    /**< @brief #BCM8957X_CPUInit */
#define BRCM_SWDSGN_BCM_THREAD_STACK_PROC                           (0xB105U)    /**< @brief #BCM_MPUAddInitThreadStack */
#define BRCM_SWDSGN_BCM_ADDTASK_MPUENTRY_PROC                       (0xB106U)    /**< @brief #BCM_AddTaskMPUEntry */
#define BRCM_SWDSGN_BCM8957X_MCUINITERR_GLOBAL                      (0xB107U)    /**< @brief #BCM8957X_MCUInitErr */
#define BRCM_SWDSGN_BCM8957X_MCUINITDONE_GLOBAL                     (0xB108U)    /**< @brief #BCM8957X_MCUInitDone */
#define BRCM_SWDSGN_BCM_INITTHREAD_STACK_GLOBAL                     (0xB109U)    /**< @brief #BCM_init_thread_stack */
#define BRCM_SWDSGN_BCM_INITTHREAD_STACK_SIZE_GLOBAL                (0xB10AU)    /**< @brief #BCM_init_thread_stack_size */
#define BRCM_SWDSGN_BCM8957X_DEVICE_GRP_MACRO                       (0xB10BU)    /**< @brief #BCM8957X_DEVICE_GRP1_START */
#define BRCM_SWDSGN_BCM8957X_DEVICE_MEMORY_ATTRIB_MACRO             (0xB10CU)    /**< @brief #BCM8957X_DEVICE_MEMORY_ATTRIB */
#define BRCM_SWDSGN_BCM_TASK_ATTRIB_MACRO                           (0xB10DU)    /**< @brief #BCM_TASK_ATTRIB */
#define BRCM_SWDSGN_BCM8957X_MPUTABLE_TYPE                          (0xB10EU)    /**< @brief #BCM8957X_MPUTableType */
#define BRCM_SWDSGN_BCM8957X_MEMORY_MACRO                           (0xB10FU)    /**< @brief #BCM8957X_MEMORY_ITCM_CODE_RO_START */
#define BRCM_SWDSGN_BCM8957X_DEVICE_MPU_TABLE_SIZE_MACRO            (0xB111U)    /**< @brief #BCM8957X_DEVICE_MPU_TABLE_SIZE */
#define BRCM_SWDSGN_BCM8957X_MEMORY_MPU_TABLE_SIZE_MACRO            (0xB112U)    /**< @brief #BCM8957X_MEMORY_MPU_TABLE_SIZE */
#define BRCM_SWDSGN_BCM8957X_DEVICE_MPU_TABLE_GLOBAL                (0xB113U)    /**< @brief #BCM8957X_DeviceMPUTable */
#define BRCM_SWDSGN_BCM8957X_MEMORY_MPU_TABLE_GLOBAL                (0xB114U)    /**< @brief #BCM8957X_MemoryMPUTable */
#define BRCM_SWDSGN_BCM8957X_CLK_CONFIG_TABLE_GLOBAL                (0xB115U)    /**< @brief #BCM8957X_ClkCfgTbl */
#define BRCM_SWDSGN_BCM8957X_MCU_CONFIG_GLOBAL                      (0xB116U)    /**< @brief #BCM8957X_McuConfig */

/** @} */

/**
    @note: MISRA C-2012 Rule 8.6 errors will be generated for all below linker
    variables for non-availability of definition in C file as these are from
    linker

    @trace #BRCM_SWARCH_BCM_ADDTASK_MPUENTRY_PROC
    @trace #BRCM_SWREQ_BCM_THREAD_PROTECTION_BCM8957X
*/
extern uint8_t BCM_init_thread_stack[];

/**
    @trace #BRCM_SWARCH_BCM_ADDTASK_MPUENTRY_PROC
    @trace #BRCM_SWREQ_BCM_THREAD_PROTECTION_BCM8957X
*/
extern uint8_t BCM_init_thread_stack_size[];

/**
    @trace #BRCM_SWARCH_BCM8957X_EARLY_INIT_PROC
    @trace #BRCM_SWREQ_BCM8957X_INITIALIZATION
*/
static volatile uint32_t BCM8957X_MCUInitErr = BCM_ERR_OK;

/**
    @trace #BRCM_SWARCH_BCM8957X_EARLY_INIT_PROC
    @trace #BRCM_SWREQ_BCM8957X_INITIALIZATION
*/
static volatile uint32_t BCM8957X_MCUInitDone = FALSE;

/**
    @trace #BRCM_SWARCH_BCM8957X_EARLY_INIT_PROC
    @trace #BRCM_SWREQ_BCM8957X_INITIALIZATION
*/
uint32_t BCM8957X_EarlyInitTime;

/**
   @name Device group start addresses
   @{
   @brief Device Peripheral Address

   @trace #BRCM_SWARCH_BCM8957X_EARLY_INIT_PROC
   @trace #BRCM_SWREQ_BCM8957X_INITIALIZATION
*/
#define BCM8957X_DEVICE_GRP1_START       (0x40100000UL) /* 0x40100000 to 0x4014FFFF 512KB */
#define BCM8957X_DEVICE_GRP2_START       (0x48000000UL) /* 0x49000000 to 0x49FFFFFF and
                                                           0x4A000000 to 0x4AFFFFFF and
                                                           0x4D000000 to 0x4DFFFFFF (16MB x3) */
#define BCM8957X_DEVICE_GRP3_START       (0x4B000000UL) /* to 0x4B0160FF 128KB */
#define BCM8957X_DEVICE_GRP4_START       (0x4B180000UL) /* to 0x4B1811FF   8KB */
#define BCM8957X_DEVICE_GRP5_START       (0x4B280000UL) /* to 0x4B28001F   32B */
#define BCM8957X_DEVICE_GRP6_START       (0x4C000000UL) /* to 0x4C1FFFFF   2MB */
#define BCM8957X_DEVICE_GRP7_START       (0x4C200000UL) /* to 0x4C24FFFF 512KB */
/** @} */

/**
    @trace #BRCM_SWARCH_BCM8957X_EARLY_INIT_PROC
    @trace #BRCM_SWREQ_BCM8957X_INITIALIZATION
*/
#define BCM8957X_DEVICE_MEMORY_ATTRIB (CORTEX_MX_MPU_ATTRIB_TEX_0\
                            | CORTEX_MX_MPU_ATTRIB_BUFFERABLE\
                            | CORTEX_MX_MPU_ATTRIB_PRIVILEGE\
                            | CORTEX_MX_MPU_ATTRIB_NEVER_EXEC)

/**
    @{
    @brief MCU specific MPU region start addresses

    @trace #BRCM_SWARCH_BCM_ADDTASK_MPUENTRY_PROC
    @trace #BRCM_SWREQ_BCM_THREAD_PROTECTION_BCM8957X
*/
#define BCM_TASK_ATTRIB    (CORTEX_MX_MPU_ATTRIB_TEX_1 \
                                | CORTEX_MX_MPU_ATTRIB_CACHEABLE \
                                | CORTEX_MX_MPU_ATTRIB_BUFFERABLE \
                                | CORTEX_MX_MPU_ATTRIB_FULL_ACCESS \
                                | CORTEX_MX_MPU_ATTRIB_NEVER_EXEC)
/** @} */

/**
    @{
    @brief MCU specific MPU region start addresses

    @trace #BRCM_SWARCH_BCM8957X_EARLY_INIT_PROC
    @trace #BRCM_SWREQ_BCM8957X_INITIALIZATION
*/
typedef struct sBCM8957X_MPUTableType {
    uint32_t baseAddress;
    CORTEX_MX_MPUAttribType attrib;
} BCM8957X_MPUTableType;
/** @} */

/**
    @trace #BRCM_SWARCH_BCM8957X_EARLY_INIT_PROC
    @trace #BRCM_SWREQ_BCM8957X_INITIALIZATION
*/
#define BCM8957X_DEVICE_MPU_TABLE_SIZE  (7UL)

/**
    @trace #BRCM_SWARCH_BCM8957X_EARLY_INIT_PROC
    @trace #BRCM_SWREQ_BCM8957X_INITIALIZATION
*/
const BCM8957X_MPUTableType BCM8957X_DeviceMPUTable[BCM8957X_DEVICE_MPU_TABLE_SIZE] = {
    {BCM8957X_DEVICE_GRP1_START, CORTEX_MX_MPU_ATTRIB_SIZE_512K
                                | BCM8957X_DEVICE_MEMORY_ATTRIB
                                | CORTEX_MX_MPU_ATTRIB_SR5_DISABLE
                                | CORTEX_MX_MPU_ATTRIB_SR6_DISABLE
                                | CORTEX_MX_MPU_ATTRIB_SR7_DISABLE},
    {BCM8957X_DEVICE_GRP2_START, CORTEX_MX_MPU_ATTRIB_SIZE_128M
                                | CORTEX_MX_MPU_ATTRIB_SR0_DISABLE
                                | CORTEX_MX_MPU_ATTRIB_SR3_DISABLE
                                | CORTEX_MX_MPU_ATTRIB_SR4_DISABLE
                                | CORTEX_MX_MPU_ATTRIB_SR6_DISABLE
                                | CORTEX_MX_MPU_ATTRIB_SR7_DISABLE
                                |  BCM8957X_DEVICE_MEMORY_ATTRIB },
    {BCM8957X_DEVICE_GRP3_START, CORTEX_MX_MPU_ATTRIB_SIZE_128K
                                | BCM8957X_DEVICE_MEMORY_ATTRIB
                                | CORTEX_MX_MPU_ATTRIB_SR6_DISABLE
                                | CORTEX_MX_MPU_ATTRIB_SR7_DISABLE},
    {BCM8957X_DEVICE_GRP4_START, CORTEX_MX_MPU_ATTRIB_SIZE_8K
                                | BCM8957X_DEVICE_MEMORY_ATTRIB
                                | CORTEX_MX_MPU_ATTRIB_SR5_DISABLE
                                | CORTEX_MX_MPU_ATTRIB_SR6_DISABLE
                                | CORTEX_MX_MPU_ATTRIB_SR7_DISABLE},
    {BCM8957X_DEVICE_GRP5_START, CORTEX_MX_MPU_ATTRIB_SIZE_32B
                                | BCM8957X_DEVICE_MEMORY_ATTRIB},
    {BCM8957X_DEVICE_GRP6_START, CORTEX_MX_MPU_ATTRIB_SIZE_2M
                                | BCM8957X_DEVICE_MEMORY_ATTRIB
                                | CORTEX_MX_MPU_ATTRIB_SR1_DISABLE
                                | CORTEX_MX_MPU_ATTRIB_SR2_DISABLE
                                | CORTEX_MX_MPU_ATTRIB_SR3_DISABLE},
    {BCM8957X_DEVICE_GRP7_START, CORTEX_MX_MPU_ATTRIB_SIZE_512K
                                | BCM8957X_DEVICE_MEMORY_ATTRIB
                                | CORTEX_MX_MPU_ATTRIB_SR5_DISABLE
                                | CORTEX_MX_MPU_ATTRIB_SR6_DISABLE
                                | CORTEX_MX_MPU_ATTRIB_SR7_DISABLE},
};

/**
   @name Device memory start address
   @{
   @brief Device memory start address

   @trace #BRCM_SWARCH_BCM8957X_EARLY_INIT_PROC
   @trace #BRCM_SWREQ_BCM8957X_INITIALIZATION
*/
#define BCM8957X_MEMORY_ITCM_CODE_RO_START      (0x00000000UL) /*BootRom memory Space*/
#define BCM8957X_MEMORY_ITCM_PRIVDATA_START     (0x00060000UL) /*ITCM BL Download memory Region*/
#define BCM8957X_MEMORY_DTCM_DATA_RW_START      (0x20000000UL) /*DTCM memory Region*/
#define BCM8957X_MEMORY_FLASH_START             (0x60000000UL) /*XIP Flash memory Region*/
#define BCM8957X_MEMORY_DTCM_IPC_RW_START       (0x2007C000UL) /*IPC Memory*/
#define BCM8957X_MEMORY_SCRATCH_PORT0_START     (0x64000000UL) /*Scratch memory Region*/
/** @} */

/**
    @trace #BRCM_SWARCH_BCM8957X_EARLY_INIT_PROC
    @trace #BRCM_SWREQ_BCM8957X_INITIALIZATION
*/
const BCM8957X_MPUTableType BCM8957X_MemoryMPUTable[] = {
#if defined(ENABLE_FW_LOAD)
    {BCM8957X_MEMORY_FLASH_START, CORTEX_MX_MPU_ATTRIB_SIZE_2M
                                | CORTEX_MX_MPU_ATTRIB_TEX_1
                                | CORTEX_MX_MPU_ATTRIB_READ_ONLY },
    {BCM8957X_MEMORY_ITCM_CODE_RO_START, CORTEX_MX_MPU_ATTRIB_SIZE_512K
                                | CORTEX_MX_MPU_ATTRIB_TEX_1
                                | CORTEX_MX_MPU_ATTRIB_FULL_ACCESS
                                | CORTEX_MX_MPU_ATTRIB_SR0_DISABLE
                                | CORTEX_MX_MPU_ATTRIB_SR1_DISABLE },
    {BCM8957X_MEMORY_DTCM_DATA_RW_START, CORTEX_MX_MPU_ATTRIB_SIZE_512K
                                | CORTEX_MX_MPU_ATTRIB_TEX_1
                                | CORTEX_MX_MPU_ATTRIB_FULL_ACCESS
                                | CORTEX_MX_MPU_ATTRIB_NEVER_EXEC },
    {BCM8957X_MEMORY_DTCM_IPC_RW_START, CORTEX_MX_MPU_ATTRIB_SIZE_16K
                                | CORTEX_MX_MPU_ATTRIB_TEX_1
                                | CORTEX_MX_MPU_ATTRIB_USER_READ
                                | CORTEX_MX_MPU_ATTRIB_NEVER_EXEC },
    {BCM8957X_MEMORY_SCRATCH_PORT0_START, CORTEX_MX_MPU_ATTRIB_SIZE_64K
                                    | CORTEX_MX_MPU_ATTRIB_TEX_1
                                    | CORTEX_MX_MPU_ATTRIB_FULL_ACCESS
                                    | CORTEX_MX_MPU_ATTRIB_NEVER_EXEC
                                    | CORTEX_MX_MPU_ATTRIB_SR5_DISABLE
                                    | CORTEX_MX_MPU_ATTRIB_SR6_DISABLE
                                    | CORTEX_MX_MPU_ATTRIB_SR7_DISABLE },
#else
    {BCM8957X_MEMORY_ITCM_CODE_RO_START, CORTEX_MX_MPU_ATTRIB_SIZE_512K
                                | CORTEX_MX_MPU_ATTRIB_TEX_1
                                | CORTEX_MX_MPU_ATTRIB_READ_ONLY
                                | CORTEX_MX_MPU_ATTRIB_SR0_DISABLE
                                | CORTEX_MX_MPU_ATTRIB_SR1_DISABLE
                                | CORTEX_MX_MPU_ATTRIB_SR6_DISABLE
                                | CORTEX_MX_MPU_ATTRIB_SR7_DISABLE },
    {BCM8957X_MEMORY_ITCM_PRIVDATA_START, CORTEX_MX_MPU_ATTRIB_SIZE_128K
                                | CORTEX_MX_MPU_ATTRIB_TEX_1
                                | CORTEX_MX_MPU_ATTRIB_USER_READ
                                | CORTEX_MX_MPU_ATTRIB_NEVER_EXEC },
    {BCM8957X_MEMORY_DTCM_DATA_RW_START, CORTEX_MX_MPU_ATTRIB_SIZE_512K
                                | CORTEX_MX_MPU_ATTRIB_TEX_1
                                | CORTEX_MX_MPU_ATTRIB_FULL_ACCESS
                                | CORTEX_MX_MPU_ATTRIB_NEVER_EXEC },
    {BCM8957X_MEMORY_DTCM_DATA_RW_START, CORTEX_MX_MPU_ATTRIB_SIZE_256K
                                | CORTEX_MX_MPU_ATTRIB_TEX_1
                                | CORTEX_MX_MPU_ATTRIB_READ_ONLY
                                | CORTEX_MX_MPU_ATTRIB_SR0_DISABLE
                                | CORTEX_MX_MPU_ATTRIB_SR6_DISABLE
                                | CORTEX_MX_MPU_ATTRIB_SR7_DISABLE },
    {BCM8957X_MEMORY_DTCM_IPC_RW_START, CORTEX_MX_MPU_ATTRIB_SIZE_16K
                                | CORTEX_MX_MPU_ATTRIB_TEX_1
                                | CORTEX_MX_MPU_ATTRIB_USER_READ
                                | CORTEX_MX_MPU_ATTRIB_NEVER_EXEC },
    {BCM8957X_MEMORY_SCRATCH_PORT0_START, CORTEX_MX_MPU_ATTRIB_SIZE_64K
                                    | CORTEX_MX_MPU_ATTRIB_TEX_1
                                    | CORTEX_MX_MPU_ATTRIB_FULL_ACCESS
                                    | CORTEX_MX_MPU_ATTRIB_NEVER_EXEC
                                    | CORTEX_MX_MPU_ATTRIB_SR5_DISABLE
                                    | CORTEX_MX_MPU_ATTRIB_SR6_DISABLE
                                    | CORTEX_MX_MPU_ATTRIB_SR7_DISABLE },

#endif
};

/**
    @trace #BRCM_SWARCH_BCM8957X_EARLY_INIT_PROC
    @trace #BRCM_SWREQ_BCM8957X_INITIALIZATION
*/
#define BCM8957X_MEMORY_MPU_TABLE_SIZE  (sizeof(BCM8957X_MemoryMPUTable)/sizeof(BCM8957X_MPUTableType))


/**
    @trace #BRCM_SWARCH_BCM8957X_EARLY_INIT_PROC
    @trace #BRCM_SWREQ_BCM8957X_INITIALIZATION
*/
static void BCM8957X_CPUInit(void)
{
    extern uint8_t __bss_start__[];
    extern uint8_t __bss_end__[];
    extern uint8_t __privileged_bss_start__[];
    extern uint8_t __privileged_bss_end__[];

    CORTEX_MX_MPUDisable();

    uint32_t i = 0UL;

    for (i = 0UL; i < BCM8957X_DEVICE_MPU_TABLE_SIZE; i++) {
        CORTEX_MX_MPUConfigure(i, BCM8957X_DeviceMPUTable[i].baseAddress,
                                    BCM8957X_DeviceMPUTable[i].attrib);
    }
    for (i = 0UL; i < BCM8957X_MEMORY_MPU_TABLE_SIZE; i++) {
        CORTEX_MX_MPUConfigure(BCM8957X_DEVICE_MPU_TABLE_SIZE + i,
                                    BCM8957X_MemoryMPUTable[i].baseAddress,
                                    BCM8957X_MemoryMPUTable[i].attrib);
    }

    CORTEX_MX_MPUEnable();

    /* CLEAR BSS section */
    BCM_MemSet(__bss_start__, 0U, (uint32_t)__bss_end__ - (uint32_t)__bss_start__);
    BCM_MemSet(__privileged_bss_start__, 0U, (uint32_t)__privileged_bss_end__ - (uint32_t)__privileged_bss_start__);

#if defined(ENABLE_DATA_SEGMENT_COPY)
    extern uint8_t __data_content_start__[];
    extern uint8_t __data_start__[];
    extern uint8_t __data_end__[];
    BCM_MemCpy(__data_start__, __data_content_start__, (uint32_t)__data_end__ - (uint32_t)__data_start__);
#endif
    /*Enable Faults and Disable Interrupts */
    CORTEX_MX_FAULT_ENABLE();
    CORTEX_MX_INTR_DISABLE();
    CORTEX_MX_SysTickInit(CPU_CLOCK/1000UL);

}

/**
    @trace #BRCM_SWARCH_BCM_ADDTASK_MPUENTRY_PROC
    @trace #BRCM_SWREQ_BCM_THREAD_PROTECTION_BCM8957X
*/
#if defined(ENABLE_THREAD_PROTECTION)

void BCM_AddTaskMPUEntry(uint32_t aTaskID)
{
    uint32_t sizeAttr;

    CORTEX_MX_MPUDisable();
    sizeAttr = CORTEX_MX_MPUGetSizeAttrib((uint32_t)BRCM_TaskInfo[aTaskID].size << 2UL, (uint32_t)BRCM_TaskInfo[aTaskID].size << 2UL);

    if (sizeAttr > 0UL) {
        CORTEX_MX_MPUConfigure(BCM8957X_DEVICE_MPU_TABLE_SIZE + BCM8957X_MEMORY_MPU_TABLE_SIZE,
                (uint32_t)BRCM_TaskInfo[aTaskID].base, (sizeAttr | BCM_TASK_ATTRIB));
    }
    CORTEX_MX_MPUEnable();
}

/**
    @trace #BRCM_SWARCH_BCM_THREAD_STACK_PROC
    @trace #BRCM_SWREQ_BCM_THREAD_PROTECTION_BCM8957X
*/
void BCM_MPUAddInitThreadStack(void)
{
    uint32_t sizeAttr;
    CORTEX_MX_MPUDisable();
    sizeAttr = CORTEX_MX_MPUGetSizeAttrib((uint32_t)BCM_init_thread_stack_size, (uint32_t)BCM_init_thread_stack_size);

    if (sizeAttr > 0UL) {
        CORTEX_MX_MPUConfigure(BCM8957X_DEVICE_MPU_TABLE_SIZE + BCM8957X_MEMORY_MPU_TABLE_SIZE,
                (uint32_t)BCM_init_thread_stack - (uint32_t)BCM_init_thread_stack_size,
                (sizeAttr | BCM_TASK_ATTRIB));
    }
    CORTEX_MX_MPUEnable();
}
#endif

/**
    @trace #BRCM_SWARCH_BCM8957X_EARLY_INIT_PROC
    @trace #BRCM_SWREQ_BCM8957X_INITIALIZATION
*/
static const MCU_ClkCfgType BCM8957X_ClkCfgTbl[] = {
    {
        .cfgID = MCU_CLK_CFG_ID_QSPI0_SRC250_83MHZ,   /* QSPI @ 83MHZ */
        .clkRef = {
            .clkID = MCU_CLK_ID_QSPI,
            .freq = BCM_FREQ_MHZ(83),
            .cntrl = {[0] = 0x3, [1] = 0x7},  /* Ignored by MCU */
        },
    },
    {
        .cfgID = MCU_CLK_CFG_ID_QSPI0_SRC250_50MHZ,   /* QSPI @ 50MHZ */
        .clkRef = {
            .clkID = MCU_CLK_ID_QSPI,
            .freq = BCM_FREQ_MHZ(50),
            .cntrl = {[0] = 0x3, [1] = 0x7},
        },
    },
    {
        .cfgID = MCU_CLK_CFG_ID_QSPI0_SRC250_25MHZ,   /* QSPI @ 25MHZ */
        .clkRef = {
            .clkID = MCU_CLK_ID_QSPI,
            .freq = BCM_FREQ_MHZ(25),
            .cntrl = {[0] = 0x2, [1] = 0x7},
        },
    },
    {
        .cfgID = MCU_CLK_CFG_ID_MDIO,   /* MDIO @ 100MHZ */
        .clkRef = {
            .clkID = MCU_CLK_ID_MDIO,
            .freq = BCM_FREQ_MHZ(100),
        },
    },
};

/**
    @trace #BRCM_SWARCH_BCM8957X_EARLY_INIT_PROC
    @trace #BRCM_SWREQ_BCM8957X_INITIALIZATION
*/
static const MCU_ConfigType BCM8957X_McuConfig = {
    .clkSrcFailNotification = MCU_CLK_SRC_NOTIFICATION_EN,
    .clkCfgTbl = BCM8957X_ClkCfgTbl,
    .clkCfgTblSize = (sizeof(BCM8957X_ClkCfgTbl) / sizeof(MCU_ClkCfgType)),
    .ramCfgTbl = NULL,
    .ramCfgTblSize = 0UL,
};

/**
    @trace #BRCM_SWARCH_BCM8957X_EARLY_INIT_PROC
    @trace #BRCM_SWREQ_BCM8957X_INITIALIZATION
*/
static void BCM8957X_MCUInit(void)
{
    MCU_PllStatusType pllStatus = MCU_PLLSTATUS_UNLOCKED;
    uint32_t i = 0UL;

    MCU_Init(&BCM8957X_McuConfig);

    /*
     * Wait for all the PLLs to be locked
     */
    while (pllStatus != MCU_PLLSTATUS_LOCKED) {
        pllStatus = MCU_GetPllStatus();
    }


    /*
     * Initialize QSPI clock
     */
#ifdef ENABLE_FLASH
    if (MCU_FlashClkTblPtr != NULL) {
        for (i = 0UL; i < MCU_FlashClkTblSz; i++) {
            BCM8957X_MCUInitErr = MCU_ClkInit(MCU_FlashClkTblPtr[i]);
            if (BCM_ERR_OK != BCM8957X_MCUInitErr) {
                break;
            }
        }
    }
#endif /* ENABLE_FLASH */

    /*
     * Initialize all the RAM sections
     */
    if ((BCM_ERR_OK == BCM8957X_MCUInitErr) && (BCM8957X_McuConfig.ramCfgTbl != NULL)) {
        for (i = 0UL; i < BCM8957X_McuConfig.ramCfgTblSize; i++) {
            MCU_RamSectionInit(i);
        }
    }

    if (BCM8957X_MCUInitErr != BCM_ERR_OK) {
        /* @event            Infinite loop
           @issue            while (1UL) never exit
           @risk             No risk
           @justification    This infinite loop is intentional, which triggers
                             watchdog reset when the initialization is failed.
        */

        /* coverity[no_escape] */
        /* coverity[loop_top] */
        /* coverity[loop_bottom] */
        while (1UL) { }
    }
}


/**
    @trace #BRCM_SWARCH_BCM8957X_EARLY_INIT_PROC
    @trace #BRCM_SWREQ_BCM8957X_INITIALIZATION
*/
void BCM8957X_EarlyInit(void)
{
    BCM8957X_CPUInit();

    /* initialize MCU */
    BCM8957X_MCUInit();

#ifdef ENABLE_FW_LOAD
    BCM8957X_EarlyInitTime = (uint32_t)(TIM_GetTimeRaw(0UL) / 1000000ULL);
    CORTEX_MX_SysTickCount = (uint64_t)(TIM_GetTimeRaw(0UL) / 1000000ULL);
#endif
    BCM8957X_MCUInitDone = TRUE;

}
/** @} */
