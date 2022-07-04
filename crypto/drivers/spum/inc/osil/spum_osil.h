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

/** @defgroup grp_spum_il Integration Guide
    @ingroup grp_spum

    @addtogroup grp_spum_il
    @{

    @file spum_osil.h
    @brief SPUM driver Integration Interfaces
    This header file contains the integration interface for the SPUM driver
    @version 0.10 Initial version
*/

#ifndef SPUM_OSIL_H
#define SPUM_OSIL_H

#include <stdint.h>
#include <svc.h>
#include <spum_lib.h>

/**
    @name SPUM driver interface IDs
    @{
    @brief Interface IDs for the SPUM driver
*/
#define BRCM_SWARCH_SPUM_CMD_TYPE                           (0x9101U)    /**< @brief #SPUM_CmdType                    */
#define BRCM_SWARCH_SPUM_INCMD_CREATE_CONTEXT_TYPE          (0x9102U)    /**< @brief #SPUM_InCmdCreateContextType     */
#define BRCM_SWARCH_SPUM_OUTCMD_CREATE_CONTEXT_TYPE         (0x9103U)    /**< @brief #SPUM_OutCmdCreateContextType    */
#define BRCM_SWARCH_SPUM_INCMD_DESTROY_CONTEXT_TYPE         (0x9104U)    /**< @brief #SPUM_InCmdDestroyContextType    */
#define BRCM_SWARCH_SPUM_INCMD_UPDATE_TYPE                  (0x9105U)    /**< @brief #SPUM_InCmdUpdateType            */
#define BRCM_SWARCH_SPUM_OUTCMD_UPDATE_TYPE                 (0x9106U)    /**< @brief #SPUM_OutCmdUpdateType           */
#define BRCM_SWARCH_SPUM_INCMD_FINISH_TYPE                  (0x9107U)    /**< @brief #SPUM_InCmdFinishType            */
#define BRCM_SWARCH_SPUM_OUTCMD_FINISH_TYPE                 (0x9108U)    /**< @brief #SPUM_OutCmdFinishType           */
#define BRCM_SWARCH_SPUM_INCMD_GET_JOB_EXEC_RESULT_TYPE     (0x9109U)    /**< @brief #SPUM_InCmdGetJobExecResultType  */
#define BRCM_SWARCH_SPUM_OUTCMD_GET_JOB_EXEC_RESULT_TYPE    (0x910AU)    /**< @brief #SPUM_OutCmdGetJobExecResultType */
#define BRCM_SWARCH_SPUM_IN_IOPARAMS_TYPE                   (0x910BU)    /**< @brief #SPUM_InIOParamsType             */
#define BRCM_SWARCH_SPUM_OUT_IOPARAMS_TYPE                  (0x910CU)    /**< @brief #SPUM_OutIOParamsType            */
#define BRCM_SWARCH_SPUM_IO_TYPE                            (0x910DU)    /**< @brief #SPUM_IOType                     */
#define BRCM_SWARCH_SPUM_SVCIO_TYPE                         (0x910EU)    /**< @brief #SPUM_SVCIOType                  */
#define BRCM_SWARCH_SPUM_SYSCMD_REQ_PROC                    (0x910FU)    /**< @brief #SPUM_SysCmdReq                  */
#define BRCM_SWARCH_SPUM_SYSCMD_HANDLER_PROC                (0x9110U)    /**< @brief #SPUM_SysCmdHandler              */
#define BRCM_SWARCH_SPUM_RUN_JOB_SCHEDULER_PROC             (0x9111U)    /**< @brief #SPUM_RunJobScheduler            */
#define BRCM_SWARCH_SPUM_OSIL_NOTIFY_JOB_START_PROC         (0x9112U)    /**< @brief #SPUM_OsilNotifyJobStart         */
#define BRCM_SWARCH_SPUM_OSIL_NOTIFY_JOB_COMPLETE_PROC      (0x9113U)    /**< @brief #SPUM_OsilNotifyJobComplete      */
#define BRCM_SWARCH_SPUM_DMACTCIRQHANDLER_PROC              (0x9114U)    /**< @brief #SPUM_DMACTcIRQHandler           */
#define BRCM_SWARCH_SPUM_DMACERRIRQHANDLER_PROC             (0x9115U)    /**< @brief #SPUM_DMACErrIRQHandler          */
/** @} */

/**
    @name SPUM_CmdType
    @{
    @brief SPUM driver command type

    @trace #BRCM_SWREQ_SPUM_KERNEL_INTERFACE
*/
typedef uint32_t SPUM_CmdType;                      /**< @brief SPUM command type                                                                   */
#define SPUM_CMD_INIT                   (0x00UL)    /**< @brief SPUM command to initialize the driver                                               */
#define SPUM_CMD_DEINIT                 (0x01UL)    /**< @brief SPUM command to deinit the driver                                                   */
#define SPUM_CMD_CREATE_CONTEXT         (0x02UL)    /**< @brief SPUM command to create a new symmetric crypto context                               */
#define SPUM_CMD_DESTROY_CONTEXT        (0x03UL)    /**< @brief SPUM command to destroy a context                                                   */
#define SPUM_CMD_UPDATE                 (0x04UL)    /**< @brief SPUM command to update the context state with new data                              */
#define SPUM_CMD_FINISH                 (0x05UL)    /**< @brief SPUM command to signal that no furthur changes to the context state shall be made   */
#define SPUM_CMD_GET_JOB_EXEC_RESULT    (0x06UL)    /**< @brief SPUM command to query the job status                                                */
/** @} */

/**
    @brief Input parametres to process the SPUM context create command

    @trace #BRCM_SWREQ_SPUM_KERNEL_INTERFACE
*/
typedef struct sSPUM_InCmdCreateContextType {
    const SPUM_CryptOpsType *cryptOps;              /**< @brief Context crypt ops                               */
    const SPUM_AuthOpsType *authOps;                /**< @brief Context auth ops                                */
    SPUM_CryptAuthOrderType cryptAuthOrder;         /**< @brief Context crypt and auth order                    */
    uint32_t authOutMemSize;                        /**< @brief Auth digest size                                */
    uint8_t *authOut;                               /**< @brief Memory to write the result of auth operation    */
} SPUM_InCmdCreateContextType;

/**
    @brief Results generated by executing the create context command

    @trace #BRCM_SWREQ_SPUM_KERNEL_INTERFACE
*/
typedef struct sSPUM_OutCmdCreateContextType {
    SPUM_ContextHandleType ctxHdl;                  /**< @brief Handle to the created context                   */
} SPUM_OutCmdCreateContextType;

/**
    @brief Input parametres to process the SPUM destroy context command

    @trace #BRCM_SWREQ_SPUM_KERNEL_INTERFACE
*/
typedef struct sSPUM_InCmdDestroyContextType {
    SPUM_ContextHandleType ctxHdl;                  /**< @brief Handle to the context to be destroyed           */
} SPUM_InCmdDestroyContextType;

/**
    @brief Input parametres to process the SPUM update command

    @trace #BRCM_SWREQ_SPUM_KERNEL_INTERFACE
*/
typedef struct sSPUM_InCmdUpdateType {
    SPUM_ContextHandleType ctxHdl;                  /**< @brief Context handle                                  */
    uint32_t dataInSize;                            /**< @brief Input data size in bytes                        */
    const uint8_t *dataInPtr;                       /**< @brief Input data                                      */
    uint8_t *cryptOut;                              /**< @brief Memory to write the crypt operation's output    */
} SPUM_InCmdUpdateType;

/**
    @brief Results generated by executing the update command

    @trace #BRCM_SWREQ_SPUM_KERNEL_INTERFACE
*/
typedef struct sSPUM_OutCmdUpdateType {
    SPUM_JobIdType jobId;                           /**<  @brief Handle to the submitted job                    */
} SPUM_OutCmdUpdateType;

/**
    @brief Input parametres to process the SPUM finish command

    @trace #BRCM_SWREQ_SPUM_KERNEL_INTERFACE
*/
typedef struct sSPUM_InCmdFinishType {
    SPUM_ContextHandleType ctxHdl;                  /**< @brief Context handle                                  */
    uint32_t dataInSize;                            /**< @brief Input data size in bytes                        */
    const uint8_t *dataInPtr;                       /**< @brief Input data                                      */
    uint8_t *cryptOut;                              /**< @brief Memory to write the crypt operation's output    */
} SPUM_InCmdFinishType;

/**
    @brief Results generated by executing the finish command

    @trace #BRCM_SWREQ_SPUM_KERNEL_INTERFACE
*/
typedef struct sSPUM_OutCmdFinishType {
    SPUM_JobIdType jobId;                           /**<  @brief Handle to the submitted job                    */
} SPUM_OutCmdFinishType;

/**
    @brief Input parametres to process the SPUM get job exec result command

    @trace #BRCM_SWREQ_SPUM_KERNEL_INTERFACE
*/
typedef struct sSPUM_InCmdGetJobExecResultType {
    SPUM_JobIdType jobId;                           /**<  @brief Handle a the submitted job                    */
} SPUM_InCmdGetJobExecResultType;

/**
    @brief Results generated by executing the get job exec result command

    @trace #BRCM_SWREQ_SPUM_KERNEL_INTERFACE
*/
typedef struct sSPUM_OutCmdGetJobExecResultType {
    int32_t jobExecResult;                          /**< @brief Result of executing the submitted job           */
} SPUM_OutCmdGetJobExecResultType;

/**
    @brief Input parametres to execute a requested command

    @trace #BRCM_SWREQ_SPUM_KERNEL_INTERFACE
*/
typedef union uSPUM_InIOParamsType {
    SPUM_InCmdCreateContextType cmdCreateContext;
    SPUM_InCmdDestroyContextType cmdDestroyContext;
    SPUM_InCmdUpdateType cmdUpdate;
    SPUM_InCmdFinishType cmdFinish;
    SPUM_InCmdGetJobExecResultType cmdGetJobExecResult;
} SPUM_InIOParamsType;

/**
    @brief Results generated by executing the requested command

    @trace #BRCM_SWREQ_SPUM_KERNEL_INTERFACE
*/
typedef union uSPUM_OutIOParamsType {
    SPUM_OutCmdCreateContextType cmdCreateContext;
    SPUM_OutCmdUpdateType cmdUpdate;
    SPUM_OutCmdFinishType cmdFinish;
    SPUM_OutCmdGetJobExecResultType cmdGetJobExecResult;
} SPUM_OutIOParamsType;

/**
    @brief SPUM driver IO structure

    Data structure for the SPUM driver SVC interface

    @trace #BRCM_SWREQ_SPUM_KERNEL_INTERFACE
*/
typedef struct sSPUM_IOType {
    int32_t retVal;                     /**< @brief SVC response                            */
    uint64_t taskId;                    /**< @brief Id of the task making the SVC call      */
    SPUM_InIOParamsType inParams;       /**< @brief Data consumed by the command handler    */
    SPUM_OutIOParamsType outParams;     /**< @brief Data output by the command handler      */
} SPUM_IOType;

/**
    @brief SPUM_IOType typecast helper

    @trace #BRCM_SWREQ_SPUM_KERNEL_INTERFACE
*/
typedef union uSPUM_SVCIOType {
    uint8_t *data;
    SPUM_IOType *io;
} SPUM_SVCIOType;

/** @brief SPUM driver system command request

    Interface to issue the SPUM SVC commands

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aCmd        Allocation/free command
    @param[inout]   aIO         Pointer to SPUM IO

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             SPUM command operation success
    @retval     #BCM_ERR_INVAL_MAGIC    Invalid magic number
    @retval     Others                  Error values specific to the command
                                        raised
    @retval     #BCM_ERR_INVAL_PARAMS   aIO is NULL

    @post None

    @note This interface shall be implemented by the integrator.

    @trace  #BRCM_SWREQ_SPUM_KERNEL_INTERFACE

    @limitations None
*/
extern int32_t SPUM_SysCmdReq(SPUM_CmdType aCmd, SPUM_IOType *const aIO);

/** @brief SPUM driver system command handler

    This interface handles all the SPUM driver commands requested from
    #SysCmdReq.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aMagicID    Magic ID for SPUM
    @param[in]      aCmd        System command request
    @param[inout]   aSysIO      Pointer to system request IO

    @return void

    @post None

    @note This interface shall be implemented by the integrator and shall hook
    it to SVC layer.

    @trace  #BRCM_SWREQ_SPUM_KERNEL_HANDLER
*/
extern void SPUM_SysCmdHandler(uint32_t aMagicID, uint32_t aCmd, uint8_t *aSysIO);

/** @brief Invoke the SPUM job scheduler

    This function is meant to be invoked from an ISR where SPUM
    signals that it has finished executing a job. The scheduler can
    then advance the driver state machine.

    @behavior Sync, Non-reentrant

    @pre None

    @return void

    @post None

    @trace  #BRCM_SWREQ_SPUM_LIBRARY
*/
extern void SPUM_RunJobScheduler(void);

/** @brief Notify SPUM job execution start

    This function is invoked by the scheduler just before
    the corresponding SPUM job is scheduled to run.

    @behavior Sync, Non-reentrant

    @param[in]      aJobId              ID of the job being scheduled to run
    @param[in]      aTaskId             ID of the task that submitted this job

    @return void

    @post None

    @note This interface shall be implemented by the integrator

    @trace #BRCM_SWREQ_SPUM_LIBRARY
 */
extern void SPUM_OsilNotifyJobStart(const SPUM_JobIdType aJobId, const uint64_t aTaskId);

/** @brief Notify SPUM job completion

    This function is invoked by the scheduler when a SPUM
    job finishes executing. The OS integration layer then may choose to
    send any signals to the corresponding tasks.

    @behavior Sync, Non-reentrant

    @param[in]      aJobId              ID of the job whose execution has finished
    @param[in]      aTaskId             ID of the task that submitted this job

    @return void

    @post None

    @note This interface shall be implemented by the integrator

    @trace #BRCM_SWREQ_SPUM_LIBRARY
 */
extern void SPUM_OsilNotifyJobComplete(const SPUM_JobIdType aJobId, const uint64_t aTaskId);

/** @brief DMA TC Interrupt Handler

    DMA TC Interrupt Handler.

    @behavior Sync, Re-entrant

    @pre TBD

    @param[in]      None

    @retval         None

    @post TBD

    @trace #BRCM_SWREQ_SPUM_KERNEL_HANDLER

    @limitations None
*/
extern void SPUM_DMACTcIRQHandler(void);

/** @brief DMA error Interrupt Handler

    DMA error Interrupt Handler.

    @behavior Sync, Re-entrant

    @pre TBD

    @param[in]      None

    @retval         None

    @post TBD

    @trace #BRCM_SWREQ_SPUM_KERNEL_HANDLER

    @limitations None
*/
extern void SPUM_DMACErrIRQHandler(void);
#endif /* SPUM_OSIL_H */

/** @} */
