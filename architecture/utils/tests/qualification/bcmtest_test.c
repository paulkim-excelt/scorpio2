/*****************************************************************************
 Copyright 2020-2021 Broadcom Limited.  All rights reserved.

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
/**
    @addtogroup grp_memtest_qt
    @{

    @file memtest_test.c
    @brief Qualification Test for memory testing API's

    @version 0.1 Initial Version
*/

#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <console.h>
#include <shell.h>
#include <ulog.h>
#include <atomic.h>
#include <bcm_err.h>
#include <bcm_test.h>

#include "utils_test.h"
#include "bcm_test_qt.h"

#define GetModuleLogLevel()     ULOG_LVL_INFO

static volatile BCM_ATStateType BcmTestQT_Result = BCM_AT_NOT_STARTED;

#define BCMTEST_MARK_ERR(ret)                                   \
    if (BCM_AT_EXECUTING == BcmTestQT_Result) {                 \
        ULOG_ERR("\nError: %d \t line %d\n", ret ,__LINE__);    \
        BcmTestQT_Result = ret;                                 \
    }

int32_t BcmTestQT_Start(void)
{
    BcmTestQT_Result = BCM_AT_EXECUTING;

    /* BRCM_SWQTST_BCM_TEST_BCM_TEST_SEQ */

    /* BRCM_SWQTST_BCM_TEST_TEST_START */
    {
        BCM_TestStart(BCM_UTL_ID, BCM_TEST_TYPE_QT);
        ULOG_INFO("BRCM_SWQTST_BCM_TEST_TEST_START: Pass\n");
    }

    /* BRCM_SWQTST_BCM_TEST_GET_PROBE_STATUS_EN*/
    {
        if (BCM_TEST_PROBE_STATUS_EN != BCM_GetTestProbeStatus()) {
            BCMTEST_MARK_ERR(BCM_ERR_UNKNOWN);
        }
    }

    /* BRCM_SWQTST_BCM_TEST_SET_PROBE_STATUS_DIS */
    {
        BCM_SetTestProbeStatus(BCM_TEST_PROBE_STATUS_DIS);
    }

    /* BRCM_SWQTST_BCM_TEST_GET_PROBE_STATUS_DIS */
    {
        if (BCM_TEST_PROBE_STATUS_DIS != BCM_GetTestProbeStatus()) {
            BCMTEST_MARK_ERR(BCM_ERR_UNKNOWN);
        }
    }

    /* BRCM_SWQTST_BCM_TEST_SET_TEST_SEQ, BRCM_SWQTST_BCM_TEST_GET_TEST_SEQ */
    {
        BCM_SetTestSeq(0x1U);
        if (0x1U != BCM_GetTestSeq()) {
            BCMTEST_MARK_ERR(BCM_ERR_UNKNOWN);
        }
    }

    /* BRCM_SWQTST_BCM_TEST_SET_TEST_CASE , BRCM_SWQTST_BCM_TEST_GET_TEST_CASE  */
    {
        BCM_SetTestCase(0x5U);
        if (0x5U != BCM_GetTestCase()) {
            BCMTEST_MARK_ERR(BCM_ERR_UNKNOWN);
        }
    }

    /* BRCM_SWQTST_BCM_TEST_SET_TEST_RESULT */
    {
        BCM_SET_TEST_RESULT(BCM_TEST_RESULT_PASS, 0xabcd, 0x1234);
    }

     /* BRCM_SWQTST_BCM_TEST_SET_TEST_SEQ, BRCM_SWQTST_BCM_TEST_GET_TEST_SEQ */
    {
        BCM_SetTestSeq(0x2U);
        if (0x2U != BCM_GetTestSeq()) {
            BCMTEST_MARK_ERR(BCM_ERR_UNKNOWN);
        }
    }

    /* BRCM_SWQTST_BCM_TEST_SET_TEST_CASE , BRCM_SWQTST_BCM_TEST_GET_TEST_CASE  */
    {
        BCM_SetTestCase(0x5U);
        if (0x5U != BCM_GetTestCase()) {
            BCMTEST_MARK_ERR(BCM_ERR_UNKNOWN);
        }
    }

    /* BRCM_SWQTST_BCM_TEST_SET_TEST_RESULT */
    {
        BCM_SET_TEST_RESULT(BCM_TEST_RESULT_FAIL, 0x11U, 0x22U, 0x33U, 0x44U);
    }

    /* BRCM_SWQTST_BCM_TEST_SET_TEST_CASE , BRCM_SWQTST_BCM_TEST_GET_TEST_CASE  */
    {
        BCM_SetTestCase(0x6U);
        if (0x6U != BCM_GetTestCase()) {
            BCMTEST_MARK_ERR(BCM_ERR_UNKNOWN);
        }
    }

    /* BRCM_SWQTST_BCM_TEST_SET_TEST_RESULT_NO_CUST_DATA */
    {
        BCM_SET_TEST_RESULT(BCM_TEST_RESULT_PASS);
    }

    /* BRCM_SWQTST_BCM_TEST_BCM_TEST_STOP */
    {
        BCM_TestStop();
        ULOG_INFO("BRCM_SWQTST_BCM_TEST_BCM_TEST_STOP: Pass\n");
    }

    if (BCM_AT_EXECUTING == BcmTestQT_Result) {
        BcmTestQT_Result = BCM_ERR_OK;
    }

    return 0;
}

int32_t BcmTestQT_GetResult(void)
{
    return BcmTestQT_Result;
}

/** @} */
