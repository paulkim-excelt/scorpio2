/*****************************************************************************
 Copyright 2017-2021 Broadcom Limited.  All rights reserved.

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
    @addtogroup grp_timdrv_il
    @{

    @file tim_osil.c
    @brief TIM driver integration
    This source file contains the integration of TIM driver to system
    @version 0.30 Imported from docx
*/

#include <stdint.h>
#include <tim_osil.h>
#include <stddef.h>
#include "ee.h"

/**
    @name TIM driver interface IDs
    @{
    @brief Interface IDs for TIM driver
*/
#define BRCM_SWDSGN_TIM_IRQHANDLER0_PROC     (0xE101U)    /**< @brief #TIM_IRQHandler0   */
#define BRCM_SWDSGN_TIM_IRQHANDLER1_PROC     (0xE102U)    /**< @brief #TIM_IRQHandler1   */
#define BRCM_SWDSGN_TIM_SYSCMDREQ_PROC       (0xE103U)    /**< @brief #TIM_SysCmdReq     */
#define BRCM_SWDSGN_TIM_CALLBACKTABLE_GLOBAL (0xE104U)    /**< @brief #TIM_CallBackTable */
/** @} */

/**
    @trace  #BRCM_SWARCH_TIM_ENABLENOTIFICATION_PROC
    @trace  #BRCM_SWARCH_TIM_DISABLENOTIFICATION_PROC
    @trace  #BRCM_SWARCH_TIM_IRQHANDLER_PROC
    @trace  #BRCM_SWARCH_TIM_INIT_PROC
    @trace  #BRCM_SWREQ_TIM_NOTIFICATION
*/
const TIM_CbType TIM_CallBackTable[TIM_MAX_CHANNELS] = {
#ifdef ENABLE_TIM_CHANN0_CB
    TIM_Chann0Cb,
#else
    NULL,
#endif

#ifdef ENABLE_TIM_CHANN1_CB
    TIM_Chann1Cb
#else
    NULL
#endif
};

/**
    @trace #BRCM_SWARCH_TIM_IRQHANDLER_PROC
    @trace #BRCM_SWREQ_TIM_KERNEL_HANDLER
*/
ISR2(TIM_IRQHandler0)
{
    TIM_IRQHandler(0UL);
}

/**
    @trace #BRCM_SWARCH_TIM_IRQHANDLER_PROC
    @trace #BRCM_SWREQ_TIM_KERNEL_HANDLER
*/
ISR2(TIM_IRQHandler1)
{
    TIM_IRQHandler(1UL);
}

/**
    @trace #BRCM_SWARCH_TIM_SYSCMDREQ_PROC
    @trace #BRCM_SWREQ_TIM_KERNEL_INTERFACE

    @code{.c}
    ret = BCM_ERR_INVAL_PARAMS
    if aIO is not NULL
        Build SVC request
        ret = SVC_Request(&sysReqIO)
        if ret is BCM_ERR_OK
            if BCM_ERR_OK = sysReqIO.response
                ret = aIO->retVal
            else
                ret = sysReqIO.response
    @endcode
*/
int32_t TIM_SysCmdReq(TIM_CmdType aCmd, TIM_IOType *const aIO)
{
    SVC_RequestType sysReqIO;
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    if (NULL != aIO) {
        sysReqIO.sysReqID = SVC_SPT_ID;
        sysReqIO.magicID = SVC_MAGIC_SPT_ID;
        sysReqIO.cmd = aCmd;
        sysReqIO.svcIO = (uint8_t *)aIO;
        sysReqIO.response = BCM_ERR_UNKNOWN;

        /* BCM_TEST_ADD_PROBE(BCM_SPT_ID,
                BRCM_SWPTSEQ_TIMER_SYS_CMD_TEST,
                BRCM_SWPTST_TIM_SYSCMDREQ_INVAL_SYSREQID,
                sysReqIO.sysReqID = 0UL) */
        retVal = SVC_Request(&sysReqIO);
        /* BCM_TEST_ADD_PROBE(BCM_SPT_ID,
                BRCM_SWPTSEQ_TIMER_SYS_CMD_TEST,
                BRCM_SWPTST_TIM_SYSCMDREQ_INVAL_RESPONSE,
                sysReqIO.response = BCM_ERR_INVAL_PARAMS) */
        if (BCM_ERR_OK == retVal) {
            if (BCM_ERR_OK == sysReqIO.response) {
                retVal = aIO->retVal;
            } else {
                retVal = sysReqIO.response;
            }
        }
    }

    return retVal;
}

/** @} */
