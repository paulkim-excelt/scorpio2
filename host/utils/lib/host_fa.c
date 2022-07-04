/*****************************************************************************
 Copyright 2020 Broadcom Limited.  All rights reserved.

 This program is the proprietary software of Broadcom Corporation and/or its
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

/** @defgroup grp_host_fa_impl Host FA Implementation
    @ingroup grp_host_fa

    @addtogroup grp_host_fa_impl
    @{

    @file host_fa.c
    @brief Host FA Implementation
    This file contains the host functions implementation for FA

    @version 0.1 Initial Version
*/

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
#include <host_fa.h>
/**
    @name Host API for Flow Accelerator
    @{
    @brief Host FA API
*/
#define BRCM_SWDSGN_HOST_FAFLOWADD_PROC            (0xB101U)    /**< @brief #HOST_FAFlowAdd         */
#define BRCM_SWDSGN_HOST_FAFLOWDELETE_PROC         (0xB102U)    /**< @brief #HOST_FAFlowDelete      */
#define BRCM_SWDSGN_HOST_FAFLOWGET_PROC            (0xB103U)    /**< @brief #HOST_FAFlowGet         */
#define BRCM_SWDSGN_HOST_FASTATS_PROC              (0xB104U)    /**< @brief #HOST_FAStats           */
#define BRCM_SWDSGN_HOST_FA_FLOW_STATUS_PROC       (0xB105U)    /**< @brief #HOST_FAFlowStatus      */
#define BRCM_SWDSGN_HOST_FAMACADD_PROC             (0xB106U)    /**< @brief #HOST_FAMacAdd          */
#define BRCM_SWDSGN_HOST_FAMACDELETE_PROC          (0xB107U)    /**< @brief #HOST_FAMacDelete       */
#define BRCM_SWDSGN_HOST_FAMACFORCEDELETE_PROC     (0xB108U)    /**< @brief #HOST_FAMacForceDelete  */
#define BRCM_SWDSGN_HOST_FAMACSNAPSHOTGET_PROC     (0xB109U)    /**< @brief #HOST_FAMacSnapshotGet  */
#define BRCM_SWDSGN_HOST_FARESET_PROC              (0xB10AU)    /**< @brief #HOST_FAReset           */
#define BRCM_SWDSGN_HOST_FAENABLEINTERRUPT_PROC    (0xB10BU)    /**< @brief #HOST_FAEnableInterrupt */
/** @} */

/** Add a Flow

    @trace #BRCM_SWARCH_HOST_FAFLOWADD_PROC
    @trace #BRCM_SWREQ_HOST_FA_SET

    @code{.unparsed}

    if info OR aFlow OR aFlowID is NULL
        return BCM_ERR_INVAL_PARAMS


    cmdId = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_FAC_ID, ETHSWT_FACMDID_FLOW_ADD)

    copy aFlow to cmdHdl.flowOperation.flow
    retVal =  HIPC_SendRecv(cmdId, (uint8_t*)cmdHdl.data,
             sizeof(ETHSWT_FAFlowOperationType), (uint8_t *)&resp, sizeof(resp), &replyLen)

    if (BCM_ERR_OK is not retVal)
        goto done
    else if (BCM_ERR_OK is not uswap32(resp.status))
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status))
        retVal = uswap32(resp.status)
        goto done
    else if ((MGMT_STATUS_LEN + sizeof(ETHSWT_FAFlowOperationType)) is NOT replyLen)
        HOST_Log("%s len:0x%x\n", __func__, replyLen)
        retVal = BCM_ERR_DATA_INTEG
        goto done
    else
        memcpy((uint8_t*)&respHdl,&resp.payload[0], sizeof(ETHSWT_FAFlowOperationType));
        *aFlowID =  uswap32(respHdl.flowOperation.flowID)

    done:
    return retVal

    @endcode

*/
int32_t HOST_FAFlowAdd(MgmtInfoType *info,
                            ETHSWT_FAFlowDataType *aFlow,
                            ETHSWT_FAFlowIDType  *aFlowID)
{
    int32_t              retVal = BCM_ERR_INVAL_PARAMS;
    ETHSWT_FAMsgUnionType cmdHdl;
    RPC_ResponseType     resp;
    ETHSWT_FAMsgUnionType respHdl;
    uint32_t             replyLen;
    uint32_t             cmdId;

    if ((NULL == info) || (NULL == aFlow) || (NULL == aFlowID)){
        HOST_Log("%s :: Invalid parameters info:%p aFlow:%p aFlowID:%p\n", __FUNCTION__, info, aFlow, aFlowID);
        goto done;
    }

    memset((uint8_t *)cmdHdl.data, 0, sizeof(cmdHdl));
    memset((uint8_t *)respHdl.data, 0, sizeof(respHdl));

    cmdId = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_FAC_ID, ETHSWT_FACMDID_FLOW_ADD);

    /* aFlow */
    memcpy(&cmdHdl.flowOperation.flow.match.da[0], &aFlow->match.da[0], 6UL);
    cmdHdl.flowOperation.flow.match.srcPort = uswap16(aFlow->match.srcPort);
    cmdHdl.flowOperation.flow.match.dstPort = uswap16(aFlow->match.dstPort);
    cmdHdl.flowOperation.flow.match.flags   = aFlow->match.flags;
    memcpy(&cmdHdl.flowOperation.flow.match.srcIp[0], &aFlow->match.srcIp[0], 16UL);
    memcpy(&cmdHdl.flowOperation.flow.match.dstIp[0], &aFlow->match.dstIp[0], 16UL);
    cmdHdl.flowOperation.flow.remap.operation = aFlow->remap.operation;
    memcpy(&cmdHdl.flowOperation.flow.remap.sa[0], &aFlow->remap.sa[0], 6UL);
    memcpy(&cmdHdl.flowOperation.flow.remap.da[0], &aFlow->remap.da[0], 6UL);
    cmdHdl.flowOperation.flow.remap.vlan = uswap16(aFlow->remap.vlan);
    cmdHdl.flowOperation.flow.remap.port = uswap16(aFlow->remap.port);
    memcpy(&cmdHdl.flowOperation.flow.remap.ip[0], &aFlow->remap.ip[0], 16UL);
    cmdHdl.flowOperation.flow.remap.tc = aFlow->remap.tc;
    cmdHdl.flowOperation.flow.remap.te = aFlow->remap.te;
    cmdHdl.flowOperation.flow.remap.portMask = uswap32(aFlow->remap.portMask);
    cmdHdl.flowOperation.flow.mstSlvDevice = uswap32(aFlow->mstSlvDevice);

    retVal = HIPC_SendRecv(cmdId, (uint8_t *)&cmdHdl.data,
             sizeof(ETHSWT_FAFlowOperationType), (uint8_t *)&resp, sizeof(resp), &replyLen);
    if (BCM_ERR_OK != retVal) {
        goto done;
    } else if (BCM_ERR_OK != uswap32(resp.status)) {
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status));
        retVal = uswap32(resp.status);
        goto done;
    } else if ((MGMT_STATUS_LEN + sizeof(ETHSWT_FAFlowOperationType)) != replyLen) {
        HOST_Log("%s len:0x%x\n", __func__, replyLen);
        retVal = BCM_ERR_DATA_INTEG;
        goto done;
    } else {
        memcpy((uint8_t *)&respHdl, &resp.payload[0],replyLen); 
        *aFlowID = uswap32(respHdl.flowOperation.flowID);
    }
done:
    return retVal;

}

/** Delete a Flow

    This API deletes an existing flow from Flow accelerator by providing the
    Flow ID obtained after adding the same.

    @trace #BRCM_SWARCH_HOST_FAFLOWDELETE_PROC
    @trace #BRCM_SWREQ_HOST_FA_SET

    @code{.unparsed}

    if info OR aFlowID is NULL
        return BCM_ERR_INVAL_PARAMS


    cmdId is  BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_FAC_ID, ETHSWT_FACMDID_FLOW_DELETE)

    copy aFlowID to cmdHdl.flowOperation.flowID
    retVal = HIPC_SendRecv(cmdId, (uint8_t*)cmdHdl.data,
             sizeof(ETHSWT_FAFlowOperationType), (uint8_t *)&resp, sizeof(resp), &replyLen)
    if (BCM_ERR_OK is NOT retVal)
        goto done
    else if (BCM_ERR_OK is NOT uswap32(resp.status))
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status))
        retVal = uswap32(resp.status)
        goto done
    else if ((MGMT_STATUS_LEN + sizeof(ETHSWT_FAFlowOperationType)) is NOT replyLen)
        HOST_Log("%s len:0x%x\n", __func__, replyLen)
        retVal = BCM_ERR_DATA_INTEG
        goto done

    done:
    return retVal

    @endcode
*/
int32_t HOST_FAFlowDelete(MgmtInfoType *info,
                                     ETHSWT_FAFlowIDType aFlowID)
{
    int32_t              retVal = BCM_ERR_INVAL_PARAMS;
    ETHSWT_FAMsgUnionType cmdHdl;
    RPC_ResponseType     resp;
    ETHSWT_FAMsgUnionType respHdl;
    uint32_t             replyLen;
    uint32_t             cmdId;

    if (NULL == info) {
        HOST_Log("%s :: MgmtInfoType pointer is NULL\n", __FUNCTION__);
        goto done;
    }

    memset((uint8_t *)cmdHdl.data, 0, sizeof(cmdHdl));
    memset((uint8_t *)respHdl.data, 0, sizeof(respHdl));

    cmdId = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_FAC_ID, ETHSWT_FACMDID_FLOW_DELETE);

    cmdHdl.flowOperation.flowID = uswap32(aFlowID);
    retVal = HIPC_SendRecv(cmdId, (uint8_t *)cmdHdl.data, sizeof(ETHSWT_FAFlowOperationType),
        (uint8_t *)&resp, sizeof(resp), &replyLen);
    if (BCM_ERR_OK != retVal) {
        goto done;
    } else if (BCM_ERR_OK != uswap32(resp.status)) {
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status));
        retVal = uswap32(resp.status);
        goto done;
    } else if ((MGMT_STATUS_LEN + sizeof(ETHSWT_FAFlowOperationType)) != replyLen) {
        HOST_Log("%s len:0x%x\n", __func__, replyLen);
        retVal = BCM_ERR_DATA_INTEG;
        goto done;
    }
done:
    return retVal;
}

/** Flow Get

    This API retrieves flow parameters pertaining to a Flow ID

    @trace #BRCM_SWARCH_HOST_FAFLOWGET_PROC
    @trace #BRCM_SWREQ_HOST_FA_QUERY

    @code{.unparsed}

    if info OR aFlow OR aFlowStats is NULL
        return BCM_ERR_INVAL_PARAMS

    cmdHdl.data = &cmdPayload[0]
    respHdl.data = &resp.payload[0]

    cmdId is BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_FAC_ID, ETHSWT_FACMDID_FLOW_GET)

    retVal = HIPC_SendRecv(cmdId, (uint8_t*)cmdHdl.data,
             sizeof(ETHSWT_FAFlowOperationType), (uint8_t *)&resp, sizeof(resp), &replyLen)
    if (BCM_ERR_OK is NOT  retVal)
        goto done;
    else if (BCM_ERR_OK is NOT uswap32(resp.status))
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status))
        retVal = uswap32(resp.status)
        goto done
    else if ((MGMT_STATUS_LEN + sizeof(ETHSWT_FAFlowOperationType)) is NOT replyLen)
        HOST_Log("%s len:0x%x\n", __func__, replyLen)
        retVal = BCM_ERR_DATA_INTEG
        goto done
    else
        on Success copy the response
        copy respHdl.flowOperation.flow to aFlow
        copy respHdl.flowOperation.flowStats to aFlowStats

    done:
    return retVal
    @endcode
*/
int32_t HOST_FAFlowGet(MgmtInfoType *info, ETHSWT_FAFlowIDType aFlowID,
                                ETHSWT_FAFlowDataType  *aFlow,
                                ETHSWT_FAFlowStatsType *aFlowStats)
{
    int32_t              retVal = BCM_ERR_INVAL_PARAMS;
    ETHSWT_FAMsgUnionType cmdHdl;
    RPC_ResponseType     resp;
    ETHSWT_FAMsgUnionType respHdl;
    uint32_t             replyLen;
    uint32_t             cmdId;

    if ((NULL == info) || (NULL == aFlow) || (NULL == aFlowStats)) {
        HOST_Log("%s :: Invalid parameters info:%p aFlow:%p aFlowStats:%p\n", __FUNCTION__, info, aFlow, aFlowStats);
        goto done;
    }

    memset((uint8_t *)cmdHdl.data, 0, sizeof(cmdHdl));
    memset((uint8_t *)respHdl.data, 0, sizeof(respHdl));

    cmdId = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_FAC_ID, ETHSWT_FACMDID_FLOW_GET);

    cmdHdl.flowOperation.flowID = uswap32(aFlowID);
    retVal = HIPC_SendRecv(cmdId, (uint8_t*)cmdHdl.data,
             sizeof(ETHSWT_FAFlowOperationType), (uint8_t *)&resp, sizeof(resp), &replyLen);
    if (BCM_ERR_OK != retVal) {
        goto done;
    } else if (BCM_ERR_OK != uswap32(resp.status)) {
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status));
        retVal = uswap32(resp.status);
        goto done;
    } else if ((MGMT_STATUS_LEN + sizeof(ETHSWT_FAFlowOperationType)) != replyLen) {
        HOST_Log("%s len:0x%x\n", __func__, replyLen);
        retVal = BCM_ERR_DATA_INTEG;
        goto done;
    } else {
        /* aFlow */
        memcpy((uint8_t*)&respHdl,&resp.payload[0], sizeof(ETHSWT_FAFlowOperationType));
        memcpy(&aFlow->match.da[0], &respHdl.flowOperation.flow.match.da[0], 6UL);
        aFlow->match.srcPort = uswap16(respHdl.flowOperation.flow.match.srcPort);
        aFlow->match.dstPort = uswap16(respHdl.flowOperation.flow.match.dstPort);
        aFlow->match.flags   = respHdl.flowOperation.flow.match.flags;
        memcpy(&aFlow->match.srcIp[0], &respHdl.flowOperation.flow.match.srcIp[0], 16UL);
        memcpy(&aFlow->match.dstIp[0], &respHdl.flowOperation.flow.match.dstIp[0], 16UL);

        aFlow->remap.operation = respHdl.flowOperation.flow.remap.operation;
        memcpy(&aFlow->remap.sa[0], &respHdl.flowOperation.flow.remap.sa[0], 6UL);
        memcpy(&aFlow->remap.da[0], &respHdl.flowOperation.flow.remap.da[0], 6UL);
        aFlow->remap.vlan = uswap16(respHdl.flowOperation.flow.remap.vlan);
        aFlow->remap.port = uswap16(respHdl.flowOperation.flow.remap.port);
        memcpy(&aFlow->remap.ip[0], &respHdl.flowOperation.flow.remap.ip[0], 16UL);
        aFlow->remap.tc = respHdl.flowOperation.flow.remap.tc;
        aFlow->remap.te = respHdl.flowOperation.flow.remap.te;
        aFlow->remap.portMask = uswap32(respHdl.flowOperation.flow.remap.portMask);
        aFlow->mstSlvDevice = uswap32(respHdl.flowOperation.flow.mstSlvDevice);

        /* aFlowStats */
        aFlowStats->hits = uswap32(respHdl.flowOperation.flowStats.hits);
        aFlowStats->lastTimestamp = respHdl.flowOperation.flowStats.lastTimestamp;

    }
done:
    return retVal;
}

/** Retrieve FA Global statistics

    This API retrieves statistics from Flow accelerator

    @trace #BRCM_SWARCH_HOST_FASTATS_PROC
    @trace #BRCM_SWREQ_HOST_FA_QUERY

    @code{.unparsed}

    if info OR aStats is NULL
        return BCM_ERR_INVAL_PARAMS


    cmdId is BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_FAC_ID, ETHSWT_FACMDID_STATS)

    retVal = HIPC_SendRecv(cmdId, (uint8_t*)cmdHdl.data, sizeof(ETHSWT_FAStatsType),
                                 (uint8_t *)&resp, sizeof(resp), &replyLen)

    if (BCM_ERR_OK is NOT retVal)
        goto done
    else if (BCM_ERR_OK != uswap32(resp.status))
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status))
        retVal = uswap32(resp.status);
        goto done;
    else if ((MGMT_STATUS_LEN + sizeof(ETHSWT_FAStatsType)) is NOT replyLen)
        HOST_Log("%s len:0x%x\n", __func__, replyLen)
        retVal = BCM_ERR_DATA_INTEG
        goto done
    else
        on Success copy the response
        copy respHdl.faStats to aStats

    done:
    return retVal;
    @endcode
*/
int32_t HOST_FAStats(MgmtInfoType *info,
                              ETHSWT_FAStatsType *aStats)
{
    int32_t              retVal = BCM_ERR_INVAL_PARAMS;
    ETHSWT_FAMsgUnionType cmdHdl;
    RPC_ResponseType     resp;
    ETHSWT_FAMsgUnionType respHdl;
    uint32_t             replyLen;
    uint32_t             cmdId;

    if ((NULL == info) || (NULL == aStats)) {
        HOST_Log("%s :: Invalid parameters info:%p aStats:%p\n", __FUNCTION__, info, aStats);
        goto done;
    }

    memset((uint8_t *)cmdHdl.data, 0, sizeof(cmdHdl));
    memset((uint8_t *)respHdl.data, 0, sizeof(respHdl));

    cmdId = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_FAC_ID, ETHSWT_FACMDID_STATS);

    retVal = HIPC_SendRecv(cmdId, (uint8_t*)cmdHdl.data, sizeof(ETHSWT_FAStatsType),
                               (uint8_t *)&resp, sizeof(resp), &replyLen);
    if (BCM_ERR_OK != retVal) {
        goto done;
    } else if (BCM_ERR_OK != uswap32(resp.status)) {
        retVal = uswap32(resp.status);
        goto done;
    } else if ((MGMT_STATUS_LEN + sizeof(ETHSWT_FAStatsType)) != replyLen) {
        retVal = BCM_ERR_DATA_INTEG;
        goto done;
    } else {
        memcpy((uint8_t*)&respHdl,&resp.payload[0], sizeof(ETHSWT_FAStatsType));
        aStats->hit = uswap32(respHdl.faStats.hit);
        aStats->miss = uswap32(respHdl.faStats.miss);
        aStats->snapFail = uswap32(respHdl.faStats.snapFail);
        aStats->etypeFail = uswap32(respHdl.faStats.etypeFail);
        aStats->versionFail = uswap32(respHdl.faStats.versionFail);
        aStats->fragFail = uswap32(respHdl.faStats.fragFail);
        aStats->protocolFail = uswap32(respHdl.faStats.protocolFail);
        aStats->checksumFail = uswap32(respHdl.faStats.checksumFail);
        aStats->optionsFail = uswap32(respHdl.faStats.optionsFail);
        aStats->headerLengthFail = uswap32(respHdl.faStats.headerLengthFail);
        aStats->intrFlags =  uswap32(respHdl.faStats.intrFlags);
        aStats->flowTableUsage = uswap32(respHdl.faStats.flowTableUsage);
        aStats->poolTableUsage =  uswap32(respHdl.faStats.poolTableUsage);
        aStats->nextHopTableUsage =  uswap32(respHdl.faStats.nextHopTableUsage);
        aStats->currentTimestamp =  uswap32(respHdl.faStats.currentTimestamp);
    }

done:
    return retVal;
}

/** Retrieve FA Flow Status

    This API retrieves status from Flow accelerator

    @trace #BRCM_SWARCH_HOST_FA_FLOW_STAUTS_PROC
    @trace #BRCM_SWREQ_HOST_FA_QUERY

    @code{.unparsed}

    if info OR aFlowStatus is NULL
        return BCM_ERR_INVAL_PARAMS


    cmdId is BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_FAC_ID, ETHSWT_FACMDID_FLOW_STATUS)

    cmdHdl.flowStatus.mstSlvDevice is aflowStatus->mstSlvDevice
    cmdHdl.flowStatus.attribute is uswap32(aFlowStatus->attribute)

    if ETHSWT_FAATTRIBUTE_MAC_USE is aFlowStatus->attribute
        memcpy(cmdHdl.flowStatus.mac, aFlowStatus->mac, 6UL)

    retVal = HIPC_SendRecv(cmdId, (uint8_t*)cmdHdl.data, sizeof(ETHSWT_FAFlowStatusDataType),
                               (uint8_t *)&resp, sizeof(resp), &replyLen);
    if (BCM_ERR_OK is not retVal)
        goto done
    else if (BCM_ERR_OK != uswap32(resp.status))
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status))
        retVal = uswap32(resp.status)
        goto done
    else if ((MGMT_STATUS_LEN + sizeof(ETHSWT_FAFlowStatusDataType)) is NOT replyLen)
        HOST_Log("%s len:0x%x\n", __func__, replyLen);
        retVal = BCM_ERR_DATA_INTEG
        goto done
    else
        on Success copy the response
        copy respHdl.flowStatus to aFlowStatus

    done:
    return retVal;
    @endcode
*/
int32_t HOST_FAFlowStatus(MgmtInfoType *info,
                                    ETHSWT_FAFlowStatusDataType *aFlowStatus)
{
    int32_t              retVal = BCM_ERR_INVAL_PARAMS;
    ETHSWT_FAMsgUnionType cmdHdl;
    RPC_ResponseType     resp;
    ETHSWT_FAMsgUnionType respHdl;
    uint32_t             replyLen;
    uint32_t             cmdId;

    if ((NULL == info) || (NULL == aFlowStatus)){
        HOST_Log("%s :: Invalid parameters info:%p aFlowStatus:%p\n", __FUNCTION__, info, aFlowStatus);
        goto done;
    }

    memset((uint8_t *)cmdHdl.data, 0, sizeof(cmdHdl));
    memset((uint8_t *)respHdl.data, 0, sizeof(respHdl));

    cmdId = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_FAC_ID, ETHSWT_FACMDID_FLOW_STATUS);

    cmdHdl.flowStatus.mstSlvDevice = uswap32(aFlowStatus->mstSlvDevice);
    cmdHdl.flowStatus.attribute = uswap32(aFlowStatus->attribute);
    if(ETHSWT_FAATTRIBUTE_MAC_USE == aFlowStatus->attribute) {
        memcpy(cmdHdl.flowStatus.mac, aFlowStatus->mac, 6UL);
    }

    retVal = HIPC_SendRecv(cmdId, (uint8_t*)cmdHdl.data, sizeof(ETHSWT_FAFlowStatusDataType),
                               (uint8_t *)&resp, sizeof(resp), &replyLen);
    if (BCM_ERR_OK != retVal) {
        goto done;
    } else if (BCM_ERR_OK != uswap32(resp.status)) {
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status));
        retVal = uswap32(resp.status);
        goto done;
    } else if ((MGMT_STATUS_LEN + sizeof(ETHSWT_FAFlowStatusDataType)) != replyLen) {
        HOST_Log("%s len:0x%x\n", __func__, replyLen);
        retVal = BCM_ERR_DATA_INTEG;
        goto done;
    } else {
        memcpy((uint8_t*)&respHdl,&resp.payload[0], sizeof(ETHSWT_FAFlowStatusDataType));
        aFlowStatus->attribute = uswap32(respHdl.flowStatus.attribute);
        aFlowStatus->mstSlvDevice = uswap32(respHdl.flowStatus.mstSlvDevice);
        memcpy(&aFlowStatus->mac, &respHdl.flowStatus.mac, 6UL);
        memcpy(&aFlowStatus->mask, &respHdl.flowStatus.mask,
                               sizeof(respHdl.flowStatus.mask));
    }
done:
    return retVal;
}

/** Add MAC Address

    This API will add a pool table entry

    @trace #BRCM_SWARCH_HOST_FAMACADD_PROC
    @trace #BRCM_SWREQ_HOST_FA_SET

    @code{.unparsed}

    if info OR aMacOp is NULL
        return BCM_ERR_INVAL_PARAMS


    cmdId = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_FAC_ID, ETHSWT_FACMDID_MAC_ADD)

    Get the MAC Snap shot
    retVal = HOST_FAMacSnapshotGet(info, &macSnapShot)

    if BCM_ERR_OK is NOT retVal
        goto done
    else
        check for the Other Group ID. The MAC ID to be validated if it exists in other Group
        if (0UL is aMacOp->mstSlvDevice)
            otherGroup =1UL
        else
            otherGroup =0UL

        Check if mac is already exists on  same Group
        for(i=0;i<ETHSWT_FA_POOL_MAX;i++) {
            if (0UL is memcmp(aMacOp->info.mac,&macSnapShot.info[aMacOp->mstSlvDevice][i].mac[0],6)) {
                retVal = BCM_ERR_OK;
                goto done
            }
        }

        Check if mac is already exists on different group
        If it found in different group then Report Error
        for(i=0;i<ETHSWT_FA_POOL_MAX;i++) {
            if (0UL == memcmp(aMacOp->info.mac,&macSnapShot.info[otherGroup][i].mac[0],6)) {
                retVal = BCM_ERR_INVAL_PARAMS;
                goto done;
            }
        }

        If the input MAC is 00:00:00:00:00:00 then use the  device MAC
        of the requested group to add
        if(0UL == memcmp(macZero,aMacOp->info.mac,6)) {
            memcpy(aMacOp->info.mac, &macSnapShot.deviceMac[aMacOp->mstSlvDevice][0U], 6UL);
        }

    copy aMacOp to aMacOpcmdHdl.macOperation
    retVal = HIPC_SendRecv(cmdId, (uint8_t*)cmdHdl.data,
             sizeof(ETHSWT_FAMacOperationType), (uint8_t *)&resp, sizeof(resp), &replyLen)
    if (BCM_ERR_OK != retVal)
        goto done
    else if (BCM_ERR_OK != uswap32(resp.status))
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status))
        retVal = uswap32(resp.status)
        goto done
    else if ((MGMT_STATUS_LEN + sizeof(ETHSWT_FAMacOperationType)) != replyLen)
        HOST_Log("%s len:0x%x\n", __func__, replyLen)
        retVal = BCM_ERR_DATA_INTEG
        goto done

    done:
    return retVal
    @endcode
*/
int32_t HOST_FAMacAdd(MgmtInfoType *info, ETHSWT_FAMacOperationType *aMacOp)
{
    int32_t              retVal = BCM_ERR_INVAL_PARAMS;
    ETHSWT_FAMsgUnionType cmdHdl;
    RPC_ResponseType     resp;
    ETHSWT_FAMsgUnionType respHdl;
    uint32_t             replyLen;
    uint32_t             cmdId;
    ETHSWT_FAMacSnapshotType macSnapShot;
    uint8_t              macZero[6U] = {0};
    int32_t              i;
    uint8_t              otherGroup;

    if ((NULL == info) || (NULL == aMacOp)) {
        HOST_Log("%s :: Invalid parameters info:%p aMacOp:%p\n", __FUNCTION__, info, aMacOp);
        goto done;
    }

    memset((uint8_t *)cmdHdl.data, 0, sizeof(cmdHdl));
    memset((uint8_t *)respHdl.data, 0, sizeof(respHdl));

    cmdId = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_FAC_ID, ETHSWT_FACMDID_MAC_ADD);

    retVal = HOST_FAMacSnapshotGet(info, &macSnapShot);
    if(BCM_ERR_OK != retVal) {
        goto done;
    } else {
        if(0UL == aMacOp->mstSlvDevice) {
            otherGroup =1UL;
        } else {
            otherGroup =0UL;
        }

        /* Check if mac is already exists on  same Group */
        for(i=0;i<ETHSWT_FA_POOL_MAX;i++) {
            if (0UL == memcmp(aMacOp->info.mac,&macSnapShot.info[aMacOp->mstSlvDevice][i].mac[0],6)) {
                retVal = BCM_ERR_CUSTOM;
                goto done;
            }
        }

        /* If more then one device found */
        if(0UL == memcmp(macZero,&macSnapShot.deviceMac[otherGroup][0U],6U)) {
            /* Check if mac is already exists on different group.
            If it found in different group then Report Error */
            for(i=0;i<ETHSWT_FA_POOL_MAX;i++) {
                if (0UL == memcmp(aMacOp->info.mac,&macSnapShot.info[otherGroup][i].mac[0],6)) {
                    retVal = BCM_ERR_INVAL_PARAMS;
                    goto done;
               }
            }
        }

        /* If the input MAC is 00:00:00:00:00:00 then use the  device MAC
        of the requested group to add */
        if(0UL == memcmp(macZero,aMacOp->info.mac,6)) {
            memcpy(aMacOp->info.mac, &macSnapShot.deviceMac[aMacOp->mstSlvDevice][0U], 6UL);
        }
    }
    cmdHdl.macOperation.mstSlvDevice = uswap32(aMacOp->mstSlvDevice);
    cmdHdl.macOperation.info.external = uswap32(aMacOp->info.external);
    memcpy(cmdHdl.macOperation.info.mac, aMacOp->info.mac, 6UL);
    HOST_Log("Adding MAC addr: %x:%x:%x:%x:%x:%x\n",
            (uint32_t)(aMacOp->info.mac[0]),
            (uint32_t)(aMacOp->info.mac[1]),
            (uint32_t)(aMacOp->info.mac[2]),
            (uint32_t)(aMacOp->info.mac[3]),
            (uint32_t)(aMacOp->info.mac[4]),
            (uint32_t)(aMacOp->info.mac[5]));
    retVal = HIPC_SendRecv(cmdId, (uint8_t*)cmdHdl.data,
             sizeof(ETHSWT_FAMacOperationType), (uint8_t *)&resp, sizeof(resp), &replyLen);
    if (BCM_ERR_OK != retVal) {
        goto done;
    } else if (BCM_ERR_OK != uswap32(resp.status)) {
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status));
        retVal = uswap32(resp.status);
        goto done;
    } else if ((MGMT_STATUS_LEN + sizeof(ETHSWT_FAMacOperationType)) != replyLen) {
        HOST_Log("%s len:0x%x\n", __func__, replyLen);
        retVal = BCM_ERR_DATA_INTEG;
        goto done;
    }
done:
    return retVal;
}

/** Delete MAC Address

    This API will will delete a pool table entry if it is no more referenced by any of the flows.

    @trace #BRCM_SWARCH_HOST_FAMACDELETE_PROC
    @trace #BRCM_SWREQ_HOST_FA_SET

    @code{.unparsed}

    if info OR aMacOp is NULL
        return BCM_ERR_INVAL_PARAMS


    cmdId = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_FAC_ID, ETHSWT_FACMDID_MAC_DELETE)

    copy aMacOp to aMacOpcmdHdl.macOperation
    retVal = HIPC_SendRecv(cmdId, (uint8_t*)cmdHdl.data,
             sizeof(ETHSWT_FAMacOperationType), (uint8_t *)&resp, sizeof(resp), &replyLen)
    if (BCM_ERR_OK != retVal)
        goto done
    else if (BCM_ERR_OK != uswap32(resp.status))
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status))
        retVal = uswap32(resp.status)
        goto done
    else if ((MGMT_STATUS_LEN + sizeof(ETHSWT_FAMacOperationType)) != replyLen)
        HOST_Log("%s len:0x%x\n", __func__, replyLen);
        retVal = BCM_ERR_DATA_INTEG
        goto done

    done:
    return retVal
    @endcode
*/
int32_t HOST_FAMacDelete(MgmtInfoType *info, ETHSWT_FAMacOperationType *aMacOp)
{
    int32_t              retVal = BCM_ERR_INVAL_PARAMS;
    ETHSWT_FAMsgUnionType cmdHdl;
    RPC_ResponseType     resp;
    ETHSWT_FAMsgUnionType respHdl;
    uint32_t             replyLen;
    uint32_t             cmdId;

    if ((NULL == info) || (NULL == aMacOp)) {
        HOST_Log("%s :: Invalid parameters info:%p aMacOp:%p\n", __FUNCTION__, info, aMacOp);
        goto done;
    }

    memset((uint8_t *)cmdHdl.data, 0, sizeof(cmdHdl));
    memset((uint8_t *)respHdl.data, 0, sizeof(respHdl));

    cmdId = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_FAC_ID, ETHSWT_FACMDID_MAC_DELETE);

    cmdHdl.macOperation.mstSlvDevice = uswap32(aMacOp->mstSlvDevice);
    memcpy(&cmdHdl.macOperation.info.mac[0], &aMacOp->info.mac[0], 6UL);
    HOST_Log("Deleting MAC addr: %x:%x:%x:%x:%x:%x\n",
            (uint32_t)(aMacOp->info.mac[0]),
            (uint32_t)(aMacOp->info.mac[1]),
            (uint32_t)(aMacOp->info.mac[2]),
            (uint32_t)(aMacOp->info.mac[3]),
            (uint32_t)(aMacOp->info.mac[4]),
            (uint32_t)(aMacOp->info.mac[5]));
    retVal = HIPC_SendRecv(cmdId, (uint8_t*)cmdHdl.data,
             sizeof(ETHSWT_FAMacOperationType), (uint8_t *)&resp, sizeof(resp), &replyLen);
    if (BCM_ERR_OK != retVal) {
        goto done;
    } else if (BCM_ERR_OK != uswap32(resp.status)) {
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status));
        retVal = uswap32(resp.status);
        goto done;
    } else if ((MGMT_STATUS_LEN + sizeof(ETHSWT_FAMacOperationType)) != replyLen) {
        HOST_Log("%s len:0x%x\n", __func__, replyLen);
        retVal = BCM_ERR_DATA_INTEG;
        goto done;
    }
done:
    return retVal;
}

/** Delete MAC Address by Force

    This API will try delete a pool table entry.
    If it found that the MAC is used by any Flow then this API Retreive the FLOW status
    curresponding to the MAC address. And from the FLOW status the flow will be deleted
    individuvally. After that MAC Address will be deleted. If the requested MAC Address
    is in Static then it can not be deleted.

    @trace #BRCM_SWARCH_HOST_FAMACFORCEDELETE_PROC
    @trace #BRCM_SWREQ_HOST_FA_SET

    @code{.unparsed}

    if info OR aMacOp is NULL
        return BCM_ERR_INVAL_PARAMS


    Try to delete the MAC
    retVal = HOST_FAMacDelete(info,aMacOp)

    if delete success then exit
    else get the Flow status

        -#get the flowstatus with ETHSWT_FAATTRIBUTE_MAC_USE
        retVal = HOST_FAFlowStatus(info, &flowStatus)
        -#copy the flowStatus.mask to usedMacMask. This will be used to compare
          with the static Mask
        memcpy(&usedMacMask, flowStatus.mask, sizeof(flowStatus.mask))
        -#get the flowstatus with ETHSWT_FAATTRIBUTE_STATIC for the same MAC group.
            retVal = HOST_FAFlowStatus(info, &flowStatus)
        -#copy the flowStatus.mask to usedStaticMacMask. This will be used to compare with the requested Mask.
          If match it can't be deleted.
            memcpy(&usedStaticMacMask, &flowStatus.mask, sizeof(flowStatus.mask))
        for(flow=0;flow<(ETHSWT_FA_FLOWS_MAX / 8UL);flow++) {
            -#Chek If static mask is set for the requested MAC. If it is set then report Error
            if(FALSE != (usedMacMask[flow] & usedStaticMacMask[flow]))
                retVal = BCM_ERR_BUSY
                goto done
            else if (FALSE != usedMacMask[flow]) {
                for (flowBit=0; flowBit<8UL; flowBit++) {
                    -#if the MAC is not in static then the flows can e deleted.
                    if(TRUE == ((usedMacMask[flow] >> flowBit) & 0x1U)) {
                        if flow identified
                            if group is 0
                                retVal = HOST_FAFlowDelete(info,(((flow * 8) + flowBit)))
                            else
                                retVal = HOST_FAFlowDelete(info,((flowStatus.mstSlvDevice << 16U) | ((flow * 8) + flowBit)))
                        if(BCM_ERR_OK != retVal)
                            goto done
                        }
                    }
                }
            } else {
                Do Nothing
            }
        }
        Delete  MAC After Successfull deleation of the Flow
        retVal = HOST_FAMacDelete(info,aMacOp);
    }
    done:
    return retVal
}
    @endcode
*/
int32_t HOST_FAMacForceDelete(MgmtInfoType *info, ETHSWT_FAMacOperationType *aMacOp)
{
    int32_t                retVal = BCM_ERR_INVAL_PARAMS;
    uint8_t                usedMacMask[ETHSWT_FA_FLOWS_MAX / 8UL];
    uint8_t                usedStaticMacMask[ETHSWT_FA_FLOWS_MAX / 8UL];
    int32_t                flow;
    int32_t                flowBit;
    int32_t                enForceDel = TRUE;
    ETHSWT_FAFlowStatusDataType flowStatus;

    if ((NULL == info) || (NULL == aMacOp)) {
        HOST_Log("%s :: Invalid parameters info:%p aMacOp:%p\n", __FUNCTION__, info, aMacOp);
        goto done;
    }

    retVal = HOST_FAMacDelete(info,aMacOp);
    if(BCM_ERR_OK == retVal) {
        goto done;
    } else {
        memcpy(flowStatus.mac, aMacOp->info.mac, 6UL);
        flowStatus.attribute = ETHSWT_FAATTRIBUTE_MAC_USE;
        flowStatus.mstSlvDevice = aMacOp->mstSlvDevice;
        retVal = HOST_FAFlowStatus(info, &flowStatus);
        if(BCM_ERR_OK != retVal) {
            goto done;
        }

        memcpy(&usedMacMask, flowStatus.mask, sizeof(flowStatus.mask));
        flowStatus.attribute = ETHSWT_FAATTRIBUTE_STATIC ;
        flowStatus.mstSlvDevice = aMacOp->mstSlvDevice;
        retVal = HOST_FAFlowStatus(info, &flowStatus);
        if(BCM_ERR_OK != retVal) {
            goto done;
        }

        memcpy(&usedStaticMacMask, &flowStatus.mask, sizeof(flowStatus.mask));
        for(flow=0;flow<(ETHSWT_FA_FLOWS_MAX / 8UL);flow++) {
            /* Chek if static mask is set for the requested MAC. If Set Exit*/
            if(0U != (usedMacMask[flow] & usedStaticMacMask[flow])){
                retVal = BCM_ERR_BUSY;
                enForceDel = FALSE;
                goto done;
            }
        }
        /* If It is not a MAC which is used by static Flow */
        if(TRUE == enForceDel) {
            for(flow=0;flow<(ETHSWT_FA_FLOWS_MAX / 8UL);flow++) {
                if (FALSE != usedMacMask[flow]){
                    for (flowBit=0; flowBit<8UL; flowBit++) {
                        if(TRUE == ((usedMacMask[flow] >> flowBit) & 0x1U)) {
                            retVal = HOST_FAFlowDelete(info,((flowStatus.mstSlvDevice << 16U) | ((flow * 8) + flowBit)));
                            /* If failed and the reason is not because of flow not dound */
                            if((BCM_ERR_OK != retVal) && (BCM_ERR_INVAL_PARAMS != retVal)) {
                                goto done;
                            }
                        }
                    }
                }
            }
        }
        /* Delete  MAC After Successfull deleation of the Flow */
        retVal = HOST_FAMacDelete(info,aMacOp);
    }
done:
    return retVal;
}

/** Get Snapshot of the pool table MAC addresses

    This API will retrieve Pool Table MAC addresses, their domain(internal/
    external) and their usage as a bitmask of flow IDs

    @trace #BRCM_SWARCH_HOST_FAMACSNAPSHOTGET_PROC
    @trace #BRCM_SWREQ_HOST_FA_QUERY

    @code{.unparsed}

    if info OR aMacSnapShot is NULL
        return BCM_ERR_INVAL_PARAMS


    cmdId = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_FAC_ID, ETHSWT_FACMDID_MAC_SNAPSHOT)

    retVal = HIPC_SendRecv(cmdId, (uint8_t*)cmdHdl.data,
             sizeof(ETHSWT_FAMacSnapshotType), (uint8_t *)&resp, sizeof(resp), &replyLen)
    if (BCM_ERR_OK is NOT retVal)
        goto done
    else if (BCM_ERR_OK != uswap32(resp.status))
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status))
        retVal = uswap32(resp.status)
        goto done
    else if ((MGMT_STATUS_LEN + sizeof(ETHSWT_FAMacSnapshotType)) is NOT replyLen)
        HOST_Log("%s len:0x%x\n", __func__, replyLen)
        retVal = BCM_ERR_DATA_INTEG;
        goto done
    else
        copy response to the aMacSnapShot

    done:
    return retVal;
    @endcode
*/
int32_t HOST_FAMacSnapshotGet(MgmtInfoType *info,
                                   ETHSWT_FAMacSnapshotType *aMacSnapShot)
{
    int32_t              retVal = BCM_ERR_INVAL_PARAMS;
    uint8_t              macZero[6U] = {0};
    ETHSWT_FAMsgUnionType  cmdHdl;
    RPC_ResponseType     resp;
    ETHSWT_FAMsgUnionType  respHdl;
    uint32_t             replyLen;
    uint32_t             cmdId;
    uint32_t             i;

    if ((NULL == info) || (NULL == aMacSnapShot)) {
        HOST_Log("%s :: Invalid parameters info:%p aMacSnapShot:%p\n", __FUNCTION__, info, aMacSnapShot);
        goto done;
    }

    memset((uint8_t *)cmdHdl.data, 0, sizeof(cmdHdl));
    memset((uint8_t *)respHdl.data, 0, sizeof(respHdl));

    cmdId = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_FAC_ID, ETHSWT_FACMDID_MAC_SNAPSHOT);

    retVal = HIPC_SendRecv(cmdId, (uint8_t*)cmdHdl.data,
             sizeof(ETHSWT_FAMacSnapshotType), (uint8_t *)&resp, sizeof(resp), &replyLen);
    if (BCM_ERR_OK != retVal) {
        goto done;
    } else if (BCM_ERR_OK != uswap32(resp.status)) {
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status));
        retVal = uswap32(resp.status);
        goto done;
    } else if ((MGMT_STATUS_LEN + sizeof(ETHSWT_FAMacSnapshotType)) != replyLen) {
        HOST_Log("%s len:0x%x\n", __func__, replyLen);
        retVal = BCM_ERR_DATA_INTEG;
        goto done;
    } else {
        memcpy((uint8_t*)&respHdl,&resp.payload[0],replyLen);
        memcpy(&aMacSnapShot->info[0], &respHdl.macSnapshot.info[0], sizeof(aMacSnapShot->info[0]));
        memcpy(&aMacSnapShot->deviceMac[0U][0U], &respHdl.macSnapshot.deviceMac[0U][0U], 6UL);
        for (i = 0UL; i < ETHSWT_FA_POOL_MAX; i++) {
            aMacSnapShot->info[0U][i].external = respHdl.macSnapshot.info[0U][i].external;
        }
        if(0UL != memcmp(macZero,&respHdl.macSnapshot.deviceMac[1U][0U],6U)) {
            memcpy(&aMacSnapShot->info[1], &respHdl.macSnapshot.info[1], sizeof(aMacSnapShot->info[1]));
            memcpy(&aMacSnapShot->deviceMac[1U][0U], &respHdl.macSnapshot.deviceMac[1U][0U], 6UL);
            for (i = 0UL; i < ETHSWT_FA_POOL_MAX; i++) {
                aMacSnapShot->info[1U][i].external = respHdl.macSnapshot.info[1U][i].external;
            }

        }
    }
done:
    return retVal;
}

/** Reset the FA

    This API will De-Initialize and Initialize the FA with the
    Provided configuration as an argument

    @trace #BRCM_SWARCH_HOST_FARESET_PROC
    @trace #BRCM_SWREQ_HOST_FA_SET

    @code{.unparsed}

    if info OR ctcfCfg is NULL
        return BCM_ERR_INVAL_PARAMS


     copy ctcfCfg to cmdHdl.ctfCfg

    cmdId = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_FAC_ID, ETHSWT_FACMDID_RESET)


    retVal = HIPC_SendRecv(cmdId, (uint8_t*)cmdHdl.data,
             sizeof(ETHSWT_FACtfCfgType), (uint8_t *)&resp, sizeof(resp), &replyLen)
    if (BCM_ERR_OK is NOT retVal)
        goto done
    else if (BCM_ERR_OK is NOT uswap32(resp.status))
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status))
        retVal = uswap32(resp.status)
        goto done
    else if ((MGMT_STATUS_LEN + sizeof(ETHSWT_FACtfCfgType)) is NOT replyLen)
        HOST_Log("%s len:0x%x\n", __func__, replyLen);
        retVal = BCM_ERR_DATA_INTEG
        goto done

    done:
    return retVal
    @endcode
*/
int32_t HOST_FAReset(MgmtInfoType *info, ETHSWT_FACtfCfgType *ctcfCfg)
{
    int32_t              retVal = BCM_ERR_INVAL_PARAMS;
    ETHSWT_FAMsgUnionType cmdHdl;
    RPC_ResponseType     resp;
    ETHSWT_FAMsgUnionType respHdl;
    uint32_t             replyLen;
    uint32_t             cmdId;

    if ((NULL == info) || (NULL == ctcfCfg)){
        HOST_Log("%s :: Invalid parameters info:%p ctcfCfg:%p\n", __FUNCTION__, info, ctcfCfg);
        goto done;
    }

    memset((uint8_t *)cmdHdl.data, 0, sizeof(cmdHdl));
    memset((uint8_t *)respHdl.data, 0, sizeof(respHdl));

    cmdHdl.ctfCfg.mode               = ctcfCfg->mode;
    cmdHdl.ctfCfg.crc                = ctcfCfg->crc;
    cmdHdl.ctfCfg.seedValue          = uswap16(ctcfCfg->seedValue);
    cmdHdl.ctfCfg.timestampPeriodSec = uswap32(ctcfCfg->timestampPeriodSec);
    cmdHdl.ctfCfg.validateMatchDA    = uswap32(ctcfCfg->validateMatchDA);

    cmdId = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_FAC_ID, ETHSWT_FACMDID_RESET);

    retVal = HIPC_SendRecv(cmdId, (uint8_t*)cmdHdl.data,
             sizeof(ETHSWT_FACtfCfgType), (uint8_t *)&resp, sizeof(resp), &replyLen);
    if (BCM_ERR_OK != retVal) {
        goto done;
    } else if (BCM_ERR_OK != uswap32(resp.status)) {
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status));
        retVal = uswap32(resp.status);
        goto done;
    } else if ((MGMT_STATUS_LEN + sizeof(ETHSWT_FACtfCfgType)) != replyLen) {
        HOST_Log("%s len:0x%x\n", __func__, replyLen);
        retVal = BCM_ERR_DATA_INTEG;
        goto done;
    }
done:
    return retVal;
}

/** Enable Interrupt For the FA

    This API will set the Interrupt Flags of #ETHSWT_FAIntrFlagsType

    @trace #BRCM_SWARCH_HOST_FAENABLEINTERRUPT_PROC
    @trace #BRCM_SWREQ_HOST_FA_SET

    @code{.unparsed}

    if info is NULL
        return BCM_ERR_INVAL_PARAMS


    copy flags to intFlag

    cmdId = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_FAC_ID, ETHSWT_FACMDID_INTERRUPT_ENABLE)

    retVal = HIPC_SendRecv(cmdId, (uint8_t*)cmdHdl.data,
             sizeof(ETHSWT_FAIntrFlagsType), (uint8_t *)&resp, sizeof(resp), &replyLen)
    if (BCM_ERR_OK != retVal)
        goto done;
    else if (BCM_ERR_OK is NOT uswap32(resp.status))
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status))
        retVal = uswap32(resp.status)
        goto done
    else if ((MGMT_STATUS_LEN + sizeof(ETHSWT_FAIntrFlagsType)) is NOT replyLen)
        HOST_Log("%s len:0x%x\n", __func__, replyLen)
        retVal = BCM_ERR_DATA_INTEG
        goto done

    done:
    return retVal
    @endcode
*/
int32_t HOST_FAEnableInterrupt(MgmtInfoType *info, ETHSWT_FAIntrFlagsType flags)
{
    int32_t              retVal = BCM_ERR_INVAL_PARAMS;
    ETHSWT_FAMsgUnionType cmdHdl;
    RPC_ResponseType     resp;
    ETHSWT_FAMsgUnionType respHdl;
    uint32_t             replyLen;
    uint32_t             cmdId;
    ETHSWT_FAIntrFlagsType intFlag;

    if (NULL == info) {
        HOST_Log("%s :: MgmtInfoType pointer is NULL\n", __FUNCTION__);
        goto done;
    }

    memset((uint8_t *)cmdHdl.data, 0, sizeof(cmdHdl));
    memset((uint8_t *)respHdl.data, 0, sizeof(respHdl));

    cmdId = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_FAC_ID, ETHSWT_FACMDID_INTERRUPT_ENABLE);
    intFlag = uswap32(flags);

    cmdHdl.intrFlags = intFlag;
    retVal = HIPC_SendRecv(cmdId, (uint8_t*)cmdHdl.data,
             sizeof(ETHSWT_FAIntrFlagsType), (uint8_t *)&resp, sizeof(resp), &replyLen);
    if (BCM_ERR_OK != retVal) {
        goto done;
    } else if (BCM_ERR_OK != uswap32(resp.status)) {
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status));
        retVal = uswap32(resp.status);
        goto done;
    } else if ((MGMT_STATUS_LEN + sizeof(ETHSWT_FAIntrFlagsType)) != replyLen) {
        HOST_Log("%s len:0x%x\n", __func__, replyLen);
        retVal = BCM_ERR_DATA_INTEG;
        goto done;
    }
done:
    return retVal;
}

/** @} */
