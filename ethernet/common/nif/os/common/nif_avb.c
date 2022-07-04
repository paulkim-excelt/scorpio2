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
    @section sec_nif_overview NIF AVB Overview

    @file nif_avb.c
    @brief NIF AVB Implementation file

    @version 0.1 Initial version
*/

#include <nif.h>
#include <nif_avb.h>
#if defined (ENABLE_NIF_FQTSS)
#include <nif_fqtss.h>
#endif
#include "nif_internal.h"

/**
    @name NIF AVB Architecture IDs
    @{
    @brief Architecture IDs for NIF AVB
*/
#define BRCM_SWDSGN_NIF_ENABLEAVBSHAPING_PROC               (0xA201U)    /**< @brief #NIF_EnableAVBShaping            */
#define BRCM_SWDSGN_NIF_DISABLEAVBSHAPING_PROC              (0xA202U)    /**< @brief #NIF_DisableAVBShaping           */
#define BRCM_SWDSGN_NIF_PROCESSETHERNETTIMER_PROC           (0xA203U)    /**< @brief #NIF_ProcessEthernetTimer        */
#define BRCM_SWDSGN_NIF_ARECLIENTSWAITINGFORBUFFERS_PROC    (0xA204U)    /**< @brief #NIF_AreClientsWaitingForBuffers */
/** @} */

/**
    Enables AVB shaping for a stream

    @trace #BRCM_SWARCH_NIF_ENABLEAVBSHAPING_PROC
    @trace #BRCM_SWREQ_NIF_STREAM_SHAPING
*/
int32_t NIF_EnableAVBShaping(NIF_CntrlIDType aCtrlIdx, NIF_AVBClassType aClass, uint32_t aReservation)
{
    int32_t             retVal = BCM_ERR_INVAL_PARAMS;
#if defined(ENABLE_NIF_FQTSS)
    uint32_t            streamIdx = NIF_FQTSS_MAX_STREAMS;
    uint32_t            period = aClass * 1000UL;
    uint32_t            clientID;
    const NIF_TSEthIntfType *ethFn = NULL;
    NIF_EthCntrlrIdxType ethCtrlIdx = NIF_GET_CONTROLLER_INDEX(aCtrlIdx);

    ethFn = NIF_GetTSEthControllerID(aCtrlIdx);
    if (NULL == ethFn) {
        goto done;
    }

    if ((aClass != NIF_AVBCLASS_A) && (aClass != NIF_AVBCLASS_B)) {
        retVal = BCM_ERR_INVAL_PARAMS;
        goto done;
    }

    NIF_GetClientID(aCtrlIdx, &clientID);
    /* Extract stream information from aCtrlIdx */
    retVal = NIF_FindStreamIdx(clientID, &streamIdx);
    if (BCM_ERR_OK == retVal) {
        retVal = NIF_FqtssEnableStream(streamIdx, period, aReservation);
        if (BCM_ERR_OK == retVal) {
            NIF_Comp.totalAVBReserved += aReservation;
            if (NIF_Comp.totalAVBReserved > NIF_FQTSS_MAX_AVB_BANDWIDTH) {
                NIF_ReportError(aCtrlIdx, BRCM_SWARCH_NIF_ENABLEAVBSHAPING_PROC,
                        BCM_ERR_NOSUPPORT, NIF_Comp.totalAVBReserved, __LINE__);
            }
            if (NIF_Comp.currentTimerPeriod > period) {
                retVal = ethFn->setGPTimer(ethCtrlIdx, period);
                NIF_Comp.currentTimerPeriod = period;
            }
        }
    }
done:
#else
    uint32_t streamIdx = 0UL;
    retVal = BCM_ERR_NOSUPPORT;
#endif
    if (BCM_ERR_OK != retVal) {
        NIF_ReportError(aCtrlIdx, BRCM_SWARCH_NIF_ENABLEAVBSHAPING_PROC, retVal,
                        streamIdx, __LINE__);
    }
    return retVal;
}

/**
    Disables AVB shaping for a stream

    @trace #BRCM_SWARCH_NIF_DISABLEAVBSHAPING_PROC
    @trace #BRCM_SWREQ_NIF_STREAM_SHAPING
*/
int32_t NIF_DisableAVBShaping(NIF_CntrlIDType aCtrlIdx)
{
    int32_t             retVal  = BCM_ERR_INVAL_PARAMS;
#if defined(ENABLE_NIF_FQTSS)
    uint32_t            streamIdx = NIF_FQTSS_MAX_STREAMS;
    uint32_t            fastestTimerPeriod;
    uint32_t            reservation;
    uint32_t            clientID;
    const NIF_TSEthIntfType *ethFn = NULL;
    NIF_EthCntrlrIdxType ethCtrlIdx = NIF_GET_CONTROLLER_INDEX(aCtrlIdx);

    ethFn = NIF_GetTSEthControllerID(aCtrlIdx);
    if (NULL == ethFn) {
        goto done;
    }

    NIF_GetClientID(aCtrlIdx, &clientID);

    /* Extract stream information from aCtrlIdx */
    retVal = NIF_FindStreamIdx(clientID, &streamIdx);
    if (BCM_ERR_OK == retVal) {
        retVal = NIF_FqtssDisableStream(streamIdx,
                                     &reservation,
                                     &fastestTimerPeriod);
        if (BCM_ERR_OK == retVal) {
            NIF_Comp.totalAVBReserved -= reservation;
            if (NIF_Comp.currentTimerPeriod < fastestTimerPeriod) {
                retVal = ethFn->setGPTimer(ethCtrlIdx, fastestTimerPeriod);
                NIF_Comp.currentTimerPeriod = fastestTimerPeriod;
            }
        }
    }
done:
#else
    uint32_t streamIdx = 0UL;
    retVal = BCM_ERR_NOSUPPORT;
#endif
    if (BCM_ERR_OK != retVal) {
        NIF_ReportError(aCtrlIdx, BRCM_SWARCH_NIF_DISABLEAVBSHAPING_PROC, retVal,
                       streamIdx, __LINE__);
    }
    return retVal;
}

/**
    Process ethernet timer

    @trace #BRCM_SWARCH_NIF_PROCESSETHERNETTIMER_PROC
    @trace #BRCM_SWREQ_NIF_STREAM_SHAPING
*/
void NIF_ProcessEthernetTimer(ETHER_HwIDType aID)
{
    uint32_t i;
    NIF_CntrlIDType ctrlIdx;

    /* Go through all clients waiting for buffer and send notification */
    for (i = 0UL; i < NIF_CmnCtrlConfig.cmnCbTblSize; i++) {
        if ((NIF_AVBCtrlConfig.avbCbTbl[i].bufAvailCb != NULL) &&
            (0UL != (NIF_Comp.isWaitingForBuffer & (1UL << i)))) {
            /* Generate nif controller index */
            ctrlIdx = NIF_CTRL(0U, NIF_CmnCtrlConfig.cmnCbTbl[i].clientID,
                               NIF_CmnCtrlConfig.cmnCbTbl[i].cntrlIndex);
            NIF_AVBCtrlConfig.avbCbTbl[i].bufAvailCb(ctrlIdx);
        }
    }
}

/**
    Check if clients are waiting for buffer

    @trace #BRCM_SWARCH_NIF_ARECLIENTSWAITINGFORBUFFERS_PROC
    @trace #BRCM_SWREQ_NIF_STREAM_SHAPING
*/
uint32_t NIF_AreClientsWaitingForBuffers(void)
{
    uint32_t isWaiting = (0UL == NIF_Comp.isWaitingForBuffer) ? 0UL:1UL;
    return isWaiting;
}

/** @} */
