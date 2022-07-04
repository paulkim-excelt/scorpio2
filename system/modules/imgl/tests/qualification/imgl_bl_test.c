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

extern uint8_t IMGL_TestMmap0[];

#define GetModuleLogLevel() IMGLTEST_GetTestLogLevel()

#define IMGLTEST_MAX_IMG_SIZE      (0x1000UL)
#define IMGLTEST_GAURD_BAND_SIZE   (0x100UL)
#define IMGLTEST_TEST_IMG_ID       (0xFF02U)
#define IMGLTEST_MARKING_BYTE      (0xABU)

static uint8_t IMGLTEST_RefMem[IMGLTEST_GAURD_BAND_SIZE + IMGLTEST_MAX_IMG_SIZE + IMGLTEST_GAURD_BAND_SIZE];
static uint8_t IMGLTEST_BLImg[IMGLTEST_GAURD_BAND_SIZE + IMGLTEST_MAX_IMG_SIZE + IMGLTEST_GAURD_BAND_SIZE];
static uint8_t IMGLTEST_Key[IMGLTEST_GAURD_BAND_SIZE + IMGLTEST_MAX_IMG_SIZE + IMGLTEST_GAURD_BAND_SIZE];

/* IMGLTEST Test Log level */
static uint32_t IMGLTEST_TestLogLevel = ULOG_LVL_VERBOSE;

static uint8_t * IMGLTEST_FWText;
static uint8_t * IMGLTEST_FWData;

/* Get IMGLTEST Test Log Level */
COMP_INLINE uint32_t IMGLTEST_GetTestLogLevel()
{
    return IMGLTEST_TestLogLevel;
}

static volatile int32_t IMGLTEST_result = BCM_AT_NOT_STARTED;

static uint32_t IMGLTEST_FlatBinSize;

const MODULE_Type* const IMGL_FetchModuleFnTable[MODULE_COUNT_MAX] = {
    &OTPM_Module,
    &CRYPTO_Service.client,
    &IMGL_FetchModule,
};

static void IMGLTEST_LoadTestImg(uint8_t *aStartAddr, uint16_t aImgID, uint32_t *aSize)
{
    const MSGQ_MsgHdrType* status;

    int32_t ret = BCM_TestLoadImg(aImgID, aStartAddr, *aSize, SystemEvent2, &status);
    if (BCM_ERR_OK != ret) {
        IMGLTEST_result = ret;
    } else {
        do{
            BCM_EventMaskType mask;
            /* wait for the event */
            BCM_WaitEvent(SystemEvent2);
            BCM_GetEvent(IMGLTEST_Task, &mask);
            BCM_ClearEvent(mask);
            ret = BCM_TestGetLoadImgStatus(status, aSize);
        } while (BCM_ERR_BUSY == ret);

        if (BCM_ERR_OK != ret) {
            IMGLTEST_result = ret;
        }
    }
}

/* This always assumes the offset IMGLTEST_GAURD_BAND_SIZE for content */
static void IMGLTEST_ValidateContent(uint16_t aImgID, uint8_t *aContent, uint32_t aMatchFull)
{
    int32_t ret;
    const MSGQ_MsgHdrType* status;
    uint32_t size = 0UL;

    BCM_MemSet(IMGLTEST_RefMem, IMGLTEST_MARKING_BYTE, sizeof(IMGLTEST_RefMem));
    ret = BCM_TestLoadImg(aImgID, &IMGLTEST_RefMem[IMGLTEST_GAURD_BAND_SIZE], IMGLTEST_MAX_IMG_SIZE, SystemEvent2, &status);
    if (BCM_ERR_OK != ret) {
        IMGLTEST_result = ret;
    } else {
        do{
            BCM_EventMaskType mask;
            /* wait for the event */
            BCM_WaitEvent(SystemEvent2);
            BCM_GetEvent(IMGLTEST_Task, &mask);
            BCM_ClearEvent(mask);
            ret = BCM_TestGetLoadImgStatus(status, &size);
        } while (BCM_ERR_BUSY == ret);

        if (BCM_ERR_OK != ret) {
            IMGLTEST_result = ret;
        }
    }

    if (0UL != aMatchFull) {
        ret = memcmp(IMGLTEST_RefMem, aContent, sizeof(IMGLTEST_RefMem));
    } else {
        ret = memcmp(&IMGLTEST_RefMem[IMGLTEST_GAURD_BAND_SIZE], aContent + IMGLTEST_GAURD_BAND_SIZE, size);
    }

    if (BCM_ERR_OK != ret) {
        IMGLTEST_result = ret;
    }

}

static void IMGLTEST_Init(uint8_t *aStartAddr, uint16_t aImgID)
{
    PTBL_Type *ptbl = (PTBL_Type *)aStartAddr;
    /* load flat binary */
    int32_t ret;

    uint32_t textSize;
    uint32_t dataSize;

    ret = IMGL_MemoryInfoGet(0UL, &IMGLTEST_FWText, &textSize);
    if (BCM_ERR_OK != ret) {
        IMGLTEST_result = ret;
    } else if ((IMGLTEST_GAURD_BAND_SIZE + IMGLTEST_MAX_IMG_SIZE + IMGLTEST_GAURD_BAND_SIZE) > textSize) {
        IMGLTEST_result = BCM_ERR_NOMEM;
    }

    ret = IMGL_MemoryInfoGet(1UL, &IMGLTEST_FWData, &dataSize);
    if (BCM_ERR_OK != ret) {
        IMGLTEST_result = ret;
    } else if ((IMGLTEST_GAURD_BAND_SIZE + IMGLTEST_MAX_IMG_SIZE + IMGLTEST_GAURD_BAND_SIZE) > dataSize) {
        IMGLTEST_result = BCM_ERR_NOMEM;
    }

    if (BCM_AT_EXECUTING == IMGLTEST_result) {
        IMGLTEST_FlatBinSize = IMGL_MMAP_SIZE_0;
        IMGLTEST_LoadTestImg(aStartAddr, aImgID, &IMGLTEST_FlatBinSize);
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
            PTBL_IdType pid = ptbl->entry[i].pid & PTBL_ID_TYPE_MASK;
            itbl = (ITBL_Type *) (aStartAddr + ptbl->entry[i].addr);
            for (j=0;j<itbl->hdr.numImgs;j++) {
                uint16_t imgID = itbl->entry[j].imgType;

                if ((PTBL_ID_BL == pid) && (1U == imgID)) {
                    change = 1;
                    itbl->entry[j].loadAddr = (uint32_t) (IMGLTEST_BLImg + IMGLTEST_GAURD_BAND_SIZE);
                }

                if ((PTBL_ID_FW == pid) && (0U == imgID)) {
                    change = 1;
                    itbl->entry[j].loadAddr = (uint32_t) (IMGLTEST_FWText + IMGLTEST_GAURD_BAND_SIZE);
                }

                if ((PTBL_ID_FW == pid) && (2U == imgID)) {
                    change = 1;
                    itbl->entry[j].loadAddr = (uint32_t) (IMGLTEST_FWData + IMGLTEST_GAURD_BAND_SIZE);
                }

                if ((PTBL_ID_SECURE_KEY == pid) && (0U == imgID)) {
                    change = 1;
                    itbl->entry[j].loadAddr = (uint32_t) (IMGLTEST_Key + IMGLTEST_GAURD_BAND_SIZE);
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

    BCM_MemSet(IMGLTEST_BLImg, IMGLTEST_MARKING_BYTE, sizeof(IMGLTEST_BLImg));
    BCM_MemSet(IMGLTEST_FWText, IMGLTEST_MARKING_BYTE, textSize);
    BCM_MemSet(IMGLTEST_FWData, IMGLTEST_MARKING_BYTE, dataSize);
    BCM_MemSet(IMGLTEST_Key, IMGLTEST_MARKING_BYTE, sizeof(IMGLTEST_Key));

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
    int32_t ret;
    BCM_EventMaskType mask;
    BCM_EventMaskType allMask;
    BCM_StateType state = BCM_STATE_UNINIT;
    BCM_StateType prevState;
    int32_t exitTask = FALSE;

    IMGLTEST_Init(IMGL_Mmap0, 0xFF00);

    BCM_MemSet(&__imgl_context_start__[0], 0U, (uint32_t)&__imgl_context_end__[0] - (uint32_t)&__imgl_context_start__[0] + 1);

    BCM_MemSet(IMGL_FetchModule.context, 0U, sizeof(MODULE_ContextType));

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
                    }
                    break;
                case BCM_STATE_INIT:
                    ret = MODULE_InitStateHandler(IMGL_FetchModuleFnTable, MODULE_COUNT_MAX);
                    if (BCM_ERR_OK == ret) {
                        state = BCM_STATE_READY;
                    } else if (BCM_ERR_BUSY != ret) {
                        IMGLTEST_result = BCM_ERR_INVAL_STATE;
                        exitTask = TRUE;
                    }
                    break;
                case BCM_STATE_READY:
                    exitTask = TRUE;
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

    IMGLTEST_ValidateContent(0xFFF1, IMGLTEST_FWText + sizeof(IMGL_ImgHdrType), 0UL);
    IMGLTEST_ValidateContent(0xFFF2, IMGLTEST_FWData + sizeof(IMGL_ImgHdrType), 0UL);

    if (BCM_AT_EXECUTING == IMGLTEST_result) {
        IMGLTEST_result = BCM_ERR_OK;
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
