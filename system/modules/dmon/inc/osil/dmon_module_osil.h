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

/** @defgroup grp_dmn_mod_il DMON Module Integration Guide
    @ingroup grp_dmn_mod

    @addtogroup grp_dmn_mod_il
    @{

    @file dmn_module_osil.h
    @brief Integration for Device monitor module

    @version 0.1 Initial version
*/

#ifndef DMON_MOD_OSIL_H
#define DMON_MOD_OSIL_H

#include <module.h>
#if defined(ENABLE_VTMON)
#include <vtmon.h>
#endif

/**
    @name DMON Module Integration Interface IDs
    @{
    @brief Integration Interface IDs for Device monitor Modules

*/
#define BRCM_SWARCH_DMON_ALARMCB_PROC         (0x9601U) /**< @brief #DMON_AlarmCb          */
#define BRCM_SWARCH_DMON_GETSERVER_INFO_PROC  (0x9602U) /**< @brief #DMON_GetServerInfo    */
#define BRCM_SWARCH_DMON_VTMON_CFG_GLOBAL     (0x9603U) /**< @brief #DMON_VtmonCfg         */
#define BRCM_SWARCH_DMON_HB_INT_GLOBAL        (0x9604U) /**< @brief #DMON_HeartBeatInterval*/

/** @} */

/**
    @trace #BRCM_SWREQ_DMON_MODULE
 */
extern void DMON_AlarmCb(void);

/**
    @trace #BRCM_SWREQ_DMON_MODULE
 */
extern void DMON_GetServerInfo(int32_t *aServerTask, uint32_t *aServerEvent);

#if defined(ENABLE_VTMON)
/**
    @brief Global for VTMON Configuration

    @trace #BRCM_SWREQ_DMON_MODULE
*/
extern const VTMON_ConfigType DMON_VtmonCfg;
#endif

/**
    @brief Heart Beat Interval in milliseconds

    @trace #BRCM_SWREQ_DMON_MODULE
*/
extern const uint32_t DMON_HeartBeatInterval;

#endif /* DMON_MOD_OSIL_H */
/** @} */