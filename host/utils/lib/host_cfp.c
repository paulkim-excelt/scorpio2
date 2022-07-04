/*****************************************************************************
 Copyright 2018 Broadcom Limited.  All rights reserved.

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

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <sys/time.h>
#include "hipc.h"
#include <bcm_err.h>
#include <rpc_cmds.h>
#include <host_cfp.h>
#include <hlog.h>
#include <ethernet_swt_cfp.h>

int32_t HOST_CFPGetStats(MgmtInfoType *info,
                       uint32_t row,
                       ETHSWT_CFPStatsType *stats)
{
    int32_t                retVal = BCM_ERR_OK;
    ETHSWT_CFPMsgUnionType msg;
    RPC_ResponseType     resp;
    uint32_t             replyLen;
    uint32_t             cmdId;

    HOST_Log("CFPGetStats invoked for %u\n", row);

    if ((info == NULL) || (stats == NULL) || (row >= ETHSWT_CFP_MAX_RULES)) {
        retVal = BCM_ERR_INVAL_PARAMS;
        goto done;
    }

    cmdId = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_CFP_ID, ETHSWT_CFPCMDID_GETSTATS);

    msg.cfpStats.row = uswap32(row);

    retVal = HIPC_SendRecv(cmdId, (uint8_t *)&msg,
             sizeof(ETHSWT_CFPRowStatsType), (uint8_t *)&resp, sizeof(resp), &replyLen);

    if (retVal != BCM_ERR_OK) {
        goto done;
    } else if (uswap32(resp.status) != BCM_ERR_OK) {
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status));
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    } else if (replyLen != (MGMT_STATUS_LEN + sizeof(ETHSWT_CFPRowStatsType))) {
        HOST_Log("%s len:0x%x\n", __func__, replyLen);
        retVal = BCM_ERR_DATA_INTEG;
        goto done;
    } else {
        memcpy((uint8_t *)&msg, &resp.payload[0], sizeof(ETHSWT_CFPRowStatsType));
        stats->green  = uswap32(msg.cfpStats.stats.green);
        stats->yellow = uswap32(msg.cfpStats.stats.yellow);
        stats->red    = uswap32(msg.cfpStats.stats.red);
    }
done:
    return retVal;
}

int32_t HOST_CFPGetRowConfig(MgmtInfoType *info, uint32_t row, ETHSWT_CFPRuleType* config)
{
    int32_t                retVal = BCM_ERR_OK;
    ETHSWT_CFPMsgUnionType msg;
    RPC_ResponseType     resp;
    uint32_t             replyLen;
    uint32_t             cmdId;
    uint32_t             i;

    if ((info == NULL) || (config == NULL) || (row >= ETHSWT_CFP_MAX_RULES)) {
        retVal = BCM_ERR_INVAL_PARAMS;
        goto done;
    }

    cmdId = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_CFP_ID, ETHSWT_CFPCMDID_GETROWCONFIG);

    msg.cfpRule.rowAndSlice = uswap16((row << ETHSWT_CFP_ROWANDSLICE_ROW_SHIFT) & ETHSWT_CFP_ROWANDSLICE_ROW_MASK);
    retVal = HIPC_SendRecv(cmdId, (uint8_t *)&msg,
             sizeof(ETHSWT_CFPRuleType), (uint8_t *)&resp, sizeof(resp), &replyLen);

    if (retVal != BCM_ERR_OK) {
        goto done;
    } else if (uswap32(resp.status) != BCM_ERR_OK) {
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status));
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    } else if (replyLen != (MGMT_STATUS_LEN + sizeof(ETHSWT_CFPRuleType))) {
        HOST_Log("%s len:0x%x\n", __func__, replyLen);
        retVal = BCM_ERR_DATA_INTEG;
        goto done;
    } else {
        memcpy((uint8_t *)&msg, &resp.payload[0], sizeof(ETHSWT_CFPRuleType));
        config->rowAndSlice           = uswap16(msg.cfpRule.rowAndSlice);
        config->key.flags             = uswap32(msg.cfpRule.key.flags);
        config->key.flagsMask         = uswap32(msg.cfpRule.key.flagsMask);
        config->key.ingressPortBitmap = uswap16(msg.cfpRule.key.ingressPortBitmap);
        config->key.cTagFlags         = uswap32(msg.cfpRule.key.cTagFlags);
        config->key.sTagFlags         = uswap32(msg.cfpRule.key.sTagFlags);
        config->key.cTagMask          = uswap16(msg.cfpRule.key.cTagMask);
        config->key.sTagMask          = uswap16(msg.cfpRule.key.sTagMask);
        config->key.l2Framing         = msg.cfpRule.key.l2Framing;
        config->key.l3Framing         = msg.cfpRule.key.l3Framing;
        config->key.numEnabledUDFs    = msg.cfpRule.key.numEnabledUDFs;
        for (i = 0UL; i < msg.cfpRule.key.numEnabledUDFs; ++i) {
            config->key.udfList[i].value         = uswap16(msg.cfpRule.key.udfList[i].value);
            config->key.udfList[i].mask          = uswap16(msg.cfpRule.key.udfList[i].mask);
            config->key.udfList[i].baseAndOffset = msg.cfpRule.key.udfList[i].baseAndOffset;
        }

        config->action.dstMapIBFlags      = uswap32(msg.cfpRule.action.dstMapIBFlags);
        config->action.dstMapOBFlags      = uswap32(msg.cfpRule.action.dstMapOBFlags);
        config->action.tosIBFlags         = msg.cfpRule.action.tosIBFlags;
        config->action.tosOBFlags         = msg.cfpRule.action.tosOBFlags;
        config->action.tcFlags            = msg.cfpRule.action.tcFlags;
        config->action.reasonCode         = msg.cfpRule.action.reasonCode;
        config->action.otherFlags         = msg.cfpRule.action.otherFlags;
        config->action.colorFlags         = msg.cfpRule.action.colorFlags;
        config->action.chainID            = msg.cfpRule.action.chainID;
        config->action.meter.policerFlags = msg.cfpRule.action.meter.policerFlags;
        config->action.meter.cirTkBkt     = uswap32(msg.cfpRule.action.meter.cirTkBkt);
        config->action.meter.cirRefCnt    = uswap32(msg.cfpRule.action.meter.cirRefCnt);
        config->action.meter.cirBktSize   = uswap32(msg.cfpRule.action.meter.cirBktSize);
        config->action.meter.eirTkBkt     = uswap32(msg.cfpRule.action.meter.eirTkBkt);
        config->action.meter.eirRefCnt    = uswap32(msg.cfpRule.action.meter.eirRefCnt);
        config->action.meter.eirBktSize   = uswap32(msg.cfpRule.action.meter.eirBktSize);
    }
done:
    return retVal;
}

int32_t HOST_CFPGetSnapshotInt(MgmtInfoType *info, ETHSWT_CFPEntrySnapshotType *rules,
                               uint32_t index, uint32_t *count)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;
    ETHSWT_CFPMsgUnionType msg;
    RPC_ResponseType resp;
    uint32_t replyLen;
    uint32_t cmdId;
    uint32_t idx;

    if ((info == NULL) || (rules == NULL) || (NULL == count) || (0UL == *count) || (*count > ETHSWT_CFPRULELIST_MAX_RULES)) {
        HOST_Log("%s :: Invalid parameters info:%p entry:%p count:%u\n", __FUNCTION__, info, rules, *count);
        goto done;
    }

    cmdId = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_CFP_ID, ETHSWT_CFPCMDID_GETRULELIST);
    msg.cfpRuleList.num = uswap32(index);

    retVal = HIPC_SendRecv(cmdId, (uint8_t *)&msg,
             sizeof(ETHSWT_CFPRuleListType),
             (uint8_t *)&resp, sizeof(resp), &replyLen);

    if (retVal != BCM_ERR_OK) {
        goto done;
    } else if (uswap32(resp.status) != BCM_ERR_OK) {
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status));
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    } else if (replyLen != (MGMT_STATUS_LEN + sizeof(ETHSWT_CFPRuleListType))) {
        HOST_Log("%s len:0x%x\n", __func__, replyLen);
        retVal = BCM_ERR_DATA_INTEG;
        goto done;
    } else {
        memcpy((uint8_t *)&msg, &resp.payload[0], sizeof(ETHSWT_CFPRuleListType));
        *count = uswap32(msg.cfpRuleList.num);
        for (idx = 0; idx < *count; idx++) {
            rules[idx] = msg.cfpRuleList.entry[idx];
        }
    }

done:
    return retVal;
}

int32_t HOST_CFPGetSnapshot(MgmtInfoType *info,
                            ETHSWT_CFPTableSnapshotType* snapShot,
                            ETHSWT_CFPEntrySnapshotType *rules)
{
    int32_t              retVal = BCM_ERR_OK;

    ETHSWT_CFPMsgUnionType   msg;
    RPC_ResponseType     resp;
    uint32_t             replyLen;
    uint32_t             cmdId;
    uint32_t             idx = 0UL;
    uint32_t             thisCount;
    uint32_t             available = ETHSWT_CFP_MAX_RULES;

    if ((info == NULL) || (snapShot == NULL)) {
        retVal = BCM_ERR_INVAL_PARAMS;
        goto done;
    }

    cmdId = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_CFP_ID, ETHSWT_CFPCMDID_GETSNAPSHOT);

    retVal = HIPC_SendRecv(cmdId, (uint8_t *)&msg,
             sizeof(ETHSWT_CFPTableSnapshotType), (uint8_t *)&resp, sizeof(resp), &replyLen);

    if (retVal != BCM_ERR_OK) {
        goto done;
    } else if (uswap32(resp.status) != BCM_ERR_OK) {
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status));
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    } else if (replyLen != (MGMT_STATUS_LEN + sizeof(ETHSWT_CFPTableSnapshotType))) {
        HOST_Log("%s len:0x%x\n", __func__, replyLen);
        retVal = BCM_ERR_DATA_INTEG;
        goto done;
    } else {
        memcpy((uint8_t *)&msg, &resp.payload[0], sizeof(ETHSWT_CFPTableSnapshotType));
        snapShot->numValidEntries     = uswap32(msg.cfpSnapshot.numValidEntries);
        memcpy(&snapShot->udfList, &msg.cfpSnapshot.udfList, sizeof(snapShot->udfList));
        snapShot->portEnableMask      = uswap16(msg.cfpSnapshot.portEnableMask);
    }

    memset((uint8_t *)rules, 0UL, sizeof(ETHSWT_CFPEntrySnapshotType) * (ETHSWT_CFP_MAX_RULES));

    while (idx < available) {
        if ((available - idx) >= ETHSWT_CFPRULELIST_MAX_RULES) {
            thisCount = ETHSWT_CFPRULELIST_MAX_RULES;
        } else {
            thisCount = available - idx;
        }

        retVal = HOST_CFPGetSnapshotInt(info, &rules[idx], idx, &thisCount);
        if (BCM_ERR_OK != retVal) {
            break;
        }
        idx += thisCount;
    }

done:
    return retVal;
}
int32_t HOST_CFPAddRule(MgmtInfoType *info, ETHSWT_CFPRuleType *config)
{
    int32_t              retVal = BCM_ERR_OK;

    ETHSWT_CFPMsgUnionType msg;

    RPC_ResponseType     resp;
    uint32_t             replyLen;
    uint32_t             cmdId;
    uint32_t             i;
    uint16_t             row;
    uint16_t             slice;

    if ((info == NULL) || (config == NULL)) {
        retVal = BCM_ERR_INVAL_PARAMS;
        goto done;
    }

    /* Perform basic validation */
    row   = (config->rowAndSlice & ETHSWT_CFP_ROWANDSLICE_ROW_MASK) >> ETHSWT_CFP_ROWANDSLICE_ROW_SHIFT;
    slice = (config->rowAndSlice & ETHSWT_CFP_ROWANDSLICE_SLICE_MASK) >> ETHSWT_CFP_ROWANDSLICE_SLICE_SHIFT;
    if ((row >= ETHSWT_CFP_MAX_RULES) || (slice >= ETHSWT_CFP_MAX_SLICES)) {
        HOST_Log("CFP row number: [0,%lu] slice number: [0, %lu]\n", ETHSWT_CFP_MAX_RULES-1UL, ETHSWT_CFP_MAX_SLICES-1UL);
        retVal = BCM_ERR_INVAL_PARAMS;
        goto done;
    }

    cmdId = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_CFP_ID, ETHSWT_CFPCMDID_ADDRULE);

    msg.cfpRule.rowAndSlice            = uswap16(config->rowAndSlice);
    msg.cfpRule.key.flags              = uswap32(config->key.flags);
    msg.cfpRule.key.flagsMask          = uswap32(config->key.flagsMask);
    msg.cfpRule.key.ingressPortBitmap  = uswap16(config->key.ingressPortBitmap);
    msg.cfpRule.key.cTagFlags          = uswap32(config->key.cTagFlags);
    msg.cfpRule.key.sTagFlags          = uswap32(config->key.sTagFlags);
    msg.cfpRule.key.cTagMask           = uswap16(config->key.cTagMask);
    msg.cfpRule.key.sTagMask           = uswap16(config->key.sTagMask);
    msg.cfpRule.key.l2Framing          = config->key.l2Framing;
    msg.cfpRule.key.l3Framing          = config->key.l3Framing;
    msg.cfpRule.key.numEnabledUDFs     = config->key.numEnabledUDFs;
    for (i = 0UL; i < msg.cfpRule.key.numEnabledUDFs; ++i) {
        msg.cfpRule.key.udfList[i].value         = uswap16(config->key.udfList[i].value);
        msg.cfpRule.key.udfList[i].mask          = uswap16(config->key.udfList[i].mask);
        msg.cfpRule.key.udfList[i].baseAndOffset = config->key.udfList[i].baseAndOffset;
    }

    msg.cfpRule.action.dstMapIBFlags      = uswap32(config->action.dstMapIBFlags);
    msg.cfpRule.action.dstMapOBFlags      = uswap32(config->action.dstMapOBFlags);
    msg.cfpRule.action.tosIBFlags         = config->action.tosIBFlags;
    msg.cfpRule.action.tosOBFlags         = config->action.tosOBFlags;
    msg.cfpRule.action.tcFlags            = config->action.tcFlags;
    msg.cfpRule.action.reasonCode         = config->action.reasonCode;
    msg.cfpRule.action.otherFlags         = config->action.otherFlags;
    msg.cfpRule.action.colorFlags         = config->action.colorFlags;
    msg.cfpRule.action.chainID            = config->action.chainID;
    msg.cfpRule.action.meter.policerFlags = config->action.meter.policerFlags;
    msg.cfpRule.action.meter.cirTkBkt     = uswap32(config->action.meter.cirTkBkt);
    msg.cfpRule.action.meter.cirRefCnt    = uswap32(config->action.meter.cirRefCnt);
    msg.cfpRule.action.meter.cirBktSize   = uswap32(config->action.meter.cirBktSize);
    msg.cfpRule.action.meter.eirTkBkt     = uswap32(config->action.meter.eirTkBkt);
    msg.cfpRule.action.meter.eirRefCnt    = uswap32(config->action.meter.eirRefCnt);
    msg.cfpRule.action.meter.eirBktSize   = uswap32(config->action.meter.eirBktSize);

    retVal = HIPC_SendRecv(cmdId, (uint8_t *)&msg,
             sizeof(ETHSWT_CFPRuleType), (uint8_t *)&resp, sizeof(resp), &replyLen);

    if (retVal != BCM_ERR_OK) {
        goto done;
    } else if (uswap32(resp.status) != BCM_ERR_OK) {
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status));
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    } else if (replyLen != (MGMT_STATUS_LEN + sizeof(ETHSWT_CFPRuleType))) {
        HOST_Log("%s len:0x%x\n", __func__, replyLen);
        retVal = BCM_ERR_DATA_INTEG;
        goto done;
    }
done:
    return retVal;
}

int32_t HOST_CFPDeleteRule(MgmtInfoType *info, uint32_t row)
{
    int32_t                retVal = BCM_ERR_OK;

    ETHSWT_CFPMsgUnionType msg;

    RPC_ResponseType     resp;
    uint32_t             replyLen;
    uint32_t             cmdId;

    if ((info == NULL) || (row >= ETHSWT_CFP_MAX_RULES)) {
        retVal = BCM_ERR_INVAL_PARAMS;
        goto done;
    }

    cmdId = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_CFP_ID, ETHSWT_CFPCMDID_REMOVERULE);

    msg.cfpRule.rowAndSlice = uswap16((row << ETHSWT_CFP_ROWANDSLICE_ROW_SHIFT) & ETHSWT_CFP_ROWANDSLICE_ROW_MASK);

    retVal = HIPC_SendRecv(cmdId, (uint8_t *)&msg,
             sizeof(ETHSWT_CFPRuleType), (uint8_t *)&resp, sizeof(resp), &replyLen);

    if (retVal != BCM_ERR_OK) {
        goto done;
    } else if (uswap32(resp.status) != BCM_ERR_OK) {
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status));
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    } else if (replyLen != (MGMT_STATUS_LEN + sizeof(ETHSWT_CFPRuleType))) {
        HOST_Log("%s len:0x%x\n", __func__, replyLen);
        retVal = BCM_ERR_DATA_INTEG;
        goto done;
    }
done:
    return retVal;
}

int32_t HOST_CFPUpdateRule(MgmtInfoType *info, uint32_t row, ETHSWT_CFPActionType *action)
{
    int32_t                retVal = BCM_ERR_OK;

    ETHSWT_CFPMsgUnionType msg;

    RPC_ResponseType     resp;
    uint32_t             replyLen;
    uint32_t             cmdId;

    if ((info == NULL) || (action == NULL) || (row >= ETHSWT_CFP_MAX_RULES)) {
        retVal = BCM_ERR_INVAL_PARAMS;
        goto done;
    }

    cmdId = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_CFP_ID, ETHSWT_CFPCMDID_UPDATERULE);

    msg.cfpRule.rowAndSlice               = uswap16((row << ETHSWT_CFP_ROWANDSLICE_ROW_SHIFT) & ETHSWT_CFP_ROWANDSLICE_ROW_MASK);
    msg.cfpRule.action.dstMapIBFlags      = uswap32(action->dstMapIBFlags);
    msg.cfpRule.action.dstMapOBFlags      = uswap32(action->dstMapOBFlags);
    msg.cfpRule.action.tosIBFlags         = action->tosIBFlags;
    msg.cfpRule.action.tosOBFlags         = action->tosOBFlags;
    msg.cfpRule.action.tcFlags            = action->tcFlags;
    msg.cfpRule.action.reasonCode         = action->reasonCode;
    msg.cfpRule.action.otherFlags         = action->otherFlags;
    msg.cfpRule.action.colorFlags         = action->colorFlags;
    msg.cfpRule.action.chainID            = action->chainID;
    msg.cfpRule.action.meter.policerFlags = action->meter.policerFlags;
    msg.cfpRule.action.meter.cirTkBkt     = uswap32(action->meter.cirTkBkt);
    msg.cfpRule.action.meter.cirRefCnt    = uswap32(action->meter.cirRefCnt);
    msg.cfpRule.action.meter.cirBktSize   = uswap32(action->meter.cirBktSize);
    msg.cfpRule.action.meter.eirTkBkt     = uswap32(action->meter.eirTkBkt);
    msg.cfpRule.action.meter.eirRefCnt    = uswap32(action->meter.eirRefCnt);
    msg.cfpRule.action.meter.eirBktSize   = uswap32(action->meter.eirBktSize);

    retVal = HIPC_SendRecv(cmdId, (uint8_t *)&msg,
             sizeof(ETHSWT_CFPRuleType), (uint8_t *)&resp, sizeof(resp), &replyLen);

    if (retVal != BCM_ERR_OK) {
        goto done;
    } else if (uswap32(resp.status) != BCM_ERR_OK) {
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status));
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    } else if (replyLen != (MGMT_STATUS_LEN + sizeof(ETHSWT_CFPRuleType))) {
        HOST_Log("%s len:0x%x\n", __func__, replyLen);
        retVal = BCM_ERR_DATA_INTEG;
        goto done;
    }
done:
    return retVal;
}

int32_t HOST_CFPSetPortMode(MgmtInfoType *info, uint32_t port, uint32_t enable)
{
    int32_t                retVal = BCM_ERR_OK;

    ETHSWT_CFPMsgUnionType msg;

    RPC_ResponseType     resp;
    uint32_t             replyLen;
    uint32_t             cmdId;

    /*FIXME: Validate port */
    if ((info == NULL) || ((enable != 0UL) && (enable != 1UL))){
        retVal = BCM_ERR_INVAL_PARAMS;
        goto done;
    }

    cmdId = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_CFP_ID, ETHSWT_CFPCMDID_SETPORTMODE);

    msg.cfpPortMode.port = uswap32(port);
    msg.cfpPortMode.mode = uswap32(enable);

    retVal = HIPC_SendRecv(cmdId, (uint8_t *)&msg,
             sizeof(ETHSWT_CFPPortModeType), (uint8_t *)&resp, sizeof(resp), &replyLen);

    if (retVal != BCM_ERR_OK) {
        goto done;
    } else if (uswap32(resp.status) != BCM_ERR_OK) {
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status));
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    } else if (replyLen != (MGMT_STATUS_LEN + sizeof(ETHSWT_CFPPortModeType))) {
        HOST_Log("%s len:0x%x\n", __func__, replyLen);
        retVal = BCM_ERR_DATA_INTEG;
        goto done;
    }
done:
    return retVal;
}

int32_t HOST_CFPNotificationHandler(uint32_t currentSlave,
            uint8_t notificationId, uint8_t *msg, uint32_t size)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    return retVal;
}

int32_t HOST_CFPStreamPolicerAdd(MgmtInfoType *info, uint8_t *mac_addr, uint16_t vlan,
                                 uint32_t rate, uint32_t burst, uint32_t srcMask,
                                 uint32_t threshold, uint32_t interval, uint32_t report,
                                 uint32_t block, uint32_t *const streamIdx)
{
    int32_t              retVal = BCM_ERR_INVAL_PARAMS;

    ETHSWT_CFPMsgUnionType msg;
    RPC_ResponseType     resp;

    uint32_t             replyLen;
    uint32_t             cmdId;

    if (info == NULL) {
        HOST_Log("%s :: MgmtInfoType pointer is NULL\n", __FUNCTION__);
        goto done;
    }

    cmdId = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_CFP_ID, ETHSWT_CFPCMDID_STREAMPOLICER_ADD);
    msg.streamPolicerEntry.vlanID    = uswap16(vlan);
    memcpy(&msg.streamPolicerEntry.macAddr[0], mac_addr, 6UL);
    msg.streamPolicerEntry.policerParams.portMask           = uswap32(srcMask);
    msg.streamPolicerEntry.policerParams.rate               = uswap32(rate);
    msg.streamPolicerEntry.policerParams.burstSize          = uswap32(burst);
    msg.streamPolicerEntry.policerParams.dropThreshold      = uswap32(threshold);
    msg.streamPolicerEntry.policerParams.monitoringInterval = uswap32(interval);
    msg.streamPolicerEntry.policerParams.action             = (block & ETHSWT_CFPSTREAMPOLICERACTION_BLOCK_MASK) |
                                                                  ((report << ETHSWT_CFPSTREAMPOLICERACTION_REPORT_SHIFT) &
                                                                  ETHSWT_CFPSTREAMPOLICERACTION_REPORT_MASK);

    retVal = HIPC_SendRecv(cmdId, (uint8_t *)&msg,
             sizeof(ETHSWT_CFPStreamType),
             (uint8_t *)&resp, sizeof(resp), &replyLen);

    if (retVal != BCM_ERR_OK) {
        goto done;
    } else if (uswap32(resp.status) != BCM_ERR_OK) {
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status));
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    } else if (replyLen != (MGMT_STATUS_LEN + sizeof(ETHSWT_CFPStreamType))) {
        HOST_Log("%s len:0x%x\n", __func__, replyLen);
        retVal = BCM_ERR_DATA_INTEG;
        goto done;
    }

    memcpy((uint8_t *)&msg, &resp.payload[0], sizeof(ETHSWT_CFPStreamType));
    *streamIdx = uswap32(msg.streamPolicerEntry.streamIdx);
done:
    return retVal;
}

int32_t HOST_CFPStreamPolicerDel(MgmtInfoType *info, uint32_t streamIdx)
{
    int32_t              retVal = BCM_ERR_INVAL_PARAMS;

    ETHSWT_CFPMsgUnionType msg;
    RPC_ResponseType     resp;

    uint32_t             replyLen;
    uint32_t             cmdId;

    if (info == NULL) {
        HOST_Log("%s :: MgmtInfoType pointer is NULL\n", __FUNCTION__);
        goto done;
    }

    cmdId = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_CFP_ID, ETHSWT_CFPCMDID_STREAMPOLICER_DEL);
    msg.streamPolicerEntry.streamIdx = uswap32(streamIdx);

    retVal = HIPC_SendRecv(cmdId, (uint8_t *)&msg,
             sizeof(ETHSWT_CFPStreamType),
             (uint8_t *)&resp, sizeof(resp), &replyLen);

    if (retVal != BCM_ERR_OK) {
        goto done;
    } else if (uswap32(resp.status) != BCM_ERR_OK) {
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status));
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    } else if (replyLen != (MGMT_STATUS_LEN + sizeof(ETHSWT_CFPStreamType))) {
        HOST_Log("%s len:0x%x\n", __func__, replyLen);
        retVal = BCM_ERR_DATA_INTEG;
        goto done;
    }

done:
    return retVal;
}

int32_t HOST_CFPStreamBlock(MgmtInfoType *info, uint32_t streamIdx)
{
    int32_t              retVal = BCM_ERR_INVAL_PARAMS;

    ETHSWT_CFPMsgUnionType msg;
    RPC_ResponseType     resp;

    uint32_t             replyLen;
    uint32_t             cmdId;

    if (info == NULL) {
        HOST_Log("%s :: MgmtInfoType pointer is NULL\n", __FUNCTION__);
        goto done;
    }

    cmdId = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_CFP_ID, ETHSWT_CFPCMDID_BLOCKSTREAM);
    msg.streamPolicerEntry.streamIdx = uswap32(streamIdx);

    retVal = HIPC_SendRecv(cmdId, (uint8_t *)&msg,
             sizeof(ETHSWT_CFPStreamType),
             (uint8_t *)&resp, sizeof(resp), &replyLen);

    if (retVal != BCM_ERR_OK) {
        goto done;
    } else if (uswap32(resp.status) != BCM_ERR_OK) {
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status));
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    } else if (replyLen != (MGMT_STATUS_LEN + sizeof(ETHSWT_CFPStreamType))) {
        HOST_Log("%s len:0x%x\n", __func__, replyLen);
        retVal = BCM_ERR_DATA_INTEG;
        goto done;
    }

done:
    return retVal;
}

int32_t HOST_CFPStreamResume(MgmtInfoType *info, uint32_t streamIdx)
{
    int32_t              retVal = BCM_ERR_INVAL_PARAMS;

    ETHSWT_CFPMsgUnionType msg;
    RPC_ResponseType     resp;

    uint32_t             replyLen;
    uint32_t             cmdId;

    if (info == NULL) {
        HOST_Log("%s :: MgmtInfoType pointer is NULL\n", __FUNCTION__);
        goto done;
    }

    cmdId = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_CFP_ID, ETHSWT_CFPCMDID_RESUMESTREAM);
    msg.streamPolicerEntry.streamIdx = uswap32(streamIdx);

    retVal = HIPC_SendRecv(cmdId, (uint8_t *)&msg,
             sizeof(ETHSWT_CFPStreamType),
             (uint8_t *)&resp, sizeof(resp), &replyLen);

    if (retVal != BCM_ERR_OK) {
        goto done;
    } else if (uswap32(resp.status) != BCM_ERR_OK) {
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status));
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    } else if (replyLen != (MGMT_STATUS_LEN + sizeof(ETHSWT_CFPStreamType))) {
        HOST_Log("%s len:0x%x\n", __func__, replyLen);
        retVal = BCM_ERR_DATA_INTEG;
        goto done;
    }
done:
    return retVal;
}

int32_t HOST_CFPStreamPolicerFindIdx(MgmtInfoType *info, uint8_t *mac_addr, uint16_t vlan,
                                          uint32_t srcMask, uint32_t *const streamIdx)
{
    int32_t              retVal = BCM_ERR_INVAL_PARAMS;

    ETHSWT_CFPMsgUnionType msg;
    RPC_ResponseType     resp;

    uint32_t             replyLen;
    uint32_t             cmdId;

    if (info == NULL) {
        HOST_Log("%s :: MgmtInfoType pointer is NULL\n", __FUNCTION__);
        goto done;
    }

    cmdId = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_CFP_ID, ETHSWT_CFPCMDID_STREAMPOLICER_FIND);
    memcpy(&msg.streamPolicerEntry.macAddr[0], mac_addr, 6UL);
    msg.streamPolicerEntry.vlanID                 = uswap16(vlan);
    msg.streamPolicerEntry.policerParams.portMask = uswap32(srcMask);

    retVal = HIPC_SendRecv(cmdId, (uint8_t *)&msg,
             sizeof(ETHSWT_CFPStreamType),
             (uint8_t *)&resp, sizeof(resp), &replyLen);

    if (retVal != BCM_ERR_OK) {
        goto done;
    } else if (uswap32(resp.status) != BCM_ERR_OK) {
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status));
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    } else if (replyLen != (MGMT_STATUS_LEN + sizeof(ETHSWT_CFPStreamType))) {
        HOST_Log("%s len:0x%x\n", __func__, replyLen);
        retVal = BCM_ERR_DATA_INTEG;
        goto done;
    }

    memcpy((uint8_t *)&msg, &resp.payload[0], sizeof(ETHSWT_CFPStreamType));
    *streamIdx = uswap32(msg.streamPolicerEntry.streamIdx);
done:
    return retVal;
}

int32_t HOST_CFPStreamPolicerGetStatus(MgmtInfoType *info, ETHSWT_CFPStreamPolicerStatusType *const aStatus)
{
    int32_t              retVal = BCM_ERR_INVAL_PARAMS;

    ETHSWT_CFPMsgUnionType msg;
    RPC_ResponseType     resp;

    uint32_t             replyLen;
    uint32_t             cmdId;

    if (info == NULL) {
        HOST_Log("%s :: MgmtInfoType pointer is NULL\n", __FUNCTION__);
        goto done;
    }

    cmdId = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_CFP_ID, ETHSWT_CFPCMDID_STREAMPOLICER_GET);
    msg.streamPolicerStatus.idx = uswap32(aStatus->idx);

    retVal = HIPC_SendRecv(cmdId, (uint8_t *)&msg,
             sizeof(ETHSWT_CFPStreamPolicerStatusType),
             (uint8_t *)&resp, sizeof(resp), &replyLen);

    if (retVal != BCM_ERR_OK) {
        goto done;
    } else if (uswap32(resp.status) != BCM_ERR_OK) {
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status));
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    } else if (replyLen != (MGMT_STATUS_LEN + sizeof(ETHSWT_CFPStreamPolicerStatusType))) {
        HOST_Log("%s len:0x%x\n", __func__, replyLen);
        retVal = BCM_ERR_DATA_INTEG;
        goto done;
    }

    memcpy((uint8_t *)&msg, &resp.payload[0], sizeof(ETHSWT_CFPStreamPolicerStatusType));
    memcpy(aStatus->macAddress, msg.streamPolicerStatus.macAddress, 6U);
    aStatus->idx       = uswap32(msg.streamPolicerStatus.idx);
    aStatus->vlan      = uswap16(msg.streamPolicerStatus.vlan);
    aStatus->portMask  = uswap32(msg.streamPolicerStatus.portMask);
    aStatus->blocked   = uswap32(msg.streamPolicerStatus.blocked);
    aStatus->isStatic  = uswap32(msg.streamPolicerStatus.isStatic);
    aStatus->greenCntr = uswap32(msg.streamPolicerStatus.greenCntr);
    aStatus->redCntr   = uswap32(msg.streamPolicerStatus.redCntr);
done:
    return retVal;
}

int32_t HOST_CFPStreamPolicerSnapshot(MgmtInfoType *info, ETHSWT_CFPStreamPolicerSnapshotType *const aSnapshot)
{
    int32_t              retVal = BCM_ERR_INVAL_PARAMS;

    ETHSWT_CFPMsgUnionType msg;
    RPC_ResponseType     resp;

    uint32_t             replyLen;
    uint32_t             cmdId;

    if (info == NULL) {
        HOST_Log("%s :: MgmtInfoType pointer is NULL\n", __FUNCTION__);
        goto done;
    }

    cmdId = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_CFP_ID, ETHSWT_CFPCMDID_STREAMPOLICER_SNAPSHOT);

    retVal = HIPC_SendRecv(cmdId, (uint8_t *)&msg,
             sizeof(ETHSWT_CFPStreamPolicerSnapshotType),
             (uint8_t *)&resp, sizeof(resp), &replyLen);

    if (retVal != BCM_ERR_OK) {
        goto done;
    } else if (uswap32(resp.status) != BCM_ERR_OK) {
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status));
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    } else if (replyLen != (MGMT_STATUS_LEN + sizeof(ETHSWT_CFPStreamPolicerSnapshotType))) {
        HOST_Log("%s len:0x%x\n", __func__, replyLen);
        retVal = BCM_ERR_DATA_INTEG;
        goto done;
    }

    memcpy(aSnapshot, &resp.payload[0], sizeof(ETHSWT_CFPStreamPolicerSnapshotType));
done:
    return retVal;
}

