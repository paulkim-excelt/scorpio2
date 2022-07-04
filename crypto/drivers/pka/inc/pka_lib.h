/*****************************************************************************
 Copyright 2019-2021 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_pkalib_ifc PKA library interface
    @ingroup grp_pka

    @addtogroup grp_pkalib_ifc
    @{
    This library provides optimized routines for the clients to run RSA and ECC based
    asymmetric crypto algorithms.

    @file pka_lib.h
    @brief Interface File
    This header file contains the interface functions for the PKA library
    @version 0.1 Initial Version
*/
#ifndef PKALIB_H
#define PKALIB_H

#include <stdint.h>

#include <secutils.h>
#include <bcm_utils.h>

/**
    @name PKA library Architecture IDs
    @{
    @brief Architecture IDs for the PKA library
*/
#define BRCM_SWARCH_PKA_JOBID_TYPE                (0x8801U)    /**< @brief #PKA_JobIdType               */
#define BRCM_SWARCH_PKA_INIT_PROC                 (0x8802U)    /**< @brief #PKA_Init                    */
#define BRCM_SWARCH_PKA_DEINIT_PROC               (0x8803U)    /**< @brief #PKA_Deinit                  */
#define BRCM_SWARCH_PKA_MSGDIGESTALG_TYPE         (0x8804U)    /**< @brief #PKA_MsgDigestAlgType        */
#define BRCM_SWARCH_PKA_RSA_SIGNATURE_SCHEME_TYPE (0x8805U)    /**< @brief #PKA_RsaSignatureSchemeType  */
#define BRCM_SWARCH_PKA_ECGROUP_TYPE              (0x8806U)    /**< @brief #PKA_EcGroup                 */
#define BRCM_SWARCH_PKA_RSA_VERIFY_PROC           (0x8807U)    /**< @brief #PKA_RsaVerify               */
#define BRCM_SWARCH_PKA_ECDSA_SIGN_PROC           (0x8808U)    /**< @brief #PKA_EcdsaSign               */
#define BRCM_SWARCH_PKA_ECDSA_VERIFY_PROC         (0x8809U)    /**< @brief #PKA_EcdsaVerify             */
#define BRCM_SWARCH_PKA_ECDHE_PROC                (0x880AU)    /**< @brief #PKA_Ecdhe                   */
#define BRCM_SWARCH_PKA_GETALGEXECRESULT_PROC     (0x880BU)    /**< @brief #PKA_GetAlgExecResult        */
/*  * @} */

/**
    @brief Handle to a submitted PKA job

    @trace #BRCM_SWREQ_PKA_KERNEL_INTERFACE
*/
typedef uint64_t PKA_JobIdType;

/**
    @name Supported Elliptic curve groups
    @{
    Supported elliptic curve groups.

    The domain parametres are described in
    the document [SEC 2: Recommended Elliptic Curve Domain Parameters],
    chapter 2.

    @trace #BRCM_SWREQ_PKA_KERNEL_INTERFACE
 */
typedef uint32_t PKA_EcGroup;
#define PKA_ECGROUP_SECP_256R1          (0UL)
#define PKA_ECGROUP_SECP_384R1          (1UL)
/** @} */

/**
    @brief PKA Driver and hardware initialization

    Initialize the PKA driver data structures and reset the PKA HW

    @behavior Sync, Non-reentrant

    @pre None
    @post The driver is ready to accept PKA jobs

    @trace #BRCM_SWREQ_PKA_INIT
*/
void PKA_Init(void);

/**
    @brief PKA Driver and hardware deinit

    Deinit the PKA driver data structures and reset the PKA HW

    @behavior Sync, Non-reentrant

    @pre None

    Return values are documented in reverse-chronological order
    @retval         #BCM_ERR_OK                 Success
    @retval         #BCM_ERR_BUSY               Cannot deinit because jobs are in-flight.
                                                Client may retry at a later point

    @post On successful call to this API, HW and all the driver data structures are reset

    @trace #BRCM_SWREQ_PKA_DEINIT
*/
int32_t PKA_Deinit(void);

/**
    @{
    @brief Message digest algorithms

    @trace #BRCM_SWREQ_PKA_KERNEL_INTERFACE
*/
typedef uint32_t PKA_MsgDigestAlgType;
#define PKA_MSGDIGESTALG_SHA256             (0UL)
/** @} */

/**
    @{
    @brief RSA SSA algorithms

    For the PSS scheme, it is assumed that the MGF function used
    during the signing operation is the MGF1 function specified in the
    RFC 8017. The salt length used during the signature generation is
    assumed to be equal to the length of the digest generated by the
    hashing algorithm.

    @trace #BRCM_SWREQ_PKA_KERNEL_INTERFACE
*/
typedef uint32_t PKA_RsaSignatureSchemeType;
#define PKA_RSA_SIGNATURE_SCHEME_PKCS_V15   (0UL)
#define PKA_RSA_SIGNATURE_SCHEME_PSS        (1UL)
/** @} */

/**
    @brief RSA signature verification algorithm.

    This API executes the RSA signature verification algorithms
    specified in [RFC8017].

    We only support public key moduls of length 256 octets (RSA2K).
    For PSS signatures
        -# MGF function is assumed to be the MGF1 function specified in RFC8017.
        -# Salt length is assumed to be equal to the length of the digest generated
           by the hashing algorithm

    @behavior Async, Reentrant

    @pre None

    @param[in]      aSigScheme                  RSA SSA algorithm
    @param[in]      aRsaPubMod                  RSA public key modulus
    @param[in]      aRsaPubExp                  RSA public key exponent
    @param[in]      aSignature                  Signature to be verified
    @param[in]      aMsgDigestAlg               Algorithm used to generate the message digest
    @param[in]      aMsgDigest                  Message digest
    @param[out]     aJobId                      Handle to the submitted job

    Return values are documented in reverse-chronological order
    @retval          #BCM_ERR_OK                On successful job submission
    @retval          #BCM_ERR_INVAL_PARAMS      Any of the input pointer parametres is NULL.
                                                aRsaPubMod is not 128 or 256 octets long or is in invalid state.
                                                aRsaPubExp has more octets than aRsaPubMod or is in invalid state.
                                                aSign has more octets than aRsaPubMod or is in invalid state
                                                aMsgDigestAlg invalid.
                                                aMsgDigest length inconsistent with the aMsgDigestAlg, or is in
                                                invalid state.
                                                The requested RSA operation is not supported on the platform
    @retval          #BCM_ERR_NOMEM             Job submission failed due to an internal error.

    @post After successful job submission, the client may query the status of the job execution by calling
            the @ref PKA_GetAlgExecResult API. *aAlgExecResult is set to
                -# BCM_ERR_OK           if the signature verification was successful
                -# BCM_ERR_BUSY         if the execution is yet to complete
                -# BCM_ERR_AUTH_FAILED  if the signature verification failed

    @post On successful job submission, @ref PKA_GetAlgExecResult should be called by the
            client to check the result of the signature verification. The BCM_ERR_OK return value
            from the said API indicates that the signature has been successfully verified. Also, a
            shallow copy of all the parametres of type SECUTILS_ConstBigUintType is made by the
            library and is stored in its data structures, so the clients are free to discard their
            instances of these parametres (but the backing storage needs to be preserved)

    @trace #BRCM_SWREQ_PKA_LIBRARY
 */
int32_t PKA_RsaVerify(const PKA_RsaSignatureSchemeType aSigScheme, const SECUTILS_ConstBigUintType *const aRsaPubMod, const SECUTILS_ConstBigUintType *const aRsaPubExp, const SECUTILS_ConstBigUintType *const aSignature, const PKA_MsgDigestAlgType aMsgDigestAlg, const SECUTILS_ConstBigUintType *const aMsgDigest, PKA_JobIdType *const aJobId);

/**
    @brief ECDSA signing algorithm

    This API executes the ECDSA signing algorithm specified in [ANS X9.62],
    section 5.3.

    @behavior Async, Reentrant

    @pre None

    @param[in]       aEcGroup                   Elliptic curve group to use
    @param[in]       aPrivkeyHdl                Secure heap allocation handle holding the
                                                signing key. This key should be compatible with
                                                the elliptic curve group specified in the aEcGroup
                                                argument.
    @param[in]       aRandNonce                 Cryptographically secure random number in the interval [1, n-1]
                                                where n is the order of the generator point of the aEcGroup
    @param[in]       aMsgDigest                 Message digest
    @param[out]      aSignatureR                R coordinate of the computed signature.
                                                Buffer should be large enough to be able to hold n (the order of
                                                the EcGroup's generator)
    @param[out]      aSignatureS                S coordinate of the computed signature.
                                                Buffer should be large enough to be able to hold n (the order of
                                                the EcGroup's generator)
    @param[out]      aJobId                     Handle to the submitted job

    Return values are documented in reverse-chronological order
    @retval          #BCM_ERR_OK                On success
    @retval          #BCM_ERR_INVAL_PARAMS      Any of the input args is invalid.
                                                The requested signing operation is not supported
                                                on the platform
    @retval          #BCM_ERR_NOMEM             Job submission failed due to an internal error.

    @post On successful job submission, @ref PKA_GetAlgExecResult should be called by the
            client to check the status of the submitted job. The #BCM_ERR_OK return value
            from the said API indicates that the signature has been suceessfully generated.
            #BCM_ERR_EAGAIN return value indicates that the random nonce passed in was not
            suitable, and the client may try the signature generation with a different random
            nonce. Also, a shallow copy of all the parametres of type SECUTILS_ConstBigUintType
            is made by the library and is stored in its data structures, so the clients are
            free to discard their instances of these parametres (but the backing storage needs to be
            preserved)

    @trace #BRCM_SWREQ_PKA_LIBRARY
 */
int32_t PKA_EcdsaSign(const PKA_EcGroup aEcGroup, const uint32_t aPrivkeyHdl, const SECUTILS_ConstBigUintType *const aRandNonce, const SECUTILS_ConstBigUintType *const aMsgDigest, SECUTILS_BigUintType *const aSignatureR, SECUTILS_BigUintType *const aSignatureS, PKA_JobIdType *const aJobId);

/**
    @brief ECDSA verification algorithm

    This API executes the ECDSA verification algorithm specified in [ANS X9.62],
    section 5.4.

    @behavior Async, Reentrant

    @pre None

    @param[in]       aEcGroup                   Elliptic curve group to use
    @param[in]       aPubKeyX                   X co-ordinate of the public key
    @param[in]       aPubKeyY                   Y co-ordinate of the public key
    @param[in]       aMsgDigest                 Message digest
    @param[out]      aSignatureR                R coordinate of the signature to be verified
    @param[out]      aSignatureS                S coordinate of the signature to be verified
    @param[out]      aJobId                     Handle to the submitted job

    Return values are documented in reverse-chronological order
    @retval          #BCM_ERR_OK                On success
    @retval          #BCM_ERR_INVAL_PARAMS      Any of the input args is invalid.
                                                The requested verification operation is not supported
                                                on the platform
    @retval          #BCM_ERR_NOMEM             Job submission failed due to an internal error.

    @post On successful job submission, @ref PKA_GetAlgExecResult should be called by the
            client to check the status of the submitted job. The #BCM_ERR_OK return value
            from the said API indicates that the signature has been suceessfully verified.
            Also, a shallow copy of all the parametres of type SECUTILS_ConstBigUintType
            is made by the library and is stored in its data structures, so the clients are
            free to discard their instances of these parametres (but the backing storage needs to be
            preserved)

    @trace #BRCM_SWREQ_PKA_LIBRARY
 */
int32_t PKA_EcdsaVerify(const PKA_EcGroup aEcGroup, const SECUTILS_ConstBigUintType *const aPubKeyX, const SECUTILS_ConstBigUintType *const aPubKeyY, const SECUTILS_ConstBigUintType *const aMsgDigest, const SECUTILS_ConstBigUintType *const aSignatureR, const SECUTILS_ConstBigUintType *const aSignatureS, PKA_JobIdType *const aJobId);

/**
    @brief Elliptic curve Diffie-Hellman key exchange algorithm

    This API executes the ECDH/ECDHE algorithm to compute a public key
    and a shared secret

    @behavior Async, Reentrant

    @pre None

    @param[in]       aEcGroup                   Elliptic curve group to use
    @param[in]       aPrivkeyHdl                Secure heap allocation holding the private key
                                                for the ECDH/ECDHE operation
    @param[in]       aRemotePubKeyX             X coordinate of the public key of the remote party
    @param[in]       aRemotePubKeyY             Y coordinate of the public key of the remote party
    @param[out]      aPubKeyX                   X coordinate of the computed public key to be sent to the
                                                remote party. Should have the same size of the corresponding
                                                remote public key coordinate. Can be NULL in which case,
                                                the corresponding computation will be skipped. If this param
                                                is NULL, aPubKeyY should also be NULL
    @param[out]      aPubKeyY                   Y coordinate of the computed public key to be sent to the
                                                remote party.  Should have the same size of the corresponding
                                                remote public key coordinate. Can be NULL in which case,
                                                the corresponding computation will be skipped. If this param
                                                is NULL, aPubKeyX should also be NULL
    @param[out]      aSharedSecretHdl           Handle to the secure heap allocation holding the computed
                                                shared secret
    @param[out]      aJobId                     Handle to the submitted job

    Return values are documented in reverse-chronological order
    @retval          #BCM_ERR_OK                On success
    @retval          #BCM_ERR_INVAL_PARAMS      Any of the input args is invalid.
                                                The requested ECDH/ECDHE operation is not supported
                                                on the platform
    @retval          #BCM_ERR_NOMEM             Job submission failed due to an internal error.

    @post On successful job submission, @ref PKA_GetAlgExecResult should be called by the
            client to check the status of the submitted job. The #BCM_ERR_OK return value
            from the said API indicates that the shared secret has been computed and the
            public key has been written. Also, a shallow copy of all the parametres of type
            SECUTILS_ConstBigUintType is made by the library and is stored in its data structures,
            so the clients are free to discard their instances of these parametres
            (but the backing storage needs to be preserved)

    @trace #BRCM_SWREQ_PKA_LIBRARY
*/
int32_t PKA_Ecdhe(const PKA_EcGroup aEcGroup, const uint32_t aPrivKeyHdl, const SECUTILS_ConstBigUintType *const aRemotePubKeyX, const SECUTILS_ConstBigUintType *const aRemotePubKeyY, SECUTILS_BigUintType *const aPubKeyX, SECUTILS_BigUintType *const aPubKeyY, uint32_t *const aSharedSecretHdl, PKA_JobIdType *const aJobId);

/**
    @brief PKA library algorithm execution result

    The API's to run algorithms provided by this library are asynchronous.
    Job ID's are returned on Successful calls to those async API's. Clients are to call
    this function to check the status of the algorithm execution.

    @behavior Sync, Reentrant

    @pre None

    @param[in]       aJobId                     Handle to a valid job handle
    @param[inout]    aAlgExecResult             Result of the PKA algorithm execution as defined
                                                in the corresponding PKA algorithm API's documentation

    Return values are documented in reverse-chronological order
    @retval         #BCM_ERR_OK                 Success
    @retval         #BCM_ERR_INVAL_PARAMS       aJobId invalid or aAlgExecResult is NULL

    @post If the job ID passed in was valid, and the corresponding algorithm execution finished, this jobID
            is invalidated.

    @trace #BRCM_SWREQ_PKA_LIBRARY
*/
int32_t PKA_GetAlgExecResult(const PKA_JobIdType aJobId, int32_t *const aAlgExecResult);
#endif
/** @} */
