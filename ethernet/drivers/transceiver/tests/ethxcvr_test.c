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
#include <bcm_utils.h>
#include <bcm_test.h>
#include <bcm_time.h>
#include <osil/bcm_osil.h>
#include <ethxcvr.h>
#include <ethernet.h>
#include <mcu.h>
#include <tim.h>
#include <ethutils.h>
#include <ulog.h>
#define GetModuleLogLevel() ULOG_LVL_ERROR

#define CHECK_ERR_BREAK(ret, port)                                          \
    if (BCM_ERR_OK != ret) {                                                \
        if (BCM_ERR_NOSUPPORT != ret) {                                     \
            ULOG_ERR("Error:%d for port %u line %u\n", ret, port, __LINE__);\
            break;                                                          \
        } else {                                                            \
            ret = BCM_ERR_OK;                                               \
        }                                                                   \
    }

#define CHECK_ERR(ret, port)                                         \
    if (BCM_ERR_OK != ret) {                                         \
        if (BCM_ERR_NOSUPPORT != ret) {                              \
            ULOG_ERR("Test Failed with Error:%d port %u line %u\n", ret, port, __LINE__);\
            goto exit;                                               \
        } else {                                                     \
            ret = BCM_ERR_OK;                                        \
        }                                                            \
    }

#define CHECK_PARAMS(ret, param1, param2, port)                      \
    if (BCM_ERR_OK == ret) {                                         \
        if (param1 != param2) {                                      \
            retVal = BCM_ERR_UNKNOWN;                                \
            ULOG_ERR("Error: params [%u] != [%u] for port %u line %u\n", \
                    param1, param2, port, __LINE__);                 \
            goto exit;                                               \
        }                                                            \
    } else {                                                         \
        if (BCM_ERR_NOSUPPORT != ret) {                              \
            ULOG_ERR("Test Failed with Error:%d port %u line %u\n", ret, port, __LINE__);\
            goto exit;                                               \
        } else {                                                     \
            ret = BCM_ERR_OK;                                        \
        }                                                            \
    }

#define CHECK_ERR_LOAD(ret, mod)                                     \
    if (BCM_ERR_OK != ret) {                                         \
        if (BCM_ERR_NOSUPPORT != ret) {                              \
            ULOG_ERR("Error:%d while loading config-%s line %u\n", ret, mod, __LINE__);\
            goto exit;                                               \
        } else {                                                     \
            ret = BCM_ERR_OK;                                        \
        }                                                            \
    }

static int32_t ETHXCVR_TestResult = BCM_AT_NOT_STARTED;

static const uint8_t ETHER_DefaultMacAddr[] = {
    0x02, 0x01, 0x02, 0x03, 0x04, 0x05
};

static const ETHER_CfgType ETHER_Config = {
    .hwID = ETHER_HW_ID_0,
    .speed = ETHER_SPEED_1000MBPS,
    .duplexMode = ETHER_DUPLEX_MODE_FULL,
    .maxRxFrmLen = 1522UL,
    .macAddr = ETHER_DefaultMacAddr,
    .prioChanMap[0] = 0UL,
    .prioChanMap[1] = 0UL,
    .prioChanMap[2] = 0UL,
    .prioChanMap[3] = 0UL,
    .prioChanMap[4] = 0UL,
    .prioChanMap[5] = 0UL,
    .prioChanMap[6] = 0UL,
    .prioChanMap[7] = 0UL,
};


static const ETHXCVR_ConfigType ETHXCVR_Cfg;
static const MSGQ_MsgHdrType *ETHXCVRTEST_Hdr = NULL;
static uint32_t ETHXCVRTEST_ConfigLoadEvent = SystemEvent1;

static int32_t ETHXCVR_TestLoadConfig(void) {
  int32_t ret = BCM_ERR_OK;
  uint32_t size;
  uint16_t imgid = 0xFF00U;
  ret = BCM_TestLoadImg(imgid, (uint8_t *)&ETHXCVR_Cfg, sizeof(ETHXCVR_ConfigType), ETHXCVRTEST_ConfigLoadEvent, &ETHXCVRTEST_Hdr);
  CHECK_ERR_LOAD(ret, "Loading");

  ret = BCM_WaitEvent(ETHXCVRTEST_ConfigLoadEvent);
  if (BCM_ERR_OK == ret) {
    (void)BCM_ClearEvent(ETHXCVRTEST_ConfigLoadEvent);
  } else {
    CHECK_ERR_LOAD(ret, "WaitEvent");
  }
  ret = BCM_TestGetLoadImgStatus(ETHXCVRTEST_Hdr, &size);
  CHECK_ERR_LOAD(ret, "Load_Status");

  return ret;

exit:
    return ret;
}

void TIM_Chann1Cb(void)
{
    int ret;
    ret = (int32_t)IncrementCounterHardware(HRTimer);
    if (E_OK != ret) {
    }
}

static const TIM_ConfigType TimerCfg[] = {
    {
        .prescale = TIM_PRESCALE_DIV_1,
        .chanID = 0UL,
        .chanMode = TIM_CHAN_MODE_PERIODIC,
        .width = TIM_WIDTH_32_BIT,
        .sysTimeEn = TRUE,
    },
    {
        .prescale = TIM_PRESCALE_DIV_1,
        .chanID = 1UL,
        .chanMode = TIM_CHAN_MODE_PERIODIC,
        .width = TIM_WIDTH_32_BIT,
        .sysTimeEn = FALSE,
    },
};

static uint32_t ETHXCVR_TestCheckOutOfTurnSetMode(uint32_t aIndex)
{
    uint32_t retVal = FALSE;
#if defined(__BCM8956X__)
     MCU_VersionType version;

     MCU_GetVersion(&version);
     if ((MCU_CHIP_VERSION_A0 == version.rev) &&
         (ETHXCVR_Cfg.port[aIndex].busMode == ETHXCVR_BUSMODE_SGMII) &&
         (ETHXCVR_Cfg.port[aIndex].bus.cntrlID == 3U)) {
        retVal = TRUE;
    }
#endif
    return retVal;
}

static int32_t ETHXCVR_TestUpdate(uint8_t aPort)
{
    int32_t retVal;

    retVal = ETHXCVR_UpdateHWStatus(aPort);
    CHECK_ERR(retVal, aPort);

    do {
        retVal = ETHXCVR_StateHandler(aPort);
    } while (BCM_ERR_EAGAIN == retVal);
    CHECK_ERR(retVal, aPort);

exit:
    return retVal;
}

static int32_t ETHXCVR_Setup(void)
{
    int32_t                retVal = BCM_ERR_OK;
    uint32_t               i      = 0UL;
    ETHXCVR_PortConfigType portCfg;
    uint32_t               isStackingPort;
    uint32_t               portNum = 0UL;

    retVal = ETHXCVR_TestLoadConfig();
    CHECK_ERR_LOAD(retVal, "ETHXCVR_Setup");
    ETHUTILS_Init();

    /* Enable MDIO driver - part of controller */
    ETHER_Init(ETHER_HW_ID_0, &ETHER_Config);

    /* Enable HRTimer used for MDIO */
    TIM_Init(TimerCfg[1UL].chanID, &TimerCfg[1UL]);

    for (; i < ETHXCVR_Cfg.numPorts; i++) {
        isStackingPort = FALSE;
        portNum = ETHUTILS_ConvertToLocalPort(ETHXCVR_Cfg.port[i].id, &isStackingPort);

        if ((ETHUTILS_INVALID_PORT != portNum) && (FALSE == isStackingPort)) {
            BCM_MemCpy(&portCfg, &ETHXCVR_Cfg.port[i], sizeof(ETHXCVR_PortConfigType));
            portCfg.id = portNum;
            ETHXCVR_Init(portNum, &portCfg);
            if (TRUE == ETHXCVR_TestCheckOutOfTurnSetMode(i)) {
                ETHXCVR_ModeType mode =
                    (ETHXCVR_BOOLEAN_TRUE == ETHXCVR_Cfg.port[i].portEnable) ?
                    ETHXCVR_MODE_ACTIVE : ETHXCVR_MODE_DOWN;

                retVal = ETHXCVR_SetMode(portNum, mode);
                CHECK_ERR_BREAK(retVal, portNum);

                do {
                    retVal = ETHXCVR_StateHandler(portNum);
                } while (BCM_ERR_EAGAIN == retVal);
                CHECK_ERR_BREAK(retVal, portNum);
            }
        }
    }

    CHECK_ERR(retVal, portNum);

    for (i = 0UL; i < ETHXCVR_Cfg.numPorts; i++) {
        isStackingPort = FALSE;
        portNum = ETHUTILS_ConvertToLocalPort(ETHXCVR_Cfg.port[i].id, &isStackingPort);

        if ((ETHUTILS_INVALID_PORT != portNum) && (FALSE == isStackingPort)) {
            if (FALSE == ETHXCVR_TestCheckOutOfTurnSetMode(i)) {
                ETHXCVR_ModeType mode =
                    (ETHXCVR_BOOLEAN_TRUE == ETHXCVR_Cfg.port[i].portEnable) ?
                    ETHXCVR_MODE_ACTIVE : ETHXCVR_MODE_DOWN;

                retVal = ETHXCVR_SetMode(portNum, mode);
                CHECK_ERR_BREAK(retVal, portNum);

                do {
                    retVal = ETHXCVR_StateHandler(portNum);
                } while (BCM_ERR_EAGAIN == retVal);
                CHECK_ERR_BREAK(retVal, portNum);

                retVal = ETHXCVR_TestUpdate(portNum);
                CHECK_ERR(retVal, portNum);
            }
        }
    }

    /* Delay to ensure link comes up - 50ms seems to be enough */
    BCM_CpuNDelay(50000000UL);
exit:
    return retVal;
}

static void ETHXCVR_Cleanup(void)
{
    uint32_t  isStackingPort;
    uint32_t  portNum;
    uint32_t  i;

    for (i = 0UL; i < ETHXCVR_Cfg.numPorts; i++) {
        isStackingPort = FALSE;
        portNum = ETHUTILS_ConvertToLocalPort(ETHXCVR_Cfg.port[i].id, &isStackingPort);

        if ((ETHUTILS_INVALID_PORT != portNum) && (FALSE == isStackingPort)) {
            ETHXCVR_DeInit(portNum);
        }
    }
}

static int32_t ETHXCVR_CheckExpectedAdminMode(uint8_t aPort, ETHXCVR_ModeType aMode)
{
    ETHXCVR_ModeType mode;
    int32_t          retVal = ETHXCVR_GetMode(aPort, &mode);

    // ULOG_ERR("Port %u mode %u expected %u ret %u\n", aPort, mode, aMode, retVal);
    if ((BCM_ERR_OK != retVal) || (aMode != mode)) {
        retVal = BCM_ERR_UNKNOWN;
    }
    return retVal;
}

static int32_t ETHXCVR_TestSetAdminMode(uint8_t aPort, ETHXCVR_ModeType aMode)
{
    int32_t retVal = ETHXCVR_SetMode(aPort, aMode);
    if ((BCM_ERR_OK != retVal) && (BCM_ERR_NOSUPPORT != retVal)) {
        goto exit;
    }

    //ULOG_ERR("Able to set mode %u on port %u\n", aMode, aPort);
    if (BCM_ERR_NOSUPPORT != retVal) {
        do {
            retVal = ETHXCVR_StateHandler(aPort);
        } while (BCM_ERR_EAGAIN == retVal);
        CHECK_ERR(retVal, aPort);
    }

exit:
    return retVal;
}

static int32_t ETHXCVR_TestAdminMode(uint8_t aPort)
{
    int32_t          retVal;

    ULOG_INFO("Testing Admin Mode\n");
    retVal = ETHXCVR_CheckExpectedAdminMode(aPort, ETHXCVR_MODE_ACTIVE);
    CHECK_ERR(retVal, aPort);

    retVal = ETHXCVR_TestSetAdminMode(aPort, ETHXCVR_MODE_DOWN);
    if ((BCM_ERR_OK != retVal) && (BCM_ERR_NOSUPPORT != retVal)) {
        goto exit;
    }

    if (BCM_ERR_NOSUPPORT != retVal) {
        retVal = ETHXCVR_TestUpdate(aPort);
        CHECK_ERR(retVal, aPort);

        retVal = ETHXCVR_CheckExpectedAdminMode(aPort, ETHXCVR_MODE_DOWN);
        CHECK_ERR(retVal, aPort);
    }

    retVal = ETHXCVR_TestSetAdminMode(aPort, ETHXCVR_MODE_ACTIVE);
    if ((BCM_ERR_OK != retVal) && (BCM_ERR_NOSUPPORT != retVal)) {
        goto exit;
    }

    if (BCM_ERR_NOSUPPORT != retVal) {
        retVal = ETHXCVR_TestUpdate(aPort);
        CHECK_ERR(retVal, aPort);

        retVal = ETHXCVR_CheckExpectedAdminMode(aPort, ETHXCVR_MODE_ACTIVE);
        CHECK_ERR(retVal, aPort);
    }

    retVal = ETHXCVR_TestSetAdminMode(aPort, ETHXCVR_MODE_ISOLATE);
    if ((BCM_ERR_OK != retVal) && (BCM_ERR_NOSUPPORT != retVal)) {
        goto exit;
    }

    if (BCM_ERR_NOSUPPORT != retVal) {
        retVal = ETHXCVR_TestUpdate(aPort);
        CHECK_ERR(retVal, aPort);

        retVal = ETHXCVR_CheckExpectedAdminMode(aPort, ETHXCVR_MODE_ISOLATE);
        CHECK_ERR(retVal, aPort);
    }

    retVal = ETHXCVR_TestSetAdminMode(aPort, ETHXCVR_MODE_ACTIVE);
    if ((BCM_ERR_OK != retVal) && (BCM_ERR_NOSUPPORT != retVal)) {
        goto exit;
    }

    if (BCM_ERR_NOSUPPORT != retVal) {
        retVal = ETHXCVR_TestUpdate(aPort);
        CHECK_ERR(retVal, aPort);

        retVal = ETHXCVR_CheckExpectedAdminMode(aPort, ETHXCVR_MODE_ACTIVE);
        CHECK_ERR(retVal, aPort);
    }

exit:
    return retVal;
}

static int32_t ETHXCVR_TestMasterSlaveMode(const ETHXCVR_PortConfigType *const aConfig)
{
    int32_t             retVal = BCM_ERR_OK;
    ETHXCVR_BooleanType mode;

    ULOG_INFO("Testing BR Master/Slave Mode\n");
    if (ETHXCVR_BOOLEAN_TRUE == aConfig->autoNeg) {
        retVal = ETHXCVR_GetMasterMode(aConfig->id, &mode);
        CHECK_ERR(retVal, aConfig->id);
    } else {
        retVal = ETHXCVR_SetMasterMode(aConfig->id, ETHXCVR_BOOLEAN_TRUE);
        if (BCM_ERR_NOSUPPORT == retVal) {
            retVal = BCM_ERR_OK;
            goto exit;
        }
        CHECK_ERR(retVal, aConfig->id);

        do {
            retVal = ETHXCVR_StateHandler(aConfig->id);
        } while (BCM_ERR_EAGAIN == retVal);
        CHECK_ERR(retVal, aConfig->id);

        retVal = ETHXCVR_TestUpdate(aConfig->id);
        CHECK_ERR(retVal, aConfig->id);

        retVal = ETHXCVR_GetMasterMode(aConfig->id, &mode);
        CHECK_PARAMS(retVal, mode, ETHXCVR_BOOLEAN_TRUE, aConfig->id);

        retVal = ETHXCVR_SetMasterMode(aConfig->id, ETHXCVR_BOOLEAN_FALSE);
        CHECK_ERR(retVal, aConfig->id);

        do {
            retVal = ETHXCVR_StateHandler(aConfig->id);
        } while (BCM_ERR_EAGAIN == retVal);
        CHECK_ERR(retVal, aConfig->id);

        retVal = ETHXCVR_TestUpdate(aConfig->id);
        CHECK_ERR(retVal, aConfig->id);

        retVal = ETHXCVR_GetMasterMode(aConfig->id, &mode);
        CHECK_PARAMS(retVal, mode, ETHXCVR_BOOLEAN_FALSE, aConfig->id);
    }

exit:
    return retVal;
}

static int32_t ETHXCVR_TestAutoNeg(uint8_t aPort)
{
    int32_t retVal = ETHXCVR_RestartAutoNeg(aPort);
    if (BCM_ERR_NOSUPPORT == retVal) {
        retVal = BCM_ERR_OK;
        goto exit;
    }
    CHECK_ERR(retVal, aPort);

    do {
        retVal = ETHXCVR_StateHandler(aPort);
    } while (BCM_ERR_EAGAIN == retVal);
    CHECK_ERR(retVal, aPort);

    retVal = ETHXCVR_TestUpdate(aPort);
    CHECK_ERR(retVal, aPort);

exit:
    return retVal;
}

static int32_t ETHXCVR_TestGetRoutines(const ETHXCVR_PortConfigType *const aConfig)
{
    int32_t                   retVal;
    ETHXCVR_LinkStateType     link;
    ETHXCVR_SpeedType         speed;
    ETHXCVR_DuplexModeType    duplex;
    ETHXCVR_FlowControlType   flowControl;
    ETHXCVR_BooleanType       mode;
    ETHXCVR_AutoNegStatusType status;
    ETHXCVR_StatsType         stats;
    uint32_t sqi;

    ULOG_INFO("Testing Link State\n");
    retVal = ETHXCVR_GetLinkState(aConfig->id, &link);
    CHECK_ERR(retVal, aConfig->id);

    ULOG_INFO("Testing Speed\n");
    retVal = ETHXCVR_GetSpeed(aConfig->id, &speed);
    if (aConfig->autoNeg != ETHXCVR_BOOLEAN_TRUE) {
        CHECK_PARAMS(retVal, speed, aConfig->speed, aConfig->id);
    } else {
        CHECK_ERR(retVal, aConfig->id);
    }

    ULOG_INFO("Testing Duplex Mode\n");
    retVal = ETHXCVR_GetDuplexMode(aConfig->id, &duplex);
    CHECK_PARAMS(retVal, duplex, aConfig->duplex, aConfig->id);

    ULOG_INFO("Testing Flow Control Mode\n");
    retVal = ETHXCVR_GetFlowControl(aConfig->id, &flowControl);
    CHECK_PARAMS(retVal, flowControl, aConfig->flowControl, aConfig->id);

    ULOG_INFO("Testing GetSQI\n");
    retVal = ETHXCVR_GetSQIValue(aConfig->id, &sqi);
    CHECK_ERR(retVal, aConfig->id);

    ULOG_INFO("Testing Jumbo Mode\n");
    retVal = ETHXCVR_GetJumboMode(aConfig->id, &mode);
    CHECK_PARAMS(retVal, mode, aConfig->jumbo, aConfig->id);

    ULOG_INFO("Testing Autoneg Status\n");
    retVal = ETHXCVR_GetAutoNegStatus(aConfig->id, &status);
    CHECK_ERR(retVal, aConfig->id);

    ULOG_INFO("Testing Stats\n");
    retVal = ETHXCVR_GetStats(aConfig->id, &stats);
    CHECK_ERR(retVal, aConfig->id);

exit:
    return retVal;
}

static int32_t ETHXCVR_TestLoopbackMode(uint8_t aPort)
{
    int32_t             retVal = BCM_ERR_OK;
    ETHXCVR_BooleanType mode;

    ULOG_INFO("Testing Loopback Mode\n");
    retVal = ETHXCVR_SetLoopbackMode(aPort, ETHXCVR_BOOLEAN_TRUE);
    if (BCM_ERR_NOSUPPORT == retVal) {
        retVal = BCM_ERR_OK;
        goto exit;
    }
    CHECK_ERR(retVal, aPort);

    do {
        retVal = ETHXCVR_StateHandler(aPort);
    } while (BCM_ERR_EAGAIN == retVal);
    CHECK_ERR(retVal, aPort);

    retVal = ETHXCVR_TestUpdate(aPort);
    CHECK_ERR(retVal, aPort);

    retVal = ETHXCVR_GetLoopbackMode(aPort, &mode);
    CHECK_PARAMS(retVal, mode, ETHXCVR_BOOLEAN_TRUE, aPort);

    retVal = ETHXCVR_SetLoopbackMode(aPort, ETHXCVR_BOOLEAN_FALSE);
    CHECK_ERR(retVal, aPort);

    do {
        retVal = ETHXCVR_StateHandler(aPort);
    } while (BCM_ERR_EAGAIN == retVal);
    CHECK_ERR(retVal, aPort);

    retVal = ETHXCVR_TestUpdate(aPort);
    CHECK_ERR(retVal, aPort);

    retVal = ETHXCVR_GetLoopbackMode(aPort, &mode);
    CHECK_PARAMS(retVal, mode, ETHXCVR_BOOLEAN_FALSE, aPort);

exit:
    return retVal;
}

TASK(ETHXCVR_TestTask)
{
    int32_t   retVal = BCM_ERR_OK;
    uint32_t  i      = 0UL;
    ETHXCVR_PortConfigType config;

    retVal = ETHXCVR_Setup();
    if (BCM_ERR_OK == retVal) {
        for (; i < ETHXCVR_HW_ID_MAX; i++) {
            (void)ETHXCVR_GetPortConfig(i, &config);
            if (config.portEnable == ETHXCVR_BOOLEAN_TRUE) {
                ULOG_ERR("Testing port %u\n", config.id);

                retVal = ETHXCVR_TestGetRoutines(&config);
                CHECK_ERR_BREAK(retVal, config.id);

                retVal = ETHXCVR_TestAdminMode(config.id);
                CHECK_ERR_BREAK(retVal, config.id);

                retVal = ETHXCVR_TestMasterSlaveMode(&config);
                CHECK_ERR_BREAK(retVal, config.id);

                if (config.autoNeg == ETHXCVR_BOOLEAN_TRUE) {
                    retVal = ETHXCVR_TestAutoNeg(config.id);
                    CHECK_ERR_BREAK(retVal, config.id);
                }
                retVal = ETHXCVR_TestLoopbackMode(config.id);
                CHECK_ERR_BREAK(retVal, config.id);
            }
        }
    }

    ETHXCVR_Cleanup();
    ETHXCVR_TestResult = retVal;
    BCM_TerminateTask();
    return;
}

int32_t BCM_ExecuteAT(uint32_t aIndex)
{
    int32_t ret = BCM_AT_NOT_AVAILABLE;

    if (1UL == aIndex) {
        ETHXCVR_TestResult = BCM_AT_EXECUTING;
        (void)BCM_ActivateTask(ETHXCVR_TestTask);
        ret = BCM_ERR_OK;
    }

    return ret;
}

int32_t BCM_GetResultAT(uint32_t aIndex)
{
    int32_t ret = BCM_AT_NOT_AVAILABLE;

    if (1UL == aIndex) {
        ret = ETHXCVR_TestResult;
    }
    return ret;
}

void APP_Init()
{
}

void ETHXCVR_ModeIndication(ETHXCVR_IDType aID, ETHXCVR_ModeType aMode)
{
    ULOG_INFO("Received ModeIndication mode=%u for port=%u\n", aMode, aID);
}

