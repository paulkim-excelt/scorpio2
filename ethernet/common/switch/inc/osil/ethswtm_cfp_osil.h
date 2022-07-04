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
    @defgroup grp_ethsrv_swtcfp_osil_ifc CFP Module OSIL Interface
    @ingroup grp_ethsrv_swt

    @addtogroup grp_ethsrv_swtcfp_osil_ifc
    @{

    @file ethswtm_cfp_osil.h

    @brief CFP module OSIL Interface

    @version 0.1 Initial version
*/

#ifndef ETHSWTM_CFP_OSIL_H
#define ETHSWTM_CFP_OSIL_H

#include <inttypes.h>
#include <module_osil.h>
/**
    @name CFP Module IDs for OSIL
    @{
    @brief Architecture API IDs for CFP module OSIL
*/
#define BRCM_SWARCH_ETHSWTM_CFPEVENT_TYPE                   (0x9101U)    /**< @brief #ETHSWTM_CFPEventType            */
#define BRCM_SWARCH_ETHSWTM_CFPEVENTINFO_GLOBAL             (0x9102U)    /**< @brief #ETHSWTM_CFPEventInfo            */
#define BRCM_SWARCH_ETHSWTM_CFPENABLEMONITORALARM_PROC      (0x9103U)    /**< @brief #ETHSWTM_CFPEnableMonitorAlarm   */
#define BRCM_SWARCH_ETHSWTM_CFPSTREAMMONITORALARMCB_PROC    (0x9104U)    /**< @brief #ETHSWTM_CFPStreamMonitorAlarmCb */
#define BRCM_SWARCH_ETHSWTM_CFPASYNCEVENT_PROC              (0x9105U)    /**< @brief #ETHSWTM_CFPAsyncEvent           */
#define BRCM_SWARCH_ETHSWTM_CFPGETSERVER_PROC               (0x9106U)    /**< @brief #ETHSWTM_CFPGetServer            */
/** @} */

/**
    @name CFP module event structure

    @trace #BRCM_SWREQ_ETHSWTM_CFP
*/
typedef struct sETHSWTM_CFPEventType {
    uint32_t streamMonitorEvent;     /**< @brief Event for monitoring Streams */
} ETHSWTM_CFPEventType;

/**
    @brief Event structure object of CFP module

    @trace #BRCM_SWREQ_ETHSWTM_CFP
*/
extern const ETHSWTM_CFPEventType ETHSWTM_CFPEventInfo;

/** @brief Enable Monitor Alarm

    This API enables/disables an alarm meant for stream monitoring

    @behavior Sync, Non-reentrant

    @pre none

    @param[in]   aEnable        TRUE: Enable, FALSE: Disable
    @param[in]   aIncrement     Alarm increment value
    @param[in]   aCycle         Alarm cycle value

    @return   None

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHSWTM_CFP
*/
extern void ETHSWTM_CFPEnableMonitorAlarm(uint32_t aEnable, uint32_t aIncrement, uint32_t aCycle);

/** @brief ETHSWTM_CFPStreamMonitorAlarm callback function

    Callback function for stream monitor alarm

    @param None

    @return None

    @trace #BRCM_SWREQ_ETHSWTM_CFP
*/
void ETHSWTM_CFPStreamMonitorAlarmCb(void);

/** @brief Async Event notification

    This API sends an async event notification to HOST

    @param[in]  aCmdID      Notification identifier
    @param[in]  aParams     Parameters(as a buffer) associated with the notification
    @param[in]  aSize       Size of the buffer containing notification parameters

    @retval     #BCM_ERR_OK           Event notification sent successfully
    @retval     #BCM_ERR_NOSUPPORT   No support for async notification to HOST

    @trace #BRCM_SWREQ_ETHSWTM_CFP
*/
extern int32_t ETHSWTM_CFPAsyncEvent(uint8_t aCmdID, const uint8_t *const aParams,
                                    uint32_t aSize);

/** @brief API to return the Task and event for the switch module

    @behavior Sync, Re-entrant

    @pre None

    @param[out]     aServerTask         Server task ID
    @param[out]     aServerEvent        Event mask

    Return values are documented in reverse-chronological order
    @retval       void

    @limitations None.

    @trace #BRCM_SWREQ_ETHSWTM_CFP
*/
extern void ETHSWTM_CFPGetServer(int32_t *aServerTask, uint32_t *aServerEvent);

#endif /* ETHSWTM_CFP_OSIL_H */
/** @} */
