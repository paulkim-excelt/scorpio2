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
    @file nif_switch.c
    @brief NIF Switch Implementation file

    @version 0.1 Initial version
*/

#include <stddef.h>
#include <inttypes.h>
#include <bcm_err.h>
#include <system.h>
#include <bcm_utils.h>
#include <atomic.h>
#include <nif.h>
#include <nif_switch.h>
#include <nif_xcvr.h>
#include <nif_timestamp.h>
#include <eth_osil.h>
#include <eth_switch_osil.h>
#include "nif_internal.h"

/**
    @name NIF Switch Design IDs
    @{
    @brief Design IDs for NIF Switch
*/
#define BRCM_SWDSGN_ETHSWT_MGMTINFOIND_PROC        (0xA701U)    /**< @brief #ETHSWT_MgmtInfoInd    */
#define BRCM_SWDSGN_ETHSWT_TXTSIND_PROC            (0xA702U)    /**< @brief #ETHSWT_TxTSInd        */
#define BRCM_SWDSGN_ETHSWT_RXTSIND_PROC            (0xA703U)    /**< @brief #ETHSWT_RxTSInd        */
#define BRCM_SWDSGN_NIF_SWTSETMGMTINFO_PROC        (0xA704U)    /**< @brief #NIF_SwtSetMgmtInfo    */
#define BRCM_SWDSGN_NIF_SWITCHCTRLCONFIG_GLOBAL    (0xA705U)    /**< @brief #NIF_SwitchCtrlConfig  */
#define BRCM_SWDSGN_NIF_ENABLETXTIMESTAMP_PROC     (0xA706U)    /**< @brief #NIF_EnableTxTimestamp */
#define BRCM_SWDSGN_NIF_SWITCHTXBUFINFO_GLOBAL     (0xA707U)    /**< @brief #NIF_SwitchTxBufInfo   */
/** @} */

/**
    @brief Allocate Tx buffer memory

    @trace #BRCM_SWARCH_NIF_GETTXBUFFER_PROC
    @trace #BRCM_SWARCH_NIF_SEND_PROC
    @trace #BRCM_SWARCH_NIF_TXBUFINFO_TYPE
    @trace #BRCM_SWREQ_NIF_SWITCH_MANAGEMENT_INFO
*/
static NIF_SwitchTxBufInfoType NIF_SwitchTxBufInfo[NIF_BUF_COUNT] COMP_SECTION(".bss.nif");

/**
    @brief NIF AVB configuration memory

    @trace #BRCM_SWARCH_NIF_INIT_PROC
    @trace #BRCM_SWARCH_NIF_AVBCTRLCFG_TYPE
    @trace #BRCM_SWREQ_NIF_SWITCH_MANAGEMENT_INFO
*/
extern const NIF_SwitchCtrlCfgType NIF_SwitchCtrlConfig;

/**
    Enable Timestamping for transmit packet

    @trace #BRCM_SWARCH_NIF_ENABLETXTIMESTAMP_PROC
    @trace #BRCM_SWREQ_NIF_TIME_SWITCH
*/
int32_t NIF_EnableTxTimestamp(NIF_CntrlIDType aCtrlIdx,
                              uint32_t aBufIdx)
{
    int32_t retVal = BCM_ERR_OK;
    const NIF_TSEthIntfType *ethFn = NULL;
    NIF_EthCntrlrIdxType ethCtrlIdx = NIF_GET_CONTROLLER_INDEX(aCtrlIdx);

    ethFn = NIF_GetTSEthControllerID(aCtrlIdx);
    if (NULL == ethFn) {
        goto done;
    }

    if (NIF_BUF_COUNT <= aBufIdx) {
        retVal = BCM_ERR_INVAL_PARAMS;
        NIF_ReportError(aCtrlIdx, BRCM_SWARCH_NIF_ENABLETXTIMESTAMP_PROC, retVal,
                        aBufIdx, __LINE__);
        goto done;
    }

    if (NIF_BUFSTATE_ALLOC != NIF_TxBufInfo[aBufIdx].bufState) {
        retVal = BCM_ERR_INVAL_BUF_STATE;
        NIF_ReportError(aCtrlIdx, BRCM_SWARCH_NIF_ENABLETXTIMESTAMP_PROC, retVal,
                        aBufIdx, NIF_TxBufInfo[aBufIdx].bufState);
        goto done;
    }

    retVal = NIF_SwitchCtrlConfig.swtIntfTbl[0].enableTxTs(ethCtrlIdx, aBufIdx,
                               &(NIF_SwitchTxBufInfo[aBufIdx].mgmtInfo));

    if (BCM_ERR_OK == retVal) {
        NIF_TxBufInfo[aBufIdx].isTSed = TRUE;
    }
done:
    return retVal;
}

/**
    Set the management information

    @trace #BRCM_SWARCH_NIF_SWTSETMGMTINFO_PROC
    @trace #BRCM_SWREQ_NIF_SWITCH_MANAGEMENT_INFO
*/
int32_t NIF_SwtSetMgmtInfo(NIF_CntrlIDType aCtrlIdx,
                           uint32_t aBufIdx,
                           const ETHSWT_MgmtInfoType *const aMgmtInfo)
{
    int32_t retVal = BCM_ERR_OK;
    NIF_EthCntrlrIdxType ethCtrlIdx = NIF_GET_CONTROLLER_INDEX(aCtrlIdx);

    if (NIF_BUF_COUNT <= aBufIdx) {
        retVal = BCM_ERR_INVAL_PARAMS;
        NIF_ReportError(aCtrlIdx, BRCM_SWARCH_NIF_SWTSETMGMTINFO_PROC, retVal,
                        aBufIdx, __LINE__);
        goto done;
    }

    if (NIF_BUFSTATE_ALLOC != NIF_TxBufInfo[aBufIdx].bufState) {
        retVal = BCM_ERR_INVAL_BUF_STATE;
        NIF_ReportError(aCtrlIdx, BRCM_SWARCH_NIF_SWTSETMGMTINFO_PROC, retVal,
                        aBufIdx, NIF_TxBufInfo[aBufIdx].bufState);
        goto done;
    }

    NIF_SwitchTxBufInfo[aBufIdx].mgmtInfo = *aMgmtInfo;
    retVal = ETHSWT_SetMgmtInfo(ethCtrlIdx, aBufIdx,
                    &(NIF_SwitchTxBufInfo[aBufIdx].mgmtInfo));
done:
    return retVal;
}

/**
    Switch Management information call back

    @trace #BRCM_SWARCH_ETHSWT_MGMT_INFO_IND_PROC
    @trace #BRCM_SWREQ_ETHSWT_INDICATIONS
*/
void ETHSWT_MgmtInfoInd(ETHER_HwIDType aCntrlID,
                          const uint8_t *const aData,
                          const ETHSWT_MgmtInfoType *const aMgmtInfo)
{
    uint32_t i;
    NIF_CntrlIDType ctrlIdx;
    const uint8_t *buf = NIF_Comp.rxBufInfo.clientBuf;
    ETHER_VLANIDType vlanID = NIF_Comp.rxBufInfo.vlanID;
    ETHER_EtherType etherType = NIF_Comp.rxBufInfo.etherType;

    if (NIF_STATE_INIT != NIF_Comp.state) {
        NIF_ReportError(0ULL, BRCM_SWDSGN_ETHSWT_MGMTINFOIND_PROC, BCM_ERR_UNINIT,
                        NIF_Comp.state, __LINE__);
        goto done;
    }

    if (aCntrlID != NIF_CmnCtrlConfig.hwIdx) {
        NIF_ReportError(0ULL, BRCM_SWDSGN_ETHSWT_MGMTINFOIND_PROC,
                        BCM_ERR_INVAL_PARAMS, aCntrlID, __LINE__);
        goto done;
    }

    if ((NULL != aData) && (NULL != aMgmtInfo)) {
        /* Save Rx driver buffer pointer */
        if (aData != NIF_Comp.rxBufInfo.drvBuf) {
            NIF_ReportError(0ULL, BRCM_SWDSGN_ETHSWT_MGMTINFOIND_PROC,
                    BCM_ERR_INVAL_PARAMS, (uint32_t)aData,
                    (uint32_t)NIF_Comp.rxBufInfo.drvBuf);
            goto done;
        }

        for (i = 0UL; i < NIF_CmnCtrlConfig.cmnCbTblSize; i++) {
            if (etherType == NIF_CmnCtrlConfig.cmnCbTbl[i].etherType) {
                ctrlIdx = NIF_CTRL(vlanID,
                                   NIF_CmnCtrlConfig.cmnCbTbl[i].clientID,
                                   NIF_CmnCtrlConfig.cmnCbTbl[i].cntrlIndex);
                if (NIF_SwitchCtrlConfig.switchCbTbl[i].rxMgmtInfoCb != NULL) {
                    NIF_SwitchCtrlConfig.switchCbTbl[i].rxMgmtInfoCb(ctrlIdx, buf, aMgmtInfo);
                }
                break;
            }
        }
    }

done:
    return ;
}

/**
    Callback from switch driver to provide timestamp of TX packet

    @trace #BRCM_SWARCH_ETHSWT_TX_TS_IND_PROC
    @trace #BRCM_SWREQ_ETHSWT_INDICATIONS
*/
void ETHSWT_TxTSInd(ETHER_HwIDType aCntrlID,
                      uint32_t aBufIdx,
                      const ETHSWT_MgmtInfoType *const aMgmtInfo,
                      const ETHER_TimestampType *const aTS,
                      const ETHER_TimestampQualType* const aTSQual)
{
    uint32_t i;
    NIF_TxBufInfoType       *txBufInfo = &NIF_TxBufInfo[aBufIdx];
    NIF_SwitchTxBufInfoType *switchTxBufInfo = &NIF_SwitchTxBufInfo[aBufIdx];
    ETHER_EtherType       etherType;
    NIF_ClientIDType      clientID;

    if (NIF_STATE_INIT != NIF_Comp.state) {
        NIF_ReportError(0ULL, BRCM_SWDSGN_ETHSWT_TXTSIND_PROC,
                        BCM_ERR_UNINIT, NIF_Comp.state, __LINE__);
        goto done;
    }

    if (aCntrlID != NIF_CmnCtrlConfig.hwIdx) {
        NIF_ReportError(0ULL, BRCM_SWDSGN_ETHSWT_TXTSIND_PROC,
                        BCM_ERR_INVAL_PARAMS, aCntrlID,  __LINE__);
        goto done;
    }

    NIF_GetClientID(txBufInfo->ctrlIdx, &clientID);
    etherType = txBufInfo->etherType;

    for (i = 0UL; i < NIF_CmnCtrlConfig.cmnCbTblSize; i++) {
        if ((etherType == NIF_CmnCtrlConfig.cmnCbTbl[i].etherType) &&
            (clientID == NIF_CmnCtrlConfig.cmnCbTbl[i].clientID)) {
            if (TRUE == txBufInfo->isTSed) {
                txBufInfo->isTSed = FALSE;
                if (NIF_TSCtrlConfig.tsCbTbl[i].txTSCb != NULL) {
                    NIF_TSCtrlConfig.tsCbTbl[i].txTSCb(txBufInfo->ctrlIdx,
                            aBufIdx,
                            switchTxBufInfo->mgmtInfo.portIdx,
                            aTS, aTSQual);
                }
            }
            break;
        }
    }
done:
    return ;
}

/**
    Callback from switch driver to provide timestamp of RX packet

    @trace #BRCM_SWARCH_ETHSWT_RX_TS_IND_PROC
    @trace #BRCM_SWREQ_ETHSWT_MANAGEMENT
*/
void ETHSWT_RxTSInd(ETHER_HwIDType aCntrlID,
                      const uint8_t *const aData,
                      const ETHSWT_MgmtInfoType *const aMgmtInfo,
                      const ETHER_TimestampType *const aTS,
                      const ETHER_TimestampQualType* const aTSQual)
{
    uint32_t i;
    NIF_CntrlIDType ctrlIdx;
    const uint8_t *buf = NIF_Comp.rxBufInfo.clientBuf;
    ETHER_VLANIDType vlanID = NIF_Comp.rxBufInfo.vlanID;
    ETHER_EtherType etherType = NIF_Comp.rxBufInfo.etherType;

    if (NIF_STATE_INIT != NIF_Comp.state) {
        NIF_ReportError(0ULL, BRCM_SWDSGN_ETHSWT_RXTSIND_PROC, BCM_ERR_UNINIT,
                        NIF_Comp.state, __LINE__);
        goto done;
    }

    if (aCntrlID != NIF_CmnCtrlConfig.hwIdx) {
        NIF_ReportError(0ULL, BRCM_SWDSGN_ETHSWT_RXTSIND_PROC,
                        BCM_ERR_INVAL_PARAMS, aCntrlID, __LINE__);
        goto done;
    }

    if ((NULL != aData) && (NULL != aMgmtInfo)) {
        /* Save Rx driver buffer pointer */
        if (aData != NIF_Comp.rxBufInfo.drvBuf) {
            NIF_ReportError(0ULL, BRCM_SWDSGN_ETHSWT_RXTSIND_PROC,
                            BCM_ERR_INVAL_PARAMS, (uint32_t)aData,
                           (uint32_t)NIF_Comp.rxBufInfo.drvBuf);
            goto done;
        }

        for (i = 0UL; i < NIF_CmnCtrlConfig.cmnCbTblSize; i++) {
            if (etherType == NIF_CmnCtrlConfig.cmnCbTbl[i].etherType) {
                if (NIF_TSCtrlConfig.tsCbTbl[i].rxTSCb != NULL) {
                    ctrlIdx = NIF_CTRL(vlanID,
                                       NIF_CmnCtrlConfig.cmnCbTbl[i].clientID,
                                       NIF_CmnCtrlConfig.cmnCbTbl[i].cntrlIndex);
                    NIF_TSCtrlConfig.tsCbTbl[i].rxTSCb(ctrlIdx, buf, aMgmtInfo->portIdx,
                            aTS, aTSQual);
                }
                break;
            }
        }
    }

done:
    return ;
}

/** @} */
