/*****************************************************************************
 Copyright 2018-2020 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_ethswt_cfp_ifc Compact Field Processor (CFP) Interface
    @ingroup grp_ethswt

    @addtogroup grp_ethswt_cfp_ifc
    @{

    @file ethswt_cfp.h

    @brief Interface for CFP
    This file provides the interface/APIs which can be used to initialize,
    configure and add/remove rules to/from the CFP block.

    @version 0.1 Initial version

*/

#ifndef ETHSWTCFP_H
#define ETHSWTCFP_H

#include <stdint.h>
#include "eth_switch.h"
#include <ethernet_swt_cfp.h>

/**
    @name Ethernet switch driver Architecture IDs
    @{
    @brief Architecture IDs for Ethernet switch driver
*/
#define BRCM_SWARCH_ETHSWT_CFP_TAGSTATUS_TYPE           (0x8A04U)    /**< @brief #ETHSWT_CFPTagStatusType     */
#define BRCM_SWARCH_ETHSWT_CFP_TTL_VAL_TYPE             (0x8A05U)    /**< @brief #ETHSWT_CFPTTLValType        */
#define BRCM_SWARCH_ETHSWT_CFP_SNAPSHOT_TYPE            (0x8A07U)    /**< @brief #ETHSWT_CFPSnapshotType      */
#define BRCM_SWARCH_ETHSWT_CFP_INIT_PROC                (0x8A08U)    /**< @brief #ETHSWT_CFPInit              */
#define BRCM_SWARCH_ETHSWT_CFP_ADD_RULE_PROC            (0x8A09U)    /**< @brief #ETHSWT_CFPAddRule           */
#define BRCM_SWARCH_ETHSWT_CFP_REMOVE_RULE_PROC         (0x8A0AU)    /**< @brief #ETHSWT_CFPRemoveRule        */
#define BRCM_SWARCH_ETHSWT_CFP_UPDATE_RULE_PROC         (0x8A0BU)    /**< @brief #ETHSWT_CFPUpdateRule        */
#define BRCM_SWARCH_ETHSWT_CFP_GET_STATS_PROC           (0x8A0CU)    /**< @brief #ETHSWT_CFPGetStats          */
#define BRCM_SWARCH_ETHSWT_CFP_GET_ROW_CONFIG_PROC      (0x8A0DU)    /**< @brief #ETHSWT_CFPGetRowConfig      */
#define BRCM_SWARCH_ETHSWT_CFP_GET_SNAPSHOT_PROC        (0x8A0EU)    /**< @brief #ETHSWT_CFPGetSnapshot       */
#define BRCM_SWARCH_ETHSWT_CFP_ENABLE_PORT_PROC         (0x8A0FU)    /**< @brief #ETHSWT_CFPEnablePort        */
#define BRCM_SWARCH_ETHSWT_CFP_DISABLE_PORT_PROC        (0x8A00U)    /**< @brief #ETHSWT_CFPDisablePort       */
#define BRCM_SWARCH_ETHSWT_CFP_DEINIT_PROC              (0x8A11U)    /**< @brief #ETHSWT_CFPDeInit            */
/** @} */

/**
    @name ETHSWT_CFPTagStatusType
    @{
    @brief Definitions for VLAN tag status

    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION
*/
typedef uint8_t ETHSWT_CFPTagStatusType;      /**< @brief typedef for tag status */
#define ETHSWT_CFP_TAGSTATUS_VID_NONE    (0U) /**< @brief Tag not present */
#define ETHSWT_CFP_TAGSTATUS_VID_ZERO    (1U) /**< @brief Tag present with VID=0 */
#define ETHSWT_CFP_TAGSTATUS_VID_NONZERO (3U) /**< @brief Tag present with VID!=0 */
/** @} */

/**
    @name ETHSWT_CFPTTLValType
    @{
    @brief Definitions for TTL value

    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION
*/
typedef uint8_t ETHSWT_CFPTTLValType;         /**< @brief typedef for TTL value */
#define ETHSWT_CFP_TTL_VAL_0             (0U) /**< @brief TTL=0 */
#define ETHSWT_CFP_TTL_VAL_1             (1U) /**< @brief TTL=1 */
#define ETHSWT_CFP_TTL_VAL_OTHERS        (2U) /**< @brief TTL=Others */
#define ETHSWT_CFP_TTL_VAL_255           (3U) /**< @brief TTL=255 */
/** @} */

/**
    @brief Structure for CFP table snapshot

    @trace #BRCM_SWREQ_ETHSWT_KERNEL_INTERFACE
*/
typedef struct sETHSWT_CFPSnapshotType {
    uint32_t                    numValidEntries;                 /**< @brief Number of valid entries */
    ETHSWT_CFPEntrySnapshotType entry[ETHSWT_CFP_MAX_RULES];     /**< @brief Table of per row snapshot                                                     encoded in a bitfield as follows:                                                     Enable (1) | Static (1) | Slice(2) | Format(2) | Resv(2) */
    ETHSWT_CFPUDFAllocListType  udfList[ETHSWT_CFP_NUM_FORMATS]; /**< @brief List of allocated UDFs per format */
    uint16_t                    portEnableMask;                  /**< @brief Bitmask of ports where CFP
                                                                      lookup is enabled */
} ETHSWT_CFPSnapshotType;


/** @brief Initialize CFP

    @behavior Sync, Re-entrant (for different switch index)

    @pre Switch driver is initialized

    This API initializes the CFP block. It performs the following steps:
        - clear the CFP TCAM
        - enables the feature on all ports
        - enable the global rate meter
        - programs the rules from the configuration. All these rules are
          marked as static (read only). They cannot be modified later using
          any of the APIs like #ETHSWT_CFPRemoveRule, #ETHSWT_CFPUpdateRule

    @param[in]   aID                    Switch index
    @param[in]   aConfig                Pointer to CFP configuration

    Return values are documented in reverse-chronological order
    @retval  #BCM_ERR_OK                CFP block initialized successfully
    @retval  #BCM_ERR_INVAL_PARAMS      (Register/Configuration is invalid) or
                                        (ruleListSz is greater than #ETHSWT_CFP_MAX_RULES) or
                                        (aConfig is NULL) or
                                        (Switch index is invalid)
    @retval  #BCM_ERR_TIME_OUT          CFP/Switch Register access timed out
    @retval  #BCM_ERR_NOMEM             Ran out of UDFs to accomodate a rule
    @retval  #BCM_ERR_INVAL_MAGIC       Config magic is invalid
    @retval  #BCM_ERR_INVAL_STATE       CFP is not in reset state

    @post None

    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION

    @limitations None
*/
int32_t ETHSWT_CFPInit(ETHSWT_HwIDType aID,
                 const ETHSWT_CFPConfigType* const aConfig);

/** @brief Add a CFP rule

    @behavior Sync, Re-entrant (for different switch index)

    @pre Switch driver and CFP is initialized

    This API validates and adds a rule to CFP TCAM. If a valid slice is provided in input,
    the driver tries to accomodate all UDFs of the rule in the slice. If no valid slice is
    provided, the driver tries to allocate the highest slice where all UDFs can be accomodated.
    If required, new UDFs can be allocated in the slice. Similarly, if a valid row number is
    provided as input, the driver checks if it is free and proceeds with programming the rule.
    In the case a static entry is already present at the input row error is returned. In case a
    non-static entry is present then the input rule is inserted at the row by shifting the
    existing entries. If no valid row is provided in input, the driver allocates the lowest free
    row number and proceeds with programming the rule.

    @param[in]     aID                 Switch index
    @param[in]     aKey                Key configuration
    @param[in]     aAction             Action configuration
    @param[inout]  aRow                Pointer to the requested row number (set to ETHSWT_CFP_MAX_RULES
                                       in case the driver needs to allocate) on input. On output
                                       it provides the configured row number
    @param[inout]  aSlice              Pointer to the requested slice number(set to ETHSWT_CFP_MAX_SLICES
                                       in case the driver needs to allocate) on input. On output
                                       it provides the configured slice number

    Return values are documented in reverse-chronological order
    @retval  #BCM_ERR_OK               Rule programmed successfully in CFP block
    @retval  #BCM_ERR_INVAL_PARAMS     #aID is invalid OR
                                       #aKey/#aAction/#aRow/#aSlice is NULL OR
                                       #aRow or #aSlice is invalid value OR
                                       Configuration provided is invalid
    @retval  #BCM_ERR_TIME_OUT         CFP/Switch Register access timed out
    @retval  #BCM_ERR_NOMEM            All rows in TCAM are occupied or unable
                                       to find a slice where the UDFs for this
                                       rule can be accomodated

    @retval  #BCM_ERR_INVAL_STATE      CFP is not in initialized state
    @retval  #BCM_ERR_NOPERM           Static rule configured at row which is
                                       being requested in aRule

    @post None

    @trace #BRCM_SWREQ_ETHSWT_DYNAMIC_CONFIGURATION

    @limitations None
*/
int32_t ETHSWT_CFPAddRule(ETHSWT_HwIDType aID,
                    const ETHSWT_CFPKeyType* const aKey,
                    const ETHSWT_CFPActionType* const aAction,
                    uint32_t* const aRow,
                    uint32_t* const aSlice);

/** @brief Remove a CFP rule

    @behavior Sync, Re-entrant (for different switch index)

    @pre Switch driver and CFP is initialized

    This API removes a rule (if it exists) from the CFP block. It also frees up
    any UDFs which are no longer used after deletion of this rule. This API returns
    an error in case an attempt to delete a static rule is made

    @param[in]     aID                 Switch index
    @param[in]     aRow                Row number

    Return values are documented in reverse-chronological order
    @retval  #BCM_ERR_OK               Rule removed successfully from CFP block
    @retval  #BCM_ERR_INVAL_PARAMS     #aID is invalid or #aRow is not a valid CFP row number
    @retval  #BCM_ERR_TIME_OUT         CFP/Switch Register access timed out
    @retval  #BCM_ERR_INVAL_STATE      CFP is not in initialized state
    @retval  #BCM_ERR_NOT_FOUND        No rule configured at aRow
    @retval  #BCM_ERR_NOPERM           Static rule configured at aRow

    @post None

    @trace #BRCM_SWREQ_ETHSWT_DYNAMIC_CONFIGURATION

    @limitations None
*/
int32_t ETHSWT_CFPRemoveRule(ETHSWT_HwIDType aID,
                       uint32_t aRow);

/** @brief Update a CFP rule

    @behavior Sync, Re-entrant (for different switch index)

    @pre Switch driver and CFP is initialized

    This API updates an existing rule in the CFP block. Only the action policy
    RAM is updated. This API returns an error in case an attempt to update a
    static rule is made

    @param[in]     aID                 Switch index
    @param[in]     aRow                Row number
    @param[in]     aAction             Pointer to action policy configuration

    Return values are documented in reverse-chronological order
    @retval  #BCM_ERR_OK               Action policy RAM successfully updated
    @retval  #BCM_ERR_INVAL_PARAMS     #aID is invalid or #aRow is not a valid CFP row number
                                       #aAction is NULL or has invalid configuration
    @retval  #BCM_ERR_TIME_OUT         CFP/Switch Register access timed out
    @retval  #BCM_ERR_INVAL_STATE      CFP is not in initialized state
    @retval  #BCM_ERR_NOT_FOUND        No rule configured at aRow
    @retval  #BCM_ERR_NOPERM           Static rule configured at aRow

    @post None

    @trace #BRCM_SWREQ_ETHSWT_DYNAMIC_CONFIGURATION

    @limitations None
*/
int32_t ETHSWT_CFPUpdateRule(ETHSWT_HwIDType aID,
                       uint32_t aRow,
                       const ETHSWT_CFPActionType* const aAction);

/** @brief Get statistic counters for a CFP rule

    @behavior Sync, Re-entrant (for different switch index)

    @pre Switch driver and CFP is initialized

    This API fetches the red, yellow and green statistic counters for an
    existing CFP rule

    @param[in]     aID               Switch index
    @param[in]     aRow              Row number
    @param[out]    aStats            Pointer to location to store statistics

    Return values are documented in reverse-chronological order
    @retval  #BCM_ERR_OK             Statistics fetched successfully
    @retval  #BCM_ERR_INVAL_PARAMS   #aID is invalid or #aRow is not a valid CFP row number
                                     #aStats is NULL
    @retval  #BCM_ERR_TIME_OUT       CFP/Switch Register access timed out
    @retval  #BCM_ERR_INVAL_STATE    CFP is not in initialized state
    @retval  #BCM_ERR_NOT_FOUND      No rule configured at aRow

    @post None

    @trace #BRCM_SWREQ_ETHSWT_QUERY

    @limitations None
*/
int32_t ETHSWT_CFPGetStats(ETHSWT_HwIDType aID,
                     uint32_t aRow,
                     ETHSWT_CFPStatsType *const aStats);

/** @brief Get configuration for a CFP rule

    @behavior Sync, Re-entrant (for different switch index)

    @pre Switch driver and CFP is initialized

    This API fetches the configuration for an existing CFP rule

    @param[in]     aID              Switch index
    @param[in]     aRow             Row number
    @param[out]    aConfig          Pointer to location to store configuration

    Return values are documented in reverse-chronological order
    @retval  #BCM_ERR_OK            Configuration fetched successfully
    @retval  #BCM_ERR_INVAL_PARAMS  #aID is invalid or
                                    #aConfig is NULL or has invalid configuration
                                    #aRow is not a valid CFP row
    @retval  #BCM_ERR_TIME_OUT      CFP/Switch Register access timed out
    @retval  #BCM_ERR_INVAL_STATE   CFP is not in initialized state
    @retval  #BCM_ERR_NOT_FOUND     No rule configured at aRow

    @post None

    @trace #BRCM_SWREQ_ETHSWT_QUERY

    @limitations None
*/
int32_t ETHSWT_CFPGetRowConfig(ETHSWT_HwIDType aID,
                         uint32_t aRow,
                         ETHSWT_CFPRuleType *const aConfig);

/** @brief Get summarised snapshot of the CFP table

    @behavior Sync, Re-entrant (for different switch index)

    @pre Switch driver and CFP is initialized

    This API fetches the summarised snapshot of the CFP table

    @param[in]     aID               Switch index
    @param[out]    aTable            Pointer to location to store table snapshot

    Return values are documented in reverse-chronological order
    @retval  #BCM_ERR_OK             Snapshot fetched successfully
    @retval  #BCM_ERR_INVAL_PARAMS   #aSnapshot is NULL or #aID is invalid
    @retval  #BCM_ERR_INVAL_STATE    CFP is not in initialized state

    @post None

    @trace #BRCM_SWREQ_ETHSWT_QUERY

    @limitations None
*/
int32_t ETHSWT_CFPGetSnapshot(ETHSWT_HwIDType aID,
                        ETHSWT_CFPSnapshotType *const aSnapshot);

/** @brief Enable CFP lookup on a port

    @behavior Sync, Re-entrant (for different switch index)

    @pre Switch driver and CFP is initialized

    This API enables CFP lookup on a port

    @param[in]     aID               Switch index
    @param[in]     aPortNum          Port number

    Return values are documented in reverse-chronological order
    @retval  #BCM_ERR_OK             Port enabled successfully
    @retval  #BCM_ERR_INVAL_PARAMS   #aID is invalid or port number is invalid
    @retval  #BCM_ERR_TIME_OUT       CFP/Switch Register access timed out
    @retval  #BCM_ERR_INVAL_STATE    CFP is not in initialized state

    @post None

    @trace #BRCM_SWREQ_ETHSWT_DYNAMIC_CONFIGURATION

    @limitations None
*/
int32_t ETHSWT_CFPEnablePort(ETHSWT_HwIDType aID,
                       uint32_t aPortNum);

/** @brief Disable CFP lookup on a port

    @behavior Sync, Re-entrant (for different switch index)

    @pre Switch driver and CFP is initialized

    This API disables CFP lookup on a port

    @param[in]     aID               Switch index
    @param[in]     aPortNum          Port number

    Return values are documented in reverse-chronological order
    @retval  #BCM_ERR_OK             Port disabled successfully
    @retval  #BCM_ERR_INVAL_PARAMS   #aID is invalid or port number is invalid
    @retval  #BCM_ERR_TIME_OUT       CFP/Switch Register access timed out
    @retval  #BCM_ERR_INVAL_STATE    CFP is not in initialized state

    @post None

    @trace #BRCM_SWREQ_ETHSWT_DYNAMIC_CONFIGURATION

    @limitations None
*/
int32_t ETHSWT_CFPDisablePort(ETHSWT_HwIDType aID,
                       uint32_t aPortNum);

/** @brief De-Initialize CFP

    @behavior Sync, Re-entrant (for different switch index)

    @pre CFP, Switch driver is initialized

    This API de-initializes the CFP block. It disables the feature on all ports

    @param[in]   aID                   Switch index

    Return values are documented in reverse-chronological order
    @retval  #BCM_ERR_OK               CFP block de-initialized successfully
    @retval  #BCM_ERR_INVAL_PARAMS     #aID is invalid
    @retval  #BCM_ERR_TIME_OUT         CFP/Switch Register access timed out
    @retval  #BCM_ERR_INVAL_STATE      CFP is already in reset state

    @post None

    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION

    @limitations None
*/
int32_t ETHSWT_CFPDeInit(ETHSWT_HwIDType aID);

#endif /* ETHSWTCFP_H */
/** @} */
