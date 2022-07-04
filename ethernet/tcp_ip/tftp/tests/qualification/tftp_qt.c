/*****************************************************************************
 Copyright 2019 Broadcom Limited.  All rights reserved.

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
    @addtogroup grp_tftp_qt
    @{

    @file tftp_qt.c
    @brief TFTP Component Qualification Test
    This source file contains the QT implementation for TFTP library
    @version 0.1 Initial version
*/

#include <stdlib.h>
#include <string.h>

#include "ee.h"
#include <ulog.h>
#include <bcm_err.h>
#include <console.h>
#include <bcm_test.h>
#include <osil/bcm_osil.h>
#include "tftp_qt.h"
#include "tftp_test.h"
#include "tftp.h"
#include <eth_osil.h>
#include <module_helper.h>
#include <time_module_osil.h>
#include "inet_osil.h"
#include "udp.h"

/**
    @name Component Qualification Test Sequence IDs
    @{
    @brief Component Qualification Test Sequence IDs
*/
#define BRCM_SWQTDSGN_TFTP_QTSEQUENCE0_PROC      (0xF0U)   /**< @brief #TFTP_QTSequence1  */
#define BRCM_SWQTDSGN_TFTP_QTSEQUENCE1_PROC      (0xF1U)   /**< @brief #TFTP_QTSequence2  */
/** @} */

#define GetModuleLogLevel() ULOG_LVL_VERBOSE

static volatile int32_t tftp_qt_result = BCM_AT_NOT_STARTED;

static uint32_t writeDone = FALSE;

#define TFTP_CHECK_ERR_CLIENT(ret,file,line)  if (BCM_ERR_OK != ret){ ULOG_ERR("\n Client Error: %d \tfile: %s \t line %d",ret,file,line); tftp_qt_result = ret;}
#define TFTP_CHECK_ERR_SERVER(ret,file,line)  if (BCM_ERR_OK != ret){ ULOG_ERR("\n Server Error: %d \tfile: %s \t line %d",ret,file,line); tftp_qt_result = ret;}

#define TFTP_CONVERT_IP_ADDRESS(A, B, C, D) (A & 0xFFU) << 24U|(B & 0xFFU) << 16U\
                                            |(C & 0xFFU) << 8U | (D & 0xFFU)

#define TFTP_BUFFER_SIZE    (4UL * 1000UL)

static uint8_t COMP_SECTION(".dma.bcm.test") clientDataBuf[TFTP_BUFFER_SIZE];
static uint8_t COMP_SECTION(".dma.bcm.test") serverDataBuf[TFTP_BUFFER_SIZE];

TFTP_ContextType clientConnection, serverConnection;

void TFTP_TEST_AlarmCb(void)
{
    if (BCM_AT_EXECUTING == tftp_qt_result) {
        (void)SetEvent(TFTPClientTask, SystemEvent6);
        (void)SetEvent(TFTPServerTask, SystemEvent6);
    }
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
#if defined(__BCM8953X__) || defined(__BCM8956X__) || defined(__BCM8957X__)
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
int32_t TFTPTest_SetModeActive(void)
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

int32_t TFTP_TestInit(void)
{
    int32_t ret;
    INET_InterfaceVlanTagConfigType vlanCfg = { .pcp = 0, .vlan = 0 };

    /* Initialize Ethernet driver */
    ETHER_Init(ETHER_HW_ID_0, &EthIT1_Config);

    /* Set controller mode to Active */
    ret = TFTPTest_SetModeActive();
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("TFTPTest_SetModeActive() failed with %d\n", ret);
        goto err;
    }

    ret = NIF_Init();
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("NIF_Init() failed with %d\n", ret);
        goto err;
    }
    INET_Init();

    ret = INET_UpdateInterface(INET_INTERFACEID_0, INET_IPADDRESSASSIGNMENT_STATIC,
                              (INET_CONVERT_IP_ADDRESS((192UL), (168UL), (10UL), (2UL))),
                              (24U), (INET_CONVERT_IP_ADDRESS((192UL), (168UL), (10UL), (1UL))),
                              &vlanCfg);
    if (BCM_ERR_OK != ret) {
        ULOG_ERR("INET_UpdateInterface() failed with %d\n", ret);
        goto err;
    }

    /* Enable Ethernet Controller loopback */
    ETHER_EnableLoopBack(ETHER_HW_ID_0);
err:
    return ret;
}

/** @brief TFTP client test sequence

    This function tests the TFTP client interfaces.

    @behavior Sync, Non-reentrant

    @param None

    @retval void

    @trace #BRCM_SWQTSEQ_TFTP_SEQ0

    @code{.unparsed}
    @endcode
*/
TASK(TFTPClientTask)
{
    int32_t retVal;
    uint32_t dataSize;
    uint32_t totalSize = 0UL;
    BCM_EventMaskType mask = 0UL;
    uint8_t fileName[TFTP_MAX_FILENAME_LEN+1];
    uint32_t idx;
    uint32_t offset = 0UL;
    uint32_t isLast = FALSE;
    uint32_t procLen = 0UL;

    for (idx = 0UL; idx < TFTP_BUFFER_SIZE; idx++){
        clientDataBuf[idx] = (uint8_t)idx;
    }

    ULOG_INFO("\n TFTP Client Test started\n");

    TFTP_ConfigType config = {0x1234, INET_PAYLOAD_ID0,
        TFTP_CONVERT_IP_ADDRESS((192U), (168U), (10U), (1U)),
        10UL, 3UL};
    config.options.count = 1UL;
    config.options.list[0].type = TFTP_OPTION_BLKSIZE;
    config.options.list[0].val = TFTP_SUPPORTED_MAX_DATA_LEN;

    retVal = TFTP_Init(&clientConnection, &config);
    TFTP_CHECK_ERR_CLIENT(retVal,__FILE__, __LINE__);

    BCM_StrnCpy(fileName, "write512.bin", 13);

    retVal = TFTP_ClientWrite(&clientConnection, fileName);
    TFTP_CHECK_ERR_CLIENT(retVal,__FILE__, __LINE__);

    dataSize = TFTP_BUFFER_SIZE / 10UL;
    isLast = FALSE;

    do {
        (void)BCM_WaitEvent(SystemEvent6 | SystemEvent5);
        (void)BCM_GetEvent(TFTPClientTask, &mask);
        (void)BCM_ClearEvent(mask);

        /* Event for an available ethernet Tx/Rx buffer or on alarm expiry */
        procLen = 0UL;
        retVal = TFTP_PutDataHandler(&clientConnection, clientDataBuf + offset, dataSize, &procLen, isLast);
        ULOG_ERR("C %u of %4u pr %3u tot %4u l %u\n", retVal, offset, procLen, totalSize, isLast);

        if (BCM_ERR_BUSY == retVal) {
            if (dataSize == procLen) {
                offset += dataSize;
                totalSize += procLen;
            }
            if (TFTP_BUFFER_SIZE <= (totalSize + dataSize)) {
                isLast = TRUE;
            }
       } else if (BCM_ERR_OK == retVal) {
            ULOG_ERR("Client total sent bytes %u for file %s\n", totalSize, fileName);
            break;
        } else {
            TFTP_CHECK_ERR_CLIENT(retVal,__FILE__, __LINE__);
            break;
        }
    } while(1);

    if (BCM_ERR_OK != retVal) {
        goto end;
    }

    retVal = TFTP_DeInit(&clientConnection);
    TFTP_CHECK_ERR_CLIENT(retVal,__FILE__, __LINE__);

    retVal = TFTP_Init(&clientConnection, &config);
    TFTP_CHECK_ERR_CLIENT(retVal,__FILE__, __LINE__);

    BCM_StrnCpy(fileName, "read512.bin", 12);
    retVal = TFTP_ClientRead(&clientConnection, fileName);
    TFTP_CHECK_ERR_CLIENT(retVal,__FILE__, __LINE__);
    ULOG_ERR("Client sent read request %s", fileName);

    dataSize = TFTP_BUFFER_SIZE / 2UL;
    offset = 0UL;
    totalSize = 0UL;
    procLen = 0UL;
    BCM_MemSet(clientDataBuf, 0U, TFTP_BUFFER_SIZE);

    do {
        (void)BCM_WaitEvent(SystemEvent6 | SystemEvent5);
        (void)BCM_GetEvent(TFTPClientTask, &mask);
        (void)BCM_ClearEvent(mask);

        retVal = TFTP_GetDataHandler(&clientConnection, clientDataBuf + offset, dataSize, &procLen);
        if (BCM_ERR_OK == retVal) {
            totalSize += procLen;
            ULOG_ERR("Client total received bytes %u for file %s\n",totalSize, fileName);
            break;
        } else if (BCM_ERR_NOMEM == retVal){
            if (dataSize == procLen) {
                offset += dataSize;
                totalSize += procLen;
                procLen = 0UL;
            }
        } else if (BCM_ERR_BUSY != retVal) {
            tftp_qt_result = retVal;
            TFTP_CHECK_ERR_CLIENT(retVal,__FILE__, __LINE__);
            break;
        }
    } while(1);

    if (BCM_ERR_OK != retVal) {
        goto end;
    }

    retVal = TFTP_DeInit(&clientConnection);
    TFTP_CHECK_ERR_CLIENT(retVal,__FILE__, __LINE__);

    for (idx = 0UL; idx < TFTP_BUFFER_SIZE; idx++){
        if (clientDataBuf[idx] != (uint8_t)idx){
            tftp_qt_result = BCM_ERR_DATA_INTEG;
            ULOG_ERR("Client Data mismatch at %u", idx);
            break;
        }
    }

#if 0
    retVal = TFTP_Init(&clientConnection, &config);
    TFTP_CHECK_ERR_CLIENT(retVal,__FILE__, __LINE__);

    BCM_StrnCpy(fileName, "missing_file.bin", 16);
    retVal = TFTP_ClientRead(&clientConnection, fileName);
    TFTP_CHECK_ERR_CLIENT(retVal,__FILE__, __LINE__);

    ULOG_ERR("Client sent read request %s", fileName);
    dataSize = TFTP_BUFFER_SIZE / 2UL;
    offset = 0UL;
    totalSize = 0UL;
    procLen = 0UL;
    BCM_MemSet(clientDataBuf, 0U, TFTP_BUFFER_SIZE);

    do {
        (void)BCM_WaitEvent(SystemEvent6 | SystemEvent5);
        (void)BCM_GetEvent(TFTPClientTask, &mask);
        (void)BCM_ClearEvent(mask);

        retVal = TFTP_GetDataHandler(&clientConnection, clientDataBuf + offset, dataSize, &procLen);
        if (BCM_ERR_OK == retVal) {
            totalSize += procLen;
            ULOG_ERR("Client total received bytes %u for file %s\n",totalSize, fileName);
            break;
        } else if (BCM_ERR_NOMEM == retVal){
            if (dataSize == procLen) {
                offset += dataSize;
                totalSize += procLen;
                procLen = 0UL;
            }
        } else if (BCM_ERR_BUSY != retVal) {
            tftp_qt_result = retVal;
            TFTP_CHECK_ERR_CLIENT(retVal,__FILE__, __LINE__);
            break;
        }
    } while(1);
#endif

end:
    if (BCM_AT_EXECUTING == tftp_qt_result) {
        ULOG_INFO("\n TFTP Client Test PASSED \n");
        tftp_qt_result = BCM_ERR_OK;
    }

    BCM_TerminateTask();
}

/** @brief TFTP server test sequence

    This function tests the TFTP server interfaces.

    @behavior Sync, Non-reentrant

    @param None

    @retval void

    @trace #BRCM_SWQTSEQ_TFTP_SEQ1

    @code{.unparsed}
    @endcode
*/
TASK(TFTPServerTask)
{
    int32_t  retVal;
    BCM_EventMaskType mask = 0UL;
    TFTP_OptionCfgType options;

    TFTP_ConfigType config = {0x1234, INET_PAYLOAD_ID1,
                              INET_IPADDRESS_INVALID,
                              10UL, 3UL};

    ULOG_INFO("\n TFTP Server started\n");

    do {
        uint8_t fileName[TFTP_MAX_FILENAME_LEN+1];
        TFTP_PacketType packetType;
        uint32_t clientIPAddr;
        uint16_t clientPort;

        (void)BCM_WaitEvent(SystemEvent5 | SystemEvent6);
        (void)BCM_GetEvent(TFTPServerTask, &mask);
        (void)BCM_ClearEvent(mask);

        (void)INET_Bind(0x1234, INET_PAYLOAD_ID1, 69);
        retVal = TFTP_DetectPacket(0x1234, INET_PAYLOAD_ID1, fileName, &packetType,
                &clientIPAddr, &clientPort, &options);
        if (BCM_ERR_OK == retVal) {
            ULOG_INFO("TFTP Server > FileName %s Request Type %u ClientIP %x ClientPort %u aBlockSize %u  \n",
                    fileName, packetType, clientIPAddr, clientPort, options.list[0].val);

            if (0U == memcmp(fileName,"missing_file.bin", 16U)) {
                uint8_t errorString[] = "File not present\0";
                do {
                    retVal = TFTP_ServerRejectConnection(0x1234, 0UL, clientIPAddr, clientPort,
                            TFTP_ERROR_FILE_NOT_FOUND, errorString);
                    if (BCM_ERR_BUSY == retVal) {
                        (void)BCM_WaitEvent(SystemEvent5 | SystemEvent6);
                        (void)BCM_GetEvent(TFTPServerTask, &mask);
                        (void)BCM_ClearEvent(mask);
                    }
                } while (retVal != BCM_ERR_OK);

                continue;
            } else {
                /* New request to be serviced */
                uint32_t dataSize = TFTP_BUFFER_SIZE;
                uint32_t totalSize = 0UL;

                BCM_MemCpy(&config.options, &options, sizeof(TFTP_OptionCfgType));
                config.remoteIPAddr = clientIPAddr;

                retVal = TFTP_Init(&serverConnection, &config);
                TFTP_CHECK_ERR_SERVER(retVal,__FILE__, __LINE__);

                if ((TFTP_PACKET_RRQ != packetType) &&
                    (TFTP_PACKET_WRQ != packetType)) {
                    TFTP_CHECK_ERR_SERVER(retVal,__FILE__, __LINE__);
                    break;
                }

                if ((TFTP_PACKET_WRQ == packetType) && (writeDone == TRUE)) {
                    ULOG_ERR("Ignoring duplicate write request");
                    continue;
                }

                retVal = TFTP_ServerAcceptConnection(&serverConnection,
                        clientPort,
                        (TFTP_PACKET_RRQ == packetType) ? TRUE:FALSE);
                TFTP_CHECK_ERR_SERVER(retVal,__FILE__, __LINE__);

                do {
                    /* Event for an available ethernet Tx/Rx buffer or on alarm expiry */
                    (void)BCM_WaitEvent(SystemEvent5 | SystemEvent6);
                    (void)BCM_GetEvent(TFTPServerTask, &mask);
                    (void)BCM_ClearEvent(mask);

                    uint32_t procLen;
                    if (TFTP_PACKET_RRQ == packetType) {
                        retVal = TFTP_PutDataHandler(&serverConnection, serverDataBuf,
                                dataSize, &totalSize, TRUE);
                    } else  {
                        retVal = TFTP_GetDataHandler(&serverConnection, serverDataBuf,
                                dataSize, &procLen);
                    }
                    ULOG_ERR("S %u procLen %4u totalSize %4u\n", retVal, procLen, totalSize);

                    if (BCM_ERR_BUSY == retVal) {
                        continue;
                    } else if (BCM_ERR_NOMEM == retVal) {
                        if (procLen == dataSize) {
                            totalSize += procLen;
                        }
                    } else if (BCM_ERR_OK == retVal) {
                        ULOG_ERR("Server total bytes %u for file %s\n",totalSize, fileName);
                        if (TFTP_PACKET_WRQ == packetType) {
                            writeDone = TRUE;
                            uint32_t idx;
                            for (idx = 0UL; idx < TFTP_BUFFER_SIZE; idx++){
                                if (serverDataBuf[idx] != (uint8_t)idx){
                                    tftp_qt_result = BCM_ERR_DATA_INTEG;
                                    ULOG_ERR("Server Data mismatch at %u data=%x", idx, serverDataBuf[idx]);
                                    break;
                                }
                            }
                        }
                        break;
                    } else {
                        TFTP_CHECK_ERR_SERVER(retVal,__FILE__, __LINE__);
                        break;
                    }
                } while(1);
            }
        }
    } while (1);

    BCM_TerminateTask();
}

TASK(EthernetTask)
{
    ULOG_INFO("\n Ethernet Task started\n");
    do {
        BCM_EventMaskType mask = 0UL;
        (void)BCM_WaitEvent(SystemEvent0 | SystemEvent3);
        (void)BCM_GetEvent(EthernetTask, &mask);
        (void)BCM_ClearEvent(mask);

        if (SystemEvent0 == (mask & SystemEvent0)) {
            (void)BCM_ClearEvent(ETHER_PKT_EVENT);
            ETHER_ProcessPkts(0UL);
        }

        if (SystemEvent3 == (mask & SystemEvent3)) {
            INET_ProcessTimers();
        }
    }while(1);
    BCM_TerminateTask();
}

#ifdef ENABLE_TFTP_IT
TASK(TFTPITTask)
{
    ULOG_INFO("\nTFTP IT Task started\n");
    TFTP_ExecuteIt();
    BCM_TerminateTask();
}
#endif

int32_t BCM_ExecuteAT(uint32_t aIndex)
{
    int32_t ret = BCM_AT_NOT_AVAILABLE;
    if (1UL == aIndex) {
        if (BCM_ERR_OK == TFTP_TestInit()) {
            tftp_qt_result = BCM_AT_EXECUTING;
            ULOG_INFO("\n Test started\n");
            BCM_ActivateTask(EthernetTask);
            BCM_ActivateTask(TFTPServerTask);
            BCM_ActivateTask(TFTPClientTask);
            ret = BCM_ERR_OK;
        }
#ifdef ENABLE_TFTP_IT
    } else if (2UL == aIndex) {
        (void)TFTP_TestInit();
        tftp_qt_result = BCM_AT_EXECUTING;
        ULOG_INFO("\n Test started\n");
        BCM_ActivateTask(TFTPITTask);
        ret = BCM_ERR_OK;
#endif
    }

    return ret;
}

int32_t BCM_GetResultAT(uint32_t aIndex)
{
    int32_t ret = BCM_AT_NOT_AVAILABLE;

    if (1UL == aIndex) {
        ret = tftp_qt_result;
#ifdef ENABLE_TFTP_IT
    } else if (2UL == aIndex) {
        ret = TFTP_GetStatusIt();
#endif
    }

    return ret;
}

/** @} */
