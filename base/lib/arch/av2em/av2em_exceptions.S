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

.include arc_aux_regs.S

.ldefine ARC_STATUS32_FLAGS_BANK0,        ((0 << ARC_STATUS32_BANK_SHIFT) & ARC_STATUS32_BANK_MASK)
.ldefine ARC_STATUS32_FLAGS_BANK1,        ((1 << ARC_STATUS32_BANK_SHIFT) & ARC_STATUS32_BANK_MASK)

.ldefine ARC_STATUS32_FLAGS_BANK0_ISR,    (ARC_STATUS32_DZ_BIT | ARC_STATUS32_L_BIT | ARC_STATUS32_FLAGS_BANK0)
.ldefine ARC_STATUS32_FLAGS_BANK1_ISR_SC, (ARC_STATUS32_DZ_BIT | ARC_STATUS32_L_BIT | ARC_STATUS32_SC_BIT | ARC_STATUS32_FLAGS_BANK1)
.ldefine ARC_STATUS32_FLAGS_BANK0_AE_SC,  (ARC_STATUS32_DZ_BIT | ARC_STATUS32_L_BIT | ARC_STATUS32_SC_BIT | ARC_STATUS32_FLAGS_BANK0 | ARC_STATUS32_AE_BIT)
.ldefine ARC_STATUS32_FLAGS_BANK1_AE_SC,  (ARC_STATUS32_DZ_BIT | ARC_STATUS32_L_BIT | ARC_STATUS32_SC_BIT | ARC_STATUS32_FLAGS_BANK1 | ARC_STATUS32_AE_BIT)

BASE_AV2EmContextSwitchISR::
    # Clear off the interrupt
    sr 0, [ARC_AUX_IRQ_HINT_ADDR]

    # CPU should have automatically switched us to Bank1 at this
    # point (because this should be configured as a FIRQ handler).
    #
    # We would however like to turn on the HW stack checking and the
    # DivZero exceptions
    kflag ARC_STATUS32_FLAGS_BANK1_ISR_SC

    # Before calling any C functions, save off the zero overhead loop
    # context to callee saved registers
    lr r14, [ARC_LP_START_ADDR]
    lr r15, [ARC_LP_END_ADDR]
    mov r16, r60

    # Invoke the scheduler and see if a context switch is really needed
    bl BASE_GetNextTaskToSched
    mov r2, BASE_CurTaskId
    ld_s r1, [r2]
    brne r0, r1, switchops

    # Context switch not needed.
    # Restore the zero overhead loop context and return
    mov r60, r16
    sr r15, [ARC_LP_END_ADDR]
    sr r14, [ARC_LP_START_ADDR]

    rtie

switchops:
    # Context switch is needed.
    #
    # Stash the next task ID and the zero overhead loop context
    # in a global scratch memory
    mov r17, BASE_AV2EMCtxSwitchGblMem
    st r0,  [r17]
    st r14, [r17, 4]
    st r15, [r17, 8]
    st r16, [r17, 12]

    # Execute the task switch post-ops
    bl BASE_TaskSwitchPostOps

    # Switch to bank0 to save the task context to the user stack.
    # HW stack checking needs to be disabled as we will be manipulating
    # the user stack after this.
    kflag ARC_STATUS32_FLAGS_BANK0_ISR

    # Start by dumping the general purpose registers onto the
    # user stack
    enter_s {r13-r26}
    .irep num, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 27, 30, 31, 29
        push r\&num
    .endr

    # Dump the zero overhead loop context on the stack
    mov r17, BASE_AV2EMCtxSwitchGblMem
    ld r14, [r17, 4]
    ld r15, [r17, 8]
    ld r16, [r17, 12]
    .irep num, 14, 15, 16
        push r\&num
    .endr

    # Finally, save the status32 register
    lr r0, [ARC_STATUS32_P0_ADDR]
    push r0

    # Context save ops complete.
    #
    # Load the new and old task ID's. Update the BASE_CurTaskId global
    # with the value of the new task ID
    mov r2, BASE_CurTaskId
    ld r0, [r17]
    ld r1, [r2]
    st r0, [r2]

    # Stash the sp of the old task in the kernel data structures.
    # Load the sp of the new task from the same data structures.
    mov r3, BASE_TaskStatesFirstSpAddr
    mov r4, BASE_TaskStatesSpStride
    ld  r3, [r3]
    ld  r4, [r4]

    mpy r1, r1, r4
    add_s r1, r1, r3
    st sp, [r1]

    mpy r0, r0, r4
    add_s r0, r0, r3
    ld sp, [r0]

    # Context restore ops.
    # Restore the status32 register
    pop r0
    sr r0, [ARC_STATUS32_P0_ADDR]

    # Next, the zero overhead loop context
    .irep num, 16, 15, 14
        pop r\&num
    .endr

    sr r14, [ARC_LP_START_ADDR]
    sr r15, [ARC_LP_END_ADDR]
    mov r60, r16

    # Next, restore the general purpose registers
    .irep num, 29, 31, 30, 27, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0
        pop r\&num
    .endr
    leave_s {r13-r26}

    # Switch back to bank 1
    kflag ARC_STATUS32_FLAGS_BANK1_ISR_SC

    rtie

BASE_AV2EmTrapHandler::
    # Prepare for a register bank switch.
    #
    # The two trap args in r0 and r1 have to be made available
    # in the new bank. Push them to the kernel stack to start with.
    push_s r0
    push_s r1

    # sp is banked. At this point, sp in bank1 is at the kernel base
    # address while sp in bank0 (the current bank) is ahead by two words.
    #
    # Switch bank while adjusting these pointers
    add_s sp, sp, 8
    kflag ARC_STATUS32_FLAGS_BANK1_AE_SC
    sub_s sp, sp, 8

    # Restore trap args into the new register bank
    pop_s r1
    pop_s r0

    # Make sure that this trap request came from the user mode
    #
    # Bit 7 in the erstatus register (if set) indicates that the CPU
    # was in user mode when the exception was taken
    lr r2, [ARC_ERSTATUS_ADDR]
    btst_s r2, 7
    b.z BCM_OS_DEFAULT_HANDLER

    # Save the zero overhead loop context to the callee saved registers
    lr r14, [ARC_LP_START_ADDR]
    lr r15, [ARC_LP_END_ADDR]
    mov r16, r60

    # Branch to the handler
    bl SVC_CmdHandler

    # Restore the zero overhead loop context
    sr r14, [ARC_LP_START_ADDR]
    sr r15, [ARC_LP_END_ADDR]
    mov r60, r16

    # Switch back to bank 0.
    #
    # The exception exit sequence swaps the contents of the
    # AUX_USER_SP with the sp of the current bank.
    #
    # We do not want sp of the BANK1 to point to anything other
    # than the kernel base. Therefore, switch to bank 0 before
    # issuing rtie.
    #
    # sp of bank 0 should already pointing to the kernel stack base
    kflag ARC_STATUS32_FLAGS_BANK0_AE_SC

    # Return from the exception
    rtie

