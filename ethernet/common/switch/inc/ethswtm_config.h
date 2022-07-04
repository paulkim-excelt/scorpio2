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
    @defgroup grp_ethsrv_swt_ifc Ethernet switch: Config Interface
    @ingroup grp_ethsrv_swt

    @addtogroup grp_ethsrv_swt_ifc
    @{

    @file ethswtm_config.h

    @brief Ethernet Service: Switch Interface Config
    This file contains the configuration interfaces for the Ethernet Service specific
    to Switch

    @version 0.1 Initial version
*/

#ifndef ETHSWTM_CFG_H
#define ETHSWTM_CFG_H

#include <ethswt_common.h>
#include <ethswtm_core.h>
#ifdef ENABLE_ETHSWTM_ARL_LIB
#include <ethswtm_arl.h>
#ifdef ENABLE_ETHSWTM_CFP_LIB
#include <ethernet_swt_cfp.h>
#endif
#endif
#ifdef ENABLE_ETHSWTM_EXT_LIB
#include <ethswtm_ext.h>
#endif
#ifdef ENABLE_ETHSWTM_VLAN_LIB
#include <ethswtm_vlan.h>
#endif
#ifdef ENABLE_ETHSWTM_DEBUG_LIB
#include <ethswtm_debug.h>
#endif

/**
    @name Ethernet Service Switch API IDs
    @{
    @brief API IDs for Switch in Ethernet Service
*/
#define BRCM_SWARCH_ETHSWTM_CONFIG_TYPE      (0x8401U)    /**< @brief #ETHSWTM_ConfigType */
#define BRCM_SWARCH_ETHSWTM_CONFIG_GLOBAL    (0x8402U)    /**< @brief #ETHSWTM_Config     */
/** @} */

/**
    @brief ETHSWTM Switch Configuration Type

    @trace #BRCM_SWREQ_ETHSWTM_CONFIG
 */
typedef struct COMP_PACKED sETHSWTM_ConfigType {
    uint32_t  magicId;                                       /**< @brief Magic number 'COMM' */
#ifdef ENABLE_ETHSWTM_EXT_LIB
    ETHSWTM_ExtConfigType extCfg;                            /**< @brief Extension Configuration */
#endif
#ifdef ENABLE_ETHSWTM_VLAN_LIB
    ETHSWTM_VLANConfigType vlanCfg;   /**< @brief VLAN Configuration */
#endif
#ifdef ENABLE_ETHSWTM_ARL_LIB
    ETHSWTM_ARLConfigType arlCfg;     /**< @brief ARL Configuration */
#ifdef ENABLE_ETHSWTM_CFP_LIB
    ETHSWT_CFPStreamPolicerConfigType streamPolicerCfg;     /**< @brief CFP Stream Policer Configuration */
#endif
#endif
} ETHSWTM_ConfigType;

/**
    @brief Ethernet Service Switch configuration

    @trace #BRCM_SWREQ_ETHSWTM_CONFIG
 */
extern ETHSWTM_ConfigType ETHSWTM_Config;

#endif /* ETHSWTM_CFG_H */

/** @} */
