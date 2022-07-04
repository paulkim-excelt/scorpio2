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
#include <bcm_err.h>
#include <bcm_test.h>
#include "ee.h"

#include "msg_queue_test.h"

extern void QUEUE_ExecuteIT(void);
extern int32_t QUEUE_GetResultIT(void);

void MsgQQT1_Start(void);
void MsgQQT2_Start(void);
void MsgQQT3_Start(void);
void MsgQQT4_Start(void);

int32_t MsgQQT1_GetResult(void);
int32_t MsgQQT2_GetResult(void);
int32_t MsgQQT3_GetResult(void);
int32_t MsgQQT4_GetResult(void);

#define MSGQ_EN_NOTIF_IT1   (1UL)
#define MSGQ_DIS_NOTIF_IT2  (2UL)
#define MSGQ_DIS_NOTIF_IT3  (3UL)
#define MSGQ_DIS_NOTIF_IT4  (4UL)
#ifdef ENABLE_MSGQ_IT
#define MSGQ_IT1            (5UL)
#endif /* ENABLE_MSGQ_IT */

void SVC_TestSvcHandler(uint32_t aMagicID, uint32_t aCmd, uint8_t *aSysIO)
{
    MSGQ_TEST_SVC_IOType *msgqTestSvc;
    msgqTestSvc = (void *)aSysIO;

    MSGQ_TEST_SVC_V2_IOType *msgqTestSvcV2;
    msgqTestSvcV2 = (void *)aSysIO;

    switch (aCmd) {
        case MSQQ_TEST_SVC_CMD_SEND_MSG:
            msgqTestSvc->retVal = MSGQ_SendMsg(msgqTestSvc->msgQ,
                                               msgqTestSvc->msg,
                                               msgqTestSvc->clientMask,
                                               msgqTestSvc->pHdr);
            break;
        case MSQQ_TEST_SVC_CMD_SEND_MSG_V2:
            msgqTestSvcV2->retVal = MSGQ_SendMsgv2(msgqTestSvcV2->msgQ,
                                                   msgqTestSvcV2->msg,
                                                   msgqTestSvcV2->clientMask,
                                                   msgqTestSvcV2->pHdr);
            break;
        default:
            msgqTestSvc->retVal = BCM_ERR_INVAL_PARAMS;
            break;
    }
}

int32_t BCM_ExecuteAT(uint32_t aIndex)
{
    int32_t retVal = BCM_ERR_OK;
    uint32_t testType;

    testType = ((aIndex & BCM_TEST_SEQ_TYPE_MASK) >> (BCM_TEST_SEQ_TYPE_SHIFT));

    switch (testType) {
        case BCM_TEST_SEQ_TYPE_QT:
            retVal = MSGQ_ExecuteQt(aIndex);
            break;
#ifdef ENABLE_MSGQ_IT
        case BCM_TEST_SEQ_TYPE_IT:
            retVal = MSGQ_ExecuteIt(aIndex);
            break;
#endif /* ENABLE_MSGQ_IT */
#ifdef ENABLE_MSGQ_COVERAGE
        case BCM_TEST_SEQ_TYPE_COV:
            retVal = MSGQ_ExecuteCt(aIndex);
            break;
        case BCM_TEST_SEQ_TYPE_PRB:
            retVal = MSGQ_ExecuteCt(aIndex);
            break;
#endif /* ENABLE_MSGQ_COVERAGE */
        default:
            retVal = BCM_AT_NOT_AVAILABLE;
            break;
    }

    return retVal;
}

int32_t BCM_GetResultAT(uint32_t aIndex)
{
    int32_t retVal = BCM_AT_NOT_AVAILABLE;
    uint32_t testType;

    testType = ((aIndex & BCM_TEST_SEQ_TYPE_MASK) >> (BCM_TEST_SEQ_TYPE_SHIFT));

    switch (testType) {
        case BCM_TEST_SEQ_TYPE_QT:
            retVal = MSGQ_GetStatusQt(aIndex);
            break;
#ifdef ENABLE_MSGQ_IT
        case BCM_TEST_SEQ_TYPE_IT:
            retVal = MSGQ_GetStatusIt(aIndex);
            break;
#endif /* ENABLE_MSGQ_IT */
#ifdef ENABLE_MSGQ_COVERAGE
        case BCM_TEST_SEQ_TYPE_COV:
            retVal = MSGQ_GetStatusCt(aIndex);
            break;
        case BCM_TEST_SEQ_TYPE_PRB:
            retVal = MSGQ_GetStatusCt(aIndex);
            break;
#endif /* ENABLE_MSGQ_COVERAGE */
        default:
            retVal = BCM_AT_NOT_AVAILABLE;
            break;
    }

    return retVal;
}
