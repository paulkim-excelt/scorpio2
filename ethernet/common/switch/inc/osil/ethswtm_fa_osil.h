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
    @defgroup grp_ethsrv_fa_osil_ifc FA Module OSIL Interface
    @ingroup grp_ethsrv_swt

    @addtogroup grp_ethsrv_fa_osil_ifc
    @{

    @file ethswtm_fa_osil.h

    @brief FA module OSIL Interface

    @version 0.1 Initial version
*/

#ifndef ETHSWTM_FA_OSIL_H
#define ETHSWTM_FA_OSIL_H

#include <module_osil.h>

/**
    @name FA Module IDs for OSIL
    @{
    @brief Architecture API IDs for FA module OSIL
*/
#define BRCM_SWARCH_ETHSWTM_FAEVENT_TYPE          (0x9301U)    /**< @brief #ETHSWTM_FAEventType */
#define BRCM_SWARCH_ETHSWTM_FAEVENTINFO_GLOBAL    (0x9302U)    /**< @brief #ETHSWTM_FAEventInfo */
#define BRCM_SWARCH_ETHSWTM_FAONESECALARMCB_PROC  (0x9303U)    /**< @brief #ETHSWTM_FAOneSecAlarmCb */
#define BRCM_SWARCH_ETHSWTM_FAASYNCEVENT_PROC     (0x9304U)    /**< @brief #ETHSWTM_FAAsyncEvent */
#define BRCM_SWARCH_ETHSWTM_FAONESECTIMER_GLOBAL  (0x9305U)    /**< @brief #ETHSWTM_FAOneSecTimer */
#define BRCM_SWARCH_ETHSWTM_FAENABLEALARM_PROC    (0x9306U)    /**< @brief #ETHSWTM_FAEnableAlarm */
#define BRCM_SWARCH_ETHSWTM_FAGETSERVER_PROC      (0x9307U)    /**< @brief #ETHSWTM_FAGetServer   */
/** @} */

/**
    @name FA module event structure

    @trace #BRCM_SWREQ_ETHSWTM_FA
*/
typedef struct sETHSWTM_FAEventType {
    uint32_t irqEvent;             /**< @brief Event for Interrupt Request */
} ETHSWTM_FAEventType;


/**
    @brief One Second Timer

    One second timer count value

    @trace #BRCM_SWREQ_ETHSWTM_FA
*/
extern uint32_t ETHSWTM_FAOneSecTimer;

/**
    @brief Event structure object of FA module

    @trace #BRCM_SWREQ_ETHSWTM_FA
*/
extern const ETHSWTM_FAEventType ETHSWTM_FAEventInfo;

/** @brief ETHSWTM_FAOneSecAlarm callback function

    Callback function for one second alarm

    @param None

    @return None

    @trace #BRCM_SWREQ_ETHSWTM_FA
*/
void ETHSWTM_FAOneSecAlarmCb(void);

/** @brief Async Event notification

    This API sends an async event notification to HOST

    @param[in]  aCmdID      Notification identifier
    @param[in]  aParams     Parameters(as a buffer) associated with the notification
    @param[in]  aSize       Size of the buffer containing notification parameters

    @retval     #BCM_ERR_OK           Event notification sent successfully
    @retval     #BCM_ERR_NOSUPPORT   No support for async notification to HOST

    @trace #BRCM_SWREQ_ETHSWTM_FA
*/
extern int32_t ETHSWTM_FAAsyncEvent(uint8_t aCmdID, const uint8_t *const aParams,
                                    uint32_t aSize);

/** @brief Enable Alarm

    This API enables/disables One Second Alarm

    @behavior Sync, Non-reentrant

    @pre none

    @param[in]   aEnable        TRUE: Enable, FALSE: Disable

    @return   None

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHSWTM_FA
*/
extern void ETHSWTM_FAEnableAlarm(uint32_t aEnable);

/** @brief API to return the Task and event for the switch module

    @behavior Sync, Re-entrant

    @pre None

    @param[out]     aServerTask         Server task ID
    @param[out]     aServerEvent        Event mask

    Return values are documented in reverse-chronological order
    @retval       void

    @limitations None.

    @trace #BRCM_SWREQ_ETHSWTM_FA
*/
extern void ETHSWTM_FAGetServer(int32_t *aServerTask, uint32_t *aServerEvent);

#endif /* ETHSWTM_FA_OSIL_H */
/** @} */
