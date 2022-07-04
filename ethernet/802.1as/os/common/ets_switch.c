/*****************************************************************************
 Copyright 2020-2022 Broadcom Limited.  All rights reserved.

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
    @addtogroup grp_ets_il
    @{
    @file ets_switch.c
    @brief ETS Library OS Integration Layer for Switch
    This source file contains the integration of ETS to system
    @version 0.1 Initial version
*/

/* Includes */
#include <bcm_err.h>
#include <atomic.h>
#include <bcm_utils.h>
#include <ethutils.h>
#include "ets.h"
#include "ets_osil_switch.h"
#include "ets_osil_defs.h"
#include <rpc_local_osil.h>
#include <ethernet_ets.h>
/**
    @name ETS Component Design IDs
    @{
    @brief Design IDs for ETS component

*/
#define BRCM_SWDSGN_ETS_RECORDQ_GLOBAL                   (0xA201U)    /**< @brief #ETS_RecordQ               */
#define BRCM_SWDSGN_ETS_RECORDS_Q_LOG2_SZ_MACRO          (0xA202U)    /**< @brief #ETS_RECORDS_Q_LOG2_SZ     */
#define BRCM_SWDSGN_ETS_RECORDS_Q_SZ_MACRO               (0xA203U)    /**< @brief #ETS_RECORDS_Q_SZ          */
#define BRCM_SWDSGN_ETS_THRESHOLD_TIMER_TICKS            (0xA204U)    /**< @brief #ETS_THRESHOLD_TIMER_TICKS */
#define BRCM_SWDSGN_ETS_RXMGMTINFOINDICATION_PROC        (0xA205U)    /**< @brief #ETS_RxMgmtInfoIndication  */
#define BRCM_SWDSGN_ETS_TRANSMIT_SWITCH_PROC             (0xA206U)    /**< @brief #ETS_TransmitSwitch        */
#define BRCM_SWDSGN_ETS_CONFIGSAVECALLBACK_PROC          (0xA207U)    /**< @brief #ETS_ConfigSaveCallback    */
#define BRCM_SWDSGN_ETS_EVENTCALLBACK_PROC               (0xA208U)    /**< @brief #ETS_EventCallback         */
#define BRCM_SWDSGN_ETS_SENDRECORDTOHOST_PART_PROC       (0xA209U)    /**< @brief #ETS_SendRecordToHost      */
#define BRCM_SWDSGN_ETS_RECORDCALLBACK_PROC              (0xA20AU)    /**< @brief #ETS_RecordCallback        */
#define BRCM_SWDSGN_ETS_PERIODICSENDRECORDS_PART_PROC    (0xA20BU)    /**< @brief #ETS_PeriodicSendRecords   */
#define BRCM_SWDSGN_ETS_GETRECORDQ_PROC                  (0xA20CU)    /**< @brief #ETS_GetRecordQ            */
#define BRCM_SWDSGN_ETS_UPDATE_CONFIG_PROC               (0xA20DU)    /**< @brief #ETS_UpdateConfig          */
/** @} */

/**
    @brief Log2 of circular queue depth, used to store records.
    This number can be configured.
    @trace #BRCM_SWARCH_ETS_PERIODIC_SEND_RECORDS_PROC
    @trace #BRCM_SWREQ_ETS

*/
#ifdef ENABLE_RECORD_NOTIFICATION
#define ETS_RECORDS_Q_LOG2_SZ (4UL)

/**
    @brief Circular queue depth, used to store records.
    This number can be configured.
    @trace #BRCM_SWARCH_ETS_PERIODIC_SEND_RECORDS_PROC
    @trace #BRCM_SWREQ_ETS

*/
#define ETS_RECORDS_Q_SZ (1 << ETS_RECORDS_Q_LOG2_SZ)

/**
    @brief Threshold of timer ticks to trigger send
           records periodically
    @trace #BRCM_SWARCH_ETS_PERIODIC_SEND_RECORDS_PROC
    @trace #BRCM_SWREQ_ETS
*/
#define ETS_THRESHOLD_TIMER_TICKS (2U)

/**
    @brief Circular queue to store records
    @trace #BRCM_SWREQ_ETS
    @trace #BRCM_SWARCH_ETS_RECORDCALLBACK_PROC
*/
CIRCQ_V2_DEFINE(ETS_RecordQ, ETS_RECORDS_Q_LOG2_SZ, ETS_RecordType, ETS_RecordQBuf,
                ETS_RecordQIdx, (CIRCQ_OVERWRITE_DISABLE), ".data.gptp");

/**
    @trace #BRCM_SWREQ_ETS
    @trace #BRCM_SWARCH_ETS_RECORDCALLBACK_PROC
*/
CIRCQ_Type * ETS_GetRecordQ(void)
{
    return (CIRCQ_Type*)&ETS_RecordQ;
}

#endif

/**
    @code{.unparsed}
#if (ETS_MAX_INTERFACES > 1)
    entry = networkQ.last();
    if (aBuf == networkQ[entry].bufIdx) {
        networkQ[entry].intfIdx = aMgmtInfo->portIdx;
        if (!ETS_IsGptpEventMsg(aBuf)) {
            Push(networkQ, event);
        }
    }
#endif
    @endcode
    @trace #BRCM_SWARCH_ETS_RXMGMTINFOINDICATION_PROC
    @trace #BRCM_SWREQ_ETS_NIF_CALLBACK_SWITCH
*/
void ETS_RxMgmtInfoIndication(NIF_CntrlIDType aCtrlIdx,
                              const uint8_t *const aBuf,
                              const ETHSWT_MgmtInfoType *const aMgmtInfo)
{
    int32_t         rc          = BCM_ERR_OK;
    ETS_StateType   state       = ETS_GetState();
    uint32_t        isEventMsg;
    uint32_t        lineNum        = 0UL;
    ETS_ContextType *ETS_Handle = ETS_GetHandle();

    if (state != ETS_STATE_RUNNING) {
        rc = BCM_ERR_INVAL_STATE;
        lineNum = __LINE__;
        goto end;
    }

    if ((NULL == aBuf) || (NULL == aMgmtInfo)) {
        rc = BCM_ERR_INVAL_PARAMS;
        lineNum = __LINE__;
        goto end;
    }

    /* Validate that we received the callback for the same packet */
    if (((uint32_t)aBuf == ETS_Handle->events[ETS_Handle->currRxIdx].bufIdx) &&
        (ETS_PKTEVENT_RX == ETS_Handle->events[ETS_Handle->currRxIdx].eventId)) {
        ETS_Handle->events[ETS_Handle->currRxIdx].intfIdx = aMgmtInfo->portIdx;
        /* If this is a general message, no need to wait for the */
        /* timestamp callback                                    */
        rc = ETS_IsGptpEventMsg(ETS_Handle->events[ETS_Handle->currRxIdx].intfIdx,
                                ETS_Handle->events[ETS_Handle->currRxIdx].rxBuffer,
                                ETS_Handle->events[ETS_Handle->currRxIdx].pktLen,
                                &isEventMsg);
        if ((BCM_ERR_OK == rc) && (0UL == isEventMsg)) {
            /* Push the packet now */
            rc = CIRCQ_Push(ETS_GetNetworkQ(), (char*)&ETS_Handle->currRxIdx, 1UL);
            if(BCM_ERR_OK != rc) {
                /* Deallocate the buffer */
                ATOMIC_SetBit(&ETS_Handle->networkQAllocFlags, ETS_Handle->currRxIdx);
                lineNum = __LINE__;
            }
        }
    } else {
        rc = BCM_ERR_INVAL_PARAMS;
        lineNum = __LINE__;
    }

end:
    if ((BCM_ERR_OK != rc) && (ETS_STATE_RUNNING == ETS_GetState())) {
        ETS_ErrorReport(BRCM_SWARCH_ETS_RXMGMTINFOINDICATION_PROC, rc, lineNum,
                       (uint32_t)aBuf, ETS_Handle->events[ETS_Handle->currRxIdx].bufIdx,
                       ETS_Handle->events[ETS_Handle->currRxIdx].eventId);
    }
}

/**
    @code{.unparsed}
    NIF_SwtSetMgmtInfo()
    @endcode
    @trace #BRCM_SWARCH_ETS_TRANSMIT_SWITCH_PROC
    @trace #BRCM_SWREQ_ETS_CORE_SWITCH
*/
int32_t ETS_TransmitSwitch(const uint32_t        aIntfNum,
                           const NIF_CntrlIDType aCtrlIdx,
                           const uint32_t        aBufIdx)
{
    int32_t             rc      = BCM_ERR_OK;
    ETHSWT_MgmtInfoType mgmtInfo;

    mgmtInfo.switchIdx = 0UL;
    mgmtInfo.portIdx   = aIntfNum;
    mgmtInfo.tc        = ETHSWT_TC_4;
    rc = NIF_SwtSetMgmtInfo(aCtrlIdx, aBufIdx, &mgmtInfo);
    return rc;
}

/**
    @code{.unparsed}
    if (BCM_ERR_OK == retVal)
        localPort = ETHUTILS_ConvertToLocalPort(aPortIdx, &isStackingPort)
        if (ETHUTILS_INVALID_PORT != localPort)
            notification.data = buf
            notification.pDelayNBRR.port   = aPortIdx
            notification.pDelayNBRR.pDelay = aPdelay
            notification.pDelayNBRR.nbrr   = aRateRatio
            retVal = RPC_AsyncEventToHost(BCM_GROUPID_ETHSRV, BCM_ETS_ID, ETS_EVENT_IF_PDELAY_CHANGED,
                    notification.data, sizeof(ETS_PortPDelayAndNBRRType))
            line = __LINE__

        for (; i < ETS_Handle->config.numInterfaces; ++i)
            if (aPortIdx == ETS_Handle->config.intfCfg[i].hwPortNum)
                ETS_Handle->config.intfCfg[i].avnuNbrPropDelay = aPdelay
                ETS_Handle->config.intfCfg[i].avnuNbrRateRatio = aRateRatio
                break
    if (BCM_ERR_OK != retVal)
        ETS_ErrorReport(BRCM_SWARCH_ETS_CONFIGSAVECALLBACK_PROC, retVal,
                line, aPortIdx, aPdelay, (uint32_t)aRateRatio)

    @endcode

    @trace #BRCM_SWARCH_ETS_CONFIGSAVECALLBACK_PROC
    @trace #BRCM_SWREQ_ETS_CORE_SWITCH
*/
void ETS_ConfigSaveCallback (const uint32_t aPortIdx,
                             const uint32_t aPdelay,
                             const int32_t  aRateRatio)
{
    ETS_MsgUnionType  notification;
    uint32_t          localPort;
    MCU_InfoType      stackingInfo   = {0U};
    uint32_t          i              = 0UL;
    uint32_t          isStackingPort = FALSE;
    int32_t           retVal         = MCU_GetInfo(&stackingInfo);
    ETS_ContextType   *ETS_Handle    = ETS_GetHandle();
    uint32_t          line           = __LINE__;

    if (BCM_ERR_OK == retVal) {
        localPort = ETHUTILS_ConvertToLocalPort(aPortIdx, &isStackingPort);
        if (ETHUTILS_INVALID_PORT != localPort) {
            notification.pDelayNBRR.port   = aPortIdx;
            notification.pDelayNBRR.pDelay = aPdelay;
            notification.pDelayNBRR.nbrr   = aRateRatio;
            retVal = RPC_AsyncEventToHost(BCM_GROUPID_ETHSRV, BCM_ETS_ID, ETS_EVENT_IF_PDELAY_CHANGED,
                                          (const uint8_t *const)notification.data, sizeof(ETS_PortPDelayAndNBRRType));
            line = __LINE__;
        }

        /* Also cache these in the configuration */
        for (; i < ETS_Handle->config.numInterfaces; ++i) {
            if (aPortIdx == ETS_Handle->config.intfCfg[i].hwPortNum) {
                ETS_Handle->config.intfCfg[i].avnuNbrPropDelay = aPdelay;
                ETS_Handle->config.intfCfg[i].avnuNbrRateRatio = aRateRatio;
                break;
            }
        }

    }
    if (BCM_ERR_OK != retVal) {
        ETS_ErrorReport(BRCM_SWARCH_ETS_CONFIGSAVECALLBACK_PROC, retVal,
                line, aPortIdx, aPdelay, (uint32_t)aRateRatio);
    }
}

/**
    @code{.unparsed}
    switch (aEvent) {
        case ETS_EVENT_IF_UP:
        case ETS_EVENT_IF_DOWN:
#if defined(ENABLE_ETH_SWITCH)
            ETHSWT_SetLedState(aPortIdx, aEvent);
#endif
#if defined(ENABLE_IPC)
            RPC_AsyncEventToHost(aPortIdx, aEvent);
#endif
            break;
        case ETS_EVENT_SYNC:
        case ETS_EVENT_SYNC_LOST:
        case ETS_EVENT_IF_LOST_RESP_EXCEEDED:
        case ETS_EVENT_IF_LOST_RESP_RECOVERED:
#if defined(ENABLE_IPC)
            RPC_AsyncEventToHost(aPortIdx, aEvent);
#endif
            break;
    }
    @endcode
    @trace #BRCM_SWARCH_ETS_EVENTCALLBACK_PROC
    @trace #BRCM_SWREQ_ETS_CORE_SWITCH
*/
void ETS_EventCallback (const uint32_t      aPortIdx,
                        const ETS_EventType aEvent)
{
    int32_t          ret;
    uint32_t         lineNum;
    ETS_MsgUnionType notification;

    notification.portNum = aPortIdx;

    switch (aEvent) {
        case ETS_EVENT_IF_UP:
            ret = ETHSWT_SetLedState(0UL, aPortIdx, ETHSWT_LED_AVB, TRUE);
            lineNum = __LINE__;
            if (ret == BCM_ERR_OK) {
                ret = RPC_AsyncEventToHost(BCM_GROUPID_ETHSRV, BCM_ETS_ID, aEvent,
                                           (const uint8_t *const)notification.data, sizeof(aPortIdx));
                lineNum = __LINE__;
            }
            break;
        case ETS_EVENT_IF_DOWN:
            ret = ETHSWT_SetLedState(0UL, aPortIdx, ETHSWT_LED_AVB, FALSE);
            lineNum = __LINE__;
            if (ret == BCM_ERR_OK) {
                ret = RPC_AsyncEventToHost(BCM_GROUPID_ETHSRV, BCM_ETS_ID, aEvent,
                                           (const uint8_t *const)notification.data, sizeof(aPortIdx));
                lineNum = __LINE__;
            }
            break;
        case ETS_EVENT_SYNC:
            ret = RPC_AsyncEventToHost(BCM_GROUPID_ETHSRV, BCM_ETS_ID, aEvent,
                                       NULL, 0UL);
            lineNum = __LINE__;
            break;
        case ETS_EVENT_SYNC_LOST:
            ret = RPC_AsyncEventToHost(BCM_GROUPID_ETHSRV, BCM_ETS_ID, aEvent,
                                       NULL, 0UL);
            lineNum = __LINE__;
            break;
        case ETS_EVENT_IF_LOST_RESP_EXCEEDED:
            ret = RPC_AsyncEventToHost(BCM_GROUPID_ETHSRV, BCM_ETS_ID, aEvent,
                                       (const uint8_t *const)notification.data, sizeof(aPortIdx));
            lineNum = __LINE__;
            break;
        case ETS_EVENT_IF_LOST_RESP_RECOVERED:
            ret = RPC_AsyncEventToHost(BCM_GROUPID_ETHSRV, BCM_ETS_ID, aEvent,
                                       (const uint8_t *const)notification.data, sizeof(aPortIdx));
            lineNum = __LINE__;
            break;
        default:
            ret = BCM_ERR_NOT_FOUND;
            lineNum = __LINE__;
            break;
    }
    if (BCM_ERR_OK != ret) {
        ETS_ErrorReport(BRCM_SWARCH_ETS_EVENTCALLBACK_PROC, ret, lineNum,
                        aPortIdx, aEvent, 0UL);
    }
}

/**
    @code{.unparsed}
    if ((BCM_ERR_OK == rc) && (FALSE == isEmpty))
        record.numRecords = CIRCQ_Pop(ETS_GetRecordQ(), (char* const)&record.records, ETS_MAX_RECORDS_PER_IPC_MSG)
        if (record.numRecords != 0UL)
#ifdef ENABLE_RECORD_NOTIFICATION_TEST
            extern int32_t ValidateRecord(ETS_RecordsListType* const aRecord)
            rc = ValidateRecord(&record)
#else
            ETS_MsgUnionType notification
            notification.records = &record
            rc = RPC_AsyncEventToHost(BCM_GROUPID_ETHSRV, BCM_ETS_ID, ETS_EVENT_IF_RECORD,
                    notification.data, sizeof(ETS_RecordsListType))
#endif
    if (BCM_ERR_OK != rc)
        ETS_ErrorReport(BRCM_SWDSGN_ETS_SENDRECORDTOHOST_PART_PROC, rc,
                        (uint32_t) isEmpty, record.numRecords,
                         0UL, 0UL)
    @endcode

    @trace #BRCM_SWREQ_ETS_CORE_SWITCH
    @trace #BRCM_SWARCH_ETS_RECORDCALLBACK_PROC
*/
#ifdef ENABLE_RECORD_NOTIFICATION
static void ETS_SendRecordToHost(void)
{
    uint32_t isEmpty = TRUE;
    int32_t rc = BCM_ERR_OK;
    ETS_RecordsListType record;
    record.numRecords      = 0UL;
    rc = CIRCQ_IsEmpty(ETS_GetRecordQ(), &isEmpty);
    if ((BCM_ERR_OK == rc) && (FALSE == isEmpty)) {
        /* Dequeue the records and send to host */
        record.numRecords = CIRCQ_Pop(ETS_GetRecordQ(), (char* const)&record.records, ETS_MAX_RECORDS_PER_IPC_MSG);
        if (record.numRecords != 0UL) {
#ifdef ENABLE_RECORD_NOTIFICATION_TEST
            extern int32_t ValidateRecord(ETS_RecordsListType* const aRecord);
            rc = ValidateRecord(&record);
#else
            ETS_MsgUnionType notification;
            BCM_MemCpy(&notification.records, &record, sizeof(record));
            rc = RPC_AsyncEventToHost(BCM_GROUPID_ETHSRV, BCM_ETS_ID, ETS_EVENT_IF_RECORD,
                                      (const uint8_t *const)notification.data, sizeof(ETS_RecordsListType));
#endif
        }
    }
    if (BCM_ERR_OK != rc) {
        ETS_ErrorReport(BRCM_SWDSGN_ETS_SENDRECORDTOHOST_PART_PROC, rc,
                        (uint32_t) isEmpty, record.numRecords,
                         0UL, 0UL);
    }
}

/**
    @code{.unparsed}
    Increment timer tick
    if the timer tick threshold has been exceeded:
        Send records to host
        Reset timer tick count to 0
    @endcode
    @trace #BRCM_SWREQ_ETS_CORE_SWITCH
    @trace #BRCM_SWARCH_ETS_PERIODIC_SEND_RECORDS_PROC
*/
void ETS_PeriodicSendRecords(void)
{
    ETS_ContextType *ETS_Handle = ETS_GetHandle();
    /* Send records to host */
    ETS_Handle->numTimerTicks++;
    if(ETS_THRESHOLD_TIMER_TICKS <= ETS_Handle->numTimerTicks) {
        ETS_SendRecordToHost();
        ETS_Handle->numTimerTicks = 0U;
    }
}
#endif

/**
    @code{.unparsed}
    Push record into record circular queue
    If there is no space in the queue:
        Flush the queue by sending all records to host
        Retry pushing record into record circular queue
    @endcode
    @trace #BRCM_SWREQ_ETS_CORE_SWITCH
    @trace #BRCM_SWARCH_ETS_RECORDCALLBACK_PROC
*/
void ETS_RecordCallback(ETS_RecordType* const aRecord)
{
#ifdef ENABLE_RECORD_NOTIFICATION
    int32_t                ret;
    ret = CIRCQ_Push(ETS_GetRecordQ(), (char*)aRecord, 1UL);
    if (BCM_ERR_NOMEM == ret) {
        /* Flush the queue */
        ETS_SendRecordToHost();
        ret = CIRCQ_Push(ETS_GetRecordQ(), (char*)aRecord, 1UL);
    }
    if (BCM_ERR_OK != ret) {
        ETS_ErrorReport(BRCM_SWARCH_ETS_RECORDCALLBACK_PROC, ret, 0UL, 0UL, 0UL, 0UL);
    }
#else
    /* Purposefully ignore */
#endif
}

/**
    @code{.unparsed}
    @endcode
    @trace #BRCM_SWREQ_ETS
    @trace #BRCM_SWARCH_ETS_UPDATE_CONFIG_PROC
*/
void ETS_UpdateConfig(ETS_ConfigType *const aConfig,
                      uint32_t aUnifiedToLocal)
{
#if defined (ENABLE_ETS)
    MCU_InfoType   stackingInfo = {0U};
    ETS_ConfigType scratch;
    uint32_t       localPort;
    uint32_t       unifiedPort;
    uint32_t       i                  = 0UL;
    uint32_t       isStackingPort     = FALSE;
    uint32_t       portCnt            = 0UL;
    uint32_t       stackingPortSlave  = FALSE;
    int32_t        retVal =  MCU_GetInfo(&stackingInfo);

    if (BCM_ERR_OK != retVal) {
        ETS_ErrorReport(BRCM_SWARCH_ETS_UPDATE_CONFIG_PROC, retVal,
                (uint32_t)__LINE__, 0UL, 0UL, 0UL);
    } else {

        BCM_MemCpy(&scratch, aConfig, sizeof(ETS_ConfigType));
        BCM_MemSet(scratch.intfCfg, 0U, sizeof(scratch.intfCfg));

        for (; i < aConfig->numInterfaces; ++i) {
            if (TRUE == aUnifiedToLocal) {
                localPort = ETHUTILS_ConvertToLocalPort(aConfig->intfCfg[i].hwPortNum,
                                                          &isStackingPort);
                if ((ETHUTILS_INVALID_PORT != localPort) && (FALSE == isStackingPort))  {
                    BCM_MemCpy(&scratch.intfCfg[portCnt],
                               &aConfig->intfCfg[i],
                               sizeof(ETS_IntfConfigType));
                    scratch.intfCfg[portCnt].hwPortNum = (uint8_t)localPort;
                    BCM_MemCpy(&scratch.domainCfg[0U].intfCfg[portCnt],
                               &aConfig->domainCfg[0U].intfCfg[i],
                               sizeof(ETS_DomainIntfConfigType));
                    portCnt++;
                } else if (aConfig->domainCfg[0U].intfCfg[i].avnuPortRole == ETS_ROLE_SLAVE) {
                    stackingPortSlave = TRUE;
                }
            } else {
                unifiedPort = ETHUTILS_ConvertToUnifiedPort(aConfig->intfCfg[i].hwPortNum,
                                                              &isStackingPort);
                if ((ETHUTILS_INVALID_PORT != unifiedPort) && (FALSE == isStackingPort)) {
                    BCM_MemCpy(&scratch.intfCfg[portCnt],
                               &aConfig->intfCfg[i],
                               sizeof(ETS_IntfConfigType));
                    scratch.intfCfg[portCnt].hwPortNum = (uint8_t)unifiedPort;
                    BCM_MemCpy(&scratch.domainCfg[0U].intfCfg[portCnt],
                               &aConfig->domainCfg[0U].intfCfg[i],
                               sizeof(ETS_DomainIntfConfigType));
                    portCnt++;
                }
            }
        }

        /* Add the stacking/internal ports */
        if ((TRUE == aUnifiedToLocal) &&
                (1U == stackingInfo.stackingEn) &&
                (aConfig->domainCfg[0U].avnuClockMode == ETS_CLOCKMODE_SLAVE)) {
            ETS_IntfConfigType intfCfg = {
                .hwPortNum = stackingInfo.stackPort0,
                .initLogPdelayInterval = ETS_LOGINTERVAL_1S,
                .avnuOperLogPdelayInterval = ETS_OPERLOGPDELAY_1S,
                .avnuNbrPropDelay = 300UL,
                .avnuNbrRateRatio = 0x40000000L,
                .allowedLostResponses = 3U
            };
            ETS_DomainIntfConfigType domainIntfCfg = {
                .portEnable = TRUE,
                .avnuPortRole = (stackingPortSlave == TRUE) ? ETS_ROLE_SLAVE:ETS_ROLE_MASTER,
                .initLogSyncInterval = ETS_LOGINTERVAL_125MS,
                .avnuOperLogSyncInterval = ETS_OPERLOGSYNC_1S,
                .syncReceiptTimeout = 3U,
            };

            BCM_MemCpy(&scratch.domainCfg[0U].intfCfg[portCnt], &domainIntfCfg, sizeof(ETS_DomainIntfConfigType));
            BCM_MemCpy(&scratch.intfCfg[portCnt++], &intfCfg, sizeof(ETS_IntfConfigType));
        }
        scratch.numInterfaces = portCnt;
        BCM_MemCpy(aConfig, &scratch, sizeof(ETS_ConfigType));
    }
#endif
}

/** @} */
