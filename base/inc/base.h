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
    @defgroup grp_base_ifc BASE interface
    @ingroup grp_base

    @addtogroup grp_base_ifc
    @{
    This header makes available the macros and the function prototypes
    that the apps and the drivers will need to work against BASE.

    @file base.h
    @brief BASE Interface File
    @version 0.1 Initial Version
*/
#ifndef BASE_H
#define BASE_H

#include <stddef.h>
#include <stdint.h>
#include <compiler.h>
#include <osil/bcm_osil.h>
#include <base_app_cfg.h>

/**
    @name BASE Architecture IDs
    @{
    @brief Architecture IDs for BASE
*/
#define BRCM_SWARCH_BASE_ISR2_PRESTUB_PROC          (0x8401U)    /**< @brief #BASE_ISR2_prestub      */
#define BRCM_SWARCH_BASE_ISR2_POSTSTUB_PROC         (0x8402U)    /**< @brief #BASE_ISR2_poststub     */
#define BRCM_SWARCH_BASE_TASK_PRESTUB_PROC          (0x8403U)    /**< @brief #BASE_TASK_prestub      */
#define BRCM_SWARCH_BASE_TASK_POSTSTUB_PROC         (0x8404U)    /**< @brief #BASE_TASK_poststub     */
#define BRCM_SWARCH_BASE_NUM_PROFILE_TASKS_MACRO    (0x8405U)    /**< @brief #BASE_NUM_PROFILE_TASKS */
#define BRCM_SWARCH_BASE_PROFILE_DATA_GLOBAL        (0x8406U)    /**< @brief #BASE_ProfileData       */
/** @} */

/**
    @brief ISR pre-stub

    BASE expectes a call to this routine at the entry of every
    ISR implemented by the peripheral drivers

    @behavior Sync, Non-reentrant

    @pre CPU is at the ISR entry point

    @return A flag that is to be treated as an opaque value, and
        should be passed in to the @ref BASE_ISR2_poststub routine

    @post Interrupts are disabled and other book-keeping is performed

    @trace #BRCM_SWREQ_BASE
*/
uint32_t BASE_ISR2_prestub(void);

/**
    @brief ISR post-stub

    BASE expectes a call to this routine at the exit of every
    ISR implemented by the peripheral drivers

    @behavior Sync, Non-reentrant

    @pre CPU is at the ISR exit point

    @param[in]      aFlag                   The flag returned by the
                                            @ref BASE_ISR2_prestub call

    @return void

    @post Interrupts are re-enabled and other book-keeping is performed

    @trace #BRCM_SWREQ_BASE
*/
void BASE_ISR2_poststub(const uint32_t aFlag);

/**
    @brief TASK pre-stub

    BASE expectes a call to this routine at the entry point of every
    task in the system

    @behavior Sync, Non-reentrant

    @pre CPU is at the task entry point

    @return void

    @post None

    @trace #BRCM_SWREQ_BASE
*/
void BASE_TASK_prestub(void);

/**
    @brief TASK post-stub

    BASE expectes a call to this routine at the exit point of every
    task in the system

    @behavior Sync, Non-reentrant

    @pre CPU is at the task exit point

    @return void

    @post Signals BASE that the task has finished executing

    @trace #BRCM_SWREQ_BASE
*/
void BASE_TASK_poststub(void);

/**
    @brief Maximum number of profiled tasks

    @trace #BRCM_SWREQ_BASE
*/
#define BASE_NUM_PROFILE_TASKS      (64UL)

/**
    @brief Profiling information

    @trace #BRCM_SWREQ_BASE
*/
extern volatile uint64_t BASE_ProfileData[BASE_NUM_PROFILE_TASKS];

#endif /* BASE_H */
/** @} */
