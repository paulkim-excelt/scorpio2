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

/**
    @defgroup grp_imgl_impl Implementation
    @ingroup grp_imgl

    @addtogroup grp_imgl_impl
    @{

    @file imgl.c
    @brief Image Loader Implementation
    @version 0.1 Initial version
*/

#include <imgl.h>
#include <stdlib.h>
#include <module.h>
#include <module_osil.h>
#include <bcm_utils.h>
#include "ee.h"

#if defined(ENABLE_PTM)
#include <ptm.h>
#endif

#if defined(ENABLE_IPC)
#include <rpc_loader.h>
#endif

/**
    @name Design IDs
    @{
    @brief Design IDs
*/
#define BRCM_SWDSGN_IMGL_MODES_GLOBAL              (0xA501U)    /**< @brief #IMGL_Modes             */
#define BRCM_SWDSGN_IMGL_LOAD_IMAGE_PROC           (0xA502U)    /**< @brief #IMGL_LoadImg           */
#define BRCM_SWDSGN_IMGL_GET_STATUS_PROC           (0xA503U)    /**< @brief #IMGL_GetStatus         */
#define BRCM_SWDSGN_IMGL_LOAD_IMG_TABLE_PROC       (0xA504U)    /**< @brief #IMGL_GetImgTbl         */
#define BRCM_SWDSGN_IMGL_LOAD_RAW_IMAGE_PROC       (0xA505U)    /**< @brief #IMGL_LoadRawImg        */
#define BRCM_SWDSGN_IMGL_GET_IMG_SIZE_PROC         (0xA506U)    /**< @brief #IMGL_GetImgSize        */
#define BRCM_SWDSGN_MODULE_LOAD_CFG_PROC           (0xA507U)    /**< @brief #MODULE_LoadCfg         */
/** @} */

/**
    @brief List of Enabled modes for loading Images

    @trace #BRCM_SWARCH_IMGL_GET_STATUS_PROC
    @trace #BRCM_SWARCH_IMGL_LOAD_IMG_PROC
    @trace #BRCM_SWARCH_IMGL_LOAD_MODE_TYPE
    @trace #BRCM_SWREQ_IMGL_ABSTRACTION
*/
const IMGL_InterfaceType * const IMGL_Modes[] = {
#ifdef IMGL_MODE_FUNC_TABLE_PRIO0
&IMGL_MODE_FUNC_TABLE_PRIO0,
#endif
#ifdef IMGL_MODE_FUNC_TABLE_PRIO1
&IMGL_MODE_FUNC_TABLE_PRIO1,
#endif
};

/** @} */

/**
    @addtogroup grp_imgl_ifc
    @{
*/

/**
    @trace #BRCM_SWARCH_IMGL_LOAD_IMG_PROC
    @trace #BRCM_SWREQ_IMGL_ABSTRACTION

    @code{.c}
    ret = BCM_ERR_NODEV
    if Arguments are NULL
        ret = ERR_INVAL_PARAMS
    else
        for each in IMGL_Modes:
            if each->loadImgTbl(aImgID, aAddr, aBufSize, aClientMask, &aStatus->hdr) == BCM_ERR_OK
                break
    return ret
    @endcode
*/
const ITBL_Type *IMGL_GetImgTbl(uint8_t aImgTblID)
{
    const ITBL_Type *tbl = NULL;
    uint32_t i;

    for (i = 0UL; i < sizeof(IMGL_Modes)/sizeof(IMGL_InterfaceType*); i++) {
       if ((NULL != IMGL_Modes[i]) && (NULL != IMGL_Modes[i]->getImgTbl)) {
            tbl = IMGL_Modes[i]->getImgTbl(aImgTblID);
            if (NULL != tbl) {
                break;
            }
        }
    }

    return tbl;
}

/**
    @trace #BRCM_SWARCH_IMGL_LOAD_IMG_PROC
    @trace #BRCM_SWREQ_IMGL_ABSTRACTION

    @code{.c}
    ret = BCM_ERR_NODEV
    if Arguments are NULL
        ret = ERR_INVAL_PARAMS
    else
        for each in IMGL_Modes:
            if each->loadImage(aImgID, aAddr, aBufSize, aClientMask, &aStatus->hdr) == BCM_ERR_OK
                aStatus->size = 0
                aStatus->mode = each->mode
                break
    return ret
    @endcode
*/
int32_t IMGL_LoadImg(uint16_t aImgID, uint8_t *const aAddr,
                           uint32_t aBufSize, const uint32_t aClientMask,
                           IMGL_LoadStatusType* const aStatus)
{
    int32_t ret = BCM_ERR_NODEV;
    uint32_t i;
    uint32_t aOffset = 0UL;

    if ((NULL == aAddr) || (NULL == aStatus)) {
        ret = BCM_ERR_INVAL_PARAMS;
    } else {
        for (i = 0UL; i < sizeof(IMGL_Modes)/sizeof(IMGL_InterfaceType*); i++) {
            if ((NULL != IMGL_Modes[i]) && (NULL != IMGL_Modes[i]->readImg)) {
                aStatus->hdr = NULL;
                ret = IMGL_Modes[i]->readImg(IMGL_CHANNEL_IDX0, PTBL_ID_SYSCFG, aImgID, 0UL, aAddr,
                                    aOffset, aBufSize, aClientMask, &aStatus->hdr);
                if (BCM_ERR_OK == ret) {
                    aStatus->size = 0;
                    aStatus->mode = IMGL_Modes[i]->mode;
                    break;
                }
            }
        }
    }

    return ret;
}


/**
    @trace #BRCM_SWARCH_IMGL_LOAD_RAW_IMG_PROC
    @trace #BRCM_SWREQ_IMGL_ABSTRACTION

    @code{.c}
    ret = BCM_ERR_NODEV
    if Arguments are NULL
        ret = ERR_INVAL_PARAMS
    else
        for each in IMGL_Modes:
            if each->loadImage(aImgID, aAddr, aBufSize, aClientMask, &aStatus->hdr) == BCM_ERR_OK
                aStatus->size = 0
                aStatus->mode = each->mode
                break
    return ret
    @endcode
*/
int32_t IMGL_LoadRawImg(PTBL_IdType aPid, uint16_t aImgID, uint8_t *const aAddr,
                        uint32_t aOffset, uint32_t aBufSize, const uint32_t aClientMask,
                        IMGL_LoadStatusType* const aStatus)
{
    int32_t ret = BCM_ERR_NODEV;
    uint32_t i;

    if ((NULL == aAddr) || (NULL == aStatus)) {
        ret = BCM_ERR_INVAL_PARAMS;
    } else {
        for (i = 0UL; i < sizeof(IMGL_Modes)/sizeof(IMGL_InterfaceType*); i++) {
            if ((NULL != IMGL_Modes[i]) && (NULL != IMGL_Modes[i]->readImg)) {
                ret = IMGL_Modes[i]->readImg(IMGL_CHANNEL_IDX0, PTBL_ID_SYSCFG, aImgID, 0UL, aAddr,
                                    aOffset, aBufSize, aClientMask, &aStatus->hdr);
                if (BCM_ERR_OK == ret) {
                    aStatus->size = 0;
                    aStatus->mode = IMGL_Modes[i]->mode;
                    break;
                }
            }
        }
    }

    return ret;
}

/**
    @trace #BRCM_SWARCH_IMGL_GET_STATUS_PROC
    @trace #BRCM_SWREQ_IMGL_ABSTRACTION

    @code{.c}
    if aStatus is not NULL and aStatus->hdr is not NULL
        for each in IMGL_Modes:
            if each->mode == aStatus->mode:
                ret = each->getStatus(aStatus->hdr, &aStatus->size);
                if ret !=  BCM_ERR_BUSY:
                    aStatus->hdr = NULL
    return ret
    @endcode
*/
extern int32_t IMGL_GetStatus(IMGL_LoadStatusType *const aStatus)
{
    int32_t ret = BCM_ERR_INVAL_PARAMS;
    int32_t i;

    if ((NULL != aStatus) && (NULL != aStatus->hdr)) {
        for (i = 0L; i < (int32_t)(sizeof(IMGL_Modes)/sizeof(IMGL_InterfaceType*)); i++) {
            if (NULL != IMGL_Modes[i]) {
                if (aStatus->mode == IMGL_Modes[i]->mode) {
                    ret = IMGL_Modes[i]->getStatus(aStatus->hdr, &aStatus->size);
                    if (BCM_ERR_BUSY != ret) {
                        aStatus->hdr = NULL;
                    }
                }
            }
        }
    }
    return ret;
}

/**
    @trace #BRCM_SWARCH_IMGL_GET_IMG_SIZE_PROC
    @trace #BRCM_SWREQ_IMGL_ABSTRACTION

    @code{.c}
    size = 0
    ITBL_Type *itbl = IMGL_GetImgTbl(aPid)
    if itbl is not NULL
        for i = 0 to itbl->hdr.numImgs
            if imgID is equal to imageTbl->entry[i].imgType
                if aOffset is less than or equal to imageTbl->entry[i].actualSize
                    size = imageTbl->entry[i].actualSize - aOffset;
                break;
    return size
    @endcode
*/
uint32_t IMGL_GetImgSize(PTBL_IdType aPid, uint16_t aImgID, uint32_t aOffset)
{
    uint32_t i;
    uint32_t size = 0UL;
    const ITBL_Type *itbl = IMGL_GetImgTbl(aPid);
    if (NULL != itbl) {
        for (i = 0UL; i < itbl->hdr.numImgs; i++) {
            if (aImgID == itbl->entry[i].imgType) {
                if (aOffset <= itbl->entry[i].actualSize) {
                    size = itbl->entry[i].actualSize - aOffset;
                }
                break;
            }
        }
    }
    return size;
}

/**
    @trace #BRCM_SWARCH_MODULE_LOAD_CFG_PROC
    @trace #BRCM_SWREQ_MODULE_IMGL

    @code{.unparsed}
    retVal = BCM_ERR_OK
    if (((0U != aModEntry->configImgID) && (0UL < aModEntry->configImgSize)) &&
        (FALSE == aModEntry->context->isImagesLoaded))
        if (BCM_STATE_SUB_STATE_RESET == aModEntry->context->imglState)
            BCM_MemSet(aModEntry->configImgData, 0U, aModEntry->configImgSize)
            retVal = IMGL_LoadImg()
            if (BCM_ERR_OK == retVal)
                retVal = BCM_ERR_BUSY
                aModEntry->context->imglState = BCM_STATE_SUB_STATE_STAGE0
             else
                aModEntry->context->imglState = BCM_STATE_SUB_STATE_RESET
                retVal = BCM_ERR_UNKNOWN
         else
            retVal  = IMGL_GetStatus(&imglStatus)
            if (BCM_ERR_BUSY == retVal)
                Check again on an event
            else
                aModEntry->context->configImgSize = aModEntry->context->imglStatus.size
                aModEntry->context->imglState = BCM_STATE_SUB_STATE_RESET
                aModEntry->context->isImagesLoaded = TRUE
                if (retVal != BCM_ERR_OK)
                    retVal = BCM_ERR_UNKNOWN
                    aModEntry->context->isImagesLoaded = FALSE
                    BCM_MemSet(aModEntry->configImgData, 0U, aModEntry->configImgSize)
    return retVal
    @endcode
*/
int32_t MODULE_LoadCfg(const MODULE_Type * const aModEntry)
{
    int32_t retVal = BCM_ERR_OK;
    IMGL_LoadStatusType status;

    if (((0U != aModEntry->configImgID) && (0UL < aModEntry->configImgSize)) &&
        (FALSE == aModEntry->context->isCfgLoaded)) {
        if (BCM_STATE_SUB_STATE_RESET == aModEntry->context->cfgLoadState) {
            BCM_MemSet(aModEntry->configImgData, 0U, aModEntry->configImgSize);
            retVal = IMGL_LoadImg(aModEntry->configImgID,
                                  aModEntry->configImgData,
                                  aModEntry->configImgSize,
                                  MODULE_Event,
                                  &status);
            if (BCM_ERR_OK == retVal) {
                retVal = BCM_ERR_BUSY;
                aModEntry->context->cfgLoadSize = status.size;
                aModEntry->context->handle = (uint32_t)status.hdr;
                aModEntry->context->custom[0UL] = status.mode;
                aModEntry->context->cfgLoadState = BCM_STATE_SUB_STATE_STAGE0;
            } else {
                aModEntry->context->cfgLoadState = BCM_STATE_SUB_STATE_RESET;
                /* Report error */
                retVal = BCM_ERR_UNKNOWN;
            }
        } else {
            status.size = aModEntry->context->cfgLoadSize;
            status.hdr = (const MSGQ_MsgHdrType *)((uint32_t)aModEntry->context->handle);
            status.mode = aModEntry->context->custom[0UL];
            retVal  = IMGL_GetStatus(&status);
            if (BCM_ERR_BUSY == retVal) {
                /* Check again on an event */
            } else {
                aModEntry->context->cfgLoadSize = status.size;
                aModEntry->context->cfgLoadState = BCM_STATE_SUB_STATE_RESET;
                aModEntry->context->isCfgLoaded = TRUE;
                if (retVal != BCM_ERR_OK) {
                    retVal = BCM_ERR_UNKNOWN;
                    aModEntry->context->cfgLoadState = BCM_STATE_SUB_STATE_RESET;
                    BCM_MemSet(aModEntry->configImgData, 0U, aModEntry->configImgSize);
                }
            }
        }
    }

    return retVal;
}
/** @} */
