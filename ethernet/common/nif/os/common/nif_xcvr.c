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
    @addtogroup grp_nif_impl
    @{
    @section sec_nif_overview NIF Xcvr Overview

    @file nif_xcvr.c
    @brief NIF XCVR Implementation file

    @version 0.1 Initial version
*/

#include <stddef.h>
#include <inttypes.h>
#include <ethxcvr.h>
#include <bcm_err.h>
#include <nif_xcvr.h>
#include <ethxcvr_osil.h>
#include "nif_internal.h"

/**
    @name NIF XCVR Design IDs
    @{
    @brief Design IDs for NIF XCVR
*/
#define BRCM_SWDSGN_NIF_XCVRGETSQIVALUE_PROC           (0xA601U)    /**< @brief #NIF_XcvrGetSQIValue        */
#define BRCM_SWDSGN_ETHXCVR_LINKSTATECHANGEIND_PROC    (0xA602U)    /**< @brief #ETHXCVR_LinkStateChangeInd */
/** @} */

#if !defined(ENABLE_WLAN)
/**
    Get SQI Value

    @trace #BRCM_SWARCH_NIF_XCVRGETSQIVALUE_PROC
    @trace #BRCM_SWREQ_NIF_XCVR
*/
int32_t NIF_XcvrGetSQIValue(uint32_t aXcvrIdx, uint32_t *const aSQIValue)
{
    int32_t retVal = BCM_ERR_OK;

    if (NIF_STATE_INIT != NIF_Comp.state) {
        retVal = BCM_ERR_UNINIT;
    } else if (NIF_XcvrCtrlConfig.xcvrIntfTblSize <= aXcvrIdx){
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (NIF_XcvrCtrlConfig.xcvrIntfTbl[aXcvrIdx].getSQIValue == NULL){
        retVal = BCM_ERR_NOSUPPORT;
    } else {
        retVal = NIF_XcvrCtrlConfig.xcvrIntfTbl[aXcvrIdx].getSQIValue(aXcvrIdx, aSQIValue);
    }

    return retVal;
}
#endif

/**
    Ethernet transceiver link state indication

    @trace #BRCM_SWARCH_ETHXCVR_LINKSTATECHANGEIND_PROC
    @trace #BRCM_SWREQ_ETHXCVR_STATUS_NIF
*/
void ETHXCVR_LinkStateChangeInd(ETHXCVR_IDType aID,
                                ETHXCVR_LinkStateType aLinkState)
{
    NIF_ReportError(aID, BRCM_SWARCH_ETHXCVR_LINKSTATECHANGEIND_PROC,
                    BCM_ERR_OK, __LINE__, aLinkState);
}

/** @} */
