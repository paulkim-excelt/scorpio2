/*****************************************************************************
 Copyright 2020-2021 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_security_qt Qualification Tests
    @ingroup grp_ethswt

    @addtogroup grp_security_qt
    @{

    @file security_qt.h
    @brief Security Integration Test
    This file contains test cases and test sequences for Layer 2/Layer 3
    Security feature for BCM89561X family of devices.
    @version 0.1 Initial version
*/

#ifndef SECURITY_QT_H
#define SECURITY_QT_H

/**
    @brief Enable "MAC Address sticky to a port".

    @pre
        -# INET client should be registered
        -# VlanId(1024U) should be added in NIF_CtrlVlanArray

    @test If "MAC Address sticky to a port" feature is enabled, then
          any packet arriving with MAC-SA which is sticky to
          that port should be allowed.

    @post
        -# All transmitted packets with MAC-SA sticky to that port
         should be received.

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_ETHSWT_SECURITY
*/
#define BRCM_SWQTST_ETHSWT_STICKY_MAC_ENABLE_MATCH_SA                    (0x301UL)

/**
    @brief Enable "MAC Address sticky to a port" with
           action as "Drop packet".

    @pre
        -# INET client should be registered
        -# VlanId(1024U) should be added in NIF_CtrlVlanArray

    @test If "MAC Address sticky to a port" feature is enabled with
          action as "Drop packet", then any packet arriving with MAC-SA
          which is not sticky to that port should be dropped.

    @post
        -# All transmitted packets with MAC-SA not sticky to that port
         should be dropped.

    @functional     Yes

    @type           Neg

    @trace #BRCM_SWREQ_ETHSWT_SECURITY
*/
#define BRCM_SWQTST_ETHSWT_STICKY_MAC_ENABLE_DROP_PKT                    (0x302UL)

/**
    @brief Enable "MAC Address sticky to a port" with
           action as "Redirect to CPU".

    @pre
        -# INET client should be registered
        -# VlanId(1024U) should be added in NIF_CtrlVlanArray

    @test If "MAC Address sticky to a port" feature is enabled with
          action as "Redirect to CPU", then any packet arriving with MAC-SA
          which is not sticky to that port should be redirected to IMP
          port.

    @post
        -# All transmitted packets with MAC-SA not sticky to that port
         should be redirected to IMP port.

    @functional     Yes

    @type           Neg

    @trace #BRCM_SWREQ_ETHSWT_SECURITY
*/
#define BRCM_SWQTST_ETHSWT_STICKY_MAC_ENABLE_REDIRECT_TO_CPU             (0x303UL)

/**
    @brief Disable "MAC Address sticky to a port".

    @pre
        -# INET client should be registered
        -# VlanId(1024U) should be added in NIF_CtrlVlanArray

    @test If "MAC Address sticky to a port" feature is disabled, then
          any packet arriving with any valid MAC-SA should be allowed.

    @post
        -# All transmitted packets should be received.

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_ETHSWT_SECURITY
*/
#define BRCM_SWQTST_ETHSWT_STICKY_MAC_DISABLE                            (0x304UL)

/**
    @brief Enable "Address Limiting" with
           action as "Drop packet".

    @pre
        -# INET client should be registered
        -# VlanId(1024U) should be added in NIF_CtrlVlanArray

    @test If "Address Limiting" feature is enabled with action as
          "Drop packet", And the count of dynamically learnt unicast
          MAC addresses on a particular port exceeds with the maximum
          programmed value for that port, Then packet with new MAC-SA
          should be dropped.

    @post
        -# All transmitted packets with new MAC-SA after reaching maximum
           programmed value for that port should be dropped and overlimit counter
           should be incremented.

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_ETHSWT_SECURITY
*/
#define BRCM_SWQTST_ETHSWT_ADDRESS_LIMITING_ENABLE_DROP_PKT              (0x305UL)

/**
    @brief Enable "Address Limiting" with
           action as "Redirect to CPU".

    @pre
        -# INET client should be registered
        -# VlanId(1024U) should be added in NIF_CtrlVlanArray

    @test If "Address Limiting" feature is enabled with action as
          "Redirect to CPU", And the count of dynamically learnt unicast
          MAC addresses on a particular port exceeds with the maximum
          programmed value for that port, Then packet with new MAC-SA
          should be redirected to IMP port.

    @post
        -# All transmitted packets with new MAC-SA after reaching maximum
           programmed value for that port should be redirected to IMP port
           and overlimit counter should be incremented.

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_ETHSWT_SECURITY
*/
#define BRCM_SWQTST_ETHSWT_ADDRESS_LIMITING_ENABLE_REDIRECT_TO_CPU       (0x306UL)

/**
    @brief Enable "Address Limiting" with
           action as "Normal".

    @pre
        -# INET client should be registered
        -# VlanId(1024U) should be added in NIF_CtrlVlanArray

    @test If "Address Limiting" feature is enabled with action as
          "Normal", And the count of dynamically learnt unicast
          MAC addresses on a particular port exceeds with the maximum
          programmed value for that port, Then packet with new MAC-SA
          should follow normal ACL based forwarding process.

    @post
        -# All transmitted packets with new MAC-SA after reaching maximum
           programmed value for that port should follow normal ACL based
           forwarding process and increment overlimit counter.

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_ETHSWT_SECURITY
*/
#define BRCM_SWQTST_ETHSWT_ADDRESS_LIMITING_ENABLE_NORMAL                (0x307UL)

/**
    @brief Enable "Address Limiting" with
           action as "Copy to CPU".

    @pre
        -# INET client should be registered
        -# VlanId(1024U) should be added in NIF_CtrlVlanArray

    @test If "Address Limiting" feature is enabled with action as
          "Copy to CPU", And the count of dynamically learnt unicast
          MAC addresses on a particular port exceeds with the maximum
          programmed value for that port, Then packet with new MAC-SA
          should be copied to CPU port .

    @post
        -# All transmitted packets with new MAC-SA after reaching maximum
           programmed value for that port should be copied to IMP port
           and overlimit counter should be incremented.

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_ETHSWT_SECURITY
*/
#define BRCM_SWQTST_ETHSWT_ADDRESS_LIMITING_ENABLE_COPY_TO_CPU           (0x308UL)

/**
    @brief Disable "Address Limiting".

    @pre
        -# INET client should be registered
        -# VlanId(1024U) should be added in NIF_CtrlVlanArray

    @test If "Address Limiting" feature is disabled, And the count of
          dynamically learned unicast MAC addresses on a particular
          port exceeds with the maximum programmed value for that port,
          Then packet with new MAC-SA should not be discarded.

    @post
        -# All transmitted packets with new MAC-SA after reaching maximum
           programmed value for that port should not be discarded.

    @functional     Yes

    @type           Neg

    @trace #BRCM_SWREQ_ETHSWT_SECURITY
*/
#define BRCM_SWQTST_ETHSWT_ADDRESS_LIMITING_DISABLE_ON_PORT              (0x309UL)

/**
    @brief Enable "Address Limiting".

    @pre
        -# INET client should be registered
        -# VlanId(1024U) should be added in NIF_CtrlVlanArray

    @test If "Address Limiting" feature is enabled, And the total
          count of dynamically learned unicast MAC addresses across
          all the ports exceeds with the maximum programmed total
          value for all the ports, Then packet with new MAC-SA should
          be discarded.

    @post
        -# All transmitted packets with new MAC-SA after reaching maximum
           total programmed value accross all the ports should be discarded.

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_ETHSWT_SECURITY
*/
#define BRCM_SWQTST_ETHSWT_ADDRESS_LIMITING_ENABLE_ACCROSS_PORT          (0x30AUL)

/**
    @brief Enable "Station Movement Detection" with action
           as "Drop packet".

    @pre
        -# INET client should be registered
        -# VlanId(1024U) should be added in NIF_CtrlVlanArray

    @test If "Station Movement Detection" feature is enabled with action
          as "Drop packet", And a MAC address is learned by hardware
          from this port, then any packet with the same address as MAC-SA
          ingress to switch from a different physical port should
          be dropped.

    @post
        -# All transmitted packets after station movement should
           be dropped.

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_ETHSWT_SECURITY
*/
#define BRCM_SWQTST_ETHSWT_STATION_MOVEMENT_DETECTION_DROP_PKT           (0x30BUL)

/**
    @brief Enable "Station Movement Detection" with action
          as "Redirect to CPU".

    @pre
        -# INET client should be registered
        -# VlanId(1024U) should be added in NIF_CtrlVlanArray

    @test If "Station Movement Detection" feature is enabled with action
          as "Redirect to CPU", And a MAC address is learned by hardware
          from this port, then any packet with the same address as MAC-SA
          ingress to switch from a different physical port should
          be redirected to IMP port.

    @post
        -# All transmitted packets after station movement should
           be redirected to IMP port.

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_ETHSWT_SECURITY
*/
#define BRCM_SWQTST_ETHSWT_STATION_MOVEMENT_DETECTION_REDIRECT_TO_CPU    (0x30CUL)

/**
    @brief Disable "Station Movement Detection".

    @pre
        -# INET client should be registered
        -# VlanId(1024U) should be added in NIF_CtrlVlanArray

    @test If "Station Movement Detection" feature is disabled, And
          a MAC address has been learned by hardware on a port,
          and a packet with the same address as MAC-SA enters the
          switch from a different physical port, then it should
          not be discarded.

    @post
        -# All transmitted packets after station movement should
           not be discarded.

    @functional     Yes

    @type           Neg

    @trace #BRCM_SWREQ_ETHSWT_SECURITY
*/
#define BRCM_SWQTST_ETHSWT_STATION_MOVEMENT_DETECTION_DISABLE            (0x30DUL)

/**
    @brief Enable "Vlan-Hopping detection" with action
           as "Drop packet"

    @pre
        -# Ethernet loopback should be enabled on test port

    @test If "Vlan-Hopping detection" feature is enabled with action
          as "Drop packet", then any packet arriving with two tags with
          TPID 0x8100 should be discarded.

    @post
        -# All double-tagged transmitted packets with
          TPID 0x8100 should be discarded.

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_ETHSWT_SECURITY
*/
#define BRCM_SWQTST_ETHSWT_VLAN_HOPPING_DETECTION_DROP_PKT               (0x30EUL)

/**
    @brief Enable "Vlan-Hopping detection" with action
           as "Redirect to CPU"

    @pre
        -# Ethernet loopback should be enabled on test port

    @test If "Vlan-Hopping detection" feature is enabled with action
          as "Redirect to CPU", then any packet arriving with two tags with
          TPID 0x8100 should be redirected to IMP port.

    @post
        -# All double-tagged transmitted packets with
          TPID 0x8100 should be redirected to IMP port.

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_ETHSWT_SECURITY
*/
#define BRCM_SWQTST_ETHSWT_VLAN_HOPPING_DETECTION_REDIRECT_TO_CPU        (0x30FUL)

/**
    @brief Disable "Vlan-Hopping detection".

    @pre
        -# Ethernet loopback should be enabled on test port

    @test If "Vlan-Hopping detection" feature is disabled, then
          any packet arriving with two tags with TPID 0x8100 should
          not be discarded.

    @post
        -# All double-tagged transmitted packets with TPID 0x8100
           should be received.

    @functional     Yes

    @type           Neg

    @trace #BRCM_SWREQ_ETHSWT_SECURITY
*/
#define BRCM_SWQTST_ETHSWT_VLAN_HOPPING_DETECTION_DISABLE                (0x310UL)

/** @brief Security feature test "station movement detection"

    This test simulates MAC Spoofing to breach the security of
    the system using station movement, And check the authenticity of
    "station movement detection", Which is taken to prevent this
    well known attack.

    @code{.c}
   -# Activate Security Test Task
    - TestPort1 = 1UL (None)
    - TestPort2 = 2UL (Station movement enabled)
    - TestPort3 = 3UL (Sticky MAC address enabled)
    - TestPort4 = 4UL (Address limiting enabled)
    - IMP_PORT  = 8UL
    - SwtID = 0U
    - vlanID = 1024U
    - ethCtrlIdx = 0x0ULL
    - dstMacAddr[] = {0x30U, 0x80U, 0xC2U, 0x00U, 0x00U, 0x02U}
    - srcMacAddr[] = {0x02U, 0x00U, 0x00U, 0x01U, 0x29U, 0x51U}
    - Retrieve the NIF controller index for a INET client
    - Add vlan-1024 in NIF_CtrlVlanArray
    - MAX_ARL_ENTRY_TEST = 20
    - ETHSWT_ARLEntryType   aARLTbl[MAX_ARL_ENTRY_TEST]

   -# Initial setup
     - Delete all the entries in ARL Table

   -# Setup for "Station Movement" feature
     - Set Source MAC Address
       ETHER_SetMacAddr(SwtID, srcMacAddr) should return BCM_ERR_OK

     - Set loopback on TestPort1
       ETHSWT_SetPortLoopbackMode(SwtID, TestPort1, ETHXCVR_BOOLEAN_TRUE)
       should return BCM_ERR_OK

     - Add TestPort1, TestPort2 and ARM-CPU port as part of vlan 1024
       ETHSWT_AddVLANPorts(SwtID, 0x01FF , 1024U, 0x01FF) should return BCM_ERR_OK

     - Retrieve the NIF controller index for INET client
       NIF_GetCtrlIdx(vlanID, BCM_NET_ID, SwtID, &ethCtrlIdx) should return BCM_ERR_OK

     - Get Rx stat of TestPort1 before sending the packets
       ETHSWT_GetRxStat(SwtID, TestPort1, &rxStat1) should return BCM_ERR_OK

     - Set number of INET IPv4 packets received on ARM-CPU to zero
       numRxPkts = 0UL

     - Transmit 5 IPv4 packets, with destination MAC address dstMacAddr(30:80:C2:00:00:02) and
       srcMacAddr(02:00:00:01:29:51), destined to TestPort1 and verify that all the packets
       should be received on ARM-CPU.
       length = 90U
       NIF_GetTxBuffer(*ethCtrlIdx, ETHER_ETHERTYPE_IP, 6U, &bufIdx, &pdu, &length)
       BCM_MemCpy(pdu, ipv4_pkt, sizeof(ipv4_pkt))
       mgmtInfo.switchIdx = 0UL
       mgmtInfo.portIdx   = TestPort1
       mgmtInfo.tc        = ETHSWT_TC_4
       ret = NIF_SwtSetMgmtInfo(*ethCtrlIdx, bufIdx, &mgmtInfo)
       NIF_Send(ethCtrlIdx, ETHER_ETHERTYPE_IP, 1UL, bufIdx, sizeof(ipv4_pkt), dstMacAddr)


     - Get Rx stat of TestPort1 after sending the packets
       ETHSWT_GetRxStat(SwtID, TestPort1, &rxStat2) should return BCM_ERR_OK

     - Check whether the difference of rxStat2.pktsRxDiscard and rxStat1.pktsRxDiscard is equal to 0UL or not
       and also check numRxPkts is equal to 5UL or not

     - Clear loopback on TestPort1
       ETHSWT_SetPortLoopbackMode(SwtID, TestPort1, ETHXCVR_BOOLEAN_FALSE) should return BCM_ERR_OK

     - Set loopback on TestPort2
       ETHSWT_SetPortLoopbackMode(SwtID, TestPort2, ETHXCVR_BOOLEAN_TRUE) should return BCM_ERR_OK

     - Get Station movement detection on TestPort2
       ETHSWT_GetStationMovementDetection(SwtID, TestPort2, &stationMoveAction)
       should return BCM_ERR_OK

     - Check whether the stationMoveAction is ETHSWT_SECURITY_ACTION_DROP_PKT or not

     - Get Rx stat of TestPort2 before sending the packets
       ETHSWT_GetRxStat(SwtID, TestPort2, &rxStat1) should return BCM_ERR_OK

     - Set number of INET IPv4 packets received on ARM-CPU to zero
       numRxPkts = 0UL

     - Transmit 5 IPv4 packets, with destination MAC address dstMacAddr(30:80:C2:00:00:02) and
       srcMacAddr(02:00:00:01:29:51), destined to TestPort2
       length = 90U
       NIF_GetTxBuffer(*ethCtrlIdx, ETHER_ETHERTYPE_IP, 6U, &bufIdx, &pdu, &length)
       BCM_MemCpy(pdu, ipv4_pkt, sizeof(ipv4_pkt))
       mgmtInfo.switchIdx = 0UL
       mgmtInfo.portIdx   = TestPort2
       mgmtInfo.tc        = ETHSWT_TC_4
       ret = NIF_SwtSetMgmtInfo(*ethCtrlIdx, bufIdx, &mgmtInfo)
       NIF_Send(ethCtrlIdx, ETHER_ETHERTYPE_IP, 1UL, bufIdx, sizeof(ipv4_pkt), dstMacAddr)


     - Get Rx stat of TestPort2 after sending the packets
       ETHSWT_GetRxStat(SwtID, TestPort2, &rxStat2) should return BCM_ERR_OK

     - Check whether the difference of rxStat2.pktsRxDiscard and rxStat1.pktsRxDiscard is equal to 5UL or not
       and also check numRxPkts is equal to 0UL or not
       #BRCM_SWQTST_ETHSWT_STATION_MOVEMENT_DETECTION_DROP_PKT

     - Set Station movement detection on TestPort2
       stationMoveAction = ETHSWT_SECURITY_ACTION_REDIRECT_TO_CPU
       ETHSWT_SetStationMovementDetection(SwtID, TestPort2, &stationMoveAction)
       should return BCM_ERR_OK

     - Get Station movement detection on TestPort2
       ETHSWT_GetStationMovementDetection(SwtID, TestPort2, &stationMoveAction)
       should return BCM_ERR_OK

     - Check whether the stationMoveAction is ETHSWT_SECURITY_ACTION_REDIRECT_TO_CPU or not

     - Get Tx stat of IMP Port before sending the packets
       ETHSWT_GetTxStat(SwtID, IMP_PORT, &txStat1) should return BCM_ERR_OK

     - Get Tx stat of Port-7 before sending the packets
       ETHSWT_GetTxStat(SwtID, 7UL, &p7TxStat1) should return BCM_ERR_OK

     - Transmit 5 IPv4 packets, with destination MAC address dstMacAddr(30:80:C2:00:00:02) and
       srcMacAddr(02:00:00:01:29:51), destined to TestPort2
       length = 90U
       NIF_GetTxBuffer(*ethCtrlIdx, ETHER_ETHERTYPE_IP, 6U, &bufIdx, &pdu, &length)
       BCM_MemCpy(pdu, ipv4_pkt, sizeof(ipv4_pkt))
       mgmtInfo.switchIdx = 0UL
       mgmtInfo.portIdx   = TestPort2
       mgmtInfo.tc        = ETHSWT_TC_4
       ret = NIF_SwtSetMgmtInfo(*ethCtrlIdx, bufIdx, &mgmtInfo)
       NIF_Send(ethCtrlIdx, ETHER_ETHERTYPE_IP, 1UL, bufIdx, sizeof(ipv4_pkt), dstMacAddr)


     - Get Tx stat of IMP Port after sending the packets
       ETHSWT_GetTxStat(SwtID, IMP_PORT, &txStat2) should return BCM_ERR_OK

     - Get Tx stat of Port-7 after sending the packets
       ETHSWT_GetTxStat(SwtID, 7UL, &p7TxStat2) should return BCM_ERR_OK

     - Check whether the difference of p7TxStat2.unicast and p7TxStat1.unicast is equal to 0UL or not

     - Check whether the difference of txStat2.unicast and txStat1.unicast is equal to 5UL or not
       #BRCM_SWQTST_ETHSWT_STATION_MOVEMENT_DETECTION_REDIRECT_TO_CPU

     - Clear Station movement detection on TestPort2
       stationMoveAction = ETHSWT_SECURITY_ACTION_DISABLED
       ETHSWT_SetStationMovementDetection(0U, TestPort2, &stationMoveAction) should return BCM_ERR_OK

     - Get Station movement detection on TestPort2
       ETHSWT_GetStationMovementDetection(SwtID, TestPort2, &stationMoveAction)
       should return BCM_ERR_OK

     - Check whether the stationMoveAction is ETHSWT_SECURITY_ACTION_DISABLED or not

     - Get Rx stat of TestPort2 before sending the packets
       ETHSWT_GetRxStat(SwtID, TestPort2, &rxStat1) should return BCM_ERR_OK

     - Set number of INET IPv4 packets received on ARM-CPU to zero
       numRxPkts = 0UL

     - Transmit 5 IPv4 packets, with destination MAC address dstMacAddr(30:80:C2:00:00:02) and
       srcMacAddr(02:00:00:01:29:51), destined to TestPort2
        length = 90U
        NIF_GetTxBuffer(*ethCtrlIdx, ETHER_ETHERTYPE_IP, 6U, &bufIdx, &pdu, &length)
        BCM_MemCpy(pdu, ipv4_pkt, sizeof(ipv4_pkt))
        mgmtInfo.switchIdx = 0UL
        mgmtInfo.portIdx   = TestPort2
        mgmtInfo.tc        = ETHSWT_TC_4
        ret = NIF_SwtSetMgmtInfo(*ethCtrlIdx, bufIdx, &mgmtInfo)
        NIF_Send(ethCtrlIdx, ETHER_ETHERTYPE_IP, 1UL, bufIdx, sizeof(ipv4_pkt), dstMacAddr)

     - Get Rx stat of TestPort2 after sending the packets
       ETHSWT_GetRxStat(SwtID, TestPort2, &rxStat2) should return BCM_ERR_OK

     - Check whether the difference of rxStat2.pktsRxDiscard and rxStat1.pktsRxDiscard is equal to 0UL or not
       and also check numRxPkts is equal to 5UL or not
       #BRCM_SWQTST_ETHSWT_STATION_MOVEMENT_DETECTION_DISABLE

     - Clear loopback on TestPort2
       ETHSWT_SetPortLoopbackMode(SwtID, TestPort2, ETHXCVR_BOOLEAN_FALSE) should return BCM_ERR_OK

     - Reset Station movement detection on TestPort2
       stationMoveAction = ETHSWT_SECURITY_ACTION_DROP_PKT
       ETHSWT_SetStationMovementDetection(SwtID, TestPort2, &stationMoveAction)
       should return BCM_ERR_OK

     - Get Station movement detection on TestPort2
       ETHSWT_GetStationMovementDetection(SwtID, TestPort2, &stationMoveAction)
       should return BCM_ERR_OK

     - Check whether the stationMoveAction is ETHSWT_SECURITY_ACTION_DROP_PKT or not

     - Delete all the entries in ARL Table
    -# Terminate Security Test Task
   -#
    @endcode

    @board BCM8956X

    @auto           yes

    @type           Sanity

    @testproc #BRCM_SWQTST_ETHSWT_STATION_MOVEMENT_DETECTION_DROP_PKT
    @testproc #BRCM_SWQTST_ETHSWT_STATION_MOVEMENT_DETECTION_REDIRECT_TO_CPU
    @testproc #BRCM_SWQTST_ETHSWT_STATION_MOVEMENT_DETECTION_DISABLE
*/
#define BRCM_SWQTSEQ_ETHSWT_SECURITY_STATION_MOVEMENT_DETECTION_SEQ      (0x311UL)

/** @brief Security feature test "Sticky MAC Addresses"

    This test simulates MAC Spoofing to breach the security of
    the system using unknown SA (Source Address), And check the
    authenticity of "Sticky MAC Addresses", Which is taken to prevent
    this well known attack.

    @code{.c}
   -# Activate Security Test Task
      - TestPort1 = 1UL (None)
      - TestPort2 = 2UL (Station movement enabled)
      - TestPort3 = 3UL (Sticky MAC address enabled)
      - TestPort4 = 4UL (Address limiting enabled)
      - IMP_PORT  = 8UL
      - SwtID = 0U
      - vlanID = 1024U
      - ethCtrlIdx = 0x0ULL
      - dstMacAddr[] = {0x30U, 0x80U, 0xC2U, 0x00U, 0x00U, 0x02U}
      - srcMacAddr[] = {0x02U, 0x00U, 0x00U, 0x01U, 0x29U, 0x51U}
      - Retrieve the NIF controller index for a INET client
      - Add vlan-1024 in NIF_CtrlVlanArray
      - MAX_ARL_ENTRY_TEST = 20
      - ETHSWT_ARLEntryType   aARLTbl[MAX_ARL_ENTRY_TEST]

   -# Initial setup
      - Delete all the entries in ARL Table
   -# Setup for "Sticky MAC Addresses" feature
      - Set loopback on TestPort3
        ETHSWT_SetPortLoopbackMode(SwtID, TestPort3, ETHXCVR_BOOLEAN_TRUE)
        should return BCM_ERR_OK

      - Get source MAC Address
        ETHER_GetMacAddr(SwtID, srcMacAddr) should return BCM_ERR_OK

      - Add TestPort3 and ARM-CPU port as part of vlan 1024
        ETHSWT_AddVLANPorts(SwtID, 0x01FF , 1024U, 0x01FF) should return BCM_ERR_OK

      - Add ARL Entry
        BCM_MemCpy(&arlEntry.macAddr, &srcMacAddr, sizeof(srcMacAddr))
        arlEntry.vlanID = vlanID
        arlEntry.portMask = (1U << TestPort3)
        ETHSWT_AddARLEntry(SwtID, &arlEntry) should return BCM_ERR_OK

      - Get MAC Address sticky action on TestPort3
        ETHSWT_GetMACAddressStickyToPort(0U, TestPort3, &stickyMACAction) should return BCM_ERR_OK

      - Check whether the stickyMACAction is ETHSWT_SECURITY_ACTION_DROP_PKT or not

      - Retrieve the NIF controller index for INET client
        NIF_GetCtrlIdx(vlanID, BCM_NET_ID, SwtID, &ethCtrlIdx) should return BCM_ERR_OK

      - Transmit 5 IPv4 packets, with destination MAC address dstMacAddr(30:80:C2:00:00:02) and
        srcMacAddr (received from ETHER_GetMacAddr), destined to TestPort3 and verify that all the packets
        should be received on ARM-CPU.
        length = 90U
        NIF_GetTxBuffer(*ethCtrlIdx, ETHER_ETHERTYPE_IP, 6U, &bufIdx, &pdu, &length)
        BCM_MemCpy(pdu, ipv4_pkt, sizeof(ipv4_pkt))
        mgmtInfo.switchIdx = 0UL
        mgmtInfo.portIdx   = TestPort3
        mgmtInfo.tc        = ETHSWT_TC_4
        ret = NIF_SwtSetMgmtInfo(*ethCtrlIdx, bufIdx, &mgmtInfo)
        NIF_Send(ethCtrlIdx, ETHER_ETHERTYPE_IP, 1UL, bufIdx, sizeof(ipv4_pkt), dstMacAddr)

        #BRCM_SWQTST_ETHSWT_STICKY_MAC_ENABLE_MATCH_SA

      - Set Source MAC Address with new value
        srcMacAddr[5] += 1U;
        ETHER_SetMacAddr(SwtID, srcMacAddr) should return BCM_ERR_OK

      - Get Rx stat of TestPort3 before sending the packets
        ETHSWT_GetRxStat(SwtID, TestPort3, &rxStat1) should return BCM_ERR_OK

      - Set number of INET IPv4 packets received on ARM-CPU to zero
        numRxPkts = 0UL

      - Transmit 5 IPv4 packets, with destination MAC address dstMacAddr(30:80:C2:00:00:02) and
        srcMacAddr (new SA-MAC), destined to TestPort3.
        length = 90U
        NIF_GetTxBuffer(*ethCtrlIdx, ETHER_ETHERTYPE_IP, 6U, &bufIdx, &pdu, &length)
        BCM_MemCpy(pdu, ipv4_pkt, sizeof(ipv4_pkt))
        mgmtInfo.switchIdx = 0UL
        mgmtInfo.portIdx   = TestPort3
        mgmtInfo.tc        = ETHSWT_TC_4
        ret = NIF_SwtSetMgmtInfo(*ethCtrlIdx, bufIdx, &mgmtInfo)
        NIF_Send(ethCtrlIdx, ETHER_ETHERTYPE_IP, 1UL, bufIdx, sizeof(ipv4_pkt), dstMacAddr)


      - Get Rx stat of TestPort3 after sending the packets
        ETHSWT_GetRxStat(SwtID, TestPort3, &rxStat2) should return BCM_ERR_OK

      - Check whether the difference of rxStat2.pktsRxDiscard and rxStat1.pktsRxDiscard is equal to 5UL or not
        and also check numRxPkts is equal to 0UL or not
        #BRCM_SWQTST_ETHSWT_STICKY_MAC_ENABLE_DROP_PKT

      - Enable the MAC Address sticky on TestPort3
        stickyMACAction = ETHSWT_SECURITY_ACTION_REDIRECT_TO_CPU
        ETHSWT_SetMACAddressStickyToPort(SwtID, TestPort3, &stickyMACAction) should return BCM_ERR_OK

      - Get MAC Address sticky action on TestPort3
        ETHSWT_GetMACAddressStickyToPort(0U, TestPort3, &stickyMACAction) should return BCM_ERR_OK

      - Check whether the stickyMACAction is ETHSWT_SECURITY_ACTION_REDIRECT_TO_CPU or not

      - Get Tx stat of IMP Port before sending the packets
        ETHSWT_GetTxStat(SwtID, IMP_PORT, &txStat1) should return BCM_ERR_OK

      - Get Tx stat of Port-7 before sending the packets
        ETHSWT_GetTxStat(SwtID, 7UL, &p7TxStat1) should return BCM_ERR_OK

      - Transmit 5 IPv4 packets, with destination MAC address dstMacAddr(30:80:C2:00:00:02) and
        srcMacAddr (new SA-MAC), destined to TestPort3.
        length = 90U
        NIF_GetTxBuffer(*ethCtrlIdx, ETHER_ETHERTYPE_IP, 6U, &bufIdx, &pdu, &length)
        BCM_MemCpy(pdu, ipv4_pkt, sizeof(ipv4_pkt))
        mgmtInfo.switchIdx = 0UL
        mgmtInfo.portIdx   = TestPort3
        mgmtInfo.tc        = ETHSWT_TC_4
        ret = NIF_SwtSetMgmtInfo(*ethCtrlIdx, bufIdx, &mgmtInfo)
        NIF_Send(ethCtrlIdx, ETHER_ETHERTYPE_IP, 1UL, bufIdx, sizeof(ipv4_pkt), dstMacAddr)

      - Get Tx stat of Port-7 after sending the packets
        ETHSWT_GetTxStat(SwtID, 7UL, &p7TxStat2) should return BCM_ERR_OK

      - Check whether the difference of p7TxStat2.unicast and p7TxStat2.unicast is equal to 0UL or not

      - Get Tx stat of IMP Port after sending the packets
        ETHSWT_GetTxStat(SwtID, IMP_PORT, &txStat2) should return BCM_ERR_OK

      - Check whether the difference of txStat2.unicast and txStat1.unicast is equal to 5UL or not
        #BRCM_SWQTST_ETHSWT_STICKY_MAC_ENABLE_REDIRECT_TO_CPU

      - Disable sticky MAC Address on TestPort1
        stickyMACAction = ETHSWT_SECURITY_ACTION_DISABLED
        ETHSWT_SetMACAddressStickyToPort(SwtID, TestPort1, &stickyMACAction) should return BCM_ERR_OK

      - Get MAC Address sticky action on TestPort3
        ETHSWT_GetMACAddressStickyToPort(0U, TestPort3, &stickyMACAction) should return BCM_ERR_OK

      - Check whether the stickyMACAction is ETHSWT_SECURITY_ACTION_DISABLED or not

      - Get Rx stat of TestPort3 before sending the packets
        ETHSWT_GetRxStat(SwtID, TestPort3, &rxStat1) should return BCM_ERR_OK

      - Set number of INET IPv4 packets received on ARM-CPU to zero
        numRxPkts = 0UL

      - Transmit 5 IPv4 packets, with destination MAC address dstMacAddr(30:80:C2:00:00:02) and
        srcMacAddr (new SA-MAC), destined to TestPort3.
        length = 90U
        NIF_GetTxBuffer(*ethCtrlIdx, ETHER_ETHERTYPE_IP, 6U, &bufIdx, &pdu, &length)
        BCM_MemCpy(pdu, ipv4_pkt, sizeof(ipv4_pkt))
        mgmtInfo.switchIdx = 0UL
        mgmtInfo.portIdx   = TestPort3
        mgmtInfo.tc        = ETHSWT_TC_4
        ret = NIF_SwtSetMgmtInfo(*ethCtrlIdx, bufIdx, &mgmtInfo)
        NIF_Send(ethCtrlIdx, ETHER_ETHERTYPE_IP, 1UL, bufIdx, sizeof(ipv4_pkt), dstMacAddr)


      - Get Rx stat of TestPort3 after sending the packets
        ETHSWT_GetRxStat(SwtID, TestPort3, &rxStat2) should return BCM_ERR_OK

      - Check whether the difference of rxStat2.pktsRxDiscard and rxStat1.pktsRxDiscard is equal to 0UL or not
        and also check numRxPkts is equal to 5UL or not
        #BRCM_SWQTST_ETHSWT_STICKY_MAC_DISABLE

      - Enable the MAC Address sticky on TestPort3
        stickyMACAction = ETHSWT_SECURITY_ACTION_DROP_PKT
        ETHSWT_SetMACAddressStickyToPort(SwtID, TestPort3, &stickyMACAction) should return BCM_ERR_OK

      - Get MAC Address sticky action on TestPort3
        ETHSWT_GetMACAddressStickyToPort(0U, TestPort3, &stickyMACAction) should return BCM_ERR_OK

      - Check whether the stickyMACAction is ETHSWT_SECURITY_ACTION_DROP_PKT or not

      - Delete all the entries in ARL Table
    -# Terminate Security Test Task
   -#
    @endcode

    @board BCM8956X

    @auto           yes

    @type           Sanity

    @testproc #BRCM_SWQTST_ETHSWT_STICKY_MAC_ENABLE_MATCH_SA
    @testproc #BRCM_SWQTST_ETHSWT_STICKY_MAC_ENABLE_DROP_PKT
    @testproc #BRCM_SWQTST_ETHSWT_STICKY_MAC_ENABLE_REDIRECT_TO_CPU
    @testproc #BRCM_SWQTST_ETHSWT_STICKY_MAC_DISABLE
*/
#define BRCM_SWQTSEQ_ETHSWT_SECURITY_STICKY_MAC_SEQ                      (0x312UL)

/** @brief Security feature test "VLAN Hopping detection"

    This test simulates VLAN Hopping to breach the security of
    the system and check the authenticity of "VLAN Hopping detection",
    Which is taken to prevent this well known attack.

    @code{.c}
   -# Activate Security Test Task
      - TestPort1 = 1UL (None)
      - TestPort2 = 2UL (Station movement enabled)
      - TestPort3 = 3UL (Sticky MAC address enabled)
      - TestPort4 = 4UL (Address limiting enabled)
      - IMP_PORT  = 8UL
      - SwtID = 0U
      - vlanID = 1024U
      - ethCtrlIdx = 0x0ULL
      - dstMacAddr[] = {0x30U, 0x80U, 0xC2U, 0x00U, 0x00U, 0x02U}
      - srcMacAddr[] = {0x02U, 0x00U, 0x00U, 0x01U, 0x29U, 0x51U}
      - Retrieve the NIF controller index for a INET client
      - Add vlan-1024 in NIF_CtrlVlanArray
      - MAX_ARL_ENTRY_TEST = 20
      - ETHSWT_ARLEntryType   aARLTbl[MAX_ARL_ENTRY_TEST]

   -# Initial setup
      - Delete all the entries in ARL Table
   -# Setup for "VLAN Hopping detection" feature

      - Set loopback on TestPort1
        ETHSWT_SetPortLoopbackMode(SwtID, TestPort1, ETHXCVR_BOOLEAN_TRUE)
        should return BCM_ERR_OK

      - Add TestPort1 and ARM-CPU port as part of vlan 1024
        ETHSWT_AddVLANPorts(SwtID, 0x01FF , 1024U, 0x01FF) should return BCM_ERR_OK

      - Get VLAN Hopping action
        ETHSWT_GetVlanHoppingDetection(SwtID, &aVlanHoppingAction) should return BCM_ERR_OK

      - Check whether the aVlanHoppingAction is ETHSWT_SECURITY_ACTION_DROP_PKT or not

      - Get Rx stat of TestPort1 before sending the packets
        ETHSWT_GetRxStat(SwtID, TestPort1, &rxStat1) should return BCM_ERR_OK

      - Get buffer from Ethernet Driver
        aPriority = 3UL
        pktLen = sizeof(ipv4_pkt) + NIF_VLAN_TAG_SIZE + NIF_VLAN_TAG_SIZE + NIF_ETHERTYPE_SIZE
        ETHER_GetTxBuffer(SwtID, aPriority, &bufIdx, &pktBuf, &pktLen) should return BCM_ERR_OK

      - Insert VLAN tag1
       *((ETHER_EtherType *)(pktBuf)) = CPU_NativeToBE16(ETHER_ETHERTYPE_VLANTAG)
        pktLen -= NIF_VLAN_TAG_SIZE
        pktBuf += 2UL;
        *((ETHER_VLANIDType *)(pktBuf)) = CPU_NativeToBE16(0U | (aPriority << 13UL) | (vlanID & 0xFFFU));
        pktBuf += 2UL;

      - Insert VLAN tag2
       *((ETHER_EtherType *)(pktBuf)) = CPU_NativeToBE16(ETHER_ETHERTYPE_VLANTAG)
        pktLen -= NIF_VLAN_TAG_SIZE
        pktBuf += 2UL;
        *((ETHER_VLANIDType *)(pktBuf)) = CPU_NativeToBE16(0U | (aPriority << 13UL) | (vlanID & 0xFFFU));
        pktBuf += 2UL;

      - Insert Ethertype
        *((ETHER_EtherType *)(pktBuf)) = CPU_NativeToBE16(ETHER_ETHERTYPE_IP);
         pktBuf += NIF_ETHERTYPE_SIZE

      - Copy the packet to be send, into the buffer
        memcpy(pktBuf, Ether_VLAN_HOPPING_Pkt, pktLen)

        mgmtInfo.switchIdx = SwtID;
        mgmtInfo.portIdx   = TestPort1
        mgmtInfo.tc        = ETHSWT_TC_4
        ETHSWT_SetMgmtInfo(SwtID, bufIdx, &mgmtInfo) should return BCM_ERR_OK

      - Send 5 packets
        ETHER_Send(SwtID, 1UL, bufIdx, pktLen, dstMacAddr)
        should return BCM_ERR_OK

      - Get Rx stat of TestPort1 after sending the packets
        ETHSWT_GetRxStat(SwtID, TestPort1, &rxStat2) should return BCM_ERR_OK

      - Check whether the difference of rxStat2.pktsRxDiscard and rxStat1.pktsRxDiscard is equal to 5UL or not
        #BRCM_SWQTST_ETHSWT_VLAN_HOPPING_DETECTION_DROP_PKT

      - Enable the VLAN Hopping detection
        aVlanHoppingAction = ETHSWT_SECURITY_ACTION_REDIRECT_TO_CPU
        ETHSWT_SetVlanHoppingDetection(SwtID, aVlanHoppingAction) should return BCM_ERR_OK

      - Get VLAN Hopping action
        ETHSWT_GetVlanHoppingDetection(SwtID, &aVlanHoppingAction) should return BCM_ERR_OK

      - Check whether the aVlanHoppingAction is ETHSWT_SECURITY_ACTION_REDIRECT_TO_CPU or not

      - Get Tx stat of IMP_PORT before sending the packets
        ETHSWT_GetTxStat(SwtID, IMP_PORT, &txStat1) should return BCM_ERR_OK

      - Get Tx stat of Port-7 before sending the packets
        ETHSWT_GetTxStat(SwtID, 7UL, &p7TxStat2) should return BCM_ERR_OK

      - Get buffer from Ethernet Driver
        aPriority = 3UL
        pktLen = sizeof(ipv4_pkt) + NIF_VLAN_TAG_SIZE + NIF_VLAN_TAG_SIZE + NIF_ETHERTYPE_SIZE
        ETHER_GetTxBuffer(SwtID, aPriority, &bufIdx, &pktBuf, &pktLen) should return BCM_ERR_OK

      - Insert VLAN tag1
       *((ETHER_EtherType *)(pktBuf)) = CPU_NativeToBE16(ETHER_ETHERTYPE_VLANTAG)
        pktLen -= NIF_VLAN_TAG_SIZE
        pktBuf += 2UL;
        *((ETHER_VLANIDType *)(pktBuf)) = CPU_NativeToBE16(0U | (aPriority << 13UL) | (vlanID & 0xFFFU));
        pktBuf += 2UL;

      - Insert VLAN tag2
       *((ETHER_EtherType *)(pktBuf)) = CPU_NativeToBE16(ETHER_ETHERTYPE_VLANTAG)
        pktLen -= NIF_VLAN_TAG_SIZE
        pktBuf += 2UL;
        *((ETHER_VLANIDType *)(pktBuf)) = CPU_NativeToBE16(0U | (aPriority << 13UL) | (vlanID & 0xFFFU));
        pktBuf += 2UL;

      - Insert Ethertype
        *((ETHER_EtherType *)(pktBuf)) = CPU_NativeToBE16(ETHER_ETHERTYPE_IP);
         pktBuf += NIF_ETHERTYPE_SIZE

      - Copy the packet to be send, into the buffer
        memcpy(pktBuf, ipv4_pkt, sizeof(ipv4_pkt))

        mgmtInfo.switchIdx = SwtID;
        mgmtInfo.portIdx   = TestPort1
        mgmtInfo.tc        = ETHSWT_TC_4
        ETHSWT_SetMgmtInfo(SwtID, bufIdx, &mgmtInfo) should return BCM_ERR_OK

      - Send 5 packets
        ETHER_Send(SwtID, 1UL, bufIdx, pktLen, dstMacAddr)
        should return BCM_ERR_OK

      - Get Tx stat of IMP_PORT after sending the packets
        ETHSWT_GetTxStat(SwtID, IMP_PORT, &txStat2) should return BCM_ERR_OK

      - Get Tx stat of Port-7 after sending the packets
        ETHSWT_GetTxStat(SwtID, 7UL, &p7TxStat2) should return BCM_ERR_OK

      - Check whether the difference of p7TxStat2.unicast and p7TxStat1.unicast is equal to 0UL or not

      - Check whether the difference of txStat2.unicast and txStat1.unicast is equal to 5UL or not
        #BRCM_SWQTST_ETHSWT_VLAN_HOPPING_DETECTION_REDIRECT_TO_CPU

      - Disable the VLAN Hopping detection
        aVlanHoppingAction = ETHSWT_SECURITY_ACTION_DROP_PKT
        ETHSWT_SetVlanHoppingDetection(SwtID, aVlanHoppingAction) should return BCM_ERR_OK

      - Get VLAN Hopping action
        ETHSWT_GetVlanHoppingDetection(SwtID, &aVlanHoppingAction) should return BCM_ERR_OK

      - Check whether the aVlanHoppingAction is ETHSWT_SECURITY_ACTION_DROP_PKT or not

      - Get Rx stat of TestPort1 before sending the packets
        ETHSWT_GetRxStat(SwtID, TestPort1, &rxStat1) should return BCM_ERR_OK

      - Get buffer from Ethernet Driver
        aPriority = 3UL
        pktLen = sizeof(ipv4_pkt) + NIF_VLAN_TAG_SIZE + NIF_VLAN_TAG_SIZE + NIF_ETHERTYPE_SIZE
        ETHER_GetTxBuffer(SwtID, aPriority, &bufIdx, &pktBuf, &pktLen) should return BCM_ERR_OK

      - Insert VLAN tag1
       *((ETHER_EtherType *)(pktBuf)) = CPU_NativeToBE16(ETHER_ETHERTYPE_VLANTAG)
        pktLen -= NIF_VLAN_TAG_SIZE
        pktBuf += 2UL;
        *((ETHER_VLANIDType *)(pktBuf)) = CPU_NativeToBE16(0U | (aPriority << 13UL) | (vlanID & 0xFFFU));
        pktBuf += 2UL;

      - Insert VLAN tag2
       *((ETHER_EtherType *)(pktBuf)) = CPU_NativeToBE16(ETHER_ETHERTYPE_VLANTAG)
        pktLen -= NIF_VLAN_TAG_SIZE
        pktBuf += 2UL;
        *((ETHER_VLANIDType *)(pktBuf)) = CPU_NativeToBE16(0U | (aPriority << 13UL) | (vlanID & 0xFFFU));
        pktBuf += 2UL;

      - Insert Ethertype
        *((ETHER_EtherType *)(pktBuf)) = CPU_NativeToBE16(ETHER_ETHERTYPE_IP);
         pktBuf += NIF_ETHERTYPE_SIZE

      - Copy the packet to be send, into the buffer
        memcpy(pktBuf, ipv4_pkt, sizeof(ipv4_pkt))

        mgmtInfo.switchIdx = SwtID;
        mgmtInfo.portIdx   = TestPort1
        mgmtInfo.tc        = ETHSWT_TC_4
        ETHSWT_SetMgmtInfo(SwtID, bufIdx, &mgmtInfo) should return BCM_ERR_OK

      - Send 5 packets
        ETHER_Send(SwtID, 1UL, bufIdx, pktLen, dstMacAddr)
        should return BCM_ERR_OK

      - Get Rx stat of TestPort1 after sending the packets
        ETHSWT_GetRxStat(SwtID, TestPort1, &rxStat2) should return BCM_ERR_OK

      - Check whether the difference of rxStat2.pktsRxDiscard and rxStat1.pktsRxDiscard is equal to 0UL or not
        #BRCM_SWQTST_ETHSWT_VLAN_HOPPING_DETECTION_DISABLE

      - Enable the VLAN Hopping detection
        aVlanHoppingAction = ETHSWT_SECURITY_ACTION_DROP_PKT
        ETHSWT_SetVlanHoppingDetection(SwtID, aVlanHoppingAction) should return BCM_ERR_OK

      - Get VLAN Hopping action
        ETHSWT_GetVlanHoppingDetection(SwtID, &aVlanHoppingAction) should return BCM_ERR_OK

      - Check whether the aVlanHoppingAction is ETHSWT_SECURITY_ACTION_DROP_PKT or not

      - Delete all the entries in ARL Table
    -# Terminate Security Test Task
   -#
    @endcode

    @board BCM8956X

    @auto           yes

    @type           Sanity

    @testproc #BRCM_SWQTST_ETHSWT_VLAN_HOPPING_DETECTION_DROP_PKT
    @testproc #BRCM_SWQTST_ETHSWT_VLAN_HOPPING_DETECTION_REDIRECT_TO_CPU
    @testproc #BRCM_SWQTST_ETHSWT_VLAN_HOPPING_DETECTION_DISABLE

*/
#define BRCM_SWQTSEQ_ETHSWT_SECURITY_VLAN_HOPPING_SEQ                    (0x313UL)

/** @brief Security features test "Address Limiting"

    This test simulates MAC Flooding to breach the security of
    the system using "macof" attack, And check the authenticity of
    "Address Limiting", Which is taken to prevent this well known attack.

    @code{.c}
   -# Activate Security Test Task
      - TestPort1 = 1UL (None)
      - TestPort2 = 2UL (Station movement enabled)
      - TestPort3 = 3UL (Sticky MAC address enabled)
      - TestPort4 = 4UL (Address limiting enabled)
      - IMP_PORT  = 8UL
      - SwtID = 0U
      - vlanID = 1024U
      - ethCtrlIdx = 0x0ULL
      - dstMacAddr[] = {0x30U, 0x80U, 0xC2U, 0x00U, 0x00U, 0x02U}
      - srcMacAddr[] = {0x02U, 0x00U, 0x00U, 0x01U, 0x29U, 0x51U}
      - Retrieve the NIF controller index for a INET client
      - Add vlan-1024 in NIF_CtrlVlanArray
      - MAX_ARL_ENTRY_TEST = 20
      - ETHSWT_ARLEntryType   aARLTbl[MAX_ARL_ENTRY_TEST]

   -# Initial setup
      - Delete all the entries in ARL Table
   -# Setup for "Address Limiting" feature

      - Set loopback on TestPort4
        ETHSWT_SetPortLoopbackMode(SwtID, TestPort4, ETHXCVR_BOOLEAN_TRUE)
        should return BCM_ERR_OK

      - Add TestPort1, TestPort4 and ARM-CPU port as part of vlan 1024
        ETHSWT_AddVLANPorts(SwtID, 0x01FF , 1024U, 0x01FF) should return BCM_ERR_OK

      - Get Address Limiting information of TestPort4
        ETHSWT_GetPortAddrLimitAndCounter(0U, TestPort4, &addressLimitInfo, &aPortLearnedCounter, &aPortOverLimitCounter) should return BCM_ERR_OK

      - Check whether the addressLimitInfo.overLimitAction is ETHSWT_SECURITY_ACTION_DROP_PKT and
        addressLimitInfo.macLearningLimit is 5U or not

      - Get Rx stat of TestPort4 before sending the packets
        ETHSWT_GetRxStat(SwtID, TestPort4, &rxStat1) should return BCM_ERR_OK

      - Set number of INET IPv4 packets received on ARM-CPU to zero
        numRxPkts = 0UL

      - Loop (addressLimitInfo.macLearningLimit) times :
         -- Set Source MAC Address with new value
            srcMacAddr[5] += 1U;
            ETHER_SetMacAddr(SwtID, srcMacAddr) should return BCM_ERR_OK

         -- Transmit 1 IPv4 packets, with destination MAC address dstMacAddr(30:80:C2:00:00:02) and
            srcMacAddr (new SA-MAC), destined to TestPort4.
        length = 90U
        NIF_GetTxBuffer(*ethCtrlIdx, ETHER_ETHERTYPE_IP, 6U, &bufIdx, &pdu, &length)
        BCM_MemCpy(pdu, ipv4_pkt, sizeof(ipv4_pkt))
        mgmtInfo.switchIdx = 0UL
        mgmtInfo.portIdx   = TestPort4
        mgmtInfo.tc        = ETHSWT_TC_4
        ret = NIF_SwtSetMgmtInfo(*ethCtrlIdx, bufIdx, &mgmtInfo)
        NIF_Send(ethCtrlIdx, ETHER_ETHERTYPE_IP, 1UL, bufIdx, sizeof(ipv4_pkt), dstMacAddr)

        end loop

      - Get Rx stat of TestPort4 after sending the packets
        ETHSWT_GetRxStat(SwtID, TestPort4, &rxStat2) should return BCM_ERR_OK

      - Check whether the difference of rxStat2.pktsRxDiscard and rxStat1.pktsRxDiscard is equal to 0UL or not
        and also check numRxPkts is equal to 5UL or not

      - Read the ARL table
        aTblSize = MAX_ARL_ENTRY_TEST;
        ETHSWT_GetARLTable(0U, aARLTbl, &aTblSize) should return BCM_ERR_OK

      - Verify that aTblSize is equal to addressLimitInfo.macLearningLimit or not

      - Check the overlimit counter is 0 or not and also check learnt counter is 5 or not.
        ETHSWT_GetPortAddrLimitAndCounter(SwtID, TestPort4, &addressLimitInfo) should return BCM_ERR_OK

      - Get Rx stat of TestPort4 before sending the packets
        ETHSWT_GetRxStat(SwtID, TestPort4, &rxStat1) should return BCM_ERR_OK

      - Set number of INET IPv4 packets received on ARM-CPU to zero
        numRxPkts = 0UL

      - Loop 5 times :
         -- Set Source MAC Address with new value
            srcMacAddr[5] += 1U;
            ETHER_SetMacAddr(SwtID, srcMacAddr) should return BCM_ERR_OK

         -- Transmit 1 IPv4 packets, with destination MAC address dstMacAddr(30:80:C2:00:00:02) and
            srcMacAddr (new SA-MAC), destined to TestPort4.
        length = 90U
        NIF_GetTxBuffer(*ethCtrlIdx, ETHER_ETHERTYPE_IP, 6U, &bufIdx, &pdu, &length)
        BCM_MemCpy(pdu, ipv4_pkt, sizeof(ipv4_pkt))
        mgmtInfo.switchIdx = 0UL
        mgmtInfo.portIdx   = TestPort4
        mgmtInfo.tc        = ETHSWT_TC_4
        ret = NIF_SwtSetMgmtInfo(*ethCtrlIdx, bufIdx, &mgmtInfo)
        NIF_Send(ethCtrlIdx, ETHER_ETHERTYPE_IP, 1UL, bufIdx, sizeof(ipv4_pkt), dstMacAddr)

        end loop

      - Get Rx stat of TestPort4 after sending the packets
        ETHSWT_GetRxStat(SwtID, TestPort4, &rxStat2) should return BCM_ERR_OK

      - Check whether the difference of rxStat2.pktsRxDiscard and rxStat1.pktsRxDiscard is equal to 5UL or not
        and also check numRxPkts is equal to 0UL or not

      - Check the overlimit counter is 5 or not.
        ETHSWT_GetPortAddrLimitAndCounter(SwtID, TestPort4, &addressLimitInfo) should return BCM_ERR_OK

      - Read the ARL table
        aTblSize = MAX_ARL_ENTRY_TEST;
        ETHSWT_GetARLTable(0U, aARLTbl, &aTblSize) should return BCM_ERR_OK

      - Verify that aTblSize is equal to addressLimitInfo.macLearningLimit or not
        #BRCM_SWQTST_ETHSWT_ADDRESS_LIMITING_ENABLE_DROP_PKT

      - Clear Address Limiting on TestPort4
        addressLimitInfo.overLimitAction = ETHSWT_SECURITY_ACTION_DISABLED;
        ETHSWT_SetPortAddrLimiting(SwtID, TestPort4, &addressLimitInfo) should return BCM_ERR_OK

      - Get Address Limiting information of TestPort4
        ETHSWT_GetPortAddrLimitAndCounter(0U, TestPort4, &addressLimitInfo, &aPortLearnedCounter, &aPortOverLimitCounter) should return BCM_ERR_OK

      - Check whether the addressLimitInfo.overLimitAction is ETHSWT_SECURITY_ACTION_DISABLED or not

      - Get Rx stat of TestPort4 before sending the packets
        ETHSWT_GetRxStat(SwtID, TestPort4, &rxStat1) should return BCM_ERR_OK

      - Set number of INET IPv4 packets received on ARM-CPU to zero
        numRxPkts = 0UL

      - Loop 5 times :
         -- Set Source MAC Address with new value
            srcMacAddr[5] += 1U;
            ETHER_SetMacAddr(SwtID, srcMacAddr) should return BCM_ERR_OK

         -- Transmit 1 IPv4 packets, with destination MAC address dstMacAddr(30:80:C2:00:00:02) and
            srcMacAddr (new SA-MAC), destined to TestPort4.
        length = 90U
        NIF_GetTxBuffer(*ethCtrlIdx, ETHER_ETHERTYPE_IP, 6U, &bufIdx, &pdu, &length)
        BCM_MemCpy(pdu, ipv4_pkt, sizeof(ipv4_pkt))
        mgmtInfo.switchIdx = 0UL
        mgmtInfo.portIdx   = TestPort4
        mgmtInfo.tc        = ETHSWT_TC_4
        ret = NIF_SwtSetMgmtInfo(*ethCtrlIdx, bufIdx, &mgmtInfo)
        NIF_Send(ethCtrlIdx, ETHER_ETHERTYPE_IP, 1UL, bufIdx, sizeof(ipv4_pkt), dstMacAddr)

        end loop

      - Get Rx stat of TestPort4 after sending the packets
        ETHSWT_GetRxStat(SwtID, TestPort4, &rxStat2) should return BCM_ERR_OK

      - Check whether the difference of rxStat2.pktsRxDiscard and rxStat1.pktsRxDiscard is equal to 0UL or not
        and also check numRxPkts is equal to 5UL or not

      - Read the ARL table
        aTblSize = MAX_ARL_ENTRY_TEST;
        ETHSWT_GetARLTable(0U, aARLTbl, &aTblSize) should return BCM_ERR_OK

      - Verify that aTblSize is equal to (addressLimitInfo.macLearningLimit + 5UL) or not

      - Check the overlimit counter is 0 or not.
        ETHSWT_GetPortAddrLimitAndCounter(SwtID, TestPort4, &addressLimitInfo) should return BCM_ERR_OK
        #BRCM_SWQTST_ETHSWT_ADDRESS_LIMITING_DISABLE_ON_PORT

      - Delete all the entries in ARL Table

      - Set Address Limiting to TestPort4
        addressLimitInfo.overLimitAction = ETHSWT_SECURITY_ACTION_REDIRECT_TO_CPU;
        addressLimitInfo.macLearningLimit = 5U;
        ETHSWT_SetPortAddrLimiting(SwtID, TestPort4, &addressLimitInfo) should return BCM_ERR_OK

      - Get Address Limiting information of TestPort4
        ETHSWT_GetPortAddrLimitAndCounter(0U, TestPort4, &addressLimitInfo, &aPortLearnedCounter, &aPortOverLimitCounter) should return BCM_ERR_OK

      - Check whether the addressLimitInfo.overLimitAction is ETHSWT_SECURITY_ACTION_REDIRECT_TO_CPU and
        addressLimitInfo.macLearningLimit is 5U or not

      - Get source MAC Address
        ETHER_GetMacAddr(SwtID, srcMacAddr) should return BCM_ERR_OK

      - Loop (addressLimitInfo.macLearningLimit) times :
         -- Set Source MAC Address with new value
            srcMacAddr[5] += 1U;
            ETHER_SetMacAddr(SwtID, srcMacAddr) should return BCM_ERR_OK

         -- Transmit 1 IPv4 packets, with destination MAC address dstMacAddr(30:80:C2:00:00:02) and
            srcMacAddr (new SA-MAC), destined to TestPort4.
        length = 90U
        NIF_GetTxBuffer(*ethCtrlIdx, ETHER_ETHERTYPE_IP, 6U, &bufIdx, &pdu, &length)
        BCM_MemCpy(pdu, ipv4_pkt, sizeof(ipv4_pkt))
        mgmtInfo.switchIdx = 0UL
        mgmtInfo.portIdx   = TestPort4
        mgmtInfo.tc        = ETHSWT_TC_4
        ret = NIF_SwtSetMgmtInfo(*ethCtrlIdx, bufIdx, &mgmtInfo)
        NIF_Send(ethCtrlIdx, ETHER_ETHERTYPE_IP, 1UL, bufIdx, sizeof(ipv4_pkt), dstMacAddr)

        end loop

      - Read the ARL table
        aTblSize = MAX_ARL_ENTRY_TEST;
        ETHSWT_GetARLTable(0U, aARLTbl, &aTblSize) should return BCM_ERR_OK

      - Verify that aTblSize is equal to addressLimitInfo.macLearningLimit or not

      - Check the overlimit counter is 0 or not and also check learnt counter is
        equal to addressLimitInfo.macLearningLimit or not.
        ETHSWT_GetPortAddrLimitAndCounter(SwtID, TestPort4, &addressLimitInfo) should return BCM_ERR_OK

      - Get Tx stat of IMP Port before sending the packets
        ETHSWT_GetTxStat(SwtID, IMP_PORT, &txStat1) should return BCM_ERR_OK

      - Get Tx stat of Port-7 before sending the packets
        ETHSWT_GetTxStat(SwtID, 7UL, &p7TxStat1) should return BCM_ERR_OK

      - Loop 5 times :
         -- Set Source MAC Address with new value
            srcMacAddr[5] += 1U;
            ETHER_SetMacAddr(SwtID, srcMacAddr) should return BCM_ERR_OK

         -- Transmit 1 IPv4 packets, with destination MAC address dstMacAddr(30:80:C2:00:00:02) and
            srcMacAddr (new SA-MAC), destined to TestPort4.
        length = 90U
        NIF_GetTxBuffer(*ethCtrlIdx, ETHER_ETHERTYPE_IP, 6U, &bufIdx, &pdu, &length)
        BCM_MemCpy(pdu, ipv4_pkt, sizeof(ipv4_pkt))
        mgmtInfo.switchIdx = 0UL
        mgmtInfo.portIdx   = TestPort4
        mgmtInfo.tc        = ETHSWT_TC_4
        ret = NIF_SwtSetMgmtInfo(*ethCtrlIdx, bufIdx, &mgmtInfo)
        NIF_Send(ethCtrlIdx, ETHER_ETHERTYPE_IP, 1UL, bufIdx, sizeof(ipv4_pkt), dstMacAddr)

        end loop

      - Get Tx stat of IMP Port after sending the packets
        ETHSWT_GetTxStat(SwtID, IMP_PORT, &txStat2) should return BCM_ERR_OK

      - Check whether the difference of txStat2.unicast and txStat1.unicast is equal to 5UL or not

      - Get Tx stat of Port-7 after sending the packets
        ETHSWT_GetTxStat(SwtID, 7UL, &p7TxStat2) should return BCM_ERR_OK

      - Check whether the difference of p7TxStat2.unicast and p7TxStat1.unicast is equal to 0UL or not

      - Check the overlimit counter is 5 or not.
        ETHSWT_GetPortAddrLimitAndCounter(SwtID, TestPort4, &addressLimitInfo) should return BCM_ERR_OK

      - Read the ARL table
        aTblSize = MAX_ARL_ENTRY_TEST;
        ETHSWT_GetARLTable(0U, aARLTbl, &aTblSize) should return BCM_ERR_OK

      - Verify that aTblSize is equal to addressLimitInfo.macLearningLimit or not
        #BRCM_SWQTST_ETHSWT_ADDRESS_LIMITING_ENABLE_REDIRECT_TO_CPU

      - Delete all the entries in ARL Table

      - Set Address Limiting to TestPort4
        addressLimitInfo.overLimitAction = ETHSWT_SECURITY_ACTION_NORMAL;
        addressLimitInfo.macLearningLimit = 5U;
        ETHSWT_SetPortAddrLimiting(SwtID, TestPort4, &addressLimitInfo) should return BCM_ERR_OK

      - Get Address Limiting information of TestPort4
        ETHSWT_GetPortAddrLimitAndCounter(0U, TestPort4, &addressLimitInfo, &aPortLearnedCounter, &aPortOverLimitCounter) should return BCM_ERR_OK

      - Check whether the addressLimitInfo.overLimitAction is ETHSWT_SECURITY_ACTION_NORMAL and
        addressLimitInfo.macLearningLimit is 5U or not

      - Get source MAC Address
        ETHER_GetMacAddr(SwtID, srcMacAddr) should return BCM_ERR_OK

      - Get Rx stat of TestPort4 before sending the packets
        ETHSWT_GetRxStat(SwtID, TestPort4, &rxStat1) should return BCM_ERR_OK

      - Set number of INET IPv4 packets received on ARM-CPU to zero
        numRxPkts = 0UL

      - Loop (addressLimitInfo.macLearningLimit) times :
         -- Set Source MAC Address with new value
            srcMacAddr[5] += 1U;
            ETHER_SetMacAddr(SwtID, srcMacAddr) should return BCM_ERR_OK

         -- Transmit 1 IPv4 packets, with destination MAC address dstMacAddr(30:80:C2:00:00:02) and
            srcMacAddr (new SA-MAC), destined to TestPort4.
        length = 90U
        NIF_GetTxBuffer(*ethCtrlIdx, ETHER_ETHERTYPE_IP, 6U, &bufIdx, &pdu, &length)
        BCM_MemCpy(pdu, ipv4_pkt, sizeof(ipv4_pkt))
        mgmtInfo.switchIdx = 0UL
        mgmtInfo.portIdx   = TestPort4
        mgmtInfo.tc        = ETHSWT_TC_4
        ret = NIF_SwtSetMgmtInfo(*ethCtrlIdx, bufIdx, &mgmtInfo)
        NIF_Send(ethCtrlIdx, ETHER_ETHERTYPE_IP, 1UL, bufIdx, sizeof(ipv4_pkt), dstMacAddr)

        end loop

      - Get Rx stat of TestPort4 after sending the packets
        ETHSWT_GetRxStat(SwtID, TestPort4, &rxStat2) should return BCM_ERR_OK

      - Check whether the difference of rxStat2.pktsRxDiscard and rxStat1.pktsRxDiscard is equal
        to 0UL or not and also check numRxPkts is equal to addressLimitInfo.macLearningLimit or not

      - Read the ARL table
        aTblSize = MAX_ARL_ENTRY_TEST;
        ETHSWT_GetARLTable(0U, aARLTbl, &aTblSize) should return BCM_ERR_OK

      - Verify that aTblSize is equal to addressLimitInfo.macLearningLimit or not

      - Check the overlimit counter is 0 or not and also check learnt counter is
        equal to addressLimitInfo.macLearningLimit or not.
        ETHSWT_GetPortAddrLimitAndCounter(SwtID, TestPort4, &addressLimitInfo) should return BCM_ERR_OK

      - Get Rx stat of TestPort4 before sending the packets
        ETHSWT_GetRxStat(SwtID, TestPort4, &rxStat1) should return BCM_ERR_OK

      - Set number of INET IPv4 packets received on ARM-CPU to zero
        numRxPkts = 0UL

      - Loop 5 times :
         -- Set Source MAC Address with new value
            srcMacAddr[5] += 1U;
            ETHER_SetMacAddr(SwtID, srcMacAddr) should return BCM_ERR_OK

         -- Transmit 1 IPv4 packets, with destination MAC address dstMacAddr(30:80:C2:00:00:02) and
            srcMacAddr (new SA-MAC), destined to TestPort4.
        length = 90U
        NIF_GetTxBuffer(*ethCtrlIdx, ETHER_ETHERTYPE_IP, 6U, &bufIdx, &pdu, &length)
        BCM_MemCpy(pdu, ipv4_pkt, sizeof(ipv4_pkt))
        mgmtInfo.switchIdx = 0UL
        mgmtInfo.portIdx   = TestPort4
        mgmtInfo.tc        = ETHSWT_TC_4
        ret = NIF_SwtSetMgmtInfo(*ethCtrlIdx, bufIdx, &mgmtInfo)
        NIF_Send(ethCtrlIdx, ETHER_ETHERTYPE_IP, 1UL, bufIdx, sizeof(ipv4_pkt), dstMacAddr)

        end loop

      - Get Rx stat of TestPort4 after sending the packets
        ETHSWT_GetRxStat(SwtID, TestPort4, &rxStat2) should return BCM_ERR_OK

      - Check whether the difference of rxStat2.pktsRxDiscard and rxStat1.pktsRxDiscard is equal to 0UL or not
        and also check numRxPkts is equal to 5UL or not

      - Read the ARL table
        aTblSize = MAX_ARL_ENTRY_TEST;
        ETHSWT_GetARLTable(0U, aARLTbl, &aTblSize) should return BCM_ERR_OK

      - Verify that aTblSize is equal to addressLimitInfo.macLearningLimit or not

      - Check the overlimit counter is 5 or not.
        ETHSWT_GetPortAddrLimitAndCounter(SwtID, TestPort4, &addressLimitInfo) should return BCM_ERR_OK
        #BRCM_SWQTST_ETHSWT_ADDRESS_LIMITING_ENABLE_NORMAL

      - Delete all the entries in ARL Table

      - Set Address Limiting to TestPort4
        addressLimitInfo.overLimitAction = ETHSWT_SECURITY_ACTION_COPY_TO_CPU;
        addressLimitInfo.macLearningLimit = 5U;
        ETHSWT_SetPortAddrLimiting(SwtID, TestPort4, &addressLimitInfo) should return BCM_ERR_OK

      - Get Address Limiting information of TestPort4
        ETHSWT_GetPortAddrLimitAndCounter(0U, TestPort4, &addressLimitInfo, &aPortLearnedCounter, &aPortOverLimitCounter) should return BCM_ERR_OK

      - Check whether the addressLimitInfo.overLimitAction is ETHSWT_SECURITY_ACTION_COPY_TO_CPU and
        addressLimitInfo.macLearningLimit is 5U or not

      - Get source MAC Address
        ETHER_GetMacAddr(SwtID, srcMacAddr) should return BCM_ERR_OK

      - Get Rx stat of TestPort4 before sending the packets
        ETHSWT_GetRxStat(SwtID, TestPort4, &rxStat1) should return BCM_ERR_OK

      - Set number of INET IPv4 packets received on ARM-CPU to zero
        numRxPkts = 0UL

      - Loop (addressLimitInfo.macLearningLimit) times :
         -- Set Source MAC Address with new value
            srcMacAddr[5] += 1U;
            ETHER_SetMacAddr(SwtID, srcMacAddr) should return BCM_ERR_OK

         -- Transmit 1 IPv4 packets, with destination MAC address dstMacAddr(30:80:C2:00:00:02) and
            srcMacAddr (new SA-MAC), destined to TestPort4.
        length = 90U
        NIF_GetTxBuffer(*ethCtrlIdx, ETHER_ETHERTYPE_IP, 6U, &bufIdx, &pdu, &length)
        BCM_MemCpy(pdu, ipv4_pkt, sizeof(ipv4_pkt))
        mgmtInfo.switchIdx = 0UL
        mgmtInfo.portIdx   = TestPort4
        mgmtInfo.tc        = ETHSWT_TC_4
        ret = NIF_SwtSetMgmtInfo(*ethCtrlIdx, bufIdx, &mgmtInfo)
        NIF_Send(ethCtrlIdx, ETHER_ETHERTYPE_IP, 1UL, bufIdx, sizeof(ipv4_pkt), dstMacAddr)

        end loop

      - Get Rx stat of TestPort4 after sending the packets
        ETHSWT_GetRxStat(SwtID, TestPort4, &rxStat2) should return BCM_ERR_OK

      - Check whether the difference of rxStat2.pktsRxDiscard and rxStat1.pktsRxDiscard is equal
        to 0UL or not and also check numRxPkts is equal to addressLimitInfo.macLearningLimit or not

      - Read the ARL table
        aTblSize = MAX_ARL_ENTRY_TEST;
        ETHSWT_GetARLTable(0U, aARLTbl, &aTblSize) should return BCM_ERR_OK

      - Verify that aTblSize is equal to addressLimitInfo.macLearningLimit or not

      - Check the overlimit counter is 0 or not and also check learnt counter is
        equal to addressLimitInfo.macLearningLimit or not.
        ETHSWT_GetPortAddrLimitAndCounter(SwtID, TestPort4, &addressLimitInfo) should return BCM_ERR_OK

      - Get Tx stat of IMP Port before sending the packets
        ETHSWT_GetTxStat(SwtID, IMP_PORT, &txStat1) should return BCM_ERR_OK

      - Get Tx stat of Port-7 before sending the packets
        ETHSWT_GetTxStat(SwtID, 7UL, &p7TxStat1) should return BCM_ERR_OK

      - Set number of INET IPv4 packets received on ARM-CPU to zero
        numRxPkts = 0UL

      - Loop 5 times :
         -- Set Source MAC Address with new value
            srcMacAddr[5] += 1U;
            ETHER_SetMacAddr(SwtID, srcMacAddr) should return BCM_ERR_OK

         -- Transmit 1 IPv4 packets, with destination MAC address dstMacAddr(30:80:C2:00:00:02) and
            srcMacAddr (new SA-MAC), destined to TestPort4.
        length = 90U
        NIF_GetTxBuffer(*ethCtrlIdx, ETHER_ETHERTYPE_IP, 6U, &bufIdx, &pdu, &length)
        BCM_MemCpy(pdu, ipv4_pkt, sizeof(ipv4_pkt))
        mgmtInfo.switchIdx = 0UL
        mgmtInfo.portIdx   = TestPort4
        mgmtInfo.tc        = ETHSWT_TC_4
        ret = NIF_SwtSetMgmtInfo(*ethCtrlIdx, bufIdx, &mgmtInfo)
        NIF_Send(ethCtrlIdx, ETHER_ETHERTYPE_IP, 1UL, bufIdx, sizeof(ipv4_pkt), dstMacAddr)

        end loop

      - Get Tx stat of IMP Port after sending the packets
        ETHSWT_GetTxStat(SwtID, IMP_PORT, &txStat2) should return BCM_ERR_OK

      - Check whether the difference of txStat2.unicast and txStat1.unicast is equal to 5UL or not

      - Get Tx stat of Port-7 after sending the packets
        ETHSWT_GetTxStat(SwtID, 7UL, &p7TxStat2) should return BCM_ERR_OK

      - Check whether the difference of p7TxStat2.unicast and p7TxStat1.unicast is equal to 5UL or not

      - Check numRxPkts is equal to 5UL or not

      - Read the ARL table
        aTblSize = MAX_ARL_ENTRY_TEST;
        ETHSWT_GetARLTable(0U, aARLTbl, &aTblSize) should return BCM_ERR_OK

      - Verify that aTblSize is equal to addressLimitInfo.macLearningLimit or not

      - Check the overlimit counter is 5 or not.
        ETHSWT_GetPortAddrLimitAndCounter(SwtID, TestPort4, &addressLimitInfo) should return BCM_ERR_OK
        #BRCM_SWQTST_ETHSWT_ADDRESS_LIMITING_ENABLE_COPY_TO_CPU

      - Clear Address Limiting on TestPort4
        addressLimitInfo.overLimitAction = ETHSWT_SECURITY_ACTION_DISABLED;
        ETHSWT_SetPortAddrLimiting(SwtID, TestPort4, &addressLimitInfo) should return BCM_ERR_OK

      - Get Address Limiting information of TestPort4
        ETHSWT_GetPortAddrLimitAndCounter(0U, TestPort4, &addressLimitInfo, &aPortLearnedCounter, &aPortOverLimitCounter) should return BCM_ERR_OK

      - Check whether the addressLimitInfo.overLimitAction is ETHSWT_SECURITY_ACTION_DISABLED or not

      - Delete all the entries in ARL Table

        portMACLimit4  = 3U
        portMACLimit1  = 3U
        totalMACLimit  = 5U

      - Set Address Limiting to TestPort4
        addressLimitInfo.overLimitAction = ETHSWT_SECURITY_ACTION_DROP_PKT;
        addressLimitInfo.macLearningLimit = portMACLimit4;
        ETHSWT_SetPortAddrLimiting(SwtID, TestPort4, &addressLimitInfo) should return BCM_ERR_OK

      - Get Address Limiting information of TestPort4
        ETHSWT_GetPortAddrLimitAndCounter(0U, TestPort4, &addressLimitInfo, &aPortLearnedCounter, &aPortOverLimitCounter) should return BCM_ERR_OK

      - Check whether the addressLimitInfo.overLimitAction is ETHSWT_SECURITY_ACTION_DROP_PKT and
        addressLimitInfo.macLearningLimit is portMACLimit4 or not

      - Set Address Limiting to TestPort1
        addressLimitInfo.overLimitAction = ETHSWT_SECURITY_ACTION_DROP_PKT;
        addressLimitInfo.macLearningLimit = portMACLimit1;
        ETHSWT_SetPortAddrLimiting(SwtID, TestPort1, &addressLimitInfo) should return BCM_ERR_OK

      - Get Address Limiting information of TestPort1
        ETHSWT_GetPortAddrLimitAndCounter(0U, TestPort1, &addressLimitInfo, &aPortLearnedCounter, &aPortOverLimitCounter) should return BCM_ERR_OK

      - Check whether the addressLimitInfo.overLimitAction is ETHSWT_SECURITY_ACTION_DROP_PKT and
        addressLimitInfo.macLearningLimit is portMACLimit1 or not

      - Set Address Limiting learn counter across all the port
        ETHSWT_SetTotalAddrLimit(SwtID, totalMACLimit) should return BCM_ERR_OK

      - Loop portMACLimit4 times :
         -- Set Source MAC Address with new value
            srcMacAddr[5] += 1U;
            ETHER_SetMacAddr(SwtID, srcMacAddr) should return BCM_ERR_OK

         -- Transmit 1 IPv4 packets, with destination MAC address dstMacAddr(30:80:C2:00:00:02) and
            srcMacAddr (new SA-MAC), destined to TestPort4.
        length = 90U
        NIF_GetTxBuffer(*ethCtrlIdx, ETHER_ETHERTYPE_IP, 6U, &bufIdx, &pdu, &length)
        BCM_MemCpy(pdu, ipv4_pkt, sizeof(ipv4_pkt))
        mgmtInfo.switchIdx = 0UL
        mgmtInfo.portIdx   = TestPort4
        mgmtInfo.tc        = ETHSWT_TC_4
        ret = NIF_SwtSetMgmtInfo(*ethCtrlIdx, bufIdx, &mgmtInfo)
        NIF_Send(ethCtrlIdx, ETHER_ETHERTYPE_IP, 1UL, bufIdx, sizeof(ipv4_pkt), dstMacAddr)

        end loop

      - Check the overlimit counter is 0 or not and also check learnt counter is
        equal to portMACLimit4 or not.
        ETHSWT_GetPortAddrLimitAndCounter(SwtID, TestPort4, &addressLimitInfo) should return BCM_ERR_OK

     - Clear loopback on TestPort4
       ETHSWT_SetPortLoopbackMode(SwtID, TestPort4, ETHXCVR_BOOLEAN_FALSE) should return BCM_ERR_OK

      - Set loopback on TestPort1
       ETHSWT_SetPortLoopbackMode(SwtID, TestPort1, ETHXCVR_BOOLEAN_TRUE)
       should return BCM_ERR_OK

      - Loop (totalMACLimit - portMACLimit4) times :
         -- Set Source MAC Address with new value
            srcMacAddr[5] += 1U;
            ETHER_SetMacAddr(SwtID, srcMacAddr) should return BCM_ERR_OK

         -- Transmit 1 IPv4 packets, with destination MAC address dstMacAddr(30:80:C2:00:00:02) and
            srcMacAddr (new SA-MAC), destined to TestPort1.
        length = 90U
        NIF_GetTxBuffer(*ethCtrlIdx, ETHER_ETHERTYPE_IP, 6U, &bufIdx, &pdu, &length)
        BCM_MemCpy(pdu, ipv4_pkt, sizeof(ipv4_pkt))
        mgmtInfo.switchIdx = 0UL
        mgmtInfo.portIdx   = TestPort1
        mgmtInfo.tc        = ETHSWT_TC_4
        ret = NIF_SwtSetMgmtInfo(*ethCtrlIdx, bufIdx, &mgmtInfo)
        NIF_Send(ethCtrlIdx, ETHER_ETHERTYPE_IP, 1UL, bufIdx, sizeof(ipv4_pkt), dstMacAddr)

        end loop

      - Check the overlimit counter is 0 or not and also check learnt counter is
        equal to (totalMACLimit - portMACLimit4) or not.
        ETHSWT_GetPortAddrLimitAndCounter(SwtID, TestPort1, &addressLimitInfo) should return BCM_ERR_OK

      - Check the total learnt counter across the port is equal to totalMACLimit or not.
        ETHSWT_GetTotalAddrLimitAndCounter(SwtID, &aTotalMACLearningLimit, &aTotalLearnedCounter)
        should return BCM_ERR_OK

      - Read the ARL table
        aTblSize = MAX_ARL_ENTRY_TEST;
        ETHSWT_GetARLTable(0U, aARLTbl, &aTblSize) should return BCM_ERR_OK

      - Verify that aTblSize is equal to totalMACLimit or not

      - Get Rx stat of TestPort1 before sending the packets
        ETHSWT_GetRxStat(SwtID, TestPort1, &rxStat1) should return BCM_ERR_OK

      - Set number of INET IPv4 packets received on ARM-CPU to zero
        numRxPkts = 0UL

      - Loop 5 times :
         -- Set Source MAC Address with new value
            srcMacAddr[5] += 1U;
            ETHER_SetMacAddr(SwtID, srcMacAddr) should return BCM_ERR_OK

         -- Transmit 1 IPv4 packets, with destination MAC address dstMacAddr(30:80:C2:00:00:02) and
            srcMacAddr (new SA-MAC), destined to TestPort1.
        length = 90U
        NIF_GetTxBuffer(*ethCtrlIdx, ETHER_ETHERTYPE_IP, 6U, &bufIdx, &pdu, &length)
        BCM_MemCpy(pdu, ipv4_pkt, sizeof(ipv4_pkt))
        mgmtInfo.switchIdx = 0UL
        mgmtInfo.portIdx   = TestPort1
        mgmtInfo.tc        = ETHSWT_TC_4
        ret = NIF_SwtSetMgmtInfo(*ethCtrlIdx, bufIdx, &mgmtInfo)
        NIF_Send(ethCtrlIdx, ETHER_ETHERTYPE_IP, 1UL, bufIdx, sizeof(ipv4_pkt), dstMacAddr)

        end loop

      - Get Rx stat of TestPort1 after sending the packets
        ETHSWT_GetRxStat(SwtID, TestPort1, &rxStat2) should return BCM_ERR_OK

      - Check whether the difference of rxStat2.pktsRxDiscard and rxStat1.pktsRxDiscard is equal
        to 5UL or not and also check numRxPkts is equal to 0UL or not

      - Check the overlimit counter is 5UL or not and also check learnt counter is
        equal to (totalMACLimit - portMACLimit4) or not.
        ETHSWT_GetPortAddrLimitAndCounter(SwtID, TestPort1, &addressLimitInfo) should return BCM_ERR_OK

      - Check the total learnt counter across the port is equal to totalMACLimit or not.
        ETHSWT_GetTotalAddrLimitAndCounter(SwtID, &aTotalMACLearningLimit, &aTotalLearnedCounter)
        should return BCM_ERR_OK

      - Read the ARL table
        aTblSize = MAX_ARL_ENTRY_TEST;
        ETHSWT_GetARLTable(0U, aARLTbl, &aTblSize) should return BCM_ERR_OK

      - Verify that aTblSize is equal to totalMACLimit or not
        #BRCM_SWQTST_ETHSWT_ADDRESS_LIMITING_ENABLE_ACCROSS_PORT

      - Clear Address Limiting on TestPort1
        addressLimitInfo.overLimitAction = ETHSWT_SECURITY_ACTION_DISABLED;
        ETHSWT_SetPortAddrLimiting(SwtID, TestPort1, &addressLimitInfo) should return BCM_ERR_OK

      - Get Address Limiting information of TestPort1
        ETHSWT_GetPortAddrLimitAndCounter(0U, TestPort1, &addressLimitInfo, &aPortLearnedCounter, &aPortOverLimitCounter) should return BCM_ERR_OK

      - Check whether the addressLimitInfo.overLimitAction is ETHSWT_SECURITY_ACTION_DISABLED or not

      - Set Address Limiting accross all the port with default limit
        totalMACLimit = 4096U
        ETHSWT_SetTotalAddrLimit(SwtID, totalMACLimit) should return BCM_ERR_OK

      - Clear loopback on TestPort4
        ETHSWT_SetPortLoopbackMode(SwtID, TestPort4, ETHXCVR_BOOLEAN_FALSE) should return BCM_ERR_OK

      - Clear loopback on TestPort1
        ETHSWT_SetPortLoopbackMode(SwtID, TestPort1, ETHXCVR_BOOLEAN_FALSE) should return BCM_ERR_OK

      - Set Address Limiting to TestPort4
        addressLimitInfo.overLimitAction = ETHSWT_SECURITY_ACTION_DROP_PKT;
        addressLimitInfo.macLearningLimit = 5U;
        ETHSWT_SetPortAddrLimiting(SwtID, TestPort4, &addressLimitInfo) should return BCM_ERR_OK

      - Get Address Limiting information of TestPort4
        ETHSWT_GetPortAddrLimitAndCounter(0U, TestPort4, &addressLimitInfo, &aPortLearnedCounter, &aPortOverLimitCounter) should return BCM_ERR_OK

      - Check whether the addressLimitInfo.overLimitAction is ETHSWT_SECURITY_ACTION_DROP_PKT and
        addressLimitInfo.macLearningLimit is 5U or not

      - Delete all the entries in ARL Table
    -# Terminate Security Test Task

    @endcode

    @board BCM8956X

    @auto           yes

    @type           Sanity

    @testproc #BRCM_SWQTST_ETHSWT_ADDRESS_LIMITING_ENABLE_DROP_PKT
    @testproc #BRCM_SWQTST_ETHSWT_ADDRESS_LIMITING_DISABLE_ON_PORT
    @testproc #BRCM_SWQTST_ETHSWT_ADDRESS_LIMITING_ENABLE_REDIRECT_TO_CPU
    @testproc #BRCM_SWQTST_ETHSWT_ADDRESS_LIMITING_ENABLE_NORMAL
    @testproc #BRCM_SWQTST_ETHSWT_ADDRESS_LIMITING_ENABLE_COPY_TO_CPU
    @testproc #BRCM_SWQTST_ETHSWT_ADDRESS_LIMITING_ENABLE_ACCROSS_PORT
*/
#define BRCM_SWQTSEQ_ETHSWT_SECURITY_ADDRESS_LIMITING_SEQ                (0x314UL)

#endif /* SECURITY_QT_H */

/** @} */