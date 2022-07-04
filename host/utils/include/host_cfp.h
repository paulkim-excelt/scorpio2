/*****************************************************************************
 Copyright 2018-2019 Broadcom Limited.  All rights reserved.

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

/**
    @defgroup grp_host_cfp Host CFP
    @ingroup grp_host_comms

    @addtogroup grp_host_cfp
    @{

    @file host_cfp.h
    @brief Host CFP API
    This header file contains the host interface functions for CFP

    @version 1.0 Initial Version
*/

#ifndef HOST_CFP_H
#define HOST_CFP_H

#include <host_system.h>
#include <ethernet_swt_cfp.h>

/** @brief CFP Get Stats

    This API is used to get statistics information from CFP

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      info        Pointer to #MgmtInfoType handle
    @param[in]      row         Row number
    @param[out]     stats       Pointer to #ETHSWT_CFPStatsType to be filled

    @return     #BCM_ERR_OK             Statistics information filled successfully
    @return     #BCM_ERR_INVAL_PARAMS   Invalid info pointer
    @return     #BCM_ERR_INVAL_PARAMS   Invalid row
    @return     #BCM_ERR_INVAL_PARAMS   Invalid stats pointer
    @return     #BCM_ERR_UNKNOWN        Error reported by target
    @return     #BCM_ERR_DATA_INTEG     Reply from the target is not of appropriate length

    @post None

    @limitations None
*/
extern int32_t HOST_CFPGetStats(MgmtInfoType *info, uint32_t row, ETHSWT_CFPStatsType *stats);

/** @brief CFP Add Rule

    This API is used to add a CFP rule. The slice number in the rule config is used if valid and if
    the rule can be accomodated in that slice. Otherwise the highest slice where the rule can be
    accomodated is chosen. The row number in the rule config is used if it is valid, otherwise the
    lowest numbered free row is chosen. If the row is already occupied by a static rule, this call
    will fail. If it is occupied by a non-static rule, the existing rules are moved to create space
    and the rule is added at the input row number

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      info        Pointer to #MgmtInfoType handle
    @param[in]      config      Pointer to #ETHSWT_CFPRuleType

    @return     #BCM_ERR_OK             Rule added successfully
    @return     #BCM_ERR_INVAL_PARAMS   Invalid info pointer
    @return     #BCM_ERR_INVAL_PARAMS   Invalid config pointer
    @return     #BCM_ERR_INVAL_PARAMS   Invalid row
    @return     #BCM_ERR_INVAL_PARAMS   Invalid slice
    @return     #BCM_ERR_UNKNOWN        Error reported by target
    @return     #BCM_ERR_DATA_INTEG     Reply from the target is not of appropriate length

    @post None

    @limitations None
*/
extern int32_t HOST_CFPAddRule(MgmtInfoType *info, ETHSWT_CFPRuleType *config);

/** @brief CFP Delete Rule

    This API is used to delete a CFP rule

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      info        Pointer to #MgmtInfoType handle
    @param[in]      row         Row number

    @return     #BCM_ERR_OK             Rule deleted successfully
    @return     #BCM_ERR_INVAL_PARAMS   Invalid info pointer
    @return     #BCM_ERR_INVAL_PARAMS   Invalid row
    @return     #BCM_ERR_UNKNOWN        Error reported by target
    @return     #BCM_ERR_DATA_INTEG     Reply from the target is not of appropriate length

    @post None

    @limitations None
*/
extern int32_t HOST_CFPDeleteRule(MgmtInfoType *info, uint32_t row);

/** @brief CFP Update Rule

    This API is used to update a CFP rule

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      info        Pointer to #MgmtInfoType handle
    @param[in]      row         Row number
    @param[in]      action      Pointer to #ETHSWT_CFPActionType

    @return     #BCM_ERR_OK             Rule updated successfully
    @return     #BCM_ERR_INVAL_PARAMS   Invalid info pointer
    @return     #BCM_ERR_INVAL_PARAMS   Invalid row
    @return     #BCM_ERR_INVAL_PARAMS   Invalid action
    @return     #BCM_ERR_UNKNOWN        Error reported by target
    @return     #BCM_ERR_DATA_INTEG     Reply from the target is not of appropriate length

    @post None

    @limitations None
*/
extern int32_t HOST_CFPUpdateRule(MgmtInfoType *info, uint32_t row, ETHSWT_CFPActionType *action);

/** @brief CFP get row configuration

    This API is used to get the row configuration

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      info        Pointer to #MgmtInfoType handle
    @param[in]      row         Row number
    @param[out]     config      Pointer to #ETHSWT_CFPRuleType to be filled

    @return     #BCM_ERR_OK             Row configuration obtained successfully
    @return     #BCM_ERR_INVAL_PARAMS   Invalid info pointer
    @return     #BCM_ERR_INVAL_PARAMS   Invalid row
    @return     #BCM_ERR_INVAL_PARAMS   Invalid config pointer
    @return     #BCM_ERR_UNKNOWN        Error reported by target
    @return     #BCM_ERR_DATA_INTEG     Reply from the target is not of appropriate length

    @post None

    @limitations None
*/
extern int32_t HOST_CFPGetRowConfig(MgmtInfoType *info, uint32_t row, ETHSWT_CFPRuleType* config);

/** @brief CFP get snapshot

    This API is used to get the table snapshot

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      info        Pointer to #MgmtInfoType handle
    @param[out]     snapshot    Pointer to #ETHSWT_CFPTableSnapshotType to be filled
    @param[out]     rules       Pointer to #ETHSWT_CFPEntrySnapshotType to be filled

    @return     #BCM_ERR_OK             Snapshot obtained successfully
    @return     #BCM_ERR_INVAL_PARAMS   Invalid rules pointer
    @return     #BCM_ERR_INVAL_PARAMS   Invalid snapshot pointer
    @return     #BCM_ERR_UNKNOWN        Error reported by target
    @return     #BCM_ERR_DATA_INTEG     Reply from the target is not of appropriate length

    @post None

    @limitations None
*/
extern int32_t HOST_CFPGetSnapshot(MgmtInfoType *info,
                                   ETHSWT_CFPTableSnapshotType* snapShot,
                                   ETHSWT_CFPEntrySnapshotType *rules);

/** @brief CFP set port mode

    This API is used to set the port mode

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      info        Pointer to #MgmtInfoType handle
    @param[in]      port        Port number
    @param[in]      enable      Enable mode

    @return     #BCM_ERR_OK             Port mode set successfully
    @return     #BCM_ERR_INVAL_PARAMS   Invalid info pointer
    @return     #BCM_ERR_INVAL_PARAMS   Invalid enable
    @return     #BCM_ERR_UNKNOWN        Error reported by target
    @return     #BCM_ERR_DATA_INTEG     Reply from the target is not of appropriate length

    @post None

    @limitations None
*/
extern int32_t HOST_CFPSetPortMode(MgmtInfoType *info, uint32_t port, uint32_t enable);

/** @brief CFP Notification Handler

    This API is meant to handle asynchronous notifications sent by CFP on target

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      currentSlave    Slave ID
    @param[in]      notificationId  Notification ID
    @param[in]      msg             Message buffer pointer
    @param[in]      size            Size of the message buffer "msg" in bytes

    @return     #BCM_ERR_INVAL_PARAMS   Implementation not there

    @post None

    @limitations None
*/
extern int32_t HOST_CFPNotificationHandler(uint32_t currentSlave,
                uint8_t notificationId, uint8_t *msg, uint32_t size);

/** @brief Stream policer addition

    This API is used to add a stream policer

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      info            Pointer to #MgmtInfoType handle
    @param[in]      mac_addr        Pointer to an character buffer MAC address
    @param[in]      vlan            VLAN ID
    @param[in]      rate            Policer rate (Kbps)
    @param[in]      burst           Policer burst (bytes)
    @param[in]      srcMask         Ingress port bitmask
    @param[in]      threshold       Drop threshold (bytes)
    @param[in]      interval        Monitoring interval (ticks)
    @param[in]      report          Flag indicating whether host needs to be notified when
                                    drop threshold is exceeded
    @param[in]      block           Flag indicating whether stream should be blocked when
                                    drop threshold is exceeded
    @param[out]     streamIdx       Stream index

    @return     #BCM_ERR_OK             Stream policer added successfully
    @return     #BCM_ERR_INVAL_PARAMS   Invalid info pointer
    @return     #BCM_ERR_UNKNOWN        Error reported by target

    @post None

    @limitations None
*/
int32_t HOST_CFPStreamPolicerAdd(MgmtInfoType *info, uint8_t *mac_addr, uint16_t vlan,
                                      uint32_t rate, uint32_t burst, uint32_t srcMask,
                                      uint32_t threshold, uint32_t interval, uint32_t report,
                                      uint32_t block, uint32_t *const streamIdx);

/** @brief Stream policer deletion

    This API is used to delete a stream policer

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      info            Pointer to #MgmtInfoType handle
    @param[in]      streamIdx       Stream index

    @return     #BCM_ERR_OK             Stream policer deleted successfully
    @return     #BCM_ERR_INVAL_PARAMS   Invalid info pointer
    @return     #BCM_ERR_UNKNOWN        Error reported by target

    @post None

    @limitations None
*/
int32_t HOST_CFPStreamPolicerDel(MgmtInfoType *info, uint32_t streamIdx);

/** @brief Block stream

    This API is used to block a stream

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      info            Pointer to #MgmtInfoType handle
    @param[in]      streamIdx       Stream index

    @return     #BCM_ERR_OK             Stream blocked successfully
    @return     #BCM_ERR_INVAL_PARAMS   Invalid info pointer
    @return     #BCM_ERR_UNKNOWN        Error reported by target

    @post None

    @limitations None
*/
int32_t HOST_CFPStreamBlock(MgmtInfoType *info, uint32_t streamIdx);

/** @brief Resume stream

    This API is used to resume a blocked stream

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      info            Pointer to #MgmtInfoType handle
    @param[in]      streamIdx       Stream index

    @return     #BCM_ERR_OK             Stream resumed successfully
    @return     #BCM_ERR_INVAL_PARAMS   Invalid info pointer
    @return     #BCM_ERR_UNKNOWN        Error reported by target

    @post None

    @limitations None
*/
int32_t HOST_CFPStreamResume(MgmtInfoType *info, uint32_t streamIdx);

/** @brief Find stream policer index

    This API is used to find a stream policer index

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      info            Pointer to #MgmtInfoType handle
    @param[in]      mac_addr        Pointer to an character buffer MAC address
    @param[in]      vlan            VLAN ID
    @param[in]      srcMask         Ingress port bitmask
    @param[out]     streamIdx       Stream index

    @return     #BCM_ERR_OK             Stream policer index found successfully
    @return     #BCM_ERR_INVAL_PARAMS   Invalid info pointer
    @return     #BCM_ERR_UNKNOWN        Error reported by target

    @post None

    @limitations None
*/
int32_t HOST_CFPStreamPolicerFindIdx(MgmtInfoType *info, uint8_t *mac_addr, uint16_t vlan,
                                          uint32_t srcMask, uint32_t *const streamIdx);

/** @brief Get stream policer status

    This API is used to retrieve stream policer status for a particular index

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      info            Pointer to #MgmtInfoType handle
    @param[inout]   aStatus         Pointer to stream policer status

    @return     #BCM_ERR_OK             Stream policer status retrieved successfully
    @return     #BCM_ERR_INVAL_PARAMS   Invalid info pointer
    @return     #BCM_ERR_UNKNOWN        Error reported by target

    @post None

    @limitations None
*/
int32_t HOST_CFPStreamPolicerGetStatus(MgmtInfoType *info, ETHSWT_CFPStreamPolicerStatusType *const aStatus);

/** @brief Get stream policer snapshot

    This API is used to retrieve stream policer snapshot

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      info            Pointer to #MgmtInfoType handle
    @param[inout]   aSnapshot       Pointer to stream policer snapshot

    @return     #BCM_ERR_OK             Stream policer snapshot retrieved successfully
    @return     #BCM_ERR_INVAL_PARAMS   Invalid info pointer
    @return     #BCM_ERR_UNKNOWN        Error reported by target

    @post None

    @limitations None
*/
int32_t HOST_CFPStreamPolicerSnapshot(MgmtInfoType *info, ETHSWT_CFPStreamPolicerSnapshotType *const aSnapshot);

#endif /* HOST_CFP_H */

/** @} */
