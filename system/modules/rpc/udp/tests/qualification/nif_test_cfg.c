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
#include <stdint.h>
#include <bcm_err.h>
#include <bcm_utils.h>
#include <nif.h>
#include <nif_timestamp.h>
#include <nif_switch.h>
#include <nif_xcvr.h>
#include <nif_avb.h>

extern void INET_RxIPv4Pkt(NIF_CntrlIDType aCtrlIdx,
                           const uint8_t *const aBuf,
                           uint16_t aLen,
                           const uint8_t *const aSrcMacAddr,
                           const uint8_t *const aDestMacAddr,
                           uint32_t aPriority);

extern void INET_TxPktConfirmation (NIF_CntrlIDType aCtrlIdx,
                                    uint32_t aBufIdx);

extern void INET_RxARPPkt(NIF_CntrlIDType aCtrlIdx,
                          const uint8_t *const aBuf,
                          uint16_t aLen,
                          const uint8_t *const aSrcMacAddr,
                          const uint8_t *const aDestMacAddr,
                          uint32_t aPriority);

const NIF_CmnCbTblType NIF_CmnCtrlCbTbl[] = {
    {
        .clientID = NIF_CLIENT_ID(BCM_NET_ID, 0U),
        .etherType = ETHER_ETHERTYPE_IP,
        .cntrlIndex = NIF_CNTRLR_ID(NIF_ETHCNTRLR_WIRED, 0U),
        .rxCb = INET_RxIPv4Pkt,
        .txCb = INET_TxPktConfirmation,
    },
    {
        .clientID = NIF_CLIENT_ID(BCM_NET_ID, 0U),
        .etherType = ETHER_ETHERTYPE_ARP,
        .cntrlIndex = NIF_CNTRLR_ID(NIF_ETHCNTRLR_WIRED, 0U),
        .rxCb = INET_RxARPPkt,
        .txCb = INET_TxPktConfirmation,
    },
};

const NIF_SwitchCbTblType NIF_SwitchCtrlCbTbl[] = {
    {
        .rxMgmtInfoCb = NULL,
    },
    {
        .rxMgmtInfoCb = NULL,
    },
};

const NIF_TSCbTblType NIF_TSCtrlCbTbl[] = {
    {
        .rxTSCb = NULL,
        .txTSCb = NULL,
    },
    {
        .rxTSCb = NULL,
        .txTSCb = NULL,
    },
};

const NIF_AVBCbTblType NIF_AVBCtrlCbTbl[] = {
    {
        .bufAvailCb = NULL,
    },
    {
        .bufAvailCb = NULL,
    },
};

static const NIF_CmnEthIntfType NIF_CmnEthIntfTbl[] = {
    {
        .getTxBuf = ETHER_GetTxBuffer,
        .sendTxBuf = ETHER_Send,
        .getMacAddr = ETHER_GetMacAddr,
        .setMode = ETHER_SetMode,
        .getMode = ETHER_GetMode,
    },
};

static const NIF_CmnEthIntfType NIF_CmnWLEthIntfTbl[] = {
};

static const NIF_TSEthIntfType NIF_TSEthIntfTbl[] = {
    {
        .getTime = NULL,
        .getRxTS = NULL,
        .getTxTs = NULL,
        .enableTs = NULL,
        .setTime = NULL,
        .setCorrectionTime = NULL,
        .setGPTimer = NULL,
    },
};

static const NIF_TSEthIntfType NIF_TSWLEthIntfTbl[] = {
};

static const NIF_XcvrIntfType NIF_XcvrIntfTbl[] = {
#if (ETHXCVR_HW_ID_MAX > 0UL)
    {
        .getLinkState = ETHXCVR_GetLinkState,
        .getSQIValue = ETHXCVR_GetSQIValue,
    },
#endif
#if (ETHXCVR_HW_ID_MAX > 1UL)
    {
        .getLinkState = ETHXCVR_GetLinkState,
        .getSQIValue = ETHXCVR_GetSQIValue,
    },
#endif
#if (ETHXCVR_HW_ID_MAX > 2UL)
    {
        .getLinkState = ETHXCVR_GetLinkState,
        .getSQIValue = ETHXCVR_GetSQIValue,
    },
#endif
#if (ETHXCVR_HW_ID_MAX > 3UL)
    {
        .getLinkState = ETHXCVR_GetLinkState,
        .getSQIValue = ETHXCVR_GetSQIValue,
    },
#endif
#if (ETHXCVR_HW_ID_MAX > 4UL)
    {
        .getLinkState = ETHXCVR_GetLinkState,
        .getSQIValue = ETHXCVR_GetSQIValue,
    },
#endif
#if (ETHXCVR_HW_ID_MAX > 5UL)
    {
        .getLinkState = ETHXCVR_GetLinkState,
        .getSQIValue = ETHXCVR_GetSQIValue,
    },
#endif
#if (ETHXCVR_HW_ID_MAX > 6UL)
    {
        .getLinkState = ETHXCVR_GetLinkState,
        .getSQIValue = ETHXCVR_GetSQIValue,
    },
#endif
#if (ETHXCVR_HW_ID_MAX > 7UL)
    {
        .getLinkState = ETHXCVR_GetLinkState,
        .getSQIValue = ETHXCVR_GetSQIValue,
    },
#endif
};

static const NIF_XcvrIntfType NIF_WLXcvrIntfTbl[] = {
};

static const NIF_SwtIntfType NIF_SwtIntfTbl[] = {
#ifdef ENABLE_ETH_SWITCH
    {
        .enableTxTs = ETHSWT_EnableTxTimestamp,
    },
#endif
};

static const NIF_ClientIDType NIF_ClientStreamsTbl[] = {};

const NIF_CmnCtrlCfgType NIF_CmnCtrlConfig = {
    .hwIdx = 0UL,
    .cmnCbTbl = NIF_CmnCtrlCbTbl,
    .cmnCbTblSize = sizeof(NIF_CmnCtrlCbTbl)/sizeof(NIF_CmnCbTblType),
    .streamTbl = NIF_ClientStreamsTbl,
    .streamTblSize = sizeof(NIF_ClientStreamsTbl)/sizeof(NIF_ClientIDType),
    /* Ethernet driver interface function table */
    .cmnEthIntfTbl = NIF_CmnEthIntfTbl,
    .cmnEthIntfTblSize = sizeof(NIF_CmnEthIntfTbl)/sizeof(NIF_CmnEthIntfType),
    /* Wireless ethernet driver interface function table */
    .cmnWlEthIntfTbl = NIF_CmnWLEthIntfTbl,
    .cmnWlEthIntfTblSize = sizeof(NIF_CmnWLEthIntfTbl)/sizeof(NIF_CmnEthIntfType),
};

const NIF_CmnCfgType NIF_CmnConfig = {
    .cmnCtrlCfg = &NIF_CmnCtrlConfig,
};

const NIF_SwitchCtrlCfgType NIF_SwitchCtrlConfig = {
    .switchCbTbl = NIF_SwitchCtrlCbTbl,
    .switchCbTblSize = sizeof(NIF_SwitchCtrlCbTbl)/sizeof(NIF_SwitchCbTblType),
    /* Switch interface function table */
    .swtIntfTbl = NIF_SwtIntfTbl,
    .swtIntfTblSize = sizeof(NIF_SwtIntfTbl)/sizeof(NIF_SwtIntfType),
};

const NIF_SwitchCfgType NIF_SwitchConfig = {
    .switchCtrlCfg = &NIF_SwitchCtrlConfig,
};

const NIF_XcvrCtrlCfgType NIF_XcvrCtrlConfig = {
    /* XCVR interface function table */
    .xcvrIntfTbl = NIF_XcvrIntfTbl,
    .xcvrIntfTblSize = sizeof(NIF_XcvrIntfTbl)/sizeof(NIF_XcvrIntfType),
    /* Wireless XCVR interface function table */
    .wlXcvrIntfTbl = NIF_WLXcvrIntfTbl,
    .wlXcvrIntfTblSize = sizeof(NIF_WLXcvrIntfTbl)/sizeof(NIF_XcvrIntfType),
};

const NIF_XcvrCfgType NIF_XcvrConfig = {
    .xcvrCtrlCfg = &NIF_XcvrCtrlConfig,
};

const NIF_TSCtrlCfgType NIF_TSCtrlConfig = {
    .tsCbTbl = NIF_TSCtrlCbTbl,
    .tsCbTblSize = sizeof(NIF_TSCtrlCbTbl)/sizeof(NIF_TSCbTblType),
    .tsEthIntfTbl = NIF_TSEthIntfTbl,
    .tsEthIntfTblSize = sizeof(NIF_TSEthIntfTbl)/sizeof(NIF_TSEthIntfType),
    .tsWlEthIntfTbl = NIF_TSWLEthIntfTbl,
    .tsWlEthIntfTblSize = sizeof(NIF_TSWLEthIntfTbl)/sizeof(NIF_TSEthIntfType),
};

const NIF_TSCfgType NIF_TSConfig = {
    .tsCtrlCfg = &NIF_TSCtrlConfig,
};

const NIF_AVBCtrlCfgType NIF_AVBCtrlConfig = {
    .avbCbTbl = NIF_AVBCtrlCbTbl,
    .avbCbTblSize = sizeof(NIF_AVBCtrlCbTbl)/sizeof(NIF_AVBCbTblType),
};

const NIF_AVBCfgType NIF_AVBConfig = {
    .avbCtrlCfg = &NIF_AVBCtrlConfig,
};
