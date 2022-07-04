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
    @defgroup grp_rpc_host_cmd_impl Design
    @ingroup grp_sys_rpc_module

    @addtogroup grp_rpc_host_cmd_impl
    @{

    @file rpc_hostcmds.c
    @brief RPC Host command Implementation
    This file contains the implementation of host commands

    @version 0.1 Initial draft
*/
#include <stdio.h>
#include <build_info.h>
#include <bcm_utils.h>
#include <system.h>
#include <msg_queue.h>
#include <bcm_err.h>
#include <stdlib.h>
#include <osil/system_osil.h>
#include <module.h>
#include <module_helper.h>
#include <system_state.h>
#include <system_dmon.h>
#include <bcm_os.h>
#include <cpu.h>
#include <rpc_hosthelper.h>
#include <rpc_local_osil.h>
#include <rpc_mem.h>
#include <system_imgl.h>

/**
    @name Design IDs
    @{
    @brief Design IDs for host commands

*/
#define BRCM_SWDSGN_RPC_HOSTCMDCONTEXT_TYPE               (0xA401U)    /**< @brief #RPC_HostCmdContextType       */
#define BRCM_SWDSGN_RPC_HOSTCMDCONTEXT_GLOBAL             (0xA402U)    /**< @brief #RPC_HostCmdContext           */
#define BRCM_SWDSGN_RPC_HOSTCMDSERVICE_GLOBAL             (0xA403U)    /**< @brief #RPC_HostCmdService           */
#define BRCM_SWDSGN_RPC_HOSTCMDEVENTHANDLER_PROC          (0xA404U)    /**< @brief #RPC_HostCmdEventHandler      */
#define BRCM_SWDSGN_RPC_HOSTCMDSEND_CMD_PROC              (0xA405U)    /**< @brief #RPC_HostCmdSendCmd           */
#define BRCM_SWDSGN_RPC_HOSTCMDGET_RESP_PROC              (0xA406U)    /**< @brief #RPC_HostCmdGetResp           */
#define BRCM_SWDSGN_RPC_HOSTCMDEVENTMASK_PROC             (0xA407U)    /**< @brief #RPC_HostCmdGetEventMask      */
#define BRCM_SWDSGN_RPC_HOSTCMD_HANDLER_PROC              (0xA408U)    /**< @brief #RPC_HostCmdHandler           */
#define BRCM_SWDSGN_RPC_HOSTCMD_MSG_COUNT_MACRO           (0xA409U)    /**< @brief #RPC_HOSTCMD_MSG_COUNT        */
#define BRCM_SWDSGN_RPC_HOSTCMDASYNC_MSG_PROC             (0xA40AU)    /**< @brief #RPC_HostCmdAsyncMsg          */
#define BRCM_SWDSGN_RPC_HOST_MAX_MSG_ASYNC_MACRO          (0xA40BU)    /**< @brief #RPC_HOST_MAX_MSG_ASYNC       */
#define BRCM_SWDSGN_RPC_HOST_MAX_MSG_ASYNC_MASK_MACRO     (0xA40CU)    /**< @brief #RPC_HOST_MAX_MSG_ASYNC_MASK  */
#define BRCM_SWDSGN_RPC_HOSTCMDPROCSTATE_TYPE             (0xA40DU)    /**< @brief #RPC_HostCmdProcStateType     */
/** @} */

/**
    @brief Number of entries in MsgQ
    @{
    @trace #BRCM_SWARCH_RPC_HOSTCMDSERVICE_GLOBAL
    @trace #BRCM_SWREQ_RPC_HOSTCMDSERVICE
*/
#define RPC_HOSTCMD_MSG_COUNT            (4UL)
#define RPC_HOSTCMD_MSG_BIT              (0x80000000UL)
#define RPC_HOSTCMD_DMON_HEARTBEAT       (BCM_GET_CMDID(DMON_ID_HEART_BEAT))
/** @} */

/**
    @brief Maximum number of Async command messages

    @trace #BRCM_SWARCH_RPC_HOSTCMDSERVICE_GLOBAL
    @trace #BRCM_SWREQ_RPC_HOSTCMDSERVICE
*/
#define RPC_HOST_MAX_MSG_ASYNC              (32UL)

/**
    @brief Maximum Async Messages mask

    @trace #BRCM_SWARCH_RPC_HOSTCMDSERVICE_GLOBAL
    @trace #BRCM_SWREQ_RPC_HOSTCMDSERVICE
*/
#define RPC_HOST_MAX_MSG_ASYNC_MASK         (0x1FUL)

/**
    @brief Command processing state

    @trace #BRCM_SWARCH_RPC_HOSTCMDSERVICE_GLOBAL
    @trace #BRCM_SWREQ_RPC_HOSTCMDSERVICE
*/
typedef uint32_t RPC_HostCmdProcStateType;
#define RPC_HOSTCMD_PROC_STATE_RESET        (0UL)
#define RPC_HOSTCMD_PROC_STATE_QUEUED       (1UL)
#define RPC_HOSTCMD_PROC_STATE_COMPLETE     (2UL)

/**
    @brief RPC Host command context

    @trace #BRCM_SWARCH_RPC_HOSTCMDSERVICE_GLOBAL
    @trace #BRCM_SWREQ_RPC_HOSTCMDSERVICE
*/
typedef struct sRPC_HostCmdContextType {
    MODULE_ContextType         modCtx;                              /**< @brief Service interface context */
    RPC_MemMsgType             heartBeatMsg;                        /**< @brief Memory to store latest heartbeat message */
    RPC_MemMsgType             asyncMsgs[RPC_HOST_MAX_MSG_ASYNC];   /**< @brief Memory to store ASYNC messages */
    uint32_t                   asyncMsgWrIdx;                       /**< @brief Async message write index */
    uint32_t                   asyncMsgRdIdx;                       /**< @brief Async message read index */
    RPC_MemMsgType             cmdMsgs[RPC_HOSTCMD_MSG_COUNT];      /**< @brief MsgQ memory to store host commands */
    RPC_HostCmdProcStateType   cmdState[RPC_HOSTCMD_MSG_COUNT];     /**< @brief Command */
    uint32_t                   cmdQBitMask;                         /**< @brief Message 0:Available 1:Used */
} RPC_HostCmdContextType;

/**
    @brief SYSTEM Context

    @trace #BRCM_SWARCH_RPC_HOSTCMDSERVICE_GLOBAL
    @trace #BRCM_SWREQ_RPC_HOSTCMDSERVICE
*/
static RPC_HostCmdContextType RPC_HostCmdContext;

/** @brief EnQ the index for message

    This API Queue the index

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  aCtx               Pointer to Module context Interface of the Module
    @param[in]  aMsg               Async Message to push in cache

    @return void

    @trace #BRCM_SWARCH_RPC_MASTERIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL

    @code{.unparsed}
    idx = aCtx->asyncMsgWrIdx & RPC_HOST_MAX_MSG_ASYNC_MASK
    BCM_MemCpy(&aCtx->asyncMsgs[idx], aMsg, sizeof(RPC_MemMsgType))
    aCtx->asyncMsgWrIdx++
    if(RPC_HOST_MAX_MSG_ASYNC == aCtx->asyncMsgWrIdx - aCtx->asyncMsgRdIdx)
        aCtx->asyncMsgRdIdx++
    @endcode
*/
static void RPC_HostCmdAsyncEnQ(RPC_HostCmdContextType *aCtx, const uint8_t *aMsg)
{
    uint32_t idx;
    idx = aCtx->asyncMsgWrIdx & RPC_HOST_MAX_MSG_ASYNC_MASK;
    BCM_MemCpy(&aCtx->asyncMsgs[idx], aMsg, sizeof(RPC_MemMsgType));
    aCtx->asyncMsgWrIdx++;
    if(RPC_HOST_MAX_MSG_ASYNC == aCtx->asyncMsgWrIdx - aCtx->asyncMsgRdIdx) {
        aCtx->asyncMsgRdIdx++;
    }
}

/** @brief Peek The first element in Q

    This API Peek into Q and return the first element

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aCtx    Pointer to Module context Interface of the Module

    @return RPC_MemMsgType is not NULL if found in Q

    @trace #BRCM_SWARCH_RPC_MASTERIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL

    @code{.unparsed}
    RPC_MemMsgType *asyncMsg = NULL
    if(aCtx->asyncMsgWrIdx != aCtx->asyncMsgRdIdx)
        idx = aCtx->asyncMsgRdIdx & RPC_HOST_MAX_MSG_ASYNC_MASK
        asyncMsg = &aCtx->asyncMsgs[idx]
    return asyncMsg
    @endcode
*/
static RPC_MemMsgType* RPC_HostCmdAsyncPeekInQ(RPC_HostCmdContextType *aCtx)
{
    uint32_t idx;
    RPC_MemMsgType *asyncMsg = NULL;
    if(aCtx->asyncMsgWrIdx != aCtx->asyncMsgRdIdx) {
        idx = aCtx->asyncMsgRdIdx & RPC_HOST_MAX_MSG_ASYNC_MASK;
        asyncMsg = &aCtx->asyncMsgs[idx];
    }
    return asyncMsg;
}


/** @brief DeQ the index for message

    This API Pop's the index from the queue

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aCtx    Pointer to context Interface of the Module

    @return RPC_HdlType aHdl if found in Q
            NULL otherwise

    @trace #BRCM_SWARCH_RPC_MASTERIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL

    @code{.unparsed}
    asyncMsg = RPC_HostCmdAsyncPeekInQ(aCtx)
    if(NULL != asyncMsg)
        idx = aCtx->asyncMsgRdIdx & RPC_HOST_MAX_MSG_ASYNC_MASK
        BCM_MemSet(&aCtx->asyncMsgs[idx], 0U, sizeof(RPC_MemMsgType))
        aCtx->asyncMsgRdIdx++
        if((aCtx->asyncMsgRdIdx & (~RPC_HOST_MAX_MSG_ASYNC_MASK)) ==
                    (aCtx->asyncMsgWrIdx & (~RPC_HOST_MAX_MSG_ASYNC_MASK)))
            aCtx->asyncMsgWrIdx = (aCtx->asyncMsgWrIdx & RPC_HOST_MAX_MSG_ASYNC_MASK)
            aCtx->asyncMsgRdIdx = (aCtx->asyncMsgRdIdx & RPC_HOST_MAX_MSG_ASYNC_MASK)
    return asyncMsg
    @endcode
*/
static RPC_MemMsgType* RPC_HostCmdAsyncDeQ(RPC_HostCmdContextType *aCtx)
{
    uint32_t idx;
    RPC_MemMsgType *asyncMsg = NULL;

    asyncMsg = RPC_HostCmdAsyncPeekInQ(aCtx);
    if(NULL != asyncMsg) {
        idx = aCtx->asyncMsgRdIdx & RPC_HOST_MAX_MSG_ASYNC_MASK;
        BCM_MemSet(&aCtx->asyncMsgs[idx], 0U, sizeof(RPC_MemMsgType));
        aCtx->asyncMsgRdIdx++;
        if((aCtx->asyncMsgRdIdx & (~RPC_HOST_MAX_MSG_ASYNC_MASK)) ==
                    (aCtx->asyncMsgWrIdx & (~RPC_HOST_MAX_MSG_ASYNC_MASK))) {
            /* Transfer complete state. Set the index back to initial */
            aCtx->asyncMsgWrIdx = (aCtx->asyncMsgWrIdx & RPC_HOST_MAX_MSG_ASYNC_MASK);
            aCtx->asyncMsgRdIdx = (aCtx->asyncMsgRdIdx & RPC_HOST_MAX_MSG_ASYNC_MASK);
        }
    }

    return asyncMsg;
}

/**
    @brief Function to count the leading zeroes

    @trace #BRCM_SWARCH_RPC_HOSTCMDSERVICE_GLOBAL
    @trace #BRCM_SWREQ_RPC_HOSTCMDSERVICE

    @code{.unparsed}
    index = CPU_Clz(CPU_BitReverse(RPC_HostCmdContext.cmdQBitMask ^ 0xFFFFFFFFUL))
    if (RPC_HOSTCMD_MSG_COUNT > index)
        *aIndex = index
        RPC_HostCmdContext.cmdQBitMask |= (1UL << index)
        retVal = BCM_ERR_OK
    return retVal
    @endcode
*/
static int32_t RPC_HostCmdGetFreeSlot(uint32_t *aIndex)
{
    int32_t retVal = BCM_ERR_NOMEM;
    uint32_t index;
    index = CPU_Clz(CPU_BitReverse(RPC_HostCmdContext.cmdQBitMask ^ 0xFFFFFFFFUL));
    if (RPC_HOSTCMD_MSG_COUNT > index) {
        *aIndex = index;
        RPC_HostCmdContext.cmdQBitMask |= (1UL << index);
        retVal = BCM_ERR_OK;
    }
    return retVal;
}

/**
    @brief RPC Host Command Handler

    @trace #BRCM_SWARCH_RPC_HOSTCMDSERVICE_GLOBAL
    @trace #BRCM_SWREQ_RPC_HOSTCMDSERVICE

    @code{.unparsed}
    switch (BCM_GET_CMDID(aCmdMsg->cmd))
    case SYS_CMDID_EXECUTE:
        strncpy(fileName, (char*)aCmdMsg->payload, 100UL)
        Configure the IMGL interface with provided image
        retVal = RPC_HostImglSet(fileName)
        break
    case SYS_CMDID_IMGL_HDR_REQ:
        strncpy(fileName, (char*)aCmdMsg->payload, 100UL)
        Configure the IMGL interface with provided image
        retVal = RPC_HostImglSet(fileName)
        if(BCM_ERR_OK == retVal)
            retVal = RPC_HostImglGetParsedImgHdrs(aCmdMsg->payload)
            if(BCM_ERR_OK == retVal)
                aCmdMsg->len = sizeof(SYS_UpdateExecCmdType)
                retVal = BCM_ERR_OK
        break
    case SYS_ASYNCID_KEEPALIVE:
        BCM_MemCpy(aCmdMsg->payload, &RPC_HostCmdContext.heartBeatMsg.payload, RPC_MEM_MSG_PAYLOAD_SZ)
        aCmdMsg->len = RPC_HostCmdContext.heartBeatMsg.len
        retVal = BCM_ERR_OK
        break
    case RPC_HOST_CMDID_GET_ASYNC_MSG:
        peekMsg = RPC_HostCmdAsyncPeekInQ(&RPC_HostCmdContext)
        if(NULL != peekMsg)
            BCM_MemCpy(aCmdMsg->payload, peekMsg->payload, sizeof(RPC_MemMsgType))
            aCmdMsg->cmd = peekMsg->cmd
            aCmdMsg->len = peekMsg->len
            (void)RPC_HostCmdAsyncDeQ(&RPC_HostCmdContext)
            retVal = BCM_ERR_OK
         else
            aCmdMsg->len = 0UL
            retVal = BCM_ERR_NOT_FOUND
        break
    default:
        retVal = BCM_ERR_NOSUPPORT
    break
    return retVal
    @endcode
*/
int32_t RPC_HostCmdHandler(RPC_MemMsgType *aCmdMsg)
{
    int32_t retVal = BCM_ERR_OK;
    char fileName[100UL];
    RPC_MemMsgType *peekMsg;

    switch (BCM_GET_CMDID(aCmdMsg->cmd)) {
    case RPC_CMDIDVAL_IMGL_HDR_REQ:
        strncpy(fileName, (char*)aCmdMsg->payload, 100UL);
        /* Configure the IMGL interface with provided image */
        retVal = RPC_HostImglSet(fileName);
        if(BCM_ERR_OK == retVal) {
            retVal = RPC_HostImglGetParsedImgHdrs(aCmdMsg->payload);
            if(BCM_ERR_OK == retVal) {
                aCmdMsg->len = sizeof(IMGL_UpdateAutoSyncMsgType);
                retVal = BCM_ERR_OK;
            }
        }
        break;
    case RPC_HOSTCMD_DMON_HEARTBEAT:
        BCM_MemCpy(aCmdMsg->payload, &RPC_HostCmdContext.heartBeatMsg.payload, RPC_MEM_MSG_PAYLOAD_SZ);
        aCmdMsg->len = RPC_HostCmdContext.heartBeatMsg.len;
        retVal = BCM_ERR_OK;
        break;
    case RPC_HOST_CMDID_GET_ASYNC_MSG:
        peekMsg = RPC_HostCmdAsyncPeekInQ(&RPC_HostCmdContext);
        if(NULL != peekMsg) {
            BCM_MemCpy(aCmdMsg->payload, peekMsg->payload, sizeof(RPC_MemMsgType));
            aCmdMsg->cmd = peekMsg->cmd;
            aCmdMsg->len = peekMsg->len;
            (void)RPC_HostCmdAsyncDeQ(&RPC_HostCmdContext);
            retVal = BCM_ERR_OK;
        } else {
            aCmdMsg->len = 0UL;
            retVal = BCM_ERR_NOT_FOUND;
        }
        break;
    default:
        retVal = BCM_ERR_NOSUPPORT;
    break;
    }
    return retVal;
}

/**
    @brief RPC Host event handler

    @trace #BRCM_SWARCH_RPC_HOSTCMDSERVICE_GLOBAL
    @trace #BRCM_SWREQ_RPC_HOSTCMDSERVICE

    @code{.unparsed}
    if (0UL != RPC_HostCmdContext.cmdQBitMask)
        for (index = 0UL
            (index < RPC_HOSTCMD_MSG_COUNT) &&
            (RPC_HOSTCMD_PROC_STATE_QUEUED == RPC_HostCmdContext.cmdState[index])
            index++)
            RPC_MemMsgType *eventPtr = &RPC_HostCmdContext.cmdMsgs[index]
            retVal = RPC_HostCmdHandler(eventPtr)
            if (BCM_ERR_BUSY != retVal)
                RPC_HostCmdContext.cmdState[index] = RPC_HOSTCMD_PROC_STATE_COMPLETE
                eventPtr->response = retVal
    @endcode
*/
void RPC_HostCmdEventHandler(uint32_t aMask)
{
    int32_t retVal = BCM_ERR_OK;
    uint32_t index = 0UL;

    if (0UL != RPC_HostCmdContext.cmdQBitMask) {
        for (index = 0UL;
            (index < RPC_HOSTCMD_MSG_COUNT) &&
            (RPC_HOSTCMD_PROC_STATE_QUEUED == RPC_HostCmdContext.cmdState[index]);
            index++) {
            RPC_MemMsgType *eventPtr = &RPC_HostCmdContext.cmdMsgs[index];
            retVal = RPC_HostCmdHandler(eventPtr);
            if (BCM_ERR_BUSY != retVal) {
                /* Update the command processing as complete */
                RPC_HostCmdContext.cmdState[index] = RPC_HOSTCMD_PROC_STATE_COMPLETE;
                eventPtr->response = retVal;
            }
        }
    }
 }

/**
    @brief RPC Host send command

    @trace #BRCM_SWARCH_RPC_HOSTCMDSERVICE_GLOBAL
    @trace #BRCM_SWREQ_RPC_HOSTCMDSERVICE

    @code{.unparsed}
    if (invalid args)
        retVal = BCM_ERR_INVAL_PARAMS
    else
        retVal = RPC_HostCmdGetFreeSlot(&idx)
        if (BCM_ERR_OK == retVal)
            BCM_MemCpy(&RPC_HostCmdContext.cmdMsgs[idx], aCmdData, sizeof(RPC_MemMsgType))
            RPC_HostCmdContext.cmdState[idx] = RPC_HOSTCMD_PROC_STATE_QUEUED
            *aHandle = idx
        *aForwardToSlaves = 0UL;
    return retVal
    @endcode
*/
static int32_t RPC_HostCmdSendCmd(BCM_CmdType aCmd, uint32_t aLen, const uint8_t *aCmdData,
                                  BCM_HandleType *aHandle, uint32_t *aForwardToSlaves)
{
    int32_t retVal = BCM_ERR_OK;
    uint32_t idx;

    if ((aCmdData == NULL) ||
        (aForwardToSlaves == NULL) ||
        (aHandle == NULL) ||
        (sizeof(RPC_MemMsgType) < aLen)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        retVal = RPC_HostCmdGetFreeSlot(&idx);
        if (BCM_ERR_OK == retVal) {
            RPC_HostCmdContext.cmdMsgs[idx].magic = RPC_MEMMSG_MAGIC;
            RPC_HostCmdContext.cmdMsgs[idx].cmd = aCmd;
            RPC_HostCmdContext.cmdMsgs[idx].len = aLen;
            BCM_MemCpy(&RPC_HostCmdContext.cmdMsgs[idx].payload, aCmdData, aLen);
            RPC_HostCmdContext.cmdState[idx] = RPC_HOSTCMD_PROC_STATE_QUEUED;
            *aHandle = idx | RPC_HOSTCMD_MSG_BIT;
        }
        *aForwardToSlaves = 0UL;
    }
    return retVal;
}

/** @brief Retreive status of RPC Host commands

    This API queries the status of completed host commands which were
    previously issued

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aHandle         Message queue Handle
    @param[in]      aReplyID        Reply ID (group, comp, cmd)
    @param[in]      aInLen          Available Length of the reply data payload in bytes
    @param[out]     aReplyData      Pointer to reply message to be filled by SYS
    @param[out]     aReplyDataLen   Pointer to length of reply message to be filled by SYS

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK     Command status retrieved successfully
    @retval     #BCM_ERR_BUSY   Command under processing

    @post None

    @trace #BRCM_SWARCH_RPC_HOSTCMDSERVICE_GLOBAL
    @trace #BRCM_SWREQ_RPC_HOSTCMDSERVICE

    @code{.unparsed}
    if (invalid args)
        retVal = BCM_ERR_INVAL_PARAMS
    else
        if (RPC_HOSTCMD_PROC_STATE_COMPLETE == RPC_HostCmdContext.cmdState[aHandle])
            BCM_MemCpy(aReplyData, &RPC_HostCmdContext.cmdMsgs[aHandle], sizeof(RPC_MemMsgType))
            *aReplyDataLen = sizeof(RPC_MemMsgType)
            RPC_HostCmdContext.cmdState[aHandle] = RPC_HOSTCMD_PROC_STATE_RESET
            RPC_HostCmdContext.cmdQBitMask &= ((1UL << aHandle) ^ 0xFFFFFFFFUL)
            retVal = BCM_ERR_OK
         else
            retVal = BCM_ERR_BUSY
    return retVal
    @endcode
*/
static int32_t RPC_HostCmdGetResp(BCM_HandleType aHandle,
                                  BCM_CmdType aReplyID, uint32_t aInLen,
                                  uint8_t *aReplyData, uint32_t *aReplyDataLen)
{
    int32_t retVal = BCM_ERR_OK;
    uint32_t idx = (uint32_t)(aHandle ^ RPC_HOSTCMD_MSG_BIT);
    if ((aReplyData == NULL) ||
        (aReplyDataLen == NULL) ||
        (0UL == aInLen) ||
        (RPC_HOSTCMD_MSG_COUNT <= idx)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        if (RPC_HOSTCMD_PROC_STATE_COMPLETE == RPC_HostCmdContext.cmdState[idx]) {
            retVal = RPC_HostCmdContext.cmdMsgs[idx].response;
            BCM_MemCpy(aReplyData, &RPC_HostCmdContext.cmdMsgs[idx].payload, RPC_HostCmdContext.cmdMsgs[idx].len);
            *aReplyDataLen = RPC_HostCmdContext.cmdMsgs[idx].len;

            RPC_HostCmdContext.cmdState[idx] = RPC_HOSTCMD_PROC_STATE_RESET;
            RPC_HostCmdContext.cmdQBitMask &= ((1UL << idx) ^ 0xFFFFFFFFUL);
        } else {
            retVal = BCM_ERR_BUSY;
        }
    }

    return retVal;
}

/** @brief Process the Async message

    @trace #BRCM_SWARCH_RPC_MASTERIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL

    @code{.unparsed}
    if (RPC_HOSTCMD_DMON_HEARTBEAT == compId)
        BCM_MemCpy(&RPC_HostCmdContext->heartBeatMsg, aMsg, sizeof(RPC_MemMsgType))
    else
        RPC_HostCmdAsyncEnQ(&RPC_HostCmdContext, aMsg)
    return ret
    @endcode
*/
int32_t RPC_HostCmdAsyncMsg(BCM_CmdType aNotfn,
                            const uint8_t *aMsg,
                            uint32_t aLen,
                            uint32_t *aForwardToHost)
{
    int32_t ret = BCM_ERR_OK;
    uint8_t cmdID = BCM_GET_CMDID(aNotfn);
    if (RPC_HOSTCMD_DMON_HEARTBEAT == cmdID) {
        BCM_MemCpy(&RPC_HostCmdContext.heartBeatMsg, aMsg, sizeof(RPC_MemMsgType));
    } else {
        RPC_HostCmdAsyncEnQ(&RPC_HostCmdContext, aMsg);
    }
    return ret;
}

/**
    @brief RPC Host command handler

    @trace #BRCM_SWARCH_RPC_HOSTCMDSERVICE_GLOBAL
    @trace #BRCM_SWREQ_RPC_HOSTCMDSERVICE
*/
const SERVICE_Type RPC_HostCmdService = {
    .group  = BCM_GROUPID_SYS,
    .server = {
        .groupID           = BCM_GROUPID_SYS,
        .compID            = BCM_RPC_ID,
        .configImgID       = 0UL,
        .configImgData     = NULL,
        .configImgSize     = 0UL,
        .context           = &RPC_HostCmdContext.modCtx,
        .eventHandler      = RPC_HostCmdEventHandler,
        .sendCmd           = RPC_HostCmdSendCmd,
        .getResp           = RPC_HostCmdGetResp,
        .asyncMsg          = RPC_HostCmdAsyncMsg,
    },
};
/** @} */
