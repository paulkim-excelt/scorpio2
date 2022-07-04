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
    @defgroup grp_rpc_v2_msg_osil_impl RPC Local Integration Rererence
    @ingroup grp_rpc_v2_local

    @addtogroup grp_rpc_v2_msg_osil_impl
    @{

    @file rpc_local_osil.c
    @brief This file implements RPC Message OSIL functionality

    @version 0.1 Initial version
*/
#include <stddef.h>
#include <module.h>
#include <rpc_local_osil.h>
#ifndef ENABLE_HOST_BUILD
#include <ee.h>
#include <base_kernel_services.h>
#else
#include <rpc_hostcmd.h>
#endif
#include <msg_queue.h>
#include <bcm_utils.h>
#include <bcm_err.h>
#ifdef ENABLE_RPC_MSGQ_TEST
#include <rpc_local_test.h>
#else
#ifdef ENABLE_ETHSRV_RPC
#include <ethernet_service.h>
#endif
#include <system_osil.h>
#include <system_module_v2.h>
#ifdef RPC_MSGQ_MASTER_IFC_NVM
#include <nvm_ipc.h>
#include <nvm_service.h>
#endif
#endif

#ifdef ENABLE_CRYPTO_SERVICE
#include <crypto_service.h>
#endif

/**
    @name RPC MessageQ OSIL Design IDs
    @{
    @brief Design IDs for RPC MessageQ OSIL
*/
#define BRCM_SWDSGN_RPC_MASTERIFCOBJECTS_GLOBAL       (0xE101U) /**< @brief #RPC_MasterIfcObjects    */
#define BRCM_SWDSGN_RPC_LOADERQV2_GLOBAL              (0xE102U) /**< @brief #RPC_LoaderQV2           */
#define BRCM_SWDSGN_RPC_GETLOADERMSGQ_GLOBAL          (0xE103U) /**< @brief #RPC_GetLoaderMsgQ       */
#define BRCM_SWDSGN_RPC_ASYNCQV2_GLOBAL               (0xE104U) /**< @brief #RPC_AsyncQV2            */
#define BRCM_SWDSGN_RPC_GETASYNCMSGQ_GLOBAL           (0xE105U) /**< @brief #RPC_GetAsyncMsgQ        */
#define BRCM_SWDSGN_RPC_SLAVECMDQ_GLOBAL              (0xE106U) /**< @brief #RPC_SlaveCmdQ           */
#define BRCM_SWDSGN_RPC_MSGQGETCMDQ_GLOBAL            (0xE107U) /**< @brief #RPC_MsgQGetCmdQ         */
#define BRCM_SWDSGN_RPC_MSGQMASTEREVENT_GLOBAL        (0xE108U) /**< @brief #RPC_MasterEvent         */
#define BRCM_SWDSGN_RPC_SLAVEEVENT_GLOBAL             (0xE109U) /**< @brief #RPC_SlaveEvent          */
#define BRCM_SWDSGN_RPC_TIMER_ALARM_CB_PROC           (0xE10AU) /**< @brief #RPC_TimerAlarmCb        */
#define BRCM_SWDSGN_RPC_STREAMTIMEOUTMS_GLOBAL        (0xE10BU) /**< @brief #RPC_StreamTimeoutMs     */
/** @} */

/**
    @brief RPC Master Message Event

    @trace #BRCM_SWARCH_RPC_MASTERIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL
*/
const uint32_t RPC_MasterEvent = RPC_MSGQ_MASTER_EVENT;

/**
    @brief RPC Slave Event

    @trace #BRCM_SWARCH_RPC_SLAVEEVENT_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL
*/
const uint32_t RPC_SlaveEvent = RPC_SLAVE_EVENT;

#ifdef ENABLE_RPC_MASTER_STREAM_SUPPORT
/**
    @brief RPC Stream timeout value in milliseconds

    @trace #BRCM_SWARCH_RPC_STREAMTIMEOUTMS_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL
*/
const uint32_t RPC_StreamTimeoutMs = RPC_STREAM_TIMEOUT_MS;

/**
    @brief Loader Command Message Queue

    The message queue for the loader commands

    @trace #BRCM_SWARCH_RPC_MASTERIMGHANDLER_GLOBAL
    @trace #BRCM_SWARCH_RPC_MASTERIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL
*/
MSGQ_DEFINE_V3(RPC_LoaderQV2, RPC_MASTER_LOAD_MSG_MAX, (int32_t)RPC_TASK,
               RPC_MSGQ_MASTER_LOADER_EVENT, MSGQ_CLIENT_SIGNAL_ENABLE,
               RPC_MasterLoadReqType, RPC_MsgQMasterLoaderHdrQ,
               RPC_MasterLoaderGetMsg, ".bss.rpc");

/**
    @brief Get Loader Queue

    @trace #BRCM_SWARCH_RPC_GETLOADERMSGQ_PROC
    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL
*/
const MSGQ_Type* RPC_GetLoaderMsgQ (void)
{
    return &RPC_LoaderQV2;
}
#endif

#ifdef RPC_SLAVE_ENABLE_LOCALCMD_SUPPORT
/**
    @brief Local Command Q for MessageQ Slave

    The message queue for the Local commands

    @trace #BRCM_SWARCH_RPC_SLAVEIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL
*/
MSGQ_DEFINE_V3(RPC_SlaveCmdQ, RPC_SLAVE_LOCAL_MSG_MAX, (int32_t)RPC_TASK,
               RPC_SLAVE_EVENT, MSGQ_CLIENT_SIGNAL_ENABLE,
               RPC_LocalMsgType, RPC_SlaveCmdHdrQ,
               RPC_MsgQGetCmd, ".bss.rpc");

/**
    @brief Get Local Command Queue

    @trace #BRCM_SWARCH_RPC_SLAVEIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL
*/
const MSGQ_Type* RPC_MsgQGetCmdQ(void)
{
    return &RPC_SlaveCmdQ;
}
#endif

#ifdef RPC_MASTER_ENABLE_IFC_SUPPORT
/**
    @brief Async Message from local subsytem to Host

    The message queue for Async messages to be sent to Host

    @trace #BRCM_SWARCH_RPC_MASTERIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL
*/
MSGQ_DEFINE_V3(RPC_AsyncQV2, RPC_MASTER_ASYNC_MSG_MAX, (int32_t)RPC_TASK,
               RPC_ASYNC_EVENT, MSGQ_CLIENT_SIGNAL_DISABLE,
               RPC_LocalMsgType, RPC_MsgQMasterAsyncHdrQ,
               RPC_MasterAsyncGetMsg, ".bss.rpc");

/**
    @brief Get Async Message Queue

    @trace #BRCM_SWARCH_RPC_MASTERIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL
*/
const MSGQ_Type* RPC_GetAsyncMsgQ (void)
{
    return &RPC_AsyncQV2;
}
#endif

/**
    @brief RPC Master Message Queue Modules

    @trace #BRCM_SWARCH_RPC_MASTERIFCOBJECTS_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL
*/
const SERVICE_Type * const RPC_MasterIfcObjects[] = {
#ifdef RPC_MSGQ_MASTER_IFC_SYS
    &RPC_MSGQ_MASTER_IFC_SYS,
#else
    NULL,
#endif
#ifdef RPC_MSGQ_MASTER_IFC_ETHSRV
    &RPC_MSGQ_MASTER_IFC_ETHSRV,
#else
    NULL,
#endif
#ifdef RPC_MSGQ_MASTER_IFC_NVM
    &RPC_MSGQ_MASTER_IFC_NVM,
#else
    NULL,
#endif
#ifdef RPC_MSGQ_MASTER_IFC_CRYPTO
    &RPC_MSGQ_MASTER_IFC_CRYPTO,
#else
    NULL,
#endif
#ifdef RPC_MSGQ_MASTER_IFC_HOST
    &RPC_MSGQ_MASTER_IFC_HOST,
#else
    NULL,
#endif
#ifdef RPC_TEST_IFC
    &RPC_TEST_IFC,
#else
    NULL,
#endif
    NULL,
    NULL,
};

/**
    @trace #BRCM_SWARCH_RPC_TIMER_ALARM_CB_PROC
    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL

    @code{.c}
    BASE_SetEvent(RPC_TASK, RPC_MSGQ_MASTER_EVENT)
    @endcode
*/
void RPC_TimerAlarmCb(void)
{
#ifndef ENABLE_HOST_BUILD
    BASE_SetEvent(RPC_TASK, RPC_MSGQ_MASTER_EVENT);
#endif
}
/** @} */
