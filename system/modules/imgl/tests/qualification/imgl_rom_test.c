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

#include <ee.h>
#include <bcm_utils.h>
#include <bcm_osil.h>
#include <ulog.h>
#include <bcm_test.h>
#include <pt_utils.h>
#include <imgl_osil.h>
#include <pt_utils.h>
#include <crc.h>
#include <imgl_mmap.h>
#include <module.h>
#include <module_helper.h>
#include <imgl_mod.h>
#include <otp_module_osil.h>
#include <crypto_service.h>

#include "test_flat_flash.h"
#include "test_bl.h"

extern uint8_t IMGL_TestMmap0[];

uint32_t IMGLTEST_WaitForFlag = 0UL;
uint32_t IMGLTEST_SlaveReqState = 0UL;
uint32_t IMGLTEST_SlaveReqEvent = SystemEvent1;
uint32_t IMGLTEST_SlaveReqBL = 0UL;

extern int32_t IMGLTEST_SlaveReq();

uint32_t IMGLTEST_BLReq = 0UL;
int32_t IMGLTEST_RomNegTest()
{
    int32_t ret = BCM_ERR_OK;
    return ret;
}
#define GetModuleLogLevel() IMGLTEST_GetTestLogLevel()

#define IMGLTEST_MAX_IMG_SIZE      (0x1000UL)
#define IMGLTEST_TEST_IMG_ID       (0xFF02U)
#define IMGLTEST_MARKING_BYTE      (0xABU)

static uint8_t IMGLTEST_TempMem[ IMGLTEST_MAX_IMG_SIZE];

uint8_t *IMGLTEST_SlaveReqMem = &IMGLTEST_TempMem[0];
uint32_t IMGLTEST_SlaveReqMemSize = IMGLTEST_MAX_IMG_SIZE;

/* IMGLTEST Test Log level */
static uint32_t IMGLTEST_TestLogLevel = ULOG_LVL_VERBOSE;

static uint8_t * IMGLTEST_BLImg;
uint32_t IMGLTEST_BLImgOffset = 0x100;
uint32_t IMGLTEST_UsingRPC = 0UL;

/* Get IMGLTEST Test Log Level */
COMP_INLINE uint32_t IMGLTEST_GetTestLogLevel()
{
    return IMGLTEST_TestLogLevel;
}

volatile int32_t IMGLTEST_result = BCM_AT_NOT_STARTED;

static uint32_t IMGLTEST_FlatBinSize;

const MODULE_Type* const IMGL_FetchModuleFnTable[MODULE_COUNT_MAX] = {
    &OTPM_Module,
    &CRYPTO_Service.client,
    &IMGL_FetchModule,
};

uint32_t* IMGL_GetBLAddr(void)
{
    if (0UL == IMGLTEST_SlaveReqBL) {
        uint32_t blSize = 0UL;
        if (BCM_ERR_OK == IMGL_MemoryInfoGet(0UL, &IMGLTEST_BLImg, &blSize)) {
            if (0UL == IMGLTEST_UsingRPC) {
                return (uint32_t*)(IMGLTEST_BLImg + IMGLTEST_BLImgOffset);
            } else {
                return (uint32_t*)(IMGLTEST_BLImg);
            }

        }
    } else if (1UL == IMGLTEST_SlaveReqBL) {
        /* serve wrong data */
        return (uint32_t*)IMGL_Mmap0;
    }

    return NULL;
}

static void IMGLTEST_Init(uint8_t *aStartAddr)
{
    PTBL_Type *ptbl = (PTBL_Type *)aStartAddr;
    /* load flat binary */
    int32_t ret;

    uint32_t blSize;

    ret = IMGL_MemoryInfoGet(0UL, &IMGLTEST_BLImg, &blSize);
    if (BCM_ERR_OK != ret) {
        IMGLTEST_result = ret;
    } else if (IMGLTEST_MAX_IMG_SIZE > blSize) {
        IMGLTEST_result = BCM_ERR_NOMEM;
    }

    if (BCM_AT_EXECUTING == IMGLTEST_result) {
        IMGLTEST_FlatBinSize = test_flat_flash_bin_len;
        BCM_MemCpy(aStartAddr, test_flat_flash_bin, test_flat_flash_bin_len);
    }

    /* update load addresses */
    /* NOTE: This portion uses the image IDs used while creating the flattened binary */
    if (BCM_AT_EXECUTING == IMGLTEST_result) {
        uint32_t i;
        ITBL_Type *itbl;
        for (i=0; i < ptbl->hdr.numEntries; i++) {
            uint32_t j;
            uint32_t change = 0;
            uint32_t crc;
            uint32_t badItbl;

            if (i == 0) {
                badItbl = 1;
            } else {
                badItbl = 0;
            }

            PTBL_IdType pid = ptbl->entry[i].pid & PTBL_ID_TYPE_MASK;
            itbl = (ITBL_Type *) (aStartAddr + ptbl->entry[i].addr);
            for (j=0;j<itbl->hdr.numImgs;j++) {
                uint16_t imgID = itbl->entry[j].imgType;
                if ((PTBL_ID_BL == pid) && (0U == imgID)) {
                    change = 1;
                    if (0UL == badItbl) {
                        itbl->hdr.entryPoint = (uint32_t) (IMGLTEST_BLImg + IMGLTEST_BLImgOffset + sizeof(IMGL_ImgHdrType));
                        itbl->entry[j].loadAddr = (uint32_t) (IMGLTEST_BLImg + IMGLTEST_BLImgOffset);
                    } else {
                        itbl->hdr.entryPoint = (uint32_t) (IMGLTEST_BLImg + blSize + sizeof(IMGL_ImgHdrType));
                        itbl->entry[j].loadAddr = (uint32_t) (IMGLTEST_BLImg + blSize);
                    }
                }
            }

            /* recalculate CRC */
            crc = BCM_CRC32((uint8_t *)itbl->entry, itbl->hdr.numImgs * ITBL_ENTRY_SIZE, PTBL_CRC32_POLY);

            if (0UL != change) {
                itbl->hdr.crc = crc;
                itbl->hdr.hdrErrDetCode = BCM_CRC32((uint8_t *)&itbl->hdr, ITBL_HDR_SIZE - sizeof(uint32_t), PTBL_CRC32_POLY);
            } else {
                if (crc != itbl->hdr.crc) {
                    IMGLTEST_result = BCM_ERR_AUTH_FAILED;
                }
            }
        }
    }

    BCM_MemSet(IMGLTEST_BLImg, IMGLTEST_MARKING_BYTE, blSize);
}

int32_t RPC_CmdQSendCmd(BCM_GroupIDType aGrpID, BCM_CompIDType aCompID, uint8_t aCmdID,
                       const uint8_t *const aParams, uint32_t aSize, uint32_t aClientMask,
                       const MSGQ_MsgHdrType** const aHdr)
{
    return BCM_ERR_OK;
}

int32_t RPC_CmdQGetCmdStatus(const MSGQ_MsgHdrType *const aHdr, int32_t * const aResponse,
                                   uint8_t *const aParams, uint32_t * const aSize)
{
     return BCM_ERR_OK;
}

extern uint8_t __imgl_context_start__[], __imgl_context_end__[];

TASK(IMGLTEST_Task)
{
    uint32_t i;
    int32_t ret;
    BCM_EventMaskType mask;
    BCM_EventMaskType allMask;
    BCM_StateType state = BCM_STATE_UNINIT;
    BCM_StateType prevState;

    IMGLTEST_Init(IMGL_Mmap0);

    for (i = 0UL; i < 4UL; i++) {
        IMGL_EntryPtType entryPt = NULL;
        int32_t exitTask = FALSE;

        BCM_MemSet(IMGLTEST_BLImg + IMGLTEST_BLImgOffset, IMGLTEST_MARKING_BYTE, test_bl_img_len + sizeof(IMGL_ImgHdrType));

        if (0UL != i) {
            IMGLTEST_UsingRPC = 1UL;
            /* fail the RPC request once */
            IMGLTEST_BLReq = BCM_ERR_UNKNOWN;
            if (1UL == i) {
                /* corrupt image to force RPC path */
                /* TODO : Corrupt image header few bytes */
                BCM_MemSet(&IMGL_Mmap0[0x2000], 0U, IMGL_MEM_AREA_MIN_SIZE);
                BCM_MemSet(&IMGL_Mmap0[0x4000], 0U, IMGL_MEM_AREA_MIN_SIZE);
            } else if (2UL == i) {
                /* corrupt itbl to force RPC path */
                BCM_MemSet(&IMGL_Mmap0[0x1000], 0U, IMGL_MEM_AREA_MIN_SIZE);
                BCM_MemSet(&IMGL_Mmap0[0x3000], 0U, IMGL_MEM_AREA_MIN_SIZE);
            } else {
                /* corrupt ptbl to force RPC path */
                BCM_MemSet(&IMGL_Mmap0[0], 0U, IMGL_MEM_AREA_MIN_SIZE);
            }

            /* reset state */
            state = BCM_STATE_UNINIT;

            /* Fail the first request for RPC */
            IMGLTEST_WaitForFlag = 1UL;
        } else {
            if (BCM_ERR_NOT_FOUND != IMGL_GetEntryPt(&entryPt)) {
                IMGLTEST_result = BCM_ERR_UNKNOWN;
                goto err_exit;
            }
        }

        BCM_MemSet(&__imgl_context_start__[0], 0U, (uint32_t)&__imgl_context_end__[0] - (uint32_t)&__imgl_context_start__[0] + 1);

        BCM_MemSet(OTPM_Module.context, 0U, sizeof(MODULE_ContextType));
        BCM_MemSet(CRYPTO_Service.client.context, 0U, sizeof(MODULE_ContextType));
        BCM_MemSet(IMGL_FetchModule.context, 0U, sizeof(MODULE_ContextType));

        /* Get the event masks for all modules and submodules */
        allMask = MODULE_GetEventMask(IMGL_FetchModuleFnTable, MODULE_COUNT_MAX);
        if ((IMGL_GetEventMask() | MODULE_Event) != allMask) {
            IMGLTEST_result = BCM_ERR_UNKNOWN;
            goto err_exit;
        }

        do {
            do {
                prevState = state;
                switch(state) {
                    case BCM_STATE_UNINIT:
                        ret = MODULE_ResetStateHandler(IMGL_FetchModuleFnTable, MODULE_COUNT_MAX);
                        if (BCM_ERR_OK == ret) {
                            state = BCM_STATE_INIT;
                        } else if (BCM_ERR_BUSY != ret) {
                            IMGLTEST_result = BCM_ERR_INVAL_STATE;
                            exitTask = TRUE;
                            goto err_exit;
                        }
                        break;
                    case BCM_STATE_INIT:
                        ret = MODULE_InitStateHandler(IMGL_FetchModuleFnTable, MODULE_COUNT_MAX);
                        if (BCM_ERR_OK == ret) {
                            state = BCM_STATE_READY;
                        } else if (BCM_ERR_BUSY != ret) {
                            IMGLTEST_result = BCM_ERR_INVAL_STATE;
                            exitTask = TRUE;
                            goto err_exit;
                        }
                        break;
                    case BCM_STATE_READY:
                        ret = MODULE_ReadyStateHandler(IMGL_FetchModuleFnTable, MODULE_COUNT_MAX, BCM_STATE_UNINIT);
                        if (BCM_ERR_OK == ret) {
                            if (1UL >= i) {
                                BCM_MemSet(IMGLTEST_TempMem, IMGLTEST_MARKING_BYTE, sizeof(IMGLTEST_TempMem));
                                IMGLTEST_SlaveReqMemSize = IMGLTEST_MAX_IMG_SIZE;
                                IMGLTEST_SlaveReqState = 0UL;
                                state = BCM_STATE_RUN;
                            } else {
                                exitTask = TRUE;
                            }
                        } else if (BCM_ERR_BUSY != ret) {
                            IMGLTEST_result = BCM_ERR_INVAL_STATE;
                            exitTask = TRUE;
                            goto err_exit;
                        }
                        break;
                    case BCM_STATE_RUN:
                        /* serve the bootloader to slave */
                        ret = IMGLTEST_SlaveReq();
                        if (BCM_ERR_OK == ret) {
                            if (0UL == IMGLTEST_SlaveReqState) {
                                /* verify data */
                                if (0 != memcmp(test_bl_img, IMGLTEST_TempMem + sizeof(IMGL_ImgHdrType), test_bl_img_len)) {
                                    IMGLTEST_result = BCM_ERR_AUTH_FAILED;
                                    goto err_exit;
                                }
                            } else {
                                IMGLTEST_result = BCM_ERR_UNKNOWN;
                                goto err_exit;
                            }
                             exitTask = TRUE;
                        } else if (BCM_ERR_BUSY != ret) {
                            IMGLTEST_result = ret;
                            exitTask = TRUE;
                            goto err_exit;
                        }
                        break;
                    default:
                        break;
                }
            } while (prevState != state);

            if (TRUE != exitTask) {
                BCM_WaitEvent(allMask);
                BCM_GetEvent(IMGLTEST_Task, &mask);
                BCM_ClearEvent(mask);
                MODULE_EventHandler(IMGL_FetchModuleFnTable, MODULE_COUNT_MAX, mask);
            }
        } while (exitTask != TRUE);


        if (i == 0) {
            if (0 != memcmp(test_bl_img, IMGLTEST_BLImg + IMGLTEST_BLImgOffset + sizeof(IMGL_ImgHdrType), test_bl_img_len)) {
                IMGLTEST_result = BCM_ERR_AUTH_FAILED;
            }
        } else {
            if (0 != memcmp(test_bl_img, IMGLTEST_BLImg + sizeof(IMGL_ImgHdrType), test_bl_img_len)) {
                IMGLTEST_result = BCM_ERR_AUTH_FAILED;
            }
        }

        ret = IMGL_GetEntryPt(&entryPt);
        if (i != 0) {
            /* For RPC path */
            entryPt += IMGLTEST_BLImgOffset;
        }

        if ((BCM_ERR_OK != ret) || ((uint32_t)(sizeof(IMGL_ImgHdrType) + IMGLTEST_BLImg + IMGLTEST_BLImgOffset) != (uint32_t)entryPt)) {
            IMGLTEST_result = (uint32_t)entryPt;
        }

    }

    if (BCM_AT_EXECUTING == IMGLTEST_result) {
        IMGLTEST_result = IMGLTEST_RomNegTest();
    }
err_exit:

    BCM_TerminateTask();
}

int32_t BCM_ExecuteAT(uint32_t aIndex)
{
    int32_t ret = BCM_AT_NOT_AVAILABLE;

    if (1UL == aIndex) {
        IMGLTEST_result = BCM_AT_EXECUTING;
        BCM_ActivateTask(IMGLTEST_Task);
        ret = BCM_ERR_OK;
    }
    return ret;
}

/* BCM_GetResultAT */
int32_t BCM_GetResultAT(uint32_t aIndex)
{
    int32_t ret = BCM_AT_NOT_AVAILABLE;

    if (1UL == aIndex) {
        ret = IMGLTEST_result;
    }
    return ret;
}
