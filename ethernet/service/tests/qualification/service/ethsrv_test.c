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
    @addtogroup grp_ethsrv_test
    @{

    @file ethsrv_test.c
    @brief Ethernet Service Test
    This source file contains the Test for Ethernet Service
    @version 0.1 Initial version
*/

#include "ee.h"
#include <bcm_err.h>
#include <console.h>
#include <bcm_test.h>
#include <osil/bcm_osil.h>
#include "ethernet_service.h"
#include <module_helper.h>
#include <time_module_osil.h>
#include <ulog.h>
#include <ethernet_nif.h>
#include <mcu.h>

/**
    @name Component Qualification Test Sequence IDs
    @{
    @brief Component Qualification Test Sequence IDs
*/
#define BRCM_SWQTDSGN_ETHSRV_QTSEQUENCE1_PROC      (0xF0U)   /**< @brief #ETHSRV_QTSequence1  */
/** @} */

#define GetModuleLogLevel() ULOG_LVL_VERBOSE

static volatile int32_t ethsrv_qt_result = BCM_AT_NOT_STARTED;

TASK(TestTask)
{
    int32_t ret;
#if 0
    BCM_HandleType handle;
    ETHER_MDIOAccessType cmd;
    uint32_t forwardToSlaves = 0UL;
    uint32_t replyLen;
    uint32_t mask;
#endif

    ULOG_INFO("\n Test Task started\n");

    do {
        ret = ETHERNET_Service.client.resetStateHandler(BCM_STATE_INIT);
    } while (ret == BCM_ERR_BUSY);

    if (BCM_ERR_OK != ret) {
        ULOG_ERR("resetStateHandler failed with %d\n", ret);
        ethsrv_qt_result = ret;
        goto done;
    }

    do {
        ret = ETHERNET_Service.client.initStateHandler(BCM_STATE_READY);
    } while (ret == BCM_ERR_BUSY);

    if (BCM_ERR_OK != ret) {
        ULOG_ERR("initStateHandler failed with %d\n", ret);
        ethsrv_qt_result = ret;
        goto done;
    }

    do {
        ret = ETHERNET_Service.client.readyStateHandler(BCM_STATE_RUN);
    } while (ret == BCM_ERR_BUSY);

    if (BCM_ERR_OK != ret) {
        ULOG_ERR("readyStateHandler failed with %d\n", ret);
        ethsrv_qt_result = ret;
        goto done;
    }

#if 0
    cmd.deviceID = MCU_DEVICE_MASTER;
    cmd.mdioHwID = 1UL;
    cmd.pkt.regAccMode = ETHER_MDIOREGACCESS_CL45;
    cmd.pkt.deviceType = 1U;
    cmd.pkt.slaveAddr = 1U;
    cmd.pkt.regAddr = 0x834U;

    ret = ETHERNET_Service.server.sendCmd(BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_ETH_ID, ETHER_CMDID_MDIO_READ),
                                          sizeof(ETHER_MDIOAccessType),
                                          (const uint8_t*)&cmd,
                                          &handle,
                                          &forwardToSlaves);

    if (BCM_ERR_OK != ret) {
        ULOG_ERR("sendCmd failed with %d\n", ret);
        ethsrv_qt_result = ret;
        goto done;
    }

    do {
        (void)BCM_WaitEvent(MODULE_EVENT);
        (void)BCM_GetEvent(TestTask, &mask);
        (void)BCM_ClearEvent(mask);

        ret = ETHERNET_Service.server.getResp(handle,
                BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_ETH_ID, ETHER_CMDID_MDIO_READ),
                sizeof(ETHER_MDIOAccessType),
                (uint8_t*)&cmd,
                &replyLen);
    } while (ret == BCM_ERR_BUSY);

    if (BCM_ERR_OK != ret) {
        ULOG_ERR("getResp failed with %d\n", ret);
        ethsrv_qt_result = ret;
        goto done;
    }
#endif

    /* Wind up */
    do {
        ret = ETHERNET_Service.client.runStateHandler(BCM_STATE_READY);
    } while (ret == BCM_ERR_BUSY);

    if (BCM_ERR_OK != ret) {
        ULOG_ERR("runStateHandler failed with %d\n", ret);
        ethsrv_qt_result = ret;
        goto done;
    }

    do {
        ret = ETHERNET_Service.client.readyStateHandler(BCM_STATE_UNINIT);
    } while (ret == BCM_ERR_BUSY);

    if (BCM_ERR_OK != ret) {
        ULOG_ERR("readyStateHandler failed with %d\n", ret);
        ethsrv_qt_result = ret;
        goto done;
    }

done:
    if (BCM_AT_EXECUTING == ethsrv_qt_result) {
        ULOG_INFO("\n Test PASSED \n");
        ethsrv_qt_result = BCM_ERR_OK;
    }

    BCM_TerminateTask();
}

int32_t BCM_ExecuteAT(uint32_t aIndex)
{
    int32_t ret = BCM_AT_NOT_AVAILABLE;
    if (1UL == aIndex) {
        ethsrv_qt_result = BCM_AT_EXECUTING;
        BCM_ActivateTask(ETHERNET_Task);
        BCM_ActivateTask(TestTask);
        ret = BCM_ERR_OK;
    }

    return ret;
}

int32_t BCM_GetResultAT(uint32_t aIndex)
{
    int32_t ret = BCM_AT_NOT_AVAILABLE;

    if (1UL == aIndex) {
        ret = ethsrv_qt_result;
    }

    return ret;
}

/** @} */
