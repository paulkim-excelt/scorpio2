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

    .syntax unified
    .arch armv7-m
    .cpu cortex-m7
    .code 16
    .text

.section .reset_func
    B   BCM_OS_RESET_HANDLER

/*=====================================================
    Macros
=======================================================*/

/*=====================================================
    Externs
=======================================================*/

    .extern BCM8957X_EarlyInit
    .extern __main_stack__
    .extern BCM_init_thread_stack

    .extern chip_nmi_handler
    .extern SysTick_IRQHandler
    .extern BCM_MPUAddInitThreadStack
    .extern CORTEX_MX_EnableDiv0Trap
    .extern CORTEX_MX_SysTickHandler

/*=====================================================
    Reset handler
=======================================================*/

    .global  BCM_OS_RESET_HANDLER
    .global  main

BCM_OS_RESET_HANDLER:
    LDR r0, =CORTEX_MX_VECTOR_TBL
    LDR r1, =0xE000ED08
    STR r0, [r1]

/*=====================================================
    Setup exception stack and do low level
    chip initialization (MPU configuration, memory init etc)
=======================================================*/
    LDR r0, =__main_stack__
    MSR MSP, r0

    BLX     BCM8957X_EarlyInit
    BLX     CORTEX_MX_EnableDiv0Trap

#ifdef ENABLE_THREAD_PROTECTION
    BL      BCM_MPUAddInitThreadStack
    BLX     CORTEX_MX_INTREnable

    MOV     r0, #0x1                        /* thread Mode: unprivileged */
    MOV     r1, #0x1                        /* Stack: use PSP for thread mode */
    LDR     r2, =BCM_init_thread_stack      /* stack: init stack for PSP */
    BL      CORTEX_MX_SetThreadMode
#else
    BLX     CORTEX_MX_INTREnable
    MOV     r0, #0x0                        /* thread Mode:  privileged */
    MOV     r1, #0x1                        /* Stack: use PSP for thread mode */
    LDR     r2, =BCM_init_thread_stack      /* stack: init stack for PSP */
    BL      CORTEX_MX_SetThreadMode
#endif

    MOV     r0, #0x0
    BLX     BCM_StartOS
LOOP:
    b       LOOP
main:
    b       main
/*=====================================================
    exception handlers
=======================================================*/
    .global BCM_OS_NMI_ISR
    .global BCM_OS_HARD_FAULT_ISR
    .global BCM_OS_MPU_FAULT_ISR
    .global BCM_OS_BUS_FAULT_ISR
    .global BCM_OS_USAGE_FAULT_ISR
    .global BCM_OS_DEBUG_MONITOR_ISR
    .global BCM_OS_SYSTICK_ISR
    .global irq_handler
    .global reserved_handler

BCM_OS_NMI_ISR:
    PUSH {lr}
    BL   chip_nmi_handler
    POP  {lr}
    bx   lr

BCM_OS_HARD_FAULT_ISR:
    b BCM_OS_HARD_FAULT_ISR

BCM_OS_MPU_FAULT_ISR:
    b BCM_OS_MPU_FAULT_ISR

BCM_OS_BUS_FAULT_ISR:
    b BCM_OS_BUS_FAULT_ISR

BCM_OS_USAGE_FAULT_ISR:
    b BCM_OS_USAGE_FAULT_ISR

BCM_OS_DEBUG_MONITOR_ISR:
    b BCM_OS_DEBUG_MONITOR_ISR

BCM_OS_SYSTICK_ISR:
    PUSH {lr}
    BL   CORTEX_MX_SysTickHandler
    POP  {lr}
    bx   lr


irq_handler:
    b irq_handler

reserved_handler:
    b reserved_handler
