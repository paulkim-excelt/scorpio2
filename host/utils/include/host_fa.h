/*****************************************************************************
 Copyright 2020 Broadcom Limited.  All rights reserved.

 This program is the proprietary software of Broadcom Corporation and/or its
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

/** @defgroup grp_host_fa_ifc Host FA Interface
    @ingroup grp_host_fa

    @addtogroup grp_host_fa_ifc
    @{

    @file host_fa.h
    @brief Host FA Interface
    This header file contains the host interface functions for FA

    @version 0.1 Initial Version
*/

#ifndef HOST_FA_H
#define HOST_FA_H

#include <ethernet_swt_fa.h>
/**
    @name Host API IDs for Flow Accelerator
    @{
    @brief Host FA API
*/
#define BRCM_SWARCH_HOST_FAFLOWADD_PROC            (0x8101U)    /**< @brief #HOST_FAFlowAdd         */
#define BRCM_SWARCH_HOST_FAFLOWDELETE_PROC         (0x8102U)    /**< @brief #HOST_FAFlowDelete      */
#define BRCM_SWARCH_HOST_FAFLOWGET_PROC            (0x8103U)    /**< @brief #HOST_FAFlowGet         */
#define BRCM_SWARCH_HOST_FASTATS_PROC              (0x8104U)    /**< @brief #HOST_FAStats           */
#define BRCM_SWARCH_HOST_FA_FLOW_STAUTS_PROC       (0x8105U)    /**< @brief #HOST_FAFlowStatus      */
#define BRCM_SWARCH_HOST_FAMACADD_PROC             (0x8106U)    /**< @brief #HOST_FAMacAdd          */
#define BRCM_SWARCH_HOST_FAMACDELETE_PROC          (0x8107U)    /**< @brief #HOST_FAMacDelete       */
#define BRCM_SWARCH_HOST_FAMACFORCEDELETE_PROC     (0x8108U)    /**< @brief #HOST_FAMacForceDelete  */
#define BRCM_SWARCH_HOST_FAMACSNAPSHOTGET_PROC     (0x8109U)    /**< @brief #HOST_FAMacSnapshotGet  */
#define BRCM_SWARCH_HOST_FARESET_PROC              (0x810AU)    /**< @brief #HOST_FAReset           */
#define BRCM_SWARCH_HOST_FAENABLEINTERRUPT_PROC    (0x810BU)    /**< @brief #HOST_FAEnableInterrupt */
/** @} */

/** @brief Add a Flow

    This API adds a new flow into Flow accelerator

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      info       Pointer to #MgmtInfoType handle
    @param[in]      aFlow      Pointer to #ETHSWT_FAFlowDataType
    @param[Out]     aFlowID    Pointer to obtain the flow identifier upon success

    Return values are documented in reverse-chronological order
    @retval    #BCM_ERR_OK              Flow added successfully
    @retval    #BCM_ERR_NOMEM           Insufficient memory to add
    @retval    #BCM_ERR_NOT_FOUND       Matching entry not found in Pool table
    @retval    #BCM_ERR_INVAL_STATE     FA is configured in BYPASS mode
    @retval    #BCM_ERR_UNINIT          FA is uninitialised
    @retval    #BCM_ERR_INVAL_PARAMS    aFlow is NULL OR aFlowID is NULL
    @return    #BCM_ERR_DATA_INTEG      Reply from the target is not of appropriate length

    @post None

    @limitations None

    @trace #BRCM_SWREQ_HOST_FA_SET_CMD_HANDLER
*/
extern int32_t HOST_FAFlowAdd(MgmtInfoType *info,
                                ETHSWT_FAFlowDataType *aFlow,
                                ETHSWT_FAFlowIDType  *aFlowID);

/** @brief Delete a Flow

    This API deletes an existing flow from Flow accelerator by providing the
    Flow ID obtained after adding the same.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      info        Pointer to #MgmtInfoType handle
    @param[in]      aFlowID     Flow ID of the to be deleted flow

    Return values are documented in reverse-chronological order
    @retval    #BCM_ERR_OK              Flow deleted successfully
    @retval    #BCM_ERR_NOPERM          No permission to delete static entry
    @retval    #BCM_ERR_UNINIT          FA is uninitialised
    @retval    #BCM_ERR_INVAL_PARAMS    aFlowID is invalid
    @return    #BCM_ERR_DATA_INTEG      Reply from the target is not of appropriate length

    @post None

    @limitations None
`
    @trace #BRCM_SWREQ_HOST_FA_SET_CMD_HANDLER
*/
extern int32_t HOST_FAFlowDelete(MgmtInfoType *info,
                                     ETHSWT_FAFlowIDType aFlowID);

/** @brief Flow Get

    This API retrieves flow parameters pertaining to a Flow ID

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      info        Pointer to #MgmtInfoType handle
    @param[in]      aFlowID     Flow ID of the flow #ETHSWT_FAFlowIDType
    @param[out]     aFlow       Pointer to retrieve flow parameters for aFlowID
    @param[out]     aFlowStats  Pointer to retrieve flow statistics for aFlowID

    Return values are documented in reverse-chronological order
    @retval    #BCM_ERR_OK              Flow parameters obtained successfully
    @retval    #BCM_ERR_UNINIT          FA is uninitialised
    @retval    #BCM_ERR_INVAL_PARAMS    aFlowID is invalid OR
                                        aFlow is NULL OR aFlowStats is NULL
    @return    #BCM_ERR_DATA_INTEG      Reply from the target is not of appropriate length

    @post None

    @limitations None

    @trace #BRCM_SWREQ_HOST_FA_QUERY_CMD_HANDLER
*/
extern int32_t HOST_FAFlowGet(MgmtInfoType *info, ETHSWT_FAFlowIDType aFlowID,
                                ETHSWT_FAFlowDataType  *aFlow,
                                ETHSWT_FAFlowStatsType *aFlowStats);

/** @brief Retrieve FA Global statistics

    This API retrieves statistics from Flow accelerator

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      info        Pointer to #MgmtInfoType handle
    @param[out]     aStats      Pointer to stats structure of #ETHSWT_FAStatsType

    Return values are documented in reverse-chronological order
    @retval    #BCM_ERR_OK              Statistics retrieved successfully
    @retval    #BCM_ERR_UNINIT          FA is uninitialised
    @retval    #BCM_ERR_INVAL_PARAMS    aStats is NULL
    @return    #BCM_ERR_DATA_INTEG      Reply from the target is not of appropriate length

    @post None

    @limitations None

    @trace #BRCM_SWREQ_HOST_FA_QUERY_CMD_HANDLER
*/
extern int32_t HOST_FAStats(MgmtInfoType *info,
                              ETHSWT_FAStatsType *aStats);

/** @brief Retrieve FA Flow Status

    This API retrieves status from Flow accelerator

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      info         Pointer to #MgmtInfoType handle
    @param[out]     aFlowStatus  Pointer to status structure of #ETHSWT_FAFlowStatusDataType

    Return values are documented in reverse-chronological order
    @retval    #BCM_ERR_OK              Status retrieved successfully
    @retval    #BCM_ERR_UNINIT          FA is uninitialised
    @retval    #BCM_ERR_INVAL_PARAMS    aFlowStatus is NULL
    @return    #BCM_ERR_DATA_INTEG      Reply from the target is not of appropriate length

    @post None

    @limitations None

    @trace #BRCM_SWREQ_HOST_FA_QUERY_CMD_HANDLER
*/
extern int32_t HOST_FAFlowStatus(MgmtInfoType *info,
                                    ETHSWT_FAFlowStatusDataType *aFlowStatus);

/** @brief Add MAC Address

    This API will add a pool table entry

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  info        Pointer to #MgmtInfoType handle
    @param[in]  aMacOp      MAC address and Group to be added #ETHSWT_FAMacOperationType

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK           Successfully added or same exists already
    @retval     #BCM_ERR_NOMEM        No memory available to add a new entry
    @retval     #BCM_ERR_NOPERM       No permission to overwrite existing MAC
                                      with different "external" field
    @retval     #BCM_ERR_INVAL_PARAMS aMac is NULL OR MAC address is all 0s OR
                                      aExternal is neither TRUE nor FALSE
    @return    #BCM_ERR_DATA_INTEG    Reply from the target is not of appropriate length

    @post None

    @limitations None

    @trace #BRCM_SWREQ_HOST_FA_SET_CMD_HANDLER
*/
extern int32_t HOST_FAMacAdd(MgmtInfoType *info, ETHSWT_FAMacOperationType *aMacOp);

/** @brief Delete MAC Address

    This API will will delete a pool table entry if it is no more referenced by
    any of the flows.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]    info        Pointer to #MgmtInfoType handle
    @param[in]    aMacOp      MAC address to be deleted #ETHSWT_FAMacOperationType

    Return values are documented in reverse-chronological order
    @retval    #BCM_ERR_OK              Entry deleted successfully
    @retval    #BCM_ERR_BUSY            Entry cannot be deleted as it is in use
    @retval    #BCM_ERR_NOT_FOUND       Entry not found
    @retval    #BCM_ERR_INVAL_PARAMS    aMac is NULL
    @return    #BCM_ERR_DATA_INTEG      Reply from the target is not of appropriate length

    @post None

    @limitations None

    @trace #BRCM_SWREQ_HOST_FA_SET_CMD_HANDLER
*/
extern int32_t HOST_FAMacDelete(MgmtInfoType *info, ETHSWT_FAMacOperationType *aMacOp);

/** @brief Delete MAC Address by Force

    This API will try delete a pool table entry.
    If it found that the MAC is used by any Flow then this API Retreive the FLOW status
    curresponding to that address.And in the flow status individuvally
    the flow will be deleted and then MAC.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]    info        Pointer to #MgmtInfoType handle
    @param[in]    aMacOp      MAC address to be deleted #ETHSWT_FAMacOperationType

    Return values are documented in reverse-chronological order
    @retval    #BCM_ERR_OK              Entry deleted successfully
    @retval    #BCM_ERR_BUSY            Entry cannot be deleted as it is in use
    @retval    #BCM_ERR_NOT_FOUND       Entry not found
    @retval    #BCM_ERR_INVAL_PARAMS    aMac is NULL
    @return    #BCM_ERR_DATA_INTEG      Reply from the target is not of appropriate length

    @post None

    @limitations None

    @trace #BRCM_SWREQ_HOST_FA_SET_CMD_HANDLER
*/
extern int32_t HOST_FAMacForceDelete(MgmtInfoType *info, ETHSWT_FAMacOperationType *aMacOp);

/** @brief Get Snapshot of the pool table MAC addresses

    This API will retrieve Pool Table MAC addresses, their domain(internal/
    external) and their usage as a bitmask of flow IDs

    @behavior Sync, Re-entrant

    @pre None

    @param[in]    info            Pointer to #MgmtInfoType handle
    @param[out]   aMacSnapShot    Pointer to retrieve MAC Snapshot #ETHSWT_FAMacSnapshotType

    Return values are documented in reverse-chronological order
    @retval    #BCM_ERR_OK              Pool table read successfully and
                                        information populated
    @retval    #BCM_ERR_NOT_FOUND       MAC address doesn't match existing ones
    @retval    #BCM_ERR_INVAL_PARAMS    aMacSnapShot is NULL
    @retval    #BCM_ERR_UNINIT          Ethernet is not initialized
    @retval    #BCM_ERR_NOSUPPORT       Invalid aCmdId
    @return    #BCM_ERR_DATA_INTEG      Reply from the target is not of appropriate length

    @post None

    @limitations None

    @trace #BRCM_SWREQ_HOST_FA_QUERY_CMD_HANDLER
*/
extern int32_t HOST_FAMacSnapshotGet(MgmtInfoType *info,
                                   ETHSWT_FAMacSnapshotType *aMacSnapShot);

/** @brief Re-Initilize the FA

    This API will De-Initialize and Initialize the FA with the
    Provided configuration as an argument

    @behavior Sync, Re-entrant

    @pre None

    @param[in]    info         Pointer to #MgmtInfoType handle
    @param[in]    ctcfCfg      Pointer to CTCF Configuration

    Return values are documented in reverse-chronological order
    @retval    #BCM_ERR_OK              Entry deleted successfully
    @retval    #BCM_ERR_NOSUPPORT       This operation is Not Supported
    @retval    #BCM_ERR_INVAL_PARAMS    ctcfCfg is NULL
    @return    #BCM_ERR_DATA_INTEG      Reply from the target is not of appropriate length

    @post None

    @limitations None

    @trace #BRCM_SWREQ_HOST_FA_SET_CMD_HANDLER
*/
extern int32_t HOST_FAReset(MgmtInfoType *info, ETHSWT_FACtfCfgType *ctcfCfg);


/** @brief Enable Interrupt For the FA

    This API will set the Interrupt Flags of #ETHSWT_FAIntrFlagsType

    @behavior Sync, Re-entrant

    @pre None

    @param[in]    info       Pointer to #MgmtInfoType handle
    @param[in]    flags      Interrupt Flags

    Return values are documented in reverse-chronological order
    @retval   #BCM_ERR_OK              Successfully enabled interrupts
    @retval   #BCM_ERR_UNINIT          FA is uninitialised
    @return   #BCM_ERR_DATA_INTEG      Reply from the target is not of appropriate length

    @post None

    @limitations None

    @trace #BRCM_SWREQ_HOST_FA_SET_CMD_HANDLER
*/
extern int32_t HOST_FAEnableInterrupt(MgmtInfoType *info, ETHSWT_FAIntrFlagsType flags);

#endif /* HOST_FA_H */

/** @} */
