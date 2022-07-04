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
    @defgroup grp_rpc_ipc_slave_impl IPC Slave Design
    @ingroup grp_rpc_v2_ipc

    @addtogroup grp_rpc_ipc_slave_impl
    @{

    @file rpc_ipc_slave.c
    @brief IPC Slave Interface Design

    @version 0.1 Initial Version
*/

#include <stddef.h>
#include <string.h>
#include <bcm_err.h>
#include <bcm_utils.h>
#include <bcm_comp.h>
#include <rpc_mem.h>
#include <rpc_interface.h>
#include <rpc_ipc_slave_osil.h>
#include <rpc_ipc_common.h>
#include <imgl_interface.h>
#include <mcu.h>

/**
    @name RPC IPC Slave Interface Design IDs
    @{
    @brief Design IDs for RPC IPC slave Interface
*/
#define BRCM_SWDSGN_RPC_IPCSLAVESTREAMSTATE_TYPE        (0xA102U)    /**< @brief #RPC_IPCSlaveStreamStateType */
#define BRCM_SWDSGN_RPC_IPCSLAVECONTEXT_TYPE            (0xA103U)    /**< @brief #RPC_IPCSlaveContextType */
#define BRCM_SWDSGN_RPC_IPCSLAVECONTEXT_GLOBAL          (0xA104U)    /**< @brief #RPC_IPCSlaveContext */
#define BRCM_SWDSGN_RPC_IPCSLAVEISSTREAM_PROC           (0xA105U)    /**< @brief #RPC_IPCSlaveIsStream */
#define BRCM_SWDSGN_RPC_IPCSLAVEINIT_PROC               (0xA106U)    /**< @brief #RPC_IPCSlaveInit */
#define BRCM_SWDSGN_RPC_IPCSLAVEISCONNECTED_PROC        (0xA107U)    /**< @brief #RPC_IPCSlaveIsConnected */
#define BRCM_SWDSGN_RPC_IPCSLAVECONNECT_PROC            (0xA108U)    /**< @brief #RPC_IPCSlaveConnect */
#define BRCM_SWDSGN_RPC_IPCSLAVEGETEVENTMASK_PROC       (0xA109U)    /**< @brief #RPC_IPCSlaveGetEventMask */
#define BRCM_SWDSGN_RPC_IPCSLAVESENDMSG_PROC            (0xA10AU)    /**< @brief #RPC_IPCSlaveSendMsg */
#define BRCM_SWDSGN_RPC_IPCSLAVESTREAMSENDASYNCREQ_PROC (0xA10BU)    /**< @brief #RPC_IPCSlaveStreamSendAsyncReq */
#define BRCM_SWDSGN_RPC_IPCSLAVESENDSTREAMIMGHACK_PROC  (0xA10CU)    /**< @brief #RPC_IPCSlaveSendStreamImghACK */
#define BRCM_SWDSGN_RPC_IPCSLAVESENDSTREAMACK_PROC      (0xA10DU)    /**< @brief #RPC_IPCSlaveSendStreamACK */
#define BRCM_SWDSGN_RPC_IPCSLAVERECVMSG_PROC            (0xA10EU)    /**< @brief #RPC_IPCSlaveRecvMsg */
#define BRCM_SWDSGN_RPC_IPCSLAVEPROCESSSTREAM_PROC      (0xA10FU)    /**< @brief #RPC_IPCSlaveProcessStream */
#define BRCM_SWDSGN_RPC_IPCSLAVEDISCONNECT_PROC         (0xA110U)    /**< @brief #RPC_IPCSlaveDisconnect */
#define BRCM_SWDSGN_RPC_IPCSLAVEDEINIT_PROC             (0xA111U)    /**< @brief #RPC_IPCSlaveDeinit */
#define BRCM_SWDSGN_RPC_IPCSLAVEIFC_GLOBAL              (0xA112U)    /**< @brief #RPC_IPCSlaveIfc */
#define BRCM_SWDSGN_RPC_IPCSLAVEHANDLELEGACYMSG_PROC    (0xA113U)    /**< @brief #RPC_IPCSlaveHandleLegacyMsg */
#define BRCM_SWDSGN_RPC_IPCSLAVE_MSG_IS_LEGACY_MACRO    (0xA114U)    /**< @brief #RPC_IPCSLAVE_MSG_IS_LEGACY */
#define BRCM_SWDSGN_RPC_IPCSLAVESENDSTREAMDATAACK_PROC  (0xA115U)    /**< @brief #RPC_IPCSlaveSendStreamDataACK */
/** @} */

/**
    @brief RPC app information stored in RPC memory message type

    @trace #BRCM_SWARCH_RPC_IPCSLAVEIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_IPC_SLAVE
*/
#define RPC_IPCSLAVE_MSG_IS_LEGACY  (0U)

/**
    @name RPC IPC Stream State types

    @{
    @brief Various states of RPC IPC stream processing

    @trace #BRCM_SWARCH_RPC_IPCSLAVEIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_IPC_SLAVE
*/
typedef uint32_t RPC_IPCSlaveStreamStateType;
#define RPC_IPCSLAVESTREAMSTATE_RESET            (BCM_STATE_SUB_STATE_RESET)  /**< @brief New stream request */
#define RPC_IPCSLAVESTREAMSTATE_EXPECT_IMGH      (BCM_STATE_SUB_STATE_STAGE0) /**< @brief Async request sent and Expecting IMG HDR */
#define RPC_IPCSLAVESTREAMSTATE_PEND_ACK_IMGH_TX (BCM_STATE_SUB_STATE_STAGE1) /**< @brief Acknowledgement(IMG HDR) pending transmission */
#define RPC_IPCSLAVESTREAMSTATE_READY            (BCM_STATE_SUB_STATE_STAGE2) /**< @brief Ready to receive stream data */
#define RPC_IPCSLAVESTREAMSTATE_PEND_ACK_DATA_TX (BCM_STATE_SUB_STATE_STAGE3) /**< @brief Acknowledgement(data) pending transmission */
#define RPC_IPCSLAVESTREAMSTATE_COMPLETE         (BCM_STATE_SUB_STATE_DONE)   /**< @brief Stream processing complete */
/** @} */

/**
    @brief RPC IPC slave Context type

    @trace #BRCM_SWARCH_RPC_IPCSLAVEIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_IPC_SLAVE
*/
typedef struct sRPC_IPCSlaveContextType {
    RPC_InterfaceIdType selfId;         /**< @brief This Interface ID */
    RPC_InterfaceIdType peerId;         /**< @brief Connected Master ID */
    RPC_AssociationIndexType assocId;   /**< @brief This Interface Association ID */
    uint16_t  bootInfo;                 /**< @brief Boot Info fetched from mcu */
    uint8_t   rsv;                      /**< @brief Reserved */
} RPC_IPCSlaveContextType;

/**
    @brief RPC IPC slave Context

    @trace #BRCM_SWARCH_RPC_IPCSLAVEIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_IPC_SLAVE
*/
static RPC_IPCSlaveContextType RPC_IPCSlaveContext COMP_SECTION(".bss.rpc");

/** @brief RPC IPC Message/Stream type determination

    Identify if a command-ID is of stream type

    @behavior Sync, Re-entrant

    @param[in]  aCmdID              Command identifier

    Return values are documented in reverse-chronological order
    @retval     #TRUE               Command is of stream type
    @retval     #FALSE              Command is not of stream type

    @trace #BRCM_SWARCH_RPC_IPCSLAVEIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_IPC_SLAVE

    @code{.unparsed}
    if ((BCM_CMDID(BCM_GROUPID_IMGL, BCM_RSV_ID, RPC_CMDIDVAL_DWNLD_IMG_HDR_V2) == aCmdID) ||
        (BCM_CMDID(BCM_GROUPID_IMGL, BCM_RSV_ID, RPC_CMDIDVAL_DWNLD_IMG_V2) == aCmdID))
        isStream = TRUE
    else
        isStream = FALSE
    return isStream
    @endcode
*/
static uint32_t RPC_IPCSlaveIsStream(uint32_t aCmdID)
{
    uint32_t isStream;
    if ((BCM_CMDID(BCM_GROUPID_IMGL, BCM_RSV_ID, RPC_CMDIDVAL_DWNLD_IMG_HDR_V2) == aCmdID) ||
        (BCM_CMDID(BCM_GROUPID_IMGL, BCM_RSV_ID, RPC_CMDIDVAL_DWNLD_IMG_V2) == aCmdID)) {
        isStream = TRUE;
    } else {
        isStream = FALSE;
    }
    return isStream;
}

/** @brief RPC IPC Slave Interface Initialization

    Function to initialize the IPC Slave Interface

    @behavior Sync, Non-Reentrant

    @param[in]      void

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Init successful
    @retval     #BCM_ERR_UNKNOWN        Init Failed

    @trace #BRCM_SWARCH_RPC_IPCSLAVEIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_IPC_SLAVE

    @limitations None

    @code{.unparsed}
    IPC_Init(RPC_IPCSLAVE_CHANNEL_NUM)
    BCM_MemSet(RPC_IPCSlaveContext, 0U, sizeof(RPC_IPCSlaveContext))
    retVal = RPC_GetModIfcAndAssoc(&RPC_IPCSlaveIfc, &RPC_IPCSlaveContext.selfId,
                                 &RPC_IPCSlaveContext.peerId,
                                 &RPC_IPCSlaveContext.assocId)
    MCU_GetInfo(&info)
    RPC_IPCSlaveContext.bootInfo = info.bootInfo & 0xFFFFUL
    return retVal
    @endcode
*/
static int32_t RPC_IPCSlaveInit(void)
{
    int32_t retVal;
    MCU_InfoType info;

    IPC_Init(RPC_IPCSLAVE_CHANNEL_NUM);
    BCM_MemSet(&RPC_IPCSlaveContext, 0U, sizeof(RPC_IPCSlaveContext));
    retVal = RPC_GetModIfcAndAssoc(&RPC_IPCSlaveIfc, &RPC_IPCSlaveContext.selfId,
                                 &RPC_IPCSlaveContext.peerId,
                                 &RPC_IPCSlaveContext.assocId);

    info.bootInfo = 0UL;
    (void)MCU_GetInfo(&info);
    RPC_IPCSlaveContext.bootInfo = info.bootInfo & 0xFFFFUL;

    return retVal;
}

/** @brief RPC IPC Slave Interface connection status

    @behavior Sync, Non-Reentrant

    @param[in]      void

    @return     FALSE - Disconnected, TRUE - Connected

    @trace #BRCM_SWARCH_RPC_IPCSLAVEIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_IPC_SLAVE

    @limitations None

    @code{.unparsed}
    return TRUE
    @endcode
*/
static uint32_t RPC_IPCSlaveIsConnected(void)
{
    return TRUE;
}

/** @brief RPC IPC Slave Interface Connect

    This API will initiate connection to remote master.

    @behavior Sync, Non-Reentrant

    @param[in]      void

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Connection established
    @retval     #BCM_ERR_NOT_FOUND      No Connection established
    @retval     #BCM_ERR_UNKNOWN        Unknown failure

    @trace #BRCM_SWARCH_RPC_IPCSLAVEIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_IPC_SLAVE

    @limitations None

    @code{.unparsed}
    return BCM_ERR_OK
    @endcode
*/
static int32_t RPC_IPCSlaveConnect(void)
{
    return BCM_ERR_OK;
}

/** @brief Get the event mask for the interface

    API to return the event mask for the interface.

    @behavior Sync, Reentrant

    @pre None

    @param void

    @retval     #uint32_t   Event mask for the interface

    @post None

    @trace #BRCM_SWARCH_RPC_IPCSLAVEIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_IPC_SLAVE

    @code{.unparsed}
    return RPC_IPCSlaveChann0Event
    @endcode
*/
static uint32_t RPC_IPCSlaveGetEventMask(void)
{
    return RPC_IPCSlaveChann0Event;
}

/** @brief Update the command message

    Internal function to detect the command message format
    and update into the RPC_MemMsgType structure

    @behavior Sync, Reentrant

    @pre None

    @param void

    @retval   void

    @post None

    @trace #BRCM_SWARCH_RPC_IPCSLAVEIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_IPC_SLAVE

    @code{.unparsed}
    msgType = RPC_MsgGet(aMsgHdl)
    if (RPC_MEMMSG_MAGIC == msgType->magic)
        msgType->response = BCM_ERR_CUSTOM
        update client info as newer format message
        msgType.rsvd = FALSE
    else
        BCM_MemMove(msgType.payload, msgType, aLen)
        msgType.cmd = aCmdID
        msgType.len = aLen
        msgType->appinfoTop = 0UL
        BCM_MemSet(msgType->appinfo, 0u, sizeof(msgType->appinfo))
        msgType->response = BCM_ERR_CUSTOM
        msgType.rsvd = TRUE
    return
    @endcode
*/
static void RPC_IPCSlaveHandleLegacyMsg(RPC_HdlType* aMsgHdl, uint32_t aCmdID, uint32_t aLen)
{
    RPC_MemMsgType *msgType = NULL;

    msgType = RPC_MsgGet(*aMsgHdl);
    if (NULL == msgType) {
        /* Log error */
    } else {
        if (RPC_MEMMSG_MAGIC == msgType->magic) {
            msgType->response = BCM_ERR_CUSTOM;
            /* Update client info as newer format message */
            msgType->rsvd = FALSE;
        } else {
            /* Message is in older format which is plain payload */
            /* Newer format msg will be using RPC_MemMsgType     */
            BCM_MemMove(msgType->payload, msgType, aLen);
            msgType->cmd = aCmdID;
            msgType->len = aLen;
            msgType->appinfoTop = 0UL;
            msgType->timeoutMs = 0UL;
            BCM_MemSet(msgType->appinfo, 0u, sizeof(msgType->appinfo));
            msgType->response = BCM_ERR_CUSTOM;
            msgType->rsvd = TRUE;
        }
    }
    return;
}

/** @brief RPC IPC Slave Interface Send message

    Interface Function to send response/async message

    @behavior Sync, Non-Reentrant

    @param[in]      aHdl                Message Handle to be sent

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Message sent successfully
    @retval     #BCM_ERR_NOMEM          Message not sent out due to lack of
                                        buffers. The operation should be retried
    @retval     #BCM_ERR_UNKNOWN        Unknown failure

    @trace #BRCM_SWARCH_RPC_IPCSLAVEIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_IPC_SLAVE

    @limitations None

    @code{.unparsed}
    retVal = BCM_ERR_UNKNOWN
    RPC_MemMsgType *msg
    totalLen = 0UL

    msg = RPC_MsgGet(aHdl)
    if (NULL != msg)
        scratchMsg = RPC_MsgScratch()
        if (TRUE == msg->rsvd)
            RPC_ResponseMsgType *respLegacy = (RPC_ResponseMsgType *)scratchMsg;
            if (0UL == (msg.cmd & BCM_CMD_ASYNC_MASK))
                respLegacy->status = aRespCode
                totalLen = sizeof(RPC_RespCodeType)
            }
            BCM_MemCpy(respLegacy.payload, msg.payload, msg.len)
            totalLen += msg.len
            retVal = IPC_Send(RPC_IPCSLAVE_CHANNEL_NUM, msg.cmd, respLegacy, totalLen);
        else
            msg->magic = RPC_MEMMSG_MAGIC
            retVal = IPC_Send(RPC_IPCSLAVE_CHANNEL_NUM, msg.cmd, msg, sizeof(RPC_MemMsgType));

        if ((BCM_ERR_BUSY == retVal) || (BCM_ERR_NOMEM == retVal))
            retVal = BCM_ERR_NOMEM
        else if (BCM_ERR_OK != retVal)
            retVal = BCM_ERR_UNKNOWN
        else
            retVal = BCM_ERR_OK
        return retVal
    @endcode
*/
static int32_t RPC_IPCSlaveSendMsg(RPC_HdlType aHdl)
{
    int32_t retVal = BCM_ERR_UNKNOWN;
    RPC_MemMsgType *msg = NULL;
    RPC_MemMsgType *scratchMsg = NULL;
    RPC_ResponseMsgType *respLegacy = NULL;
    uint32_t totalLen = 0UL;

    msg = RPC_MsgGet(aHdl);
    if (NULL != msg) {
        scratchMsg = RPC_MsgScratch();
        if (NULL != scratchMsg) {
            if (TRUE == msg->rsvd) {
                respLegacy = (RPC_ResponseMsgType *)scratchMsg;
                if (0UL == (msg->cmd & BCM_CMD_ASYNC_MASK)) {
                    respLegacy->status = msg->response;
                    totalLen = sizeof(int32_t);
                }
                BCM_MemCpy(((uint8_t*)respLegacy + totalLen), msg->payload, msg->len);
                totalLen += msg->len;
                retVal = IPC_Send(RPC_IPCSLAVE_CHANNEL_NUM, msg->cmd,
                                  (uint8_t*)respLegacy, totalLen);
            } else {
                msg->magic = RPC_MEMMSG_MAGIC;
                retVal = IPC_Send(RPC_IPCSLAVE_CHANNEL_NUM, msg->cmd, (uint8_t*)msg,
                                  sizeof(RPC_MemMsgType) - (RPC_MEM_MSG_PAYLOAD_SZ - msg->len));
            }

            if ((BCM_ERR_BUSY == retVal) || (BCM_ERR_NOMEM == retVal)) {
                retVal = BCM_ERR_NOMEM;
            } else if (BCM_ERR_OK != retVal) {
                retVal = BCM_ERR_UNKNOWN;
            } else {
                (void)RPC_Release(aHdl);
                retVal = BCM_ERR_OK;
            }
        } else {
            retVal = BCM_ERR_UNKNOWN;
        }
    }
    return retVal;
}

/** @brief RPC IPC Slave Interface Receive Message

    Interface function used to receive command message.
    Client to invoke this API until #BCM_ERR_NOT_FOUND is got

    @behavior Sync, Non-Reentrant

    @param[out]     aHdl            Handle to received message

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK         Message received successfully and copied
    @retval     #BCM_ERR_OK         Message being processed, client to
                                    invoke this API again
    @retval     #BCM_ERR_NOT_FOUND  No Message received
    @retval     #BCM_ERR_UNKNOWN    Unknown failure

    @trace #BRCM_SWARCH_RPC_IPCSLAVEIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_IPC_SLAVE

    @limitations None

    @code{.unparsed}
    BCM_CmdType cmdVal
    uint32_t packetLen = sizeof(RPC_MemMsgType)
    isStream = FALSE

    if (NULL == aHdl)
        retVal = BCM_ERR_UNKNOWN
    else
        retVal = RPC_MsgAlloc(RPC_HDL_INVALID, RPC_IPCSlaveContext.selfId,
                                               RPC_IPCSlaveContext.peerId,
                                               RPC_IPCSlaveContext.assocId,
                                               aHdl)
        if (BCM_ERR_OK == retVal)
            msgType = RPC_MsgGet(aHdl)
            retVal = IPC_Receive(RPC_IPCSLAVE_CHANNEL_NUM, &cmdVal, (uint8_t*)msgType, &packetLen)
            if ((BCM_ERR_NOMEM == retVal) || (BCM_ERR_BUSY == retVal))
                retVal = BCM_ERR_NOT_FOUND
                RPC_Release(*aHdl)
            else if (BCM_ERR_OK != retVal)
                Handle failure at IPC driver
                retVal = BCM_ERR_UNKNOWN
                RPC_Release(*aHdl)
            else
                if (encrpyted != cmdVal)
                    isStream = RPC_IPCSlaveIsStream(cmdVal)
                    if (TRUE == isStream)
                        streamHandle = get targetStrmHdl from the packet
                        clientInfo = RPC_StrmGetSlaveClientInfo(streamHandle)
                        if(clientInfo IS NOT NULL)
                            RPC_IPCSlaveHandleLegacyMsg(*aHdl, cmdVal, packetLen)
                            clientInfo->pendingMsgHdl = *aHdl
                            clientInfo->peerhdl = hdr->hostStrmHdl
                            this msg will be processed in the next ProcessStream call
                            *aHdl = 0UL
                            retVal = BCM_ERR_BUSY
                        else
                            RPC_Release(*aHdl);
                            retVal = BCM_ERR_UNKNOWN
                if (command)
                    RPC_IPCSlaveHandleLegacyMsg(*aHdl, cmdVal, packetLen)
                    If (IMGL group, PING command)
                        RPC_PingType *ping = (RPC_PingType *)msgType->payload
                        BCM_MemSet(msgType->payload, 0U, sizeof(msgType->payload))
                        ping->mode = RPC_CURRENT_BOOT_MODE
                        MCU_GetVersion(&ping->version)
                        msgType->len = sizeof(RPC_PingType)
                        msgType->response = BCM_ERR_NOSUPPORT
                        retVal = RPC_IPCSlaveSendMsg(*aHdl)
                        if (retVal IS BCM_ERR_OK)
                            retVal = BCM_ERR_BUSY
                    else
                        aHdl already holds valid handle
                        retVal = BCM_ERR_OK
        else
            return BCM_ERR_NOT_FOUND
    @endcode
*/
static int32_t RPC_IPCSlaveRecvMsg(RPC_HdlType* const aHdl)
{
    BCM_CmdType cmdVal = 0UL;
    uint32_t packetLen = sizeof(RPC_MemMsgType);
    uint32_t isStream = FALSE;
    RPC_MemMsgType *msgType = NULL;
    RPC_MemStrmClientInfoType *clientInfo = NULL;
    RPC_HdlType streamHandle = 0UL;
    RPC_HdlType peerhdl;
    int32_t retVal;

    if (NULL == aHdl) {
        retVal = BCM_ERR_UNKNOWN;
    } else {
        retVal = RPC_MsgAlloc(RPC_HDL_INVALID,
                              RPC_IPCSlaveContext.selfId,
                              RPC_IPCSlaveContext.peerId,
                              RPC_IPCSlaveContext.assocId,
                              aHdl);
        if (BCM_ERR_OK == retVal) {
            msgType = RPC_MsgGet(*aHdl);
            if (NULL != msgType) {
                retVal = IPC_Receive(RPC_IPCSLAVE_CHANNEL_NUM, &cmdVal,
                        (uint8_t*)msgType, sizeof(RPC_MemMsgType),
                        &packetLen);
                if ((BCM_ERR_NOMEM == retVal) || (BCM_ERR_BUSY == retVal)) {
                    retVal = BCM_ERR_NOT_FOUND;
                    (void)RPC_Release(*aHdl);
                } else if (BCM_ERR_OK != retVal) {
                    /* Handle failure at IPC driver */
                    retVal = BCM_ERR_UNKNOWN;
                    (void)RPC_Release(*aHdl);
                } else {
                    isStream = RPC_IPCSlaveIsStream(cmdVal);
                    if (TRUE == isStream) {
                        if (RPC_CMDIDVAL_DWNLD_IMG_HDR_V2 == BCM_GET_CMDID(cmdVal)) {
                            RPC_DwnldHdrV2Type *hdr = (RPC_DwnldHdrV2Type*)msgType;
                            streamHandle = hdr->targetStrmHdl;
                            peerhdl = hdr->hostStrmHdl;
                        } else {
                            RPC_DwnldImageType *hdr = (RPC_DwnldImageType*)msgType;
                            streamHandle = hdr->targetStrmHdl;
                            peerhdl = hdr->hostStrmHdl;
                        }
                        clientInfo = RPC_StrmGetSlaveClientInfo(streamHandle);
                        if (NULL != clientInfo) {
                            clientInfo->peerHdl = peerhdl;
                            RPC_IPCSlaveHandleLegacyMsg(aHdl, cmdVal, packetLen);
                            clientInfo->pendingMsgHdl = *aHdl;
                            /* This stream packet will be processed in the
                               next ProcessStream call */
                            *aHdl = 0UL;
                            retVal = BCM_ERR_BUSY;
                        } else {
                            (void)RPC_Release(*aHdl);
                            retVal = BCM_ERR_UNKNOWN;
                        }
                    } else {
                        RPC_IPCSlaveHandleLegacyMsg(aHdl, cmdVal, packetLen);

                        /* Handle IMGL group, PING command */
                        if ((BCM_GROUPID_IMGL == BCM_GET_GROUPID(msgType->cmd)) &&
                            (RPC_CMDIDVAL_PING == BCM_GET_CMDID(msgType->cmd))) {
                            RPC_PingType *ping = (void *)msgType->payload;
                            BCM_MemSet(msgType->payload, 0U, sizeof(msgType->payload));
                            ping->mode = RPC_CURRENT_BOOT_MODE;
                            MCU_GetVersion(&ping->version);
                            msgType->len = sizeof(RPC_PingType);
                            msgType->response = BCM_ERR_OK;
                            retVal = RPC_IPCSlaveSendMsg(*aHdl);
                            if (BCM_ERR_OK == retVal) {
                                retVal = BCM_ERR_BUSY;
                            } else {
                                /* TODO: Cache this in context to be retried later */
                            }
                        } else {
                            /* aHdl already holds valid handle */
                            retVal = BCM_ERR_OK;
                        }
                    }
                }
            } else {
                retVal = BCM_ERR_UNKNOWN;
            }
        } else {
            retVal = BCM_ERR_NOT_FOUND;
        }
    }

    return retVal;
}

/** @brief RPC IPC Send Async message

    Send an async message to retrieve a particular image buffer

    @behavior Sync, Re-entrant

    @param[in]      aCfg                Stream config got from RPC Mem layer
    @param[in]      aHdl                Stream handle

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Success
    @retval     #BCM_ERR_BUSY           IPC channel buffer underflow
    @retval     #BCM_ERR_UNKNOWN        Failure at IPC driver

    @trace #BRCM_SWARCH_RPC_IPCSLAVEIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_IPC_SLAVE

    @code{.unparsed}

    if (aCfg->partial IS FALSE)
        cmdID = BCM_ASYNCID(BCM_GROUPID_IMGL, BCM_RSV_ID, RPC_CMDIDVAL_IMAGE_FETCH_V2);
    else
        cmdID = BCM_ASYNCID(BCM_GROUPID_IMGL, BCM_RSV_ID, RPC_CMDIDVAL_IMAGE_PART_FETCH_V2);

    if (RPC_CMDIDVAL_IMAGE_FETCH_V2 == BCM_GET_CMDID(cmdID))
        RPC_ImgReqV2Type imgReq;
        if (TRUE == aCfg->isTbl)
            imgReq.isTbl = 1U
        else
            imgReq.isImgHdr = 0U
            imgReq.imgID = aCfg->imgId
            imgReq.pid = aCfg->pid
            imgReq.imgMaxSize = aCfg->xferSize
            imgReq.offset = 0UL
            imgReq.targetStrmHdl = aHdl
            retVal = IPC_Send(RPC_IPCSLAVE_CHANNEL_NUM, cmdID, (uint8_t *)&imgReq,
                          sizeof(RPC_ImgReqType))
    else
        RPC_ImgReqV2Type imgPartReq
        imgPartReq.isTbl = 0U
        imgPartReq.imgID = aCfg->imgId
        imgPartReq.pid = aCfg->pid
        imgPartReq.offset = aCfg->offset
        imgPartReq.targetStrmHdl = aHdl
        imgPartReq.imgMaxSize = aCfg->xferSize
        retVal = IPC_Send(RPC_IPCSLAVE_CHANNEL_NUM, cmdID, (uint8_t *)&imgPartReq,
                          sizeof(RPC_ImgReqV2Type))

    if ((BCM_ERR_BUSY == retVal) || (BCM_ERR_NOMEM == retVal))
        retVal = BCM_ERR_BUSY
    return retVal
    @endcode
*/
static int32_t RPC_IPCSlaveStreamSendAsyncReq(RPC_StrmCfgType *aCfg, uint32_t aHdl)
{
    uint32_t cmdID;
    int32_t retVal;

    if (FALSE == aCfg->partial) {
        cmdID = BCM_ASYNCID(BCM_GROUPID_IMGL, BCM_RSV_ID, RPC_CMDIDVAL_IMAGE_FETCH_V2);
    } else {
        cmdID = BCM_ASYNCID(BCM_GROUPID_IMGL, BCM_RSV_ID, RPC_CMDIDVAL_IMAGE_PART_FETCH_V2);
    }

    if (RPC_CMDIDVAL_IMAGE_FETCH_V2 == BCM_GET_CMDID(cmdID)) {
        RPC_ImgReqV2Type imgReq;
        if (TRUE == aCfg->isTbl) {
            imgReq.isTbl = 1U;
        } else {
            imgReq.isTbl = 0U;
        }
        imgReq.imgID = aCfg->imgId;
        imgReq.pid = (uint8_t)aCfg->pid;
        imgReq.imgMaxSize = aCfg->xferSize;
        imgReq.targetStrmHdl = aHdl;
        imgReq.offset = 0UL;
        retVal = IPC_Send(RPC_IPCSLAVE_CHANNEL_NUM, cmdID,
                         (uint8_t *)&imgReq, sizeof(RPC_ImgReqV2Type));
    } else {
        RPC_ImgReqV2Type imgPartReq;
        imgPartReq.isTbl = 0U;
        imgPartReq.imgID = aCfg->imgId;
        imgPartReq.pid = (uint8_t)aCfg->pid;
        imgPartReq.offset = aCfg->offset;
        imgPartReq.targetStrmHdl = aHdl;
        imgPartReq.imgMaxSize = aCfg->xferSize;
        retVal = IPC_Send(RPC_IPCSLAVE_CHANNEL_NUM, cmdID,
                         (uint8_t *)&imgPartReq, sizeof(RPC_ImgReqV2Type));
    }

    if ((BCM_ERR_BUSY == retVal) || (BCM_ERR_NOMEM == retVal)) {
        retVal = BCM_ERR_BUSY;
    }

    return retVal;
}

/** @brief RPC IPC Slave Interface Send IMGH Acknowledgement

    Internal function used by interface to send pending IMGH Acknowledgement

    @behavior Sync, Non-Reentrant

    @param[in]      aHdl            Stream Handle
    @param[in]      strmCfg         Pointer to stream configuration
    @param[in]      pendingRespCode Response code

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Acknowledgement Sent successfully
    @retval     #BCM_ERR_BUSY           IPC Channel if busy/full, caller
                                        needs to retry at a later point in time
    @retval     #BCM_ERR_UNKNOWN        Unknown IPC failure

    @trace #BRCM_SWARCH_RPC_IPCSLAVEIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_IPC_SLAVE

    @limitations None

    @code{.unparsed}
    dlHdr = {
        .magicNum = IMGL_IMGH_MAGIC,
        .pid = aStrmCfg->pid,
        .imgID = aStrmCfg->imgId,
        .imgSize = aStrmCfg->xferSize,
        .targetStrmHdl = aHdl,
        .hostStrmHdl = aStrmCfg->peerHdl,
        .response = aRespCode,
    }

    retVal = IPC_Send(RPC_IPCSLAVE_CHANNEL_NUM, RPC_CMDIDVAL_DWNLD_IMG_HDR_V2,
                        (uint8_t *)&dlHdr, sizeof(RPC_DwnldHdrV2Type))
    if (BCM_ERR_BUSY == retVal) OR (BCM_ERR_NOMEM == retVal)
        retVal = BCM_ERR_BUSY
    else if (BCM_ERR_OK != retVal)
        retVal = BCM_ERR_UNKNOWN
    else
        retVal = BCM_ERR_OK
    return retVal
    @endcode
*/
static int32_t RPC_IPCSlaveSendStreamImghACK(RPC_HdlType aHdl, RPC_StrmCfgType *aStrmCfg,  RPC_MemStrmClientInfoType *aClientInfo)
{
    int32_t retVal;
    RPC_DwnldHdrV2Type dlHdr = {
                    .magicNum = IMGL_IMGH_MAGIC,
                    .pid = aStrmCfg->pid,
                    .imgID = aStrmCfg->imgId,
                    .imgSize = aStrmCfg->xferSize,
                    .targetStrmHdl = aHdl,
                    .hostStrmHdl = aClientInfo->peerHdl,
                    .response = aClientInfo->pendingRespCode,
                };

    retVal = IPC_Send(RPC_IPCSLAVE_CHANNEL_NUM, RPC_CMDIDVAL_DWNLD_IMG_HDR_V2,
                        (uint8_t *)&dlHdr, sizeof(RPC_DwnldHdrV2Type));
    if ((BCM_ERR_BUSY == retVal) || (BCM_ERR_NOMEM == retVal)) {
        retVal = BCM_ERR_BUSY;
    } else if (BCM_ERR_OK != retVal) {
        retVal = BCM_ERR_UNKNOWN;
    } else {
        retVal = BCM_ERR_OK;
    }

    return retVal;
}

/** @brief RPC IPC Slave Interface Send Data Acknowledgement

    Internal function used by interface to send pending Data Acknowledgement

    @behavior Sync, Non-Reentrant

    @param[in]      aHdl            Stream Handle
    @param[in]      strmCfg         Pointer to stream configuration
    @param[in]      pendingRespCode Response code

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Acknowledgement Sent successfully
    @retval     #BCM_ERR_BUSY           IPC Channel if busy/full, caller
                                        needs to retry at a later point in time
    @retval     #BCM_ERR_UNKNOWN        Unknown IPC failure

    @trace #BRCM_SWARCH_RPC_IPCSLAVEIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_IPC_SLAVE

    @limitations None

    @code{.unparsed}
    dlImg = {
        .magicNum = RPC_IPC_STREAM_MAGIC,
        .pid = aStrmCfg->pid,
        .imgID = aStrmCfg->imgId,
        .targetStrmHdl = aHdl,
        .hostStrmHdl = aStrmCfg->peerHdl,
        .len = aStrmCfg->xferSize,
        .response = aRespCode,
    }

    retVal = IPC_Send(RPC_IPCSLAVE_CHANNEL_NUM, RPC_CMDIDVAL_DWNLD_IMG_V2,
                        (uint8_t *)&dlImg, sizeof(RPC_DwnldImageType))
    if (BCM_ERR_BUSY == retVal) OR (BCM_ERR_NOMEM == retVal)
        retVal = BCM_ERR_BUSY
    else if (BCM_ERR_OK != retVal)
        retVal = BCM_ERR_UNKNOWN
    else
        retVal = BCM_ERR_OK
    return retVal
    @endcode
*/
static int32_t RPC_IPCSlaveSendStreamDataACK(RPC_HdlType aHdl, RPC_StrmCfgType *aStrmCfg, RPC_MemStrmClientInfoType *aClientInfo)
{
    int32_t retVal;
    RPC_DwnldImageType dlImg = {
                    .magicNum = RPC_IPC_STREAM_MAGIC,
                    .pid = aStrmCfg->pid,
                    .imgID = aStrmCfg->imgId,
                    .targetStrmHdl = aHdl,
                    .hostStrmHdl = aClientInfo->peerHdl,
                    .len = aStrmCfg->xferSize,
                    .response = aClientInfo->pendingRespCode,
                };

    retVal = IPC_Send(RPC_IPCSLAVE_CHANNEL_NUM, RPC_CMDIDVAL_DWNLD_IMG_V2,
                     (uint8_t *)&dlImg, sizeof(RPC_DwnldImageType));
    if ((BCM_ERR_BUSY == retVal) || (BCM_ERR_NOMEM == retVal)) {
        retVal = BCM_ERR_BUSY;
    } else if (BCM_ERR_OK != retVal) {
        retVal = BCM_ERR_UNKNOWN;
    } else {
        retVal = BCM_ERR_OK;
    }

    return retVal;
}

/** @brief RPC IPC Slave Interface Process Stream

    Interface function to read/write to stream and send/receive from remote end.
    Unknown failures may be recovered only with deinit and init.

    @behavior Sync, Non-Reentrant

    @param[in]      aHdl        Stream Handle to be processed

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Data processed successfully, stream completed
    @retval     #BCM_ERR_BUSY           Data processed successfully, more data expected
    @retval     #BCM_ERR_UNKNOWN        Unknown failure

    @trace #BRCM_SWARCH_RPC_IPCSLAVEIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_IPC_SLAVE

    @limitations Legacy stream requests shall not be supported

    @code{.unparsed}
    retVal = BCM_ERR_BUSY

    RPC_MemStrmClientInfoType *clientInfo = RPC_StrmGetSlaveClientInfo(aHdl)
    if (NULL == clientInfo)
        retVal = BCM_ERR_UNKNOWN
    else
        Proceed only if clientInfo fetched successfully
        retVal = RPC_StrmGetCfg(aHdl, strmCfg)
        if (PTBL_ID_BL == strmCfg.pid)
            strmCfg.imgId = RPC_IPCSlaveContext.bootInfo
        if (BCM_ERR_OK == retVal)
            msgPacket = RPC_MsgGet(clientInfo->pendingMsgHdl)
            if ((NULL == msgPacket)
                    && (RPC_IPCSLAVESTREAMSTATE_RESET != clientInfo->state)
                    && (RPC_IPCSLAVESTREAMSTATE_PEND_ACK_IMGH_TX != clientInfo->state)
                    && (RPC_IPCSLAVESTREAMSTATE_PEND_ACK_DATA_TX != clientInfo->state))
                retVal = BCM_ERR_BUSY
            else
                retVal = BCM_ERR_OK
        else
            retVal = BCM_ERR_UNKNOWN

        if (BCM_STATE_SUB_STATE_DONE == aPeerState)
            (void)RPC_Release(clientInfo->pendingMsgHdl)
            clientInfo->pendingMsgHdl = RPC_HDL_INVALID
            clientInfo->state = RPC_IPCSLAVESTREAMSTATE_COMPLETE
            retVal = BCM_ERR_OK
        else
            do {
                prevState = clientInfo->state
                switch (clientInfo->state)
                    case RPC_IPCSLAVESTREAMSTATE_RESET:
                        retVal = RPC_IPCSlaveStreamSendAsyncReq(strmCfg, aHdl)
                        if (BCM_ERR_OK == retVal)
                            clientInfo->state = RPC_IPCSLAVESTREAMSTATE_EXPECT_IMGH
                            retVal = BCM_ERR_BUSY
                        else
                            RPC module needs to retry sending - ASYNC by invoking this function again
                            retVal = BCM_ERR_BUSY
                        break
                    case RPC_IPCSLAVESTREAMSTATE_EXPECT_IMGH:
                        if (NULL != msgPacket)
                            RPC_DwnldHdrV2Type *imgHdr = (RPC_DwnldHdrV2Type *)msgPacket->payload
                            if (RPC_CMDIDVAL_DWNLD_IMG_HDR_V2 == BCM_GET_CMDID(msgPacket->cmd))
                                if (imgHdr->imgSize <= strmCfg->xferSize)
                                    (void)RPC_StrmSetXferSize(aHdl, imgHdr->imgSize)
                                    clientInfo->pendingRespCode = BCM_ERR_OK
                                else
                                    clientInfo->pendingRespCode = BCM_ERR_NOMEM
                            else
                                clientInfo->state = RPC_IPCSLAVESTREAMSTATE_PEND_ACK_IMGH_TX
                                (void)RPC_Release(clientInfo->pendingMsgHdl)
                                clientInfo->pendingMsgHdl = 0UL
                                break
                        else
                                clientInfo->state = RPC_IPCSLAVESTREAMSTATE_COMPLETE
                                retVal = BCM_ERR_UNKNOWN
                    case RPC_IPCSLAVESTREAMSTATE_READY:
                        if (0UL != clientInfo->pendingMsgHdl)
                            RPC_DwnldImageType *imgDataHdr = (RPC_DwnldImageType *)msgPacket->payload
                            (void)RPC_StrmGetFreeSz(aHdl, &freeSize, &accLen)
                            respCode = BCM_ERR_OK
                            if ((accLen + imgDataHdr->len) > strmCfg->xferSize)
                                Report error
                                respCode = BCM_ERR_NOMEM
                                peer has sent more than agreed-upon size, ignore additional bytes
                                imgDataHdr->len = strmCfg->xferSize - accLen

                            if (imgDataHdr->len <= freeSize)
                                (void)RPC_StrmWrite(aHdl, imgDataHdr->payload, imgDataHdr->len)
                                (void)RPC_Release(clientInfo->pendingMsgHdl)
                                clientInfo->pendingMsgHdl = 0UL
                                clientInfo->pendingRespCode = respCode
                                clientInfo->state = RPC_IPCSLAVESTREAMSTATE_PEND_ACK_DATA_TX
                        break
                    case RPC_IPCSLAVESTREAMSTATE_PEND_ACK_IMGH_TX:
                        retVal = RPC_IPCSlaveSendStreamImghACK(aHdl, &strmCfg, clientInfo->pendingRespCode)
                        if (BCM_ERR_OK == retVal)
                            clientInfo->state = RPC_IPCSLAVESTREAMSTATE_READY
                            retVal = BCM_ERR_BUSY
                        break
                    case RPC_IPCSLAVESTREAMSTATE_PEND_ACK_DATA_TX:
                        retVal = RPC_IPCSlaveSendStreamDataACK(aHdl, &strmCfg, clientInfo->pendingRespCode)
                        if (BCM_ERR_OK == retVal)
                            clientInfo->state = RPC_IPCSLAVESTREAMSTATE_READY
                            retVal = BCM_ERR_BUSY
                        break
                    case RPC_IPCSLAVESTREAMSTATE_COMPLETE:
                        retVal = BCM_ERR_OK
                    default:
                        retVal = BCM_ERR_UNKNOWN
            while (clientInfo->state != prevState)

            ret = RPC_StrmGetFreeSz(aStreamHdl, &size, &accLen)
            if ((BCM_ERR_OK == ret) && (accLen == streamCfg->xferSize))
                clientInfo->state = RPC_IPCSLAVESTREAMSTATE_COMPLETE
                retVal = BCM_ERR_OK
    return retVal
    @endcode
*/
static int32_t RPC_IPCSlaveProcessStream(RPC_HdlType aHdl, BCM_SubStateType aPeerState)
{
    int32_t retVal;
    int32_t ret;
    int32_t respCode;
    RPC_StrmCfgType strmCfg;
    RPC_MemStrmClientInfoType *clientInfo = RPC_StrmGetSlaveClientInfo(aHdl);
    RPC_MemMsgType *msgPacket = NULL;
    RPC_IPCSlaveStreamStateType prevState;
    uint32_t freeSize = 0UL;
    uint32_t accLen = 0UL;

    if (NULL == clientInfo) {
        retVal = BCM_ERR_UNKNOWN;
    } else {
        BCM_MemSet(&strmCfg, 0U, sizeof(RPC_StrmCfgType));
        retVal = RPC_StrmGetCfg(aHdl, &strmCfg);

        if (PTBL_ID_BL == strmCfg.pid) {
            strmCfg.imgId = RPC_IPCSlaveContext.bootInfo;
        }

        if (BCM_ERR_OK == retVal) {
                msgPacket = RPC_MsgGet(clientInfo->pendingMsgHdl);
            if ((NULL == msgPacket)
                    && (RPC_IPCSLAVESTREAMSTATE_RESET != clientInfo->state)
                    && (RPC_IPCSLAVESTREAMSTATE_PEND_ACK_IMGH_TX != clientInfo->state)
                    && (RPC_IPCSLAVESTREAMSTATE_PEND_ACK_DATA_TX != clientInfo->state)) {
                retVal = BCM_ERR_BUSY;
            } else {
                retVal = BCM_ERR_OK;
            }
        } else {
            retVal = BCM_ERR_UNKNOWN;
        }

        /* In case of peer timeout, complete stream */
        if (BCM_STATE_SUB_STATE_DONE == aPeerState) {
            (void)RPC_Release(clientInfo->pendingMsgHdl);
            clientInfo->pendingMsgHdl = RPC_HDL_INVALID;
            clientInfo->state = RPC_IPCSLAVESTREAMSTATE_COMPLETE;
            retVal = BCM_ERR_OK;
        } else if (BCM_ERR_OK == retVal) {
            do {
                prevState = clientInfo->state;
                switch (clientInfo->state) {
                    case RPC_IPCSLAVESTREAMSTATE_RESET: {
                        retVal = RPC_IPCSlaveStreamSendAsyncReq(&strmCfg, aHdl);
                        if (BCM_ERR_OK == retVal) {
                            clientInfo->state = RPC_IPCSLAVESTREAMSTATE_EXPECT_IMGH;
                            retVal = BCM_ERR_BUSY;
                        } else {
                            /* RPC Module needs to retry sending - ASYNC by
                               invoking this function again */
                            retVal = BCM_ERR_BUSY;
                        }
                        break;
                    }
                    case RPC_IPCSLAVESTREAMSTATE_EXPECT_IMGH: {
                        if (NULL != msgPacket) {
                            RPC_DwnldHdrV2Type *imgHdr = (void *)msgPacket->payload;
                            if (RPC_CMDIDVAL_DWNLD_IMG_HDR_V2 == BCM_GET_CMDID(msgPacket->cmd)) {
                                if (imgHdr->imgSize <= strmCfg.xferSize) {
                                    (void)RPC_StrmSetXferSize(aHdl, imgHdr->imgSize);
                                    clientInfo->pendingRespCode = BCM_ERR_OK;
                                } else {
                                    clientInfo->pendingRespCode = BCM_ERR_NOMEM;
                                }
                                clientInfo->state = RPC_IPCSLAVESTREAMSTATE_PEND_ACK_IMGH_TX;
                                (void)RPC_Release(clientInfo->pendingMsgHdl);
                                clientInfo->pendingMsgHdl = 0UL;
                            } else {
                                clientInfo->state = RPC_IPCSLAVESTREAMSTATE_COMPLETE;
                                retVal = BCM_ERR_UNKNOWN;
                            }
                        }
                        break;
                    }
                    case RPC_IPCSLAVESTREAMSTATE_READY: {
                        if (0UL != clientInfo->pendingMsgHdl) {
                            RPC_DwnldImageType *imgDataHdr = (void *)msgPacket->payload;
                            (void)RPC_StrmGetFreeSz(aHdl, &freeSize, &accLen);
                            respCode = BCM_ERR_OK;
                            if (NULL != imgDataHdr) {
                                if ((accLen + imgDataHdr->len) > strmCfg.xferSize) {
                                    /* Report error */
                                    respCode = BCM_ERR_NOMEM;
                                    /* peer has sent more than agreed-upon size, ignore additional bytes */
                                    imgDataHdr->len = strmCfg.xferSize - accLen;
                                }

                                if (imgDataHdr->len <= freeSize) {
                                    (void)RPC_StrmWrite(aHdl, imgDataHdr->imgData, imgDataHdr->len);
                                    (void)RPC_Release(clientInfo->pendingMsgHdl);
                                    clientInfo->pendingMsgHdl = 0UL;
                                    clientInfo->pendingRespCode = respCode;
                                    clientInfo->state = RPC_IPCSLAVESTREAMSTATE_PEND_ACK_DATA_TX;
                                }
                            }
                        }
                        retVal = BCM_ERR_BUSY;
                        break;
                    }
                    case RPC_IPCSLAVESTREAMSTATE_PEND_ACK_IMGH_TX: {
                        retVal = RPC_IPCSlaveSendStreamImghACK(aHdl, &strmCfg, clientInfo);
                        if (BCM_ERR_OK == retVal) {
                            clientInfo->state = RPC_IPCSLAVESTREAMSTATE_READY;
                            retVal = BCM_ERR_BUSY;
                        }
                        break;
                    }
                    case RPC_IPCSLAVESTREAMSTATE_PEND_ACK_DATA_TX: {
                        retVal = RPC_IPCSlaveSendStreamDataACK(aHdl, &strmCfg, clientInfo);
                        if (BCM_ERR_OK == retVal) {
                            clientInfo->state = RPC_IPCSLAVESTREAMSTATE_READY;
                            retVal = BCM_ERR_BUSY;
                        }
                        break;
                    }
                    case RPC_IPCSLAVESTREAMSTATE_COMPLETE:
                    break;
                    default: {
                        retVal = BCM_ERR_UNKNOWN;
                        break;
                    }
                }
            } while (clientInfo->state != prevState);

            ret = RPC_StrmGetFreeSz(aHdl, &freeSize, &accLen);
            if ((BCM_ERR_OK == ret) &&
                (accLen == strmCfg.xferSize)) {
                clientInfo->state = RPC_IPCSLAVESTREAMSTATE_COMPLETE;
                retVal = BCM_ERR_OK;
            }
        }
    }
    return retVal;
}

/** @brief RPC IPC Slave Interface Disconnect

    @behavior Sync, Non-Reentrant

    @param[in]      void

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Disconnection successful
    @retval     #BCM_ERR_UNKNOWN        Unknown failure

    @trace #BRCM_SWARCH_RPC_IPCSLAVEIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_IPC_SLAVE

    @limitations None

    @code{.unparsed}
    return BCM_ERR_OK
    @endcode
*/
static int32_t RPC_IPCSlaveDisconnect(void)
{
    return BCM_ERR_OK;
}

/** @brief RPC IPC Slave Interface channel de-initialization

    This API used to deinitialize the IPC Slave Interface

    @behavior Sync, Non-Reentrant

    @param[in]      void

    @retval void

    @trace #BRCM_SWARCH_RPC_IPCSLAVEIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_IPC_SLAVE

    @limitations None

    @code{.unparsed}
    BCM_MemSet(RPC_IPCSlaveContext, 0U, sizeof(RPC_IPCSlaveContext))
    IPC_DeInit(RPC_IPCSLAVE_CHANNEL_NUM)
    @endcode
*/
static void RPC_IPCSlaveDeinit(void)
{
    BCM_MemSet(&RPC_IPCSlaveContext, 0U, sizeof(RPC_IPCSlaveContext));
    (void)IPC_DeInit(RPC_IPCSLAVE_CHANNEL_NUM);
    return;
}

/** @brief IPC Slave interface structure

    @trace #BRCM_SWARCH_RPC_IPCSLAVEIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_IPC_SLAVE
*/
const RPC_InterfaceType RPC_IPCSlaveIfc = {
    .type          = RPC_IFC_CHAN_IPC,
    .mode          = RPC_IFC_CHAN_MODE_SLAVE,
    .assoc         = RPC_ASSOCIATIONINDEX_0,
    .init          = RPC_IPCSlaveInit,
    .isConnected   = RPC_IPCSlaveIsConnected,
    .connect       = RPC_IPCSlaveConnect,
    .sendMsg       = RPC_IPCSlaveSendMsg,
    .recvMsg       = RPC_IPCSlaveRecvMsg,
    .processStrm   = RPC_IPCSlaveProcessStream,
    .disconnect    = RPC_IPCSlaveDisconnect,
    .getEventMask  = RPC_IPCSlaveGetEventMask,
    .deinit        = RPC_IPCSlaveDeinit,
};

/** @} */
