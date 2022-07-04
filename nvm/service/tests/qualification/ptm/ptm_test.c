/*****************************************************************************
 Copyright 2018-2021 Broadcom Limited.  All rights reserved.

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
#include <msg_queue.h>
#include <ptm.h>
#include <osil/bcm_osil.h>
#include "ee.h"
#include <ptm_test.h>

#define PTM_IMG_ID                  (0xC000)
#define PTM_IMG_MAGIC               (0x544D5450)
#define IMG_BUF_SIZE                (1024)
#define CLIENT_EVENT_MASK           (PTMTestEvent)

#define GetModuleLogLevel() ULOG_LVL_ERROR

static uint8_t ImgBuf[IMG_BUF_SIZE];
static int32_t PTMQT1_Result = BCM_AT_NOT_STARTED;
static uint32_t nvmTestId = PTM_TESTID_QT;

static uint8_t TestBuffer[4UL] = {0xAA, 0xBB, 0xCC, 0xDD};
static uint8_t OutBuffer[4UL];

void PTMQT_Execute(){
    BCM_EventMaskType mask;
    int32_t status;
    PTM_SizeType imgSz;
    uint32_t *magic;
    int32_t ret = BCM_ERR_OK;
    const MSGQ_MsgHdrType *pHdr = NULL;

    ULOG_ERR("PTM TEST: START\n");

    ret = PTM_LoadImg(IMGL_CHANNEL_IDX0, PTBL_ID_SYSCFG, PTM_IMG_ID, 0UL, ImgBuf, 0UL, IMG_BUF_SIZE,
            CLIENT_EVENT_MASK, &pHdr);

    if (ret == BCM_ERR_OK) {
        BCM_WaitEvent(CLIENT_EVENT_MASK);
        BCM_GetEvent(PTMQT_Task, &mask);
        if ((mask & CLIENT_EVENT_MASK) == CLIENT_EVENT_MASK) {
            BCM_ClearEvent(CLIENT_EVENT_MASK);
        }
        status = PTM_GetStatus(pHdr, &imgSz);
        if (status == BCM_ERR_OK) {
            /* check for magic */
            magic = (uint32_t *)&ImgBuf[0];
            if (*magic != PTM_IMG_MAGIC) {
                ULOG_ERR("PTM TEST: INVALID IMAGE MAGIC\n");
                ret = BCM_ERR_INVAL_MAGIC;
                goto end;
            }
        } else {
            ULOG_ERR("PTM TEST: PTM_GetStatus Failed\n");
            ret = BCM_ERR_UNKNOWN;
            goto end;
        }
    } else {
        ULOG_ERR("PTM TEST: PTM_LoadImg failed\n");
        goto end;
    }

    ret = PTM_WriteUserData(0xBC10, TestBuffer, sizeof(TestBuffer),
            CLIENT_EVENT_MASK, &pHdr);

    if (ret == BCM_ERR_OK) {
        BCM_WaitEvent(CLIENT_EVENT_MASK);
        BCM_GetEvent(PTMQT_Task, &mask);
        if ((mask & CLIENT_EVENT_MASK) == CLIENT_EVENT_MASK) {
            BCM_ClearEvent(CLIENT_EVENT_MASK);
        }
        status = PTM_GetStatus(pHdr, &imgSz);
        if (status == BCM_ERR_OK) {
            ret = BCM_ERR_OK;
        } else {
            ULOG_ERR("PTM TEST: PTM_GetStatus[PTM_WriteUserData] Failed\n");
            ret = BCM_ERR_UNKNOWN;
            goto end;
        }
    } else {
        ULOG_ERR("PTM TEST: PTM_WriteUserData failed\n");
        goto end;
    }

    ret = PTM_LoadUserData(0xBC10, OutBuffer, sizeof(OutBuffer),
            CLIENT_EVENT_MASK, &pHdr);

    if (ret == BCM_ERR_OK) {
        BCM_WaitEvent(CLIENT_EVENT_MASK);
        BCM_GetEvent(PTMQT_Task, &mask);
        if ((mask & CLIENT_EVENT_MASK) == CLIENT_EVENT_MASK) {
            BCM_ClearEvent(CLIENT_EVENT_MASK);
        }
        status = PTM_GetStatus(pHdr, &imgSz);
        if (status == BCM_ERR_OK) {
            if (OutBuffer[0] == 0xAAU) {
                ret = BCM_ERR_OK;
            }
        } else {
            ULOG_ERR("PTM TEST: PTM_GetStatus[PTM_LoadUserData] Failed\n");
            ret = BCM_ERR_UNKNOWN;
            goto end;
        }
    } else {
        ULOG_ERR("PTM TEST: PTM_ReadUserData failed\n");
        goto end;
    }

    ret = PTM_EraseUserData(0xBC10, CLIENT_EVENT_MASK, &pHdr);

    if (ret == BCM_ERR_OK) {
        BCM_WaitEvent(CLIENT_EVENT_MASK);
        BCM_GetEvent(PTMQT_Task, &mask);
        if ((mask & CLIENT_EVENT_MASK) == CLIENT_EVENT_MASK) {
            BCM_ClearEvent(CLIENT_EVENT_MASK);
        }
        status = PTM_GetStatus(pHdr, &imgSz);
        if (status == BCM_ERR_OK) {
            ret = BCM_ERR_OK;
        } else {
            ULOG_ERR("PTM TEST: PTM_GetStatus[PTM_WriteUserData] Failed\n");
            ret = BCM_ERR_UNKNOWN;
            goto end;
        }
    } else {
        ULOG_ERR("PTM TEST: PTM_WriteUserData failed\n");
        goto end;
    }

    ret = PTM_LoadUserData(0xBC10, OutBuffer, sizeof(OutBuffer),
            CLIENT_EVENT_MASK, &pHdr);

    if (ret == BCM_ERR_OK) {
        BCM_WaitEvent(CLIENT_EVENT_MASK);
        BCM_GetEvent(PTMQT_Task, &mask);
        if ((mask & CLIENT_EVENT_MASK) == CLIENT_EVENT_MASK) {
            BCM_ClearEvent(CLIENT_EVENT_MASK);
        }
        status = PTM_GetStatus(pHdr, &imgSz);
        if (status != BCM_ERR_OK) {
            ret = BCM_ERR_OK;
        } else {
            ULOG_ERR("PTM TEST: PTM_GetStatus[PTM_LoadUserData] Failed\n");
            ret = BCM_ERR_UNKNOWN;
            goto end;
        }
    } else {
        ULOG_ERR("PTM TEST: PTM_ReadUserData failed\n");
        goto end;
    }

end:
    ULOG_ERR("PTM TEST: END\n");
    PTMQT1_Result = ret;
}

TASK(PTMQT_Task)
{
    if (PTM_TESTID_QT == nvmTestId) {
        PTMQT_Execute();
    }
#ifdef ENABLE_NVM_IT
    else if (NVM_TESTID_IT == nvmTestId) {
        NVMIT_Execute();
    }
#endif /* ENABLE_NVM_IT */
    BCM_TerminateTask();
}

int32_t BCM_ExecuteAT(uint32_t aIndex)
{
    int32_t retVal = BCM_ERR_OK;

    switch(aIndex)
    {
    case PTM_IT1:
        nvmTestId = PTM_TESTID_QT;
        if (BCM_AT_NOT_STARTED == PTMQT1_Result) {
            PTMQT1_Result = BCM_AT_EXECUTING;
            BCM_ActivateTask(PTMQT_Task);
        }
        break;
#ifdef ENABLE_NVM_IT
    case NVM_IT:
        nvmTestId = NVM_TESTID_IT;
        BCM_ActivateTask(PTMQT_Task);
        break;
#endif /* ENABLE_NVM_IT */
    default:
        retVal = BCM_AT_NOT_AVAILABLE;
        break;
    }
    return retVal;
}

int32_t BCM_GetResultAT(uint32_t aIndex)
{
    int32_t retVal;

    switch(aIndex)
    {
    case PTM_IT1:
        retVal = PTMQT1_Result;
        break;
#ifdef ENABLE_NVM_IT
    case NVM_IT:
        retVal = NVMIT_GetResult();
        break;
#endif /* ENABLE_NVM_IT */
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
