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
    @addtogroup grp_pchdrv_il
    @{

    @file pchdrv_osil.c
    @brief Patch driver system integration
    This source file contains the integration of Patch driver to system
    @version Initial revision
*/
#include <stdint.h>
#include <stddef.h>
#include <svc.h>
#include <pchdrv.h>
#include <osil/pchdrv_osil.h>

/**
    @name Patch driver interface IDs
    @{
    @brief Patch driver integration design IDs.
*/
#define BRCM_SWDSGN_PATCH_SYSCMDREQ_PROC    (0xE101U)    /**< @brief #PATCH_SysCmdReq */
#define BRCM_SWDSGN_PATCH_DEF_ISR_PROC      (0xE102U)    /**< @brief #PATCH_DefaultInterruptHandler */
/** @} */

/**
    @code{.c}
    ret = BCM_ERR_INVAL_PARAMS
    if aPchdrvIO == NULL
        ret = BCM_ERR_INVAL_PARAMS
    else
        sysReqIO.sysReqID = SVC_PCH_ID
        sysReqIO.magicID = SVC_MAGIC_PCH_ID
        sysReqIO.cmd = aCmd
        sysReqIO.svcIO = aPchdrvIO
        sysReqIO.response = BCM_ERR_UNKNOWN
        ret = SVC_Request(&sysReqIO)
        if ret is BCM_ERR_OK and sysReqIO.response is BCM_ERR_OK
            ret = aPchdrvIO->retVal
        else
            ret = BCM_ERR_UNKNOWN
    return ret
    @endcode

    @trace #BRCM_SWARCH_PATCH_SYS_CMD_REQ_PROC
    @trace #BRCM_SWREQ_PATCH_KERNEL_INTERFACE
*/
int32_t PATCH_SysCmdReq(PATCH_CmdType aCmd, PATCH_IOType *aPchdrvIO)
{
    SVC_RequestType sysReqIO;
    int32_t ret = BCM_ERR_INVAL_PARAMS;

    if (aPchdrvIO != NULL) {
        sysReqIO.sysReqID = SVC_PCH_ID;
        sysReqIO.magicID = SVC_MAGIC_PCH_ID;
        sysReqIO.cmd = aCmd;
        sysReqIO.svcIO = (uint8_t *)aPchdrvIO;
        sysReqIO.response = BCM_ERR_UNKNOWN;

        ret = SVC_Request(&sysReqIO);

        if ((BCM_ERR_OK == ret) && (BCM_ERR_OK == sysReqIO.response)) {
            ret = aPchdrvIO->retVal;
        } else {
            ret = BCM_ERR_UNKNOWN;
        }
    }
    return ret;
}

/**
    @code{.c}
    PATCH_ExecPatchSeq(0UL, aIntNum)
    @endcode

    @trace #BRCM_SWARCH_PATCH_CMD_DEF_ISR_PROC
    @trace #BRCM_SWREQ_PATCH_KERNEL_HANDLER
*/
void PATCH_DefaultInterruptHandler(uint32_t aIntNum)
{
    /* CompID = BCM_INT_ID, for all interrupts */
    (void)PATCH_ExecPatchSeq(BCM_INT_ID, aIntNum);
}

/** @} */
