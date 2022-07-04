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
    @defgroup grp_crypto_service_design Design
    @ingroup grp_crypto_service

    @addtogroup grp_crypto_service_design
    @{

    @file crypto_server.c
    @brief Crypto Service Design
    This source file contains the Design details of Crypto Service
    @version 0.1 Intiial Version
*/

#include <bcm_comp.h>
#include <bcm_err.h>
#include <compiler.h>
#include <crypto_service.h>
#include <module_helper.h>
#include <crypto_osil.h>

/**
    @name Design IDs
    @{
    @brief Design IDs
*/
#define BRCM_SWDSGN_CRYPTO_CLIENT_CONTEXT_GLOBAL        (0xA000U)    /**< @brief #CRYPTO_ClientContext      */
#define BRCM_SWDSGN_CRYPTO_SERVER_CONTEXT_TYPE          (0xA001U)    /**< @brief #CRYPTO_ServerContextType  */
#define BRCM_SWDSGN_CRYPTO_SERVER_CONTEXT_GLOBAL        (0xA002U)    /**< @brief #CRYPTO_ServerContext      */
#define BRCM_SWDSGN_CRYPTO_CLIENT_RESET_HANDLER_PROC    (0xA003U)    /**< @brief #CRYPTO_ClientStateHandler */
#define BRCM_SWDSGN_CRYPTO_CLIENT_GET_EVENT_MASK_PROC   (0xA007U)    /**< @brief #CRYPTO_ClientGetEventMask */
#define BRCM_SWDSGN_CRYPTO_SERVER_SEND_CMD_PROC         (0xA008U)    /**< @brief #CRYPTO_ServerSendCmd      */
#define BRCM_SWDSGN_CRYPTO_SERVER_GET_RESP_PROC         (0xA009U)    /**< @brief #CRYPTO_ServerGetResp      */
#define BRCM_SWDSGN_CRYPTO_SERVER_MSGQ_GET_STATE        (0xA00AU)    /**< @brief #CRYPTO_ServerMsgQGetState */
#define BRCM_SWDSGN_CRYPTO_SERVICE_GLOBAL               (0xA010U)    /**< @brief #CRYPTO_Service            */
/** @} */

/**
    @trace #BRCM_SWARCH_CRYPTO_SERVICE_GLOBAL
    @trace #BRCM_SWREQ_CRYPTO_SERVICE
*/
static MODULE_ContextType CRYPTO_ClientContext COMP_SECTION(".bss.system.CRYPTO_ClientContext");

/**
    @trace #BRCM_SWARCH_CRYPTO_SERVICE_GLOBAL
    @trace #BRCM_SWREQ_CRYPTO_SERVICE
*/
typedef struct sCRYPTO_ServerContextType {
    MODULE_ContextType      modCtx;
    MSGQ_CtxType            stateMsgQCtx;
    BCM_StateType           state[MSGQ_SIZE];
} CRYPTO_ServerContextType;

/**
    @trace #BRCM_SWARCH_CRYPTO_SERVICE_GLOBAL
    @trace #BRCM_SWREQ_CRYPTO_SERVICE
*/
static CRYPTO_ServerContextType CRYPTO_ServerContext COMP_SECTION(".bss.crypto.service.CRYPTO_ServerContext");

/**
    @trace #BRCM_SWARCH_CRYPTO_SERVICE_GLOBAL
    @trace #BRCM_SWREQ_CRYPTO_SERVICE

    @code{.unparsed}
    SERVICE_ClientHandler(&CRYPTO_Server, aRequestedState)
    @endcode
*/
static int32_t CRYPTO_ClientStateHandler(BCM_StateType aRequestedState)
{
    return SERVICE_ClientHandler(&CRYPTO_Service, aRequestedState);
}

/**
    @trace #BRCM_SWARCH_CRYPTO_SERVICE_GLOBAL
    @trace #BRCM_SWREQ_CRYPTO_SERVICE

    @code{.unparsed}
    return MODULE_Event
    @endcode
*/
static uint32_t CRYPTO_ClientGetEventMask(void)
{
    return MODULE_Event;
}

/**
    @trace #BRCM_SWARCH_CRYPTO_SERVICE_GLOBAL
    @trace #BRCM_SWREQ_CRYPTO_SERVICE
*/
static int32_t CRYPTO_ServerSendCmd(BCM_CmdType aCmd, uint32_t aLen, const uint8_t *aCmdData,
                                BCM_HandleType *aHandle, uint32_t *aForwardToSlaves)
{
    return MODULE_SendCmd(CRYPTO_Service.modules, MODULE_COUNT_MAX, MODULE_MSG_CHECK_COMP_ID,
                    aCmd, aLen, aCmdData, aHandle, aForwardToSlaves);
}

/**
    @trace #BRCM_SWARCH_CRYPTO_SERVICE_GLOBAL
    @trace #BRCM_SWREQ_CRYPTO_SERVICE
*/
static int32_t CRYPTO_ServerGetResp(BCM_HandleType aHandle, BCM_CmdType aReplyID, uint32_t aInLen,
                                     uint8_t *aReplyData, uint32_t *aReplyDataLen)
{
    return MODULE_GetResp(CRYPTO_Service.modules, MODULE_COUNT_MAX, MODULE_MSG_CHECK_COMP_ID,
                            aHandle, aReplyID, aInLen, aReplyData, aReplyDataLen);
}

/**
    @brief CRYPTO state transition commands helper for MSGQ

    @trace #BRCM_SWARCH_CRYPTO_SERVICE_GLOBAL
    @trace #BRCM_SWREQ_CRYPTO_SERVICE
*/
static void* CRYPTO_ServerMsgQGetState(uint32_t i)
{
    return (void*)&CRYPTO_ServerContext.state[i];
}
/** @} */

/**
    @addtogroup grp_crypto_service_ifc
    @{
*/
/**
    @trace #BRCM_SWARCH_CRYPTO_SERVICE_GLOBAL
    @trace #BRCM_SWREQ_CRYPTO_SERVICE
*/
const SERVICE_Type CRYPTO_Service = {
    .group  = BCM_GROUPID_CRYPTO,
    .client = {
        .groupID           = BCM_GROUPID_CRYPTO,
        .compID            = BCM_CRS_ID,
        .context           = &CRYPTO_ClientContext,
        .resetStateHandler = CRYPTO_ClientStateHandler,
        .initStateHandler  = CRYPTO_ClientStateHandler,
        .readyStateHandler = CRYPTO_ClientStateHandler,
        .runStateHandler   = CRYPTO_ClientStateHandler,
        .getEventMask      = CRYPTO_ClientGetEventMask,
        .cmdQ              = MSGQ_INIT_V2(CRYPTO_GetServer, MSGQ_CLIENT_SIGNAL_ENABLE,
                                    BCM_StateType, MSGQ_SIZE, &CRYPTO_ServerContext.stateMsgQCtx,
                                    CRYPTO_ServerMsgQGetState),
    },
    .server = {
        .groupID           = BCM_GROUPID_CRYPTO,
        .compID            = BCM_CRS_ID,
        .configImgID       = 0U,
        .configImgData     = NULL,
        .configImgSize     = 0UL,
        .context           = &CRYPTO_ServerContext.modCtx,
#ifdef ENABLE_CRYPTO_SERVICE_STATE_HANDLER
        .resetStateHandler = CRYPTO_ServiceResetStateHandler,
        .readyStateHandler = CRYPTO_ServiceReadyStateHandler,
#endif
#ifdef ENABLE_CRYPTO_SERVICE_EVENT_HANDLER
        .eventHandler      = CRYPTO_ServiceEventHandler,
        .getEventMask      = CRYPTO_ServiceGetEventMask,
#endif
        .sendCmd           = CRYPTO_ServerSendCmd,
        .getResp           = CRYPTO_ServerGetResp,
    },
    .state = CRYPTO_ServerContext.state,
    .modules = {
        &CRYPTO_VerifyModule,
#ifdef CRYPTO_SECY_MODULE
        &CRYPTO_SECY_MODULE,
#endif
    },
};

/** @} */
