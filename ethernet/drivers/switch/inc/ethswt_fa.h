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
    @defgroup grp_fa_ifc Flow Accelerator Interface
    @ingroup grp_ethswt

    @addtogroup grp_fa_ifc
    @{

    @file ethswt_fa.h
    @brief Flow Accelerator interface
    This header file contains the interface functions for Flow accelerator

    @version 0.1 Initial version
*/

#ifndef ETHSWT_FA_H
#define ETHSWT_FA_H

#include <bcm_err.h>
#include <compiler.h>
#include <unimac.h>
#include <eth_switch.h>
#include <ethernet_swt_fa.h>

/**
    @name Flow Accelerator API IDs
    @{
    @brief API IDs for Flow Accelerator
*/
#define BRCM_SWARCH_ETHSWT_FAID_TYPE            (0x8701U)    /**< @brief #ETHSWT_FAIDType            */
#define BRCM_SWARCH_ETHSWT_FAMACINFO_TYPE       (0x8702U)    /**< @brief #ETHSWT_FAMacInfoType       */
#define BRCM_SWARCH_ETHSWT_FAREMAP_TYPE         (0x8703U)    /**< @brief #ETHSWT_FARemapType         */
#define BRCM_SWARCH_ETHSWT_FAFLOW_TYPE          (0x8704U)    /**< @brief #ETHSWT_FAFlowType          */
#define BRCM_SWARCH_ETHSWT_FACFG_TYPE           (0x8705U)    /**< @brief #ETHSWT_FACfgType           */
#define BRCM_SWARCH_ETHSWT_FAPOOLINFO_TYPE      (0x8706U)    /**< @brief #ETHSWT_FAPoolTableInfoType */
#define BRCM_SWARCH_ETHSWT_FAFLOWSTATUS_TYPE    (0x8707U)    /**< @brief #ETHSWT_FAFlowStatusType    */
#define BRCM_SWARCH_ETHSWT_FAINIT_PROC          (0x8708U)    /**< @brief #ETHSWT_FAInit              */
#define BRCM_SWARCH_ETHSWT_FADEINIT_PROC        (0x8709U)    /**< @brief #ETHSWT_FADeinit            */
#define BRCM_SWARCH_ETHSWT_FAFLOWADD_PROC       (0x870AU)    /**< @brief #ETHSWT_FAFlowAdd           */
#define BRCM_SWARCH_ETHSWT_FAFLOWDELETE_PROC    (0x870BU)    /**< @brief #ETHSWT_FAFlowDelete        */
#define BRCM_SWARCH_ETHSWT_FAFLOWGET_PROC       (0x870CU)    /**< @brief #ETHSWT_FAFlowGet           */
#define BRCM_SWARCH_ETHSWT_FASTATS_PROC         (0x870DU)    /**< @brief #ETHSWT_FAStats             */
#define BRCM_SWARCH_ETHSWT_FATIMER_PROC         (0x870EU)    /**< @brief #ETHSWT_FATimer             */
#define BRCM_SWARCH_ETHSWT_FAMACADD_PROC        (0x870FU)    /**< @brief #ETHSWT_FAMacAdd            */
#define BRCM_SWARCH_ETHSWT_FAMACDELETE_PROC     (0x8710U)    /**< @brief #ETHSWT_FAMacDelete         */
#define BRCM_SWARCH_ETHSWT_FAMACPOOLGET_PROC    (0x8711U)    /**< @brief #ETHSWT_FAMacPoolGet        */
#define BRCM_SWARCH_ETHSWT_FAENABLEINTR_PROC    (0x8712U)    /**< @brief #ETHSWT_FAEnableInterrupt   */
/** @} */

/**
    @name Hardware ID type
    @{
    @brief Flow Accelerator hardware index type

    @trace #BRCM_SWREQ_ETHSWT_FA_INITIALISATION
*/
typedef uint8_t ETHSWT_FAIDType;       /**< @brief hardware ID type */
#define ETHSWT_FAID_0      (0U)        /**< @brief hardware ID 0    */
/** @} */

/**
    @name ETHSWT_FAMacInfoType
    @{
    @brief FA MAC information Type

    @trace #BRCM_SWREQ_ETHSWT_FA_INITIALISATION
*/
typedef struct COMP_PACKED sETHSWT_FAMacInfoType {
    uint8_t flowMask[ETHSWT_FA_FLOWS_MAX / 8UL]; /**< @brief Flow usage bitmask */
    uint32_t external;          /**< @brief Domain FALSE:internal TRUE:external */
    uint32_t valid;             /**< @brief Entry is valid if TRUE, else invalid */
    uint16_t refCount;          /**< @brief Reference count of flow usage */
    uint8_t mac[6UL];           /**< @brief Mac Address */
} ETHSWT_FAMacInfoType;
/** @} */

/**
    @name ETHSWT_FARemapType
    @brief Flow accelerator Remap type

    @trace #BRCM_SWREQ_ETHSWT_FA_INITIALISATION
 */
typedef struct COMP_PACKED sETHSWT_FARemapType {
    ETHSWT_FAOperationType operation; /**< @brief Operation to be performed on L2 header */
    uint8_t     sa[6];      /**< @brief Remap Source Address */
    uint8_t     da[6];      /**< @brief Remap Destination Address */
    uint16_t    vlan;       /**< @brief Remap VLAN Tag (PCP, DEI & VLAN ID) */
    uint16_t    port;       /**< @brief L4 Remap Port, set to 0 if overwrite is not required */
    uint8_t     ip[16];     /**< @brief Remap IP Address, set to 0 if overwrite is not required */
    ETHSWT_TCType tc;       /**< @brief Traffic Class */
    ETHSWT_TEType te;       /**< @brief Tag Reinforcement */
    uint16_t    portMask;   /**< @brief Portmask. If 0UL, opcode=0 will be used.
                                 Otherwise opcode=1 will be used in Broadcom header/tag */
} ETHSWT_FARemapType;

/**
    @name ETHSWT_FAFlowType
    @{
    @brief Flow accelerator Flow type

    @trace #BRCM_SWREQ_ETHSWT_FA_INITIALISATION
 */
typedef struct COMP_PACKED sETHSWT_FAFlowType {
    ETHSWT_FAMatchType match;   /**< @brief Match parameters of type #ETHSWT_FAMatchType */
    ETHSWT_FARemapType remap;   /**< @brief Replacement paramters of type #ETHSWT_FARemapType */
    ETHSWT_FAFlowValidType valid;   /**< @brief Entry validity type */
} ETHSWT_FAFlowType;
/** @} */


/**
    @name ETHSWT_FACfgType
    @{
    @brief Flow accelerator configuration type

    @trace #BRCM_SWREQ_ETHSWT_FA_INITIALISATION
*/
typedef struct COMP_PACKED sETHSWT_FACfgType {
    UNIMAC_CfgType unimacCfg;     /**< @brief Unimac Configuration */
    ETHSWT_FACtfCfgType ctfCfg;   /**< @brief CTF configuration */
} ETHSWT_FACfgType;
/** @} */

/**
    @name ETHSWT_FAPoolTableInfoType
    @{
    @brief FA Pool table information Type

    @trace #BRCM_SWREQ_ETHSWT_FA_INITIALISATION
*/
typedef struct COMP_PACKED sETHSWT_FAPoolTableInfoType {
    ETHSWT_FAMacInfoType macInfo[ETHSWT_FA_POOL_MAX]; /**< @brief MAC information */
    uint8_t tableUsage;         /**< @brief Count of valid entries */
} ETHSWT_FAPoolTableInfoType;
/** @} */

/**
    @name ETHSWT_FAFlowStatusType
    @{
    @brief Flow Status Type

    @trace #BRCM_SWREQ_ETHSWT_FA_INITIALISATION
 */
typedef struct COMP_PACKED sETHSWT_FAFlowStatusType {          /**< @brief ETHSWT_FAFlowStatus Type*/
    uint8_t activeMask[ETHSWT_FA_FLOWS_MAX / 8UL]; /**< @brief Active Entry bitmask */
    uint8_t staticMask[ETHSWT_FA_FLOWS_MAX / 8UL]; /**< @brief Static Entry bitmask */
} ETHSWT_FAFlowStatusType;
/** @} */

/** @brief Initialize FA

    This API initializes the Flow Accelerator with the given configuration.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  aSwtID      Switch Hardware Instance Identifier
    @param[in]  aFAID       FA Hardware Instance Identifier
    @param[in]  aConfig     Pointer to FA configuration

    @return     void

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHSWT_FA_INITIALISATION
*/
extern void ETHSWT_FAInit(ETHSWT_HwIDType aSwtID, ETHSWT_FAIDType aFAID,
                          const ETHSWT_FACfgType *const aConfig);

/** @brief Deinitialize FA

    This API de-initializes the Flow Accelerator

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  aSwtID      Switch Hardware Instance Identifier
    @param[in]  aFAID       FA Hardware Instance Identifier

    @return     void

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHSWT_FA_INITIALISATION
*/
extern void ETHSWT_FADeinit(ETHSWT_HwIDType aSwtID, ETHSWT_FAIDType aFAID);

/** @brief Add a Flow

    This API adds a new flow into Flow accelerator

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  aSwtID      Switch Hardware Instance Identifier
    @param[in]  aFAID       FA Hardware Instance Identifier
    @param[in]  aFlow       Pointer to flow of type #ETHSWT_FAFlowType
    @param[Out] aFlowID     Pointer to obtain the flow identifier upon success
                            Driver stores the flow identifier upon addition

    Return values are documented in reverse-chronological order
    @retval    #BCM_ERR_OK              Flow added successfully
    @retval    #BCM_ERR_NOMEM           Insufficient memory to add
    @retval    #BCM_ERR_NOT_FOUND       Matching entry not found in Pool table
    @retval    #BCM_ERR_INVAL_STATE     FA is configured in BYPASS mode
    @retval    #BCM_ERR_UNINIT          FA is uninitialised
    @retval    #BCM_ERR_INVAL_PARAMS    Invalid aSwtID OR invalid aFAID OR
                                        aFlow is NULL OR aFlowID is NULL

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHSWT_FA_OPERATIONS
*/
extern int32_t ETHSWT_FAFlowAdd(ETHSWT_HwIDType aSwtID, ETHSWT_FAIDType aFAID,
                                const ETHSWT_FAFlowType *const aFlow,
                                uint16_t *const aFlowID);

/** @brief Delete a Flow

    This API deletes an existing flow from Flow accelerator by providing the
    Flow ID obtained after adding the same.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  aSwtID      Switch Hardware Instance Identifier
    @param[in]  aFAID       FA Hardware Instance Identifier
    @param[in]  aFlowID     Flow ID of the flow to be deleted.

    Return values are documented in reverse-chronological order
    @retval    #BCM_ERR_OK              Flow deleted successfully
    @retval    #BCM_ERR_NOPERM          Permission denied(#ETHSWT_FAFLOWVALID_TILLREBOOT)
    @retval    #BCM_ERR_UNINIT          FA is uninitialised
    @retval    #BCM_ERR_INVAL_PARAMS    Invalid aSwtID OR invalid aFAID OR aFlowID is invalid

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHSWT_FA_OPERATIONS
*/
extern int32_t ETHSWT_FAFlowDelete(ETHSWT_HwIDType aSwtID, ETHSWT_FAIDType aFAID,
                                   const uint16_t aFlowID);

/** @brief Flow Get

    This API retrieves flow parameters pertaining to a Flow ID

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  aSwtID      Switch Hardware Instance Identifier
    @param[in]  aFAID       FA Hardware Instance Identifier
    @param[in]  aFlowID     Flow ID of the flow
    @param[out] aFlow       Pointer to retrieve flow parameters, to be updated by driver
                            aFlow->match.da will be valid only if
                            validateMatchDA was TRUE during initialisation
    @param[out] aFlowStats  Pointer to retrieve flow statistics, to be updated by driver

    Return values are documented in reverse-chronological order
    @retval    #BCM_ERR_OK              Flow parameters obtained successfully
    @retval    #BCM_ERR_UNINIT          FA is uninitialised
    @retval    #BCM_ERR_INVAL_PARAMS    Invalid aSwtID OR invalid aFAID OR
                                        aFlowID is invalid OR
                                        aFlow is NULL OR aFlowStats is NULL

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHSWT_FA_QUERY
*/
extern int32_t ETHSWT_FAFlowGet(ETHSWT_HwIDType aSwtID, ETHSWT_FAIDType aFAID,
                                const uint16_t aFlowID,
                                ETHSWT_FAFlowType *const aFlow,
                                ETHSWT_FAFlowStatsType *const aFlowStats);

/** @brief Retrieve statistics

    This API retrieves statistics from Flow accelerator

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  aSwtID      Switch Hardware Instance Identifier
    @param[in]  aFAID       FA Hardware Instance Identifier
    @param[out] aStats      Pointer to statistics structure of type
                            #ETHSWT_FAStatsType to be filled by the driver
    @param[out] aFlowStatus Pointer to statistics structure of type
                            #ETHSWT_FAFlowStatusType to be filled by the driver

    Return values are documented in reverse-chronological order
    @retval    #BCM_ERR_OK              Statistics retrieved successfully
    @retval    #BCM_ERR_UNINIT          FA is uninitialised
    @retval    #BCM_ERR_INVAL_PARAMS    Invalid aSwtID OR invalid aFAID OR
                                        aStats is NULL OR aFlowStatus is NULL

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHSWT_FA_QUERY
*/
extern int32_t ETHSWT_FAStats(ETHSWT_HwIDType aSwtID, ETHSWT_FAIDType aFAID,
                              ETHSWT_FAStatsType *const aStats,
                              ETHSWT_FAFlowStatusType *const aFlowStatus);

/** @brief Periodic Timer

    This API handles the periodic timer meant for managing timestamp

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  aSwtID      Switch Hardware Instance Identifier
    @param[in]  aFAID       FA Hardware Instance Identifier

    Return values are documented in reverse-chronological order
    @retval    #BCM_ERR_OK              Timer event processed successfully
    @retval    #BCM_ERR_UNINIT          FA is uninitialised
    @retval    #BCM_ERR_INVAL_PARAMS    Invalid aSwtID OR invalid aFAID

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHSWT_FA_OPERATIONS
*/
extern int32_t ETHSWT_FATimer(ETHSWT_HwIDType aSwtID, ETHSWT_FAIDType aFAID);

/** @brief Add Pool table entry

    This API will add a pool table entry

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  aSwtID      Switch Hardware Instance Identifier
    @param[in]  aFAID       FA Hardware Instance Identifier
    @param[in]  aMac        Pointer to MAC address
    @param[in]  aExternal   TRUE:External MAC
                            FALSE: Internal MAC

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK           Successfully added or same exists already
    @retval     #BCM_ERR_NOMEM        No memory available to add a new entry
    @retval     #BCM_ERR_NOPERM       No permission to overwrite existing MAC
                                      with different "external" field
    @retval     #BCM_ERR_INVAL_STATE  FA is configured in BYPASS mode
    @retval     #BCM_ERR_UNINIT       FA is uninitialised
    @retval     #BCM_ERR_INVAL_PARAMS Invalid aSwtID OR invalid aFAID OR
                                      aMac is NULL OR MAC address is all 0s OR
                                      aExternal is neither TRUE nor FALSE

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHSWT_FA_OPERATIONS
*/
extern int32_t ETHSWT_FAMacAdd(ETHSWT_HwIDType aSwtID, ETHSWT_FAIDType aFAID,
                               const uint8_t *const aMac,
                               uint32_t aExternal);

/** @brief Delete Pool table entry

    This API will will delete a pool table entry if it is no more referenced by
    any of the flows.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]    aSwtID      Switch Hardware Instance Identifier
    @param[in]    aFAID       FA Hardware Instance Identifier
    @param[in]    aMac        Pointer to MAC address

    Return values are documented in reverse-chronological order
    @retval    #BCM_ERR_OK              Entry deleted successfully
    @retval    #BCM_ERR_BUSY            Entry cannot be deleted as it is in use
    @retval    #BCM_ERR_NOT_FOUND       Entry not found
    @retval    #BCM_ERR_INVAL_STATE     FA is configured in BYPASS mode
    @retval    #BCM_ERR_UNINIT          FA is uninitialised
    @retval    #BCM_ERR_INVAL_PARAMS    Invalid aSwtID OR invalid aFAID OR
                                        aMac is NULL

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHSWT_FA_OPERATIONS
*/
extern int32_t ETHSWT_FAMacDelete(ETHSWT_HwIDType aSwtID, ETHSWT_FAIDType aFAID,
                                  const uint8_t *const aMac);

/** @brief Get Pool Table MAC addresses

    This API will retrieve Pool Table MAC addresses, their domain(internal/
    external) and their usage as a bitmask of flow IDs

    @behavior Sync, Re-entrant

    @pre None

    @param[in]    aSwtID            Switch Hardware Instance Identifier
    @param[in]    aFAID             FA Hardware Instance Identifier
    @param[out]   aPoolTableInfo    Pointer to retrieve Pool table information

    Return values are documented in reverse-chronological order
    @retval   #BCM_ERR_OK           Successfully retrieved MAC addresses
    @retval   #BCM_ERR_UNINIT       FA is uninitialised
    @retval   #BCM_ERR_INVAL_PARAMS Invalid aSwtID OR invalid aFAID OR
                                    aPoolTableInfo is NULL

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHSWT_FA_QUERY
*/
extern int32_t ETHSWT_FAMacPoolGet(ETHSWT_HwIDType aSwtID,
                                   ETHSWT_FAIDType aFAID,
                                   ETHSWT_FAPoolTableInfoType *const aPoolTableInfo);

/** @brief Enable Interrupts

    This API will enable interrupts

    @behavior Sync, Re-entrant

    @pre None

    @param[in]    aSwtID            Switch Hardware Instance Identifier
    @param[in]    aFAID             FA Hardware Instance Identifier
    @param[out]   aFlags            Flag mask of interrupts to be enabled

    Return values are documented in reverse-chronological order
    @retval   #BCM_ERR_OK           Successfully enabled interrupts
    @retval   #BCM_ERR_UNINIT       FA is uninitialised
    @retval   #BCM_ERR_NOPERM       No permission when CTF is in BYPASS Mode
    @retval   #BCM_ERR_INVAL_PARAMS Invalid aSwtID OR invalid aFAID

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHSWT_FA_OPERATIONS
*/
extern int32_t ETHSWT_FAEnableInterrupt(ETHSWT_HwIDType aSwtID,
                                        ETHSWT_FAIDType aFAID,
                                        ETHSWT_FAIntrFlagsType aFlags);

#endif /* ETHSWT_FA_H */

/** @} */
