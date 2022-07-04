/*****************************************************************************
 Copyright 2018-2020 Broadcom Limited.  All rights reserved.

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
#include <stdio.h>
#include <time.h>
#include <sys/time.h>
#include "hipc.h"
#include <bcm_err.h>
#include <bcm_utils.h>
#include <ets_osil.h>
#include <rpc_cmds.h>
#include <host_ets.h>
#include <ethernet_ets.h>
#include <hlog.h>

#define HOST_ETS_ASYNC_PREFIX  "ETS Notification:"
#define HOST_ETS_MAX_PORTS     (15U)

extern uint32_t CurrentSpiId;

#ifdef ENABLE_RECORD_NOTIFICATION
static ETS_RecordType portRecords[HOST_ETS_MAX_PORTS][ETS_NUM_RECORDS_PER_INTF];
#endif

int32_t HOST_ETSGetGlobalStatus(MgmtInfoType *info, ETS_GlobalStatusType *globalStatus)
{
    int32_t retVal = -1;
    ETS_MsgUnionType cmdHdl;
    RPC_ResponseType resp;

    uint32_t replyLen;
    uint32_t cmdId;

    if ((info == NULL) || (globalStatus == NULL)) {
        HOST_Log("%s :: Invalid input parameter(info = %p, globalStatus = %p)\n",
            __FUNCTION__, info, globalStatus);
        goto done;
    }

    memset((uint8_t *)cmdHdl.data, 0, sizeof(cmdHdl));

    cmdId = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_ETS_ID, ETS_CMD_GETGLOBALSTATUS);

    retVal = HIPC_SendRecv(cmdId, (uint8_t *)cmdHdl.data,
             sizeof(ETS_GlobalStatusType), (uint8_t *)&resp, RPC_CMDPAYLOADSZ, &replyLen);

    if (retVal != BCM_ERR_OK) {
        goto done;
    } else if (uswap32(resp.status) != BCM_ERR_OK) {
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status));
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    } else if (replyLen != (MGMT_STATUS_LEN + sizeof(ETS_GlobalStatusType))) {
        HOST_Log("%s len:0x%x\n", __func__, replyLen);
        retVal = BCM_ERR_DATA_INTEG;
        goto done;
    } else {
        memcpy((uint8_t *)&cmdHdl, &resp.payload[0], sizeof(ETS_GlobalStatusType));
        globalStatus->magicId = uswap32(cmdHdl.globalStatus.magicId);
        memcpy(&globalStatus->clockId.id[0], &cmdHdl.globalStatus.clockId.id[0], sizeof(ETS_ClockIdentityType));
        globalStatus->networkTime.seconds = uswap64(cmdHdl.globalStatus.networkTime.seconds);
        globalStatus->networkTime.nanoseconds = uswap32(cmdHdl.globalStatus.networkTime.nanoseconds);
        globalStatus->networkTimeState = uswap32(cmdHdl.globalStatus.networkTimeState);
        globalStatus->activeDomainNum = cmdHdl.globalStatus.activeDomainNum;
    }

done:
    return retVal;
}

int32_t HOST_ETSGetDomainStatus(MgmtInfoType *info, ETS_DomainType domain, ETS_DomainStatusType *domainStatus)
{
    int32_t retVal = -1;
    uint32_t i = 0UL;
    ETS_MsgUnionType cmdHdl;
    RPC_ResponseType resp;

    uint32_t replyLen;
    uint32_t cmdId;

    if ((info == NULL) || (domainStatus == NULL)) {
        HOST_Log("%s :: Invalid input parameter(info = %p, domainStatus = %p)\n",
            __FUNCTION__, info, domainStatus);
        goto done;
    }

    memset((uint8_t *)cmdHdl.data, 0, sizeof(cmdHdl));

    cmdHdl.domainStatus.num = domain;
    cmdId = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_ETS_ID, ETS_CMD_GETDOMAINSTATUS);

    retVal = HIPC_SendRecv(cmdId, (uint8_t *)cmdHdl.data,
             sizeof(ETS_DomainNumAndStatusType), (uint8_t *)&resp, RPC_CMDPAYLOADSZ, &replyLen);

    if (retVal != BCM_ERR_OK) {
        goto done;
    } else if (uswap32(resp.status) != BCM_ERR_OK) {
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status));
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    } else if (replyLen != (MGMT_STATUS_LEN + sizeof(ETS_DomainNumAndStatusType))) {
        HOST_Log("%s len:0x%x\n", __func__, replyLen);
        retVal = BCM_ERR_DATA_INTEG;
        goto done;
    } else {
        memcpy((uint8_t *)&cmdHdl, &resp.payload[0], sizeof(ETS_DomainNumAndStatusType));
        domainStatus->magicId                  = uswap32(cmdHdl.domainStatus.status.magicId);
        domainStatus->clockState               = uswap32(cmdHdl.domainStatus.status.clockState);
        domainStatus->gmStatus                 = uswap32(cmdHdl.domainStatus.status.gmStatus);
        domainStatus->rateRatioIn              = uswap32(cmdHdl.domainStatus.status.rateRatioIn);
        domainStatus->gmRateRatio              = uswap32(cmdHdl.domainStatus.status.gmRateRatio);
        domainStatus->slavePort                = uswap32(cmdHdl.domainStatus.status.slavePort);
        domainStatus->signalingTxSeqId         = uswap16(cmdHdl.domainStatus.status.signalingTxSeqId);
        domainStatus->reqSyncLogInterval       = uswap32(cmdHdl.domainStatus.status.reqSyncLogInterval);
        domainStatus->isSignalingTimerStarted  = uswap32(cmdHdl.domainStatus.status.isSignalingTimerStarted);;
        domainStatus->isSyncReceived           = uswap32(cmdHdl.domainStatus.status.isSyncReceived);
        domainStatus->rxFollowupCorrection     = uswap64(cmdHdl.domainStatus.status.rxFollowupCorrection);
        domainStatus->rxPOT.seconds            = uswap64(cmdHdl.domainStatus.status.rxPOT.seconds);
        domainStatus->rxPOT.nanoseconds        = uswap32(cmdHdl.domainStatus.status.rxPOT.nanoseconds);
        domainStatus->gmIdentifier.stepsRemoved= uswap16(cmdHdl.domainStatus.status.gmIdentifier.stepsRemoved);
        memcpy(&domainStatus->gmIdentifier.clockId,
               &cmdHdl.domainStatus.status.gmIdentifier.clockId,
               sizeof(ETS_ClockIdentityType));
        domainStatus->gmIdentifier.systemId.priority1 =
            cmdHdl.domainStatus.status.gmIdentifier.systemId.priority1;
        domainStatus->gmIdentifier.systemId.clockClass =
            cmdHdl.domainStatus.status.gmIdentifier.systemId.clockClass;
        domainStatus->gmIdentifier.systemId.clockAccuracy =
            cmdHdl.domainStatus.status.gmIdentifier.systemId.clockAccuracy;
        domainStatus->gmIdentifier.systemId.offsetScaledLogVariance =
            uswap16(cmdHdl.domainStatus.status.gmIdentifier.systemId.offsetScaledLogVariance);
        domainStatus->gmIdentifier.systemId.priority2 =
            cmdHdl.domainStatus.status.gmIdentifier.systemId.priority2;
        domainStatus->gmIdentifier.timeSource = cmdHdl.domainStatus.status.gmIdentifier.timeSource;
        domainStatus->gmIdentifier.pathTrace.type = uswap16(cmdHdl.domainStatus.status.gmIdentifier.pathTrace.type);
        domainStatus->gmIdentifier.pathTrace.length = uswap16(cmdHdl.domainStatus.status.gmIdentifier.pathTrace.length);
        for (; i < ETS_MAX_HOPS_PER_DOMAIN; ++i) {
            memcpy(&domainStatus->gmIdentifier.pathTrace.clkID[i],
                   &cmdHdl.domainStatus.status.gmIdentifier.pathTrace.clkID[i],
                   sizeof(ETS_ClockIdentityType));
        }
        domainStatus->gmIdentifier.utcOffset = uswap16(cmdHdl.domainStatus.status.gmIdentifier.utcOffset);
        domainStatus->gmIdentifier.flags = uswap16(cmdHdl.domainStatus.status.gmIdentifier.flags);
        domainStatus->gmChangeCount = uswap32(cmdHdl.domainStatus.status.gmChangeCount);
        domainStatus->parentId.port = uswap16(cmdHdl.domainStatus.status.parentId.port);
        memcpy(&domainStatus->parentId.clockID,
               &cmdHdl.domainStatus.status.parentId.clockID,
               sizeof(ETS_ClockIdentityType));
        domainStatus->domainState = cmdHdl.domainStatus.status.domainState;
    }

done:
    return retVal;
}

int32_t HOST_ETSGetPortStatus(MgmtInfoType *info, ETS_PortNumAndStatusType *portStatus)
{
    int32_t retVal = -1;
    ETS_MsgUnionType cmdHdl;
    RPC_ResponseType resp;

    uint32_t replyLen;
    uint32_t cmdId;

    if ((info == NULL) || (portStatus == NULL)) {
        HOST_Log("%s :: Invalid input parameter is NULL\n", __FUNCTION__);
        goto done;
    }

    memset((uint8_t *)cmdHdl.data, 0, sizeof(cmdHdl));

    cmdHdl.portStatus.num = uswap32(portStatus->num);

    cmdId = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_ETS_ID, ETS_CMD_GETPORTSTATUS);

    retVal = HIPC_SendRecv(cmdId, (uint8_t *)cmdHdl.data,
            sizeof(ETS_PortNumAndStatusType),
            (uint8_t *)&resp, RPC_CMDPAYLOADSZ, &replyLen);

    if (retVal != BCM_ERR_OK) {
        goto done;
    } else if (uswap32(resp.status) != BCM_ERR_OK) {
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status));
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    } else if (replyLen != (MGMT_STATUS_LEN + sizeof(ETS_PortNumAndStatusType))) {
        HOST_Log("%s len:0x%x\n", __func__, replyLen);
        retVal = BCM_ERR_DATA_INTEG;
        goto done;
    } else {
        memcpy((uint8_t *)&cmdHdl, &resp.payload[0], sizeof(ETS_PortNumAndStatusType));
        portStatus->status.magicId = uswap32(cmdHdl.portStatus.status.magicId);
        portStatus->status.nbrPropDelay = uswap32(cmdHdl.portStatus.status.nbrPropDelay);
        portStatus->status.nbrRateRatio = uswap32(cmdHdl.portStatus.status.nbrRateRatio);
        portStatus->status.isMeasuringPdelay = uswap32(cmdHdl.portStatus.status.isMeasuringPdelay);
        portStatus->status.isAVnuPdelayConfigSaved = uswap32(cmdHdl.portStatus.status.isAVnuPdelayConfigSaved);
        portStatus->status.currentLogPdelayIntvl = uswap32(cmdHdl.portStatus.status.currentLogPdelayIntvl);
        memcpy(&portStatus->status.partnerId,
                &cmdHdl.portStatus.status.partnerId,
                sizeof(portStatus->status.partnerId));
        portStatus->status.pDelayTxSeqId = uswap16(cmdHdl.portStatus.status.pDelayTxSeqId);
        portStatus->status.numPdelayRespLost = uswap32(cmdHdl.portStatus.status.numPdelayRespLost);
        portStatus->status.pDelayReqState = uswap32(cmdHdl.portStatus.status.pDelayReqState);
        portStatus->status.pDelayRespState = uswap32(cmdHdl.portStatus.status.pDelayRespState);
        portStatus->status.pDelayT1.seconds = uswap64(cmdHdl.portStatus.status.pDelayT1.seconds);
        portStatus->status.pDelayT1.nanoseconds = uswap32(cmdHdl.portStatus.status.pDelayT1.nanoseconds);
        portStatus->status.pDelayT2.seconds = uswap64(cmdHdl.portStatus.status.pDelayT2.seconds);
        portStatus->status.pDelayT2.nanoseconds = uswap32(cmdHdl.portStatus.status.pDelayT2.nanoseconds);
        portStatus->status.pDelayT3.seconds = uswap64(cmdHdl.portStatus.status.pDelayT3.seconds);
        portStatus->status.pDelayT3.nanoseconds = uswap32(cmdHdl.portStatus.status.pDelayT3.nanoseconds);
        portStatus->status.pDelayT4.seconds = uswap64(cmdHdl.portStatus.status.pDelayT4.seconds);
        portStatus->status.pDelayT4.nanoseconds = uswap32(cmdHdl.portStatus.status.pDelayT4.nanoseconds);
        portStatus->status.asCapableAcrossDomains = uswap32(cmdHdl.portStatus.status.asCapableAcrossDomains);
    }

done:
    return retVal;
}

int32_t HOST_ETSGetPerDomainPortStatus(MgmtInfoType *info, ETS_PerDomainPortStatusType *status)
{
    int32_t retVal = -1;
    ETS_MsgUnionType cmdHdl;
    RPC_ResponseType resp;

    uint32_t replyLen;
    uint32_t cmdId;

    if ((info == NULL) || (status == NULL)) {
        HOST_Log("%s :: Invalid input parameter is NULL\n", __FUNCTION__);
        goto done;
    }

    memset((uint8_t *)cmdHdl.data, 0, sizeof(cmdHdl));

    cmdHdl.domainPortStatus.portNum = uswap32(status->portNum);
    cmdHdl.domainPortStatus.domain  = status->domain;

    cmdId = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_ETS_ID, ETS_CMD_GETDOMAINPORTSTATUS);

    retVal = HIPC_SendRecv(cmdId, (uint8_t *)cmdHdl.data,
            sizeof(ETS_PerDomainPortStatusType),
            (uint8_t *)&resp, RPC_CMDPAYLOADSZ, &replyLen);

    if (retVal != BCM_ERR_OK) {
        goto done;
    } else if (uswap32(resp.status) != BCM_ERR_OK) {
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status));
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    } else if (replyLen != (MGMT_STATUS_LEN + sizeof(ETS_PerDomainPortStatusType))) {
        HOST_Log("%s len:0x%x\n", __func__, replyLen);
        retVal = BCM_ERR_DATA_INTEG;
        goto done;
    } else {
        memcpy((uint8_t *)&cmdHdl, &resp.payload[0], sizeof(ETS_PerDomainPortStatusType));
        status->status.magicId = uswap32(cmdHdl.domainPortStatus.status.magicId);
        status->status.role = cmdHdl.domainPortStatus.status.role;
        status->status.currentLogSyncIntvl = uswap32(cmdHdl.domainPortStatus.status.currentLogSyncIntvl);
        status->status.syncReceiptTimeoutIntvl = uswap32(cmdHdl.domainPortStatus.status.syncReceiptTimeoutIntvl);
        status->status.syncInfoAvailable = uswap32(cmdHdl.domainPortStatus.status.syncInfoAvailable);
        status->status.syncSeqNum = uswap16(cmdHdl.domainPortStatus.status.syncSeqNum);
        status->status.txFollowupCorrection = uswap64(cmdHdl.domainPortStatus.status.txFollowupCorrection);
        status->status.syncState = uswap32(cmdHdl.domainPortStatus.status.syncState);
        status->status.syncTimestamp.seconds = uswap64(cmdHdl.domainPortStatus.status.syncTimestamp.seconds);
        status->status.syncTimestamp.nanoseconds = uswap32(cmdHdl.domainPortStatus.status.syncTimestamp.nanoseconds);
        status->status.announceSeqNum = uswap16(cmdHdl.domainPortStatus.status.announceSeqNum);
        status->status.currentLogAnnIntvl = uswap32(cmdHdl.domainPortStatus.status.currentLogAnnIntvl);
        status->status.annReceiptTimeoutIntvl = uswap32(cmdHdl.domainPortStatus.status.annReceiptTimeoutIntvl);
        status->status.currentLogGptpCapIntvl = uswap32(cmdHdl.domainPortStatus.status.currentLogGptpCapIntvl);
        status->status.gPTPCapReceiptTimeoutIntvl = uswap32(cmdHdl.domainPortStatus.status.gPTPCapReceiptTimeoutIntvl);

        status->stats.magicId = uswap32(cmdHdl.domainPortStatus.stats.magicId);
        status->stats.syncTxCount = uswap32(cmdHdl.domainPortStatus.stats.syncTxCount);
        status->stats.syncRxCount = uswap32(cmdHdl.domainPortStatus.stats.syncRxCount);
        status->stats.syncTransmitTimeouts = uswap32(cmdHdl.domainPortStatus.stats.syncTransmitTimeouts);
        status->stats.syncRxDiscards = uswap32(cmdHdl.domainPortStatus.stats.syncRxDiscards);
        status->stats.followUpTxCount = uswap32(cmdHdl.domainPortStatus.stats.followUpTxCount);
        status->stats.followUpRxCount = uswap32(cmdHdl.domainPortStatus.stats.followUpRxCount);
        status->stats.followUpRxDiscards = uswap32(cmdHdl.domainPortStatus.stats.followUpRxDiscards);
        status->stats.signalingTxCount = uswap32(cmdHdl.domainPortStatus.stats.signalingTxCount);
        status->stats.signalingRxCount = uswap32(cmdHdl.domainPortStatus.stats.signalingRxCount);
        status->stats.signalingRxDiscards = uswap32(cmdHdl.domainPortStatus.stats.signalingRxDiscards);
        status->stats.announceTxCount = uswap32(cmdHdl.domainPortStatus.stats.announceTxCount);
        status->stats.announceRxCount = uswap32(cmdHdl.domainPortStatus.stats.announceRxCount);
        status->stats.announceRxDiscards = uswap32(cmdHdl.domainPortStatus.stats.announceRxDiscards);
        status->stats.announceReceiptTimeouts = uswap32(cmdHdl.domainPortStatus.stats.announceReceiptTimeouts);
        status->stats.pDelayReqTxCount = uswap32(cmdHdl.domainPortStatus.stats.pDelayReqTxCount);
        status->stats.pDelayReqRxCount = uswap32(cmdHdl.domainPortStatus.stats.pDelayReqRxCount);
        status->stats.pDelayReqRxDiscards = uswap32(cmdHdl.domainPortStatus.stats.pDelayReqRxDiscards);
        status->stats.pDelayRespTxCount = uswap32(cmdHdl.domainPortStatus.stats.pDelayRespTxCount);
        status->stats.pDelayRespRxCount = uswap32(cmdHdl.domainPortStatus.stats.pDelayRespRxCount);
        status->stats.pDelayRespRxDiscards = uswap32(cmdHdl.domainPortStatus.stats.pDelayRespRxDiscards);
        status->stats.pDelayRespFollowUpTxCount = uswap32(cmdHdl.domainPortStatus.stats.pDelayRespFollowUpTxCount);
        status->stats.pDelayRespFollowUpRxCount = uswap32(cmdHdl.domainPortStatus.stats.pDelayRespFollowUpRxCount);
        status->stats.syncReceiptTimeouts = uswap32(cmdHdl.domainPortStatus.stats.syncReceiptTimeouts);
        status->stats.followupReceiptTimeouts = uswap32(cmdHdl.domainPortStatus.stats.followupReceiptTimeouts);
        status->stats.pDelayReceiptTimeouts = uswap32(cmdHdl.domainPortStatus.stats.pDelayReceiptTimeouts);
        status->stats.badPdelayValues = uswap32(cmdHdl.domainPortStatus.stats.badPdelayValues);
        status->stats.txErrors = uswap32(cmdHdl.domainPortStatus.stats.txErrors);
        status->stats.tsErrors = uswap32(cmdHdl.domainPortStatus.stats.tsErrors);
        status->stats.ptpDiscardCount = uswap32(cmdHdl.domainPortStatus.stats.ptpDiscardCount);
        status->stats.parseFailed = uswap32(cmdHdl.domainPortStatus.stats.parseFailed);
        status->stats.txConf = uswap32(cmdHdl.domainPortStatus.stats.txConf);
        status->stats.pDelayLostResponsesExceeded = uswap32(cmdHdl.domainPortStatus.stats.pDelayLostResponsesExceeded);
        status->stats.setTimeCount = uswap32(cmdHdl.domainPortStatus.stats.setTimeCount);
        status->stats.deltaTime0NsTo10Ns = uswap32(cmdHdl.domainPortStatus.stats.deltaTime0NsTo10Ns);
        status->stats.deltaTime11NsTo40Ns = uswap32(cmdHdl.domainPortStatus.stats.deltaTime11NsTo40Ns);
        status->stats.deltaTime41NsTo80Ns = uswap32(cmdHdl.domainPortStatus.stats.deltaTime41NsTo80Ns);
        status->stats.deltaTime81NsTo100Ns = uswap32(cmdHdl.domainPortStatus.stats.deltaTime81NsTo100Ns);
        status->stats.deltaTime101NsTo1000Ns = uswap32(cmdHdl.domainPortStatus.stats.deltaTime101NsTo1000Ns);
        status->stats.deltaTime1001NsTo10000Ns = uswap32(cmdHdl.domainPortStatus.stats.deltaTime1001NsTo10000Ns);
        status->stats.deltaTime10001NsToMax = uswap32(cmdHdl.domainPortStatus.stats.deltaTime10001NsToMax);
    }

done:
    return retVal;
}

/*
   @api
 * mgmt_stats_clear
 *
 * @brief
 * Clear the 802.1AS stats for a port
 *
 * @param=info - management info
 * @param=port - port number
 *
 * @returns 0 on success, !0 on error
 */
int32_t HOST_ETSClearPortStats(MgmtInfoType *info, uint32_t port, ETS_DomainType domain)
{
    int32_t retVal = -1;
    ETS_MsgUnionType cmdHdl;
    RPC_ResponseType resp;

    uint32_t replyLen;
    uint32_t cmdId;

    if (info == NULL) {
        HOST_Log("%s :: MgmtInfoType pointer is NULL\n", __FUNCTION__);
        goto done;
    }

    memset((uint8_t *)cmdHdl.data, 0, sizeof(cmdHdl));

    cmdHdl.domainPortStatus.portNum = uswap32(port);
    cmdHdl.domainPortStatus.domain  = domain;

    cmdId = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_ETS_ID, ETS_CMD_RESETSTATS);

    retVal = HIPC_SendRecv(cmdId, (uint8_t *)cmdHdl.data,
            sizeof(ETS_PerDomainPortStatusType),
            (uint8_t *)&resp, RPC_CMDPAYLOADSZ, &replyLen);

    if (retVal != BCM_ERR_OK) {
        goto done;
    } else if (uswap32(resp.status) != BCM_ERR_OK) {
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status));
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    } else if (replyLen != (MGMT_STATUS_LEN)) {
        HOST_Log("%s len:0x%x\n", __func__, replyLen);
        retVal = BCM_ERR_DATA_INTEG;
        goto done;
    }

done:
    return retVal;
}

int32_t HOST_ETSSetTime(MgmtInfoType *info, uint32_t sec_high, uint32_t sec_low, uint32_t nanosec)
{
    int32_t retVal = -1;
    ETS_MsgUnionType cmdHdl;
    RPC_ResponseType resp;

    uint32_t replyLen;
    uint32_t cmdId;

    if (info == NULL) {
        HOST_Log("%s :: MgmtInfoType pointer is NULL\n", __FUNCTION__);
        goto done;
    }

    memset((uint8_t *)cmdHdl.data, 0, sizeof(cmdHdl));

    cmdId = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_ETS_ID, ETS_CMD_SETGLOBALTIME);

    cmdHdl.time.seconds = uswap64((((uint64_t)sec_high << 32) | sec_low));
    cmdHdl.time.nanoseconds = uswap32(nanosec);

    retVal = HIPC_SendRecv(cmdId, (uint8_t *)cmdHdl.data,
             sizeof(ETS_TimeType), (uint8_t *)&resp, RPC_CMDPAYLOADSZ, &replyLen);

    if (retVal != BCM_ERR_OK) {
        goto done;
    } else if (uswap32(resp.status) != BCM_ERR_OK) {
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status));
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    } else if (replyLen != (MGMT_STATUS_LEN)) {
        HOST_Log("%s len:0x%x\n", __func__, replyLen);
        retVal = BCM_ERR_DATA_INTEG;
        goto done;
    }

done:
    return retVal;
}

int32_t HOST_ETSSetGlobalEnable(MgmtInfoType *info, uint32_t globalEnable)
{
    int32_t retVal = -1;
    ETS_MsgUnionType cmdHdl;
    RPC_ResponseType resp;

    uint32_t replyLen;
    uint32_t cmdId;

    /* validate parameters */
    if (info == NULL) {
        HOST_Log("%s :: MgmtInfoType pointer is NULL\n", __FUNCTION__);
        goto done;
    } else if ((globalEnable != FALSE) && (globalEnable != TRUE)) {
        HOST_Log("%s invalid mode:%d\n", __FUNCTION__, globalEnable);
        goto done;
    }

    memset((uint8_t *)cmdHdl.data, 0, sizeof(cmdHdl));
    cmdId = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_ETS_ID, ETS_CMD_SETGLOBALENABLE);
    cmdHdl.globalEnable = uswap32(globalEnable);

    retVal = HIPC_SendRecv(cmdId, (uint8_t *)cmdHdl.data,
             sizeof(uint32_t), (uint8_t *)&resp, RPC_CMDPAYLOADSZ, &replyLen);
    if (retVal != BCM_ERR_OK) {
        goto done;
    } else if (uswap32(resp.status) != BCM_ERR_OK) {
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status));
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    } else if (replyLen != (MGMT_STATUS_LEN)) {
        HOST_Log("%s len:0x%x\n", __func__, replyLen);
        retVal = BCM_ERR_DATA_INTEG;
        goto done;
    }

done:
    return retVal;
}

int32_t HOST_ETSSetPortEnable(MgmtInfoType *info, uint32_t port, uint32_t portEnable, ETS_DomainType domain)
{
    int32_t retVal = -1;
    ETS_MsgUnionType cmdHdl;
    RPC_ResponseType resp;

    uint32_t replyLen;
    uint32_t cmdId;

    /* validate parameters */
    if (info == NULL) {
        HOST_Log("%s :: MgmtInfoType pointer is NULL\n", __FUNCTION__);
        goto done;
    } else if ((portEnable != FALSE) && (portEnable != TRUE)) {
        HOST_Log("%s invalid portEnable:%d\n", __FUNCTION__, portEnable);
        goto done;
    }

    memset((uint8_t *)cmdHdl.data, 0, sizeof(cmdHdl));

    cmdId = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_ETS_ID, ETS_CMD_SETPORTENABLE);

    cmdHdl.portEnable.num = uswap32(port);
    cmdHdl.portEnable.domain = domain;
    cmdHdl.portEnable.portEnable = uswap32(portEnable);

    retVal = HIPC_SendRecv(cmdId, (uint8_t *)cmdHdl.data,
             sizeof(ETS_PortEnableType), (uint8_t *)&resp, RPC_CMDPAYLOADSZ, &replyLen);

    if (retVal != BCM_ERR_OK) {
        goto done;
    } else if (uswap32(resp.status) != BCM_ERR_OK) {
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status));
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    } else if (replyLen != (MGMT_STATUS_LEN)) {
        HOST_Log("%s len:0x%x\n", __func__, replyLen);
        retVal = BCM_ERR_DATA_INTEG;
        goto done;
    }

done:
    return retVal;
}

#ifdef ENABLE_RECORD_NOTIFICATION
int32_t HOST_ETSStartStopSendingRecord(MgmtInfoType *info, uint8_t isStart)
{
    int32_t retVal = -1;
    ETS_MsgUnionType cmdHdl;
    RPC_ResponseType resp;

    uint32_t replyLen;
    uint32_t cmdId;

    if (info == NULL) {
        HOST_Log("%s :: MgmtInfoType pointer is NULL\n", __FUNCTION__);
        goto done;
    }

    memset((uint8_t *)cmdHdl.data, 0, sizeof(cmdHdl));

    cmdId = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_ETS_ID, ETS_CMD_NOTIFY_RECORD);
    cmdHdl.isNotifyingRecord = uswap32(isStart);
    retVal = HIPC_SendRecv(cmdId, (uint8_t *)cmdHdl.data,
             sizeof(cmdHdl.isNotifyingRecord), (uint8_t *)&resp, RPC_CMDPAYLOADSZ, &replyLen);

    if (retVal != BCM_ERR_OK) {
        goto done;
    } else if (uswap32(resp.status) != BCM_ERR_OK) {
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status));
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    } else if (replyLen != MGMT_STATUS_LEN) {
        HOST_Log("%s len:0x%x\n", __func__, replyLen);
        retVal = BCM_ERR_DATA_INTEG;
        goto done;
    }

    if (0U == isStart) {
        memset(portRecords, 0U, sizeof(portRecords));
    }
done:
    return retVal;
}

int32_t HOST_ETSGetRecord(uint32_t portIdx, ETS_RecordType *records, uint32_t size)
{
    int32_t retVal = BCM_ERR_OK;

    /* validate parameters */
    if (records == NULL)  {
        HOST_Log("%s :: ETS_RecordType pointer is NULL\n", __FUNCTION__);
        goto done;
    }

    if (size > ETS_NUM_RECORDS_PER_INTF)  {
        HOST_Log("%s :: invalid size:%d\n", __FUNCTION__, size);
        goto done;
    }

    if (portIdx >= HOST_ETS_MAX_PORTS) {
        HOST_Log("%s :: portIdx is: %lu , which is greater than max allowed value: %lu \n",
                __FUNCTION__, portIdx, (HOST_ETS_MAX_PORTS - 1));
        retVal = BCM_ERR_INVAL_PARAMS;
        goto done;
    }

    memcpy(records, &portRecords[portIdx] , size * sizeof(ETS_RecordType));
done:
    return retVal;
}

static int32_t HOST_ETSMsgToIndex(uint32_t isTX, ETS_MsgType msgType, uint32_t* msgIdx)
{
    int32_t retVal = BCM_ERR_OK;
    switch (msgType) {
        case ETS_MSG_SYNC:
            *msgIdx = 0UL;
            break;
        case ETS_MSG_FOLLOWUP:
            *msgIdx = 1UL;
            break;
        case ETS_MSG_PDELAY_REQ:
            *msgIdx = 2UL ;
            break;
        case ETS_MSG_PDELAY_RESP:
            *msgIdx = 3UL ;
            break;
        case ETS_MSG_PDELAY_RESP_FOLLOWUP:
            *msgIdx = 4UL ;
            break;
        default:
            *msgIdx = 0xFFFFFFFF;
            retVal = BCM_ERR_INVAL_PARAMS;
            break;
    }
    return retVal;
}
#endif

int32_t HOST_ETSNotificationHandler(uint32_t currentSlave, ETS_EventType notificationId, uint8_t *msg, uint32_t size)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    if (NULL == msg) {
        HOST_Log("%s SPI-Id:%u Invalid parameter notificationId:0x%x msg:%p size=%d\n",
            __func__, currentSlave, notificationId, msg, size);
        goto done;
    }


#ifdef ENABLE_RECORD_NOTIFICATION
    if(ETS_EVENT_IF_RECORD == notificationId) {
            uint32_t portIdx;
            uint32_t i;
            uint32_t validRecords;
            uint32_t msgIdx;
            uint32_t flag;
            uint32_t portAndRecNum;
            ETS_MsgUnionType notificationHdl;

            BCM_MemCpy(notificationHdl.data, msg, sizeof(notificationHdl));
            validRecords = uswap32(notificationHdl.records.numRecords);
            for (i = 0UL; i < validRecords; ++i) {
                    /* Cache the latest record for each port */
                    portAndRecNum = uswap32(notificationHdl.records.records[i].portAndRecNum);
                    portIdx = (portAndRecNum & ETS_RECORDDEFS_PORT_NUM_MASK) >> ETS_RECORDDEFS_PORT_NUM_SHIFT;
                    if (portIdx >= HOST_ETS_MAX_PORTS) {
                        retVal = BCM_ERR_INVAL_PARAMS;
                        HOST_Log("%s :: portIdx is: %lu , which is greater than max allowed value: %lu \n",
                                __FUNCTION__, portIdx, (HOST_ETS_MAX_PORTS - 1));
                        goto done;
                    }
                    flag = uswap32(notificationHdl.records.records[i].flag);
                    retVal = HOST_ETSMsgToIndex((flag & ETS_RECORDDEFS_IS_TX_MASK) >> ETS_RECORDDEFS_IS_TX_SHIFT,
                                        (flag & ETS_RECORDDEFS_PACKET_TYPE_MASK) >> ETS_RECORDDEFS_PACKET_TYPE_SHIFT,
                                        &msgIdx);
                    if (retVal != BCM_ERR_OK) {
                        HOST_Log("%s :: msgIdx invalid: %lu\n", __FUNCTION__, msgIdx);
                        goto done;
                    }
                    portRecords[portIdx][msgIdx].gmTime.s             = uswap32(notificationHdl.records.records[i].gmTime.s);
                    portRecords[portIdx][msgIdx].gmTime.ns            = uswap32(notificationHdl.records.records[i].gmTime.ns);
                    portRecords[portIdx][msgIdx].localTime.s          = uswap32(notificationHdl.records.records[i].localTime.s);
                    portRecords[portIdx][msgIdx].localTime.ns         = uswap32(notificationHdl.records.records[i].localTime.ns);
                    portRecords[portIdx][msgIdx].followupTimestamp.s  = uswap32(notificationHdl.records.records[i].followupTimestamp.s);
                    portRecords[portIdx][msgIdx].followupTimestamp.ns = uswap32(notificationHdl.records.records[i].followupTimestamp.ns);
                    portRecords[portIdx][msgIdx].portAndRecNum        = portAndRecNum;
                    portRecords[portIdx][msgIdx].flag                 = flag;
                    portRecords[portIdx][msgIdx].srcPortIdentity.port = uswap16(notificationHdl.records.records[i].srcPortIdentity.port);
                    memcpy(portRecords[portIdx][msgIdx].srcPortIdentity.clockID.id,
                            notificationHdl.records.records[i].srcPortIdentity.clockID.id,
                            sizeof(ETS_ClockIdentityType));
                    portRecords[portIdx][msgIdx].pDelay               = uswap32(notificationHdl.records.records[i].pDelay);
                    portRecords[portIdx][msgIdx].deltaCorrectionTime  = uswap64(notificationHdl.records.records[i].deltaCorrectionTime);
            }
            retVal = BCM_ERR_OK;
        }
#endif

done:
    return retVal;
}

