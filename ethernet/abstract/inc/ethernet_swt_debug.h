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
    @defgroup grp_ethernet_swt_dbg_ifc Switch Debug abstract Interface
    @ingroup grp_ethernet_abstract

    @addtogroup grp_ethernet_swt_dbg_ifc
    @{

    @file ethernet_swt_debug.h

    @brief Debug Abstract Interface
    This file contains the interfaces for the Ethernet abstract for Debug

    @version 1.0 Initial version
*/

#ifndef ETHERNET_SWT_DEBUG_H
#define ETHERNET_SWT_DEBUG_H

#include <module_msg.h>
#include <ethernet_common.h>
#include <ethernet_swt_common.h>

/**
    @name Switch CORE API IDs
    @{
    @brief API IDs for CORE in Switch
*/
#define BRCM_SWARCH_ETHSWT_DEBUGCMDID_TYPE                (0x8301U)    /**< @brief #ETHSWT_DebugCmdIdType          */
#define BRCM_SWARCH_ETHSWT_DEBUGMIRRORENABLE_TYPE         (0x8302U)    /**< @brief #ETHSWT_DebugMirrorEnableType   */
#define BRCM_SWARCH_ETHSWT_DEBUGMIRRORSTATUS_TYPE         (0x8303U)    /**< @brief #ETHSWT_DebugMirrorStatusType   */
#define BRCM_SWARCH_ETHSWT_DEBUGMIB_TYPE                  (0x8304U)    /**< @brief #ETHSWT_DebugMibType            */
#define BRCM_SWARCH_ETHSWT_TRAFFICDIR_TYPE                (0x8305U)    /**< @brief #ETHSWT_TrafficDirType          */
#define BRCM_SWARCH_ETHSWT_PORTMIRRORSTATE_TYPE           (0x8306U)    /**< @brief #ETHSWT_PortMirrorStateType     */
#define BRCM_SWARCH_ETHSWT_PORTMIRRORCFG_TYPE             (0x8307U)    /**< @brief #ETHSWT_PortMirrorCfgType       */
#define BRCM_SWARCH_ETHSWT_DEBUGMSGUNION_TYPE             (0x8308U)    /**< @brief #ETHSWT_DebugMsgUnionType       */
#define BRCM_SWARCH_ETHSWT_DEBUGHOSTCONTEXT_TYPE          (0x8309U)    /**< @brief #ETHSWT_DebugHostContextType    */
#define BRCM_SWARCH_ETHSWT_DEBUGHOSTCONTEXTSETUP_PROC     (0x830AU)    /**< @brief #ETHSWT_DebugHostContextSetup   */
#define BRCM_SWARCH_ETHSWT_DEBUGHOSTCONTEXTPROCESS_PROC   (0x830BU)    /**< @brief #ETHSWT_DebugHostContextProcess */
#define BRCM_SWARCH_ETHSWT_SWTDEBUGHELPER_GLOBAL          (0x830CU)    /**< @brief #ETHSWT_SWTDebugHelper          */
#define BRCM_SWARCH_ETHSWT_DEBUGMIRRORHELPER_GLOBAL       (0x830DU)    /**< @brief #ETHSWT_DebugMirrorHelper       */
#define BRCM_SWARCH_ETHSWT_DEBUG_MAX_PAYLOAD_SIZE_MACRO   (0x830EU)    /**< @brief #ETHSWT_DEBUG_MAX_PAYLOAD_SIZE  */
/** @} */

/**
    @name Switch Debug command IDs
    @{
    @brief Switch Debug command IDs group

    @trace #BRCM_SWREQ_ETHSWT
*/
typedef uint8_t ETHSWT_DebugCmdIdType;               /**< @brief VLAN command message Type                                                               */
#define ETHSWT_DEBUGCMDID_MIRROR_ENABLE     (0x70U)  /**< @brief #ETHSWT_DebugMirrorEnableType   #ETHSWT_SetPortMirrorConfig:ETHSWT_SetPortMirrorState   */
#define ETHSWT_DEBUGCMDID_MIRROR_DISABLE    (0x71U)  /**< @brief #NA                             #ETHSWT_GetMirrorCapturePort:ETHSWT_SetPortMirrorState  */
#define ETHSWT_DEBUGCMDID_MIRROR_STATUS     (0x72U)  /**< @brief #ETHSWT_DebugMirrorStatusType   #ETHSWT_GetMirrorCapturePort:ETHSWT_GetPortMirrorState:ETHSWT_GetPortMirrorConfig:ETHSWT_GetPortMirrorConfig */
#define ETHSWT_DEBUGCMDID_MIBS              (0x73U)  /**< @brief #ETHSWT_DebugMibType            #ETHSWT_GetRxStat:ETHSWT_GetTxStat                       */
#define ETHSWT_DEBUGCMDID_MIBS_CLEAR        (0x74U)  /**< @brief #ETHSWT_DebugMibType            #ETHSWT_ClearRxStat:ETHSWT_ClearTxStat                   */
#define ETHSWT_DEBUGCMDID_START             (ETHSWT_DEBUGCMDID_MIRROR_ENABLE)   /**< @brief Debug Command start index                                     */
#define ETHSWT_DEBUGCMDID_END               (ETHSWT_DEBUGCMDID_MIBS_CLEAR)      /**< @brief Debug Command end index                                       */
/** @} */

/**
    @brief Maximum size of VLAN command payload in bytes

    @trace #BRCM_SWREQ_ETHSWT
*/
#define ETHSWT_DEBUG_MAX_PAYLOAD_SIZE   (256UL)

/**
    @name Traffic direction
    @{
    @brief Dirrection of traffic

    @trace #BRCM_SWREQ_ETHSWT
*/
typedef uint8_t ETHSWT_TrafficDirType;
#define ETHSWT_TRAFFICDIR_INGRESS   (0x0U) /**< @brief Ingress */
#define ETHSWT_TRAFFICDIR_EGRESS    (0x1U) /**< @brief Egress  */
/** @} */

/**
    @name Port mirror state type
    @{
    @brief Port mirror state type

    @trace #BRCM_SWREQ_ETHSWT
*/
typedef uint32_t ETHSWT_PortMirrorStateType;          /**< @brief Port mirror state type */
#define ETHSWT_PORTMIRRORSTATE_DISABLED     (0x0UL) /**< @brief Port mirror state disabled */
#define ETHSWT_PORTMIRRORSTATE_ENABLED      (0x1UL) /**< @brief Port mirror state enabled */
/** @} */

/**
    @brief Port mirror configuration

    @trace #BRCM_SWREQ_ETHSWT
*/
typedef struct sETHSWT_PortMirrorCfgType {
    uint16_t portMask;              /**< @brief Mirrored port mask. This is bit
                                            mask value of the ports whose traffic
                                            shall be mirrored to the given port */
    uint16_t packetDivider;         /**< @brief Packet divider (only a subset of
                                            the received frame shall be mirrored).
                                            For example if packetDivider is set to
                                            10, then out of 10 packets passing the
                                            filtering, only 1 shall be mirrored */
    uint8_t srcMacAddrFilter[6UL];  /**< @brief Source MAC address that shall be
                                            mirrored */
    uint8_t destMacAddrFilter[6UL]; /**< @brief Destination MAC address that
                                            shall be mirrored */
} ETHSWT_PortMirrorCfgType;
_Static_assert(sizeof(ETHSWT_PortMirrorCfgType) <= ETHSWT_DEBUG_MAX_PAYLOAD_SIZE,
               "ETHSWT_PortMirrorCfgType does not fit in IPC payload");

/**
    @brief Structure to manage the port Mirroring.

    @trace #BRCM_SWREQ_ETHSWT
*/
typedef struct sETHSWT_DebugMirrorEnableType {
    ETHSWT_PortIDType           probePort;       /**< @brief probe port */
    ETHSWT_TrafficDirType       direction;       /**< @brief traffic direction */
    ETHSWT_PortMirrorCfgType    mirrorCfg;       /**< @brief mirror configuration */
} ETHSWT_DebugMirrorEnableType;
_Static_assert(sizeof(ETHSWT_DebugMirrorEnableType) <= ETHSWT_DEBUG_MAX_PAYLOAD_SIZE,
               "ETHSWT_DebugMirrorEnableType does not fit in IPC payload");

/**
    @brief Structure to manage the port Mirroring status.

    @trace #BRCM_SWREQ_ETHSWT
*/
typedef struct sETHSWT_DebugMirrorStatusType {
    ETHSWT_PortMirrorStateType  state;              /**< @brief enabled or disabled */
    ETHSWT_PortIDType           probePort;          /**< @brief probe port */
    ETHSWT_PortMirrorCfgType    ingressMirrorCfg;   /**< @brief mirror configuration for ingress traffic */
    ETHSWT_PortMirrorCfgType    egressMirrorCfg;    /**< @brief mirror configuration for egress traffic */
} ETHSWT_DebugMirrorStatusType;
_Static_assert(sizeof(ETHSWT_DebugMirrorStatusType) <= ETHSWT_DEBUG_MAX_PAYLOAD_SIZE,
               "ETHSWT_DebugMirrorStatusType does not fit in IPC payload");

/**
    @brief Structure to manage the Rx/Tx statistics.

    @trace #BRCM_SWREQ_ETHSWT
*/
typedef struct sETHSWT_DebugMibType {
    ETHSWT_PortIDType port;      /**< @brief Port ID */
    ETHER_RxStatsType rxStats;     /**< @brief Receive stats */
    ETHER_TxStatsType txStats;     /**< @brief Transmit stats */
} ETHSWT_DebugMibType;
_Static_assert(sizeof(ETHSWT_DebugMibType) <= ETHSWT_DEBUG_MAX_PAYLOAD_SIZE,
               "ETHSWT_DebugMibType does not fit in IPC payload");

/**
    @brief Vlan Union encapsulating all messages

    @trace #BRCM_SWREQ_ETHSWT
*/
typedef union uETHSWT_DebugMsgUnionType {
    uint32_t                       data[ETHSWT_DEBUG_MAX_PAYLOAD_SIZE/4UL];
    ETHSWT_DebugMirrorEnableType   mirrorEnable; /**< @brief Mirror Enable struct */
    ETHSWT_DebugMirrorStatusType   mirrorStatus; /**< @brief Mirror Status struct*/
    ETHSWT_DebugMibType            mib;          /**< @brief MIB struct */
} ETHSWT_DebugMsgUnionType;

/**
    @brief Vlan Host Context Type

    @trace #BRCM_SWREQ_ETHSWT
*/
typedef struct sETHSWT_DebugHostContextType {
    BCM_StateType               state;      /**< @brief Context State           */
    BCM_SubStateType            subState;   /**< @brief Context Sub State       */
    BCM_CmdType                 id;         /**< @brief Command/Response ID     */
    int32_t                     status;     /**< @brief final status of command */
    ETHSWT_DebugMsgUnionType    msg;        /**< @brief Message input/output    */
} ETHSWT_DebugHostContextType;

/**
    @brief Setup Switch Core Host context

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
int32_t ETHSWT_DebugHostContextSetup(ETHSWT_DebugHostContextType *aContext, ETHSWT_DebugCmdIdType aCmdID,
                                     const ETHSWT_DebugMsgUnionType *aMsgPayload);

/**
    @brief Process Switch Core Host context

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
    at @ref ETHSWT_DebugCmdIdType, and any output will be reflected in the structure represented
    at @ref ETHSWT_DebugCmdIdType.

    @trace #BRCM_SWREQ_ETHSWT

    @limitations None
*/
int32_t ETHSWT_DebugHostContextProcess(ETHSWT_DebugHostContextType *aContext, int32_t aResponse,
                                       BCM_CmdType aInMsgID, const uint8_t *aInMsgPayload,
                                       BCM_CmdType *aOutMsgId, uint8_t *aOutMsgPayload);

/**
    @brief Host Switch Debug Helper Module

    @trace #BRCM_SWREQ_ETHSWT
*/
extern const MODULE_MsgConverterType ETHSWT_SWTDebugHelper;

/**
    @brief Host Switch Mirror Helper Module

    @trace #BRCM_SWREQ_ETHSWT
*/
extern const MODULE_MsgConverterType ETHSWT_DebugMirrorHelper;

#endif /* ETHERNET_SWT_DEBUG_H */
/** @} */
