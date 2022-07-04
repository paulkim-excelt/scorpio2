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
    @addtogroup grp_nvm_il
    @{

    @file nvm_osil.c
    @brief Flash Manager integration
    This source file contains the integration of flash manager to system.
    @version 0.52 Imported from docx
*/

#include <stddef.h>
#include <system.h>
#include <inttypes.h>
#include <bcm_err.h>
#include <flash_osil.h>
#include <nvm.h>
#include <nvm_osil.h>
#include <ptm_osil.h>
#include <board.h>
#include <osil/bcm_osil.h>
#include "ee.h"
#include <ulog.h>

#include <system_state.h>

#define GetModuleLogLevel()         (ULOG_LVL_INFO)

#define FLASH_EVENTS        (FLASH0_EVENT | FLASH1_EVENT)
#define NVM_0_EVENTS        (NVM_MSGQ_EVENT | NVM_FLS_0_CB_IND_EVENT)
#define NVM_1_EVENTS        (NVM_MSGQ_EVENT | NVM_FLS_1_CB_IND_EVENT)
#define NVM_EVENTS          (NVM_0_EVENTS | NVM_1_EVENTS)
#define PTM_EVENTS          (PTM_MSGQ_EVENT_ID | PTM_FLASH_OP_DONE_EVENT_ID)

/* Function prototypes */
static void *NVM_GetMsg(uint32_t aIdx);
int32_t InitNVM(void);
int32_t DeInitNVM(void);

typedef struct sNVM_ContextType {
    BCM_StateType          state;
    uint32_t               deInitStatus;
} NVM_ContextType;

static NVM_ContextType NVM_Context;

#define NVM_MSGQ_ENTRY_COUNT (4UL)

MSGQ_DEFINE_V3(NVM_MsgQ, NVM_MSGQ_ENTRY_COUNT, NVM_SERVER_TASK_ID, NVM_MSGQ_EVENT, MSGQ_CLIENT_SIGNAL_ENABLE,
               NVM_MsgType, NVM_MsgHdrQ, NVM_GetMsg, ".data.nvm")

static NVM_MsgType NVM_Msg[NVM_MSGQ_ENTRY_COUNT];

static SYS_CmdType NVM_Cmd[MSGQ_SIZE] COMP_SECTION(".bss.nvm");

void* NVM_GetCmd(uint32_t idx)
{
    void* pRet = NULL;

    if (idx < MSGQ_SIZE) {
        pRet = (void *)(&NVM_Cmd[idx]);
    }
    return pRet;
}


MSGQ_DEFINE_V2(NVM_CmdQ, NVM_SERVER_TASK_ID, NVM_NOTIF_EVENT, MSGQ_CLIENT_SIGNAL_ENABLE,
        SYS_CmdType, NVM_CmdHdrQ, NVM_GetCmd, ".data.nvm");

static void NVM_ReportError(uint8_t aInstanceID, uint16_t aApiID,
        int32_t aErr, uint32_t aVal0, uint32_t aVal1, uint32_t aVal2,
        uint32_t aVal3)
{
    const uint32_t values[4] = {aVal0, aVal1, aVal2, aVal3};
    BCM_ReportError(BCM_FLM_ID, aInstanceID, aApiID, aErr, 4UL, values);
}

static void *NVM_GetMsg(uint32_t aIdx)
{
    void *pMsg = NULL;

    if (NVM_MSGQ_ENTRY_COUNT > aIdx) {
        pMsg = (void *)(&NVM_Msg[aIdx]);
    }

    return pMsg;
}

#if !defined(ENABLE_FLASH_TEST)
/**
    Client (CLIENT_TASK) shall wait for two events: FLASH_OPS_DONE_EVENT and
    FLASH_OPS_ERR_EVENT after initiating a flash asynchronous operation.After
    successful completion of flash operation client task shall be woken up by
    setting FLASH_OPS_DONE_EVENT from the #FLASH_OpsDoneInd callback function.

    Below is typical implementation of #FLASH_OpsDoneInd.
    @code{.c}
    void FLASH_OpsDoneInd(FLASH_HwIDType aID)
    {
        Signal(CLIENT_TASK, FLASH_OPS_DONE_EVENT);
    }
    @endcode
*/
void FLASH_OpsDoneInd(FLASH_HwIDType aID)
{
    int32_t status;

    if (FLASH_HW_ID_0 == aID) {
        status = BCM_SetEvent(NVM_SERVER_TASK_ID, NVM_FLS_0_CB_IND_EVENT);
        if (status != BCM_ERR_OK) {
            NVM_ReportError((uint8_t)aID, BRCM_SWARCH_FLASH_OPS_DONE_IND_PROC,
                    BCM_ERR_CUSTOM, 0UL, 0UL, 0UL, 0UL);
        }
    } else if (FLASH_HW_ID_1 == aID) {
        status = BCM_SetEvent(NVM_SERVER_TASK_ID, NVM_FLS_1_CB_IND_EVENT);
        if (status != BCM_ERR_OK) {
            NVM_ReportError((uint8_t)aID, BRCM_SWARCH_FLASH_OPS_DONE_IND_PROC,
                    BCM_ERR_CUSTOM, 0UL, 0UL, 0UL, 0UL);
        }
    } else {
        NVM_ReportError((uint8_t)aID, BRCM_SWARCH_FLASH_OPS_DONE_IND_PROC,
                BCM_ERR_INVAL_PARAMS, 0UL, 0UL, 0UL, 0UL);
    }
}

/**
    Client task shall wait for two events, say FLASH_OPS_DONE_EVENT and
    FLASH_OPS_ERR_EVENT after initiating a flash asynchronous operation. On
    error during flash operation, client task shall be woken up by setting
    FLASH_OPS_ERR_EVENT from the #FLASH_OpsErrInd callback function.

    Below is typical implementation of #FLASH_OpsErrInd:
    @code {.c}
    void FLASH_OpsErrInd(FLASH_HwIDType aID)
    {
        Signal(CLIENT_TASK, FLASH_OPS_ERR_EVENT);
    }
    @endcode
*/
void FLASH_OpsErrInd(FLASH_HwIDType aID)
{
    int32_t status;

    if (FLASH_HW_ID_0 == aID) {
        status = BCM_SetEvent(NVM_SERVER_TASK_ID, NVM_FLS_0_CB_IND_EVENT);
        if (status != BCM_ERR_OK) {
            NVM_ReportError((uint8_t)aID, BRCM_SWARCH_FLASH_OPS_ERR_IND_PROC,
                    BCM_ERR_CUSTOM, 0UL, 0UL, 0UL, 0UL);
        }
    } else if (FLASH_HW_ID_1 == aID){
        status = BCM_SetEvent(NVM_SERVER_TASK_ID, NVM_FLS_1_CB_IND_EVENT);
        if (status != BCM_ERR_OK) {
            NVM_ReportError((uint8_t)aID, BRCM_SWARCH_FLASH_OPS_ERR_IND_PROC,
                    BCM_ERR_CUSTOM, 0UL, 0UL, 0UL, 0UL);
        }
    } else {
        NVM_ReportError((uint8_t)aID, BRCM_SWARCH_FLASH_OPS_ERR_IND_PROC,
                BCM_ERR_INVAL_PARAMS, 0UL, 0UL, 0UL, 0UL);
    }
}
#endif

/**
    @code{.c}
        *MsgQ = NVM_MsgQ;
    return void
    @endcode
*/
void NVM_GetMsgQ(MSGQ_Type *MsgQ)
{
    *MsgQ = NVM_MsgQ;
}

/**
    @code{.c}
    do {
        ret = MSGQ_GetMsgIdx(&NVM_MsgQ, &idx)
        if ret is BCM_ERR_BUSY
            break
        if ret is not BCM_ERR_OK
            break

        ret = NVM_MsgHandler(aID, &NVM_Msg[idx])
        if ret is BCM_ERR_OK {
            ret = MSGQ_CompleteMsgIdx(&NVM_MsgQ, idx)
        }
    } while (ret is BCM_ERR_OK)
    @endcode
*/
void NVM_EventHandler(void)
{
    int32_t retVal;
    uint32_t idx;

    do {
        /* Get message queue index */
        retVal = MSGQ_GetMsgIdx(&NVM_MsgQ, &idx);
        if (BCM_ERR_BUSY == retVal) {
            /* No new message */
            break;
        }

        if (BCM_ERR_OK != retVal) {
            /* Something wrong happened */
            NVM_ReportError((uint8_t)0UL, BRCM_SWARCH_NVM_IL_EVENT_HANDLER_PROC,
                    retVal, 0UL, 0UL, 0UL, 0UL);
            break;
        }

        /* Process message */
        retVal = NVM_MsgHandler(&NVM_Msg[idx]);

        /* Complete the message */
        if (BCM_ERR_OK == retVal) {
            retVal = MSGQ_CompleteMsgIdx(&NVM_MsgQ, idx);
            if (BCM_ERR_OK != retVal) {
                NVM_ReportError((uint8_t)0UL, BRCM_SWARCH_NVM_IL_EVENT_HANDLER_PROC,
                        retVal, 0UL, 0UL, 0UL, 0UL);
                break;
            }
        }
    } while (BCM_ERR_OK == retVal);

    return ;
}

static void NVM_ServerEventHandler(EventMaskType aEventMask)
{
#if defined(ENABLE_FLASH)
    if ((aEventMask & FLASH0_EVENT) != 0UL) {
        FLASH_StateHandler(0UL);
    }
    if ((aEventMask & FLASH1_EVENT) != 0UL) {
        FLASH_StateHandler(1UL);
    }
#endif
#if defined(ENABLE_NVM)
    if ((aEventMask & NVM_EVENTS) != 0UL) {
        NVM_EventHandler();
    }
#endif
#if defined(ENABLE_PTM)
    if ((aEventMask & PTM_EVENTS) != 0UL) {
        PTM_EventHandler();
    }
#endif
}

/**
    @brief Initialize NVM Service
*/
int32_t InitNVM(void)
{
    int32_t retVal = BCM_ERR_UNKNOWN;
    uint32_t i;
    FLASH_HwIDType flashID;
    const FLASH_CfgTblType *aFlashCfg;
    FLASH_StatusType flashStatus;

    /* Flash manager Initialization */
    for (i = 0UL; i < NVM_CfgTblSz; i++) {
        switch (NVM_CfgTbl[i].aDev) {

            case NVM_TYPE_FLASH:
                flashID = (FLASH_HwIDType) NVM_CfgTbl[i].aID;
                aFlashCfg = (const FLASH_CfgTblType *)NVM_CfgTbl[i].aCfg;
                if (flashID >= FLASH_MAX_HW_ID ||
                        (NULL == aFlashCfg)) {
                    retVal = BCM_ERR_INVAL_PARAMS;
                    break;
                }
                FLASH_Init(flashID, &aFlashCfg->config);
                retVal = FLASH_GetStatus(flashID, &flashStatus);
                if (BCM_ERR_OK != retVal) {
                    break;
                }
                if (FLASH_STATUS_IDLE != flashStatus) {
                    retVal = BCM_ERR_UNKNOWN;
                    break;
                }
                break;
            default:
                retVal = BCM_ERR_UNKNOWN;
                break;
        }
        if (BCM_ERR_OK != retVal) {
            break;
        }

    }
    if (BCM_ERR_OK == retVal) {
        retVal = NVM_Init();
        if (BCM_ERR_OK != retVal) {
            goto err;
        }
    }

err:
    if (BCM_ERR_OK != retVal) {
        NVM_ReportError((uint8_t)0U, BRCM_SWARCH_NVM_IL_SERVER_INIT_PROC, retVal, 0UL,
                0UL, 0UL, __LINE__);
    }
    return retVal;
}

/**
    @brief Initialize PTM Server
*/
#if defined(ENABLE_PTM)
static int32_t ConfigPTM(void)
{
    int32_t retVal;
    PTM_StateType ptmState;
    BCM_EventMaskType waitEvents = FLASH_EVENTS | NVM_EVENTS | PTM_FLASH_OP_DONE_EVENT_ID;
    BCM_EventMaskType eventMask = 0U;

    retVal = PTM_Init(PTM_Cfg);
    if (BCM_ERR_OK != retVal) {
        goto err;
    }
    /* Wait until PTM is initialized */
    do {
        ptmState = PTM_GetState();
        if (PTM_STATE_IDLE == ptmState) {
            retVal = BCM_ERR_OK;
            break;
        }
        if (PTM_STATE_ERROR == ptmState) {
            retVal = BCM_ERR_NOT_FOUND;
            break;
        }
        retVal = BCM_WaitEvent(waitEvents);
        if (BCM_ERR_OK != retVal) {
            break;
        }
        retVal = BCM_GetEvent(NVM_Server, &eventMask);
        if (BCM_ERR_OK != retVal) {
            break;
        }
        retVal = BCM_ClearEvent((EventMaskType )eventMask & (EventMaskType)waitEvents);
        if (BCM_ERR_OK != retVal) {
            break;
        }
        NVM_ServerEventHandler(eventMask & waitEvents);
    } while (1UL);

err:
    return retVal;
}
#endif

int32_t ConfigNVM(void)
{
    int32_t retVal = BCM_ERR_UNKNOWN;
    uint32_t i;
    int32_t status = BCM_ERR_UNKNOWN;
    int32_t flsInit = BCM_ERR_UNKNOWN;
    BCM_EventMaskType waitEvents = FLASH_EVENTS | NVM_EVENTS;
    BCM_EventMaskType eventMask = 0U;
    FLASH_HwIDType flashID;
    const FLASH_CfgTblType *aFlashCfg;
    FLASH_OpsResultType flashOpResult;

    /* Flash manager Initialization */
    for (i = 0UL; i < NVM_CfgTblSz; i++) {
        switch (NVM_CfgTbl[i].aDev) {

            case NVM_TYPE_FLASH:
                flashID = (FLASH_HwIDType) NVM_CfgTbl[i].aID;
                aFlashCfg = (const FLASH_CfgTblType *)NVM_CfgTbl[i].aCfg;
                if (flashID >= FLASH_MAX_HW_ID ||
                        (NULL == aFlashCfg)) {
                    retVal = BCM_ERR_INVAL_PARAMS;
                    break;
                }
                retVal = FLASH_CfgReadLane(flashID);
                if (BCM_ERR_OK == retVal) {
                    do {
                        status = BCM_WaitEvent(waitEvents);
                        if (BCM_ERR_OK != status) {
                            retVal = BCM_ERR_UNKNOWN;
                            break;
                        }
                        status = BCM_GetEvent(NVM_Server, &eventMask);
                        if (BCM_ERR_OK != status) {
                            retVal = BCM_ERR_UNKNOWN;
                            break;
                        }
                        status = BCM_ClearEvent(eventMask & waitEvents);
                        if (BCM_ERR_OK != status) {
                            retVal = BCM_ERR_UNKNOWN;
                            break;
                        }
                        if ((eventMask & FLASH_EVENTS) != 0UL) {
                            NVM_ServerEventHandler((EventMaskType)eventMask & (EventMaskType)waitEvents);
                        } else {
                            flsInit = BCM_ERR_OK;
                        }
                    } while (flsInit != BCM_ERR_OK);
                    if (BCM_ERR_OK == retVal) {
                        retVal = FLASH_GetOpsResult(flashID, &flashOpResult);
                    }
                } else if (BCM_ERR_NOSUPPORT == retVal) {
                    retVal = BCM_ERR_OK;
                } else {
                    retVal = BCM_ERR_UNKNOWN;
                }

                break;
            default:
                retVal = BCM_ERR_UNKNOWN;
                break;
        }
        if (BCM_ERR_OK != retVal) {
            break;
        }
    }

    if (BCM_ERR_OK != retVal) {
        NVM_ReportError((uint8_t)0U, BRCM_SWARCH_NVM_IL_SERVER_INIT_PROC, retVal, (uint32_t)status,
                0UL, 0UL, __LINE__);
    }
    return retVal;

}

/**
    @brief DeInitialize NVM Service
*/
int32_t DeInitNVM(void)
{
    int32_t retVal = BCM_ERR_OK;
    uint32_t i;
    FLASH_HwIDType flashID;
    FLASH_StatusType flashStatus;

    for (i = 0UL; i < NVM_CfgTblSz; i++) {
        switch (NVM_CfgTbl[i].aDev) {

            case NVM_TYPE_FLASH:
                flashID = (FLASH_HwIDType) NVM_CfgTbl[i].aID;
                FLASH_DeInit(flashID);
                retVal = FLASH_GetStatus(flashID, &flashStatus);
                if (BCM_ERR_OK == retVal) {
                    if (FLASH_STATUS_UNINIT == flashStatus) {
                        retVal = NVM_DeInit();
                    } else {
                        retVal = BCM_ERR_INVAL_STATE;
                    }
                }
                break;
            default:
                retVal = BCM_ERR_UNKNOWN;
                break;
        }
    }
    return retVal;
}

void NVM_ResetStateHandler(const BCM_EventMaskType aMask, BCM_StateType *const aState)
{
    int32_t retVal = BCM_ERR_OK;
    uint32_t state = BCM_STATE_GET_STATE(*aState);
    uint32_t component = BCM_STATE_GET_COMPONENT(*aState);
    uint32_t subState = BCM_STATE_GET_SUBSTATE(*aState);

    if (BCM_STATE_COMPONENT_NONE == component) {

#if !defined(ENABLE_NVM_TEST) && !defined(ENABLE_FLASH_TEST)
        retVal = InitNVM();
#endif
        if (BCM_ERR_OK == retVal) {
            component = BCM_STATE_COMPONENT_DONE;
            subState = BCM_STATE_SUB_STATE_RESET;
        }
    } else {
        /* This can use for async comp event if avialable */
    }
    *aState = BCM_STATE_CREATE_STATE(state, component, subState);
}

void NVM_InitStateHandler(const BCM_EventMaskType aMask, BCM_StateType *const aState)
{
    int32_t retVal = BCM_ERR_OK;
    uint32_t state = BCM_STATE_GET_STATE(*aState);
    uint32_t component = BCM_STATE_GET_COMPONENT(*aState);
    uint32_t subState = BCM_STATE_GET_SUBSTATE(*aState);

    if (BCM_STATE_COMPONENT_NONE == component) {
        retVal = ConfigNVM();
#if defined(ENABLE_PTM)
        if (BCM_ERR_OK == retVal) {
            (void)ConfigPTM();
        }
#else
        (void)retVal;
#endif
        component = BCM_STATE_COMPONENT_DONE;
        subState = BCM_STATE_SUB_STATE_RESET;
    } else {
        /* This can use for async comp event if avialable */
    }

    *aState = BCM_STATE_CREATE_STATE(state, component, subState);
}


static void NVM_StopStateHandler(BCM_EventMaskType aMask, BCM_StateType *aState)
{
    int32_t retVal;
    uint32_t state = BCM_STATE_GET_STATE(*aState);
    uint32_t component = BCM_STATE_GET_COMPONENT(*aState);
    uint32_t subState = BCM_STATE_GET_SUBSTATE(*aState);

    if (BCM_STATE_COMPONENT_NONE == component) {
        retVal = DeInitNVM();
        if (BCM_ERR_OK == retVal) {
            component = BCM_STATE_COMPONENT_DONE;
            subState = BCM_STATE_SUB_STATE_RESET;
        }
    }

    *aState = BCM_STATE_CREATE_STATE(state, component, subState);
}

void NVM_TryCompleteMsg(int32_t aError)
{
    uint32_t cmdMsgIdx = 0UL;

    int32_t retVal = MSGQ_GetMsgIdx(&NVM_CmdQ, &cmdMsgIdx);
    if (BCM_ERR_OK == retVal) {
        NVM_Cmd[cmdMsgIdx].response = aError;
        (void)MSGQ_CompleteMsgIdx(&NVM_CmdQ, cmdMsgIdx);
    }
}

int32_t NVM_CheckForCommand(SYS_CmdIDType *aCmd)
{
    uint32_t cmdMsgIdx = 0UL;
    int32_t retVal = MSGQ_GetMsgIdx(&NVM_CmdQ, &cmdMsgIdx);
    if (BCM_ERR_OK == retVal) {
        *aCmd = NVM_Cmd[cmdMsgIdx].cmd;
    }
    return retVal;
}

TASK(NVM_Server)
{
    int32_t status;
    uint32_t state;
    uint32_t prevState;
    BCM_EventMaskType waitEvents = NVM_NOTIF_EVENT;
    BCM_EventMaskType eventMask = 0U;
    int32_t retVal;
    SYS_CmdIDType cmdVal = SYS_CMD_ID_MAX;

#if !defined(ENABLE_NVM_TEST) && !defined(ENABLE_FLASH_TEST) && defined(ENABLE_PTM)
        waitEvents |= FLASH_EVENTS | NVM_EVENTS | PTM_EVENTS;
#else
        waitEvents |= FLASH_EVENTS | NVM_EVENTS;
#endif

    NVM_Context.state = BCM_STATE_CREATE_STATE(BCM_STATE_UNINIT, BCM_STATE_COMPONENT_NONE, BCM_STATE_SUB_STATE_RESET);
    NVM_Context.deInitStatus = BCM_STATE_COMPONENT_NONE;

    while (BCM_STATE_COMPONENT_DONE != NVM_Context.deInitStatus) {

        status = BCM_WaitEvent(waitEvents);
        if (BCM_ERR_OK != status) {
            break;
        }
        status = BCM_GetEvent(NVM_Server, &eventMask);
        if (BCM_ERR_OK != status) {
            break;
        }
        status = BCM_ClearEvent(eventMask & waitEvents);
        if (BCM_ERR_OK != status) {
            break;
        }

        state = BCM_STATE_GET_STATE(NVM_Context.state);

        do {
            prevState = state;
            switch(state) {
                case BCM_STATE_UNINIT:
                    retVal = NVM_CheckForCommand(&cmdVal);
                    if (BCM_ERR_OK == retVal) {
                        if (SYS_CMD_ID_INIT == cmdVal) {
                            NVM_ResetStateHandler(eventMask, &NVM_Context.state);
                            if (BCM_STATE_COMPONENT_DONE ==  BCM_STATE_GET_COMPONENT(NVM_Context.state)) {
                                NVM_Context.state = BCM_STATE_CREATE_STATE(BCM_STATE_INIT, BCM_STATE_COMPONENT_NONE, BCM_STATE_SUB_STATE_RESET);
                                NVM_TryCompleteMsg(BCM_ERR_OK);
                            }
                        } else {
                            NVM_TryCompleteMsg(BCM_ERR_INVAL_STATE);
                        }
                    }
                    break;
                case BCM_STATE_INIT:
                    if (BCM_STATE_COMPONENT_NONE == NVM_Context.deInitStatus) {
                        NVM_ServerEventHandler(eventMask);
                    }
                    retVal = NVM_CheckForCommand(&cmdVal);
                    if (BCM_ERR_OK == retVal) {
                        if (SYS_CMD_ID_CONFIG == cmdVal) {
                            NVM_InitStateHandler(eventMask, &NVM_Context.state);
                            if (BCM_STATE_COMPONENT_DONE ==  BCM_STATE_GET_COMPONENT(NVM_Context.state)) {
                                NVM_Context.state = BCM_STATE_CREATE_STATE(BCM_STATE_READY, BCM_STATE_COMPONENT_NONE, BCM_STATE_SUB_STATE_RESET);
                                NVM_TryCompleteMsg(BCM_ERR_OK);
                            }
                        } else {
                            NVM_TryCompleteMsg(BCM_ERR_INVAL_STATE);
                        }
                    }
                    break;
                case BCM_STATE_READY:
                    if (BCM_STATE_COMPONENT_NONE == NVM_Context.deInitStatus) {
                        NVM_ServerEventHandler(eventMask);
                    }
                    retVal = NVM_CheckForCommand(&cmdVal);
                    if (BCM_ERR_OK == retVal) {
                        if (SYS_CMD_ID_START == cmdVal) {
                            NVM_Context.state = BCM_STATE_CREATE_STATE(BCM_STATE_RUN, BCM_STATE_COMPONENT_NONE, BCM_STATE_SUB_STATE_RESET);
                            NVM_TryCompleteMsg(BCM_ERR_OK);
                        } else {
                            NVM_TryCompleteMsg(BCM_ERR_INVAL_STATE);
                        }
                    }
                    break;
                case BCM_STATE_RUN:
                    if (BCM_STATE_COMPONENT_NONE == NVM_Context.deInitStatus) {
                        NVM_ServerEventHandler(eventMask);
                    }
                    retVal = NVM_CheckForCommand(&cmdVal);
                    if (BCM_ERR_OK == retVal) {
                        if (SYS_CMD_ID_DEINIT == cmdVal) {
                            NVM_StopStateHandler(eventMask, &NVM_Context.state);
                            if (BCM_STATE_COMPONENT_DONE ==  BCM_STATE_GET_COMPONENT(NVM_Context.state)) {
                                NVM_Context.deInitStatus = BCM_STATE_COMPONENT_DONE;
                                NVM_Context.state = BCM_STATE_CREATE_STATE(BCM_STATE_UNINIT, BCM_STATE_COMPONENT_NONE, BCM_STATE_SUB_STATE_RESET);
                                NVM_TryCompleteMsg(BCM_ERR_OK);
                            }
                        } else if (SYS_CMD_ID_STOP == cmdVal) {
                            NVM_Context.state = BCM_STATE_CREATE_STATE(BCM_STATE_READY, BCM_STATE_COMPONENT_NONE, BCM_STATE_SUB_STATE_RESET);
                            NVM_TryCompleteMsg(BCM_ERR_OK);
                        } else {
                            NVM_TryCompleteMsg(BCM_ERR_INVAL_STATE);
                        }
                    }
                    break;
                default:
                    ULOG_ERR(" %s wrong state %08x \n", __func__, NVM_Context.state);
                    (void)state;
                    break;
            }
            if (BCM_STATE_COMPONENT_DONE == NVM_Context.deInitStatus) {
                break;
            }
            state = BCM_STATE_GET_STATE(NVM_Context.state);
        } while (prevState != state);
    }

    BCM_TerminateTask();
}

/**
    @code{.c}
    BCM_ActivateTask(NVM_Server)
    @endcode
*/
void NVM_ServerInit(void)
{
    int32_t status;

    status = BCM_ActivateTask(NVM_Server);
    if (BCM_ERR_OK != status) {
        NVM_ReportError((uint8_t)0U, BRCM_SWARCH_NVM_IL_SERVER_INIT_PROC, status, 0UL,
                0UL, 0UL, __LINE__);
    }
}

static int32_t NVM_SendCmdSys(const SYS_CmdType *const aCmd,
        const uint32_t aClientMask,
        const MSGQ_MsgHdrType** const aHdr)
{
    int32_t retVal;

    if ((NULL != aCmd)
            && (BCM_GROUPID_NVM == aCmd->groupID)
            && (BCM_NVM_ID == aCmd->compID)
            && (NULL != aHdr)) {
        if (SYS_CMD_ID_INIT == aCmd->cmd) {
            NVM_ServerInit();
        }
        retVal = MSGQ_SendMsg(&NVM_CmdQ, (const void *) aCmd, aClientMask, aHdr);
    } else {
        retVal = BCM_ERR_INVAL_PARAMS;
    }

    return retVal;
}

static int32_t NVM_RecvRespSys(const MSGQ_MsgHdrType* const aHdr,
        SYS_CmdType* const aCmd)
{
    int32_t retval;

    if ((NULL != aHdr) && (NULL != aCmd)) {
        retval = MSGQ_RecvMsg(&NVM_CmdQ, aHdr, (void *) aCmd);
    } else {
        retval = BCM_ERR_INVAL_PARAMS;
    }

    return retval;
}

static BCM_StateType NVM_GetStateSys(void)
{
    return BCM_STATE_GET_STATE(NVM_Context.state);
}

const SYS_FnTblType NVM_FnTable =
{
    .parentGroupID = BCM_GROUPID_SYS,
    .parentCompID = BCM_SYS_ID,
    .groupID = BCM_GROUPID_NVM,
    .compID = BCM_NVM_ID,
    .sendCmd = NVM_SendCmdSys,
    .recvResp = NVM_RecvRespSys,
    .getState = NVM_GetStateSys,
    .notifyError = NULL,
};
/** @} */
