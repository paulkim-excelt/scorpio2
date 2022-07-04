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
    @defgroup grp_rpc_v2_master_impl Local Master Design
    @ingroup grp_rpc_v2_local

    @addtogroup grp_rpc_v2_master_impl
    @{

    @file rpc_msg_master.c
    @brief RPC Master interface Design

    @version 0.1 Initial Version
*/

#include <stdio.h>
#include <stddef.h>
#include <string.h>
#include <bcm_err.h>
#include <bcm_utils.h>
#include <bcm_comp.h>
#include <bcm_time.h>
#include <pt_utils.h>
#include <rpc_mem.h>
#include <rpc_interface.h>
#include <cpu.h>
#include <rpc_local.h>
#include <rpc_local_osil.h>
#include <rpc_master_loader.h>
#include <imgl_interface.h>
#include <mcu.h>
#include <system_dmon.h>
#include <system_imgl.h>
#ifndef RPC_MASTER_ENABLE_IFC_SUPPORT
#include <rpc_hosthelper.h>
#endif
/**
    @name Component Design IDs
    @{
    @brief Design IDs for Component
*/
#define BRCM_SWDSGN_RPC_MASTER_MAX_MSG_MACRO             (0xA201U)    /**< @brief #RPC_MASTER_MAX_MSG             */
#define BRCM_SWDSGN_RPC_MASTER_MAX_MSG_ASYNC_MACRO       (0xA202U)    /**< @brief #RPC_MASTER_MAX_MSG_ASYNC       */
#define BRCM_SWDSGN_RPC_MASTER_MAX_MSG_ASYNC_MASK_MACRO  (0xA203U)    /**< @brief #RPC_MASTER_MAX_MSG_ASYNC_MASK  */
#define BRCM_SWDSGN_RPC_MASTERHEARTBEATMSG_GLOBAL        (0xA204U)    /**< @brief #RPC_MasterHeartBeatMsg         */
#define BRCM_SWDSGN_RPC_MASTERMSG_TYPE                   (0xA205U)    /**< @brief #RPC_MasterMsgType              */
#define BRCM_SWDSGN_RPC_MASTERMSGCTXTYPE_TYPE            (0xA206U)    /**< @brief #RPC_MasterMsgCtxType           */
#define BRCM_SWDSGN_RPC_MASTERASYNCENQ_PROC              (0xA207U)    /**< @brief #RPC_MasterAsyncEnQ             */
#define BRCM_SWDSGN_RPC_MASTERASYNCPEEKINQ_PROC          (0xA208U)    /**< @brief #RPC_MasterAsyncPeekInQ         */
#define BRCM_SWDSGN_RPC_MASTERASYNCDEQ_PROC              (0xA209U)    /**< @brief #RPC_MasterAsyncDeQ             */
#define BRCM_SWDSGN_RPC_MASTERIFC_GLOBAL                 (0xA20AU)    /**< @brief #RPC_MasterIfc                  */
#define BRCM_SWDSGN_RPC_MASTERIMGHANDLER_GLOBAL          (0xA20BU)    /**< @brief #RPC_MasterImgHandler           */
#define BRCM_SWDSGN_RPC_MASTEREVENT_GLOBAL               (0xA20CU)    /**< @brief #RPC_MasterEvent                */
#define BRCM_SWDSGN_RPC_MASTERIMGLOADMSG_GLOBAL          (0xA20DU)    /**< @brief #RPC_MasterImgLoadMsg           */
#define BRCM_SWDSGN_RPC_MASTERMSGCTX_TYPE                (0xA20EU)    /**< @brief #RPC_MasterMsgCtx               */
#define BRCM_SWDSGN_RPC_MASTERINIT_PROC                  (0xA20FU)    /**< @brief #RPC_MasterInit                 */
#define BRCM_SWDSGN_RPC_MASTERALLOCMSG_PROC              (0xA210U)    /**< @brief #RPC_MasterAllocMsg             */
#define BRCM_SWDSGN_RPC_MASTERFREEMSG_PROC               (0xA211U)    /**< @brief #RPC_MasterFreeMsg              */
#define BRCM_SWDSGN_RPC_MASTERISCONNECTED_PROC           (0xA212U)    /**< @brief #RPC_MasterIsConnected          */
#define BRCM_SWDSGN_RPC_MASTERCONNECT_PROC               (0xA213U)    /**< @brief #RPC_MasterConnect              */
#define BRCM_SWDSGN_RPC_MASTERGETMSGSIZE_PROC            (0xA214U)    /**< @brief #RPC_MasterGetMsgSize           */
#define BRCM_SWDSGN_RPC_MASTERSENDMSG_PROC               (0xA215U)    /**< @brief #RPC_MasterSendMsg              */
#define BRCM_SWDSGN_RPC_MASTERRECVMSG_PROC               (0xA216U)    /**< @brief #RPC_MasterRecvMsg              */
#define BRCM_SWDSGN_RPC_MASTERPROCESS_PROC               (0xA217U)    /**< @brief #RPC_MasterProcess              */
#define BRCM_SWDSGN_RPC_MASTERDETECTSTRM_PROC            (0xA218U)    /**< @brief #RPC_MasterDetectStrm           */
#define BRCM_SWDSGN_RPC_MASTERPROCESSSTRM_PROC           (0xA219U)    /**< @brief #RPC_MasterProcessStrm          */
#define BRCM_SWDSGN_RPC_MASTERDISCONNECT_PROC            (0xA21AU)    /**< @brief #RPC_MasterDisconnect           */
#define BRCM_SWDSGN_RPC_MASTERDEINIT_PROC                (0xA21BU)    /**< @brief #RPC_MasterDeinit               */
#define BRCM_SWDSGN_RPC_MASTERLOADERGETMSG_PROC          (0xA21CU)    /**< @brief #RPC_MasterLoaderGetMsg         */
#define BRCM_SWDSGN_RPC_MASTERLOADIMG_PROC               (0xA21DU)    /**< @brief #RPC_MasterLoadImg              */
#define BRCM_SWDSGN_RPC_MASTERGETLOADERSTATUS_PROC       (0xA21EU)    /**< @brief #RPC_MasterGetLoaderStatus      */
#define BRCM_SWDSGN_RPC_MASTERREADPTBL_PROC              (0xA21FU)    /**< @brief #RPC_MasterReadPTBL             */
#define BRCM_SWDSGN_RPC_MASTERREADITBL_PROC              (0xA220U)    /**< @brief #RPC_MasterReadITBL             */
#define BRCM_SWDSGN_RPC_MASTERGETEVENTMASK_PROC          (0xA221U)    /**< @brief #RPC_MasterGetEventMask         */
#define BRCM_SWDSGN_RPC_ASYNCEVENTTOHOST_PROC            (0xA222U)    /**< @brief #RPC_AsyncEventToHost           */
#define BRCM_SWDSGN_RPC_MASTERASYNCGETMSG_PROC           (0xA223U)    /**< @brief #RPC_MasterAsyncGetMsg          */
#define BRCM_SWDSGN_RPC_MASTERASYNCMSGFROMQ_GLOBAL       (0xA224U)    /**< @brief #RPC_MasterAsyncMsgFromQ        */
#define BRCM_SWDSGN_RPC_MASTERASYNCMSGS_GLOBAL           (0xA225U)    /**< @brief #RPC_MasterAsyncMsgs            */
#define BRCM_SWDSGN_RPC_MASTERMERGERESPONSE_PROC         (0xA226U)    /**< @brief #RPC_MasterMergeResponse        */
#define BRCM_SWDSGN_RPC_MASTERPROCESSSLAVERESPONSE_PROC  (0xA227U)    /**< @brief #RPC_MasterProcessSlaveResponse */
#define BRCM_SWDSGN_RPC_MASTERPROCESSLOCALRESPONSE_PROC  (0xA228U)    /**< @brief #RPC_MasterProcessLocalResponse */
#define BRCM_SWDSGN_RPC_MASTERCHECKCMDTIMEOUT_PROC       (0xA229U)    /**< @brief #RPC_MasterCheckCmdTimeout      */
#define BRCM_SWDSGN_RPC_MASTER_DBG_MSG_COUNT_MACRO       (0xA22AU)    /**< @brief #RPC_MASTER_DBG_MSG_COUNT       */
/** @} */

/**
    @brief RPC Message Master Maximum number of command messages

    @trace #BRCM_SWARCH_RPC_MASTERIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL
*/
#define RPC_MASTER_MAX_MSG    (32UL)

/**
    @brief RPC DBG Message count

    @trace #BRCM_SWARCH_RPC_MASTERIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL
*/
#define RPC_MASTER_DBG_MSG_COUNT (RPC_MEM_MSG_PAYLOAD_SZ/sizeof(BCM_DbgMsgType))

#ifdef ENABLE_RPC_MASTER_STREAM_SUPPORT
/**
    @brief RPC Loader Queue messages

    @trace #BRCM_SWARCH_RPC_MASTERIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL
*/
static RPC_MasterLoadReqType
          RPC_MasterImgLoadMsg[RPC_MASTER_LOAD_MSG_MAX]
          COMP_SECTION(".bss.rpc");
#endif

#ifdef RPC_MASTER_ENABLE_IFC_SUPPORT
/**
    @brief RPC Async messages to Host

    @trace #BRCM_SWARCH_RPC_MASTERIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL
*/
static RPC_LocalMsgType
          RPC_MasterAsyncMsgFromQ[RPC_MASTER_ASYNC_MSG_MAX]
          COMP_SECTION(".bss.rpc");
#endif

/**
    @brief Structure used to manage commands for Message Queue Master

    'slaveMsgHdl' stores the information received from the slave interface

    @trace #BRCM_SWARCH_RPC_MASTERIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL
 */
typedef struct sRPC_MasterMsgType {
    BCM_SubStateType        subState;     /**< @brief Substate (only for special commands) */
    RPC_HdlType             cmdHdl;       /**< @brief Handle of the received Command
                                               which is acquired and held here */
    uint64_t                timeoutNs;    /**< @brief Time at which the commands needs to timout
                                               if processing is not complete */
    uint32_t                slaveMsgHdl;  /**< @brief Handle to the cloned message got
                                               from RPC slave for forwarded messages */
    uint32_t                curNumResp;   /**< @brief Number of collated responses*/
    uint32_t                reqNumResp;   /**< @brief Number of needed responses */
    BCM_CmdType             cmd;          /**< @brief Command (group, comp, cmd)    */
    BCM_GroupIDType         groupID;      /**< @brief Group ID */
    BCM_CompIDType          compID;       /**< @brief Component ID */
    uint32_t                objIdx;       /**< @brief Index of the
                                               #RPC_MasterIfcObjects */
    BCM_HandleType          handle;       /**< @brief Handle to message queue when
                                               command is provided to local
                                               service provider */
}RPC_MasterMsgType;

/**
    @brief RPC Master Message Queue Message context structure

    @trace #BRCM_SWARCH_RPC_MASTERIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL
 */
typedef struct sRPC_MasterMsgCtxType {
    RPC_InterfaceIdType      selfId;                     /**< @brief This  Interface ID */
    RPC_InterfaceIdType      peerId;                     /**< @brief Connected Master ID */
    RPC_AssociationIndexType assocId;                    /**< @brief This interface Association ID */
    uint32_t                 strmTimeoutMs;              /**< @brief Timeout for streams in ms */
    RPC_MasterMsgType        cmdMsg[RPC_MASTER_MAX_MSG]; /**< @brief Memory to store context
                                                              of recvd commands */
    uint32_t                 usageMask;                  /**< @brief Bitmask of memory usage */
    RPC_MemMsgType           tempMsg;                    /**< @brief Message used for merging responses */
    uint32_t                 isSlvAssoc;                 /**< @brief Is Slave Association available */
    BCM_DbgMsgType           dbgMsgs[RPC_MASTER_DBG_MSG_COUNT];
} RPC_MasterMsgCtxType;

/**
    @brief RPC Master Message Queue Message context

    @trace #BRCM_SWARCH_RPC_MASTERIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL
*/
static RPC_MasterMsgCtxType RPC_MasterMsgCtx COMP_SECTION(".bss.rpc");

/** @brief Allocate a message from the RPC Master Command msg pool

    Function used to allocate a free message in RPC Master context
    1 - Memory is Free
    0 - Memory is Busy

    @behavior Sync, Non-Reentrant

    @param[out]      aIndex        Command Message Index

    @retval     #BCM_ERR_OK             Command message is Allocated
    @retval     #BCM_ERR_NOMEM          No Memory available to allocate
    @retval     #BCM_ERR_UNKNOWN        Index is NULL

    @trace #BRCM_SWARCH_RPC_MASTERIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL

    @limitations None

    @code{.unparsed}
    calculate the number of trailing Zeros
    find the index by using (RPC_MASTER_MAX_MSG - 1UL) - zerosCnt
    if(RPC_MASTER_MAX_MSG <= aIndex)
        return BCM_ERR_NOMEM
    else
        memset the context RPC_MasterMsgCtx.cmdMsg[idx]
        mask the index
        return the index
        clear the index bit RPC_MasterMsgCtx.usageMask
    @endcode
*/
static int32_t RPC_MasterAllocMsg(uint32_t *aIndex)
{
    int32_t retVal;
    uint32_t zerosCnt;
    uint32_t idx;

    if(NULL == aIndex) {
        retVal = BCM_ERR_UNKNOWN;
    } else {
        zerosCnt = CPU_Clz(RPC_MasterMsgCtx.usageMask);
        idx = (RPC_MASTER_MAX_MSG - 1UL) - zerosCnt;
        if(RPC_MASTER_MAX_MSG <= idx) {
            retVal = BCM_ERR_NOMEM;
        } else {
            BCM_MemSet(&RPC_MasterMsgCtx.cmdMsg[idx], 0U, sizeof(RPC_MasterMsgType));
            RPC_MasterMsgCtx.usageMask &= ~(1UL << idx);
            *aIndex = idx;
            retVal = BCM_ERR_OK;
        }
    }

    return retVal;
}

/** @brief Free message from the the RPC Master Command msg pool

    Function used to free a message of given index in RPC_MasterMsgCtx

    @behavior Sync, Non-Reentrant

    @param[in]      aIndex        Command Message Index

    @return void

    @trace #BRCM_SWARCH_RPC_MASTERIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL

    @limitations None

    @code{.unparsed}
    set the index bit in RPC_MasterMsgCtx.usageMask
    @endcode
*/
static inline void RPC_MasterFreeMsg(uint32_t aIndex)
{
    RPC_MasterMsgCtx.usageMask |= (1UL << aIndex);;
}

#ifdef ENABLE_RPC_MASTER_STREAM_SUPPORT
/**
    @brief Get the aIdx-th for loader message from memory

    @trace #BRCM_SWARCH_RPC_MASTERIFC_GLOBAL
    @trace #BRCM_SWARCH_RPC_MASTERIMGHANDLER_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL

    @code{.unparsed}
        if(RPC_MASTER_LOAD_MSG_MAX >= aIdx)
            return NULL
        else
            return Address of RPC_MasterImgLoadMsg[aIdx]
    @endcode
*/
void* RPC_MasterLoaderGetMsg(uint32_t aIdx)
{
    void* pRet = NULL;

    if (RPC_MASTER_LOAD_MSG_MAX > aIdx) {
        pRet = (void *)(&RPC_MasterImgLoadMsg[aIdx]);
    }
    return pRet;
}
#endif

#ifdef RPC_MASTER_ENABLE_IFC_SUPPORT
/**
    @brief Get the async message from memory for specified index

    @trace #BRCM_SWARCH_RPC_MASTERIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL

    @code{.unparsed}
    void* pRet = NULL
    if (RPC_MASTER_ASYNC_MSG_MAX > aIdx)
        pRet = Address of RPC_MasterAsyncMsgFromQ[aIdx]
    return pRet
    @endcode
*/
void* RPC_MasterAsyncGetMsg (uint32_t aIdx)
{
    void* pRet = NULL;

    if (RPC_MASTER_ASYNC_MSG_MAX > aIdx) {
        pRet = (void *)(&RPC_MasterAsyncMsgFromQ[aIdx]);
    }
    return pRet;
}
#endif

/** @brief RPC Master interface Initialization

    Function initialize the RPC Master interface

    @behavior Sync, Non-Reentrant

    @param[in]      void

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Init successful
    @retval     #BCM_ERR_UNKNOWN        Init Failed

    @trace #BRCM_SWARCH_RPC_MASTERIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL

    @limitations None

    @code{.unparsed}
        memset RPC_MasterImgLoadMsg
        memset RPC_MasterMsgCtx
        Set the usageMask
    @endcode
*/
static int32_t RPC_MasterInit(void)
{
    int32_t retVal = BCM_ERR_OK;
    uint32_t i;
    MCU_InfoType info;

#ifdef ENABLE_RPC_MASTER_STREAM_SUPPORT
    BCM_MemSet(RPC_MasterImgLoadMsg, 0U, (RPC_MASTER_LOAD_MSG_MAX * sizeof(RPC_MasterLoadReqType)));
#endif
    BCM_MemSet(&RPC_MasterMsgCtx, 0U, sizeof(RPC_MasterMsgCtxType));
    retVal = RPC_GetModIfcAndAssoc(&RPC_MasterIfc,
                                   &RPC_MasterMsgCtx.peerId,
                                   &RPC_MasterMsgCtx.selfId,
                                   &RPC_MasterMsgCtx.assocId);
    if(BCM_ERR_OK == retVal) {
        for(i=0; i<RPC_MASTER_MAX_MSG; i++){
            RPC_MasterMsgCtx.usageMask |= (1UL << i);;
        }
    }

    RPC_MasterMsgCtx.isSlvAssoc = 0UL;
    retVal = MCU_GetInfo(&info);
    if (BCM_ERR_OK == retVal) {
        if (TRUE == info.stackingEn) {
            if (MCU_DEVICE_MASTER == info.mstSlvMode) {
                RPC_MasterMsgCtx.isSlvAssoc = 1UL;
            }
        }
    } else if (BCM_ERR_NOSUPPORT == retVal) {
        /* Host implementation handling */
        RPC_MasterMsgCtx.isSlvAssoc = 1UL;
        retVal = BCM_ERR_OK;
    } else {
        /* MISRA */
    }

#ifdef ENABLE_RPC_MASTER_STREAM_SUPPORT
    RPC_MasterMsgCtx.strmTimeoutMs = RPC_StreamTimeoutMs;
#endif
    return retVal;
}

/** @brief RPC Master interface connection status

    @behavior Sync, Non-Reentrant

    @param[in]      void

    @return     FALSE - Disconnected, TRUE - Connected

    @trace #BRCM_SWARCH_RPC_MASTERIFC_GLOBAL
    @trace  #BRCM_SWREQ_RPC_INTERFACE_LOCAL

    @limitations None

    @code{.unparsed}
    @endcode
*/
static uint32_t RPC_MasterIsConnected(void)
{
    return TRUE;
}

/** @brief RPC Master interface Connect

    This API will initiate connection to remote slave.

    @behavior Sync, Non-Reentrant

    @param[in]      void

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Connection established
    @retval     #BCM_ERR_NOT_FOUND      No Connection established
    @retval     #BCM_ERR_UNKNOWN        Unknown failure

    @trace #BRCM_SWARCH_RPC_MASTERIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL

    @limitations None

    @code{.unparsed}
    @endcode
*/
static int32_t RPC_MasterConnect(void)
{
    return BCM_ERR_OK;
}

/** @brief RPC Master interface Get Max Message size

    @behavior Sync, Non-Reentrant

    @param[in]      void

    @return Message Size

    @trace #BRCM_SWARCH_RPC_MASTERIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL

    @limitations None

    @code{.unparsed}
        return RPC_MEM_MSG_PAYLOAD_SZ;
    @endcode
*/
static uint32_t RPC_MasterGetMsgSize(void)
{
    return RPC_MEM_MSG_PAYLOAD_SZ;
}

/** @brief Get the event mask for the interface

    API to return the event mask for the interface.
    This API gets executed in the context of the caller task.

    @behavior Sync, Reentrant

    @pre None

    @param void

    @retval     #uint32_t   Event mask for the interface

    @post None

    @trace #BRCM_SWARCH_RPC_MASTERIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL

    @limitations Must return the same event mask at any point of time
    i.e. it cannot be changed dynamically.

    @code{.unparsed}
    return RPC_MasterEvent;
    @endcode
*/
static uint32_t RPC_MasterGetEventMask(void)
{
    return RPC_MasterEvent;
}

/** @brief RPC Master interface Send message

    Interface Function to send command

    @behavior Sync, Non-Reentrant

    @param[in]      aHdl                Message Handle to be sent

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Message sent successfully
    @retval     #BCM_ERR_NOMEM          Queue is Full and cannot be added to queue
    @retval     #BCM_ERR_UNKNOWN        Unknown failure

    @trace #BRCM_SWARCH_RPC_MASTERIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL

    @limitations None

    @code{.unparsed}
    retVal = RPC_MasterAllocMsg(&msgIdx)
    if(BCM_ERR_OK == retVal)
        cmdMsg = RPC_MsgGet(aHdl)
        if(NULL == cmdMsg)
            retVal = BCM_ERR_UNKNOWN
         else
#ifdef RPC_MASTER_ENABLE_IFC_SUPPORT
            compID = (uint16_t)BCM_GET_COMP(cmdMsg->cmd)
            groupID = (uint8_t)BCM_GET_GROUPID(cmdMsg->cmd)
            for(i = 0UL i < RPC_MASTER_MAX_OBJECTS i++)
                if((NULL != RPC_MasterIfcObjects[i])
                                && (NULL != RPC_MasterIfcObjects[i]->server.sendCmd)
                                && (groupID == RPC_MasterIfcObjects[i]->group))
                    retVal = RPC_MasterIfcObjects[i]->server.sendCmd(cmdID, compID, cmdMsg->payload,
                                         cmdMsg->len, RPC_MasterGetEventMask(),
                                         &RPC_MasterMsgCtx.cmdMsg[msgIdx].handle, &forwardtoSlaves)
                    if(BCM_ERR_OK == retVal)
                        RPC_MasterMsgCtx.cmdMsg[msgIdx].groupID = groupID
                        RPC_MasterMsgCtx.cmdMsg[msgIdx].compID = compID
                        RPC_MasterMsgCtx.cmdMsg[msgIdx].objIdx = i
                       break
#else
            if (BCM_CMDID(BCM_GROUPID_SYS, BCM_RSV_ID, SYS_CMDID_EXECUTE) == cmdMsg->cmd)
                char fileName[100UL]
                strncpy(fileName, (char*)cmdMsg->payload, 100UL)
                Configure the IMGL interface with provided image
                 cmdMsg->response = RPC_HostImglSet(fileName)
                update the handle to send as response
                 RPC_MasterMsgCtx.specialCmdHandle = aHdl
                retVal = BCM_ERR_OK
            else if (BCM_CMDID(BCM_GROUPID_SYS, BCM_RSV_ID, SYS_CMDID_IMGL_HDR_REQ) == cmdMsg->cmd)
                SYS_UpdateExecCmdType *info = (SYS_UpdateExecCmdType*)cmdMsg->payload;
                char fileName[100UL]
                strncpy(fileName, (char*)cmdMsg->payload, 100UL)
                Configure the IMGL interface with provided image
                 cmdMsg->response = RPC_HostImglSet(fileName)
                Check if file copied success fully
                if(BCM_ERR_OK == cmdMsg->response)
                    memset(info, 0U, sizeof(SYS_UpdateExecCmdType))
                    cmdMsg->response = RPC_HostImglGetParsedImgHdrs(info)
                    Check if get parsed images successfully
                     if(BCM_ERR_OK == cmdMsg->response)
                        cmdMsg->len = sizeof(SYS_UpdateExecCmdType)
                        cmdMsg->response = BCM_ERR_OK
                RPC_MasterMsgCtx.specialCmdHandle = aHdl
                retVal = BCM_ERR_OK
            else
            forwardtoSlaves = 1UL
#endif
            if (1UL == forwardtoSlaves)
                retVal = RPC_SendToSlave(aHdl, &RPC_MasterMsgCtx.cmdMsg[msgIdx].slaveMsgHdl)
                if(retVal IS BCM_ERR_OK)
                    (void)RPC_MemPushAppInfo(aHdl,msgIdx)

        if(BCM_ERR_OK != retVal)
            BCM_MemSet(&RPC_MasterMsgCtx.cmdMsg[msgIdx], 0U, sizeof(RPC_MasterMsgType))
            RPC_MasterFreeMsg(msgIdx)
         else
            RPC_MasterMsgCtx.cmdMsg[msgIdx].cmdHdl = aHdl
            RPC_MasterMsgCtx.cmdMsg[msgIdx].subState = BCM_STATE_SUB_STATE_RESET

    return retVal

    @endcode
*/
static int32_t RPC_MasterSendMsg(RPC_HdlType aHdl)
{
    uint32_t        i = 0UL;
    BCM_GroupIDType groupID = 0U;
    BCM_CompIDType  compID = 0U;
    uint32_t        msgIdx = 0UL;
    uint32_t        forwardtoSlaves = 0UL;
    int32_t         retVal;

    RPC_MemMsgType *cmdMsg = NULL;
    retVal = RPC_MasterAllocMsg(&msgIdx);
    if(BCM_ERR_OK == retVal) {
        /* Space is available in Message context*/
        cmdMsg = RPC_MsgGet(aHdl);
        if(NULL == cmdMsg) {
            RPC_MasterFreeMsg(msgIdx);
            retVal = BCM_ERR_UNKNOWN;
        } else {
            compID = (uint16_t)BCM_GET_COMP(cmdMsg->cmd);
            groupID = (uint8_t)BCM_GET_GROUPID(cmdMsg->cmd);

            for(i = 0UL; i < RPC_MASTER_MAX_OBJECTS; i++) {
                if((NULL != RPC_MasterIfcObjects[i]) &&
                  (NULL != RPC_MasterIfcObjects[i]->server.sendCmd) &&
                   (groupID == RPC_MasterIfcObjects[i]->group)
#ifdef ENABLE_HOST_BUILD
                   && (compID == RPC_MasterIfcObjects[i]->server.compID)
#endif
                   ) {

                    RPC_MasterMsgCtx.cmdMsg[msgIdx].cmd = 0UL;
                    RPC_MasterMsgCtx.cmdMsg[msgIdx].groupID = 0U;
                    RPC_MasterMsgCtx.cmdMsg[msgIdx].compID = 0UL;
                    retVal = RPC_MasterIfcObjects[i]->server.sendCmd(cmdMsg->cmd, cmdMsg->len, cmdMsg->payload,
                                         &RPC_MasterMsgCtx.cmdMsg[msgIdx].handle, &forwardtoSlaves);
                    RPC_MasterMsgCtx.cmdMsg[msgIdx].cmd = cmdMsg->cmd;
                    RPC_MasterMsgCtx.cmdMsg[msgIdx].groupID = groupID;
                    RPC_MasterMsgCtx.cmdMsg[msgIdx].compID = compID;
                    RPC_MasterMsgCtx.cmdMsg[msgIdx].objIdx = i;
                    if(BCM_ERR_OK == retVal) {
                        if (0UL != RPC_MasterMsgCtx.cmdMsg[msgIdx].handle) {
                            RPC_MasterMsgCtx.cmdMsg[msgIdx].reqNumResp++;
                        }
                    } else {
#ifndef ENABLE_HOST_BUILD
                        /* Error response for the command */
                        RPC_MasterMsgCtx.cmdMsg[msgIdx].reqNumResp = 0UL;
                        RPC_MasterMsgCtx.cmdMsg[msgIdx].curNumResp = 0UL;
                        RPC_MasterMsgCtx.cmdMsg[msgIdx].handle = 0UL;
                        RPC_MasterMsgCtx.cmdMsg[msgIdx].cmdHdl = aHdl;
                        forwardtoSlaves = 0UL;
                        cmdMsg->response = retVal;
                        retVal = BCM_ERR_OK;
#else
                        forwardtoSlaves = 1UL;
#endif
                    }
                    break;
                }
            }
#ifdef ENABLE_HOST_BUILD
            if (RPC_MASTER_MAX_OBJECTS == i) {
                forwardtoSlaves = 1UL;
                i = 0UL;
            }
#endif
            if(RPC_MASTER_MAX_OBJECTS != i) {
                if ((1UL == forwardtoSlaves) && (1UL == RPC_MasterMsgCtx.isSlvAssoc)) {
                    retVal = RPC_SendToSlave(aHdl, &RPC_MasterMsgCtx.cmdMsg[msgIdx].slaveMsgHdl);
                    if (BCM_ERR_OK == retVal) {
                        (void)RPC_MemPushAppInfo(aHdl,msgIdx);
                        RPC_MasterMsgCtx.cmdMsg[msgIdx].reqNumResp++;
                    }
                }
                RPC_MasterMsgCtx.cmdMsg[msgIdx].cmdHdl = aHdl;
                if (0UL == cmdMsg->timeoutMs) {
                    RPC_MasterMsgCtx.cmdMsg[msgIdx].timeoutNs = RPC_DISABLE_TIMEOUT_VAL;
                } else {
                    RPC_MasterMsgCtx.cmdMsg[msgIdx].timeoutNs = BCM_GetTimeNs() + (cmdMsg->timeoutMs * 1000000ULL);
                }
                RPC_MasterMsgCtx.cmdMsg[msgIdx].subState = BCM_STATE_SUB_STATE_STAGE0;
            } else {
                /* Not found a matching group - generate error response */
                RPC_MasterMsgCtx.cmdMsg[msgIdx].cmdHdl = aHdl;
                RPC_MasterMsgCtx.cmdMsg[msgIdx].timeoutNs = RPC_DISABLE_TIMEOUT_VAL;
                RPC_MasterMsgCtx.cmdMsg[msgIdx].subState = BCM_STATE_SUB_STATE_STAGE0;
                RPC_MasterMsgCtx.cmdMsg[msgIdx].reqNumResp = 0;
                cmdMsg->response = BCM_ERR_NOSUPPORT;
                retVal = BCM_ERR_OK;
            }
        }
    }

    return retVal;
}

/** @brief RPC Master merge responses

    Function to merge the responses got from local subsystem and RPC slave

    @behavior Sync, Non-Reentrant

    @param[in]      aMsgIdx             Local interface context index of the command
                                        message for which response needs to
                                        be processed
    @param[in]      aOutMsg             Output message buffer
    @param[in]      aInMsg              Input message that needs to be merged

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Response merged successfully. Merged
                                        response can be delivered to client
    @retval     #BCM_ERR_NOT_FOUND      Current Response is processed.
                                        Awaiting further response/s.
    @retval     #BCM_ERR_UNKNOWN        Unknown failure

    @trace #BRCM_SWARCH_RPC_MASTERIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL

    @limitations None

    @code{.unparsed}
    RPC_MasterMsgType *msgCtxt = &RPC_MasterMsgCtx.cmdMsg[aMsgIdx]
    Copy the first response as-is into the output message buffer
    if (0UL == msgCtxt->curNumResp)
        BCM_MemCpy(aOutMsg->payload, aInMsg->payload, aInMsg->len)
        aOutMsg->len = aInMsg->len
        aOutMsg->response = aInMsg->response
        retVal = BCM_ERR_OK
#ifdef RPC_MASTER_ENABLE_IFC_SUPPORT
     else
        RPC_MemMsgType *tempMsg = &RPC_MasterMsgCtx.tempMsg
        Output message buffer may already have a response, copy into
        temporary memory before merging response
        BCM_MemCpy(tempMsg, aOutMsg, sizeof(RPC_MemMsgType))
        if (NULL != RPC_MasterIfcObjects[msgCtxt->objIdx]->server.mergeResult)
            retVal = RPC_MasterIfcObjects[msgCtxt->objIdx]->server.mergeResult(aOutMsg, tempMsg, aInMsg)
            if(BCM_ERR_OK != retVal)
                retVal = BCM_ERR_UNKNOWN
#endif
    msgCtxt->curNumResp++
    if (msgCtxt->curNumResp != msgCtxt->reqNumResp)
        If more responses are to be got, update error so that interface
        does not provide it to the RPC module
        retVal = BCM_ERR_NOT_FOUND
     else
        BCM_MemSet(msgCtxt, 0U, sizeof(RPC_MasterMsgType))
        RPC_MasterFreeMsg(aMsgIdx)
        retVal = BCM_ERR_OK
    return retVal
    @endcode
*/
static int32_t RPC_MasterMergeResponse(uint32_t aMsgIdx,
                                       RPC_MemMsgType *aOutMsg,
                                       RPC_MemMsgType *aInMsg)
{
    int32_t retVal = BCM_ERR_OK;
    RPC_MasterMsgType *msgCtxt = &RPC_MasterMsgCtx.cmdMsg[aMsgIdx];

    /* Copy the first response as-is into the output message buffer */
    if (0UL == msgCtxt->curNumResp) {
        BCM_MemCpy(aOutMsg->payload, aInMsg->payload, aInMsg->len);
        aOutMsg->len = aInMsg->len;
        aOutMsg->response = aInMsg->response;
        retVal = BCM_ERR_OK;
#ifdef RPC_MASTER_ENABLE_IFC_SUPPORT
    } else {
        RPC_MemMsgType *tempMsg = &RPC_MasterMsgCtx.tempMsg;
        /* Output message buffer may already have a response, copy into */
        /* temporary memory before merging response                     */
        BCM_MemCpy(tempMsg, aOutMsg, sizeof(RPC_MemMsgType));
        if (NULL != RPC_MasterIfcObjects[msgCtxt->objIdx]->server.mergeResult) {
            retVal = RPC_MasterIfcObjects[msgCtxt->objIdx]->server.mergeResult(
                                aInMsg->cmd,
                                aInMsg->len,
                                aOutMsg->payload, &aOutMsg->response,
                                tempMsg->payload, tempMsg->response,
                                aInMsg->payload, aInMsg->response);
            if(BCM_ERR_OK != retVal) {
                retVal = BCM_ERR_UNKNOWN;
                aOutMsg->response = retVal;
            }
        }
#endif
    }

    /* Increment the count of responses that are processed*/
    msgCtxt->curNumResp++;

    if (msgCtxt->curNumResp != msgCtxt->reqNumResp) {
        /* If more responses are to be got, update error so that interface */
        /* does not provide it to the RPC module                       */
        retVal = BCM_ERR_NOT_FOUND;
    } else {
        BCM_MemSet(msgCtxt, 0U, sizeof(RPC_MasterMsgType));
        RPC_MasterFreeMsg(aMsgIdx);
        retVal = BCM_ERR_OK;
    }

    return retVal;
}

/** @brief RPC Master fetch response from RPC slave

    Function which fetches the responses from RPC slave and merges
    the result when applicable.

    @behavior Sync, Non-Reentrant

    @param[out]    aOutHdl              Handle of Msg buffer
                                        Allocated newly for a ASYNC msg
                                        Updated with command Hdl for earlier
                                        received command

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Message fetched successfully
    @retval     #BCM_ERR_NOT_FOUND      No Message or it is to be processed fully
    @retval     #BCM_ERR_UNKNOWN        Unknown failure

    @trace #BRCM_SWARCH_RPC_MASTERIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL

    @limitations None

    @code{.unparsed}
    Check RPC slave for response/async messages
    retVal = RPC_RecvFromSlave(&respHdl)
    if (BCM_ERR_OK == retVal)
        respMsg = RPC_MsgGet(respHdl)
        if(NULL == respMsg)
            retVal = BCM_ERR_UNKNOWN
         else
            If it is an Async Msg, handle it
            if (0UL != (respMsg->cmd & BCM_CMD_ASYNC_MASK))
                retVal = RPC_MsgAlloc(aOutHdl)
                if(BCM_ERR_OK != retVal)
                    retVal = BCM_ERR_NOMEM
                 else
                    outMsg = RPC_MsgGet(*aOutHdl)
                    if(NULL == outMsg)
                        retVal = BCM_ERR_UNKNOWN
                     else
                        BCM_MemCpy(outMsg, respMsg, sizeof(RPC_MemMsgType))
                        retVal = BCM_ERR_OK
             else
                Check if the handle become stale because of timeout
                outMsg = RPC_MsgGet(appinfohdl)
                if(outMsg NULL)
                    return BCM_ERR_UNKNOWN
                else
                   Get the index of the local context of the message
                   retVal = RPC_MemPeekAppInfo(outMsg, &msgIdx)
                   if(retVal IS NOT BCM_ERR_OK)
                       return BCM_ERR_UNKNOWN
                   else
                        For special commands, invoke cmd_handler with response till ERR_OK
                        else, Handle Response Msg for regular commands
                        *aOutHdl = appinfohdl
                        Regular command response
                        retVal = RPC_MasterMergeResponse(msgIdx, outMsg, respMsg)
                        RPC_MemPopAppInfo(respHdl, &appinfohdl)
                else
                    return BCM_ERR_UNKNOWN

    return retVal

    @endcode
*/
static int32_t RPC_MasterProcessSlaveResponse(RPC_HdlType *aOutHdl)
{
    int32_t retVal;
    RPC_HdlType respHdl = RPC_HDL_INVALID;
    RPC_MemMsgType *respMsg = NULL;
    RPC_MemMsgType *outMsg = NULL;
    uint32_t msgIdx;
    RPC_HdlType srcHdl;

    /* Check RPC slave for response/async messages */
    retVal = RPC_RecvFromSlave(&respHdl, &srcHdl);
    if (BCM_ERR_OK == retVal) {
        respMsg = RPC_MsgGet(respHdl);
        if(NULL == respMsg) {
            retVal = BCM_ERR_UNKNOWN;
        } else {
            /* If it is an Async Msg */
            if (0UL != (respMsg->cmd & BCM_CMD_ASYNC_MASK)) {
#ifndef ENABLE_HOST_BUILD
                retVal = RPC_MsgAlloc(RPC_HDL_INVALID,
                                      RPC_MasterMsgCtx.peerId,
                                      RPC_MasterMsgCtx.selfId,
                                      RPC_MasterMsgCtx.assocId,
                                      aOutHdl);
                if(BCM_ERR_OK != retVal) {
                    retVal = BCM_ERR_NOMEM;
                } else {
                    outMsg = RPC_MsgGet(*aOutHdl);
                    if(NULL == outMsg) {
                        retVal = BCM_ERR_UNKNOWN;
                    } else {
                        BCM_MemCpy(outMsg, respMsg, sizeof(RPC_MemMsgType));
                        (void)RPC_Release(respHdl);
                        retVal = BCM_ERR_OK;
                    }
                }
#else
                uint32_t idx = 0UL;
                uint32_t forwardToHost = 0UL;
                for(idx = 0UL; idx < RPC_MASTER_MAX_OBJECTS; idx++) {
                    if((NULL != RPC_MasterIfcObjects[idx]) &&
                       (NULL != RPC_MasterIfcObjects[idx]->server.asyncMsg)) {
                        (void)RPC_MasterIfcObjects[idx]->server.asyncMsg(respMsg->cmd,
                                        (uint8_t*)respMsg, sizeof(respMsg), &forwardToHost);
                    }
                }
                (void)RPC_Release(respHdl);
                retVal = BCM_ERR_NOT_FOUND;
#endif
            } else {
                /* Check if the handle become stale */
                outMsg = RPC_MsgGet(srcHdl);
                if(NULL == outMsg) {
                    retVal = BCM_ERR_UNKNOWN;
                } else {
                    /* Get the index of the local context of the message */
                    retVal = RPC_MemPeekAppInfo(outMsg, &msgIdx);
                    if (BCM_ERR_OK != retVal) {
                        retVal = BCM_ERR_UNKNOWN;
                    } else {
                        /* Merge with Regular command response */
                        retVal = RPC_MasterMergeResponse(msgIdx, outMsg, respMsg);
                        if(BCM_ERR_OK == retVal) {
                            *aOutHdl = srcHdl;
                        }
                        (void)RPC_MemPopAppInfo(srcHdl, &msgIdx);
                        (void)RPC_Release(respHdl);
                    }
                }
            }
        }
    }
    return retVal;
}

/** @brief RPC Master process local response

    Function which fetches the responses from local susbsytem and merges
    the result when applicable.

    @behavior Sync, Non-Reentrant

    @param[out]    aOutHdl              Handle of Msg buffer
                                        Updated with command Hdl for earlier
                                        received command

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Message fetched successfully
    @retval     #BCM_ERR_NOT_FOUND      No Message or it is to be processed fully
    @retval     #BCM_ERR_UNKNOWN        Unknown failure

    @trace #BRCM_SWARCH_RPC_MASTERIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL

    @limitations None

    @code{.unparsed}
    for(msgIdx = 0UL msgIdx < RPC_MASTER_MAX_MSG msgIdx++)
        objIdx = RPC_MasterMsgCtx.cmdMsg[msgIdx].objIdx
        if((NULL != RPC_MasterIfcObjects[objIdx]) &&
           (RPC_MasterMsgCtx.cmdMsg[msgIdx].groupID ==
                                RPC_MasterIfcObjects[objIdx]->group) &&
                      (NULL != RPC_MasterIfcObjects[objIdx]->server.getResp)
                      (0UL != RPC_MasterMsgCtx.cmdMsg[msgIdx].handle))
            *aOutHdl = RPC_MasterMsgCtx.cmdMsg[msgIdx].cmdHdl
            tempMsg = RPC_MsgScratch()
            retVal = RPC_MasterIfcObjects[objIdx]->server.getStatus(
                          RPC_MasterMsgCtx.cmdMsg[msgIdx].handle,
                          RPC_MasterMsgCtx.cmdMsg[msgIdx].compID, &cmdID,
                          tempMsg->payload, &tempMsg->len)
            if(BCM_ERR_BUSY != retVal)
                tempMsg->response = retVal
                cmdMsg = RPC_MsgGet(*aOutHdl)
                if(NULL == cmdMsg)
                    retVal = BCM_ERR_UNKNOWN
                    break
                 else
                    Merge local response
                    retVal = RPC_MasterMergeResponse(msgIdx, cmdMsg, tempMsg)
                    break

    In case no response is got, update the error
    if (RPC_MASTER_MAX_MSG == msgIdx)
        retVal = BCM_ERR_NOT_FOUND
    return retVal
    @endcode
*/
static int32_t RPC_MasterProcessLocalResponse(RPC_HdlType *aOutHdl)
{
    int32_t retVal = BCM_ERR_NOT_FOUND;
    RPC_MemMsgType *tempMsg = NULL;
    RPC_MemMsgType *cmdMsg = NULL;
    uint32_t msgIdx;
    uint32_t objIdx;

    /* Check for responses from local susbsytem */
    for(msgIdx = 0UL; msgIdx < RPC_MASTER_MAX_MSG; msgIdx++) {
        /* If command is active */
        if (RPC_MasterMsgCtx.cmdMsg[msgIdx].subState > BCM_STATE_SUB_STATE_RESET) {
            objIdx = RPC_MasterMsgCtx.cmdMsg[msgIdx].objIdx;
            if((NULL != RPC_MasterIfcObjects[objIdx]) &&
               (RPC_MasterMsgCtx.cmdMsg[msgIdx].groupID ==
                                    RPC_MasterIfcObjects[objIdx]->group) &&
               (NULL != RPC_MasterIfcObjects[objIdx]->server.getResp) &&
               (0UL != RPC_MasterMsgCtx.cmdMsg[msgIdx].handle)) {

                *aOutHdl = RPC_MasterMsgCtx.cmdMsg[msgIdx].cmdHdl;
                tempMsg = RPC_MsgScratch();
                BCM_MemSet(tempMsg, 0U, sizeof(RPC_MemMsgType));

                retVal = RPC_MasterIfcObjects[objIdx]->server.getResp(
                              RPC_MasterMsgCtx.cmdMsg[msgIdx].handle,
                              RPC_MasterMsgCtx.cmdMsg[msgIdx].cmd, RPC_MEM_MSG_PAYLOAD_SZ,
                              tempMsg->payload, &tempMsg->len);
                if(BCM_ERR_BUSY != retVal) {
                    RPC_MasterMsgCtx.cmdMsg[msgIdx].handle = 0UL;
                    if (RPC_MasterMsgCtx.cmdMsg[msgIdx].curNumResp <
                                            RPC_MasterMsgCtx.cmdMsg[msgIdx].reqNumResp) {
                        tempMsg->magic = RPC_MEMMSG_MAGIC;
                        tempMsg->response = retVal;
                        tempMsg->cmd = RPC_MasterMsgCtx.cmdMsg[msgIdx].cmd;
                        cmdMsg = RPC_MsgGet(*aOutHdl);
                        if(NULL == cmdMsg) {
                            retVal = BCM_ERR_UNKNOWN;
                            break;
                        } else {
                            /* Merge local response */
                            retVal = RPC_MasterMergeResponse(msgIdx, cmdMsg, tempMsg);
                            break;
                        }
                    } else {
                        /* In case of a timeout, free up the local context after getting response from local subsystem */
                        BCM_MemSet(&RPC_MasterMsgCtx.cmdMsg[msgIdx], 0U, sizeof(RPC_MasterMsgType));
                        RPC_MasterFreeMsg(msgIdx);
                    }
                }
            } else if(0UL == RPC_MasterMsgCtx.cmdMsg[msgIdx].reqNumResp) {
                *aOutHdl = RPC_MasterMsgCtx.cmdMsg[msgIdx].cmdHdl;
                BCM_MemSet(&RPC_MasterMsgCtx.cmdMsg[msgIdx], 0U, sizeof(RPC_MasterMsgType));
                RPC_MasterFreeMsg(msgIdx);
                retVal = BCM_ERR_OK;
                break;
            } else {
                /* Do Nothing */
            }
        }
    }

    /* In case no response is got, update the error */
    if (RPC_MASTER_MAX_MSG == msgIdx) {
        retVal = BCM_ERR_NOT_FOUND;
    }

    return retVal;
}

/** @brief RPC Master interface for timing out Messages

    Internal function used to check whether commands have timed out

    @behavior Sync, Non-Reentrant

    @param[out]     RPC_HdlType     Handle to message that has timed out

    Return values are documented in reverse-chronological order
    @retval     void

    @trace #BRCM_SWARCH_RPC_MASTERIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL

    @limitations None

    @code{.unparsed}
    for (idx = 0UL; idx < RPC_MASTER_MAX_MSG; idx++)
        if ((0UL != (RPC_MasterMsgCtx.usageMask & (1U << idx))) &&
            (RPC_MasterMsgCtx.cmdMsg[idx].curNumResp !=
                                  RPC_MasterMsgCtx.cmdMsg[idx].reqNumResp))
            cmdMsg = RPC_MsgGet(RPC_MasterMsgCtx.cmdMsg[idx].cmdHdl)
            if(NULL != cmdMsg)
                if (RPC_MasterMsgCtx.cmdMsg[idx].timeoutNs < BCM_GetTimeNs())
                    cmdMsg->response = BCM_ERR_TIME_OUT
                    RPC_MasterMsgCtx.cmdMsg[idx].curNumResp =
                                            RPC_MasterMsgCtx.cmdMsg[idx].reqNumResp
                    cmdHandle = RPC_MasterMsgCtx.cmdMsg[idx].cmdHdl
                    if (RPC_HDL_INVALID != RPC_MasterMsgCtx.cmdMsg[idx].slaveMsgHdl)
                        (void)RPC_MemPeekAppInfo(cmdMsg, &msgIdx)
#ifdef RPC_MASTER_ENABLE_IFC_SUPPORT
                    if (NULL != RPC_MasterMsgCtx.cmdMsg[idx].hdr)
                        freeCmdCtxt = 0UL
#endif
                    if (1UL == freeCmdCtxt)
                        BCM_MemSet(&RPC_MasterMsgCtx.cmdMsg[idx], 0U, sizeof(RPC_MasterMsgType))
                        RPC_MasterFreeMsg(idx)
                    RPC_Release(RPC_MasterMsgCtx.cmdMsg[idx].slaveMsgHdl)
                    break
    return cmdHandle
    @endcode
*/
static RPC_HdlType RPC_MasterCheckCmdTimeout()
{
    uint32_t idx;
    uint32_t msgIdx;
    RPC_MemMsgType *cmdMsg = NULL;
    RPC_HdlType cmdHandle = RPC_HDL_INVALID;
    uint32_t freeCmdCtxt = 1UL;

    for (idx = 0UL; idx < RPC_MASTER_MAX_MSG; idx++) {
        if ((0UL == (RPC_MasterMsgCtx.usageMask & (1U << idx))) &&
            (RPC_MasterMsgCtx.cmdMsg[idx].curNumResp !=
                RPC_MasterMsgCtx.cmdMsg[idx].reqNumResp)) {
            cmdMsg = RPC_MsgGet(RPC_MasterMsgCtx.cmdMsg[idx].cmdHdl);
            if(NULL != cmdMsg) {
                if (RPC_MasterMsgCtx.cmdMsg[idx].timeoutNs < BCM_GetTimeNs()) {
                    cmdMsg->response = BCM_ERR_TIME_OUT;
                    RPC_MasterMsgCtx.cmdMsg[idx].curNumResp =
                                            RPC_MasterMsgCtx.cmdMsg[idx].reqNumResp;
                    cmdHandle = RPC_MasterMsgCtx.cmdMsg[idx].cmdHdl;
                    if (RPC_HDL_INVALID != RPC_MasterMsgCtx.cmdMsg[idx].slaveMsgHdl) {
                        /* For commands forwarded to slave, pop the locally added */
                        /* entry before sending response                          */
                        (void)RPC_MemPopAppInfo(cmdHandle, &msgIdx);
                    }
                    /* Free up the cloned handle of slave */
                    RPC_Release(RPC_MasterMsgCtx.cmdMsg[idx].slaveMsgHdl);
#ifdef RPC_MASTER_ENABLE_IFC_SUPPORT
                    if (0UL != RPC_MasterMsgCtx.cmdMsg[idx].handle) {
                        /* MsgQ msg Header in context is needed to pick response */
                        /* from the local subsystem. Context needs to be freed   */
                        /* only after getting response from MsgQ server          */
                        freeCmdCtxt = 0UL;
                    }
#endif
                    if (1UL == freeCmdCtxt) {
                        BCM_MemSet(&RPC_MasterMsgCtx.cmdMsg[idx], 0U, sizeof(RPC_MasterMsgType));
                        RPC_MasterFreeMsg(idx);
                    }
                    break;
                }
            }
        }
    }
    return cmdHandle;
}

/** @brief RPC Master interface Receive Message

    Interface function used to receive status.

    @behavior Sync, Non-Reentrant

    @param[out]     aHdl            Handle to received message

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK         Message received successfully and copied
    @retval     #BCM_ERR_BUSY       Command is still being processed
    @retval     #BCM_ERR_NOMEM      Cannot Get the status because of no Memory
    @retval     #BCM_ERR_UNKNOWN    Unknown failure

    @trace #BRCM_SWARCH_RPC_MASTERIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL

    @limitations None

    @code{.unparsed}
#ifdef RPC_MASTER_ENABLE_IFC_SUPPORT
    RPC_MsgAlloc(RPC_HDL_INVALID, RPC_MasterMsgCtx.peerId, RPC_MasterMsgCtx.selfId,
                          RPC_MasterMsgCtx.assocId, &outHdl);
    if retVal is BCM_ERR_OK
        cmdMsg = RPC_MsgGet(outHdl);
        if cmdMsg is NULL
            RPC_Release(outHdl);
            outHdl = RPC_HDL_INVALID;
            retVal = BCM_ERR_UNKNOWN;
        else
            for (objIdx = 0UL; objIdx < RPC_MASTER_DBG_MSG_COUNT; objIdx++)
                retVal = BCM_GetError(&RPC_MasterMsgCtx.dbgMsgs[objIdx]);
                if (BCM_ERR_OK != retVal)
                    break;
            if objIdx > 0UL
                cmdMsg->cmd = BCM_ASYNCID(BCM_GROUPID_IMGL, BCM_RSV_ID, RPC_CMDIDVAL_DEBUG);
                cmdMsg->len = sizeof(BCM_DbgMsgType) * objIdx;
                cmdMsg->rsvd = FALSE;
                BCM_MemCpy(cmdMsg->payload, RPC_MasterMsgCtx.dbgMsgs, cmdMsg->len);
                retVal = BCM_ERR_OK;
            else
                RPC_Release(outHdl);
                outHdl = RPC_HDL_INVALID;
                retVal = BCM_ERR_NOT_FOUND;

    Check if there are any ASYNC messages to be sent to Host
    if retVal is not BCM_ERR_OK
        asyncMsgQ = RPC_GetAsyncMsgQ()
        if(NULL != asyncMsgQ)
            retVal = MSGQ_GetMsgIdx(asyncMsgQ, &objIdx)
            if(BCM_ERR_OK == retVal)
                retVal = RPC_MsgAlloc(RPC_HDL_INVALID,
                                      RPC_MasterMsgCtx.peerId, RPC_MasterMsgCtx.selfId,
                                       RPC_MasterMsgCtx.assocId,
                                       &outHdl))
                if(BCM_ERR_OK != retVal)
                    retVal = BCM_ERR_NOMEM
                 else
                    cmdMsg = RPC_MsgGet(outHdl)
                    if(NULL == cmdMsg)
                        retVal = BCM_ERR_UNKNOWN
                     else
                        asyncMsg = &RPC_MasterAsyncMsgFromQ[objIdx]
                        BCM_MemCpy(cmdMsg->payload, asyncMsg->payLoad, asyncMsg->payLoadSize)
                        cmdMsg->cmd = asyncMsg->cmd
                        cmdMsg->len = asyncMsg->payLoadSize
                        cmdMsg->rsvd1[0] = TRUE
                        retVal = MSGQ_CompleteMsgIdx(asyncMsgQ, objIdx)
#endif

    Only if there is no ASYNC message to be sent, then process responses
    if (BCM_ERR_OK != retVal)
        Check RPC slave for response/async messages
        retVal = RPC_MasterProcessSlaveResponse(&outHdl)
#ifdef RPC_MASTER_ENABLE_IFC_SUPPORT
        if (BCM_ERR_OK != retVal)
            Check local subsystem for responses
            retVal = RPC_MasterProcessLocalResponse(&outHdl)
#endif
    if(BCM_ERR_OK == retVal)
        *aHdl = outHdl
    return retVal
    @endcode
*/
static int32_t RPC_MasterRecvMsg(RPC_HdlType* const aHdl)
{
    int32_t     retVal = BCM_ERR_NOT_FOUND;
    RPC_HdlType outHdl = RPC_HDL_INVALID;

    /*
        On target, we check if there are any info/error msgs to be sent to host
        If there is no info/error messages to be sent, Check for async msgs to be sent to host
        If there is no ASYNC message to be sent, then process responses
        Fetch response from RPC slave
            Handle if its an async from connected slaves
            if its a response, then match it to CMD in interface context
            process/merge the response
        On target, check for response from local subsystem
            process/merge the response
    */
#ifdef RPC_MASTER_ENABLE_IFC_SUPPORT
    RPC_LocalMsgType *asyncMsg;
    const MSGQ_Type *asyncMsgQ;
    RPC_MemMsgType *cmdMsg;
    uint32_t  objIdx;

    retVal = RPC_MsgAlloc(RPC_HDL_INVALID, RPC_MasterMsgCtx.peerId, RPC_MasterMsgCtx.selfId,
                          RPC_MasterMsgCtx.assocId, &outHdl);
    if (BCM_ERR_OK == retVal) {
        cmdMsg = RPC_MsgGet(outHdl);
        if(NULL == cmdMsg) {
            RPC_Release(outHdl);
            outHdl = RPC_HDL_INVALID;
            retVal = BCM_ERR_UNKNOWN;
        } else {
            for (objIdx = 0UL; objIdx < RPC_MASTER_DBG_MSG_COUNT; objIdx++) {
                retVal = BCM_GetError(&RPC_MasterMsgCtx.dbgMsgs[objIdx]);
                if (BCM_ERR_OK != retVal) {
                    break;
                }
            }
            if (objIdx > 0UL) {
                cmdMsg->cmd = BCM_ASYNCID(BCM_GROUPID_IMGL, BCM_RSV_ID, RPC_CMDIDVAL_DEBUG);
                cmdMsg->len = sizeof(BCM_DbgMsgType) * objIdx;
                cmdMsg->rsvd = FALSE;
                BCM_MemCpy(cmdMsg->payload, RPC_MasterMsgCtx.dbgMsgs, cmdMsg->len);
                retVal = BCM_ERR_OK;
            } else {
                RPC_Release(outHdl);
                outHdl = RPC_HDL_INVALID;
                retVal = BCM_ERR_NOT_FOUND;
            }
        }
    }

    /* Check if there are any ASYNC messages to be sent to Host */
    if (BCM_ERR_OK != retVal) {
        asyncMsgQ = RPC_GetAsyncMsgQ();
        if(NULL != asyncMsgQ) {
            retVal = MSGQ_GetMsgIdx(asyncMsgQ, &objIdx);
            if(BCM_ERR_OK == retVal) {
                retVal = RPC_MsgAlloc(RPC_HDL_INVALID,
                                      RPC_MasterMsgCtx.peerId, RPC_MasterMsgCtx.selfId,
                                      RPC_MasterMsgCtx.assocId,
                                      &outHdl);
                if(BCM_ERR_OK != retVal) {
                    retVal = BCM_ERR_NOMEM;
                } else {
                    cmdMsg = RPC_MsgGet(outHdl);
                    if(NULL == cmdMsg) {
                        retVal = BCM_ERR_UNKNOWN;
                    } else {
                        asyncMsg = &RPC_MasterAsyncMsgFromQ[objIdx];
                        BCM_MemCpy(cmdMsg->payload, asyncMsg->payLoad, asyncMsg->payLoadSize);
                        cmdMsg->cmd = asyncMsg->cmd;
                        cmdMsg->len = asyncMsg->payLoadSize;
                        cmdMsg->rsvd = FALSE;
                        retVal = MSGQ_CompleteMsgIdx(asyncMsgQ, objIdx);
                    }
                }
            }
        }
    }
#endif

    /* Only if there is no ASYNC message to be sent, then process responses */
    if (BCM_ERR_OK != retVal) {
        /* Check RPC slave for response/async messages */
        retVal = RPC_MasterProcessSlaveResponse(&outHdl);
        if (BCM_ERR_OK != retVal) {
            /* Check local subsystem for responses */
            retVal = RPC_MasterProcessLocalResponse(&outHdl);
        }
        if (BCM_ERR_OK != retVal) {
            /* Check if any command has timed out */
            outHdl = RPC_MasterCheckCmdTimeout();
            if (RPC_HDL_INVALID != outHdl) {
                retVal = BCM_ERR_OK;
            }
        }
    }

    if(BCM_ERR_OK == retVal) {
        *aHdl = outHdl;
    }

    return retVal;
}

#ifdef RPC_MASTER_ENABLE_IFC_SUPPORT
/** @brief Send Async Messages to Host

    This API queues the Async Messages to Host

    @trace #BRCM_SWARCH_RPC_ASYNCEVENTTOHOST_PROC
    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL

    @code{.unparsed}
    int32_t retVal
    RPC_LocalMsgType asyncMsg
    const MSGQ_Type *asyncMsgQ

    asyncMsgQ = RPC_GetAsyncMsgQ()
    if ((NULL == asyncMsgQ) &&
        ((0UL != aLen) && (NULL == aBuff)))
        retVal = BCM_ERR_INVAL_PARAMS
    else
        asyncMsg.cmd = BCM_ASYNCID(aGrpID, aCompID, aCmdID)
        asyncMsg.payLoadSize = aLen
        BCM_MemCpy(asyncMsg.payLoad, aBuff, aLen)
        retVal = MSGQ_SendMsg(asyncMsgQ, &asyncMsg,
                              MSGQ_NO_CLIENTMASK, NULL)
    return retVal
    @endcode
*/
int32_t RPC_AsyncEventToHost(BCM_GroupIDType aGrpID,
                             BCM_CompIDType aCompID,
                             uint8_t aCmdID,
                             const uint8_t *const aBuff,
                             uint32_t aLen)
{
    int32_t retVal;
    const MSGQ_Type *asyncMsgQ = RPC_GetAsyncMsgQ();

    if ((NULL == asyncMsgQ) ||
        ((0UL != aLen) && (NULL == aBuff))) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (aLen > RPC_MEM_MSG_PAYLOAD_SZ) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        RPC_LocalMsgType asyncMsg = {0};
        asyncMsg.cmd = BCM_ASYNCID(aGrpID, aCompID, aCmdID);
        asyncMsg.payLoadSize = aLen;
        BCM_MemCpy(asyncMsg.payLoad, aBuff, aLen);
        retVal = MSGQ_SendMsg(asyncMsgQ, &asyncMsg,
                              MSGQ_NO_CLIENTMASK, NULL);
    }

    return retVal;
}
#endif

/** @brief RPC Master interface Process


    @behavior Sync, Non-Reentrant

    @param[in]      void

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             No Errors found
    @retval     #BCM_ERR_TIME_OUT       Connection timed out
    @retval     #BCM_ERR_UNKNOWN        Unknown failure

    @trace #BRCM_SWARCH_RPC_MASTERIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL

    @limitations None

    @code{.unparsed}
    @endcode
*/
static int32_t RPC_MasterProcess(void)
{
    return BCM_ERR_OK;
}

#ifdef ENABLE_RPC_MASTER_STREAM_SUPPORT
/** @brief RPC Master interface Detect Stream request

    Interface function to detect new stream requests
    Unknown failures may be recovered only with deinit and init.

    @behavior Sync, Non-Reentrant

    @param[out]     aHdl            New Handle

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Detected new stream
    @retval     #BCM_ERR_EAGAIN         Detected New stream, call again for more detections
    @retval     #BCM_ERR_NOT_FOUND      No New streams detected
    @retval     #BCM_ERR_UNKNOWN        Unknown failure

    @trace #BRCM_SWARCH_RPC_MASTERIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL

    @limitations None

    @code{.unparsed}
    RPC_StrmCfgType cfg
    RPC_MsgQLoaderQ = RPC_GetLoaderMsgQ();
        if(NULL!= RPC_MsgQLoaderQ)
        for(i=0; i<RPC_MASTER_LOAD_MSG_MAX; i++)
            MSGQ_GetMsgIdx(RPC_MsgQLoaderQ, &idx)
            loadImg = &RPC_MasterImgLoadMsg[idx]
            retVal = BCM_ERR_UNKNOWN
            if(BCM_ERR_CUSTOM == loadImg->result)
                if(RPC_MASTERLOAD_PTBL_REQ == loadImg->fetchCmd)
                    cfg.xferSize = sizeof(PTBL_Type)
                else
                    cfg.xferSize = loadImg->inLen

                if(cfg.xferSize > loadImg->inLen)
                    loadImg->result = BCM_ERR_INVAL_PARAMS
                    MSGQ_CompleteMsgIdx(RPC_MsgQLoaderQ, idx)
                else
                    Prepare the config(pid,imgId, offset, isTbl, xferSize) and send to stream alloc
                    cfg.pid = (loadMsg->pid & PTBL_ID_TYPE_MASK)
                    cfg.imgId = loadMsg->imgID
                    cfg.offset = loadMsg->imgOffset
                    cfg.isTbl = loadMsg->fetchCmd
                    if(RPC_MASTERLOAD_ITBL_REQ == loadMsg->fetchCmd)
                        cfg.isTbl = TRUE
                        cfg.partial = FALSE
                    else
                        cfg.isTbl = FALSE;
                        if(PTBL_ID_BL == loadMsg->pid)
                            cfg.partial = FALSE
                        else
                            cfg.partial = TRUE
                    RPC_StrmAlloc(&cfg,RPC_MOD_CHAN_MSGQ,RPC_IFC_CHAN_MODE_MASTER,&hdl)
                    if(BCM_ERR_OK == retVal)
                        loadMsg->result = BCM_ERR_BUSY
                        break
    @endcode
*/
static int32_t RPC_MasterDetectStrm(RPC_HdlType* const  aHdl)
{

    uint32_t  i = 0UL;
    uint32_t  idx = 0UL;
    int32_t   retVal = BCM_ERR_UNKNOWN;
    RPC_HdlType hdl;
    RPC_MasterLoadReqType *loadMsg;
    RPC_StrmCfgType cfg;
    const MSGQ_Type *RPC_MsgQLoaderQ;
    RPC_InterfaceIdType slaveIdx;
    BCM_MemSet(&cfg, 0U, sizeof(RPC_StrmCfgType));

    RPC_MsgQLoaderQ = RPC_GetLoaderMsgQ();
    if(NULL!= RPC_MsgQLoaderQ) {
        for(i=0; i<RPC_MASTER_LOAD_MSG_MAX; i++) {
            retVal = MSGQ_GetMsgIdx(RPC_MsgQLoaderQ, &idx);
            if(BCM_ERR_OK == retVal) {
                loadMsg = &RPC_MasterImgLoadMsg[idx];
                retVal = BCM_ERR_UNKNOWN;
                if(BCM_ERR_CUSTOM == loadMsg->result) {
                    if(RPC_MASTERLOAD_PTBL_REQ == loadMsg->fetchCmd) {
                        cfg.xferSize = sizeof(PTBL_Type);
                    } else {
                        cfg.xferSize = loadMsg->inLen;
                    }

                    slaveIdx = RPC_GetSlaveIfcIdx(RPC_MasterIfc.assoc, RPC_MasterImgHandler.channel[loadMsg->channel]);
                    if((cfg.xferSize > loadMsg->inLen) ||
                        (RPC_INTERFACEID_MAX == slaveIdx)) {
                        loadMsg->result = BCM_ERR_INVAL_PARAMS;
                        retVal = MSGQ_CompleteMsgIdx(RPC_MsgQLoaderQ, idx);
                    } else {
                        cfg.pid = (loadMsg->pid & PTBL_ID_TYPE_MASK);
                        cfg.imgId = loadMsg->imgID;
                        cfg.offset = loadMsg->imgOffset;
                        if(RPC_MASTERLOAD_ITBL_REQ == loadMsg->fetchCmd) {
                            cfg.isTbl = TRUE;
                            cfg.partial = FALSE;
                        } else {
                            cfg.isTbl = FALSE;
                            if(PTBL_ID_BL == loadMsg->pid) {
                                cfg.partial = FALSE;
                            } else {
                                cfg.partial = TRUE;
                            }
                        }
                        retVal = RPC_StrmAlloc(&cfg, slaveIdx,
                                               RPC_MasterMsgCtx.selfId,
                                               RPC_MasterMsgCtx.assocId,
                                               &hdl);
                        if(BCM_ERR_OK == retVal) {
                            loadMsg->result = BCM_ERR_BUSY;
                            if (0UL == RPC_MasterMsgCtx.strmTimeoutMs) {
                                loadMsg->streamTimeout = RPC_DISABLE_TIMEOUT_VAL;
                            } else {
                                loadMsg->streamTimeout = BCM_GetTimeNs() + (RPC_MasterMsgCtx.strmTimeoutMs * 1000000ULL);
                            }
                            *aHdl = hdl;
                            break;
                        } else {
                            break;
                        }
                    }
                }
            }
        }
    }

    return retVal;
}

/** @brief RPC Master interface Process Stream

    @trace #BRCM_SWARCH_RPC_MASTERIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL

    @code{.unparsed}
    retVal = MSGQ_GetMsgIdx(RPC_GetLoaderMsgQ(), &idx)
    if(BCM_ERR_OK == retVal)
        loadMsg = &RPC_MasterImgLoadMsg[idx]
        (void)RPC_StrmGetCfg(aHdl, &strmCfg)
        (void)RPC_StrmGetFilledSz(aHdl, &rdSize, &currOffset)
        if (0UL < rdSize)
            retVal = RPC_StrmRead(aHdl, loadMsg->imgLoadAddrBuf+currOffset, rdSize, &outSize)
            if(retVal == BCM_ERR_OK)
                loadMsg->result = retVal
                isCompleteMsg = 1UL
             else if ((retVal == BCM_ERR_NOMEM) || (retVal == BCM_ERR_BUSY))
                if (0UL == RPC_MasterMsgCtx.strmTimeoutMs)
                    loadMsg->streamTimeout = RPC_DISABLE_TIMEOUT_VAL
                 else
                    loadMsg->streamTimeout = BCM_GetTimeNs() + (RPC_MasterMsgCtx.strmTimeoutMs * 1000000ULL)
                retVal = BCM_ERR_BUSY
             else
                loadMsg->result = BCM_ERR_NOT_FOUND
                retVal = BCM_ERR_UNKNOWN
                isCompleteMsg = 1UL
         else if (currOffset == strmCfg.xferSize)
            loadMsg->result = BCM_ERR_OK
            isCompleteMsg = 1UL
         else if ((BCM_STATE_SUB_STATE_DONE == aPeerState) ||
                   (loadMsg->streamTimeout < BCM_GetTimeNs()))
            loadMsg->result = BCM_ERR_TIME_OUT
            retVal = BCM_ERR_OK
            isCompleteMsg = 1UL
         else
            retVal = BCM_ERR_BUSY
    if (1UL == isCompleteMsg)
        masterInfo->state = BCM_STATE_SUB_STATE_DONE
        (void)RPC_StrmGetFilledSz(aHdl, &rdSize, &loadMsg->filledSize)
        (void)MSGQ_CompleteMsgIdx(RPC_GetLoaderMsgQ(), idx)
    return retVal
    @endcode
*/
static int32_t RPC_MasterProcessStrm(RPC_HdlType aHdl, BCM_SubStateType aPeerState)
{
    uint32_t idx = 0UL;
    uint32_t rdSize;
    uint32_t currOffset = 0UL;
    uint32_t outSize;
    uint32_t isCompleteMsg = 0UL;
    int32_t  retVal = BCM_ERR_UNKNOWN;
    RPC_StrmCfgType strmCfg;
    RPC_MasterLoadReqType *loadMsg;
    RPC_MemStrmClientInfoType *masterInfo = RPC_StrmGetMasterClientInfo(aHdl);

    retVal = MSGQ_GetMsgIdx(RPC_GetLoaderMsgQ(), &idx);
    if(BCM_ERR_OK == retVal) {
        loadMsg = &RPC_MasterImgLoadMsg[idx];
        BCM_MemSet(&strmCfg, 0U, sizeof(RPC_StrmCfgType));
        (void)RPC_StrmGetCfg(aHdl, &strmCfg);
        (void)RPC_StrmGetFilledSz(aHdl, &rdSize, &currOffset);
        if (0UL < rdSize) {
            retVal = RPC_StrmRead(aHdl, loadMsg->imgLoadAddrBuf+currOffset, rdSize, &outSize);
            if(retVal == BCM_ERR_OK) {
                loadMsg->result = retVal;
                isCompleteMsg = 1UL;
            } else if ((retVal == BCM_ERR_NOMEM) || (retVal == BCM_ERR_BUSY)) {
                if (0UL == RPC_MasterMsgCtx.strmTimeoutMs) {
                    loadMsg->streamTimeout = RPC_DISABLE_TIMEOUT_VAL;
                } else {
                    loadMsg->streamTimeout = BCM_GetTimeNs() + (RPC_MasterMsgCtx.strmTimeoutMs * 1000000ULL);
                }
                retVal = BCM_ERR_BUSY;
            } else {
                loadMsg->result = BCM_ERR_NOT_FOUND;
                retVal = BCM_ERR_UNKNOWN;
                isCompleteMsg = 1UL;
            }
        } else if (currOffset == strmCfg.xferSize) {
            loadMsg->result = BCM_ERR_OK;
            isCompleteMsg = 1UL;
        } else if ((BCM_STATE_SUB_STATE_DONE == aPeerState) ||
                   (loadMsg->streamTimeout < BCM_GetTimeNs())) {
            loadMsg->result = BCM_ERR_TIME_OUT;
            retVal = BCM_ERR_OK;
            isCompleteMsg = 1UL;
        } else {
            retVal = BCM_ERR_BUSY;
        }
    }

    if (1UL == isCompleteMsg) {
        masterInfo->state = BCM_STATE_SUB_STATE_DONE;
        (void)RPC_StrmGetFilledSz(aHdl, &rdSize, &loadMsg->filledSize);
        (void)MSGQ_CompleteMsgIdx(RPC_GetLoaderMsgQ(), idx);
    }
    return retVal;
}
#endif

/** @brief RPC Master interface Disconnect

    Disconnect any active connecion, and perform any coneection related cleanup.
    Interface should accept new connection requests after this API call.
    Unknown failures may be recovered only with deinit and init.

    @behavior Sync, Non-Reentrant

    @param[in]      void

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Disconnection successful
    @retval     #BCM_ERR_UNKNOWN        Unknown failure

    @trace #BRCM_SWARCH_RPC_MASTERIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL

    @limitations None

    @code{.unparsed}
    @endcode
*/
static int32_t RPC_MasterDisconnect(void)
{
    return BCM_ERR_OK;
}

/** @brief RPC Master interface channel de-initialization

    This API used to deinitialize the Message Queue Master interface

    @behavior Sync, Non-Reentrant

    @param[in]      void

    @retval void

    @trace #BRCM_SWARCH_RPC_MASTERIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL

    @limitations None

    @code{.unparsed}
        memset RPC_MasterImgLoadMsg
        memset RPC_MasterMsgCtx
        Set the usageMask
    @endcode
*/
static void RPC_MasterDeinit(void)
{
    uint32_t i;
#ifdef ENABLE_RPC_MASTER_STREAM_SUPPORT
    BCM_MemSet(RPC_MasterImgLoadMsg, 0U, (RPC_MASTER_LOAD_MSG_MAX * sizeof(RPC_MasterLoadReqType)));
#endif
    BCM_MemSet(&RPC_MasterMsgCtx, 0U, sizeof(RPC_MasterMsgCtxType));
    for(i=0; i<RPC_MASTER_MAX_MSG; i++){
        RPC_MasterMsgCtx.usageMask |= (1UL << i);;
    }
}

#ifdef ENABLE_RPC_MASTER_STREAM_SUPPORT
/** @brief Request to fetch an image

    @behavior Async, Re-entrant

    @pre None

    @param[in]      aChannel    Loader Channel ID
    @param[in]      aPID        Partition ID
    @param[in]      aImgID      16-bit Image ID
    @param[in]      aImgAddr    32-bit address for Flash kind of modules
    @param[out]     aAddr       Address where image shall be loaded
    @param[in]      aOffset     Offset, within the image, from where to load
    @param[in]      aBufSize    Size of the image
    @param[in]      aClientMask Client event mask
    @param[out]     aHdr        message handle from server.

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Request to Load image is accepted and
                                        shall be processed asynchronously.
    @retval     #BCM_ERR_BUSY           Queue is full
    @retval     #BCM_ERR_UNKNOWN        Unknown error
    @retval     #BCM_ERR_INVAL_PARAMS   aStatus is NULL or
                                        aBufSize is NULL or
                                        aAddr is NULL
                                        aHdr is NULL

    @post None

    @trace #BRCM_SWARCH_RPC_MASTERIMGHANDLER_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL

    @code{.unparsed}
    RPC_MsgQLoaderQ = RPC_GetLoaderMsgQ()
    if (aAddr IS NULL) OR (aHdr IS NULL)
           OR (aBufSize IS 0UL) OR (RPC_MsgQLoaderQ IS NULL)
        return BCM_ERR_INVAL_PARAMS
    else
        loadMsg.pid =  aPID
        loadMsg.imgID = aImgID
        loadMsg.imgLoadAddrBuf = aAddr
        loadMsg.imgOffset = aOffset
        loadMsg.inLen = aBufSize
        loadMsg.result = BCM_ERR_CUSTOM
        loadMsg.fetchCmd = RPC_MASTERLOAD_IMAGE_REQ
        loadMsg.filledSize = 0UL
        retVal = MSGQ_SendMsg(RPC_MsgQLoaderQ, &loadMsg, aClientMask, aHdr)
            return retVal

    @endcode
*/
static int32_t RPC_MasterLoadImg(IMGL_ChannelIdxType aChannel,
                              PTBL_IdType aPID,
                              uint16_t aImgID,
                              uint32_t aImgAddr,
                              uint8_t* const aAddr,
                              uint32_t aOffset,
                              uint32_t aBufSize,
                              const uint32_t aClientMask,
                              const MSGQ_MsgHdrType** const aHdr)
{
    int32_t retVal;
    RPC_MasterLoadReqType loadMsg;
    const MSGQ_Type *RPC_MsgQLoaderQ;

    RPC_MsgQLoaderQ = RPC_GetLoaderMsgQ();
    if ((NULL == aAddr) || (NULL ==aHdr)
               || (0UL == aBufSize) || (NULL== RPC_MsgQLoaderQ)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        loadMsg.pid =  aPID;
        loadMsg.imgID = aImgID;
        loadMsg.imgLoadAddrBuf = aAddr;
        loadMsg.imgOffset = aOffset;
        loadMsg.inLen = aBufSize;
        loadMsg.result = BCM_ERR_CUSTOM;
        loadMsg.fetchCmd = RPC_MASTERLOAD_IMAGE_REQ;
        loadMsg.filledSize = 0UL;
        loadMsg.channel = aChannel;
        retVal = MSGQ_SendMsg(RPC_MsgQLoaderQ, &loadMsg, aClientMask, aHdr);
    }

    return retVal;
}

/** @brief Fetch Partition Table

    @behavior Sync, Non-reentrant

    @pre Loader is configured

    @param[in]       aChannel            Loader Channel ID
    @param[out]      aDownloadAddress    Download area address
    @param[in]       aMaxSize            Download area size
    @param[in]       aClientMask         Client event mask
    @param[out]      aHdr                message handle from server.

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Success
    @retval     #BCM_ERR_TIME_OUT       Timeout occurred
    @retval     #BCM_ERR_NODEV          Channel does not exist
    @retval     #BCM_ERR_INVAL_PARAMS   (aDownloadAddress is NULL) or

    @post Loader is configured

    @trace #BRCM_SWARCH_RPC_MASTERIMGHANDLER_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL

    @code{.unparsed}
    RPC_MsgQLoaderQ = RPC_GetLoaderMsgQ()
    if (aDownloadAddress IS NULL) OR (aHdr IS NULL)
             OR (aMaxSize IS 0UL) OR (RPC_MsgQLoaderQ IS NULL)
        return BCM_ERR_INVAL_PARAMS
    else
        loadMsg.pid = 0xFFU
        loadMsg.imgID = 0U
        loadMsg.imgLoadAddrBuf = aDownloadAddress
        loadMsg.imgOffset = 0UL
        loadMsg.inLen = aMaxSize
        loadMsg.result = BCM_ERR_CUSTOM
        loadMsg.fetchCmd = RPC_MASTERLOAD_PTBL_REQ
        loadMsg.filledSize = 0UL
        retVal = MSGQ_SendMsg(RPC_MsgQLoaderQ, &loadMsg, aClientMask, aHdr)
            return retVal
    @endcode
*/

static int32_t RPC_MasterReadPTBL(IMGL_ChannelIdxType aChannel,
                     uint32_t aDevAddr,
                     uint8_t *aDownloadAddress,
                     uint32_t aMaxSize,
                     const uint32_t aClientMask,
                     const MSGQ_MsgHdrType** const aHdr)
{
    int32_t retVal;
    RPC_MasterLoadReqType loadMsg;
    const MSGQ_Type *RPC_MsgQLoaderQ;

    RPC_MsgQLoaderQ = RPC_GetLoaderMsgQ();
    if ((NULL == aDownloadAddress) || (NULL == aHdr)
            || (0UL == aMaxSize) || (NULL== RPC_MsgQLoaderQ)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        loadMsg.pid = 0xFFU;
        loadMsg.imgID = 0U;
        loadMsg.imgLoadAddrBuf = aDownloadAddress;
        loadMsg.imgOffset = 0UL;
        loadMsg.inLen = aMaxSize;
        loadMsg.result = BCM_ERR_CUSTOM;
        loadMsg.fetchCmd = RPC_MASTERLOAD_PTBL_REQ;
        loadMsg.filledSize = 0UL;
        loadMsg.channel = aChannel;
        retVal = MSGQ_SendMsg(RPC_MsgQLoaderQ, &loadMsg, aClientMask, aHdr);
    }

    return retVal;
}

/** @brief Fetch Image Table

    @behavior Sync, Non-reentrant

    @pre loader is configured

    @param[in]       aChannel            Loader Channel ID
    @param[in]       aPartID             Partition ID
    @param[in]       aITBLAddress        ITBL address fetched from PTBL
    @param[out]      aDownloadAddress    Download area address
    @param[in]       aMaxSize            Download area size
    @param[in]       aClientMask         Client event mask
    @param[out]      aHdr                message handle from server.

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Success
    @retval     #BCM_ERR_TIME_OUT       Timeout occurred
    @retval     #BCM_ERR_NODEV          Channel does not exist
    @retval     #BCM_ERR_INVAL_PARAMS   (aDownloadAddress is NULL) or
                                        (aHdr is NULL)
    @post loader is configured

    @trace #BRCM_SWARCH_RPC_MASTERIMGHANDLER_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL

    @code{.unparsed}
    RPC_MsgQLoaderQ = RPC_GetLoaderMsgQ()
    if (aDownloadAddress IS NULL) OR (aHdr IS NULL)
              OR (aMaxSize IS 0UL) OR (RPC_MsgQLoaderQ is NULL)
        return BCM_ERR_INVAL_PARAMS
    else
        loadMsg.pid = aPartID
        loadMsg.imgID = 0U
        loadMsg.imgLoadAddrBuf = aDownloadAddress
        loadMsg.imgOffset = 0UL
        loadMsg.inLen = aMaxSize
        loadMsg.result = BCM_ERR_CUSTOM
        loadMsg.fetchCmd = RPC_MASTERLOAD_ITBL_REQ
        loadMsg.filledSize = 0UL
        retVal = MSGQ_SendMsg(RPC_MsgQLoaderQ, &loadMsg, aClientMask, aHdr)
    @endcode
*/
static int32_t RPC_MasterReadITBL(IMGL_ChannelIdxType aChannel,
                      PTBL_IdType aPartID,
                      uint32_t aITBLAddress,
                      uint8_t *aDownloadAddress,
                      uint32_t aMaxSize,
                      const uint32_t aClientMask,
                      const MSGQ_MsgHdrType** const aHdr)
{
    int32_t retVal;
    RPC_MasterLoadReqType loadMsg;
    const MSGQ_Type *RPC_MsgQLoaderQ;

    RPC_MsgQLoaderQ = RPC_GetLoaderMsgQ();
    if ((NULL == aDownloadAddress) || (NULL == aHdr)
             || (0UL == aMaxSize) || (NULL== RPC_MsgQLoaderQ)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        loadMsg.pid = aPartID;
        loadMsg.imgID = 0U;
        loadMsg.imgLoadAddrBuf = aDownloadAddress;
        loadMsg.imgOffset = 0UL;
        loadMsg.inLen = aMaxSize;
        loadMsg.result = BCM_ERR_CUSTOM;
        loadMsg.fetchCmd = RPC_MASTERLOAD_ITBL_REQ;
        loadMsg.filledSize = 0UL;
        loadMsg.channel = aChannel;
        retVal = MSGQ_SendMsg(RPC_MsgQLoaderQ, &loadMsg, aClientMask, aHdr);
    }

    return retVal;
}

/** @brief Get the status of Read/Erase/Write request

    @behavior Sync, Re-entrant

    @pre None

    @param[in]   aHdr               Message Handle
    @param[out]  aProcessedSize     Filled/Written size

    @return     #BCM_ERR_OK             Fetch/Write completed successfully
    @return     #BCM_ERR_BUSY           Fetch/Write is in progress

    @post TBD

    @trace #BRCM_SWARCH_RPC_MASTERIMGHANDLER_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL

    @limitations This API shall be called from the task context.

    @code{.unparsed}
    RPC_MsgQLoaderQ = RPC_GetLoaderMsgQ()
    if(NULL!= RPC_MsgQLoaderQ)
        retVal = MSGQ_RecvMsg(RPC_MsgQLoaderQ, aHdr, &loadMsg)
        if (BCM_ERR_OK == retVal)
            *aImgSize = loadMsg.filledSize
            return loadMsg.result
        else
            return BCM_ERR_BUSY
    @endcode
*/
static int32_t RPC_MasterGetLoaderStatus(const MSGQ_MsgHdrType *const aHdr,
                                                  uint32_t *const aImgSize)
{
    int32_t retVal = BCM_ERR_BUSY;
    RPC_MasterLoadReqType loadMsg;
    const MSGQ_Type *RPC_MsgQLoaderQ;

    RPC_MsgQLoaderQ = RPC_GetLoaderMsgQ();
    if(NULL!= RPC_MsgQLoaderQ) {
        BCM_MemSet(&loadMsg, 0U, sizeof(RPC_MasterLoadReqType));
        retVal = MSGQ_RecvMsg(RPC_MsgQLoaderQ, aHdr, &loadMsg);
        if (BCM_ERR_OK == retVal) {
            *aImgSize = loadMsg.filledSize;
            retVal = loadMsg.result;
        }
    }

    return retVal;
}
#endif

/** @brief RPC Master interface

    @trace #BRCM_SWARCH_RPC_MASTERIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL
*/
const RPC_InterfaceType RPC_MasterIfc = {
    .mode          = RPC_IFC_CHAN_MODE_MASTER,
    .assoc         = RPC_ASSOCIATIONINDEX_0,
    .init          = RPC_MasterInit,
    .isConnected   = RPC_MasterIsConnected,
    .connect       = RPC_MasterConnect,
    .getMsgSize    = RPC_MasterGetMsgSize,
    .sendMsg       = RPC_MasterSendMsg,
    .recvMsg       = RPC_MasterRecvMsg,
    .processMsg    = RPC_MasterProcess,
#ifdef ENABLE_RPC_MASTER_STREAM_SUPPORT
    .detectStrm    = RPC_MasterDetectStrm,
    .processStrm   = RPC_MasterProcessStrm,
#endif
    .disconnect    = RPC_MasterDisconnect,
    .getEventMask  = RPC_MasterGetEventMask,
    .deinit        = RPC_MasterDeinit,
};

#ifdef ENABLE_RPC_MASTER_STREAM_SUPPORT
/**
    @trace #BRCM_SWARCH_RPC_MASTERIMGHANDLER_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL
*/
const IMGL_InterfaceType RPC_MasterImgHandler = {
    .mode      = IMGL_LOAD_MODE_RPC,
    .readImg   = RPC_MasterLoadImg,
    .getStatus = RPC_MasterGetLoaderStatus,
    .readPTBL  = RPC_MasterReadPTBL,
    .readITBL  = RPC_MasterReadITBL,
    .channel[0UL] = IMGL_CHANNEL_ID_RPC_UDP,
    .channel[1UL] = IMGL_CHANNEL_ID_RPC_IPC,
};
#endif

/** @} */
