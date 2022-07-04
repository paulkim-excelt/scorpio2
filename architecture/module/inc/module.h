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

    @defgroup grp_module_ifc Module Interface
    @ingroup grp_module

    @addtogroup grp_module_ifc
    @{

    @tagseq service_state_seq_diagram.svg "State Transition Sequence diagram"
    @startseq
    group {label = "client"; color = "#EFFFFF";  Client;service.client;};
    group {label = "service"; color = "#FFEFFF"; service.server; service.modules;};
    Client => service.client [label = "xxxStateHandler"] {
        service.client -> service.server [label = "MSGQ_SendMsg", note = "to service.client.cmdQ"] {
            service.server => service.modules [label = "xxxStateHandler"];
        };
    };
    service.client <- service.server [label = "MSGQ_CompleteMsg", note = "on service.client.cmdQ"];
    Client => service.client [label = "xxxStateHandler"] {
        service.client => service.server [label = "MSGQ_RecvMsg", note = "to service.client.cmdQ"];
    };
    @endseq

    @tagseq service_msg_seq_diagram.svg "Message Sequence diagram"
    @startseq
    group {label = "client"; color = "#EFFFFF";  Client;service.client;};
    group {label = "service"; color = "#FFEFFF"; service.server; service.modules;};
    Client => service.client [label = "sendCmd"] {
        service.client -> service.server [label = "service.server.sendMsg"] {
            service.server => service.modules [label = "service.modules.sendMsg", rightnote="MSGQ_SendMsg to service.server.cmdQ if aHandle is 1ULL"];
        };
    };
    service.server => service.modules [label = "processCmd"];
    service.client <- service.server [label = "notify client via MSGQ_CompleteMsg"];
    Client => service.client [label = "getResp"] {
        service.client -> service.server [label = "service.server.getResp"] {
            service.server => service.modules [label = "service.modules.recvMsg", rightnote="MSGQ_RecvMsg to service.server.cmdQ if aHandle belong here"];
        };
    };
    @endseq

    @file module.h
    @brief Generic Module Interface

    @version 0.1 Initial version
*/

#ifndef MODULE_H
#define MODULE_H

#include <inttypes.h>
#include <stddef.h>
#include <bcm_err.h>
#include <bcm_comp.h>
#include <msg_queue.h>

/**
    @name MODULE Architecture IDs
    @{
    @brief Architecture IDs
*/
#define BRCM_SWARCH_MODULE_MSG_CHECK_TYPE         (0x8201U)    /**< @brief #MODULE_MsgCheckType       */
#define BRCM_SWARCH_MODULE_COUNT_MAX_MACRO        (0x8202U)    /**< @brief #MODULE_COUNT_MAX          */
#define BRCM_SWARCH_MODULE_SEND_CMD_TYPE          (0x8203U)    /**< @brief #MODULE_SendCmdType        */
#define BRCM_SWARCH_MODULE_GET_RESP_TYPE          (0x8204U)    /**< @brief #MODULE_GetRespType        */
#define BRCM_SWARCH_MODULE_MERGE_RESULT_TYPE      (0x8205U)    /**< @brief #MODULE_MergeResultType    */
#define BRCM_SWARCH_MODULE_ASYNC_NOTIF_TYPE       (0x8206U)    /**< @brief #MODULE_AsyncNotifType     */
#define BRCM_SWARCH_MODULE_PROCESS_CMD_TYPE       (0x8207U)    /**< @brief #MODULE_ProcessCmdType     */
#define BRCM_SWARCH_MODULE_STATE_HANDLER_TYPE     (0x8208U)    /**< @brief #MODULE_StateHandlerType   */
#define BRCM_SWARCH_MODULE_EVENT_HANDLER_TYPE     (0x8209U)    /**< @brief #MODULE_EventHandlerType   */
#define BRCM_SWARCH_MODULE_GET_EVENT_MASK_TYPE    (0x820AU)    /**< @brief #MODULE_GetEventMaskType   */
#define BRCM_SWARCH_MODULE_TYPE                   (0x820BU)    /**< @brief #MODULE_Type               */
#define BRCM_SWARCH_MODULE_CONTEXT_TYPE           (0x820CU)    /**< @brief #MODULE_ContextType        */
#define BRCM_SWARCH_SERVICE_STATE_QUEUE_TYPE      (0x820DU)    /**< @brief #SERVICE_StateQueueType    */
#define BRCM_SWARCH_SERVICE_TYPE                  (0x820EU)    /**< @brief #SERVICE_Type              */
/** @} */

/**
    @brief Maximum modules to System/Sub-System

    Maximum number of modules to System/Sub-System that is supported.

    @trace #BRCM_SWREQ_MODULE
*/
#define MODULE_COUNT_MAX  (16UL)

/**
    @name message check type
    @{
    @brief Message ID check for underlying children

    @trace #BRCM_SWREQ_MODULE
*/
typedef uint32_t MODULE_MsgCheckType;
#define MODULE_MSG_CHECK_COMP_ID   (0UL)
#define MODULE_MSG_CHECK_MSG_ID    (1UL)
/** @} */

/** @brief Send a command to the module

    This API performs the following
        -# Validates the command
        -# When stacking is enabled, identifies if it is processed only locally
            or to be sent to slave or both
        -# If the module has its own queue of commands, the command is added to
            queue, otherwise, reports to the caller that it may need to be queued

    This API gets executed in the context of a client task (not same as state
    handler or event handler or process cmd).

    @behavior Sync, Reentrant

    @pre None

    @param[in]   aCmd                   Command group, component and ID
    @param[in]   aCmdDataLen            Length of the command data payload in bytes
    @param[in]   aCmdData               Pointer to the command data payload
    @param[out]  aHandle                Pointer to BCM_HandleType for later query
                                        using #BCM_ModGetStatusType
                                        (Assumed to be set to zero by root caller,
                                        Updated to 1ULL if local processing is needed.
                                        When 1ULL, caller may put to message QUeue and
                                        update this value)
    @param[out]  aForwardToSlaves       Boolean to indicate if command needs to be
                                        forwarded to connected slaves

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Command validated successfully
    @retval     #BCM_ERR_NOSUPPORT      Invalid #aCmd
    @retval     #BCM_ERR_NOMEM          If queue is full
    @retval     #BCM_ERR_INVAL_PARAMS   aCmdData is NULL or aHandle is NULL or
                                        aForwardToSlaves is NULL or
                                        Invalid params in command payload

    @post None

    @limitations None

    @trace #BRCM_SWREQ_MODULE
*/
typedef int32_t (*MODULE_SendCmdType)(BCM_CmdType    aCmd,
                                    uint32_t        aCmdDataLen,
                                    const uint8_t   *aCmdData,
                                    BCM_HandleType  *aHandle,
                                    uint32_t        *aForwardToSlaves);


/** @brief Get response from the module for a given command

    This API validates the handle and retrieves the response.
    This API gets executed in the context of a client task (not same as state
    handler or event handler or process cmd).

    @behavior Sync, Reentrant

    @pre None

    @param[in]   aHandle                BCM Handle to retrieve response for
    @param[in]   aReplyID               Reply ID (group, comp, cmd)
    @param[in]   aInLen                 Available Length of the reply data payload in bytes
    @param[out]  aReplyData             Pointer to the reply data payload
    @param[out]  aReplyDataLen          Actual Length of the reply data payload in bytes

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Command completed successfully
    @retval     #BCM_ERR_BUSY           Busy processing command
    @retval     #BCM_ERR_NOSUPPORT      Invalid #aReplyID
    @retval     #BCM_ERR_UNKNOWN        Failed to fetch the response
    @retval     #BCM_ERR_INVAL_PARAMS   aHandle is invalid or aReplyData is NULL
                                        or aReplyDataLen is NULL

    @post None

    @limitations None

    @trace #BRCM_SWREQ_MODULE
*/
typedef int32_t (*MODULE_GetRespType)(BCM_HandleType aHandle,
                                    BCM_CmdType aReplyID,
                                    uint32_t aInLen,
                                    uint8_t *aReplyData,
                                    uint32_t *aReplyDataLen);

/** @brief Merge results

    Merge results from master/slaves into one response to caller

    This API gets executed in the context of a client task (not same as state
    handler or event handler or process cmd).

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aCmd                Command group, component and ID
    @param[in]      aLen                Length of response
    @param[out]     aOutResponse        Pointer to merged response (of aLen)
    @param[out]     aOutResult          Pointer to merged result
    @param[in]      aInResponse1        Pointer to first response message to be merged
    @param[in]      aInResult1          Result1 to be merged (of BCM Error types)
    @param[in]      aInResponse2        Pointer to second response message to be merged
    @param[in]      aInResult2          Result2 to be merged (of BCM Error types)

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Command status retrieved successfully
    @retval     #BCM_ERR_NOSUPPORT      Invalid #aCmd
    @retval     #BCM_ERR_INVAL_PARAMS   aOutResponse is NULL or
                                        aOutResult is NULL or
                                        aInResponse1 is NULL or
                                        aInResponse2 is NULL or

    @post None

    @limitations None

    @trace #BRCM_SWREQ_MODULE
*/
typedef int32_t (*MODULE_MergeResultType)(BCM_CmdType aCmd,
                                          uint32_t aLen,
                                          uint8_t *aOutResponse,
                                          int32_t *aOutResult,
                                          const uint8_t *aInResponse1,
                                          int32_t aInResult1,
                                          const uint8_t *aInResponse2,
                                          int32_t aInResult2);

/** @brief Async Notification Message to Host or Component

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  aNotfn                 Notification and Component ID
    @param[in]  aMsg                   Async Message payload
    @param[in]  aLen                   Length of the Async message
    @param[out] aForwardToHost         Flag to indicate if message needs to be
                                     forwarded to host

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Message processed successfully
    @retval     #BCM_ERR_NOSUPPORT      Invalid #aNotfn
    @retval     #BCM_ERR_INVAL_PARAMS   aMsg is NULL or
                                        aForwardToHost is NULL or
                                        Invalid params in message payload

    @post None

    @trace  #BRCM_SWREQ_MODULE

    @limitations None
*/
typedef int32_t (*MODULE_AsyncNotifType)(BCM_CmdType aNotfn,
                                        const uint8_t *aMsg,
                                        uint32_t aLen,
                                        uint32_t *aForwardToHost);

/** @brief Process the command to the module

    Process the module command.

    This API gets executed in the context of the Caller task.

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]    aCmd                  Command group, component and ID
    @param[inout] aCmdState             Status of command processing,
                                        Caller should change state to #BCM_CMD_STATE_RESET
                                        on return of #BCM_ERR_OK.
    @param[inout] aCmdData              Pointer to the command payload
    @param[in]    aLen                  Length of the command payload in bytes
    @param[out]   aReplyLen             Length of the responce in bytes

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Command processed successfully
    @retval     #BCM_ERR_EAGAIN         API needs to be invoked again (on an event)
    @retval     #BCM_ERR_NOSUPPORT      Invalid #aCmdID, not supported
    @retval     #BCM_ERR_INVAL_PARAMS   aCmdStatus/aCmdData/aLen is NULL
                                        Invalid #aLen

    @post None

    @limitations None

    @trace #BRCM_SWREQ_MODULE
*/
typedef int32_t (*MODULE_ProcessCmdType)(BCM_CmdType aCmd,
                                        BCM_SubStateType *const aCmdState,
                                        uint8_t *const aCmdData,
                                        uint32_t aLen,
                                        uint32_t *const aReplyLen);

/** @brief Module state handler

    Process the state change requests sent to the module. Only valid state
    change requests shall be sent to module.

    This API gets executed in the context of the Caller task.

    @behavior Sync, Non-reentrant

    @pre Module implementation shall assume that only valid #aRequestedState
    will be passed to this API. Caller Task is aware of the module state and
    will always provide a valid #aRequestedState.

    @param[in]   aReqState          The next state to which
                                    module needs to transition

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             State transitioned successfully
    @retval     #BCM_ERR_BUSY           API needs to be invoked again (on an event)
    @retval     #BCM_ERR_UNKNOWN        Integration error

    @post None

    @limitations The transition from BCM_STATE_UNINIT to BCM_STATE_INIT shall
    complete synchronously in a single invocation of this API.

    @trace #BRCM_SWREQ_MODULE
*/
typedef int32_t (*MODULE_StateHandlerType)(BCM_StateType aReqState);

/** @brief Module event handler

    Process the events of the module

    This API gets executed in the context of the caller task.

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]   aMask                  Event mask that is set

    @retval void

    @post None

    @limitations None

    @trace #BRCM_SWREQ_MODULE
*/
typedef void (*MODULE_EventHandlerType)(uint32_t aMask);

/** @brief Get the event mask for the module

    API to return the event mask for the module. The SYSTEM will invoke
    the #MODULE_EventHandlerType of the module in case the specified
    event of the module was set.

    This API gets executed in the context of the caller task.

    @behavior Sync, Reentrant

    @pre None

    @param void

    @retval     #uint32_t   Event mask for the module

    @post None

    @limitations Must return the same event mask at any point of time
    i.e. it cannot be changed dynamically.

    @trace #BRCM_SWREQ_MODULE
*/
typedef uint32_t (*MODULE_GetEventMaskType)(void);

/**
    @brief Module context type

    Module context structure that is used by the caller to
    maintain the module's state transition or the loading
    of the configuration images.

    @trace #BRCM_SWREQ_MODULE
 */
typedef struct sMODULE_ContextType {
    BCM_StateType       state;              /**< @brief Current state of the module             */
    BCM_SubStateType    subState;           /**< @brief Sub state of the module                 */
    BCM_HandleType      handle;             /**< @brief Handle to track other task activities   */
    BCM_SubStateType    cfgLoadState;       /**< @brief Sub state of the config load for internal use only.
                                                This should not be used in module implementation*/
    uint32_t            cfgLoadSize;        /**< @brief Config image size that is fetched       */
    uint32_t            isCfgLoaded;        /**< @brief Boolean to indicate if module config image is loaded */
    uint32_t            custom[4UL];        /**< @brief Used as per implementer                 */
    int32_t             errCode;            /**< @brief Error code preserved temporarily        */
} MODULE_ContextType;

/**
    @brief Module information structure

    Each module that integrates into SYSTEM shall provide relevant
    functions as function pointers listed below.

    @trace #BRCM_SWREQ_MODULE
 */
typedef struct sMODULE_Type {
    BCM_GroupIDType             groupID;           /**< @brief Group ID             */
    uint8_t                     rsvd0[3UL];        /**< @brief Reserved             */
    BCM_CompIDType              compID;            /**< @brief Component ID         */
    uint16_t                    configImgID;       /**< @brief Config image identifier */
    uint8_t                     *configImgData;     /**< @brief Pointer to memory where image
                                                            needs to be fetched     */
    uint32_t                    configImgSize;     /**< @brief Image size in bytes  */
    uint8_t                     cmdStart;          /**< @brief Cmd start range      */
    uint8_t                     cmdEnd;            /**< @brief Cmd end range        */
    MODULE_ContextType          *context;          /**< @brief Context of module    */
    MODULE_StateHandlerType     resetStateHandler; /**< @brief Reset state handler  */
    MODULE_StateHandlerType     initStateHandler;  /**< @brief Init state handler   */
    MODULE_StateHandlerType     readyStateHandler; /**< @brief Ready state handler  */
    MODULE_StateHandlerType     runStateHandler;   /**< @brief Run state handler    */
    MODULE_EventHandlerType     eventHandler;      /**< @brief Event handler        */
    MODULE_ProcessCmdType       processCmd;        /**< @brief Process command. This must be NULL if the commands
                                                        are queued within the module either via cmdQ or otherwise   */
    MODULE_GetEventMaskType     getEventMask;      /**< @brief Get event mask       */
    const struct sMODULE_Type *const* subModules;  /**< @brief Submodule list       */

    MSGQ_Type                   cmdQ;              /**< @brief Command Queue,
                                                        usage maybe dependent on module,
                                                        and maybe initialized by module */
    MODULE_SendCmdType          sendCmd;           /**< @brief Send the command     */
    MODULE_GetRespType          getResp;           /**< @brief Get the response     */
    MODULE_MergeResultType      mergeResult;       /**< @brief Merge results        */
    MODULE_AsyncNotifType       asyncMsg;          /**< @brief Async message        */

} MODULE_Type;

/**
    @brief Service Interface for integration into system

    @trace #BRCM_SWREQ_SERVICE
*/
typedef struct sSERVICE_Type {
    BCM_GroupIDType             group;              /**< @brief group           */
    MODULE_Type                 client;             /**< @brief Client Module   */
    MODULE_Type                 server;             /**< @brief Server Module   */
    BCM_StateType               *state;             /**< @brief Server State Request */
    const MODULE_Type *const    modules[MODULE_COUNT_MAX];  /**< @brief module list*/
} SERVICE_Type;

#endif /* MODULE_H */
/** @} */
