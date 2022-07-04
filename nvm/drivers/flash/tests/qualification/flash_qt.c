/*****************************************************************************
 Copyright 2016-2022 Broadcom Limited.  All rights reserved.

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

#include "ee.h"
#include <string.h>
#include <ulog.h>
#include <bcm_err.h>
#include <bcm_test.h>
#include <bcm_utils.h>
#include <mcu.h>
#include <flash.h>
#include <flash_osil.h>
#include <mcu_clk.h>
#include <atomic.h>
#include <shell.h>
#include <osil/bcm_osil.h>

#include "flash_test.h"
#include "flash_qt.h"

#define GetModuleLogLevel()     ULOG_LVL_ERROR

#define CALL(func)                                                               \
        retVal = func;                                                           \
        if (BCM_ERR_OK != retVal) {                                              \
            FLASHQT_ErrCnt++;                                                     \
            goto bcm_err;                                                        \
        }                                                                        \

#define EXECUTE_TEST(case, func, expecRet)                                       \
        BCM_SetTestCase(case);                                                   \
        retVal = func;                                                           \
        if (expecRet == retVal) {                                                \
            BCM_SetTestResult(BCM_ERR_OK);                                       \
        } else {                                                                 \
            BCM_SetTestResult(BCM_ERR_UNKNOWN);                                  \
            ULOG_ERR("Flash_QT: Err case: %x, retVal: %x at: %d\n",              \
                                            case, retVal, __LINE__);             \
            FLASHQT_ErrCnt++;                                                     \
            goto bcm_err;                                                        \
        }                                                                        \

#define REPORT_RESULT(case, condition)                                           \
        BCM_SetTestCase(case);                                                   \
        if (condition) {                                                         \
            BCM_SetTestResult(BCM_ERR_OK);                                       \
        } else {                                                                 \
            BCM_SetTestResult(BCM_ERR_UNKNOWN);                                  \
            ULOG_ERR("Flash_QT: Err case: %x, at line : %d\n", case, __LINE__);  \
            FLASHQT_ErrCnt++;                                                     \
            goto bcm_err;                                                        \
        }                                                                        \

#define FLASHQT_DONE_IND    (0UL)
#define FLASHQT_ERR_IND     (1UL)

#define FLASH0_SIZE                     (4UL * 1024UL * 1024UL)
#define FLASH0_SPEED                    (FLASH_SPEED_80M)
#define FLASH0_READ_LANE_CFG            (FLASH_READ_LANE_DUAL)
#define FLASH0_FLASH_ID                 (FLASH_FLSID_MACRONIX_MX25L32)
#define FLASH0_FLSABLE_SEC_START_ADDR   (0UL)

#if (FLASH0_SPEED == FLASH_SPEED_80M)
#define FLASH0_CLK_CFG_ID               (MCU_CLK_CFG_ID_QSPI0_SRC250_83MHZ)
#elif (FLASH0_SPEED == FLASH_SPEED_62M)
#define FLASH0_CLK_CFG_ID               (MCU_CLK_CFG_ID_QSPI0_SRC250_62MHZ)
#elif (FLASH0_SPEED == FLASH_SPEED_50M)
#define FLASH0_CLK_CFG_ID               (MCU_CLK_CFG_ID_QSPI0_SRC250_50MHZ)
#elif (FLASH0_SPEED == FLASH_SPEED_25M)
#define FLASH0_CLK_CFG_ID               (MCU_CLK_CFG_ID_QSPI0_SRC250_25MHZ)
#endif

/* Flash page size */
#define PAGE_SIZE               (256UL)
/* Section page size */
#define SECTOR_SIZE             (64UL * 1024UL)
#define FLASHQT_TESTADDR        (FLASH0_FLSABLE_SEC_LIST0_START)
#define FLASHQT_PAGE_COUNT      (4UL)

static const MCU_ClkCfgIDType FLASHQT_ClkTbl[] = {
#ifdef ENABLE_FLASH0
    FLASH0_CLK_CFG_ID,
#endif /* ENABLE_FLASH0 */
#if (FLASH_MAX_HW_ID > 1)
#if ENABLE_FLASH1
    FLASH1_CLK_CFG_ID,
#endif /* ENABLE_FLASH1 */
#endif /* FLASH_MAX_HW_ID > 1 */
};

const MCU_ClkCfgIDType *FLASH_clk_table = FLASHQT_ClkTbl;
const uint32_t FLASH_clk_table_sz = (sizeof(FLASHQT_ClkTbl) /
                                     sizeof(MCU_ClkCfgIDType));

#ifdef ENABLE_FLASH0
/* Flashable (Erasable/Writable) sector list for Flash 0 */
#define FLASH0_FLSABLE_SEC_LIST0_START      (FLASH0_FLSABLE_SEC_START_ADDR)
#define FLASH0_FLSABLE_SEC_LIST0_SECTORS    (3UL)
static const FLASH_FlsableSecType FLASHQT_Fls0FlsableSecList[] = {
    {FLASH0_FLSABLE_SEC_LIST0_START, FLASH0_FLSABLE_SEC_LIST0_SECTORS},
};
#endif /* ENABLE_FLASH0 */

#if (FLASH_MAX_HW_ID > 1)
#ifdef ENABLE_FLASH1
/* Flashable (Erasable/Writable) sector list for Flash 1 */
#define FLASH1_FLSABLE_SEC_LIST0_START      (FLASH1_FLSABLE_SEC_START_ADDR)
#define FLASH1_FLSABLE_SEC_LIST0_SECTORS    (3UL)
static const FLASH_FlsableSecType FLASHQT_Fls1FlsableSecList[] = {
    {FLASH1_FLSABLE_SEC_LIST0_START, FLASH1_FLSABLE_SEC_LIST0_SECTORS},
};
#endif /* FLASH_MAX_HW_ID > 1 */
#endif /* ENABLE_FLASH1 */

/* Flash Configurations */
static FLASH_CfgType FLASHQT_Config[FLASH_MAX_HW_ID] = {
#ifdef ENABLE_FLASH0
    {
        .size = FLASH0_SIZE,
        .pageSize = PAGE_SIZE,
        .sectorSize = SECTOR_SIZE,
        .SPIMode = FLASH_SPI_MODE_3,
        .speed = FLASH0_SPEED,
        .readLane = FLASH0_READ_LANE_CFG,
        .flsableSecListSize = (sizeof(FLASHQT_Fls0FlsableSecList)/
                                sizeof(FLASH_FlsableSecType)),
        .flsableSecList = FLASHQT_Fls0FlsableSecList,
        .flsID = FLASH0_FLASH_ID,
    },
#else
    {0},
#endif
#if (FLASH_MAX_HW_ID > 1)
#ifdef ENABLE_FLASH1
    {
        .size = FLASH1_SIZE,
        .pageSize = PAGE_SIZE,
        .sectorSize = SECTOR_SIZE,
        .SPIMode = FLASH_SPI_MODE_3,
        .speed = FLASH1_SPEED,
        .readLane = FLASH1_READ_LANE_CFG,
        .flsableSecListSize = (sizeof(FLASHQT_Fls1FlsableSecList)/
                                sizeof(FLASH_FlsableSecType)),
        .flsableSecList = FLASHQT_Fls1FlsableSecList,
        .flsID = FLASH1_FLASH_ID,
    },
#else
    {0},
#endif
#endif

#if (FLASH_MAX_HW_ID > 2)
#error "FLASH_MAX_HW_ID > 2 not supported"
#endif
};

/* Buffers */
static uint32_t COMP_SECTION(".dma.bcm.test") FLASHQT_DevID;
static uint8_t COMP_SECTION(".dma.bcm.test") FLASHQT_TxBuf[FLASHQT_PAGE_COUNT * PAGE_SIZE];
static uint8_t COMP_SECTION(".dma.bcm.test") FLASHQT_RxBuf[FLASHQT_PAGE_COUNT * PAGE_SIZE];

/* Qualification test status variables */
static int32_t  FLASHQT_RunState = BCM_AT_NOT_STARTED;
static uint32_t FLASHQT_Idx      = 0UL;
static int32_t  FLASHQT_Result;
static uint32_t FLASHQT_ErrCnt;

/* Flash OpsDoneInd */
void FLASH_OpsDoneInd(FLASH_HwIDType aID)
{
    if (FLASH_HW_ID_0 == aID) {
        (void)BCM_SetEvent(FLASHQT_Task, FlashQt_DoneEvent);
    } else {
        (void)BCM_SetEvent(FLASHQT_Task, FlashQt_DoneEvent);
    }
}

/* Flash OpsErrInd */
void FLASH_OpsErrInd(FLASH_HwIDType aID)
{
    if (FLASH_HW_ID_0 == aID) {
        (void)BCM_SetEvent(FLASHQT_Task, FlashQt_ErrEvent);
    } else {
        (void)BCM_SetEvent(FLASHQT_Task, FlashQt_ErrEvent);
    }
}

/* Helper function to wait, get and clear an event */
static uint32_t FLASHQT_WaitGetClearEvent(TaskType aTaskID)
{
    uint32_t retVal;
    uint32_t isLoopActive = 1UL;
    BCM_EventMaskType mask = 0UL;
    while (1UL == isLoopActive) {
        (void)BCM_WaitEvent(FlashQt_DoneEvent | FlashQt_ErrEvent);
        (void)BCM_GetEvent(aTaskID, &mask);
        if ((mask & FlashQt_DoneEvent) != 0UL) {
            (void)BCM_ClearEvent(FlashQt_DoneEvent);
            retVal = FLASHQT_DONE_IND;
            isLoopActive = 0UL;
        } else if ((mask & FlashQt_ErrEvent) != 0UL) {
            (void)BCM_ClearEvent(FlashQt_ErrEvent);
            retVal = FLASHQT_ERR_IND;
            isLoopActive = 0UL;
        } else {
            isLoopActive = 1UL;
        }
    }
    return retVal;
}

/* Test the flash */
static int32_t FLASHQT_Test1(FLASH_HwIDType aID)
{
    int32_t retVal = BCM_ERR_OK;
    uint32_t mask;
    uint32_t errInd;
    int32_t readCmp;
    FLASH_StatusType flashStatus;
    FLASH_OpsResultType opsRes;

    ULOG_ERR("FlashTest (aID: %d): START\n", aID);

    FLASH_Init(aID, &FLASHQT_Config[aID]);
    /* Verfiy current flash status as FLASH_STATUS_IDLE */
    CALL(FLASH_GetStatus(aID, &flashStatus))
    REPORT_RESULT(BRCM_SWQTST_FLASH_STATUS_IDLE,
                  (FLASH_STATUS_IDLE == flashStatus))
    CALL(FLASH_GetOpsResult(aID, &opsRes))
    REPORT_RESULT(BRCM_SWQTST_FLASH_OPS_RESULT_OK,
                  (FLASH_OPS_RESULT_OK == opsRes))

    if((FLASHQT_Config[aID].flsID == FLASH_FLSID_WINBOND_W25Q16) ||
       (FLASHQT_Config[aID].flsID == FLASH_FLSID_WINBOND_W25Q64CV)) {
        /* Configure Read lane */
        EXECUTE_TEST(BRCM_SWQTST_FLASH_CFG_READLANE,
                 FLASH_CfgReadLane(aID),
                 BCM_ERR_OK)
        do {
            (void)BCM_WaitEvent(SystemEvent0);
            (void)BCM_GetEvent(FLASHQT_Task, &mask);
            (void)BCM_ClearEvent(mask & SystemEvent0);
            FLASH_StateHandler(aID);
            CALL(FLASH_GetOpsResult(aID, &opsRes))
            if ((FLASH_OPS_RESULT_OK == opsRes) ||
                (FLASH_OPS_RESULT_FAIL == opsRes)) {
                errInd = FLASHQT_WaitGetClearEvent(FLASHQT_Task);
                REPORT_RESULT(BRCM_SWQTST_FLASH_READ_EVENT_DONE,
                      (FLASHQT_DONE_IND == errInd))
                REPORT_RESULT(BRCM_SWQTST_FLASH_OPS_RESULT_OK,
                      (FLASH_OPS_RESULT_OK == opsRes))
                break;
            }
        }while(1UL);
    } else {
        EXECUTE_TEST(BRCM_SWQTST_FLASH_CFG_READLANE_NOSUPPORT,
                 FLASH_CfgReadLane(aID),
                 BCM_ERR_NOSUPPORT)
    }

    /* Read device ID */
    EXECUTE_TEST(BRCM_SWQTST_FLASH_READ_DEVID,
                 FLASH_ReadID(aID, &FLASHQT_DevID),
                 BCM_ERR_OK)
    do {
        (void)BCM_WaitEvent(SystemEvent0);
        (void)BCM_GetEvent(FLASHQT_Task, &mask);
        (void)BCM_ClearEvent(mask & SystemEvent0);
        FLASH_StateHandler(aID);
        CALL(FLASH_GetOpsResult(aID, &opsRes))
        if ((FLASH_OPS_RESULT_OK == opsRes) ||
            (FLASH_OPS_RESULT_FAIL == opsRes)) {
            errInd = FLASHQT_WaitGetClearEvent(FLASHQT_Task);
            REPORT_RESULT(BRCM_SWQTST_FLASH_READ_EVENT_DONE,
                  (FLASHQT_DONE_IND == errInd))
            REPORT_RESULT(BRCM_SWQTST_FLASH_OPS_RESULT_OK,
                  (FLASH_OPS_RESULT_OK == opsRes))
            break;
        }
    }while(1UL);

    /* Read Id using FLASH_RegReadWrite API */
    BCM_MemSet(FLASHQT_TxBuf, 0x0, 4UL);
    BCM_MemSet(FLASHQT_RxBuf, 0x0, 4UL);
    FLASHQT_TxBuf[0] = (uint8_t)0x9F;
    EXECUTE_TEST(BRCM_SWQTST_FLASH_READ_DEVID_REG,
                 FLASH_RegReadWrite(aID, FLASHQT_RxBuf, FLASHQT_TxBuf, 4UL),
                 BCM_ERR_OK)
    do {
        (void)BCM_WaitEvent(SystemEvent0);
        (void)BCM_GetEvent(FLASHQT_Task, &mask);
        (void)BCM_ClearEvent(mask & SystemEvent0);
        FLASH_StateHandler(aID);
        CALL(FLASH_GetOpsResult(aID, &opsRes))
        if ((FLASH_OPS_RESULT_OK == opsRes) ||
            (FLASH_OPS_RESULT_FAIL == opsRes)) {
            errInd = FLASHQT_WaitGetClearEvent(FLASHQT_Task);
            REPORT_RESULT(BRCM_SWQTST_FLASH_READ_EVENT_DONE,
                  (FLASHQT_DONE_IND == errInd))
            REPORT_RESULT(BRCM_SWQTST_FLASH_OPS_RESULT_OK,
                  (FLASH_OPS_RESULT_OK == opsRes))
            break;
        }
    }while(1UL);
    REPORT_RESULT(BRCM_SWQTST_FLASH_READ_CMP_DEVID,
                  ((((uint32_t)FLASHQT_RxBuf[1] << 16UL)
                   | ((uint32_t)FLASHQT_RxBuf[2] << 8UL)
                   | (uint32_t)FLASHQT_RxBuf[3]) == FLASHQT_DevID))

    /* Erase 1 sector of flash */
    EXECUTE_TEST(BRCM_SWQTST_FLASH_ERASE_SECTOR,
                 FLASH_Erase(aID, FLASHQT_TESTADDR, SECTOR_SIZE),
                 BCM_ERR_OK)
    do {
        (void)BCM_WaitEvent(SystemEvent0);
        (void)BCM_GetEvent(FLASHQT_Task, &mask);
        (void)BCM_ClearEvent(mask & SystemEvent0);
        FLASH_StateHandler(aID);
        CALL(FLASH_GetOpsResult(aID, &opsRes))
        if ((FLASH_OPS_RESULT_OK == opsRes) ||
            (FLASH_OPS_RESULT_FAIL == opsRes)) {
            errInd = FLASHQT_WaitGetClearEvent(FLASHQT_Task);
            REPORT_RESULT(BRCM_SWQTST_FLASH_READ_EVENT_DONE,
                  (FLASHQT_DONE_IND == errInd))
            REPORT_RESULT(BRCM_SWQTST_FLASH_OPS_RESULT_OK,
                  (FLASH_OPS_RESULT_OK == opsRes))
            break;
        }
    }while(1UL);

    /* Do a blank check of the erased sector */
    EXECUTE_TEST(BRCM_SWQTST_FLASH_ERASE_BLANK_CHECK,
                 FLASH_BlankCheck(aID, FLASHQT_TESTADDR, SECTOR_SIZE),
                 BCM_ERR_OK)
    do {
        (void)BCM_WaitEvent(SystemEvent0);
        (void)BCM_GetEvent(FLASHQT_Task, &mask);
        (void)BCM_ClearEvent(mask & SystemEvent0);
        FLASH_StateHandler(aID);
        CALL(FLASH_GetOpsResult(aID, &opsRes))
        if ((FLASH_OPS_RESULT_OK == opsRes) ||
            (FLASH_OPS_RESULT_FAIL == opsRes)) {
            errInd = FLASHQT_WaitGetClearEvent(FLASHQT_Task);
            REPORT_RESULT(BRCM_SWQTST_FLASH_READ_EVENT_DONE,
                  (FLASHQT_DONE_IND == errInd))
            REPORT_RESULT(BRCM_SWQTST_FLASH_OPS_RESULT_OK,
                  (FLASH_OPS_RESULT_OK == opsRes))
            break;
        }
    }while(1UL);

    /* Write a known pattern to one page of the flash */
    BCM_MemSet(FLASHQT_TxBuf, 0xA5, sizeof(FLASHQT_TxBuf));
    EXECUTE_TEST(BRCM_SWQTST_FLASH_WRITE_PAGE,
                 FLASH_Write(aID, FLASHQT_TESTADDR, FLASHQT_TxBuf, PAGE_SIZE),
                 BCM_ERR_OK)
    do {
        (void)BCM_WaitEvent(SystemEvent0);
        (void)BCM_GetEvent(FLASHQT_Task, &mask);
        (void)BCM_ClearEvent(mask & SystemEvent0);
        FLASH_StateHandler(aID);
        CALL(FLASH_GetOpsResult(aID, &opsRes))
        if ((FLASH_OPS_RESULT_OK == opsRes) ||
            (FLASH_OPS_RESULT_FAIL == opsRes)) {
            errInd = FLASHQT_WaitGetClearEvent(FLASHQT_Task);
            REPORT_RESULT(BRCM_SWQTST_FLASH_READ_EVENT_DONE,
                  (FLASHQT_DONE_IND == errInd))
            REPORT_RESULT(BRCM_SWQTST_FLASH_OPS_RESULT_OK,
                  (FLASH_OPS_RESULT_OK == opsRes))
            break;
        }
    }while(1UL);

    /* Read back the updated page and verity the write */
    EXECUTE_TEST(BRCM_SWQTST_FLASH_READ_PAGE,
                 FLASH_Read(aID, FLASHQT_TESTADDR, FLASHQT_RxBuf, PAGE_SIZE),
                 BCM_ERR_OK)
    do {
        (void)BCM_WaitEvent(SystemEvent0);
        (void)BCM_GetEvent(FLASHQT_Task, &mask);
        (void)BCM_ClearEvent(mask & SystemEvent0);
        FLASH_StateHandler(aID);
        CALL(FLASH_GetOpsResult(aID, &opsRes))
        if ((FLASH_OPS_RESULT_OK == opsRes) ||
            (FLASH_OPS_RESULT_FAIL == opsRes)) {
            errInd = FLASHQT_WaitGetClearEvent(FLASHQT_Task);
            REPORT_RESULT(BRCM_SWQTST_FLASH_READ_EVENT_DONE,
                  (FLASHQT_DONE_IND == errInd))
            REPORT_RESULT(BRCM_SWQTST_FLASH_OPS_RESULT_OK,
                  (FLASH_OPS_RESULT_OK == opsRes))
            break;
        }
    }while(1UL);

    readCmp = memcmp(FLASHQT_TxBuf, FLASHQT_RxBuf, PAGE_SIZE);
    REPORT_RESULT(BRCM_SWQTST_FLASH_READ_CMP,
                  (0 == readCmp))

    /* Use FLASH_Compare to verify the presvious write operation */
    EXECUTE_TEST(BRCM_SWQTST_FLASH_CMP_PAGE,
                 FLASH_Compare(aID, FLASHQT_TESTADDR, FLASHQT_TxBuf,  PAGE_SIZE),
                 BCM_ERR_OK)
    do {
        (void)BCM_WaitEvent(SystemEvent0);
        (void)BCM_GetEvent(FLASHQT_Task, &mask);
        (void)BCM_ClearEvent(mask & SystemEvent0);
        FLASH_StateHandler(aID);
        CALL(FLASH_GetOpsResult(aID, &opsRes))
        if ((FLASH_OPS_RESULT_OK == opsRes) ||
            (FLASH_OPS_RESULT_FAIL == opsRes)) {
            errInd = FLASHQT_WaitGetClearEvent(FLASHQT_Task);
            REPORT_RESULT(BRCM_SWQTST_FLASH_READ_EVENT_DONE,
                  (FLASHQT_DONE_IND == errInd))
            REPORT_RESULT(BRCM_SWQTST_FLASH_OPS_RESULT_OK,
                  (FLASH_OPS_RESULT_OK == opsRes))
            break;
        }
    }while(1UL);

    /* Read 3 sectors from the flash */
    EXECUTE_TEST(BRCM_SWQTST_FLASH_READ_ALL_PAGES,
                 FLASH_Read(aID, FLASHQT_TESTADDR, FLASHQT_RxBuf,
                 (FLASHQT_PAGE_COUNT * PAGE_SIZE)),
                 BCM_ERR_OK)
    (void)BCM_WaitEvent(SystemEvent0);
    (void)BCM_GetEvent(FLASHQT_Task, &mask);
    (void)BCM_ClearEvent(mask & SystemEvent0);
    FLASH_StateHandler(aID);
    /* Cancel the last read operation */
    EXECUTE_TEST(BRCM_SWQTST_FLASH_CANCEL,
                 FLASH_Cancel(aID),
                 BCM_ERR_OK)
    errInd = FLASHQT_WaitGetClearEvent(FLASHQT_Task);
    REPORT_RESULT(BRCM_SWQTST_FLASH_READ_EVENT_ERR,
                  (FLASHQT_ERR_IND == errInd))
    /* verify that FLASH_OPS_RESULT_CANCELLED is received */
    CALL(FLASH_GetOpsResult(aID, &opsRes))
    REPORT_RESULT(BRCM_SWQTST_FLASH_OPS_RESULT_CANCELLED,
                  (FLASH_OPS_RESULT_CANCELLED  == opsRes))

    FLASH_DeInit(aID);
    CALL(FLASH_GetStatus(aID, &flashStatus))
    REPORT_RESULT(BRCM_SWQTST_FLASH_STATUS_UNINIT,
                  (FLASH_STATUS_UNINIT == flashStatus))

bcm_err:
    ULOG_ERR("FlashTest (aID: %d): END\n", aID);
    if (FLASHQT_ErrCnt > 0UL) {
        retVal = BCM_ERR_UNKNOWN;
    }
    return retVal;
}

TASK(FLASHQT_Task)
{
    BCM_TestStart(BCM_SPT_ID);
    BCM_SetTestSeq(FLASHQT_Idx);
    FLASHQT_ErrCnt = 0;

    if (BRCM_SWQTSEQ_FLASH_CTRL0_SEQ1 == FLASHQT_Idx) {
        FLASHQT_Result = FLASHQT_Test1(FLASH_HW_ID_0);
    } else if (BRCM_SWQTSEQ_FLASH_CTRL1_SEQ2 == FLASHQT_Idx){
        FLASHQT_Result = FLASHQT_Test1(FLASH_HW_ID_1);
    } else {
        FLASHQT_Result = BCM_ERR_UNKNOWN;
    }

    (void)BCM_TerminateTask();
}

static int32_t Flash_ExecuteQtInternal(uint32_t aTestIdx)
{
    int32_t retVal;
    StatusType retOS = E_OK;
    TaskStateType taskState = SUSPENDED;
    TaskStateRefType taskStatePtr = &taskState;

    retOS = GetTaskState(FLASHQT_Task, taskStatePtr);
    if (BCM_ERR_OK == retOS) {
        if (SUSPENDED == taskState) {
            FLASHQT_RunState = BCM_AT_EXECUTING;
            FLASHQT_Idx = aTestIdx;
            retVal = BCM_ActivateTask(FLASHQT_Task);
            if (BCM_ERR_OK != retVal) {
                retVal = BCM_AT_NOT_STARTED;
                FLASHQT_RunState = BCM_AT_NOT_STARTED;
                ULOG_ERR("FLASHQT_Task activation failed, error: %d\n\r", retVal);
            }
        } else {
            retVal = BCM_AT_EXECUTING;
            ULOG_ERR("FLASHQT_Task is already running \n\r");
        }
    } else {
        retVal = BCM_ERR_UNKNOWN;
        ULOG_ERR("GetTaskState in Flash_ExecuteQt failed Error: %d\n\r", retOS);
    }

    return retVal;
}

int32_t Flash_ExecuteQt(uint32_t aTestIdx)
{
    int32_t retVal = BCM_ERR_OK;

    switch (aTestIdx) {
#ifdef BRCM_SWQTSEQ_FLASH_CTRL0_SEQ1
#ifdef ENABLE_FLASH0
        case BRCM_SWQTSEQ_FLASH_CTRL0_SEQ1:
            retVal = Flash_ExecuteQtInternal(aTestIdx);
            break;
#endif
#endif
#ifdef BRCM_SWQTSEQ_FLASH_CTRL1_SEQ2
#ifdef ENABLE_FLASH1
        case BRCM_SWQTSEQ_FLASH_CTRL1_SEQ2:
            retVal = Flash_ExecuteQtInternal(aTestIdx);
            break;
#endif
#endif
        default:
            retVal = BCM_AT_NOT_AVAILABLE;
            break;
    }

    return retVal;
}

static int32_t Flash_GetStatusQtInternal(uint32_t aTestIdx)
{
    int32_t retVal;
    StatusType retOS = E_OK;
    TaskStateType taskState = RUNNING;
    TaskStateRefType taskStatePtr = &taskState;

    if (FLASHQT_Idx == aTestIdx) {
        retOS = GetTaskState(FLASHQT_Task, taskStatePtr);
        if (BCM_ERR_OK == retOS) {
            if ((SUSPENDED == taskState) &&
                (BCM_AT_EXECUTING == FLASHQT_RunState)) {
                FLASHQT_RunState = BCM_AT_NOT_STARTED;
                retVal = FLASHQT_Result;
            } else {
                retVal = BCM_AT_EXECUTING;
            }
        } else {
            retVal = BCM_ERR_UNKNOWN;
            ULOG_ERR("GetTaskState in Flash_GetStatusQt failed Error: %d\n\r", retOS);
        }
    } else {
        retVal = BCM_AT_NOT_AVAILABLE;
    }

    return retVal;
}

int32_t Flash_GetStatusQt(uint32_t aTestIdx)
{
    int32_t retVal;

    switch (aTestIdx) {
#ifdef BRCM_SWQTSEQ_FLASH_CTRL0_SEQ1
#ifdef ENABLE_FLASH0
        case BRCM_SWQTSEQ_FLASH_CTRL0_SEQ1:
            retVal = Flash_GetStatusQtInternal(aTestIdx);
            break;
#endif
#endif
#ifdef BRCM_SWQTSEQ_FLASH_CTRL1_SEQ2
#ifdef ENABLE_FLASH1
        case BRCM_SWQTSEQ_FLASH_CTRL1_SEQ2:
            retVal = Flash_GetStatusQtInternal(aTestIdx);
            break;
#endif
#endif
        default:
            retVal = BCM_AT_NOT_AVAILABLE;
            break;
    }

    return retVal;
}