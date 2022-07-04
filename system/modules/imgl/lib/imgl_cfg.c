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
    @defgroup grp_imgl_cfg_impl API Implementation
    @ingroup grp_imgl

    @addtogroup grp_imgl_cfg_impl
    @{

    @file imgl_cfg.c
    @brief IMGL API Implementation
    This source file contains the implementation of functions for IMGL loads

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
    @name IMGL Design IDs
    @{
    @brief Design IDs for IMGL
*/
#define BRCM_SWDSGN_IMGL_CFGCONTEXT_GLOBAL            (0xBB01U)    /**< @brief #IMGL_CfgContext       */
#define BRCM_SWDSGN_IMGL_LOAD_STATE_HANDLER_PROC      (0xBB02U)    /**< @brief #IMGL_LoadStateHandler */
#define BRCM_SWDSGN_IMGL_LOAD_REQ_HANDLER_PROC        (0xBB03U)    /**< @brief #IMGL_LoadReqHandler   */
#define BRCM_SWDSGN_IMGL_CFGINIT_HANDLER_PROC         (0xBB04U)    /**< @brief #IMGL_CfgInitHandler   */
#define BRCM_SWDSGN_IMGL_CFGINIT_PROC                 (0xBB05U)    /**< @brief #IMGL_CfgInit          */
#define BRCM_SWDSGN_IMGL_CFG_HANDLER_PROC             (0xBB06U)    /**< @brief #IMGL_CfgHandler       */
#define BRCM_SWDSGN_IMGL_CFG_GET_PROC                 (0xBB07U)    /**< @brief #IMGL_CfgGet           */
#define BRCM_SWDSGN_IMGL_CFG_GET_STATUS_PROC          (0xBB08U)    /**< @brief #IMGL_CfgGetStatus     */
#define BRCM_SWDSGN_IMGL_LOAD_EXE_IMAGE_PROC          (0xBB09U)    /**< @brief #IMGL_LoadFirmwareImage*/
/** @} */

/** @brief Image Loader from multiple enabled modes

    @behavior Sync, Non-reentrant

    @pre IMGL is initialized

    @param[inout]       aMsg        Load Image Message

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Image is successfully loaded and authenticated
    @retval     #BCM_ERR_AUTH_FAILED    Authentication failed
    @return     #BCM_ERR_NOMEM          Insufficient memory to load image
    @return     #BCM_ERR_NOT_FOUND      Image not found
    @return     #BCM_ERR_BUSY           Image loading Busy

    @post Image is loaded into download area upon success

    @trace #BRCM_SWARCH_IMGL_CFG_HANDLER_PROC
    @trace #BRCM_SWREQ_IMGL_CORE

    @code{.c}
    do
        state = aContext->loadState
        if aContext->loadState is IMGL_LOAD_STATE_RESET
            IMGL_CoreReset()
            aContext->loadState = IMGL_LOAD_STATE_READ_MODE_SETUP
            IMGL_LoadContext.devAddr = 0
            ret = BUSY
        else if aContext->loadState is IMGL_LOAD_STATE_READ_MODE_SETUP
            if IMGL_LoadContext.modeMask is 0
                ret = ERR_NOT_FOUND
                aContext->loadState = IMGL_LOAD_STATE_DONE
            else
                for interface  in IMGL_Interfaces
                    if (1 << interface ->mode) & IMGL_LoadContext.modeMask != 0
                        IMGL_LoadContext.modeMask &= ~(1<< interface ->mode)
                        IMGL_LoadContext.curModIndex = interface  index
                        aContext->loadState = IMGL_LOAD_STATE_READ_CHAN_SETUP
                        if load mode  is NVM, setup CoreContext.imgHdr by searching into shared memory or from PTU query
                            if buffer size is less
                                ret = NO_MEM
                                aContext->loadState = IMGL_LOAD_STATE_DONE
        else if aContext->loadState is IMGL_LOAD_STATE_READ_CHAN_SETUP
            for chan in 0:IMGL_Interfaces[curModIndex]->numChannels-1
                if (1 << chan) & IMGL_LoadContext.channelMask != 0
                    IMGL_LoadContext.channelMask &= ~(1 <<chan)
                    IMGL_CoreContextSet()
                    aContext->loadState = IMGL_LOAD_STATE_READ
            if chan is IMGL_Interfaces[curModIndex]->numChannels
                aContext->loadState = IMGL_LOAD_STATE_READ_MODE_SETUP
        else if aContext->loadState is IMGL_LOAD_STATE_READ
            ret = IMGL_LoadStageProcess()
            if ret is OK
                aContext->loadState = IMGL_LOAD_STATE_DONE
            else if ret is BUSY
                break
            else if ret is NOMEM or ret is AUTH_FAILED
                aContext->loadState = IMGL_LOAD_STATE_DONE
            else
                aContext->loadState = IMGL_LOAD_STATE_READ_CHAN_SETUP
        else (IMGL_LOAD_STATE_DONE)
            Do Nothing
    while state != aContext->loadState
    return ret
    @endcode
*/
static int32_t IMGL_LoadStateHandler(IMGL_CfgContextType *aContext, IMGL_LoadImgMsgType *aMsg)
{
    int32_t ret = BCM_ERR_BUSY;
    PTU_ImgInfoType  ptuImgInfo;
    IMGL_LoadStateType state;
    int32_t err;
    uint8_t *tempContextBuffer = NULL;
    uint32_t tempContextBufSize = 0UL;
    IMGL_ModeType mode = IMGL_LOAD_MODE_NONE;
    IMGL_ChannelType channel = IMGL_CHANNEL_ID_INVALID;

    IMGL_LoadCmdType cmd = IMGL_LOAD_CMD_INVALID;
    if (IMGL_CMD_LOAD_NORMAL == aMsg->cmd) {
        cmd = IMGL_LOAD_CMD_LOAD_NORMAL;
    } else if (IMGL_CMD_LOAD_RAW == aMsg->cmd) {
        cmd = IMGL_LOAD_CMD_LOAD_RAW;
    } else {
        /* Commenting for misra_c_2012_rule_15_7_violation */
    }

    do {
        state = aContext->loadState;
        switch (state) {
            case IMGL_LOAD_STATE_RESET:
                IMGL_SharedGetIfc(&mode, &channel);
                aContext->imgInfo.readModeIdx = IMGL_SearchModeIdx(mode);
                aContext->imgInfo.readChannel = IMGL_SearchChannelIdx(mode, channel);
                aContext->imgInfo.pid = aMsg->pid;
                aContext->imgInfo.imgID = aMsg->imgID;
                aContext->imgInfo.maxSize = aMsg->bufferSize;
                aContext->imgInfo.readDevAddr = 0UL;
                err = PTU_GetImgInfo(IMGL_SharedGetPTBL(), IMGL_SharedGetCopyID(PTBL_ID_SYSCFG), IMGL_SharedGetITBL(PTBL_ID_SYSCFG),
                                    aMsg->imgID, &ptuImgInfo);
                if (BCM_ERR_OK == err) {
                    BCM_MemSet(&aContext->core, 0U, sizeof(aContext->core));
                    aContext->imgInfo.readDevAddr = ptuImgInfo.flashAddr;
                    aContext->imgInfo.rawReadOffset = aMsg->offset;
                    aContext->loadState = IMGL_LOAD_STATE_READ;
                    ret = BCM_ERR_BUSY;
                } else {
                    ret = BCM_ERR_NOT_FOUND;
                }
            break;
            case IMGL_LOAD_STATE_READ:
                (void)IMGL_TempMemGet(&aContext->commonContext, 0UL, 0UL, &tempContextBuffer, &tempContextBufSize);
                aContext->imgInfo.bufferSize = tempContextBufSize;
                ret = IMGL_LoadStageProcess(cmd, &aContext->imgInfo, &aContext->core,
                                        tempContextBuffer, aMsg->loadAddr);
                if (BCM_ERR_OK == ret) {
                    aContext->loadState = IMGL_LOAD_STATE_DONE;
                } else if (BCM_ERR_BUSY == ret) {
                } else if ((BCM_ERR_NOMEM == ret) || (BCM_ERR_AUTH_FAILED == ret)) {
                    aContext->loadState = IMGL_LOAD_STATE_DONE;
                } else {
                    ret = BCM_ERR_NOT_FOUND;
                }
            break;
            case IMGL_LOAD_STATE_DONE:
                if (IMGL_CMD_LOAD_NORMAL == aMsg->cmd) {
                    aMsg->actSize = aContext->core.imgHdr.imgSize - sizeof(IMGL_ImgHdrType)
                                    + IMGL_IMGH_DWNLD_HDR_SIZE;
                } else if (IMGL_CMD_LOAD_RAW == aMsg->cmd) {
                    aMsg->actSize = aMsg->bufferSize;
                } else {
                    /* Commenting for misra_c_2012_rule_15_7_violation */
                }
            break;
            default:
                /* Do nothing */
            break;
        }
    } while (state != aContext->loadState);

    return ret;
}

/** @brief Load Firmware for Load RAW Image API

    @behavior Sync, Non-reentrant

    @pre IMGL is initialized

    @param[in]          aImglContext    IMGL Context
    @param[inout]       aMsg            Message containing offset and size of buffer

    Return values are documented in reverse-chronological order
    @retval     void

    @post None

    @trace #BRCM_SWARCH_IMGL_FETCH_MOD_GLOBAL
    @trace #BRCM_SWREQ_IMGL_CORE

    @code{.c}
    ret = PTU_GetImgInfo(IMGL_SharedGetPTBL(), IMGL_SharedGetCopyID(aMsg->pid), IMGL_SharedGetITBL(aMsg->pid), aMsg->imgID, &ptuImgInfo)
    if BCM_ERR_OK == ret
        IMGL_ImgHdrType * imgHdr = (IMGL_ImgHdrType *)ptuImgInfo.loadAddr
        if (NULL != imgHdr) && (IMGL_IMGH_MAGIC == imgHdr->magicNum)
            && (aMsg->offset <= BCM_ALIGN_NEXT(imgHdr->imgSize + IMGL_IMGH_DWNLD_HDR_SIZE, IMGL_ALIGN_VALUE))
            size = imgHdr->imgSize + IMGL_IMGH_DWNLD_HDR_SIZE - aMsg->offset
            size = BCM_MIN(size, aMsg->bufferSize)
            BCM_MemCpy(aMsg->loadAddr, (const uint8_t*)ptuImgInfo.loadAddr + aMsg->offset, size)
            aMsg->actSize = size
            aMsg->result = BCM_ERR_OK
        else
            aMsg->actSize = 0
            aMsg->result = BCM_ERR_NOT_FOUND
    else
        aMsg->actSize = 0
        aMsg->result = BCM_ERR_NOT_FOUND
    @endcode
*/
static void IMGL_LoadFirmwareImage(IMGL_LoadImgMsgType *aMsg)
{
    uint32_t loadAddr;
    uint32_t size;
    int32_t ret = PTU_GetLoadAddress(IMGL_SharedGetITBL(aMsg->pid), aMsg->imgID, &loadAddr);
    if (BCM_ERR_OK == ret) {
        IMGL_ImgHdrType * imgHdr = (IMGL_ImgHdrType *)loadAddr;
        if ((NULL != imgHdr) && (IMGL_IMGH_MAGIC == imgHdr->magicNum)) {
            size = BCM_ALIGN_NEXT(imgHdr->imgSize + IMGL_IMGH_DWNLD_HDR_SIZE, IMGL_ALIGN_VALUE);
            if (aMsg->offset <= size) {
                size -= aMsg->offset;
                size = BCM_MIN(size, aMsg->bufferSize);
                BCM_MemCpy(aMsg->loadAddr, (const uint8_t*)loadAddr + aMsg->offset, size);
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
    } else {
        aMsg->actSize = 0UL;
        aMsg->result = BCM_ERR_NOT_FOUND;
    }
}

/**
    @trace #BRCM_SWARCH_IMGL_CFG_HANDLER_PROC
    @trace #BRCM_SWREQ_IMGL_CORE

    @code{.unparsed}
    (ret, index) = MSGQ_GetMsgIdx(IMGL_GetMsgQ())
    while ret is OK
        msg = IMGL_GetMsg(index)
        if (cmd is not IMGL_LOAD_IMG_CMD_NORMAL or cmd is not IMGL_LOAD_IMG_CMD_RAW)
            msg->result = ERR_INVAL_PARAMS
        else if msg->result is UNINIT
            if aContext->state is IMGL_STATE_RUNNING
                aContext->loadState = RESET
                msg->result = IMGL_LoadStateHandler(msg)
            else
                Do nothing
        else if msg->result is BUSY
            msg->result = IMGL_LoadStateHandler(msg)
        else
            Do Nothing
        if (msg->result is not BUSY) && (msg->result is not UNINT)
            DCACHE_CleanAll();
            MSGQ_CompleteMsg(index)
            (ret,index) = MSGQ_GetMsgIdx(IMGL_GetMsgQ())
        else
            Break Loop
    @endcode
*/
static void IMGL_LoadReqHandler(IMGL_CfgContextType *aContext)
{
    uint32_t index = 0UL;

    int32_t ret = MSGQ_GetMsgIdx(IMGL_GetMsgQ(), &index);
    while (BCM_ERR_OK == ret) {
        IMGL_LoadImgMsgType *msg = IMGL_GetMsg(index);
        if ((IMGL_CMD_LOAD_NORMAL != msg->cmd) &&
            (IMGL_CMD_LOAD_RAW != msg->cmd)) {
            msg->result = BCM_ERR_INVAL_PARAMS;
        } else if (BCM_ERR_UNINIT == msg->result) {
            if (PTBL_ID_FW == msg->pid) {
                IMGL_LoadFirmwareImage(msg);
            } else if (IMGL_STATE_READY == aContext->state) {
                aContext->loadState = IMGL_LOAD_STATE_RESET;
                msg->result = IMGL_LoadStateHandler(aContext, msg);
            } else {
                /* wait to go to ready state */
            }
        } else if (BCM_ERR_BUSY == msg->result) {
            msg->result = IMGL_LoadStateHandler(aContext, msg);
        } else {
            /* Commenting for misra_c_2012_rule_15_7_violation */
        }

        if ((BCM_ERR_BUSY != msg->result)
            && (BCM_ERR_UNINIT != msg->result)) {
            DCACHE_CleanAll();
            (void)MSGQ_CompleteMsgIdx(IMGL_GetMsgQ(), index);
            ret = MSGQ_GetMsgIdx(IMGL_GetMsgQ(), &index);
        } else {
            break;
        }
    }
}

/**
    @trace #BRCM_SWARCH_IMGL_CFG_HANDLER_PROC
    @trace #BRCM_SWREQ_IMGL_CORE

    @code{.unparsed}
    if aContext->state is IMGL_STATE_INIT
        IMGL_InitStateHandler(&aContext->commonContext, aContext->initPID, &aContext->readyState, IMGL_TempMemGet, &aContext->imgInfo)
        if aContext->readyState is IMGL_INT_STATE_DONE
            aContext->state = IMGL_STATE_READY
        else if aContext->readyState is IMGL_INT_STATE_ERROR
            aContext->readyState = IMGL_INT_STATE_INIT

    @endcode
*/
static void IMGL_CfgInitHandler(IMGL_CfgContextType *aContext)
{
    if (IMGL_STATE_INIT == aContext->state) {
        IMGL_ModeType mode = IMGL_LOAD_MODE_NONE;
        IMGL_ChannelType channel = IMGL_CHANNEL_ID_INVALID;

        IMGL_SharedGetIfc(&mode, &channel);
        IMGL_InitStateHandler(&aContext->commonContext,
                               aContext->initPID,
                              &aContext->readyState,
                               IMGL_TempMemGet,
                              &aContext->imgInfo,
                               mode,
                               channel);
        if (IMGL_INT_STATE_DONE == aContext->readyState) {
            aContext->state = IMGL_STATE_READY;
        } else if (IMGL_INT_STATE_ERROR == aContext->readyState) {
            aContext->readyState = IMGL_INT_STATE_INIT;
        } else{
            /* Do nothing */
        }
    } else {
        /* Do nothing in ready state */
    }
}

/**
    @trace #BRCM_SWARCH_IMGL_CFG_HANDLER_PROC
    @trace #BRCM_SWREQ_IMGL_CORE

    @code{.unparsed}
    if IMGL_VerifyMagic() is ERR_OK
        Reset IMGL_CfgContext
        aContext->readyState = IMGL_INT_STATE_INIT
        aContext->initPID = PTBL_ID_SYSCFG
        IMGL_AllocateItbl(PTBL_ID_SYSCFG);
        ret = IMGL_CommonInit()
        ret = ERR_OK
    else
        ret = ERR_INVAL_MAGIC

    if ret is ERR_OK
        aContext->state = IMGL_STATE_INIT
    else
        aContext->state = IMGL_STATE_UNINIT
    return ret
    @endcode
*/
int32_t IMGL_CfgInit(IMGL_CfgContextType *aContext)
{

    int32_t ret = BCM_ERR_OK;
    IMGL_ModeType mode = IMGL_LOAD_MODE_NONE;
    IMGL_ChannelType channel = IMGL_CHANNEL_ID_INVALID;
    MCU_InfoType mcuInfo;

    /* Init to take place even if BL or ROM failed to initialize */
    IMGL_SharedContextInit();

    /* Choose RPC(UDP) mode on slave device */
    ret = MCU_GetInfo(&mcuInfo);
    if ((BCM_ERR_OK == ret) && (TRUE == mcuInfo.stackingEn) && (MCU_DEVICE_MASTER != mcuInfo.mstSlvMode)) {
        IMGL_SharedSetIfc(IMGL_LOAD_MODE_RPC, IMGL_CHANNEL_ID_RPC_UDP);
    }

    IMGL_SharedGetIfc(&mode, &channel);
    /* Get mode, if invalid. set to rpc. channel to 0 idx */
    if (IMGL_LOAD_MODE_MAX == IMGL_SearchModeIdx(mode)) {
        uint32_t modeIdx = IMGL_SearchModeIdx(IMGL_LOAD_MODE_RPC);
        if (IMGL_LOAD_MODE_MAX != modeIdx) {
            uint32_t i;
            for (i = 0UL; i < IMGL_CHANNEL_IDX_MAX; i++) {
                if (IMGL_CHANNEL_ID_INVALID != IMGL_Interfaces[modeIdx]->channel[i]) {
                    (void)IMGL_SharedSetIfc(IMGL_LOAD_MODE_RPC, IMGL_Interfaces[modeIdx]->channel[i]);
                    break;
                }
            }
        }
    }

    BCM_MemSet(aContext, 0U, sizeof(IMGL_CfgContextType));
    aContext->readyState = IMGL_INT_STATE_INIT;
    aContext->initPID = PTBL_ID_SYSCFG;

    IMGL_CommonInit(&aContext->commonContext);

    aContext->state = IMGL_STATE_INIT;

    return ret;
}

/**
    @trace #BRCM_SWARCH_IMGL_CFG_GET_PROC
    @trace #BRCM_SWREQ_IMGL_CORE

    @code{.unparsed}
    IMGL_CfgInitHandler()
    return ERR_OK
    @endcode
*/
int32_t IMGL_CfgGet(IMGL_CfgContextType *aContext)
{
    IMGL_CfgInitHandler(aContext);

    return BCM_ERR_OK;
}

/**
    @trace #BRCM_SWARCH_IMGL_CFG_GET_STATUS_PROC
    @trace #BRCM_SWREQ_IMGL_CORE

    @code{.unparsed}
    if aContext->state is IMGL_STATE_READY
        ret = ERR_OK
    else
        if aContext->readyState is IMGL_INT_STATE_INIT
            ret = ERR_NOT_FOUND;
        else
            ret = ERR_BUSY
    return ret
    @endcode
*/
int32_t IMGL_CfgGetStatus(IMGL_CfgContextType *aContext)
{
    int32_t ret;
    if (IMGL_STATE_READY == aContext->state) {
        ret = BCM_ERR_OK;
    } else {
        if (IMGL_INT_STATE_INIT == aContext->readyState) {
            ret = BCM_ERR_NOT_FOUND;
        } else {
            ret = BCM_ERR_BUSY;
        }
    }

    return ret;
}

/**
    @trace #BRCM_SWARCH_IMGL_CFG_HANDLER_PROC
    @trace #BRCM_SWREQ_IMGL_CORE

    @code{.c}
    IMGL_CfgInitHandler(aContext);
    IMGL_LoadReqHandler(aContext);
    @endcode
*/
void IMGL_CfgHandler(IMGL_CfgContextType *aContext)
{
    IMGL_CfgInitHandler(aContext);
    IMGL_LoadReqHandler(aContext);
}

/** @} */
