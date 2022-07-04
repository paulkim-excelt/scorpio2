/*****************************************************************************
 Copyright 2017-2019 Broadcom Limited.  All rights reserved.

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
    @addtogroup grp_inet_il
    @{

    @file ethif.c
    @brief Integration layer implementation of Internet Stack

    @version 1.0 updated group for #COMP_Function
    @version 0.1 Initial version
*/

#include <stdint.h>
#include <string.h>
#include "bcm_utils.h"
#include "bcm_err.h"
#include "nif.h"
#ifdef ENABLE_ETH_SWITCH
#include "nif_switch.h"
#endif
#include "eth_osil.h"
#include "inet_cfg.h"
#include "netif.h"

/**
    @name INET Library API IDs
    @{
    @brief Design IDs for INET IL
 */
#define BRCM_SWDSGN_INET_ETHER_MUT_MACRO          (0xA101U)    /**< @brief #INET_ETHER_MTU        */
#define BRCM_SWDSGN_INET_CHECKNIFCTRLIDX_PROC     (0xA102U)    /**< @brief #INET_CheckNIFCtrlIdx  */
#define BRCM_SWDSGN_INET_NETIFGETMACADDR_PROC     (0xA103U)    /**< @brief #INET_NetIfGetMACAddr  */
#define BRCM_SWDSGN_INET_NETIFGETMTU_PROC         (0xA104U)    /**< @brief #INET_NetIfGetMTU      */
#define BRCM_SWDSGN_INET_NETIFGETTXBUFFER_PROC    (0xA105U)    /**< @brief #INET_NetIfGetTxBuffer */
#define BRCM_SWDSGN_INET_NETIFPARSEHDR_PROC       (0xA106U)    /**< @brief #INET_NetIfParseHdr    */
#define BRCM_SWDSGN_INET_NETIFSEND_PROC           (0xA107U)    /**< @brief #INET_NetIfSend        */
/** @} */

/**
    @trace #BRCM_SWARCH_INET_NETIFGETMTU_PROC
    @trace #BRCM_SWREQ_INET
*/
#define INET_ETHER_MTU       (1500U)

/**
    @trace #BRCM_SWARCH_INET_NETIFGETTXBUFFER_PROC
    @trace #BRCM_SWARCH_INET_NETIFSEND_PROC
    @trace #BRCM_SWARCH_INET_NETIFGETMACADDR_PROC
    @trace #BRCM_SWREQ_INET
*/
static int32_t INET_CheckNIFCtrlIdx(INET_InterfaceStateType *const aIfObj)
{
    int32_t rc = BCM_ERR_OK;
    if (NIF_CNTRLIDTYPE_INVALID == aIfObj->nifCtrlIdx){
        rc = NIF_GetCtrlIdx(aIfObj->cfg.vlanConfig.vlan,
                BCM_NET_ID,
                0U,
                &aIfObj->nifCtrlIdx);
    }

    return rc;
}

/**
    @trace #BRCM_SWARCH_INET_NETIFGETMTU_PROC
    @trace #BRCM_SWREQ_INET
*/
uint16_t INET_NetIfGetMTU(const INET_InterfaceIdType aIntfId)
{
    return INET_ETHER_MTU;
}

/**
    @trace #BRCM_SWARCH_INET_NETIFGETTXBUFFER_PROC
    @trace #BRCM_SWREQ_INET
*/
int32_t INET_NetIfGetTxBuffer(const INET_InterfaceIdType aIntfId,
                              uint16_t aEtherType,
                              uint32_t* const aBufIdx,
                              uint8_t** aBuf,
                              uint32_t* const aLen)
{
    int32_t                    rc;
    INET_InterfaceStateType   *ifObj = NULL;

    rc = INET_GetInterface(aIntfId, &ifObj);
    if (BCM_ERR_OK == rc) {
        rc = INET_CheckNIFCtrlIdx(ifObj);
        if(BCM_ERR_OK == rc) {
            rc = NIF_GetTxBuffer(ifObj->nifCtrlIdx,
                                 aEtherType,
                                 ifObj->cfg.vlanConfig.pcp,
                                 aBufIdx,
                                 aBuf,
                                 aLen);
        }
    }

    return rc;
}

/**
    @trace #BRCM_SWARCH_INET_NETIFSEND_PROC
    @trace #BRCM_SWREQ_INET
*/
int32_t INET_NetIfSend(const INET_InterfaceIdType aIntfId,
                       uint16_t                   aEtherType,
                       const uint8_t *const       aDestMACAddr,
                       const uint32_t             aBufIdx,
                       uint8_t* const             aBuf,
                       const uint32_t             aLen)
{
    int32_t                    rc;
    INET_InterfaceStateType*   ifObj = NULL;

    rc = INET_GetInterface(aIntfId, &ifObj);
    if (BCM_ERR_OK == rc) {
        rc = INET_CheckNIFCtrlIdx(ifObj);
        if(BCM_ERR_OK == rc) {
#ifdef ENABLE_ETH_SWITCH
            rc = INET_SwtSetMgmtInfoForInet(ifObj->nifCtrlIdx, aBufIdx);
#endif
            if (BCM_ERR_OK == rc) {
                rc = NIF_Send(ifObj->nifCtrlIdx,
                              aEtherType,
                              TRUE,
                              aBufIdx,
                              aLen,
                              aDestMACAddr);
                if (BCM_ERR_OK == rc) {
                    /* Track the number of L2 packet transmitted */
                    ifObj->stats.txL2PktCount++;
                }
            }
        }
    }
    return rc;
}

/**
    @trace #BRCM_SWARCH_INET_NETIFGETMACADDR_PROC
    @trace #BRCM_SWREQ_INET
*/
int32_t INET_NetIfGetMACAddr(const INET_InterfaceIdType aIntfId,
                             uint8_t* const             aBuf)
{
    int32_t rc = BCM_ERR_OK;
    INET_InterfaceStateType *ifObj = NULL;

    rc = INET_GetInterface(aIntfId, &ifObj);
    if (BCM_ERR_OK == rc) {
        rc = INET_CheckNIFCtrlIdx(ifObj);
        if(BCM_ERR_OK == rc) {
            rc = NIF_GetMacAddr(ifObj->nifCtrlIdx,aBuf);
        }
    }
    return rc;
}

/**
    @trace #BRCM_SWARCH_INET_NETIFPARSEHDR_PROC
    @trace #BRCM_SWREQ_INET
*/
int32_t INET_NetIfParseHdr(NIF_CntrlIDType aCtrlIdx,
                           uint16_t* aVlan,
                           uint32_t* aHwIdx)
{
    int32_t retVal;

    *aHwIdx = NIF_GET_CONTROLLER_INDEX(aCtrlIdx);

    retVal = NIF_GetVlanID(aCtrlIdx, aVlan);

    return retVal;
}

/** @} */
