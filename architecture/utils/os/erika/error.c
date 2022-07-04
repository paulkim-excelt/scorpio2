/*****************************************************************************
 Copyright 2017-2021 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_utils_err_impl BCM Error Implementation
    @ingroup grp_utils

    @addtogroup grp_utils_err_impl
    @{

    @file error.c
    @brief Error reporting and Query
    This file implements Error Reporting function.

    @version 0.1 Initial version
*/

#include "ee.h"
#include <compiler.h>
#include <bcm_utils.h>
#include <bcm_err.h>
#include <msg_queue.h>
#include <base_app_cfg.h>
#ifdef __ARC_V2_EM__
#include <arc_timer.h>
#else
#include <cortex_mx.h>
#include <mcu.h>
#endif

/**
    @name Error Reporting Design IDs
    @{
    @brief Design IDs for Error Reporting
*/
#define BRCM_SWDSGN_BCM_ERR_LOG_MSGQ_ENTRY_LOG2COUNT_MACRO (0xA501U)    /**< @brief #BCM_ERR_LOG_MSGQ_ENTRY_LOG2COUNT   */
#define BRCM_SWDSGN_BCM_ERR_LOG_GLOBAL                     (0xA505U)    /**< @brief #BCM_ErrLog                         */
#define BRCM_SWDSGN_BCM_ERR_LOG_GET_MSG_PROC               (0xA506U)    /**< @brief #BCM_ErrLogGetMsg                   */
#define BRCM_SWDSGN_BCM_ERR_LOG_MSGQ_GLOBAL                (0xA507U)    /**< @brief #BCM_ErrLogMsgQ                     */
#define BRCM_SWDSGN_BCM_UPDATE_STACKING_INFO_PROC          (0xA508U)    /**< @brief #BCM_UpdateStackingInfo             */
#define BRCM_SWDSGN_BCM_UPDATE_DEV_INFO_PROC               (0xA509U)    /**< @brief #BCM_UpdateDevInfo                  */
#define BRCM_SWDSGN_BCM_GET_ERROR_PROC                     (0xA50CU)    /**< @brief #BCM_GetError                       */
#define BRCM_SWDSGN_BCM_ERR_REPORT_PROC                    (0xA50DU)    /**< @brief #BCM_ReportError                    */
#define BRCM_SWDSGN_BCM_ERR_REPORTV2_PROC                  (0xA50EU)    /**< @brief #BCM_ReportErrorV2                  */
#define BRCM_SWDSGN_BCM_DBGMSG_PUTRAW_PROC                 (0xA50FU)    /**< @brief #BCM_DbgMsgPutRaw                   */
/** @} */

/**
    @trace #BRCM_SWARCH_BCM_ERR_REPORT_PROC
    @trace #BRCM_SWREQ_BCM_COMPONENT_MSGQ
*/
#ifndef BCM_ERR_LOG_MSGQ_ENTRY_LOG2COUNT
#define BCM_ERR_LOG_MSGQ_ENTRY_LOG2COUNT    (8UL)
#endif

/**
    @trace #BRCM_SWARCH_BCM_GET_ERROR_PROC
    @trace #BRCM_SWARCH_BCM_ERR_REPORT_PROC
    @trace #BRCM_SWREQ_BCM_COMPONENT_MSGQ
*/
static BCM_DbgMsgType BCM_ErrLog[1UL << BCM_ERR_LOG_MSGQ_ENTRY_LOG2COUNT] COMP_SECTION(".bss.bcm.err.BCM_ErrLog");

/**
    @trace #BRCM_SWARCH_BCM_GET_ERROR_PROC
    @trace #BRCM_SWARCH_BCM_ERR_REPORT_PROC
    @trace #BRCM_SWREQ_BCM_COMPONENT_MSGQ
*/
void* BCM_ErrLogGetMsg(uint32_t idx)
{
    void* pRet = NULL;

    if (idx < (1UL << BCM_ERR_LOG_MSGQ_ENTRY_LOG2COUNT)) {
        pRet = (void *)(&BCM_ErrLog[idx]);
    }
    return pRet;
}

/**
    @trace #BRCM_SWARCH_BCM_GET_ERROR_PROC
    @trace #BRCM_SWARCH_BCM_ERR_REPORT_PROC
    @trace #BRCM_SWREQ_BCM_COMPONENT_MSGQ
*/
MSGQ_DEFINE_V4(BCM_ErrLogMsgQ, BCM_ERR_LOG_MSGQ_ENTRY_LOG2COUNT, BCM_DBG_MSG_TASK, MSGQ_NO_CLIENTMASK,
               BCM_DbgMsgType, BCM_ErrLogMsgHdrQ, BCM_ErrLogGetMsg, ".bss.err.log");

/**
    @trace #BRCM_SWARCH_BCM_GET_ERROR_PROC
    @trace #BRCM_SWREQ_BCM_COMPONENT_MSGQ
*/
#ifndef __ARC_V2_EM__
static void BCM_UpdateStackingInfo(BCM_DbgMsgType *aInfo)
{
    MCU_InfoType mcuInfo;

    (void)MCU_GetInfo(&mcuInfo);
    aInfo->devInfo |= ((uint32_t)mcuInfo.stackingEn << BCM_DEV_INFO_STACKING_EN_SHIFT) & BCM_DEV_INFO_STACKING_EN_MASK;
    aInfo->devInfo |= ((uint32_t)mcuInfo.mstSlvMode << BCM_DEV_INFO_STACKING_MODE_SHIFT) & BCM_DEV_INFO_STACKING_MODE_MASK;
}
#endif

/**
    @trace #BRCM_SWARCH_BCM_ERR_REPORT_PROC
    @trace #BRCM_SWARCH_BCM_ERR_REPORTV2_PROC
    @trace #BRCM_SWREQ_BCM_COMPONENT_MSGQ
*/
static void BCM_UpdateDevInfo(BCM_DbgMsgType *aInfo)
{
#ifdef __ARC_V2_EM__
    //aInfo->timeMS = ARC_TimerGetTickCntRTC();
    aInfo->devInfo |= (BCM_DEV_INFO_CPU_HSM << BCM_DEV_INFO_CPU_SHIFT) & BCM_DEV_INFO_CPU_MASK;
#else
    aInfo->timeMS = CORTEX_MX_SysTickCount;
    aInfo->devInfo |= (BCM_DEV_INFO_CPU_APP << BCM_DEV_INFO_CPU_SHIFT) & BCM_DEV_INFO_CPU_MASK;
#endif
#if defined(ENABLE_ROM_MODE)
    aInfo->bootMode = BCM_BOOT_MODE_IDX_ROM;
#elif defined(ENABLE_BOOTLOADER_MODE)
    aInfo->bootMode = BCM_BOOT_MODE_IDX_BL;
#else
    aInfo->bootMode = BCM_BOOT_MODE_IDX_FW;
#endif
}

/**
    @trace #BRCM_SWARCH_BCM_GET_ERROR_PROC
    @trace #BRCM_SWREQ_BCM_COMPONENT_MSGQ
*/
int32_t BCM_GetError(BCM_DbgMsgType *aError)
{
    int32_t ret = BCM_ERR_NOMEM;
    TaskType taskID = INVALID_TASK;
    uint32_t index = 0UL;

    if (NULL == aError) {
        ret = BCM_ERR_INVAL_PARAMS;
    } else {
        (void)GetTaskID(&taskID);
        if (taskID == BCM_ErrLogMsgQ.serverID) {
            ret = MSGQ_GetMsgIdx(&BCM_ErrLogMsgQ, &index);
            if (BCM_ERR_OK == ret) {
                BCM_MemCpy(aError, &BCM_ErrLog[index], sizeof(BCM_DbgMsgType));
#ifndef __ARC_V2_EM__
                BCM_UpdateStackingInfo(aError);
#endif
                ret = MSGQ_CompleteMsgIdx(&BCM_ErrLogMsgQ, index);
            }
        }
    }

    return ret;
}

/**
    @trace #BRCM_SWARCH_BCM_ERR_REPORT_PROC
    @trace #BRCM_SWREQ_BCM_COMPONENT_MSGQ
*/
void BCM_ReportError(BCM_CompIDType aCompID,
                       uint8_t aInstanceID,
                       uint16_t aApiID,
                       int32_t aErrorID,
                       uint32_t aNumInts,
                       const uint32_t *const aValues)
{
    uint32_t i;
    BCM_DbgMsgType error = {
        .version  = BCM_ERR_VERSION_0,
        .comp     = aCompID,
        .instance = aInstanceID,
        .api      = aApiID,
        .line     = 0U,
        .state    = BCM_STATE_UNINIT,
        .error    = aErrorID,
    };
    if (NULL != aValues) {
        for (i = 0UL; (i < aNumInts) && (i < BCM_ERR_MAX_CUSTOM_VALUES); i++) {
            error.custom[i] = aValues[i];
        }
    }
    for (i = aNumInts; i < BCM_ERR_MAX_CUSTOM_VALUES; i++) {
        error.custom[i] = 0UL;
    }

    (void)BCM_UpdateDevInfo(&error);
#ifdef ENABLE_ALL_ERR_LOGS
    (void)MSGQ_SendMsg(&BCM_ErrLogMsgQ, (const void *) &error, MSGQ_NO_CLIENTMASK, NULL);
#else
    if (BCM_ERR_OK == aErrorID) {
        (void)MSGQ_SendMsg(&BCM_ErrLogMsgQ, (const void *) &error, MSGQ_NO_CLIENTMASK, NULL);
    }
#endif /* ENABLE_ERR_LOGS*/
}

/**
    @trace #BRCM_SWARCH_BCM_ERR_REPORTV2_PROC
    @trace #BRCM_SWREQ_BCM_COMPONENT_MSGQ
*/
void BCM_ReportErrorV2(BCM_CompIDType aCompID,
                       uint8_t aInstanceID,
                       uint16_t aApiID,
                       int32_t aErrorID,
                       uint32_t aLineNo,
                       uint32_t aState,
                       uint32_t aNumInts,
                       const uint32_t *const aValues)
{
    uint32_t i;
    BCM_DbgMsgType error = {
        .version  = BCM_ERR_VERSION_1,
        .comp     = aCompID,
        .instance = aInstanceID,
        .api      = aApiID,
        .line     = (uint16_t)aLineNo,
        .state    = aState,
        .error    = aErrorID,
    };
    if (NULL != aValues) {
        for (i = 0UL; (i < aNumInts) && (i < BCM_ERR_MAX_CUSTOM_VALUES); i++) {
            error.custom[i] = aValues[i];
        }
    }
    for (i = aNumInts; i < BCM_ERR_MAX_CUSTOM_VALUES; i++) {
        error.custom[i] = 0UL;
    }

    (void)BCM_UpdateDevInfo(&error);

#ifdef ENABLE_ALL_ERR_LOGS
    (void)MSGQ_SendMsg(&BCM_ErrLogMsgQ, (const void *) &error, MSGQ_NO_CLIENTMASK, NULL);
#else
    if (BCM_ERR_OK == aErrorID) {
        (void)MSGQ_SendMsg(&BCM_ErrLogMsgQ, (const void *) &error, MSGQ_NO_CLIENTMASK, NULL);
    }
#endif /* ENABLE_ERR_LOGS*/
}

/**
   @trace #BRCM_SWARCH_BCM_LOG_DEBUG_INFO_PROC
   @trace #BRCM_SWREQ_BCM_COMPONENT_MSGQ
*/
void BCM_DbgMsgPutRaw(BCM_DbgMsgType *aDebugInfo)
{
    (void)MSGQ_SendMsg(&BCM_ErrLogMsgQ, (const void *)aDebugInfo, MSGQ_NO_CLIENTMASK, NULL);
}

/** @} */
