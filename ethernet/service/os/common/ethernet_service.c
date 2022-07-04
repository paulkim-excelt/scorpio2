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
    @defgroup grp_ethernet_service_impl Ethernet Service Design
    @ingroup grp_ethsrv_sw

    @addtogroup grp_ethernet_service_impl
    @{
    @file ethernet_service.c
    @brief Ethernet Service Design
    This source file contains the design of Ethernet Service
    @version 0.1 Initial version
*/

#include <bcm_osil.h>
#include <bcm_utils.h>
#include <ethernet_service.h>
#include <ethernet_osil.h>
#include <module.h>
#include <module_helper.h>
#include <bcm_utils.h>
#include <ethutils.h>

#ifdef ENABLE_ETH
#include "nif_cntrlr.h"
#endif

#ifdef ENABLE_INET
#include "inet.h"
#endif

#ifdef ENABLE_ETH_TIME
#include "ettm.h"
#endif

#ifdef ENABLE_ETHXCVRM
#include "ethxcvrm.h"
#endif

#ifdef ENABLE_ETS
#include "etsm.h"
#endif

#ifdef ETHSWTM_COREMODULE
#include <ethswtm_core.h>
#endif

#ifdef ETHSWTM_VLANMODULE
#include <ethswtm_vlan.h>
#endif

#ifdef ETHSWTM_ARLMODULE
#include <ethswtm_arl.h>
#endif

#ifdef ETHSWTM_CFPMODULE
#include <ethswtm_cfp.h>
#endif

#ifdef ETHSWTM_EXTMODULE
#include <ethswtm_ext.h>
#endif

#ifdef ETHSWTM_DEBUGMODULE
#include <ethswtm_debug.h>
#endif

#ifdef ETHSWTM_FAMODULE
#include <ethswtm_fa.h>
#endif

/**
    @name Ethsrv RPC Design IDs
    @{
    @brief Design IDs for Ethsrv RPC
*/
#define BRCM_SWDSGN_ETHERNET_CONTEXT_TYPE               (0xA202) /**< @brief #ETHERNET_ContextType       */
#define BRCM_SWDSGN_ETHERNET_CLIENT_CONTEXT_GLOBAL      (0xA203) /**< @brief #ETHERNET_ClientContext     */
#define BRCM_SWDSGN_ETHERNET_SERVER_CONTEXT_GLOBAL      (0xA204) /**< @brief #ETHERNET_ServerContext     */
#define BRCM_SWDSGN_ETHERNET_REPORTERROR_PROC           (0xA205) /**< @brief #ETHERNET_ReportError       */
#define BRCM_SWDSGN_ETHERNET_CLIENT_STATE_HANDLER_PROC  (0xA206) /**< @brief #ETHERNET_ClientStateHandler*/
#define BRCM_SWDSGN_ETHERNET_SEND_CMD_PROC              (0xA207) /**< @brief #ETHERNET_SendCmd           */
#define BRCM_SWDSGN_ETHERNET_GET_RESP_PROC              (0xA208) /**< @brief #ETHERNET_GetResp           */
#define BRCM_SWDSGN_ETHERNET_MERGE_RESULT_PROC          (0xA209) /**< @brief #ETHERNET_MergeResult       */
#define BRCM_SWDSGN_ETHERNET_ASYNC_MSG_PROC             (0xA20A) /**< @brief #ETHERNET_AsyncMsg          */
#define BRCM_SWDSGN_ETHERNET_GET_EVENT_MASK_PROC        (0xA20B) /**< @brief #ETHERNET_GetEventMask      */
#define BRCM_SWDSGN_ETHERNET_EVENT_HANDLER_PROC         (0xA20C) /**< @brief #ETHERNET_EventHandler      */
#define BRCM_SWDSGN_ETHERNET_MSGQ_GET_STATE_PROC        (0xA20D) /**< @brief #ETHERNET_MsgQGetState      */
#define BRCM_SWDSGN_ETHERNET_MSGQ_GET_CMD_PROC          (0xA20E) /**< @brief #ETHERNET_MsgQGetCmd        */
#define BRCM_SWDSGN_ETHERNET_SERVICE_GLOBAL             (0xA20F) /**< @brief #ETHERNET_Service           */
/** @} */

/**
    @brief Command-Response structure for command queue

    @trace #BRCM_SWARCH_ETHERNET_SERVICE_GLOBAL
    @trace #BRCM_SWREQ_ETHERNET_TASK
*/
typedef struct sETHERNET_ContextType {
    MODULE_ContextType      modCtx;             /**< @brief Module context      */
    uint32_t                isEthUtilsInited;
    MSGQ_CtxType            stateMsgQCtx;
    BCM_StateType           state[MSGQ_SIZE];
} ETHERNET_ContextType ;

/**
    @brief Command-Response structure for command queue

    @trace #BRCM_SWARCH_ETHERNET_SERVICE_GLOBAL
    @trace #BRCM_SWREQ_ETHERNET_TASK
*/
static MODULE_ContextType ETHERNET_ClientContext COMP_SECTION(".bss.system.service.ETHERNET_ClientContext") ;

/**
    @brief Memory for RPC MsgQ

    @trace #BRCM_SWARCH_ETHERNET_SERVICE_GLOBAL
    @trace #BRCM_SWREQ_ETHERNET_TASK
*/
static ETHERNET_ContextType ETHERNET_ServerContext COMP_SECTION(".bss.ethernet.service.ETHERNET_ServerContext") ;

/**
    @brief ETHERNET Client State Handler

    @trace #BRCM_SWARCH_ETHERNET_SERVICE_GLOBAL
    @trace #BRCM_SWREQ_ETHERNET_TASK
*/
static int32_t ETHERNET_ClientStateHandler(BCM_StateType aRequestedState)
{
    return SERVICE_ClientHandler(&ETHERNET_Service, aRequestedState);
}

/**
    API used to report error.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aApiID    API ID
    @param[in]      aErr      Error
    @param[in]      aVal0     Value of variable
    @param[in]      aVal1     Value of variable
    @param[in]      aVal2     Value of variable
    @param[in]      aVal3     Value of variable

    @return         void

    @post None

    @code{.unparsed}
    values[4UL] = {aVal0, aVal1, aVal2, aVal3}
    BCM_ReportError((BCM_COM_ID & BCM_LOGMASK_USER), 0U, aApiID, aErr, 4UL,
                    values)
    @endcode

    @trace #BRCM_SWARCH_ETHERNET_SERVICE_GLOBAL
    @trace #BRCM_SWREQ_ETHERNET_TASK
*/
#ifdef ENABLE_ETHSRV_CMDS
static void ETHERNET_ReportError(uint16_t aApiID, int32_t aErr, uint32_t aVal0,
                        uint32_t aVal1, uint32_t aVal2, uint32_t aVal3)
{
    const uint32_t values[4UL] = {aVal0, aVal1, aVal2, aVal3};
    BCM_ReportError((BCM_COM_ID & BCM_LOGMASK_USER), 0U, aApiID,
                    aErr, 4UL, values);
}

/** @brief Send commands to ETHERNET task

    This API queues the management commands to ethsrv module

    @behavior Sync, Re-entrant

    @pre None

    @param[in]   aCmd                   Command group, component and ID
    @param[in]   aCmdDataLen            Length of the command data payload in bytes
    @param[in]   aCmdData               Pointer to the command data payload
    @param[out]  aHandle                Pointer to BCM_HandleType for later query
                                        using #BCM_ModGetStatusType
    @param[out]  aForwardToSlaves       Boolean to indicate if command needs to be
                                        forwarded to connected slaves

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK     Command posted successfully

    @post None

    @trace #BRCM_SWARCH_ETHERNET_SERVICE_GLOBAL
    @trace #BRCM_SWREQ_ETHERNET_TASK

    @limitations This API may not be supported on all the chipsets
*/
static int32_t ETHERNET_SendCmd(BCM_CmdType aCmd, uint32_t aLen, const uint8_t *aCmdData,
                                        BCM_HandleType *aHandle, uint32_t *aForwardToSlaves)
{
    int32_t retVal = BCM_ERR_OK;
    uint8_t cmdId = (uint8_t)BCM_GET_CMDID(aCmd);
    BCM_CompIDType compID = (uint16_t)BCM_GET_COMP(aCmd);
    BCM_CmdType cmd;

    if ((aCmdData == NULL) || (aHandle == NULL)
        || (aForwardToSlaves == NULL) || (ETHERNET_MEM_MSG_PAYLOAD_SZ < aLen)){
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        cmd = BCM_CMDID(BCM_GROUPID_ETHSRV,compID,cmdId);
        retVal = MODULE_SendCmd(ETHERNET_Service.modules, MODULE_COUNT_MAX, MODULE_MSG_CHECK_COMP_ID,
                                cmd, aLen, aCmdData, aHandle, aForwardToSlaves);
    }

    if (BCM_ERR_OK != retVal) {
        ETHERNET_ReportError(BRCM_SWDSGN_ETHERNET_SEND_CMD_PROC, retVal,(uint32_t) (MODULE_Event),
                          (uint32_t) aHandle, cmdId, compID);
    }

    return retVal;
}

/** @brief Retreive status of management commands from ETHERNET task

    This API queries the status of completed management commands which were
    previously issued to ethsrv task

    @behavior Sync, Re-entrant

    @pre None

    @param[in]   aHandle                BCM Handle to retrieve response for
    @param[in]   aReplyID               Reply ID (group, comp, cmd)
    @param[in]   aInLen                 Available Length of the reply data payload in bytes
    @param[out]  aReplyData             Pointer to the reply data payload
    @param[out]  aReplyDataLen          Actual Length of the reply data payload in bytes

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK     Command status retrieved successfully

    @post None

    @trace #BRCM_SWARCH_ETHERNET_SERVICE_GLOBAL
    @trace #BRCM_SWREQ_ETHERNET_TASK

    @limitations This API may not be supported on all the chipsets
*/
static int32_t ETHERNET_GetResp(BCM_HandleType aHandle, BCM_CmdType aReplyID, uint32_t aInLen,
                                uint8_t *aReplyData, uint32_t *aReplyDataLen)
{
    int32_t  retVal = BCM_ERR_OK;

    if ((0ULL == aHandle) || (aReplyData == NULL) || (aReplyDataLen == NULL)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        retVal = MODULE_GetResp(ETHERNET_Service.modules, MODULE_COUNT_MAX, MODULE_MSG_CHECK_COMP_ID,
                                aHandle, aReplyID, aInLen, aReplyData, aReplyDataLen);
    }

    if ((BCM_ERR_OK != retVal) && (BCM_ERR_BUSY != retVal)) {
        ETHERNET_ReportError(BRCM_SWDSGN_ETHERNET_GET_RESP_PROC, retVal,(uint32_t) (MODULE_Event),
                             (uint32_t) aHandle, aReplyID, (uint32_t)aReplyDataLen);
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_ETHERNET_SERVICE_GLOBAL
    @trace #BRCM_SWREQ_ETHERNET_TASK
*/
static int32_t ETHERNET_MergeResult(BCM_CmdType aCmd,
                           uint32_t aLen,
                           uint8_t * aOutResponse,
                           int32_t * aOutResult,
                           const uint8_t * aInResponse1,
                           int32_t aInResult1,
                           const uint8_t * aInResponse2,
                           int32_t aInResult2)
{
    int32_t retVal = BCM_ERR_OK;

    if ((NULL == aOutResponse) || (NULL == aOutResult)
        || (NULL == aInResponse1) || (NULL == aInResponse2)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        retVal = MODULE_MergeResult(ETHERNET_Service.modules, MODULE_COUNT_MAX, MODULE_MSG_CHECK_COMP_ID,
                                    aCmd,  aLen, aOutResponse, aOutResult,
                                    aInResponse1, aInResult1, aInResponse2, aInResult2);
    }
    return retVal;
}

/**
    @trace #BRCM_SWARCH_ETHERNET_SERVICE_GLOBAL
    @trace #BRCM_SWREQ_ETHERNET_TASK
*/
static int32_t ETHERNET_AsyncMsg(BCM_CmdType aNotfn, const uint8_t *aMsg,
                               uint32_t aLen, uint32_t *aForwardToHost)
{
    return BCM_ERR_OK;
}


/**
    @trace #BRCM_SWARCH_ETHERNET_SERVICE_GLOBAL
    @trace #BRCM_SWREQ_ETHERNET_TASK
*/
uint32_t ETHERNET_GetEventMask(void)
{
    return MODULE_Event;
}

/**
    @trace #BRCM_SWARCH_ETHERNET_SERVICE_GLOBAL
    @trace #BRCM_SWREQ_ETHERNET_TASK
*/
static void ETHERNET_EventHandler(uint32_t aMask)
{
    if (FALSE == ETHERNET_ServerContext.isEthUtilsInited) {
        ETHUTILS_Init();
        ETHERNET_ServerContext.isEthUtilsInited = TRUE;
    }
    MODULE_EventHandler(ETHERNET_Service.modules, MODULE_COUNT_MAX, aMask);
    return;
}
#endif

/**
    @brief Fetch the command message based on index

    @trace #BRCM_SWARCH_ETHERNET_SERVICE_GLOBAL
    @trace #BRCM_SWREQ_ETHERNET_TASK
*/
static void* ETHERNET_MsgQGetState(uint32_t idx)
{
    return (void *)(&ETHERNET_ServerContext.state[idx]);
}

/**
    @trace #BRCM_SWARCH_ETHERNET_SERVICE_GLOBAL
    @trace #BRCM_SWREQ_ETHERNET_TASK
*/
const SERVICE_Type ETHERNET_Service= {
    .group  = BCM_GROUPID_ETHSRV,
    .client = {
        .groupID            = BCM_GROUPID_ETHSRV,
        .compID             = BCM_COM_ID,
        .context            = &ETHERNET_ClientContext,
        .resetStateHandler  = ETHERNET_ClientStateHandler,
        .initStateHandler   = ETHERNET_ClientStateHandler,
        .readyStateHandler  = ETHERNET_ClientStateHandler,
        .runStateHandler    = ETHERNET_ClientStateHandler,
        .cmdQ               = MSGQ_INIT_V2(ETHERNET_GetServer, MSGQ_CLIENT_SIGNAL_ENABLE,
                                    BCM_StateType, MSGQ_SIZE, &ETHERNET_ServerContext.stateMsgQCtx,
                                    ETHERNET_MsgQGetState),
    },
    .server = {
        .groupID           = BCM_GROUPID_ETHSRV,
        .compID            = BCM_COM_ID,
        .configImgID       = 0UL,
        .configImgData     = NULL,
        .configImgSize     = 0UL,
        .context           = &ETHERNET_ServerContext.modCtx,
#ifdef ENABLE_ETHSRV_CMDS
        .eventHandler      = ETHERNET_EventHandler,
        .sendCmd           = ETHERNET_SendCmd,
        .getResp           = ETHERNET_GetResp,
        .mergeResult       = ETHERNET_MergeResult,
        .asyncMsg          = ETHERNET_AsyncMsg,
        .getEventMask      = ETHERNET_GetEventMask,
#endif
    },
    .state = ETHERNET_ServerContext.state,
    .modules = {
#ifdef ETHSRV_ETHER_MODULE
        &ETHSRV_ETHER_MODULE,
#endif
#ifdef ETHSRV_INET_MODULE
        &ETHSRV_INET_MODULE,
#endif
#ifdef ETHSRV_ETHXCVR_MODULE
        &ETHSRV_ETHXCVR_MODULE,
#endif
#ifdef ETHSRV_ETT_MODULE
        &ETHSRV_ETT_MODULE,
#endif
#ifdef ETHSWTM_COREMODULE
        &ETHSWTM_COREMODULE,
#endif
#ifdef ETHSWTM_VLANMODULE
        &ETHSWTM_VLANMODULE,
#endif
#ifdef ETHSWTM_ARLMODULE
        &ETHSWTM_ARLMODULE,
#endif
#ifdef ETHSWTM_CFPMODULE
        &ETHSWTM_CFPMODULE,
#endif
#ifdef ETHSWTM_EXTMODULE
        &ETHSWTM_EXTMODULE,
#endif
#ifdef ETHSWTM_DEBUGMODULE
        &ETHSWTM_DEBUGMODULE,
#endif
#ifdef ETHSWTM_FAMODULE
        &ETHSWTM_FAMODULE,
#endif
#ifdef ETHSRV_ETS_MODULE
        &ETHSRV_ETS_MODULE,
#endif
    },
};

/** @} */
