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
    @defgroup grp_imgl_common_impl API Implementation
    @ingroup grp_imgl

    @addtogroup grp_imgl_common_impl
    @{

    @file imgl_common.c
    @brief IMGL API Implementation
    This source file contains the implementation of functions for IMGL Core

    @version 1.0 Initial version
*/

#include <stdlib.h>
#include <compiler.h>
#include <imgl_osil.h>
#include <bcm_utils.h>
#include <crc.h>
#include <dbg_log.h>
#include <mcu.h>
#include <lw_queue.h>
#include <imgl_loader.h>
#include <bcm_time.h>
#include <imgl_lib.h>

#include "imgl_common.h"
#include "imgl_shared_context.h"

/**
    @name IMGL Core Design IDs
    @{
    @brief Design IDs for IMGL Core
*/
#define BRCM_SWDSGN_IMGL_MEMORY_RESET_PROC            (0xB500U)    /**< @brief #IMGL_MemoryReset             */
#define BRCM_SWDSGN_IMGL_TEMPMEM_GET_PROC             (0xB501U)    /**< @brief #IMGL_TempMemGet              */
#define BRCM_SWDSGN_IMGL_MEMORY_GET_PROC              (0xB502U)    /**< @brief #IMGL_MemoryGet               */
#define BRCM_SWDSGN_IMGL_INIT_STATE_UPDATE_ERROR_PROC (0xB503U)    /**< @brief #IMGL_InitStateUpdateInError  */
#define BRCM_SWDSGN_IMGL_INT_STATE_HANDLER_PROC       (0xB504U)    /**< @brief #IMGL_InitStateHandler        */
#define BRCM_SWDSGN_IMGL_COMMONINIT_PROC              (0xB505U)    /**< @brief #IMGL_CommonInit              */
#define BRCM_SWDSGN_IMGL_GET_IMG_SIZE_PROC            (0xB506U)    /**< @brief #IMGL_GetImgSize              */
#define BRCM_SWDSGN_IMGL_GET_IMGTBL_PROC              (0xB507U)    /**< @brief #IMGL_GetImgTbl               */
#define BRCM_SWDSGN_IMGL_LOAD_IMG_PROC                (0xB508U)    /**< @brief #IMGL_LoadImg                 */
#define BRCM_SWDSGN_IMGL_GET_STATUS_PROC              (0xB509U)    /**< @brief #IMGL_GetStatus               */
#define BRCM_SWDSGN_IMGL_LOAD_RAW_IMG_PROC            (0xB50AU)    /**< @brief #IMGL_LoadRawImg              */
#define BRCM_SWDSGN_IMGL_SEARCH_MODE_IDX_PROC         (0xB50BU)    /**< @brief #IMGL_SearchModeIdx           */
#define BRCM_SWDSGN_IMGL_SEARCH_CHN_IDX_PROC          (0xB50CU)    /**< @brief #IMGL_SearchChannelIdx        */
#define BRCM_SWDSGN_IMGL_LOAD_CANCEL_PROC             (0xB50DU)    /**< @brief #IMGL_LoadCancel              */
#define BRCM_SWDSGN_IMGL_LOAD_PTBL_PROC               (0xB50EU)    /**< @brief #IMGL_LoadPTBL                */
#define BRCM_SWDSGN_IMGL_LOAD_ITBL_PROC               (0xB50FU)    /**< @brief #IMGL_LoadITBL                */
#define BRCM_SWDSGN_IMGL_CORE_STAGE_DONE_MACRO        (0xB511U)    /**< @brief #IMGL_CORE_STAGE_DONE         */
#define BRCM_SWDSGN_IMGL_CORE_STATE_HANDLER_PROC      (0xB512U)    /**< @brief #IMGL_LoadStageProcess        */
/** @} */

/**
    @trace #BRCM_SWARCH_IMGL_FETCH_MOD_GLOBAL
    @trace #BRCM_SWARCH_IMGL_CFG_HANDLER_PROC
    @trace #BRCM_SWREQ_IMGL_CORE
*/
static inline IMGL_IntStateType IMGL_InitStateUpdateInError(IMGL_ModeType aMode)
{
    IMGL_IntStateType state;
    if (IMGL_LOAD_MODE_RPC == aMode) {
        state = IMGL_INT_STATE_ERROR;
    } else {
        state = IMGL_INT_STATE_SET_COPY_ID;
    }

    return state;
}

/**
    @trace #BRCM_SWARCH_IMGL_FETCH_MOD_GLOBAL
    @trace #BRCM_SWREQ_IMGL_CORE

    @code{.unparsed}
    count = 0
    BCM_MemSet(aContext->mem, 0U, sizeof(aContext->mem));
    for (i=0; i<IMGL_FETCH_EXE_MAX_MEM_CNT; i++)
        ret = IMGL_MemoryInfoGet(i, &addr, &size)
        if ret ==  BCM_ERR_OK
            BCM_MemSet(addr, 0U, size);
            aContext->mem[count].index = i;
            aContext->mem[count].offset = 0UL;
            aContext->mem[count].size = size;
            aContext->mem[count].allocated = 0;
            count++;
    @endcode

*/
void IMGL_MemoryReset(IMGL_CommonContextType *aContext)
{
    uint32_t count = 0UL;
    uint32_t i;
    uint8_t *addr;
    uint32_t size;
    int32_t ret;

    BCM_MemSet(aContext->mem, 0U, sizeof(aContext->mem));
    aContext->freeIndex = 0UL;
    for (i=0UL; i<IMGL_FETCH_EXE_MAX_MEM_CNT; i++) {
        ret = IMGL_MemoryInfoGet(i, &addr, &size);
        if (BCM_ERR_OK == ret) {
            BCM_MemSet(addr, 0U, size);
            aContext->mem[count].index = i;
            aContext->mem[count].start = (uint32_t)addr;
            aContext->mem[count].size = size;
            aContext->mem[count].allocated = 0;
            count++;
            aContext->freeIndex++;
        }
    }
}

#if defined(ENABLE_IMGL_FW)
/**
    @trace #BRCM_SWARCH_IMGL_UPDATE_MOD_GLOBAL
    @trace #BRCM_SWREQ_IMGL_CORE
*/
int32_t IMGL_TempMemGet(IMGL_CommonContextType *aContext,
                        uint32_t aLoadAddress,
                        uint32_t aImgSize,
                        uint8_t **aMemory,
                        uint32_t *aOutSize)
{
    *aMemory = (uint8_t*)aContext->tempBuffer;
    *aOutSize = IMGL_MEM_AREA_MIN_SIZE;
    return BCM_ERR_OK;
}
#endif

#if defined(ENABLE_IMGL_ROM) || defined(ENABLE_IMGL_BL)
/** @brief Allocate and Get memory

    @behavior Sync, Non-reentrant

    @pre IMGL is initialized

    @param[in]      aLoadAddress    Load address
    @param[in]      aImgSize        Image Size
    @param[out]     aAddress        memory address
    @param[out]     aOutSize        allocated size

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Found a valid memory area, and aMemory is populated
    @retval     #BCM_ERR_NOMEM          Failed to allocate memory
    @retval     #BCM_ERR_INVAL_PARAMS   aAddress is NULL

    @post None

    @note This API is exposed only for test purposes. Not to be used directly

    @trace #BRCM_SWARCH_IMGL_FETCH_MOD_GLOBAL
    @trace #BRCM_SWREQ_IMGL_CORE

    @todo To be updated
    @code{.unparsed}
    ret = BCM_ERR_NOMEM
    if NULL == aAddress
        ret = BCM_ERR_INVAL_PARAMS
    else
        for (i=0; i<=ITBL_MAX_NUM_ENTRIES; i++)
            if (0UL == aContext->mem[i].allocated) && (aContext->mem[i].start <= aLoadAddress)
                && ((aLoadAddress + aImgSize) <= (aContext->mem[i].start + aContext->mem[i].size))
                *aAddress = (uint8_t*) aLoadAddress;
                if start address is not aLoadAddress
                    assign the start address as new block start address
                    assign the index as new block index
                    assign (aLoadAddress - start adress) as size for new block
                    Clear new block allocation status
                    Get next slot as new block
                if end address is more than aLoadAddress + aImgSize
                    assign the (aLoadAddress + aImgSize) as new block start address
                    assign the index as new block index
                    assign (total size - (aLoadAddress + aImgSize)) as size for new block
                    Clear new block allocation status

                Update current block start address to aLoadAddress
                Update current block size to aImgSize
                Set current block allocation status as allocated

                ret = BCM_ERR_OK
                break
    return ret
    @endcode

    @limitations It assumes sufficient slots are available in aContext->mem
*/
int32_t IMGL_MemoryGet(IMGL_CommonContextType *aContext,
                         uint32_t aLoadAddress,
                         uint32_t aImgSize,
                         uint8_t **aMemory,
                         uint32_t *aOutSize)
{
    int32_t retval = BCM_ERR_NOMEM;
    uint32_t i,j;
    *aOutSize = 0UL;

    for (i = 0UL; i < IMGL_FETCH_EXE_MAX_MEM_CNT; i++) {
        if ((0UL == aContext->mem[i].allocated)
            && (aContext->mem[i].start <= aLoadAddress)
            && ((aLoadAddress + aImgSize) <= (aContext->mem[i].start + aContext->mem[i].size))) {
            *aMemory = (uint8_t *) aLoadAddress;
            /* if start address is not aLoadAddress */
            /* assign the start address to new block */
            if (aContext->mem[i].start < aLoadAddress) {
                j = aContext->freeIndex++;
                aContext->mem[j].index = aContext->mem[i].index;
                aContext->mem[j].start = aContext->mem[i].start;
                aContext->mem[j].size = aLoadAddress - aContext->mem[i].start;
                aContext->mem[j].allocated = 0UL;
            }
            /* if end address is more than aLoadAddress + aImgSize */
            /* assign the aLoadAddress + aImgSize address to new block */
            if ((aLoadAddress + aImgSize) < (aContext->mem[i].start + aContext->mem[i].size)) {
                j = aContext->freeIndex++;
                aContext->mem[j].index = aContext->mem[i].index;
                aContext->mem[j].start = (aLoadAddress + aImgSize);
                aContext->mem[j].size = ((aContext->mem[i].start + aContext->mem[i].size) - (aLoadAddress + aImgSize));
                aContext->mem[j].allocated = 0UL;
            }
            aContext->mem[i].start = aLoadAddress;
            aContext->mem[i].size = aImgSize;
            aContext->mem[i].allocated = 1UL;
            *aOutSize = aImgSize;
            retval = BCM_ERR_OK;
            break;
        }
    }

    return retval;
}
#endif

/** @brief Init State Handler (Loads PTBL and ITBL)

    @behavior Sync, Non-reentrant

    @pre IMGL is initialized

    @param[in]          aPid            Partition ID
    @param[in]          aCmd            Core Command for loading
    @param[in]          aMemory         Function pointer to get memory

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Patition authentication completed and/or loaded
    @retval     #BCM_ERR_AUTH_FAILED    Authentication failed
    @return     #BCM_ERR_NOMEM          Insufficient memory to load image
    @return     #BCM_ERR_NOT_FOUND      Image not found
    @return     #BCM_ERR_BUSY           Image loading Busy

    @post None

    @trace #BRCM_SWARCH_IMGL_FETCH_MOD_GLOBAL
    @trace #BRCM_SWARCH_IMGL_CFG_HANDLER_PROC
    @trace #BRCM_SWREQ_IMGL_CORE

    @code{.c}
    ret = IMGL_MemoryInfoGet(0UL, &addr, &size);
    if ret is not OK
        aImglContext->state = READY
    else
        do
            state = *aIntState
            if *aIntState is IMGL_INT_STATE_SET_MODE
                if aImglContext->curModMask is 0
                    aImglContext->state = IMGL_STATE_READY
                else
                    for interface  in IMGL_Interfaces
                        if interface  is valid
                            if (1 << interface ->mode) & aImglContext->curModMask != 0
                                aImglContext->curModMask &= ~(1<< interface ->mode)
                                aImglContext->curModIndex = interface  index
                                aImglContext->curChannelMask = aImglContext->loadChannelMask & ((1 << interface ->numChannels) - 1)
                                *aIntState = IMGL_INT_STATE_SET_CHANNEL
                                break
            else if aIntState is IMGL_INT_STATE_SET_CHANNEL
                for chan in 0:IMGL_Interfaces[curModIndex]->numChannels-1
                    if (1 << chan) & aImglContext->curChannelMask != 0
                        aImglContext->curChanIndex = chan
                        IMGL_SearchChannelIdx(aMode, IMGL_SharedGetChannel())Mask &= ~(1 <<chan)
                        aContext->hdr = NULL
                if chan is IMGL_Interfaces[curModIndex]->numChannels
                    aIntState = IMGL_INT_STATE_SET_MODE
            else if aIntState is IMGL_INT_STATE_LOAD_PTBL
                ret =IMGL_LoadPTBL(IMGL_Interfaces[aImglContext->curModIndex],
                                    aImglContext->curChanIndex, addr, &size, &aContext->hdr)
                if ret is OK
                    ret = PTU_ConstructPTBL(addr, size, IMGL_SharedGetPTBL());
                    if ret is OK
                        aContext->hdr = NULL
                        *aIntState = IMGL_INT_STATE_LOAD_SYSCFG_ITBL
                        aImglContext->pid[PTBL_ID_SYSCFG] = 1
                    else
                        *aIntState = IMGL_INT_STATE_SET_CHANNEL;
                else if ret is BUSY
                    break
                else
                    *aIntState = IMGL_INT_STATE_SET_CHANNEL
            else if aIntState is IMGL_INT_STATE_LOAD_SYSCFG_ITBL
                ret = PTU_GetPartitionAddr(IMGL_SharedGetPTBL(), PTBL_ID_CONSTRUCT(SYSCFG, aImglContext->pid[PTBL_ID_SYSCFG]), &itblAddr);
                if ret is OK
                    size = size(aImglContext->itbl[PTBL_ID_SYSCFG])
                    ret = IMGL_LoadITBL(IMGL_Interfaces[aImglContext->curModIndex],
                                        aImglContext->curChanIndex,
                                        SYSCFG,
                                        itblAddr,
                                        &aImglContext->itbl[PTBL_ID_SYSCFG],
                                        &size,
                                        &aContext->hdr)
                    if ret is OK
                        aContext->hdr = NULL
                        *aIntState = IMGL_INT_STATE_LOAD_FW_ITBL
                        aImglContext->pid[PTBL_ID_FW] = 1
                    else if ret is BUSY
                        break
                    else
                        *aIntState = IMGL_INT_STATE_SET_CHANNEL
                else
                    if aImglContext->pid[PTBL_ID_SYSCFG] is PTBL_MAX_NUM_COPIES
                        *aIntState = IMGL_INT_STATE_SET_CHANNEL
                    else
                        Increment aImglContext->pid[PTBL_ID_SYSCFG]
            else if aIntState is IMGL_INT_STATE_LOAD_FW_ITBL
                ret = PTU_GetPartitionAddr(IMGL_SharedGetPTBL(), PTBL_ID_CONSTRUCT(FW, aImglContext->pid[PTBL_ID_FW]), &itblAddr);
                if ret is OK
                    size = size(aImglContext->itbl[PTBL_ID_FW])
                    ret = IMGL_LoadITBL(IMGL_Interfaces[aImglContext->curModIndex],
                                        aImglContext->curChanIndex,
                                        FW,
                                        itblAddr,
                                        &aImglContext->itbl[PTBL_ID_FW],
                                        &size,
                                        &aContext->hdr)
                    if ret is OK
                        aContext->hdr = NULL
                        *aIntState = IMGL_LOAD_STATE_DONE
                    else if ret is BUSY
                        break
                    else
                        *aIntState = IMGL_INT_STATE_SET_CHANNEL
                else
                    if aImglContext->pid[PTBL_ID_FW] is PTBL_MAX_NUM_COPIES
                        *aIntState = IMGL_INT_STATE_SET_CHANNEL
                    else
                        Increment aImglContext->pid[PTBL_ID_SYSCFG]
            else (IMGL_LOAD_STATE_DONE)
                aImglContext->pid[PTBL_ID_SYSCFG] = PTBL_ID_CONSTRUCT(SYSCFG, aImglContext->pid[PTBL_ID_SYSCFG])
                aImglContext->pid[PTBL_ID_FW] = PTBL_ID_CONSTRUCT(FW, aImglContext->pid[PTBL_ID_FW])
                aImglContext->state = IMGL_STATE_READY
        while state != *aIntState
    return ret
    @endcode
*/
int32_t IMGL_InitStateHandler(IMGL_CommonContextType *aContext,
                              PTBL_IdType aInitPid,
                              IMGL_IntStateType      *aIntState,
                              IMGL_GetMemoryType      aGetMemory,
                              IMGL_LoadImgInfoType   *aImgInfo,
                              IMGL_ModeType           aMode,
                              IMGL_ChannelType      aChannel)
{
    int32_t ret =  BCM_ERR_UNKNOWN;
    IMGL_IntStateType state;
    uint16_t copyID;
    uint8_t* addr = NULL;
    uint32_t tmpSize = 0UL;
    IMGL_LoadCmdType cmd = IMGL_LOAD_CMD_INVALID;
    PTBL_Type ptbl;
    /* update mode details */
    uint32_t modeIdx = IMGL_SearchModeIdx(aMode);
    uint32_t channelIdx = IMGL_SearchChannelIdx(aMode, aChannel);

#if defined(ENABLE_IMGL_ROM)
    if (PTBL_ID_BL == aInitPid) {
        cmd = IMGL_LOAD_CMD_FETCH_BOOTLOADER;
    }
#elif defined(ENABLE_IMGL_BL)
    if (PTBL_ID_FW == aInitPid) {
        cmd = IMGL_LOAD_CMD_FETCH_NORMAL;
    }
#elif defined(ENABLE_IMGL_FW)
    if (PTBL_ID_SYSCFG == aInitPid) {
        cmd = IMGL_LOAD_CMD_FETCH_VERSION;
    }
#else
#error "No mode selected for imgl"
#endif

    if ((IMGL_LOAD_CMD_INVALID == cmd)
        || (IMGL_LOAD_MODE_MAX <= modeIdx)
        || (IMGL_CHANNEL_IDX_MAX <= channelIdx)) {
        *aIntState = IMGL_INT_STATE_ERROR;
    }

    do {
        state = *aIntState;
        switch (*aIntState) {
        case IMGL_INT_STATE_RESET:
            ret = BCM_ERR_OK;
        break;
        case IMGL_INT_STATE_INIT:
#if defined(ENABLE_IMGL_ROM) || defined(ENABLE_IMGL_BL)
            IMGL_SharedSetCopyID(aInitPid, 1U);
            if (IMGL_LOAD_MODE_RPC == aMode) {
                PTU_CreatePTBL(IMGL_SharedGetCopyID(aInitPid), 0x0, &ptbl);
                (void)IMGL_SharedSetPTBL((uint8_t*)&ptbl, PTBL_SIZE);
#if defined(ENABLE_IMGL_ROM)
                ret = IMGL_MemoryInfoGet(0UL, &addr, &tmpSize);
                if (BCM_ERR_OK == ret) {
                    PTU_CreateITBL(0U, (uint32_t)addr + sizeof(IMGL_ImgHdrType), (uint32_t)addr, tmpSize, tmpSize, (ITBL_BLType *)aContext->tempBuffer, 0UL);
                    (void)IMGL_SharedSetITBL(aInitPid, (ITBL_Type*)aContext->tempBuffer);

                    aContext->numImgs = 1UL;
                    aContext->imgIDs[0UL] = 0U;
                    aContext->curImgIdx = 0UL;
                    *aIntState = IMGL_INT_STATE_READ_IMAGE_SETUP;
                } else {
                    *aIntState = IMGL_INT_STATE_ERROR;
                }
#else
                *aIntState = IMGL_INT_STATE_LOAD_ITBL;
#endif
            } else {
                *aIntState = IMGL_INT_STATE_LOAD_PTBL;
            }
#elif defined(ENABLE_IMGL_FW)
            IMGL_SharedSetCopyID(aInitPid, (IMGL_SharedGetCopyID(PTBL_ID_FW) & PTBL_ID_COPY_MASK) >> PTBL_ID_COPY_SHIFT);
            if (IMGL_LOAD_MODE_RPC == aMode) {
                PTU_CreatePTBL(IMGL_SharedGetCopyID(aInitPid), 0x0, &ptbl);
                (void)IMGL_SharedSetPTBL((uint8_t*)&ptbl, PTBL_SIZE);
            }
            *aIntState = IMGL_INT_STATE_LOAD_ITBL;
#endif
        break;
        case IMGL_INT_STATE_LOAD_PTBL:
            ret = IMGL_LoadPTBL(IMGL_Interfaces[modeIdx], channelIdx,
                                (uint8_t*)aContext->tempBuffer, sizeof(aContext->tempBuffer), &aContext->hdr);
            if (BCM_ERR_OK == ret) {
#if defined(ENABLE_IMGL_BL)
                *aIntState = IMGL_INT_STATE_LOAD_USER_ITBL;
#else
                *aIntState = IMGL_INT_STATE_LOAD_ITBL;
#endif
            } else if (BCM_ERR_BUSY == ret) {
                break;
            } else {
                *aIntState = IMGL_INT_STATE_ERROR;
            }
        break;
#if defined(ENABLE_IMGL_BL)
        case IMGL_INT_STATE_LOAD_USER_ITBL:
            ret = IMGL_LoadITBL(IMGL_Interfaces[modeIdx], channelIdx, IMGL_SharedGetPTBL(),
                            IMGL_SharedGetCopyID(PTBL_ID_USER_DATA), (ITBL_Type *)aContext->tempBuffer, &aContext->hdr);
            if (BCM_ERR_OK == ret) {
                ret = PTU_GetImgInfo(IMGL_SharedGetPTBL(), IMGL_SharedGetCopyID(PTBL_ID_USER_DATA), IMGL_SharedGetITBL(PTBL_ID_USER_DATA),
                                    IMGL_USER_IMG_ID, &aContext->ptuImgInfo);
                if (BCM_ERR_OK == ret) {
                    *aIntState = IMGL_INT_STATE_LOAD_UPDATE_REQUEST;
                    aContext->usrImgInfo.readModeIdx = modeIdx;
                    aContext->usrImgInfo.readChannel = channelIdx;
                    aContext->usrImgInfo.pid = IMGL_SharedGetCopyID(PTBL_ID_USER_DATA);
                    aContext->usrImgInfo.imgID = IMGL_USER_IMG_ID;
                    aContext->usrImgInfo.maxSize = sizeof(IMGL_ImgHdrType);
                    aContext->usrImgInfo.readDevAddr = aContext->ptuImgInfo.flashAddr;
                    aContext->usrImgInfo.bufferSize = IMGL_MEM_AREA_MIN_SIZE;
                    BCM_MemSet(&aContext->core, 0U, sizeof(aContext->core));
                } else {
                    IMGL_MemoryReset(aContext);
                    *aIntState = IMGL_INT_STATE_LOAD_ITBL;
                }
            } else if (BCM_ERR_BUSY == ret) {
                break;
            } else {
                IMGL_MemoryReset(aContext);
                *aIntState = IMGL_INT_STATE_LOAD_ITBL;
            }
        break;
        case IMGL_INT_STATE_LOAD_UPDATE_REQUEST:
            ret = IMGL_LoadStageProcess(IMGL_LOAD_CMD_LOAD_NORMAL, &aContext->usrImgInfo,
                                &aContext->core, (uint8_t*)aContext->tempBuffer, (uint8_t*)&aContext->updateRequest);
            if (BCM_ERR_OK == ret) {
                if (MCU_RESETREASON_WD != MCU_GetResetReason()) {
                    IMGL_SharedSetCopyID(aInitPid, PTBL_MAX_NUM_COPIES);
                    aContext->updatePending = 1UL;
                }
                IMGL_MemoryReset(aContext);
                *aIntState = IMGL_INT_STATE_LOAD_ITBL;
            } else if (BCM_ERR_BUSY == ret) {
                break;
            } else {
                IMGL_MemoryReset(aContext);
                *aIntState = IMGL_INT_STATE_LOAD_ITBL;
            }
        break;
#endif
        case IMGL_INT_STATE_SET_COPY_ID:
            copyID = (IMGL_SharedGetCopyID(aInitPid) & PTBL_ID_COPY_MASK) >> PTBL_ID_COPY_SHIFT;
            if ((copyID < PTBL_MAX_NUM_COPIES) || (0UL != aContext->updatePending)) {
                if (0UL != aContext->updatePending) {
                    /* Failed to load recently updated copy(last copy) */
                    /* try from copy 1 */
                    copyID = 1U;
                    aContext->updatePending = 0UL;
                } else {
                    copyID++;
                }
                IMGL_SharedSetCopyID(aInitPid, copyID);
                IMGL_MemoryReset(aContext);
                *aIntState = IMGL_INT_STATE_LOAD_ITBL;
            } else {
                *aIntState = IMGL_INT_STATE_ERROR;
            }
        break;
        case IMGL_INT_STATE_LOAD_ITBL:
            ret = IMGL_LoadITBL(IMGL_Interfaces[modeIdx], channelIdx, IMGL_SharedGetPTBL(),
                                    IMGL_SharedGetCopyID(aInitPid), (ITBL_Type *)aContext->tempBuffer, &aContext->hdr);
            if (BCM_ERR_OK == ret) {
                aContext->numImgs = ITBL_MAX_NUM_ENTRIES;
                ret = PTU_GetImgIDs(IMGL_SharedGetITBL(aInitPid), aContext->imgIDs, &aContext->numImgs);
                if (BCM_ERR_OK == ret) {
                    aContext->curImgIdx = 0UL;
                    *aIntState = IMGL_INT_STATE_READ_IMAGE_SETUP;
                } else {
                    *aIntState = IMGL_InitStateUpdateInError(aMode);
                }
            } else if (BCM_ERR_BUSY == ret) {
                break;
            } else {
                *aIntState = IMGL_InitStateUpdateInError(aMode);
            }
        break;
        case IMGL_INT_STATE_READ_IMAGE_SETUP:
            if (aContext->curImgIdx < aContext->numImgs) {
                ret = PTU_GetImgInfo(IMGL_SharedGetPTBL(),
                                     IMGL_SharedGetCopyID(aInitPid),
                                     IMGL_SharedGetITBL(aInitPid),
                                    aContext->imgIDs[aContext->curImgIdx],
                                    &aContext->ptuImgInfo);
                if (BCM_ERR_OK == ret) {
                    aImgInfo->readModeIdx = modeIdx;
                    aImgInfo->readChannel = channelIdx;
                    aImgInfo->pid = IMGL_SharedGetCopyID(aInitPid);
                    aImgInfo->imgID = aContext->imgIDs[aContext->curImgIdx];
                    if (BCM_ERR_OK == aGetMemory(aContext, aContext->ptuImgInfo.loadAddr,
                                        aContext->ptuImgInfo.maxSize, &addr, &tmpSize)) {
                        *aIntState = IMGL_INT_STATE_READ_IMAGE;
                        aImgInfo->maxSize = aContext->ptuImgInfo.maxSize;
                        aImgInfo->readDevAddr = aContext->ptuImgInfo.flashAddr;
                        aImgInfo->bufferSize = tmpSize;
                        BCM_MemSet(&aContext->core, 0U, sizeof(aContext->core));
                    } else {
                        IMGL_SharedRemoveImgHdrs(aInitPid);
                        *aIntState = IMGL_InitStateUpdateInError(aMode);
                    }
                } else {
                    IMGL_SharedRemoveImgHdrs(aInitPid);
                    *aIntState = IMGL_InitStateUpdateInError(aMode);
                }
            }

            if (aContext->curImgIdx == aContext->numImgs) {
                *aIntState = IMGL_INT_STATE_DONE;
                ret = BCM_ERR_OK;
            }
        break;
        case IMGL_INT_STATE_READ_IMAGE:
            if ((PTBL_ID_BL == aInitPid) || (PTBL_ID_FW == aInitPid)) {
                addr = (uint8_t*)aContext->ptuImgInfo.loadAddr;
            } else {
                addr = (uint8_t*)aContext->tempBuffer;
            }
            ret = IMGL_LoadStageProcess(cmd, aImgInfo, &aContext->core,
                                        addr, (uint8_t*)aContext->ptuImgInfo.loadAddr);
            if (BCM_ERR_OK == ret) {
                ret = IMGL_SharedAddImgHdr(&aContext->core.imgHdr);
                if (BCM_ERR_OK != ret) {
                    /* report error */
                }
                aContext->curImgIdx++;
                *aIntState = IMGL_INT_STATE_READ_IMAGE_SETUP;
            } else if (BCM_ERR_BUSY == ret) {
                break;
            } else {
                IMGL_SharedRemoveImgHdrs(aInitPid);
                *aIntState = IMGL_InitStateUpdateInError(aMode);
            }
        break;
        case IMGL_INT_STATE_DONE:
            ret = BCM_ERR_OK;
#if defined(ENABLE_IMGL_ROM)
            BCM_REPORT_ERROR(BCM_IMG_ID, 0U, BRCM_SWDSGN_IMGL_INT_STATE_HANDLER_PROC, ret,
                            0UL, aChannel, aContext->core.imgHdr.flags, "Fetch request successful");
#endif
        break;
        case IMGL_INT_STATE_ERROR:
            ret = BCM_ERR_NOT_FOUND;
        break;
        default:
        break;
        }
    } while (state != *aIntState);
    return ret;
}

/**
    @trace #BRCM_SWARCH_IMGL_LOAD_IMG_PROC
    @trace #BRCM_SWARCH_IMGL_LOAD_RAW_IMG_PROC
    @trace #BRCM_SWREQ_IMGL_CORE

    @code{.c}

    BCM_MemSet(&IMGL_CommonContext, 0U, sizeof(IMGL_CommonContext))

    @endcode
*/
void IMGL_CommonInit(IMGL_CommonContextType *aContext)
{
    BCM_MemSet(aContext, 0U, sizeof(IMGL_CommonContextType));
}

/**
    @trace #BRCM_SWARCH_IMGL_GET_IMG_SIZE_PROC
    @trace #BRCM_SWREQ_IMGL_ABSTRACTION_CORE

    @code{.unparsed}
    size = 0UL;
    imgHdr = NULL;
    if aPid is PTBL_ID_BL
        imgHdr = IMGL_GetBLAddr()
    else if PTBL_ID_FW == aPid
        if BCM_ERR_OK == PTU_GetImgInfo(IMGL_SharedGetPTBL(), IMGL_SharedGetCopyID(PTBL_ID_FW),
                                         IMGL_SharedGetITBL(PTBL_ID_FW), aImgID, &ptuImgInfo)
            imgHdr = (IMGL_ImgHdrType *)ptuImgInfo.loadAddr
    else
        imgHdr = IMGL_SharedFindImgHdr(aPid, aImgID)
    if (imgHdr->magicNum is IMGL_IMGH_MAGIC)
        size = BCM_ALIGN_NEXT(imgHdr->imgSize + IMGL_IMGH_DWNLD_HDR_SIZE, IMGL_ALIGN_VALUE)
        if aOffset <= size
            size -= aOffset
        else
            size = 0
    return size;
    @endcode
*/
uint32_t IMGL_GetImgSize(PTBL_IdType aPid, uint16_t aImgID, uint32_t aOffset)
{
    uint32_t size = 0UL;
    IMGL_ImgHdrType * imgHdr = NULL;

#if defined(ENABLE_IMGL_ROM)
    if (PTBL_ID_BL == aPid) {
       imgHdr = (IMGL_ImgHdrType *)IMGL_GetBLAddr();
    }
#elif defined(ENABLE_IMGL_BL)
    if (PTBL_ID_BL == aPid) {
        imgHdr = (IMGL_ImgHdrType *)IMGL_GetBLAddr();
    } else {
        imgHdr = IMGL_SharedFindImgHdr(aPid, aImgID);
    }
#elif defined(ENABLE_IMGL_FW)
    if (PTBL_ID_FW == aPid) {
        uint32_t loadAddr = 0UL;
        if (BCM_ERR_OK == PTU_GetLoadAddress(IMGL_SharedGetITBL(PTBL_ID_FW), aImgID, &loadAddr)) {
            imgHdr = (IMGL_ImgHdrType *)loadAddr;
        }
    } else {
        imgHdr = IMGL_SharedFindImgHdr(aPid, aImgID);
    }
#endif

    if ((NULL != imgHdr) && (IMGL_IMGH_MAGIC == imgHdr->magicNum)) {
        size = BCM_ALIGN_NEXT(imgHdr->imgSize + IMGL_IMGH_DWNLD_HDR_SIZE, IMGL_ALIGN_VALUE);
        if (aOffset <= size) {
            size -= aOffset;
        } else {
            size = 0UL;
        }
    }

    return size;
}


#if defined(ENABLE_IMGL_BL) || defined(ENABLE_IMGL_FW)
/**
    @trace #BRCM_SWARCH_IMGL_LOAD_IMG_PROC
    @trace #BRCM_SWREQ_IMGL_ABSTRACTION_CORE

    @code{.unparsed}
    msg.cmd = IMGL_CMD_LOAD_NORMAL
    msg.imgID = aImgID
    msg.loadAddr = aAddr
    msg.bufferSize = aBufSize
    msg.result = ERR_UNINIT
    msg.pid = SYSCFG;

    return MSGQ_SendMsg(IMGL_GetMsgQ(), &msg, aClientMask, &aStatus->hdr)
    @endcode

*/
int32_t IMGL_LoadImg(uint16_t aImgID,
                     uint8_t *const aAddr,
                     uint32_t aBufSize,
                     const uint32_t aClientMask,
                     IMGL_LoadStatusType* const aStatus)
{
    IMGL_LoadImgMsgType msg;

    msg.cmd = IMGL_CMD_LOAD_NORMAL;
    msg.imgID = aImgID;
    msg.loadAddr = aAddr;
    msg.bufferSize = aBufSize;
    msg.offset = 0UL;
    msg.result = BCM_ERR_UNINIT;
    msg.pid = PTBL_ID_SYSCFG;

    return MSGQ_SendMsg(IMGL_GetMsgQ(), (void *)&msg, aClientMask, &aStatus->hdr);
}
#endif

/**
    @trace #BRCM_SWARCH_IMGL_LOAD_IMG_TBL_PROC
    @trace #BRCM_SWREQ_IMGL_ABSTRACTION_CORE

    @code{.unparsed}
    return IMGL_SharedGetITBL((PTBL_IdType)aImgTblID)
    @endcode

*/
const ITBL_Type *IMGL_GetImgTbl(uint8_t aImgTblID)
{
    return IMGL_SharedGetITBL((PTBL_IdType)aImgTblID);
}

/**
    @trace #BRCM_SWARCH_IMGL_GET_STATUS_PROC
    @trace #BRCM_SWREQ_IMGL_ABSTRACTION_CORE

    @code{.unparsed}
    ret = MSGQ_RecvMsg(IMGL_GetMsgQ(), aStatus->hdr, &msg)
    if ret is OK
        aStatus->mode = msg.mode
        aStatus->size = msg.actSize
        aStatus->hdr = NULL

    return ret
    @endcode

*/
int32_t IMGL_GetStatus(IMGL_LoadStatusType *const aStatus)
{
    int32_t ret;
    IMGL_LoadImgMsgType msg;

    ret = MSGQ_RecvMsg(IMGL_GetMsgQ(), aStatus->hdr, (void *)&msg);
    if (BCM_ERR_OK == ret) {
        aStatus->mode = msg.mode;
        aStatus->size = msg.actSize;
        aStatus->hdr = NULL;
        ret = msg.result;
    }

    return ret;
}

/**
    @trace #BRCM_SWARCH_IMGL_LOAD_RAW_IMG_PROC
    @trace #BRCM_SWREQ_IMGL_ABSTRACTION_CORE

    @code{.unparsed}
    msg.cmd = IMGL_CMD_LOAD_RAW
    msg.pid = aPid
    msg.imgID = aImgID
    msg.loadAddr = aAddr
    msg.offset = aOffset
    msg.bufferSize = aBufSize
    msg.result = BCM_ERR_UNINIT
    return MSGQ_SendMsg(IMGL_GetMsgQ(), (void *)&msg, aClientMask, &aStatus->hdr)
    @endcode
*/
int32_t IMGL_LoadRawImg(PTBL_IdType aPid,
                        uint16_t aImgID,
                        uint8_t *const aAddr,
                        uint32_t aOffset,
                        uint32_t aBufSize,
                        const uint32_t aClientMask,
                        IMGL_LoadStatusType* const aStatus)
{
    IMGL_LoadImgMsgType msg;
    int32_t ret;

    msg.cmd = IMGL_CMD_LOAD_RAW;
    msg.pid = aPid;
    msg.imgID = aImgID;
    msg.loadAddr = aAddr;
    msg.offset = aOffset;
    msg.bufferSize = aBufSize;
    msg.result = BCM_ERR_UNINIT;
    ret = MSGQ_SendMsg(IMGL_GetMsgQ(), (void *)&msg, aClientMask, &aStatus->hdr);
    return ret;
}

/**
    @trace #BRCM_SWARCH_IMGL_LOAD_RAW_IMG_PROC
    @trace #BRCM_SWREQ_IMGL_ABSTRACTION_CORE

    @code{.unparsed}
    if aStatus is NULL
        retVal = BCM_ERR_INVAL_PARAMS
    else
        retVal = MSGQ_TryCancelMsg(IMGL_GetMsgQ(), aStatus->hdr, (void *)&msg);
        if (retVal is BCM_ERR_OK) or (retVal is BCM_ERR_CANCELLED) or retVal is BCM_ERR_BUSY
            Do Nothing
        else
            retVal = BCM_ERR_UNKNOWN
    return retVal
    @endcode
*/
int32_t IMGL_LoadCancel(IMGL_LoadStatusType* const aStatus)
{
    IMGL_LoadImgMsgType msg;
    int32_t retVal;
    if (NULL == aStatus) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        retVal = MSGQ_TryCancelMsg(IMGL_GetMsgQ(), aStatus->hdr, (void *)&msg);
        if ((BCM_ERR_OK == retVal)
            || (BCM_ERR_CANCELLED == retVal)
            || (BCM_ERR_BUSY == retVal)) {
            /* Do Nothing */
        } else {
            retVal = BCM_ERR_UNKNOWN;
        }
    }
    return retVal;
}

/**
    @trace #BRCM_SWARCH_IMGL_LOAD_IMG_PROC
    @trace #BRCM_SWARCH_IMGL_LOAD_RAW_IMG_PROC
    @trace #BRCM_SWREQ_IMGL_CORE

    @code{.unparsed}
    for interface in IMGL_Interfaces
        if aMode is  IMGL_Interface->mode
            return idx

    return IMGL_LOAD_MODE_MAX
    @endcode
*/
uint32_t IMGL_SearchModeIdx(IMGL_ModeType aMode)
{
    uint32_t i;
    uint32_t idx = IMGL_LOAD_MODE_MAX;
    for (i = 0UL; i< IMGL_LOAD_MODE_MAX; i++) {
        if ((NULL != IMGL_Interfaces[i]) && (IMGL_Interfaces[i]->mode == aMode)) {
            idx = i;
            break;
        }
    }

    return idx;
}


/**
    @trace #BRCM_SWARCH_IMGL_LOAD_IMG_PROC
    @trace #BRCM_SWARCH_IMGL_LOAD_RAW_IMG_PROC
    @trace #BRCM_SWREQ_IMGL_CORE

    @code{.unparsed}
    for interface in IMGL_Interfaces
        if aMode is  aMode
            for channel in IMGL_CHANNEL_IDX_MAX
                if aMode->channel is aChannel
                    return idx

    return IMGL_LOAD_MODE_MAX
    @endcode
*/
IMGL_ChannelIdxType IMGL_SearchChannelIdx(IMGL_ModeType aMode, IMGL_ChannelType aChannel)
{
    uint32_t i,j;
    IMGL_ChannelIdxType channelIdx = IMGL_CHANNEL_IDX_MAX;

    for (i = 0UL; i< IMGL_LOAD_MODE_MAX; i++) {
        if ((NULL != IMGL_Interfaces[i]) && (IMGL_Interfaces[i]->mode == aMode)) {
            for (j = 0UL; j < IMGL_CHANNEL_IDX_MAX; j++) {
                if (IMGL_Interfaces[i]->channel[j] == aChannel) {
                    channelIdx = j;
                    break;
                }
            }
            break;
        }
    }

    return channelIdx;
}

/**
    @trace #BRCM_SWARCH_IMGL_LOAD_PTBL_PROC
    @trace #BRCM_SWREQ_IMGL_CORE

    @code{.c}
    if aInterface->readPTBL is NULL or aInterface->getStatus is NULL
        ret = BCM_ERR_UNKNOWN
    else if *aHdr is NULL
        ret =  aInterface->readPTBL(aChannel, ITBL_PTBL_OFFSET, aAddr, *aSize,
                                IMGL_ModEvent, aHdr);
    if ret is OK
        ret = aInterface->getStatus(*aHdr, aSize)
    else
        ret = UNKNOWN
    return ret
    @endcode
*/
int32_t IMGL_LoadPTBL(const IMGL_InterfaceType* const aInterface, IMGL_ChannelIdxType aChannel, uint8_t *aScratch,
                        uint32_t aScrtchSize, const MSGQ_MsgHdrType **aHdr)
{
    int32_t retVal = BCM_ERR_OK;
    uint8_t *addr = aScratch;
    uint32_t size = aScrtchSize;

    if ((NULL == aInterface)
        || (NULL == aInterface->readPTBL)
        || (NULL == aInterface->getStatus)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (NULL == *aHdr) {
        retVal =  aInterface->readPTBL(aChannel, IMGL_PTBL_OFFSET,
                                        addr, size, IMGL_ModEvent, aHdr);
    } else {
        /* Commenting for misra_c_2012_rule_15_7_violation */
    }

    if (BCM_ERR_OK == retVal) {
        retVal = aInterface->getStatus(*aHdr, &size);
        if (BCM_ERR_OK == retVal) {
            retVal = IMGL_SharedSetPTBL(addr , size);
        }
        if (BCM_ERR_BUSY != retVal) {
            *aHdr = NULL;
        }
    } else {
        retVal = BCM_ERR_UNKNOWN;
    }

    return retVal;
}
/** @} */

/**
    @addtogroup grp_imgl_loader_ifc
    @{
*/

/**
    @trace #BRCM_SWARCH_IMGL_LOAD_STAGE_HANDLER_PROC
    @trace #BRCM_SWREQ_IMGL_CORE
*/
#define IMGL_CORE_STAGE_DONE(aCore, aStage)         \
    {                                               \
        (aCore)->doneStages |= (1UL << (aStage));   \
        (aCore)->pendStages &= ~(1UL << (aStage));  \
        (aCore)->enStages &= ~(1UL << (aStage));    \
    }

/**
    @trace #BRCM_SWARCH_IMGL_LOAD_ITBL_PROC
    @trace #BRCM_SWREQ_IMGL_CORE

    @code{.c}
    if aInterface->readITBL is NULL or aInterface->getStatus is NULL
        ret = BCM_ERR_UNKNOWN
    else
        ret = PTU_GetPartitionAddr(aPtbl, aPtblId, &itblAddr)
    if ret is OK
        if *aHdr is NULL
            ret =  aInterface->readITBL(aChannel, aPtblId, itblAddr, aAddr, *aSize,
                                    IMGL_ModEvent, aHdr);
        if ret is OK
            ret = aInterface->getStatus(*aHdr, aSize)
        else
            ret = UNKNOWN
    return ret
    @endcode
*/
int32_t IMGL_LoadITBL(const IMGL_InterfaceType* const aInterface, IMGL_ChannelIdxType aChannel, const PTBL_Type *aPtbl,
                        PTBL_IdType aPtblId, ITBL_Type *aItbl, const MSGQ_MsgHdrType **aHdr)
{
    int32_t retVal;
    uint32_t itblAddr;
    uint32_t size;

    if ((NULL == aInterface)
        || (NULL == aInterface->readITBL)
        || (NULL == aInterface->getStatus)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        retVal = PTU_GetPartitionAddr(aPtbl, aPtblId, &itblAddr);
    }

    if (BCM_ERR_OK == retVal) {
        if (NULL == *aHdr) {
            retVal =  aInterface->readITBL(aChannel, aPtblId, itblAddr,
                                (uint8_t*)aItbl, sizeof(ITBL_Type), IMGL_ModEvent, aHdr);
        }
        if (BCM_ERR_OK == retVal) {
            retVal = aInterface->getStatus(*aHdr, &size);
            if (BCM_ERR_OK == retVal) {
                (void)IMGL_SharedSetITBL(((aPtblId & PTBL_ID_TYPE_MASK) >> PTBL_ID_TYPE_SHIFT), aItbl);
            }
            if (BCM_ERR_BUSY != retVal) {
                *aHdr = NULL;
            }
        }
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_IMGL_LOAD_STAGE_HANDLER_PROC
    @trace #BRCM_SWREQ_IMGL_CORE

    @code{.c}
    do
        aCore->chunkMovStages = 0
        for i=0:IMGL_LOAD_STAGE_NUM-1
            if (aContext->enStages & (1 << i))
                ret = IMGL_StageTable[i].handler(aCore)
                if ret is BUSY
                    aCore->pending |= (1UL << i)
                else if ret is OK
                    IMGL_CORE_STAGE_DONE(aCore, i)
                else
                    IMGL_CORE_STAGE_ERROR(aCore, i)
                    if aCore->status is OK
                        aCore->status = ret;
    while aCore->chunkMovStages is not 0
    if aContext->pendingstages is 0
        return aCore->status
    else
        return BUSY
    @endcode
*/
int32_t IMGL_LoadStageProcess(IMGL_LoadCmdType aCmd, const IMGL_LoadImgInfoType *aImgInfo,
                    IMGL_LoadContextType *aCore, uint8_t *aChunkBuffer, uint8_t *aClientBuffer)
{
    int32_t ret;
    uint32_t i;

#if defined (ENABLE_IMGL_ROM)
    if (IMGL_LOAD_CMD_INVALID == aCore->cmd) {
        aCore->cmd = aCmd;
        aCore->pendStages = 0UL;
        aCore->doneStages = 0UL;
        aCore->enStages = 0UL;
        if (IMGL_LOAD_CMD_FETCH_BOOTLOADER == aCmd) {
            aCore->chunkCnt = 1UL;
            aCore->chunkOffset = 0UL;
            aCore->chunkSize = aImgInfo->bufferSize;
            IMGL_CoreEnableStage(aCore, IMGL_LOAD_STAGE_FETCH_EXE, 0UL, aImgInfo->maxSize, IMGL_LOAD_STAGE_INVALID);
            for (i = 0UL; i < aCore->chunkCnt; i++) {
                (void)LWQ_Push(&aCore->stageInfo[IMGL_LOAD_STAGE_FETCH_EXE].procQ, (uint8_t)i);
            }
        } else {
            aCore->status = BCM_ERR_NOSUPPORT;
        }
    }
#else
    if (IMGL_LOAD_CMD_INVALID == aCore->cmd) {
        aCore->cmd = aCmd;
        aCore->pendStages = 0UL;
        aCore->doneStages = 0UL;
        aCore->enStages = 0UL;
        if (IMGL_LOAD_CMD_FETCH_NORMAL == aCmd) {
            aCore->chunkCnt = BCM_MIN(2UL, (aImgInfo->bufferSize + 32767UL)/32768UL);
            aCore->chunkOffset = sizeof(IMGL_ImgHdrType);
        } else {
            aCore->chunkCnt = 2UL;
            aCore->chunkOffset = 0UL;
        }
        aCore->chunkSize = aImgInfo->bufferSize / aCore->chunkCnt;

        switch (aCore->cmd)  {
#if defined(ENABLE_IMGL_BL)
            case IMGL_LOAD_CMD_FETCH_NORMAL:
                IMGL_CoreEnableStage(aCore, IMGL_LOAD_STAGE_READ_HDR, 0UL, sizeof(IMGL_ImgHdrType), IMGL_LOAD_STAGE_INVALID);
            break;
#endif
#if defined(ENABLE_IMGL_BL) || defined (ENABLE_IMGL_FW)
            case IMGL_LOAD_CMD_LOAD_NORMAL:
                IMGL_CoreEnableStage(aCore, IMGL_LOAD_STAGE_READ_HDR, 0UL, sizeof(IMGL_ImgHdrType), IMGL_LOAD_STAGE_INVALID);
            break;
#endif
#if defined(ENABLE_IMGL_FW)
            case IMGL_LOAD_CMD_LOAD_RAW:
                IMGL_CoreEnableStage(aCore, IMGL_LOAD_STAGE_READ_DATA, aImgInfo->rawReadOffset, aImgInfo->maxSize, IMGL_LOAD_STAGE_COPY);
                IMGL_CoreEnableStage(aCore, IMGL_LOAD_STAGE_COPY, 0UL, aImgInfo->maxSize, IMGL_LOAD_STAGE_READ_DATA);
                for (i = 0UL; i < aCore->chunkCnt; i++) {
                    (void)LWQ_Push(&aCore->stageInfo[IMGL_LOAD_STAGE_READ_DATA].procQ, (uint8_t)i);
                }
            break;
            case IMGL_LOAD_CMD_FETCH_VERSION:
                IMGL_CoreEnableStage(aCore, IMGL_LOAD_STAGE_READ_HDR, 0UL, sizeof(IMGL_ImgHdrType), IMGL_LOAD_STAGE_INVALID);
            break;
#if defined(ENABLE_IMGL_UPDATE)
            case IMGL_LOAD_CMD_UPDATE_NORMAL:
                IMGL_CoreEnableStage(aCore, IMGL_LOAD_STAGE_ERASE, 0UL, aImgInfo->maxSize, IMGL_LOAD_STAGE_INVALID);
            break;
            case IMGL_LOAD_CMD_UPDATE_USERIMG:
                IMGL_CoreEnableStage(aCore, IMGL_LOAD_STAGE_ERASE, 0UL, aImgInfo->maxSize, IMGL_LOAD_STAGE_INVALID);
            break;
            case IMGL_LOAD_CMD_ERASE_IMG:
                IMGL_CoreEnableStage(aCore, IMGL_LOAD_STAGE_ERASE, 0UL, aImgInfo->maxSize, IMGL_LOAD_STAGE_INVALID);
            break;
#endif
#endif
            default:
                 aCore->status = BCM_ERR_NOSUPPORT;
            break;
        }
    }
#endif

    do {
        aCore->chunkMovStages = 0UL;
        for (i = 0UL; i < IMGL_LOAD_STAGE_NUM; i++) {
            if (0UL != (aCore->enStages & (1UL << i))) {
                ret = (IMGL_StageTable[i])(aImgInfo, aCore, aChunkBuffer, aClientBuffer);
                if (BCM_ERR_BUSY == ret) {
                    /* Do Nothing */
                } else if (BCM_ERR_OK == ret) {
                    IMGL_CORE_STAGE_CLEAR_PENDING(aCore, i);
                    if (0UL == aCore->stageInfo[i].size) {
                        IMGL_CORE_STAGE_DONE(aCore, i);
                    }
                } else {
                    IMGL_CORE_STAGE_ERROR(aCore, i);
                    if (BCM_ERR_OK == aCore->status) {
                        aCore->status = ret;
                    }
                }
            }
        }
    } while (0UL != aCore->chunkMovStages);

    if (0UL == aCore->pendStages) {
        ret = aCore->status;
    } else {
        ret = BCM_ERR_BUSY;
    }

    return ret;
}
/** @} */
