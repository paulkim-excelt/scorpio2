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
    @defgroup grp_ethsrv_time_platform_ifc Ethernet Time Module platform specific Interface
    @ingroup grp_ethsrv_time

    @addtogroup grp_ethsrv_time_platform_ifc
    @{

    @file ettm_platform.h

    @brief Ethernet Time Module Platform specific Interface
    This file contains the platform specific interfaces for the Ethernet Time module

    @version 0.1 Initial version
*/

#ifndef ETTM_PLATFORM_H
#define ETTM_PLATFORM_H

#include <bcm_err.h>
#include <ethernet.h>
#include <module.h>
#include <msg_queue.h>

/**
    @name Ethernet Time Module IDs
    @{
    @brief Architecture API IDs for Ethernet Time module
*/
#define BRCM_SWARCH_ETTM_CONFIG_GLOBAL             (0x9201U)    /**< @brief #ETTM_Config            */
#define BRCM_SWARCH_ETTM_CONTEXT_TYPE              (0x9202U)    /**< @brief #ETTM_ContextType       */
#define BRCM_SWARCH_ETTM_PLATFORMINITNONE_PROC     (0x9203U)    /**< @brief #ETTM_PlatformInitNone  */
#define BRCM_SWARCH_ETTM_PLATFORMSYNCSLAVE_PROC    (0x9205U)    /**< @brief #ETTM_PlatformSyncSlave */
#define BRCM_SWARCH_ETTM_PLATFORMMERGEHB_PROC      (0x9206U)    /**< @brief #ETTM_PlatformMergeHB   */
#define BRCM_SWARCH_ETTM_RPCMSG_TYPE               (0x9207U)    /**< @brief #ETTM_RpcMsgType        */
#define BRCM_SWARCH_ETTM_RPC_MSGQ_COUNT_MACRO      (0x9208U)    /**< @brief #ETTM_RPC_MSGQ_COUNT    */
#define BRCM_SWARCH_ETTM_MAX_PAYLOAD_SIZE_MACRO    (0x9209U)    /**< @brief #ETTM_MAX_PAYLOAD_SIZE  */
/** @} */

/** @brief Ethernet time driver configuration

    @trace #BRCM_SWREQ_ETTM
*/
extern const ETHER_TimeCfgType ETTM_Config;

/**
    @brief Max count of entries in RPC MsgQ

    @trace #BRCM_SWREQ_ETTM
*/
#define ETTM_RPC_MSGQ_COUNT       (4UL)

/**
    @brief Maximum payload size for ETTM commands

    @trace #BRCM_SWREQ_ETTM
*/
#define ETTM_MAX_PAYLOAD_SIZE     (16)

/**
    @brief Command-Response structure for command queue

    @trace #BRCM_SWREQ_ETTM
*/
typedef struct sETTM_RpcMsgType {
    uint8_t        cmdID;                       /**< @brief Switch/Ethernet command identifier */
    BCM_CompIDType compID;                      /**< @brief Component identifier */
    int32_t        ret;                         /**< @brief Return status */
    uint32_t       payloadLen;                  /**< @brief Length of command payload in bytes */
    uint8_t        payload[ETTM_MAX_PAYLOAD_SIZE];  /**< @brief Space for command response payload */
} ETTM_RpcMsgType;

/**
    @brief Structure for EthTime handle

    Context structure will be used to maintain the internal
    variables specific to the ethernet time module

    @trace #BRCM_SWREQ_ETTM
*/
typedef struct sETTM_ContextType {
    MODULE_ContextType     moduleContext;              /**< @brief SYS module context */
    uint32_t               frameSyncDone;              /**< @brief Flag (TRUE/FALSE)
                                                            indicating whether the
                                                            framesync process is complete
                                                            or not */
    const MSGQ_MsgHdrType* pHdrSlave;                  /**< @brief Used to manage Msg sent
                                                            from master to slave */
    uint8_t                hbReadCnt;                  /**< @brief  Number of times heart
                                                            beat read attempted */
    uint8_t                payload[ETTM_MAX_PAYLOAD_SIZE];/**< @brief Payload memory
                                                            TODO : update with RPC_MEM_MSG_PAYLOAD_SZ
                                                            once Hydra migrates to RPC V2 */
    BCM_SubStateType       cmdState;                   /**< @brief Command processing state */
    ETTM_RpcMsgType        rpcCmds[ETTM_RPC_MSGQ_COUNT]; /**< @brief Memory for RPC commands  */
    MSGQ_CtxType           rpcMsgQCtx;                 /**< @brief Memory for MsgQ context  */
} ETTM_ContextType;

/** @brief Platform specific initialization for no framesync case

    @pre None

    This API is invoked as part of the EthTime initialization when
    the no framesync operation is selected. It might be used to
    reset the EthTime block and return the difference with the
    system timer

    @param[out]   aTimeDiff              Time difference in nanoseconds

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETTM
*/
void ETTM_PlatformInitNone(uint64_t *const aTimeDiff);

/** @brief Platform specific master-slave synchronization routine

    @pre None

    This API is invoked to perform the master-slave synchronization on the
    master device. It may be invoked multiple times by the state machine

    @param[inout] aContext             Context structure

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETTM
*/
void ETTM_PlatformSyncSlave(ETTM_ContextType *const aContext);

/** @brief Platform specific heartbeat merge logic

    @pre None

    This API is invoked to merge hearbeats from different
    hardware blocks and get a single resultant heartbeat

    @param[in]   aInResponse1           Input heartbeat message from first block
    @param[in]   aInResponse2           Input heartbeat message from second block
    @param[out]  aOutResponse           Merged output heartbeat message

    @retval      #BCM_ERR_OK            Heartbeats merged successfully
    @retval      #BCM_ERR_INVAL_PARAMS  Invalid input heartbeat values

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETTM
*/
int32_t ETTM_PlatformMergeHB(void const *aInResponse1,
                             void const *aInResponse2,
                             void *aOutResponse);

#endif /* ETTM_PLATFORM_H */

/** @} */
