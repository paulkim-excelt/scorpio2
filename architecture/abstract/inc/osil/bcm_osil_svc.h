/*****************************************************************************
 Copyright 2019 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_bcm_osil_svc OS Function Integration
    @ingroup grp_abstract

    @addtogroup grp_bcm_osil_svc
    @{
    This file specifies Command hander interface for OS integration

    file osil/bcm_osil_svc.h

    @version 1.0 Initial Version
*/

#ifndef BCM_OSIL_SVC_H
#define BCM_OSIL_SVC_H

#include <bcm_osil.h>

/**
    @name Component API IDs
    @{
    @brief API IDs for Component
*/
#define BRCM_SWARCH_BCM_OS_SYSCMDHDLR_PROC    (0x9201U)    /**< @brief #BCM_OsSysCmdHandler */
#define BRCM_SWARCH_BCM_OS_CMD_TYPE           (0x9202U)    /**< @brief #BCM_OsCmdType       */
#define BRCM_SWARCH_BCM_OS_IO_TYPE            (0x9203U)    /**< @brief #BCM_OsIOType        */
#define BRCM_SWARCH_BCM_OS_SYSCMDREQ_PROC     (0x9204U)    /**< @brief #BCM_OsSysCmdReq     */
/** @} */

/**
    @name BCM_OsCmdType
    @{
    @brief BCM_OS SVC Command

    @trace #BRCM_SWREQ_BCM_OS_WRAPPER
*/
typedef uint32_t BCM_OsCmdType;                      /**< @brief BCM_OS SVC Command */
#define BCM_OS_CMD_ACTIVATETASK        (0x1UL)      /**< @brief BCM_ActivateTask */
#define BCM_OS_CMD_TERMINATETASK       (0x2UL)      /**< @brief BCM_TerminateTask */
#define BCM_OS_CMD_THREADNOTTERMINATED (0x3UL)      /**< @brief BCM_ThreadNotTerminated */
#define BCM_OS_CMD_STARTOS             (0x4UL)      /**< @brief BCM_StartOS */
#define BCM_OS_CMD_GETEVENT            (0x5UL)      /**< @brief BCM_GetEvent */
#define BCM_OS_CMD_SETEVENT            (0x6UL)      /**< @brief BCM_SetEvent */
#define BCM_OS_CMD_CLEAREVENT          (0x7UL)      /**< @brief BCM_ClearEvent */
#define BCM_OS_CMD_WAITEVENT           (0x8UL)      /**< @brief BCM_WaitEvent */
#define BCM_OS_CMD_SETRELALARM         (0x9UL)      /**< @brief BCM_SetRelAlarm */
#define BCM_OS_CMD_CANCELALARM         (0xAUL)      /**< @brief BCM_CancelAlarm */
#define BCM_OS_CMD_EXEC_HANDOVER       (0xBUL)      /**< @brief BCM_ExecHandover */
/** @} */


/**
    @brief  Structure to define input and output parameters

    @trace #BRCM_SWREQ_BCM_OS_WRAPPER
*/
typedef struct sBCM_OsIOType {
    int32_t status;                            /**< @brief status of system call */
    BCM_TaskType taskId;
    BCM_AppModeType appMode;
    BCM_EventMaskType eventMask;
    BCM_AlarmType alarmID;
    BCM_TickType alarmInc;
    BCM_TickType alarmCycle;
    BCM_EntryPtType entryPt;
} BCM_OsIOType;

/** @brief Raise System Command Request

    Interface to raise System Command Request.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aCmd        Command requested by user
    @param[inout]   aIO         In-Out structure containing request parameters

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Command request was raised successfully
    @retval     #BCM_ERR_INVAL_MAGIC    Invalid SVC magic
    @retval     #BCM_ERR_UNKNOWN        aIO is NULL

    @post None

    @note This interface shall be implemented by the integrator.

    @trace  #BRCM_SWREQ_BCM_OS_WRAPPER

    @limitations None
*/
int32_t BCM_OsSysCmdReq(const uint32_t aCmd, BCM_OsIOType *aIO);

/** @brief BCM OS system command request handler

    This API will handle the system command request and call internal handler
    after validating the MAGIC ID

    @behavior Sync, Non-reentrant

    @pre none

    @param[in]       aMagicID        Magic ID of BCM_OS
    @param[in]       acmd            command to be executed in system context
    @param[inout]    aSysIO          System IO structure to exchange information

    Return values are documented in reverse-chronological order
    @return          none

    @post none

    @trace  #BRCM_SWREQ_BCM_OS_KERNEL_HANDLER

    @limitations none
*/
extern void BCM_OsSysCmdHandler(uint32_t aMagicID, uint32_t aCmd, uint8_t * aSysIO);

#endif	/* BCM_OSIL_SVC_H */

/** @} */
