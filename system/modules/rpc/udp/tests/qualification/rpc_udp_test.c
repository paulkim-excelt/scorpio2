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
#include <shell.h>
#include <bcm_err.h>
#include <bcm_test.h>
#include <bcm_comp.h>
#include <bcm_utils.h>
#include <ee.h>
#include <ulog.h>
#include <rpc_mem.h>
#include <rpc_interface.h>
#include <rpc_mem_osil.h>
#include <eth_osil.h>
#include <module_helper.h>
#include <time_module_osil.h>
#include <inet_cfg.h>
#include <inet_osil.h>
#include <rpc_udp_platform.h>

#define GetModuleLogLevel()         (ULOG_LVL_INFO)

/** Qualification Test Number Enumeration */
#define RPC_TEST1        (0x0001UL)         /**< Command-response test sequence */
#define RPC_TEST_MAX     (RPC_TEST1)        /**< Test max value */
#define RPC_TEST_STRM_XFERSIZE    (1428UL)    /**< Total Transfer size */
#define RPC_TEST_CMD (0x0ABBCCDDUL)
#define RPC_TEST_ASYNC (0xAABBCCDDUL)

static uint32_t RPC_TestIndex;
static int32_t RPC_TestResult = BCM_AT_NOT_STARTED;

static uint8_t RPC_WrBuffer[RPC_TEST_STRM_XFERSIZE];
static uint8_t RPC_RdBuffer[RPC_TEST_STRM_XFERSIZE];

const RPC_InterfaceType RPC_DummyMasterIfc = {
    .mode          = RPC_IFC_CHAN_MODE_MASTER,
    .assoc         = RPC_ASSOCIATIONINDEX_0,
    .init          = NULL,
    .isConnected   = NULL,
    .connect       = NULL,
    .getMsgSize    = NULL,
    .sendMsg       = NULL,
    .recvMsg       = NULL,
    .processMsg    = NULL,
    .detectStrm    = NULL,
    .processStrm   = NULL,
    .disconnect    = NULL,
    .getEventMask  = NULL,
    .deinit        = NULL,
};

const RPC_InterfaceType RPC_DummySlaveIfc = {
    .mode          = RPC_IFC_CHAN_MODE_SLAVE,
    .assoc         = RPC_ASSOCIATIONINDEX_1,
    .init          = NULL,
    .isConnected   = NULL,
    .connect       = NULL,
    .getMsgSize    = NULL,
    .sendMsg       = NULL,
    .recvMsg       = NULL,
    .processMsg    = NULL,
    .processStrm   = NULL,
    .disconnect    = NULL,
    .getEventMask  = NULL,
    .deinit        = NULL,
};

const RPC_InterfaceType* const RPC_Interfaces[RPC_INTERFACEID_MAX] = {
    &RPC_UDPSlaveIfc,
    &RPC_DummyMasterIfc,
    &RPC_DummySlaveIfc,
    &RPC_UDPMasterIfc,
    NULL,
    NULL,
    NULL,
    NULL,
};

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
#if defined(__BCM8956X__) || defined(__BCM8957X__) || defined(__BCM8958X__)
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
int32_t RPCTest_SetModeActive(void)
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

int32_t RPC_TestInit(void)
{
    int32_t ret;
    INET_InterfaceVlanTagConfigType vlanCfg = { .pcp = 0, .vlan = 0 };

    /* Initialize Ethernet driver */
    ETHER_Init(ETHER_HW_ID_0, &EthIT1_Config);

    /* Set controller mode to Active */
    ret = RPCTest_SetModeActive();
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("RPCTest_SetModeActive() failed with %d\n", ret);
        goto err;
    }

    ret = NIF_Init();
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("NIF_Init() failed with %d\n", ret);
        goto err;
    }
    INET_Init();

    ret = INET_UpdateInterface(INET_INTERFACEID_0, INET_IPADDRESSASSIGNMENT_STATIC,
                              (INET_CONVERT_IP_ADDRESS((192UL), (168UL), (10UL), (1UL))),
                              (24U), (INET_CONVERT_IP_ADDRESS((192UL), (168UL), (10UL), (0UL))),
                              &vlanCfg);
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("INET_UpdateInterface() failed with %d\n", ret);
        goto err;
    }

    ret = INET_UpdateInterface(INET_INTERFACEID_1, INET_IPADDRESSASSIGNMENT_STATIC,
                              (INET_CONVERT_IP_ADDRESS((192UL), (168UL), (10UL), (0UL))),
                              (24U), (INET_CONVERT_IP_ADDRESS((192UL), (168UL), (10UL), (1UL))),
                              &vlanCfg);
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("INET_UpdateInterface() failed with %d\n", ret);
        goto err;
    }

    /* Enable Ethernet Controller loopback */
    ETHER_EnableLoopBack(ETHER_HW_ID_0);

    /* Pre-populate the ARP caches */
    INET_ARPEntryType* cache = INET_Config.interfaces[INET_INTERFACEID_0]->arpCache;

    cache->valid = 1UL;
    cache->ipAddr = (INET_CONVERT_IP_ADDRESS((192UL), (168UL), (10UL), (0UL)));
    cache->flags = INET_ARPENTRYSTATE_STATIC;
    cache->macAddr[0] = 0xAA;
    cache->macAddr[1] = 0xBB;
    cache->macAddr[2] = 0xCC;
    cache->macAddr[3] = 0xDD;
    cache->macAddr[4] = 0xEE;
    cache->macAddr[5] = 0xFF;

    cache = INET_Config.interfaces[INET_INTERFACEID_1]->arpCache;
    cache->valid = 1UL;
    cache->ipAddr = (INET_CONVERT_IP_ADDRESS((192UL), (168UL), (10UL), (1UL)));
    cache->flags = INET_ARPENTRYSTATE_STATIC;
    cache->ifID  = INET_INTERFACEID_1;
    cache->macAddr[0] = 0xAA;
    cache->macAddr[1] = 0xCC;
    cache->macAddr[2] = 0xCC;
    cache->macAddr[3] = 0xDD;
    cache->macAddr[4] = 0xEE;
    cache->macAddr[5] = 0xFF;

err:
    return ret;
}

uint32_t RPC_GetImgSize(uint16_t aPid, uint16_t aImgID, uint32_t aOffset)
{
    return RPC_TEST_STRM_XFERSIZE;
}

const RPC_InterfaceType* const * RPC_GetModInterfaces()
{
    return RPC_Interfaces;
}


void RPC_TEST_AlarmCb(void)
{
    if (BCM_AT_EXECUTING == RPC_TestResult) {
        (void)SetEvent(RPC_EventTask, SystemEvent1);
        (void)SetEvent(RPC_TestTask, SystemEvent1);
    }
}

void RPC_ProcessModuleMsg()
{
    RPC_UDPMasterIfc.processMsg();
    RPC_UDPSlaveIfc.processMsg();
}

/************ SEQ1: Command-response Test *************/
int32_t RPC_TestSequence1(void)
{
    int32_t retVal;
    int32_t retVal2;
    uint32_t tmp32 = 0UL;
    BCM_EventMaskType mask = 0UL;
    RPC_HdlType outHdl;
    RPC_HdlType slaveHdl;
    RPC_HdlType cmdHdl;
    RPC_MemMsgType *msg;
    RPC_HdlType masterHdl;
    uint32_t    i;
    uint32_t    outSz = 0UL;
    RPC_StrmCfgType cfg = {
        .pid = 3U,
        .imgId = 0xBC50U,
        .offset = 0UL,
        .isTbl = 0UL,
        .xferSize = RPC_TEST_STRM_XFERSIZE,
        .isRead = TRUE,
        .partial = FALSE,
    };

    RPC_MemInit();

    /* Initialize interface */
    retVal = RPC_UDPMasterIfc.init();
    if(BCM_ERR_OK != retVal) {
        ULOG_ERR("RPC Master init failed %u\n", retVal);
        goto done;
    }

    retVal = RPC_UDPSlaveIfc.init();
    if(BCM_ERR_OK != retVal) {
        ULOG_ERR("RPC Slave init failed %u\n", retVal);
        goto done;
    }

    /* Connect interface */
    while((FALSE == RPC_UDPMasterIfc.isConnected()) || (FALSE == RPC_UDPSlaveIfc.isConnected())) {
        (void)BCM_GetEvent(RPC_TestTask, &mask);
        (void)BCM_ClearEvent(mask);
        (void)BCM_WaitEvent(SystemEvent1);
        RPC_UDPMasterIfc.connect();
        RPC_UDPSlaveIfc.connect();
    }

    tmp32 = RPC_UDPMasterIfc.getMsgSize();
    if(RPC_MEM_MSG_PAYLOAD_SZ != tmp32) {
        ULOG_ERR("Fail\n");
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    }

    tmp32 = RPC_UDPSlaveIfc.getMsgSize();
    if(RPC_MEM_MSG_PAYLOAD_SZ != tmp32) {
        ULOG_ERR("Fail\n");
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    }

    /* Send a command from master to slave */
    retVal = RPC_MsgAlloc(RPC_HDL_INVALID, RPC_INTERFACEID_0, RPC_INTERFACEID_1,
                          RPC_ASSOCIATIONINDEX_0, &outHdl);
    if(BCM_ERR_OK != retVal) {
        ULOG_ERR("Fail =%d\n",retVal);
        goto done;
    }

    msg = RPC_MsgGet(outHdl);
    if(NULL == msg) {
        ULOG_ERR("Fail\n");
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    } else {
        BCM_MemSet(msg, 0U, sizeof(RPC_MemMsgType));
    }

    msg->magic = RPC_MEMMSG_MAGIC;
    msg->cmd = RPC_TEST_CMD;

    do {
        retVal = RPC_UDPMasterIfc.sendMsg(outHdl);
        (void)BCM_GetEvent(RPC_TestTask, &mask);
        (void)BCM_ClearEvent(mask);
        (void)BCM_WaitEvent(SystemEvent1);
    } while (BCM_ERR_NOMEM == retVal);

    if(BCM_ERR_OK != retVal) {
        ULOG_ERR("Fail\n");
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    }

    /* Receive the command at slave */

    do {
        (void)BCM_GetEvent(RPC_TestTask, &mask);
        (void)BCM_ClearEvent(mask);
        (void)BCM_WaitEvent(SystemEvent1);
        /* Try till UDP slave gets the command */
        retVal = RPC_UDPSlaveIfc.recvMsg(&cmdHdl);
    } while (BCM_ERR_OK != retVal);

    msg = RPC_MsgGet(cmdHdl);
    if(NULL == msg) {
        ULOG_ERR("Fail\n");
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    }

    /* Check that the correct command is received */
    if (RPC_TEST_CMD != msg->cmd) {
        ULOG_ERR("Fail\n");
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    }

    /* Send response to master */
    do {
        retVal = RPC_UDPSlaveIfc.sendMsg(cmdHdl);
        (void)BCM_GetEvent(RPC_TestTask, &mask);
        (void)BCM_ClearEvent(mask);
        (void)BCM_WaitEvent(SystemEvent1);
    } while (BCM_ERR_NOMEM == retVal);

    if(BCM_ERR_OK != retVal) {
        ULOG_ERR("Fail\n");
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    }

    /* Allocate stream handle */
    retVal = RPC_StrmAlloc(&cfg,
                           RPC_INTERFACEID_0,
                           RPC_INTERFACEID_1,
                           RPC_ASSOCIATIONINDEX_0,
                           &slaveHdl);

    if(BCM_ERR_OK != retVal) {
        ULOG_ERR("RPC_StrmAlloc failed %u\n",retVal);
        goto done;
    }


    retVal = RPC_UDPSlaveIfc.processStrm(slaveHdl, BCM_STATE_SUB_STATE_RESET);
    if (BCM_ERR_BUSY != retVal) {
        ULOG_ERR("RPC_ProcessStream failed %u\n",retVal);
        goto done;
    }
    /* Ensure stream request is sent and received */
    do {
        (void)BCM_GetEvent(RPC_TestTask, &mask);
        (void)BCM_ClearEvent(mask);
        (void)BCM_WaitEvent(SystemEvent1);
        retVal = RPC_UDPMasterIfc.detectStrm(&masterHdl);
    } while (BCM_ERR_NOT_FOUND == retVal);

    if(BCM_ERR_OK != retVal) {
        ULOG_ERR("Fail %u\n",retVal);
        goto done;
    }

    /* Initialize stream data */
    for (i = 0UL; i < RPC_TEST_STRM_XFERSIZE; ++i) {
        RPC_WrBuffer[i] = (uint8_t)i;
    }


    retVal = RPC_StrmWrite(masterHdl, RPC_WrBuffer, sizeof(RPC_WrBuffer));
    if(BCM_ERR_OK != retVal) {
        ULOG_ERR("RPC_StrmWrite failed %u\n", retVal);
        goto done;
    }

    do {
        retVal = RPC_UDPMasterIfc.processStrm(masterHdl, BCM_STATE_SUB_STATE_RESET);
        (void)BCM_GetEvent(RPC_TestTask, &mask);
        (void)BCM_ClearEvent(mask);
        (void)BCM_WaitEvent(SystemEvent1);
        retVal2 = RPC_UDPSlaveIfc.processStrm(slaveHdl, BCM_STATE_SUB_STATE_RESET);
    } while ((retVal != BCM_ERR_OK) && (retVal2 != BCM_ERR_OK));

    retVal = RPC_StrmRead(slaveHdl, RPC_RdBuffer, sizeof(RPC_RdBuffer), &outSz);
    if(BCM_ERR_OK != retVal) {
        ULOG_ERR("RPC_StrmRead failed %u\n", retVal);
        goto done;
    }

    for (i = 0UL; i < RPC_TEST_STRM_XFERSIZE; ++i) {
        if (RPC_RdBuffer[i] != (uint8_t)i) {
            retVal = BCM_ERR_DATA_INTEG;
            break;
        }
    }

    /* Receive the response at master */
    do {
        (void)BCM_GetEvent(RPC_TestTask, &mask);
        (void)BCM_ClearEvent(mask);
        (void)BCM_WaitEvent(SystemEvent1);
        /* Try till UDP master gets the response */
        retVal = RPC_UDPMasterIfc.recvMsg(&masterHdl);
    } while (BCM_ERR_OK != retVal);

    msg = RPC_MsgGet(masterHdl);
    if(NULL == msg) {
        ULOG_ERR("Fail\n");
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    }

    /* Send Async message to master */
    retVal = RPC_MsgAlloc(RPC_HDL_INVALID, RPC_INTERFACEID_1, RPC_INTERFACEID_0,
                          RPC_ASSOCIATIONINDEX_1, &slaveHdl);
    if(BCM_ERR_OK != retVal) {
        ULOG_ERR("Fail =%d\n",retVal);
        goto done;
    }
    msg = RPC_MsgGet(slaveHdl);
    if(NULL == msg) {
        ULOG_ERR("Fail\n");
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    } else {
        BCM_MemSet(msg, 0U, sizeof(RPC_MemMsgType));
    }

    msg->magic = RPC_MEMMSG_MAGIC;
    msg->cmd = RPC_TEST_ASYNC;

    do {
        retVal = RPC_UDPSlaveIfc.sendMsg(slaveHdl);
        (void)BCM_GetEvent(RPC_TestTask, &mask);
        (void)BCM_ClearEvent(mask);
        (void)BCM_WaitEvent(SystemEvent1);
    } while (BCM_ERR_NOMEM == retVal);

    /* Receive the Async message at master */
    do {
        (void)BCM_GetEvent(RPC_TestTask, &mask);
        (void)BCM_ClearEvent(mask);
        (void)BCM_WaitEvent(SystemEvent1);
        /* Try till UDP master gets the response */
        retVal = RPC_UDPMasterIfc.recvMsg(&masterHdl);
    } while (BCM_ERR_OK != retVal);

    msg = RPC_MsgGet(masterHdl);
    if(NULL == msg) {
        ULOG_ERR("Fail\n");
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    }

    /* Check that the correct message is received */
    if (RPC_TEST_ASYNC != msg->cmd) {
        ULOG_ERR("Fail\n");
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    }

    /* Disconnect connection */
    RPC_UDPMasterIfc.disconnect();
    RPC_UDPSlaveIfc.disconnect();

    slaveHdl = outHdl;

    /* Try to send/recv command after connection is lost */
    retVal = RPC_UDPMasterIfc.sendMsg(outHdl);
    if(BCM_ERR_OK != retVal) {
        ULOG_ERR("Fail\n");
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    }

    retVal = RPC_UDPMasterIfc.recvMsg(&outHdl);
    if(BCM_ERR_NOT_FOUND != retVal) {
        ULOG_ERR("Fail\n");
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    }

    retVal = RPC_UDPSlaveIfc.sendMsg(slaveHdl);
    if(BCM_ERR_OK != retVal) {
        ULOG_ERR("Fail\n");
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    }

    retVal = RPC_UDPSlaveIfc.recvMsg(&slaveHdl);
    if(BCM_ERR_NOT_FOUND != retVal) {
        ULOG_ERR("Fail\n");
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    }

    if (RPC_UDPINTF_DATA_EVENT != RPC_UDPMasterIfc.getEventMask()) {
        ULOG_ERR("getEventMask Fail\n");
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    }

    RPC_UDPMasterIfc.deinit();
    RPC_UDPSlaveIfc.deinit();

    {
        char fileName[] = "bcm-00000000-89570000-00000000.bin";
        uint16_t imgId;
        uint8_t  pid;
        uint32_t offset;
        uint32_t totalSize;
        uint8_t  isImgTbl;
        (void)RPC_PlatParseEthBootFileName(fileName, 43, &imgId, &pid, &offset, &totalSize, &isImgTbl);
    }
    retVal = BCM_ERR_OK;

    RPC_MemDeinit();

done:
    return retVal;
}

TASK(RPC_EventTask)
{
    ULOG_INFO("\n Event handler task started\n");
    do {
        BCM_EventMaskType mask = 0UL;
        (void)BCM_WaitEvent(SystemEvent0 | SystemEvent1 | SystemEvent3);
        (void)BCM_GetEvent(RPC_EventTask, &mask);
        (void)BCM_ClearEvent(mask);

        if (SystemEvent0 == (mask & SystemEvent0)) {
            (void)BCM_ClearEvent(ETHER_PKT_EVENT);
            ETHER_ProcessPkts(0UL);
        }

        if (SystemEvent3 == (mask & SystemEvent3)) {
            INET_ProcessTimers();
        }
        if(RPC_TEST1 == RPC_TestIndex) {
            RPC_ProcessModuleMsg();
        }
    } while(1);

    BCM_TerminateTask();
}

TASK(RPC_TestTask)
{
    int32_t retVal;

    if(RPC_TEST1 == RPC_TestIndex) {
        RPC_TestInit();
        retVal = RPC_TestSequence1();
    } else {
        retVal = BCM_ERR_UNKNOWN;
    }

    if(BCM_AT_EXECUTING == RPC_TestResult) {
        RPC_TestResult = retVal;
    }
    ULOG_ERR("\n Test %d completed\n", RPC_TestIndex);
    (void)BCM_TerminateTask();
}

int32_t BCM_ExecuteAT(uint32_t aIndex)
{
    int32_t retVal;

    if ((RPC_TEST_MAX >= aIndex) && (0UL < aIndex)) {
        if (BCM_AT_EXECUTING != RPC_TestResult) {
            RPC_TestIndex = aIndex;
            RPC_TestResult = BCM_AT_EXECUTING;
            retVal = (int32_t)BCM_ActivateTask(RPC_TestTask);
            if (BCM_ERR_OK != retVal) {
                ULOG_ERR("%s:%d Activation failed Err:%d\n", __func__, __LINE__, retVal);
                RPC_TestResult = BCM_AT_NOT_STARTED;
                retVal = BCM_ERR_INVAL_STATE;
            }
        } else {
            retVal = BCM_ERR_OK;
        }
    } else {
        retVal = BCM_AT_NOT_AVAILABLE;
    }

    return retVal;
}

int32_t BCM_GetResultAT(uint32_t aIndex)
{
    int32_t retVal = BCM_AT_NOT_AVAILABLE;

    if ((RPC_TEST_MAX >= aIndex) && (0UL < aIndex)) {
        if(RPC_TestIndex == aIndex) {
            retVal = RPC_TestResult;
        }
    }
    return retVal;
}

void APP_Init(void)
{
    /* Dummy Init */
}
