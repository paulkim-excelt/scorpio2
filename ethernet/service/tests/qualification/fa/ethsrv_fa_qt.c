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
#include <ethsrv_fa_rpc.h>
#include <ethsrv_ipc.h>
#include <bcm_time.h>

#define GetModuleLogLevel()     ULOG_LVL_ERROR

/* remove these 2 events */
#define ETHSRV_FA_QT_PROCESS     SystemEvent0

#define ETHSRV_FA_QT_STATIC_NO_OF_IPV4_FLOW   1UL

#define ETHSRV_FA_QT_STATIC_NO_OF_IPV6_FLOW    1UL

#define ETHSRV_FA_QT_DYNAMIC_NO_OF_FLOWS   1UL

#define ETHSRV_FA_QT_STATIC_NO_OF_FLOW    ((ETHSRV_FA_QT_STATIC_NO_OF_IPV4_FLOW) \
                                         + (2 * (ETHSRV_FA_QT_STATIC_NO_OF_IPV6_FLOW)))

#define ETHSRV_FA_STATIC_MACS    3UL

uint32_t ETHSRV_QTReplyLen;
uint32_t ETHSRV_QTFwdToSlaves;
ETHSRV_FAFlowIDType ETHSRV_QTstaticFlowID[5];
ETHSRV_FAFlowIDType ETHSRV_QTactiveFlowID[5];
#ifdef __BCM89564G__
uint8_t ETHSRV_FAQTOutPayLoad[RPC_RESPPAYLOADSZ];
uint8_t ETHSRV_FAQTInPayLoad2[RPC_RESPPAYLOADSZ];
#endif

static int32_t ETHSRV_FAQTResult = BCM_AT_NOT_STARTED;

static ETHSRV_FAFlowOperationType ETHSRV_FAQTFlowsPos[2UL] = {
    [0] = {
        .flow ={
            .match = {
                .da = {0x00U, 0x11U, 0x22U, 0x33U, 0x44U, 0x03U},
                .srcPort = 40001UL,
                .dstPort = 50000UL,
                .srcIp = {0xAU, 0x14U, 0x1EU, 0x28U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U},
                .dstIp = {0xAU, 0x14U, 0x1EU, 0x29U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U},
                .flags = ETHSWT_FAFLAGS_L3IPV4,
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
            .mstSlvDevice = MCU_DEVICE_MASTER,
        },
        .flowID =0,
        .flowStats = {0},
    },
    [1] = {
        .flow ={

            .match = {
                .da = {0x00U, 0x11U, 0x22U, 0x33U, 0x44U, 0x03U},
                .srcPort = 40001UL,
                .dstPort = 50001UL,
                .srcIp = {0xAU, 0x14U, 0x1EU, 0x28U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U},
                .dstIp = {0xAU, 0x14U, 0x1EU, 0x29U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U},
                .flags = ETHSWT_FAFLAGS_L3IPV4,
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
            .mstSlvDevice = MCU_DEVICE_MASTER,
        },
        .flowID =0,
        .flowStats = {0},
    },
};

static ETHSRV_FAFlowOperationType ETHSRV_FAQTFlowsNeg[2UL] = {
    [0] = {
        .flow ={
            .match = {
                .da = {0x40U, 0x11U, 0x22U, 0x33U, 0x44U, 0x03U},
                .srcPort = 40000UL,
                .dstPort = 50000UL,
                .srcIp = {0xAU, 0x14U, 0x1EU, 0x28U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U},
                .dstIp = {0xAU, 0x14U, 0x1EU, 0x29U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U},
                .flags = ETHSWT_FAFLAGS_L3IPV4,
            },
            .remap = {
                .operation = ETHSWT_FAOPERATION_S_TAG,
                .sa = {0x40U, 0x11U, 0x22U, 0x33U, 0x44U, 0x03U},
                .da = {0xAAU, 0xBBU, 0xCCU, 0xDDU, 0xEEU, 0x0BU},
                .vlan = (3U << 13UL) | 11U,
                .port = 0U,
                .ip = {0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U},
                .tc = ETHSWT_TC_0,
                .te = ETHSWT_TE_NONE,
                .portMask = 0U,
            },
            .mstSlvDevice = MCU_DEVICE_MASTER,
        },
        .flowID =0,
        .flowStats = {0},
    },
    [1] = {
        .flow ={

            .match = {
                .da = {0x00U, 0x11U, 0x22U, 0x33U, 0x44U, 0x03U},
                .srcPort = 40001UL,
                .dstPort = 50001UL,
                .srcIp = {0xAU, 0x14U, 0x1EU, 0x28U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U},
                .dstIp = {0xAU, 0x14U, 0x1EU, 0x29U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U},
                .flags = ETHSWT_FAFLAGS_L3IPV4,
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
            .mstSlvDevice = MCU_DEVICE_MASTER,
        },
        .flowID =0,
        .flowStats = {0},
    },
};

static ETHSWT_FACtfCfgType ETHSRV_FAQTCtfCfgNormal = {
        .mode = ETHSWT_FACTFMODE_NORMAL,
        .crc = ETHSWT_FACRC_CCITT,
        .seedValue = 0,
        .timestampPeriodSec = 2,
        .validateMatchDA = TRUE
};

static ETHSWT_FACtfCfgType ETHSRV_FAQTCtfCfgBypass = {
        .mode = ETHSWT_FACTFMODE_BYPASS,
        .crc = ETHSWT_FACRC_CCITT,
        .seedValue = 0,
        .timestampPeriodSec = 2,
        .validateMatchDA = TRUE
};

static const uint8_t ETHSRV_FAQTMacs[4UL][6UL] = {
    {0x00U, 0x11U, 0x22U, 0x33U, 0x44U, 0x03U},
    {0x20U, 0x11U, 0x22U, 0x33U, 0x44U, 0x03U},
    {0x00U, 0x11U, 0x22U, 0x33U, 0x44U, 0x01U},
    {0x10U, 0x11U, 0x22U, 0x33U, 0x44U, 0x01U},
};

/* This is to be updated with the Static configuration */
static uint8_t ETHSRV_FAQTSTaticMacs[ETHSRV_FA_STATIC_MACS][6UL] = {
    {0x00U, 0x11U, 0x22U, 0x33U, 0x44U, 0x03U},
    {0x10U, 0x11U, 0x22U, 0x33U, 0x44U, 0x03U},
    {0x00U, 0x00U, 0x00U, 0x00U, 0x00U, 0x00U},
};

static int32_t ETHSRV_FAQTGetFAFlowCount(ETHSRV_FAFlowStatusType *aFlowStatus, ETHSRV_FAFlowIDType *aflowID)
{
    uint32_t flow;
    uint32_t flowBit;
    uint32_t count = 0UL;

    for(flow =0; flow <(ETHSWT_FA_FLOWS_MAX / 8UL); flow++) {
        if(FALSE != (aFlowStatus->mask[flow])) {
            for (flowBit=0; flowBit<8UL; flowBit++) {
                if(TRUE == ((aFlowStatus->mask[flow] >> flowBit) & 0x1U)) {
                    aflowID[count] = ((flow * 8) + flowBit);
                    count++;
                }
            }
        }
    }
    return count;
}

static int32_t ETHSRV_FAQTFlowValidate(ETHSRV_FAFlowType *flow1, ETHSRV_FAFlowType *flow2)
{
    int32_t retVal = BCM_ERR_UNKNOWN;

    /* FA FLOW Match Parameters */
    if((0UL != memcmp(&flow1->match.da[0], &flow2->match.da[0], 6U))
         ||(flow1->match.srcPort != flow2->match.srcPort)
         ||(flow1->match.dstPort != flow2->match.dstPort)
         ||(flow1->match.flags != flow2->match.flags)) {
            goto err_exit;
    }

    if(ETHSWT_FAFLAGS_L3IPV4 == flow1->match.flags) {
        if((0UL != memcmp(&flow1->match.srcIp[0], &flow2->match.srcIp[0], 4U))
            ||(0UL != memcmp(&flow1->match.dstIp[0], &flow2->match.dstIp[0], 4U))) {
            goto err_exit;
        }
    } else {
        if((0UL != memcmp(&flow1->match.srcIp[0], &flow2->match.srcIp[0], 16U))
            ||(0UL != memcmp(&flow1->match.dstIp[0], &flow2->match.dstIp[0], 16U))) {
            goto err_exit;
        }
    }

    /* FA FLOW Remap Parameters */
    if((flow1->remap.operation != flow2->remap.operation)
            || (0UL != memcmp(&flow1->remap.sa[0], &flow2->remap.sa[0], 6U))
            || (0UL != memcmp(&flow1->remap.da[0], &flow2->remap.da[0], 6U))
            || (flow1->remap.vlan != flow2->remap.vlan)
            || (flow1->remap.port != flow2->remap.port)
            || (flow1->remap.tc != flow2->remap.tc)
            || (flow1->remap.tc != flow2->remap.tc)
            || (flow1->remap.portMask != flow2->remap.portMask)) {
            goto err_exit;
    }

    if(ETHSWT_FAFLAGS_L3IPV4 == flow1->match.flags) {
        if(0UL != memcmp(&flow1->remap.ip[0], &flow2->remap.ip[0], 4U)) {
            goto err_exit;
        }
    } else {
        if(0UL != memcmp(&flow1->remap.ip[0], &flow2->remap.ip[0], 16U)) {
            goto err_exit;
        }
    }
    retVal = BCM_ERR_OK;

err_exit:
    return retVal;
}

static int32_t ETHSRV_FASendRecv(uint8_t aCmdID, BCM_CompIDType aCompID,
                              uint8_t *aCmd, uint32_t aLen,
                              const uint32_t aClientMask,
                              const MSGQ_MsgHdrType* pHdr,
                              uint32_t *aForwardToSlaves,
                              uint32_t *aReplyLen)
{
    BCM_EventMaskType mask;
    int32_t retVal = BCM_ERR_OK;

    if((NULL == aCmd) ||(NULL == pHdr)
                ||(NULL == aForwardToSlaves) ||(NULL == aReplyLen)){
        ULOG_ERR(" Invalid Parameters\n");
    }

    retVal = ETHSRV_FA.sendCmd(aCmdID, aCompID, aCmd, aLen, aClientMask, &pHdr, aForwardToSlaves);
    if (retVal != BCM_ERR_OK) {
        ULOG_ERR("Failed to send Command\n");
        goto err_exit;
    }

    /* Wait for server to process the request */
    (void)BCM_WaitEvent(aClientMask);
    (void)BCM_GetEvent(ETHSRV_FAQTTask, &mask);
    if (0UL != (mask & aClientMask)) {
        (void)BCM_ClearEvent(aClientMask);
    }
    retVal = ETHSRV_FA.getStatus(pHdr, aCompID, &aCmdID, aCmd, aReplyLen);
    if (retVal != BCM_ERR_OK) {
        ULOG_ERR("Unable to Receive Response..");
        goto err_exit;
    }

err_exit:
    return retVal;
}

/* Get the configured MAC addresses */
static int32_t ETHSRV_FAQTMacpoolGet (const MSGQ_MsgHdrType* pHdr)
{
    int32_t i;
    int32_t retVal;
    uint8_t macZero[6UL] = {0};
    ETHSRV_FAMacSnapshotType macSnapshot;
#ifdef __BCM89564G__
    ETHSRV_FAMacSnapshotType macSnapshotOut;
    int32_t result;
    int32_t inResult1;
    int32_t inResult2;

    inResult1 = BCM_ERR_OK;
    inResult2 = BCM_ERR_OK;
#endif

    ULOG_ERR("TC1....");
    retVal = ETHSRV_FASendRecv(ETHSRV_ETHSWTCMDID_FA_MAC_SNAPSHOT,BCM_SWT_ID,
                               (uint8_t*)&macSnapshot,sizeof(ETHSRV_FAMacSnapshotType),
                               ETHSRV_FA_QT_PROCESS, pHdr,&ETHSRV_QTFwdToSlaves, &ETHSRV_QTReplyLen);

    if((BCM_ERR_OK != retVal)  || (FALSE == ETHSRV_QTFwdToSlaves)) {
        retVal = BCM_ERR_UNKNOWN;
        ULOG_ERR("FAIL\n");
        goto err_exit;
    } else {
        for (i=0; i<ETHSRV_FA_STATIC_MACS; i++) {
            if(0UL == memcmp(&macZero[0], &ETHSRV_FAQTSTaticMacs[i][0],6U)) {
                memcpy(&ETHSRV_FAQTSTaticMacs[i][0],&macSnapshot.deviceMac[0],6U);
            }
        }
        if((0UL == memcmp(&macSnapshot.info[0][0].mac[0], &ETHSRV_FAQTSTaticMacs[0][0],6U))
            && (0UL == memcmp(&macSnapshot.info[0][1].mac[0], &ETHSRV_FAQTSTaticMacs[1][0],6U))
            && (0UL == memcmp(&macSnapshot.info[0][2].mac[0], &ETHSRV_FAQTSTaticMacs[2][0],6U))) {
            ULOG_ERR("PASS\n");
        } else {
            retVal = BCM_ERR_UNKNOWN;
            ULOG_ERR("FAIL\n");
        }
    }

#ifdef __BCM89564G__
    retVal = ETHSRV_FA.mergeResult(ETHSRV_ETHSWTCMDID_FA_MAC_SNAPSHOT, BCM_SWT_ID,
                                     sizeof(ETHSRV_FAMacSnapshotType), (uint8_t*)&macSnapshotOut, &result,
                                     (uint8_t*)&macSnapshot, inResult1, (uint8_t*)&macSnapshot, inResult2);
    if(BCM_ERR_OK != retVal) {
        ULOG_ERR("MacSnapShot Merge FAIL\n");
    } else {
        if((0UL == memcmp(&macSnapshot.info[0], &macSnapshotOut.info[0],sizeof(ETHSRV_FAMacInfoType)))
        && (0UL == memcmp(&macSnapshot.deviceMac[0], &macSnapshotOut.deviceMac[0], 6U))) {
            ULOG_ERR(" MacSnapShot Merge PASS\n");

        } else {
            retVal = BCM_ERR_UNKNOWN;
            ULOG_ERR("MacSnapShot Merge FAIL\n");
        }
    }
#endif
err_exit:
    return retVal;

}

/* Add an existing MAC address */
static int32_t ETHSRV_FAQTMacAddExisting (const MSGQ_MsgHdrType* pHdr)
{
    int32_t retVal;
    ETHSRV_FAMacOperationType macOp;

    ULOG_ERR("TC2....");
    BCM_MemCpy(&macOp.info.mac[0UL], &ETHSRV_FAQTMacs[0UL][0UL],6UL);
    macOp.info.external = FALSE;
    macOp.mstSlvDevice = MCU_DEVICE_MASTER;
    retVal = ETHSRV_FASendRecv(ETHSRV_ETHSWTCMDID_FA_MAC_ADD,BCM_SWT_ID,
                               (uint8_t*)&macOp, sizeof(ETHSRV_FAMacOperationType),
                                ETHSRV_FA_QT_PROCESS, pHdr,&ETHSRV_QTFwdToSlaves,&ETHSRV_QTReplyLen);
    if((BCM_ERR_OK != retVal)  || (FALSE != ETHSRV_QTFwdToSlaves)) {
        retVal = BCM_ERR_UNKNOWN;
        ULOG_ERR("FAIL\n");
    } else {
        ULOG_ERR("PASS\n");
    }
    return retVal;
}

/* Add a new MAC address */
static int32_t ETHSRV_FAQTMacAddNew (const MSGQ_MsgHdrType* pHdr)
{
    int32_t retVal;
    ETHSRV_FAMacOperationType macOp;

    ULOG_ERR("TC3....");
    BCM_MemCpy(&macOp.info.mac[0UL], &ETHSRV_FAQTMacs[1UL][0UL],6UL);
    macOp.info.external = FALSE;
    macOp.mstSlvDevice = MCU_DEVICE_MASTER;
    retVal = ETHSRV_FASendRecv(ETHSRV_ETHSWTCMDID_FA_MAC_ADD,BCM_SWT_ID,
                              (uint8_t*)&macOp,sizeof(ETHSRV_FAMacOperationType),
                              ETHSRV_FA_QT_PROCESS, pHdr,&ETHSRV_QTFwdToSlaves,&ETHSRV_QTReplyLen);
    if((BCM_ERR_OK != retVal)  || (FALSE != ETHSRV_QTFwdToSlaves)) {
        retVal = BCM_ERR_UNKNOWN;
        ULOG_ERR("FAIL\n");
    } else {
        ULOG_ERR("PASS\n");
    }

    return retVal;
}

/* Add flows one of the configured MACs */
static int32_t ETHSRV_FAQTFlowaddPos (const MSGQ_MsgHdrType* pHdr)
{
    int32_t retVal;

    ULOG_ERR("TC4....");
    retVal = ETHSRV_FASendRecv(ETHSRV_ETHSWTCMDID_FA_FLOW_ADD, BCM_SWT_ID,
                               (uint8_t*)&ETHSRV_FAQTFlowsPos[0],sizeof(ETHSRV_FAFlowOperationType),
                                ETHSRV_FA_QT_PROCESS, pHdr,&ETHSRV_QTFwdToSlaves,&ETHSRV_QTReplyLen);
    if((BCM_ERR_OK != retVal)
        || (((MCU_DEVICE_MASTER == ETHSRV_FAQTFlowsPos[0].flow.mstSlvDevice) && (TRUE == ETHSRV_QTFwdToSlaves))
            || ((MCU_DEVICE_SLAVE_1 == ETHSRV_FAQTFlowsPos[0].flow.mstSlvDevice) && (FALSE == ETHSRV_QTFwdToSlaves)))) {
        retVal = BCM_ERR_UNKNOWN;
        ULOG_ERR("FAIL\n");
    } else {
        ULOG_ERR("PASS\n");
    }

    return retVal;
}

/* Add flows with non-configured MAC */
static int32_t ETHSRV_FAQTFlowaddNeg (const MSGQ_MsgHdrType* pHdr)
{
    int32_t retVal;

    ULOG_ERR("TC5....");
    retVal = ETHSRV_FASendRecv(ETHSRV_ETHSWTCMDID_FA_FLOW_ADD, BCM_SWT_ID,
                               (uint8_t*)&ETHSRV_FAQTFlowsNeg[0],sizeof(ETHSRV_FAFlowOperationType),
                               ETHSRV_FA_QT_PROCESS, pHdr,&ETHSRV_QTFwdToSlaves,&ETHSRV_QTReplyLen);
    if((BCM_ERR_OK == retVal)
        || (((MCU_DEVICE_MASTER == ETHSRV_FAQTFlowsNeg[0].flow.mstSlvDevice) && (TRUE == ETHSRV_QTFwdToSlaves))
            || ((MCU_DEVICE_SLAVE_1 == ETHSRV_FAQTFlowsNeg[0].flow.mstSlvDevice) && (FALSE == ETHSRV_QTFwdToSlaves)))) {
        retVal = BCM_ERR_UNKNOWN;
        ULOG_ERR("FAIL\n");
    } else {
        retVal = BCM_ERR_OK;
        ULOG_ERR("PASS\n");
    }

    return retVal;
}

/* Get the configured flowstatus static flow masks */
static int32_t ETHSRV_FAQTGetFlowstatusGetStatic (const MSGQ_MsgHdrType* pHdr)
{
    int32_t retVal;
    int32_t flowCount;
    ETHSRV_FAFlowStatusType flowStatus;

    ULOG_ERR("TC6....");
    flowStatus.attribute = ETHSRV_FAATTRIBUTE_STATIC;
    flowStatus.mstSlvDevice = MCU_DEVICE_MASTER;
    retVal = ETHSRV_FASendRecv(ETHSRV_ETHSWTCMDID_FA_FLOW_STATUS, BCM_SWT_ID,
                               (uint8_t*)&flowStatus,sizeof(ETHSRV_FAFlowStatusType),
                               ETHSRV_FA_QT_PROCESS, pHdr,&ETHSRV_QTFwdToSlaves,&ETHSRV_QTReplyLen);
    if((BCM_ERR_OK != retVal)  || (FALSE != ETHSRV_QTFwdToSlaves)) {
        ULOG_ERR("FAIL\n");
    } else {
        flowCount =0;
        flowCount = ETHSRV_FAQTGetFAFlowCount(&flowStatus,&ETHSRV_QTstaticFlowID[0]);
        if (ETHSRV_FA_QT_STATIC_NO_OF_FLOW == flowCount) {
            ULOG_ERR("PASS\n");
        } else {
            retVal = BCM_ERR_UNKNOWN;
            ULOG_ERR("FAIL\n");
        }
    }

    return retVal;
}

/* Get the configured flowstatus active flow masks */
static int32_t ETHSRV_FAQTGetFlowstatusGetActive (const MSGQ_MsgHdrType* pHdr)
{
    int32_t retVal;
    int32_t flowCount;
    ETHSRV_FAFlowStatusType flowStatus;

    ULOG_ERR("TC7....");
    flowStatus.attribute = ETHSRV_FAATTRIBUTE_ACTIVE;
    flowStatus.mstSlvDevice = MCU_DEVICE_MASTER;
    retVal = ETHSRV_FASendRecv(ETHSRV_ETHSWTCMDID_FA_FLOW_STATUS, BCM_SWT_ID,
                               (uint8_t*)&flowStatus,sizeof(ETHSRV_FAFlowStatusType),
                               ETHSRV_FA_QT_PROCESS, pHdr,&ETHSRV_QTFwdToSlaves,&ETHSRV_QTReplyLen);
    if((BCM_ERR_OK != retVal)  || (FALSE != ETHSRV_QTFwdToSlaves)) {
        ULOG_ERR("FAIL\n");
    } else {
        flowCount =0;
        flowCount = ETHSRV_FAQTGetFAFlowCount(&flowStatus,&ETHSRV_QTactiveFlowID[0]);
        if ((ETHSRV_FA_QT_DYNAMIC_NO_OF_FLOWS +ETHSRV_FA_QT_STATIC_NO_OF_FLOW) == flowCount) {
            ULOG_ERR("PASS\n");
        } else {
            retVal = BCM_ERR_UNKNOWN;
            ULOG_ERR("FAIL\n");
        }
    }

    return retVal;
}

/* Retrieve flow paramters and compare them with configured values */
static int32_t ETHSRV_FAQTFlowget (const MSGQ_MsgHdrType* pHdr)
{
    int32_t retVal;
    ETHSRV_FAFlowOperationType flowOp = {0};

    ULOG_ERR("TC8....");
    flowOp.flowID = ETHSRV_FAQTFlowsPos[0].flowID;
    retVal = ETHSRV_FASendRecv(ETHSRV_ETHSWTCMDID_FA_FLOW_GET, BCM_SWT_ID,
                                (uint8_t*)&flowOp,sizeof(ETHSRV_FAFlowOperationType),
                                ETHSRV_FA_QT_PROCESS, pHdr,&ETHSRV_QTFwdToSlaves,&ETHSRV_QTReplyLen);
    if((BCM_ERR_OK != retVal)
        || (((MCU_DEVICE_MASTER == ETHSRV_FAQTFlowsPos[0].flow.mstSlvDevice) && (TRUE == ETHSRV_QTFwdToSlaves))
            || ((MCU_DEVICE_SLAVE_1 == ETHSRV_FAQTFlowsPos[0].flow.mstSlvDevice) && (FALSE == ETHSRV_QTFwdToSlaves)))) {
        retVal = BCM_ERR_UNKNOWN;
        ULOG_ERR("FAIL\n");
    } else {
        retVal = ETHSRV_FAQTFlowValidate(&ETHSRV_FAQTFlowsPos[0].flow, &flowOp.flow);
        if(BCM_ERR_OK == retVal) {
            ULOG_ERR("PASS\n");
        } else {
            ULOG_ERR("FAIL\n");
        }
    }

    return retVal;
}

/* Verify that Deletion a static flow fails */
static int32_t ETHSRV_FAQTFlowdeleteNeg (const MSGQ_MsgHdrType* pHdr)
{
    int32_t retVal;
    ETHSRV_FAFlowOperationType flowOp;

    ULOG_ERR("TC9....");
    flowOp.flowID = ETHSRV_QTstaticFlowID[0];
    retVal = ETHSRV_FASendRecv(ETHSRV_ETHSWTCMDID_FA_FLOW_DELETE, BCM_SWT_ID,
                                (uint8_t*)&flowOp,sizeof(ETHSRV_FAFlowOperationType),
                                ETHSRV_FA_QT_PROCESS, pHdr,&ETHSRV_QTFwdToSlaves,&ETHSRV_QTReplyLen);
    if((BCM_ERR_OK == retVal)  || (FALSE != ETHSRV_QTFwdToSlaves)){
        retVal = BCM_ERR_UNKNOWN;
        ULOG_ERR("FAIL\n");
    } else {
        retVal = BCM_ERR_OK;
        ULOG_ERR("PASS\n");
    }

    return retVal;
}

/* Verify that Deletion a non-static flow succeeds */
static int32_t ETHSRV_FAQTFlowdeletePos (const MSGQ_MsgHdrType* pHdr)
{
    int32_t retVal;
    ETHSRV_FAFlowOperationType flowOp;

    ULOG_ERR("TC10...");
    flowOp.flowID = ETHSRV_FAQTFlowsPos[0].flowID;
    retVal = ETHSRV_FASendRecv(ETHSRV_ETHSWTCMDID_FA_FLOW_DELETE, BCM_SWT_ID,
                               (uint8_t*)&flowOp,sizeof(ETHSRV_FAFlowOperationType),
                               ETHSRV_FA_QT_PROCESS, pHdr,&ETHSRV_QTFwdToSlaves,&ETHSRV_QTReplyLen);
    if((BCM_ERR_OK != retVal)
        || (((MCU_DEVICE_MASTER == ETHSRV_FAQTFlowsPos[0].flow.mstSlvDevice) && (TRUE == ETHSRV_QTFwdToSlaves))
            || ((MCU_DEVICE_SLAVE_1 == ETHSRV_FAQTFlowsPos[0].flow.mstSlvDevice) && (FALSE == ETHSRV_QTFwdToSlaves)))) {
        retVal = BCM_ERR_UNKNOWN;
        ULOG_ERR("FAIL\n");
    } else {
        ULOG_ERR("PASS\n");
    }

    return retVal;
}

/* Verify that deletion of MAC address in use */
static int32_t ETHSRV_FAQTMacdeleteNeg (const MSGQ_MsgHdrType* pHdr)
{
    int32_t retVal;
    ETHSRV_FAMacOperationType macOp;

    ULOG_ERR("TC11...");
    BCM_MemCpy(&macOp.info.mac[0UL], &ETHSRV_FAQTMacs[0UL][0UL],6UL);
    macOp.mstSlvDevice = MCU_DEVICE_MASTER;
    retVal = ETHSRV_FASendRecv(ETHSRV_ETHSWTCMDID_FA_MAC_DELETE,BCM_SWT_ID,
                                (uint8_t*)&macOp,sizeof(ETHSRV_FAMacOperationType),
                                ETHSRV_FA_QT_PROCESS, pHdr,&ETHSRV_QTFwdToSlaves,&ETHSRV_QTReplyLen);
    if((BCM_ERR_OK == retVal)  || (FALSE != ETHSRV_QTFwdToSlaves)){
        retVal = BCM_ERR_UNKNOWN;
        ULOG_ERR("FAIL\n");
    } else {
        retVal = BCM_ERR_OK;
        ULOG_ERR("PASS\n");
    }

    return retVal;
}

/* Verify that deletion of MAC address not in use */
static int32_t ETHSRV_FAQTMacdeletePos (const MSGQ_MsgHdrType* pHdr)
{
    int32_t retVal;
    ETHSRV_FAMacOperationType macOp;

    ULOG_ERR("TC12...");
    BCM_MemCpy(&macOp.info.mac[0UL], &ETHSRV_FAQTMacs[1UL][0UL],6UL);
    macOp.mstSlvDevice = MCU_DEVICE_MASTER;
    retVal = ETHSRV_FASendRecv(ETHSRV_ETHSWTCMDID_FA_MAC_DELETE,BCM_SWT_ID,
                                (uint8_t*)&macOp,sizeof(ETHSRV_FAMacOperationType),
                                 ETHSRV_FA_QT_PROCESS, pHdr,&ETHSRV_QTFwdToSlaves,&ETHSRV_QTReplyLen);
    if((BCM_ERR_OK != retVal)  || (FALSE != ETHSRV_QTFwdToSlaves)){
        retVal = BCM_ERR_UNKNOWN;
        ULOG_ERR("FAIL\n");
    } else {
        ULOG_ERR("PASS\n");
    }

    return retVal;
}

/* Retrieve global statistics */
static int32_t ETHSRV_FAQTStats (const MSGQ_MsgHdrType* pHdr)
{
    int32_t retVal;
    ETHSWT_FAStatsType faStats = {0};
#ifdef __BCM89564G__
    int32_t result;
    int32_t inResult1;
    int32_t inResult2;

    inResult1 = BCM_ERR_OK;
    inResult2 = BCM_ERR_OK;
#endif

    ULOG_ERR("TC13...");
    retVal = ETHSRV_FASendRecv(ETHSRV_ETHSWTCMDID_FA_STATS,BCM_SWT_ID,
                               (uint8_t*)&faStats,sizeof(ETHSWT_FAStatsType),
                               ETHSRV_FA_QT_PROCESS, pHdr,&ETHSRV_QTFwdToSlaves,&ETHSRV_QTReplyLen);
    if((BCM_ERR_OK != retVal) || (FALSE == ETHSRV_QTFwdToSlaves)){
        retVal = BCM_ERR_UNKNOWN;
        ULOG_ERR("FAIL\n");
        goto err_exit;
    } else {
        ULOG_ERR("PASS\n");
    }
#ifdef __BCM89564G__
    memset(&ETHSRV_FAQTOutPayLoad[0], 0, sizeof(ETHSRV_FAQTOutPayLoad));
    memset(&ETHSRV_FAQTInPayLoad2[0], 0, sizeof(ETHSRV_FAQTInPayLoad2));
    retVal = ETHSRV_FA.mergeResult(ETHSRV_ETHSWTCMDID_FA_STATS, BCM_SWT_ID,
                                     sizeof(ETHSWT_FAStatsType), &ETHSRV_FAQTOutPayLoad[0], &result,
                                     (uint8_t*)&faStats, inResult1, &ETHSRV_FAQTInPayLoad2[0], inResult2);
    if(BCM_ERR_OK != retVal) {
        ULOG_ERR("FA Stats Merge FAIL\n");
    } else {
        if(0UL == memcmp(&faStats, &ETHSRV_FAQTOutPayLoad[0],sizeof(ETHSWT_FAStatsType))) {
            ULOG_ERR(" FA Stats Merge PASS\n");

        } else {
            ULOG_ERR("FA Stats Merge FAIL\n");
            retVal = BCM_ERR_UNKNOWN;
        }
    }
#endif
err_exit:
    return retVal;
}

/* Enable interrupts */
static int32_t ETHSRV_FAQTInterruptEn (const MSGQ_MsgHdrType* pHdr)
{
    int32_t retVal;
    ETHSWT_FAIntrFlagsType faIntFlag;
#ifdef __BCM89564G__
    int32_t result;
    int32_t inResult1;
    int32_t inResult2;

    inResult1 = BCM_ERR_OK;
    inResult2 = BCM_ERR_OK;
#endif
    ULOG_ERR("TC14...");
    faIntFlag = (ETHSWT_FAINTRFLAGS_PARSE_L2
           | ETHSWT_FAINTRFLAGS_OVERFLOW_RSV | ETHSWT_FAINTRFLAGS_COR_NEXT_HOP);
    retVal = ETHSRV_FASendRecv(ETHSRV_ETHSWTCMDID_FA_INTERRUPT_ENABLE, BCM_SWT_ID,
                                (uint8_t*)&faIntFlag,sizeof(ETHSWT_FAIntrFlagsType),
                                ETHSRV_FA_QT_PROCESS, pHdr,&ETHSRV_QTFwdToSlaves,&ETHSRV_QTReplyLen);
    if((BCM_ERR_OK != retVal) || (FALSE == ETHSRV_QTFwdToSlaves)){
        retVal = BCM_ERR_UNKNOWN;
        ULOG_ERR("FAIL\n");
        goto err_exit;
    } else {
        ULOG_ERR("PASS\n");
    }
#ifdef __BCM89564G__
    memset(&ETHSRV_FAQTOutPayLoad[0], 0, sizeof(ETHSRV_FAQTOutPayLoad));
    memset(&ETHSRV_FAQTInPayLoad2[0], 0, sizeof(ETHSRV_FAQTInPayLoad2));
    retVal = ETHSRV_FA.mergeResult(ETHSRV_ETHSWTCMDID_FA_INTERRUPT_ENABLE, BCM_SWT_ID,
                                     sizeof(ETHSWT_FAIntrFlagsType), &ETHSRV_FAQTOutPayLoad[0], &result,
                                     (uint8_t*)&faIntFlag, inResult1, &ETHSRV_FAQTInPayLoad2[0], inResult2);
    if(BCM_ERR_OK != retVal) {
        ULOG_ERR("Interrupt Merge FAIL\n");
    } else {
        if(0UL == memcmp(&faIntFlag,&ETHSRV_FAQTOutPayLoad[0],sizeof(ETHSWT_FAIntrFlagsType))){
            ULOG_ERR(" Interrupt Merge PASS\n");

        } else {
            retVal = BCM_ERR_UNKNOWN;
            ULOG_ERR("Interrupt Merge FAIL\n");
        }
    }
#endif
err_exit:
    return retVal;
}

/* Reset FA into BYPASS mode */
static int32_t ETHSRV_FAQTResetBypass (const MSGQ_MsgHdrType* pHdr)
{
    int32_t retVal;
#ifdef __BCM89564G__
    int32_t result;
    int32_t inResult1;
    int32_t inResult2;

    inResult1 = BCM_ERR_OK;
    inResult2 = BCM_ERR_OK;
#endif

    ULOG_ERR("TC15...");
    retVal = ETHSRV_FASendRecv(ETHSRV_ETHSWTCMDID_FA_RESET,BCM_SWT_ID,
                                (uint8_t*)&ETHSRV_FAQTCtfCfgBypass,sizeof(ETHSWT_FACtfCfgType),
                                ETHSRV_FA_QT_PROCESS, pHdr,&ETHSRV_QTFwdToSlaves,&ETHSRV_QTReplyLen);
    if((BCM_ERR_OK != retVal)  || (FALSE == ETHSRV_QTFwdToSlaves)) {
        retVal = BCM_ERR_UNKNOWN;
        ULOG_ERR("FAIL\n");
        goto err_exit;
    } else {
        ULOG_ERR("PASS\n");
    }

#ifdef __BCM89564G__
    memset(&ETHSRV_FAQTOutPayLoad[0], 0, sizeof(ETHSRV_FAQTOutPayLoad));
    memset(&ETHSRV_FAQTInPayLoad2[0], 0, sizeof(ETHSRV_FAQTInPayLoad2));
    retVal = ETHSRV_FA.mergeResult(ETHSRV_ETHSWTCMDID_FA_RESET, BCM_SWT_ID,
                                     sizeof(ETHSWT_FACtfCfgType), &ETHSRV_FAQTOutPayLoad[0], &result,
                                     (uint8_t*)&ETHSRV_FAQTCtfCfgBypass, inResult1, &ETHSRV_FAQTInPayLoad2[0], inResult2);
    if(BCM_ERR_OK != retVal) {
        ULOG_ERR("Reset Merge FAIL\n");
    } else {
        if(0UL == memcmp(&ETHSRV_FAQTCtfCfgBypass,&ETHSRV_FAQTOutPayLoad[0],sizeof(ETHSWT_FACtfCfgType))){
            ULOG_ERR(" Reset Merge PASS\n");

        } else {
            retVal = BCM_ERR_UNKNOWN;
            ULOG_ERR("Reset Merge FAIL\n");
        }
    }
#endif
err_exit:
    return retVal;
}

/* Add flows with non-configured MAC */
static int32_t ETHSRV_FAQTFlowaddBypassNeg (const MSGQ_MsgHdrType* pHdr)
{
    int32_t retVal;

    ULOG_ERR("TC16...");
    retVal = ETHSRV_FASendRecv(ETHSRV_ETHSWTCMDID_FA_FLOW_ADD, BCM_SWT_ID,
                                (uint8_t*)&ETHSRV_FAQTFlowsNeg[0],sizeof(ETHSRV_FAFlowOperationType),
                                 ETHSRV_FA_QT_PROCESS, pHdr,&ETHSRV_QTFwdToSlaves,&ETHSRV_QTReplyLen);
    if((BCM_ERR_OK == retVal)
        || (((MCU_DEVICE_MASTER == ETHSRV_FAQTFlowsNeg[0].flow.mstSlvDevice) && (TRUE == ETHSRV_QTFwdToSlaves))
            || ((MCU_DEVICE_SLAVE_1 == ETHSRV_FAQTFlowsNeg[0].flow.mstSlvDevice) && (FALSE == ETHSRV_QTFwdToSlaves)))) {
        retVal = BCM_ERR_UNKNOWN;
        ULOG_ERR("FAIL\n");
    } else {
        retVal = BCM_ERR_OK;
        ULOG_ERR("PASS\n");
    }

    return retVal;
}

/* Reset FA into NORMAL mode */
static int32_t ETHSRV_FAQTResetNormal (const MSGQ_MsgHdrType* pHdr)
{
    int32_t retVal;
#ifdef __BCM89564G__
    int32_t result;
    int32_t inResult1;
    int32_t inResult2;

    inResult1 = BCM_ERR_OK;
    inResult2 = BCM_ERR_OK;
#endif

    ULOG_ERR("TC17...");
    retVal = ETHSRV_FASendRecv(ETHSRV_ETHSWTCMDID_FA_RESET,BCM_SWT_ID,
                               (uint8_t*)&ETHSRV_FAQTCtfCfgNormal,sizeof(ETHSWT_FACtfCfgType),
                               ETHSRV_FA_QT_PROCESS, pHdr,&ETHSRV_QTFwdToSlaves,&ETHSRV_QTReplyLen);
    if((BCM_ERR_OK != retVal)  || (FALSE == ETHSRV_QTFwdToSlaves)) {
        retVal = BCM_ERR_UNKNOWN;
        ULOG_ERR("FAIL \n");
        goto err_exit;
    } else {
        ULOG_ERR("PASS\n");
    }

#ifdef __BCM89564G__
    memset(&ETHSRV_FAQTOutPayLoad[0], 0, sizeof(ETHSRV_FAQTOutPayLoad));
    memset(&ETHSRV_FAQTInPayLoad2[0], 0, sizeof(ETHSRV_FAQTInPayLoad2));
    retVal = ETHSRV_FA.mergeResult(ETHSRV_ETHSWTCMDID_FA_RESET, BCM_SWT_ID,
                                     sizeof(ETHSWT_FACtfCfgType), &ETHSRV_FAQTOutPayLoad[0], &result,
                                     (uint8_t*)&ETHSRV_FAQTCtfCfgNormal, inResult1,
                                     &ETHSRV_FAQTInPayLoad2[0], inResult2);
    if(BCM_ERR_OK != retVal) {
        ULOG_ERR("Reset Merge FAIL\n");
    } else {
        if(0UL == memcmp(&ETHSRV_FAQTCtfCfgNormal,&ETHSRV_FAQTOutPayLoad[0],sizeof(ETHSWT_FACtfCfgType))){
            ULOG_ERR(" Reset Merge PASS\n");

        } else {
            retVal = BCM_ERR_UNKNOWN;
            ULOG_ERR("Reset Merge FAIL\n");
        }
    }
#endif
err_exit:
    return retVal;
}

/* Get the configured flowstatus static flow masks */
static int32_t ETHSRV_FAQTGetFlowstatusGetStaticRst (const MSGQ_MsgHdrType* pHdr)
{
    int32_t retVal;
    int32_t flowCount;
    ETHSRV_FAFlowStatusType flowStatus;

    ULOG_ERR("TC18...");
    flowStatus.attribute = ETHSRV_FAATTRIBUTE_STATIC;
    flowStatus.mstSlvDevice = MCU_DEVICE_MASTER;
    retVal = ETHSRV_FASendRecv(ETHSRV_ETHSWTCMDID_FA_FLOW_STATUS, BCM_SWT_ID,
                               (uint8_t*)&flowStatus,sizeof(ETHSRV_FAFlowStatusType),
                               ETHSRV_FA_QT_PROCESS, pHdr,&ETHSRV_QTFwdToSlaves,&ETHSRV_QTReplyLen);
    if((BCM_ERR_OK != retVal)  || (FALSE != ETHSRV_QTFwdToSlaves)) {
        ULOG_ERR("FAIL\n");
    } else {
        flowCount =0;
        flowCount = ETHSRV_FAQTGetFAFlowCount(&flowStatus,&ETHSRV_QTstaticFlowID[0]);
        if (0UL== flowCount) {
            ULOG_ERR("PASS\n");
        } else {
            retVal = BCM_ERR_UNKNOWN;
            ULOG_ERR("FAIL\n");
        }
    }

    return retVal;

}

/* Get the configured flowstatus active flow masks */
static int32_t ETHSRV_FAQTGetFlowstatusGetActiveRst (const MSGQ_MsgHdrType* pHdr)
{
    int32_t retVal;
    int32_t flowCount;
    ETHSRV_FAFlowStatusType flowStatus;

    ULOG_ERR("TC19...");
    flowStatus.attribute = ETHSRV_FAATTRIBUTE_ACTIVE;
    flowStatus.mstSlvDevice = MCU_DEVICE_MASTER;
    retVal = ETHSRV_FASendRecv(ETHSRV_ETHSWTCMDID_FA_FLOW_STATUS, BCM_SWT_ID,
                               (uint8_t*)&flowStatus,sizeof(ETHSRV_FAFlowStatusType),
                                ETHSRV_FA_QT_PROCESS, pHdr,&ETHSRV_QTFwdToSlaves,&ETHSRV_QTReplyLen);
    if((BCM_ERR_OK != retVal)  || (FALSE != ETHSRV_QTFwdToSlaves)) {
        ULOG_ERR("FAIL");
    } else {
        flowCount =0;
        flowCount = ETHSRV_FAQTGetFAFlowCount(&flowStatus,&ETHSRV_QTactiveFlowID[0]);
        if (0UL == flowCount) {
            ULOG_ERR("PASS\n");
        } else {
            retVal = BCM_ERR_UNKNOWN;
            ULOG_ERR("FAIL\n");
        }
    }

    return retVal;
}

TASK(ETHSRV_FAQTTask)
{

    int32_t retVal;

    const MSGQ_MsgHdrType  *hdr;
    MSGQ_MsgHdrType lHdr;
    hdr = &lHdr;

    /* Get the configured MAC addresses */
    retVal = ETHSRV_FAQTMacpoolGet(hdr);
    if(BCM_ERR_OK != retVal) {
        goto err_exit;
    }

    /* Add an existing MAC address */
    retVal = ETHSRV_FAQTMacAddExisting(hdr);
        if(BCM_ERR_OK != retVal) {
        goto err_exit;
    }
    /* Add a new MAC address */
    retVal = ETHSRV_FAQTMacAddNew(hdr);
        if(BCM_ERR_OK != retVal) {
        goto err_exit;
    }
    /* Add flows one of the configured MACs */
    retVal = ETHSRV_FAQTFlowaddPos(hdr);
        if(BCM_ERR_OK != retVal) {
        goto err_exit;
    }

    /* Add flows with non-configured MAC */
    retVal = ETHSRV_FAQTFlowaddNeg(hdr);
        if(BCM_ERR_OK != retVal) {
        goto err_exit;
    }

    /* Get the configured flowstatus static flow masks */
    retVal = ETHSRV_FAQTGetFlowstatusGetStatic(hdr);
        if(BCM_ERR_OK != retVal) {
        goto err_exit;
    }

    /* Get the configured flowstatus active flow masks */
    retVal = ETHSRV_FAQTGetFlowstatusGetActive(hdr);
        if(BCM_ERR_OK != retVal) {
        goto err_exit;
    }

    /* Retrieve flow paramters and compare them with configured values */
    retVal = ETHSRV_FAQTFlowget(hdr);
        if(BCM_ERR_OK != retVal) {
        goto err_exit;
    }

    /* Verify that Deletion a static flow fails */
    retVal = ETHSRV_FAQTFlowdeleteNeg(hdr);
        if(BCM_ERR_OK != retVal) {
        goto err_exit;
    }

    /* Verify that Deletion a non-static flow succeeds */
    retVal = ETHSRV_FAQTFlowdeletePos(hdr);
        if(BCM_ERR_OK != retVal) {
        goto err_exit;
    }
    /* Verify that deletion of MAC address in use */
    retVal = ETHSRV_FAQTMacdeleteNeg(hdr);
        if(BCM_ERR_OK != retVal) {
        goto err_exit;
    }

    /* Verify that deletion of MAC address not in use */
    retVal = ETHSRV_FAQTMacdeletePos(hdr);
        if(BCM_ERR_OK != retVal) {
        goto err_exit;
    }

    /* Retrieve global statistics */
    retVal = ETHSRV_FAQTStats(hdr);
        if(BCM_ERR_OK != retVal) {
        goto err_exit;
    }

    /* Enable interrupts */
    retVal = ETHSRV_FAQTInterruptEn(hdr);
        if(BCM_ERR_OK != retVal) {
        goto err_exit;
    }

    /* Reset FA into BYPASS mode */
    retVal = ETHSRV_FAQTResetBypass(hdr);
        if(BCM_ERR_OK != retVal) {
        goto err_exit;
    }

    /* Add flows with non-configured MAC */
    retVal = ETHSRV_FAQTFlowaddBypassNeg(hdr);
        if(BCM_ERR_OK != retVal) {
        goto err_exit;
    }

    /* Reset FA into NORMAL mode */
    retVal = ETHSRV_FAQTResetNormal(hdr);
        if(BCM_ERR_OK != retVal) {
        goto err_exit;
    }

    /* Get the configured flowstatus static flow masks */
    retVal = ETHSRV_FAQTGetFlowstatusGetStaticRst(hdr);
        if(BCM_ERR_OK != retVal) {
        goto err_exit;
    }

    /* Get the configured flowstatus active flow masks */
    retVal = ETHSRV_FAQTGetFlowstatusGetActiveRst(hdr);
        if(BCM_ERR_OK != retVal) {
        goto err_exit;
    }
err_exit:
    ETHSRV_FAQTResult = retVal;
    BCM_TerminateTask();
}

int32_t BCM_ExecuteAT(uint32_t aIndex)
{
    int32_t retVal;

    if (1UL == aIndex) {
        if (BCM_AT_EXECUTING != ETHSRV_FAQTResult) {
            retVal = BCM_ActivateTask(ETHSRV_FAQTTask);
            if (BCM_ERR_OK == retVal) {
                ETHSRV_FAQTResult = BCM_AT_EXECUTING;
            } else {
                ETHSRV_FAQTResult = BCM_AT_NOT_STARTED;
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
        ret = ETHSRV_FAQTResult;
    }
    return ret;
}

void APP_Init()
{
}

