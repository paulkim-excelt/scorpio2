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
    @defgroup grp_crypto_verify_ifc Verify Interface
    @ingroup grp_crypto_abstract

    @addtogroup grp_crypto_verify_ifc
    @{

    @section sec_crypto_verify_seq Sequence Diagrams
    @tagseq crypto_verify_direct_client.svg "Direct Client"
    @startseq
    group {label = "CLIENT"; color = "#EFFFFF";  Client;};
    group {label = "CRYPTO API"; color = "#FFEFFF";  VERIFY_API; };
    group {label = "CRYPTO"; color = "#FFFFEF"; MSGQ; VERIFY_Module;};
    Client => VERIFY_API [label = "CRYPTO_VerifyInit", return = "seesionHdl"] {
        VERIFY_API => MSGQ [label = "MSGQ_CtxCreate", return = "seesionHdl"];
        VERIFY_API -> MSGQ [label = "MSGQ_CtxSendMsg", note="Init"] {
            MSGQ  --> VERIFY_Module [label = "signal"] {
                VERIFY_API <--  MSGQ;
            };
        };
    };
    VERIFY_Module => MSGQ [label = "MSGQ_CtxGetMsgIdx", note="Initialize Context"];
    VERIFY_Module => MSGQ [label = "MSGQ_CtxCompleteMsgIdx"];
    Client <-- VERIFY_Module;
    loop {
        Client => VERIFY_API [label = "CRYPTO_VerifyUpdate", return = "jobHdl"] {
            VERIFY_API -> MSGQ [label = "MSGQ_CtxSendMsg", note="non-zero buffer"] {
                MSGQ  --> VERIFY_Module [label = "signal"] {
                    VERIFY_API <--  MSGQ;
                };
            };
        };
        VERIFY_Module => MSGQ [label = "MSGQ_CtxGetMsgIdx", note="Update Context"];
        VERIFY_Module => MSGQ [label = "MSGQ_CtxCompleteMsgIdx"];
        Client <-- VERIFY_Module;
        Client => VERIFY_API [label = "CRYPTO_VerifyStatus", note="for jobHdl"] {
            VERIFY_API => MSGQ [label = "MSGQ_CtxRecvMsg"];
        };
    };
    Client => VERIFY_API [label = "CRYPTO_VerifyFinish"] {
        VERIFY_API -> MSGQ [label = "MSGQ_CtxSendMsg", note="status query"] {
            MSGQ  --> VERIFY_Module [label = "signal"] {
                VERIFY_API <--  MSGQ;
            };
        };
        VERIFY_Module => MSGQ [label = "MSGQ_CtxGetMsgIdx", note="Finalize Context"];
        VERIFY_Module => MSGQ [label = "MSGQ_CtxCompleteMsgIdx"];
        Client <-- VERIFY_Module;
        VERIFY_API => MSGQ [label="MSGQ_GetNextMsgHdl", return="jobHdl"];
        VERIFY_API => MSGQ [label="MSGQ_CtxRecvMsg"];
        VERIFY_API => MSGQ [label="MSGQ_CtxDestroy"];
    };
    @endseq

    @limitations None

    @file crypto_verify.h
    @brief Crypto Verify Interface
    This header file contains the interface functions for crypto based verification
    @version 0.1 Initial Version
*/

#ifndef CRYPTO_VERIRY_H
#define CRYPTO_VERIRY_H

#include <crypto_common.h>
#include <msg_queue.h>

/**
    @name Crypto Verify Architecture IDs
    @{
    @brief Architecture IDs for Crypto Verify
*/
#define BRCM_SWARCH_CRYPTO_VERIFY_MACRO             (0x8200U)    /**< @brief #CRYPTO_VERIFY_MSG_SIZE    */
#define BRCM_SWARCH_CRYPTO_VERIFY_TYPE              (0x8201U)    /**< @brief #CRYPTO_VerifyType         */
#define BRCM_SWARCH_CRYPTO_VERIFY_RAW_INIT_TYPE     (0x8202U)    /**< @brief #CRYPTO_VerifyRawInitType  */
#define BRCM_SWARCH_CRYPTO_VERIFY_RAW_UPDATE_TYPE   (0x8203U)    /**< @brief #CRYPTO_VerifyRawUpdateType*/
#define BRCM_SWARCH_CRYPTO_VERIFY_INIT_TYPE         (0x8204U)    /**< @brief #CRYPTO_VerifyInitType     */
#define BRCM_SWARCH_CRYPTO_VERIFY_UPDATE_TYPE       (0x8205U)    /**< @brief #CRYPTO_VerifyUpdateType   */
#define BRCM_SWARCH_CRYPTO_VERIFY_RESPONSE_TYPE     (0x8206U)    /**< @brief #CRYPTO_VerifyResponseType */
#define BRCM_SWARCH_CRYPTO_VERIFY_MSG_UNION_TYPE    (0x8207U)    /**< @brief #CRYPTO_VerifyMsgUnionType */
#define BRCM_SWARCH_CRYPTO_VERIFY_MSG_TYPE          (0x8208U)    /**< @brief #CRYPTO_VerifyMsgType      */
#define BRCM_SWARCH_CRYPTO_VERIFY_INIT_PROC         (0x8209U)    /**< @brief #CRYPTO_VerifyInit         */
#define BRCM_SWARCH_CRYPTO_VERIFY_UPDATE_PROC       (0x820AU)    /**< @brief #CRYPTO_VerifyUpdate       */
#define BRCM_SWARCH_CRYPTO_VERIFY_STATUS_PROC       (0x820BU)    /**< @brief #CRYPTO_VerifyStatus       */
#define BRCM_SWARCH_CRYPTO_VERIFY_CANCEL_PROC       (0x820CU)    /**< @brief #CRYPTO_VerifyCancel       */
#define BRCM_SWARCH_CRYPTO_VERIFY_SEND_CMD_PROC     (0x820DU)    /**< @brief #CRYPTO_VerifySendCmd      */
#define BRCM_SWARCH_CRYPTO_VERIFY_GET_RESP_PROC     (0x820EU)    /**< @brief #CRYPTO_VerifyGetResp      */
/** @} */


/**
    @name CRYPTO Verify Macros
    @{
    @brief Crypto Verify Macros

    @trace #BRCM_SWREQ_CRYPTO
**/
#define CRYPTO_VERIFY_MSG_SIZE              (368UL) /**< @brief Crypto Verify message Size */
#define CRYPTO_VERIFY_KEY_AUTH_MAX_SIZE     (32UL)  /**< @brief Crypto Verify Key Authorization max size */
#define CRYPTO_VERIFY_SIGNATURE_MAX_SIZE    (256UL) /**< @brief Crypto Verify Signature max size */
#define CRYPTO_VERIFY_CHUNK_MAX_SIZE        (320UL) /**< @brief Crypto Verify Chunk max size */
/** @} */

/**
    @name CRYPTO Verify Message IDs
    @{
    @brief Message IDs for exchange on message queues

    These are used for interaction over MSGQ interface and RPC commands.
    Hence, this must be within 8-bit space.

    @trace #BRCM_SWREQ_CRYPTO
*/
typedef uint8_t CRYPTO_VerifyType;      /**< @brief Verify message Type */
#define CRYPTO_VERIFY_RAW_INIT     (0U) /**< @brief Initialize Verify Context   */
#define CRYPTO_VERIFY_RAW_UPDATE   (1U) /**< @brief Update Verify Context       */
#define CRYPTO_VERIFY_INIT         (8U) /**< @brief Initialize Verify Context   */
#define CRYPTO_VERIFY_UPDATE       (9U) /**< @brief Update Verify Context       */
/** @} */

/**
    @brief Verity Raw Init Structure (320 Bytes)

    @trace #BRCM_SWREQ_CRYPTO
 */
typedef struct sCRYPTO_VerifyRawInitType {
    CRYPTO_KeyHdlType   keyHdl;     /**< @brief Key Handle              */
    CRYPTO_AlgoType     algo;       /**< @brief Algorithm               */
    CRYPTO_AlgoType     hash;       /**< @brief Hash Type               */
    CRYPTO_AlgoType     padding;    /**< @brief Padding Type            */
    uint32_t            msgLength;  /**< @brief Message Length          */
    uint32_t            keyAuthLen; /**< @brief Key Authorization length
                                            must be zero for MVK        */
    uint32_t            sigLen;     /**< @brief Signature Length        */
    uint8_t             keyAuth[CRYPTO_VERIFY_KEY_AUTH_MAX_SIZE];
                                        /**< @brief Key Authorization value */
    uint8_t             signature[CRYPTO_VERIFY_SIGNATURE_MAX_SIZE];
                                        /**< @brief Signature (input)       */
    uint32_t            reserved[12UL];
} CRYPTO_VerifyRawInitType;
_Static_assert(CRYPTO_VERIFY_MSG_SIZE == sizeof(CRYPTO_VerifyRawInitType),
    "Ease of debug will be broken if the size is not properly aligned");

/**
    @brief Verity Raw Update Structure

    @trace #BRCM_SWREQ_CRYPTO
*/
typedef struct sCRYPTO_VerifyRawUpdateType {
    uint32_t            chunkSize;          /**< @brief Chunk Size          */
    uint8_t             chunkData[CRYPTO_VERIFY_CHUNK_MAX_SIZE];
                                            /**< @brief Chunk data          */
    uint32_t            reserved[11UL];
} CRYPTO_VerifyRawUpdateType;
_Static_assert(CRYPTO_VERIFY_MSG_SIZE == sizeof(CRYPTO_VerifyRawUpdateType),
    "Size of this structure must match other messages in this file");

/**
    @brief Verity Init Structure (320 Bytes)

    @trace #BRCM_SWREQ_CRYPTO
 */
typedef struct sCRYPTO_VerifyInitType {
    MSGQ_HdlType        ctxHdl;     /**< @brief Session Handle      */
    CRYPTO_KeyHdlType   keyHdl;     /**< @brief Key Handle              */
    CRYPTO_AlgoType     algo;       /**< @brief Algorithm               */
    CRYPTO_AlgoType     hash;       /**< @brief Hash Type               */
    CRYPTO_AlgoType     padding;    /**< @brief Padding Type            */
    uint32_t            msgLength;  /**< @brief Message Length          */
    uint32_t            keyAuthLen; /**< @brief Key Authorization length
                                            must be zero for MVK        */
    uint32_t            sigLen;     /**< @brief Signature Length        */
    uint8_t             *keyAuth;   /**< @brief Key Authorization value */
    uint8_t             *signature; /**< @brief Signature (input)       */
    uint32_t            reserved[80UL];
} CRYPTO_VerifyInitType;
_Static_assert(CRYPTO_VERIFY_MSG_SIZE == sizeof(CRYPTO_VerifyInitType),
    "Ease of debug will be broken if the size is not properly aligned");

/**
    @brief Verity Update Structure

    @trace #BRCM_SWREQ_CRYPTO
 */
typedef struct sCRYPTO_VerifyUpdateType {
    MSGQ_HdlType        ctxHdl;     /**< @brief Session Handle      */
    uint32_t            chunkSize;  /**< @brief Chunk Size (input)              */
    uint8_t             *chunkData; /**< @brief Chunk data pointer (input)      */
    uint32_t            reserved[88UL];
} CRYPTO_VerifyUpdateType;
_Static_assert(CRYPTO_VERIFY_MSG_SIZE == sizeof(CRYPTO_VerifyUpdateType),
    "Size of this structure must match other messages in this file");

/**
    @brief Response Structure used for VerifyInit & VerifyUpdate

    @trace #BRCM_SWREQ_CRYPTO
 */
typedef struct sCRYPTO_VerifyResponseType {
    MSGQ_HdlType        ctxHdl;     /**< @brief Session Handle      */
    int32_t             status;     /**< @brief Command status      */
    uint32_t            reserved[89UL];
} CRYPTO_VerifyResponseType;
_Static_assert(CRYPTO_VERIFY_MSG_SIZE == sizeof(CRYPTO_VerifyResponseType),
    "Size of this structure must match other messages in this file");

/**
    @brief Verity Union encapsulating all messages

    @trace #BRCM_SWREQ_CRYPTO
*/
typedef union uCRYPTO_VerifyMsgUnionType {
    uint32_t                  data[CRYPTO_VERIFY_MSG_SIZE/4UL];
    CRYPTO_VerifyInitType     init;      /**< @brief Verify Init command data */
    CRYPTO_VerifyUpdateType   update;    /**< @brief Verify Update command data */
    CRYPTO_VerifyResponseType response;  /**< @beief Response data for either commands */
} CRYPTO_VerifyMsgUnionType;

/**
    @brief Verity Union encapsulating all messages

    @trace #BRCM_SWREQ_CRYPTO
*/
typedef struct sCRYPTO_VerifyMsgType {
    uint32_t                    magic;
    BCM_CmdType                 id;
    int32_t                     status;
    uint32_t                    reserved;
    CRYPTO_VerifyMsgUnionType   u;
} CRYPTO_VerifyMsgType;

/** @brief Crypto Verification initialization

    Initializes Crypto Verification Context based on key, algorithm, message size,
    and signature

    @behavior Async, Re-entrant

    @pre Crypto Verify module is in initialized state (#CRYPTO_VerifyModule)

    @param[inout]   aInitInfo   Verification Initialization Info
    @param[in]      aClientMask Mask with which the caller need to be signalled
    @param[in/out]  aCtxHdl     Context Handle (If valid use the same)
    @param[out]     aJobHdl     Job Handle (may be NULL)

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Success
    @retval     #BCM_ERR_UNKNOWN        Integration fault
    @retval     #BCM_ERR_NOMEM          All Verify contexts are busy
    @retval     #BCM_ERR_INVAL_PARAMS   (aInitInfo is NULL) or (aCtxHdl is NULL)

    @post None

    @trace #BRCM_SWREQ_CRYPTO

    @limitations None
*/
int32_t CRYPTO_VerifyInit(CRYPTO_VerifyInitType *aInitInfo, uint32_t aClientMask,
                            MSGQ_HdlType *aCtxHdl, MSGQ_HdlType *aJobHdl);

/** @brief Update Verify context

    Update hash with in the verify context based on message provided and
    performs verification when complete msgSize is received

    @behavior Async, Re-entrant

    @pre Verify Context is created and intialized using #CRYPTO_VerifyInit

    @param[in]      aCtxHdl         Context Handle
    @param[in]      aUpdateInfo     Verification update information with message
    @param[out]     aJobHdl         Job Handle (may be NULL)

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Update request posted to Verify Module
    @retval     #BCM_ERR_UNKNOWN        Integration fault
    @retval     #BCM_ERR_NOMEM          Contexts Queue is full
    @retval     #BCM_ERR_INVAL_PARAMS   aUpdateInfo is NULL

    @post None

    @trace #BRCM_SWREQ_CRYPTO

    @limitations None
*/
int32_t CRYPTO_VerifyUpdate(MSGQ_HdlType aCtxHdl, const CRYPTO_VerifyUpdateType *aUpdateInfo, MSGQ_HdlType *aJobHdl);

/** @brief Query status of proviously posted job

    @behavior Sync, Re-entrant

    @pre aCtxHdl is created using #CRYPTO_VerifyInit and aJobHdl is created using
        #CRYPTO_VerifyInit or #CRYPTO_VerifyUpdate

    @param[in]      aCtxHdl     Context Handle
    @param[in]      aJobHdl     Job Handle (may be #MSGQ_HDL_INVALID)
    @param[out]     aStatus     Authentication Status

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Request processing complete
    @retval     #BCM_ERR_BUSY           Request is being processed
    @retval     #BCM_ERR_UNKNOWN        Integration fault
    @retval     #BCM_ERR_INVAL_PARAMS   aStatus is NULL

    @post When "return value is #BCM_ERR_UNKNOWN" or "return Value is #BCM_ERR_OK and
    aStatus is not BCM_ERR_BUSY", Context is already destroyed


    @note aStatus values are documented in reverse-chronological order
    aStatus is set to #BCM_ERR_OK if authentication success.
    aStatus is set to #BCM_ERR_AUTH_FAILED if authentication failed.
    aStatus is set to #BCM_ERR_NO_SUPPORT if authentication mechanism is not supported.
    aStatus is set to #BCM_ERR_NOT_FOUND if Key is not present (returned only if using special key handles).
    aStatus is set to #BCM_ERR_BUSY if authentication is not complete.
    aStatus is set to #BCM_ERR_INVAL_STATE if request is not allowed.

    @trace #BRCM_SWREQ_CRYPTO

    @limitations None
*/
int32_t CRYPTO_VerifyStatus(MSGQ_HdlType aCtxHdl, MSGQ_HdlType aJobHdl, int32_t *aStatus);

/** @brief Cancel the verification

    @behavior Sync, Re-entrant

    @pre aCtxHdl is created using #CRYPTO_VerifyInit

    @param[in]      aCtxHdl     Context Handle

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully canceled
    @retval     #BCM_ERR_AUTH_FAILED    Task ID of the caller is not matching
                                        with the requestor’s Task ID
    @retval     #BCM_ERR_BUSY           Pending processing on aCtxHdl
    @retval     #BCM_ERR_UNKNOWN        Integration fault

    @post When "return value is #BCM_ERR_OK" Context is already destroyed

    @trace #BRCM_SWREQ_CRYPTO

    @limitations None
*/
int32_t CRYPTO_VerifyCancel(MSGQ_HdlType aCtxHdl);

/** @brief Send commands to verify module

    This API queues the crypto commands to crypto verify module

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aCmd                Command ID
    @param[in]      aLen                Length of the management command message
    @param[in]      aCmdData            Management command information
    @param[in]      aHandle             Pointer to BCM_HandleType for later query
                                        using #BCM_ModGetStatusType
    @param[out]     aForwardToSlaves    Is this message needed to be forwarded
                                        to slaves

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK     Command posted successfully

    @post None

    @trace #BRCM_SWREQ_CRYPTO
*/
int32_t CRYPTO_VerifySendCmd(BCM_CmdType aCmd, uint32_t aLen, const uint8_t *aCmdData,
                                        BCM_HandleType *aHandle, uint32_t *aForwardToSlaves);

/** @brief Retreive status of crypto verify commands

    This API queries the status of completed crypto verify commands which were
    previously issued

    @behavior Sync, Re-entrant

    @pre None

    @param[in]   aHandle                BCM Handle to retrieve response
    @param[in]   aReplyID               Reply ID (group, comp, cmd)
    @param[in]   aInLen                 Available Length of the reply data payload in bytes
    @param[out]  aReplyData             Pointer to the reply data payload
    @param[out]  aReplyDataLen          Actual Length of the reply data payload in bytes

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK     Command status retrieved successfully

    @post None

    @trace #BRCM_SWREQ_CRYPTO
*/
int32_t CRYPTO_VerifyGetResp(BCM_HandleType aHandle, BCM_CmdType aReplyID, uint32_t aInLen,
                                     uint8_t *aReplyData, uint32_t *aReplyDataLen);
#endif /* CRYPTO_VERIRY_H */

/** @} */
