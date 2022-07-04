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

#if defined (__GHSCC__)
    .thumb2
#else
    .syntax unified
#ifdef  __CORTEX_M7__
    .arch armv7-m
    .cpu cortex-m7
#elif __CORTEX_R4__
    .arch armv7-r
    .cpu cortex-r4
#endif
    .code 16
#endif
    .text

.global BASE_ARMv7mPendSVHandler

BASE_ARMv7mPendSVHandler:
                    push {r4, lr}

        /* Disable interrupts                   */
                    BL  INTR_Suspend
                    MOV r4, r0

        /* Clear Pendsv                         */
                    BL CORTEX_MX_PendSvClear

        /* Get next task to switch to           */
                    BL BASE_GetNextTaskToSched

        /* Restore r4 and lr                    */
                    MOV r3, r4
                    pop {r4, lr}

        /* Check if a context switch is needed  */
                    LDR r12, =BASE_CurTaskId
                    LDR r1, [r12]
                    SUB r2, r0, r1
                    CBZ r2, exit

        /* Update the CurTaskId global          */
                    STR r0, [r12]

        /* Get the current PSP                  */
                    MRS r2, PSP

#if defined(BASE_ARMV7M_ENABLE_FPU_CONTEXT_SAVE_RESTORE)
        /*
            Check if FPU context is active.
            If it is, save the FPU context on the PSP
        */
                    TST lr, #0x10
                    IT eq
                    VSTMDBEQ r2!, {s16-s31}
#endif
        /* Save the general purpose registers on PSP    */
                    stmfd r2!, {r4-r11, lr}

        /*
            Store the current (updated) PSP inside the kernel data structures.
            Then fetch the stack pointer of the next task from the said
            data structures
        */
                    LDR r4, =BASE_TaskStatesFirstSpAddr
                    LDR r5, =BASE_TaskStatesSpStride
                    LDR r4, [r4]
                    LDR r5, [r5]
                    MLA r6, r5, r1, r4
                    STR r2, [r6]
                    MLA r6, r5, r0, r4
                    LDR r2, [r6]

        /* Restore the next context             */
                    ldmia r2!, {r4-r11, lr}
#if defined(BASE_ARMV7M_ENABLE_FPU_CONTEXT_SAVE_RESTORE)
        /*
            Restore the FPU context if needed
        */
                    TST lr, #0x10
                    IT eq
                    VLDMIAEQ r2!, {s16-s31}
#endif

        /* Update the PSP                       */
                    MSR PSP, r2

        /* Task switch post ops                 */
                    push {r3, lr}
                    BL BASE_TaskSwitchPostOps
                    pop {r3, lr}

         exit:      MOV r0, r3
                    B INTR_Resume

