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

/** @defgroup grp_rpc_v2_msg_il Local Interface Integration Guide
    @ingroup grp_rpc_v2_local

    @addtogroup grp_rpc_v2_msg_il
    @{

    @file rpc_local_osil.h
    @brief RPC Message Integration Interfaces
    This header file contains the integration interface for RPC Message

    @version 1.0 Initial Version
*/

#ifndef RPC_MSG_OSIL_H
#define RPC_MSG_OSIL_H

#include <pt_utils.h>
#include <msg_queue.h>
#include <rpc_mem.h>

/**
    @name RPC Integration Interface IDs
    @{
    @brief Integration Interface IDs for RPC

*/
#define BRCM_SWARCH_RPC_MASTER_LOAD_MSG_MAX_MACRO        (0x9201U)    /**< @brief #RPC_MASTER_LOAD_MSG_MAX   */
#define BRCM_SWARCH_RPC_MASTER_ASYNC_MSG_MAX_MACRO       (0x9202U)    /**< @brief #RPC_MASTER_ASYNC_MSG_MAX  */
#define BRCM_SWARCH_RPC_SLAVE_LOCAL_MSG_MACRO            (0x9203U)    /**< @brief #RPC_SLAVE_LOCAL_MSG_MAX   */
#define BRCM_SWARCH_RPC_MASTER_MAX_OBECTS_MACRO          (0x9204U)    /**< @brief #RPC_MASTER_MAX_OBJECTS    */
#define BRCM_SWARCH_RPC_MASTERLOADREQ_TYPE               (0x9205U)    /**< @brief #RPC_MasterLoadReqType     */
#define BRCM_SWARCH_RPC_MASTERLOAD_TYPE                  (0x9206U)    /**< @brief #RPC_MasterLoadType        */
#define BRCM_SWARCH_RPC_LOCALMSG_TYPE                    (0x9207U)    /**< @brief #RPC_LocalMsgType          */
#define BRCM_SWARCH_RPC_MASTERIFCOBJECTS_GLOBAL          (0x9208U)    /**< @brief #RPC_MasterIfcObjects      */
#define BRCM_SWARCH_RPC_MASTEREVENT_GLOBAL               (0x9209U)    /**< @brief #RPC_MasterEvent           */
#define BRCM_SWARCH_RPC_SLAVEEVENT_GLOBAL                (0x920AU)    /**< @brief #RPC_SlaveEvent            */
#define BRCM_SWARCH_RPC_GETLOADERMSGQ_PROC               (0x920BU)    /**< @brief #RPC_GetLoaderMsgQ         */
#define BRCM_SWARCH_RPC_MASTERLOADERGETMSG_PROC          (0x920CU)    /**< @brief #RPC_MasterLoaderGetMsg    */
#define BRCM_SWARCH_RPC_GETASYNCMSGQ_PROC                (0x920DU)    /**< @brief #RPC_GetAsyncMsgQ          */
#define BRCM_SWARCH_RPC_MASTERASYNCGETMSG_PROC           (0x920EU)    /**< @brief #RPC_MasterAsyncGetMsg     */
#define BRCM_SWARCH_RPC_MSGQGETCMDQ_PROC                 (0x920FU)    /**< @brief #RPC_MsgQGetCmdQ           */
#define BRCM_SWARCH_RPC_MSGQGETCMD_PROC                  (0x9210U)    /**< @brief #RPC_MsgQGetCmd            */
#define BRCM_SWARCH_RPC_ASYNCEVENTTOHOST_PROC            (0x9216U)    /**< @brief #RPC_AsyncEventToHost      */
#define BRCM_SWARCH_RPC_SLAVESENDLOCALCMD_PROC           (0x9219U)    /**< @brief #RPC_SlaveSendLocalCmd     */
#define BRCM_SWARCH_RPC_SLAVEGETLOCALRESP_PROC           (0x921AU)    /**< @brief #RPC_SlaveGetLocalResp     */
#define BRCM_SWARCH_RPC_LOAD_RAW_IMG_PROC                (0x921BU)    /**< @brief #RPC_LoadRawImg            */
#define BRCM_SWARCH_RPC_LOAD_GET_STATUS_PROC             (0x921CU)    /**< @brief #RPC_LoadGetStatus         */
#define BRCM_SWARCH_RPC_LOAD_CANCEL_PROC                 (0x921DU)    /**< @brief #RPC_LoadCancel            */
#define BRCM_SWARCH_RPC_GET_IMG_TBL_PROC                 (0x921EU)    /**< @brief #RPC_GetImgTbl             */
#define BRCM_SWARCH_RPC_GET_IMG_SIZE_PROC                (0x921FU)    /**< @brief #RPC_GetImgSize            */
#define BRCM_SWARCH_RPC_TIMER_ALARM_CB_PROC              (0x9220U)    /**< @brief #RPC_TimerAlarmCb          */
#define BRCM_SWARCH_RPC_DISABLE_TIMEOUT_VAL_MACRO        (0x9221U)    /**< @brief #RPC_DISABLE_TIMEOUT_VAL   */
#define BRCM_SWARCH_RPC_STREAMTIMEOUTMS_GLOBAL           (0x9222U)    /**< @brief #RPC_StreamTimeoutMs       */
/** @} */

/**
    @brief Image Loader structure for RPC Master

    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL
 */
typedef uint32_t RPC_MasterLoadType;
#define RPC_MASTERLOAD_PTBL_REQ     (1UL)
#define RPC_MASTERLOAD_ITBL_REQ     (2UL)
#define RPC_MASTERLOAD_IMAGE_REQ    (3UL)

/**
    @brief RPC Message Master Maximum number of loader messages

    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL
*/
#define RPC_MASTER_LOAD_MSG_MAX    (4UL)

/**
    @brief RPC Message Master Maximum number of Async messages

    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL
*/
#define RPC_MASTER_ASYNC_MSG_MAX    (4UL)

/**
    @brief RPC Message Master Maximum number of Async messages

    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL
*/
#define RPC_SLAVE_LOCAL_MSG_MAX    (4UL)

/**
    @brief Value to configure that timeout in not enabled

    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL
*/
#define RPC_DISABLE_TIMEOUT_VAL    (0xFFFFFFFFFFFFFFFFULL)

/**
    @brief Imagle Loader structure for RPC Master

    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL
 */
typedef struct sRPC_MasterLoadReqType{
    RPC_MasterLoadType fetchCmd;     /**< @brief Image Loader Fetch type Command          */
    int32_t  result;                 /**< @brief Result of the last request               */
    uint32_t channel;                /**< @brief Channel for fetching image (IPC/UDP)     */
    PTBL_IdType pid;                 /**< @brief Partition ID                             */
    uint16_t imgID;                  /**< @brief Image ID                                 */
    uint8_t* imgLoadAddrBuf;         /**< @brief Address buffer where image shall be
                                          loaded by RPC                                   */
    uint32_t inLen;                  /**< @brief Length of the buffer                     */
    uint32_t imgOffset;              /**< @brief offset from where the image to be loaded */
    uint32_t filledSize;             /**< @brief Filled size                              */
    uint64_t streamTimeout;          /**< @brief Time at which stream is to timeout       */
} RPC_MasterLoadReqType;

/**
    @brief Maximum RPC Component Modules

    This macro defines the number of entries in RPC_MasterIfcObjects

    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL
*/
#define RPC_MASTER_MAX_OBJECTS (8UL)

/**
    @brief RPC Master Event

    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL
*/
extern const uint32_t RPC_MasterEvent;

/**
    @brief RPC Stream timeout value in milliseconds

    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL
*/
extern const uint32_t RPC_StreamTimeoutMs;

/**
    @brief Get Loader Message Queue

    @behavior Sync, non-reentrant

    @pre Message Q should be in Initialized stage

    @return   Pointer to the message Queue
    @return   NULL if Message Q is Not defined

    @post None

    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL

    @limitations None
*/
const MSGQ_Type* RPC_GetLoaderMsgQ (void);

/**
    @brief Get the aIdx-th message from memory

    Retrieve the aIdx-th message from server.

    @behavior Sync, non-reentrant

    @pre None

    @param[in]  aIdx    Index of the message

    @return    Pointer to the aIdx-th message
    @return    NULL if idx >= RPC_MASTER_LOAD_MSG_MAX

    @post None

    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL

    @limitations None
*/
extern void* RPC_MasterLoaderGetMsg(uint32_t aIdx);

/**
    @brief Get Async Message Queue

    @behavior Sync, non-reentrant

    @pre Message Q should be in Initialized stage

    @return   Pointer to the message Queue
    @return   NULL if Message Q is Not defined

    @post None

    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL

    @limitations None
*/
const MSGQ_Type* RPC_GetAsyncMsgQ (void);

/**
    @brief Get the aIdx-th message from memory

    Retrieve the aIdx-th message from server.

    @behavior Sync, non-reentrant

    @pre None

    @param[in]  aIdx    Index of the message

    @return    Pointer to the aIdx-th message
    @return    NULL if idx >= RPC_MASTER_ASYNC_MSG_MAX

    @post None

    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL

    @limitations None
*/
extern void* RPC_MasterAsyncGetMsg(uint32_t aIdx);

/**
    @brief Local Command structure for Message Queue Slave and
    for managing Async events to Host

    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL
 */
typedef struct sRPC_LocalMsgType{
    BCM_CmdType cmd;                             /**< @brief Command ID            */
    int32_t     result;                          /**< @brief result of the command */
    uint32_t    cfgTimeoutMs;                    /**< @brief Configured command
                                                      timeout in ms                */
    RPC_HdlType hdl;                             /**< @brief Handle allocated for this message */
    uint64_t    timeoutNs;                       /**< @brief Time at which message
                                                      needs to timeout. This is the
                                                      time at which message proc
                                                      started plus the cfgTimeoutMs*/
    uint32_t    payLoadSize;                     /**< @brief Payload size in bytes */
    uint8_t     payLoad[RPC_MEM_MSG_PAYLOAD_SZ]; /**< @brief Command Payload       */
} RPC_LocalMsgType;

/**
    @brief Get MsgQ Slave Local Message Queue

    @behavior Sync, non-reentrant

    @pre Local Message Q should be in Initialized stage

    @return   Pointer to the message Queue
    @return   NULL if Message Q is Not defined

    @post None

    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL

    @limitations None
*/
const MSGQ_Type* RPC_MsgQGetCmdQ (void);

/**
    @brief Get the aIdx-th message from memory

    Retrieve the aIdx-th message from server.

    @behavior Sync, non-reentrant

    @pre None

    @param[in]  aIdx    Index of the message

    @return    Pointer to the aIdx-th message
    @return    NULL if idx >= RPC_SLAVE_LOCAL_MSG_MAX

    @post None

    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL

    @limitations None
*/
extern void* RPC_MsgQGetCmd(uint32_t aIdx);

/**
    @brief Message Queue Slave Event

    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL
*/
extern const uint32_t RPC_SlaveEvent;

/**
    @brief Module Functions table for RPC Components

    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL
*/
extern const SERVICE_Type * const RPC_MasterIfcObjects[RPC_MASTER_MAX_OBJECTS];

/** @brief Send Async Messages to Host

    This API queues the Async Messages to Host

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aGrpID             Group ID ID value
    @param[in]      aCompID            Component ID value
    @param[in]      aCmdID             Command ID value
    @param[in]      aBuff              Pointer to the Buffer
    @param[in]      aLen               Length of the message

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Asyc Message is posted successfully
    @retval     #BCM_ERR_NOMEM          Async Queue is Full and cannot be added to queue
    @retval     #BCM_ERR_INVAL_PARAMS   aGrpID is invalid or
                                        aCompID is invalid or
                                        aCmdID is invalid or
                                        (aBuff is NULL AND aLen is NOT 0) OR
                                        (aBuff is NOT NULL AND aLen is 0) OR
                                        aLen is more than available memory

    @post None

    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL

    @limitations None
*/
extern int32_t RPC_AsyncEventToHost(BCM_GroupIDType aGrpID, BCM_CompIDType aCompID, uint8_t aCmdID,
                                      const uint8_t *const aBuff, uint32_t aLen);

/** @brief Send Command Messages to MsgQ Slave

    This API queues the local Command Messages

    @behavior Sync, Re-entrant

    @pre None

    @param[in]     aGrpID             Group ID ID value
    @param[in]     aCompID            Component ID value
    @param[in]     aCmdID             Command ID value
    @param[in]     aBuff              Pointer to the Message
    @param[in]     aLen               Length of the message
    @param[in]     aTimeoutMs         Timeout in milliseconds
    @param[in]     aClientMask        Client mask to be set on command completion
    @param[out]    aHdr               Pointer to the message queue header used to
                                      Retrieve the status

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Asyc Message is posted successfully
    @retval     #BCM_ERR_NOMEM          Async Queue is Full and cannot be added to queue
    @retval     #BCM_ERR_INVAL_PARAMS   aGrpID is invalid or
                                        aCompID is invalid or
                                        aCmdID is invalid or
                                        aLen is 0 or
                                        aHdr is NULL or
                                        aBuff is NULL

    @post None

    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL

    @limitations None
*/
extern int32_t RPC_SlaveSendLocalCmd(BCM_GroupIDType aGrpID, BCM_CompIDType aCompID, uint8_t aCmdID,
                                     const uint8_t *const aBuff, uint32_t aLen, uint32_t aTimeoutMs,
                                     uint32_t aClientMask, const MSGQ_MsgHdrType** const aHdr);

/** @brief Receive Command Message Response from MsgQ Slave

    This API provides the response of the Command

    @behavior Sync, Re-entrant

    @pre None

    @param[in]     aHdr             Pointer to the message queue header to
                                    Retrieve the status
    @param[out]    aResponse        Result of the Message Queue command
    @param[in]     aBuff            Pointer to read the message
    @param[out]    aSize            Size of the Message

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Asyc Message is posted successfully
    @retval     #BCM_ERR_NOMEM          Async Queue is Full and cannot be added to queue
    @retval     #BCM_ERR_INVAL_PARAMS   aHdr is NULL or
                                        aResponse is NULL or
                                        aBuff is NULL or
                                        aSize is NULL

    @post None

    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL

    @limitations None
*/
extern int32_t RPC_SlaveGetLocalResp(const MSGQ_MsgHdrType *const aHdr, int32_t * const aResponse,
                                     uint8_t *const aBuff, uint32_t * const aSize);

/** @brief Load raw image request

    This API posts request to load a raw image from given partition (aPID).
    After image is loaded, caller will be signalled and
    it shall call RPC_LoadGetStatus() API to
    find the status of the loaded image and its actual
    size.


    @behavior Async, Non-reentrant

    @pre None

    @param[in]      aPID            Partition ID
    @param[in]      aImgID          Image ID
    @param[in]      aIsTbl          Is Image Table
    @param[in]      aAddr           Memory address where this image will be loaded
    @param[in]      aOffset         Offset within image
    @param[in]      aBufSize        Lenght of the buffer (aAddr)
    @param[in]      aClientMask     Signal mask which will be triggered
                                    when image is loaded
    @param[out]     aHdr            MSGQ header (shall be used later to query the
                                    status by calling RPC_LoadGetStatus().

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Request is accepted. Caller will be signaled
                                        when image loading completes
    @retval     #BCM_ERR_INVAL_PARAMS   aAddr is NULL or
                                        aBufSize is 0
    @retVal     #BCM_ERR_BUSY           Previous request is pending


    @post None

    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL

   @limitations This API shall be called from the task context.
*/
extern int32_t RPC_LoadRawImg(PTBL_IdType aPid, uint16_t aImgID, uint8_t *const aAddr,
                            uint32_t aOffset, uint32_t aBufSize, const uint32_t aClientMask,
                            const MSGQ_MsgHdrType** const aHdr);

/** @brief Get status of the image load request

    This APIs returns the status of the load image
    request and actual size of the image loaded.

    @behavior Sync, Non-reentrant

    @pre None

    @param[out]      aSize            Actual size of the image loaded
    @param[int]      aHdr             MSGQ header


    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             image is loaded successfully
                                        and actual size of the image
                                        is returned in aSize.
    @retval     #BCM_ERR_INVAL_PARAMS   aSize is NULL
    @retVal     #BCM_ERR_BUSY           Request is pending (image is
                                        being loaded)

    @post None

    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL

    @limitations None
*/
extern int32_t RPC_LoadGetStatus(const MSGQ_MsgHdrType* const aHdr, uint32_t *const aSize);

/**
    Same as @ref IMGL_LoadCancel

    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL
*/
extern int32_t RPC_LoadCancel(const MSGQ_MsgHdrType* const aHdr);

/**
    Same as @ref IMGL_GetImgTbl

    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL
*/
extern const ITBL_Type *RPC_GetImgTbl(PTBL_IdType aPid);

/**
    Same as @ref IMGL_GetImgSize

    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL
*/
extern uint32_t RPC_GetImgSize(PTBL_IdType aPid, uint16_t aImgID, uint32_t aOffset);

/** @brief Timer Alarm callback function

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      void

    @return     void

    @post None

    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL

    @limitations None
*/
extern void RPC_TimerAlarmCb(void);

#endif /* RPC_MSGQ_MASTER_H */
/** @} */
