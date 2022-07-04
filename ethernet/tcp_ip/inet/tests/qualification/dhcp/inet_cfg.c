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
    @addtogroup grp_inet_il
    @{

    @file inet_cfg.c
    @brief Connections and endpoints for bcm8956x

    @version 1.0 updated group for #COMP_Function
    @version 0.1 Initial version
*/

#include <stdint.h>
#include <bcm_utils.h>
#include <ee.h>
#include <bcm_err.h>
#include <ulog.h>
#include <ethernet.h>
#include <system.h>
#include <inet_cfg.h>
#include <inet_osil.h>
#include "eecfg.h"
#include "dhcp.h"

/**
    @name INET Connection Architecture IDs
    @{
    @brief Architecture IDs for INET Connections
 */
#define BRCM_SWDSGN_INET_REASS0_GLOBAL                  (0xBD01U)    /**< @brief #INET_Reass0               */
#define BRCM_SWDSGN_INET_REASS1_GLOBAL                  (0xBD02U)    /**< @brief #INET_Reass1               */
#define BRCM_SWDSGN_INET_REASS2_GLOBAL                  (0xBD03U)    /**< @brief #INET_Reass2               */
#define BRCM_SWDSGN_INET_REASSEMBLYBUFFERPOOL_GLOBAL    (0xBD04U)    /**< @brief #INET_ReassemblyBufferPool */
#define BRCM_SWDSGN_INET_CACHEHWIDX0_GLOBAL             (0xBD05U)    /**< @brief #INET_CacheHwIdx0          */
#define BRCM_SWDSGN_INET_EXTIF_GLOBAL                   (0xBD06U)    /**< @brief #INET_ExtIf                */
#define BRCM_SWDSGN_INET_INTERFACES_GLOBAL              (0xBD07U)    /**< @brief #INET_Interfaces           */
#define BRCM_SWDSGN_INET_ENDPOINTS_GLOBAL               (0xBD08U)    /**< @brief #INET_EndPoints            */
#define BRCM_SWDSGN_INET_CONFIG_GLOBAL                  (0xBD09U)    /**< @brief #INET_Config               */
#define BRCM_SWDSGN_INET_DHCPCLIENT_GLOBAL              (0xBD0AU)    /**< @brief #INET_DHCPClient           */
/** @} */

/**
    @trace #BRCM_SWARCH_INET_UDPRECEIVEINDICATION_PROC
    @trace #BRCM_SWARCH_INET_GETREASSEMBLYBUFFER_PROC
    @trace #BRCM_SWARCH_INET_UPDATEREASSEMBLYBUFFER_PROC
    @trace #BRCM_SWARCH_INET_FREEREASSEMBLYBUFFER_PROC
    @trace #BRCM_SWARCH_INET_CLIENTACKREASSBUF_PROC
    @trace #BRCM_SWARCH_INET_PROCESSTIMERS_PROC
    @trace #BRCM_SWREQ_INET_SWITCH
*/
INET_DEFINE_REASS_BUF(INET_Reass0, (INET_Reass0Buf), (INET_Reass0Q), (INET_Reass0QBuf), (INET_Reass0QIdx), (INET_Reass0RW));

/**
    @trace #BRCM_SWARCH_INET_UDPRECEIVEINDICATION_PROC
    @trace #BRCM_SWARCH_INET_GETREASSEMBLYBUFFER_PROC
    @trace #BRCM_SWARCH_INET_UPDATEREASSEMBLYBUFFER_PROC
    @trace #BRCM_SWARCH_INET_FREEREASSEMBLYBUFFER_PROC
    @trace #BRCM_SWARCH_INET_CLIENTACKREASSBUF_PROC
    @trace #BRCM_SWARCH_INET_PROCESSTIMERS_PROC
    @trace #BRCM_SWREQ_INET_SWITCH
*/
INET_DEFINE_REASS_BUF(INET_Reass1, (INET_Reass1Buf), (INET_Reass1Q), (INET_Reass1QBuf), (INET_Reass1QIdx), (INET_Reass1RW));

/**
    @trace #BRCM_SWARCH_INET_UDPRECEIVEINDICATION_PROC
    @trace #BRCM_SWARCH_INET_GETREASSEMBLYBUFFER_PROC
    @trace #BRCM_SWARCH_INET_UPDATEREASSEMBLYBUFFER_PROC
    @trace #BRCM_SWARCH_INET_FREEREASSEMBLYBUFFER_PROC
    @trace #BRCM_SWARCH_INET_CLIENTACKREASSBUF_PROC
    @trace #BRCM_SWARCH_INET_PROCESSTIMERS_PROC
    @trace #BRCM_SWREQ_INET_SWITCH
*/
INET_DEFINE_REASS_BUF(INET_Reass2, (INET_Reass2Buf), (INET_Reass2Q), (INET_Reass2QBuf), (INET_Reass2QIdx), (INET_Reass2RW));

/**
    @trace #BRCM_SWARCH_INET_UDPRECEIVEINDICATION_PROC
    @trace #BRCM_SWARCH_INET_GETREASSEMBLYBUFFER_PROC
    @trace #BRCM_SWARCH_INET_UPDATEREASSEMBLYBUFFER_PROC
    @trace #BRCM_SWARCH_INET_FREEREASSEMBLYBUFFER_PROC
    @trace #BRCM_SWARCH_INET_CLIENTACKREASSBUF_PROC
    @trace #BRCM_SWARCH_INET_PROCESSTIMERS_PROC
    @trace #BRCM_SWREQ_INET_SWITCH
*/
static const INET_ReassemblyBufferType* const INET_ReassemblyBufferPool[]=
{
    &INET_Reass0,
    &INET_Reass1,
    &INET_Reass2,
};

/**
    @trace #BRCM_SWARCH_INET_INIT_PROC
    @trace #BRCM_SWARCH_INET_GETINTERFACE_PROC
    @trace #BRCM_SWARCH_INET_GETINTERFACEFORENDPOINT_PROC
    @trace #BRCM_SWARCH_INET_SEARCHINTERFACE_PROC
    @trace #BRCM_SWARCH_INET_ADDARPENTRY_PROC
    @trace #BRCM_SWARCH_INET_FINDARPENTRY_PROC
    @trace #BRCM_SWARCH_INET_REMOVEARPENTRY_PROC
    @trace #BRCM_SWARCH_INET_BUFAVAIL_PROC
    @trace #BRCM_SWREQ_INET_SWITCH
*/
static INET_ARPEntryType INET_CacheHwIdx0[INET_MAX_ENTRIES_ARPCACHE];

/**
    @trace #BRCM_SWARCH_INET_INIT_PROC
    @trace #BRCM_SWARCH_INET_GETINTERFACE_PROC
    @trace #BRCM_SWARCH_INET_GETINTERFACEFORENDPOINT_PROC
    @trace #BRCM_SWARCH_INET_SEARCHINTERFACE_PROC
    @trace #BRCM_SWARCH_INET_ADDARPENTRY_PROC
    @trace #BRCM_SWARCH_INET_FINDARPENTRY_PROC
    @trace #BRCM_SWARCH_INET_REMOVEARPENTRY_PROC
    @trace #BRCM_SWARCH_INET_BUFAVAIL_PROC
    @trace #BRCM_SWREQ_INET_SWITCH
*/
INET_DEFINE_INTERFACE(INET_ExtIf, (INET_CacheHwIdx0), (INET_ExtIfState),
                      (ETHER_HW_ID_0), (0U), (0U),
                      INET_IPADDRESSASSIGNMENT_DYNAMIC,
                      INET_IPADDRESS_INVALID,
                      (0U),
                      INET_IPADDRESS_INVALID
                      );

/**
    @trace #BRCM_SWARCH_INET_INIT_PROC
    @trace #BRCM_SWARCH_INET_GETINTERFACE_PROC
    @trace #BRCM_SWARCH_INET_GETINTERFACEFORENDPOINT_PROC
    @trace #BRCM_SWARCH_INET_SEARCHINTERFACE_PROC
    @trace #BRCM_SWARCH_INET_ADDARPENTRY_PROC
    @trace #BRCM_SWARCH_INET_FINDARPENTRY_PROC
    @trace #BRCM_SWARCH_INET_REMOVEARPENTRY_PROC
    @trace #BRCM_SWARCH_INET_BUFAVAIL_PROC
    @trace #BRCM_SWREQ_INET_SWITCH
*/
static const INET_SystemInterfaceType* const INET_Interfaces[] = {
    &INET_ExtIf,
};

/**
    @trace #BRCM_SWARCH_INET_GETINTERFACEFORENDPOINT_PROC
    @trace #BRCM_SWARCH_INET_GETENDPOINT_PROC
    @trace #BRCM_SWARCH_INET_UDPRECEIVEINDICATION_PROC
    @trace #BRCM_SWARCH_INET_ADDARPENTRY_PROC
    @trace #BRCM_SWARCH_INET_BUFAVAIL_PROC
    @trace #BRCM_SWREQ_INET_SWITCH
*/
INET_DEFINE_UDP_ENDPOINT(INET_DHCPClient, (INET_DHCPClientCtxt), (INET_DHCPClientCtxtQ),
                     (INET_DHCPClientCtxtQBuf), (INET_DHCPClientCtxtQIdx),
                     (BCM_NET_ID), (INET_PAYLOAD_ID0), (INET_INTERFACEID_0), (INET_EVENT_PROCESS_TASK), (UDP_RxEvent),
                     (INET_EVENT_PROCESS_TASK), (UDP_TxEvent), (2UL), (DHCP_CLIENT_PORT), (INET_IPADDRESS_INVALID), (DHCP_SERVER_PORT),
                     (INET_L4PROTO_UDP), (INET_DSCP_CS0));

/**
    @trace #BRCM_SWARCH_INET_GETINTERFACEFORENDPOINT_PROC
    @trace #BRCM_SWARCH_INET_GETENDPOINT_PROC
    @trace #BRCM_SWARCH_INET_UDPRECEIVEINDICATION_PROC
    @trace #BRCM_SWARCH_INET_ADDARPENTRY_PROC
    @trace #BRCM_SWARCH_INET_BUFAVAIL_PROC
    @trace #BRCM_SWREQ_INET_SWITCH
*/
static const INET_SystemEndPointType* const INET_EndPoints[] = {
    &INET_DHCPClient,
};

/**
    @trace #BRCM_SWARCH_INET_GETINTERFACEFORENDPOINT_PROC
    @trace #BRCM_SWARCH_INET_GETENDPOINT_PROC
    @trace #BRCM_SWARCH_INET_UDPRECEIVEINDICATION_PROC
    @trace #BRCM_SWARCH_INET_ADDARPENTRY_PROC
    @trace #BRCM_SWARCH_INET_BUFAVAIL_PROC
    @trace #BRCM_SWARCH_INET_INIT_PROC
    @trace #BRCM_SWARCH_INET_GETINTERFACE_PROC
    @trace #BRCM_SWARCH_INET_SEARCHINTERFACE_PROC
    @trace #BRCM_SWARCH_INET_FINDARPENTRY_PROC
    @trace #BRCM_SWARCH_INET_REMOVEARPENTRY_PROC
    @trace #BRCM_SWARCH_INET_GETREASSEMBLYBUFFER_PROC
    @trace #BRCM_SWARCH_INET_UPDATEREASSEMBLYBUFFER_PROC
    @trace #BRCM_SWARCH_INET_FREEREASSEMBLYBUFFER_PROC
    @trace #BRCM_SWARCH_INET_CLIENTACKREASSBUF_PROC
    @trace #BRCM_SWARCH_INET_PROCESSTIMERS_PROC
    @trace #BRCM_SWREQ_INET_SWITCH
*/
const INET_CfgType INET_Config = {
    .interfaces = INET_Interfaces,
    .intfCount = sizeof(INET_Interfaces)/sizeof(INET_SystemInterfaceType*),
    .endPoints = INET_EndPoints,
    .endPtCount = sizeof(INET_EndPoints)/sizeof(INET_SystemEndPointType*),
    .reassBufferPool = INET_ReassemblyBufferPool,
    .reassBufCount = sizeof(INET_ReassemblyBufferPool)/sizeof(INET_ReassemblyBufferType*),
};

/** @} */
