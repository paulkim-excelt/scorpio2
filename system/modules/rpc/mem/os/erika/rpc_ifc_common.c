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
    @addtogroup grp_rpc_v2_ifc
    @{

    @file rpc_ifc_common.c
    @brief RPC Interface Common
    This file contains the RPC common Interface implementation

    @version 0.1 Initial draft
*/

#include <stdlib.h>
#include <rpc_interface.h>

/**
    @name RPC Interface Common Design IDs
    @{
    @brief Design IDs for RPC Interface Common

*/
#define BRCM_SWDSGN_RPC_GETMODIFCANDASSOC_PROC          (0xE000U)    /**< @brief #RPC_GetModIfcAndAssoc  */
#define BRCM_SWDSGN_RPC_RPC_GET_SLAVE_IFC_IDX_PROC      (0xE001U)    /**< @brief #RPC_GetSlaveIfcIdx     */
/** @} */

/** @brief Get Module Interface And Association

    @trace  #BRCM_SWARCH_RPC_GETMODIFCANDASSOC_PROC
    @trace  #BRCM_SWREQ_RPC_INTERFACE

    @code{.c}
    retVal = BCM_ERR_UNKNOWN
    for(ifc = 0; ifc < RPC_INTERFACEID_MAX; ifc++)
        if ((interfaces[ifc].module IS NOT NULL)
                   AND (interfaces[ifc].module IS aMod))
            *aSlaveIfcID = ifc
            *aAssocID = interfaces[ifc].association
            retVal = BCM_ERR_OK
            break

    if(retVal IS NOT BCM_ERR_UNKNOWN)
        retVal = BCM_ERR_UNKNOWN
        for(ifc = 0UL; ifc < RPC_INTERFACEID_MAX; ifc++)
            if ((NULL != interfaces[ifc].module)
                   AND (interfaces[ifc].association == *aAssocID))
                if((interfaces[*aSlaveIfcID].module->mode IS RPC_IFC_CHAN_MODE_MASTER)
                   && (interfaces[ifc].module->mode IS RPC_IFC_CHAN_MODE_SLAVE))
                        Request received from master module.And looking for connected slave
                        So, copy the aSlaveIfcID to aMasterIfcID and update the aSlaveIfcID
                        *aMasterIfcID = *aSlaveIfcID
                        *aSlaveIfcID = ifc
                        retVal = BCM_ERR_OK
                        break
                else if((RPC_IFC_CHAN_MODE_SLAVE == interfaces[*aSlaveIfcID].module->mode)
                             && (RPC_IFC_CHAN_MODE_MASTER == interfaces[ifc].module->mode))
                    Request received from slave module.And looking for connected master
                    *aMasterIfcID = ifc
                    retVal = BCM_ERR_OK
                    break
    return retVal
    @endcode
*/
int32_t RPC_GetModIfcAndAssoc(const RPC_InterfaceType *aMod,
                              RPC_InterfaceIdType *aSlaveIfcID,
                              RPC_InterfaceIdType *aMasterIfcID,
                              RPC_AssociationIndexType *aAssocID)
{
    uint32_t ifc;
    int32_t retVal = BCM_ERR_UNKNOWN;
    const RPC_InterfaceType * const *interfaces = RPC_GetModInterfaces();

    for(ifc = 0UL; ifc < RPC_INTERFACEID_MAX; ifc++) {
        if ((NULL != interfaces) &&
            (NULL != interfaces[ifc]) &&
            (interfaces[ifc] == aMod)) {
            *aSlaveIfcID = ifc;
            *aAssocID = interfaces[ifc]->assoc;
            retVal = BCM_ERR_OK;
            break;
        }
    }

    if(BCM_ERR_UNKNOWN != retVal) {
        retVal = BCM_ERR_UNKNOWN;
        for(ifc = 0UL; ifc < RPC_INTERFACEID_MAX; ifc++) {
            if ((NULL != interfaces) &&
                (NULL != interfaces[ifc]) &&
                (interfaces[ifc]->assoc == *aAssocID)) {
                if((RPC_IFC_CHAN_MODE_MASTER == interfaces[*aSlaveIfcID]->mode)
                   && (RPC_IFC_CHAN_MODE_SLAVE == interfaces[ifc]->mode)) {
                    *aMasterIfcID = *aSlaveIfcID;
                    *aSlaveIfcID = ifc;
                    retVal = BCM_ERR_OK;
                    break;
                } else if((RPC_IFC_CHAN_MODE_SLAVE == interfaces[*aSlaveIfcID]->mode)
                             && (RPC_IFC_CHAN_MODE_MASTER == interfaces[ifc]->mode)) {
                    *aMasterIfcID = ifc;
                    retVal = BCM_ERR_OK;
                    break;
                } else {
                  /* Do Nothing */
                  /* It returns Error */
                }
            }
        }
    }

    return retVal;
}

/** @brief Verify if its a valid peer interface

    @trace  #BRCM_SWARCH_RPC_GET_SLAVE_IFC_IDX_PROC
    @trace  #BRCM_SWREQ_RPC_INTERFACE

    @code{.c}
    interfaces = RPC_GetModInterfaces();
    idx = RPC_INTERFACEID_MAX
    if (NULL != interfaces)
        for i=0:RPC_INTERFACEID_MAX-1
            if interfaces[i] is NULL
                    OR interfaces[i]->mode is not RPC_IFC_CHAN_MODE_SLAVE
                    OR interfaces[i]->assoc is not aAssoc
                Do Nothing
            else interface[i]->type is RPC_IFC_CHAN_IPC AND aType is IMGL_CHANNEL_ID_RPC_IPC
                idx = i;
                break
            else interface[i]->type is RPC_IFC_CHAN_UDP AND aType is IMGL_CHANNEL_ID_RPC_UDP
                idx = i;
                break
    return idx
    @endcode
*/
RPC_InterfaceIdType RPC_GetSlaveIfcIdx(RPC_AssociationIndexType aAssoc, IMGL_ChannelType aType)
{
    uint32_t i;
    const RPC_InterfaceType * const *interfaces = RPC_GetModInterfaces();

    RPC_InterfaceIdType idx = RPC_INTERFACEID_MAX;
    if (NULL != interfaces) {
        for (i = 0UL; i < RPC_INTERFACEID_MAX; i++) {
            if ((NULL == interfaces[i])
                || (RPC_IFC_CHAN_MODE_SLAVE != interfaces[i]->mode)
                || (aAssoc != interfaces[i]->assoc)) {
                /* Do Nothing */
            } else if ((RPC_IFC_CHAN_IPC == interfaces[i]->type)
                    && (IMGL_CHANNEL_ID_RPC_IPC == aType)) {
                idx = i;
                break;
            } else if ((RPC_IFC_CHAN_UDP == interfaces[i]->type)
                    && (IMGL_CHANNEL_ID_RPC_UDP == aType)) {
                idx = i;
                break;
            } else {
                /* Do Nothing */
            }
         }
     }
    return idx;
}

/** @} */
