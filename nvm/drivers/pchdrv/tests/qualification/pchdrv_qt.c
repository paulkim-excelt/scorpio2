/*****************************************************************************
 Copyright 2021-2022 Broadcom Limited.  All rights reserved.

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
#include <osil/bcm_osil.h>
#include <pchdrv.h>
#include <osil/pchdrv_osil.h>
#include <mpu.h>
#include <svc.h>
#include <compiler.h>
#include <mpu.h>
#include <patch_routines.h>
#ifdef __CORTEX_MX__
#include <cortex_mx.h>

#define MPU_Disable()   CORTEX_MX_MPUDisable()
#define MPU_Enable()    CORTEX_MX_MPUEnable()
#endif

#define PCHT_PATCH_ROUT_ARG(argType0, argType1, argType2, argType3) \
                            (((argType0)<<6U) | ((argType1)<<4U)    \
                            |((argType2)<<2U) | ((argType3)<<0U))   \

#define PCHT_PATCH_ROUT_HDR(argTypes, progLen, loadOffset) \
                                (((argTypes)<<24U) | ((progLen)<<16U) | (loadOffset))

#define PCHT_PATCH_SEQ_HDR(compId, patchId, patchIdx)     (((compId)<<16U)|((patchId)<<8U)|((patchIdx)))

#define PCHT_TEST_COMPID0 0x10AA
#define PCHT_TEST_COMPID1 0x20BB

typedef struct sPCHT_TestDataType {
    uint16_t compId;
    uint8_t patchId;
    uint32_t result[5*3];
} PCHT_TestDataType;

static int32_t PCHT_TestStatus;
static uint32_t PCHT_Result[3][5];
uint32_t PCHT_ErrorLine;
uint32_t PCHT_LastExeLine;

#define PCHT_TEST_ASSERT(x)                    \
    do {                                       \
        if(!(x)) {                             \
            PCHT_TestStatus = BCM_ERR_UNKNOWN; \
            PCHT_ErrorLine = __LINE__;         \
            goto end;                          \
        }  else {                              \
            PCHT_LastExeLine = __LINE__;       \
        }                                      \
    } while(0U)

static uint32_t PCHT_PatchBin[128] = {
    PCHT_PATCH_SEQ_HDR(PCHT_TEST_COMPID0, 0, 0),
    (uint32_t)PCHT_Result[0], /* Arg row */
    0x04030201UL,             /* Arg row */
    0x08070605UL,             /* Arg row */
    0x00000000UL,             /* Invalidate row */

    PCHT_PATCH_SEQ_HDR(PCHT_TEST_COMPID0, 1, 1),
    (uint32_t)PCHT_Result[1], /* Arg row */
    0x40302010UL,              /* Arg row */
    0x00000000UL,              /* Invalidate row */

    PCHT_PATCH_SEQ_HDR(PCHT_TEST_COMPID1, 1, 0),
    (uint32_t)PCHT_Result[0], /* Arg row */
    0x40302010UL,              /* Arg row */
    0x80706050UL,              /* Arg row */
    0x00000000UL,              /* Invalidate row */

    PCHT_PATCH_SEQ_HDR(PCHT_TEST_COMPID1, 1, 1),
    (uint32_t)PCHT_Result[1], /* Arg row */
    0x44332211UL,              /* Arg row */
    0x00000001UL,              /* Invalidate row */

    PCHT_PATCH_SEQ_HDR(PCHT_TEST_COMPID1, 1, 2),
    (uint32_t)PCHT_Result[2], /* Arg row */
    0x44332211UL,              /* Arg row */
    0x88776655UL,              /* Arg row */
    0xCCBBAA99UL,              /* Arg row */
    0x00000000UL,              /* Invalidate row */

    /* patch routine instructions will be copied here */
};

static const PCHT_TestDataType PCHT_TestData[] = {
    {
        PCHT_TEST_COMPID0, 0,
        {
            0x11111111UL, 0x04030201UL, 0x00000605UL, 0x00000007UL, 0x0403080DUL,
            0x00000000UL, 0x00000000UL, 0x00000000UL, 0x00000000UL, 0x00000000UL,
            0x00000000UL, 0x00000000UL, 0x00000000UL, 0x00000000UL, 0x00000000UL,
        }
    },
    {
        PCHT_TEST_COMPID0, 1,
        {
            0x00000000UL, 0x00000000UL, 0x00000000UL, 0x00000000UL, 0x00000000UL,
            0x22222222UL, 0x00002010UL, 0x00000030UL, 0x00000000UL, 0xFFFFDFDFUL,
            0x00000000UL, 0x00000000UL, 0x00000000UL, 0x00000000UL, 0x00000000UL,
        }
    },
    {
        PCHT_TEST_COMPID1, 1,
        {
            0x11111111UL, 0x40302010UL, 0x00006050UL, 0x00000070UL, 0x403080D0UL,
            0x00000000UL, 0x00000000UL, 0x00000000UL, 0x00000000UL, 0x00000000UL,
            0x33333333UL, 0x44332211UL, 0x00006655UL, 0xAA998877UL, 0xEEBBEE77UL,
        }
    },
};

static void PCHT_PatchExecTest(void)
{
    int32_t ret;
    uint32_t test;
    for (test = 0U; test < BCM_ARRAY_LEN(PCHT_TestData); test++) {
        uint32_t i;
        BCM_MemSet(PCHT_Result, 0U, sizeof(PCHT_Result));
        ret = PATCH_ExecPatchSeq(PCHT_TestData[test].compId, PCHT_TestData[test].patchId);
        PCHT_TEST_ASSERT(ret == BCM_ERR_OK);

        for (i = 0U; i < BCM_ARRAY_LEN(PCHT_TestData[test].result); i++) {
            if (PCHT_TestData[test].result[i] != ((uint32_t *)PCHT_Result)[i]) {
                break;
            }
        }
        PCHT_TEST_ASSERT(BCM_ARRAY_LEN(PCHT_TestData[test].result) == i);
    }
    end:;
}

void SVC_TestSvcHandler(uint32_t aMagicID, uint32_t aCmd, uint8_t *aSysIO)
{
    if (0U == aCmd) {
        MPU_Disable();
    } else if (1U == aCmd) {
        MPU_Enable();
    } else if (2U == aCmd) {
        PCHT_PatchExecTest();
    }
}

uint32_t PCHT_CopyRoutine(PATCH_PatchFuncType aFunc,
                          uint32_t aArgType,
                          uint32_t aLoadOffset,
                          uint32_t aSize,
                          uint32_t aIndex)
{
    uint32_t index = aIndex;
    intptr_t srcAddr;
    PCHT_PatchBin[index] = PCHT_PATCH_ROUT_HDR(aArgType, aSize/4, aLoadOffset);
    index -= aSize/4;
    srcAddr = ((intptr_t)aFunc)&~3U; /* Make it word aligned */
    BCM_MemCpy(PCHT_PatchBin+index, (void *)srcAddr, aSize);
    return index - 1;
}

int32_t PCHT_ExecuteQt(uint32_t aIndex)
{
    int32_t ret;
    uint32_t index;

    /* Copy patch routines from endo of the array */
    index = BCM_ARRAY_LEN(PCHT_PatchBin)-1;
    index = PCHT_CopyRoutine(PCHT_PatchRoutine0, PCHT_PATCH_ROUT_ARG(3, 3, 2, 1),    0,  80, index);
    index = PCHT_CopyRoutine(PCHT_PatchRoutine1, PCHT_PATCH_ROUT_ARG(3, 2, 1, 0), 32*4, 100, index);
    index = PCHT_CopyRoutine(PCHT_PatchRoutine2, PCHT_PATCH_ROUT_ARG(3, 3, 2, 3), 64*4, 120, index);

    PCHT_TestStatus = BCM_ERR_OK;
    SVC_RunTestSvc(0, NULL);
    ret = PATCH_Init(PCHT_PatchBin, BCM_ARRAY_LEN(PCHT_PatchBin));
    SVC_RunTestSvc(1, NULL); /* Enable MPU */
    PCHT_TEST_ASSERT(ret == BCM_ERR_OK);

    PCHT_PatchExecTest();

     /* Execute PCHT_PatchExecTest() from SVC context */
    SVC_RunTestSvc(2, NULL);

    ret = PATCH_DeInit();
    PCHT_TEST_ASSERT(ret == BCM_ERR_OK);
end:
    return PCHT_TestStatus;
}
