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
    @defgroup grp_ethsrv_swtvlan_ifc Ethernet Service: VLAN Interface
    @ingroup grp_ethsrv_swt

    @addtogroup grp_ethsrv_swtvlan_ifc
    @{

    @file ethswtm_vlan.h

    @brief Ethernet Service: VLAN Interface
    This file contains the interfaces for the Ethernet Service specific
    to VLAN

    @version 0.1 Initial version
*/

#ifndef ETHSWTM_VLAN_H
#define ETHSWTM_VLAN_H

#include <module.h>
#include <ethswt_common.h>
#include <ethernet_swt_vlan.h>

/**
    @name Ethernet Service VLAN API IDs
    @{
    @brief API IDs for VLAN in Ethernet Service
*/
#define BRCM_SWARCH_ETHSWTM_VLAN_MAX_ENTRIES_MACRO    (0x8301U)    /**< @brief #ETHSWTM_VLAN_MAX_ENTRIES */
#define BRCM_SWARCH_ETHSWTM_VLANENTRY_TYPE            (0x8302U)    /**< @brief #ETHSWTM_VLANEntryType    */
#define BRCM_SWARCH_ETHSWTM_VLANCONFIG_TYPE           (0x8303U)    /**< @brief #ETHSWTM_VLANConfigType   */
#define BRCM_SWARCH_ETHSWTM_VLANMODULE_GLOBAL         (0x8304U)    /**< @brief #ETHSWTM_VLANModule       */
/** @} */

/**
    @brief Maximum number of VLANS supported by Ethernet Service

    @trace #BRCM_SWREQ_ETHSWTM_VLAN
*/
#define ETHSWTM_VLAN_MAX_ENTRIES                       (512UL)

/**
    @brief VLAN entry

    @trace #BRCM_SWREQ_ETHSWTM_VLAN
 */
typedef struct COMP_PACKED sETHSWTM_VLANEntryType {
    uint16_t vlan;      /**< @brief VLAN Identifier */
    uint16_t portMask;  /**< @brief Bitmap of participating ports */
    uint16_t tagMask;   /**< @brief Bitmap of participating ports
                                    where egress packets are tagged */
} ETHSWTM_VLANEntryType;

/**
    @brief VLAN Configuration

    @trace #BRCM_SWREQ_ETHSWTM_VLAN
 */
typedef struct COMP_PACKED sETHSWTM_VLANConfigType {
    ETHSWTM_VLANEntryType         vidTable[ETHSWTM_VLAN_MAX_ENTRIES];
                                                           /**< @brief VLAN table */
    uint32_t                      vidTblSz;                /**< @brief Number of entries in VLAN table */
} ETHSWTM_VLANConfigType;

/**
    @brief Function pointer table for ETHSWTM VLAN module

    @trace #BRCM_SWREQ_ETHSWTM_VLAN
 */
extern const MODULE_Type ETHSWTM_VLANModule;

#endif /* ETHSWTM_VLAN_H */

/** @} */

