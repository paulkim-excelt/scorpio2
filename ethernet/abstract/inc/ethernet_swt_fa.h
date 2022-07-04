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
    @defgroup grp_ethernet_swt_fa_ifc Switch FA abstract Interface
    @ingroup grp_ethernet_abstract

    @addtogroup grp_ethernet_swt_fa_ifc
    @{

    @file ethswtm_abs_fa.h

    @brief FA Interface
    This file contains the interfaces for the Ethernet abstract for FA

    @version 1.0 Initial version
*/

#ifndef ETHSWT_ABSTRACT_FA_H
#define ETHSWT_ABSTRACT_FA_H

#include <module_msg.h>
#include <ethernet_common.h>
#include <mcu.h>

/**
    @name Ethernet Service FA API IDs
    @{
    @brief API IDs for FA in Ethernet Service
*/
#define BRCM_SWARCH_ETHSWT_FACMDID_TYPE               (0x8A01U)    /**< @brief #ETHSWT_FACmdIdType         */
#define BRCM_SWARCH_ETHSWT_FAASYNCEVENT_TYPE          (0x8A02U)    /**< @brief #ETHSWT_FAAsyncEventType    */
#define BRCM_SWARCH_ETHSWT_FAFLOWOPERATION_TYPE       (0x8A03U)    /**< @brief #ETHSWT_FAFlowOperationType */
#define BRCM_SWARCH_ETHSWT_FAMACOPERATION_TYPE        (0x8A04U)    /**< @brief #ETHSWT_FAMacOperationType  */
#define BRCM_SWARCH_ETHSWT_FAMACSNAPSHOT_TYPE         (0x8A05U)    /**< @brief #ETHSWT_FAMacSnapshotType   */
#define BRCM_SWARCH_ETHSWT_FAATTRIBUTE_TYPE           (0x8A06U)    /**< @brief #ETHSWT_FAAttributeType     */
#define BRCM_SWARCH_ETHSWT_FAFLOWSTATUSDATA_TYPE      (0x8A07U)    /**< @brief #ETHSWT_FAFlowStatusDataType*/
#define BRCM_SWARCH_ETHSWT_FASTATS_TYPE               (0x8A08U)    /**< @brief #ETHSWT_FAStatsType         */
#define BRCM_SWARCH_ETHSWT_FAFLOWDATA_TYPE            (0x8A09U)    /**< @brief #ETHSWT_FAFlowDataType      */
#define BRCM_SWARCH_ETHSWT_FAMACGROUP_TYPE            (0x8A0AU)    /**< @brief #ETHSWT_FAMacGroupType      */
#define BRCM_SWARCH_ETHSWT_FAFLOWID_TYPE              (0x8A0BU)    /**< @brief #ETHSWT_FAFlowIDType        */
#define BRCM_SWARCH_ETHSWT_FAINTRFLAGS_TYPE           (0x8A0CU)    /**< @brief #ETHSWT_FAIntrFlagsType     */
#define BRCM_SWARCH_ETHSWT_FAOPERATION_TYPE           (0x8A0DU)    /**< @brief #ETHSWT_FAOperationType     */
#define BRCM_SWARCH_ETHSWT_FAFLAGS_TYPE               (0x8A0EU)    /**< @brief #ETHSWT_FAFlagsType         */
#define BRCM_SWARCH_ETHSWT_FAFLOWVALID_TYPE           (0x8A0FU)    /**< @brief #ETHSWT_FAFlowValidType     */
#define BRCM_SWARCH_ETHSWT_FAMATCH_TYPE               (0x8A10U)    /**< @brief #ETHSWT_FAMatchType         */
#define BRCM_SWARCH_ETHSWT_FAREMAPDATA_TYPE           (0x8A11U)    /**< @brief #ETHSWT_FARemapDataType     */
#define BRCM_SWARCH_ETHSWT_FAMACADDRINFO_TYPE         (0x8A12U)    /**< @brief #ETHSWT_FAMacAddrInfoType   */
#define BRCM_SWARCH_ETHSWT_FAFLOWSTATS_TYPE           (0x8A13U)    /**< @brief #ETHSWT_FAFlowStatsType     */
#define BRCM_SWARCH_ETHSWT_FACTFMODE_TYPE             (0x8A14U)    /**< @brief #ETHSWT_FACtfModeType       */
#define BRCM_SWARCH_ETHSWT_FACRC_TYPE                 (0x8A15U)    /**< @brief #ETHSWT_FACrcType           */
#define BRCM_SWARCH_ETHSWT_FACTFCFG_TYPE              (0x8A16U)    /**< @brief #ETHSWT_FACtfCfgType        */
#define BRCM_SWARCH_ETHSWT_FAMSGUNION_TYPE            (0x8A17U)    /**< @brief #ETHSWT_FAMsgUnionType      */
#define BRCM_SWARCH_ETHSWT_FAHOSTCONTEXT_TYPE         (0x8A18U)    /**< @brief #ETHSWT_FAHostContextType   */
#define BRCM_SWARCH_ETHSWT_FAHOSTCONTEXTSETUP_PROC    (0x8A19U)    /**< @brief #ETHSWT_FAHostContextSetup  */
#define BRCM_SWARCH_ETHSWT_FAHOSTCONTEXTPROCESS_PROC  (0x8A1AU)    /**< @brief #ETHSWT_FAHostContextProcess*/
#define BRCM_SWARCH_ETHSWT_FA_MAX_PAYLOAD_SIZE_MACRO  (0x8A1BU)    /**< @brief #ETHSWT_FA_MAX_PAYLOAD_SIZE */
/** @} */

/**
    @brief Maximum size of FA command payload in bytes

    @trace #BRCM_SWREQ_ETHSWT
*/
#define ETHSWT_FA_MAX_PAYLOAD_SIZE     (160UL)

/**
    @name Switch FA command IDs
    @{
    @brief Switch FA command IDs group

    @trace #BRCM_SWREQ_ETHSWT
*/
typedef uint8_t ETHSWT_FACmdIdType;               /**< @brief EXT command message Type                                     */
#define ETHSWT_FACMDID_FLOW_ADD           (0xD0U) /**< @brief #ETHSWT_FAFlowOperationType       #ETHSWT_FAFlowAdd          */
#define ETHSWT_FACMDID_FLOW_DELETE        (0xD1U) /**< @brief #ETHSWT_FAFlowOperationType       #ETHSWT_FAFlowDelete       */
#define ETHSWT_FACMDID_FLOW_GET           (0xD2U) /**< @brief #ETHSWT_FAFlowOperationType       #ETHSWT_FAFlowGet          */
#define ETHSWT_FACMDID_STATS              (0xD3U) /**< @brief #ETHSWT_FAStatsType               #ETHSWT_FAStats            */
#define ETHSWT_FACMDID_MAC_SNAPSHOT       (0xD4U) /**< @brief #ETHSWT_FAMacSnapshotType         #ETHSWT_FAMacPoolGet
                                                                                                #ETHSWT_GetARLMyDASnapshot */
#define ETHSWT_FACMDID_MAC_ADD            (0xD5U) /**< @brief #ETHSWT_FAMacOperationType        #ETHSWT_FAMacAdd
                                                                                                #ETHSWT_AddARLMyDAEntry    */
#define ETHSWT_FACMDID_MAC_DELETE         (0xD6U) /**< @brief #ETHSWT_FAMacOperationType        #ETHSWT_FAMacDelete
                                                                                                #ETHSWT_DeleteARLMyDAEntry */
#define ETHSWT_FACMDID_FLOW_STATUS        (0xD7U) /**< @brief #ETHSWT_FAFlowStatusDataType      #ETHSWT_FAStats            */
#define ETHSWT_FACMDID_INTERRUPT_ENABLE   (0xD8U) /**< @brief #ETHSWT_FAIntrFlagsType           #ETHSWT_FAEnableInterrupt  */
#define ETHSWT_FACMDID_RESET              (0xD9U) /**< @brief #ETHSWT_FACtfCfgType              #ETHSWT_FADeinit           */
#define ETHSWT_FACMDID_START              (ETHSWT_FACMDID_FLOW_ADD)
#define ETHSWT_FACMDID_END                (ETHSWT_FACMDID_RESET)
/** @} */

/**
    @name ETHSWT_FAAsyncEventType
    @{
    @brief ETHSWTM FA Asynchronous event type

    Event generated asynchronously by target

    @trace #BRCM_SWREQ_ETHSWT
*/
typedef uint8_t ETHSWT_FAAsyncEventType;
#define ETHSWT_FAASYNCEVENT_INTERRUPT     (0x0U)  /**< @brief FA interrupt event */
/** @} */

/**
    @name ETHSWT_FAFlowIDType
    @{
    @brief Flow Identifier

    @trace #BRCM_SWREQ_ETHSWT
*/
typedef uint32_t ETHSWT_FAFlowIDType;
#define ETHSWT_FAFLOWID_RSVD_MASK    (0xFF000000UL)
#define ETHSWT_FAFLOWID_RSVD_SHIFT   (24UL)
#define ETHSWT_FAFLOWID_GROUP_MASK   (0x00FF0000UL)
#define ETHSWT_FAFLOWID_GROUP_SHIFT  (16UL)
#define ETHSWT_FAFLOWID_FLOW_MASK    (0x0000FFFFUL)
#define ETHSWT_FAFLOWID_FLOW_SHIFT   (0UL)
/** @} */

/**
    @name ETHSWT_FAAttributeType
    @{
    @brief ETHSWTM FA flow attributes

    Attributes of the flow for which a bitmask is being queried

    @trace #BRCM_SWREQ_ETHSWT
*/
typedef uint32_t ETHSWT_FAAttributeType;
#define ETHSWT_FAATTRIBUTE_ACTIVE    (1UL) /**< @brief Active mask */
#define ETHSWT_FAATTRIBUTE_STATIC    (2UL) /**< @brief Static mask */
#define ETHSWT_FAATTRIBUTE_MAC_USE   (3UL) /**< @brief MAC address usage mask */
/** @} */

/**
    @brief ETHSWTM FA Flow Status Type

    Structure to retrieve flow status corresponding to attribute

    @trace #BRCM_SWREQ_ETHSWT
*/
typedef struct COMP_PACKED sETHSWT_FAFlowStatusDataType {
    uint8_t mask[ETHSWT_FA_FLOWS_MAX / 8UL]; /**< @brief bitmask of flows
                                                  satisfying the attribute */
    ETHSWT_FAAttributeType attribute;        /**< @brief Attributes of mask */
    MCU_DeviceType mstSlvDevice;             /**< @brief 0: Master, 1: Slave-1, 2: Slave-2 */
    uint8_t mac[6UL];                        /**< @brief MAC address */
    uint8_t rsvd[2];                         /**< @brief Reserved */
} ETHSWT_FAFlowStatusDataType;

/**
    @name ETHSWT_FAIntrFlagsType
    @{
    @brief Interrupt flags type

    @trace #BRCM_SWREQ_ETHSWT
*/
typedef uint32_t ETHSWT_FAIntrFlagsType;
#define ETHSWT_FAINTRFLAGS_EDIT_BH         (0x00000001UL) /**< @brief Broadcom header edit invalid */
#define ETHSWT_FAINTRFLAGS_IPV4_CHECKSUM   (0x00000002UL) /**< @brief Checksum error detected on incoming IPv4 frame */
#define ETHSWT_FAINTRFLAGS_PARSE_L3        (0x00000004UL) /**< @brief Parsing did not complete during l3 stage */
#define ETHSWT_FAINTRFLAGS_PARSE_L2        (0x00000008UL) /**< @brief Parsing did not complete during l2 stage */
#define ETHSWT_FAINTRFLAGS_PARSE_BH        (0x00000010UL) /**< @brief Parsing did not complete during brcm header stage */
#define ETHSWT_FAINTRFLAGS_OVERFLOW_HWQ    (0x00000020UL) /**< @brief HW queue overflow */
#define ETHSWT_FAINTRFLAGS_OVERFLOW_HB     (0x00000040UL) /**< @brief Header buffer overflow */
#define ETHSWT_FAINTRFLAGS_OVERFLOW_RXQ    (0x00000080UL) /**< @brief RXQ buffer overflow */
#define ETHSWT_FAINTRFLAGS_SOP_EOP         (0x00000100UL) /**< @brief Sop/Eop error */
#define ETHSWT_FAINTRFLAGS_OVERFLOW_SPB    (0x00000200UL) /**< @brief Split buffer overflow */
#define ETHSWT_FAINTRFLAGS_OVERFLOW_LAB    (0x00000400UL) /**< @brief Latency buffer overflow */
#define ETHSWT_FAINTRFLAGS_INTERNAL_MERGE  (0x00000800UL) /**< @brief Merge error */
#define ETHSWT_FAINTRFLAGS_OVERFLOW_TXQ    (0x00001000UL) /**< @brief Tx queue overflow error */
#define ETHSWT_FAINTRFLAGS_OVERFLOW_RSV    (0x00002000UL) /**< @brief RSV buffer overflow error */
#define ETHSWT_FAINTRFLAGS_COR_HB          (0x00004000UL) /**< @brief Correctable ECC error has been detected in the header buffer */
#define ETHSWT_FAINTRFLAGS_COR_HWQ_1       (0x00008000UL) /**< @brief Correctable ECC error has been detected in the HWQ buffer */
#define ETHSWT_FAINTRFLAGS_COR_HWQ_0       (0x00010000UL) /**< @brief Correctable ECC error has been detected in the HWQ buffer */
#define ETHSWT_FAINTRFLAGS_COR_LAB         (0x00020000UL) /**< @brief Correctable ECC error has been detected in the latency buffer */
#define ETHSWT_FAINTRFLAGS_COR_NAPT_FLOW   (0x00040000UL) /**< @brief Correctable ECC error has been detected in the napt flow table */
#define ETHSWT_FAINTRFLAGS_COR_NEXT_HOP    (0x00080000UL) /**< @brief Correctable ECC error has been detected in the next hop table */
#define ETHSWT_FAINTRFLAGS_UNCOR_HB        (0x00100000UL) /**< @brief Uncorrectable ECC error has been detected in the header buffer */
#define ETHSWT_FAINTRFLAGS_UNCOR_HWQ_1     (0x00200000UL) /**< @brief Uncorrectable ECC error has been detected in the HWQ buffer */
#define ETHSWT_FAINTRFLAGS_UNCOR_HWQ_0     (0x00400000UL) /**< @brief Uncorrectable ECC error has been detected in the HWQ buffer */
#define ETHSWT_FAINTRFLAGS_UNCOR_LAB       (0x00800000UL) /**< @brief Uncorrectable ECC error has been detected in the latency buffer */
#define ETHSWT_FAINTRFLAGS_UNCOR_NAPT_FLOW (0x01000000UL) /**< @brief Uncorrectable ECC error has been detected in the napt flow table */
#define ETHSWT_FAINTRFLAGS_UNCOR_NEXT_HOP  (0x02000000UL) /**< @brief Uncorrectable ECC error has been detected in the next hop table */
/** @} */

/**
    @name ETHSWT_FAStatsType

    @brief Statistics type

    @note  Some of the counters are cleared upon read and hence the client is
           expected to accumulate them and then present to application or host.

    @trace #BRCM_SWREQ_ETHSWT
*/
typedef struct COMP_PACKED sETHSWT_FAStatsType {
    uint32_t hit;               /**< @brief Count of hits- clear-on-read */
    uint32_t miss;              /**< @brief Count of misses- clear-on-read */
    uint32_t snapFail;          /**< @brief Count of SNAP failures- clear-on-read */
    uint32_t etypeFail;         /**< @brief Count of etype failures- clear-on-read */
    uint32_t versionFail;       /**< @brief Count of version failures- clear-on-read */
    uint32_t fragFail;          /**< @brief Count of fragmentation failures- clear-on-read */
    uint32_t protocolFail;      /**< @brief Count of UDP/TCP protocol failures- clear-on-read */
    uint32_t checksumFail;      /**< @brief Count of IPv4 checksum failures- clear-on-read */
    uint32_t optionsFail;       /**< @brief Count of IPv4 option failures- clear-on-read */
    uint32_t headerLengthFail;  /**< @brief Count of IPv4 header length failures- clear-on-read */
    ETHSWT_FAIntrFlagsType intrFlags; /**< @brief Interrupt flags */
    uint32_t flowTableUsage;    /**< @brief Number of entries used in Flow Table */
    uint32_t poolTableUsage;    /**< @brief Number of entries used in Pool Table */
    uint32_t nextHopTableUsage; /**< @brief Number of entries used in Next-Hop Table */
    uint32_t currentTimestamp;  /**< @brief Current timestamp */
} ETHSWT_FAStatsType;

/**
    @name ETHSWT_FAOperationType

    @brief Operation to be performed on the L2 header

    @trace #BRCM_SWREQ_ETHSWT
    @{
*/
typedef uint8_t ETHSWT_FAOperationType;
#define ETHSWT_FAOPERATION_S_TAG      (0U)    /**< @brief Replace MAC header, use Service Provider Tag */
#define ETHSWT_FAOPERATION_C_TAG      (1U)    /**< @brief Replace MAC header, use Customer Tag */
#define ETHSWT_FAOPERATION_NO_TAG     (2U)    /**< @brief Replace MAC header, use no VLAN tag */
#define ETHSWT_FAOPERATION_NO_OP      (3U)    /**< @brief Do not replace MAC header, just update Source and Destination MAC addresses */
/** @} */

/**
    @name ETHSWT_FAFlagsType

    @brief Flags pertaining to the packet type

    @trace #BRCM_SWREQ_ETHSWT
    @{
*/
typedef uint8_t ETHSWT_FAFlagsType;
#define ETHSWT_FAFLAGS_L4TCP      (0x01U)    /**< @brief TCP / UDP */
#define ETHSWT_FAFLAGS_L3IPV4     (0x02U)    /**< @brief IP v4/v6 */
#define ETHSWT_FAFLAGS_L2LLCSNAP  (0x04U)    /**< @brief LLCSNAP/DIXv2 */
#define ETHSWT_FAFLAGS_INBOUND    (0x08U)    /**< @brief Inboud/Outbound */
/** @} */

/**
    @name ETHSWT_FAFlowValidType

    @brief Flow entry validity type

    @trace #BRCM_SWREQ_ETHSWT
    @{
*/
typedef uint8_t ETHSWT_FAFlowValidType;
#define ETHSWT_FAFLOWVALID_TILLREBOOT   (0x0U)  /**< @brief Entry valid till reboot
                                                and cannot be deleted once added */
#define ETHSWT_FAFLOWVALID_TILLDELETE   (0x1U)  /**< @brief Entry valid till it is deleted */
/** @} */

/**
    @name ETHSWT_FAMatchType

    @brief Flow accelerator Match type

    @trace #BRCM_SWREQ_ETHSWT
 */
typedef struct COMP_PACKED sETHSWT_FAMatchType {
    uint8_t     da[6];          /**< @brief Ingress Destination Address, valid
                                     when #ETHSWT_FACfgType
                                     validateMatchDA parameter is true */
    uint16_t    srcPort;        /**< @brief L4 Source Port */
    uint16_t    dstPort;        /**< @brief L4 destination Port */
    uint8_t     srcIp[16];      /**< @brief Source IP Address */
    uint8_t     dstIp[16];      /**< @brief Destination IP Address */
    ETHSWT_FAFlagsType flags;   /**< @brief Packet type flags combination */
} ETHSWT_FAMatchType;
_Static_assert(sizeof(ETHSWT_FAMatchType) <= ETHSWT_FA_MAX_PAYLOAD_SIZE,
               "ETHSWT_FAMatchType does not fit in IPC payload");

/**
    @name ETHSWT_FARemapDataType
    @{
    @brief Flow accelerator Remap type

    @trace #BRCM_SWREQ_ETHSWT
 */
typedef struct COMP_PACKED sETHSWT_FARemapDataType {
    ETHSWT_FAOperationType operation; /**< @brief Operation to be performed on L2 header */
    uint8_t     sa[6];                /**< @brief Remap Source Address */
    uint8_t     da[6];                /**< @brief Remap Destination Address */
    uint16_t    vlan;                 /**< @brief Remap VLAN ID */
    uint16_t    port;                 /**< @brief L4 Remap Port, set to 0 if overwrite is not required */
    uint8_t     ip[16];               /**< @brief Remap IP Address, set to 0 if overwrite is not required */
    ETHSWT_TCType tc;                 /**< @brief Traffic Class */
    ETHSWT_TEType te;                 /**< @brief Tag Reinforcement */
    uint32_t    portMask;             /**< @brief Portmask. If 0UL, opcode=0 will be used.
                                           Otherwise opcode=1 will be used in Broadcom header/tag */
} ETHSWT_FARemapDataType;
/** @} */

/**
    @name ETHSWT_FAFlowDataType
    @{
    @brief Flow accelerator Flow type

    @trace #BRCM_SWREQ_ETHSWT
 */
typedef struct COMP_PACKED sETHSWT_FAFlowDataType {
    ETHSWT_FAMatchType match;     /**< @brief Match parameters */
    ETHSWT_FARemapDataType remap;     /**< @brief Remap parameters */
    MCU_DeviceType mstSlvDevice;  /**< @brief 0: Master, 1: Slave-1, 2: Slave-2 */
} ETHSWT_FAFlowDataType;
_Static_assert(sizeof(ETHSWT_FAFlowDataType) <= ETHSWT_FA_MAX_PAYLOAD_SIZE,
               "ETHSWT_FAFlowDataType does not fit in IPC payload");
/** @} */

/**
    @name ETHSWT_FAMacAddrInfoType

    @brief MAC Information

    @trace #BRCM_SWREQ_ETHSWT
*/
typedef struct COMP_PACKED sETHSWT_FAMacAddrInfoType {
    uint32_t external;      /**< @brief Domain: TRUE:External, FALSE:Internal */
    uint8_t mac[6UL];       /**< @brief MAC Address */
} ETHSWT_FAMacAddrInfoType;
_Static_assert(sizeof(ETHSWT_FAMacAddrInfoType) <= ETHSWT_FA_MAX_PAYLOAD_SIZE,
               "ETHSWT_FAMacAddrInfoType does not fit in IPC payload");

/**
    @name ETHSWT_FAMacGroupType

    @brief MAC Address Configuration

    @trace #BRCM_SWREQ_ETHSWT
*/
typedef struct COMP_PACKED sETHSWT_FAMacGroupType {
    uint32_t count;                                /**< @brief Number of valid entries */
    ETHSWT_FAMacAddrInfoType info[ETHSWT_FA_POOL_MAX]; /**< @brief Pool Table entries */
} ETHSWT_FAMacGroupType;
_Static_assert(sizeof(ETHSWT_FAMacGroupType) <= ETHSWT_FA_MAX_PAYLOAD_SIZE,
               "ETHSWT_FAMacGroupType does not fit in IPC payload");

/**
    @name ETHSWT_FAFlowStatsType
    @brief Flow Statistics type

    @trace #BRCM_SWREQ_ETHSWT
*/
typedef struct COMP_PACKED sETHSWT_FAFlowStatsType {
    uint32_t hits;          /**< Number of hits */
    uint8_t lastTimestamp;  /**< Last timestamp */
} ETHSWT_FAFlowStatsType;
_Static_assert(sizeof(ETHSWT_FAFlowStatsType) <= ETHSWT_FA_MAX_PAYLOAD_SIZE,
               "ETHSWT_FAFlowStatsType does not fit in IPC payload");

/**
    @brief Ethernet Service FA Flow operation Type

    Structure to manage FA flow related operations

    @trace #BRCM_SWREQ_ETHSWT
*/
typedef struct COMP_PACKED sETHSWT_FAFlowOperationType {
    ETHSWT_FAFlowIDType flowID;         /**< @brief Flow ID */
    ETHSWT_FAFlowDataType flow;             /**< @brief Flow parameters */
    ETHSWT_FAFlowStatsType flowStats;   /**< @brief Flow Statistics */
    uint8_t rsvd;                       /**< Reserved */
} ETHSWT_FAFlowOperationType;
_Static_assert(sizeof(ETHSWT_FAFlowOperationType) <= ETHSWT_FA_MAX_PAYLOAD_SIZE,
               "ETHSWT_FAFlowOperationType does not fit in IPC payload");

/**
    @brief Ethernet Service FA MAC operation Type

    Structure to manage FA MAC related operations

    @trace #BRCM_SWREQ_ETHSWT
*/
typedef struct COMP_PACKED sETHSWT_FAMacOperationType {
    MCU_DeviceType mstSlvDevice;      /**< @brief Master/Slave identifier */
    ETHSWT_FAMacAddrInfoType info;        /**< @brief MAC information */
    uint8_t rsvd[2] ;                 /**< @brief Reserved */
} ETHSWT_FAMacOperationType;
_Static_assert(sizeof(ETHSWT_FAMacOperationType) <= ETHSWT_FA_MAX_PAYLOAD_SIZE,
               "ETHSWT_FAMacOperationType does not fit in IPC payload");

/**
    @brief Ethernet Service FA MAC Snapshot Type

    Structure to hold FA MAC snapshot

    @trace #BRCM_SWREQ_ETHSWT
*/
typedef struct COMP_PACKED sETHSWT_FAMacSnapshotType {
    ETHSWT_FAMacAddrInfoType info[2UL][ETHSWT_FA_POOL_MAX]; /**< @brief Mac Info */
    uint8_t deviceMac[2UL][6UL];                        /**< @brief List of Device MAC addresses */
} ETHSWT_FAMacSnapshotType;
_Static_assert(sizeof(ETHSWT_FAMacSnapshotType) <= ETHSWT_FA_MAX_PAYLOAD_SIZE,
               "ETHSWT_FAMacSnapshotType does not fit in IPC payload");

/**
    @name ETHSWT_FACtfModeType
    @{
    @brief CTF Operational Mode type

    @trace #BRCM_SWREQ_ETHSWT
*/
typedef uint8_t ETHSWT_FACtfModeType;
#define ETHSWT_FACTFMODE_NORMAL   (0U)    /**< @brief Normal mode */
#define ETHSWT_FACTFMODE_BYPASS   (1U)    /**< @brief Bypass mode */
/** @} */

/**
    @name ETHSWT_FACrcType
    @{
    @brief CRC types

    @trace #BRCM_SWREQ_ETHSWT
*/
typedef uint8_t ETHSWT_FACrcType;
#define ETHSWT_FACRC_CCITT    (0U)        /**< @brief CCITT polynomial (X^16 + X^12 + X^5 + 1) */
#define ETHSWT_FACRC_CRC16    (1U)        /**< @brief CRC16 polynomial (X^16 + X^15 + X^2 + 1) */
/** @} */

/**
    @name ETHSWT_FACtfCfgType

    @brief CTF configuration Type

    @trace #BRCM_SWREQ_ETHSWT
*/
typedef struct COMP_PACKED sETHSWT_FACtfCfgType {
    ETHSWT_FACtfModeType mode;        /**< @brief CTF Operational Mode */
    ETHSWT_FACrcType crc;             /**< @brief CRC type */
    uint16_t seedValue;               /**< @brief Inital seed value */
    uint32_t timestampPeriodSec;      /**< @brief Timestamp period in seconds */
    uint32_t validateMatchDA;         /**< @brief TRUE:Validation of Match-DA will be enabled, FALSE: disabled */
} ETHSWT_FACtfCfgType;

/**
    @brief Vlan Union encapsulating all messages

    @trace #BRCM_SWREQ_ETHSWT
*/
typedef union uETHSWT_FAMsgUnionType {
    uint32_t                     data[ETHSWT_FA_MAX_PAYLOAD_SIZE/4UL];
    ETHSWT_FAStatsType           faStats;       /**< @brief Statistics */
    ETHSWT_FAFlowOperationType   flowOperation; /**< @brief Flow Operation */
    ETHSWT_FAMacSnapshotType     macSnapshot;   /**< @brief MAC Snapshot */
    ETHSWT_FAMacOperationType    macOperation;  /**< @brief MAC Operation */
    ETHSWT_FAFlowStatusDataType  flowStatus;    /**< @brief Flow Status */
    ETHSWT_FAIntrFlagsType       intrFlags;     /**< @brief Interrupt Flags */
    ETHSWT_FACtfCfgType          ctfCfg;        /**< @brief CFT Configuration */
} ETHSWT_FAMsgUnionType;

/**
    @brief Vlan Host Context Type

    @trace #BRCM_SWREQ_ETHSWT
*/
typedef struct sETHSWT_FAHostContextType {
    BCM_StateType               state;      /**< @brief Context State           */
    BCM_SubStateType            subState;   /**< @brief Context Sub State       */
    BCM_CmdType                 id;         /**< @brief Command/Response ID     */
    int32_t                     status;     /**< @brief final status of command */
    ETHSWT_FAMsgUnionType       msg;        /**< @brief Message input/output    */
} ETHSWT_FAHostContextType;

/**
    @brief Setup FA Host context

    @behavior Sync, Non-Rentrant

    @pre None

    @param[inout]   aContext        Context to be setup
    @param[in]      aSecYID         Command/Message Type
    @param[in]      aMsgPayload     Command/Message payload

    Return values are documented in reverse-chronological order
    @retval     BCM_ERR_OK              Setup for initialization complete
    @retval     BCM_ERR_INVAL_PARAMS    aContext is NULL or aInitMsg is NULL

    @post aContext.state is changes to RUNNING.

    @trace #BRCM_SWREQ_ETHSWT

    @limitations None
*/
int32_t ETHSWT_FAHostContextSetup(ETHSWT_FAHostContextType *aContext, ETHSWT_FACmdIdType aCmdID,
                                  const ETHSWT_FAMsgUnionType *aMsgPayload);

/**
    @brief Process FA Host context

    @behavior Sync, Non-Rentrant

    @pre None

    @param[inout]   aContext        Context to be setup
    @param[in]      aResponse       Response code received from RPC Message
    @param[in]      aInitMsg        Received message ID
    @param[in]      aInMsgPayload   Received message payload
    @param[out]     aOutMsgId       Next message ID
    @param[out]     aInitMsg        Next message payload

    Return values are documented in reverse-chronological order
    @retval     BCM_ERR_OK              Process complete
    @retval     BCM_ERR_BUSY            Process is on going
    @retval     BCM_ERR_UNKNOWN         Integration fault
    @retval     BCM_ERR_INVAL_PARAMS    aContext is NULL or aInMsgPayload is NULL
                                        or aOutMsgId is NULL or aOutMsgPayload is NULL

    @post aContext.state is changes to RUNNING.

    @note aContext.u.status will reflect the error reported by the function referenced
    at @ref ETHSWT_FACmdIdType, and any output will be reflected in the structure represented
    at @ref ETHSWT_FACmdIdType.

    @trace #BRCM_SWREQ_ETHSWT

    @limitations None
*/
int32_t ETHSWT_FAHostContextProcess(ETHSWT_FAHostContextType *aContext, int32_t aResponse,
                                    BCM_CmdType aInMsgID, const uint8_t *aInMsgPayload,
                                    BCM_CmdType *aOutMsgId, uint8_t *aOutMsgPayload);

#endif /* ETHSWT_ABSTRACT_FA_H */

/** @} */
