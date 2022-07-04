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
  @defgroup grp_inet_qt Qualification Tests
  @ingroup grp_inet

  @addtogroup grp_inet_qt
  @{

  @file code.c
  @brief INET Library Integration Test
  This source file contains the qualification tests for INET library
  @version 0.86 Import from MS Word document
*/

#include <ee.h>
#include <bcm_test.h>
#include <ulog.h>
#include <bcm_err.h>
#include <bcm_time.h>
#include <bcm_osil.h>
#include <shell.h>
#include <cortex.h>
#include "inet_cfg.h"
#include "inet_osil.h"
#include "dhcp.h"
#include "dhcp_osil.h"
#include <eth_osil.h>
#include <module_helper.h>
#include <time_module_osil.h>

#define GetModuleLogLevel()  ULOG_LVL_ERROR

#define DHCP_1S     (320L)
#define DHCP_100MS  (32L)
#define DHCP_PRINT_IP_ADDRESS(X) (X >> 24U) & 0xFFU, (X >> 16U) & 0xFFU,\
                                 (X >> 8U) & 0xFFU, (X & 0xFFU)

static volatile int32_t dhcp_qt_result = BCM_AT_NOT_STARTED;

static INET_IPAddressType myIP = INET_IPADDRESS_INVALID;

static INET_InterfaceVlanTagConfigType vlanCfg = { .pcp = 0, .vlan = 0 };

static uint32_t renewalTime = 0UL;

static DHCP_ConfigType config = {
    .compID = BCM_NET_ID,
    .payloadID = INET_PAYLOAD_ID0,
    .leaseTime = DHCP_INFINITY_TIME,
    .maxRetries = 3U,
    .selectTimeout = 2000UL,
    .initialDelaySeed = 0UL,
    .initialRetryPeriod = 1000UL,
    .maxRetryPeriod = 8000UL,
    .clientIdLen = 0U,
    .vendorIdLen = 0U,
    .clientId = {0U},
    .hintFile = {0U},
    .vendorId = {0U},
};

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

void DHCPTest_Timeout_Callback(void)
{
    (void)SetEvent(DHCPTestTask, SystemEvent4);
}

void DHCP_OfferReceivedCallback(uint32_t aOfferNum)
{
    (void)DHCP_SelectOffer(aOfferNum);
}

void DHCP_BoundCallback(void)
{
    int32_t                  ret;
    INET_IPAddressType       defaultRoute = INET_IPADDRESS_INVALID;
    INET_IPAddressType       netmask      = INET_IPADDRESS_INVALID;
    INET_IPAddressType       tftpServer   = INET_IPADDRESS_INVALID;
    uint8_t                  bootFile[DHCP_MAX_FILENAME_LEN+1U];
    uint32_t                 len;

    len = sizeof(myIP);
    ret = DHCP_GetParameter(0U, DHCP_PARAM_IPADDR, (uint8_t*)&myIP, &len);
    if ((BCM_ERR_OK != ret) || (len != sizeof(myIP)) || (INET_IPADDRESS_INVALID == myIP)) {
        ULOG_ERR("DHCP_GetParameter() for host IP failed with %d\n", ret);
        dhcp_qt_result = ret;
        goto err;
    }

    len = sizeof(defaultRoute);
    ret = DHCP_GetParameter(0U, DHCP_PARAM_ROUTER, (uint8_t*)&defaultRoute, &len);
    if ((BCM_ERR_OK != ret) || (len != sizeof(defaultRoute)) || (INET_IPADDRESS_INVALID == defaultRoute)) {
        ULOG_ERR("DHCP_GetParameter() for router IP failed with %d\n", ret);
        dhcp_qt_result = ret;
        goto err;
    }

    len = sizeof(netmask);
    ret = DHCP_GetParameter(0U, DHCP_PARAM_SUBNET_MASK, (uint8_t*)&netmask, &len);
    if ((BCM_ERR_OK != ret) || (len != sizeof(netmask)) || (INET_IPADDRESS_INVALID == netmask)) {
        ULOG_ERR("DHCP_GetParameter() for subnet mask failed with %d\n", ret);
        dhcp_qt_result = ret;
        goto err;
    }

    len = sizeof(tftpServer);
    ret = DHCP_GetParameter(0U, DHCP_PARAM_TFTP_SERVER_ADDR, (uint8_t*)&tftpServer, &len);
    if ((BCM_ERR_OK != ret) || (len != sizeof(tftpServer)) || (INET_IPADDRESS_INVALID == tftpServer)) {
        ULOG_ERR("DHCP_GetParameter() for TFTP server IP failed with %d\n", ret);
        dhcp_qt_result = ret;
        goto err;
    }

    len = sizeof(bootFile);
    ret = DHCP_GetParameter(0U, DHCP_PARAM_BOOT_FILE_NAME, bootFile, &len);
    if ((BCM_ERR_OK != ret) || (len == 0UL)) {
        ULOG_ERR("DHCP_GetParameter() for boot file name failed with %d\n", ret);
        dhcp_qt_result = ret;
        goto err;
    }

    len = sizeof(renewalTime);
    ret = DHCP_GetParameter(0U, DHCP_PARAM_RENEWAL_TIME, (uint8_t*)&renewalTime, &len);
    if ((BCM_ERR_OK != ret) || (len != sizeof(renewalTime)) || (0UL == renewalTime)) {
        ULOG_ERR("DHCP_GetParameter() for lease time failed with %d\n", ret);
        dhcp_qt_result = ret;
        goto err;
    }

    ULOG_ERR("\nIP Address : %u:%u:%u:%u\nRouter     : %u:%u:%u:%u\nNetmask    : %u:%u:%u:%u\n",
             DHCP_PRINT_IP_ADDRESS(myIP),
             DHCP_PRINT_IP_ADDRESS(defaultRoute),
             DHCP_PRINT_IP_ADDRESS(netmask));
    ULOG_ERR("\nTFTP Server: %u:%u:%u:%u\nBootFile   : %s\n",
             DHCP_PRINT_IP_ADDRESS(tftpServer),
             bootFile);

    /* Update the interface */
    ret = INET_UpdateInterface(INET_INTERFACEID_0, INET_IPADDRESSASSIGNMENT_DYNAMIC,
                               myIP, (32U - (uint8_t)CORTEX_Clz(CORTEX_BitReverse(netmask))),
                               defaultRoute, &vlanCfg);
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("INET_UpdateInterface() line %u failed with %d\n", __LINE__, ret);
        dhcp_qt_result = ret;
        goto err;
    }

err:
    (void)BCM_SetEvent(DHCPTestTask, SystemEvent1);
}

void DHCP_UnBoundCallback(void)
{
}

TASK(DHCPTestTask)
{
    int32_t                  ret;
    BCM_EventMaskType        mask = 0UL;
    uint8_t                  macAddr[6U];
    INET_ARPEntryStateType   arpEntryState;
    uint32_t                 index = 0UL;

    /* Initialize Ethernet driver */
    ETHER_Init(ETHER_HW_ID_0, &EthIT1_Config);

    /* Set controller mode to Active */
    ret = EthIT_SetModeActive();
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("EthIT_SetModeActive() failed with %d\n", ret);
        dhcp_qt_result = ret;
        goto err;
    }

    ret = NIF_Init();
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("NIF_Init() failed with %d\n", ret);
        dhcp_qt_result = ret;
        goto err;
    }
    INET_Init();

    ret = DHCP_Init(&config);
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("DHCP_Init() failed with %d\n", ret);
        dhcp_qt_result = ret;
        goto err;
    }

    (void)BCM_SetRelAlarm(DHCPTest_Timeout_Alarm, 5L * DHCP_1S, 0L);

    while (BCM_ERR_OK == ret) {
        /* Wait for either Bound callback or timer to expire */
        (void)BCM_WaitEvent(SystemEvent0|SystemEvent1|SystemEvent3|SystemEvent4|UDP_TxEvent|UDP_RxEvent);
        (void)BCM_GetEvent(DHCPTestTask, &mask);
        (void)BCM_ClearEvent(mask);
        if (SystemEvent0 == (mask & SystemEvent0)) {
            (void)BCM_ClearEvent(ETHER_PKT_EVENT);
             ETHER_ProcessPkts(0UL);
        }
        if (SystemEvent3 == (mask & SystemEvent3)) {
            INET_ProcessTimers();
            DHCP_HandleTimerEvent();
        }
        if (UDP_RxEvent == (mask & UDP_RxEvent)) {
            /* Process the received DHCP packet */
            DHCP_HandleRxEvent();
        }
        if (UDP_TxEvent == (mask & UDP_TxEvent)) {
            /* Process the buffer available callback/ARP probe */
            DHCP_HandleTxEvent();
        }
        if (SystemEvent1 == (mask & SystemEvent1)) {
            ULOG_ERR("Received bound callback\n");
            break;
        }
        if (SystemEvent4 == (mask & SystemEvent4)) {
            ULOG_ERR("Timed out waiting for Bound callback\n");
            dhcp_qt_result = ret = BCM_ERR_TIME_OUT;
            break;
        }
    };

    (void)BCM_CancelAlarm(DHCPTest_Timeout_Alarm);

    if (ret != BCM_ERR_OK) {
        (void)DHCP_DeInit();
        goto err;
    }

    /* Send a gratuitous ARP to inform the world that we own this IP address now */
    (void)INET_ARPSendRequest(0UL, myIP, 0UL, FALSE);

    /* Wait for 100ms for a response to the gratuitous ARP to be received */
    (void)BCM_SetRelAlarm(DHCPTest_Timeout_Alarm, DHCP_100MS, 0L);

    while (1UL == TRUE) {
        /* Wait for timer to expire */
        (void)BCM_WaitEvent(SystemEvent0|SystemEvent3|SystemEvent4|UDP_TxEvent|UDP_RxEvent);
        (void)BCM_GetEvent(DHCPTestTask, &mask);
        (void)BCM_ClearEvent(mask);
        if (SystemEvent0 == (mask & SystemEvent0)) {
            (void)BCM_ClearEvent(ETHER_PKT_EVENT);
             ETHER_ProcessPkts(0UL);
        }
        if (SystemEvent3 == (mask & SystemEvent3)) {
            INET_ProcessTimers();
            DHCP_HandleTimerEvent();
        }
        if (UDP_RxEvent == (mask & UDP_RxEvent)) {
            /* Process the received DHCP packet */
            DHCP_HandleRxEvent();
        }
        if (UDP_TxEvent == (mask & UDP_TxEvent)) {
            /* Process the buffer available callback/ARP probe */
            DHCP_HandleTxEvent();
        }
        if (SystemEvent4 == (mask & SystemEvent4)) {
            break;
        }
    };

    /* Remove the entry*/
    ret = INET_FindARPEntry(0UL, myIP, macAddr, &arpEntryState, &index);
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("INET_FindARPEntry() failed with %d\n", ret);
        dhcp_qt_result = ret;
        goto err;
    }

    if (arpEntryState != INET_ARPENTRYSTATE_WAIT) {
        ULOG_ERR("arpEntryState not in WAIT state \n");
        dhcp_qt_result = BCM_ERR_UNKNOWN;
        goto err;
    }

    ret = INET_RemoveARPEntry(0UL, myIP);
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("INET_RemoveARPEntry() failed with %d\n", ret);
        dhcp_qt_result = ret;
        goto err;
    }

#ifdef DHCP_TEST_RENEWAL
    /* Wait for renewal to occur */
    (void)BCM_SetRelAlarm(DHCPTest_Timeout_Alarm, (int32_t)renewalTime * DHCP_1S, 0L);

    while (1UL == TRUE) {
        /* Wait for timer to expire */
        (void)BCM_WaitEvent(SystemEvent0|SystemEvent3|SystemEvent4|UDP_TxEvent|UDP_RxEvent);
        (void)BCM_GetEvent(DHCPTestTask, &mask);
        (void)BCM_ClearEvent(mask);
        if (SystemEvent0 == (mask & SystemEvent0)) {
            (void)BCM_ClearEvent(ETHER_PKT_EVENT);
             ETHER_ProcessPkts(0UL);
        }
        if (SystemEvent3 == (mask & SystemEvent3)) {
            INET_ProcessTimers();
            DHCP_HandleTimerEvent();
        }
        if (UDP_RxEvent == (mask & UDP_RxEvent)) {
            /* Process the received DHCP packet */
            DHCP_HandleRxEvent();
        }
        if (UDP_TxEvent == (mask & UDP_TxEvent)) {
            /* Process the buffer available callback/ARP probe */
            DHCP_HandleTxEvent();
        }
        if (SystemEvent4 == (mask & SystemEvent4)) {
            break;
        }
    };
#endif
    ret = DHCP_DeInit();
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("DHCP_DeInit() failed with %d\n", ret);
        dhcp_qt_result = ret;
        goto err;
    }

    /* Release the IP address */
    ret = INET_UpdateInterface(INET_INTERFACEID_0, INET_IPADDRESSASSIGNMENT_DYNAMIC,
                               INET_IPADDRESS_INVALID, 0U,
                               INET_IPADDRESS_INVALID, &vlanCfg);
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("INET_UpdateInterface() line %u failed with %d\n", __LINE__, ret);
        dhcp_qt_result = ret;
        goto err;
    }

err:
    ULOG_ERR("\nTest completed");
    if (BCM_AT_EXECUTING == dhcp_qt_result) {
        dhcp_qt_result = BCM_ERR_OK;
    }
    (void)BCM_TerminateTask();
}

int32_t BCM_ExecuteAT(uint32_t aIndex)
{
    int32_t ret = BCM_AT_NOT_AVAILABLE;
    if (1UL == aIndex) {
        if (dhcp_qt_result != BCM_AT_EXECUTING) {
            dhcp_qt_result = BCM_AT_EXECUTING;
            (void)BCM_ActivateTask(DHCPTestTask);
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
            ret = dhcp_qt_result;
            break;
        default:
            ret = BCM_AT_NOT_AVAILABLE;
            break;
    }
    return ret;
}

