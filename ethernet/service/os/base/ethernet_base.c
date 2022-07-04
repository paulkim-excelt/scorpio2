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
    @defgroup grp_ethernet_base_il Ethernet Task Integration
    @ingroup grp_ethsrv_sw

    @addtogroup grp_ethernet_base_il
    @{

    @file ethernet_base.c

    @brief Ethernet Task integration
    This file contains the integration details of Ethernet Task

    @version 0.1 Initial version
*/
#include <stdlib.h>
#include <string.h>
#include <bcm_utils.h>
#include <osil/bcm_osil.h>

#include "ee.h"
#include "ee_internal.h"

#include <osil/ethernet_osil.h>

#include <module.h>
#include <module_osil.h>
#include <module_helper.h>

/**
    @name Ethernet Design IDs
    @{
    @brief Ethernet Design IDs
*/
#define BRCM_SWDSGN_ETHERNET_TASK_PROC              (0xD100U)    /**< @brief #ETHERNET_Task     */
#define BRCM_SWDSGN_ETHERNET_GET_SERVER_PROC        (0xD101U)    /**< @brief #ETHERNET_GetServer*/
/** @} */

/**
    @code{.unparsed}
    @endcode

    @trace #BRCM_SWARCH_ETHERNET_SERVICE_GLOBAL
    @trace #BRCM_SWREQ_ETHERNET_TASK
*/
TASK(ETHERNET_Task)
{
    SERVICE_ServerTaskFunc(&ETHERNET_Service, ETHERNET_Task);
    (void)BCM_TerminateTask();
}

/**
    @code{.unparsed}
    @endcode

    @trace #BRCM_SWARCH_ETHERNET_GET_SERVER_PROC
    @trace #BRCM_SWREQ_ETHERNET_TASK
*/
void ETHERNET_GetServer(int32_t *aServerTask, uint32_t *aServerEvent)
{
    if (NULL != aServerTask) {
        *aServerTask = ETHERNET_Task;
    }
    if (NULL != aServerEvent) {
        *aServerEvent = MODULE_Event;
    }
}

/** @} */
