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
    @defgroup grp_ethernet_swt_ext_ifc Switch EXT abstract Interface
    @ingroup grp_ethernet_abstract

    @addtogroup grp_ethernet_swt_ext_ifc
    @{

    @file ethernet_swt_ext.h

    @brief EXT Interface
    This file contains the interfaces for the switch abstract for EXT

    @version 1.0 Initial version
*/

#ifndef ETHERNET_SWT_EXT_H
#define ETHERNET_SWT_EXT_H

#include <module_msg.h>
#include <ethernet_swt_common.h>
#include <ethernet_xcvr_common.h>
#include <ethernet_swt_core.h>

/**
    @name EXT API IDs
    @{
    @brief API IDs for EXT
*/
#define BRCM_SWARCH_ETHSWT_EXT_MAX_PORTS_MACRO              (0x8201U)    /**< @brief #ETHSWT_EXT_MAX_PORTS                */
#define BRCM_SWARCH_ETHSWT_EXTCMDID_TYPE                    (0x8202U)    /**< @brief #ETHSWT_ExtCmdIdType                 */
#define BRCM_SWARCH_ETHSWT_EXTPORTINFO_TYPE                 (0x8203U)    /**< @brief #ETHSWT_ExtPortInfoType              */
#define BRCM_SWARCH_ETHSWT_EXTSWITCHINFO_TYPE               (0x8204U)    /**< @brief #ETHSWT_ExtSwitchInfoType            */
#define BRCM_SWARCH_ETHSWT_EXTTC10WAKEUP_TYPE               (0x8205U)    /**< @brief #ETHSWT_ExtTc10WakeUpType            */
#define BRCM_SWARCH_ETHSWT_EXTTOTALMACLEARNINGLIMIT_TYPE    (0x8206U)    /**< @brief #ETHSWT_ExtTotalMACLearningLimitType */
#define BRCM_SWARCH_ETHSWT_EXTSTICKYMAC_TYPE                (0x8207U)    /**< @brief #ETHSWT_ExtStickyMACType             */
#define BRCM_SWARCH_ETHSWT_EXTPORTADDRESSLIMIT_TYPE         (0x8208U)    /**< @brief #ETHSWT_ExtPortAddressLimitType      */
#define BRCM_SWARCH_ETHSWT_EXTSTATIONMOVEMENT_TYPE          (0x8209U)    /**< @brief #ETHSWT_ExtStationMovementType       */
#define BRCM_SWARCH_ETHSWT_EXTPORTLINKINFO_TYPE             (0x820AU)    /**< @brief #ETHSWT_ExtPortLinkInfoType          */
#define BRCM_SWARCH_ETHSWT_EXTASYNCEVENT_TYPE               (0x820BU)    /**< @brief #ETHSWT_ExtAsyncEventType            */
#define BRCM_SWARCH_ETHSWT_EXT_MAX_PAYLOAD_SIZE_MACRO       (0x820CU)    /**< @brief #ETHSWT_EXT_MAX_PAYLOAD_SIZE         */
#define BRCM_SWARCH_ETHSWT_EXTMSGUNION_TYPE                 (0x820DU)    /**< @brief #ETHSWT_ExtMsgUnionType              */
#define BRCM_SWARCH_ETHSWT_EXTHOSTCONTEXT_TYPE              (0x820EU)    /**< @brief #ETHSWT_ExtHostContextType           */
#define BRCM_SWARCH_ETHSWT_EXTHOSTCONTEXTSETUP_PROC         (0x820FU)    /**< @brief #ETHSWT_ExtHostContextSetup          */
#define BRCM_SWARCH_ETHSWT_EXTHOSTCONTEXTPROCESS_PROC       (0x8210U)    /**< @brief #ETHSWT_ExtHostContextProcess        */
#define BRCM_SWARCH_ETHSWT_SWTHELPER_GLOBAL                 (0x8211U)    /**< @brief #ETHSWT_SWTHelper                    */
/** @} */

/**
    @brief Maximum number of ports supported by Ethernet Service

    @trace #BRCM_SWREQ_ETHSWT
*/
#define ETHSWT_EXT_MAX_PORTS                        (16UL)

/**
    @name Switch Ext command IDs
    @{
    @brief Switch Ext command IDs group

    @trace #BRCM_SWREQ_ETHSWT
*/
typedef uint8_t ETHSWT_ExtCmdIdType;                        /**< @brief EXT command message Type                                                */
#define ETHSWT_EXTCMDID_PORT_INFO_GET              (0xB0U)  /**< @brief #ETHSWT_ExtPortInfoType              #ETHSWT_GetPortType
                                                                                                             #ETHSWT_GetPortMode
                                                                                                             #ETHSWT_GetPortLinkState
                                                                                                             #ETHSWT_GetPortSpeed
                                                                                                             #ETHSWT_GetPortMasterMode
                                                                                                             #ETHSWT_GetSQIValue
                                                                                                             #ETHSWT_GetPortJumboMode
                                                                                                             #ETHSWT_GetPortLoopbackMode
                                                                                                             #ETHXCVR_GetPortConfig
                                                                                                             #ETHSWT_GetPortAutoNegStatus
                                                                                                             #ETHSWT_GetPortDuplexMode
                                                                                                             #ETHSWT_GetLedState
                                                                                                             #ETHSWT_GetXcvrStats
                                                                                                             #ETHSWT_GetPortDefaultVlan          */
#define ETHSWT_EXTCMDID_PORT_INFO_SET              (0xB1U)  /**< @brief #ETHSWT_ExtPortInfoType              #ETHSWT_SetPortMode
                                                                                                             #ETHSWT_SetPortSpeed
                                                                                                             #ETHSWT_SetPortMasterMode
                                                                                                             #ETHSWT_SetPortJumboMode
                                                                                                             #ETHSWT_SetPortLoopbackMode
                                                                                                             #ETHSWT_SetPortDefaultVlan          */
#define ETHSWT_EXTCMDID_SWITCH_INFO_GET            (0xB2U)  /**< @brief #ETHSWT_ExtSwitchInfoType            #ETHSWT_GetAge
                                                                                                             #ETHSWT_GetDumbFwdMode
                                                                                                             #ETHSWT_GetMgmtMode
                                                                                                             #ETHSWT_GetBrcmHdrMode
                                                                                                             #ETHSWT_GetVLANIngressFilterMode    */
#define ETHSWT_EXTCMDID_SWITCH_INFO_SET            (0xB3U)  /**< @brief #ETHSWT_ExtSwitchInfoType            #ETHSWT_SetAge
                                                                                                             #ETHSWT_SetMgmtMode
                                                                                                             #ETHSWT_SetBrcmHdrMode
                                                                                                             #ETHSWT_SetDumbFwdMode
                                                                                                             #ETHSWT_SetVLANIngressFilterMode    */
#define ETHSWT_EXTCMDID_VLAN_HOPPING_DETECTION_SET (0xB4U)  /**< @brief #ETHSWT_SecurityActionType           #ETHSWT_SetVlanHoppingDetection     */
#define ETHSWT_EXTCMDID_VLAN_HOPPING_DETECTION_GET (0xB5U)  /**< @brief #ETHSWT_ExtTotalMACLearningLimitType #ETHSWT_GetTotalAddrLimitAndCounter */
#define ETHSWT_EXTCMDID_STATION_MOVE_DETECT_SET    (0xB6U)  /**< @brief #ETHSWT_ExtStationMovementType       #ETHSWT_SetStationMovementDetection */
#define ETHSWT_EXTCMDID_STATION_MOVE_DETECT_GET    (0xB7U)  /**< @brief #ETHSWT_ExtStationMovementType       #ETHSWT_GetStationMovementDetection */
#define ETHSWT_EXTCMDID_PORT_ADDRESS_LIMITING_SET  (0xB8U)  /**< @brief #ETHSWT_ExtPortAddressLimitType      #ETHSWT_SetPortAddrLimiting         */
#define ETHSWT_EXTCMDID_PORT_ADDRESS_LIMITING_GET  (0xB9U)  /**< @brief #ETHSWT_ExtPortAddressLimitType      #ETHSWT_GetPortAddrLimitAndCounter  */
#define ETHSWT_EXTCMDID_TOTAL_ADDRESS_LIMIT_SET    (0xBAU)  /**< @brief #ETHSWT_ExtTotalMACLearningLimitType #ETHSWT_SetTotalAddrLimit           */
#define ETHSWT_EXTCMDID_TOTAL_ADDRESS_LIMIT_GET    (0xBBU)  /**< @brief #ETHSWT_ExtTotalMACLearningLimitType #ETHSWT_GetTotalAddrLimitAndCounter */
#define ETHSWT_EXTCMDID_STICKY_MAC_ADDRESS_SET     (0xBCU)  /**< @brief #ETHSWT_ExtStickyMACType             #ETHSWT_SetMACAddressStickyToPort   */
#define ETHSWT_EXTCMDID_STICKY_MAC_ADDRESS_GET     (0xBDU)  /**< @brief #ETHSWT_ExtStickyMACType             #ETHSWT_GetMACAddressStickyToPort   */
#define ETHSWT_EXTCMDID_GETWAKEUPMODE              (0xBEU)  /**< @brief #ETHSWT_ExtTc10WakeUpType            #ETHSWT_GetPortWakeUpMode           */
#define ETHSWT_EXTCMDID_GETWAKEUPREASON            (0xBFU)  /**< @brief #ETHSWT_ExtTc10WakeUpType            #ETHSWT_GetPortWakeUpReason         */
#define ETHSWT_EXTCMDID_START                      (ETHSWT_EXTCMDID_PORT_INFO_GET)   /**< @brief EXT Command start index                         */
#define ETHSWT_EXTCMDID_END                        (ETHSWT_EXTCMDID_GETWAKEUPREASON) /**< @brief EXT Command end index                           */
/** @} */

/**
    @brief Maximum size of VLAN command payload in bytes

    @trace #BRCM_SWREQ_ETHSWT
*/
#define ETHSWT_EXT_MAX_PAYLOAD_SIZE   (140UL)

/**
    @brief Structure to manage the port parameters.

    @trace #BRCM_SWREQ_ETHSWT
*/
typedef struct sETHSWT_ExtPortInfoType {
    ETHSWT_PortIDType           port;               /**< @brief Port identifier */
    ETHXCVR_ModeType            adminMode;          /**< @brief Admin mode of the port - enabled/disabled */
    ETHXCVR_LinkStateType       linkStatus;         /**< @brief Link status of the port - up/down */
    ETHXCVR_SpeedType           speed;              /**< @brief Current speed of the port - 10/100/Autoneg */
    ETHXCVR_BooleanType         masterEnable;       /**< @brief BroadR-Reach mode - master/slave */
    ETHXCVR_BooleanType         jumboEnable;        /**< @brief Jumbo enable */
    ETHXCVR_BooleanType         loopbackEnable;     /**< @brief Loop back mode - enabled/disabled */
    ETHXCVR_BooleanType         autonegEnable;      /**< @brief Auto Neg - enabled/disabled */
    ETHXCVR_AutoNegStatusType   autonegComplete;    /**< @brief Auto Neg - complete/pending */
    ETHXCVR_DuplexModeType      duplex;             /**< @brief duplex - full/half */
    uint32_t                    led;                /**< @brief led - on/off */
    uint32_t                    linkStateChangeCnt; /**< @brief no. of state changes */
    ETHXCVR_BusModeType         busMode;            /**< @brief XCVR bus mode */
    ETHXCVR_PhyMediaType        phyMedia;           /**< @brief XCVR phy media */
    uint32_t                    linkSQI;            /**< @brief Link SQI */
    uint32_t                    pvid;               /**< @brief PVID */
    uint32_t                    prio;               /**< @brief Priority */
} ETHSWT_ExtPortInfoType;
_Static_assert(sizeof(ETHSWT_ExtPortInfoType) <= ETHSWT_EXT_MAX_PAYLOAD_SIZE,
               "ETHSWT_ExtPortInfoType does not fit in IPC payload");

/**
    @brief Structure to manage the switch get/set parameters.

    @trace #BRCM_SWREQ_ETHSWT
*/
typedef struct sETHSWT_ExtSwitchInfoType {
    uint32_t                         ageTime;     /**< @brief Age Time */
    ETHSWT_DumbFwdModeType           dumbFwdMode; /**< @brief Dumb Forward Mode */
    ETHSWT_VLANIngressFilterModeType iFilter;     /**< @brief Ingress Filter */
    ETHSWT_BrcmHdrModeType           brcmHdrMode; /**< @brief Broadcom Header Mode */
    ETHSWT_MgmtModeType              mgmtMode;    /**< @brief Management Mode */
} ETHSWT_ExtSwitchInfoType;
_Static_assert(sizeof(ETHSWT_ExtSwitchInfoType) <= ETHSWT_EXT_MAX_PAYLOAD_SIZE,
               "ETHSWT_ExtSwitchInfoType does not fit in IPC payload");

/**
    @brief Structure to manage tc10 sleep wake

    @trace #BRCM_SWREQ_ETHSWT
*/
typedef struct sETHSWT_ExtTc10WakeUpType {
    ETHSWT_PortIDType           port;           /**< @brief Port identifier    */
    ETHXCVR_WakeupReasonType    reason;         /**< @brief Wakeup Reason      */
    uint8_t                     mode;           /**< @brief Sleep Wake Control */
} ETHSWT_ExtTc10WakeUpType;
_Static_assert(sizeof(ETHSWT_ExtTc10WakeUpType) <= ETHSWT_EXT_MAX_PAYLOAD_SIZE,
               "ETHSWT_ExtTc10WakeUpType does not fit in IPC payload");

/**
    @brief Structure to manage station movement

    @trace #BRCM_SWREQ_ETHSWT
*/
typedef struct sETHSWT_ExtStationMovementType {
    ETHSWT_PortIDType            port;              /**< @brief Port identifier */
    ETHSWT_SecurityActionType    stationMoveAction; /**< @brief Station movement action */
} ETHSWT_ExtStationMovementType;
_Static_assert(sizeof(ETHSWT_ExtStationMovementType) <= ETHSWT_EXT_MAX_PAYLOAD_SIZE,
               "ETHSWT_ExtStationMovementType does not fit in IPC payload");

/**
    @brief Structure to manage address limiting

    @trace #BRCM_SWREQ_ETHSWT
*/
typedef struct sETHSWT_ExtPortAddressLimitType {
    ETHSWT_PortIDType            port;                   /**< @brief Port identifier */
    ETHSWT_AddressLimitingType   addressLimitInfo;       /**< @brief Address limiting information */
    uint16_t                     portLearnedCounter;     /**< @brief SA MAC addresses learned on the port */
    uint32_t                     portOverLimitCounter;   /**< @brief Overlimit counter */
} ETHSWT_ExtPortAddressLimitType;
_Static_assert(sizeof(ETHSWT_ExtPortAddressLimitType) <= ETHSWT_EXT_MAX_PAYLOAD_SIZE,
               "ETHSWT_ExtPortAddressLimitType does not fit in IPC payload");

/**
    @brief Structure to manage sticky MAC

    @trace #BRCM_SWREQ_ETHSWT
*/
typedef struct sETHSWT_ExtStickyMACType {
    ETHSWT_PortIDType            port;               /**< @brief Port identifier */
    ETHSWT_SecurityActionType    stickyMACAction;    /**< @brief Sticky MAC address action */
} ETHSWT_ExtStickyMACType;
_Static_assert(sizeof(ETHSWT_ExtStickyMACType) <= ETHSWT_EXT_MAX_PAYLOAD_SIZE,
               "ETHSWT_ExtStickyMACType does not fit in IPC payload");

/**
    @brief Structure to manage address limiting across all ports

    @trace #BRCM_SWREQ_ETHSWT
*/
typedef struct sETHSWT_ExtTotalMACLearningLimitType {
    uint16_t    totalMACLearningLimit;      /**< @brief maximum number of MAC
                                                  addresses allowed to
                                                  learn across all ports */
    uint16_t    totalLearnedCounter;        /**< @brief SA MAC addresses learned across all ports */
} ETHSWT_ExtTotalMACLearningLimitType;
_Static_assert(sizeof(ETHSWT_ExtTotalMACLearningLimitType) <= ETHSWT_EXT_MAX_PAYLOAD_SIZE,
               "ETHSWT_ExtTotalMACLearningLimitType does not fit in IPC payload");

/**
    @brief Structure to manage the switch port link information type.

    @trace #BRCM_SWREQ_ETHSWT
*/
typedef struct sETHSWT_ExtPortLinkInfoType {
    ETHSWT_PortIDType       port;           /**< @brief Port identifier */
    ETHXCVR_LinkStateType   linkState;      /**< @brief Link status of the port - up/down */
    ETHSWT_PortStatsType    portStats;      /**< @brief Port stats */
} ETHSWT_ExtPortLinkInfoType;
_Static_assert(sizeof(ETHSWT_ExtPortLinkInfoType) <= ETHSWT_EXT_MAX_PAYLOAD_SIZE,
               "ETHSWT_ExtPortLinkInfoType does not fit in IPC payload");

/**
    @name ETHSWT_ExtAsyncEventType
    @{
    @brief ETHSWTM EXT Asynchronous event type

    Event generated asynchronously by target

    @trace #BRCM_SWREQ_ETHSWT
*/
typedef uint8_t ETHSWT_ExtAsyncEventType;
#define ETHSWT_EXTASYNCEVENT_PORT_LINK_INFO  (0x00U) /**< @brief Port link event */
/** @} */

/**
    @brief EXT Union encapsulating all messages

    @trace #BRCM_SWREQ_ETHSWT
*/
typedef union uETHSWT_ExtMsgUnionType {
    uint32_t                             data[ETHSWT_EXT_MAX_PAYLOAD_SIZE/4UL];
    ETHSWT_ExtPortInfoType               portInfo;             /**< @brief Port information */
    ETHSWT_ExtSwitchInfoType             switchInfo;           /**< @brief Switch information */
    ETHSWT_ExtTc10WakeUpType             tc10Wake;             /**< @brief TC10 wake-up */
    ETHSWT_CoreRegAccessType             regAccess;            /**< @brief Switch reg read or write     */
    uint32_t                             vlanHoppingAction;    /**< @brief VLAN hopping Action */
    ETHSWT_ExtStationMovementType        stationMove;          /**< @brief Station Movement */
    ETHSWT_ExtPortAddressLimitType       addrLimit;            /**< @brief Address Limit */
    ETHSWT_ExtStickyMACType              stickyMAC;            /**< @brief Sticky MAC */
    ETHSWT_ExtTotalMACLearningLimitType  totalAddressLimit;    /**< @brief Total MAC Learning Limit */
    ETHSWT_ExtPortLinkInfoType           portLinkInfo;         /**< @brief Port link information */
} ETHSWT_ExtMsgUnionType;

/**
    @brief EXT Host Context Type

    @trace #BRCM_SWREQ_ETHSWT
*/
typedef struct sETHSWT_ExtHostContextType {
    BCM_StateType               state;      /**< @brief Context State           */
    BCM_SubStateType            subState;   /**< @brief Context Sub State       */
    BCM_CmdType                 id;         /**< @brief Command/Response ID     */
    int32_t                     status;     /**< @brief final status of command */
    ETHSWT_ExtMsgUnionType      msg;        /**< @brief Message input/output    */
} ETHSWT_ExtHostContextType;

/**
    @brief Setup EXT Host context

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
int32_t ETHSWT_ExtHostContextSetup(ETHSWT_ExtHostContextType *aContext, ETHSWT_ExtCmdIdType aCmdID,
                                   const ETHSWT_ExtMsgUnionType *aMsgPayload);

/**
    @brief Process EXT Host context

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
    at @ref ETHSWT_ExtCmdIdType, and any output will be reflected in the structure represented
    at @ref ETHSWT_ExtCmdIdType.

    @trace #BRCM_SWREQ_ETHSWT

    @limitations None
*/
int32_t ETHSWT_ExtHostContextProcess(ETHSWT_ExtHostContextType *aContext, int32_t aResponse,
                                     BCM_CmdType aInMsgID, const uint8_t *aInMsgPayload,
                                     BCM_CmdType *aOutMsgId, uint8_t *aOutMsgPayload);

/**
    @brief Host Switch Helper Module

    @trace #BRCM_SWREQ_ETHSWT
*/
extern const MODULE_MsgConverterType ETHSWT_SWTHelper;

#endif /* ETHERNET_SWT_EXT_H */
/** @} */
