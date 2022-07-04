/*****************************************************************************
 Copyright 2021-2022 Broadcom Limited.  All rights reserved.

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
    @addtogroup grp_ets_il
    @{
    @file ets_il.c
    @brief ETS Integration Layer
    This source file contains the integration of ETS to API
    @version 0.1 Draft version
*/

#include <ets_sm.h>
#include "ets_osil_defs.h"
#include <atomic.h>

/**
    @name ETS MOD OSIL Design IDs
    @{
    @brief Design IDs for ETS MOD OSIL

*/
#define BRCM_SWDSGN_ETS_SMGROUPS_GLOBAL     (0xA401U)    /**< @brief #ETS_SMGroups    */
#define BRCM_SWDSGN_ETS_MODEINDEX_GLOBAL    (0xA402U)    /**< @brief #ETS_ModeIndex   */
#define BRCM_SWDSGN_ETS_TRANSMIT_PROC       (0xA403U)    /**< @brief #ETS_Transmit    */
/** @} */


/**
  Check to validate ETS operating modes
**/

#if !defined (ETS_MODULE_AVNU) && !defined (ETS_MODULE_IEEE2011)
#error No ETS operating modes enabled
#endif

/**
    @trace #BRCM_SWREQ_ETS_SM
    @trace #BRCM_SWARCH_ETS_SMGROUPS_GLOBAL
*/
const ETS_SMGroupType *ETS_SMGroups[ETS_OPERMODE_MAX] = {
#ifdef ETS_MODULE_AVNU
    &ETS_MODULE_AVNU, /* ETS_SMGroupAvnu */
#endif
#ifdef ETS_MODULE_IEEE2011
    &ETS_MODULE_IEEE2011, /* ETS_SMGroupIeee2011 */
#endif
};

/**
    @trace #BRCM_SWREQ_ETS_SM
    @trace #BRCM_SWARCH_ETS_MODEINDEX_GLOBAL
*/
uint32_t ETS_ModeIndex = ETS_OPERMODE_MAX;

/**
    @code{.unparsed}
#ifndef ENDPOINT
    ETS_TransmitSwitch()
#endif
    if (0UL != aLen) {
        if (1UL == aIsEventMsg) {
            NIF_EnableTxTimestamp(aBufIdx);
        }

        freeIdx= Allocate(&txWaitQ);
        txWaitQ[freeIdx].intfIdx    = aIntfIdx;
        txWaitQ[freeIdx].bufIdx     = aBufIdx;
        txWaitQ[freeIdx].pktType    = aPktType;
        txWaitQ[freeIdx].isEventMsg = aIsEventMsg;
    }
    NIF_Send(aBufIdx);
    @endcode
    @trace #BRCM_SWARCH_ETS_TRANSMIT_PROC
    @trace #BRCM_SWREQ_ETS_CORE
*/
int32_t ETS_Transmit(const uint32_t        aIntfNum,
                     const NIF_CntrlIDType aCtrlIdx,
                     const uint32_t        aBufIdx,
                     const uint32_t        aLen,
                     const uint32_t        aPktType,
                     const uint32_t        aIsEventMsg,
                     const uint8_t* const  aDstMacAddr)
{
    int32_t   rc      = BCM_ERR_OK;
    uint32_t  lineNum = 0UL;
    uint32_t  freeIdx = 0xFFUL;
    ETS_ContextType* hdl = ETS_GetHandle();

#ifdef ENABLE_ETH_SWITCH
    rc = ETS_TransmitSwitch(aIntfNum, aCtrlIdx, aBufIdx);
    if (BCM_ERR_OK != rc) {
        lineNum = __LINE__;
        /* Free the buffer */
        (void)NIF_Send(aCtrlIdx, ETHER_ETHERTYPE_GPTP, 1UL, aBufIdx, 0UL, aDstMacAddr);
        goto end;
    }
#endif

    if ((1UL == aIsEventMsg) && (0UL != aLen)){
        /* mark the packet for egress timestamping */
        rc = NIF_EnableTxTimestamp(aCtrlIdx, aBufIdx);
    }

    if(BCM_ERR_OK == rc) {
        /* Insert entry in the transmit wait queue to wait for TxConfirmation */
        if (0UL != aLen) {
            /* Store the bufIdx along with the pktType so that we can */
            /* identify the packet on a TxConfirmation                */
            freeIdx= ATOMIC_ClrNGetBit(&hdl->txWaitQAllocFlags);

            if (freeIdx < ETS_NUM_TX_WAITQ_PKTS) {
                hdl->txWaitPkts[freeIdx].intfIdx    = aIntfNum;
                hdl->txWaitPkts[freeIdx].bufIdx     = aBufIdx;
                hdl->txWaitPkts[freeIdx].pktType    = aPktType;
                hdl->txWaitPkts[freeIdx].isEventMsg = aIsEventMsg;
            } else {
                rc = BCM_ERR_NOMEM;
                lineNum = __LINE__;
                goto end;
            }
        }
        rc = NIF_Send(aCtrlIdx, ETHER_ETHERTYPE_GPTP, 1UL, aBufIdx, aLen, aDstMacAddr);
    } else {
        lineNum = __LINE__;
        /* Free the buffer */
        (void)NIF_Send(aCtrlIdx, ETHER_ETHERTYPE_GPTP, 1UL, aBufIdx, 0UL, aDstMacAddr);
    }
end:
    if (BCM_ERR_OK != rc) {
        ETS_ErrorReport(BRCM_SWARCH_ETS_TRANSMIT_PROC, rc, lineNum,
                        aIntfNum, aBufIdx, aLen);
        ETS_ErrorReport(BRCM_SWARCH_ETS_TRANSMIT_PROC, rc, aPktType, aIsEventMsg,
                        hdl->txWaitQAllocFlags, (uint32_t)freeIdx);
    }
    return rc;
}

/** @} */
