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
#include <ee.h>
#include <console.h>
#include <bcm_test.h>
#include <ulog.h>
#include <bcm_utils.h>
#include <shell.h>
#include <osil/bcm_osil.h>
#include "ets.h"
#include "ets_osil.h"
#include "etsm.h"
#include <module_osil.h>

#define GetModuleLogLevel()  ULOG_LVL_INFO
#define CHECK_ERR(ret, lineNum)  if (BCM_ERR_OK != (ret)) {                             \
                                ULOG_ERR("\n Error: %d \t line %d",(ret),(lineNum));    \
                                goto end;                                               \
                                }

#define ETSCOMPQT_INTERVAL_31_25MS (31250UL)
static const ETS_ConfigType ETSCOMPQT_Config =
{
    .magicId = ETS_CONFIG_MAGIC_ID,
    .operMode = ETS_OPERMODE_AVNU,
    .globalEnable = TRUE,
    .timeSource = ETS_TIMESOURCE_INT_OSC,
    .syncLocked = TRUE,
    .boundaryModeEnable = FALSE,
#if (ETS_MAX_INTERFACES > 8UL)
    .numInterfaces = 14U,
#elif (ETS_MAX_INTERFACES > 1UL)
    .numInterfaces = 8U,
#else
    .numInterfaces = 1U,
#endif
    .intfCfg = {
        {
            .hwPortNum = 0U,
            .initLogPdelayInterval = ETS_LOGINTERVAL_INF,
            .avnuOperLogPdelayInterval = ETS_OPERLOGPDELAY_INF,
            .avnuNbrPropDelay = 2000UL,
            .avnuNbrRateRatio = 0x40000000L,
            .allowedLostResponses = 3U,
        },
#if (ETS_MAX_INTERFACES > 1UL)
        {
            .hwPortNum = 1U,
            .initLogPdelayInterval = ETS_LOGINTERVAL_1S,
            .avnuOperLogPdelayInterval = ETS_OPERLOGPDELAY_1S,
            .avnuNbrPropDelay = 2000UL,
            .avnuNbrRateRatio = 0x40000000L,
            .allowedLostResponses = 3U
        },
        {
            .hwPortNum = 2U,
            .initLogPdelayInterval = ETS_LOGINTERVAL_1S,
            .avnuOperLogPdelayInterval = ETS_OPERLOGPDELAY_8S,
            .avnuNbrPropDelay = 2000UL,
            .avnuNbrRateRatio = 0x40000000L,
            .allowedLostResponses = 3U
        },
        {
            .hwPortNum = 3U,
            .initLogPdelayInterval = ETS_LOGINTERVAL_1S,
            .avnuOperLogPdelayInterval = ETS_OPERLOGPDELAY_8S,
            .avnuNbrPropDelay = 2000UL,
            .avnuNbrRateRatio = 0x40000000L,
            .allowedLostResponses = 3U
        },
        {
            .hwPortNum = 4U,
            .initLogPdelayInterval = ETS_LOGINTERVAL_1S,
            .avnuOperLogPdelayInterval = ETS_OPERLOGPDELAY_8S,
            .avnuNbrPropDelay = 2000UL,
            .avnuNbrRateRatio = 0x40000000L,
            .allowedLostResponses = 3U
        },
        {
            .hwPortNum = 5U,
            .initLogPdelayInterval = ETS_LOGINTERVAL_1S,
            .avnuOperLogPdelayInterval = ETS_OPERLOGPDELAY_8S,
            .avnuNbrPropDelay = 2000UL,
            .avnuNbrRateRatio = 0x40000000L,
            .allowedLostResponses = 3U
        },
        {
            .hwPortNum = 6U,
            .initLogPdelayInterval = ETS_LOGINTERVAL_1S,
            .avnuOperLogPdelayInterval = ETS_OPERLOGPDELAY_8S,
            .avnuNbrPropDelay = 2000UL,
            .avnuNbrRateRatio = 0x40000000L,
            .allowedLostResponses = 3U
        },
        {
            .hwPortNum = 8U,
            .initLogPdelayInterval = ETS_LOGINTERVAL_1S,
            .avnuOperLogPdelayInterval = ETS_OPERLOGPDELAY_8S,
            .avnuNbrPropDelay = 2000UL,
            .avnuNbrRateRatio = 0x40000000L,
            .allowedLostResponses = 3U
        },
#endif
    },
    .numDomains = 1U,
    .domainCfg = {
        {
            .domainNumber = 0U,
            .avnuClockMode = ETS_CLOCKMODE_GM,
            .avnuSyncAbsenceTimeout = 0U,
            .avnuGmRateRatio = 0x40000000,
            .intfCfg = {
                {
                    .portEnable = TRUE,
                    .avnuPortRole = ETS_ROLE_MASTER,
                    .initLogSyncInterval = ETS_LOGINTERVAL_125MS,
                    .avnuOperLogSyncInterval = ETS_OPERLOGSYNC_125MS,
                    .syncReceiptTimeout = 3U,
                },
#if (ETS_MAX_INTERFACES > 1UL)
                {
                    .portEnable = FALSE,
                    .avnuPortRole = ETS_ROLE_MASTER,
                    .initLogSyncInterval = ETS_LOGINTERVAL_31_25MS,
                    .avnuOperLogSyncInterval = ETS_OPERLOGSYNC_125MS,
                    .syncReceiptTimeout = 3U,
                },
                {
                    .portEnable = FALSE,
                    .avnuPortRole = ETS_ROLE_MASTER,
                    .initLogSyncInterval = ETS_LOGINTERVAL_31_25MS,
                    .avnuOperLogSyncInterval = ETS_OPERLOGSYNC_125MS,
                    .syncReceiptTimeout = 3U,
                },
                {
                    .portEnable = FALSE,
                    .avnuPortRole = ETS_ROLE_MASTER,
                    .initLogSyncInterval = ETS_LOGINTERVAL_31_25MS,
                    .avnuOperLogSyncInterval = ETS_OPERLOGSYNC_125MS,
                    .syncReceiptTimeout = 3U,
                },
                {
                    .portEnable = FALSE,
                    .avnuPortRole = ETS_ROLE_MASTER,
                    .initLogSyncInterval = ETS_LOGINTERVAL_31_25MS,
                    .avnuOperLogSyncInterval = ETS_OPERLOGSYNC_125MS,
                    .syncReceiptTimeout = 3U,
                },
                {
                    .portEnable= FALSE,
                    .avnuPortRole = ETS_ROLE_MASTER,
                    .initLogSyncInterval = ETS_LOGINTERVAL_31_25MS,
                    .avnuOperLogSyncInterval = ETS_OPERLOGSYNC_125MS,
                    .syncReceiptTimeout = 3U,
                },
                {
                    .portEnable = FALSE,
                    .avnuPortRole = ETS_ROLE_MASTER,
                    .initLogSyncInterval = ETS_LOGINTERVAL_31_25MS,
                    .avnuOperLogSyncInterval = ETS_OPERLOGSYNC_125MS,
                    .syncReceiptTimeout = 3U,
                },
                {
                    .portEnable = FALSE,
                    .avnuPortRole = ETS_ROLE_MASTER,
                    .initLogSyncInterval = ETS_LOGINTERVAL_31_25MS,
                    .avnuOperLogSyncInterval = ETS_OPERLOGSYNC_125MS,
                    .syncReceiptTimeout = 3U,
                },
#endif
            },
        },
    },
};

static volatile int32_t etscomp_qt_result = BCM_AT_NOT_STARTED;

const ETSM_EventType ETSM_EventInfo = {
    .packetEvent    = SystemEvent0,
    .timestampEvent = SystemEvent0,
    .timerEvent     = SystemEvent1,
};

void ETSM_GetServer(int32_t *aServerTask, uint32_t *aServerEvent)
{
    if (NULL != aServerTask) {
        *aServerTask = ETSCOMPTestTask;
    }
    if (NULL != aServerEvent) {
        *aServerEvent = MODULE_Event;
    }
}

extern void ETHSRV_Process(void);

static void Delay(uint32_t aTicks)
{
    uint32_t i = 0UL;

    for (; i < aTicks; ++i) {
        ETSM_Module.eventHandler(ETSM_EventInfo.timerEvent |
                                     ETSM_EventInfo.packetEvent|
                                     ETSM_EventInfo.timestampEvent);
        ETHSRV_Process();
    }
}

/**
  @defgroup grp_ets_qt Qualification Tests
  @ingroup grp_ets

  @addtogroup grp_ets_qt
  @{

  @file code.c
  @brief ETS Component Integration Test
  This source file contains the qualification tests for ETS component
  @version 1.25 Import from MS Word document
*/

/** @brief Brief description of COMP_IT

  This test ....

  @code{.unparsed}
  # Activate Test Task
  # Activate ETS Protocol Task
  # Initialize ETS
  # De-initialize ETS
  # Terminate Test Task

@endcode
*/

TASK(ETSCOMPTestTask)
{
    int32_t                    ret = BCM_ERR_OK;
    ETS_MsgUnionType           cmdResp;
    BCM_SubStateType           cmdStatus;
    uint32_t                   cmdBufSize;
    BCM_HandleType             processLocal = 0ULL;
    uint32_t                   forwardToSlaves = 0UL;
    uint32_t                   cmd;
    uint32_t                   mask;
    uint32_t                   replyLen;

    /* Reset -> Init */
    do {
        ret = ETSM_Module.resetStateHandler(BCM_STATE_INIT);
    } while (ret == BCM_ERR_BUSY);
    CHECK_ERR(ret, __LINE__);

    /* Ensure configuration is loaded */
    BCM_MemCpy(ETSM_Module.configImgData,
               &ETSCOMPQT_Config,
               sizeof(ETSCOMPQT_Config));

    /* Init -> Ready */
    do {
        ret = ETSM_Module.initStateHandler(BCM_STATE_READY);
    } while (ret == BCM_ERR_BUSY);
    CHECK_ERR(ret, __LINE__);

    /* Ready -> Run */
    do {
        ret = ETSM_Module.readyStateHandler(BCM_STATE_RUN);
    } while (ret == BCM_ERR_BUSY);
    CHECK_ERR(ret, __LINE__);

    mask = ETSM_Module.getEventMask();
    if (mask != (ETSM_EventInfo.packetEvent    |
                 ETSM_EventInfo.timerEvent     |
                 ETSM_EventInfo.timestampEvent |
                 MODULE_Event)) {
        ret = BCM_ERR_INVAL_PARAMS;
        CHECK_ERR(ret, __LINE__);
    }

    ULOG_INFO("\nTesting gPTP in GM mode\n");

    /* Simulate passage of time */
    Delay(10);

    /* Set the global time */
    cmd = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_ETS_ID, ETS_CMD_SETGLOBALTIME);
    cmdBufSize = sizeof(ETS_TimeType);
    cmdResp.time.seconds = 100000ULL;
    cmdResp.time.nanoseconds = 0UL;
    ret = ETSM_Module.processCmd(cmd, &cmdStatus, (uint8_t*)cmdResp.data, cmdBufSize, &replyLen);
    CHECK_ERR(ret, __LINE__);
    ULOG_INFO("Setting the global time\n");

    /* Fetch the global status */
    cmd = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_ETS_ID, ETS_CMD_GETGLOBALSTATUS);
    cmdBufSize = sizeof(ETS_GlobalStatusType);
    ret = ETSM_Module.processCmd(cmd, &cmdStatus, (uint8_t*)cmdResp.data, cmdBufSize, &replyLen);
    CHECK_ERR(ret, __LINE__);

    if ((cmdResp.globalStatus.activeDomainNum != 0U) ||
        (cmdResp.globalStatus.networkTime.seconds != 100005ULL) ||
        (cmdResp.globalStatus.networkTimeState != ETS_TIMESTATE_SYNC)) {
        ULOG_ERR("Error: global status unexpected %u %u:%u %u\n",
                cmdResp.globalStatus.activeDomainNum,
                (uint32_t)cmdResp.globalStatus.networkTime.seconds,
                cmdResp.globalStatus.networkTime.nanoseconds,
                cmdResp.globalStatus.networkTimeState);
        ret = BCM_ERR_INVAL_STATE;
        goto end;
    }

    ULOG_INFO("Verified global status\n");

    /* Fetch the domain status */
    cmd = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_ETS_ID, ETS_CMD_GETDOMAINSTATUS);
    cmdBufSize = sizeof(ETS_DomainNumAndStatusType);
    cmdResp.domainStatus.num = 0U;
    ret = ETSM_Module.processCmd(cmd, &cmdStatus, (uint8_t*)cmdResp.data, cmdBufSize, &replyLen);
    CHECK_ERR(ret, __LINE__);

    if ((cmdResp.domainStatus.status.gmStatus != ETS_GMSTATUS_PRESENT) ||
        (cmdResp.domainStatus.status.clockState != ETS_CLOCKSTATE_UPDATE_GM)) {
        ULOG_ERR("Error: domain status unexpected %u %u\n",
                cmdResp.domainStatus.status.gmStatus,
                cmdResp.domainStatus.status.clockState);
        ret = BCM_ERR_INVAL_STATE;
        goto end;
    }

    ULOG_INFO("Verified domain status\n");

    /* Fetch the port status */
    cmd = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_ETS_ID, ETS_CMD_GETPORTSTATUS);
    cmdBufSize = sizeof(ETS_PortNumAndStatusType);
    cmdResp.portStatus.num = 0UL;
    ret = ETSM_Module.sendCmd(cmd, cmdBufSize, (uint8_t*)cmdResp.data, &processLocal, &forwardToSlaves);
    CHECK_ERR(ret, __LINE__);

    if ((TRUE != processLocal) &&
        (FALSE != forwardToSlaves)) {
        ret = BCM_ERR_UNKNOWN;
        CHECK_ERR(ret, __LINE__);
    }

    ret = ETSM_Module.processCmd(cmd, &cmdStatus, (uint8_t*)cmdResp.data, cmdBufSize, &replyLen);
    CHECK_ERR(ret, __LINE__);

    if ((cmdResp.portStatus.status.isMeasuringPdelay != 0UL) ||
        (cmdResp.portStatus.status.currentLogPdelayIntvl != ETS_LOGINTERVAL_INF)) {
        ULOG_ERR("Error: port status unexpected %lu:%ld\n",
                cmdResp.portStatus.status.isMeasuringPdelay,
                cmdResp.portStatus.status.currentLogPdelayIntvl);
        ret = BCM_ERR_INVAL_STATE;
        goto end;
    }

    /* Fetch the per-domain port status */
    cmd = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_ETS_ID, ETS_CMD_GETDOMAINPORTSTATUS);
    cmdBufSize = sizeof(ETS_PerDomainPortStatusType);
    cmdResp.domainPortStatus.portNum = 0UL;
    cmdResp.domainPortStatus.domain = 0U;
    ret = ETSM_Module.sendCmd(cmd, cmdBufSize, (uint8_t*)cmdResp.data, &processLocal, &forwardToSlaves);
    CHECK_ERR(ret, __LINE__);

    if ((TRUE != processLocal) &&
        (FALSE != forwardToSlaves)) {
        ret = BCM_ERR_UNKNOWN;
        CHECK_ERR(ret, __LINE__);
    }

    ret = ETSM_Module.processCmd(cmd, &cmdStatus, (uint8_t*)cmdResp.data, cmdBufSize, &replyLen);
    CHECK_ERR(ret, __LINE__);

        if (cmdResp.domainPortStatus.status.currentLogSyncIntvl != ETS_LOGINTERVAL_125MS) {
        ULOG_ERR("Error: per-domain port status unexpected %ld\n",
                cmdResp.domainPortStatus.status.currentLogSyncIntvl);
        ret = BCM_ERR_INVAL_STATE;
        goto end;
    }

    ULOG_INFO("Verified interface status in GM mode\n");

    ULOG_INFO("\nSwitching to slave mode....\n");
    /* Run -> Ready */
    do {
        ret = ETSM_Module.runStateHandler(BCM_STATE_READY);
    } while (ret == BCM_ERR_BUSY);
    CHECK_ERR(ret, __LINE__);

    /* Ready -> UnInit */
    do {
        ret = ETSM_Module.readyStateHandler(BCM_STATE_UNINIT);
    } while (ret == BCM_ERR_BUSY);
    CHECK_ERR(ret, __LINE__);

    /* Reset -> Init */
    do {
        ret = ETSM_Module.resetStateHandler(BCM_STATE_INIT);
    } while (ret == BCM_ERR_BUSY);
    CHECK_ERR(ret, __LINE__);

    ETS_ConfigType ETSCOMPQT_SlaveConfig;
    BCM_MemCpy(&ETSCOMPQT_SlaveConfig,
               &ETSCOMPQT_Config,
               sizeof(ETSCOMPQT_Config));

    ETSCOMPQT_SlaveConfig.domainCfg[0U].avnuSyncAbsenceTimeout = 1U;
    ETSCOMPQT_SlaveConfig.domainCfg[0U].avnuClockMode = ETS_CLOCKMODE_SLAVE;
    ETSCOMPQT_SlaveConfig.domainCfg[0U].intfCfg[0U].avnuOperLogSyncInterval   = ETS_OPERLOGSYNC_1S;
    ETSCOMPQT_SlaveConfig.intfCfg[0U].initLogPdelayInterval = ETS_LOGINTERVAL_1S;
    ETSCOMPQT_SlaveConfig.intfCfg[0U].avnuOperLogPdelayInterval = ETS_OPERLOGPDELAY_1S;
    ETSCOMPQT_SlaveConfig.domainCfg[0U].intfCfg[0U].avnuPortRole = ETS_ROLE_SLAVE;
    ETSCOMPQT_SlaveConfig.intfCfg[0U].avnuNbrPropDelay          = 200UL;
    ETSCOMPQT_SlaveConfig.domainCfg[0U].intfCfg[0U].initLogSyncInterval   = ETS_LOGINTERVAL_31_25MS;
    ETSCOMPQT_SlaveConfig.intfCfg[0U].allowedLostResponses  = 1U;

    /* Ensure configuration is loaded */
    BCM_MemCpy(ETSM_Module.configImgData,
               &ETSCOMPQT_SlaveConfig,
               sizeof(ETSCOMPQT_SlaveConfig));

    /* Init -> Ready */
    do {
        ret = ETSM_Module.initStateHandler(BCM_STATE_READY);
    } while (ret == BCM_ERR_BUSY);
    CHECK_ERR(ret, __LINE__);

    /* Ready -> Run */
    do {
        ret = ETSM_Module.readyStateHandler(BCM_STATE_RUN);
    } while (ret == BCM_ERR_BUSY);
    CHECK_ERR(ret, __LINE__);

    /* Wait for sync absence timeout to occur */
    Delay(100);

    /* Fetch the domain status */
    cmd = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_ETS_ID, ETS_CMD_GETDOMAINSTATUS);
    cmdBufSize = sizeof(ETS_DomainStatusType);
    cmdResp.domainStatus.num = 0U;

    ret = ETSM_Module.processCmd(cmd, &cmdStatus, (uint8_t*)cmdResp.data, cmdBufSize, &replyLen);
    CHECK_ERR(ret, __LINE__);

    /* Verify the domain status */
    if ((cmdResp.domainStatus.status.gmStatus != ETS_GMSTATUS_STARTUP_ABSENT) ||
        (cmdResp.domainStatus.status.clockState != ETS_CLOCKSTATE_INIT_SLAVE)) {
        ULOG_ERR("Error: domain status unexpected %lu: %lu\n", cmdResp.domainStatus.status.gmStatus,
        cmdResp.domainStatus.status.clockState);
        ret = BCM_ERR_INVAL_STATE;
        goto end;
    }
    ULOG_INFO("Verified domain status in slave mode\n");

    /* Fetch the port status */
    cmd = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_ETS_ID, ETS_CMD_GETPORTSTATUS);
    cmdBufSize = sizeof(ETS_PortNumAndStatusType);
    cmdResp.portStatus.num = 0UL;
    ret = ETSM_Module.processCmd(cmd, &cmdStatus, (uint8_t*)cmdResp.data, cmdBufSize, &replyLen);
    CHECK_ERR(ret, __LINE__);

    /* Verify the interface status */
    if ((cmdResp.portStatus.status.isMeasuringPdelay != 0UL) ||
        (cmdResp.portStatus.status.currentLogPdelayIntvl != ETS_LOGINTERVAL_1S)) {
        ULOG_ERR("Error: port status unexpected line %d\n", __LINE__);
        ret = BCM_ERR_INVAL_STATE;
        goto end;
    }
    ULOG_INFO("Verified port status in slave mode\n");

    /* Fetch the per-domain port status */
    cmd = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_ETS_ID, ETS_CMD_GETDOMAINPORTSTATUS);
    cmdBufSize = sizeof(ETS_PerDomainPortStatusType);
    cmdResp.domainPortStatus.portNum = 0UL;
    cmdResp.domainPortStatus.domain = 0U;
    ret = ETSM_Module.processCmd(cmd, &cmdStatus, (uint8_t*)cmdResp.data, cmdBufSize, &replyLen);
    CHECK_ERR(ret, __LINE__);

    /* Verify the per-domain port status */
    if ((cmdResp.domainPortStatus.status.syncReceiptTimeoutIntvl !=
         (ETSCOMPQT_INTERVAL_31_25MS * ETSCOMPQT_Config.domainCfg[0U].intfCfg[0U].syncReceiptTimeout)) ||
        (cmdResp.domainPortStatus.stats.pDelayReqTxCount == 0UL)) {
        ULOG_ERR("Error: per-domain port status unexpected line %d\n", __LINE__);
        ret = BCM_ERR_INVAL_STATE;
        goto end;
    }
    ULOG_INFO("Verified per-domain port status in slave mode\n");

    /* Reset interface stats */
    cmd = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_ETS_ID, ETS_CMD_RESETSTATS);
    ret = ETSM_Module.processCmd(cmd, &cmdStatus, (uint8_t*)cmdResp.data, cmdBufSize, &replyLen);
    CHECK_ERR(ret, __LINE__);

    /* Fetch interface stats */
    cmd = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_ETS_ID, ETS_CMD_GETDOMAINPORTSTATUS);
    ret = ETSM_Module.processCmd(cmd, &cmdStatus, (uint8_t*)cmdResp.data, cmdBufSize, &replyLen);
    CHECK_ERR(ret, __LINE__);

    /* Verify stats */
    if (cmdResp.domainPortStatus.stats.pDelayReqTxCount > 1UL) {
        ULOG_ERR("Error: interface stats unexpected after clearing %lu\n",
                cmdResp.domainPortStatus.stats.pDelayReqTxCount);
        ret = BCM_ERR_INVAL_STATE;
        goto end;
    }
    ULOG_INFO("Verified interface stats after clearing\n");

    /* TODO: Test mergeResult as well */

    /* Run -> Ready */
    do {
        ret = ETSM_Module.runStateHandler(BCM_STATE_READY);
    } while (ret == BCM_ERR_BUSY);
    CHECK_ERR(ret, __LINE__);

    /* Ready -> UnInit */
    do {
        ret = ETSM_Module.readyStateHandler(BCM_STATE_UNINIT);
    } while (ret == BCM_ERR_BUSY);
    CHECK_ERR(ret, __LINE__);

end:
    etscomp_qt_result = ret;
    (void)BCM_TerminateTask();
}
/** @} */

int32_t BCM_ExecuteAT(uint32_t aIndex)
{
    int32_t ret = BCM_AT_NOT_AVAILABLE;

    if (1UL == aIndex) {
        etscomp_qt_result = BCM_AT_EXECUTING;
        (void)BCM_ActivateTask(ETSCOMPTestTask);
        ret = BCM_ERR_OK;
    }
    return ret;
}

int32_t BCM_GetResultAT(uint32_t aIndex)
{
    int32_t ret = BCM_AT_NOT_AVAILABLE;
    if (1UL == aIndex) {
        ret = etscomp_qt_result;
    }
    return ret;
}

void APP_Init(void)
{
}
