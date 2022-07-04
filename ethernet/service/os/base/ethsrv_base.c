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
    @defgroup grp_ethernet_impl Ethernet Task Implementation
    @ingroup grp_ethsrv_sw

    @addtogroup grp_ethernet_impl
    @{

    @file ethsrv_base.c

    @brief Ethernet Task integration
    This file contains the integration details of Ethernet Task

    @version 0.1 Initial version
*/

#include <stdlib.h>
#include <string.h>
#include <system.h>
#include <bcm_utils.h>
#include <module.h>
#include <bcm_osil.h>
#include <ethutils.h>
#include <module_helper.h>
#include <ethsrv_module.h>
#if defined(ENABLE_ETHERNET_MCAN)
#include <osil/can_osil.h>
#endif /* ENABLE_ETHERNET_MCAN */
#include <ethsrv_base.h>


/**
    @name ETHERNET Design IDs
    @{
    @brief ETHERNET Design IDs
*/
#define BRCM_SWDSGN_ETHERNET_ERRORNOTIFN_TYPE           (0xD001U)   /**< @brief #ETHERNET_ErrorNotifnType */
#define BRCM_SWDSGN_ETHERNET_ERRORNOTIF_GLOBAL          (0xD002U)   /**< @brief #ETHERNET_ErrorNotif */
#define BRCM_SWDSGN_ETHERNET_CMD_GLOBAL                 (0xD003U)   /**< @brief #ETHERNET_Cmd */
#define BRCM_SWDSGN_ETHERNET_MODULEFNTABLES_GLOBAL      (0xD004U)   /**< @brief #ETHERNET_ModuleFnTables */
#define BRCM_SWDSGN_ETHERNET_ERRORREPORT_PROC           (0xD005U)   /**< @brief #ETHERNET_ErrorReport */
#define BRCM_SWDSGN_ETHERNET_GETCMD_PROC                (0xD006U)   /**< @brief #ETHERNET_GetCmd */
#define BRCM_SWDSGN_ETHERNET_CMDQ_GLOBAL                (0xD007U)   /**< @brief #ETHERNET_CmdQ */
#define BRCM_SWDSGN_ETHERNET_CHECKFORCOMMAND_PROC       (0xD008U)   /**< @brief #ETHERNET_CheckForCommand */
#define BRCM_SWDSGN_ETHERNET_TRYCOMPLETEMSG_PROC        (0xD009U)   /**< @brief #ETHERNET_TryCompleteMsg */
#define BRCM_SWDSGN_ETHERNET_GETNOTIF_PROC              (0xD00AU)   /**< @brief #ETHERNET_GetNotif */
#define BRCM_SWDSGN_ETHERNET_NOTIFQ_FLOBAL              (0xD00BU)   /**< @brief #ETHERNET_NotifQ */
#define BRCM_SWDSGN_ETHERNET_SENDERRNOTIFICATION_PROC   (0xD00CU)   /**< @brief #ETHERNET_SendErrNotification */
#define BRCM_SWDSGN_ETHERNET_SENDCMDSYS_PROC            (0xD00DU)   /**< @brief #ETHERNET_SendCmdSys */
#define BRCM_SWDSGN_ETHERNET_RECVRESPSYS_PROC           (0xD00EU)   /**< @brief #ETHERNET_RecvRespSys */
#define BRCM_SWDSGN_ETHERNET_FETCHSTATE_PROC            (0xD00FU)   /**< @brief #ETHERNET_FetchState */
#define BRCM_SWDSGN_ETHERNET_TASK_PROC                  (0xD011U)   /**< @brief #ETHERNET_Task */
#define BRCM_SWDSGN_ETHERNET_FNTABLE_GLOBAL             (0xD012U)   /**< @brief #ETHERNET_FnTable */
/** @} */

/**
    @brief ETHERNET error notification structure

    @trace #BRCM_SWARCH_ETHERNET_FNTABLE_GLOBAL
    @trace #BRCM_SWREQ_ETHERNET_TASK
*/
typedef struct sETHERNET_ErrorNotifnType {
    BCM_GroupIDType groupID;  /**< @brief Group ID */
    BCM_CompIDType compID;    /**< @brief Component ID */
    int32_t error;            /**< @brief Error to be notified */
} ETHERNET_ErrorNotifnType;

/**
    @brief Memory for error notification messages

    @trace #BRCM_SWARCH_ETHERNET_FNTABLE_GLOBAL
    @trace #BRCM_SWREQ_ETHERNET_TASK
*/
static ETHERNET_ErrorNotifnType ETHERNET_ErrorNotif[MSGQ_SIZE] COMP_SECTION(".bss.ethsrv");

/**
    @brief Memory for commands from system service

    @trace #BRCM_SWARCH_ETHERNET_FNTABLE_GLOBAL
    @trace #BRCM_SWREQ_ETHERNET_TASK
*/
static SYS_CmdType ETHERNET_Cmd[MSGQ_SIZE] COMP_SECTION(".bss.ethsrv");

/**
    @brief List of all modules and its submodules in ETHSRV

    @trace #BRCM_SWARCH_ETHERNET_FNTABLE_GLOBAL
    @trace #BRCM_SWREQ_ETHERNET_TASK
*/
const MODULE_Type* const ETHERNET_ModuleFnTables[MODULE_COUNT_MAX] = {
    &ETHSRV_Module,
};

/**
    @brief Error reporting function

    @trace #BRCM_SWARCH_ETHERNET_FNTABLE_GLOBAL
    @trace #BRCM_SWREQ_ETHERNET_TASK
*/
void ETHERNET_ErrorReport(uint16_t aApiID, int32_t aErr, uint32_t aVal0,
                          uint32_t aVal1, uint32_t aVal2, uint32_t aVal3)
{
    const uint32_t values[4UL] = {aVal0, aVal1, aVal2, aVal3};
    BCM_ReportError((BCM_COM_ID & BCM_LOGMASK_USER), 0U, aApiID,
                    aErr, 4UL, values);
}

/**
    @brief Function which returns the command from system service

    @trace #BRCM_SWARCH_ETHERNET_FNTABLE_GLOBAL
    @trace #BRCM_SWREQ_ETHERNET_TASK
*/
static void* ETHERNET_GetCmd(uint32_t idx)
{
    void* pRet = NULL;

    if (idx < MSGQ_SIZE) {
        pRet = (void *)(&ETHERNET_Cmd[idx]);
    }
    return pRet;
}

/**
    @brief CommandQ for commands from system service

    @trace #BRCM_SWARCH_ETHERNET_FNTABLE_GLOBAL
    @trace #BRCM_SWREQ_ETHERNET_TASK
*/
MSGQ_DEFINE_V2(ETHERNET_CmdQ, ETHERNET_Task, ETHERNET_NOTIF_EVENT, MSGQ_CLIENT_SIGNAL_ENABLE,
               SYS_CmdType, ETHERNET_CmdHdrQ, ETHERNET_GetCmd, ".data.ethsrv");

/**
    @brief Check CommandQ for commands from system service

    @trace #BRCM_SWARCH_ETHERNET_FNTABLE_GLOBAL
    @trace #BRCM_SWREQ_ETHERNET_TASK
*/
static int32_t ETHERNET_CheckForCommand(SYS_CmdIDType *aCmd)
{
    uint32_t cmdMsgIdx = 0UL;
    int32_t retVal = MSGQ_GetMsgIdx(&ETHERNET_CmdQ, &cmdMsgIdx);
    if (BCM_ERR_OK == retVal) {
        *aCmd = ETHERNET_Cmd[cmdMsgIdx].cmd;
    }
    return retVal;
}

/**
    @brief Complete commands in CommandQ for system service

    @trace #BRCM_SWARCH_ETHERNET_FNTABLE_GLOBAL
    @trace #BRCM_SWREQ_ETHERNET_TASK
*/
static void ETHERNET_TryCompleteMsg(int32_t aError)
{
    uint32_t cmdMsgIdx = 0UL;
    int32_t retVal = MSGQ_GetMsgIdx(&ETHERNET_CmdQ, &cmdMsgIdx);
    if (BCM_ERR_OK == retVal) {
        ETHERNET_Cmd[cmdMsgIdx].response = aError;
        (void)MSGQ_CompleteMsgIdx(&ETHERNET_CmdQ, cmdMsgIdx);
    }
}

/**
    @brief Get the error notification

    @trace #BRCM_SWARCH_ETHERNET_FNTABLE_GLOBAL
    @trace #BRCM_SWREQ_ETHERNET_TASK
*/
static void* ETHERNET_GetNotif(uint32_t idx)
{
    void* pRet = NULL;

    if (idx < MSGQ_SIZE) {
        pRet = (void *)(&ETHERNET_ErrorNotif[idx]);
    }
    return pRet;
}


/**
    @brief Error notification message queue

    @trace #BRCM_SWARCH_ETHERNET_FNTABLE_GLOBAL
    @trace #BRCM_SWREQ_ETHERNET_TASK
*/
MSGQ_DEFINE_V2(ETHERNET_NotifQ, ETHERNET_Task, ETHERNET_NOTIF_EVENT, MSGQ_CLIENT_SIGNAL_DISABLE,
               ETHERNET_ErrorNotifnType, ETHERNET_NotifHdrQ, ETHERNET_GetNotif, ".data.ethsrv");

/**
    @brief Function to send error notification

    @trace #BRCM_SWARCH_ETHERNET_FNTABLE_GLOBAL
    @trace #BRCM_SWREQ_ETHERNET_TASK
*/
static int32_t ETHERNET_SendErrNotification(BCM_GroupIDType aSenderGroupID,
                                          BCM_CompIDType aSenderCompID,
                                          int32_t aError)
{
    ETHERNET_ErrorNotifnType notif;
    notif.groupID = aSenderGroupID;
    notif.compID = aSenderCompID;
    notif.error = aError;
    return MSGQ_SendMsg(&ETHERNET_NotifQ, &notif, MSGQ_NO_CLIENTMASK, NULL);
}

/**
    @brief Function for system service to post command

    @trace #BRCM_SWARCH_ETHERNET_FNTABLE_GLOBAL
    @trace #BRCM_SWREQ_ETHERNET_TASK
*/
static int32_t ETHERNET_SendCmdSys(const SYS_CmdType *const aCmd,
                                 const uint32_t aClientMask,
                                 const MSGQ_MsgHdrType** const aHdr)
{
    int32_t retVal;

    if ((NULL != aCmd)
        && (BCM_GROUPID_ETHSRV == aCmd->groupID)
        && (BCM_COM_ID == aCmd->compID)
        && (NULL != aHdr)) {
        if (SYS_CMD_ID_INIT == aCmd->cmd) {
            retVal = BCM_ActivateTask(ETHERNET_Task);
            if (BCM_ERR_OK != retVal) {
                /* LOG ERROR */
            }
        }
        retVal = MSGQ_SendMsg(&ETHERNET_CmdQ, (const void *) aCmd, aClientMask, aHdr);
    } else {
        retVal = BCM_ERR_INVAL_PARAMS;
    }

    return retVal;
}

/**
    @brief Function for system service to get command response

    @trace #BRCM_SWARCH_ETHERNET_FNTABLE_GLOBAL
    @trace #BRCM_SWREQ_ETHERNET_TASK
*/
static int32_t ETHERNET_RecvRespSys(const MSGQ_MsgHdrType* const aHdr,
                                  SYS_CmdType* const aCmd)
{
    int32_t retval;

    if ((NULL != aHdr) && (NULL != aCmd)) {
        retval = MSGQ_RecvMsg(&ETHERNET_CmdQ, aHdr, (void *) aCmd);
    } else {
        retval = BCM_ERR_INVAL_PARAMS;
    }

    return retval;
}

/**
    @brief Function to get the state of ETHSRV

    @trace #BRCM_SWARCH_ETHERNET_FNTABLE_GLOBAL
    @trace #BRCM_SWREQ_ETHERNET_TASK
*/
static BCM_StateType ETHERNET_FetchState(void)
{
    return ETHSRV_Module.context->state;
}

/**
    @brief ETHERNET Task function

    @trace #BRCM_SWARCH_ETHERNET_FNTABLE_GLOBAL
    @trace #BRCM_SWREQ_ETHERNET_TASK

    @code{.unparsed}
    ETHUTILS_Init()
    BCM_MODULE_GET_ALL_MASK(ETHERNET_ModuleFnTables, idx, modMask)

    waitMask = ETHERNET_MSGQ_CMD_EVENT | ETHERNET_NOTIF_EVENT | ShutdownEvent
    waitMask |= ETHERNET_CAN_EVENT
    waitMask |= MDIO_STATE_HANDLER_EVENT
    waitMask |= modMask

    do
     do
         prevState = state
         ETHSRV_PROCESS_COMMANDS(&aCmdState)
         switch(state)
             case BCM_STATE_UNINIT:
                 retVal = ETHERNET_CheckForCommand(&cmdVal)
                 if (BCM_ERR_OK == retVal)
                     if (SYS_CMD_ID_INIT == cmdVal)
                         BCM_MODULE_RESET_STATE_HANDLER(ETHERNET_ModuleFnTables,
                                 idx, retVal)
                         if (BCM_ERR_OK == retVal)
                             state = BCM_STATE_INIT
#ifdef ENABLE_RPC
                                if (BCM_STATE_SUB_STATE_RESET == subState)
                                    (void)BCM_ActivateTask(ETHERNET_RPC_SERVER_TASK)
                                    subState = BCM_STATE_SUB_STATE_STAGE0
                                else
                                    BCM_StateType compState = BCM_STATE_UNINIT
                                    retVal = SYS_GetState(BCM_GROUPID_ETHSRV, BCM_RPC_ID, &compState)
                                    if (BCM_ERR_OK != retVal)
                                        ETHERNET_ErrorReport(BRCM_SWDSGN_ETHERNET_TASK_PROC, retVal,
                                            0UL, 0UL, 0UL, __LINE__)
                                    else
                                        if (BCM_STATE_INIT == compState)
                                            state = BCM_STATE_INIT
                                            subState = BCM_STATE_SUB_STATE_RESET
                                            ETHERNET_TryCompleteMsg(BCM_ERR_OK)
                                        if (BCM_STATE_ERROR == compState)
                                            ETHERNET_ErrorReport(BRCM_SWDSGN_ETHERNET_TASK_PROC, retVal,
                                                0UL, 0UL, compState, __LINE__)
                                            state = BCM_STATE_INIT
                                            subState = BCM_STATE_SUB_STATE_RESET
                                            ETHERNET_TryCompleteMsg(BCM_ERR_OK)
#else
                                state = BCM_STATE_INIT
                                ETHERNET_TryCompleteMsg(BCM_ERR_OK)
#endif
                      else
                         ETHERNET_TryCompleteMsg(BCM_ERR_INVAL_STATE)
                 break
             case BCM_STATE_INIT:
                 retVal = ETHERNET_CheckForCommand(&cmdVal)
                 if (BCM_ERR_OK == retVal)
                     if (SYS_CMD_ID_CONFIG == cmdVal)
                         BCM_MODULE_INIT_STATE_HANDLER(ETHERNET_ModuleFnTables,
                                                 idx, retVal)
                         if (BCM_ERR_OK == retVal)
                             state = BCM_STATE_READY
                             retVal = ETHSRV_Notification(ETHSRV_EVENT_ETHSRV_READY, NULL, 0UL);
                             if (BCM_ERR_OK != retVal)
                                 ETHSRV_ReportError(BRCM_SWDSGN_ETHERNET_TASK_PROC, retVal,
                                         (uint32_t)__LINE__, BCM_GROUPID_ETHSRV, BCM_COM_ID,
                                         ETHSRV_EVENT_ETHSRV_READY)
                                 retVal = BCM_ERR_OK
                                 ETHERNET_TryCompleteMsg(BCM_ERR_OK);
                      else
                         ETHERNET_TryCompleteMsg(BCM_ERR_INVAL_STATE)
                 break
             case BCM_STATE_READY:
                 retVal = ETHERNET_CheckForCommand(&cmdVal)
                 if (BCM_ERR_OK == retVal)
                     if (SYS_CMD_ID_START == cmdVal)
                         BCM_MODULE_READY_STATE_HANDLER(ETHERNET_ModuleFnTables,
                                                 BCM_STATE_RUN, idx, retVal)
                         if (BCM_ERR_OK == retVal)
                             state = BCM_STATE_RUN
                             ETHERNET_TryCompleteMsg(BCM_ERR_OK);
                      else if (SYS_CMD_ID_DEINIT == cmdVal)
                         BCM_MODULE_READY_STATE_HANDLER(ETHERNET_ModuleFnTables,
                                             BCM_STATE_UNINIT, idx, retVal)
                         if (BCM_ERR_OK == retVal)
                             state = BCM_STATE_UNINIT
                             exitTask = TRUE
                             ETHERNET_TryCompleteMsg(BCM_ERR_OK);
                      else
                         ETHERNET_TryCompleteMsg(BCM_ERR_INVAL_STATE)
                 break
             case BCM_STATE_RUN:
                 retVal = ETHERNET_CheckForCommand(&cmdVal)
                 if (BCM_ERR_OK == retVal)
                     if (SYS_CMD_ID_STOP == cmdVal)
                         BCM_MODULE_RUN_STATE_HANDLER(ETHERNET_ModuleFnTables,
                                                 BCM_STATE_READY, idx, retVal)
                         if (BCM_ERR_OK == retVal)
                             state = BCM_STATE_READY
                             ETHERNET_TryCompleteMsg(BCM_ERR_OK);
                      else if (SYS_CMD_ID_DEINIT == cmdVal)
                         BCM_MODULE_RUN_STATE_HANDLER(ETHERNET_ModuleFnTables,
                                             BCM_STATE_UNINIT, idx, retVal)
                         if (BCM_ERR_OK == retVal)
                             state = BCM_STATE_UNINIT
                             exitTask = TRUE
                             ETHERNET_TryCompleteMsg(BCM_ERR_OK);
                      else
                         ETHERNET_TryCompleteMsg(BCM_ERR_INVAL_STATE)
                 break
             default:
                 break
      while (prevState != state)

     if (TRUE != exitTask)
         ETHSRV_PROCESS_COMMANDS(&aCmdState)
         BCM_WaitEvent(waitMask)
         BCM_GetEvent(ETHERNET_Task, &mask)
         BCM_ClearEvent(mask)
         BCM_MODULE_PROCESS_EVENTS(ETHERNET_ModuleFnTables, idx, mask)
         if ((mask & ETHERNET_CAN_EVENT) == ETHERNET_CAN_EVENT)
             ETHERNET_CAN_PROCESS(0UL)
    while (exitTask != TRUE)
#ifdef ENABLE_RPC
    BCM_SetEvent(ETHERNET_RPC_SERVER_TASK, ShutdownEvent);
#endif
    BCM_TerminateTask()
    @endcode
*/
TASK(ETHERNET_Task)
{
    BCM_StateType state = BCM_STATE_UNINIT;
    BCM_StateType prevState;
    int32_t exitTask = FALSE;
    int32_t retVal = BCM_ERR_OK;
    BCM_EventMaskType mask = 0UL;
    BCM_EventMaskType modMask = 0UL;
    BCM_EventMaskType waitMask = 0UL;
    SYS_CmdIDType cmdVal = SYS_CMD_ID_MAX;
#ifdef ENABLE_RPC
    uint32_t subState = BCM_STATE_SUB_STATE_RESET;
#endif

    ETHUTILS_Init();

    modMask = MODULE_GetEventMask(ETHERNET_ModuleFnTables, MODULE_COUNT_MAX);

    waitMask = ETHERNET_MSGQ_CMD_EVENT | ETHERNET_NOTIF_EVENT | ShutdownEvent;
#if defined(ENABLE_ETHERNET_MCAN)
    waitMask |= ETHERNET_CAN_EVENT;
#endif

    /* Adding all modules mask */
    waitMask |= modMask;

    do {
        do {
            prevState = state;
            switch(state) {
                case BCM_STATE_UNINIT:
                    retVal = ETHERNET_CheckForCommand(&cmdVal);
                    if (BCM_ERR_OK == retVal) {
                        if (SYS_CMD_ID_INIT == cmdVal) {
                            retVal = MODULE_ResetStateHandler(ETHERNET_ModuleFnTables, MODULE_COUNT_MAX);
                            if (BCM_ERR_OK == retVal) {
#ifdef ENABLE_RPC
                                if (BCM_STATE_SUB_STATE_RESET == subState) {
                                    (void)BCM_ActivateTask(ETHERNET_RPC_SERVER_TASK);
                                    subState = BCM_STATE_SUB_STATE_STAGE0;
                                } else {
                                    BCM_StateType compState = BCM_STATE_UNINIT;
                                    retVal = SYS_GetState(BCM_GROUPID_ETHSRV, BCM_RPC_ID, &compState);
                                    if (BCM_ERR_OK != retVal) {
                                        ETHERNET_ErrorReport(BRCM_SWDSGN_ETHERNET_TASK_PROC, retVal,
                                            0UL, 0UL, 0UL, __LINE__);
                                    } else {
                                        if (BCM_STATE_INIT == compState) {
                                            state = BCM_STATE_INIT;
                                            subState = BCM_STATE_SUB_STATE_RESET;
                                            ETHERNET_TryCompleteMsg(BCM_ERR_OK);
                                        }
                                        if (BCM_STATE_ERROR == compState) {
                                            ETHERNET_ErrorReport(BRCM_SWDSGN_ETHERNET_TASK_PROC, retVal,
                                                0UL, 0UL, compState, __LINE__);
                                            state = BCM_STATE_INIT;
                                            subState = BCM_STATE_SUB_STATE_RESET;
                                            ETHERNET_TryCompleteMsg(BCM_ERR_OK);
                                        }
                                    }
                                }
#else
                                state = BCM_STATE_INIT;
                                ETHERNET_TryCompleteMsg(BCM_ERR_OK);
#endif
                            }
                        } else {
                            ETHERNET_TryCompleteMsg(BCM_ERR_INVAL_STATE);
                        }
                    }
                    break;
                case BCM_STATE_INIT:
                    retVal = ETHERNET_CheckForCommand(&cmdVal);
                    if (BCM_ERR_OK == retVal) {
                        if (SYS_CMD_ID_CONFIG == cmdVal) {
                            retVal = MODULE_InitStateHandler(ETHERNET_ModuleFnTables, MODULE_COUNT_MAX);
                            if (BCM_ERR_OK == retVal) {
                                state = BCM_STATE_READY;
                                ETHERNET_TryCompleteMsg(BCM_ERR_OK);
                            }
                        } else {
                            ETHERNET_TryCompleteMsg(BCM_ERR_INVAL_STATE);
                        }
                    }
                    break;
                case BCM_STATE_READY:
                    retVal = ETHERNET_CheckForCommand(&cmdVal);
                    if (BCM_ERR_OK == retVal) {
                        if (SYS_CMD_ID_START == cmdVal) {
                            retVal = MODULE_ReadyStateHandler(ETHERNET_ModuleFnTables, MODULE_COUNT_MAX, BCM_STATE_RUN);
                            if (BCM_ERR_OK == retVal) {
                                state = BCM_STATE_RUN;
                                ETHERNET_TryCompleteMsg(BCM_ERR_OK);
                            }
                        } else if (SYS_CMD_ID_DEINIT == cmdVal) {
                            retVal = MODULE_ReadyStateHandler(ETHERNET_ModuleFnTables, MODULE_COUNT_MAX, BCM_STATE_UNINIT);
                            if (BCM_ERR_OK == retVal) {
                                state = BCM_STATE_UNINIT;
                                exitTask = TRUE;
                                ETHERNET_TryCompleteMsg(BCM_ERR_OK);
                            }
                        } else {
                            ETHERNET_TryCompleteMsg(BCM_ERR_INVAL_STATE);
                        }
                    }
                    break;
                case BCM_STATE_RUN:
                    retVal = ETHERNET_CheckForCommand(&cmdVal);
                    if (BCM_ERR_OK == retVal) {
                        if (SYS_CMD_ID_STOP == cmdVal) {
                            retVal = MODULE_RunStateHandler(ETHERNET_ModuleFnTables, MODULE_COUNT_MAX, BCM_STATE_READY);
                            if (BCM_ERR_OK == retVal) {
                                state = BCM_STATE_READY;
                                ETHERNET_TryCompleteMsg(BCM_ERR_OK);
                            }
                        } else if (SYS_CMD_ID_DEINIT == cmdVal) {
                            retVal = MODULE_RunStateHandler(ETHERNET_ModuleFnTables, MODULE_COUNT_MAX, BCM_STATE_UNINIT);
                            if (BCM_ERR_OK == retVal) {
                                state = BCM_STATE_UNINIT;
                                exitTask = TRUE;
                                ETHERNET_TryCompleteMsg(BCM_ERR_OK);
                            }
                        } else {
                            ETHERNET_TryCompleteMsg(BCM_ERR_INVAL_STATE);
                        }
                    }
                    break;
                default:
                    break;
            }
        } while (prevState != state);

        if (TRUE != exitTask) {
            BCM_WaitEvent(waitMask);
            BCM_GetEvent(ETHERNET_Task, &mask);
            BCM_ClearEvent(mask);
            MODULE_EventHandler(ETHERNET_ModuleFnTables, MODULE_COUNT_MAX, mask);
#ifdef ENABLE_ETHERNET_MCAN
            if ((mask & ETHERNET_CAN_EVENT) == ETHERNET_CAN_EVENT) {
                /* Process CAN */
                ETHERNET_CAN_PROCESS(0UL);
            }
#endif
        }

    } while (exitTask != TRUE);

#ifdef ENABLE_RPC
    BCM_SetEvent(ETHERNET_RPC_SERVER_TASK, ShutdownEvent);
#endif
    (void)BCM_TerminateTask();
}

/**
    @brief ETHERNET interface for system service

    @trace #BRCM_SWARCH_ETHERNET_FNTABLE_GLOBAL
    @trace #BRCM_SWREQ_ETHERNET_TASK
*/
const SYS_FnTblType ETHERNET_FnTable =
{
    .parentGroupID = BCM_GROUPID_SYS,
    .parentCompID = BCM_SYS_ID,
    .groupID = BCM_GROUPID_ETHSRV,
    .compID = BCM_COM_ID,
    .sendCmd = ETHERNET_SendCmdSys,
    .recvResp = ETHERNET_RecvRespSys,
    .getState = ETHERNET_FetchState,
    .notifyError = ETHERNET_SendErrNotification,
};

/** @} */
