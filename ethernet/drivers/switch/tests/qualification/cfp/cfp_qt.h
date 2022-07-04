/*****************************************************************************
 Copyright 2019-2021 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_cfp_qt Qualification Tests
    @ingroup grp_ethswt

    @addtogroup grp_cfp_qt
    @{

    @file cfp_qt.h
    @brief CFP Integration Test
    This file contains test cases and test sequences for CFP.
    @version 0.1 Initial version
*/

#ifndef CFP_QT_H
#define CFP_QT_H

/**
    @brief Send untagged packets with a CFP Non-IP rule to steer untagged packets to ARM

    @pre
        -# gPTP client should be registered
        -# Ethernet loopback should be enabled on test port

    @test CFP Non-IP rule with CTagStatus value as Un-Tagged should allow only un-tagged
    packets.

    @post
        -# all untagged transmitted packets should be received.
        -# green statistics counter should be same as transmitted count, while others should be zero

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_ETHSWT_CFP
*/
#define BRCM_SWQTST_ETHSWT_CFP_NON_IP_UNTAGGED_WITH_UNTAGGED_PKT       (0x101UL)

/**
    @brief  Send VLAN-tagged packets with a CFP Non-IP rule to allow only un-tagged packets

    @pre
        -# gPTP client should be registered
        -# Ethernet loopback should be enabled on test port

    @test CFP Non-IP rule with CTagStatus value as Un-Tagged should not allow VLAN-tagged
    packets.

    @post
        -# all VLAN-tagged transmitted packets should be dropped.
        -# all statistics counters should not be changed

    @functional     Yes

    @type           Neg

    @trace #BRCM_SWREQ_ETHSWT_CFP
*/
#define BRCM_SWQTST_ETHSWT_CFP_NON_IP_UNTAGGED_WITH_VLAN_TAGGED_PKT    (0x102UL)

/**
    @brief  Send un-tagged packets with a CFP Non-IP rule to allow only VLAN tagged packets

    @pre
        -# gPTP client should be registered
        -# Ethernet loopback should be enabled on test port

    @test CFP Non-IP rule with CTagStatus value as VLAN-Tagged should not allow un-tagged
    packets.

    @post
        -# all un-tagged transmitted packets should be dropped.
        -# all statistics counters should not be changed

    @functional     Yes

    @type           Neg

    @trace #BRCM_SWREQ_ETHSWT_CFP
*/
#define BRCM_SWQTST_ETHSWT_CFP_NON_IP_VLAN_TAGGED_WITH_UNTAGGED_PKT    (0x103UL)

/**
    @brief Send VLAN-tagged packets with vlanID mismatch to drop VLAN-tagged packets

    @pre
        -# gPTP client should be registered
        -# Ethernet loopback should be enabled on test port
        -# VlanId should be added in NIF_CtrlVlanArray

    @test CFP Non-IP rule with CTagStatus value as VLAN-Tagged should not allow VLAN-tagged
    packets with vlanID does not match with the vlanID of the CFP rule added.

    @post
        -# all VLAN-tagged transmitted packets should be dropped.
        -# all statistics counters should not be changed

    @functional     Yes

    @type           Neg

    @trace #BRCM_SWREQ_ETHSWT_CFP
*/
#define BRCM_SWQTST_ETHSWT_CFP_NON_IP_VLAN_TAGGED_WITH_VLAN_9_PKT      (0x104UL)

/**
    @brief Send VLAN-tagged packets with a CFP Non-IP rule to steer VLAN-tagged packets to ARM

    @pre
        -# gPTP client should be registered
        -# Ethernet loopback should be enabled on test port
        -# VlanId should be added in NIF_CtrlVlanArray

    @test CFP Non-IP rule with CTagStatus value as VLAN-Tagged should allow VLAN-tagged
    packets with vlanID matches with vlanID of the CFP rule added.

    @post
        -# all VLAN-tagged transmitted packets should be received.
        -# green statistics counter should be same as transmitted count, while others should be zero

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_ETHSWT_CFP
*/
#define BRCM_SWQTST_ETHSWT_CFP_NON_IP_VLAN_TAGGED_WITH_VLAN_7_PKT      (0x105UL)

/**
    @brief Send VLAN-tagged packets with a CFP Non-IP rule to steer VLAN-tagged packets to ARM

    @pre
        -# gPTP client should be registered
        -# Ethernet loopback should be enabled on test port
        -# VlanId should be added in NIF_CtrlVlanArray

    @test CFP Non-IP rule with CTagStatus value as VLAN-Tagged should allow VLAN-tagged
    packets with vlanID other than vlanID of the CFP rule added (but matches with the
    bitwise 'AND' of vlanID and vlanId-mask of the CFP rule added).

    @post
        -# all VLAN-tagged transmitted packets should be received.
        -# green statistics counter should be same as transmitted count, while others should be zero

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_ETHSWT_CFP
*/
#define BRCM_SWQTST_ETHSWT_CFP_NON_IP_VLAN_TAGGED_WITH_VLAN_15_PKT     (0x106UL)

/**
    @brief Send any VLAN-Tagged/Un-Tagged packets with a CFP Non-IP rule to accept all packet types

    @pre
        -# gPTP client should be registered
        -# Ethernet loopback should be enabled on test port
        -# VlanId should be added in NIF_CtrlVlanArray

    @test CFP Non-IP rule with CTagStatus value as VLAN-Tagged/UN-Tagged should allow all
    packets.

    @post
        -# all VLAN-Tagged/UN-Tagged transmitted packets should be received.
        -# green statistics counter should be same as transmitted count, while others should be zero

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_ETHSWT_CFP
*/
#define BRCM_SWQTST_ETHSWT_CFP_NON_IP_ALL_TAGGED_WITH_ALL_PKT          (0x107UL)

/**
    @brief Send VLAN-tagged packets with vlanID mismatch to drop VLAN-tagged packets

    @pre
        -# INET client should be registered
        -# Ethernet loopback should be enabled on test port
        -# VlanId should be added in NIF_CtrlVlanArray

    @test CFP IPv4 rule with CTagStatus value as VLAN-Tagged should not allow VLAN-tagged
    packets with vlanID does not match with the vlanID of the CFP rule added.

    @post
        -# all VLAN-tagged transmitted packets should be dropped.
        -# all statistics counters should not be changed

    @functional     Yes

    @type           Neg

    @trace #BRCM_SWREQ_ETHSWT_CFP
*/
#define BRCM_SWQTST_ETHSWT_CFP_IPV4_VLAN_TAGGED_WITH_VLAN_9_PKT        (0x108UL)

/**
    @brief Send VLAN-tagged packets with a CFP IPv4 rule to steer VLAN-tagged packets to ARM

    @pre
        -# INET client should be registered
        -# Ethernet loopback should be enabled on test port
        -# VlanId should be added in NIF_CtrlVlanArray

    @test CFP IPv4 rule with CTagStatus value as VLAN-Tagged should allow VLAN-tagged
    packets with vlanID matches with vlanID of the CFP rule added.

    @post
        -# all VLAN-tagged transmitted packets should be received.
        -# green statistics counter should be same as transmitted count, while others should be zero

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_ETHSWT_CFP
*/
#define BRCM_SWQTST_ETHSWT_CFP_IPV4_VLAN_TAGGED_WITH_VLAN_7_PKT        (0x109UL)

/**
    @brief Send VLAN-tagged packets with a CFP IPv4 rule to steer VLAN-tagged packets to ARM

    @pre
        -# INET client should be registered
        -# Ethernet loopback should be enabled on test port
        -# VlanId should be added in NIF_CtrlVlanArray

    @test CFP IPv4 rule with CTagStatus value as VLAN-Tagged should allow VLAN-tagged
    packets with vlanID other than vlanID of the CFP rule added (but matches with the
    bitwise 'AND' of vlanID and vlanId-mask of the CFP rule added).

    @post
        -# all VLAN-tagged transmitted packets should be received.
        -# green statistics counter should be same as transmitted count, while others should be zero

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_ETHSWT_CFP
*/
#define BRCM_SWQTST_ETHSWT_CFP_IPV4_VLAN_TAGGED_WITH_VLAN_15_PKT       (0x10AUL)

/**
    @brief Initialization of the CFP block.

    @pre
        -# gPTP client should be registered
        -# Ethernet loopback should be enabled on test port

    @test Before initialization of the CFP block none of the gPTP packets should received.

    @post
        -# CFP_Init should return BCM_ERR_OK
        -# None of the packet should received

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_ETHSWT_CFP
*/
#define BRCM_SWQTST_ETHSWT_CFP_TEST_CFP_INIT                           (0x10BUL)

/**
    @brief Send equal numbers of Sync and PDelay Request packets with a CFP rule to steer only PDelay Request packets to ARM

    @pre
        -# gPTP client should be registered
        -# Ethernet loopback should be enabled on test port

    @test CFP rule (gPTP) which only allow PDelay Request packets should not allow Sync packets.

    @post
        -# Only half of the packets should received (PDelay Request packets only)
        -# green statistics counter should be half of transmitted count, while others should be zero

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_ETHSWT_CFP
*/
#define BRCM_SWQTST_ETHSWT_CFP_TEST_PDELAY_ONLY                        (0x10CUL)

/**
    @brief Insertion of CFP rule should not allow overwriting static rule.

    @pre
        -# Static rule should already programmed at the particular row.

    @test Insertion of CFP rule should fail while overwriting static rule.

    @post
        -# CFP_AddRule should return BCM_ERR_NOPERM.

    @functional     Yes

    @type           Neg

    @trace #BRCM_SWREQ_ETHSWT_CFP
*/
#define BRCM_SWQTST_ETHSWT_CFP_TEST_STATIC_INSERTION                   (0x10DUL)

/**
    @brief Auto addition of CFP rule should happen if default slice and row numbers are provided.

    @pre
        -# CFP table should have an empty row and a slice where this rule can be accomodated.

    @test Auto addition of CFP rule should happen if default slice(CFP_MAX_SLICES)
    and row(CFP_MAX_RULES) numbers are provided.

    @post
        -# Rule should successfully gets programmed at highest priority row and slice number available.

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_ETHSWT_CFP
*/
#define BRCM_SWQTST_ETHSWT_CFP_TEST_DYNAMIC_ADDITION                   (0x10EUL)

/**
    @brief Drop unwanted gPTP traffic which doesn't match any prior CFP rule.

    @pre
        -# gPTP client should be registered
        -# Ethernet loopback should be enabled on test port

    @test All the gPTP traffic should hit the default blacklisting rule(Drop the packets) if it doesn't match
    any prior rules programmed. Send Sync and PDelay Request packets with two CFP rules(first one is to allow
    PDelay Request packets and the last one is to drop all gPTP packets).

    @post
        -# Only half of the packets should received (PDelay Request packets only)
        -# green statistics counter of the row corresponding to first rule should be half of transmitted count(count of PDelay packets), while others should be zero

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_ETHSWT_CFP
*/
#define BRCM_SWQTST_ETHSWT_CFP_TEST_BLACKLISTING                       (0x10FUL)

/**
    @brief Dynamically added CFP rule should be updated.

    @pre
        -# Dynamic rule should already be programmed for updation

    @test Updation of CFP rule should happen if it was programmed dynamically.

    @post
        -# CFP_UpdateRule should return BCM_ERR_OK.
        -# Fetching the configuration should return updated values

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_ETHSWT_CFP
*/
#define BRCM_SWQTST_ETHSWT_CFP_TEST_UPDATE_RULE                        (0x110UL)

/**
    @brief Allow all the gPTP traffic which doesn't match any prior CFP rule.

    @pre
        -# gPTP client should be registered
        -# Ethernet loopback should be enabled on test port

    @test All the gPTP traffic should hit the default whitelisting rule(allow all the gPTP packets) if it doesn't match
    any prior rules programmed. Send Sync and PDelay Request packets with two CFP rules(first one is to allow
    PDelay Request packets only and the last one is to allow all gPTP packets).

    @post
        -# All the packets should received
        -# green statistics counter should be same as transmitted count, while others should be zero

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_ETHSWT_CFP
*/
#define BRCM_SWQTST_ETHSWT_CFP_TEST_WHITELISTING                       (0x111UL)

/**
    @brief Disable test port.

    @pre
        -# gPTP client should be registered
        -# CFP rule to steer all gPTP packets to ARM should be present

    @test If the test port has CFP disabled then it should not match any CFP rules
          for traffic ingressing on that port.

    @post
        -# CFP_DisablePort should return BCM_ERR_OK
        -# None of the transmitted packets should received

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_ETHSWT_CFP
*/
#define BRCM_SWQTST_ETHSWT_CFP_TEST_DISABLE_PORT                       (0x112UL)

/**
    @brief Enable test port.

    @pre
        -# gPTP client should be registered
        -# CFP rule to steer all gPTP packets to ARM should be present

    @test If the test port has CFP enabled then ingress traffic should go through CFP lookup and action.

    @post
        -# CFP_EnablePort should return BCM_ERR_OK
        -# All of the transmitted packets should received

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_ETHSWT_CFP
*/
#define BRCM_SWQTST_ETHSWT_CFP_TEST_ENABLE_PORT                        (0x113UL)

/**
    @brief Remove CFP rule.

    @pre
        -# gPTP client should be registered
        -# Ethernet loopback should be enabled on test port
        -# Rule should be added before removing it

    @test After removing the CFP rule it should not be valid any more.

    @post
        -# CFP_RemoveRule should return BCM_ERR_OK
        -# Only half of the packets should received (PDelay Request packets only)

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_ETHSWT_CFP
*/
#define BRCM_SWQTST_ETHSWT_CFP_TEST_REMOVE_RULE                        (0x114UL)

/**
    @brief De-initialize the CFP block.

    @pre
        -# gPTP client should be registered
        -# Ethernet loopback should be enabled on test port

    @test After de-initialize the CFP block none of the gPTP packets should received.

    @post
        -# CFP_DeInit should return BCM_ERR_OK
        -# None of the packet should received

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_ETHSWT_CFP
*/
#define BRCM_SWQTST_ETHSWT_CFP_TEST_DEINIT                             (0x115UL)

/** @brief CFP Test sequence 0

    This test simulates a whitelisting/blacklisting use case.

    @code{.c}
    -# Activate CFP Mask Test Task
    -# Setup
      - Retrieve the NIF controller index for a gPTP client
      - Enable Ethernet loopback on test port
    -# Transmit gPTP packets, (alternating between Sync and PDelay Request PDUs)
       destined to test port and verify that no packets are received
    -# BRCM_SWQTST_ETHSWT_CFP_TEST_CFP_INIT
    -# Have a single rule in the CFP configuration to forward untagged gPTP PDelay Request
       packets, identified by destination MAC address 01:80:c2:00:00:0e, ethertype
       0x88f7 and message type 2 (in the common header), to the ARM CPU.
      - Non-IP
      - Row 0, Slice 2
      - AFT_UN_TAGGED
      - ethertype 0x88f7
      - UDF0 value 0x000EU, mask 0xFFFFU, base #CFP_UDFBASE_SOP , Offset 2U
      - UDF1 value 0xC200U, mask 0xFFFFU, base #CFP_UDFBASE_SOP , Offset 1U
      - UDF2 value 0x0180U, mask 0xFFFFU, base #CFP_UDFBASE_SOP,  Offset 0U
      - UDF3 value 0x0200U, mask 0xFFFFU, base #CFP_UDFBASE_ENDL2HDR, Offset 0U
      - Destination mask should be 0x80
    -# Initialize the CFP block using CFP_Init()

    -# Transmit 4 un-tagged gPTP packets, (alternating between Sync and PDelay Request PDUs) with
       destination MAC address 01:80:c2:00:00:0e, destined to test port.
       #BRCM_SWQTST_ETHSWT_CFP_TEST_PDELAY_ONLY

    -# Have a rule to drop all un-tagged gPTP packets,
       identified by destination MAC address 01:80:c2:00:00:0e, ethertype
       0x88f7.
      - Non-IP
      - Row 0, Slice 2
      - AFT_UN_TAGGED
      - ethertype 0x88f7
      - UDF0 value 0x000EU, mask 0xFFFFU, base #CFP_UDFBASE_SOP , Offset 2U
      - UDF1 value 0xC200U, mask 0xFFFFU, base #CFP_UDFBASE_SOP , Offset 1U
      - UDF2 value 0x0180U, mask 0xFFFFU, base #CFP_UDFBASE_SOP,  Offset 0U
      - Destination mask should be 0x00
    -# Add rule using CFP_AddRule()
       #BRCM_SWQTST_ETHSWT_CFP_TEST_STATIC_INSERTION

    -# Have a rule to drop all un-tagged gPTP packets,
       identified by destination MAC address 01:80:c2:00:00:0e, ethertype
       0x88f7.
      - Non-IP
      - Row CFP_MAX_RULES, Slice CFP_MAX_SLICES
      - AFT_UN_TAGGED
      - ethertype 0x88f7
      - UDF0 value 0x000EU, mask 0xFFFFU, base #CFP_UDFBASE_SOP , Offset 2U
      - UDF1 value 0xC200U, mask 0xFFFFU, base #CFP_UDFBASE_SOP , Offset 1U
      - UDF2 value 0x0180U, mask 0xFFFFU, base #CFP_UDFBASE_SOP,  Offset 0U
      - Destination mask should be 0x00
    -# Add rule using CFP_AddRule()
       #BRCM_SWQTST_ETHSWT_CFP_TEST_DYNAMIC_ADDITION

    -# Transmit 4 un-tagged gPTP packets, (alternating between Sync and PDelay Request PDUs) with
       destination MAC address 01:80:c2:00:00:0e, destined to test port.
       #BRCM_SWQTST_ETHSWT_CFP_TEST_BLACKLISTING

    -# Update the rule to forward all un-tagged gPTP packets,
       identified by destination MAC address 01:80:c2:00:00:0e, ethertype
       0x88f7, to the ARM CPU.
      - Non-IP
      - Row 1, Slice 2
      - AFT_UN_TAGGED
      - ethertype 0x88f7
      - UDF0 value 0x000EU, mask 0xFFFFU, base #CFP_UDFBASE_SOP , Offset 2U
      - UDF1 value 0xC200U, mask 0xFFFFU, base #CFP_UDFBASE_SOP , Offset 1U
      - UDF2 value 0x0180U, mask 0xFFFFU, base #CFP_UDFBASE_SOP,  Offset 0U
      - Destination mask should be 0x80
    -# Update rule using CFP_UpdateRule()
       #BRCM_SWQTST_ETHSWT_CFP_TEST_UPDATE_RULE

    -# Transmit 4 un-tagged gPTP packets, (alternating between Sync and PDelay Request PDUs) with
       destination MAC address 01:80:c2:00:00:0e, destined to test port.
       #BRCM_SWQTST_ETHSWT_CFP_TEST_WHITELISTING

    -# Disable test port using CFP_DisablePort
    -# Transmit 4 un-tagged gPTP packets, (alternating between Sync and PDelay Request PDUs) with
       destination MAC address 01:80:c2:00:00:0e, destined to test port.
       #BRCM_SWQTST_ETHSWT_CFP_TEST_DISABLE_PORT

    -# Re-enable test port using CFP_EnablePort
    -# Transmit 4 un-tagged gPTP packets, (alternating between Sync and PDelay Request PDUs) with
       destination MAC address 01:80:c2:00:00:0e, destined to test port.
       #BRCM_SWQTST_ETHSWT_CFP_TEST_ENABLE_PORT

    -# Remove the rule to forward all un-tagged gPTP packets,
       identified by destination MAC address 01:80:c2:00:00:0e, ethertype
       0x88f7, to the ARM CPU.
      - Row 1
    -# Remove rule using CFP_RemoveRule()
       #BRCM_SWQTST_ETHSWT_CFP_TEST_REMOVE_RULE

    -# De-Initialize CFP block
    -# De-initialize the CFP block using CFP_DeInit()
       #BRCM_SWQTST_ETHSWT_CFP_TEST_DEINIT

    -# Terminate CFP Test Task
    @endcode

    @board bcm8953x

    @auto           yes

    @type           Sanity

    @testproc #BRCM_SWQTST_ETHSWT_CFP_TEST_CFP_INIT
    @testproc #BRCM_SWQTST_ETHSWT_CFP_TEST_PDELAY_ONLY
    @testproc #BRCM_SWQTST_ETHSWT_CFP_TEST_STATIC_INSERTION
    @testproc #BRCM_SWQTST_ETHSWT_CFP_TEST_DYNAMIC_ADDITION
    @testproc #BRCM_SWQTST_ETHSWT_CFP_TEST_BLACKLISTING
    @testproc #BRCM_SWQTST_ETHSWT_CFP_TEST_UPDATE_RULE
    @testproc #BRCM_SWQTST_ETHSWT_CFP_TEST_WHITELISTING
    @testproc #BRCM_SWQTST_ETHSWT_CFP_TEST_DISABLE_PORT
    @testproc #BRCM_SWQTST_ETHSWT_CFP_TEST_ENABLE_PORT
    @testproc #BRCM_SWQTST_ETHSWT_CFP_TEST_REMOVE_RULE
    @testproc #BRCM_SWQTST_ETHSWT_CFP_TEST_DEINIT

*/
#define BRCM_SWQTSEQ_CFP_SEQ0                                          (0x116UL)

/** @brief CFP Test sequence 1

    This test verify CTag masking feature for Non-IP and IPv4 rules.

    @code{.c}
    -# Activate CFP Mask Test Task
    -# Setup
     - Retrieve the NIF controller index for a gPTP client
     - Enable Ethernet loopback on test port
    -# Transmit gPTP PDelay Request packets,
       destined to test port and verify that no packets are received
       #Initialize the CFP block using CFP_Init()

    -# Have a single rule to forward untagged gPTP PDelay Request
       packets, identified by destination MAC address 01:80:c2:00:00:0e, ethertype
       0x88f7 and message type 2 (in the common header), to the ARM CPU.
    -# CFP_AddRule() with following parameters should return BCM_ERR_OK
      - Non-IP
      - Row 0, Slice 2
      - AFT_UN_TAGGED
      - ethertype 0x88f7
      - UDF0 value 0x000EU, mask 0xFFFFU, base #CFP_UDFBASE_SOP , Offset 2U
      - UDF1 value 0xC200U, mask 0xFFFFU, base #CFP_UDFBASE_SOP , Offset 1U
      - UDF2 value 0x0180U, mask 0xFFFFU, base #CFP_UDFBASE_SOP,  Offset 0U
      - UDF3 value 0x0200U, mask 0xFFFFU, base #CFP_UDFBASE_ENDL2HDR, Offset 0U
      - Destination mask should be 0x80

    -# Transmit 4 untagged PDelay Request packets
       #BRCM_SWQTST_ETHSWT_CFP_NON_IP_UNTAGGED_WITH_UNTAGGED_PKT

    -# Transmit 4 VLAN-tagged (CTag with vlanId 7) PDelay Request packets
       #BRCM_SWQTST_ETHSWT_CFP_NON_IP_UNTAGGED_WITH_VLAN_TAGGED_PKT

    -# CFP_RemoveRule()
       - Row 0
    -# CFP_AddRule() with following parameters should return BCM_ERR_OK
      - Non-IP
      - Row 0, Slice 2
      - VLAN 7, AFT_VLAN_TAGGED, Mask 0x7
      - ethertype 0x88f7
      - UDF0 value 0x000EU, mask 0xFFFFU, base #CFP_UDFBASE_SOP , Offset 2U
      - UDF1 value 0xC200U, mask 0xFFFFU, base #CFP_UDFBASE_SOP , Offset 1U
      - UDF2 value 0x0180U, mask 0xFFFFU, base #CFP_UDFBASE_SOP,  Offset 0U
      - UDF3 value 0x0200U, mask 0xFFFFU, base #CFP_UDFBASE_ENDL2HDR, Offset 0U
      - Destination mask should be 0x80

    -# Transmit Un-tagged PDelay Request packets
       #BRCM_SWQTST_ETHSWT_CFP_NON_IP_VLAN_TAGGED_WITH_UNTAGGED_PKT

    -# Transmit 4 VLAN-tagged (CTag, vlanID not equal to 7) PDelay Request packets
       #BRCM_SWQTST_ETHSWT_CFP_NON_IP_VLAN_TAGGED_WITH_VLAN_9_PKT

    -# Transmit 4 VLAN-tagged (CTag, vlanID 7) PDelay Request packets
       #BRCM_SWQTST_ETHSWT_CFP_NON_IP_VLAN_TAGGED_WITH_VLAN_7_PKT

    -# Transmit 4 VLAN-tagged (CTag, vlanID 15) PDelay Request packets
       #BRCM_SWQTST_ETHSWT_CFP_NON_IP_VLAN_TAGGED_WITH_VLAN_15_PKT

    -# CFP_RemoveRule()
      - Row 0
    -# CFP_AddRule() with following parameters should return BCM_ERR_OK
      - Non-IP
      - Row 0, Slice 2
      - AFT_VLAN_TAGGED, AFT_UN_TAGGED, AFT_PRIO_TAGGED
      - ethertype 0x88f7
      - UDF0 value 0x000EU, mask 0xFFFFU, base #CFP_UDFBASE_SOP , Offset 2U
      - UDF1 value 0xC200U, mask 0xFFFFU, base #CFP_UDFBASE_SOP , Offset 1U
      - UDF2 value 0x0180U, mask 0xFFFFU, base #CFP_UDFBASE_SOP,  Offset 0U
      - UDF3 value 0x0200U, mask 0xFFFFU, base #CFP_UDFBASE_ENDL2HDR, Offset 0U
      - Destination mask should be 0x80

    -# Transmit 4 VLAN-tagged (CTag, vlanID 7) PDelay Request packets
       #BRCM_SWQTST_ETHSWT_CFP_NON_IP_ALL_TAGGED_WITH_ALL_PKT

    -# Transmit 4 un-tagged PDelay Request packets
       #BRCM_SWQTST_ETHSWT_CFP_NON_IP_ALL_TAGGED_WITH_ALL_PKT

    -# CFP_RemoveRule()
      - Row 0
    -# CFP_AddRule() with following parameters should return BCM_ERR_OK
      - IPv4
      - Row 0, Slice 2
      - VLAN 7, AFT_VLAN_TAGGED, Mask 0x7
      - Destination mask should be 0x80
    -# ETHERSWT_AddVLANPorts(0U, 0x01FF , 7U, 0x01FF) should return BCM_ERR_OK
    -# ETHERSWT_AddVLANPorts(0U, 0x01FF , 9U, 0x01FF) should return BCM_ERR_OK
    -# Retrieve the NIF controller index for a INET client with vlanId 9

    -# Transmit 4 VLAN-tagged (CTag, vlanID 9) IPv4 packets
       #BRCM_SWQTST_ETHSWT_CFP_IPV4_VLAN_TAGGED_WITH_VLAN_9_PKT

    -# Retrieve the NIF controller index for a INET client with vlanId 7
    -# Transmit 4 VLAN-tagged (CTag, vlanID 7) IPv4 packets
       #BRCM_SWQTST_ETHSWT_CFP_IPV4_VLAN_TAGGED_WITH_VLAN_7_PKT

    -# ETHERSWT_AddVLANPorts(0U, 0x01FF , 7U, 0x01FF) should return BCM_ERR_OK
    -# Retrieve the NIF controller index for a INET client with vlanId 15
    -# Transmit 4 VLAN-tagged (CTag, vlanID 15) IPv4 packets
       #BRCM_SWQTST_ETHSWT_CFP_IPV4_VLAN_TAGGED_WITH_VLAN_15_PKT

    -# CFP_RemoveRule()
      - Row 0
    -# De-initialize the CFP block using CFP_DeInit()
    -# Terminate CFP Test Task
    @endcode

    @board bcm8953x

    @auto           yes

    @type           Sanity

    @testproc #BRCM_SWQTST_ETHSWT_CFP_NON_IP_UNTAGGED_WITH_UNTAGGED_PKT
    @testproc #BRCM_SWQTST_ETHSWT_CFP_NON_IP_UNTAGGED_WITH_VLAN_TAGGED_PKT
    @testproc #BRCM_SWQTST_ETHSWT_CFP_NON_IP_VLAN_TAGGED_WITH_UNTAGGED_PKT
    @testproc #BRCM_SWQTST_ETHSWT_CFP_NON_IP_VLAN_TAGGED_WITH_VLAN_9_PKT
    @testproc #BRCM_SWQTST_ETHSWT_CFP_NON_IP_VLAN_TAGGED_WITH_VLAN_7_PKT
    @testproc #BRCM_SWQTST_ETHSWT_CFP_NON_IP_VLAN_TAGGED_WITH_VLAN_15_PKT
    @testproc #BRCM_SWQTST_ETHSWT_CFP_NON_IP_ALL_TAGGED_WITH_ALL_PKT
    @testproc #BRCM_SWQTST_ETHSWT_CFP_IPV4_VLAN_TAGGED_WITH_VLAN_9_PKT
    @testproc #BRCM_SWQTST_ETHSWT_CFP_IPV4_VLAN_TAGGED_WITH_VLAN_7_PKT
    @testproc #BRCM_SWQTST_ETHSWT_CFP_IPV4_VLAN_TAGGED_WITH_VLAN_15_PKT
*/
#define BRCM_SWQTSEQ_CFP_SEQ1                                          (0x117UL)

#endif /* CFP_QT_H */

/** @} */
