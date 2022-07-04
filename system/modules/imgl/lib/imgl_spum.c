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
    @defgroup grp_imgl_security_impl Hash Implementation
    @ingroup grp_imgl

    @addtogroup grp_imgl_security_impl
    @{

    @file imgl_spum.c
    @brief IMGL Security Implementation
    This source file contains the implementation of functions for IMGL Security

    @version 0.1 Initial version
*/

#include <stdlib.h>
#include <compiler.h>
#include <imgl_security.h>
#include <bcm_utils.h>
#include <spum_lib.h>
#include <sha.h>
#include <rsa.h>
#include <bcm_err.h>

/**
    @name IMGL Security Design IDs
    @{
    @brief Design IDs for IMGL Security
*/
#define BRCM_SWDSGN_IMGL_HASH_STATE_TYPE        (0xB301U)    /**< @brief #IMGL_HashStateType   */
#define BRCM_SWDSGN_IMGL_HASH_CONTEXT_TYPE      (0xB302U)    /**< @brief #IMGL_HashContextType */
#define BRCM_SWDSGN_IMGL_HASH_CONTEXT_GLOBAL    (0xB303U)    /**< @brief #IMGL_HashContext     */
#define BRCM_SWDSGN_IMGL_HASH_INIT_PROC         (0xB304U)    /**< @brief #IMGL_HashInit        */
#define BRCM_SWDSGN_IMGL_HASH_HDR_REQ_PROC      (0xB305U)    /**< @brief #IMGL_HashHdrReq      */
#define BRCM_SWDSGN_IMGL_HASH_REQ_PROC          (0xB306U)    /**< @brief #IMGL_HashDataReq     */
#define BRCM_SWDSGN_IMGL_HASH_STATUS_PROC       (0xB307U)    /**< @brief #IMGL_HashStatus      */
#define BRCM_SWDSGN_IMGL_HASH_CANCEL_PROC       (0xB308U)    /**< @brief #IMGL_HashCancel      */
#define BRCM_SWDSGN_IMGL_HASH_DEINIT_PROC       (0xB309U)    /**< @brief #IMGL_HashDeinit      */

/** @} */

/**
    @name IMGL_HashStateType
    @{
    @brief Imgl Hashing state

    @trace #BRCM_SWARCH_IMGL_HASH_DEINIT_PROC
    @trace #BRCM_SWARCH_IMGL_HASH_CANCEL_PROC
    @trace #BRCM_SWARCH_IMGL_HASH_STATUS_PROC
    @trace #BRCM_SWARCH_IMGL_HASH_REQ_PROC
    @trace #BRCM_SWARCH_IMGL_HASH_INIT_PROC
    @trace #BRCM_SWREQ_IMGL_CORE_SPUM
*/
typedef uint32_t IMGL_HashStateType; /**< @brief */
#define IMGL_HASH_STATE_UNINIT     (0UL)   /**< @brief UNINIT state. This value must be zero */
#define IMGL_HASH_STATE_INIT       (1UL)   /**< @brief Init/Idle state  */
#define IMGL_HASH_STATE_BUSY       (2UL)   /**< @brief Processing Request */
#define IMGL_HASH_STATE_READY      (3UL)   /**< @brief Result is Ready to fetch */
/** @} */

/**
    @brief IMGL Hashing context

    @trace #BRCM_SWARCH_IMGL_HASH_INIT_PROC
    @trace #BRCM_SWREQ_IMGL_CORE_SPUM

 */
typedef struct sIMGL_HashContextType {
    IMGL_HashStateType  state;
    IMGL_HashType       hashType;
    uint32_t            byteConsumed;
    uint8_t             digestHash[SHA256_S_DIGEST8];
    uint32_t            crc;
    SPUM_AuthOpsType    authOps;
    SPUM_CryptAuthOrderType cryptAuthOrder;
    SPUM_ContextHandleType ctxHdl;
    SPUM_JobIdType      job;
} IMGL_HashContextType;

/**
    @brief Global context for IMGL_HashContext

    @anchor IMGL_HashContext
    @trace #BRCM_SWARCH_IMGL_HASH_DEINIT_PROC
    @trace #BRCM_SWARCH_IMGL_HASH_CANCEL_PROC
    @trace #BRCM_SWARCH_IMGL_HASH_STATUS_PROC
    @trace #BRCM_SWARCH_IMGL_HASH_REQ_PROC
    @trace #BRCM_SWARCH_IMGL_HASH_INIT_PROC
    @trace #BRCM_SWREQ_IMGL_CORE_SPUM
*/
static IMGL_HashContextType IMGL_HashContext[IMGL_HASH_CHAN_CNT];


/** @brief Initilize Hasher for specific channel

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aChan               Hasher Channel
    @param[in]      aType               Hasher Type

    @return     int32_t

    @post None

    @trace #BRCM_SWARCH_IMGL_HASH_TYPE
    @trace #BRCM_SWARCH_IMGL_HASH_CHAN_TYPE
    @trace #BRCM_SWARCH_IMGL_HASH_INIT_PROC
    @trace #BRCM_SWREQ_IMGL_CORE_SPUM

    @code{.unparsed}
    retVal = BCM_ERR_OK
    if IMGL_HASH_MAX_NUM < aType || IMGL_HASH_CHAN_CNT <= aChan
        retVal = BCM_ERR_INVAL_PARAMS
    else
        switch aType
            case IMGL_HASH_SHA_256:
                SHA_Init256(digestHash)
                break
            deafult:
                retVal = BCM_ERR_NOSUPPORT
                break

        Update the imgl Hashing Type for aChan
        Update the imgl Hashing state for aChan to IMGL_HASH_STATE_INIT
        Reset byteConsumed to 0UL
    @endcode

*/
int32_t IMGL_HashInit(IMGL_HashChanType aChan, IMGL_HashType aType)
{
    int32_t retVal = BCM_ERR_OK;

    if ((IMGL_HASH_MAX_NUM < aType)
            || (IMGL_HASH_CHAN_CNT <= aChan)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        switch(aType) {
            case IMGL_HASH_SHA_256:
                IMGL_HashContext[aChan].authOps.hashAlg = SPUM_HASH_ALG_SHA256;
                retVal = SPUM_CreateContext(NULL, &IMGL_HashContext[aChan].authOps,
                                        SPUM_CRYPT_AUTH_ORDER_NONE, SHA256_S_DIGEST8,
                                        IMGL_HashContext[aChan].digestHash,
                                        &IMGL_HashContext[aChan].ctxHdl);
                break;
            case IMGL_HASH_CRC_32:
                IMGL_HashContext[aChan].crc = ~0UL;
                break;
            default:
                retVal = BCM_ERR_NOSUPPORT;
                break;
        }
    }

    if (BCM_ERR_OK == retVal) {
        IMGL_HashContext[aChan].hashType = aType;
        IMGL_HashContext[aChan].state = IMGL_HASH_STATE_INIT;
        IMGL_HashContext[aChan].byteConsumed = 0UL;
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_IMGL_HASH_REQ_PROC
    @trace #BRCM_SWREQ_IMGL_CORE_SPUM
*/
int32_t IMGL_HashHdrReq(IMGL_HashChanType aChan, const IMGL_ImgHdrType *aImgHdr)
{
    int32_t retVal = BCM_ERR_OK;

    if ((NULL == aImgHdr)
            || (IMGL_HASH_CHAN_CNT <= aChan)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if ((IMGL_HASH_STATE_UNINIT == IMGL_HashContext[aChan].state)
            || (IMGL_HASH_STATE_READY == IMGL_HashContext[aChan].state)) {
        retVal = BCM_ERR_INVAL_STATE;
    } else {
        switch(IMGL_HashContext[aChan].hashType) {
            case IMGL_HASH_CRC_32:
                IMGL_HashContext[aChan].crc = BCM_CRC32Custom(aImgHdr->iv,
                                                               sizeof(IMGL_ImgHdrType) - IMGL_IMGH_DWNLD_HDR_SIZE,
                                                               0x04C11DB7UL,
                                                               IMGL_HashContext[aChan].crc);
                break;
            case IMGL_HASH_SHA_256:
                retVal = SPUM_Update(IMGL_HashContext[aChan].ctxHdl, sizeof(aImgHdr->version), (uint8_t*)&aImgHdr->version,
                                        NULL, &IMGL_HashContext[aChan].job);
                IMGL_HashContext[aChan].state = IMGL_HASH_STATE_BUSY;
                IMGL_HashContext[aChan].byteConsumed += sizeof(aImgHdr->version);
                break;
            default:
                retVal = BCM_ERR_INVAL_STATE;
                break;

        }
    }

    if (BCM_ERR_OK == retVal) {
        IMGL_HashContext[aChan].state = IMGL_HASH_STATE_BUSY;
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_IMGL_HASH_REQ_PROC
    @trace #BRCM_SWREQ_IMGL_CORE_SPUM


    @code{.c}
    retVal = BCM_ERR_OK
    blockCount = (aSize / 64UL)
    byteRemaining = (aSize % 64UL)

    if NULL == aInput || IMGL_HASH_CHAN_CNT <= aChan
        retVal = BCM_ERR_INVAL_PARAMS
    else if IMGL_HASH_STATE_UNINIT == state || IMGL_HASH_STATE_READY == state
        retVal = BCM_ERR_INVAL_STATE
    else
        if blockCount != 0UL
            if byteCount == 0UL
                bitsRemaining = SHA_Update256(digest, aInput, aSize * 8UL)
                state = IMGL_HASH_STATE_BUSY
                byteConsumed += aSize
            else
                SHA_Final256(digest, aInput, (byteConsumed + aSize) * 8UL, aSize * 8UL)
                state = IMGL_HASH_STATE_READY
        else
            SHA_Final256(digest, aInput, (byteConsumed + aSize) * 8UL, aSize * 8UL)
            state = IMGL_HASH_STATE_READY

     return retVal

    @endcode
*/
int32_t IMGL_HashDataReq(IMGL_HashChanType aChan, const uint8_t *aInput, uint32_t aSize, uint32_t aMoreData)
{
    int32_t retVal = BCM_ERR_OK;

    /* NULL pointer check is removed for Leo FW load which needs zero address */
    if ((IMGL_HASH_CHAN_CNT <= aChan)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if ((IMGL_HASH_STATE_UNINIT == IMGL_HashContext[aChan].state)
            || (IMGL_HASH_STATE_READY == IMGL_HashContext[aChan].state)) {
        retVal = BCM_ERR_INVAL_STATE;
    } else if (0ULL != IMGL_HashContext[aChan].job) {
            retVal = BCM_ERR_BUSY;
    } else {
        switch (IMGL_HashContext[aChan].hashType) {
            case IMGL_HASH_SHA_256:
                /*Check the status of previous call in case of HW Hashing*/
                if (aMoreData == 0UL) {
                    retVal = SPUM_Finish(IMGL_HashContext[aChan].ctxHdl, aSize, aInput,
                                            NULL, &IMGL_HashContext[aChan].job);
                    IMGL_HashContext[aChan].state = IMGL_HASH_STATE_READY;
                } else {
                    retVal = SPUM_Update(IMGL_HashContext[aChan].ctxHdl, aSize, aInput,
                                        NULL, &IMGL_HashContext[aChan].job);
                    IMGL_HashContext[aChan].state = IMGL_HASH_STATE_BUSY;
                }
                IMGL_HashContext[aChan].byteConsumed += aSize;
                break;
            case IMGL_HASH_CRC_32:
                IMGL_HashContext[aChan].crc = BCM_CRC32Custom(aInput, aSize, 0x04C11DB7UL, IMGL_HashContext[aChan].crc);
                break;
            default:
                retVal = BCM_ERR_INVAL_PARAMS;
                break;
        }
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_IMGL_HASH_STATUS_PROC
    @trace #BRCM_SWREQ_IMGL_CORE_SPUM


    @code{.c}
    retVal = BCM_ERR_OK
    if IMGL_HASH_CHAN_CNT <= aChannn/
        retVal = BCM_ERR_INVAL_PARAMS
    else if IMGL_HASH_STATE_UNINIT == state
        retVal = BCM_ERR_INVAL_STATE
    else if NULL != aHash && NULL != aHashSize
        if SHA256_S_DIGEST8 > *aHashSize
            retVal = BCM_ERR_NOMEM
        else
            if IMGL_HASH_STATE_BUSY == state
                SHA_Final256(digest, &emptyBuf, byteConsumed * 8UL, 0UL);
                state = IMGL_HASH_STATE_READY;

            if IMGL_HASH_STATE_READY == state
                BCM_MemCpy(aHash, digestHash, SHA256_S_DIGEST8)
                *aHashSize = SHA256_S_DIGEST8
                byteConsumed = 0UL
                SHA_Init256(digestHash);
                state = IMGL_HASH_STATE_INIT
            else
                retVal = BCM_ERR_INVAL_STATE

    else
        retVal = BCM_ERR_OK

    return retVal

    @endcode
*/
int32_t IMGL_HashStatus(IMGL_HashChanType aChan, uint8_t *const aHash, uint32_t *aHashSize)
{
    int32_t retVal = BCM_ERR_OK;

    if (IMGL_HASH_CHAN_CNT <= aChan) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (IMGL_HASH_STATE_UNINIT == IMGL_HashContext[aChan].state) {
        retVal = BCM_ERR_INVAL_STATE;
    } else if ((NULL != aHash)
            && (NULL != aHashSize)) {
        switch (IMGL_HashContext[aChan].hashType) {
            case IMGL_HASH_SHA_256:
                if (SHA256_S_DIGEST8 > *aHashSize) {
                    retVal = BCM_ERR_NOMEM;
                } else {
                    int32_t jobResult;
                    retVal = SPUM_GetJobExecResult(IMGL_HashContext[aChan].job, &jobResult);
                    if ((BCM_ERR_OK == retVal) && (BCM_ERR_OK == jobResult)) {
                        IMGL_HashContext[aChan].job = 0;
                        BCM_MemCpy((void*) aHash, (void*)IMGL_HashContext[aChan].digestHash, SHA256_S_DIGEST8);
                        *aHashSize = SHA256_S_DIGEST8;
                        IMGL_HashContext[aChan].byteConsumed = 0UL;
                        IMGL_HashContext[aChan].state = IMGL_HASH_STATE_INIT;
                    } else {
                        retVal = BCM_ERR_BUSY;
                    }
                }
                break;
            case IMGL_HASH_CRC_32:
                aHash[0] = IMGL_HashContext[aChan].crc & 0xFFU;
                aHash[1] = (IMGL_HashContext[aChan].crc & 0xFF00U) >> 8U;
                aHash[2] = (IMGL_HashContext[aChan].crc & 0xFF0000U) >> 16U;
                aHash[3] = (IMGL_HashContext[aChan].crc & 0xFF000000U) >> 24U;
                *aHashSize = 4UL;
                IMGL_HashContext[aChan].crc = ~0UL;
                break;
            default:
                retVal = BCM_ERR_INVAL_PARAMS;
                break;
        }
    } else {
        int32_t jobResult;
        switch (IMGL_HashContext[aChan].hashType) {
            case IMGL_HASH_SHA_256:
                retVal = SPUM_GetJobExecResult(IMGL_HashContext[aChan].job, &jobResult);
                if ((BCM_ERR_OK == retVal) && (BCM_ERR_OK == jobResult)) {
                    IMGL_HashContext[aChan].job = 0;
                    retVal = BCM_ERR_OK;
                } else {
                    retVal = BCM_ERR_BUSY;
                }
            break;
            case IMGL_HASH_CRC_32:
                retVal = BCM_ERR_OK;
            break;
            default:
            break;
        }
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_IMGL_HASH_CANCEL_PROC
    @trace #BRCM_SWREQ_IMGL_CORE_SPUM


    @code{.c}
    retVal = BCM_ERR_OK

    if IMGL_HASH_CHAN_CNT <= aChan
        retVal = BCM_ERR_INVAL_PARAMS
    else if IMGL_HASH_STATE_BUSY != state
        retVal = BCM_ERR_INVAL_STATE
    else
        SHA_Init256(digestHash)
        state = IMGL_HASH_STATE_INIT
        byteConsumed = 0UL

    return retVal

    @endcode
*/
int32_t IMGL_HashCancel(IMGL_HashChanType aChan)
{
    int32_t retVal = BCM_ERR_OK;

    if (IMGL_HASH_CHAN_CNT <= aChan) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (IMGL_HASH_STATE_BUSY != IMGL_HashContext[aChan].state) {
        retVal = BCM_ERR_INVAL_STATE;
    } else {
        IMGL_HashContext[aChan].state = IMGL_HASH_STATE_INIT;
        IMGL_HashContext[aChan].byteConsumed = 0UL;
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_IMGL_HASH_DEINIT_PROC
    @trace #BRCM_SWREQ_IMGL_CORE_SPUM

    @code{.c}
    retVal = BCM_ERR_OK
    if IMGL_HASH_CHAN_CNT <= aChan
        retVal = BCM_ERR_INVAL_PARAMS
    else if IMGL_HASH_STATE_BUSY = state
        retVal = BCM_ERR_BUSY
    else
        state = IMGL_HASH_STATE_UNINIT

    return retVal

    @endcode
*/
int32_t IMGL_HashDeinit(IMGL_HashChanType aChan)
{
    int32_t retVal = BCM_ERR_OK;

    if (IMGL_HASH_CHAN_CNT <= aChan) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (IMGL_HASH_STATE_BUSY == IMGL_HashContext[aChan].state) {
        retVal = BCM_ERR_BUSY;
    } else {
        if (SPUM_HASH_ALG_SHA256 == IMGL_HashContext[aChan].authOps.hashAlg) {
            SPUM_DestroyContext(IMGL_HashContext[aChan].ctxHdl);
        }
        IMGL_HashContext[aChan].state = IMGL_HASH_STATE_UNINIT;
    }

    return retVal;

}

/** @} */
