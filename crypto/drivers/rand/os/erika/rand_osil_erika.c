/*****************************************************************************
 Copyright 2020-2022 Broadcom Limited.  All rights reserved.

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
    @addtogroup grp_rand_il
    @{

    @file rand_osil_erika.c
    @brief rand driver integration
    This source file contains the integration of rand driver to system
    @version 0.10 Initial version
*/

#include <ee.h>
#include <bcm_err.h>
#include <osil/bcm_osil.h>

#include "osil/rand_osil.h"

/**
    @name RAND osil design IDs
    @{
    @brief Osil Design IDs for the RAND driver
*/
#define BRCM_SWDSGN_RAND_SYSCMDREQ_PROC                   (0xE101U)    /**< @brief #RAND_SysCmdReq             */
#define BRCM_SWDSGN_RAND_OSIL_NOTIFY_JOB_START_PROC       (0xE102U)    /**< @brief #RAND_OsilNotifyJobStart    */
#define BRCM_SWDSGN_RAND_OSIL_NOTIFY_JOB_COMPLETE_PROC    (0xE103U)    /**< @brief #RAND_OsilNotifyJobComplete */
#define BRCM_SWDSGN_RAND_IRQ_HANDLER_PROC                 (0xE104U)    /**< @brief #RAND_IRQHandler            */
/** @} */

/**
    @trace #BRCM_SWARCH_RAND_SYS_CMD_REQ_PROC
    @trace #BRCM_SWREQ_RAND_KERNEL_INTERFACE
*/
int32_t RAND_SysCmdReq(RAND_CmdType aCmd, RAND_IOType *const aIO)
{
    SVC_RequestType sysReqIO;
    int32_t ret = BCM_ERR_INVAL_PARAMS;

    _Static_assert(sizeof(TaskRefType) == sizeof(size_t),
        "The implementation of this routine is incorrect if this condition fails!");
    _Static_assert(sizeof(TaskType) <= sizeof(uint64_t),
        "The implementation of this routine is incorrect if this condition fails!");

    if (NULL != aIO) {
        sysReqIO.sysReqID = SVC_RND_ID;
        sysReqIO.magicID = SVC_MAGIC_RND_ID;
        sysReqIO.cmd = aCmd;
        sysReqIO.svcIO = (uint8_t *)aIO;
        sysReqIO.response = BCM_ERR_UNKNOWN;

        aIO->taskId = 0ULL;
        (void) GetTaskID((TaskRefType)&aIO->taskId);

        ret = SVC_Request(&sysReqIO);

        if (BCM_ERR_OK == ret) {
            if (BCM_ERR_OK == sysReqIO.response) {
                ret = aIO->retVal;
            } else {
                ret = sysReqIO.response;
            }
        }
    }

    return ret;
}

/**
    @trace #BRCM_SWARCH_RAND_OSIL_NOTIFY_JOB_START_PROC
    @trace #BRCM_SWREQ_RAND_LIBRARY
*/
void RAND_OsilNotifyJobStart(const RAND_JobIdType aJobId, const uint64_t aTaskId)
{
    (void) aJobId;
    (void) aTaskId;
    return;
}

/**
    @code{.unparsed}
    (void) aJobId
    (void)SetEvent((TaskType)aTaskId, RandEvent)
    @endcode

    @trace #BRCM_SWARCH_RAND_OSIL_NOTIFY_JOB_COMPLETE_PROC
    @trace #BRCM_SWREQ_RAND_LIBRARY
*/
void RAND_OsilNotifyJobComplete(const RAND_JobIdType aJobId, const uint64_t aTaskId)
{
    (void) aJobId;
    (void)SetEvent((TaskType)aTaskId, RandEvent);
    return;
}

/**
    @trace #BRCM_SWARCH_RAND_RUN_JOB_SCHEDULER_PROC
    @trace #BRCM_SWREQ_RAND_KERNEL_HANDLER
*/
ISR2(RAND_IRQHandler)
{
    RAND_RunJobScheduler();
}

/** @} */

