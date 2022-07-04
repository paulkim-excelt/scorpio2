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

#include "ee.h"
#include <string.h>
#include <ulog.h>
#include <bcm_utils.h>
#include <bcm_test.h>
#include <osil/bcm_osil.h>
#include <module.h>
#include <module_helper.h>

extern int32_t Module_ExecuteIt(uint32_t aTestIdx);
extern int32_t Module_GetStatusIt(uint32_t aTestIdx);

#define BCM_MOD_IMG_SIZE       (1024UL)

void SERVICE1_GetDetails(int32_t *task, uint32_t *event)
{
    *task = SERVICE1_Task;
    *event = MODULE_EVENT;
}

typedef struct sMODULE_TestContextType {
    MODULE_ContextType  modCtx;
    uint32_t            resetVal;
    uint32_t            initVal;
    uint32_t            readyVal;
    uint32_t            runVal;
    MSGQ_CtxType        msgQContext;
    uint32_t            msgs[MSGQ_SIZE];
    uint8_t             config[BCM_MOD_IMG_SIZE];
} MODULE_TestContextType;

uint32_t MODULE_Counter;
/******************************  MODULE 1  ************************************/
extern const MODULE_Type MOD1_Ifc;
MODULE_TestContextType MOD1_Context;
int32_t MOD1_ResetStateHandler(BCM_StateType aRequestedState)
{
    MOD1_Context.resetVal = MODULE_Counter++;
    return BCM_ERR_OK;
}

int32_t MOD1_InitStateHandler(BCM_StateType aRequestedState)
{
    MOD1_Context.initVal = MODULE_Counter++;
    return BCM_ERR_OK;
}

int32_t MOD1_ReadyStateHandler(BCM_StateType aRequestedState)
{
    MOD1_Context.readyVal = MODULE_Counter++;
    return BCM_ERR_OK;
}

int32_t MOD1_RunStateHandler(BCM_StateType aRequestedState)
{
    MOD1_Context.runVal = MODULE_Counter++;
    return BCM_ERR_OK;
}

uint32_t MOD1_GetEventMask()
{
    return MODULE_EVENT;
}

void MOD1_EventHandler(uint32_t aMask)
{
    int32_t retVal;
    uint32_t idx = 0UL;
    retVal = MSGQ_GetMsgIdx(&MOD1_Ifc.cmdQ, &idx);
    while (BCM_ERR_OK == retVal) {
        MOD1_Context.msgs[idx] = MOD1_Ifc.compID;
        MSGQ_CompleteMsgIdx(&MOD1_Ifc.cmdQ, idx);
        retVal = MSGQ_GetMsgIdx(&MOD1_Ifc.cmdQ, &idx);
    }
}

int32_t MOD1_SendCmd(BCM_CmdType aCmd, uint32_t aLen, const uint8_t *aCmdData,
                        BCM_HandleType *aHandle, uint32_t *aForwardToSlaves)
{
    MSGQ_SendMsgv2(&MOD1_Ifc.cmdQ, aCmdData, MODULE_Event, aHandle);
    return BCM_ERR_OK;
}

int32_t MOD1_GetResp(BCM_HandleType aHandle, BCM_CmdType aReplyID, uint32_t aInLen,
                        uint8_t *aReplyData, uint32_t *aReplyDataLen)
{
    return MSGQ_RecvMsgv2(&MOD1_Ifc.cmdQ, aHandle, aReplyData);
}

int32_t MOD1_MergeResult(BCM_CmdType aCmd, uint32_t aLen,
                            uint8_t *aOutResponse, int32_t *aOutResult,
                            const uint8_t *aInResponse1, int32_t aInResult1,
                            const uint8_t *aInResponse2, int32_t aInResult2)
{
    return BCM_ERR_OK;
}

void* MOD1_GetMsg(uint32_t i)
{
    return (void*)&MOD1_Context.msgs[i];
}
const MODULE_Type MOD1_Ifc = {
    .groupID           = 01U,
    .compID            = 0x0101U,
#ifdef MODULE_EN_LOAD_CFG_TEST
    .configImgID       = 0xFF00U,
    .configImgData     = MOD1_Context.config,
    .configImgSize     = BCM_MOD_IMG_SIZE,
#endif /* MODULE_EN_LOAD_CFG_TEST */
    .context           = &MOD1_Context.modCtx,
    .resetStateHandler = MOD1_ResetStateHandler,
    .initStateHandler  = MOD1_InitStateHandler,
    .readyStateHandler = MOD1_ReadyStateHandler,
    .runStateHandler   = MOD1_RunStateHandler,
    .eventHandler      = MOD1_EventHandler,
    .sendCmd           = MOD1_SendCmd,
    .getResp           = MOD1_GetResp,
    .mergeResult       = MOD1_MergeResult,
    .getEventMask      = MOD1_GetEventMask,
    .processCmd        = NULL,
    .cmdQ              = MSGQ_INIT_V2(SERVICE1_GetDetails, MSGQ_CLIENT_SIGNAL_ENABLE,
                                    uint32_t , MSGQ_SIZE, &MOD1_Context.msgQContext, MOD1_GetMsg),
};

/******************************************************************************/

/******************************  MODULE 2  ************************************/
extern const MODULE_Type MOD2_Ifc;
MODULE_TestContextType MOD2_Context;
int32_t MOD2_ResetStateHandler(BCM_StateType aRequestedState)
{
    MOD2_Context.resetVal = MODULE_Counter++;
    return BCM_ERR_OK;
}

int32_t MOD2_InitStateHandler(BCM_StateType aRequestedState)
{
    MOD2_Context.initVal = MODULE_Counter++;
    return BCM_ERR_OK;
}

int32_t MOD2_ReadyStateHandler(BCM_StateType aRequestedState)
{
    MOD2_Context.readyVal = MODULE_Counter++;
    return BCM_ERR_OK;
}

int32_t MOD2_RunStateHandler(BCM_StateType aRequestedState)
{
    MOD2_Context.runVal = MODULE_Counter++;
    return BCM_ERR_OK;
}

uint32_t MOD2_GetEventMask()
{
    return MODULE_EVENT;
}

void MOD2_EventHandler(uint32_t aMask)
{
    int32_t retVal;
    uint32_t idx = 0UL;
    retVal = MSGQ_GetMsgIdx(&MOD2_Ifc.cmdQ, &idx);
    while (BCM_ERR_OK == retVal) {
        MOD2_Context.msgs[idx] = MOD2_Ifc.compID;
        MSGQ_CompleteMsgIdx(&MOD2_Ifc.cmdQ, idx);
        retVal = MSGQ_GetMsgIdx(&MOD2_Ifc.cmdQ, &idx);
    }
}

int32_t MOD2_SendCmd(BCM_CmdType aCmd, uint32_t aLen, const uint8_t *aCmdData,
                        BCM_HandleType *aHandle, uint32_t *aForwardToSlaves)
{
    MSGQ_SendMsgv2(&MOD2_Ifc.cmdQ, aCmdData, MODULE_Event, aHandle);
    return BCM_ERR_OK;
}

int32_t MOD2_GetResp(BCM_HandleType aHandle, BCM_CmdType aReplyID, uint32_t aInLen,
                        uint8_t *aReplyData, uint32_t *aReplyDataLen)
{
    return MSGQ_RecvMsgv2(&MOD2_Ifc.cmdQ, aHandle, aReplyData);
}

int32_t MOD2_MergeResult(BCM_CmdType aCmd, uint32_t aLen,
                            uint8_t *aOutResponse, int32_t *aOutResult,
                            const uint8_t *aInResponse1, int32_t aInResult1,
                            const uint8_t *aInResponse2, int32_t aInResult2)
{
    return BCM_ERR_OK;
}

void* MOD2_GetMsg(uint32_t i)
{
    return (void*)&MOD2_Context.msgs[i];
}

const MODULE_Type MOD2_Ifc = {
    .groupID           = 01U,
    .compID            = 0x0102U,
#ifdef MODULE_EN_LOAD_CFG_TEST
    .configImgID       = 0xFF01U,
    .configImgData     = MOD2_Context.config,
    .configImgSize     = BCM_MOD_IMG_SIZE,
#endif /* MODULE_EN_LOAD_CFG_TEST */
    .context           = &MOD2_Context.modCtx,
    .resetStateHandler = MOD2_ResetStateHandler,
    .initStateHandler  = MOD2_InitStateHandler,
    .readyStateHandler = MOD2_ReadyStateHandler,
    .runStateHandler   = MOD2_RunStateHandler,
    .eventHandler      = MOD2_EventHandler,
    .sendCmd           = MOD2_SendCmd,
    .getResp           = MOD2_GetResp,
    .mergeResult       = MOD2_MergeResult,
    .getEventMask      = MOD2_GetEventMask,
    .processCmd        = NULL,
    .cmdQ              = MSGQ_INIT_V2(SERVICE1_GetDetails, MSGQ_CLIENT_SIGNAL_ENABLE,
                                    uint32_t , MSGQ_SIZE, &MOD2_Context.msgQContext, MOD2_GetMsg),
};

/******************************************************************************/

/******************************  MODULE 3  ************************************/
extern const MODULE_Type MOD3_Ifc;
MODULE_TestContextType MOD3_Context;
int32_t MOD3_ResetStateHandler(BCM_StateType aRequestedState)
{
    MOD3_Context.resetVal = MODULE_Counter++;
    return BCM_ERR_OK;
}

int32_t MOD3_InitStateHandler(BCM_StateType aRequestedState)
{
    MOD3_Context.initVal = MODULE_Counter++;
    return BCM_ERR_OK;
}

int32_t MOD3_ReadyStateHandler(BCM_StateType aRequestedState)
{
    MOD3_Context.readyVal = MODULE_Counter++;
    return BCM_ERR_OK;
}

int32_t MOD3_RunStateHandler(BCM_StateType aRequestedState)
{
    MOD3_Context.runVal = MODULE_Counter++;
    return BCM_ERR_OK;
}

uint32_t MOD3_GetEventMask()
{
    return MODULE_EVENT;
}

void MOD3_EventHandler(uint32_t aMask)
{
    int32_t retVal;
    uint32_t idx = 0UL;
    retVal = MSGQ_GetMsgIdx(&MOD3_Ifc.cmdQ, &idx);
    while (BCM_ERR_OK == retVal) {
        MOD3_Context.msgs[idx] = MOD3_Ifc.compID;
        MSGQ_CompleteMsgIdx(&MOD3_Ifc.cmdQ, idx);
        retVal = MSGQ_GetMsgIdx(&MOD3_Ifc.cmdQ, &idx);
    }
}

int32_t MOD3_SendCmd(BCM_CmdType aCmd, uint32_t aLen, const uint8_t *aCmdData,
                        BCM_HandleType *aHandle, uint32_t *aForwardToSlaves)
{
    MSGQ_SendMsgv2(&MOD3_Ifc.cmdQ, aCmdData, MODULE_Event, aHandle);
    return BCM_ERR_OK;
}

int32_t MOD3_GetResp(BCM_HandleType aHandle, BCM_CmdType aReplyID, uint32_t aInLen,
                        uint8_t *aReplyData, uint32_t *aReplyDataLen)
{
    return MSGQ_RecvMsgv2(&MOD3_Ifc.cmdQ, aHandle, aReplyData);
}

int32_t MOD3_MergeResult(BCM_CmdType aCmd, uint32_t aLen,
                            uint8_t *aOutResponse, int32_t *aOutResult,
                            const uint8_t *aInResponse1, int32_t aInResult1,
                            const uint8_t *aInResponse2, int32_t aInResult2)
{
    return BCM_ERR_OK;
}

void* MOD3_GetMsg(uint32_t i)
{
    return (void*)&MOD3_Context.msgs[i];
}

const MODULE_Type MOD3_Ifc = {
    .groupID           = 01U,
    .compID            = 0x0103U,
#ifdef MODULE_EN_LOAD_CFG_TEST
    .configImgID       = 0xFF02U,
    .configImgData     = MOD3_Context.config,
    .configImgSize     = BCM_MOD_IMG_SIZE,
#endif /* MODULE_EN_LOAD_CFG_TEST */
    .context           = &MOD3_Context.modCtx,
    .resetStateHandler = MOD3_ResetStateHandler,
    .initStateHandler  = MOD3_InitStateHandler,
    .readyStateHandler = MOD3_ReadyStateHandler,
    .runStateHandler   = MOD3_RunStateHandler,
    .eventHandler      = MOD3_EventHandler,
    .sendCmd           = MOD3_SendCmd,
    .getResp           = MOD3_GetResp,
    .mergeResult       = MOD3_MergeResult,
    .getEventMask      = MOD3_GetEventMask,
    .processCmd        = NULL,
    .cmdQ              = MSGQ_INIT_V2(SERVICE1_GetDetails, MSGQ_CLIENT_SIGNAL_ENABLE,
                                    uint32_t , MSGQ_SIZE, &MOD3_Context.msgQContext, MOD3_GetMsg),
};

/******************************************************************************/

/******************************  SERVICE 1  ***********************************/
extern const SERVICE_Type SERVICE1_Ifc;
MSGQ_CtxType SERVICE1_StateContext;
BCM_StateType SERVICE1_State[MSGQ_SIZE];
MODULE_TestContextType SERVICE1_ClientContext;
MODULE_TestContextType SERVICE1_ServerContext;
int32_t SERVICE1_ClientResetStateHandler(BCM_StateType aRequestedState)
{
    return SERVICE_ClientHandler(&SERVICE1_Ifc, BCM_STATE_INIT);
}

int32_t SERVICE1_ClientInitStateHandler(BCM_StateType aRequestedState)
{
return SERVICE_ClientHandler(&SERVICE1_Ifc, BCM_STATE_READY);
}

int32_t SERVICE1_ClientReadyStateHandler(BCM_StateType aRequestedState)
{
    return SERVICE_ClientHandler(&SERVICE1_Ifc, BCM_STATE_RUN);
}

int32_t SERVICE1_ClientRunStateHandler(BCM_StateType aRequestedState)
{
    return SERVICE_ClientHandler(&SERVICE1_Ifc, BCM_STATE_UNINIT);
}

int32_t SERVICE1_ServerResetStateHandler(BCM_StateType aRequestedState)
{
    SERVICE1_ServerContext.resetVal = MODULE_Counter++;
    return BCM_ERR_OK;
}

int32_t SERVICE1_ServerInitStateHandler(BCM_StateType aRequestedState)
{
    SERVICE1_ServerContext.initVal = MODULE_Counter++;
    return BCM_ERR_OK;
}

int32_t SERVICE1_ServerReadyStateHandler(BCM_StateType aRequestedState)
{
    SERVICE1_ServerContext.readyVal = MODULE_Counter++;
    return BCM_ERR_OK;
}

int32_t SERVICE1_ServerRunStateHandler(BCM_StateType aRequestedState)
{
    SERVICE1_ServerContext.runVal = MODULE_Counter++;
    return BCM_ERR_OK;
}

uint32_t SERVICE1_GetEventMask()
{
    return MODULE_EVENT;
}

int32_t SERVICE1_SendCmd(BCM_CmdType aCmd, uint32_t aLen, const uint8_t *aCmdData,
                        BCM_HandleType *aHandle, uint32_t *aForwardToSlaves)
{
    return BCM_ERR_NOMEM;
}

int32_t SERVICE1_GetResp(BCM_HandleType aHandle, BCM_CmdType aReplyID, uint32_t aInLen,
                        uint8_t *aReplyData, uint32_t *aReplyDataLen)
{
    return BCM_ERR_BUSY;
}

int32_t SERVICE1_MergeResult(BCM_CmdType aCmd, uint32_t aLen,
                            uint8_t *aOutResponse, int32_t *aOutResult,
                            const uint8_t *aInResponse1, int32_t aInResult1,
                            const uint8_t *aInResponse2, int32_t aInResult2)
{
    return BCM_ERR_OK;
}

void* SERVICE1_GetMsg(uint32_t i)
{
    return (void*)&SERVICE1_State[i];
}

const SERVICE_Type SERVICE1_Ifc = {
    .group           = 01U,
    .client = {
        .groupID           = 01U,
        .compID            = 0x0100U,
        .context           = &SERVICE1_ClientContext.modCtx,
        .resetStateHandler = SERVICE1_ClientResetStateHandler,
        .initStateHandler  = SERVICE1_ClientInitStateHandler,
        .readyStateHandler = SERVICE1_ClientReadyStateHandler,
        .runStateHandler   = SERVICE1_ClientRunStateHandler,
        .getEventMask      = SERVICE1_GetEventMask,
        .cmdQ              = MSGQ_INIT_V2(SERVICE1_GetDetails, MSGQ_CLIENT_SIGNAL_ENABLE,
                                        BCM_StateType , MSGQ_SIZE, &SERVICE1_StateContext, SERVICE1_GetMsg),
    },
    .server = {
        .groupID           = 01U,
        .compID            = 0x0100U,
        .context           = &SERVICE1_ServerContext.modCtx,
        .resetStateHandler = SERVICE1_ServerResetStateHandler,
        .initStateHandler  = SERVICE1_ServerInitStateHandler,
        .readyStateHandler = SERVICE1_ServerReadyStateHandler,
        .runStateHandler   = SERVICE1_ServerRunStateHandler,
        .sendCmd           = SERVICE1_SendCmd,
        .getResp           = SERVICE1_GetResp,
        .mergeResult       = SERVICE1_MergeResult,
        .getEventMask      = SERVICE1_GetEventMask,
        .processCmd        = NULL,
    },
    .state = SERVICE1_State,
    .modules = {
        &MOD1_Ifc,
        &MOD2_Ifc,
        &MOD3_Ifc,
    }
};

TASK(SERVICE1_Task)
{
    SERVICE_ServerTaskFunc(&SERVICE1_Ifc, SERVICE1_Task);
}
/******************************************************************************/

int32_t MODULE_TestResult;
TASK(BCM_MODTestTask)
{
    int32_t  retVal;
    MODULE_Counter = 0UL;
    const MODULE_Type * module = &SERVICE1_Ifc.client;
    MODULE_TestResult = BCM_AT_EXECUTING;
    /* Validate state transitions (UNINIT->INIT)*/
    retVal = MODULE_ResetStateHandler(&module, 1UL);
    while (BCM_ERR_BUSY == retVal) {
        BCM_WaitEvent(MODULE_Event);
        BCM_ClearEvent(MODULE_Event);
        retVal = MODULE_ResetStateHandler(&module, 1UL);
    }
    if ((BCM_ERR_OK != retVal)
        || (SERVICE1_ClientContext.modCtx.state != BCM_STATE_INIT)) {
        goto err_exit;
    }
    if ((MOD1_Context.resetVal != 0UL)
        || (MOD2_Context.resetVal != 1UL)
        || (MOD3_Context.resetVal != 2UL)
        || (SERVICE1_ServerContext.resetVal != 3UL)) {
        retVal = BCM_ERR_UNKNOWN;
        goto err_exit;
    }

    /* Validate state transitions (UNINIT->READY)*/
    retVal = MODULE_InitStateHandler(&module, 1UL);
    while (BCM_ERR_BUSY == retVal) {
        BCM_WaitEvent(MODULE_Event);
        BCM_ClearEvent(MODULE_Event);
        retVal = MODULE_InitStateHandler(&module, 1UL);
    }

#ifdef MODULE_EN_LOAD_CFG_TEST
    if ((BCM_ERR_OK != retVal)
        || (SERVICE1_ClientContext.modCtx.state != BCM_STATE_READY)
        || (BCM_MOD_IMG_SIZE != MOD1_Ifc.context->cfgLoadSize)
        || (BCM_MOD_IMG_SIZE != MOD2_Ifc.context->cfgLoadSize)
        || (BCM_MOD_IMG_SIZE != MOD3_Ifc.context->cfgLoadSize)) {
        retVal = BCM_ERR_UNKNOWN;
        goto err_exit;
    }
#else /* MODULE_EN_LOAD_CFG_TEST */
    if ((BCM_ERR_OK != retVal)
        || (SERVICE1_ClientContext.modCtx.state != BCM_STATE_READY)) {
        retVal = BCM_ERR_UNKNOWN;
        goto err_exit;
    }
#endif /* MODULE_EN_LOAD_CFG_TEST */

    if ((MOD1_Context.initVal != 4UL)
        || (MOD2_Context.initVal != 5UL)
        || (MOD3_Context.initVal != 6UL)
        || (SERVICE1_ServerContext.initVal != 7UL)) {
        retVal = BCM_ERR_UNKNOWN;
        goto err_exit;
    }

    /* Validate state transitions (READY->RUN)*/
    retVal = MODULE_ReadyStateHandler(&module, 1UL, BCM_STATE_RUN);
    while (BCM_ERR_BUSY == retVal) {
        BCM_WaitEvent(MODULE_Event);
        BCM_ClearEvent(MODULE_Event);
        retVal = MODULE_ReadyStateHandler(&module, 1UL, BCM_STATE_RUN);
    }
    if ((BCM_ERR_OK != retVal)
        || (SERVICE1_ClientContext.modCtx.state != BCM_STATE_RUN)) {
        goto err_exit;
    }
    if ((MOD1_Context.readyVal != 8UL)
        || (MOD2_Context.readyVal != 9UL)
        || (MOD3_Context.readyVal != 10UL)
        || (SERVICE1_ServerContext.readyVal != 11UL)) {
        retVal = BCM_ERR_UNKNOWN;
        goto err_exit;
    }

    /* Validate state transitions (RUN->READY)*/
    retVal = MODULE_RunStateHandler(&module, 1UL, BCM_STATE_UNINIT);
    while (BCM_ERR_BUSY == retVal) {
        BCM_WaitEvent(MODULE_Event);
        BCM_ClearEvent(MODULE_Event);
        retVal = MODULE_RunStateHandler(&module, 1UL, BCM_STATE_UNINIT);
    }
    if ((BCM_ERR_OK != retVal)
        || (SERVICE1_ClientContext.modCtx.state != BCM_STATE_UNINIT)) {
        goto err_exit;
    }
    if ((MOD1_Context.runVal != 14UL)
        || (MOD2_Context.runVal != 13UL)
        || (MOD3_Context.runVal != 12UL)
        || (SERVICE1_ServerContext.runVal != 15UL)) {
        retVal = BCM_ERR_UNKNOWN;
        goto err_exit;
    }


err_exit:
    MODULE_TestResult = retVal;
    BCM_TerminateTask();
    return;
}

int32_t BCM_ExecuteAT(uint32_t aIndex)
{
    int32_t retVal = BCM_AT_NOT_STARTED;

    if (1UL == aIndex) {
        if (BCM_AT_EXECUTING != MODULE_TestResult) {
            retVal = BCM_ActivateTask(BCM_MODTestTask);
            if (BCM_ERR_OK == retVal) {
            } else {
                retVal = BCM_AT_NOT_STARTED;
            }
        }
#ifdef ENABLE_MODULE_IT
    } else if (0x1001UL == aIndex) {
        retVal = Module_ExecuteIt(aIndex);
#endif
    } else {
        retVal = BCM_AT_NOT_AVAILABLE;
    }

    return retVal;
}

int32_t BCM_GetResultAT(uint32_t aIndex)
{
    int32_t retVal = BCM_AT_NOT_AVAILABLE;

    if (1UL == aIndex) {
        retVal = MODULE_TestResult;
#ifdef ENABLE_MODULE_IT
    } else if (0x1001UL == aIndex) {
        retVal = Module_GetStatusIt(aIndex);
#endif
    }
    return retVal;
}

void APP_Init()
{
}
