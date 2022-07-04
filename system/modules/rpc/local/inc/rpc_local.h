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

 2. TO THE COMP_MAXIMUM EXTENT PERMITTED BY LAW, THE SOFTWARE IS PROVIDED "AS IS"
    AND WITH ALL FAULTS AND BROADCOM MAKES NO PROMISES, REPRESENTATIONS OR
    WARRANTIES, EITHER EXPRESS, IMPLIED, STATUTORY, OR OTHERWISE, WITH RESPECT
    TO THE SOFTWARE.  BROADCOM SPECIFICALLY DISCLAIMS ANY AND ALL IMPLIED
    WARRANTIES OF TITLE, MERCHANTABILITY, NONINFRINGEMENT, FITNESS FOR A
    PARTICULAR PURPOSE, LACK OF VIRUSES, ACCURACY OR COMPLETENESS,
    QUIET ENJOYMENT, QUIET POSSESSION OR CORRESPONDENCE TO DESCRIPTION.
    YOU ASSUME THE ENTIRE RISK ARISING OUT OF USE OR PERFORMANCE OF THE
    SOFTWARE.

 3. TO THE COMP_MAXIMUM EXTENT PERMITTED BY LAW, IN NO EVENT SHALL BROADCOM OR ITS
    LICENSORS BE LIABLE FOR (i) CONSEQUENTIAL, INCIDENTAL, SPECIAL, INDIRECT,
    OR EXEMPLARY DAMAGES WHATSOEVER ARISING OUT OF OR IN ANY WAY RELATING TO
    YOUR USE OF OR INABILITY TO USE THE SOFTWARE EVEN IF BROADCOM HAS BEEN
    ADVISED OF THE POSSIBILITY OF SUCH DAMAGES; OR (ii) ANY AMOUNT IN EXCESS
    OF THE AMOUNT ACTUALLY PAID FOR THE SOFTWARE ITSELF OR U.S. $1, WHICHEVER
    IS GREATER. THESE LIMITATIONS SHALL APPLY NOTWITHSTANDING ANY FAILURE OF
    ESSENTIAL PURPOSE OF ANY LIMITED REMEDY.
******************************************************************************/

/**
    @defgroup grp_rpc_v2_local_ifc Local Interface Special APIs
    @ingroup grp_rpc_v2_local

    @addtogroup grp_rpc_v2_local_ifc
    @{

    @file rpc_local.h
    @brief RPC Master and RPC Slave interface

    @version 0.1 Initial Version
*/

#ifndef RPC_LOCAL_H
#define RPC_LOCAL_H

#include <stdint.h>
#include <rpc_interface.h>
#include <module.h>

/**
    @name RPC Master and Slave Architecture IDs
    @{
    @brief Architecture IDs for RPC Master and Slave
*/
#define BRCM_SWARCH_RPC_PROCESSSPECIALCMD_TYPE      (0x8403U)  /**< @brief #RPC_ProcessSpecialCmdType */
#define BRCM_SWARCH_RPC_SPECIALCMDINFO_TYPE         (0x8404U)  /**< @brief #RPC_SpecialCmdInfoType    */
#define BRCM_SWARCH_RPC_SENDTOSLAVE_PROC            (0x8405U)  /**< @brief #RPC_SendToSlave           */
#define BRCM_SWARCH_RPC_RECVFROMSLAVE_PROC          (0x8406U)  /**< @brief #RPC_RecvFromSlave         */
/** @} */

/** @brief Function to process the special command

    Special commands are those that involve multiple command
    exchange between host and target per user input.
    Modules supporting special commands shall implement this
    API, which will be invoked when the client receieves
    a command which matches the module's 'cmd' value
    specified in #RPC_SpecialCmdInfoType.

    @behavior Sync, Non-Reentrant

    @param[inout]   aSubState           State of command processing to
                                        be used/updated by module until
                                        command processing completion
    @param[inout]   aCmdMsg             Command message for processing.
                                        Response to client is filled
                                        into same buffer after command
                                        processing completion
    @param[in]      aRespMsg            Response got from RPC slave
                                        which needs to be processed.
                                        NULL in case of a new command that
                                        is received from client that needs
                                        to be processed
    @param[out]     aSlaveMsgInfo       App info got from RPC slave for a
                                        forwarded command. Caller will use
                                        it to match the response with the
                                        command source

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Command completed successfully
    @retval     #BCM_ERR_BUSY           Command is still being processed
    @retval     #BCM_ERR_UNKNOWN        Unknown error

    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL

    @limitations None
*/
typedef int32_t (*RPC_ProcessSpecialCmdType)(BCM_SubStateType *aSubState,
                                             RPC_MemMsgType *aCmdMsg,
                                             RPC_MemMsgType *aRespMsg,
                                             uint32_t *aSlaveMsgInfo);

/**
    @brief Function pointer table for each special command
    that is supported on the platform

    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL
 */
typedef struct sRPC_SpecialCmdInfoType {
    BCM_CmdType                cmd;         /**< @brief Command ID */
    RPC_ProcessSpecialCmdType  processCmd;  /**< @brief Process the command */
} RPC_SpecialCmdInfoType;

/** @brief Send the Message to Slave Interface

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aHdl          Message Handle
    @param[out]     aClonedHdl    Message handle cloned by the module

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK          Success
    @retval     #BCM_ERR_UNKNOWN     Fail to Send

    @post None

    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL

    @limitations None
*/
extern int32_t RPC_SendToSlave(RPC_HdlType aHdl, uint32_t *aClonedHdl);

/** @brief Receive the Response from Slave Interface

    @behavior Sync, Non-reentrant

    @pre None

    @param[out]     aSlvHdl      Slave Message Handle
    @param[out]     aMasterHdl   Master Message Handle

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK          Success
    @retval     #BCM_ERR_NOT_FOUND   No Receive Response Message Found

    @post None

    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL

    @limitations Support Only when slave present
*/
extern int32_t RPC_RecvFromSlave(RPC_HdlType *aSlvHdl, RPC_HdlType *aMasterHdl);
#endif /* RPC_LOCAL_H */
/** @} */
