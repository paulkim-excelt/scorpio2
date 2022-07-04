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
    @defgroup grp_ethswt_cfp_inter_ifc CFP driver internal interface
    @ingroup grp_ethswt

    @addtogroup grp_ethswt_cfp_inter_ifc
    @{

    @file cfp_drv.h

    @brief CFP driver interface

    @version 0.1 Initial version

*/
#ifndef CFP_DRV_H
#define CFP_DRV_H

#include <stdint.h>
#include <ethswt_cfp.h>

/**
    @name CFP driver Architecture IDs
    @{
    @brief Architecture IDs for CFP driver
*/
#define BRCM_SWARCH_ETHSWT_CFP_UDFQUEUEENTRY_TYPE       (0x8101U)    /**< @brief #ETHSWT_CFPUDFQueueEntryType */
#define BRCM_SWARCH_ETHSWT_CFP_DRVFINDSLICE_PROC        (0x8102U)    /**< @brief #ETHSWT_CFPDrvFindSlice      */
#define BRCM_SWARCH_ETHSWT_CFP_DRVVALIDATEKEY_PROC      (0x8103U)    /**< @brief #ETHSWT_CFPDrvValidateKey    */
#define BRCM_SWARCH_ETHSWT_CFP_DRVPROGRAMTCAM_PROC      (0x8104U)    /**< @brief #ETHSWT_CFPDrvProgramTCAM    */
#define BRCM_SWARCH_ETHSWT_CFP_DRVGETKEY_PROC           (0x8105U)    /**< @brief #ETHSWT_CFPDrvGetKey         */
#define BRCM_SWARCH_ETHSWT_CFP_DRVSETRULEVALID_PROC     (0x8106U)    /**< @brief #ETHSWT_CFPDrvSetRuleValid   */
#define BRCM_SWARCH_ETHSWT_CFP_DRVWAITFORACCESS_PROC    (0x8107U)    /**< @brief #ETHSWT_CFPDrvWaitForAccess  */
#define BRCM_SWARCH_ETHSWT_CFP_DRVPROGRAMUDFS_PROC      (0x8108U)    /**< @brief #ETHSWT_CFPDrvProgramUDFs    */
#define BRCM_SWARCH_ETHSWT_CFP_DRVSETTBLSIZE_PROC       (0x8109U)    /**< @brief #ETHSWT_CFPDrvSetTblSize     */
#define BRCM_SWARCH_ETHSWT_CFPTBLSIZE_TYPE              (0x810AU)    /**< @brief #ETHSWT_CFPTblSizeType       */
/** @} */

/**
    @brief Structure for UDF Scratch Queue
    This stores the temporary information during UDF allocation for a rule in
    a particular slice.

    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION
*/
typedef struct sETHSWT_CFPUDFQueueEntryType {
    uint32_t value;   /**< @brief Value of the UDF */
    uint32_t mask;    /**< @brief Mask of the UDF */
    uint8_t  enable;  /**< @brief Flag indicating whether the
                           UDF is enabled or not */
    uint8_t  created; /**< @brief Flag indicating whether the UDF
                           is already allocated or not */
    uint8_t  address; /**< @brief Address (base and offset) of the UDF */
} ETHSWT_CFPUDFQueueEntryType;

/**
    @name ETHSWT_CFPTableSizeType
    @{
    @brief Definitions for dynamic modification of CFP table size

    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION
*/
typedef uint16_t ETHSWT_CFPTblSizeType;                                   /**< @brief typedef for color */
#define ETHSWT_CFPTBLSIZE_RESTRICTED   (ETHSWT_CFP_MAX_RULES_RESTRICTED) /**< @brief Reduced Table size based on platform */
#define ETHSWT_CFPTBLSIZE_MAX          (ETHSWT_CFP_MAX_RULES)            /**< @brief Maximum table size */
/** @} */

/** @brief Find a free slice for UDFs of a rule to be programmed

    @behavior Sync, Re-entrant

    @pre None

    @param[in]     aID              Switch index
    @param[in]     aKey             Pointer to key configuration
    @param[inout]  aSlice           Slice number
    @param[inout]  aActiveUDFList   List of programmed UDFs
    @param[out]    aProgramUDFQ     List of UDFs that need to be programmed
                                    based on the identified slice

    Return values are documented in reverse-chronological order
    @retval  #BCM_ERR_OK            Slice with free UDFs fetched successfully
    @retval  #BCM_ERR_NOMEM         No space in any slice for the UDFs of rule

    @post None

    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION
*/
extern int32_t ETHSWT_CFPDrvFindSlice(ETHSWT_HwIDType aID,
                                      const ETHSWT_CFPKeyType* const aKey,
                                      uint32_t* const aSlice,
                                      ETHSWT_CFPUDFAllocListType *const aActiveUDFList,
                                      ETHSWT_CFPUDFQueueEntryType *const aProgramUDFQ);

/** @brief Validate key configuration

    @behavior Sync, Re-entrant

    @pre None

    This API checks the input parameters in the key configuration and reports
    any errors

    @param[in]     aID               Switch index
    @param[in]     aKey              CFP Key

    Return values are documented in reverse-chronological order
    @retval  #BCM_ERR_OK             Rule is valid
    @retval  #BCM_ERR_INVAL_PARAMS   Returned if any of the following fields are
                                     invalid
                                         - cTagFlags/sTagFlags
                                         - l2Framing
                                         - l3Framing
                                         - numEnabledUDFs
                                         - UDF base
    @retval  #BCM_ERR_NOMEM           CFP TCAM is full

    @post None

    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION

    @limitations None
*/
extern int32_t ETHSWT_CFPDrvValidateKey(ETHSWT_HwIDType aID,
                                        const ETHSWT_CFPKeyType* const aKey);

/** @brief Program the CFP key in the TCAM

    @behavior Sync, Re-entrant (for different switch index)

    @pre None

    This API programs the row in the TCAM for the given config

    @param[in]     aID               Switch index
    @param[in]     aRow              Row number
    @param[in]     aSlice            Slice number
    @param[in]     aKey              Pointer to key configuration
    @param[in]     aProgramUDFQ      UDF entries to be programmed for #aRow

    Return values are documented in reverse-chronological order
    @retval  #BCM_ERR_OK             Row programmed successfully in TCAM
    @retval  #BCM_ERR_INVAL_PARAMS   Register or L3 framing type is invalid
    @retval  #BCM_ERR_TIME_OUT       CFP/Switch Register access timed out

    @post None

    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION

    @limitations None
*/
extern int32_t ETHSWT_CFPDrvProgramTCAM(ETHSWT_HwIDType aID,
                                        uint32_t aRow,
                                        uint32_t aSlice,
                                        const ETHSWT_CFPKeyType* const aKey,
                                        const ETHSWT_CFPUDFQueueEntryType *const aProgramUDFQ);

/** @brief CFP Get key configuration for specified row

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aID             Switch Index
    @param[in]      aRow            Row number
    @param[out]     aKey            Pointer to key structure
    @param[out]     aSlice          Pointer to slice information
    @param[in]      aUDFBaseAddr    Base address of UDF register

    Return values are documented in reverse-chronological order
    @retval         #BCM_ERR_OK             On success
    @retval         #BCM_ERR_INVAL_PARAMS   If aKey has invalid params
    @return         Others                  As returned by #ETHSWT_DrvReadReg

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHSWT_QUERY
*/
extern int32_t ETHSWT_CFPDrvGetKey(ETHSWT_HwIDType aID,
                                   uint32_t aRow,
                                   ETHSWT_CFPKeyType *const aKey,
                                   uint16_t *const aSlice,
                                   volatile uint8_t *aUDFBaseAddr);

/** @brief Enable/Disable rule by setting/clearing the TCAM valid bit

    @behavior Sync, Re-entrant (for different switch index)

    @pre None

    This API enables/disables the rule at the input row. This is done by
    setting the TCAM row valid bit during rule enable and resetting the valid
    bit to zero during rule disable.

    @param[in]     aID               Switch index
    @param[in]     aRow              Row number of the rule
    @param[in]     aEnable           Flag indicating whether the rule needs
                                     to be enabled or disabled

    Return values are documented in reverse-chronological order
    @retval  #BCM_ERR_OK             Rule enabled/disabled successfully
    @retval  #BCM_ERR_INVAL_PARAMS   Register is invalid
    @retval  #BCM_ERR_TIME_OUT       CFP/Switch Register access timed out

    @post None

    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION

    @limitations None
*/
extern int32_t ETHSWT_CFPDrvSetRuleValid(ETHSWT_HwIDType aID,
                                         uint32_t aRow, uint32_t aEnable);

/** @brief Wait for CFP access operation to complete

    @behavior Sync, Re-entrant (for different switch index)

    @pre None

    This API waits for a CFP operation to complete within a stipulated time.

    @param[in]     aID               Switch index

    Return values are documented in reverse-chronological order
    @retval  #BCM_ERR_OK             Operation completed successfully
    @retval  #BCM_ERR_INVAL_PARAMS   Register is invalid
    @retval  #BCM_ERR_TIME_OUT       CFP/Switch Register access timed out

    @post None

    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION

    @limitations None
*/
extern int32_t ETHSWT_CFPDrvWaitForAccess(ETHSWT_HwIDType aID);

/** @brief Program the global UDFs

    @behavior Sync, Re-entrant (for different switch index)

    @pre None

    This API programs the newly allocated global UDFs for a particular slice and
    format.

    @param[in]     aID               Switch index
    @param[in]     aFormat           CFP Format
    @param[in]     aSlice            Slice number
    @param[in]     aUDFBaseAddr      UDF base address to be used for
                                     programming the entries
    @param[out]    aProgramUDFQ      List of UDFs that need to be programmed

    Return values are documented in reverse-chronological order
    @retval  #BCM_ERR_OK             UDFs programmed successfully
    @retval  #BCM_ERR_INVAL_PARAMS   Register is invalid
    @retval  #BCM_ERR_TIME_OUT       Switch Register access timed out

    @post None

    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION

    @limitations None
*/
extern int32_t ETHSWT_CFPDrvProgramUDFs(ETHSWT_HwIDType aID,
                                        uint32_t aFormat,
                                        uint32_t aSlice,
                                        volatile uint8_t* aUDFBaseAddr,
                                        const ETHSWT_CFPUDFQueueEntryType *const aProgramUDFQ);

/** @brief Set table size for CFP

    @behavior Sync, Re-entrant (for different switch index)

    @pre Switch driver and CFP is initialized

    This API shall be used to restrict the number of TCAM rows that
    CFP module can use. Please refer to TRM for number of available
    TCAM rows on any platform.

    @param[in]     aID               Switch index
    @param[in]     aTblSize          Table size value

    Return values are documented in reverse-chronological order
    @retval  #BCM_ERR_OK             Table size set successfully
    @retval  #BCM_ERR_NOMEM          CFP is already using the rows exceeding the
                                     table size limit imposed by #aTblSize.
    @retval  #BCM_ERR_INVAL_PARAMS   #aID is invalid or #aTblSize is invalid
    @retval  #BCM_ERR_INVAL_STATE    CFP is not in initialized state

    @post None

    @trace #BRCM_SWREQ_ETHSWT_DYNAMIC_CONFIGURATION

    @limitations None
*/
int32_t ETHSWT_CFPDrvSetTblSize(ETHSWT_HwIDType aID,
                                ETHSWT_CFPTblSizeType aTblSize);

#endif /* CFP_DRV_H */
/** @} */

