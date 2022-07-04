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
    @defgroup grp_ethsrv_swtext_osil_impl Ext Module OSIL Implementation
    @ingroup grp_ethsrv_swt

    @addtogroup grp_ethsrv_swtext_osil_impl
    @{

    @file ethswtm_ext_osil.c

    @brief Ext module OSIL Implementation

    @version 0.1 Initial version
*/

#include <ee.h>
#include <bcm_osil.h>
#include <ethswtm_ext_osil.h>
#ifdef ENABLE_RPC
#include <rpc_async.h>
#endif
#include <rpc_local_osil.h>

/**
    @name Ext Module Design IDs for OSIL implementation
    @{
    @brief Design IDs for Ext module OSIL implementation
*/
#define BRCM_SWDSGN_ETHSWTM_EXTEVENTINFO_GLOBAL    (0xBD01U)    /**< @brief #ETHSWTM_ExtEventInfo  */
#define BRCM_SWDSGN_ETHSWTM_EXTASYNCEVENT_PROC     (0xBD02U)    /**< @brief #ETHSWTM_ExtAsyncEvent */
#define BRCM_SWDSGN_ETHSWTM_EXTGETSERVER_PROC      (0xBD03U)    /**< @brief #ETHSWTM_ExtGetServer  */
/** @} */

/**
    @brief Event information

    Event configuration for integration

    @trace #BRCM_SWARCH_ETHSWTM_EXTEVENTINFO_GLOBAL
    @trace #BRCM_SWREQ_ETHSWTM_EXT
*/
const ETHSWTM_ExtEventType ETHSWTM_ExtEventInfo = {
    .portLinkEvent = ETHERSWT_PORT_LINK_EVENT,
};

/**
    @code{.unparsed}
#ifdef ENABLE_RPC
    retVal = RPC_AsyncEventToHost(BCM_GROUPID_ETHSRV, BCM_SWT_ID,
                                  aCmdID, aParams, aSize)
#else
    retVal = BCM_ERR_NOSUPPORT
#endif
    return retVal
    @endcode

    @trace #BRCM_SWARCH_ETHSWTM_EXTASYNCEVENT_PROC
    @trace #BRCM_SWREQ_ETHSWTM_EXT
*/
int32_t ETHSWTM_ExtAsyncEvent(uint8_t aCmdID, const uint8_t *const aParams,
                              uint32_t aSize)
{
    int32_t retVal;

#if defined(ENABLE_RPC)
    retVal = RPC_AsyncEventToHost(BCM_GROUPID_ETHSRV, BCM_SWT_ID,
                                  aCmdID, aParams, aSize);
#else
    retVal = BCM_ERR_NOSUPPORT;
#endif
    return retVal;
}

/**
    @code{.unparsed}
    @endcode

    @trace #BRCM_SWARCH_ETHSWTM_EXTGETSERVER_PROC
    @trace #BRCM_SWREQ_ETHSWTM_EXT
*/
void ETHSWTM_ExtGetServer(int32_t *aServerTask, uint32_t *aServerEvent)
{
    if (NULL != aServerTask) {
        *aServerTask = ETHERNET_Task;
    }
    if (NULL != aServerEvent) {
        *aServerEvent = MODULE_Event;
    }
}

/** @} */
