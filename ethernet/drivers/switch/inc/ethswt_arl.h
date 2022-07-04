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
    @defgroup grp_ethswt_arl_ifc Ethernet Switch Driver Interface
    @ingroup grp_ethswt

    @addtogroup grp_ethswt_arl_ifc
    @{

    @file ethswt_arl.h
    @brief Application programmer interface for Ethernet Switch Driver (ARL)

    @version 0.51 Imported from docx
 */

#ifndef ETHSWT_ARL_H
#define ETHSWT_ARL_H

#include <compiler.h>
#include <ethswt_common.h>
#include <ethernet_swt_arl.h>
#include <ethernet_swt_common.h>

/**
    @name Ethernet Switch driver API IDs
    @{
    @brief API IDs for  Ethernet Switch driver
*/
#define BRCM_SWARCH_ETHSWT_MACLEARNING_TYPE                     (0x8301U)    /**< @brief #ETHSWT_MacLearningModeType         */
#define BRCM_SWARCH_ETHSWT_SET_MAC_LEARN_MODE_PROC              (0x8304U)    /**< @brief #ETHSWT_SetMACLearningMode          */
#define BRCM_SWARCH_ETHSWT_GET_MAC_LEARN_MODE_PROC              (0x8305U)    /**< @brief #ETHSWT_GetMACLearningMode          */
#define BRCM_SWARCH_ETHSWT_GET_PORT_MAC_ADDR_PROC               (0x8306U)    /**< @brief #ETHSWT_GetPortMacAddr              */
#define BRCM_SWARCH_ETHSWT_GET_ARL_TBL_PROC                     (0x8307U)    /**< @brief #ETHSWT_GetARLTable                 */
#define BRCM_SWARCH_ETHSWT_ADD_ARL_ENTRY_PROC                   (0x8308U)    /**< @brief #ETHSWT_AddARLEntry                 */
#define BRCM_SWARCH_ETHSWT_DELETE_ARL_ENTRY_PROC                (0x8309U)    /**< @brief #ETHSWT_DeleteARLEntry              */
#define BRCM_SWARCH_ETHSWT_ADD_ARL_MYDA_ENTRY_PROC              (0x830AU)    /**< @brief #ETHSWT_AddARLMyDAEntry             */
#define BRCM_SWARCH_ETHSWT_DELETE_ARL_MYDA_ENTRY_PROC           (0x830BU)    /**< @brief #ETHSWT_DeleteARLMyDAEntry          */
#define BRCM_SWARCH_ETHSWT_GETARLMYDASNAPSHOT_PROC              (0x830CU)    /**< @brief #ETHSWT_GetARLMyDASnapshot          */
#define BRCM_SWARCH_ETHSWT_SET_AGE_PROC                         (0x830DU)    /**< @brief #ETHSWT_SetAge                      */
#define BRCM_SWARCH_ETHSWT_GET_AGE_PROC                         (0x830EU)    /**< @brief #ETHSWT_GetAge                      */
#define BRCM_SWARCH_ETHSWT_SET_STATIONMOVEMENTDETECTION_PROC    (0x830FU)    /**< @brief #ETHSWT_SetStationMovementDetection */
#define BRCM_SWARCH_ETHSWT_GET_STATIONMOVEMENTDETECTION_PROC    (0x8310U)    /**< @brief #ETHSWT_GetStationMovementDetection */
#define BRCM_SWARCH_ETHSWT_SET_PORT_ADDRLIMITING_PROC           (0x8311U)    /**< @brief #ETHSWT_SetPortAddrLimiting         */
#define BRCM_SWARCH_ETHSWT_GET_PORT_ADDRLIMITANDCOUNTER_PROC    (0x8312U)    /**< @brief #ETHSWT_GetPortAddrLimitAndCounter  */
#define BRCM_SWARCH_ETHSWT_SET_MACADDRESSSTICKYTOPORT_PROC      (0x8313U)    /**< @brief #ETHSWT_SetMACAddressStickyToPort   */
#define BRCM_SWARCH_ETHSWT_GET_MACADDRESSSTICKYTOPORT_PROC      (0x8314U)    /**< @brief #ETHSWT_GetMACAddressStickyToPort   */
#define BRCM_SWARCH_ETHSWT_SET_TOTALADDRLIMIT_PROC              (0x8315U)    /**< @brief #ETHSWT_SetTotalAddrLimit           */
#define BRCM_SWARCH_ETHSWT_GET_TOTALADDRLIMITANDCOUNTER_PROC    (0x8316U)    /**< @brief #ETHSWT_GetTotalAddrLimitAndCounter */
/** @} */

/**
    @name Port ARL learning mode type
    @{
    @brief Port ARL learning mode type

    @trace #BRCM_SWREQ_ETHSWT_KERNEL_INTERFACE
*/
typedef uint8_t ETHSWT_MacLearningModeType;   /**< @brief ARL learning mode
                                                        type */
#define ETHSWT_MACLEARNING_DISABLED   (0U)    /**< @brief MAC learning
                                                        disabled (MAC address is
                                                        not learned either by
                                                        software or hardware) */
#define ETHSWT_MACLEARNING_HW_ENABLED (1U)    /**< @brief Hardware learning
                                                        mode enabled */
#define ETHSWT_MACLEARNING_SW_ENABLED (2U)    /**< @brief Software learning
                                                        mode enabled. In this mode
                                                        hardware does not
                                                        automatically learns the
                                                        ARL and does not create or
                                                        update the ARL table.
                                                        If the packet is coming
                                                        from unknown source
                                                        address, it is forwarded to
                                                        CPU for learning */
/** @} */

/** @brief Identify a port to reach given MAC address

    This API searches through switch ports to identify a port to reach given MAC
    address.

    @note The switch performs search for indentifying a port to reach a
    given MAC address based on MAC address + VLAN combination.

    @behavior Sync, Re-entrant

    @pre TBD

    @param[in]      aSwtID      Switch index
    @param[out]     aPortID     Pointer to retrieve Port index
    @param[in]      aMacAddr    Pointer to retrieve MAC address
    @param[in]      aVlanID     Vlan ID in which MAC Address is participating

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully retrieved port index from
                                        which MAC address is reachable
    @retval     #BCM_ERR_INVAL_PARAMS   (Invalid switch index) or
                                        (aMacAddr is NULL) or
                                        (Invalid VLAN Id) or
                                        (aPortID is NULL) or
                                        (Multicast Address)
    @retval     #BCM_ERR_NOT_FOUND      There is no port which can reach this
                                        MAC address (+ VLAN combination )
    @retval     #BCM_ERR_TIME_OUT       Switch driver read-write time-out
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post TBD

    @trace  #BRCM_SWREQ_ETHSWT_QUERY

    @limitations None
*/
int32_t ETHSWT_GetPortMacAddr(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType *const aPortID,
        const uint8_t *const aMacAddr,
        ETHER_VLANIDType aVlanID);

/** @brief Retrieve ARL table

    This API read the complete ARL table from the switch and copies it to the
    buffer given by @c aARLTbl.

    @behavior Sync, Re-entrant

    @pre TBD

    @param[in]      aSwtID      Switch index
    @param[out]     aARLTbl     Pointer to retrieve ARL table
    @param[inout]   aTblSize    - in: Maximum number of entries that can be
                                  copied in the ARL table buffer
                                - out: Actual number of entries copied in the
                                  ARL table buffer

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully retrieved ARL table
    @retval     #BCM_ERR_TIME_OUT       Switch driver read-write time-out
    @retval     #BCM_ERR_INVAL_PARAMS   (aTblSize is NULL or <BR>
                                        aARLTbl is NULL) or
                                        (Invalid switch index)
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized
    @todo       #BCM_ERR_INVAL_PARAMS   aTbleSize is zero. Where are we checking
                                        this in the code?

    @post TBD

    @trace  #BRCM_SWREQ_ETHSWT_QUERY

    @limitations None
*/
int32_t ETHSWT_GetARLTable(ETHSWT_HwIDType aSwtID,
        ETHSWT_ARLEntryType *const aARLTbl,
        uint16_t *const aTblSize);

/** @brief Set MAC learning mode

    This API sets MAC learning mode for index switch port.

    @behavior Sync, Re-entrant for different aPortID or aSwtID

    @pre TBD

    @param[in]      aSwtID      Switch index
    @param[in]      aPortID     Port index
    @param[in]      aMode       MAC learning mode

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully set MAC learning mode
    @retval     #BCM_ERR_TIME_OUT       Timeout occurred while reading/writing
                                        switch register
    @retval     #BCM_ERR_INVAL_PARAMS   (Invalid port index) or
                                        (Invalid MAC learning mode) or
                                        (Invalid switch index)
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post TBD

    @trace  #BRCM_SWREQ_ETHSWT_DYNAMIC_CONFIGURATION

    @limitations None
*/
int32_t ETHSWT_SetMACLearningMode(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID,
        ETHSWT_MacLearningModeType aMode);

/** @brief Get MAC learning mode

    This API retrieves MAC learning mode for index switch port.

    @behavior Sync, Re-entrant for different aPortID or aSwtID

    @pre TBD

    @param[in]      aSwtID      Switch index
    @param[in]      aPortID     Port index
    @param[out]     aMode       Pointer to retrieve MAC learning mode

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully retrieved MAC learning mode
    @retval     #BCM_ERR_TIME_OUT       Timeout occurred while reading/writing
                                        switch register
    @retval     #BCM_ERR_INVAL_PARAMS   (aMode is NULL) or
                                        (Invalid port index) or
                                        (Invalid switch index)
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post TBD

    @trace  #BRCM_SWREQ_ETHSWT_QUERY

    @limitations None
*/
int32_t ETHSWT_GetMACLearningMode(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID,
        ETHSWT_MacLearningModeType *const aMode);

/** @brief Add entry to ARL table

    This API adds a new entry to ARL table.

    @note aARLEntry->reserved are not respected in this API

    @behavior Sync, Re-entrant

    @pre TBD

    @param[in]      aSwtID      Switch index
    @param[in]      aPortID     Port index
    @param[in]      aARLEntry   Pointer to ARL entry

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully added entry to ARL table
    @retval     #BCM_ERR_TIME_OUT       Timeout occurred while reading/writing
                                        switch register
    @retval     #BCM_ERR_INVAL_PARAMS   (Trying to add an ARL entry with destination map
                                        which is not the subset of registered VLAN map) or
                                        (Trying to add an ARL entry with VLAN which doesn’t exist) or
                                        (aARLEntry is NULL) or
                                        (Invalid switch index)
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post TBD

    @trace  #BRCM_SWREQ_ETHSWT_INITIALISATION

    @limitations None
*/
int32_t ETHSWT_AddARLEntry(ETHSWT_HwIDType aSwtID,
        ETHSWT_ARLEntryType *const aARLEntry);

/** @brief Delete entry from ARL table

    This API delete an existing entry from ARL table.

    @note aARLEntry->portMask and aARLEntry->reserved are not respected in
    this API

    @note This API would not delete static ARL entries.

    @behavior Sync, Re-entrant

    @pre TBD

    @param[in]      aSwtID      Switch index
    @param[in]      aPortID     Port index
    @param[in]      aVlanID     VLAN ID
    @param[in]      aMacAddr    Pointer to MAC address

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully removed entry from ARL table
    @retval     #BCM_ERR_TIME_OUT       Timeout occurred while reading/writing
                                        switch register
    @retval     #BCM_ERR_NOT_FOUND      Entry not found in ARL table
    @retval     #BCM_ERR_INVAL_PARAMS   (aMacAddr is NULL) or
                                        (Invalid VLAN identifier) or
                                        (Invalid port index) or
                                        (Invalid switch index) or
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post TBD

    @trace  #BRCM_SWREQ_ETHSWT_DYNAMIC_CONFIGURATION

    @limitations None
*/
int32_t ETHSWT_DeleteARLEntry(ETHSWT_HwIDType aSwtID,
        ETHSWT_ARLEntryType *const aARLEntry);

/** @brief Add entry to ARL MyDA Control

    This API adds a new ARL entry in MyDA control

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aSwtID      Switch index
    @param[in]      aPortMask   Port mask
    @param[in]      aMacAddr    Pointer to MAC Address

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully added entry to ARL table
    @retval     #BCM_ERR_NOSUPPORT      No MyDA Support in switch
    @retval     #BCM_ERR_NOMEM          No memory available to add a entry
    @retval     #BCM_ERR_INVAL_PARAMS   (aSwtID is NULL) or
                                        (aMacAddr is NULL) or
                                        (*aMacAddr is 0) or
                                        (*aMacAddr is Multicast)

    @post None

    @trace  #BRCM_SWREQ_ETHSWT_INITIALISATION

    @limitations None
*/
int32_t ETHSWT_AddARLMyDAEntry(ETHSWT_HwIDType aSwtID,
                                  uint16_t aPortMask,
                                  const uint8_t *const aMacAddr);

/** @brief Delete entry from ARL MyDA Control

    This API delete an existing ARL entry from MyDA Control

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aSwtID      Switch index
    @param[in]      aMacAddr    Pointer to MAC address

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully removed entry from ARL MyDA Control
    @retval     #BCM_ERR_NOSUPPORT      No MyDA Support in switch
    @retval     #BCM_ERR_NOT_FOUND      ARL Entry not found in MyDA Control
    @retval     #BCM_ERR_INVAL_PARAMS   (aSwtID is NULL) or
                                        (aMacAddr is NULL) or
                                        (*aMacAddr is 0) or
                                        (*aMacAddr is Multicast)

    @post None

    @trace  #BRCM_SWREQ_ETHSWT_DYNAMIC_CONFIGURATION

    @limitations None
*/
int32_t ETHSWT_DeleteARLMyDAEntry(ETHSWT_HwIDType aSwtID,
                                  const uint8_t *const aMacAddr);

/** @brief Retrieve myDA ARL Entries

    This API reads the myDA ARL entries from the switch

    @behavior Sync, Re-entrant

    @pre None

    @param[in]        aSwtID        Switch index
    @param[out]       aARLTbl       Pointer to retrieve myDA ARL table
    @param[inout]     aTblSize      - in: Maximum number of entries that can be
                                    copied in the myDA ARL table buffer
                                    - out: Actual number of entries copied in the
                                    myDA ARL table buffer

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully retrieved entries from ARL MyDA Control
    @retval     #BCM_ERR_NOSUPPORT      No MyDA Support in switch
    @retval     #BCM_ERR_INVAL_PARAMS   (aSwtID is NULL) or
                                        (aARLTbl is NULL) or
                                        (aTblSize is NULL) or
                                        (*aTblSize is 0) or
                                        (*aTblSize is Greater than #ETHSWT_MAX_MYDA_ENTRIES)

    @post None

    @trace  #BRCM_SWREQ_ETHSWT_QUERY

    @limitations None
*/
int32_t ETHSWT_GetARLMyDASnapshot(ETHSWT_HwIDType aSwtID,
                                      ETHSWT_ARLEntryType *const aARLTbl,
                                      uint16_t *const aTblSize);

/** @brief Set Switch Age Time

    This API sets switch FDB age time. Dynamically learnt entries will
    age out within aAge to 2*aAge seconds. If 0 value is passed as aAge,
    it disables FDB ageing.

    @behavior Sync, Re-entrant

    @pre TBD

    @param[in]      aSwtID      Switch index
    @param[in]      aAge        Switch FDB age time

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully set FDB age
    @retval     #BCM_ERR_TIME_OUT       Timeout occurred while reading/writing
                                        switch register
    @retval     #BCM_ERR_INVAL_PARAMS   Invalid switch index
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post TBD

    @trace  #BRCM_SWREQ_ETHSWT_DYNAMIC_CONFIGURATION

    @limitations None
*/
int32_t ETHSWT_SetAge(ETHSWT_HwIDType aSwtID,
        uint32_t aAge);

/** @brief Retrieve Switch FDB age time

    This API retreives switch FDB age time.

    @behavior Sync, Re-entrant

    @pre TBD

    @param[in]      aSwtID      Switch index
    @param[out]     aAge        Pointer to retrieve FDB age

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully retrieved FDB age
    @retval     #BCM_ERR_TIME_OUT       Timeout occurred while reading/writing
                                        switch register
    @retval     #BCM_ERR_INVAL_PARAMS   (aAge is NULL) or
                                        (Invalid switch index)
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post TBD

    @trace  #BRCM_SWREQ_ETHSWT_QUERY

    @limitations None
*/
int32_t ETHSWT_GetAge(ETHSWT_HwIDType aSwtID,
        uint32_t *const aAge);

/** @brief Set station movement detection(enable with action/disable)

    If station movement detection is enabled and a MAC address
    has been learned by hardware on a port, and a packet with
    the same address as MAC-SA enters the switch from a different
    physical port, then it should be discarded or sent to the CPU.

    @behavior Sync, Non re-entrant

    @pre None

    @param[in]      aSwtID                   Switch index
    @param[in]      aPortID                  Port index
    @param[in]      aSMDetectAction          Station movement
                                             detection action

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully set station movement
                                        detection action
    @retval     #BCM_ERR_TIME_OUT       Timeout occurred while reading/writing
                                        switch register
    @retval     #BCM_ERR_INVAL_PARAMS   (Invalid switch index) or
                                        (Invalid aPortID) or
                                        (Invalid station movement detection
                                        action)
    @retval     #BCM_ERR_NOPERM         CPU port is not available
                                        (Valid only for the action,
                                         redirect to CPU)
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post None

    @trace  #BRCM_SWREQ_ETHSWT_SECURITY

    @limitations None
*/
int32_t ETHSWT_SetStationMovementDetection(ETHSWT_HwIDType aSwtID,
            ETHSWT_PortIDType aPortID,
            ETHSWT_SecurityActionType aSMDetectAction);

/** @brief Get station movement detection(enable/disable) status

    This API retreives switch station movement detection
    informations.

    @behavior Sync, Non re-entrant

    @pre None

    @param[in]      aSwtID                   Switch index
    @param[in]      aPortID                  Port index
    @param[out]     aSMDetectAction          Pointer to station movement
                                             detection action

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully retrieved station movement
                                        detection information information
    @retval     #BCM_ERR_TIME_OUT       Timeout occurred while reading/writing
                                        switch register
    @retval     #BCM_ERR_INVAL_PARAMS   (aSMDetectAction is NULL) or
                                        (Invalid aPortID) or
                                        (Invalid switch index)
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post None

    @trace  #BRCM_SWREQ_ETHSWT_SECURITY

    @limitations None
*/
int32_t ETHSWT_GetStationMovementDetection(ETHSWT_HwIDType aSwtID,
            ETHSWT_PortIDType aPortID,
            ETHSWT_SecurityActionType * const aSMDetectAction);

/** @brief Set address limiting information of the port

    This API sets the maximum number of MAC addresses that are learned on
    the port. Only limits the number of dynamically learned unicast
    MAC addresses. MAC addresses configured by the CPU are not counted
    against the limit. API also sets the action, which will be triggered
    if the count of dynamically learned unicast MAC addresses on this
    port exceeds with the programmed value.

    @behavior Sync, Non re-entrant

    @pre None

    @param[in]      aSwtID                   Switch index
    @param[in]      aPortID                  Port index
    @param[in]      aAddressLimitInfo        Pointer to address limiting
                                             information

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully set address limiting information
                                        for the port
    @retval     #BCM_ERR_TIME_OUT       Timeout occurred while reading/writing
                                        switch register
    @retval     #BCM_ERR_INVAL_PARAMS   (Invalid switch index) or
                                        (Invalid aPortID) or
                                        (Invalid address limit
                                        action or value) or (aAddressLimitInfo
                                        is NULL)
    @retval     #BCM_ERR_NOPERM         CPU port is not available
                                        (Valid only for the action,
                                        redirect to CPU and copy to CPU)
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post None

    @trace  #BRCM_SWREQ_ETHSWT_SECURITY

    @limitations None
*/
int32_t ETHSWT_SetPortAddrLimiting(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID,
        const ETHSWT_AddressLimitingType * const aAddressLimitInfo);

/** @brief Get address limiting information for the port

    This API retreives switch address limiting information
    of the provided port.

    @behavior Sync, Non re-entrant

    @pre None

    @param[in]      aSwtID                   Switch index
    @param[in]      aPortID                  Port index
    @param[out]     aAddressLimitInfo        Pointer to address limiting
                                             action
    @param[out]     aPortLearnedCounter      pointer to the number
                                             of SA MAC addresses
                                             learned on this ports.
                                             This counter can't exceed
                                             the max programmed learning
                                             value of this port
    @param[out]     aPortOverLimitCounter    pointer to the overlimit
                                             counter value of this ports.
                                             This counter is the number of
                                             packets ingress to this port after
                                             port SA learn counter exceeds to
                                             SA learn limit.

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully retrieved address limiting
                                        information of the provided port
    @retval     #BCM_ERR_TIME_OUT       Timeout occurred while reading/writing
                                        switch register
    @retval     #BCM_ERR_INVAL_PARAMS   (Invalid switch index) or
                                        (Invalid aPortID) or
                                        (aAddressLimitInfo is NULL) or
                                        (aPortLearnedCounter is NULL) or
                                        (aPortOverLimitCounter is NULL) or
                                        (invalid PortID)
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post None

    @trace  #BRCM_SWREQ_ETHSWT_SECURITY

    @limitations None
*/
int32_t ETHSWT_GetPortAddrLimitAndCounter(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID,
        ETHSWT_AddressLimitingType * const aAddressLimitInfo,
        uint16_t * const aPortLearnedCounter,
        uint32_t * const aPortOverLimitCounter);


/** @brief Set sticky MAC Address action to the port

    This API sets the sticky MAC Address action to a port.
    If a single MAC address (or a small number of MAC addresses)
    is/are sticky to a port, then any packet arriving with Source
    MAC address which is sticky to that port should only be allowed.
    If the incoming packet is an IEEE 802.1X packet, or special
    frames, the incoming packets are forwarded.

    @behavior Sync, Non re-entrant

    @pre Hardware learning can be disabled.

    @param[in]      aSwtID                   Switch index
    @param[in]      aPortID                  Port index
    @param[in]      aStickyMACAction         Sticky MAC address
                                             action

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully set sticky MAC Address
                                        action to the port
    @retval     #BCM_ERR_TIME_OUT       Timeout occurred while reading/writing
                                        switch register
    @retval     #BCM_ERR_INVAL_PARAMS   (Invalid switch index) or
                                        (Invalid aPortID) or
                                        (Invalid sticky MAC address
                                        action)
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized
    @retval     #BCM_ERR_NOPERM         CPU port is not available
                                        (Valid only for the action,
                                        redirect to CPU)

    @post None

    @trace  #BRCM_SWREQ_ETHSWT_SECURITY

    @limitations None
*/
int32_t ETHSWT_SetMACAddressStickyToPort(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID,
        ETHSWT_SecurityActionType aStickyMACAction);

/** @brief Get sticky MAC Address information to the port

    This API retreives sticky MAC Address information
    of the provided port.

    @behavior Sync, Non re-entrant

    @pre Hardware learning can be disabled.

    @param[in]      aSwtID                   Switch index
    @param[in]      aPortID                  Port index
    @param[out]     aStickyMACAction         Pointer to sticky MAC address
                                             action

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully retrieved sticky MAC
                                        Address information to the port
    @retval     #BCM_ERR_TIME_OUT       Timeout occurred while reading/writing
                                        switch register
    @retval     #BCM_ERR_INVAL_PARAMS   (Invalid switch index) or
                                        (Invalid aPortID) or
                                        (aStickyMACAction is NULL)
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post None

    @trace  #BRCM_SWREQ_ETHSWT_SECURITY

    @limitations None
*/
int32_t ETHSWT_GetMACAddressStickyToPort(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID,
        ETHSWT_SecurityActionType * const aStickyMACAction);

/** @brief Set total MAC-SA limiting control

    This API sets the maximum number of MAC addresses that are learned
    accross all the port. When Address Limit is reached (i.e.,  either
    port-wise limit is reached or overall limit is reached), the subsequent
    actions are controlled by the over limit action field of the corresponding
    port.

    @behavior Sync, Non re-entrant

    @pre None

    @param[in]      aSwtID                   Switch index
    @param[in]      aTotalMACLearningLimit   maximum number of MAC
                                             addresses allowed to
                                             learn across all ports

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully set address limiting information
                                        for the port
    @retval     #BCM_ERR_TIME_OUT       Timeout occurred while reading/writing
                                        switch register
    @retval     #BCM_ERR_INVAL_PARAMS   (Invalid switch index) or
                                        (aTotalMACLearningLimit
                                        is greater than the maximum
                                        ARL table size)
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post None

    @trace  #BRCM_SWREQ_ETHSWT_SECURITY

    @limitations None
*/
int32_t ETHSWT_SetTotalAddrLimit(ETHSWT_HwIDType aSwtID,
        uint16_t aTotalMACLearningLimit);

/** @brief Get total MAC-SA limiting control

    This API retreives total MAC-SA limit accross
    all the port.

    @behavior Sync, Non re-entrant

    @pre None

    @param[in]      aSwtID                   Switch index
    @param[out]     aTotalMACLearningLimit   pointer to maximum
                                             number of MAC
                                             addresses allowed to
                                             learn on all ports
    @param[out]     aTotalLearnedCounter     pointer to the number
                                             of SA MAC addresses
                                             learned on all ports.
                                             This counter can't exceed
                                             the max programmed learning
                                             value across all the port

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully set address limiting information
                                        for the port
    @retval     #BCM_ERR_TIME_OUT       Timeout occurred while reading/writing
                                        switch register
    @retval     #BCM_ERR_INVAL_PARAMS   (Invalid switch index) or
                                        (aTotalMACLearningLimit
                                        is NULL) or (aTotalLearnedCounter
                                        is NULL)
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post None

    @trace  #BRCM_SWREQ_ETHSWT_SECURITY

    @limitations None
*/
int32_t ETHSWT_GetTotalAddrLimitAndCounter(ETHSWT_HwIDType aSwtID,
        uint16_t * const aTotalMACLearningLimit,
        uint16_t * const aTotalLearnedCounter);

#endif /* ETHSWT_ARL_H */

/** @} */
