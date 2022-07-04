/*****************************************************************************
 Copyright 2020-2021 Broadcom Limited.  All rights reserved.

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
    ARMv7M specific BASE kernel routines

    @file armv7m.c
    @brief ARMv7M specific BASE kernel routines
    @version 0.1 Initial Version
*/

#include <svc.h>
#include <interrupt.h>
#include <cortex_mx.h>
#include "armv7m_kernel.h"

/**
    @name BASE kernel ARMv7M design IDs
    @{
    @brief Design IDs for the BASE kernel ARMv7M port
*/
#define BRCM_SWDSGN_BASE_ARMV7M_TASK_INIT_STACK_FRAME_TYPE    (0xB301U)    /**< @brief #BASE_ARMv7mTaskInitStackFrameType */
#define BRCM_SWDSGN_BASE_ARMV7M_SVC_HANDLER_PROC              (0xB302U)    /**< @brief #BASE_ARMv7mSVCHandler             */
#define BRCM_SWDSGN_BASE_ISR2_PRESTUB_PROC                    (0xB303U)    /**< @brief #BASE_ISR2_prestub                 */
#define BRCM_SWDSGN_BASE_ISR2_POSTSTUB_PROC                   (0xB304U)    /**< @brief #BASE_ISR2_poststub                */
#define BRCM_SWDSGN_BASE_ARCH_RESET_TASK_STATE_PROC           (0xB305U)    /**< @brief #BASE_ArchResetTaskState           */
#define BRCM_SWDSGN_BASE_ARCH_RUN_SCHED_AT_EXIT_PROC          (0xB306U)    /**< @brief #BASE_ArchRunSchedAtExit           */
#define BRCM_SWDSGN_BASE_ARCH_START_OS_PROC                   (0xB307U)    /**< @brief #BASE_ArchStartOS                  */
#define BRCM_SWDSGN_BASE_EXEC_HANDOVER_PROC                   (0xB308U)    /**< @brief #BASE_ExecHandover                 */
/** @} */

/**
    @brief ARMv7M stack frame to be setup by the kernel during the task activation

    @trace #BRCM_SWARCH_BASE_ARCH_RESET_TASK_STATE_PROC
    @trace #BRCM_SWREQ_BASE_CORTEX_MX
*/
typedef struct COMP_PACKED sBASE_ARMv7mTaskInitStackFrameType {
    uint32_t regs1[8UL];    /**< @brief r4-r11                  */
    uint32_t excReturn;     /**< @brief EXC_RETURN              */
    uint32_t regs2[5UL];    /**< @brief r0-r3, r12              */
    uint32_t lr;            /**< @brief link register           */
    uint32_t pc;            /**< @brief Program counter         */
    uint32_t xpsr;          /**< @brief Program status register */
} BASE_ARMv7mTaskInitStackFrameType;

/**
    @trace #BRCM_SWARCH_BASE_ARMV7M_SVC_HANDLER_PROC
    @trace #BRCM_SWREQ_BASE_CORTEX_MX
*/
void BASE_ARMv7mSVCHandler(SVC_RequestType *const aSysReqIo, const uint32_t aSysReqID)
{
    /* Disable interrupts */
    const uint32_t intrFlags = INTR_Suspend();

    /* Invoke the command handler */
    SVC_CmdHandler(aSysReqIo, aSysReqID);

    /* Enable interrupts and switch back to thread mode */
    INTR_Resume(intrFlags);
}

/**
    @trace #BRCM_SWARCH_BASE_ISR2_PRESTUB_PROC
    @trace #BRCM_SWREQ_BASE_CORTEX_MX
*/
uint32_t BASE_ISR2_prestub(void)
{
    _Static_assert(
        sizeof(uint32_t) == sizeof(INTR_FlagType),
        "The ISR2 prestub and poststub impl rely on this condition being true!"
    );

    /* Unconditionally disable interrupts */
    return INTR_Suspend();
}

/**
    @trace #BRCM_SWARCH_BASE_ISR2_POSTSTUB_PROC
    @trace #BRCM_SWREQ_BASE_CORTEX_MX
*/
void BASE_ISR2_poststub(const uint32_t flag)
{
    /* Enable IRQ's back */
    INTR_Resume(flag);
}

/**
    @trace #BRCM_SWARCH_BASE_ARCH_RESET_TASK_STATE_PROC
    @trace #BRCM_SWREQ_BASE_CORTEX_MX
*/
void BASE_ArchResetTaskState(const uint32_t aTaskIdx)
{
    uint32_t i;

    BASE_TaskStateType *const taskState = &BASE_TaskStates[aTaskIdx];
    const BASE_TaskConstStateType *const taskConstState = &BASE_TaskConstStates[aTaskIdx];

    /* Carve out a stack frame */
    BASE_ARMv7mTaskInitStackFrameType *const stackFrame =
        (BASE_ARMv7mTaskInitStackFrameType*)(
            taskConstState->taskInfo->base + taskConstState->taskInfo->size
        ) - 1UL;

    /* Initialize the stack top pointer for the task */
    taskState->sp = (void*)stackFrame;

    /* Initialize the stack frame */
    for (i = 0UL; i < 8UL; i++) {
        stackFrame->regs1[i] = 0UL;
    }

    for (i = 0UL; i < 5UL; i++) {
        stackFrame->regs2[i] = 0UL;
    }

    /* EXC_RETURN = 0xFFFFFFFDUL => Switch to thread mode, PSP, no FPU CTX */
    stackFrame->excReturn = 0xFFFFFFFDUL;
    stackFrame->lr = 0xFFFFFFFFUL;      /* Reset LR value   */
    stackFrame->pc = (uint32_t)taskConstState->taskEntryPtFnPtr;
    stackFrame->xpsr = 0x01000000UL;    /* Reset XPSR value */

    return;
}

/**
    @trace #BRCM_SWARCH_BASE_ARCH_RUN_SCHED_AT_EXIT_PROC
    @trace #BRCM_SWREQ_BASE_CORTEX_MX
*/
void BASE_ArchRunSchedAtExit(void)
{
    CORTEX_MX_PendSvSet();
}

/**
    @trace #BRCM_SWARCH_BASE_ARCH_START_OS_PROC
    @trace #BRCM_SWREQ_BASE_CORTEX_MX
*/
void BASE_ArchStartOS(void)
{
    /* Platform specific setup */
    BASE_ARMv7mPlatformInit();

    /* PendSV shall have the lowest priority possible */
    (void) CORTEX_MX_PendSVSetPrio(0xFFUL);

    /* Set CurTaskId to a dummy task, and trigger a context switch */
    BASE_CurTaskId = BASE_NUM_TASKS;
    CORTEX_MX_PendSvSet();

    return;
}

/**
    @trace #BRCM_SWARCH_BASE_ARCH_START_OS_PROC
    @trace #BRCM_SWREQ_BASE_CORTEX_MX
*/
void BASE_ExecHandover(const BCM_EntryPtType aEntry)
{

    COMP_ASM(
        "           MOV     r4, %0                           \n"
        "           BL      CORTEX_MX_INTRDisable            \n"
        /*  r0: thread Mode:  privileged
            r1: use MSP for thread mode
            r2: init stack for PSP      */
        "           MOV     r0, #0x0                         \n"
        "           MOV     r1, #0x0                         \n"
        "           MOV     r2, #0x0                         \n"
        "           BL      CORTEX_MX_SetThreadMode          \n"
        /*  Prepare dummy stack     */
        "           MOV     r0, #0x0                         \n"
        "           MOV     r1, #0x0                         \n"
        "           MOV     r2, r4                           \n"
        "           LDR     r3, =0x81000000                  \n"
        "           PUSH    {r0-r3}                          \n"
        "           PUSH    {r0-r3}                          \n"
        "           LDR     r0,=0xFFFFFFF9                   \n"
        "           BX      r0                               \n"
        ::"r"(aEntry));
}

/** @} */
