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
/**
    @defgroup grp_rpc_v2_udp_osil_impl UDP Integration Reference
    @ingroup grp_rpc_v2_udp

    @addtogroup grp_rpc_v2_udp_osil_impl
    @{

    @file rpc_udp_osil.c
    @brief This file implements RPC UDP OSIL functionality

    @version 0.1 Initial version
*/

#include <rpc_udp_osil.h>
#include <ee.h>

/**
    @name RPC UDP OSIL Design IDs
    @{
    @brief Design IDs for RPC UDP OSIL
*/
#define BRCM_SWDSGN_RPC_UDPINTFDATAEVENT_GLOBAL     (0xEE01U)    /**< @brief #RPC_UDPIntfDataEvent   */
#define BRCM_SWDSGN_RPC_UDP_SLAVE_CONFIG_GLOBAL     (0xEE02U)    /**< @brief #RPC_UDPSlaveIntfConfig */
#define BRCM_SWDSGN_RPC_UDP_SLAVE_SERVER_GLOBAL     (0xEE03U)    /**< @brief #RPC_UDPSlaveServer     */
#define BRCM_SWDSGN_RPC_UDP_SLAVE_TX_GLOBAL         (0xEE04U)    /**< @brief #RPC_UDPSlaveTx         */
#define BRCM_SWDSGN_RPC_UDP_SLAVE_RX_GLOBAL         (0xEE05U)    /**< @brief #RPC_UDPSlaveRx         */
#define BRCM_SWDSGN_RPC_UDP_SLAVE_STREAM0_GLOBAL    (0xEE06U)    /**< @brief #RPC_UDPSlaveStrm0      */
#define BRCM_SWDSGN_RPC_UDP_SLAVE_STREAM1_GLOBAL    (0xEE07U)    /**< @brief #RPC_UDPSlaveStrm1      */
#define BRCM_SWDSGN_RPC_UDP_MASTER_CONFIG_GLOBAL    (0xEE08U)    /**< @brief #RPC_UDPMasterIntfConfig*/
#define BRCM_SWDSGN_RPC_UDP_MASTER_SERVER_GLOBAL    (0xEE09U)    /**< @brief #RPC_UDPMasterServer    */
#define BRCM_SWDSGN_RPC_UDP_MASTER_TX_GLOBAL        (0xEE0AU)    /**< @brief #RPC_UDPMasterTx        */
#define BRCM_SWDSGN_RPC_UDP_MASTER_RX_GLOBAL        (0xEE0BU)    /**< @brief #RPC_UDPMasterRx        */
#define BRCM_SWDSGN_RPC_UDP_MASTER_STREAM0_GLOBAL   (0xEE0CU)    /**< @brief #RPC_UDPMasterStrm0     */
#define BRCM_SWDSGN_RPC_UDP_MASTER_STREAM1_GLOBAL   (0xEE0DU)    /**< @brief #RPC_UDPMasterStrm1     */
/** @} */

/**
    @brief RPC UDP Event

    @trace #BRCM_SWARCH_RPC_UDPINTFDATAEVENT_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP
*/
const uint32_t RPC_UDPIntfDataEvent = RPC_UDPINTF_DATA_EVENT;

/**
    @brief RPC UDP configuration

    @trace #BRCM_SWARCH_RPC_UDP_SLAVE_CONFIG_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP
*/
const RPC_UDPIntfConfigType RPC_UDPSlaveIntfConfig = {
    .serverPayloadId = 0UL,
    .txPayloadId = 1UL,
    .rxPayloadId = 2UL,
    .streamPayloadId[0] = 3UL,
    .streamPayloadId[1] = 4UL,
    .maxRetryCount = RPC_TFTP_RETRY_COUNT,
    .streamRetryIntervalMs = RPC_TFTP_STREAM_RETRY_INTERVAL_MS,
    .msgRetryIntervalMs = RPC_TFTP_MSG_RETRY_INTERVAL_MS,
};

/**
    @brief RPC UDP configuration

    @trace #BRCM_SWARCH_RPC_UDP_MASTER_CONFIG_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP
*/
const RPC_UDPIntfConfigType RPC_UDPMasterIntfConfig = {
    .serverPayloadId = 5UL,
    .txPayloadId = 6UL,
    .rxPayloadId = 7UL,
    .streamPayloadId[0] = 8UL,
    .streamPayloadId[1] = 9UL,
    .maxRetryCount = RPC_TFTP_RETRY_COUNT,
    .streamRetryIntervalMs = RPC_TFTP_STREAM_RETRY_INTERVAL_MS,
    .msgRetryIntervalMs = RPC_TFTP_MSG_RETRY_INTERVAL_MS,
};

#ifdef INET_RPC_UDP_SLAVE_SERVER
/**
    @trace #BRCM_SWARCH_RPC_UDP_SLAVE_SERVER_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP
*/
INET_DEFINE_NULL_UDP_ENDPOINT(RPC_UDPSlaveServer, (RPC_UDPSlaveServerCtxt), (RPC_UDPSlaveServerCtxtQ),
              (RPC_UDPSlaveServerCtxtQBuf), (RPC_UDPSlaveServerCtxtQIdx),
              (BCM_RPC_ID), (INET_PAYLOAD_ID0), (RPC_TASK), (SystemEvent7),
              (RPC_TASK), (SystemEvent7), (3UL), (INET_L4PROTO_UDP), (INET_DSCP_CS0));
#endif

#ifdef INET_RPC_UDP_SLAVE_TX
/**
    @trace #BRCM_SWARCH_RPC_UDP_SLAVE_TX_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP
*/
INET_DEFINE_NULL_UDP_ENDPOINT(RPC_UDPSlaveTx, (RPC_UDPSlaveTxCtxt), (RPC_UDPSlaveTxCtxtQ),
              (RPC_UDPSlaveTxCtxtQBuf), (RPC_UDPSlaveTxCtxtQIdx),
              (BCM_RPC_ID), (INET_PAYLOAD_ID1), (RPC_TASK), (SystemEvent7),
              (RPC_TASK), (SystemEvent7), (3UL), (INET_L4PROTO_UDP), (INET_DSCP_CS0));
#endif

#ifdef INET_RPC_UDP_SLAVE_RX
/**
    @trace #BRCM_SWARCH_RPC_UDP_SLAVE_RX_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP
*/
INET_DEFINE_NULL_UDP_ENDPOINT(RPC_UDPSlaveRx, (RPC_UDPSlaveRxCtxt), (RPC_UDPSlaveRxCtxtQ),
              (RPC_UDPSlaveRxCtxtQBuf), (RPC_UDPSlaveRxCtxtQIdx),
              (BCM_RPC_ID), (INET_PAYLOAD_ID2), (RPC_TASK), (SystemEvent7),
              (RPC_TASK), (SystemEvent7), (3UL), (INET_L4PROTO_UDP), (INET_DSCP_CS0));
#endif

#ifdef INET_RPC_UDP_SLAVE_STRM0
/**
    @trace #BRCM_SWARCH_RPC_UDP_SLAVE_STREAM0_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP
*/
INET_DEFINE_NULL_UDP_ENDPOINT(RPC_UDPSlaveStrm0, (RPC_UDPSlaveStrm0Ctxt), (RPC_UDPSlaveStrm0CtxtQ),
              (RPC_UDPSlaveStrm0CtxtQBuf), (RPC_UDPSlaveStrm0CtxtQIdx),
              (BCM_RPC_ID), (INET_PAYLOAD_ID3), (RPC_TASK), (SystemEvent7),
              (RPC_TASK), (SystemEvent7), (3UL), (INET_L4PROTO_UDP), (INET_DSCP_CS0));
#endif

#ifdef INET_RPC_UDP_SLAVE_STRM1
/**
    @trace #BRCM_SWARCH_RPC_UDP_SLAVE_STREAM1_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP
*/
INET_DEFINE_NULL_UDP_ENDPOINT(RPC_UDPSlaveStrm1, (RPC_UDPSlaveStrm1Ctxt), (RPC_UDPSlaveStrm1CtxtQ),
              (RPC_UDPSlaveStrm1CtxtQBuf), (RPC_UDPSlaveStrm1CtxtQIdx),
              (BCM_RPC_ID), (INET_PAYLOAD_ID4), (RPC_TASK), (SystemEvent7),
              (RPC_TASK), (SystemEvent7), (3UL), (INET_L4PROTO_UDP), (INET_DSCP_CS0));
#endif

#ifdef INET_RPC_UDP_MASTER_SERVER
/**
    @trace #BRCM_SWARCH_RPC_UDP_MASTER_SERVER_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP
*/
INET_DEFINE_NULL_UDP_ENDPOINT(RPC_UDPMasterServer, (RPC_UDPMasterServerCtxt), (RPC_UDPMasterServerCtxtQ),
                     (RPC_UDPMasterServerCtxtQBuf), (RPC_UDPMasterServerCtxtQIdx),
                     (BCM_RPC_ID), (INET_PAYLOAD_ID5), (RPC_TASK), (SystemEvent7),
                     (RPC_TASK), (SystemEvent7), (3UL), (INET_L4PROTO_UDP), (INET_DSCP_CS0));
#endif

#ifdef INET_RPC_UDP_MASTER_TX
/**
    @trace #BRCM_SWARCH_RPC_UDP_MASTER_TX_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP
*/
INET_DEFINE_NULL_UDP_ENDPOINT(RPC_UDPMasterTx, (RPC_UDPMasterTxCtxt), (RPC_UDPMasterTxCtxtQ),
                     (RPC_UDPMasterTxCtxtQBuf), (RPC_UDPMasterTxCtxtQIdx),
                     (BCM_RPC_ID), (INET_PAYLOAD_ID6), (RPC_TASK), (SystemEvent7),
                     (RPC_TASK), (SystemEvent7), (3UL), (INET_L4PROTO_UDP), (INET_DSCP_CS0));
#endif

#ifdef INET_RPC_UDP_MASTER_RX
/**
    @trace #BRCM_SWARCH_RPC_UDP_MASTER_RX_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP
*/
INET_DEFINE_NULL_UDP_ENDPOINT(RPC_UDPMasterRx, (RPC_UDPMasterRxCtxt), (RPC_UDPMasterRxCtxtQ),
                     (RPC_UDPMasterRxCtxtQBuf), (RPC_UDPMasterRxCtxtQIdx),
                     (BCM_RPC_ID), (INET_PAYLOAD_ID7), (RPC_TASK), (SystemEvent7),
                     (RPC_TASK), (SystemEvent7), (3UL), (INET_L4PROTO_UDP), (INET_DSCP_CS0));
#endif

#ifdef INET_RPC_UDP_MASTER_STRM0
/**
    @trace #BRCM_SWARCH_RPC_UDP_MASTER_STREAM0_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP
*/
INET_DEFINE_NULL_UDP_ENDPOINT(RPC_UDPMasterStrm0, (RPC_UDPMasterStrm0Ctxt), (RPC_UDPMasterStrm0CtxtQ),
                     (RPC_UDPMasterStrm0CtxtQBuf), (RPC_UDPMasterStrm0CtxtQIdx),
                     (BCM_RPC_ID), (INET_PAYLOAD_ID8), (RPC_TASK), (SystemEvent7),
                     (RPC_TASK), (SystemEvent7), (3UL), (INET_L4PROTO_UDP), (INET_DSCP_CS0));
#endif

#ifdef INET_RPC_UDP_MASTER_STRM1
/**
    @trace #BRCM_SWARCH_RPC_UDP_MASTER_STREAM1_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP
*/
INET_DEFINE_NULL_UDP_ENDPOINT(RPC_UDPMasterStrm1, (RPC_UDPMasterStrm1Ctxt), (RPC_UDPMasterStrm1CtxtQ),
                     (RPC_UDPMasterStrm1CtxtQBuf), (RPC_UDPMasterStrm1CtxtQIdx),
                     (BCM_RPC_ID), (INET_PAYLOAD_ID9), (RPC_TASK), (SystemEvent7),
                     (RPC_TASK), (SystemEvent7), (3UL), (INET_L4PROTO_UDP), (INET_DSCP_CS0));
#endif

/** @} */
