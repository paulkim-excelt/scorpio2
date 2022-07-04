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
    @defgroup grp_ethsrv_swtcfp_osil_impl CFP Module OSIL Implementation
    @ingroup grp_ethsrv_swt

    @addtogroup grp_ethsrv_swtcfp_osil_impl
    @{

    @file ethswtm_cfp_osil.c

    @brief CFP module OSIL Implementation

    @version 0.1 Initial version
*/

#include <ee.h>
#include <bcm_osil.h>
#include <ethswtm_cfp_osil.h>

/**
    @name CFP Module Design IDs for OSIL implementation
    @{
    @brief Design IDs for CFP module OSIL implementation
*/
#define BRCM_SWDSGN_ETHSWTM_CFPEVENTINFO_GLOBAL             (0xB101U)    /**< @brief #ETHSWTM_CFPEventInfo            */
#define BRCM_SWDSGN_ETHSWTM_CFPENABLEMONITORALARM_PROC      (0xB102U)    /**< @brief #ETHSWTM_CFPEnableMonitorAlarm   */
#define BRCM_SWDSGN_ETHSWTM_CFPSTREAMMONITORALARMCB_PROC    (0xB103U)    /**< @brief #ETHSWTM_CFPStreamMonitorAlarmCb */
#define BRCM_SWDSGN_ETHSWTM_CFPGETSERVER_PROC               (0xB104U)    /**< @brief #ETHSWTM_CFPGetServer            */
/** @} */

/**
    @brief Event information

    Event configuration for integration

    @trace #BRCM_SWARCH_ETHSWTM_CFPEVENTINFO_GLOBAL
    @trace #BRCM_SWREQ_ETHSWTM_CFP
*/
const ETHSWTM_CFPEventType ETHSWTM_CFPEventInfo = {
    .streamMonitorEvent = ETHSWTM_CFP_STREAMMONITOR_EVENT,
};

/**
    @code{.unparsed}
    if (FALSE == aEnable)
        BCM_CancelAlarm(ETHSWTM_CFPStreamMonitorAlarm)
    else
        BCM_SetRelAlarm(ETHSWTM_CFPStreamMonitorAlarm, aIncrement, aCycle)
    @endcode

    @trace #BRCM_SWARCH_ETHSWTM_CFPENABLEMONITORALARM_PROC
    @trace #BRCM_SWREQ_ETHSWTM_CFP
*/
void ETHSWTM_CFPEnableMonitorAlarm(uint32_t aEnable, uint32_t aIncrement, uint32_t aCycle)
{
    if (FALSE == aEnable) {
        BCM_CancelAlarm(ETHSWTM_CFPStreamMonitorAlarm);
    } else {
        BCM_SetRelAlarm(ETHSWTM_CFPStreamMonitorAlarm, aIncrement, aCycle);
    }
}

/**
    @code{.unparsed}
    SetEvent(ETHSWTM_TASK, ETHSWTM_CFPEventInfo.streamMonitorEvent)
    @endcode

    @trace #BRCM_SWARCH_ETHSWTM_CFPSTREAMMONITORALARMCB_PROC
    @trace #BRCM_SWREQ_ETHSWTM_CFP
*/
void ETHSWTM_CFPStreamMonitorAlarmCb(void)
{
    (void)SetEvent(ETHSWTM_TASK, ETHSWTM_CFPEventInfo.streamMonitorEvent);
}

/**
    @code{.unparsed}
    @endcode

    @trace #BRCM_SWARCH_ETHSWTM_CFPGETSERVER_PROC
    @trace #BRCM_SWREQ_ETHSWTM_CFP
*/
void ETHSWTM_CFPGetServer(int32_t *aServerTask, uint32_t *aServerEvent)
{
    if (NULL != aServerTask) {
        *aServerTask = ETHERNET_Task;
    }
    if (NULL != aServerEvent) {
        *aServerEvent = MODULE_Event;
    }
}

/** @} */
