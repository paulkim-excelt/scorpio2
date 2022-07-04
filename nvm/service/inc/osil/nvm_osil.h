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

/** @defgroup grp_nvm_il Integration Guide
    @ingroup grp_nvm

    @addtogroup grp_nvm_il
    @{
    @section sec_nvm_integration Integration Guide
    This section describes all the details to integrate flash manager to system.

    @section sec_nvm_il_seq Sequence Diagram
    This section describes integration sequence diagram for #NVM_FlsRead,
    #NVM_GetStatus and #NVM_FlsCancel. Flash manger asynchronous operations
    like #NVM_Init and #NVM_DeInit shall follow same sequence as
    #NVM_FlsRead.

    @image html nvm_seq_il_diagram.jpg "Integration layer sequence diagram"

    @file nvm_osil.h
    @brief Flash manager Integration Interfaces
    This header file contains the integration interface for Flash manager.
    @version 0.52 Imported from docx
*/

#ifndef NVM_OSIL_H
#define NVM_OSIL_H

#include <system_module.h>
#include <nvm.h>

/**
    @name NVM Interface IDs
    @{
    @brief Inegration Interface IDs for NVM Server
*/
#define BRCM_SWARCH_NVM_DEV_ID_TYPE               (0x9201U)    /**< @brief #NVM_DevIDType    */
#define BRCM_SWARCH_NVM_INIT_PROC                 (0x9202U)    /**< @brief #NVM_Init         */
#define BRCM_SWARCH_NVM_DEINIT_PROC               (0x9203U)    /**< @brief #NVM_DeInit       */
#define BRCM_SWARCH_NVM_IL_CMD_TYPE               (0x9204U)    /**< @brief #NVM_CmdType      */
#define BRCM_SWARCH_NVM_IL_MSG_TYPE               (0x9205U)    /**< @brief #NVM_MsgType      */
#define BRCM_SWARCH_NVM_IL_MSG_HANDLER_PROC       (0x9206U)    /**< @brief #NVM_MsgHandler   */
#define BRCM_SWARCH_NVM_IL_EVENT_HANDLER_PROC     (0x9207U)    /**< @brief #NVM_EventHandler */
#define BRCM_SWARCH_NVM_IL_SEND_MSG_PROC          (0x9208U)    /**< @brief #NVM_SendMsg      */
#define BRCM_SWARCH_NVM_IL_TRY_CANCEL_MSG_PROC    (0x9209U)    /**< @brief #NVM_TryCancelMsg */
#define BRCM_SWARCH_NVM_IL_RECV_MSG_PROC          (0x920AU)    /**< @brief #NVM_RecvMsg      */
#define BRCM_SWARCH_NVM_IL_SERVER_INIT_PROC       (0x920BU)    /**< @brief #NVM_ServerInit   */
#define BRCM_SWARCH_NVM_FNTABLE_GLOBAL            (0x920CU)    /**< @brief #NVM_FnTable      */
#define BRCM_SWARCH_NVM_IL_PHY_2_VIRT_PROC        (0x920DU)    /**< @brief #NVM_Phy2VirtAddr */
/** @} */

/**
    @name NVM_CmdType
    @{
    @brief NVM command type.

    This type shall be used for describing NVM command in NVM
    message type (#NVM_MsgType).

    @trace #BRCM_SWREQ_NVM_IL_CMD
*/
typedef uint8_t NVM_CmdType;    /**< @brief NVM Server command type */
#define NVM_CMD_READ                     (1U)   /**< Read command */
#define NVM_CMD_WRITE                    (2U)   /**< Write command */
#define NVM_CMD_ERASE                    (3U)   /**< Erase command */
/** @} */

typedef uint32_t  NVM_DevType;   /**< @brief NVM device type */
#define NVM_TYPE_OTP    (0UL)
#define NVM_TYPE_FLASH  (1UL)

/**
    @name NVM_DevIDType
    @{
    @brief NVM device type

    @trace #BRCM_SWREQ_NVM_DEV_ID
*/
typedef uint32_t  NVM_DevIDType;   /**< @brief NVM device type */
/** @} */

/**
    @brief NVM message type

    This type shall be used for passing message using message queue.

    @trace #BRCM_SWREQ_NVM_IL_MSG
*/
typedef struct {
    NVM_DevIDType       aID;
    NVM_CmdType         cmd;        /**< @brief NVM command */
    NVM_AddrType        virtAddr;   /**< @brief NVM operation address */
    uint32_t            len;        /**< @brief NVM operation length */
    const uint8_t *     bufIn;      /**< @brief Input data buffer */
    uint8_t *           bufOut;     /**< @brief Output data buffer */
    NVM_OpResultType    opResult;   /**< @brief Operation result */
} NVM_MsgType;

/**
    @brief NVM configuration type

    @trace #BRCM_SWREQ_NVM_IL_CFG
*/
typedef struct {
    const void *const   aCfg;     /**< @brief Pointer to NVM driver configuration */
    NVM_DevType         aDev;       /**< @brief NVM Device type */
    NVM_DevIDType       aID;        /**< @brief NVM Controller ID */
    NVM_AddrType        startAddr;  /**< @brief NVM Device start address */
    uint32_t            nvmSize;    /**< @brief NVM Device region */
    uint32_t            maxSize;    /**< @brief NVM Memory integarted size */
} NVM_CfgType;

extern const NVM_CfgType * const     NVM_CfgTbl;
extern const uint32_t                   NVM_CfgTblSz;

/** @brief Initialize NVM server

    Interface to initialize NVM server. This interface also initializes flash
    driver with given configurations and configures the flash read lanes.

    @behavior Async, Re-entrant (for differnt aID)

    @pre TBD

    @param[in]      void

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Flash Initialization request
                                        successfully queued.
    @retval     Others                  As returned from #NVM_SendMsg
    @retval     Others                  As returned from #FLASH_Init
    @retval     #BCM_ERR_UNKNOWN        Flash is not in #FLASH_STATUS_IDLE state
                                        after initialization
    @retval     #BCM_ERR_INVAL_STATE    Flash manager is not in
                                        #NVM_STATE_UNINIT state
    @retval     #BCM_ERR_INVAL_PARAMS   aMsgHdr is NULL
    @retval     #BCM_ERR_INVAL_PARAMS   aConfig->flashCfg is NULL
    @retval     #BCM_ERR_INVAL_PARAMS   aConfig is NULL
    @retval     #BCM_ERR_INVAL_PARAMS   Invalid aID

    @post TBD

    @trace #BRCM_SWREQ_NVM_INIT

    @limitations None
*/
extern int32_t NVM_Init(void);

/** @brief De-initialize flash manager

    Interface to de-initialize NVM Server. NVM processes all the
    pending requests in the queue before processing de-initialization request.
    On completion of this request, client shall be notified by signaling using
    @c aClientMask.

    All requests queued after queuing of de-initialization request and before
    NVM server is de-initialized are marked failed with operation result as
    #NVM_OP_RESULT_FAILED.

    @behavior Async, Re-entrant

    @pre TBD

    @param[in]      void

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             De-initialization request successfully
                                        queued.
    @retval     Others                  As returned from #NVM_SendMsg
    @retval     #BCM_ERR_UNINIT         Flash manager is in
                                        #NVM_STATE_UNINIT state
    @retval     #BCM_ERR_INVAL_PARAMS   aMsgHdr is NULL
    @retval     #BCM_ERR_INVAL_PARAMS   aID is invalid

    @post TBD

    @trace #BRCM_SWREQ_NVM_DEINIT

    @limitations This interface shall be called from task context.
*/
extern int32_t NVM_DeInit(void);

/** @brief Handle NVM messages

    Interface to handle NVM messages.

    @behavior Sync, Re-entrant (for different aID)

    @pre TBD

    @param[in]      aID         Flash manager device ID
    @param[in]      aMsg        Pointer to flash manager message

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Message processing complete, message
                                        shall be marked as complete.
    @retval     #BCM_ERR_EAGAIN         Message processing in-progress. Message
                                        shall not be marked as complete.
    @retval     #BCM_ERR_INVAL_PARAMS   Returned in the following cases:
                                        - aMsg->cmd is invalid
                                        - Invalid aID
                                        - aMsg is NULL

    @post TBD

    @note This interface shall be called from #NVM_EventHandler.

    @trace  #BRCM_SWREQ_NVM_IL_MSG_HANDLER

    @limitations None
*/
extern int32_t NVM_MsgHandler(NVM_MsgType * const aMsg);

/** @brief Handle NVM server events

    Interface to handle NVM server events. This function retrieves
    messages from message queue, which is processed by #NVM_MsgHandler. On
    completion of message processing, message is marked completed in this
    interface.

    @behavior Sync, Re-entrant (for different aID)

    @pre TBD

    @param[in]      void

    @return     void

    @post TBD

    @note This interface shall be implemented by the integrator and shall be
    called from NVM server task.

    @trace  #BRCM_SWREQ_NVM_IL_EVENT_HANDLER

    @limitations None
*/
extern void NVM_EventHandler(void);

/** @brief Get NVM message Queue

    Interface to fetch NVM message Queue

    @behavior Sync

    @pre TBD

    @param[out]     MsgQ       Pointer NVM message Queue

    @return     void

    @post TBD

    @limitations None
*/
extern void NVM_GetMsgQ(MSGQ_Type *MsgQ);

/** @brief Helper function for Physical to virtual address covertion

    Interface to convert physical to virtual address

    @behavior Sync

    @pre TBD

    @param[in]      aPhysAddr       Physical Address
    @param[in]      aDev            Device Type
    @param[in]      aID             Device controller ID
    @param[out]     aVirtAddr       Virtual Address

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Convertion Completed successfully
    @retval     #BCM_ERR_INVAL_PARAMS   Returned in the following cases:
                            aPhysAddr:  Invalid physical address
                                 aDev:  Device Type not supported
                                  aID:  Invalid controller ID

    @post TBD

    @limitations None
*/
extern int32_t NVM_Phy2VirtAddr(uint32_t aPhysAddr, NVM_DevType aDev,
                                    NVM_DevIDType aID, NVM_AddrType *aVirtAddr);

/** @brief Activate the NVM Server Task

    This interface activates the NVM Server Task.

    @behavior Sync, Non-reentrant

    @pre TBD

    @param          void

    @return     void

    @post TBD

    @note This interface shall be implemented by the integrator.

    @trace  #BRCM_SWREQ_NVM_IL_SERVER_INIT

    @limitations None
*/
extern void NVM_ServerInit(void);

/** @brief Function table for system interface

    Function table for system interface.

    @trace  #BRCM_SWREQ_NVM_IL_SERVER_INIT
*/
extern const SYS_FnTblType NVM_FnTable;

#endif /* NVM_OSIL_H */
/** @} */
