/*****************************************************************************
 Copyright 2021 Broadcom Limited.  All rights reserved.

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
    @addtogroup grp_ipc_il
    @{

    @file ipc_osil.c
    @brief IPC driver Integration
    This source file contains the integration of IPC driver to system
    @version 0.20 Imported from docx
*/

#include <ipc.h>
#include <ipc_osil.h>
#include "ee.h"

/**
    @name IPC Driver interface IDs
    @{
    @brief IPC driver integration design IDs.
*/
#define BRCM_SWDSGN_IPC_SYSCMDREQ_PROC    (0xE101U) /**< @brief #IPC_SysCmdReq */
#define BRCM_SWDSGN_IPC_IRQ_CHNN0_PROC    (0xE102U) /**< @brief #IPC_IRQChann0Handler */
#define BRCM_SWDSGN_IPC_IRQ_CHNN1_PROC    (0xE103U) /**< @brief #IPC_IRQChann1Handler */
/** @} */

/**
    @code{.c}
    sysReqIO.sysReqID = SVC_IPC_ID
    sysReqIO.magicID = SVC_MAGIC_IPC_ID
    sysReqIO.cmd = aCmd
    sysReqIO.svcIO = aIO
    sysReqIO.response = BCM_ERR_UNKNOWN

    ret = SVC_Request(&sysReqIO)
    if ret is not BCM_ERR_OK or sysReqIO.response is not BCM_ERR_OK
        ret = BCM_ERR_UNKNOWN
    else
        ret = aIO->retVal
    return ret
    @endcode

    @trace #BRCM_SWARCH_IPC_SYS_CMD_REQ_PROC
    @trace #BRCM_SWREQ_IPC_KERNEL_INTERFACE
*/
int32_t IPC_SysCmdReq(const uint32_t aCmd, IPC_IOType *aIO)
{
    int32_t ret;
    SVC_RequestType sysReqIO;

    /* Build SVC command struct */
    sysReqIO.sysReqID = SVC_IPC_ID;
    sysReqIO.magicID = SVC_MAGIC_IPC_ID;
    sysReqIO.cmd = aCmd;
    sysReqIO.svcIO = (uint8_t *)aIO;
    sysReqIO.response = BCM_ERR_UNKNOWN;

    ret = SVC_Request(&sysReqIO);
    if ((BCM_ERR_OK != ret) || (BCM_ERR_OK != sysReqIO.response)) {
        ret = BCM_ERR_UNKNOWN;
    } else {
        ret = aIO->status;
    }
    return ret;
}

/**
    @code{.c}
    IPC_IRQHandler(0)
    SetEvent(IPC_SERVER_TASK, IPC_CHANN0_EVENT)
    @endcode

    @trace #BRCM_SWARCH_IPC_IRQ_CH0_HANDLER_PROC
    @trace #BRCM_SWREQ_IPC_KERNEL_HANDLER
*/
ISR2(IPC_IRQChann0Handler)
{
    IPC_IRQHandler(0UL);
#ifdef IPC_CHANN0_EVENT
    (void)SetEvent(IPC_SERVER_TASK, IPC_CHANN0_EVENT);
#endif
}

/**
    @code{.c}
    IPC_IRQHandler(1)
    SetEvent(IPC_SERVER_TASK, IPC_CHANN1_EVENT)
    @endcode

    @trace #BRCM_SWARCH_IPC_IRQ_CH1_HANDLER_PROC
    @trace #BRCM_SWREQ_IPC_KERNEL_HANDLER
*/
#if IPC_MAX_CHANNELS > 1
ISR2(IPC_IRQChann1Handler)
{
    IPC_IRQHandler(1UL);
#ifdef IPC_CHANN1_EVENT
#ifdef IPC_CHANN1_SERVER_TASK
    (void)SetEvent(IPC_CHANN1_SERVER_TASK, IPC_CHANN1_EVENT);
#else
    (void)SetEvent(IPC_SERVER_TASK, IPC_CHANN1_EVENT);
#endif
#endif
}
#endif

/** @} */
