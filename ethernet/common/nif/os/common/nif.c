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
    @addtogroup grp_nif_impl
    @{
    @section sec_nif_overview NIF Overview

    Network Interface Layer (NIF) is an abstraction layer for the
    underlying network drivers such as Ethernet driver, Switch driver,
    transciever driver and the wirless driver. This layer abstracts all
    the client modules from the underlying network drivers.

    @file nif.c
    @brief NIF Common Implementation file

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
#include <nif_avb.h>
#include <nif_timestamp.h>
#include <eth_osil.h>
#include <ethxcvr_osil.h>
#if defined(ENABLE_WLAN)
#include <wl_eth.h>
#include <wl_eth_xcvr.h>
#endif
#include <ulog.h>
#if defined (ENABLE_NIF_FQTSS)
#include <nif_fqtss.h>
#endif
#include "nif_internal.h"

/**
    @name NIF Design IDs
    @{
    @brief Design IDs for NIF
*/
#define BRCM_SWDSGN_NIF_MAX_CLIENTS_MACRO             (0xA501U)    /**< @brief #NIF_MAX_CLIENTS           */
#define BRCM_SWDSGN_NIF_VLAN_TAG_SIZE_MACRO           (0xA502U)    /**< @brief #NIF_VLAN_TAG_SIZE         */
#define BRCM_SWDSGN_NIF_ETHERTYPE_SIZE_MACRO          (0xA503U)    /**< @brief #NIF_ETHERTYPE_SIZE        */
#define BRCM_SWDSGN_NIF_TXBUFINFO_GLOBAL              (0xA504U)    /**< @brief #NIF_TxBufInfo             */
#define BRCM_SWDSGN_NIF_COMP_GLOBAL                   (0xA505U)    /**< @brief #NIF_Comp                  */
#define BRCM_SWDSGN_NIF_CHECKCONFIG_PROC              (0xA506U)    /**< @brief #NIF_CheckConfig           */
#define BRCM_SWDSGN_NIF_GETCLIENTID_PROC              (0xA507U)    /**< @brief #NIF_GetClientID           */
#define BRCM_SWDSGN_NIF_GETCMNETHCONTROLLERID_PROC    (0xA508U)    /**< @brief #NIF_GetCmnEthControllerID */
#define BRCM_SWDSGN_NIF_GETTSETHCONTROLLERID_PROC     (0xA509U)    /**< @brief #NIF_GetTSEthControllerID  */
#define BRCM_SWDSGN_NIF_FINDSTREAMIDX_PROC            (0xA50AU)    /**< @brief #NIF_FindStreamIdx         */
#define BRCM_SWDSGN_NIF_INIT_PROC                     (0xA50BU)    /**< @brief #NIF_Init                  */
#define BRCM_SWDSGN_NIF_GETCTRLIDX_PROC               (0xA50CU)    /**< @brief #NIF_GetCtrlIdx            */
#define BRCM_SWDSGN_NIF_SETCTRLMODE_PROC              (0xA50DU)    /**< @brief #NIF_SetCtrlMode           */
#define BRCM_SWDSGN_NIF_GETCTRLMODE_PROC              (0xA50EU)    /**< @brief #NIF_GetCtrlMode           */
#define BRCM_SWDSGN_NIF_GETMACADDR_PROC               (0xA50FU)    /**< @brief #NIF_GetMacAddr            */
#define BRCM_SWDSGN_NIF_GETVLANID_PROC                (0xA510U)    /**< @brief #NIF_GetVlanID             */
#define BRCM_SWDSGN_NIF_GETTXBUFFER_PROC              (0xA511U)    /**< @brief #NIF_GetTxBuffer           */
#define BRCM_SWDSGN_NIF_SEND_PROC                     (0xA512U)    /**< @brief #NIF_Send                  */
#define BRCM_SWDSGN_NIF_ENABLETXTIMESTAMP_PROC        (0xA513U)    /**< @brief #NIF_EnableTxTimestamp     */
#define BRCM_SWDSGN_ETHER_RXIND_PROC                  (0xA514U)    /**< @brief #ETHER_RxInd               */
#define BRCM_SWDSGN_ETHER_TXDONEIND_PROC              (0xA515U)    /**< @brief #ETHER_TxDoneInd           */
#define BRCM_SWDSGN_NIF_REPORTERROR_PROC              (0xA516U)    /**< @brief #NIF_ReportError           */
/** @} */

/**
    @brief Maximum supported NIF clients

    @trace #BRCM_SWARCH_NIF_INIT_PROC
    @trace #BRCM_SWREQ_NIF_CONFIG
*/
#define NIF_MAX_CLIENTS                 (16UL)

/**
    @brief NIF VLAN tag size

    @trace #BRCM_SWARCH_NIF_GETTXBUFFER_PROC
    @trace #BRCM_SWARCH_NIF_SEND_PROC
    @trace #BRCM_SWREQ_NIF_CONFIG
*/
#define NIF_VLAN_TAG_SIZE               (4UL)

/**
    @brief NIF ethertype size

    @trace #BRCM_SWARCH_NIF_GETTXBUFFER_PROC
    @trace #BRCM_SWARCH_NIF_SEND_PROC
    @trace #BRCM_SWREQ_NIF_CONFIG
*/
#define NIF_ETHERTYPE_SIZE              (2UL)

/**
    @brief Allocate Tx buffer memory

    @trace #BRCM_SWARCH_NIF_GETTXBUFFER_PROC
    @trace #BRCM_SWARCH_NIF_SEND_PROC
    @trace #BRCM_SWARCH_NIF_TXBUFINFO_TYPE
    @trace #BRCM_SWREQ_NIF_INIT
*/
NIF_TxBufInfoType NIF_TxBufInfo[NIF_BUF_COUNT] COMP_SECTION(".bss.nif");

/**
    @brief NIF context memory

    @trace #BRCM_SWARCH_NIF_INIT_PROC
    @trace #BRCM_SWARCH_NIF_COMP_TYPE
    @trace #BRCM_SWREQ_NIF_INIT
*/
NIF_CompType NIF_Comp COMP_SECTION(".bss.nif");

/** @brief NIF Report Error

    @trace #BRCM_SWARCH_NIF_REPORTERROR_PROC
    @trace #BRCM_SWREQ_NIF_INIT
*/
void NIF_ReportError(NIF_CntrlIDType aCtrlIdx,
                      uint16_t aApiID, int32_t aError,
                      uint32_t aVal0, uint32_t aVal1)
{
    const uint32_t values[4] = {(uint32_t)(aCtrlIdx >> 32ULL),
                                (uint32_t)aCtrlIdx, aVal0, aVal1};
    BCM_ReportError(BCM_NIF_ID, 0U, aApiID, aError, 4UL, values);
}

/** @brief NIF check configuration

    Detailed description of COMP_FunctionPart

    @behavior Sync, Re-entrant

    @pre describe any pre-condition

    @param[in]      None

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             If Configuration is valid
    @retval     #BCM_ERR_INVAL_PARAMS   When configuration is invalid
    @retval     #BCM_ERR_NOMEM          When call back size is invalid

    @post describe post condition

    @trace #BRCM_SWARCH_NIF_INIT_PROC
    @trace #BRCM_SWREQ_NIF_INIT

    @limitations any limitations for this api

    Detailed design of this function to be populated here.
    Insert flowchart or pseudocode.
    @image html comp_flowchart.jpg
*/
static int32_t NIF_CheckConfig(void)
{
    int32_t retVal = BCM_ERR_OK;

    if ((NULL == NIF_CmnCtrlConfig.cmnCbTbl) && (0UL != NIF_CmnCtrlConfig.cmnCbTblSize)) {
        retVal = BCM_ERR_INVAL_PARAMS;
        goto done;
    }

    if (NIF_CmnCtrlConfig.cmnCbTblSize > NIF_MAX_CLIENTS) {
        retVal = BCM_ERR_NOMEM;
        goto done;
    }

    if ((NULL == NIF_TSCtrlConfig.tsCbTbl) && (0UL != NIF_TSCtrlConfig.tsCbTblSize)) {
        retVal = BCM_ERR_INVAL_PARAMS;
        goto done;
    }

    if (NIF_TSCtrlConfig.tsCbTblSize > NIF_MAX_CLIENTS) {
        retVal = BCM_ERR_NOMEM;
        goto done;
    }

    if ((NULL == NIF_AVBCtrlConfig.avbCbTbl) && (0UL != NIF_AVBCtrlConfig.avbCbTblSize)) {
        retVal = BCM_ERR_INVAL_PARAMS;
        goto done;
    }

    if (NIF_AVBCtrlConfig.avbCbTblSize > NIF_MAX_CLIENTS) {
        retVal = BCM_ERR_NOMEM;
        goto done;
    }

    if (((NULL == NIF_CmnCtrlConfig.cmnEthIntfTbl) && (0UL != NIF_CmnCtrlConfig.cmnEthIntfTblSize)) ||
        ((NULL == NIF_CmnCtrlConfig.cmnWlEthIntfTbl) && (0UL != NIF_CmnCtrlConfig.cmnWlEthIntfTblSize)) ||
        ((NULL == NIF_TSCtrlConfig.tsEthIntfTbl) && (0UL != NIF_TSCtrlConfig.tsEthIntfTblSize)) ||
        ((NULL == NIF_TSCtrlConfig.tsWlEthIntfTbl) && (0UL != NIF_TSCtrlConfig.tsWlEthIntfTblSize))){
        retVal = BCM_ERR_INVAL_PARAMS;
        goto done;
    }

done:
    return retVal;
}

/** @brief NIF get client ID

    @trace #BRCM_SWARCH_NIF_GETCLIENTID_PROC
    @trace #BRCM_SWREQ_NIF_INIT
*/
void NIF_GetClientID(NIF_CntrlIDType aCtrlIdx,
                      NIF_ClientIDType *const aClientID)
{
    uint16_t compID;
    uint8_t instID;

    if (aClientID != NULL) {
        compID = ((uint16_t)(((aCtrlIdx) & NIF_CTRLVAL_COMP_ID_MASK)
                              >> NIF_CTRLVAL_COMP_ID_SHIFT));
        instID = ((uint8_t)(((aCtrlIdx) & NIF_CTRLVAL_INST_ID_MASK)
                              >> NIF_CTRLVAL_INST_ID_SHIFT));
        *aClientID = NIF_CLIENT_ID(compID, instID);
    }
}

/** @brief NIF get controller ID

    @trace #BRCM_SWARCH_NIF_GETCMNETHCONTROLLERID_PROC
    @trace #BRCM_SWREQ_NIF_INIT
*/
const NIF_CmnEthIntfType* NIF_GetCmnEthControllerID(NIF_CntrlIDType aCtrlIdx)
{
    NIF_EthCntrlrType ctrlType;
    NIF_EthCntrlrIdxType ctrlIndex;
    const NIF_CmnEthIntfType *funcPtr = NULL;

    ctrlType = ((uint32_t)(((aCtrlIdx) & NIF_CTRLVAL_CNTRLRTYPE_MASK)
                                    >> NIF_CTRLVAL_CNTRLRTYPE_SHIFT));
    ctrlIndex = ((uint32_t)(((aCtrlIdx) & NIF_CTRLVAL_CNTRLRID_MASK)
                                    >> NIF_CTRLVAL_CNTRLRID_SHIFT));

    /* Check for configured type and index to be valid values and avoid */
    /* out of bound access                                              */
    if(((NIF_ETHCNTRLR_WIRED == ctrlType) &&
        (NIF_CmnCtrlConfig.cmnEthIntfTblSize <= ctrlIndex)) ||
       ((NIF_ETHCNTRLR_WIRELESS == ctrlType) &&
        (NIF_CmnCtrlConfig.cmnWlEthIntfTblSize <= ctrlIndex))){
       goto done;
    }

    switch(ctrlType){
        case NIF_ETHCNTRLR_WIRED:
            funcPtr = &NIF_CmnCtrlConfig.cmnEthIntfTbl[ctrlIndex];
            break;
        case NIF_ETHCNTRLR_WIRELESS:
            funcPtr = &NIF_CmnCtrlConfig.cmnWlEthIntfTbl[ctrlIndex];
            break;
        default:
            /* Handling default case */
            break;
    }

done:
    return funcPtr;
}

/** @brief NIF get controller ID

    @trace #BRCM_SWARCH_NIF_GETTSETHCONTROLLERID_PROC
    @trace #BRCM_SWREQ_NIF_INIT
*/
const NIF_TSEthIntfType* NIF_GetTSEthControllerID(NIF_CntrlIDType aCtrlIdx)
{
    NIF_EthCntrlrType ctrlType;
    NIF_EthCntrlrIdxType ctrlIndex;
    const NIF_TSEthIntfType *funcPtr = NULL;

    ctrlType = ((uint32_t)(((aCtrlIdx) & NIF_CTRLVAL_CNTRLRTYPE_MASK)
                                    >> NIF_CTRLVAL_CNTRLRTYPE_SHIFT));
    ctrlIndex = ((uint32_t)(((aCtrlIdx) & NIF_CTRLVAL_CNTRLRID_MASK)
                                    >> NIF_CTRLVAL_CNTRLRID_SHIFT));

    /* Check for configured type and index to be valid values and avoid */
    /* out of bound access                                              */
    if(((NIF_ETHCNTRLR_WIRED == ctrlType) &&
        (NIF_TSCtrlConfig.tsEthIntfTblSize <= ctrlIndex)) ||
       ((NIF_ETHCNTRLR_WIRELESS == ctrlType) &&
        (NIF_TSCtrlConfig.tsWlEthIntfTblSize <= ctrlIndex))){
       goto done;
    }

    switch(ctrlType){
        case NIF_ETHCNTRLR_WIRED:
            funcPtr = &NIF_TSCtrlConfig.tsEthIntfTbl[ctrlIndex];
            break;
        case NIF_ETHCNTRLR_WIRELESS:
            funcPtr = &NIF_TSCtrlConfig.tsWlEthIntfTbl[ctrlIndex];
            break;
        default:
            /* Handling default case */
            break;
    }

done:
    return funcPtr;
}

/** @brief NIF find stream index

    @trace #BRCM_SWARCH_NIF_FINDSTREAMIDX_PROC
    @trace #BRCM_SWREQ_NIF_STREAM_SHAPING
*/
#if defined (ENABLE_NIF_FQTSS)
int32_t  NIF_FindStreamIdx(NIF_ClientIDType aClientID,
                                  uint32_t *const aStreamIdx)
{
    int32_t   retVal = BCM_ERR_NOT_FOUND;
    uint32_t  i = 0UL;

    for (i = 0UL; i < NIF_CmnCtrlConfig.streamTblSize; ++i) {
        if (aClientID == NIF_CmnCtrlConfig.streamTbl[i]) {
            *aStreamIdx = i;
            retVal = BCM_ERR_OK;
            break;
        }
    }

    return retVal;
}
#endif

/**
    NIF Initialization function

    @trace #BRCM_SWARCH_NIF_INIT_PROC
    @trace #BRCM_SWREQ_NIF_INIT
*/
int32_t NIF_Init(void)
{
    int32_t retVal;
    uint32_t i;

    if (NIF_STATE_UNINIT != NIF_Comp.state) {
        retVal = BCM_ERR_INVAL_STATE;
        goto done;
    }

    /* Check config parameters */
    retVal = NIF_CheckConfig();
    if (BCM_ERR_OK == retVal) {

        for (i = 0UL; i < NIF_BUF_COUNT; i++) {
            NIF_TxBufInfo[i].bufState  = NIF_BUFSTATE_FREE;
            NIF_TxBufInfo[i].etherType = 0U;
            NIF_TxBufInfo[i].size      = 0UL;
            NIF_TxBufInfo[i].isTSed    = 0UL;
            NIF_TxBufInfo[i].ctrlIdx   = 0ULL;
        }

        /* Change the state to INIT */
        NIF_Comp.state = NIF_STATE_INIT;
        NIF_Comp.isWaitingForBuffer = 0UL;
        NIF_Comp.currentTimerPeriod = 0xFFFFFFFFUL;
        NIF_Comp.totalAVBReserved = 0UL;
    }

done:
    return retVal;
}

/**
    Get NIF controller index

    @trace #BRCM_SWARCH_NIF_GETCTRLIDX_PROC
    @trace #BRCM_SWREQ_NIF_TRANSMIT
*/
int32_t NIF_GetCtrlIdx(ETHER_VLANIDType aVlanID,
                       uint16_t aCompID,
                       uint8_t aInstID,
                       NIF_CntrlIDType *const aCtrlIdx)
{
    int32_t retVal = BCM_ERR_OK;
    NIF_ClientIDType clientID = NIF_CLIENT_ID(aCompID, aInstID);
    NIF_CntrlIDType ctrlIdx;
    NIF_CntrlrValType ethCtrlIdx = NIF_CNTRLRVAL_INVALID;
    uint32_t i;

    /* Find the ethernet controller for the client */
    for (i = 0UL; i < NIF_CmnCtrlConfig.cmnCbTblSize; i++) {
        if (clientID == NIF_CmnCtrlConfig.cmnCbTbl[i].clientID) {
            ethCtrlIdx = NIF_CmnCtrlConfig.cmnCbTbl[i].cntrlIndex;
            break;
        }
    }

    ctrlIdx = NIF_CTRL(aVlanID, clientID, ethCtrlIdx);

    if ((NULL == aCtrlIdx) || (ethCtrlIdx == NIF_CNTRLRVAL_INVALID)) {
        retVal = BCM_ERR_INVAL_PARAMS;
        NIF_ReportError(ctrlIdx, BRCM_SWARCH_NIF_GETCTRLIDX_PROC, retVal, 0UL, __LINE__);
        goto done;
    }

    if (NIF_STATE_INIT != NIF_Comp.state) {
        retVal = BCM_ERR_UNINIT;
        goto done;
    }

    *aCtrlIdx = ctrlIdx;

done:
    return retVal;
}

/**
    Set NIF controller mode

    @trace #BRCM_SWARCH_NIF_SETCTRLMODE_PROC
    @trace #BRCM_SWREQ_NIF_INIT
*/
int32_t NIF_SetCtrlMode(NIF_CntrlIDType aCtrlIdx,
                        ETHER_ModeType aMode)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;
    const NIF_CmnEthIntfType *ethFn = NULL;
    NIF_EthCntrlrIdxType ethCtrlIdx = NIF_GET_CONTROLLER_INDEX(aCtrlIdx);

    ethFn = NIF_GetCmnEthControllerID(aCtrlIdx);
    if(NULL != ethFn){
        retVal = ethFn->setMode(ethCtrlIdx, aMode);
    }
    return retVal;
}

/**
    Get NIF controller mode

    @trace #BRCM_SWARCH_NIF_GETCTRLMODE_PROC
    @trace #BRCM_SWREQ_NIF_QUERY
*/
int32_t NIF_GetCtrlMode(NIF_CntrlIDType aCtrlIdx,
                        ETHER_ModeType *const aMode)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;
    const NIF_CmnEthIntfType *ethFn = NULL;
    NIF_EthCntrlrIdxType ethCtrlIdx = NIF_GET_CONTROLLER_INDEX(aCtrlIdx);

    if (NULL == aMode) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        ethFn = NIF_GetCmnEthControllerID(aCtrlIdx);
        if(NULL != ethFn){
            retVal = ethFn->getMode(ethCtrlIdx, aMode);
        }
    }
    return retVal;
}

/**
    Get MAC address

    @trace #BRCM_SWARCH_NIF_GETMACADDR_PROC
    @trace #BRCM_SWREQ_NIF_QUERY
*/
int32_t NIF_GetMacAddr(NIF_CntrlIDType aCtrlIdx,
                       uint8_t *const aMacAddr)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;
    const NIF_CmnEthIntfType *ethFn = NULL;
    NIF_EthCntrlrIdxType ethCtrlIdx = NIF_GET_CONTROLLER_INDEX(aCtrlIdx);

    ethFn = NIF_GetCmnEthControllerID(aCtrlIdx);
    if(NULL != ethFn){
        retVal = ethFn->getMacAddr(ethCtrlIdx, aMacAddr);
    }
    return retVal;
}

/**
    Get VLAN ID

    @trace #BRCM_SWARCH_NIF_GETVLANID_PROC
    @trace #BRCM_SWREQ_NIF_QUERY
*/
int32_t NIF_GetVlanID(NIF_CntrlIDType aCtrlIdx,
                      ETHER_VLANIDType *const aVlanID)
{
    int32_t retVal = BCM_ERR_OK;

    if (NULL == aVlanID) {
        retVal = BCM_ERR_INVAL_PARAMS;
        goto done;
    }

    if (NIF_STATE_INIT != NIF_Comp.state) {
        retVal = BCM_ERR_UNINIT;
        goto done;
    }

    *aVlanID = ((ETHER_VLANIDType)(((aCtrlIdx) & NIF_CTRLVAL_VLAN_ID_MASK)
                                        >> NIF_CTRLVAL_VLAN_ID_SHIFT));

done:
    return retVal;
}

/**
    Get empty transmit buffer

    @trace #BRCM_SWARCH_NIF_GETTXBUFFER_PROC
    @trace #BRCM_SWREQ_NIF_TRANSMIT
*/
int32_t NIF_GetTxBuffer(NIF_CntrlIDType aCtrlIdx,
                        ETHER_EtherType aEtherType,
                        ETHER_PrioType aPriority,
                        uint32_t *const aBufIdx,
                        uint8_t **const aBuf,
                        uint32_t *const aLenInOut)
{
    int32_t retVal = BCM_ERR_OK;
    ETHER_VLANIDType vlanID;
    ETHER_PrioType priority = (aPriority & 0x7U);
    uint32_t i = NIF_CmnCtrlConfig.cmnCbTblSize;
    NIF_ClientIDType clientID;
#if defined (ENABLE_NIF_FQTSS)
    uint32_t streamIdx = NIF_FQTSS_MAX_STREAMS;
    uint32_t fqtssBytes;
#endif
    const NIF_CmnEthIntfType *ethFn = NULL;
    NIF_EthCntrlrIdxType ethCtrlIdx = NIF_GET_CONTROLLER_INDEX(aCtrlIdx);

    ethFn = NIF_GetCmnEthControllerID(aCtrlIdx);
    if(NULL == ethFn){
        goto done;
    }


    retVal = NIF_GetVlanID(aCtrlIdx, &vlanID);
    if (BCM_ERR_OK != retVal) {
        goto done;
    }

    NIF_GetClientID(aCtrlIdx, &clientID);

    /* Check that the Ethertype is allocated to the client */
    for (i = 0UL; i < NIF_CmnCtrlConfig.cmnCbTblSize; i++) {
        if ((clientID == NIF_CmnCtrlConfig.cmnCbTbl[i].clientID) &&
            (aEtherType == NIF_CmnCtrlConfig.cmnCbTbl[i].etherType)) {
            break;
        }
    }

    if (i == NIF_CmnCtrlConfig.cmnCbTblSize) {
        retVal = BCM_ERR_INVAL_PARAMS;
        goto done;
    }

    if (aPriority > 7U) {
        retVal = BCM_ERR_INVAL_PARAMS;
        goto done;
    }

#if defined (ENABLE_NIF_FQTSS)
    /* Check for available credits - in case shaping is enabled */
    if (BCM_ERR_OK == NIF_FindStreamIdx(clientID, &streamIdx)) {
        if (BCM_ERR_OK != NIF_FqtssGetBytes(streamIdx, aLenInOut)) {
            if ((NIF_Comp.totalAVBReserved > 0UL) &&
                (*aLenInOut > ((100UL - NIF_Comp.totalAVBReserved) * 15UL))) {
                *aLenInOut = (100UL - NIF_Comp.totalAVBReserved) * 15UL;
            }
        }
    } else {
        /* Unshaped/unreserved stream */
        if ((NIF_Comp.totalAVBReserved > 0UL) &&
            (*aLenInOut > ((100UL - NIF_Comp.totalAVBReserved) * 15UL))) {
            *aLenInOut = (100UL - NIF_Comp.totalAVBReserved) * 15UL;
        }
    }
    fqtssBytes = *aLenInOut;
#endif

    if ((vlanID >= ETHER_VLANID_MIN)
            && (vlanID <= ETHER_VLANID_MAX)){
        /* Space for VLAN tag */
        *aLenInOut += NIF_VLAN_TAG_SIZE;
    }
    /* Space for Ether type */
    *aLenInOut += NIF_ETHERTYPE_SIZE;

    if (*aLenInOut > 0UL) {
        retVal = ethFn->getTxBuf(ethCtrlIdx, priority, aBufIdx,
                                 aBuf, aLenInOut);
        if (BCM_ERR_OK != retVal) {
#if defined (ENABLE_NIF_FQTSS)
            if (streamIdx < NIF_FQTSS_MAX_STREAMS) {
                (void)NIF_FqtssConsumeBytes(streamIdx, fqtssBytes, 0UL);
            }
#endif
            goto done;
        }

        if ((vlanID >= ETHER_VLANID_MIN)
                && (vlanID <= ETHER_VLANID_MAX)){
            if (*aLenInOut > NIF_VLAN_TAG_SIZE) {
                *aLenInOut -= NIF_VLAN_TAG_SIZE;
                /* Insert VLAN tag */
                *((ETHER_EtherType *)(*aBuf)) = CPU_NativeToBE16(ETHER_ETHERTYPE_VLANTAG);
                *aBuf += 2UL;
                *((ETHER_VLANIDType *)(*aBuf)) =
                    CPU_NativeToBE16(0U | (priority << 13UL) | (vlanID & 0xFFFU));
                *aBuf += 2UL;
            } else {
                retVal = ethFn->sendTxBuf(ethCtrlIdx, FALSE, *aBufIdx, 0UL, NULL);
                if (BCM_ERR_OK != retVal) {
                    NIF_ReportError(aCtrlIdx, BRCM_SWARCH_NIF_GETTXBUFFER_PROC, retVal,
                                    *aBufIdx, __LINE__);
                }
                retVal = BCM_ERR_NOMEM;
#if defined (ENABLE_NIF_FQTSS)
                (void)NIF_FqtssConsumeBytes(streamIdx, fqtssBytes, 0UL);
#endif
                goto done;
            }
        }

        if (*aLenInOut > NIF_ETHERTYPE_SIZE) {
            *aLenInOut -= NIF_ETHERTYPE_SIZE;
            *((ETHER_EtherType *)(*aBuf)) = CPU_NativeToBE16(aEtherType);
            *aBuf += NIF_ETHERTYPE_SIZE;
        } else {
            retVal = ethFn->sendTxBuf(ethCtrlIdx, FALSE, *aBufIdx, 0UL, NULL);
            if (BCM_ERR_OK != retVal) {
                NIF_ReportError(aCtrlIdx, BRCM_SWARCH_NIF_GETTXBUFFER_PROC, retVal,
                        *aBufIdx, __LINE__);
            }
            retVal = BCM_ERR_NOMEM;
#if defined (ENABLE_NIF_FQTSS)
            (void)NIF_FqtssConsumeBytes(streamIdx, fqtssBytes, 0UL);
#endif
            goto done;
        }

        /* Update the state of the buffer */
        if (NIF_BUF_COUNT <= (*aBufIdx)) {
            NIF_ReportError(aCtrlIdx, BRCM_SWARCH_NIF_GETTXBUFFER_PROC, BCM_ERR_NOMEM,
                    *aBufIdx, __LINE__);
        } else {
            if (NIF_BUFSTATE_FREE != NIF_TxBufInfo[*aBufIdx].bufState) {
                NIF_ReportError(aCtrlIdx, BRCM_SWARCH_NIF_GETTXBUFFER_PROC,
                        BCM_ERR_INVAL_BUF_STATE,
                        *aBufIdx, NIF_TxBufInfo[*aBufIdx].bufState);
            } else {
                NIF_TxBufInfo[*aBufIdx].bufState = NIF_BUFSTATE_ALLOC;
                NIF_TxBufInfo[*aBufIdx].etherType = aEtherType;
                NIF_TxBufInfo[*aBufIdx].size = *aLenInOut;
                NIF_TxBufInfo[*aBufIdx].ctrlIdx = aCtrlIdx;
                ATOMIC_ClrBit(&NIF_Comp.isWaitingForBuffer, i);
            }
        }
#if defined (ENABLE_NIF_FQTSS)
    } else {
        retVal = BCM_ERR_NOMEM;
#endif
    }
done:
    if ((BCM_ERR_OK != retVal) && (i != NIF_CmnCtrlConfig.cmnCbTblSize)) {
        ATOMIC_SetBit(&NIF_Comp.isWaitingForBuffer, i);
    }
    return retVal;
}

/**
    Send Ethernet packet

    @trace #BRCM_SWARCH_NIF_SEND_PROC
    @trace #BRCM_SWREQ_NIF_TRANSMIT
*/
int32_t NIF_Send(NIF_CntrlIDType aCtrlIdx,
                 ETHER_EtherType aEtherType,
                 uint32_t aIsTxConfEnable,
                 uint32_t aBufIdx,
                 uint32_t aLen,
                 const uint8_t *const aDestMacAddr)
{
    int32_t retVal = BCM_ERR_OK;
    ETHER_VLANIDType vlanID;
    uint32_t len = aLen;
#if defined (ENABLE_NIF_FQTSS)
    uint32_t streamIdx = NIF_FQTSS_MAX_STREAMS;
    uint32_t i;
    uint32_t clientID;

    NIF_GetClientID(aCtrlIdx, &clientID);
#endif
    const NIF_CmnEthIntfType *ethFn = NULL;
    NIF_EthCntrlrIdxType ethCtrlIdx = NIF_GET_CONTROLLER_INDEX(aCtrlIdx);

    ethFn = NIF_GetCmnEthControllerID(aCtrlIdx);
    if (NULL == ethFn) {
        goto done;
    }

    if (NIF_STATE_INIT != NIF_Comp.state) {
        retVal = BCM_ERR_UNINIT;
        goto done;
    }

    retVal = NIF_GetVlanID(aCtrlIdx, &vlanID);
    if (BCM_ERR_OK != retVal) {
        goto done;
    }

    if (NIF_BUF_COUNT <= aBufIdx) {
        retVal = BCM_ERR_INVAL_PARAMS;
        NIF_ReportError(aCtrlIdx, BRCM_SWARCH_NIF_SEND_PROC, retVal, aBufIdx, __LINE__);
        goto done;
    }

    if (NIF_BUFSTATE_ALLOC != NIF_TxBufInfo[aBufIdx].bufState) {
        retVal = BCM_ERR_INVAL_BUF_STATE;
        NIF_ReportError(aCtrlIdx, BRCM_SWARCH_NIF_SEND_PROC, retVal, aBufIdx,
                        NIF_TxBufInfo[aBufIdx].bufState);
        goto done;
    }

    if (aEtherType != NIF_TxBufInfo[aBufIdx].etherType) {
        retVal = BCM_ERR_INVAL_PARAMS;
        NIF_ReportError(aCtrlIdx, BRCM_SWARCH_NIF_SEND_PROC, retVal, aBufIdx, __LINE__);
        NIF_ReportError(aCtrlIdx, BRCM_SWARCH_NIF_SEND_PROC, retVal,
                        NIF_TxBufInfo[aBufIdx].etherType, aEtherType);
        goto done;
    }

    if (aCtrlIdx != NIF_TxBufInfo[aBufIdx].ctrlIdx) {
        retVal = BCM_ERR_INVAL_PARAMS;
        NIF_ReportError(aCtrlIdx, BRCM_SWARCH_NIF_SEND_PROC, retVal, 0UL, __LINE__);
        NIF_ReportError(aCtrlIdx, BRCM_SWARCH_NIF_SEND_PROC, retVal,
                       (uint32_t)(NIF_TxBufInfo[aBufIdx].ctrlIdx >> 32UL),
                       (uint32_t)NIF_TxBufInfo[aBufIdx].ctrlIdx);
        goto done;
    }

    if (len > NIF_TxBufInfo[aBufIdx].size) {
        retVal = BCM_ERR_INVAL_PARAMS;
        NIF_ReportError(aCtrlIdx, BRCM_SWARCH_NIF_SEND_PROC, retVal, aBufIdx, __LINE__);
        NIF_ReportError(aCtrlIdx, BRCM_SWARCH_NIF_SEND_PROC, retVal,
                        NIF_TxBufInfo[aBufIdx].size, len);
        goto done;
    }

#ifdef ENABLE_ETHER_SEND_SYNC
    aIsTxConfEnable = FALSE;
    NIF_TxBufInfo[aBufIdx].bufState = NIF_BUFSTATE_FREE;
#else
    if (TRUE == aIsTxConfEnable) {
        NIF_TxBufInfo[aBufIdx].bufState = NIF_BUFSTATE_TX;
    } else {
        NIF_TxBufInfo[aBufIdx].bufState = NIF_BUFSTATE_FREE;
    }
#endif

    /* If len is zero free-up the packet */
    if (len != 0UL) {
#if defined (ENABLE_NIF_FQTSS)
        if (BCM_ERR_OK == NIF_FindStreamIdx(clientID, &streamIdx)) {
            NIF_FqtssConsumeBytes(streamIdx, NIF_TxBufInfo[aBufIdx].size, len);
        }
#endif

        if (vlanID >= ETHER_VLANID_MIN) {
            len += NIF_VLAN_TAG_SIZE + NIF_ETHERTYPE_SIZE; /* VLAN + EtherType */
        } else {
            len += NIF_ETHERTYPE_SIZE; /* EtherType */
        }
    } else {
        /* Free the NIF buf state */
        NIF_TxBufInfo[aBufIdx].bufState = NIF_BUFSTATE_FREE;
#if defined (ENABLE_NIF_FQTSS)
        if (BCM_ERR_OK == NIF_FindStreamIdx(clientID, &streamIdx)) {
            /* Release the bytes back to shaper */
            (void)NIF_FqtssConsumeBytes(streamIdx, NIF_TxBufInfo[aBufIdx].size, 0UL);
        }
        for (i = 0UL; i < NIF_CmnCtrlConfig.cmnCbTblSize; i++) {
            if ((aEtherType == NIF_CmnCtrlConfig.cmnCbTbl[i].etherType) &&
                (clientID == NIF_CmnCtrlConfig.cmnCbTbl[i].clientID)) {
                ATOMIC_SetBit(&NIF_Comp.isWaitingForBuffer, i);
                break;
            }
        }
#endif
    }

    retVal = ethFn->sendTxBuf(ethCtrlIdx, aIsTxConfEnable,
                              aBufIdx, len, aDestMacAddr);
done:
    return retVal;
}

/**
    Ethernet RX packet indication callback

    @trace #BRCM_SWARCH_ETHER_RXIND_PROC
    @trace #BRCM_SWREQ_ETHER_INDICATIONS_NIF
*/
void ETHER_RxInd(ETHER_HwIDType aID, const uint8_t *const aBuf,
                 uint32_t aLen, const uint8_t *const aSrcMacAddr,
                 const uint8_t *const aDestMacAddr)
{
    uint32_t i;
    ETHER_EtherType etherType;
    NIF_CntrlIDType ctrlIdx;
    uint32_t len = aLen;
    const uint8_t *buf = aBuf;
    uint32_t priority = 0UL;
    ETHER_VLANIDType vlanID = 0U;

    if (NIF_STATE_INIT != NIF_Comp.state) {
        NIF_ReportError(0ULL, BRCM_SWARCH_ETHER_RXIND_PROC, BCM_ERR_UNINIT,
                        NIF_Comp.state, __LINE__);
        goto done;
    }

    if (aID != NIF_CmnCtrlConfig.hwIdx) {
        NIF_ReportError(0ULL, BRCM_SWARCH_ETHER_RXIND_PROC, BCM_ERR_INVAL_PARAMS,
                        aID, __LINE__);
        goto done;
    }

    if ((aBuf != NULL) && (len >= ETHER_HDR_SIZE)) {
        /* Save Rx driver buffer pointer */
        NIF_Comp.rxBufInfo.drvBuf = buf;
        etherType = *((ETHER_EtherType *)(buf));
        etherType = CPU_BEToNative16(etherType);
        len -= 2UL;
        buf = &buf[2UL];
        /* Check if the packet is VLAN tagged */
        if(ETHER_ETHERTYPE_VLANTAG == etherType) {
            vlanID = *((ETHER_VLANIDType *)(buf));
            vlanID = CPU_BEToNative16(vlanID);
            priority = (uint32_t)(vlanID >> 13UL);
            vlanID &= 0xFFFU;
            /* Update the packet etherType skipping the VLAN tag */
            etherType = *((ETHER_EtherType *)(&buf[2UL]));
            etherType = CPU_BEToNative16(etherType);
            len -= 4UL;
            buf = &buf[4UL];
        }
        NIF_Comp.rxBufInfo.vlanID = vlanID;
        NIF_Comp.rxBufInfo.etherType = etherType;

        for (i = 0UL; i < NIF_CmnCtrlConfig.cmnCbTblSize; i++) {
            if (etherType == NIF_CmnCtrlConfig.cmnCbTbl[i].etherType) {
                ctrlIdx = NIF_CTRL(vlanID,
                                   NIF_CmnCtrlConfig.cmnCbTbl[i].clientID,
                                   NIF_CmnCtrlConfig.cmnCbTbl[i].cntrlIndex);
                if (NIF_CmnCtrlConfig.cmnCbTbl[i].rxCb != NULL) {
                    /* Save Rx Client buffer pointer */
                    NIF_Comp.rxBufInfo.clientBuf = buf;
                    NIF_CmnCtrlConfig.cmnCbTbl[i].rxCb(ctrlIdx, buf, len,
                            aSrcMacAddr, aDestMacAddr, priority);
                }
#if !defined(ENABLE_ETH_SWITCH) && !defined(ENABLE_WLAN)
                {
                    int32_t retVal;
                    ETHER_TimestampType ts;
                    ETHER_TimestampQualType tsQual;
                    if ((ETHER_ETHERTYPE_GPTP == etherType) &&
                        (NIF_TSCtrlConfig.tsCbTbl[i].rxTSCb != NULL) &&
                        (NIF_TSCtrlConfig.tsEthIntfTbl != NULL) &&
                        (NIF_TSCtrlConfig.tsEthIntfTbl[aID].getRxTS != NULL)) {
                        retVal = NIF_TSCtrlConfig.tsEthIntfTbl[aID].getRxTS(aID, aBuf, &ts, &tsQual);
                        if (BCM_ERR_OK == retVal) {
                            NIF_TSCtrlConfig.tsCbTbl[i].rxTSCb(ctrlIdx, buf, 0UL,
                                    &ts, &tsQual);
                        }
                    }
                }
#endif
                break;
            }
        }
    }

done:
    return ;
}

/**
    Ethernet TX packet send confirmation callback

    @trace #BRCM_SWARCH_ETHER_TXDONEIND_PROC
    @trace #BRCM_SWREQ_ETHER_INDICATIONS_NIF
*/
void ETHER_TxDoneInd(ETHER_HwIDType aID, uint32_t aBufIdx,
                     ETHER_ResultType aResult)
{
    uint32_t              i;
    NIF_TxBufInfoType     *txBufInfo = &NIF_TxBufInfo[aBufIdx];
    ETHER_EtherType       etherType;
    NIF_ClientIDType      clientID;
    NIF_CntrlIDType       ctrlIdx;

    if (NIF_STATE_INIT != NIF_Comp.state) {
        NIF_ReportError(0ULL, BRCM_SWARCH_ETHER_TXDONEIND_PROC, BCM_ERR_UNINIT,
                        NIF_Comp.state, __LINE__);
        goto done;
    }

    if (aID != NIF_CmnCtrlConfig.hwIdx) {
        NIF_ReportError(0ULL, BRCM_SWARCH_ETHER_TXDONEIND_PROC,
                        BCM_ERR_INVAL_PARAMS, aID, __LINE__);
        goto done;
    }

    if (NIF_BUFSTATE_TX != txBufInfo->bufState) {
        NIF_ReportError(0ULL, BRCM_SWARCH_ETHER_TXDONEIND_PROC,
                        BCM_ERR_INVAL_BUF_STATE, txBufInfo->bufState,
                        __LINE__);
        goto done;
    }

    if (ETHER_RESULT_SUCCESS != aResult) {
        NIF_ReportError(0ULL, BRCM_SWARCH_ETHER_TXDONEIND_PROC, BCM_ERR_UNKNOWN,
                        txBufInfo->bufState, __LINE__);
        goto done;
    }

    NIF_GetClientID(txBufInfo->ctrlIdx, &clientID);
    etherType = txBufInfo->etherType;

    for (i = 0UL; i < NIF_CmnCtrlConfig.cmnCbTblSize; i++) {
        if ((etherType == NIF_CmnCtrlConfig.cmnCbTbl[i].etherType) &&
            (clientID == NIF_CmnCtrlConfig.cmnCbTbl[i].clientID)) {
            if (NIF_CmnCtrlConfig.cmnCbTbl[i].txCb != NULL) {
                NIF_CmnCtrlConfig.cmnCbTbl[i].txCb(txBufInfo->ctrlIdx, aBufIdx);
            }
#if !defined(ENABLE_ETH_SWITCH) && !defined(ENABLE_WLAN)
            {
                ETHER_TimestampType ts;
                ETHER_TimestampQualType tsQual;
                int32_t retVal;
                if (TRUE == txBufInfo->isTSed) {
                    txBufInfo->isTSed = FALSE;
                    if ((NIF_TSCtrlConfig.tsCbTbl[i].txTSCb != NULL) &&
                        (NIF_TSCtrlConfig.tsEthIntfTbl != NULL) &&
                        (NIF_TSCtrlConfig.tsEthIntfTbl[aID].getRxTS != NULL)) {
                        /* Get Timestamp */
                        retVal = NIF_TSCtrlConfig.tsEthIntfTbl[aID].getTxTs(aID, aBufIdx, &ts, &tsQual);
                        if (BCM_ERR_OK == retVal) {
                            NIF_TSCtrlConfig.tsCbTbl[i].txTSCb(txBufInfo->ctrlIdx,
                                                      aBufIdx, 0UL, &ts,
                                                      &tsQual);
                        }
                    }
                }
            }
#endif
        } else {
            if ((NIF_AVBCtrlConfig.avbCbTbl[i].bufAvailCb != NULL) &&
                    (0UL != (NIF_Comp.isWaitingForBuffer  & (1UL << i)))) {
                /* Generate nif controller index */
                ctrlIdx = NIF_CTRL(0U, NIF_CmnCtrlConfig.cmnCbTbl[i].clientID,
                                   NIF_CmnCtrlConfig.cmnCbTbl[i].cntrlIndex);
                NIF_AVBCtrlConfig.avbCbTbl[i].bufAvailCb(ctrlIdx);
            }
        }
    }
done:
    txBufInfo->bufState = NIF_BUFSTATE_FREE;
    return ;
}


/** @} */
