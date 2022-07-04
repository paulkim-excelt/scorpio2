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
    AND WITH ALL ARLULTS AND BROADCOM MAKES NO PROMISES, REPRESENTATIONS OR
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
    IS GREATER. THESE LIMITATIONS SHALL APPLY NOTWITHSTANDING ANY ARLILURE OF
    ESSENTIAL PURPOSE OF ANY LIMITED REMEDY.
******************************************************************************/
/**
    @defgroup grp_ethsrv_swtarl_osil_impl ARL Module OSIL Implementation
    @ingroup grp_ethsrv_swt

    @addtogroup grp_ethsrv_swtarl_osil_impl
    @{

    @file ethswtm_arl_osil.c

    @brief ARL module OSIL Implementation

    @version 0.1 Initial version
*/

#include <ee.h>
#include <bcm_osil.h>
#include <ethswtm_arl.h>
#include <ethswtm_arl_osil.h>
#ifdef ENABLE_RPC
#include <rpc_cmd_queue.h>
#endif
#ifdef ENABLE_RPC_V2
#include <rpc_local_osil.h>
#endif
#include <ethernet_swt_arl.h>

/**
    @name ARL Module Design IDs for OSIL implementation
    @{
    @brief Design IDs for ARL module OSIL implementation
*/
#define BRCM_SWDSGN_ETHSWTM_ARLEVENTINFO_GLOBAL    (0xB201U)    /**< @brief #ETHSWTM_ARLEventInfo */
#define BRCM_SWDSGN_ETHSWTM_ARLSENDCMD_PROC        (0xB202U)    /**< @brief #ETHSWTM_ARLSendCmd   */
#define BRCM_SWDSGN_ETHSWTM_ARLCMDSTATUS_PROC      (0xB203U)    /**< @brief #ETHSWTM_ARLCmdStatus */
#define BRCM_SWDSGN_ETHSWTM_ARLGETSERVER_PROC      (0xB204U)    /**< @brief #ETHSWTM_ARLGetServer */
/** @} */

/**
    @brief Event information

    Event configuration for integration

    @trace #BRCM_SWARCH_ETHSWTM_ARLEVENTINFO_GLOBAL
    @trace #BRCM_SWREQ_ETHSWTM_ARL
*/
const ETHSWTM_ARLEventType ETHSWTM_ARLEventInfo = {
    .refreshEvent = ETHSWTM_ARL_REFRESH_EVENT,
};

/**
    @code{.unparsed}
#ifdef ENABLE_RPC
    retVal = RPC_CmdQSendCmd(BCM_GROUPID_ETHSRV, BCM_SWT_ID, aCmdID, aParams,
                             sizeof(ETHSWTM_ARLListType),
                             ETHSWTM_ARLEventInfo.refreshEvent, aHdr)
#else
    retVal = BCM_ERR_NOSUPPORT
#endif
    return retVal
    @endcode

    @trace #BRCM_SWARCH_ETHSWTM_ARLSENDCMD_PROC
    @trace #BRCM_SWREQ_ETHSWTM_ARL
*/
int32_t ETHSWTM_ARLSendCmd(uint8_t aCmdID,
                           const uint8_t *const aParams,
                           const MSGQ_MsgHdrType** const aHdr)
{
    int32_t retVal;
#if defined (ENABLE_RPC_V2)
    retVal = RPC_SlaveSendLocalCmd(BCM_GROUPID_ETHSRV, BCM_SWT_ID, aCmdID, aParams,
                             sizeof(ETHSWT_ARLListType), 0UL,
                             ETHSWTM_ARLEventInfo.refreshEvent, aHdr);
#else
    retVal = BCM_ERR_NOSUPPORT;
#endif
    return retVal;
}

/**
    @code{.unparsed}
#ifdef ENABLE_RPC
    retVal = RPC_CmdQGetCmdStatus(aHdr, aResponse, aParams, aSize);
#else
    retVal = BCM_ERR_NOSUPPORT
#endif
    return retVal
    @endcode

    @trace #BRCM_SWARCH_ETHSWTM_ARLCMDSTATUS_PROC
    @trace #BRCM_SWREQ_ETHSWTM_ARL
*/
int32_t ETHSWTM_ARLCmdStatus(const MSGQ_MsgHdrType *const aHdr, int32_t * const aResponse,
                             uint8_t *const aParams, uint32_t * const aSize)
{
    int32_t retVal;
#if defined (ENABLE_RPC_V2)
    retVal = RPC_SlaveGetLocalResp(aHdr, aResponse, aParams, aSize);
#else
    retVal = BCM_ERR_NOSUPPORT;
#endif
    return retVal;
}

/**
    @code{.unparsed}
    @endcode

    @trace #BRCM_SWARCH_ETHSWTM_ARLGETSERVER_PROC
    @trace #BRCM_SWREQ_ETHSWTM_ARL
*/
void ETHSWTM_ARLGetServer(int32_t *aServerTask, uint32_t *aServerEvent)
{
    if (NULL != aServerTask) {
        *aServerTask = ETHERNET_Task;
    }
    if (NULL != aServerEvent) {
        *aServerEvent = MODULE_Event;
    }
}

/** @} */
