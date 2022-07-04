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
#include "security_qt.h"
#include <eth_switch.h>
#include <mcu_switch_ext.h>

#define BRPHY_PORTS     (4UL)
#define SGMII_MAX_HW_ID (5UL)
#define GetModuleLogLevel()     ULOG_LVL_ERROR

#define MAX_ARL_ENTRY_TEST (20U)
#define VLAN_TAG_SIZE      (4UL)
#define ETHERTYPE_SIZE     (2UL)

const uint32_t TestPort1 = 1UL;
const uint32_t TestPort2 = 2UL;
const uint32_t TestPort3 = 3UL;
const uint32_t TestPort4 = 4UL;
const uint32_t TestPort7 = 7UL;
const uint32_t IMP_PORT  = 8UL;
uint32_t line = 0xFFFFFFFF;

static uint32_t numExpectedRxPkts = 0UL;

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

const uint8_t dstMacAddrIPv4[] = {0x30U, 0x80U, 0xC2U, 0x00U, 0x00U, 0x02U};
const ETHER_VLANIDType vlanID = 1024U;
NIF_CntrlIDType ethCntrlIdx = ~(0x0ULL);
static volatile int32_t security_qt_result = BCM_AT_NOT_STARTED;
static volatile uint32_t activeTaskIndex;

void DelayTimerAlarmCb(void)
{
    (void)SetEvent(SecurityTest, SystemEvent0);
}

static int32_t DeleteARLTable(void)
{
    int32_t               ret = BCM_ERR_OK;
    uint32_t              i;
    ETHSWT_ARLEntryType   aARLTbl[MAX_ARL_ENTRY_TEST];
    uint16_t aTblSize = MAX_ARL_ENTRY_TEST;
    ret = ETHSWT_GetARLTable(0U, aARLTbl, &aTblSize);
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("ETHSWT_GetARLTable() failed with %d\n", ret);
        line = __LINE__;
         goto err;
    }
    for (i = 0UL; i < aTblSize; ++i) {
        ret = ETHSWT_DeleteARLEntry(0U, &aARLTbl[i]);
        if (BCM_ERR_OK != ret) {
            ULOG_ERR("ETHSWT_DeleteARLEntry() at index %d failed with %d\n", i, ret);
            line = __LINE__;
            goto err;
        }
    }
err:
    return ret;
}

static int32_t ResetConfig(void)
{
    int32_t  ret = BCM_ERR_OK;
    uint32_t testport;

    for(testport = TestPort1; testport <= TestPort4; testport++) {
        /* Clear loopback on Ethernet port testport */
        ret = ETHSWT_SetPortLoopbackMode(0U, testport, ETHXCVR_BOOLEAN_FALSE);
        if (ret != BCM_ERR_OK) {
             ULOG_ERR("ETHSWT_SetPortLoopbackMode() returned error: %d Port: %lu\n", ret, testport);
             security_qt_result = ret;
             line = __LINE__;
             goto err;
        }
    }
    /* Delete ARL Table */
    ret = DeleteARLTable();
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("DeleteARLTable() failed with %d\n", ret);
        security_qt_result = ret;
        line = __LINE__;
        goto err;
    }
err:
    return ret;
}

static int32_t InitConfig(void)
{
    int32_t ret = BCM_ERR_OK;
    /* Create vlan 1024U */
    ret = ETHSWT_AddVLANPorts(0U, 0x00FF , vlanID, 0x00FF);
    if (ret != BCM_ERR_OK) {
         ULOG_ERR("ETHERSWT_AddVLANPorts() returned error: %d\n", ret);
         security_qt_result = ret;
         line = __LINE__;
         goto err;
     }
    ret = NIF_GetCtrlIdx(vlanID, BCM_NET_ID, 0U, &ethCntrlIdx);
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("NIF_GetCtrlIdx() failed with %d\n", ret);
        security_qt_result = ret;
        line = __LINE__;
        goto err;
    }
    /* Delete ARL Table */
    ret = DeleteARLTable();
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("DeleteARLTable() failed with %d\n", ret);
        security_qt_result = ret;
        line = __LINE__;
        goto err;
    }
err:
    return ret;
}

static void Delay(uint32_t aTicks)
{
    BCM_EventMaskType mask = 0UL;
    /* Now wait for upto aTicks */
    BCM_SetRelAlarm(DelayTimerAlarm, aTicks, 0U);
    BCM_WaitEvent(SystemEvent0);
    BCM_GetEvent(SecurityTest, &mask);
    if (mask & SystemEvent0) {
        BCM_ClearEvent(SystemEvent0);
    }
    /* Disable the alarm so that it can be reused */
    BCM_CancelAlarm(DelayTimerAlarm);
}

static int32_t SendPacketsAndVerify(const NIF_CntrlIDType* const ethCntrlIdx,
                                 uint32_t numExpected, ETHER_EtherType ethertype,
                                 const uint8_t *const aPacket, uint32_t aLength,
                                 const uint8_t *dstMacAddr, uint32_t numToSend,
                                 uint32_t aTestPort, ETHSWT_SecurityActionType aAction)
{
    uint32_t              i            = 0UL;
    uint8_t               *pdu         = NULL;
    uint32_t              bufIdx       = 0xFFUL;
    uint32_t              length;
    int32_t               ret = BCM_ERR_OK;
    ETHSWT_MgmtInfoType mgmtInfo;
    numExpectedRxPkts = numExpected;
    ETHER_RxStatsType rxStat1;
    ETHER_RxStatsType rxStat2;
    ETHER_TxStatsType txStat1;
    ETHER_TxStatsType txStat2;

    /* Get Tx stat of IMP_PORT before sending the pacteks */
    ret = ETHSWT_GetTxStat(0U, IMP_PORT, &txStat1);
    if (ret != BCM_ERR_OK) {
        ULOG_ERR("ETHSWT_GetTxStat() returned error: %d\n", ret);
        line = __LINE__;
        goto err;
    }
    /* Get Rx stat of aTestPort before sending the pacteks */
    ret = ETHSWT_GetRxStat(0U, aTestPort, &rxStat1);
    if (ret != BCM_ERR_OK) {
        ULOG_ERR("ETHSWT_GetRxStat() returned error: %d\n", ret);
        line = __LINE__;
        goto err;
    }

    for (i = 0UL; i < numToSend; ++i) {
        length = aLength;
        ret = NIF_GetTxBuffer(*ethCntrlIdx, ethertype, 6U, &bufIdx, &pdu, &length);
        if (BCM_ERR_OK != ret) {
            ULOG_ERR("NIF_GetTxBuffer() failed with %d\n", ret);
            line = __LINE__;
            goto err;
        }

        BCM_MemCpy(pdu, aPacket, aLength);

        mgmtInfo.switchIdx = 0UL;
        mgmtInfo.portIdx   = aTestPort;
        mgmtInfo.tc        = ETHSWT_TC_4;
        ret = NIF_SwtSetMgmtInfo(*ethCntrlIdx, bufIdx, &mgmtInfo);
        if (BCM_ERR_OK != ret) {
            ULOG_ERR("NIF_SwtSetMgmtInfo() failed with %d\n", ret);
            line = __LINE__;
            goto err;
        }
        ret = NIF_Send(*ethCntrlIdx, ethertype, 1UL, bufIdx, aLength, dstMacAddr);

        if (BCM_ERR_OK != ret) {
            ULOG_ERR("NIF_Send() failed with %d\n", ret);
            line = __LINE__;
            goto err;
        }
    }

    /* Now wait for upto 30 ticks for packets to be received */
    Delay(30UL);
    /* Get Rx stat of aTestPort after sending the pacteks */
    ret = ETHSWT_GetRxStat(0U, aTestPort, &rxStat2);
    if (ret != BCM_ERR_OK) {
        ULOG_ERR("ETHSWT_GetRxStat() returned error: %d\n", ret);
        goto err;
    }
    /* Get Tx stat of IMP_PORT after sending the pacteks */
    ret = ETHSWT_GetTxStat(0U, IMP_PORT, &txStat2);
    if (ret != BCM_ERR_OK) {
        ULOG_ERR("ETHSWT_GetTxStat() returned error: %d\n", ret);
        line = __LINE__;
        goto err;
    }
    if((ETHSWT_SECURITY_ACTION_REDIRECT_TO_CPU == aAction) ||
       (ETHSWT_SECURITY_ACTION_COPY_TO_CPU == aAction)) {
        if((rxStat2.uniCast - rxStat1.uniCast) != numToSend) {
            ULOG_ERR("Packets are not received as expected on TestPort: %lu rxStat2.uniCast:%lu\
            rxStat1.uniCast:%lu expected received :%lu\n", aTestPort, rxStat2.uniCast, rxStat1.uniCast, numToSend);
            ret = BCM_ERR_UNKNOWN;
            goto err;

        }
        if((txStat2.uniCast - txStat1.uniCast) != numToSend) {
            ULOG_ERR("Packets are not forwarded as expected to IMP Port from Testport: %lu txStat2.uniCast:%lu\
            txStat1.uniCast:%lu expected:%lu\n", aTestPort, txStat2.uniCast, txStat1.uniCast, numToSend);
            ret = BCM_ERR_UNKNOWN;
            goto err;

        }
    } else {
        if((rxStat2.uniCast - rxStat1.uniCast) != numToSend) {
            ULOG_ERR("Packets are not received as expected on TestPort: %lu  rxStat2.uniCast:%lu\
            rxStat1.uniCast:%lu expected received :%lu\n", aTestPort, rxStat2.uniCast, rxStat1.uniCast, numToSend);
            ret = BCM_ERR_UNKNOWN;
            goto err;

        }
        if((rxStat2.pktsRxDiscard - rxStat1.pktsRxDiscard) != (numToSend - numExpected)) {
            ULOG_ERR("Packets are not discarded as expected on TestPort: %lu rxStat2.pktsRxDiscard:%lu\
            rxStat1.pktsRxDiscard:%lu expected discard :%lu\n", aTestPort, rxStat2.pktsRxDiscard, rxStat1.pktsRxDiscard, (numToSend - numExpected));
            ret = BCM_ERR_UNKNOWN;
            goto err;

        }
        if(txStat2.uniCast != txStat1.uniCast) {
            ULOG_ERR("Packets are forwarded to IMP Port which is not expected from Testport: %lu txStat2.uniCast:%lu\
            txStat1.uniCast:%lu expected:%lu\n", aTestPort, txStat2.uniCast, txStat1.uniCast, numToSend);
            ret = BCM_ERR_UNKNOWN;
            goto err;

        }
    }
err:
    return ret;
}

static int32_t SendDoubleTaggedPacketsAndVerify(const NIF_CntrlIDType* const ethCntrlIdx,
                                 uint32_t numExpected, ETHER_EtherType ethertype,
                                 const uint8_t *const aPacket, uint32_t aLength,
                                 const uint8_t *dstMacAddr, uint32_t numToSend,
                                 uint32_t aTestPort, ETHSWT_SecurityActionType aAction)
{
    uint32_t              i            = 0UL;
    uint8_t               *pktBuf      = NULL;
    uint32_t              bufIdx       = 0xFFUL;
    uint32_t              pktLen;
    int32_t               ret = BCM_ERR_OK;
    uint8_t               priority;
    ETHSWT_MgmtInfoType mgmtInfo;
    numExpectedRxPkts = numExpected;
    ETHER_RxStatsType rxPort7Stat1;
    ETHER_RxStatsType rxPort7Stat2;
    ETHER_TxStatsType txPort7Stat1;
    ETHER_TxStatsType txPort7Stat2;
    ETHER_TxStatsType txIMPStat1;
    ETHER_TxStatsType txIMPStat2;
    ETHER_RxStatsType rxTestPortStat1;
    ETHER_RxStatsType rxTestPortStat2;

    /* Get Tx stat of IMP_PORT before sending the pacteks */
    ret = ETHSWT_GetTxStat(0U, IMP_PORT, &txIMPStat1);
    if (ret != BCM_ERR_OK) {
        ULOG_ERR("ETHSWT_GetTxStat() returned error: %d\n", ret);
        line = __LINE__;
        goto err;
    }

    /* Get Tx stat of TestPort7 before sending the pacteks */
    ret = ETHSWT_GetTxStat(0U, TestPort7, &txPort7Stat1);
    if (ret != BCM_ERR_OK) {
        ULOG_ERR("ETHSWT_GetTxStat() returned error: %d\n", ret);
        line = __LINE__;
        goto err;
    }

    /* Get Rx stat of TestPort7 before sending the pacteks */
    ret = ETHSWT_GetRxStat(0U, TestPort7, &rxPort7Stat1);
    if (ret != BCM_ERR_OK) {
        ULOG_ERR("ETHSWT_GetRxStat() returned error: %d\n", ret);
        line = __LINE__;
        goto err;
    }

    /* Get Rx stat of aTestPort before sending the pacteks */
    ret = ETHSWT_GetRxStat(0U, aTestPort, &rxTestPortStat1);
    if (ret != BCM_ERR_OK) {
        ULOG_ERR("ETHSWT_GetRxStat() returned error: %d\n", ret);
        line = __LINE__;
        goto err;
    }

    for (i = 0UL; i < numToSend; ++i) {
      /* Get buffer from Ethernet Driver */
        priority = 6U;
        pktLen = sizeof(ipv4_pkt) + VLAN_TAG_SIZE + VLAN_TAG_SIZE + ETHERTYPE_SIZE;
        ret = ETHER_GetTxBuffer(0U, priority, &bufIdx, &pktBuf, &pktLen);
        if (BCM_ERR_OK != ret) {
            ULOG_ERR("ETHER_GetTxBuffer() failed with %d\n", ret);
            line = __LINE__;
            goto err;
        }

        /* Insert VLAN tag1 */
       *((ETHER_EtherType *)(pktBuf)) = CPU_NativeToBE16(ETHER_ETHERTYPE_VLANTAG);
        pktBuf += 2UL;
        *((ETHER_VLANIDType *)(pktBuf)) = CPU_NativeToBE16((priority << 13UL) | (vlanID & 0xFFFU));
        pktBuf += 2UL;

        /* Insert VLAN tag2 */
       *((ETHER_EtherType *)(pktBuf)) = CPU_NativeToBE16(ETHER_ETHERTYPE_VLANTAG);
        pktBuf += 2UL;
        *((ETHER_VLANIDType *)(pktBuf)) = CPU_NativeToBE16((priority << 13UL) | (vlanID & 0xFFFU));
        pktBuf += 2UL;

        /* Insert Ethertype */
        *((ETHER_EtherType *)(pktBuf)) = CPU_NativeToBE16(ETHER_ETHERTYPE_IP);
         pktBuf += 2UL;

        /* Copy the packet to be send, into the buffer */
        memcpy(pktBuf, ipv4_pkt, sizeof(ipv4_pkt));

        mgmtInfo.switchIdx = 0UL;
        mgmtInfo.portIdx   = aTestPort;
        mgmtInfo.tc        = ETHSWT_TC_4;

        ret = ETHSWT_SetMgmtInfo(0U, bufIdx, &mgmtInfo);
        if (BCM_ERR_OK != ret) {
            ULOG_ERR("ETHSWT_SetMgmtInfo() failed with %d\n", ret);
            line = __LINE__;
            goto err;
        }
        ret = ETHER_Send(0U, 1UL, bufIdx, pktLen, dstMacAddr);

        if (BCM_ERR_OK != ret) {
            ULOG_ERR("ETHER_Send() failed with %d\n", ret);
            line = __LINE__;
            goto err;
        }
    }

    /* Now wait for upto 30 ticks for packets to be received */
    Delay(30UL);

    /* Get Rx stat of TestPort7 after sending the pacteks */
    ret = ETHSWT_GetRxStat(0U, TestPort7, &rxPort7Stat2);
    if (ret != BCM_ERR_OK) {
        ULOG_ERR("ETHSWT_GetRxStat() returned error: %d\n", ret);
        goto err;
    }

    /* Get Tx stat of TestPort7 after sending the pacteks */
    ret = ETHSWT_GetTxStat(0U, TestPort7, &txPort7Stat2);
    if (ret != BCM_ERR_OK) {
        ULOG_ERR("ETHSWT_GetTxStat() returned error: %d\n", ret);
        line = __LINE__;
        goto err;
    }
    /* Get Tx stat of IMP_PORT after sending the pacteks */
    ret = ETHSWT_GetTxStat(0U, IMP_PORT, &txIMPStat2);
    if (ret != BCM_ERR_OK) {
        ULOG_ERR("ETHSWT_GetTxStat() returned error: %d\n", ret);
        line = __LINE__;
        goto err;
    }
    /* Get Rx stat of aTestPort after sending the pacteks */
    ret = ETHSWT_GetRxStat(0U, aTestPort, &rxTestPortStat2);
    if (ret != BCM_ERR_OK) {
        ULOG_ERR("ETHSWT_GetRxStat() returned error: %d\n", ret);
        line = __LINE__;
        goto err;
    }
    if(ETHSWT_SECURITY_ACTION_REDIRECT_TO_CPU == aAction) {
        if(rxPort7Stat2.pktsRxDiscard != rxPort7Stat1.pktsRxDiscard) {
            ULOG_ERR("Packets are discarded on ARM-CPU port: %lu which should be redirected to IMP Port rxPort7Stat2.pktsRxDiscard:%lu\
            rxPort7Stat1.pktsRxDiscard:%lu\n", TestPort7, rxPort7Stat2.pktsRxDiscard, rxPort7Stat1.pktsRxDiscard);
            ret = BCM_ERR_UNKNOWN;
            goto err;

        }
        if((txIMPStat2.uniCast - txIMPStat1.uniCast) != numToSend) {
            ULOG_ERR("Packets are not forwarded as expected to IMP Port from Testport: %lu txIMPStat2.uniCast:%lu\
            txIMPStat1.uniCast:%lu expected:%lu\n", aTestPort, txIMPStat2.uniCast, txIMPStat1.uniCast, numToSend);
            ret = BCM_ERR_UNKNOWN;
            goto err;

        }
        if((txPort7Stat2.uniCast - txPort7Stat1.uniCast) != numExpected) {
            ULOG_ERR("Packets are received which is not expected on ARM CPU Port: %lu txPort7Stat2.uniCast:%lu\
            txPort7Stat1.uniCast:%lu expected :%lu\n", TestPort7, txPort7Stat2.uniCast, txPort7Stat1.uniCast, numExpected);
            ret = BCM_ERR_UNKNOWN;
            goto err;

        }
    } else {
        if(((rxPort7Stat2.pktsRxDiscard - rxPort7Stat1.pktsRxDiscard) != (numToSend - numExpected)) &&
           ((txPort7Stat2.uniCast - txPort7Stat1.uniCast) != numExpected)) {
            ULOG_ERR("Packets are not discarded as expected on ARM CPU Port: %lu rxPort7Stat2.pktsRxDiscard:%lu\
            rxPort7Stat1.pktsRxDiscard:%lu expected discard :%lu\n", TestPort7, rxPort7Stat2.pktsRxDiscard, rxPort7Stat1.pktsRxDiscard, (numToSend - numExpected));
            ret = BCM_ERR_UNKNOWN;
            goto err;

        }
        if((rxTestPortStat2.uniCast - rxTestPortStat1.uniCast) != numExpected) {
            ULOG_ERR("Packets are not received as expected on TestPort: %lu rxTestPortStat2.uniCast:%lu\
            rxTestPortStat1.uniCast:%lu expected received :%lu\n", aTestPort, rxTestPortStat2.uniCast, rxTestPortStat1.uniCast, numExpected);
            ret = BCM_ERR_UNKNOWN;
            goto err;

        }
        if(txIMPStat2.uniCast != txIMPStat1.uniCast) {
            ULOG_ERR("Packets are forwarded to IMP Port from Testport:%lu which is not expected txIMPStat2.uniCast:%lu\
            txIMPStat1.uniCast:%lu expected:%lu\n", aTestPort, txIMPStat2.uniCast, txIMPStat1.uniCast, numToSend);
            ret = BCM_ERR_UNKNOWN;
            goto err;

        }
    }
    ULOG_ERR("Sent %lu packets and received %lu back, expected %lu\n", numToSend, numExpected, numExpected);

err:
    return ret;
}

void SMDetectSeq1(void)
{
    int32_t         ret = BCM_ERR_OK;
    ETHSWT_SecurityActionType stationMoveAction;
    uint8_t               srcMacAddrIPv4[] = {0x02U, 0x00U, 0x00U, 0x01U, 0x29U, 0x51U};
    line     = 0xFFFFFFFF;
    /* Setup */

    /*** Station Movement Test ***/
    /* If a MAC address has been learned by hardware on a port,
    and a packet with the same address as MAC-SA enters the
    switch from a different physical port, then it should
    be discarded */

    ret = InitConfig();
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("InitConfig() failed with %d\n", ret);
        security_qt_result = ret;
        line = __LINE__;
        goto err;
    }

    /* Set Source MAC Address */
    ret = ETHER_SetMacAddr(0U, srcMacAddrIPv4);
    if (ret != BCM_ERR_OK) {
         ULOG_ERR("ETHER_SetMacAddr() returned error: %d\n", ret);
         security_qt_result = ret;
         line = __LINE__;
         goto err;
    }

    /* Set loopback on Ethernet TestPort1 */
    ret = ETHSWT_SetPortLoopbackMode(0U, TestPort1, ETHXCVR_BOOLEAN_TRUE);
    if (ret != BCM_ERR_OK) {
         ULOG_ERR("ETHSWT_SetPortLoopbackMode() returned error: %d\n", ret);
         security_qt_result = ret;
         line = __LINE__;
         goto err;
     }
    Delay(10UL);
    /* Transmit VLAN-tagged (CTag, vlanID 1024U) IPv4 packets and confirm that the IPv4 packets is received */
    ret = SendPacketsAndVerify(&ethCntrlIdx, 5U, ETHER_ETHERTYPE_IP, ipv4_pkt, sizeof(ipv4_pkt), dstMacAddrIPv4, 5U, TestPort1, ETHSWT_SECURITY_ACTION_DISABLED);
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("SendPacketsAndVerify() failed with %d\n", ret);
        security_qt_result = ret;
        line = __LINE__;
        goto err;
    }

    /* Clear loopback on Ethernet port TestPort1 */
    ret = ETHSWT_SetPortLoopbackMode(0U, TestPort1, ETHXCVR_BOOLEAN_FALSE);
    if (ret != BCM_ERR_OK) {
         ULOG_ERR("ETHSWT_SetPortLoopbackMode() returned error: %d\n", ret);
         security_qt_result = ret;
         line = __LINE__;
         goto err;
     }


    /* Set loopback on Ethernet port TestPort2*/
    ret = ETHSWT_SetPortLoopbackMode(0U, TestPort2, ETHXCVR_BOOLEAN_TRUE);
    if (ret != BCM_ERR_OK) {
         ULOG_ERR("ETHSWT_SetPortLoopbackMode() returned error: %d\n", ret);
         security_qt_result = ret;
         line = __LINE__;
         goto err;
     }
    Delay(10UL);

    ret = ETHSWT_GetStationMovementDetection(0U, TestPort2, &stationMoveAction);
    if (ret != BCM_ERR_OK) {
         ULOG_ERR("ETHSWT_SetStationMovementDetection() returned error: %d\n", ret);
         security_qt_result = ret;
         line = __LINE__;
         goto err;
    }
    if (ETHSWT_SECURITY_ACTION_DROP_PKT != stationMoveAction) {
         ULOG_ERR("ETHSWT_GetStationMovementDetection() returned action: %u\n", stationMoveAction);
         security_qt_result = BCM_ERR_UNKNOWN;
         line = __LINE__;
         goto err;
    }
    ret = SendPacketsAndVerify(&ethCntrlIdx, 0U, ETHER_ETHERTYPE_IP, ipv4_pkt, sizeof(ipv4_pkt), dstMacAddrIPv4, 5U, TestPort2, ETHSWT_SECURITY_ACTION_DROP_PKT);
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("SendPacketsAndVerify() failed with %d\n", ret);
        security_qt_result = ret;
        line = __LINE__;
        goto err;
    }

    /* Set Station movement detection (action as Redirect to CPU) on Ethernet port TestPort2 */
    stationMoveAction = ETHSWT_SECURITY_ACTION_REDIRECT_TO_CPU;
    ret = ETHSWT_SetStationMovementDetection(0U, TestPort2, stationMoveAction);
    if (ret != BCM_ERR_OK) {
         ULOG_ERR("ETHSWT_SetStationMovementDetection() returned error: %d\n", ret);
         security_qt_result = ret;
         line = __LINE__;
         goto err;
    }
    ret = ETHSWT_GetStationMovementDetection(0U, TestPort2, &stationMoveAction);
    if (ret != BCM_ERR_OK) {
         ULOG_ERR("ETHSWT_GetStationMovementDetection() returned error: %d\n", ret);
         security_qt_result = ret;
         line = __LINE__;
         goto err;
    }

    if (ETHSWT_SECURITY_ACTION_REDIRECT_TO_CPU != stationMoveAction) {
         ULOG_ERR("ETHSWT_GetStationMovementDetection() returned action: %u\n", stationMoveAction);
         security_qt_result = BCM_ERR_UNKNOWN;
         line = __LINE__;
         goto err;
    }
    ret = SendPacketsAndVerify(&ethCntrlIdx, 0U, ETHER_ETHERTYPE_IP, ipv4_pkt, sizeof(ipv4_pkt), dstMacAddrIPv4, 5U, TestPort2, ETHSWT_SECURITY_ACTION_REDIRECT_TO_CPU);
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("SendPacketsAndVerify() failed with %d\n", ret);
        security_qt_result = ret;
        line = __LINE__;
        goto err;
    }
    /* Clear Station movement detection on Ethernet port TestPort2 */
    stationMoveAction = ETHSWT_SECURITY_ACTION_DISABLED;
    ret = ETHSWT_SetStationMovementDetection(0U, TestPort2, stationMoveAction);
    if (ret != BCM_ERR_OK) {
         ULOG_ERR("ETHSWT_SetStationMovementDetection() returned error: %d\n", ret);
         security_qt_result = ret;
         line = __LINE__;
         goto err;
    }
    ret = SendPacketsAndVerify(&ethCntrlIdx, 5U, ETHER_ETHERTYPE_IP, ipv4_pkt, sizeof(ipv4_pkt), dstMacAddrIPv4, 5U, TestPort2, ETHSWT_SECURITY_ACTION_DISABLED);
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("SendPacketsAndVerify() failed with %d\n", ret);
        security_qt_result = ret;
        line = __LINE__;
        goto err;
    }

    /* Set Station movement detection on Ethernet port TestPort2 */
    stationMoveAction = ETHSWT_SECURITY_ACTION_DROP_PKT;
    ret = ETHSWT_SetStationMovementDetection(0U, TestPort2, stationMoveAction);
    if (ret != BCM_ERR_OK) {
         ULOG_ERR("ETHSWT_SetStationMovementDetection() returned error: %d\n", ret);
         security_qt_result = ret;
         line = __LINE__;
         goto err;
    }

    ret = ETHSWT_GetStationMovementDetection(0U, TestPort2, &stationMoveAction);
    if (ret != BCM_ERR_OK) {
         ULOG_ERR("ETHSWT_GetStationMovementDetection() returned error: %d\n", ret);
         security_qt_result = ret;
         line = __LINE__;
         goto err;
    }

    if (ETHSWT_SECURITY_ACTION_DROP_PKT != stationMoveAction) {
         ULOG_ERR("ETHSWT_GetStationMovementDetection() returned action: %u\n", stationMoveAction);
         security_qt_result = BCM_ERR_UNKNOWN;
         line = __LINE__;
         goto err;
    }

err:
    ret = ResetConfig();
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("ResetConfig() failed with %d\n", ret);
        security_qt_result = ret;
        line = __LINE__;
    }
    return;
}

void StickyMACSeq2(void)
{
    int32_t         ret = BCM_ERR_OK;
    ETHSWT_SecurityActionType stickyMACAction;
    ETHSWT_ARLEntryType arlEntry;
    uint8_t  srcMacAddrIPv4[] = {0x02U, 0x00U, 0x00U, 0x01U, 0x29U, 0x51U};
    line     = 0xFFFFFFFF;
    /* Setup */

    /* If a single MAC address (or a small number of MAC addresses)
       is/are sticky to a port, then any packet arriving with MAC
       address which is sticky to that port should only be allowed.*/

    ret = InitConfig();
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("InitConfig() failed with %d\n", ret);
        security_qt_result = ret;
        line = __LINE__;
        goto err;
    }

    /* Set loopback on Ethernet port TestPort3*/
    ret = ETHSWT_SetPortLoopbackMode(0U, TestPort3, ETHXCVR_BOOLEAN_TRUE);
    if (ret != BCM_ERR_OK) {
         ULOG_ERR("ETHSWT_SetPortLoopbackMode() returned error: %d\n", ret);
         security_qt_result = ret;
         line = __LINE__;
         goto err;
    }

    /* Get Source MAC Address */
    ret = ETHER_GetMacAddr(0U, srcMacAddrIPv4);
    if (ret != BCM_ERR_OK) {
         ULOG_ERR("ETHER_GetMacAddr() returned error: %d\n", ret);
         security_qt_result = ret;
         line = __LINE__;
         goto err;
    }

    /* Add ARL Entry */
    BCM_MemCpy(&arlEntry.macAddr, &srcMacAddrIPv4, sizeof(srcMacAddrIPv4));
    arlEntry.vlanID = vlanID;
    arlEntry.portMask = (1U << TestPort3);
    ret = ETHSWT_AddARLEntry(0U, &arlEntry);
    if (ret != BCM_ERR_OK) {
         ULOG_ERR("ETHSWT_AddARLEntry() returned error: %d\n", ret);
         security_qt_result = ret;
         line = __LINE__;
         goto err;
    }

    ret = ETHSWT_GetMACAddressStickyToPort(0U, TestPort3, &stickyMACAction);
    if (ret != BCM_ERR_OK) {
         ULOG_ERR("ETHSWT_GetMACAddressStickyToPort() returned error: %d\n", ret);
         security_qt_result = ret;
         line = __LINE__;
         goto err;
    }

    if (ETHSWT_SECURITY_ACTION_DROP_PKT != stickyMACAction) {
         ULOG_ERR("ETHSWT_GetMACAddressStickyToPort() returned action: %u expected: %u\n", stickyMACAction, ETHSWT_SECURITY_ACTION_DROP_PKT);
         security_qt_result = BCM_ERR_UNKNOWN;
         line = __LINE__;
         goto err;
    }
    /* Send 5 packets(With sticky SA-MAC) and verify that all should be received on TestPort3*/
    ret = SendPacketsAndVerify(&ethCntrlIdx, 5U, ETHER_ETHERTYPE_IP, ipv4_pkt, sizeof(ipv4_pkt), dstMacAddrIPv4, 5U, TestPort3, ETHSWT_SECURITY_ACTION_DROP_PKT);
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("SendPacketsAndVerify() failed with %d\n", ret);
        security_qt_result = ret;
        line = __LINE__;
        goto err;
    }

    /* Set Source MAC Address */
    srcMacAddrIPv4[5] += 1U;
    ret = ETHER_SetMacAddr(0U, srcMacAddrIPv4);
    if (ret != BCM_ERR_OK) {
         ULOG_ERR("ETHER_SetMacAddr() returned error: %d\n", ret);
         security_qt_result = ret;
         line = __LINE__;
         goto err;
    }

    /* Send 5 packets(With non sticky SA-MAC) and verify that none of them should be received on TestPort3*/
    ret = SendPacketsAndVerify(&ethCntrlIdx, 0U, ETHER_ETHERTYPE_IP, ipv4_pkt, sizeof(ipv4_pkt), dstMacAddrIPv4, 5U, TestPort3, ETHSWT_SECURITY_ACTION_DROP_PKT);
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("SendPacketsAndVerify() failed with %d\n", ret);
        security_qt_result = ret;
        line = __LINE__;
        goto err;
    }
    /* Making the MAC Address sticky to TestPort3 (with action Redirect to CPU)*/
    stickyMACAction = ETHSWT_SECURITY_ACTION_REDIRECT_TO_CPU;
    ret = ETHSWT_SetMACAddressStickyToPort(0U, TestPort3, stickyMACAction);
    if (ret != BCM_ERR_OK) {
         ULOG_ERR("ETHSWT_SetMACAddressStickyToPort() returned error: %d\n", ret);
         security_qt_result = ret;
         line = __LINE__;
         goto err;
    }
    ret = ETHSWT_GetMACAddressStickyToPort(0U, TestPort3, &stickyMACAction);
    if (ret != BCM_ERR_OK) {
         ULOG_ERR("ETHSWT_GetMACAddressStickyToPort() returned error: %d\n", ret);
         security_qt_result = ret;
         line = __LINE__;
         goto err;
    }

    if (ETHSWT_SECURITY_ACTION_REDIRECT_TO_CPU != stickyMACAction) {
         ULOG_ERR("ETHSWT_GetMACAddressStickyToPort() returned action: %u expected: %u\n", stickyMACAction, ETHSWT_SECURITY_ACTION_DROP_PKT);
         security_qt_result = BCM_ERR_UNKNOWN;
         line = __LINE__;
         goto err;
    }
    /* Send 5 packets(With non sticky SA-MAC) and verify that none of them should be received on TestPort3*/
    ret = SendPacketsAndVerify(&ethCntrlIdx, 0U, ETHER_ETHERTYPE_IP, ipv4_pkt, sizeof(ipv4_pkt), dstMacAddrIPv4, 5U, TestPort3, ETHSWT_SECURITY_ACTION_REDIRECT_TO_CPU);
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("SendPacketsAndVerify() failed with %d\n", ret);
        security_qt_result = ret;
        line = __LINE__;
        goto err;
    }
    /* Disable sticky MAC Address to TestPort3*/
    stickyMACAction = ETHSWT_SECURITY_ACTION_DISABLED;
    ret = ETHSWT_SetMACAddressStickyToPort(0U, TestPort3, stickyMACAction);
    if (ret != BCM_ERR_OK) {
         ULOG_ERR("ETHSWT_SetMACAddressStickyToPort() returned error: %d\n", ret);
         security_qt_result = ret;
         line = __LINE__;
         goto err;
    }

    /* Send 5 packets(With non sticky SA-MAC) and verify that all should be received on TestPort3 */
    ret = SendPacketsAndVerify(&ethCntrlIdx, 5U, ETHER_ETHERTYPE_IP, ipv4_pkt, sizeof(ipv4_pkt), dstMacAddrIPv4, 5U, TestPort3, ETHSWT_SECURITY_ACTION_DISABLED);
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("SendPacketsAndVerify() failed with %d\n", ret);
        security_qt_result = ret;
        line = __LINE__;
        goto err;
    }

    /* Making the MAC Address sticky to TestPort3*/
    stickyMACAction = ETHSWT_SECURITY_ACTION_DROP_PKT;
    ret = ETHSWT_SetMACAddressStickyToPort(0U, TestPort3, stickyMACAction);
    if (ret != BCM_ERR_OK) {
         ULOG_ERR("ETHSWT_SetMACAddressStickyToPort() returned error: %d\n", ret);
         security_qt_result = ret;
         line = __LINE__;
         goto err;
    }
    ret = ETHSWT_GetMACAddressStickyToPort(0U, TestPort3, &stickyMACAction);
    if (ret != BCM_ERR_OK) {
         ULOG_ERR("ETHSWT_GetMACAddressStickyToPort() returned error: %d\n", ret);
         security_qt_result = ret;
         line = __LINE__;
         goto err;
    }

    if (ETHSWT_SECURITY_ACTION_DROP_PKT != stickyMACAction) {
         ULOG_ERR("ETHSWT_GetMACAddressStickyToPort() returned action: %u expected: %u\n", stickyMACAction, ETHSWT_SECURITY_ACTION_DROP_PKT);
         security_qt_result = BCM_ERR_UNKNOWN;
         line = __LINE__;
         goto err;
    }
err:
    ret = ResetConfig();
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("ResetConfig() failed with %d\n", ret);
        security_qt_result = ret;
        line = __LINE__;
    }
    return;
}

void VLANHoppingDetectSeq3(void)
{
    int32_t         ret = BCM_ERR_OK;
    ETHSWT_SecurityActionType vlanHoppingAction;
    line     = 0xFFFFFFFF;
    /*** VLAN HOPPING Test ***/

    /* Set Vlan Hopping detection */

    ret = InitConfig();
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("InitConfig() failed with %d\n", ret);
        security_qt_result = ret;
        line = __LINE__;
        goto err;
    }

    /* Set loopback on Ethernet port TestPort1*/
    ret = ETHSWT_SetPortLoopbackMode(0U, TestPort1, ETHXCVR_BOOLEAN_TRUE);
    if (ret != BCM_ERR_OK) {
         ULOG_ERR("ETHSWT_SetPortLoopbackMode() returned error: %d\n", ret);
         security_qt_result = ret;
         line = __LINE__;
         goto err;
    }
    Delay(10UL);
    ret = ETHSWT_GetVlanHoppingDetection(0U, &vlanHoppingAction);
    if (ret != BCM_ERR_OK) {
         ULOG_ERR("ETHSWT_GetVlanHoppingDetection() returned error: %d\n", ret);
         security_qt_result = ret;
         line = __LINE__;
         goto err;
    }
    if (ETHSWT_SECURITY_ACTION_DROP_PKT != vlanHoppingAction) {
         ULOG_ERR("ETHSWT_GetVlanHoppingDetection() returned action: %u\n", vlanHoppingAction);
         security_qt_result = BCM_ERR_UNKNOWN;
         line = __LINE__;
         goto err;
    }
    ret = SendDoubleTaggedPacketsAndVerify(&ethCntrlIdx, 0U, ETHER_ETHERTYPE_IP, ipv4_pkt, sizeof(ipv4_pkt), dstMacAddrIPv4, 5U, TestPort1, ETHSWT_SECURITY_ACTION_DROP_PKT);
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("SendDoubleTaggedPacketsAndVerify() failed with %d\n", ret);
        security_qt_result = ret;
        line = __LINE__;
        goto err;
    }
    /* Set Vlan Hopping detection with action as redirect to IMP Port */
    vlanHoppingAction = ETHSWT_SECURITY_ACTION_REDIRECT_TO_CPU;
    ret = ETHSWT_SetVlanHoppingDetection(0U, vlanHoppingAction);
    if (ret != BCM_ERR_OK) {
         ULOG_ERR("ETHSWT_SetVlanHoppingDetection() returned error: %d\n", ret);
         security_qt_result = ret;
         line = __LINE__;
         goto err;
    }
    ret = ETHSWT_GetVlanHoppingDetection(0U, &vlanHoppingAction);
    if (ret != BCM_ERR_OK) {
         ULOG_ERR("ETHSWT_GetVlanHoppingDetection() returned error: %d\n", ret);
         security_qt_result = ret;
         line = __LINE__;
         goto err;
    }
    if (ETHSWT_SECURITY_ACTION_REDIRECT_TO_CPU != vlanHoppingAction) {
         ULOG_ERR("ETHSWT_GetVlanHoppingDetection() returned action: %u\n", vlanHoppingAction);
         security_qt_result = BCM_ERR_UNKNOWN;
         line = __LINE__;
         goto err;
    }
    ret = SendDoubleTaggedPacketsAndVerify(&ethCntrlIdx, 0U, ETHER_ETHERTYPE_IP, ipv4_pkt, sizeof(ipv4_pkt), dstMacAddrIPv4, 5U, TestPort1, ETHSWT_SECURITY_ACTION_REDIRECT_TO_CPU);
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("SendDoubleTaggedPacketsAndVerify() failed with %d\n", ret);
        security_qt_result = ret;
        line = __LINE__;
        goto err;
    }
    /* Clear Vlan Hopping detection */
    vlanHoppingAction = ETHSWT_SECURITY_ACTION_DISABLED;
    ret = ETHSWT_SetVlanHoppingDetection(0U, vlanHoppingAction);
    if (ret != BCM_ERR_OK) {
         ULOG_ERR("ETHSWT_SetVlanHoppingDetection() returned error: %d\n", ret);
         security_qt_result = ret;
         line = __LINE__;
         goto err;
    }
    ret = ETHSWT_GetVlanHoppingDetection(0U, &vlanHoppingAction);
    if (ret != BCM_ERR_OK) {
         ULOG_ERR("ETHSWT_GetVlanHoppingDetection() returned error: %d\n", ret);
         security_qt_result = ret;
         line = __LINE__;
         goto err;
    }
    if (ETHSWT_SECURITY_ACTION_DISABLED != vlanHoppingAction) {
         ULOG_ERR("ETHSWT_GetVlanHoppingDetection() returned action: %u\n", vlanHoppingAction);
         security_qt_result = BCM_ERR_UNKNOWN;
         line = __LINE__;
         goto err;
    }
    ret = SendDoubleTaggedPacketsAndVerify(&ethCntrlIdx, 5U, ETHER_ETHERTYPE_IP, ipv4_pkt, sizeof(ipv4_pkt), dstMacAddrIPv4, 5U, TestPort1, ETHSWT_SECURITY_ACTION_DISABLED);
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("SendDoubleTaggedPacketsAndVerify() failed with %d\n", ret);
        security_qt_result = ret;
        line = __LINE__;
        goto err;
    }

    vlanHoppingAction = ETHSWT_SECURITY_ACTION_DROP_PKT;
    ret = ETHSWT_SetVlanHoppingDetection(0U, vlanHoppingAction);
    if (ret != BCM_ERR_OK) {
         ULOG_ERR("ETHSWT_SetVlanHoppingDetection() returned error: %d\n", ret);
         security_qt_result = ret;
         line = __LINE__;
         goto err;
    }
    ret = ETHSWT_GetVlanHoppingDetection(0U, &vlanHoppingAction);
    if (ret != BCM_ERR_OK) {
         ULOG_ERR("ETHSWT_GetVlanHoppingDetection() returned error: %d\n", ret);
         security_qt_result = ret;
         line = __LINE__;
         goto err;
    }
    if (ETHSWT_SECURITY_ACTION_DROP_PKT != vlanHoppingAction) {
         ULOG_ERR("ETHSWT_GetVlanHoppingDetection() returned action: %u\n", vlanHoppingAction);
         security_qt_result = BCM_ERR_UNKNOWN;
         line = __LINE__;
         goto err;
    }
err:
    ret = ResetConfig();
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("ResetConfig() failed with %d\n", ret);
        security_qt_result = ret;
        line = __LINE__;
    }
    return;
}

static int32_t AddressLimittingSubSeq(ETHSWT_SecurityActionType aAction)
{
    int32_t         ret = BCM_ERR_OK;
    ETHSWT_AddressLimitingType addressLimitInfo;
    uint8_t srcMacAddrIPv4[] = {0x02U, 0x00U, 0x00U, 0x01U, 0x29U, 0x51U};
    uint16_t aPortLearnedCounter;
    uint32_t aPortOverLimitCounter;
    uint32_t numExpected;
    line     = 0xFFFFFFFF;

    switch (aAction) {
        case ETHSWT_SECURITY_ACTION_DROP_PKT:
            numExpected = 0UL;
            break;
        case ETHSWT_SECURITY_ACTION_NORMAL:
            numExpected = 1UL;
            break;
        case ETHSWT_SECURITY_ACTION_REDIRECT_TO_CPU:
            numExpected = 0UL;
            break;
        default:
            numExpected = 1UL; /* ETHSWT_SECURITY_ACTION_COPY_TO_CPU */
            break;
    }
    /* Delete ARL Table */
    ret = DeleteARLTable();
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("DeleteARLTable() failed with %d\n", ret);
        line = __LINE__;
        goto err;
    }
    ret = ETHER_SetMacAddr(0U, srcMacAddrIPv4);
    if (ret != BCM_ERR_OK) {
         ULOG_ERR("ETHER_SetMacAddr() returned error: %d\n", ret);
         line = __LINE__;
         goto err;
    }
    if(aAction != ETHSWT_SECURITY_ACTION_DROP_PKT) {
        /* Set Address Limiting to TestPort4*/
        addressLimitInfo.overLimitAction = aAction;
        addressLimitInfo.macLearningLimit = 5U;
        ret = ETHSWT_SetPortAddrLimiting(0U, TestPort4, &addressLimitInfo);
        if (ret != BCM_ERR_OK) {
             ULOG_ERR("ETHSWT_SetPortAddrLimiting() returned error: %d\n", ret);
             line = __LINE__;
             goto err;
        }
    }
    ret = ETHSWT_GetPortAddrLimitAndCounter(0U, TestPort4, &addressLimitInfo, &aPortLearnedCounter, &aPortOverLimitCounter);
    if (ret != BCM_ERR_OK) {
         ULOG_ERR("ETHSWT_GetPortAddrLimitAndCounter() returned error: %d\n", ret);
         line = __LINE__;
         goto err;
    }
    if ((addressLimitInfo.overLimitAction != aAction) ||
         (addressLimitInfo.macLearningLimit != 5U)) {
         ULOG_ERR("ETHSWT_GetPortAddrLimitAndCounter() returned action: %u Limit: %u\n", addressLimitInfo.overLimitAction,
         addressLimitInfo.macLearningLimit);
         ret = BCM_ERR_UNKNOWN;
         line = __LINE__;
         goto err;
    }

    for (uint8_t i = 1UL; i <= 10UL; i++) {
        /* Set Source MAC Address */
        srcMacAddrIPv4[5] += 1U;
        ret = ETHER_SetMacAddr(0U, srcMacAddrIPv4);
        if (ret != BCM_ERR_OK) {
             ULOG_ERR("ETHER_SetMacAddr() returned error: %d\n", ret);
             line = __LINE__;
             goto err;
        }
        if (i <= addressLimitInfo.macLearningLimit) {
            /* Send 1 packets and verify that should be received on TestPort4 */
            ret = SendPacketsAndVerify(&ethCntrlIdx, 1U, ETHER_ETHERTYPE_IP, ipv4_pkt,
                                       sizeof(ipv4_pkt), dstMacAddrIPv4, 1U, TestPort4, ETHSWT_SECURITY_ACTION_DISABLED);
        } else {
            ret = SendPacketsAndVerify(&ethCntrlIdx, numExpected, ETHER_ETHERTYPE_IP, ipv4_pkt,
                                       sizeof(ipv4_pkt), dstMacAddrIPv4, 1U, TestPort4, aAction);
        }
        if (BCM_ERR_OK != ret) {
            ULOG_ERR("SendPacketsAndVerify() failed with %d\n", ret);
            line = __LINE__;
            goto err;
        }
    }
    ret = ETHSWT_GetPortAddrLimitAndCounter(0U, TestPort4, &addressLimitInfo, &aPortLearnedCounter, &aPortOverLimitCounter);
    if (ret != BCM_ERR_OK) {
         ULOG_ERR("ETHSWT_GetPortAddrLimitAndCounter() returned error: %d\n", ret);
         line = __LINE__;
         goto err;
    }
    if ((aPortLearnedCounter != addressLimitInfo.macLearningLimit) ||
         (aPortOverLimitCounter != 5U)) {
         ULOG_ERR("ETHSWT_GetPortAddrLimitAndCounter() returned aPortLearnedCounter: %u aPortOverLimitCounter: %u\n", aPortLearnedCounter, aPortOverLimitCounter);
         ret = BCM_ERR_UNKNOWN;
         line = __LINE__;
         goto err;
    }
err:
    return ret;
}
void AddressLimittingSeq4(void)
{
    int32_t         ret = BCM_ERR_OK;
    ETHSWT_AddressLimitingType addressLimitInfo;
    uint8_t srcMacAddrIPv4[] = {0x02U, 0x00U, 0x00U, 0x01U, 0x29U, 0x51U};
    uint16_t portMACLimit1;
    uint16_t portMACLimit2;
    uint16_t totalMACLimit;
    uint16_t aPortLearnedCounter;
    uint32_t aPortOverLimitCounter;
    uint16_t aTotalMACLearningLimit;
    uint16_t aTotalLearnedCounter;
    line     = 0xFFFFFFFF;

    ret = InitConfig();
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("InitConfig() failed with %d\n", ret);
        security_qt_result = ret;
        line = __LINE__;
        goto err;
    }
    /* Set loopback on Ethernet port TestPort4*/
    ret = ETHSWT_SetPortLoopbackMode(0U, TestPort4, ETHXCVR_BOOLEAN_TRUE);
    if (ret != BCM_ERR_OK) {
         ULOG_ERR("ETHSWT_SetPortLoopbackMode() returned error: %d\n", ret);
         security_qt_result = ret;
         line = __LINE__;
         goto err;
    }
    Delay(10UL);

    /* If the count of dynamically learned unicast MAC addresses
       on a particular port exceeds with the maximum programmed
       value for that port, then appropriate action should be
       triggered */

    ret = AddressLimittingSubSeq(ETHSWT_SECURITY_ACTION_DROP_PKT);
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("AddressLimittingSubSeq() failed with %d action: %u\n", ret, ETHSWT_SECURITY_ACTION_DROP_PKT);
        security_qt_result = ret;
        line = __LINE__;
        goto err;
    }
    ret = AddressLimittingSubSeq(ETHSWT_SECURITY_ACTION_REDIRECT_TO_CPU);
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("AddressLimittingSubSeq() failed with %d action: %u\n", ret, ETHSWT_SECURITY_ACTION_REDIRECT_TO_CPU);
        security_qt_result = ret;
        line = __LINE__;
        goto err;
    }
    ret = AddressLimittingSubSeq(ETHSWT_SECURITY_ACTION_COPY_TO_CPU);
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("AddressLimittingSubSeq() failed with %d action: %u\n", ret, ETHSWT_SECURITY_ACTION_COPY_TO_CPU);
        security_qt_result = ret;
        line = __LINE__;
        goto err;
    }
    ret = AddressLimittingSubSeq(ETHSWT_SECURITY_ACTION_NORMAL);
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("AddressLimittingSubSeq() failed with %d action: %u\n", ret, ETHSWT_SECURITY_ACTION_NORMAL);
        security_qt_result = ret;
        line = __LINE__;
        goto err;
    }

    /* Clear Address Limiting to TestPort4*/
    addressLimitInfo.overLimitAction = ETHSWT_SECURITY_ACTION_DISABLED;
    ret = ETHSWT_SetPortAddrLimiting(0U, TestPort4, &addressLimitInfo);
    if (ret != BCM_ERR_OK) {
         ULOG_ERR("ETHSWT_SetPortAddrLimiting() returned error: %d\n", ret);
         security_qt_result = ret;
         line = __LINE__;
         goto err;
    }
    /* Delete ARL Table */
    ret = DeleteARLTable();
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("DeleteARLTable() failed with %d\n", ret);
        security_qt_result = ret;
        line = __LINE__;
        goto err;
    }
    srcMacAddrIPv4[5] -= 10U;
    for (uint8_t i = 0UL; i < 10UL; i++) {
        /* Set Source MAC Address */
        srcMacAddrIPv4[5] += 1U;
        ret = ETHER_SetMacAddr(0U, srcMacAddrIPv4);
        if (ret != BCM_ERR_OK) {
             ULOG_ERR("ETHER_SetMacAddr() returned error: %d\n", ret);
             security_qt_result = ret;
             line = __LINE__;
             goto err;
        }
        /* Send 1 packets and verify that should be received on TestPort4 */
        ret = SendPacketsAndVerify(&ethCntrlIdx, 1U, ETHER_ETHERTYPE_IP, ipv4_pkt,
                                   sizeof(ipv4_pkt), dstMacAddrIPv4, 1U, TestPort4, ETHSWT_SECURITY_ACTION_DISABLED);
        if (BCM_ERR_OK != ret) {
            ULOG_ERR("SendPacketsAndVerify() failed with %d\n", ret);
            security_qt_result = ret;
            line = __LINE__;
            goto err;
        }
    }
    /* Delete ARL Table */
    ret = DeleteARLTable();
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("DeleteARLTable() failed with %d\n", ret);
        security_qt_result = ret;
        line = __LINE__;
        goto err;
    }

    /* If the total count of dynamically learned unicast MAC
    addresses across all the ports exceeds with the maximum
    programmed total value for all the ports, then
    appropriate action should be triggered. */

    portMACLimit1  = 3U;
    portMACLimit2  = 3U;
    totalMACLimit  = 5U;

    /* Set Address Limiting to TestPort4*/
    addressLimitInfo.overLimitAction = ETHSWT_SECURITY_ACTION_DROP_PKT;
    addressLimitInfo.macLearningLimit = portMACLimit1;
    ret = ETHSWT_SetPortAddrLimiting(0U, TestPort4, &addressLimitInfo);
    if (ret != BCM_ERR_OK) {
         ULOG_ERR("ETHSWT_SetPortAddrLimiting() returned error: %d\n", ret);
         security_qt_result = ret;
         line = __LINE__;
         goto err;
    }

    /* Set Address Limiting accross all the port with limit 3U */
    ret = ETHSWT_SetTotalAddrLimit(0U, totalMACLimit);
    if (ret != BCM_ERR_OK) {
         ULOG_ERR("ETHSWT_DrvSetTotalAddressLimit() returned error: %d\n", ret);
         security_qt_result = ret;
         line = __LINE__;
         goto err;
    }

    srcMacAddrIPv4[5] -= 10U;
    for (uint16_t i = 1UL; i <= portMACLimit1; i++) {
        /* Set Source MAC Address */
        srcMacAddrIPv4[5] += 1U;
        ret = ETHER_SetMacAddr(0U, srcMacAddrIPv4);
        if (ret != BCM_ERR_OK) {
             ULOG_ERR("ETHER_SetMacAddr() returned error: %d\n", ret);
             security_qt_result = ret;
             line = __LINE__;
             goto err;
        }
        /* Send 1 packets and verify that should be received on TestPort4 */
        ret = SendPacketsAndVerify(&ethCntrlIdx, 1U, ETHER_ETHERTYPE_IP, ipv4_pkt,
                                   sizeof(ipv4_pkt), dstMacAddrIPv4, 1U, TestPort4, ETHSWT_SECURITY_ACTION_DROP_PKT);
        if (BCM_ERR_OK != ret) {
            ULOG_ERR("SendPacketsAndVerify() failed with %d\n", ret);
            security_qt_result = ret;
            line = __LINE__;
            goto err;
        }
    }
    /* Clear loopback on Ethernet port TestPort4*/
    ret = ETHSWT_SetPortLoopbackMode(0U, TestPort4, ETHXCVR_BOOLEAN_FALSE);
    if (ret != BCM_ERR_OK) {
         ULOG_ERR("ETHSWT_SetPortLoopbackMode() returned error: %d\n", ret);
         security_qt_result = ret;
         line = __LINE__;
         goto err;
    }

    /* Set loopback on Ethernet port TestPort1*/
    ret = ETHSWT_SetPortLoopbackMode(0U, TestPort1, ETHXCVR_BOOLEAN_TRUE);
    if (ret != BCM_ERR_OK) {
         ULOG_ERR("ETHSWT_SetPortLoopbackMode() returned error: %d\n", ret);
         security_qt_result = ret;
         line = __LINE__;
         goto err;
    }
    Delay(10UL);
    /* Set Address Limiting to TestPort1*/
    addressLimitInfo.overLimitAction = ETHSWT_SECURITY_ACTION_DROP_PKT;
    addressLimitInfo.macLearningLimit = portMACLimit2;
    ret = ETHSWT_SetPortAddrLimiting(0U, TestPort1, &addressLimitInfo);
    if (ret != BCM_ERR_OK) {
         ULOG_ERR("ETHSWT_SetPortAddrLimiting() returned error: %d\n", ret);
         security_qt_result = ret;
         line = __LINE__;
         goto err;
    }
    for (uint16_t i = (portMACLimit1 + 1U); i <= (portMACLimit1 + portMACLimit2); i++) {
        /* Set Source MAC Address */
        srcMacAddrIPv4[5] += 1U;
        ret = ETHER_SetMacAddr(0U, srcMacAddrIPv4);
        if (ret != BCM_ERR_OK) {
             ULOG_ERR("ETHER_SetMacAddr() returned error: %d\n", ret);
             security_qt_result = ret;
             line = __LINE__;
             goto err;
        }
        if (i <= totalMACLimit) {
            /* Send 5 packets and verify that should be received on TestPort1 */
            ret = SendPacketsAndVerify(&ethCntrlIdx, 5U, ETHER_ETHERTYPE_IP, ipv4_pkt,
                                       sizeof(ipv4_pkt), dstMacAddrIPv4, 5U, TestPort1, ETHSWT_SECURITY_ACTION_DROP_PKT);
        } else {
            /* Send 5 packets and verify that should not be received on TestPort1 */
            ret = SendPacketsAndVerify(&ethCntrlIdx, 0U, ETHER_ETHERTYPE_IP, ipv4_pkt,
                                       sizeof(ipv4_pkt), dstMacAddrIPv4, 5U, TestPort1, ETHSWT_SECURITY_ACTION_DROP_PKT);
        }
        if (BCM_ERR_OK != ret) {
            ULOG_ERR("SendPacketsAndVerify() failed with %d\n", ret);
            security_qt_result = ret;
            line = __LINE__;
            goto err;
        }
    }

    ret = ETHSWT_GetTotalAddrLimitAndCounter(0U, &aTotalMACLearningLimit, &aTotalLearnedCounter);
    if (ret != BCM_ERR_OK) {
         ULOG_ERR("ETHSWT_GetTotalAddrLimitAndCounter() returned error: %d\n", ret);
         security_qt_result = ret;
         line = __LINE__;
         goto err;
    }
    if ((aTotalMACLearningLimit != totalMACLimit) ||
         (aTotalLearnedCounter != totalMACLimit)) {
         ULOG_ERR("ETHSWT_GetTotalAddrLimitAndCounter() returned aTotalMACLearningLimit: %u aTotalLearnedCounter: %u\n", aTotalMACLearningLimit, aTotalLearnedCounter);
         security_qt_result = BCM_ERR_UNKNOWN;
         line = __LINE__;
         goto err;
    }

    /* Clear Address Limiting to TestPort1*/
    addressLimitInfo.overLimitAction = ETHSWT_SECURITY_ACTION_DISABLED;
    ret = ETHSWT_SetPortAddrLimiting(0U, TestPort1, &addressLimitInfo);
    if (ret != BCM_ERR_OK) {
         ULOG_ERR("ETHSWT_SetPortAddrLimiting() returned error: %d\n", ret);
         security_qt_result = ret;
         line = __LINE__;
         goto err;
    }

    /* Clear Address Limiting to TestPort4*/
    addressLimitInfo.overLimitAction = ETHSWT_SECURITY_ACTION_DISABLED;
    ret = ETHSWT_SetPortAddrLimiting(0U, TestPort1, &addressLimitInfo);
    if (ret != BCM_ERR_OK) {
         ULOG_ERR("ETHSWT_SetPortAddrLimiting() returned error: %d\n", ret);
         security_qt_result = ret;
         line = __LINE__;
         goto err;
    }

    /* Set Address Limiting accross all the port with default limit(i.e. maximimu ARL table size (4096)) */
    ret = ETHSWT_SetTotalAddrLimit(0U, 4096U);
    if (ret != BCM_ERR_OK) {
         ULOG_ERR("ETHSWT_DrvSetTotalAddressLimit() returned error: %d\n", ret);
         security_qt_result = ret;
         line = __LINE__;
         goto err;
    }

    /* Set Address Limiting to TestPort4*/
    addressLimitInfo.overLimitAction = ETHSWT_SECURITY_ACTION_DROP_PKT;
    addressLimitInfo.macLearningLimit = 5U;
    ret = ETHSWT_SetPortAddrLimiting(0U, TestPort4, &addressLimitInfo);
    if (ret != BCM_ERR_OK) {
         ULOG_ERR("ETHSWT_SetPortAddrLimiting() returned error: %d\n", ret);
         security_qt_result = ret;
         line = __LINE__;
         goto err;
    }
    ret = ETHSWT_GetPortAddrLimitAndCounter(0U, TestPort4, &addressLimitInfo, &aPortLearnedCounter, &aPortOverLimitCounter);
    if (ret != BCM_ERR_OK) {
         ULOG_ERR("ETHSWT_GetPortAddrLimitAndCounter() returned error: %d\n", ret);
         security_qt_result = ret;
         line = __LINE__;
         goto err;
    }
    if ((addressLimitInfo.overLimitAction != ETHSWT_SECURITY_ACTION_DROP_PKT) ||
         (addressLimitInfo.macLearningLimit != 5U)) {
         ULOG_ERR("ETHSWT_GetPortAddrLimitAndCounter() returned action: %u Limit: %u\n", addressLimitInfo.overLimitAction,
         addressLimitInfo.macLearningLimit);
         security_qt_result = BCM_ERR_UNKNOWN;
         line = __LINE__;
         goto err;
    }
err:
    ret = ResetConfig();
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("ResetConfig() failed with %d\n", ret);
        security_qt_result = ret;
        line = __LINE__;
    }
    return;
}

/**
  @defgroup  Qualification Tests
  @ingroup

  @addtogroup
  @{

  @file security_qt.c
  @brief

  @version 0.1 Initial version
*/

/** @brief Security features Test

    This test simulates different ways to breach the security of
    the system like VLAN Hopping, MAC Flooding and MAC Spoofing,
    And check the authenticity of different security measures,
    Which are taken to prevent these well known attcks.

@endcode
*/
TASK(SecurityTest)
{
    switch (activeTaskIndex) {
        case 1UL:
                SMDetectSeq1();
            break;
        case 2UL:
                StickyMACSeq2();
            break;
        case 3UL:
                VLANHoppingDetectSeq3();
            break;
        default:
                AddressLimittingSeq4();
            break;
    }

    if (BCM_AT_EXECUTING == security_qt_result) {
        security_qt_result = BCM_ERR_OK;
    } else {
        ULOG_ERR("\n Error at line no: %lu", line);
        line = 0xFFFFFFFFUL;
    }
    ULOG_ERR("\n Test completed");
    BCM_TerminateTask();
}
/** @} */

int32_t BCM_ExecuteAT(uint32_t aIndex)
{
    int32_t ret = BCM_AT_NOT_AVAILABLE;

    if (aIndex <= 4UL) {
        security_qt_result = BCM_AT_EXECUTING;
        activeTaskIndex = aIndex;
        BCM_ActivateTask(SecurityTest);
        ret = BCM_ERR_OK;
    }

    return ret;
}

int32_t BCM_GetResultAT(uint32_t aIndex)
{
    int32_t ret = BCM_AT_NOT_AVAILABLE;

    if (activeTaskIndex == aIndex) {
        ret = security_qt_result;
    }
    return ret;
}

void APP_Init()
{
}

#ifndef ENABLE_INET
void INET_RxIPv4Pkt(NIF_CntrlIDType aCtrlIdx,
                    const uint8_t *const aBuf,
                    uint16_t aLen,
                    const uint8_t *const aSrcMacAddr,
                    const uint8_t *const aDestMacAddr,
                    uint32_t aPriority)
{
}

void INET_TxPktConfirmation(NIF_CntrlIDType aCtrlIdx,
                             uint32_t aBufIdx)
{

}

void INET_RxARPPkt(NIF_CntrlIDType aCtrlIdx,
                   const uint8_t *const aBuf,
                   uint16_t aLen,
                   const uint8_t *const aSrcMacAddr,
                   const uint8_t *const aDestMacAddr,
                   uint32_t aPriority)
{

}
#endif
