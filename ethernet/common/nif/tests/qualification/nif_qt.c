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

/** @brief Qualification test for NIF
 */

#include <bcm_utils.h>
#include <bcm_err.h>
#include <nif.h>
#include <osil/eth_osil.h>
#include <nif_switch.h>
#include <bcm_test.h>
#include <ulog.h>
#include "ee.h"
#include <nif_internal.h>

#ifdef ENABLE_NIF_IT
int32_t NIF_ExecuteIt(uint32_t aTestIdx);
int32_t NIF_GetStatusIt(uint32_t aTestIdx);
#endif

#define NIF_TX_IT1            (1UL)
#define NIF_TX_IT2            (2UL)
#define ETHER_HW_ID           (0UL)
#define ETHIT1_WAIT_FOR_EVENTS (ETHER_PKT_EVENT)
#define GetModuleLogLevel()         (ULOG_LVL_ERROR)
#define MARK_ERR(ret, line) {ULOG_ERR("\nError: %ld, \tline %d", ret, line); NIF_QtStatus = ret;}

const uint32_t TestPort1 = 1UL;
static uint32_t NIF_TxCbCnt = 0UL;
static uint32_t NIF_RxCbCnt = 0UL;
static uint32_t NIF_TxPktCnt = 0UL;
static uint32_t NIF_CurrentTest;

static const uint8_t EthIT1_MacAddr[6] = {0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF};
static uint32_t NIF_PatCompOffset = 0UL;

static const ETHER_CfgType EthIT1_Config = {
    .hwID = 0UL,
    .speed = ETHER_SPEED_100MBPS,
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
};

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
static const ETHER_VLANIDType vlanID = 1024U;
NIF_CntrlIDType ethCntrlIdx = ~(0x0ULL);

static volatile int32_t NIF_QtStatus = BCM_AT_NOT_STARTED;

/* Helper function to set Ethernet controller to Active */
int32_t EthIT_SetModeActive(void)
{
    int32_t retVal;
    ETHER_ModeType mode;

    retVal = ETHER_SetMode(ETHER_HW_ID, ETHER_MODE_ACTIVE);
    if (BCM_ERR_OK == retVal) {
        retVal = ETHER_GetMode(ETHER_HW_ID, &mode);
        if (BCM_ERR_OK == retVal) {
            if (ETHER_MODE_ACTIVE != mode) {
                retVal = BCM_ERR_INVAL_STATE;
            }
        }
    }

    if (BCM_ERR_OK != retVal) {
        MARK_ERR(retVal, __LINE__);
    }

    return retVal;
}

void EthIT1_WaitEvent(void)
{
    uint32_t waitMask = ETHIT1_WAIT_FOR_EVENTS;
    uint32_t mask = 0UL;

    do {
        BCM_WaitEvent(waitMask);
        BCM_GetEvent(NIFTEST_Task, &mask);
        BCM_ClearEvent(mask);

        if (ETHER_PKT_EVENT == (mask & ETHER_PKT_EVENT)) {
            /* Process Ethernet */
            while (NIF_RxCbCnt != NIF_TxPktCnt) {
                ETHER_ProcessPkts(0UL);
            }
            break;
        }
    } while (1);

    return;
}

int32_t SendPacketsAndVerify(const NIF_CntrlIDType* const ethCntrlIdx,
                                 ETHER_EtherType ethertype,
                                 const uint8_t *const aPacket, uint32_t aLength,
                                 const uint8_t *dstMacAddr, uint32_t numToSend,
                                 uint32_t aTestPort)
{
    uint32_t              i            = 0UL;
    uint8_t               *pdu         = NULL;
    uint32_t              bufIdx       = 0xFFUL;
    uint32_t              length;
    int32_t               retVal = BCM_ERR_OK;
#if defined(ENABLE_ETH_SWITCH)
    ETHSWT_MgmtInfoType mgmtInfo;
#endif


    for (i = 0UL; i < numToSend; ++i) {
        length = aLength + 1UL;
        retVal = NIF_GetTxBuffer(*ethCntrlIdx, ethertype, 6U, &bufIdx, &pdu, &length);
        if (BCM_ERR_OK != retVal) {
            MARK_ERR(retVal, __LINE__);
            goto err;
        }

        BCM_MemCpy(pdu, aPacket, aLength);
        pdu[length - 1UL] = (uint8_t)NIF_TxPktCnt;

#if defined(ENABLE_ETH_SWITCH)
        mgmtInfo.switchIdx = 0UL;
        mgmtInfo.portIdx   = aTestPort;
        mgmtInfo.tc        = ETHSWT_TC_4;

        retVal = NIF_SwtSetMgmtInfo(*ethCntrlIdx, bufIdx, &mgmtInfo);
        if (BCM_ERR_OK != retVal) {
            MARK_ERR(retVal, __LINE__);
            goto err;
        }
#endif
        retVal = NIF_Send(*ethCntrlIdx, ethertype, 1UL, bufIdx, length, dstMacAddr);
        if (BCM_ERR_OK != retVal) {
            MARK_ERR(retVal, __LINE__);
            goto err;
        } else {
            NIF_TxPktCnt++;
        }
        EthIT1_WaitEvent();
    }

err:
    return retVal;
}


int32_t NIF_ExecuteQt(uint32_t aTestIdx)
{
    int32_t retVal = BCM_ERR_OK;
    ETHER_VLANIDType vlanIDGet;
    uint8_t macAddr[ETHER_MAC_ADDR_SIZE] = {0U};

#if defined(ENABLE_ETH_SWITCH)
    ETHSWT_Init(ETHER_HW_ID);
    /* Create vlan 1024U */
    retVal = ETHSWT_AddVLANPorts(0U, 0x00FF , vlanID, 0x00FF);
    if (retVal != BCM_ERR_OK) {
         MARK_ERR(retVal, __LINE__);
         goto err;
    }
#endif
    /* Initialize Ethernet driver */
    ETHER_Init(ETHER_HW_ID, &EthIT1_Config);

    /* Set controller mode to Active */
    retVal = EthIT_SetModeActive();
    if (BCM_ERR_OK != retVal) {
        MARK_ERR(retVal, __LINE__);
        goto err;
    }

    retVal = NIF_Init();
    if (BCM_ERR_OK != retVal) {
        MARK_ERR(retVal, __LINE__);
        goto err;
    }
    retVal = NIF_GetCtrlIdx(vlanID, BCM_NET_ID, 0U, &ethCntrlIdx);
    if (BCM_ERR_OK != retVal) {
        MARK_ERR(retVal, __LINE__);
        goto err;
    }
    retVal = NIF_GetVlanID(ethCntrlIdx, &vlanIDGet);
    if (BCM_ERR_OK != retVal) {
        MARK_ERR(retVal, __LINE__);
        goto err;
    }
    if (vlanIDGet != vlanID) {
        retVal = BCM_ERR_UNKNOWN;
        MARK_ERR(retVal, __LINE__);
        goto err;
    }
    retVal = NIF_GetMacAddr(ethCntrlIdx, macAddr);
    if (BCM_ERR_OK != retVal) {
        MARK_ERR(retVal, __LINE__);
        goto err;
    }
    retVal =  memcmp(macAddr, &EthIT1_MacAddr, ETHER_MAC_ADDR_SIZE);
    if (0UL != retVal) {
        retVal = BCM_ERR_UNKNOWN;
        MARK_ERR(retVal, __LINE__);
        goto err;
    }
    /* Enable Ethernet Loopback */
    ETHER_EnableLoopBack(ETHER_HW_ID_0);

    /* Transmit VLAN-tagged (CTag, vlanID 1024U) IPv4 packets and confirm that the IPv4 packets is received */
    retVal = SendPacketsAndVerify(&ethCntrlIdx, ETHER_ETHERTYPE_IP, ipv4_pkt, sizeof(ipv4_pkt), dstMacAddrIPv4, 100U, TestPort1);
    if (BCM_ERR_OK != retVal) {
        MARK_ERR(retVal, __LINE__);
        goto err;
    } else {
        NIF_QtStatus = BCM_ERR_OK;
    }

err:
	return retVal;
}

TASK(NIFTEST_Task)
{
	if (NIF_TX_IT1 == NIF_CurrentTest){
		(void)NIF_ExecuteQt(NIF_CurrentTest);
#ifdef ENABLE_NIF_IT
	} else {
		(void)NIF_ExecuteIt(NIF_TX_IT2);
#endif
	}

    (void)BCM_TerminateTask();
}

int32_t NIFIT1_GetResult(void)
{
    return NIF_QtStatus;
}

int32_t BCM_ExecuteAT(uint32_t aIndex)
{
    int32_t ret;
    StatusType retOS = E_OK;
    TaskStateType taskState = SUSPENDED;

    switch(aIndex)
    {
    case NIF_TX_IT1:
	case NIF_TX_IT2:
        retOS = GetTaskState(NIFTEST_Task, &taskState);
        if (E_OK == retOS) {
            if (SUSPENDED == taskState) {
				NIF_CurrentTest = aIndex;
                if (BCM_AT_EXECUTING != NIF_QtStatus) {
                    NIF_QtStatus = BCM_AT_EXECUTING;
                    ret = BCM_ActivateTask(NIFTEST_Task);
                    if (BCM_ERR_OK != ret) {
                        NIF_QtStatus = BCM_AT_NOT_STARTED;
                        ULOG_ERR("Task activation failed, error: %d\n",
                                ret);
                    }
                }
                ret = BCM_ERR_OK;
            } else {
                NIF_QtStatus = BCM_AT_EXECUTING;
                ULOG_ERR("Test is already running\n");
                ret = BCM_ERR_OK;
            }
        } else {
            ULOG_ERR("Get Task state failed, error: %d\n",BCM_ERR_UNKNOWN);
            ret = BCM_ERR_UNKNOWN;
        }
        break;
    default:
        ret = BCM_AT_NOT_AVAILABLE;
    }

    return ret;
}

int32_t BCM_GetResultAT(uint32_t aIndex)
{
    int32_t ret;

    switch(aIndex)
    {
    case NIF_TX_IT1:
        ret = NIFIT1_GetResult();
        break;
#ifdef ENABLE_NIF_IT
    case NIF_TX_IT2:
        ret = NIF_GetStatusIt(aIndex);
        break;
#endif
    default:
        ret = BCM_AT_NOT_AVAILABLE;
    }

    return ret;
}

void INET_RxIPv4Pkt(NIF_CntrlIDType aCtrlIdx,
                    const uint8_t *const aBuf,
                    uint16_t aLen,
                    const uint8_t *const aSrcMacAddr,
                    const uint8_t *const aDestMacAddr,
                    uint32_t aPriority)
{
    int32_t retVal;
    uint32_t pktNum;
    /* Compare source address */
    retVal =  memcmp(aSrcMacAddr, &EthIT1_MacAddr, ETHER_MAC_ADDR_SIZE);
    if (0UL != retVal) {
        retVal = BCM_ERR_DATA_INTEG;
        MARK_ERR(retVal, __LINE__);
    }

    /* Compare destination address */
    retVal =  memcmp(aDestMacAddr, dstMacAddrIPv4, ETHER_MAC_ADDR_SIZE);
    if (0UL != retVal) {
        retVal = BCM_ERR_DATA_INTEG;
        MARK_ERR(retVal, __LINE__);
    }

    /* Compare VLAN in the Rx buffer */
    if (NIF_Comp.rxBufInfo.vlanID != vlanID) {
        retVal = BCM_ERR_DATA_INTEG;
        MARK_ERR(retVal, __LINE__);
    }

    retVal = memcmp((void *)aBuf, &ipv4_pkt[NIF_PatCompOffset],
            aLen - NIF_PatCompOffset - 1UL);
    if (0 == retVal) {
        pktNum = aBuf[aLen - 1UL];
        if (pktNum == (NIF_RxCbCnt & 0xFF) ) {
            NIF_RxCbCnt++;
        } else {
            retVal = BCM_ERR_DATA_INTEG;
            ULOG_ERR("pktNum:0x%x, NIF_RxCbCnt:0x%x", pktNum, NIF_RxCbCnt);
            MARK_ERR(retVal, __LINE__);
        }
    } else {
        retVal = BCM_ERR_DATA_INTEG;
        MARK_ERR(retVal, __LINE__);
    }
}

void INET_TxPktConfirmation(NIF_CntrlIDType aCtrlIdx,
                             uint32_t aBufIdx)
{
    NIF_TxCbCnt++;
}

void INET_RxARPPkt(NIF_CntrlIDType aCtrlIdx,
                   const uint8_t *const aBuf,
                   uint16_t aLen,
                   const uint8_t *const aSrcMacAddr,
                   const uint8_t *const aDestMacAddr,
                   uint32_t aPriority)
{

}

/*VCAST_DONT_INSTRUMENT_END*/
