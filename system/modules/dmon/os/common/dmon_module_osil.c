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
    @addtogroup grp_dmn_mod_il
    @{

    @file dmn_module_osil.c
    @brief This file implements integration layer for DMON  module.

    @version 0.1 Initial draft
    */

#include <bcm_err.h>
#include <bcm_utils.h>
#include <module.h>
#include <osil/module_osil.h>
#include <module_helper.h>
#include <bcm_comp.h>
#include <bcm_utils.h>
#include <dmon_module_osil.h>
#include <system_module_v2.h>
#include <system_service_osil.h>
#include <ee.h>

/**
  @name DMON Module Design IDs
  @{
  @brief Design IDs for DMON Module
  */
#define BRCM_SWDSGN_DMON_VTMON_CFG_GLOBAL           (0xA400U)   /**< @brief #DMON_VtmonCfg                */
#define BRCM_SWDSGN_DMON_GET_SERVERINFO_PROC        (0xA401U)   /**< @brief #DMON_GetServerInfo           */
#define BRCM_SWDSGN_DMON_ALARMCB_PROC               (0xA402U)   /**< @brief #DMON_AlarmCb                 */
#define BRCM_SWDSGN_DMON_TEMP_NOTF_PROC             (0xA403U)   /**< @brief #DMON_VtmonTempNotification   */
#define BRCM_SWDSGN_DMON_VOLT_NOTF_PROC             (0xA404U)   /**< @brief #DMON_VtmonVoltNotification   */
#define BRCM_SWDSGN_DMON_HEARTBEAT_INTERVAL_GLOBAL  (0xA405U)   /**< @brief #DMON_HeartBeatInterval       */

/** @} */

/**
    @trace #BRCM_SWARCH_DMON_HB_INT_GLOBAL
    @trace #BRCM_SWREQ_DMON_MODULE
*/
const uint32_t DMON_HeartBeatInterval = DMON_HEART_BEAT_INTERVAL_MS;

#if defined(ENABLE_VTMON)
/**
    @trace #BRCM_SWARCH_DMON_VTMON_CFG_GLOBAL
    @trace #BRCM_SWREQ_DMON_MODULE
*/
const VTMON_ConfigType DMON_VtmonCfg = {
    .tempConfig = {
        .threshLow = -30,
        .threshHigh = 115,
    },
    .voltConfig = {
        {
            .ID = VTMON_VOLT_ID_1V0,
            .threshLow = 900,
            .threshHigh = 1100
        },
        {
            .ID = VTMON_VOLT_ID_1V8,
            .threshLow = 1700,
            .threshHigh = 1900
        },
        {
            .ID = VTMON_VOLT_ID_3V3,
            .threshLow = 3200,
            .threshHigh = 3400
        },
    },
};

/**
    @trace #BRCM_SWARCH_DMON_VTMON_CFG_GLOBAL
    @trace #BRCM_SWREQ_DMON_MODULE
*/
void DMON_VtmonTempNotification(VTMON_TempType aCurrent,
                              VTMON_TempType aLowThreshold,
                              VTMON_TempType aHighThreshold)
{
    /* TODO: Update this function */
}

/**
    @trace #BRCM_SWARCH_DMON_VTMON_CFG_GLOBAL
    @trace #BRCM_SWREQ_DMON_MODULE
*/
void DMON_VtmonVoltNotification(VTMON_VoltIDType aVoltID,
                             VTMON_VoltType aCurrent,
                             VTMON_VoltType aLowThreshold,
                             VTMON_VoltType aHighThreshold)
{
    /* TODO: Update this function */
}
#endif

/**
    @trace #BRCM_SWARCH_DMON_GETSERVER_INFO_PROC
    @trace #BRCM_SWREQ_DMON_MODULE
*/
#if defined(SYSTEM_DMON_MODULE)
void DMON_GetServerInfo(int32_t *aServerTask, uint32_t *aServerEvent)
{
    SYSTEM_GetServer(aServerTask, aServerEvent);
}
#endif

/**
    @trace #BRCM_SWARCH_DMON_ALARMCB_PROC
    @trace #BRCM_SWREQ_DMON_MODULE
*/
void DMON_AlarmCb(void)
{
    int32_t serverTask;
    uint32_t event;

    SYSTEM_GetServer(&serverTask, &event);

    (void)SetEvent(serverTask, event);
}

/** @} */
