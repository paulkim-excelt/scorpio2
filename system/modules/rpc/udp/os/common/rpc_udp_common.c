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
    @defgroup grp_rpc_udp_common_ifc_impl RPC UDP Common Design
    @ingroup grp_rpc_v2_udp

    @addtogroup grp_rpc_udp_common_ifc_impl
    @{

    @file rpc_udp_common.c
    @brief RPC UDP Common Interface Design

    @version 0.1 Initial Version
*/

#include <bcm_err.h>
#include <rpc_udp_common.h>
#include <udp.h>
#include <inet_osil.h>

/**
    @name RPC UDP Common interface Design IDs
    @{
    @brief Design IDs for RPC UDP common interface
*/
#define BRCM_SWDSGN_RPC_UDPCOMMONINIT_PROC         (0xA901U) /**< @brief #RPC_UDPCommonInit   */
#define BRCM_SWDSGN_RPC_UDPCOMMONDEINIT_PROC       (0xA902U) /**< @brief #RPC_UDPCommonDeInit */
#define BRCM_SWDSGN_RPC_UDPCOMMONDISCONNECT_PROC   (0xA903U) /**< @brief #RPC_UDPCommonDisconnect */
#define BRCM_SWDSGN_RPC_UDPCOMMONHANDLETXCONN_PROC (0xA904U) /**< @brief #RPC_UDPCommonHandleTxConn */
#define BRCM_SWDSGN_RPC_UDPCOMMONHANDLERXCONN_PROC (0xA905U) /**< @brief #RPC_UDPCommonHandleRxConn */
#define BRCM_SWDSGN_RPC_UDPCOMMONGETMSGSIZE_PROC   (0xA906U) /**< @brief #RPC_UDPCommonGetMsgSize */
#define BRCM_SWDSGN_RPC_UDPCOMMONGETEVENTMASK_PROC (0xA907U) /**< @brief #RPC_UDPCommonGetEventMask */
#define BRCM_SWDSGN_RPC_UDPCOMMONPROCESSMSG_PROC   (0xA908U) /**< @brief #RPC_UDPCommonProcessMsg */
/** @} */

/**
    @trace #BRCM_SWARCH_RPC_UDPCOMMONINIT_PROC
    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP

    @code{.unparsed}
    Copy serverPayloadId, maxRetryCount, retryIntervalMs, keepAliveIntervalNs, tx and rx payloadIds from config to context
    Store aRemoteIP in context
    For each stream:
        Copy stream payloadIds from config to context
        Set interface id for the stream endpoint
    Set interface id for the server endpoint
    Set interface id for the tx connection endpoint
    Set interface id for the rx connection endpoint
    Bind to TFTP server port
    @endcode
*/
int32_t RPC_UDPCommonInit(const RPC_UDPIntfConfigType *const aConfig,
                          const RPC_InterfaceType *const aIfc,
                          RPC_UDPContextType *const aContext,
                          INET_InterfaceIdType aIntfID,
                          INET_IPAddressType aRemoteIP)
{
    uint32_t idx;
    int32_t  retVal;

    /* Update config from OSIL */
    aContext->connections.serverPayloadId   = aConfig->serverPayloadId;
    aContext->connections.tx.payloadId      = aConfig->txPayloadId;
    aContext->connections.rx.payloadId      = aConfig->rxPayloadId;
    aContext->streamRetryIntervalMs         = aConfig->streamRetryIntervalMs;
    aContext->msgRetryIntervalMs            = aConfig->msgRetryIntervalMs;
    aContext->maxRetryCount                 = aConfig->maxRetryCount;
    aContext->keepAliveIntervalNs           = BCM_MAX(aConfig->maxRetryCount/2UL, 1UL) *aConfig->msgRetryIntervalMs * 1000000ULL;
    aContext->remoteIPAddr                  = aRemoteIP;
    for (idx = 0UL; idx < RPC_MEM_STREAM_COUNT; idx++) {
        aContext->connections.streams[idx].payloadId = aConfig->streamPayloadId[idx];
        /* Update interface for stream end points */
        retVal = INET_SetEndPointInterface(BCM_RPC_ID,
                                           aContext->connections.streams[idx].payloadId,
                                           aIntfID);
        if (BCM_ERR_OK != retVal) {
            break;
        }
    }

    if (BCM_ERR_OK != retVal) {
        goto end;
    }

    /* Update interface for server and tx/rx connection end points */
    retVal = INET_SetEndPointInterface(BCM_RPC_ID,
                                       aContext->connections.serverPayloadId,
                                       aIntfID);
    if (BCM_ERR_OK != retVal) {
        goto end;
    }

    retVal = INET_SetEndPointInterface(BCM_RPC_ID,
                                       aContext->connections.tx.payloadId,
                                       aIntfID);
    if (BCM_ERR_OK != retVal) {
        goto end;
    }

    retVal = INET_SetEndPointInterface(BCM_RPC_ID,
                                       aContext->connections.rx.payloadId,
                                       aIntfID);

    if (BCM_ERR_OK != retVal) {
        goto end;
    }

    /* Bind to TFTP server port */
    retVal = INET_Bind(BCM_RPC_ID, aContext->connections.serverPayloadId, 69U);

end:
    return retVal;
}

/**
    @trace #BRCM_SWARCH_RPC_UDPCOMMONDEINIT_PROC
    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP

    @code{.unparsed}
    Deinit the TFTP server
    Deinit the transmit and receive connections
    Deinit the stream connections
    @endcode
*/
void RPC_UDPCommonDeInit(RPC_UDPConnectionsType *const connections)
{
    uint32_t idx;

    /* Deinit the TFTP server */
    (void)INET_UnBind(BCM_RPC_ID, connections->serverPayloadId);

    /* Deinit the transmit and receive connections */
    (void)INET_UnBind(BCM_RPC_ID, connections->rx.payloadId);
    (void)TFTP_DeInit(&connections->rx.tftpContext);
    (void)INET_UnBind(BCM_RPC_ID, connections->tx.payloadId);
    (void)TFTP_DeInit(&connections->tx.tftpContext);

    /* Deinit the stream connections */
    for (idx = 0UL; idx < RPC_MEM_STREAM_COUNT; idx++) {
        (void)INET_UnBind(BCM_RPC_ID, connections->streams[idx].payloadId);
        (void)TFTP_DeInit(&connections->streams[idx].tftpContext);
    }

    return;
}

/**
    @trace #BRCM_SWARCH_RPC_UDPCOMMONDISCONNECT_PROC
    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP

    @code{.unparsed}
    Increment Rx numDisconnects stats
    Store time in Rx disconnTimeNs
    Deinit Rx TFTP context
    Increment Tx numDisconnects stats
    Store time in Tx disconnTimeNs
    Deinit Tx TFTP context
    @endcode
*/
void RPC_UDPCommonDisconnect(RPC_UDPConnectionsType *const connections)
{
    connections->rx.stats.numDisconnects++;
    connections->rx.stats.disconnTimeNs = BCM_GetTimeNs();
    (void)TFTP_DeInit(&connections->rx.tftpContext);

    connections->tx.stats.numDisconnects++;
    connections->tx.stats.disconnTimeNs = BCM_GetTimeNs();
    (void)TFTP_DeInit(&connections->tx.tftpContext);
}

/**
    @trace #BRCM_SWARCH_RPC_UDPCOMMONHANDLERXCONN_PROC
    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP

    @code{.unparsed}
    int32_t retVal = BCM_ERR_OK
    uint32_t bufLen = 0UL
    RPC_MemMsgType *msg = (RPC_MemMsgType *)aConn->msgBuffer

    Only if there is no pending message from UDP master that
    needs to be processed, then call GetDataHandler
    if (FALSE == aConn->isMsgPending)
        do
            bufLen = 0UL;
            retVal = TFTP_GetDataHandler(&aConn->tftpContext, aConn->msgBuffer, TFTP_DEFAULT_DATA_LEN, &bufLen)
        while (BCM_ERR_NOMEM == retVal)
        if (BCM_ERR_BUSY != retVal)
            aIfc->disconnect()
         else if (aTftpState == TFTP_GetState(&aConn->tftpContext))
            if (TFTP_DEFAULT_DATA_LEN == bufLen)
                if (RPC_UDP_KEEPALIVE_CMD == msg->cmd)
                    Discard keepalive message
                 else
                    This command will be used in recvMsg API
                    aConn->isMsgPending = TRUE

                if (FALSE == TFTP_IsTxPending(&aConn->tftpContext)))
                    aConn->lastTxTime = BCM_GetTimeNs()
         else
             MISRA
    return retVal
    @endcode
*/
int32_t RPC_UDPCommonHandleRxConn(RPC_UDPConnType *aConn,
                               const RPC_InterfaceType *const aIfc,
                               const TFTP_StateType aTftpState)
{
    int32_t retVal = BCM_ERR_OK;
    uint32_t bufLen = 0UL;
    RPC_MemMsgType *msg = (RPC_MemMsgType *)aConn->msgBuffer;

    /* Only if there is no pending message from UDP master that */
    /* needs to be processed, then call GetDataHandler          */
    if (FALSE == aConn->isMsgPending) {
        /* Invoke TFTP_GetDataHandler to send ACK to UDP master */
        do {
            bufLen = 0UL;
            retVal = TFTP_GetDataHandler(&aConn->tftpContext, aConn->msgBuffer,
                                         TFTP_DEFAULT_DATA_LEN, &bufLen);
        } while (BCM_ERR_NOMEM == retVal);

        if (BCM_ERR_BUSY != retVal) {
            aIfc->disconnect();
        } else if (aTftpState == TFTP_GetState(&aConn->tftpContext)) {
            if (TFTP_DEFAULT_DATA_LEN == bufLen) {
                if (RPC_UDP_KEEPALIVE_CMD == msg->cmd) {
                    /* Discard keepalive message */
                } else {
                    /* This command will be used in recvMsg API */
                    aConn->isMsgPending = TRUE;
                }
                if (FALSE == TFTP_IsTxPending(&aConn->tftpContext)) {
                    aConn->lastTxTime = BCM_GetTimeNs();
                }
            }
        } else {
            /* MISRA */
        }
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_RPC_UDPCOMMONHANDLETXCONN_PROC
    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP

    @code{.unparsed}
    int32_t retVal = BCM_ERR_OK
    uint32_t bufLen = 0UL
    RPC_MemMsgType *msg = (RPC_MemMsgType *)aConn->msgBuffer
    msg->magic = RPC_MEMMSG_MAGIC
    msg->cmd = RPC_UDP_KEEPALIVE_CMD
    msg->len = 0UL
    if ((TRUE == TFTP_IsTxPending(&aConn->tftpContext)) ||
        (aKeepAliveIntervalNs < (BCM_GetTimeNs() - aConn->lastTxTime)))
        Invoke TFTP_PutDataHandler to send PING to UDP slave or
        to send pending packet
        retVal = TFTP_PutDataHandler(&aConn->tftpContext,
                                     aConn->msgBuffer,
                                     TFTP_DEFAULT_DATA_LEN,
                                     &bufLen, FALSE)
        if (BCM_ERR_BUSY != retVal)
            Connection lost
            aIfc->disconnect()
        else if (aTftpState == TFTP_GetState(&aConn->tftpContext))
            if (TFTP_DEFAULT_DATA_LEN == bufLen)
                 Packet transmitted successfully, update timestamp
                aConn->lastTxTime = BCM_GetTimeNs()
        else
             MISRA
    return retVal
    @endcode
*/
int32_t RPC_UDPCommonHandleTxConn(RPC_UDPConnType *aConn,
                                  uint64_t aKeepAliveIntervalNs,
                                  const RPC_InterfaceType *const aIfc,
                                  const TFTP_StateType aTftpState)
{
    int32_t retVal = BCM_ERR_OK;
    uint32_t bufLen = 0UL;
    RPC_MemMsgType *msg = (RPC_MemMsgType *)aConn->msgBuffer;
    msg->magic = RPC_MEMMSG_MAGIC;
    msg->cmd = RPC_UDP_KEEPALIVE_CMD;
    msg->len = 0UL;

    if ((TRUE == TFTP_IsTxPending(&aConn->tftpContext)) ||
        (aKeepAliveIntervalNs <
                    (BCM_GetTimeNs() - aConn->lastTxTime))) {
        /* Invoke TFTP_PutDataHandler to send PING to UDP slave or */
        /* to send pending packet                                  */
        retVal = TFTP_PutDataHandler(&aConn->tftpContext,
                                     aConn->msgBuffer,
                                     TFTP_DEFAULT_DATA_LEN,
                                     &bufLen, FALSE);
        if (BCM_ERR_BUSY != retVal) {
            /* Connection lost */
            aIfc->disconnect();
        } else if (aTftpState == TFTP_GetState(&aConn->tftpContext)) {
            if (TFTP_DEFAULT_DATA_LEN == bufLen) {
                /* Packet transmitted successfully, update timestamp */
                aConn->lastTxTime = BCM_GetTimeNs();
            }
        } else {
            /* MISRA */
        }
    }
    return retVal;
}

/**
    @trace #BRCM_SWARCH_RPC_UDPCOMMONGETMSGSIZE_PROC
    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP

    @code{.unparsed}
    return RPC_MEM_MSG_PAYLOAD_SZ
    @endcode
*/
uint32_t RPC_UDPCommonGetMsgSize(void)
{
    return RPC_MEM_MSG_PAYLOAD_SZ;
}

/**
    @trace #BRCM_SWARCH_RPC_UDPCOMMONGETEVENTMASK_PROC
    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP

    @code{.unparsed}
    return RPC_UDPIntfDataEvent
    @endcode
*/
uint32_t RPC_UDPCommonGetEventMask(void)
{
    return RPC_UDPIntfDataEvent;
}

/** @brief RPC UDP Master Interface Process message

    @trace #BRCM_SWARCH_RPC_UDPMASTERIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP

    @limitations None

    @code{.unparsed}
    RPC_UDPConnType *conn = NULL
    Handle receive Connection
    conn = &aConnections->rx
    if (TFTP_STATE_RESET == TFTP_GetState(&conn->tftpContext))
        (void)aIfc->connect()
    else
        (void)RPC_UDPCommonHandleRxConn(conn, aIfc, aTftpRxState)
    Handle transmit Connection
    conn = &aConnections->tx
    if (TFTP_STATE_RESET == TFTP_GetState(&conn->tftpContext))
        (void)aIfc->connect()
     else
        (void)RPC_UDPCommonHandleTxConn(conn, aKeepAliveIntervalNs, aIfc, aTftpTxState)
    return BCM_ERR_OK
    @endcode
*/
int32_t RPC_UDPCommonProcessMsg(RPC_UDPConnectionsType *aConnections,
                                uint64_t aKeepAliveIntervalNs,
                                const RPC_InterfaceType *const aIfc,
                                const TFTP_StateType aTftpRxState,
                                const TFTP_StateType aTftpTxState)
{

    RPC_UDPConnType *conn = NULL;

    /* Handle receive Connection */
    conn = &aConnections->rx;
    if (TFTP_STATE_RESET == TFTP_GetState(&conn->tftpContext)) {
        (void)aIfc->connect();
    } else {
        (void)RPC_UDPCommonHandleRxConn(conn, aIfc, aTftpRxState);
    }

    /* Handle transmit Connection */
    conn = &aConnections->tx;
    if (TFTP_STATE_RESET == TFTP_GetState(&conn->tftpContext)) {
        (void)aIfc->connect();
    } else {
        (void)RPC_UDPCommonHandleTxConn(conn, aKeepAliveIntervalNs, aIfc, aTftpTxState);
    }
    return BCM_ERR_OK;
}

/** @} */
