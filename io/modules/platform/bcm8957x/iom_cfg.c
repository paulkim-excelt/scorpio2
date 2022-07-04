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
  @addtogroup grp_iom_cfg
  @{

  @file iom_cfg.c
  @brief IO module Configuration
  This source file contains the configurations for IO module configurations.
  @version 0.1 Imported from docx

*/
#include <pinmux.h>
#include <gpio.h>
#include <bcm_utils.h>

/**
    @name IOM Configuration IDs
    @{
    @brief Architecture API IDs for IO Module Configuration
*/
#define BRCM_SWDSGN_IOM_IIC0_CFG_GLOBAL       (0xB900U) /**< @brief #IOM_IIC0PinModeCfg */
#define BRCM_SWDSGN_IOM_GPIO0_CFG_GLOBAL       (0xB901U) /**< @brief #IOM_GPIOPinModeCfg */
#define BRCM_SWDSGN_IOM_QSPI_CFG_GLOBAL       (0xB902U) /**< @brief #IOM_QSPIPinModeCfg */

/** @} */

/**
    @trace #BRCM_SWREQ_IOM
    @trace #BRCM_SWARCH_IOM_
*/
static const PINMUX_PinModeCfgType IOM_GPIOPinModeCfg[] = {
    {PINMUX_PIN_MODE_GPIO, 0UL},
};

/**
    @trace #BRCM_SWREQ_IOM
    @trace #BRCM_SWARCH_IOM_
*/
static const PINMUX_PinModeCfgType IOM_QSPIPinModeCfg[] = {
    {PINMUX_PIN_MODE_QSPI, 0U},
};

/**
    @trace #BRCM_SWREQ_IOM
    @trace #BRCM_SWARCH_IOM_
*/
static const PINMUX_PinCfgType IOM_PinMuxPins[] = {
{PINMUX_PIN_DIRECTION_OUT, PINMUX_PIN_DIRECTION_NOT_CHANGEABLE, GPIO_CHANNEL_8, PINMUX_PIN_MODE_QSPI, PINMUX_PIN_LEVEL_HIGH, 1UL, &IOM_QSPIPinModeCfg[0], PINMUX_PIN_MODE_NOT_CHANGEABLE},
#ifdef ENABLE_IPC
    {PINMUX_PIN_DIRECTION_OUT, PINMUX_PIN_DIRECTION_NOT_CHANGEABLE, GPIO_CHANNEL_4, PINMUX_PIN_MODE_GPIO,
     PINMUX_PIN_LEVEL_HIGH, 1UL, &IOM_GPIOPinModeCfg[0], PINMUX_PIN_MODE_NOT_CHANGEABLE},
#endif
    /*IOM_GPIO_MONITOR*/
	{0U, PINMUX_PIN_DIRECTION_NOT_CHANGEABLE, GPIO_CHANNEL_5, PINMUX_PIN_MODE_GPIO, 0U, 1UL, &IOM_GPIOPinModeCfg[0], PINMUX_PIN_MODE_NOT_CHANGEABLE},
};

const PINMUX_ConfigType PINMUX_Config[] = {
    {
        BCM_ARRAY_LEN(IOM_PinMuxPins),
        &IOM_PinMuxPins[0],
    },
};

const GPIO_IntrCbType GPIO_IntrCbTbl[GPIO_MAX_CHANNELS] = {
    NULL,                   /* Channel 0 */
    NULL,                   /* Channel 1 */
    NULL,                   /* Channel 2 */
    NULL,                   /* Channel 3 */
    NULL,                   /* Channel 4 */
    NULL,                   /* Channel 5 */
    NULL,                   /* Channel 6 */
    NULL,                   /* Channel 7 */
    NULL,                   /* Channel 8 */
};

/** @} */
