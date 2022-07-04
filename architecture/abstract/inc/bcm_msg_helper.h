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
    @defgroup grp_msg_helper_ifc Client Helpers
    @ingroup grp_abstract

    @addtogroup grp_msg_helper_ifc
    @{

    @file bcm_msg_helper.h

    @brief Message helper Interface
    @version 0.1 Initial version
*/

#ifndef BCM_MSG_HELPER_H
#define BCM_MSG_HELPER_H

#include <bcm_msg.h>

/**
    @name BCM Message Handler API IDs
    @{
    @brief API IDs for Message Handler in System and underlying Subsystem
*/
#define BRCM_SWARCH_MSG_PROCESS_PROC            (0x8500U)    /**< @brief #MSG_Process */
/** @} */

/** @brief Helper function to process an input string or message response

    This helper function shall be used by each helper module and its children
    to check if it supports handling input message string and generate a
    message byte array. In case of input message response, it identifies the
    actual helper module responsible to handle it and passes the response to it.

    @behavior Sync, Reentrant

    This function follows architecture defined at @ref BCM_MsgProcessType
    with below additional arguments
    @param[in]   aHelpers               Client helper modules
    @param[in]   aCnt                   Count of modules

    @trace #BRCM_SWREQ_BCM_COMPONENT
*/
int32_t MSG_Process(BCM_SubStateType *aSubState,
                    BCM_CmdType      *aMsg,
                    const uint8_t    *aInput,
                    uint32_t          aInputLen,
                    uint8_t          *aOut,
                    uint32_t         *aOutLen,
                    uint64_t         *aQueue
                    int32_t          *aResponse
                    const sBCM_MsgConverterType * const *aHelpers,
                    uint32_t          aHelpersCnt);

#endif /* BCM_MSG_HELPER_H */
/** @} */
