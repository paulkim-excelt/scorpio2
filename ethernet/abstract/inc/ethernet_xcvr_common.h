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
    @defgroup grp_ethxcvr_common_ifc Ethernet XCVR Interface
    @ingroup grp_ethernet_abstract

    @addtogroup grp_ethxcvr_common_ifc
    @{

    @file ethernet_xcvr_common.h

    @brief Ethernet XCVR Interface
    This file contains the interfaces for the Ethernet XCVR

    @version 1.0 Initial version
*/

#ifndef ETHERNET_XCVR_COMMON_H
#define ETHERNET_XCVR_COMMON_H

/**
    @name Ethernet XCVR API IDs
    @{
    @brief API IDs for Ethernet XCVR
*/
#define BRCM_SWARCH_ETHXCVR_MODE_TYPE            (0x8801U)    /**< @brief #ETHXCVR_ModeType  */
#define BRCM_SWARCH_ETHXCVR_LINKSTATE_TYPE       (0x8802U)    /**< @brief #ETHXCVR_LinkStateType */
#define BRCM_SWARCH_ETHXCVR_SPEED_TYPE           (0x8803U)    /**< @brief #ETHXCVR_SpeedType */
#define BRCM_SWARCH_ETHXCVR_DUPLEXMODE_TYPE      (0x8804U)    /**< @brief #ETHXCVR_DuplexModeType */
#define BRCM_SWARCH_ETHXCVR_BUSMODE_TYPE         (0x8805U)    /**< @brief #ETHXCVR_BusModeType */
#define BRCM_SWARCH_ETHXCVR_FLOWCONTROL_TYPE     (0x8806U)    /**< @brief #ETHXCVR_FlowControlType */
#define BRCM_SWARCH_ETHXCVR_ACCESSMODE_TYPE      (0x8807U)    /**< @brief #ETHXCVR_AccessModeType */
#define BRCM_SWARCH_ETHXCVR_PHYMEDIA_TYPE        (0x8808U)    /**< @brief #ETHXCVR_PhyMediaType */
#define BRCM_SWARCH_ETHXCVR_WAKEUPREASON_TYPE    (0x8809U)    /**< @brief #ETHXCVR_WakeupReasonType */
#define BRCM_SWARCH_ETHXCVR_BOOLEAN_TYPE         (0x880AU)    /**< @brief #ETHXCVR_BooleanType */
#define BRCM_SWARCH_ETHXCVR_AUTONEGSTATUS_TYPE   (0x880BU)    /**< @brief #ETHXCVR_AutoNegStatusType */
/** @} */

/**
    @name ETHXCVR_ModeType
    @{
    @brief Ethernet transceiver mode

    @trace #BRCM_SWREQ_ETHXCVR_COMMON
*/
typedef uint8_t ETHXCVR_ModeType; /**< @brief ETHXCVR_Mode typedef */
#define ETHXCVR_MODE_DOWN    (1U) /**< @brief Transceiver down */
#define ETHXCVR_MODE_ACTIVE  (2U) /**< @brief Transceiver active */
#define ETHXCVR_MODE_ISOLATE (3U) /**< @brief Isolate PHY from MII */
/** @} */

/**
    @name ETHXCVR_LinkStateType
    @{
    @brief Transceiver link status

    @trace #BRCM_SWREQ_ETHXCVR_COMMON
*/
typedef uint8_t ETHXCVR_LinkStateType;    /**< @brief ETHXCVR_LinkState typedef */
#define ETHXCVR_LINKSTATE_DOWN      (1U)  /**< @brief Link down */
#define ETHXCVR_LINKSTATE_ACTIVE    (2U)  /**< @brief Link up */
/** @} */

/**
    @name ETHXCVR_SpeedType
    @{
    @brief Ethernet transceiver speed

    @trace #BRCM_SWREQ_ETHXCVR_COMMON
*/
typedef uint8_t ETHXCVR_SpeedType;       /**< @brief ETHXCVR_Speed typedef */
#define ETHXCVR_SPEED_10MBPS     (0x01U) /**< @brief 10Mbps */
#define ETHXCVR_SPEED_100MBPS    (0x02U) /**< @brief 100Mbps */
#define ETHXCVR_SPEED_1000MBPS   (0x04U) /**< @brief 1000Mbps */
#define ETHXCVR_SPEED_2500MBPS   (0x08U) /**< @brief 2500Mbps */
#define ETHXCVR_SPEED_5000MBPS   (0x10U) /**< @brief 5000Mbps */
#define ETHXCVR_SPEED_VALID_MASK (0x1FU) /**< @brief Mask indicating valid bits */
/** @} */

/**
    @name ETHXCVR_DuplexModeType
    @{
    @brief Transceiver duplex mode

    @trace #BRCM_SWREQ_ETHXCVR_COMMON
*/
typedef uint8_t ETHXCVR_DuplexModeType; /**< @brief ETHXCVR_DuplexMode typedef */
#define ETHXCVR_DUPLEXMODE_HALF (0x1U)  /**< @brief Half duplex */
#define ETHXCVR_DUPLEXMODE_FULL (0x2U)  /**< @brief Full duplex */
/** @} */

/**
    @name ETHXCVR_BusModeType
    @brief Mode of the data bus connecting the MAC and the PHY. It could be
           an MII like bus or an integrated PHY where the bus is not exposed.
    @{
    @trace #BRCM_SWREQ_ETHXCVR_COMMON
*/
typedef uint8_t ETHXCVR_BusModeType;       /**< @brief ETHXCVR_BusModeType typedef */
#define ETHXCVR_BUSMODE_INTG          (1U) /**< @brief Integrated PHY */
#define ETHXCVR_BUSMODE_RGMII         (2U) /**< @brief RGMII bus */
#define ETHXCVR_BUSMODE_RVMII         (3U) /**< @brief RVMII bus */
#define ETHXCVR_BUSMODE_SGMII         (4U) /**< @brief SGMII bus */
#define ETHXCVR_BUSMODE_RMII          (5U) /**< @brief RMII bus */
#define ETHXCVR_BUSMODE_MII           (6U) /**< @brief MII bus */
#define ETHXCVR_BUSMODE_PCIE          (7U) /**< @brief PCIE bus */
/** @} */

/**
    @name ETHXCVR_FlowControlType
    @brief Transceiver Flow control
    This will be the preferred flow control when auto-negotiation is enabled
    @{
    @trace #BRCM_SWREQ_ETHXCVR_COMMON
*/
typedef uint8_t ETHXCVR_FlowControlType;
#define ETHXCVR_FLOWCONTROL_NONE   (0U) /**< @brief No pause */
#define ETHXCVR_FLOWCONTROL_TXONLY (1U) /**< @brief Transmit pause only */
#define ETHXCVR_FLOWCONTROL_TXRX   (2U) /**< @brief Both transmit and receive pause */
#define ETHXCVR_FLOWCONTROL_RXONLY (3U) /**< @brief Receive pause only */
/** @} */

/**
    @name Transceiver access mode
    @brief Access mode for the PHY. Bus is assumed to be integrated and hence
    memory mapped
    @{
    @trace #BRCM_SWREQ_ETHXCVR_COMMON
*/
typedef uint8_t ETHXCVR_AccessModeType; /**< @brief ETHXCVR_AccessModeType typedef */
#define ETHXCVR_ACCESSMODE_MMAP  (1U) /**< @brief Memory mapped access */
#define ETHXCVR_ACCESSMODE_MDIO  (2U) /**< @brief MDIO access */
/** @} */

/**
    @name ETHXCVR_PhyMediaType
    @brief Physical medium for connecting to external world
    @{
    @trace #BRCM_SWREQ_ETHXCVR_COMMON
*/
typedef uint8_t ETHXCVR_PhyMediaType;     /**< @brief ETHXCVR_PhyMediaType typedef */
#define ETHXCVR_PHYMEDIA_NONE        (0U) /**< @brief Invalid */
#define ETHXCVR_PHYMEDIA_10BASET1    (1U) /**< @brief 10Base-T1 */
#define ETHXCVR_PHYMEDIA_10BASET     (2U) /**< @brief 10Base-T */
#define ETHXCVR_PHYMEDIA_100BASET1   (3U) /**< @brief 100Base-T1 */
#define ETHXCVR_PHYMEDIA_100BASETX   (4U) /**< @brief 100Base-TX */
#define ETHXCVR_PHYMEDIA_1000BASET1  (5U) /**< @brief 1000Base-T1 */
#define ETHXCVR_PHYMEDIA_1000BASET   (6U) /**< @brief 1000Base-T */
#define ETHXCVR_PHYMEDIA_1000BASEX   (7U) /**< @brief 1000Base-X */
/** @} */

/**
    @name ETHXCVR_WakeupReasonType
    @brief defines the transceiver wake up reasons
    @{
    @trace #BRCM_SWREQ_ETHXCVR_COMMON
*/
typedef uint8_t ETHXCVR_WakeupReasonType;
#define ETHXCVR_WAKEUPREASON_NONE     (0U) /**< @brief No WakeUp Detected */
#define ETHXCVR_WAKEUPREASON_UNKNOWN  (1U) /**< @brief WakeUp Happend But No wake up reason detected */
#define ETHXCVR_WAKEUPREASON_REMOTE   (2U) /**< @brief WakeUp Request Received From the Remote PHY   */
#define ETHXCVR_WAKEUPREASON_LOCAL    (3U) /**< @brief WakeUp Request Asserted By Local PHY   */
#define ETHXCVR_WAKEUPREASON_POWER_ON (4U) /**< @brief Power on wake up detected   */
#define ETHXCVR_WAKEUPREASON_PIN      (5U) /**< @brief Pin wake up detected        */
/** @} */

/**
    @name ETHXCVR_BooleanType
    @brief Enable/disable for a feature
    @{
    @trace #BRCM_SWREQ_ETHXCVR_COMMON
*/
typedef uint8_t ETHXCVR_BooleanType;
#define ETHXCVR_BOOLEAN_FALSE  (0U) /**< @brief False */
#define ETHXCVR_BOOLEAN_TRUE   (1U) /**< @brief True  */
/** @} */

/**
    @name ETHXCVR_AutoNegStatusType
    @{
    @brief Auto-negotiation status

    @trace #BRCM_SWREQ_ETHXCVR_COMMON
*/
typedef uint8_t ETHXCVR_AutoNegStatusType;          /**< @brief ETHXCVR_AutoNegStatusType typedef */
#define ETHXCVR_AUTONEGSTATUS_COMPLETE      (0x1U) /**< @brief Auto-neg complete */
#define ETHXCVR_AUTONEGSTATUS_INCOMPLETE    (0x2U) /**< @brief Auto-neg incomplete */
#define ETHXCVR_AUTONEGSTATUS_NO_ABILITY    (0x3U) /**< @brief Auto-neg ability not present  */
/** @} */

#endif /* ETHERNET_XCVR_COMMON_H */
/** @} */