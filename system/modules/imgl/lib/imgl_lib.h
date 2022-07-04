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
    @defgroup grp_imgl_lib_ifc IMGL Library Interface
    @ingroup grp_imgl

    @addtogroup grp_imgl_lib_ifc
    @{

    IMGL Library interface

    @limitations None

    @file imgl_lib.h
    @brief IMGL Library interface
    This header file contains the library interface functions for IMGL

    @version 0.1 Initial Version
*/

#ifndef IMGL_LIB_H
#define IMGL_LIB_H

#include <stdint.h>
#include <imgl_interface.h>
#include <pt_utils.h>
#include "imgl_common.h"
/**
    @name IMGL Library Architecture IDs
    @{
    @brief Architecture IDs for IMGL Library
*/
#define BRCM_SWARCH_IMGL_GET_FETCH_STATE_PROC         (0x8801U)    /**< @brief #IMGL_GetFetchState         */
#define BRCM_SWARCH_IMGL_CFG_INIT_PROC                (0x8806U)    /**< @brief #IMGL_CfgInit               */
#define BRCM_SWARCH_IMGL_GET_CFG_STATE_PROC           (0x8807U)    /**< @brief #IMGL_GetCfgState           */
#define BRCM_SWARCH_IMGL_CFG_GET_PROC                 (0x8808U)    /**< @brief #IMGL_CfgGet                */
#define BRCM_SWARCH_IMGL_CFG_GET_STATUS_PROC          (0x8809U)    /**< @brief #IMGL_CfgGetStatus          */
#define BRCM_SWARCH_IMGL_CFG_HANDLER_PROC             (0x880AU)    /**< @brief #IMGL_CfgHandler            */
#define BRCM_SWARCH_IMGL_UPDATE_REQUEST_PROC          (0x880BU)    /**< @brief #IMGL_UpdateRequest         */
#define BRCM_SWARCH_IMGL_UPDATE_STATUS_PROC           (0x880CU)    /**< @brief #IMGL_UpdateStatus          */
#define BRCM_SWARCH_IMGL_UPDATE_INIT_PROC             (0x880DU)    /**< @brief #IMGL_UpdateInit            */
#define BRCM_SWARCH_IMGL_DEINIT_PROC                  (0x880EU)    /**< @brief #IMGL_Deinit                */

/** @} */

/** @brief Get current IMGL state

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      void

    @return     IMGL_StateType

    @post None

    @trace #BRCM_SWREQ_IMGL_CORE
*/
static inline IMGL_StateType IMGL_GetFetchState(IMGL_FetchContextType *aFetchContext)
{
    return aFetchContext->state;
}

/** @brief Update with newer version

    Fetches images over a specific channel and updates them on Flash

    @behavior Async, Non-reentrant

    @pre IMGL_UpdateInit is called

    @param[inout]   aUpdateContext  Imgl update context
    @param[in]      aCfgContext     Imgl cfg context
    @param[in]      aFetchMode      Mode for fetching images
    @param[in]      aFetchChannel   Channel for fetching images
    @param[in]      aRequest        Update Request

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Success
    @retval     #BCM_ERR_INVAL_STATE    Updater is not ready to take requests
    @retval     #BCM_ERR_INVAL_PARAMS   (aMode is invalid) or (no module found with aFetchMode)
                                        or (aRequest is NULL)
                                        or (aRequest->numImgs > IMGL_UPDATE_MAX_NUM_IMGS)

    @post None

    @trace #BRCM_SWREQ_IMGL_CORE

    @limitations None
*/
int32_t IMGL_UpdateRequest(IMGL_UpdateContextType *aUpdateContext,
                           IMGL_CfgContextType *aCfgContext,
                           IMGL_ModeType aFetchMode,
                           IMGL_ChannelType aFetchChannel,
                           IMGL_UpdateReqType *aRequest);

/** @brief IMGL Update Partition Status

    Retrieves current status of IMGL_UpdatePartition request. Caller is expected
    to trigger the state machine through IMGL_StateHandler independent of this
    API

    @behavior Async, Non-reentrant

    @pre IMGL_UpdatePartition is called

    @param[inout]   aUpdateContext  Imgl update context
    @param[in]      aCfgContext     Imgl cfg context

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Success
    @retval     #BCM_ERR_NOT_FOUND      Images not found
    @retval     #BCM_ERR_BUSY           Update in progress
    @retval     #BCM_ERR_INVAL_STATE    Initialization was not successful or not invoked
                                        or No pending update command

    @post None

    @trace #BRCM_SWREQ_IMGL_CORE

    @limitations None
*/
int32_t IMGL_UpdateStatus(IMGL_UpdateContextType *aUpdateContext, IMGL_CfgContextType *aCfgContext);

/** @brief Initializes IMGL

    @behavior Sync, Non-reentrant

    @pre None

    @param[inout]   aUpdateContext  Imgl update context
    @param[in]      aCfgContext     Imgl cfg context

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Success

    @post IMGL is initialized

    @trace #BRCM_SWREQ_IMGL_CORE
*/
int32_t IMGL_UpdateInit(IMGL_UpdateContextType *aUpdateContext, IMGL_CfgContextType *aCfgContext);

/** @brief Initializes IMGL Configuration

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]   aContext Pointer to IMGL cfg context

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Success

    @post IMGL is initialized

    @trace #BRCM_SWREQ_IMGL_CORE
*/
int32_t IMGL_CfgInit(IMGL_CfgContextType *aContext);

/** @brief Get configuration images

    @behavior Sync, Non-reentrant

    @pre IMGL Configuration is initialized

    @param[in]  aContext Pointer to IMGL cfg context

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Success

    @post None

    @trace #BRCM_SWREQ_IMGL_CORE
*/
int32_t IMGL_CfgGet(IMGL_CfgContextType *aContext);

/** @brief Get configuration request status

    @behavior Sync, Non-reentrant

    @pre IMGL Configuration is initialized

    @param[in]   aContext Pointer to IMGL cfg context

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Success
    @retval     #BCM_ERR_NOT_FOUND      Failed to get configuration
    @retval     #BCM_ERR_BUSY           Busy processing

    @post None

    @trace #BRCM_SWREQ_IMGL_CORE
*/
int32_t IMGL_CfgGetStatus(IMGL_CfgContextType *aContext);

/** @brief IMGL State Handler

    This function processes different pending requests from various clients,
    including IMGL_UpdatePartition requests

    @behavior Async, Non-reentrant

    @pre IMGL_CfgInit is called

    @param[in]   aContext Pointer to IMGL cfg context

    @return     void

    @post None

    @trace #BRCM_SWREQ_IMGL_CORE

    @limitations None
*/
void IMGL_CfgHandler(IMGL_CfgContextType *aContext);

/** @brief Get current IMGL state

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]   aContext Pointer to IMGL cfg context

    @return     IMGL_StateType

    @post None

    @trace #BRCM_SWREQ_IMGL_CORE
*/
static inline IMGL_StateType IMGL_GetCfgState(IMGL_CfgContextType *aContext) {
    return aContext->state;
}

/** @brief Deinitialize IMGL and Loaders

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      void

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Success

    @post IMGL and Loaders are deinitialized for provided modes.

    @trace #BRCM_SWREQ_IMGL_CORE
*/
int32_t IMGL_Deinit(void);

#endif /* IMGL_LIB_H */
/** @} */
