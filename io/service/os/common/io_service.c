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
    @defgroup grp_iosrv_design Design
    @ingroup grp_iosrv

    @addtogroup grp_iosrv_design
    @{

    @file io_service.c
    @brief IO Service Design
    This source file contains the Design details of IO Service
    @version 0.1 Intiial Version
*/

#include <bcm_comp.h>
#include <bcm_err.h>
#include <compiler.h>
#include <io_service.h>
#include <io_service_osil.h>
#include <module_helper.h>
#include <io_module_osil.h>

/**
    @name Design IDs
    @{
    @brief Design IDs for IO Service
*/
#define BRCM_SWDSGN_IOS_SERVICE_CLIENT_CONTEXT_GLOBAL        (0xA101U)    /**< @brief #IOS_SERVICE_ClientContext      */
#define BRCM_SWDSGN_IOS_SERVICE_SERVER_CONTEXT_TYPE          (0xA102U)    /**< @brief #IOS_SERVICE_ServerContextType  */
#define BRCM_SWDSGN_IOS_SERVICE_SERVER_CONTEXT_GLOBAL        (0xA103U)    /**< @brief #IOS_SERVICE_ServerContext      */
#define BRCM_SWDSGN_IOS_SERVICE_CLIENT_RESET_HANDLER_PROC    (0xA104U)    /**< @brief #IOS_SERVICE_ClientStateHandler */
#define BRCM_SWDSGN_IOS_SERVICE_CLIENT_GET_EVENT_MASK_PROC   (0xA105U)    /**< @brief #IOS_SERVICE_ClientGetEventMask */
#define BRCM_SWDSGN_IOS_SERVICE_SERVER_GET_EVENT_MASK_PROC   (0xA106U)    /**< @brief #IOS_SERVICE_ServerGetEventMask */
#define BRCM_SWDSGN_IOS_SERVICE_SERVER_SEND_CMD_PROC         (0xA107U)    /**< @brief #IOS_SERVICE_ServerSendCmd      */
#define BRCM_SWDSGN_IOS_SERVICE_SERVER_GET_RESP_PROC         (0xA108U)    /**< @brief #IOS_SERVICE_ServerGetResp      */
#define BRCM_SWDSGN_IOS_SERVICE_SERVER_MSGQ_GET_STATE        (0xA109U)    /**< @brief #IOS_SERVICE_ServerMsgQGetState */
#define BRCM_SWDSGN_IOS_SERVICE_GLOBAL                       (0xA10AU)    /**< @brief #IOS_SERVICE                    */
/** @} */

/**
    @brief Global client context for MODULE_ContextType

    @trace #BRCM_SWARCH_IOS_SERVICE_GLOBAL
    @trace #BRCM_SWREQ_IOS_SERVICE
 */
static MODULE_ContextType IOS_SERVICE_ClientContext COMP_SECTION(".bss.system.IOS_SERVICE_ClientContext");

/**
    @brief Server context for IO

    @trace #BRCM_SWARCH_IOS_SERVICE_GLOBAL
    @trace #BRCM_SWREQ_IOS_SERVICE
 */
typedef struct sIOS_SERVICE_ServerContextType {
    MODULE_ContextType      modCtx;
    MSGQ_CtxType            stateMsgQCtx;
    BCM_StateType           state[MSGQ_SIZE];
} IOS_SERVICE_ServerContextType;

/**
    @brief Global server context for IOS_SERVICE_ServerContextType

    @trace #BRCM_SWARCH_IOS_SERVICE_GLOBAL
    @trace #BRCM_SWREQ_IOS_SERVICE
 */
static IOS_SERVICE_ServerContextType IOS_SERVICE_ServerContext COMP_SECTION(".bss.io.service.IOS_SERVICE_ServerContext");

/**
    @code{.c}
    return SERVICE_ClientHandler(&IOS_SERVICE, aRequestedState)
    @endcode

    @trace #BRCM_SWARCH_IOS_SERVICE_GLOBAL
    @trace #BRCM_SWREQ_IOS_SERVICE
*/
static int32_t IOS_SERVICE_ClientStateHandler(BCM_StateType aRequestedState)
{
    return SERVICE_ClientHandler(&IOS_SERVICE, aRequestedState);
}

/**
    @code{.c}
    return MODULE_Event
    @endcode

    @trace #BRCM_SWARCH_IOS_SERVICE_GLOBAL
    @trace #BRCM_SWREQ_IOS_SERVICE
*/
static uint32_t IOS_SERVICE_ClientGetEventMask(void)
{
    return MODULE_Event;
}

/**
    @code{.c}
    return MODULE_Event
    @endcode

    @trace #BRCM_SWARCH_IOS_SERVICE_GLOBAL
    @trace #BRCM_SWREQ_IOS_SERVICE
*/
static uint32_t IOS_SERVICE_ServerGetEventMask(void)
{
    return MODULE_Event;
}

/**
    @code{.c}
    return MODULE_SendCmd(IOS_SERVICE.modules, MODULE_COUNT_MAX, MODULE_MSG_CHECK_COMP_ID,
                          aCmd, aLen, aCmdData, aHandle, aForwardToSlaves)
    @endcode

    @trace #BRCM_SWARCH_IOS_SERVICE_GLOBAL
    @trace #BRCM_SWREQ_IOS_SERVICE
*/
static int32_t IOS_SERVICE_ServerSendCmd(BCM_CmdType aCmd, uint32_t aLen, const uint8_t *aCmdData,
                                BCM_HandleType *aHandle, uint32_t *aForwardToSlaves)
{
    return MODULE_SendCmd(IOS_SERVICE.modules, MODULE_COUNT_MAX, MODULE_MSG_CHECK_COMP_ID,
                          aCmd, aLen, aCmdData, aHandle, aForwardToSlaves);
}

/**
    @code{.c}
    return MODULE_GetResp(IOS_SERVICE.modules, MODULE_COUNT_MAX, MODULE_MSG_CHECK_COMP_ID,
                          aHandle, aReplyID, aInLen, aReplyData, aReplyDataLen)
    @endcode

    @trace #BRCM_SWARCH_IOS_SERVICE_GLOBAL
    @trace #BRCM_SWREQ_IOS_SERVICE
*/
static int32_t IOS_SERVICE_ServerGetResp(BCM_HandleType aHandle, BCM_CmdType aReplyID, uint32_t aInLen,
                                     uint8_t *aReplyData, uint32_t *aReplyDataLen)
{
    return MODULE_GetResp(IOS_SERVICE.modules, MODULE_COUNT_MAX, MODULE_MSG_CHECK_COMP_ID,
                          aHandle, aReplyID, aInLen, aReplyData, aReplyDataLen);
}

/**
    @code{.c}
    return (void*)&IOS_SERVICE_ServerContext.state[i]
    @endcode

    @trace #BRCM_SWARCH_IOS_SERVICE_GLOBAL
    @trace #BRCM_SWREQ_IOS_SERVICE
*/
static void* IOS_SERVICE_ServerMsgQGetState(uint32_t i)
{
    return (void*)&IOS_SERVICE_ServerContext.state[i];
}
/** @} */

/**
    @addtogroup grp_iosrv_ifc
    @{
*/

/**
    @code{.c}
    .group  = BCM_GROUPID_IO,
    .client =
        .groupID           = BCM_GROUPID_IO,
        .compID            = BCM_IOS_ID,
        .context           = &IOS_SERVICE_ClientContext,
        .resetStateHandler = IOS_SERVICE_ClientStateHandler,
        .initStateHandler  = IOS_SERVICE_ClientStateHandler,
        .readyStateHandler = IOS_SERVICE_ClientStateHandler,
        .runStateHandler   = IOS_SERVICE_ClientStateHandler,
        .getEventMask      = IOS_SERVICE_ClientGetEventMask,
        .cmdQ              = MSGQ_INIT_V2(IOS_SERVICE_GetServer, MSGQ_CLIENT_SIGNAL_ENABLE,
                                    BCM_StateType, MSGQ_SIZE, &IOS_SERVICE_ServerContext.stateMsgQCtx,
                                    IOS_SERVICE_ServerMsgQGetState),

    .server =
        .groupID           = BCM_GROUPID_IO,
        .compID            = BCM_IOS_ID,
        .configImgID       = 0U,
        .configImgData     = NULL,
        .configImgSize     = 0UL,
        .context           = &IOS_SERVICE_ServerContext.modCtx,
        .eventHandler      = NULL,
        .getEventMask      = IOS_SERVICE_ServerGetEventMask,
        .sendCmd           = IOS_SERVICE_ServerSendCmd,
        .getResp           = IOS_SERVICE_ServerGetResp,

    .state = IOS_SERVICE_ServerContext.state,
    .modules =,
    @endcode

    @trace #BRCM_SWARCH_IOS_SERVICE_GLOBAL
    @trace #BRCM_SWREQ_IOS_SERVICE
*/
const SERVICE_Type IOS_SERVICE = {
    .group  = BCM_GROUPID_IO,
    .client = {
        .groupID           = BCM_GROUPID_IO,
        .compID            = BCM_IOS_ID,
        .context           = &IOS_SERVICE_ClientContext,
        .resetStateHandler = IOS_SERVICE_ClientStateHandler,
        .initStateHandler  = IOS_SERVICE_ClientStateHandler,
        .readyStateHandler = IOS_SERVICE_ClientStateHandler,
        .runStateHandler   = IOS_SERVICE_ClientStateHandler,
        .getEventMask      = IOS_SERVICE_ClientGetEventMask,
        .cmdQ              = MSGQ_INIT_V2(IOS_SERVICE_GetServer, MSGQ_CLIENT_SIGNAL_ENABLE,
                                    BCM_StateType, MSGQ_SIZE, &IOS_SERVICE_ServerContext.stateMsgQCtx,
                                    IOS_SERVICE_ServerMsgQGetState),
    },
    .server = {
        .groupID           = BCM_GROUPID_IO,
        .compID            = BCM_IOS_ID,
        .configImgID       = 0U,
        .configImgData     = NULL,
        .configImgSize     = 0UL,
        .context           = &IOS_SERVICE_ServerContext.modCtx,
        .eventHandler      = NULL,
        .getEventMask      = IOS_SERVICE_ServerGetEventMask,
        .sendCmd           = IOS_SERVICE_ServerSendCmd,
        .getResp           = IOS_SERVICE_ServerGetResp,
    },
    .state = IOS_SERVICE_ServerContext.state,
    .modules = {
#ifdef IOS_IOM_MODULE
        &IOS_IOM_MODULE,
#endif
    },
};
/** @} */
