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
    @defgroup grp_ethsrv_swtarl_osil_ifc ARL Module OSIL Interface
    @ingroup grp_ethsrv_swt

    @addtogroup grp_ethsrv_swtarl_osil_ifc
    @{

    @file ethswtm_arl_osil.h

    @brief ARL module OSIL Interface

    @version 0.1 Initial version
*/

#ifndef ETHSWTM_ARL_OSIL_H
#define ETHSWTM_ARL_OSIL_H

#include <msg_queue.h>
#include <module_osil.h>
/**
    @name ARL Module IDs for OSIL
    @{
    @brief Architecture API IDs for ARL module OSIL
*/
#define BRCM_SWARCH_ETHSWTM_ARLEVENT_TYPE          (0x9201U)    /**< @brief #ETHSWTM_ARLEventType */
#define BRCM_SWARCH_ETHSWTM_ARLEVENTINFO_GLOBAL    (0x9202U)    /**< @brief #ETHSWTM_ARLEventInfo */
#define BRCM_SWARCH_ETHSWTM_ARLSENDCMD_PROC        (0x9203U)    /**< @brief #ETHSWTM_ARLSendCmd   */
#define BRCM_SWARCH_ETHSWTM_ARLCMDSTATUS_PROC      (0x9204U)    /**< @brief #ETHSWTM_ARLCmdStatus */
#define BRCM_SWARCH_ETHSWTM_ARLGETSERVER_PROC      (0x9205U)    /**< @brief #ETHSWTM_ARLGetServer */
/** @} */

/**
    @name ARL module event structure

    @trace #BRCM_SWREQ_ETHSWTM_ARL
*/
typedef struct sETHSWTM_ARLEventType {
    uint32_t refreshEvent;     /**< @brief Event for refreshing ARL entries */
} ETHSWTM_ARLEventType;

/**
    @brief Event structure object of ARL module

    @trace #BRCM_SWREQ_ETHSWTM_ARL
*/
extern const ETHSWTM_ARLEventType ETHSWTM_ARLEventInfo;

/** @brief Send Command

    This API sends a command through RPC

    @param[in]  aCmdID      Command identifier
    @param[in]  aParams     Parameters(as a buffer) associated with the command
    @param[out] aHdr        Message handle (Pointer to message header).

    @retval     #BCM_ERR_NOSUPPORT   No support for RPC messaging
    @retval     others               As returned by #RPC_CmdQSendCmd

    @trace #BRCM_SWREQ_ETHSWTM_ARL
*/
int32_t ETHSWTM_ARLSendCmd(uint8_t aCmdID,
                           const uint8_t *const aParams,
                           const MSGQ_MsgHdrType** const aHdr);

/** @brief Command status

    This API retrieves the status of previously posted command

    @param[in]      aHdr        Handle of the Message
    @param[out]     aResponse   Response return code for the command. This field is valid
                                only if this API returns #BCM_ERR_OK.
    @param[out]     aParams     Response data for the command. This is valid
                                only if this API returns #BCM_ERR_OK.
    @param[inout]   aSize       Size of the response loaded. This field is valid
                                only if this API returns #BCM_ERR_OK.

    @retval     #BCM_ERR_NOSUPPORT   No support for RPC messaging
    @retval     others               As returned by #RPC_CmdQGetCmdStatus

    @trace #BRCM_SWREQ_ETHSWTM_ARL
*/
int32_t ETHSWTM_ARLCmdStatus(const MSGQ_MsgHdrType *const aHdr, int32_t * const aResponse,
                             uint8_t *const aParams, uint32_t * const aSize);

/** @brief API to return the Task and event for the switch module

    @behavior Sync, Re-entrant

    @pre None

    @param[out]     aServerTask         Server task ID
    @param[out]     aServerEvent        Event mask

    Return values are documented in reverse-chronological order
    @retval       void

    @limitations None.

    @trace #BRCM_SWREQ_ETHSWTM_ARL
*/
extern void ETHSWTM_ARLGetServer(int32_t *aServerTask, uint32_t *aServerEvent);

#endif /* ETHSWTM_ARL_OSIL_H */
/** @} */
