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
  @defgroup grp_inet_qt Qualification Tests
  @ingroup grp_inet

  @addtogroup grp_inet_qt
  @{

  @file tcp_test.c
  @brief TCP test
  This source file contains the tests for TCP operation
  @version 0.1 Initial version
*/

#include <ee.h>
#include <bcm_test.h>
#include <ulog.h>
#include <bcm_err.h>
#include <bcm_utils.h>
#include <bcm_osil.h>
#include "inet_cfg.h"
#include "inet_osil.h"
#include <eth_osil.h>
#include <module_helper.h>
#include <time_module_osil.h>

#define GetModuleLogLevel()  ULOG_LVL_ERROR

static volatile int32_t TCPTEST_Result = BCM_AT_NOT_STARTED;

#define TCPTEST_PRINT_IP_ADDRESS(X) (X >> 24U) & 0xFFU, (X >> 16U) & 0xFFU,\
                                 (X >> 8U) & 0xFFU, (X & 0xFFU)
#define TCPTEST_SERVER_PORT 5000

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

TASK(ETHERNET_Task)
{
    int32_t                  ret;
    BCM_EventMaskType mask = 0UL;

    /* Initialize Ethernet driver */
    ETHER_Init(ETHER_HW_ID_0, &EthIT1_Config);

    /* Set controller mode to Active */
    ret = EthIT_SetModeActive();
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("EthIT_SetModeActive() failed with %d\n", ret);
        TCPTEST_Result = ret;
        goto err;
    }

    ret = NIF_Init();
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("NIF_Init() failed with %d\n", ret);
        TCPTEST_Result = ret;
        goto err;
    }
    INET_Init();

    /* Enable Ethernet Controller loopback */
    ETHER_EnableLoopBack(ETHER_HW_ID_0);

    while (TRUE) {
        (void)BCM_WaitEvent(SystemEvent0|SystemEvent3|SystemEvent16);
        (void)BCM_GetEvent(ETHERNET_Task, &mask);
        (void)BCM_ClearEvent(mask);
        if (0 != (mask & SystemEvent0)) {
             ETHER_ProcessPkts(0UL);
        }
        if (0 != (mask & SystemEvent3)) {
            INET_ProcessTimers();
        }
        if (0 != (mask & SystemEvent16)) {
            INET_TCPProcessCtrlMsgs();
        }

    }

err:
    ULOG_ERR("\nTest Failed");
    if (BCM_AT_EXECUTING == TCPTEST_Result) {
        TCPTEST_Result = BCM_ERR_OK;
    }
    (void)BCM_TerminateTask();
}

TASK(TCPTestServerTask)
{
    int32_t                  ret;
    BCM_EventMaskType        mask = 0UL;
    INET_IPAddressType       ipAddr = INET_IPADDRESS_INVALID;
    INET_PortType            port = INET_PORT_INVALID;
    uint32_t                 endPts[] = {INET_PAYLOAD_ID0, INET_PAYLOAD_ID1};
    uint32_t                 *endPtsPtr = endPts;
    uint32_t                 payloadId;
    INET_TCPStateType        state;

    ret = INET_Bind(BCM_NET_ID, INET_PAYLOAD_ID0, TCPTEST_SERVER_PORT);
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("Server:INET_Bind() failed with %d\n", ret);
        TCPTEST_Result = ret;
        goto err;
    }

    ret = TCP_Listen(BCM_NET_ID, INET_PAYLOAD_ID0, 1UL);

    while (BCM_ERR_OK == ret) {
        (void)BCM_WaitEvent(SystemEvent0|SystemEvent2);
        (void)BCM_GetEvent(TCPTestServerTask, &mask);
        (void)BCM_ClearEvent(mask);

        if (0 != (mask & SystemEvent0)) {
            /* Process the incoming connection request */
            ret = TCP_GetConnReq(BCM_NET_ID, INET_PAYLOAD_ID0, &ipAddr, &port);
            if (BCM_ERR_OK == ret) {
                ULOG_ERR("Server: Received connection request from %u.%u.%u.%u:%u\n",
                        TCPTEST_PRINT_IP_ADDRESS(ipAddr), port);
                ret = TCP_GetFreeEndPt(BCM_NET_ID, &endPtsPtr, sizeof(endPts)/sizeof(endPts[0]), &payloadId);
                if (BCM_ERR_OK == ret) {
                    ret = TCP_Accept(BCM_NET_ID, INET_PAYLOAD_ID0, payloadId, ipAddr, port);
                }
            }
        }

        if (0 != (mask & SystemEvent2)) {
            state = INET_TCPGetState(BCM_NET_ID, payloadId);
            if (INET_TCPSTATE_ESTABLISHED == state) {
                ULOG_ERR("Server: Connection Established\n");
                (void)BCM_SetEvent(TCPTestClientTask, SystemEvent2);
            } else if (INET_TCPSTATE_CLOSE_WAIT == state) {
                ULOG_ERR("Server: Remote end initiated close\n");
                ret = TCP_Close(BCM_NET_ID, payloadId);
            } else if (INET_TCPSTATE_CLOSED == state) {
                ULOG_ERR("Server: Connection closed\n");
                break;
            }
        }
    };

    if (BCM_ERR_OK != ret) {
        TCPTEST_Result = ret;
    }

err:
    ULOG_ERR("\nTest completed");
    if (BCM_AT_EXECUTING == TCPTEST_Result) {
        TCPTEST_Result = BCM_ERR_OK;
    }
    (void)BCM_TerminateTask();
}

TASK(TCPTestClientTask)
{
    int32_t                  ret;
    INET_IPAddressType       serverIPAddr = INET_CONVERT_IP_ADDRESS(192U, 168U, 10U, 1U);
    INET_TCPStateType        tcpState;

    /* Allocate ephemeral port for the client */
    ret = INET_Bind(BCM_NET_ID, INET_PAYLOAD_ID2, INET_PORT_INVALID);
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("Client: INET_Bind() failed with %d\n", ret);
        TCPTEST_Result = ret;
        goto err;
    }

    /* Retry connecting */
    do {
        if (BCM_ERR_OK != ret) {
            (void)BCM_WaitEvent(SystemEvent1);
            (void)BCM_ClearEvent(SystemEvent1);
        }
        ret = TCP_Connect(BCM_NET_ID, INET_PAYLOAD_ID2, serverIPAddr, TCPTEST_SERVER_PORT);
    } while (BCM_ERR_EAGAIN == ret);

    /* Wait for the connection to go through */
    (void)BCM_WaitEvent(SystemEvent0);
    (void)BCM_ClearEvent(SystemEvent0);

    tcpState = INET_TCPGetState(BCM_NET_ID, INET_PAYLOAD_ID2);
    if (tcpState == INET_TCPSTATE_ESTABLISHED) {
      ULOG_ERR("Client: Connection Established to server %u.%u.%u.%u:%u\n",
            TCPTEST_PRINT_IP_ADDRESS(serverIPAddr), TCPTEST_SERVER_PORT);
    }

    (void)BCM_WaitEvent(SystemEvent2);
    (void)BCM_ClearEvent(SystemEvent2);

    ULOG_ERR("Client: Closing the connection \n");

    ret = TCP_Close(BCM_NET_ID, INET_PAYLOAD_ID2);

    while ((ret == BCM_ERR_OK) && (tcpState != INET_TCPSTATE_CLOSED)) {
        (void)BCM_WaitEvent(SystemEvent0);
        (void)BCM_ClearEvent(SystemEvent0);
        tcpState = INET_TCPGetState(BCM_NET_ID, INET_PAYLOAD_ID2);
    }

    ULOG_ERR("Client: Connection closed\n");

err:
    if (BCM_ERR_OK != ret) {
        TCPTEST_Result = ret;
    }
    (void)BCM_TerminateTask();
}

int32_t BCM_ExecuteAT(uint32_t aIndex)
{
    int32_t ret = BCM_AT_NOT_AVAILABLE;
    if (1UL == aIndex) {
        if (TCPTEST_Result != BCM_AT_EXECUTING) {
            TCPTEST_Result = BCM_AT_EXECUTING;
            (void)BCM_ActivateTask(ETHERNET_Task);
            (void)BCM_ActivateTask(TCPTestServerTask);
            (void)BCM_ActivateTask(TCPTestClientTask);
            ret = BCM_ERR_OK;
        }
    }
    return ret;
}

int32_t BCM_GetResultAT(uint32_t aIndex)
{
    int32_t ret;
    switch (aIndex)
    {
        case 1UL:
            ret = TCPTEST_Result;
            break;
        default:
            ret = BCM_AT_NOT_AVAILABLE;
            break;
    }
    return ret;
}
