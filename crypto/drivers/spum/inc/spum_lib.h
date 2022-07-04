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
    @defgroup grp_spumlib_ifc SPUM library interface
    @ingroup grp_spum

    @addtogroup grp_spumlib_ifc
    @{
    This library provides API's for the clients to access the symmetric
    crypto primitives implemented in the SPUM HW IP.

    @file spum_lib.h
    @brief Interface File
    This header file contains the interface functions for the SPUM library
    @version 0.1 Initial Version
*/

#ifndef SPUMLIB_H
#define SPUMLIB_H

#include <stdint.h>

#include <bcm_utils.h>

/**
    @name SPUM library Architecture IDs
    @{
    @brief Architecture IDs for the secure heap
*/
#define BRCM_SWARCH_SPUM_MAX_INPUT_DATA_SIZE_MACRO    (0x8601U)    /**< @brief #SPUM_MAX_INPUT_DATA_SIZE */
#define BRCM_SWARCH_SPUM_CRYPT_AUTH_ORDER_TYPE        (0x8602U)    /**< @brief #SPUM_CryptAuthOrderType  */
#define BRCM_SWARCH_SPUM_CRYPT_OP_TYPE                (0x8603U)    /**< @brief #SPUM_CryptOpType         */
#define BRCM_SWARCH_SPUM_CIPHER_ALG_TYPE              (0x8604U)    /**< @brief #SPUM_CipherAlgType       */
#define BRCM_SWARCH_SPUM_CIPHER_MODE_TYPE             (0x8605U)    /**< @brief #SPUM_CipherModeType      */
#define BRCM_SWARCH_SPUM_HASH_ALG_TYPE                (0x8606U)    /**< @brief #SPUM_HashAlgType         */
#define BRCM_SWARCH_SPUM_CRYPT_OPS_TYPE               (0x8607U)    /**< @brief #SPUM_CryptOpsType        */
#define BRCM_SWARCH_SPUM_AUTH_OPS_TYPE                (0x8608U)    /**< @brief #SPUM_AuthOpsType         */
#define BRCM_SWARCH_SPUM_JOBID_TYPE                   (0x8609U)    /**< @brief #SPUM_JobIdType           */
#define BRCM_SWARCH_SPUM_CONTEXT_HANDLE_TYPE          (0x860AU)    /**< @brief #SPUM_ContextHandleType   */
#define BRCM_SWARCH_SPUM_INIT_PROC                    (0x860BU)    /**< @brief #SPUM_Init                */
#define BRCM_SWARCH_SPUM_DEINIT_PROC                  (0x860CU)    /**< @brief #SPUM_Deinit              */
#define BRCM_SWARCH_SPUM_CREATE_CONTEXT_PROC          (0x860DU)    /**< @brief #SPUM_CreateContext       */
#define BRCM_SWARCH_SPUM_DESTROY_CONTEXT_PROC         (0x860EU)    /**< @brief #SPUM_DestroyContext      */
#define BRCM_SWARCH_SPUM_UPDATE_PROC                  (0x860FU)    /**< @brief #SPUM_Update              */
#define BRCM_SWARCH_SPUM_FINISH_PROC                  (0x8610U)    /**< @brief #SPUM_Finish              */
#define BRCM_SWARCH_SPUM_GET_JOB_EXEC_RESULT_PROC     (0x8611U)    /**< @brief #SPUM_GetJobExecResult    */
/** @} */

/**
    @{
    @brief Crypt and auth order

    @trace #BRCM_SWREQ_SPUM_KERNEL_INTERFACE
*/
typedef uint32_t SPUM_CryptAuthOrderType;
#define SPUM_CRYPT_AUTH_ORDER_NONE                          (0UL)
#define SPUM_CRYPT_AUTH_ORDER_CRYPT_THEN_AUTH               (1UL)
#define SPUM_CRYPT_AUTH_ORDER_AUTH_THEN_CRYPT               (2UL)
/** @} */

/**
    @{
    @brief Crypt operation type

    @trace #BRCM_SWREQ_SPUM_KERNEL_INTERFACE
*/
typedef uint32_t SPUM_CryptOpType;
#define SPUM_CRYPT_OP_ENCRYPT                               (0UL)
#define SPUM_CRYPT_OP_DECRYPT                               (1UL)
/** @} */

/**
    @{
    @brief Cipher algorithm type

    @trace #BRCM_SWREQ_SPUM_KERNEL_INTERFACE
*/
typedef uint32_t SPUM_CipherAlgType;
#define SPUM_CIPHER_ALG_AES128                              (0UL)
#define SPUM_CIPHER_ALG_AES192                              (1UL)
#define SPUM_CIPHER_ALG_AES256                              (2UL)
/** @} */

/**
    @{
    @brief Cipher mode type

    @trace #BRCM_SWREQ_SPUM_KERNEL_INTERFACE
*/
typedef uint32_t SPUM_CipherModeType;
#define SPUM_CIPHER_MODE_CBC                                (1UL)
#define SPUM_CIPHER_MODE_CTR                                (4UL)
/** @} */

/**
    @{
    @brief Hash algorithm type

    @trace #BRCM_SWREQ_SPUM_KERNEL_INTERFACE
*/
typedef uint32_t SPUM_HashAlgType;
#define SPUM_HASH_ALG_SHA256                                (0UL)
#define SPUM_HASH_ALG_HMAC_SHA256                           (1UL)
/** @} */

/**
    @brief Crypt operation description

    @trace #BRCM_SWREQ_SPUM_KERNEL_INTERFACE
*/
typedef struct sSPUM_CryptOpsType {
    SPUM_CryptOpType cryptOp;           /**< @brief Encrypt or decrypt                                              */
    SPUM_CipherAlgType cryptAlg;        /**< @brief Cipher algorithm to use                                         */
    SPUM_CipherModeType cipherMode;     /**< @brief Cipher mode to use                                              */
    uint32_t keySecheapHdl;             /**< @brief Secure heap handle containing encryption or a decryption key    */
    const uint8_t *iv;                  /**< @brief Initialization vector as needed by the cipher mode              */
} SPUM_CryptOpsType;

/**
    @brief Auth operation description

    @trace #BRCM_SWREQ_SPUM_KERNEL_INTERFACE
*/
typedef struct sSPUM_AuthOpsType {
    SPUM_HashAlgType hashAlg;           /**< @brief Hash algorithm to use                       */
    uint32_t keySecheapHdl;             /**< @brief Secure heap handle containing the auth key  */
} SPUM_AuthOpsType;

/**
    @brief Handle to a submitted SPUM job

    @trace #BRCM_SWREQ_SPUM_KERNEL_INTERFACE
*/
typedef uint64_t SPUM_JobIdType;

/**
    @brief SPUM driver context handle

    The API's provided by this library allow the clients to run the
    various crypto/auth algorithms in an INIT->UPDATE->FINISH fashion. That is,
    instead of running a crypto/auth algorithm on the entire input data buffer
    in one shot, one can break the buffer up into multiple small chunks and
    call the update() API to process these smaller chunks one at a time.
    To process the last chunk of data, the client would call the finish() API to
    let the driver know that the input data has been exhausted, and the final
    results should now be computed.

    To enable this mode of operation, algorithm execution states will have to be
    tracked by the driver across these update calls, and the hardware needs to be
    setup correctly with the updated state during the job submission. A SPUM driver
    context is a container for all such state.

    One creates a SPUM driver context by calling the @ref SPUM_CreateContext API. The
    crypto/auth algorithms to run are specified at this point. A handle to this context
    is returned to the client.

    The client may then call @ref SPUM_Update zero or more times against this context
    with small chunks of input data. The processing is terminated by the client by a
    call to @ref SPUM_Finish.

    The context handle is automatically invalidated as soon as the @ref SPUM_Finish
    is successfully issued by the client. The invalidation also happens if any of the
    jobs issued against this context cause the hardware to raise errors.

    @trace #BRCM_SWREQ_SPUM_KERNEL_INTERFACE
*/
typedef uint64_t SPUM_ContextHandleType;

/**
    @brief SPUM Driver and hardware initialization

    Initialize the SPUM driver data structures and setup the
    SPUM and the DMA HW engines

    @behavior Sync, Non-reentrant

    @pre None
    @post The driver is ready to accept SPUM jobs

    @trace #BRCM_SWREQ_SPUM_INIT
*/
void SPUM_Init(void);

/**
    @brief SPUM Driver and hardware deinit

    Deinit the SPUM driver data structures and reset the HW

    @behavior Sync, Non-reentrant

    @pre None

    Return values are documented in reverse-chronological order
    @retval         #BCM_ERR_OK                 Success
    @retval         #BCM_ERR_BUSY               Cannot deinit because jobs are in-flight.
                                                Client may retry at a later point

    @post On successful call to this API, HW and all the driver data structures are reset

    @trace #BRCM_SWREQ_SPUM_DEINIT
*/
int32_t SPUM_Deinit(void);

/**
    @brief Create a SPUM driver context

    @behavior Sync, Reentrant

    @pre None

    @param[in]      aCryptOps                   Encryption/decryption operations to be performed. Can be
                                                NULL, in which case no encryption or decryption
                                                operation will be performed on the input buffers
    @param[in]      aAuthOps                    Auth operations to be performed. Can be
                                                NULL, in which case no hash computation
                                                operation will be performed on the input buffers
    @param[in]      aCryptAuthOrder             Order in which to perform the crypt and auth operations
                                                if both are specified. If the context is being setup
                                                with just a crypt operation or just an auth operation,
                                                then this should be set to @ref SPUM_CRYPT_AUTH_ORDER_NONE.
                                                If both crypt and auth operation are being setup, then this
                                                should be set to either @ref SPUM_CRYPT_AUTH_ORDER_CRYPT_THEN_AUTH
                                                or @ref SPUM_CRYPT_AUTH_ORDER_AUTH_THEN_CRYPT
    @param[in]      aAuthOutMemSize             Size of the auth out buffer. If @ref SPUM_HASH_ALG_SHA256 is the
                                                hash algorithm that is being setup, then the buffer size should
                                                be greater than or equal to 32. This parameter should be set to
                                                zero if no auth algorithm is being setup
    @param[in]      aAuthOut                    Buffer to  write the computed hash to. This buffer
                                                will be written to when a job enqueued by @ref SPUM_Finish
    @param[out]      aCtxHdl                    Handle to the newly created context.

    Return values are documented in reverse-chronological order
    @retval          #BCM_ERR_OK                On successful context creation
    @retval          #BCM_ERR_INVAL_PARAMS      If both aCryptOps and aAuthOps are NULL, or if any
                                                of the parametres are inconsistent with others, or are
                                                in bad state
    @retval          #BCM_ERR_NOMEM             Context creation failed because driver couldn't set aside
                                                the needed amount of memory to create a context

    @trace #BRCM_SWREQ_SPUM_LIBRARY
*/
int32_t SPUM_CreateContext(const SPUM_CryptOpsType *const aCryptOps, const SPUM_AuthOpsType *const aAuthOps, const SPUM_CryptAuthOrderType aCryptAuthOrder, const uint32_t aAuthOutMemSize, uint8_t *const aAuthOut, SPUM_ContextHandleType *const aCtxHdl);

/**
    @brief Destroy the SPUM driver context

    This function may be called by the clients if they do need
    a SPUM context anymore.

    As the documentation of @ref SPUM_ContextHandleType notes, the SPUM
    context handle is automatically invalidated after a call to @ref SPUM_Finish
    or if a HW error was seen when a previously submitted job against
    this context was run. The clients are not expected to call this API
    in those situations.

    @behavior Sync, Reentrant

    @param[in]      aCtxHdl                     Context handle corresponding to the context to
                                                destroy

    Return values are documented in reverse-chronological order
    @retval          #BCM_ERR_INVAL_PARAMS      Invalid context handle
    @retval          #BCM_ERR_OK                Context has been sucessfully destroyed

    @trace #BRCM_SWREQ_SPUM_LIBRARY
*/
int32_t SPUM_DestroyContext(const SPUM_ContextHandleType aCtxHdl);

/**
    @brief Update the crypto/auth computations given a new chunk of input data

    Refer to the documentation of @ref SPUM_ContextHandleType for furthur
    information

    @behavior Async, Reentrant

    @pre None

    @param[in]      aCtxHdl                     Context handle against which the SPUM job is to be
                                                issued
    @param[in]      aDataInSize                 Input data size in bytes
    @param[in]      aDataIn                     Buffer containing the input data
    @param[in]      aCryptOut                   Buffer to write the output of the crypt operation to.
                                                Should be NULL if the context was setup without a crypt
                                                operation. This buffer contains a valid crypt output
                                                once the submitted SPUM job resolves
    @param[in]      aJobId                      Handle to the submitted job

    Return values are documented in reverse-chronological order
    @retval          #BCM_ERR_OK                On successful job submission
    @retval          #BCM_ERR_INVAL_PARAMS      If any of the input parametres are inconsistent with
                                                others, or do not meet the defined criteria
    @retval          #BCM_ERR_NOMEM             Job submission failed due to an internal error

    @post After successful job submission, the client may query the status of the job execution by calling
            the @ref SPUM_GetJobExecResult API. *aJobExecResult is set to #BCM_ERR_OK if the job submitted
            resolved successfully. Else, it is set to #BCM_ERR_INVAL_STATE

    @limitations
        -# If the context was setup with a crypt operation, then the aDataInSize parameter
           should be a multiple of 16 (AES block size)
        -# If the context was setup with a @ref SPUM_HASH_ALG_SHA256 operation, then aDataInSize
           parameter should be a multiple of 64 (SHA256 block size)

    @trace #BRCM_SWREQ_SPUM_LIBRARY
*/
int32_t SPUM_Update(const SPUM_ContextHandleType aCtxHdl, const uint32_t aDataInSize, const uint8_t *const aDataIn, uint8_t *const aCryptOut, SPUM_JobIdType *const aJobId);

/**
    @brief Finish the crypto/auth computations given a the last chunk of input data

    Refer to the documentation of @ref SPUM_ContextHandleType for furthur
    information

    @behavior Async, Reentrant

    @pre None

    @param[in]      aCtxHdl                     Context handle against which the SPUM job is to be
                                                issued
    @param[in]      aDataInSize                 Input data size in bytes. Can be zero bytes.
    @param[in]      aDataIn                     Buffer containing the input data. Should be NULL when
                                                aDataInSize is zero.
    @param[in]      aCryptOut                   Buffer to write the output of the crypt operation to.
                                                Should be NULL if the context was setup without a crypt
                                                operation. This buffer contains a valid crypt output
                                                once the submitted SPUM job resolves. Should be NULL
                                                when aDataIn is NULL
    @param[in]      aJobId                      Handle to the submitted job

    Return values are documented in reverse-chronological order
    @retval          #BCM_ERR_OK                On successful job submission
    @retval          #BCM_ERR_INVAL_PARAMS      If any of the input parametres are inconsistent with
                                                others, or do not meet the defined criteria
    @retval          #BCM_ERR_NOMEM             Job submission failed due to an internal error

    @post After successful job submission, the client may query the status of the job execution by calling
            the @ref SPUM_GetJobExecResult API. *aJobExecResult is set to #BCM_ERR_OK if the job submitted
            resolved successfully. Else, it is set to #BCM_ERR_INVAL_STATE. The context handle will be
            invalidated immediately after this function successfully returns.

    @limitations
        -# If the context was setup with @ref SPUM_CIPHER_MODE_CBC, then the aDataInSize parameter
           should be a multiple of 16 (AES block size)

    @trace #BRCM_SWREQ_SPUM_LIBRARY
*/
int32_t SPUM_Finish(const SPUM_ContextHandleType aCtxHdl, const uint32_t aDataInSize, const uint8_t *const aDataIn, uint8_t *const aCryptOut, SPUM_JobIdType *const aJobId);

/**
    @brief Get SPUM job execution result

    The API's to run algorithms provided by this library are asynchronous.
    Job ID's are returned on successful calls to those async API's. Clients are to call
    this function to check the status of the algorithm execution.

    @behavior Sync, Reentrant

    @pre None

    @param[in]       aJobId                     Handle to a valid job handle
    @param[inout]    aJobExecResult             Result of the SPUM job execution

    Return values are documented in reverse-chronological order
    @retval         #BCM_ERR_OK                 Success
    @retval         #BCM_ERR_INVAL_PARAMS       aJobId invalid or aJobExecResult is NULL

    @post If the job ID passed in was valid, and the corresponding job execution finished, this jobID
            is invalidated.

    @trace #BRCM_SWREQ_SPUM_LIBRARY
*/
int32_t SPUM_GetJobExecResult(const SPUM_JobIdType aJobId, int32_t *const aJobExecResult);

#endif /* SPUMLIB_H */
/** @} */
