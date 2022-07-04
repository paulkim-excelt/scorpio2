/*****************************************************************************
  Copyright 2017-2022 Broadcom Limited.  All rights reserved.

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
  @defgroup grp_inet_qt Qualification Tests
  @ingroup grp_inetlib

  @addtogroup grp_inet_qt
  @{

  @file udp_test.c
  @brief INET Library Integration Test
  This source file contains the qualification tests for INET library
  @version 0.86 Import from MS Word document
*/

#include <stdlib.h>
#include <string.h>
#include <ee.h>
#include <bcm_test.h>
#include <ulog.h>
#include <bcm_err.h>
#include <bcm_time.h>
#include <bcm_utils.h>
#include <shell.h>
#include <eth_osil.h>
#include <inet_cfg.h>
#include <inet_osil.h>
#include <osil/bcm_osil.h>
#include "udp.h"
#include <ulog.h>
#include <inet_test.h>

#define MARK_ERR(ret, line) {ULOG_ERR("\nError: %ld, \tline %d", ret, line); inet_qt1_result = ret;}

extern const INET_CfgType INET_Config;

static const INET_CfgType* const INET_ConnCfg = &INET_Config;

#define TEST1_PKT_SIZE      (INET_MAX_REASS_BUF_SIZE - 100U)
#define TEST2_PKT_SIZE      (INET_MAX_REASS_BUF_SIZE)
#define TEST1_NUM_TX_PKTS    50UL
#define TEST3_NUM_TX_PKTS    50UL

#define INET_PRINT_IP_ADDRESS(X) (X >> 24U) & 0xFFU, (X >> 16U) & 0xFFU,\
                                 (X >> 8U) & 0xFFU, (X & 0xFFU)

#define GetModuleLogLevel()  ULOG_LVL_ERROR
static uint32_t         rxPktCnt = 0UL;
static uint8_t          txBuf[TEST1_PKT_SIZE];
static uint8_t          rxBuf[TEST2_PKT_SIZE];
static volatile int32_t inet_qt1_result = BCM_AT_NOT_STARTED;
static uint32_t timer = 0UL;
static const uint8_t EthIT1_MacAddr[] = {
    0x02, 0x01, 0x02, 0x03, 0x04, 0x05
};

static const ETHER_CfgType EthIT1_Config = {
    .hwID = 0UL,
#if defined(__BCM8956X__) || defined(__BCM8957X__) || defined(__BCM8958X__)
    .speed = ETHER_SPEED_1000MBPS,
#else
    .speed = ETHER_SPEED_100MBPS,
#endif
    .duplexMode = ETHER_DUPLEX_MODE_FULL,
    .maxRxFrmLen = 1522UL,
    .macAddr = EthIT1_MacAddr,
#if defined(__BCM8908X__) || defined(__BCM8910X__)
    .prioChanMap[0] = 0UL,
    .prioChanMap[1] = 0UL,
    .prioChanMap[2] = 1UL,
    .prioChanMap[3] = 1UL,
    .prioChanMap[4] = 2UL,
    .prioChanMap[5] = 2UL,
    .prioChanMap[6] = 3UL,
    .prioChanMap[7] = 3UL,
#endif
#if defined(__BCM8953X__) || defined(__BCM8956X__) || defined(__BCM8957X__) || defined(__BCM8958X__)
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

void Systick_Callback(void)
{
    timer++;
    (void)SetEvent(Test1Task, SystemEvent0);
    (void)SetEvent(Test2Task, SystemEvent0);
}

int32_t Test_UDP_SendTo(const BCM_CompIDType aCompId,
                        const uint32_t aPayloadId,
                        const uint8_t* const aBuf,
                        const uint16_t aLen,
                        INET_IPAddressType aDestIPAddr,
                        INET_PortType aDestPort,
                        uint32_t testNumTxPkts)
{
    int32_t       ret = BCM_ERR_OK;
    BCM_EventMaskType mask = 0UL;
    uint32_t waitMask;
    uint32_t      txInProgress = 0UL;
    uint32_t      txPktCnt = 0UL;

    /* Test UDP_SendTo and UDP_Process */
    while (txPktCnt < testNumTxPkts) {
        /* By default INET reassembly buffers are configured  */
        /* with 15 KB size. Hence we test for total Tx packet */
        /* TEST1_PKT_SIZE less than 15 KB                     */
        ret = UDP_SendTo(aCompId, aPayloadId, aBuf, aLen, aDestIPAddr, aDestPort);
        if (ret == BCM_ERR_BUSY) {
            txInProgress = 1UL;
        } else if (ret == BCM_ERR_OK) {
            txPktCnt++;
        } else {
            ULOG_ERR("\nError: %d \t returned by UDP_SendTo",ret);
            inet_qt1_result = ret;
            break;
        }

        /* Send out any pending packets */
        while (1UL == txInProgress) {
            /* Wait for data or for retry event */
            waitMask = UDP_TxEvent | ETHER_PKT_EVENT;
            (void)BCM_WaitEvent(waitMask);
            (void)BCM_GetEvent(Test1Task, &mask);

            if (0UL != (mask & UDP_TxEvent)) {
                (void)BCM_ClearEvent(UDP_TxEvent);
                ret = UDP_Process(aCompId, aPayloadId);
                if (ret == BCM_ERR_OK) {
                    txInProgress = 0UL;
                    txPktCnt++;
                } else {
                    if (ret != BCM_ERR_BUSY) {
                        ULOG_ERR("\nError: %d \t returned by UDP_Process",ret);
                        inet_qt1_result = ret;
                        break;
                    }
                }
            }
            if (ETHER_PKT_EVENT == (mask & ETHER_PKT_EVENT)) {
                /* Process Ethernet */
                (void)BCM_ClearEvent(ETHER_PKT_EVENT);
                ETHER_ProcessPkts(0UL);
            }
        }
    }
    return ret;
}

/** @brief Brief description of COMP_IT1

  This test simulates UDP transmission, UDP reception and UDP cancellation.

  @code{.unparsed}

     # Add a static entry to the ARP cache to enable UDP_SendTo as ethernet
       loopback is enabled
     # Send a buffer of size INET_MAX_REASS_BUF_SIZE bytes filled with 0xAA
       pattern in all bytes using the UDP_SendTo API to a destination in unicast
       mode.
     # When BCM_ERR_BUSY is returned, wait for the UDP_TxEvent to execute
       UDP_Process API.
     # Invoke UDP_Process API repeatedly until it returns BCM_ERR_OK
     # As loopback test is enabled, this packet should be received by the same
       DUT and INET should set the event UDP_RxEvent to the client task
     # In a separate task, call the UDP_Recv API whenever UDP_RxEvent is got
     # Check for the return code from UDP_Recv and also the more data flag of
       UDP_Recv API
     # Invoke UDP_Recv API as long as more data flag is TRUE
     # Validate the Rx data with 0xAA value filled by the sender
     # Repeat steps 1-9 for ‘n’ times and validate
     # Repeat steps 1-10 for sending data to multicast and broadcast
       address/end points
     # Send a buffer of size 14500 bytes using the UDP_SendTo API
     # If BCM_ERR_BUSY is returned, execute UDP_CancelSend API and verify that
       this returns BCM_ERR_OK
     # In the task receiving data, check the throughput displayed.
@endcode
*/
void TestTask1()
{
    int32_t       ret;
    INET_InterfaceVlanTagConfigType vlanCfg = { .pcp = 2, .vlan = 1024 };
    INET_IPAddressType remoteAddr;

    BCM_MemSet(INET_Config.interfaces[0]->arpCache, 0U, sizeof(INET_ARPEntryType));
    BCM_MemSet(INET_Config.interfaces[1]->arpCache, 0U, sizeof(INET_ARPEntryType));

    INET_ARPEntryType* cache = INET_ConnCfg->interfaces[INET_INTERFACEID_0]->arpCache;
    /* Find a free slot to add the static entry */
    while (cache->valid) {
        cache++;
        continue;
    }
    /* Adding a dummy entry into ARP cache for loopback tests */
    cache->valid = 1UL;
    cache->ipAddr = (INET_CONVERT_IP_ADDRESS((192UL), (168UL), (10UL), (3UL)));
    cache->flags = INET_ARPENTRYSTATE_STATIC;
    cache->macAddr[0] = 0xAA;
    cache->macAddr[1] = 0xBB;
    cache->macAddr[2] = 0xCC;
    cache->macAddr[3] = 0xDD;
    cache->macAddr[4] = 0xEE;
    cache->macAddr[5] = 0xFF;

    ret = INET_Bind(0x1234, INET_PAYLOAD_ID0, 5000U);
    if (BCM_ERR_OK != ret) {
        inet_qt1_result = ret;
        goto error;
    }
    /* For loopback to same IP */
    remoteAddr = INET_CONVERT_IP_ADDRESS((192UL), (168UL), (10UL), (3UL));

    ret = INET_SetEndPointInterface(0x1234, INET_PAYLOAD_ID0, INET_INTERFACEID_0);
    if (BCM_ERR_OK != ret) {
        inet_qt1_result = ret;
        goto error;
    }

    ret = INET_SetEndPointInterface(0x1234, INET_PAYLOAD_ID3, INET_INTERFACEID_0);
    if (BCM_ERR_OK != ret) {
        inet_qt1_result = ret;
        goto error;
    }
    ret = INET_SetEndPointInterface(0x1234, INET_PAYLOAD_ID4, INET_INTERFACEID_0);
    if (BCM_ERR_OK != ret) {
        inet_qt1_result = ret;
        goto error;
    }

    ret = INET_UpdateInterface(INET_INTERFACEID_0, INET_IPADDRESSASSIGNMENT_STATIC,
                              (INET_CONVERT_IP_ADDRESS((192UL), (168UL), (10UL), (3UL))),
                              (24U), (INET_CONVERT_IP_ADDRESS((192UL), (168UL), (10UL), (1UL))),
                              &vlanCfg);
    if (BCM_ERR_OK != ret) {
        inet_qt1_result = ret;
        goto error;
    }
    BCM_MemSet(txBuf, 0xAAU, TEST1_PKT_SIZE);
    /* By default INET reassembly buffers are configured  */
    /* with 15 KB size. Hence we test for total Tx packet */
    /* TEST1_PKT_SIZE less than 15 KB                     */

    /* Send packets on unicast address */
    ret = Test_UDP_SendTo(0x1234, INET_PAYLOAD_ID0, txBuf, TEST1_PKT_SIZE, remoteAddr, 5000U, TEST1_NUM_TX_PKTS);
    if (ret != BCM_ERR_OK) {
        ULOG_ERR("\nError: %d \t returned by UDP_SendTo",ret);
        inet_qt1_result = ret;
        goto error;
    } else {
        ULOG_ERR("Tx Test for Unicast streaming - sent %d Tx Packets \n",TEST1_NUM_TX_PKTS);
    }

    ret = INET_Bind(0x1234, INET_PAYLOAD_ID3, 5003U);
    if (BCM_ERR_OK != ret) {
        inet_qt1_result = ret;
        goto error;
    }
    /* Multicast IP address */
    remoteAddr = INET_CONVERT_IP_ADDRESS((224UL), (10UL), (10UL), (10UL));
    /* Send packets on multicast address */
    ret = Test_UDP_SendTo(0x1234, INET_PAYLOAD_ID3, txBuf, TEST1_PKT_SIZE, remoteAddr, 5003U, TEST3_NUM_TX_PKTS);
    if (ret != BCM_ERR_OK) {
        ULOG_ERR("\nError: %d \t returned by UDP_SendTo",ret);
        inet_qt1_result = ret;
        goto error;
    } else {
        ULOG_ERR("Tx Test for Multicast streaming - sent %d Tx Packets \n",TEST3_NUM_TX_PKTS);
    }

    ret = INET_Bind(0x1234, INET_PAYLOAD_ID4, 5004U);
    if (BCM_ERR_OK != ret) {
        inet_qt1_result = ret;
        goto error;
    }
    /* Broadcast IP address */
    remoteAddr = INET_CONVERT_IP_ADDRESS((255UL), (255UL), (255UL), (255UL));
    /* Send packets on Broadcast address */
    ret = Test_UDP_SendTo(0x1234, INET_PAYLOAD_ID4, txBuf, TEST1_PKT_SIZE, remoteAddr, 5004U, TEST3_NUM_TX_PKTS);
    if (ret != BCM_ERR_OK) {
        ULOG_ERR("\nError: %d \t returned by UDP_SendTo",ret);
        inet_qt1_result = ret;
        goto error;
    } else {
        ULOG_ERR("Tx Test for Broadcast streaming - sent %d Tx Packets \n", TEST3_NUM_TX_PKTS);
    }
    while ((TEST1_NUM_TX_PKTS +
         TEST3_NUM_TX_PKTS +
         TEST3_NUM_TX_PKTS) > rxPktCnt) {
        ETHER_ProcessPkts(0UL);
    }
    ret = INET_Bind(0x1234, 0UL, 5000U);
    if (BCM_ERR_OK != ret) {
        inet_qt1_result = ret;
        goto error;
    }
    /* For loopback to same IP */
    remoteAddr = INET_CONVERT_IP_ADDRESS((192UL), (168UL), (10UL), (3UL));
    /* Test UDP_SendTo and UDP_CancelSend */
    ret = UDP_SendTo(0x1234, 0UL, txBuf, TEST1_PKT_SIZE, remoteAddr, 5000U);
    if (ret == BCM_ERR_BUSY) {
        /* Try and cancel the transmission */
        ret = UDP_CancelSend(0x1234, 0UL);
        if (BCM_ERR_OK != ret) {
            ULOG_ERR("\nError: %d \t returned by UDP_CancelSend",ret);
            inet_qt1_result = ret;
        }
    } else {
        ULOG_INFO("\nUDP_CancelSend not tested %d", ret);
    }
error:
    return;
}

uint64_t bitrate = 0ULL;
TASK(Test2Task)
{
    int32_t        ret = BCM_ERR_OK;
    BCM_EventMaskType  mask = 0UL;
    uint16_t       rxBufLen;
    uint32_t       rxBytes  = 0UL;
    INET_IPAddressType srcIPAddr;
    INET_PortType      srcPort;
    BCM_TimeType       start, end, diff;
    uint32_t       firstTime = 1UL;
    uint64_t       timeElapsedNs;
    timer = 0UL;

    /* Wait till all packets are received or till timeout */
    while ((timer < 500UL) &&
           ((TEST1_NUM_TX_PKTS + TEST3_NUM_TX_PKTS + TEST3_NUM_TX_PKTS) > rxPktCnt)) {
        uint8_t        moreData = 0U;
        /* Wait for data */
        (void)BCM_WaitEvent(UDP_RxEvent|SystemEvent0|SystemEvent4|SystemEvent5);
        (void)BCM_GetEvent(Test2Task, &mask);

        if (0UL != (mask & UDP_RxEvent)) {
            (void)BCM_ClearEvent(UDP_RxEvent);
            do {
                rxBufLen = TEST2_PKT_SIZE;
                moreData = 0U;

                ret = UDP_Recv(0x1234, INET_PAYLOAD_ID0, rxBuf, &rxBufLen,
                               &srcIPAddr, &srcPort, &moreData);
                if ((BCM_ERR_OK == ret ) && (0U < rxBufLen)) {
                    if (1UL == firstTime) {
                        BCM_GetTime(&start);
                        firstTime = 0UL;
                    } else {
                        BCM_GetTime(&end);
                    }
                    rxPktCnt++;
                    rxBytes += rxBufLen;
                    if (rxBuf[0U] == (0xAAU & 0xFFU)) {
                        ULOG_INFO("%u)Received %u bytes\n", rxPktCnt, rxBufLen);
                    } else {
                        ULOG_ERR("%u) Corruption %u bytes with byte 0x%x\n",
                                  rxPktCnt, rxBufLen, rxBuf[0U]);
                    }
                } else {
                    ULOG_ERR("\nError: %d \t returned by UDP_Recv",ret);
                }
            } while(1U == moreData);
        }
        if (0UL != (mask & SystemEvent4)) {
            (void)BCM_ClearEvent(SystemEvent4);
            do {
                rxBufLen = TEST2_PKT_SIZE;
                moreData = 0U;

                ret = UDP_Recv(0x1234, INET_PAYLOAD_ID3, rxBuf, &rxBufLen,
                               &srcIPAddr, &srcPort, &moreData);
                if ((BCM_ERR_OK == ret ) && (0U < rxBufLen)) {
                    if (1UL == firstTime) {
                        BCM_GetTime(&start);
                        firstTime = 0UL;
                    } else {
                        BCM_GetTime(&end);
                    }
                    rxPktCnt++;
                    rxBytes += rxBufLen;
                    if (rxBuf[0U] == (0xAAU & 0xFFU)) {
                        ULOG_INFO("%u)Received %u bytes\n", rxPktCnt, rxBufLen);
                    } else {
                        ULOG_ERR("%u) Corruption %u bytes with byte 0x%x\n",
                                  rxPktCnt, rxBufLen, rxBuf[0U]);
                    }
                } else {
                    ULOG_ERR("\nError: %d \t returned by UDP_Recv",ret);
                }
            } while(1U == moreData);
        }
        if (0UL != (mask & SystemEvent5)) {
            (void)BCM_ClearEvent(SystemEvent5);
            do {
                rxBufLen = TEST2_PKT_SIZE;
                moreData = 0U;

                ret = UDP_Recv(0x1234, INET_PAYLOAD_ID4, rxBuf, &rxBufLen,
                               &srcIPAddr, &srcPort, &moreData);
                if ((BCM_ERR_OK == ret ) && (0U < rxBufLen)) {
                    if (1UL == firstTime) {
                        BCM_GetTime(&start);
                        firstTime = 0UL;
                    } else {
                        BCM_GetTime(&end);
                    }
                    rxPktCnt++;
                    rxBytes += rxBufLen;
                    if (rxBuf[0U] == (0xAAU & 0xFFU)) {
                        ULOG_INFO("%u)Received %u bytes\n", rxPktCnt, rxBufLen);
                    } else {
                        ULOG_ERR("%u) Corruption %u bytes with byte 0x%x\n",
                                  rxPktCnt, rxBufLen, rxBuf[0U]);
                    }
                } else {
                    ULOG_ERR("\nError: %d \t returned by UDP_Recv",ret);
                }
            } while(1U == moreData);
        }
        if (0UL != (mask & SystemEvent0)) {
            (void)BCM_ClearEvent(SystemEvent0);
        }

    }
    diff = BCM_GetTimeAbsDiff(start, end);
    timeElapsedNs = diff.s * 1000000000ULL + diff.ns;
    if (0ULL != timeElapsedNs){
        bitrate = (rxBytes * 8000000000ULL)/ timeElapsedNs;
    }
    ULOG_ERR("\nThroughput Test : %lu pkts %lu bytes recvd %u (bps) bitrate\n",
                    rxPktCnt, rxBytes, (uint32_t)bitrate );

    ret = INET_UnBind(0x1234, INET_PAYLOAD_ID0);
    if (BCM_ERR_OK != ret) {
        inet_qt1_result = ret;
    }
    ret = INET_UnBind(0x1234, INET_PAYLOAD_ID3);
    if (BCM_ERR_OK != ret) {
        inet_qt1_result = ret;
    }

    ret = INET_UnBind(0x1234, INET_PAYLOAD_ID4);
    if (BCM_ERR_OK != ret) {
        inet_qt1_result = ret;
    }
    /* TEST1_NUM_TX_PKTS - Unicast packets   */
    /* TEST3_NUM_TX_PKTS - Multicast packets */
    /* TEST3_NUM_TX_PKTS - Broadcast packets */
    if ((TEST1_NUM_TX_PKTS +
         TEST3_NUM_TX_PKTS +
         TEST3_NUM_TX_PKTS) > rxPktCnt) {
        inet_qt1_result = BCM_ERR_UNKNOWN;
    } else {
        inet_qt1_result = BCM_ERR_OK;
    }

    ret = INET_TestCommonDeInit();

    (void)BCM_TerminateTask();
}

int32_t UDP_ExecuteQT()
{
    int32_t ret = BCM_AT_NOT_AVAILABLE;

    ret = INET_TestCommonInit(EthIT1_MacAddr, &EthIT1_Config);
    if (BCM_ERR_OK != ret) {
        MARK_ERR(ret, __LINE__);
        goto done;
    }

    inet_qt1_result = BCM_AT_EXECUTING;
    (void)BCM_ActivateTask(Test2Task);
    TestTask1();

done:
    return ret;
}

int32_t UDP_GetResultQT()
{
    return inet_qt1_result;
}
