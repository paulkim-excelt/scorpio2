/*****************************************************************************
 Copyright 2020 Broadcom Limited.  All rights reserved.

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
#include <bcm_utils.h>
#include <bcm_test.h>
#include <osil/bcm_osil.h>
#include <eth_switch.h>
#include <ethswt_fa.h>

#define GetModuleLogLevel()         ULOG_LVL_ERROR
#define ETHSWT_FAQT_DELAY_EVENT     SystemEvent4
#define ETHSWT_FAQT_INTERNAL        0
/* IN Port VLAN ID, PORT Mask, Umtagged Mask */
#define ETHSWT_FAQT_VLANID0         900
#define ETHSWT_FAQT_PORT_MASK0      0x82
#define ETHSWT_FAQT_UNTAGGED_MASK0  0x82

/*Out Port VLAN ID, PORT Mask, Umtagged Mask */
#define ETHSWT_FAQT_VLANID1         11
#define ETHSWT_FAQT_PORT_MASK1      0x90
#define ETHSWT_FAQT_UNTAGGED_MASK1  0x90

static const uint8_t ETHSWT_FAQtMacs[4UL][6UL] = {
    {0x00U, 0x11U, 0x22U, 0x33U, 0x44U, 0x03U},
    {0x10U, 0x11U, 0x22U, 0x33U, 0x44U, 0x03U},
    {0x00U, 0x11U, 0x22U, 0x33U, 0x44U, 0x01U},
    {0x10U, 0x11U, 0x22U, 0x33U, 0x44U, 0x01U},
};

static int32_t ETHSWT_FAQt1Result = BCM_AT_NOT_STARTED;
static int32_t ETHSWT_FAQt2Result = BCM_AT_NOT_STARTED;
static uint16_t ETHSWT_FAQtEnData = 0U;

static const ETHSWT_FACfgType ETHSWT_FAQtInitCfg[2UL] = {
    {/* Normal */
        .unimacCfg = {
            .maxFrameLength = 1522UL,
            .enableExternalConfig = 1U,
            .speed = 0U,
            .loopBack = UNIMAC_LOOPBACK_NONE,
            .macAddr = {0U, 0U, 0U, 0U, 0U, 0U},
        },
        .ctfCfg = {
            .mode = ETHSWT_FACTFMODE_NORMAL,
            .crc = ETHSWT_FACRC_CCITT,
            .seedValue = 0UL,
            .timestampPeriodSec = 1UL,
            .validateMatchDA = TRUE,
        },
    },
    {/* Bypass */
        .unimacCfg = {
            .maxFrameLength = 1522UL,
            .enableExternalConfig = 1U,
            .speed = 0U,
            .loopBack = UNIMAC_LOOPBACK_NONE,
            .macAddr = {0U, 0U, 0U, 0U, 0U, 0U},
        },
        .ctfCfg = {
            .mode = ETHSWT_FACTFMODE_BYPASS,
            .crc = ETHSWT_FACRC_CCITT,
            .seedValue = 0UL,
            .timestampPeriodSec = 3UL,
            .validateMatchDA = TRUE,
        },
    },
};

static const ETHSWT_FAFlowType FA_QtFlows[2UL] = {
    {
        .match = {
            .da = {0x00U, 0x11U, 0x22U, 0x33U, 0x44U, 0x03U},
            .srcPort = 40000UL,
            .dstPort = 50000UL,
            .srcIp = {0xAU, 0x14U, 0x1EU, 0x28U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U},
            .dstIp = {0xAU, 0x14U, 0x1EU, 0x29U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U},
            .flags = 0U,
        },
        .remap = {
            .operation = ETHSWT_FAOPERATION_S_TAG,
            .sa = {0x00U, 0x11U, 0x22U, 0x33U, 0x44U, 0x03U},
            .da = {0xAAU, 0xBBU, 0xCCU, 0xDDU, 0xEEU, 0x0BU},
            .vlan = (3U << 13UL) | 11U,
            .port = 0U,
            .ip = {0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U},
            .tc = ETHSWT_TC_0,
            .te = ETHSWT_TE_NONE,
            .portMask = 0U,
        },
        .valid = ETHSWT_FAFLOWVALID_TILLREBOOT,
    },
    {
        .match = {
            .da = {0x10U, 0x11U, 0x22U, 0x33U, 0x44U, 0x03U},
            .srcPort = 40000UL,
            .dstPort = 50000UL,
            .srcIp = {0x0AU,0x14U,0x1E,0x28},
            .dstIp = {0x0AU,0x14U,0x1E,0x29},
            .flags = ETHSWT_FAFLAGS_L3IPV4 | ETHSWT_FAFLAGS_L4TCP,
        },
        .remap = {
            .operation = ETHSWT_FAOPERATION_C_TAG,
            .sa = {0x10U, 0x11U, 0x22U, 0x33U, 0x44U, 0x03U},
            .da = {0xAAU, 0xBBU, 0xCCU, 0xDDU, 0xEEU, 0x0BU},
            .vlan = (3U << 13UL) | 11U,
            .port = 0U,
            .ip = {0x0U,0x0U,0x0U,0x0U},
            .tc = ETHSWT_TC_0,
            .te = ETHSWT_TE_NONE,
            .portMask = 0U,
        },
        .valid = ETHSWT_FAFLOWVALID_TILLDELETE,
    },
};

static void ETHSWT_FAQTIrqCb ()
{
    ETHSWT_FAStatsType faStats;
    ETHSWT_FAFlowStatusType flowStatus;

    ETHSWT_FAStats(ETHSWT_HW_ID_0, ETHSWT_FAID_0, &faStats, &flowStatus);
}

static void ETHSWT_FAQTDelay(uint32_t aTicks)
{
    BCM_EventMaskType     mask;

    /* Now wait for upto aTicks */
    BCM_SetRelAlarm(DelayTimerAlarm, aTicks, 0U);
    BCM_WaitEvent(ETHSWT_FAQT_DELAY_EVENT);
    BCM_GetEvent(ETHSWT_FAQtTask, &mask);
    if (mask & ETHSWT_FAQT_DELAY_EVENT) {
        BCM_ClearEvent(ETHSWT_FAQT_DELAY_EVENT);
    }
    if (mask & ETHSWT_FA_PROCESS_IRQ_EVENT) {
        BCM_ClearEvent(ETHSWT_FA_PROCESS_IRQ_EVENT);
        ETHSWT_FAQTIrqCb();
    }
    /* Disable the alarm so that it can be reused */
    BCM_CancelAlarm(DelayTimerAlarm);
}

int32_t ETHSWT_FAQTSequence1(void)
{
    int32_t retVal = BCM_ERR_OK;
    uint16_t flowID1;
    uint16_t flowID2;
    uint16_t count;
    uint16_t flowBit;
    uint16_t flowIdFound = FALSE;
    uint16_t macFound = 0U;
    int32_t i;
    ETHSWT_FAFlowType flow;
    ETHSWT_FAStatsType faStats;
    ETHSWT_FAFlowStatsType flowStats;
    ETHSWT_FAFlowStatusType flowStatus;
    ETHSWT_FAPoolTableInfoType poolTable;

    ULOG_ERR("SEQ.Step1....");
    ETHSWT_FAInit(ETHSWT_HW_ID_0, ETHSWT_FAID_0, &ETHSWT_FAQtInitCfg[0]);
    ULOG_ERR("Done\n");

    ULOG_ERR("SEQ.Step2....");
    /* Add a New MAC Address */
    retVal = ETHSWT_FAMacAdd(ETHSWT_HW_ID_0, ETHSWT_FAID_0, &ETHSWT_FAQtMacs[0UL][0UL], ETHSWT_FAQT_INTERNAL);
    if(BCM_ERR_OK != retVal) {
        goto error;
    }

    /* Add a New MAC Address */
    retVal = ETHSWT_FAMacAdd(ETHSWT_HW_ID_0, ETHSWT_FAID_0, &ETHSWT_FAQtMacs[1UL][0UL], ETHSWT_FAQT_INTERNAL);
    if(BCM_ERR_OK != retVal) {
        goto error;
    }
    ULOG_ERR("Done\n");

    ULOG_ERR("SEQ.Step3....");
    retVal = ETHSWT_FAMacPoolGet(ETHSWT_HW_ID_0, ETHSWT_FAID_0, &poolTable);
    if(BCM_ERR_OK != retVal) {
        goto error;
    } else {
        /* check the macID 2 is added or not */
        for(i=0; i<ETHSWT_FA_POOL_MAX; i++) {
            if(0UL == memcmp(&poolTable.macInfo[i].mac[0UL], &ETHSWT_FAQtMacs[1UL][0UL],6U)) {
                macFound = 1U;
                break;
            }
        }
        if(1U != macFound) {
            retVal = BCM_ERR_CUSTOM;
            goto error;
        }
    }
    ULOG_ERR("Done\n");

    ULOG_ERR("SEQ.Step4....");
    /* Add VlanID InPort*/
    retVal = ETHSWT_AddVLANPorts(ETHSWT_HW_ID_0, ETHSWT_FAQT_PORT_MASK0, ETHSWT_FAQT_VLANID0, ETHSWT_FAQT_UNTAGGED_MASK0);
    if(BCM_ERR_OK != retVal) {
        goto error;
    }

    /* Add VlanID OutPort*/
    retVal = ETHSWT_AddVLANPorts(ETHSWT_HW_ID_0, ETHSWT_FAQT_PORT_MASK1, ETHSWT_FAQT_VLANID1, ETHSWT_FAQT_UNTAGGED_MASK1);
    if(BCM_ERR_OK != retVal) {
        goto error;
    }


    retVal = ETHSWT_FAFlowAdd(ETHSWT_HW_ID_0, ETHSWT_FAID_0, &FA_QtFlows[0], &flowID1);
    if(BCM_ERR_OK != retVal) {
        goto error;
    }

    retVal = ETHSWT_FAFlowAdd(ETHSWT_HW_ID_0, ETHSWT_FAID_0, &FA_QtFlows[1], &flowID2);
    if(BCM_ERR_OK != retVal) {
        goto error;
    }
    ULOG_ERR("Done\n");

    ULOG_ERR("SEQ.Step5....");
    retVal = ETHSWT_FAStats(ETHSWT_HW_ID_0, ETHSWT_FAID_0, &faStats, &flowStatus);
    if(BCM_ERR_OK != retVal) {
        goto error;
    }
    for(count =0; count <(ETHSWT_FA_FLOWS_MAX / 8UL); count++) {
        if(FALSE != (flowStatus.activeMask[count])) {
            for (flowBit=0; flowBit<8UL; flowBit++) {
                if(TRUE == ((flowStatus.activeMask[count] >> flowBit) & 0x1U)) {
                    if(flowID2 == ((count * 8) + flowBit))
                    {
                        flowIdFound = TRUE;
                        count = (ETHSWT_FA_FLOWS_MAX / 8UL);
                        break;
                    }
                }
            }
        }
    }
    if(FALSE == flowIdFound) {
        retVal = BCM_ERR_UNKNOWN;
        goto error;
    }
    ULOG_ERR("Done\n");


    ULOG_ERR("SEQ.Step6....");
    retVal = ETHSWT_FAFlowGet(ETHSWT_HW_ID_0, ETHSWT_FAID_0, flowID1, &flow, &flowStats);
    if((BCM_ERR_OK != retVal)
          || (0UL != memcmp(&FA_QtFlows[0], &flow, sizeof(ETHSWT_FAFlowType)))) {
        retVal = BCM_ERR_CUSTOM;
        goto error;
    }
    ULOG_ERR("Done\n");

    ULOG_ERR("SEQ.Step7....");
    retVal = ETHSWT_FAFlowGet(ETHSWT_HW_ID_0, ETHSWT_FAID_0, flowID2, &flow, &flowStats);
    if((BCM_ERR_OK != retVal)
          || (0UL != memcmp(&FA_QtFlows[1], &flow, sizeof(ETHSWT_FAFlowType)))) {
        retVal = BCM_ERR_CUSTOM;
        goto error;
    }
    ULOG_ERR("Done\n");

    ETHSWT_FAEnableInterrupt(ETHSWT_HW_ID_0, ETHSWT_FAID_0, 0x03FFFFFFFL);

    ULOG_ERR("SEQ.Step8....");
    retVal = ETHSWT_FAStats(ETHSWT_HW_ID_0, ETHSWT_FAID_0, &faStats, &flowStatus);
    if(BCM_ERR_OK != retVal) {
        goto error;
    }
    ULOG_ERR("Done\n");


    if(1U == ETHSWT_FAQtEnData)
    {
        ULOG_ERR("Waiting For Data Transfer");
        for(i=10;i>=0;i--) {
            ETHSWT_FAQTDelay(300);
            ULOG_ERR(".");
            ETHSWT_FAQTDelay(300);
            ULOG_ERR(".");
            ETHSWT_FAQTDelay(300);
            ULOG_ERR("%d", i);
        }
        ULOG_ERR("\n");
    }

    ULOG_ERR("SEQ.Step9...");
    ULOG_ERR("Timer Test...");
    /* check weather the timer overflow after count 7 */
    for(count=0; count<10; count++)
    {
        ETHSWT_FATimer(ETHSWT_HW_ID_0,ETHSWT_FAID_0);
        ETHSWT_FAQTDelay(500);
        retVal = ETHSWT_FAStats(ETHSWT_HW_ID_0, ETHSWT_FAID_0, &faStats, &flowStatus);
        if(BCM_ERR_OK != retVal) {
            goto error;
        }
        ULOG_ERR("%d",faStats.currentTimestamp);
        if(((5U == count) && (6UL != faStats.currentTimestamp))
                   ||((9U == count) && (2UL != faStats.currentTimestamp)))
        {
            retVal = BCM_ERR_UNKNOWN;
            goto error;
        }
    }
    ULOG_ERR("...Done\n");
    ETHSWT_FAQTDelay(500);

    ULOG_ERR("SEQ.Step10....");
    /* Negative test case. MAC Delete should fail as it is in use by Flow */
    retVal = ETHSWT_FAMacDelete(ETHSWT_HW_ID_0, ETHSWT_FAID_0, &ETHSWT_FAQtMacs[0UL][0UL]);
    if(BCM_ERR_BUSY != retVal) {
        goto error;
    }
    ULOG_ERR("Done\n");

    /* Delete a Flow VALID_TILL_REBOOT */
    ULOG_ERR("SEQ.Step11....");
    retVal = ETHSWT_FAFlowDelete(ETHSWT_HW_ID_0, ETHSWT_FAID_0, flowID1);
    if(BCM_ERR_NOPERM != retVal) {
        goto error;
    }
    ULOG_ERR("Done\n");

    /* Delete a Flow VALID_TILL_DELETE */
    ULOG_ERR("SEQ.Step12....");
    retVal = ETHSWT_FAFlowDelete(ETHSWT_HW_ID_0, ETHSWT_FAID_0, flowID2);
    if(BCM_ERR_OK != retVal) {
        goto error;
    }
    ULOG_ERR("Done\n");

    ULOG_ERR("SEQ.Step13....");
    retVal = ETHSWT_FAStats(ETHSWT_HW_ID_0, ETHSWT_FAID_0, &faStats, &flowStatus);
    if(BCM_ERR_OK != retVal) {
        goto error;
    }
    flowIdFound = FALSE;
    for(count =0; count <(ETHSWT_FA_FLOWS_MAX / 8UL); count++) {
        if(FALSE != (flowStatus.activeMask[count])) {
            for (flowBit=0; flowBit<8UL; flowBit++) {
                if(TRUE == ((flowStatus.activeMask[count] >> flowBit) & 0x1U)) {
                    if(flowID2 == ((count * 8) + flowBit))
                    {
                        flowIdFound = TRUE;
                        count = (ETHSWT_FA_FLOWS_MAX / 8UL);
                        break;
                    }
                }
            }
        }
    }
    if(TRUE == flowIdFound) {
        retVal = BCM_ERR_UNKNOWN;
        goto error;
    }
    ULOG_ERR("Done\n");

    ULOG_ERR("SEQ.Step14...");
    retVal = ETHSWT_FAMacDelete(ETHSWT_HW_ID_0, ETHSWT_FAID_0, &ETHSWT_FAQtMacs[1UL][0UL]);
    if(BCM_ERR_OK != retVal) {
        goto error;
    }
    ULOG_ERR("Done\n");

    ULOG_ERR("SEQ.Step15...");
    /* verify for mac ID is deleted */
    retVal = ETHSWT_FAMacPoolGet(ETHSWT_HW_ID_0, ETHSWT_FAID_0, &poolTable);
    if(BCM_ERR_OK != retVal) {
        goto error;
    } else {
        macFound = 0U;
        /* check the macID 2 is deleted or not */
        for(int32_t i=0; i<ETHSWT_FA_POOL_MAX; i++) {
            if(0UL == memcmp(&poolTable.macInfo[ETHSWT_FA_POOL_MAX].mac[0UL], &ETHSWT_FAQtMacs[1UL][0UL],6U)) {
                macFound = 1U;
                break;
            }
        }
        if(1U == macFound) {
            retVal = BCM_ERR_CUSTOM;
            goto error;
        }
    }
    ULOG_ERR("Done\n");

    ULOG_ERR("SEQ.Step16...");
    retVal = ETHSWT_FAFlowGet(ETHSWT_HW_ID_0, ETHSWT_FAID_0, flowID2, &flow, &flowStats);
    if(BCM_ERR_INVAL_PARAMS != retVal) {
        goto error;
    }
    ULOG_ERR("Done\n");

    ULOG_ERR("SEQ.Step17...");
    ETHSWT_FADeinit(ETHSWT_HW_ID_0, ETHSWT_FAID_0);
    ULOG_ERR("Done\n");

    ULOG_ERR("SEQ.Step18...");
    /* Add New MAC Address and check for failure*/
    retVal = ETHSWT_FAMacAdd(ETHSWT_HW_ID_0, ETHSWT_FAID_0, &ETHSWT_FAQtMacs[2UL][0UL], ETHSWT_FAQT_INTERNAL);
    if(retVal != BCM_ERR_UNINIT) {
        goto error;
    }
    ULOG_ERR("Done\n");

    ULOG_ERR("SEQ.Step19...");
    ETHSWT_FAInit(ETHSWT_HW_ID_0, ETHSWT_FAID_0, &ETHSWT_FAQtInitCfg[1]);
    ULOG_ERR("Done\n");

    ULOG_ERR("SEQ.Step20...");
    retVal = ETHSWT_FAFlowAdd(ETHSWT_HW_ID_0, ETHSWT_FAID_0, &FA_QtFlows[1], &flowID2);
    if(BCM_ERR_INVAL_STATE != retVal) {
        goto error;
    }
    ULOG_ERR("Done\n");

    /* De-initialize to execute testcase again */
    ULOG_ERR("SEQ.Step21...");
    ETHSWT_FADeinit(ETHSWT_HW_ID_0, ETHSWT_FAID_0);
    ULOG_ERR("Done\n");

    retVal = BCM_ERR_OK;

error:
    return retVal;
}

TASK(ETHSWT_FAQtTask)
{
    int32_t retVal;

    retVal = ETHSWT_FAQTSequence1();
    if(BCM_ERR_OK != retVal) {
        ULOG_ERR("FAILED retVal = %d\n",retVal);
    }
    if (BCM_AT_EXECUTING == ETHSWT_FAQt1Result) {
        ETHSWT_FAQt1Result = retVal;
    } else if(BCM_AT_EXECUTING == ETHSWT_FAQt2Result) {
        ETHSWT_FAQt2Result = retVal;
    }
    ULOG_ERR("\nTest completed");

    BCM_TerminateTask();
}

void DelayTimerAlarmCb(void)
{
    SetEvent(ETHSWT_FAQtTask, ETHSWT_FAQT_DELAY_EVENT);
}

int32_t BCM_ExecuteAT(uint32_t aIndex)
{
    int32_t retVal;

    if ((1UL == aIndex) && ((BCM_AT_NOT_STARTED == ETHSWT_FAQt2Result)
                             || (BCM_ERR_OK == ETHSWT_FAQt2Result))) {
        if (BCM_AT_EXECUTING != ETHSWT_FAQt1Result) {
            retVal = BCM_ActivateTask(ETHSWT_FAQtTask);
            if (BCM_ERR_OK == retVal) {
                ETHSWT_FAQt1Result = BCM_AT_EXECUTING;
                ETHSWT_FAQtEnData = 0U;
            } else {
                ETHSWT_FAQt1Result = BCM_AT_NOT_STARTED;
                retVal = BCM_AT_NOT_STARTED;
            }
        } else {
            retVal = BCM_ERR_OK;
        }
    } else if ((2UL == aIndex) && ((BCM_AT_NOT_STARTED == ETHSWT_FAQt1Result)
                             || (BCM_ERR_OK == ETHSWT_FAQt1Result))) {
        if (BCM_AT_EXECUTING != ETHSWT_FAQt2Result) {
            retVal = BCM_ActivateTask(ETHSWT_FAQtTask);
            if (BCM_ERR_OK == retVal) {
                ETHSWT_FAQt2Result = BCM_AT_EXECUTING;
                ETHSWT_FAQtEnData = 1U;
            } else {
                ETHSWT_FAQt2Result = BCM_AT_NOT_STARTED;
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
        ret = ETHSWT_FAQt1Result;
    } else if(2UL == aIndex) {
        ret = ETHSWT_FAQt2Result;
    }
    return ret;
}

void APP_Init()
{
}
