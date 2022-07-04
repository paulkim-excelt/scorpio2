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
    @defgroup grp_time_mod_config Time Module Configuration
    @ingroup grp_time_utils

    @addtogroup grp_time_mod_config
    @{

    @file time_config.c
    @brief This file implements module configuration for time.

    @version 0.1 Initial draft
*/

#include <time_module_osil.h>
#include <base_kernel_services.h>
#include <base_app_cfg.h>

/**
    @name Time module configuration Design IDs
    @{
    @brief Design IDs for time module configuration
*/
#define BRCM_SWDSGN_TIME_MODCFG_GLOBAL        (0xB001U) /**< @brief #TIME_ModConfig         */
#define BRCM_SWDSGN_TIM_CH0CALLBACK_PROC      (0xB002U) /**< @brief #TIM_Chann0Cb           */
#define BRCM_SWDSGN_TIM_CH1CALLBACK_PROC      (0xB003U) /**< @brief #TIM_Chann1Cb           */
/** @} */

/**
    @brief Global time module configuration

    Time module configuration table

    @trace #BRCM_SWARCH_TIME_MODCFG_GLOBAL
    @trace #BRCM_SWREQ_TIME_MODULE
*/
const TIME_ModCfgType TIME_ModConfig[TIME_MAX_NUM_CHANNELS] = {
    {
        .isValid = 1UL,
        .config = {
            .prescale = TIM_PRESCALE_DIV_1,
            .chanID = 0UL,
            .chanMode = TIM_CHAN_MODE_PERIODIC,
            .width = TIM_WIDTH_32_BIT,
            .sysTimeEn = TRUE,
        },
    },
    {
        .isValid = 1UL,
        .config = {
            .prescale = TIM_PRESCALE_DIV_1,
            .chanID = 1UL,
            .chanMode = TIM_CHAN_MODE_PERIODIC,
            .width = TIM_WIDTH_32_BIT,
            .sysTimeEn = FALSE,
        },
    }
};

/**
    @brief Timer channel 1 callback

    @trace #BRCM_SWARCH_TIM_CALLBACK1_PROC
    @trace #BRCM_SWREQ_TIM_NOTIFICATION_SWITCH

    @code{.unparsed}
    BASE_IncrementCounter(HRTimer)
    @endcode
*/
void TIM_Chann1Cb(void)
{
    int32_t ret = BASE_IncrementCounter(HRTimer);
    if (BCM_ERR_OK != ret) {
        BCM_REPORT_ERROR(BCM_TMD_ID, 0U, BRCM_SWDSGN_TIM_CH1CALLBACK_PROC, ret,
         0UL, "Invalid response from BASE_IncrementCounter");
    }
}

/**
    @brief Timer channel 0 callback

    @trace #BRCM_SWARCH_TIM_CALLBACK0_PROC
    @trace #BRCM_SWREQ_TIM_NOTIFICATION_SWITCH

    @code{.unparsed}
    BASE_IncrementCounter(SystemTimer)
    @endcode
*/
void TIM_Chann0Cb(void)
{
    int32_t ret = BASE_IncrementCounter(SystemTimer);
    if (BCM_ERR_OK != ret) {
        BCM_REPORT_ERROR(BCM_TMD_ID, 0U, BRCM_SWDSGN_TIM_CH0CALLBACK_PROC, ret,
         0UL, "Invalid response from BASE_IncrementCounter");
    }
}

/** @} */
