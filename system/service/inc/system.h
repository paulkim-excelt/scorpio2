/*****************************************************************************
 Copyright 2016-2020 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_system_ifc System interface
    @ingroup grp_sys_service

    @addtogroup grp_system_ifc
    @{

    @file system.h
    @brief System interface

    System interface

    @version 1.0 Changelist1
*/

#ifndef SYSTEM_H
#define SYSTEM_H

#include <inttypes.h>
#include <compiler.h>
#include <bcm_err.h>
#include <svc.h>
#include <msg_queue.h>
#include <bcm_comp.h>
#include <system_state.h>
#include <system_module.h>

/**
    @name System Architecture IDs
    @{
    @brief Architecture IDs
*/
#define BRCM_SWARCH_SYS_CONFIG_ID_MACRO           (0x8101U)    /**< @brief #SYS_CONFIG_ID_ETHSWTM */
#define BRCM_SWARCH_SYS_SEND_PROC                 (0x8102U)    /**< @brief #SYS_SendCmd           */
#define BRCM_SWARCH_SYS_RECV_PROC                 (0x8103U)    /**< @brief #SYS_RecvResp          */
#define BRCM_SWARCH_SYS_SUB_STATE_HANDLER_PROC    (0x8104U)    /**< @brief #SYS_SubStateHandler   */
#define BRCM_SWARCH_SYS_GET_STATE_PROC            (0x8105U)    /**< @brief #SYS_GetState          */
#define BRCM_SWARCH_SYS_NOTIFY_ERROR_PROC         (0x8106U)    /**< @brief #SYS_NotifyError       */
/** @} */

/**
    @name System Config IDs
    @{
    @brief PT Image IDs for system configuration

    @trace #BRCM_SWREQ_SYS_INTERFACE
*/
#define SYS_CONFIG_ID_ETHSWTM       (0xBC10U)  /**< @brief EthSrv Config       */
#define SYS_CONFIG_ID_ETS         (0xBC20U)  /**< @brief ETS Config         */
#define SYS_CONFIG_ID_CFP         (0xBC30U)  /**< @brief CFP Config         */
#define SYS_CONFIG_ID_ETHSWTM_FA    (0xBC50U)  /**< @brief Flow Accelerator   */
#define SYS_CONFIG_ID_PP_CODEC    (0xBC10U)  /**< @brief PP codec Config    */
#define SYS_CONFIG_ID_PP_MP       (0xBC11U)  /**< @brief MP safety Config   */
#define SYS_CONFIG_ID_PP_SP       (0xBC12U)  /**< @brief SP safety Config   */
/** @} */

/** @brief Send command to the subsystem

    Send command to the sub system

    @behavior Sync, Re-entrant

    @pre None

    @param[in]    aReceiverCompID Group ID of recipient
    @param[in]    aReceiverCompID Component ID of recipient
    @param[in]    aCmd            Command to send as #SYS_CmdIDType
    @param[in]    aClientMask     Client Mask
    @param[inout] aHdr            Pointer to store the handle

    Return values are documented in reverse-chronological order
    @retval  #BCM_ERR_OK        Successfully sent
    @retval  #BCM_ERR_INVAL_PARAMS    aHdr is NULL
    @retval  #BCM_ERR_INVAL_PARAMS    aCmd is not valid
    @retval  #BCM_ERR_INVAL_PARAMS    aReceiverGroupID is not valid
    @retval  #BCM_ERR_INVAL_PARAMS    aReceiverCompID is not valid
    @retval  as returned by #SYS_SendCmdType

    @post None

    @trace #BRCM_SWREQ_SYS_INTERFACE

    @limitations Any subsytem can send the command.
*/
int32_t SYS_SendCmd(BCM_GroupIDType aReceiverGroupID,
                    BCM_CompIDType aReceiverCompID,
                    const SYS_CmdIDType aCmd,
                    const uint32_t aClientMask,
                    const MSGQ_MsgHdrType** const aHdr);

/** @brief Receive response from the subsystem

    Receive responce from the sub system

    @behavior Sync, Re-entrant

    @pre None

    @param[in]    aReceiverGroupID Group ID from which this response
                                   needs to be received  from
    @param[in]    aReceiverCompID  Component ID from which this response
                                   needs to be received  from
    @param[in]    aHdr             Pointer to the handle previously returned by #SYS_Send
    @param[inout] aCmd             Pointer to store the command
    @param[inout] aResp            Pointer to store the response

    Return values are documented in reverse-chronological order
    @retval  #BCM_ERR_OK              Successfully sent
    @retval  #BCM_ERR_INVAL_PARAMS    aHdr is NULL
    @retval  #BCM_ERR_INVAL_PARAMS    aCmd is NULL
    @retval  #BCM_ERR_INVAL_PARAMS    aResp is NULL
    @retval  #BCM_ERR_INVAL_PARAMS    aReceiverGroupID is not valid
    @retval  #BCM_ERR_INVAL_PARAMS    aReceiverCompID is not valid
    @retval  as returned by #SYS_RecvRespType

    @post None

    @trace #BRCM_SWREQ_SYS_INTERFACE

    @limitations Any subsytem can receive the response if aHdr is correct
*/
int32_t SYS_RecvResp(BCM_GroupIDType aReceiverGroupID,
                     BCM_CompIDType aReceiverCompID,
                     const MSGQ_MsgHdrType* const aHdr,
                     SYS_CmdIDType *aCmd,
                     int32_t *aResp);

/** @brief Group State Handler

    Transitions standard group modules

    @behavior Sync, Re-entrant

    @pre None

    @param[in]    aReceiverGroupID  Group ID from which this response
                                    needs to be received  from
    @param[inout]   aState          BCM_StateType used and updated
    @param[in]      aRequestedState Requested state
    @param[in]      aClientMask     Client Mask
    @param[inout]   aHdr            Pointer to MSGQ Handle

    @return     void

    @post None

    @trace #BRCM_SWREQ_SYS_INTERFACE

    @limitations None
*/
void SYS_SubStateHandler(BCM_GroupIDType aReceiverGroupID,
                        BCM_StateType *aState,
                        BCM_StateType aRequestedState,
                        const uint32_t aClientMask,
                        const MSGQ_MsgHdrType **aHdr);

/** @brief Get the subsystem state

    Get the state of sub system

    @behavior Sync, Re-entrant

    @pre None

    @param[in]    aGroupID   Group ID of sub system
    @param[in]    aCompID    Component ID of sub system
    @param[inout] aState     Pointer to store the state

    Return values are documented in reverse-chronological order
    @retval #BCM_ERR_OK           Successful
    @retval #BCM_ERR_INVAL_PARAMS aState is NULL
    @retval #BCM_ERR_INVAL_PARAMS aGroupID is not valid
    @retval #BCM_ERR_INVAL_PARAMS aCompID is not valid

    @post None

    @trace #BRCM_SWREQ_SYS_INTERFACE

    @limitations None
*/
int32_t SYS_GetState(BCM_GroupIDType aGroupID,
                     BCM_CompIDType aCompID,
                     BCM_StateType *aState);

/** @brief Notify errors

    Function to be invoked by Subsystems when error occurs.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aSenderGroupID     Group ID of sender
    @param[in]      aSenderCompID      Component ID of sender
    @param[in]      aReceiverGroupID   Group ID of recipient
    @param[in]      aReceiverCompID    Component ID of recipient
    @param[in]      aSysState          State

    Return values are documented in reverse-chronological order
    @retval  as returned by #SYS_NotifyErrorType
    @retval  #BCM_ERR_AUTH_FAILED     Receipent is not the parent
    @retval  #BCM_ERR_INVAL_PARAMS    aSenderGroupID is not valid
    @retval  #BCM_ERR_INVAL_PARAMS    aSenderCompID is not valid
    @retval  #BCM_ERR_INVAL_PARAMS    aReceiverGroupID is not valid
    @retval  #BCM_ERR_INVAL_PARAMS    aReceiverCompID is not valid

    @post None

    @trace  #BRCM_SWREQ_SYS_INTERFACE

    @limitations None
*/
int32_t SYS_NotifyError(BCM_GroupIDType aSenderGroupID,
                        BCM_CompIDType aSenderCompID,
                        BCM_GroupIDType aReceiverGroupID,
                        BCM_CompIDType aReceiverCompID,
                        BCM_StateType aState);
#endif /* SYSTEM_H */

/** @} */
