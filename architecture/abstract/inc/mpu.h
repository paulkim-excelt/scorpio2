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
    @defgroup grp_mpu_abstract MPU Abstraction interface
    @ingroup grp_abstract

    @addtogroup grp_mpu_abstract
    @{

    @file mpu.h
    @brief This file contains MPU Abstraction API interfaces

    @version 0.1 Initial Version
*/
#ifndef MPU_H
#define MPU_H

/**
    @name MPU Table Architecture IDs
    @{
    @brief Architecture IDs for MPU Table
*/
#define BRCM_SWARCH_MPU_REGION_ATTR_TYPE        (0x8B00U)   /**< @brief #MPU_RegionAttrType     */
#define BRCM_SWARCH_MPU_REGION_DESC_TYPE        (0x8B01U)   /**< @brief #MPU_RegionDescType     */
#define BRCM_SWARCH_MPU_ENABLE_PROC             (0x8B02U)   /**< @brief #MPU_Enable             */
#define BRCM_SWARCH_MPU_DISABLE_PROC            (0x8B03U)   /**< @brief #MPU_Disable            */
#define BRCM_SWARCH_MPU_CONFIGURE_REGION_PROC   (0x8B04U)   /**< @brief #MPU_ConfigureRegion    */
#define BRCM_SWARCH_MPU_GET_REGION_ATTR_PROC    (0x8B05U)   /**< @brief #MPU_GetRegionAttr      */
/** @} */


/** @brief MPU region attributes

    The interpretation of the bits in this datatype instance
    is platform specific.

    @trace #BRCM_SWREQ_MPU_ABSTRACTION
*/
typedef uint32_t MPU_RegionAttrType;

/** @brief MPU region description type

    @trace #BRCM_SWREQ_MPU_ABSTRACTION
*/
typedef struct sMPU_RegionDescType {
    uint32_t baseAddr;              /**< @brief Region base address     */
    MPU_RegionAttrType regionAttr;  /**< @brief Region attributes       */
} MPU_RegionDescType;

/** @brief Enable the MPU

    @behavior Sync, Reentrant

    @pre CPU is at the appropriate privilage level

    @return void

    @post MPU enabled

    @trace #BRCM_SWREQ_MPU_ABSTRACTION
*/
void MPU_Enable(void);

/** @brief Disable the MPU

    @behavior Sync, Reentrant

    @pre CPU is at the appropriate privilage level

    @return void

    @post MPU disabled

    @trace #BRCM_SWREQ_MPU_ABSTRACTION
*/
void MPU_Disable(void);

/** @brief Setup an MPU region

    The region priority (if the MPU implements them) is assumed to increase
    with increasing region index number.

    @behavior Sync, Reentrant

    @pre CPU is at the appropriate privilage level, MPU disabled

    @param[in]      aRegionIdx              MPU region index
    @param[in]      aRegionDesc             MPU region configuration params

    Return values are documented in reverse-chronological order
    @retval         #BCM_ERR_INVAL_PARAMS   aRegionIdx invalid
                                            aRegionConfig is NULL or has invalid
                                            content
    @retval         #BCM_ERR_OK             MPU region configured

    @post None

    @trace #BRCM_SWREQ_MPU_ABSTRACTION
*/
int32_t MPU_ConfigureRegion(const uint32_t aRegionIdx, const MPU_RegionDescType *const aRegionDesc);

/** @brief Compute MPU region attribute given a region size

    @behavior Sync, Reentrant

    @pre None

    @param[in]      aRegionSize             Desired size of the MPU region
    @param[out]     aRegionAttr             Computed region attribute

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_INVAL_PARAMS       aRegionAttr is NULL or unsupported aRegionSize
    @retval     #BCM_ERR_OK                 Region attribute computation sucessful

    @post None

    @trace #BRCM_SWREQ_MPU_ABSTRACTION
*/
int32_t MPU_GetRegionAttr(const uint32_t aRegionSize, MPU_RegionAttrType *const aRegionAttr);

#endif /* MPU_H */
/** @} */

