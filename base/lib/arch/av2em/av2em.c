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
    @addtogroup grp_base_impl
    @{
    ARCv2EM specific BASE kernel routines

    @file av2em_secure.c
    @brief ARCv2EM specific BASE kernel routines
    @version 0.1 Initial Version
*/

#include <string.h>

#include <svc.h>
#include <bcm_utils.h>
#include <osil/bcm_osil.h>
#include <osil/bcm_osil_svc.h>
#include <arc_interrupts.h>
#include "../../kernel.h"

/**
    @name BASE kernel ARCv2EM design IDs
    @{
    @brief Design IDs for the BASE kernel ARCv2EM port
*/
#define BRCM_SWDSGN_BASE_AV2EM_TASK_INIT_STACK_FRAME_TYPE   (0xB301U)   /**< @brief #BASE_AV2EmTaskInitStackFrameType   */
#define BRCM_SWDSGN_BASE_ISR2_PRESTUB_PROC                  (0xB302U)   /**< @brief #BASE_ISR2_prestub                 */
#define BRCM_SWDSGN_BASE_ISR2_POSTSTUB_PROC                 (0xB303U)   /**< @brief #BASE_ISR2_poststub                */
#define BRCM_SWDSGN_BASE_ARCH_RUN_SCHED_AT_EXIT_PROC        (0xB304U)   /**< @brief #BASE_ArchRunSchedAtExit            */
#define BRCM_SWDSGN_BASE_ARCH_START_OS_PROC                 (0xB305U)   /**< @brief #BASE_ArchStartOS                  */
#define BRCM_SWDSGN_BASE_ARCH_RESET_TASK_STATE_PROC         (0xB306U)   /**< @brief #BASE_ArchResetTaskState           */
#define BRCM_SWDSGN_BASE_EXEC_HANDOVER_PROC                 (0xB307U)   /**< @brief #BASE_ExecHandover                 */
/** @} */

/**
    @brief ARCv2EM stack frame to be setup by the kernel during the task activation

    @trace #BRCM_SWARCH_BASE_ARCH_RESET_TASK_STATE_PROC
    @trace #BRCM_SWREQ_BASE_AV2EM
 */
typedef struct sBASE_AV2EmTaskInitStackFrameType {
    uint32_t status32;      /**< @brief Status32                            */
    uint32_t lpCount;       /**< @brief Zero overhead loop count            */
    uint32_t lpEnd;         /**< @brief Zero overhead loop end address      */
    uint32_t lpStart;       /**< @brief Zero overhead loop start address    */
    uint32_t pc;            /**< @brief Program counter                     */
    uint32_t blink;         /**< @brief Branch link register                */
    uint32_t regs[29UL];    /**< @brief General purpose registers           */
} BASE_AV2EmTaskInitStackFrameType;

/**
    @trace #BRCM_SWARCH_BASE_ISR2_PRESTUB_PROC
    @trace #BRCM_SWREQ_BASE_AV2EM
*/
uint32_t BASE_ISR2_prestub(void)
{
    return 0;
}

/**
    @trace #BRCM_SWARCH_BASE_ISR2_POSTSTUB_PROC
    @trace #BRCM_SWREQ_BASE_AV2EM
*/
void BASE_ISR2_poststub(const uint32_t flag)
{
    return;
}

/**
    @code{.unparsed}
        CALL ARC_TriggerInterrupt with context switch IRQ number
            to set a pending context switch
    @endcode

    @trace #BRCM_SWARCH_BASE_ARCH_RUN_SCHED_AT_EXIT_PROC
    @trace #BRCM_SWREQ_BASE_AV2EM
*/
void BASE_ArchRunSchedAtExit(void)
{
    const int32_t ret = ARC_TriggerInterrupt(BASE_AV2EM_CONTEXT_SWITCH_INTERRUPT_NUM);
    BASE_KERNEL_ASSERT(BCM_ERR_OK == ret);
    return;
}

/**
    @code{.unparsed}
        CALL BASE_AV2EMPlatformInit
        Enable interrupts in user-mode
        INITIALIZE BASE_CurTaskId to point to the init task
        CALL BASE_ArchRunSchedAtExit to trigger a context switch at exception exit
    @endcode

    @trace #BRCM_SWARCH_BASE_ARCH_START_OS_PROC
    @trace #BRCM_SWREQ_BASE_AV2EM
*/
void BASE_ArchStartOS(void)
{
    /* Platform specific setup */
    BASE_AV2EMPlatformInit();

    /* Enable interrupts on the init task */
    const uint32_t erStatus = ARC_ReadAux(ARC_ERSTATUS_ADDR);
    ARC_WriteAux(ARC_ERSTATUS_ADDR, erStatus | ARC_STATUS32_IE_BIT);

    /* Set CurTaskId to a dummy task, and trigger a context switch */
    BASE_CurTaskId = BASE_NUM_TASKS;
    BASE_ArchRunSchedAtExit();

    return;
}

/**
    @code{.unparsed}
        stackStart, stackSize = LOOKUP STACK_START, STACK_SIZE for aTaskIdx
        stackFrameAddr = stackStart + (stackSize - stackFrameSize)
        POPULATE stackFrame pointed by stackFrameAddr
        return
    @endcode

    @trace #BRCM_SWARCH_BASE_ARCH_RESET_TASK_STATE_PROC
    @trace #BRCM_SWREQ_BASE_AV2EM
*/
void BASE_ArchResetTaskState(const uint32_t aTaskIdx)
{
    BASE_KERNEL_ASSERT(aTaskIdx < BASE_NUM_TASKS);

    BASE_TaskStateType *const taskState = &BASE_TaskStates[aTaskIdx];
    const BASE_TaskConstStateType *const taskConstState = &BASE_TaskConstStates[aTaskIdx];

    /* Carve out a stack frame */
    BASE_AV2EmTaskInitStackFrameType *const stackFrame =
        (BASE_AV2EmTaskInitStackFrameType*)(
            taskConstState->taskInfo->base + taskConstState->taskInfo->size
        ) - 1UL;

    /* Initialize the stack top pointer for the task */
    taskState->sp = (void*)stackFrame;

    /* Initialize the restore context */
    stackFrame->lpStart = 0xA0A0A0A0UL;
    stackFrame->lpEnd   = 0xB0B0B0B0UL;
    stackFrame->lpCount = 0xFFFFUL;
    stackFrame->status32 =
        ARC_STATUS32_U_BIT  |     /* Usermode                     */
        ARC_STATUS32_IE_BIT |     /* Interrupts enable            */
        ARC_STATUS32_US_BIT |     /* Usermode sleep enable        */
        ARC_STATUS32_SC_BIT |     /* Enable HW stack checking     */
        ARC_STATUS32_DZ_BIT |     /* DivZero exception enable     */
        ARC_STATUS32_L_BIT  |     /* Zero overhead loop disable   */
        ((0UL << ARC_STATUS32_BANK_SHIFT) & ARC_STATUS32_BANK_MASK) /* Register bank 0      */
        ;

    stackFrame->pc = (uint32_t) taskConstState->taskEntryPtFnPtr;
    stackFrame->blink = 0xFFFFFFFFUL;

    BCM_MemSet(stackFrame->regs, 0x00, sizeof(stackFrame->regs));

    return;
}

/**
    @code{.unparsed}
        CALL aEntryPt
    @endcode

    @trace #BRCM_SWARCH_BASE_ARCH_START_OS_PROC
    @trace #BRCM_SWREQ_BASE_AV2EM
*/
void BASE_ExecHandover(const BCM_EntryPtType aEntryPt)
{
    /*
        Nothing special needs to be done here. Just pass the
        control along...
    */
    aEntryPt();
    return;
}

/** @} */
