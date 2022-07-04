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
#include <stdlib.h>
#include <string.h>
#include <ulog.h>
#include <bcm_test.h>
#include <bcm_err.h>
#include <nvm.h>
#include <pt_utils.h>
#include <ee.h>
#include <bcm_osil.h>
#include <nvm_osil.h>
#include <flash.h>
#include <ptu_qt.h>


#define GetModuleLogLevel() ULOG_LVL_ERROR

static int32_t PtuQtRunState = BCM_AT_NOT_STARTED;
static int32_t PtuQtResult = BCM_ERR_UNKNOWN;
static uint32_t PtuQtIdx = 0UL;

#define CHECK_ERR(ret, line)                                       \
    if ((BCM_ERR_OK != (ret)) && (BCM_ERR_EAGAIN != (ret))){           \
        ULOG_ERR("\n Error: %d \t line %d", (ret), (line));            \
        goto exit;                                                 \
        }

#define PTUQT_TEST_BUF_SIZE (4UL * 1024UL)

static uint8_t PTUQT_TestBuf[PTUQT_TEST_BUF_SIZE];

PTBL_Type PTUQT_ptbl;
ITBL_BLType PTUQT_bl_tbl;
ITBL_Type PTUQT_itbl;

static void PTU_TestQT1()
{
    uint32_t i,j;
    int32_t retVal;
    const MSGQ_MsgHdrType *hdr;
    NVM_OpResultType nvmResult;
    NVM_AddrType nvmStartAddr[2UL] = {NVM_START_ADDR_FLASH0, NVM_START_ADDR_FLASH1};
    uint32_t flashID[2UL] = {FLASH_HW_ID_0, FLASH_HW_ID_1};
    uint32_t nvmID = 0UL;
    uint32_t len = 0UL;

    for (i = 0UL; i < 2UL; i++) {
        /* Read PT */
        ULOG_ERR(" Trying with flash %d\n",i);
        retVal = NVM_Read(nvmStartAddr[i],
                       PTUQT_TestBuf,
                       PTUQT_TEST_BUF_SIZE,
                       SystemEvent1,
                       &hdr);
        CHECK_ERR(retVal, __LINE__);

        (void)BCM_WaitEvent(SystemEvent1);
        (void)BCM_ClearEvent(SystemEvent1);

        retVal = NVM_GetStatus(&nvmResult, hdr, &len);
        CHECK_ERR(retVal, __LINE__);

        if (NVM_OP_RESULT_SUCCESS == nvmResult) {
            /* Initialize the PT */
            retVal = PTU_ConstructPTBL(PTUQT_TestBuf,PTUQT_TEST_BUF_SIZE, &PTUQT_ptbl);
            if (BCM_ERR_OK == retVal) {
                nvmID = i;
                break;
            }
        }
    }

    if (2UL == i) {
        CHECK_ERR(BCM_ERR_NOT_FOUND, __LINE__);
    }

    for (i = 1UL; i < PTBL_MAX_NUM_COPIES; i++) {
        uint32_t addr;
        retVal = PTU_GetPartitionAddr(&PTUQT_ptbl, (uint16_t)PTBL_ID_CONSTRUCT(PTBL_ID_BL,(PTBL_IdType)i),&addr);
        CHECK_ERR(retVal, __LINE__);
        if (BCM_ERR_OK == retVal) {
            uint32_t len = 0UL;
            /* translate the addr */
            NVM_AddrType partitionAddr;
            retVal = NVM_Phy2VirtAddr(addr, NVM_TYPE_FLASH, flashID[nvmID], &partitionAddr);
            CHECK_ERR(retVal, __LINE__);

            /* read the partition */
            retVal = NVM_Read(partitionAddr,
                           (uint8_t*)&PTUQT_bl_tbl,
                           sizeof(PTUQT_bl_tbl),
                           SystemEvent1,
                           &hdr);
            CHECK_ERR(retVal, __LINE__);

            (void)BCM_WaitEvent(SystemEvent1);
            (void)BCM_ClearEvent(SystemEvent1);

            retVal = NVM_GetStatus(&nvmResult, hdr, &len);
            CHECK_ERR(retVal, __LINE__);
            if (NVM_OP_RESULT_SUCCESS == nvmResult) {
                /* Initialize the PT */
                PTU_ImgInfoType imgInfo;
                retVal = PTU_GetBootloaderInfo(&PTUQT_ptbl,
                                            (uint16_t)PTBL_ID_CONSTRUCT(PTBL_ID_BL,(PTBL_IdType)i),
                                            &PTUQT_bl_tbl,&imgInfo);
                 CHECK_ERR(retVal, __LINE__);
                 ULOG_ERR(" PID %x size %x maxsize %x",PTBL_ID_BL,imgInfo.actualSize,imgInfo.maxSize);
                 ULOG_ERR(" flashAddr %x loadAddr %x\n",imgInfo.flashAddr,imgInfo.loadAddr);
                 break;
            }
        }
    }

    if (PTBL_MAX_NUM_COPIES == i) {
        CHECK_ERR(BCM_ERR_NOT_FOUND, __LINE__);
    }

    for (i = 1UL; i < PTBL_MAX_NUM_COPIES; i++) {
        uint32_t addr;
        retVal = PTU_GetPartitionAddr(&PTUQT_ptbl, (uint16_t)PTBL_ID_CONSTRUCT(PTBL_ID_SYSCFG,(PTBL_IdType)i),&addr);
        CHECK_ERR(retVal, __LINE__);
        if (BCM_ERR_OK == retVal) {
            uint32_t len = 0UL;
            /* translate the addr */
            NVM_AddrType partitionAddr;
            retVal = NVM_Phy2VirtAddr(addr, NVM_TYPE_FLASH, flashID[nvmID], &partitionAddr);
            CHECK_ERR(retVal, __LINE__);

            /* read the partition */
            retVal = NVM_Read(partitionAddr,
                           (uint8_t*)&PTUQT_itbl,
                           sizeof(PTUQT_itbl),
                           SystemEvent1,
                           &hdr);
            CHECK_ERR(retVal, __LINE__);

            (void)BCM_WaitEvent(SystemEvent1);
            (void)BCM_ClearEvent(SystemEvent1);

            retVal = NVM_GetStatus(&nvmResult, hdr, &len);
            CHECK_ERR(retVal, __LINE__);
            if (NVM_OP_RESULT_SUCCESS == nvmResult) {
                /* Initialize the PT */
                uint16_t imgIDs[ITBL_MAX_NUM_ENTRIES];
                uint32_t numImages = ITBL_MAX_NUM_ENTRIES;
                /* get images info */
                retVal = PTU_GetImgIDs(&PTUQT_itbl, imgIDs, &numImages);
                CHECK_ERR(retVal, __LINE__);

                for (j = 0UL ; j < numImages; j++) {
                    PTU_ImgInfoType imgInfo;
                     retVal = PTU_GetImgInfo(&PTUQT_ptbl, (uint16_t)PTBL_ID_CONSTRUCT(PTBL_ID_SYSCFG,(PTBL_IdType)i),
                                            &PTUQT_itbl, imgIDs[j], &imgInfo);
                     CHECK_ERR(retVal, __LINE__);
                     ULOG_ERR(" PID %x IMGID: %x size %x maxsize %x",PTBL_ID_BL,imgIDs[j],imgInfo.actualSize,imgInfo.maxSize);
                     ULOG_ERR(" flashAddr %x loadAddr %x\n",imgInfo.flashAddr,imgInfo.loadAddr);
                }
                break;
            }
        }
    }

    
exit:
    PtuQtResult = retVal;
}

/* PTUQT_Task */
TASK(PTUQT_Task)
{
    if(BRCM_SWQTSEQ_PTU_RECONST_PTBLE == PtuQtIdx)
    {
        PTU_TestQT1();
    }
    else
    {
        PtuQtResult = BCM_ERR_UNKNOWN;
    }

    (void)BCM_TerminateTask();
}

static int32_t PTU_ExecuteQtInternal(uint32_t aTestIdx)
{
    int32_t retVal;
    StatusType retOS = E_OK;
    TaskStateType taskState = SUSPENDED;
    TaskStateRefType taskStatePtr = &taskState;

    retOS = GetTaskState(PTUQT_Task, taskStatePtr);
    if (BCM_ERR_OK == retOS) {
        if (SUSPENDED == taskState) {
            PtuQtRunState = BCM_AT_EXECUTING;
            PtuQtIdx = aTestIdx;
            retVal = BCM_ActivateTask(PTUQT_Task);
            if (BCM_ERR_OK != retVal) {
                retVal = BCM_AT_NOT_STARTED;
                PtuQtRunState = BCM_AT_NOT_STARTED;
                ULOG_ERR("PTUQT_Task activation failed, error: %d\n\r", retVal);
            }
        } else {
            retVal = BCM_AT_EXECUTING;
            ULOG_ERR("PTUQT_Task is already running \n\r");
        }
    } else {
        retVal = BCM_ERR_UNKNOWN;
        ULOG_ERR("GetTaskState in PTU_ExecuteQt failed Error: %d\n\r", retOS);
    }

    return retVal;
}

int32_t PTU_ExecuteQt(uint32_t aTestIdx)
{
    int32_t retVal = BCM_ERR_OK;

    switch(aTestIdx)
    {
#ifdef BRCM_SWQTSEQ_PTU_RECONST_PTBLE
    case BRCM_SWQTSEQ_PTU_RECONST_PTBLE:
        retVal = PTU_ExecuteQtInternal(aTestIdx);
        break;
#endif
    default:
        retVal = BCM_AT_NOT_AVAILABLE;
        break;
    }
    return retVal;
}

static int32_t PTU_GetStatusQtInternal(uint32_t aTestIdx)
{
    int32_t retVal;
    StatusType retOS = E_OK;
    TaskStateType taskState = RUNNING;
    TaskStateRefType taskStatePtr = &taskState;

    if (PtuQtIdx == aTestIdx) {
        retOS = GetTaskState(PTUQT_Task, taskStatePtr);
        if (BCM_ERR_OK == retOS) {
            if ((SUSPENDED == taskState) &&
                (BCM_AT_EXECUTING == PtuQtRunState)) {
                PtuQtRunState = BCM_AT_NOT_STARTED;
                retVal = PtuQtResult;
            } else {
                retVal = BCM_AT_EXECUTING;
            }
        } else {
            retVal = BCM_ERR_UNKNOWN;
            ULOG_ERR("GetTaskState in PTU_GetStatusQt failed Error: %d\n\r", retOS);
        }
    } else {
        retVal = BCM_AT_NOT_AVAILABLE;
    }

    return retVal;
}

int32_t PTU_GetStatusQt(uint32_t aTestIdx)
{
    int32_t retVal;

    switch(aTestIdx)
    {
#ifdef BRCM_SWQTSEQ_PTU_RECONST_PTBLE
    case BRCM_SWQTSEQ_PTU_RECONST_PTBLE:
        retVal = PTU_GetStatusQtInternal(aTestIdx);
        break;
#endif
    default:
        retVal = BCM_AT_NOT_AVAILABLE;
        break;
    }
    return retVal;
}

void APP_Init()
{
    /* Dummy Init */
}
