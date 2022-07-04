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
    @defgroup grp_msgq_ifc Interface
    @ingroup grp_msgq

    @addtogroup grp_msgq_ifc
    @{
    Server shall allocate #MSGQ_SIZE * "number of contexts" number of messages.

    @section sec_msgq_fsm State Machine
    @subsection subsec_msgq_fsm_with_notif With Client Notification
    Each message has the following states:
    -# @b Init: All messages are in @c Init state after the component
       initialization.
    -# @b Posted: When a client posts a request, the message shall be moved to
       @c Posted state.
    -# @b Processing: When service provider starts to process the request, the
       message shall be moved to @c Processing state.
    -# @b Completed: Upon completion of the request (success/error), the message
       shall be moved to @c Completed state. In case of error, the component
       shall update the component error type in component specific structure.
       When message is moved to @c Completed state, service provider shall
       signal the client. Upon receiving the signal, Client shall call
       #MSGQ_RecvMsg to get the server response, which in turn moves the message
       to @c Init state.

    Below figure depicts the state transition for a message:
    @image html  msgq_state_machine_with_notif.jpg "State machine (with notification)"

    @subsection subsec_msgq_fsm_without_notif Without Client Notification
    Each message has the following states:
    -# @b Init: All messages are in @c Init state after the component
       initialization.
    -# @b Posted: When a client posts a request, the message state shall be
       moved to @c Posted state. After message is moved to @c Posted state,
       client shall trigger an event to the service provider.
    -# @b Processing: When service provider starts to process the request, the
       message shall be moved to @c Processing state. Upon completion of the
       request (success/error), the message shall be moved to @c Init state. In
       this mode, no notifications are sent to client.

    Below figure depicts the state transition for a message (without client
    notification):
    @image html msgq_state_machine_without_notif.jpg "State machine (without notifications)"

    @section sec_msgq_seq Sequence Diagrams
    @tagseq msgq_seq_diagram.svg "Sequence diagram"
    @startseq
    group {label = "client"; color = "#EFFFFF";  Client;};
    group {label = "Message Queue"; color = "#FFEFFF"; MSGQ;};
    group {label = "server"; color = "#FFFFEF"; Server; Example;};
    Client -> MSGQ [label = "CtxCreate"];
    MSGQ -> Server [label = "signal"] {
        Client <-- MSGQ;
        Server => MSGQ [label = "CtxGetMsgIdx"];
        Server => Example [label = "InitContext"];
        Client  <-- Server;
    };
    loop {
        Client -> MSGQ [label = "CtxSendMsg"];
        MSGQ -> Server [label = "signal"] {
            Client <-- MSGQ;
            Server => MSGQ [label = "CtxGetMsgIdx"];
            Server => Example [label = "ProcessMsg"];
            Server => MSGQ [label = "CtxCompleteMsg"];
            Client <-- Server [label = "signal"];
        };
        Client => MSGQ [label = "CtxRecvMsg"];
    };
    Client -> MSGQ [label = "CtxDestroy"];
    MSGQ -> Server [label = "signal"] {
        Client <-- MSGQ;
        Server => MSGQ [label = "CtxGetMsgIdx"];
        Server => Example [label = "DestroyContext"];
        Client  <-- Server;
    };
    @endseq


    @file msg_queue.h
    @brief Message Queue application interface
    This header file contains the interfaces for Message Queue
    @version 1.10 Imported from docx
*/

#ifndef MSG_QUEUE_H
#define MSG_QUEUE_H

#include <stdint.h>
#include <bcm_comp.h>
#include <bcm_err.h>

/**
    @name Message Queue API IDs
    @{
    @brief API IDs for Message Queue
*/
#define BRCM_SWARCH_MSGQ_MACRO                     (0x8101U)    /**< @brief #MSGQ_SIZE                 */
#define BRCM_SWARCH_MSGQ_MSG_STATUS_TYPE           (0x8102U)    /**< @brief #MSGQ_MsgStatusType        */
#define BRCM_SWARCH_MSGQ_HDL_TYPE                  (0x8103U)    /**< @brief #MSGQ_HdlType              */
#define BRCM_SWARCH_MSGQ_MSG_HDR_TYPE              (0x8104U)    /**< @brief #MSGQ_MsgHdrType           */
#define BRCM_SWARCH_MSGQ_MSGINFO_TYPE              (0x8105U)    /**< @brief #MSGQ_MsgInfoType          */
#define BRCM_SWARCH_MSGQ_CONTEXT_TYPE              (0x8106U)    /**< @brief #MSGQ_CtxType              */
#define BRCM_SWARCH_MSGQ_MSG_HDR_Q_TYPE            (0x8107U)    /**< @brief #MSGQ_MsgHdrQType          */
#define BRCM_SWARCH_MSGQ_MSGQ_INIT_HDRQ_MACRO      (0x8108U)    /**< @brief #MSGQ_INIT_HDRQ            */
#define BRCM_SWARCH_MSGQ_MSGQ_DEFINE_HDRQ_MACRO    (0x8109U)    /**< @brief #MSGQ_DEFINE_HDRQ          */
#define BRCM_SWARCH_MSGQ_CLIENT_SIGNAL_MACRO       (0x810AU)    /**< @brief #MSGQ_CLIENT_SIGNAL_ENABLE */
#define BRCM_SWARCH_MSGQ_MSG_QUEUE_TYPE            (0x810BU)    /**< @brief #MSGQ_Type                 */
#define BRCM_SWARCH_MSGQ_MSGQ_INIT_MACRO           (0x810CU)    /**< @brief #MSGQ_INIT                 */
#define BRCM_SWARCH_MSGQ_MSGQ_DEFINE_MACRO         (0x810DU)    /**< @brief #MSGQ_DEFINE               */
#define BRCM_SWARCH_MSGQ_MSGQ_DEFINE_V2_MACRO      (0x810EU)    /**< @brief #MSGQ_DEFINE_V2            */
#define BRCM_SWARCH_MSGQ_MSGQ_DEFINE_CTX_MACRO     (0x810FU)    /**< @brief #MSGQ_DEFINE_WITH_CONTEXT  */
#define BRCM_SWARCH_MSGQ_SEND_MSG_PROC             (0x8110U)    /**< @brief #MSGQ_SendMsg              */
#define BRCM_SWARCH_MSGQ_TRY_CANCEL_MSG_PROC       (0x8111U)    /**< @brief #MSGQ_TryCancelMsg         */
#define BRCM_SWARCH_MSGQ_RECV_MSG_PROC             (0x8112U)    /**< @brief #MSGQ_RecvMsg              */
#define BRCM_SWARCH_MSGQ_GET_MSG_IDX_PROC          (0x8113U)    /**< @brief #MSGQ_GetMsgIdx            */
#define BRCM_SWARCH_MSGQ_COMPLETE_MSG_IDX_PROC     (0x8114U)    /**< @brief #MSGQ_CompleteMsgIdx       */
#define BRCM_SWARCH_MSGQ_GET_MSG_TYPE              (0x8115U)    /**< @brief #MSGQ_GetMsgType           */
#define BRCM_SWARCH_MSGQ_GET_MSG_V2_TYPE           (0x8116U)    /**< @brief #MSGQ_GetMsgV2Type         */
#define BRCM_SWARCH_MSGQ_MSGQ_DEFINE_V3_MACRO      (0x8117U)    /**< @brief #MSGQ_DEFINE_V3            */
#define BRCM_SWARCH_MSGQ_MSGQ_DEFINE_V4_MACRO      (0x8118U)    /**< @brief #MSGQ_DEFINE_V4            */
#define BRCM_SWARCH_MSGQ_VERSION_TYPE              (0x8119U)    /**< @brief #MSGQ_VersionType          */
#define BRCM_SWARCH_MSGQ_CTX_CREATE_PROC           (0x811AU)    /**< @brief #MSGQ_CtxCreate            */
#define BRCM_SWARCH_MSGQ_CTX_SEND_MSG_PROC         (0x811BU)    /**< @brief #MSGQ_CtxSendMsg           */
#define BRCM_SWARCH_MSGQ_CTX_TRY_CANCEL_MSG_PROC   (0x811CU)    /**< @brief #MSGQ_CtxTryCancelMsg      */
#define BRCM_SWARCH_MSGQ_CTX_RECV_MSG_PROC         (0x811DU)    /**< @brief #MSGQ_CtxRecvMsg           */
#define BRCM_SWARCH_MSGQ_CTX_DESTROY_PROC          (0x811EU)    /**< @brief #MSGQ_CtxDestroy           */
#define BRCM_SWARCH_MSGQ_CTX_GET_MSG_IDX_PROC      (0x811FU)    /**< @brief #MSGQ_CtxGetMsgIdx         */
#define BRCM_SWARCH_MSGQ_CTX_COMPLETE_MSG_IDX_PROC (0x8120U)    /**< @brief #MSGQ_CtxCompleteMsgIdx    */
#define BRCM_SWARCH_MSGQ_CTX_GET_HDL_PROC          (0x8121U)    /**< @brief #MSGQ_CtxGetHdl            */
#define BRCM_SWARCH_MSGQ_IS_HDL_VALID_PROC         (0x8122U)    /**< @brief #MSGQ_IsHdlValid           */
#define BRCM_SWARCH_MSGQ_MSGQ_INIT_CTX_MACRO       (0x8123U)    /**< @brief #MSGQ_INIT_WITH_CONTEXT    */
#define BRCM_SWARCH_MSGQ_HDRQ_TYPE                 (0x8124U)    /**< @brief #MSGQ_HdrQType             */
#define BRCM_SWARCH_MSGQ_GET_SERVER_TYPE           (0x8125U)    /**< @brief #MSGQ_GetServerType        */
#define BRCM_SWARCH_MSGQ_MSGQ_INIT_V2_MACRO        (0x8126U)    /**< @brief #MSGQ_INIT_V2              */
#define BRCM_SWARCH_MSGQ_SEND_MSG_V2_PROC          (0x8127U)    /**< @brief #MSGQ_SendMsgv2            */
#define BRCM_SWARCH_MSGQ_TRY_CANCEL_MSG_V2_PROC    (0x8128U)    /**< @brief #MSGQ_TryCancelMsgv2       */
#define BRCM_SWARCH_MSGQ_RECV_MSG_V2_PROC          (0x8129U)    /**< @brief #MSGQ_RecvMsgv2            */
#define BRCM_SWARCH_MSGQ_MSGQ_INIT_V2_CTX_MACRO    (0x812AU)    /**< @brief #MSGQ_INIT_V2_WITH_CONTEXT */
/** @} */

/**
    @name Message Queue Macros
    @{

    @trace #BRCM_SWREQ_MSGQ_CONFIGURATION
*/
#define MSGQ_SIZE           (16UL)          /**< @brief Size of the Message Queue */
#define MSGQ_MAGIC          (0x5147534DUL)  /**< @brief 'MSGQ' */
#define MSGQ_CTX_MAGIC      (0x4851534DUL)  /**< @brief 'MSQH' */
#define MSGQ_INVALID_INDEX  (0xFFFFFFFFUL)  /**< @brief Message queue invalid index */
#define MSGQ_INVALID_CLIENT (-1L)           /**< @brief Invalid Message Queue client ID*/
#define MSGQ_NO_CLIENTMASK  (0UL)
/** @} */

/**
    @name Message status
    @{
    @brief Status of a message object

    @trace #BRCM_SWREQ_MSGQ_CONFIGURATION
*/
typedef uint32_t MSGQ_MsgStatusType;
#define MSGQ_MSG_STATUS_INIT       (0UL)            /**< @brief Message is in initialized state.*/
#define MSGQ_MSG_STATUS_POSTED     (1UL)            /**< @brief Client has posted the message   */
#define MSGQ_MSG_STATUS_PROCESSING (2UL)            /**< @brief Server is processing the message*/
#define MSGQ_MSG_STATUS_COMPLETED  (0xFFFFFFFFUL)   /**< @brief Server completed processing the message */
/** @} */

/**
    @name Message Handle
    @{
    @brief Message Handle

    @trace #BRCM_SWREQ_MSGQ_CONFIGURATION
*/
typedef BCM_HandleType MSGQ_HdlType;
#define MSGQ_HDL_INVALID        (0x0ULL)                /**< @brief Invalid Handle      */
#define MSGQ_HDL_MSG_IDX_MASK   (0x00000000000000FFULL) /**< @brief Message Index Mask  */
#define MSGQ_HDL_MSG_IDX_SHIFT  (0UL)                   /**< @brief Message Index Shift */
#define MSGQ_HDL_CTX_IDX_MASK   (0x000000000000FF00ULL) /**< @brief Context Index Mask  */
#define MSGQ_HDL_CTX_IDX_SHIFT  (8UL)                   /**< @brief Context Index Shift */
#define MSGQ_HDL_SEED_MASK      (0x00000000FFFF0000ULL) /**< @brief Seed Mask           */
#define MSGQ_HDL_SEED_SHIFT     (16UL)                  /**< @brief Seed Shift          */
#define MSGQ_HDL_HASH_MASK      (0xFFFFFFFF00000000ULL) /**< @brief Hash Mask           */
#define MSGQ_HDL_HASH_SHIFT     (32UL)                  /**< @brief Hash Shift          */
/** @} */

/**
    @trace #BRCM_SWREQ_MSGQ_CONFIGURATION
*/
typedef MSGQ_HdlType MSGQ_MsgHdrType;

/**
    @brief Message Info structure containing requester and state information.

    @trace #BRCM_SWREQ_MSGQ_CONFIGURATION
*/
typedef struct sMSGQ_MsgInfoType {
    MSGQ_MsgStatusType  status;     /**< @brief Message state          */
    int32_t             clientID;   /**< @brief Task ID of client to signal upon
                                     completion (reset value = #MSGQ_INVALID_CLIENT) */
    uint32_t            clientMask; /**< @brief Client event mask to signal upon
                                     completion (reset value = #MSGQ_NO_CLIENTMASK) */
} MSGQ_MsgInfoType;

/**
    @brief Message Context structure

    @trace #BRCM_SWREQ_MSGQ_CONFIGURATION
*/
typedef struct sMSGQ_CtxType{
    uint32_t            magic;  /**< @brief Magic word \'MSQH\'     */
    uint32_t            hash;   /**< @brief Context specific Hash   */
    uint32_t            wIdx;   /**< @brief Write Index             */
    uint32_t            rIdx;   /**< @brief Read Index              */
    int32_t             clientID;   /**< @brief Task ID of client to signal upon
                                     completion (reset value = #MSGQ_INVALID_CLIENT) */
    uint32_t            clientMask; /**< @brief Client event mask to signal upon
                                     completion (reset value = #MSGQ_NO_CLIENTMASK) */
    uint32_t            rsvd[8UL];
    MSGQ_HdlType        ctxHdl;             /**< @brief Abstract Context Handle */
    MSGQ_HdlType        msgHdl[MSGQ_SIZE];  /**< @brief Abstract Message Handle */
    MSGQ_MsgInfoType    msgInfo[MSGQ_SIZE]; /**< @brief Array of Info structures
                                            containing client and message information */
} MSGQ_CtxType;


#if (MSGQ_SIZE > 16UL)
#error "Wrong MSGQ_SIZE defined"
#else

/**
    @trace #BRCM_SWREQ_MSGQ_CONFIGURATION
*/
typedef MSGQ_CtxType MSGQ_HdrQType;

/**
    @brief Macro to initialize #MSGQ_CtxType structure

    This macro shall be used by server to initialize instance of #MSGQ_CtxType.

    @trace #BRCM_SWREQ_MSGQ_CONFIGURATION
 */
#define MSGQ_INIT_HDRQ(aMsgCount)                               \
{                                                               \
.magic = MSGQ_CTX_MAGIC,                                        \
.rIdx = 0UL,                                                    \
.wIdx = 0UL,                                                    \
.clientID = MSGQ_INVALID_CLIENT,                                \
.clientMask = 0UL,                                              \
.rsvd = {0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL},               \
.ctxHdl = 0ULL,                                                 \
.msgHdl = {0ULL, 0ULL, 0ULL, 0ULL, 0ULL, 0ULL, 0ULL, 0ULL,      \
            0ULL, 0ULL, 0ULL, 0ULL, 0ULL, 0ULL, 0ULL, 0ULL},    \
.msgInfo = {{MSGQ_MSG_STATUS_INIT, MSGQ_INVALID_CLIENT, MSGQ_NO_CLIENTMASK},     \
        {MSGQ_MSG_STATUS_INIT, MSGQ_INVALID_CLIENT, MSGQ_NO_CLIENTMASK},      \
        {MSGQ_MSG_STATUS_INIT, MSGQ_INVALID_CLIENT, MSGQ_NO_CLIENTMASK},      \
        {MSGQ_MSG_STATUS_INIT, MSGQ_INVALID_CLIENT, MSGQ_NO_CLIENTMASK},      \
        {MSGQ_MSG_STATUS_INIT, MSGQ_INVALID_CLIENT, MSGQ_NO_CLIENTMASK},      \
        {MSGQ_MSG_STATUS_INIT, MSGQ_INVALID_CLIENT, MSGQ_NO_CLIENTMASK},      \
        {MSGQ_MSG_STATUS_INIT, MSGQ_INVALID_CLIENT, MSGQ_NO_CLIENTMASK},      \
        {MSGQ_MSG_STATUS_INIT, MSGQ_INVALID_CLIENT, MSGQ_NO_CLIENTMASK},      \
        {MSGQ_MSG_STATUS_INIT, MSGQ_INVALID_CLIENT, MSGQ_NO_CLIENTMASK},      \
        {MSGQ_MSG_STATUS_INIT, MSGQ_INVALID_CLIENT, MSGQ_NO_CLIENTMASK},      \
        {MSGQ_MSG_STATUS_INIT, MSGQ_INVALID_CLIENT, MSGQ_NO_CLIENTMASK},      \
        {MSGQ_MSG_STATUS_INIT, MSGQ_INVALID_CLIENT, MSGQ_NO_CLIENTMASK},      \
        {MSGQ_MSG_STATUS_INIT, MSGQ_INVALID_CLIENT, MSGQ_NO_CLIENTMASK},      \
        {MSGQ_MSG_STATUS_INIT, MSGQ_INVALID_CLIENT, MSGQ_NO_CLIENTMASK},      \
        {MSGQ_MSG_STATUS_INIT, MSGQ_INVALID_CLIENT, MSGQ_NO_CLIENTMASK},      \
        {MSGQ_MSG_STATUS_INIT, MSGQ_INVALID_CLIENT, MSGQ_NO_CLIENTMASK},}     \
}

/**
    @brief Macro to define and initialize #MSGQ_CtxType instance of name @a aMsgHdrQ

    This macro shall be used by the message queue server to initialize an
    instance of #MSGQ_CtxType (of name @a aMsgHdrQ).

    @trace #BRCM_SWREQ_MSGQ_CONFIGURATION
 */
#define MSGQ_DEFINE_HDRQ(aMsgHdrQ)      \
    static MSGQ_CtxType (aMsgHdrQ);
#endif

/**
    @name Enable/Disable client notification
    @{

    @trace #BRCM_SWREQ_MSGQ_CONFIGURATION
*/
#define MSGQ_CLIENT_SIGNAL_ENABLE    (1UL)   /**< @brief Client notification enabled */
#define MSGQ_CLIENT_SIGNAL_DISABLE   (0UL)   /**< @brief Client notification disabled */
/** @} */

/**
    @name message queue version
    @{

    @trace #BRCM_SWREQ_MSGQ_CONFIGURATION
*/
typedef uint32_t MSGQ_VersionType;
#define MSGQ_VERSION_1   (0UL)   /**< @brief Message queue version V1 */
#define MSGQ_VERSION_2   (1UL)   /**< @brief Message queue version V2 */
/** @} */

/** @brief Get the i'th message from the server

    Function pointer pointing to a function to get the ith message from the
    server. This function pointer shall be provided by the server.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aArg1       Brief description of aArg1

    @return     void *                  Pointer to the ith message

    @post None

    @trace #BRCM_SWREQ_MSGQ_CONFIGURATION

    @limitations None
*/
typedef void* (*MSGQ_GetMsgType)(uint32_t i);

/** @brief Get the aMsgIdx'th message in aCtxIdx'th Context from the server

    Function pointer pointing to a function to get the ith message from the
    server. This function pointer shall be provided by the server.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aCtxIdx       Context index
    @param[in]      aMsgIdx       Message index

    @return     uint8_t*          Pointer to the message

    @post None

    @trace #BRCM_SWREQ_MSGQ_CONFIGURATION

    @limitations None
*/
typedef uint8_t* (*MSGQ_GetMsgV2Type)(uint32_t aCtxIdx, uint32_t aMsgIdx);

/** @brief Get Server details

    @behavior Sync, Re-entrant

    @pre None

    @param[out]      aServerTask        Server Task ID
    @param[out]      aServerEvent       Server Event Mask

    @return     void

    @post None

    @trace #BRCM_SWREQ_MSGQ_CONFIGURATION

    @limitations None
*/
typedef void (*MSGQ_GetServerType)(int32_t *aServerTask, uint32_t *aServerEvent);

/**
    @brief Message Queue handle

    Detailed structure description.

    @trace #BRCM_SWREQ_MSGQ_CONFIGURATION
*/
typedef struct sMSGQ_Type {
    uint32_t            magic;      /**< @brief Magic word 'MSGQ' (#MSG_QUEUE_MAGIC
                                        checked for corruption) */
    MSGQ_VersionType    version;    /**< @brief version based implementation */
    MSGQ_GetServerType  getServer;  /**< @brief Get Server, if this is NULL, serverID and server Mask will be used */
    int32_t             serverID;   /**< @brief Task ID of server to be signaled
                                         on reception of the message by message queue*/
    uint32_t            serverMask; /**< @brief Server signal mask */
    uint32_t            enNotif;    /**< @brief Enable/Disable client notifications:
                                         - #MSGQ_CLIENT_SIGNAL_ENABLE
                                         - #MSGQ_CLIENT_SIGNAL_DISABLE */
    uint32_t            msgSize;    /**< @brief Size of message structure (defined by server) */
    MSGQ_CtxType        *ctx;       /**< @brief Pointer to Queue of message headers */
    uint32_t            ctxCount;   /**< @brief Maximum count of contexts supported by this queue */
    uint32_t            msgCount;   /**< @brief Maximum count of messages supported by
                                            this queue per context */
    MSGQ_GetMsgType     getMsg;     /**< @brief Function pointer to get i'th message (0 to msgCount - 1)*/
    MSGQ_GetMsgV2Type   getMsgV2;   /**< @brief Function pointer to get message */
} MSGQ_Type;

/**
    @brief Macro to initialize #MsgQ structure

    This macro shall be used by server to initialize #MsgQ.

    @param[in]      aServerID           ID of the server task, which is the only
                                        task allowed to call #MSGQ_GetMsgIdx and
                                        #MSGQ_CompleteMsgIdx
    @param[in]      aServerMask         Event mask to signal the server task
    @param[in]      aEnableNotification Enable Client notifications
    @param[in]      aMsgType            Type of the C object representing the
                                        message (This is used to get the size of
                                        the C object using sizeof operator)
    @param[in]      aMsgHdrQ            Pointer to #MSGQ_CtxType
    @param[in]      aGetMessage         Callback to get ith message from the
                                        queue

    @trace #BRCM_SWREQ_MSGQ_CONFIGURATION
 */
#define MSGQ_INIT(aServerID, aServerMask, aEnableNotification,  \
                    aMsgType, aMsgCount, aMsgHdrQ, aGetMessage) \
{                                                               \
    .magic = MSGQ_MAGIC,                                        \
    .serverID = (aServerID),                                    \
    .serverMask = (aServerMask),                                \
    .enNotif = (aEnableNotification),                           \
    .msgSize = sizeof(aMsgType),                                \
    .ctx = (aMsgHdrQ),                                          \
    .ctxCount = 1UL,                                            \
    .msgCount = (aMsgCount),                                    \
    .getMsg = (aGetMessage)                                     \
}

/**
    @brief Macro to initialize #MsgQ structure with notify server function

    This macro shall be used by server to initialize #MsgQ.

    @param[in]      aGetServer          Function to get server
    @param[in]      aEnableNotification Enable Client notifications
    @param[in]      aMsgType            Type of the C object representing the
                                        message (This is used to get the size of
                                        the C object using sizeof operator)
    @param[in]      aMsgHdrQ            Pointer to #MSGQ_CtxType
    @param[in]      aGetMessage         Callback to get ith message from the
                                        queue

    @trace #BRCM_SWREQ_MSGQ_CONFIGURATION
 */
#define MSGQ_INIT_V2(aGetServer, aEnableNotification, aMsgType, \
                            aMsgCount, aMsgHdrQ, aGetMessage)   \
{                                                               \
    .magic = MSGQ_MAGIC,                                        \
    .getServer = (aGetServer),                                  \
    .serverID = (MSGQ_INVALID_CLIENT),                          \
    .serverMask = (MSGQ_NO_CLIENTMASK),                         \
    .enNotif = (aEnableNotification),                           \
    .msgSize = sizeof(aMsgType),                                \
    .ctx = (aMsgHdrQ),                                          \
    .ctxCount = 1UL,                                            \
    .msgCount = (aMsgCount),                                    \
    .getMsg = (aGetMessage)                                     \
}

/**
    @brief Macro to define and initialize MsgQ structure

    This macro shall be used by server to define and initialize an instance of
    #MsgQ.

    @param[in]      aMsgQ               Name of the #MsgQ instance
    @param[in]      aServerID           ID of the server task, which is the only
                                        task allowed to call #MSGQ_GetMsgIdx and
                                        #MSGQ_CompleteMsgIdx
    @param[in]      aServerMask         Event mask to signal the server task
    @param[in]      aEnableNotification Enable Client notifications
    @param[in]      aMsgType            Type of the C object representing the
                                        message (This is used to get the size of
                                        the C object using sizeof operator)
    @param[in]      aMsgHdrQ            variable name for MSGQ_MsgHdrQ
    @param[in]      aGetMessage         Callback to get ith message from the
                                        queue

    @trace #BRCM_SWREQ_MSGQ_CONFIGURATION
 */
#define MSGQ_DEFINE(aMsgQ, aServerID, aServerMask, aEnableNotification,      \
                    aMsgType, aMsgHdrQ, aGetMessage)                         \
static const MSGQ_Type (aMsgQ) = MSGQ_INIT(aServerID, aServerMask,           \
                                    aEnableNotification, aMsgType, MSGQ_SIZE,\
                                    aMsgHdrQ, aGetMessage);

/**
    @brief Macro to define and initialize MsgQ structure with Memory Protection

    This macro shall be used by server to define and initialize an instance of
    #MsgQ.

    @param[in]      aMsgQ               Name of the #MsgQ instance
    @param[in]      aServerID           ID of the server task, which is the only
                                        task allowed to call #MSGQ_GetMsgIdx and
                                        #MSGQ_CompleteMsgIdx
    @param[in]      aServerMask         Event mask to signal the server task
    @param[in]      aEnableNotification Enable Client notifications
    @param[in]      aMsgType            Type of the C object representing the
                                        message (This is used to get the size of
                                        the C object using sizeof operator)
    @param[in]      aMsgHdrQ            variable name for MSGQ_MsgHdrQ
    @param[in]      aGetMessage         Callback to get ith message from the
                                        queue
    @param[in]      aSecName            Name of the Memory section

    @trace #BRCM_SWREQ_MSGQ_CONFIGURATION
 */
#define MSGQ_DEFINE_V2(aMsgQ, aServerID, aServerMask, aEnableNotification,          \
                    aMsgType, aMsgHdrQ, aGetMessage, aSecName)                      \
static COMP_SECTION(aSecName) MSGQ_CtxType (aMsgHdrQ);                             \
static const MSGQ_Type (aMsgQ) = MSGQ_INIT(aServerID, aServerMask,                  \
                                    aEnableNotification, aMsgType, MSGQ_SIZE,       \
                                    &aMsgHdrQ, aGetMessage);

/**
    @brief Macro to define MsgQ with customizable count of entries and initialize
    MsgQ structure with Memory Protection

    This macro shall be used by server to define and initialize an instance of
    #MsgQ.

    @param[in]      aMsgQ               Name of the #MsgQ instance
    @param[in]      aMsgCount           Maximum count of entries to be supported
                                        in this MsgQ
    @param[in]      aServerID           ID of the server task, which is the only
                                        task allowed to call #MSGQ_GetMsgIdx and
                                        #MSGQ_CompleteMsgIdx
    @param[in]      aServerMask         Event mask to signal the server task
    @param[in]      aEnableNotification Enable Client notifications
    @param[in]      aMsgType            Type of the C object representing the
                                        message (This is used to get the size of
                                        the C object using sizeof operator)
    @param[in]      aMsgHdrQ            variable name for MSGQ_MsgHdrQ
    @param[in]      aGetMessage         Callback to get ith message from the
                                        queue
    @param[in]      aSecName            Name of the Memory section

    @trace #BRCM_SWREQ_MSGQ_CONFIGURATION
 */
#define MSGQ_DEFINE_V3(aMsgQ, aMsgCount, aServerID, aServerMask,                    \
            aEnableNotification, aMsgType, aMsgHdrQ, aGetMessage, aSecName)         \
static COMP_SECTION(aSecName) MSGQ_CtxType (aMsgHdrQ);                              \
static const MSGQ_Type (aMsgQ) = MSGQ_INIT(aServerID, aServerMask,                  \
                                    aEnableNotification, aMsgType, aMsgCount,       \
                                    &aMsgHdrQ, aGetMessage);
/**
    @brief Macro to define MsgQ with notifications disabled and customizable count
    of entries with message Queue depth 256 and initialize MsgQ structure with
    Memory Protection and should in .bss section.

    This macro shall be used by server to define and initialize an instance of
    #MSGQ_Type.

    @param[in]      aMsgQ               Name of the #MsgQ instance
    @param[in]      aLog2Cnt            Log count of entries to be supported
                                        in this MsgQ
    @param[in]      aServerID           ID of the server task, which is the only
                                        task allowed to call #MSGQ_GetMsgIdx and
                                        #MSGQ_CompleteMsgIdx
    @param[in]      aServerMask         Event mask to signal the server task
    @param[in]      aMsgType            Type of the C object representing the
                                        message (This is used to get the size of
                                        the C object using sizeof operator)
    @param[in]      aCtx                variable name for #MSGQ_CtxType
    @param[in]      aGetMessage         Function to get ith message from the
                                        queue
    @param[in]      aSecName            Name of the Memory section

    @trace #BRCM_SWREQ_MSGQ_CONFIGURATION
 */
#define MSGQ_DEFINE_V4(aMsgQ, aLog2Cnt, aServerID, aServerMask,                             \
                    aMsgType, aCtx, aGetMessage, aSecName)                                  \
static COMP_SECTION(aSecName) MSGQ_CtxType (aCtx);                                          \
static const MSGQ_Type (aMsgQ) = {                                                          \
                .magic = MSGQ_MAGIC,                                                        \
                .version = MSGQ_VERSION_1,                                                  \
                .serverID = (aServerID),                                                    \
                .serverMask = (aServerMask),                                                \
                .enNotif = (MSGQ_CLIENT_SIGNAL_DISABLE),                                    \
                .msgSize = sizeof(aMsgType),                                                \
                .ctx = (&aCtx),                                                             \
                .ctxCount = (1UL),                                                          \
                .msgCount = (1UL << (aLog2Cnt)),                                            \
                .getMsg = (aGetMessage)                                                     \
            };

/**
    @brief Macro to define #MSGQ_Type with multiple context support

    @param[in]      aMsgQ               Name of the #MSGQ_Type instance
    @param[in]      aLog2MsgCnt         Log count of messages to be supported
                                        in this MSGQ per Context
    @param[in]      aLog2CtxCnt         Log count of number of contexts
    @param[in]      aServerID           ID of the server task, which is the only
                                        task allowed to call #MSGQ_GetMsgIdx and
                                        #MSGQ_CompleteMsgIdx
    @param[in]      aServerMask         Event mask to signal the server task
    @param[in]      aMsgType            Type of the C object representing the
                                        message (This is used to get the size of
                                        the C object using sizeof operator)
    @param[in]      aCtx                variable name for #MSGQ_CtxType
    @param[in]      aGetMessage         Callback to get ith message from the
                                        queue
    @param[in]      aSecName            Name of the Memory section

    @trace #BRCM_SWREQ_MSGQ_CONFIGURATION
 */
#define MSGQ_DEFINE_WITH_CONTEXT(aMsgQ, aLog2MsgCnt, aLog2CtxCnt, aServerID, aServerMask,   \
                                aMsgType, aCtx, aGetMessage, aSecName)                      \
static COMP_SECTION(aSecName) MSGQ_CtxType (aCtx)[1UL << (aLog2CtxCnt)];                    \
static const MSGQ_Type (aMsgQ) = {                                                          \
                .magic = MSGQ_MAGIC,                                                        \
                .version = MSGQ_VERSION_2,                                                  \
                .serverID = (aServerID),                                                    \
                .serverMask = (aServerMask),                                                \
                .enNotif = (MSGQ_CLIENT_SIGNAL_ENABLE),                                     \
                .msgSize = sizeof(aMsgType),                                                \
                .ctx = (aCtx),                                                              \
                .ctxCount = 1UL << (aLog2CtxCnt),                                           \
                .msgCount = (1UL << (aLog2MsgCnt)),                                         \
                .getMsgV2 = (aGetMessage)                                                   \
            };

/**
    @brief Macro to initialize #MSGQ_Type with multiple context support

    @param[in]      aLog2MsgCnt         Log count of messages to be supported
                                        in this MSGQ per Context
    @param[in]      aLog2CtxCnt         Log count of number of contexts
    @param[in]      aServerID           ID of the server task, which is the only
                                        task allowed to call #MSGQ_GetMsgIdx and
                                        #MSGQ_CompleteMsgIdx
    @param[in]      aServerMask         Event mask to signal the server task
    @param[in]      aMsgType            Type of the C object representing the
                                        message (This is used to get the size of
                                        the C object using sizeof operator)
    @param[in]      aCtx                Context structure
    @param[in]      aGetMessage         Callback to get ith message from the
                                        queue

    @trace #BRCM_SWREQ_MSGQ_CONFIGURATION
 */
#define MSGQ_INIT_WITH_CONTEXT(aLog2MsgCnt, aLog2CtxCnt, aServerID, aServerMask,            \
                                aMsgType, aCtx, aGetMessage)                                \
            {                                                                               \
                .magic = MSGQ_MAGIC,                                                        \
                .version = MSGQ_VERSION_2,                                                  \
                .serverID = (aServerID),                                                    \
                .serverMask = (aServerMask),                                                \
                .enNotif = (MSGQ_CLIENT_SIGNAL_ENABLE),                                     \
                .msgSize = sizeof(aMsgType),                                                \
                .ctx = (aCtx),                                                              \
                .ctxCount = 1UL << (aLog2CtxCnt),                                           \
                .msgCount = (1UL << (aLog2MsgCnt)),                                         \
                .getMsgV2 = (aGetMessage)                                                   \
            }

/**
    @brief Macro to initialize #MSGQ_Type with multiple context support

    @param[in]      aLog2MsgCnt         Log count of messages to be supported
                                        in this MSGQ per Context
    @param[in]      aLog2CtxCnt         Log count of number of contexts
    @param[in]      aGetServer          Function to get server
    @param[in]      aMsgType            Type of the C object representing the
                                        message (This is used to get the size of
                                        the C object using sizeof operator)
    @param[in]      aCtx                Context structure
    @param[in]      aGetMessage         Callback to get ith message from the
                                        queue

    @trace #BRCM_SWREQ_MSGQ_CONFIGURATION
 */
#define MSGQ_INIT_V2_WITH_CONTEXT(aLog2MsgCnt, aLog2CtxCnt, aGetServer,                     \
                                aMsgType, aCtx, aGetMessage)                                \
            {                                                                               \
                .magic = MSGQ_MAGIC,                                                        \
                .version = MSGQ_VERSION_2,                                                  \
                .getServer = (aGetServer),                                                  \
                .serverID = (MSGQ_INVALID_CLIENT),                                          \
                .serverMask = (MSGQ_NO_CLIENTMASK),                                         \
                .enNotif = (MSGQ_CLIENT_SIGNAL_ENABLE),                                     \
                .msgSize = sizeof(aMsgType),                                                \
                .ctx = (aCtx),                                                              \
                .ctxCount = 1UL << (aLog2CtxCnt),                                           \
                .msgCount = (1UL << (aLog2MsgCnt)),                                         \
                .getMsgV2 = (aGetMessage)                                                   \
            }

/** @brief Queue message

    API to queue a message in the message queue. A Handle is output by this API
    for client to query the status of the queued message (called by client).
    Upon successfully posting the message to the queue, the API signals the
    server.

    @behavior Sync, Re-entrant

    @pre There should have valid message queue server.

    @param[in]      msgQ        Handle to message queue
    @param[in]      msg         Pointer to the message
    @param[in]      clientMask  Client signal mask
    @param[out]     pHdr        Pointer to #MSGQ_HdlType

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Message is successfully queued to the
                                        message queue.
    @retval     #BCM_ERR_NOMEM          Queue is full
    @retval     #BCM_ERR_UNKNOWN        Unknown error while signaling server
                                        or msgQ->msgHdrQ is NULL
    @retval     #BCM_ERR_INVAL_PARAMS   @a msg is NULL
    @retval     #BCM_ERR_INVAL_PARAMS   clientMask is 0 (when Client
                                        Notifications are enabled)
    @retval     #BCM_ERR_INVAL_PARAMS   @a msgQ is NULL

    @post On successfully posting the message, server will be signaled

    @trace #BRCM_SWREQ_MSGQ_USER_INTERFACE
*/
int32_t MSGQ_SendMsg(const MSGQ_Type* const msgQ,
                    const void* const msg,
                    const uint32_t clientMask,
                    const MSGQ_HdlType** const pHdr);

/** @brief Try cancelling a message

    API to try to cancel the message which was previously queued by the client
    using #MSGQ_SendMsg API. If the request is in the Queue and not currently
    being processed by the server (i.e. not in progress), it shall be removed
    from the Message Queue, the handle to the message header shalll become
    invalid and API returns #BCM_ERR_CANCELLED. If the request is already in
    progress (i.e. being processed by the server), it cannot be cancelled and
    client need to wait for the completion of the message. In this case, API
    shall return #BCM_ERR_BUSY.

    @behavior Sync, Re-entrant

    @pre There should have valid message handle.

    @param[in]      aMsgQ       Handle to message queue
    @param[in]      aHdr        Pointer to message header
    @param[out]     aMsg        Pointer to the message


    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_CANCELLED      Message is cancelled
    @retval     #BCM_ERR_OK             Message processing is completed by the
                                        server and response is copied to @a aMsg
    @retval     #BCM_ERR_UNKNOWN        Unknown error while signaling server

    @retval     #BCM_ERR_BUSY           Message cannot be cancelled

    @retval     #BCM_ERR_UNKNOWN        @a msgQ->msgHdrQ is NULL
    @retval     #BCM_ERR_NOT_FOUND      @a aHdr does not belong to
                                        @a aMsgQ

    @retval     #BCM_ERR_INVAL_PARAMS   Message is in @c Init state
    @retval     #BCM_ERR_INVAL_PARAMS   @a aMsg is  NULL
    @retval     #BCM_ERR_INVAL_PARAMS   @a aHdr is NULL

    @retval     #BCM_ERR_AUTH_FAILED    Task ID of the caller is not matching
                                        with the requestor’s Task ID

    @retval     #BCM_ERR_INVAL_PARAMS   @a aMsgQ has invalid magic
    @retval     #BCM_ERR_INVAL_PARAMS   @a aMsgQ is NULL

    @post On Successful cancellation, aHdl pointing to message will be moved to INIT_STATE

    @trace #BRCM_SWREQ_MSGQ_USER_INTERFACE

    @limitations This API shall be called only from task context.
*/
int32_t MSGQ_TryCancelMsg(const MSGQ_Type* const aMsgQ,
                        const MSGQ_HdlType* const aHdr,
                        void* const aMsg);

/** @brief Query the status of submitted message

    API to query the status of the submitted message and get response. Upon
    successfully receiving the response, the API signals the server task as
    well.

    @behavior Sync, Re-entrant

    @pre There should have valid message handle.

    @param[in]      aMsgQ       Handle to message queue
    @param[in]      aHdr        Pointer to message header
    @param[out]     aMsg        Pointer to the message

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Message processing is completed by
                                        server and response is copied to
                                        @a aMsg. Client no longer owns the
                                        message header.
    @retval     #BCM_ERR_UNKNOWN        Unknown error while signaling server
    @retval     #BCM_ERR_UNKNOWN        @a msgQ->msgHdrQ is NULL

    @retval     #BCM_ERR_BUSY           Message cannot be cancelled

    @retval     #BCM_ERR_INVAL_PARAMS   Message is in @c Init state
    @retval     #BCM_ERR_INVAL_PARAMS   @a aMsg is  NULL

    @retval     #BCM_ERR_AUTH_FAILED    Task ID of the caller is not matching
                                        with the requestor’s Task ID

    @retval     #BCM_ERR_NOT_FOUND      @a aHdr does not belong to
                                        @a aMsgQ
    @retval     #BCM_ERR_NOT_FOUND      @a aHdl is NULL
    @retval     #BCM_ERR_INVAL_PARAMS   @a aMsgQ has invalid magic
    @retval     #BCM_ERR_INVAL_PARAMS   @a aMsgQ is NULL

    @post aHdr pointing to message will moved to INIT_STATE

    @trace #BRCM_SWREQ_MSGQ_USER_INTERFACE

    @limitations This API shall be called by the client only when client
    notifications are enabled.
    @limitations API shall be called only from task context.
*/
int32_t MSGQ_RecvMsg(const MSGQ_Type* const aMsgQ,
                    const MSGQ_HdlType* const aHdr,
                    void* const aMsg);

/** @brief Queue message

    API to queue a message in the message queue. A Handle is output by this API
    for client to query the status of the queued message (called by client).
    Upon successfully posting the message to the queue, the API signals the
    server.

    @behavior Sync, Re-entrant

    @pre There should have valid message queue server.

    @param[in]      msgQ        Handle to message queue
    @param[in]      msg         Pointer to the message
    @param[in]      clientMask  Client signal mask
    @param[out]     pHdr        Pointer to #MSGQ_HdlType

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Message is successfully queued to the
                                        message queue.
    @retval     #BCM_ERR_NOMEM          Queue is full
    @retval     #BCM_ERR_UNKNOWN        Unknown error while signaling server
                                        or msgQ->msgHdrQ is NULL
    @retval     #BCM_ERR_INVAL_PARAMS   @a msg is NULL
    @retval     #BCM_ERR_INVAL_PARAMS   clientMask is 0 (when Client
                                        Notifications are enabled)
    @retval     #BCM_ERR_INVAL_PARAMS   @a msgQ is NULL

    @post On successfully posting the message, server will be signaled

    @trace #BRCM_SWREQ_MSGQ_USER_INTERFACE
*/
int32_t MSGQ_SendMsgv2(const MSGQ_Type* const msgQ, const uint8_t* const msg,
                    const uint32_t clientMask, MSGQ_HdlType* const pHdr);

/** @brief Try cancelling a message

    API to try to cancel the message which was previously queued by the client
    using #MSGQ_SendMsg API. If the request is in the Queue and not currently
    being processed by the server (i.e. not in progress), it shall be removed
    from the Message Queue, the handle to the message header shalll become
    invalid and API returns #BCM_ERR_CANCELLED. If the request is already in
    progress (i.e. being processed by the server), it cannot be cancelled and
    client need to wait for the completion of the message. In this case, API
    shall return #BCM_ERR_BUSY.

    @behavior Sync, Re-entrant

    @pre There should have valid message handle.

    @param[in]      aMsgQ       Handle to message queue
    @param[in]      aHdr        Pointer to message header
    @param[out]     aMsg        Pointer to the message


    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_CANCELLED      Message is cancelled
    @retval     #BCM_ERR_OK             Message processing is completed by the
                                        server and response is copied to @a aMsg
    @retval     #BCM_ERR_UNKNOWN        Unknown error while signaling server

    @retval     #BCM_ERR_BUSY           Message cannot be cancelled

    @retval     #BCM_ERR_UNKNOWN        @a msgQ->msgHdrQ is NULL
    @retval     #BCM_ERR_NOT_FOUND      @a aHdr does not belong to
                                        @a aMsgQ

    @retval     #BCM_ERR_INVAL_PARAMS   Message is in @c Init state
    @retval     #BCM_ERR_INVAL_PARAMS   @a aMsg is  NULL

    @retval     #BCM_ERR_AUTH_FAILED    Task ID of the caller is not matching
                                        with the requestor’s Task ID

    @retval     #BCM_ERR_INVAL_PARAMS   @a aMsgQ has invalid magic
    @retval     #BCM_ERR_INVAL_PARAMS   @a aMsgQ is NULL

    @post On Successful cancellation, aHdl pointing to message will be moved to INIT_STATE

    @trace #BRCM_SWREQ_MSGQ_USER_INTERFACE

    @limitations This API shall be called only from task context.
*/
int32_t MSGQ_TryCancelMsgv2(const MSGQ_Type* const aMsgQ, MSGQ_HdlType aHdr, uint8_t* const aMsg);

/** @brief Query the status of submitted message

    API to query the status of the submitted message and get response. Upon
    successfully receiving the response, the API signals the server task as
    well.

    @behavior Sync, Re-entrant

    @pre There should have valid message handle.

    @param[in]      aMsgQ       Handle to message queue
    @param[in]      aHdr        Pointer to message header
    @param[out]     aMsg        Pointer to the message

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Message processing is completed by
                                        server and response is copied to
                                        @a aMsg. Client no longer owns the
                                        message header.
    @retval     #BCM_ERR_UNKNOWN        Unknown error while signaling server
    @retval     #BCM_ERR_UNKNOWN        @a msgQ->msgHdrQ is NULL

    @retval     #BCM_ERR_BUSY           Message cannot be cancelled

    @retval     #BCM_ERR_INVAL_PARAMS   Message is in @c Init state
    @retval     #BCM_ERR_INVAL_PARAMS   @a aMsg is  NULL

    @retval     #BCM_ERR_AUTH_FAILED    Task ID of the caller is not matching
                                        with the requestor’s Task ID

    @retval     #BCM_ERR_NOT_FOUND      @a aHdr does not belong to
                                        @a aMsgQ
    @retval     #BCM_ERR_INVAL_PARAMS   @a aMsgQ has invalid magic
    @retval     #BCM_ERR_INVAL_PARAMS   @a aMsgQ is NULL

    @post aHdr pointing to message will moved to INIT_STATE

    @trace #BRCM_SWREQ_MSGQ_USER_INTERFACE

    @limitations This API shall be called by the client only when client
    notifications are enabled.
    @limitations API shall be called only from task context.
*/
int32_t MSGQ_RecvMsgv2(const MSGQ_Type* const aMsgQ, MSGQ_HdlType aHdr, uint8_t* const aMsg);

/** @brief Get the index of the pending message to be processed

    This API shall be called by the server. If this API is called from any task
    other than the server task, the API shall return #BCM_ERR_AUTH_FAILED.

    @behavior Sync, Re-entrant for different message queues

    @pre message should be in posted state.

    @param[in]      aMsgQ       Handle to message queue
    @param[out]     idx         Pointer to index of message (valid only if API
                                returns #BCM_ERR_OK)

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             There is a new message in the queue and
                                        the index has been successfully
                                        retrieved
    @retval     #BCM_ERR_BUSY           No new message in queue or client is
                                        busy in posting new message

    @retval     #BCM_ERR_UNKNOWN        @a msgQ->msgHdrQ is NULL

    @retval     #BCM_ERR_INVAL_PARAMS   @a msgQ does not have a valid magic
    @retval     #BCM_ERR_INVAL_PARAMS   @a msgQ is NULL

    @retval     #BCM_ERR_AUTH_FAILED    Calling task is not authorized to get
                                        the message index
    @retval     #BCM_ERR_INVAL_PARAMS   @a idx is NULL

    @post On Successful fetch, message will moved to PROCESSING_STATE

    @trace #BRCM_SWREQ_MSGQ_USER_INTERFACE

    @limitations This API should be called only from server task context.
*/
int32_t MSGQ_GetMsgIdx(const MSGQ_Type* const aMsgQ,
                        uint32_t* const idx);

/** @brief Notify a message processing completion

    API to be called by server to notify a message processing completion. Upon
    marking a message as completed, the corresponding client is signaled. If
    this API is called from any task other than the server task, the API shall
    return #BCM_ERR_AUTH_FAILED.

    @behavior Sync, Re-entrant for different message queues

    @pre message should be in processing state.

    @param[in]      aMsgQ       Pointer to MsgQ where message processing
                                completion needs to be notified
    @param[in]      idx         Index of the message to be marked as complete

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Message successfully moved to completed
                                        state in message queue
    @retval     #BCM_ERR_UNKNOWN        Unknown error while signaling client
    @retval     #BCM_ERR_UNKNOWN        Message already in completed state
    @retval     #BCM_ERR_INVAL_PARAMS   API called from wrong state

    @retval     #BCM_ERR_INVAL_PARAMS   @a idx is not valid
    @retval     #BCM_ERR_INVAL_MAGIC    Invalid msgQ->msgHdrQ magic
    @retval     #BCM_ERR_INVAL_MAGIC    msgQ->msgHdrQ is NULL
    @retval     #BCM_ERR_INVAL_PARAMS   @a msgQ does not have a valid
                                        magic
    @retval     #BCM_ERR_INVAL_PARAMS   @a msgQ is NULL
    @retval     #BCM_ERR_AUTH_FAILED    Calling task is not authorized to
                                        complete the message

    @post On Successful completion, message will moved to COMPLETED_STATE

    @trace #BRCM_SWREQ_MSGQ_USER_INTERFACE

    @limitations This API shall be called only from server task context.
*/
int32_t MSGQ_CompleteMsgIdx(const MSGQ_Type* const aMsgQ,
                            const uint32_t idx);

/** @brief Create a Context on Queue to post Messages and retrieve responses

    API to create a context in the Queue. A Handle is output by this API
    for client to post messages, query status of the queued message.
    Upon creation of a successful context, server is notified of the new context.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      msgQ        Handle to message queue
    @param[in]      clientMask  Client signal mask
    @param[out]     aCtxHdl     Pointer to #MSGQ_HdlType

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             New Context is created and *aCtxHdl is valid
    @retval     #BCM_ERR_NOMEM          No Free Cotexts available
    @retval     #BCM_ERR_UNKNOWN        Integration fault
    @retval     #BCM_ERR_INVAL_PARAMS   aMsgQ does not have a valid magic 'MSGQ'
    @retval     #BCM_ERR_INVAL_PARAMS   aCtxHdl is NULL
    @retval     #BCM_ERR_INVAL_PARAMS   clientMask is 0
    @retval     #BCM_ERR_INVAL_PARAMS   aMsgQ is NULL

    @post On successfully creating the context, server will be signaled.

    @trace #BRCM_SWREQ_MSGQ_USER_INTERFACE

    @limitations This API shall be called only from task context.
*/
int32_t MSGQ_CtxCreate(const MSGQ_Type* const aMsgQ,
                        const uint32_t aClientMask,
                        MSGQ_HdlType* aCtxHdl);

/** @brief Queue message to MsgQ

    API to queue a message in the message queue. A Handle is output by this API
    for client to query the status of the queued message. Upon successfully posting
    the message to the queue, the API signals the server.
    If aHdl is NULL, server will not signal client at any point of time and
    MSGQ_TryCancelMsgV2 & MSGQ_RecvMsgV2 call shall not be possible.

    @behavior Sync, Re-entrant

    @pre Context is created by client

    @param[in]      aMsgQ       Message queue
    @param[in]      aCtxHdl     Context Handle returned by #MSGQ_CtxCreate
    @param[in]      aMsg        Pointer to the message
    @param[out]     aMsgHdl     Message Handle

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Message is successfully queued
    @retval     #BCM_ERR_NOMEM          Queue is full
    @retval     #BCM_ERR_AUTH_FAILED    Task ID of the caller is not matching
                                        with the requestor’s Task ID
    @retval     #BCM_ERR_UNKNOWN        Integration Fault
    @retval     #BCM_ERR_INVAL_PARAMS   aMsgQ does not have a valid magic 'MSGQ'
    @retval     #BCM_ERR_INVAL_PARAMS   aMsg is NULL
    @retval     #BCM_ERR_INVAL_PARAMS   aMsgQ is NULL

    @post On successfully posting the message, server will be signaled.

    @trace #BRCM_SWREQ_MSGQ_USER_INTERFACE

    @limitations This API shall be called only from task context.
*/
int32_t MSGQ_CtxSendMsg(const MSGQ_Type* const aMsgQ, MSGQ_HdlType aCtxHdl,
                        const uint8_t* const aMsg, MSGQ_HdlType* const aMsgHdl);

/** @brief Get Context handle corresponding to a message handle

    API to get Context handle corresponding to a message handle

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aMsgQ        Pointer to MsgQ
    @param[in]      aHdl         Message Handle

    @return     Context Handle or MSGQ_HDL_INVALID

    @post None

    @trace #BRCM_SWREQ_MSGQ_USER_INTERFACE
*/
MSGQ_HdlType MSGQ_CtxGetHdl(const MSGQ_Type* const aMsgQ, MSGQ_HdlType aHdl);

/** @brief Try cancelling a message

    API to try to cancel the message which was previously queued by the client
    using #MSGQ_CtxSendMsg.

    If the request is in the Queue and not currently being processed by
    the server (i.e. not in progress), it shall be removed from the Message
    Queue, the handle to the message shall become invalid and API returns
    #BCM_ERR_CANCELLED.

    If the request is already in progress (i.e. being processed by the server),
    it cannot be cancelled and client need to wait for the completion of the
    message. In this case, API shall return #BCM_ERR_BUSY.

    @behavior Sync, Re-entrant

    @pre A message has been posted using #MSGQ_CtxSendMsg

    @param[in]      aMsgQ       Pointer to message queue
    @param[in]      aMsgHdl     Message Handle returned by #MSGQ_CtxSendMsg
    @param[out]     aMsg        Pointer to the message

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_CANCELLED      Message is cancelled
    @retval     #BCM_ERR_OK             Message processing is completed
    @retval     #BCM_ERR_BUSY           Message cannot be cancelled
    @retval     #BCM_ERR_AUTH_FAILED    Task ID of the caller is not matching
                                        with the requestor’s Task ID
    @retval     #BCM_ERR_UNKNOWN        Integration Fault
    @retval     #BCM_ERR_INVAL_PARAMS   aMsgHdl does not belong to aMsgQ
    @retval     #BCM_ERR_INVAL_PARAMS   aMsgQ does not supoort cancelling
    @retval     #BCM_ERR_INVAL_PARAMS   aMsg is  NULL
    @retval     #BCM_ERR_INVAL_PARAMS   aMsgQ has invalid magic
    @retval     #BCM_ERR_INVAL_PARAMS   aMsgQ is NULL

    @post On Successful cancellation, aHdl pointing to message will be moved to INIT_STATE

    @trace #BRCM_SWREQ_MSGQ_USER_INTERFACE

    @limitations This API shall be called only from task context.
*/
int32_t MSGQ_CtxTryCancelMsg(const MSGQ_Type* const aMsgQ,
                            MSGQ_HdlType aMsgHdl,
                            uint8_t* const aMsg);

/** @brief Query the status of submitted message

    API to query the status of the submitted message and get response. Upon
    successfully receiving the response, the API signals the server task as
    well.

    @behavior Sync, Re-entrant

    @pre A message has been posted using #MSGQ_CtxSendMsg

    @param[in]      aMsgQ       Pointer to message queue
    @param[in]      aCtxHdl     Context Handle returned by #MSGQ_CtxCreate
    @param[in]      aMsgHdl     Message Handle returned by #MSGQ_CtxSendMsg
    @param[out]     aMsg        Pointer to the message

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Message processing is completed by server
                                        and response is copied to aMsg. Handle is invalidated
    @retval     #BCM_ERR_BUSY           Message cannot be cancelled
    @retval     #BCM_ERR_AUTH_FAILED    Task ID of the caller is not matching
                                        with the requestor’s Task ID if aMsgHdl is not #MSGQ_HDL_INVALID
    @retval     #BCM_ERR_UNKNOWN        Integration Fault
    @retval     #BCM_ERR_INVAL_PARAMS   aMsgHdl does not belong to aMsgQ if aMsgHdl is not #MSGQ_HDL_INVALID
    @retval     #BCM_ERR_NOT_FOUND      No messages to receive for aCtxHdl if aMsgHdl is #MSGQ_HDL_INVALID
    @retval     #BCM_ERR_AUTH_FAILED    Task ID of the caller is not matching
                                        with the requestor’s Task ID if aMsgHdl is #MSGQ_HDL_INVALID
    @retval     #BCM_ERR_INVAL_PARAMS   aMsgQ does not support receiving messages
    @retval     #BCM_ERR_INVAL_PARAMS   aCtxHdl is not valid
    @retval     #BCM_ERR_INVAL_PARAMS   aMsg is  NULL
    @retval     #BCM_ERR_INVAL_PARAMS   aMsgQ has invalid magic
    @retval     #BCM_ERR_INVAL_PARAMS   aMsgQ is NULL


    @post aHdr pointing to message will moved to INIT_STATE

    @trace #BRCM_SWREQ_MSGQ_USER_INTERFACE

    @limitations This API shall be called by the client only when client
    notifications are enabled.
    @limitations API shall be called only from task context.
*/
int32_t MSGQ_CtxRecvMsg(const MSGQ_Type* const aMsgQ,
                        MSGQ_HdlType aCtxHdl,
                        MSGQ_HdlType aMsgHdl,
                        uint8_t* const aMsg);

/** @brief Destroy a Context on Queue

    API to destroy a context in the Queue. Upon destruction of context, server
    is notified.

    @behavior Sync, Re-entrant

    @pre There should have valid message queue server.

    @param[in]      aMsgQ       Handle to message queue
    @param[in]      aCtxHdl     Pointer to #MSGQ_HdlType

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Context is destroyed
    @retval     #BCM_ERR_BUSY           Pending processing on Context
    @retval     #BCM_ERR_AUTH_FAILED    Task ID of the caller is not matching
                                        with the requestor’s Task ID
    @retval     #BCM_ERR_UNKNOWN        Integration fault
    @retval     #BCM_ERR_NOT_FOUND      aCtxHdl does not belong to aMsgQ
    @retval     #BCM_ERR_INVAL_PARAMS   aMsgQ does not have a valid magic 'MSGQ'
    @retval     #BCM_ERR_INVAL_PARAMS   aMsgQ is NULL

    @post On successfully creating the context, server will be signaled.

    @trace #BRCM_SWREQ_MSGQ_USER_INTERFACE

    @limitations This API shall be called only from task context.
*/
int32_t MSGQ_CtxDestroy(const MSGQ_Type* const aMsgQ, MSGQ_HdlType aCtxHdl);

/** @brief Get the index of the pending message to be processed

    @behavior Sync, Re-entrant for different message queues

    @pre None

    @param[in]      aMsgQ       MsgQ from where next message index is needed
    @param[in]      aCtxIdx     Context Index from the Queue in which next message index is needed
    @param[out]     aMsgIdx     Pointer to index of message (valid only if API returns #BCM_ERR_OK)

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             There is a new message in the queue and
                                        the index has been successfully retrieved
    @retval     #BCM_ERR_BUSY           No new message in queue
    @retval     #BCM_ERR_UNKNOWN        Integration fault
    @retval     #BCM_ERR_UNINIT         Context is not created yet or destroyed
    @retval     #BCM_ERR_INVAL_PARAMS   aMsgIdx is NULL
    @retval     #BCM_ERR_INVAL_PARAMS   aCtxIdx is invalid
    @retval     #BCM_ERR_AUTH_FAILED    Task ID of the caller is not matching
                                        with the server’s Task ID
    @retval     #BCM_ERR_INVAL_PARAMS   aMsgQ does not have a valid magic
    @retval     #BCM_ERR_INVAL_PARAMS   aMsgQ is NULL

    @post On Successful fetch, message will moved to PROCESSING_STATE

    @trace #BRCM_SWREQ_MSGQ_USER_INTERFACE

    @limitations This API should be called only from server task context.
*/
int32_t MSGQ_CtxGetMsgIdx(const MSGQ_Type* const aMsgQ,
                            uint32_t aCtxIdx,
                            uint32_t* const aMsgIdx);

/** @brief Notify a message processing completion

    API to be called by server to notify a message processing completion. Upon
    marking a message as completed, the corresponding client is signaled.

    @behavior Sync, Re-entrant for different message queues

    @pre message should be in processing state.

    @param[in]      aMsgQ       Pointer to MsgQ where message processing
                                completion needs to be notified
    @param[in]      aCtxIdx     Context Index
    @param[in]      aMsgIdx     Index of the message to be marked as complete

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Message successfully moved to completed
                                        state in message queue
    @retval     #BCM_ERR_UNKNOWN        Integration fault
    @retval     #BCM_ERR_INVAL_PARAMS   API called from wrong state
    @retval     #BCM_ERR_INVAL_PARAMS   aMsgIdx is not valid
    @retval     #BCM_ERR_INVAL_PARAMS   aCtxIdx is not valid
    @retval     #BCM_ERR_AUTH_FAILED    Task ID of the caller is not matching
                                        with the server’s Task ID
    @retval     #BCM_ERR_INVAL_PARAMS   aMsgQ does not have a valid magic
    @retval     #BCM_ERR_INVAL_PARAMS   aMsgQ is NULL

    @post On Successful completion, message will moved to COMPLETED_STATE

    @trace #BRCM_SWREQ_MSGQ_USER_INTERFACE

    @limitations This API shall be called only from server task context.
*/
int32_t MSGQ_CtxCompleteMsgIdx(const MSGQ_Type* const aMsgQ,
                                uint32_t aCtxIdx,
                                uint32_t aMsgIdx);

/** @brief Check if Message Handle is valid

    API to validate msgQ and message hdl.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aMsgQ        Pointer to MsgQ
    @param[in]      aHdl         Message or Context Handle

    Return values are documented in reverse-chronological order
    @retval     #TRUE             Validated successfully
    @retval     #FALSE            Invalid aMsgQ or aHdl

    @post None

    @trace #BRCM_SWREQ_MSGQ_USER_INTERFACE
*/
uint32_t MSGQ_IsHdlValid(const MSGQ_Type* const aMsgQ, MSGQ_HdlType aHdl);

#endif /* MSG_QUEUE_H */
/** @} */
