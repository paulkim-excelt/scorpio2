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

    .syntax unified
    .arch armv7-m
    .cpu cortex-m7
    .code 16
    .text

vector_reg:
    .word 0xE000ED08
/*=====================================================
    Macros
=======================================================*/
#define VECTOR(x)           \
    .word x + 1

#define CRG_PLL_STATUS                (0x4a82001a) /* PLL Status register */
#define CRG_PLL_STATUS_PLL_LOCK_MASK  (0x2000)

#define CRG_CLOCK_CONFIG2             (0x4a82001e) /* Clock config regsiter */
#define DMU_DMU_CLK_SEL               (0x40146044) /* DMU Clock Control register */

#define DMU_CLKSEL_CPUCLK_SEL_MASK             (0x00000003)
#define DMU_CLKSEL_CPUCLK_SEL_SHIFT            (0)
#define DMU_CLKSEL_CPUCLK_SRC_TOP_PLL          (0x1)
#define DMU_CLKSEL_QCLK_SEL_MASK               (0x0000000C)
#define DMU_CLKSEL_QCLK_SEL_SHIFT              (2)
#define DMU_CLKSEL_QCLK_DIV_10                 (0x3)
#define DMU_CLKSEL_HCLK_SEL_MASK               (0x00000030)
#define DMU_CLKSEL_HCLK_SEL_SHIFT              (4)
#define DMU_CLKSEL_HCLK_DIV_2                  (1)
#define DMU_CLKSEL_PCLK_SEL_MASK               (0x000000c0)
#define DMU_CLKSEL_PCLK_SEL_SHIFT              (6)
#define DMU_CLKSEL_PCLK_DIV_2                  (1)

#define DMU_CPUCLK_VAL  (DMU_CLKSEL_CPUCLK_SRC_TOP_PLL << DMU_CLKSEL_CPUCLK_SEL_SHIFT)
#define DMU_QCLK_VAL    (DMU_CLKSEL_QCLK_DIV_10 << DMU_CLKSEL_QCLK_SEL_SHIFT)
#define DMU_HCLK_VAL    (DMU_CLKSEL_HCLK_DIV_2 << DMU_CLKSEL_HCLK_SEL_SHIFT)
#define DMU_PCLK_VAL    (DMU_CLKSEL_PCLK_DIV_2 << DMU_CLKSEL_PCLK_SEL_SHIFT)

#define DMU_CLKSEL_VAL  (DMU_CPUCLK_VAL | DMU_QCLK_VAL | DMU_HCLK_VAL | DMU_PCLK_VAL)

#define CFG_HW_MEM_INIT_EN          (0x4014811c)
#define CFG_HW_MEM_INIT_DONE_STS    (0x40148120)
#define CFG_HW_MEM_INIT_MASK        (0x7FF)

#define CFG_CFG_CPUSYS_MISC                     (0x40148004)
#define CFG_CPUSYS_MISC_MEM_INIT_DONE_CFG_MASK  (0x20000000)
#define CFG_CPUSYS_MISC_M7_ADDR_REMAP_EN_CFG_MASK (0x80000)

#define CRG_SM_FAULT_CTRL                   (0x4a820042)
#define CRG_SM_FAULT_EN_PLL_LOCK            (0x1 << 0)
#define CRG_SM_FAULT_EN_CPU_NMI_TIMEOUT     (0x1 << 2)
#define CRG_SM_FAULT_EN_ITCM_ECC_ERR        (0x1 << 4)

#define IO_STRAPS_RAW                       (0x4a840040)
#define IO_STRAPS_RAW_SFT_FORCE_DWNLD_MASK  (0x4)
#define IO_STRAPS_RAW_SFT_FORCE_DWNLD_SHIFT (2)
#define IO_STRAPS_RAW_SFT_DEBUG_MODE_MASK   (0x8000)
#define IO_STRAPS_RAW_SFT_DEBUG_MODE_SHIFT  (15)

#define OTP_FOUT_DATA4                      (0x4C012044)
#define OTP_FOUT_DATA5                      (0x4C012048)
#define OTP_FOUT_DATA6                      (0x4C01204C)

#define OTP_BROM_BYPASS_BIT_SHIFT           (28)
#define OTP_BROM_BYPASS_BIT_MASK            (0xF << 28)
#define OTP_BROM_BYPASS_VAL                 (0xA << 28)

#define CHIPMISC_HW_SPARE_REG7      (0x4A80030e)
#define CHIPMISC_RAMDUMP_MASK       (0x8000)
/*=====================================================
    Externs
=======================================================*/

    .extern __main_stack__
    .extern BL_EarlyInit
    .extern CORTEX_MX_EnableDiv0Trap
    .extern BL_main

/*======================================================
    Exception Vectors

    Thumb mode code
    bit[0] of all exception vector table entries needs
    to be 1 (except entry 0 which is for main stack),
    since cortex-m EPSR.T bit is set/reset
    based on bit[0] of exception entry code. Since
    cortex-M supports only thumb mode, EPSR.T must
    be always 1. Trying to execute an instruction
    while EPSR.T bit is set 0, will lead to hardfault
=======================================================*/

    .section .vector_tbl
    .code   16
    .global  __vectors

#ifdef ENABLE_RESET_FUNC_AT_START
    B CORTEX_MX_RESET_HANDLER
#endif

__vectors:
    VECTOR(__main_stack__)
    VECTOR(CORTEX_MX_RESET_HANDLER)
    VECTOR(CORTEX_MX_NMI_FAULT)
    VECTOR(CORTEX_MX_HARD_FAULT)
    VECTOR(CORTEX_MX_MPU_FAULT)
    VECTOR(CORTEX_MX_BUS_FAULT)
    VECTOR(CORTEX_MX_USAGE_FAULT)
    VECTOR(CORTEX_MX_RSVD)
    VECTOR(CORTEX_MX_RSVD)
    VECTOR(CORTEX_MX_RSVD)
    VECTOR(CORTEX_MX_RSVD)
    VECTOR(CORTEX_MX_SVC_HANDLER)
    VECTOR(CORTEX_MX_DEBUG_MONITOR_HANDLER)
    VECTOR(CORTEX_MX_RSVD)
    VECTOR(CORTEX_MX_PENDSV_HANDLER)
    VECTOR(CORTEX_MX_SYSTICK_HANDLER)
    VECTOR(CORTEX_MX_IRQ_HANDLER)



/*=====================================================
    Reset handler
=======================================================*/

    .global  CORTEX_MX_RESET_HANDLER

CORTEX_MX_RESET_HANDLER:
    LDR r0, =__vectors
    LDR r1, =vector_reg
    LDR r1, [r1]
    STR r0, [r1]
#if APP_TEST_MODE == 1
    blx     APP_Init   /* jump to test main */
#else
#ifdef BCM8957X_ENABLE_ROM_BYPASS
/*=====================================================
 * Check ROM by-pass OTP bit
 *=====================================================*/
 /* OTP row 12 is autoloaded by the OTP controller into
    FOUT bits. row 12 data is bits[194:156] of which
    bits [159:156] is loaded into OTP_FOUT_DATA4.
    bits [191:160] is loaded into OTP_FOUT_DATA5.
    bits [194:191] is loaded into OTP_FOUT_DATA6
 */
    LDR r0, =OTP_FOUT_DATA4
    LDR r0, [r0]
    LDR r1, =OTP_BROM_BYPASS_BIT_MASK
    LDR r2, =OTP_BROM_BYPASS_VAL
    AND r1, r1, r0
    CMP r1, r2
    BNE CHECK_PLL_STATUS
#ifdef BCM8957X_ENABLE_DBG_LOG
    MOV r0, #DBG_LOG_ROM_BYPASS
    BL  BCM8957X_LogStatus
#endif
    B   .
#endif

#ifdef BCM8957X_ENABLE_CLK_SWITCH
/*=====================================================
 *  Switch CPU clk from REF_25MHz  to System PLL
 *  check if the system PLL is locked
 *  if yes, switch QSPI clock source to 250M,
 *  and ARM clock to TOP PLL
 *  if system PLL is not locked, goto while(1)
 *  loop and donot boot the device
 *  if PLL is locked, enable the PLL lock lost fault
 *  in SM state machine
 *=====================================================*/
CHECK_PLL_STATUS:
#ifdef BCM8957X_ENABLE_DBG_LOG
    MOV  r0, #DBG_LOG_CHECK_PLL_STATUS
    BL   BCM8957X_LogStatus
#endif

CHECK_PLL_STATUS_LOOP:
#ifdef BCM8957X_ENABLE_DBG_LOG
    MOV  r0, #DBG_LOG_PLL_NOT_LOCKED_LOOP
    BL   BCM8957X_LogStatus
#endif
    LDR  r0, =CRG_PLL_STATUS
    LDRH r0, [r0]
    AND  r1, r0, #CRG_PLL_STATUS_PLL_LOCK_MASK
    CMP  r1, #CRG_PLL_STATUS_PLL_LOCK_MASK
    BNE  CHECK_PLL_STATUS_LOOP

    /* Enable the lock lost fault in SM */
    LDR  r0, =CRG_SM_FAULT_CTRL
    LDRH r1, [r0]
    ORR  r1, r1, #CRG_SM_FAULT_EN_PLL_LOCK
    STRH r1, [r0]

SWITCH_CPU_CLK:
    /* switch QSPI clock source to 250M */
    LDR  r0, =CRG_CLOCK_CONFIG2
    LDRH r1, [r0]
    ORR  r1, #0x1
    STRH r1, [r0]

    LDR r0, =DMU_DMU_CLK_SEL
    /**
     * select CPU CLK : TOP PPL,  HCLK: 1/2 CPU CLK,
     * PCLK: 1/2 HCLK and QSPI: 25Mhz
     */
    MOV r1, #DMU_CLKSEL_VAL
    STR r1, [r0]
    /* dummy read */
    LDR r1, [r0]
#ifdef BCM8957X_ENABLE_DBG_LOG
    MOV r0, #DBG_LOG_SWITCH_CPU_CLK
    BL  BCM8957X_LogStatus
#endif
#endif

#ifdef BCM8957X_ENABLE_TCM_INIT
/*=====================================================
    Initialize TCM memory
    1. Initialize ALL TCM Memories (ITCM/DTCM/IPC/MEM_TOP).
    2. Set the MEM_INIT_DONE_cfg bit to 1 to enable the ECC
    3. Enable SM fault on the ECC errors
=======================================================*/
    LDR r0, =CHIPMISC_HW_SPARE_REG7
    MOV r2, #CHIPMISC_RAMDUMP_MASK
    LDRH r1, [r0]
    AND r1, r1, r2
    CMP r1, r2
    BEQ SKIP_TCM_INIT

    BL  TCMInit
SKIP_TCM_INIT:
#endif

/*=====================================================
    Setup stack
=======================================================*/
    LDR r0, =__main_stack__
    MSR MSP, r0

/*=====================================================
    Setup MPU regions
=======================================================*/
    BL  CORTEX_MX_EnableDiv0Trap
    BL  BCM8957X_RomEarlyInit

#ifdef BCM8957X_ENABLE_ADDR_REMAP
    /* Disable the M7 address remap logic now*/
    LDR r0, =CFG_CFG_CPUSYS_MISC
    LDR r1, [r0]
    BIC r1, r1, #CFG_CPUSYS_MISC_M7_ADDR_REMAP_EN_CFG_MASK
    STR r1, [r0]
#endif

/*=====================================================
    C-Entry code
=======================================================*/
    /* ensure Interrupts are disabled */
    CPSID   i
    /* ensure faults are enabled */
    CPSIE   f

#if APP_TEST_MODE == 3
    blx     APP_Init   /* jump to test main */
#else
C_ENTRY:
    blx     BCM8957X_RomMain                    /* jump to main */
#endif
#endif
LOOP:
    b       LOOP

#ifdef BCM8957X_ENABLE_DBG_LOG
/*=====================================================
 * Bootrom status logging
 *=====================================================*/
    .func BCM8957X_LogStatus
    .global BCM8957X_LogStatus
BCM8957X_LogStatus:
    LDR r1, =DBG_LOG_REGISTER
    STRH r0, [r1]
    BX LR
    .endfunc
#endif

#ifdef BCM8957X_ENABLE_TCM_INIT
/*=====================================================
  Initialize TCM memory
  This functions reset each bank of the memory using STM
  and after reset it reads the start address of the each
  bank (double word read using LDRD)

  r0: start of the memory address
  r1: bank size (must be multiple of 32). Each STM will clear
     8 words at a time
  r2: number of mem banks
 *=====================================================*/
    .func  TCMInit
    .global TCMInit

TCMInit:
    LDR r0, =CFG_HW_MEM_INIT_EN
    LDR r1, =CFG_HW_MEM_INIT_MASK
    STR r1, [r0]

    /* Wait for All memories init to complete */
    LDR r0, =CFG_HW_MEM_INIT_DONE_STS
WAIT_INIT_DONE:
    LDR r2, [r0]
    CMP r2, r1
    BEQ MEM_INIT_DONE
    B   WAIT_INIT_DONE

MEM_INIT_DONE:
    DMB

    /* Read the first location of all memories */
    LDR  r0, =0x00020000
    LDRD r1, r2, [r0]
    LDR  r0, =0x00050000
    LDRD r1, r2, [r0]
    LDR  r0, =0x20000000
    LDRD r1, r2, [r0]
    LDR  r0, =0x2003E000
    LDRD r1, r2, [r0]
    LDR  r0, = 0x2007C000
    LDRD r1, r2, [r0]

    LDR r0, =CFG_CFG_CPUSYS_MISC
    LDR r1, [r0]
    ORR r1, r1, #CFG_CPUSYS_MISC_MEM_INIT_DONE_CFG_MASK
    STR r1, [r0]
    LDR r0, =CRG_SM_FAULT_CTRL
    LDRH r1, [r0]
    ORR r1, r1, #(CRG_SM_FAULT_EN_CPU_NMI_TIMEOUT | CRG_SM_FAULT_EN_ITCM_ECC_ERR)
    STRH r1, [r0]
    BX LR
    .endfunc
#endif

/*=====================================================
    exception handlers
=======================================================*/
    .global CORTEX_MX_NMI_FAULT
    .global CORTEX_MX_HARD_FAULT
    .global CORTEX_MX_MPU_FAULT
    .global CORTEX_MX_BUS_FAULT
    .global CORTEX_MX_USAGE_FAULT
    .global CORTEX_MX_SVC_HANDLER
    .global CORTEX_MX_DEBUG_MONITOR_HANDLER
    .global CORTEX_MX_PENDSV_HANDLER
    .global CORTEX_MX_SYSTICK_HANDLER
    .global CORTEX_MX_IRQ_HANDLER
    .global CORTEX_MX_RSVD

CORTEX_MX_NMI_FAULT:
    b CORTEX_MX_NMI_FAULT

CORTEX_MX_HARD_FAULT:
    b CORTEX_MX_HARD_FAULT

CORTEX_MX_MPU_FAULT:
    b CORTEX_MX_MPU_FAULT

CORTEX_MX_BUS_FAULT:
    b CORTEX_MX_BUS_FAULT

CORTEX_MX_USAGE_FAULT:
    b CORTEX_MX_USAGE_FAULT

CORTEX_MX_SVC_HANDLER:
    b CORTEX_MX_SVC_HANDLER

CORTEX_MX_DEBUG_MONITOR_HANDLER:
    b CORTEX_MX_DEBUG_MONITOR_HANDLER

CORTEX_MX_PENDSV_HANDLER:
    b CORTEX_MX_PENDSV_HANDLER

CORTEX_MX_SYSTICK_HANDLER:
    b CORTEX_MX_SYSTICK_HANDLER

CORTEX_MX_IRQ_HANDLER:
    b CORTEX_MX_IRQ_HANDLER

CORTEX_MX_RSVD:
    b CORTEX_MX_RSVD
