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

/** @defgroup grp_crypto_il Integration Guide
    @ingroup grp_crypto_abstract

    @addtogroup grp_crypto_il
    @{

    @file crypto_osil.h
    @brief Crypto Integration
    This header file contains the integration interface for Crypto
    @version 0.1 Intiial Version
*/

#ifndef CRYPTO_OSIL_H
#define CRYPTO_OSIL_H

#include <bcm_comp.h>

/**
    @name Integration Interface IDs
    @{
    @brief Integration Interface IDs for Crypto Service
*/
#define BRCM_SWARCH_CRYPTO_ADDRTRANS_PROC               (0x9100U)     /**< @brief #CRYPTO_TranslateAddr             */
#define BRCM_SWARCH_CRYPTO_GET_EVENT_MASK_PROC          (0x9101U)    /**< @brief #CRYPTO_ServiceGetEventMask        */
#define BRCM_SWARCH_CRYPTO_EVENT_HANDLER_PROC           (0x9102U)    /**< @brief #CRYPTO_ServiceEventHandler        */
#define BRCM_SWARCH_CRYPTO_GET_SERVER_PROC              (0x9103U)    /**< @brief #CRYPTO_GetServer                  */
#define BRCM_SWARCH_CRYPTO_SERVICE_RESET_HANDLER_PROC   (0x9104U)    /**< @brief #CRYPTO_ServiceResetStateHandler   */
#define BRCM_SWARCH_CRYPTO_SERVICE_READY_HANDLER_PROC   (0x9105U)    /**< @brief #CRYPTO_ServiceReadyStateHandler   */
/** @} */

/** @brief Translate the ARM Address to ARC Address

    @behavior Sync, Re-entrant

    @param[in]      aPtr     Pointor uint8_t type

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully Translated
    @retval     #BCM_ERR_INVAL_PARAMS   Translation address is not valid address range

    @trace #BRCM_SWREQ_CRYPTO

    @limitations None
*/
extern int32_t CRYPTO_TranslateAddr(uint8_t *aPtr, uint8_t **pPtr);

/** @brief Get Event Mask to be installed for Crypto Service

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      void

    @return uint32_t Event Mask

    @post None

    @note To be implemented.

    @trace  #BRCM_SWREQ_CRYPTO

    @limitations None
*/
uint32_t CRYPTO_ServiceGetEventMask(void);

/** @brief Event Handler to be installed for Crypto Service

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aMask       Event Mask

    @return void

    @post None

    @note To be implemented.

    @trace  #BRCM_SWREQ_CRYPTO

    @limitations None
*/
void CRYPTO_ServiceEventHandler(uint32_t aMask);

/** @brief Get Server details

    @behavior Sync, Re-entrant

    @pre None

    @param[out]      aServerTask        Server Task ID
    @param[out]      aServerEvent       Server Event Mask

    @return     void

    @post None

    @trace #BRCM_SWREQ_CRYPTO

    @limitations None
*/
void CRYPTO_GetServer(int32_t *aServerTask, uint32_t *aServerEvent);

/** @brief Crypto Service Reset State Handler

    Same as @ref #MODULE_StateHandlerType

    @trace  #BRCM_SWREQ_CRYPTO

    @limitations None
*/
int32_t CRYPTO_ServiceResetStateHandler(BCM_StateType aReqState);

/** @brief Crypto Service Ready State Handler

    Same as @ref #MODULE_StateHandlerType

    @trace  #BRCM_SWREQ_CRYPTO

    @limitations None
*/
int32_t CRYPTO_ServiceReadyStateHandler(BCM_StateType aReqState);

#endif /* CRYPTO_OSIL_H */

/** @} */
