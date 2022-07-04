/*****************************************************************************
 Copyright 2020-2021 Broadcom Limited.  All rights reserved.

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

/** @defgroup grp_rand_il Integration Guide
    @ingroup grp_rand

    @addtogroup grp_rand_il
    @{

    @file rand_osil.h
    @brief rand library Integration Interfaces
    This header file contains the integration interface for the rand library
    @version 0.10 Initial version
*/

#include <stdint.h>
#include <svc.h>

#include <rand_lib.h>

#ifndef RAND_OSIL_H
#define RAND_OSIL_H

/**
    @name Rand library interface IDs
    @{
    @brief Interface IDs for the rand library
*/
#define BRCM_SWARCH_RAND_CMD_TYPE                           (0x9101U)    /**< @brief #RAND_CmdType                    */
#define BRCM_SWARCH_RAND_INCMD_GET_RAND_UINT_TYPE           (0x9102U)    /**< @brief #RAND_InCmdGetRandUIntType       */
#define BRCM_SWARCH_RAND_OUTCMD_GET_RAND_UINT_TYPE          (0x9103U)    /**< @brief #RAND_OutCmdGetRandUIntType      */
#define BRCM_SWARCH_RAND_INCMD_GET_JOB_EXEC_RESULT_TYPE     (0x9104U)    /**< @brief #RAND_InCmdGetJobExecResultType  */
#define BRCM_SWARCH_RAND_OUTCMD_GET_JOB_EXEC_RESULT_TYPE    (0x9105U)    /**< @brief #RAND_OutCmdGetJobExecResultType */
#define BRCM_SWARCH_RAND_IN_IOPARAMS_TYPE                   (0x9106U)    /**< @brief #RAND_InIOParamsType             */
#define BRCM_SWARCH_RAND_OUT_IOPARAMS_TYPE                  (0x9107U)    /**< @brief #RAND_OutIOParamsType            */
#define BRCM_SWARCH_RAND_IO_TYPE                            (0x9108U)    /**< @brief #RAND_IOType                     */
#define BRCM_SWARCH_RAND_SVC_IO_TYPE                        (0x9109U)    /**< @brief #RAND_SVCIOType                  */
#define BRCM_SWARCH_RAND_SYS_CMD_REQ_PROC                   (0x910AU)    /**< @brief #RAND_SysCmdReq                  */
#define BRCM_SWARCH_RAND_SYS_CMD_HANDLER_PROC               (0x910BU)    /**< @brief #RAND_SysCmdHandler              */
#define BRCM_SWARCH_RAND_RUN_JOB_SCHEDULER_PROC             (0x910CU)    /**< @brief #RAND_RunJobScheduler            */
#define BRCM_SWARCH_RAND_OSIL_NOTIFY_JOB_START_PROC         (0x910DU)    /**< @brief #RAND_OsilNotifyJobStart         */
#define BRCM_SWARCH_RAND_OSIL_NOTIFY_JOB_COMPLETE_PROC      (0x910EU)    /**< @brief #RAND_OsilNotifyJobComplete      */
#define BRCM_SWARCH_RAND_IRQHANDLER_PROC                    (0x910FU)    /**< @brief #RAND_IRQHandler                 */

/** @} */

/**
    @name RAND_CmdType
    @{
    @brief rand library command type

    @trace #BRCM_SWREQ_RAND_KERNEL_INTERFACE
*/
typedef uint32_t RAND_CmdType;                    /**< @brief RAND command type                             */
#define RAND_CMD_INIT                 (0x00UL)    /**< @brief RAND command to initialize the library        */
#define RAND_CMD_DEINIT               (0x01UL)    /**< @brief RAND command to de-initialize the library     */
#define RAND_CMD_GET_RAND_UINT        (0x02UL)    /**< @brief RAND command to generate a random number      */
#define RAND_CMD_GET_JOB_EXEC_RESULT  (0x03UL)    /**< @brief RAND command to query the job status          */
/** @} */

/**
    @brief Input parametres to process the get rand uint command

    @trace #BRCM_SWREQ_RAND_KERNEL_INTERFACE
*/
typedef struct sRAND_InCmdGetRandUIntType {
    const RAND_InputType *lo;       /**< @brief The smallest possible random integer                */
    const RAND_InputType *hi;       /**< @brief The highest possible random integer                 */
    RAND_OutputType *randNumber;    /**< @brief BigUint to place the generated random number into   */
} RAND_InCmdGetRandUIntType;

/**
    @brief Results generated by executing the get rand uint command

    @trace #BRCM_SWREQ_RAND_KERNEL_INTERFACE
*/
typedef struct sRAND_OutCmdGetRandUIntType {
    RAND_JobIdType jobId;     /**< @brief Handle to the submitted job             */
} RAND_OutCmdGetRandUIntType;

/**
    @brief Input parametres to process the get job exec result command

    @trace #BRCM_SWREQ_RAND_KERNEL_INTERFACE
*/
typedef struct sRAND_InCmdGetJobExecResultType {
    RAND_JobIdType jobId;                         /**<  @brief Handle a the submitted job                    */
} RAND_InCmdGetJobExecResultType;

/**
    @brief Results generated by executing the get job exec result command

    @trace #BRCM_SWREQ_RAND_KERNEL_INTERFACE
*/
typedef struct sRAND_OutCmdGetJobExecResultType {
    int32_t jobExecResult;                          /**< @brief Result of executing the submitted job           */
} RAND_OutCmdGetJobExecResultType;

/**
    @brief Input parametres to execute a requested command

    @trace #BRCM_SWREQ_RAND_KERNEL_INTERFACE
*/
typedef union uRAND_InIOParamsType {
    RAND_InCmdGetRandUIntType cmdRandUInt;
    RAND_InCmdGetJobExecResultType cmdGetJobExecResult;
} RAND_InIOParamsType;

/**
    @brief Results generated by executing the requested command

    @trace #BRCM_SWREQ_RAND_KERNEL_INTERFACE
*/
typedef union uRAND_OutIOParamsType {
    RAND_OutCmdGetRandUIntType cmdRandUInt;
    RAND_OutCmdGetJobExecResultType cmdGetJobExecResult;
} RAND_OutIOParamsType;

/**
    @brief Rand library IO structure

    Data structure for the RAND library SVC interface

    @trace #BRCM_SWREQ_RAND_KERNEL_INTERFACE
*/
typedef struct sRAND_IOType {
    int32_t retVal;                     /**< @brief SVC response                            */
    uint64_t taskId;                    /**< @brief Id of the task making the SVC call      */
    RAND_InIOParamsType inParams;       /**< @brief Data consumed by the command handler    */
    RAND_OutIOParamsType outParams;     /**< @brief Data output by the command handler      */
} RAND_IOType;

/**
    @brief RAND_IOType typecast helper

    @trace #BRCM_SWREQ_RAND_KERNEL_INTERFACE
*/
typedef union uRAND_SVCIOType {
    uint8_t *data;
    RAND_IOType *io;
} RAND_SVCIOType;

/** @brief Rand library system command request

    Interface to issue the RAND SVC commands

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aCmd        Allocation/free command
    @param[inout]   aIO         Pointer to Timer IO

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Timer command operation success
    @retval     #BCM_ERR_INVAL_MAGIC    Invalid magic number
    @retval     Others                  Error values specific to the command
                                        raised
    @retval     #BCM_ERR_INVAL_PARAMS   aIO is NULL

    @post None

    @note This interface shall be implemented by the integrator.

    @trace  #BRCM_SWREQ_RAND_KERNEL_INTERFACE

    @limitations None
*/
extern int32_t RAND_SysCmdReq(RAND_CmdType aCmd, RAND_IOType *const aIO);

/** @brief Rand library system command handler

    This interface handles all the RAND library commands requested from
    #SysCmdReq.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aMagicID    Magic ID for Timer
    @param[in]      aCmd        System command request
    @param[inout]   aSysIO      Pointer to system request IO

    @return void

    @post None

    @note This interface shall be implemented by the integrator and shall hook
    it to SVC layer.

    @trace  #BRCM_SWREQ_RAND_KERNEL_HANDLER
*/
extern void RAND_SysCmdHandler(uint32_t aMagicID, uint32_t aCmd, uint8_t *aSysIO);

/** @brief Invoke the job scheduler

    This function is meant to be invoked from an ISR where RBG200
    signals that it has procuced the programmed number of random bits.
    The scheduler can then advance the library state machine.

    @behavior Sync, Non-reentrant

    @pre None

    @return void

    @post None

    @trace  #BRCM_SWREQ_RAND_LIBRARY
*/
extern void RAND_RunJobScheduler(void);

/** @brief Notify RAND job execution start

    This function is invoked by the scheduler just before
    the corresponding RAND job is scheduled to run.

    @behavior Sync, Non-reentrant

    @param[in]      aJobId              ID of the job being scheduled to run
    @param[in]      aTaskId             ID of the task that submitted this job

    @return void

    @post None

    @note This interface shall be implemented by the integrator

    @trace #BRCM_SWREQ_RAND_LIBRARY
 */
extern void RAND_OsilNotifyJobStart(const RAND_JobIdType aJobId, const uint64_t aTaskId);

/** @brief Notify RAND job completion

    This function is invoked by the scheduler when a RAND
    job finishes executing. The OS integration layer then may choose to
    send any signals to the corresponding tasks.

    @behavior Sync, Non-reentrant

    @param[in]      aJobId              ID of the job whose execution has finished
    @param[in]      aTaskId             ID of the task that submitted this job

    @return void

    @post None

    @note This interface shall be implemented by the integrator

    @trace #BRCM_SWREQ_RAND_LIBRARY
 */
extern void RAND_OsilNotifyJobComplete(const RAND_JobIdType aJobId, const uint64_t aTaskId);

/** @brief RAND Interrupt Handler

    RAND Interrupt Handler.

    @behavior Sync, Re-entrant

    @pre TBD

    @param[in]      None

    @retval         None

    @post TBD

    @trace #BRCM_SWREQ_RAND_KERNEL_HANDLER

    @limitations None
*/
extern void RAND_IRQHandler(void);

#endif /* RAND_OSIL_H */
/** @} */

