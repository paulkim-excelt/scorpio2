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

/** @defgroup grp_module_il Integration Guide
    @ingroup grp_module

    @addtogroup grp_module_il
    @{

    @file module_osil.h
    @brief Integration for Generic Module

    @version 0.1 Initial version
*/

#ifndef MODULE_OSIL_H
#define MODULE_OSIL_H

#include <inttypes.h>
#include <module.h>

/**
    @name System Integration Interface IDs
    @{
    @brief Integration Interface IDs for System

*/
#define BRCM_SWARCH_MODULE_EVENT_GLOBAL     (0x9101U)   /**< @brief #MODULE_Event   */
#define BRCM_SWARCH_MODULE_LOAD_CFG_PROC    (0x9102U)   /**< @brief #MODULE_LoadCfg */
/** @} */

/** @brief Global to translate the OS event to U32 for various module operation

    This event is used for
    -# configuration image loading notifications
    -# message notifications (commands/responses etc)
    -# Other events specific to the module (should be light weight)

    @trace #BRCM_SWREQ_MODULE
*/
extern const uint32_t MODULE_Event;

/** @brief Load the module configuration image

    Initiate and load the configuration image for the module.

    This API gets executed in the context of the Caller task.

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]   aModEntry           Pointer to module function table entry

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK          Configuration fetched successfully
    @retval     #BCM_ERR_BUSY        API needs to be invoked again (on an event)
    @retval     #BCM_ERR_UNKNOWN     Error from IMGL_* APIs


    @post This function updates the 'imglState' present in module context
    to BCM_STATE_SUB_STATE_STAGE0 when image load is in progress. If this API
    returns and imglState is BCM_STATE_SUB_STATE_RESET, then it indicates that
    the image was loaded successfully or there was an error in loading.

    @limitations None

    @trace #BRCM_SWREQ_MODULE
*/
int32_t MODULE_LoadCfg(const MODULE_Type * const aModEntry);

#endif /* MODULE_OSIL_H */
/** @} */
