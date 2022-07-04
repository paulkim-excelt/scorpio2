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

/** @defgroup grp_rpc_v2_udp_intf_il UDP Interface Integration Guide
    @ingroup grp_rpc_v2_udp

    @addtogroup grp_rpc_v2_udp_intf_il
    @{

    @file rpc_udp_osil.h
    @brief RPC UDP Intferface Integration Interfaces
    This header file contains the integration interface for RPC UDP Slave
    and UDP master modules

    @version 1.0 Initial Version
*/

#ifndef RPC_UDP_INTF_OSIL_H
#define RPC_UDP_INTF_OSIL_H

#include <stdint.h>
#include <inet_cfg.h>

/**
    @name RPC Integration Interface IDs
    @{
    @brief Integration Interface IDs for RPC UDP Interface

*/
#define BRCM_SWARCH_RPC_UDPINTFDATAEVENT_GLOBAL    (0x9300U)    /**< @brief #RPC_UDPIntfDataEvent   */
#define BRCM_SWARCH_RPC_UDPINTFCONFIG_TYPE         (0x9301U)    /**< @brief #RPC_UDPIntfConfigType  */
#define BRCM_SWARCH_RPC_UDP_SLAVE_CONFIG_GLOBAL    (0x9302U)    /**< @brief #RPC_UDPSlaveIntfConfig */
#define BRCM_SWARCH_RPC_UDP_SLAVE_SERVER_GLOBAL    (0x9303U)    /**< @brief #RPC_UDPSlaveServer     */
#define BRCM_SWARCH_RPC_UDP_SLAVE_TX_GLOBAL        (0x9304U)    /**< @brief #RPC_UDPSlaveTx         */
#define BRCM_SWARCH_RPC_UDP_SLAVE_RX_GLOBAL        (0x9305U)    /**< @brief #RPC_UDPSlaveRx         */
#define BRCM_SWARCH_RPC_UDP_SLAVE_STREAM0_GLOBAL   (0x9306U)    /**< @brief #RPC_UDPSlaveStrm0      */
#define BRCM_SWARCH_RPC_UDP_SLAVE_STREAM1_GLOBAL   (0x9307U)    /**< @brief #RPC_UDPSlaveStrm1      */
#define BRCM_SWARCH_RPC_UDP_MASTER_CONFIG_GLOBAL   (0x9308U)    /**< @brief #RPC_UDPMasterIntfConfig*/
#define BRCM_SWARCH_RPC_UDP_MASTER_SERVER_GLOBAL   (0x9309U)    /**< @brief #RPC_UDPMasterServer    */
#define BRCM_SWARCH_RPC_UDP_MASTER_TX_GLOBAL       (0x930AU)    /**< @brief #RPC_UDPMasterTx        */
#define BRCM_SWARCH_RPC_UDP_MASTER_RX_GLOBAL       (0x930BU)    /**< @brief #RPC_UDPMasterRx        */
#define BRCM_SWARCH_RPC_UDP_MASTER_STREAM0_GLOBAL  (0x930CU)    /**< @brief #RPC_UDPMasterStrm0     */
#define BRCM_SWARCH_RPC_UDP_MASTER_STREAM1_GLOBAL  (0x930DU)    /**< @brief #RPC_UDPMasterStrm1     */
/** @} */

/**
    @brief UDP interface data event

    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP
*/
extern const uint32_t RPC_UDPIntfDataEvent;

/**
    @brief RPC UDP interface end point and IP configuration

    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP
*/
typedef struct sRPC_UDPIntfConfigType {
    uint32_t   serverPayloadId;         /**< @brief TFTP server payload ID          */
    uint32_t   txPayloadId;             /**< @brief Transmit connection payload ID  */
    uint32_t   rxPayloadId;             /**< @brief Receive connection payload ID   */
    uint32_t   streamPayloadId[RPC_MEM_STREAM_COUNT];
                                        /**< @brief Stream payload IDs              */
    uint32_t   maxRetryCount;           /**< @brief TFTP retry count                */
    uint32_t   streamRetryIntervalMs;   /**< @brief TFTP Stream retry interval      */
    uint32_t   msgRetryIntervalMs;      /**< @brief TFTP Msg retry interval         */
} RPC_UDPIntfConfigType;

/**
    @brief RPC UDP interface configuration

    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP
*/
extern const RPC_UDPIntfConfigType RPC_UDPMasterIntfConfig;

/**
    @brief RPC UDP interface configuration

    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP
*/
extern const RPC_UDPIntfConfigType RPC_UDPSlaveIntfConfig;

/**
    @brief RPC UDP Streams Server

    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP
*/
extern const INET_SystemEndPointType RPC_UDPSlaveServer;

/**
    @brief RPC UDP Msg Tx Client

    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP
*/
extern const INET_SystemEndPointType RPC_UDPSlaveTx;

/**
    @brief RPC UDP Msg Rx Client

    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP
*/
extern const INET_SystemEndPointType RPC_UDPSlaveRx;

/**
    @brief RPC UDP Stream 0

    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP
*/
extern const INET_SystemEndPointType RPC_UDPSlaveStrm0;

/**
    @brief RPC UDP Stream 1

    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP
*/
extern const INET_SystemEndPointType RPC_UDPSlaveStrm1;

/**
    @brief RPC UDP interface configuration

    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP
*/
extern const INET_SystemEndPointType RPC_UDPMasterServer;

/**
    @brief RPC UDP Msg Tx

    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP
*/
extern const INET_SystemEndPointType RPC_UDPMasterTx;

/**
    @brief RPC UDP Msg Rx

    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP
*/
extern const INET_SystemEndPointType RPC_UDPMasterRx;

/**
    @brief RPC UDP Stream 0 Client

    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP
*/
extern const INET_SystemEndPointType RPC_UDPMasterStrm0;

/**
    @brief RPC UDP Stream 1 Client

    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP
*/
extern const INET_SystemEndPointType RPC_UDPMasterStrm1;

#endif /* RPC_UDP_INTF_OSIL_H */
/** @} */
