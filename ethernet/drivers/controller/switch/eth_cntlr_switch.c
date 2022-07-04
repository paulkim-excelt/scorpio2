/*****************************************************************************
 Copyright 2020 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_eth_cntlrdrv_switch_ifc_impl Ethernet Controller Switch Integration
    @ingroup grp_eth_cntlrdrv

    @addtogroup grp_eth_cntlrdrv_switch_ifc_impl
    @{
*/

#include <bcm_utils.h>
#include <bcm_err.h>
#include <eth_switch_osil.h>
#include "eth_cntlr_switch.h"

/**
    @name Ethernet Switch Driver design IDs
    @{
    @brief Design IDs for ethernet Switch Driver integration
*/
#define BRCM_SWDSGN_ETHER_CNTLRSWTTXADAPTBUFFER_PROC     (0xB901U)    /**< @brief #ETHER_CntlrSwtTxAdaptBuffer  */
#define BRCM_SWDSGN_ETHER_CNTLRSWTTXPROCESSFRAME_PROC    (0xB902U)    /**< @brief #ETHER_CntlrSwtTxProcessFrame */
#define BRCM_SWDSGN_ETHER_CNTLRSWTTXDONEIND_PROC         (0xB903U)    /**< @brief #ETHER_CntlrSwtTxDoneInd      */
#define BRCM_SWDSGN_ETHER_CNTLRSWTRXPROCESSFRAME_PROC    (0xB904U)    /**< @brief #ETHER_CntlrSwtRxProcessFrame */
#define BRCM_SWDSGN_ETHER_CNTLRSWTRXDONEIND_PROC         (0xB905U)    /**< @brief #ETHER_CntlrSwtRxDoneInd      */
/** @} */

/**
    @trace #BRCM_SWARCH_ETHER_CNTLRSWTTXADAPTBUFFER_PROC
    @trace #BRCM_SWREQ_ETHER_ETHSWT_INTEGRATION_SWITCH
*/
int32_t ETHER_CntlrSwtTxAdaptBuffer(ETHER_HwIDType aCntrlID,
                                    uint32_t aBufIdx,
                                    uint8_t ** const aDataInOut,
                                    uint32_t * const aLenInOut)
{
    return ETHSWT_TxAdaptBuffer(aCntrlID, aBufIdx, aDataInOut, aLenInOut);
}

/**
    @trace #BRCM_SWARCH_ETHER_CNTLRSWTTXPROCESSFRAME_PROC
    @trace #BRCM_SWREQ_ETHER_ETHSWT_INTEGRATION_SWITCH
*/
int32_t ETHER_CntlrSwtTxProcessFrame(ETHER_HwIDType aCntrlID,
                                     uint32_t aBufIdx,
                                     uint8_t ** const aDataInOut,
                                     uint32_t * const aLenInOut)
{
    return ETHSWT_TxProcessFrame(aCntrlID, aBufIdx, aDataInOut, aLenInOut);
}

/**
    @trace #BRCM_SWARCH_ETHER_CNTLRSWTTXDONEIND_PROC
    @trace #BRCM_SWREQ_ETHER_ETHSWT_INTEGRATION_SWITCH
*/
int32_t ETHER_CntlrSwtTxDoneInd(ETHER_HwIDType aCntrlID,
                                uint32_t aBufIdx)
{
    return ETHSWT_TxDoneInd (aCntrlID, aBufIdx);
}

/**
    @trace #BRCM_SWARCH_ETHER_CNTLRSWTRXPROCESSFRAME_PROC
    @trace #BRCM_SWREQ_ETHER_ETHSWT_INTEGRATION_SWITCH
*/
int32_t ETHER_CntlrSwtRxProcessFrame(ETHER_HwIDType aCntrlID,
                                     uint32_t aBufIdx,
                                     uint8_t ** const aDataInOut,
                                     uint32_t * const aLenInOut,
                                     uint32_t *const aIsMgmtFrameOnly)
{
    return ETHSWT_RxProcessFrame(aCntrlID, aBufIdx, aDataInOut, aLenInOut, aIsMgmtFrameOnly);
}

/**
    @trace #BRCM_SWARCH_ETHER_CNTLRSWTRXDONEIND_PROC
    @trace #BRCM_SWREQ_ETHER_ETHSWT_INTEGRATION_SWITCH
*/
int32_t ETHER_CntlrSwtRxDoneInd(ETHER_HwIDType aCntrlID,
                                uint32_t aBufIdx)
{
    return ETHSWT_RxDoneInd(aCntrlID, aBufIdx);
}

/** @} */

