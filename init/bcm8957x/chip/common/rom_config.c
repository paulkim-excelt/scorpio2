/*****************************************************************************
 Copyright 2020 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_bcm8967x_rom_config Configuration
    @ingroup grp_bcm8967x_rom

    @addtogroup grp_bcm8967x_rom_config
    @{

    @file rom_config.c
    @brief ROM configuration

    @version 0.1 Initial version
*/

#include <stdint.h>
#include <pinmux.h>
#include <bcm_utils.h>
#include <ipc.h>

/**
    @name ROM Main Design IDs
    @{
    @brief Design IDs for ROM Main
*/
#define BRCM_SWDSGN_PINMUX_QSPI_PIN_CFG_GLOBAL       (0xB101U)    /**< @brief #PINMUX_QSPIPinCfg */
#define BRCM_SWDSGN_PINMUX_PINS_GLOBAL               (0xB102U)    /**< @brief #PINMUX_Pins       */
#define BRCM_SWDSGN_PINMUX_CONFIG_BCM8967X_GLOBAL    (0xB103U)    /**< @brief #PINMUX_Config     */
/** @} */

/**
    @trace #BRCM_SWARCH_PINMUX_CONFIG_GLOBAL
    @trace #BRCM_SWREQ_PINMUX_KERNEL_INTERFACE_BCM8967X_ROM
*/
static const PINMUX_PinModeCfgType PINMUX_QSPIPinCfg[] = {
    {PINMUX_PIN_MODE_QSPI, 0U},
};

/**
    @trace #BRCM_SWARCH_PINMUX_CONFIG_GLOBAL
    @trace #BRCM_SWREQ_PINMUX_KERNEL_INTERFACE_BCM8967X_ROM
*/
static const PINMUX_PinCfgType PINMUX_Pins[] = {
    {PINMUX_PIN_DIRECTION_OUT, PINMUX_PIN_DIRECTION_NOT_CHANGEABLE, GPIO_CHANNEL_8, PINMUX_PIN_MODE_QSPI, PINMUX_PIN_LEVEL_HIGH, 1UL, &PINMUX_QSPIPinCfg[0], PINMUX_PIN_MODE_NOT_CHANGEABLE},
};

/**
    @trace #BRCM_SWARCH_PINMUX_CONFIG_GLOBAL
    @trace #BRCM_SWREQ_PINMUX_KERNEL_INTERFACE_BCM8967X_ROM
*/
const PINMUX_ConfigType PINMUX_Config[] = {
    {
        sizeof(PINMUX_Pins) / sizeof(PINMUX_PinCfgType),
        &PINMUX_Pins[0],
    },
};

/**
*/
const IPC_ChannCfgType IPC_ChannCfg[IPC_MAX_CHANNELS] = {
    {
        .ID = 0UL,
        .mode = IPC_CHANN_MODE_SLAVE,
        .sizeLog2 = 9U,
        .cntLog2 = 3U,
        .busInfo = {
            .hwID = 0UL,
            .busType = IPC_BUS_MEMMAP,
            .slaveID = 0UL,
            .fnTbl = NULL,
        },
    },
};


/** @} */
