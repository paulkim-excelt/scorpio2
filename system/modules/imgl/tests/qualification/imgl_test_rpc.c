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

#include <stddef.h>
#include <string.h>
#include <imgl.h>
#include <bcm_err.h>
#include <bcm_utils.h>
#include <pt_utils.h>
#include <bcm_test.h>

#if defined(ENABLE_IMGL_ROM_TEST)
#include "test_bl_signed.h"
#include <imgl_osil.h>
#include <imgl_mmap.h>
#include <imgl_interface.h>
MSGQ_MsgHdrType IMGL_TEST_RPC_hdr = 0ULL;

extern uint32_t IMGLTEST_WaitForFlag;

extern int32_t RPC_LoadRawImg(PTBL_IdType aPid, uint16_t aImgID, uint8_t *const aAddr,
                            uint32_t aOffset, uint32_t aBufSize, const uint32_t aClientMask,
                            const MSGQ_MsgHdrType** const aHdr);
extern int32_t RPC_LoadGetStatus(const MSGQ_MsgHdrType* const aHdr, uint32_t *const aSize);
extern int32_t RPC_LoadCancel(const MSGQ_MsgHdrType* const aHdr);
extern const ITBL_Type *RPC_GetImgTbl(PTBL_IdType aPid);
extern uint32_t RPC_GetImgSize(PTBL_IdType aPid, uint16_t aImgID, uint32_t aOffset);

extern uint32_t IMGLTEST_SlaveReqState;
extern uint8_t IMGLTEST_TempMem[];

extern uint8_t *IMGLTEST_SlaveReqMem;
extern uint32_t IMGLTEST_SlaveReqMemSize;
extern uint32_t IMGLTEST_SlaveReqEvent;
extern uint32_t IMGLTEST_SlaveReqBL;

const MSGQ_MsgHdrType *IMGLTEST_Hdr = NULL;
const MSGQ_MsgHdrType *IMGLTEST_HdrArray[MSGQ_SIZE+1];
IMGL_LoadStatusType IMGLTEST_Status;

extern uint32_t IMGLTEST_BLReq;

int32_t IMGLTEST_SlaveReq()
{
    uint32_t i;
    int32_t exitLoop = 0UL;
    int32_t ret = BCM_ERR_OK;
    uint32_t size;

    while ((BCM_ERR_OK == ret) && (0UL == exitLoop)) {
        switch (IMGLTEST_SlaveReqState) {
            case 0UL:
                /* Test with wrong offset */
                ret = RPC_LoadRawImg(PTBL_ID_BL, 0U, IMGLTEST_SlaveReqMem, 0xFFFFFFFFUL, IMGLTEST_SlaveReqMemSize, IMGLTEST_SlaveReqEvent, &IMGLTEST_Hdr);
                break;
            case 1UL:
                /* get status */
                ret = RPC_LoadGetStatus(IMGLTEST_Hdr, &size);
                if (BCM_ERR_NOT_FOUND == ret) {
                    ret = BCM_ERR_OK;
                }
                break;
            case 2UL:
                /* send request */
                ret = RPC_LoadRawImg(PTBL_ID_BL, 0U, IMGLTEST_SlaveReqMem, 0UL, IMGLTEST_SlaveReqMemSize, IMGLTEST_SlaveReqEvent, &IMGLTEST_Hdr);
                break;
            case 3UL:
                /* cancel request */
                ret = RPC_LoadCancel(IMGLTEST_Hdr);
                if (BCM_ERR_CANCELLED == ret) {
                    ret = BCM_ERR_OK;
                } else {
                    ret = BCM_ERR_UNKNOWN;
                }
                break;
            case 4UL:
                /* send request for wrong PID*/
                ret = RPC_LoadRawImg(PTBL_ID_FW, 0U, IMGLTEST_SlaveReqMem, 0UL, IMGLTEST_SlaveReqMemSize, IMGLTEST_SlaveReqEvent, &IMGLTEST_Hdr);
                break;
            case 5UL:
                /* get status */
                ret = RPC_LoadGetStatus(IMGLTEST_Hdr, &size);
                if (BCM_ERR_BUSY == ret) {

                } else if (BCM_ERR_INVAL_PARAMS == ret) {
                    ret = BCM_ERR_OK;
                } else {
                    ret = BCM_ERR_UNKNOWN;
                }

                if (BCM_ERR_OK == ret) {
                    ret = RPC_LoadCancel(IMGLTEST_Hdr);
                    if (BCM_ERR_UNKNOWN == ret) {
                        ret = BCM_ERR_OK;
                    } else {
                        ret = BCM_ERR_UNKNOWN;
                    }
                }

                break;
            case 6UL:
                if (NULL == RPC_GetImgTbl(PTBL_ID_TYPE_MASK)) {
                    ret = BCM_ERR_OK;
                } else {
                    ret = BCM_ERR_UNKNOWN;
                }
                break;
            case 7UL:
                if (NULL != RPC_GetImgTbl(PTBL_ID_BL)) {
                    ret = BCM_ERR_OK;
                } else {
                    ret = BCM_ERR_UNKNOWN;
                }
                break;
            case 8UL:
                if (0UL != RPC_GetImgSize(PTBL_ID_BL, 0U, 0UL)) {
                    ret = BCM_ERR_OK;
                } else {
                    ret = BCM_ERR_UNKNOWN;
                }
                break;
            case 9UL:
                if (0UL == RPC_GetImgSize(PTBL_ID_FW, 0U, 0UL)) {
                    ret = BCM_ERR_OK;
                } else {
                    ret = BCM_ERR_UNKNOWN;
                }
                break;
            case 10UL:
                /* cancel request */
                ret = RPC_LoadCancel(NULL);
                if (BCM_ERR_UNKNOWN == ret) {
                    ret = BCM_ERR_OK;
                } else {
                    ret = BCM_ERR_UNKNOWN;
                }
                break;
            case 11UL:
                /* Test with less size */
                ret = RPC_LoadRawImg(PTBL_ID_BL, 0U, IMGLTEST_SlaveReqMem, 0UL, 0x200, IMGLTEST_SlaveReqEvent, &IMGLTEST_Hdr);
                break;
            case 12UL:
                /* get status */
                ret = RPC_LoadGetStatus(IMGLTEST_Hdr, &size);
                break;
            case 13UL:
                /* Test with NULL IMGLTEST_Hdr */
                IMGLTEST_SlaveReqBL = 2UL;
                ret = RPC_LoadRawImg(PTBL_ID_BL, 0U, IMGLTEST_SlaveReqMem, 0UL, IMGLTEST_SlaveReqMemSize, IMGLTEST_SlaveReqEvent, &IMGLTEST_Hdr);
                break;
            case 14UL:
                /* get status */
                ret = RPC_LoadGetStatus(IMGLTEST_Hdr, &size);
                if (BCM_ERR_NOT_FOUND == ret) {
                    IMGLTEST_SlaveReqBL = 0UL;
                    ret = BCM_ERR_OK;
                }
                break;
            case 15UL:
                /* Test with invalid IMGLTEST_Hdr */
                IMGLTEST_SlaveReqBL = 1UL;
                ret = RPC_LoadRawImg(PTBL_ID_BL, 0U, IMGLTEST_SlaveReqMem, 0UL, IMGLTEST_SlaveReqMemSize, IMGLTEST_SlaveReqEvent, &IMGLTEST_Hdr);
                break;
            case 16UL:
                /* get status */
                ret = RPC_LoadGetStatus(IMGLTEST_Hdr, &size);
                if (BCM_ERR_NOT_FOUND == ret) {
                    IMGLTEST_SlaveReqBL = 0UL;
                    ret = BCM_ERR_OK;
                }
                break;
            case 17UL:
                {
                    IMGL_LoadImgMsgType msg;
                    msg.cmd = IMGL_CMD_LOAD_NORMAL;
                    msg.pid = PTBL_ID_BL;
                    msg.imgID = 0U;
                    msg.loadAddr = IMGLTEST_SlaveReqMem;
                    msg.offset = 0UL;
                    msg.bufferSize = IMGLTEST_SlaveReqMemSize;
                    msg.result = BCM_ERR_UNINIT;
                    ret = MSGQ_SendMsg(IMGL_GetMsgQ(), (void *)&msg, IMGLTEST_SlaveReqEvent, &IMGLTEST_Status.hdr);
                }
                break;
            case 18UL:
                /* get status */
                ret = IMGL_GetStatus(&IMGLTEST_Status);
                if (BCM_ERR_INVAL_PARAMS == ret) {
                    ret = BCM_ERR_OK;
                }
                break;
            case 19UL:
                for (i = 0UL; (i <= MSGQ_SIZE) && (BCM_ERR_OK == ret); i++) {
                    ret = RPC_LoadRawImg(PTBL_ID_BL, 0U, IMGLTEST_SlaveReqMem, 0UL, IMGLTEST_SlaveReqMemSize, IMGLTEST_SlaveReqEvent, &IMGLTEST_HdrArray[i]);
                }

                if ((MSGQ_SIZE < i) && (BCM_ERR_NOMEM == ret)) {
                    ret = BCM_ERR_OK;
                }

                break;
            case 20UL:
                /* get status */
                for (i = 0UL; (i < MSGQ_SIZE) && (BCM_ERR_OK == ret); i++) {
                    if (NULL != IMGLTEST_HdrArray[i]) {
                        ret = RPC_LoadGetStatus(IMGLTEST_HdrArray[i], &size);
                        if (BCM_ERR_OK == ret) {
                            IMGLTEST_HdrArray[i] = NULL;
                        }
                    }
                }
                break;
            case 21UL:
                ret = IMGL_MemoryMapModule.readImg(0UL, PTBL_ID_BL, 0U, 0UL, 0UL, 0UL, 0UL, IMGLTEST_SlaveReqEvent, &IMGLTEST_Hdr);
                if (BCM_ERR_INVAL_PARAMS == ret) {
                    ret = BCM_ERR_OK;
                }
                ret = IMGL_MemoryMapModule.readImg(IMGL_CHANNEL_IDX_MAX, PTBL_ID_BL, 0U, 0UL, 0UL, 0UL, IMGLTEST_SlaveReqMemSize, IMGLTEST_SlaveReqEvent, &IMGLTEST_Hdr);
                if (BCM_ERR_NODEV == ret) {
                    ret = BCM_ERR_OK;
                }
                ret = IMGL_MemoryMapModule.readImg(IMGL_CHANNEL_IDX1, PTBL_ID_BL, 0U, 0UL, 0UL, 0UL, IMGLTEST_SlaveReqMemSize, IMGLTEST_SlaveReqEvent, &IMGLTEST_Hdr);
                if (BCM_ERR_NODEV == ret) {
                    ret = BCM_ERR_OK;
                }
                ret = IMGL_MemoryMapModule.readImg(IMGL_CHANNEL_IDX0, PTBL_ID_BL, 0U, 0UL, 0UL, IMGL_MMAP_SIZE_0, IMGLTEST_SlaveReqMemSize, IMGLTEST_SlaveReqEvent, &IMGLTEST_Hdr);
                if (BCM_ERR_UNKNOWN == ret) {
                    ret = BCM_ERR_OK;
                }
                ret = IMGL_MemoryMapModule.getStatus(IMGLTEST_Hdr, &size);
                if (BCM_ERR_AUTH_FAILED == ret) {
                    ret = BCM_ERR_OK;
                }
                if (BCM_ERR_OK == ret) {
                    const MSGQ_Type* msgq = IMGL_GetMsgQ();
                    if (NULL == msgq->getMsg(MSGQ_SIZE)) {
                        ret = BCM_ERR_OK;
                    } else {
                        ret = BCM_ERR_UNKNOWN;
                    }
                }
                if (BCM_ERR_OK == ret) {
                    if (BCM_ERR_INVAL_PARAMS == IMGL_MemoryInfoGet(0UL, NULL, &size)) {
                        ret = BCM_ERR_OK;
                    } else {
                         ret = BCM_ERR_UNKNOWN;
                    }
                }
                if (BCM_ERR_OK == ret) {
                    uint8_t *temp;
                    if (BCM_ERR_INVAL_PARAMS == IMGL_MemoryInfoGet(0UL, &temp, NULL)) {
                        ret = BCM_ERR_OK;
                    } else {
                         ret = BCM_ERR_UNKNOWN;
                    }
                }
                break;
            default:
                exitLoop = 1UL;
                IMGLTEST_SlaveReqState = 0xFFFFFFFFUL;
                break;
        }
        if (BCM_ERR_OK == ret) {
            IMGLTEST_SlaveReqState++;
        }
    }
    return ret;
}
#endif
static int32_t IMGL_TEST_RPC_LoadImg(IMGL_ChannelIdxType aChannel,
                              PTBL_IdType aPID,
                              uint16_t aImgID,
                              uint32_t aImgAddr,
                              uint8_t* const aAddr,
                              uint32_t aOffset,
                              uint32_t aBufSize,
                              const uint32_t aClientMask,
                              const MSGQ_MsgHdrType** const aHdr)
{
    int32_t err = BCM_ERR_OK;

    if ((NULL == aAddr) || (0UL == aBufSize) || (NULL == aHdr)) {
        err = BCM_ERR_INVAL_PARAMS;
    } else {
#if defined(ENABLE_IMGL_ROM_TEST)
        if (PTBL_ID_BL == ((aPID & PTBL_ID_TYPE_MASK) >> PTBL_ID_TYPE_SHIFT)) {
            if (0UL == IMGLTEST_BLReq) {
                BCM_MemCpy(aAddr, test_bl_signed_bin, test_bl_signed_bin_len);
                err = BCM_ERR_OK;
                IMGL_TEST_RPC_hdr = 1ULL;
                *aHdr = &IMGL_TEST_RPC_hdr;
            } else {
                err = IMGLTEST_BLReq;
                IMGLTEST_BLReq = 0UL;
            }

        } else {
            err = BCM_ERR_NOSUPPORT;
        }
#else
        err =  BCM_TestLoadRawImg(aPID, aImgID, aAddr,
                           aOffset, aBufSize, aClientMask,
                           aHdr);
#endif
    }

    return err;
}

static int32_t IMGL_TEST_RPC_ReadPTBL(IMGL_ChannelIdxType aChannel,
                     uint32_t aDevAddr,
                     uint8_t *aDownloadAddress,
                     uint32_t aMaxSize,
                     const uint32_t aClientMask,
                     const MSGQ_MsgHdrType** const aHdr)
{
    int32_t err = BCM_ERR_OK;

    if ((NULL == aDownloadAddress) || (0UL == aMaxSize) || (NULL == aHdr)) {
        err = BCM_ERR_INVAL_PARAMS;
    } else {
#if defined(ENABLE_IMGL_ROM_TEST)
        err = BCM_ERR_NOSUPPORT;
#else
        err = BCM_TestLoadRawImg(0xFFU, 0U, aDownloadAddress,
                           0UL, aMaxSize, aClientMask,aHdr);
#endif
    }

    return err;
}

static int32_t IMGL_TEST_RPC_ReadITBL(IMGL_ChannelIdxType aChannel,
                      PTBL_IdType aPartID,
                      uint32_t aITBLAddress,
                      uint8_t *aDownloadAddress,
                      uint32_t aMaxSize,
                      const uint32_t aClientMask,
                      const MSGQ_MsgHdrType** const aHdr)
{
    int32_t err = BCM_ERR_OK;

    if ((NULL == aDownloadAddress) || (0UL == aMaxSize) || (NULL == aHdr)) {
        err = BCM_ERR_INVAL_PARAMS;
    } else {
#if defined(ENABLE_IMGL_ROM_TEST)
        err = BCM_ERR_NOSUPPORT;
#else
        err = BCM_TestLoadRawImg(aPartID, 0U, aDownloadAddress,
                           0UL, aMaxSize, aClientMask,aHdr);
#endif
    }

    return err;
}

static int32_t IMGL_TEST_RPC_GetLoaderStatus(const MSGQ_MsgHdrType *const aHdr,
                             uint32_t *const aImgSize)
{
#if defined(ENABLE_IMGL_ROM_TEST)
    if (aHdr == &IMGL_TEST_RPC_hdr) {
        if (1ULL == IMGL_TEST_RPC_hdr) {
            *aImgSize = test_bl_signed_bin_len;
            IMGL_TEST_RPC_hdr = 0ULL;
            return BCM_ERR_OK;
        } else {
            return BCM_ERR_BUSY;
        }
    } else {
        return BCM_ERR_INVAL_PARAMS;
    }
#else
    return BCM_TestGetLoadImgStatus(aHdr, aImgSize);
#endif
}

const IMGL_InterfaceType IMGL_TestRpcModule = {
    .mode = IMGL_LOAD_MODE_RPC,
    .getImgTbl = NULL,
    .readImg = IMGL_TEST_RPC_LoadImg,
    .getStatus = IMGL_TEST_RPC_GetLoaderStatus,
    .readPTBL = IMGL_TEST_RPC_ReadPTBL,
    .readITBL = IMGL_TEST_RPC_ReadITBL,
    .channel[0UL] = IMGL_CHANNEL_ID_RPC_IPC,
    .channel[1UL] = IMGL_CHANNEL_ID_INVALID,
};
