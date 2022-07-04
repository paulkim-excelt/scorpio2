/*****************************************************************************
 Copyright 2018-2022 Broadcom Limited.  All rights reserved.

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

/** @brief Integration test for CFP */

#include "ee.h"
#include <string.h>
#include <ulog.h>
#include <bcm_utils.h>
#include <bcm_err.h>
#include <bcm_test.h>
#include <nif.h>
#include <nif_switch.h>
#include <ethxcvr.h>
#include <osil/bcm_osil.h>
#include <ethswt_cfp.h>
#include "cfp_qt.h"
#include <eth_switch.h>
#include <eth_osil.h>
#include <ethxcvr.h>
#include <module_helper.h>
#include <time_module_osil.h>
#include <mcu.h>

#define GetModuleLogLevel()     ULOG_LVL_ERROR
#define NUM_PKTS                4UL

#define ETHER_HW_ID           (0UL)

#ifdef __BCM8956X__
#define TEST_PORT 2UL
#else
#define TEST_PORT 0UL
#endif

static uint32_t numRxPkts = 0UL;

static const uint8_t pdelay_req_pkt[]= {0x12U, 0x02U, 0x00U, 0x36U,
                                        0x00U, 0x00U, 0x00U, 0x08U,
                                        0x00U, 0x00U, 0x00U, 0x00U,
                                        0x00U, 0x00U, 0x00U, 0x00U,
                                        0x00U, 0x00U, 0x00U, 0x00U,
                                        0xAAU, 0xBBU, 0xCCU, 0xFFU,
                                        0xFEU, 0xDDU, 0xEEU, 0xFFU,
                                        0x00U, 0x01U, 0x00U, 0x01U,
                                        0x05U, 0x00U, 0x00U, 0x00U,
                                        0x00U, 0x00U, 0x00U, 0x00U,
                                        0x00U, 0x00U, 0x00U, 0x00U,
                                        0x00U, 0x00U, 0x00U, 0x00U,
                                        0x00U, 0x00U, 0x00U, 0x00U,
                                        0x00U, 0x00U};

static uint8_t sync_pkt[]= {0x10U, 0x02U, 0x00U, 0x2CU,
                            0x00U, 0x00U, 0x02U, 0x08U,
                            0x00U, 0x00U, 0x00U, 0x00U,
                            0x00U, 0x00U, 0x00U, 0x00U,
                            0x00U, 0x00U, 0x00U, 0x00U,
                            0xAAU, 0xBBU, 0xCCU, 0xFFU,
                            0xFEU, 0xDDU, 0xEEU, 0xFFU,
                            0x00U, 0x01U, 0x00U, 0x01U,
                            0x00U, 0xFBU, 0x00U, 0x00U,
                            0x00U, 0x00U, 0x00U, 0x00U,
                            0x00U, 0x00U, 0x00U, 0x00U};

static const uint8_t ipv4_pkt[]      = {0x45U, 0x00U, 0x00U, 0x44U,
                                        0xADU, 0x0BU, 0x00U, 0x00U,
                                        0x40U, 0x11U, 0x14U, 0xC9U,
                                        0xACU, 0x14U, 0x02U, 0xFDU,
                                        0xC0U, 0xA8U, 0x0AU, 0x01U,
                                        0x00U, 0x00U, 0x00U, 0x00U,
                                        0x00U, 0x00U, 0x00U, 0x00U,
                                        0x00U, 0x00U, 0x00U, 0x00U,
                                        0x00U, 0x00U, 0x00U, 0x00U,
                                        0x00U, 0x00U, 0x00U, 0x00U,
                                        0x00U, 0x00U, 0x00U, 0x00U,
                                        0x00U, 0x00U, 0x00U, 0x00U,
                                        0x00U, 0x00U, 0x00U, 0x00U,
                                        0x00U, 0x00U, 0x00U, 0x00U,
                                        0x00U, 0x00U, 0x00U, 0x00U,
                                        0x00U, 0x00U, 0x00U, 0x00U,
                                        0x00U, 0x00U, 0x00U, 0x00U};

static volatile int32_t cfp_qt_result = BCM_AT_NOT_STARTED;
static volatile uint32_t activeTaskIndex;
static volatile uint8_t isCFPTestInitDone = FALSE;

ETHSWT_CFPConfigType cfpConfig =
{
    .magicId = ETHSWT_CFP_CONFIG_MAGIC_ID,
    .pktLenCorr = ETHSWT_CFP_PKTLENCORR_NONE,
#ifdef __BCM8956X__
    .portEnableMask = 0x4U,
#else
    .portEnableMask = 0x1U,
#endif
    .ruleList = {
        {
            .key = {
                .l2Framing         = ETHSWT_CFP_L2FRAMING_DIXV2,
                .l3Framing         = ETHSWT_CFP_L3FRAMING_NONIP,
                .flags             = 0x88F7UL,
                .flagsMask         = 0xFFFFUL,
                .ingressPortBitmap = 0x1FFU,
                .cTagFlags         = ETHSWT_CFP_KEY_TAG_UN_TAGGED_MASK,
                .sTagFlags         = ETHSWT_CFP_KEY_TAG_UN_TAGGED_MASK,
                .udfList           = {
                    {
                        .value         = 0x000EU,
                        .mask          = 0xFFFFU,
                        .baseAndOffset = 2U,
                    },
                    {
                        .value         = 0xC200U,
                        .mask          = 0xFFFFU,
                        .baseAndOffset = 1U,
                    },
                    {
                        .value         = 0x0180U,
                        .mask          = 0xFFFFU,
                        .baseAndOffset = 0U,
                    },
                    {
                        .value         = 0x0200U,
                        .mask          = 0x0F00U,
                        .baseAndOffset = 0x40U,
                    },
                },
                .numEnabledUDFs    = 4U,
            },
            .action = {
                .meter = {
                    .policerFlags = ETHSWT_CFP_POLICERMODE_DISABLED << ETHSWT_CFP_METER_MODE_SHIFT,
                },
                .dstMapIBFlags = (ETHSWT_CFP_CHANGEFWDMAP_REP << ETHSWT_CFP_ACTION_CHANGE_FWDMAP_SHIFT) | 0x80U,
                .dstMapOBFlags = (ETHSWT_CFP_CHANGEFWDMAP_REP << ETHSWT_CFP_ACTION_CHANGE_FWDMAP_SHIFT) | 0x80U,
                .tcFlags = (1U << ETHSWT_CFP_ACTION_CHANGE_TC_SHIFT) | 7U,
                .otherFlags = (ETHSWT_CFP_ACTION_BYPASS_VLAN_MASK | ETHSWT_CFP_ACTION_BYPASS_EAP_MASK | ETHSWT_CFP_ACTION_BYPASS_STP_MASK),
            },
            .rowAndSlice = ETHSWT_CFP_MAX_RULES | ((ETHSWT_CFP_MAX_SLICES << ETHSWT_CFP_ROWANDSLICE_SLICE_SHIFT) & ETHSWT_CFP_ROWANDSLICE_SLICE_MASK),
        },
    },
    .ruleListSz = 1U
};

void DelayTimerAlarmCb(void)
{
    TaskStateType taskState = SUSPENDED;
    StatusType retOS = E_OK;
    retOS = GetTaskState(CFPTest, &taskState);
    if (E_OK == retOS) {
        if (WAITING == taskState) {
            (void)SetEvent(CFPTest, SystemEvent6);
        } else {
            (void)SetEvent(CFPMaskTest, SystemEvent6);
        }
    } else {
        ULOG_ERR("GetTaskState() failed status: %d\n\r", retOS);
    }
}

TASK(CFPPktEventTask)
{
    uint32_t waitMask = ETHER_PKT_EVENT;
    uint32_t mask = 0UL;

    do {
        BCM_WaitEvent(waitMask);
        BCM_GetEvent(CFPPktEventTask, &mask);
        BCM_ClearEvent(mask);

        if (ETHER_PKT_EVENT == (mask & ETHER_PKT_EVENT)) {
            /* Process Ethernet */
            ETHER_ProcessPkts(0UL);
        }
    } while (1);

    return;
}

static int32_t SendGPTPPktsAndVerify(const NIF_CntrlIDType* const ethCtrlIdx,
                                 uint32_t numExpected)
{
    uint32_t              i            = 0UL;
    uint8_t               *pdu         = NULL;
    uint32_t              bufIdx       = 0xFFUL;
    uint32_t              length;
    int32_t               ret;
    ETHSWT_MgmtInfoType mgmtInfo;
    BCM_EventMaskType     mask = 0UL;
    const uint8_t         dstMacAddr[] = {0x01U, 0x80U, 0xC2U, 0x00U, 0x00U, 0x0EU};

    numRxPkts = 0UL;

    for (; i < NUM_PKTS; ++i) {
        length = 90U;
        ret = NIF_GetTxBuffer(*ethCtrlIdx, ETHER_ETHERTYPE_GPTP, 6U, &bufIdx, &pdu, &length);
        if (BCM_ERR_OK != ret) {
            ULOG_ERR("NIF_GetTxBuffer() failed with %d\n", ret);
            goto err;
        }

        if (0 == (i % 2U)) {
            length = sizeof(pdelay_req_pkt);
            BCM_MemCpy(pdu, pdelay_req_pkt, length);
        } else {
            length = sizeof(sync_pkt);
            BCM_MemCpy(pdu, sync_pkt, length);
        }

        mgmtInfo.switchIdx = 0UL;
        mgmtInfo.portIdx   = TEST_PORT;
        mgmtInfo.tc        = ETHSWT_TC_4;
        ret = NIF_SwtSetMgmtInfo(*ethCtrlIdx, bufIdx, &mgmtInfo);
        if (BCM_ERR_OK != ret) {
            ULOG_ERR("NIF_SwtSetMgmtInfo() failed with %d\n", ret);
            goto err;
        }
        ret = NIF_Send(*ethCtrlIdx, ETHER_ETHERTYPE_GPTP, 1UL, bufIdx, length, dstMacAddr);
        if (BCM_ERR_OK != ret) {
            ULOG_ERR("NIF_Send() failed with %d\n", ret);
            goto err;
        }
    }

    /* Now wait for upto 30 ticks for packets to be received */
    BCM_SetRelAlarm(DelayTimerAlarm, 30U, 0U);

    BCM_WaitEvent(SystemEvent6);
    BCM_GetEvent(CFPTest, &mask);
    if (mask & SystemEvent6) {
        BCM_ClearEvent(SystemEvent6);
        ULOG_ERR("Sent %lu packets and received %lu back, expected %lu\n", NUM_PKTS, numRxPkts, numExpected);
        if (numRxPkts != numExpected) {
            ret = BCM_ERR_UNKNOWN;
        }
    }
    /* Disable the alarm so that it can be reused */
    BCM_CancelAlarm(DelayTimerAlarm);
err:
    return ret;
}

static int32_t SendPacketsAndVerify(const NIF_CntrlIDType* const ethCtrlIdx,
                                 uint32_t numExpected, ETHER_EtherType ethertype,
                                 const uint8_t *const aPacket, uint32_t aLength,
                                 const uint8_t *dstMacAddr,
                                 uint32_t row)
{
    uint32_t              i            = 0UL;
    uint8_t               *pdu         = NULL;
    uint32_t              bufIdx       = 0xFFUL;
    uint32_t              length;
    int32_t               ret = BCM_ERR_OK;
    ETHSWT_MgmtInfoType   mgmtInfo;
    BCM_EventMaskType     mask = 0UL;
    ETHSWT_CFPStatsType   stats1;
    ETHSWT_CFPStatsType   stats2;

    /* Retrieve stats before sending the packets */
    if(ETHSWT_CFP_MAX_RULES != row) {
        ret = ETHSWT_CFPGetStats(0UL, row, &stats1);
        if (BCM_ERR_OK != ret) {
            ULOG_ERR("CFP_GetStats() failed before sending packets with error %d\n", ret);
            cfp_qt_result = ret;
            goto err;
        }
    }
    for (; i < NUM_PKTS; ++i) {
        length = aLength;
        ret = NIF_GetTxBuffer(*ethCtrlIdx, ethertype, 6U, &bufIdx, &pdu, &length);
        if (BCM_ERR_OK != ret) {
            ULOG_ERR("NIF_GetTxBuffer() failed with %d\n", ret);
            goto err;
        }
        if (length < aLength) {
            ULOG_ERR("NIF_GetTxBuffer() does not provide requested buffer requested size: \
            %d returned size %d\n", aLength, length);
            cfp_qt_result = BCM_ERR_NOMEM;
            goto err;
        }
        length = aLength;
        BCM_MemCpy(pdu, aPacket, length);

        mgmtInfo.switchIdx = 0UL;
        mgmtInfo.portIdx   = TEST_PORT;
        mgmtInfo.tc        = ETHSWT_TC_4;
        ret = NIF_SwtSetMgmtInfo(*ethCtrlIdx, bufIdx, &mgmtInfo);
        if (BCM_ERR_OK != ret) {
            ULOG_ERR("NIF_SwtSetMgmtInfo() failed with %d\n", ret);
            goto err;
        }

        ret = NIF_Send(*ethCtrlIdx, ethertype, 1UL, bufIdx, length, dstMacAddr);

        if (BCM_ERR_OK != ret) {
            ULOG_ERR("NIF_Send() failed with %d\n", ret);
            goto err;
        }
    }

    /* Now wait for upto 30 ticks for packets to be received */
    BCM_SetRelAlarm(DelayTimerAlarm, 30U, 0U);

    BCM_WaitEvent(SystemEvent6);
    BCM_GetEvent(CFPMaskTest, &mask);
    if (mask & SystemEvent6) {
        BCM_ClearEvent(SystemEvent6);

        /* Retrieve stats after receiving packets */
        if(ETHSWT_CFP_MAX_RULES != row) {
            ret = ETHSWT_CFPGetStats(0UL, row, &stats2);
            if ((BCM_ERR_OK != ret) ||
                    ((stats2.green - stats1.green) != numExpected) ||
                    ((stats2.yellow - stats1.yellow)!= 0UL) ||
                    ((stats2.red - stats1.red) != 0UL)) {
                ULOG_ERR("CFP_GetStats() failed after receiving packets with %d, GreenCntr = %lu \
                        YellowCntr = %lu RedCntr = %lu\n", ret, stats2.green, stats2.yellow,
                        stats2.red);
                ret = BCM_ERR_UNKNOWN;
            } else {
                ULOG_ERR("Sent %lu packets and received %lu back, expected %lu\n", NUM_PKTS, stats2.green - stats1.green, numExpected);
            }
        }
    }
    /* Disable the alarm so that it can be reused */
    BCM_CancelAlarm(DelayTimerAlarm);
err:
    return ret;
}

/**
  @defgroup grp_cfp_qt Qualification Tests
  @ingroup grp_eth_switch_cfp

  @addtogroup grp_cfp_qt
  @{

  @file cfp_qt.c
  @brief CFP Integration Test
  This source file contains the qualification tests for CFP
  @version 0.1 Initial version
*/

/** @brief CFP Test sequence 1

    This test verify CTag masking feature for IP and Non-IP rules.

    @behavior Sync/Async, Re-entrant/Non-reentrant

    @pre
    -# gPTP client should be registered
    -# INET client should be registered
    -# VlanId should be added in NIF_CtrlVlanArray
    -# Task(CFPMaskTest) should be in active state

    @param[in]      void

    @retval     #BCM_ERR_OK             CFP_QTSequence1 returned successfully
    @retval     #BCM_ERR_INVAL_PARAMS   Invalid parameter
    @retval     #BCM_ERR_UNKNOWN        Send and verification of packets failed
    @retval     #BCM_ERR_INVAL_STATE    CFP_Init/CFP_DeInit failed

    @post
    -# #BCM_ERR_OK should be returned

    @trace #BRCM_SWQTSEQ_CFP_SEQ1

    @limitations
    -# This test does not verify CTag masking feature for IPv6 rules
    -# CFP rule with CTagStatus value as PRIO-Tagged has not been verified

    @code{.c}
  # Activate CFP Mask Test Task
  # Setup
    - Retrieve the NIF controller index for a gPTP client
    - Enable Ethernet loopback on test port
  # Transmit gPTP PDelay Request packets,
    destined to test port and verify that no packets are received
  # Have a single rule in the CFP configuration to forward untagged gPTP PDelay Request
    packets, identified by destination MAC address 01:80:c2:00:00:0e, ethertype
    0x88f7 and message type 2 (in the common header), to the ARM CPU.
  # Initialize the CFP block using CFP_Init()
  # Transmit untagged (CTag) PDelay Request packets and confirm that all PDelay Request packets are received

  # Retrieve statistics using CFP_GetStats() for row 0 and ensure that the green
    statistics counter is same as transmitted count, while others are zero
  # Transmit VLAN-tagged (CTag with vlanId 7) PDelay Request packets and confirm that the none
    of PDelay Request packet is received

  # Insert a rule at row 1, slice 2 using ETHSWT_CFPAddRule(), to allow VLAN-tagged
   (CTag with VlanId 7 and vlanId-mask 7) PDelay Request packets. Verify that the rule successfully
    gets programmed at row 1 and slice 2

  # Transmit un-tagged  PDelay Request packets
    and verify that none of the PDelay Request packet is received.
  # Retrieve statistics using CFP_GetStats() for row 1 and ensure that all
    statistics counter are zero.

  # Transmit VLAN-tagged (CTag, vlanID not equal to 7) PDelay Request packets
    and verify that none of the PDelay Request packet is received.

  # Retrieve statistics using CFP_GetStats() for row 1 and ensure that all
    statistics counter are zero.
  # Transmit VLAN-tagged (CTag, vlanID 7) PDelay Request packets and confirm that all
    PDelay Request packets are received.

  # Retrieve statistics using CFP_GetStats() for row 1 and ensure that the green
    statistics counter is same as transmitted count, while others are zero
  # Transmit VLAN-tagged (CTag, vlanID 15) PDelay Request packets and confirm that all
    PDelay Request packets are received.

  # Retrieve statistics using CFP_GetStats() for row 1 and ensure that the green
    statistics counter increments by transmitted count, while others are zero
  # Insert an IPv4-rule at row 2, slice 2 using ETHSWT_CFPAddRule(), to allow VLAN-tagged
   (CTag with VlanId 7 and vlanId-mask 7) IPv4 packets. Verify that the rule successfully
    gets programmed at row 2 and slice 2
  # Add test port as part of vlan 7. Verify that the test port successfully
    gets added to vlan 7.
  # Add test port as part of vlan 9. Verify that the test port successfully
    gets added to vlan 9.
  # Retrieve the NIF controller index for a INET client with vlanId 9
  # Transmit VLAN-tagged (CTag, vlanID 9) IPv4 packets and verify that none of the Ipv4 packet is received.

  # Retrieve statistics using CFP_GetStats() for row 2 and ensure that all
    statistics counter are zero.
  # Retrieve the NIF controller index for a INET client with vlanId 7
  # Transmit VLAN-tagged (CTag, vlanID 7) IPv4 packets and verify that all Ipv4 packets are received.

  # Retrieve statistics using CFP_GetStats() for row 2 and ensure that the green
    statistics counter is same as transmitted count, while others are zero
  # Add test port as part of vlan 15. Verify that the test port successfully
    gets added to vlan 15.
  # Retrieve the NIF controller index for a INET client with vlanId 15
  # Transmit VLAN-tagged (CTag, vlanID 15) IPv4 packets and verify that all Ipv4 packets are received.

  # Retrieve statistics using CFP_GetStats() for row 2 and ensure that the green
    statistics counter increments by transmitted count, while others are zero
  # De-initialize the CFP block using CFP_DeInit()
  # Terminate CFP Test Task
    @endcode
*/
int32_t CFP_QTSequence1(void)
{
    NIF_CntrlIDType ethCtrlIdx = ~(0x0ULL);
    int32_t         ret = BCM_ERR_OK;
    uint32_t        row;
    uint32_t        slice;
    ETHSWT_CFPKeyType     key;
    ETHSWT_CFPActionType  action;
    ETHER_VLANIDType vlanID = 0U;
    const uint8_t         dstMacAddrNonIP[] = {0x01U, 0x80U, 0xC2U, 0x00U, 0x00U, 0x0EU};
    const uint8_t         dstMacAddrIPv4[] = {0x30U, 0x80U, 0xC2U, 0x00U, 0x00U, 0x02U};

    /* Setup */
    ret = NIF_GetCtrlIdx(vlanID, BCM_ETS_ID, 0U, &ethCtrlIdx);

    /* Set loopback on Ethernet port */
    ETHXCVR_SetLoopbackMode(TEST_PORT, ETHXCVR_BOOLEAN_TRUE);

    /* Transmit untagged PDelay Request packet and verify that none are received */
    ret = SendPacketsAndVerify(&ethCtrlIdx, 0UL, ETHER_ETHERTYPE_GPTP, pdelay_req_pkt, sizeof(pdelay_req_pkt), dstMacAddrNonIP, ETHSWT_CFP_MAX_RULES);
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("SendPacketsAndVerify() failed with %d\n", ret);
        cfp_qt_result = ret;
        goto err;
    }

    /* Initialize CFP block */
    ULOG_ERR("Initializing CFP\n");
    cfpConfig.ruleListSz = 0U;
    ret = ETHSWT_CFPInit(0UL, &cfpConfig);
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("CFP_Init() failed with %d\n", ret);
        cfp_qt_result = ret;
        goto err;
    }
    cfpConfig.ruleListSz = 1U;
    /* Insert rule to allow only un-tagged PDelay Request packets */
    BCM_MemCpy(&key, &cfpConfig.ruleList[0U].key, sizeof(ETHSWT_CFPKeyType));
    BCM_MemCpy(&action, &cfpConfig.ruleList[0U].action, sizeof(ETHSWT_CFPActionType));

    ULOG_ERR("Inserting rule to allow only un-tagged gPTP packets\n");
    row = ETHSWT_CFP_MAX_RULES;
    slice = ETHSWT_CFP_MAX_SLICES;
    ret = ETHSWT_CFPAddRule(0UL, &key, &action, &row, &slice);
    if ((BCM_ERR_OK != ret) || (row != 0UL) || (slice != 2UL)) {
        ULOG_ERR("ETHSWT_CFPAddRule() failed with %d row=%lu slice=%lu\n", ret, row, slice);
        cfp_qt_result = ret;
        goto err;
    }

    /* Transmit untagged (CTag) PDelay Request packets and confirm that the PDelay Request packets is received */
    ret = SendPacketsAndVerify(&ethCtrlIdx, NUM_PKTS, ETHER_ETHERTYPE_GPTP, pdelay_req_pkt, sizeof(pdelay_req_pkt), dstMacAddrNonIP, row);
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("SendPacketsAndVerify() failed with %d\n", ret);
        cfp_qt_result = ret;
        goto err;
    }

    /* Transmit VLAN-tagged (CTag) PDelay Request packets and confirm that the PDelay Request packets is not received */
    vlanID = 7U;
    ret = NIF_GetCtrlIdx(vlanID, BCM_ETS_ID, 0U, &ethCtrlIdx);
    ret = SendPacketsAndVerify(&ethCtrlIdx, 0U, ETHER_ETHERTYPE_GPTP, pdelay_req_pkt, sizeof(pdelay_req_pkt), dstMacAddrNonIP, row);
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("SendPacketsAndVerify() failed with %d\n", ret);
        cfp_qt_result = ret;
        goto err;
    }

    /* Remove rule for un-tagged gPTP packets */
    ULOG_ERR("Removing rule for forwarding only un-tagged gPTP packets\n");
    ret = ETHSWT_CFPRemoveRule(0UL, row);
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("ETHSWT_CFPRemoveRule() failed with %d\n", ret);
        cfp_qt_result = ret;
        goto err;
    }

    /* Insert rule to allow VLAN-tagged (CTag with VlanId 7U) PDelay Request packets */
    BCM_MemCpy(&key, &cfpConfig.ruleList[0U].key, sizeof(ETHSWT_CFPKeyType));
    BCM_MemCpy(&action, &cfpConfig.ruleList[0U].action, sizeof(ETHSWT_CFPActionType));
    key.cTagFlags         = (ETHSWT_CFP_KEY_TAG_VLAN_TAGGED_MASK | (ETHSWT_CFP_KEY_TAG_ID_VALID_MASK) | (7U << ETHSWT_CFP_KEY_TAG_ID_SHIFT));
    key.cTagMask          = 0x007;

    ULOG_ERR("Inserting rule to allow VLAN-tagged (CTag) gPTP packets with VlanId 7U \n");
    row = ETHSWT_CFP_MAX_RULES;
    slice = ETHSWT_CFP_MAX_SLICES;
    ret = ETHSWT_CFPAddRule(0UL, &key, &action, &row, &slice);
    if ((BCM_ERR_OK != ret) || (row != 0UL) || (slice != 2UL)) {
        ULOG_ERR("ETHSWT_CFPAddRule() failed with %d row=%lu slice=%lu\n", ret, row, slice);
        cfp_qt_result = ret;
        goto err;
    }

    /* Transmit untagged PDelay Request packet and verify that none are received */
    vlanID = 0U;
    ret = NIF_GetCtrlIdx(vlanID, BCM_ETS_ID, 0U, &ethCtrlIdx);
    ret = SendPacketsAndVerify(&ethCtrlIdx, 0UL, ETHER_ETHERTYPE_GPTP, pdelay_req_pkt, sizeof(pdelay_req_pkt), dstMacAddrNonIP, row);
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("SendPacketsAndVerify() failed with %d\n", ret);
        cfp_qt_result = ret;
        goto err;
    }

    /* Transmit VLAN-tagged (CTag, vlanID not equal to 7U) PDelay Request packets
       and confirm that the PDelay Request packets is not received */
    vlanID = 9U;
    ret = NIF_GetCtrlIdx(vlanID, BCM_ETS_ID, 0U, &ethCtrlIdx);
    ret = SendPacketsAndVerify(&ethCtrlIdx, 0UL, ETHER_ETHERTYPE_GPTP, pdelay_req_pkt, sizeof(pdelay_req_pkt), dstMacAddrNonIP, row);
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("SendPacketsAndVerify() failed with %d\n", ret);
        cfp_qt_result = ret;
        goto err;
    }

    /* Transmit VLAN-tagged (CTag, vlanID 7U) PDelay Request packets and confirm that the PDelay Request packets is received */
    vlanID = 7U;
    ret = NIF_GetCtrlIdx(vlanID, BCM_ETS_ID, 0U, &ethCtrlIdx);
    ret = SendPacketsAndVerify(&ethCtrlIdx, NUM_PKTS, ETHER_ETHERTYPE_GPTP, pdelay_req_pkt, sizeof(pdelay_req_pkt), dstMacAddrNonIP, row);
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("SendPacketsAndVerify() failed with %d\n", ret);
        cfp_qt_result = ret;
        goto err;
    }

    /* Check vlan mask */
    /* Transmit VLAN-tagged (CTag, vlanID 15U) PDelay Request packets and confirm that the PDelay Request packets is received */
    vlanID = 15U;
    ret = NIF_GetCtrlIdx(vlanID, BCM_ETS_ID, 0U, &ethCtrlIdx);
    ret = SendPacketsAndVerify(&ethCtrlIdx, NUM_PKTS, ETHER_ETHERTYPE_GPTP, pdelay_req_pkt, sizeof(pdelay_req_pkt), dstMacAddrNonIP, row);
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("SendPacketsAndVerify() failed with %d\n", ret);
        cfp_qt_result = ret;
        goto err;
    }

    /* Remove rule for VLAN-tagged (CTag, vlanID 7U) PDelay Request packets */
    ULOG_ERR("Removing rule for forwarding only VLAN-tagged (CTag, vlanID 7U) PDelay Request packets\n");
    ret = ETHSWT_CFPRemoveRule(0UL, row);
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("ETHSWT_CFPRemoveRule() failed with %d\n", ret);
        cfp_qt_result = ret;
        goto err;
    }

    /* Insert rule to allow all of VLAN-tagged, PRIO-tagged and un-tagged PDelay Request packets */
    BCM_MemCpy(&key, &cfpConfig.ruleList[0U].key, sizeof(ETHSWT_CFPKeyType));
    BCM_MemCpy(&action, &cfpConfig.ruleList[0U].action, sizeof(ETHSWT_CFPActionType));
    key.cTagFlags         = (ETHSWT_CFP_KEY_TAG_PRIO_TAGGED_MASK  |
                             ETHSWT_CFP_KEY_TAG_UN_TAGGED_MASK    |
                             ETHSWT_CFP_KEY_TAG_VLAN_TAGGED_MASK  |
                             ETHSWT_CFP_KEY_TAG_ID_VALID_MASK);

    ULOG_ERR("Inserting rule to allow all of VLAN-tagged, PRIO-tagged and un-tagged PDelay Request packets \n");
    row = ETHSWT_CFP_MAX_RULES;
    slice = ETHSWT_CFP_MAX_SLICES;
    ret = ETHSWT_CFPAddRule(0UL, &key, &action, &row, &slice);
    if ((BCM_ERR_OK != ret) || (row != 0UL) || (slice != 2UL)) {
        ULOG_ERR("ETHSWT_CFPAddRule() failed with %d row=%lu slice=%lu\n", ret, row, slice);
        cfp_qt_result = ret;
        goto err;
    }

    /* Transmit untagged (CTag) PDelay Request packets and confirm that the PDelay Request packets is received */
    vlanID = 0U;
    ret = NIF_GetCtrlIdx(vlanID, BCM_ETS_ID, 0U, &ethCtrlIdx);
    ret = SendPacketsAndVerify(&ethCtrlIdx, NUM_PKTS, ETHER_ETHERTYPE_GPTP, pdelay_req_pkt, sizeof(pdelay_req_pkt), dstMacAddrNonIP, row);
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("SendPacketsAndVerify() failed with %d\n", ret);
        cfp_qt_result = ret;
        goto err;
    }

    /* Transmit VLAN-tagged (CTag, vlanID 7U) PDelay Request packets and confirm that the PDelay Request packets is received */
    vlanID = 7U;
    ret = NIF_GetCtrlIdx(vlanID, BCM_ETS_ID, 0U, &ethCtrlIdx);
    ret = SendPacketsAndVerify(&ethCtrlIdx, NUM_PKTS, ETHER_ETHERTYPE_GPTP, pdelay_req_pkt, sizeof(pdelay_req_pkt), dstMacAddrNonIP, row);
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("SendPacketsAndVerify() failed with %d\n", ret);
        cfp_qt_result = ret;
        goto err;
    }

    /* Remove rule to allow all of VLAN-tagged, PRIO-tagged and un-tagged PDelay Request packets */
    ULOG_ERR("Removing rule for forwarding all of VLAN-tagged, PRIO-tagged and un-tagged PDelay Request packets\n");
    ret = ETHSWT_CFPRemoveRule(0UL, row);
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("ETHSWT_CFPRemoveRule() failed with %d\n", ret);
        cfp_qt_result = ret;
        goto err;
    }

    /* Create Rule to forward all IPv4 packets with VlanId 7U*/

    BCM_MemCpy(&key, &cfpConfig.ruleList[0U].key, sizeof(ETHSWT_CFPKeyType));
    BCM_MemCpy(&action, &cfpConfig.ruleList[0U].action, sizeof(ETHSWT_CFPActionType));
    key.cTagFlags         = (ETHSWT_CFP_KEY_TAG_VLAN_TAGGED_MASK | (ETHSWT_CFP_KEY_TAG_ID_VALID_MASK) | (7U << ETHSWT_CFP_KEY_TAG_ID_SHIFT));
    key.cTagMask          = 0x007;
    key.l3Framing         = ETHSWT_CFP_L3FRAMING_IPV4;
    key.flags             = 0x0;
    key.flagsMask         = 0x0;
    key.numEnabledUDFs    = 0U;

    ULOG_ERR("Inserting rule to allow VLAN-tagged (CTag) IPv4 packets with VlanId 7U \n");
    row = ETHSWT_CFP_MAX_RULES;
    slice = ETHSWT_CFP_MAX_SLICES;
    ret = ETHSWT_CFPAddRule(0UL, &key, &action, &row, &slice);
    if ((BCM_ERR_OK != ret) || (row != 0UL) || (slice != 2UL)) {
        ULOG_ERR("ETHSWT_CFPAddRule() failed with %d row=%lu slice=%lu\n", ret, row, slice);
        cfp_qt_result = ret;
        goto err;
    }

    /* Transmit VLAN-tagged (CTag, vlanID 9U) IPv4 packets and confirm that the IPv4 packets is not received */
    vlanID = 9U;
    ret = NIF_GetCtrlIdx(vlanID, BCM_NET_ID, 0U, &ethCtrlIdx);
    ret = SendPacketsAndVerify(&ethCtrlIdx, 0U, ETHER_ETHERTYPE_IP, ipv4_pkt, sizeof(ipv4_pkt), dstMacAddrIPv4, row);
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("SendPacketsAndVerify() failed with %d\n", ret);
        cfp_qt_result = ret;
        goto err;
    }

    /* Transmit VLAN-tagged (CTag, vlanID 7U) IPv4 packets and confirm that the IPv4 packets is received */
    vlanID = 7U;
    ret = NIF_GetCtrlIdx(vlanID, BCM_NET_ID, 0U, &ethCtrlIdx);
    ret = SendPacketsAndVerify(&ethCtrlIdx, NUM_PKTS, ETHER_ETHERTYPE_IP, ipv4_pkt, sizeof(ipv4_pkt), dstMacAddrIPv4, row);
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("SendPacketsAndVerify() failed with %d\n", ret);
        cfp_qt_result = ret;
        goto err;
    }

    /* Transmit VLAN-tagged (CTag, vlanID 15U) IPv4 packets and confirm that the IPv4 packets is received */
    vlanID = 15U;
    ret = NIF_GetCtrlIdx(vlanID, BCM_NET_ID, 0U, &ethCtrlIdx);
    ret = SendPacketsAndVerify(&ethCtrlIdx, NUM_PKTS, ETHER_ETHERTYPE_IP, ipv4_pkt, sizeof(ipv4_pkt), dstMacAddrIPv4, row);
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("SendPacketsAndVerify() failed with %d\n", ret);
        cfp_qt_result = ret;
        goto err;
    }

    /* Remove rule for VLAN-tagged (CTag, vlanID 7U) IPv4 packets */
    ULOG_ERR("Removing rule for forwarding only VLAN-tagged (CTag, vlanID 7U) IPv4 packets\n");
    ret = ETHSWT_CFPRemoveRule(0UL, row);
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("ETHSWT_CFPRemoveRule() failed with %d\n", ret);
        cfp_qt_result = ret;
        goto err;
    }

    /* De-Initialize CFP block */
    ULOG_ERR("De-initializing CFP\n");
    ret = ETHSWT_CFPDeInit(0UL);
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("CFP_DeInit() failed with %d\n", ret);
        cfp_qt_result = ret;
        goto err;
    }
err:
    return ret;
}

static const uint8_t EthIT1_MacAddr[] = {
    0x02, 0x01, 0x02, 0x03, 0x04, 0x05
};

static const ETHER_CfgType EthIT1_Config = {
    .hwID = 0UL,
#if defined(__BCM8956X__) || defined(__BCM8957X__)
    .speed = ETHER_SPEED_1000MBPS,
#else
    .speed = ETHER_SPEED_100MBPS,
#endif
    .duplexMode = ETHER_DUPLEX_MODE_FULL,
    .maxRxFrmLen = 1522UL,
    .macAddr = EthIT1_MacAddr,
#if defined(__BCM8908X__)
    .prioChanMap[0] = 0UL,
    .prioChanMap[1] = 0UL,
    .prioChanMap[2] = 1UL,
    .prioChanMap[3] = 1UL,
    .prioChanMap[4] = 2UL,
    .prioChanMap[5] = 2UL,
    .prioChanMap[6] = 3UL,
    .prioChanMap[7] = 3UL,
#endif
#if defined(__BCM8910X__)
    .prioChanMap[0] = 0UL,
    .prioChanMap[1] = 0UL,
    .prioChanMap[2] = 1UL,
    .prioChanMap[3] = 1UL,
    .prioChanMap[4] = 2UL,
    .prioChanMap[5] = 2UL,
    .prioChanMap[6] = 3UL,
    .prioChanMap[7] = 3UL,
#endif
#if defined(__BCM8953X__)
    .prioChanMap[0] = 0UL,
    .prioChanMap[1] = 0UL,
    .prioChanMap[2] = 0UL,
    .prioChanMap[3] = 0UL,
    .prioChanMap[4] = 0UL,
    .prioChanMap[5] = 0UL,
    .prioChanMap[6] = 0UL,
    .prioChanMap[7] = 0UL,
#endif
#if defined(__BCM8956X__) || defined(__BCM8957X__)
    .prioChanMap[0] = 0UL,
    .prioChanMap[1] = 0UL,
    .prioChanMap[2] = 0UL,
    .prioChanMap[3] = 0UL,
    .prioChanMap[4] = 0UL,
    .prioChanMap[5] = 0UL,
    .prioChanMap[6] = 0UL,
    .prioChanMap[7] = 0UL,
#endif
};

#if defined(__BCM8956X__)
const ETHXCVR_PortConfigType ETHXCVRQT_Cfg = {
    .id         = TEST_PORT,
    .portEnable = ETHXCVR_BOOLEAN_TRUE,
    .speed      = ETHXCVR_SPEED_100MBPS,
    .autoNeg    = ETHXCVR_BOOLEAN_FALSE,
    .duplex     = ETHXCVR_DUPLEXMODE_FULL,
    .flowControl= ETHXCVR_FLOWCONTROL_NONE,
    .jumbo      = ETHXCVR_BOOLEAN_FALSE,
    .busMode    = ETHXCVR_BUSMODE_INTG,
    .bus = {
     .cntrlID = 0U,
     .instID  = 0U,
     .driverParams = {{0U}},
    },
    .phy = {
     .hwID = 1U,
     .slaveID = 0U,
     .accessMode = ETHXCVR_ACCESSMODE_MMAP,
     .phyMedia = ETHXCVR_PHYMEDIA_100BASET1,
     .masterMode =ETHXCVR_BOOLEAN_TRUE,
     .driverParams = {{0U}},
    }
};
#endif

#if defined(__BCM8957X__)
const ETHXCVR_PortConfigType ETHXCVRQT_Cfg = {
    .id         = TEST_PORT,
    .portEnable = ETHXCVR_BOOLEAN_TRUE,
    .speed      = ETHXCVR_SPEED_1000MBPS,
    .autoNeg    = ETHXCVR_BOOLEAN_FALSE,
    .duplex     = ETHXCVR_DUPLEXMODE_FULL,
    .flowControl= ETHXCVR_FLOWCONTROL_NONE,
    .jumbo      = ETHXCVR_BOOLEAN_FALSE,
    .busMode    = ETHXCVR_BUSMODE_INTG,
    .bus = {
     .cntrlID = 0U,
     .instID  = 0U,
     .driverParams = {{0U}},
    },
    .phy = {
     .hwID = 0U,
     .slaveID = 0U,
     .accessMode = ETHXCVR_ACCESSMODE_MMAP,
     .phyMedia = ETHXCVR_PHYMEDIA_1000BASET1,
     .masterMode =ETHXCVR_BOOLEAN_TRUE,
     .driverParams = {{0U}},
    }
};
#endif


/* Helper function to set Ethernet controller to Active */
int32_t EthIT_SetModeActive(void)
{
    int32_t retVal;
    ETHER_ModeType mode;

    retVal = ETHER_SetMode(ETHER_HW_ID_0, ETHER_MODE_ACTIVE);
    if (BCM_ERR_OK == retVal) {
        retVal = ETHER_GetMode(ETHER_HW_ID_0, &mode);
        if (BCM_ERR_OK == retVal) {
            if (ETHER_MODE_ACTIVE != mode) {
                retVal = BCM_ERR_INVAL_STATE;
            }
        }
    }

    return retVal;
}

int32_t CFP_TestInit(void)
{
    int32_t ret;

    ETHXCVR_Init(TEST_PORT, &ETHXCVRQT_Cfg);
    ret = ETHXCVR_SetMode(TEST_PORT, ETHXCVR_MODE_ACTIVE);
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("ETHXCVR_SetMode() failed with %d\n", ret);
        goto err;
    }

    /* Initialize Ethernet driver */
    ETHER_Init(ETHER_HW_ID_0, &EthIT1_Config);

    /* Set controller mode to Active */
    ret = EthIT_SetModeActive();
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("EthIT_SetModeActive() failed with %d\n", ret);
        goto err;
    }

    ret = NIF_Init();
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("NIF_Init() failed with %d\n", ret);
        goto err;
    }
    ETHSWT_Init(ETHER_HW_ID);
    ret = MCU_EnableEthTraffic();
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("MCU_EnableEthTraffic() failed with %d\n", ret);
        goto err;
    }

err:
    return ret;
}

/** @brief CFP Test sequence 0

    This test simulates a whitelisting/blacklisting use case.

    @behavior Sync/Async, Re-entrant/Non-reentrant

    @pre
    -# gPTP client should be registered
    -# Task(CFPTest) should be in active state

    @param[in]      void

    @retval     #BCM_ERR_OK             CFP_QTSequence0 returned successfully
    @retval     #BCM_ERR_INVAL_PARAMS   Invalid parameter
    @retval     #BCM_ERR_UNKNOWN        Send and verification of packets failed
    @retval     #BCM_ERR_INVAL_STATE    CFP_Init/CFP_DeInit failed

    @post
    -# #BCM_ERR_OK should be returned

    @trace #BRCM_SWQTSEQ_CFP_SEQ0

    @limitations
    -# This test only verify CFP feature for Non-IP rules with gPTP client

  @code{.unparsed}
  # Activate CFP Test Task
  # Setup
    - Retrieve the NIF controller index for a gPTP client
    - Enable Ethernet loopback on test port
  # Transmit gPTP packets, (alternating between Sync and PDelay Request PDUs)
    destined to test port and verify that no packets are received
  # Have a single rule in the CFP configuration to forward gPTP PDelay Request
    packets, identified by destination MAC address 01:80:c2:00:00:0e, ethertype
    0x88f7 and message type 2 (in the common header), to the ARM CPU.
  # Initialize the CFP block using ETHSWT_CFPInit()
  # Transmit gPTP packets, (alternating between Sync and PDelay Request PDUs)
    destined to test port and verify that only half (PDelay Request) the packets are
    received
  # Retrieve statistics using ETHSWT_CFPGetStats() for row 0 and ensure that the green
    statistics counter is half of transmitted count, while others are zero
  # Insert a rule at row 0, slice 2 using ETHSWT_CFPAddRule(), to drop all gPTP PDUs.
    Verify that the call fails with BCM_ERR_NOPERM
  # Insert the same rule using ETHSWT_CFPAddRule(), to drop all gPTP PDUs, this time
    letting the module chose the row and slice. Verify that the rule successfully
    gets programmed at row 1 and slice 2
  # Transmit gPTP packets, (alternating between Sync and PDelay Request PDUs)
    destined to test port and verify that only half (PDelay Request) PDUs are received
  # Update the rule at row 1 (to drop all gPTP PDUs) using ETHSWT_CFPUpdateRule()
    to now forward them to the CPU
  # Transmit gPTP packets, (alternating between Sync and PDelay Request PDUs)
    destined to test port and verify that all are received
  # Disable test port using ETHSWT_CFPEnablePort()
  # Transmit gPTP packets, (alternating between Sync and PDelay Request PDUs)
    destined to test port and verify that none are received
  # Re-enable test port using ETHSWT_CFPEnablePort()
  # Transmit gPTP packets, (alternating between Sync and PDelay Request PDUs)
    destined to test port and verify that all are received
  # Remove the rule at row 1 using ETHSWT_CFPRemoveRule()
  # Transmit gPTP packets, (alternating between Sync and PDelay Request PDUs)
    destined to test port and verify that only half (PDelay Request) the PDUs are
    received
  # De-initialize the CFP block using ETHSWT_CFPDeInit()
  # Transmit gPTP packets, (alternating between Sync and PDelay Request PDUs)
    destined to test port and verify that none are received
  # Terminate CFP Test Task
@endcode
*/
int32_t CFP_QTSequence0(void)
{
    NIF_CntrlIDType ethCtrlIdx = ~(0x0ULL);
    int32_t         ret;
    uint32_t        row;
    uint32_t        slice;
    ETHSWT_CFPKeyType     key;
    ETHSWT_CFPActionType  action;
    ETHSWT_CFPStatsType   stats;
    ETHSWT_CFPRuleType    rule;

    /* Setup */
    ret = NIF_GetCtrlIdx(0U, BCM_ETS_ID, 0U, &ethCtrlIdx);

    /* Set loopback on Ethernet port */
    ETHXCVR_SetLoopbackMode(TEST_PORT, ETHXCVR_BOOLEAN_TRUE);

    /* Wait for completion */
    do {
        ret = ETHXCVR_StateHandler(TEST_PORT);
    } while (BCM_ERR_EAGAIN == ret);
    ULOG_ERR("ETHXCVR_StateHandler returned %d\n", ret);

    /* Transmit gPTP packets and verify that none are received */
    ret = SendGPTPPktsAndVerify(&ethCtrlIdx, 0UL);
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("SendGPTPPktsAndVerify() failed with %d\n", ret);
        cfp_qt_result = ret;
        goto err;
    }

    /* Initialize CFP block */
    ULOG_ERR("Initializing CFP\n");
    ret = ETHSWT_CFPInit(0UL, &cfpConfig);
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("ETHSWT_CFPInit() failed with %d\n", ret);
        cfp_qt_result = ret;
        goto err;
    }

    /* Transmit gPTP packets and confirm that only the PDelay Request packets are received */
    ret = SendGPTPPktsAndVerify(&ethCtrlIdx, NUM_PKTS/2UL);
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("SendGPTPPktsAndVerify() failed with %d\n", ret);
        cfp_qt_result = ret;
        goto err;
    }

    /* Retrieve stats */
    ret = ETHSWT_CFPGetStats(0UL, 0UL, &stats);
    if ((BCM_ERR_OK != ret) || (stats.green != NUM_PKTS/2UL) || (stats.yellow != 0UL) ||
        (stats.red != 0UL)) {
        ULOG_ERR("ETHSWT_CFPGetStats() failed with %d, GreenCntr = %lu \
                 YellowCntr = %lu RedCntr = %lu\n", ret, stats.green, stats.yellow,
                 stats.red);
        cfp_qt_result = ret;
        goto err;
    }

    /* Insert rule to drop all gPTP packets */
    BCM_MemCpy(&key, &cfpConfig.ruleList[0U].key, sizeof(ETHSWT_CFPKeyType));
    BCM_MemCpy(&action, &cfpConfig.ruleList[0U].action, sizeof(ETHSWT_CFPActionType));
    key.udfList[3U].value = 0x0U;
    key.udfList[3U].baseAndOffset = 0U;
    key.numEnabledUDFs = 3U;
    action.dstMapIBFlags = (ETHSWT_CFP_CHANGEFWDMAP_REP << ETHSWT_CFP_ACTION_CHANGE_FWDMAP_SHIFT);
    action.dstMapOBFlags = (ETHSWT_CFP_CHANGEFWDMAP_REP << ETHSWT_CFP_ACTION_CHANGE_FWDMAP_SHIFT);

    row = 0UL;
    slice = 2UL;
    ULOG_ERR("Inserting rule to drop all gPTP packets at row 0, slice 2\n");
    ret = ETHSWT_CFPAddRule(0UL, &key, &action, &row, &slice);
    if (BCM_ERR_NOPERM != ret) {
        ULOG_ERR("ETHSWT_CFPAddRule() did not fail with BCM_ERR_NOPERM when trying to overwrite static rule at row 0\n", ret);
        cfp_qt_result = ret;
        goto err;
    }

    ULOG_ERR("Inserting rule to drop all gPTP packets \n");
    row = ETHSWT_CFP_MAX_RULES;
    slice = ETHSWT_CFP_MAX_SLICES;
    ret = ETHSWT_CFPAddRule(0UL, &key, &action, &row, &slice);
    if ((BCM_ERR_OK != ret) || (row != 1UL) || (slice != 2UL)) {
        ULOG_ERR("ETHSWT_CFPAddRule() failed with %d row=%lu slice=%lu\n", ret, row, slice);
        cfp_qt_result = ret;
        goto err;
    }

    /* Transmit gPTP packets and confirm that only half are received */
    ret = SendGPTPPktsAndVerify(&ethCtrlIdx, NUM_PKTS/2UL);
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("SendGPTPPktsAndVerify() failed with %d\n", ret);
        cfp_qt_result = ret;
        goto err;
    }

    /* Update Rule to forward all gPTP packets */
    ULOG_ERR("Updating rule to forward all gPTP packets\n");
    action.dstMapIBFlags = (ETHSWT_CFP_CHANGEFWDMAP_REP << ETHSWT_CFP_ACTION_CHANGE_FWDMAP_SHIFT) | 0x80U,
    action.dstMapOBFlags = (ETHSWT_CFP_CHANGEFWDMAP_REP << ETHSWT_CFP_ACTION_CHANGE_FWDMAP_SHIFT) | 0x80U,
    ret = ETHSWT_CFPUpdateRule(0UL, row, &action);
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("ETHSWT_CFPUpdateRule() failed with %d\n", ret);
        cfp_qt_result = ret;
        goto err;
    }

    /* Fetch the configuration and verify that it took effect */
    ret = ETHSWT_CFPGetRowConfig(0UL, row, &rule);
    if ((BCM_ERR_OK != ret) || (rule.action.dstMapOBFlags != ((ETHSWT_CFP_CHANGEFWDMAP_REP << ETHSWT_CFP_ACTION_CHANGE_FWDMAP_SHIFT) | 0x80U))
        || (rule.key.numEnabledUDFs != 3U)) {
        ULOG_ERR("ETHSWT_CFPGetRowConfig() failed with %d, numEnabledUDFs = lu, dstMapOBFlags = 0x%x\n",
                   ret, rule.key.numEnabledUDFs, rule.action.dstMapOBFlags);
        cfp_qt_result = ret;
        goto err;
    }

    /* Transmit gPTP packets and confirm that all are received */
    ret = SendGPTPPktsAndVerify(&ethCtrlIdx, NUM_PKTS);
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("SendGPTPPktsAndVerify() failed with %d\n", ret);
        cfp_qt_result = ret;
        goto err;
    }

    /* Disable test port */
    ULOG_ERR("Disabling port %u\n", TEST_PORT);
    ret = ETHSWT_CFPDisablePort(0UL, TEST_PORT);
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("ETHSWT_CFPEnablePort() failed with %d\n", ret);
        cfp_qt_result = ret;
        goto err;
    }

    /* Transmit gPTP packets and confirm that none are received */
    ret = SendGPTPPktsAndVerify(&ethCtrlIdx, 0UL);
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("SendGPTPPktsAndVerify() failed with %d\n", ret);
        cfp_qt_result = ret;
        goto err;
    }

    /*Re-enable test port */
    ULOG_ERR("Re-enabling port %u\n", TEST_PORT);
    ret = ETHSWT_CFPEnablePort(0UL, TEST_PORT);
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("ETHSWT_CFPEnablePort() failed with %d\n", ret);
        cfp_qt_result = ret;
        goto err;
    }

    /* Transmit gPTP packets and confirm that all are received */
    ret = SendGPTPPktsAndVerify(&ethCtrlIdx, NUM_PKTS);
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("SendGPTPPktsAndVerify() failed with %d\n", ret);
        cfp_qt_result = ret;
        goto err;
    }

    /* Remove rule for all gPTP packets */
    ULOG_ERR("Removing rule for forwarding gPTP packets\n");
    ret = ETHSWT_CFPRemoveRule(0UL, row);
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("ETHSWT_CFPRemoveRule() failed with %d\n", ret);
        cfp_qt_result = ret;
        goto err;
    }

    /* Transmit gPTP packets and verify that only half are received */
    ret = SendGPTPPktsAndVerify(&ethCtrlIdx, NUM_PKTS/2UL);
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("SendGPTPPktsAndVerify() failed with %d\n", ret);
        cfp_qt_result = ret;
        goto err;
    }

    /* De-Initialize CFP block */
    ULOG_ERR("De-initializing CFP\n");
    ret = ETHSWT_CFPDeInit(0UL);
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("ETHSWT_CFPDeInit() failed with %d\n", ret);
        cfp_qt_result = ret;
        goto err;
    }

    /* Transmit gPTP packets and verify that none are received */
    ret = SendGPTPPktsAndVerify(&ethCtrlIdx, 0UL);
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("SendGPTPPktsAndVerify() failed with %d\n", ret);
        cfp_qt_result = ret;
        goto err;
    }
err:
    return ret;
}

/** @brief Brief description of COMP_IT1

  This test simulates masking feature of Tag

  @code{.unparsed}
@endcode
*/
TASK(CFPMaskTest)
{
    CFP_QTSequence1();

    ULOG_ERR("\n Test completed");
    if (BCM_AT_EXECUTING == cfp_qt_result) {
        cfp_qt_result = BCM_ERR_OK;
    }
    BCM_TerminateTask();
}

/** @brief Brief description of COMP_IT1

  This test simulates a whitelisting/blacklisting use case.

  @code{.unparsed}
@endcode
*/
TASK(CFPTest)
{
    CFP_QTSequence0();

    ULOG_ERR("\n Test completed");
    if (BCM_AT_EXECUTING == cfp_qt_result) {
        cfp_qt_result = BCM_ERR_OK;
    }
    BCM_TerminateTask();
}

/** @} */

int32_t BCM_ExecuteAT(uint32_t aIndex)
{
    int32_t ret = BCM_AT_NOT_AVAILABLE;
    if (FALSE == isCFPTestInitDone) {
        ret = CFP_TestInit();
        if (BCM_ERR_OK != ret) {
            ULOG_ERR("CFP_TestInit() failed with %d\n", ret);
            cfp_qt_result = ret;
            goto err;
        } else {
            isCFPTestInitDone = TRUE;
        }
    }
    if (1UL == aIndex) {
        cfp_qt_result = BCM_AT_EXECUTING;
        activeTaskIndex = aIndex;
        BCM_ActivateTask(CFPPktEventTask);
        BCM_ActivateTask(CFPTest);
        ret = BCM_ERR_OK;
    } else if (2UL == aIndex) {
        cfp_qt_result = BCM_AT_EXECUTING;
        activeTaskIndex = aIndex;
        BCM_ActivateTask(CFPPktEventTask);
        BCM_ActivateTask(CFPMaskTest);
        ret = BCM_ERR_OK;
    }

err:
    return ret;
}

int32_t BCM_GetResultAT(uint32_t aIndex)
{
    int32_t ret = BCM_AT_NOT_AVAILABLE;

    if (activeTaskIndex == aIndex) {
        ret = cfp_qt_result;
    }
    return ret;
}

void ETS_RxPktIndication (uint64_t aCtrlIdx,
                          const uint8_t *const aPktBuf,
                          uint16_t aPktLen,
                          const uint8_t *const aSrcMacAddr,
                          const uint8_t *const aDestMacAddr,
                          uint32_t aPriority)
{
    numRxPkts++;
}

void ETS_RxPktTSIndication(uint64_t aCtrlIdx,
                     const uint8_t *const aBuf,
                     const ETHSWT_MgmtInfoType *const aMgmtInfo,
                     const ETHER_TimestampType *const aTS,
                     const ETHER_TimestampQualType* const aTSQual)
{
}

void ETS_TxPktConfirmation (uint64_t aCtrlIdx,
                            uint32_t aBufIdx)
{
}

void ETS_TxPktTSIndication(uint64_t aCtrlIdx,
                           uint32_t aBufIdx,
                           const ETHSWT_MgmtInfoType *const aMgmtInfo,
                           const ETHER_TimestampType *const aTS,
                           const ETHER_TimestampQualType* const aTSQual)
{
}

#if !defined (ENABLE_INET)
void INET_RxIPv4Pkt(NIF_CntrlIDType aCtrlIdx,
        const uint8_t *const aBuf,
        uint16_t aLen,
        const uint8_t *const aSrcMacAddr,
        const uint8_t *const aDestMacAddr,
        uint32_t aPriority)
{
    numRxPkts++;
}

void INET_TxPktConfirmation(NIF_CntrlIDType aCtrlIdx,
        uint32_t aBufIdx)
{

}
#endif

void ETHXCVR_ModeIndication(ETHXCVR_IDType aID, ETHXCVR_ModeType aMode)
{
}
