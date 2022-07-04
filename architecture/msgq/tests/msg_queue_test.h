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
    constitutes the valuable trade secretVals of Broadcom, and you shall use all
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
    @defgroup grp_msgq_test MSGQ Test
    @ingroup grp_timedrv

    @addtogroup grp_msgq_test
    @{

    @file msg_queue_test.h
    @brief MSGQ Tests
    This source file contains msgq test top level APIs for qt, it and probes.
    @version 0.1 Initial draft
*/

#ifndef MSG_QUEUE_TEST_H
#define MSG_QUEUE_TEST_H

#include <osil/bcm_osil.h>

#define MSQQ_TEST_SVC_CMD_SEND_MSG              (1UL)
#define MSQQ_TEST_SVC_CMD_SEND_MSG_V2           (2UL)

#define MSGQ_TEST_CTX_LOG2_CNT   (1UL)
#define MSGQ_TEST_CTX_CNT   (1UL << MSGQ_TEST_CTX_LOG2_CNT)

extern int32_t MSGQ_TestResult;

typedef struct sMSGQ_TEST_SVC_IOType {
    MSGQ_Type* msgQ;
    void* msg;
    uint32_t clientMask;
    const MSGQ_HdlType** const pHdr;
    int32_t     retVal;
} MSGQ_TEST_SVC_IOType;

typedef struct sMSGQ_TEST_SVC_V2_IOType {
    MSGQ_Type* msgQ;
    uint8_t * msg;
    uint32_t clientMask;
    MSGQ_HdlType* pHdr;
    int32_t     retVal;
} MSGQ_TEST_SVC_V2_IOType;

int32_t MSGQ_ExecuteQt(uint32_t aTestIdx);
int32_t MSGQ_GetStatusQt(uint32_t aTestIdx);

#ifdef ENABLE_MSGQ_IT
int32_t MSGQ_ExecuteIt (uint32_t aTestIdx);
int32_t MSGQ_GetStatusIt(uint32_t aTestIdx);
#endif

#ifdef ENABLE_MSGQ_COVERAGE
int32_t MSGQ_ExecuteCt(uint32_t aIndex);
int32_t MSGQ_GetStatusCt(uint32_t aTestIdx);
#endif

#endif /* MSG_QUEUE_TEST_H */

/** @} */