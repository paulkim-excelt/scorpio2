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
    @defgroup grp_crypto_verify_hw_mod_impl Crypto verify HW module Implementation
    @ingroup grp_crypto_abstract

    @addtogroup grp_crypto_verify_hw_mod_impl
    @{

    @file verify_hw_mod.c
    @brief module design for Crypto verify HW module

    @version 0.1 Initial version
*/

#include <bcm_err.h>
#include <stdlib.h>
#include <module.h>
#include <bcm_utils.h>
#include <osil/bcm_osil.h>
#include <osil/module_osil.h>
#include <crypto_module.h>
#include <crypto_verify.h>
#include <crypto_osil.h>
#include <ee.h>
#include <bcm_osil.h>
#include <pka_lib.h>
#include <spum_lib.h>
#include <mcu.h>

#ifndef OTP_SKIP_PUBKEY_READ
#include <otp_module.h>
#endif

/**
    @name Design IDs
    @{
    @brief Design IDs for Crypto verify software module
*/
#define BRCM_SWDSGN_CRYPTO_VERIFY_HW_NUM_MACRO                  (0xA101U)   /**< @brief #CRYPTO_VERIFY_HW_NUM_CTX           */
#define BRCM_SWDSGN_CRYPTO_VERIFY_HW_EVENT_MASK_MACRO           (0xA102U)   /**< @brief #CRYPTO_VERIFY_HW_EVENT_MASK        */
#define BRCM_SWDSGN_CRYPTO_VERIFY_HW_ALGO_CTX_STATE_TYPE        (0xA103U)   /**< @brief #CRYPTO_VerifyHWAlgoCtxStateType    */
#define BRCM_SWDSGN_CRYPTO_VERIFY_HW_ALGOCONTEXT_TYPE           (0xA104U)   /**< @brief #CRYPTO_VerifyHWAlgoCtxType         */
#define BRCM_SWDSGN_CRYPTO_VERIFY_HW_MODCONTEXT_TYPE            (0xA105U)   /**< @brief #CRYPTO_VerifyHWModCtxType          */
#define BRCM_SWDSGN_CRYPTO_VERIFY_HW_MODCONTEXT_GLOBAL          (0xA106U)   /**< @brief #CRYPTO_VerifyHWModCtx              */
#define BRCM_SWDSGN_CRYPTO_VERIFY_HW_MODMVK_GLOBAL              (0xA107U)   /**< @brief #CRYPTO_VerifyHWModMVK              */
#define BRCM_SWDSGN_CRYPTO_VERIFY_HW_MSGQCONTEXT_GLOBAL         (0xA108U)   /**< @brief #CRYPTO_VerifyHWMsgQCtx             */
#define BRCM_SWDSGN_CRYPTO_VERIFY_HW_RSA2K_EXPONENT_GLOBAL      (0xA109U)   /**< @brief #CRYPTO_VerifyHWRSA2KExponent       */
#define BRCM_SWDSGN_CRYPTO_VERIFY_HW_GET_MSG_PROC               (0xA10AU)   /**< @brief #CRYPTO_VerifyHWGetMsg              */
#define BRCM_SWDSGN_CRYPTO_VERIFY_HW_MOD_REPORT_ERROR_PROC      (0xA10BU)   /**< @brief #CRYPTO_VerifyHWModReportError      */
#define BRCM_SWDSGN_CRYPTO_VERIFY_HW_INIT_BIGUINT_LIMBS_PROC    (0xA10CU)   /**< @brief #CRYPTO_VerifyHWInitBigUintLimbs    */
#define BRCM_SWDSGN_CRYPTO_VERIFY_HW_RESET_STATE_HANDLER_PROC   (0xA10DU)   /**< @brief #CRYPTO_VerifyHWResetStateHandler   */
#define BRCM_SWDSGN_CRYPTO_VERIFY_HW_UNINIT_CTX_PROC            (0xA10EU)   /**< @brief #CRYPTO_VerifyHWUninitCtx           */
#define BRCM_SWDSGN_CRYPTO_VERIFY_HW_VALIDATE_INIT_PARAMS_PROC  (0xA10FU)   /**< @brief #CRYPTO_VerifyHWValidateInitParams  */
#define BRCM_SWDSGN_CRYPTO_VERIFY_HW_PROCESS_INIT_MSG_PROC      (0xA110U)   /**< @brief #CRYPTO_VerifyHWProcessInitMsg      */
#define BRCM_SWDSGN_CRYPTO_VERIFY_HW_DIGEST_SUBMIT_PROC         (0xA111U)   /**< @brief #CRYPTO_VerifyHWDigestSubmit        */
#define BRCM_SWDSGN_CRYPTO_VERIFY_HW_DIGEST_DONE_PROC           (0xA112U)   /**< @brief #CRYPTO_VerifyHWDigestDone          */
#define BRCM_SWDSGN_CRYPTO_VERIFY_HW_RSA2K_SUBMIT_PROC          (0xA113U)   /**< @brief #CRYPTO_VerifyHWRSA2KSubmit         */
#define BRCM_SWDSGN_CRYPTO_VERIFY_HW_SIGVERIF_SUBMIT_PROC       (0xA114U)   /**< @brief #CRYPTO_VerifyHWSigVerifSubmit      */
#define BRCM_SWDSGN_CRYPTO_VERIFY_HW_SIGVERIF_DONE_PROC         (0xA115U)   /**< @brief #CRYPTO_VerifyHWSigVerifDone        */
#define BRCM_SWDSGN_CRYPTO_VERIFY_HW_PROCESS_UPDATE_MSG_PROC    (0xA116U)   /**< @brief #CRYPTO_VerifyHWProcessUpdateMsg    */
#define BRCM_SWDSGN_CRYPTO_VERIFY_HW_PROCESS_MSG_PROC           (0xA117U)   /**< @brief #CRYPTO_VerifyHWProcessMsg          */
#define BRCM_SWDSGN_CRYPTO_VERIFY_HW_EVENT_HANDLER_PROC         (0xA118U)   /**< @brief #CRYPTO_VerifyHWEventHandler        */
#define BRCM_SWDSGN_CRYPTO_VERIFY_HW_GET_EVENT_MASK_PROC        (0xA119U)   /**< @brief #CRYPTO_VerifyHWGetEventMask        */
#define BRCM_SWDSGN_CRYPTO_VERIFY_HW_MODULE_GLOBAL              (0xA11AU)   /**< @brief #CRYPTO_VerifyModule                */
/** @} */

/**
    @name CRYPTO Verify Size Macros
    @{
    @brief Crypto Verify Size Macros

    @trace #BRCM_SWARCH_CRYPTO_VERIFY_MODULE_GLOBAL
    @trace #BRCM_SWREQ_CRYPTO_VERIFY_HARDWARE
**/
#define CRYPTO_VERIFY_HW_NUM_CTX          (1UL << CRYPTO_VERIFY_NUM_CTX_LOG2)         /**< @brief Crypto Verify context Size */
#define CRYPTO_VERIFY_HW_NUM_MSG_PER_CTX  (1UL << CRYPTO_VERIFY_NUM_MSG_PER_CTX_LOG2) /**< @brief Crypto Verify message Size per context */
/** @} */

/**
    @brief Crypto verify HW module event mask

    @trace #BRCM_SWARCH_CRYPTO_VERIFY_MODULE_GLOBAL
    @trace #BRCM_SWREQ_CRYPTO_VERIFY_HARDWARE
*/
#define CRYPTO_VERIFY_HW_EVENT_MASK (MODULE_EVENT | PKAEvent | SPUMEvent)

/**
    @{
    @brief Crypto verify context state

    @trace #BRCM_SWARCH_CRYPTO_VERIFY_MODULE_GLOBAL
    @trace #BRCM_SWREQ_CRYPTO_VERIFY_HARDWARE
**/
typedef uint32_t CRYPTO_VerifyHWAlgoCtxStateType;
#define CRYPTO_VERIFY_HW_ALGO_CTX_STATE_UNINIT                  (0UL)
#define CRYPTO_VERIFY_HW_ALGO_CTX_STATE_DIGEST_MORE_DATA        (1UL)
#define CRYPTO_VERIFY_HW_ALGO_CTX_STATE_DIGEST_IN_PROGRESS      (2UL)
#define CRYPTO_VERIFY_HW_ALGO_CTX_STATE_DIGEST_DONE             (3UL)
#define CRYPTO_VERIFY_HW_ALGO_CTX_STATE_SIG_VERIF_IN_PROGRESS   (4UL)
#define CRYPTO_VERIFY_HW_ALGO_CTX_STATE_SIG_VERIF_DONE          (5UL)
/** @} */

/**
    @brief Crypto algorithm context

    @trace #BRCM_SWARCH_CRYPTO_VERIFY_MODULE_GLOBAL
    @trace #BRCM_SWREQ_CRYPTO_VERIFY_HARDWARE
*/
typedef struct sCRYPTO_VerifyHWAlgoCtxType {
    CRYPTO_VerifyHWAlgoCtxStateType state;                      /**< @brief Algorithm state                         */
    uint32_t expectedSize;                                      /**< @brief Total message length                    */
    uint32_t consumedSize;                                      /**< @brief Received message length                 */
    CRYPTO_AlgoType sigAlgo;                                    /**< @brief Signature verification algorithm        */
    CRYPTO_AlgoType digestAlgo;                                 /**< @brief Message digest algorithm                */
    uint32_t digestLimbs[64UL / 4UL];                           /**< @brief Space to hold the message digest        */
    uint32_t signatureLimbs[256UL / 4UL];                       /**< @brief Space to hold the signature             */
    SPUM_ContextHandleType digestCtxHdl;                        /**< @brief SPUM driver context handle              */
    int32_t sigVerifJobExecResult;                              /**< @brief Signature verification job result       */
    SPUM_JobIdType spumJobId;                                   /**< @brief Handle to the submitted SPUM job        */
    PKA_JobIdType pkaJobId;                                     /**< @brief Handle to the submitted PKA job         */
    CRYPTO_VerifyMsgType msg[CRYPTO_VERIFY_HW_NUM_MSG_PER_CTX]; /**< @brief Message space                           */
} CRYPTO_VerifyHWAlgoCtxType;

/**
    @brief Crypto module context

    @trace #BRCM_SWARCH_CRYPTO_VERIFY_MODULE_GLOBAL
    @trace #BRCM_SWREQ_CRYPTO_VERIFY_HARDWARE
*/
typedef struct sCRYPTO_VerifyHWModCtxType {
    MODULE_ContextType modCtx;                              /**< @brief Module context                              */
    uint32_t lastProcessedCtxIdx;                           /**< @brief Last processed context index                */
    CRYPTO_VerifyHWAlgoCtxType algoCtx[CRYPTO_VERIFY_HW_NUM_CTX];           /**< @brief Algorithm context           */
    uint32_t digestCtxIdx;              /**< @brief Context index against which the HW is digesting the data        */
    uint32_t sigVerifCtxIdx;            /**< @brief Context index which the HW is verifying the signature           */
} CRYPTO_VerifyHWModCtxType;

/**
    @brief Crypto module context

    @trace #BRCM_SWARCH_CRYPTO_VERIFY_MODULE_GLOBAL
    @trace #BRCM_SWREQ_CRYPTO_VERIFY_HARDWARE
*/
static CRYPTO_VerifyHWModCtxType
    CRYPTO_VerifyHWModCtx COMP_SECTION(".bss.crypto.verify.hw.CRYPTO_VerifyHWModCtx");

/**
    @brief Device MVK

    @trace #BRCM_SWARCH_CRYPTO_VERIFY_MODULE_GLOBAL
    @trace #BRCM_SWREQ_CRYPTO_VERIFY_HARDWARE
*/
static CRYPTO_PublicKeyContainerType
    CRYPTO_VerifyHWModMVK COMP_SECTION(".bss.crypto.verify.hw.CRYPTO_VerifyHWModMVK");

/**
    @brief Crypto verify message Q contexts

    @trace #BRCM_SWARCH_CRYPTO_VERIFY_MODULE_GLOBAL
    @trace #BRCM_SWREQ_CRYPTO_VERIFY_HARDWARE
*/
static MSGQ_CtxType CRYPTO_VerifyHWMsgQCtx[1UL << CRYPTO_VERIFY_NUM_CTX_LOG2]
    COMP_SECTION(".bss.crypto.verify.hw.CRYPTO_VerifyHWMsgQCtx");

/**
    @brief RSA exponent global

    @trace #BRCM_SWARCH_CRYPTO_VERIFY_MODULE_GLOBAL
    @trace #BRCM_SWREQ_CRYPTO_VERIFY_HARDWARE
*/
static const uint32_t CRYPTO_VerifyHWRSA2KExponent = 65537UL;

/**
    @brief Crypto veify module get message

    @trace #BRCM_SWARCH_CRYPTO_VERIFY_MODULE_GLOBAL
    @trace #BRCM_SWREQ_CRYPTO_VERIFY_HARDWARE

    @code{.c}
    if aCtxIdx < CRYPTO_VERIFY_HW_NUM_CTX and aMsgIdx < CRYPTO_VERIFY_HW_NUM_MSG_PER_CTX
        msg = &CRYPTO_VerifyHWModCtx.algoCtx[aCtxIdx].msg[aMsgIdx]
    else
        msg = NULL
    return msg
    @endcode
*/
static uint8_t* CRYPTO_VerifyHWGetMsg(uint32_t aCtxIdx, uint32_t aMsgIdx)
{
    uint8_t* pRet;
    CRYPTO_VerifyHWModCtxType *ctx = &CRYPTO_VerifyHWModCtx;

    if ((aCtxIdx < CRYPTO_VERIFY_HW_NUM_CTX) && (aMsgIdx < CRYPTO_VERIFY_HW_NUM_MSG_PER_CTX)) {
        pRet = (uint8_t *)(&ctx->algoCtx[aCtxIdx].msg[aMsgIdx]);
    } else {
        pRet = (uint8_t *) NULL;
    }
    return pRet;
}

/**
    @brief Crypto veify module report error

    @trace #BRCM_SWARCH_CRYPTO_VERIFY_MODULE_GLOBAL
    @trace #BRCM_SWREQ_CRYPTO_VERIFY_HARDWARE

    @code{.c}
    values = {aState, aLine}
    BCM_ReportError(BCM_CVM_ID, 0U, aApiID, aError, 2UL, values);
    @endcode
*/
static void CRYPTO_VerifyHWModReportError(uint16_t aApiID, int32_t aError, uint32_t aState, uint32_t aLine)
{
    uint32_t values[4UL] = {0UL};
    values[0UL] = aLine;
    values[1UL] = aState;
    BCM_ReportError(BCM_CVM_ID, 0U, aApiID, aError, 2UL, values);
}

/**
    @brief Helper to perform endianness conversions

    PKA driver accepts SECUTILS_BigUint args. These big int's
    are laid out in little-endian byte ordering. The keys read from the
    OTP and the signatures given to us are expected to be encoded in big-endian
    format. This helper routine thus exists to perform the necessary conversions.

    @pre None

    @param[in]      aNumLimbs                   Number of words needing the
                                                endianness conversion
    @param[in]      aNumBigEndian               Big endian integer
    @param[out]     aLimbs                      Endian swapped integer. It is OK
                                                if this buffer overlaps with aNumBigEndian

    Return values are documented in reverse-chronological order
    @retval         #BCM_ERR_INVAL_PARAMS       aNumLimbs is greater than 64
    @retval         #BCM_ERR_OK                 Endianness swapped

    @post None

    @trace #BRCM_SWARCH_CRYPTO_VERIFY_MODULE_GLOBAL
    @trace #BRCM_SWREQ_CRYPTO_VERIFY_HARDWARE

    @code{.c}
    if aNumLimbs > 64
        return BCM_ERR_INVAL_PARAMS
    else
        uint32_t tmpBuf[64];
        memcmp(&tmpBuf, aNumBigEndian, aNumLimbs * 4UL)
        SECUTILS_BigUintType bigInt = { .numLimbs = aNumLimbs, .limbs = aLimbs }
        SECUTILS_ImportBigUint(
            SECUTILS_DIGIT_ENDIANNESS_BIG, SECUTILS_DIGIT_ORDER_MOST_SIGNIFICANT,
            aNumLimbs, tmpBuf, &bigInt
        )
        return BCM_ERR_OK
    @endcode
*/
static int32_t CRYPTO_VerifyHWInitBigUintLimbs(const uint32_t aNumLimbs, const uint8_t *const aNumBigEndian, uint32_t *const aLimbs)
{
    int32_t ret;
    uint32_t tmpBuf[64UL];
    const uint32_t tmpBufLenWords = 64UL;

    if (aNumLimbs <= tmpBufLenWords) {
        SECUTILS_BigUintType bigInt = {
            .numLimbs = aNumLimbs,
            .limbs = aLimbs,
        };

        BCM_MemCpy(&tmpBuf, aNumBigEndian, aNumLimbs * 4UL);
        ret = SECUTILS_ImportBigUint(
            SECUTILS_DIGIT_ENDIANNESS_BIG,
            SECUTILS_DIGIT_ORDER_MOST_SIGNIFICANT,
            aNumLimbs,
            tmpBuf,
            &bigInt
        );

    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }

    return ret;
}

/**
    @brief Crypto veify module reset state handler

    @pre None

    @param[in]      aRequestedState             Requested state

    Return values are documented in reverse-chronological order
    @retval         #BCM_ERR_UNKNOWN            Reset could not be performed
    @retval         #BCM_ERR_OK                 Reset done

    @post None

    @trace #BRCM_SWARCH_CRYPTO_VERIFY_MODULE_GLOBAL
    @trace #BRCM_SWREQ_CRYPTO_VERIFY_HARDWARE

    @code{.unparsed}
    ctx = &CRYPTO_VerifyHWModCtx
    mvk = &CRYPTO_VerifyHWModMVK

    for (i = 0UL; i < CRYPTO_VERIFY_HW_NUM_CTX; i++) {
        ctx->algoCtx[i].state = CRYPTO_VERIFY_HW_ALGO_CTX_STATE_UNINIT
    }

    READ_OTP_AND_POPULATE(&mvk)

    ctx->digestCtxIdx = CRYPTO_VERIFY_HW_NUM_CTX
    ctx->sigVerifCtxIdx = CRYPTO_VERIFY_HW_NUM_CTX
    ctx->lastProcessedCtxIdx = CRYPTO_VERIFY_HW_NUM_CTX - 1UL

    ret = CRYPTO_VerifyHWInitBigUintLimbs(ctx->mvkLenWords, (const uint8_t*) ctx->mvk, ctx->mvk)

    if (BCM_ERR_OK == ret)
        PKA_Init();
        SPUM_Init();

    if (BCM_ERR_OK != ret)
        return BCM_ERR_UNKNOWN
    else
        return BCM_ERR_OK

    @endcode
*/
static int32_t CRYPTO_VerifyHWResetStateHandler(BCM_StateType aRequestedState)
{
    (void) aRequestedState;

    uint32_t i;
    int32_t ret = BCM_ERR_OK;
    CRYPTO_VerifyHWModCtxType *const ctx = &CRYPTO_VerifyHWModCtx;
    CRYPTO_PublicKeyContainerType *const mvk = &CRYPTO_VerifyHWModMVK;
    uint32_t keyType = 0UL;
    MCU_SecurityModeType mucSecMode = MCU_SECURITY_MODE_UNKNOWN;

#ifndef OTP_SKIP_PUBKEY_READ
    uint32_t keySize;

    ret = OTPM_ReadPubKey((uint8_t *)mvk->pubKey, sizeof(mvk->pubKey), &keyType, &keySize);
    if ((BCM_ERR_OK == ret) && (1UL == keyType)) {
        mvk->keyAlgo = CRYPTO_ALGO_RSA2K;
        mvk->keyPaddingAlgo = CRYPTO_ALGO_PKCS21;
        mvk->keyLenWords = 64UL;
        mucSecMode = MCU_SECURITY_MODE_RSA;
    } else {
        mvk->keyLenWords = 0UL;
        mvk->keyAlgo = 0UL;
        mvk->keyPaddingAlgo = 0UL;

        if (BCM_ERR_NOT_FOUND != ret) {
            ret = BCM_ERR_UNKNOWN;
        }
    }

#else
    /* RSA test key */
    const uint8_t mvkRSA2kTestKey[256UL] = {
        0xae,0x87,0xff,0x09,0x9e,0xc2,0x5c,0x05,0x84,0xaa,0xf7,0x78,0x0f,0x32,0x4c,0x73,
        0x48,0xbc,0xd7,0x54,0xd9,0x98,0xc9,0x3c,0x94,0xd4,0xec,0xbb,0xef,0x4c,0x61,0x0a,
        0x17,0x9f,0x64,0x51,0x2b,0x5f,0xed,0x54,0x7a,0x45,0x70,0xca,0x0a,0xae,0x8e,0xbb,
        0xa5,0x4a,0xeb,0x8b,0x0f,0xaa,0xfb,0xbd,0xd1,0x63,0xa1,0x88,0x48,0x55,0x13,0xba,
        0x35,0xfc,0xa1,0xdb,0xc3,0xb1,0xd6,0x4e,0xd2,0x79,0x93,0x9d,0x5f,0xac,0x56,0x75,
        0x0c,0xb7,0x26,0xb3,0x3e,0x7b,0x06,0x43,0xb3,0x19,0x1c,0xeb,0x8c,0xf1,0x1a,0x20,
        0xc4,0x68,0xdf,0x9b,0x68,0x30,0xa0,0x55,0xdd,0x5a,0x55,0x57,0xe8,0x98,0xa6,0x3e,
        0x42,0x28,0xbc,0xe1,0xd8,0xa8,0x44,0xc0,0x42,0xb9,0x8f,0xf8,0xb7,0x6a,0xcd,0x3c,
        0xdf,0xa4,0x25,0xc6,0xa1,0xf3,0xc8,0x47,0x72,0xbb,0xc2,0x74,0xb4,0x74,0x33,0x89,
        0x80,0x95,0xba,0x69,0x6a,0x21,0xd2,0xe0,0xaa,0x5d,0x33,0x03,0x0f,0xf8,0x13,0xcf,
        0xeb,0x29,0xf9,0x06,0x4d,0x0a,0x5a,0xe1,0xfa,0xc3,0x50,0x3d,0x46,0x96,0x4d,0x77,
        0xef,0x5a,0x52,0xe9,0x08,0x04,0xaf,0xae,0x3a,0xb7,0xa0,0x76,0x8a,0x3e,0x66,0xf1,
        0xc3,0x23,0x71,0xf8,0x64,0x53,0x54,0x55,0xa1,0xa5,0xce,0xe0,0x7f,0xe6,0xef,0xde,
        0x4c,0x55,0x59,0xea,0x0d,0x1c,0xf1,0xa4,0x10,0xca,0xf6,0x7d,0x4c,0x7c,0xd5,0x21,
        0x0c,0x41,0xf4,0x3a,0x39,0x43,0x7b,0x2a,0x8f,0x86,0xe7,0x51,0xf0,0x78,0x9d,0xe9,
        0xf7,0x18,0x60,0x5c,0x50,0x99,0x73,0xe3,0x50,0xf2,0x7b,0x34,0x07,0x46,0xd0,0x9b,
    };
    memcpy(mvk->pubKey, mvkRSA2kTestKey, 256UL);
    mvk->keyLenWords = 64UL;
    mvk->keyAlgo = CRYPTO_ALGO_RSA2K;
    mvk->keyPaddingAlgo = CRYPTO_ALGO_PKCS21;
    keyType = CRYPTO_ALGO_RSA2K;
#endif /* OTP_SKIP_PUBKEY_READ  */

    /* Reset the context states */
    for (i = 0UL; i < CRYPTO_VERIFY_HW_NUM_CTX; i++) {
        ctx->algoCtx[i].state = CRYPTO_VERIFY_HW_ALGO_CTX_STATE_UNINIT;
    }

    ctx->digestCtxIdx = CRYPTO_VERIFY_HW_NUM_CTX;
    ctx->sigVerifCtxIdx = CRYPTO_VERIFY_HW_NUM_CTX;
    ctx->lastProcessedCtxIdx = CRYPTO_VERIFY_HW_NUM_CTX - 1UL;

    if (BCM_ERR_OK == ret) {
        /* Endianness conversion of the MVK */
        ret = CRYPTO_VerifyHWInitBigUintLimbs(mvk->keyLenWords, (const uint8_t*) mvk->pubKey, mvk->pubKey);
        if (BCM_ERR_OK == ret) {
            /* PKA and SPUM init */
            PKA_Init();
            SPUM_Init();
        }
    } else if (BCM_ERR_NOT_FOUND == ret) {
        mucSecMode = MCU_SECURITY_MODE_NONE;
        ret = BCM_ERR_OK; /* non secure board */
    } else {
        /* We have an error. Will be handled  */
    }

    if (BCM_ERR_OK != ret) {
        ret = BCM_ERR_UNKNOWN;
    } else {
        (void) MCU_SetSecurityMode(mucSecMode);
        BCM_REPORT_ERROR4(BCM_CVM_ID, 0U, BRCM_SWDSGN_CRYPTO_VERIFY_HW_RESET_STATE_HANDLER_PROC,
                            BCM_ERR_OK, BCM_STATE_INIT, keyType, mvk->pubKey[0UL], mvk->pubKey[1UL],
                            mvk->pubKey[2UL], "Crypto Verify Key type");
    }

    return ret;
}

/**
    @brief Helper to UNINIT a context

    @pre A HW job should not be in progress against the context being UNINT'd

    @param[in]      aAlgCtx                     Context to uninit

    @return void

    @post Context UNINIT'd

    @trace #BRCM_SWARCH_CRYPTO_VERIFY_MODULE_GLOBAL
    @trace #BRCM_SWREQ_CRYPTO_VERIFY_HARDWARE

    @code{.c}
    algCtxState = aAlgCtx->state
    if (CRYPTO_VERIFY_HW_ALGO_CTX_STATE_UNINIT != algCtxState)
        BCM_ASSERT(algCtxState != CRYPTO_VERIFY_HW_ALGO_CTX_STATE_DIGEST_IN_PROGRESS)
        BCM_ASSERT(algCtxState != CRYPTO_VERIFY_HW_ALGO_CTX_STATE_SIG_VERIF_IN_PROGRESS)
        if (CRYPTO_VERIFY_HW_ALGO_CTX_STATE_DIGEST_MORE_DATA == algCtxState)
            SPUM_DestroyContext(aAlgCtx->digestCtxHdl)

        aAlgCtx->state = CRYPTO_VERIFY_HW_ALGO_CTX_STATE_UNINIT
    @endcode
*/
static void CRYPTO_VerifyHWUninitCtx(CRYPTO_VerifyHWAlgoCtxType *const aAlgCtx)
{
    const CRYPTO_VerifyHWAlgoCtxStateType algCtxState = aAlgCtx->state;

    if (CRYPTO_VERIFY_HW_ALGO_CTX_STATE_UNINIT != algCtxState) {
        /*
            This function should never be called when a HW job
            is in progress against the context being UNINIT'd
        */
        BCM_ASSERT(algCtxState != CRYPTO_VERIFY_HW_ALGO_CTX_STATE_DIGEST_IN_PROGRESS)
        BCM_ASSERT(algCtxState != CRYPTO_VERIFY_HW_ALGO_CTX_STATE_SIG_VERIF_IN_PROGRESS)

        if (CRYPTO_VERIFY_HW_ALGO_CTX_STATE_DIGEST_MORE_DATA == algCtxState) {
            /* Free up the context handle */
            const int32_t retVal = SPUM_DestroyContext(aAlgCtx->digestCtxHdl);
            (void) retVal;
        }

        aAlgCtx->state = CRYPTO_VERIFY_HW_ALGO_CTX_STATE_UNINIT;
    }

    return;
}

/**
    @brief Validate the context init params

    @pre None

    @param[in]      aCryptInitParams            Context init params

    Return values are documented in reverse-chronological order
    @retval         #BCM_ERR_NOSUPPORT          Requested context init params invalid/
                                                not supported
    @retval         #BCM_ERR_OK                 Context params valid and supported

    @post None

    @trace #BRCM_SWARCH_CRYPTO_VERIFY_MODULE_GLOBAL
    @trace #BRCM_SWREQ_CRYPTO_VERIFY_HARDWARE

    @code{.c}
    sigAlg = aCryptInitParams->algo
    digestAlg = aCryptInitParams->hash
    paddingAlg = aCryptInitParams->padding

    if ((CRYPTO_ALGO_RSA2K == sigAlg) && (CRYPTO_ALGO_SHA256 == digestAlg) && (CRYPTO_ALGO_PKCS21 == paddingAlg))
        expectedSigLen = 256UL
        messageLenBlockMask = 63UL
        ret = BCM_ERR_OK
    else
        ret = BCM_ERR_NOSUPPORT

    if ((BCM_ERR_OK == ret) &&
        (sigAlg == CRYPTO_VerifyHWModMVK.keyAlgo) &&
        (NULL != aCryptInitParams->signature) &&
        (expectedSigLen == aCryptInitParams->sigLen) &&
        (0UL != aCryptInitParams->msgLength) &&
        (0UL == (aCryptInitParams->msgLength & messageLenBlockMask)))
        ret = BCM_ERR_OK
    else
        ret = BCM_ERR_NOSUPPORT

    return ret
    @endcode
*/
static int32_t CRYPTO_VerifyHWValidateInitParams(const CRYPTO_VerifyInitType *const aCryptInitParams)
{
    int32_t ret;
    uint32_t expectedSigLen = 0UL;
    uint32_t messageLenBlockMask = 0UL;
    const CRYPTO_AlgoType sigAlg = aCryptInitParams->algo;
    const CRYPTO_AlgoType digestAlg = aCryptInitParams->hash;
    const CRYPTO_AlgoType paddingAlg = aCryptInitParams->padding;

    if ((CRYPTO_ALGO_RSA2K == sigAlg) && (CRYPTO_ALGO_SHA256 == digestAlg) && (CRYPTO_ALGO_PKCS21 == paddingAlg)) {
        /* Signatures are 256 bytes long and the message needs to be a multiple of 64 bytes */
        expectedSigLen = 256UL;
        messageLenBlockMask = 63UL;
        ret = BCM_ERR_OK;
    } else {
        /* Unsupported combination of sigAlg/digestAlg/paddingAlg */
        ret = BCM_ERR_NOSUPPORT;
    }

    if ((BCM_ERR_OK == ret) &&
        (sigAlg == CRYPTO_VerifyHWModMVK.keyAlgo) &&
        (NULL != aCryptInitParams->signature) &&
        (expectedSigLen == aCryptInitParams->sigLen) &&
        (0UL != aCryptInitParams->msgLength) &&
        (0UL == (aCryptInitParams->msgLength & messageLenBlockMask))) {
        ret = BCM_ERR_OK;
    } else {
        ret = BCM_ERR_NOSUPPORT;
    }

    return ret;
}

/**
    @brief Process the context init message

    @pre None

    @param[in]      aCryptInitParams            Context init params
    @param[out]     aVerifStatus                Signature verification status to update
    @param[out]     aAlgCtx                     Context to initialize

    Return values are documented in reverse-chronological order
    @retval         #BCM_ERR_OK                 Always. Signals the caller that the init
                                                processing is complete and a response can
                                                be sent to the client

    @post aVerifStatus is set to #BCM_ERR_BUSY if the context init was sucessful.
        Else, it is set to BCM_ERR_NOSUPPORT.

    @trace #BRCM_SWARCH_CRYPTO_VERIFY_MODULE_GLOBAL
    @trace #BRCM_SWREQ_CRYPTO_VERIFY_HARDWARE

    @code{.c}
    ret = CRYPTO_VerifyHWValidateInitParams(aCryptInitParams)
    if (BCM_ERR_OK == ret)
        SPUM_ContextHandleType ctxHdl = 0ULL
        ret = SPUM_CreateContext(aCryptInitParams->hash, &ctxHdl)

        if (BCM_ERR_OK == ret)
            CRYPTO_VerifyHWUninitCtx(aAlgCtx)
            aAlgCtx->state = CRYPTO_VERIFY_HW_ALGO_CTX_STATE_DIGEST_MORE_DATA
            aAlgCtx->expectedSize = aCryptInitParams->msgLength
            aAlgCtx->consumedSize = 0UL
            aAlgCtx->sigAlgo = aCryptInitParams->algo
            aAlgCtx->digestAlgo = aCryptInitParams->hash
            aAlgCtx->digestCtxHdl = ctxHdl
            aAlgCtx->sigVerifJobExecResult = BCM_ERR_UNKNOWN
            aAlgCtx->spumJobId = 0ULL
            aAlgCtx->pkaJobId = 0ULL
            memcpy(aAlgCtx->signatureLimbs, aCryptInitParams->signature, aCryptInitParams->sigLen)
            ret = BCM_ERR_OK
        else
            ret = BCM_ERR_NOSUPPORT

    if (BCM_ERR_OK == ret)
        *aVerifStatus = BCM_ERR_BUSY
    } else
        *aVerifStatus = BCM_ERR_NOSUPPORT
    }

    return BCM_ERR_OK
    @endcode
*/
static int32_t CRYPTO_VerifyHWProcessInitMsg(const CRYPTO_VerifyInitType *const aCryptInitParams, int32_t *const aVerifStatus, CRYPTO_VerifyHWAlgoCtxType *const aAlgCtx)
{
    int32_t ret;

    ret = CRYPTO_VerifyHWValidateInitParams(aCryptInitParams);
    if (BCM_ERR_OK == ret) {
        /*
            Params OK. Try creating a SPUM hash context.
            We only support SHA256 digest (checked by CRYPTO_VerifyHWValidateInitParams
            called above)
        */
        SPUM_ContextHandleType ctxHdl = 0ULL;
        const SPUM_AuthOpsType spumAuthOps = {
            .hashAlg = SPUM_HASH_ALG_SHA256,
            .keySecheapHdl = 0UL
        };

        ret = SPUM_CreateContext(
            NULL,                           /* aCryptOps        */
            &spumAuthOps,                   /* aAuthOps         */
            SPUM_CRYPT_AUTH_ORDER_NONE,     /* aCryptAuthOrder  */
            32UL,                           /* aAuthOutMemSize  */
            (uint8_t*)aAlgCtx->digestLimbs, /* aAuthOut         */
            &ctxHdl                         /* aCtxHdl          */
        );

        if (BCM_ERR_OK == ret) {
            /* All OK. Start off by resetting the context */
            CRYPTO_VerifyHWUninitCtx(aAlgCtx);

            /* Populate the ALG state */
            aAlgCtx->state = CRYPTO_VERIFY_HW_ALGO_CTX_STATE_DIGEST_MORE_DATA;
            aAlgCtx->expectedSize = aCryptInitParams->msgLength;
            aAlgCtx->consumedSize = 0UL;
            aAlgCtx->sigAlgo = aCryptInitParams->algo;
            aAlgCtx->digestAlgo = aCryptInitParams->hash;
            aAlgCtx->digestCtxHdl = ctxHdl;
            aAlgCtx->sigVerifJobExecResult = BCM_ERR_UNKNOWN;
            aAlgCtx->spumJobId = 0ULL;
            aAlgCtx->pkaJobId = 0ULL;

            BCM_MemCpy((void*) aAlgCtx->signatureLimbs, (const void*) aCryptInitParams->signature, aCryptInitParams->sigLen);
            ret = BCM_ERR_OK;
        } else {
            ret = BCM_ERR_NOSUPPORT;
        }
    }

    if (BCM_ERR_OK == ret) {
        *aVerifStatus = BCM_ERR_BUSY;
    } else {
        *aVerifStatus = BCM_ERR_NOSUPPORT;
    }

    return BCM_ERR_OK;
}

/**
    @brief Attempt to submit a digest computation job to the HW

    @pre None

    @param[in]      aCryptUpdateParams          Update params
    @param[inout]   aAlgCtx                     Context against which the digest
                                                computation is to be issued

    Return values are documented in reverse-chronological order
    @retval         #BCM_ERR_EAGAIN             HW is already computing the digest of another
                                                messsage. The caller should try submitting this
                                                job again later
    @retval         #BCM_ERR_BUSY               Digest computation job issued
    @retval         #BCM_ERR_INVAL_STATE        Job submission failed

    @post On a sucessful job submission to the HW, the context's state is transitioned
        to #CRYPTO_VERIFY_HW_ALGO_CTX_STATE_DIGEST_IN_PROGRESS

    @trace #BRCM_SWARCH_CRYPTO_VERIFY_MODULE_GLOBAL
    @trace #BRCM_SWREQ_CRYPTO_VERIFY_HARDWARE

    @code{.c}
    if (CRYPTO_VERIFY_HW_NUM_CTX > CRYPTO_VerifyHWModCtx.digestCtxIdx) &&
       (aAlgCtx->consumedSize < aAlgCtx->expectedSize) &&
       ((aAlgCtx->consumedSize + aCryptUpdateParams->chunkSize) <= aAlgCtx->expectedSize)
        return BCM_ERR_EAGAIN

    if ((aAlgCtx->consumedSize + aCryptUpdateParams->chunkSize) == aAlgCtx->expectedSize)
        ret = SPUM_HashFinish(...)
    else
        ret = SPUM_HashUpdate(...)

    if (BCM_ERR_OK == ret)
        ctxIdx = aAlgCtx - &CRYPTO_VerifyHWModCtx.algoCtx[0UL]
        aAlgCtx->consumedSize += aCryptUpdateParams->chunkSize
        aAlgCtx->state = CRYPTO_VERIFY_HW_ALGO_CTX_STATE_DIGEST_IN_PROGRESS
        CRYPTO_VerifyHWModCtx.digestCtxIdx = ctxIdx
        CRYPTO_VerifyHWModCtx.lastProcessedCtxIdx = ctxIdx
        return BCM_ERR_BUSY
    else
        return BCM_ERR_INVAL_STATE

    @endcode
*/
static int32_t CRYPTO_VerifyHWDigestSubmit(const CRYPTO_VerifyUpdateType *const aCryptUpdateParams, CRYPTO_VerifyHWAlgoCtxType *const aAlgCtx)
{
    int32_t ret;

    if ((CRYPTO_VERIFY_HW_NUM_CTX <= CRYPTO_VerifyHWModCtx.digestCtxIdx) &&
        (aAlgCtx->consumedSize < aAlgCtx->expectedSize) &&
        ((aAlgCtx->consumedSize + aCryptUpdateParams->chunkSize) <= aAlgCtx->expectedSize)) {

        if ((aAlgCtx->consumedSize + aCryptUpdateParams->chunkSize) == aAlgCtx->expectedSize) {
            ret = SPUM_Finish(
                aAlgCtx->digestCtxHdl,          /* aCtxHdl      */
                aCryptUpdateParams->chunkSize,  /* aDataInSize  */
                aCryptUpdateParams->chunkData,  /* aDataIn      */
                NULL,                           /* aCryptOut    */
                &aAlgCtx->spumJobId             /* aJobId       */
            );
        } else {
            ret = SPUM_Update(
                aAlgCtx->digestCtxHdl,          /* aCtxHdl      */
                aCryptUpdateParams->chunkSize,  /* aDataInSize  */
                aCryptUpdateParams->chunkData,  /* aDataIn      */
                NULL,                           /* aCryptOut    */
                &aAlgCtx->spumJobId             /* aJobId       */
            );
        }

        if (BCM_ERR_OK == ret) {
            const uint32_t ctxIdx = (uint32_t) (aAlgCtx - &CRYPTO_VerifyHWModCtx.algoCtx[0UL]);
            aAlgCtx->consumedSize += aCryptUpdateParams->chunkSize;
            aAlgCtx->state = CRYPTO_VERIFY_HW_ALGO_CTX_STATE_DIGEST_IN_PROGRESS;
            CRYPTO_VerifyHWModCtx.digestCtxIdx = ctxIdx;
            CRYPTO_VerifyHWModCtx.lastProcessedCtxIdx = ctxIdx;
            ret = BCM_ERR_BUSY;
        } else {
            ret = BCM_ERR_INVAL_STATE;
        }

    } else {
        /* Job not issued. Need to try again */
        ret = BCM_ERR_EAGAIN;
    }

    return ret;
}

/**
    @brief Handle the digest computation completions

    @pre None

    @return void

    @post The state of the context against which the digest computation job resolved
        is appropriately transitioned

    @trace #BRCM_SWARCH_CRYPTO_VERIFY_MODULE_GLOBAL
    @trace #BRCM_SWREQ_CRYPTO_VERIFY_HARDWARE

    @code{.c}
    ctxIdx = CRYPTO_VerifyHWModCtx.digestCtxIdx
    algCtx = &CRYPTO_VerifyHWModCtx.algoCtx[ctxIdx]

    retVal = SPUM_GetJobExecResult(algCtx->spumJobId, &jobExecResult)
    if (BCM_ERR_OK == retVal)
        if (BCM_ERR_BUSY == jobExecResult)
            DO NOTHING
        else if (BCM_ERR_OK != retVal)
            jobFailed = true
        else
            jobDone = true
    else
        jobFailed = true

    if (true == jobFailed)
        algCtx->spumJobId = 0ULL
        algCtx->digestCtxHdl = 0ULL
        algCtx->state = CRYPTO_VERIFY_HW_ALGO_CTX_STATE_SIG_VERIF_DONE
        algCtx->sigVerifJobExecResult = BCM_ERR_AUTH_FAILED
        CRYPTO_VerifyHWModCtx.digestCtxIdx = CRYPTO_VERIFY_HW_NUM_CTX

    if (true == jobDone)
        if (algCtx->expectedSize == algCtx->consumedSize)
            algCtx->digestCtxHdl = 0ULL
        algCtx->spumJobId = 0ULL
        algCtx->state = CRYPTO_VERIFY_HW_ALGO_CTX_STATE_DIGEST_DONE
        CRYPTO_VerifyHWModCtx.digestCtxIdx = CRYPTO_VERIFY_HW_NUM_CTX

    @endcode
*/
static void CRYPTO_VerifyHWDigestDone(void)
{
    uint32_t jobDone = 0UL;
    uint32_t jobFailed = 0UL;
    int32_t jobExecResult = BCM_ERR_OK;
    const uint32_t ctxIdx = CRYPTO_VerifyHWModCtx.digestCtxIdx;
    BCM_ASSERT(ctxIdx < CRYPTO_VERIFY_HW_NUM_CTX)

    CRYPTO_VerifyHWAlgoCtxType *const algCtx = &CRYPTO_VerifyHWModCtx.algoCtx[ctxIdx];

    const int32_t retVal = SPUM_GetJobExecResult(algCtx->spumJobId, &jobExecResult);
    if (BCM_ERR_OK == retVal) {
        if (BCM_ERR_BUSY == jobExecResult) {
            /* Do nothing */
        } else if (BCM_ERR_OK != jobExecResult) {
            jobFailed = 1UL;
        } else {
            jobDone = 1UL;
        }
    } else {
        jobFailed = 1UL;
    }

    if (1UL == jobFailed) {
        /*
            Fail the signature verification given that the digest
            computation failed.

            SPUM driver automatically invalidates the
            context in this case. So, no driver call is necessary
            at this point
        */
        algCtx->spumJobId = 0ULL;
        algCtx->digestCtxHdl = 0ULL;
        algCtx->state = CRYPTO_VERIFY_HW_ALGO_CTX_STATE_SIG_VERIF_DONE;
        algCtx->sigVerifJobExecResult = BCM_ERR_AUTH_FAILED;
        CRYPTO_VerifyHWModCtx.digestCtxIdx = CRYPTO_VERIFY_HW_NUM_CTX;
    }

    if (1UL == jobDone) {
        /*
            Check if we've finished digesting the entire message.
            If so, SPUM driver would have invalidated the context
            for us.
        */
        if (algCtx->expectedSize == algCtx->consumedSize) {
            algCtx->digestCtxHdl = 0ULL;
        }

        algCtx->spumJobId = 0ULL;
        algCtx->state = CRYPTO_VERIFY_HW_ALGO_CTX_STATE_DIGEST_DONE;
        CRYPTO_VerifyHWModCtx.digestCtxIdx = CRYPTO_VERIFY_HW_NUM_CTX;
    }

    return;
}

/**
    @brief Submit RSA2K signature verification job to PKA

    @pre None

    @param[in]      aAlgCtx                     Context against which the RSA2K job is to
                                                be issued

    Return values are documented in reverse-chronological order
    @retval         #BCM_ERR_INVAL_STATE        Failed to submit the RSA job
    @retval         #BCM_ERR_OK                 RSA job submitted

    @post None

    @trace #BRCM_SWARCH_CRYPTO_VERIFY_MODULE_GLOBAL
    @trace #BRCM_SWREQ_CRYPTO_VERIFY_HARDWARE

    @code{.c}
    int32_t ret = BCM_ERR_UNKNOWN

    retVal1 = CRYPTO_VerifyHWInitBigUintLimbs(64UL, aAlgCtx->signatureLimbs, aAlgCtx->signatureLimbs)
    retVal2 = CRYPTO_VerifyHWInitBigUintLimbs(8UL, aAlgCtx->digestLimbs, aAlgCtx->digestLimbs)

    if ((BCM_ERR_OK == retVal1) && (BCM_ERR_OK == retVal2))
        SECUTILS_ConstBigUintType digest
        SECUTILS_ConstBigUintType signature
        SECUTILS_ConstBigUintType rsaModulus
        SECUTILS_ConstBigUintType rsaExponent

        rsaModulus.numLimbs = 64UL
        rsaModulus.limbs = CRYPTO_VerifyHWModMVK.pubKey
        rsaExponent.numLimbs = 1UL
        rsaExponent.limbs = &CRYPTO_VerifyHWRSA2KExponent
        signature.numLimbs = 64UL
        signature.limbs = aAlgCtx->signatureLimbs
        digest.numLimbs = 8UL
        digest.limbs = aAlgCtx->digestLimbs

        ret = PKA_RsaVerify(
            PKA_RSA_SIGNATURE_SCHEME_PSS,
            &rsaModulus,
            &rsaExponent,
            &signature,
            PKA_MSGDIGESTALG_SHA256,
            &digest,
            &aAlgCtx->pkaJobId
        )

    if (BCM_ERR_OK != ret) {
        ret = BCM_ERR_INVAL_STATE
    }

    return ret;

    @endcode
*/
static int32_t CRYPTO_VerifyHWRSA2KSubmit(CRYPTO_VerifyHWAlgoCtxType *const aAlgCtx)
{
    int32_t ret = BCM_ERR_UNKNOWN;

    /* Perform the necessary endianness conversions  */
    const int32_t retVal1 = CRYPTO_VerifyHWInitBigUintLimbs(64UL,
        (const uint8_t *)aAlgCtx->signatureLimbs, aAlgCtx->signatureLimbs);
    const int32_t retVal2 = CRYPTO_VerifyHWInitBigUintLimbs(8UL,
        (const uint8_t *)aAlgCtx->digestLimbs, aAlgCtx->digestLimbs);

    if ((BCM_ERR_OK == retVal1) && (BCM_ERR_OK == retVal2)) {
        SECUTILS_ConstBigUintType digest;
        SECUTILS_ConstBigUintType signature;
        SECUTILS_ConstBigUintType rsaModulus;
        SECUTILS_ConstBigUintType rsaExponent;

        rsaModulus.numLimbs = 64UL;
        rsaModulus.limbs = (const uint32_t *) &CRYPTO_VerifyHWModMVK.pubKey;

        rsaExponent.numLimbs = 1UL;
        rsaExponent.limbs = &CRYPTO_VerifyHWRSA2KExponent;

        signature.numLimbs = 64UL;
        signature.limbs = aAlgCtx->signatureLimbs;

        digest.numLimbs = 8UL;
        digest.limbs = aAlgCtx->digestLimbs;

        ret = PKA_RsaVerify(
            PKA_RSA_SIGNATURE_SCHEME_PSS,
            &rsaModulus,
            &rsaExponent,
            &signature,
            PKA_MSGDIGESTALG_SHA256,
            &digest,
            &aAlgCtx->pkaJobId
        );
    }

    if (BCM_ERR_OK != ret) {
        ret = BCM_ERR_INVAL_STATE;
    }

    return ret;
}

/**
    @brief Attempt to submit a signature verification job to the HW

    @pre Message digest compuation complete

    @param[inout]   aAlgCtx                     Context against which the signature
                                                verification operation is to be issued

    Return values are documented in reverse-chronological order
    @retval         #BCM_ERR_EAGAIN             HW is already verifying a signature from another
                                                context. The caller should try submitting this
                                                job again later
    @retval         #BCM_ERR_BUSY               Signature verification job issued
    @retval         #BCM_ERR_INVAL_STATE        Job submission failed

    @post On a sucessful job submission to the HW, the context's state is transitioned
        to #CRYPTO_VERIFY_HW_ALGO_CTX_STATE_SIG_VERIF_IN_PROGRESS

    @trace #BRCM_SWARCH_CRYPTO_VERIFY_MODULE_GLOBAL
    @trace #BRCM_SWREQ_CRYPTO_VERIFY_HARDWARE

    @code{.c}
    if (CRYPTO_VERIFY_HW_NUM_CTX > CRYPTO_VerifyHWModCtx.sigVerifCtxIdx)
        return BCM_ERR_EAGAIN

    if (CRYPTO_ALGO_RSA2K == aAlgCtx->sigAlgo)
        ret = CRYPTO_VerifyHWRSA2KSubmit(aAlgCtx)
    else
        ret = BCM_ERR_INVAL_STATE

    if (BCM_ERR_OK == ret)
        aAlgCtx->state = CRYPTO_VERIFY_HW_ALGO_CTX_STATE_SIG_VERIF_IN_PROGRESS
        CRYPTO_VerifyHWModCtx.sigVerifCtxIdx = aAlgCtx - &CRYPTO_VerifyHWModCtx.algoCtx[0UL]
        return BCM_ERR_BUSY
    else
        return BCM_ERR_INVAL_STATE
    @endcode
*/
static int32_t CRYPTO_VerifyHWSigVerifSubmit(CRYPTO_VerifyHWAlgoCtxType *const aAlgCtx)
{
    int32_t ret;

    if (CRYPTO_VERIFY_HW_NUM_CTX <= CRYPTO_VerifyHWModCtx.sigVerifCtxIdx) {

        switch (aAlgCtx->sigAlgo) {
            case CRYPTO_ALGO_RSA2K:
                ret = CRYPTO_VerifyHWRSA2KSubmit(aAlgCtx);
                break;
            default:
                ret = BCM_ERR_INVAL_STATE;
                break;
        }

        if (BCM_ERR_OK == ret) {
            aAlgCtx->state = CRYPTO_VERIFY_HW_ALGO_CTX_STATE_SIG_VERIF_IN_PROGRESS;
            CRYPTO_VerifyHWModCtx.sigVerifCtxIdx = (uint32_t) (aAlgCtx - &CRYPTO_VerifyHWModCtx.algoCtx[0UL]);
            ret = BCM_ERR_BUSY;
        } else {
            ret = BCM_ERR_INVAL_STATE;
        }

    } else {
        /* Need to try again */
        ret = BCM_ERR_EAGAIN;
    }

    return ret;
}

/**
    @brief Handle the signature verification job completions

    @pre None

    @return void

    @post The state of the context against which the signature verification job resolved
        is appropriately transitioned

    @trace #BRCM_SWARCH_CRYPTO_VERIFY_MODULE_GLOBAL
    @trace #BRCM_SWREQ_CRYPTO_VERIFY_HARDWARE

    @code{.c}
    uint32_t jobDone;
    int32_t jobExecResult = BCM_ERR_UNKNOWN;
    ctxIdx = CRYPTO_VerifyHWModCtx.sigVerifCtxIdx
    algCtx = &CRYPTO_VerifyHWModCtx.algoCtx[ctxIdx]

    retVal = PKA_GetAlgExecResult(algCtx->pkaJobId, &jobExecResult)
    if (BCM_ERR_OK == retVal)
        if (BCM_ERR_OK == jobExecResult)
            algCtx->sigVerifJobExecResult = BCM_ERR_OK
            jobDone = 1UL
        else if (BCM_ERR_BUSY == jobExecResult)
            jobDone = 0UL
        else
            algCtx->sigVerifJobExecResult = BCM_ERR_AUTH_FAILED
            jobDone = 1UL
    else
        algCtx->sigVerifJobExecResult = BCM_ERR_AUTH_FAILED
        jobDone = 1UL

    if (1UL == jobDone)
        algCtx->state = CRYPTO_VERIFY_HW_ALGO_CTX_STATE_SIG_VERIF_DONE
        CRYPTO_VerifyHWModCtx.sigVerifCtxIdx = CRYPTO_VERIFY_HW_NUM_CTX

    @endcode
*/
static void CRYPTO_VerifyHWSigVerifDone(void)
{
    uint32_t jobDone;
    int32_t jobExecResult = BCM_ERR_UNKNOWN;
    const uint32_t ctxIdx = CRYPTO_VerifyHWModCtx.sigVerifCtxIdx;
    BCM_ASSERT(ctxIdx < CRYPTO_VERIFY_HW_NUM_CTX)

    CRYPTO_VerifyHWAlgoCtxType *const algCtx = &CRYPTO_VerifyHWModCtx.algoCtx[ctxIdx];

    const int32_t retVal = PKA_GetAlgExecResult(algCtx->pkaJobId, &jobExecResult);
    if (BCM_ERR_OK == retVal) {
        if (BCM_ERR_OK == jobExecResult) {
            algCtx->sigVerifJobExecResult = BCM_ERR_OK;
            jobDone = 1UL;
        } else if (BCM_ERR_BUSY == jobExecResult) {
            jobDone = 0UL;
        } else {
            algCtx->sigVerifJobExecResult = BCM_ERR_AUTH_FAILED;
            jobDone = 1UL;
        }
    } else {
        algCtx->sigVerifJobExecResult = BCM_ERR_AUTH_FAILED;
        jobDone = 1UL;
    }

    if (1UL == jobDone) {
        algCtx->state = CRYPTO_VERIFY_HW_ALGO_CTX_STATE_SIG_VERIF_DONE;
        CRYPTO_VerifyHWModCtx.sigVerifCtxIdx = CRYPTO_VERIFY_HW_NUM_CTX;
    }

    return;
}

/**
    @brief Process the context update message

    @pre None

    @param[in]      aCryptUpdateParams          Update params
    @param[out]     aVerifStatus                Signature verification status to update
    @param[out]     aAlgCtx                     Context to process the update against

    Return values are documented in reverse-chronological order
    @retval         #BCM_ERR_BUSY               The update message is being processed (asynchronously)
    @retval         #BCM_ERR_OK                 Signals the caller that the update
                                                processing is complete and a response can
                                                be sent to the client

    @post aVerifStatus is set to
        -# #BCM_ERR_BUSY if the signature verification is still in progress
        -# #BCM_ERR_OK if the signature is authentic
        -# #BCM_ERR_AUTH_FAILED if the signature verification failed

    @trace #BRCM_SWARCH_CRYPTO_VERIFY_MODULE_GLOBAL
    @trace #BRCM_SWREQ_CRYPTO_VERIFY_HARDWARE

    @code{.c}
    switch (aAlgCtx->state)
        case CRYPTO_VERIFY_HW_ALGO_CTX_STATE_DIGEST_MORE_DATA:
            ret = CRYPTO_VerifyHWDigestSubmit(aCryptUpdateParams, aAlgCtx)
            if ((BCM_ERR_BUSY == ret) || (BCM_ERR_EAGAIN == ret))
                *aVerifStatus = BCM_ERR_BUSY
                ret = BCM_ERR_BUSY
            else
                CRYPTO_VerifyHWUninitCtx(aAlgCtx)
                *aVerifStatus = BCM_ERR_AUTH_FAILED
                ret = BCM_ERR_OK
        case CRYPTO_VERIFY_HW_ALGO_CTX_STATE_DIGEST_IN_PROGRESS:
            *aVerifStatus = BCM_ERR_BUSY
            ret = BCM_ERR_BUSY
        case CRYPTO_VERIFY_HW_ALGO_CTX_STATE_DIGEST_DONE
            if (aAlgCtx->consumedSize < aAlgCtx->expectedSize)
                aAlgCtx->state = CRYPTO_VERIFY_HW_ALGO_CTX_STATE_DIGEST_MORE_DATA
                *aVerifStatus = BCM_ERR_BUSY
                ret = BCM_ERR_OK
            else
                ret = CRYPTO_VerifyHWSigVerifSubmit(aAlgCtx)
                if ((BCM_ERR_BUSY == ret) || (BCM_ERR_EAGAIN == ret))
                    *aVerifStatus = BCM_ERR_BUSY
                    ret = BCM_ERR_BUSY
                else
                    CRYPTO_VerifyHWUninitCtx(aAlgCtx)
                    *aVerifStatus = BCM_ERR_AUTH_FAILED
                    ret = BCM_ERR_OK
        case CRYPTO_VERIFY_HW_ALGO_CTX_STATE_SIG_VERIF_IN_PROGRESS:
            *aVerifStatus = BCM_ERR_BUSY
            ret = BCM_ERR_BUSY
        break;
        case CRYPTO_VERIFY_HW_ALGO_CTX_STATE_SIG_VERIF_DONE:
            CRYPTO_VerifyHWUninitCtx(aAlgCtx);
            *aVerifStatus = aAlgCtx->sigVerifJobExecResult
            ret = BCM_ERR_OK
        break;
        case CRYPTO_VERIFY_HW_ALGO_CTX_STATE_UNINIT:
        default:
            *aVerifStatus = BCM_ERR_INVAL_STATE
            ret = BCM_ERR_OK
        break;

    return ret
    @endcode
*/
static int32_t CRYPTO_VerifyHWProcessUpdateMsg(const CRYPTO_VerifyUpdateType *const aCryptUpdateParams, int32_t *const aVerifStatus, CRYPTO_VerifyHWAlgoCtxType *const aAlgCtx)
{
    int32_t ret;

    switch (aAlgCtx->state) {
        case CRYPTO_VERIFY_HW_ALGO_CTX_STATE_DIGEST_MORE_DATA:
            /* Attempt to issue a message digest job */
            ret = CRYPTO_VerifyHWDigestSubmit(aCryptUpdateParams, aAlgCtx);
            if ((BCM_ERR_BUSY == ret) || (BCM_ERR_EAGAIN == ret)) {
                *aVerifStatus = BCM_ERR_BUSY;
                ret = BCM_ERR_BUSY;
            } else {
                CRYPTO_VerifyHWUninitCtx(aAlgCtx);
                *aVerifStatus = BCM_ERR_AUTH_FAILED;
                ret = BCM_ERR_OK;
            }
        break;
        case CRYPTO_VERIFY_HW_ALGO_CTX_STATE_DIGEST_IN_PROGRESS:
            /*
                Do nothing. HW is busy digesting the previously submitted message chunk.

                The CRYPTO_VerifyHWDigestDone function will appropriately transition the
                context state on job completion.
            */
            *aVerifStatus = BCM_ERR_BUSY;
            ret = BCM_ERR_BUSY;
        break;
        case CRYPTO_VERIFY_HW_ALGO_CTX_STATE_DIGEST_DONE:
            if (aAlgCtx->consumedSize < aAlgCtx->expectedSize) {
                /* Complete this message. Set the alg state to MORE_DATA */
                aAlgCtx->state = CRYPTO_VERIFY_HW_ALGO_CTX_STATE_DIGEST_MORE_DATA;
                *aVerifStatus = BCM_ERR_BUSY;
                ret = BCM_ERR_OK;
            } else {
                /* Attempt to issue a signature verification operation */
                ret = CRYPTO_VerifyHWSigVerifSubmit(aAlgCtx);
                if ((BCM_ERR_BUSY == ret) || (BCM_ERR_EAGAIN == ret)) {
                    *aVerifStatus = BCM_ERR_BUSY;
                    ret = BCM_ERR_BUSY;
                } else {
                    CRYPTO_VerifyHWUninitCtx(aAlgCtx);
                    *aVerifStatus = BCM_ERR_AUTH_FAILED;
                    ret = BCM_ERR_OK;
                }
            }
        break;
        case CRYPTO_VERIFY_HW_ALGO_CTX_STATE_SIG_VERIF_IN_PROGRESS:
            /*
                Do nothing. PKA is performing the signature verificaiton job

                The CRYPTO_VerifyHWSigVerifDone function will appropriately transition the
                context state on job completion.
            */
            *aVerifStatus = BCM_ERR_BUSY;
            ret = BCM_ERR_BUSY;
        break;
        case CRYPTO_VERIFY_HW_ALGO_CTX_STATE_SIG_VERIF_DONE:
            CRYPTO_VerifyHWUninitCtx(aAlgCtx);
            *aVerifStatus = aAlgCtx->sigVerifJobExecResult;
            ret = BCM_ERR_OK;
        break;
        case CRYPTO_VERIFY_HW_ALGO_CTX_STATE_UNINIT:
        default:
            *aVerifStatus = BCM_ERR_INVAL_STATE;
            ret = BCM_ERR_OK;
        break;
    }

    return ret;
}

/**
    @brief Crypto veify module process message

    @pre None

    @param[in]      aCtxIdx                     Context index to process the message against
    @param[in]      aMsgIdx                     Message index

    Return values are documented in reverse-chronological order
    @retval         #BCM_ERR_BUSY               The update message is being processed (asynchronously)
    @retval         #BCM_ERR_OK                 Signals the caller that the message
                                                processing is complete and a response can
                                                be sent to the client

    @trace #BRCM_SWARCH_CRYPTO_VERIFY_MODULE_GLOBAL
    @trace #BRCM_SWREQ_CRYPTO_VERIFY_HARDWARE

    @code{.unparsed}
    ctx = &CRYPTO_VerifyHWModCtx
    algoCtx = &ctx->algoCtx[aCtxIdx]
    msg = &algoCtx->msg[aMsgIdx]
    id = BCM_GET_CMDID(msg->id)

    switch (id) {
        case CRYPTO_VERIFY_INIT:
            ret = CRYPTO_VerifyHWProcessInitMsg(&msg->u.init, &msg->status, algoCtx);
        break;
        case CRYPTO_VERIFY_UPDATE:
            ret = CRYPTO_VerifyHWProcessUpdateMsg(&msg->u.update, &msg->status, algoCtx);
        break;
        default:
            msg->status = BCM_ERR_NOSUPPORT;
            ret = BCM_ERR_OK;
        break;
    }

    return ret;
    @endcode
*/
static int32_t CRYPTO_VerifyHWProcessMsg(uint32_t aCtxIdx, uint32_t aMsgIdx)
{
    int32_t ret;

    CRYPTO_VerifyHWModCtxType *ctx = &CRYPTO_VerifyHWModCtx;
    CRYPTO_VerifyHWAlgoCtxType *algoCtx = &ctx->algoCtx[aCtxIdx];
    CRYPTO_VerifyMsgType *msg = &algoCtx->msg[aMsgIdx];
    CRYPTO_VerifyType id = (CRYPTO_VerifyType)(BCM_GET_CMDID(msg->id));

    switch (id) {
        case CRYPTO_VERIFY_INIT:
            ret = CRYPTO_VerifyHWProcessInitMsg(&msg->u.init, &msg->status, algoCtx);
        break;
        case CRYPTO_VERIFY_UPDATE:
            ret = CRYPTO_VerifyHWProcessUpdateMsg(&msg->u.update, &msg->status, algoCtx);
        break;
        default:
            msg->status = BCM_ERR_NOSUPPORT;
            ret = BCM_ERR_OK;
        break;
    }

    return ret;
}

/**
    @brief Crypto verify module event handler

    @trace #BRCM_SWARCH_CRYPTO_VERIFY_MODULE_GLOBAL
    @trace #BRCM_SWREQ_CRYPTO_VERIFY_HARDWARE

    @code{.unparsed}
    ctx = &CRYPTO_VerifyHWModCtx

    if (aMask & SPUMEvent)
        CRYPTO_VerifyHWDigestDone()

    if (aMask & PKAEvent)
        CRYPTO_VerifyHWSigVerifDone()

    if (aMask & MODULE_EVENT)
        for each ctx in CRYPTO_VERIFY_HW_NUM_CTX
            loop on success
                ret = MSGQ_CtxGetMsgIdx(&CRYPTO_VerifyModule.cmdQ, ctx ,&idx)
                if ret is ERR_OK
                    if CRYPTO_VerifyHWModMVK.keyLenWords is 0
                        ctx->algoCtx[ctx].msg[idx].status = ERR_NOT_FOUND
                        retVal = BCM_ERR_OK
                    else
                        retVal = CRYPTO_VerifyHWProcessMsg(ctx,idx)

                    if (BCM_ERR_BUSY != retVal)
                        ret = MSGQ_CtxCompleteMsgIdx(&CRYPTO_VerifyModule.cmdQ, ctx, idx)
                        if ret is not ERR_OK
                            report error

                else if ret is ERR_UNINIT
                    CRYPTO_VerifyHWUninitCtx(&ctx->algoCtx[ctxIdx])
                else if ret is not ERR_BUSY
                    report error
    @endcode
*/
static void CRYPTO_VerifyHWEventHandler(uint32_t aMask)
{
    CRYPTO_VerifyHWModCtxType *ctx = &CRYPTO_VerifyHWModCtx;

    if (0UL != (aMask & SPUMEvent)) {
        CRYPTO_VerifyHWDigestDone();
    }

    if (0UL != (aMask & PKAEvent)) {
        CRYPTO_VerifyHWSigVerifDone();
    }

    if (0UL != (aMask & CRYPTO_VERIFY_HW_EVENT_MASK)) {
        int32_t ret;
        uint32_t i;
        uint32_t msgIdx = 0UL;
        for (i = 0UL; i < CRYPTO_VERIFY_HW_NUM_CTX; i++) {
            /*
                In an attempt to be fair to all the contexts, we start processing
                form the context index one next to the context against which a HW
                job was issued in the previous run.

                CRYPTO_VERIFY_HW_NUM_CTX is assumed to be a power of two.
            */
            /* @event            Constant expression result
               @issue            The expression (CRYPTO_VERIFY_HW_NUM_CTX - 1UL) is always zero
               @risk             No risk
               @justification    The expression (CRYPTO_VERIFY_HW_NUM_CTX - 1UL) is zero
                                 for only bcm8956x a0 */
            const uint32_t ctxIdx = (ctx->lastProcessedCtxIdx + i + 1UL) & (CRYPTO_VERIFY_HW_NUM_CTX - 1UL);
            do {
                /* Get message from queue */
                ret = MSGQ_CtxGetMsgIdx(&CRYPTO_VerifyModule.cmdQ, ctxIdx, &msgIdx);
                if (ret == BCM_ERR_OK) {
                    int32_t retVal;

                    if (0UL == CRYPTO_VerifyHWModMVK.keyLenWords) {
                        ctx->algoCtx[ctxIdx].msg[msgIdx].status = BCM_ERR_NOT_FOUND;
                        retVal = BCM_ERR_OK;
                    } else {
                        retVal = CRYPTO_VerifyHWProcessMsg(ctxIdx, msgIdx);
                    }

                    /* Mark the message as completed if needed */
                    if (BCM_ERR_BUSY != retVal) {
                        retVal = MSGQ_CtxCompleteMsgIdx(&CRYPTO_VerifyModule.cmdQ, ctxIdx, msgIdx);
                        if (BCM_ERR_OK != retVal) {
                            CRYPTO_VerifyHWModReportError(BRCM_SWDSGN_CRYPTO_VERIFY_HW_EVENT_HANDLER_PROC,
                                retVal, BCM_STATE_UNINIT, __LINE__
                            );
                        }
                    } else {
                        /* Message is being processed. Move on to the next context */
                        break;
                    }
                } else if (BCM_ERR_UNINIT == ret) {
                    CRYPTO_VerifyHWUninitCtx(&ctx->algoCtx[ctxIdx]);
                } else if (BCM_ERR_BUSY != ret) {
                    CRYPTO_VerifyHWModReportError(BRCM_SWDSGN_CRYPTO_VERIFY_HW_EVENT_HANDLER_PROC, ret, BCM_STATE_UNINIT, __LINE__);
                } else {
                    /* Do nothing */
                }
            } while (BCM_ERR_OK == ret);
        }
    }
}

/**
    @brief Crypto verify module get event mask

    @trace #BRCM_SWARCH_CRYPTO_VERIFY_MODULE_GLOBAL
    @trace #BRCM_SWREQ_CRYPTO_VERIFY_HARDWARE

    @code{.unparsed}
    return (MODULE_EVENT)
    @endcode
*/
static uint32_t CRYPTO_VerifyHWGetEventMask(void)
{
    return CRYPTO_VERIFY_HW_EVENT_MASK;
}

/**
    @brief Crypto verify module Info

    @trace #BRCM_SWARCH_CRYPTO_VERIFY_MODULE_GLOBAL
    @trace #BRCM_SWREQ_CRYPTO_VERIFY_HARDWARE
*/
const MODULE_Type CRYPTO_VerifyModule = {
    .groupID           = BCM_GROUPID_CRYPTO,
    .compID            = BCM_CVM_ID,
    .configImgID       = ((uint16_t) 0UL),
    .configImgData     = NULL,
    .configImgSize     = 0UL,
    .context           = &CRYPTO_VerifyHWModCtx.modCtx,
    .resetStateHandler = CRYPTO_VerifyHWResetStateHandler,
    .initStateHandler  = NULL,
    .readyStateHandler = NULL,
    .runStateHandler   = NULL,
    .eventHandler      = CRYPTO_VerifyHWEventHandler,
    .cmdQ              = MSGQ_INIT_V2_WITH_CONTEXT(CRYPTO_VERIFY_NUM_MSG_PER_CTX_LOG2,
                                                CRYPTO_VERIFY_NUM_CTX_LOG2,
                                                CRYPTO_GetServer,
                                                CRYPTO_VerifyMsgType,
                                                CRYPTO_VerifyHWMsgQCtx,
                                                CRYPTO_VerifyHWGetMsg),
    .mergeResult       = NULL,
    .getEventMask      = CRYPTO_VerifyHWGetEventMask,
    .sendCmd           = CRYPTO_VerifySendCmd,
    .getResp           = CRYPTO_VerifyGetResp,
};
/** @} */
