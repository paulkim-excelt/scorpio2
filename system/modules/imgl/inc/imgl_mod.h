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
    @defgroup grp_imgl_mod_ifc IMGL modules interface
    @ingroup grp_imgl

    @addtogroup grp_imgl_mod_ifc
    @{

    @limitations None

    @file imgl_mod.h

    @brief IMGL Module interface function headers

    This file contains the interface function definitions for IMGL modules

    @version 0.1 initial version
*/
#ifndef IMGL_MOD_H
#define IMGL_MOD_H

#include <stdint.h>
#include <module.h>

/**
    @name IMGL Modules Architecture IDs
    @{
    @brief Architecture IDs for IMGL Modules
*/
#define BRCM_SWARCH_IMGL_FETCH_MOD_GLOBAL          (0x8701U)    /**< @brief #IMGL_FetchModule            */
#define BRCM_SWARCH_IMGL_UPDATE_MOD_GLOBAL         (0x8702U)    /**< @brief #IMGL_UpdateModule           */
#define BRCM_SWARCH_IMGL_GET_ENTRY_POINT_PROC      (0x8703U)    /**< @brief #IMGL_GetEntryPt             */
/** @} */

/**
    @brief Global stucture to store IMGL fetch module parameter.

    This Module should be listed in Platform module Info structure array.
    #SYSTEM_NvmModule & #SYSTEM_EthSrvModule should be listed first.

    @trace #BRCM_SWREQ_IMGL_CORE
*/
extern const MODULE_Type IMGL_FetchModule;

/**
    @brief Global stucture to store IMGL update module parameter.

    This Module should be listed in Platform module Info structure array.
    #SYSTEM_NvmModule & #SYSTEM_EthSrvModule should be listed first.

    @trace #BRCM_SWREQ_IMGL_CORE
*/
extern const MODULE_Type IMGL_UpdateModule;

/** @brief Returns the executable entry point

    Returns the executable entry point. This could be NULL if not set by the module

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]     aEntryPt Pointer to store the entry point

    Return values are documented in reverse-chronological order
    @retval     BCM_ERR_OK             Valid Entry point.
    @retval     BCM_ERR_NOT_FOUND      Invalid Entry point.

    @post None

    @note None

    @trace #BRCM_SWREQ_IMGL_CORE

    @limitations None
*/
int32_t IMGL_GetEntryPt(IMGL_EntryPtType *aEntryPt);

#endif /* IMGL_MOD_H */
/** @} */
