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
    @defgroup grp_imgl_loader_impl Loader Implementation
    @ingroup grp_imgl

    @addtogroup grp_imgl_loader_impl
    @{

    @file imgl_loader.c
    @brief IMGL Loader Implementation
    This source file contains the implementation of functions for IMGL Loader

    @version 1.0 Initial version
*/

#include <stdlib.h>
#include <compiler.h>
#include <imgl_osil.h>
#include <bcm_utils.h>
#include <crc.h>
#include <dbg_log.h>
#include <imgl_loader.h>
#include <bcm_time.h>
#include <crypto_verify.h>
#include "imgl_shared_context.h"

/**
    @name IMGL Core Design IDs
    @{
    @brief Design IDs for IMGL Core
*/
#define BRCM_SWDSGN_IMGL_LOAD_STAGE_INFO_SET_PROC    (0xB100U)    /**< @brief #IMGL_CoreEnableStage        */
#define BRCM_SWDSGN_IMGL_ERASE_STAGE_PROC            (0xB103U)    /**< @brief #IMGL_EraseStageHndlr        */
#define BRCM_SWDSGN_IMGL_READ_HDR_STAGE_PROC         (0xB104U)    /**< @brief #IMGL_ReadHdrStageHndlr      */
#define BRCM_SWDSGN_IMGL_WRITE_HDR_STAGE_PROC        (0xB105U)    /**< @brief #IMGL_WriteHdrStageHndlr     */
#define BRCM_SWDSGN_IMGL_READ_STAGE_PROC             (0xB106U)    /**< @brief #IMGL_ReadDataStageHndlr     */
#define BRCM_SWDSGN_IMGL_WRITE_STAGE_PROC            (0xB107U)    /**< @brief #IMGL_WriteDataStageHndlr    */
#define BRCM_SWDSGN_IMGL_HASH_STAGE_PROC             (0xB108U)    /**< @brief #IMGL_VerifyStageHndlr       */
#define BRCM_SWDSGN_IMGL_COPY_STAGE_PROC             (0xB109U)    /**< @brief #IMGL_CopyStageHndlr         */
#define BRCM_SWDSGN_IMGL_FETCH_EXE_STAGE_PROC        (0xB10AU)    /**< @brief #IMGL_FetchExeStageHndlr     */
#define BRCM_SWDSGN_IMGL_HANDLERS_GLOBAL             (0xB10BU)    /**< @brief #IMGL_StageTable             */

/** @} */

/** @brief IMGL internal function to handle Erase Stage

    Arch details at @ref IMGL_StageHandlerType

    @trace #BRCM_SWARCH_IMGL_LOAD_STAGE_HANDLER_PROC
    @trace #BRCM_SWREQ_IMGL_CORE

    @code{.unparsed}
    info = &aCore->stageInfo[ERASE_STAGE]
    mask = 1 << ERASE_STAGE
    while info->size > 0
        if aCore->pendStages & mask
            ret = aModule->getStatus(info->hdr, &size)
            if ret is OK
                info->offset += aModule->minEraseSize
                info->size -= aModule->minEraseSize
                if info->size == 0
                    IMGL_CORE_STAGE_DONE(aCore, ERASE_STAGE)
                    aCore->enStages = READ_HDR
                    IMGL_CoreEnableStage(&aCore->stageInfo[READ_HDR], aImgInfo->writeDevAddr, sizeof(IMGL_ImgHdrType), IMGL_LOAD_STAGE_INVALID)
                    break
            else if ret is not BUSY
                IMGL_CORE_STAGE_ERROR(aCore, ERASE_STAGE)
            else
                aCore->pendStages |= mask
                break loop
        else
            ret = aModule->eraseImg(aChannel, aImgInfo->pid, aImgInfo->imgID,
                                    aImgInfo->writeDevAddr + info->offset, aModule->minEraseSize,
                                    IMGL_ModEvent, &aCore->hdr)
            if (ret != OK)
                IMGL_CORE_STAGE_ERROR(aCore, ERASE_STAGE)
            else
                aCore->pendStages |= mask
                break loop
    @endcode
*/
#if defined(ENABLE_IMGL_UPDATE)
static int32_t IMGL_EraseStageHndlr(const IMGL_LoadImgInfoType *aImgInfo,
                            IMGL_LoadContextType *aCore, uint8_t *aChunkBuffer,
                            uint8_t *aClientBuffer)
{
    int32_t ret;

    IMGL_LoadStageInfoType *info = &aCore->stageInfo[IMGL_LOAD_STAGE_ERASE];
    uint32_t size;
    ret = BCM_ERR_OK;

    while ((info->size > 0UL) && (BCM_ERR_OK == ret)) {
        if (IMGL_CORE_STAGE_IS_PENDING(aCore, IMGL_LOAD_STAGE_ERASE)) {
            ret = IMGL_Interfaces[aImgInfo->writeModeIdx]->getStatus(info->hdr, &size);
            if (BCM_ERR_OK == ret) {
                IMGL_CORE_STAGE_CLEAR_PENDING(aCore, IMGL_LOAD_STAGE_ERASE);
                info->offset += IMGL_Interfaces[aImgInfo->writeModeIdx]->minEraseSize;
                info->size -= BCM_MIN(IMGL_Interfaces[aImgInfo->writeModeIdx]->minEraseSize,info->size);
                if (0UL == info->size) {
                    ret = BCM_ERR_OK;
                    if (IMGL_LOAD_CMD_UPDATE_USERIMG == aCore->cmd) {
                        IMGL_CoreEnableStage(aCore, IMGL_LOAD_STAGE_WRITE_HDR, 0UL, sizeof(IMGL_ImgHdrType), IMGL_LOAD_STAGE_INVALID);
                        IMGL_CoreEnableStage(aCore, IMGL_LOAD_STAGE_WRITE_DATA, sizeof(IMGL_ImgHdrType), aImgInfo->maxSize, IMGL_LOAD_STAGE_INVALID);
                        (void)LWQ_Push(&aCore->stageInfo[IMGL_LOAD_STAGE_WRITE_DATA].procQ, 0U);
                        aCore->filledSizes[0UL] = aImgInfo->maxSize;
                    } else if (IMGL_LOAD_CMD_ERASE_IMG == aCore->cmd) {
                        /* Do Nothing */
                    } else {
                        IMGL_CoreEnableStage(aCore, IMGL_LOAD_STAGE_READ_HDR, 0UL, sizeof(IMGL_ImgHdrType), IMGL_LOAD_STAGE_INVALID);
                    }
                }
            }
        } else {
            ret = IMGL_Interfaces[aImgInfo->writeModeIdx]->eraseImg(aImgInfo->writeChannel, aImgInfo->pid, aImgInfo->imgID,
                                    aImgInfo->writeDevAddr + info->offset, IMGL_Interfaces[aImgInfo->writeModeIdx]->minEraseSize,
                                    IMGL_ModEvent, &info->hdr);
            if (BCM_ERR_OK == ret) {
                IMGL_CORE_STAGE_SET_PENDING(aCore, IMGL_LOAD_STAGE_ERASE);
            }
        }
    }

    return ret;
}
#endif

/** @brief IMGL internal function to handle Get Header Stage

    Arch details at @ref IMGL_StageHandlerType

    @trace #BRCM_SWARCH_IMGL_LOAD_STAGE_HANDLER_PROC
    @trace #BRCM_SWREQ_IMGL_CORE

    @code{.unparsed}
    mask  = 1 << READ_HDR
    while aInfo->size > 0
        if aCore->pendStages & mask
            ret = aModule->getStatus(aInfo->hdr, &size)
            if ret is OK
                aInfo->offset += size
                aInfo->size -= size
                if magic in imgHdr is OK and size is less than aImgInfo->maxSize and size >= 0
                    tmpSize = aCore->imgHdr.size - 20
                    alignedSize = ALIGN(tmpSize, 64) (for SHA and Decrypt)
                    BCM_CRC32 of header part (leaving first 20 bytes)
                    Also, Compute Hash of version information in header
                    if cmd is FETCH_IMAGE (for validation of fetchExe)
                        aCore->enStages = READ_DATA , DECRYPT , HASH , COPY
                        IMGL_CoreEnableStage(&aCore->stageInfo[READ_DATA], 512, alignedSize, IMGL_LOAD_STAGE_VERIFY)
                        IMGL_CoreEnableStage(&aCore->stageInfo[HASH], 512, alignedSize, IMGL_LOAD_STAGE_COPY)
                        IMGL_CoreEnableStage(&aCore->stageInfo[COPY], 512, tmpSize, IMGL_LOAD_STAGE_READ_DATA)
                        IMGL_CORE_STAGE_DONE(aCore, READ_HDR_STAGE)
                    else if cmd is (UPDATE CMD)
                        aCore->enStages = WRITE_HDR, READ_DATA , WRITE_DATA, DECRYPT , HASH , COPY
                        IMGL_CoreEnableStage(&aCore->stageInfo[WRITE_HDR], 512, sizeof(IMGL_ImgHdrType), IMGL_LOAD_STAGE_INVALID)
                        IMGL_CoreEnableStage(&aCore->stageInfo[READ_DATA], 512, alignedSize, IMGL_LOAD_STAGE_WRITE_DATA)
                        IMGL_CoreEnableStage(&aCore->stageInfo[WRITE_DATA], 512, alignedSize, IMGL_LOAD_STAGE_VERIFY)
                        IMGL_CoreEnableStage(&aCore->stageInfo[HASH], 512, alignedSize, IMGL_LOAD_STAGE_COPY)
                        IMGL_CoreEnableStage(&aCore->stageInfo[COPY], 512, tmpSize, IMGL_LOAD_STAGE_READ_DATA)
                        IMGL_CORE_STAGE_DONE(aCore, READ_HDR_STAGE)
                    else
                        IMGL_CORE_STAGE_ERROR(aCore, READ_HDR_STAGE)
                        Cmd Unhandled
                else if size is more than aMaxSize
                    IMGL_CORE_STAGE_ERROR(aCore, READ_HDR_STAGE)
                    aCore->status = BCM_ERR_NOMEM
                else
                    IMGL_CORE_STAGE_ERROR(aCore, READ_HDR_STAGE)
                    aCore->status = BCM_ERR_NOT_FOUND
            else if ret is not BUSY
                IMGL_CORE_STAGE_ERROR(aCore, READ_HDR)
            else
                aCore->pendStages |= mask
                break loop
        else
            ret = aModule->readImg(aChannel, aInfo->pid, aInfo->imgID,
                                    &aCore->imgHdr, aImgInfo->writeDevAddr, sizeof(*aImgHdr),
                                    IMGL_ModEvent, &aInfo->hdr)
            if (ret != OK)
                IMGL_CORE_STAGE_ERROR(aCore, READ_HDR_STAGE)
            else
                aCore->pendStages |= mask
                break loop
    @endcode
*/
#if defined(ENABLE_IMGL_FW) || defined(ENABLE_IMGL_BL)
static int32_t IMGL_ReadHdrStageHndlr(const IMGL_LoadImgInfoType *aImgInfo,
                            IMGL_LoadContextType *aCore, uint8_t *aChunkBuffer,
                            uint8_t *aClientBuffer)
{
    int32_t ret = BCM_ERR_OK;
    IMGL_LoadStageInfoType *info =  &aCore->stageInfo[IMGL_LOAD_STAGE_READ_HDR];
    uint32_t size = 0UL;
    uint8_t i;
    uint8_t chunkCnt = (uint8_t) aCore->chunkCnt;

    while ((info->size > 0UL) && (BCM_ERR_OK == ret)) {
        if (IMGL_CORE_STAGE_IS_PENDING(aCore, IMGL_LOAD_STAGE_READ_HDR)) {
            ret = IMGL_Interfaces[aImgInfo->readModeIdx]->getStatus(info->hdr, &size);
            if (BCM_ERR_OK == ret) {
                IMGL_CORE_STAGE_CLEAR_PENDING(aCore, IMGL_LOAD_STAGE_READ_HDR);
                info->offset += size;
                info->size -= size;
                uint32_t imgSize = aCore->imgHdr.imgSize - sizeof(IMGL_ImgHdrType) + IMGL_IMGH_DWNLD_HDR_SIZE;
                if ((IMGL_IMGH_MAGIC == aCore->imgHdr.magicNum)
                    && (aCore->imgHdr.imgSize >= (sizeof(IMGL_ImgHdrType) - IMGL_IMGH_DWNLD_HDR_SIZE + 4UL)) /* 4 bytes as minimum */
                    && (imgSize <= aImgInfo->maxSize)) {
                    uint32_t alignedSize = BCM_ALIGN_NEXT(imgSize , IMGL_ALIGN_VALUE);

                    if (IMGL_LOAD_CMD_FETCH_NORMAL == aCore->cmd) {
#if defined(ENABLE_IMGL_BL)
                        BCM_MemCpy(aClientBuffer, &aCore->imgHdr, sizeof(IMGL_ImgHdrType));
                        IMGL_CoreEnableStage(aCore, IMGL_LOAD_STAGE_READ_DATA, sizeof(IMGL_ImgHdrType), alignedSize, IMGL_LOAD_STAGE_VERIFY);
                        IMGL_CoreEnableStage(aCore, IMGL_LOAD_STAGE_VERIFY, sizeof(IMGL_ImgHdrType), alignedSize, IMGL_LOAD_STAGE_READ_DATA);
                        for (i = 0U; i < chunkCnt; i++) {
                            (void)LWQ_Push(&aCore->stageInfo[IMGL_LOAD_STAGE_READ_DATA].procQ, i);
                        }
#else
                        ret = BCM_ERR_NOSUPPORT;
#endif
#if defined(ENABLE_IMGL_FW) || defined(ENABLE_IMGL_BL)
                    } else if (IMGL_LOAD_CMD_LOAD_NORMAL == aCore->cmd) {
                        IMGL_CoreEnableStage(aCore, IMGL_LOAD_STAGE_READ_DATA, sizeof(IMGL_ImgHdrType), alignedSize, IMGL_LOAD_STAGE_COPY);
                        IMGL_CoreEnableStage(aCore, IMGL_LOAD_STAGE_COPY, 0UL, imgSize, IMGL_LOAD_STAGE_VERIFY);
                        IMGL_CoreEnableStage(aCore, IMGL_LOAD_STAGE_VERIFY, sizeof(IMGL_ImgHdrType), alignedSize, IMGL_LOAD_STAGE_READ_DATA);
                        for (i = 0U; i < chunkCnt; i++) {
                            (void)LWQ_Push(&aCore->stageInfo[IMGL_LOAD_STAGE_READ_DATA].procQ, i);
                        }
#endif
#if defined(ENABLE_IMGL_FW)
                    } else if (IMGL_LOAD_CMD_FETCH_VERSION == aCore->cmd) {
                        IMGL_CoreEnableStage(aCore, IMGL_LOAD_STAGE_READ_DATA, sizeof(IMGL_ImgHdrType), alignedSize, IMGL_LOAD_STAGE_VERIFY);
                        IMGL_CoreEnableStage(aCore, IMGL_LOAD_STAGE_VERIFY, sizeof(IMGL_ImgHdrType), alignedSize, IMGL_LOAD_STAGE_READ_DATA);
                        for (i = 0U; i < chunkCnt; i++) {
                            (void)LWQ_Push(&aCore->stageInfo[IMGL_LOAD_STAGE_READ_DATA].procQ, i);
                        }
#if defined(ENABLE_IMGL_UPDATE)
                    } else if (IMGL_LOAD_CMD_UPDATE_NORMAL == aCore->cmd) {

                        IMGL_CoreEnableStage(aCore, IMGL_LOAD_STAGE_WRITE_HDR, 0UL, sizeof(IMGL_ImgHdrType), IMGL_LOAD_STAGE_INVALID);
                        IMGL_CoreEnableStage(aCore, IMGL_LOAD_STAGE_READ_DATA, sizeof(IMGL_ImgHdrType), alignedSize, IMGL_LOAD_STAGE_WRITE_DATA);
                        IMGL_CoreEnableStage(aCore, IMGL_LOAD_STAGE_WRITE_DATA, sizeof(IMGL_ImgHdrType), alignedSize, IMGL_LOAD_STAGE_VERIFY);
                        IMGL_CoreEnableStage(aCore, IMGL_LOAD_STAGE_VERIFY, sizeof(IMGL_ImgHdrType), alignedSize, IMGL_LOAD_STAGE_READ_DATA);
                        for (i = 0U; i < chunkCnt; i++) {
                            (void)LWQ_Push(&aCore->stageInfo[IMGL_LOAD_STAGE_READ_DATA].procQ, i);
                        }
#endif
#endif
                    } else {
                        ret = BCM_ERR_NOSUPPORT;
                    }
                } else if (imgSize > aImgInfo->maxSize) {
                    ret = BCM_ERR_NOMEM;
                } else {
                    ret = BCM_ERR_NOT_FOUND;
                }
            }
        } else {
            ret = IMGL_Interfaces[aImgInfo->readModeIdx]->readImg(aImgInfo->readChannel, aImgInfo->pid,
                                aImgInfo->imgID, aImgInfo->readDevAddr, (uint8_t*)&aCore->imgHdr,
                                info->offset, sizeof(aCore->imgHdr),
                                IMGL_ModEvent, &info->hdr);
            if (BCM_ERR_OK == ret) {
                IMGL_CORE_STAGE_SET_PENDING(aCore, IMGL_LOAD_STAGE_READ_HDR);
            }
        }
    }
    return ret;
}
#endif
/** @brief IMGL internal function to handle image write header

    Arch details at @ref IMGL_StageHandlerType

    @trace #BRCM_SWARCH_IMGL_LOAD_STAGE_HANDLER_PROC
    @trace #BRCM_SWREQ_IMGL_CORE

    @code{.unparsed}
    info = aCore->stageInfo[WRITE_HDR]
    mask  = 1 << WRITE_HDR
    while info->size > 0 and LWQ_Length(&info->procQ) > 0
        index = LWQ_PeekFirst(info->procQ) * aCore->chunkSize
        if aCore->pendStages & mask
            ret = aModule->getStatus(aInfo->hdr, &size)
            if ret is OK
                IMGL_CORE_STAGE_DONE(aCore, WRITE_HDR)
            else if ret is not BUSY
                IMGL_CORE_STAGE_ERROR(aCore, WRITE_HDR)
                if aCore->status is OK
                    aCore->status = UNKNOWN
            else
                aCore->pendStages |= mask
        else
            ret = aModule->writeImg(aChannel, aInfo->pid, aInfo->imgID,
                                    &aCore->imgHdr, aInfo->offset, sizeof(IMGL_ImgHdrType),
                                    IMGL_ModEvent, &aInfo->hdr)
            if (ret != OK)
                IMGL_CORE_STAGE_ERROR(aCore, WRITE_HDR)
                if aCore->status is OK
                    aCore->status = UNKNOWN
            else
                aCore->pendStages |= mask
    @endcode
*/
#if defined(ENABLE_IMGL_UPDATE)
static int32_t IMGL_WriteHdrStageHndlr(const IMGL_LoadImgInfoType *aImgInfo,
                            IMGL_LoadContextType *aCore, uint8_t *aChunkBuffer,
                            uint8_t *aClientBuffer)
{
    int32_t ret;


    IMGL_LoadStageInfoType *info = &aCore->stageInfo[IMGL_LOAD_STAGE_WRITE_HDR];
    uint32_t size;
    ret = BCM_ERR_OK;

    while ((info->size > 0UL) && (BCM_ERR_OK == ret)) {
        if (IMGL_CORE_STAGE_IS_PENDING(aCore, IMGL_LOAD_STAGE_WRITE_HDR)) {
            ret = IMGL_Interfaces[aImgInfo->writeModeIdx]->getStatus(info->hdr, &size);
            if (BCM_ERR_OK == ret) {
                IMGL_CORE_STAGE_CLEAR_PENDING(aCore, IMGL_LOAD_STAGE_WRITE_HDR);
                info->offset += sizeof(IMGL_ImgHdrType);
                info->size -= sizeof(IMGL_ImgHdrType);
            }
        } else {
            ret = IMGL_Interfaces[aImgInfo->writeModeIdx]->writeImg(aImgInfo->writeChannel, aImgInfo->pid,
                                aImgInfo->imgID, aImgInfo->writeDevAddr, (uint8_t*)&aCore->imgHdr, info->offset,
                                sizeof(IMGL_ImgHdrType), IMGL_ModEvent, &info->hdr);
            if (BCM_ERR_OK == ret) {
                IMGL_CORE_STAGE_SET_PENDING(aCore, IMGL_LOAD_STAGE_WRITE_HDR);
            }
        }
    }
    return ret;
}
#endif

/** @brief IMGL internal function to handle image read

    Arch details at @ref IMGL_StageHandlerType

    @trace #BRCM_SWARCH_IMGL_LOAD_STAGE_HANDLER_PROC
    @trace #BRCM_SWREQ_IMGL_CORE

    @code{.unparsed}
    info = aCore->stageInfo[READ_DATA]
    mask  = 1 << READ_DATA
    while aInfo->size > 0 and LWQ_Length(&aInfo->procQ) > 0
        index = LWQ_PeekFirst(aInfo->procQ) * aCore->chunkSize
        if aCore->pendStages & mask
            ret = aModule->getStatus(aInfo->hdr, &size)
            if ret is OK
                aCore->pendStages &= ~mask
                aStage->offset += size
                aStage->size -= size
                index = LWQ_Pop(&info->procQ)
                LWQ_Push(aCore->stageInfo[info->next], index)
                aCore->filledSize[index] = size
                aCore->chunkMovStages++;
                if (info->size == 0)
                    IMGL_CORE_STAGE_DONE(aCore, READ_DATA)
                    aCore->status = BCM_ERR_OK;
            else if ret is not BUSY
                IMGL_CORE_STAGE_ERROR(aCore, READ_DATA)
                if aCore->status is OK
                    aCore->status = UNKNOWN
            else
                aCore->pendStages |= mask
                break
        else
            size = MIN(aCore->chunkSize, info->size)
            ret = aModule->readImg(aCore->aChannel, aImgInfo->pid, aImgInfo->imgID,
                                    aImgInfo->writeDevAddr, aChunkBuffer + (index * aCore->chunkSize), aInfo->offset, size,
                                    IMGL_ModEvent, &aInfo->hdr)
            if (ret != OK)
                IMGL_CORE_STAGE_ERROR(aCore, READ_DATA)
                if aCore->status is OK
                    aCore->status = UNKNOWN
            else
                aCore->pendStages |= mask
    @endcode
*/
#if defined(ENABLE_IMGL_FW) || defined(ENABLE_IMGL_BL)
static int32_t IMGL_ReadDataStageHndlr(const IMGL_LoadImgInfoType *aImgInfo,
                            IMGL_LoadContextType *aCore, uint8_t *aChunkBuffer,
                            uint8_t *aClientBuffer)
{
    int32_t ret = BCM_ERR_OK;
    IMGL_LoadStageInfoType *stageInfo = &aCore->stageInfo[IMGL_LOAD_STAGE_READ_DATA];
    uint32_t size = 0UL;

    while ((0UL < stageInfo->size) && (0UL < LWQ_Length(stageInfo->procQ)) && (BCM_ERR_OK == ret)) {
        uint8_t index = LWQ_PeekFirst(stageInfo->procQ);
        if (IMGL_CORE_STAGE_IS_PENDING(aCore, IMGL_LOAD_STAGE_READ_DATA)) {
            ret = IMGL_Interfaces[aImgInfo->readModeIdx]->getStatus(stageInfo->hdr, &size);
            if (BCM_ERR_OK == ret) {
                aCore->loadTime = BCM_GetTimeNs() - aCore->loadTime;
                IMGL_CORE_STAGE_CLEAR_PENDING(aCore, IMGL_LOAD_STAGE_READ_DATA);

                stageInfo->offset += size;
                stageInfo->size -= size;
                (void)LWQ_Pop(&stageInfo->procQ, &index);
                if (stageInfo->next != IMGL_LOAD_STAGE_INVALID) {
                    (void)LWQ_Push(&aCore->stageInfo[stageInfo->next].procQ, index);
                }
                aCore->chunkMovStages++;
                aCore->filledSizes[index] = size;
            }
        } else {
            aCore->loadTime = BCM_GetTimeNs();
            size = BCM_MIN(aCore->chunkSize, stageInfo->size);
            ret = IMGL_Interfaces[aImgInfo->readModeIdx]->readImg(aImgInfo->readChannel, aImgInfo->pid, aImgInfo->imgID, aImgInfo->readDevAddr,
                                                        aChunkBuffer + aCore->chunkOffset + (index * aCore->chunkSize),
                                                        stageInfo->offset, size, IMGL_ModEvent, &stageInfo->hdr);

            if (BCM_ERR_OK == ret) {
                IMGL_CORE_STAGE_SET_PENDING(aCore, IMGL_LOAD_STAGE_READ_DATA);
            }
        }
    }

    return ret;
}
#endif
/** @brief IMGL internal function to handle image write

    Arch details at @ref IMGL_StageHandlerType

    @trace #BRCM_SWARCH_IMGL_LOAD_STAGE_HANDLER_PROC
    @trace #BRCM_SWREQ_IMGL_CORE

    @code{.unparsed}
    info = aCore->stageInfo[WRITE_DATA]
    mask  = 1 << WRITE_DATA
    while info->size > 0 and LWQ_Length(&info->procQ) > 0
        index = LWQ_PeekFirst(info->procQ) * aCore->chunkSize
        if aCore->pendStages & mask
            ret = aModule->getStatus(aInfo->hdr, &size)
            if ret is OK
                aCore->pendStages &= ~mask
                aStage->offset += size
                aStage->size -= size
                index = LWQ_Pop(&info->procQ)
                LWQ_Push(aCore->stageInfo[info->next], index)
                aCore->filledSize[index] = size
                if (info->size == 0)
                    IMGL_CORE_STAGE_DONE(aCore, WRITE_DATA)
            else if ret is not BUSY
                IMGL_CORE_STAGE_ERROR(aCore, WRITE_DATA)
                if aCore->status is OK
                    aCore->status = UNKNOWN
            else
                aCore->pendStages |= mask
        else
            size = MIN(aCore->chunkSize, info->size)
            ret = aModule->writeImg(aChannel, aInfo->pid, aInfo->imgID,
                                    &aAddr[index], aInfo->offset, size,
                                    IMGL_ModEvent, &aInfo->hdr)
            if (ret != OK)
                IMGL_CORE_STAGE_ERROR(aCore, WRITE_DATA)
                if aCore->status is OK
                    aCore->status = UNKNOWN
            else
                aCore->pendStages |= mask
    @endcode
*/
#if defined(ENABLE_IMGL_UPDATE)
static int32_t IMGL_WriteDataStageHndlr(const IMGL_LoadImgInfoType *aImgInfo,
                            IMGL_LoadContextType *aCore, uint8_t *aChunkBuffer,
                            uint8_t *aClientBuffer)
{
    int32_t ret;

    IMGL_LoadStageInfoType *info = &aCore->stageInfo[IMGL_LOAD_STAGE_WRITE_DATA];
    uint32_t size = 0UL;

    ret = BCM_ERR_OK;
    while ((0UL < info->size) && (0UL < LWQ_Length(info->procQ)) && (BCM_ERR_OK == ret)) {
        uint8_t index = LWQ_PeekFirst(info->procQ);
        if (IMGL_CORE_STAGE_IS_PENDING(aCore, IMGL_LOAD_STAGE_WRITE_DATA)) {
            ret = IMGL_Interfaces[aImgInfo->writeModeIdx]->getStatus(info->hdr, &size);
            if (BCM_ERR_OK == ret) {
                IMGL_CORE_STAGE_CLEAR_PENDING(aCore, IMGL_LOAD_STAGE_WRITE_DATA);
                info->offset += aCore->filledSizes[index];
                info->size -= aCore->filledSizes[index];
                (void)LWQ_Pop(&info->procQ, &index);
                if (info->next != IMGL_LOAD_STAGE_INVALID) {
                    (void)LWQ_Push(&aCore->stageInfo[info->next].procQ, index);
                }
                aCore->chunkMovStages++;
            }
        } else {
            size = BCM_MIN(aCore->chunkSize, info->size);
            if (0UL != (size & 0xFFUL)) {
                BCM_MemSet(aChunkBuffer + (index * aCore->chunkSize) + size,
                            0x0U, (0x100UL - (size & 0xFFUL)));
                size = (size + 0xFFUL) & ~0xFFUL;
            }
            ret = IMGL_Interfaces[aImgInfo->writeModeIdx]->writeImg(aImgInfo->writeChannel, aImgInfo->pid,
                            aImgInfo->imgID, aImgInfo->writeDevAddr, aChunkBuffer + (index * aCore->chunkSize),
                            info->offset, size, IMGL_ModEvent, &info->hdr);
            if (BCM_ERR_OK == ret) {
                IMGL_CORE_STAGE_SET_PENDING(aCore, IMGL_LOAD_STAGE_WRITE_DATA);
            }
        }
    }
    return ret;
}
#endif

/** @brief IMGL internal function to handle image hashing

    Arch details at @ref IMGL_StageHandlerType

    @trace #BRCM_SWARCH_IMGL_LOAD_STAGE_HANDLER_PROC
    @trace #BRCM_SWREQ_IMGL_CORE

    @code{.unparsed}
    return BCM_ERR_OK
    @endcode
*/
static int32_t IMGL_VerifyStageHndlr(const IMGL_LoadImgInfoType *aImgInfo,
                            IMGL_LoadContextType *aCore, uint8_t *aChunkBuffer,
                            uint8_t *aClientBuffer)
{
    int32_t ret = BCM_ERR_OK;
    IMGL_LoadStageInfoType *info = &aCore->stageInfo[IMGL_LOAD_STAGE_VERIFY];
    uint8_t index;
    IMGL_StageStateType tmpState;
    CRYPTO_VerifyUpdateType *updateInfo = &aCore->verifyMsg.u.update;

    do {
        tmpState = info->state;
        switch (tmpState) {
        case IMGL_STAGE_STATE_0:
            aCore->hashTime = BCM_GetTimeNs();
            if (PTBL_ID_USER_DATA != (aImgInfo->pid & PTBL_ID_TYPE_MASK)) {
                /* try RSA */
                CRYPTO_VerifyInitType *initInfo = &aCore->verifyMsg.u.init;
                initInfo->keyHdl = CRYPTO_KEY_HDL_MVK;
                initInfo->algo = aCore->imgHdr.algo;
                initInfo->hash = aCore->imgHdr.hash;
                initInfo->padding = aCore->imgHdr.padding;
                initInfo->msgLength = info->size + sizeof(aCore->imgHdr.version);
                initInfo->sigLen = aCore->imgHdr.sigLen;
                initInfo->signature = aCore->imgHdr.signature;
                ret = CRYPTO_VerifyInit(initInfo, IMGL_ModEvent, &aCore->verifyCtx, NULL);
                if (BCM_ERR_OK == ret) {
                    info->state = IMGL_STAGE_STATE_1;
                    IMGL_CORE_STAGE_SET_PENDING(aCore, IMGL_LOAD_STAGE_VERIFY);
                }
            } else {
                info->state = IMGL_STAGE_STATE_6;
            }
        break;
        case IMGL_STAGE_STATE_1:
            ret = CRYPTO_VerifyStatus(aCore->verifyCtx, MSGQ_HDL_INVALID, &aCore->verifyMsg.status);
            if (BCM_ERR_OK == ret) {
                IMGL_CORE_STAGE_CLEAR_PENDING(aCore, IMGL_LOAD_STAGE_VERIFY);
                if (BCM_ERR_NOT_FOUND == aCore->verifyMsg.status) {
                    info->state = IMGL_STAGE_STATE_6;
                } else if (BCM_ERR_BUSY == aCore->verifyMsg.status) {
                    info->state = IMGL_STAGE_STATE_2;
                } else {
                    /* error */
                    ret = BCM_ERR_UNKNOWN;
                }
            }
        break;
        case IMGL_STAGE_STATE_2:
            /*Calculate Img Hdr Hash*/
            /*verify update req */
            updateInfo->chunkData = (uint8_t*)&aCore->imgHdr.version;
            updateInfo->chunkSize = sizeof(aCore->imgHdr.version);
            ret = CRYPTO_VerifyUpdate(aCore->verifyCtx, updateInfo, NULL);
            if (BCM_ERR_OK == ret) {
                info->state = IMGL_STAGE_STATE_3;
                IMGL_CORE_STAGE_SET_PENDING(aCore, IMGL_LOAD_STAGE_VERIFY);
            }
        break;
        case IMGL_STAGE_STATE_3:
            ret = CRYPTO_VerifyStatus(aCore->verifyCtx, MSGQ_HDL_INVALID, &aCore->verifyMsg.status);
            if (BCM_ERR_OK == ret) {
                IMGL_CORE_STAGE_CLEAR_PENDING(aCore, IMGL_LOAD_STAGE_VERIFY);
                if (BCM_ERR_BUSY == aCore->verifyMsg.status) {
                    info->state = IMGL_STAGE_STATE_4;
                } else if (BCM_ERR_OK != aCore->verifyMsg.status) {
                    ret = aCore->verifyMsg.status;
                    info->state = IMGL_STAGE_STATE_8;
                } else {
                    ret = BCM_ERR_UNKNOWN;
                    info->state = IMGL_STAGE_STATE_8;
                }
            }
        break;
        case IMGL_STAGE_STATE_4:
            if (0UL != aCore->errorStages) {
                /* clear context */
                ret = CRYPTO_VerifyCancel(aCore->verifyCtx);
                if (BCM_ERR_BUSY == ret) {
                    IMGL_CORE_STAGE_SET_PENDING(aCore, IMGL_LOAD_STAGE_VERIFY);
                    info->state = IMGL_STAGE_STATE_4;
                } else {
                    ret = BCM_ERR_AUTH_FAILED;
                    info->state = IMGL_STAGE_STATE_8;
                }
            } else if ((info->size > 0UL) && (LWQ_Length(info->procQ) > 0UL)) {
                CRYPTO_VerifyUpdateType *updateInfo = &aCore->verifyMsg.u.update;
                index = LWQ_PeekFirst(info->procQ);
                updateInfo->chunkData = (uint8_t*)&aChunkBuffer[aCore->chunkOffset + (index * aCore->chunkSize)];
                updateInfo->chunkSize = aCore->filledSizes[index];
                ret = CRYPTO_VerifyUpdate(aCore->verifyCtx, updateInfo, NULL);
                if (BCM_ERR_OK == ret) {
                    info->state = IMGL_STAGE_STATE_5;
                    IMGL_CORE_STAGE_SET_PENDING(aCore, IMGL_LOAD_STAGE_VERIFY);
                } else {
                    break;
                }
            } else {
                IMGL_CORE_STAGE_SET_PENDING(aCore, IMGL_LOAD_STAGE_VERIFY);
            }
        break;
        case IMGL_STAGE_STATE_5:
            index = LWQ_PeekFirst(info->procQ);
            ret = CRYPTO_VerifyStatus(aCore->verifyCtx, MSGQ_HDL_INVALID, &aCore->verifyMsg.status);
            if (BCM_ERR_OK == ret) {
                IMGL_CORE_STAGE_CLEAR_PENDING(aCore, IMGL_LOAD_STAGE_VERIFY);
                info->size -= aCore->filledSizes[index];
                (void)LWQ_Pop(&info->procQ, &index);
                if (info->next != IMGL_LOAD_STAGE_INVALID) {
                    (void)LWQ_Push(&aCore->stageInfo[info->next].procQ, index);
                }
                aCore->chunkMovStages++;
                if ((0UL == info->size) && (BCM_ERR_BUSY != aCore->verifyMsg.status)) {
                    ret = aCore->verifyMsg.status;
                    info->state = IMGL_STAGE_STATE_8;
                } else if ((0UL != info->size) && (BCM_ERR_BUSY == aCore->verifyMsg.status)) {
                    info->state = IMGL_STAGE_STATE_4;
                } else {
                    /* actual error is not unknown and aCore->verifyMsg.status could be BCM_ERR_OK */
                    /* clear context */
                    IMGL_CORE_STAGE_ERROR(aCore, IMGL_LOAD_STAGE_VERIFY);
                    info->state = IMGL_STAGE_STATE_4;
                    /* overwrite with actual error */
                    ret = BCM_ERR_UNKNOWN;
                }
            } else if (BCM_ERR_BUSY == ret) {
                /* Do Nothing */
            } else {
                IMGL_CORE_STAGE_CLEAR_PENDING(aCore, IMGL_LOAD_STAGE_VERIFY);
                break;
            }
        break;
        case IMGL_STAGE_STATE_6:
            aCore->crc = BCM_CRC32Custom(aCore->imgHdr.iv,
                                         sizeof(IMGL_ImgHdrType) - IMGL_IMGH_DWNLD_HDR_SIZE,
                                         0x04C11DB7UL,
                                         ~0UL);
            info->state = IMGL_STAGE_STATE_7;
        break;
        case IMGL_STAGE_STATE_7:
            while ((info->size > 0UL) && (LWQ_Length(info->procQ) > 0UL)) {
                index = LWQ_PeekFirst(info->procQ);
                aCore->crc = BCM_CRC32Custom(&aChunkBuffer[aCore->chunkOffset + (index * aCore->chunkSize)],
                                             aCore->filledSizes[index],
                                             0x04C11DB7UL,
                                             aCore->crc);
                info->size -= aCore->filledSizes[index];
                (void)LWQ_Pop(&info->procQ, &index);
                if (info->next != IMGL_LOAD_STAGE_INVALID) {
                    (void)LWQ_Push(&aCore->stageInfo[info->next].procQ, index);
                }
                aCore->chunkMovStages++;
                if (0UL == info->size) {
                    if (aCore->imgHdr.errDetCode == aCore->crc) {
                        ret = BCM_ERR_OK;
                    } else {
                        ret = BCM_ERR_AUTH_FAILED;
                    }
                    info->state = IMGL_STAGE_STATE_8;
                }
            }

            if (info->size > 0UL) {
                IMGL_CORE_STAGE_SET_PENDING(aCore, IMGL_LOAD_STAGE_VERIFY);
            }
        break;
        case IMGL_STAGE_STATE_8:
            aCore->hashTime = BCM_GetTimeNs() - aCore->hashTime;
#if defined(ENABLE_IMGL_ROM)
            BCM_REPORT_ERROR(BCM_IMG_ID, 0U, BRCM_SWDSGN_IMGL_HASH_STAGE_PROC, ret,
                            0UL, "Verification request successful");
#endif
        break;
        default:
            IMGL_CORE_STAGE_CLEAR_PENDING(aCore, IMGL_LOAD_STAGE_VERIFY);
            ret = BCM_ERR_AUTH_FAILED;
        break;
        }
    } while (tmpState != info->state);

    return ret;
}

/** @brief IMGL internal function to handle Copy to client buffer

    @trace #BRCM_SWARCH_IMGL_LOAD_STAGE_HANDLER_PROC
    @trace #BRCM_SWREQ_IMGL_CORE

    @code{.unparsed}
    info = aCore->stageInfo[AUTH]
    mask  = 1 << AUTH
    while info->size > 0 and LWQ_Length(&info->procQ) > 0
        index = LWQ_PeekFirst(info->procQ)
        offset = index * aCore->chunkSize
        BCM_MemCpy(&aCopyBase[aStage->offset], aChunkBuffer[index], aCore->filledSize[index])
        aStage->offset += aCore->filledSize[index]
        aStage->size -= aCore->filledSize[index]
        index = LWQ_Pop(&info->procQ)
        LWQ_Push(aCore->stageInfo[info->next], index)
        aCore->chunkMovStages++
        if (info->size == 0)
            IMGL_CORE_STAGE_DONE(aCore, HASH)
    @endcode
*/
#if defined(ENABLE_IMGL_BL) || defined (ENABLE_IMGL_FW)
static int32_t IMGL_CopyStageHndlr(const IMGL_LoadImgInfoType *aImgInfo,
                            IMGL_LoadContextType *aCore, uint8_t *aChunkBuffer,
                            uint8_t *aClientBuffer)
{
    int32_t ret = BCM_ERR_OK;
    IMGL_LoadStageInfoType *stageInfo = &aCore->stageInfo[IMGL_LOAD_STAGE_COPY];

    while ((0UL < stageInfo->size) && (0UL < LWQ_Length(stageInfo->procQ))) {
        uint8_t index = 0U;
        uint32_t size;
        (void)LWQ_Pop(&stageInfo->procQ, &index);
        size = BCM_MIN(aCore->filledSizes[index], stageInfo->size);
        BCM_MemCpy(&aClientBuffer[stageInfo->offset], &aChunkBuffer[aCore->chunkOffset + (index * aCore->chunkSize)], size);
        stageInfo->offset += size;
        stageInfo->size -= size;
        if (stageInfo->next != IMGL_LOAD_STAGE_INVALID) {
            (void)LWQ_Push(&aCore->stageInfo[stageInfo->next].procQ, index);
        }
        aCore->chunkMovStages++;
    }

    return ret;
}
#endif

/** @brief IMGL internal function to handle image hashing

    Arch details at @ref IMGL_StageHandlerType

    @trace #BRCM_SWARCH_IMGL_LOAD_STAGE_HANDLER_PROC
    @trace #BRCM_SWREQ_IMGL_CORE

    @code{.unparsed}
    return BCM_ERR_OK
    @endcode
*/
#if defined (ENABLE_IMGL_ROM)
static int32_t IMGL_FetchExeStageHndlr(const IMGL_LoadImgInfoType *aImgInfo,
                            IMGL_LoadContextType *aCore, uint8_t *aChunkBuffer,
                            uint8_t *aClientBuffer)
{
    int32_t ret = BCM_ERR_OK;
    IMGL_LoadStageInfoType *stageInfo = &aCore->stageInfo[IMGL_LOAD_STAGE_FETCH_EXE];
    uint32_t size = 0UL;

    while ((0UL < stageInfo->size) && (0UL < LWQ_Length(stageInfo->procQ)) && (BCM_ERR_OK == ret)) {
        uint8_t index = LWQ_PeekFirst(stageInfo->procQ);
        if (IMGL_CORE_STAGE_IS_PENDING(aCore, IMGL_LOAD_STAGE_FETCH_EXE)) {
            ret = IMGL_Interfaces[aImgInfo->readModeIdx]->getStatus(stageInfo->hdr, &size);
            if (BCM_ERR_OK == ret) {
                aCore->loadTime = BCM_GetTimeNs() - aCore->loadTime;
                IMGL_CORE_STAGE_CLEAR_PENDING(aCore, IMGL_LOAD_STAGE_FETCH_EXE);
                if (size <= aCore->chunkSize) {
                    uint32_t imgSize;
                    BCM_MemCpy(&aCore->imgHdr, aChunkBuffer + aCore->chunkOffset + (index * aCore->chunkSize), sizeof(IMGL_ImgHdrType));
                    imgSize = aCore->imgHdr.imgSize - sizeof(IMGL_ImgHdrType) + IMGL_IMGH_DWNLD_HDR_SIZE;
                    if ((IMGL_IMGH_MAGIC == aCore->imgHdr.magicNum)
                        && (aCore->imgHdr.imgSize >= (sizeof(IMGL_ImgHdrType) - IMGL_IMGH_DWNLD_HDR_SIZE + 4UL)) /* 4 bytes as minimum as the image is executable*/
                        && ((imgSize + sizeof(IMGL_ImgHdrType) <= aCore->chunkSize))) {
                        uint32_t alignedSize = BCM_ALIGN_NEXT(imgSize, IMGL_ALIGN_VALUE);
                        aCore->chunkOffset += sizeof(IMGL_ImgHdrType);
                        IMGL_CoreEnableStage(aCore, IMGL_LOAD_STAGE_VERIFY, sizeof(IMGL_ImgHdrType), alignedSize, IMGL_LOAD_STAGE_INVALID);
                        (void)LWQ_Pop(&stageInfo->procQ, &index);
                        (void)LWQ_Push(&aCore->stageInfo[IMGL_LOAD_STAGE_VERIFY].procQ, index);
                        aCore->filledSizes[index] = alignedSize;
                        aCore->chunkMovStages++;
                        /* there should be only one chunk */
                        stageInfo->size = 0UL;
#if defined(ENABLE_IMGL_ROM)
                        BCM_REPORT_ERROR(BCM_IMG_ID, 0U, BRCM_SWDSGN_IMGL_FETCH_EXE_STAGE_PROC, ret,
                                        0UL, IMGL_Interfaces[aImgInfo->readModeIdx]->channel[aImgInfo->readChannel], "Read request successful");
#endif
                    } else {
                        ret = BCM_ERR_NOT_FOUND;
                    }
                } else {
                    ret = BCM_ERR_NOMEM;
                }
            }
        } else {
            aCore->loadTime = BCM_GetTimeNs();
            size = BCM_MIN(aCore->chunkSize, stageInfo->size);
            ret = IMGL_Interfaces[aImgInfo->readModeIdx]->readImg(aImgInfo->readChannel, aImgInfo->pid, aImgInfo->imgID, aImgInfo->readDevAddr,
                                                        aChunkBuffer + aCore->chunkOffset + (index * aCore->chunkSize),
                                                        stageInfo->offset, size, IMGL_ModEvent, &stageInfo->hdr);

            if (BCM_ERR_OK == ret) {
                IMGL_CORE_STAGE_SET_PENDING(aCore, IMGL_LOAD_STAGE_FETCH_EXE);
            }
        }
    }

    return ret;
}
#endif

/**
    @trace #BRCM_SWARCH_IMGL_STAGE_TABLE_GLOBAL
    @trace #BRCM_SWREQ_IMGL_CORE
*/
const IMGL_StageHandlerType IMGL_StageTable[] = {
#if defined(ENABLE_IMGL_UPDATE)
    IMGL_EraseStageHndlr,
#else
    NULL,
#endif
#if defined(ENABLE_IMGL_BL) || defined (ENABLE_IMGL_FW)
    IMGL_ReadHdrStageHndlr,
#else
    NULL,
#endif
#if defined(ENABLE_IMGL_UPDATE)
    IMGL_WriteHdrStageHndlr,
#else
    NULL,
#endif
#if defined (ENABLE_IMGL_ROM)
    IMGL_FetchExeStageHndlr,
#else
    NULL,
#endif
#if defined(ENABLE_IMGL_BL) || defined (ENABLE_IMGL_FW)
    IMGL_ReadDataStageHndlr,
#else
    NULL,
#endif
#if defined(ENABLE_IMGL_UPDATE)
    IMGL_WriteDataStageHndlr,
#else
    NULL,
#endif
#if defined(ENABLE_IMGL_BL) || defined (ENABLE_IMGL_FW)
    IMGL_CopyStageHndlr,
#else
    NULL,
#endif
    IMGL_VerifyStageHndlr,
};


/** @brief IMGL internal function to set/init StageInfo

    @trace #BRCM_SWARCH_IMGL_LOAD_STAGE_INFO_SET_PROC
    @trace #BRCM_SWREQ_IMGL_CORE

    @code{.unparsed}
    LWQ_Init(&aInfo->procQ)
    aInfo->size = aSize
    aInfo->offset = aOffset
    aInfo->next = aNext
    aInfo->hdr = NULL
    @endcode
*/
void IMGL_CoreEnableStage(IMGL_LoadContextType *aCore,
                       IMGL_LoadStageType      aStage,
                       uint32_t            aOffset,
                       uint32_t            aSize,
                       IMGL_LoadStageType      aNext)
{
    IMGL_LoadStageInfoType *aInfo = &aCore->stageInfo[aStage];
    aCore->enStages |= 1UL << aStage;
    LWQ_Init(&aInfo->procQ);
    aInfo->size = aSize;
    aInfo->offset = aOffset;
    aInfo->next = aNext;
    aInfo->state = IMGL_STAGE_STATE_0;
    aInfo->hdr = NULL;
}

/** @} */
