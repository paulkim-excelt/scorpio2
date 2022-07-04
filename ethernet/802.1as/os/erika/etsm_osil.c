/*****************************************************************************
 Copyright 2017-2021 Broadcom Limited.  All rights reserved.

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
    @addtogroup grp_ets_il
    @{
    @file etsm_osil.c
    @brief ETS EthSrv module OS Integration Layer
    This source file contains the integration of ETS EthSrv module to system
    @version 0.1 Imported from Word Document
*/

/* Includes */
#include <stdint.h>
#include <ee.h>
#include "etsm.h"
#include "ets_osil_defs.h"
#include <osil/bcm_osil.h>

/**
    @name ETS Component Design IDs
    @{
    @brief Design IDs for ETS component

*/
#define BRCM_SWDSGN_ETSM_EVENTINFO_GLOBAL     (0xE101U)    /**< @brief #ETSM_EventInfo    */
#define BRCM_SWDSGN_ETSM_TIMERALARMCB_PROC    (0xE102U)    /**< @brief #ETSM_TimerAlarmCb */
#define BRCM_SWDSGN_ETSM_STARTTIMER_PROC      (0xE103U)    /**< @brief #ETSM_StartTimer   */
#define BRCM_SWDSGN_ETSM_STOPTIMER_PROC       (0xE104U)    /**< @brief #ETSM_StopTimer    */
#define BRCM_SWDSGN_ETSM_GETSERVER_PROC       (0xE105U)    /**< @brief #ETSM_GetServer    */
/** @} */


/**
    @trace #BRCM_SWARCH_ETSM_EVENTINFO_GLOBAL
    @trace #BRCM_SWREQ_ETSM
*/
const ETSM_EventType ETSM_EventInfo = {
    .packetEvent    = ETHER_PKT_EVENT,
    .timestampEvent = ETHER_TIMESTAMP_EVENT,
    .timerEvent     = ETS_TIMER_EVENT,
};

/**
    @code{.unparsed}
    BCM_SetRelAlarm(ETSM_TimerAlarm)
    @endcode

    @trace #BRCM_SWREQ_ETSM
    @trace #BRCM_SWARCH_ETSM_STARTTIMER_PROC
*/
void ETSM_StartTimer(void)
{
    (void)BCM_SetRelAlarm(ETSM_TimerAlarm, 1L, 5L);
}

/**
    @code{.unparsed}
    BCM_CancelAlarm(ETSM_TimerAlarm)
    @endcode

    @trace #BRCM_SWREQ_ETSM
    @trace #BRCM_SWARCH_ETSM_STOPTIMER_PROC
*/
void ETSM_StopTimer(void)
{
    (void)BCM_CancelAlarm(ETSM_TimerAlarm);
}

/**
    @code{.unparsed}
    SetEvent(ETSM_TASK, SystemEvent15);
    @endcode
    @trace #BRCM_SWARCH_ETSM_MODULE_GLOBAL
    @trace #BRCM_SWREQ_ETSM
*/
void ETSM_TimerAlarmCb(void)
{
    (void)SetEvent(ETSM_TASK, ETSM_EventInfo.timerEvent);
}

/**
    @code{.unparsed}
    @endcode

    @trace #BRCM_SWARCH_ETSM_MODULE_GLOBAL
    @trace #BRCM_SWREQ_ETSM
*/
void ETSM_GetServer(int32_t *aServerTask, uint32_t *aServerEvent)
{
    if (NULL != aServerTask) {
        *aServerTask = ETSM_TASK;
    }
    if (NULL != aServerEvent) {
        *aServerEvent = MODULE_Event;
    }
}

/** @} */
