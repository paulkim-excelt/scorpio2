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

 2. TO THE COMP_MAXIMUM EXTENT PERMITTED BY LAW, THE SOFTWARE IS PROVIDED "AS IS"
    AND WITH ALL FAULTS AND BROADCOM MAKES NO PROMISES, REPRESENTATIONS OR
    WARRANTIES, EITHER EXPRESS, IMPLIED, STATUTORY, OR OTHERWISE, WITH RESPECT
    TO THE SOFTWARE.  BROADCOM SPECIFICALLY DISCLAIMS ANY AND ALL IMPLIED
    WARRANTIES OF TITLE, MERCHANTABILITY, NONINFRINGEMENT, FITNESS FOR A
    PARTICULAR PURPOSE, LACK OF VIRUSES, ACCURACY OR COMPLETENESS,
    QUIET ENJOYMENT, QUIET POSSESSION OR CORRESPONDENCE TO DESCRIPTION.
    YOU ASSUME THE ENTIRE RISK ARISING OUT OF USE OR PERFORMANCE OF THE
    SOFTWARE.

 3. TO THE COMP_MAXIMUM EXTENT PERMITTED BY LAW, IN NO EVENT SHALL BROADCOM OR ITS
    LICENSORS BE LIABLE FOR (i) CONSEQUENTIAL, INCIDENTAL, SPECIAL, INDIRECT,
    OR EXEMPLARY DAMAGES WHATSOEVER ARISING OUT OF OR IN ANY WAY RELATING TO
    YOUR USE OF OR INABILITY TO USE THE SOFTWARE EVEN IF BROADCOM HAS BEEN
    ADVISED OF THE POSSIBILITY OF SUCH DAMAGES; OR (ii) ANY AMOUNT IN EXCESS
    OF THE AMOUNT ACTUALLY PAID FOR THE SOFTWARE ITSELF OR U.S. $1, WHICHEVER
    IS GREATER. THESE LIMITATIONS SHALL APPLY NOTWITHSTANDING ANY FAILURE OF
    ESSENTIAL PURPOSE OF ANY LIMITED REMEDY.
******************************************************************************/
/**
    @defgroup grp_aes_sw_ifc Interface
    @ingroup grp_aes_sw

    @addtogroup grp_aes_sw_ifc
    @{
    @file aes.h
    @brief AES SW routines API header
    This file contains the interface function declarations for AES
    SW routines

    @version 0.1 Initial Version
*/
#ifndef AES_H
#define AES_H

#include <stdint.h>
#include <bcm_err.h>
#include <crypto_common.h>

/**
    @name AES Architecture IDs
    @{
    @brief Architecture IDs for the AES API's
*/
#define BRCM_SWARCH_AES_ECB_ENCRYPT_BLOCK_PROC                  (0x8201U)   /**< @brief #AES_ECBEncryptBlock            */
#define BRCM_SWARCH_AES_ECB_DECRYPT_BLOCK_PROC                  (0x8202U)   /**< @brief #AES_ECBDecryptBlock            */
/** @} */

/** @brief AES-ECB Encrypt one block (128 bits) of plain-text

    @behavior Sync, reentrant

    @pre None

    @param[in]      aKeyType                    AES key type
    @param[in]      aCipherKey                  Pointer to the cipher key
    @param[in]      aPlainText                  Pointer to the plain-text to encrypt
    @param[out]     aCipherText                 Pointer to the memory where the cipher-text
                                                is to be written

    Return values are documented in reverse-chronological order
    @retval         BCM_ERR_INVAL_PARAMS        Invalid keyType,
                                                aCipherKey is NULL,
                                                aPlainText is NULL,
                                                aCipherText is NULL
    @retval         BCM_ERR_OK                  Encryption complete

    @post None

    @trace #BRCM_SWREQ_AES_SW_ROUTINES
*/
int32_t AES_ECBEncryptBlock(const CRYPTO_KeyType aKeyType, const uint8_t *const aCipherKey, const uint8_t *const aPlainText, uint8_t *const aCipherText);

/** @brief AES-ECB Decrypt one block (128 bits) of cipher-text

    @behavior Sync, reentrant

    @pre None

    @param[in]      aKeyType                    AES key type
    @param[in]      aCipherKey                  Pointer to the cipher key
    @param[in]      aCipherText                 Pointer to the cipher-text to decrypt
    @param[out]     aPlainText                  Pointer to the memory where the plain-text
                                                is to be written

    Return values are documented in reverse-chronological order
    @retval         BCM_ERR_INVAL_PARAMS        Invalid keyType,
                                                aCipherKey is NULL,
                                                aPlainText is NULL,
                                                aCipherText is NULL
    @retval         BCM_ERR_OK                  Encryption complete

    @post None

    @trace #BRCM_SWREQ_AES_SW_ROUTINES
*/
int32_t AES_ECBDecryptBlock(const CRYPTO_KeyType aKeyType, const uint8_t *const aCipherKey, const uint8_t *const aCipherText, uint8_t *const aPlainText);

#endif
/** @} */
