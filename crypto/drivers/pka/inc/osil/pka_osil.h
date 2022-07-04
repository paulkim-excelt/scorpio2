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

/** @defgroup grp_pka_il Integration Guide
    @ingroup grp_pka

    @addtogroup grp_pka_il
    @{

    @file pka_osil.h
    @brief PKA driver Integration Interfaces
    This header file contains the integration interface for the PKA driver
    @version 0.10 Initial version
*/

#ifndef PKA_OSIL_H
#define PKA_OSIL_H

#include <stdint.h>
#include <svc.h>
#include <pka_lib.h>

/**
    @name PKA driver interface IDs
    @{
    @brief Interface IDs for the PKA driver
*/
#define BRCM_SWARCH_PKA_CMD_TYPE                        (0x9101U)    /**< @brief #PKA_CmdType                    */
#define BRCM_SWARCH_PKA_INCMD_GET_JOB_STATUS_TYPE       (0x9102U)    /**< @brief #PKA_InCmdGetJobStatusType      */
#define BRCM_SWARCH_PKA_OUTCMD_GET_JOB_STATUS_TYPE      (0x9103U)    /**< @brief #PKA_OutCmdGetJobStatusType     */
#define BRCM_SWARCH_PKA_INCMD_RSA_VERIFY_TYPE           (0x9104U)    /**< @brief #PKA_InCmdRsaVerifyType         */
#define BRCM_SWARCH_PKA_OUTCMD_RSA_VERIFY_TYPE          (0x9105U)    /**< @brief #PKA_OutCmdRsaVerifyType        */
#define BRCM_SWARCH_PKA_INCMD_ECDSA_SIGN_TYPE           (0x9106U)    /**< @brief #PKA_InCmdEcdsaSignType         */
#define BRCM_SWARCH_PKA_OUTCMD_ECDSA_SIGN_TYPE          (0x9107U)    /**< @brief #PKA_OutCmdEcdsaSignType        */
#define BRCM_SWARCH_PKA_INCMD_ECDSA_VERIFY_TYPE         (0x9108U)    /**< @brief #PKA_InCmdEcdsaVerifyType       */
#define BRCM_SWARCH_PKA_OUTCMD_ECDSA_VERIFY_TYPE        (0x9109U)    /**< @brief #PKA_OutCmdEcdsaVerifyType      */
#define BRCM_SWARCH_PKA_INCMD_ECDHE_TYPE                (0x910AU)    /**< @brief #PKA_InCmdEcdheType             */
#define BRCM_SWARCH_PKA_OUTCMD_ECDHE_TYPE               (0x910BU)    /**< @brief #PKA_OutCmdEcdheType            */
#define BRCM_SWARCH_PKA_IN_IOPARAMS_TYPE                (0x910CU)    /**< @brief #PKA_InIOParamsType             */
#define BRCM_SWARCH_PKA_OUT_IOPARAMS_TYPE               (0x910DU)    /**< @brief #PKA_OutIOParamsType            */
#define BRCM_SWARCH_PKA_IO_TYPE                         (0x910EU)    /**< @brief #PKA_IOType                     */
#define BRCM_SWARCH_PKA_SVCIO_TYPE                      (0x910FU)    /**< @brief #PKA_SVCIOType                  */
#define BRCM_SWARCH_PKA_SYSCMD_REQ_PROC                 (0x9110U)    /**< @brief #PKA_SysCmdReq                  */
#define BRCM_SWARCH_PKA_SYSCMD_HANDLER_PROC             (0x9111U)    /**< @brief #PKA_SysCmdHandler              */
#define BRCM_SWARCH_PKA_RUN_JOB_SCHEDULER_PROC          (0x9112U)    /**< @brief #PKA_RunJobScheduler            */
#define BRCM_SWARCH_PKA_OSIL_NOTIFY_JOB_START_PROC      (0x9113U)    /**< @brief #PKA_OsilNotifyJobStart         */
#define BRCM_SWARCH_PKA_OSIL_NOTIFY_JOB_COMPLETE_PROC   (0x9114U)    /**< @brief #PKA_OsilNotifyJobComplete      */
#define BRCM_SWARCH_PKA_IRQHANDLER_PROC                 (0x9115U)    /**< @brief #PKA_IRQHandler                 */
/** @} */

/**
    @name PKA_CmdType
    @{
    @brief PKA driver command type

    @trace #BRCM_SWREQ_PKA_KERNEL_INTERFACE
*/
typedef uint32_t PKA_CmdType;                       /**< @brief PKA command type                                            */
#define PKA_CMD_INIT                    (0x00UL)    /**< @brief PKA command to initialize the driver                        */
#define PKA_CMD_DEINIT                  (0x01UL)    /**< @brief PKA command to deinit the driver                            */
#define PKA_CMD_GET_JOB_STATUS          (0x02UL)    /**< @brief PKA command to query the job status                         */
#define PKA_CMD_RSA_VERIFY              (0x03UL)    /**< @brief PKA command to issue a RSA signature verification           */
#define PKA_CMD_ECDSA_SIGN              (0x04UL)    /**< @brief PKA command to issue a ECDSA signing operation              */
#define PKA_CMD_ECDSA_VERIFY            (0x05UL)    /**< @brief PKA command to issue a ECDSA verification operation         */
#define PKA_CMD_ECDHE                   (0x06UL)    /**< @brief PKA command to issue a ECDHE key exchange operation         */
/** @} */

/**
    @brief Input parametres to process the PKA job status command

    @trace #BRCM_SWREQ_PKA_KERNEL_INTERFACE
*/
typedef struct sPKA_InCmdGetJobStatusType {
    PKA_JobIdType jobId;                /**< @brief PKA job ID whose status is being requested  */
} PKA_InCmdGetJobStatusType;

/**
    @brief Results generated by the PKA job status command

    @trace #BRCM_SWREQ_PKA_KERNEL_INTERFACE
*/
typedef struct sPKA_OutCmdGetJobStatusType {
    int32_t algExecResult;              /**< @brief Result of the job execution     */
} PKA_OutCmdGetJobStatusType;

/**
    @brief Input parametres to issue a RSA signature verification job

    @trace #BRCM_SWREQ_PKA_KERNEL_INTERFACE
*/
typedef struct sPKA_InCmdRsaVerifyType {
    PKA_RsaSignatureSchemeType sigScheme;       /**< @brief RSA SSA algorithm           */
    const SECUTILS_ConstBigUintType *rsaPubMod; /**< @brief RSA modulus                 */
    const SECUTILS_ConstBigUintType *rsaPubExp; /**< @brief RSA exponent                */
    const SECUTILS_ConstBigUintType *signature; /**< @brief Signature to be verified    */
    const SECUTILS_ConstBigUintType *msgDigest; /**< @brief Message digest              */
    PKA_MsgDigestAlgType msgDigestAlg;          /**< @brief Digest algorithm used       */
} PKA_InCmdRsaVerifyType;

/**
    @brief Result generated by the RSA signature verification command

    @trace #BRCM_SWREQ_PKA_KERNEL_INTERFACE
*/
typedef struct sPKA_OutCmdRsaVerifyType {
    PKA_JobIdType jobId;                /**< @brief ID of the signature verification job issued */
} PKA_OutCmdRsaVerifyType;

/**
    @brief Input parametres to issue an ECDSA signing job

    @trace #BRCM_SWREQ_PKA_KERNEL_INTERFACE
*/
typedef struct sPKA_InCmdEcdsaSignType {
    PKA_EcGroup ecGroup;                        /**< @brief Elliptic curve group                    */
    uint32_t privkeyHdl;                        /**< @brief Signing key secure heap handle          */
    const SECUTILS_ConstBigUintType *randNonce; /**< @brief Random nonce                            */
    const SECUTILS_ConstBigUintType *msgDigest; /**< @brief Message digest                          */
    SECUTILS_BigUintType *signatureR;           /**< @brief R coordinate of the computed signature  */
    SECUTILS_BigUintType *signatureS;           /**< @brief S coordinate of the computed signature  */
} PKA_InCmdEcdsaSignType;

/**
    @brief Result generated by the ECDSA sign command

    @trace #BRCM_SWREQ_PKA_KERNEL_INTERFACE
*/
typedef struct sPKA_OutCmdEcdsaSignType {
    PKA_JobIdType jobId;                        /**< @brief ID of the ECDSA signing job issued      */
} PKA_OutCmdEcdsaSignType;

/**
    @brief Input parametres to issue an ECDSA verification job

    @trace #BRCM_SWREQ_PKA_KERNEL_INTERFACE
*/
typedef struct sPKA_InCmdEcdsaVerifyType {
    PKA_EcGroup ecGroup;                            /**< @brief Elliptic curve group                    */
    const SECUTILS_ConstBigUintType *pubKeyX;       /**< @brief Public key X coordinate                 */
    const SECUTILS_ConstBigUintType *pubKeyY;       /**< @brief Public key Y coordinate                 */
    const SECUTILS_ConstBigUintType *msgDigest;     /**< @brief Message digest                          */
    const SECUTILS_ConstBigUintType *signatureR;    /**< @brief R coordinate the signature to verify    */
    const SECUTILS_ConstBigUintType *signatureS;    /**< @brief S coordinate the signature to verify    */
} PKA_InCmdEcdsaVerifyType;

/**
    @brief Result generated by the ECDSA verification command

    @trace #BRCM_SWREQ_PKA_KERNEL_INTERFACE
*/
typedef struct sPKA_OutCmdEcdsaVerifyType {
    PKA_JobIdType jobId;                            /**< @brief ID of the ECDSA verification job issued */
} PKA_OutCmdEcdsaVerifyType;

/**
    @brief Input parametres to issue an ECDHE job

    @trace #BRCM_SWREQ_PKA_KERNEL_INTERFACE
*/
typedef struct sPKA_InCmdEcdheType {
    PKA_EcGroup ecGroup;                            /**< @brief Elliptic curve group                            */
    uint32_t privKeyHdl;                            /**< @brief Secure heap handle to a random number           */
    const SECUTILS_ConstBigUintType *remotePubKeyX; /**< @brief Remote public key X coordinate                  */
    const SECUTILS_ConstBigUintType *remotePubKeyY; /**< @brief Remote public key Y coordinate                  */
    SECUTILS_BigUintType *pubKeyX;                  /**< @brief X coordinate of the computed pubkey             */
    SECUTILS_BigUintType *pubKeyY;                  /**< @brief Y coordinate of the computed pubkey             */
    uint32_t sharedSecretHdl;                       /**< @brief Secure heap handle holding the shared secret    */
} PKA_InCmdEcdheType;

/**
    @brief Result generated by an ECDHE command

    @trace #BRCM_SWREQ_PKA_KERNEL_INTERFACE
*/
typedef struct sPKA_OutCmdEcdheType {
    PKA_JobIdType jobId;                            /**< @brief ID of the ECDSA verification job issued         */
} PKA_OutCmdEcdheType;

/**
    @brief Input parametres to execute a requested command

    @trace #BRCM_SWREQ_PKA_KERNEL_INTERFACE
*/
typedef union uPKA_InIOParamsType {
    PKA_InCmdGetJobStatusType cmdGetJobStatus;      /**< @brief Query job status command                            */
    PKA_InCmdRsaVerifyType cmdRsaVerify;            /**< @brief RSA signature verification command                  */
    PKA_InCmdEcdsaSignType cmdEcdsaSign;            /**< @brief ECDSA sign command                                  */
    PKA_InCmdEcdsaVerifyType cmdEcdsaVerify;        /**< @brief ECDSA verification command                          */
    PKA_InCmdEcdheType cmdEcdhe;                    /**< @brief ECDHE key exchange command                          */
} PKA_InIOParamsType;

/**
    @brief Results generated by executing the requested command

    @trace #BRCM_SWREQ_PKA_KERNEL_INTERFACE
*/
typedef union uPKA_OutIOParamsType {
    PKA_OutCmdGetJobStatusType cmdGetJobStatus;     /**< @brief Result of executing a query job status command              */
    PKA_OutCmdRsaVerifyType cmdRsaVerify;           /**< @brief Result of executing an RSA signature verification command   */
    PKA_OutCmdEcdsaSignType cmdEcdsaSign;           /**< @brief Result of executing an ECDSA signing command                */
    PKA_OutCmdEcdsaVerifyType cmdEcdsaVerify;       /**< @brief Result of executing an ECDSA verification command           */
    PKA_OutCmdEcdheType cmdEcdhe;                   /**< @brief ECDHE key exchange command                                  */
} PKA_OutIOParamsType;

/**
    @brief PKA driver IO structure

    Data structure for the PKA driver SVC interface

    @trace #BRCM_SWREQ_PKA_KERNEL_INTERFACE
*/
typedef struct sPKA_IOType {
    int32_t retVal;                     /**< @brief SVC response                            */
    uint64_t taskId;                    /**< @brief Id of the task making the SVC call      */
    PKA_InIOParamsType inParams;        /**< @brief Data consumed by the command handler    */
    PKA_OutIOParamsType outParams;      /**< @brief Data output by the command handler      */
} PKA_IOType;

/**
    @brief PKA_IOType typecast helper

    @trace #BRCM_SWREQ_PKA_KERNEL_INTERFACE
*/
typedef union uPKA_SVCIOType {
    uint8_t *data;
    PKA_IOType *io;
} PKA_SVCIOType;

/** @brief PKA driver system command request

    Interface to issue the PKA SVC commands

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aCmd        Allocation/free command
    @param[inout]   aIO         Pointer to Timer IO

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             PKA command operation success
    @retval     #BCM_ERR_INVAL_MAGIC    Invalid magic number
    @retval     Others                  Error values specific to the command
                                        raised
    @retval     #BCM_ERR_INVAL_PARAMS   aIO is NULL

    @post None

    @note This interface shall be implemented by the integrator.

    @trace  #BRCM_SWREQ_PKA_KERNEL_INTERFACE

    @limitations None
*/
extern int32_t PKA_SysCmdReq(PKA_CmdType aCmd, PKA_IOType *const aIO);

/** @brief PKA driver system command handler

    This interface handles all the PKA driver commands requested from
    #SysCmdReq.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aMagicID    PKA Magic ID
    @param[in]      aCmd        System command request
    @param[inout]   aSysIO      Pointer to system request IO

    @return void

    @post None

    @note This interface shall be implemented by the integrator and shall hook
    it to SVC layer.

    @trace  #BRCM_SWREQ_PKA_KERNEL_HANDLER
*/
extern void PKA_SysCmdHandler(uint32_t aMagicID, uint32_t aCmd, uint8_t *aSysIO);

/** @brief Invoke the PKA job scheduler

    This function is meant to be invoked from an ISR where PKA
    signals that it has finished executing the previously submitted
    work. The scheduler can then advance the driver state machine.

    @behavior Sync, Non-reentrant

    @pre None

    @return void

    @post None

    @trace  #BRCM_SWREQ_PKA_LIBRARY
*/
extern void PKA_RunJobScheduler(void);

/** @brief Notify PKA job execution start

    This function is invoked by the scheduler just before
    the corresponding PKA job is scheduled to run.

    @behavior Sync, Non-reentrant

    @param[in]      aJobId              ID of the job being scheduled to run
    @param[in]      aTaskId             ID of the task that submitted this job

    @return void

    @post None

    @note This interface shall be implemented by the integrator

    @trace #BRCM_SWREQ_PKA_LIBRARY
 */
extern void PKA_OsilNotifyJobStart(const PKA_JobIdType aJobId, const uint64_t aTaskId);

/** @brief Notify PKA job completion

    This function is invoked by the scheduler when a PKA
    job finishes executing. The OS integration layer then may choose to
    send any signals to the corresponding tasks.

    @behavior Sync, Non-reentrant

    @param[in]      aJobId              ID of the job whose execution has finished
    @param[in]      aTaskId             ID of the task that submitted this job

    @return void

    @post None

    @note This interface shall be implemented by the integrator

    @trace #BRCM_SWREQ_PKA_LIBRARY
 */
extern void PKA_OsilNotifyJobComplete(const PKA_JobIdType aJobId, const uint64_t aTaskId);

/** @brief PKA Interrupt Handler

    PKA Interrupt Handler.

    @behavior Sync, Re-entrant

    @pre TBD

    @param[in]      None

    @retval         None

    @post TBD

    @trace #BRCM_SWREQ_PKA_KERNEL_HANDLER

    @limitations None
*/
extern void PKA_IRQHandler(void);
#endif /* PKA_OSIL_H */

/** @} */
