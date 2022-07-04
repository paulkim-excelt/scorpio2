/*****************************************************************************
 Copyright 2021-2022 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_crypto_common_ifc Common Types
    @ingroup grp_crypto_abstract

    @addtogroup grp_crypto_common_ifc
    @{

    @file crypto_common.h
    @brief Crypto Common Types and Macros
    This header file contains common types and macros for cryptography

    @version 0.1 Initial Version
*/

#ifndef CRYPTO_COMMON_H
#define CRYPTO_COMMON_H

#include <stdint.h>

/**
    @name Component Architecture IDs
    @{
    @brief Architecture IDs for Component
*/
#define BRCM_SWARCH_CRYPTO_MACRO                        (0x8100U)   /**< @brief #CRYPTO_MAGIC                   */
#define BRCM_SWARCH_CRYPTO_KEY_TYPE                     (0x8101U)   /**< @brief #CRYPTO_KeyType                 */
#define BRCM_SWARCH_CRYPTO_KEY_HDL_TYPE                 (0x8102U)   /**< @brief #CRYPTO_KeyHdlType              */
#define BRCM_SWARCH_CRYPTO_ALGO_TYPE                    (0x8103U)   /**< @brief #CRYPTO_AlgoType                */
#define BRCM_SWARCH_CRYPTO_PUBLIC_KEY_CONTAINER_TYPE    (0x8104U)   /**< @brief #CRYPTO_PublicKeyContainerType  */
/** @} */

/**
    @brief magic 'CRPT'

    @trace #BRCM_SWREQ_CRYPTO
*/
#define CRYPTO_MAGIC                (0x43525054UL)

/**
    @name Crypto Keytype macros
    @{
    @brief Crypto specific common macros

    | Bits (31:16)  | Bits (15:12)  | Bits (11:8)   | Bits (7:0)        |
    |:-------------:|:-------------:|:-------------:|:-----------------:|
    | Algorithm     | Major version | Minor version |  Bit width        |

    <br>Algo Type: RSA/ECDSA/AES-CMAC/SHA/PKCS etc
    <br>Algo version: 1.5, 2.2 etc
    <br>Algo Bit width: 256, 2048 etc. Representation in multiples of 32
    @trace #BRCM_SWREQ_CRYPTO
*/
typedef uint32_t CRYPTO_KeyType;
#define CRYPTO_KEY_TYPE_MASK            (0xFFFF0000UL)  /**< @brief Type Mask           */
#define CRYPTO_KEY_VER_MASK             (0x0000FF00UL)  /**< @brief Version Mask        */
#define CRYPTO_KEY_BW_MASK              (0x000000FFUL)  /**< @brief Bit width Mask      */
#define CRYPTO_KEY_INVALID              (0x00000000UL)  /**< @brief Invalid key type    */
#define CRYPTO_KEY_AES128               (0x41450004UL)  /**< @brief AES 128 bit key     */
#define CRYPTO_KEY_AES192               (0x41450006UL)  /**< @brief AES 192 bit key     */
#define CRYPTO_KEY_AES256               (0x41450008UL)  /**< @brief AES 256 bit key     */
#define CRYPTO_KEY_RSA_2K               (0x52531040UL)  /**< @brief RSA2K key           */
#define CRYPTO_KEY_ECC_SECP256R1        (0x45431008UL)  /**< @brief ECC SECP256R1 Key   */
#define CRYPTO_KEY_ECC_SECP384R1        (0x4543100CUL)  /**< @brief ECC SECP384R1 Key   */
/** @} */

/**
    @name Crypto related macros
    @{
    @brief Crypto specific common macros

    | Bits (31:16)  | Bits (15:12)  | Bits (11:8)   | Bits (7:0)        |
    |:-------------:|:-------------:|:-------------:|:-----------------:|
    | Algorithm     | Major version | Minor version |  Bit width        |

    <br>Algo Type: RSA/ECDSA/AES-CMAC/SHA/PKCS etc
    <br>Algo version: 1.5, 2.2 etc
    <br>Algo Bit width: 256, 2048 etc. Representation in multiples of 128
    @trace #BRCM_SWREQ_CRYPTO
*/
typedef uint32_t CRYPTO_AlgoType;
#define CRYPTO_ALGO_TYPE_MASK   (0xFFFF0000UL)  /**< @brief Type Mask       */
#define CRYPTO_ALGO_VER_MASK    (0x0000FF00UL)  /**< @brief Version Mask    */
#define CRYPTO_ALGO_BW_MASK     (0x000000FFUL)  /**< @brief Bit width Mask  */
#define CRYPTO_ALGO_RSA2K       (0x52531010UL)  /**< @brief RSA-2K "RS"     */
#define CRYPTO_ALGO_ECDSA384    (0x45431003UL)  /**< @brief ECDSA-384 "EC"  */

#define CRYPTO_ALGO_SHA256      (0x53482002UL)  /**< @brief SHA2-256  "SH"  */
#define CRYPTO_ALGO_SHA384      (0x53482003UL)  /**< @brief SHA2-384  "SH"  */
#define CRYPTO_ALGO_SHA512      (0x53482004UL)  /**< @brief SHA2-512  "SH"  */

#define CRYPTO_ALGO_PKCS21      (0x504B2100UL)  /**< @brief PKCS 2.1  "PK"  */
/** @} */

/**
    @name Crypto related macros
    @{
    @brief Crypto specific common macros

    Represented by 32-bits of CRC, 16-bits of random seed, and 16-bits of index.
    Special handles are as described below.

    @trace #BRCM_SWREQ_CRYPTO
*/
typedef uint64_t CRYPTO_KeyHdlType;
#define CRYPTO_KEY_HDL_INVALID      (0x0ULL)    /**< @brief Invalid Handle      */
#define CRYPTO_KEY_HDL_MVK          (0x1ULL)    /**< @brief Module Manufacturer Verification Key (Public Key in OTP) */
/** @} */

/** @brief Public key container type

    Temporary. In future, this (or a variation of it) should be
    defined by the keystore

    @trace #BRCM_SWREQ_CRYPTO
*/
typedef struct sCRYPTO_PublicKeyContainerType {
    uint32_t keyLenWords;               /**< @brief Public key length in words  */
    CRYPTO_AlgoType keyAlgo;            /**< @brief Key algorithm               */
    CRYPTO_AlgoType keyPaddingAlgo;     /**< @brief Padding algorithm           */
    uint32_t pubKey[256UL / 4UL];       /**< @brief Public key                  */
} CRYPTO_PublicKeyContainerType;

#endif /* CRYPTO_COMMON_H */

/** @} */
