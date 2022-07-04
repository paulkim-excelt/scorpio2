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
    @defgroup grp_imgl_update_mod_impl Imgl update module Implementation
    @ingroup grp_imgl

    @addtogroup grp_imgl_update_mod_impl
    @{

    @file imgl_update_mod.c
    @brief module design for IMGL update module

    @version 0.1 Initial version
*/

#include <bcm_err.h>
#include <stdlib.h>
#include <module.h>
#include <system_state.h>
#include <imgl.h>
#include <imgl_osil.h>
#include <mcu.h>
#include <system_imgl.h>
#include <bcm_utils.h>
#include <imgl_mod.h>
#include <imgl_lib.h>
#include <system_service_osil.h>
#include <module_osil.h>

/**
    @name IMGL update module design IDs
    @{
    @brief Design IDs for IMGL update module

*/
#define BRCM_SWDSGN_IMGL_UPDATE_MODCONTEXT_TYPE            (0xB801U)    /**< @brief #IMGL_UpdateModContextType    */
#define BRCM_SWDSGN_IMGL_UPDATE_MODCONTEXT_GLOBAL          (0xB802U)    /**< @brief #IMGL_UpdateModContext        */
#define BRCM_SWDSGN_IMGL_UPDATE_MODULE_GLOBAL              (0xB803U)    /**< @brief #IMGL_UpdateModule            */
#define BRCM_SWDSGN_IMGL_UPDATE_RESETSTATE_HANDLER_PROC    (0xB804U)    /**< @brief #IMGL_UpdateResetStateHandler */
#define BRCM_SWDSGN_IMGL_UPDATE_EVENTHANDLER_PROC          (0xB808U)    /**< @brief #IMGL_UpdateEventHandler      */
#define BRCM_SWDSGN_IMGL_UPDATE_SEND_CMD_PROC              (0xB809U)    /**< @brief #IMGL_UpdateSendCmd           */
#define BRCM_SWDSGN_IMGL_UPDATE_MERGE_RESULT_PROC          (0xB80AU)    /**< @brief #IMGL_UpdateMergeResult       */
#define BRCM_SWDSGN_IMGL_UPDATE_PROCESS_CMD_PROC           (0xB80BU)    /**< @brief #IMGL_UpdateProcessCommand    */
#define BRCM_SWDSGN_IMGL_UPDATE_GET_EVENTMASK_PROC         (0xB80DU)    /**< @brief #IMGL_UpdateGetEventMask      */
#define BRCM_SWDSGN_IMGL_UPDATE_INITSTATE_HANDLER_PROC     (0xB80EU)    /**< @brief #IMGL_UpdateInitStateHandler  */
#define BRCM_SWDSGN_IMGL_UPDATE_READYSTATE_HANDLER_PROC    (0xB80FU)    /**< @brief #IMGL_UpdateReadyStateHandler */
#define BRCM_SWDSGN_IMGL_RPC_MSG_COUNT_MACRO               (0xB810U)    /**< @brief #IMGL_RPC_MSG_COUNT           */
#define BRCM_SWDSGN_IMGL_MSGQ_GET_CMD_PROC                 (0xB811U)    /**< @brief #IMGL_MsgQGetCmd              */
#define BRCM_SWDSGN_IMGL_UPDATE_GET_RESP_PROC              (0xB812U)    /**< @brief #IMGL_UpdateGetResp           */

/** @} */

/**
    @brief IMGL RPC Message Count

    @trace #BRCM_SWARCH_IMGL_UPDATE_MOD_GLOBAL
    @trace #BRCM_SWREQ_IMGL_CORE
*/
#define IMGL_RPC_MSG_COUNT      (4UL)

/**
    @brief IMGL Module context

    @trace #BRCM_SWARCH_IMGL_UPDATE_MOD_GLOBAL
    @trace #BRCM_SWREQ_IMGL_CORE
*/
typedef struct sIMGL_UpdateModContextType {
    MODULE_ContextType      innerContext;
    MCU_InfoType            stackingInfo;
    IMGL_CfgContextType     cfgContext;
    IMGL_UpdateContextType  updateContext;

    BCM_SubStateType        cmdState;
    MSGQ_CtxType            rpcMsgQCtx;
    IMGL_MsgType            rpcCmds[IMGL_RPC_MSG_COUNT];
} IMGL_UpdateModContextType;

/**
    @brief IMGL Module context

    @trace #BRCM_SWARCH_IMGL_UPDATE_MOD_GLOBAL
    @trace #BRCM_SWREQ_IMGL_CORE
*/
static IMGL_UpdateModContextType IMGL_UpdateModContext COMP_SECTION(".bss.imgl");

/**
    @code{.unparsed}
    loop till state change
        if imglModContext->subState BCM_STATE_SUB_STATE_RESET
            MCU_GetInfo(&stackingInfo)
            ret=IMGL_CfgInit()
            if ret is BCM_ERR_OK
                ret = BCM_ERR_BUSY
                imglModContext->subState = BCM_STATE_SUB_STATE_STAGE0
        if imglModContext->subState BCM_STATE_SUB_STATE_STAGE0
            retVal = IMGL_CfgGet();
            if ret is BCM_ERR_OK
                ret = BCM_ERR_BUSY
                imglModContext->subState = BCM_STATE_SUB_STATE_STAGE1
        if imglModContext->subState BCM_STATE_SUB_STATE_STAGE1
            retVal = IMGL_CfgGetStatus();
            if ret is not BCM_ERR_OK and ret is not BCM_ERR_BUSY
                imglModContext->subState = BCM_STATE_SUB_STATE_STAGE0

    if ret is not BCM_ERR_BUSY:
        imglModContext->subState = BCM_STATE_SUB_STATE_RESET

    @endcode

    @trace #BRCM_SWARCH_IMGL_UPDATE_MOD_GLOBAL
    @trace #BRCM_SWREQ_IMGL_CORE
*/
static int32_t IMGL_UpdateResetStateHandler(BCM_StateType aRequestedState)
{
    int32_t retVal = BCM_ERR_UNKNOWN;
    uint32_t prevState;
    MODULE_ContextType *imglModContext = IMGL_UpdateModule.context;

    do {
        prevState = imglModContext->subState;
        switch(imglModContext->subState) {
            case BCM_STATE_SUB_STATE_RESET:
                (void)MCU_GetInfo(&IMGL_UpdateModContext.stackingInfo);
                retVal = IMGL_CfgInit(&IMGL_UpdateModContext.cfgContext);
                if (BCM_ERR_OK != retVal) {
                    retVal = BCM_ERR_UNKNOWN;
                } else {
                    retVal = BCM_ERR_BUSY;
                    imglModContext->subState = BCM_STATE_SUB_STATE_STAGE0;
                }
                break;
            case BCM_STATE_SUB_STATE_STAGE0:
                retVal = IMGL_CfgGet(&IMGL_UpdateModContext.cfgContext);
                if (BCM_ERR_OK != retVal) {
                    imglModContext->subState = BCM_STATE_SUB_STATE_RESET;
                } else {
                    retVal = BCM_ERR_BUSY;
                    imglModContext->subState = BCM_STATE_SUB_STATE_STAGE1;
                }
                break;
            case BCM_STATE_SUB_STATE_STAGE1:
                retVal = IMGL_CfgGetStatus(&IMGL_UpdateModContext.cfgContext);
                if ((BCM_ERR_OK != retVal) && (BCM_ERR_BUSY != retVal)) {
                    imglModContext->subState = BCM_STATE_SUB_STATE_STAGE0;
                }
                break;
            default:
                break;
        }
    } while(prevState != imglModContext->subState);

    if (BCM_ERR_BUSY != retVal) {
        imglModContext->subState = BCM_STATE_SUB_STATE_RESET;
    }

    return retVal;
}

/**
    @code{.unparsed}
        return IMGL_UpdateInit()
    @endcode

    @trace #BRCM_SWARCH_IMGL_UPDATE_MOD_GLOBAL
    @trace #BRCM_SWREQ_IMGL_CORE
*/
static int32_t IMGL_UpdateInitStateHandler(BCM_StateType aRequestedState)
{
    int32_t retVal = BCM_ERR_OK;
    if ((0UL == IMGL_UpdateModContext.stackingInfo.stackingEn)
        || ((1UL == IMGL_UpdateModContext.stackingInfo.stackingEn)
            && (MCU_DEVICE_MASTER == IMGL_UpdateModContext.stackingInfo.mstSlvMode))) {

        retVal = IMGL_UpdateInit(&IMGL_UpdateModContext.updateContext, &IMGL_UpdateModContext.cfgContext);

        if (BCM_ERR_OK != retVal) {
            retVal = BCM_ERR_UNKNOWN;
        }
    }

    return retVal;
}

/**
    @code{.unparsed}
        return IMGL_UpdateStatus()
    @endcode

    @trace #BRCM_SWARCH_IMGL_UPDATE_MOD_GLOBAL
    @trace #BRCM_SWREQ_IMGL_CORE
*/
static int32_t IMGL_UpdateReadyStateHandler(BCM_StateType aRequestedState)
{
    int32_t retVal = BCM_ERR_OK;
    if ((0UL == IMGL_UpdateModContext.stackingInfo.stackingEn)
        || ((1UL == IMGL_UpdateModContext.stackingInfo.stackingEn)
            && (MCU_DEVICE_MASTER == IMGL_UpdateModContext.stackingInfo.mstSlvMode))) {
        retVal = IMGL_UpdateStatus(&IMGL_UpdateModContext.updateContext, &IMGL_UpdateModContext.cfgContext);

        if ((BCM_ERR_OK != retVal) && (BCM_ERR_BUSY != retVal)) {
            retVal = BCM_ERR_UNKNOWN;
        }
    }

    return retVal;
}

/**
    @code{.unparsed}
    cmdID = BCM_GET_CMDID(aCmd)
    switch (cmdID)
        case SYS_CMDID_FLASH_UPDATE:
            if aCmdStatus == BCM_ERR_UNINIT
                IMGL_UpdateRequest(IMGL_LOAD_MODE_RPC)
                retVal = BCM_ERR_BUSY
            else
                IMGL_UpdateStatus()
                retVal = BCM_ERR_OK
            break;
    return retVal
    @endcode

    @trace #BRCM_SWARCH_IMGL_UPDATE_MOD_GLOBAL
    @trace #BRCM_SWREQ_IMGL_CORE
*/
static int32_t IMGL_UpdateProcessCommand(uint32_t aIdx)
{
    int32_t retVal =BCM_ERR_UNKNOWN;
    IMGL_MsgType *msg = &IMGL_UpdateModContext.rpcCmds[aIdx];
    uint32_t cmdID = msg->id;
    BCM_SubStateType *cmdState = &IMGL_UpdateModContext.cmdState;

    switch (cmdID) {
        case IMGL_ID_UPDATE_AUTO_SYNC:
            if (BCM_STATE_SUB_STATE_RESET == *cmdState) {
                IMGL_UpdateReqType request ={0};
                uint32_t i;

                retVal = BCM_ERR_INVAL_PARAMS;
                for (i = 0UL; i < msg->u.updateAutoSync.numImgs; i++) {
                    request.pid[i] = msg->u.updateAutoSync.imgHdr[i].pid;
                    request.imgID[i] = msg->u.updateAutoSync.imgHdr[i].imgID;
                }
                request.numImgs = msg->u.updateAutoSync.numImgs;
                request.channel = msg->u.updateAutoSync.flashId;
                retVal = IMGL_UpdateRequest(&IMGL_UpdateModContext.updateContext, &IMGL_UpdateModContext.cfgContext, IMGL_LOAD_MODE_RPC, msg->u.updateAutoSync.fetchChannel, &request);
                if (BCM_ERR_OK == retVal) {
                    retVal = BCM_ERR_BUSY;
                    *cmdState = BCM_STATE_SUB_STATE_STAGE0;
                } else if (BCM_ERR_EAGAIN == retVal) {
                    retVal = BCM_ERR_BUSY;
                } else {
                    *cmdState = BCM_STATE_SUB_STATE_RESET;
                }
            } else if (BCM_STATE_SUB_STATE_STAGE0 == *cmdState) {
                retVal = IMGL_UpdateStatus(&IMGL_UpdateModContext.updateContext, &IMGL_UpdateModContext.cfgContext);
                if ((BCM_ERR_OK != retVal) && (BCM_ERR_BUSY != retVal)) {
                    *cmdState = BCM_STATE_SUB_STATE_RESET;
                } else if (BCM_ERR_OK == retVal) {
                    *cmdState = BCM_STATE_SUB_STATE_RESET;
                } else {
                }
            }
            break;
        default:
            retVal = BCM_ERR_NOSUPPORT;
            break;
    }

    return retVal;
}

/**
    @code{.unparsed}
    *aForwardToSlaves = FALSE
    *aHandle = TRUE

    return BCM_ERR_OK
    @endcode

    @trace #BRCM_SWARCH_IMGL_UPDATE_MOD_GLOBAL
    @trace #BRCM_SWREQ_IMGL_CORE
*/
static int32_t IMGL_UpdateSendCmd(BCM_CmdType    aCmd,
                                    uint32_t        aCmdDataLen,
                                    const uint8_t   *aCmdData,
                                    BCM_HandleType  *aHandle,
                                    uint32_t        *aForwardToSlaves)
{
    int32_t         retVal = BCM_ERR_OK;
    IMGL_MsgType    msg = {0};

    if ((aCmdData == NULL) || (aForwardToSlaves == NULL)
        || (aHandle == NULL) || (IMGL_MSG_MAX_SIZE < aCmdDataLen)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        /* Map the incoming request */
        msg.id      = aCmd;
        msg.status  = BCM_ERR_UNINIT;
        msg.len     = aCmdDataLen;
        BCM_MemCpy(msg.u.data, aCmdData, aCmdDataLen);
        *aForwardToSlaves = FALSE;
        retVal = MSGQ_SendMsgv2(&IMGL_UpdateModule.cmdQ, (uint8_t*)&msg, MODULE_Event, aHandle);
    }

    return retVal;
}

/** @brief Retreive status of commands submitted via #IMGL_UpdateSendCmd

    Archicture is as described in #MODULE_GetRespType

    @trace #BRCM_SWARCH_IMGL_UPDATE_MOD_GLOBAL
    @trace #BRCM_SWREQ_IMGL_CORE

    @limitations This API may not be supported on all the chipsets
*/
static int32_t IMGL_UpdateGetResp(BCM_HandleType aHandle, BCM_CmdType aReplyID, uint32_t aInLen,
                                     uint8_t *aReplyData, uint32_t *aReplyDataLen)
{
    int32_t         retVal = BCM_ERR_OK;
    IMGL_MsgType    msg = {0};

    if (((0ULL == aHandle) || (aReplyData == NULL)
        || (aReplyDataLen == NULL)) || (aInLen < IMGL_MSG_MAX_SIZE)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        retVal = MSGQ_RecvMsgv2(&IMGL_UpdateModule.cmdQ, aHandle, (uint8_t*)&msg);
        if (BCM_ERR_OK == retVal) {
            /* Copy the response payload */
            BCM_MemCpy(aReplyData, msg.u.data, msg.len);
            *aReplyDataLen = msg.len;
        }
    }

    return retVal;
}

/**
    @code{.unparsed}
    return BCM_ERR_OK
    @endcode

    @trace #BRCM_SWARCH_IMGL_UPDATE_MOD_GLOBAL
    @trace #BRCM_SWREQ_IMGL_CORE
*/
static int32_t IMGL_UpdateMergeResult(BCM_CmdType aCmd,
                                    uint32_t aLen,
                                    uint8_t *aOutResponse,
                                    int32_t *aOutResult,
                                    const uint8_t *aInResponse1,
                                    int32_t aInResult1,
                                    const uint8_t *aInResponse2,
                                    int32_t aInResult2)
{
    return BCM_ERR_OK;
}

/**
    @code{.unparsed}
    if IMGL_GetEventMask() & aMask
        IMGL_CfgHandler()
        IMGL_UpdateStatus()
    @endcode

    @trace #BRCM_SWARCH_IMGL_UPDATE_MOD_GLOBAL
    @trace #BRCM_SWREQ_IMGL_CORE
*/
static void IMGL_UpdateEventHandler(uint32_t aMask)
{
    int32_t retVal;

    if (0UL != (IMGL_GetEventMask() & aMask)) {
        IMGL_CfgHandler(&IMGL_UpdateModContext.cfgContext);
        IMGL_UpdateStatus(&IMGL_UpdateModContext.updateContext, &IMGL_UpdateModContext.cfgContext);
    }

    do {
        uint32_t index = 0UL;
        retVal = MSGQ_GetMsgIdx(&IMGL_UpdateModule.cmdQ, &index);
        if(BCM_ERR_OK == retVal) {
            retVal = IMGL_UpdateProcessCommand(index);
            if (BCM_ERR_BUSY != retVal) {
                retVal = MSGQ_CompleteMsgIdx(&IMGL_UpdateModule.cmdQ, index);
            }
        }
    } while(BCM_ERR_OK == retVal);
}

/**
    @code{.unparsed}
    return IMGL_GetEventMask()
    @endcode

    @trace #BRCM_SWARCH_IMGL_UPDATE_MOD_GLOBAL
    @trace #BRCM_SWREQ_IMGL_CORE
*/
static uint32_t IMGL_UpdateGetEventMask(void)
{
    return IMGL_GetEventMask();
}

/**
    @brief IMGL RPC Cmds helper for MSGQ

    @trace #BRCM_SWARCH_IMGL_UPDATE_MOD_GLOBAL
    @trace #BRCM_SWREQ_IMGL_CORE
*/
static void* IMGL_MsgQGetCmd(uint32_t i)
{
    return (void*)&IMGL_UpdateModContext.rpcCmds[i];
}

/**
    @brief Imgl module Info

    @trace #BRCM_SWARCH_IMGL_UPDATE_MOD_GLOBAL
    @trace #BRCM_SWREQ_IMGL_CORE
*/
const MODULE_Type IMGL_UpdateModule = {
    .groupID           = BCM_GROUPID_IMGL,
    .compID            = BCM_IMG_ID,
    .configImgID       = 0U,
    .configImgData     = NULL,
    .configImgSize     = 0UL,
    .context           = &IMGL_UpdateModContext.innerContext,
    .resetStateHandler = IMGL_UpdateResetStateHandler,
    .initStateHandler  = IMGL_UpdateInitStateHandler,
    .readyStateHandler = IMGL_UpdateReadyStateHandler,
    .runStateHandler   = NULL,
    .eventHandler      = IMGL_UpdateEventHandler,
    .sendCmd           = IMGL_UpdateSendCmd,
    .getResp           = IMGL_UpdateGetResp,
    .mergeResult       = IMGL_UpdateMergeResult,
    .getEventMask      = IMGL_UpdateGetEventMask,
    .cmdQ              = MSGQ_INIT_V2(IMGL_GetServer, MSGQ_CLIENT_SIGNAL_ENABLE,
                            IMGL_MsgType, IMGL_RPC_MSG_COUNT,
                            &IMGL_UpdateModContext.rpcMsgQCtx, IMGL_MsgQGetCmd),
};

/** @} */
