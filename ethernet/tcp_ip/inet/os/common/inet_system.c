/*****************************************************************************
 Copyright 2019-2022 Broadcom Limited.  All rights reserved.

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
    @addtogroup grp_inet_il
    @{

    @file inet_system.c
    @brief System integration of Internet Stack

    @version 0.1 Initial version
*/

#include <atomic.h>
#include <bcm_err.h>
#include <bcm_utils.h>
#include <system.h>
#include <inet_cfg.h>
#include <inet_osil.h>
#include <dhcp.h>
#include <dhcp_osil.h>

/**
    @name INET Library Design IDs
    @{
    @brief Design IDs for INET IL
 */
#define BRCM_SWDSGN_INET_COMPIL_TYPE                         (0xA201U)    /**< @brief #INET_COMPILType                  */
#define BRCM_SWDSGN_INET_CONNCFG_GLOBAL                      (0xA202U)    /**< @brief #INET_ConnCfg                     */
#define BRCM_SWDSGN_INET_OSILHANDLE_PROC                     (0xA203U)    /**< @brief #INET_OSILHandle                  */
#define BRCM_SWDSGN_INET_ADDARPENTRY_PROC                    (0xA204U)    /**< @brief #INET_AddARPEntry                 */
#define BRCM_SWDSGN_INET_BUFFERAVAILABLEINDICATION_PROC      (0xA205U)    /**< @brief #INET_BufferAvailableIndication   */
#define BRCM_SWDSGN_INET_BUFFERAVAILABLEONCONTROLLER_PROC    (0xA206U)    /**< @brief #INET_BufferAvailableOnController */
#define BRCM_SWDSGN_INET_CLIENTACKREASSBUF_PROC              (0xA207U)    /**< @brief #INET_ClientAckReassBuf           */
#define BRCM_SWDSGN_INET_FINDARPENTRY_PROC                   (0xA208U)    /**< @brief #INET_FindARPEntry                */
#define BRCM_SWDSGN_INET_FREEREASSEMBLYBUFFER_PROC           (0xA209U)    /**< @brief #INET_FreeReassemblyBuffer        */
#define BRCM_SWDSGN_INET_GETENDPOINT_PROC                    (0xA20AU)    /**< @brief #INET_GetEndPoint                 */
#define BRCM_SWDSGN_INET_GETINTERFACE_PROC                   (0xA20BU)    /**< @brief #INET_GetInterface                */
#define BRCM_SWDSGN_INET_GETINTERFACECOUNT_PROC              (0xA20CU)    /**< @brief #INET_GetInterfaceCount           */
#define BRCM_SWDSGN_INET_GETINTERFACEFORENDPOINT_PROC        (0xA20DU)    /**< @brief #INET_GetInterfaceForEndPoint     */
#define BRCM_SWDSGN_INET_GETREASSEMBLYBUFFER_PROC            (0xA20EU)    /**< @brief #INET_GetReassemblyBuffer         */
#define BRCM_SWDSGN_INET_INIT_PROC                           (0xA20FU)    /**< @brief #INET_Init                        */
#define BRCM_SWDSGN_INET_PROCESSTIMERS_PROC                  (0xA210U)    /**< @brief #INET_ProcessTimers               */
#define BRCM_SWDSGN_INET_REMOVEARPENTRY_PROC                 (0xA211U)    /**< @brief #INET_RemoveARPEntry              */
#define BRCM_SWDSGN_INET_REPORTERROR_PROC                    (0xA212U)    /**< @brief #INET_ReportError                 */
#define BRCM_SWDSGN_INET_SEARCHINTERFACE_PROC                (0xA213U)    /**< @brief #INET_SearchInterface             */
#define BRCM_SWDSGN_INET_TXPKTCONFIRMATION_PROC              (0xA214U)    /**< @brief #INET_TxPktConfirmation           */
#define BRCM_SWDSGN_INET_UDPRECEIVEINDICATION_PROC           (0xA215U)    /**< @brief #INET_UDPReceiveIndication        */
#define BRCM_SWDSGN_INET_UPDATEREASSEMBLYBUFFER_PROC         (0xA216U)    /**< @brief #INET_UpdateReassemblyBuffer      */
#define BRCM_SWDSGN_INET_UPDATEINTERFACE_PROC                (0xA217U)    /**< @brief #INET_UpdateInterface             */
#define BRCM_SWDSGN_INET_SETENDPOINTINTERFACE_PROC           (0xA218U)    /**< @brief #INET_SetEndPointInterface        */
#define BRCM_SWDSGN_INET_ALLOCATEEPHEMERALPORT_PROC          (0xA219U)    /**< @brief #INET_AllocateEphemeralPort       */
#define BRCM_SWDSGN_INET_SETENDPOINTLOCALPORT_PROC           (0xA21AU)    /**< @brief #INET_SetEndPointLocalPort        */
#define BRCM_SWDSGN_INET_TCPRECEIVEINDICATION_PROC           (0xA21BU)    /**< @brief #INET_TCPReceiveIndication        */
#define BRCM_SWDSGN_INET_TCPRESETENDPOINT_PROC               (0xA21CU)    /**< @brief #INET_TCPResetEndPoint            */
#define BRCM_SWDSGN_INET_TCPPROCESSCTRLMSGS_PROC             (0xA21DU)    /**< @brief #INET_TCPProcessCtrlMsgs          */
/** @} */

/**
    @brief The structure used by INET OSIL for maintaining its internal
    variables and stats.

    @trace #BRCM_SWARCH_INET_PROCESSTIMERS_PROC
    @trace #BRCM_SWREQ_INET
*/
typedef struct sINET_COMPILType {
    uint64_t lastProcTime;      /**< @brief Variable to track the last time at which
                                     this timer was invoked */
    uint32_t inetTxConfCount;   /**< @brief Counter to track the number of Tx
                                     confirmations received */
    uint32_t inetBufTimeout;    /**< @brief Counter to track the number of
                                     reassembly buffer timeouts */
    INET_PortType currentFreeEphemeralPort; /**< @brief Tracks the next free ephemeral port */
} INET_COMPILType;

/**
    @trace #BRCM_SWARCH_INET_CONFIG_MACRO
    @trace #BRCM_SWREQ_INET
*/
static const INET_CfgType* const INET_ConnCfg = &INET_Config;

/**
    @trace #BRCM_SWARCH_INET_PROCESSTIMERS_PROC
    @trace #BRCM_SWREQ_INET
*/
static INET_COMPILType INET_OSILHandle;

/**
    @trace #BRCM_SWARCH_INET_GETINTERFACE_PROC
    @trace #BRCM_SWARCH_INET_GETINTERFACEFORENDPOINT_PROC
    @trace #BRCM_SWARCH_INET_GETENDPOINT_PROC
    @trace #BRCM_SWARCH_INET_UDPRECEIVEINDICATION_PROC
    @trace #BRCM_SWARCH_INET_SEARCHINTERFACE_PROC
    @trace #BRCM_SWARCH_INET_ADDARPENTRY_PROC
    @trace #BRCM_SWARCH_INET_FINDARPENTRY_PROC
    @trace #BRCM_SWARCH_INET_REMOVEARPENTRY_PROC
    @trace #BRCM_SWARCH_INET_GETREASSEMBLYBUFFER_PROC
    @trace #BRCM_SWARCH_INET_UPDATEREASSEMBLYBUFFER_PROC
    @trace #BRCM_SWARCH_INET_FREEREASSEMBLYBUFFER_PROC
    @trace #BRCM_SWREQ_INET
*/
static void INET_ReportError(uint16_t aApiID, int32_t aErr, uint32_t aVal0,
                            uint32_t aVal1, uint32_t aVal2, uint32_t aVal3)
{
#ifndef ULOG
    const uint32_t values[4UL] = {aVal0, aVal1, aVal2, aVal3};
    BCM_ReportError(BCM_NET_ID, 0x0U, aApiID,
                    aErr, 4UL, values);
#endif
}

/**
    @trace #BRCM_SWARCH_INET_INIT_PROC
    @trace #BRCM_SWREQ_INET
*/
void INET_Init(void)
{
    uint32_t idx = 0UL;
    uint32_t cnt = 0UL;
    int32_t  retVal;
    uint64_t currTime;

    /* Capture time for INET timer handling */
    currTime = BCM_GetTimeNs();

    BCM_MemSet(&INET_OSILHandle, 0U, sizeof(INET_COMPILType));
    INET_OSILHandle.currentFreeEphemeralPort = INET_PORT_EPHEMERAL_START;

    for (idx = 0UL; idx < INET_ConnCfg->reassBufCount; idx++) {
        const INET_ReassemblyBufferType * const reassPtr = INET_ConnCfg->reassBufferPool[idx];
        BCM_MemSet(reassPtr->params, 0U, sizeof(INET_ReassRWParamsType));
        reassPtr->params->bufState  = INET_REASSBUFSTATE_FREE;
        reassPtr->params->clientEndPtID = INET_ENDPOINTID_INVALID;
        retVal = CIRCQ_Reset(reassPtr->fragmentQ);
        if (BCM_ERR_OK != retVal) {
            INET_ReportError(BRCM_SWARCH_INET_INIT_PROC, retVal, idx,
                             __LINE__, 0UL, 0UL);
        }
    }

    for (idx = 0UL; idx < INET_ConnCfg->intfCount; idx++) {
        const INET_SystemInterfaceType * const intf = INET_ConnCfg->interfaces[idx];
        intf->ifCtxt->ifID = idx;
        intf->ifCtxt->nifCtrlIdx = NIF_CNTRLIDTYPE_INVALID;
        intf->ifCtxt->lastARPProcTime = currTime;
        BCM_MemSet(&intf->ifCtxt->stats, 0U, sizeof(INET_InterfaceStatsType));

        /* Check that two interfaces are not using the same static IP address */
        if (INET_IPADDRESSASSIGNMENT_STATIC ==
                        INET_ConnCfg->interfaces[idx]->ifCtxt->cfg.addressType) {
            for (cnt = 0UL; cnt < INET_ConnCfg->intfCount; cnt++) {
                if ((idx != cnt) &&
                    (INET_IPADDRESSASSIGNMENT_STATIC ==
                            INET_ConnCfg->interfaces[cnt]->ifCtxt->cfg.addressType) &&
                    (INET_ConnCfg->interfaces[idx]->ifCtxt->cfg.ipAddress ==
                            INET_ConnCfg->interfaces[cnt]->ifCtxt->cfg.ipAddress)) {
                    INET_ReportError(BRCM_SWARCH_INET_INIT_PROC, BCM_ERR_NOSUPPORT, idx,
                                     cnt, INET_ConnCfg->interfaces[idx]->ifCtxt->cfg.ipAddress,
                                     INET_ConnCfg->intfCount);
                }
            }
        }
    }

    for (idx = 0UL; idx < INET_ConnCfg->endPtCount; idx++) {
        const INET_SystemEndPointType * const endPt = INET_ConnCfg->endPoints[idx];
        retVal = CIRCQ_Reset(endPt->endPtObj.rxPktQ);
        if (BCM_ERR_OK != retVal) {
            INET_ReportError(BRCM_SWARCH_INET_INIT_PROC, retVal, idx,
                             0UL, 0UL, 0UL);
        }

        /* Check for duplicate UDP ports on same interface */
        for (cnt = 0UL; cnt < INET_ConnCfg->endPtCount; cnt++) {
            if ((idx != cnt) &&
                (0UL != INET_ConnCfg->endPoints[idx]->endPtObj.ctxt->endPtCfg.localPort) &&
                (INET_ConnCfg->endPoints[idx]->endPtObj.ctxt->intfId ==
                            INET_ConnCfg->endPoints[cnt]->endPtObj.ctxt->intfId) &&
                (INET_ConnCfg->endPoints[idx]->endPtObj.ctxt->endPtCfg.localPort ==
                            INET_ConnCfg->endPoints[cnt]->endPtObj.ctxt->endPtCfg.localPort)) {
                INET_ReportError(BRCM_SWARCH_INET_INIT_PROC, BCM_ERR_NOSUPPORT, idx,
                                 cnt, INET_ConnCfg->endPoints[idx]->endPtObj.ctxt->intfId,
                                 INET_ConnCfg->endPoints[idx]->endPtObj.ctxt->endPtCfg.localPort);
            }
        }
    }

    INET_OSILHandle.lastProcTime = currTime;

    /* Will be implemented after ethernet driver adds callback to */
    /* notify link up notification                                */
    return;
}

/**
    @trace #BRCM_SWARCH_INET_UPDATEINTERFACE_PROC
    @trace #BRCM_SWREQ_INET
*/
int32_t INET_UpdateInterface(INET_InterfaceIdType aIntfID,
                             INET_IPAddressAssignmentType aAddrType,
                             INET_IPAddressType aIntfIPAddr,
                             INET_NetmaskType aIntfNetmask,
                             INET_IPAddressType aIntfGatewayIP,
                             const INET_InterfaceVlanTagConfigType *const aIntfParams)
{
    int32_t retVal = BCM_ERR_OK;
    uint32_t intfCount = 0UL;
    INET_InterfaceStateType *intfObj = NULL;
    uint32_t cnt;
    INET_GetInterfaceCount(&intfCount);

    if ((aIntfID >= intfCount)  ||
        ((INET_IPADDRESSASSIGNMENT_STATIC != aAddrType) &&
         (INET_IPADDRESSASSIGNMENT_DYNAMIC != aAddrType)) ||
        (NULL == aIntfParams)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        retVal = INET_GetInterface(aIntfID, &intfObj);
        if ((BCM_ERR_OK == retVal) && (NULL != intfObj)) {
            /* Check if the IP address is already used by any interface */
            if (INET_IPADDRESS_INVALID != aIntfIPAddr) {
                for (cnt = 0UL; cnt < INET_ConnCfg->intfCount; cnt++) {
                    if ((aIntfID != INET_ConnCfg->interfaces[cnt]->ifCtxt->ifID) &&
                        (aIntfIPAddr == INET_ConnCfg->interfaces[cnt]->ifCtxt->cfg.ipAddress) &&
                        /* Two interfaces with different VLAN is allowed */
                        (aIntfParams->vlan == INET_ConnCfg->interfaces[cnt]->ifCtxt->cfg.vlanConfig.vlan)) {
                        retVal = BCM_ERR_NOPERM;
                        break;
                    }
                }
            }

            /* Update only if its a non-duplicate IP address */
            if (BCM_ERR_OK == retVal) {
                intfObj->cfg.addressType = aAddrType;
                intfObj->cfg.vlanConfig.pcp = aIntfParams->pcp;
                intfObj->cfg.vlanConfig.vlan = aIntfParams->vlan;
                intfObj->cfg.ipAddress = aIntfIPAddr;
                intfObj->cfg.netmask = aIntfNetmask;
                intfObj->cfg.defaultRoute = aIntfGatewayIP;
                retVal = NIF_GetCtrlIdx(intfObj->cfg.vlanConfig.vlan,
                                    BCM_NET_ID,
                                    0U,
                                    &intfObj->nifCtrlIdx);
            }
        }
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_INET_SETENDPOINTINTERFACE_PROC
    @trace #BRCM_SWREQ_INET
*/
int32_t INET_SetEndPointInterface(const BCM_CompIDType aCompId,
                                  const uint32_t aPayloadId,
                                  INET_InterfaceIdType aIntfID)
{
    int32_t retVal = BCM_ERR_OK;
    uint32_t intfCount = 0UL;
    uint32_t cnt;
    INET_EndPointIdType endPtIndex;
    const INET_EndPointObjectType *endPointObj;

    INET_GetInterfaceCount(&intfCount);

    if ((0UL == aCompId) || (aIntfID >= intfCount)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        retVal = INET_GetEndPoint(aCompId, aPayloadId,
                                  &endPtIndex, &endPointObj);
        if ((BCM_ERR_OK == retVal) && (NULL != endPointObj)) {
            /* It is possible that a UDP port can be bound to EP when tagged to a different */
            /* interface. Later if its remapped to another interface, we need to check that */
            /* the UDP end point port number is unique on the newer interface               */
            for (cnt = 0UL; cnt < INET_ConnCfg->endPtCount; cnt++) {
                /* Check if any other end points on aIntfID uses same UDP port number */
                if ((aIntfID == INET_ConnCfg->endPoints[cnt]->endPtObj.ctxt->intfId) &&
                    (INET_PORT_INVALID != endPointObj->ctxt->endPtCfg.localPort) &&
                    (endPointObj->ctxt->endPtCfg.localPort ==
                                INET_ConnCfg->endPoints[cnt]->endPtObj.ctxt->endPtCfg.localPort) &&
                    !((aCompId == INET_ConnCfg->endPoints[cnt]->compId) &&
                                (aPayloadId == INET_ConnCfg->endPoints[cnt]->payloadId))) {
                    retVal = BCM_ERR_NOPERM;
                    break;
                }
            }
            if (BCM_ERR_OK == retVal) {
                endPointObj->ctxt->intfId = aIntfID;
            }
        }
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_INET_GETINTERFACECOUNT_PROC
    @trace #BRCM_SWREQ_INET
*/
void INET_GetInterfaceCount(uint32_t* const aIntfCount)
{
    *aIntfCount = INET_ConnCfg->intfCount;
    return;
}

/**
    @trace #BRCM_SWARCH_INET_GETINTERFACE_PROC
    @trace #BRCM_SWREQ_INET
*/
int32_t INET_GetInterface(const INET_InterfaceIdType aIntfId,
                          INET_InterfaceStateType** const aIntfObj)
{
    int32_t retVal;

    if ((NULL == aIntfObj) || (aIntfId >= INET_ConnCfg->intfCount)) {
        retVal = BCM_ERR_INVAL_PARAMS;
        INET_ReportError(BRCM_SWARCH_INET_GETINTERFACE_PROC, retVal, aIntfId,
                         0UL, 0UL, 0UL);
    } else {
        retVal = BCM_ERR_OK;
        *aIntfObj = INET_ConnCfg->interfaces[aIntfId]->ifCtxt;
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_INET_GETINTERFACEFORENDPOINT_PROC
    @trace #BRCM_SWREQ_INET
*/
int32_t INET_GetInterfaceForEndPoint(const INET_EndPointIdType aEndPointId,
                                     INET_InterfaceStateType** const aIntfObj)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    if ((NULL == aIntfObj) || (aEndPointId >= INET_ConnCfg->endPtCount)) {
        retVal = BCM_ERR_INVAL_PARAMS;
        INET_ReportError(BRCM_SWARCH_INET_GETINTERFACEFORENDPOINT_PROC, retVal,
                        (uint32_t)aEndPointId, (uint32_t)aIntfObj, 0UL, 0UL);
    } else {
        INET_InterfaceIdType intfID;
        intfID = INET_ConnCfg->endPoints[aEndPointId]->endPtObj.ctxt->intfId;
        /* Check that the end point is mapped to a valid interface */
        if (INET_INTERFACEID_INVALID != intfID) {
            *aIntfObj = INET_ConnCfg->interfaces[intfID]->ifCtxt;
            retVal = BCM_ERR_OK;
        }
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_INET_GETENDPOINT_PROC
    @trace #BRCM_SWREQ_INET
*/
int32_t INET_GetEndPoint(const BCM_CompIDType aCompId,
                         const uint32_t aPayloadId,
                         INET_EndPointIdType* const aEndPtIndex,
                         const INET_EndPointObjectType** const aEndPointObj)
{
    int32_t  retVal;
    uint32_t i;

    if ((NULL == aEndPointObj) || (NULL == aEndPtIndex)){
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        retVal = BCM_ERR_NOT_FOUND;
        for (i = 0UL; i < INET_ConnCfg->endPtCount; ++i) {
            if ((INET_ConnCfg->endPoints[i]->compId == aCompId) &&
                (INET_ConnCfg->endPoints[i]->payloadId == aPayloadId)) {
                *aEndPtIndex = (INET_EndPointIdType)i;
                *aEndPointObj  = &INET_ConnCfg->endPoints[i]->endPtObj;
                retVal = BCM_ERR_OK;
                break;
            }
        }
    }

    if (BCM_ERR_OK != retVal) {
        INET_ReportError(BRCM_SWARCH_INET_GETENDPOINT_PROC, retVal,
                        (uint32_t)aCompId, aPayloadId, (uint32_t)aEndPointObj,
                        __LINE__);
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_INET_UDPRECEIVEINDICATION_PROC
    @trace #BRCM_SWREQ_INET
*/
int32_t INET_UDPReceiveIndication(const INET_IPAddressType aSrcAddr,
                                  const INET_PortType aSrcPort,
                                  const INET_PortType aDestPort,
                                  const INET_L4ProtoType aL4Protocol,
                                  const uint8_t* const aBuf,
                                  const uint16_t aLen,
                                  INET_InterfaceIdType aIntfId)
{
    int32_t                       retVal = BCM_ERR_NOT_FOUND;
    int32_t                       ret;
    const INET_SystemEndPointType *sysEndPtObj = NULL;
    INET_ReassRWParamsType        *reassBufParams = NULL;
    INET_EndPointIdType           endPtIndex;
    uint32_t                      lineNum = 0UL;
    uint32_t                      i;
    uint64_t                      currTime;

    for (i = 0UL; i < INET_ConnCfg->endPtCount; ++i) {
        /* Search for the end point which matches the protocol and local port */
        /* We do not match for the remote IP address and port for server kind */
        /* of application where an end point can receive data from multiple   */
        /* remote clients. The local address is not matched here as it is     */
        /* assumed to have been checked at reception.                         */
        if ((aIntfId == INET_ConnCfg->endPoints[i]->endPtObj.ctxt->intfId) &&
            (INET_ConnCfg->endPoints[i]->endPtObj.l4Proto == aL4Protocol) &&
            (INET_ConnCfg->endPoints[i]->endPtObj.ctxt->endPtCfg.localPort == aDestPort)) {
            endPtIndex = (INET_EndPointIdType)i;
            sysEndPtObj  = INET_ConnCfg->endPoints[i];
            retVal = BCM_ERR_OK;
            break;
        }
    }

    if (BCM_ERR_OK == retVal) {
        INET_RxPktType pkt = {.buffer = aBuf,
                              .length = aLen,
                              .srcIPAddr = aSrcAddr,
                              .srcPort = aSrcPort};

        if (aLen > INET_MAX_REASS_BUF_SIZE) {
            /* The length parameter here is the length of the complete */
            /* payload. However there might be a limited reassembly    */
            /* buffer which is not sufficient to contain the complete  */
            /* payload in which case the payload gets truncated        */
            pkt.length = INET_MAX_REASS_BUF_SIZE;
            /* Update statistics */
            sysEndPtObj->endPtObj.ctxt->stats.rxTruncPkts++;
            /* Report error */
            INET_ReportError(BRCM_SWARCH_INET_UDPRECEIVEINDICATION_PROC, BCM_ERR_OK,
                            (uint32_t)aLen, aSrcAddr, (uint32_t)aSrcPort,
                            (uint32_t)aL4Protocol);
        }

        /* Store the buffer and length in the receive queue */
        retVal = CIRCQ_Push(sysEndPtObj->endPtObj.rxPktQ,
                           (const char*) &pkt, 1UL);
        if (BCM_ERR_OK == retVal){
            for (i = 0UL ; i < INET_ConnCfg->reassBufCount; ++i) {
                if ((aBuf == INET_ConnCfg->reassBufferPool[i]->buffer) &&
                    (INET_REASSBUFSTATE_FREE != INET_ConnCfg->reassBufferPool[i]->params->bufState)) {
                    reassBufParams = INET_ConnCfg->reassBufferPool[i]->params;
                    break;
                }
            }
            if (NULL != reassBufParams ){
                currTime = BCM_GetTimeNs();
                /* Update the state and end point ID of the reassembly buffer */
                reassBufParams->clientEndPtID = endPtIndex;
                reassBufParams->expiryTime = currTime + (1000ULL * INET_MAX_CLIENT_READ_TIMEOUT);
                reassBufParams->bufState = INET_REASSBUFSTATE_QUEUED;
            }
        } else {
            lineNum = __LINE__;
        }

        /* Inform the receive task before trying to push into the queue */
        ret = INET_InformClientRxTask(sysEndPtObj->rxTaskId, sysEndPtObj->rxTaskEventId);
        if (BCM_ERR_OK != ret) {
            retVal = BCM_ERR_UNKNOWN;
        }

        /* Update statistics */
        if (BCM_ERR_OK == retVal) {
            sysEndPtObj->endPtObj.ctxt->stats.rxGoodPkts++;
            sysEndPtObj->endPtObj.ctxt->stats.rxBytes += pkt.length;
        } else {
            sysEndPtObj->endPtObj.ctxt->stats.rxDropPkts++;
            INET_ReportError(BRCM_SWARCH_INET_UDPRECEIVEINDICATION_PROC, retVal,
                    (uint32_t)sysEndPtObj->rxTaskId,
                    (uint32_t)endPtIndex,
                    (uint32_t)aDestPort, lineNum);
        }
    } else {
        lineNum = __LINE__;
        INET_ReportError(BRCM_SWARCH_INET_UDPRECEIVEINDICATION_PROC, retVal,
                0UL, 0UL, (uint32_t)aDestPort, lineNum);
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_INET_SEARCHINTERFACE_PROC
    @trace #BRCM_SWREQ_INET
*/
int32_t INET_SearchInterface(const uint32_t aHwId,
                             const INET_IPAddressType aIPAddress,
                             const uint16_t aVlan,
                             INET_InterfaceIdType* const aIntfId)
{
    int32_t  retVal;
    uint32_t i;

    if (NULL == aIntfId) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        retVal = BCM_ERR_NOT_FOUND;
        for (i = 0UL; i < INET_ConnCfg->intfCount; ++i) {
            if((aHwId == INET_ConnCfg->interfaces[i]->ifCtxt->cfg.hwIndex) &&
               (aIPAddress == INET_ConnCfg->interfaces[i]->ifCtxt->cfg.ipAddress) &&
               (aVlan == INET_ConnCfg->interfaces[i]->ifCtxt->cfg.vlanConfig.vlan)) {
                INET_ConnCfg->interfaces[i]->ifCtxt->ifID = i;
                *aIntfId = i;
                retVal = BCM_ERR_OK;
                break;
            }
        }
    }
    return retVal;
}

/**
    @trace #BRCM_SWARCH_INET_ADDARPENTRY_PROC
    @trace #BRCM_SWREQ_INET
*/
int32_t INET_AddARPEntry(const INET_InterfaceIdType aIntfId,
                         const INET_IPAddressType  aIPAddress,
                         const uint8_t* const aMACAddr,
                         const INET_ARPEntryStateType aFlags,
                         const uint8_t aUpdateAddr)
{
    int32_t            retVal = BCM_ERR_NOMEM;
    INET_ARPEntryType* cache;
    uint32_t           emptySlot = INET_MAX_ENTRIES_ARPCACHE;
    uint32_t           entryFound= 0UL;
    uint32_t           i;
    uint32_t           notExclusive;
    uint32_t           val;
    INET_ARPEntryStateType   cacheFlag;

    if (aIntfId >= INET_ConnCfg->intfCount) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {

        cache = INET_ConnCfg->interfaces[aIntfId]->arpCache;

        /* There could be an entry already allocated for this IP address */
        /* So traverse the complete table but keep an eye out for empty  */
        /* slot just in case we do not find the entry                    */
        for (i = 0UL; i < INET_MAX_ENTRIES_ARPCACHE; ++i) {
            do {
                notExclusive  = 0UL;
                entryFound = 0UL;
                retVal = BCM_ERR_NOMEM;
                val = CORTEX_LdrEx(&cache[i].exclVal);

                if (1UL == cache[i].valid) {
                    /* Occupied slot */
                    if (aIPAddress == cache[i].ipAddr) {
                        entryFound = 1UL;
                        switch (cache[i].flags) {
                            case INET_ARPENTRYSTATE_STATIC:
                                retVal = BCM_ERR_NOPERM;
                                break;
                            case INET_ARPENTRYSTATE_WAIT:
                            case INET_ARPENTRYSTATE_RESOLVED:
                            case INET_ARPENTRYSTATE_LEARNT:
                                /* For resolved and learnt entries, we are */
                                /* probably just refreshing them, still it */
                                /* is better to update the address         */
                                if (1U == aUpdateAddr){
                                    BCM_MemCpy(cache[i].macAddr, aMACAddr, 6UL);
                                }

                                /* Copy the flag value at index. This is done as we want */
                                /* the cache location to be updated before the event is  */
                                /* raised to the INET clients                            */
                                cacheFlag = cache[i].flags;
                                cache[i].flags  = aFlags;

                                if (aFlags != INET_ARPENTRYSTATE_WAIT){
                                    cache[i].timer  = INET_ARP_COMPLETE_ENTRY_LIFETIME;
                                } else {
                                    cache[i].timer = INET_ARP_RETRY_PERIOD;
                                }

                                /* For a transition from WAIT to LEARNT/RESOLVED state */
                                if ((INET_ARPENTRYSTATE_WAIT == cacheFlag) &&
                                    ((INET_ARPENTRYSTATE_LEARNT == aFlags) ||
                                     (INET_ARPENTRYSTATE_RESOLVED == aFlags))){
                                    uint32_t idx;

                                    /* Whenever an ARP entry gets resolved, we check the list of end points */
                                    /* on the interface. All the clients are notified so that they can start*/
                                    /* transmission or call the process API to continue data transmission.  */

                                    for (idx = 0UL; idx < INET_ConnCfg->endPtCount; idx++) {
                                        const INET_SystemEndPointType *sysEndPtObj = INET_ConnCfg->endPoints[idx];
                                        if (aIntfId == sysEndPtObj->endPtObj.ctxt->intfId) {
                                            sysEndPtObj->endPtObj.ctxt->arpCacheIndex = i;
                                            (void)INET_InformClientTxTask(sysEndPtObj->txTaskId, sysEndPtObj->txTaskEventId);
                                        }
                                    }
                                }
                                retVal = BCM_ERR_OK;
                                break;
                            default:
                                retVal = BCM_ERR_INVAL_PARAMS;
                                break;
                        }
                    }
                }
                notExclusive = CORTEX_StrEx(&cache[i].exclVal, (val + 1UL));
            } while (1UL == notExclusive);

            /* Trigger to stop searching */
            if (1UL == entryFound){
                break;
            }
        }

        /* If an entry is not found in cache, then find an empty slot */
        if(0UL == entryFound) {
            for (i = 0UL; i < INET_MAX_ENTRIES_ARPCACHE; ++i) {
                do {
                    notExclusive  = 0UL;
                    retVal = BCM_ERR_NOMEM;
                    emptySlot = INET_MAX_ENTRIES_ARPCACHE;

                    val = CORTEX_LdrEx(&cache[i].exclVal);

                    if (0UL == cache[i].valid) {
                        emptySlot = i;
                        /* Add entry into ARP cache */
                        cache[emptySlot].valid  = 1UL;
                        cache[emptySlot].ipAddr = aIPAddress;
                        cache[emptySlot].flags  = aFlags;
                        /* Update the interface which is adding this entry */
                        cache[emptySlot].ifID   = aIntfId;
                        if (INET_ARPENTRYSTATE_WAIT == aFlags) {
                            cache[emptySlot].timer = INET_ARP_RETRY_PERIOD;
                        } else {
                            cache[emptySlot].timer = INET_ARP_COMPLETE_ENTRY_LIFETIME;
                            BCM_MemCpy(cache[emptySlot].macAddr, aMACAddr, 6UL);
                        }
                        retVal = BCM_ERR_OK;
                    }
                    notExclusive = CORTEX_StrEx(&cache[i].exclVal, (val + 1UL));
                }while (1UL == notExclusive);

                /* Trigger to stop searching */
                if (emptySlot != INET_MAX_ENTRIES_ARPCACHE){
                    break;
                }
            }
        }
    }

    if (BCM_ERR_OK != retVal) {
        INET_ReportError(BRCM_SWARCH_INET_ADDARPENTRY_PROC, retVal, aIntfId,
                         aIPAddress, (uint32_t)aFlags, emptySlot);
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_INET_FINDARPENTRY_PROC
    @trace #BRCM_SWREQ_INET
*/
int32_t INET_FindARPEntry(const INET_InterfaceIdType aIntfId,
                          const INET_IPAddressType  aIPAddress,
                          uint8_t* const aMACAddr,
                          INET_ARPEntryStateType* const aFlags,
                          uint32_t* const arpIndex)
{
    int32_t            retVal = BCM_ERR_NOT_FOUND;
    INET_ARPEntryType* cache;
    uint32_t           i;
    uint32_t           notExclusive;
    uint32_t           val;

    if ((aIntfId >= INET_ConnCfg->intfCount) ||
        (INET_MAX_ENTRIES_ARPCACHE <= *arpIndex)) {
        retVal = BCM_ERR_INVAL_PARAMS;
        INET_ReportError(BRCM_SWARCH_INET_FINDARPENTRY_PROC, retVal, aIntfId,
                         aIPAddress, 0UL, 0UL);
    } else {
        cache = INET_ConnCfg->interfaces[aIntfId]->arpCache;

        /* Check if entry is available at cached index */
        do {
            notExclusive = 0UL;
            /* Reset value to avoid using old value when strex fails */
            /* and this loop has to run afresh to pick the new value */
            *aFlags = 0UL;
            retVal = BCM_ERR_NOT_FOUND;

            val = CORTEX_LdrEx(&cache[*arpIndex].exclVal);

            if ((1UL == cache[*arpIndex].valid) &&
                (aIPAddress == cache[*arpIndex].ipAddr)) {

                *aFlags = cache[*arpIndex].flags;
                if (*aFlags != INET_ARPENTRYSTATE_WAIT) {
                    BCM_MemCpy(aMACAddr, cache[*arpIndex].macAddr, 6UL);
                }
                retVal = BCM_ERR_OK;

            }
            notExclusive = CORTEX_StrEx(&cache[*arpIndex].exclVal, (val + 1UL));
        } while (1UL == notExclusive);

        /* If entry not found at cached index, then loop through */
        /* the ARP cache and identify it.                        */
        if (BCM_ERR_NOT_FOUND == retVal){
            for (i = 0UL; i < INET_MAX_ENTRIES_ARPCACHE; ++i) {
                do {
                    notExclusive = 0UL;
                    /* Reset value to avoid using old value when strex fails */
                    /* and this loop has to run afresh to pick the new value */
                    *aFlags = 0UL;
                    retVal = BCM_ERR_NOT_FOUND;

                    val = CORTEX_LdrEx(&cache[i].exclVal);

                    if ((1UL == cache[i].valid) &&
                        (aIPAddress == cache[i].ipAddr)) {

                        *aFlags = cache[i].flags;
                        if (*aFlags != INET_ARPENTRYSTATE_WAIT) {
                            BCM_MemCpy(aMACAddr, cache[i].macAddr, 6UL);
                        }
                        retVal = BCM_ERR_OK;
                        *arpIndex = i;
                    }
                    notExclusive = CORTEX_StrEx(&cache[i].exclVal, (val + 1UL));
                } while (1UL == notExclusive);
                /* In case an entry is found, return it */
                if (BCM_ERR_OK == retVal) {
                    break;
                }
            }
        }
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_INET_REMOVEARPENTRY_PROC
    @trace #BRCM_SWREQ_INET
*/
int32_t INET_RemoveARPEntry(const INET_InterfaceIdType aIntfId,
                            const INET_IPAddressType  aIPAddress)
{
    int32_t            retVal = BCM_ERR_NOT_FOUND;
    INET_ARPEntryType* cache;
    uint32_t           i;
    uint32_t           notExclusive;
    uint32_t           val;

    if (aIntfId >= INET_ConnCfg->intfCount) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        cache = INET_ConnCfg->interfaces[aIntfId]->arpCache;

        for (i = 0UL; i < INET_MAX_ENTRIES_ARPCACHE; ++i) {
            do {
                notExclusive = 0UL;
                val = CORTEX_LdrEx(&cache[i].exclVal);
                /* Check and flush the cache entry */
                if ((1UL == cache[i].valid) && (aIPAddress == cache[i].ipAddr)) {
                    if (cache[i].flags != INET_ARPENTRYSTATE_STATIC) {
                        cache[i].valid = 0UL;
                        cache[i].ipAddr = 0UL;
                        cache[i].ifID = INET_INTERFACEID_INVALID;
                        retVal = BCM_ERR_OK;
                    } else {
                        retVal = BCM_ERR_NOSUPPORT;
                    }
                }
                notExclusive = CORTEX_StrEx(&cache[i].exclVal, (val + 1UL));
            } while (1UL == notExclusive);

            if (BCM_ERR_NOT_FOUND != retVal){
                break;
            }
        }
    }

    if (BCM_ERR_OK != retVal) {
        INET_ReportError(BRCM_SWARCH_INET_REMOVEARPENTRY_PROC, retVal,
                         aIntfId, aIPAddress, 0UL, 0UL);
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_INET_GETREASSEMBLYBUFFER_PROC
    @trace #BRCM_SWREQ_INET
*/
int32_t INET_GetReassemblyBuffer(const INET_IPAddressType aSrcAddr,
                                 const uint16_t aIdent,
                                 uint8_t** aBuf,
                                 uint16_t* aLen,
                                 uint16_t* const aCurLen,
                                 uint16_t* const aTotalLen,
                                 const CIRCQ_Type** aFragQ)
{
    int32_t  retVal = BCM_ERR_NOMEM;
    const INET_ReassemblyBufferType *reassBuffer = NULL;
    uint32_t entryFound = 0UL;
    uint32_t emptySlot  = INET_ConnCfg->reassBufCount;
    uint32_t i;

    for (i = 0UL ; i < INET_ConnCfg->reassBufCount; ++i) {
        if (INET_REASSBUFSTATE_ALLOCATED == INET_ConnCfg->reassBufferPool[i]->params->bufState) {
            if ((aSrcAddr == INET_ConnCfg->reassBufferPool[i]->params->ipAddr) &&
                (aIdent == INET_ConnCfg->reassBufferPool[i]->params->ident)) {
                retVal = BCM_ERR_OK;
                entryFound = 1UL;
                reassBuffer = INET_ConnCfg->reassBufferPool[i];
                break;
            }
        } else {
            if ((emptySlot == INET_ConnCfg->reassBufCount) &&
                (INET_REASSBUFSTATE_FREE == INET_ConnCfg->reassBufferPool[i]->params->bufState)){
                emptySlot = i;
            }
        }
    }

    if ((0UL == entryFound) && (emptySlot != INET_ConnCfg->reassBufCount)) {
        INET_ConnCfg->reassBufferPool[emptySlot]->params->bufState = INET_REASSBUFSTATE_ALLOCATED;
        INET_ConnCfg->reassBufferPool[emptySlot]->params->ipAddr   = aSrcAddr;
        INET_ConnCfg->reassBufferPool[emptySlot]->params->ident    = aIdent;
        INET_ConnCfg->reassBufferPool[emptySlot]->params->expiryTime = BCM_GetTimeNs() + (INET_MAX_REASS_BUF_TIMEOUT * 1000ULL);
        reassBuffer = INET_ConnCfg->reassBufferPool[emptySlot];

        /* Safe to initialize the circular queue here as client has already */
        /* freed it and only ETHERNET_Task would be accessing this queue        */
        retVal = CIRCQ_Reset(INET_ConnCfg->reassBufferPool[emptySlot]->fragmentQ);
    }

    if (BCM_ERR_OK == retVal) {
        *aBuf      = reassBuffer->buffer;
        *aLen      = INET_MAX_REASS_BUF_SIZE;
        *aFragQ    = reassBuffer->fragmentQ;
        *aCurLen   = reassBuffer->params->curLen;
        *aTotalLen = reassBuffer->params->totalLen;
    } else {
        INET_ReportError(BRCM_SWARCH_INET_GETREASSEMBLYBUFFER_PROC, retVal, aSrcAddr,
                        (uint32_t) aIdent,
                         INET_ConnCfg->reassBufCount, 0UL);
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_INET_UPDATEREASSEMBLYBUFFER_PROC
    @trace #BRCM_SWREQ_INET
*/
int32_t INET_UpdateReassemblyBuffer(const INET_IPAddressType aSrcAddr,
                                    const uint16_t aIdent,
                                    const uint16_t aCurLen,
                                    const uint16_t aTotalLen)
{
    int32_t  retVal = BCM_ERR_NOT_FOUND;
    uint32_t i;

    for (i = 0UL ; i < INET_ConnCfg->reassBufCount; ++i) {
        if (INET_REASSBUFSTATE_ALLOCATED == INET_ConnCfg->reassBufferPool[i]->params->bufState) {
            if ((aSrcAddr == INET_ConnCfg->reassBufferPool[i]->params->ipAddr) &&
                (aIdent == INET_ConnCfg->reassBufferPool[i]->params->ident)) {
                retVal = BCM_ERR_OK;
                INET_ConnCfg->reassBufferPool[i]->params->curLen = aCurLen;
                if (aTotalLen != 0U) {
                    INET_ConnCfg->reassBufferPool[i]->params->totalLen = aTotalLen;
                }
                break;
            }
        }
    }

    if (BCM_ERR_OK != retVal) {
        INET_ReportError(BRCM_SWARCH_INET_UPDATEREASSEMBLYBUFFER_PROC, retVal, aSrcAddr,
                        (uint32_t)aIdent, (uint32_t)aCurLen,
                        (uint32_t)aTotalLen);
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_INET_FREEREASSEMBLYBUFFER_PROC
    @trace #BRCM_SWREQ_INET
*/
int32_t INET_FreeReassemblyBuffer(const uint8_t* const aBuf)
{
    int32_t  retVal = BCM_ERR_NOT_FOUND;
    INET_ReassRWParamsType *reassBufParams = NULL;
    uint32_t i;

    for (i = 0UL ; i < INET_ConnCfg->reassBufCount; ++i) {
        if ((aBuf == INET_ConnCfg->reassBufferPool[i]->buffer) &&
            (INET_REASSBUFSTATE_FREE != INET_ConnCfg->reassBufferPool[i]->params->bufState)) {
            reassBufParams = INET_ConnCfg->reassBufferPool[i]->params;
            reassBufParams->ident           = 0U;
            reassBufParams->ipAddr          = 0UL;
            reassBufParams->curLen          = 0U;
            reassBufParams->totalLen        = 0U;
            reassBufParams->expiryTime      = 0ULL;
            reassBufParams->clientEndPtID   = INET_ENDPOINTID_INVALID;
            /* Whenever INET gets a Rx packet, it is the context of      */
            /* EthSrv Task. The allocation is based on the value of       */
            /* 'bufState' flag of the reassembly buffer. This flag       */
            /* is reset here only after all the other members are reset. */
            /* Earlier, we were setting the 'bufState' flag to FREE first*/
            /* and if a context switch occured, EthSrv Task would allocate*/
            /* this same buffer. Later, in this function, the other      */
            /* variables are reset. This race condition is avoided by    */
            /* setting the 'bufState' flag to zero at the end.           */
            CORTEX_DSB();
            reassBufParams->bufState = INET_REASSBUFSTATE_FREE;
            retVal = BCM_ERR_OK;
            break;
        }
    }

    if (BCM_ERR_OK != retVal) {
        INET_ReportError(BRCM_SWARCH_INET_FREEREASSEMBLYBUFFER_PROC, retVal,
                         (uint32_t)aBuf, i, 0UL, 0UL);
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_INET_CLIENTACKREASSBUF_PROC
    @trace #BRCM_SWREQ_INET
*/
int32_t INET_ClientAckReassBuf(const uint8_t* const aBuf,
                               INET_EndPointIdType const aEndPtID)
{
    int32_t  retVal = BCM_ERR_NOT_FOUND;
    INET_ReassRWParamsType *reassBufParams = NULL;
    INET_ReassBufStateType retState;
    uint32_t i;

    for (i = 0UL ; i < INET_ConnCfg->reassBufCount; ++i) {
        if ((aBuf == INET_ConnCfg->reassBufferPool[i]->buffer) &&
            (INET_REASSBUFSTATE_FREE != INET_ConnCfg->reassBufferPool[i]->params->bufState)) {
            reassBufParams = INET_ConnCfg->reassBufferPool[i]->params;
            retVal = BCM_ERR_OK;
            break;
        }
    }

    if ((BCM_ERR_OK == retVal) &&
        (NULL != reassBufParams)  &&
        /* Check if this buffer is for the mentioned client */
        (aEndPtID == reassBufParams->clientEndPtID) &&
        /* Check if buffer is in QUEUED state */
        (INET_REASSBUFSTATE_QUEUED == reassBufParams->bufState)) {

        retState = ATOMIC_CheckUpdate(&reassBufParams->bufState,
                                     INET_REASSBUFSTATE_QUEUED,
                                     INET_REASSBUFSTATE_RCVD);
        /* A QUEUED buffer can either be  RCVD by the client task or */
        /* be timed out by the EthSrv task. In case when the client   */
        /* is updating the state to RCVD, and it gets interrupted by */
        /* the EthSrv task, it times out the buffer and sets its state*/
        /* to FREE, we are returning error in such case              */
        if (retState != INET_REASSBUFSTATE_QUEUED){
            retVal = BCM_ERR_INVAL_STATE;
        }
    } else {
        retVal = BCM_ERR_INVAL_PARAMS;
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_INET_PROCESSTIMERS_PROC
    @trace #BRCM_SWREQ_INET
*/
void INET_ProcessTimers(void)
{
    INET_ARPEntryType*        cache;
    uint32_t                  idx;
    uint32_t                  entry;
    INET_ReassRWParamsType    *reassBufParams = NULL;
    uint32_t                  notExclusive;
    uint32_t                  val;
    uint32_t                  isSendARP;
    INET_IPAddressType        ipAddrRetry;
    uint64_t                  currTime;

    currTime = BCM_GetTimeNs();

    /* Compute the time interval since last processing */
    INET_OSILHandle.lastProcTime = currTime;

    for (idx = 0UL; idx < INET_Config.intfCount; idx++) {
        const INET_SystemInterfaceType *interface = INET_Config.interfaces[idx];
        cache = interface->arpCache;
        if ((currTime - interface->ifCtxt->lastARPProcTime) >= interface->arpProcessInterval) {
            interface->ifCtxt->lastARPProcTime = currTime;
            for (entry = 0UL; entry < INET_MAX_ENTRIES_ARPCACHE; ++entry) {
                isSendARP = 0UL;
                do {
                    notExclusive = 0UL;
                    ipAddrRetry = 0UL;
                    val = CORTEX_LdrEx(&cache[entry].exclVal);
                    if ((1UL == cache[entry].valid) &&
                        (INET_ARPENTRYSTATE_STATIC != cache[entry].flags)) {

                        if (0UL == cache[entry].timer) {
                            ipAddrRetry = cache[entry].ipAddr;
                            /* Flush the entry */
                            cache[entry].timer  = 0UL;
                            cache[entry].valid  = 0UL;
                            cache[entry].ipAddr = 0UL;
                            /* For a entry in WAIT state, mark for ARP resend */
                            if (INET_ARPENTRYSTATE_WAIT == cache[entry].flags) {
                                isSendARP = 1UL;
                            }
                        } else {
                            /* Decrement life of the entry */
                            cache[entry].timer--;
                            /* If the entry is about to timeout, try to refresh */
                            if ((INET_ARPENTRYSTATE_WAIT != cache[entry].flags) &&
                                 (1UL == cache[entry].timer)) {
                                isSendARP = 1UL;
                            }
                        }
                    }
                    notExclusive = CORTEX_StrEx(&cache[entry].exclVal, (val + 1UL));
                } while (1UL == notExclusive);

                /* Send ARP request when flag is set */
                if ((1UL == isSendARP) && (0UL != ipAddrRetry)) {
                    INET_ARPSendRequest(cache[entry].ifID, ipAddrRetry, cache[entry].flags, TRUE);
                }
            }

        }
    }

    /* Check all reassembly buffers to be timed out */
    for (idx = 0UL; idx < INET_ConnCfg->reassBufCount; idx++) {
        uint8_t bufTimeOut = 0U;
        reassBufParams = INET_ConnCfg->reassBufferPool[idx]->params;

        /* Case when a reassembly buffer is used and is not fully */
        /* filled as some IP fragment was not received OR         */
        /* Case when the reassembly buffer was queued to the Client */
        /* and if it fails to read within stipulated time           */
        if (((INET_REASSBUFSTATE_ALLOCATED == reassBufParams->bufState) &&
             (reassBufParams->curLen != reassBufParams->totalLen)) ||
             (INET_REASSBUFSTATE_QUEUED == reassBufParams->bufState)){

            /* Decrement timer and manage looparound */
            if (reassBufParams->expiryTime < currTime) {
                reassBufParams->expiryTime = 0ULL;
                bufTimeOut = 1U;
            }
        }

        /* Case when reassembly buffer timeout */
        if (1U == bufTimeOut){
            /* Increment stats for buffer timeout */
            INET_OSILHandle.inetBufTimeout++;
            (void)INET_FreeReassemblyBuffer(INET_ConnCfg->reassBufferPool[idx]->buffer);
        }
    }

#if defined(ENABLE_INET_TCP)
    /* Check all TCP endpoints to be re-triggered (for retry) */
    for (idx = 0UL; idx < INET_ConnCfg->endPtCount; idx++) {
        const INET_SystemEndPointType *sysEndPtObj = INET_ConnCfg->endPoints[idx];
        INET_EndPointObjectType       *endPt = (INET_EndPointObjectType*) &sysEndPtObj->endPtObj;

        if ((endPt->l4Proto == INET_L4PROTO_TCP) &&
            (endPt->tcpCtxt->timer != 0ULL) &&
            (endPt->tcpCtxt->timer < currTime)) {
            int32_t retVal = INET_TCPTriggerStateMachine(endPt, INET_TCPEVENT_TIMER, NULL, 0UL, INET_IPADDRESS_INVALID);
            if ((BCM_ERR_MAX_ATTEMPS == retVal) || (BCM_ERR_OK == retVal)) {
                /* Inform the client that we have run of out of retries */
                (void)INET_InformClientRxTask(sysEndPtObj->rxTaskId, sysEndPtObj->rxTaskEventId);
            }
        }
    }
#endif

    return;
}

/**
    @trace #BRCM_SWARCH_INET_BUFAVAIL_PROC
    @trace #BRCM_SWREQ_INET_NIF_CB
*/
static void INET_BufferAvailableOnController (const uint32_t aHwIdx)
{
    uint32_t i;

    /* Send txTaskEventId to all tasks in the middle of transmission */
    /* on the network controller which raised the callback        */
    for (i = 0UL; i < INET_ConnCfg->endPtCount; ++i) {
        const INET_SystemEndPointType *sysEndPtObj = INET_ConnCfg->endPoints[i];
        if (aHwIdx == INET_ConnCfg->interfaces[INET_ConnCfg->endPoints[i]->endPtObj.ctxt->intfId]->ifCtxt->cfg.hwIndex) {
            if ((sysEndPtObj->endPtObj.ctxt->sentBytes) <
                    (sysEndPtObj->endPtObj.ctxt->txLength)){
                (void)INET_InformClientTxTask(sysEndPtObj->txTaskId, sysEndPtObj->txTaskEventId);
            }
        }
    }
}

/**
    @trace #BRCM_SWARCH_INET_TXPKTCONF_PROC
    @trace #BRCM_SWREQ_INET_NIF_CB
*/
void INET_TxPktConfirmation (NIF_CntrlIDType aCtrlIdx,
                             uint32_t aBufIdx)
{
    uint32_t aHwIdx = NIF_GET_CONTROLLER_INDEX(aCtrlIdx);

    /* Track the number of INET Tx Confirmation received */
    INET_OSILHandle.inetTxConfCount++;

    INET_BufferAvailableOnController(aHwIdx);
}

/**
    @trace #BRCM_SWARCH_INET_BUFAVAIL_PROC
    @trace #BRCM_SWREQ_INET_NIF_CB
*/
void INET_BufferAvailableIndication (NIF_CntrlIDType aCtrlIdx)
{
    uint32_t aHwIdx = NIF_GET_CONTROLLER_INDEX(aCtrlIdx);

    INET_BufferAvailableOnController(aHwIdx);
}

/**
    @trace #BRCM_SWARCH_INET_ALLOCATEEPHEMERALPORT_PROC
    @trace #BRCM_SWREQ_INET
*/
INET_PortType INET_AllocateEphemeralPort(void)
{
    INET_PortType port;
    int32_t       ret;
    uint32_t      i;

    do {
        ret = BCM_ERR_OK;
        port = INET_OSILHandle.currentFreeEphemeralPort++;

        if (0U == INET_OSILHandle.currentFreeEphemeralPort) {
            INET_OSILHandle.currentFreeEphemeralPort = INET_PORT_EPHEMERAL_START;
        }

        for (i = 0UL; i < INET_ConnCfg->endPtCount; ++i) {
            if (port == INET_ConnCfg->endPoints[i]->endPtObj.ctxt->endPtCfg.localPort) {
                ret = BCM_ERR_EAGAIN;
                break;
            }
        }
    } while (ret != BCM_ERR_OK);

    return port;
}

/**
    @trace #BRCM_SWARCH_INET_SETENDPOINTLOCALPORT_PROC
    @trace #BRCM_SWREQ_INET
*/
int32_t INET_SetEndPointLocalPort(const BCM_CompIDType aCompId,
                                  const uint32_t aPayloadId,
                                  INET_PortType  aPort,
                                  uint32_t       aIsUnBind)
{
    INET_EndPointIdType             endPtId = 0xFFU;
    const INET_EndPointObjectType   *endPtObj = NULL;
    int32_t                         retVal;
    uint32_t                        i = 0UL;
    INET_InterfaceIdType            intfId;

    /* Check if the end point is valid or not */
    retVal = INET_GetEndPoint(aCompId, aPayloadId,
                              &endPtId, &endPtObj);

    if (BCM_ERR_OK == retVal) {
        if (TRUE == aIsUnBind) {
            /* Check that there is no pending Tx buffer when Unbinding end point */
            if (NULL != endPtObj->ctxt->txBuf) {
                retVal = BCM_ERR_INVAL_STATE;
            } else {
                endPtObj->ctxt->endPtCfg.localPort = INET_PORT_INVALID;
            }
        } else {
            if (INET_PORT_INVALID == aPort) {
                endPtObj->ctxt->endPtCfg.localPort = INET_AllocateEphemeralPort();
            } else {
                intfId = endPtObj->ctxt->intfId;
                /* Check whether this port is already bound to another end point on same interface */
                for (; i < INET_ConnCfg->endPtCount; ++i) {
                    if ((intfId == INET_ConnCfg->endPoints[i]->endPtObj.ctxt->intfId) &&
                        (aPort == INET_ConnCfg->endPoints[i]->endPtObj.ctxt->endPtCfg.localPort) &&
                        !((aCompId == INET_ConnCfg->endPoints[i]->compId) && (aPayloadId == INET_ConnCfg->endPoints[i]->payloadId))) {
                        retVal = BCM_ERR_NOPERM;
                        break;
                    }
                }
                if (retVal == BCM_ERR_OK) {
                    endPtObj->ctxt->endPtCfg.localPort = aPort;
                }
            }
        }
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_INET_TCPRECEIVEINDICATION_PROC
    @trace #BRCM_SWREQ_INET
*/
int32_t INET_TCPReceiveIndication(const INET_IPAddressType aSrcAddr,
                                  const INET_TCPHdrType *const aTcpHdr,
                                  const uint8_t* const aBuf,
                                  const uint16_t aLen,
                                  INET_InterfaceIdType aIntfId)
{
    int32_t                       retVal = BCM_ERR_NOT_FOUND;
#if defined(ENABLE_INET_TCP)
    const INET_SystemEndPointType *sysEndPtObj = NULL;
    const INET_SystemEndPointType *listenSysEndPtObj = NULL;
    INET_EndPointObjectType       *endPtObj = NULL;
    uint32_t                      i;

    /* When receiving a TCP packet, the following tuple would be used to */
    /* identify the receiving end point:                                 */
    /* <source IP, source Port, destination IP, destination Port>        */
    /* The source parameters would be matched against the corresponding  */
    /* remote host details. Destination IP is not matched here as it     */
    /* would already have been used to identify the parent interface for */
    /* the endpoint (intfId). The destination port is matched against    */
    /* the local port number.                                            */
    /* To also cater to the case of initial connection setup where the   */
    /* packet needs to reach the listening endpoint we also need to do a */
    /* less strict lookup with just <destination IP, destination Port>,  */
    /* but this should only be performed if the earlier lookup has       */
    /* failed. To avoid multiple passes the lookup can keep an eye out   */
    /* for the fallback option (only one such entry will exist)          */

    for (i = 0UL; i < INET_ConnCfg->endPtCount; ++i) {
        if ((aIntfId == INET_ConnCfg->endPoints[i]->endPtObj.ctxt->intfId) &&
            (INET_ConnCfg->endPoints[i]->endPtObj.l4Proto == INET_L4PROTO_TCP) &&
            (INET_ConnCfg->endPoints[i]->endPtObj.ctxt->endPtCfg.localPort == aTcpHdr->dstPort)) {
            /* First check <destination IP, destination port> has succeeded at this stage */
            if (listenSysEndPtObj == NULL) {
                listenSysEndPtObj = INET_ConnCfg->endPoints[i];
            }
            if ((INET_ConnCfg->endPoints[i]->endPtObj.ctxt->endPtCfg.remotePort == aTcpHdr->srcPort) &&
                (INET_ConnCfg->endPoints[i]->endPtObj.ctxt->endPtCfg.remoteAddr == aSrcAddr)) {
                sysEndPtObj  = INET_ConnCfg->endPoints[i];
                retVal = BCM_ERR_OK;
                break;
            }
        }
    }

    if ((BCM_ERR_OK != retVal) && (listenSysEndPtObj != NULL)) {
        /* We have managed to locate a listening endpoint for this packet */
        /* To confirm, we should check its state                          */
        INET_TCPStateType tcpState = INET_TCPGetState(listenSysEndPtObj->compId, listenSysEndPtObj->payloadId);
        if (tcpState == INET_TCPSTATE_LISTEN) {
            sysEndPtObj = listenSysEndPtObj;
            retVal = BCM_ERR_OK;
        }
    }

    if (BCM_ERR_OK == retVal) {
        endPtObj = (INET_EndPointObjectType*)&sysEndPtObj->endPtObj;

        if (aLen > 0UL) {
            /* FIXME: Copy data (if any) to receive buffer */
        }

        /* Free up the reassembly buffer at this point. FIXME: Check this */
        (void)INET_FreeReassemblyBuffer(aBuf);

        /* Trigger the state machine */
        INET_TCPEventType event = INET_TCPGetEventFromPkt(endPtObj, aTcpHdr);
        retVal = INET_TCPTriggerStateMachine(endPtObj, event, aTcpHdr, aLen, aSrcAddr);

        if (BCM_ERR_OK == retVal) {
            /* Update statistics */
            endPtObj->ctxt->stats.rxGoodPkts++;
            endPtObj->ctxt->stats.rxBytes += aLen;

            /* Inform the receive task */
            retVal = INET_InformClientRxTask(sysEndPtObj->rxTaskId, sysEndPtObj->rxTaskEventId);
            if (BCM_ERR_OK != retVal) {
                retVal = BCM_ERR_UNKNOWN;
            }
        }

    }
#endif
    return retVal;
}

/**
    @trace #BRCM_SWARCH_INET_TCPRESETENDPOINT_PROC
    @trace #BRCM_SWREQ_INET
*/
int32_t INET_TCPResetEndPoint(const INET_EndPointObjectType *const aEndPtObj)
{
    int32_t retVal;
    INET_EndPointStateType *ctxt = aEndPtObj->ctxt;
    INET_TCPEndPointStateType *tcpCtxt = aEndPtObj->tcpCtxt;

    BCM_MemSet(&ctxt->endPtCfg, 0U, sizeof(INET_EndPointIPPortType));
    BCM_MemSet(&ctxt->stats, 0U, sizeof(INET_EndPointStatsType));
    BCM_MemSet(tcpCtxt, 0U, sizeof(INET_TCPEndPointStateType));
    retVal = CIRCQ_Reset(aEndPtObj->rxPktQ);

    return retVal;
}

/**
    @trace #BRCM_SWARCH_INET_TCPPROCESSCTRLMSGS_PROC
    @trace #BRCM_SWREQ_INET
*/
void INET_TCPProcessCtrlMsgs(void)
{
#if defined(ENABLE_INET_TCP)
    uint32_t i = 0UL;

    for (; i < INET_ConnCfg->endPtCount; ++i) {
        INET_EndPointObjectType *endPtObj = (INET_EndPointObjectType*)&INET_ConnCfg->endPoints[i]->endPtObj;
        if (endPtObj->l4Proto == INET_L4PROTO_TCP) {
            //FIXME: continue if the transmit queue is not empty
            uint32_t msgIdx = 0UL;
            int32_t retVal = MSGQ_GetMsgIdx(endPtObj->tcpCtrlQ, &msgIdx);
            if (BCM_ERR_OK == retVal) {
                retVal = INET_TCPTriggerStateMachine(endPtObj,
                                                     endPtObj->tcpCtrlMsgs[msgIdx].event,
                                                     &endPtObj->tcpCtrlMsgs[msgIdx].tcpHdr,
                                                     0UL,
                                                     INET_IPADDRESS_INVALID);
                if (BCM_ERR_OK == retVal) {
                    (void)MSGQ_CompleteMsgIdx(endPtObj->tcpCtrlQ, msgIdx);
                }
            }
        }
    }
#endif
}

/** @} */
