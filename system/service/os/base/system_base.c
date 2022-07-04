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
    @defgroup grp_sys_mod_task_il System Task Integration
    @ingroup grp_sys_service

    @addtogroup grp_sys_mod_task_il
    @{

    @file system_base.c

    @brief System Task integration
    This file contains the integration details of System Task

    @version 0.1 Initial version
*/
#include <stdlib.h>
#include <string.h>
#include <bcm_utils.h>
#include <osil/bcm_osil.h>

#include "ee.h"
#include "ee_internal.h"

#include <osil/system_osil.h>
#include <system_module_v2.h>
#include <system_service_osil.h>

#include <module.h>
#include <module_osil.h>
#include <module_helper.h>
#include <mcu.h>

/**
    @name System Design IDs
    @{
    @brief System Design IDs
*/
#define BRCM_SWDSGN_SYSTEM_TASK_PROC                (0xD100U)    /**< @brief #SYSTEM_Task               */
#define BRCM_SWDSGN_SYSTEM_GET_SERVER_PROC          (0xD101U)    /**< @brief #SYSTEM_GetServer          */
#define BRCM_SWDSGN_SYSTEM_SERVICE_ALARM_CB_PROC    (0xD102U)    /**< @brief #SYSTEM_ServiceAlarmCb     */
/** @} */


/**
    @code{.unparsed}
    @endcode

    @trace #BRCM_SWARCH_SYSTEM_MODULE_GLOBAL
    @trace #BRCM_SWREQ_SYSTEM_SERVICE
*/
TASK(SYSTEM_Task)
{
    int32_t retVal;
    BCM_StateType state = BCM_STATE_INIT;
    retVal = MSGQ_SendMsgv2(&SYSTEM_Service.client.cmdQ, (const uint8_t*)&state, MODULE_Event, NULL);
    if (BCM_ERR_OK == retVal) {
        SERVICE_ServerTaskFunc(&SYSTEM_Service, SYSTEM_Task);
    }

    (void)BCM_TerminateTask();
}

/**
    @code{.unparsed}
    @endcode

    @trace #BRCM_SWARCH_SYSTEM_GET_SERVER_PROC
    @trace #BRCM_SWREQ_SYSTEM_SERVICE
*/
void SYSTEM_GetServer(int32_t *aServerTask, uint32_t *aServerEvent)
{
    if (NULL != aServerTask) {
        *aServerTask = SYSTEM_Task;
    }
    if (NULL != aServerEvent) {
        *aServerEvent = MODULE_Event;
    }
}

/** @brief Reboot alarm callback.

    @trace #BRCM_SWARCH_SYSTEM_SERVICE_ALARM_CB_PROC
    @trace #BRCM_SWREQ_SYSTEM_SERVICE
*/
void SYSTEM_ServiceAlarmCb(void)
{
    (void)SetEvent(SYSTEM_Task, MODULE_Event);
}
/** @} */
