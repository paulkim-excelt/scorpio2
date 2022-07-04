/*****************************************************************************
 Copyright 2020-2022 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_imgl_mmap_impl Memory Mapped Module Implementation
    @ingroup grp_imgl

    @addtogroup grp_imgl_mmap_impl
    @{

    @file imgl_mmap.c
    @brief Memory Mapped Loader implementation
    This source file contains the implementation of Memory Mapped IMGL module
    @version 0.1 Initial version
*/

#include <stddef.h>
#include <string.h>
#include <compiler.h>
#include <imgl_osil.h>
#include <bcm_utils.h>
#include <imgl_mmap.h>

#ifdef ENABLE_IMGL_MMAP_ASYNC_MODE
#include "ee.h"
#endif

/**
    @name NVM Sync loader Design IDs
    @{
    @brief Design IDs for NVM Sync loader
*/
#define BRCM_SWDSGN_IMGL_MMAP_ADDR_GLOBAL         (0xA101U)    /**< @brief #IMGL_MmapAddr        */
#define BRCM_SWDSGN_IMGL_MMAP_INTERNAL_PROC       (0xA102U)    /**< @brief #IMGL_MmapInternal    */
#define BRCM_SWDSGN_IMGL_MMAP_READ_PTBL_PROC      (0xA105U)    /**< @brief #IMGL_MmapReadPTBL    */
#define BRCM_SWDSGN_IMGL_MMAP_READ_ITBL_PROC      (0xA106U)    /**< @brief #IMGL_MmapReadITBL    */
#define BRCM_SWDSGN_IMGL_MMAP_READ_IMAGE_PROC     (0xA107U)    /**< @brief #IMGL_MmapReadImg     */
#define BRCM_SWDSGN_IMGL_MMAP_ERASE_IMG_PROC      (0xA108U)    /**< @brief #IMGL_MmapEraseImg    */
#define BRCM_SWDSGN_IMGL_MMAP_WRITE_IMG_PROC      (0xA109U)    /**< @brief #IMGL_MmapWriteImg    */
#define BRCM_SWDSGN_IMGL_MMAP_GETSTATUS_PROC      (0xA10AU)    /**< @brief #IMGL_MmapGetStatus   */
#define BRCM_SWDSGN_IMGL_MMAP_HANDLER_GLOBAL      (0xA10BU)    /**< @brief #IMGL_MmapHandler     */
#define BRCM_SWDSGN_IMGL_MMAP_SIZE_GLOBAL         (0xA10CU)    /**< @brief #IMGL_MmapSize        */
#define BRCM_SWDSGN_IMGL_MMAP_PROC_SIZE_GLOBAL    (0xA10DU)    /**< @brief #IMGL_MmapProcSize    */
#define BRCM_SWDSGN_IMGL_MMAP_MODULE_GLOBAL       (0xA10EU)    /**< @brief #IMGL_MemoryMapModule */
#define BRCM_SWDSGN_IMGL_MMAP_JOB_TYPE            (0xA10FU)    /**< @brief #IMGL_MmapJobType     */
#define BRCM_SWDSGN_IMGL_MMAP_MSG_GLOBAL          (0xA110U)    /**< @brief #IMGL_MmapMsg         */
#define BRCM_SWDSGN_IMGL_MMAP_GET_MSG_PROC        (0xA111U)    /**< @brief #IMGL_GetMmapMsg      */
#define BRCM_SWDSGN_IMGL_MMAP_MSGQ_GLOBAL         (0xA112U)    /**< @brief #IMGL_MmapMsgQ        */
#define BRCM_SWDSGN_IMGL_MMAP_SERVER_PROC         (0xA113U)    /**< @brief #IMGL_MmapServer      */
#define BRCM_SWDSGN_IMGL_MMAP_0_GLOBAL            (0xA114U)    /**< @brief #IMGL_Mmap0           */
#define BRCM_SWDSGN_IMGL_MMAP_1_GLOBAL            (0xA115U)    /**< @brief #IMGL_Mmap1           */
#define BRCM_SWDSGN_IMGL_MMAP_JOBID_TYPE          (0xA116U)    /**< @brief #IMGL_MmapJobIDType   */
#define BRCM_SWDSGN_IMGL_MMAP_PROCESS_PROC        (0xA117U)    /**< @brief #IMGL_MmapProcess     */
/** @} */

/**
    @brief Memory map 0

    @trace #BRCM_SWARCH_IMGL_MMAP_HANDLER_GLOBAL
    @trace  #BRCM_SWREQ_IMGL_CORE
*/
#if (IMGL_MMAP_SIZE_0 > 0)
uint8_t IMGL_Mmap0[IMGL_MMAP_SIZE_0] COMP_SECTION(".imgl.mmap.addr0.IMGL_Mmap0");
#endif

/**
    @brief Memory map 1

    @trace #BRCM_SWARCH_IMGL_MMAP_HANDLER_GLOBAL
    @trace  #BRCM_SWREQ_IMGL_CORE
*/
#if (IMGL_MMAP_SIZE_1 > 0)
uint8_t IMGL_Mmap1[IMGL_MMAP_SIZE_1] COMP_SECTION(".imgl.mmap.addr1.IMGL_Mmap1");
#endif

/**
    @brief Memory map address

    @trace #BRCM_SWARCH_IMGL_MMAP_HANDLER_GLOBAL
    @trace  #BRCM_SWREQ_IMGL_CORE
*/
static uint8_t * const IMGL_MmapAddr[] = {
#if (IMGL_MMAP_SIZE_0 > 0)
    (uint8_t *)IMGL_Mmap0,
#else
    NULL,
#endif
#if (IMGL_MMAP_SIZE_1 > 0)
    (uint8_t *)IMGL_Mmap1,
#else
    NULL,
#endif
};

/**
    @brief Memory map size

    @trace #BRCM_SWARCH_IMGL_MMAP_HANDLER_GLOBAL
    @trace  #BRCM_SWREQ_IMGL_CORE
*/
static const uint32_t IMGL_MmapSize[] = {
#if (IMGL_MMAP_SIZE_0 > 0)
    IMGL_MMAP_SIZE_0,
#else
    0UL,
#endif
#if (IMGL_MMAP_SIZE_1 > 0)
    IMGL_MMAP_SIZE_1
#else
    0UL,
#endif
};

/**
    @name Memory map job ID
    @{
    @brief Job type
    @trace #BRCM_SWARCH_IMGL_MMAP_HANDLER_GLOBAL
    @trace #BRCM_SWREQ_IMGL_CORE
*/
typedef uint32_t IMGL_MmapJobIDType;
#define IMGL_MMAP_JOBID_READ  (0UL)
#define IMGL_MMAP_JOBID_WRITE (1UL)
#define IMGL_MMAP_JOBID_RESET (2UL)
/** @}*/

/**
    @trace #BRCM_SWARCH_IMGL_MMAP_HANDLER_GLOBAL
    @trace  #BRCM_SWREQ_IMGL_CORE
*/
typedef struct sIMGL_MmapJobType {
    int32_t             result;
    IMGL_ChannelIdxType    channel;
    uint8_t             *dst;
    uint32_t            maxSize;
    uint32_t            offset;
    IMGL_MmapJobIDType      jobID;
} IMGL_MmapJobType;

/**
    @brief IMGL Message queue array

    @trace #BRCM_SWARCH_IMGL_MMAP_HANDLER_GLOBAL
    @trace  #BRCM_SWREQ_IMGL_CORE
*/
#ifdef ENABLE_IMGL_MMAP_ASYNC_MODE
static IMGL_MmapJobType IMGL_MmapMsg[MSGQ_SIZE];
#endif

/**
    @trace #BRCM_SWARCH_IMGL_MMAP_HANDLER_GLOBAL
    @trace  #BRCM_SWREQ_IMGL_CORE

    @code{.c}
    if aIdx < MSGQ_SIZE
        msg = &IMGL_LoadImgMsg[aIdx]
    else
        msg = NULL
    return msg
    @endcode
*/
#ifdef ENABLE_IMGL_MMAP_ASYNC_MODE
static void* IMGL_GetMmapMsg(uint32_t aIdx)
{
    void *ptr = NULL;
    if (aIdx < MSGQ_SIZE) {
        ptr = (void *)&IMGL_MmapMsg[aIdx];
    }

    return ptr;
}
#endif

/**
    @trace #BRCM_SWARCH_IMGL_MMAP_HANDLER_GLOBAL
    @trace  #BRCM_SWREQ_IMGL_CORE

    @code{.c}
    if aJobID is IMGL_MMAP_JOBID_READ
        MemCpy(aDst, aSrc, aSize)
#if defined(ENABLE_IMGL_MMAP_UPDATE)
    else if aJobID is IMGL_MMAP_JOBID_WRITE
        MemCpy(aSrc, aDst, aSize)
    else if aJobID is IMGL_MMAP_JOBID_RESET
        MemSet(aSrc, 0xFFU, aSize)
#endif
    else
        return NOSUPPORT
    return msg
    @endcode
*/
static int32_t IMGL_MmapProcess(IMGL_MmapJobIDType aJobID,
                                uint8_t *aSrc,
                                uint8_t *aDst,
                                uint32_t aSize)
{
    int32_t retval;

    switch (aJobID) {
#if defined(ENABLE_IMGL_MMAP_UPDATE)
        case IMGL_MMAP_JOBID_WRITE:
            BCM_MemCpy(aSrc, aDst, aSize);
            retval = BCM_ERR_OK;
            break;
        case IMGL_MMAP_JOBID_RESET:
            BCM_MemSet(aSrc, 0xFFU, aSize);
            retval = BCM_ERR_OK;
            break;
#endif
        default:
            /* IMGL_MMAP_JOBID_READ */
            BCM_MemCpy(aDst, aSrc, aSize);
            retval = BCM_ERR_OK;
            break;
    }

    return retval;
}

/**
    @brief IMGL load Message Queue

    @trace #BRCM_SWARCH_IMGL_MMAP_HANDLER_GLOBAL
    @trace  #BRCM_SWREQ_IMGL_CORE
*/
#ifdef ENABLE_IMGL_MMAP_ASYNC_MODE
MSGQ_DEFINE_V2(IMGL_MmapMsgQ,
                IMGL_MmapServer,
                IMGL_EVENT,
                MSGQ_CLIENT_SIGNAL_ENABLE,
                IMGL_MmapJobType,
                IMGL_MmapImgMsgQHdr,
                IMGL_GetMmapMsg,
                ".bss.imgl");
#endif
/**
    @trace #BRCM_SWARCH_IMGL_MMAP_HANDLER_GLOBAL
    @trace  #BRCM_SWREQ_IMGL_CORE
*/
#ifdef ENABLE_IMGL_MMAP_ASYNC_MODE
TASK(IMGL_MmapServer)
{
    uint32_t index = 0UL;
    int32_t ret;
    /* @event            Infinite loop
       @issue            while (1UL) never exit
       @risk             No risk
       @justification    This infinite loop is an intentional and below statements are required to execute in loop. */

    /* coverity[no_escape] */
    /* coverity[loop_top] */
    while (1UL) {
        BCM_WaitEvent(IMGL_EVENT);
        BCM_ClearEvent(IMGL_EVENT);
        ret = MSGQ_GetMsgIdx(&IMGL_MmapMsgQ, &index);
        while (BCM_ERR_OK == ret) {
            IMGL_MmapJobType *msg = &IMGL_MmapMsg[index];
            msg->result = IMGL_MmapProcess(msg->jobID,
                                           &IMGL_MmapAddr[msg->channel][msg->offset],
                                           msg->dst,
                                           msg->maxSize);
            (void)MSGQ_CompleteMsgIdx(&IMGL_MmapMsgQ, index);
            ret = MSGQ_GetMsgIdx(&IMGL_MmapMsgQ, &index);
        }
    /* coverity[loop_bottom] */
    }

}
#endif

/**
    @brief Memory map size for late retrieval

    @trace #BRCM_SWARCH_IMGL_MMAP_HANDLER_GLOBAL
    @trace  #BRCM_SWREQ_IMGL_CORE
*/
#ifndef ENABLE_IMGL_MMAP_ASYNC_MODE
static uint32_t IMGL_MmapProcSize COMP_SECTION(".bss.imgl");
#endif

/** @brief Fetch the data

    Validate and fetch the data

    @behavior Sync, Reentrant

    @param[in]       aChannel           Loader Channel ID
    @param[out]      aDstAddress        Pointer to store the data
    @param[in]       aMaxSize           Maximum size requested
    @param[out]      aFilledSize        Pointer to store the fetched size
    @param[in]       aOffset            Offset with in the flash

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Success
    @retval     #BCM_ERR_NODEV          Channel does not exist
    @retval     #BCM_ERR_INVAL_PARAMS   (aDstAddress is NULL) or
                                        (aFilledSize is NULL) or
                                        (aMaxSize is 0)

    @trace #BRCM_SWARCH_IMGL_MMAP_HANDLER_GLOBAL
    @trace  #BRCM_SWREQ_IMGL_CORE

    @code{.unparsed}
    if aDstAddress is NULL or aFilledSize is NULL or aMaxSize is 0
        ret = ERR_INVAL_PARAMS
    else if aChannel >= Number of channels
        ret = BCM_ERR_NODEV
    else if state !=  INIT
        ret = BCM_ERR_INVAL_STATE
    else if FLSLDR_Size[aChannel] < (offset + maxsize)
        ret = BCM_ERR_UNKNOWN
    else
        BCM_MemCpy(aDstAddress, &FLSLDR_Context.addr[i][aOffset], aMaxSize)
        store aMaxSize in aFilledSize
        ret = BCM_ERR_OK
    return ret
    @endcode
*/
static int32_t IMGL_MmapInternal(IMGL_ChannelIdxType aChannel,
                                    uint8_t *aDstAddress,
                                    uint32_t aMaxSize,
                                    uint32_t aOffset,
                                    IMGL_MmapJobIDType aJobID,
                                    const uint32_t aClientMask,
                                    const MSGQ_MsgHdrType** const aHdr)
{
    int32_t retval;

    if (0UL == aMaxSize) {
        retval = BCM_ERR_INVAL_PARAMS;
    } else if (IMGL_CHANNEL_IDX_MAX <= aChannel) {
        retval = BCM_ERR_NODEV;
    } else if (IMGL_CHANNEL_ID_INVALID == IMGL_MemoryMapModule.channel[aChannel]) {
        retval = BCM_ERR_NODEV;
    } else if (IMGL_MmapSize[aChannel] < (aOffset + aMaxSize)) {
        retval =  BCM_ERR_UNKNOWN;
    } else {
#ifdef ENABLE_IMGL_MMAP_ASYNC_MODE
        IMGL_MmapJobType job;
        job.result = BCM_ERR_UNINIT;
        job.channel = aChannel;
        job.dst = aDstAddress;
        job.maxSize = aMaxSize;
        job.offset = aOffset;
        job.jobID = aJobID;
        retval = MSGQ_SendMsg(&IMGL_MmapMsgQ, &job, aClientMask, aHdr);
#else
        retval = IMGL_MmapProcess(aJobID, &IMGL_MmapAddr[aChannel][aOffset], aDstAddress, aMaxSize);
        if (BCM_ERR_OK == retval) {
            IMGL_MmapProcSize = aMaxSize;
        }
#endif
    }
    return retval;
}

/** @brief Fetch Partition Table

    For Architecture, refer to @ref IMGL_ReadPTBLType

    @core {.c}
    ...
    @endcode

    @trace #BRCM_SWARCH_IMGL_MMAP_HANDLER_GLOBAL
    @trace  #BRCM_SWREQ_IMGL_CORE
*/
static int32_t IMGL_MmapReadPTBL(IMGL_ChannelIdxType aChannel,
                                uint32_t aDevAddr,
                                uint8_t *aDownloadAddress,
                                uint32_t aMaxSize,
                                const uint32_t aClientMask,
                                const MSGQ_MsgHdrType** const aHdr)
{
    return IMGL_MmapInternal(aChannel, aDownloadAddress, aMaxSize, aDevAddr, IMGL_MMAP_JOBID_READ, aClientMask, aHdr);
}

/** @brief Fetch Image Table

    For Architecture, refer to @ref IMGL_ReadITBLType

    @core {.c}
    ...
    @endcode

    @trace #BRCM_SWARCH_IMGL_MMAP_HANDLER_GLOBAL
    @trace  #BRCM_SWREQ_IMGL_CORE
*/
static int32_t IMGL_MmapReadITBL(IMGL_ChannelIdxType aChannel,
                               PTBL_IdType aPartID,
                               uint32_t aITBLAddress,
                               uint8_t *aDownloadAddress,
                               uint32_t aMaxSize,
                               const uint32_t aClientMask,
                               const MSGQ_MsgHdrType** const aHdr)
{
    return IMGL_MmapInternal(aChannel, aDownloadAddress, aMaxSize, aITBLAddress, IMGL_MMAP_JOBID_READ, aClientMask, aHdr);
}

/** @brief Request to fetch an image

    For Architecture, refer to @ref IMGL_ReadImgType

    @core {.c}
    ...
    @endcode

    @trace #BRCM_SWARCH_IMGL_MMAP_HANDLER_GLOBAL
    @trace #BRCM_SWREQ_IMGL_CORE

*/
static int32_t IMGL_MmapReadImg(IMGL_ChannelIdxType aChannel,
                                PTBL_IdType aPID,
                                uint16_t    aImgID,
                                uint32_t    aImgAddr,
                                uint8_t *const aAddr,
                                uint32_t    aOffset,
                                uint32_t    aBufSize,
                                const uint32_t aClientMask,
                                const MSGQ_MsgHdrType** const aHdr)
{
    return IMGL_MmapInternal(aChannel, aAddr, aBufSize, aImgAddr + aOffset, IMGL_MMAP_JOBID_READ, aClientMask, aHdr);
}
#if defined(ENABLE_IMGL_MMAP_UPDATE)
/** @brief Request to erase an image

    For Architecture, refer to @ref IMGL_EraseImgType

    @core {.c}
    ...
    @endcode

    @trace #BRCM_SWARCH_IMGL_MMAP_HANDLER_GLOBAL
    @trace #BRCM_SWREQ_IMGL_CORE

*/
static int32_t IMGL_MmapEraseImg(IMGL_ChannelIdxType aChannel,
                                PTBL_IdType aPID,
                                uint16_t aImgID,
                                uint32_t aDevAddr,
                                uint32_t aSize,
                                const uint32_t aClientMask,
                                const MSGQ_MsgHdrType** const aHdr)
{
    return IMGL_MmapInternal(aChannel, NULL, aSize, aDevAddr, IMGL_MMAP_JOBID_RESET, aClientMask, aHdr);
}

/** @brief Request to write an image

    For Architecture, refer to @ref IMGL_WriteImgType

    @core {.c}
    ...
    @endcode

    @trace #BRCM_SWARCH_IMGL_MMAP_HANDLER_GLOBAL
    @trace #BRCM_SWREQ_IMGL_CORE

*/
static int32_t IMGL_MmapWriteImg(IMGL_ChannelIdxType aChannel,
                                    PTBL_IdType aPID,
                                    uint16_t    aImgID,
                                    uint32_t    aImgAddr,
                                    uint8_t *const aAddr,
                                    uint32_t    aOffset,
                                    uint32_t    aBufSize,
                                    const uint32_t aClientMask,
                                    const MSGQ_MsgHdrType** const aHdr)
{
    return IMGL_MmapInternal(aChannel, aAddr, aBufSize, aImgAddr + aOffset, IMGL_MMAP_JOBID_WRITE, aClientMask, aHdr);
}

#endif

/** @brief Get the status of Read/Erase/Write request

    For Architecture, refer to @ref IMGL_GetStatusType

    @core {.c}
    ...
    @endcode

    @trace #BRCM_SWARCH_IMGL_MMAP_HANDLER_GLOBAL
    @trace #BRCM_SWREQ_IMGL_CORE

*/
static int32_t IMGL_MmapGetStatus(const MSGQ_MsgHdrType *const aHdr,
                                    uint32_t *const aProcessedSize)
{
#ifdef ENABLE_IMGL_MMAP_ASYNC_MODE
    int32_t retVal;
    IMGL_MmapJobType job;
    retVal = MSGQ_RecvMsg(&IMGL_MmapMsgQ, aHdr, &job);
    if (BCM_ERR_OK == retVal) {
        *aProcessedSize = job.maxSize;
    }
    return retVal;
#else
    *aProcessedSize = IMGL_MmapProcSize;
    IMGL_MmapProcSize = 0UL;
    return BCM_ERR_OK;
#endif
}

/**
    @brief Global flash loader info

    Global flash loader information

    @trace #BRCM_SWARCH_IMGL_MMAP_HANDLER_GLOBAL
    @trace #BRCM_SWREQ_IMGL_CORE
*/
const IMGL_InterfaceType IMGL_MemoryMapModule =
{
    .comp = BCM_IMG_ID,
    .maxNumCopies = PTBL_MAX_NUM_COPIES,
    .mode = IMGL_LOAD_MODE_NVM,
    .minEraseSize = 4096UL,
    .getState = NULL,
    .getImgTbl = NULL,
    .readPTBL = IMGL_MmapReadPTBL,
    .readITBL = IMGL_MmapReadITBL,
    .readImg = IMGL_MmapReadImg,
#if defined(ENABLE_IMGL_MMAP_UPDATE)
    .eraseImg = IMGL_MmapEraseImg,
    .writeImg = IMGL_MmapWriteImg,
#else
    .eraseImg = NULL,
    .writeImg = NULL,
#endif
    .getStatus = IMGL_MmapGetStatus,
#if (IMGL_MMAP_SIZE_0 > 0)
    .channel[0UL] = IMGL_CHANNEL_ID_NVM_0,
#else
    .channel[0UL] = IMGL_CHANNEL_ID_INVALID,
#endif
#if (IMGL_MMAP_SIZE_1 > 0)
    .channel[1UL] = IMGL_CHANNEL_ID_NVM_1,
#else
    .channel[1UL] = IMGL_CHANNEL_ID_INVALID,
#endif
};

/** @} */
