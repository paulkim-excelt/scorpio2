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

 2. TO THE COMP_MAXIMUM EXTENT PERMITTED BY LAW, THE SOFTWARE IS PROVIDED "AS IS"
    AND WITH ALL FAULTS AND BROADCOM MAKES NO PROMISES, REPRESENTATIONS OR
    WARRANTIES, EITHER EXPRESS, IMPLIED, STATUTORY, OR OTHERWISE, WITH RESPECT
    TO THE SOFTWARE.  BROADCOM SPECIFICALLY DISCLAIMS ANY AND ALL IMPLIED
    WARRANTIES OF TITLE, MERCHANTABILITY, NONINFRINGEMENT, FITNESS FOR A
    PARTICULAR PURPOSE, LACK OF VIRUSES, ACCURACY OR COMPLETENESS,
    QUIET ENJOYMENT, QUIET POSSESSION OR CORRESPONDENCE TO DESCRIPTION.
    YOU ASSUME THE ENTIRE RISK ARISING OUT OF USE OR PERFORMANCE OF THE
    SOFTWARE.

 3. TO THE COMP_MAXIMUM EXTENT PERMITTED BY LAW, IN NO EVENT SHALL BROADCOM OR ITS
    LICENSORS BE LIABLE FOR (i) CONSEQUENTIAL, INCIDENTAL, SPECIAL, INDIRECT,
    OR EXEMPLARY DAMAGES WHATSOEVER ARISING OUT OF OR IN ANY WAY RELATING TO
    YOUR USE OF OR INABILITY TO USE THE SOFTWARE EVEN IF BROADCOM HAS BEEN
    ADVISED OF THE POSSIBILITY OF SUCH DAMAGES; OR (ii) ANY AMOUNT IN EXCESS
    OF THE AMOUNT ACTUALLY PAID FOR THE SOFTWARE ITSELF OR U.S. $1, WHICHEVER
    IS GREATER. THESE LIMITATIONS SHALL APPLY NOTWITHSTANDING ANY FAILURE OF
    ESSENTIAL PURPOSE OF ANY LIMITED REMEDY.
******************************************************************************/
#ifndef RPC_HOSTHELPER_H
#define RPC_HOSTHELPER_H

#include <stdint.h>
#include <pt_utils.h>
#include <rpc_ipc_common.h>

#define BL_CNTRL_MAX_IMG_COUNT  (32UL)
#define BL_IMG_SIGNATURE_SIZE   (256UL)
#define MSG_BUF_SIZE            (512UL - 128UL)

#define TAR_HEADER_NAME_OFFSET  (0UL)
#define TAR_HEADER_NAME_LENGTH  (100UL)
#define TAR_HEADER_SIZE_OFFSET  (124UL)
#define TAR_HEADER_SIZE_LENGTH  (12UL)
#define TAR_HEADER_MAGIC_OFFSET (257UL)
#define TAR_HEADER_MAGIC_LENGTH (6UL)

#define TAR_HEADER_SIZE         (512UL)
#define HOST_TAR_BASE_SIZE      (2UL*1024UL*1024UL)

#define RPC_HOST_CMDID_GET_ASYNC_MSG   (0xFF)    /* Async Message Request Command */

typedef struct sTAR_Parsed_ImgType {
    uint32_t isInitialized;
    uint32_t numImages;
    uint32_t imgOffsets[BL_CNTRL_MAX_IMG_COUNT];
    RPC_ImgReqV2Type pwImgHdrs[BL_CNTRL_MAX_IMG_COUNT];
    ITBL_BLType blImageTbl;
} TAR_Parsed_ImgType;

extern uint8_t HOST_TarBase[HOST_TAR_BASE_SIZE];
extern int32_t RPC_HostImglSet(char* aFileName);
extern int32_t RPC_HostImglGetParsedImgHdrs(const uint8_t *aBuff);
extern int32_t RPC_HOSTImglGetImg(uint32_t* aOffset, uint32_t* aSize, uint32_t aPid, uint32_t aImgID);
extern int32_t RPC_HOSTImglGetItbl(uint32_t* aOffset, uint32_t* aSize, uint32_t aPid);
extern int32_t RPC_HOSTImglGetPtbl(uint32_t* aOffset, uint32_t* aSize);
#endif /* RPC_HOSTHELPER_H */
/** @} */
