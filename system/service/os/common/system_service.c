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
    @defgroup grp_sys_service_impl Implementation
    @ingroup grp_sys_service

    @addtogroup grp_sys_service_impl
    @{

    @file system_service.c
    @brief System Module Implementation
    This file contains the invoke the module defined by integration layer

    @version 0.1 Initial draft
*/

#include <build_info.h>
#include <bcm_utils.h>
#include <system.h>
#include <msg_queue.h>
#include <bcm_err.h>
#include <stdlib.h>
#include <osil/system_osil.h>
#if defined(ENABLE_ETHSRV)
#include <ethernet_service.h>
#endif
#include <module.h>
#include <module_helper.h>
#include <system_state.h>
#include <dbgmem.h>
#include <otp.h>
#include <mcu.h>
#include <bcm_os.h>
#ifdef ENABLE_RPC_V2
#include <rpc_local_osil.h>
#include <rpc_module_v2.h>
#include <rpc_master_loader.h>
#endif
#include <bcm_os.h>
#include <module.h>
#include <system_module.h>
#if defined(ENABLE_TIME_MODULE)
#include <time_module_osil.h>
#endif

#if defined(ENABLE_IMGL_V2)
#include <imgl_interface.h>
#include <imgl_mod.h>
#include <imgl_osil.h>
#endif
#if defined(ENABLE_OTP_MODULE) && !defined(ENABLE_OTP_TEST)
#include <otp_module_osil.h>
#endif
#ifdef SYSTEM_NVM_SERVICE
#include <nvm_service.h>
#endif
#ifdef SYSTEM_CRYPTO_SERVICE
#include <crypto_service.h>
#endif
#ifdef ENABLE_TC10_MODULE
#include <tc10_module_osil.h>
#endif
#include <init.h>

#ifdef SYSTEM_WDG_MODULE
#include <wdg_osil.h>
#endif
#ifdef SYSTEM_IO_SERVICE
#include <io_service.h>
#endif
#include <system_module_v2.h>
#include <system_service_osil.h>

/**
    @name Subsystem Notificaiton Design IDs
    @{
    @brief Design IDs for Subsystem Notificaiton

*/
#define BRCM_SWDSGN_SYSTEM_CONTEXT_TYPE               (0xA401U)    /**< @brief #SYSTEM_ContextType       */
#define BRCM_SWDSGN_SYSTEM_CONTEXT_GLOBAL             (0xA402U)    /**< @brief #SYSTEM_Context           */
#define BRCM_SWDSGN_SYSTEM_SERVICE_GLOBAL             (0xA403U)    /**< @brief #SYSTEM_Service           */
#define BRCM_SWDSGN_SYSTEM_RESETSTATE_HANDLER_PROC    (0xA405U)    /**< @brief #SYSTEM_ResetStateHandler */
#define BRCM_SWDSGN_SYSTEM_INITSTATE_HANDLER_PROC     (0xA406U)    /**< @brief #SYSTEM_InitStateHandler  */
#define BRCM_SWDSGN_SYSTEM_READYSTATE_HANDLER_PROC    (0xA407U)    /**< @brief #SYSTEM_ReadyStateHandler */
#define BRCM_SWDSGN_SYSTEM_RUNSTATE_HANDLER_PROC      (0xA408U)    /**< @brief #SYSTEM_RunStateHandler   */
#define BRCM_SWDSGN_SYSTEM_EVENTHANDLER_PROC          (0xA409U)    /**< @brief #SYSTEM_EventHandler      */
#define BRCM_SWDSGN_SYSTEM_SEND_CMD_PROC              (0xA40BU)    /**< @brief #SYSTEM_SendCmd           */
#define BRCM_SWDSGN_SYSTEM_GET_RESP_PROC              (0xA40CU)    /**< @brief #SYSTEM_GetResp           */
#define BRCM_SWDSGN_SYSTEM_MERGE_RESULT_PROC          (0xA40DU)    /**< @brief #SYSTEM_MergeResult       */
#define BRCM_SWDSGN_SYSTEM_EVENTMASK_PROC             (0xA40EU)    /**< @brief #SYSTEM_GetEventMask      */
#define BRCM_SWDSGN_SYSTEM_MSGQ_GET_STATE_PROC        (0xA414U)    /**< @brief #SYSTEM_MsgQGetState      */
#define BRCM_SWDSGN_SYSTEM_ASYNC_MSG_PROC             (0xA419U)    /**< @brief #SYSTEM_AsyncMsg          */

/** @} */

/**
    @brief SYSTEM Context Type

    @trace #BRCM_SWARCH_SYSTEM_MODULE_GLOBAL
    @trace #BRCM_SWREQ_SYSTEM_SERVICE
*/
typedef struct sSYSTEM_ContextType {
    MODULE_ContextType      modCtx;
    MSGQ_CtxType            stateMsgQCtx;
    BCM_StateType           state[MSGQ_SIZE];
} SYSTEM_ContextType;

/**
    @brief SYSTEM Context

    @trace #BRCM_SWARCH_SYSTEM_MODULE_GLOBAL
    @trace #BRCM_SWREQ_SYSTEM_SERVICE
*/
static SYSTEM_ContextType SYSTEM_Context;

/**
    @brief SYSTEM Get Event Mask

    @trace #BRCM_SWARCH_SYSTEM_MODULE_GLOBAL
    @trace #BRCM_SWREQ_SYSTEM_SERVICE
*/
uint32_t SYSTEM_GetEventMask(void)
{
    uint32_t mask;

    mask = MODULE_Event;

    return mask;
}

/**
    @brief SYSTEM Event Handler

    @trace #BRCM_SWARCH_SYSTEM_MODULE_GLOBAL
    @trace #BRCM_SWREQ_SYSTEM_SERVICE
*/
void SYSTEM_EventHandler(uint32_t aMask)
{
}

/**
    @brief SYSTEM Reset Handler

    @trace #BRCM_SWARCH_SYSTEM_MODULE_GLOBAL
    @trace #BRCM_SWREQ_SYSTEM_SERVICE
*/
int32_t SYSTEM_ResetStateHandler(BCM_StateType aRequestedState)
{
    int32_t retVal;
    BCM_StateType state = BCM_STATE_READY;
    retVal = MSGQ_SendMsgv2(&SYSTEM_Service.client.cmdQ, (const uint8_t*)&state, MODULE_Event, NULL);
    if (BCM_ERR_OK != retVal) {
        retVal = BCM_ERR_UNKNOWN;
    }
    return retVal;
}

/**
    @brief SYSTEM Init Handler

    @trace #BRCM_SWARCH_SYSTEM_MODULE_GLOBAL
    @trace #BRCM_SWREQ_SYSTEM_SERVICE
*/
int32_t SYSTEM_InitStateHandler(BCM_StateType aRequestedState)
{
    int32_t retVal = BCM_ERR_BUSY;
    BCM_StateType state;

#if defined(ENABLE_FW_LOAD)
    state = BCM_STATE_UNINIT;
    retVal = MSGQ_SendMsgv2(&SYSTEM_Service.client.cmdQ, (const uint8_t*)&state, MODULE_Event, NULL);
#else
    state = BCM_STATE_RUN;
    retVal = MSGQ_SendMsgv2(&SYSTEM_Service.client.cmdQ, (const uint8_t*)&state, MODULE_Event, NULL);
#endif

    if ((BCM_ERR_OK != retVal) && (BCM_ERR_BUSY != retVal)) {
        retVal = BCM_ERR_UNKNOWN;
    }
    return retVal;
}

/**
    @brief SYSTEM Ready State Handler

    @trace #BRCM_SWARCH_SYSTEM_MODULE_GLOBAL
    @trace #BRCM_SWREQ_SYSTEM_SERVICE
*/
int32_t SYSTEM_ReadyStateHandler(BCM_StateType aRequestedState)
{
    int32_t retVal = BCM_ERR_BUSY;
    if (BCM_STATE_UNINIT == aRequestedState) {
#if defined(ENABLE_FW_LOAD)
        IMGL_EntryPtType entryPt;
        retVal = IMGL_GetEntryPt(&entryPt);
        if (BCM_ERR_OK == retVal) {
            BCM_ExecHandover(entryPt);
        }
#endif
        /* This should never happen*/
        retVal = BCM_ERR_UNKNOWN;
    } else {
        /* Do nothing */
        retVal = BCM_ERR_OK;
    }

    return retVal;
}

/**
    @brief SYSTEM Validate Cmd Handler

    @trace #BRCM_SWARCH_SYSTEM_MODULE_GLOBAL
    @trace #BRCM_SWREQ_SYSTEM_SERVICE
*/
static int32_t SYSTEM_SendCmd(BCM_CmdType aCmd, uint32_t aLen, const uint8_t *aCmdData,
                                BCM_HandleType *aHandle, uint32_t *aForwardToSlaves)
{
    int32_t              retVal = BCM_ERR_OK;
    retVal = MODULE_SendCmd(SYSTEM_Service.modules, MODULE_COUNT_MAX, MODULE_MSG_CHECK_COMP_ID,
                    aCmd, aLen, aCmdData, aHandle, aForwardToSlaves);
    return retVal;
}

/** @brief Retreive status of management commands

    This API queries the status of completed management commands which were
    previously issued to SYS

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aHandle         Message queue Handle
    @param[in]      aReplyID        Reply ID (group, comp, cmd)
    @param[in]      aInLen          Available Length of the reply data payload in bytes
    @param[out]     aReplyData      Pointer to reply message to be filled by SYS
    @param[out]     aReplyDataLen   Pointer to length of reply message to be filled by SYS

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK     Command status retrieved successfully

    @post None

    @trace #BRCM_SWARCH_SYSTEM_MODULE_GLOBAL
    @trace #BRCM_SWREQ_SYSTEM_SERVICE

    @limitations This API may not be supported on all the chipsets
*/
static int32_t SYSTEM_GetResp(BCM_HandleType aHandle, BCM_CmdType aReplyID, uint32_t aInLen,
                                     uint8_t *aReplyData, uint32_t *aReplyDataLen)
{
    int32_t     retVal;

    if ((0ULL == aHandle) || (aReplyData == NULL) || (aReplyDataLen == NULL)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        retVal = MODULE_GetResp(SYSTEM_Service.modules, MODULE_COUNT_MAX, MODULE_MSG_CHECK_COMP_ID,
                                aHandle, aReplyID, aInLen, aReplyData, aReplyDataLen);
    }

    return retVal;
}

/**
    @brief SYSTEM Async notification message

    @trace #BRCM_SWARCH_SYSTEM_MODULE_GLOBAL
    @trace #BRCM_SWREQ_SYSTEM_SERVICE
*/
int32_t SYSTEM_AsyncMsg(BCM_CmdType aNotfn,
                        const uint8_t *aMsg,
                        uint32_t aLen,
                        uint32_t *aForwardToHost)
{
    int32_t ret = BCM_ERR_OK;
    uint32_t compId = BCM_GET_COMP(aNotfn);

    if (BCM_TCT_ID == compId) {  /* FIXME: for all clients */
#ifdef ENABLE_TC10_MODULE
        ret = SYSTEM_TC10_MODULE.asyncMsg(aNotfn, aMsg, aLen, aForwardToHost);
#endif
    }

    return ret;
}

/**
    @brief SYSTEM Merge Result Handler

    @trace #BRCM_SWARCH_SYSTEM_MODULE_GLOBAL
    @trace #BRCM_SWREQ_SYSTEM_SERVICE
*/
static int32_t SYSTEM_MergeResult(BCM_CmdType aCmd, uint32_t aLen,
                                    uint8_t *aOutResponse, int32_t *aOutResult,
                                    const uint8_t *aInResponse1, int32_t aInResult1,
                                    const uint8_t *aInResponse2, int32_t aInResult2)
{
    int32_t retVal = BCM_ERR_OK;

    if ((NULL == aOutResponse) || (NULL == aOutResult)
        || (NULL == aInResponse1) || (NULL == aInResponse2)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if ((BCM_ERR_OK != aInResult1) || (BCM_ERR_OK != aInResult2)) {
        *aOutResult = (aInResult1 == BCM_ERR_OK) ? aInResult2 : aInResult1;
    } else {
        *aOutResult = BCM_ERR_OK;
    }

    return retVal;
}

/**
    @brief SYSTEM state transition commands helper for MSGQ

    @trace #BRCM_SWARCH_SYSTEM_MODULE_GLOBAL
    @trace #BRCM_SWREQ_SYSTEM_SERVICE
*/
static void* SYSTEM_MsgQGetState(uint32_t i)
{
    return (void*)&SYSTEM_Context.state[i];
}

/**
    @brief SYSTEM Module Handler

    @trace #BRCM_SWARCH_SYSTEM_MODULE_GLOBAL
    @trace #BRCM_SWREQ_SYSTEM_SERVICE
*/
const SERVICE_Type SYSTEM_Service = {
    .group  = BCM_GROUPID_SYS,
    .client = {
        .cmdQ              = MSGQ_INIT_V2(SYSTEM_GetServer, MSGQ_CLIENT_SIGNAL_ENABLE,
                                    BCM_StateType, MSGQ_SIZE, &SYSTEM_Context.stateMsgQCtx,
                                    SYSTEM_MsgQGetState),
    },
    .server = {
        .groupID           = BCM_GROUPID_SYS,
        .compID            = BCM_SYS_ID,
        .configImgID       = 0UL,
        .configImgData     = NULL,
        .configImgSize     = 0UL,
        .context           = &SYSTEM_Context.modCtx,
        .resetStateHandler = SYSTEM_ResetStateHandler,
        .initStateHandler  = SYSTEM_InitStateHandler,
        .readyStateHandler = SYSTEM_ReadyStateHandler,
        .eventHandler      = SYSTEM_EventHandler,
        .sendCmd           = SYSTEM_SendCmd,
        .getResp           = SYSTEM_GetResp,
        .mergeResult       = SYSTEM_MergeResult,
        .getEventMask      = SYSTEM_GetEventMask,
        .asyncMsg          = SYSTEM_AsyncMsg,
    },
    .state = SYSTEM_Context.state,
    .modules = {
#if defined(SYSTEM_WDG_MODULE)
        &SYSTEM_WDG_MODULE,
#endif
#if defined(SYSTEM_TIME_MODULE)
        &SYSTEM_TIME_MODULE,
#endif
#if defined(SYSTEM_IO_SERVICE)
        &SYSTEM_IO_SERVICE.client,
#endif
#if defined(SYSTEM_NVM_SERVICE)
        &SYSTEM_NVM_SERVICE.client,
#endif
#if defined(SYSTEM_CRYPTO_SERVICE)
        &SYSTEM_CRYPTO_SERVICE.client,
#endif
#if defined(SYSTEM_ETHERNET_SERVICE)
        &SYSTEM_ETHERNET_SERVICE.client,
#endif
#if defined(SYSTEM_RPC_MODULE)
        &SYSTEM_RPC_MODULE,
#endif
#if defined(SYSTEM_TC10_MODULE)
        &SYSTEM_TC10_MODULE,
#endif
#if defined(SYSTEM_IMGL_FETCH_MODULE)
        &SYSTEM_IMGL_FETCH_MODULE,
#endif
#if defined(SYSTEM_IMGL_UPDATE_MODULE)
        &SYSTEM_IMGL_UPDATE_MODULE,
#endif
#if defined(SYSTEM_DMON_MODULE)
            &SYSTEM_DMON_MODULE,
#endif
    },
};
/** @} */

