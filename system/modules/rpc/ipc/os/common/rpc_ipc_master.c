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
    @defgroup grp_rpc_ipc_master_impl IPC Master Design
    @ingroup grp_rpc_v2_ipc

    @addtogroup grp_rpc_ipc_master_impl
    @{

    @file rpc_ipc_master.c
    @brief IPC Master Interface Design

    @version 0.1 Initial Version
*/
#include <stddef.h>
#include <string.h>
#include <stdio.h>
#include <bcm_err.h>
#include <bcm_utils.h>
#include <cpu_utils.h>
#include <bcm_comp.h>
#include <rpc_mem.h>
#include <rpc_interface.h>
#include <rpc_ipc_host.h>
#include <rpc_ipc_common.h>
#include <imgl_interface.h>
#include <rpc_local_osil.h>
#include <unistd.h>
#include <system_dmon.h>

/**
    @name RPC IPC Master interface Design IDs
    @{
    @brief Design IDs for RPC IPC master interface
*/
#define BRCM_SWDSGN_RPC_IPCMASTERSTREAMSTATE_TYPE        (0xA000U) /**< @brief #RPC_IPCMasterStreamStateType    */
#define BRCM_SWDSGN_RPC_IPCMASTERIFC_GLOBAL              (0xA001U) /**< @brief #RPC_IPCMasterIfc             */
#define BRCM_SWDSGN_RPC_IPCMASTERINIT_PROC               (0xA002U) /**< @brief #RPC_IPCMasterInit               */
#define BRCM_SWDSGN_RPC_IPCMASTERDEINIT_PROC             (0xA003U) /**< @brief #RPC_IPCMasterDeinit             */
#define BRCM_SWDSGN_RPC_IPCMASTERISCONNECTED_PROC        (0xA004U) /**< @brief #RPC_IPCMasterIsConnected        */
#define BRCM_SWDSGN_RPC_IPCMASTERCONNECT_PROC            (0xA005U) /**< @brief #RPC_IPCMasterConnect            */
#define BRCM_SWDSGN_RPC_IPCMASTERGETEVENTMASK_PROC       (0xA006U) /**< @brief #RPC_IPCMasterGetEventMask       */
#define BRCM_SWDSGN_RPC_IPCMASTERSENDMSG_PROC            (0xA007U) /**< @brief #RPC_IPCMasterSendMsg            */
#define BRCM_SWDSGN_RPC_IPCMASTERRECVMSG_PROC            (0xA008U) /**< @brief #RPC_IPCMasterRecvMsg            */
#define BRCM_SWDSGN_RPC_IPCMASTERPROCESSSTREAM_PROC      (0xA009U) /**< @brief #RPC_IPCMasterProcessStream      */
#define BRCM_SWDSGN_RPC_IPCMASTERDISCONNECT_PROC         (0xA00AU) /**< @brief #RPC_IPCMasterDisconnect         */
#define BRCM_SWDSGN_RPC_IPCMASTERCONTEXT_GLOBAL          (0xA00BU) /**< @brief #RPC_IPCMasterContext */
#define BRCM_SWDSGN_RPC_IPCMASTERGETMSGSIZE_PROC         (0xA00CU) /**< @brief #RPC_IPCMasterGetMsgSize         */
#define BRCM_SWDSGN_RPC_IPCMASTERPROCESS_PROC            (0xA00DU) /**< @brief #RPC_IPCMasterProcess            */
#define BRCM_SWDSGN_RPC_IPCMASTERDETECTSTREAM_PROC       (0xA00EU) /**< @brief #RPC_IPCMasterDetectStream       */
#define BRCM_SWDSGN_RPC_IPCMASTERPROCESSIMGHDRACK_PROC   (0xA00FU) /**< @brief #RPC_IPCMasterProcessImgHdrAck   */
#define BRCM_SWDSGN_RPC_IPCMASTERPROCESSIMGDATAACK_PROC  (0xA010U) /**< @brief #RPC_IPCMasterProcessImgDataAck  */
#define BRCM_SWDSGN_RPC_IPCMASTERCACHESTREAMREQUEST_PROC (0xA011U) /**< @brief #RPC_IPCMasterCacheStreamRequest */
#define BRCM_SWDSGN_RPC_IPCMASTERHANDLEASYNC_PROC        (0xA012U) /**< @brief #RPC_IPCMasterHandleAsync        */
#define BRCM_SWDSGN_RPC_IPCMASTERHANDLERESPONSE_PROC     (0xA013U) /**< @brief #RPC_IPCMasterHandleResponse     */
#define BRCM_SWDSGN_RPC_IPCMASTERSENDSTREAMDATA_PROC     (0xA014U) /**< @brief #RPC_IPCMasterSendStreamData     */
#define BRCM_SWDSGN_RPC_IPCMASTERCONTEXT_TYPE            (0xA015U) /**< @brief #RPC_IPCMasterContextType */
#define BRCM_SWDSGN_RPC_IPCMASTERSENDIMGH_PROC           (0xA016U) /**< @brief #RPC_IPCMasterSendIMGH    */
/** @} */

/**
    @name RPC IPC Stream State types

    @{
    @brief Various states of RPC IPC stream processing

    @trace #BRCM_SWARCH_RPC_IPCMASTERIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_IPC_MASTER
*/
typedef uint32_t RPC_IPCMasterStreamStateType;
#define RPC_IPCMASTERSTREAMSTATE_RESET            (BCM_STATE_SUB_STATE_RESET)  /**< @brief New stream request */
#define RPC_IPCMASTERSTREAMSTATE_PEND_ACK_IMGH_RX (BCM_STATE_SUB_STATE_STAGE0) /**< @brief Acknowledgement(IMG HDR) pending reception */
#define RPC_IPCMASTERSTREAMSTATE_READY            (BCM_STATE_SUB_STATE_STAGE1) /**< @brief Ready to receive stream data */
#define RPC_IPCMASTERSTREAMSTATE_PEND_ACK_DATA_RX (BCM_STATE_SUB_STATE_STAGE2) /**< @brief Acknowledgement(data) pending reception */
#define RPC_IPCMASTERSTREAMSTATE_COMPLETE         (BCM_STATE_SUB_STATE_DONE)   /**< @brief Stream processing complete */
/** @} */

/**
    @brief RPC IPC master Context type

    @trace #BRCM_SWARCH_RPC_IPCMASTERIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_IPC_MASTER
*/
typedef struct sRPC_IPCMasterContextType {
    RPC_StrmCfgType streamCfg;          /**< @brief Stream Configuration */
    RPC_InterfaceIdType selfId;         /**< @brief This Module Interface ID */
    RPC_InterfaceIdType peerId;         /**< @brief Connected Master ID */
    RPC_AssociationIndexType assocId;   /**< @brief This Interface Association ID */
    RPC_StreamVersionType strmVer;          /**< @brief Stream version */
    RPC_HdlType     selfStrmHdlV1;      /**< @brief Currently active stream handle for v1 stream */
    uint8_t rsv;                        /**< @brief Reserved */
} RPC_IPCMasterContextType;

/**
    @brief RPC IPC master Context

    @trace #BRCM_SWARCH_RPC_IPCMASTERIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_IPC_MASTER
*/

static RPC_IPCMasterContextType RPC_IPCMasterContext COMP_SECTION(".bss.rpc");

/** @brief RPC IPC Master Interface Initialization

    Function to initialize the IPC Master Interface

    @behavior Sync, Non-Reentrant

    @param[in]      void

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Init successful
    @retval     #BCM_ERR_UNKNOWN        Init Failed

    @trace #BRCM_SWARCH_RPC_IPCMASTERIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_IPC_MASTER

    @limitations None

    @code{.unparsed}
    retVal = RPC_IpcHostInit()
    if (BCM_ERR_OK == retVal)
        BCM_MemSet(&RPC_IPCMasterContext, 0U, sizeof(RPC_IPCMasterContext));
        retVal = RPC_GetModIfcAndAssoc(&RPC_IPCMasterIfc, &RPC_IPCMasterContext.selfId,
                                       &RPC_IPCMasterContext.peerId,
                                       &RPC_IPCMasterContext.assocId);
    return retVal
    @endcode
*/
static int32_t RPC_IPCMasterInit(void)
{
    int32_t retVal;

    retVal = RPC_IpcHostInit();
    if (BCM_ERR_OK == retVal) {
        BCM_MemSet(&RPC_IPCMasterContext, 0U, sizeof(RPC_IPCMasterContext));
        retVal = RPC_GetModIfcAndAssoc(&RPC_IPCMasterIfc, &RPC_IPCMasterContext.peerId,
                                       &RPC_IPCMasterContext.selfId,
                                       &RPC_IPCMasterContext.assocId);
    }

    return retVal;
}

/** @brief RPC IPC Master Interface connection status

    @behavior Sync, Non-Reentrant

    @param[in]      void

    @return     FALSE - Disconnected, TRUE - Connected

    @trace #BRCM_SWARCH_RPC_IPCMASTERIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_IPC_MASTER

    @limitations None

    @code{.unparsed}
    return TRUE
    @endcode
*/
static uint32_t RPC_IPCMasterIsConnected(void)
{
    return TRUE;
}

/** @brief RPC IPC Master Interface Connect

    This API will initiate connection to remote master.

    @behavior Sync, Non-Reentrant

    @param[in]      void

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Connection established
    @retval     #BCM_ERR_NOT_FOUND      No Connection established
    @retval     #BCM_ERR_UNKNOWN        Unknown failure

    @trace #BRCM_SWARCH_RPC_IPCMASTERIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_IPC_MASTER

    @limitations None

    @code{.unparsed}
    return BCM_ERR_OK
    @endcode
*/
static int32_t RPC_IPCMasterConnect(void)
{
    return BCM_ERR_OK;
}

/** @brief Get the event mask for the interface

    API to return the event mask for thee interface.

    @behavior Sync, Reentrant

    @pre None

    @param void

    @retval #uint32_t Event mask for the interface

    @post None

    @trace #BRCM_SWARCH_RPC_IPCMASTERIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_IPC_MASTER

    @code{.unparsed}
    return RPC_IPCMasterChann0Event
    @endcode
*/
static uint32_t RPC_IPCMasterGetEventMask(void)
{
    return 0UL;
}

/** @brief RPC IPC Master Interface Send message

    Interface Function to send response/async message

    @behavior Sync, Non-Reentrant

    @param[in]      aHdl                Message Handle to be sent

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Message sent successfully
    @retval     #BCM_ERR_NOMEM          Message not sent out due to lack of
                                        buffers. The operation should be retried
    @retval     #BCM_ERR_UNKNOWN        Unknown failure

    @trace #BRCM_SWARCH_RPC_IPCMASTERIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_IPC_MASTER

    @limitations None

    @code{.unparsed}
    msg = RPC_MsgGet(aHdl)
    retVal = RPC_MemPushAppInfo(aHdl, aHdl)
    if (BCM_ERR_OK == retVal)
        msg->magic = RPC_MEMMSG_MAGIC
        retVal = RPC_IpcHostSend(msg->cmd, (uint8_t*)msg, sizeof(RPC_MemMsgType))
        if ((BCM_ERR_OK != retVal) AND (BCM_ERR_NOMEM != retVal))
            retVal = BCM_ERR_UNKNOWN
    else
        retVal = BCM_ERR_UNKNOWN
    return retVal
    @endcode
*/
static int32_t RPC_IPCMasterSendMsg(RPC_HdlType aHdl)
{
    int32_t retVal;
    RPC_MemMsgType *msg;
    BCM_CmdType cmdVal;
    RPC_MemMsgType *srcMsg;

    msg = RPC_MsgScratch();
    srcMsg = RPC_MsgGet(aHdl);

    retVal = RPC_MemPushAppInfo(aHdl, aHdl);
    if (BCM_ERR_OK == retVal) {
        BCM_MemCpy(msg, srcMsg, sizeof(RPC_MemMsgType));

        msg->magic = CPU_NativeToLE32(msg->magic);
        msg->version = CPU_NativeToLE32(msg->version);
        cmdVal = msg->cmd;
        msg->cmd = CPU_NativeToLE32(msg->cmd);
        msg->response = CPU_NativeToLE32(msg->response);
        msg->len = CPU_NativeToLE32(msg->len);
        msg->appinfoTop = CPU_NativeToLE32(msg->appinfoTop);

        retVal = RPC_IpcHostSend(cmdVal, (uint8_t*)msg, sizeof(RPC_MemMsgType) - (RPC_MEM_MSG_PAYLOAD_SZ - srcMsg->len));
        if ((BCM_ERR_OK != retVal) && (BCM_ERR_NOMEM != retVal)) {
            uint32_t appInfo;
            RPC_MemPopAppInfo(aHdl, &appInfo);
            retVal = BCM_ERR_UNKNOWN;
        }
    } else {
        retVal = BCM_ERR_UNKNOWN;
    }
    return retVal;
}

/** @brief RPC IPC Master Interface Process Image Data Acknowledgement

    Interface function used to Process Image Data Acknowledgement

    @behavior Sync, Non-Reentrant

    @param[in]        aMsg          Message pointer
    @param[in]        aVer          Stream version type

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_EAGAIN     Acknowledgement processed successfully
    @retval     #BCM_ERR_UNKNOWN    Failed to retrieve client information

    @trace #BRCM_SWARCH_RPC_IPCMASTERIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_IPC_MASTER

    @limitations None

    @code{.unparsed}
    if (RPC_STREAM_VERSION_2 == aVer)
        aDwnldImg = (RPC_DwnldImageType *)aMsg
        response = aDwnldImg->response
        hostStrmHdl = aDwnldImg->hostStrmHdl
    else
        response = *(uint32_t *)aMsg
        hostStrmHdl = RPC_IPCMasterContext.selfStrmHdlV1
    retVal = RPC_StrmGetCfg(hostStrmHdl, &cfg)
    if ((BCM_ERR_OK != retVal) OR ((RPC_STREAM_VERSION_2 == aVer)
        AND ((RPC_IPC_STREAM_MAGIC != CPU_LEToNative32(aDwnldImg->magicNum))
            OR (cfg.pid != aDwnldImg->pid)
            OR (cfg.imgId != CPU_LEToNative16(aDwnldImg->imgID))
            OR (cfg.peerHdl != aDwnldImg->targetStrmHdl))))
        retVal = BCM_ERR_UNKNOWN
    else
        clientInfo = RPC_StrmGetMasterClientInfo(hostStrmHdl)
        if (NULL != clientInfo)
            if (BCM_ERR_OK == response)
                if (RPC_IPCMASTERSTREAMSTATE_PEND_ACK_DATA_RX == clientInfo->state)
                    clientInfo->state = RPC_IPCMASTERSTREAMSTATE_READY
                    retVal = BCM_ERR_EAGAIN
                else
                    retVal = BCM_ERR_UNKNOWN
            else
                clientInfo->state = RPC_IPCMASTERSTREAMSTATE_COMPLETE
                retVal = BCM_ERR_EAGAIN
        else
            retVal = BCM_ERR_UNKNOWN
    return retVal
    @endcode
*/
static int32_t RPC_IPCMasterProcessImgDataAck(RPC_MemMsgType *aMsg, RPC_StreamVersionType aVer)
{
    int32_t retVal;
    RPC_StrmCfgType cfg;
    RPC_MemStrmClientInfoType *clientInfo;
    uint32_t response;
    uint32_t hostStrmHdl;
    RPC_DwnldImageType *aDwnldImg;

    if (RPC_STREAM_VERSION_2 == aVer) {
        aDwnldImg = (RPC_DwnldImageType *)aMsg;
        response = aDwnldImg->response;
        hostStrmHdl = aDwnldImg->hostStrmHdl;
    } else {
        response = *(uint32_t *)aMsg;
        hostStrmHdl = RPC_IPCMasterContext.selfStrmHdlV1;
    }

    /* get stream cfg and validate parameters */
    retVal = RPC_StrmGetCfg(hostStrmHdl, &cfg);
    if ((BCM_ERR_OK != retVal) || ((RPC_STREAM_VERSION_2 == aVer)
        && ((RPC_IPC_STREAM_MAGIC != CPU_LEToNative32(aDwnldImg->magicNum))
            || (cfg.pid != aDwnldImg->pid)
            || (cfg.imgId != CPU_LEToNative16(aDwnldImg->imgID))
            || (cfg.peerHdl != aDwnldImg->targetStrmHdl)))) {
        /* drop the packet and let the caller call this API again to fetch new messages */
        retVal = BCM_ERR_UNKNOWN;
    } else {
        clientInfo = RPC_StrmGetMasterClientInfo(hostStrmHdl);
        if (NULL != clientInfo) {
            if (BCM_ERR_OK == response) {
                if (RPC_IPCMASTERSTREAMSTATE_PEND_ACK_DATA_RX == clientInfo->state) {
                    clientInfo->state = RPC_IPCMASTERSTREAMSTATE_READY;
                    retVal = BCM_ERR_EAGAIN;
                } else {
                    retVal = BCM_ERR_UNKNOWN;
                }
            } else {
                /* Error reported by peer, terminate stream */
                clientInfo->state = RPC_IPCMASTERSTREAMSTATE_COMPLETE;
                retVal = BCM_ERR_EAGAIN;
            }
        } else {
            /* client info is NULL */
            retVal = BCM_ERR_UNKNOWN;
        }
    }
    return retVal;
}

/** @brief RPC IPC Master Interface Process Image Header Acknowledgement

    Interface function used to Process Image Header Acknowledgement

    @behavior Sync, Non-Reentrant

    @param[in]        aMsg          Message pointer
    @param[in]        aVer          Stream version type

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_EAGAIN     Acknowledgement processed successfully
    @retval     #BCM_ERR_UNKNOWN    Failed to retrieve client information

    @trace #BRCM_SWARCH_RPC_IPCMASTERIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_IPC_MASTER

    @limitations None

    @code{.unparsed}
    if (RPC_STREAM_VERSION_2 == aVer)
        dwnldHdr = (RPC_DwnldHdrV2Type *)aMsg
        response = dwnldHdr->response
        hostStrmHdl = dwnldHdr->hostStrmHdl
    else
        response = *(uint32_t *)aMsg
        hostStrmHdl = RPC_IPCMasterContext.selfStrmHdlV1
    retVal = RPC_StrmGetCfg(hostStrmHdl, &cfg)
    if ((BCM_ERR_OK != retVal) OR ((RPC_STREAM_VERSION_2 == aVer)
        AND ((IMGL_IMGH_MAGIC !=  CPU_LEToNative32(dwnldHdr->magicNum))
            OR (cfg.pid != dwnldHdr->pid)
            OR (cfg.imgId != CPU_LEToNative16(dwnldHdr->imgID))
            OR (cfg.peerHdl != dwnldHdr->targetStrmHdl))))
        retVal = BCM_ERR_UNKNOWN
    else
        clientInfo = RPC_StrmGetMasterClientInfo(hostStrmHdl)
        if (NULL != clientInfo)
            if (BCM_ERR_OK == CPU_LEToNative32(response))
                if (RPC_IPCMASTERSTREAMSTATE_PEND_ACK_IMGH_RX == clientInfo->state)
                    clientInfo->state = RPC_IPCMASTERSTREAMSTATE_READY
                    retVal = BCM_ERR_EAGAIN
                else
                    retVal = BCM_ERR_UNKNOWN
            else
                clientInfo->state = RPC_IPCMASTERSTREAMSTATE_COMPLETE
                retVal = BCM_ERR_EAGAIN
        else
            retVal = BCM_ERR_UNKNOWN
    return retVal
    @endcode
*/
static int32_t RPC_IPCMasterProcessImgHdrAck(RPC_MemMsgType *aMsg, RPC_StreamVersionType aVer)
{
    int32_t retVal;
    RPC_StrmCfgType cfg;
    RPC_MemStrmClientInfoType *clientInfo;
    uint32_t response;
    uint32_t hostStrmHdl;
    RPC_DwnldHdrV2Type *dwnldHdr;

    if (RPC_STREAM_VERSION_2 == aVer) {
        dwnldHdr = (RPC_DwnldHdrV2Type *)aMsg;
        response = dwnldHdr->response;
        hostStrmHdl = dwnldHdr->hostStrmHdl;
    } else {
        response = *(uint32_t *)aMsg;
        hostStrmHdl = RPC_IPCMasterContext.selfStrmHdlV1;
    }

    /* get stream cfg and validate parameters */
    retVal = RPC_StrmGetCfg(hostStrmHdl, &cfg);

    if ((BCM_ERR_OK != retVal) || ((RPC_STREAM_VERSION_2 == aVer)
        && ((IMGL_IMGH_MAGIC !=  CPU_LEToNative32(dwnldHdr->magicNum))
            || (cfg.pid != dwnldHdr->pid)
            || (cfg.imgId != CPU_LEToNative16(dwnldHdr->imgID))
            || (cfg.peerHdl != dwnldHdr->targetStrmHdl)))) {
        /* drop the packet and let the caller call this API again to fetch new messages */
        retVal = BCM_ERR_UNKNOWN;
    } else {
        clientInfo = RPC_StrmGetMasterClientInfo(hostStrmHdl);
        if (NULL != clientInfo) {
            if (BCM_ERR_OK == CPU_LEToNative32(response)) {
                if (RPC_IPCMASTERSTREAMSTATE_PEND_ACK_IMGH_RX == clientInfo->state) {
                    clientInfo->state = RPC_IPCMASTERSTREAMSTATE_READY;
                    retVal = BCM_ERR_EAGAIN;
                } else {
                    retVal = BCM_ERR_UNKNOWN;
                }
            } else {
                /* Error reported by peer, terminate stream */
                clientInfo->state = RPC_IPCMASTERSTREAMSTATE_COMPLETE;
                retVal = BCM_ERR_EAGAIN;
            }
        } else {
            /* clientInfo is NULL */
            retVal = BCM_ERR_UNKNOWN;
        }
    }
    return retVal;
}

/** @brief RPC IPC Master Interface Cache stream request

    Interface function used to Cache stream request information

    @behavior Sync, Non-Reentrant

    @param[in]        aMsg            Message pointer
    @param[in]        aVer            Stream version

    @return void

    @trace #BRCM_SWARCH_RPC_IPCMASTERIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_IPC_MASTER

    @limitations None

    @code{.unparsed}
    if (RPC_STREAM_VERSION_2 == aVer)
        RPC_ImgReqV2Type *req = (RPC_ImgReqV2Type *)aMsg
        RPC_IPCMasterContext.streamCfg.pid = req->pid
        RPC_IPCMasterContext.streamCfg.imgId = CPU_LEToNative16(req->imgID)
        RPC_IPCMasterContext.streamCfg.offset = CPU_LEToNative32(req->offset)
        RPC_IPCMasterContext.streamCfg.isTbl = req->isTbl
        RPC_IPCMasterContext.streamCfg.xferSize = CPU_LEToNative32(req->imgMaxSize)
        RPC_IPCMasterContext.streamCfg.blkSize = CPU_LEToNative32(RPC_STREAMDATA_PAYLOAD_SIZE)
        RPC_IPCMasterContext.streamCfg.isRead = CPU_LEToNative32(TRUE)
        RPC_IPCMasterContext.streamCfg.peerHdl = req->targetStrmHdl
    else
        if (RPC_STREAM_VERSION_INVALID == RPC_IPCMasterContext.strmVer)
            RPC_ImgPartReqV1Type *req = (RPC_ImgPartReqV1Type *)aMsg

            if (BCM_ASYNCID(BCM_GROUPID_IMGL, BCM_RSV_ID, RPC_CMDIDVAL_IMAGE_PART_FETCH_V1) == aCmdVal)
                offset = CPU_LEToNative32(req->offset)
            else
                offset = 0UL
            RPC_IPCMasterContext.streamCfg.pid = req->pid
            RPC_IPCMasterContext.streamCfg.imgId = CPU_LEToNative16(req->imgID)
            RPC_IPCMasterContext.streamCfg.offset = offset
            RPC_IPCMasterContext.streamCfg.isTbl = req->isImgHdr
            RPC_IPCMasterContext.streamCfg.xferSize = CPU_LEToNative32(req->imgMaxSize)
            RPC_IPCMasterContext.streamCfg.blkSize = CPU_LEToNative32(RPC_STREAMDATA_PAYLOAD_SIZE)
            RPC_IPCMasterContext.streamCfg.isRead = CPU_LEToNative32(TRUE)
            RPC_IPCMasterContext.streamCfg.peerHdl = RPC_HDL_INVALID
    RPC_IPCMasterContext.strmVer = aVer
    @endcode
*/
static void RPC_IPCMasterCacheStreamRequest(RPC_MemMsgType *aMsg, RPC_StreamVersionType aVer, BCM_CmdType aCmdVal)
{
    if (RPC_STREAM_VERSION_2 == aVer) {
        RPC_ImgReqV2Type *req = (RPC_ImgReqV2Type *)aMsg;
        printf("\npid = %x imgid=%x offset=%x istbl = %x\n",
                req->pid, CPU_LEToNative16(req->imgID),
                CPU_LEToNative32(req->offset), req->isTbl);
        RPC_IPCMasterContext.streamCfg.pid = req->pid;
        RPC_IPCMasterContext.streamCfg.imgId = CPU_LEToNative16(req->imgID);
        RPC_IPCMasterContext.streamCfg.offset = CPU_LEToNative32(req->offset);
        RPC_IPCMasterContext.streamCfg.isTbl = req->isTbl;
        RPC_IPCMasterContext.streamCfg.xferSize = CPU_LEToNative32(req->imgMaxSize);
        RPC_IPCMasterContext.streamCfg.blkSize = CPU_LEToNative32(RPC_STREAMDATA_PAYLOAD_SIZE);
        RPC_IPCMasterContext.streamCfg.isRead = CPU_LEToNative32(TRUE);
        RPC_IPCMasterContext.streamCfg.peerHdl = req->targetStrmHdl;
    } else {
        /* legacy stream request */
        if (RPC_STREAM_VERSION_INVALID == RPC_IPCMasterContext.strmVer) {
            RPC_ImgPartReqV1Type *req = (RPC_ImgPartReqV1Type *)aMsg;
            uint32_t offset;

            if (BCM_ASYNCID(BCM_GROUPID_IMGL, BCM_RSV_ID, RPC_CMDIDVAL_IMAGE_PART_FETCH_V1) == aCmdVal) {
                offset = CPU_LEToNative32(req->offset);
            } else {
                offset = 0UL;
            }

            printf("\nv1 pid = %x imgid=%x offset=%x istbl = %x\n",
                    req->pid, CPU_LEToNative16(req->imgID),
                    CPU_LEToNative32(offset), req->isImgHdr);

            RPC_IPCMasterContext.streamCfg.pid = req->pid;
            RPC_IPCMasterContext.streamCfg.imgId = CPU_LEToNative16(req->imgID);
            RPC_IPCMasterContext.streamCfg.offset = CPU_LEToNative32(offset);
            RPC_IPCMasterContext.streamCfg.isTbl = req->isImgHdr;
            RPC_IPCMasterContext.streamCfg.xferSize = CPU_LEToNative32(req->imgMaxSize);
            RPC_IPCMasterContext.streamCfg.blkSize = CPU_LEToNative32(RPC_STREAMDATA_PAYLOAD_SIZE);
            RPC_IPCMasterContext.streamCfg.isRead = CPU_LEToNative32(TRUE);
            RPC_IPCMasterContext.streamCfg.peerHdl = RPC_HDL_INVALID;
        } /* else, one in pipeline, ignore the new request*/
    }
    RPC_IPCMasterContext.strmVer = aVer;
}

/** @brief RPC IPC Master Interface Handle Asynchronous message

    Interface function used to receive Asynchronous message.

    @behavior Sync, Non-Reentrant

    @param[in]        aInMsg            Incoming Asynchronous message pointer
    @param[out]     aHdl            Handle to received message

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK         Message received successfully and copied
    @retval     #BCM_ERR_UNKNOWN    Message allocation failed

    @trace #BRCM_SWARCH_RPC_IPCMASTERIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_IPC_MASTER

    @limitations None

    @code{.unparsed}
    retVal = RPC_MsgAlloc(RPC_HDL_INVALID, RPC_IPCMasterContext.peerId,
                          RPC_IPCMasterContext.selfId,
                          RPC_IPCMasterContext.assocId, aHdl)
    if (BCM_ERR_OK == retVal)
        allocMsg = RPC_MsgGet(*aHdl)
        if (NULL != allocMsg)
            BCM_MemCpy(allocMsg, aInMsg, sizeof(RPC_MemMsgType))
        else
            (void)RPC_Release(*aHdl)
            *aHdl = RPC_HDL_INVALID
            retVal = BCM_ERR_UNKNOWN
    else
        retVal = BCM_ERR_UNKNOWN
    return retVal
    @endcode
*/
static int32_t RPC_IPCMasterHandleAsync(RPC_MemMsgType *aInMsg, RPC_HdlType* const aHdl)
{
    int32_t retVal;
    RPC_MemMsgType *allocMsg;

    retVal = RPC_MsgAlloc(RPC_HDL_INVALID, RPC_IPCMasterContext.peerId,
                          RPC_IPCMasterContext.selfId,
                          RPC_IPCMasterContext.assocId, aHdl);
    if (BCM_ERR_OK == retVal) {
        allocMsg = RPC_MsgGet(*aHdl);
        if (NULL != allocMsg) {
            BCM_MemCpy(allocMsg, aInMsg, sizeof(RPC_MemMsgType));
            allocMsg->cmd = CPU_LEToNative32(allocMsg->cmd);
            allocMsg->len = CPU_LEToNative32(allocMsg->len);
            retVal = RPC_MemPushAppInfo(*aHdl, *aHdl);
            /* retVal would already be BCM_ERR_OK and
               aHdl would point to new handle meant for async message */
        } else {
            (void)RPC_Release(*aHdl);
            *aHdl = RPC_HDL_INVALID;
            retVal = BCM_ERR_UNKNOWN;
        }
    } else {
        retVal = BCM_ERR_UNKNOWN;
    }
    return retVal;
}

/** @brief RPC IPC Master Interface Handle Response

    Interface function used to receive response message.

    @behavior Sync, Non-Reentrant

    @param[in]        aInMsg            Incoming response message pointer
    @param[out]     aHdl            Handle to received message

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK         Message received successfully and copied
    @retval     #BCM_ERR_UNKNOWN    AppInfo not found OR Invalid AppInfo

    @trace #BRCM_SWARCH_RPC_IPCMASTERIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_IPC_MASTER

    @limitations None

    @code{.unparsed}
    retVal = RPC_MemPeekAppInfo(aInMsg, aHdl)
    if (BCM_ERR_OK == retVal)
        retVal = RPC_MemPopAppInfo(*aHdl, aHdl)
        if (BCM_ERR_OK == retVal)
            cmdMsg = RPC_MsgGet(*aHdl)
            if (NULL != cmdMsg)
                BCM_MemCpy(cmdMsg, aInMsg, sizeof(RPC_MemMsgType))
            else
                retVal = BCM_ERR_UNKNOWN
    if (BCM_ERR_OK != retVal)
        *aHdl = RPC_HDL_INVALID
        retVal = BCM_ERR_UNKNOWN
    return retVal
    @endcode
*/
static int32_t RPC_IPCMasterHandleResponse(RPC_MemMsgType *aInMsg, RPC_HdlType* const aHdl)
{
    int32_t retVal;
    RPC_MemMsgType *cmdMsg;

    retVal = RPC_MemPeekAppInfo(aInMsg, aHdl);
    if (BCM_ERR_OK == retVal) {
        cmdMsg = RPC_MsgGet(*aHdl);
        if (NULL != cmdMsg) {
            BCM_MemCpy(cmdMsg, aInMsg, sizeof(RPC_MemMsgType));
            retVal = RPC_MemPopAppInfo(*aHdl, aHdl);
            if (BCM_ERR_OK != retVal) {
                retVal = BCM_ERR_UNKNOWN;
            }
            /* retVal would already be BCM_ERR_OK and
               aHdl would point to cmd handle */
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

/** @brief RPC IPC Master Interface Receive Message

    Interface function used to receive command message.
    Client to invoke this API until #BCM_ERR_NOT_FOUND is got

    @behavior Sync, Non-Reentrant

    @param[out]     aHdl            Handle to received message

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK         Message received successfully and copied
    @retval     #BCM_ERR_EAGAIN     Message being processed, client to
                                    invoke this API again
    @retval     #BCM_ERR_NOT_FOUND  No Message received
    @retval     #BCM_ERR_UNKNOWN    Unknown failure

    @trace #BRCM_SWARCH_RPC_IPCMASTERIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_IPC_MASTER

    @limitations None

    @code{.unparsed}
    if (RPC_STREAM_VERSION_2 == RPC_IPCMasterContext.strmVer)
        retVal = BCM_ERR_EAGAIN
    else
        retVal = RPC_MsgAlloc(RPC_HDL_INVALID, RPC_IPCMasterContext.peerId,
                              RPC_IPCMasterContext.selfId,
                              RPC_IPCMasterContext.assocId, aHdl)
        if (BCM_ERR_OK == retVal)
            (void)RPC_Release(*aHdl)
            msg = RPC_MsgScratch()
            if (NULL == msg)
                retVal = BCM_ERR_UNKNOWN
            else
                *aHdl = RPC_HDL_INVALID
        else
            if(BCM_ERR_NOMEM == retVal)
                retVal = BCM_ERR_NOT_FOUND
            else
                retVal = BCM_ERR_EAGAIN
    if (BCM_ERR_OK == retVal)
        retVal = RPC_IpcHostRecv(&cmdVal, (uint8_t*)msg, sizeof(RPC_MemMsgType), &packetLen)
        if (BCM_ERR_NOT_FOUND == retVal)
        else if (BCM_ERR_OK != retVal)
            retVal = BCM_ERR_UNKNOWN
        else
            if ((BCM_ASYNCID(BCM_GROUPID_IMGL, BCM_RSV_ID, RPC_CMDIDVAL_IMAGE_FETCH_V2) == cmdVal)
                || (BCM_ASYNCID(BCM_GROUPID_IMGL, BCM_RSV_ID, RPC_CMDIDVAL_IMAGE_PART_FETCH_V2) == cmdVal))
                retVal = BCM_ERR_EAGAIN
                RPC_IPCMasterCacheStreamRequest(msg, RPC_STREAM_VERSION_2, 0UL)
            else if (BCM_CMDID(BCM_GROUPID_IMGL, BCM_RSV_ID, RPC_CMDIDVAL_DWNLD_IMG_HDR_V2) == cmdVal)
                retVal = RPC_IPCMasterProcessImgHdrAck(msg, RPC_STREAM_VERSION_2)
            else if (BCM_CMDID(BCM_GROUPID_IMGL, BCM_RSV_ID, RPC_CMDIDVAL_DWNLD_IMG_V2) == cmdVal)
                retVal = RPC_IPCMasterProcessImgDataAck(msg, RPC_STREAM_VERSION_2)
            else if ((BCM_ASYNCID(BCM_GROUPID_IMGL, BCM_RSV_ID, RPC_CMDIDVAL_IMAGE_FETCH_V1) == cmdVal)
                || (BCM_ASYNCID(BCM_GROUPID_IMGL, BCM_RSV_ID, RPC_CMDIDVAL_IMAGE_PART_FETCH_V1) == cmdVal))
                retVal = BCM_ERR_EAGAIN
                RPC_IPCMasterCacheStreamRequest(msg, RPC_STREAM_VERSION_1, cmdVal)
            else if (BCM_CMDID(BCM_GROUPID_IMGL, BCM_RSV_ID, RPC_CMDIDVAL_DWNLD_IMG_HDR_V1) == cmdVal)
                retVal = RPC_IPCMasterProcessImgHdrAck(msg, RPC_STREAM_VERSION_1)
            else if (BCM_CMDID(BCM_GROUPID_IMGL, BCM_RSV_ID, RPC_CMDIDVAL_DWNLD_IMG_V1) == cmdVal)
                retVal = RPC_IPCMasterProcessImgDataAck(msg, RPC_STREAM_VERSION_1)
            else if (0UL != (cmdVal & BCM_CMD_ASYNC_MASK))
                retVal = RPC_IPCMasterHandleAsync(msg, aHdl)
            else
                msg->appinfoTop = CPU_LEToNative32(msg->appinfoTop)
                msg->magic = CPU_LEToNative32(msg->magic)
                msg->version = CPU_LEToNative32(msg->version)
                msg->cmd = CPU_LEToNative32(msg->cmd)
                msg->len = CPU_LEToNative32(msg->len)
                msg->response = CPU_LEToNative32(msg->response)
                retVal = RPC_IPCMasterHandleResponse(msg, aHdl)
    return retVal
    @endcode
*/
static int32_t RPC_IPCMasterRecvMsg(RPC_HdlType* const aHdl)
{
    BCM_CmdType cmdVal = 0UL;
    uint32_t packetLen = sizeof(RPC_MemMsgType);
    RPC_MemMsgType *msg = NULL;
    int32_t retVal;

    if (RPC_STREAM_VERSION_2 == RPC_IPCMasterContext.strmVer) {
        /* Pending stream request, don't process anything until it is accepted-
            it is acceptable to let messages pending with IPC driver */
        retVal = BCM_ERR_EAGAIN;
    } else {
        /* Async message requires a handle allocation, so test if allocation would succeed */
        retVal = RPC_MsgAlloc(RPC_HDL_INVALID, RPC_IPCMasterContext.peerId,
                              RPC_IPCMasterContext.selfId,
                              RPC_IPCMasterContext.assocId, aHdl);
        if (BCM_ERR_OK == retVal) {
            (void)RPC_Release(*aHdl);
            msg = RPC_MsgScratch();
            if (NULL == msg) {
                retVal = BCM_ERR_UNKNOWN;
            } else {
                *aHdl = RPC_HDL_INVALID;
            }
        } else {
            if(BCM_ERR_NOMEM == retVal) {
                /* rpc_module can stop requesting to receive message */
                retVal = BCM_ERR_NOT_FOUND;
            } else {
                retVal = BCM_ERR_EAGAIN;
            }
        }
    }

    if (BCM_ERR_OK == retVal) {
        retVal = RPC_IpcHostRecv(&cmdVal, (uint8_t*)msg, sizeof(RPC_MemMsgType), &packetLen);
        if (BCM_ERR_NOT_FOUND == retVal) {
            /* Nothing - return same error */
        } else if (BCM_ERR_OK != retVal) {
            /* Handle failure reported by IPC driver */
            retVal = BCM_ERR_UNKNOWN;
        } else {
            if ((BCM_ASYNCID(BCM_GROUPID_IMGL, BCM_RSV_ID, RPC_CMDIDVAL_IMAGE_FETCH_V2) == cmdVal)
                || (BCM_ASYNCID(BCM_GROUPID_IMGL, BCM_RSV_ID, RPC_CMDIDVAL_IMAGE_PART_FETCH_V2) == cmdVal)) {
                /* Image fetch request v2 */
                retVal = BCM_ERR_EAGAIN;
                RPC_IPCMasterCacheStreamRequest(msg, RPC_STREAM_VERSION_2, 0UL);
            } else if (BCM_CMDID(BCM_GROUPID_IMGL, BCM_RSV_ID, RPC_CMDIDVAL_DWNLD_IMG_HDR_V2) == cmdVal) {
                /* Img Hdr Ack v2 */
                retVal = RPC_IPCMasterProcessImgHdrAck(msg, RPC_STREAM_VERSION_2);
            } else if (BCM_CMDID(BCM_GROUPID_IMGL, BCM_RSV_ID, RPC_CMDIDVAL_DWNLD_IMG_V2) == cmdVal) {
                /* Img Data Ack v2 */
                retVal = RPC_IPCMasterProcessImgDataAck(msg, RPC_STREAM_VERSION_2);
            } else if ((BCM_ASYNCID(BCM_GROUPID_IMGL, BCM_RSV_ID, RPC_CMDIDVAL_IMAGE_FETCH_V1) == cmdVal)
                || (BCM_ASYNCID(BCM_GROUPID_IMGL, BCM_RSV_ID, RPC_CMDIDVAL_IMAGE_PART_FETCH_V1) == cmdVal)) {
                /* Image fetch request v1 */
                retVal = BCM_ERR_EAGAIN;
                RPC_IPCMasterCacheStreamRequest(msg, RPC_STREAM_VERSION_1, cmdVal);
            } else if (BCM_CMDID(BCM_GROUPID_IMGL, BCM_RSV_ID, RPC_CMDIDVAL_DWNLD_IMG_HDR_V1) == cmdVal) {
                /* Img Hdr Ack v1 */
                retVal = RPC_IPCMasterProcessImgHdrAck(msg, RPC_STREAM_VERSION_1);
            } else if (BCM_CMDID(BCM_GROUPID_IMGL, BCM_RSV_ID, RPC_CMDIDVAL_DWNLD_IMG_V1) == cmdVal) {
                /* Img Data Ack v1 */
                retVal = RPC_IPCMasterProcessImgDataAck(msg, RPC_STREAM_VERSION_1);
            } else if (0UL != (cmdVal & BCM_CMD_ASYNC_MASK)) {
                /* Async msg */
                retVal = RPC_IPCMasterHandleAsync(msg, aHdl);
            } else {
                /* response msg */
                msg->appinfoTop = CPU_LEToNative32(msg->appinfoTop);
                msg->magic = CPU_LEToNative32(msg->magic);
                msg->version = CPU_LEToNative32(msg->version);
                msg->cmd = CPU_LEToNative32(msg->cmd);
                msg->len = CPU_LEToNative32(msg->len);
                msg->response = CPU_LEToNative32(msg->response);
                retVal = RPC_IPCMasterHandleResponse(msg, aHdl);
                if (cmdVal ==  DMON_ID_REBOOT) {
                    sleep(1);
                }
            }
        }
    }
    return retVal;
}

/** @brief RPC IPC Master Send Stream Data

    This API will attempt to send stream data over HIPC

    @behavior Sync, Non-Reentrant

    @param[in]      aHdl        Stream Handle to be processed
    @param[in]      aClientInfo Client information specific to stream
    @param[in]      aStrmCfg    Stream configuration

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Data processed successfully, stream completed
    @retval     #BCM_ERR_BUSY           Data processed successfully, more data expected
    @retval     #BCM_ERR_UNKNOWN        Unknown failure

    @trace #BRCM_SWARCH_RPC_IPCMASTERIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_IPC_MASTER

    @code{.unparsed}
    currOffset = 0UL

    if (RPC_HDL_INVALID == aClientInfo->pendingMsgHdl)
        retVal = RPC_MsgAlloc(RPC_HDL_INVALID, RPC_IPCMasterContext.peerId,
                              RPC_IPCMasterContext.selfId,
                              RPC_IPCMasterContext.assocId, &allocMsgHdl)
        if (BCM_ERR_OK == retVal)
            allocMsg = RPC_MsgGet(allocMsgHdl)
            if (NULL != allocMsg)
                dlImg = (RPC_DwnldImageType *)allocMsg
                retVal = RPC_StrmGetFilledSz(aHdl, &rdSize, &currOffset)
                if (BCM_ERR_OK == retVal)
                    if (currOffset == aStrmCfg->xferSize)
                        aClientInfo->state = RPC_IPCMASTERSTREAMSTATE_COMPLETE
                        retVal = BCM_ERR_BUSY
                    else
                        if (rdSize > RPC_STREAMDATA_PAYLOAD_SIZE)
                            rdSize = RPC_STREAMDATA_PAYLOAD_SIZE
                        if (RPC_STREAM_VERSION_2 == aClientInfo->strmVer)
                            payloadPtr = &dlImg->imgData[0]
                        else
                            payloadPtr = (uint8_t *)allocMsg
                        retVal = RPC_StrmRead(aHdl, payloadPtr, rdSize, &outSize)
                        if ((BCM_ERR_INVAL_STATE == retVal) OR (BCM_ERR_INVAL_PARAMS == retVal))
                            retVal = BCM_ERR_UNKNOWN
                        else
                            if (RPC_STREAM_VERSION_2 == aClientInfo->strmVer)
                                dlImg->magicNum = RPC_IPC_STREAM_MAGIC
                                dlImg->pid = aStrmCfg->pid
                                dlImg->imgID = aStrmCfg->imgId
                                dlImg->offset = currOffset
                                dlImg->targetStrmHdl = aStrmCfg->peerHdl
                                dlImg->hostStrmHdl = aHdl
                                dlImg->len = outSize

                            aClientInfo->pendingMsgHdl = aHdl
                else
                    retVal = BCM_ERR_UNKNOWN
            else
                (void)RPC_Release(allocMsgHdl)
                retVal = BCM_ERR_UNKNOWN
        else
            retVal = BCM_ERR_BUSY

    if (RPC_HDL_INVALID != aClientInfo->pendingMsgHdl)
        allocMsg = RPC_MsgGet(aClientInfo->pendingMsgHdl)
        if (NULL != allocMsg)
            if (RPC_STREAM_VERSION_2 == aClientInfo->strmVer)
                txSize = sizeof(RPC_DwnldImageType)
                cmd = RPC_CMDIDVAL_DWNLD_IMG_V2
            else
                rdSize = 0UL
                currOffset = 0UL
                (void)RPC_StrmGetFilledSz(aHdl, &rdSize, &currOffset)
                if (currOffset == aStrmCfg->xferSize)
                    txSize = aStrmCfg->xferSize % RPC_STREAMDATA_PAYLOAD_SIZE
                    if (0UL == txSize)
                        txSize = RPC_STREAMDATA_PAYLOAD_SIZE
                else
                    txSize = RPC_STREAMDATA_PAYLOAD_SIZE
                cmd = RPC_CMDIDVAL_DWNLD_IMG_V1
            retVal = RPC_IpcHostSend(cmd, (uint8_t *)allocMsg, txSize)
            if (BCM_ERR_OK == retVal)
                aClientInfo->pendingMsgHdl = RPC_HDL_INVALID
                aClientInfo->state = RPC_IPCMASTERSTREAMSTATE_PEND_ACK_DATA_RX
            retVal = BCM_ERR_BUSY
        else
            retVal = BCM_ERR_UNKNOWN

    return retVal
    @endcode
*/
static int32_t RPC_IPCMasterSendStreamData(RPC_HdlType aHdl,
                                           RPC_MemStrmClientInfoType *aClientInfo,
                                           RPC_StrmCfgType *aStrmCfg)
{
    int32_t retVal;
    uint32_t rdSize;
    uint32_t outSize = 0UL;
    RPC_DwnldImageType *dlImg;
    RPC_HdlType allocMsgHdl;
    RPC_MemMsgType *allocMsg;
    uint32_t currOffset = 0UL;
    uint8_t *payloadPtr;
    uint32_t txSize;
    uint32_t cmd;

    if (RPC_HDL_INVALID == aClientInfo->pendingMsgHdl) {
        /* No pending stream data transfer, fetch from server and send via HIPC */
        retVal = RPC_MsgAlloc(RPC_HDL_INVALID, RPC_IPCMasterContext.peerId,
                              RPC_IPCMasterContext.selfId,
                              RPC_IPCMasterContext.assocId, &allocMsgHdl);
        if (BCM_ERR_OK == retVal) {
            allocMsg = RPC_MsgGet(allocMsgHdl);
            if (NULL != allocMsg) {
                dlImg = (RPC_DwnldImageType *)allocMsg;
                /* Get available size */
                retVal = RPC_StrmGetFilledSz(aHdl, &rdSize, &currOffset);
                if (BCM_ERR_OK == retVal) {
                    if (currOffset == aStrmCfg->xferSize) {
                        (void)RPC_Release(allocMsgHdl);
                        aClientInfo->state = RPC_IPCMASTERSTREAMSTATE_COMPLETE;
                        aClientInfo->pendingMsgHdl = RPC_HDL_INVALID;
                        /* Transfer complete, Stream can be released */
                        retVal = BCM_ERR_OK;
                    } else if (0UL < rdSize) {
                        if (rdSize > RPC_STREAMDATA_PAYLOAD_SIZE) {
                            rdSize = RPC_STREAMDATA_PAYLOAD_SIZE;
                        }

                        if (RPC_STREAM_VERSION_2 == aClientInfo->strmVer) {
                            payloadPtr = &dlImg->imgData[0];
                        } else {
                            payloadPtr = (uint8_t *)allocMsg;
                        }

                        /* Get stream data */
                        retVal = RPC_StrmRead(aHdl, payloadPtr, rdSize, &outSize);
                        if (((BCM_ERR_INVAL_STATE == retVal) || (BCM_ERR_INVAL_PARAMS == retVal))
                              &&((BCM_ERR_INVAL_PARAMS == retVal) && (0UL != rdSize))) {
                            retVal = BCM_ERR_UNKNOWN;
                        } else {
                            if (RPC_STREAM_VERSION_2 == aClientInfo->strmVer) {
                                dlImg->magicNum = CPU_NativeToLE32(RPC_IPC_STREAM_MAGIC);
                                dlImg->pid = aStrmCfg->pid;
                                dlImg->imgID = CPU_NativeToLE16(aStrmCfg->imgId);
                                dlImg->offset = CPU_NativeToLE32(aStrmCfg->offset+currOffset);
                                dlImg->targetStrmHdl = aStrmCfg->peerHdl;
                                dlImg->hostStrmHdl = aHdl;
                                dlImg->len = CPU_NativeToLE32(outSize);
                            }
                            aClientInfo->pendingMsgHdl = allocMsgHdl;
                            if(5U > aStrmCfg->pid) {
                                printf("\r%03u%%", (((currOffset)*100)/aStrmCfg->xferSize));
                            }
                            fflush(stdout);
                        }
                    } else {
                        (void)RPC_Release(allocMsgHdl);
                        aClientInfo->pendingMsgHdl = RPC_HDL_INVALID;
                        retVal = BCM_ERR_BUSY;
                    }
                } else {
                    retVal = BCM_ERR_UNKNOWN;
                }
            } else {
                /* couldn't get message pointer- strange but release and report */
                (void)RPC_Release(allocMsgHdl);
                retVal = BCM_ERR_UNKNOWN;
            }
        } else {
            /* couldn't allocate message */
            retVal = BCM_ERR_BUSY;
        }
    }

    if (RPC_HDL_INVALID != aClientInfo->pendingMsgHdl) {
        /* Attempt to send pending stream data */
        allocMsg = RPC_MsgGet(aClientInfo->pendingMsgHdl);
        if (NULL != allocMsg) {
            if (RPC_STREAM_VERSION_2 == aClientInfo->strmVer) {
                txSize = sizeof(RPC_DwnldImageType);
                cmd = RPC_CMDIDVAL_DWNLD_IMG_V2;
            } else {
                rdSize = 0UL;
                currOffset = 0UL;
                (void)RPC_StrmGetFilledSz(aHdl, &rdSize, &currOffset);
                if (currOffset == aStrmCfg->xferSize) {
                    /* Last packet */
                    txSize = aStrmCfg->xferSize % RPC_STREAMDATA_PAYLOAD_SIZE;
                    if (0UL == txSize) {
                        /* size aligned to RPC_STREAMDATA_PAYLOAD_SIZE */
                        txSize = RPC_STREAMDATA_PAYLOAD_SIZE;
                    }
                } else {
                    txSize = RPC_STREAMDATA_PAYLOAD_SIZE;
                }
                cmd = RPC_CMDIDVAL_DWNLD_IMG_V1;
            }
            retVal = RPC_IpcHostSend(cmd, (uint8_t *)allocMsg, txSize);
            if (BCM_ERR_OK == retVal) {
               (void)RPC_Release(aClientInfo->pendingMsgHdl);
                aClientInfo->pendingMsgHdl = RPC_HDL_INVALID;
                aClientInfo->state = RPC_IPCMASTERSTREAMSTATE_PEND_ACK_DATA_RX;
            }
            retVal = BCM_ERR_BUSY;
        } else {
            retVal = BCM_ERR_UNKNOWN;
        }
    }

    return retVal;
}

/** @brief RPC IPC Master Send Image Header

    This API will attempt to send image header over HIPC

    @behavior Sync, Non-Reentrant

    @param[in]      aStrmCfg    Stream configuration
    @param[in]      aHdl        Stream Handle to be processed
    @param[in]      aClientInfo Client information specific to stream

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             IMGH sent successfully
    @return     #BCM_ERR_NOSUPPORT      IPC message's length is not supported
    @return     #BCM_ERR_UNINIT         IPC mechanism is not yet initialised
    @return     #BCM_ERR_NODEV          Target is undergoing a reboot
    @return     #BCM_ERR_BUSY           Target is not ready to accept anymore messages
    @return     #BCM_ERR_NOMEM          All available IPC buffers are used-up

    @trace #BRCM_SWARCH_RPC_IPCMASTERIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_IPC_MASTER

    @code{.unparsed}
    if (RPC_STREAM_VERSION_2 == aClientInfo->strmVer) {
        RPC_DwnldHdrV2Type dlHdr = {
            .magicNum = CPU_NativeToLE32(IMGL_IMGH_MAGIC),
            .pid = aStrmCfg->pid,
            .imgID = CPU_NativeToLE16(aStrmCfg->imgId),
            .imgSize = CPU_NativeToLE32(aStrmCfg->xferSize),
            .targetStrmHdl = aStrmCfg->peerHdl,
            .hostStrmHdl = aHdl,
            .response = CPU_NativeToLE32(BCM_ERR_OK),
        }
        retVal = RPC_IpcHostSend(RPC_CMDIDVAL_DWNLD_IMG_HDR_V2, (uint8_t *)&dlHdr, sizeof(dlHdr))
    else
        RPC_DwnldHdrV1Type dlHdr = {
            .magicNum = CPU_NativeToLE32(IMGL_IMGH_MAGIC),
            .imgSize = CPU_NativeToLE32(aStrmCfg->xferSize),
            .flags = 0UL,
            .errDetCode = 0ULL,
        }
        retVal = RPC_IpcHostSend(RPC_CMDIDVAL_DWNLD_IMG_HDR_V1, (uint8_t *)&dlHdr, sizeof(dlHdr))
    return retVal
    @endcode
*/
static int32_t RPC_IPCMasterSendIMGH(RPC_StrmCfgType *aStrmCfg,
                                     RPC_HdlType aHdl,
                                     RPC_MemStrmClientInfoType *aClientInfo)
{
    int32_t retVal;

    /* compose IMGH and send */
    if (RPC_STREAM_VERSION_2 == aClientInfo->strmVer) {
        RPC_DwnldHdrV2Type dlHdr = {
            .magicNum = CPU_NativeToLE32(IMGL_IMGH_MAGIC),
            .pid = aStrmCfg->pid,
            .imgID = CPU_NativeToLE16(aStrmCfg->imgId),
            .imgSize = CPU_NativeToLE32(aStrmCfg->xferSize),
            .targetStrmHdl = aStrmCfg->peerHdl,
            .hostStrmHdl = aHdl,
            .response = CPU_NativeToLE32(BCM_ERR_OK),
        };
        retVal = RPC_IpcHostSend(RPC_CMDIDVAL_DWNLD_IMG_HDR_V2, (uint8_t *)&dlHdr, sizeof(dlHdr));
    } else {
        RPC_DwnldHdrV1Type dlHdr = {
            .magicNum = CPU_NativeToLE32(IMGL_IMGH_MAGIC),
            .imgSize = CPU_NativeToLE32(aStrmCfg->xferSize),
            .flags = 0UL,
            .errDetCode = 0ULL,
        };
        retVal = RPC_IpcHostSend(RPC_CMDIDVAL_DWNLD_IMG_HDR_V1, (uint8_t *)&dlHdr, sizeof(dlHdr));
    }

    return retVal;
}

/** @brief RPC IPC Master Interface Process Stream

    @trace #BRCM_SWARCH_RPC_IPCMASTERIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_IPC_MASTER

    @code{.unparsed}
    retVal = RPC_StrmGetCfg(aHdl, &strmCfg)
    if (BCM_ERR_OK == retVal)
        clientInfo = RPC_StrmGetMasterClientInfo(aHdl)
        if (NULL == clientInfo)
            retVal = BCM_ERR_UNKNOWN
     else
        retVal = BCM_ERR_UNKNOWN
    Proceed only after all stream details are fetched successfully
    if (BCM_ERR_OK == retVal)
        switch (clientInfo->state)
        case RPC_IPCMASTERSTREAMSTATE_RESET:
            retVal = RPC_IPCMasterSendIMGH(&strmCfg, aHdl, clientInfo)
            if (BCM_ERR_OK == retVal)
                clientInfo->state = RPC_IPCMASTERSTREAMSTATE_PEND_ACK_IMGH_RX
                retVal = BCM_ERR_BUSY
             else
                 RPC Module needs to retry sending - IMGH by invoking this function again
                retVal = BCM_ERR_BUSY
            break
        case RPC_IPCMASTERSTREAMSTATE_PEND_ACK_IMGH_RX:
            retVal = BCM_ERR_BUSY
            break
        case RPC_IPCMASTERSTREAMSTATE_READY:
            retVal = RPC_IPCMasterSendStreamData(aHdl, clientInfo, &strmCfg)
            if (BCM_ERR_OK == retVal)
                RPC_IPCMasterContext.strmVer = RPC_STREAM_VERSION_INVALID
                RPC_IPCMasterContext.selfStrmHdlV1 = RPC_HDL_INVALID
            break
        case RPC_IPCMASTERSTREAMSTATE_PEND_ACK_DATA_RX:
            retVal = BCM_ERR_BUSY
            break
        case RPC_IPCMASTERSTREAMSTATE_COMPLETE:
            RPC_IPCMasterContext.strmVer = RPC_STREAM_VERSION_INVALID
            RPC_IPCMasterContext.selfStrmHdlV1 = RPC_HDL_INVALID
            retVal = BCM_ERR_OK
            break
        default:
            retVal = BCM_ERR_UNKNOWN
            break
    return retVal
    @endcode
*/
static int32_t RPC_IPCMasterProcessStream(RPC_HdlType aHdl, BCM_SubStateType aPeerState)
{
    int32_t retVal;
    RPC_StrmCfgType strmCfg;
    RPC_MemStrmClientInfoType *clientInfo;

    retVal = RPC_StrmGetCfg(aHdl, &strmCfg);
    if (BCM_ERR_OK == retVal) {
        clientInfo = RPC_StrmGetMasterClientInfo(aHdl);
        if (NULL == clientInfo) {
            retVal = BCM_ERR_UNKNOWN;
        }
    } else {
        retVal = BCM_ERR_UNKNOWN;
    }

    /* Proceed only after all stream details are fetched successfully */
    if (BCM_ERR_OK == retVal) {
        switch (clientInfo->state) {
        case RPC_IPCMASTERSTREAMSTATE_RESET: {
            retVal = RPC_IPCMasterSendIMGH(&strmCfg, aHdl, clientInfo);
            if (BCM_ERR_OK == retVal) {
                clientInfo->state = RPC_IPCMASTERSTREAMSTATE_PEND_ACK_IMGH_RX;
                retVal = BCM_ERR_BUSY;
            } else {
                /* RPC Module needs to retry sending - IMGH by invoking this function again */
                retVal = BCM_ERR_BUSY;
            }
            break;
        }
        case RPC_IPCMASTERSTREAMSTATE_PEND_ACK_IMGH_RX:
            retVal = BCM_ERR_BUSY;
            break;
        case RPC_IPCMASTERSTREAMSTATE_READY:
            retVal = RPC_IPCMasterSendStreamData(aHdl, clientInfo, &strmCfg);
            if (BCM_ERR_OK == retVal) {
                RPC_IPCMasterContext.strmVer = RPC_STREAM_VERSION_INVALID;
                RPC_IPCMasterContext.selfStrmHdlV1 = RPC_HDL_INVALID;
            }
            break;
        case RPC_IPCMASTERSTREAMSTATE_PEND_ACK_DATA_RX:
            retVal = BCM_ERR_BUSY;
            break;
        case RPC_IPCMASTERSTREAMSTATE_COMPLETE:
            RPC_IPCMasterContext.strmVer = RPC_STREAM_VERSION_INVALID;
            RPC_IPCMasterContext.selfStrmHdlV1 = RPC_HDL_INVALID;
            retVal = BCM_ERR_OK;
            break;
        default:
            retVal = BCM_ERR_UNKNOWN;
            break;
        }
    }
    return retVal;
}

/** @brief RPC IPC Master Interface Disconnect

    @behavior Sync, Non-Reentrant

    @param[in]      void

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Disconnection successful
    @retval     #BCM_ERR_UNKNOWN        Unknown failure

    @trace #BRCM_SWARCH_RPC_IPCMASTERIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_IPC_MASTER

    @limitations None

    @code{.unparsed}
    return BCM_ERR_OK
    @endcode
*/
static int32_t RPC_IPCMasterDisconnect(void)
{
    return BCM_ERR_OK;
}

/** @brief RPC IPC Master Interface channel de-initialization

    This API used to deinitialize the IPC Master Interface

    @behavior Sync, Non-Reentrant

    @param[in]      void

    @retval void

    @trace #BRCM_SWARCH_RPC_IPCMASTERIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_IPC_MASTER

    @limitations None

    @code{.unparsed}
    RPC_IpcHostDeinit()
    BCM_MemSet(&RPC_IPCMasterContext, 0U, sizeof(RPC_IPCMasterContext));
    @endcode
*/
static void RPC_IPCMasterDeinit(void)
{
    RPC_IpcHostDeinit();
    BCM_MemSet(&RPC_IPCMasterContext, 0U, sizeof(RPC_IPCMasterContext));
    return;
}

/** @brief RPC IPC Master Interface Get Max Message size

    @behavior Sync, Non-Reentrant

    @param[in]      void

    @return Message Size

    @trace #BRCM_SWARCH_RPC_IPCMASTERIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_IPC_MASTER

    @limitations None

    @code{.unparsed}
    return RPC_MEM_MSG_PAYLOAD_SZ
    @endcode
*/
static uint32_t RPC_IPCMasterGetMsgSize(void)
{
    return RPC_MEM_MSG_PAYLOAD_SZ;
}

/** @brief RPC IPC Master Interface Process

    @behavior Sync, Non-Reentrant

    @param[in]      void

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             No Errors found
    @retval     #BCM_ERR_TIME_OUT       Connection timed out
    @retval     #BCM_ERR_UNKNOWN        Unknown failure

    @trace #BRCM_SWARCH_RPC_IPCMASTERIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_IPC_MASTER

    @limitations None

    @code{.unparsed}
    return BCM_ERR_OK
    @endcode
*/
static int32_t RPC_IPCMasterProcess(void)
{
    return BCM_ERR_OK;
}

/** @brief RPC IPC Master Interface Detect Stream request

    Interface function to detect new stream requests
    Unknown failures may be recovered only with deinit and init.

    @behavior Sync, Non-Reentrant

    @param[out]     aHdl            New Handle

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Detected new stream
    @retval     #BCM_ERR_EAGAIN         Detected New stream, call again for more detections
    @retval     #BCM_ERR_NOT_FOUND      No New streams detected
    @retval     #BCM_ERR_UNKNOWN        Unknown failure

    @trace #BRCM_SWARCH_RPC_IPCMASTERIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_IPC_MASTER

    @limitations None

    @code{.unparsed}
    if (RPC_STREAM_VERSION_INVALID == RPC_IPCMasterContext.strmVer)
        retVal = BCM_ERR_NOT_FOUND
    else if ((RPC_STREAM_VERSION_1 == RPC_IPCMasterContext.strmVer)
                AND (RPC_HDL_INVALID != RPC_IPCMasterContext.selfStrmHdlV1))
        retVal = BCM_ERR_NOT_FOUND
    else
        if (FALSE == RPC_IPCMasterContext.streamCfg.isTbl)
            size = RPC_GetImgSize(RPC_IPCMasterContext.streamCfg.pid,
                                  RPC_IPCMasterContext.streamCfg.imgId,
                                  RPC_IPCMasterContext.streamCfg.offset)
            if (size == 0UL)
                RPC_IPCMasterContext.strmVer = RPC_STREAM_VERSION_INVALID
                retVal = BCM_ERR_NOT_FOUND
            else
                if (RPC_IPCMasterContext.streamCfg.xferSize > size)
                    RPC_IPCMasterContext.streamCfg.xferSize = size
                retVal = BCM_ERR_OK
        else
            retVal = BCM_ERR_OK

        if (BCM_ERR_OK == retrVal)
            retVal = RPC_StrmAlloc(&RPC_IPCMasterContext.streamCfg, RPC_IPCMasterContext.peerId,
                                    RPC_IPCMasterContext.selfId, RPC_IPCMasterContext.assocId, aHdl)
            if (BCM_ERR_NOMEM == retVal)
                retVal = BCM_ERR_EAGAIN
            else if (BCM_ERR_OK != retVal)
                retVal = BCM_ERR_UNKNOWN
            else
                clientInfo = RPC_StrmGetMasterClientInfo(*aHdl)
                if (NULL == clientInfo)
                    retVal = BCM_ERR_UNKNOWN
                else
                    clientInfo->strmVer = RPC_IPCMasterContext.strmVer
                if (RPC_STREAM_VERSION_1 == RPC_IPCMasterContext.strmVer)
                    RPC_IPCMasterContext.selfStrmHdlV1 = *aHdl
                else
                    RPC_IPCMasterContext.strmVer = RPC_STREAM_VERSION_INVALID
    return retVal
    @endcode
*/
static int32_t RPC_IPCMasterDetectStream(RPC_HdlType* const aHdl)
{
    int32_t retVal;
    RPC_MemStrmClientInfoType *clientInfo;
    uint32_t size;

    if (RPC_STREAM_VERSION_INVALID == RPC_IPCMasterContext.strmVer) {
        retVal = BCM_ERR_NOT_FOUND;
    } else if ((RPC_STREAM_VERSION_1 == RPC_IPCMasterContext.strmVer)
                && (RPC_HDL_INVALID != RPC_IPCMasterContext.selfStrmHdlV1)) {
        retVal = BCM_ERR_NOT_FOUND;
    } else {
        if (FALSE == RPC_IPCMasterContext.streamCfg.isTbl) {
            /* Get the size of the image */
            size = RPC_GetImgSize(RPC_IPCMasterContext.streamCfg.pid,
                                  RPC_IPCMasterContext.streamCfg.imgId,
                                  RPC_IPCMasterContext.streamCfg.offset);
            if (size == 0UL) {
                RPC_IPCMasterContext.strmVer = RPC_STREAM_VERSION_INVALID;
                retVal = BCM_ERR_NOT_FOUND;
            } else {
                if (RPC_IPCMasterContext.streamCfg.xferSize > size) {
                    /* Feasible, update the xferSize to actual size */
                    RPC_IPCMasterContext.streamCfg.xferSize = size;
                } /* else txSize <= size, continue with the value in Cfg */
                retVal = BCM_ERR_OK;
            }
        } else {
            retVal = BCM_ERR_OK;
        }

        if (BCM_ERR_OK == retVal) {
            retVal = RPC_StrmAlloc(&RPC_IPCMasterContext.streamCfg, RPC_IPCMasterContext.peerId,
                    RPC_IPCMasterContext.selfId, RPC_IPCMasterContext.assocId, aHdl);
            if (BCM_ERR_NOMEM == retVal) {
                retVal = BCM_ERR_EAGAIN;
            } else if (BCM_ERR_OK != retVal) {
                /* aHdl is NULL */
                retVal = BCM_ERR_UNKNOWN;
            } else {
                clientInfo = RPC_StrmGetMasterClientInfo(*aHdl);
                if (NULL == clientInfo) {
                    retVal = BCM_ERR_UNKNOWN;
                } else {
                    /* cache strVer */
                    clientInfo->strmVer = RPC_IPCMasterContext.strmVer;
                }
                if (RPC_STREAM_VERSION_1 == RPC_IPCMasterContext.strmVer) {
                    RPC_IPCMasterContext.selfStrmHdlV1 = *aHdl;
                } else {
                    RPC_IPCMasterContext.strmVer = RPC_STREAM_VERSION_INVALID;
                }
                /* Stream has been allocated & aHdl populated, retVal is BCM_ERR_OK */
            }
        }
    }
    return retVal;
}

/** @brief IPC Master interface structure

    @trace #BRCM_SWARCH_RPC_IPCMASTERIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_IPC_MASTER
*/
const RPC_InterfaceType RPC_IPCMasterIfc = {
    .type          = RPC_IFC_CHAN_IPC,
    .mode          = RPC_IFC_CHAN_MODE_MASTER,
    .assoc         = RPC_ASSOCIATIONINDEX_1,
    .init          = RPC_IPCMasterInit,
    .isConnected   = RPC_IPCMasterIsConnected,
    .connect       = RPC_IPCMasterConnect,
    .getMsgSize    = RPC_IPCMasterGetMsgSize,
    .sendMsg       = RPC_IPCMasterSendMsg,
    .recvMsg       = RPC_IPCMasterRecvMsg,
    .processMsg    = RPC_IPCMasterProcess,
    .detectStrm    = RPC_IPCMasterDetectStream,
    .processStrm   = RPC_IPCMasterProcessStream,
    .disconnect    = RPC_IPCMasterDisconnect,
    .getEventMask  = RPC_IPCMasterGetEventMask,
    .deinit        = RPC_IPCMasterDeinit,
};

/** @} */
