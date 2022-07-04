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
    @defgroup grp_rpc_v2_mem_impl Design
    @ingroup grp_rpc_v2_mem

    @addtogroup grp_rpc_v2_mem_impl
    @{
    The RPC Memory interfaces are populated in this file.

    @file rpc_mem.c
    @brief RPC Memory Design
    This source file contains the implementation of functions for RPC Memory

    @version 0.1 Initial version
*/

#include <cpu.h>
#include <bcm_utils.h>
#include <rpc_mem.h>
#include <rpc_mem_osil.h>
/**
    @name RPC memory lib Design ID
    @{
    @brief Design IDs for RPC memory lib
*/
#define BRCM_SWDSGN_RPC_MEM_MAX_CNT_IN_BITS_MACRO    (0xA401U)    /**< @brief #RPC_MEM_MAX_CNT_IN_BITS     */
#define BRCM_SWDSGN_RPC_MEMMSGCONTEXT_TYPE           (0xA402U)    /**< @brief #RPC_MemMsgContextType       */
#define BRCM_SWDSGN_RPC_MEMSTRMCONTEXT_TYPE          (0xA403U)    /**< @brief #RPC_MemStrmContextType      */
#define BRCM_SWDSGN_RPC_MEMCONTEXT_TYPE              (0xA404U)    /**< @brief #RPC_MemContextType          */
#define BRCM_SWDSGN_RPC_MEMCTX_GLOBAL                (0xA405U)    /**< @brief #RPC_MemCtx                  */
#define BRCM_SWDSGN_RPC_MEMGETIDX_PROC               (0xA406U)    /**< @brief #RPC_MemGetIdx               */
#define BRCM_SWDSGN_RPC_MEMVALIDATEMSGHDL_PROC       (0xA407U)    /**< @brief #RPC_MemValidateMsgHdl       */
#define BRCM_SWDSGN_RPC_MEMVALIDATESTRMHDL_PROC      (0xA408U)    /**< @brief #RPC_MemValidateStrmHdl      */
#define BRCM_SWDSGN_RPC_MEMGETWRSIZE_PROC            (0xA409U)    /**< @brief #RPC_MemGetWrSize            */
#define BRCM_SWDSGN_RPC_MEMGETFILLEDSZ_PROC          (0xA40AU)    /**< @brief #RPC_MemGetRdSize            */
#define BRCM_SWDSGN_RPC_MEMCPYLIN2CIR_PROC           (0xA40BU)    /**< @brief #RPC_MemCpyLin2Cir           */
#define BRCM_SWDSGN_RPC_MEMCPYCIR2LIN_PROC           (0xA40CU)    /**< @brief #RPC_MemCpyCir2Lin           */
#define BRCM_SWDSGN_RPC_MEM_INIT_PROC                (0xA40DU)    /**< @brief #RPC_MemInit                 */
#define BRCM_SWDSGN_RPC_MSG_SCRATCH_PROC             (0xA40EU)    /**< @brief #RPC_MsgScratch              */
#define BRCM_SWDSGN_RPC_MSG_ALLOC_PROC               (0xA40FU)    /**< @brief #RPC_MsgAlloc                */
#define BRCM_SWDSGN_RPC_MSG_GET_PROC                 (0xA410U)    /**< @brief #RPC_MsgGet                  */
#define BRCM_SWDSGN_RPC_STRM_ALLOC_PROC              (0xA411U)    /**< @brief #RPC_StrmAlloc               */
#define BRCM_SWDSGN_RPC_STRM_GET_CFG_PROC            (0xA412U)    /**< @brief #RPC_StrmGetCfg              */
#define BRCM_SWDSGN_RPC_STRM_FREE_SZ_PROC            (0xA413U)    /**< @brief #RPC_StrmGetFreeSz           */
#define BRCM_SWDSGN_RPC_STRM_FILLED_SZ_PROC          (0xA414U)    /**< @brief #RPC_StrmGetFilledSz         */
#define BRCM_SWDSGN_RPC_STRM_WRITE_PROC              (0xA415U)    /**< @brief #RPC_StrmWrite               */
#define BRCM_SWDSGN_RPC_STRM_READ_PROC               (0xA416U)    /**< @brief #RPC_StrmRead                */
#define BRCM_SWDSGN_RPC_ACQUIRE_PROC                 (0xA417U)    /**< @brief #RPC_Acquire                 */
#define BRCM_SWDSGN_RPC_RELEASE_PROC                 (0xA418U)    /**< @brief #RPC_Release                 */
#define BRCM_SWDSGN_RPC_MEM_DEINIT_PROC              (0xA419U)    /**< @brief #RPC_MemDeinit               */
#define BRCM_SWDSGN_RPC_STRMGETSLAVECLIENTINFO_PROC  (0xA41AU)    /**< @brief #RPC_StrmGetSlaveClientInfo  */
#define BRCM_SWDSGN_RPC_STRMGETMASTERCLIENTINFO_PROC (0xA41BU)    /**< @brief #RPC_StrmGetMasterClientInfo */
#define BRCM_SWDSGN_RPC_MEMPUSHAPPINFO_PROC          (0xA41CU)    /**< @brief #RPC_MemPushAppInfo          */
#define BRCM_SWDSGN_RPC_MEMPOPAPPINFO_PROC           (0xA41DU)    /**< @brief #RPC_MemPopAppInfo           */
#define BRCM_SWDSGN_RPC_MEMPEEKAPPINFO_PROC          (0xA41EU)    /**< @brief #RPC_MemPeekAppInfo          */
#define BRCM_SWDSGN_RPC_GETSTREAMSTATUS_PROC         (0xA41FU)    /**< @brief #RPC_GetStreamStatus         */
#define BRCM_SWDSGN_RPC_STRM_PEEK_PROC               (0xA420U)    /**< @brief #RPC_StrmPeek                */
#define BRCM_SWDSGN_RPC_STRMSETXFERSIZE_PROC         (0xA421U)    /**< @brief #RPC_StrmSetXferSize         */
#define BRCM_SWDSGN_RPC_MSGPUSHPAPPINFO_PROC         (0xA422U)    /**< @brief #RPC_MsgPushAppInfo          */
#define BRCM_SWDSGN_RPC_MSGPOPPAPPINFO_PROC          (0xA423U)    /**< @brief #RPC_MsgPopAppInfo           */
#define BRCM_SWDSGN_RPC_MSGINIT_PROC                 (0xA424U)    /**< @brief #RPC_MsgInit                 */
/** @} */

/**
    @brief RPC Max Memory in No Of Bits

    @trace #BRCM_SWARCH_RPC_MSG_ALLOC_PROC
    @trace #BRCM_SWARCH_RPC_STRM_ALLOC_PROC
    @trace #BRCM_SWREQ_RPC_MEM
*/
#define RPC_MEM_MAX_CNT_IN_BITS (31UL)

/**
    @brief Handle type

    @trace #BRCM_SWARCH_RPC_MSG_GET_PROC
    @trace #BRCM_SWARCH_RPC_STRM_GET_CFG_PROC
    @trace #BRCM_SWARCH_RPC_STRM_FREE_SZ_PROC
    @trace #BRCM_SWARCH_RPC_STRM_FILLED_SZ_PROC
    @trace #BRCM_SWARCH_RPC_STRM_WRITE_PROC
    @trace #BRCM_SWARCH_RPC_STRM_READ_PROC
    @trace #BRCM_SWARCH_RPC_ACQUIRE_PROC
    @trace #BRCM_SWARCH_RPC_RELEASE_PROC
    @trace #BRCM_SWREQ_RPC_MEM
*/
static inline uint8_t RPC_MemGetIdx(RPC_HdlType aHdl)
{
        return (uint8_t)((aHdl & RPC_HDL_IDX_MASK) >> RPC_HDL_IDX_SHIFT);
}

/**
    @brief RPC Message memory context Type

    @trace #BRCM_SWARCH_RPC_MEM_INIT_PROC
    @trace #BRCM_SWARCH_RPC_MSG_ALLOC_PROC
    @trace #BRCM_SWARCH_RPC_STRM_ALLOC_PROC
    @trace #BRCM_SWARCH_RPC_STRM_GET_CFG_PROC
    @trace #BRCM_SWARCH_RPC_STRM_FREE_SZ_PROC
    @trace #BRCM_SWARCH_RPC_STRM_FILLED_SZ_PROC
    @trace #BRCM_SWARCH_RPC_STRM_WRITE_PROC
    @trace #BRCM_SWARCH_RPC_STRM_READ_PROC
    @trace #BRCM_SWARCH_RPC_ACQUIRE_PROC
    @trace #BRCM_SWARCH_RPC_RELEASE_PROC
    @trace #BRCM_SWARCH_RPC_MEM_DEINIT_PROC
    @trace #BRCM_SWREQ_RPC_MEM
*/
typedef struct sRPC_MemMsgContextType {
    RPC_HdlType              hdl;         /**< @brief Command handler         */
    RPC_AssociationIndexType assocId;     /**< @brief Association ID of hdl   */
    uint32_t                 refCount;    /**< @brief Reference Count         */
} RPC_MemMsgContextType;

/**
    @brief RPC Stream memory context Type

    @trace #BRCM_SWARCH_RPC_MEM_INIT_PROC
    @trace #BRCM_SWARCH_RPC_STRM_ALLOC_PROC
    @trace #BRCM_SWARCH_RPC_STRM_GET_CFG_PROC
    @trace #BRCM_SWARCH_RPC_STRM_FREE_SZ_PROC
    @trace #BRCM_SWARCH_RPC_STRM_FILLED_SZ_PROC
    @trace #BRCM_SWARCH_RPC_STRM_WRITE_PROC
    @trace #BRCM_SWARCH_RPC_STRM_READ_PROC
    @trace #BRCM_SWARCH_RPC_ACQUIRE_PROC
    @trace #BRCM_SWARCH_RPC_RELEASE_PROC
    @trace #BRCM_SWARCH_RPC_MEM_DEINIT_PROC
    @trace #BRCM_SWREQ_RPC_MEM
*/
typedef struct sRPC_MemStrmContextType {
    RPC_HdlType               hdl;       /**< @brief Stream Handle                      */
    uint32_t                  refCount;  /**< @brief Reference Count                    */
    RPC_StrmCfgType           cfg;       /**< @brief stream Configuration               */
    uint32_t                  readLen;   /**< @brief Length of buff read so far         */
    uint32_t                  writeLen;  /**< @brief Length of buff written so far      */
    RPC_MemStrmClientInfoType slaveInfo; /**< @brief Slave client information           */
    RPC_MemStrmClientInfoType mstrInfo;  /**< @brief Master client information          */
} RPC_MemStrmContextType;

/**
    @brief RPC memory context Type

    @trace #BRCM_SWARCH_RPC_MEM_INIT_PROC
    @trace #BRCM_SWARCH_RPC_MSG_ALLOC_PROC
    @trace #BRCM_SWARCH_RPC_STRM_ALLOC_PROC
    @trace #BRCM_SWARCH_RPC_STRM_GET_CFG_PROC
    @trace #BRCM_SWARCH_RPC_STRM_FREE_SZ_PROC
    @trace #BRCM_SWARCH_RPC_STRM_FILLED_SZ_PROC
    @trace #BRCM_SWARCH_RPC_STRM_WRITE_PROC
    @trace #BRCM_SWARCH_RPC_STRM_READ_PROC
    @trace #BRCM_SWARCH_RPC_ACQUIRE_PROC
    @trace #BRCM_SWARCH_RPC_RELEASE_PROC
    @trace #BRCM_SWARCH_RPC_MEM_DEINIT_PROC
    @trace #BRCM_SWREQ_RPC_MEM
*/
typedef struct sRPC_MemContextType {
    uint32_t msgKeyCntr;                 /**< @brief Message Key Counter */
    uint32_t streamKeyCntr;              /**< @brief stream Key Counter */
    uint32_t msgUsageBitMask;            /**< @brief Message 1:Available 0:Busy */
    uint32_t streamUsageBitMask;         /**< @brief Stream 1:Available 0:Busy */
    RPC_AssociationIndexType assocCntr[RPC_ASSOCIATIONINDEX_MAX];  /**< @brief handle's allocation per association */
    RPC_MemMsgContextType msgCtx[RPC_MEM_MAX_CNT_MSG]; /**< @brief Message Context*/
    RPC_MemStrmContextType streamCtx[RPC_MEM_MAX_CNT_STRM]; /**< @brief Stream Context*/
} RPC_MemContextType;

/**
    @brief Memory context

    @trace #BRCM_SWARCH_RPC_MEM_INIT_PROC
    @trace #BRCM_SWARCH_RPC_MSG_ALLOC_PROC
    @trace #BRCM_SWARCH_RPC_STRM_ALLOC_PROC
    @trace #BRCM_SWARCH_RPC_STRM_GET_CFG_PROC
    @trace #BRCM_SWARCH_RPC_STRM_FREE_SZ_PROC
    @trace #BRCM_SWARCH_RPC_STRM_FILLED_SZ_PROC
    @trace #BRCM_SWARCH_RPC_STRM_WRITE_PROC
    @trace #BRCM_SWARCH_RPC_STRM_READ_PROC
    @trace #BRCM_SWARCH_RPC_ACQUIRE_PROC
    @trace #BRCM_SWARCH_RPC_RELEASE_PROC
    @trace #BRCM_SWARCH_RPC_MEM_DEINIT_PROC
    @trace #BRCM_SWREQ_RPC_MEM
*/
static RPC_MemContextType RPC_MemCtx COMP_SECTION(".bss.rpc");

/** @brief Validate the message handle

    This API match the handlewith the
    RPC_MemCtx.msgCtx handle and return the result

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aHdl               Handle to look for in the pool of
                                       available messages

    @retval     #BCM_ERR_OK             Matching message found
    @retval     #BCM_ERR_INVAL_PARAMS   aHdl is RPC_HDL_INVALID
                                        OR aHdl is Stale

    @trace #BRCM_SWARCH_RPC_MSG_ALLOC_PROC
    @trace #BRCM_SWARCH_RPC_MSG_GET_PROC
    @trace #BRCM_SWARCH_RPC_ACQUIRE_PROC
    @trace #BRCM_SWARCH_RPC_RELEASE_PROC
    @trace #BRCM_SWREQ_RPC_MEM

    @code{.c}
    idx = RPC_MemGetIdx(aHdl)
    if (aHdl is RPC_HDL_INVALID)
        OR (Not a RPC_HDL_TYPE_MSG)
        OR (index >= RPC_Memory.msgCnt)
        OR (RPC_MemCtx.msgCtx[idx].refCount IS 0)
        OR (RPC_MemCtx.RPC_MsgCtx[idx].hdl != aHdl)
        return BCM_ERR_INVAL_PARAMS;
    else
        return BCM_ERR_OK
    @endcode
*/
static int32_t RPC_MemValidateMsgHdl(RPC_HdlType aHdl)
{
    int32_t retVal;
    uint32_t idx;

    idx = RPC_MemGetIdx(aHdl);
    if((RPC_HDL_INVALID == aHdl)
          || (RPC_HDL_TYPE_MSG != RPC_MemGetType(aHdl))
          || (RPC_Memory.msgCnt <= idx)
          || (0UL == RPC_MemCtx.msgCtx[idx].refCount)
          || (RPC_MemCtx.msgCtx[idx].hdl != aHdl)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        retVal = BCM_ERR_OK;
    }

    return retVal;
}

/** @brief Validate the stream handle

    This API match the handlewith the
    RPC_MemCtx.streamCtx handle and return the result

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aHdl               Handle to look for in the pool of
                                       available streams

    @retval     #BCM_ERR_OK             Matching stream found
    @retval     #BCM_ERR_NOT_FOUND      aHdl is stale
    @retval     #BCM_ERR_INVAL_PARAMS   aHdl is RPC_HDL_INVALID
                                        OR aHdl is Stale

    @trace #BRCM_SWARCH_RPC_STRM_ALLOC_PROC
    @trace #BRCM_SWARCH_RPC_STRM_GET_CFG_PROC
    @trace #BRCM_SWARCH_RPC_STRM_FREE_SZ_PROC
    @trace #BRCM_SWARCH_RPC_STRM_FILLED_SZ_PROC
    @trace #BRCM_SWARCH_RPC_STRM_WRITE_PROC
    @trace #BRCM_SWARCH_RPC_STRM_READ_PROC
    @trace #BRCM_SWARCH_RPC_ACQUIRE_PROC
    @trace #BRCM_SWARCH_RPC_RELEASE_PROC
    @trace #BRCM_SWREQ_RPC_MEM

    @code{.c}
    idx = RPC_MemGetIdx(aHdl)
    if (aHdl is RPC_HDL_INVALID)
        OR (Not a RPC_HDL_TYPE_STRM)
        OR (index >= RPC_Memory.strmCnt)
        OR (RPC_MemCtx.streamCtx[idx].refCount IS 0)
        OR (RPC_MemCtx.RPC_streamCtx[idx].hdl != aHdl)
        return BCM_ERR_INVAL_PARAMS
    else
        return BCM_ERR_OK
    @endcode
*/
static int32_t RPC_MemValidateStrmHdl(RPC_HdlType aHdl)
{
    int32_t retVal;
    uint32_t idx;

    idx = RPC_MemGetIdx(aHdl);
    if((RPC_HDL_INVALID == aHdl)
          || (RPC_HDL_TYPE_STRM != RPC_MemGetType(aHdl))
          || (RPC_Memory.strmCnt <= idx)
          || (0UL == RPC_MemCtx.streamCtx[idx].refCount)
          || (RPC_MemCtx.streamCtx[idx].hdl != aHdl)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        retVal = BCM_ERR_OK;
    }

    return retVal;
}

/** @brief Get the available Size in a Stream

    @behavior Sync, Re-entrant

    @pre None

    @param[in]       aStrm               Stream Context
    @param[in]       aMaxSize            Maximum Buffer size of Stream
    @param[out]      aSize               data available to write

    @return void

    @trace #BRCM_SWARCH_RPC_STRM_WRITE_PROC
    @trace #BRCM_SWARCH_RPC_STRM_FREE_SZ_PROC
    @trace #BRCM_SWREQ_RPC_MEM

    @code{.c}
        FilledSize = aStrm->writeLen - aStrm->readLen
        available Space to write (*aSize) = (RPC_Memory.strmSize - FilledSize);
    @endcode
*/
static inline void RPC_MemGetWrSize(RPC_MemStrmContextType *aStrm, uint32_t aMaxSize,
                               uint32_t *aSize)
{
    uint32_t FilledSize;

    /* Total Written data */
    FilledSize = aStrm->writeLen - aStrm->readLen;
    /* Space available to write the data */
    *aSize = (aMaxSize - FilledSize);
}

/** @brief Get the available data in a Stream

    @behavior Sync, Re-entrant

    @pre None

    @param[in]       aStrm               Stream Context
    @param[in]       aMaxSize            Maximum Buffer size of Stream
    @param[out]      aSize               data available to read

    @return void

    @trace #BRCM_SWARCH_RPC_STRM_READ_PROC
    @trace #BRCM_SWARCH_RPC_STRM_FILLED_SZ_PROC
    @trace #BRCM_SWREQ_RPC_MEM

    @code{.c}
        Total available data to read(*aSize) = aStrm->writeLen - aStrm->readLen
    @endcode
*/
static inline void RPC_MemGetRdSize(RPC_MemStrmContextType *aStrm, uint32_t aMaxSize,
                                 uint32_t *aSize)
{
    *aSize = aStrm->writeLen - aStrm->readLen;
}

/** @brief Write the data from linear buffer to circular buffer

    This function copy the data from aLinBuff. to aCirBuff
    aCirBuff is a stream buffer in which data can be written in circular.
    aLinBuff is a buffer from where the data to be copied to circular buffer.

    <BR>
    case1:
    If there is no data written, then it writes till end of the buffer size
    @image html lin2circase1.jpg "Linear To Circular Case 1"

    <BR>
    case2:
    If the size of the data to be written is within the remaining space of the buffer,
    then it writes the data in linear till the end of the buffer.
    @image html lin2circase2.jpg "Linear To Circular Case 2"

    <BR>
    case3:
    If the size of the data to be written is more than the remaining space of the buffer,
    then it writes the data in linear till the end of the buffer and starts writing the data
    from the begining of the buffer till the available size
    @image html lin2circase3.jpg "Linear To Circular Case 3"

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aStrm           Stream
    @param[in]      aMaxCirBuffSz   Maximum Buffer size of Stream Memory
    @param[in]      aWrSize         Available size to write
    @param[in]      aLinBuff        In Linear data buffer
    @param[out]     aCirBuff        stream data buffer

    @retval     #BCM_ERR_OK             Copy Successful, and xfer completed
    @retval     #BCM_ERR_NOMEM          Copy successful, xfer still pending
    @retval     #BCM_ERR_INVAL_PARAMS   Total size more than transfer size

    @trace #BRCM_SWARCH_RPC_STRM_WRITE_PROC
    @trace #BRCM_SWARCH_RPC_STRM_READ_PROC
    @trace #BRCM_SWREQ_RPC_MEM

    @code{.c}
        wrOffSet = aStrm->writeLen % aMaxCirBuffSz
        maxLinCpySz = calculate the Remaining space in the buffer on present iteration
        if(aSize <= Available space in this buffer)
            copy the data from 'aLinBuff' to 'aCirBuff' of size 'aSize'
        else
            cirMem = calculate the data to be written/read on circular
            copy the data from 'aLinBuff' to 'aCirBuff' of size 'maxLinCpySz'
            copy the data from 'aLinBuff' to 'aCirBuff' of size 'cirMem'
        total length written so far += aSize
        if(total written length = transfer size)
            return BCM_ERR_OK
        else
            return BCM_ERR_NOMEM
    @endcode
*/
static int32_t RPC_MemCpyLin2Cir(RPC_MemStrmContextType *aStrm, uint32_t aMaxCirBuffSz,
                                           uint32_t aSize, const uint8_t *aLinBuff, uint8_t *aCirBuff)
{
    int32_t retVal;
    uint32_t wrOffSet;
    uint32_t maxLinCpySz;   /* Remaining space in the present buffer*/
    uint32_t cirMem;     /* available space in circular */

    if ((aStrm->writeLen + aSize) > aStrm->cfg.xferSize) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        wrOffSet = aStrm->writeLen % aMaxCirBuffSz;
        /* Remaining space in the buffer on present iteration */
        maxLinCpySz = aMaxCirBuffSz - wrOffSet;
        if(aSize <= maxLinCpySz) {
        /* If the write size is within the current buffer space */
            BCM_MemCpy((aCirBuff + wrOffSet), aLinBuff, aSize);
        } else {
            /* Check if the buffer to be filled from begining for circlular */
            cirMem = aSize - maxLinCpySz;
            /* Write data to End Of Buffer */
            BCM_MemCpy((aCirBuff + wrOffSet), aLinBuff, maxLinCpySz);
            /* Write data from begining Of the Buffer */
            BCM_MemCpy(aCirBuff, (aLinBuff+maxLinCpySz), cirMem);
        }
        aStrm->writeLen += aSize;

        if(aStrm->cfg.xferSize == aStrm->writeLen) {
            retVal = BCM_ERR_OK;
        } else {
            retVal = BCM_ERR_NOMEM;
        }
    }
    return retVal;
}

/** @brief Read the data from circular to linear buffer

    This function copy the data from aCirBuff to aLinBuff
    aCirBuff is a stream buffer in which data can be read in circular.
    aLinBuff is a buffer to where the data to be copied from circular buffer.

    case1:
    If the buffer is full
    @image html cir2lincase1.jpg "Circular To Linear Case 1"

    case2:
    If the size of the data to be read is within the remaining space of the buffer,
    then it reads the data in linear to the end of the buffer till available data.
    @image html cir2lincase2.jpg "Circular To Linear Case 2"

    case3:
    If the size of the data to be read is more than the remaining space of the buffer,
    then it reads the data in linear till the end of the buffer.
    And next it starts reading from the beginning of the buffer till the requested size
    @image html cir2lincase3.jpg "Circular To Linear Case 3"
    @behavior Sync, Re-entrant

    @pre None

    @param[in]     aStrm           Stream context
    @param[in]     aMaxCirBuffSz   Maximum Buffer size of Stream Memory
    @param[in]     asize           Available size to read
    @param[in]     aCirBuff        stream data buffer
    @param[out]    aLinBuff        out Linear data buffer
    @param[in]     aIsPeek         Boolean to indicate if its a PEEK/READ
                                   TRUE: Stream peek
                                   FALSE: Stream read

    @retval     #BCM_ERR_OK             Copy Successful, and xfer completed
    @retval     #BCM_ERR_NOMEM          Copy successful, xfer still pending
    @retval     #BCM_ERR_INVAL_PARAMS   Total size more than transfer size

    @trace #BRCM_SWARCH_RPC_STRM_READ_PROC
    @trace #BRCM_SWREQ_RPC_MEM

    @code{.c}
    rdOffset = aStrm->readLen % aMaxCirBuffSz
    maxLinCpySz = calculate the Remaining data in the buffer on present iteration
    if(aSize <= Available data in this buffer)
        copy the data from 'aCirBuff' to 'aLinBuff' of size 'aSize'
    else
        cirMem = calculate the data to be read on circular
        copy the data from 'aCirBuff' to 'aLinBuff' of size 'maxLinCpySz'
        copy the remaining data from 'aCirBuff' to 'aLinBuff' of size 'cirMem'
    if FALSE == aIsPeek
        total length read so far(aStrm.readLen) += aSize
    if(total read length = transfer size)
        return BCM_ERR_OK
    else
        return BCM_ERR_NOMEM
    @endcode
*/
static int32_t RPC_MemCpyCir2Lin(RPC_MemStrmContextType *aStrm, uint32_t aMaxCirBuffSz,
                                 uint32_t aSize, uint8_t *aCirBuff, uint8_t *aLinBuff,
                                 uint32_t aIsPeek)
{
    int32_t retVal;
    uint32_t rdOffset;
    uint32_t maxLinCpySz;   /* Remaining space in the present buffer*/
    uint32_t cirMem;     /* available space in circular */

    if ((aStrm->readLen + aSize) > aStrm->cfg.xferSize) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        rdOffset = aStrm->readLen % aMaxCirBuffSz;
        /* Remaining space in the buffer on present iteration */
        maxLinCpySz = aMaxCirBuffSz - rdOffset;
        if(aSize <= maxLinCpySz) {
        /* If the write size is within the current buffer space */
            BCM_MemCpy(aLinBuff, (aCirBuff + rdOffset), aSize);
        } else {
            /* Check if the buffer to be filled from begining for circlular */
            cirMem = aSize - maxLinCpySz;
            /* Write data to End Of Buffer */
            BCM_MemCpy(aLinBuff, (aCirBuff + rdOffset), maxLinCpySz);
            /* Write data from begining Of the Buffer */
            BCM_MemCpy((aLinBuff+maxLinCpySz),aCirBuff, cirMem);
        }

        /* Increment only if its 'read' and not a 'peek' */
        if (FALSE == aIsPeek) {
            aStrm->readLen += aSize;
        }

        if(aStrm->cfg.xferSize == aStrm->readLen) {
            retVal = BCM_ERR_OK;
        } else {
            retVal = BCM_ERR_NOMEM;
        }
    }

    return retVal;
}

/** @brief Initialize RPC Memory

    Initialize RPC Memory block, its internal context and data strcutures

    @trace #BRCM_SWARCH_RPC_MEM_INIT_PROC
    @trace #BRCM_SWREQ_RPC_MEM

    @code{.c}
        Memset 0U to RPC_Memory.msgPool
        Memset 0U to RPC_Memory.strmPool
        Memset 0U to RPC_MemCtx
        Enable the BitMask for the actuval allocated memory for message and stream
    @endcode
*/
void RPC_MemInit(void)
{
    uint32_t i;

    BCM_MemSet(RPC_Memory.msgPool, 0U, sizeof(RPC_MemMsgType) * RPC_Memory.msgCnt);
    BCM_MemSet(RPC_Memory.strmPool, 0U, RPC_Memory.strmSize * RPC_Memory.strmCnt);
    for(i=0; i<RPC_Memory.msgCnt; i++){
        RPC_MemCtx.msgUsageBitMask |= (1UL << i);
    }
    for(i=0; i<RPC_Memory.strmCnt; i++){
        RPC_MemCtx.streamUsageBitMask |= (1UL << i);
    }
    RPC_MemCtx.msgKeyCntr = 1UL;
    RPC_MemCtx.streamKeyCntr = 1UL;
}

/** @brief Get Scratch Message for temporary use


    @trace #BRCM_SWARCH_RPC_MSG_SCRATCH_PROC
    @trace #BRCM_SWREQ_RPC_MEM

    @code{.c}
        return pointer to RPC_Memory.scratch
    @endcode
*/
RPC_MemMsgType* RPC_MsgScratch(void)
{
    return RPC_Memory.scratch;
}

/** @brief Allocate/Clone a Message Handle

    @trace #BRCM_SWARCH_RPC_MSG_ALLOC_PROC
    @trace #BRCM_SWREQ_RPC_MEM

    @code{.c}
        get the free index
        if (aOutHdl is NULL)
            return BCM_ERR_INVAL_PARAMS
        else if (RPC_Memory.msgCnt <= index)
            return BCM_ERR_NOMEM
        else if (aInHdl IS stale)
            return BCM_ERR_INVAL_PARAMS
        else
            memset the RPC_MemCtx.msgCtx[idx]
            Prepare the Handle in *aOutHdl with idx, aClientID0, aClientID1, RPC_HDL_TYPE_MSG, Hash Key
            update the RPC_MemCtx.msgCtx[idx].hdl
            Increment the reference count in RPC_MemCtx.msgCtx[idx]
            Increment the hash key counter
            clear the bitmask in RPC_MemCtx.msgUsageBitMask to Block the memory
            RPC_MemCtx.msgCtx[idx].assocId = aAssocID
            RPC_MemCtx.assocCntr[aAssocID]++
            if(aInHdl IS valid)
                clone the handle
                Clear the appinfo and appinfoTop in cloned handle
            return BCM_ERR_OK
    @endcode
*/
int32_t RPC_MsgAlloc(RPC_HdlType aInHdl,
                            RPC_InterfaceIdType aSlaveID,
                            RPC_InterfaceIdType aMasterID,
                            RPC_AssociationIndexType aAssocID,
                            RPC_HdlType *aOutHdl)
{
    uint32_t zerosCnt;
    uint32_t i;
    uint32_t idx;
    int32_t retVal;

    zerosCnt = CPU_Clz(RPC_MemCtx.msgUsageBitMask);
    idx = RPC_MEM_MAX_CNT_IN_BITS - zerosCnt;
    if(NULL == aOutHdl) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if((RPC_Memory.msgCnt <= idx) || (RPC_MAX_HANDLES_PER_ASSOC == RPC_MemCtx.assocCntr[aAssocID])){
        retVal = BCM_ERR_NOMEM;
    } else if((RPC_HDL_INVALID != aInHdl)
                 &&(BCM_ERR_OK != RPC_MemValidateMsgHdl(aInHdl))) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        BCM_MemSet(&RPC_MemCtx.msgCtx[idx], 0U, sizeof(RPC_MemMsgContextType));
        *aOutHdl = (((RPC_MemCtx.msgKeyCntr << RPC_HDL_HASH_SHIFT) & RPC_HDL_KEY_MASK)
                     | ((aSlaveID << RPC_HDL_SLAVEID_SHIFT) & RPC_HDL_SLAVEID_MASK)
                     | ((aMasterID << RPC_HDL_MASTERID_SHIFT) & RPC_HDL_MASTERID_MASK)
                     | (RPC_HDL_TYPE_MSG  << RPC_HDL_TYPE_SHIFT)
                     | ((idx << RPC_HDL_IDX_SHIFT) & RPC_HDL_IDX_MASK));
        RPC_MemCtx.msgCtx[idx].hdl = *aOutHdl;
        RPC_MemCtx.msgCtx[idx].refCount++;
        RPC_MemCtx.msgKeyCntr++;
        RPC_MemCtx.msgUsageBitMask &= ~(1UL << idx);
        RPC_MemCtx.msgCtx[idx].assocId = aAssocID;
        RPC_MemCtx.assocCntr[aAssocID]++;
        if(RPC_HDL_INVALID != aInHdl) {
            BCM_MemCpy(&RPC_Memory.msgPool[idx],
                 &RPC_Memory.msgPool[((aInHdl & RPC_HDL_IDX_MASK) >> RPC_HDL_IDX_SHIFT)],
                 sizeof(RPC_MemMsgType));
        }
        for(i=0UL; i<RPC_MEM_MAX_CNT_APPINFO; i++) {
            RPC_Memory.msgPool[idx].appinfo[i] = 0UL;
        }
        RPC_Memory.msgPool[idx].appinfoTop = 0UL;
        retVal = BCM_ERR_OK;
    }

    return retVal;
}

/** @brief Get Message content for a handle

    @trace #BRCM_SWARCH_RPC_MSG_GET_PROC
    @trace #BRCM_SWREQ_RPC_MEM

    @code{.c}
        match aHdl with handle present in the msgContext.
        If it matches
            return the memory pointer of the index
        else
            return NULL
    @endcode
*/
RPC_MemMsgType* RPC_MsgGet(RPC_HdlType aHdl)
{
    int32_t retVal;
    uint32_t idx;
    RPC_MemMsgType *msgPtr;

    idx = RPC_MemGetIdx(aHdl);
    retVal = RPC_MemValidateMsgHdl(aHdl);
    if(BCM_ERR_OK == retVal) {
        msgPtr = &RPC_Memory.msgPool[idx];
    } else {
        msgPtr = NULL;
    }

    return msgPtr;
}

/** @brief Allocate a stream handle

    Allocation can hold multiples of given size, when successful.

    @trace #BRCM_SWARCH_RPC_STRM_ALLOC_PROC
    @trace #BRCM_SWREQ_RPC_MEM

    @code{.c}
        get the free index
        if index is out of Boundary
            return BCM_ERR_NOMEM
        else
            index = RPC_MEM_MAX_CNT_IN_BITS - index

        if (aOutHdl is NULL) OR (aConfig IS NULL)
            return BCM_ERR_INVAL_PARAMS
        else if (RPC_Memory.strmCnt <= idx)
            return BCM_ERR_NOMEM
        else
            memset the RPC_MemCtx.msgCtx[idx]
            Prepare the Handle in *aOutHdl with idx, aClientID0, aClientID1, RPC_HDL_TYPE_MSG, Hash Key
            update the RPC_MemCtx.msgCtx[idx].hdl
            Increment the reference count in RPC_MemCtx.msgCtx[idx]
            Increment the hash key counter
            clear the bitmask in RPC_MemCtx.msgUsageBitMask to Block the memory
            if(aInHdl IS NOT RPC_HDL_INVALID)
                clone the handle
            return BCM_ERR_OK
    @endcode
*/
int32_t RPC_StrmAlloc(RPC_StrmCfgType * aConfig,
                            RPC_InterfaceIdType aSlaveID,
                            RPC_InterfaceIdType aMasterID,
                            RPC_AssociationIndexType aAssocID,
                            RPC_HdlType *aOutHdl)
{
    uint32_t idx;
    uint32_t zerosCnt;
    int32_t retVal;

    zerosCnt = CPU_Clz(RPC_MemCtx.streamUsageBitMask);
    /* get the actuval index by subtract from 31 */
    idx = RPC_MEM_MAX_CNT_IN_BITS - zerosCnt;
    if((NULL == aOutHdl) || (NULL == aConfig)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if(RPC_Memory.strmCnt <= idx) {
        retVal = BCM_ERR_NOMEM;
    } else {
        BCM_MemSet(&RPC_MemCtx.streamCtx[idx], 0U, sizeof(RPC_MemStrmContextType));
        *aOutHdl = (((RPC_MemCtx.streamKeyCntr << RPC_HDL_HASH_SHIFT) & RPC_HDL_KEY_MASK)
                     | ((aSlaveID << RPC_HDL_SLAVEID_SHIFT) & RPC_HDL_SLAVEID_MASK)
                     | ((aMasterID << RPC_HDL_MASTERID_SHIFT) & RPC_HDL_MASTERID_MASK)
                     | (RPC_HDL_TYPE_STRM  << RPC_HDL_TYPE_SHIFT)
                     | ((idx << RPC_HDL_IDX_SHIFT) & RPC_HDL_IDX_MASK));
        RPC_MemCtx.streamCtx[idx].hdl = *aOutHdl;
        RPC_MemCtx.streamCtx[idx].refCount++;
        RPC_MemCtx.streamKeyCntr++;
        RPC_MemCtx.streamUsageBitMask &= ~(1UL << idx);
        BCM_MemCpy(&RPC_MemCtx.streamCtx[idx].cfg, aConfig, sizeof(RPC_StrmCfgType));
        retVal = BCM_ERR_OK;
    }

    return retVal;
}

/** @brief Free space in the stream buffer


    @trace #BRCM_SWARCH_RPC_STRM_GET_CFG_PROC
    @trace #BRCM_SWREQ_RPC_MEM

    @code{.c}
        if (aCfg is NULL)
            OR if( aHdl IS NOT RPC_HDL_TYPE_STRM)
            return BCM_ERR_INVAL_PARAMS
        else
            validate the stream handle
            if(valid)
                return the aCfg using he index from streamCtx
    @endcode
*/
int32_t RPC_StrmGetCfg(RPC_HdlType aHdl, RPC_StrmCfgType *aCfg)
{
    int32_t retVal;
    uint32_t idx;

    if((NULL == aCfg)
        || (RPC_HDL_TYPE_STRM != RPC_MemGetType(aHdl))) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        retVal = RPC_MemValidateStrmHdl(aHdl);
        if(BCM_ERR_OK == retVal) {
            idx = RPC_MemGetIdx(aHdl);
            BCM_MemCpy(aCfg, &RPC_MemCtx.streamCtx[idx].cfg, sizeof(RPC_StrmCfgType));
        }
    }
    return retVal;
}

/** @brief Set the transfer size of the stream

    @trace #BRCM_SWARCH_RPC_STRMSETXFERSIZE_PROC
    @trace #BRCM_SWREQ_RPC_MEM

    @code{.c}
    if(RPC_HDL_TYPE_STRM != RPC_MemGetType(aHdl))
        retVal = BCM_ERR_INVAL_PARAMS
    else
        retVal = RPC_MemValidateStrmHdl(aHdl)
        if(BCM_ERR_OK == retVal)
            idx = RPC_MemGetIdx(aHdl)
            RPC_MemCtx.streamCtx[idx].cfg.xferSize = aTransferSize
    return retVal
    @endcode
*/
int32_t RPC_StrmSetXferSize(RPC_HdlType aHdl, uint32_t aTransferSize)
{
    int32_t retVal;
    uint32_t idx;

    if(RPC_HDL_TYPE_STRM != RPC_MemGetType(aHdl)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        retVal = RPC_MemValidateStrmHdl(aHdl);
        if(BCM_ERR_OK == retVal) {
            idx = RPC_MemGetIdx(aHdl);
            RPC_MemCtx.streamCtx[idx].cfg.xferSize = aTransferSize;
        }
    }
    return retVal;
}

/** @brief Free space in the stream buffer

    @trace #BRCM_SWARCH_RPC_STRM_FREE_SZ_PROC
    @trace #BRCM_SWREQ_RPC_MEM

    @code{.c}
        if (aSize is NULL)OR (aTotalSize is NULL)
            return BCM_ERR_INVAL_PARAMS
        else
           get the index from aHdl
           validate the stream Handle
           if(valid)
               calculate the size using RPC_MemGetWrSize
           update the aTotalSize
    @endcode
*/

int32_t RPC_StrmGetFreeSz(RPC_HdlType aHdl, uint32_t *aSize,
                             uint32_t *aTotalSize)
{
    uint32_t idx;
    uint32_t maxSize = 0UL;
    int32_t retVal;

    if((NULL == aSize) || (NULL == aTotalSize)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        idx = RPC_MemGetIdx(aHdl);
        retVal = RPC_MemValidateStrmHdl(aHdl);
        if(BCM_ERR_OK == retVal) {
            maxSize = RPC_Memory.strmSize;
            RPC_MemGetWrSize(&RPC_MemCtx.streamCtx[idx], maxSize, aSize);
            *aTotalSize = RPC_MemCtx.streamCtx[idx].writeLen;
        }
    }
    return retVal;
}

/** @brief Filled size in the stream (that can be read out)

    @trace #BRCM_SWARCH_RPC_STRM_FILLED_SZ_PROC
    @trace #BRCM_SWREQ_RPC_MEM

    @code{.c}
        if (aSize is NULL)OR (aTotalSize is NULL)
            return BCM_ERR_INVAL_PARAMS
        else
            validate the stream Handle
            if(valid)
                calculate the size using RPC_MemGetRdSize
            update the aTotalSize
    @endcode
*/
int32_t RPC_StrmGetFilledSz(RPC_HdlType aHdl, uint32_t *aSize,
                               uint32_t *aTotalSize)
{
    uint8_t idx;
    uint32_t maxSize = 0UL;
    int32_t retVal;

    if((NULL == aSize) || (NULL == aTotalSize)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        idx = RPC_MemGetIdx(aHdl);
        retVal = RPC_MemValidateStrmHdl(aHdl);
        if(BCM_ERR_OK == retVal) {
            maxSize = RPC_Memory.strmSize;
            RPC_MemGetRdSize(&RPC_MemCtx.streamCtx[idx], maxSize, aSize);
            *aTotalSize = RPC_MemCtx.streamCtx[idx].readLen;
        }
    }
    return retVal;
}

/** @brief Get the stream client information for the connected slave

    @trace #BRCM_SWARCH_RPC_STRMGETSLAVECLIENTINFO_PROC
    @trace #BRCM_SWREQ_RPC_MEM

    @code{.c}
    RPC_MemStrmClientInfoType *clientInfo = NULL
    if (BCM_ERR_OK == RPC_MemValidateStrmHdl(aHdl))
        if (RPC_HDL_TYPE_STRM == RPC_MemGetType(aHdl))
            index = RPC_MemGetIdx(aHdl)
            clientInfo = &RPC_MemCtx.streamCtx[index].slaveInfo
    return clientInfo
    @endcode
*/
RPC_MemStrmClientInfoType* RPC_StrmGetSlaveClientInfo(RPC_HdlType aHdl)
{
    uint8_t index;
    RPC_MemStrmClientInfoType *clientInfo = NULL;

    if (BCM_ERR_OK == RPC_MemValidateStrmHdl(aHdl)) {
        if (RPC_HDL_TYPE_STRM == RPC_MemGetType(aHdl)) {
            index = RPC_MemGetIdx(aHdl);
            clientInfo = &RPC_MemCtx.streamCtx[index].slaveInfo;
        }
    }

    return clientInfo;
}

/** @brief Get the stream client information for the connected master

    @trace #BRCM_SWARCH_RPC_STRMGETMASTERCLIENTINFO_PROC
    @trace #BRCM_SWREQ_RPC_MEM

    @code{.c}
    RPC_MemStrmClientInfoType *clientInfo = NULL
    if (BCM_ERR_OK == RPC_MemValidateStrmHdl(aHdl))
        if (RPC_HDL_TYPE_STRM == RPC_MemGetType(aHdl))
            index = RPC_MemGetIdx(aHdl)
            clientInfo = &RPC_MemCtx.streamCtx[index].mstrInfo
    return clientInfo
    @endcode
*/
RPC_MemStrmClientInfoType* RPC_StrmGetMasterClientInfo(RPC_HdlType aHdl)
{
    uint8_t index;
    RPC_MemStrmClientInfoType *clientInfo = NULL;

    if (BCM_ERR_OK == RPC_MemValidateStrmHdl(aHdl)) {
        if (RPC_HDL_TYPE_STRM == RPC_MemGetType(aHdl)) {
            index = RPC_MemGetIdx(aHdl);
            clientInfo = &RPC_MemCtx.streamCtx[index].mstrInfo;
        }
    }

    return clientInfo;
}


/** @brief Write data to stream

    @trace #BRCM_SWARCH_RPC_STRM_WRITE_PROC
    @trace #BRCM_SWREQ_RPC_MEM

    @code{.c}
        if (aBuffer is NULL) OR (aSize is 0)
            OR (type is RPC_HDL_TYPE_MSG)
            return BCM_ERR_INVAL_PARAMS
        else
            validate the stream handle
            if(valid)
                Calculate the available size using RPC_MemGetWrSize
                if (aSize <= availableMem)
                    copy the data from 'aBuffer' to 'stream Buffer'
                else
                    return BCM_ERR_UNKNOWN
    @endcode
*/
int32_t RPC_StrmWrite(RPC_HdlType aHdl, const uint8_t *aBuffer, uint32_t aSize)
{
    uint32_t idx;
    uint32_t availableMem;   /* Total available space */
    uint32_t maxSize = 0UL;
    uint32_t type;
    int32_t retVal;

    type = RPC_MemGetType(aHdl);
    if((0UL == aSize) || (NULL == aBuffer)
            || (RPC_HDL_TYPE_MSG == type)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        idx = RPC_MemGetIdx(aHdl);
        retVal = RPC_MemValidateStrmHdl(aHdl);
        if(BCM_ERR_OK == retVal) {
            maxSize = RPC_Memory.strmSize;
            /* get the Available space to write */
            RPC_MemGetWrSize(&RPC_MemCtx.streamCtx[idx], maxSize, &availableMem);
            if(aSize <= availableMem) {
                retVal = RPC_MemCpyLin2Cir(&RPC_MemCtx.streamCtx[idx], maxSize, aSize,
                                      aBuffer, &RPC_Memory.strmPool[(idx * RPC_MEM_STREAM_SIZE)]);
            } else {
                retVal = BCM_ERR_UNKNOWN;
            }
        }
    }
    return retVal;
}

/** @brief Read content from stream

    @trace #BRCM_SWARCH_RPC_STRM_READ_PROC
    @trace #BRCM_SWREQ_RPC_MEM

    @code{.c}
        if (aBuffer is NULL) OR (aSize is 0)
            OR (type is RPC_HDL_TYPE_MSG)
            return BCM_ERR_INVAL_PARAMS
        else
            get the index from the handle
            validate the stream handle
            if(valid)
                Calculate the available size using RPC_MemGetRdSize
                if(aSize <= availableData)
                    copy the data from 'stream Buffer' to 'aBuffer'
                else
                    return BCM_ERR_UNKNOWN
    @endcode
*/
int32_t RPC_StrmRead(RPC_HdlType aHdl, uint8_t *aBuffer,
                        uint32_t aSize, uint32_t *aOutSIze)
{
    uint32_t idx;
    uint32_t availableData;   /* Total available data */
    int32_t retVal;
    uint32_t maxSize = 0UL;
    uint32_t type;

    type = RPC_MemGetType(aHdl);
    if((0UL == aSize) || (NULL == aBuffer)
            || (RPC_HDL_TYPE_MSG == type)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        idx = RPC_MemGetIdx(aHdl);
        retVal = RPC_MemValidateStrmHdl(aHdl);
        if(BCM_ERR_OK == retVal) {
            maxSize = RPC_Memory.strmSize;
            /* get the Available data and offset to read */
            RPC_MemGetRdSize(&RPC_MemCtx.streamCtx[idx], maxSize, &availableData);
            if(aSize <= availableData) {
                retVal = RPC_MemCpyCir2Lin(&RPC_MemCtx.streamCtx[idx], maxSize, aSize,
                                  &RPC_Memory.strmPool[(idx * RPC_MEM_STREAM_SIZE)],
                                  aBuffer, FALSE);
                *aOutSIze = aSize;
            }

        }
    }

    return retVal;
}

/** @brief Peek content from stream

    @trace #BRCM_SWARCH_RPC_STRM_PEEK_PROC
    @trace #BRCM_SWREQ_RPC_MEM

    @code{.c}
    if (aBuffer is NULL) OR (aSize is 0)
        OR (type is RPC_HDL_TYPE_MSG)
        return BCM_ERR_INVAL_PARAMS
    else
        get the index from the handle
        validate the stream handle
        if(valid)
            Calculate the available size using RPC_MemGetRdSize
            if(aSize <= availableData)
                copy the data from 'stream Buffer' to 'aBuffer'
    @endcode
*/
int32_t RPC_StrmPeek(RPC_HdlType aHdl, uint8_t *aBuffer,
                     uint32_t aSize, uint32_t *aOutSIze)
{
    uint32_t idx;
    uint32_t availableData;   /* Total available data */
    int32_t retVal;
    uint32_t maxSize = 0UL;
    uint32_t type;

    type = RPC_MemGetType(aHdl);
    if((0UL == aSize) || (NULL == aBuffer)
            || (RPC_HDL_TYPE_MSG == type)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        idx = RPC_MemGetIdx(aHdl);
        retVal = RPC_MemValidateStrmHdl(aHdl);
        if(BCM_ERR_OK == retVal) {
            maxSize = RPC_Memory.strmSize;
            /* get the Available data and offset to read */
            RPC_MemGetRdSize(&RPC_MemCtx.streamCtx[idx], maxSize, &availableData);
            if(aSize <= availableData) {
                retVal = RPC_MemCpyCir2Lin(&RPC_MemCtx.streamCtx[idx], maxSize, aSize,
                                  &RPC_Memory.strmPool[(idx * RPC_MEM_STREAM_SIZE)],
                                  aBuffer, TRUE);
                *aOutSIze = aSize;
            }
        }
    }
    return retVal;
}

/** @brief Increment reference count and avoid free up


    @trace #BRCM_SWARCH_RPC_ACQUIRE_PROC
    @trace #BRCM_SWREQ_RPC_MEM

    @code{.c}
        get the RPC_HDL_TYPE from aHdl
        if type == RPC_HDL_TYPE_MSG
           validate the Message Handle
           if(valid)
               Increment the MsgContext reference count
        else
           validate the Stream Handle
           if(valid)
               Increment the StreamContext reference count
    @endcode
*/
int32_t RPC_Acquire(RPC_HdlType aHdl)
{
    uint8_t type;
    uint32_t idx;
    int32_t retVal;

    type = RPC_MemGetType(aHdl);
    idx = RPC_MemGetIdx(aHdl);
    if(RPC_HDL_TYPE_MSG == type) {
        retVal = RPC_MemValidateMsgHdl(aHdl);
        if(BCM_ERR_OK == retVal) {
            RPC_MemCtx.msgCtx[idx].refCount++;
        }
    } else {
        retVal = RPC_MemValidateStrmHdl(aHdl);
        if(BCM_ERR_OK == retVal) {
            RPC_MemCtx.streamCtx[idx].refCount++;
        }
    }

    return retVal;
}

/** @brief Decrement reference count and free upon zero

    @trace #BRCM_SWARCH_RPC_RELEASE_PROC
    @trace #BRCM_SWREQ_RPC_MEM

    @code{.c}
        get the RPC_HDL_TYPE from aHdl
        get the index from aHdl
        if type == RPC_HDL_TYPE_MSG
           validate the Handle
           if(valid)
               decrement the MsgContext reference count
               if refcount IS 0
                   clear RPC_Memory.msgPool and RPC_MemCtx.msgCtx memory
                    to release the Message handle
                    RPC_MemCtx.assocCntr[RPC_MemCtx.msgCtx[idx].assocId]--
        else if type == RPC_HDL_TYPE_STRM
           validate the Stream Handle
           if(valid)
               decrement the StreamContext reference count
               if refcount IS 0
                   clear RPC_Memory.strmPool and RPC_MemCtx.streamCtx memory
                   release the stream handle
    @endcode
*/
int32_t RPC_Release(RPC_HdlType aHdl)
{
    uint8_t type;
    uint32_t idx;
    int32_t retVal;

    type = RPC_MemGetType(aHdl);
    idx = RPC_MemGetIdx(aHdl);
    if(RPC_HDL_TYPE_MSG == type) {
        retVal = RPC_MemValidateMsgHdl(aHdl);
        if(BCM_ERR_OK == retVal) {
            RPC_MemCtx.msgCtx[idx].refCount--;
            if(0UL == RPC_MemCtx.msgCtx[idx].refCount) {
                BCM_MemSet(&RPC_Memory.msgPool[idx], 0U, sizeof(RPC_MemMsgType));
                RPC_MemCtx.msgUsageBitMask |= (1UL << idx);
                RPC_MemCtx.assocCntr[RPC_MemCtx.msgCtx[idx].assocId]--;
                BCM_MemSet(&RPC_MemCtx.msgCtx[idx], 0U, sizeof(RPC_MemMsgContextType));
            }
        }
    } else {
        retVal = RPC_MemValidateStrmHdl(aHdl);
        if(BCM_ERR_OK == retVal) {
            RPC_MemCtx.streamCtx[idx].refCount--;
            if(0UL == RPC_MemCtx.streamCtx[idx].refCount) {
                BCM_MemSet(&RPC_Memory.strmPool[idx * RPC_MEM_STREAM_SIZE], 0U, sizeof(RPC_MEM_STREAM_SIZE));
                BCM_MemSet(&RPC_MemCtx.streamCtx[idx], 0U, sizeof(RPC_MemStrmContextType));
                RPC_MemCtx.streamUsageBitMask |= (1UL << idx);
            }
        }
    }

    return retVal;
}

/** @brief Deinitialize RPC Memory

    @trace #BRCM_SWARCH_RPC_MEM_DEINIT_PROC
    @trace #BRCM_SWREQ_RPC_MEM

    @code{.c}
        clear the RPC_Memory.msgPool
        clear the RPC_Memory.strmPool
        clear the RPC_MemCtx
    @endcode
*/
void RPC_MemDeinit(void)
{
    BCM_MemSet(RPC_Memory.msgPool, 0U, sizeof(RPC_MemMsgType) * RPC_Memory.msgCnt);
    BCM_MemSet(RPC_Memory.strmPool, 0U, RPC_Memory.strmSize * RPC_Memory.strmCnt);
    BCM_MemSet(&RPC_MemCtx, 0U, sizeof(RPC_MemContextType));
}

/** @brief  Push AppInfo

    @trace #BRCM_SWARCH_RPC_MEMPUSHAPPINFO_PROC
    @trace #BRCM_SWREQ_RPC_MEM

    @code{.c}
    tmpMsg = RPC_MsgGet(aHdl)
    if(NULL != tmpMsg)
        if(if NO Memory to push)
            return BCM_ERR_UNKNOWN
        else
            if space is available then push the aAppInfo
            tmpMsg->appinfo[tmpMsg->appinfoTop] = aAppInfo
            tmpMsg->appinfoTop++
            return BCM_ERR_OK
    else
        return BCM_ERR_INVAL_PARAMS
    @endcode
*/
int32_t RPC_MemPushAppInfo(RPC_HdlType aHdl, uint32_t aAppInfo)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;
    RPC_MemMsgType *tmpMsg;

    tmpMsg = RPC_MsgGet(aHdl);
    if(NULL != tmpMsg) {
        if(RPC_MEM_MAX_CNT_APPINFO == tmpMsg->appinfoTop) {
            retVal = BCM_ERR_UNKNOWN;
        } else {
            tmpMsg->appinfo[tmpMsg->appinfoTop] = aAppInfo;
            tmpMsg->appinfoTop++;
            retVal = BCM_ERR_OK;
        }
    }

    return retVal;
}

/** @brief  Peek AppInfo

    @trace #BRCM_SWARCH_RPC_MEMPEEKAPPINFO_PROC
    @trace #BRCM_SWREQ_RPC_MEM

    @code{.c}
    if(aMsg IS NULL)
        return BCM_ERR_INVAL_PARAMS
    else if(0UL == aMsg->appinfoTop)
        No data available to Peek
        return BCM_ERR_NOMEM
    else
        data is available to peek
        *aAppInfo = aMsg->appinfo[(aMsg->appinfoTop - 1UL)]
        return BCM_ERR_OK
    @endcode
*/
int32_t RPC_MemPeekAppInfo(RPC_MemMsgType *aMsg, uint32_t *aAppInfo)
{
    int32_t retVal = BCM_ERR_OK;

    if(NULL == aMsg) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if(0UL == aMsg->appinfoTop) {
        retVal = BCM_ERR_NOMEM;
    } else {
        *aAppInfo = aMsg->appinfo[(aMsg->appinfoTop - 1UL)];
    }

    return retVal;
}

/** @brief  Pop AppInfo

    @trace #BRCM_SWARCH_RPC_MEMPOPAPPINFO_PROC
    @trace #BRCM_SWREQ_RPC_MEM

    @code{.c}
    validate the handle
    retVal = RPC_MemValidateMsgHdl(aHdl);
    if(retVal IS BCM_ERR_OK)
        tmpMsg = RPC_MsgGet(aHdl)
        retVal = RPC_MemPeekAppInfo(tmpMsg, aAppInfo)
        if(retVal IS BCM_ERR_OK)
            tmpMsg->appinfoTop--
    @endcode
*/
int32_t RPC_MemPopAppInfo(RPC_HdlType aHdl, uint32_t *aAppInfo)
{
    int32_t retVal = BCM_ERR_OK;
    RPC_MemMsgType *tmpMsg;

    retVal = RPC_MemValidateMsgHdl(aHdl);
    if(BCM_ERR_OK == retVal) {
        tmpMsg = RPC_MsgGet(aHdl);
        retVal = RPC_MemPeekAppInfo(tmpMsg, aAppInfo);
        if(BCM_ERR_OK == retVal) {
            tmpMsg->appinfoTop--;
        }
    }

    return retVal;
}

/**
    @brief Crypto verify proxy push appInfo

    @trace #BRCM_SWARCH_RPC_MEMPOPAPPINFO_PROC
    @trace #BRCM_SWREQ_RPC_MEM
    @code{.unparsed}
    tmpMsg->appinfo[aMsg->appinfoTop] = aAppInfo
    tmpMsg->appinfoTop++
    @endcode
*/
int32_t RPC_MsgPushAppInfo(RPC_MemMsgType* aMsg, uint32_t aAppInfo)
{
    int32_t retVal = BCM_ERR_OK;

    if (aMsg == NULL) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        aMsg->appinfo[aMsg->appinfoTop] = aAppInfo;
        aMsg->appinfoTop++;
    }

    return retVal;
}

/**
    @brief Crypto verify proxy pop appInfo

    @trace #BRCM_SWARCH_RPC_MEMPOPAPPINFO_PROC
    @trace #BRCM_SWREQ_RPC_MEM
    @code{.unparsed}
    *aAppInfo = aMsg->appinfo[(aMsg->appinfoTop - 1UL)]
    @endcode
*/
int32_t RPC_MsgPopAppInfo(RPC_MemMsgType* aMsg, uint32_t *aAppInfo)
{
    int32_t retVal = BCM_ERR_OK;

    if ((aAppInfo == NULL)
            || (aMsg == NULL)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        *aAppInfo = aMsg->appinfo[(aMsg->appinfoTop - 1UL)];
        aMsg->appinfoTop--;
    }

    return retVal;
}

/**
    @brief Crypto verify proxy pop appInfo

    @trace #BRCM_SWARCH_RPC_MEMPOPAPPINFO_PROC
    @trace #BRCM_SWREQ_RPC_MEM
    @code{.unparsed}
    aMsg->magic = RPC_MEMMSG_MAGIC;
    @endcode
*/
void RPC_MsgInit(RPC_MemMsgType* aMsg)
{
    BCM_MemSet((uint8_t*)aMsg, 0, sizeof(RPC_MemMsgType));
    aMsg->magic = RPC_MEMMSG_MAGIC;
}

/** @brief Get the stream processing status

    @trace #BRCM_SWARCH_RPC_MEMPOPAPPINFO_PROC
    @trace #BRCM_SWREQ_RPC_MEM

    @code{.c}
    type = RPC_MemGetType(aHdl)
    if((RPC_HDL_INVALID == aHdl) ||
       (RPC_HDL_TYPE_STRM != type)||
       (NULL == aSlaveState) ||
       (NULL == aMasterState))
        retVal = BCM_ERR_INVAL_PARAMS
     else
        retVal = RPC_MemValidateStrmHdl(aHdl)
        if(BCM_ERR_OK == retVal)
            slaveClientInfo = RPC_StrmGetSlaveClientInfo(aHdl)
            mstrClientInfo = RPC_StrmGetMasterClientInfo(aHdl)
            *aSlaveState = slaveClientInfo->state
            *aMasterState = mstrClientInfo->state
    return retVal
    @endcode
*/
int32_t RPC_GetStreamStatus(RPC_HdlType aHdl,
                            BCM_SubStateType *aSlaveState,
                            BCM_SubStateType *aMasterState)
{
    int32_t retVal = BCM_ERR_OK;
    uint32_t type;
    RPC_MemStrmClientInfoType *slaveClientInfo = RPC_StrmGetSlaveClientInfo(aHdl);
    RPC_MemStrmClientInfoType *mstrClientInfo = RPC_StrmGetMasterClientInfo(aHdl);

    type = RPC_MemGetType(aHdl);
    if((RPC_HDL_INVALID == aHdl) ||
       (RPC_HDL_TYPE_STRM != type)||
       (NULL == aSlaveState) ||
       (NULL == aMasterState) ||
       (NULL == slaveClientInfo) ||
       (NULL == mstrClientInfo)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        retVal = RPC_MemValidateStrmHdl(aHdl);
        if(BCM_ERR_OK == retVal) {
            *aSlaveState = slaveClientInfo->state;
            *aMasterState = mstrClientInfo->state;
        }
    }

    return retVal;
}

/** @} */
