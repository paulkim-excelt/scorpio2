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
    @defgroup grp_secutils_ifc Interface
    @ingroup grp_secutils

    @addtogroup grp_secutils_ifc
    @{
    @file secutils.h
    @brief Interface File
    This file contains the interface functions for the utilities to be used in the security drivers

    @version 0.1 Initial Version
*/
#ifndef SECUTILS_H
#define SECUTILS_H

#include <stdint.h>

/**
    @name Security utils Architecture IDs
    @{
    @brief Architecture IDs for the security utils
*/
#define BRCM_SWARCH_SECUTILS_DIGIT_ENDIANNESS_TYPE                 (0x8101U)    /**< @brief #SECUTILS_DigitEndianness           */
#define BRCM_SWARCH_SECUTILS_DIGIT_ORDER_TYPE                      (0x8102U)    /**< @brief #SECUTILS_DigitOrder                */
#define BRCM_SWARCH_SECUTILS_BIGUINT_ORDERING_TYPE                 (0x8103U)    /**< @brief #SECUTILS_BigUintOrderingType       */
#define BRCM_SWARCH_SECUTILS_BIGUINT_TYPE                          (0x8104U)    /**< @brief #SECUTILS_BigUintType               */
#define BRCM_SWARCH_SECUTILS_CONST_BIGUINT_TYPE                    (0x8105U)    /**< @brief #SECUTILS_ConstBigUintType          */
#define BRCM_SWARCH_SECUTILS_MONT_CTX_TYPE                         (0x8106U)    /**< @brief #SECUTILS_BigUintMontCtxType        */
#define BRCM_SWARCH_SECUTILS_CONST_ZERO_GLOBAL                     (0x8107U)    /**< @brief #SECUTILS_ConstZero                 */
#define BRCM_SWARCH_SECUTILS_CONST_ONE_GLOBAL                      (0x8108U)    /**< @brief #SECUTILS_ConstOne                  */
#define BRCM_SWARCH_SECUTILS_GET_CONST_BIGUINT_PROC                (0x8109U)    /**< @brief #SECUTILS_GetConstBigUint           */
#define BRCM_SWARCH_SECUTILS_IMPORT_BIGUINT_PROC                   (0x810AU)    /**< @brief #SECUTILS_ImportBigUint             */
#define BRCM_SWARCH_SECUTILS_BIGUINT_CMP_PROC                      (0x810BU)    /**< @brief #SECUTILS_BigUintCmp                */
#define BRCM_SWARCH_SECUTILS_BIGUINT_ADD_PROC                      (0x810CU)    /**< @brief #SECUTILS_BigUintAdd                */
#define BRCM_SWARCH_SECUTILS_BIGUINT_SUB_PROC                      (0x810DU)    /**< @brief #SECUTILS_BigUintSub                */
#define BRCM_SWARCH_SECUTILS_BIGUINT_ONES_COMPLEMENT_PROC          (0x810EU)    /**< @brief #SECUTILS_BigUintOnesComplement     */
#define BRCM_SWARCH_SECUTILS_BIGUINT_GET_MSWORD_AND_BITIDX_PROC    (0x810FU)    /**< @brief #SECUTILS_BigUintGetMSWordAndBitIdx */
#define BRCM_SWARCH_SECUTILS_COMPUTE_NINV_MOD_2POW32_PROC          (0x8110U)    /**< @brief #SECUTILS_ComputeNInvMod2Pow32      */
#define BRCM_SWARCH_SECUTILS_BIGUINT_COMPUTE_MONT_CTX_PROC         (0x8111U)    /**< @brief #SECUTILS_BigUintComputeMontCtx     */
#define BRCM_SWARCH_SECUTILS_BIGUINT_MONT_XFORM_PROC               (0x8112U)    /**< @brief #SECUTILS_BigUintMontXform          */
#define BRCM_SWARCH_SECUTILS_BIGUINT_MONT_REDUCE_PROC              (0x8113U)    /**< @brief #SECUTILS_BigUintMontReduce         */
#define BRCM_SWARCH_SECUTILS_BIGUINT_MONT_EXP_PROC                 (0x8114U)    /**< @brief #SECUTILS_BigUintMontExp            */
/** @} */

/**
    @name SECUTILS_DigitEndianness
    @{
    @brief Endianness of a digit in a multi precision integer representation

    @trace #BRCM_SWREQ_SECUTILS_MPINT
*/
typedef uint32_t SECUTILS_DigitEndianness;                  /**< @brief Digit endianness type                                    */
#define SECUTILS_DIGIT_ENDIANNESS_BIG                 (0UL) /**< @brief Indicates that the digit byte ordering is big endian     */
#define SECUTILS_DIGIT_ENDIANNESS_LITTLE              (1UL) /**< @brief Indicates that the digit byte ordering is little endian  */
/** @} */

/**
    @name SECUTILS_DigitOrder
    @{
    @brief Digit order in a multi precision integer representation

    @trace #BRCM_SWREQ_SECUTILS_MPINT
*/
typedef uint32_t SECUTILS_DigitOrder;                       /**< @brief Digit order type                                         */
#define SECUTILS_DIGIT_ORDER_MOST_SIGNIFICANT         (0UL) /**< @brief Indicates that the digit at index 0 is most significant  */
#define SECUTILS_DIGIT_ORDER_LEAST_SIGNIFICANT        (1UL) /**< @brief Indicates that the digit at index 0 is least significant */
/** @} */

/**
    @name SECUTILS_BigUintOrderingType
    @{
    @brief BigUint ordering

    @trace #BRCM_SWREQ_SECUTILS_MPINT
*/
typedef uint32_t SECUTILS_BigUintOrderingType;
#define SECUTILS_BIGUINT_ORDERING_LT        (0UL)
#define SECUTILS_BIGUINT_ORDERING_EQ        (1UL)
#define SECUTILS_BIGUINT_ORDERING_GT        (2UL)
/** @} */

/**
    @brief Mutable unsigned multi precision integer

    @trace #BRCM_SWREQ_SECUTILS_MPINT
*/
typedef struct sSECUTILS_BigUintType {
    uint32_t numLimbs;     /**< @brief Number of 32-bit words in this instance of the big integer               */
    uint32_t *limbs;       /**< @brief Digits. limbs[0] is the least significant. The memory is user managed    */
} SECUTILS_BigUintType;

/**
    @brief Immutable unsigned multi precision integer

    @trace #BRCM_SWREQ_SECUTILS_MPINT
*/
typedef struct sSECUTILS_ConstBigUintType {
    uint32_t numLimbs;
    const uint32_t *limbs;
} SECUTILS_ConstBigUintType;

/**
    @brief Montgomery context

    @trace #BRCM_SWREQ_SECUTILS_MPINT
*/
typedef struct sSECUTILS_BigUintMontCtxType {
    uint32_t negNInvMod32;              /**< @brief -(1/N) mod 32       */
    SECUTILS_ConstBigUintType N;        /**< @brief The modulus         */
    SECUTILS_ConstBigUintType rModN;    /**< @brief R mod N             */
    SECUTILS_ConstBigUintType rrModN;   /**< @brief R^2 mod N           */
} SECUTILS_BigUintMontCtxType;

/**
    @brief Const uint for a commonly used constant zero

    @trace #BRCM_SWREQ_SECUTILS_MPINT
*/
extern const SECUTILS_ConstBigUintType *const SECUTILS_ConstZero;

/**
    @brief Const uint for a commmonly used constant one

    @trace #BRCM_SWREQ_SECUTILS_MPINT
*/
extern const SECUTILS_ConstBigUintType *const SECUTILS_ConstOne;

/** @brief Cast a mutable BigUint into a immutable BigUint

    @behavior Sync, reentrant

    @pre None

    @param[in]      aBigUint                    Mutable BigUint input

    @post None

    @trace #BRCM_SWREQ_SECUTILS_MPINT

    @limitations None
*/
static inline SECUTILS_ConstBigUintType* SECUTILS_GetConstBigUint(const SECUTILS_BigUintType *const aBigUint)
{
    return (SECUTILS_ConstBigUintType*)aBigUint;
}

/** @brief Import a multi precision integer

    Helper API to convert a few different representations of a multi precision
    integer to the one defined by @ref SECUTILS_BigUint

    @behavior Sync, reentrant

    @pre None

    @param[in]      aSrcEndianness              Endianness of the digits in the source multi
                                                precision integer representation
    @param[in]      aSrcDigitOrder              Digit ordering in the source multi precision
                                                integer representation
    @param[in]      aNumSrcWords                Number of words in the source
                                                multi precision integer representation
    @param[in]      aSrc                        Source multi precision integer to import from
    @param[inout]   aDst                        Imported multi precision integer

    Return values are documented in reverse-chronological order
    @retval      BCM_ERR_OK              Success.
    @retval      BCM_ERR_INVAL_PARAMS    (aNumSrcWords != aDst->numLimbs), aNumSrcWords is zero
                                         or aDst->limbs is NULL, Invalid aSrcEndianness, Invalid
                                         aSrcDigitOrder

    @post None

    @trace #BRCM_SWREQ_SECUTILS_MPINT

    @limitations None
*/
int32_t SECUTILS_ImportBigUint(const SECUTILS_DigitEndianness aSrcEndianness, const SECUTILS_DigitOrder aSrcDigitOrder, const uint32_t aNumSrcWords, const uint32_t *const aSrc, SECUTILS_BigUintType *const aDst);

/** @brief Compare two BigUints

    @behavior Sync, reentrant

    @pre None

    @param[in]      aBigUint0                   BigUint on the LHS of the compare operation
    @param[in]      aBigUint1                   BigUint on the RHS of the compare operation
    @param[in]      aOrdering                   Comparision result. Will be set to -
                                                    #SECUTILS_BIGUINT_ORDERING_LT if aBigUint0 < aBigUint1
                                                    #SECUTILS_BIGUINT_ORDERING_GT if aBigUint0 > aBigUint1
                                                    #SECUTILS_BIGUINT_ORDERING_EQ otherwise

    Return values are documented in reverse-chronological order
    @retval      BCM_ERR_OK              Success.
    @retval      BCM_ERR_INVAL_PARAMS    Any of the input params is not valid

    @post None

    @trace #BRCM_SWREQ_SECUTILS_MPINT

    @limitations None
*/
int32_t SECUTILS_BigUintCmp(const SECUTILS_ConstBigUintType *const aBigUint0, const SECUTILS_ConstBigUintType *const aBigUint1, SECUTILS_BigUintOrderingType *const aOrdering);

/** @brief Add two BigUints

    aBigUint2 = aBigUint0 + aBigUint1

    @behavior Sync, reentrant

    @pre None

    @param[in]      aBigUint0               BigUint on the LHS of the addition operation
    @param[in]      aBigUint1               BigUint on the RHS of the addition operation
    @param[inout]   aBigUint2               Addition result

    Return values are documented in reverse-chronological order
    @retval         BCM_ERR_OK              Success.
    @retval         BCM_ERR_NOMEM           Addition result overflows aBigUint2
    @retval         BCM_ERR_INVAL_PARAMS    Any of the input params is not valid

    @post None

    @trace #BRCM_SWREQ_SECUTILS_MPINT

    @limitations None
*/
int32_t SECUTILS_BigUintAdd(const SECUTILS_ConstBigUintType *const aBigUint0, const SECUTILS_ConstBigUintType *const aBigUint1, SECUTILS_BigUintType *const aBigUint2);

/** @brief Subtract two BigUints

    aBigUint2 = aBigUint0 - aBigUint1

    @behavior Sync, reentrant

    @pre None

    @param[in]      aBigUint0               BigUint on the LHS of the subtraction operation
    @param[in]      aBigUint1               BigUint on the RHS of the subtraction operation
    @param[inout]   aBigUint2               Subtraction result

    Return values are documented in reverse-chronological order
    @retval         BCM_ERR_OK              Success.
    @retval         BCM_ERR_NOMEM           Subtraction result overflows or underflows
    @retval         BCM_ERR_INVAL_PARAMS    Any of the input params is not valid

    @post None

    @todo Reconsider the underflow behaviour

    @trace #BRCM_SWREQ_SECUTILS_MPINT

    @limitations None
*/
int32_t SECUTILS_BigUintSub(const SECUTILS_ConstBigUintType *const aBigUint0, const SECUTILS_ConstBigUintType *const aBigUint1, SECUTILS_BigUintType *const aBigUint2);

/** @brief Compute ones complement of a BigUint

    @behavior Sync, reentrant

    @pre None

    @param[in]      aBigUint0               BigUint input
    @param[inout]   aOnesComplement         Ones complement output

    Return values are documented in reverse-chronological order
    @retval         BCM_ERR_OK              Success.
    @retval         BCM_ERR_INVAL_PARAMS    Any of the input params is not valid, aOnesComplement
                                            not big enough to hold the ones complement result

    @post None

    @trace #BRCM_SWREQ_SECUTILS_MPINT

    @limitations None
*/
int32_t SECUTILS_BigUintOnesComplement(const SECUTILS_ConstBigUintType *const aBigUint0, SECUTILS_BigUintType *const aOnesComplement);

/** @brief Compute the most significant bit and word positions

    @behavior Sync, reentrant

    @pre None

    @param[in]      aBigUint            BigUint input
    @param[inout]   aMSWordIdx          Pointer to write the MS word index to
    @param[inout]   aMSBitIdxInWord     Pointer to write the MS bit index in the
                                        MS word

    Return values are documented in reverse-chronological order
    @retval      BCM_ERR_OK             Success.
    @retval      BCM_ERR_INVAL_PARAMS   Any of the input params is not valid

    @post None

    @trace #BRCM_SWREQ_SECUTILS_MPINT

    @limitations None
*/
int32_t SECUTILS_BigUintGetMSWordAndBitIdx(const SECUTILS_ConstBigUintType *const aBigUint, uint32_t *const aMSWordIdx, uint32_t *const aMSBitIdxInWord);

/** @brief Compute 1/N mod 2^32 or -1/N mod 2^32

    @behavior Sync, reentrant

    @pre None

    @param[in]      aN                      The modulus N. Should be odd
    @param[in]      aDoInv                  If zero, aNp is set to (1/N) mod 2^32.
                                            Else, aNp is set to -(1/N) mod 2^32
    @param[inout]   aNp                     Computed output

    Return values are documented in reverse-chronological order
    @retval         BCM_ERR_OK              Success.
    @retval         BCM_ERR_INVAL_PARAMS    aN is invalid or is not odd,
                                            aNp is NULL

    @post None

    @trace #BRCM_SWREQ_SECUTILS_MPINT

    @limitations None
*/
int32_t SECUTILS_ComputeNInvMod2Pow32(const SECUTILS_ConstBigUintType *const aN, const uint32_t aDoInv, uint32_t *const aNp);

/** @brief Compute a montgomery context

    @behavior Sync, reentrant

    @pre None

    @param[in]      aN                      The modulus N
    @param[in]      aRModNBuffer            Buffer to which the computed quantity (R mod N)
                                            is to be written to
    @param[in]      aRModNBufferNumWords    Buffer size of aRModNBuffer in words. Should be atleast
                                            aN->numLimbs
    @param[in]      aRRModNBuffer           Buffer to which the computed quantity (R^2 mod N)
                                            is to be written to
    @param[in]      aRRModNBufferNumWords   Buffer size of aRRModNBuffer in words. Should be atleast
                                            aN->numLimbs + 1
    @param[in]      aScratchBuffer          Scratch space that this function may use to store any
                                            intermediate computations
    @param[in]      aScratchBuffernumWords  Buffer size of aScratchBuffer in words. Should be atleast
                                            2*(aN->numLimbs) + 2
    @param[inout]   aMontCtx                Montgomery context to initialize

    Return values are documented in reverse-chronological order
    @retval         BCM_ERR_OK              Success.
    @retval         BCM_ERR_INVAL_PARAMS    aN is invalid,
                                            Input buffers are invalid, or have insufficient size,
                                            aMontCtx is NULL

    @post aMontCtx holds references to aN->limbs, aRModNBuffer and aRRModNBuffer.
        The contents of aN->limbs, aRModNBuffer and aRRModNBuffer should not change until such a time
        when the aMontCtx being initialized is no longer needed.

    @trace #BRCM_SWREQ_SECUTILS_MPINT

    @limitations None
*/
int32_t SECUTILS_BigUintComputeMontCtx(const SECUTILS_ConstBigUintType *const aN, uint32_t *const aRModNBuffer, const uint32_t aRModNBufferNumWords, uint32_t *const aRRModNBuffer, const uint32_t aRRModNBufferNumWords, uint32_t *const aScratchBuffer, const uint32_t aScratchBuffernumWords, SECUTILS_BigUintMontCtxType *const aMontCtx);

/** @brief Transform X into montgomery domain

    aXHat = aX*R mod N

    @behavior Sync, reentrant

    @pre None

    @param[in]      aMontCtx                The montgomery context
    @param[in]      aScratchBuffer          Scratch space that this function may use to store any
                                            intermediate computations
    @param[in]      aScratchBuffernumWords  Buffer size of aScratchBuffer in words. Should be atleast
                                            2*(aN->numLimbs) + 2
    @param[in]      aX                      Integer to be transformed into the montgomery
                                            domain. Should be in the range [0, N), where
                                            N is the modulus against which the montgomery context
                                            was created
    @param[inout]   aXHat                   Transformation result. Underlying buffer should be of
                                            size greater than or equal to N->numLimbs. This buffer
                                            may overlap with the buffer used by aX

    Return values are documented in reverse-chronological order
    @retval         BCM_ERR_OK              Success.
    @retval         BCM_ERR_INVAL_PARAMS    aMontCtx is invalid,
                                            aX or aXHat is an invalid bigint,
                                            aXHat's buffer isn't big enough

    @post None

    @trace #BRCM_SWREQ_SECUTILS_MPINT

    @limitations None
*/
int32_t SECUTILS_BigUintMontXform(const SECUTILS_BigUintMontCtxType *const aMontCtx, uint32_t *const aScratchBuffer, const uint32_t aScratchBufferNumWords, const SECUTILS_ConstBigUintType *const aX, SECUTILS_BigUintType *const aXHat);

/** @brief Montgomery reduction

    aX = aXHat*R^-1 mod N

    @behavior Sync, reentrant

    @pre None

    @param[in]      aMontCtx                The montgomery context
    @param[in]      aScratchBuffer          Scratch space that this function may use to store any
                                            intermediate computations
    @param[in]      aScratchBuffernumWords  Buffer size of aScratchBuffer in words. Should be atleast
                                            2*(aN->numLimbs) + 2
    @param[in]      aXHat                   Integer to perform the reduction operation on
    @param[inout]   aX                      Reduction output. Underlying buffer should be of
                                            size greater than or equal to N->numLimbs. This buffer
                                            may overlap with the buffer used by aXHat

    Return values are documented in reverse-chronological order
    @retval      BCM_ERR_OK                 Success.
    @retval      BCM_ERR_INVAL_PARAMS       aMontCtx is invalid,
                                            aXHat or aX is an invalid bigint,
                                            aX's buffer isn't big enough

    @post None

    @trace #BRCM_SWREQ_SECUTILS_MPINT

    @limitations None
*/
int32_t SECUTILS_BigUintMontReduce(const SECUTILS_BigUintMontCtxType *const aMontCtx, uint32_t *const aScratchBuffer, const uint32_t aScratchBufferNumWords, const SECUTILS_ConstBigUintType *const aXHat,  SECUTILS_BigUintType *const aX);

/** @brief Montgomery exponentiation

    aOutHat = ((aXHat^aExp) * R^(-aExp + 1) mod N

    @behavior Sync, reentrant

    @pre None

    @param[in]      aMontCtx                The montgomery context
    @param[in]      aScratchBuffer          Scratch space that this function may use to store any
                                            intermediate computations
    @param[in]      aScratchBuffernumWords  Buffer size of aScratchBuffer in words. Should be atleast
                                            2*(aN->numLimbs) + 2
    @param[in]      aXHat                   Base of the exponentiation operation
    @param[in]      aExp                    Exponent
    @param[inout]   aOutHat                 Output of the exponentiation operation.
                                            Underlying buffer should be of
                                            size greater than or equal to N->numLimbs. This buffer
                                            should not overlap with the buffer used by aXHat or aExp

    Return values are documented in reverse-chronological order
    @retval         BCM_ERR_OK              Success.
    @retval         BCM_ERR_INVAL_PARAMS    aMontCtx is invalid,
                                            aXHat, aExp or aOutHat is an invalid bigint,
                                            aXHat's buffer isn't big enough

    @post None

    @trace #BRCM_SWREQ_SECUTILS_MPINT

    @limitations We only support aExp's whose representations do not exceed a single
        machine word for simplicity reasons.
*/
int32_t SECUTILS_BigUintMontExp(const SECUTILS_BigUintMontCtxType *const aMontCtx, uint32_t *const aScratchBuffer, const uint32_t aScratchBufferNumWords, const SECUTILS_ConstBigUintType *const aXHat, const SECUTILS_ConstBigUintType *const aExp, const SECUTILS_BigUintType *const aOutHat);

#endif
/** @} */
