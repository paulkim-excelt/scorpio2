/*****************************************************************************
 Copyright 2017-2018 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_nvm_ifc Interface
    @ingroup grp_nvm_service

    @addtogroup grp_nvm_ifc
    @{
    @section sec_nvm_overview Overview
    @image html nvm_overview.jpg "NVM Server Layers"
    NVM Service is thin interface layer which supports queuing of flash
    operation requests from the multiple clients for same flash controller.
    Flash operation requests are queued to flash manager message queue  and upon
    completion, client is signaled. Upon signaling, client shall check the
    status of the request by calling #NVM_GetStatus.

    Flash manager support following flash operations:
    - Flash initialization (with flash read lane configuration)
    - Flash read
    - Flash write
    - Flash erase
    - Flash compare
    - Flash blank check
    - Flash de-initialization

    @section sec_nvm_fsm State Machine
    @image html nvm_state_machine.jpg "Flash manager state machine"

    Flash manager states:
    - #NVM_STATE_UNINIT: Flash manager uninitialized or de-initialized after
    initialization.
    - #NVM_STATE_IDLE: Flash manager is initialized and currently no
    operation request in progress.
    - #NVM_STATE_BUSY: Flash manager is busy in processing operation request

    @note Any operation request queued after flash manager de-initialization
    request and before flash manager is de-initialized (Flash manager moves to
    #NVM_STATE_UNINIT) shall be marked failed with #NVM_OP_RESULT_FAILED.

    @section sec_nvm_seq Sequence Diagrams
    This section describes use case diagram for flash manager.

    Note that APIs like #NVM_Erase, #NVM_Write, #NVM_Compare,
    #NVM_BlankCheck shall follow same sequence as #NVM_Read.

    @image html nvm_seq_diagram_gen.jpg "Flash manager use-case "

    @section sec_nvm_perf Performance & Memory

    | Performance       | Description                                       |
    |:-----------------:|:-------------------------------------------------:|
    | CPU Load          |  NA                                               |
    | Memory Bandwidth  |  NA                                               |
    | HW Utilization    |  NA                                               |

    @limitations None

    @file nvm.h
    @brief Application interface for NVM Server
    This header file contains the interfaces for NVM Server
    @version 0.52 Imported from docx
*/

#ifndef NVM_H
#define NVM_H

#include <msg_queue.h>
#include <flash.h>
#include <osil/flash_osil.h>

/**
    @name NVM API IDs
    @{
    @brief API IDs for NVM Server
*/
#define BRCM_SWARCH_NVM_STATE_TYPE              (0x8101U)    /**< @brief #NVM_StateType    */
#define BRCM_SWARCH_NVM_OP_RESULT_TYPE          (0x8102U)    /**< @brief #NVM_OpResultType */
#define BRCM_SWARCH_NVM_GET_STATE_PROC          (0x8103U)    /**< @brief #NVM_GetState     */
#define BRCM_SWARCH_NVM_CANCEL_PROC             (0x8104U)    /**< @brief #NVM_Cancel       */
#define BRCM_SWARCH_NVM_FLS_READ_PROC           (0x8105U)    /**< @brief #NVM_Read         */
#define BRCM_SWARCH_NVM_FLS_WRITE_PROC          (0x8106U)    /**< @brief #NVM_Write        */
#define BRCM_SWARCH_NVM_FLS_ERASE_PROC          (0x8107U)    /**< @brief #NVM_Erase        */
#define BRCM_SWARCH_NVM_FLS_COMPARE_PROC        (0x8108U)    /**< @brief #NVM_Compare      */
#define BRCM_SWARCH_NVM_FLS_BLANK_CHECK_PROC    (0x8109U)    /**< @brief #NVM_BlankCheck   */
#define BRCM_SWARCH_NVM_GET_STATUS_PROC         (0x810AU)    /**< @brief #NVM_GetStatus    */
/** @} */


/**
    @name NVM_AddrType
    @{
    @brief NVM Device address type

    This type is used for describing memory mapped device address for NVM operation.

    @trace #BRCM_SWREQ_NVM_ADDR
*/
typedef uint64_t NVM_AddrType; /**< @brief NVM Device address type */
#define NVM_MAX_REGION_OTP           (0x10000UL)
#define NVM_START_ADDR_OTP0          (0x00ULL)
#define NVM_START_ADDR_OTP1          (NVM_START_ADDR_OTP0 + NVM_MAX_REGION_OTP)
#define NVM_START_ADDR_OTP2          (NVM_START_ADDR_OTP1 + NVM_MAX_REGION_OTP)
#define NVM_START_ADDR_OTP3          (NVM_START_ADDR_OTP2 + NVM_MAX_REGION_OTP)

#define NVM_MAX_REGION_FLASH         (0x10000000UL)
#define NVM_START_ADDR_FLASH0        (0x10000000ULL)
#define NVM_START_ADDR_FLASH1        (NVM_START_ADDR_FLASH0 + NVM_MAX_REGION_FLASH)
/** @} */


/**
    @name NVM_StateType
    @{
    @brief NVM device state types

    @trace #BRCM_SWREQ_NVM_STATE
*/
typedef uint32_t NVM_StateType;      /**< @brief NVM state type */
#define NVM_STATE_UNINIT     (0UL)   /**< @brief NVM device state uninit */
#define NVM_STATE_IDLE       (1UL)   /**< @brief NVM device state idle */
#define NVM_STATE_BUSY       (2UL)   /**< @brief NVM device state busy */
/** @} */

/**
    @name NVM_OpResultType
    @{
    @brief NVM operation result type

    @trace #BRCM_SWREQ_NVM_OP_RESULT
*/
typedef uint32_t NVM_OpResultType;       /**< @brief Operation result type */
#define NVM_OP_RESULT_SUCCESS    (1UL)   /**< @brief Operation result success */
#define NVM_OP_RESULT_FAILED     (2UL)   /**< @brief Operation result failed */
#define NVM_OP_RESULT_PENDING    (3UL)   /**< @brief Operation result pending */
/** @} */


/** @brief Retrieve NVM device state

    Interface to retrieve NVM device state based on #NVM_DevIDType.

    @behavior Sync, Re-entrant

    @pre TBD

    @param[in]      aID         NVM device ID
    @param[out]     aState      Pointer to retrieve NVM state

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             NVM state retrieved
                                        successfully
    @retval     #BCM_ERR_INVAL_PARAMS   aState is NULL
    @retval     #BCM_ERR_INVAL_PARAMS   Invalid aID

    @post TBD

    @trace #BRCM_SWREQ_NVM_GET_STATE

    @limitations None
*/
extern int32_t NVM_GetState(NVM_StateType * const aState);


/** @brief NVM Flash device read request

    Interface to queue flash read request to NVM Server. For successfully
    queued request, flash read shall be performed from aAddr for @c aLen bytes.
    On completion of this request, client shall be signaled using @c
    aClientMask. Client shall only wait for signal from flash manager for
    successfully queued request.

    @behavior Async, Re-entrant

    @pre TBD

    @param[in]      aAddr       Flash read address
    @param[out]     aBuf        Pointer to output data buffer
    @param[in]      aLen        Length in bytes
    @param[in]      aClientMask Client signal mask. This signal shall be used to
                                notify client about completion of the request
    @param[out]     aMsgHdr     Pointer to unique message header for the
                                operation request, this message header shall be
                                used to:
                                - Query the result of the operation using
                                  #NVM_GetStatus or
                                - Cancel the operation using #NVM_Cancel

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Flash read request successfully queued
    @retval     Others                  As returned from #NVM_SendMsg
    @retval     #BCM_ERR_UNINIT         Flash manager is in #NVM_STATE_UNINIT
                                        state
    @retval     #BCM_ERR_INVAL_PARAMS   aMsgHdr is NULL
    @retval     #BCM_ERR_INVAL_PARAMS   aLen is zero
    @retval     #BCM_ERR_INVAL_PARAMS   aBuf is NULL
    @retval     #BCM_ERR_INVAL_PARAMS   Invalid aIInvalid aID

    @post TBD

    @trace #BRCM_SWREQ_NVM_FLS_READ

    @limitations This interface shall be called from task context.
*/
extern int32_t NVM_Read(NVM_AddrType aAddr,
                           uint8_t * const aBuf,
                           uint32_t aLen,
                           const uint32_t aClientMask,
                           const MSGQ_MsgHdrType ** const aMsgHdr);

/** @brief NVM Flash write request

    Interface to queue flash write request to NVM server. For successfully
    queued request, flash write shall be performed from @c aAddr for @c aLen
    bytes. On completion of this request, client shall be signaled using
    @c aClientMask.

    Client shall only wait for signal from NVM server for successfully queued
    request.


    @behavior Async, Re-entrant

    @pre TBD

    @param[in]      aAddr       Flash write address
    @param[in]      aBuf        Pointer to data buffer to be written
    @param[in]      aLen        Length in bytes
    @param[in]      aClientMask Client signal mask. This signal shall be used to
                                notify client about completion of the request
    @param[out]     aMsgHdr     Pointer to unique message header for the
                                operation request, this message header shall be
                                used to
                                - Query the result of the operation using
                                  #NVM_GetStatus or
                                - Cancel the operation using #NVM_Cancel

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Flash write request successfully queued
    @retval     Others                  As returned from #NVM_SendMsg
    @retval     #BCM_ERR_UNINIT         Flash manager is in
                                        #NVM_STATE_UNINIT state
    @retval     #BCM_ERR_INVAL_PARAMS   @c aMsgHdr is NULL
    @retval     #BCM_ERR_INVAL_PARAMS   @c aLen is zero
    @retval     #BCM_ERR_INVAL_PARAMS   @c aBuf is NULL
    @retval     #BCM_ERR_INVAL_PARAMS   Invalid @c aID


    @post TBD

    @trace #BRCM_SWREQ_NVM_FLS_WRITE

    @limitations This interface shall be called from task context
*/
extern int32_t NVM_Write(NVM_AddrType aAddr,
                           const uint8_t * const aBuf,
                           uint32_t aLen,
                           const uint32_t aClientMask,
                           const MSGQ_MsgHdrType ** const aMsgHdr);

/** @brief Flash erase request

    Interface to queue flash erase request to NVM server. For successfully
    queued request, flash erase shall be performed from @c aAddr for @c aLen
    bytes. On completion of this request, client shall be signaled using
    @c aClientMask.

    Client shall only wait for signal from flash manager for successfully queued
    request.

    @behavior Async, Re-entrant

    @pre TBD

    @param[in]      aAddr       Flash erase address
    @param[in]      aLen        Length in bytes to be erased
    @param[in]      aClientMask Client signal mask. This signal shall be used to
                                notify client about completion of the request
    @param[out]     aMsgHdr     Pointer to unique message header for the
                                operation request, this message header shall be
                                used to:
                                - Query the result of the operation using
                                  #NVM_GetStatus or
                                - Cancel the operation using #NVM_Cancel

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Flash erase request successfully queued
    @retval     Others                  As returned from #NVM_SendMsg
    @retval     #BCM_ERR_UNINIT         Flash manager is in
                                        #NVM_STATE_UNINIT state
    @retval     #BCM_ERR_INVAL_PARAMS   @c aMsgHdr is NULL
    @retval     #BCM_ERR_INVAL_PARAMS   @c aLen is zero
    @retval     #BCM_ERR_INVAL_PARAMS   Invalid @c aID

    @post TBD

    @trace #BRCM_SWREQ_NVM_ERASE

    @limitations This interface shall be called from task context.
*/
extern int32_t NVM_Erase(NVM_AddrType aAddr,
                           uint32_t aLen,
                           const uint32_t aClientMask,
                           const MSGQ_MsgHdrType ** const aMsgHdr);

/** @brief Get NVM operation result

    Interface to retrieve result for the NVM operation request queued
    previously and associated with unique @c aMsgHdr.

    @behavior Sync, Re-entrant

    @pre TBD

    @param[out]     aOpResult   NVM operation result
    @param[in]      aMsgHdr     Pointer to unique message header for the
                                operation request, this message header shall be
                                used to:
                                - Query the result of the operation using
                                  #NVM_GetStatus or
                                - Cancel the operation using #NVM_Cancel

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Result successfully retrieved
    @retval     Others                  As returned from #NVM_RecvMsg
    @retval     #BCM_ERR_INVAL_PARAMS   @c aMsgHdr is NULL
    @retval     #BCM_ERR_INVAL_PARAMS   @c aOpResult is NULL
    @retval     #BCM_ERR_INVAL_PARAMS   Invalid @c aID

    @post TBD

    @trace #BRCM_SWREQ_NVM_GET_OP_RESULT

    @limitations Result shall only be retrieved by the original requestor
    client.
    @limitations This interface shall be called from task context.
*/
extern int32_t NVM_GetStatus(NVM_OpResultType * const aOpResult,
                                  const MSGQ_MsgHdrType * const aMsgHdr,
                                  uint32_t *aLen);

/** @brief Cancel NVM operation request

    Interface to cancel NVM device operation requests already queued with NVM.
    If the request to be cancelled is already in progress, then the
    request shall complete as usual without cancellation.

    If the request to be cancelled is already completed, then operation result
    shall be retrieved in the interface call.

    @behavior Sync, Re-entrant

    @pre TBD

    @param[in]      aOpResult   Pointer to retrieve operation result, in case
                                the operation request is already processed
    @param[inout]     aMsgHdr     Unique message header retrieved during operation
                                request

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Request already processed cancellation
                                        not possible. Result is retrieved in
                                        @c aOpRessult.
    @retval     Others                  As returned from #NVM_TryCancelMsg
    @retval     #BCM_ERR_INVAL_PARAMS   aMsgHdr is NULL
    @retval     #BCM_ERR_INVAL_PARAMS   Invalid aID

    @post TBD

    @trace #BRCM_SWREQ_NVM_CANCEL

    @limitations Request shall only be cancelled by the original requestor
    client.
    @limitations This interface shall be called from task context.

*/
extern int32_t NVM_Cancel(NVM_OpResultType * const aOpResult,
                             const MSGQ_MsgHdrType * const aMsgHdr);

#endif /* NVM_H */
/** @} */
