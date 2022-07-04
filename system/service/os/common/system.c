/*****************************************************************************
 Copyright 2020-2021 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_system_impl System interface
    @ingroup grp_sys_service

    @addtogroup grp_system_impl
    @{

    @file system.c
    @brief System interface for subsystem to interact.

    @version 0.1 Initial version
*/
#include <stdlib.h>
#include <bcm_err.h>
#include <bcm_utils.h>
#include <system.h>
#include <system_module.h>
#include <bcm_utils.h>

/**
    @name Sub system design IDs
    @{
    @brief Design IDs for sub system
*/
#define BRCM_SWDSGN_SYS_GET_FNTBL_PROC            (0xA301U)    /**< @brief #SYS_GetFnTbl        */
#define BRCM_SWDSGN_SYS_SEND_CMD_PROC             (0xA302U)    /**< @brief #SYS_SendCmd         */
#define BRCM_SWDSGN_SYS_RECV_RESP_PROC            (0xA303U)    /**< @brief #SYS_RecvResp        */
#define BRCM_SWDSGN_SYS_GET_STATE_PROC            (0xA304U)    /**< @brief #SYS_GetState        */
#define BRCM_SWDSGN_SYS_SUB_STATE_HANDLER_PROC    (0xA305U)    /**< @brief #SYS_SubStateHandler */
#define BRCM_SWDSGN_SYS_NOTIFY_ERROR_PROC         (0xA306U)    /**< @brief #SYS_NotifyError     */
/** @} */


/** @brief Get sub system function table

    Get sub system function table matching with

    @behavior Sync, Re-entrant

    @pre #SYS_FnTables is initialized

    @param[in]      aGroupID       Brief description of aArg1

    @retval Pointer to function table as #SYS_FnTblType

    @post  None

    @trace #BRCM_SWARCH_SYS_FNTABLE_MAX_MACRO
    @trace #BRCM_SWARCH_SYS_FN_TABLES_GLOBAL
    @trace #BRCM_SWARCH_SYS_SEND_PROC
    @trace #BRCM_SWARCH_SYS_RECV_PROC
    @trace #BRCM_SWARCH_SYS_GET_STATE_PROC
    @trace #BRCM_SWARCH_SYS_NOTIFY_ERROR_PROC
    @trace #BRCM_SWREQ_SYS_INTERFACE

    @limitations None

    @code{.unparsed}
    for each fnTbl in SYS_FnTables
        if fnTbl is not None
            if fnTbl->groupID is aGroupID and fnTbl->compID is  aCompID
                return fnTbl
    @endcode

*/
static const SYS_FnTblType* SYS_GetFnTbl(BCM_GroupIDType aGroupID,
                                         BCM_CompIDType aCompID)
{
    uint32_t i;
    const SYS_FnTblType *fnTbl = NULL;

    for (i = 0UL; i < SYS_FNTABLE_MAX; i++) {
        if (NULL != SYS_FnTables[i]) {
            if ((aGroupID == SYS_FnTables[i]->groupID) &&
                (aCompID == SYS_FnTables[i]->compID)) {
                fnTbl = SYS_FnTables[i];
            }
        }
    }

    return fnTbl;
}

/**
    @trace #BRCM_SWARCH_SYS_CMD_TYPE
    @trace #BRCM_SWARCH_SYS_SEND_PROC
    @trace #BRCM_SWREQ_SYS_INTERFACE

    @code{.unparsed}
    if (aHdr is NULL) or (aCmd > SYS_CMD_ID_MAX)
        return ERR_INVAL_PARAMS
    else
        fnTbl = SYS_GetFnTbl(aReceiverGroupID, aReceiverCompID)
        SYS_CmdType cmd = {
            .id = fnTbl->id,
            .cmd = aCmd,
            .response = BCM_ERR_BUSY
        };

        if fnTbl is not NULL
            return fnTbl->sendCmd(&cmd, aClientMask, aHdr);
        else
            return ERR_INVAL_PARAMS
    @endcode

    @limitations None
*/
int32_t SYS_SendCmd(BCM_GroupIDType aReceiverGroupID,
                    BCM_CompIDType aReceiverCompID,
                    const SYS_CmdIDType aCmd,
                    const uint32_t aClientMask,
                    const MSGQ_MsgHdrType** const aHdr)
{
    int32_t retVal = BCM_ERR_OK;
    if ((NULL == aHdr) ||
        (SYS_CMD_ID_MAX < aCmd)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        const SYS_FnTblType *fnTbl = SYS_GetFnTbl(aReceiverGroupID, aReceiverCompID);
        if (NULL != fnTbl) {
            SYS_CmdType cmd = {
                .groupID = fnTbl->groupID,
                .compID = fnTbl->compID,
                .cmd = aCmd,
                .response = BCM_ERR_BUSY
            };

            retVal = fnTbl->sendCmd(&cmd, aClientMask, aHdr);
        } else {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_SYS_CMD_TYPE
    @trace #BRCM_SWARCH_SYS_RECV_PROC
    @trace #BRCM_SWREQ_SYS_INTERFACE

    @code{.unparsed}
    if (aHdr is NULL) or (aCmd is NULL) or (aResp is NULL)
        return ERR_INVAL_PARAMS
    else
        fnTbl = SYS_GetFnTbl(aReceiverGroupID, aReceiverCompID)
        if fnTbl is not NULL
            ret = aFTbl->recvResp(aHdr, &resp)
            if ret is ERR_OK
                *aCmd = resp->cmd;
                *aResp = resp->response;
            return ret;
        else
            return ERR_INVAL_PARAMS
    @endcode

    @limitations None
*/
int32_t SYS_RecvResp(BCM_GroupIDType aReceiverGroupID,
                     BCM_CompIDType aReceiverCompID,
                     const MSGQ_MsgHdrType* const aHdr,
                     SYS_CmdIDType *aCmd,
                     int32_t *aResp)
{
    int32_t retVal = BCM_ERR_OK;
    if ((NULL == aHdr) ||
        (NULL == aCmd) ||
        (NULL == aResp)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        const SYS_FnTblType *fnTbl = SYS_GetFnTbl(aReceiverGroupID, aReceiverCompID);
        if (NULL != fnTbl) {
            SYS_CmdType resp;
            BCM_MemSet(&resp, 0U, sizeof(resp));
            retVal = fnTbl->recvResp(aHdr, &resp);
            if (BCM_ERR_OK == retVal) {
                *aCmd = resp.cmd;
                *aResp = resp.response;
            }
        } else {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_SYS_SUB_STATE_HANDLER_PROC
    @trace #BRCM_SWREQ_SYS_INTERFACE

    @code{.unparsed}
    if aState is not NULL and aHdr is not NULL
        state = BCM_STATE_GET_STATE(*aState)
        comp = BCM_STATE_GET_COMPONENT(*aState)
        subState = BCM_STATE_GET_SUBSTATE(*aState)
        switch (state)
            case UNINIT:
                cmd = INIT
                expectedState  = INIT
            case INIT:
                cmd = CONFIG
                expectState = RUN
            case RUN:
                cmd = DEINIT
                expectState = UNINIT
        ret = SYS_GetState(aReceiverGroupID, comp, &currState)
        if ret is not OK
            currState = UNINIT
        else if expectState is equal to currState
            *aState = BCM_STATE_UPDATE_SUBSTATE(BCM_STATE_SUB_STATE_DONE)
        else
            do
                prevSubState = subState
                switch (subState)
                    case RESET:
                        ret = SYS_SendCmd(aReceiverGroupID, comp, cmd, aClientMask, aHdr)
                        if ret is OK
                            *aState = BCM_STATE_UPDATE_SUBSTATE(STAGE0)
                        else
                            *aState = BCM_STATE_UPDATE_SUBSTATE(DONE)
                    case STAGE0:
                        ret = SYS_RecvResp(aReceiverGroupID, comp, *aHdr, &tmpCmd, &tmpResp)
                        if ret is not BUSY
                            *aState = BCM_STATE_UPDATE_SUBSTATE(DONE)
                            if tmpCmd is not cmd or tmpResp is not OK
                                BCM_ReportError
                subState = BCM_STATE_GET_SUBSTATE(*aState)
            while (prevSubState != subState)
    @endcode

    @limitations None
*/
void SYS_SubStateHandler(BCM_GroupIDType aReceiverGroupID,
                         BCM_StateType *aState,
                         BCM_StateType aRequestedState,
                         const uint32_t aClientMask,
                         const MSGQ_MsgHdrType **aHdr)
{
    uint32_t state, comp, subState, prevSubState;
    uint32_t cmd, tmpCmd = 0UL;
    BCM_StateType expectState, currState;
    int32_t ret, tmpResp = 0L;

    if ((NULL != aState) &&  (NULL != aHdr)) {
        state = BCM_STATE_GET_STATE(*aState);
        comp = BCM_STATE_GET_COMPONENT(*aState);
        subState = BCM_STATE_GET_SUBSTATE(*aState);
        switch (state) {
            case BCM_STATE_UNINIT:
                cmd = SYS_CMD_ID_INIT;
                expectState = BCM_STATE_INIT;
            break;
            case BCM_STATE_INIT:
                cmd = SYS_CMD_ID_CONFIG;
                expectState = BCM_STATE_READY;
            break;
            case BCM_STATE_READY:
                if (BCM_STATE_RUN == aRequestedState) {
                    cmd = SYS_CMD_ID_START;
                    expectState = BCM_STATE_RUN;
                } else {
                    cmd = SYS_CMD_ID_DEINIT;
                    expectState = BCM_STATE_UNINIT;
                }
            break;
            case BCM_STATE_RUN:
                if (BCM_STATE_READY == aRequestedState) {
                    cmd = SYS_CMD_ID_STOP;
                    expectState = BCM_STATE_READY;
                } else if (BCM_STATE_RUN == aRequestedState) {
                    cmd = SYS_CMD_ID_START;
                    expectState = BCM_STATE_RUN;
                } else {
                    cmd = SYS_CMD_ID_DEINIT;
                    expectState = BCM_STATE_UNINIT;
                }
            break;
            default:
                cmd = SYS_CMD_ID_DEINIT;
                expectState = BCM_STATE_UNINIT;
            break;
        }
        ret = SYS_GetState(aReceiverGroupID, (uint16_t)comp, &currState);
        if (BCM_ERR_OK != ret) {
            currState = BCM_STATE_UNINIT;
        } else if ((expectState == currState) && (BCM_STATE_SUB_STATE_RESET == subState)) {
            *aState = BCM_STATE_UPDATE_SUBSTATE(*aState, BCM_STATE_SUB_STATE_DONE);
        } else {
            do {
                prevSubState = subState;
                switch (subState) {
                    case BCM_STATE_SUB_STATE_RESET:
                        ret = SYS_SendCmd(aReceiverGroupID, (uint16_t)comp, cmd, aClientMask, aHdr);
                        if (BCM_ERR_OK == ret) {
                            *aState = BCM_STATE_UPDATE_SUBSTATE(*aState, BCM_STATE_SUB_STATE_STAGE0);
                        } else {
                            *aState = BCM_STATE_UPDATE_SUBSTATE(*aState, BCM_STATE_SUB_STATE_DONE);
                        }
                        break;
                    case BCM_STATE_SUB_STATE_STAGE0:
                        ret = SYS_RecvResp(aReceiverGroupID,(uint16_t)comp, *aHdr, &tmpCmd, &tmpResp);
                        if (BCM_ERR_BUSY != ret) {
                            *aState = BCM_STATE_UPDATE_SUBSTATE(*aState, BCM_STATE_SUB_STATE_DONE);
                            if ((tmpCmd != cmd) || (BCM_ERR_OK != tmpResp)) {
                                uint32_t values[4UL] = {0UL};
                                values[0UL] = *aState;
                                values[1UL] = tmpCmd;
                                values[2UL] = cmd;
                                values[3UL] = (uint32_t)tmpResp;
                                BCM_ReportError(BCM_SYS_ID, 1U, BRCM_SWDSGN_SYS_SUB_STATE_HANDLER_PROC,
                                                ret, 4UL, values);
                            }
                        }
                        break;
                    default:
                    break;
                }
                subState = BCM_STATE_GET_SUBSTATE(*aState);
            } while (prevSubState != subState);
        }
    }
}

/**
    @trace #BRCM_SWARCH_SYS_GET_STATE_PROC
    @trace #BRCM_SWREQ_SYS_INTERFACE

    @code{.unparsed}

    fnTbl = SYS_GetFnTbl(aGroupID, aCompID)
    if fnTbl is not NULL
        *aState = fnTbl->getState();
        return ERR_OK
    else
        return ERR_INVAL_PARAMS
    @endcode

    @limitations None
*/
int32_t SYS_GetState(BCM_GroupIDType aGroupID,
                     BCM_CompIDType aCompID,
                     BCM_StateType *aState)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;
    const SYS_FnTblType *fnTbl = SYS_GetFnTbl(aGroupID, aCompID);
    if ((NULL != fnTbl) && (NULL != aState)) {
        *aState = fnTbl->getState();
        retVal = BCM_ERR_OK;
    }

    return retVal;
}

/** @brief Send error notification

    @trace #BRCM_SWARCH_SYS_NOTIFY_ERROR_PROC
    @trace #BRCM_SWREQ_SYS_INTERFACE

    @code{.unparsed}

    senderFnTbl = SYS_GetFnTbl(aSenderGroupID, aSenderCompID)
    receiverFnTbl = SYS_GetFnTbl(aReceiverGroupID, aReceiverCompID)
    if senderFnTbl is not NULL and receiverFnTbl is not NULL
        if senderFnTbl->parentGroupID is aReceiverGroupID and
            senderFnTbl->parentCompID is aReceiverCompID
            *aState = fnTbl->getState();
            return receiverFnTbl->notifyError(aSenderGroupID, aSenderCompID, aState);
        else
            return ERR_INVAL_PARAMS
    else
        return ERR_INVAL_PARAMS
    @endcode

    @limitations None
*/
int32_t SYS_NotifyError(BCM_GroupIDType aSenderGroupID,
                        BCM_CompIDType aSenderCompID,
                        BCM_GroupIDType aReceiverGroupID,
                        BCM_CompIDType aReceiverCompID,
                        BCM_StateType aState)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;;
    const SYS_FnTblType *senderFnTbl = SYS_GetFnTbl(aSenderGroupID, aSenderCompID);
    const SYS_FnTblType *receiverFnTbl = SYS_GetFnTbl(aReceiverGroupID, aReceiverCompID);

    if ((NULL != senderFnTbl) && (NULL != receiverFnTbl)) {
        if ((aReceiverGroupID == senderFnTbl->parentGroupID) &&
            (aReceiverCompID == senderFnTbl->parentCompID)) {
            retVal = receiverFnTbl->notifyError(aSenderGroupID, aSenderCompID, aState);
        } else {
            retVal = BCM_ERR_AUTH_FAILED;
        }
    }

    return retVal;

}

/** @} */
