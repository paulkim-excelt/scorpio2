/*****************************************************************************
 Copyright 2022 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_nvm_service_design Design
    @ingroup grp_nvm_service_v2

    @addtogroup grp_nvm_service_design
    @{

    @file nvm_server.c
    @brief NVM Service Design
    This source file contains the Design details of NVM Service
    @version 0.1 Intiial Version
*/

#include <bcm_comp.h>
#include <bcm_err.h>
#include <compiler.h>
#include <nvm_service.h>
#include <nvm_service_osil.h>
#include <module_helper.h>
#ifdef ENABLE_FLASH_MODULE
#include <flash_module_osil.h>
#endif
#ifdef ENABLE_OTP_MODULE
#include <osil/otp_module_osil.h>
#endif

/**
    @name Design IDs
    @{
    @brief Design IDs for NVM
*/
#define BRCM_SWDSGN_NVM_CLIENT_CONTEXT_GLOBAL        (0xA301U)    /**< @brief #NVM_ClientContext      */
#define BRCM_SWDSGN_NVM_SERVER_CONTEXT_TYPE          (0xA302U)    /**< @brief #NVM_ServerContextType  */
#define BRCM_SWDSGN_NVM_SERVER_CONTEXT_GLOBAL        (0xA303U)    /**< @brief #NVM_ServerContext      */
#define BRCM_SWDSGN_NVM_CLIENT_RESET_HANDLER_PROC    (0xA304U)    /**< @brief #NVM_ClientStateHandler */
#define BRCM_SWDSGN_NVM_CLIENT_GET_EVENT_MASK_PROC   (0xA305U)    /**< @brief #NVM_ClientGetEventMask */
#define BRCM_SWDSGN_NVM_SERVER_SEND_CMD_PROC         (0xA306U)    /**< @brief #NVM_ServerSendCmd      */
#define BRCM_SWDSGN_NVM_SERVER_GET_RESP_PROC         (0xA307U)    /**< @brief #NVM_ServerGetResp      */
#define BRCM_SWDSGN_NVM_SERVER_MSGQ_GET_STATE        (0xA308U)    /**< @brief #NVM_ServerMsgQGetState */
#define BRCM_SWDSGN_NVM_SERVICE_GLOBAL               (0xA309U)    /**< @brief #NVM_Service            */
/** @} */

/**
    @brief Global client context for MODULE_ContextType

    @trace #BRCM_SWARCH_NVM_SERVICE_GLOBAL
    @trace #BRCM_SWREQ_NVM_SERVICE
 */
static MODULE_ContextType NVM_ClientContext COMP_SECTION(".bss.system.NVM_ClientContext");

/**
    @brief Server context for NVM

    @trace #BRCM_SWARCH_NVM_SERVICE_GLOBAL
    @trace #BRCM_SWREQ_NVM_SERVICE
 */
typedef struct sNVM_ServerContextType {
    MODULE_ContextType      modCtx;
    MSGQ_CtxType            stateMsgQCtx;
    BCM_StateType           state[MSGQ_SIZE];
} NVM_ServerContextType;

/**
    @brief Global server context for NVM_ServerContextType

    @trace #BRCM_SWARCH_NVM_SERVICE_GLOBAL
    @trace #BRCM_SWREQ_NVM_SERVICE
 */
static NVM_ServerContextType NVM_ServerContext COMP_SECTION(".bss.nvm.service.NVM_ServerContext");

/**
    @code{.c}
    return SERVICE_ClientHandler(&NVM_Service, aRequestedState)
    @endcode

    @trace #BRCM_SWARCH_NVM_SERVICE_GLOBAL
    @trace #BRCM_SWREQ_NVM_SERVICE
*/
static int32_t NVM_ClientStateHandler(BCM_StateType aRequestedState)
{
    return SERVICE_ClientHandler(&NVM_Service, aRequestedState);
}

/**
    @code{.c}
    return MODULE_Event
    @endcode

    @trace #BRCM_SWARCH_NVM_SERVICE_GLOBAL
    @trace #BRCM_SWREQ_NVM_SERVICE
*/
static uint32_t NVM_ClientGetEventMask(void)
{
    return MODULE_Event;
}

/**
    @code{.c}
    return MODULE_SendCmd(NVM_Service.modules, MODULE_COUNT_MAX, MODULE_MSG_CHECK_COMP_ID,
                          aCmd, aLen, aCmdData, aHandle, aForwardToSlaves)
    @endcode

    @trace #BRCM_SWARCH_NVM_SERVICE_GLOBAL
    @trace #BRCM_SWREQ_NVM_SERVICE
*/
static int32_t NVM_ServerSendCmd(BCM_CmdType aCmd, uint32_t aLen, const uint8_t *aCmdData,
                                BCM_HandleType *aHandle, uint32_t *aForwardToSlaves)
{
    return MODULE_SendCmd(NVM_Service.modules, MODULE_COUNT_MAX, MODULE_MSG_CHECK_COMP_ID,
                          aCmd, aLen, aCmdData, aHandle, aForwardToSlaves);
}

/**
    @code{.c}
    return MODULE_GetResp(NVM_Service.modules, MODULE_COUNT_MAX, MODULE_MSG_CHECK_COMP_ID,
                          aHandle, aReplyID, aInLen, aReplyData, aReplyDataLen)
    @endcode

    @trace #BRCM_SWARCH_NVM_SERVICE_GLOBAL
    @trace #BRCM_SWREQ_NVM_SERVICE
*/
static int32_t NVM_ServerGetResp(BCM_HandleType aHandle, BCM_CmdType aReplyID, uint32_t aInLen,
                                     uint8_t *aReplyData, uint32_t *aReplyDataLen)
{
    return MODULE_GetResp(NVM_Service.modules, MODULE_COUNT_MAX, MODULE_MSG_CHECK_COMP_ID,
                          aHandle, aReplyID, aInLen, aReplyData, aReplyDataLen);
}

/**
    @code{.c}
    return (void*)&NVM_ServerContext.state[i]
    @endcode

    @trace #BRCM_SWARCH_NVM_SERVICE_GLOBAL
    @trace #BRCM_SWREQ_NVM_SERVICE
*/
static void* NVM_ServerMsgQGetState(uint32_t i)
{
    return (void*)&NVM_ServerContext.state[i];
}
/** @} */

/**
    @addtogroup grp_nvm_service_ifc
    @{
*/

/**

    @code{.c}
    .group  = BCM_GROUPID_NVM,
    .client =
        .groupID           = BCM_GROUPID_NVM,
        .compID            = BCM_NVM_ID,
        .context           = &NVM_ClientContext,
        .resetStateHandler = NVM_ClientStateHandler,
        .initStateHandler  = NVM_ClientStateHandler,
        .readyStateHandler = NVM_ClientStateHandler,
        .runStateHandler   = NVM_ClientStateHandler,
        .getEventMask      = NVM_ClientGetEventMask,
        .cmdQ              = MSGQ_INIT_V2(NVM_GetServer, MSGQ_CLIENT_SIGNAL_ENABLE,
                                    BCM_StateType, MSGQ_SIZE, &NVM_ServerContext.stateMsgQCtx,
                                    NVM_ServerMsgQGetState),

    .server =
        .groupID           = BCM_GROUPID_NVM,
        .compID            = BCM_NVM_ID,
        .configImgID       = 0U,
        .configImgData     = NULL,
        .configImgSize     = 0UL,
        .context           = &NVM_ServerContext.modCtx,
        .eventHandler      = NULL,
        .getEventMask      = NULL,
        .sendCmd           = NVM_ServerSendCmd,
        .getResp           = NVM_ServerGetResp,

    .state = NVM_ServerContext.state,
    .modules =,
    @endcode

    @trace #BRCM_SWARCH_NVM_SERVICE_GLOBAL
    @trace #BRCM_SWREQ_NVM_SERVICE
*/
const SERVICE_Type NVM_Service = {
    .group  = BCM_GROUPID_NVM,
    .client = {
        .groupID           = BCM_GROUPID_NVM,
        .compID            = BCM_NVM_ID,
        .context           = &NVM_ClientContext,
        .resetStateHandler = NVM_ClientStateHandler,
        .initStateHandler  = NVM_ClientStateHandler,
        .readyStateHandler = NVM_ClientStateHandler,
        .runStateHandler   = NVM_ClientStateHandler,
        .getEventMask      = NVM_ClientGetEventMask,
        .cmdQ              = MSGQ_INIT_V2(NVM_GetServer, MSGQ_CLIENT_SIGNAL_ENABLE,
                                    BCM_StateType, MSGQ_SIZE, &NVM_ServerContext.stateMsgQCtx,
                                    NVM_ServerMsgQGetState),
    },
    .server = {
        .groupID           = BCM_GROUPID_NVM,
        .compID            = BCM_NVM_ID,
        .configImgID       = 0U,
        .configImgData     = NULL,
        .configImgSize     = 0UL,
        .context           = &NVM_ServerContext.modCtx,
        .eventHandler      = NULL,
        .getEventMask      = NVM_ClientGetEventMask,
        .sendCmd           = NVM_ServerSendCmd,
        .getResp           = NVM_ServerGetResp,
    },
    .state = NVM_ServerContext.state,
    .modules = {
#ifdef NVM_OTP_MODULE
        &NVM_OTP_MODULE,
#endif
#ifdef NVM_FLASH_MODULE
        &NVM_FLASH_MODULE,
#endif
    },
};
/** @} */
