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

 2. TO THE COMP_MAXIMUM EXTENT PERMITTED BY LAW, THE SOFTWARE IS PROVIDED "AS IS"
    AND WITH ALL FAULTS AND BROADCOM MAKES NO PROMISES, REPRESENTATIONS OR
    WARRANTIES, EITHER EXPRESS, IMPLIED, STATUTORY, OR OTHERWISE, WITH RESPECT
    TO THE SOFTWARE.  BROADCOM SPECIFICALLY DISCLAIMS ANY AND ALL IMPLIED
    WARRANTIES OF TITLE, MERCHANTABILITY, NONINFRINGEMENT, FITNESS FOR A
    PARTICULAR PURPOSE, LACK OF VIRUSES, ACCURACY OR COMPLETENESS,
    QUIET ENJOYMENT, QUIET POSSESSION OR CORRESPONDENCE TO DESCRIPTION.
    YOU ASSUME THE ENTIRE RISK ARISING OUT OF USE OR PERFORMANCE OF THE
    SOFTWARE.

 3. TO THE COMP_MAXIMUM EXTENT PERMITTED BY LAW, IN NO EVENT SHALL BROADCOM OR ITS
    LICENSORS BE LIABLE FOR (i) CONSEQUENTIAL, INCIDENTAL, SPECIAL, INDIRECT,
    OR EXEMPLARY DAMAGES WHATSOEVER ARISING OUT OF OR IN ANY WAY RELATING TO
    YOUR USE OF OR INABILITY TO USE THE SOFTWARE EVEN IF BROADCOM HAS BEEN
    ADVISED OF THE POSSIBILITY OF SUCH DAMAGES; OR (ii) ANY AMOUNT IN EXCESS
    OF THE AMOUNT ACTUALLY PAID FOR THE SOFTWARE ITSELF OR U.S. $1, WHICHEVER
    IS GREATER. THESE LIMITATIONS SHALL APPLY NOTWITHSTANDING ANY FAILURE OF
    ESSENTIAL PURPOSE OF ANY LIMITED REMEDY.
******************************************************************************/

/**
    @defgroup grp_rpc_udp_comn_ifc UDP Common Interface
    @ingroup grp_rpc_v2_udp

    @addtogroup grp_rpc_udp_comn_ifc
    @{

    @file rpc_udp_common.h
    @brief RPC UDP common interface used by both
    UDP Master and UDP Slave Interfaces

    @version 0.1 Initial Version
*/

#ifndef RPC_UDP_COMMON_H
#define RPC_UDP_COMMON_H

#include <stdint.h>
#include <bcm_comp.h>
#include <tftp.h>
#include <rpc_interface.h>
#include <rpc_udp_osil.h>

/**
    @name RPC UDP Common Architecture IDs
    @{
    @brief Architecture IDs for RPC UDP Common
*/
#define BRCM_SWARCH_RPC_UDPCONTEXT_TYPE               (0x8B01U)    /**< @brief #RPC_UDPContextType */
#define BRCM_SWARCH_RPC_UDP_KEEPALIVE_CMD_MACRO       (0x8B02U)    /**< @brief #RPC_UDP_KEEPALIVE_CMD */
#define BRCM_SWARCH_RPC_UDPCONNSTATS_TYPE             (0x8B03U)    /**< @brief #RPC_UDPConnStatsType */
#define BRCM_SWARCH_RPC_UDPCONN_TYPE                  (0x8B04U)    /**< @brief #RPC_UDPConnType */
#define BRCM_SWARCH_RPC_UDPSTREAMCONN_TYPE            (0x8B05U)    /**< @brief #RPC_UDPStreamConnType */
#define BRCM_SWARCH_RPC_UDPCONNECTIONS_TYPE           (0x8B06U)    /**< @brief #RPC_UDPConnectionsType */
#define BRCM_SWARCH_RPC_UDPCOMMONINIT_PROC            (0x8B07U)    /**< @brief #RPC_UDPCommonInit */
#define BRCM_SWARCH_RPC_UDPCOMMONDEINIT_PROC          (0x8B08U)    /**< @brief #RPC_UDPCommonDeInit */
#define BRCM_SWARCH_RPC_UDPCOMMONDISCONNECT_PROC      (0x8B09U)    /**< @brief #RPC_UDPCommonDisconnect */
#define BRCM_SWARCH_RPC_UDPCOMMONHANDLERXCONN_PROC    (0x8B0AU)    /**< @brief #RPC_UDPCommonHandleRxConn */
#define BRCM_SWARCH_RPC_UDPCOMMONHANDLETXCONN_PROC    (0x8B0BU)    /**< @brief #RPC_UDPCommonHandleTxConn */
#define BRCM_SWARCH_RPC_UDPCOMMONGETMSGSIZE_PROC      (0x8B0CU)    /**< @brief #RPC_UDPCommonGetMsgSize */
#define BRCM_SWARCH_RPC_UDPCOMMONGETEVENTMASK_PROC    (0x8B0DU)    /**< @brief #RPC_UDPCommonGetEventMask */
#define BRCM_SWARCH_RPC_UDPCOMMONPROCESSMSG_PROC      (0x8B0EU)    /**< @brief #RPC_UDPCommonProcessMsg */
/** @} */

/**
    @name RPC UDP keep alive command to keep connection active

    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP
*/
#define RPC_UDP_KEEPALIVE_CMD      (BCM_CMDID(BCM_GROUPID_IMGL,BCM_RSV_ID,0U))

/**
    @brief RPC UDP connection stats

    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP
*/
typedef struct sRPC_UDPConnStatsType {
    uint64_t    connTimeNs;      /**< @brief Timestamp of last connection */
    uint64_t    disconnTimeNs;   /**< @brief Timestamp of last disconnection */
    uint32_t    numConnects;     /**< @brief Count of connects */
    uint32_t    numDisconnects;  /**< @brief Count of disconnects */
    uint32_t    sendMsgDrop;     /**< @brief Count of response/async that was dropped */
} RPC_UDPConnStatsType;

/**
    @brief RPC UDP connection Type

    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP
*/
typedef struct sRPC_UDPConnType {
    uint32_t              payloadId;        /**< @brief Payload ID for connection */
    TFTP_ContextType      tftpContext;      /**< @brief TFTP context */
    uint64_t              lastTxTime;       /**< @brief Time of last transmit */
    RPC_UDPConnStatsType  stats;            /**< @brief Statistics */
    uint8_t               msgBuffer[TFTP_DEFAULT_DATA_LEN];
                                            /**< @brief Message buffer */
    uint32_t              isMsgPending;     /**< @brief Boolean to indicate if a command
                                                 is copied into #msgBuffer and pending
                                                 processing */
} RPC_UDPConnType;

/**
    @brief RPC UDP stream connection Type

    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP
*/
typedef struct sRPC_UDPStreamConnType {
    TFTP_ContextType   tftpContext;               /**< @brief Stream TFTP context */
    uint32_t           payloadId;                 /**< @brief Stream payload ID */
    uint32_t           isLastPacket;              /**< @brief Boolean to indicate that the
                                                       last packet has been transmitted */
    uint64_t           lastProcTime;
} RPC_UDPStreamConnType;

/**
    @brief RPC UDP connections

    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP
*/
typedef struct sRPC_UDPConnectionsType {
    uint32_t                 serverPayloadId; /**< @brief TFTP server payload ID */
    RPC_UDPConnType          rx;              /**< @brief Receive connection */
    RPC_UDPConnType          tx;              /**< @brief Transmit connection */
    RPC_UDPStreamConnType    streams[RPC_MEM_STREAM_COUNT];
                                                  /**< @brief Stream requests */
} RPC_UDPConnectionsType;

/**
    @brief RPC UDP Context type

    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP
*/
typedef struct sRPC_UDPContextType {
    RPC_InterfaceIdType      selfId;                /**< @brief This Module Interface ID */
    RPC_InterfaceIdType      peerId;                /**< @brief Connected peer ID */
    RPC_AssociationIndexType assocId;               /**< @brief This Interface Association ID */
    BCM_SubStateType         ifcInitState;          /**< @brief State of Interface initialization */
    INET_IPAddressType       remoteIPAddr;          /**< @brief UDP peer IP address */
    uint32_t                 maxRetryCount;         /**< @brief TFTP retry count */
    uint32_t                 streamRetryIntervalMs; /**< @brief TFTP Stream retry interval */
    uint32_t                 msgRetryIntervalMs;    /**< @brief TFTP Msg retry interval */
    uint64_t                 keepAliveIntervalNs;   /**< @brief TFTP Keep Alive Interval*/
    RPC_UDPConnectionsType   connections;           /**< @brief Connection handles */
    uint8_t                  streamBuffer[TFTP_MAX_DATA_LEN];
                                                  /**< @brief Stream buffer */
} RPC_UDPContextType;

/** @brief RPC UDP interface common initialization

    This API used to initialize the UDP Interface

    @behavior Sync, Non-Reentrant

    @param[in]      aConfig        Pointer to configuration
    @param[in]      aIfc           RPC interface
    @param[in]      aContext       Pointer to context
    @param[in]      aIntfID        INET interface index
    @param[in]      aRemoteIP      Remote IP address

    @retval #BCM_ERR_OK           Initialization succeeded
    @retval #BCM_ERR_INVAL_PARAMS Initialization failed do to invalid configuration

    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP

    @limitations None
*/
int32_t RPC_UDPCommonInit(const RPC_UDPIntfConfigType *const aConfig,
                          const RPC_InterfaceType *const aIfc,
                          RPC_UDPContextType *const aContext,
                          INET_InterfaceIdType aIntfID,
                          INET_IPAddressType aRemoteIP);

/** @brief RPC UDP interface common de-initialization

    This API used to deinitialize the UDP Interface

    @behavior Sync, Non-Reentrant

    @param[in]      aConnections   Pointer to connections

    @retval void

    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP

    @limitations None
*/
void RPC_UDPCommonDeInit(RPC_UDPConnectionsType *const aConnections);

/** @brief RPC UDP interface common disconnection

    This API used to disconnect the UDP Interface

    @behavior Sync, Non-Reentrant

    @param[in]      aConnections   Pointer to connections

    @retval void

    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP

    @limitations None
*/
void RPC_UDPCommonDisconnect(RPC_UDPConnectionsType *const aConnections);

/** @brief Handle receive connection requests from UDP peer

    This API handles connections for the receive connection

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aConn       Receive Connection context
    @param[in]      aIfc        RPC interface
    @param[in]      aTftpState  TFTP state

    @retval void

    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP

    @limitations None
*/
int32_t RPC_UDPCommonHandleRxConn(RPC_UDPConnType *aConn,
                               const RPC_InterfaceType *const aIfc,
                               const TFTP_StateType aTftpState);

/** @brief Initiate transmit connection requests to UDP peer

    This API will initiate transmit connection to remote

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aConn                Receive Connection context
    @param[in]      aKeepAliveIntervalNs Keep alive interval
    @param[in]      aIfc                 RPC interface
    @param[in]      aTftpState           TFTP state

    @retval void

    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP

    @limitations None
*/
int32_t RPC_UDPCommonHandleTxConn(RPC_UDPConnType *aConn,
                               uint64_t aKeepAliveIntervalNs,
                               const RPC_InterfaceType *const aIfc,
                               const TFTP_StateType aTftpState);

/** @brief RPC UDP Interface Get Max Message size

    @behavior Sync, Non-Reentrant

    @param[in]      void

    @return Message Size

    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP

    @limitations None
*/
uint32_t RPC_UDPCommonGetMsgSize(void);

/** @brief Get the event mask for the interface

    API to return the event mask for the interface.

    @behavior Sync, Reentrant

    @pre None

    @param void

    @retval     #uint32_t   Event mask for the interface

    @post None

    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP
*/
uint32_t RPC_UDPCommonGetEventMask(void);

/** @brief RPC UDP Interface Process message

    This API will process messages

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aConn                Receive Connection context
    @param[in]      aKeepAliveIntervalNs Keep alive interval
    @param[in]      aIfc                 RPC interface
    @param[in]      aTftpRxState         TFTP Rx Connection state
    @param[in]      aTftpTxState         TFTP Tx Connection state

    @retval void
    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP

    @limitations None

*/
int32_t RPC_UDPCommonProcessMsg(RPC_UDPConnectionsType *aConnections,
                                uint64_t aKeepAliveIntervalNs,
                                const RPC_InterfaceType *const aIfc,
                                const TFTP_StateType aTftpRxState,
                                const TFTP_StateType aTftpTxState);

#endif /* RPC_UDP_COMMON_H */
/** @} */
