/*****************************************************************************
 Copyright 2018-2019 Broadcom Limited.  All rights reserved.

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
#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include <time.h>
#include <sys/time.h>
#include "hipc.h"
#include <bcm_err.h>
#include <string.h>
#include <ethernet_nif.h>
#include <rpc_cmds.h>
#include <host_etherswt.h>
#include <bcm_utils.h>
#include <hlog.h>
#include <ethernet_swt_arl.h>

#define MAX_SYNC_PULSES 8
#define MGMT_ETHER_ADDR_LEN                    6
#define GET_ARL_SNAPSHOT_ATTEMPT_MAX 12

int32_t HOST_EtherSwtMib(MgmtInfoType *info, int32_t port, ETHSWT_DebugMibType *mib)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;
    ETHSWT_DebugMsgUnionType cmdMsg;
    RPC_ResponseType resp;

    uint32_t replyLen;
    uint32_t cmdId;

    if ((info == NULL) || (mib == NULL)) {
        HOST_Log("%s :: Invalid input param(info:%p mib:%p)\n",
                __FUNCTION__, info, mib);
        goto done;
    }

    memset((uint8_t *)cmdMsg.data, 0, sizeof(cmdMsg));

    cmdMsg.mib.port = uswap32(port);

    cmdId = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_DBG_ID, ETHSWT_DEBUGCMDID_MIBS);
    retVal = HIPC_SendRecv(cmdId, (uint8_t *)cmdMsg.data,
                sizeof(ETHSWT_DebugMibType), (uint8_t *)&resp,
                sizeof(resp), &replyLen);

    if (retVal != BCM_ERR_OK) {
        goto done;
    } else if (uswap32(resp.status) != BCM_ERR_OK) {
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status));
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    } else if (replyLen != (MGMT_STATUS_LEN + sizeof(ETHSWT_DebugMibType))) {
        HOST_Log("%s len:0x%x\n", __func__, replyLen);
        retVal = BCM_ERR_DATA_INTEG;
        goto done;
    } else {
        memcpy((uint8_t *)&cmdMsg, &resp.payload[0], sizeof(ETHSWT_DebugMibType));
        mib->port = uswap32(cmdMsg.mib.port);
        mib->rxStats.gdPkts = uswap32(cmdMsg.mib.rxStats.gdPkts);
        mib->rxStats.octetsLow = uswap32(cmdMsg.mib.rxStats.octetsLow);
        mib->rxStats.octetsHigh = uswap32(cmdMsg.mib.rxStats.octetsHigh);
        mib->rxStats.allPkts = uswap32(cmdMsg.mib.rxStats.allPkts);
        mib->rxStats.brdCast = uswap32(cmdMsg.mib.rxStats.brdCast);
        mib->rxStats.mutCast = uswap32(cmdMsg.mib.rxStats.mutCast);
        mib->rxStats.uniCast = uswap32(cmdMsg.mib.rxStats.uniCast);
        mib->rxStats.pkts64 = uswap32(cmdMsg.mib.rxStats.pkts64);
        mib->rxStats.pkts65_127 = uswap32(cmdMsg.mib.rxStats.pkts65_127);
        mib->rxStats.pkts128_255 = uswap32(cmdMsg.mib.rxStats.pkts128_255);
        mib->rxStats.pkts256_511 = uswap32(cmdMsg.mib.rxStats.pkts256_511);
        mib->rxStats.pkts512_1023 = uswap32(cmdMsg.mib.rxStats.pkts512_1023);
        mib->rxStats.pkts1024_MAX = uswap32(cmdMsg.mib.rxStats.pkts1024_MAX);
        mib->rxStats.pkts1024_1522 = uswap32(cmdMsg.mib.rxStats.pkts1024_1522);
        mib->rxStats.pkts1523_2047 = uswap32(cmdMsg.mib.rxStats.pkts1523_2047);
        mib->rxStats.pkts2048_4095 = uswap32(cmdMsg.mib.rxStats.pkts2048_4095);
        mib->rxStats.pkts4096_8191 = uswap32(cmdMsg.mib.rxStats.pkts4096_8191);
        mib->rxStats.pkts8192_MAX = uswap32(cmdMsg.mib.rxStats.pkts8192_MAX);
        mib->rxStats.pktsJabber = uswap32(cmdMsg.mib.rxStats.pktsJabber);
        mib->rxStats.pktsOvrSz = uswap32(cmdMsg.mib.rxStats.pktsOvrSz);
        mib->rxStats.pktsFrag = uswap32(cmdMsg.mib.rxStats.pktsFrag);
        mib->rxStats.pktsRxDrop = uswap32(cmdMsg.mib.rxStats.pktsRxDrop);
        mib->rxStats.pktsCrcAlignErr = uswap32(cmdMsg.mib.rxStats.pktsCrcAlignErr);
        mib->rxStats.pktsUndSz = uswap32(cmdMsg.mib.rxStats.pktsUndSz);
        mib->rxStats.pktsCrcErr = uswap32(cmdMsg.mib.rxStats.pktsCrcErr);
        mib->rxStats.pktsRxDiscard = uswap32(cmdMsg.mib.rxStats.pktsRxDiscard);
        mib->rxStats.rxPause = uswap32(cmdMsg.mib.rxStats.rxPause);

        mib->txStats.octets = uswap32(cmdMsg.mib.txStats.octets);
        mib->txStats.brdCast = uswap32(cmdMsg.mib.txStats.brdCast);
        mib->txStats.mutCast = uswap32(cmdMsg.mib.txStats.mutCast);
        mib->txStats.uniCast = uswap32(cmdMsg.mib.txStats.uniCast);
        mib->txStats.txDropped = uswap32(cmdMsg.mib.txStats.txDropped);
        mib->txStats.txDroppedErr = uswap32(cmdMsg.mib.txStats.txDroppedErr);
        mib->txStats.txCollision = uswap32(cmdMsg.mib.txStats.txCollision);
        mib->txStats.txCollisionSingle = uswap32(cmdMsg.mib.txStats.txCollisionSingle);
        mib->txStats.txCollisionMulti = uswap32(cmdMsg.mib.txStats.txCollisionMulti);
        mib->txStats.txLateCollision = uswap32(cmdMsg.mib.txStats.txLateCollision);
        mib->txStats.txExcessiveCollision = uswap32(cmdMsg.mib.txStats.txExcessiveCollision);
        mib->txStats.txDeferredTransmit = uswap32(cmdMsg.mib.txStats.txDeferredTransmit);
        mib->txStats.txFrameInDiscard = uswap32(cmdMsg.mib.txStats.txFrameInDiscard);
        mib->txStats.txPause = uswap32(cmdMsg.mib.txStats.txPause);
        mib->txStats.txQ0 = uswap32(cmdMsg.mib.txStats.txQ0);
        mib->txStats.txQ1 = uswap32(cmdMsg.mib.txStats.txQ1);
        mib->txStats.txQ2 = uswap32(cmdMsg.mib.txStats.txQ2);
        mib->txStats.txQ3 = uswap32(cmdMsg.mib.txStats.txQ3);
        mib->txStats.txQ4 = uswap32(cmdMsg.mib.txStats.txQ4);
        mib->txStats.txQ5 = uswap32(cmdMsg.mib.txStats.txQ5);
        mib->txStats.txQ6 = uswap32(cmdMsg.mib.txStats.txQ6);
        mib->txStats.txQ7 = uswap32(cmdMsg.mib.txStats.txQ7);
        mib->txStats.pkts64 = uswap32(cmdMsg.mib.txStats.pkts64);
        mib->txStats.pkts65_127 = uswap32(cmdMsg.mib.txStats.pkts65_127);
        mib->txStats.pkts128_255 = uswap32(cmdMsg.mib.txStats.pkts128_255);
        mib->txStats.pkts256_511 = uswap32(cmdMsg.mib.txStats.pkts256_511);
        mib->txStats.pkts512_1023 = uswap32(cmdMsg.mib.txStats.pkts512_1023);
        mib->txStats.pkts1024_MAX = uswap32(cmdMsg.mib.txStats.pkts1024_MAX);
    }

done:
    return retVal;
}

int32_t HOST_EtherSwtMibClear(MgmtInfoType *info, int32_t port)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    ETHSWT_DebugMsgUnionType cmdMsg;
    RPC_ResponseType resp;

    uint32_t replyLen;
    uint32_t cmdId;

    if (info == NULL) {
        HOST_Log("%s :: Invalid input param info:%p\n", __FUNCTION__, info);
        goto done;
    }

    memset((uint8_t *)cmdMsg.data, 0, sizeof(cmdMsg));

    cmdMsg.mib.port = uswap32(port);

    cmdId = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_DBG_ID, ETHSWT_DEBUGCMDID_MIBS_CLEAR);
    retVal = HIPC_SendRecv(cmdId, (uint8_t *)cmdMsg.data,
                sizeof(ETHSWT_DebugMibType), (uint8_t *)&resp,
                sizeof(resp), &replyLen);

    if (retVal != BCM_ERR_OK) {
        goto done;
    } else if (uswap32(resp.status) != BCM_ERR_OK) {
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status));
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    } else if (replyLen != (MGMT_STATUS_LEN + sizeof(ETHSWT_DebugMibType))) {
        HOST_Log("%s len:0x%x\n", __func__, replyLen);
        retVal = BCM_ERR_DATA_INTEG;
        goto done;
    }

done:
    return retVal;
}
/*
 * @api
 * HOST_EtherSwtAgeTimeGet
 *
 * @brief
 * Get the bridge age time
 *
 * @param=info - management info
 * @param=switch age time in seconds
 *
 * @returns 0 on success, !0 on error
 */
int32_t HOST_EtherSwtAgeTimeGet(MgmtInfoType *info, uint32_t *ageTime)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;
    ETHSWT_ExtSwitchInfoType switchInfo;

    if ((info == NULL) || (ageTime == NULL)) {
        HOST_Log("%s :: Invalid input param(info =%p and ageTime = %p)\n",
                __FUNCTION__, info, ageTime);
        goto done;
    }

    retVal = HOST_EtherSwtSwitchInfoGet(info, &switchInfo);
    if (retVal == BCM_ERR_OK) {
        *ageTime = switchInfo.ageTime;
    }

done:
    return retVal;
}

/*
 * @api
 * HOST_EtherSwtDumbFwdModeGet
 *
 * @brief
 * Get the dumbfwd mode
 *
 * @param=info - management info
 * @param=dumbFwdMode - to get the information
 *
 * @returns 0 on success, !0 on error
 */
int32_t HOST_EtherSwtDumbFwdModeGet(MgmtInfoType *info, ETHSWT_DumbFwdModeType *dumbFwdMode)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;
    ETHSWT_ExtSwitchInfoType switchInfo;

    if ((info == NULL) || (dumbFwdMode == NULL)) {
        HOST_Log("%s :: Invalid input parameters(info=%p and dumbFwdMode=%p \n",
                __FUNCTION__, info, dumbFwdMode);
        goto done;
    }

    retVal = HOST_EtherSwtSwitchInfoGet(info, &switchInfo);
    if (retVal == BCM_ERR_OK) {
        *dumbFwdMode = switchInfo.dumbFwdMode;
    }

done:
    return retVal;
}

/*
 * @api
 * HOST_EtherSwtMgmtModeGet
 *
 * @brief
 * Get the management mode
 *
 * @param=info - management info
 * @param=mgmtMode - to get the information
 *
 * @returns 0 on success, !0 on error
 */
int32_t HOST_EtherSwtMgmtModeGet(MgmtInfoType *info, ETHSWT_MgmtModeType *mgmtMode)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;
    ETHSWT_ExtSwitchInfoType switchInfo;

    if ((info == NULL) || (mgmtMode == NULL)) {
        HOST_Log("%s :: Invalid input parameters(info=%p and mgmtMode=%p \n",
                __FUNCTION__, info, mgmtMode);
        goto done;
    }

    retVal = HOST_EtherSwtSwitchInfoGet(info, &switchInfo);
    if (retVal == BCM_ERR_OK) {
        *mgmtMode = switchInfo.mgmtMode;
    }

done:
    return retVal;
}

/*
 * @api
 * HOST_EtherSwtBrcmHdrModeGet
 *
 * @brief
 * Get the brcmhdr mode
 *
 * @param=info - management info
 * @param=brcmHdrMode - to get the information
 *
 * @returns 0 on success, !0 on error
 */
int32_t HOST_EtherSwtBrcmHdrModeGet(MgmtInfoType *info, ETHSWT_BrcmHdrModeType *brcmHdrMode)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;
    ETHSWT_ExtSwitchInfoType switchInfo;

    if ((info == NULL) || (brcmHdrMode == NULL)) {
        HOST_Log("%s :: Invalid input parameters(info=%p and brcmHdrMode=%p \n",
                __FUNCTION__, info, brcmHdrMode);
        goto done;
    }

    retVal = HOST_EtherSwtSwitchInfoGet(info, &switchInfo);
    if (retVal == BCM_ERR_OK) {
        *brcmHdrMode = switchInfo.brcmHdrMode;
    }

done:
    return retVal;
}

/*
 * @api
 * HOST_EtherSwtMirrorEnable
 *
 * @brief
 * Enable mirroring
 *
 * @param=info - management info
 * @param=portMask - port bitmap
 * @param=probePort - probe port
 * @param=direction - traffic direction
 * @param=packetDivider - No.of frames to be mirrored
 *
 * @returns 0 on success, !0 on error
 */
int32_t HOST_EtherSwtMirrorEnable(MgmtInfoType *info, uint16_t portMask,
                                uint32_t probePort,
                                ETHSWT_TrafficDirType direction,
                                uint16_t packetDivider)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;
    ETHSWT_DebugMsgUnionType cmdMsg;
    RPC_ResponseType resp;

    uint32_t replyLen;
    uint32_t cmdId;

    if (info == NULL) {
        HOST_Log("%s :: MgmtInfoType pointer is NULL\n", __FUNCTION__);
        goto done;
    }

    if ((direction != ETHSWT_TRAFFICDIR_INGRESS)
            && (direction != ETHSWT_TRAFFICDIR_EGRESS)) {
        HOST_Log("%s :: Invalid mirroring direction %d\n", __FUNCTION__, direction);
        goto done;
    }

    /* make sure the port bitmap is non-zero and
       don't allow the probe port in the port bitmap
     */
    if (((portMask == 0x0) && (FALSE == HIPC_IsStacked()))
            || ((portMask & (1 << probePort)) != 0x0)) {
        HOST_Log("Invalid port bitmap or conflicting probe port\n");
        goto done;
    }

    memset((uint8_t *)cmdMsg.data, 0, sizeof(cmdMsg));

    cmdMsg.mirrorEnable.probePort = uswap32(probePort);
    cmdMsg.mirrorEnable.mirrorCfg.portMask = uswap16(portMask);
    cmdMsg.mirrorEnable.direction = direction;
    cmdMsg.mirrorEnable.mirrorCfg.packetDivider = uswap16(packetDivider);

    cmdId = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_DBG_ID, ETHSWT_DEBUGCMDID_MIRROR_ENABLE);
    retVal = HIPC_SendRecv(cmdId, (uint8_t *)cmdMsg.data,
            sizeof(ETHSWT_DebugMirrorEnableType),
            (uint8_t *)&resp, sizeof(resp), &replyLen);
    if (retVal != BCM_ERR_OK) {
        goto done;
    } else if (uswap32(resp.status) != BCM_ERR_OK) {
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status));
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    } else if (replyLen != (MGMT_STATUS_LEN + sizeof(ETHSWT_DebugMirrorEnableType))) {
        HOST_Log("%s len:0x%x\n", __func__, replyLen);
        retVal = BCM_ERR_DATA_INTEG;
        goto done;
    }
done:
    return retVal;
}

/*
 * @api
 * HOST_EtherSwtMirrorDisable
 *
 * @brief
 * Disable mirroring
 *
 * @param=info - management info
 *
 * @returns 0 on success, !0 on error
 */
int32_t HOST_EtherSwtMirrorDisable(MgmtInfoType *info)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;
    ETHSWT_DebugMsgUnionType cmdMsg;
    RPC_ResponseType resp;

    uint32_t replyLen;
    uint32_t cmdId;

    if (info == NULL) {
        HOST_Log("%s :: MgmtInfoType pointer is NULL\n", __FUNCTION__);
        goto done;
    }

    memset((uint8_t *)cmdMsg.data, 0, sizeof(cmdMsg));

    cmdId = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_DBG_ID, ETHSWT_DEBUGCMDID_MIRROR_DISABLE);
    retVal = HIPC_SendRecv(cmdId, (uint8_t *)cmdMsg.data,
            0UL, (uint8_t *)&resp, sizeof(resp), &replyLen);

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
done:
    return retVal;
}

/*
 * @api
 * HOST_EtherSwtMirrorStatus
 *
 * @brief
 * Get the status of mirroring
 *
 * @param=info - management info
 * @param=mode -     enabled or disabled
 * @param=portMask- bitmap of ports to mirror
 * @param=probePort  -   probe port
 *
 * @returns 0 on success, !0 on error
 */
int32_t HOST_EtherSwtMirrorStatus(MgmtInfoType *info, ETHSWT_PortMirrorStateType *state,
        uint16_t *ingressPortMask, uint16_t *egressPortMask, uint32_t *probePort)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;
    ETHSWT_DebugMsgUnionType cmdMsg;
    RPC_ResponseType resp;

    uint32_t replyLen;
    uint32_t cmdId;

    if (info == NULL) {
        HOST_Log("%s :: MgmtInfoType pointer is NULL\n", __FUNCTION__);
        goto done;
    }

    memset((uint8_t *)cmdMsg.data, 0, sizeof(cmdMsg));

    cmdId = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_DBG_ID, ETHSWT_DEBUGCMDID_MIRROR_STATUS);
    retVal = HIPC_SendRecv(cmdId, (uint8_t *)cmdMsg.data,
            sizeof(ETHSWT_DebugMirrorStatusType),
            (uint8_t *)&resp, sizeof(resp), &replyLen);
    if (retVal != BCM_ERR_OK) {
        goto done;
    } else if (uswap32(resp.status) != BCM_ERR_OK) {
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status));
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    } else if (replyLen != (MGMT_STATUS_LEN + sizeof(ETHSWT_DebugMirrorStatusType))) {
        HOST_Log("%s len:0x%x\n", __func__, replyLen);
        retVal = BCM_ERR_DATA_INTEG;
        goto done;
    } else  {
        memcpy((uint8_t *)&cmdMsg, &resp.payload[0], sizeof(ETHSWT_DebugMirrorStatusType));
        *state = uswap32(cmdMsg.mirrorStatus.state);
        *ingressPortMask = uswap16(cmdMsg.mirrorStatus.ingressMirrorCfg.portMask);
        *egressPortMask = uswap16(cmdMsg.mirrorStatus.egressMirrorCfg.portMask);
        *probePort = uswap32(cmdMsg.mirrorStatus.probePort);
    }
done:
    return retVal;
}

/*
 * @api
 * HOST_EtherSwtAgeTimeSet
 *
 * @brief
 * Set the bridge age time
 *
 * @param=info - management info
 * @param=switch age time in seconds
 *
 * @returns 0 on success, !0 on error
 */
int32_t HOST_EtherSwtAgeTimeSet(MgmtInfoType *info, uint32_t ageTime)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;
    ETHSWT_ExtSwitchInfoType switchInfo;

    if (info == NULL) {
        HOST_Log("%s :: MgmtInfoType pointer is NULL\n", __FUNCTION__);
        goto done;
    }

    retVal = HOST_EtherSwtSwitchInfoGet(info, &switchInfo);
    if (BCM_ERR_OK == retVal) {
        switchInfo.ageTime = ageTime;
        retVal = HOST_EtherSwtSwitchInfoSet(info, &switchInfo);
    }

done:
    return retVal;
}

int32_t HOST_EtherSwtSwitchInfoGet(MgmtInfoType *info, ETHSWT_ExtSwitchInfoType *switchInfo)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;
    ETHSWT_ExtMsgUnionType cmdMsg;
    RPC_ResponseType resp;

    uint32_t replyLen;
    uint32_t cmdId;

    if ((info == NULL) || (switchInfo == NULL)) {
        HOST_Log("%s :: Invalid input parameter(info = %p and switchInfo = %p)\n",
                __FUNCTION__, info, switchInfo);
        goto done;
    }

    memset((uint8_t *)cmdMsg.data, 0, sizeof(cmdMsg));

    cmdId = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_SWT_ID, ETHSWT_EXTCMDID_SWITCH_INFO_GET);
    retVal = HIPC_SendRecv(cmdId, (uint8_t *)cmdMsg.data,
            sizeof(ETHSWT_ExtSwitchInfoType),
            (uint8_t *)&resp, sizeof(resp), &replyLen);
    if (retVal != BCM_ERR_OK) {
        goto done;
    } else if (uswap32(resp.status) != BCM_ERR_OK) {
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status));
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    } else if (replyLen != (MGMT_STATUS_LEN + sizeof(ETHSWT_ExtSwitchInfoType))) {
        HOST_Log("%s len:0x%x\n", __func__, replyLen);
        retVal = BCM_ERR_DATA_INTEG;
        goto done;
    } else {
        memcpy((uint8_t *)&cmdMsg, &resp.payload[0], sizeof(ETHSWT_ExtSwitchInfoType));
        switchInfo->ageTime = uswap32(cmdMsg.switchInfo.ageTime);
        switchInfo->dumbFwdMode = uswap32(cmdMsg.switchInfo.dumbFwdMode);
        switchInfo->brcmHdrMode = uswap32(cmdMsg.switchInfo.brcmHdrMode);
        switchInfo->mgmtMode = uswap32(cmdMsg.switchInfo.mgmtMode);
        switchInfo->iFilter = uswap32(cmdMsg.switchInfo.iFilter);
    }

done:
    return retVal;
}

int32_t HOST_EtherSwtSwitchInfoSet(MgmtInfoType *info, ETHSWT_ExtSwitchInfoType *switchInfo)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;
    ETHSWT_ExtMsgUnionType cmdMsg;
    RPC_ResponseType resp;

    uint32_t replyLen;
    uint32_t cmdId;

    if ((info == NULL) || (switchInfo == NULL)) {
        HOST_Log("%s :: Invalid input parameter(info = %p and switchInfo = %p)\n",
                __FUNCTION__, info, switchInfo);
        goto done;
    }

    memset((uint8_t *)cmdMsg.data, 0, sizeof(cmdMsg));
    cmdMsg.switchInfo.ageTime = uswap32(switchInfo->ageTime);
    cmdMsg.switchInfo.dumbFwdMode = uswap32(switchInfo->dumbFwdMode);
    cmdMsg.switchInfo.brcmHdrMode = uswap32(switchInfo->brcmHdrMode);
    cmdMsg.switchInfo.mgmtMode = uswap32(switchInfo->mgmtMode);
    cmdMsg.switchInfo.iFilter = uswap32(switchInfo->iFilter);

    cmdId = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_SWT_ID, ETHSWT_EXTCMDID_SWITCH_INFO_SET);
    retVal = HIPC_SendRecv(cmdId, (uint8_t *)cmdMsg.data,
            sizeof(ETHSWT_ExtSwitchInfoType),
            (uint8_t *)&resp, sizeof(resp), &replyLen);
    if (retVal != BCM_ERR_OK) {
        goto done;
    } else if (uswap32(resp.status) != BCM_ERR_OK) {
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status));
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    } else if (replyLen != (MGMT_STATUS_LEN + sizeof(ETHSWT_ExtSwitchInfoType))) {
        HOST_Log("%s len:0x%x\n", __func__, replyLen);
        retVal = BCM_ERR_DATA_INTEG;
        goto done;
    }

done:
    return retVal;
}

/*
 * @api
 * HOST_EtherSwtPortInfoGet
 *
 * @brief
 * Get the port information
 *
 * @param=info - management info
 * @param=port - port to get the information
 * @param=portInfo - structure to fill port information
 *
 * @returns 0 on success, !0 on error
 */
int32_t HOST_EtherSwtPortInfoGet(MgmtInfoType *info, uint32_t port, ETHSWT_ExtPortInfoType *portInfo)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;
    ETHSWT_ExtMsgUnionType cmdMsg;
    RPC_ResponseType resp;
    uint32_t replyLen;
    uint32_t cmdId;

    if ((info == NULL) || (portInfo == NULL)) {
        HOST_Log("%s :: Invalid input parameter(info = %p and portInfo = %p)\n",
                __FUNCTION__, info, portInfo);
        goto done;
    }

    memset((uint8_t *)cmdMsg.data, 0, sizeof(cmdMsg));

    cmdMsg.portInfo.port = uswap32(port);

    cmdId = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_SWT_ID, ETHSWT_EXTCMDID_PORT_INFO_GET);
    retVal = HIPC_SendRecv(cmdId, (uint8_t *)cmdMsg.data,
            sizeof(ETHSWT_ExtPortInfoType),
            (uint8_t *)&resp, sizeof(resp), &replyLen);
    if (retVal != BCM_ERR_OK) {
        goto done;
    } else if (uswap32(resp.status) != BCM_ERR_OK) {
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status));
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    } else if (replyLen != (MGMT_STATUS_LEN + sizeof(ETHSWT_ExtPortInfoType))) {
        HOST_Log("%s len:0x%x\n", __func__, replyLen);
        retVal = BCM_ERR_DATA_INTEG;
        goto done;
    } else {
        memcpy((uint8_t *)&cmdMsg, &resp.payload[0], sizeof(ETHSWT_ExtPortInfoType));
        portInfo->port = uswap32(cmdMsg.portInfo.port);
        portInfo->adminMode = cmdMsg.portInfo.adminMode;
        portInfo->linkStatus = cmdMsg.portInfo.linkStatus;
        portInfo->speed = cmdMsg.portInfo.speed;
        portInfo->masterEnable = cmdMsg.portInfo.masterEnable;
        portInfo->jumboEnable = cmdMsg.portInfo.jumboEnable;
        portInfo->loopbackEnable = cmdMsg.portInfo.loopbackEnable;
        portInfo->autonegEnable = cmdMsg.portInfo.autonegEnable;
        portInfo->autonegComplete = cmdMsg.portInfo.autonegComplete;
        portInfo->duplex= cmdMsg.portInfo.duplex;
        portInfo->led = uswap32(cmdMsg.portInfo.led);
        portInfo->linkStateChangeCnt = uswap32(cmdMsg.portInfo.linkStateChangeCnt);
        portInfo->busMode = cmdMsg.portInfo.busMode;
        portInfo->phyMedia = cmdMsg.portInfo.phyMedia;
        portInfo->linkSQI = uswap32(cmdMsg.portInfo.linkSQI);
        portInfo->pvid = uswap32(cmdMsg.portInfo.pvid);
        portInfo->prio = uswap32(cmdMsg.portInfo.prio);
    }

done:
    return retVal;
}


/*
 * @api
 * HOST_EtherSwtPortInfoSet
 *
 * @brief
 * Get the port information
 *
 * @param=info - management info
 * @param=portInfo - structure with port information
 *
 * @returns 0 on success, !0 on error
 */
int32_t HOST_EtherSwtPortInfoSet(MgmtInfoType *info, ETHSWT_ExtPortInfoType *portInfo)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;
    ETHSWT_ExtMsgUnionType cmdMsg;
    RPC_ResponseType resp;

    uint32_t replyLen;
    uint32_t cmdId;

    if ((info == NULL) || (portInfo == NULL)) {
        HOST_Log("%s :: Invalid input parameter(info = %p and portInfo = %p)\n",
                __FUNCTION__, info, portInfo);
        goto done;
    }
    memset((uint8_t *)cmdMsg.data, 0, sizeof(cmdMsg));

    cmdMsg.portInfo.port = uswap32(portInfo->port);
    cmdMsg.portInfo.adminMode = portInfo->adminMode;
    cmdMsg.portInfo.linkStatus = portInfo->linkStatus;
    cmdMsg.portInfo.speed = portInfo->speed;
    cmdMsg.portInfo.masterEnable = portInfo->masterEnable;
    cmdMsg.portInfo.jumboEnable = portInfo->jumboEnable;
    cmdMsg.portInfo.loopbackEnable = portInfo->loopbackEnable;
    cmdMsg.portInfo.autonegEnable = portInfo->autonegEnable;
    cmdMsg.portInfo.autonegComplete = portInfo->autonegComplete;
    cmdMsg.portInfo.duplex= portInfo->duplex;
    cmdMsg.portInfo.led = uswap32(portInfo->led);
    cmdMsg.portInfo.linkStateChangeCnt = uswap32 (portInfo->linkStateChangeCnt);
    cmdMsg.portInfo.busMode = portInfo->busMode;
    cmdMsg.portInfo.phyMedia = portInfo->phyMedia;
    cmdMsg.portInfo.linkSQI = uswap32(portInfo->linkSQI);
    cmdMsg.portInfo.pvid = uswap32(portInfo->pvid);
    cmdMsg.portInfo.prio = uswap32(portInfo->prio);

    cmdId = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_SWT_ID, ETHSWT_EXTCMDID_PORT_INFO_SET);
    retVal = HIPC_SendRecv(cmdId, (uint8_t *)cmdMsg.data,
            sizeof(ETHSWT_ExtPortInfoType),
            (uint8_t *)&resp, sizeof(resp), &replyLen);
    if (retVal != BCM_ERR_OK) {
        goto done;
    } else if (uswap32(resp.status) != BCM_ERR_OK) {
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status));
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    } else if (replyLen != (MGMT_STATUS_LEN + sizeof(ETHSWT_ExtPortInfoType))) {
        HOST_Log("%s len:0x%x\n", __func__, replyLen);
        retVal = BCM_ERR_DATA_INTEG;
        goto done;
    }

done:
    return retVal;
}

int32_t HOST_EtherSwtRegRead(MgmtInfoType *info, MCU_DeviceType destn, uint32_t addr,
                             uint32_t len, uint64_t *data)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;
    ETHSWT_ExtMsgUnionType cmdMsg;
    RPC_ResponseType resp;

    uint32_t replyLen;
    uint32_t cmdId;
    int i;

    if ((info == NULL) || (len > 16UL)) {
        HOST_Log("%s :: Invalid input parameter(info = %p and len = %u)\n",
                __FUNCTION__, info, len);
        goto done;
    }

    memset((uint8_t *)cmdMsg.data, 0, sizeof(cmdMsg));

    cmdMsg.regAccess.addr = uswap32(addr);
    cmdMsg.regAccess.len = uswap32(len);
    cmdMsg.regAccess.deviceID = uswap32(destn);

    cmdId = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_CRE_ID, ETHSWT_CORECMDID_READ);
    retVal = HIPC_SendRecv(cmdId, (uint8_t *)cmdMsg.data,
            sizeof(ETHSWT_CoreRegAccessType),
            (uint8_t *)&resp, sizeof(resp), &replyLen);
    if (retVal != BCM_ERR_OK) {
        goto done;
    } else if (uswap32(resp.status) != BCM_ERR_OK) {
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status));
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    } else if (replyLen != (MGMT_STATUS_LEN + sizeof(ETHSWT_CoreRegAccessType))) {
        HOST_Log("%s len:0x%x\n", __func__, replyLen);
        retVal = BCM_ERR_DATA_INTEG;
        goto done;
    } else {
        memcpy((uint8_t *)&cmdMsg, &resp.payload[0], sizeof(ETHSWT_CoreRegAccessType));
        for(i = 0; i < len; i++) {
           data[i] = uswap64(*(uint64_t *)&cmdMsg.regAccess.data[i*8]);
        }
    }

done:
    return retVal;
}

int32_t HOST_EtherSwtRegWrite(MgmtInfoType *info, MCU_DeviceType destn, uint32_t addr,
                              uint32_t len, uint64_t *data)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;
    ETHSWT_ExtMsgUnionType cmdMsg;
    RPC_ResponseType resp;

    uint32_t replyLen;
    uint32_t cmdId;
    int i;

    if ((info == NULL) || (len > 16UL)) {
        HOST_Log("%s :: Invalid input parameter(info = %p and len = %u)\n",
                __FUNCTION__, info, len);
        goto done;
    }

    memset((uint8_t *)cmdMsg.data, 0, sizeof(cmdMsg));

    cmdMsg.regAccess.addr = uswap32(addr);
    cmdMsg.regAccess.len = uswap32(len);
    cmdMsg.regAccess.deviceID = uswap32(destn);

    for(i = 0; i < len; i++) {
        *(uint64_t *)&cmdMsg.regAccess.data[i*8] = uswap64(data[i]);
    }

    cmdId = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_CRE_ID, ETHSWT_CORECMDID_WRITE);
    retVal = HIPC_SendRecv(cmdId, (uint8_t *)cmdMsg.data,
            sizeof(ETHSWT_CoreRegAccessType),
            (uint8_t *)&resp, sizeof(resp), &replyLen);
    if (retVal != BCM_ERR_OK) {
        goto done;
    } else if (uswap32(resp.status) != BCM_ERR_OK) {
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status));
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    } else if (replyLen != (MGMT_STATUS_LEN + sizeof(ETHSWT_CoreRegAccessType))) {
        HOST_Log("%s len:0x%x\n", __func__, replyLen);
        retVal = BCM_ERR_DATA_INTEG;
        goto done;
    }

done:
    return retVal;
}

/*
 * @api
 * HOST_EtherSwtVlanGet
 *
 * @brief
 * Get the VLAN info
 *
 * @param=info - management info
 * @param=vlan - vlan id
 * @param=portMask - VLAN port membership
 * @param=tagMask - tagged bitmap
 *
 * @returns 0 on success, !0 on error
 */
int32_t HOST_EtherSwtVlanGet(MgmtInfoType *info, uint16_t vlan, uint32_t *portMask,
        uint32_t *tagMask, uint32_t *staticPortMask)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    ETHSWT_VLANMsgUnionType cmdMsg;
    RPC_ResponseType resp;
    uint32_t replyLen;
    uint32_t cmdId;

    if ((info == NULL) || (tagMask == NULL) || (portMask == NULL)
            || (staticPortMask == NULL)) {
        HOST_Log("%s :: Invalid input param(info = %p, tagMask = %p, "
                "portMask = %p, staticPortMask = %p)\n",
                __FUNCTION__, info, tagMask, portMask, staticPortMask);
        goto done;
    }

    memset((uint8_t *)cmdMsg.data, 0, sizeof(ETHSWT_VLANMsgUnionType));

    cmdMsg.vlanPort.vlan = uswap16(vlan);

    cmdId = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_VLN_ID, ETHSWT_VLANCMDID_GET);
    retVal = HIPC_SendRecv(cmdId, (uint8_t*)(uint8_t *)cmdMsg.data,
            sizeof(ETHSWT_VLANPortType),
            (uint8_t *)&resp, sizeof(resp), &replyLen);
    if (retVal != BCM_ERR_OK) {
        goto done;
    } else if (uswap32(resp.status) != BCM_ERR_OK) {
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status));
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    } else if (replyLen != (MGMT_STATUS_LEN + sizeof(ETHSWT_VLANPortType))) {
        HOST_Log("%s len:0x%x\n", __func__, replyLen);
        retVal = BCM_ERR_DATA_INTEG;
        goto done;
    } else {
        memcpy((uint8_t *)&cmdMsg, &resp.payload[0], sizeof(ETHSWT_VLANPortType));
        *portMask = uswap32(cmdMsg.vlanPort.portMask);
        *tagMask = uswap32(cmdMsg.vlanPort.tagMask);
        *staticPortMask = uswap32(cmdMsg.vlanPort.staticPortMask);
    }
done:
    return retVal;
}


/*
 * @api
 * HOST_EtherSwtVlanPortAdd
 *
 * @brief
 * Add the given port to the given VLAN, and enable/disable tagging on it
 *
 * @param=info - management info
 * @param=vlan - vlan id
 * @param=portMask - port bitmask to add
 * @param=tagMask - tagged port bitMask
 *
 * @returns 0 on success, !0 on error
 */
int32_t HOST_EtherSwtVlanPortAdd(MgmtInfoType *info, uint16_t vlan, uint32_t portMask, uint32_t tagMask)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;
    ETHSWT_VLANMsgUnionType cmdMsg;
    RPC_ResponseType resp;

    uint32_t replyLen;
    uint32_t cmdId;

    if (info == NULL) {
        HOST_Log("%s :: MgmtInfoType pointer is NULL\n", __FUNCTION__);
        goto done;
    }

    memset((uint8_t *)cmdMsg.data, 0, sizeof(ETHSWT_VLANMsgUnionType));

    cmdId = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_VLN_ID, ETHSWT_VLANCMDID_PORT_ADD);
    cmdMsg.vlanPort.vlan = uswap16(vlan);
    cmdMsg.vlanPort.portMask = uswap32(portMask);
    cmdMsg.vlanPort.tagMask = uswap32(tagMask);

    retVal = HIPC_SendRecv(cmdId, (uint8_t*)(uint8_t *)cmdMsg.data,
             sizeof(ETHSWT_VLANPortType),
             (uint8_t *)&resp, sizeof(resp), &replyLen);
    if (retVal != BCM_ERR_OK) {
        goto done;
    } else if (uswap32(resp.status) != BCM_ERR_OK) {
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status));
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    } else if (replyLen != (MGMT_STATUS_LEN + sizeof(ETHSWT_VLANPortType))) {
        HOST_Log("%s len:0x%x\n", __func__, replyLen);
        retVal = BCM_ERR_DATA_INTEG;
        goto done;
    }
done:
    return retVal;
}

/*
 * @api
 * HOST_EtherSwtVlanPortDel
 *
 * @brief
 * Delete the given port from the given VLAN
 *
 * @param=info - management info
 * @param=vlan - vlan id to create
 * @param=portMask - portMask to remove
 *
 * @returns 0 on success, !0 on error
 */
int32_t HOST_EtherSwtVlanPortDel(MgmtInfoType *info, uint16_t vlan, uint32_t portMask)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;
    ETHSWT_VLANMsgUnionType cmdMsg;
    RPC_ResponseType resp;

    uint32_t replyLen;
    uint32_t cmdId;

    if (info == NULL) {
        HOST_Log("%s :: MgmtInfoType pointer is NULL\n", __FUNCTION__);
        goto done;
    }

    memset((uint8_t *)cmdMsg.data, 0, sizeof(ETHSWT_VLANMsgUnionType));

    cmdId = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_VLN_ID, ETHSWT_VLANCMDID_PORT_REMOVE);
    cmdMsg.vlanPort.vlan = uswap16(vlan);
    cmdMsg.vlanPort.portMask = uswap32(portMask);

    retVal = HIPC_SendRecv(cmdId, (uint8_t*)(uint8_t *)cmdMsg.data,
             sizeof(ETHSWT_VLANPortType),
             (uint8_t *)&resp, sizeof(resp), &replyLen);
    if (retVal != BCM_ERR_OK) {
        goto done;
    } else if (uswap32(resp.status) != BCM_ERR_OK) {
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status));
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    } else if (replyLen != (MGMT_STATUS_LEN + sizeof(ETHSWT_VLANPortType))) {
        HOST_Log("%s len:0x%x\n", __func__, replyLen);
        retVal = BCM_ERR_DATA_INTEG;
        goto done;
    }
done:
    return retVal;
}

/*
 * @api
 * HOST_EtherSwtVlanPvidSet
 *
 * @brief
 * Configure the untagged VLAN for the given port.
 *
 * @param=info - management info
 * @param=port - port number
 * @param=pvid - pvid
 * @param=prio - priority
 *
 * @returns 0 on success, !0 on error
 */
int32_t HOST_EtherSwtVlanPvidSet(MgmtInfoType *info, uint32_t port, uint32_t pvid, uint32_t prio)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;
    ETHSWT_ExtPortInfoType portInfo;

    if (info == NULL) {
        HOST_Log("%s :: MgmtInfoType pointer is NULL\n", __FUNCTION__);
        goto done;
    }

    retVal = HOST_EtherSwtPortInfoGet(info, port, &portInfo);
    if (retVal == BCM_ERR_OK) {
        portInfo.pvid = pvid;
        portInfo.prio = prio;
        retVal = HOST_EtherSwtPortInfoSet(info, &portInfo);
    }
done:
    return retVal;
}

/*
 * @api
 * HOST_EtherSwtVlanIfilterSet
 *
 * @brief
 * Enable/Disbale VLAN ingress filtering mode for all ports
 *
 * @param=info - management info
 * @param=iFilter - iFilter mode
 *
 * @returns 0 on success, !0 on error
 */
int32_t HOST_EtherSwtVlanIfilterSet(MgmtInfoType *info, ETHSWT_VLANIngressFilterModeType iFilter)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;
    ETHSWT_ExtSwitchInfoType switchInfo;

    if (info == NULL) {
        HOST_Log("%s :: MgmtInfoType pointer is NULL\n", __FUNCTION__);
        goto done;
    }
    if ((iFilter != ETHSWT_VLAN_INGRESS_FILTER_MODE_ENABLED) &&
            (iFilter != ETHSWT_VLAN_INGRESS_FILTER_MODE_DISABLED)) {
        HOST_Log("Invalid mode for ingress filtering %d\n", iFilter);
        goto done;
    }

    retVal = HOST_EtherSwtSwitchInfoGet(info, &switchInfo);
    if (BCM_ERR_OK == retVal) {
        switchInfo.iFilter = iFilter;
        retVal = HOST_EtherSwtSwitchInfoSet(info, &switchInfo);
    }

done:
    return retVal;
}

/*
 * @api
 * HOST_EtherSwtVlanIfilterGet
 *
 * @brief
 * Get VLAN ingress filtering mode for all ports
 *
 * @param=info - management info
 * @param=iFilter - iFilter mode
 *
 * @returns 0 on success, !0 on error
 */
int32_t HOST_EtherSwtVlanIfilterGet(MgmtInfoType *info, ETHSWT_VLANIngressFilterModeType *iFilter)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;
    ETHSWT_ExtSwitchInfoType switchInfo;

    if ((info == NULL) || (iFilter == NULL)){
        HOST_Log("%s: Invalid parameters info:%p iFilter:%p\n", __FUNCTION__, info, iFilter);
        goto done;
    }

    retVal = HOST_EtherSwtSwitchInfoGet(info, &switchInfo);
    if (retVal == BCM_ERR_OK) {
        *iFilter = switchInfo.iFilter;
    }

done:
    return retVal;
}

/*@api
 * HOST_EtherSwtConvertMac
 *
 * @brief
 * Print the contents of a buffer to stdout. For debugging.
 *
 * @param=mac_addr - pointer to mac address string
 * @param=data - pointer to the mac address hex
 * @param=status - status of the operation
 *
 * @returns void
 *
 * @desc
 */
void HOST_EtherSwtConvertMac(char *mac_addr, unsigned char *mac_hex, int32_t *status)
{
    uint8_t i;
    uint32_t octet;
    char *ptr = mac_addr;

    *status = BCM_ERR_INVAL_PARAMS;

    if (ptr == NULL) {
        HOST_Log("%s :: mac_addr ptr is null\n", __FUNCTION__);
        return ;
    }

    if (mac_hex == NULL) {
        HOST_Log("%s :: mac_hex ptr is null\n", __FUNCTION__);
        return ;
    }

    if (strlen(mac_addr) != 17) {
        HOST_Log("Macaddr length mismatch, should be of the format xx:xx:xx:xx:xx:xx\n");
        return;
    }

    for (i = 0; i < 17; i++) {
        if ((i % 3) == 2) {
            if (mac_addr[i] != ':') {
                HOST_Log("Invalid characters in macaddr input\n");
                return;
            }
        } else {
            if ((mac_addr[i] < '0')
                    || ((mac_addr[i] > '9') && (mac_addr[i] < 'A'))
                    || ((mac_addr[i] > 'F') && (mac_addr[i] < 'a'))
                    || (mac_addr[i] > 'f')) {
                HOST_Log("Invalid characters in macaddr input\n");
                return;
            }
        }
    }

    for (i = 0; i < MGMT_ETHER_ADDR_LEN; ++i) {
        if (!i) {
            octet = strtol(mac_addr, &ptr, 16);
        } else {
            octet = strtol(ptr+1, &ptr, 16);
        }

        if (i == (MGMT_ETHER_ADDR_LEN - 1)) {
            if ((*ptr != '\0') || (octet > 255)) {
                HOST_Log("%s :: Invalid mac address format\n", __FUNCTION__);
                return;
            }
        } else {
            if ((*ptr != ':') || (octet > 255)) {
                HOST_Log("%s :: Invalid macaddress\n", __FUNCTION__);
                return;
            }
        }

        mac_hex[i] = octet;
    }

    if ((mac_hex[0] == 0) && (mac_hex[1] == 0) && (mac_hex[2] == 0) &&
            (mac_hex[3] == 0) && (mac_hex[4] == 0) && (mac_hex[5] == 0)) {
        HOST_Log("\nInvalid MAC address\n");
        return;   /* Invalid mac address */
    }

    if ((mac_hex[0] == 0xff) && (mac_hex[1] == 0xff) && (mac_hex[2] == 0xff) &&
            (mac_hex[3] == 0xff) && (mac_hex[4] == 0xff) && (mac_hex[5] == 0xff)) {
        HOST_Log("\nBroadcast MAC address\n");
        return;   /* Broad cast mac address */
    }

    *status = BCM_ERR_OK;
}

int32_t HOST_EtherSwtARLAdd(MgmtInfoType *info, uint8_t *mac_addr, uint16_t vlan, uint32_t portMask)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    ETHSWT_ARLMsgUnionType cmdMsg;
    RPC_ResponseType resp;

    uint32_t replyLen;
    uint32_t cmdId;

    if (info == NULL) {
        HOST_Log("%s :: MgmtInfoType pointer is NULL\n", __FUNCTION__);
        goto done;
    }

    memset(&cmdMsg, 0, sizeof(ETHSWT_ARLMsgUnionType));

    cmdId = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_ARL_ID, ETHSWT_ARLCMDID_ADD);
    cmdMsg.arlEntry.vlanID = uswap16(vlan);
    cmdMsg.arlEntry.portMask = uswap32(portMask);
    memcpy(&cmdMsg.arlEntry.macAddr[0], mac_addr, 6UL);

    retVal = HIPC_SendRecv(cmdId, (uint8_t *)&cmdMsg,
             sizeof(ETHSWT_ARLEntryType),
             (uint8_t *)&resp, sizeof(resp), &replyLen);

    if (retVal != BCM_ERR_OK) {
        goto done;
    } else if (uswap32(resp.status) != BCM_ERR_OK) {
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status));
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    } else if (replyLen != (MGMT_STATUS_LEN + sizeof(ETHSWT_ARLEntryType))) {
        HOST_Log("%s len:0x%x\n", __func__, replyLen);
        retVal = BCM_ERR_DATA_INTEG;
        goto done;
    }

done:
    return retVal;
}

int32_t HOST_EtherSwtARLDelete(MgmtInfoType *info, uint8_t *mac_addr, uint16_t vlan)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    ETHSWT_ARLMsgUnionType cmdMsg;
    RPC_ResponseType resp;

    uint32_t replyLen;
    uint32_t cmdId;

    if (info == NULL) {
        HOST_Log("%s :: MgmtInfoType pointer is NULL\n", __FUNCTION__);
        goto done;
    }

    cmdId = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_ARL_ID, ETHSWT_ARLCMDID_DELETE);
    cmdMsg.arlEntry.vlanID = uswap16(vlan);
    memcpy(&cmdMsg.arlEntry.macAddr[0], mac_addr, 6UL);

    retVal = HIPC_SendRecv(cmdId, (uint8_t *)&cmdMsg,
             sizeof(ETHSWT_ARLEntryType),
             (uint8_t *)&resp, sizeof(resp), &replyLen);
    if (retVal != BCM_ERR_OK) {
        goto done;
    } else if (uswap32(resp.status) != BCM_ERR_OK) {
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status));
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    } else if (replyLen != (MGMT_STATUS_LEN + sizeof(ETHSWT_ARLEntryType))) {
        HOST_Log("%s len:0x%x\n", __func__, replyLen);
        retVal = BCM_ERR_DATA_INTEG;
        goto done;
    }

done:
    return retVal;
}

int32_t HOST_EtherSwtARLSnapshot(MgmtInfoType *info, uint32_t *count)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    ETHSWT_ARLMsgUnionType cmdMsg;
    RPC_ResponseType resp;

    uint32_t replyLen;
    uint32_t cmdId;

    if (info == NULL){
        HOST_Log("%s :: MgmtInfoType pointer is NULL\n", __FUNCTION__);
        goto done;
    }

    cmdId = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_ARL_ID, ETHSWT_ARLCMDID_SNAPSHOT);

    retVal = HIPC_SendRecv(cmdId, (uint8_t *)&cmdMsg,
             sizeof(ETHSWT_ARLListType),
             (uint8_t *)&resp, sizeof(resp), &replyLen);
    if (retVal != BCM_ERR_OK) {
        goto done;
    } else if (uswap32(resp.status) == BCM_ERR_EAGAIN) {
        retVal = BCM_ERR_EAGAIN;
        goto done;
    } else if (uswap32(resp.status) != BCM_ERR_OK) {
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status));
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    } else if (replyLen != (MGMT_STATUS_LEN + sizeof(ETHSWT_ARLListType))) {
        HOST_Log("%s len:0x%x\n", __func__, replyLen);
        retVal = BCM_ERR_DATA_INTEG;
        goto done;
    } else {
        memcpy((uint8_t *)&cmdMsg, &resp.payload[0], sizeof(ETHSWT_ARLListType));
        *count = uswap32(cmdMsg.arlList.num);
    }

done:
    return retVal;
}

int32_t HOST_EtherSwtARLGetInt(MgmtInfoType *info, ETHSWT_ARLEntryType *entry,
                                uint32_t index, uint32_t *count)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    ETHSWT_ARLMsgUnionType cmdMsg;
    RPC_ResponseType resp;

    uint32_t replyLen;
    uint32_t cmdId;
    uint32_t idx;

    if ((info == NULL) || (entry == NULL) || (NULL == count) || (0UL == *count) || (*count > ETHSWT_ARL_RPC_MAX_ENTRIES)) {
        HOST_Log("%s :: Invalid parameters info:%p entry:%p count:%u\n", __FUNCTION__, info, entry, *count);
        goto done;
    }

    cmdId = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_ARL_ID, ETHSWT_ARLCMDID_GET);
    cmdMsg.arlList.num = uswap32(index);

    retVal = HIPC_SendRecv(cmdId, (uint8_t *)&cmdMsg,
             sizeof(ETHSWT_ARLListType),
             (uint8_t *)&resp, sizeof(resp), &replyLen);

    if (retVal != BCM_ERR_OK) {
        goto done;
    } else if (uswap32(resp.status) != BCM_ERR_OK) {
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status));
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    } else if (replyLen != (MGMT_STATUS_LEN + sizeof(ETHSWT_ARLListType))) {
        HOST_Log("%s len:0x%x\n", __func__, replyLen);
        retVal = BCM_ERR_DATA_INTEG;
        goto done;
    } else {
        memcpy((uint8_t *)&cmdMsg, &resp.payload[0], sizeof(ETHSWT_ARLListType));
        *count = uswap32(cmdMsg.arlList.num);
        for (idx = 0; idx < *count; idx++) {
            memcpy(&entry[idx].macAddr[0], &cmdMsg.arlList.entries[idx].macAddr[0], 6UL);
            entry[idx].vlanID = uswap16(cmdMsg.arlList.entries[idx].vlanID);
            entry[idx].portMask = uswap32(cmdMsg.arlList.entries[idx].portMask);
            entry[idx].reserved = uswap16(cmdMsg.arlList.entries[idx].reserved);
        }
    }

done:
    return retVal;
}

/* count is an inout parameter. Indicates maximum entries that the caller can
 * accept and the maximum entries that the target can provide */
int32_t HOST_EtherSwtARLGet(MgmtInfoType *info, ETHSWT_ARLEntryType *entry, uint32_t *count)
{
    uint32_t idx = 0UL;
    uint32_t thisCount;
    uint32_t available = 0UL;
    int32_t retVal = BCM_ERR_INVAL_PARAMS;
    uint32_t attempt = 0UL;

    if ((info == NULL) || (entry == NULL) || (count == NULL) || (0UL == *count)) {
        HOST_Log("%s :: Invalid parameters info:%p entry:%p count:%p\n", __FUNCTION__, info, entry, count);
        goto done;
    }

    do {
        retVal = HOST_EtherSwtARLSnapshot(info, &available);
        attempt++;
    } while((BCM_ERR_EAGAIN == retVal) && (attempt < GET_ARL_SNAPSHOT_ATTEMPT_MAX));

    if (BCM_ERR_EAGAIN == retVal) {
        HOST_Log("%s status:%d attempt:&lu\n", __func__, retVal, attempt);
        goto done;
    }

    if (BCM_ERR_OK != retVal) {
        HOST_Log("Failed to buffer ARL entries\n");
        goto done;
    }
    if (*count < available) {
        available = *count;
    }

    memset((uint8_t *)entry, 0UL, sizeof(ETHSWT_ARLEntryType) * (*count));

    while (idx < available) {
        if ((available - idx) >= ETHSWT_ARL_RPC_MAX_ENTRIES) {
            thisCount = ETHSWT_ARL_RPC_MAX_ENTRIES;
        } else {
            thisCount = available - idx;
        }
        retVal = HOST_EtherSwtARLGetInt(info, &entry[idx], idx, &thisCount);
        if (BCM_ERR_OK != retVal) {
            break;
        }
        idx += thisCount;
    }

    *count = available;

done:
    return retVal;
}

/*
 * @api
 * mgmt_admin_mode_get
 *
 * @brief
 * Get admin mode
 *
 * @param=info - management info
 * @param=port - port to get the information
 * @param=admin_mode - information to get
 *
 * @returns 0 on success, !0 on error
 */
int32_t HOST_EtherSwtXcvrAdminModeGet(MgmtInfoType *info, uint32_t port, ETHXCVR_ModeType *adminMode)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;
    ETHSWT_ExtPortInfoType portInfo;

    if (info == NULL) {
        HOST_Log("%s :: MgmtInfoType pointer is NULL\n", __FUNCTION__);
        goto done;
    }
    if (adminMode == NULL) {
        HOST_Log("Invalid adminMode pointer\n");
        goto done;
    }

    retVal = HOST_EtherSwtPortInfoGet(info, port, &portInfo);
    if (retVal == BCM_ERR_OK) {
        *adminMode = portInfo.adminMode;
    }

done:
    return retVal;
}

/*
 * @api
 * HOST_EtherSwtXcvrSpeedGet
 *
 * @brief
 * Get the speed
 *
 * @param=info - management info
 * @param=port - port to get the information
 * @param=speed - information to get
 *
 * @returns 0 on success, !0 on error
 */
int32_t HOST_EtherSwtXcvrSpeedGet(MgmtInfoType *info, uint32_t port, ETHXCVR_SpeedType *speed)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;
    ETHSWT_ExtPortInfoType portInfo;

    if (info == NULL) {
        HOST_Log("%s :: MgmtInfoType pointer is NULL\n", __FUNCTION__);
        goto done;
    }
    if (speed == NULL) {
        HOST_Log("Invalid speed pointer\n");
        goto done;
    }

    retVal = HOST_EtherSwtPortInfoGet(info, port, &portInfo);
    if (retVal == BCM_ERR_OK) {
        *speed = portInfo.speed;
    }
done:
    return retVal;
}

/*
 * @api
 * HOST_EtherSwtXcvrMasterSlaveGet
 *
 * @brief
 * Get the BR master/slave mode
 *
 * @param=info - management info
 * @param=port - port to get the information
 * @param=master_slave - information to get
 *
 * @returns 0 on success, !0 on error
 */
int32_t HOST_EtherSwtXcvrMasterSlaveGet(MgmtInfoType *info, uint32_t port, ETHXCVR_BooleanType *masterSlave)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;
    ETHSWT_ExtPortInfoType portInfo;

    if (info == NULL) {
        HOST_Log("%s :: MgmtInfoType pointer is NULL\n", __FUNCTION__);
        goto done;
    }
    if (masterSlave == NULL) {
        HOST_Log("Invalid masterSlave pointer\n");
        goto done;
    }

    retVal = HOST_EtherSwtPortInfoGet(info, port, &portInfo);
    if (retVal == BCM_ERR_OK) {
        *masterSlave = portInfo.masterEnable;
    }
done:
    return retVal;
}

/*
 * @api
 * HOST_EtherSwtXcvrPhyLbGet
 *
 * @brief
 * Get the phy_lb mode
 *
 * @param=info - management info
 * @param=port - port to get the information
 * @param=phy_lb - information to get
 *
 * @returns 0 on success, !0 on error
 */
int32_t HOST_EtherSwtXcvrPhyLbGet(MgmtInfoType *info, uint32_t port, ETHXCVR_BooleanType *loopbackEnable)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;
    ETHSWT_ExtPortInfoType portInfo;

    if (info == NULL) {
        HOST_Log("%s :: MgmtInfoType pointer is NULL\n", __FUNCTION__);
        goto done;
    }
    if (loopbackEnable == NULL) {
        HOST_Log("Invalid loopbackEnable pointer\n");
        goto done;
    }

    retVal = HOST_EtherSwtPortInfoGet(info, port, &portInfo);
    if (retVal == BCM_ERR_OK) {
        *loopbackEnable = portInfo.loopbackEnable;
    }
done:
    return retVal;
}


/*
 * @api
 * HOST_EtherSwtXcvrLinkSQIGet
 *
 * @brief
 * Get the link signal quality index
 *
 * @param=info - management info
 * @param=port - port to get the information
 * @param=sqi_reg_val - pointer to fill the sqi value
 *
 * @returns 0 on success, !0 on error
 */

int32_t HOST_EtherSwtXcvrLinkSQIGet(MgmtInfoType *info, uint32_t port, uint32_t *sqi)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;
    ETHSWT_ExtPortInfoType portInfo;

    if ((info == NULL) || (sqi == NULL)) {
        HOST_Log("%s :: Atleast one of the input pointer argument is NULL\n", __FUNCTION__);
        goto done;
    }

    retVal = HOST_EtherSwtPortInfoGet(info, port, &portInfo);
    if (retVal == BCM_ERR_OK) {
        *sqi = portInfo.linkSQI;
    }
done:
    return retVal;
}

/*
 * @api
 * HOST_EtherSwtXcvrJumboFrameModeGet
 *
 * @brief
 * Get the port jumbo frame mode
 *
 * @param=info - management info
 * @param=port - port to get the information
 * @param=jumboe frame mode  0=disable, 1=enable
 *
 * @returns 0 on success, !0 on error
 */
int32_t HOST_EtherSwtXcvrJumboFrameModeGet(MgmtInfoType *info, uint32_t port, ETHXCVR_BooleanType* jumboEnable)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;
    ETHSWT_ExtPortInfoType portInfo;

    if ((info == NULL) || (jumboEnable == NULL)) {
        HOST_Log("%s :: Atleast one of the input pointer argument is NULL\n", __FUNCTION__);
        goto done;
    }

    retVal = HOST_EtherSwtPortInfoGet(info, port, &portInfo);
    if (retVal == BCM_ERR_OK) {
        *jumboEnable = portInfo.jumboEnable;
    }
done:
    return retVal;
}

/*
 * @api
 * HOST_EtherSwtXcvrTypeGet
 *
 * @brief
 * get port type
 *
 * @param=info - pointer to the MgmtInfoType
 * @port = port number
 * @returns 0 on success, !0 on error
 */
int32_t HOST_EtherSwtXcvrTypeGet(MgmtInfoType *info, uint32_t port, ETHXCVR_BusModeType *busMode, ETHXCVR_PhyMediaType *phyMedia)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;
    ETHSWT_ExtPortInfoType portInfo;

    if ((info == NULL) || (busMode == NULL) || (phyMedia == NULL)) {
        HOST_Log("%s :: Invalid input parameter(info = %p,busMode = %p, phyMedia = %p)\n", __FUNCTION__, info, busMode, phyMedia);
        goto done;
    }

    retVal = HOST_EtherSwtPortInfoGet(info, port, &portInfo);
    if (retVal == BCM_ERR_OK) {
        *busMode  = portInfo.busMode;
        *phyMedia = portInfo.phyMedia;
    }
done:
    return retVal;
}

/*
 * @api
 * HOST_EtherSwtMgmtModeSet
 *
 * @brief
 * Set the management mode
 *
 * @param=info - management info
 * @param=mgmtMode - to set management mode
 *
 * @returns 0 on success, !0 on error
 */
int32_t HOST_EtherSwtMgmtModeSet(MgmtInfoType *info, ETHSWT_MgmtModeType mgmtMode)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;
    ETHSWT_ExtSwitchInfoType switchInfo;

    if (info == NULL) {
        HOST_Log("%s :: MgmtInfoType pointer is NULL\n", __FUNCTION__);
        goto done;
    }

    if ((mgmtMode != ETHSWT_MGMTMODE_ENABLE) && (mgmtMode != ETHSWT_MGMTMODE_DISABLE)) {
        HOST_Log("%s :: Invalid value for mgmtMode\n", __FUNCTION__);
        goto done;
    }

    retVal = HOST_EtherSwtSwitchInfoGet(info, &switchInfo);
    if (BCM_ERR_OK == retVal) {
        switchInfo.mgmtMode = mgmtMode;
        retVal = HOST_EtherSwtSwitchInfoSet(info, &switchInfo);
    }

done:
    return retVal;
}


/*
 * @api
 * HOST_EtherSwtDumbFwdModeSet
 *
 * @brief
 * Set the dumbfwd mode
 *
 * @param=info - management info
 * @param=dumbfwd_mode - to set dumbfwd mode
 *
 * @returns 0 on success, !0 on error
 */
int32_t HOST_EtherSwtDumbFwdModeSet(MgmtInfoType *info, ETHSWT_DumbFwdModeType dumbFwdMode)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;
    ETHSWT_ExtSwitchInfoType switchInfo;

    if (info == NULL) {
        HOST_Log("%s :: MgmtInfoType pointer is NULL\n", __FUNCTION__);
        goto done;
    }

    if ((dumbFwdMode != ETHSWT_DUMBFWD_ENABLE) && (dumbFwdMode != ETHSWT_DUMBFWD_DISABLE)) {
        HOST_Log("%s :: Invalid value for dumbFwdMode\n", __FUNCTION__);
        goto done;
    }

    retVal = HOST_EtherSwtSwitchInfoGet(info, &switchInfo);
    if (BCM_ERR_OK == retVal) {
        switchInfo.dumbFwdMode = dumbFwdMode;
        retVal = HOST_EtherSwtSwitchInfoSet(info, &switchInfo);
    }

done:
    return retVal;
}
/*
 * @api
 * HOST_EtherSwtBrcmHdrModeSet
 *
 * @brief
 * Set the brcmhdr mode
 *
 * @param=info - management info
 * @param=brcmHdrMode - to set brcmhdr mode
 *
 * @returns 0 on success, !0 on error
 */
int32_t HOST_EtherSwtBrcmHdrModeSet(MgmtInfoType *info, ETHSWT_BrcmHdrModeType brcmHdrMode)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;
    ETHSWT_ExtSwitchInfoType switchInfo;

    if (info == NULL) {
        HOST_Log("%s :: MgmtInfoType pointer is NULL\n", __FUNCTION__);
        goto done;
    }

    if ((brcmHdrMode != ETHSWT_BRCMHDR_ENABLE) && (brcmHdrMode != ETHSWT_BRCMHDR_DISABLE)) {
        HOST_Log("%s :: Invalid value for brcmhdr \n", __FUNCTION__);
        goto done;
    }

    retVal = HOST_EtherSwtSwitchInfoGet(info, &switchInfo);
    if (BCM_ERR_OK == retVal) {
        switchInfo.brcmHdrMode = brcmHdrMode;
        retVal = HOST_EtherSwtSwitchInfoSet(info, &switchInfo);
    }

done:
    return retVal;
}

/*
 * @api
 * HOST_EtherSwtXcvrAdminModeSet
 *
 * @brief
 * Set the port admin mode
 *
 * @param=info - management info
 * @param=port - port to get the information
 * @param=admin_mode - 1=disable, 2=enable
 *
 * @returns 0 on success, !0 on error
 */

int32_t HOST_EtherSwtXcvrAdminModeSet(MgmtInfoType *info, uint32_t port,
                                    ETHXCVR_ModeType adminMode)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;
    ETHSWT_ExtPortInfoType portInfo;

    if (info == NULL) {
        HOST_Log("%s :: MgmtInfoType pointer is NULL\n", __FUNCTION__);
        goto done;
    }

    if ((adminMode != ETHXCVR_MODE_ACTIVE) && (adminMode != ETHXCVR_MODE_DOWN)) {
        HOST_Log("%s :: Invalid setting for port admin mode %u\n", __FUNCTION__,
                adminMode);
        goto done;
    }

    retVal = HOST_EtherSwtPortInfoGet(info, port, &portInfo);
    if (retVal == BCM_ERR_OK) {
        portInfo.adminMode = adminMode;
        retVal = HOST_EtherSwtPortInfoSet(info, &portInfo);
    }
done:
    return retVal;
}

/*
 * @api
 * HOST_EtherSwtXcvrMasterSlaveSet
 *
 * @brief
 * Set the BR master/slave mode
 *
 * @param=info - management info
 * @param=port - port to get the information
 * @param=brMode - 0=slave, 1=master
 *
 * @returns 0 on success, !0 on error
 */
int32_t HOST_EtherSwtXcvrMasterSlaveSet(MgmtInfoType *info, uint32_t port, ETHXCVR_BooleanType masterEnable)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;
    ETHSWT_ExtPortInfoType portInfo;

    if (info == NULL) {
        HOST_Log("%s :: MgmtInfoType pointer is NULL\n", __FUNCTION__);
        goto done;
    }

    if ((masterEnable != ETHXCVR_BOOLEAN_TRUE) && (masterEnable != ETHXCVR_BOOLEAN_FALSE)) {
        HOST_Log("%s :: Invalid brMode configuration %u\n", __FUNCTION__, masterEnable);
        goto done;
    }

    retVal = HOST_EtherSwtPortInfoGet(info, port, &portInfo);
    if (retVal == BCM_ERR_OK) {
        portInfo.masterEnable = masterEnable;
        retVal = HOST_EtherSwtPortInfoSet(info, &portInfo);
    }
done:
    return retVal;
}

/*
 * @api
 * HOST_EtherSwtXcvrPhyLbSet
 *
 * @brief
 * Set the port phy_lb mode
 *
 * @param=info - management info
 * @param=port - port to get the information
 * @param=loopBackMode - ETHXCVR_BOOLEAN_FALSE=disable, ETHXCVR_BOOLEAN_TRUE=enable
 *
 * @returns 0 on success, !0 on error
 */
int32_t HOST_EtherSwtXcvrPhyLbSet(MgmtInfoType *info, uint32_t port, ETHXCVR_BooleanType loopbackEnable)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;
    ETHSWT_ExtPortInfoType portInfo;

    if (info == NULL) {
        HOST_Log("%s :: MgmtInfoType pointer is NULL\n", __FUNCTION__);
        goto done;
    }

    if ((loopbackEnable != ETHXCVR_BOOLEAN_TRUE) && (loopbackEnable != ETHXCVR_BOOLEAN_FALSE)) {
        HOST_Log("%s :: Invalid loopbackEnable configuration %u\n", __FUNCTION__, loopbackEnable);
        goto done;
    }

    retVal = HOST_EtherSwtPortInfoGet(info, port, &portInfo);
    if (retVal == BCM_ERR_OK) {
        portInfo.loopbackEnable = loopbackEnable;
        retVal = HOST_EtherSwtPortInfoSet(info, &portInfo);
    }
done:
    return retVal;
}

/*
 * @api
 * HOST_EtherSwtXcvrJumboFrameModeSet
 *
 * @brief
 * Set the port jumbo frame mode
 *
 * @param=info - management info
 * @param=port - port to get the information
 * @param=jumbo enable  0=disable, 1=enable
 *
 * @returns 0 on success, !0 on error
 */
int32_t HOST_EtherSwtXcvrJumboFrameModeSet(MgmtInfoType *info, uint32_t port, ETHXCVR_BooleanType jumboEnable)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;
    ETHSWT_ExtPortInfoType portInfo;

    if (info == NULL) {
        HOST_Log("%s :: MgmtInfoType pointer is NULL\n", __FUNCTION__);
        goto done;
    }

    if ((jumboEnable != ETHXCVR_BOOLEAN_TRUE) && (jumboEnable != ETHXCVR_BOOLEAN_FALSE)) {
        HOST_Log("%s :: Invalid jumboFrameMode configuration %u \n", __FUNCTION__, jumboEnable);
        goto done;
    }

    retVal = HOST_EtherSwtPortInfoGet(info, port, &portInfo);
    if (retVal == BCM_ERR_OK) {
        portInfo.jumboEnable = jumboEnable;
        retVal = HOST_EtherSwtPortInfoSet(info, &portInfo);
    }
done:
    return retVal;
}

int32_t HOST_EtherSwtSetVlanHoppingDetection(MgmtInfoType *info,
                   ETHSWT_SecurityActionType aVlanHoppingAction)
{
    int32_t                retVal = BCM_ERR_INVAL_PARAMS;
    ETHSWT_ExtMsgUnionType cmdMsg;
    RPC_ResponseType       resp;
    uint32_t               replyLen;
    uint32_t               cmdId;

    if (info == NULL) {
        HOST_Log("%s :: MgmtInfoType pointer is NULL\n", __FUNCTION__);
        goto done;
    }

    memset((uint8_t *)cmdMsg.data, 0, sizeof(cmdMsg));

    cmdId = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_SWT_ID, ETHSWT_EXTCMDID_VLAN_HOPPING_DETECTION_SET);
    cmdMsg.vlanHoppingAction = uswap32(aVlanHoppingAction);

    retVal = HIPC_SendRecv(cmdId, (uint8_t *)cmdMsg.data,
             sizeof((cmdMsg.vlanHoppingAction)),
             (uint8_t *)&resp, sizeof(resp), &replyLen);
    if (retVal != BCM_ERR_OK) {
        goto done;
    } else if (uswap32(resp.status) != BCM_ERR_OK) {
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status));
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    } else if (replyLen != (MGMT_STATUS_LEN + sizeof(cmdMsg.vlanHoppingAction))) {
        HOST_Log("%s len:0x%x\n", __func__, replyLen);
        retVal = BCM_ERR_DATA_INTEG;
        goto done;
    }

done:
    return retVal;
}
int32_t HOST_EtherSwtGetVlanHoppingDetection(MgmtInfoType *info,
        ETHSWT_SecurityActionType * const aVlanHoppingActionPtr)
{
    int32_t                retVal = BCM_ERR_INVAL_PARAMS;
    ETHSWT_ExtMsgUnionType cmdMsg;
    RPC_ResponseType       resp;
    uint32_t               replyLen;
    uint32_t               cmdId;

    if (info == NULL) {
        HOST_Log("%s :: MgmtInfoType pointer is NULL\n", __FUNCTION__);
        goto done;
    }
    if (aVlanHoppingActionPtr == NULL) {
        HOST_Log("%s :: aVlanHoppingActionPtr pointer is NULL\n", __FUNCTION__);
        goto done;
    }
    memset((uint8_t *)cmdMsg.data, 0, sizeof(cmdMsg));
    cmdId = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_SWT_ID, ETHSWT_EXTCMDID_VLAN_HOPPING_DETECTION_GET);

    retVal = HIPC_SendRecv(cmdId, (uint8_t *)cmdMsg.data,
             sizeof((cmdMsg.vlanHoppingAction)),
             (uint8_t *)&resp, sizeof(resp), &replyLen);
    if (retVal != BCM_ERR_OK) {
        goto done;
    } else if (uswap32(resp.status) != BCM_ERR_OK) {
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status));
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    } else if (replyLen != (MGMT_STATUS_LEN + sizeof((cmdMsg.vlanHoppingAction)))) {
        HOST_Log("%s len:0x%x\n", __func__, replyLen);
        retVal = BCM_ERR_DATA_INTEG;
        goto done;
    }
    memcpy((uint8_t *)&cmdMsg, &resp.payload[0], sizeof(cmdMsg.vlanHoppingAction));
    *aVlanHoppingActionPtr  = uswap32(cmdMsg.vlanHoppingAction);
done:
    return retVal;
}

int32_t HOST_EtherSwtGetWakeupMode(MgmtInfoType *info, uint32_t aPort, uint8_t *const aMode)
{
    int32_t                retVal = BCM_ERR_INVAL_PARAMS;
    ETHSWT_ExtMsgUnionType cmdMsg;
    RPC_ResponseType       resp;
    uint32_t               replyLen;
    uint32_t               cmdId;

    if (info == NULL) {
        HOST_Log("%s :: MgmtInfoType pointer is NULL\n", __FUNCTION__);
        goto done;
    }

    memset((uint8_t *)cmdMsg.data, 0, sizeof(cmdMsg));

    cmdMsg.tc10Wake.port = uswap32(aPort);
    cmdId = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_SWT_ID, ETHSWT_EXTCMDID_GETWAKEUPMODE);

    retVal = HIPC_SendRecv(cmdId, (uint8_t *)cmdMsg.data,
             sizeof(ETHSWT_ExtTc10WakeUpType),
             (uint8_t *)&resp, sizeof(resp), &replyLen);

    if (retVal != BCM_ERR_OK) {
        goto done;
    } else if (uswap32(resp.status) != BCM_ERR_OK) {
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status));
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    } else if (replyLen != (MGMT_STATUS_LEN + sizeof(ETHSWT_ExtTc10WakeUpType))) {
        HOST_Log("%s len:0x%x\n", __func__, replyLen);
        retVal = BCM_ERR_DATA_INTEG;
        goto done;
    }
    memcpy((uint8_t *)&cmdMsg, &resp.payload[0], sizeof(ETHSWT_ExtTc10WakeUpType));
    *aMode = uswap32(cmdMsg.tc10Wake.mode);
done:
    return retVal;
}

int32_t HOST_EtherSwtGetWakeupReason(MgmtInfoType *info, uint32_t aPort, ETHXCVR_WakeupReasonType *const aReason)
{
    int32_t                retVal = BCM_ERR_INVAL_PARAMS;
    ETHSWT_ExtMsgUnionType cmdMsg;
    RPC_ResponseType       resp;
    uint32_t               replyLen;
    uint32_t               cmdId;

    if (info == NULL) {
        HOST_Log("%s :: MgmtInfoType pointer is NULL\n", __FUNCTION__);
        goto done;
    }

    memset((uint8_t *)cmdMsg.data, 0, sizeof(cmdMsg));

    cmdMsg.tc10Wake.port = uswap32(aPort);
    cmdId = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_SWT_ID, ETHSWT_EXTCMDID_GETWAKEUPREASON);

    retVal = HIPC_SendRecv(cmdId, (uint8_t *)cmdMsg.data,
             sizeof(ETHSWT_ExtTc10WakeUpType),
             (uint8_t *)&resp, sizeof(resp), &replyLen);

    if (retVal != BCM_ERR_OK) {
        goto done;
    } else if (uswap32(resp.status) != BCM_ERR_OK) {
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status));
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    } else if (replyLen != (MGMT_STATUS_LEN + sizeof(ETHSWT_ExtTc10WakeUpType))) {
        HOST_Log("%s len:0x%x\n", __func__, replyLen);
        retVal = BCM_ERR_DATA_INTEG;
        goto done;
    }
    memcpy((uint8_t *)&cmdMsg, &resp.payload[0], sizeof(ETHSWT_ExtTc10WakeUpType));
    *aReason = uswap32(cmdMsg.tc10Wake.reason);
done:
    return retVal;
}

#ifdef ENABLE_ETHSWT_SECURITY
int32_t HOST_EtherSwtSetStationMovementDetection(MgmtInfoType *info,
            ETHSWT_PortIDType aPortID, ETHSWT_SecurityActionType aStationMoveAction)
{
    int32_t                retVal = BCM_ERR_INVAL_PARAMS;
    ETHSWT_ExtMsgUnionType cmdMsg;
    RPC_ResponseType       resp;
    uint32_t               replyLen;
    uint32_t               cmdId;

    if (info == NULL) {
        HOST_Log("%s :: MgmtInfoType pointer is NULL\n", __FUNCTION__);
        goto done;
    }

    memset((uint8_t *)cmdMsg.data, 0, sizeof(cmdMsg));

    cmdId = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_SWT_ID, ETHSWT_EXTCMDID_STATION_MOVE_DETECT_SET);
    cmdMsg.stationMove.port = uswap32(aPortID);
    cmdMsg.stationMove.stationMoveAction = aStationMoveAction;

    retVal = HIPC_SendRecv(cmdId, (uint8_t *)cmdMsg.data,
             sizeof(ETHSWT_ExtStationMovementType),
             (uint8_t *)&resp, sizeof(resp), &replyLen);

    if (retVal != BCM_ERR_OK) {
        goto done;
    } else if (uswap32(resp.status) != BCM_ERR_OK) {
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status));
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    } else if (replyLen != (MGMT_STATUS_LEN + sizeof(ETHSWT_ExtStationMovementType))) {
        HOST_Log("%s len:0x%x\n", __func__, replyLen);
        retVal = BCM_ERR_DATA_INTEG;
        goto done;
    }

done:
    return retVal;
}

int32_t HOST_EtherSwtGetStationMovementDetection(MgmtInfoType *info,
            ETHSWT_PortIDType aPortID, ETHSWT_SecurityActionType * const aStationMoveAction)
{
    int32_t                retVal = BCM_ERR_INVAL_PARAMS;
    ETHSWT_ExtMsgUnionType cmdMsg;
    RPC_ResponseType       resp;
    uint32_t               replyLen;
    uint32_t               cmdId;

    if (info == NULL) {
        HOST_Log("%s :: MgmtInfoType pointer is NULL\n", __FUNCTION__);
        goto done;
    }
    if (aStationMoveAction == NULL) {
        HOST_Log("%s :: aStationMoveAction pointer is NULL\n", __FUNCTION__);
        goto done;
    }
    memset((uint8_t *)cmdMsg.data, 0, sizeof(cmdMsg));

    cmdId = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_SWT_ID, ETHSWT_EXTCMDID_STATION_MOVE_DETECT_GET);
    cmdMsg.stationMove.port = uswap32(aPortID);

    retVal = HIPC_SendRecv(cmdId, (uint8_t *)cmdMsg.data,
             sizeof(ETHSWT_ExtStationMovementType),
             (uint8_t *)&resp, sizeof(resp), &replyLen);
    if (retVal != BCM_ERR_OK) {
        goto done;
    } else if (uswap32(resp.status) != BCM_ERR_OK) {
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status));
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    } else if (replyLen != (MGMT_STATUS_LEN + sizeof(ETHSWT_ExtStationMovementType))) {
        HOST_Log("%s len:0x%x\n", __func__, replyLen);
        retVal = BCM_ERR_DATA_INTEG;
        goto done;
    }
    memcpy((uint8_t *)&cmdMsg, &resp.payload[0], sizeof(ETHSWT_ExtStationMovementType));
    *aStationMoveAction  = cmdMsg.stationMove.stationMoveAction;
done:
    return retVal;
}

int32_t HOST_EtherSwtSetMACAddressStickyToPort(MgmtInfoType *info,
            ETHSWT_PortIDType aPortID, ETHSWT_SecurityActionType aStickyMACAction)
{
    int32_t              retVal = BCM_ERR_INVAL_PARAMS;
    ETHSWT_ExtMsgUnionType cmdMsg;
    RPC_ResponseType     resp;
    uint32_t             replyLen;
    uint32_t             cmdId;

    if (info == NULL) {
        HOST_Log("%s :: MgmtInfoType pointer is NULL\n", __FUNCTION__);
        goto done;
    }

    memset((uint8_t *)cmdMsg.data, 0, sizeof(cmdMsg));

    cmdId = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_SWT_ID, ETHSWT_EXTCMDID_STICKY_MAC_ADDRESS_SET);
    cmdMsg.stickyMAC.port = uswap32(aPortID);
    cmdMsg.stickyMAC.stickyMACAction = aStickyMACAction;

    retVal = HIPC_SendRecv(cmdId, (uint8_t *)cmdMsg.data,
             sizeof(ETHSWT_ExtStickyMACType),
             (uint8_t *)&resp, sizeof(resp), &replyLen);
    if (retVal != BCM_ERR_OK) {
        goto done;
    } else if (uswap32(resp.status) != BCM_ERR_OK) {
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status));
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    } else if (replyLen != (MGMT_STATUS_LEN + sizeof(ETHSWT_ExtStickyMACType))) {
        HOST_Log("%s len:0x%x\n", __func__, replyLen);
        retVal = BCM_ERR_DATA_INTEG;
        goto done;
    }

done:
    return retVal;
}

int32_t HOST_EtherSwtGetMACAddressStickyToPort(MgmtInfoType *info,
        ETHSWT_PortIDType aPortID, ETHSWT_SecurityActionType * const aStickyMACAction)
{
    int32_t              retVal = BCM_ERR_INVAL_PARAMS;
    ETHSWT_ExtMsgUnionType cmdMsg;
    RPC_ResponseType     resp;
    uint32_t             replyLen;
    uint32_t             cmdId;

    if (info == NULL) {
        HOST_Log("%s :: MgmtInfoType pointer is NULL\n", __FUNCTION__);
        goto done;
    }
    if (aStickyMACAction == NULL) {
        HOST_Log("%s :: aStickyMACAction pointer is NULL\n", __FUNCTION__);
        goto done;
    }
    memset((uint8_t *)cmdMsg.data, 0, sizeof(cmdMsg));

    cmdId = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_SWT_ID, ETHSWT_EXTCMDID_STICKY_MAC_ADDRESS_GET);
    cmdMsg.stickyMAC.port = uswap32(aPortID);

    retVal = HIPC_SendRecv(cmdId, (uint8_t *)cmdMsg.data,
             sizeof(ETHSWT_ExtStickyMACType),
             (uint8_t *)&resp, sizeof(resp), &replyLen);

    if (retVal != BCM_ERR_OK) {
        goto done;
    } else if (uswap32(resp.status) != BCM_ERR_OK) {
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status));
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    } else if (replyLen != (MGMT_STATUS_LEN + sizeof(ETHSWT_ExtStickyMACType))) {
        HOST_Log("%s len:0x%x\n", __func__, replyLen);
        retVal = BCM_ERR_DATA_INTEG;
        goto done;
    }
    memcpy((uint8_t *)&cmdMsg, &resp.payload[0], sizeof(ETHSWT_ExtStickyMACType));
    *aStickyMACAction  = cmdMsg.stickyMAC.stickyMACAction;
done:
    return retVal;
}

int32_t HOST_EtherSwtSetPortAddrLimiting(MgmtInfoType *info,
                   ETHSWT_PortIDType aPortID,
                   ETHSWT_SecurityActionType aOverLimitAction,
                   uint16_t aMacLearningLimit)
{
    int32_t              retVal = BCM_ERR_INVAL_PARAMS;
    ETHSWT_ExtMsgUnionType cmdMsg;
    RPC_ResponseType     resp;
    uint32_t             replyLen;
    uint32_t             cmdId;

    if (info == NULL) {
        HOST_Log("%s :: MgmtInfoType pointer is NULL\n", __FUNCTION__);
        goto done;
    }

    memset((uint8_t *)cmdMsg.data, 0, sizeof(cmdMsg));

    cmdId = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_SWT_ID, ETHSWT_EXTCMDID_PORT_ADDRESS_LIMITING_SET);
    cmdMsg.addrLimit.port = uswap32(aPortID);
    cmdMsg.addrLimit.addressLimitInfo.overLimitAction = aOverLimitAction;
    cmdMsg.addrLimit.addressLimitInfo.macLearningLimit = uswap16(aMacLearningLimit);

    retVal = HIPC_SendRecv(cmdId, (uint8_t *)cmdMsg.data,
             sizeof(ETHSWT_ExtPortAddressLimitType),
             (uint8_t *)&resp, sizeof(resp), &replyLen);

    if (retVal != BCM_ERR_OK) {
        goto done;
    } else if (uswap32(resp.status) != BCM_ERR_OK) {
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status));
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    } else if (replyLen != (MGMT_STATUS_LEN + sizeof(ETHSWT_ExtPortAddressLimitType))) {
        HOST_Log("%s len:0x%x\n", __func__, replyLen);
        retVal = BCM_ERR_DATA_INTEG;
        goto done;
    }

done:
    return retVal;
}

int32_t HOST_EtherSwtGetPortAddrLimitAndCounter(MgmtInfoType *info,
                   ETHSWT_PortIDType aPortID,
                   ETHSWT_SecurityActionType * const aOverLimitAction,
                   uint16_t * const aMacLearningLimit,
                   uint16_t * const aPortLearnedCounter,
                   uint32_t * const aPortOverLimitCounter)
{
    int32_t              retVal = BCM_ERR_INVAL_PARAMS;
    ETHSWT_ExtMsgUnionType cmdMsg;
    RPC_ResponseType     resp;
    uint32_t             replyLen;
    uint32_t             cmdId;

    if (info == NULL) {
        HOST_Log("%s :: MgmtInfoType pointer is NULL\n", __FUNCTION__);
        goto done;
    }
    if ((aOverLimitAction == NULL)    ||
        (aMacLearningLimit == NULL)   ||
        (aPortLearnedCounter == NULL) ||
        (aPortOverLimitCounter == NULL)) {
        HOST_Log("%s :: pointer is NULL\n", __FUNCTION__);
        goto done;
    }

    memset((uint8_t *)cmdMsg.data, 0, sizeof(cmdMsg));

    cmdId = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_SWT_ID, ETHSWT_EXTCMDID_PORT_ADDRESS_LIMITING_GET);
    cmdMsg.stickyMAC.port = uswap32(aPortID);

    retVal = HIPC_SendRecv(cmdId, (uint8_t *)cmdMsg.data,
             sizeof(ETHSWT_ExtPortAddressLimitType),
             (uint8_t *)&resp, sizeof(resp), &replyLen);

    if (retVal != BCM_ERR_OK) {
        goto done;
    } else if (uswap32(resp.status) != BCM_ERR_OK) {
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status));
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    } else if (replyLen != (MGMT_STATUS_LEN + sizeof(ETHSWT_ExtPortAddressLimitType))) {
        HOST_Log("%s len:0x%x\n", __func__, replyLen);
        retVal = BCM_ERR_DATA_INTEG;
        goto done;
    }
    memcpy((uint8_t *)&cmdMsg, &resp.payload[0], sizeof(ETHSWT_ExtPortAddressLimitType));
    *aOverLimitAction  = cmdMsg.addrLimit.addressLimitInfo.overLimitAction;
    *aMacLearningLimit = uswap16(cmdMsg.addrLimit.addressLimitInfo.macLearningLimit);
    *aPortLearnedCounter = uswap16(cmdMsg.addrLimit.portLearnedCounter);
    *aPortOverLimitCounter = uswap32(cmdMsg.addrLimit.portOverLimitCounter);
done:
    return retVal;
}

int32_t HOST_EtherSwtSetTotalAddrLimit(MgmtInfoType *info,
                     uint16_t aTotalMACLearningLimit)
{
    int32_t              retVal = BCM_ERR_INVAL_PARAMS;
    ETHSWT_ExtMsgUnionType cmdMsg;
    RPC_ResponseType     resp;
    uint32_t             replyLen;
    uint32_t             cmdId;

    if (info == NULL) {
        HOST_Log("%s :: MgmtInfoType pointer is NULL\n", __FUNCTION__);
        goto done;
    }

    memset((uint8_t *)cmdMsg.data, 0, sizeof(cmdMsg));

    cmdId = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_SWT_ID, ETHSWT_EXTCMDID_TOTAL_ADDRESS_LIMIT_SET);
    cmdMsg.totalAddressLimit.totalMACLearningLimit = uswap16(aTotalMACLearningLimit);

    retVal = HIPC_SendRecv(cmdId, (uint8_t *)cmdMsg.data,
             sizeof(ETHSWT_ExtTotalMACLearningLimitType),
             (uint8_t *)&resp, sizeof(resp), &replyLen);
    if (retVal != BCM_ERR_OK) {
        goto done;
    } else if (uswap32(resp.status) != BCM_ERR_OK) {
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status));
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    } else if (replyLen != (MGMT_STATUS_LEN + sizeof(ETHSWT_ExtTotalMACLearningLimitType))) {
        HOST_Log("%s len:0x%x\n", __func__, replyLen);
        retVal = BCM_ERR_DATA_INTEG;
        goto done;
    }

done:
    return retVal;
}
int32_t HOST_EtherSwtGetTotalAddrLimitAndCounter(MgmtInfoType *info,
                                uint16_t * const aTotalMACLearningLimit,
                                uint16_t * const aTotalLearnedCounter)
{
    int32_t              retVal = BCM_ERR_INVAL_PARAMS;
    ETHSWT_ExtMsgUnionType cmdMsg;
    RPC_ResponseType     resp;
    uint32_t             replyLen;
    uint32_t             cmdId;

    if (info == NULL) {
        HOST_Log("%s :: MgmtInfoType pointer is NULL\n", __FUNCTION__);
        goto done;
    }
    if (aTotalMACLearningLimit == NULL) {
        HOST_Log("%s :: aTotalMACLearningLimit pointer is NULL\n", __FUNCTION__);
        goto done;
    }
    if (aTotalLearnedCounter == NULL) {
        HOST_Log("%s :: aTotalLearnedCounter pointer is NULL\n", __FUNCTION__);
        goto done;
    }

    memset((uint8_t *)cmdMsg.data, 0, sizeof(cmdMsg));

    cmdId = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_SWT_ID, ETHSWT_EXTCMDID_TOTAL_ADDRESS_LIMIT_GET);

    retVal = HIPC_SendRecv(cmdId, (uint8_t *)cmdMsg.data,
             sizeof(ETHSWT_ExtTotalMACLearningLimitType),
             (uint8_t *)&resp, sizeof(resp), &replyLen);
    if (retVal != BCM_ERR_OK) {
        goto done;
    } else if (uswap32(resp.status) != BCM_ERR_OK) {
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status));
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    } else if (replyLen != (MGMT_STATUS_LEN + sizeof(ETHSWT_ExtTotalMACLearningLimitType))) {
        HOST_Log("%s len:0x%x\n", __func__, replyLen);
        retVal = BCM_ERR_DATA_INTEG;
        goto done;
    }
    memcpy((uint8_t *)&cmdMsg, &resp.payload[0], sizeof(ETHSWT_ExtTotalMACLearningLimitType));
    *aTotalMACLearningLimit = uswap16(cmdMsg.totalAddressLimit.totalMACLearningLimit);
    *aTotalLearnedCounter = uswap16(cmdMsg.totalAddressLimit.totalLearnedCounter);
done:
    return retVal;
}
#endif /* ENABLE_ETHSWT_SECURITY */
