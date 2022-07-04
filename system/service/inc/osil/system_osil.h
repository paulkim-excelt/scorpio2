/*****************************************************************************
 Copyright 2018-2019 Broadcom Limited.  All rights reserved.

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

/** @defgroup grp_system_il System Integration Guide
    @ingroup grp_sys_service

    @addtogroup grp_system_il
    @{

    @file system_osil.h
    @brief Integration for System

    @version 0.1 Initial version
*/

#ifndef SYSTEM_OSIL_H
#define SYSTEM_OSIL_H

#include <module.h>
#include <system_module.h>

/**
    @name System Integration Interface IDs
    @{
    @brief Integration Interface IDs for System

*/
#define BRCM_SWARCH_SYS_FN_TABLE_GLOBAL             (0x9201U)    /**< @brief #SYS_FnTable             */
#define BRCM_SWARCH_SYS_CLEAR_NOTE_PROC             (0x9202U)    /**< @brief #SYS_ClearNotification   */
#define BRCM_SWARCH_SYS_GETTRAFFICCMDSTATUS_PROC    (0x9203U)    /**< @brief #SYS_GetTrafficCmdStatus */
#define BRCM_SWARCH_SYSTEM_NVM_MODULE_GLOBAL        (0x9204U)    /**< @brief #SYSTEM_NvmModule        */
#define BRCM_SWARCH_SYSTEM_ETHSRV_MODULE_GLOBAL     (0x9205U)    /**< @brief #SYSTEM_EthSrvModule     */
#define BRCM_SWARCH_SYS_SUBMODEVENT_GLOBAL          (0x9207U)    /**< @brief #SYS_SubModEvent         */
#define BRCM_SWARCH_SYSTEM_PLAT_MODULE_GLOBAL       (0x920CU)    /**< @brief #SYSTEM_PlatModule       */
#define BRCM_SWARCH_SYSTEM_SUBMODULE_LIST_GLOBAL    (0x920DU)    /**< @brief #SYSTEM_SubModList       */
#define BRCM_SWARCH_SYS_REBOOT_TIMER_EXP_GLOBAL     (0x920EU)    /**< @brief #SYS_RebootTimerExpired  */
#define BRCM_SWARCH_SYS_TRIGGER_REBOOT_GLOBAL       (0x920FU)    /**< @brief #SYS_TriggerReboot       */
#define BRCM_SWARCH_SYS_REBOOT_MODE_GLOBAL          (0x9210U)    /**< @brief #SYS_RebootMode          */
#define BRCM_SWARCH_SYSTEM_REBOOT_EVENT_GLOBAL      (0x9211U)    /**< @brief #SYSTEM_RebootEvent      */
#define BRCM_SWARCH_SYSTEM_ENABLE_REBOOT_ALARM_PROC (0x9212U)    /**< @brief #SYSTEM_RebootAlarmEnable*/
#define BRCM_SWARCH_SYSTEM_HEALTHALARMCB_PROC       (0x9213U)    /**< @brief #SYSTEM_HealthAlarmCb    */
#define BRCM_SWARCH_SYSTEM_SERVICE_ALARM_CB_PROC    (0x9214U)    /**< @brief #SYSTEM_ServiceAlarmCb   */

/** @} */

/**
    @brief Global table for system

    Function pointer table for system

    @trace #BRCM_SWREQ_SYS_INTERFACE
*/
extern const SYS_FnTblType SYS_FnTable;

/** @brief Get pending error notification and clear

    @behavior Sync, Non-reentrant

    @pre None

    @param None

    @retval None

    @post None

    @note None

    @trace  #BRCM_SWREQ_SYS_INTERFACE

    @limitations None

*/
void SYS_ClearNotification(void);

/** @brief Get status for traffic update request completion

    @behavior Sync, Non-reentrant

    @pre None

    @param void

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Command processed successfully
    @retval     #BCM_ERR_BUSY           Command still being processed
    @retval     #BCM_ERR_UNKNOWN        Error during command processing

    @post None

    @trace  #BRCM_SWREQ_SYS_INTERFACE

    @limitations None
*/
int32_t SYS_GetTrafficCmdStatus();


/** @brief Global to hold reboot counter status

    @trace #BRCM_SWREQ_SYS_INTERFACE
*/
extern uint32_t SYS_RebootTimerExpired;

/** @brief Global to hold reboot counter status

    @trace #BRCM_SWREQ_SYS_INTERFACE
*/
extern uint32_t SYS_TriggerReboot;

/** @brief Global to translate the OS event to U32 for SYS module
    operation

    @trace #BRCM_SWREQ_SYS_INTERFACE
*/
extern const uint32_t SYS_SubModEvent;

/** @brief Global to translate the OS event to U32 for Reboot event

    @trace #BRCM_SWREQ_SYSTEM_SERVICE
*/
extern const uint32_t SYSTEM_RebootEvent;

/**
    @brief Global stucture to store SYSTEM Platform module parameter.

    @trace #BRCM_SWREQ_SYSTEM_SERVICE
*/
extern const MODULE_Type SYSTEM_PlatModule;

/**
    @brief Global stucture to store SYSTEM sub module list.

    @trace #BRCM_SWREQ_SYSTEM_SERVICE
*/
extern const MODULE_Type* const SYSTEM_SubModList[MODULE_COUNT_MAX];

/** @brief API for notification alarm callback

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  void

    @retval       void

    @limitations None.

    @trace #BRCM_SWREQ_SYSTEM_SERVICE
*/
extern void SYSTEM_HealthAlarmCb(void);

/** @brief API for reboot alarm callback

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  void

    @retval       void

    @limitations None.

    @trace #BRCM_SWREQ_SYSTEM_SERVICE
*/
extern void SYSTEM_ServiceAlarmCb(void);

/** @brief API to activate reboot alarm

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  aDelayMs    Delay in milliseconds

    @retval       void

    @limitations None.

    @trace #BRCM_SWREQ_SYSTEM_SERVICE
*/
extern void SYSTEM_RebootAlarmEnable(uint32_t aDelayMs);

#endif /* IPC_SYSTEM_OSIL_H */
/** @} */
