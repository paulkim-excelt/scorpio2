/*****************************************************************************
 Copyright 2019-2021 Broadcom Limited.  All rights reserved.

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
#include <stddef.h>
#include <bcm_utils.h>
#include <bcm_err.h>
#include <rpc_hosthelper.h>
#include <cpu_utils.h>
#include <rpc_ipc_common.h>
#include <sys/time.h>
#include <module_msg.h>
#include <system_imgl.h>

static uint32_t rawLoadSize = 0UL;
static TAR_Parsed_ImgType parsedTarImages;
uint8_t HOST_TarBase[HOST_TAR_BASE_SIZE];
#define COMPARE_IMG_HDRS(aImgHdr, i)                                 \
    ((aImgHdr->pid == parsedTarImages.pwImgHdrs[i].pid) &&           \
     (aImgHdr->imgID == parsedTarImages.pwImgHdrs[i].imgID) &&       \
     (aImgHdr->isTbl == parsedTarImages.pwImgHdrs[i].isTbl))


int32_t RPC_LoadRawImg(PTBL_IdType aPid, uint16_t aImgID, uint8_t *const aAddr,
                       uint32_t aOffset, uint32_t aBufSize, const uint32_t aClientMask,
                       const MSGQ_MsgHdrType** const aHdr)
{
    uint32_t i;
    uint32_t size = 0UL;
    uint32_t offset;
    int32_t retVal = BCM_ERR_OK;

    for (i = 0UL; i < parsedTarImages.numImages; i++) {
        if ((aPid == parsedTarImages.pwImgHdrs[i].pid) &&
            (aImgID == parsedTarImages.pwImgHdrs[i].imgID) &&
            (0U == parsedTarImages.pwImgHdrs[i].isTbl)) {
            break;
        }
    }
    if (parsedTarImages.numImages == i) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        size = parsedTarImages.pwImgHdrs[i].imgMaxSize - aOffset;
        offset = parsedTarImages.imgOffsets[i] + aOffset;
        if (size > aBufSize) {
            size = aBufSize;
        }
        rawLoadSize = size;
        memcpy(aAddr, ((HOST_TarBase + 20UL) + offset), size);
    }
    return retVal;
}

int32_t RPC_LoadGetStatus(const MSGQ_MsgHdrType* const aHdr, uint32_t *const aSize)
{
    *aSize = rawLoadSize;
    return BCM_ERR_OK;
}

int32_t RPC_LoadCancel(const MSGQ_MsgHdrType* const aHdr)
{
    return BCM_ERR_OK;
}

const ITBL_Type *RPC_GetImgTbl(PTBL_IdType aPid)
{
    uint32_t i;
    ITBL_Type *itbl;

    for (i = 0UL; i < parsedTarImages.numImages; i++) {
        if ((aPid == parsedTarImages.pwImgHdrs[i].pid) &&
            (1U == parsedTarImages.pwImgHdrs[i].isTbl)) {
            break;
        }
    }

    if (parsedTarImages.numImages == i) {
        itbl = NULL;
    } else {
        itbl = (ITBL_Type*)((HOST_TarBase + 20UL) + parsedTarImages.imgOffsets[i]);
    }
    return itbl;
}

uint32_t RPC_GetImgSize(PTBL_IdType aPid, uint16_t aImgID, uint32_t aOffset)
{
    uint32_t tarOffset = 0UL;
    uint32_t size = 0UL;
    int32_t retVal;

    retVal = RPC_HOSTImglGetImg(&tarOffset, &size, aPid, aImgID);
    if (BCM_ERR_OK == retVal) {
        if (size < aOffset) {
            size = 0UL;
        } else {
            size -= aOffset;
        }
    } else {
        size = 0UL;
    }

    return size;
}

int32_t MCU_GetInfo(MCU_InfoType *aInfo)
{
    return BCM_ERR_NOSUPPORT;
}

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

static uint8_t tar_is_img_tbl(const uint8_t *const hdr)
{
    uint8_t isTbl = TRUE;

    if (hdr[TAR_HEADER_NAME_OFFSET + 32UL] == '0') {
        isTbl = FALSE;
    }
    return isTbl;
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

static int32_t RPC_ReadImgFromFile(char *name, uint8_t *aBuff, uint32_t *len)
{
    FILE *fp;
    uint32_t readLen;
    int32_t retVal;

    retVal = BCM_ERR_OK;
    fp = fopen(name, "r");
    if (!fp) {
        (void)MODULE_HostHelperLog("could not open File %s\n", name);
        retVal = BCM_ERR_INVAL_PARAMS;
        goto done;
    }
    if (fseek(fp, 0, SEEK_END) < 0) {
        (void)MODULE_HostHelperLog("error seeking to end of %s\n", name);
        fclose(fp);
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    }

    *len = ftell(fp);
    if((*len < 0 ) || (HOST_TAR_BASE_SIZE < *len)) {
        (void)MODULE_HostHelperLog("error in getting the current position\n");
        fclose(fp);
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    }
    if (fseek(fp, 0, SEEK_SET) < 0) {
        (void)MODULE_HostHelperLog("error seeking to beginning of %s\n", name);
        fclose(fp);
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    }

    readLen = fread(aBuff, 1, *len, fp);
    fclose(fp);
    if (readLen != *len) {
        (void)MODULE_HostHelperLog("error reading %s\n", name);
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    }

done:
    return retVal;
}

int32_t RPC_ImglSet(const uint8_t *tar, uint32_t size)
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
//        memcpy(HOST_TarBase, tar, size);
        (void)MODULE_HostHelperLog("PID  ImgID   maxSz  ImgHdr\n");
        while ((offset + TAR_HEADER_SIZE < size) && (i < BL_CNTRL_MAX_IMG_COUNT)) {
            uint16_t pid = 0UL;
            uint32_t imageSize = 0UL;
            uint8_t  isTbl = FALSE;

            if (FALSE == tar_check_header(&tar[offset])) {
                break;
            }

            pid = tar_get_pid(&tar[offset]);
            isTbl = tar_is_img_tbl(&tar[offset]);
            imageSize = tar_get_file_size(&tar[offset]);
            totalSize = (TAR_HEADER_SIZE + imageSize + (TAR_HEADER_SIZE - 1UL)) & (~(TAR_HEADER_SIZE - 1UL));

            parsedTarImages.imgOffsets[i] = offset + TAR_HEADER_SIZE;

            parsedTarImages.pwImgHdrs[i].imgMaxSize = imageSize;
            parsedTarImages.pwImgHdrs[i].pid = pid;
            parsedTarImages.pwImgHdrs[i].isTbl = isTbl;

            if (FALSE == isTbl) {
                parsedTarImages.pwImgHdrs[i].imgID = tar_get_img_id(&tar[offset]);
            } else {
                parsedTarImages.pwImgHdrs[i].imgID = 0UL;
                if (1UL == pid) {
                    /* Bootloader partition */
                    memcpy(&parsedTarImages.blImageTbl, &tar[offset + TAR_HEADER_SIZE], sizeof(ITBL_BLType));
                }
            }

            RPC_ImgReqV2Type *hdr = &parsedTarImages.pwImgHdrs[i];
            (void)MODULE_HostHelperLog("%3d 0x%04x 0x%05x %5d\n",
                     hdr->pid, hdr->imgID, hdr->imgMaxSize, hdr->isTbl);
            offset += totalSize;
            i++;
        }

        parsedTarImages.numImages = i;
        parsedTarImages.isInitialized = 1UL;
    }
    return retVal;
}

int32_t RPC_HostImglSet(char* aFileName)
{
    int32_t retVal = BCM_ERR_OK;
    uint32_t  imgSize;

    retVal = RPC_ReadImgFromFile(aFileName, HOST_TarBase, &imgSize);
    if((BCM_ERR_OK == retVal) && (0UL != imgSize)){
        RPC_ImglSet(HOST_TarBase + 20UL, imgSize - 20UL);
    }

    return retVal;
}

int32_t RPC_HostImglGetParsedImgHdrs(const uint8_t *aBuff)
{
    uint32_t i;
    int32_t retVal = BCM_ERR_OK;

    if (NULL == aBuff) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (0UL == parsedTarImages.isInitialized) {
        retVal = BCM_ERR_INVAL_STATE;
    } else {
        IMGL_UpdateAutoSyncMsgType *info = (IMGL_UpdateAutoSyncMsgType*)aBuff;
        uint32_t count = 0UL;
        for (i = 0UL; i < parsedTarImages.numImages; i++) {
            if (1U == parsedTarImages.pwImgHdrs[i].pid) {
                /* Check of the image entry is present */
                if ((parsedTarImages.pwImgHdrs[i].isTbl == FALSE)
                    && (parsedTarImages.pwImgHdrs[i].imgID !=
                        CPU_LEToNative16(parsedTarImages.blImageTbl.entry.imgType))) {
                    continue;
                }
            }
            if(((TRUE == parsedTarImages.pwImgHdrs[i].isTbl)
                || ((3U != parsedTarImages.pwImgHdrs[i].pid) && (5U != parsedTarImages.pwImgHdrs[i].pid))
                || (0xFFU == parsedTarImages.pwImgHdrs[i].pid))) {
                continue; /*No update of Image Table or Patition Table during OTA */
            }
            info->imgHdr[count].isImgHdr = parsedTarImages.pwImgHdrs[i].isTbl;
            info->imgHdr[count].pid = parsedTarImages.pwImgHdrs[i].pid;
            info->imgHdr[count].imgID = CPU_NativeToLE16(parsedTarImages.pwImgHdrs[i].imgID);
            info->imgHdr[count].imgMaxSize = CPU_NativeToLE32(parsedTarImages.pwImgHdrs[i].imgMaxSize);
            count++;
        }
        info->numImgs = CPU_NativeToLE32(count);
        (void)MODULE_HostHelperLog("RPC_HostImglGetParsedImgHdrs err=%d\n",retVal);
    }
    return retVal;
}

int32_t RPC_HOSTImglGetPtbl(uint32_t* aOffset, uint32_t* aSize)
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
            goto exit;
        } else {
            *aOffset = parsedTarImages.imgOffsets[i];
            *aSize = parsedTarImages.pwImgHdrs[i].imgMaxSize;
        }
    }

exit:
    if (BCM_ERR_OK != retval) {
        (void)MODULE_HostHelperLog("%s:%d status:%d\n", __func__, __LINE__, retval);
    }
    return retval;
}

int32_t RPC_HOSTImglGetItbl(uint32_t* aOffset, uint32_t* aSize, uint32_t aPid)
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
            (void)MODULE_HostHelperLog("%s:%d status:%d %d %d %d\n", __func__, __LINE__,
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
        (void)MODULE_HostHelperLog("%s:%d status:%d\n", __func__, __LINE__, retval);
    }
    return retval;
}

int32_t RPC_HOSTImglGetImg(uint32_t* aOffset, uint32_t* aSize, uint32_t aPid, uint32_t aImgID)
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
            (void)MODULE_HostHelperLog("%s:%d pid:%d imgID:%d maxSz:%d isTbl:%d\n", __func__, __LINE__,
                fetchImageHdr->pid, fetchImageHdr->imgID, fetchImageHdr->imgMaxSize,
                fetchImageHdr->isTbl);
        } else {
            *aOffset = parsedTarImages.imgOffsets[i];
            *aSize = parsedTarImages.pwImgHdrs[i].imgMaxSize;
        }
    }

    if (BCM_ERR_OK != retval) {
        (void)MODULE_HostHelperLog("%s:%d status:%d\n", __func__, __LINE__, retval);
    }
    return retval;
}

uint64_t BCM_GetTimeNs()
{
    uint64_t timeNs;
    struct timeval current_time;
    gettimeofday(&current_time, NULL);
    timeNs = (uint64_t)(((uint64_t)current_time.tv_sec * 1000000000ULL) +
                            ((uint64_t)current_time.tv_usec * 1000ULL));
    return timeNs;
}
