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
    .arch armv7-r
    .cpu cortex-r4

    .code 32
    .text

    .macro  BASE_ARMV7R_EXCEPTION_HANDLER EXCEPT_MODE HANDLER_INNER EXIT1 EXIT2
        /* Start off by pushing the LR and SPSR onto the task stack                     */
                SRSDB sp!, #16
        /*  Switch to the system mode and push the caller-saved regs on the task stack  */
                CPSID   i, #31
                PUSH    {r0-r3, r12, lr}
        /*  Switch back to the original exception mode. This would mean that we would   */
        /*  be working with a preconfigured exception stack                             */
                CPSID   i, #\EXCEPT_MODE
        /*  Reset the BASE_ARMv7rRunSchedOnExit global                                  */
                LDR r2, =BASE_ARMv7rRunSchedOnExit
                MOV r3, #0
                STR r3, [r2]
        /*  Call the handler routine                                                    */
                BLX \HANDLER_INNER
        /*  Check if we need to run the scheduler                                       */
                LDR r0, =BASE_ARMv7rRunSchedOnExit
                LDR r0, [r0]
                CMP r0, #0
                BEQ \EXIT1
        /*  Context switch may be needed. Invoke the scheduler to get                   */
        /*  the ID of the next task                                                     */
                BLX BASE_GetNextTaskToSched
        /*  Load the ID of the current task.                                            */
        /*  If the new task ID returned by the scheduler is the same as the old one,    */
        /*  bail out.                                                                   */
        /*  Else, proceed with the context switching. Update the BASE_CurTaskId global  */
                LDR r2, =BASE_CurTaskId
                LDR r1, [r2]
                CMP r0, r1
                BEQ \EXIT1
                STR r0, [r2]
        /*  Perform context switching. Start off by running the TaskSwitchPostOps       */
        /*  function                                                                    */
                PUSH {r0, r1}
                BLX BASE_TaskSwitchPostOps
                POP {r0, r1}
        /*  Switch to the system mode.                                                  */
        /*  This gives us the ability to manipulate the task stacks directly            */
                CPSID   i, #31
        /*  Save the current context on the task stack                                  */
                STMFD sp!, {r4-r11}
        /*  Store the current (updated) SP inside the kernel data structures.           */
        /*  Then fetch the stack pointer of the next task from the said data structures */
                LDR r4, =BASE_TaskStatesFirstSpAddr
                LDR r5, =BASE_TaskStatesSpStride
                LDR r4, [r4]
                LDR r5, [r5]
                MLA r6, r5, r1, r4
                STR sp, [r6]
                MLA r6, r5, r0, r4
                LDR sp, [r6]
        /*  Restore the context from the new stack and exit                             */
                LDMIA sp!, {r4-r11}
                B \EXIT2
        /*  Context switch was not performed. Switch to system mode now                 */
\EXIT1:         CPSID   i, #31
        /*  Restore r0-r3, LR, PC and CPSR. We will switch to the                       */
        /*  userland post the execution of the RFE instruction                          */
\EXIT2:         POP {r0-r3, r12, lr}
                RFEIA sp!
    .endm

.global BASE_ARMv7rSVCHandler
.global BASE_ARMv7rIrqHandler

BASE_ARMv7rSVCHandler:
   /* Mode 19 is the SVC exception mode */
        BASE_ARMV7R_EXCEPTION_HANDLER 19, SVC_CmdHandler, svc_exit1, svc_exit2

BASE_ARMv7rIrqHandler:
   /* Adjust the LR as specified in the ARMv7R arch manual */
        SUB lr, lr, #4
   /* Mode 18 is the ISR exception mode */
        BASE_ARMV7R_EXCEPTION_HANDLER 18, irq_generic_handler, irq_exit1, irq_exit2

