/*****************************************************************************
 Copyright 2019-2020 Broadcom Limited.  All rights reserved.

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
    @addtogroup grp_imgl_osil_ifc
    @{

    @file imgl_version.c
    @brief Image Loader Integration
    This source file contains the integration of Iamge Loader
    @version 0.1 Initial version
*/

#include <stddef.h>
#include <imgl_osil.h>

/**
    @name IMGL osil Design IDs
    @{
    @brief Design IDs for IMGL osil
*/
#define BRCM_SWDSGN_IMGL_VERSION_COMPARE_PROC          (0xA301U)    /**< @brief #IMGL_VersionCompare      */
#define BRCM_SWDSGN_IMGL_IS_VERSION_COMPATIBLE_PROC    (0xA302U)    /**< @brief #IMGL_IsVersionCompatible */
/** @} */

/**
    @note This is a reference implementation only
    @trace #BRCM_SWARCH_IMGL_VER_CMP_PROC
    @trace #BRCM_SWREQ_IMGL_VERSION
*/
IMGL_VerCmpResultType IMGL_VersionCompare(const IMGL_VersionType* const aNewVersion,
                                          const IMGL_VersionType* const aOldVersion)
{
    IMGL_VerCmpResultType result;
    if (aNewVersion->major < aOldVersion->major) {
        result = IMGL_VER_CMP_RESULT_LOWER;
    } else if (aNewVersion->major > aOldVersion->major) {
        result = IMGL_VER_CMP_RESULT_HIGHER;
    } else if (aNewVersion->minor < aOldVersion->minor) {
        result = IMGL_VER_CMP_RESULT_LOWER;
    } else if (aNewVersion->minor > aOldVersion->minor) {
        result = IMGL_VER_CMP_RESULT_HIGHER;
    } else {
        result = IMGL_VER_CMP_RESULT_MATCH;
    }
    return result;
}

/**
    @note This is a reference implementation only
    @trace #BRCM_SWARCH_IMGL_IS_VER_COMPATIBLE_PROC
    @trace #BRCM_SWREQ_IMGL_VERSION
*/
int32_t IMGL_IsVersionCompatible(const IMGL_VersionType* const aVersion1,
                                 const IMGL_VersionType* const aVersion2)
{
    return BCM_ERR_OK;
}
/** @} */
