/*****************************************************************************
 Copyright 2022 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_iosrv_base_il Task
    @ingroup grp_iosrv

    @addtogroup grp_iosrv_base_il Task
    @{

    @file io_service_base.c
    @brief IO Service Integration to BASE
    This source file contains the integration of IO Service into BASE
    @version 0.1 Initial Version
*/

#include "ee.h"
#include <module_helper.h>
#include <io_service.h>
#include <io_service_osil.h>

/**
    @name Design IDs
    @{
    @brief Design IDs for IO service
*/
#define BRCM_SWDSGN_IOS_SERVICE_TASK_PROC           (0xD101U)    /**< @brief #IOS_SERVICE_Task      */
#define BRCM_SWDSGN_IOS_SERVICE_GET_SERVER_PROC     (0xD102U)    /**< @brief #IOS_SERVICE_GetServer */
/** @} */

/** @brief IO Server function

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      void

    @return void

    @post None

    @trace #BRCM_SWARCH_IOS_SERVICE_GLOBAL
    @trace #BRCM_SWREQ_IOS_SERVICE

    @limitations None

    @code{.unparsed}
    SERVICE_ServerTaskFunc(&IOS_SERVICE, IOS_SERVICE_Task)
    (void)BCM_TerminateTask()
    @endcode

*/
TASK(IOS_SERVICE_Task)
{
    SERVICE_ServerTaskFunc(&IOS_SERVICE, IOS_SERVICE_Task);
    (void)BCM_TerminateTask();
}

/**
    @code{.unparsed}
    if (NULL != aServerTask)
        *aServerTask = IOS_SERVICE_Task
    if (NULL != aServerEvent)
        *aServerEvent = MODULE_Event
    @endcode

    @trace #BRCM_SWARCH_IOS_SERVICE_GET_SERVER_PROC
    @trace #BRCM_SWREQ_IOS_SERVICE
*/
void IOS_SERVICE_GetServer(int32_t *aServerTask, uint32_t *aServerEvent)
{
    if (NULL != aServerTask)
    {
        *aServerTask = IOS_SERVICE_Task;
    }
    if (NULL != aServerEvent)
    {
        *aServerEvent = MODULE_Event;
    }
}

/** @} */