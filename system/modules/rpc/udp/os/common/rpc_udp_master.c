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
    @defgroup grp_rpc_udp_master_ifc_impl UDP Master Design
    @ingroup grp_rpc_v2_udp

    @addtogroup grp_rpc_udp_master_ifc_impl
    @{

    @file rpc_udp_master.c
    @brief UDP Master Interface Design

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
#include <rpc_udp_common.h>
#include <rpc_udp_platform.h>
#include <rpc_udp_osil.h>
#include <rpc_local_osil.h>
#include <inet.h>
#include <inet_osil.h>
#include <udp.h>
#include <tftp.h>
#include <imgl.h>
#include <ethutils.h>

/**
    @name RPC UDP Master interface Design IDs
    @{
    @brief Design IDs for RPC UDP master interface
*/
#define BRCM_SWDSGN_RPC_UDPMASTERCONTEXT_GLOBAL                 (0xA601U) /**< @brief #RPC_UDPMasterContext */
#define BRCM_SWDSGN_RPC_UDPMASTERINITIALIZE_PROC                (0xA602U) /**< @brief #RPC_UDPMasterInitialize */
#define BRCM_SWDSGN_RPC_UDPMASTERISCONNECTED_PROC               (0xA603U) /**< @brief #RPC_UDPMasterIsConnected */
#define BRCM_SWDSGN_RPC_UDPMASTERCONNECT_PROC                   (0xA604U) /**< @brief #RPC_UDPMasterConnect */
#define BRCM_SWDSGN_RPC_UDPMASTERPROCESSMSG_PROC                (0xA605U) /**< @brief #RPC_UDPMasterProcessMsg */
#define BRCM_SWDSGN_RPC_UDPMASTERGETEVENTMASK_PROC              (0xA606U) /**< @brief #RPC_UDPMasterGetEventMask */
#define BRCM_SWDSGN_RPC_UDPMASTERSENDMSG_PROC                   (0xA607U) /**< @brief #RPC_UDPMasterSendMsg */
#define BRCM_SWDSGN_RPC_UDPMASTERHANDLEASYNC_PROC               (0xA608U) /**< @brief #RPC_UDPMasterHandleAsync */
#define BRCM_SWDSGN_RPC_UDPMASTERHANDLERESPONSE_PROC            (0xA609U) /**< @brief #RPC_UDPMasterHandleResponse */
#define BRCM_SWDSGN_RPC_UDPMASTERRECVMSG_PROC                   (0xA60AU) /**< @brief #RPC_UDPMasterRecvMsg */
#define BRCM_SWDSGN_RPC_UDPMASTERPROCESSSTREAM_PROC             (0xA60BU) /**< @brief #RPC_UDPMasterProcessStream */
#define BRCM_SWDSGN_RPC_UDPMASTERDISCONNECT_PROC                (0xA60CU) /**< @brief #RPC_UDPMasterDisconnect */
#define BRCM_SWDSGN_RPC_UDPMASTERDEINITIALIZE_PROC              (0xA60DU) /**< @brief #RPC_UDPMasterDeinitialize */
#define BRCM_SWDSGN_RPC_UDPMASTERDETECTSTREAM_PROC              (0xA60EU) /**< @brief #RPC_UDPMasterDetectStream */
#define BRCM_SWDSGN_RPC_UDPMASTERIFC_GLOBAL                     (0xA60FU) /**< @brief #RPC_UDPMasterIfc */
#define BRCM_SWDSGN_RPC_UDPMASTERCONVHEX2INT_PROC               (0xA610U) /**< @brief #RPC_UDPMasterConvHex2Int */
#define BRCM_SWDSGN_RPC_UDPMASTERIFCPARSEFILENAME_PROC          (0xA611U) /**< @brief #RPC_UDPMasterIfcParseFileName */
#define BRCM_SWDSGN_RPC_UDP_MASTER_LEGACY_FILENAME_SIZE_MACRO   (0xA612U) /**< @brief #RPC_UDP_MASTER_LEGACY_FILENAME_SIZE */
#define BRCM_SWDSGN_RPC_UDP_MASTER_FILENAME_SIZE_MACRO          (0xA613U) /**< @brief #RPC_UDP_MASTER_FILENAME_SIZE    */
/** @} */


/**
    @brief Filename size expected in a TFTP request packet
    from legacy ROM
    bcm-yyyyyyyy-zzzzzzzz-aaaaaaaa.bin (length 43) -> ROM on Scorpio B0

    @trace #BRCM_SWARCH_RPC_UDPMASTERIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP
*/
#define RPC_UDP_MASTER_LEGACY_FILENAME_SIZE (43U)

/**
    @brief Filename size expected in a TFTP request packet
    from RPC V2 modules
    bcm-manuf(8)-model(8)-rev(8)-istbl(2) pid(2) imgID(4)-offset(8)-size(8).bin (length 61)

    @trace #BRCM_SWARCH_RPC_UDPMASTERIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP
*/
#define RPC_UDP_MASTER_FILENAME_SIZE (61U)

/**
    @brief RPC UDP master Context

    @trace #BRCM_SWARCH_RPC_UDPMASTERIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP
*/

static RPC_UDPContextType RPC_UDPMasterContext COMP_SECTION(".bss.rpc");

/** @brief RPC UDP Master Interface Initialization

    Function to initialize the UDP Master Interface

    @trace #BRCM_SWARCH_RPC_UDPMASTERIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP

    @limitations None

    @code{.unparsed}
    Clear context
    Retrieve peerId, selfId and assocId using RPC_GetModIfcAndAssoc() and store in context
    return RPC_UDPCommonInit(&RPC_UDPMasterIntfConfig,
                             &RPC_UDPMasterIfc,
                             &RPC_UDPMasterContext.connections,
                             INET_INTERFACEID_1,
                             INET_MASTER_DEFAULT_IP_ADDR + 1UL)
    @endcode
*/
static int32_t RPC_UDPMasterInitialize(void)
{
    int32_t retVal;

    BCM_MemSet(&RPC_UDPMasterContext, 0U, sizeof(RPC_UDPMasterContext));
    retVal = RPC_GetModIfcAndAssoc(&RPC_UDPMasterIfc, &RPC_UDPMasterContext.peerId,
                                   &RPC_UDPMasterContext.selfId,
                                   &RPC_UDPMasterContext.assocId);

    if (BCM_ERR_OK == retVal) {
        retVal = RPC_UDPCommonInit(&RPC_UDPMasterIntfConfig,
                                   &RPC_UDPMasterIfc,
                                   &RPC_UDPMasterContext,
                                   INET_INTERFACEID_1,
                                   INET_MASTER_DEFAULT_IP_ADDR + 1UL);
    }
    return retVal;
}

/** @brief RPC UDP Master Interface connection status

    @trace #BRCM_SWARCH_RPC_UDPMASTERIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP

    @limitations None

    @code{.unparsed}
    uint32_t isConnected = 0UL
    if ((TFTP_STATE_WRITE ==
                    TFTP_GetState(&RPC_UDPMasterContext.txConn.tftpContext)) &&
        (TFTP_STATE_READ ==
                    TFTP_GetState(&RPC_UDPMasterContext.rxConn.tftpContext)))
        isConnected = 1UL
    return isConnected
    @endcode
*/
static uint32_t RPC_UDPMasterIsConnected(void)
{
    uint32_t isConnected = 0UL;
    if ((TFTP_STATE_WRITE ==
                    TFTP_GetState(&RPC_UDPMasterContext.connections.tx.tftpContext)) &&
        (TFTP_STATE_READ ==
                    TFTP_GetState(&RPC_UDPMasterContext.connections.rx.tftpContext))) {
        isConnected = 1UL;
    }
    return isConnected;
}

/** @brief RPC UDP Master Interface Disconnect

    @trace #BRCM_SWARCH_RPC_UDPMASTERIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP

    @limitations None

    @code{.unparsed}
    RPC_UDPCommonDisconnect(&RPC_UDPMasterContext.connections)
    return BCM_ERR_OK
    @endcode
*/
static int32_t RPC_UDPMasterDisconnect(void)
{
    RPC_UDPCommonDisconnect(&RPC_UDPMasterContext.connections);

    return BCM_ERR_OK;
}

/** @brief RPC UDP Master Interface Connect

    This API will initiate connection to remote slave

    @trace #BRCM_SWARCH_RPC_UDPMASTERIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP

    @limitations None

    @code{.unparsed}
    int32_t retVal = BCM_ERR_OK
    uint8_t fName[] = "bcm_rpc_message"
    TFTP_ConfigType config =
        .compId        = BCM_RPC_ID,
        .payloadId     = 0U,
        .remoteIPAddr  = RPC_UDPMasterContext.remoteIPAddr,
        .maxRetryCount = RPC_UDPMasterContext.maxRetryCount,
        .timeoutInms   = RPC_UDPMasterContext.retryIntervalMs,
    if (TFTP_STATE_RESET == TFTP_GetState(&RPC_UDPMasterContext.txConn.tftpContext))
        config.payloadId = RPC_UDPMasterContext.txConn.payloadId
        retVal = TFTP_Init(&RPC_UDPMasterContext.txConn.tftpContext, &config)
        if (BCM_ERR_OK == retVal)
            retVal = TFTP_ClientWrite(&RPC_UDPMasterContext.txConn.tftpContext, fName)
    if ((BCM_ERR_OK == retVal) &&
        (TFTP_STATE_RESET == TFTP_GetState(&RPC_UDPMasterContext.rxConn.tftpContext)))
        config.payloadId = RPC_UDPMasterContext.rxConn.payloadId
        retVal = TFTP_Init(&RPC_UDPMasterContext.rxConn.tftpContext, &config)
        if (BCM_ERR_OK == retVal)
            retVal = TFTP_ClientRead(&RPC_UDPMasterContext.rxConn.tftpContext, fName)
    return retVal
    @endcode
*/
static int32_t RPC_UDPMasterConnect(void)
{
    int32_t retVal = BCM_ERR_OK;

    uint8_t fName[] = "bcm_rpc_message";
    TFTP_ConfigType config = {
        .compId        = BCM_RPC_ID,
        .payloadId     = 0U,
        .remoteIPAddr  = RPC_UDPMasterContext.remoteIPAddr,
        .maxRetryCount = RPC_UDPMasterContext.maxRetryCount,
        .timeoutInms   = RPC_UDPMasterContext.msgRetryIntervalMs,
    };

    if (TFTP_STATE_RESET == TFTP_GetState(&RPC_UDPMasterContext.connections.tx.tftpContext)) {
        config.payloadId = RPC_UDPMasterContext.connections.tx.payloadId;
        retVal = TFTP_Init(&RPC_UDPMasterContext.connections.tx.tftpContext, &config);
        if (BCM_ERR_OK == retVal) {
            retVal = TFTP_ClientWrite(&RPC_UDPMasterContext.connections.tx.tftpContext, fName);
            RPC_UDPMasterContext.connections.tx.stats.numConnects++;
        }
    }
    if ((BCM_ERR_OK == retVal) &&
        (TFTP_STATE_RESET == TFTP_GetState(&RPC_UDPMasterContext.connections.rx.tftpContext))) {
        config.payloadId = RPC_UDPMasterContext.connections.rx.payloadId;
        retVal = TFTP_Init(&RPC_UDPMasterContext.connections.rx.tftpContext, &config);
        if (BCM_ERR_OK == retVal) {
            retVal = TFTP_ClientRead(&RPC_UDPMasterContext.connections.rx.tftpContext, fName);
            RPC_UDPMasterContext.connections.rx.stats.numConnects++;
        }
    }

    return retVal;
}

/** @brief RPC UDP Master Interface Process message

    @trace #BRCM_SWARCH_RPC_UDPMASTERIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP

    @limitations None

    @code{.unparsed}
    return RPC_UDPCommonProcessMsg(&RPC_UDPMasterContext.connections,
                                RPC_UDPMasterContext.keepAliveIntervalNs,
                                &RPC_UDPMasterIfc,
                                TFTP_STATE_READ,
                                TFTP_STATE_WRITE)
    @endcode
*/
static int32_t RPC_UDPMasterProcessMsg(void)
{
    return RPC_UDPCommonProcessMsg(&RPC_UDPMasterContext.connections,
                                   RPC_UDPMasterContext.keepAliveIntervalNs,
                                   &RPC_UDPMasterIfc,
                                   TFTP_STATE_READ,
                                   TFTP_STATE_WRITE);
}

/** @brief RPC UDP Master Interface Send message

    Interface Function to send response/async message

    @trace #BRCM_SWARCH_RPC_UDPMASTERIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP

    @limitations None

    @code{.unparsed}
    int32_t retVal
    int32_t ret
    RPC_UDPConnType *conn = &RPC_UDPMasterContext.txConn
    RPC_MemMsgType *inMsg
    uint32_t procLen = 0UL
    uint32_t appInfo
    if (TFTP_STATE_WRITE == TFTP_GetState(&conn->tftpContext))
        inMsg = RPC_MsgGet(aHdl)
        retVal = RPC_MemPushAppInfo(aHdl, aHdl)
        if (BCM_ERR_OK == retVal)
            inMsg->magic = RPC_MEMMSG_MAGIC
            retVal = TFTP_PutDataHandler(&conn->tftpContext,
                                         (uint8_t*)inMsg, TFTP_DEFAULT_DATA_LEN,
                                         &procLen, FALSE)
            if (BCM_ERR_BUSY != retVal)
                RPC_UDPMasterDisconnect()
                retVal = BCM_ERR_UNKNOWN
            else if (TFTP_DEFAULT_DATA_LEN != procLen)
                 In a case if PING was sent, but ACK is awaited. This response
                 will not be transmitted until ACK is got for PING
                 RPC module will retry
                retVal = BCM_ERR_NOMEM
             else
                conn->lastTxTime = BCM_GetTimeNs()
                retVal = BCM_ERR_OK

            ret = RPC_MemPopAppInfo(aHdl, &appInfo)
            if (BCM_ERR_OK != ret)
                retVal = BCM_ERR_UNKNOWN
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
static int32_t RPC_UDPMasterSendMsg(RPC_HdlType aHdl)
{
    int32_t retVal;
    int32_t ret;
    RPC_UDPConnType *conn = &RPC_UDPMasterContext.connections.tx;
    RPC_MemMsgType *inMsg;
    uint32_t procLen = 0UL;
    uint32_t appInfo;

    if (TFTP_STATE_WRITE == TFTP_GetState(&conn->tftpContext)) {
        inMsg = RPC_MsgGet(aHdl);
        retVal = RPC_MemPushAppInfo(aHdl, aHdl);
        if (BCM_ERR_OK == retVal) {
            inMsg->magic = RPC_MEMMSG_MAGIC;
            retVal = TFTP_PutDataHandler(&conn->tftpContext,
                                         (uint8_t*)inMsg, TFTP_DEFAULT_DATA_LEN,
                                         &procLen, FALSE);
            if (BCM_ERR_BUSY != retVal) {
                RPC_UDPMasterDisconnect();
                retVal = BCM_ERR_UNKNOWN;
            } else if (TFTP_DEFAULT_DATA_LEN != procLen) {
                /* In a case if PING was sent, but ACK is awaited. This response */
                /* will not be transmitted until ACK is got for PING             */
                /* RPC module will retry                                         */
                retVal = BCM_ERR_NOMEM;
            } else {
                conn->lastTxTime = BCM_GetTimeNs();
                retVal = BCM_ERR_OK;
            }
            ret = RPC_MemPopAppInfo(aHdl, &appInfo);
            if (BCM_ERR_OK != ret) {
                retVal = BCM_ERR_UNKNOWN;
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

/** @brief RPC UDP Master Interface Handle Asynchronous message

    Interface function used to receive Asynchronous message.

    @behavior Sync, Non-Reentrant

    @param[in]      aInMsg          Incoming Asynchronous message pointer
    @param[out]     aHdl            Handle to received message

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK         Message received successfully and copied
    @retval     #BCM_ERR_UNKNOWN    Message allocation failed

    @trace #BRCM_SWARCH_RPC_UDPMASTERIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP

    @limitations None

    @code{.unparsed}
    int32_t retVal
    RPC_MemMsgType *msg
    msg = RPC_MsgGet(*aHdl)
    if (NULL != msg)
        BCM_MemCpy(msg, aInMsg, sizeof(RPC_MemMsgType))
        retVal = BCM_ERR_OK
     else
        retVal = BCM_ERR_UNKNOWN
    return retVal
    @endcode
*/
static int32_t RPC_UDPMasterHandleAsync(RPC_MemMsgType *aInMsg,
                                        RPC_HdlType* const aHdl)
{
    int32_t retVal;
    RPC_MemMsgType *msg;

    msg = RPC_MsgGet(*aHdl);
    if (NULL != msg) {
        BCM_MemCpy(msg, aInMsg, sizeof(RPC_MemMsgType));
        retVal = BCM_ERR_OK;
    } else {
        retVal = BCM_ERR_UNKNOWN;
    }

    return retVal;
}

/** @brief RPC UDP Master Interface Handle Response

    Interface function used to receive response message.

    @behavior Sync, Non-Reentrant

    @param[in]      aInMsg          Incoming response message pointer
    @param[out]     aHdl            Handle to received message

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK         Message received successfully and copied
    @retval     #BCM_ERR_UNKNOWN    AppInfo not found OR Invalid AppInfo

    @trace #BRCM_SWARCH_RPC_UDPMASTERIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP

    @limitations None

    @code{.unparsed}
    int32_t retVal
    RPC_MemMsgType *msg = NULL
    retVal = RPC_MemPeekAppInfo(aInMsg, aHdl)
    if (BCM_ERR_OK == retVal)
        msg = RPC_MsgGet(*aHdl)
        if (NULL != msg)
            BCM_MemCpy(msg, aInMsg, sizeof(RPC_MemMsgType))
            retVal would already be BCM_ERR_OK and
            aHdl would point to cmd handle
         else
            retVal = BCM_ERR_UNKNOWN
    return retVal
    @endcode
*/
static int32_t RPC_UDPMasterHandleResponse(RPC_MemMsgType *aInMsg,
                                           RPC_HdlType* const aHdl)
{
    int32_t retVal;
    RPC_MemMsgType *msg = NULL;

    retVal = RPC_MemPeekAppInfo(aInMsg, aHdl);
    if (BCM_ERR_OK == retVal) {
        msg = RPC_MsgGet(*aHdl);
        if (NULL != msg) {
            BCM_MemCpy(msg, aInMsg, sizeof(RPC_MemMsgType));
            retVal = RPC_MemPopAppInfo(*aHdl, aHdl);
            if (BCM_ERR_OK != retVal) {
                retVal = BCM_ERR_UNKNOWN;
            }
            /* retVal would already be BCM_ERR_OK and */
            /* aHdl would point to cmd handle         */
        } else {
            retVal = BCM_ERR_UNKNOWN;
        }
    }

    if (BCM_ERR_OK != retVal) {
        *aHdl = RPC_HDL_INVALID;
        retVal = BCM_ERR_UNKNOWN;
    }

    return retVal;
}

/** @brief RPC UDP Master Interface Receive Message

    @trace #BRCM_SWARCH_RPC_UDPMASTERIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP

    @limitations None

    @code{.unparsed}
    int32_t retVal
    RPC_UDPConnType *conn = &RPC_UDPMasterContext.rxConn
    RPC_MemMsgType *msg = (RPC_MemMsgType*)&conn->msgBuffer
    uint32_t filledBufLen = 0UL

    if (TFTP_STATE_READ == TFTP_GetState(&conn->tftpContext))
        Async message requires a handle, so allocate handle
        retVal = RPC_MsgAlloc(RPC_HDL_INVALID,
                              RPC_UDPMasterContext.peerId,
                              RPC_UDPMasterContext.selfId,
                              RPC_UDPMasterContext.assocId,
                              aHdl)
        if (BCM_ERR_OK == retVal)
            if (TRUE == conn->isMsgPending)
                filledBufLen = TFTP_DEFAULT_DATA_LEN
                retVal = BCM_ERR_BUSY
                conn->isMsgPending = FALSE
            else
                do
                    retVal = TFTP_GetDataHandler(&conn->tftpContext,
                                             conn->msgBuffer,
                                             TFTP_DEFAULT_DATA_LEN,
                                             &filledBufLen)
                while (BCM_ERR_NOMEM == retVal)

            if (filledBufLen == TFTP_DEFAULT_DATA_LEN)
                if (RPC_UDP_KEEPALIVE_CMD == msg->cmd)
                    RPC_Release(*aHdl)
                    *aHdl = RPC_HDL_INVALID
                    retVal = BCM_ERR_NOT_FOUND
                else if (0UL != (msg->cmd & BCM_CMD_ASYNC_MASK))
                    Async msg
                    retVal = RPC_UDPMasterHandleAsync(msg, aHdl)
                else
                    RPC_Release(*aHdl)
                    *aHdl = RPC_HDL_INVALID
                     response msg
                    retVal = RPC_UDPMasterHandleResponse(msg, aHdl)
             else
                if (BCM_ERR_BUSY != retVal)
                    retVal = BCM_ERR_UNKNOWN
                 else
                    retVal = BCM_ERR_NOT_FOUND
                RPC_Release(*aHdl)
                *aHdl = RPC_HDL_INVALID
        else
            *aHdl = RPC_HDL_INVALID;
            retVal = BCM_ERR_NOT_FOUND;
     else
        *aHdl = RPC_HDL_INVALID
        retVal = BCM_ERR_NOT_FOUND
    return retVal
    @endcode
*/
static int32_t RPC_UDPMasterRecvMsg(RPC_HdlType* const aHdl)
{
    int32_t retVal;
    RPC_UDPConnType *conn = &RPC_UDPMasterContext.connections.rx;
    RPC_MemMsgType *msg = (RPC_MemMsgType*)&conn->msgBuffer;
    uint32_t filledBufLen = 0UL;

    if (TFTP_STATE_READ == TFTP_GetState(&conn->tftpContext)) {
        /* Async message requires a handle, so allocate handle */
        retVal = RPC_MsgAlloc(RPC_HDL_INVALID,
                              RPC_UDPMasterContext.peerId,
                              RPC_UDPMasterContext.selfId,
                              RPC_UDPMasterContext.assocId,
                              aHdl);
        if (BCM_ERR_OK == retVal) {
            if (TRUE == conn->isMsgPending) {
                filledBufLen = TFTP_DEFAULT_DATA_LEN;
                retVal = BCM_ERR_BUSY;
                conn->isMsgPending = FALSE;
            } else {
                do {
                    filledBufLen = 0UL;
                    retVal = TFTP_GetDataHandler(&conn->tftpContext,
                                                 conn->msgBuffer,
                                                 TFTP_DEFAULT_DATA_LEN,
                                                 &filledBufLen);
                } while (BCM_ERR_NOMEM == retVal);
            }
            if (filledBufLen == TFTP_DEFAULT_DATA_LEN) {
                if (RPC_UDP_KEEPALIVE_CMD == msg->cmd) {
                    RPC_Release(*aHdl);
                    *aHdl = RPC_HDL_INVALID;
                    retVal = BCM_ERR_NOT_FOUND;
                } else if (0UL != (msg->cmd & BCM_CMD_ASYNC_MASK)) {
                    /* Async msg */
                    retVal = RPC_UDPMasterHandleAsync(msg, aHdl);
                } else {
                    RPC_Release(*aHdl);
                    *aHdl = RPC_HDL_INVALID;
                    /* response msg */
                    retVal = RPC_UDPMasterHandleResponse(msg, aHdl);
                }
            } else {
                if (BCM_ERR_BUSY != retVal) {
                    retVal = BCM_ERR_UNKNOWN;
                } else {
                    retVal = BCM_ERR_NOT_FOUND;
                }
                RPC_Release(*aHdl);
                *aHdl = RPC_HDL_INVALID;
            }
        } else {
            *aHdl = RPC_HDL_INVALID;
            retVal = BCM_ERR_NOT_FOUND;
        }
    } else {
        *aHdl = RPC_HDL_INVALID;
        retVal = BCM_ERR_NOT_FOUND;
    }
    return retVal;
}

/** @brief RPC UDP parse filename received in TFTP request

    @behavior Sync, Re-entrant

    @param[in]      aStr                String with the number in hexadecimal format
    @param[in]      aStrSize            Input string length
    @param[out]     aValue              Number in integer format

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Number converted successfully
    @retval     #BCM_ERR_INVAL_PARAMS   Error in number conversion

    @trace #BRCM_SWARCH_RPC_UDPMASTERIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP

    @code{.unparsed}
    int32_t ret = BCM_ERR_OK
    uint32_t value = 0UL
    uint32_t idx = 0UL
    uint32_t len = BCM_StrnLen(aStr, aStrSize)
    char var
    while ((aStr[idx] != '\0') && (idx < len) && (ret == BCM_ERR_OK))
        var = (char)aStr[idx]
        switch (var)
            case '0'...'9':
                value = (value * ETHUTILS_FILEDEF_BASE_HEX) +
                        (uint32_t)aStr[idx] - (uint32_t)'0'
                break
            case 'a'...'f':
                value = (value * ETHUTILS_FILEDEF_BASE_HEX) +
                        (uint32_t)aStr[idx] - (uint32_t)'a' +
                        ETHUTILS_FILEDEF_BASE_DEC
                break
            case 'A'...'F':
                value = (value * ETHUTILS_FILEDEF_BASE_HEX) +
                        (uint32_t)aStr[idx] -
                        (uint32_t)'A' + ETHUTILS_FILEDEF_BASE_DEC
                break
            case 'x':
            case 'X':
                break
            default:
                ret = BCM_ERR_INVAL_PARAMS
                break
        idx++
    *aValue = value
    return ret
    @endcode
*/
static int32_t RPC_UDPMasterConvHex2Int(const char* aStr,
                                        uint32_t aStrSize,
                                        uint32_t *const aValue)
{
    int32_t ret = BCM_ERR_OK;
    uint32_t value = 0UL;
    uint32_t idx = 0UL;
    uint32_t len = BCM_StrnLen(aStr, aStrSize);
    char var;

    while ((aStr[idx] != '\0') && (idx < len) && (ret == BCM_ERR_OK)) {
        var = (char)aStr[idx];
        switch (var) {
            case '0'...'9':
                value = (value * ETHUTILS_FILEDEF_BASE_HEX) +
                        (uint32_t)aStr[idx] - (uint32_t)'0';
                break;
            case 'a'...'f':
                value = (value * ETHUTILS_FILEDEF_BASE_HEX) +
                        (uint32_t)aStr[idx] - (uint32_t)'a' +
                        ETHUTILS_FILEDEF_BASE_DEC;
                break;
            case 'A'...'F':
                value = (value * ETHUTILS_FILEDEF_BASE_HEX) +
                        (uint32_t)aStr[idx] -
                        (uint32_t)'A' + ETHUTILS_FILEDEF_BASE_DEC;
                break;
            case 'x':
            case 'X':
                break;
            default:
                ret = BCM_ERR_INVAL_PARAMS;
                break;
        }
        idx++;
    }

    *aValue = value;
    return ret;
}

/** @brief RPC UDP parse filename received in TFTP request

    @behavior Sync, Re-entrant

    @param[in]      aFileName           Buffer containing the filename
    @param[out]     aImgID              Image identifier
    @param[out]     aPID                Partition identifier
    @param[out]     aTotalSize          Size of the image
    @param[out]     aIsImgTbl           Boolean to indicate if its a image table

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             File name  parsed successfully
    @retval     #BCM_ERR_INVAL_PARAMS   Invalid file name string

    @trace #BRCM_SWARCH_RPC_UDPMASTERIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP

    @code{.unparsed}
    int32_t ret
    uint32_t value
    uint32_t len = BCM_StrnLen(aFileName, TFTP_MAX_FILENAME_LEN)

    if ((0L == strncmp(aFileName, "bcm-", 4L)) &&
        (len == RPC_UDP_MASTER_FILENAME_SIZE))
        Expect a string in the below format
        bcm-<manuf(8)>-<model(8)>-<rev(8)>-<istbl(2) pid(2) imgID(4)>-<offset(8)>-<size(8)>.bin
        ret = RPC_UDPMasterConvHex2Int(&aFileName[ETHUTILS_FILEDEF_IMGID_START],
                                       ETHUTILS_FILEDEF_IMGID_LEN, &value)
        if (BCM_ERR_OK == ret)
            *aImgID = (uint16_t)value
         else
            goto end
        ret = RPC_UDPMasterConvHex2Int(&aFileName[ETHUTILS_FILEDEF_PID_START],
                                       ETHUTILS_FILEDEF_PID_LEN, &value)
        if (BCM_ERR_OK == ret)
            *aPID = (uint8_t)value
         else
            goto end
        ret = RPC_UDPMasterConvHex2Int(&aFileName[ETHUTILS_FILEDEF_OFFSET_START],
                                                  ETHUTILS_FILEDEF_OFFSET_LEN, aOffset)
        if (BCM_ERR_OK != ret)
            goto end
        ret = RPC_UDPMasterConvHex2Int(&aFileName[ETHUTILS_FILEDEF_SIZE_START],
                                                  ETHUTILS_FILEDEF_SIZE_LEN, aTotalSize)
        if (BCM_ERR_OK != ret)
            goto end
        ret = RPC_UDPMasterConvHex2Int(&aFileName[ETHUTILS_FILEDEF_ISTBL_START],
                                                  ETHUTILS_FILEDEF_ISTBL_LEN, &value)
        if (BCM_ERR_OK == ret)
            *aIsImgTbl = (uint8_t)value
     else if ((0L == strncmp(aFileName, "bcm-", 4L)) &&
               (len == RPC_UDP_MASTER_LEGACY_FILENAME_SIZE))
        Format used by legacy ROM
        ret = RPC_PlatParseEthBootFileName(aFileName, len, aImgID, aPID,
                                           aOffset, aTotalSize, aIsImgTbl)
     else
        ret = BCM_ERR_INVAL_PARAMS
end:
    return ret
    @endcode
*/
static int32_t RPC_UDPMasterIfcParseFileName(char* aFileName,
                                             uint16_t* const aImgID,
                                             uint8_t*  const aPID,
                                             uint32_t* const aOffset,
                                             uint32_t* const aTotalSize,
                                             uint8_t*  const aIsImgTbl)
{
    int32_t ret;
    uint32_t value;
    uint32_t len = BCM_StrnLen(aFileName, TFTP_MAX_FILENAME_LEN);

    if ((0L == strncmp(aFileName, "bcm-", 4L)) &&
        (len == RPC_UDP_MASTER_FILENAME_SIZE)) {

        /* Expect a string in the below format */
        /* rpc-<manuf(8)>-<model(8)>-<rev(8)>-<istbl(2) pid(2) imgID(4)>-<offset(8)>-<size(8)>.bin */
        ret = RPC_UDPMasterConvHex2Int(&aFileName[ETHUTILS_FILEDEF_IMGID_START],
                                       ETHUTILS_FILEDEF_IMGID_LEN, &value);
        if (BCM_ERR_OK == ret){
            *aImgID = (uint16_t)value;
        } else {
            goto end;
        }
        ret = RPC_UDPMasterConvHex2Int(&aFileName[ETHUTILS_FILEDEF_PID_START],
                                       ETHUTILS_FILEDEF_PID_LEN, &value);
        if (BCM_ERR_OK == ret){
            *aPID = (uint8_t)value;
        } else {
            goto end;
        }
        ret = RPC_UDPMasterConvHex2Int(&aFileName[ETHUTILS_FILEDEF_OFFSET_START],
                                                  ETHUTILS_FILEDEF_OFFSET_LEN, aOffset);
        if (BCM_ERR_OK != ret){
            goto end;
        }
        ret = RPC_UDPMasterConvHex2Int(&aFileName[ETHUTILS_FILEDEF_SIZE_START],
                                                  ETHUTILS_FILEDEF_SIZE_LEN, aTotalSize);
        if (BCM_ERR_OK != ret){
            goto end;
        }
        ret = RPC_UDPMasterConvHex2Int(&aFileName[ETHUTILS_FILEDEF_ISTBL_START],
                                                  ETHUTILS_FILEDEF_ISTBL_LEN, &value);
        if (BCM_ERR_OK == ret){
            *aIsImgTbl = (uint8_t)value;
        }
    } else if ((0L == strncmp(aFileName, "bcm-", 4L)) &&
               (len == RPC_UDP_MASTER_LEGACY_FILENAME_SIZE)) {
        /* Format used by legacy ROM */
        ret = RPC_PlatParseEthBootFileName(aFileName, len, aImgID, aPID,
                                           aOffset, aTotalSize, aIsImgTbl);
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }

end:
    return ret;
}

/** @brief RPC UDP Master Interface Detect Stream request

    @trace #BRCM_SWARCH_RPC_UDPMASTERIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP

    @code{.unparsed}
    TFTP_ConfigType config =
        .compId        = BCM_RPC_ID,
        .maxRetryCount = RPC_UDPMasterContext.maxRetryCount,
        .timeoutInms   = RPC_UDPMasterContext.retryIntervalMs,

    retVal = TFTP_DetectPacket(BCM_RPC_ID, RPC_UDPMasterContext.serverPayloadId,
                               aFileName, &packetType,
                               &clientIPAddr, &clientPort,
                               &options)
    if (BCM_ERR_OK == retVal)
        Parse file name and fill the stream config structure
        retVal = RPC_UDPMasterIfcParseFileName((char *)aFileName, &strmCfg.imgId, (uint8_t*)&strmCfg.pid,
                                               &strmCfg.offset, &strmCfg.xferSize, (uint8_t*)&strmCfg.isTbl)
        if (BCM_ERR_OK == retVal)
            Accept request only if a valid image is present in IMGL
            numBytes = IMGL_GetImgSize(strmCfg.pid, strmCfg.imgId, strmCfg.offset)
            if (0UL < numBytes)
                Detect if its a partial fetch and update transfer size
                if ((0UL != strmCfg.offset) || (numBytes > strmCfg.xferSize))
                    strmCfg.partial = TRUE
                 else
                    strmCfg.partial = FALSE
                strmCfg.xferSize = (numBytes > strmCfg.xferSize) ? strmCfg.xferSize: numBytes
        If file name parsing failed, or if the IMG is not present
        if ((BCM_ERR_OK != retVal) || (0UL == numBytes))
            (void)TFTP_ServerRejectConnection(..)
            retVal = BCM_ERR_NOT_FOUND
         else
            retVal = RPC_StrmAlloc(..)
            if (BCM_ERR_OK != retVal)
                (void)TFTP_ServerRejectConnection(..)
                retVal = BCM_ERR_NOT_FOUND
             else
                index = RPC_MemGetIndex(*aHdl)
                RPC_UDPMasterContext.streams[index].isLastPacket = FALSE
                config.payloadId = RPC_UDPMasterContext.streams[index].payloadId
                config.remoteIPAddr = clientIPAddr
                retVal = TFTP_Init(&RPC_UDPMasterContext.streams[index].tftpContext,
                                   &config)
                if (BCM_ERR_OK == retVal)
                    retVal = TFTP_ServerAcceptConnection(&RPC_UDPMasterContext.streams[index].tftpContext,
                                                         clientPort, TRUE)
     else
        retVal = BCM_ERR_NOT_FOUND
    return retVal

    @endcode
*/
static int32_t RPC_UDPMasterDetectStream(RPC_HdlType* const aHdl)
{
    int32_t retVal;
    uint8_t aFileName[TFTP_MAX_FILENAME_LEN];
    TFTP_PacketType packetType;
    uint32_t clientIPAddr = INET_IPADDRESS_INVALID;
    uint16_t clientPort = INET_PORT_INVALID;
    TFTP_OptionCfgType options;
    uint32_t index = 0UL;
    uint32_t numBytes = 0UL;
    RPC_StrmCfgType strmCfg;
    TFTP_ConfigType config = {
        .compId        = BCM_RPC_ID,
        .maxRetryCount = RPC_UDPMasterContext.maxRetryCount,
        .timeoutInms   = RPC_UDPMasterContext.streamRetryIntervalMs,
    };
    BCM_MemSet(&options, 0U, sizeof(options));
    BCM_MemSet(aFileName, 0U, sizeof(aFileName));

    /* Check for any new stream requests */
    retVal = TFTP_DetectPacket(BCM_RPC_ID, RPC_UDPMasterContext.connections.serverPayloadId,
                               aFileName, &packetType,
                               &clientIPAddr, &clientPort,
                               &options);
    if (BCM_ERR_OK == retVal) {
        BCM_MemSet(&strmCfg, 0U, sizeof(RPC_StrmCfgType));
        /* Parse file name and fill the stream config structure */
        retVal = RPC_UDPMasterIfcParseFileName((char *)aFileName, &strmCfg.imgId, (uint8_t*)&strmCfg.pid,
                                               &strmCfg.offset, &strmCfg.xferSize, (uint8_t*)&strmCfg.isTbl);
        if (BCM_ERR_OK == retVal) {
            if (1UL == strmCfg.isTbl) {
                numBytes = strmCfg.xferSize;
                strmCfg.partial = FALSE;
            } else {
                /* Accept request only if a valid image is present in IMGL */
                numBytes = RPC_GetImgSize(strmCfg.pid, strmCfg.imgId, strmCfg.offset);
                if (0UL < numBytes) {
                    /* Detect if its a partial fetch and update transfer size */
                    if ((0UL != strmCfg.offset) || (numBytes > strmCfg.xferSize)) {
                        strmCfg.partial = TRUE;
                    } else {
                        strmCfg.partial = FALSE;
                    }
                    strmCfg.xferSize = (numBytes > strmCfg.xferSize) ? strmCfg.xferSize: numBytes;
                }
            }
        }
        /* If file name parsing failed, or if the IMG is not present */
        if ((BCM_ERR_OK != retVal) || (0UL == numBytes)) {
            (void)TFTP_ServerRejectConnection(BCM_RPC_ID, RPC_UDPMasterContext.connections.serverPayloadId,
                                              clientIPAddr, clientPort,TFTP_ERROR_FILE_NOT_FOUND,
                                              aFileName);
            retVal = BCM_ERR_NOT_FOUND;
        } else {
            retVal = RPC_StrmAlloc(&strmCfg, RPC_UDPMasterContext.peerId,
                                   RPC_UDPMasterContext.selfId, RPC_UDPMasterContext.assocId, aHdl);
            if (BCM_ERR_OK != retVal) {
                (void)TFTP_ServerRejectConnection(BCM_RPC_ID, RPC_UDPMasterContext.connections.serverPayloadId,
                                                  clientIPAddr, clientPort,TFTP_ERROR_FILE_NOT_FOUND,
                                                  aFileName);
                retVal = BCM_ERR_NOT_FOUND;
            } else {
                index = RPC_MemGetIndex(*aHdl);
                RPC_UDPMasterContext.connections.streams[index].isLastPacket = FALSE;
                config.payloadId = RPC_UDPMasterContext.connections.streams[index].payloadId;
                config.remoteIPAddr = clientIPAddr;
                BCM_MemCpy(&config.options, &options, sizeof(options));

                retVal = TFTP_Init(&RPC_UDPMasterContext.connections.streams[index].tftpContext,
                                   &config);
                if (BCM_ERR_OK == retVal) {
                    retVal = TFTP_ServerAcceptConnection(&RPC_UDPMasterContext.connections.streams[index].tftpContext,
                                                         clientPort, TRUE);
                    RPC_UDPMasterContext.connections.streams[index].lastProcTime = BCM_GetTimeNs();
                }

                /* In case of any error, release stream handle */
                if (BCM_ERR_OK != retVal) {
                    RPC_Release(*aHdl);
                    retVal = BCM_ERR_UNKNOWN;
                }
            }
        }
    } else {
        retVal = BCM_ERR_NOT_FOUND;
    }

    return retVal;
}

/** @brief RPC UDP Master Interface Process Stream

    @trace #BRCM_SWARCH_RPC_UDPMASTERIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP

    @limitations Legacy stream requests shall not be supported

    @code{.unparsed}
    RPC_MemStrmClientInfoType *clientInfo = RPC_StrmGetMasterClientInfo(aHdl)
    index = RPC_MemGetIndex(aHdl)
    retVal = RPC_StrmGetCfg(aHdl, &strmCfg)
    if ((BCM_ERR_OK == retVal) &&  (NULL != clientInfo))
        Proceed only after all stream details are fetched successfully
        blockSize = TFTP_GetBlockSize(&RPC_UDPMasterContext.streams[index].tftpContext)
        New stream packet to be composed and sent
        (void)RPC_StrmGetFilledSz(aHdl, &rdSize, &totalSize)
        If we have got the last piece of data for the stream
        if (strmCfg.xferSize == (rdSize + totalSize))
             When last packet was sent, but call to this API is done during TFTP linger
            if ((FALSE == RPC_UDPMasterContext.streams[index].isLastPacket) &&
                (blockSize < rdSize))
                rdSize = blockSize
             else
                Final fragment of TFTP stream transfer
                No change to 'rdSize'
                RPC_UDPMasterContext.streams[index].isLastPacket = TRUE
         else if (blockSize < rdSize)
             Intermediate stream packets, send only when we have TFTP_MAX_DATA_LEN bytes
            rdSize = blockSize
         else
             Not ready to send a TFTP data packet, insufficient data
            rdSize = 0UL
            retVal = BCM_ERR_BUSY
        Peek and copy the computed number of bytes
        (void)RPC_StrmPeek(aHdl, RPC_UDPMasterContext.streamBuffer, rdSize, &procSize)

        If there is data to be sent OR TFTP linger period is ON after sending last packet
        if ((0UL < rdSize) ||
            (TRUE == RPC_UDPMasterContext.streams[index].isLastPacket))
            procSize = 0UL
            retVal = TFTP_PutDataHandler(&RPC_UDPMasterContext.streams[index].tftpContext,
                                         RPC_UDPMasterContext.streamBuffer,
                                         rdSize, &procSize,
                                         RPC_UDPMasterContext.streams[index].isLastPacket)
            if (BCM_ERR_OK == retVal)
                Case when entire file was sent successfully and linger duration is complete
                RPC_UDPMasterContext.streams[index].isLastPacket = FALSE
                clientInfo->isProcessDone = TRUE
            else if (BCM_ERR_BUSY == retVal)
                if (procSize == rdSize)
                     Read from stream to empty the bytes that was transmitted by TFTP
                    (void)RPC_StrmRead(aHdl, RPC_UDPMasterContext.streamBuffer, rdSize, &procSize)
            else
                Stream connection failed, free context
                (void)TFTP_DeInit(&RPC_UDPMasterContext.streams[index].tftpContext)
                retVal = BCM_ERR_UNKNOWN
                clientInfo->isProcessDone = TRUE
        else if (((0UL == totalSize) && (BCM_STATE_SUB_STATE_DONE == aPeerState)) ||
                 ((2000ULL * 1000000ULL) < (currTime - RPC_UDPMasterContext.connections.streams[index].lastProcTime)))
            (void)TFTP_DeInit(&RPC_UDPMasterContext.connections.streams[index].tftpContext)
            RPC_UDPMasterContext.connections.streams[index].isLastPacket = FALSE
            retVal = BCM_ERR_UNKNOWN
            clientInfo->state = BCM_STATE_SUB_STATE_DONE
    else
        In case the peer module reports an error, then close this stream
        (void)TFTP_DeInit(&RPC_UDPMasterContext.streams[index].tftpContext)
        RPC_UDPMasterContext.streams[index].isLastPacket = FALSE
        retVal = BCM_ERR_UNKNOWN
        if (NULL != clientInfo)
            clientInfo->isProcessDone = TRUE
    return retVal

    @endcode
*/
static int32_t RPC_UDPMasterProcessStream(RPC_HdlType aHdl, BCM_SubStateType aPeerState)
{
    int32_t retVal;
    RPC_StrmCfgType strmCfg;
    RPC_MemStrmClientInfoType *clientInfo = RPC_StrmGetMasterClientInfo(aHdl);
    uint32_t rdSize = 0UL;
    uint32_t procSize = 0UL;
    uint32_t totalSize = 0UL;
    uint32_t blockSize = 0UL;
    uint64_t currTime = 0ULL;
    uint32_t index = RPC_MemGetIndex(aHdl);

    retVal = RPC_StrmGetCfg(aHdl, &strmCfg);
    if ((BCM_ERR_OK == retVal) &&  (NULL != clientInfo)) {
        blockSize = TFTP_GetBlockSize(&RPC_UDPMasterContext.connections.streams[index].tftpContext);
        /* New stream packet to be composed and sent */
        (void)RPC_StrmGetFilledSz(aHdl, &rdSize, &totalSize);

        /* If we have got the last piece of data for the stream */
        if (strmCfg.xferSize == (rdSize + totalSize)) {
            /* When last packet was sent, but call to this API is done during TFTP linger */
            if ((FALSE == RPC_UDPMasterContext.connections.streams[index].isLastPacket) &&
                (blockSize < rdSize)) {
                rdSize = blockSize;
            } else {
                /* Final fragment of TFTP stream transfer */
                /* No change to 'rdSize'                  */
                RPC_UDPMasterContext.connections.streams[index].isLastPacket = TRUE;
            }
        } else if (blockSize < rdSize) {
            /* Intermediate stream packets, send only when we have TFTP_MAX_DATA_LEN bytes */
            rdSize = blockSize;
        } else {
            /* Not ready to send a TFTP data packet, insufficient data */
            rdSize = 0UL;
            retVal = BCM_ERR_BUSY;
        }
        /* Peek and copy the computed number of bytes */
        (void)RPC_StrmPeek(aHdl, RPC_UDPMasterContext.streamBuffer, rdSize, &procSize);
        currTime = BCM_GetTimeNs();

        /* If there is data to be sent OR TFTP linger period is ON after sending last packet */
        if ((0UL < rdSize) ||
            (TRUE == RPC_UDPMasterContext.connections.streams[index].isLastPacket)) {
            procSize = 0UL;
            retVal = TFTP_PutDataHandler(&RPC_UDPMasterContext.connections.streams[index].tftpContext,
                                         RPC_UDPMasterContext.streamBuffer,
                                         rdSize, &procSize,
                                         RPC_UDPMasterContext.connections.streams[index].isLastPacket);
            if (BCM_ERR_OK == retVal) {
                /* Case when entire file was sent successfully and linger duration is complete */
                RPC_UDPMasterContext.connections.streams[index].isLastPacket = FALSE;
                (void)RPC_StrmRead(aHdl, RPC_UDPMasterContext.streamBuffer, rdSize, &procSize);
                clientInfo->state = BCM_STATE_SUB_STATE_DONE;
            } else if (BCM_ERR_BUSY == retVal) {
                if ((procSize == rdSize) && (FALSE == RPC_UDPMasterContext.connections.streams[index].isLastPacket)) {
                    /* Read from stream to empty the bytes that was transmitted by TFTP */
                    (void)RPC_StrmRead(aHdl, RPC_UDPMasterContext.streamBuffer, rdSize, &procSize);
                    RPC_UDPMasterContext.connections.streams[index].lastProcTime = BCM_GetTimeNs();
                }
            } else {
                /* Stream connection failed, free context */
                (void)TFTP_DeInit(&RPC_UDPMasterContext.connections.streams[index].tftpContext);
                retVal = BCM_ERR_UNKNOWN;
                clientInfo->state = BCM_STATE_SUB_STATE_DONE;
            }
        } else if (((0UL == totalSize) &&
                    (BCM_STATE_SUB_STATE_DONE == aPeerState)) ||
                   ((2000ULL * 1000000ULL /* 2000ms */) < (currTime - RPC_UDPMasterContext.connections.streams[index].lastProcTime))) {
            (void)TFTP_DeInit(&RPC_UDPMasterContext.connections.streams[index].tftpContext);
            RPC_UDPMasterContext.connections.streams[index].isLastPacket = FALSE;
            retVal = BCM_ERR_UNKNOWN;
            clientInfo->state = BCM_STATE_SUB_STATE_DONE;
        } else {
            /* Nothing */
        }
    } else {
        /* In case the peer module reports an error, then close this stream */
        (void)TFTP_DeInit(&RPC_UDPMasterContext.connections.streams[index].tftpContext);
        RPC_UDPMasterContext.connections.streams[index].isLastPacket = FALSE;
        retVal = BCM_ERR_UNKNOWN;
        if (NULL != clientInfo) {
            clientInfo->state = BCM_STATE_SUB_STATE_DONE;
        }
    }

    return retVal;
}

/** @brief RPC UDP Master Interface channel de-initialization

    This API used to deinitialize the UDP Master Interface

    @behavior Sync, Non-Reentrant

    @param[in]      void

    @retval void

    @trace #BRCM_SWARCH_RPC_UDPMASTERIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP

    @limitations None

    @code{.unparsed}
    RPC_UDPCommonDeInit(&RPC_UDPMasterContext.connections)
    @endcode
*/
static void RPC_UDPMasterDeinitialize(void)
{
    RPC_UDPCommonDeInit(&RPC_UDPMasterContext.connections);
}

/** @brief UDP Master interface structure

    @trace #BRCM_SWARCH_RPC_UDPMASTERIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP
*/
const RPC_InterfaceType RPC_UDPMasterIfc = {
    .type          = RPC_IFC_CHAN_UDP,
    .mode          = RPC_IFC_CHAN_MODE_MASTER,
    .assoc         = RPC_ASSOCIATIONINDEX_1,
    .init          = RPC_UDPMasterInitialize,
    .isConnected   = RPC_UDPMasterIsConnected,
    .connect       = RPC_UDPMasterConnect,
    .getMsgSize    = RPC_UDPCommonGetMsgSize,
    .sendMsg       = RPC_UDPMasterSendMsg,
    .recvMsg       = RPC_UDPMasterRecvMsg,
    .processMsg    = RPC_UDPMasterProcessMsg,
    .detectStrm    = RPC_UDPMasterDetectStream,
    .processStrm   = RPC_UDPMasterProcessStream,
    .disconnect    = RPC_UDPMasterDisconnect,
    .getEventMask  = RPC_UDPCommonGetEventMask,
    .deinit        = RPC_UDPMasterDeinitialize,
};

/** @} */
