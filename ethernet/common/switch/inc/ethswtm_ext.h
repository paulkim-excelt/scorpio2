/*****************************************************************************
 Copyright 2021-2022 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_ethsrv_swtsecurity_ifc Ethernet Service: EXT Interface
    @ingroup grp_ethsrv_swt

    @addtogroup grp_ethsrv_swtsecurity_ifc
    @{

    @file ethswtm_ext.h

    @brief Ethernet Service: EXT Interface
    This file contains the interfaces for the Ethernet Service specific
    to EXT

    @version 0.1 Initial version
*/

#ifndef ETHSWTM_EXT_H
#define ETHSWTM_EXT_H

#include <module.h>
#include <ethswt_common.h>
#include <ethxcvr.h>
#include <ethswt_arl.h>
#include <ethswt_ext.h>
#include <ethernet_swt_ext.h>
#include <ethswt_xcvr.h>

/**
    @name Ethernet Service EXT API IDs
    @{
    @brief API IDs for EXT in Ethernet Service
*/
#define BRCM_SWARCH_ETHSWTM_EXTCONFIG_TYPE                   (0x8701U)   /**< @brief #ETHSWTM_ExtConfigType                */
#define BRCM_SWARCH_ETHSWTM_EXTPORTCONFIG_TYPE               (0x8702U)    /**< @brief #ETHSWTM_ExtPortConfigType            */
#define BRCM_SWARCH_ETHSWTM_EXTMODULE_GLOBAL                 (0x8703U)    /**< @brief #ETHSWTM_ExtModule                    */
/** @} */

/**
    @brief Port configuration

    @trace #BRCM_SWREQ_ETHSWTM_EXT
*/
typedef struct COMP_PACKED sETHSWTM_ExtPortConfigType {
    uint32_t                     portID;            /**< @brief Port Index */
    ETHSWT_PortType              role;              /**< @brief Port role */
    uint32_t                     enableTimeStamp;   /**< @brief Enable or disable timestamp support*/
    uint32_t                     enableJumboFrm;    /**< @brief Enable jumbo frames support on this
                                                          port */
    ETHSWT_PortIngressCfgType    ingressCfg;        /**< @brief Port ingress configuration */
    ETHSWT_PortEgressCfgType     egressCfg;         /**< @brief Port egress configuration */
    ETHSWT_PortSecurityCfgType   securityCfg;       /**< @brief Security configuration */
} ETHSWTM_ExtPortConfigType;

/**
    @brief Switch Core Configuration Type

    @trace #BRCM_SWREQ_ETHSWTM_EXT
 */
typedef struct COMP_PACKED sETHSWTM_ExtConfigType {
    ETHSWTM_ExtPortConfigType   portCfgList[ETHSWT_EXT_MAX_PORTS];
                                                           /**< @brief Port configuration list */
    uint32_t                      portCfgListSz;           /**< @brief Number of ports */
    ETHSWT_GlobalSecurityCfgType  globalSecurityCfg;       /**< @brief  Security configuration  */
    ETHSWT_BrcmHdrModeType        brcmHdrMode;             /**< @brief IMP Broadcom header mode */
    ETHSWT_SwitchType             switchType;              /**< @brief Type of switch w.r.t to operation */
} ETHSWTM_ExtConfigType;

/**
    @brief Function pointer table for ETHSWTM EXT module

    @trace #BRCM_SWREQ_ETHSWTM_EXT
 */
extern const MODULE_Type ETHSWTM_ExtModule;

#endif /* ETHSWTM_EXT_H */

/** @} */

