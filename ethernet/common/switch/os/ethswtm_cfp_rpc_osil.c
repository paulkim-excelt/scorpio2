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
    @defgroup grp_ethsrv_swtcfp_rpc_osil_impl CFP Module rpc async OSIL Implementation
    @ingroup grp_ethsrv_swt

    @addtogroup grp_ethsrv_swtcfp_rpc_osil_impl
    @{

    @file ethswtm_cfp_rpc_osil.c

    @brief CFP module rpc async OSIL Implementation

    @version 0.1 Initial version
*/

#include <ee.h>
#include <bcm_osil.h>
#include <ethswtm_cfp_osil.h>
#include <rpc_local_osil.h>

/**
    @name CFP Module Design IDs for rpc async OSIL implementation
    @{
    @brief Design IDs for CFP module rpc async OSIL implementation
*/
#define BRCM_SWDSGN_ETHSWTM_CFPASYNCEVENT_PROC              (0xB104U)    /**< @brief #ETHSWTM_CFPAsyncEvent */
#define BRCM_SWDSGN_ETHSWTM_CFPGETSERVER_PROC               (0xB105U)    /**< @brief #ETHSWTM_CFPGetServer  */
/** @} */

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

    @trace #BRCM_SWARCH_ETHSWTM_CFPASYNCEVENT_PROC
    @trace #BRCM_SWREQ_ETHSWTM_CFP
*/
int32_t ETHSWTM_CFPAsyncEvent(uint8_t aCmdID, const uint8_t *const aParams,
                              uint32_t aSize)
{
    int32_t retVal;
#ifdef ENABLE_RPC
    retVal = RPC_AsyncEventToHost(BCM_GROUPID_ETHSRV, BCM_CFP_ID,
                                  aCmdID, aParams, aSize);
#else
    retVal = BCM_ERR_NOSUPPORT;
#endif
    return retVal;
}

/**
    @code{.unparsed}
    @endcode

    @trace #BRCM_SWARCH_ETHSWTM_CFPGETSERVER_PROC
    @trace #BRCM_SWREQ_ETHSWTM_CFP
*/
void ETHSWTM_CFPGetServer(int32_t *aServerTask, uint32_t *aServerEvent)
{
    if (NULL != aServerTask) {
        *aServerTask = ETHERNET_Task;
    }
    if (NULL != aServerEvent) {
        *aServerEvent = MODULE_Event;
    }
}

/** @} */
