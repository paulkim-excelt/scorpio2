/*****************************************************************************
 Copyright 2020-2021 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_rpc_v2_mod_ifc Interface
    @ingroup grp_rpc_v2_mod

    @addtogroup grp_rpc_v2_mod_ifc
    @{
    RPC Module adheres to Module Architecture described at @ref grp_module.
    It follows the state machine as expected by Module Architecture. Any porting
    efforts must ensure that all state handlers and event handlers of RPC Module
    are executing in a single thread context.

    Reset State Handler iterates through the enabled interfaces as listed in
    #RPC_InterfaceType and initializes them. Once all interfaces are initialized,
    RPC Module transitions to Init State. Event Handler may be invoked after this
    stage.

    Ready and Run State Handlers respect the DeInit request and deinitialize the
    underlying interfaces #RPC_InterfaceType. Event Handler must not be invoked
    after this stage.

    Other State Handlers do not perform any operation and simply let the state
    transition to flow through.

    Upon any event, RPC Module statically prioritizes sending responses and Notifications
    to the Host. It iterates through #RPC_InterfaceType from tail to head and
    -# If Interface is Master
        -# Receive message and Queue it to corresponding Slave Interface Queue
        (Queue maintained in RPC module, per interface)
        -# Detect any new stream requests
        .
    -# If Interface is Slave
        -# Remove messages from Queue and Send them to Host. Slave Interface is
            responsible to free the Memory Handle upon successful Send
        .

    RPC Module then iterates through #RPC_InterfaceType from head to tail for
    receiving new commands
    -# If Interface is Slave
        -# Receive message and Queue it to corresponding Master Interface Queue
            (Queue maintained in RPC module, per interface). Slave Interface is
            responsible for allocation of memory from RPC Memory.
        -# Process streams related to this interface
        .
    -# If Interface is Master
        -# Remove messages from Queue and Send it to Master Interface (to send to
            Local Service providers or Slave devices for processing)
        -# Process any new stream requests
        .

    @limitations To avoid memory shortage issues, Master interfaces are expected
    give the response on the same memory handle where they received the command.


    @file rpc_module_v2.h
    @brief RPC Integration Interfaces

    @version 0.1 Initial Version
*/

#ifndef RPC_MODULE_V2_H
#define RPC_MODULE_V2_H

#include <bcm_err.h>
#include <module.h>

/**
    @name RPC interface Architecture IDs
    @{
    @brief Architecture IDs for RPC interface

*/
#define BRCM_SWARCH_RPC_MODULE_GLOBAL            (0x8000U)  /**< @brief #RPC_Module              */
/** @} */

/**
    @brief RPC Module to be integrated to Ethsrv Task

    @trace #BRCM_SWREQ_RPC_MODULE_V2
*/
extern const MODULE_Type RPC_Module;

#endif /* RPC_MODULE_V2_H */
/** @} */
