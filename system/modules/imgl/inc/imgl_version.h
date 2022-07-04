/*****************************************************************************
 Copyright 2020 Broadcom Limited.  All rights reserved.

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

/** @defgroup grp_imgl_version_ifc Version Interface
    @ingroup grp_imgl

    @addtogroup grp_imgl_version_ifc
    @{
    Version information and comtability checks for the images.

    @file imgl_version.h
    @brief Image version Interfaces
    @version 0.1 Initial Version
*/

#ifndef IMGL_VERSION_H
#define IMGL_VERSION_H

#include <bcm_err.h>
#include <stdint.h>

/**
    @name Image version Integration Interface IDs
    @{
    @brief Integration Interface IDs for Image version

*/
#define BRCM_SWARCH_IMGL_VERSION_MAGIC_MACRO       (0x8401U)    /**< @brief #IMGL_VERSION_MAGIC       */
#define BRCM_SWARCH_IMGL_VERSION_TYPE              (0x8402U)    /**< @brief #IMGL_VersionType         */
#define BRCM_SWARCH_IMGL_VER_CMP_RESULT_TYPE       (0x8403U)    /**< @brief #IMGL_VerCmpResultType    */
#define BRCM_SWARCH_IMGL_VER_CMP_PROC              (0x8404U)    /**< @brief #IMGL_VersionCompare      */
#define BRCM_SWARCH_IMGL_IS_VER_COMPATIBLE_PROC    (0x8405U)    /**< @brief #IMGL_IsVersionCompatible */
/** @} */

/**
    @brief Image version magic

    @trace #BRCM_SWREQ_IMGL_VERSION
*/
#define IMGL_VERSION_MAGIC           (0x56455253UL)

#pragma pack(push, 4)
/**
    @brief Version type

    Version information

    @trace #BRCM_SWREQ_IMGL_VERSION
 */
typedef struct sIMGL_VersionType {
    uint32_t              magic;           /**< @brief Magic VERS #IMGL_VERSION_MAGIC */
    uint32_t              major;           /**< @brief Major version number */
    uint32_t              minor;           /**< @brief Minor version number */
    uint8_t               tag[64UL];       /**< @brief Tag string */
    uint8_t               buildInfo[52UL]; /**< @brief Server name, user name, date and time */
} IMGL_VersionType;

#pragma pack(pop)

/**
    @name Image version comparasion result type
    @{
    @brief Image version comparasion result type

    @trace #BRCM_SWREQ_IMGL_VERSION
*/
typedef int32_t IMGL_VerCmpResultType;  /**< @brief Load Mode Type         */
#define IMGL_VER_CMP_RESULT_UNKNOWN  (-2L) /**< @brief Unknown             */
#define IMGL_VER_CMP_RESULT_LOWER    (-1L) /**< @brief Lower version       */
#define IMGL_VER_CMP_RESULT_MATCH    (0L)  /**< @brief Matched version     */
#define IMGL_VER_CMP_RESULT_HIGHER   (1L)  /**< @brief Higher version      */
/** @} */


/** @brief Version comparision

    Compares the aNewVersion w.r.t to aOldVersion.

   @behavior Sync, Non-reentrant

   @pre None

   @param[in]       aNewVersion          Pointer to new version
   @param[in]       aOldVersion          Pointer to old version

   Return values are documented in reverse-chronological order
   @return     #IMGL_VER_CMP_RESULT_MATCH             (aNewVersion is match with aOldVersion) or
                                                      (aNewVersion is NULL and aOldVersion is NULL) or
                                                      (aNewVersion is not valid and aOldVersion is not valid)
   @return     #IMGL_VER_CMP_RESULT_LOWER             (aNewVersion is lower compared to aOldVersion) or
                                                      (aNewVersion is NULL) or
                                                      (aNewVersion is not valid)
   @return     #IMGL_VER_CMP_RESULT_HIGHER            (aNewVersion is higher compared to aOldVersion) or
                                                      (aOldVersion is NULL) or
                                                      (aOldVersion is not valid)
   @return     #IMGL_VER_CMP_RESULT_UNKNOWN           (aNewVersion tag is not same as aOldVersion tag)

   @post None

   @trace  #BRCM_SWREQ_IMGL_VERSION
*/
IMGL_VerCmpResultType IMGL_VersionCompare(const IMGL_VersionType* const aNewVersion,
                                          const IMGL_VersionType* const aOldVersion);

/** @brief Version compatibility check

    Compatability of aVersion2 w.r.t to aVersion1

   @behavior Sync, Non-reentrant

   @pre None

   @param[in]       aVersion1            Pointer to version 1
   @param[in]       aVersion2            Pointer to version 2


   Return values are documented in reverse-chronological order
   @retval     #BCM_ERR_OK             aVersion2 is compatible with aVersion1
   @retval     #BCM_ERR_NOSUPPORT      aVersion2 is not compatible with aVersion1
   @retval     #BCM_ERR_INVAL_PARAMS   (aVersion1 is NULL) or
                                       (aVersion2 is NULL)

   @post None

   @trace  #BRCM_SWREQ_IMGL_VERSION
*/
int32_t IMGL_IsVersionCompatible(const IMGL_VersionType* const aVersion1,
                                 const IMGL_VersionType* const aVersion2);

#endif /* IMGL_VERSION_H */
/** @} */
