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
//#include <board.h>
#include <uart.h>
#include <bcm_err.h>
#include <bcm_utils.h>
#include <circ_queue.h>
#include <osil/bcm_osil.h>
#include "ee.h"


#include "ee.h"
#include <string.h>
#include <ulog.h>
#include <bcm_err.h>
#include <bcm_test.h>
//#include <otp.h>
#include <atomic.h>
#include <bcm_utils.h>
#include <shell.h>
#include <osil/bcm_osil.h>

#define GetModuleLogLevel() ULOG_LVL_ERROR

/* Test IDs */
#define UART_IT1     (1UL)

/* Macros for error reporting */
#define ATOMIC_CHECK_UPDATE(status, ret)                    \
{                                                           \
    if (BCM_AT_EXECUTING == (*status)) {                    \
        (*status) = ((int32_t)(ret));                       \
    }                                                       \
}
#define MARK_ERR(status, ret, line)                         \
{                                                           \
    ULOG_ERR("\nError: 0x%x \t line %d", ret ,line);        \
    ATOMIC_CHECK_UPDATE((status), (ret))                    \
}
#define CHECK_ERR(status, ret, line)                        \
    if (BCM_ERR_OK != (ret))                                \
    {                                                       \
        MARK_ERR((status), (ret), (line));                  \
        goto err;                                           \
    }

#define CHECK_ERR_BRK(status, ret, line)                    \
    if (BCM_ERR_OK != (ret))                                \
    {                                                       \
        MARK_ERR((status), (ret), (line));                  \
        break;                                              \
    }

/* Macros */

#define TEST_STRING_SIZE  (sizeof(TxBuffer))
#define TEST_LOG_BUF_SIZE     (32UL)
#define TEST_TX_PACKET_COUNT  (2048UL)

static const uint8_t TxBuffer[] = "UARTTEST_SPEED1M"; /*16Byte x 2048 = 32KB*/
static uint8_t TestRxBuf[TEST_LOG_BUF_SIZE];
static uint32_t RxCount;
static uint32_t currRxIdx;

/* Test Status */
static int32_t UartIT1_Status = BCM_AT_NOT_STARTED;

/* Task for UART_IT1 */
TASK(UartIT1_Task)
{
    int32_t err = BCM_ERR_OK;
    int32_t *aStatus = &UartIT1_Status;
    BCM_EventMaskType mask;

    ULOG_ERR("\nUartTest Started\n");

    currRxIdx = 0UL;
    RxCount = 0UL;
    UART_Init(UART_TEST_HW_ID);

    do {
        err = UART_Send(UART_TEST_HW_ID, TxBuffer, sizeof(TxBuffer));
        CHECK_ERR_BRK(aStatus, err, __LINE__);

        err = BCM_WaitEvent(UartRxEvent | UartRxErrEvent);
        if (BCM_ERR_OK == err) {
            err = BCM_GetEvent(UartIT1_Task, &mask);
            if (BCM_ERR_OK == err) {
                BCM_ClearEvent(mask);
            } else {
                CHECK_ERR_BRK(aStatus, err, __LINE__);
            }
        } else {
            CHECK_ERR_BRK(aStatus, err, __LINE__);
        }

        if ((mask & UartRxEvent) != 0UL) {
            CHECK_ERR_BRK(aStatus, BCM_ERR_OK, __LINE__);
        } else {
            CHECK_ERR_BRK(aStatus, BCM_ERR_UNKNOWN, __LINE__);
        }

    } while (RxCount < TEST_TX_PACKET_COUNT);


    UART_DeInit(UART_TEST_HW_ID);

    if(BCM_AT_EXECUTING == UartIT1_Status) {
        UartIT1_Status = BCM_ERR_OK;
        ULOG_ERR("\nUartTest Passed\n");
    } else {
        ULOG_ERR("\nUartTest Failed\n");
    }

    (void)BCM_TerminateTask();
}


void Test_UARTRxCb(uint8_t *data, uint32_t size)
{
    if (size > 0) {
        if ((currRxIdx + size) < sizeof(TestRxBuf)) {
            BCM_MemCpy(&TestRxBuf[currRxIdx], data, size);
            currRxIdx += size;
            if (currRxIdx == TEST_STRING_SIZE) {
                RxCount++;
                currRxIdx = 0UL;
                if (memcmp(TxBuffer, TestRxBuf, sizeof(TxBuffer)) == 0UL) {
                    SetEvent(UartIT1_Task, UartRxEvent);
                } else {
                    SetEvent(UartIT1_Task, UartRxErrEvent);
                }
                BCM_MemSet(TestRxBuf, 0, TEST_STRING_SIZE);
            }
        }
    }
}

void Test_UARTTxCb(void)
{
}

void Test_ErrCb(UART_ErrorType aError, uint8_t aData)
{
}

const UART_ConfigType UART_Config[] = {
    {
        .baud = UART_BAUD_1000000,
        .txFifoLvl = UART_FIFO_LVL_1DIV8,
        .rxFifoLvl = UART_FIFO_LVL_1DIV8,
        .stopBits = UART_STOP_BITS1,
        .parity = UART_PARITY_NONE,
        .loopBackMode = 1UL,
        .txCb = Test_UARTTxCb,
        .rxCb = Test_UARTRxCb,
        .errCb = Test_ErrCb,
    },
};

/* Start Test */
int32_t BCM_ExecuteAT(uint32_t aIndex)
{
    int32_t retVal = BCM_ERR_OK;

    switch(aIndex) {
    case UART_IT1:
        UartIT1_Status = BCM_AT_EXECUTING;
        (void)BCM_ActivateTask(UartIT1_Task);
        break;
    default:
        retVal = BCM_AT_NOT_AVAILABLE;
        break;
    }
    return retVal;
}

/* Get Test results */
int32_t BCM_GetResultAT(uint32_t aIndex)
{
    int32_t retVal = BCM_ERR_OK;

    switch(aIndex) {
    case UART_IT1:
        retVal = UartIT1_Status;
        break;
    default:
        retVal = BCM_AT_NOT_AVAILABLE;
        break;
    }
    return retVal;
}

void APP_Init(void)
{
    /* Dummy Init */
}
