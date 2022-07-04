/*****************************************************************************
 Copyright 2021-2022 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_rpc_udp_slv_impl UDP Slave Design
    @ingroup grp_rpc_v2_udp

    @addtogroup grp_rpc_udp_slv_impl
    @{

    @file rpc_udp_slave.c
    @brief UDP Slave Interface Design

    @version 0.1 Initial Version
*/

#include <stddef.h>
#include <string.h>
#include <stdio.h>
#include <bcm_err.h>
#include <bcm_utils.h>
#include <bcm_comp.h>
#include <rpc_mem.h>
#include <rpc_interface.h>
#include <imgl_interface.h>
#include <rpc_udp_common.h>
#include <rpc_ipc_common.h>
#include <rpc_udp_osil.h>
#include <inet.h>
#include <inet_cfg.h>
#include <inet_osil.h>
#include <tftp.h>
#include <udp.h>
#include <ethutils.h>


/**
    @name RPC UDP Slave interface Design IDs
    @{
    @brief Design IDs for RPC UDP slave interface
*/
#define BRCM_SWDSGN_RPC_UDPSLAVECONTEXT_PROC                (0xA701U) /**< @brief #RPC_UDPSlaveContext */
#define BRCM_SWDSGN_RPC_UDPSLAVEFETCHTFTPPARAMS_PROC        (0xA702U) /**< @brief #RPC_UDPSlaveFetchTFTPParams */
#define BRCM_SWDSGN_RPC_UDPSLAVEINITIALIZE_PROC             (0xA703U) /**< @brief #RPC_UDPSlaveInitialize */
#define BRCM_SWDSGN_RPC_UDPSLAVEISCONNECTED_PROC            (0xA704U) /**< @brief #RPC_UDPSlaveIsConnected */
#define BRCM_SWDSGN_RPC_UDPSLAVEHANDLERECVCONN_PROC         (0xA705U) /**< @brief #RPC_UDPSlaveHandleRecvConn */
#define BRCM_SWDSGN_RPC_UDPSLAVEHANDLETRANSMITCONN_PROC     (0xA706U) /**< @brief #RPC_UDPSlaveHandleTransmitConn */
#define BRCM_SWDSGN_RPC_UDPSLAVECONNECT_PROC                (0xA707U) /**< @brief #RPC_UDPSlaveConnect */
#define BRCM_SWDSGN_RPC_UDPSLAVEPROCESSMSG_PROC             (0xA708U) /**< @brief #RPC_UDPSlaveProcessMsg */
#define BRCM_SWDSGN_RPC_UDPSLAVESENDMSG_PROC                (0xA709U) /**< @brief #RPC_UDPSlaveSendMsg */
#define BRCM_SWDSGN_RPC_UDPSLAVERECVMSG_PROC                (0xA70aU) /**< @brief #RPC_UDPSlaveRecvMsg */
#define BRCM_SWDSGN_RPC_UDPSLAVEPROCESSSTREAM_PROC          (0xA70BU) /**< @brief #RPC_UDPSlaveProcessStream */
#define BRCM_SWDSGN_RPC_UDPSLAVEDISCONNECT_PROC             (0xA70CU) /**< @brief #RPC_UDPSlaveDisconnect */
#define BRCM_SWDSGN_RPC_UDPSLAVEDEINITIALIZE_PROC           (0xA70DU) /**< @brief #RPC_UDPSlaveDeinitialize */
#define BRCM_SWDSGN_RPC_UDPSLAVEIFC_GLOBAL                  (0xA70EU) /**< @brief #RPC_UDPSlaveIfc */
/** @} */

/**
    @brief RPC UDP slave Context

    @trace #BRCM_SWARCH_RPC_UDPSLAVEIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP
*/
static RPC_UDPContextType RPC_UDPSlaveContext COMP_SECTION(".bss.rpc");

/** @brief RPC UDP Slave Interface Initialization

    Function to initialize the UDP Slave Interface

    @behavior Sync, Non-Reentrant

    @param[in]      void

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Init successful
    @retval     #BCM_ERR_UNKNOWN        Init Failed

    @trace #BRCM_SWARCH_RPC_UDPSLAVEIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP

    @limitations None

    @code{.unparsed}
    retVal = MCU_GetInfo(&info)
    Clear context
    Retrieve peerId, selfId and assocId using RPC_GetModIfcAndAssoc() and store in context
    if (BCM_ERR_OK == retVal)
        if (INET_IPADDRESS_INVALID != info.tftpServerAddr)
            remoteIP = info.tftpServerAddr
         else if ((TRUE == info.stackingEn) && (MCU_DEVICE_MASTER != info.mstSlvMode))
            remoteIP = (INET_CONVERT_IP_ADDRESS((192U), (168U), (10U), (0U)))
         else
            Nothing

    return RPC_UDPCommonInit(&RPC_UDPSlaveIntfConfig,
                             &RPC_UDPSlaveIfc,
                             &RPC_UDPSlaveContext,
                             INET_INTERFACEID_0,
                             remoteIP)
    @endcode
*/
static int32_t RPC_UDPSlaveInitialize(void)
{
    MCU_InfoType info = {0U};
    INET_IPAddressType remoteIP = INET_MASTER_DEFAULT_IP_ADDR;
    int32_t retVal = MCU_GetInfo(&info);

    if (BCM_ERR_OK == retVal) {
        BCM_MemSet(&RPC_UDPSlaveContext, 0U, sizeof(RPC_UDPSlaveContext));
        retVal = RPC_GetModIfcAndAssoc(&RPC_UDPSlaveIfc,
                                       &RPC_UDPSlaveContext.selfId,
                                       &RPC_UDPSlaveContext.peerId,
                                       &RPC_UDPSlaveContext.assocId);

        if (BCM_ERR_OK == retVal) {
            if (INET_IPADDRESS_INVALID != info.tftpServerAddr) {
                remoteIP = info.tftpServerAddr;
            } else if ((TRUE == info.stackingEn) && (MCU_DEVICE_MASTER != info.mstSlvMode)) {
                remoteIP = INET_MASTER_DEFAULT_IP_ADDR;
            } else {
                /* Nothing */
            }
            retVal = RPC_UDPCommonInit(&RPC_UDPSlaveIntfConfig,
                                       &RPC_UDPSlaveIfc,
                                       &RPC_UDPSlaveContext,
                                       INET_INTERFACEID_0,
                                       remoteIP);
        }
    }

    return retVal;
}

/** @brief RPC UDP Slave Interface connection status

    @trace #BRCM_SWARCH_RPC_UDPSLAVEIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP

    @limitations None

    @code{.unparsed}
    uint32_t isConnected = 0UL
    if ((TFTP_STATE_SEND ==
                    TFTP_GetState(&RPC_UDPSlaveContext.txConn.tftpContext)) &&
        (TFTP_STATE_RECV ==
                    TFTP_GetState(&RPC_UDPSlaveContext.rxConn.tftpContext))) {
        isConnected = 1UL
    return isConnected
    @endcode
*/
static uint32_t RPC_UDPSlaveIsConnected(void)
{
    uint32_t isConnected = 0UL;
    if ((TFTP_STATE_SEND ==
                    TFTP_GetState(&RPC_UDPSlaveContext.connections.tx.tftpContext)) &&
        (TFTP_STATE_RECV ==
                    TFTP_GetState(&RPC_UDPSlaveContext.connections.rx.tftpContext))) {
        isConnected = 1UL;
    }
    return isConnected;
}

/** @brief RPC UDP Slave Interface Disconnect

    @trace #BRCM_SWARCH_RPC_UDPSLAVEIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP

    @limitations None

    @code{.unparsed}
    RPC_UDPCommonDisconnect(&RPC_UDPSlaveContext.connections)
    return BCM_ERR_OK
    @endcode
*/
static int32_t RPC_UDPSlaveDisconnect(void)
{
    RPC_UDPCommonDisconnect(&RPC_UDPSlaveContext.connections);

    return BCM_ERR_OK;
}

/** @brief Handle receive connection requests from UDP master

    This API handles connections for the receive connection

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aConn       Receive Connection context

    @retval void

    @trace #BRCM_SWARCH_RPC_UDPSLAVEIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP

    @code{.unparsed}
    RPC_UDPCommonHandleRxConn(aConn, &RPC_UDPSlaveIfc, TFTP_STATE_RECV)
    @endcode
*/
static void RPC_UDPSlaveHandleRecvConn(RPC_UDPConnType *aConn)
{
    (void)RPC_UDPCommonHandleRxConn(aConn, &RPC_UDPSlaveIfc, TFTP_STATE_RECV);
}

/** @brief Handle transmit connection requests from UDP master

    This API handles connections for the transmit connection

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aConn       Transmit Connection context

    @retval void

    @trace #BRCM_SWARCH_RPC_UDPSLAVEIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP

    @code{.unparsed}
    RPC_UDPCommonHandleTxConn(aConn, RPC_UDPSlaveContext.keepAliveIntervalNs, &RPC_UDPSlaveIfc, TFTP_STATE_SEND)
    @endcode
*/
static void RPC_UDPSlaveHandleTransmitConn(RPC_UDPConnType *aConn)
{
    (void)RPC_UDPCommonHandleTxConn(aConn, RPC_UDPSlaveContext.keepAliveIntervalNs, &RPC_UDPSlaveIfc, TFTP_STATE_SEND);
}

/** @brief RPC UDP Slave Interface Connect

    @trace #BRCM_SWARCH_RPC_UDPSLAVEIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP

    @code{.unparsed}
    int32_t retVal
    uint8_t fileName[TFTP_MAX_FILENAME_LEN]
    TFTP_PacketType packetType
    uint32_t clientIPAddr
    uint16_t clientPort
    TFTP_OptionCfgType options
    RPC_UDPConnType *rxConn = &RPC_UDPSlaveContext.rxConn
    RPC_UDPConnType *txConn = &RPC_UDPSlaveContext.txConn
    uint8_t errStr[64] = "Connection from invalid client IP\n"
    TFTP_ConfigType config =
        .compId        = BCM_RPC_ID,
        .payloadId     = 0U,
        .remoteIPAddr  = RPC_UDPSlaveContext.remoteIPAddr,
        .maxRetryCount = RPC_UDPSlaveContext.maxRetryCount,
        .timeoutInms   = RPC_UDPSlaveContext.retryIntervalMs,

    do
        retVal = TFTP_DetectPacket(BCM_RPC_ID, RPC_UDPSlaveContext.serverPayloadId,
                                   fileName, &packetType, &clientIPAddr, &clientPort, &options)
        if(BCM_ERR_OK == retVal)
            Update config based on client IP address
            config.remoteIPAddr = clientIPAddr

            if (TFTP_PACKET_WRQ == packetType)
                For rxConn channel, connected UDP master will issue a write request
                config.payloadId = rxConn->payloadId
                Make sure both connections are from same UDP master IP address
                if ((TFTP_STATE_SEND == TFTP_GetState(&txConn->tftpContext)) &&
                    (clientIPAddr != txConn->tftpContext.cfg.remoteIPAddr))
                    retVal = TFTP_ServerRejectConnection(BCM_RPC_ID,
                                                         rxConn->payloadId,
                                                         clientIPAddr, clientPort,
                                                         TFTP_ERROR_ACCESS_VIOLATION,
                                                         errStr)
                 else
                    retVal = TFTP_Init(&rxConn->tftpContext, &config)
                    if (BCM_ERR_OK == retVal)
                        retVal = TFTP_ServerAcceptConnection(&rxConn->tftpContext,
                                                             clientPort, FALSE)
                        rxConn->stats.numConnects++
                        rxConn->stats.connTimeNs = BCM_GetTimeNs()
                        call function to send a ACK packet
                        RPC_UDPSlaveHandleRecvConn(rxConn)
             else if (TFTP_PACKET_RRQ == packetType)
                For txConn channel, connected UDP master will issue a read request
                txConn = &RPC_UDPSlaveContext.txConn
                config.payloadId = txConn->payloadId
                Make sure both connections are from same UDP master IP address
                if ((TFTP_STATE_RECV == TFTP_GetState(&rxConn->tftpContext)) &&
                    (clientIPAddr != rxConn->tftpContext.cfg.remoteIPAddr))
                    retVal = TFTP_ServerRejectConnection(BCM_RPC_ID,
                                                         txConn->payloadId,
                                                         clientIPAddr, clientPort,
                                                         TFTP_ERROR_ACCESS_VIOLATION,
                                                         errStr)
                 else
                    retVal = TFTP_Init(&txConn->tftpContext, &config)
                    if (BCM_ERR_OK == retVal)
                        retVal = TFTP_ServerAcceptConnection(&txConn->tftpContext, clientPort, TRUE)
                        txConn->stats.numConnects++
                        txConn->stats.connTimeNs = BCM_GetTimeNs()
                        call function to send a PING packet
                        RPC_UDPSlaveHandleTransmitConn(txConn)
             else
                 Log error
                retVal = BCM_ERR_UNKNOWN
                break
    while (BCM_ERR_OK == retVal)
    return BCM_ERR_OK
    @endcode
*/
static int32_t RPC_UDPSlaveConnect(void)
{
    int32_t retVal;
    uint8_t fileName[TFTP_MAX_FILENAME_LEN];
    TFTP_PacketType packetType = TFTP_PACKET_INVALID;
    uint32_t clientIPAddr = INET_IPADDRESS_INVALID;
    uint16_t clientPort = INET_PORT_INVALID;
    TFTP_OptionCfgType options;
    RPC_UDPConnType *rxConn = &RPC_UDPSlaveContext.connections.rx;
    RPC_UDPConnType *txConn = &RPC_UDPSlaveContext.connections.tx;
    uint8_t errStr[64] = "Connection from invalid client IP\n";
    TFTP_ConfigType config = {
        .compId        = BCM_RPC_ID,
        .payloadId     = 0U,
        .remoteIPAddr  = RPC_UDPSlaveContext.remoteIPAddr,
        .maxRetryCount = RPC_UDPSlaveContext.maxRetryCount,
        .timeoutInms   = RPC_UDPSlaveContext.msgRetryIntervalMs,
    };

    do {
        retVal = TFTP_DetectPacket(BCM_RPC_ID, RPC_UDPSlaveContext.connections.serverPayloadId,
                                   fileName, &packetType, &clientIPAddr, &clientPort, &options);
        if(BCM_ERR_OK == retVal) {
            /* Update config based on client IP address */
            config.remoteIPAddr = clientIPAddr;

            if (TFTP_PACKET_WRQ == packetType) {
                /* For rxConn channel, connected UDP master will issue a write request */
                config.payloadId = rxConn->payloadId;
                /* Make sure both connections are from same UDP master IP address */
                if ((TFTP_STATE_SEND == TFTP_GetState(&txConn->tftpContext)) &&
                    (clientIPAddr != txConn->tftpContext.cfg.remoteIPAddr)) {
                    retVal = TFTP_ServerRejectConnection(BCM_RPC_ID,
                                                         rxConn->payloadId,
                                                         clientIPAddr, clientPort,
                                                         TFTP_ERROR_ACCESS_VIOLATION,
                                                         errStr);
                } else {
                    retVal = TFTP_Init(&rxConn->tftpContext, &config);
                    if (BCM_ERR_OK == retVal) {
                        retVal = TFTP_ServerAcceptConnection(&rxConn->tftpContext, clientPort, FALSE);
                        rxConn->stats.numConnects++;
                        rxConn->stats.connTimeNs = BCM_GetTimeNs();
                        /* call function to send a ACK packet */
                        RPC_UDPSlaveHandleRecvConn(rxConn);
                    }
                }
            } else if (TFTP_PACKET_RRQ == packetType) {
                /* For txConn channel, connected UDP master will issue a read request */
                txConn = &RPC_UDPSlaveContext.connections.tx;
                config.payloadId = txConn->payloadId;
                /* Make sure both connections are from same UDP master IP address */
                if ((TFTP_STATE_RECV == TFTP_GetState(&rxConn->tftpContext)) &&
                    (clientIPAddr != rxConn->tftpContext.cfg.remoteIPAddr)) {
                    retVal = TFTP_ServerRejectConnection(BCM_RPC_ID, txConn->payloadId, clientIPAddr,
                                                        clientPort, TFTP_ERROR_ACCESS_VIOLATION, errStr);
                } else {
                    retVal = TFTP_Init(&txConn->tftpContext, &config);
                    if (BCM_ERR_OK == retVal) {
                        retVal = TFTP_ServerAcceptConnection(&txConn->tftpContext, clientPort, TRUE);
                        txConn->stats.numConnects++;
                        txConn->stats.connTimeNs = BCM_GetTimeNs();
                        /* call function to send a PING packet */
                        RPC_UDPSlaveHandleTransmitConn(txConn);
                    }
                }
            } else {
                /* Log error */
                retVal = BCM_ERR_UNKNOWN;
                break;
            }
        }
    } while (BCM_ERR_OK == retVal);

    return BCM_ERR_OK;
}

/** @brief RPC UDP Slave Interface Process Message

    @trace #BRCM_SWARCH_RPC_UDPSLAVEIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP

    @code{.unparsed}
    return RPC_UDPCommonProcessMsg(&RPC_UDPSlaveContext.connections,
                                   RPC_UDPSlaveContext.keepAliveIntervalNs,
                                   &RPC_UDPSlaveIfc,
                                   TFTP_STATE_RECV,
                                   TFTP_STATE_SEND)
    @endcode
*/
static int32_t RPC_UDPSlaveProcessMsg(void)
{
    return RPC_UDPCommonProcessMsg(&RPC_UDPSlaveContext.connections,
                                   RPC_UDPSlaveContext.keepAliveIntervalNs,
                                   &RPC_UDPSlaveIfc,
                                   TFTP_STATE_RECV,
                                   TFTP_STATE_SEND);
}

/** @brief RPC UDP Slave Interface Send message

    Interface Function to send response/async message

    @trace #BRCM_SWARCH_RPC_UDPSLAVEIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP

    @code{.unparsed}
    int32_t retVal
    RPC_UDPConnType *conn = &RPC_UDPSlaveContext.txConn
    RPC_MemMsgType *msg = (RPC_MemMsgType*)conn->msgBuffer
    RPC_MemMsgType *inMsg
    uint32_t procLen = 0UL
    if (TFTP_STATE_SEND == TFTP_GetState(&conn->tftpContext))
        inMsg = RPC_MsgGet(aHdl)
        if (NULL != inMsg)
            BCM_MemCpy(msg, inMsg, sizeof(RPC_MemMsgType))
            retVal = TFTP_PutDataHandler(&conn->tftpContext,
                                         conn->msgBuffer, TFTP_DEFAULT_DATA_LEN,
                                         &procLen, FALSE)
            if (BCM_ERR_BUSY != retVal)
                RPC_UDPSlaveDisconnect()
                retVal = BCM_ERR_UNKNOWN
            else if (TFTP_DEFAULT_DATA_LEN != procLen)
                In a case if PING was sent, but ACK is awaited. This response
                will not be transmitted until ACK is got for PING
                RPC module will retry
                retVal = BCM_ERR_NOMEM
            else
                conn->lastTxTime = BCM_GetTimeNs()
                retVal = BCM_ERR_OK
                RPC_Release(aHdl)
        else
            retVal = BCM_ERR_UNKNOWN
    else
        In case connection is not active, then drop the packet
        RPC_Release(aHdl)
        conn->stats.sendMsgDrop++
        retVal = BCM_ERR_OK
    return retVal
    @endcode
*/
static int32_t RPC_UDPSlaveSendMsg(RPC_HdlType aHdl)
{
    int32_t retVal;
    RPC_UDPConnType *conn = &RPC_UDPSlaveContext.connections.tx;
    RPC_MemMsgType *msg = (RPC_MemMsgType*)conn->msgBuffer;
    RPC_MemMsgType *inMsg;
    uint32_t procLen = 0UL;

    if (TFTP_STATE_SEND == TFTP_GetState(&conn->tftpContext)) {
        inMsg = RPC_MsgGet(aHdl);
        if (NULL != inMsg) {
            BCM_MemCpy(msg, inMsg, sizeof(RPC_MemMsgType));
            retVal = TFTP_PutDataHandler(&conn->tftpContext,
                                         conn->msgBuffer, TFTP_DEFAULT_DATA_LEN,
                                         &procLen, FALSE);
            if (BCM_ERR_BUSY != retVal) {
                RPC_UDPSlaveDisconnect();
                retVal = BCM_ERR_UNKNOWN;
            } else if (TFTP_DEFAULT_DATA_LEN != procLen) {
                /* In a case if PING was sent, but ACK is awaited. This response */
                /* will not be transmitted until ACK is got for PING             */
                /* RPC module will retry                                         */
                retVal = BCM_ERR_NOMEM;
            } else {
                conn->lastTxTime = BCM_GetTimeNs();
                retVal = BCM_ERR_OK;
                RPC_Release(aHdl);
            }
        } else {
            retVal = BCM_ERR_UNKNOWN;
        }
    } else {
        /* In case connection is not active, then drop the packet */
        RPC_Release(aHdl);
        conn->stats.sendMsgDrop++;
        retVal = BCM_ERR_OK;
    }

    return retVal;
}

/** @brief RPC UDP Slave Interface Receive Message

    @trace #BRCM_SWARCH_RPC_UDPSLAVEIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP

    @limitations None

    @code{.unparsed}
    int32_t retVal
    RPC_MemMsgType *msg = NULL
    uint32_t filledBufLen = 0UL
    RPC_UDPConnType *conn = &RPC_UDPSlaveContext.rxConn
    if(TFTP_STATE_RECV == TFTP_GetState(&conn->tftpContext))
        retVal = RPC_MsgAlloc(RPC_HDL_INVALID,
                              RPC_UDPSlaveContext.selfId,
                              RPC_UDPSlaveContext.peerId,
                              RPC_UDPSlaveContext.assocId,
                              aHdl)
        if (BCM_ERR_OK != retVal)
            retVal = BCM_ERR_NOT_FOUND
         else
            A command packet was got during the 'process' call
            if (TRUE == conn->isMsgPending)
                filledBufLen = TFTP_DEFAULT_DATA_LEN
                retVal = BCM_ERR_BUSY
                conn->isMsgPending = FALSE
             else
             do
                filledBufLen = 0UL;
                retVal = TFTP_GetDataHandler(&conn->tftpContext, conn->msgBuffer,
                                              TFTP_DEFAULT_DATA_LEN, &filledBufLen);
             } while (retVal is BCM_ERR_NOMEM)
            if (BCM_ERR_BUSY != retVal)
                connection timeout (lost), Log error
                RPC_UDPSlaveDisconnect()
                RPC_Release(*aHdl)
                retVal = BCM_ERR_UNKNOWN
             else if (TFTP_DEFAULT_DATA_LEN == filledBufLen)
                msg = RPC_MsgGet(*aHdl)
                BCM_MemCpy(msg, conn->msgBuffer, sizeof(RPC_MemMsgType))
                if (RPC_UDP_KEEPALIVE_CMD == msg->cmd)
                    Discard keepalive message
                    RPC_Release(*aHdl)
                    retVal = BCM_ERR_NOT_FOUND
                 else
                    retVal = BCM_ERR_OK
            else
                RPC_Release(*aHdl);
                retVal = BCM_ERR_NOT_FOUND;
     else
         Log error
        retVal = BCM_ERR_NOT_FOUND
    return retVal
    @endcode
*/
static int32_t RPC_UDPSlaveRecvMsg(RPC_HdlType* const aHdl)
{
    int32_t retVal;
    RPC_MemMsgType *msg = NULL;
    uint32_t filledBufLen = 0UL;
    RPC_UDPConnType *conn = &RPC_UDPSlaveContext.connections.rx;

    if(TFTP_STATE_RECV == TFTP_GetState(&conn->tftpContext)) {
        retVal = RPC_MsgAlloc(RPC_HDL_INVALID,
                              RPC_UDPSlaveContext.selfId,
                              RPC_UDPSlaveContext.peerId,
                              RPC_UDPSlaveContext.assocId,
                              aHdl);
        if (BCM_ERR_OK != retVal) {
            retVal = BCM_ERR_NOT_FOUND;
        } else {
            /* A command packet was got during the 'process' call */
            if (TRUE == conn->isMsgPending) {
                filledBufLen = TFTP_DEFAULT_DATA_LEN;
                retVal = BCM_ERR_BUSY;
                conn->isMsgPending = FALSE;
            } else {
                /* try to fetch command from UDP master */
                do {
                    filledBufLen = 0UL;
                    retVal = TFTP_GetDataHandler(&conn->tftpContext,
                                                 conn->msgBuffer,
                                                 TFTP_DEFAULT_DATA_LEN,
                                                 &filledBufLen);
                } while(BCM_ERR_NOMEM == retVal);
            }

            if (BCM_ERR_BUSY != retVal) {
                /* connection timeout (lost), Log error */
                RPC_UDPSlaveDisconnect();
                RPC_Release(*aHdl);
                retVal = BCM_ERR_UNKNOWN;
            } else if (TFTP_DEFAULT_DATA_LEN == filledBufLen) {
                msg = RPC_MsgGet(*aHdl);
                if (NULL != msg) {
                    BCM_MemCpy(msg, conn->msgBuffer, sizeof(RPC_MemMsgType));
                    if (RPC_UDP_KEEPALIVE_CMD == msg->cmd) {
                        /* Discard keepalive message */
                        RPC_Release(*aHdl);
                        retVal = BCM_ERR_NOT_FOUND;
                    } else {
                        retVal = BCM_ERR_OK;
                    }
                } else {
                    retVal = BCM_ERR_UNKNOWN;
                }
            } else {
                RPC_Release(*aHdl);
                retVal = BCM_ERR_NOT_FOUND;
            }
        }
    } else {
        /* Log error */
        retVal = BCM_ERR_NOT_FOUND;
    }

    return retVal;
}

/** @brief RPC UDP Slave fetch TFTP config params

    Internal API that detects if DHCP IP acquistion needs to be
    initiated. It also fetches the bootfile name and TFTP server
    IP address (if present) from the DHCP offer. In case if bootfile
    name is not provided by DHCP, it creates the filename.

    @behavior Sync, Non-reentrant

    @pre None

    @param[out]     aFileName          Pointer to store the boot filename
                                       got from the DHCP offer
    @param[in]      aFileNameSize      File name size in bytes
    @param[inout]   aTFTPServerAddr    IP address from OTP is input and TFTP server
                                       IP provided by DHCP offer is sent as output
    @param[in]      aStrmCfg           Stream configuration

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             TFTP server IP and bootfile picked successfully
    @retval     #BCM_ERR_BUSY           In process of getting the params
    @retval     #BCM_ERR_UNKNOWN        Unknown error

    @post None

    @trace #BRCM_SWARCH_RPC_UDPSLAVEIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP

    @limitations None

    @code{.unparsed}
    retVal = INET_GetInterface(INET_INTERFACEID_0  INET_SlaveIf , &inetSlaveIfState)
    if (BCM_ERR_OK != retVal)
        retVal = BCM_ERR_UNKNOWN
     else
        switch (RPC_UDPSlaveContext.ifcInitState)
            case BCM_STATE_SUB_STATE_RESET:
                if (INET_IPADDRESSASSIGNMENT_STATIC != inetSlaveIfState->cfg.addressType)
                    (void)INET_UpdateInterface(INET_INTERFACEID_0  INET_SlaveIf ,
                                               INET_IPADDRESSASSIGNMENT_DYNAMIC, INET_IPADDRESS_INVALID,
                                               INET_IPADDRESS_INVALID, INET_IPADDRESS_INVALID, &intfParams)
                    retVal = INET_StartDHCP()
                    RPC_UDPSlaveContext.ifcInitState = BCM_STATE_SUB_STATE_STAGE0
                    retVal = BCM_ERR_BUSY
                 else
                    Continue with stream processing as IFC uses static IP
                    RPC_UDPSlaveContext.ifcInitState = BCM_STATE_SUB_STATE_STAGE1
                    ETHUTILS_CreateBootFilename(aFileName, aStrmCfg->imgId, aStrmCfg->pid,
                                               aStrmCfg->offset, aStrmCfg->xferSize, aStrmCfg->isTbl)
                    retVal = BCM_ERR_OK
                break
            case BCM_STATE_SUB_STATE_STAGE0:
                Check if valid DHCP IP is got
                if (INET_IPADDRESS_INVALID != inetSlaveIfState->cfg.ipAddress)
                    In case of DHCP, get the remote TFTP server IP and bootfile name
                    if ((1U == aStrmCfg->pid) && (0U == aStrmCfg->imgId))
                        Use the DHCP bootfile name (if provided) only for ROM image fetch (pid=1, imgID=0)
                        dhcpParamLen = aFileNameSize
                        (void)DHCP_GetParameter(0UL, DHCP_PARAM_BOOT_FILE_NAME, aFileName, &dhcpParamLen)
                    if (0UL == BCM_StrnLen((const char *)aFileName, TFTP_MAX_FILENAME_LEN))
                         Compose file name if its not provided by DHCP offer
                        ETHUTILS_CreateBootFilename(aFileName, aStrmCfg->imgId, aStrmCfg->pid,
                                                   aStrmCfg->offset, aStrmCfg->xferSize, aStrmCfg->isTbl)
                    dhcpParamLen = sizeof(ipAddr)
                    (void)DHCP_GetParameter(0UL, DHCP_PARAM_TFTP_SERVER_ADDR, (uint8_t*)&ipAddr, &dhcpParamLen)
                    if (INET_IPADDRESS_INVALID != ipAddr)
                         Use the TFTP server IP provided by DHCP offer
                        *aTFTPServerAddr = ipAddr
                    retVal = BCM_ERR_OK
                 else
                    retVal = BCM_ERR_BUSY
                break
            default:
                retVal = BCM_ERR_UNKNOWN
                break
    return retVal
    @endcode
*/
static int32_t RPC_UDPSlaveFetchTFTPParams(uint8_t *aFileName,
                                           uint32_t aFileNameSize,
                                           INET_IPAddressType *aTFTPServerAddr,
                                           RPC_StrmCfgType *aStrmCfg)
{
    int32_t retVal = BCM_ERR_BUSY;
    INET_InterfaceStateType *inetSlaveIfState = NULL;
    INET_InterfaceVlanTagConfigType intfParams = {0U, 0U};
    uint32_t dhcpParamLen = 0UL;
    INET_IPAddressType ipAddr = INET_IPADDRESS_INVALID;

    retVal = INET_GetInterface(INET_INTERFACEID_0 /* INET_SlaveIf */, &inetSlaveIfState);
    if (BCM_ERR_OK != retVal) {
        retVal = BCM_ERR_UNKNOWN;
    } else {
        switch (RPC_UDPSlaveContext.ifcInitState) {
            case BCM_STATE_SUB_STATE_RESET:
                if (INET_IPADDRESSASSIGNMENT_STATIC != inetSlaveIfState->cfg.addressType) {
                    (void)INET_UpdateInterface(INET_INTERFACEID_0 /* INET_SlaveIf */,
                                               INET_IPADDRESSASSIGNMENT_DYNAMIC, INET_IPADDRESS_INVALID,
                                               INET_IPADDRESS_INVALID, INET_IPADDRESS_INVALID, &intfParams);
                    retVal = INET_StartDHCP();
                    RPC_UDPSlaveContext.ifcInitState = BCM_STATE_SUB_STATE_STAGE0;
                    retVal = BCM_ERR_BUSY;
                } else {
                    /* Continue with stream processing as IFC uses static IP */
                    ETHUTILS_CreateBootFilename(aFileName, aStrmCfg->imgId, aStrmCfg->pid,
                                               aStrmCfg->offset, aStrmCfg->xferSize, aStrmCfg->isTbl);
                    retVal = BCM_ERR_OK;
                }
                break;
            case BCM_STATE_SUB_STATE_STAGE0:
                /* Check if valid DHCP IP is got */
                if (INET_IPADDRESS_INVALID != inetSlaveIfState->cfg.ipAddress) {
                    /* In case of DHCP, get the remote TFTP server IP and bootfile name */
                    if ((1U == aStrmCfg->pid) && (0U == aStrmCfg->imgId)) {
                        /* Use the DHCP bootfile name (if provided) only for ROM image fetch (pid=1, imgID=0) */
                        dhcpParamLen = aFileNameSize;
                        (void)DHCP_GetParameter(0UL, DHCP_PARAM_BOOT_FILE_NAME, aFileName, &dhcpParamLen);
                    }
                    if (0UL == BCM_StrnLen((const char *)aFileName, TFTP_MAX_FILENAME_LEN)) {
                        /* Compose file name if its not provided by DHCP offer */
                        ETHUTILS_CreateBootFilename(aFileName, aStrmCfg->imgId, aStrmCfg->pid,
                                                   aStrmCfg->offset, aStrmCfg->xferSize, aStrmCfg->isTbl);
                    }
                    dhcpParamLen = sizeof(ipAddr);
                    (void)DHCP_GetParameter(0UL, DHCP_PARAM_TFTP_SERVER_ADDR, (uint8_t*)&ipAddr, &dhcpParamLen);
                    if (INET_IPADDRESS_INVALID != ipAddr) {
                        /* Use the TFTP server IP provided by DHCP offer */
                        *aTFTPServerAddr = ipAddr;
                    }
                    retVal = BCM_ERR_OK;
                } else {
                    retVal = BCM_ERR_BUSY;
                }
                break;
            default:
                retVal = BCM_ERR_UNKNOWN;
                break;
        }
    }
    return retVal;
}

/** @brief RPC UDP Slave Interface Process Stream

    @trace #BRCM_SWARCH_RPC_UDPSLAVEIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP

    @code{.unparsed}
    int32_t retVal
    uint32_t index = 0UL
    RPC_StrmCfgType strmCfg
    TFTP_StateType prevState
    uint8_t fileName[DHCP_MAX_FILENAME_LEN] = 0U
    uint32_t freeSize = 0UL
    uint32_t accLen = 0UL
    uint32_t filledBufLen = 0UL
    TFTP_ContextType *strmCtxt = NULL
    TFTP_ConfigType config =
        .compId        = BCM_RPC_ID,
        .payloadId     = 0U,
        .remoteIPAddr  = RPC_UDPSlaveContext.remoteIPAddr,
        .maxRetryCount = RPC_UDPSlaveContext.maxRetryCount,
        .timeoutInms   = RPC_UDPSlaveContext.retryIntervalMs,

    If there is a active connection, use IP address from corresponding
    Use remote IP addr from OSIL if there is no active rxConn/txConn
    TFTP context
    if ((TFTP_STATE_SEND == RPC_UDPSlaveContext.txConn.tftpContext.state) ||
        (INET_IPADDRESS_INVALID != RPC_UDPSlaveContext.txConn.tftpContext.cfg.remoteIPAddr))
        config.remoteIPAddr = RPC_UDPSlaveContext.txConn.tftpContext.cfg.remoteIPAddr
    else if ((TFTP_STATE_RECV == RPC_UDPSlaveContext.rxConn.tftpContext.state) ||
            (INET_IPADDRESS_INVALID != RPC_UDPSlaveContext.rxConn.tftpContext.cfg.remoteIPAddr))
        config.remoteIPAddr = RPC_UDPSlaveContext.rxConn.tftpContext.cfg.remoteIPAddr
    else
        MISRA

    retVal = RPC_StrmGetCfg(aHdl, &strmCfg)
    if (BCM_ERR_OK == retVal)
        index = RPC_MemGetIndex(aHdl)
        strmCtxt = &RPC_UDPSlaveContext.streamTftpContext[index]
        slaveClientInfo = RPC_StrmGetSlaveClientInfo(aHdl)
        if (NULL == slaveClientInfo)
            retVal = BCM_ERR_UNKNOWN
    else
        retVal = BCM_ERR_UNKNOWN

    if (BCM_ERR_OK == retVal) && (TFTP_STATE_RESET == TFTP_GetState(strmCtxt)
        retVal = RPC_UDPSlaveFetchTFTPParams(fileName, sizeof(fileName),
                                            &config.remoteIPAddr,
                                            &strmCfg)

    Proceed only after all stream details are fetched successfully
    if (BCM_ERR_OK == retVal)
        do
            prevState = strmCtxt->state
            switch (strmCtxt->state)
            case TFTP_STATE_RESET:
                Setup the TFTP option for 1428 byte blocksize
                config.options.count = 1U
                config.options.list[0UL].type = TFTP_OPTION_BLKSIZE
                config.options.list[0UL].val  = TFTP_MAX_DATA_LEN
                config.payloadId = RPC_UDPSlaveContext.streamPayloadId[index]
                retVal = TFTP_Init(strmCtxt, &config)
                if (BCM_ERR_OK == retVal) && (INET_IPADDRESS_INVALID != config.remoteIPAddr)
                    Construct the filename from aCmdID, aPID, aImgID aOffset, & aMaxSize
                    ETHUTILS_CreateBootFilename(fileName, strmCfg.imgId, strmCfg.pid,
                                            strmCfg.offset, strmCfg.xferSize, strmCfg.isTbl)
                    retVal = TFTP_ClientRead(strmCtxt, fileName)
                    if (BCM_ERR_OK != retVal)
                        retVal = BCM_ERR_UNKNOWN
                    else
                        retVal = BCM_ERR_BUSY
                else
                    retVal = BCM_ERR_UNKNOWN
                break
            case TFTP_STATE_READ:
                (void)RPC_StrmGetFreeSz(aHdl, &freeSize, &accLen)
                if (TFTP_MAX_DATA_LEN <= freeSize)
                    do {
                        filledBufLen = 0UL
                        retVal = TFTP_GetDataHandler(strmCtxt, RPC_UDPSlaveContext.streamBuffer,
                                                TFTP_MAX_DATA_LEN, &filledBufLen)
                    } while (BCM_ERR_NOMEM == retVal)
                    Handling based on error code
                    if (BCM_ERR_OK == retVal)
                        stream processing complete
                        slaveClientInfo->state = BCM_STATE_SUB_STATE_DONE
                    else if (BCM_ERR_BUSY != retVal)
                        retVal = BCM_ERR_UNKNOWN
                        slaveClientInfo->state = BCM_STATE_SUB_STATE_DONE
                    else
                        Write any stream data received
                        if (0UL < filledBufLen)
                            retVal = RPC_StrmWrite(aHdl,
                                                RPC_UDPSlaveContext.streamBuffer,
                                                filledBufLen)
                            if (BCM_ERR_NOMEM == retVal)
                                retVal = BCM_ERR_BUSY
                        tftpPktState = TFTP_GetPacketProcState(strmCtxt);
                        if ((TFTP_PACKETSTATE_LAST_PENDING == tftpPktState) ||
                            (TFTP_PACKETSTATE_LAST_SENT == tftpPktState))
                            (void)RPC_StrmGetFreeSz(aHdl, &freeSize, &accLen)
                            (void)RPC_StrmSetXferSize(aHdl, accLen)
                else
                    retVal = BCM_ERR_BUSY
                break
                default:
                retVal = BCM_ERR_UNKNOWN
                break
        while (prevState != strmCtxt->state) && (BCM_STATE_SUB_STATE_DONE != slaveClientInfo->state)
    if (BCM_ERR_BUSY != retVal)
        if (NULL != slaveClientInfo)
            slaveClientInfo->state = BCM_STATE_SUB_STATE_DONE
        TFTP_DeInit(strmCtxt)
    return retVal
    @endcode
*/
static int32_t RPC_UDPSlaveProcessStream(RPC_HdlType aHdl, BCM_SubStateType aPeerResponse)
{
    int32_t retVal;
    uint32_t index = 0UL;
    RPC_StrmCfgType strmCfg;
    TFTP_StateType prevState;
    uint8_t fileName[DHCP_MAX_FILENAME_LEN] = {0U};
    uint32_t freeSize = 0UL;
    uint32_t accLen = 0UL;
    uint32_t filledBufLen = 0UL;
    TFTP_ContextType *strmCtxt = NULL;
    RPC_MemStrmClientInfoType *slaveClientInfo = NULL;
    TFTP_PacketStateType tftpPktState;
    TFTP_ConfigType config = {
        .compId        = BCM_RPC_ID,
        .payloadId     = 0U,
        .remoteIPAddr  = RPC_UDPSlaveContext.remoteIPAddr,
        .maxRetryCount = RPC_UDPSlaveContext.maxRetryCount,
        .timeoutInms   = RPC_UDPSlaveContext.streamRetryIntervalMs,
    };
    BCM_MemSet(fileName, 0U, sizeof(fileName));
    BCM_MemSet(&strmCfg, 0U, sizeof(RPC_StrmCfgType));

    /* Use remote IP addr from OSIL if there is no active rxConn/txConn. If there is */
    /* a active connection, use IP address from corresponding TFTP context           */
    if ((TFTP_STATE_SEND == TFTP_GetState(&RPC_UDPSlaveContext.connections.tx.tftpContext)) ||
        (INET_IPADDRESS_INVALID != RPC_UDPSlaveContext.connections.tx.tftpContext.cfg.remoteIPAddr)) {
        config.remoteIPAddr = RPC_UDPSlaveContext.connections.tx.tftpContext.cfg.remoteIPAddr;
    } else if ((TFTP_STATE_RECV == TFTP_GetState(&RPC_UDPSlaveContext.connections.rx.tftpContext)) ||
               (INET_IPADDRESS_INVALID != RPC_UDPSlaveContext.connections.rx.tftpContext.cfg.remoteIPAddr)) {
        config.remoteIPAddr = RPC_UDPSlaveContext.connections.rx.tftpContext.cfg.remoteIPAddr;
    } else {
    }

    retVal = RPC_StrmGetCfg(aHdl, &strmCfg);
    if (BCM_ERR_OK == retVal) {
        index = RPC_MemGetIndex(aHdl);
        strmCtxt = &RPC_UDPSlaveContext.connections.streams[index].tftpContext;
        slaveClientInfo = RPC_StrmGetSlaveClientInfo(aHdl);
        if (NULL == slaveClientInfo) {
            retVal = BCM_ERR_UNKNOWN;
        }
    } else {
        retVal = BCM_ERR_UNKNOWN;
    }

    /* Check for filename and TFTP server IP only when stream is in RESET state */
    if ((BCM_ERR_OK == retVal) && (TFTP_STATE_RESET == TFTP_GetState(strmCtxt))) {
        /* Check if INET network IFC needs initialization    */
        /* If no IP is configured, initiate DHCP request     */
        /* Fetch the Remote TFTP Server IP and bootfile name */
        retVal = RPC_UDPSlaveFetchTFTPParams(fileName, sizeof(fileName),
                                             &config.remoteIPAddr,
                                             &strmCfg);
    }

    if ((BCM_ERR_OK == retVal) && (BCM_STATE_SUB_STATE_DONE != slaveClientInfo->state)) {
        do {
            prevState = TFTP_GetState(strmCtxt);
            switch (TFTP_GetState(strmCtxt)) {
                case TFTP_STATE_RESET:
                    /* Setup the TFTP option for 1428 byte blocksize */
                    config.options.count = 1U;
                    config.options.list[0UL].type = TFTP_OPTION_BLKSIZE;
                    config.options.list[0UL].val  = TFTP_MAX_DATA_LEN;
                    config.payloadId = RPC_UDPSlaveContext.connections.streams[index].payloadId;
                    retVal = TFTP_Init(strmCtxt, &config);
                    if ((BCM_ERR_OK == retVal) &&
                        (INET_IPADDRESS_INVALID != config.remoteIPAddr)) {
                        retVal = TFTP_ClientRead(strmCtxt, fileName);
                        if (BCM_ERR_OK != retVal) {
                            retVal = BCM_ERR_UNKNOWN;
                        } else {
                            retVal = BCM_ERR_BUSY;
                        }
                    } else {
                        retVal = BCM_ERR_UNKNOWN;
                    }
                    break;
                case TFTP_STATE_READ:
                    (void)RPC_StrmGetFreeSz(aHdl, &freeSize, &accLen);
                    if (TFTP_MAX_DATA_LEN <= freeSize) {
                        do {
                            filledBufLen = 0UL;
                            uint32_t bufSize = TFTP_GetBlockSize(strmCtxt);
                            strmCtxt->procDataBufSize = 0UL;
                            retVal = TFTP_GetDataHandler(strmCtxt, RPC_UDPSlaveContext.streamBuffer,
                                                         bufSize, &filledBufLen);
                        } while (BCM_ERR_NOMEM == retVal);
                        if (BCM_ERR_OK == retVal) {
                            /* stream processing complete */
                            slaveClientInfo->state = BCM_STATE_SUB_STATE_DONE;
                        } else if (BCM_ERR_BUSY != retVal) {
                            retVal = BCM_ERR_UNKNOWN;
                            slaveClientInfo->state = BCM_STATE_SUB_STATE_DONE;
                        } else {
                            /* Write any stream data received */
                            if (0UL < filledBufLen) {
                                retVal = RPC_StrmWrite(aHdl, RPC_UDPSlaveContext.streamBuffer, filledBufLen);
                                if ((BCM_ERR_OK == retVal) || (BCM_ERR_NOMEM == retVal)) {
                                    retVal = BCM_ERR_BUSY;
                                }
                            }
                            tftpPktState = TFTP_GetPacketProcState(strmCtxt);
                            /* In case the last packet for the stream is got, then set */
                            /* the actual file size that is received                   */
                            if ((TFTP_PACKETSTATE_LAST_PENDING == tftpPktState) ||
                                    (TFTP_PACKETSTATE_LAST_SENT == tftpPktState)) {
                                (void)RPC_StrmGetFreeSz(aHdl, &freeSize, &accLen);
                                (void)RPC_StrmSetXferSize(aHdl, accLen);
                            }
                        }
                    } else {
                        retVal = BCM_ERR_BUSY;
                    }
                    break;
                default:
                    retVal = BCM_ERR_UNKNOWN;
                break;
            }
        } while ((prevState != TFTP_GetState(strmCtxt)) && (BCM_STATE_SUB_STATE_DONE != slaveClientInfo->state));
    }
    if ((BCM_ERR_BUSY != retVal) || (BCM_STATE_SUB_STATE_DONE == aPeerResponse)) {
        if (NULL != slaveClientInfo) {
            slaveClientInfo->state = BCM_STATE_SUB_STATE_DONE;
        }
        (void)TFTP_DeInit(strmCtxt);
    }
    return retVal;
}

/** @brief RPC UDP Slave Interface channel de-initialization

    @trace #BRCM_SWARCH_RPC_UDPSLAVEIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP

    @limitations None

    @code{.unparsed}
    RPC_UDPCommonDeInit(&RPC_UDPSlaveContext.connections)
    @endcode
*/
static void RPC_UDPSlaveDeinitialize(void)
{
    RPC_UDPCommonDeInit(&RPC_UDPSlaveContext.connections);
}

/** @brief UDP Slave interface structure

    @trace #BRCM_SWARCH_RPC_UDPSLAVEIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP
*/
const RPC_InterfaceType RPC_UDPSlaveIfc = {
    .type          = RPC_IFC_CHAN_UDP,
    .mode          = RPC_IFC_CHAN_MODE_SLAVE,
    .assoc         = RPC_ASSOCIATIONINDEX_0,
    .init          = RPC_UDPSlaveInitialize,
    .isConnected   = RPC_UDPSlaveIsConnected,
    .connect       = RPC_UDPSlaveConnect,
    .getMsgSize    = RPC_UDPCommonGetMsgSize,
    .sendMsg       = RPC_UDPSlaveSendMsg,
    .recvMsg       = RPC_UDPSlaveRecvMsg,
    .processMsg    = RPC_UDPSlaveProcessMsg,
    .processStrm   = RPC_UDPSlaveProcessStream,
    .disconnect    = RPC_UDPSlaveDisconnect,
    .getEventMask  = RPC_UDPCommonGetEventMask,
    .deinit        = RPC_UDPSlaveDeinitialize,
};

/** @} */
