/*****************************************************************************
 Copyright 2021-2022 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_imgl_fetch_mod_impl Imgl fetch module Implementation
    @ingroup grp_imgl

    @addtogroup grp_imgl_fetch_mod_impl
    @{

    @file imgl_fetch_mod.c
    @brief module design for IMGL fetch module

    @version 0.1 Initial version
*/

#include <bcm_err.h>
#include <stdlib.h>
#include <module.h>
#include <system_state.h>
#include <imgl.h>
#include <imgl_osil.h>
#include <mcu.h>
#include <bcm_utils.h>
#include <osil/bcm_osil.h>
#include <imgl_mod.h>
#include <osil/module_osil.h>
#include <imgl_lib.h>
#include <otp_module.h>
#if !defined(IMGL_NO_CACHE)
#include <cache.h>
#endif
#include "imgl_common.h"
#include "imgl_shared_context.h"
/**
    @name Subsystem Notificaiton Design IDs
    @{
    @brief Design IDs for Subsystem Notificaiton

*/
#define BRCM_SWDSGN_IMGL_FETCH_MODCONTEXT_TYPE            (0xB701U)    /**< @brief #IMGL_FetchModContextType    */
#define BRCM_SWDSGN_IMGL_FETCH_MODCONTEXT_GLOBAL          (0xB702U)    /**< @brief #IMGL_FetchModContext        */
#define BRCM_SWDSGN_IMGL_FETCH_MODULE_GLOBAL              (0xB703U)    /**< @brief #IMGL_FetchModule            */
#define BRCM_SWDSGN_IMGL_FETCH_RESETSTATE_HANDLER_PROC    (0xB704U)    /**< @brief #IMGL_FetchResetStateHandler */
#define BRCM_SWDSGN_IMGL_FETCH_INITSTATE_HANDLER_PROC     (0xB705U)    /**< @brief #IMGL_FetchExeInitStateHandler  */
#define BRCM_SWDSGN_IMGL_FETCH_EVENTHANDLER_PROC          (0xB706U)    /**< @brief #IMGL_FetchEventHandler      */
#define BRCM_SWDSGN_IMGL_FETCH_GET_EVENTMASK_PROC         (0xB707U)    /**< @brief #IMGL_FetchGetEventMask      */
#define BRCM_SWDSGN_IMGL_GET_ENTRY_POINT_PROC             (0xB709U)    /**< @brief #IMGL_GetEntryPt             */
#define BRCM_SWDSGN_IMGL_LOAD_BL_IMG_PROC                 (0xB70AU)    /**< @brief #IMGL_LoadBootloaderImage    */
#define BRCM_SWDSGN_IMGL_FETCH_EXE_INIT_PROC              (0xB70BU)    /**< @brief #IMGL_FetchExeInit           */
#define BRCM_SWDSGN_IMGL_FETCH_EXE_HANDLER_PROC           (0xB70CU)    /**< @brief #IMGL_FetchExeHandler        */
#define BRCM_SWDSGN_IMGL_FETCH_EXE_REQ_PROC               (0xB70DU)    /**< @brief #IMGL_FetchExeReq            */
#define BRCM_SWDSGN_IMGL_FETCH_EXE_STATUS_PROC            (0xB70EU)    /**< @brief #IMGL_FetchExeStatus         */
#define BRCM_SWDSGN_IMGL_FETCH_INIT_STATE_CHECK_PROC      (0xB710U)    /**< @brief #IMGL_FetchInitStateCheck    */
/** @} */

/**
    @brief SYS IMGL Module context

    @trace #BRCM_SWARCH_IMGL_FETCH_MOD_GLOBAL
    @trace #BRCM_SWREQ_IMGL_CORE
*/
typedef struct sIMGL_FetchModContextType {
    MODULE_ContextType      innerContext;
    uint32_t                copyId;
    IMGL_EntryPtType        entryPt;
    uint32_t                isExeLoaded;
    IMGL_FetchContextType   fetchContext;
    IMGL_ChannelIdxType        channelIdx;
} IMGL_FetchModContextType;

/**
    @brief SYS IMGL Module context

    @trace #BRCM_SWARCH_IMGL_FETCH_MOD_GLOBAL
    @trace #BRCM_SWREQ_IMGL_CORE
*/
static IMGL_FetchModContextType IMGL_FetchModContext COMP_SECTION(".bss.imgl");

/** @brief Load Bootloader for Load RAW Image API

    @behavior Sync, Non-reentrant

    @pre IMGL is initialized

    @param[inout]       aMsg            Message containing offset and size of buffer

    Return values are documented in reverse-chronological order
    @retval     void

    @post None

    @trace #BRCM_SWARCH_IMGL_FETCH_MOD_GLOBAL
    @trace #BRCM_SWREQ_IMGL_CORE

    @code{.c}
    imgHdr = IMGL_GetBLAddr()
    if (imgHdr is not NULL) and (imgHdr->magicNum is IMGL_IMGH_MAGIC)
        and (aMsg->offset is less than BCM_ALIGN_NEXT(imgHdr->imgSize + IMGL_IMGH_DWNLD_HDR_SIZE, IMGL_ALIGN_VALUE))
        size = imgHdr->imgSize + IMGL_IMGH_DWNLD_HDR_SIZE - aMsg->offset
        size = MIN(size, aMsg->bufferSize)
        BCM_MemCpy(aMsg->loadAddr, IMGL_GetBLAddr() + aMsg->offset, size)
        aMsg->actSize = size
        aMsg->result = BCM_ERR_OK
    else
        aMsg->result = BCM_ERR_NOT_FOUND
    @endcode
*/
static void IMGL_LoadBootloaderImage(IMGL_LoadImgMsgType *aMsg)
{
    uint32_t size;
    IMGL_ImgHdrType * imgHdr = (IMGL_ImgHdrType *)IMGL_GetBLAddr();
    if ((NULL != imgHdr) && (IMGL_IMGH_MAGIC == imgHdr->magicNum)) {
        size = BCM_ALIGN_NEXT(imgHdr->imgSize + IMGL_IMGH_DWNLD_HDR_SIZE, IMGL_ALIGN_VALUE);
        if (aMsg->offset <= size) {
            size -= aMsg->offset;
            size = BCM_MIN(size, aMsg->bufferSize);
            BCM_MemCpy(aMsg->loadAddr, (const uint8_t*)IMGL_GetBLAddr() + aMsg->offset, size);
            aMsg->actSize = size;
            aMsg->result = BCM_ERR_OK;
        } else {
            aMsg->actSize = 0UL;
            aMsg->result = BCM_ERR_NOT_FOUND;
        }
    } else {
        aMsg->actSize = 0UL;
        aMsg->result = BCM_ERR_NOT_FOUND;
    }
}

/**
    @brief Initializes IMGL for fetching executable

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aPid       Partition table ID

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Success
    @retval     #BCM_ERR_UNKNOWN        Public Key or Decryption Key read failed.
                                        This device cannot be booted

    @post IMGL is initialized

    @trace #BRCM_SWARCH_IMGL_FETCH_MOD_GLOBAL
    @trace #BRCM_SWREQ_IMGL_CORE

    @code{.c}
    if aPid is BL or FW
        if IMGL_VerifyMagic() is not ERR_OK
            IMGL_SharedContextInit()
        Reset aFetchContext

        aFetchContext->initPID = aPid

        ret = IMGL_CommonInit()
        if ret is ERR_OK
            aFetchContext->state = IMGL_STATE_INIT
        else
            aFetchContext->state = IMGL_STATE_UNINIT
    else
        aFetchContext->state = IMGL_STATE_UNINIT
        ret = INVAL_PARAMS
    return ret
    @endcode
*/
static void IMGL_FetchExeInit(IMGL_FetchContextType *aFetchContext, PTBL_IdType aPid)
{
    int32_t ret;

    IMGL_SharedContextInit();

    BCM_MemSet(aFetchContext, 0U, sizeof(IMGL_FetchContextType));

    aFetchContext->initPID = aPid;

    IMGL_CommonInit(&aFetchContext->commonContext);

    /* Get enabled bootmodes */
    ret = OTPM_GetEnabledBootModes(&aFetchContext->bootModes);
    if (BCM_ERR_OK == ret) {
        aFetchContext->state = IMGL_STATE_INIT;
    } else {
        aFetchContext->bootModes = (OTPM_BOOTMODE_FLASH | OTPM_BOOTMODE_IPC | OTPM_BOOTMODE_TFTP);
        aFetchContext->state = IMGL_STATE_INIT;
    }
}

/**
    @trace #BRCM_SWARCH_IMGL_FETCH_MOD_GLOBAL
    @trace #BRCM_SWREQ_IMGL_CORE

    @code{.c}
    if (IMGL_INT_STATE_DONE == aFetchContext->initState) {
        (void)IMGL_SharedSetIfc(aFetchContext->fetchMode, aFetchContext->fetchChannel);
        aFetchContext->state = IMGL_STATE_READY;
        ret = BCM_ERR_OK;
    } else if (IMGL_INT_STATE_ERROR == aFetchContext->initState) {
        aFetchContext->initState = IMGL_INT_STATE_RESET;
        ret = BCM_ERR_NOT_FOUND;
    } else if (IMGL_INT_STATE_RESET == aFetchContext->initState) {
        ret = BCM_ERR_NOT_FOUND;
    } else {
        ret = BCM_ERR_BUSY;
    }

    return ret
    @endcode
*/
static int32_t IMGL_FetchInitStateCheck(IMGL_FetchContextType *aFetchContext)
{
    int32_t ret;

    if (IMGL_INT_STATE_DONE == aFetchContext->initState) {
        (void)IMGL_SharedSetIfc(aFetchContext->fetchMode, aFetchContext->fetchChannel);
        aFetchContext->state = IMGL_STATE_READY;
        ret = BCM_ERR_OK;
    } else if (IMGL_INT_STATE_ERROR == aFetchContext->initState) {
        aFetchContext->initState = IMGL_INT_STATE_RESET;
        ret = BCM_ERR_NOT_FOUND;
    } else if (IMGL_INT_STATE_RESET == aFetchContext->initState) {
        ret = BCM_ERR_NOT_FOUND;
    } else {
        ret = BCM_ERR_BUSY;
    }

    return ret;
}

/**
    @brief IMGL State Handler

    This function processes different pending requests from various clients,
    including IMGL_FetchExeReq requests

    @behavior Async, Non-reentrant

    @pre IMGL_FetchExeInit is called

    @param[in]      void

    @return     void

    @post None

    @trace #BRCM_SWARCH_IMGL_FETCH_MOD_GLOBAL
    @trace #BRCM_SWREQ_IMGL_CORE

    @code{.c}
    do
        if aFetchContext->state is INIT
            IMGL_InitStateHandler(aFetchContext->initPID, aFetchContext->initState, IMGL_MemoryGet, &aFetchContext->imgInfo)
            if aFetchContext->initState is IMGL_INT_STATE_DONE
                aFetchContext->state = IMGL_STATE_READY
        (ret, index) = MSGQ_GetMsgIdx(IMGL_GetMsgQ())
            while ret is OK
                msg = IMGL_GetMsg(index)
                if (cmd is not IMGL_LOAD_IMG_CMD_RAW)
                    msg->result = ERR_INVAL_PARAMS
                else
                    if msg->pid is PTBL_ID_BL
                        IMGL_LoadBootloaderImage(msg)
                    else
                        msg->result = ERR_INVAL_PARAMS
                DCACHE_CleanAll();
                MSGQ_CompleteMsgIdx(IMGL_GetMsgQ())
                ret = MSGQ_GetMsgIdx(IMGL_GetMsgQ())
    @endcode
*/
static void IMGL_FetchExeHandler(IMGL_FetchContextType *aFetchContext)
{
    uint32_t index = 0UL;
    int32_t ret;

    if (IMGL_STATE_INIT == aFetchContext->state) {
        IMGL_InitStateHandler(&aFetchContext->commonContext,
                               aFetchContext->initPID,
                              &aFetchContext->initState,
                               IMGL_MemoryGet,
                              &aFetchContext->imgInfo,
                              aFetchContext->fetchMode,
                              aFetchContext->fetchChannel);
        (void)IMGL_FetchInitStateCheck(aFetchContext);
    } else {
        /* Do nothing in Ready state */
    }

    ret = MSGQ_GetMsgIdx(IMGL_GetMsgQ(), &index);
    while (BCM_ERR_OK == ret) {
        IMGL_LoadImgMsgType *msg = IMGL_GetMsg(index);
        if (IMGL_CMD_LOAD_RAW != msg->cmd) {
            msg->result = BCM_ERR_INVAL_PARAMS;
        } else {
            if (PTBL_ID_BL == msg->pid) {
                IMGL_LoadBootloaderImage(msg);
            } else {
                msg->result = BCM_ERR_INVAL_PARAMS;
            }
        }
#if !defined(IMGL_NO_CACHE)
        DCACHE_CleanAll();
#endif
        (void)MSGQ_CompleteMsgIdx(IMGL_GetMsgQ(), index);
        ret = MSGQ_GetMsgIdx(IMGL_GetMsgQ(), &index);
    }
}

/**
    @brief Fetch Executable via allowed modes

    @behavior Async, Non-reentrant

    @pre IMGL_FetchExeInit is called

    @param[in]      aMode           Mode of fetching executable
    @param[in]      aChannel        Channel ID

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Success
    @retval     #BCM_ERR_UNKNOWN        no module found with aMode
    @retval     #BCM_ERR_BUSY           Pending Fetch request (call Status function)
    @retval     #BCM_ERR_INVAL_STATE    Initialization was not successful or not invoked
    @retval     #BCM_ERR_INVAL_PARAMS   (aMode is invalid) or (aChannel is invalid)

    @post None

    @note if aPID has non-zero copy number, images will be fetched from exact copy.
            Otherwise, any copy id will be attempted to load the images

    @limitations None

    @trace #BRCM_SWARCH_IMGL_FETCH_MOD_GLOBAL
    @trace #BRCM_SWREQ_IMGL_CORE

    @code{.c}
    ret = BCM_ERR_UNKNOWN
    found = 0;
    if (aMode is more than IMGL_LOAD_MODE_MAX) or (aChannel is more than IMGL_CHANNEL_IDX_MAX)
        ret = BCM_ERR_INVAL_PARAMS
    else IMGL_STATE_INIT != aFetchContext->state
        ret = BCM_ERR_INVAL_STATE
    else if IMGL_INT_STATE_RESET != aFetchContext->initState
            and IMGL_INT_STATE_DONE != aFetchContext->initState
            and IMGL_INT_STATE_ERROR != aFetchContext->initState
        ret = BCM_ERR_BUSY
    else
        for (i=0; i< IMGL_LOAD_MODE_MAX; i++)
            if IMGL_Interfaces[i] is not NULL and (IMGL_Interfaces[i]->mode == aMode)
                and (NULL != aInfo[i]) and (NULL != aInfo[i]->fetchPTBL) and (NULL != aInfo[i]->fetchITBL)
                and (NULL != aInfo[i]->fetchImage) and (NULL != aInfo[i]->getState)
                and (IMGL_STATE_INIT == aInfo[i]->getState())
                BCM_MemSet(&IMGL_FetchExeInfo, 0U, sizeof(IMGL_FetchExeInfo))
                IMGL_FetchExeInfo.status = BCM_ERR_OK
                IMGL_SharedSetMode(aMode)
                IMGL_SharedSetChannel(aChannel);
                IMGL_MemoryReset();
                aFetchContext->initState = IMGL_INT_STATE_INIT;
                ret = IMGL_FetchExeHandler(&IMGL_FetchExeInfo);
                if (ret == BCM_ERR_BUSY)
                    ret = BCM_ERR_OK
                else
                    ret = BCM_ERR_NOT_FOUND
    return ret
    @endcode
*/
static int32_t IMGL_FetchExeReq(IMGL_FetchContextType *aFetchContext, IMGL_ModeType aMode, IMGL_ChannelIdxType aChannel)
{
    int32_t ret = BCM_ERR_OK;
    if (IMGL_LOAD_MODE_MAX <= IMGL_SearchModeIdx(aMode)) {
        ret = BCM_ERR_INVAL_PARAMS;
    } else if (IMGL_STATE_INIT != aFetchContext->state) {
        ret = BCM_ERR_INVAL_STATE;
    } else if ((IMGL_INT_STATE_RESET != aFetchContext->initState)
                && (IMGL_INT_STATE_DONE != aFetchContext->initState)
                && (IMGL_INT_STATE_ERROR != aFetchContext->initState)) {
        ret = BCM_ERR_BUSY;
    } else {
        aFetchContext->fetchMode = aMode;
        aFetchContext->fetchChannel = IMGL_Interfaces[IMGL_SearchModeIdx(aMode)]->channel[aChannel];

        /* check if the mode is enabled or not */
        if ((IMGL_CHANNEL_ID_INVALID == aFetchContext->fetchChannel)
                || ((IMGL_LOAD_MODE_NVM == aMode) && (0UL == (aFetchContext->bootModes & OTPM_BOOTMODE_FLASH)))) {
            ret = BCM_ERR_NOSUPPORT;
        } else if (IMGL_LOAD_MODE_RPC == aMode) {
            if ((IMGL_CHANNEL_ID_RPC_IPC == aFetchContext->fetchChannel) && (0UL == (aFetchContext->bootModes & OTPM_BOOTMODE_IPC))) {
                ret = BCM_ERR_NOSUPPORT;
            } else if ((IMGL_CHANNEL_ID_RPC_UDP == aFetchContext->fetchChannel) && (0UL == (aFetchContext->bootModes & OTPM_BOOTMODE_TFTP))) {
                ret = BCM_ERR_NOSUPPORT;
            } else if (IMGL_CHANNEL_ID_INVALID == aFetchContext->fetchChannel) {
                ret = BCM_ERR_NOSUPPORT;
            }
        }

        if (BCM_ERR_OK == ret) {

            aFetchContext->initState = IMGL_INT_STATE_INIT;
            IMGL_MemoryReset(&aFetchContext->commonContext);
            IMGL_InitStateHandler(&aFetchContext->commonContext,
                                   aFetchContext->initPID,
                                  &aFetchContext->initState,
                                   IMGL_MemoryGet,
                                  &aFetchContext->imgInfo,
                                   aFetchContext->fetchMode,
                                   aFetchContext->fetchChannel);
            ret = IMGL_FetchInitStateCheck(aFetchContext);
        } else {
            aFetchContext->initState = IMGL_INT_STATE_ERROR;
            ret = BCM_ERR_NOT_FOUND;
        }
    }
    return ret;
}

/**
    @brief IMGL Fetch Exe Status

    Retrieves current status of IMGL_FetchExeReq request. Caller is expected
    to trigger the state machine through IMGL_StateHandler independent of this
    API

    @behavior Sync, Non-reentrant

    @pre IMGL_FetchExeReq is called

    @param[out]     aEntryPt        Entry point address
    @param[out]     aCopyId         Copy info

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Success
    @retval     #BCM_ERR_NOT_FOUND      Executable not found
    @retval     #BCM_ERR_BUSY           Loading in progress
    @retval     #BCM_ERR_INVAL_STATE    Initialization was not successful or not invoked
                                        or No pending fetch command
    @retval     #BCM_ERR_INVAL_PARAMS   (aEntryPt is NULL)

    @post None

    @limitations None

    @trace #BRCM_SWARCH_IMGL_FETCH_MOD_GLOBAL
    @trace #BRCM_SWREQ_IMGL_CORE

    @code{.c}
    if aEntryPt is NULL
        ret = BCM_ERR_INVAL_PARAMS
    else if (aFetchContext->state is UNINIT) or (aFetchContext->initState is RESET)
        ret = BCM_ERR_INVAL_STATE
    else
        ret = IMGL_FetchExeHandler(&IMGL_FetchExeInfo);
        if ret is BCM_ERR_BUSY
            Do Nothing
        else if ret is not OK
            ret = BCM_ERR_NOT_FOUND
        else
            *aEntryPt = IMGL_FetchExeInfo.itbl.hdr.entryPt;
    return ret
    @endcode
*/
static int32_t IMGL_FetchExeStatus(IMGL_FetchContextType *aFetchContext, IMGL_EntryPtType *aEntryPt, uint32_t *aCopyId)
{
    int32_t ret;
    if ((NULL == aEntryPt) || (NULL == aCopyId)) {
        ret = BCM_ERR_INVAL_PARAMS;
    } else if (IMGL_STATE_UNINIT == aFetchContext->state) {
        ret = BCM_ERR_INVAL_STATE;
    } else {
        IMGL_InitStateHandler(&aFetchContext->commonContext,
                               aFetchContext->initPID,
                              &aFetchContext->initState,
                               IMGL_MemoryGet,
                              &aFetchContext->imgInfo,
                               aFetchContext->fetchMode,
                               aFetchContext->fetchChannel);
        ret = IMGL_FetchInitStateCheck(aFetchContext);
        if (BCM_ERR_OK == ret) {
            PTBL_IdType pid = IMGL_SharedGetCopyID(aFetchContext->initPID);
            const ITBL_Type* itbl = IMGL_SharedGetITBL(aFetchContext->initPID);
            if (NULL != itbl) {
                /* store mode details */
                (void)IMGL_SharedSetIfc(aFetchContext->fetchMode, aFetchContext->fetchChannel);
                aFetchContext->state = IMGL_STATE_READY;
                *aEntryPt = (IMGL_EntryPtType)itbl->hdr.entryPoint;
                *aCopyId = (uint32_t)((pid & PTBL_ID_COPY_MASK) >> PTBL_ID_COPY_SHIFT);
                BCM_REPORT_ERROR(BCM_IMG_ID, 0U, BRCM_SWDSGN_IMGL_FETCH_EXE_STATUS_PROC, ret,
                                 0UL, pid, "PID info");
                ret = BCM_ERR_OK;
            } else {
                ret = BCM_ERR_UNKNOWN;
            }
        }
    }
    return ret;
}

/**
    @code{.unparsed}
    if BCM_ERR_OK != IMGL_FetchExeInit(IMGL_FetchPID)
        retVal = BCM_ERR_UNKNOWN;
    @endcode

    @trace #BRCM_SWARCH_IMGL_FETCH_MOD_GLOBAL
    @trace #BRCM_SWREQ_IMGL_CORE
*/
static int32_t IMGL_FetchResetStateHandler(BCM_StateType aRequestedState)
{
    int32_t retVal = BCM_ERR_OK;
    uint32_t prevState;
    MODULE_ContextType *imglModContext = IMGL_FetchModule.context;

    do {
        prevState = imglModContext->subState;
        switch(imglModContext->subState) {
            case BCM_STATE_SUB_STATE_RESET:
                IMGL_FetchModContext.channelIdx = IMGL_CHANNEL_IDX0;
#if defined(ENABLE_IMGL_BL)
                IMGL_FetchExeInit(&IMGL_FetchModContext.fetchContext, PTBL_ID_FW);
#elif defined(ENABLE_IMGL_ROM)
                IMGL_FetchExeInit(&IMGL_FetchModContext.fetchContext, PTBL_ID_BL);
#else
#error "IMGL fetch module is not supported in this mode"
#endif
                imglModContext->subState = BCM_STATE_SUB_STATE_STAGE1;
                IMGL_FetchModContext.isExeLoaded = 0UL;
                break;
            case BCM_STATE_SUB_STATE_STAGE1:
                if (MCU_RESETMODE_NONE == MCU_GetResetMode()) {
                    IMGL_FetchExeReq(&IMGL_FetchModContext.fetchContext, IMGL_LOAD_MODE_NVM, IMGL_FetchModContext.channelIdx);
                    imglModContext->subState = BCM_STATE_SUB_STATE_STAGE2;
                } else {
                    retVal = BCM_ERR_OK;
                }
                break;
            case BCM_STATE_SUB_STATE_STAGE2:
                retVal = IMGL_FetchExeStatus(&IMGL_FetchModContext.fetchContext, &IMGL_FetchModContext.entryPt, &IMGL_FetchModContext.copyId);
                if ((BCM_ERR_OK != retVal) && (BCM_ERR_BUSY != retVal)) {
                    IMGL_FetchModContext.channelIdx++;
                    if (IMGL_CHANNEL_IDX_MAX > IMGL_FetchModContext.channelIdx) {
                        imglModContext->subState = BCM_STATE_SUB_STATE_STAGE1;
                    } else {
                        IMGL_FetchModContext.channelIdx = IMGL_CHANNEL_IDX0;
                        IMGL_FetchModContext.entryPt = NULL;
                        retVal = BCM_ERR_OK;
                    }
                } else if (BCM_ERR_OK == retVal) {
                    IMGL_FetchModContext.isExeLoaded = 1UL;
                } else {
                    /* Do nothing */
                }
                break;
            default:
                break;
            }
    } while (prevState != imglModContext->subState);

    if (BCM_ERR_BUSY != retVal) {
        imglModContext->subState = BCM_STATE_SUB_STATE_RESET;
    }

    return retVal;
}


/**
    @code{.unparsed}
    do
        prevState = subState
        switch(subState)
            case BCM_STATE_SUB_STATE_RESET:
                if MCU_GetResetMode != MCU_RESETMODE_DWNLD_IPC
                    if stacking is enable and device is master or
                    stacking is not enabled
                        retVal = IMGL_FetchExeReq(IMGL_LOAD_MODE_NVM, IMGL_CHANNEL_IDX0)
                    else
                        retVal = IMGL_FetchExeReq(IMGL_LOAD_MODE_RPC, IMGL_CHANNEL_IDX0)
                else
                    retVal = IMGL_FetchExeReq(IMGL_LOAD_MODE_RPC, IMGL_CHANNEL_IDX0)
                subState = BCM_STATE_SUB_STATE_STAGE1
            case BCM_STATE_SUB_STATE_STAGE1:
                err = IMGL_FetchExeStatus(&IMGL_FetchModContext.entryPt, &IMGL_FetchModContext.copyId)
                if BCM_ERR_OK == err
                    if stacking is enable and device is master
                        subState = BCM_STATE_SUB_STATE_STAGE2
                    else
                        subState = BCM_STATE_SUB_STATE_DONE
                else if BCM_ERR_BUSY != err && BCM_ERR_OK != err
                    IMGL_FetchExeReq(IMGL_LOAD_MODE_RPC, IMGL_CHANNEL_IDX0)
             break;
             case BCM_STATE_SUB_STATE_DONE
                retVal = BCM_ERR_OK
             break;

    while prevState != subState

    if retVal = BCM_ERR_OK
        subState = BCM_STATE_SUB_STATE_RESET

    return retVal
    @endcode

    @trace #BRCM_SWARCH_IMGL_FETCH_MOD_GLOBAL
    @trace #BRCM_SWREQ_IMGL_CORE
*/
static int32_t IMGL_FetchExeInitStateHandler(BCM_StateType aRequestedState)
{
    int32_t err;
    int32_t retVal = BCM_ERR_BUSY;
    uint32_t prevState;
    MODULE_ContextType *imglModContext = IMGL_FetchModule.context;

    do {
        prevState = imglModContext->subState;
        switch(imglModContext->subState) {
            case BCM_STATE_SUB_STATE_RESET:
                if (0UL == IMGL_FetchModContext.isExeLoaded) {
#ifdef IMGL_LOAD_MMAP_RETRY /* Retry MMAP load */
                    IMGL_FetchExeReq(&IMGL_FetchModContext.fetchContext, IMGL_LOAD_MODE_NVM, IMGL_FetchModContext.channelIdx);
#else
                    IMGL_FetchExeReq(&IMGL_FetchModContext.fetchContext, IMGL_LOAD_MODE_RPC, IMGL_FetchModContext.channelIdx);
#endif
                    imglModContext->subState = BCM_STATE_SUB_STATE_STAGE1;
                } else {
                    imglModContext->subState = BCM_STATE_SUB_STATE_DONE;
                }
                break;
            case BCM_STATE_SUB_STATE_STAGE1:
                err = IMGL_FetchExeStatus(&IMGL_FetchModContext.fetchContext, &IMGL_FetchModContext.entryPt, &IMGL_FetchModContext.copyId);
                if (BCM_ERR_OK == err) {
                    IMGL_FetchModContext.isExeLoaded = 1UL;
                    imglModContext->subState = BCM_STATE_SUB_STATE_DONE;
                } else if (BCM_ERR_BUSY == err) {
                    /*do nothing*/
                } else {
                    IMGL_FetchModContext.channelIdx++;
                    IMGL_FetchModContext.entryPt = NULL;
                    if (IMGL_CHANNEL_IDX_MAX == IMGL_FetchModContext.channelIdx) {
                        IMGL_FetchModContext.channelIdx = IMGL_CHANNEL_IDX0;
                    }
                    imglModContext->subState = BCM_STATE_SUB_STATE_RESET;
                }
                break;
            case BCM_STATE_SUB_STATE_DONE:
                retVal = BCM_ERR_OK;
                break;
            default:
                break;
        }
    } while(prevState != imglModContext->subState);

    if (BCM_ERR_OK == retVal) {
        imglModContext->subState = BCM_STATE_SUB_STATE_RESET;
    }

    return retVal;
}

/**
    @code{.unparsed}
    if IMGL_GetEventMask() & aMask
        IMGL_FetchExeHandler()
    @endcode

    @trace #BRCM_SWARCH_IMGL_FETCH_MOD_GLOBAL
    @trace #BRCM_SWREQ_IMGL_CORE
*/
static void IMGL_FetchEventHandler(uint32_t aMask)
{
    if (0UL != (IMGL_GetEventMask() & aMask)) {
        IMGL_FetchExeHandler(&IMGL_FetchModContext.fetchContext);
    }
}

/**
    @code{.unparsed}
    return (IMGL_GetEventMask() | MODULE_Event)
    @endcode

    @trace #BRCM_SWARCH_IMGL_FETCH_MOD_GLOBAL
    @trace #BRCM_SWREQ_IMGL_CORE
*/
static uint32_t IMGL_FetchGetEventMask(void)
{
    return (IMGL_GetEventMask() | MODULE_Event);
}

/**
    @brief Imgl module Info

    @trace #BRCM_SWARCH_IMGL_FETCH_MOD_GLOBAL
    @trace #BRCM_SWREQ_IMGL_CORE
*/
const MODULE_Type IMGL_FetchModule = {
    .groupID           = BCM_GROUPID_IMGL,
    .compID            = BCM_IMG_ID,
    .configImgID       = 0U,
    .configImgData     = NULL,
    .configImgSize     = 0UL,
    .context           = &IMGL_FetchModContext.innerContext,
    .resetStateHandler = IMGL_FetchResetStateHandler,
    .initStateHandler  = IMGL_FetchExeInitStateHandler,
    .readyStateHandler = NULL, /* Must be NULL, so context doesnt get cleared and IMGL get entry point gives correct entry point */
    .runStateHandler   = NULL, /* Must be NULL as fetch mod is never expected to reach here*/
    .eventHandler      = IMGL_FetchEventHandler,
    .sendCmd           = NULL,
    .mergeResult       = NULL,
    .getEventMask      = IMGL_FetchGetEventMask,
};

/**
    @code{.unparsed}
    return IMGL_FetchModContext.entryPt
    @endcode

    @trace #BRCM_SWARCH_IMGL_GET_ENTRY_POINT_PROC
    @trace #BRCM_SWREQ_IMGL_CORE
*/
int32_t IMGL_GetEntryPt(IMGL_EntryPtType *aEntryPt)
{
    int32_t ret = BCM_ERR_NOT_FOUND;

    if (0UL != IMGL_FetchModContext.isExeLoaded) {
        *aEntryPt = IMGL_FetchModContext.entryPt;
        ret = BCM_ERR_OK;
    }

    return ret;
}
/** @} */
