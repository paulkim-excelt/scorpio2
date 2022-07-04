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

/** @defgroup grp_time_mod_il Time Module Integration Guide
    @ingroup grp_time_utils

    @addtogroup grp_time_mod_il
    @{

    @file time_module_osil.h
    @brief Integration for time module

    @version 0.1 Initial version
*/

#ifndef TIME_MOD_OSIL_H
#define TIME_MOD_OSIL_H

#include <tim.h>
#include <module.h>
#include <tim_osil.h>

/**
    @name System Integration Interface IDs
    @{
    @brief Integration Interface IDs for System

*/
#define BRCM_SWARCH_TIME_MAXNUMCHAN_MACRO     (0x9101U) /**< @brief #TIME_MAX_NUM_CHANNELS  */
#define BRCM_SWARCH_TIME_MODCFG_TYPE          (0x9102U) /**< @brief #TIME_ModCfgType        */
#define BRCM_SWARCH_TIME_MODCFG_GLOBAL        (0x9103U) /**< @brief #TIME_ModConfig         */
#define BRCM_SWARCH_TIME_MODULE_GLOBAL        (0x9104U) /**< @brief #TIME_Module            */
/** @} */

/**
    @brief Timer maximum number of channels

    Timer maximum number of channels

    @trace #BRCM_SWREQ_TIME_MODULE
*/
#define TIME_MAX_NUM_CHANNELS                (2UL)

/**
    @brief Timer module configuration structure

    Structure for timer module configuration

    @trace #BRCM_SWREQ_TIME_MODULE
*/
typedef struct sTIME_ModCfgType {
    TIM_ConfigType config;
    uint32_t isValid;
} TIME_ModCfgType;

/**
    @brief Global timer module configuration

    Pointer to timer module configuration table

    @trace #BRCM_SWREQ_TIME_MODULE
*/
extern const TIME_ModCfgType TIME_ModConfig[TIME_MAX_NUM_CHANNELS];

/**
    @brief Structure for timer module

    @trace #BRCM_SWREQ_TIME_MODULE
 */
extern const MODULE_Type TIME_Module;

#endif /* TIME_MOD_OSIL_H */
/** @} */
