/*****************************************************************************
 Copyright 2020 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_rand_ifc random library interface
    @ingroup grp_rand

    @addtogroup grp_rand_ifc
    @{
    This library provides API's for the clients to obtain a sequence
    of independent and unbiased random bits or random numbers sampled
    from a uniform distribution defined over a client requested range

    @file rand_lib.h
    @brief Interface File
    This header file contains the interface functions for the random library
    @version 0.1 Initial Version
*/
#ifndef RANDLIB_H
#define RANDLIB_H

#include <stdint.h>

#include <secutils.h>
#include <bcm_utils.h>

/**
    @name rand library Architecture IDs
    @{
    @brief Architecture IDs for the rand library
*/
#define BRCM_SWARCH_RAND_MAX_NUM_RAND_WORDS_MACRO    (0x8401U)    /**< @brief #RAND_MAX_NUM_RAND_WORDS */
#define BRCM_SWARCH_RAND_JOBID_TYPE                  (0x8402U)    /**< @brief #RAND_JobIdType          */
#define BRCM_SWARCH_RAND_INPUT_TYPE                  (0x8403U)    /**< @brief #RAND_InputType          */
#define BRCM_SWARCH_RAND_OUTPUT_TYPE                 (0x8404U)    /**< @brief #RAND_OutputType         */
#define BRCM_SWARCH_RAND_INIT_PROC                   (0x8405U)    /**< @brief #RAND_Init               */
#define BRCM_SWARCH_RAND_DEINIT_PROC                 (0x8406U)    /**< @brief #RAND_Deinit             */
#define BRCM_SWARCH_RAND_GET_RAND_UINT_PROC          (0x8407U)    /**< @brief #RAND_GetRandUInt        */
#define BRCM_SWARCH_RAND_GET_JOB_EXEC_RESULT_PROC    (0x8408U)    /**< @brief #RAND_GetJobExecResult   */
/** @} */

/**
    @brief Refer to the documentation of the @ref RAND_RandUInt API

    @trace #BRCM_SWREQ_RAND_LIBRARY
*/
#define RAND_MAX_NUM_RAND_WORDS                         (64UL)

/**
    @brief Handle to a submitted job

    @trace #BRCM_SWREQ_RAND_KERNEL_INTERFACE
*/
typedef uint64_t RAND_JobIdType;

/**
    @{
    @brief Input type accepted by the @ref RAND_GetRandUInt API

    This data type allows the library clients to supply inputs that
    are either allocated on secure heap or are in the client allocated buffers.

    In either case, the data is interpreted as specified by the
    @ref SECUTILS_ConstBigUintType documentation.

    @trace #BRCM_SWREQ_RAND_KERNEL_INTERFACE
*/
typedef struct sRAND_InputType {
    uint32_t tag;                       /**< @brief Union member selection tag                          */
    uint32_t numWords;                  /**< @brief Number of valid words in the input allocation       */
    union {
        uint32_t inputHdl;              /**< @brief Secure heap handle containing the BigNum input      */
        const uint32_t *inputBuffer;    /**< @brief Client allocated buffer containing the BigNum input */
    };
} RAND_InputType;
#define RAND_INPUT_TAG_CLIENT_BUFFER        (0UL)
#define RAND_INPUT_TAG_SECURE_HEAP          (1UL)
/** @} */

/**
    @{
    @brief Output type accepted by the @ref RAND_GetRandWords and @ref RAND_GetRandUInt APIs

    This data type allows the library clients to request the output generated
    by the said APIs to be written to either a secure heap allocation or a client
    supplied buffer.

    In either case, if a BigUint is being written, the written data is to be
    interpreted as specified by the @ref SECUTILS_ConstBigUintType documentation.

    @trace #BRCM_SWREQ_RAND_KERNEL_INTERFACE
*/
typedef struct sRAND_OutputType {
    uint32_t tag;                   /**< @brief Union member selection tag                                              */
    uint32_t numWords;              /**< @brief Number of valid words in the input allocation                           */
    union {
        uint32_t outputHdl;         /**< @brief Secure heap handle is to which the output is to be written              */
        uint32_t *outputBuffer;     /**< @brief Client allocated buffer to which the output is to be written            */
    };
} RAND_OutputType;
#define RAND_OUTPUT_TAG_CLIENT_BUFFER      (0UL)
#define RAND_OUTPUT_TAG_SECURE_HEAP        (1UL)
/** @} */

/**
    @brief Rand library and RBG200 initialization

    Initialize the rand library data structures and reset the HW

    @behavior Sync, Non-reentrant

    @pre None
    @post The library is ready to accept the new jobs

    @trace #BRCM_SWREQ_RAND_INIT
*/
void RAND_Init(void);

/**
    @brief Rand library and RBG200 de-initialization

    De-initialize the rand library data structures and reset the HW

    @behavior Sync, Non-reentrant

    @pre Driver initialized

    Return values are documented in reverse-chronological order
    @retval             #BCM_ERR_OK             On Success
    @retval             #BCM_ERR_BUSY           Cannot de-init the library because of the
                                                pending jobs. Caller may retry later

    @post RBG200 and the library data structures are reset

    @trace #BRCM_SWREQ_RAND_DEINIT
*/
int32_t RAND_Deinit(void);

/**
    @brief Obtain a random unsigned integer sampled from a uniform distribution with support [aLo, aHi]

    @behavior Async, Non-reentrant

    @pre None

    @param[in]          aLo                     Lo integer. If NULL is passed, aLo is assumed to be zero.
    @param[in]          aHi                     Hi integer. If NULL is passed, aHi is assumed to be the
                                                highest number that the allocation provided by aRandNumber
                                                parameter can hold
    @param[inout]       aRandNumber             Output description
    @param[inout]       aJobId                  Handle to the submitted job

    Return values are documented in reverse-chronological order
    @retval             #BCM_ERR_OK             On successful job submission
    @retval             #BCM_ERR_INVAL_PARAMS   aJobId is NULL, aRandNumber is NULL
    @retval             #BCM_ERR_NOMEM          Job submission failed due to an internal error

    @post After successful job submission, the client may query the status of the job execution by calling
            the @ref RAND_GetJobExecResult API. *aJobExecResult is set to
                - #BCM_ERR_OK if the job submitted resolved successfully.
                - #BCM_ERR_INVAL_STATE if an error was encountered while executing the job
                - #BCM_ERR_INVAL_PARAMS if aLo, aHi and aRandNumber are invalid or are inconsistent
                - #BCM_ERR_BUSY if the submitted job hasn't resolved yet

    @trace #BRCM_SWREQ_RAND_LIBRARY
*/
int32_t RAND_GetRandUInt(const RAND_InputType *const aLo, const RAND_InputType *const aHi, RAND_OutputType *const aRandNumber, RAND_JobIdType *const aJobId);

/**
    @brief Get the job execution result

    The API's to obtain the random bits and numbers provided by this library are asynchronous.
    Job ID's are returned on successful calls to those async API's. Clients are to call
    this function to check the status of the job execution.

    @behavior Sync, Reentrant

    @pre None

    @param[in]       aJobId                     Handle to a valid job handle
    @param[inout]    aJobExecResult             Job execution result

    Return values are documented in reverse-chronological order
    @retval         #BCM_ERR_OK                 Success
    @retval         #BCM_ERR_INVAL_PARAMS       aJobId invalid or aJobExecResult is NULL

    @post If the job ID passed in was valid, and the corresponding job execution finished, this jobID
            is invalidated.

    @trace #BRCM_SWREQ_RAND_LIBRARY
*/
int32_t RAND_GetJobExecResult(const RAND_JobIdType aJobId, int32_t *const aJobExecResult);

#endif /* RANDLIB_H */

/** @} */
