/*****************************************************************************
 Copyright 2022 Broadcom Limited.  All rights reserved.

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
    @addtogroup grp_inet_test
    @{

    @file inet_cfg.c
    @brief Connections and endpoints for TCP test

    @version 0.1 Initial version
*/

#include <stdint.h>
#include <ee.h>
#include <bcm_err.h>
#include <system.h>
#include <inet_cfg.h>
#include <inet_osil.h>
#include "eecfg.h"

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
#define BRCM_SWDSGN_INET_SERVERIF_GLOBAL                (0xBD06U)    /**< @brief #INET_ServerIf             */
#define BRCM_SWDSGN_INET_CLIENTIF_GLOBAL                (0xBD07U)    /**< @brief #INET_ClientIf             */
#define BRCM_SWDSGN_INET_INTERFACES_GLOBAL              (0xBD08U)    /**< @brief #INET_Interfaces           */
#define BRCM_SWDSGN_INET_ENDPOINTS_GLOBAL               (0xBD09U)    /**< @brief #INET_EndPoints            */
#define BRCM_SWDSGN_INET_CONFIG_GLOBAL                  (0xBD0AU)    /**< @brief #INET_Config               */
#define BRCM_SWDSGN_INET_TCPSERVERLISTENER_GLOBAL       (0xBD0BU)    /**< @brief #INET_TCPServerListener    */
#define BRCM_SWDSGN_INET_TCPSERVERCONN_GLOBAL           (0xBD0CU)    /**< @brief #INET_TCPServerConn        */
#define BRCM_SWDSGN_INET_TCPCLIENT_GLOBAL               (0xBD0DU)    /**< @brief #INET_TCPClient            */
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

static INET_ARPEntryType INET_CacheHwIdx0[INET_MAX_ENTRIES_ARPCACHE] = {
    {
        .valid   = TRUE,
        .ipAddr  = (INET_CONVERT_IP_ADDRESS((192UL), (168UL), (10UL), (1UL))),
        .flags   = INET_ARPENTRYSTATE_STATIC,
        .macAddr = {0x0, 0x1, 0x2, 0x3, 0x4, 0x1},
    },
    {
        .valid   = TRUE,
        .ipAddr  = (INET_CONVERT_IP_ADDRESS((192UL), (168UL), (10UL), (2UL))),
        .flags   = INET_ARPENTRYSTATE_STATIC,
        .macAddr = {0x0, 0x1, 0x2, 0x3, 0x4, 0x2},
    },
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
INET_DEFINE_INTERFACE(INET_ClientIf, (INET_CacheHwIdx0), (INET_ClientIfState),
                      (ETHER_HW_ID_0), (0U), (0U),
                      INET_IPADDRESSASSIGNMENT_STATIC,
                      (INET_CONVERT_IP_ADDRESS((192U), (168U), (10U), (2U))),
                      (24U),
                      (INET_CONVERT_IP_ADDRESS((192U), (168U), (10U), (1U))));

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
INET_DEFINE_INTERFACE(INET_ServerIf, (INET_CacheHwIdx0), (INET_ServerIfState),
                      (ETHER_HW_ID_0), (0U), (0U),
                      INET_IPADDRESSASSIGNMENT_STATIC,
                      (INET_CONVERT_IP_ADDRESS((192U), (168U), (10U), (1U))),
                      (24U),
                      (INET_CONVERT_IP_ADDRESS((192U), (168U), (10U), (2U))));

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
    &INET_ServerIf,
    &INET_ClientIf,
};

/**
    @trace #BRCM_SWARCH_INET_GETINTERFACEFORENDPOINT_PROC
    @trace #BRCM_SWARCH_INET_GETENDPOINT_PROC
    @trace #BRCM_SWARCH_INET_UDPRECEIVEINDICATION_PROC
    @trace #BRCM_SWARCH_INET_ADDARPENTRY_PROC
    @trace #BRCM_SWARCH_INET_BUFAVAIL_PROC
    @trace #BRCM_SWREQ_INET_SWITCH
*/
INET_DEFINE_TCP_ENDPOINT(INET_TCPServerListener, (INET_TCPServerListenerCtxt),
                     (INET_TCPServerListenerCtxtQ), (INET_TCPServerListenerCtxtQBuf),
                     (INET_TCPServerListenerCtxtQIdx),
                     (INET_TCPServerListenerCtrlQ), (INET_TCPServerListenerCtrlHdrQ),
                     (INET_TCPServerListenerCtrlMsgs), (INET_TCPServerListenerCtrlGetMsg),
                     (BCM_NET_ID), (INET_PAYLOAD_ID0), (INET_INTERFACEID_0),
                     (TCPTestServerTask), (SystemEvent0),
                     (TCPTestServerTask), (SystemEvent1),
                     (INET_PORT_INVALID), (INET_IPADDRESS_INVALID), (INET_PORT_INVALID),
                     (INET_DSCP_CS0), (INET_TCPServerListenerTCPCtxt));

/**
    @trace #BRCM_SWARCH_INET_GETINTERFACEFORENDPOINT_PROC
    @trace #BRCM_SWARCH_INET_GETENDPOINT_PROC
    @trace #BRCM_SWARCH_INET_UDPRECEIVEINDICATION_PROC
    @trace #BRCM_SWARCH_INET_ADDARPENTRY_PROC
    @trace #BRCM_SWARCH_INET_BUFAVAIL_PROC
    @trace #BRCM_SWREQ_INET_SWITCH
*/
INET_DEFINE_TCP_ENDPOINT(INET_TCPServerConn, (INET_TCPServerConnCtxt),
                     (INET_TCPServerConnCtxtQ), (INET_TCPServerConnCtxtQBuf),
                     (INET_TCPServerConnCtxtQIdx),
                     (INET_TCPServerConnCtrlQ), (INET_TCPServerConnCtrlHdrQ),
                     (INET_TCPServerConnCtrlMsgs), (INET_TCPServerConnCtrlGetMsg),
                     (BCM_NET_ID), (INET_PAYLOAD_ID1), (INET_INTERFACEID_0),
                     (TCPTestServerTask), (SystemEvent2),
                     (TCPTestServerTask), (SystemEvent3),
                     (INET_PORT_INVALID), (INET_IPADDRESS_INVALID), (INET_PORT_INVALID),
                     (INET_DSCP_CS0), (INET_TCPServerConnTCPCtxt));

/**
    @trace #BRCM_SWARCH_INET_GETINTERFACEFORENDPOINT_PROC
    @trace #BRCM_SWARCH_INET_GETENDPOINT_PROC
    @trace #BRCM_SWARCH_INET_UDPRECEIVEINDICATION_PROC
    @trace #BRCM_SWARCH_INET_ADDARPENTRY_PROC
    @trace #BRCM_SWARCH_INET_BUFAVAIL_PROC
    @trace #BRCM_SWREQ_INET_SWITCH
*/
INET_DEFINE_TCP_ENDPOINT(INET_TCPClient, (INET_TCPClientCtxt),
                     (INET_TCPClientCtxtQ), (INET_TCPClientCtxtQBuf),
                     (INET_TCPClientCtxtQIdx),
                     (INET_TCPClientCtrlQ), (INET_TCPClientCtrlHdrQ),
                     (INET_TCPClientCtrlMsgs), (INET_TCPClientCtrlGetMsg),
                     (BCM_NET_ID), (INET_PAYLOAD_ID2), (INET_INTERFACEID_1),
                     (TCPTestClientTask), (SystemEvent0),
                     (TCPTestClientTask), (SystemEvent1),
                     (INET_PORT_INVALID), (INET_IPADDRESS_INVALID), (INET_PORT_INVALID),
                     (INET_DSCP_CS0), (INET_TCPClientTCPCtxt));

/**
    @trace #BRCM_SWARCH_INET_GETINTERFACEFORENDPOINT_PROC
    @trace #BRCM_SWARCH_INET_GETENDPOINT_PROC
    @trace #BRCM_SWARCH_INET_UDPRECEIVEINDICATION_PROC
    @trace #BRCM_SWARCH_INET_ADDARPENTRY_PROC
    @trace #BRCM_SWARCH_INET_BUFAVAIL_PROC
    @trace #BRCM_SWREQ_INET_SWITCH
*/
static const INET_SystemEndPointType* const INET_EndPoints[] = {
    &INET_TCPServerListener,
    &INET_TCPServerConn,
    &INET_TCPClient,
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
