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
    @defgroup grp_eth_xcvrdrv_board Ethernet Transceiver Driver board Interface
    @ingroup grp_eth_xcvrdrv

    @addtogroup grp_eth_xcvrdrv_board
    @{

    @file ethxcvr_board.h
*/

#ifndef ETHXCVR_BOARD_H
#define ETHXCVR_BOARD_H

#include <ethxcvr.h>
#include <ethxcvr_osil.h>
#include <mcu_pad_cntrl.h>

/**
    @name Ethernet Transceiver API IDs
    @{
    @brief API IDs for Ethernet Transceiver
*/
#define BRCM_SWARCH_ETHXCVR_BOARDGETPHYFNTBL_PROC          (0x9701U)    /**< @brief #ETHXCVR_BoardGetPhyFnTbl       */
#define BRCM_SWARCH_ETHXCVR_BOARDVALIDATEPHYCONFIG_PROC    (0x9702U)    /**< @brief #ETHXCVR_BoardValidatePhyConfig */
#define BRCM_SWARCH_ETHXCVR_BOARDGETRGMIIPARAMS_PROC       (0x9703U)    /**< @brief #ETHXCVR_BoardGetRGMIIParams    */

/** @} */

/**
    @trace #BRCM_SWREQ_ETHXCVR_KERNEL_HANDLER
*/
extern int32_t ETHXCVR_BoardGetPhyFnTbl(const ETHXCVR_PortConfigType *const aConfig,
                                        const ETHXCVR_FuncTblType **const aPhyFnTbl,
                                        ETHXCVR_CntxtType **const aPhyCntxt);

/**
    @brief This is board specific API which validates the configuration
           of the any external PHY.

    @behavior Sync, Non-Reeentrant

    @param[in]  aConfig      Pointer to port configuration

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @retval     #BCM_ERR_UNKNOWN        Integration issue
    @retval     #BCM_ERR_INVAL_PARAMS   Invalid parameter

    @post None

    @trace #BRCM_SWREQ_ETHXCVR_KERNEL_HANDLER
*/
extern int32_t ETHXCVR_BoardValidatePhyConfig(const ETHXCVR_PortConfigType *const aConfig);

/**
    @brief This is board specific API which retrieves  the RGMII
           pad configuration.

    @behavior Sync, Non-Reeentrant

    @param[in]   aConfig           Pointer to port configuration
    @param[out]  aRGMIIPadCfg      Pointer to RGMII pad configuration

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success

    @post None

    @trace #BRCM_SWREQ_ETHXCVR_KERNEL_HANDLER
*/
extern int32_t ETHXCVR_BoardGetRGMIIParams(const ETHXCVR_PortConfigType *const aConfig,
                                  MCU_RGMIIPadCfgType *const aRGMIIPadCfg);

#endif /* ETHXCVR_BOARD_H */

/** @} */
