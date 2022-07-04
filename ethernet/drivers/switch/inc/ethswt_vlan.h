/*****************************************************************************
 Copyright 2017-2020 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_ethswt_vlan_ifc VLAN Interface
    @ingroup grp_ethswt

    @addtogroup grp_ethswt_vlan_ifc
    @{

    @file ethswt_vlan.h
    @brief Application programmer interface for Ethernet Switch Driver (VLAN)

    @version 0.51 Imported from docx
 */

#ifndef ETHSWT_VLAN_H
#define ETHSWT_VLAN_H

#include <compiler.h>
#include <ethswt_common.h>
#include <ethernet_swt_common.h>

/**
    @name Ethernet Switch driver API IDs
    @{
    @brief API IDs for  Ethernet Switch driver
*/
#define BRCM_SWARCH_ETHSWT_VLAN_FRWRD_TYPE                     (0x8602U)    /**< @brief #ETHSWT_VLANFwrdType              */
#define BRCM_SWARCH_ETHSWT_VLAN_MEM_CFG_TYPE                   (0x8603U)    /**< @brief #ETHSWT_VLANMemberCfgType         */
#define BRCM_SWARCH_ETHSWT_ENABLE_VLAN_PROC                    (0x8604U)    /**< @brief #ETHSWT_EnableVLAN                */
#define BRCM_SWARCH_ETHSWT_GET_VLAN_PORTS_PROC                 (0x8605U)    /**< @brief #ETHSWT_GetVLANPorts              */
#define BRCM_SWARCH_ETHSWT_ADD_VLAN_PORTS_PROC                 (0x8606U)    /**< @brief #ETHSWT_AddVLANPorts              */
#define BRCM_SWARCH_ETHSWT_REMOVE_VLAN_PORTS_PROC              (0x8607U)    /**< @brief #ETHSWT_RemoveVLANPorts           */
#define BRCM_SWARCH_ETHSWT_SET_PORT_DEFAULT_VLAN_PROC          (0x8608U)    /**< @brief #ETHSWT_SetPortDefaultVlan        */
#define BRCM_SWARCH_ETHSWT_GET_PORT_DEFAULT_VLAN_PROC          (0x8609U)    /**< @brief #ETHSWT_GetPortDefaultVlan        */
#define BRCM_SWARCH_ETHSWT_SET_VLANINGRESS_FILTER_MODE_PROC    (0x860AU)    /**< @brief #ETHSWT_SetVLANIngressFilterMode  */
#define BRCM_SWARCH_ETHSWT_GET_VLANINGRESS_FILTER_MODE_PROC    (0x860BU)    /**< @brief #ETHSWT_GetVLANIngressFilterMode  */
#define BRCM_SWARCH_ETHSWT_SET_VLANHOPPINGDETECTION_PROC       (0x860CU)    /**< @brief #ETHSWT_SetVlanHoppingDetection   */
#define BRCM_SWARCH_ETHSWT_GET_VLANHOPPINGDETECTION_PROC       (0x860DU)    /**< @brief #ETHSWT_GetVlanHoppingDetection   */
/** @} */

/**
    @name VLAN forwarding type
    @{
    @brief VLAN forwarding type

    @trace #BRCM_SWREQ_ETHSWT_KERNEL_INTERFACE
*/
typedef uint8_t ETHSWT_VLANFwrdType;          /**< @brief VLAN forwarding
                                                        type */
#define ETHSWT_VLAN_FRWRD_DONT_SEND   (0U)    /**< @brief Don't send on this
                                                        port */
#define ETHSWT_VLAN_FRWRD_TAGGED      (1U)    /**< @brief Send tagged packets
                                                        at this port */
#define ETHSWT_VLAN_FRWRD_UNTAGGED    (2U)    /**< @brief Send untagged
                                                        packets at this port */
/** @} */

/**
    @brief VLAN membership configuration

    @trace #BRCM_SWREQ_ETHSWT_KERNEL_INTERFACE
*/
typedef struct COMP_PACKED sETHSWT_VLANMemberCfgType {
    ETHER_VLANIDType   vlanID;     /**< @brief VLAN ID. Membership of this port
                                            on this virtual network, frames with
                                            this VLAN ID shall be transmitted and
                                            received over this port. */
    uint16_t            macAddrList;/**< @brief Bit mask for participating MAC
                                            addresses in the VLAN. If the nth bit
                                            is set, then nth MAC address in
                                            ETHSWT_PortCfgType::fixedMacAddrList
                                            participates in this VLAN. */
    ETHSWT_PCPType      defaultPri; /**< @brief Default priority for outgoing
                                            packets. Range 0 – 7. */
    ETHSWT_VLANFwrdType forward;    /**< @brief Packet forwarding type. */
} ETHSWT_VLANMemberCfgType;

/** @brief Enable/disable VLAN

    This API enables/disables VLAN for a given port.

    @behavior Sync, Re-entrant

    @pre TBD

    @param[in]      aSwtID      Switch index
    @param[in]      aPortID     Port index
    @param[in]      aVlanID     VLAN ID
    @param[in]      aEnable     - #TRUE: Enable given VLAN for this port
                                - #FALSE: Disable given VLAN for this port

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully enabled/disabled VLAN
    @retval     #BCM_ERR_TIME_OUT       Timeout occurred while reading/writing
                                        switch register
    @retval     #BCM_ERR_NOT_FOUND      aVlanID is not configured for this port
    @retval     #BCM_ERR_UNKNOWN        Switch Driver configuration not found
    @retval     #BCM_ERR_INVAL_PARAMS   (Invalid port index) or
                                        (Invalid switch index)
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post TBD

    @trace  #BRCM_SWREQ_ETHSWT_DYNAMIC_CONFIGURATION

    @limitations None
*/
int32_t ETHSWT_EnableVLAN(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID,
        ETHER_VLANIDType aVlanID,
        uint32_t aEnable);

/** @brief Get ports participating in a VLAN

    This API retrieves port mask of the ports participating in a given
    VLAN.

    @param[in]      aSwtID      Switch index
    @param[in]      aVlanID     VLAN ID
    @param[out]     aPortMask   Bitmask representing the ports participating
                                in the given VLAN. If n-th bit is set to 1
                                represents n-th port is participating in the
                                VLAN
    @param[out]     aTagMask    Tag mask representing the ports supporting
                                tagged packets. If n-th bit is set respresents
                                n-th port is in tagged packet mode.
                                Based on this bitmask, Egress packets would be
                                sent as untagged or tagged packets
    @param[out]     aStaticPortMask   Bitmask representing the ports
                                participating in the given VLAN, which is added
                                to VLAN table during switch initialisation
                                (static entry). If n-th bit is set to 1
                                represents n-th port is participating in the
                                VLAN.
    @note The static ports can not be removed during runtime by calling
    ETHSWT_RemoveVLANPorts.

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully retrieving ports
                                        participating in VLAN.
    @retval     #BCM_ERR_TIME_OUT       Timeout occurred while reading/writing
                                        switch register
    @retval     #BCM_ERR_INVAL_PARAMS   (aTagMask is NULL) or
                                        (aPortMask is NULL) or
                                        (Invalid VLAN identifier) or
                                        (Invalid switch index)
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post TBD

    @trace  #BRCM_SWREQ_ETHSWT_QUERY

    @limitations None
*/
int32_t ETHSWT_GetVLANPorts(ETHSWT_HwIDType aSwtID,
        ETHER_VLANIDType aVlanID,
        uint32_t *const aPortMask,
        uint32_t *const aTagMask,
        uint32_t *const aStaticPortMask);


/** @brief Add ports to VLAN

    This API adds given ports to a VLAN in tagged or untagged mode.

    @param[in]      aSwtID      Switch index
    @param[in]      aPortMask   Port mask
    @param[in]      aVlanID     VLAN ID
    @param[in]      aTaggedMask Tagged mask

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully added port to VLAN
    @retval     #BCM_ERR_TIME_OUT       Timeout occurred while reading/writing
                                        switch register
    @retval     #BCM_ERR_INVAL_PARAMS   (Invalid Tagged mode mask) or
                                        (Invalid VLAN identifier) or
                                        (Invalid port mask) or
                                        (Invalid switch index)
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post TBD

    @trace  #BRCM_SWREQ_ETHSWT_DYNAMIC_CONFIGURATION

    @limitations None
*/
int32_t ETHSWT_AddVLANPorts(ETHSWT_HwIDType aSwtID,
        uint32_t aPortMask,
        ETHER_VLANIDType aVlanID,
        uint32_t aTaggedMask);

/** @brief Remove dynamically added ports from VLAN

    This API remove dynamically added ports from a VLAN, according to the port
    mask parameter.

    @behavior Sync, Re-entrant

    @note This API would not remove static entries(Ports/VLAN) from VLAN table.

    @pre TBD

    @param[in]      aSwtID      Switch index
    @param[in]      aPortMask   Port mask
    @param[in]      aVlanID     VLAN ID

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully removed port from VLAN
    @retval     #BCM_ERR_TIME_OUT       Timeout occurred while reading/writing
                                        switch register
    @retval     #BCM_ERR_NOPERM         Deletion of port/s which is/are part of static
                                        VLAN during initialization
    @retval     #BCM_ERR_INVAL_PARAMS   (Deletion of port/s which is/are not part of VLAN) or
                                        (Invalid port mask (zero)) or
                                        (Invalid VLAN identifier) or
                                        (Invalid switch index)
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post TBD

    @trace  #BRCM_SWREQ_ETHSWT_DYNAMIC_CONFIGURATION

    @limitations None
*/
int32_t ETHSWT_RemoveVLANPorts(ETHSWT_HwIDType aSwtID,
        uint32_t aPortMask,
        ETHER_VLANIDType aVlanID);

/** @brief Set port default VLAN

    This API set default VLAN ID and priority for a given port. These
    attributes would be utilised to untagged packets ingressing at
    that port.

    @behavior Sync, Re-entrant

    @pre TBD

    @param[in]      aSwtID      Switch index
    @param[in]      aPortID     Port index
    @param[in]      aPortVlanID Port default VLAN ID
    @param[in]      aPriority   Port default priority

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully set port VLAN ID and
                                        port priority
    @retval     #BCM_ERR_TIME_OUT       Timeout occurred while reading/writing
                                        switch register
    @retval     #BCM_ERR_INVAL_PARAMS   (Invalid priority value)
                                        (Invalid VLAN identifier) or
                                        (Invalid port index) or
                                        (Invalid switch index)
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post TBD

    @trace  #BRCM_SWREQ_ETHSWT_DYNAMIC_CONFIGURATION

    @limitations None
*/
int32_t ETHSWT_SetPortDefaultVlan(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID,
        ETHER_VLANIDType aVlanID,
        ETHER_PrioType aPrio);

/** @brief Get port default VLAN

    This API retrieves default VLAN ID and priority for a given port. These
    attributes would be utilised to untagged packets ingressing at that port.

    @behavior Sync, Re-entrant

    @pre TBD

    @param[in]      aSwtID      Switch index
    @param[in]      aPortID     Port index
    @param[out]     aVlanID     Pointer to retrieve port's default VLAN ID
    @param[out]     aPrio       Pointer to retrieve Port's default priority

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully retrieved port VLAN ID and
                                        port priority
    @retval     #BCM_ERR_TIME_OUT       Timeout occurred while reading/writing
                                        switch register
    @retval     #BCM_ERR_INVAL_PARAMS   (aPrio is NULL) or
                                        (aVlanID is NULL) or
                                        (Invalid port index) or
                                        (Invalid switch index)
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post TBD

    @trace  #BRCM_SWREQ_ETHSWT_QUERY

    @limitations None
*/
int32_t ETHSWT_GetPortDefaultVlan(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID,
        ETHER_VLANIDType *const aVlanID,
        ETHER_PrioType *const aPrio);

/** @brief Set Switch VLAN ingress filter mode

    This API set switch VLAN ingress filter mode.

    @behavior Sync, Re-entrant

    @pre TBD

    @param[in]      aSwtID      Switch index
    @param[in]      aMode       VLAN Ingress filter mode

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully set switch
                                        VLAN ingress filter mode
    @retval     #BCM_ERR_TIME_OUT       Timeout occurred while reading/writing
                                        switch register
    @retval     #BCM_ERR_INVAL_PARAMS   (Invalid VLAN ingress filter mode) or
                                        (Invalid switch index)
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post TBD

    @trace  #BRCM_SWREQ_ETHSWT_DYNAMIC_CONFIGURATION

    @limitations None
*/
int32_t ETHSWT_SetVLANIngressFilterMode(ETHSWT_HwIDType aSwtID,
        ETHSWT_VLANIngressFilterModeType aMode);

/** @brief Retreive Switch VLAN ingress filter mode

    This API retrieves switch VLAN ingress filter mode.

    @behavior Sync, Re-entrant

    @pre TBD

    @param[in]      aSwtID      Switch index
    @param[out]     aMode       Pointer to retrieve VLAN ingress filter state

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully retrieved switch
                                        VLAN ingress filter
    @retval     #BCM_ERR_TIME_OUT       Timeout occurred while reading/writing
                                        switch register
    @retval     #BCM_ERR_INVAL_PARAMS   (Invalid aMode) or
                                        (Invalid switch index)
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post TBD

    @trace  #BRCM_SWREQ_ETHSWT_QUERY

    @limitations None
*/
int32_t ETHSWT_GetVLANIngressFilterMode(ETHSWT_HwIDType aSwtID,
        ETHSWT_VLANIngressFilterModeType *const aMode);

/** @brief Set Vlan-Hopping detection(enable/disable)

    This API sets Vlan-Hopping detection. If Vlan-Hopping
    detection is enabled, then any packet arriving with two tags
    with TPID 0x8100 should be discarded or sent to the CPU.

    @behavior Sync, Non re-entrant

    @pre None

    @param[in]      aSwtID                   Switch index
    @param[in]      aVlanHoppingAction       Vlan-Hopping action.

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully set Vlan-Hopping
                                        detection
    @retval     #BCM_ERR_TIME_OUT       Timeout occurred while reading/writing
                                        switch register
    @retval     #BCM_ERR_INVAL_PARAMS   (invalid Vlan-Hopping action) or
                                        (Invalid switch index)
    @retval     #BCM_ERR_NOPERM         CPU port is not available
                                        (Valid only for the action,
                                         redirect to CPU)
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post None

    @trace  #BRCM_SWREQ_ETHSWT_SECURITY

    @limitations None
*/
int32_t ETHSWT_SetVlanHoppingDetection(ETHSWT_HwIDType aSwtID,
                 ETHSWT_SecurityActionType aVlanHoppingAction);

/** @brief Get Vlan-Hopping detection(enable/disable) status

    This function retreives switch Vlan-Hopping detection
    (enable/disable) status.

    @behavior Sync, Non re-entrant

    @pre None

    @param[in]      aSwtID                   Switch index
    @param[out]     aVlanHoppingAction       Pointer to Vlan-Hopping
                                             action.

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully retrieved Vlan-Hopping
                                        status
    @retval     #BCM_ERR_TIME_OUT       Timeout occurred while reading/writing
                                        switch register
    @retval     #BCM_ERR_INVAL_PARAMS   (aVlanHoppingAction is NULL) or
                                        (Invalid switch index)
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post None

    @trace  #BRCM_SWREQ_ETHSWT_SECURITY

    @limitations None
*/
int32_t ETHSWT_GetVlanHoppingDetection(ETHSWT_HwIDType aSwtID,
        ETHSWT_SecurityActionType * const aVlanHoppingAction);

#endif /* ETH_SWITCH_H */

/** @} */
