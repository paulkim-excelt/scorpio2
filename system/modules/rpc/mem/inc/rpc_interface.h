/*****************************************************************************
 Copyright 2020-2021 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_rpc_v2_ifc Interface Abstraction
    @ingroup grp_rpc_v2

    @addtogroup grp_rpc_v2_ifc
    @{

    @file rpc_interface.h
    @brief RPC communication interface

    @version 0.1 Initial Version
*/

#ifndef RPC_IFC_H
#define RPC_IFC_H

#include <bcm_err.h>
#include <rpc_mem.h>
#include <module.h>
#include <imgl_interface.h>
/**
    @name RPC interface Architecture IDs
    @{
    @brief Architecture IDs for RPC interface

*/
#define BRCM_SWARCH_RPC_IFC_CHAN_MODE_TYPE       (0x8603U)  /**< @brief #RPC_IfcChanModeType     */
#define BRCM_SWARCH_RPC_IFC_CHAN_TYPE            (0x8604U)  /**< @brief #RPC_IfcChanType         */
#define BRCM_SWARCH_RPC_IFC_INIT_TYPE            (0x8605U)  /**< @brief #RPC_IfcInitType         */
#define BRCM_SWARCH_RPC_IFC_ISCON_TYPE           (0x8606U)  /**< @brief #RPC_IfcIsConnectedType  */
#define BRCM_SWARCH_RPC_IFC_CONNECT_TYPE         (0x8607U)  /**< @brief #RPC_IfcConnectType      */
#define BRCM_SWARCH_RPC_IFC_GETMSGSZ_TYPE        (0x8608U)  /**< @brief #RPC_IfcGetMsgSizeType   */
#define BRCM_SWARCH_RPC_IFC_SENDMSG_TYPE         (0x8609U)  /**< @brief #RPC_IfcSendMsgType      */
#define BRCM_SWARCH_RPC_IFC_RECVMSG_TYPE         (0x860AU)  /**< @brief #RPC_IfcRecvMsgType      */
#define BRCM_SWARCH_RPC_IFC_PROCESSMSG_TYPE      (0x860BU)  /**< @brief #RPC_IfcProcessMsgType   */
#define BRCM_SWARCH_RPC_IFC_DET_STRM_TYPE        (0x860CU)  /**< @brief #RPC_IfcDetectStrmType   */
#define BRCM_SWARCH_RPC_IFC_PROC_STRM_TYPE       (0x860DU)  /**< @brief #RPC_IfcProcessStrmType  */
#define BRCM_SWARCH_RPC_IFC_DISCONNECT_TYPE      (0x860EU)  /**< @brief #RPC_IfcDisconnectType   */
#define BRCM_SWARCH_RPC_IFC_GETEVENTMASK_TYPE    (0x860FU)  /**< @brief #RPC_IfcGetEventMaskType */
#define BRCM_SWARCH_RPC_IFC_DEINIT_TYPE          (0x8610U)  /**< @brief #RPC_IfcDeinitType       */
#define BRCM_SWARCH_RPC_INTERFACE_TYPE           (0x8611U)  /**< @brief #RPC_InterfaceType       */
#define BRCM_SWARCH_RPC_GETMODIFCANDASSOC_PROC   (0x8612U)  /**< @brief #RPC_GetModIfcAndAssoc   */
#define BRCM_SWARCH_RPC_MASTERIFC_GLOBAL         (0x8614U)  /**< @brief #RPC_MasterIfc           */
#define BRCM_SWARCH_RPC_SLAVEIFC_GLOBAL          (0x8615U)  /**< @brief #RPC_SlaveIfc            */
#define BRCM_SWARCH_RPC_IPCMASTERIFC_GLOBAL      (0x8616U)  /**< @brief #RPC_IPCMasterIfc        */
#define BRCM_SWARCH_RPC_IPCSLAVEIFC_GLOBAL       (0x8617U)  /**< @brief #RPC_IPCSlaveIfc         */
#define BRCM_SWARCH_RPC_SOCKETSLAVEIFC_GLOBAL    (0x8618U)  /**< @brief #RPC_SocketSlaveIfc      */
#define BRCM_SWARCH_RPC_SOCKETSLAVE_NAME_MACRO   (0x8619U)  /**< @brief #RPC_SOCKETSLAVE_IFC_NAME*/
#define BRCM_SWARCH_RPC_UDPMASTERIFC_GLOBAL      (0x861AU)  /**< @brief #RPC_UDPMasterIfc        */
#define BRCM_SWARCH_RPC_UDPSLAVEIFC_GLOBAL       (0x861BU)  /**< @brief #RPC_UDPSlaveIfc         */
#define BRCM_SWARCH_RPC_GETMODINTERFACES_PROC    (0x861CU)  /**< @brief #RPC_GetModInterfaces    */
#define BRCM_SWARCH_RPC_GET_SLAVE_IFC_IDX_PROC   (0x861DU)  /**< @brief #RPC_GetSlaveIfcIdx      */
/** @} */

/**
    @name RPC channel mode type
    @{
    @trace #BRCM_SWREQ_RPC_INTERFACE
*/
typedef uint8_t RPC_IfcChanModeType;
#define RPC_IFC_CHAN_MODE_SLAVE    (1U)   /**< @brief RPC channel is in slave mode */
#define RPC_IFC_CHAN_MODE_MASTER   (2U)   /**< @brief RPC channel is in master mode */
/** @} */

/**
    @name RPC channel type
    @{
    @trace #BRCM_SWREQ_RPC_INTERFACE
*/
typedef uint8_t RPC_IfcChanType;
#define RPC_IFC_CHAN_IPC       (0x1U)   /**< @brief IPC channel type      */
#define RPC_IFC_CHAN_UDP       (0x2U)   /**< @brief UDP channel type      */
#define RPC_IFC_CHAN_MSGQ      (0x3U)   /**< @brief MessageQ channel type */
#define RPC_IFC_CHAN_SOCKET    (0x4U)   /**< @brief Socket channel type   */
/** @} */

/** @brief RPC interface Initialization

    interface Function initialize the communication channel

    @behavior Sync, Non-Reentrant

    @param[in]      void

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Init successful
    @retval     #BCM_ERR_UNKNOWN        Init Failed

    @trace  #BRCM_SWREQ_RPC_INTERFACE

    @limitations None
*/
typedef int32_t (*RPC_IfcInitType)(void);

/** @brief RPC interface connection status

    @behavior Sync, Non-Reentrant

    @param[in]      void

    @return     FALSE - Disconnected, TRUE - Connected

    @trace  #BRCM_SWREQ_RPC_INTERFACE

    @limitations None
*/
typedef uint32_t (*RPC_IfcIsConnectedType)(void);

/** @brief RPC interface Connect

    For Master interface, this API will initiate connection to remote slave.
    For Slave interface, this API will listen and return upon connection requests
    This API should be called immediately after Init API

    @behavior Sync, Non-Reentrant

    @param[in]      void

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Connection established
    @retval     #BCM_ERR_NOT_FOUND      No Connection established
    @retval     #BCM_ERR_UNKNOWN        Unknown failure

    @trace  #BRCM_SWREQ_RPC_INTERFACE

    @limitations None
*/
typedef int32_t (*RPC_IfcConnectType)(void);

/** @brief RPC interface Get Max Message size

    @behavior Sync, Non-Reentrant

    @param[in]      void

    @return Message Size

    @trace  #BRCM_SWREQ_RPC_INTERFACE

    @limitations None
*/
typedef uint32_t (*RPC_IfcGetMsgSizeType)(void);

/** @brief RPC interface Send message

    interface Function to send command/response/async notification.
    Size of payload is expected to be the value returned by RPC_IfcGetMsgSizeType
    API in the corresponding interface.

    @behavior Sync, Non-Reentrant

    @param[in]      aHdl                Message Handle to be sent

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Message sent successfully
    @retval     #BCM_ERR_NOMEM          Message not sent out due to lack of
                                        buffers. The operation should be retried.
    @retval     #BCM_ERR_UNKNOWN        There isn't enough space to add appInfo
                                        OR Unknown failure

    @trace  #BRCM_SWREQ_RPC_INTERFACE

    @limitations None
*/
typedef int32_t (*RPC_IfcSendMsgType)(RPC_HdlType aHdl);

/** @brief RPC interface Receive Message

    interface function used to receive message.
    Size of payload is expected to be the value returned by RPC_IfcGetMsgSizeType
    API in the corresponding interface.
    Unknown failures may be recovered only with deinit and init.
    Client needs to invoke this API until #BCM_ERR_NOT_FOUND is got

    @behavior Sync, Non-Reentrant

    @param[out]     aHdl            Handle to received message

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Message received successfully and copied
    @retval     #BCM_ERR_EAGAIN         This API needs to be called again after Detect/Process Stream
    @retval     #BCM_ERR_NOT_FOUND      No Message received
    @retval     #BCM_ERR_UNKNOWN        Unknown failure

    @trace  #BRCM_SWREQ_RPC_INTERFACE

    @limitations None
*/
typedef int32_t (*RPC_IfcRecvMsgType)(RPC_HdlType* const aHdl);

/** @brief RPC interface Process

    Handle any retransmissions and any connection related transitions etc.
    Upon Connection time out, client has to restart from connect request.
    Unknown failures may be recovered only with deinit and init.

    @behavior Sync, Non-Reentrant

    @param[in]      void

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             No Errors found
    @retval     #BCM_ERR_TIME_OUT       Connection timed out
    @retval     #BCM_ERR_UNKNOWN        Unknown failure

    @trace  #BRCM_SWREQ_RPC_INTERFACE

    @limitations None
*/
typedef int32_t (*RPC_IfcProcessMsgType)(void);

/** @brief RPC interface Detect Stream request

    interface function to detect new stream requests
    Unknown failures may be recovered only with deinit and init.

    @behavior Sync, Non-Reentrant

    @param[out]     aHdl            New Stream Handle

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Detected new stream
    @retval     #BCM_ERR_EAGAIN         Detected New stream, call again for more detections
    @retval     #BCM_ERR_NOT_FOUND      No New streams detected
    @retval     #BCM_ERR_UNKNOWN        Unknown failure

    @trace  #BRCM_SWREQ_RPC_INTERFACE

    @limitations None
*/
typedef int32_t (*RPC_IfcDetectStrmType)(RPC_HdlType* const  aHdl);

/** @brief RPC interface Process Stream

    Interface function to read/write to stream and send/receive from remote end.
    Unknown failures may be recovered only with deinit and init.

    NOTE: Every module needs to update its stream processing completion status
    in the #RPC_MemStrmClientInfoType which is part of stream configuration.
    The RPC module frees the stream handle only after the corresponding
    slave and master interfaces indicate stream processing completion.

    @behavior Sync, Non-Reentrant

    @param[in]      aHdl            Stream Handle to be processed
    @param[in]      aPeerState      Stream state of connected peer interface
                                    When this is set to BCM_STATE_SUB_STATE_DONE, interface
                                    must perform any context cleanup and move its stream state
                                    to BCM_STATE_SUB_STATE_DONE as well (need not be done
                                    immediately. Interface has freedom to take multiple calls
                                    to cleanup its context)

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Data processed successfully, stream completed
    @retval     #BCM_ERR_BUSY           Data processed successfully, more data expected
    @retval     #BCM_ERR_UNKNOWN        Unknown failure

    @trace  #BRCM_SWREQ_RPC_INTERFACE

    @limitations None
*/
typedef int32_t (*RPC_IfcProcessStrmType)(RPC_HdlType aHdl, BCM_SubStateType aPeerState);

/** @brief RPC interface Disconnect

    Disconnect any active connection, and perform any connection related cleanup.
    Interface should accept new connection requests after this API call.
    Unknown failures may be recovered only with deinit and init.
    This API should be called just before Deinit API

    @behavior Sync, Non-Reentrant

    @param[in]      void

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Disconnection successful
    @retval     #BCM_ERR_UNKNOWN        Unknown failure

    @trace  #BRCM_SWREQ_RPC_INTERFACE

    @limitations None
*/
typedef int32_t (*RPC_IfcDisconnectType)(void);

/** @brief Get the event mask for the interface

    API to return the event mask for the interface.
    This API gets executed in the context of the caller task.

    @behavior Sync, Reentrant

    @pre None

    @param void

    @retval     uint32_t   Event mask for the interface

    @post None

    @limitations Must return the same event mask at any point of time
    i.e. it cannot be changed dynamically.

    @trace #BRCM_SWREQ_RPC_INTERFACE
*/
typedef uint32_t (*RPC_IfcGetEventMaskType)(void);

/** @brief RPC interface channel de-initialization

    interface function used to deinitialize the channel

    @behavior Sync, Non-Reentrant

    @param[in]      void

    @retval void

    @trace  #BRCM_SWREQ_RPC_INTERFACE

    @limitations None
*/
typedef void (*RPC_IfcDeinitType)(void);

/**
    @brief Function pointer table for each RPC ethsrv interface

    Each RPC ethsrv interface shall expose functions which map to the
    the below function table

    @trace #BRCM_SWREQ_RPC_INTERFACE
 */
typedef struct sRPC_InterfaceType{
    RPC_IfcChanType          type;           /**< @brief Channel type       */
    RPC_IfcChanModeType      mode;           /**< @brief Channel Mode       */
    RPC_AssociationIndexType assoc;          /**< @brief Association        */
    RPC_IfcInitType          init;           /**< @brief Initialize         */
    RPC_IfcIsConnectedType   isConnected;    /**< @brief Is Connected       */
    RPC_IfcConnectType       connect;        /**< @brief Connect            */
    RPC_IfcGetMsgSizeType    getMsgSize;     /**< @brief Get Message Size   */
    RPC_IfcSendMsgType       sendMsg;        /**< @brief Send Message       */
    RPC_IfcRecvMsgType       recvMsg;        /**< @brief Receive Message    */
    RPC_IfcProcessMsgType    processMsg;     /**< @brief Process Message    */
    RPC_IfcDetectStrmType    detectStrm;     /**< @brief Detect New Streams */
    RPC_IfcProcessStrmType   processStrm;    /**< @brief Process Stream     */
    RPC_IfcDisconnectType    disconnect;     /**< @brief Disconnect         */
    RPC_IfcGetEventMaskType  getEventMask;   /**< @brief Get Event Mask     */
    RPC_IfcDeinitType        deinit;         /**< @brief De-Initialize      */
} RPC_InterfaceType;

/**
    @brief RPC Master interface

    @trace #BRCM_SWREQ_RPC_INTERFACE
*/
extern const RPC_InterfaceType RPC_MasterIfc;

/**
    @brief RPC Slave interface

    @trace #BRCM_SWREQ_RPC_INTERFACE
*/
extern const RPC_InterfaceType RPC_SlaveIfc;

/**
    @brief IPC Master Interface

    @trace #BRCM_SWREQ_RPC_INTERFACE
*/
extern const RPC_InterfaceType RPC_IPCMasterIfc;

/**
    @brief IPC Slave Interface

    @trace #BRCM_SWREQ_RPC_INTERFACE
*/
extern const RPC_InterfaceType RPC_IPCSlaveIfc;

/**
    @brief UDP Master Interface

    @trace #BRCM_SWREQ_RPC_INTERFACE
*/
extern const RPC_InterfaceType RPC_UDPMasterIfc;

/**
    @brief UDP Master Interface

    @trace #BRCM_SWREQ_RPC_INTERFACE
*/
extern const RPC_InterfaceType RPC_UDPSlaveIfc;

/**
    @brief Slave socket name for clients to communicate

    @trace #BRCM_SWREQ_RPC_INTERFACE
*/
#define RPC_SOCKETSLAVE_IFC_NAME            "bcm_rpc_socket"

/**
    @brief Socket Slave Interface to be integrated to RPC service

    @trace #BRCM_SWREQ_RPC_INTERFACE
*/
#ifdef RPC_SOCK_CLIENT_MAX_FD
extern const RPC_InterfaceType RPC_SocketSlaveIfc;
_Static_assert(RPC_SOCK_CLIENT_MAX_FD < 32UL, "Maximum number of allowed clients is 32");
#endif

/** @brief Get interface Info

    This APIs returns the Interface And Association of the interface

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aMod             interface Which is requesting the information
    @param[out]     aSlaveIfcID      Interface ID of the slave interface
    @param[out]     aMasterIfcID     Interface ID of the Master interface
    @param[out]     aAssocID         Association ID of the interface

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             ID's are retrieved successfully
    @retval     #BCM_ERR_UNKNOWN        interface Is Not Found

    @post None

    @trace  #BRCM_SWREQ_RPC_INTERFACE

    @limitations None
*/
extern int32_t RPC_GetModIfcAndAssoc(const RPC_InterfaceType *aMod,
                                     RPC_InterfaceIdType *aSlaveIfcID,
                                     RPC_InterfaceIdType *aMasterIfcID,
                                     RPC_AssociationIndexType *aAssocID);

/** @brief Get if its a Valid Peer Interface

    This APIs verifies for a valid peer interface

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aAssoc          Association index
    @param[in]      aType           IMGl Channel Type

    @return     #RPC_InterfaceIdType  Index of corresponding slave interface matching
                                        requested IMGL Channel type (RPC_INTERFACEID_MAX
                                        if not found)

    @post None

    @trace  #BRCM_SWREQ_RPC_INTERFACE

    @limitations None
*/
extern RPC_InterfaceIdType RPC_GetSlaveIfcIdx(RPC_AssociationIndexType aAssoc,
                                              IMGL_ChannelType aType);

/** @brief Get list of interfaces

    This API returns the list of interfaces

    @behavior Sync, Non-reentrant

    @pre None

    Return values are documented in reverse-chronological order
    @retval     Pointer to interface list

    @post None

    @trace  #BRCM_SWREQ_RPC_INTERFACE

    @limitations None
*/
extern const RPC_InterfaceType* const * RPC_GetModInterfaces();

#endif /* RPC_IFC_H */
/** @} */
