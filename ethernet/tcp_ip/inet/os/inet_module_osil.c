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
    @defgroup grp_inet_module_osil_impl INET Module OSIL Implementation
    @ingroup grp_inet

    @addtogroup grp_inet_module_osil_impl
    @{

    @file inet_module_osil.c
    @brief This file implements INET specific module OSIL functionality
    for the INET module in Communication Subsystem

    @version 0.1 Initial draft
*/

#include <bcm_err.h>
#include <bcm_utils.h>
#include <inet_osil.h>
#include <inet_cfg.h>
#include <inet_osil.h>
#include <dhcp_osil.h>
#include <dhcp.h>
#include <ee.h>

/**
    @name INET module OSIL Design IDs
    @{
    @brief Design IDs for INET module OSIL
*/
#define BRCM_SWDSGN_INET_EVENTINFO_GLOBAL           (0xB201U)    /**< @brief #INET_EventInfo             */
#define BRCM_SWDSGN_INET_DHCPCONFIG_GLOBAL          (0xB202U)    /**< @brief #INET_DHCPConfig            */
#define BRCM_SWDSGN_INET_DHCPREPORTERROR_PROC       (0xB203U)    /**< @brief #INET_DHCPReportError           */
#define BRCM_SWDSGN_DHCP_OFFERRECEIVEDCALLBACK_PROC (0xB204U)    /**< @brief #DHCP_OfferReceivedCallback */
#define BRCM_SWDSGN_DHCP_UNBOUNDCALLBACK_PROC       (0xB205U)    /**< @brief #DHCP_UnBoundCallback       */
#define BRCM_SWDSGN_DHCP_BOUNDCALLBACK_PROC         (0xB206U)    /**< @brief #DHCP_BoundCallback         */
/** @} */

/**
    @trace #BRCM_SWARCH_INET_EVENTINFO_GLOBAL
    @trace #BRCM_SWREQ_INET_MODULE
*/
const INET_EventType INET_EventInfo = {
    .inetTimer = INET_TIMER_EVENT,
#if defined(ENABLE_INET_TCP)
    .tcpCtrl = INET_TCP_CTRL_EVENT,
#endif
#if defined (ENABLE_DHCP)
    .dhcpRx = INET_UDP_RX_EVENT,
    .dhcpTx = INET_UDP_TX_EVENT,
#endif
};

/** @brief DHCP configuration

    @trace #BRCM_SWARCH_INET_DHCPCONFIG_GLOBAL
    @trace #BRCM_SWREQ_INET_MODULE
*/
const DHCP_ConfigType INET_DHCPConfig = {
    .compID = BCM_NET_ID,
    .payloadID = INET_PAYLOAD_ID0,
    .leaseTime = DHCP_INFINITY_TIME,
    .maxRetries = 3U,
    .selectTimeout = 2000UL,
    .initialDelaySeed = 0UL,
    .initialRetryPeriod = 1000UL,
    .maxRetryPeriod = 8000UL,
    .clientIdLen = 0U,
    .vendorIdLen = 0U,
    .clientId = {0U},
    .hintFile = {0U},
    .vendorId = {0U},
};

/**
    @brief INET module error reporting API

    @trace #BRCM_SWARCH_INET_MODULE_GLOBAL
    @trace #BRCM_SWREQ_INET_MODULE

    @code{.unparsed}
    const uint32_t values[4UL] = {aVal0, aVal1, aVal2, aVal3}
    BCM_ReportError((BCM_NET_ID & BCM_LOGMASK_USER), 0U, aApiID,
                    aErr, 4UL, values)
    @endcode
*/
#if !defined(ENABLE_DHCP_TEST)
static void INET_DHCPReportError(uint16_t aApiID, int32_t aErr, uint32_t aVal0,
                                 uint32_t aVal1, uint32_t aVal2, uint32_t aVal3)
{
    const uint32_t values[4UL] = {aVal0, aVal1, aVal2, aVal3};
    BCM_ReportError((BCM_NET_ID & BCM_LOGMASK_USER), 0U, aApiID,
                     aErr, 4UL, values);
}

/** @brief DHCP offer received

    @trace #BRCM_SWARCH_DHCP_OFFERRECEIVEDCALLBACK_PROC
    @trace #BRCM_SWREQ_DHCP_CALLBACK

    @code{.unparsed}
    retVal = DHCP_SelectOffer(aOfferNum)
    if (BCM_ERR_OK != retVal)
        report error
    return
    @endcode
*/
void DHCP_OfferReceivedCallback(uint32_t aOfferNum)
{
    int32_t retVal;
    retVal = DHCP_SelectOffer(aOfferNum);
    if (BCM_ERR_OK != retVal) {
        INET_DHCPReportError(BRCM_SWDSGN_DHCP_OFFERRECEIVEDCALLBACK_PROC, retVal, __LINE__, 0UL, 0UL, 0UL);
    }
    return;
}

/** @brief DHCP client moves back to Init state

    @trace #BRCM_SWARCH_DHCP_UNBOUNDCALLBACK_PROC
    @trace #BRCM_SWREQ_DHCP_CALLBACK

    @code{.unparsed}
    INET_InterfaceVlanTagConfigType vlanCfg = { .pcp = 0, .vlan = 0 }
    ret = INET_UpdateInterface(INET_INTERFACEID_0, INET_IPADDRESSASSIGNMENT_DYNAMIC,
                               INET_IPADDRESS_INVALID, 0U,
                               INET_IPADDRESS_INVALID, &vlanCfg)
    if (BCM_ERR_OK != ret)
        report error
    return
    @endcode
*/
void DHCP_UnBoundCallback(void)
{
    int32_t ret;
    INET_InterfaceVlanTagConfigType vlanCfg = { .pcp = 0, .vlan = 0 };

    /* Release the IP address */
    ret = INET_UpdateInterface(INET_INTERFACEID_0, INET_IPADDRESSASSIGNMENT_DYNAMIC,
                               INET_IPADDRESS_INVALID, 0U,
                               INET_IPADDRESS_INVALID, &vlanCfg);
    if (BCM_ERR_OK != ret) {
        INET_DHCPReportError(BRCM_SWDSGN_DHCP_UNBOUNDCALLBACK_PROC, ret, __LINE__, 0UL, 0UL, 0UL);
    }
    return;
}

/** @brief DHCP client moves back to Bound state

    @trace #BRCM_SWARCH_DHCP_BOUNDCALLBACK_PROC
    @trace #BRCM_SWREQ_DHCP_CALLBACK

    @code{.unparsed}
    len = sizeof(myIP)
    ret = DHCP_GetParameter(0U, DHCP_PARAM_IPADDR, (uint8_t*)&myIP, &len)
    check and return on error

    len = sizeof(defaultRoute)
    ret = DHCP_GetParameter(0U, DHCP_PARAM_ROUTER, (uint8_t*)&defaultRoute, &len)
    check and return on error


    len = sizeof(netmask)
    ret = DHCP_GetParameter(0U, DHCP_PARAM_SUBNET_MASK, (uint8_t*)&netmask, &len)
    check and return on error

    ret = INET_GetEndPoint(INET_DHCPConfig.compID, INET_DHCPConfig.payloadID, &endPtIndex, &endPointObj)
    if (Success)
        ret = INET_GetInterfaceForEndPoint(endPtIndex, &intfObj)
        if (Success)
            Update the interface
            ret = INET_UpdateInterface()
            if (!Success)
                check and return on error
        else
            check and return on error
     else
        check and return on error
err:
    if (!Success)
        report error
    return
    @endcode
*/
void DHCP_BoundCallback(void)
{
    int32_t                         ret;
    INET_IPAddressType              myIP         = INET_IPADDRESS_INVALID;
    INET_IPAddressType              defaultRoute = INET_IPADDRESS_INVALID;
    INET_IPAddressType              netmask      = INET_IPADDRESS_INVALID;
    uint32_t                        len;
    INET_InterfaceVlanTagConfigType vlanCfg      = {.pcp = 0, .vlan = 0 };
    uint32_t                        lineVal      = 0UL;
    INET_EndPointIdType             endPtIndex   = 0U;
    const INET_EndPointObjectType  *endPointObj;
    INET_InterfaceStateType        *intfObj;

    len = sizeof(myIP);
    ret = DHCP_GetParameter(0U, DHCP_PARAM_IPADDR, (uint8_t*)&myIP, &len);
    if ((BCM_ERR_OK != ret) || (len != sizeof(myIP)) || (INET_IPADDRESS_INVALID == myIP)) {
        lineVal = __LINE__;
        goto err;
    }

    len = sizeof(defaultRoute);
    ret = DHCP_GetParameter(0U, DHCP_PARAM_ROUTER, (uint8_t*)&defaultRoute, &len);
    if ((BCM_ERR_OK != ret) || (len != sizeof(defaultRoute)) || (INET_IPADDRESS_INVALID == defaultRoute)) {
        lineVal = __LINE__;
        goto err;
    }

    len = sizeof(netmask);
    ret = DHCP_GetParameter(0U, DHCP_PARAM_SUBNET_MASK, (uint8_t*)&netmask, &len);
    if ((BCM_ERR_OK != ret) || (len != sizeof(netmask)) || (INET_IPADDRESS_INVALID == netmask)) {
        lineVal = __LINE__;
        goto err;
    }

    ret = INET_GetEndPoint(INET_DHCPConfig.compID, INET_DHCPConfig.payloadID, &endPtIndex, &endPointObj);
    if (BCM_ERR_OK == ret) {
        ret = INET_GetInterfaceForEndPoint(endPtIndex, &intfObj);
        if (BCM_ERR_OK == ret) {
            /* Update the interface */
            ret = INET_UpdateInterface(intfObj->ifID, INET_IPADDRESSASSIGNMENT_DYNAMIC,
                    myIP, (32U - (uint8_t)CORTEX_Clz(CORTEX_BitReverse(netmask))),
                    defaultRoute, &vlanCfg);
            if (BCM_ERR_OK != ret) {
                lineVal = __LINE__;
                goto err;
            } else {
                /* TODO : Print DHCP IP? */
            }
        } else {
            lineVal = __LINE__;
        }
    } else {
        lineVal = __LINE__;
    }

err:
    if (BCM_ERR_OK != ret) {
        INET_DHCPReportError(BRCM_SWDSGN_DHCP_BOUNDCALLBACK_PROC, ret, myIP, netmask, defaultRoute, lineVal);
    }
    return;
}
#endif

/** @} */
