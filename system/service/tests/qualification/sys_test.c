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
#include <bcm_utils.h>
#include <bcm_test.h>
#include <osil/bcm_osil.h>
#include <rpc_interface.h>
#include <system_osil.h>
#include <system_module_v2.h>

static int32_t SYS_MODQTResult;

const RPC_InterfaceType* const * RPC_GetModInterfaces()
{
    return NULL;
}

TASK(SYS_MODTestTask)
{
    int32_t  retVal;
	uint32_t tempU32 = 0UL;

	SYS_MODQTResult = BCM_AT_EXECUTING;

	if (NULL == SYSTEM_Service.client.cmdQ.getMsg(0UL)) {
		retVal = BCM_ERR_UNKNOWN;
		goto done;
	}

	if (NULL == SYSTEM_Service.server.cmdQ.getMsg(0UL)) {
		retVal = BCM_ERR_UNKNOWN;
		goto done;
	}
	if (BCM_ERR_NOSUPPORT != SYSTEM_Service.server.getResp(1ULL, 0UL, 0UL, (uint8_t *)&tempU32, &tempU32)) {
		retVal = BCM_ERR_UNKNOWN;
		goto done;
	}
	if (BCM_ERR_OK != SYSTEM_Service.server.asyncMsg(1UL, NULL, 0UL, &tempU32)) {
		retVal = BCM_ERR_UNKNOWN;
		goto done;
	}

	if (0UL == SYSTEM_Service.server.getEventMask()) {
		retVal = BCM_ERR_UNKNOWN;
		goto done;
	}

	if (BCM_ERR_INVAL_PARAMS != SYSTEM_Service.server.sendCmd(0UL, (SYSTEM_RPC_MSG_PAYLOAD_SZ + 1UL), NULL, NULL, NULL)) {
		retVal = BCM_ERR_UNKNOWN;
		goto done;
	}

	if (BCM_ERR_INVAL_PARAMS != SYSTEM_Service.server.sendCmd(0UL, 0UL, NULL, NULL, NULL)) {
		retVal = BCM_ERR_UNKNOWN;
		goto done;
	}

	if (BCM_ERR_INVAL_PARAMS != SYSTEM_Service.server.sendCmd(0UL, 0UL, (const uint8_t *)&tempU32, NULL, NULL)) {
		retVal = BCM_ERR_UNKNOWN;
		goto done;
	}

	if (BCM_ERR_INVAL_PARAMS != SYSTEM_Service.server.sendCmd(0UL, 0UL, (const uint8_t *)&tempU32, (BCM_HandleType *)&tempU32, NULL)) {
		retVal = BCM_ERR_UNKNOWN;
		goto done;
	}

	retVal = BCM_ERR_OK;
done:
    SYS_MODQTResult = retVal;
    BCM_TerminateTask();
}

int32_t BCM_ExecuteAT(uint32_t aIndex)
{
    int32_t retVal;

    if (1UL == aIndex) {
        if (BCM_AT_EXECUTING != SYS_MODQTResult) {
			SYS_MODQTResult = BCM_AT_NOT_STARTED;
            retVal = BCM_ActivateTask(SYS_MODTestTask);
            if (BCM_ERR_OK != retVal) {
                SYS_MODQTResult = BCM_AT_NOT_STARTED;
                retVal = BCM_AT_NOT_STARTED;
            }
        } else {
            retVal = BCM_ERR_OK;
        }
    } else {
        retVal = BCM_AT_NOT_AVAILABLE;
    }

    return retVal;
}

int32_t BCM_GetResultAT(uint32_t aIndex)
{
    int32_t ret = BCM_AT_NOT_AVAILABLE;

    if (1UL == aIndex) {
        ret = SYS_MODQTResult;
    }
    return ret;
}

void APP_Init()
{
}
