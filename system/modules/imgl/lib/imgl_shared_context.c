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
    @defgroup grp_imgl_shared_impl API Implementation
    @ingroup grp_imgl

    @addtogroup grp_imgl_shared_impl
    @{

    @file imgl_shared_context.c
    @brief IMGL API Implementation
    This source file contains the implementation of functions for IMGL shared context

    @version 1.0 Initial version
*/

#include <stdlib.h>
#include <imgl_interface.h>
#include <pt_utils.h>
#include <imgl_osil.h>
#include <bcm_utils.h>
#include <bcm_time.h>

#include "imgl_shared_context.h"

/**
    @name IMGL Core Design IDs
    @{
    @brief Design IDs for IMGL Core
*/
#define BRCM_SWDSGN_IMGL_MAGIC_MACRO                  (0xBC00U)    /**< @brief #IMGL_MAGIC               */
#define BRCM_SWDSGN_IMGL_SHARED_CONTEXT_TYPE          (0xBC01U)    /**< @brief #IMGL_SharedContextType   */
#define BRCM_SWDSGN_IMGL_SHARED_CONTEXT_GLOBAL        (0xBC02U)    /**< @brief #IMGL_SharedContext       */
#define BRCM_SWDSGN_IMGL_SHARED_CONTEXTINIT_PROC      (0xBC03U)    /**< @brief #IMGL_SharedContextInit   */
#define BRCM_SWDSGN_IMGL_SHARED_GETIFC_PROC           (0xBC04U)    /**< @brief #IMGL_SharedGetIfc        */
#define BRCM_SWDSGN_IMGL_SHARED_SETIFC_PROC           (0xBC05U)    /**< @brief #IMGL_SharedSetIfc        */
#define BRCM_SWDSGN_IMGL_SHARED_GETCHANNEL_PROC       (0xBC06U)    /**< @brief #IMGL_SharedGetChannel    */
#define BRCM_SWDSGN_IMGL_SHARED_SETCHANNEL_PROC       (0xBC07U)    /**< @brief #IMGL_SharedSetChannel    */
#define BRCM_SWDSGN_IMGL_SHARED_GETPTBL_PROC          (0xBC08U)    /**< @brief #IMGL_SharedGetPTBL       */
#define BRCM_SWDSGN_IMGL_SHARED_SETPTBL_PROC          (0xBC09U)    /**< @brief #IMGL_SharedSetPTBL       */
#define BRCM_SWDSGN_IMGL_SHARED_GETCOPYID_PROC        (0xBC0AU)    /**< @brief #IMGL_SharedGetCopyID     */
#define BRCM_SWDSGN_IMGL_SHARED_SETCOPYID_PROC        (0xBC0BU)    /**< @brief #IMGL_SharedSetCopyID     */
#define BRCM_SWDSGN_IMGL_SHARED_GETITBL_PROC          (0xBC0CU)    /**< @brief #IMGL_SharedGetITBL       */
#define BRCM_SWDSGN_IMGL_SHARED_SETITBL_PROC          (0xBC0DU)    /**< @brief #IMGL_SharedSetITBL       */
#define BRCM_SWDSGN_IMGL_SHARED_GETIMGHDR_PROC        (0xBC0EU)    /**< @brief #IMGL_SharedGetImgHdr     */
#define BRCM_SWDSGN_IMGL_SHARED_ADDIMGHDR_PROC        (0xBC0FU)    /**< @brief #IMGL_SharedAddImgHdr     */
#define BRCM_SWDSGN_IMGL_SHARED_REMOVEIMGHDRS_PROC    (0xBC10U)    /**< @brief #IMGL_SharedRemoveImgHdrs */
#define BRCM_SWDSGN_IMGL_SHARED_FINDIMGHDR_PROC       (0xBC11U)    /**< @brief #IMGL_SharedFindImgHdr    */
#define BRCM_SWDSGN_IMGL_DEINIT_PROC                  (0xBC12U)    /**< @brief #IMGL_Deinit              */
/** @} */

/**
    @trace #BRCM_SWARCH_IMGL_SHARED_CONTEXTINIT_PROC
    @trace #BRCM_SWREQ_IMGL_CORE
*/
#define IMGL_MAGIC      (0x4C474D49UL)

/**
    @brief IMGL Core context

    @trace #BRCM_SWARCH_IMGL_SHARED_CONTEXTINIT_PROC
    @trace #BRCM_SWREQ_IMGL_CORE
 */
typedef struct sIMGL_SharedContextType {
    uint32_t                magic;              /**< @brief #IMGL_MAGIC                         */
    IMGL_ModeType           mode;               /**< @brief Load mode                           */
    IMGL_ChannelType        channel;            /**< @brief Load Channel                        */
    uint16_t                itblIdx[PTBL_MAX_NUM_ENTRIES];
    PTBL_IdType             pid[PTBL_MAX_NUM_ENTRIES];
                                                /**< @brief Partion table ID                    */
    uint8_t                 padding[64UL
                                        - ((sizeof(PTBL_IdType) + sizeof(uint16_t))* PTBL_MAX_NUM_ENTRIES)
                                        - sizeof(IMGL_ChannelType)
                                        - sizeof(IMGL_ModeType)
                                        - sizeof(uint32_t)]; /**< @brief To align the ptbl for readability */
    PTBL_Type               ptbl;               /**< @brief Partition table                     */
    ITBL_Type               itbl[IMGL_CONTEXT_MAX_IMG_TBLS];
                                                /**< @brief Image tables                        */
    IMGL_ImgHdrType         imgHdrs[IMGL_MAX_IMG_HDRS]; /**< @brief Maximum number of image headers */
    uint8_t                 reserved[IMGL_CONTEXT_RESERVE_SIZE];
} IMGL_SharedContextType;

/**
    @brief Global context for IMGL_SharedContext

    @trace #BRCM_SWARCH_IMGL_SHARED_CONTEXTINIT_PROC
    @trace #BRCM_SWREQ_IMGL_CORE
*/
static IMGL_SharedContextType IMGL_SharedContext COMP_SECTION(".imgl.context.IMGL_SharedContext");

/**
    @trace #BRCM_SWARCH_IMGL_SHARED_CONTEXTINIT_PROC
    @trace #BRCM_SWREQ_IMGL_CORE
*/
void IMGL_SharedContextInit()
{
    if (IMGL_MAGIC != IMGL_SharedContext.magic) {
        uint32_t i;
        BCM_MemSet(&IMGL_SharedContext, 0U, sizeof(IMGL_SharedContextType));
        IMGL_SharedContext.magic = IMGL_MAGIC;
        for (i = 0UL; i < PTBL_MAX_NUM_ENTRIES; i++) {
            IMGL_SharedContext.itblIdx[i] = (uint16_t)IMGL_CONTEXT_MAX_IMG_TBLS;
        }
        (void)IMGL_SharedSetCopyID(PTBL_ID_USER_DATA, 1U);
    }
}

#if defined(ENABLE_IMGL_FW)
/**
    @trace #BRCM_SWARCH_IMGL_SHARED_GETIFC_PROC
    @trace #BRCM_SWREQ_IMGL_CORE
*/
void IMGL_SharedGetIfc(IMGL_ModeType *aMode, IMGL_ChannelType *aChannel)
{
    *aMode = IMGL_SharedContext.mode;
    *aChannel = IMGL_SharedContext.channel;
}
#endif

/**
    @trace #BRCM_SWARCH_IMGL_SHARED_SETIFC_PROC
    @trace #BRCM_SWREQ_IMGL_CORE
*/
int32_t IMGL_SharedSetIfc(IMGL_ModeType aMode, IMGL_ChannelType aChannel)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    if (IMGL_LOAD_MODE_NVM == aMode) {
        if ((IMGL_CHANNEL_ID_NVM_0 == aChannel)
            || (IMGL_CHANNEL_ID_NVM_1 == aChannel)) {
            IMGL_SharedContext.mode = aMode;
            IMGL_SharedContext.channel = aChannel;
            retVal = BCM_ERR_OK;
        }
    } else if (IMGL_LOAD_MODE_RPC == aMode) {
        if ((IMGL_CHANNEL_ID_RPC_IPC == aChannel)
            || (IMGL_CHANNEL_ID_RPC_UDP == aChannel)) {
            IMGL_SharedContext.mode = aMode;
            IMGL_SharedContext.channel = aChannel;
            retVal = BCM_ERR_OK;
        }
    } else {
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_IMGL_SHARED_GETPTBL_PROC
    @trace #BRCM_SWREQ_IMGL_CORE
*/
const PTBL_Type* IMGL_SharedGetPTBL()
{
    return (&IMGL_SharedContext.ptbl);
}

/**
    @trace #BRCM_SWARCH_IMGL_SHARED_SETPTBL_PROC
    @trace #BRCM_SWREQ_IMGL_CORE
*/
int32_t IMGL_SharedSetPTBL(uint8_t* aAddr, uint32_t aSize)
{
    int32_t ret = BCM_ERR_INVAL_PARAMS;

    if (NULL != aAddr) {
        ret = PTU_ConstructPTBL(aAddr, aSize, &IMGL_SharedContext.ptbl);
    }

    return ret;
}

/**
    @trace #BRCM_SWARCH_IMGL_SHARED_GETCOPYID_PROC
    @trace #BRCM_SWREQ_IMGL_CORE
*/
PTBL_IdType IMGL_SharedGetCopyID(PTBL_IdType aPid)
{
    PTBL_IdType pid = 0U;

    if (PTBL_MAX_NUM_ENTRIES > aPid) {
        pid = IMGL_SharedContext.pid[aPid];
    }

    return pid;
}

/**
    @trace #BRCM_SWARCH_IMGL_SHARED_SETCOPYID_PROC
    @trace #BRCM_SWREQ_IMGL_CORE
*/
int32_t IMGL_SharedSetCopyID(PTBL_IdType aPid, uint16_t aCopyId)
{
    int32_t ret = BCM_ERR_INVAL_PARAMS;

    if (PTBL_MAX_NUM_ENTRIES > aPid) {
        IMGL_SharedContext.pid[aPid] = PTBL_ID_CONSTRUCT(aPid, aCopyId);
        ret = BCM_ERR_OK;
    }

    return ret;
}


/**
    @trace #BRCM_SWARCH_IMGL_SHARED_GETITBL_PROC
    @trace #BRCM_SWREQ_IMGL_CORE
*/
const ITBL_Type* IMGL_SharedGetITBL(PTBL_IdType aPid)
{
    const ITBL_Type* itbl = NULL;

    if (PTBL_MAX_NUM_ENTRIES > aPid) {
        if ((uint16_t)IMGL_CONTEXT_MAX_IMG_TBLS > IMGL_SharedContext.itblIdx[aPid]) {
            itbl = &IMGL_SharedContext.itbl[IMGL_SharedContext.itblIdx[aPid]];
        }
    }

    return itbl;
}

/**
    @trace #BRCM_SWARCH_IMGL_SHARED_SETITBL_PROC
    @trace #BRCM_SWREQ_IMGL_CORE
*/
int32_t IMGL_SharedSetITBL(PTBL_IdType aPid, const ITBL_Type *aItbl) {

    int32_t ret = BCM_ERR_INVAL_PARAMS;
    if ((PTBL_MAX_NUM_ENTRIES > aPid) && (NULL != aItbl)) {
        const ITBL_Type* itbl = IMGL_SharedGetITBL(aPid);

        if (NULL == itbl) {
            uint32_t i;

            for (i = 0UL; i < IMGL_CONTEXT_MAX_IMG_TBLS; i++) {
                if ((ITBL_MAGIC != IMGL_SharedContext.itbl[i].hdr.magicNumber)
                    && (ITBL_MAGIC_V2 != IMGL_SharedContext.itbl[i].hdr.magicNumber)) {
                    break;
                }
            }

            if (IMGL_CONTEXT_MAX_IMG_TBLS > i) {
                IMGL_SharedContext.itblIdx[aPid] = (uint16_t)i;
            }
        }

        if ((uint16_t)IMGL_CONTEXT_MAX_IMG_TBLS > IMGL_SharedContext.itblIdx[aPid]) {
            IMGL_SharedContext.itbl[IMGL_SharedContext.itblIdx[aPid]] = *aItbl;
            ret = BCM_ERR_OK;
        }
    }

    return ret;
}

#if defined(ENABLE_IMGL_FW)
/**
    @trace #BRCM_SWARCH_IMGL_SHARED_GETIMGHDR_PROC
    @trace #BRCM_SWREQ_IMGL_CORE
*/
const IMGL_ImgHdrType* IMGL_SharedGetImgHdr(uint32_t aIdx)
{
    const IMGL_ImgHdrType* imgHdr = NULL;
    if (IMGL_MAX_IMG_HDRS > aIdx) {
        imgHdr = &IMGL_SharedContext.imgHdrs[aIdx];
    }
    return imgHdr;
}
#endif

/**
    @trace #BRCM_SWARCH_IMGL_SHARED_ADDIMGHDR_PROC
    @trace #BRCM_SWREQ_IMGL_CORE
*/
int32_t IMGL_SharedAddImgHdr(IMGL_ImgHdrType *aImgHdr)
{
    int32_t ret = BCM_ERR_INVAL_PARAMS;
    if (NULL != aImgHdr) {
        uint32_t i;
        for (i = 0UL; i < IMGL_MAX_IMG_HDRS; i++) {
            if (IMGL_IMGH_MAGIC != IMGL_SharedContext.imgHdrs[i].magicNum) {
                BCM_MemCpy(&IMGL_SharedContext.imgHdrs[i], aImgHdr, sizeof(IMGL_ImgHdrType));
                ret = BCM_ERR_OK;
                break;
            }
        }

        if (IMGL_MAX_IMG_HDRS == i) {
            ret = BCM_ERR_NOMEM;
        }
    }

    return ret;
}

/**
    @trace #BRCM_SWARCH_IMGL_SHARED_REMOVEIMGHDRS_PROC
    @trace #BRCM_SWREQ_IMGL_CORE
*/
void IMGL_SharedRemoveImgHdrs(PTBL_IdType aPid)
{
    uint32_t i;
    for (i = 0UL; i < IMGL_MAX_IMG_HDRS; i++) {
        IMGL_ImgHdrType* tmp = &IMGL_SharedContext.imgHdrs[i];
        if ((IMGL_IMGH_MAGIC == IMGL_SharedContext.imgHdrs[i].magicNum)
            && (aPid == ((tmp->flags & IMGL_IMG_FLAGS_PID_MASK) >> IMGL_IMG_FLAGS_PID_SHIFT))) {
            BCM_MemSet(tmp, 0U, sizeof(IMGL_ImgHdrType));
        }
    }

    /* clear itbl */
    ITBL_Type* itbl = NULL;

    if (PTBL_MAX_NUM_ENTRIES > aPid) {
        if ((uint16_t)IMGL_CONTEXT_MAX_IMG_TBLS > IMGL_SharedContext.itblIdx[aPid]) {
            itbl = &IMGL_SharedContext.itbl[IMGL_SharedContext.itblIdx[aPid]];
            BCM_MemSet(itbl, 0U, sizeof(ITBL_Type));
            IMGL_SharedContext.itblIdx[aPid] = (uint16_t)IMGL_CONTEXT_MAX_IMG_TBLS;
        }
    }
}

#if defined(ENABLE_IMGL_BL) || defined(ENABLE_IMGL_FW)
/**
    @trace #BRCM_SWARCH_IMGL_SHARED_FINDIMGHDR_PROC
    @trace #BRCM_SWREQ_IMGL_CORE
*/
IMGL_ImgHdrType* IMGL_SharedFindImgHdr(PTBL_IdType aPid, uint16_t aImgID)
{
    IMGL_ImgHdrType * ptr = NULL;
    uint32_t i;
    for (i = 0UL; i < IMGL_MAX_IMG_HDRS; i++) {
        IMGL_ImgHdrType * tmp = &IMGL_SharedContext.imgHdrs[i];
        if ((IMGL_IMGH_MAGIC == IMGL_SharedContext.imgHdrs[i].magicNum)
            && (aPid == ((tmp->flags & IMGL_IMG_FLAGS_PID_MASK) >> IMGL_IMG_FLAGS_PID_SHIFT))
            && (aImgID == ((tmp->flags & IMGL_IMG_FLAGS_IMGID_MASK) >> IMGL_IMG_FLAGS_IMGID_SHIFT))) {
            ptr = tmp;
            break;
        }
    }
    return ptr;
}

/**
    @trace #BRCM_SWARCH_IMGL_DEINIT_PROC
    @trace #BRCM_SWREQ_IMGL_CORE

    @code{.c}
    BCM_MemSet(IMGL_SharedContext, 0, sizeof(IMGL_SharedContext));
    return OK
    @endcode
*/
int32_t IMGL_Deinit()
{
    BCM_MemSet((uint8_t*)&IMGL_SharedContext, 0, sizeof(IMGL_SharedContext));

    return BCM_ERR_OK;
}
#endif

/** @} */
