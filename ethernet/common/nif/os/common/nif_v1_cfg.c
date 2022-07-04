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

#include <stdint.h>
#include <bcm_utils.h>
#include <ee.h>
#include <nif.h>
#include <nif_timestamp.h>
#include <nif_xcvr.h>
#include <nif_avb.h>
#ifdef ENABLE_WLAN
#include <wl_eth.h>
#include <wl_eth_xcvr.h>
#endif
#if defined(ENABLE_ETH_BRPHY)
#include <brphy_osil.h>
#endif
#if defined(ENABLE_1722) && defined(ENABLE_AVB_TALKER)
#include <avb_talker.h>
#endif
#if defined(ENABLE_1722) && defined(ENABLE_AVB_LISTENER)
#include <avb_listener.h>
#endif
#if defined(ENABLE_ETS) || defined(ENABLE_ETS_TEST)
#include <ets_osil.h>
#endif
#if defined(ENABLE_INET)
#include <inet_osil.h>
#endif

static const NIF_CmnCbTblType NIF_CmnCtrlCbTbl[] = {
#if defined(ENABLE_1722)
    {
        .clientID = NIF_CLIENT_ID(BCM_AVB_ID, 0U),
        .etherType = ETHER_ETHERTYPE_1722,
        .cntrlIndex = NIF_CNTRLR_ID(NIF_ETHCNTRLR_WIRED, 0U),
#if defined(ENABLE_AVB_LISTENER)
        .rxCb = AVBL_RxPktIndication,
#else
        .rxCb = NULL,
#endif
#if defined(ENABLE_AVB_TALKER)
        .txCb = AVBT_TxPktConfirmation,
#else
        .txCb = NULL,
#endif
    },
    {
        .clientID = NIF_CLIENT_ID(BCM_AVB_ID, 1U),
        .etherType = ETHER_ETHERTYPE_1722,
        .cntrlIndex = NIF_CNTRLR_ID(NIF_ETHCNTRLR_WIRED, 0U),
#if defined(ENABLE_AVB_LISTENER)
        .rxCb = AVBL_RxPktIndication,
#else
        .rxCb = NULL,
#endif
#if defined(ENABLE_AVB_TALKER)
        .txCb = AVBT_TxPktConfirmation,
#else
        .txCb = NULL,
#endif
    },
    {
        .clientID = NIF_CLIENT_ID(BCM_AVB_ID, 2U),
        .etherType = ETHER_ETHERTYPE_1722,
        .cntrlIndex = NIF_CNTRLR_ID(NIF_ETHCNTRLR_WIRED, 0U),
#if defined(ENABLE_AVB_LISTENER)
        .rxCb = AVBL_RxPktIndication,
#else
        .rxCb = NULL,
#endif
#if defined(ENABLE_AVB_TALKER)
        .txCb = AVBT_TxPktConfirmation,
#else
        .txCb = NULL,
#endif
    },
    {
        .clientID = NIF_CLIENT_ID(BCM_AVB_ID, 3U),
        .etherType = ETHER_ETHERTYPE_1722,
        .cntrlIndex = NIF_CNTRLR_ID(NIF_ETHCNTRLR_WIRED, 0U),
#if defined(ENABLE_AVB_LISTENER)
        .rxCb = AVBL_RxPktIndication,
#else
        .rxCb = NULL,
#endif
#if defined(ENABLE_AVB_TALKER)
        .txCb = AVBT_TxPktConfirmation,
#else
        .txCb = NULL,
#endif
    },
#endif /* ENABLE_1722 */
#if defined(ENABLE_INET)
    {
        .clientID = NIF_CLIENT_ID(BCM_NET_ID, 0U),
        .etherType = ETHER_ETHERTYPE_IP,
#ifdef ENABLE_WLAN
        .cntrlIndex = NIF_CNTRLR_ID(NIF_ETHCNTRLR_WIRELESS, 0U),
#else
        .cntrlIndex = NIF_CNTRLR_ID(NIF_ETHCNTRLR_WIRED, 0U),
#endif
        .rxCb = INET_RxIPv4Pkt,
        .txCb = INET_TxPktConfirmation,
    },
    {
        .clientID = NIF_CLIENT_ID(BCM_NET_ID, 0U),
        .etherType = ETHER_ETHERTYPE_ARP,
#ifdef ENABLE_WLAN
        .cntrlIndex = NIF_CNTRLR_ID(NIF_ETHCNTRLR_WIRELESS, 0U),
#else
        .cntrlIndex = NIF_CNTRLR_ID(NIF_ETHCNTRLR_WIRED, 0U),
#endif
        .rxCb = INET_RxARPPkt,
        .txCb = INET_TxPktConfirmation,
    },
#endif
#if defined(ENABLE_ETS) || defined(ENABLE_ETS_TEST)
    {
        .clientID = NIF_CLIENT_ID(BCM_ETS_ID, 0U),
        .etherType = ETHER_ETHERTYPE_GPTP,
#ifdef ENABLE_WLAN
        .cntrlIndex = NIF_CNTRLR_ID(NIF_ETHCNTRLR_WIRELESS, 0U),
#else
        .cntrlIndex = NIF_CNTRLR_ID(NIF_ETHCNTRLR_WIRED, 0U),
#endif
        .rxCb = ETS_RxPktIndication,
        .txCb = ETS_TxPktConfirmation,
    },
#endif
};

static const NIF_TSCbTblType NIF_TSCtrlCbTbl[] = {
#if defined(ENABLE_1722)
    {
        .rxTSCb = NULL,
        .txTSCb = NULL,
    },
    {
        .rxTSCb = NULL,
        .txTSCb = NULL,
    },
    {
        .rxTSCb = NULL,
        .txTSCb = NULL,
    },
    {
        .rxTSCb = NULL,
        .txTSCb = NULL,
    },
#endif /* ENABLE_1722 */
#if defined(ENABLE_INET)
    {
        .rxTSCb = NULL,
        .txTSCb = NULL,
    },
    {
        .rxTSCb = NULL,
        .txTSCb = NULL,
    },
#endif
#if defined(ENABLE_ETS) || defined(ENABLE_ETS_TEST)
    {
        .rxTSCb = ETS_RxPktTSIndication,
        .txTSCb = ETS_TxPktTSIndication,
    },
#endif
};

static const NIF_AVBCbTblType NIF_AVBCtrlCbTbl[] = {
#if defined(ENABLE_1722)
    {
#if defined(ENABLE_AVB_TALKER)
        .bufAvailCb = AVBT_BufAvailIndication,
#else
        .bufAvailCb = NULL,
#endif
    },
    {
#if defined(ENABLE_AVB_TALKER)
        .bufAvailCb = AVBT_BufAvailIndication,
#else
        .bufAvailCb = NULL,
#endif
    },
    {
#if defined(ENABLE_AVB_TALKER)
        .bufAvailCb = AVBT_BufAvailIndication,
#else
        .bufAvailCb = NULL,
#endif
    },
    {
#if defined(ENABLE_AVB_TALKER)
        .bufAvailCb = AVBT_BufAvailIndication,
#else
        .bufAvailCb = NULL,
#endif
    },
#endif /* ENABLE_1722 */
#if defined(ENABLE_INET)
    {
        .bufAvailCb = NULL,
    },
    {
        .bufAvailCb = NULL,
    },
#endif
#if defined(ENABLE_ETS) || defined(ENABLE_ETS_TEST)
    {
        .bufAvailCb = NULL,
    },
#endif
};

static const NIF_ClientIDType NIF_ClientStreamsTbl[] = {
#if defined(ENABLE_1722) && defined(ENABLE_AVB_TALKER)
    NIF_CLIENT_ID(BCM_AVB_ID, 0),
    NIF_CLIENT_ID(BCM_AVB_ID, 1),
    NIF_CLIENT_ID(BCM_AVB_ID, 2),
    NIF_CLIENT_ID(BCM_AVB_ID, 3),
#endif
};

static const NIF_CmnEthIntfType NIF_CmnEthIntfTbl[] = {
    {
        .getTxBuf = ETHER_GetTxBuffer,
        .sendTxBuf = ETHER_Send,
        .getMode = ETHER_GetMode,
        .getMacAddr = ETHER_GetMacAddr,
        .setMode = ETHER_SetMode,
    },
};

static const NIF_TSEthIntfType NIF_TSEthIntfTbl[] = {
    {
        .getTime = ETHER_GetTime,
        .getRxTS = ETHER_GetRxTimestamp,
        .getTxTs = ETHER_GetTxTimestamp,
        .enableTs = ETHER_EnableTxTimestamp,
        .setTime = ETHER_SetTime,
        .setCorrectionTime = ETHER_SetCorrectionTime,
        .setGPTimer = ETHER_SetGPTimer,
    },
};

static const NIF_CmnEthIntfType NIF_CmnWLEthIntfTbl[] = {
#ifdef ENABLE_WLAN
    {
        .getTxBuf = WLETH_GetTxBuffer,
        .sendTxBuf = WLETH_Send,
        .getMode = WLETH_GetMode,
        .getMacAddr = WLETH_GetMacAddr,
        .setMode = WLETH_SetMode,
    },
#endif
};

static const NIF_TSEthIntfType NIF_TSWLEthIntfTbl[] = {
#ifdef ENABLE_WLAN
    {
        .getTime = WLETH_GetTime,
        .getRxTS = WLETH_GetRxTimestamp,
        .getTxTs = WLETH_GetTxTimestamp,
        .enableTs = WLETH_EnableTxTimestamp,
        .setTime = WLETH_SetTime,
        .setCorrectionTime = WLETH_SetCorrectionTime,
        .setGPTimer = WLETH_SetGPTimer,
    },
#endif
};

static const NIF_XcvrIntfType NIF_XcvrIntfTbl[] = {
    {
        .getLinkState = ETHXCVR_GetLinkState,
        .getSQIValue = ETHXCVR_GetSQIValue,
    },
};

static const NIF_XcvrIntfType NIF_WLXcvrIntfTbl[] = {
#ifdef ENABLE_WLAN
    {
        .getLinkState = WLXCVR_GetLinkState,
        .getSQIValue = WLETH_XCVR_GetSQIValue,
    },
#endif
};

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
