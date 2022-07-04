/*****************************************************************************
 Copyright 2017-2020 Broadcom Limited.  All rights reserved.

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
/** @defgroup grp_ethswt_il_impl Ethernet switch driver Integration implementation
    @ingroup grp_ethswt

    @addtogroup grp_ethswt_il_impl
    @{
    @section sec_ethswt_il_shell Ethernet Switch Driver Integration

    @file switch_osil.c
    @brief Ethernet Switch Driver Integration
    This source file contains the integration of Ethernet Switch Driver to
    system
    @version 0.51 Imported from docx
*/

#include <eth_switch_osil.h>
#include <ethxcvr.h>
#include <bcm_err.h>
#include <osil/bcm_osil.h>
#include "ee.h"

/**
    @name Design IDs
    @{
    @brief Design IDs
*/
#define BRCM_SWDSGN_ETHSWT_ID_0_MACRO                     (0xE201U)    /**< @brief #ETHSWT_ID_0                */
#define BRCM_SWDSGN_ETHSWT_SYS_CMD_REQ_PROC               (0xE202U)    /**< @brief #ETHSWT_SysCmdReq           */
#define BRCM_SWDSGN_ETHSWT_PORT0_LINK_IRQ_HANDLER_PROC    (0xE203U)    /**< @brief #ETHSWT_Port0LinkIRQHandler */
#define BRCM_SWDSGN_ETHSWT_PORT1_LINK_IRQ_HANDLER_PROC    (0xE204U)    /**< @brief #ETHSWT_Port1LinkIRQHandler */
#define BRCM_SWDSGN_ETHSWT_PORT2_LINK_IRQ_HANDLER_PROC    (0xE205U)    /**< @brief #ETHSWT_Port2LinkIRQHandler */
#define BRCM_SWDSGN_ETHSWT_PORT3_LINK_IRQ_HANDLER_PROC    (0xE206U)    /**< @brief #ETHSWT_Port3LinkIRQHandler */
#define BRCM_SWDSGN_ETHSWT_PORT4_LINK_IRQ_HANDLER_PROC    (0xE207U)    /**< @brief #ETHSWT_Port4LinkIRQHandler */
#define BRCM_SWDSGN_ETHSWT_PORT5_LINK_IRQ_HANDLER_PROC    (0xE208U)    /**< @brief #ETHSWT_Port5LinkIRQHandler */
#define BRCM_SWDSGN_ETHSWT_PORT6_LINK_IRQ_HANDLER_PROC    (0xE209U)    /**< @brief #ETHSWT_Port6LinkIRQHandler */
#define BRCM_SWDSGN_ETHSWT_PORT8_LINK_IRQ_HANDLER_PROC    (0xE20AU)    /**< @brief #ETHSWT_Port8LinkIRQHandler */
/** @} */

/**
    @brief Ethernet switch ID

    @trace #BRCM_SWARCH_ETHSWT_PORT0_LINK_IRQ_HANDLER_PROC
    @trace #BRCM_SWARCH_ETHSWT_PORT1_LINK_IRQ_HANDLER_PROC
    @trace #BRCM_SWARCH_ETHSWT_PORT2_LINK_IRQ_HANDLER_PROC
    @trace #BRCM_SWARCH_ETHSWT_PORT3_LINK_IRQ_HANDLER_PROC
    @trace #BRCM_SWARCH_ETHSWT_PORT4_LINK_IRQ_HANDLER_PROC
    @trace #BRCM_SWARCH_ETHSWT_PORT5_LINK_IRQ_HANDLER_PROC
    @trace #BRCM_SWARCH_ETHSWT_PORT6_LINK_IRQ_HANDLER_PROC
    @trace #BRCM_SWARCH_ETHSWT_PORT8_LINK_IRQ_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION
*/
#define ETHSWT_ID_0               (0UL)

/**
    @brief Sys command request

    @trace #BRCM_SWARCH_ETHSWT_SYS_CMD_REQ_PROC
    @trace #BRCM_SWREQ_ETHSWT_KERNEL_INTERFACE

    @code{.c}
    ret = BCM_ERR_UNKNOWN
    if aIO is not NULL {
        Build SVC request
        ret = SVC_Request(&sysReqIO)
        if ret is not BCM_ERR_OK
            ret = BCM_ERR_UNKNOWN
        else if sysReqIO.response is not BCM_ERR_OK
            ret = sysReqIO.response
        else
            ret = aIO->retVal
    }

    return ret
    @endcode
*/
int32_t ETHSWT_SysCmdReq(ETHSWT_IOCmdType aCmd, ETHSWT_IOType *const aIO)
{
    int32_t retVal = BCM_ERR_UNKNOWN;
    SVC_RequestType sysReqIO;

    if (NULL != aIO) {
        sysReqIO.sysReqID = SVC_SWT_ID;
        sysReqIO.magicID = SVC_MAGIC_SWT_ID;
        sysReqIO.cmd = aCmd;
        sysReqIO.svcIO = (uint8_t*)aIO;
        sysReqIO.response = BCM_ERR_UNKNOWN;

        retVal = SVC_Request(&sysReqIO);
        if (BCM_ERR_OK != retVal) {
            retVal = BCM_ERR_UNKNOWN;
        } else if (BCM_ERR_OK != sysReqIO.response) {
            retVal = BCM_ERR_UNKNOWN;
        } else {
            retVal = aIO->retVal;
        }
    }

    return retVal;
}

#if defined(ENABLE_ETHSWT_XCVR)
/**
    @brief Switch Port 0 IRQ handler

    @trace #BRCM_SWARCH_ETHSWT_PORT0_LINK_IRQ_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_KERNEL_HANDLER
*/
ISR2(ETHSWT_Port0LinkIRQHandler)
{
    StatusType status = E_OK;
    ETHSWT_LinkIRQHandler(ETHSWT_ID_0, 0UL);
    status = SetEvent(ETHERSWT_IRQ_PROCESS_TASK, ETHERSWT_PORT_LINK_EVENT);
    if (E_OK != status) {
        /* TODO: Add ASSERT/Crash */
    }
}

/**
    @brief Switch Port 1 IRQ handler

    @trace #BRCM_SWARCH_ETHSWT_PORT1_LINK_IRQ_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_KERNEL_HANDLER
*/
ISR2(ETHSWT_Port1LinkIRQHandler)
{
    StatusType status = E_OK;
    ETHSWT_LinkIRQHandler(ETHSWT_ID_0, 1UL);
    status = SetEvent(ETHERSWT_IRQ_PROCESS_TASK, ETHERSWT_PORT_LINK_EVENT);
    if (E_OK != status) {
        /* TODO: Add ASSERT/Crash */
    }
}

/**
    @brief Switch Port 2 IRQ handler

    @trace #BRCM_SWARCH_ETHSWT_PORT2_LINK_IRQ_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_KERNEL_HANDLER
*/
ISR2(ETHSWT_Port2LinkIRQHandler)
{
    int32_t status = BCM_ERR_OK;
    ETHSWT_LinkIRQHandler(ETHSWT_ID_0, 2UL);
    status = SetEvent(ETHERSWT_IRQ_PROCESS_TASK, ETHERSWT_PORT_LINK_EVENT);
    if (BCM_ERR_OK != status) {
        /* TODO: Add ASSERT/Crash */
    }
}

/**
    @brief Switch Port 3 IRQ handler

    @trace #BRCM_SWARCH_ETHSWT_PORT3_LINK_IRQ_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_KERNEL_HANDLER
*/
ISR2(ETHSWT_Port3LinkIRQHandler)
{
    int32_t status = BCM_ERR_OK;
    ETHSWT_LinkIRQHandler(ETHSWT_ID_0, 3UL);
    status = SetEvent(ETHERSWT_IRQ_PROCESS_TASK, ETHERSWT_PORT_LINK_EVENT);
    if (BCM_ERR_OK != status) {
        /* TODO: Add ASSERT/Crash */
    }
}

/**
    @brief Switch Port 4 IRQ handler

    @trace #BRCM_SWARCH_ETHSWT_PORT4_LINK_IRQ_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_KERNEL_HANDLER
*/
ISR2(ETHSWT_Port4LinkIRQHandler)
{
    StatusType status = E_OK;
    ETHSWT_LinkIRQHandler(ETHSWT_ID_0, 4UL);
    status = SetEvent(ETHERSWT_IRQ_PROCESS_TASK, ETHERSWT_PORT_LINK_EVENT);
    if (E_OK != status) {
        /* TODO: Add ASSERT/Crash */
    }
}

/**
    @brief Switch Port 5 IRQ handler

    @trace #BRCM_SWARCH_ETHSWT_PORT5_LINK_IRQ_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_KERNEL_HANDLER
*/
ISR2(ETHSWT_Port5LinkIRQHandler)
{
    StatusType status = E_OK;
    ETHSWT_LinkIRQHandler(ETHSWT_ID_0, 5UL);
    status = SetEvent(ETHERSWT_IRQ_PROCESS_TASK, ETHERSWT_PORT_LINK_EVENT);
    if (E_OK != status) {
        /* TODO: Add ASSERT/Crash */
    }
}

/**
    @brief Switch Port 6 IRQ handler

    @trace #BRCM_SWARCH_ETHSWT_PORT6_LINK_IRQ_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_KERNEL_HANDLER
*/
ISR2(ETHSWT_Port6LinkIRQHandler)
{
    StatusType status = E_OK;
    ETHSWT_LinkIRQHandler(ETHSWT_ID_0, 6UL);
    status = SetEvent(ETHERSWT_IRQ_PROCESS_TASK, ETHERSWT_PORT_LINK_EVENT);
    if (E_OK != status) {
        /* TODO: Add ASSERT/Crash */
    }
}

/**
    @brief Switch Port 8 IRQ handler

    @trace #BRCM_SWARCH_ETHSWT_PORT8_LINK_IRQ_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_KERNEL_HANDLER
*/
ISR2(ETHSWT_Port8LinkIRQHandler)
{
    StatusType status = E_OK;
    ETHSWT_LinkIRQHandler(ETHSWT_ID_0, 8UL);
    status = SetEvent(ETHERSWT_IRQ_PROCESS_TASK, ETHERSWT_PORT_LINK_EVENT);
    if (E_OK != status) {
        /* TODO: Add ASSERT/Crash */
    }
}
#endif
/** @} */
