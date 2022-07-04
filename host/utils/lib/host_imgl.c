/*****************************************************************************
 Copyright 2019-2022 Broadcom Limited.  All rights reserved.

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

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <sys/time.h>
#include <unistd.h>
#include <rpc_cmds.h>
#include "host_imgl.h"
#include "hipc.h"
#include <bcm_err.h>
#include "bl_downloader.h"
#include "bl_ipc_downloader.h"
#include <system_imgl.h>
#include <system_dmon.h>
#include <host_system.h>
#include <bcm_utils.h>
#include <hlog.h>
#include <crc.h>
#include <pt_utils.h>
#include <rpc_ipc_common.h>
#include <imgl_interface.h>

#define FLASH_PROGRAM_TIMEOUT_SEC   (5*60) /* 5minutes */
#define MSEC_PER_SEC                (1000)
#define USEC_PER_MSEC               (1000)

#define TAR_HEADER_NAME_OFFSET  (0UL)
#define TAR_HEADER_NAME_LENGTH  (100UL)
#define TAR_HEADER_SIZE_OFFSET  (124UL)
#define TAR_HEADER_SIZE_LENGTH  (12UL)
#define TAR_HEADER_MAGIC_OFFSET  (257UL)
#define TAR_HEADER_MAGIC_LENGTH  (6UL)

#define TAR_HEADER_SIZE (512UL)
#define TAR_CALLBACK_CURRENT    (0UL)
#define TAR_CALLBACK_TOTAL      (1UL)
#define TAR_CALLBACK_LAST       (2UL)

#define CRC32_POLY                       (0x04C11DB7UL)

#define HOST_TAR_BASE_SIZE  (2UL*1024UL*1024UL)

#define BCM_COMP_STR_MAX_LEN    (13U)

uint8_t HOST_TarBase[HOST_TAR_BASE_SIZE];

typedef struct sTAR_Parsed_ImgType {
    uint32_t isInitialized;
    uint32_t numImages;
    uint32_t imgOffsets[BL_CNTRL_MAX_IMG_COUNT];
    RPC_ImgReqV1Type pwImgHdrs[BL_CNTRL_MAX_IMG_COUNT];
    ITBL_BLType blImageTbl;
} TAR_Parsed_ImgType;

static TAR_Parsed_ImgType parsedTarImages;


#define COMPARE_IMG_HDRS_AND_SIZE(aImgHdr, i)                        \
    ((aImgHdr->pid == parsedTarImages.pwImgHdrs[i].pid) &&           \
     (aImgHdr->imgID == parsedTarImages.pwImgHdrs[i].imgID) &&       \
     (aImgHdr->imgMaxSize >= parsedTarImages.pwImgHdrs[i].imgMaxSize) &&   \
     (aImgHdr->isTbl == parsedTarImages.pwImgHdrs[i].isImgHdr))

#define COMPARE_IMG_HDRS(aImgHdr, i)                                 \
    ((aImgHdr->pid == parsedTarImages.pwImgHdrs[i].pid) &&           \
     (aImgHdr->imgID == parsedTarImages.pwImgHdrs[i].imgID) &&       \
     (aImgHdr->isTbl == parsedTarImages.pwImgHdrs[i].isImgHdr))

static uint16_t tar_get_pid(const uint8_t *const hdr)
{
    uint32_t i;
    uint16_t pid = 0UL;
    for (i = TAR_HEADER_NAME_OFFSET + 33UL; i < (TAR_HEADER_NAME_OFFSET + 33UL + 2UL); i++) {
        pid = pid * 16UL;
        if ((hdr[i] >= '0') && (hdr[i] <= '9')) {
            pid += hdr[i] - '0';
        } else if ((hdr[i] >= 'A') && (hdr[i] <= 'F')) {
            pid += hdr[i] - 'A' + 10;
        }
    }
    return pid;
}

static uint16_t tar_get_img_id(const uint8_t *const hdr)
{
    uint32_t i;
    uint16_t imgID = 0UL;
    for (i = (TAR_HEADER_NAME_OFFSET + 35UL); i < (TAR_HEADER_NAME_OFFSET + 35UL + 4UL); i++) {
        imgID = imgID * 16UL;
        if ((hdr[i] >= '0') && (hdr[i] <= '9')) {
            imgID += hdr[i] - '0';
        } else if ((hdr[i] >= 'A') && (hdr[i] <= 'F')) {
            imgID += hdr[i] - 'A' + 10;
        }
    }
    return imgID;
}

static uint32_t tar_is_img_hdr(const uint8_t *const hdr)
{
    uint32_t isImgHdr = TRUE;

    if (hdr[TAR_HEADER_NAME_OFFSET + 32UL] == '0') {
        isImgHdr = FALSE;
    }

    return isImgHdr;
}

static uint32_t tar_get_file_size(const uint8_t *const hdr)
{
    uint32_t i;
    uint32_t size = 0UL;
    for (i = TAR_HEADER_SIZE_OFFSET; i < (TAR_HEADER_SIZE_OFFSET + TAR_HEADER_SIZE_LENGTH - 1UL); i++) {
        size = size * 8UL;
        if ((hdr[i] >= '0') && (hdr[i] <= '9')) {
            size += hdr[i] - '0';
        }
    }
    return size;
}

static uint32_t tar_check_header(const uint8_t *const hdr)
{
    if ((hdr[TAR_HEADER_MAGIC_OFFSET] == 'u')
        && (hdr[TAR_HEADER_MAGIC_OFFSET + 1UL] == 's')
        && (hdr[TAR_HEADER_MAGIC_OFFSET + 2UL] == 't')
        && (hdr[TAR_HEADER_MAGIC_OFFSET + 3UL] == 'a')
        && (hdr[TAR_HEADER_MAGIC_OFFSET + 4UL] == 'r')
        && (hdr[TAR_HEADER_MAGIC_OFFSET + 5UL] == ' ')) {
            return TRUE;
    } else {
        return FALSE;
    }
}

int32_t HOST_ImglSet(const uint8_t *tar, uint32_t size)
{
    uint32_t i = 0UL;
    uint32_t offset = 0UL;
    uint32_t totalSize = 0UL;
    int32_t retVal = BCM_ERR_OK;

    if (size > HOST_TAR_BASE_SIZE) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        /*  Memset the BL partition details */
        memset(&parsedTarImages, 0U, sizeof(parsedTarImages));
        memcpy(HOST_TarBase, tar, size);
        HOST_Log("PID  ImgID   maxSz  ImgHdr\n");
        while ((offset + TAR_HEADER_SIZE < size) && (i < BL_CNTRL_MAX_IMG_COUNT)) {
            uint16_t pid = 0UL;
            uint32_t imageSize = 0UL;
            uint8_t  isImgHdr = FALSE;

            if (FALSE == tar_check_header(&tar[offset])) {
                break;
            }

            pid = tar_get_pid(&tar[offset]);
            isImgHdr = tar_is_img_hdr(&tar[offset]);
            imageSize = tar_get_file_size(&tar[offset]);
            totalSize = (TAR_HEADER_SIZE + imageSize + (TAR_HEADER_SIZE - 1UL)) & (~(TAR_HEADER_SIZE - 1UL));

            parsedTarImages.imgOffsets[i] = offset + TAR_HEADER_SIZE;

            parsedTarImages.pwImgHdrs[i].imgMaxSize = imageSize;
            parsedTarImages.pwImgHdrs[i].pid = pid;
            parsedTarImages.pwImgHdrs[i].isImgHdr = isImgHdr;

            if (FALSE == isImgHdr) {
                parsedTarImages.pwImgHdrs[i].imgID = tar_get_img_id(&tar[offset]);
            } else {
                parsedTarImages.pwImgHdrs[i].imgID = 0UL;
                if (1UL == pid) {
                    /* Bootloader partition */
                    memcpy(&parsedTarImages.blImageTbl, &tar[offset + TAR_HEADER_SIZE], sizeof(ITBL_BLType));
                }
            }

            RPC_ImgReqV1Type *hdr = &parsedTarImages.pwImgHdrs[i];
            HOST_Log("%3d 0x%04x 0x%05x %5d\n",
                     hdr->pid, hdr->imgID, hdr->imgMaxSize, hdr->isImgHdr);
            offset += totalSize;
            i++;
        }

        parsedTarImages.numImages = i;
        parsedTarImages.isInitialized = 1UL;
    }

    return retVal;
}

int32_t HOST_ImglGetPtbl(uint32_t* aOffset, uint32_t* aSize)
{
    uint32_t i;
    int32_t retval = BCM_ERR_OK;
    RPC_ImgReqV2Type imgHdr;
    RPC_ImgReqV2Type *fetchImageHdr = &imgHdr;

    imgHdr.pid = 0xFF;
    imgHdr.isTbl = 0UL;
    imgHdr.imgID = 0UL;
    imgHdr.imgMaxSize = 0;

    if ((NULL == aOffset) || (NULL == aSize)) {
        retval = BCM_ERR_INVAL_PARAMS;
    } else if (0UL == parsedTarImages.isInitialized) {
        retval = BCM_ERR_INVAL_STATE;
    } else {
        for (i = 0UL; i < parsedTarImages.numImages; i++) {
            if (COMPARE_IMG_HDRS(fetchImageHdr, i)) {
                break;
            }
        }

        if (parsedTarImages.numImages == i) {
            retval = BCM_ERR_INVAL_PARAMS;
            HOST_Log("%s:%d status:%d %d %d %d\n", __func__, __LINE__,
                fetchImageHdr->pid, fetchImageHdr->imgID, fetchImageHdr->imgMaxSize,
                fetchImageHdr->isTbl);
                goto exit;
        } else {
            *aOffset = parsedTarImages.imgOffsets[i];
            *aSize = parsedTarImages.pwImgHdrs[i].imgMaxSize;
        }
    }

exit:
    if (BCM_ERR_OK != retval) {
        HOST_Log("%s:%d status:%d\n", __func__, __LINE__, retval);
    }
    return retval;
}

int32_t HOST_ImglGetItbl(uint32_t* aOffset, uint32_t* aSize, uint32_t aPid)
{
    uint32_t i;
    int32_t retval = BCM_ERR_OK;
    RPC_ImgReqV2Type imgHdr;
    RPC_ImgReqV2Type *fetchImageHdr = &imgHdr;

    imgHdr.pid = aPid;
    imgHdr.isTbl = 1UL;
    imgHdr.imgID = 0UL;
    imgHdr.imgMaxSize = 0;

    if ((NULL == aOffset) || (NULL == aSize)) {
        retval = BCM_ERR_INVAL_PARAMS;
    } else if (0UL == parsedTarImages.isInitialized) {
        retval = BCM_ERR_INVAL_STATE;
    } else {
        for (i = 0UL; i < parsedTarImages.numImages; i++) {
            if (COMPARE_IMG_HDRS(fetchImageHdr, i)) {
                break;
            }
        }

        if (parsedTarImages.numImages == i) {
            retval = BCM_ERR_INVAL_PARAMS;
            HOST_Log("%s:%d status:%d %d %d %d\n", __func__, __LINE__,
                fetchImageHdr->pid, fetchImageHdr->imgID, fetchImageHdr->imgMaxSize,
                fetchImageHdr->isTbl);
                goto exit;
        } else {
            *aOffset = parsedTarImages.imgOffsets[i];
            *aSize = parsedTarImages.pwImgHdrs[i].imgMaxSize;
        }
    }

exit:
    if (BCM_ERR_OK != retval) {
        HOST_Log("%s:%d status:%d\n", __func__, __LINE__, retval);
    }
    return retval;
}

int32_t HOST_ImglGetImg(uint32_t* aOffset, uint32_t* aSize, uint32_t aPid, uint32_t aImgID)
{
    uint32_t i;
    int32_t retval = BCM_ERR_OK;
    RPC_ImgReqV2Type imgHdr;
    RPC_ImgReqV2Type *fetchImageHdr = &imgHdr;

    imgHdr.pid = aPid;
    imgHdr.isTbl = 0;
    imgHdr.imgID = aImgID;
    imgHdr.imgMaxSize = 0;

    if ((NULL == aOffset) || (NULL == aSize)) {
        retval = BCM_ERR_INVAL_PARAMS;
    } else if (0UL == parsedTarImages.isInitialized) {
        retval = BCM_ERR_INVAL_STATE;
    } else {
        for (i = 0UL; i < parsedTarImages.numImages; i++) {
            if (COMPARE_IMG_HDRS(fetchImageHdr, i)) {
                break;
            }
        }

        if (parsedTarImages.numImages == i) {
            retval = BCM_ERR_INVAL_PARAMS;
            HOST_Log("%s:%d pid:%d imgID:%d maxSz:%d isTbl:%d\n", __func__, __LINE__,
                fetchImageHdr->pid, fetchImageHdr->imgID, fetchImageHdr->imgMaxSize,
                fetchImageHdr->isTbl);
        } else {
            *aOffset = parsedTarImages.imgOffsets[i];
            *aSize = parsedTarImages.pwImgHdrs[i].imgMaxSize;
        }
    }

    if (BCM_ERR_OK != retval) {
        HOST_Log("%s:%d status:%d\n", __func__, __LINE__, retval);
    }
    return retval;
}

int32_t HOST_ImglGetParsedImgHdrsByPid(uint8_t aReqPID, IMGL_UpdateAutoSyncMsgType* aInfo)
{
    uint32_t i;
    int32_t retVal = BCM_ERR_OK;

    if (NULL == aInfo) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (0UL == parsedTarImages.isInitialized) {
        retVal = BCM_ERR_INVAL_STATE;
    } else {
        uint32_t count = 0UL;
        for (i = 0UL; i < parsedTarImages.numImages; i++) {
            if (aReqPID == parsedTarImages.pwImgHdrs[i].pid) {
                aInfo->imgHdr[count].isImgHdr = parsedTarImages.pwImgHdrs[i].isImgHdr;
                aInfo->imgHdr[count].pid = parsedTarImages.pwImgHdrs[i].pid;
                aInfo->imgHdr[count].imgID = uswap16(parsedTarImages.pwImgHdrs[i].imgID);
                aInfo->imgHdr[count].imgMaxSize = uswap32(parsedTarImages.pwImgHdrs[i].imgMaxSize);
                count++;
            }
        }
        aInfo->numImgs = uswap32(count);
    }
    return retVal;
}

int32_t HOST_ImglGetParsedImgHdrs(HIPC_InstallType aType, IMGL_UpdateAutoSyncMsgType* aInfo)
{
    uint32_t i;
    int32_t retVal = BCM_ERR_OK;

    if (NULL == aInfo) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (0UL == parsedTarImages.isInitialized) {
        retVal = BCM_ERR_INVAL_STATE;
    } else {
        uint32_t count = 0UL;
        for (i = 0UL; i < parsedTarImages.numImages; i++) {
            if (1U == parsedTarImages.pwImgHdrs[i].pid) {
                /* Check of the image entry is present */
                if ((parsedTarImages.pwImgHdrs[i].isImgHdr == FALSE)
                    && (parsedTarImages.pwImgHdrs[i].imgID !=
                        uswap16(parsedTarImages.blImageTbl.entry.imgType))) {
                    continue;
                }
            }
            if ((HIPC_INSTALL_OTA == aType) &&
                ((TRUE == parsedTarImages.pwImgHdrs[i].isImgHdr)
                || ((3U != parsedTarImages.pwImgHdrs[i].pid) && (5U != parsedTarImages.pwImgHdrs[i].pid))
                || (0xFFU == parsedTarImages.pwImgHdrs[i].pid))) {
                continue; /*No update of Image Table or Patition Table during OTA */
            }
            aInfo->imgHdr[count].isImgHdr = parsedTarImages.pwImgHdrs[i].isImgHdr;
            aInfo->imgHdr[count].pid = parsedTarImages.pwImgHdrs[i].pid;
            aInfo->imgHdr[count].imgID = uswap16(parsedTarImages.pwImgHdrs[i].imgID);
            aInfo->imgHdr[count].imgMaxSize = uswap32(parsedTarImages.pwImgHdrs[i].imgMaxSize);
            count++;
        }
        aInfo->numImgs = uswap32(count);
    }
    return retVal;
}

static int32_t transfer_image(const uint8_t *const image, const uint32_t imgLen, uint32_t fetchId, const RPC_ImgReqV2Type *const fetchImageHdr)
{
    int32_t retVal = -1;
    uint32_t recv_len;
    uint32_t i, itr, offset, cpy_sz;
    uint32_t dlImgInfoSz;
    RPC_DwnldImageType *dlImgPtr;
    uint32_t hdrCmdId;
    uint32_t imgCmdId;
    uint32_t hdrSz;
    int32_t *respPtr;
    uint32_t expRespLen;
    uint8_t sendMsgBuf[RPC_CMDPAYLOADSZ];

    /* Send Download header */
    if ((RPC_CMDIDVAL_IMAGE_FETCH_V1 == fetchId) || (RPC_CMDIDVAL_IMAGE_PART_FETCH_V1 == fetchId)) {
        IMGL_ImgHdrType *imgHdrPtr = (IMGL_ImgHdrType *)sendMsgBuf;
        imgHdrPtr->magicNum = uswap32(IMGL_IMGH_MAGIC);
        imgHdrPtr->imgSize = uswap32(imgLen);
        imgHdrPtr->flags = uswap32(1UL);
        /* Compute CRC using BCM_CRC32() when CRC is enabled in flags */
        imgHdrPtr->errDetCode = uswap64(BCM_CRC32(image, imgLen, CRC32_POLY));
        hdrCmdId = BCM_CMDID(BCM_GROUPID_IMGL, BCM_RSV_ID, RPC_CMDIDVAL_DWNLD_IMG_HDR_V1);
        hdrSz = sizeof(BL_DWNLD_ImgHdrType);

        imgCmdId = BCM_CMDID(BCM_GROUPID_IMGL, BCM_RSV_ID, RPC_CMDIDVAL_DWNLD_IMG_V1);
        dlImgInfoSz = 0UL;
        dlImgPtr = NULL;
        respPtr = (int32_t *)sendMsgBuf;
        expRespLen = sizeof(int32_t);
    } else {
        RPC_DwnldHdrV2Type *imgHdrPtr = (RPC_DwnldHdrV2Type *)sendMsgBuf;
        imgHdrPtr->magicNum = uswap32(IMGL_IMGH_MAGIC);
        imgHdrPtr->pid = fetchImageHdr->pid;
        imgHdrPtr->rsv = 0U;
        imgHdrPtr->imgID = uswap16(fetchImageHdr->imgID);
        imgHdrPtr->imgSize = uswap32(imgLen);
        imgHdrPtr->targetStrmHdl = uswap32(fetchImageHdr->targetStrmHdl);
        imgHdrPtr->hostStrmHdl = 0UL;
        hdrCmdId = BCM_CMDID(BCM_GROUPID_IMGL, BCM_RSV_ID, RPC_CMDIDVAL_DWNLD_IMG_HDR_V2);
        hdrSz = sizeof(RPC_DwnldHdrV2Type);

        imgCmdId = BCM_CMDID(BCM_GROUPID_IMGL, BCM_RSV_ID, RPC_CMDIDVAL_DWNLD_IMG_V2);
        dlImgInfoSz = sizeof(RPC_DwnldImageType) - RPC_STREAMDATA_PAYLOAD_SIZE;
        dlImgPtr = (RPC_DwnldImageType *)sendMsgBuf;
        respPtr = &imgHdrPtr->response;
        expRespLen = sizeof(RPC_DwnldHdrV2Type);
    }

    HOST_Log("transfer_image: len: %d\n", imgLen);
    retVal = HIPC_SendRecv(hdrCmdId, sendMsgBuf, hdrSz,
                           sendMsgBuf, sizeof(sendMsgBuf), &recv_len);

    if (retVal != BCM_ERR_OK) {
        goto done;
    } else if (BCM_ERR_OK != uswap32(*respPtr)) {
        HOST_Log("%s:%d status:%d\n", __func__, __LINE__, uswap32(*respPtr));
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    } else if (recv_len != expRespLen) {
        HOST_Log("%s len:0x%x, exp:0x%x\n", __func__, recv_len, expRespLen);
        retVal = BCM_ERR_DATA_INTEG;
        goto done;
    }

    itr = imgLen / RPC_STREAMDATA_PAYLOAD_SIZE;
    if (0UL != (imgLen % RPC_STREAMDATA_PAYLOAD_SIZE)) {
        itr++;
    }

    offset = 0UL;
    for (i = 0UL; i < itr; i++) {
        /* copy image chunk */
        cpy_sz = imgLen - offset;

        if (cpy_sz > RPC_STREAMDATA_PAYLOAD_SIZE) {
            cpy_sz = RPC_STREAMDATA_PAYLOAD_SIZE;
        }

        if (0UL != dlImgInfoSz) {
            dlImgPtr->offset = uswap32(offset);
            dlImgPtr->len = uswap32(cpy_sz);
            dlImgPtr->magicNum = uswap32(RPC_IPC_STREAM_MAGIC);
            dlImgPtr->pid = fetchImageHdr->pid;
            dlImgPtr->rsv1 = 0U;
            dlImgPtr->rsv2 = 0UL;
            dlImgPtr->imgID = uswap16(fetchImageHdr->imgID);
            dlImgPtr->targetStrmHdl = uswap32(fetchImageHdr->targetStrmHdl);
            dlImgPtr->hostStrmHdl = 0UL;
            respPtr = &dlImgPtr->response;
            expRespLen = sizeof(RPC_DwnldImageType);
        } else {
            respPtr = (int32_t *)sendMsgBuf;
            expRespLen = sizeof(int32_t);
        }

        memcpy(&sendMsgBuf[dlImgInfoSz], &image[offset], cpy_sz);

        retVal = HIPC_SendRecv(imgCmdId, sendMsgBuf, (cpy_sz + dlImgInfoSz),
                               sendMsgBuf, sizeof(sendMsgBuf), &recv_len);

        if (retVal != BCM_ERR_OK) {
            goto done;
        } else if (BCM_ERR_OK != uswap32(*respPtr)) {
            HOST_Log("%s:%d status:%d\n", __func__, __LINE__, uswap32(*respPtr));
            retVal = BCM_ERR_UNKNOWN;
            goto done;
        } else if (recv_len != expRespLen) {
            HOST_Log("%s len:0x%x exp:0x%x\n", __func__, recv_len, expRespLen);
            retVal = BCM_ERR_DATA_INTEG;
            goto done;
        }
        offset += cpy_sz;
    }
    HOST_Log("transfer_image: done\n");

done:
    return retVal;
}

static int32_t service_image_fetch_request(uint32_t id, const RPC_ImgReqV2Type *const fetchImageHdr)
{
    uint32_t i = 0UL;
    int32_t retVal = -1;

    HOST_Log("fetch request: pid:%x imgID:%x isTbl:%x\n", fetchImageHdr->pid, fetchImageHdr->imgID, fetchImageHdr->isTbl);
    if ((RPC_CMDIDVAL_IMAGE_PART_FETCH_V1 == id)
        || (RPC_CMDIDVAL_IMAGE_PART_FETCH_V2 == id)) {
        for (i = 0UL; i < parsedTarImages.numImages; i++) {
            if (COMPARE_IMG_HDRS(fetchImageHdr, i)) {
                break;
            }
        }

    } else {
        for (i = 0UL; i < parsedTarImages.numImages; i++) {
            if (COMPARE_IMG_HDRS_AND_SIZE(fetchImageHdr, i)) {
                break;
            }
        }
    }

    if (parsedTarImages.numImages == i) {
        retVal = BCM_ERR_INVAL_PARAMS;
        HOST_Log("%s:%d status:%d PID:%d ImgID:%d maxSz:%d isTbl:%d\n",
                 __func__, __LINE__, retVal,
                 fetchImageHdr->pid, fetchImageHdr->imgID,
                 fetchImageHdr->imgMaxSize, fetchImageHdr->isTbl);
        retVal = transfer_image(NULL, 0UL, id, fetchImageHdr);
    } else if (fetchImageHdr->offset >= parsedTarImages.pwImgHdrs[i].imgMaxSize) {
        HOST_Log("%s:%d status:%d PID:%d ImgID:%d maxSz:%d isTbl:%d\n",
                 __func__, __LINE__, retVal,
                 fetchImageHdr->pid, fetchImageHdr->imgID,
                 fetchImageHdr->imgMaxSize, fetchImageHdr->isTbl);
        retVal = transfer_image(NULL, 0UL, id, fetchImageHdr);
    } else {
        uint32_t size = parsedTarImages.pwImgHdrs[i].imgMaxSize - fetchImageHdr->offset;
        uint32_t offset = parsedTarImages.imgOffsets[i] + fetchImageHdr->offset;
        if (size > fetchImageHdr->imgMaxSize) {
            size = fetchImageHdr->imgMaxSize;
        }
        retVal = transfer_image(HOST_TarBase + offset, size, id, fetchImageHdr);
    }

    if (BCM_ERR_OK != retVal) {
        HOST_Log("%s:%d status:%d\n", __func__, __LINE__, retVal);
        goto exit;
    }

exit:
    return retVal;
}


const char * HOST_TargetBootStates[] = {
    "NONE",
    "ROM",
    "BL",
    "FW"
};

static RPC_ImgReqV2Type CurrentImgReq;
extern int32_t HOST_ImglNotificationHandler(uint32_t currentSlave,
                BCM_CompIDType comp, uint32_t notificationId,
                uint8_t *msg, uint32_t size)
{
    int32_t retVal;
    RPC_ImgReqV2Type hdr;
    BCM_DbgMsgType *dbg;
    BCM_DbgMsgType *dbgMsgs;
    uint32_t i;
    char compName[BCM_COMP_STR_MAX_LEN];

    if (NULL == msg) {
        goto done;
    }

    switch (notificationId) {
    case RPC_CMDIDVAL_DEBUG:
        retVal = BCM_ERR_OK;
        dbgMsgs = (BCM_DbgMsgType*)msg;
        for (i = 0UL; i < (size/sizeof(BCM_DbgMsgType)); i++) {
            dbg = &dbgMsgs[i];
            BCM_ConvertCompToStr(dbg->comp,compName);
            /* String NULL Termination */
            compName[BCM_COMP_STR_MAX_LEN - 1U]= '\0';
            HOST_Log("[%u.%03u] [%s] [dev:0x%03x] [%s] [inst:0x%02x] [id:0x%04x] [line:%05u] [state:0x%02x] [error:0x%02x] [custom:0x%08x,0x%08x,0x%08x,0x%08x]\n",
                dbg->timeMS/1000, (dbg->timeMS %1000), HOST_TargetBootStates[dbg->bootMode], dbg->devInfo, compName, dbg->instance, dbg->api,
                dbg->line, dbg->state, dbg->error, dbg->custom[0UL], dbg->custom[1UL], dbg->custom[2UL], dbg->custom[3UL]);
        }
    break;
    case RPC_CMDIDVAL_IMAGE_FETCH_V1:
        if (sizeof(RPC_ImgReqV1Type) == size) {
            RPC_ImgReqV1Type *tmp = (RPC_ImgReqV1Type*)msg;
            hdr.isTbl = tmp->isImgHdr;
            hdr.pid = tmp->pid;
            hdr.imgID = uswap16(tmp->imgID);
            hdr.imgMaxSize = uswap32(tmp->imgMaxSize);
            hdr.offset = 0UL;
            hdr.targetStrmHdl = 0UL;
            retVal = BCM_ERR_OK;
        }
        break;
    case RPC_CMDIDVAL_IMAGE_PART_FETCH_V1:
        if (sizeof(RPC_ImgPartReqV1Type) == size) {
            RPC_ImgPartReqV1Type *tmp = (RPC_ImgPartReqV1Type*)msg;
            hdr.isTbl = tmp->isImgHdr;
            hdr.pid = tmp->pid;
            hdr.imgID = uswap16(tmp->imgID);
            hdr.imgMaxSize = uswap32(tmp->imgMaxSize);
            hdr.offset = uswap32(tmp->offset);
            hdr.targetStrmHdl = 0UL;
            retVal = BCM_ERR_OK;
        }
        break;
    case RPC_CMDIDVAL_IMAGE_FETCH_V2:
    case RPC_CMDIDVAL_IMAGE_PART_FETCH_V2:
        if (sizeof(RPC_ImgReqV2Type) == size) {
            RPC_ImgReqV2Type *tmp = (RPC_ImgReqV2Type*)msg;
            hdr.isTbl = tmp->isTbl;
            hdr.pid = tmp->pid;
            hdr.imgID = uswap16(tmp->imgID);
            hdr.imgMaxSize = uswap32(tmp->imgMaxSize);
            hdr.offset = uswap32(tmp->offset);
            hdr.targetStrmHdl = uswap32(tmp->targetStrmHdl);
            retVal = BCM_ERR_OK;
        }
        break;
    default:
        retVal = BCM_ERR_INVAL_PARAMS;
        break;
    }

    if ((BCM_ERR_OK == retVal) && (RPC_CMDIDVAL_DEBUG != notificationId) &&
        ((CurrentImgReq.isTbl != hdr.isTbl)
        || (CurrentImgReq.pid != hdr.pid)
        || (CurrentImgReq.imgID != hdr.imgID)
        || (CurrentImgReq.imgMaxSize != hdr.imgMaxSize)
        || (CurrentImgReq.offset != hdr.offset))) {
        memcpy(&CurrentImgReq, &hdr, sizeof(RPC_ImgReqV2Type));
        retVal = service_image_fetch_request(notificationId, &hdr);
        memset(&CurrentImgReq, 0U, sizeof(RPC_ImgReqV2Type));
    }

done:
    if (BCM_ERR_OK != retVal) {
        HOST_Log("%s failed. SPI-Id:%u comp:0x%x notificationId:0x%x msg:%p size=%d err=%d\n",
                __func__, currentSlave, comp, notificationId, msg, size, retVal);
    }

    return retVal;
}
