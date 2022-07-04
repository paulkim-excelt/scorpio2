/*****************************************************************************
 Copyright 2019 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_eth_xcvrdrv_plat_impl Ethernet Transceiver Driver Platform Interface
    @ingroup grp_eth_xcvrdrv

    @addtogroup grp_eth_xcvrdrv_plat_impl
    @{

    @file ethxcvr_platform.h
*/

#ifndef ETHXCVR_PLATFORM_H
#define ETHXCVR_PLATFORM_H

#include <ethxcvr.h>
#include <ethxcvr_osil.h>

/**
    @name Ethernet Transceiver API IDs
    @{
    @brief API IDs for Ethernet Transceiver
*/
#define BRCM_SWARCH_ETHXCVR_PLATFORMGETFNTBLSCNTXT_PROC    (0x8201U)    /**< @brief #ETHXCVR_PlatformGetFnTblsCntxt    */
#define BRCM_SWARCH_ETHXCVR_PLATFORMVALIDATECONFIG_PROC    (0x8202U)    /**< @brief #ETHXCVR_PlatformValidateConfig    */
#define BRCM_SWARCH_ETHXCVR_PLATFORMMUXCONFIG_PROC         (0x8203U)    /**< @brief #ETHXCVR_PlatformMuxConfigure      */
#define BRCM_SWARCH_ETHXCVR_PLATFORMCONTROLLERMAP_TYPE     (0x8204U)    /**< @brief #ETHXCVR_PlatformControllerMapType */
#define BRCM_SWARCH_ETHXCVR_CONTROLLERMAP_GLOBAL           (0x8205U)    /**< @brief #ETHXCVR_ControllerMap             */
/** @} */

/**
    @brief Hardware to logical controller index map structure

    @trace #BRCM_SWREQ_ETHXCVR_KERNEL_HANDLER
 */
typedef struct sETHXCVR_PlatformControllerMapType {
   ETHXCVR_IDType      port;             /**< @brief Port index */
   ETHXCVR_BusModeType busMode;          /**< @brief Bus mode */
   uint8_t             hwControllerID;   /**< @brief Hardware controller index */
   uint8_t             swControllerID;   /**< @brief Software controller index */
} ETHXCVR_PlatformControllerMapType;

/**
    @brief Hardware to logical controller index map

    @trace #BRCM_SWREQ_ETHXCVR_KERNEL_HANDLER
 */
extern const ETHXCVR_PlatformControllerMapType ETHXCVR_ControllerMap[ETHXCVR_MAX_CONTROLLERS];

/**
    @trace #BRCM_SWREQ_ETHXCVR_KERNEL_HANDLER
*/
int32_t ETHXCVR_PlatformGetFnTblsCntxt(const ETHXCVR_PortConfigType *const aConfig,
                                            const ETHXCVR_FuncTblType **const aBusFnTbl,
                                            const ETHXCVR_FuncTblType **const aPhyFnTbl,
                                            ETHXCVR_CntxtType **const aPhyCntxt);

/**
    @brief This API validates the xcvr configuration of the port.

    @behavior Sync, Non-Reeentrant

    @param[in]  aConfig                 Pointer to port configuration

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @retval     #BCM_ERR_INVAL_PARAMS   Invalid parameter

    @post None

    @trace #BRCM_SWREQ_ETHXCVR_KERNEL_HANDLER
*/
int32_t ETHXCVR_PlatformValidateConfig(const ETHXCVR_PortConfigType *const aConfig);

/**
    @brief This API configure the multiplexer

    Multiple network facing interfaces can be supported
    on ethernet port. But only one of which can be active at a time.
    This API select a particular network interface for a port by programming
    certain set of multiplexers.

    @behavior Sync, Non-Reeentrant

    @param[in]  aConfig      Pointer to port configuration
    @param[in]  aMode        Ethernet transceiver mode

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @retval     #BCM_ERR_UNKNOWN        Unknown error

    @post None
    @trace #BRCM_SWREQ_ETHXCVR_KERNEL_HANDLER
*/
int32_t ETHXCVR_PlatformMuxConfigure(const ETHXCVR_PortConfigType *const aConfig, ETHXCVR_ModeType aMode);

#endif /* ETHXCVR_PLATFORM_H */

/** @} */
