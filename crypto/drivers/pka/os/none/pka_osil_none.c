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
    @addtogroup grp_pka_il
    @{

    @file pka_osil_none.c
    @brief PKA driver integration
    This source file contains the integration of PKA driver to system
    @version 0.10 Initial version
*/

#include <bcm_err.h>

#include "osil/pka_osil.h"

/**
    @name PKA driver interface IDs
    @{
    @brief Interface IDs for the PKA driver
*/
#define BRCM_SWDSGN_PKA_SYSCMDREQ_PROC                   (0xB101U)    /**< @brief #PKA_SysCmdReq             */
#define BRCM_SWDSGN_PKA_OSIL_NOTIFY_JOB_START_PROC       (0xB102U)    /**< @brief #PKA_OsilNotifyJobStart    */
#define BRCM_SWDSGN_PKA_OSIL_NOTIFY_JOB_COMPLETE_PROC    (0xB103U)    /**< @brief #PKA_OsilNotifyJobComplete */
/** @} */

/**
    @trace #BRCM_SWARCH_PKA_SYSCMD_REQ_PROC
    @trace #BRCM_SWREQ_PKA_KERNEL_INTERFACE
*/
int32_t PKA_SysCmdReq(PKA_CmdType aCmd, PKA_IOType *const aIO)
{
    int32_t ret = BCM_ERR_INVAL_PARAMS;

    PKA_RunJobScheduler();

    if (aIO != NULL) {
        PKA_SysCmdHandler(SVC_MAGIC_PKA_ID, aCmd, (uint8_t*)aIO);
        ret = aIO->retVal;
    }

    return ret;
}

/** @brief Notify PKA job start

    @trace #BRCM_SWARCH_PKA_OSIL_NOTIFY_JOB_START_PROC
    @trace #BRCM_SWREQ_PKA_LIBRARY
 */
void PKA_OsilNotifyJobStart(const PKA_JobIdType aJobId, const uint64_t aTaskId)
{
    (void) aJobId;
    (void) aTaskId;
    return;
}

/** @brief Notify PKA job completion

    @trace #BRCM_SWARCH_PKA_OSIL_NOTIFY_JOB_COMPLETE_PROC
    @trace #BRCM_SWREQ_PKA_LIBRARY
 */
void PKA_OsilNotifyJobComplete(const PKA_JobIdType aJobId, const uint64_t aTaskId)
{
    (void) aJobId;
    (void) aTaskId;
    return;
}

/** @} */
