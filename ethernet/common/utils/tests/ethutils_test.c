/*****************************************************************************
 Copyright 2022 Broadcom Limited.  All rights reserved.

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
    @addtogroup grp_ethutils_test
    @{

    @file ethutils_test.c
    @brief Ethernet Utils Test
    This source file contains the Test for Ethernet Utils
    @version 0.1 Initial version
*/

#include "ee.h"
#include <bcm_err.h>
#include <console.h>
#include <bcm_test.h>
#include <bcm_utils.h>
#include <osil/bcm_osil.h>
#include "ethutils.h"
#include <module_helper.h>
#include <ulog.h>
#include <mcu.h>

/**
    @name Component Qualification Test Sequence IDs
    @{
    @brief Component Qualification Test Sequence IDs
*/
#define BRCM_SWQTDSGN_ETHUTILS_QTSEQUENCE1_PROC      (0xF0U)   /**< @brief #ETHUTILS_QTSequence1  */
/** @} */

#define GetModuleLogLevel() ULOG_LVL_VERBOSE

static volatile int32_t ethutils_qt_result = BCM_AT_NOT_STARTED;

TASK(TestTask)
{
    uint8_t buffer[128];
#if (ETHUTILS_NUM_PORTS > 0UL)
    uint32_t isStackingPort;
    uint32_t port;
#endif
    MCU_InfoType  originalStackInfo = {0U};
    MCU_InfoType  newStackInfo = {0U};
    int32_t       retVal    = MCU_GetInfo(&originalStackInfo);

    BCM_MemCpy(&newStackInfo, &originalStackInfo, sizeof(MCU_InfoType));

    ETHUTILS_Init();

    newStackInfo.stackingEn = 1U;
    newStackInfo.mstSlvMode = MCU_DEVICE_MASTER ;
    newStackInfo.stackPort0 = 6U;
    newStackInfo.stackPort1 = 5U;
    retVal = MCU_SetInfo(&newStackInfo);
    if (retVal != BCM_ERR_OK) {
        ethutils_qt_result = retVal;
        goto done;
    }

    ETHUTILS_Init();

    newStackInfo.mstSlvMode = MCU_DEVICE_SLAVE_1;
    newStackInfo.stackPort0 = 8U;
    newStackInfo.stackPort1 = 6U;
    retVal = MCU_SetInfo(&newStackInfo);
    if (retVal != BCM_ERR_OK) {
        ethutils_qt_result = retVal;
        goto done;
    }

    ETHUTILS_Init();

    retVal = MCU_SetInfo(&originalStackInfo);
    if (retVal != BCM_ERR_OK) {
        ethutils_qt_result = retVal;
        goto done;
    }

    ETHUTILS_Init();

    ETHUTILS_CreateBootFilename (buffer, 1U, 1U, 1000UL, 0x20000UL, 0UL);
    ETHUTILS_CreateBootFilename (buffer, 1U, 3U, 1000UL, 0x20000UL, 0UL);

#if (ETHUTILS_NUM_PORTS > 0UL)
    port = ETHUTILS_ConvertToLocalPort(0UL, &isStackingPort);
    if (port != 0UL) {
        ethutils_qt_result = BCM_ERR_UNKNOWN;
        goto done;
    }

    port = ETHUTILS_ConvertToLocalPort(1000UL, &isStackingPort);
    if (port != ETHUTILS_INVALID_PORT) {
        ethutils_qt_result = BCM_ERR_UNKNOWN;
        goto done;
    }

    port = ETHUTILS_ConvertToUnifiedPort(0UL, &isStackingPort);
    if (port != 0UL) {
        ethutils_qt_result = BCM_ERR_UNKNOWN;
        goto done;
    }

    port = ETHUTILS_ConvertToUnifiedPort(1000UL, &isStackingPort);
    if (port != ETHUTILS_INVALID_PORT) {
        ethutils_qt_result = BCM_ERR_UNKNOWN;
        goto done;
    }

    (void)ETHUTILS_ConvertToLocalPortMask(0x8001U);
    (void)ETHUTILS_ConvertToUnifiedPortMask(0x8001U);
#endif

    if (BCM_AT_EXECUTING == ethutils_qt_result) {
        ULOG_INFO("\n Test PASSED \n");
        ethutils_qt_result = BCM_ERR_OK;
    }

done:
    BCM_TerminateTask();
}

int32_t BCM_ExecuteAT(uint32_t aIndex)
{
    int32_t ret = BCM_AT_NOT_AVAILABLE;
    if (1UL == aIndex) {
        ethutils_qt_result = BCM_AT_EXECUTING;
        BCM_ActivateTask(TestTask);
        ret = BCM_ERR_OK;
    }

    return ret;
}

int32_t BCM_GetResultAT(uint32_t aIndex)
{
    int32_t ret = BCM_AT_NOT_AVAILABLE;

    if (1UL == aIndex) {
        ret = ethutils_qt_result;
    }

    return ret;
}

/** @} */
