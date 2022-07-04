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
    @addtogroup grp_imgl_osil_ifc
    @{

    @file imgl_common_osil.c
    @brief Image Loader Integration
    This source file contains the integration of Iamge Loader
    @version 0.1 Initial version
*/

#include <stddef.h>
#include <msg_queue.h>
#include <module_osil.h>
#include <imgl_osil.h>
#include <bcm_utils.h>
#if !defined(IMGL_FOR_BOOTLOADER)
#include "ee.h"
#include <bcm_osil.h>
#endif
#include <imgl_mmap.h>
#if defined(ENABLE_NVM)
#include <nvm_imgl.h>
#if defined(ENABLE_FLASH_MODULE)
#include <flash_module_osil.h>
#endif /* ENABLE_FLASH_MODULE */
#endif /* ENABLE_NVM */
#if defined(ENABLE_RPC_V2)
#include <rpc_master_loader.h>
#else
extern const IMGL_InterfaceType RPC_ImageHandler;
#endif
#if defined(IMGL_MODE_FUNC_TABLE_TEST)
#include <imgl_test.h>
#endif /* IMGL_MODE_FUNC_TABLE_TEST */

#if defined(SYSTEM_IMGL_FETCH_MODULE) || defined(SYSTEM_IMGL_UPDATE_MODULE)
#include <system_service_osil.h>
#endif
/**
    @name IMGL osil Design IDs
    @{
    @brief Design IDs for IMGL osil
*/
#define BRCM_SWDSGN_IMGL_LOAD_IMG_MSG_GLOBAL       (0xA401U)    /**< @brief #IMGL_LoadImgMsg        */
#define BRCM_SWDSGN_IMGL_GET_MSG_PROC              (0xA402U)    /**< @brief #IMGL_GetMsg            */
#define BRCM_SWDSGN_IMGL_LOAD_MSGQ_HDR_GLOBAL      (0xA403U)    /**< @brief #IMGL_LoadImgMsgQHdr    */
#define BRCM_SWDSGN_IMGL_LOAD_MSGQ_GLOBAL          (0xA404U)    /**< @brief #IMGL_LoadImgMsgQ       */
#define BRCM_SWDSGN_IMGL_GET_MSGQ_PROC             (0xA405U)    /**< @brief #IMGL_GetMsgQ           */
#define BRCM_SWDSGN_IMGL_GET_EVENT_PROC            (0xA406U)    /**< @brief #IMGL_GetEventMask      */
#define BRCM_SWDSGN_IMGL_MOD_EVENT_GLOBAL          (0xA407U)    /**< @brief #IMGL_ModEvent          */
#define BRCM_SWDSGN_MODULE_LOAD_CFG_PROC           (0xA408U)    /**< @brief #MODULE_LoadCfg         */
#define BRCM_SWDSGN_IMGL_INTERFACES_GLOBAL         (0xA409U)    /**< @brief #IMGL_Interfaces        */
#define BRCM_SWDSGN_IMGL_GET_SERVER_PROC           (0xA40AU)    /**< @brief #IMGL_GetServer         */
/** @} */

/**
    @brief IMGL Message queue array

    @trace #BRCM_SWARCH_IMGL_GET_MSG_PROC
    @trace #BRCM_SWREQ_IMGL_CORE
*/
static IMGL_LoadImgMsgType IMGL_LoadImgMsg[MSGQ_SIZE];

/**
    @brief IMGL module event

    @trace #BRCM_SWARCH_IMGL_MOD_EVENT_GLOBAL
    @trace #BRCM_SWREQ_IMGL_CORE
*/
const uint32_t IMGL_ModEvent = IMGL_EVENT;

/**
    @trace #BRCM_SWARCH_IMGL_GET_MSG_PROC
    @trace #BRCM_SWREQ_IMGL_CORE

    @code{.c}
    if aIdx < MSGQ_SIZE
        msg = &IMGL_LoadImgMsg[aIdx]
    else
        msg = NULL
    return msg
    @endcode
*/
void* IMGL_GetMsg(uint32_t aIdx)
{
    void *ptr = NULL;
    if (aIdx < MSGQ_SIZE) {
        ptr = (void *)&IMGL_LoadImgMsg[aIdx];
    }

    return ptr;
}

/**
    @brief IMGL load Message Queue

    @trace #BRCM_SWARCH_IMGL_GET_MSG_PROC
    @trace #BRCM_SWREQ_IMGL_CORE
*/
MSGQ_DEFINE_V2(IMGL_LoadImgMsgQ,
                IMGL_TASK_NAME,
                IMGL_EVENT,
                MSGQ_CLIENT_SIGNAL_ENABLE,
                IMGL_LoadImgMsgType,
                IMGL_LoadImgMsgQHdr,
                IMGL_GetMsg,
                ".bss.imgl");

/**
    @trace #BRCM_SWARCH_IMGL_GET_MSG_PROC
    @trace #BRCM_SWREQ_IMGL_CORE

    @code{.c}
    return &IMGL_LoadImgMsgQ;
    @endcode
*/
const MSGQ_Type* IMGL_GetMsgQ(void)
{
    return &IMGL_LoadImgMsgQ;
}

/**
    @trace #BRCM_SWARCH_IMGL_GET_EVENT_MASK_PROC
    @trace #BRCM_SWREQ_IMGL_CORE

    @code{.c}
    return IMGL_EVENT;
    @endcode
*/
uint32_t IMGL_GetEventMask(void)
{
    return (IMGL_EVENT) | MODULE_Event;
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
#ifdef ENABLE_BCM_MOD_CONFIG_LOAD
    IMGL_LoadStatusType status;
    uint32_t retry = 0UL;

    if (((0U != aModEntry->configImgID) && (0UL < aModEntry->configImgSize)) &&
        (FALSE == aModEntry->context->isCfgLoaded)) {
        do {
            retry = 0UL;
            if (BCM_STATE_SUB_STATE_RESET == aModEntry->context->cfgLoadState) {
                BCM_MemSet(aModEntry->configImgData, 0U, aModEntry->configImgSize);
                retVal = IMGL_LoadImg(aModEntry->configImgID, aModEntry->configImgData,
                                      aModEntry->configImgSize, MODULE_Event, &status);
                if (BCM_ERR_OK == retVal) {
                    retVal = BCM_ERR_BUSY;
                    aModEntry->context->cfgLoadSize = status.size;
                    aModEntry->context->handle = (uint32_t)status.hdr;
                    aModEntry->context->custom[0UL] = status.mode;
                    aModEntry->context->cfgLoadState = BCM_STATE_SUB_STATE_STAGE0;
                } else {
                    retVal = BCM_ERR_BUSY;
                }
            }
            if (BCM_STATE_SUB_STATE_STAGE0 == aModEntry->context->cfgLoadState) {
                status.size = aModEntry->context->cfgLoadSize;
                status.hdr = (const MSGQ_MsgHdrType *)((uint32_t)aModEntry->context->handle);
                status.mode = aModEntry->context->custom[0UL];
                retVal  = IMGL_GetStatus(&status);
                if (BCM_ERR_BUSY == retVal) {
                    /* Check again on an event */
                } else if (BCM_ERR_OK == retVal) {
                    aModEntry->context->cfgLoadSize = status.size;
                    aModEntry->context->cfgLoadState = BCM_STATE_SUB_STATE_RESET;
                    aModEntry->context->isCfgLoaded = TRUE;
                } else {
                    retVal = BCM_ERR_BUSY;
                    retry = 1UL;
                    aModEntry->context->cfgLoadState = BCM_STATE_SUB_STATE_RESET;
                    BCM_MemSet(aModEntry->configImgData, 0U, aModEntry->configImgSize);
                }
            }
        } while (retry == 1UL);
    }
#endif
    return retVal;
}


/**

    @trace #BRCM_SWARCH_IMGL_GET_SERVER_PROC
    @trace #BRCM_SWREQ_IMGL_CORE
 */
#if defined(SYSTEM_IMGL_FETCH_MODULE) || defined(SYSTEM_IMGL_UPDATE_MODULE)
void IMGL_GetServer(int32_t *aServerTask, uint32_t *aServerEvent)
{
    SYSTEM_GetServer(aServerTask, aServerEvent);
}
#endif

/**
    @brief Function pointer table for each IMGL Interface

    @trace #BRCM_SWARCH_IMGL_INTERFACES_GLOBAL
    @trace #BRCM_SWREQ_IMGL_ABSTRACTION
 */
const IMGL_InterfaceType * const IMGL_Interfaces[IMGL_LOAD_MODE_MAX] = {
#ifdef IMGL_MODE_FUNC_TABLE_PRIO0
&IMGL_MODE_FUNC_TABLE_PRIO0,
#else
NULL,
#endif /* IMGL_MODE_FUNC_TABLE_PRIO0 */
#ifdef IMGL_MODE_FUNC_TABLE_PRIO1
&IMGL_MODE_FUNC_TABLE_PRIO1,
#else
NULL,
#endif /* IMGL_MODE_FUNC_TABLE_PRIO1 */
#ifdef IMGL_MODE_FUNC_TABLE_TEST
&IMGL_MODE_FUNC_TABLE_TEST,
#else
NULL,
#endif /* IMGL_MODE_FUNC_TABLE_TEST */
};
/** @} */
