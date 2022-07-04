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
    @defgroup grp_imgl_rpc_impl RPC Imgl Implementation
    @ingroup grp_imgl

    @addtogroup grp_imgl_rpc_impl
    @{

    @file imgl_rpc.c
    @brief Implementation of Image Loader for RPC
    @version 0.1 Initial version
*/

#include <imgl.h>

/**
    @name Design IDs
    @{
    @brief Design IDs
*/
#define BRCM_SWDSGN_RPC_LOAD_RAW_IMG_PROC           (0xA601U)    /**< @brief #RPC_LoadRawImg        */
#define BRCM_SWDSGN_RPC_LOAD_GET_STATUS_PROC        (0xA602U)    /**< @brief #RPC_LoadGetStatus     */
#define BRCM_SWDSGN_RPC_LOAD_CANCEL_PROC            (0xA603U)    /**< @brief #RPC_LoadCancel        */
#define BRCM_SWDSGN_RPC_GET_IMG_TBL_PROC            (0xA604U)    /**< @brief #RPC_GetImgTbl         */
#define BRCM_SWDSGN_RPC_GET_IMG_SIZE_PROC           (0xA605U)    /**< @brief #RPC_GetImgSize        */
/** @} */

/**
    @brief Implementation of Load raw image request

    @trace #BRCM_SWARCH_RPC_LOAD_RAW_IMG_PROC
    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL

    @code{.c}
    retVal = IMGL_LoadRawImg(aPid, aImgID, aAddr, aOffset, aBufSize, aClientMask, &status)
    if retVal  is BCM_ERR_OK
        *aHdr = status.hdr;
    @endcode
*/
int32_t RPC_LoadRawImg(PTBL_IdType aPid, uint16_t aImgID, uint8_t *const aAddr,
                            uint32_t aOffset, uint32_t aBufSize, const uint32_t aClientMask,
                            const MSGQ_MsgHdrType** const aHdr)
{
    int32_t retVal;
    IMGL_LoadStatusType status;
    status.hdr = NULL;

    retVal = IMGL_LoadRawImg(aPid, aImgID, aAddr, aOffset, aBufSize, aClientMask, &status);
    if(BCM_ERR_OK == retVal) {
        *aHdr = status.hdr;
    }

    return retVal;
}

/**
    @brief Implementation of Get Load raw image request status

    @trace #BRCM_SWARCH_RPC_LOAD_GET_STATUS_PROC
    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL

    @code{.c}
    status.hdr = aHdr;
    retVal = IMGL_GetStatus(&status)
    if retVal is BCM_ERR_OK
        *aSize = status.size
    return retVal;
    @endcode
*/
int32_t RPC_LoadGetStatus(const MSGQ_MsgHdrType* const aHdr, uint32_t *const aSize)
{
    int32_t retVal;
    IMGL_LoadStatusType status;
    status.size = 0UL;

    status.hdr = aHdr;
    retVal = IMGL_GetStatus(&status);
    if(BCM_ERR_OK == retVal) {
        *aSize = status.size;
    }

    return retVal;
}

/**
    @brief Implementation of Get Load raw image request status

    @trace #BRCM_SWARCH_RPC_LOAD_CANCEL_PROC
    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL

    @code{.c}
    status.hdr = aHdr;
    return IMGL_LoadCancel(&status);
    @endcode
*/
int32_t RPC_LoadCancel(const MSGQ_MsgHdrType* const aHdr)
{
    IMGL_LoadStatusType status;
    status.hdr = aHdr;
    return IMGL_LoadCancel(&status);
}

/**
    @brief Implementation of Get Load raw image request status

    @trace #BRCM_SWARCH_RPC_GET_IMG_TBL_PROC
    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL

    @code{.c}
    return IMGL_GetImgTbl(aPid);
    @endcode
*/
const ITBL_Type *RPC_GetImgTbl(PTBL_IdType aPid)
{
    return IMGL_GetImgTbl(aPid);
}
/**
    @brief Implementation of Get Load raw image request status

    @trace #BRCM_SWARCH_RPC_GET_IMG_SIZE_PROC
    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL

    @code{.c}
    return IMGL_GetImgSize(aPid, aImgID, aOffset);
    @endcode
*/
uint32_t RPC_GetImgSize(PTBL_IdType aPid, uint16_t aImgID, uint32_t aOffset)
{
    return IMGL_GetImgSize(aPid, aImgID, aOffset);
}

/** @} */
