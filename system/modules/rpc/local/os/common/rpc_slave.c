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
    @defgroup grp_rpc_slave_impl Local Slave Design
    @ingroup grp_rpc_v2_local

    @addtogroup grp_rpc_slave_impl
    @{

    @file rpc_slave.c
    @brief RPC slave Interface Design

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
#include <lw_queue.h>
#include <rpc_mem.h>
#include <cpu.h>
#include <rpc_local.h>
#include <rpc_local_osil.h>

/**
    @name Component Design IDs
    @{
    @brief Design IDs for Component
*/
#define BRCM_SWDSGN_RPC_SLAVE_MAX_MSG_MACRO        (0xA301U)   /**< @brief #RPC_SLAVE_MAX_MSG        */
#define BRCM_SWDSGN_RPC_MSGQ_LWQ_MAX_ENTRIES_MACRO (0xA302U)   /**< @brief #RPC_MSGQ_LWQ_MAX_ENTRIES */
#define BRCM_SWDSGN_RPC_SLAVEMSGCTXTYPE_TYPE       (0xA303U)   /**< @brief #RPC_SlaveMsgCtxType      */
#define BRCM_SWDSGN_RPC_SLAVEIFC_GLOBAL            (0xA304U)   /**< @brief #RPC_SlaveIfc             */
#define BRCM_SWDSGN_RPC_SLAVESTRMMEM_GLOBAL        (0xA305U)   /**< @brief #RPC_SlaveStrmMem         */
#define BRCM_SWDSGN_RPC_SLAVEMSGCTX_GLOBAL         (0xA306U)   /**< @brief #RPC_SlaveMsgCtx          */
#define BRCM_SWDSGN_RPC_SLAVECMD_GLOBAL            (0xA307U)   /**< @brief #RPC_SlaveCmd             */
#define BRCM_SWDSGN_RPC_SLAVEALLOCLWQ_PROC         (0xA308U)   /**< @brief #RPC_SlaveAllocLwq        */
#define BRCM_SWDSGN_RPC_MSGQGETCMD_PROC            (0xA309U)   /**< @brief #RPC_MsgQGetCmd           */
#define BRCM_SWDSGN_RPC_SENDTOSLAVE_PROC           (0xA30AU)   /**< @brief #RPC_SendToSlave          */
#define BRCM_SWDSGN_RPC_RECVFROMSLAVE_PROC         (0xA30BU)   /**< @brief #RPC_RecvFromSlave        */
#define BRCM_SWDSGN_RPC_SLAVESENDCMD_PROC          (0xA30CU)   /**< @brief #RPC_SlaveSendLocalCmd    */
#define BRCM_SWDSGN_RPC_SLAVEGETRESP_PROC          (0xA30DU)   /**< @brief #RPC_SlaveGetLocalResp    */
#define BRCM_SWDSGN_RPC_SLAVEINIT_PROC             (0xA30EU)   /**< @brief #RPC_SlaveInit            */
#define BRCM_SWDSGN_RPC_SLAVEISCONNECTED_PROC      (0xA30FU)   /**< @brief #RPC_SlaveIsConnected     */
#define BRCM_SWDSGN_RPC_SLAVECONNECT_PROC          (0xA310U)   /**< @brief #RPC_SlaveConnect         */
#define BRCM_SWDSGN_RPC_SLAVEGETMSGSIZE_PROC       (0xA311U)   /**< @brief #RPC_SlaveGetMsgSize      */
#define BRCM_SWDSGN_RPC_SLAVEGETEVENTMASK_PROC     (0xA312U)   /**< @brief #RPC_SlaveGetEventMask    */
#define BRCM_SWDSGN_RPC_SLAVESENDMSG_PROC          (0xA313U)   /**< @brief #RPC_SlaveSendMsg         */
#define BRCM_SWDSGN_RPC_SLAVERECVMSG_PROC          (0xA314U)   /**< @brief #RPC_SlaveRecvMsg         */
#define BRCM_SWDSGN_RPC_SLAVEPROCESS_PROC          (0xA315U)   /**< @brief #RPC_SlaveProcess         */
#define BRCM_SWDSGN_RPC_SLAVEDETECTSTRM_PROC       (0xA316U)   /**< @brief #RPC_SlaveDetectStrm      */
#define BRCM_SWDSGN_RPC_SLAVEPROCESSSTRM_PROC      (0xA317U)   /**< @brief #RPC_SlaveProcessStrm     */
#define BRCM_SWDSGN_RPC_SLAVEDISCONNECT_PROC       (0xA318U)   /**< @brief #RPC_SlaveDisconnect      */
#define BRCM_SWDSGN_RPC_SLAVEDEINIT_PROC           (0xA319U)   /**< @brief #RPC_SlaveDeinit          */
/** @} */

/**
    @brief Maximum LWQ length

    @trace #BRCM_SWARCH_RPC_SLAVEIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL
*/
#define RPC_MSGQ_LWQ_MAX_ENTRIES   (16UL)

/**
    @brief Maximum Slave Messages

    @trace #BRCM_SWARCH_RPC_SLAVEIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL
*/
#define RPC_SLAVE_MAX_MSG   (32UL)

/**
    @brief RPC Slave MessageQ context structure

    @trace #BRCM_SWARCH_RPC_SLAVEIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL
 */
typedef struct sRPC_SlaveMsgCtxType {
    RPC_InterfaceIdType      selfId;                   /**< @brief This Interface ID   */
    RPC_InterfaceIdType      peerId;                   /**< @brief Connected Master ID        */
    RPC_AssociationIndexType assocId;                  /**< @brief This Interface Association ID */
    RPC_HdlType    cmdHdl[RPC_MSGQ_LWQ_MAX_ENTRIES];   /**< @brief Command Handle             */
    RPC_HdlType    respHdl[RPC_MSGQ_LWQ_MAX_ENTRIES];  /**< @brief Resp Handle                */
    LWQ_BufferType cmdQ;                               /**< @brief Command LWQ                */
    LWQ_BufferType respQ;                              /**< @brief Response LWQ               */
    uint32_t cmdUseMask;                               /**< @brief Command Use Mask           */
    uint32_t respUseMask;                              /**< @brief Response Use Mask          */
    uint8_t appInfoCntr;                               /**< @brief AppInfo Value Counter      */
    const MSGQ_MsgHdrType *hdr[RPC_MEM_STREAM_COUNT];  /**< @brief message header             */
#ifdef ENABLE_RPC_SLAVE_STREAM_SUPPORT
    uint8_t     strmMem[RPC_MEM_STREAM_COUNT][RPC_MEM_STREAM_SIZE];
                                                       /**< @brief RPC Temporary Stream Memory*/
#endif
}RPC_SlaveMsgCtxType;

/**
    @brief RPC Slave Message Queue context

    @trace #BRCM_SWARCH_RPC_SLAVEIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL
*/
static RPC_SlaveMsgCtxType RPC_SlaveMsgCtx COMP_SECTION(".bss.rpc");

#ifdef RPC_SLAVE_ENABLE_LOCALCMD_SUPPORT
/**
    @brief RPC Local Command messages

    @trace #BRCM_SWARCH_RPC_SLAVEIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL
*/
static RPC_LocalMsgType
          RPC_SlaveCmd[RPC_SLAVE_LOCAL_MSG_MAX]
          COMP_SECTION(".bss.rpc");
#endif

/** @brief RPC Slave Interface Initialization

    Function initialize the Message Queue Slave Interface

    @behavior Sync, Non-Reentrant

    @param[in]      aLwq            LWQ
    @param[in]      aMask           Usage Mask of the LWQ
    @param[out]     aIdx            LWQ Index

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Init successful
    @retval     #BCM_ERR_UNKNOWN        Init Failed

    @trace #BRCM_SWARCH_RPC_SLAVEIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL

    @limitations None

    @code{.unparsed}
    zerosCnt = CPU_Clz(*aMask)
    idx = find the free index by (RPC_SLAVE_MAX_MSG - 1UL) - zerosCnt
    if(RPC_MSGQ_LWQ_MAX_ENTRIES <= idx)
        return BCM_ERR_NOMEM
    else
        Allocate *aMask by clear the idx
        ret = LWQ_Push(aLwq, idx)
            if(ret IS NOT BCM_ERR_OK)
                *aMask |= (1UL << idx)
                return BCM_ERR_UNKNOWN
            else
                *aIdx = idx
    @endcode
*/
static int32_t RPC_SlaveAllocLwq(LWQ_BufferType *aLwq, uint32_t *aMask, uint32_t *aIdx)
{
    int32_t retVal;
    uint32_t zerosCnt;
    uint32_t idx;

    zerosCnt = CPU_Clz(*aMask);
    idx = (RPC_SLAVE_MAX_MSG - 1UL) - zerosCnt;
    if(RPC_MSGQ_LWQ_MAX_ENTRIES <= idx) {
        return BCM_ERR_NOMEM;
    } else {
        *aMask &= ~(1UL << idx);
        retVal = LWQ_Push(aLwq, (uint8_t)idx);
        if(BCM_ERR_OK != retVal) {
            *aMask |= (1UL << idx);
            retVal = BCM_ERR_UNKNOWN;
        } else {
            *aIdx = idx;
        }
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_RPC_SENDTOSLAVE_PROC
    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL

    @code{.unparsed}
    retVal = RPC_MsgAlloc(aHdl, RPC_SlaveMsgCtx.selfId,
                                RPC_SlaveMsgCtx.peerId,
                                RPC_SlaveMsgCtx.assocId,
                                &newHdl)
    if(retVal IS NOT BCM_ERR_OK)
        return BCM_ERR_UNKNOWN
    else
          if(cmdmsg IS NOT NULL)
            retVal = RPC_SlaveAllocLwq(&RPC_SlaveMsgCtx.cmdQ, &RPC_SlaveMsgCtx.cmdUseMask, &idx)
            if(retVal IS BCM_ERR_OK)
                clear the cloned appinfo cmdmsg.appinfo[RPC_MEM_MAX_CNT_APPINFO]
                set the new message top cmdmsg.appinfoTop = 0UL
                RPC_MemPushAppInfo(newHdl,aHdl)
                RPC_SlaveMsgCtx.appInfoCntr++
                RPC_SlaveMsgCtx.cmdHdl[idx] = newHdl
            else
                RPC_Release(newHdl)
                return BCM_ERR_UNKNOWN
        else
            RPC_Release(newHdl)
            return BCM_ERR_UNKNOWN
        return BCM_ERR_UNKNOWN
    @endcode
*/
int32_t RPC_SendToSlave(RPC_HdlType aHdl, RPC_HdlType *aClonedHdl)
{
    uint32_t idx = 0UL;
    int32_t retVal;

    RPC_HdlType newHdl;
    RPC_MemMsgType *cmdmsg;

    retVal = RPC_MsgAlloc(aHdl, RPC_SlaveMsgCtx.selfId,
                                RPC_SlaveMsgCtx.peerId,
                                RPC_SlaveMsgCtx.assocId,
                                &newHdl);
    if(BCM_ERR_OK != retVal) {
        retVal = BCM_ERR_UNKNOWN;
    } else {
        cmdmsg = RPC_MsgGet(newHdl);
        if(NULL != cmdmsg) {
            retVal = RPC_SlaveAllocLwq(&RPC_SlaveMsgCtx.cmdQ, &RPC_SlaveMsgCtx.cmdUseMask, &idx);
            if(BCM_ERR_OK == retVal) {
                (void)RPC_MemPushAppInfo(newHdl,aHdl);
                RPC_SlaveMsgCtx.appInfoCntr++;
                RPC_SlaveMsgCtx.cmdHdl[idx] = newHdl;
                *aClonedHdl = newHdl;
            } else {
                (void)RPC_Release(newHdl);
                retVal = BCM_ERR_UNKNOWN;
            }
        } else {
            (void)RPC_Release(newHdl);
            retVal = BCM_ERR_UNKNOWN;
        }
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_RPC_RECVFROMSLAVE_PROC
    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL

    @code{.unparsed}
    retVal = LWQ_Pop(&RPC_SlaveMsgCtx.respQ, &idx)
    if(retVal IS NOT BCM_ERR_OK)
        return BCM_ERR_NOT_FOUND
    else
        retVal = RPC_MemPopAppInfo(RPC_SlaveMsgCtx.respHdl[idx], &appinfoHdl)
        if(retVal IS NOT BCM_ERR_OK)
            return BCM_ERR_UNKNOWN
        else
            *aSlvHdl = RPC_SlaveMsgCtx.respHdl[idx]
            *aMasterHdl = appinfoHdl
            RPC_SlaveMsgCtx.respUseMask |= (1UL << idx)
    @endcode
*/
int32_t RPC_RecvFromSlave(RPC_HdlType *aSlvHdl, RPC_HdlType *aMasterHdl)
{
    uint8_t idx = 0U;
    int32_t retVal;
    uint32_t appinfoHdl;

    retVal = LWQ_Pop(&RPC_SlaveMsgCtx.respQ, &idx);
    if(BCM_ERR_OK != retVal) {
        retVal = BCM_ERR_NOT_FOUND;
    } else {
        retVal = RPC_MemPopAppInfo(RPC_SlaveMsgCtx.respHdl[idx], &appinfoHdl);
        if(BCM_ERR_OK != retVal) {
            retVal = BCM_ERR_UNKNOWN;
        } else {
           *aSlvHdl = RPC_SlaveMsgCtx.respHdl[idx];
           *aMasterHdl = appinfoHdl;
            RPC_SlaveMsgCtx.respHdl[idx]  = RPC_HDL_INVALID;
            RPC_SlaveMsgCtx.respUseMask |= (1UL << idx);
        }
    }

    return retVal;
}

#ifdef RPC_SLAVE_ENABLE_LOCALCMD_SUPPORT
/**
    @trace #BRCM_SWARCH_RPC_SLAVESENDLOCALCMD_PROC
    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL

    @code{.unparsed}
    RPC_LocalMsgType cmdmsg
    if(aHdr is NULL) OR (aBuff IS NOT NULL AND aLen is '0')
            OR (aBuff IS NULL AND aLen IS NOT '0')
        return BCM_ERR_INVAL_PARAMS
    else
        cmdmsg.cmd = ((((uint32_t)aGrpID << BCM_CMD_GROUP_SHIFT) & BCM_CMD_GROUP_MASK) |
                      (((uint32_t)aCompID << RPC_CMD_COMP_SHIFT) & RPC_CMD_COMP_MASK) |
                      (((uint32_t)aCmdID << RPC_CMD_ID_SHIFT) & RPC_CMD_ID_MASK))

        cmdmsg.payLoadSize = aLen
        if(aBuff IS NOT NULL )
            BCM_MemCpy(cmdmsg.payLoad, aBuff, aLen)
        cmdmsg.result = BCM_ERR_CUSTOM
        cmdQ = RPC_MsgQGetCmdQ()
        MSGQ_SendMsg(cmdQ, &cmdmsg, aClientMask, aHdr)
    @endcode
*/
int32_t RPC_SlaveSendLocalCmd(BCM_GroupIDType aGrpID, BCM_CompIDType aCompID, uint8_t aCmdID,
                              const uint8_t *const aBuff, uint32_t aLen, uint32_t aTimeoutMs,
                              uint32_t aClientMask, const MSGQ_MsgHdrType** const aHdr)
{
    int32_t retVal;
    RPC_LocalMsgType cmdmsg;
    const MSGQ_Type *cmdQ;

    if((NULL == aHdr) || ((NULL != aBuff) && (0UL == aLen))
            || ((NULL == aBuff) && (0UL != aLen))) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        cmdmsg.cmd = ((((uint32_t)aGrpID << BCM_CMD_GROUP_SHIFT) & BCM_CMD_GROUP_MASK) |
                      (((uint32_t)aCompID << BCM_CMD_COMP_SHIFT) & BCM_CMD_COMP_MASK) |
                      (((uint32_t)aCmdID << BCM_CMD_ID_SHIFT) & BCM_CMD_ID_MASK));
        cmdmsg.payLoadSize = aLen;
        if(NULL != aBuff) {
            BCM_MemCpy(cmdmsg.payLoad, aBuff, aLen);
        }
        cmdmsg.result = BCM_ERR_CUSTOM;
        cmdmsg.cfgTimeoutMs = aTimeoutMs;
        cmdmsg.hdl = RPC_HDL_INVALID;
        cmdQ = RPC_MsgQGetCmdQ();
        retVal = MSGQ_SendMsg(cmdQ, &cmdmsg, aClientMask, aHdr);
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_RPC_SLAVEGETLOCALRESP_PROC
    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL

    @code{.unparsed}
    If(aHdr is NULL) OR (aResponse IS NULL) OR (aBuff IS NOT NULL AND aSize is NULL)
            OR (aBuff IS NULL AND aSize IS NOT NULL)
        return BCM_ERR_INVAL_PARAMS
    else
        RPC_LocalMsgType cmdmsg
        cmdQ = RPC_MsgQGetCmdQ
        retVal = MSGQ_RecvMsg(cmdQ, aHdr, &cmdmsg)
        if(Succes)
            if(aSize IS NOT NULL)
                BCM_MemCpy(aBuff, cmdmsg.payLoad, cmdmsg.payLoadSize)
                *aSize = cmdmsg.payLoadSize
                *aResponse = cmdmsg.result
                 return BCM_ERR_OK
            else
                return BCM_ERR_UNKNOWN
        else if(busy)
             return BCM_ERR_BUSY
        else
            return BCM_ERR_UNKNOWN
    @endcode
*/
int32_t RPC_SlaveGetLocalResp(const MSGQ_MsgHdrType *const aHdr, int32_t * const aResponse,
                              uint8_t *const aBuff, uint32_t * const aSize)
{
    int32_t retVal;
    RPC_LocalMsgType cmdmsg;
    const MSGQ_Type *cmdQ;

    if((NULL == aHdr) || (NULL == aResponse) || ((NULL != aBuff) && (NULL == aSize))
            || ((NULL == aBuff) && ((NULL != aSize) && (0UL < *aSize)))) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        cmdQ = RPC_MsgQGetCmdQ();
        BCM_MemSet(&cmdmsg, 0U, sizeof(RPC_LocalMsgType));
        retVal = MSGQ_RecvMsg(cmdQ, aHdr, &cmdmsg);
        if(BCM_ERR_OK == retVal) {
            *aResponse = cmdmsg.result;
            if ((NULL != aBuff) && ((NULL != aSize) && (0UL < aSize))) {
                BCM_MemCpy(aBuff, cmdmsg.payLoad, cmdmsg.payLoadSize);
                *aSize = cmdmsg.payLoadSize;
            }
        } else if(BCM_ERR_BUSY == retVal) {
             retVal = BCM_ERR_BUSY;
        } else {
            retVal =  BCM_ERR_UNKNOWN;
        }
    }

    return retVal;
}

/**
    @brief Get the aIdx-th for Command message from memory

    @trace #BRCM_SWARCH_RPC_SLAVEIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL

    @code{.unparsed}
        if(RPC_SLAVE_LOCAL_MSG_MAX >= aIdx)
            return NULL
        else
            return (void *)(&RPC_SlaveCmd[aIdx])
    @endcode
*/
void* RPC_MsgQGetCmd(uint32_t aIdx)
{
    void* pRet = NULL;

    if (RPC_SLAVE_LOCAL_MSG_MAX >= aIdx) {
        pRet = (void *)(&RPC_SlaveCmd[aIdx]);
    }

    return pRet;
}
#endif

/** @brief RPC Slave Interface Initialization

    Function initialize the Message Queue Slave Interface

    @behavior Sync, Non-Reentrant

    @param[in]      void

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Init successful
    @retval     #BCM_ERR_UNKNOWN        Init Failed

    @trace #BRCM_SWARCH_RPC_SLAVEIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL

    @limitations None

    @code{.unparsed}
    Mem Set RPC_SlaveMsgCtx
    retVal = RPC_GetModIfcAndAssoc(&RPC_SlaveIfc, &RPC_SlaveMsgCtx.selfId,
                                 &RPC_SlaveMsgCtx.peerId,
                                 &RPC_SlaveMsgCtx.assocId)
    if(BCM_ERR_OK == retVal) {
        Mem Set RPC_SlaveCmd
        LWQ_Init(&RPC_SlaveMsgCtx.cmdQ)
        LWQ_Init(&RPC_SlaveMsgCtx.respQ)
        Free the cmd AND resp usageMask of RPC_MSGQ_LWQ_MAX_ENTRIES
        RPC_SlaveMsgCtx.appInfoCntr++
    }

    return retVal
    @endcode
*/
static int32_t RPC_SlaveInit(void)
{
    uint32_t i;
    int32_t retVal;

    BCM_MemSet(&RPC_SlaveMsgCtx, 0U, sizeof(RPC_SlaveMsgCtxType));
    retVal = RPC_GetModIfcAndAssoc(&RPC_SlaveIfc, &RPC_SlaveMsgCtx.selfId,
                                 &RPC_SlaveMsgCtx.peerId,
                                 &RPC_SlaveMsgCtx.assocId);
    if(BCM_ERR_OK == retVal) {

#ifdef RPC_SLAVE_ENABLE_LOCALCMD_SUPPORT
        BCM_MemSet(RPC_SlaveCmd, 0U, (RPC_SLAVE_LOCAL_MSG_MAX * sizeof(RPC_LocalMsgType)));
#endif
        LWQ_Init(&RPC_SlaveMsgCtx.cmdQ);
        LWQ_Init(&RPC_SlaveMsgCtx.respQ);
        for(i=0; i<RPC_MSGQ_LWQ_MAX_ENTRIES; i++){
            RPC_SlaveMsgCtx.cmdUseMask |= (1UL << i);
            RPC_SlaveMsgCtx.respUseMask |= (1UL << i);
        }
        RPC_SlaveMsgCtx.appInfoCntr++;
    }

    return retVal;
}

/** @brief RPC Slave Interface connection status

    @behavior Sync, Non-Reentrant

    @param[in]      void

    @return     FALSE - Disconnected, TRUE - Connected

    @trace #BRCM_SWARCH_RPC_SLAVEIFC_GLOBAL
    @trace  #BRCM_SWREQ_RPC_INTERFACE_LOCAL

    @limitations None

    @code{.unparsed}
    @endcode
*/
static uint32_t RPC_SlaveIsConnected(void)
{
    return TRUE;
}

/** @brief RPC Slave Interface Connect

    This API will initiate connection to remote slave.

    @behavior Sync, Non-Reentrant

    @param[in]      void

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Connection established
    @retval     #BCM_ERR_NOT_FOUND      No Connection established
    @retval     #BCM_ERR_UNKNOWN        Unknown failure

    @trace #BRCM_SWARCH_RPC_SLAVEIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL

    @limitations None

    @code{.unparsed}
    @endcode
*/
static int32_t RPC_SlaveConnect(void)
{
    return BCM_ERR_OK;
}

/** @brief RPC Slave Interface Get Max Message size

    @behavior Sync, Non-Reentrant

    @param[in]      void

    @return Message Size

    @trace #BRCM_SWARCH_RPC_SLAVEIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL

    @limitations None

    @code{.unparsed}
        return RPC_MEM_MSG_PAYLOAD_SZ;
    @endcode
*/
static uint32_t RPC_SlaveGetMsgSize(void)
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

    @trace #BRCM_SWARCH_RPC_SLAVEIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL

    @limitations Must return the same event mask at any point of time
    i.e. it cannot be changed dynamically.

    @code{.unparsed}
    return RPC_SlaveEvent
    @endcode
*/
static uint32_t RPC_SlaveGetEventMask(void)
{
    return RPC_SlaveEvent;
}

/** @brief RPC Slave Interface Send message

    Interface Function to send command

    @behavior Sync, Non-Reentrant

    @param[in]      aHdl                Message Handle to be sent

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Message sent successfully
    @retval     #BCM_ERR_NOMEM          Queue is Full and cannot be added to queue
    @retval     #BCM_ERR_UNKNOWN        Unknown failure

    @trace #BRCM_SWARCH_RPC_SLAVEIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL

    @limitations None

    @code{.unparsed}
    forwardToHost = FALSE
    cmdmsg = RPC_MsgGet(aHdl)
    if(NULL != cmdmsg)
        if (1UL == ((cmdmsg->cmd & BCM_CMD_ASYNC_MASK) >> BCM_CMD_ASYNC_SHIFT))
            cmdID = (uint8_t)BCM_GET_CMDID(cmdmsg->cmd)
            compID = (uint16_t)BCM_GET_COMP(cmdmsg->cmd)
            groupID = (uint8_t)BCM_GET_GROUPID(cmdmsg->cmd)
            for(i = 0UL i < RPC_MASTER_MAX_OBJECTS i++)
                if((NULL != RPC_MasterIfcObjects[i]) && (group == RPC_MasterIfcObjects[i]->group))
                   if (NULL != RPC_MasterIfcObjects[i]->asyncMsg)
                        retVal = RPC_MasterIfcObjects[i]->server.asyncMsg(cmdmsg->cmd, cmdmsg->payload, cmdmsg->len, &forwardToHost)
                    else
                        retVal = BCM_ERR_OK;
                        RPC_Release(aHdl);
                    break
            if(BCM_ERR_OK == retVal)
                if (TRUE == forwardToHost)
                    retVal = RPC_SlaveAllocLwq(&RPC_SlaveMsgCtx.respQ,
                                               &RPC_SlaveMsgCtx.respUseMask, &idx)
                    if(BCM_ERR_OK == retVal)
                        RPC_SlaveMsgCtx.respHdl[idx] = aHdl
                     else
                        retVal = BCM_ERR_NOMEM
             else
                (void)RPC_Release(aHdl)
                retVal = BCM_ERR_UNKNOWN

         else
             RPC_MemPeekAppInfo(cmdmsg, &appinfoHdl)
             (If Peek IS BCM_ERR_OK)
                if(aHdl == appinfoHdl)
#ifdef RPC_SLAVE_ENABLE_LOCALCMD_SUPPORT
                    const MSGQ_Type *cmdQ = RPC_MsgQGetCmdQ()

                    retVal = MSGQ_GetMsgIdx(cmdQ, &idx)
                    if(BCM_ERR_OK == retVal)
                        RPC_SlaveCmd[idx].cmd = cmdmsg->cmd
                        RPC_SlaveCmd[idx].payLoadSize = cmdmsg->len
                        RPC_SlaveCmd[idx].result = retVal
                        BCM_MemCpy(&RPC_SlaveCmd[idx].payLoad, cmdmsg->payload,cmdmsg->len)
                        retVal = MSGQ_CompleteMsgIdx(cmdQ, idx)

#endif
                 else
                    retVal = RPC_SlaveAllocLwq(&RPC_SlaveMsgCtx.respQ,
                                               &RPC_SlaveMsgCtx.respUseMask, &idx)
                    if(BCM_ERR_OK == retVal)
                        RPC_SlaveMsgCtx.respHdl[idx] = aHdl
                     else
                        retVal = BCM_ERR_UNKNOWN

                 else
                    retVal = BCM_ERR_UNKNOWN
             else
                 retVal = BCM_ERR_UNKNOWN
    return retVal
    @endcode
*/
static int32_t RPC_SlaveSendMsg(RPC_HdlType aHdl)
{
    uint32_t idx = 0UL;
    int32_t retVal = BCM_ERR_UNKNOWN;
    uint32_t forwardToHost = FALSE;
    uint32_t appinfoHdl;

    RPC_MemMsgType *cmdmsg;

    cmdmsg = RPC_MsgGet(aHdl);
    if(NULL != cmdmsg) {
        if (1UL == ((cmdmsg->cmd & BCM_CMD_ASYNC_MASK) >> BCM_CMD_ASYNC_SHIFT)) {
#ifdef RPC_SLAVE_ENABLE_LOCALCMD_SUPPORT
            uint32_t i;
            BCM_GroupIDType groupID;

            groupID = (uint8_t)BCM_GET_GROUPID(cmdmsg->cmd);
            for(i = 0UL; i < RPC_MASTER_MAX_OBJECTS; i++) {
                if((NULL != RPC_MasterIfcObjects[i])
                    && (groupID == RPC_MasterIfcObjects[i]->group)) {
                    if (NULL != RPC_MasterIfcObjects[i]->server.asyncMsg) {
                        retVal = RPC_MasterIfcObjects[i]->server.asyncMsg(cmdmsg->cmd, cmdmsg->payload, cmdmsg->len, &forwardToHost);
                    } else {
                        retVal = BCM_ERR_OK;
                        RPC_Release(aHdl);
                    }
                    break;
                }
            }
#else
            retVal = BCM_ERR_OK;
            forwardToHost = TRUE;
#endif /* RPC_SLAVE_ENABLE_LOCALCMD_SUPPORT */
            if(BCM_ERR_OK == retVal) {
                if (TRUE == forwardToHost) {
                    retVal = RPC_SlaveAllocLwq(&RPC_SlaveMsgCtx.respQ,
                                               &RPC_SlaveMsgCtx.respUseMask, &idx);
                    if(BCM_ERR_OK == retVal) {
                        RPC_SlaveMsgCtx.respHdl[idx] = aHdl;
                    } else {
                        retVal = BCM_ERR_NOMEM;
                    }
                } else {
                    RPC_Release(aHdl);
                }
            } else {
                retVal = BCM_ERR_UNKNOWN;
                RPC_Release(aHdl);
            }
        } else {
            retVal = RPC_MemPeekAppInfo(cmdmsg, &appinfoHdl);
            if(BCM_ERR_OK == retVal) {
                if(aHdl == appinfoHdl) {
#ifdef RPC_SLAVE_ENABLE_LOCALCMD_SUPPORT
                    const MSGQ_Type *cmdQ = RPC_MsgQGetCmdQ();

                    retVal = MSGQ_GetMsgIdx(cmdQ, &idx);
                    if(BCM_ERR_OK == retVal) {
                        RPC_SlaveCmd[idx].cmd = cmdmsg->cmd;
                        RPC_SlaveCmd[idx].payLoadSize = cmdmsg->len;
                        RPC_SlaveCmd[idx].result = retVal;
                        BCM_MemCpy(&RPC_SlaveCmd[idx].payLoad, cmdmsg->payload,cmdmsg->len);
                        retVal = MSGQ_CompleteMsgIdx(cmdQ, idx);
                        (void)RPC_MemPopAppInfo(aHdl, &appinfoHdl);
                        RPC_Release(aHdl);
                    }
#endif
                } else {
                    retVal = RPC_SlaveAllocLwq(&RPC_SlaveMsgCtx.respQ,
                                               &RPC_SlaveMsgCtx.respUseMask, &idx);
                    if(BCM_ERR_OK == retVal) {
                        RPC_SlaveMsgCtx.respHdl[idx] = aHdl;
                    } else {
                        retVal = BCM_ERR_UNKNOWN;
                    }
                }
            } else {
                retVal = BCM_ERR_UNKNOWN;
            }
        }
    }

    return retVal;
}

/** @brief RPC Slave Interface Receive Message

    Interface function used to receive status.

    @behavior Sync, Non-Reentrant

    @param[out]     aHdl            Handle to received message

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK         Message received successfully and copied
    @retval     #BCM_ERR_BUSY       Command is still being processed
    @retval     #BCM_ERR_NOMEM      Cannot Get the status because of no Memory
    @retval     #BCM_ERR_UNKNOWN    Unknown failure

    @trace #BRCM_SWARCH_RPC_SLAVEIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL

    @limitations None

    @code{.unparsed}
    retVal = MSGQ_GetMsgIdx(RPC_MsgQGetCmdQ, &msgQidx)
    if(BCM_ERR_OK IS retVal)
        retVal = BCM_ERR_UNKNOWN
        if(BCM_ERR_CUSTOM == RPC_SlaveCmd[msgQidx].result)
            retVal = RPC_MsgAlloc(RPC_HDL_INVALID, RPC_SlaveMsgCtx.selfId,
                                                   RPC_SlaveMsgCtx.peerId,
                                                   RPC_SlaveMsgCtx.assocId,
                                                   aHdl)
            if(Message is allocated)
                copy the message from RPC_SlaveCmd[msgQidx] to newHdl
                RPC_MemPushAppInfo(newHdl,newHdl)
                RPC_SlaveMsgCtx.appInfoCntr++
                RPC_SlaveCmd[msgQidx].result = BCM_ERR_BUSY
                *aHdl = newHdl
                retVal = BCM_ERR_OK
            else
                retVal = BCM_ERR_NOMEM
    if(BCM_ERR_OK != retVal)
        retVal = LWQ_Pop(&RPC_SlaveMsgCtx.cmdQ, &idx)
        if(retVal IS NOT BCM_ERR_OK)
            return BCM_ERR_NOT_FOUND
        else
            *aHdl = RPC_SlaveMsgCtx.cmdHdl[idx]
    @endcode
*/
static int32_t RPC_SlaveRecvMsg(RPC_HdlType* const aHdl)
{
    uint8_t idx = 0U;
    int32_t retVal = BCM_ERR_NOT_FOUND;

#ifdef RPC_SLAVE_ENABLE_LOCALCMD_SUPPORT
    uint32_t msgQidx = 0UL;
    RPC_HdlType newHdl;
    RPC_MemMsgType *cmdmsg = NULL;
    const MSGQ_Type *cmdQ = NULL;

    cmdQ = RPC_MsgQGetCmdQ();
    retVal = MSGQ_GetMsgIdx(cmdQ, &msgQidx);
    if(BCM_ERR_OK == retVal) {
        retVal = BCM_ERR_UNKNOWN;
        if(BCM_ERR_CUSTOM == RPC_SlaveCmd[msgQidx].result) {
            retVal = RPC_MsgAlloc(RPC_HDL_INVALID, RPC_SlaveMsgCtx.selfId,
                                                   RPC_SlaveMsgCtx.peerId,
                                                   RPC_SlaveMsgCtx.assocId,
                                                   &newHdl);
            if(BCM_ERR_OK == retVal) {
                cmdmsg = RPC_MsgGet(newHdl);
                cmdmsg->cmd =  RPC_SlaveCmd[msgQidx].cmd;
                cmdmsg->len =  RPC_SlaveCmd[msgQidx].payLoadSize;
                (void)RPC_MemPushAppInfo(newHdl,newHdl);
                RPC_SlaveMsgCtx.appInfoCntr++;
                BCM_MemCpy(cmdmsg->payload, RPC_SlaveCmd[msgQidx].payLoad, RPC_SlaveCmd[msgQidx].payLoadSize);
                RPC_SlaveCmd[msgQidx].result = BCM_ERR_BUSY;
                if (0UL == RPC_SlaveCmd[msgQidx].cfgTimeoutMs) {
                    RPC_SlaveCmd[msgQidx].timeoutNs = RPC_DISABLE_TIMEOUT_VAL;
                } else {
                    RPC_SlaveCmd[msgQidx].timeoutNs = BCM_GetTimeNs() + (RPC_SlaveCmd[msgQidx].cfgTimeoutMs * 1000000ULL);
                }
                RPC_SlaveCmd[msgQidx].hdl = newHdl;
                *aHdl = newHdl;
                retVal = BCM_ERR_OK;
            } else {
                retVal = BCM_ERR_NOMEM;
            }
        } else {
            if (RPC_SlaveCmd[msgQidx].timeoutNs < BCM_GetTimeNs()) {
                RPC_SlaveCmd[msgQidx].result = BCM_ERR_TIME_OUT;
                RPC_Release(RPC_SlaveCmd[msgQidx].hdl);
                retVal = MSGQ_CompleteMsgIdx(cmdQ, msgQidx);
                RPC_Release(*aHdl);
            }
        }
    }
#endif

    /* If No message is available in 'cmdQ' then check for messages in LWQ */
    if(BCM_ERR_OK != retVal) {
        retVal = LWQ_Pop(&RPC_SlaveMsgCtx.cmdQ, &idx);
        if(BCM_ERR_OK != retVal) {
            retVal = BCM_ERR_NOT_FOUND;
        } else {
            *aHdl = RPC_SlaveMsgCtx.cmdHdl[idx];
            RPC_SlaveMsgCtx.cmdUseMask |= (1UL << idx);
        }
    }

    return retVal;
}

/** @brief RPC Slave Interface Process


    @behavior Sync, Non-Reentrant

    @param[in]      void

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             No Errors found
    @retval     #BCM_ERR_TIME_OUT       Connection timed out
    @retval     #BCM_ERR_UNKNOWN        Unknown failure

    @trace #BRCM_SWARCH_RPC_SLAVEIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL

    @limitations None

    @code{.unparsed}
    @endcode
*/
static int32_t RPC_SlaveProcess(void)
{
    return BCM_ERR_OK;
}

#ifdef ENABLE_RPC_SLAVE_STREAM_SUPPORT
/** @brief RPC Slave Interface Detect Stream request

    Detect stream is not relevent for MessageQ Slave Interface

    @behavior Sync, Non-Reentrant

    @param[out]     aHdl            New Handle

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_UNKNOWN        Unknown failure

    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL

    @trace #BRCM_SWARCH_RPC_SLAVEIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL

    @limitations None

    @code{.unparsed}
        return BCM_ERR_UNKNOWN
    @endcode
*/
static int32_t RPC_SlaveDetectStrm(RPC_HdlType* const  aHdl)
{
    return BCM_ERR_UNKNOWN;
}

/** @brief RPC Slave Interface Process Stream

    @trace #BRCM_SWARCH_RPC_SLAVEIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL

    @limitations None

    @code{.unparsed}
    slaveInfo = RPC_StrmGetSlaveClientInfo(aHdl);
    index = RPC_MemGetIndex(aHdl);
    retVal = RPC_StrmGetCfg(aHdl, &cfg);
    if ((retVal is not BCM_ERR_OK) OR (slaveInfo is NULL))
        retVal = BCM_ERR_UNKNOWN
    else if aPeerState is BCM_STATE_SUB_STATE_DONE
        if slaveInfo->state is BCM_STATE_SUB_STATE_STAGE1
            retVal = RPC_LoadCancel(&RPC_SlaveMsgCtx.hdr[index]);
        if retVal is not BCM_ERR_BUSY
            retVal = BCM_ERR_UNKNOWN;
    else
        do
            retVal = RPC_StrmGetFreeSz(aHdl, &size, &wrOffset)
            if retVal is not BCM_ERR_OK
                retVal = BCM_ERR_UNKNOWN;
                break
            if size > (cfg.xferSize - wrOffset)
                size = (cfg.xferSize - wrOffset)
            prevState = slaveInfo->state;
            switch (prevState)
            case BCM_STATE_SUB_STATE_RESET:
                if ((sizeof(ITBL_Type) <= size) AND (0UL != cfg.isTbl))
                    retVal = RPC_StrmWrite(aHdl, (const uint8_t*)RPC_GetImgTbl(cfg.pid), sizeof(ITBL_Type));
                    slaveInfo->state = BCM_STATE_SUB_STATE_DONE;
                    if retVal is not BCM_ERR_OK
                        retVal = BCM_ERR_UNKNOWN
                else if (0UL == cfg.isTbl)
                    slaveInfo->state = BCM_STATE_SUB_STATE_STAGE0;
                else
                    retVal = BCM_ERR_UNKNOWN;
            break;
            case BCM_STATE_SUB_STATE_STAGE0:
                if (size > 0UL)
                    retVal = RPC_LoadRawImg(cfg.pid, cfg.imgId, RPC_SlaveMsgCtx.strmMem[index],
                                    cfg.offset + wrOffset, size, RPC_SlaveEvent, &RPC_SlaveMsgCtx.hdr[index]);
                    if retVal is BCM_ERR_OK
                        slaveInfo->state = BCM_STATE_SUB_STATE_STAGE1;
                    else
                        (void)RPC_StrmSetXferSize(aHdl, 0UL)
                        retVal = BCM_ERR_UNKNOWN;
                else
                    Do Nothing
            break;
            case BCM_STATE_SUB_STATE_STAGE1:
                retVal = RPC_LoadGetStatus(&RPC_SlaveMsgCtx.hdr[index], &size);
                if retVal  is BCM_ERR_BUSY
                    Do nothing, wait for completion
                else if retVal is BCM_ERR_OK
                    retVal = RPC_StrmWrite(aHdl, RPC_SlaveMsgCtx.strmMem[index], size);
                    if retVal is BCM_ERR_OK
                        slaveInfo->state = BCM_STATE_SUB_STATE_DONE;
                    else
                        retVal = BCM_ERR_UNKNOWN;
                else
                    retVal = BCM_ERR_UNKNOWN;
            break;
            case BCM_STATE_SUB_STATE_DONE:
            break;
            default:
                retVal = BCM_ERR_UNKNOWN;
            break;
            }
        } while (prevState != slaveInfo->state);
    }
    if (retVal is BCM_ERR_UNKNOWN) AND (slaveInfo is not NULL)
        slaveInfo->state = BCM_STATE_SUB_STATE_DONE;
    return retVal;
    @endcode
*/
static int32_t RPC_SlaveProcessStrm(RPC_HdlType aHdl, BCM_SubStateType aPeerState)
{
    uint32_t size = 0UL;
    uint32_t wrOffset = 0UL;
    int32_t retVal = BCM_ERR_UNKNOWN;
    RPC_StrmCfgType cfg;
    BCM_SubStateType prevState;
    RPC_MemStrmClientInfoType *slaveInfo = RPC_StrmGetSlaveClientInfo(aHdl);
    uint32_t index = RPC_MemGetIndex(aHdl);

    retVal = RPC_StrmGetCfg(aHdl, &cfg);
    if ((BCM_ERR_OK != retVal) || (NULL == slaveInfo)) {
        retVal = BCM_ERR_UNKNOWN;
    } else if (BCM_STATE_SUB_STATE_DONE == aPeerState) {
        if (BCM_STATE_SUB_STATE_STAGE1 == slaveInfo->state) {
            retVal = RPC_LoadCancel(RPC_SlaveMsgCtx.hdr[index]);
        }
        if (BCM_ERR_BUSY != retVal) {
            retVal = BCM_ERR_UNKNOWN;
        }
    } else {
        do {
            retVal = RPC_StrmGetFreeSz(aHdl, &size, &wrOffset);
            if (BCM_ERR_OK != retVal) {
                retVal = BCM_ERR_UNKNOWN;
                break;
            }
            if(size > (cfg.xferSize - wrOffset)) {
                size = (cfg.xferSize - wrOffset);
            }
            prevState = slaveInfo->state;
            switch (prevState) {
            case BCM_STATE_SUB_STATE_RESET:
                if ((sizeof(ITBL_Type) <= size) && (0UL != cfg.isTbl)) {
                    retVal = RPC_StrmWrite(aHdl, (const uint8_t*)RPC_GetImgTbl(cfg.pid), sizeof(ITBL_Type));
                    slaveInfo->state = BCM_STATE_SUB_STATE_DONE;
                    if (BCM_ERR_OK != retVal) {
                        retVal = BCM_ERR_UNKNOWN;
                    }
                } else if (0UL == cfg.isTbl) {
                    slaveInfo->state = BCM_STATE_SUB_STATE_STAGE0;
                } else {
                    retVal = BCM_ERR_UNKNOWN;
                }
            break;
            case BCM_STATE_SUB_STATE_STAGE0:
                if (size > 0UL) {
                    retVal = RPC_LoadRawImg(cfg.pid, cfg.imgId, RPC_SlaveMsgCtx.strmMem[index],
                                    cfg.offset + wrOffset, size, RPC_SlaveEvent, &RPC_SlaveMsgCtx.hdr[index]);
                    if(BCM_ERR_OK == retVal) {
                        slaveInfo->state = BCM_STATE_SUB_STATE_STAGE1;
                    } else {
                        (void)RPC_StrmSetXferSize(aHdl, 0UL);
                        retVal = BCM_ERR_UNKNOWN;
                    }
                } else {
                    /* Do Nothing */
                }
            break;
            case BCM_STATE_SUB_STATE_STAGE1:
                retVal = RPC_LoadGetStatus(RPC_SlaveMsgCtx.hdr[index], &size);
                if (BCM_ERR_BUSY == retVal) {
                    /* Do nothing, wait for completion */
                } else if (BCM_ERR_OK == retVal) {
                    retVal = RPC_StrmWrite(aHdl, RPC_SlaveMsgCtx.strmMem[index], size);
                    if (BCM_ERR_OK == retVal) {
                        slaveInfo->state = BCM_STATE_SUB_STATE_DONE;
                    } else if (BCM_ERR_NOMEM == retVal) {
                        slaveInfo->state = BCM_STATE_SUB_STATE_STAGE0;
                    } else {
                        retVal = BCM_ERR_UNKNOWN;
                    }
                } else {
                    retVal = BCM_ERR_UNKNOWN;
                }
            break;
            case BCM_STATE_SUB_STATE_DONE:
            break;
            default:
                retVal = BCM_ERR_UNKNOWN;
            break;
            }
        } while (prevState != slaveInfo->state);
    }
    if ((BCM_ERR_UNKNOWN == retVal) && (NULL != slaveInfo)) {
        slaveInfo->state = BCM_STATE_SUB_STATE_DONE;
    }
    return retVal;
}
#endif

/** @brief RPC Slave Interface Disconnect

    Disconnect any active connecion, and perform any coneection related cleanup.
    Interface should accept new connection requests after this API call.
    Unknown failures may be recovered only with deinit and init.

    @behavior Sync, Non-Reentrant

    @param[in]      void

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Disconnection successful
    @retval     #BCM_ERR_UNKNOWN        Unknown failure

    @trace #BRCM_SWARCH_RPC_SLAVEIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL

    @limitations None

    @code{.unparsed}
    @endcode
*/
static int32_t RPC_SlaveDisconnect(void)
{
    return BCM_ERR_OK;
}

/** @brief RPC Slave Interface channel de-initialization

    This API used to deinitialize the Message Queue Slave Interface

    @behavior Sync, Non-Reentrant

    @param[in]      void

    @retval void

    @trace #BRCM_SWARCH_RPC_SLAVEIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL

    @limitations None

    @code{.unparsed}
        Mem Set RPC_SlaveMsgCtx
        Mem Set RPC_SlaveCmd
    @endcode
*/
static void RPC_SlaveDeinit(void)
{
    BCM_MemSet(&RPC_SlaveMsgCtx, 0U, sizeof(RPC_SlaveMsgCtxType));
#ifdef RPC_SLAVE_ENABLE_LOCALCMD_SUPPORT
    BCM_MemSet(RPC_SlaveCmd, 0U, (RPC_SLAVE_LOCAL_MSG_MAX * sizeof(RPC_LocalMsgType)));
#endif
}

/** @brief RPC Slave Interface

    @trace #BRCM_SWARCH_RPC_SLAVEIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL
*/
const RPC_InterfaceType RPC_SlaveIfc = {
    .mode          = RPC_IFC_CHAN_MODE_SLAVE,
    .assoc         = RPC_ASSOCIATIONINDEX_1,
    .init          = RPC_SlaveInit,
    .isConnected   = RPC_SlaveIsConnected,
    .connect       = RPC_SlaveConnect,
    .getMsgSize    = RPC_SlaveGetMsgSize,
    .sendMsg       = RPC_SlaveSendMsg,
    .recvMsg       = RPC_SlaveRecvMsg,
    .processMsg    = RPC_SlaveProcess,
#ifdef ENABLE_RPC_SLAVE_STREAM_SUPPORT
    .detectStrm    = RPC_SlaveDetectStrm,
    .processStrm   = RPC_SlaveProcessStrm,
#endif
    .disconnect    = RPC_SlaveDisconnect,
    .getEventMask  = RPC_SlaveGetEventMask,
    .deinit        = RPC_SlaveDeinit,
};
/** @} */
