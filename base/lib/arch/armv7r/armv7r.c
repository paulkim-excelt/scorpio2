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

/**
    @addtogroup grp_base_impl
    @{
    ARMv7R specific BASE kernel routines

    @file armv7r.c
    @brief ARMv7R specific BASE kernel routines
    @version 0.1 Initial Version
*/

#include <svc.h>
#include <stdint.h>
#include "armv7r_kernel.h"

/**
    @name BASE kernel ARMv7R design IDs
    @{
    @brief Design IDs for the BASE kernel ARMv7R port
*/
#define BRCM_SWDSGN_BASE_ARMV7R_TASK_INIT_STACK_FRAME_TYPE    (0xB201U)    /**< @brief #BASE_ARMv7rTaskInitStackFrameType */
#define BRCM_SWDSGN_BASE_ISR2_PRESTUB_PROC                    (0xB202U)    /**< @brief #BASE_ISR2_prestub                 */
#define BRCM_SWDSGN_BASE_ISR2_POSTSTUB_PROC                   (0xB203U)    /**< @brief #BASE_ISR2_poststub                */
#define BRCM_SWDSGN_BASE_ARCH_RESET_TASK_STATE_PROC           (0xB204U)    /**< @brief #BASE_ArchResetTaskState           */
#define BRCM_SWDSGN_BASE_ARCH_RUN_SCHED_AT_EXIT_PROC          (0xB205U)    /**< @brief #BASE_ArchRunSchedAtExit           */
#define BRCM_SWDSGN_BASE_ARCH_START_OS_PROC                   (0xB206U)    /**< @brief #BASE_ArchStartOS                  */
#define BRCM_SWDSGN_BASE_EXEC_HANDOVER_PROC                   (0xB207U)    /**< @brief #BASE_ExecHandover                 */
/** @} */

/**
    @brief ARMv7R stack frame to be setup by the kernel during the task activation

    @trace #BRCM_SWARCH_BASE_ARCH_RESET_TASK_STATE_PROC
    @trace #BRCM_SWREQ_BASE_CORTEX_RX
*/
typedef struct COMP_PACKED sBASE_ARMv7rTaskInitStackFrameType {
    uint32_t regs1[8UL];    /**< @brief r4-r11       */
    uint32_t regs2[5UL];    /**< @brief r0-r3, r12   */
    uint32_t lr;            /**< @brief lr           */
    uint32_t pc;            /**< @brief pc           */
    uint32_t spsr;          /**< @brief spsr         */
} BASE_ARMv7rTaskInitStackFrameType;

/**
    @trace #BRCM_SWARCH_BASE_ISR2_PRESTUB_PROC
    @trace #BRCM_SWREQ_BASE_CORTEX_RX
*/
uint32_t BASE_ISR2_prestub(void)
{
    return 0;
}

/**
    @trace #BRCM_SWARCH_BASE_ISR2_POSTSTUB_PROC
    @trace #BRCM_SWREQ_BASE_CORTEX_RX
*/
void BASE_ISR2_poststub(const uint32_t flag)
{
    return;
}

/**
    @trace #BRCM_SWARCH_BASE_ARCH_RUN_SCHED_AT_EXIT_PROC
    @trace #BRCM_SWREQ_BASE_CORTEX_RX
*/
void BASE_ArchRunSchedAtExit(void)
{
    BASE_ARMv7rRunSchedOnExit = 1UL;
    return;
}

/**
    @trace #BRCM_SWARCH_BASE_ARCH_START_OS_PROC
    @trace #BRCM_SWREQ_BASE_CORTEX_RX
*/
void BASE_ArchStartOS(void)
{
    BASE_ARMv7rPlatformInit();

    /* Set CurTaskId to a dummy task, and setup a context switch */
    BASE_CurTaskId = BASE_NUM_TASKS;
    BASE_ARMv7rRunSchedOnExit = 1UL;

    return;
}

/**
    @trace #BRCM_SWARCH_BASE_ARCH_RESET_TASK_STATE_PROC
    @trace #BRCM_SWREQ_BASE_CORTEX_RX
*/
void BASE_ArchResetTaskState(const uint32_t aTaskIdx)
{
    uint32_t i;

    BASE_TaskStateType *const taskState = &BASE_TaskStates[aTaskIdx];
    const BASE_TaskConstStateType *const taskConstState = &BASE_TaskConstStates[aTaskIdx];

    /* Carve out a stack frame */
    BASE_ARMv7rTaskInitStackFrameType *const stackFrame =
        (BASE_ARMv7rTaskInitStackFrameType*)(
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

    /* lr and pc */
    stackFrame->lr = 0xFFFFFFFFUL;      /* Reset LR value   */
    stackFrame->pc = (uint32_t)taskConstState->taskEntryPtFnPtr;

    /* spsr: Thumb, little endian, enable IRQ's, User mode */
    stackFrame->spsr = 0x00000070;

    return;
}

/**
    @trace #BRCM_SWARCH_BASE_EXEC_HANDOVER_PROC
    @trace #BRCM_SWREQ_BASE_CORTEX_RX
*/
void BASE_ExecHandover(const BCM_EntryPtType aEntry)
{
    aEntry();
}
/** @} */
