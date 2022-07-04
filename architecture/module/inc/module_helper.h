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
    @defgroup grp_module_helper_ifc Helpers
    @ingroup grp_module

    @addtogroup grp_module_helper_ifc
    @{

    @file module_helper.h

    @brief Generic Module Handler Interface
    @version 0.1 Initial version
*/

#ifndef MODULE_HANDLER_H
#define MODULE_HANDLER_H

#include <module.h>
#include <osil/module_osil.h>

/**
    @name SYSTEM Module Handler API IDs
    @{
    @brief API IDs for Module Handler in System and underlying Subsystem
*/
#define BRCM_SWARCH_MODULE_SEND_CMD_PROC            (0x8302U)    /**< @brief #MODULE_SendCmd            */
#define BRCM_SWARCH_MODULE_GET_RESP_PROC            (0x8303U)    /**< @brief #MODULE_GetResp            */
#define BRCM_SWARCH_MODULE_MERGE_RESULT_PROC        (0x8304U)    /**< @brief #MODULE_MergeResult        */
#define BRCM_SWARCH_MODULE_PROCESS_CMD_PROC         (0x8306U)    /**< @brief #MODULE_ProcessCmd         */
#define BRCM_SWARCH_MODULE_RESET_STATE_HANDLER_PROC (0x8307U)    /**< @brief #MODULE_ResetStateHandler  */
#define BRCM_SWARCH_MODULE_INIT_STATE_HANDLER_PROC  (0x8308U)    /**< @brief #MODULE_InitStateHandler   */
#define BRCM_SWARCH_MODULE_READY_STATE_HANDLER_PROC (0x8309U)    /**< @brief #MODULE_ReadyStateHandler  */
#define BRCM_SWARCH_MODULE_RUN_STATE_HANDLER_PROC   (0x830AU)    /**< @brief #MODULE_RunStateHandler    */
#define BRCM_SWARCH_MODULE_GET_EVENT_MASK_PROC      (0x830BU)    /**< @brief #MODULE_GetEventMask       */
#define BRCM_SWARCH_MODULE_EVENT_HANDLER_PROC       (0x830CU)    /**< @brief #MODULE_EventHandler       */
#define BRCM_SWARCH_SERVICE_CLIENT_HANDLER_PROC     (0x830DU)    /**< @brief #SERVICE_ClientHandler     */
#define BRCM_SWARCH_SERVICE_SERVER_TASK_FUNC_PROC   (0x830EU)    /**< @brief #SERVICE_ServerTaskFunc    */
/** @} */

/** @brief Helper function to tranisiton modules from UNINIT->INIT state

    This function transitions all the modules in the pipeline sequentially
    to the BCM_STATE_INIT state

    This function follows architecture defined at @ref MODULE_StateHandlerType
    with below deltas
    @param[in]   aModules       Modules
    @param[in]   aCnt           Count of modules

    Requested state is always assumed to be #BCM_STATE_INIT

    @trace #BRCM_SWREQ_MODULE
*/
int32_t MODULE_ResetStateHandler(const MODULE_Type * const *aModules, uint32_t aCnt);

/**
    @brief Helper function to tranisiton modules from INIT->READY state

    This function transitions all the modules in the pipeline sequentially
    to the BCM_STATE_READY state

    This function follows architecture defined at @ref MODULE_StateHandlerType
    with below deltas
    @param[in]   aModules       Modules
    @param[in]   aCnt           Count of modules

    Requested state is always assumed to be #BCM_STATE_READY

    @trace #BRCM_SWREQ_MODULE
*/
int32_t MODULE_InitStateHandler(const MODULE_Type * const *aModules, uint32_t aCnt);

/**
    @brief Helper function to tranisiton modules from READY->RUN
    or READY->UNINIT state

    This function transitions all the modules in the pipeline sequentially
    to the BCM_STATE_RUN/BCM_STATE_UNINIT state based on #(aReqState) value

    This function follows architecture defined at @ref MODULE_StateHandlerType
    with below deltas
    @param[in]   aModules           Modules
    @param[in]   aCnt               Count of modules
    @param[in]   aRequestedState    Requested state is either #BCM_STATE_RUN
                                    or #BCM_STATE_UNINIT

    @trace #BRCM_SWREQ_MODULE
*/
int32_t MODULE_ReadyStateHandler(const MODULE_Type * const *aModules,
                                uint32_t aCnt, BCM_StateType aReqState);

/**
    @brief Helper function to tranisiton modules from RUN->READY
    or RUN->UNINIT state

    This function transitions all the modules in the pipeline sequentially
    to the BCM_STATE_READY/BCM_STATE_UNINIT state based on #(aReqState) value

    This function follows architecture defined at @ref MODULE_StateHandlerType
    with below deltas
    @param[in]   aModules           Modules
    @param[in]   aCnt               Count of modules
    @param[in]   aRequestedState    Requested state is either #BCM_STATE_RUN
                                    or #BCM_STATE_UNINIT

    @trace #BRCM_SWREQ_MODULE
*/
int32_t MODULE_RunStateHandler(const MODULE_Type * const *aModules,
                                uint32_t aCnt, BCM_StateType aReqState);

/**
    @brief Helper function to get the unified mask

    This function fetches the event mask for each module in the list and
    returns it to caller

    This function follows architecture defined at @ref MODULE_GetEventMaskType
    with below deltas
    @param[in]   aModules           Modules
    @param[in]   aCnt               Count of modules

    @trace #BRCM_SWREQ_MODULE
*/
uint32_t MODULE_GetEventMask(const MODULE_Type * const *aModules, uint32_t aCnt);

/**
    @brief Helper function to handle events

    This function passes the event to the modules

    This function follows architecture defined at @ref MODULE_EventHandlerType
    with below deltas
    @param[in]   aModules           Modules
    @param[in]   aCnt               Count of modules

    @trace #BRCM_SWREQ_MODULE
*/
void MODULE_EventHandler(const MODULE_Type * const *aModules,
                            uint32_t aCnt, uint32_t aEventMask);

/**
    @brief Helper function to send command

    This function sends the command by passing it to the appropriate module

    This function follows architecture defined at @ref MODULE_SendCmdType
    with below deltas
    @param[in]   aModules           Modules
    @param[in]   aCnt               Count of modules
    @param[in]   aCmdCheckType      Command check type

    @trace #BRCM_SWREQ_MODULE
*/
int32_t MODULE_SendCmd(const MODULE_Type  * const*aModules, uint32_t    aCnt,
                        MODULE_MsgCheckType  aCmdCheckType,  BCM_CmdType  aCmd,
                        uint32_t   aCmdDataLen, const uint8_t  *aCmdData,
                        BCM_HandleType      *aHandle, uint32_t   *aForwardToSlaves);

/**
    @brief Helper function to get response for a command

    This function gets the response for previously posted command
    by querying it from the appropriate module

    This function follows architecture defined at @ref MODULE_GetRespType
    with below deltas
    @param[in]   aModules           Modules
    @param[in]   aCnt               Count of modules
    @param[in]   aCmdCheckType      Command check type

    @trace #BRCM_SWREQ_MODULE
*/
int32_t MODULE_GetResp(const MODULE_Type  * const *aModules, uint32_t    aCnt,
                        MODULE_MsgCheckType aCmdCheckType, BCM_HandleType  aHandle,
                        BCM_CmdType   aReplyID, uint32_t  aInLen,
                        uint8_t     *aReplyData, uint32_t   *aOutLen);

/**
    @brief Helper function to process command

    This function processes the command by passing it to the appropriate module

    This function follows architecture defined at @ref MODULE_ProcessCmdType
    with below deltas
    @param[in]   aModules           Modules
    @param[in]   aCnt               Count of modules
    @param[in]   aCmdCheckType      Command check type

    @trace #BRCM_SWREQ_MODULE
*/
int32_t MODULE_ProcessCmd(const MODULE_Type  * const *aModules, uint32_t   aCnt,
                        MODULE_MsgCheckType aCmdCheckType, BCM_CmdType     aCmd,
                        BCM_SubStateType    *const aCmdState, uint8_t *const aCmdData,
                        uint32_t    aLen, uint32_t   *const aReplyLen);

/**
    @brief Helper function to merge result

    This function merges the result by passing it to the appropriate module

    This function follows architecture defined at @ref MODULE_MergeResultType
    with below deltas
    @param[in]   aModules           Modules
    @param[in]   aCnt               Count of modules
    @param[in]   aCmdCheckType      Command check type

    @trace #BRCM_SWREQ_MODULE
*/
int32_t MODULE_MergeResult(const MODULE_Type  * const *aModules, uint32_t aCnt,
                            MODULE_MsgCheckType aCmdCheckType, BCM_CmdType aCmd,
                            uint32_t     aLen, uint8_t  *aOutResponse, int32_t   *aOutResult,
                            const uint8_t  *aInResponse1, int32_t    aInResult1,
                            const uint8_t  *aInResponse2, int32_t     aInResult2);

/** @brief Service state change handler (runs in client context)

    Send state change requests to the service.

    This function follows architecture defined at @ref MODULE_StateHandlerType
    with below deltas

    @param[inout]   aService            Service which needs to be transitioned
                                        (context gets updated)
    @param[in]      aRequestedState     The next state to which service needs to transition

    @trace #BRCM_SWREQ_SERVICE
*/
int32_t SERVICE_ClientHandler(const SERVICE_Type *aService, BCM_StateType aRequestedState);

/** @brief Service handler (runs in service task context)

    Process the state change requests received from client, events set by other
    tasks, commands posted into the message queue. This API must be executed in
    a dedicated task.

    @behavior Async, Non-reentrant

    @pre None

    @param[inout]   aService    Service which needs to be transitioned
    @param[in]      aTask       Task in which Service is running

    @return     void

    @post None

    @trace #BRCM_SWREQ_SERVICE
*/
void SERVICE_ServerTaskFunc(const SERVICE_Type *aService, int32_t aTask);

#endif /* MODULE_HANDLER_H */
/** @} */
