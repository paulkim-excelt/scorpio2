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
#include "ee.h"
#include <bcm_err.h>
#include <ulog.h>
#include <bcm_utils.h>
#include <osil/bcm_osil.h>
#include <svc.h>
#include <bcm_test.h>
#include <flashm_test.h>
#include "flashm_qt.h"
#include <nvm_flash.h>
#include <flash_module_osil.h>
#include <imgl_interface.h>
#include <mcu.h>
#include <module.h>
#include <module_helper.h>
#include <bcm_utils.h>

#define REPORT_RESULT(case, condition)                                          \
    BCM_SetTestCase(case);                                                  \
    if (condition) {                                                        \
        BCM_SetTestResult(BCM_ERR_OK);                                      \
    } else {                                                                \
        BCM_SetTestResult(BCM_ERR_UNKNOWN);                                 \
        ULOG_ERR("FLASHM_QT: Err case: %x, at line : %d\n", case, __LINE__);   \
        FLASHQtErrCnt++;                                                      \
        break;                                                              \
    }                                                                       \

#define GetModuleLogLevel()     ULOG_LVL_INFO

#define SECTOR_SIZE         (64UL * 1024UL)
#define FLASHMQT_TESTADDR   (1024UL * 1024UL)
#define PAGE_SIZE           (256UL)

static int32_t FLASHQtRunState = BCM_AT_NOT_STARTED;
static uint32_t FLASHQtErrCnt;
static int32_t FLASHQtResult;
static uint32_t FLASHQtIdx;

BCM_HandleType cmdHandle;
uint32_t currCmd = FLASH_CMD_RPC_ERASE;
uint32_t currCmdImgl = FLASH_CMD_IMGL_ERASE;
uint32_t currCmdState = BCM_STATE_SUB_STATE_RESET;
static uint8_t FLASHMQT_TxBuf[PAGE_SIZE];
FLASH_RpcReadInfoType readCmd;
FLASH_RpcWriteInfoType writeCmd;
FLASH_RpcEraseInfoType eraseCmd;
const MSGQ_MsgHdrType* aHdr;


uint8_t imglBufIn[512] = {
    0x48, 0x47, 0x4d, 0x49, 0x01, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x01, 0x20, 0x20, 0x20, 0xa3, 0x1e, 0x09, 0x01, 0x20, 0x20, 0x20, 0x20, 0x01, 0x20, 0x20, 0x20, 0x44, 0xd2, 0x01, 0x20, 0x01, 0x20, 0x20, 0x20, 0x1d, 0x1d, 0x55, 0x43, 0x04, 0x20, 0x20, 0x20, 0xda, 0xf9, 0xe2, 0x7b, 0x20, 0x20, 0x20, 0x20, 0x20, 0x10, 0x20, 0x20, 0x40, 0xf1, 0x20, 0x20, 0x01, 0x20, 0x20, 0x20, 0x40, 0xcf, 0x01, 0x20, 0x20, 0x80, 0x01, 0x20, 0x20, 0x20, 0x20, 0x20, 0x8d, 0x15, 0x1d, 0x7f, 0xcd, 0xd7, 0x80, 0x9d, 0xd2, 0x9c, 0x4b, 0xb2, 0x4d, 0x60, 0x20, 0x43, 0xf3, 0x08, 0x56, 0xa7, 0xe9, 0x81, 0x12, 0xdd, 0xbb, 0x11, 0xb8, 0x71, 0x7e, 0xec, 0x23, 0xd9, 0xa4, 0xf4, 0x5a, 0x09, 0xd0, 0x65, 0xd6, 0x5d, 0x6b, 0xe0, 0xd7, 0x60, 0x20, 0x88, 0x0e, 0x3e, 0x91, 0x86, 0x78, 0xc7, 0xe3, 0x0f, 0x78, 0x08, 0x70, 0x5d, 0xaf, 0xbd, 0x03, 0x58, 0x1c, 0xa8, 0xc3, 0x5c, 0xdb, 0xf3, 0x28, 0x74, 0x4d, 0x96, 0x90, 0x38, 0xe7, 0xca, 0xdd, 0xed, 0xf6, 0x2a, 0xdd, 0x18, 0xab, 0xb2, 0x3c, 0xb0, 0xfa, 0x2a, 0x9e, 0x95, 0x6e, 0x45, 0x16, 0x1f, 0xd5, 0x3f, 0xc4, 0xfb, 0x7e, 0xce, 0xf8, 0xdf, 0x1f, 0xb2, 0x47, 0xc0, 0x53, 0x53, 0xa5, 0x8c, 0x63, 0xb8, 0x35, 0xf8, 0x5d, 0x5d, 0xbf, 0x55, 0xf1, 0x6f, 0xfe, 0x1f, 0xd2, 0x55, 0xad, 0x41, 0x5a, 0x9d, 0x98, 0x69, 0x5a, 0x48, 0x54, 0x24, 0x2e, 0x5c, 0x3c, 0xd9, 0x02, 0x52, 0xad, 0x0f, 0x7a, 0x56, 0x45, 0xc1, 0x1f, 0x8c, 0x4e, 0xb5, 0xab, 0x12, 0x23, 0xb5, 0x63, 0x65, 0xd9, 0xea, 0x92, 0x8b, 0x3a, 0xdf, 0xd0, 0xe6, 0x69, 0xe2, 0xcf, 0x04, 0xc3, 0x4e, 0x19, 0x0d, 0x4e, 0x0e, 0xd9, 0x5d, 0x41, 0xc1, 0x78, 0x7f, 0xeb, 0xc6, 0x7b, 0xb2, 0x90, 0xe9, 0x5f, 0xbb, 0x3e, 0x3f, 0xcc, 0xdc, 0x02, 0x68, 0x6b, 0xbc, 0xa5, 0x4b, 0xfc, 0xcb, 0x90, 0x5c, 0xce, 0x7a, 0x01, 0xea, 0x99, 0xb6, 0xb4, 0x18, 0x54, 0xef, 0x3d, 0x77, 0x3b, 0x80, 0x2c, 0xa5, 0xa1, 0x91, 0xdc, 0xf6, 0x6d, 0x4f, 0xf1, 0x1f, 0x15, 0xa1, 0x62, 0xdd, 0x3c, 0x71, 0x11, 0x51, 0xea, 0x41, 0x4f, 0xf8, 0xe1, 0x04, 0x9f, 0x7c, 0x5c, 0x99, 0x39, 0x97, 0x9f, 0xcf, 0x96, 0x54, 0x80, 0x84, 0x1e, 0x4b, 0xbb, 0xb6, 0x79, 0xc3, 0x89, 0xdf, 0x71, 0xcb, 0x59, 0x75, 0x02, 0xa0, 0xa5, 0xbc, 0x64, 0x7b, 0x9f, 0x08
};

uint8_t imglBufOut[2*PAGE_SIZE] = {0};
uint8_t imglItblBufOut[PAGE_SIZE] = {0};
uint8_t imglPtblBufOut[PAGE_SIZE] = {0};

static const MODULE_Type* const SYSTEM_ModuleFnTables[MODULE_COUNT_MAX] = {
    &FLASHM_Module,
};

void FLASHM_GetServerInfo(int32_t *aServerTask, uint32_t *aServerEvent)
{
    *aServerTask = FLASHMQT_Task;
    *aServerEvent = MODULE_EVENT;
}

uint32_t FLASHM_TestSeq0(uint32_t aHwID)
{
    uint32_t retVal;
    uint32_t forwardToSlaves;
    BCM_CmdType replyID = 0UL;
    uint32_t replyLen = 0UL;
    uint32_t prevCmd;


    do {
        prevCmd = currCmd;
        switch (currCmd) {
            case FLASH_CMD_RPC_ERASE:
                if (BCM_STATE_SUB_STATE_RESET == currCmdState) {
                    eraseCmd.hwID = aHwID;
                    eraseCmd.addr = FLASHMQT_TESTADDR;
                    eraseCmd.len  = SECTOR_SIZE;
                    retVal = FLASHM_Module.sendCmd(FLASH_CMD_RPC_ERASE, sizeof(FLASH_RpcEraseInfoType),
                                                    (const uint8_t *)&eraseCmd, &cmdHandle, &forwardToSlaves);
                    if (BCM_ERR_OK == retVal) {
                        currCmdState = BCM_STATE_SUB_STATE_STAGE0;
                        retVal = BCM_ERR_BUSY;
                    } else {
                        FLASHQtResult = retVal;
                    }
                } else {
                    retVal = FLASHM_Module.getResp(cmdHandle, replyID, sizeof(FLASH_RpcEraseInfoType),
                                                    (uint8_t *)&eraseCmd, &replyLen);
                    if (BCM_ERR_OK == retVal) {
                        REPORT_RESULT(1UL, (replyLen == sizeof(FLASH_RpcEraseInfoType)))
                            currCmd = FLASH_CMD_RPC_WRITE;
                        currCmdState = BCM_STATE_SUB_STATE_RESET;
                        retVal = BCM_ERR_BUSY;
                    } else if (BCM_ERR_BUSY == retVal) {
                    } else {
                        FLASHQtResult = retVal;
                    }
                }
                break;
            case FLASH_CMD_RPC_WRITE:
                if (BCM_STATE_SUB_STATE_RESET == currCmdState) {
                    writeCmd.hwID = aHwID;
                    writeCmd.addr = FLASHMQT_TESTADDR;
                    writeCmd.len = PAGE_SIZE;
                    BCM_MemSet(FLASHMQT_TxBuf, 0xA5, sizeof(FLASHMQT_TxBuf));
                    BCM_MemCpy(writeCmd.bufIn, FLASHMQT_TxBuf, sizeof(writeCmd.bufIn));
                    retVal = FLASHM_Module.sendCmd(FLASH_CMD_RPC_WRITE, sizeof(FLASH_RpcWriteInfoType),
                                                        (const uint8_t *)&writeCmd, &cmdHandle, &forwardToSlaves);
                    if (BCM_ERR_OK == retVal) {
                        currCmdState = BCM_STATE_SUB_STATE_STAGE0;
                        retVal = BCM_ERR_BUSY;
                    } else {
                        FLASHQtResult = retVal;
                    }
                } else {
                    retVal = FLASHM_Module.getResp(cmdHandle, replyID, sizeof(FLASH_RpcWriteInfoType),
                                                            (uint8_t *)&writeCmd, &replyLen);
                    if (BCM_ERR_OK == retVal) {
                        REPORT_RESULT(1UL, (replyLen == sizeof(FLASH_RpcWriteInfoType)))
                            currCmd = FLASH_CMD_RPC_READ;
                        currCmdState = BCM_STATE_SUB_STATE_RESET;
                        retVal = BCM_ERR_BUSY;
                    } else if (BCM_ERR_BUSY == retVal) {
                    } else {
                        FLASHQtResult = retVal;
                    }
                }
                break;
            case FLASH_CMD_RPC_READ:
                if (BCM_STATE_SUB_STATE_RESET == currCmdState) {
                    readCmd.hwID = aHwID;
                    readCmd.addr = FLASHMQT_TESTADDR;
                    readCmd.len = PAGE_SIZE;

                    retVal = FLASHM_Module.sendCmd(FLASH_CMD_RPC_READ, sizeof(FLASH_RpcReadInfoType),
                                                        (const uint8_t *)&readCmd, &cmdHandle, &forwardToSlaves);
                    if (BCM_ERR_OK == retVal) {
                        currCmdState = BCM_STATE_SUB_STATE_STAGE0;
                        retVal = BCM_ERR_BUSY;
                    } else {
                        FLASHQtResult = retVal;
                    }
                } else {
                    retVal = FLASHM_Module.getResp(cmdHandle, replyID, sizeof(FLASH_RpcReadInfoType),
                                                        (uint8_t *)&readCmd, &replyLen);
                    if (BCM_ERR_OK == retVal) {
                        REPORT_RESULT(1UL, (replyLen == sizeof(FLASH_RpcReadInfoType)))
                            REPORT_RESULT(2UL, (0UL == memcmp(FLASHMQT_TxBuf, readCmd.bufOut, PAGE_SIZE)));
                        currCmdState = BCM_STATE_SUB_STATE_RESET;
                        retVal = BCM_ERR_OK;
                    } else if (BCM_ERR_BUSY == retVal) {
                    } else {
                        FLASHQtResult = retVal;
                    }
                }
                break;
            default:
                retVal = BCM_ERR_NOSUPPORT;
                break;
        }
    } while(currCmd != prevCmd);



    if (FLASHQtErrCnt > 0UL) {
        FLASHQtResult = BCM_ERR_CUSTOM;
    }

    return retVal;
}


int32_t FLASHM_TestSeq1(uint32_t aHwID)
{

    uint32_t retVal;
    uint32_t size = 0UL;
    uint32_t prevCmd;
    uint32_t offset = 0UL;



    do {
        prevCmd = currCmdImgl;
        switch (currCmdImgl) {

            case FLASH_CMD_IMGL_ERASE:
                if (BCM_STATE_SUB_STATE_RESET == currCmdState) {
                    retVal = FLASHM_ImglHandler.eraseImg(aHwID, 0UL, 0UL, FLASHMQT_TESTADDR,
                                                            SECTOR_SIZE, MODULE_EVENT, (const MSGQ_MsgHdrType** const)&aHdr);
                    if (BCM_ERR_OK == retVal) {
                        currCmdState = BCM_STATE_SUB_STATE_STAGE0;
                        retVal = BCM_ERR_BUSY;
                    } else {
                        FLASHQtResult = retVal;
                    }
                } else {
                    retVal = FLASHM_ImglHandler.getStatus(aHdr, &size);
                    if (BCM_ERR_OK == retVal) {
                        REPORT_RESULT(1UL, (size == SECTOR_SIZE))
                            currCmdImgl = FLASH_CMD_IMGL_WRITE;
                        currCmdState = BCM_STATE_SUB_STATE_RESET;
                        retVal = BCM_ERR_BUSY;
                    } else if (BCM_ERR_BUSY == retVal) {
                    } else {
                        FLASHQtResult = retVal;
                    }
                }
                break;

            case FLASH_CMD_IMGL_WRITE:
                if (BCM_STATE_SUB_STATE_RESET == currCmdState) {
                    retVal = FLASHM_ImglHandler.writeImg(aHwID, 0UL, 0UL, FLASHMQT_TESTADDR,
                                                            imglBufIn, offset, sizeof(imglBufIn), MODULE_EVENT, (const MSGQ_MsgHdrType** const)&aHdr);
                    if (BCM_ERR_OK == retVal) {
                        currCmdState = BCM_STATE_SUB_STATE_STAGE0;
                        retVal = BCM_ERR_BUSY;
                    } else {
                        FLASHQtResult = retVal;
                    }
                } else {
                    retVal = FLASHM_ImglHandler.getStatus((const MSGQ_MsgHdrType *const)aHdr, &size);
                    if (BCM_ERR_OK == retVal) {
                        REPORT_RESULT(1UL, (size == sizeof(imglBufIn)))
                            currCmdImgl = FLASH_CMD_IMGL_READ;
                        currCmdState = BCM_STATE_SUB_STATE_RESET;
                        retVal = BCM_ERR_BUSY;
                    } else if (BCM_ERR_BUSY == retVal) {
                    } else {
                        FLASHQtResult = retVal;
                    }
                }
                break;

            case FLASH_CMD_IMGL_READ:
                if (BCM_STATE_SUB_STATE_RESET == currCmdState) {
                    retVal = FLASHM_ImglHandler.readImg(aHwID, 0UL, 0UL, FLASHMQT_TESTADDR,
                                                            imglBufOut, offset, 2UL*PAGE_SIZE, MODULE_EVENT, (const MSGQ_MsgHdrType** const)&aHdr);
                    if (BCM_ERR_OK == retVal) {
                        currCmdState = BCM_STATE_SUB_STATE_STAGE0;
                        retVal = BCM_ERR_BUSY;
                    } else {
                        FLASHQtResult = retVal;
                    }
                } else if (BCM_STATE_SUB_STATE_STAGE0 == currCmdState){
                    retVal = FLASHM_ImglHandler.getStatus((const MSGQ_MsgHdrType *const)aHdr, &size);
                    if (BCM_ERR_OK == retVal) {
                        REPORT_RESULT(1UL, (size == 2UL*PAGE_SIZE))
                            REPORT_RESULT(2UL, (0UL == memcmp(imglBufIn, imglBufOut, 2UL*PAGE_SIZE)));
                        currCmdState = BCM_STATE_SUB_STATE_STAGE1;
                        retVal = BCM_ERR_BUSY;
                    } else if (BCM_ERR_BUSY == retVal) {
                    } else {
                        FLASHQtResult = retVal;
                    }
                } else if (BCM_STATE_SUB_STATE_STAGE1 == currCmdState) {
                    retVal = FLASHM_ImglHandler.readPTBL(aHwID, FLASHMQT_TESTADDR,
                                                            imglPtblBufOut, PAGE_SIZE, MODULE_EVENT, (const MSGQ_MsgHdrType** const)&aHdr);
                    if (BCM_ERR_OK == retVal) {
                        currCmdState = BCM_STATE_SUB_STATE_STAGE2;
                        retVal = BCM_ERR_BUSY;
                    } else {
                        FLASHQtResult = retVal;
                    }
                } else if (BCM_STATE_SUB_STATE_STAGE2 == currCmdState){
                    retVal = FLASHM_ImglHandler.getStatus((const MSGQ_MsgHdrType *const)aHdr, &size);
                    if (BCM_ERR_OK == retVal) {
                        REPORT_RESULT(1UL, (size == PAGE_SIZE))
                            REPORT_RESULT(2UL, (0UL == memcmp(imglBufIn, imglPtblBufOut, PAGE_SIZE)));
                        currCmdState = BCM_STATE_SUB_STATE_STAGE3;
                        retVal = BCM_ERR_BUSY;
                    } else if (BCM_ERR_BUSY == retVal) {
                    } else {
                        FLASHQtResult = retVal;
                    }
                } else if (BCM_STATE_SUB_STATE_STAGE3 == currCmdState) {
                    retVal = FLASHM_ImglHandler.readITBL(aHwID, 0UL, FLASHMQT_TESTADDR + 256UL,
                                                            imglItblBufOut, PAGE_SIZE, MODULE_EVENT, (const MSGQ_MsgHdrType** const)&aHdr);
                    if (BCM_ERR_OK == retVal) {
                        currCmdState = BCM_STATE_SUB_STATE_STAGE4;
                        retVal = BCM_ERR_BUSY;
                    } else {
                        FLASHQtResult = retVal;
                    }
                } else {
                    retVal = FLASHM_ImglHandler.getStatus((const MSGQ_MsgHdrType *const)aHdr, &size);
                    if (BCM_ERR_OK == retVal) {
                        REPORT_RESULT(1UL, (size == PAGE_SIZE))
                            REPORT_RESULT(2UL, (0UL == memcmp(&imglBufIn[256], imglItblBufOut, PAGE_SIZE)));
                        currCmdState = BCM_STATE_SUB_STATE_RESET;
                        retVal = BCM_ERR_OK;
                    } else if (BCM_ERR_BUSY == retVal) {
                    } else {
                        FLASHQtResult = retVal;
                    }
                }
                break;

            default:
                retVal = BCM_ERR_NOSUPPORT;
                break;
        }
    } while(currCmdImgl != prevCmd);

    if (FLASHQtErrCnt > 0UL) {
        FLASHQtResult = BCM_ERR_CUSTOM;
    }

    return retVal;
}


TASK(FLASHMQT_Task)
{
    int32_t retVal = BCM_ERR_OK;
    uint32_t exitTask = FALSE;
    BCM_TestStart(0);
    BCM_SetTestSeq(FLASHQtIdx);
    FLASHQtErrCnt = 0;

    BCM_StateType state = BCM_STATE_UNINIT;
    BCM_StateType prevState;

    BCM_EventMaskType mask = 0UL;
    BCM_EventMaskType modMask = 0UL;

    FLASHQtResult = BCM_ERR_OK;
    uint32_t FLASHM_TaskCompleted = FALSE;

    currCmd = FLASH_CMD_RPC_ERASE;
    currCmdImgl = FLASH_CMD_IMGL_ERASE;

    modMask = MODULE_GetEventMask(SYSTEM_ModuleFnTables, MODULE_COUNT_MAX);

    do {
        do {
            prevState = state;
            switch(state) {
                case BCM_STATE_UNINIT:
                    retVal = MODULE_ResetStateHandler(SYSTEM_ModuleFnTables, MODULE_COUNT_MAX);
                    if (BCM_ERR_OK == retVal) {
                        state = BCM_STATE_INIT;
                    }
                    break;
                case BCM_STATE_INIT:
                    retVal = MODULE_InitStateHandler(SYSTEM_ModuleFnTables, MODULE_COUNT_MAX);
                    if (BCM_ERR_OK == retVal) {
                        state = BCM_STATE_READY;
                    }
                    break;
                case BCM_STATE_READY:
                    retVal = MODULE_ReadyStateHandler(SYSTEM_ModuleFnTables, MODULE_COUNT_MAX, BCM_STATE_RUN);
                    if (BCM_ERR_OK == retVal) {
                        state = BCM_STATE_RUN;
                    }

                    break;
                case BCM_STATE_RUN:
                    if (TRUE == FLASHM_TaskCompleted) {
                        retVal = MODULE_RunStateHandler(SYSTEM_ModuleFnTables, MODULE_COUNT_MAX, BCM_STATE_UNINIT);
                        if (BCM_ERR_OK == retVal) {
                            exitTask = TRUE;
                        }
                    }
                    break;
                default:
                    break;
            }
        } while (prevState != state);

        if ((retVal != BCM_ERR_OK) && (retVal != BCM_ERR_BUSY)) {
            exitTask = TRUE;
            FLASHQtResult = retVal;
        }

        if (exitTask != TRUE) {
            if (BCM_STATE_RUN == state) {
                if (FLASHQtIdx == 0UL) {
                    retVal = FLASHM_TestSeq0(0);
                } else if (FLASHQtIdx == 1UL) {
                    retVal = FLASHM_TestSeq1(0);
                } else if (FLASHQtIdx == 2UL) {
                    retVal = FLASHM_TestSeq0(1);
                } else if (FLASHQtIdx == 3UL) {
                    retVal = FLASHM_TestSeq1(1);
                }
                if (BCM_ERR_BUSY != retVal) {
                    FLASHM_TaskCompleted = TRUE;
                }
            }
            if(FLASHM_TaskCompleted != TRUE) {
                BCM_WaitEvent(modMask);
                BCM_GetEvent(FLASHMQT_Task, &mask);
                BCM_ClearEvent(mask);
                MODULE_EventHandler(SYSTEM_ModuleFnTables, MODULE_COUNT_MAX, mask);
            }
        }


    } while (exitTask != TRUE);


    (void)BCM_TerminateTask();
}

static int32_t FLASHM_ExecuteQtInternal(uint32_t aTestIdx)
{
    int32_t retVal;
    StatusType retOS = E_OK;
    TaskStateType taskState = SUSPENDED;
    TaskStateRefType taskStatePtr = &taskState;

    retOS = GetTaskState(FLASHMQT_Task, taskStatePtr);
    if (BCM_ERR_OK == retOS) {
        if (SUSPENDED == taskState) {
            FLASHQtRunState = BCM_AT_EXECUTING;
            FLASHQtIdx = aTestIdx;
            retVal = BCM_ActivateTask(FLASHMQT_Task);
            if (BCM_ERR_OK != retVal) {
                retVal = BCM_AT_NOT_STARTED;
                FLASHQtRunState = BCM_AT_NOT_STARTED;
                ULOG_ERR("FLASHMQT_Task activation failed, error: %d\n\r", retVal);
            }
        } else {
            retVal = BCM_AT_EXECUTING;
            ULOG_ERR("FLASHMQT_Task is already running \n\r");
        }
    } else {
        retVal = BCM_ERR_UNKNOWN;
        ULOG_ERR("GetTaskState in FLASHM_ExecuteQt failed Error: %d\n\r", retOS);
    }

    return retVal;
}

int32_t FLASHM_ExecuteQt(uint32_t aTestIdx)
{
    int32_t retVal = BCM_ERR_OK;

    switch (aTestIdx) {
#ifdef ENABLE_FLASH0
        case BRCM_SWQTSEQ_FLASHM_0:
            retVal = FLASHM_ExecuteQtInternal(aTestIdx);
            break;
        case BRCM_SWQTSEQ_FLASHM_1:
            retVal = FLASHM_ExecuteQtInternal(aTestIdx);
            break;
#endif
#ifdef ENABLE_FLASH1
        case BRCM_SWQTSEQ_FLASHM_2:
            retVal = FLASHM_ExecuteQtInternal(aTestIdx);
            break;
        case BRCM_SWQTSEQ_FLASHM_3:
            retVal = FLASHM_ExecuteQtInternal(aTestIdx);
            break;
#endif
        default:
            retVal = BCM_AT_NOT_AVAILABLE;
            break;
    }

    return retVal;
}

static int32_t FLASHM_GetStatusQtInternal(uint32_t aTestIdx)
{
    int32_t retVal;
    StatusType retOS = E_OK;
    TaskStateType taskState = RUNNING;
    TaskStateRefType taskStatePtr = &taskState;

    if (FLASHQtIdx == aTestIdx) {
        retOS = GetTaskState(FLASHMQT_Task, taskStatePtr);
        if (BCM_ERR_OK == retOS) {
            if ((SUSPENDED == taskState) &&
                    (BCM_AT_EXECUTING == FLASHQtRunState)) {
                FLASHQtRunState = BCM_AT_NOT_STARTED;
                retVal = FLASHQtResult;
            } else {
                retVal = BCM_AT_EXECUTING;
            }
        } else {
            retVal = BCM_ERR_UNKNOWN;
            ULOG_ERR("GetTaskState in FLASHM_GetStatusQt failed Error: %d\n\r", retOS);
        }
    } else {
        retVal = BCM_AT_NOT_AVAILABLE;
    }

    return retVal;
}

int32_t FLASHM_GetStatusQt(uint32_t aTestIdx)
{
    int32_t retVal;

    switch (aTestIdx) {
#ifdef ENABLE_FLASH0
        case BRCM_SWQTSEQ_FLASHM_0:
            retVal = FLASHM_GetStatusQtInternal(aTestIdx);
            break;
        case BRCM_SWQTSEQ_FLASHM_1:
            retVal = FLASHM_GetStatusQtInternal(aTestIdx);
            break;
#endif
#ifdef ENABLE_FLASH1
        case BRCM_SWQTSEQ_FLASHM_2:
            retVal = FLASHM_GetStatusQtInternal(aTestIdx);
            break;
        case BRCM_SWQTSEQ_FLASHM_3:
            retVal = FLASHM_GetStatusQtInternal(aTestIdx);
            break;
#endif
        default:
            retVal = BCM_AT_NOT_AVAILABLE;
            break;
    }

    return retVal;
}

