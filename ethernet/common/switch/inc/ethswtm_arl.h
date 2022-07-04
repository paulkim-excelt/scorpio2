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
    @defgroup grp_ethsrv_swtarl_ifc Ethernet Service: ARL Interface
    @ingroup grp_ethsrv_swt

    @addtogroup grp_ethsrv_swtarl_ifc
    @{

    @file ethswtm_arl.h

    @brief Ethernet Service: ARL Interface
    This file contains the interfaces for the Ethernet Service specific
    to ARL

    @version 0.1 Initial version
*/

#ifndef ETHSWTM_ARL_H
#define ETHSWTM_ARL_H

#include <module.h>
#include <ethswt_common.h>
#include <ethswt_arl.h>
#include <ethernet_swt_arl.h>
#include <ethernet_common.h>

/**
    @name Ethernet Service ARL API IDs
    @{
    @brief API IDs for ARL in Ethernet Service
*/
#define BRCM_SWARCH_ETHSWTM_ARLENTRY_TYPE                (0x8501U)    /**< @brief #ETHSWTM_ARLEntryType        */
#define BRCM_SWARCH_ETHSWTM_ARLCONFIG_TYPE               (0x8502U)    /**< @brief #ETHSWTM_ARLConfigType       */
#define BRCM_SWARCH_ETHSWTM_ARLMODULE_GLOBAL             (0x8503U)    /**< @brief #ETHSWTM_ARLModule           */
#define BRCM_SWARCH_ETHSWTM_ARLENTRYUSED_PROC            (0x8504U)    /**< @brief #ETHSWTM_ARLEntryUsed        */
#define BRCM_SWARCH_ETHSWTM_ARLGETINDEXFORENTRY_PROC     (0x8505U)    /**< @brief #ETHSWTM_ARLGetIndexForEntry */
#define BRCM_SWARCH_ETHSWTM_ARLGETENTRYFORINDEX_PROC     (0x8506U)    /**< @brief #ETHSWTM_ARLGetEntryForIndex */
/** @} */

/**
    @brief ARL Entry type

    @trace #BRCM_SWREQ_ETHSWTM_ARL
 */
typedef struct COMP_PACKED sETHSWTM_ARLEntryType {
    uint8_t  macAddress[6U]; /**< @brief MAC address */
    uint16_t vlan;           /**< @brief VLAN Identifier */
    uint16_t portMask;       /**< @brief Bitmap of destination ports */
} ETHSWTM_ARLEntryType;

/**
    @brief ARL Configuration Type

    @trace #BRCM_SWREQ_ETHSWTM_ARL
 */
typedef struct COMP_PACKED sETHSWTM_ARLConfigType {
    ETHSWTM_ARLEntryType arlTable[ETHSWT_ARL_MAX_ENTRIES]; /**< @brief ARL table */
    uint32_t arlTblSz;            /**< @brief Number of entries in ARL table */
} ETHSWTM_ARLConfigType;

/**
    @brief Function pointer table for ETHSWTM ARL module

    @trace #BRCM_SWREQ_ETHSWTM_ARL
 */
extern const MODULE_Type ETHSWTM_ARLModule;

/** @brief Mark ARL entry as being used

    This API marks a specific ARL entry as being in-use or not

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  aSwtID         Switch Hardware Instance Identifier
    @param[in]  aIndex         Index of ARL Entry in the list
    @param[in]  aUsed          Boolean to mark in-use(TRUE) or not in-use(FALSE)

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK              Completed successfully
    @retval     #BCM_ERR_NOT_FOUND       Entry at aIndex not found to be in use
    @retval     #BCM_ERR_UNINIT          Uninitialised
    @retval     #BCM_ERR_INVAL_PARAMS    Invalid aSwtID OR
                                         aUsed is neither TRUE nor FALSE

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHSWTM_ARL
*/
extern int32_t ETHSWTM_ARLEntryUsed(ETHSWT_HwIDType aSwtID, uint32_t aIndex, uint32_t aUsed);

/** @brief Get ARL Index

    This API retrieves the index of ARL entry given the MAC address and VLAN ID

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  aSwtID         Switch Hardware Instance Identifier
    @param[in]  aMacAddr       Pointer to MAC address
    @param[in]  aVLAN          VLAN ID
    @param[out] aIndex         Pointer to return the index

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK              Index retrieved successfully
    @retval     #BCM_ERR_NOT_FOUND       No entry found matching the given criteria
    @retval     #BCM_ERR_UNINIT          Uninitialised
    @retval     #BCM_ERR_INVAL_PARAMS    Invalid aSwtID OR
                                         aMacAddr is NULL OR
                                         aIndex is NULL

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHSWTM_ARL
*/
extern int32_t ETHSWTM_ARLGetIndexForEntry(ETHSWT_HwIDType aSwtID, const uint8_t *const aMacAddr,
                                           const ETHER_VLANIDType aVLAN, uint32_t *aIndex);

/** @brief Get ARL Information

    This API retrieves ARL information at a given index

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  aSwtID         Switch Hardware Instance Identifier
    @param[in]  aIndex         Index of ARL entry
    @param[out] aMacAddr       Pointer to MAC address
    @param[out] aVLAN          Pointer to VLAN ID

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK              ARL information retrieved successfully
    @retval     #BCM_ERR_NOT_FOUND       No valid entry found at the given index
    @retval     #BCM_ERR_UNINIT          Uninitialised
    @retval     #BCM_ERR_INVAL_PARAMS    Invalid aSwtID OR
                                         aMacAddr is NULL OR
                                         aVLAN is NULL OR
                                         aIndex is out of bounds

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHSWTM_ARL
*/
extern int32_t ETHSWTM_ARLGetEntryForIndex(ETHSWT_HwIDType aSwtID, const uint32_t aIndex,
                                           uint8_t *aMacAddr, ETHER_VLANIDType *aVLAN);

#endif /* ETHSWTM_ARL_H */

/** @} */
