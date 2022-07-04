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
    @defgroup grp_imgl_update_impl API Implementation
    @ingroup grp_imgl

    @addtogroup grp_imgl_update_impl
    @{

    @file imgl_update.c
    @brief IMGL API Implementation
    This source file contains the implementation of functions for IMGL update

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
#include <cache.h>
#include <imgl_loader.h>
#include <bcm_time.h>
#include <imgl_lib.h>
#include "imgl_common.h"
#include "imgl_shared_context.h"


/**
    @name IMGL update Design IDs
    @{
    @brief Design IDs for IMGL update
*/

#define BRCM_SWDSGN_IMGL_UPDATE_ORDER_GLOBAL          (0xBA03U)    /**< @brief #IMGL_UpdateOrder           */
#define BRCM_SWDSGN_IMGL_UPDATE_PEND_HANDLER          (0xBA04U)    /**< @brief #IMGL_UpdatePendHandler     */
#define BRCM_SWDSGN_IMGL_UPDATE_REQ_HANDLER           (0xBA05U)    /**< @brief #IMGL_UpdateReqHandler      */
#define BRCM_SWDSGN_IMGL_UPDATE_REQUEST_PROC          (0xBA06U)    /**< @brief #IMGL_UpdateRequest         */
#define BRCM_SWDSGN_IMGL_UPDATE_STATUS_PROC           (0xBA07U)    /**< @brief #IMGL_UpdateStatus          */
#define BRCM_SWDSGN_IMGL_UPDATE_INIT_PROC             (0xBA08U)    /**< @brief #IMGL_UpdateInit            */
/** @} */

/**
    @trace #BRCM_SWARCH_IMGL_UPDATE_STATUS_PROC
    @trace #BRCM_SWREQ_IMGL_CORE
*/
static const PTBL_IdType IMGL_UpdateOrder[] = {
    PTBL_ID_CONSTRUCT(PTBL_ID_FW, 0x01U),
    PTBL_ID_CONSTRUCT(PTBL_ID_SYSCFG, 0x01U),
    PTBL_ID_CONSTRUCT(PTBL_ID_FW, 0x02U),
    PTBL_ID_CONSTRUCT(PTBL_ID_SYSCFG, 0x02U),
    PTBL_ID_CONSTRUCT(PTBL_ID_FW, 0x03U),
    PTBL_ID_CONSTRUCT(PTBL_ID_SYSCFG, 0x03U),
};

/**
    @trace #BRCM_SWARCH_IMGL_UPDATE_REQUEST_PROC
    @trace #BRCM_SWARCH_IMGL_UPDATE_STATUS_PROC
    @trace #BRCM_SWREQ_IMGL_CORE

    IMGL_UPDATE_STATE_REQUEST
*/
static void IMGL_UpdatePendHandler(IMGL_UpdateContextType *aUpdateContext)
{
    IMGL_UpdateStateType state;
    const ITBL_Type *itbl = NULL;
    PTBL_IdType readPid = 0U;
    PTBL_IdType writePid = 0U;
    PTU_ImgInfoType ptuImgInfo;
    int32_t ret;
    uint32_t i;

    BCM_MemSet(&ptuImgInfo, 0U, sizeof(ptuImgInfo));

    do {
        if (aUpdateContext->curPartIdx < 6UL) {
            writePid = IMGL_UpdateOrder[aUpdateContext->curPartIdx];
            if (PTBL_ID_FW == ((writePid & PTBL_ID_TYPE_MASK) >> PTBL_ID_TYPE_SHIFT)) {
                itbl = IMGL_SharedGetITBL(PTBL_ID_FW);
                readPid = IMGL_SharedGetCopyID(PTBL_ID_FW);
            } else {
                itbl = IMGL_SharedGetITBL(PTBL_ID_SYSCFG);
                readPid = IMGL_SharedGetCopyID(PTBL_ID_SYSCFG);
            }
        }
        state = aUpdateContext->updateState;
        switch (state) {
        case IMGL_UPDATE_STATE_PREPARE_PENDING:
            for (i = aUpdateContext->curPartIdx; i < 6UL; i++) {
                writePid = IMGL_UpdateOrder[i];
                if ((writePid != IMGL_SharedGetCopyID(PTBL_ID_FW)) && (writePid != IMGL_SharedGetCopyID(PTBL_ID_SYSCFG))) {
                    aUpdateContext->curPartIdx = i;
                    aUpdateContext->curImgIdx = 0UL;
                    aUpdateContext->updateState = IMGL_UPDATE_STATE_SETUP_READ;
                    break;
                }
            }
            if (6UL == i) {
                ret = PTU_GetImgInfo(IMGL_SharedGetPTBL(), IMGL_SharedGetCopyID(PTBL_ID_USER_DATA), IMGL_SharedGetITBL(PTBL_ID_USER_DATA), IMGL_USER_IMG_ID, &ptuImgInfo);
                if (BCM_ERR_OK == ret) {
                    aUpdateContext->imgInfo.writeModeIdx = aUpdateContext->bootModeIdx;
                    aUpdateContext->imgInfo.writeChannel = aUpdateContext->bootChannelIdx;
                    aUpdateContext->imgInfo.pid = IMGL_SharedGetCopyID(PTBL_ID_USER_DATA);
                    aUpdateContext->imgInfo.imgID = IMGL_USER_IMG_ID;
                    aUpdateContext->imgInfo.maxSize = ptuImgInfo.maxSize;
                    aUpdateContext->imgInfo.writeDevAddr = ptuImgInfo.flashAddr;
                    aUpdateContext->imgInfo.bufferSize = IMGL_MEM_AREA_MIN_SIZE;
                    BCM_MemSet(&aUpdateContext->core, 0U, sizeof(aUpdateContext->core));
                    aUpdateContext->updateState = IMGL_UPDATE_STATE_ERASE_UD;
                } else {
                    aUpdateContext->updateState = IMGL_UPDATE_STATE_READY;
                }
            }
        break;
        case IMGL_UPDATE_STATE_SETUP_READ:
            for (i = aUpdateContext->curImgIdx; i < IMGL_MAX_IMG_HDRS; i++) {
                const IMGL_ImgHdrType* imgHdr = IMGL_SharedGetImgHdr(i);
                PTBL_IdType tmp = (PTBL_IdType)((imgHdr->flags & IMGL_IMG_FLAGS_PID_MASK)
                                    >> IMGL_IMG_FLAGS_PID_SHIFT);
                if (tmp == ((writePid & PTBL_ID_TYPE_MASK) >> PTBL_ID_TYPE_SHIFT)) {
                    uint16_t imgID = (uint16_t)((imgHdr->flags & IMGL_IMG_FLAGS_IMGID_MASK) >> IMGL_IMG_FLAGS_IMGID_SHIFT);
                    ret = PTU_GetImgInfo(IMGL_SharedGetPTBL(), writePid, itbl, imgID, &ptuImgInfo);
                    if (BCM_ERR_OK == ret) {
                        aUpdateContext->updateState = IMGL_UPDATE_STATE_WAIT_READ;
                        aUpdateContext->curImgIdx = i;
                        aUpdateContext->imgInfo.readModeIdx = aUpdateContext->bootModeIdx;
                        aUpdateContext->imgInfo.readChannel = aUpdateContext->bootChannelIdx;
                        aUpdateContext->imgInfo.pid = writePid;
                        aUpdateContext->imgInfo.imgID = imgID;
                        aUpdateContext->imgInfo.maxSize = ptuImgInfo.maxSize;
                        aUpdateContext->imgInfo.readDevAddr = ptuImgInfo.flashAddr;
                        aUpdateContext->imgInfo.bufferSize = IMGL_MEM_AREA_MIN_SIZE;
                        BCM_MemSet(&aUpdateContext->core, 0U, sizeof(aUpdateContext->core));
                        break;
                    }
                }
            }
            if (IMGL_MAX_IMG_HDRS == i) {
                aUpdateContext->curPartIdx++;
                aUpdateContext->updateState = IMGL_UPDATE_STATE_PREPARE_PENDING;
            }
        break;
        case IMGL_UPDATE_STATE_WAIT_READ:
            ret = IMGL_LoadStageProcess(IMGL_LOAD_CMD_FETCH_VERSION, &aUpdateContext->imgInfo,
                                        &aUpdateContext->core, aUpdateContext->buffer, NULL);
            if (BCM_ERR_OK == ret) {
                const IMGL_ImgHdrType* imgHdr = IMGL_SharedGetImgHdr(aUpdateContext->curImgIdx);
                if (0 != memcmp(imgHdr, &aUpdateContext->core.imgHdr, sizeof(IMGL_ImgHdrType))) {
                    ret = PTU_GetImgInfo(IMGL_SharedGetPTBL(), readPid, itbl, aUpdateContext->imgInfo.imgID, &ptuImgInfo);
                    aUpdateContext->imgInfo.writeModeIdx = aUpdateContext->bootModeIdx;
                    aUpdateContext->imgInfo.writeChannel = aUpdateContext->bootChannelIdx;
                    aUpdateContext->imgInfo.writeDevAddr = aUpdateContext->imgInfo.readDevAddr;
                    aUpdateContext->imgInfo.readDevAddr = ptuImgInfo.flashAddr;
                    aUpdateContext->imgInfo.bufferSize = IMGL_MEM_AREA_MIN_SIZE;
                    BCM_MemSet(&aUpdateContext->core, 0U, sizeof(aUpdateContext->core));
                    aUpdateContext->updateState = IMGL_UPDATE_STATE_COPY;
                } else {
                    aUpdateContext->curImgIdx++;
                    aUpdateContext->updateState = IMGL_UPDATE_STATE_SETUP_READ;
                }
            } else if (BCM_ERR_BUSY == ret) {
                break;
            } else {
                ret = PTU_GetImgInfo(IMGL_SharedGetPTBL(), readPid, itbl, aUpdateContext->imgInfo.imgID, &ptuImgInfo);
                aUpdateContext->imgInfo.writeModeIdx = aUpdateContext->bootModeIdx;
                aUpdateContext->imgInfo.writeChannel = aUpdateContext->bootChannelIdx;
                aUpdateContext->imgInfo.writeDevAddr = aUpdateContext->imgInfo.readDevAddr;
                aUpdateContext->imgInfo.readDevAddr = ptuImgInfo.flashAddr;
                BCM_MemSet(&aUpdateContext->core, 0U, sizeof(aUpdateContext->core));
                aUpdateContext->updateState = IMGL_UPDATE_STATE_COPY;
            }
        break;
        case IMGL_UPDATE_STATE_COPY:
            ret = IMGL_LoadStageProcess(IMGL_LOAD_CMD_UPDATE_NORMAL, &aUpdateContext->imgInfo,
                                        &aUpdateContext->core, aUpdateContext->buffer, NULL);
            if (BCM_ERR_OK == ret) {
                aUpdateContext->curImgIdx++;
                aUpdateContext->updateState = IMGL_UPDATE_STATE_SETUP_READ;
            } else if (BCM_ERR_BUSY == ret) {
                break;
            } else {
                aUpdateContext->curImgIdx++;
                aUpdateContext->updateState = IMGL_UPDATE_STATE_SETUP_READ;
            }
        break;
        case IMGL_UPDATE_STATE_ERASE_UD:
            ret = IMGL_LoadStageProcess(IMGL_LOAD_CMD_ERASE_IMG, &aUpdateContext->imgInfo,
                                        &aUpdateContext->core, aUpdateContext->buffer, NULL);
            if (BCM_ERR_OK == ret) {
                aUpdateContext->updateState = IMGL_UPDATE_STATE_READY;
            } else if (BCM_ERR_BUSY == ret) {
                break;
            } else {
                aUpdateContext->updateState = IMGL_UPDATE_STATE_READY;
            }
        break;
        default:
        break;
        }
    } while (state != aUpdateContext->updateState);
}

/**
    @trace #BRCM_SWARCH_IMGL_UPDATE_REQUEST_PROC
    @trace #BRCM_SWARCH_IMGL_UPDATE_STATUS_PROC
    @trace #BRCM_SWREQ_IMGL_CORE

    IMGL_UPDATE_STATE_REQUEST
*/
static void IMGL_UpdateReqHandler(IMGL_UpdateContextType *aUpdateContext)
{
    IMGL_UpdateStateType state;
    const ITBL_Type *itbl = NULL;
    PTBL_IdType pid;
    PTU_ImgInfoType ptuImgInfo;
    int32_t ret;

    do {
        state = aUpdateContext->updateState;
        switch (state) {
        case IMGL_UPDATE_STATE_REQUEST:
            aUpdateContext->status = BCM_ERR_OK;
            ret = PTU_GetImgInfo(IMGL_SharedGetPTBL(), IMGL_SharedGetCopyID(PTBL_ID_USER_DATA), IMGL_SharedGetITBL(PTBL_ID_USER_DATA), IMGL_USER_IMG_ID, &ptuImgInfo);
            if (BCM_ERR_OK == ret) {
                aUpdateContext->imgInfo.writeModeIdx = aUpdateContext->writeModeIdx;
                aUpdateContext->imgInfo.writeChannel = aUpdateContext->writeChannelIdx;
                aUpdateContext->imgInfo.pid = IMGL_SharedGetCopyID(PTBL_ID_USER_DATA);
                aUpdateContext->imgInfo.imgID = IMGL_USER_IMG_ID;
                aUpdateContext->imgInfo.maxSize = ptuImgInfo.maxSize;
                aUpdateContext->imgInfo.writeDevAddr = ptuImgInfo.flashAddr;
                aUpdateContext->imgInfo.bufferSize = IMGL_MEM_AREA_MIN_SIZE;
                BCM_MemSet(&aUpdateContext->core, 0U, sizeof(aUpdateContext->core));
                aUpdateContext->updateState = IMGL_UPDATE_STATE_PREPARE_UD;
            } else {
                aUpdateContext->status = BCM_ERR_UNKNOWN;
                aUpdateContext->updateState = IMGL_UPDATE_STATE_DONE;
            }
        break;
        case IMGL_UPDATE_STATE_PREPARE_UD:
            ret = IMGL_LoadStageProcess(IMGL_LOAD_CMD_ERASE_IMG, &aUpdateContext->imgInfo,
                                        &aUpdateContext->core, aUpdateContext->buffer, NULL);
            if (BCM_ERR_OK == ret) {
                aUpdateContext->curImgIdx = 0UL;
                aUpdateContext->updateState = IMGL_UPDATE_STATE_SETUP_WRITE_IMG;
            } else if (BCM_ERR_BUSY == ret) {
                break;
            } else {
                aUpdateContext->status = BCM_ERR_UNKNOWN;
                aUpdateContext->updateState = IMGL_UPDATE_STATE_DONE;
            }
        break;
        case IMGL_UPDATE_STATE_SETUP_WRITE_IMG:
            if (aUpdateContext->curImgIdx < aUpdateContext->request.numImgs) {
                pid = aUpdateContext->request.pid[aUpdateContext->curImgIdx];
                if (PTBL_ID_FW == pid) {
                    itbl = IMGL_SharedGetITBL(PTBL_ID_FW);
                    pid  = PTBL_ID_CONSTRUCT(pid, 0x3U);
                } else if (PTBL_ID_SYSCFG == pid) {
                    itbl = IMGL_SharedGetITBL(PTBL_ID_SYSCFG);
                    pid  = PTBL_ID_CONSTRUCT(pid, 0x3U);
                } else {
                    aUpdateContext->status = BCM_ERR_NOT_FOUND;
                    aUpdateContext->updateState = IMGL_UPDATE_STATE_DONE;
                }
                if (BCM_ERR_OK == aUpdateContext->status) {
                    ret = PTU_GetImgInfo(IMGL_SharedGetPTBL(), pid, itbl,
                            aUpdateContext->request.imgID[aUpdateContext->curImgIdx], &ptuImgInfo);
                    if (BCM_ERR_OK == ret) {
                        aUpdateContext->updateState = IMGL_UPDATE_STATE_WRITE_IMG;
                        aUpdateContext->imgInfo.readModeIdx = aUpdateContext->readModeIdx;
                        aUpdateContext->imgInfo.readChannel = aUpdateContext->readChannelIdx;
                        aUpdateContext->imgInfo.writeModeIdx = aUpdateContext->writeModeIdx;
                        aUpdateContext->imgInfo.writeChannel = aUpdateContext->writeChannelIdx;
                        aUpdateContext->imgInfo.pid = pid;
                        aUpdateContext->imgInfo.imgID = aUpdateContext->request.imgID[aUpdateContext->curImgIdx];
                        aUpdateContext->imgInfo.maxSize = ptuImgInfo.maxSize;
                        aUpdateContext->imgInfo.writeDevAddr = ptuImgInfo.flashAddr;
                        aUpdateContext->imgInfo.bufferSize = IMGL_MEM_AREA_MIN_SIZE;
                        BCM_MemSet(&aUpdateContext->core, 0U, sizeof(aUpdateContext->core));
                    } else {
                        aUpdateContext->status = BCM_ERR_NOT_FOUND;
                        aUpdateContext->updateState = IMGL_UPDATE_STATE_DONE;
                    }
                }
            } else {
                aUpdateContext->updateState = IMGL_UPDATE_STATE_WRITE_UD_SETUP;
            }
        break;
        case IMGL_UPDATE_STATE_WRITE_IMG:
            ret = IMGL_LoadStageProcess(IMGL_LOAD_CMD_UPDATE_NORMAL, &aUpdateContext->imgInfo,
                                        &aUpdateContext->core, aUpdateContext->buffer, NULL);
            if (BCM_ERR_OK == ret) {
                IMGL_ImgHdrType *hdr = IMGL_SharedFindImgHdr(aUpdateContext->request.pid[aUpdateContext->curImgIdx],
                                                aUpdateContext->request.imgID[aUpdateContext->curImgIdx]);
                IMGL_VerCmpResultType result = IMGL_VersionCompare(&aUpdateContext->core.imgHdr.version, &hdr->version);
                if ((IMGL_VER_CMP_RESULT_HIGHER == result) || (IMGL_VER_CMP_RESULT_MATCH ==  result)) {
                    aUpdateContext->updateState = IMGL_UPDATE_STATE_SETUP_WRITE_IMG;
                    aUpdateContext->curImgIdx++;
                } else {
                    aUpdateContext->status = BCM_ERR_AUTH_FAILED;
                    aUpdateContext->updateState = IMGL_UPDATE_STATE_DONE;
                }
            } else if (BCM_ERR_BUSY == ret) {
                break;
            } else {
                aUpdateContext->status = BCM_ERR_NOT_FOUND;
                aUpdateContext->updateState = IMGL_UPDATE_STATE_DONE;
            }
        break;
        case IMGL_UPDATE_STATE_WRITE_UD_SETUP:
            ret = PTU_GetImgInfo(IMGL_SharedGetPTBL(), IMGL_SharedGetCopyID(PTBL_ID_USER_DATA), IMGL_SharedGetITBL(PTBL_ID_USER_DATA), IMGL_USER_IMG_ID, &ptuImgInfo);
            if (BCM_ERR_OK == ret) {
                uint32_t crc = ~0x0UL;
                aUpdateContext->updateState = IMGL_UPDATE_STATE_WRITE_UD_WAIT;
                aUpdateContext->imgInfo.readModeIdx = aUpdateContext->readModeIdx;
                aUpdateContext->imgInfo.readChannel = aUpdateContext->readChannelIdx;
                aUpdateContext->imgInfo.writeModeIdx = aUpdateContext->writeModeIdx;
                aUpdateContext->imgInfo.writeChannel = aUpdateContext->writeChannelIdx;
                aUpdateContext->imgInfo.pid = IMGL_SharedGetCopyID(PTBL_ID_USER_DATA);
                aUpdateContext->imgInfo.imgID = IMGL_USER_IMG_ID;
                aUpdateContext->imgInfo.maxSize = sizeof(IMGL_UpdateReqType);
                aUpdateContext->imgInfo.writeDevAddr = ptuImgInfo.flashAddr;
                aUpdateContext->imgInfo.bufferSize = IMGL_MEM_AREA_MIN_SIZE;
                BCM_MemSet(&aUpdateContext->core, 0U, sizeof(aUpdateContext->core));
                aUpdateContext->core.imgHdr.magicNum = IMGL_IMGH_MAGIC;
                aUpdateContext->core.imgHdr.imgSize = sizeof(IMGL_UpdateReqType) + sizeof(IMGL_ImgHdrType) - IMGL_IMGH_DWNLD_HDR_SIZE;
                BCM_MemSet(aUpdateContext->buffer, 0U, (sizeof(IMGL_UpdateReqType) + (IMGL_ALIGN_VALUE - 1UL)) & ~(IMGL_ALIGN_VALUE - 1UL));
                BCM_MemCpy(aUpdateContext->buffer, &aUpdateContext->request, sizeof(IMGL_UpdateReqType));
                crc = BCM_CRC32Custom(aUpdateContext->core.imgHdr.iv, sizeof(IMGL_ImgHdrType) - IMGL_IMGH_DWNLD_HDR_SIZE, 0x04C11DB7UL, crc);
                crc = BCM_CRC32Custom(aUpdateContext->buffer, (sizeof(IMGL_UpdateReqType) + (IMGL_ALIGN_VALUE - 1UL)) & ~(IMGL_ALIGN_VALUE - 1UL), 0x04C11DB7UL, crc);
                aUpdateContext->core.imgHdr.errDetCode = crc;
                aUpdateContext->core.imgHdr.flags = (IMGL_IMG_FLAGS_EDC_CRC << IMGL_IMG_FLAGS_EDC_SHIFT)
                                                        | (PTBL_ID_USER_DATA << IMGL_IMG_FLAGS_PID_SHIFT)
                                                        | (IMGL_USER_IMG_ID << IMGL_IMG_FLAGS_IMGID_SHIFT);
            } else {
                aUpdateContext->status = BCM_ERR_NOT_FOUND;
                aUpdateContext->updateState = IMGL_UPDATE_STATE_DONE;
            }
        break;
        case IMGL_UPDATE_STATE_WRITE_UD_WAIT:
            ret = IMGL_LoadStageProcess(IMGL_LOAD_CMD_UPDATE_USERIMG, &aUpdateContext->imgInfo,
                                &aUpdateContext->core, aUpdateContext->buffer, NULL);
            if (BCM_ERR_OK == ret) {
                aUpdateContext->updateState = IMGL_UPDATE_STATE_DONE;
                aUpdateContext->status = BCM_ERR_OK;
            } else if (BCM_ERR_BUSY == ret) {
                break;
            } else {
                aUpdateContext->status = BCM_ERR_NOT_FOUND;
                aUpdateContext->updateState = IMGL_UPDATE_STATE_DONE;
            }
        break;
        case IMGL_UPDATE_STATE_DONE:
            aUpdateContext->updateState = IMGL_UPDATE_STATE_READY;
        break;
        default:
        break;
        }
    } while (state != aUpdateContext->updateState);

}

/**
    @trace #BRCM_SWARCH_IMGL_UPDATE_INIT_PROC
    @trace #BRCM_SWREQ_IMGL_CORE

    @code{.c}
    Reset aUpdateContext

    aUpdateContext->bootModeIdx = IMGL_SearchModeIdx(IMGL_SharedGetMode())

    IMGL_UpdateStatus()

    return ERR_OK
    @endcode
*/
int32_t IMGL_UpdateInit(IMGL_UpdateContextType *aUpdateContext, IMGL_CfgContextType *aCfgContext)
{
    IMGL_ModeType mode = IMGL_LOAD_MODE_NONE;
    IMGL_ChannelType channel = IMGL_CHANNEL_ID_INVALID;

    IMGL_SharedGetIfc(&mode, &channel);

    BCM_MemSet(aUpdateContext, 0U, sizeof(IMGL_UpdateContextType));

    /* update mode idx */
    aUpdateContext->bootMode = mode;
    aUpdateContext->bootModeIdx = IMGL_SearchModeIdx(mode);
    aUpdateContext->bootChannelIdx = IMGL_SearchChannelIdx(mode, channel);

    (void)IMGL_UpdateStatus(aUpdateContext, aCfgContext);

    return BCM_ERR_OK;
}

/**
    @trace #BRCM_SWARCH_IMGL_UPDATE_REQUEST_PROC
    @trace #BRCM_SWREQ_IMGL_CORE

    @code{.c}
    ret = BCM_ERR_UNKNOWN
    found = 0;
    if (aFetchMode is more than IMGL_LOAD_MODE_MAX) or (aFetchChannel is more than IMGL_CHANNEL_IDX_MAX)
        or (aRequest is NULL) or (aRequest->numImgs > IMGL_UPDATE_MAX_NUM_IMGS)
        ret = BCM_ERR_INVAL_PARAMS
    else IMGL_UPDATE_STATE_READY != aUpdateContext->updateState
        ret = BCM_ERR_INVAL_STATE
    else
        for (i=0; i< IMGL_LOAD_MODE_MAX; i++)
            if IMGL_Interfaces[i] is not NULL and (IMGL_Interfaces[i]->mode == aMode)
                and (NULL != aInfo[i]) and (NULL != aInfo[i]->fetchPTBL) and (NULL != aInfo[i]->fetchITBL)
                and (NULL != aInfo[i]->fetchImage) and (NULL != aInfo[i]->getState)
                and (IMGL_STATE_INIT == aInfo[i]->getState())
                aUpdateContext->request = *aRequest;
                aUpdateContext->reqInfo.readMode = aFetchMode
                aUpdateContext->reqInfo.readChannel = aFetchChannel
                aUpdateContext->reqInfo.state = IMGL_UPDATE_STATE_RESET
                aUpdateContext->updateState = IMGL_UPDATE_STATE_REQUEST
                ret = IMGL_UpdateHandler(&aUpdateContext);
                if (ret == BCM_ERR_BUSY)
                    ret = BCM_ERR_OK
                else
                    ret = BCM_ERR_NOT_FOUND
    return ret
    @endcode
*/
int32_t IMGL_UpdateRequest(IMGL_UpdateContextType *aUpdateContext,
                           IMGL_CfgContextType *aCfgContext,
                           IMGL_ModeType aFetchMode,
                           IMGL_ChannelType aFetchChannel,
                           IMGL_UpdateReqType *aRequest)
{
    int32_t ret = BCM_ERR_OK;
    if ((IMGL_SearchModeIdx(aFetchMode) >= IMGL_LOAD_MODE_MAX)
        || (aFetchChannel == IMGL_CHANNEL_ID_INVALID)
        || (NULL == aRequest)
        || (aRequest->numImgs > IMGL_UPDATE_MAX_NUM_IMGS)) {
        ret = BCM_ERR_INVAL_PARAMS;
    } else if ((aFetchChannel != IMGL_Interfaces[IMGL_SearchModeIdx(aFetchMode)]->channel[IMGL_CHANNEL_IDX0])
                && (aFetchChannel != IMGL_Interfaces[IMGL_SearchModeIdx(aFetchMode)]->channel[IMGL_CHANNEL_IDX1])) {
        ret = BCM_ERR_NODEV;
    } else if (IMGL_LOAD_MODE_NVM != aUpdateContext->bootMode) {
        ret = BCM_ERR_NOSUPPORT;
    } else if (IMGL_UPDATE_STATE_READY != aUpdateContext->updateState) {
        ret = BCM_ERR_EAGAIN;
    } else {
        aUpdateContext->readModeIdx = IMGL_SearchModeIdx(aFetchMode);
        aUpdateContext->request = *aRequest;
        aUpdateContext->readChannelIdx = IMGL_SearchChannelIdx(aFetchMode, aFetchChannel);
        aUpdateContext->updateState = IMGL_UPDATE_STATE_REQUEST;
        IMGL_UpdateStatus(aUpdateContext, aCfgContext);
    }
    return ret;
}

/**
    @code{.c}
    do
        updateState = aUpdateContext->updateState
        if aUpdateContext->updateState is IMGL_UPDATE_SATE_RESET
            BCM_MemSet
            aUpdateContext->updateState = IMGL_UPDATE_STATE_PROCESS_PENDING
        else if aUpdateContext->updateState is IMGL_UPDATE_STATE_PROCESS_PENDING
            IMGL_UpdatePendHandler(&aUpdateContext)
        else if aUpdateContext->updateState is IMGL_UPDATE_STATE_REQUEST
            IMGL_UpdateReqHandler(&aUpdateContext);
        else (READY state)
            DO Nothing
    while updateState != aUpdateContext->updateState
    if aUpdateContext->updateState > IMGL_UPDATE_STATE_READY
        ret = BCM_ERR_BUSY
    else if aUpdateContext->updateState is IMGL_UPDATE_STATE_READY
        ret = aUpdateContext->request.status
    else
        ret = BCM_ERR_INVAL_STATE
    return ret
    @endcode

    @trace #BRCM_SWARCH_IMGL_UPDATE_STATUS_PROC
    @trace #BRCM_SWREQ_IMGL_CORE
*/
int32_t IMGL_UpdateStatus(IMGL_UpdateContextType *aUpdateContext, IMGL_CfgContextType *aCfgContext)
{
    int32_t ret;
    IMGL_UpdateStateType updateState;

    if (IMGL_STATE_READY != IMGL_GetCfgState(aCfgContext)) {
        ret = BCM_ERR_BUSY;
    } else {
        do {
            updateState = aUpdateContext->updateState;
            if (IMGL_UPDATE_STATE_RESET == updateState) {
                if (IMGL_LOAD_MODE_NVM == aUpdateContext->bootMode)  {
                    aUpdateContext->status = BCM_ERR_OK;
                    aUpdateContext->readModeIdx = aUpdateContext->bootModeIdx;
                    aUpdateContext->readChannelIdx = aUpdateContext->bootChannelIdx;
                    aUpdateContext->writeModeIdx = aUpdateContext->bootModeIdx;
                    aUpdateContext->writeChannelIdx = aUpdateContext->bootChannelIdx;
                    aUpdateContext->updateState = IMGL_UPDATE_STATE_PREPARE_PENDING;
                } else {
                    /* if the boot mode is not NVM; skip update */
                    aUpdateContext->writeChannelIdx = IMGL_LOAD_MODE_MAX;
                    aUpdateContext->updateState = IMGL_UPDATE_STATE_READY;
                }
            } else if (updateState < IMGL_UPDATE_STATE_READY) {
                IMGL_UpdatePendHandler(aUpdateContext);
            } else if (updateState == IMGL_UPDATE_STATE_READY) {
                /* Do Nothing here */
            } else {
                IMGL_UpdateReqHandler(aUpdateContext);
            }
        } while (updateState != aUpdateContext->updateState);

        if (aUpdateContext->updateState != IMGL_UPDATE_STATE_READY) {
            ret = BCM_ERR_BUSY;
        } else {
            ret = aUpdateContext->status;
        }
    }
    return ret;
}


/** @} */
