/*****************************************************************************
 Copyright 2020 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_system_module System modules
    @ingroup grp_sys_service

    @addtogroup grp_system_module
    @{

    @file system_module.h
    @brief APIs for interaction to sub systems.

    APIs for interaction to sub systems.

    @version 0.1 Initial version
*/

#ifndef SYSTEM_MODULE_H
#define SYSTEM_MODULE_H

#include <inttypes.h>
#include <compiler.h>
#include <bcm_err.h>
#include <svc.h>
#include <msg_queue.h>
#include <bcm_comp.h>
#include <system_state.h>
#include <module.h>

/**
    @name System Architecture IDs
    @{
    @brief Architecture IDs
*/
#define BRCM_SWARCH_SYS_FNTABLE_MAX_MACRO    (0x8301U)    /**< @brief #SYS_FNTABLE_MAX     */
#define BRCM_SWARCH_SYS_CMD_ID_TYPE          (0x8302U)    /**< @brief #SYS_CmdIDType       */
#define BRCM_SWARCH_SYS_CMD_TYPE             (0x8303U)    /**< @brief #SYS_CmdType         */
#define BRCM_SWARCH_SYS_SENDCMD_TYPE         (0x8304U)    /**< @brief #SYS_SendCmdType     */
#define BRCM_SWARCH_SYS_RECVRESP_TYPE        (0x8305U)    /**< @brief #SYS_RecvRespType    */
#define BRCM_SWARCH_SYS_GETSTATE_TYPE        (0x8306U)    /**< @brief #SYS_GetStateType    */
#define BRCM_SWARCH_SYS_NOTIFY_ERROR_TYPE    (0x8307U)    /**< @brief #SYS_NotifyErrorType */
#define BRCM_SWARCH_SYS_FNTBL_TYPE           (0x8308U)    /**< @brief #SYS_FnTblType       */
#define BRCM_SWARCH_SYS_FN_TABLES_GLOBAL     (0x8309U)    /**< @brief #SYS_FnTables        */
/** @} */

/**
    @brief Maximum subsystems macro

    Maximum number of sub systems supported.

    @trace #BRCM_SWREQ_SYS_INTERFACE
*/
#define SYS_FNTABLE_MAX  (15UL)

/**
    @name Sub system command
    @{
    @brief Sub system command

    @trace #BRCM_SWREQ_SYS_INTERFACE
*/
typedef uint32_t SYS_CmdIDType;
#define SYS_CMD_ID_INIT    (0UL)   /**< @brief Command to Initialize sub system */
#define SYS_CMD_ID_CONFIG  (1UL)   /**< @brief Command to Configure sub system */
#define SYS_CMD_ID_START   (2UL)   /**< @brief Command to start sub system */
#define SYS_CMD_ID_STOP    (3UL)   /**< @brief Command to stop sub system */
#define SYS_CMD_ID_DEINIT  (4UL)   /**< @brief Command to Deinitialize sub system */
#define SYS_CMD_ID_MAX     (5UL)   /**< @brief Maximum value */
/** @} */


/**
    @brief Command structure

    @trace #BRCM_SWREQ_SYS_INTERFACE
 */
typedef struct sSYS_CmdType{
    BCM_GroupIDType groupID;    /**< @brief Sub system group ID         */
    BCM_CompIDType compID;      /**< @brief Component ID                */
    SYS_CmdIDType cmd;          /**< @brief Command to the component    */
    int32_t response;           /**< @brief Response from component upon
                                    completion of command processing    */
} SYS_CmdType;

/** @brief Post a command to the command queue of the sub system

    Post a command to the command queue of the sub system

    @behavior Async, Non-reentrant

    @pre None

    @param[in]   aCmd        Pointer to Cmd structure
    @param[in]   aClientMask Mask to signal client task
    @param[out]  aHdr        Handle to get response, valid only when return value
                                is #BCM_ERR_OK

    Return values are documented in reverse-chronological order
    @retval   #BCM_ERR_INVAL_PARAMS    aCmd is NULL
    @retval   #BCM_ERR_INVAL_PARAMS    aCmd has invalid magic
    @retval   #BCM_ERR_INVAL_PARAMS    aMask is zero
    @retval   #BCM_ERR_INVAL_PARAMS    aHdr is NULL
    @retval   #BCM_ERR_INVAL_PARAMS    aCmd data is invalid
    @retval      as returned by MSGQ_SendMsg in MessageQueue design document

    @post None

    @trace #BRCM_SWREQ_SYS_INTERFACE

    @limitations None
*/
typedef int32_t (*SYS_SendCmdType)(const SYS_CmdType *const aCmd,
                                    const uint32_t aClientMask,
                                    const MSGQ_MsgHdrType** const aHdr);

/** @brief Receive response for the command posted previously

    Receive response to the command posted previously to the command queue of
    the sub system

    @behavior Sync, Re-entrant

    @pre None

    @param[in]   aHdr    Handle returned by SendCmd API
    @param[out]  aCmd    Response from the sub system for posted command
                        (command corresponding to handle in hdr)

    Return values are documented in reverse-chronological order
    @retval  #BCM_ERR_OK        Previously posted command is completed
                                by the sub system and a response is
                                copied to aCmd
    @retval  #BCM_ERR_INVAL_PARAMS    aHdr is NULL
    @retval  #BCM_ERR_INVAL_PARAMS    aHdr has invalid magic ID
    @retval  #BCM_ERR_INVAL_PARAMS    aCmd is NULL
    @retval  as returned by MSGQ_RecvMsg in MessageQueue design document

    @post None

    @trace #BRCM_SWREQ_SYS_INTERFACE

    @limitations None
*/
typedef int32_t  (*SYS_RecvRespType)(const MSGQ_MsgHdrType* const aHdr,
                                        SYS_CmdType* const aCmd);

/** @brief Get the sub system state

    Get the sub system state

    @behavior Sync, Re-entrant

    @pre None

    @param None

    @return State as in #BCM_StateType

    @post None

    @trace #BRCM_SWREQ_SYS_INTERFACE

    @limitations None
*/
typedef BCM_StateType (*SYS_GetStateType)(void);

/** @brief Get notified of the state

    Get notified of the state of components

    @behavior Sync, Re-entrant

    @pre None

    @param[in] aSenderGroupID Sender group ID
    @param[in] aSenderCompID  Sender component ID
    @param[in] aError         Error

    Return values are documented in reverse-chronological order
    @retval #BCM_ERR_OK      Successful
    @retval #BCM_ERR_UNKNOWN Error

    @post None

    @trace #BRCM_SWREQ_SYS_INTERFACE

    @limitations None
*/
typedef int32_t (*SYS_NotifyErrorType)(BCM_GroupIDType aSenderGroupID,
                                       BCM_CompIDType aSenderCompID,
                                       int32_t aError);

/**
    @brief Function pointer table for each sub system

    Each sub system shall expose a function which returns below
    function table for system to interact with.

    @trace #BRCM_SWREQ_SYS_INTERFACE
 */
typedef struct sSYS_FnTblType {
    BCM_GroupIDType groupID;         /**< @brief Group ID                    */
    BCM_CompIDType compID;           /**< @brief Component ID                */
    BCM_GroupIDType parentGroupID;   /**< @brief Parent Group ID             */
    BCM_CompIDType parentCompID;     /**< @brief Parent Component ID         */
    SYS_SendCmdType sendCmd;         /**< @brief Send a command              */
    SYS_RecvRespType recvResp;       /**< @brief Receive a response          */
    SYS_GetStateType getState;       /**< @brief Get the current state       */
    SYS_NotifyErrorType notifyError; /**< @brief Notify error                */
} SYS_FnTblType;

/**
    @brief Global table of sub systems

    Function pointer tables for sub systems

    @trace #BRCM_SWREQ_SYS_INTERFACE
*/
extern const SYS_FnTblType* const SYS_FnTables[SYS_FNTABLE_MAX];

#endif /* SYSTEM_MODULE_H */

/** @} */
