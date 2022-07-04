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
    @defgroup grp_pchdrv_ifc Interface
    @ingroup grp_pchdrv

    @addtogroup grp_pchdrv_ifc
    @{
    @section sec_pchdrv_overview Overview

    Patch driver provides APIs for loading and executing patch routines
    stored in the NVM.

    @limitations None

    @file pchdrv.h
    @brief Interfaces for Patch driver
    This header file  defines interface for Patch driver.

    @version 0.1 Initial version
*/

#ifndef PCHDRV_H
#define PCHDRV_H

#include <bcm_err.h>

/**
    @name Patch driver API IDs
    @{
    @brief API IDs for Patch driver
 */
#define BRCM_SWARCH_PATCH_INIT_PROC         (0x8101U)  /**< @brief #PATCH_Init            */
#define BRCM_SWARCH_PATCH_EXEC_SEQ_PROC     (0x8102U)  /**< @brief #PATCH_ExecPatchSeq    */
#define BRCM_SWARCH_PATCH_DEINIT_PROC       (0x8103U)  /**< @brief #PATCH_DeInit          */
/** @} */

/** @brief Initialize the patch driver

   Parses the given patch image, loads all the patch routines to the
   execution memory and updates the patch sequences info in the
   data structure.

   @behavior Sync, Non re-entrant

   @pre Patch driver initialized

   @param[in]  aPatchData  Patch image data
   @param[out] aNumWords   Number of words in the patch image data

   Return values are documented in reverse-chronological order

   @retval  #BCM_ERR_OK            Patch routine added successfully
   @retval  #BCM_ERR_INVAL_STATE   Patch driver already initialized
   @retval  #BCM_ERR_INVAL_PARAMS  aPatchData is NULL or aNumWords is too small
   @retval  #BCM_ERR_DATA_INTEG    Error while parsing the patch image

   @post returns the size information of the patch routine

   @trace #BRCM_SWREQ_PATCH

   @limitations Does not validate overlapping load addresses. In case of overlap,
                the latest one overwrites the former one.
 */
int32_t PATCH_Init(uint32_t const aPatchImg[], uint16_t aNumWords);

/** @brief Execute a Patch Sequence

   Executes the Patch Sequence referred by the given component and patch id.
   The patch is always executed in privileged mode but this API can be called from
   privileged or un-privileged context.

   @behavior Sync, Non re-entrant

   @pre Patch image is loaded using PATCH_LoadPatchImage()

   @param[in]   aCompId        Component ID
   @param[in]   aPatchId       Unique patch ID

   Return values are documented in reverse-chronological order

   @retval  #BCM_ERR_OK           Patch sequence executed successfully
   @retval  #BCM_ERR_NOT_FOUND    aCompId, aPatchId combination not found
   @retval  #BCM_ERR_UNINIT       Driver not initialized
   @retval  #BCM_ERR_UNKNOWN      Integration error

   @post Given patch sequence is executed

   @trace #BRCM_SWREQ_PATCH

   @limitations This function uses linear search for finding the patch. For 64
                patch sequences (the max allowed), the linear search takes about
                2.2us while the binary search takes about 1.1us.
 */
int32_t PATCH_ExecPatchSeq(uint16_t aCompId, uint8_t aPatchId);

/** @brief De-Initialize Patch driver

   De-Initialize Patch driver

   @behavior Sync, Non re-entrant

   @pre None

   Return values are documented in reverse-chronological order

   @retval  #BCM_ERR_OK           Patch driver initialized successful
   @retval  #BCM_ERR_UNINIT       Driver not initialized

   @post Patch driver deinitialized

   @trace #BRCM_SWREQ_PATCH

   @limitations None

 */
int32_t PATCH_DeInit(void);

#endif /* PCHDRV_H */

/** @} */
