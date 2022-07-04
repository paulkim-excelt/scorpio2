/*****************************************************************************
 Copyright 2022 Broadcom Limited.  All rights reserved.

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
    @addtogroup grp_rpc_v2_ifc
    @{

    @file rpc_x86.c
    @brief This file adds the RPC Interface configuration

    @version 0.1 Initial version
*/
#include <stdlib.h>
#include <rpc_interface.h>
#include <rpc_local.h>
#include <mcu.h>
#include <bcm_utils.h>

/**
    @name RPC Interface configuration Design IDs
    @{
    @brief Design IDs for RPC Interface Configuration
*/
#define BRCM_SWDSGN_RPC_INTERFACE_GLOBAL         (0xB601U)    /**< @brief #RPC_Interfaces */
#define BRCM_SWDSGN_RPC_GETMODINTERFACES_PROC    (0xB602U)    /**< @brief #RPC_GetModInterfaces */
/** @} */

/**
    @brief RPC Interface Configuration

    @trace #BRCM_SWARCH_RPC_GETMODINTERFACES_PROC
    @trace #BRCM_SWREQ_RPC_INTERFACE
*/
const RPC_InterfaceType* const RPC_InterfacesNonStacked[RPC_INTERFACEID_MAX] = {
    &RPC_IPCSlaveIfc,
    &RPC_UDPSlaveIfc,
    &RPC_MasterIfc,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
};

/**
    @brief RPC Interface Configuration

    @trace #BRCM_SWARCH_RPC_GETMODINTERFACES_PROC
    @trace #BRCM_SWREQ_RPC_INTERFACE
*/
const RPC_InterfaceType* const RPC_InterfacesStackMaster[RPC_INTERFACEID_MAX] = {
    &RPC_IPCSlaveIfc,
    &RPC_MasterIfc,
    &RPC_SlaveIfc,
    &RPC_UDPMasterIfc,
    NULL,
    NULL,
    NULL,
    NULL,
};

/**
    @brief RPC Interface Configuration

    @trace #BRCM_SWARCH_RPC_GETMODINTERFACES_PROC
    @trace #BRCM_SWREQ_RPC_INTERFACE
*/
const RPC_InterfaceType* const RPC_InterfacesStackSlave[RPC_INTERFACEID_MAX] = {
    &RPC_UDPSlaveIfc,
    &RPC_MasterIfc,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
};


/** @brief Get Interface List

    @trace  #BRCM_SWARCH_RPC_GETMODINTERFACES_PROC
    @trace  #BRCM_SWREQ_RPC_INTERFACE

    @code{.c}
    return RPC_Interfaces
    @endcode
*/
const RPC_InterfaceType* const * RPC_GetModInterfaces()
{
    int32_t retVal;
    MCU_InfoType stackingInfo;
    const RPC_InterfaceType * const *intferfaces = NULL;
    BCM_MemSet(&stackingInfo, 0U, sizeof(MCU_InfoType));

    retVal = MCU_GetInfo(&stackingInfo);
    if (BCM_ERR_OK == retVal) {
        if (TRUE == stackingInfo.stackingEn) {
            if (MCU_DEVICE_MASTER == stackingInfo.mstSlvMode) {
                intferfaces = RPC_InterfacesStackMaster;
            } else {
                intferfaces = RPC_InterfacesStackSlave;
            }
        } else {
            intferfaces = RPC_InterfacesNonStacked;
        }
    }

    return intferfaces;
}

/** @} */
