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
    @section sec_nif_overview NIF Time Stamp Overview

    @file nif_timestamp.c
    @brief NIF Time Stamp Implementation file

    @version 0.1 Initial version
*/

#include <nif_timestamp.h>
#include "nif_internal.h"

/**
    @name NIF Time Stamp Design IDs
    @{
    @brief Design IDs for NIF Time Stamp
*/
#define BRCM_SWDSGN_NIF_GETTIME_PROC              (0xA101U)    /**< @brief #NIF_GetTime           */
#define BRCM_SWDSGN_NIF_SETTIME_PROC              (0xA102U)    /**< @brief #NIF_SetTime           */
#define BRCM_SWDSGN_NIF_SETCORRECTIONTIME_PROC    (0xA103U)    /**< @brief #NIF_SetCorrectionTime */
/** @} */

/**
    Retrieve current Ethernet time

    @trace #BRCM_SWARCH_NIF_GETTIME_PROC
    @trace #BRCM_SWREQ_NIF_TIME
*/
int32_t NIF_GetTime(NIF_CntrlIDType aCtrlIdx, ETHER_TimestampType* const aTS, ETHER_TimestampQualType* const aTSQual)
{
#ifndef ENABLE_ETH_TIME
    int32_t retVal = BCM_ERR_NOSUPPORT;
#else
    int32_t retVal = BCM_ERR_INVAL_PARAMS;
    const NIF_TSEthIntfType *ethFn = NULL;
    NIF_EthCntrlrIdxType ethCtrlIdx = NIF_GET_CONTROLLER_INDEX(aCtrlIdx);

    ethFn = NIF_GetTSEthControllerID(aCtrlIdx);
    if(NULL != ethFn){
        retVal = ethFn->getTime(ethCtrlIdx, aTS, aTSQual);
    }
#endif
    return retVal;
}

/**
    Set Ethernet time

    @trace #BRCM_SWARCH_NIF_SETTIME_PROC
    @trace #BRCM_SWREQ_NIF_TIME
*/
int32_t NIF_SetTime(NIF_CntrlIDType aCtrlIdx, const ETHER_TimestampType* const aTS)
{
#ifndef ENABLE_ETH_TIME
    int32_t retVal = BCM_ERR_NOSUPPORT;
#else
    int32_t retVal = BCM_ERR_INVAL_PARAMS;
    const NIF_TSEthIntfType *ethFn = NULL;
    NIF_EthCntrlrIdxType ethCtrlIdx = NIF_GET_CONTROLLER_INDEX(aCtrlIdx);

    ethFn = NIF_GetTSEthControllerID(aCtrlIdx);
    if(NULL != ethFn){
        retVal = ethFn->setTime(ethCtrlIdx, aTS);
    }
#endif
    return retVal;
}

/**
    Adjust Ethernet time

    @trace #BRCM_SWARCH_NIF_SETCORRECTIONTIME_PROC
    @trace #BRCM_SWREQ_NIF_TIME
*/
int32_t NIF_SetCorrectionTime(NIF_CntrlIDType aCtrlIdx, const ETHER_TimestampDiffType* const aTD, const ETHER_RateRatioType* const aRR)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;
    const NIF_TSEthIntfType *ethFn = NULL;
    NIF_EthCntrlrIdxType ethCtrlIdx = NIF_GET_CONTROLLER_INDEX(aCtrlIdx);

    ethFn = NIF_GetTSEthControllerID(aCtrlIdx);
    if(NULL != ethFn){
        retVal = ethFn->setCorrectionTime(ethCtrlIdx, aTD, aRR);
    }
    return retVal;
}

/** @} */