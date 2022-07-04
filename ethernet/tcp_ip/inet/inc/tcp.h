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
  @addtogroup grp_inet_ifc
  @{
  @section sec_comp_seq Sequence Diagrams
  @tagseq tcp_seq_diagram.svg "TCP connection establishment Sequence diagram"
  @startseq
  group {label = "client"; color = "#EFFFFF";  Client;};
  group {label = "server"; color = "#EFFFFF";  Server;};
  Server => Server [label = "INET_Bind"];
  Server => Server [label = "TCP_Listen"];
  Client => Client [label = "INET_Bind"];
  Client => Server [label = "TCP_Connect"];
  Server => Server [label = "TCP_GetConnReq"];
  Server => Server [label = "TCP_GetFreeEndPt"];
  Server => Client [label = "TCP_Accept"];
  Client => Server [label = "TCP_Send"];
  Server => Server [label = "TCP_Recv"];
  Server => Client [label = "TCP_Send"];
  Client => Client [label = "TCP_Recv"];
  Client => Server [label = "TCP_Close"];
  Server => Client [label = "TCP_Close"];
  Server => Server [label = "INET_UnBind"];
  Client => Client [label = "INET_UnBind"];
  @endseq

  @file tcp.h
  @brief TCP API of Internet Stack

  This file provides the interface/APIs which can be used to communicate
  with a remote peer using the TCP protocol
  @version 0.1 Initial version
*/

#ifndef TCP_H
#define TCP_H

#include <inet.h>

/**
    @name INET Library Architecture IDs
    @{
    @brief Architecture IDs for INET Library
 */
#define BRCM_SWARCH_INET_TCPSTATE_TYPE     (0x8400U)    /**< @brief #INET_TCPStateType */
#define BRCM_SWARCH_TCP_CONNECT_PROC       (0x8401U)    /**< @brief #TCP_Connect       */
#define BRCM_SWARCH_TCP_LISTEN_PROC        (0x8402U)    /**< @brief #TCP_Listen        */
#define BRCM_SWARCH_TCP_GETCONNREQ_PROC    (0x8403U)    /**< @brief #TCP_GetConnReq    */
#define BRCM_SWARCH_TCP_GETFREEENDPT_PROC  (0x8404U)    /**< @brief #TCP_GetFreeEndPt  */
#define BRCM_SWARCH_TCP_ACCEPT_PROC        (0x8405U)    /**< @brief #TCP_Accept        */
#define BRCM_SWARCH_TCP_SEND_PROC          (0x8406U)    /**< @brief #TCP_Send          */
#define BRCM_SWARCH_TCP_RECV_PROC          (0x8407U)    /**< @brief #TCP_Recv          */
#define BRCM_SWARCH_INET_TCPGETSTATE_PROC  (0x8408U)    /**< @brief #INET_TCPGetState  */
#define BRCM_SWARCH_TCP_CLOSE_PROC         (0x8409U)    /**< @brief #TCP_Close         */
#define BRCM_SWARCH_TCP_REJECT_PROC        (0x840AU)    /**< @brief #TCP_Reject        */
/** @} */

/**
    @name INET_TCPStateType
    @{
    @brief TCP endpoint state

    @trace #BRCM_SWREQ_INET
*/
typedef uint32_t INET_TCPStateType;        /**< @brief typedef for TCP endpoint
                                            state */
#define INET_TCPSTATE_CLOSED         (0UL) /**< @brief Closed/Free */
#define INET_TCPSTATE_LISTEN         (1UL) /**< @brief Waiting for a connection
                                            request from remote end (passive
                                            open) */
#define INET_TCPSTATE_SYN_SENT       (2UL) /**< @brief Waiting for a matching
                                            connection request after having
                                            sent a connection request */
#define INET_TCPSTATE_SYN_RCVD       (3UL) /**< @brief Waiting for a confirming
                                            connection request acknowledgment
                                            after having both received and sent
                                            a connection request */
#define INET_TCPSTATE_ESTABLISHED    (4UL) /**< @brief Open connection, data
                                            received can be delivered to the
                                            user. The normal state for the data
                                            transfer phase of the connection */
#define INET_TCPSTATE_CLOSE_WAIT     (5UL) /**< @brief Waiting for a connection
                                            termination request from the local
                                            user */
#define INET_TCPSTATE_LAST_ACK       (6UL) /**< @brief Waiting for an acknowledgment
                                            of the connection termination
                                            request previously sent to the
                                            remote TCP {which includes an
                                            acknowledgment of its connection
                                            termination request} */
#define INET_TCPSTATE_FIN_WAIT_1     (7UL) /**< @brief Waiting for a connection
                                            termination request from the remote
                                            TCP, or an acknowledgment of the
                                            connection termination request
                                            previously sent */
#define INET_TCPSTATE_FIN_WAIT_2     (8UL) /**< @brief Waiting for a connection
                                            termination request from the remote
                                            TCP */
#define INET_TCPSTATE_CLOSING        (9UL) /**< @brief Waiting for a connection
                                            termination request acknowledgment
                                            from the remote TCP */
#define INET_TCPSTATE_TIME_WAIT      (10UL)/**< @brief Waiting for enough time to
                                            pass to be sure the remote TCP
                                            received the acknowledgment of its
                                            connection termination request */
/** @} */

/** @brief Establish TCP connection to remote peer

    @pre None

    This API is used to try and establish a connection request to the remote
    end. A 3-way TCP handshake is initiated at this point. This is also known
    as an active-open, typically performed by a client

    @behavior Async, Non re-entrant for same end point (identified by aCompId,
            aPayloadId)

    @param[in]   aCompId               Component identifier used to identify the
                                       end point
    @param[in]   aPayloadId            Payload identifier used to identify the
                                       end point
    @param[in]   aRemoteIPAddr         IP address of remote peer
    @param[in]   aRemotePort           Port number of remote peer

    Return values are documented in reverse-chronological order
    @retval  #BCM_ERR_OK               Connection request has been accepted
    @retval  #BCM_ERR_EAGAIN           The connection request could not be sent
                                       out. This API should be invoked again
                                       when the transmit event registered with
                                       this endpoint is triggered
    @retval  #BCM_ERR_INVAL_STATE      A connection has already been
                                       initiated/established on this endpoint
                                       or it is already listening for incoming
                                       requests
    @retval  #BCM_ERR_INVAL_PARAMS     Returned in the following cases:
                                        1. no valid TCP end point allocated
                                        2. end point does not map to a valid
                                        interface
                                        3. aRemoteIPAddr is not unicast
                                        4. aRemotePort is invalid
    @retval  #BCM_ERR_NOPERM           End point is not bound to any local port

    @post The invoking task would be triggered with the receive event registered
    with the endpoint when the connection goes through or times out

    @trace #BRCM_SWREQ_TCP

    @limitations None
*/
int32_t TCP_Connect(const BCM_CompIDType aCompId,
                    const INET_PayloadType aPayloadId,
                    INET_IPAddressType aRemoteIPAddr,
                    INET_PortType aRemotePort);

/** @brief Listen for incoming connection requests

    @pre None

    This API is used to listen to incoming TCP connection requests from remote
    hosts. This is also known as a passive-open, typically performed by a server

    @behavior Async, Non re-entrant for same end point (identified by aCompId,
            aPayloadId)

    @param[in]   aCompId               Component identifier used to identify the
                                       end point
    @param[in]   aPayloadId            Payload identifier used to identify the
                                       end point
    @param[in]   aMaxConns             The number of connection requests to be
                                       enqueued at a time. This argument is
                                       added for future scalability and is
                                       expected to be set to 1

    Return values are documented in reverse-chronological order
    @retval  #BCM_ERR_OK               Endpoint has started listening for
                                       incoming connection requests
    @retval  #BCM_ERR_INVAL_STATE      This endpoint is already listening for
                                       incoming requests or a connection has
                                       already been initiated/established
    @retval  #BCM_ERR_INVAL_PARAMS     Returned in the following cases:
                                        1. no valid TCP end point allocated for
                                           the client
                                        2. end point does not map to a valid
                                           interface
                                        3. aMaxConns is more than allowed limit
    @retval  #BCM_ERR_NOPERM           End point is not bound to any local port

    @post None

    @trace #BRCM_SWREQ_TCP

    @limitations Only single connection allowed at a time
*/
int32_t TCP_Listen(const BCM_CompIDType aCompId,
                   const INET_PayloadType aPayloadId,
                   const uint32_t aMaxConns);

/** @brief Fetch details of incoming connection request

    @pre Endpoint should be in listening state

    This API is used to fetch details (IP address, port number of remote host)
    of an incoming connection request. This is expected to be invoked when the
    task owning the endpoint is triggered with the receive event (registered
    with the endpoint) when it is in the listening state. This API is used
    for server use case

    @behavior Sync, Non re-entrant for same end point (identified by aCompId,
            aPayloadId)

    @param[in]   aCompId               Component identifier used to identify the
                                       end point
    @param[in]   aPayloadId            Payload identifier used to identify the
                                       end point
    @param[out]  aRemoteIPAddr         IP address of the host from which the
                                       connection request has been received
    @param[out]  aRemotePort           Port number of the host from which the
                                       connection request has been received

    Return values are documented in reverse-chronological order
    @retval  #BCM_ERR_OK               Incoming request received
    @retval  #BCM_ERR_BUSY             No incoming request
    @retval  #BCM_ERR_INVAL_STATE      Endpoint is not in listening state
    @retval  #BCM_ERR_INVAL_PARAMS     Returned in the following cases:
                                       - No valid TCP end point
                                       - aRemoteIPAddr or aRemotePort is NULL

    @post None

    @trace #BRCM_SWREQ_TCP

    @limitations None
*/
int32_t TCP_GetConnReq(const BCM_CompIDType aCompId,
                       const INET_PayloadType aPayloadId,
                       INET_IPAddressType *const aRemoteIPAddr,
                       INET_PortType *const aRemotePort);


/** @brief Get a free endpoint from the input list

    @pre None

    This is a helper API used to fetch a free endpoint from the input list of
    endpoints. The list is typically the set of "connection" endpoints
    associated with a "listening" endpoint on a server to handle the connections
    to individual remote clients. The assumption is that all the endpoints are
    managed by a single component and share its identifier

    @behavior Sync, Re-Entrant

    @param[in]   aCompId               Component identifier used to identify the
                                       end points
    @param[in]   aEndPtPayloadList     Pointer to an array of payload identifiers
                                       corresponding to the endpoints
    @param[in]   aListSz               Number of valid endpoints in the list
    @param[out]  aPayloadId            Payload identifier used to identify the
                                       free end point

    Return values are documented in reverse-chronological order
    @retval  #BCM_ERR_OK               Free endpoint found
    @retval  #BCM_ERR_NOT_FOUND        No free endpoints found
    @retval  #BCM_ERR_INVAL_PARAMS     aEndPtPayloadList is NULL or
                                       *aEndPtPayloadList is NULL or
                                       aListSz is 0 or
                                       aPayloadId is NULL

    @post None

    @trace #BRCM_SWREQ_TCP

    @limitations None
*/
int32_t TCP_GetFreeEndPt(const BCM_CompIDType aCompId,
                         uint32_t **aEndPtPayloadList,
                         const uint32_t aListSz,
                         uint32_t *const aPayloadId);

/** @brief Accept incoming connection request on a server

    @pre Server endpoint should be in listening state

    This API is used to accept an incoming connection (retrieved via
    invocation of #TCP_GetConnReq API). To handle the use case of a server
    which needs to cater to multiple clients, the connection is handed over
    to another end point dedicated for that particular connection. It will
    reside on the same interface and have the same port number as the original
    endpoint listening for connections (the following 4 tuple will uniquely
    identify the connection and be used to route packets to this endpoint:
    <source IP, source Port, destination IP, destination Port>
    The source IP and port correspond to the aRemoteIPAddr and aRemotePort
    arguments which get cached in the end point

    @behavior Sync, Non re-entrant for same end point (identified by aCompId,
            aListenPayloadId)

    @param[in]   aCompId               Component identifier used to identify the
                                       end point
    @param[in]   aListenPayloadId      Payload identifier used to identify the
                                       server's listening end point. This where
                                       the incoming request was received
    @param[in]   aConnPayloadId        Payload identifier used to identify the
                                       server's connection end point. This is what
                                       is going to be used for subsequent communication
                                       with the remote party
    @param[in]   aRemoteIPAddr         IP address of the host from which the
                                       connection request has been received
    @param[in]   aRemotePort           Port number of the host from which the
                                       connection request has been received

    Return values are documented in reverse-chronological order
    @retval  #BCM_ERR_OK               Connection accepted
    @retval  #BCM_ERR_NOT_FOUND        No incoming request corresponding to remote
                                       IP address and port found on the listening
                                       endpoint
    @retval  #BCM_ERR_INVAL_STATE      Either of the following:
                                       1. Endpoint corresponding to aListenPayloadId is not
                                       in listening state
                                       2. Endpoint correspond to aConnectionPayloadId is not
                                       in free/unconnected state
    @retval  #BCM_ERR_INVAL_PARAMS     Returned in the following cases:
                                       - aRemoteIPAddr or aRemotePort is invalid
                                       - No valid TCP end point for aListenPayloadId
                                       or aConnectionPayloadId for the given aCompId

    @post None

    @trace #BRCM_SWREQ_TCP

    @limitations None
*/
int32_t TCP_Accept(const BCM_CompIDType aCompId,
                   const INET_PayloadType aListenPayloadId,
                   const INET_PayloadType aConnPayloadId,
                   const INET_IPAddressType aRemoteIPAddr,
                   const INET_PortType aRemotePort);

/** @brief Reject incoming connection request on a server

    @pre Server endpoint should be in listening state

    This API is used to reject an incoming connection (retrieved via
    invocation of #TCP_GetConnReq API).

    @behavior Sync, Non re-entrant for same end point (identified by aCompId,
            aListenPayloadId)

    @param[in]   aCompId               Component identifier used to identify the
                                       end point
    @param[in]   aListenPayloadId      Payload identifier used to identify the
                                       server's listening end point. This where
                                       the incoming request was received
    @param[in]   aRemoteIPAddr         IP address of the host from which the
                                       connection request has been received
    @param[in]   aRemotePort           Port number of the host from which the
                                       connection request has been received

    Return values are documented in reverse-chronological order
    @retval  #BCM_ERR_OK               Connection rejected
    @retval  #BCM_ERR_NOT_FOUND        No incoming request corresponding to remote
                                       IP address and port found on the listening
                                       endpoint
    @retval  #BCM_ERR_INVAL_STATE      Endpoint corresponding to aListenPayloadId is not
                                       in listening state
    @retval  #BCM_ERR_INVAL_PARAMS     Returned in the following cases:
                                       - aRemoteIPAddr or aRemotePort is invalid
                                       - No valid TCP end point for aListenPayloadId
                                       for the given aCompId

    @post None

    @trace #BRCM_SWREQ_TCP

    @limitations None
*/
int32_t TCP_Reject(const BCM_CompIDType aCompId,
                   const INET_PayloadType aListenPayloadId,
                   const INET_IPAddressType aRemoteIPAddr,
                   const INET_PortType aRemotePort);

/** @brief Send data using TCP

    @pre Endpoint needs to be in connected state

    This API is used to transmit data over a TCP endpoint to a connected
    remote host. This API can be used at either server or client end

    @behavior Async, Non re-entrant for same end point (identified by aCompId,
            aPayloadId)

    @param[in]    aCompId              Component identifier used to identify the
                                       end point
    @param[in]    aPayloadId           Payload identifier used to identify the
                                       end point
    @param[in]    aBuf                 Buffer containing the TCP payload
    @param[inout] aLen                 Length of the TCP payload in the input
                                       buffer in bytes. When the call returns
                                       this contains the number of bytes
                                       consumed from the input data

    Return values are documented in reverse-chronological order
    @retval  #BCM_ERR_OK               The data has been accepted for
                                       transmission. The client is free to reuse
                                       the buffer
    @retval  #BCM_ERR_NOMEM            Input buffer too big to fit
    @retval  #BCM_ERR_EAGAIN           Endpoint is unable to accept the full
                                       data for transmission at this point.
                                       Possible reasons could include closing of
                                       the sliding window etc. The client should
                                       retry later when it is notified with the
                                       transmit event registered with the
                                       endpoint. When retrying, the client
                                       should ensure that the input buffer does
                                       not include the already consumed bytes
    @retval  #BCM_ERR_INVAL_STATE      Endpoint is not in connected state
    @retval  #BCM_ERR_INVAL_PARAMS     Returned in the following cases:
                                        1. aBuf is NULL or aLen is NULL or
                                           *aLen is 0
                                        2. no valid TCP end point
                                        3. end point does not map to a valid
                                           interface
    @post None

    @trace #BRCM_SWREQ_TCP

    @limitations None
*/
int32_t TCP_Send(const BCM_CompIDType aCompId,
                 const INET_PayloadType aPayloadId,
                 const uint8_t* const aBuf,
                 uint32_t *const aLen);

/** @brief  Receive data from TCP end point

    @pre The receive event registered with the end point gets invoked

    This API is used to read data received from a remote host from a
    TCP endpoint. This API can be used at either server or client end.
    This API is expected to be invoked by the user on getting triggered
    with the receive event registered with the endpoint. If the API
    returns indicating that no data was received, it typically points to
    the remote end having closed the connection.

    @behavior Sync, Non-Reentrant for same end point (identified by aCompId,
              aPayloadId)

    @param[in]    aCompId              Component identifier used to identify the
                                       end point
    @param[in]    aPayloadId           Payload identifier used to identify the
                                       end point
    @param[in]    aBuf                 Pointer to client buffer to copy the
                                       received data to
    @param[inout] aLen                 Length of the client buffer. When the call
                                       returns this contains the number of bytes
                                       of received data copied to the client
                                       buffer
    @param[out]   aMoreData            Boolean flag which shall be set to 1 in
                                       case there is more data that is to be read
                                       by the caller

    Return values are documented in reverse-chronological order
    @retval  #BCM_ERR_OK               Received data has been copied to the input
                                       buffer. The aLen field is updated with the
                                       number of bytes of data copied. The
                                       aMoreData field is set to 1 in case there
                                       is more data that can be read by the
                                       client
    @retval  #BCM_ERR_INVAL_STATE      Endpoint is not in connected state
    @retval  #BCM_ERR_INVAL_PARAMS     Returned in the following cases:
                                         1. aBuf is NULL or aLen is NULL or
                                           *aLen is 0 or aMoreData is NULL
                                         2. no valid TCP end point allocated for this
                                            client
    @retval  #BCM_ERR_NOPERM           Local port of end point is invalid

    @post None

    @trace #BRCM_SWREQ_TCP

    @limitations None
*/
int32_t TCP_Recv(const BCM_CompIDType aCompId,
                 const INET_PayloadType aPayloadId,
                 uint8_t* const aBuf,
                 uint32_t* const aLen,
                 uint32_t* const aMoreData);

/** @brief  Retrieve TCP endpoint state

    @pre None

    This API is used to retrieve the TCP endpoint state

    @behavior Sync, Reentrant

    @param[in]    aCompId              Component identifier used to identify the
                                       end point
    @param[in]    aPayloadId           Payload identifier used to identify the
                                       end point

    Return values are documented in reverse-chronological order
    @retval       #INET_TCPStateType       TCP endpoint/connection state

    @post None

    @trace #BRCM_SWREQ_INET

    @limitations None
*/
INET_TCPStateType INET_TCPGetState(const BCM_CompIDType aCompId,
                                   const INET_PayloadType aPayloadId);

/** @brief  Close the TCP connection

    @pre None

    This API is used to close a TCP connection. This can be invoked from either
    server or client end. If there is any pending data to be transmitted in the
    sliding window, it is first sent to the remote end. Later the stack starts
    the 4-way handshake to terminate the connection. The user shall not be
    permitted to transmit anymore data after this API is invoked. Any data
    received on the endpoint from the remote end is going to be dropped.
    When the connection termination is completed, the user's task is going to be
    triggered with the receive event registered with the endpoint.

    @behavior ASync, Non-Reentrant for same end point (identified by aCompId,
              aPayloadId)

    @param[in]    aCompId              Component identifier used to identify the
                                       end point
    @param[in]    aPayloadId           Payload identifier used to identify the
                                       end point

    Return values are documented in reverse-chronological order
    @retval  #BCM_ERR_OK               Request to close the connection has been
                                       accepted
    @retval  #BCM_ERR_INVAL_STATE      Endpoint is not in connected state
    @retval  #BCM_ERR_INVAL_PARAMS     No valid TCP end point allocated for this
                                       client
    @retval  #BCM_ERR_NOPERM           Local port of end point is invalid

    @post None

    @trace #BRCM_SWREQ_TCP

    @limitations None
*/
int32_t TCP_Close(const BCM_CompIDType aCompId,
                  const INET_PayloadType aPayloadId);

#endif /* TCP_H */
/** @} */
