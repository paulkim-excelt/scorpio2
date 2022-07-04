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
    @defgroup grp_ethernet_common_ifc Ethernet Common Interface
    @ingroup grp_ethernet_abstract

    @addtogroup grp_ethernet_common_ifc
    @{

    @file ethernet_common.h

    @brief Ethernet Common Interface
    This file contains the interfaces for the Ethernet common

    @version 1.0 Initial version
*/

#ifndef ETHERNET_COMMON_H
#define ETHERNET_COMMON_H

/**
    @name Ethernet Common API IDs
    @{
    @brief API IDs for Ethernet Common
*/
#define BRCM_SWARCH_ETHER_VLANID_TYPE            (0x8501U) /**< @brief #ETHER_VLANIDType  */
#define BRCM_SWARCH_ETHER_RXSTATS_TYPE           (0x8502U) /**< @brief #ETHER_RxStatsType */
#define BRCM_SWARCH_ETHER_TXSTATS_TYPE           (0x8503U) /**< @brief #ETHER_TxStatsType */
#define BRCM_SWARCH_ETHER_MDIOHWID_TYPE          (0x8504U) /**< @brief #ETHER_MDIOHwIDType */
#define BRCM_SWARCH_ETHER_MDIOSLAVEADDR_TYPE     (0x8505U) /**< @brief #ETHER_MDIOSlaveAddrType */
#define BRCM_SWARCH_ETHER_MDIODEVICE_TYPE        (0x8506U) /**< @brief #ETHER_MDIODeviceType */
#define BRCM_SWARCH_ETHER_MDIOREGACCESS_TYPE     (0x8507U) /**< @brief #ETHER_MDIORegAccessType */
#define BRCM_SWARCH_ETHER_MDIOREGADDR_TYPE       (0x8508U) /**< @brief #ETHER_MDIORegAddrType */
#define BRCM_SWARCH_ETHER_MDIOPKT_TYPE           (0x8509U) /**< @brief #ETHER_MDIOPktType */
/** @} */

/**
    @name VLAN ID type
    @{
    @brief 802.1Q VLAN ID type

    VLAN range 0x0 to 4095 where 0x000 and 0xFFF are reserved.

    @trace #BRCM_SWREQ_ETHER
*/
typedef uint16_t ETHER_VLANIDType;       /**< @brief 802.1Q VLAN ID type */
#define ETHER_VLANID_MIN     (1UL)       /**< @brief Minimum VLAN ID */
#define ETHER_VLANID_MAX     (4094UL)    /**< @brief Maximum VLAN ID */
#define ETHER_VLANID_MASK    (0xFFFU)    /**< @brief Mask for VLAN ID */
/** @} */

/**
    @brief Ethernet RX packet statistics

    @trace #BRCM_SWREQ_ETHER
 */
typedef struct sETHER_RxStatsType {
    uint32_t gdPkts;          /**< @brief All good packets */
    uint32_t octetsLow;       /**< @brief Octets low packets */
    uint32_t octetsHigh;      /**< @brief octets high packets */
    uint32_t allPkts;         /**< @brief All good or bad packets */
    uint32_t brdCast;         /**< @brief All good broadcast packets */
    uint32_t mutCast;         /**< @brief All good multicast packets */
    uint32_t uniCast;         /**< @brief All good unicast packets */
    uint32_t pkts64;          /**< @brief All good/bad packets with len < 64 */
    uint32_t pkts65_127;      /**< @brief All good/bad packets with len between
                                    65 to 127 */
    uint32_t pkts128_255;     /**< @brief All good/bad packets with len between
                                    128 to 255 */
    uint32_t pkts256_511;     /**< @brief All good/bad packets with len between
                                    256 to 511 */
    uint32_t pkts512_1023;    /**< @brief All good/bad packets with len between
                                    512 to 1023 */
    uint32_t pkts1024_MAX;    /**< @brief All good/bad packets with len between
                                    1024 and the standard maximum packet size
                                    inclusive */
    uint32_t pkts1024_1522;   /**< @brief All good/bad packets with len between
                                    1024 to 1522 */
    uint32_t pkts1523_2047;   /**< @brief All good/bad packets with len between
                                    1523 to 2047 */
    uint32_t pkts2048_4095;   /**< @brief All good/bad packets with len between
                                    2048 to 4095 */
    uint32_t pkts4096_8191;   /**< @brief All good/bad packets with len between
                                    4095 to 8191 */
    uint32_t pkts8192_MAX;    /**< @brief All good/bad packets with len between
                                    8192 to MAX */
    uint32_t pktsJabber;      /**< @brief All pkts with length>1536 and a bad CRC */
    uint32_t pktsOvrSz;       /**< @brief Rx pkts with length > RX_LENGTH and a
                                    good CRC */
    uint32_t pktsFrag;        /**< @brief All pkts with length < 64 and a bad CRC */
    uint32_t pktsRxDrop;      /**< @brief All pkts that experienced an overrun */
    uint32_t pktsCrcAlignErr; /**< @brief All pkts with a bad CRC or odd number
                                    of nibbles */
    uint32_t pktsUndSz;       /**< @brief All pkts with length < 64 with a good CRC */
    uint32_t pktsCrcErr;      /**< @brief All pkts that did not pass FCS check */
    uint32_t pktsRxDiscard;   /**< @brief All pkts that did not pass FCS check */
    uint32_t rxPause;         /**< @brief Number of PAUSE events */
} ETHER_RxStatsType;

/**
    @brief Ethernet TX packet statistics

    @trace #BRCM_SWREQ_ETHER
 */
typedef struct sETHER_TxStatsType {
    uint32_t octets;               /**< @brief Total number of bytes transmitted */
    uint32_t brdCast;              /**< @brief All good broadcast packets */
    uint32_t mutCast;              /**< @brief All good multicast packets */
    uint32_t uniCast;              /**< @brief All good unicast packets */
    uint32_t txDropped;            /**< @brief All dropped packets */
    uint32_t txDroppedErr;         /**< @brief All packets dropped due to error */
    uint32_t txCollision;          /**< @brief TX collisions */
    uint32_t txCollisionSingle;    /**< @brief Tx single collision */
    uint32_t txCollisionMulti;     /**< @brief Tx Multi collision counter */
    uint32_t txLateCollision;      /**< @brief Tx late collison counter */
    uint32_t txExcessiveCollision; /**< @brief Tx excessive collision counter */
    uint32_t txDeferredTransmit;   /**< @brief Tx deferred transmit counter */
    uint32_t txFrameInDiscard;     /**< @brief Tx deferred transmit counter */
    uint32_t txPause;              /**< @brief Number of PAUSE events */
    uint32_t txQ0;                 /**< @brief Total number of good packets
                                         transmitted on COS0 */
    uint32_t txQ1;                 /**< @brief Total number of good packets
                                         transmitted on COS1 */
    uint32_t txQ2;                 /**< @brief Total number of good packets
                                         transmitted on COS2 */
    uint32_t txQ3;                 /**< @brief Total number of good packets
                                         transmitted on COS3 */
    uint32_t txQ4;                 /**< @brief Total number of good packets
                                         transmitted on COS4 */
    uint32_t txQ5;                 /**< @brief Total number of good packets
                                         transmitted on COS5 */
    uint32_t txQ6;                 /**< @brief Total number of good packets
                                         transmitted on COS6 */
    uint32_t txQ7;                 /**< @brief Total number of good packets
                                         transmitted on COS7 */
    uint32_t pkts64;               /**< @brief All good/bad packets with len < 64 */
    uint32_t pkts65_127;           /**< @brief All good/bad packets with len
                                         between 65 to 127 */
    uint32_t pkts128_255;          /**< @brief All good/bad packets with len
                                         between 128 to 255 */
    uint32_t pkts256_511;          /**< @brief All good/bad packets with len
                                         between 256 to 511 */
    uint32_t pkts512_1023;         /**< @brief All good/bad packets with len
                                         between 512 to 1023 */
    uint32_t pkts1024_MAX;         /**< @brief All good/bad packets with len
                                         between 1024 and the standard maximum
                                         packet size inclusive */
} ETHER_TxStatsType;

/**
    @name ETHER_MDIOHwIDType
    @{
    @brief MDIO controller index type

    @trace #BRCM_SWREQ_ETHER
 */
typedef uint32_t ETHER_MDIOHwIDType;            /**< @brief MDIO controller index type */
/** @} */

/**
    @name ETHER_MDIOSlaveAddrType
    @{
    @brief MDIO Slave Address Type

    @trace #BRCM_SWREQ_ETHER
*/
typedef uint8_t ETHER_MDIOSlaveAddrType;
#define ETHER_MDIOSLAVEADDR_MASK         (0x1FU) /**< @brief MDIO slave address field mask */
#define ETHER_MDIOSLAVEADDR_MAX          (31U)   /**< @brief MDIO slave address max value */
/** @} */

/**
    @name ETHER_MDIODeviceType
    @{
    @brief MDIO Device Type

    @trace #BRCM_SWREQ_ETHER
*/
typedef uint8_t ETHER_MDIODeviceType;
#define ETHER_MDIODEVICETYPE_MASK        (0x1FU) /**< @brief MDIO device type field mask */
#define ETHER_MDIODEVICETYPE_MAX         (31U)   /**< @brief MDIO device type max value */
/** @} */

/**
    @name ETHER_MDIORegAccessType
    @{
    @brief MDIO register access type

    @trace #BRCM_SWREQ_ETHER
 */
typedef uint8_t ETHER_MDIORegAccessType;
#define ETHER_MDIOREGACCESS_CL22       (1U)   /**< @brief MDIO slave CL22 register access */
#define ETHER_MDIOREGACCESS_CL45       (2U)   /**< @brief MDIO slave CL45 register access */
/** @} */

/**
    @name ETHER_MDIORegAddrType
    @{
    @brief MDIO register addres type

    @trace #BRCM_SWREQ_ETHER
 */
typedef uint16_t ETHER_MDIORegAddrType;
#define ETHER_MDIOREGADDR_CL22_MASK     (0x1FUL)    /**< @brief MDIO register address mask for CL22 register access */
#define ETHER_MDIOREGADDR_CL45_MASK     (0xFFFFUL) /**< @brief MDIO register address mask for CL45 register access */
/** @} */

/**
    @brief MDIO transfer packet

    MDIO transfer packet structure.

    @trace #BRCM_SWREQ_ETHER
*/
typedef struct sETHER_MDIOPktType {
    ETHER_MDIOSlaveAddrType slaveAddr;   /**< @brief Device address of the MDIO slave.
                                              This slaveAddr is 5bit address */
    ETHER_MDIODeviceType    deviceType;  /**< @brief Device type */
    ETHER_MDIORegAccessType regAccMode;  /**< @brief Slave register access mode type */
    ETHER_MDIORegAddrType   regAddr;     /**< @brief Slave register address */
    uint16_t regData;                    /**< @brief Data read from slave register
                                              or data to write to slave register */
} ETHER_MDIOPktType;

#endif /* ETHERNET_COMMON_H */
/** @} */