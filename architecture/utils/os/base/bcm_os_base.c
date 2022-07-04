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
/**
    @defgroup grp_utils_os_base BASE OS Integration Layer
    @ingroup grp_utils

    @addtogroup grp_utils_os_base
    @{

    file bcm_os_base.c
    @brief OS Integration functions for BASE

    @version 1.0 Initial Version
*/

#include <osil/bcm_osil.h>
#include <osil/bcm_osil_svc.h>
#include <svc.h>
#include <base_kernel_services.h>

/**
    @name  OS wrapper functions Design IDs
    @{
    @brief Architecture IDs for OS wrapper functions
*/
#define BRCM_SWDSGN_BCM_OS_SYSCMDREQ_PROC      (0xD101U)    /**< @brief #BCM_OsSysCmdReq     */
#define BRCM_SWDSGN_BCM_OS_SYSCMDHDLR_PROC     (0xD102U)    /**< @brief #BCM_OsSysCmdHandler */
#define BRCM_SWDSGN_BCM_OS_SVCIO_TYPE          (0xD103U)    /**< @brief #BCM_OsSVCIOType     */
#define BRCM_SWDSGN_BCM_OS_CMD_HANDLER_PROC    (0xD104U)    /**< @brief #BCM_OsCmdHandler    */
/** @} */

/**
    @brief Union to avoid MISRA Required error
    for Type conversion

    @trace #BRCM_SWARCH_BCM_OS_SYSCMDHDLR_PROC
    @trace #BRCM_SWREQ_BCM_OS_KERNEL_HANDLER_BASE
*/
typedef union uBCM_OsSVCIOType {
    uint8_t *data;
    BCM_OsIOType *io;
} BCM_OsSVCIOType;


/**
    @code{.c}
    @endcode
    @trace #BRCM_SWARCH_BCM_OS_SYSCMDHDLR_PROC
    @trace #BRCM_SWREQ_BCM_OS_KERNEL_HANDLER_BASE
*/
static int32_t BCM_OsCmdHandler(uint32_t aCmd, BCM_OsIOType *aBCMOSIO)
{
    int32_t ret = BCM_ERR_OK;

    if (NULL == aBCMOSIO) {
        ret = BCM_ERR_INVAL_PARAMS;
    } else {
        switch(aCmd){
        case BCM_OS_CMD_ACTIVATETASK:
            aBCMOSIO->status = BASE_ActivateTask(aBCMOSIO->taskId);
        break;
        case BCM_OS_CMD_TERMINATETASK:
            aBCMOSIO->status = BASE_TerminateTask();
        break;
        case BCM_OS_CMD_THREADNOTTERMINATED:
            /* What on earth is this anyway? */
            aBCMOSIO->status = BCM_ERR_OK;
        break;
        case BCM_OS_CMD_STARTOS:
            aBCMOSIO->status = BASE_StartOS(aBCMOSIO->appMode);
        break;
        case BCM_OS_CMD_GETEVENT:
            aBCMOSIO->status = BASE_GetEvent(aBCMOSIO->taskId,
                                             &aBCMOSIO->eventMask);
        break;
        case BCM_OS_CMD_SETEVENT:
            aBCMOSIO->status = BASE_SetEvent(aBCMOSIO->taskId,
                                             aBCMOSIO->eventMask);
        break;
        case BCM_OS_CMD_CLEAREVENT:
            aBCMOSIO->status = BASE_ClearEvent(aBCMOSIO->eventMask);
        break;
        case BCM_OS_CMD_WAITEVENT:
            aBCMOSIO->status = BASE_WaitEvent(aBCMOSIO->eventMask);
        break;
        case BCM_OS_CMD_SETRELALARM:
            aBCMOSIO->status = BASE_SetRelAlarm(aBCMOSIO->alarmID,
                                                aBCMOSIO->alarmInc,
                                                aBCMOSIO->alarmCycle);
        break;
        case BCM_OS_CMD_CANCELALARM:
            aBCMOSIO->status = BASE_CancelAlarm(aBCMOSIO->alarmID);
        break;
        case BCM_OS_CMD_EXEC_HANDOVER:
            /* This function never expected to return. */
            BASE_ExecHandover(aBCMOSIO->entryPt);
            aBCMOSIO->status = BCM_ERR_UNKNOWN;
        break;
        default:
            ret = BCM_ERR_INVAL_PARAMS;
            break;
        }
    }

    return ret;
}
/** @} */
/**
    @addtogroup grp_bcm_osil_svc
    @{
*/
/**
    @code{.c}

    Build SVC Request
    ret = SVC_Request(&sysReqIO)
    if (ret is BCM_ERR_OK)
        ret = sysReqIO.response
    else
        Log error

    return ret
    @endcode
    @trace #BRCM_SWARCH_BCM_OS_SYSCMDREQ_PROC
    @trace #BRCM_SWREQ_BCM_OS_WRAPPER
*/
int32_t BCM_OsSysCmdReq(const uint32_t aCmd, BCM_OsIOType *aIO)
{
    int32_t ret;
    SVC_RequestType sysReqIO;

    sysReqIO.response = BCM_ERR_UNKNOWN;

    /* Build SVC command struct */
    sysReqIO.sysReqID = SVC_OSI_ID;
    sysReqIO.magicID = SVC_MAGIC_OSI_ID;
    sysReqIO.cmd = aCmd;
    sysReqIO.svcIO = (uint8_t*)aIO;
    /* Send SVC command */
    ret = SVC_Request(&sysReqIO);
    if (BCM_ERR_OK == ret) {
        ret = sysReqIO.response;
    }
    return ret;
}

/**
    @code{.c}
    if aSysIO.bcmOsIO is not NULL
        if aMagicID is SVC_MAGIC_OSI_ID
            ret = BCM_OsCmdHandler(aCmd, aSysIO.bcmOsIO)
            if ret is not BCM_ERR_OK
                Log error
        else
            Log error
    else
        Log error
    @endcode
    @trace #BRCM_SWARCH_BCM_OS_SYSCMDHDLR_PROC
    @trace #BRCM_SWREQ_BCM_OS_KERNEL_HANDLER_BASE
*/
void BCM_OsSysCmdHandler(uint32_t aMagicID, uint32_t aCmd, uint8_t * aSysIO)
{
    int32_t ret = BCM_ERR_OK;
    BCM_OsSVCIOType bcmSVCIO;
    bcmSVCIO.data = aSysIO;
    uint32_t line = 0UL;

    if (SVC_MAGIC_OSI_ID == aMagicID) {
        ret = BCM_OsCmdHandler(aCmd, bcmSVCIO.io);
        if (BCM_ERR_OK != ret) {
            line = (uint32_t)__LINE__;
        }
    } else {
        line = (uint32_t)__LINE__;
        ret = BCM_ERR_INVAL_PARAMS;
    }

    if (BCM_ERR_OK != ret) {
        const uint32_t values[4UL] = {line, aMagicID, aCmd, (uint32_t)aSysIO};
        BCM_ReportError(BCM_OSI_ID, 0U, BRCM_SWARCH_BCM_OS_SYSCMDHDLR_PROC,
             ret, 4UL, values);
    }

}
/** @} */
