/*****************************************************************************
 Copyright 2017-2022 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_ethswt_ext_ifc Extensions Interface
    @ingroup grp_ethswt

    @addtogroup grp_ethswt_ext_ifc
    @{

    @file ethswt_ext.h
    @brief Application programmer interface for Ethernet Switch Driver (Misc)

    @version 0.51 Imported from docx
 */

#ifndef ETHSWT_EXT_H
#define ETHSWT_EXT_H

#include <compiler.h>
#include <ethswt_common.h>
#include <ethswt_vlan.h>

/**
    @name Ethernet Switch driver API IDs
    @{
    @brief API IDs for Ethernet Switch driver
*/
#define BRCM_SWARCH_ETHSWT_PORT_FIFO_MAX_MACRO          (0x8B01U)    /**< @brief #ETHSWT_PORT_FIFO_MAX            */
#define BRCM_SWARCH_ETHSWT_SCHED_ALGO_TYPE              (0x8B02U)    /**< @brief #ETHSWT_SchedAlgoType            */
#define BRCM_SWARCH_ETHSWT_PORT_SCH_TYPE                (0x8B03U)    /**< @brief #ETHSWT_PortSchType              */
#define BRCM_SWARCH_ETHSWT_PORT_SHAPER_CFG_TYPE         (0x8B04U)    /**< @brief #ETHSWT_ShaperCfgType            */
#define BRCM_SWARCH_ETHSWT_PORT_SHAPER_CONFIG_PROC      (0x8B05U)    /**< @brief #ETHSWT_PortShaperConfig         */
#define BRCM_SWARCH_ETHSWT_FIFO_CFG_TYPE                (0x8B06U)    /**< @brief #ETHSWT_FifoCfgType              */
#define BRCM_SWARCH_ETHSWT_PORT_RATE_POLICER_TYPE       (0x8B07U)    /**< @brief #ETHSWT_PortPolicerActType       */
#define BRCM_SWARCH_ETHSWT_PACKET_TYPE                  (0x8B08U)    /**< @brief #ETHSWT_PolicerPacketFlgMaskType */
#define BRCM_SWARCH_ETHSWT_PORT_POLICER_CFG_TYPE        (0x8B09U)    /**< @brief #ETHSWT_PortPolicerCfgType       */
#define BRCM_SWARCH_ETHSWT_PORT_MAC_ENTRY_MAX_MACRO     (0x8B0AU)    /**< @brief #ETHSWT_PORT_MAC_ENTRY_MAX       */
#define BRCM_SWARCH_ETHSWT_PORT_VLAN_ENTRY_MAX_MACRO    (0x8B0BU)    /**< @brief #ETHSWT_PORT_VLAN_ENTRY_MAX      */
#define BRCM_SWARCH_ETHSWT_PORT_INGRESS_CFG_TYPE        (0x8B0CU)    /**< @brief #ETHSWT_PortIngressCfgType       */
#define BRCM_SWARCH_ETHSWT_PORT_EGRESS_CFG_TYPE         (0x8B0DU)    /**< @brief #ETHSWT_PortEgressCfgType        */
#define BRCM_SWARCH_ETHSWT_PORT_CFG_TYPE                (0x8B0EU)    /**< @brief #ETHSWT_PortCfgType              */
#define BRCM_SWARCH_ETHSWT_CFG_TYPE                     (0x8B0FU)    /**< @brief #ETHSWT_CfgType                  */
#define BRCM_SWARCH_ETHSWT_EXT_CONFIG_PROC              (0x8B10U)    /**< @brief #ETHSWT_ExtConfigure             */
#define BRCM_SWARCH_ETHSWT_PORT_SECURITY_CFG_TYPE       (0x8B11U)    /**< @brief #ETHSWT_PortSecurityCfgType      */
#define BRCM_SWARCH_ETHSWT_GLOBAL_SECURITY_CFG_TYPE     (0x8B12U)    /**< @brief #ETHSWT_GlobalSecurityCfgType    */
/** @} */

/**
    @brief Maximum number of QoS FIFO per port

    @trace #BRCM_SWREQ_ETHSWT_EXT
*/
#define ETHSWT_PORT_FIFO_MAX                    (8UL)

/**
    @name Port scheduler type
    @{
    @brief Port scheduler type

    @trace #BRCM_SWREQ_ETHSWT_EXT
*/
typedef uint8_t ETHSWT_SchedAlgoType;   /**< @brief Port scheduler type */
#define ETHSWT_SCHED_ALGO_SP  (0U)      /**< @brief Strict priority scheduler */
#define ETHSWT_SCHED_ALGO_WRR (1U)      /**< @brief Weighted round robin
                                                    scheduler */
#define ETHSWT_SCHED_ALGO_DRR (2U)      /**< @brief Deficit round robin
                                                    scheduler */
/** @} */

/**
    @brief Port scheduler type

    @trace #BRCM_SWREQ_ETHSWT_EXT
*/
typedef struct COMP_PACKED sETHSWT_PortSchType {
    ETHSWT_SchedAlgoType algo[ETHSWT_PORT_FIFO_MAX];   /**< @brief Array of
                                                    scheduler algorithm type for
                                                    all port FIFOs.
                                                    @note Not all possible
                                                    combinations of scheduler
                                                    configurations are
                                                    supported. Refer to @ref
                                                    sec_ref_trm for the list of
                                                    supported scheduler
                                                    configurations. */
} ETHSWT_PortSchType;

/**
    @brief Port shaper configuration

    @trace #BRCM_SWREQ_ETHSWT_EXT
*/
typedef struct sETHSWT_ShaperCfgType {
    uint32_t rateBps;           /**< @brief Increase in credit in bits per
                                        second (shall be multiple of 64000) */
    uint32_t burstBytes;        /**< @brief Bucket size in bytes (shall be a
                                        multiple of 64). */
    uint32_t avbShapingModeEn;  /**< @brief Enable AVB shaping mode. */
} ETHSWT_ShaperCfgType;

/**
    @brief FIFO configuration in egress port

    @trace #BRCM_SWREQ_ETHSWT_EXT
*/
typedef struct COMP_PACKED sETHSWT_FifoCfgType {
    uint32_t id;                    /**< @brief Index of FIFO */
    uint32_t minLen;                /**< @brief FIFO minimum length in bytes
                                            (guaranteed size of FIFO) */
    ETHSWT_TCType tc;               /**< @brief Traffic class assigned to this
                                            FIFO. */
    ETHSWT_ShaperCfgType shaper;    /**< @brief Shaper configuration. Queue shaper
                                            is configured by ETHSWT_ShaperCfgType::rateBps
                                            and ETHSWT_ShaperCfgType::burstBytes. A
                                            non-zero value of rateBps and burstBytes
                                            enables queue shaper.
                                            Additionally, AVB shaper is enabled/disabled
                                            by ETHSWT_ShaperCfgType::avbShapingModeEn */
} ETHSWT_FifoCfgType;

/**
    @name Port policer action type
    @{
    @brief Port policer action type

    Action to be taken by the switch when rate violation happens on the port.

    @trace #BRCM_SWREQ_ETHSWT_EXT
*/
typedef uint32_t ETHSWT_PortPolicerActType;          /**< @brief Port policer action
                                                                type */
#define ETHSWT_PORT_RATE_POLICER_BLOCK_SRC     (1UL) /**< @brief Block the source
                                                                (using MAC flow control:
                                                                Pause frame) on rate
                                                                violation */
#define ETHSWT_PORT_RATE_POLICER_DROP_PKT      (2UL) /**< @brief Drop the packet on
                                                                rate violation */
/** @} */

/**
    @name Ingress port policer flags
    @{
    @brief Ingress port policer flags

    @trace #BRCM_SWREQ_ETHSWT_EXT
*/
typedef uint32_t ETHSWT_PolicerPacketFlgMaskType;       /**< @brief  Policer flags
                                                                type */
#define ETHSWT_PACKET_UNICAST_LOOKUP_HIT       (0x1UL)  /**< @brief Packet unicast
                                                                look-up hit */
#define ETHSWT_PACKET_MULTICAST_LOOKUP_HIT     (0x2UL)  /**< @brief Packet multicast
                                                                look-up hit */
#define ETHSWT_PACKET_RES_MULTICAST_LOOKUP_HIT (0x4UL)  /**< @brief Packet reserved
                                                                multicast look-up hit */
#define ETHSWT_PACKET_BROADCAST_LOOUP_HIT      (0x8UL)  /**< @brief Packet broadcast
                                                                look-up hit */
#define ETHSWT_PACKET_MULTICAST_LOOKUP_FAILED  (0x10UL) /**< @brief Packet multicast
                                                                look-up failed */
#define ETHSWT_PACKET_UNICAST_LOOKUP_FAILED    (0x20UL) /**< @brief Packet unicast
                                                                look-up failed */
/** @} */

/**
    @brief Port policer configuration

    @trace #BRCM_SWREQ_ETHSWT_EXT
*/
typedef struct COMP_PACKED sETHSWT_PortPolicerCfgType{
    ETHSWT_PolicerPacketFlgMaskType pktMask;    /**< @brief Port policer packet
                                                        flag type (bit mask value
                                                        of the packet types on
                                                        which this policer is to be
                                                        applied). */
    uint32_t rateByteCount;                     /**< @brief Amount of the data
                                                        (excluding header) which
                                                        can be received on this
                                                        port in given time
                                                        (rateTimeInterval) */
    uint32_t rateTimeInterval;                  /**< @brief Time interval in
                                                        seconds where configured
                                                        bytes can be received
                                                        without a rate limitation. */
    ETHSWT_PortPolicerActType action;         /**< @brief Action to be taken
                                                        by the switch in case of
                                                        the rate violation. */
} ETHSWT_PortPolicerCfgType;

/**
    @brief Maximum number of MAC entries per port

    @trace #BRCM_SWREQ_ETHSWT_EXT
*/
#define ETHSWT_PORT_MAC_ENTRY_MAX               (16UL)

/**
    @brief Maximum number of VLAN entries per port

    @trace #BRCM_SWREQ_ETHSWT_EXT
*/
#define ETHSWT_PORT_VLAN_ENTRY_MAX              (16UL)

/**
    @brief Port ingress configuration

    @trace #BRCM_SWREQ_ETHSWT_EXT
*/
typedef struct COMP_PACKED sETHSWT_PortIngressCfgType {
    ETHER_VLANIDType           defaultVLAN;        /**< @brief Default VLAN for
                                                        this port. For more detail
                                                        refer @ref
                                                        eth_switch_port_forward_config
                                                        "Ingress config" */
    ETHSWT_PCPType              defaultPrio;        /**< @brief Default priority of
                                                        the VLAN. For more detail
                                                        refer @ref
                                                        eth_switch_port_forward_config
                                                        "Ingress config" */
    uint32_t                    dropUntagged;       /**< @brief If default VLAN is
                                                        not configured and this is
                                                        set to TRUE, all the
                                                        untagged frames shall be
                                                        dropped in this port.
                                                        For more detail refer @ref
                                                        eth_switch_port_forward_config
                                                        "Ingress config" */
    ETHSWT_TCType               tc;                 /**< @brief Port traffic class.
                                                        If configured, all
                                                        the ingress packet on this
                                                        port shall be assinged this
                                                        traffic class. If set to
                                                        #ETHSWT_TC_INVALID, no
                                                        traffic class based
                                                        assignment shall be done on
                                                        this port. */
    uint32_t                    policerEn;          /**< @brief Enable/disable
                                                        policer.
                                                        @note This parameter is
                                                        not supported by driver.
                                                        */
    ETHSWT_PortPolicerCfgType   policer;            /**< @brief Port policer
                                                        configurations.
                                                        @note This parameter is
                                                        not supported by driver.
                                                        */
    ETHSWT_TCType               pcp2tcMap[8UL];     /**< @brief PCP to traffic class
                                                        map. */
} ETHSWT_PortIngressCfgType;

/**
    @brief Port egress configuration

    @trace #BRCM_SWREQ_ETHSWT_EXT
*/
typedef struct COMP_PACKED sETHSWT_PortEgressCfgType {

    ETHSWT_FifoCfgType  fifoList[ETHSWT_PORT_FIFO_MAX]; /**< @brief
                                                            Configuration of port FIFOs. */
    uint32_t            fifoListSz;         /**< @brief Size of fifoList. */
    ETHSWT_PortSchType  scheduler;          /**< @brief Port scheduler */
    uint32_t            pcpRemarkEn;        /**< @brief Enable/disable PCP
                                                    remarking */
    ETHSWT_PCPType      tc2pcpMap[8UL];     /**< @brief Traffic class to PCP map
                                                 @note If pcpRemarkEn is set as false,
                                                 all instances of this
                                                 sub-element are ignored.
                                                 However if pcpRemarkEn is set
                                                 as TRUE, exactly 8 instances of
                                                 tc2pcpMap field shall be
                                                 provided, in the order of
                                                 TC0, TC1, … TC7. */
    ETHSWT_ShaperCfgType portShaper;        /**< @brief Shaper configuration. Port shaper
                                                 is configured by ETHSWT_ShaperCfgType::rateBps
                                                 and ETHSWT_ShaperCfgType::burstBytes. A
                                                 non-zero value of rateBps and burstBytes
                                                 enables port shaper.
                                                 Additionally, AVB shaper is enabled/disabled
                                                 by ETHSWT_ShaperCfgType::avbShapingModeEn */
} ETHSWT_PortEgressCfgType;

/**
    @brief Port security configuration

    @trace #BRCM_SWREQ_ETHSWT_KERNEL_INTERFACE
*/
typedef struct COMP_PACKED sETHSWT_PortSecurityCfgType {
    ETHSWT_AddressLimitingType addressLimit;     /**< @brief Address limiting config */
    ETHSWT_SecurityActionType  stickyMACAction;  /**< @brief Indicates the actions
                                                       after receiving packet with
                                                       source MAC address, which is
                                                       not sticky to this port, If
                                                       this field is non-zero otherwise
                                                       sticky MAC address feature
                                                       is disabled for this port. */
    ETHSWT_SecurityActionType  stationMoveAction;
                                                 /**< @brief Action after detecting
                                                       the station movement, If this
                                                       field is non-zero otherwise
                                                       station movement detection feature
                                                       is disabled for this port. */
} ETHSWT_PortSecurityCfgType;

/**
    @brief Port configuration

    @trace #BRCM_SWREQ_ETHSWT_EXT
*/
typedef struct COMP_PACKED sETHSWT_PortCfgType {
    uint32_t portID;            /**< @brief Port Index */
    ETHSWT_PortType role;       /**< @brief Port role */
    uint32_t xcvrID;            /**< @brief Index of transceiver connected to
                                     this port */
    uint32_t enableTimeStamp;   /**< @brief Enable or disable timestamp support*/
    uint32_t enableJumboFrm;    /**< @brief Enable jumbo frames support on this
                                     port. */
    uint8_t fixedMacAddrList[ETHSWT_PORT_MAC_ENTRY_MAX][6UL];  /**< @brief
                                     Fixed MAC address which can be reached from
                                     this port */
    uint32_t macAddrListSz;     /**< @brief Size of the MAC address list */
    ETHSWT_VLANMemberCfgType vlanMemList[ETHSWT_PORT_VLAN_ENTRY_MAX];/**<
                                     @brief VLAN membership list of this port.*/
    uint32_t vlanMemListSz;     /**< @brief Size of the VLAN membership list */
    ETHSWT_PortIngressCfgType  ingressCfg;
                                /**< @brief Port ingress configuration */
    ETHSWT_PortEgressCfgType   egressCfg;
                                /**< @brief Port egress configuration */
    ETHSWT_PortSecurityCfgType securityCfg;
                                /**< @brief Security configuration */
} ETHSWT_PortCfgType;

/**
    @brief Global security configuration across ports
    @trace #BRCM_SWREQ_ETHSWT_KERNEL_INTERFACE
*/
typedef struct COMP_PACKED sETHSWT_GlobalSecurityCfgType {
    ETHSWT_SecurityActionType     vlanHoppingAction;
                                             /**< @brief Action after detecting
                                                   Invalid double-tagged-packet,
                                                   If this field is non-zero otherwise
                                                   Invalid double-tagged-packet
                                                   detection feature is disabled
                                                   for this port. */
    uint16_t                      totalMACLearningLimit;
                                             /**< @brief Total count of dynamically
                                                  learned unicast MAC addresses
                                                  across all the ports. The limit is
                                                  capped at the #ETHSWT_ARL_SIZE.*/
} ETHSWT_GlobalSecurityCfgType;

/**
    @brief Ethernet switch configuration

    @trace #BRCM_SWREQ_ETHSWT_EXT
*/
typedef struct COMP_PACKED sETHSWT_CfgType {
    ETHSWT_PortCfgType portCfgList[ETHSWT_PORT_ID_MAX]; /**< @brief
                                         Configuration list for Switch ports */
    uint32_t portCfgListSz;         /**< @brief Size of the port configuration
                                         list (portCfgList). */
    ETHSWT_GlobalSecurityCfgType globalSecurityCfg;
                                    /**< @brief Security configuration
                                         across port */
    ETHSWT_BrcmHdrModeType brcmHdrMode; /**< @brief IMP Broadcom header mode */
    ETHSWT_SwitchType switchType;   /**< @brief Type of switch w.r.t to
                                         operation */
} ETHSWT_CfgType;

/** @brief Configure Port Shaper

    This API configures the port shaper

    @behavior Sync, Re-entrant (for different switch index)

    @pre TBD

    @param[in]      aSwtID      Switch index
    @param[in]      aPortID     Port index
    @param[in]      aShaperCfg  Pointer to shaper configuration

    @return     void

    @post TBD

    @trace  #BRCM_SWREQ_ETHSWT_EXT

    @limitations None
*/
void ETHSWT_PortShaperConfig(ETHSWT_HwIDType aSwtID,
                             ETHSWT_PortIDType aPortID,
                             const ETHSWT_ShaperCfgType *const aShaperCfg);

/** @brief Initliaze Ethernet switch driver

    This API initializes Ethernet switch driver with given configuration
    parameters.

    @behavior Sync, Re-entrant (for different switch index)

    @pre TBD

    @param[in]      aSwtID      Switch index
    @param[in]      aConfig     Pointer to switch configuration

    @return     void

    @post TBD

    @trace  #BRCM_SWREQ_ETHSWT_EXT

    @limitations This API doesn’t perform reset of switch. Switch port are
    enabled by system before initialization of switch driver.
*/
void ETHSWT_ExtConfigure(ETHSWT_HwIDType aSwtID,
            const ETHSWT_CfgType *const aConfig);

#endif /* ETHSWT_EXT_H */

/** @} */
