/*****************************************************************************
 Copyright 2017-2021 Broadcom Limited.  All rights reserved.

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
    @file etsm.c
    @brief ETS Library OS Integration Layer
    This source file contains the integration of ETS to system
    @version 0.1 Imported from Word Document
*/

/* Includes */
#include <stdint.h>
#include <string.h>
#include <bcm_err.h>
#include <circ_queue.h>
#include <nif.h>
#include <bcm_utils.h>
#include <atomic.h>
#include "ets_osil.h"
#include "etsm.h"
#include "ets_osil_defs.h"
#include <osil/bcm_osil.h>
#include <ethutils.h>
#include <system.h>
#include <mcu.h>
#include <ethernet_ets.h>

/**
    @name ETS Component Design IDs
    @{
    @brief Design IDs for ETS component

*/
#define BRCM_SWDSGN_ETS_NETWORKQ_GLOBAL                   (0xA301U)    /**< @brief #ETS_NetworkQ                 */
#define BRCM_SWDSGN_ETS_HANDLE_GLOBAL                     (0xA302U)    /**< @brief #ETS_Handle                   */
#define BRCM_SWDSGN_ETSM_MODULE_GLOBAL                    (0xA303U)    /**< @brief #ETSM_Module                  */
#define BRCM_SWDSGN_ETS_ERRORREPORT_PART_PROC             (0xA304U)    /**< @brief #ETS_ErrorReport              */
#define BRCM_SWDSGN_ETS_RXPKTINDICATION_PROC              (0xA305U)    /**< @brief #ETS_RxPktIndication          */
#define BRCM_SWDSGN_ETS_TXPKTCONFIRMATION_PROC            (0xA306U)    /**< @brief #ETS_TxPktConfirmation        */
#define BRCM_SWDSGN_ETS_RXPKTTSINDICATION_PROC            (0xA307U)    /**< @brief #ETS_RxPktTSIndication        */
#define BRCM_SWDSGN_ETS_TXPKTTSINDICATION_PROC            (0xA308U)    /**< @brief #ETS_TxPktTSIndication        */
#define BRCM_SWDSGN_ETS_PROCESSNETWORKEVENTS_PART_PROC    (0xA30AU)    /**< @brief #ETS_ProcessNetworkEvents     */
#define BRCM_SWDSGN_ETSM_RESTART_PART_PROC                (0xA30BU)    /**< @brief #ETSM_Restart                 */
#define BRCM_SWDSGN_ETSM_STOP_PART_PROC                   (0xA30CU)    /**< @brief #ETSM_Stop                    */
#define BRCM_SWDSGN_ETS_GETNETWORKQ_PROC                  (0xA30DU)    /**< @brief #ETS_GetNetworkQ              */
#define BRCM_SWDSGN_ETS_GETHANDLE_PROC                    (0xA30EU)    /**< @brief #ETS_GetHandle                */
#define BRCM_SWDSGN_ETSM_INITNETWORKQUEUES_PART_PROC      (0xA30FU)    /**< @brief #ETSM_InitNetworkQueues       */
#define BRCM_SWDSGN_ETSM_PROCESSCMD_PART_PROC             (0xA310U)    /**< @brief #ETSM_ProcessCmd              */
#define BRCM_SWDSGN_ETSM_RESETSTATECHNGHNDLR_PART_PROC    (0xA311U)    /**< @brief #ETSM_ResetStateChangeHandler */
#define BRCM_SWDSGN_ETSM_INITSTATECHNGHNDLR_PART_PROC     (0xA312U)    /**< @brief #ETSM_InitStateChangeHandler  */
#define BRCM_SWDSGN_ETSM_READYSTATECHNGHNDLR_PART_PROC    (0xA313U)    /**< @brief #ETSM_ReadyStateChangeHandler */
#define BRCM_SWDSGN_ETSM_RUNSTATECHNGHNDLR_PART_PROC      (0xA314U)    /**< @brief #ETSM_RunStateChangeHandler   */
#define BRCM_SWDSGN_ETSM_HANDLEEVENTS_PART_PROC           (0xA316U)    /**< @brief #ETSM_HandleEvents            */
#define BRCM_SWDSGN_ETSM_SENDCMD_PART_PROC                (0xA317U)    /**< @brief #ETSM_SendCmd                 */
#define BRCM_SWDSGN_ETSM_MERGERESULT_PART_PROC            (0xA318U)    /**< @brief #ETSM_MergeResult             */
#define BRCM_SWDSGN_ETSM_GETEVENTMASK_PART_PROC           (0xA319U)    /**< @brief #ETSM_GetEventMask            */
#define BRCM_SWDSGN_ETSM_ASYNCMSGHANDLER_PART_PROC        (0xA31AU)    /**< @brief #ETSM_AsyncMsgHandler         */
#define BRCM_SWDSGN_ETS_CONVERT_TO_UNIFIED_PORT_PROC      (0xA31BU)    /**< @brief #ETS_ConvertToUnifiedPort     */
#define BRCM_SWDSGN_ETS_GETCONFIG_PROC                    (0xA31CU)    /**< @brief #ETS_GetConfig                */
#define BRCM_SWDSGN_ETSM_GETRESP_PROC                     (0xA31DU)    /**< @brief #ETSM_GetResp                 */
#define BRCM_SWDSGN_ETSM_MSGQGETCMD_PROC                  (0xA31EU)    /**< @brief #ETSM_MsgQGetCmd              */
/** @} */

/* For each port, it is possible to have upto 4 events arrive at the */
/* same time. Consider a slave switch with N ports. This has (N-1)   */
/* master ports. If all the links are up, once the timer fires, a    */
/* PDelay Request is sent out of all ports. The timestamp indication */
/* and the PDelay response and follow up can be received at any time.*/
/* At the same timer, a SYNC message can be sent out of all master   */
/* ports and the timestamp indication can be received later          */
/* asynchronously. In the worst case we can receive a signaling      */
/* message on the master port.                                       */
/* For now we support upto 8 port switch and since the circular queue*/
/* can support (2^N - 1) slots, chosing to keep the number of events */
/* as 31 instead of 32 for switches and 3 for end points             */
/*
#if (ETS_MAX_INTERFACES > 1)
#define ETS_NETWORKQ_LOG2_SIZE   (5UL)
#define ETS_NUM_NETWORK_EVENTS   (31UL)
#else
#define ETS_NETWORKQ_LOG2_SIZE   (3UL)
#define ETS_NUM_NETWORK_EVENTS   (7UL)
#endif
*/

/**
    @brief Network events circular queue handle

    The handle of network events circular queue.

    @trace #BRCM_SWREQ_ETS
    @trace #BRCM_SWARCH_ETS_RXPKTINDICATION_PROC
    @trace #BRCM_SWARCH_ETS_RXPKTTSINDICATION_PROC
    @trace #BRCM_SWARCH_ETS_TXPKTCONFIRMATION_PROC
    @trace #BRCM_SWARCH_ETS_TXPKTTSINDICATION_PROC
*/
CIRCQ_V2_DEFINE(ETS_NetworkQ, ETS_NETWORKQ_LOG2_SIZE, uint8_t, ETS_NetworkQBuf,
                ETS_NetworkQIdx, (CIRCQ_OVERWRITE_DISABLE), ".data.gptp");

/**
    @brief Global context for ETS OSIL

    The data structure of the ETS OSIL which maintains the
    command, network and transmit confirmation queues.

    @trace #BRCM_SWREQ_ETS_TYPES
    @trace #BRCM_SWARCH_ETS_RXPKTINDICATION_PROC
    @trace #BRCM_SWARCH_ETS_RXPKTTSINDICATION_PROC
    @trace #BRCM_SWARCH_ETS_TXPKTCONFIRMATION_PROC
    @trace #BRCM_SWARCH_ETS_TXPKTTSINDICATION_PROC
*/
static ETS_ContextType ETS_Handle COMP_SECTION(".data.gptp") =
{
    .networkQAllocFlags  = ((1UL << ETS_NUM_NETWORK_EVENTS) - 1UL),
    .txWaitQAllocFlags   = ((1UL << ETS_NUM_TX_WAITQ_PKTS) - 1UL),
};

/**
    @code{.unparsed}
    return &ETS_Handle
    @endcode

    @trace #BRCM_SWREQ_ETS_TYPES
    @trace #BRCM_SWARCH_ETS_RXPKTINDICATION_PROC
*/
ETS_ContextType* ETS_GetHandle(void)
{
    return &ETS_Handle;
}

/**
    @code{.unparsed}
    return &ETS_NetworkQ
    @endcode

    @trace #BRCM_SWREQ_ETS
    @trace #BRCM_SWARCH_ETS_RXPKTINDICATION_PROC
*/
CIRCQ_Type * ETS_GetNetworkQ(void)
{
    return (CIRCQ_Type*)&ETS_NetworkQ;
}

/**
    @code{.unparsed}
    BCM_ReportError();
    @endcode

    @trace #BRCM_SWARCH_ETS_RXPKTINDICATION_PROC
    @trace #BRCM_SWARCH_ETS_RXPKTTSINDICATION_PROC
    @trace #BRCM_SWARCH_ETS_TXPKTCONFIRMATION_PROC
    @trace #BRCM_SWARCH_ETS_TXPKTTSINDICATION_PROC
    @trace #BRCM_SWREQ_ETS_TYPES
*/
void ETS_ErrorReport(uint16_t aApiID, int32_t aErr, uint32_t aVal0,
                     uint32_t aVal1, uint32_t aVal2, uint32_t aVal3)
{
#ifndef ULOG
    const uint32_t values[4UL] = {aVal0, aVal1, aVal2, aVal3};

    BCM_ReportError(BCM_ETS_ID, 0U, aApiID, aErr, 4UL, values);
#endif
}

/**
    @code{.unparsed}
    Reset ETS network circular Q
    Reset transmit Wait Q
    Reset Events Q
    Initialize network Q alloc flags
    Initialize transmit wait Q alloc flags
    Initialize Tx and Rx event indices
    @endcode
    @trace #BRCM_SWREQ_ETSM
    @trace #BRCM_SWARCH_ETSM_MODULE_GLOBAL
*/
static void ETSM_InitNetworkQueues(void)
{
    (void)CIRCQ_Reset(ETS_GetNetworkQ());

    BCM_MemSet(ETS_Handle.txWaitPkts, 0U, sizeof(ETS_Handle.txWaitPkts));
    BCM_MemSet(ETS_Handle.events, 0U, sizeof(ETS_Handle.events));

    ETS_Handle.networkQAllocFlags  = ((1UL << ETS_NUM_NETWORK_EVENTS) - 1UL);
    ETS_Handle.txWaitQAllocFlags   = ((1UL << ETS_NUM_TX_WAITQ_PKTS) - 1UL);
    ETS_Handle.currRxIdx           = ETS_NUM_NETWORK_EVENTS;
    ETS_Handle.currTxIdx           = ETS_NUM_NETWORK_EVENTS;
}

/**
    @code{.unparsed}
    if ETS is running:
        ETS_DeInit()
        ETSM_InitNetworkQueues()
    ETS_Init()
    @endcode
    @trace #BRCM_SWREQ_ETSM
    @trace #BRCM_SWARCH_ETSM_MODULE_GLOBAL
*/
static int32_t ETSM_Restart(void)
{
    int32_t retVal = BCM_ERR_INVAL_STATE;
    ETS_StateType state = ETS_GetState() ;

    if (ETS_STATE_RUNNING == state) {
        retVal = ETS_DeInit();

        if (BCM_ERR_OK == retVal) {
            /* Reset the data structures after changing state to RESET */
            ETSM_InitNetworkQueues();
            retVal = ETS_Init(&ETS_Handle.config);
        }
    }

    return retVal;
}

/**
    @code{.unparsed}
    ETSM_StopTimer()
    if (ETS is running)
        ETS_DeInit()
    @endcode
    @trace #BRCM_SWREQ_ETSM
    @trace #BRCM_SWARCH_ETSM_MODULE_GLOBAL
*/
static int32_t ETSM_Stop(BCM_StateType aRequestedState)
{
    int32_t ret = BCM_ERR_OK;

    ETSM_StopTimer();
    if (ETS_STATE_RUNNING == ETS_GetState()) {
        ret = ETS_DeInit();
    }

    return ret;
}

/** @brief Process messages received on network queue

    This interface is invoked by the ETS task when it is notified of a
    network event. It retrieves all events from the network events queue
    in FIFO order and feeds them to the ETS library.

    @behavior Sync, Non-reentrant

    @pre None

    @return     void

    @post None

    @code{.unparsed}
    while(event = Pop(networkQ)) {
        switch(event.eventId) {
            case ETS_PKTEVENT_RX:
                ETS_RxPacket(event.intfIdx,
                             event.rxBuffer,
                             event.pktLen,
                             event.dstMacAddr,
                             event.timestamp,
                             event.timestampValid);
                break;
            case ETS_PKTEVENT_TX:
                ETS_TxConfirmation(event.intfIdx,
                                   event.pktType,
                                   event.timestamp,
                                   event.timestampValid);
                break;
        }
    }
    @endcode

    @trace #BRCM_SWREQ_ETS
    @trace #BRCM_SWARCH_ETS_RXPKTINDICATION_PROC
    @trace #BRCM_SWARCH_ETS_RXPKTTSINDICATION_PROC
    @trace #BRCM_SWARCH_ETS_TXPKTCONFIRMATION_PROC
    @trace #BRCM_SWARCH_ETS_TXPKTTSINDICATION_PROC

    @limitations None
*/
static void ETS_ProcessNetworkEvents(void)
{
    uint32_t  idx;
    uint32_t  numEvents;
    uint8_t   idxArray[ETS_NUM_NETWORK_EVENTS];
    int32_t   rc = BCM_ERR_OK;

    BCM_MemSet(idxArray, 0U, sizeof(idxArray));

    /* Retrieve all messages from the queue one shot to maintain FIFO order */
    numEvents = CIRCQ_Pop(ETS_GetNetworkQ(), (char*)idxArray, ETS_NUM_NETWORK_EVENTS);
    for (idx = 0UL; idx < numEvents; idx++) {
        switch(ETS_Handle.events[idxArray[idx]].eventId)
        {
            case ETS_PKTEVENT_RX:
                rc = ETS_RxPacket(ETS_Handle.events[idxArray[idx]].intfIdx,
                                  ETS_Handle.events[idxArray[idx]].rxBuffer,
                                  ETS_Handle.events[idxArray[idx]].pktLen,
                                  ETS_Handle.events[idxArray[idx]].dstMacAddr,
                                  &ETS_Handle.events[idxArray[idx]].timestamp,
                                  ETS_Handle.events[idxArray[idx]].timestampValid);
                /* Deallocate the event */
                ATOMIC_SetBit(&ETS_Handle.networkQAllocFlags, idxArray[idx]);
                break;
            case ETS_PKTEVENT_TX:
                rc = ETS_TxConfirmation(ETS_Handle.events[idxArray[idx]].intfIdx,
                                        ETS_Handle.events[idxArray[idx]].pktType,
                                        &ETS_Handle.events[idxArray[idx]].timestamp,
                                        ETS_Handle.events[idxArray[idx]].timestampValid);
                /* Deallocate the event from network queue */
                ATOMIC_SetBit(&ETS_Handle.networkQAllocFlags, idxArray[idx]);
                break;
            default:
                rc = BCM_ERR_INVAL_PARAMS;
                break;
        }
        if (BCM_ERR_OK != rc) {
            uint8_t* macAddr = ETS_Handle.events[idxArray[idx]].dstMacAddr;
            ETS_ErrorReport(BRCM_SWDSGN_ETS_PROCESSNETWORKEVENTS_PART_PROC, rc,
                            idxArray[idx],
                            ETS_Handle.events[idxArray[idx]].eventId,
                            ETS_Handle.events[idxArray[idx]].intfIdx,
                            ETS_Handle.events[idxArray[idx]].bufIdx);
            ETS_ErrorReport(BRCM_SWDSGN_ETS_PROCESSNETWORKEVENTS_PART_PROC, rc,
                            ETS_Handle.events[idxArray[idx]].pktLen,
                            ETS_Handle.events[idxArray[idx]].pktType,
                            (uint32_t)macAddr[0] |
                            ((uint32_t)macAddr[1] << 8UL) |
                            ((uint32_t)macAddr[2] << 16UL) |
                            ((uint32_t)macAddr[3] << 24UL),
                            (uint32_t)macAddr[4] |
                            ((uint32_t)macAddr[5] << 8UL));
        }
    }
}

/**
    @code{.unparsed}
    event = Allocate(networkQ);

    memcpy(event.rxBuffer, aPktBuf, aPktLen);
    event.eventId = ETS_PKTEVENT_RX;

#ifndef ENABLE_ETH_SWITCH
    if (ETS_IsGptpEventMsg(aPktBuf)) {
        Push(networkQ, event);
    }
#endif
    @endcode
    @trace #BRCM_SWARCH_ETS_RXPKTINDICATION_PROC
    @trace #BRCM_SWREQ_ETS_NIF_CALLBACK
*/
void ETS_RxPktIndication (NIF_CntrlIDType aCtrlIdx,
                          const uint8_t *const aPktBuf,
                          uint16_t aPktLen,
                          const uint8_t *const aSrcMacAddr,
                          const uint8_t *const aDestMacAddr,
                          uint32_t aPriority)
{
    ETS_StateType state = ETS_GetState() ;
    int32_t       rc    = BCM_ERR_OK;

    /* Validate */
    if (state != ETS_STATE_RUNNING) {
        rc = BCM_ERR_INVAL_STATE;
        goto end;
    }

    if ((NULL == aPktBuf) || (0U == aPktLen) || (NULL == aDestMacAddr)) {
        rc = BCM_ERR_INVAL_PARAMS;
        goto end;
    }
    ETS_Handle.currRxIdx = ATOMIC_ClrNGetBit(&ETS_Handle.networkQAllocFlags);

    if (ETS_Handle.currRxIdx < ETS_NUM_NETWORK_EVENTS) {
        /* We only copy ETS_MAX_PDU_SIZE since a valid gPTP PDU */
        /* would not be larger than that                        */
        uint16_t  copyLength = (aPktLen > ETS_MAX_PDU_SIZE) ?
                                ETS_MAX_PDU_SIZE : aPktLen;

        BCM_MemCpy(ETS_Handle.events[ETS_Handle.currRxIdx].rxBuffer, aPktBuf, (size_t)copyLength);

        ETS_Handle.events[ETS_Handle.currRxIdx].eventId        = ETS_PKTEVENT_RX;
        ETS_Handle.events[ETS_Handle.currRxIdx].pktLen         = copyLength;
        ETS_Handle.events[ETS_Handle.currRxIdx].bufIdx         = (uint32_t) aPktBuf;
        ETS_Handle.events[ETS_Handle.currRxIdx].timestampValid = FALSE;
        BCM_MemCpy(ETS_Handle.events[ETS_Handle.currRxIdx].dstMacAddr, aDestMacAddr, 6UL);

        /* For end point this is the place to push the general messages */
        /* to the library                                               */
        /* For switch, wait for the management information callback     */
        /* For event messages wait for the timestamp callback           */
#ifndef ENABLE_ETH_SWITCH
        ETS_Handle.events[ETS_Handle.currRxIdx].intfIdx = 0UL;
        {
            uint32_t    isEventMsg = 0UL;
            rc = ETS_IsGptpEventMsg(ETS_Handle.events[ETS_Handle.currRxIdx].intfIdx, aPktBuf, aPktLen, &isEventMsg);
            if ((BCM_ERR_OK == rc) && (0UL == isEventMsg)) {
                /* Push the packet now */
                rc = CIRCQ_Push(ETS_GetNetworkQ(), (char*)&ETS_Handle.currRxIdx, 1UL);
                if(BCM_ERR_OK != rc) {
                    /* Deallocate the buffer */
                    ATOMIC_SetBit(&ETS_Handle.networkQAllocFlags, ETS_Handle.currRxIdx);
                }
            }
        }
#endif
    } else {
        rc = BCM_ERR_NOMEM;
    }
end:
    if ((BCM_ERR_OK != rc) && (ETS_STATE_RUNNING == ETS_GetState())) {
        ETS_ErrorReport(BRCM_SWARCH_ETS_RXPKTINDICATION_PROC, rc, (uint32_t) aPktBuf,
                       (uint32_t)aPktLen, (uint32_t)aDestMacAddr,
                       (uint32_t)ETS_Handle.currRxIdx);
    }
}


/**
    @code{.unparsed}
    entry = networkQ.last();
    if (aBuf == networkQ[entry].bufIdx) {
        networkQ[entry].timestamp = *aTS;
        networkQ[entry].timestampValid = *aTSQual;
        Push(networkQ, entry);
    }
    @endcode
    @trace #BRCM_SWARCH_ETS_RXPKTTSINDICATION_PROC
    @trace #BRCM_SWREQ_ETS_NIF_CALLBACK
*/

void ETS_RxPktTSIndication(NIF_CntrlIDType aCtrlIdx,
                           const uint8_t *const aBuf,
                           ETHXCVR_IDType aXcvrID,
                           const ETHER_TimestampType *const aTS,
                           const ETHER_TimestampQualType* const aTSQual)
{
    int32_t       rc      = BCM_ERR_OK;
    ETS_StateType state   = ETS_GetState();
    uint32_t      lineNum = 0UL;

    if (state != ETS_STATE_RUNNING) {
        rc = BCM_ERR_INVAL_STATE;
        lineNum = __LINE__;
        goto end;
    }

    if ((NULL == aBuf) || (NULL == aTS) || (NULL == aTSQual)) {
        rc = BCM_ERR_INVAL_PARAMS;
        lineNum = __LINE__;
        goto end;
    }

    /* Validate that we received the callback for the same packet   */
    /* If yes, then this is definitely the place to push the packet */
    /* to the library                                               */
    if (((uint32_t)aBuf == ETS_Handle.events[ETS_Handle.currRxIdx].bufIdx) &&
        (ETS_PKTEVENT_RX == ETS_Handle.events[ETS_Handle.currRxIdx].eventId)) {
        if(aXcvrID != ETS_Handle.events[ETS_Handle.currRxIdx].intfIdx) {
            rc = BCM_ERR_INVAL_PARAMS;
            lineNum = __LINE__;
            goto end;
        }
        ETS_Handle.events[ETS_Handle.currRxIdx].timestamp.seconds = aTS->seconds;
        ETS_Handle.events[ETS_Handle.currRxIdx].timestamp.nanoseconds = aTS->nanoseconds;
        if (ETHER_TIMESTAMPQUAL_VALID == *aTSQual) {
            ETS_Handle.events[ETS_Handle.currRxIdx].timestampValid = TRUE;
        } else {
            ETS_Handle.events[ETS_Handle.currRxIdx].timestampValid = FALSE;
        }
        /* Push the packet now */
        rc = CIRCQ_Push(ETS_GetNetworkQ(), (char*)&ETS_Handle.currRxIdx, 1UL);
        if(BCM_ERR_OK != rc) {
            /* Deallocate the buffer */
            ATOMIC_SetBit(&ETS_Handle.networkQAllocFlags, ETS_Handle.currRxIdx);
            lineNum = __LINE__;
        }
    } else {
        rc = BCM_ERR_INVAL_PARAMS;
        lineNum = __LINE__;
    }
end:
    if ((BCM_ERR_OK != rc) && (ETS_STATE_RUNNING == ETS_GetState())) {
        ETS_ErrorReport(BRCM_SWARCH_ETS_RXPKTTSINDICATION_PROC, rc, lineNum, (uint32_t)aBuf,
                       ETS_Handle.events[ETS_Handle.currRxIdx].bufIdx,
                       ETS_Handle.events[ETS_Handle.currRxIdx].eventId);
        ETS_ErrorReport(BRCM_SWARCH_ETS_RXPKTTSINDICATION_PROC, rc,
                        ETS_Handle.events[ETS_Handle.currRxIdx].intfIdx,
                        (uint32_t) aXcvrID, 0UL, 0UL);
    }
}

/**
    @code{.unparsed}
    entry = find (txWaitQ, aBufIdx);
    event = Allocate(networkQ);
    event.eventId = ETS_PKTEVENT_TX;
    event.pktType = txWaitQ[entry].pktType;
    event.intfIdx = txWaitQ[entry].intfIdx;
    event.bufIdx  = aBufIdx;
    if (!txWaitQ[entry].isEventMsg)  {
        Push(networkQ, event);
    }
    @endcode
    @trace #BRCM_SWARCH_ETS_TXPKTCONFIRMATION_PROC
    @trace #BRCM_SWREQ_ETS_NIF_CALLBACK
*/
void ETS_TxPktConfirmation (NIF_CntrlIDType aCtrlIdx,
                            uint32_t aBufIdx)
{
    ETS_StateType         state  = ETS_GetState() ;
    int32_t               rc     = BCM_ERR_OK;
    ETS_NetworkEventType  *event = NULL;
    uint32_t              i      = 0UL;
    uint32_t              txWaitFlags = ATOMIC_Get(&ETS_Handle.txWaitQAllocFlags);

    /* First check if the module is in the running state or not */
    if (state != ETS_STATE_RUNNING) {
        rc = BCM_ERR_INVAL_STATE;
        goto end;
    }

    /* To know whether or not to wait for the timestamp callback, we peek  */
    /* into the txWaitPkts queue and also take this opportunity to         */
    /* populate the port information since we are not going to get that in */
    /* any of the callbacks                                                */
    for (; i < ETS_NUM_TX_WAITQ_PKTS; i++) {
        if ((0UL == (txWaitFlags & (1UL << i))) &&
            (aBufIdx == ETS_Handle.txWaitPkts[i].bufIdx )) {

            /* Allocate an entry in the network events queue */
            ETS_Handle.currTxIdx = ATOMIC_ClrNGetBit(&ETS_Handle.networkQAllocFlags);

            if (ETS_Handle.currTxIdx < ETS_NUM_NETWORK_EVENTS) {
                event = &ETS_Handle.events[ETS_Handle.currTxIdx];
                BCM_MemSet(event, 0U, sizeof(ETS_NetworkEventType));

                /* Copy all relevant information from the transmit wait queue */
                event->eventId        = ETS_PKTEVENT_TX;
                event->intfIdx        = ETS_Handle.txWaitPkts[i].intfIdx;
                event->pktType        = ETS_Handle.txWaitPkts[i].pktType;
                event->bufIdx         = aBufIdx;
                event->timestampValid = FALSE;
                if (0UL == ETS_Handle.txWaitPkts[i].isEventMsg) {
                    rc = CIRCQ_Push(ETS_GetNetworkQ(), (char*)&ETS_Handle.currTxIdx, 1UL);

                    if(BCM_ERR_OK != rc) {
                        /* Deallocate the buffer */
                        ATOMIC_SetBit(&ETS_Handle.networkQAllocFlags, ETS_Handle.currTxIdx);
                    }
                }
            } else {
                rc = BCM_ERR_NOMEM;
            }
            /* Free up the entry in the transmit wait queue */
            ATOMIC_SetBit(&ETS_Handle.txWaitQAllocFlags, i);
            break;
        }
    }
    if (i == ETS_NUM_TX_WAITQ_PKTS) {
        rc = BCM_ERR_NOT_FOUND;
    }

end:
    if (rc != BCM_ERR_OK) {
        ETS_ErrorReport(BRCM_SWARCH_ETS_TXPKTCONFIRMATION_PROC, rc,
                        (uint32_t)(aCtrlIdx >> 32UL), (uint32_t)aCtrlIdx,
                        aBufIdx, (uint32_t)ETS_Handle.currTxIdx);
    }
}

/**
    @code{.unparsed}
    entry = networkQ.last();
    if (aBufIdx == networkQ[entry].bufIdx) {
        networkQ[entry].timestamp = *aTS;
        networkQ[entry].timestampValid = *aTSQual;
        Push(networkQ, entry);
    }
    @endcode
    @trace #BRCM_SWARCH_ETS_TXPKTTSINDICATION_PROC
    @trace #BRCM_SWREQ_ETS_NIF_CALLBACK
*/
void ETS_TxPktTSIndication(NIF_CntrlIDType aCtrlIdx,
                           uint32_t aBufIdx,
                           ETHXCVR_IDType aXcvrID,
                           const ETHER_TimestampType *const aTS,
                           const ETHER_TimestampQualType* const aTSQual)
{
    int32_t       rc      = BCM_ERR_OK;
    ETS_StateType state   = ETS_GetState();
    uint32_t      lineNum = 0UL;

    if (state != ETS_STATE_RUNNING) {
        rc = BCM_ERR_INVAL_STATE;
        lineNum = __LINE__;
        goto end;
    }

    if ((NULL == aTS) || (NULL == aTSQual)) {
        rc = BCM_ERR_INVAL_PARAMS;
        lineNum = __LINE__;
        goto end;
    }

    /* Validate that we received the callback for the same packet */
    if ((aBufIdx == ETS_Handle.events[ETS_Handle.currTxIdx].bufIdx) &&
        (ETS_PKTEVENT_TX == ETS_Handle.events[ETS_Handle.currTxIdx].eventId)) {
        ETS_Handle.events[ETS_Handle.currTxIdx].timestamp.seconds = aTS->seconds;
        ETS_Handle.events[ETS_Handle.currTxIdx].timestamp.nanoseconds = aTS->nanoseconds;
        if (ETHER_TIMESTAMPQUAL_VALID == *aTSQual) {
            ETS_Handle.events[ETS_Handle.currTxIdx].timestampValid = TRUE;
        } else {
            ETS_Handle.events[ETS_Handle.currTxIdx].timestampValid = FALSE;
        }

        /* Push the event now */
        rc = CIRCQ_Push(ETS_GetNetworkQ(), (char*)&ETS_Handle.currTxIdx, 1UL);

        if(BCM_ERR_OK != rc) {
            /* Deallocate the buffer */
            ATOMIC_SetBit(&ETS_Handle.networkQAllocFlags, ETS_Handle.currTxIdx);
            lineNum = __LINE__;
        }
    } else {
        rc = BCM_ERR_INVAL_PARAMS;
        lineNum = __LINE__;
    }
end:
    if (BCM_ERR_OK != rc) {
        ETS_ErrorReport(BRCM_SWARCH_ETS_TXPKTTSINDICATION_PROC, rc, lineNum, aBufIdx,
                        ETS_Handle.events[ETS_Handle.currTxIdx].bufIdx,
                        ETS_Handle.events[ETS_Handle.currTxIdx].eventId);
    }
}

/**
    @code{.unparsed}
    port = ETHUTILS_ConvertToUnifiedPort()
    if not a stacking port
        portNum = port
    @endcode
    @trace #BRCM_SWARCH_ETS_CONVERT_TO_UNIFIED_PORT_PROC
    @trace #BRCM_SWREQ_ETS_TYPES
*/
void ETS_ConvertToUnifiedPort(uint32_t *const aPortNum, uint32_t *const aIsStackingPort)
{
    uint32_t port;

    port = ETHUTILS_ConvertToUnifiedPort(*aPortNum,
            aIsStackingPort);
    if (FALSE == *aIsStackingPort) {
        *aPortNum = port;
    }
}

/**
    @code{.unparsed}
    return &ETS_Handle.config
    @endcode
    @trace #BRCM_SWARCH_ETS_GETCONFIG_PROC
    @trace #BRCM_SWREQ_ETS_TYPES
*/
const ETS_ConfigType* ETS_GetConfig(void)
{
    return &ETS_Handle.config;
}

/**
    @code{.unparsed}
    check input arguments and return BCM_ERR_INVAL_PARAMS on error
    check if ETS library is running and return BCM_ERR_INVAL_STATE on error
    default behaviour is to both process locally and forward unless overridden
    if command is ETS_CMD_GETGLOBALSTATUS or ETS_CMD_SETGLOBALENABLE
        check input command length and return BCM_ERR_INVAL_PARAMS on error
    if command is ETS_CMD_GETPORTSTATUS or ETS_CMD_RESETSTATS or ETS_CMD_SETPORTENABLE
        check input command length and return BCM_ERR_INVAL_PARAMS on error
        convert input (unified) port to local port
        if it is a stacking port, do not process locally, else do no forward
    if command is ETS_CMD_SETGLOBALTIME
        check input command length and return BCM_ERR_INVAL_PARAMS on error
        if we are a stacked device return BCM_ERR_NOSUPPORT else do not forward
    return BCM_ERR_NOSUPPORT for all other commands
    @endcode
    @trace #BRCM_SWARCH_ETSM_MODULE_GLOBAL
    @trace #BRCM_SWREQ_ETSM
*/
static int32_t ETSM_SendCmd(BCM_CmdType aCmd,
                            uint32_t aLen,
                            const uint8_t *aCmdData,
                            BCM_HandleType *aHandle,
                            uint32_t *aForwardToSlaves)
{
    ETS_MsgUnionType cmd;
    int32_t          retVal = BCM_ERR_OK;
    uint8_t          cmdId = (uint8_t)BCM_GET_CMDID(aCmd);
    BCM_CompIDType   compID = (uint16_t)BCM_GET_COMP(aCmd);
    ETS_RpcMsgType   cmdEntry;

    if ((NULL == aHandle) ||
        (NULL == aForwardToSlaves) ||
        (BCM_GROUPID_ETHSRV != BCM_GET_GROUPID(aCmd)) ||
        (BCM_ETS_ID != BCM_GET_COMP(aCmd))) {
        retVal = BCM_ERR_INVAL_PARAMS;
        goto done;
    }

    if(ETS_STATE_RESET == ETS_GetState()) {
        *aHandle = 0ULL;
        retVal = BCM_ERR_INVAL_STATE;
        goto done;
    }

    /* Map the incoming request */
    BCM_MemCpy(cmd.data, aCmdData, aLen);

    *aForwardToSlaves = TRUE;
    *aHandle    = 1ULL;
    switch (BCM_GET_CMDID(aCmd)) {
        case ETS_CMD_GETGLOBALSTATUS:
            if (aLen != sizeof(ETS_GlobalStatusType)) {
                retVal = BCM_ERR_INVAL_PARAMS;
            }
            break;
        case ETS_CMD_GETDOMAINSTATUS:
            if (aLen != sizeof(ETS_DomainNumAndStatusType)) {
                retVal = BCM_ERR_INVAL_PARAMS;
            }
            break;
#ifdef ENABLE_RECORD_NOTIFICATION
        case ETS_CMD_NOTIFY_RECORD:
            break;
#endif
        case ETS_CMD_GETPORTSTATUS:
            if (aLen != sizeof(ETS_PortNumAndStatusType)) {
                retVal = BCM_ERR_INVAL_PARAMS;
            } else {
                uint32_t port = cmd.portStatus.num;
                uint32_t isStackingPort = FALSE;

                port = ETHUTILS_ConvertToLocalPort(port, &isStackingPort);
                if (ETHUTILS_INVALID_PORT == port) {
                    retVal = BCM_ERR_INVAL_PARAMS;
                } else {
                    if (TRUE == isStackingPort) {
                        *aHandle = 0ULL;
                    } else {
                        *aForwardToSlaves = FALSE;
                    }
                }
            }
            break;
        case ETS_CMD_GETDOMAINPORTSTATUS:
            /* Fall through intentional */
        case ETS_CMD_RESETSTATS:
            if (aLen != sizeof(ETS_PerDomainPortStatusType)) {
                retVal = BCM_ERR_INVAL_PARAMS;
            } else {
                uint32_t port = cmd.domainPortStatus.portNum;
                uint32_t isStackingPort = FALSE;

                port = ETHUTILS_ConvertToLocalPort(port, &isStackingPort);
                if (ETHUTILS_INVALID_PORT == port) {
                    retVal = BCM_ERR_INVAL_PARAMS;
                } else {
                    if (TRUE == isStackingPort) {
                        *aHandle = 0ULL;
                    } else {
                        *aForwardToSlaves = FALSE;
                    }
                }
            }
            break;
        case ETS_CMD_SETGLOBALTIME:
            {
                MCU_InfoType  stackingInfo = {0U};

                retVal = MCU_GetInfo(&stackingInfo);
                if (BCM_ERR_OK == retVal) {
                    if (aLen != sizeof(ETS_TimeType)) {
                        retVal = BCM_ERR_NOMEM;
                    } else if (TRUE == stackingInfo.stackingEn) {
                        retVal = BCM_ERR_NOSUPPORT;
                    } else {
                        *aForwardToSlaves = FALSE;
                    }
                }
            }
            break;
        case ETS_CMD_SETGLOBALENABLE:
            if (aLen != sizeof(uint32_t)) {
                retVal = BCM_ERR_INVAL_PARAMS;
            }
            break;
        case ETS_CMD_SETPORTENABLE:
            if (aLen != sizeof(ETS_PortEnableType)) {
                retVal = BCM_ERR_INVAL_PARAMS;
            } else {
                uint32_t port = cmd.portEnable.num;
                uint32_t isStackingPort = FALSE;

                port = ETHUTILS_ConvertToLocalPort(port, &isStackingPort);
                if (ETHUTILS_INVALID_PORT == port) {
                    retVal = BCM_ERR_INVAL_PARAMS;
                } else {
                    if (TRUE == isStackingPort) {
                        *aHandle = 0ULL;
                    } else {
                        *aForwardToSlaves = FALSE;
                    }
                }
            }
            break;
        default:
            *aForwardToSlaves = FALSE;
            *aHandle = 0ULL;
            retVal = BCM_ERR_NOSUPPORT;
            break;
    }

    if ((BCM_ERR_OK == retVal) && (0ULL != *aHandle)) {
        cmdEntry.compID = compID;
        cmdEntry.cmdID = cmdId;
        cmdEntry.ret = BCM_ERR_UNKNOWN;
        cmdEntry.payloadLen = aLen;
        BCM_MemCpy(cmdEntry.payload, aCmdData, aLen);
        retVal = MSGQ_SendMsgv2(&ETSM_Module.cmdQ, (uint8_t*)&cmdEntry, MODULE_Event, aHandle);
        if ((BCM_ERR_OK != retVal) || (0UL == *aHandle)) {
            ETS_ErrorReport(BRCM_SWDSGN_ETSM_SENDCMD_PART_PROC, retVal, (uint32_t)(MODULE_Event),
                                   (uint32_t) *aHandle, compID, cmdId);
        }
    }
done:
    return retVal;
}

/** @brief Retreive status of management commands from ETS module

    This API queries the status of completed management commands which were
    previously issued to ETS module

    @behavior Sync, Re-entrant

    @pre None

    @param[in]   aHandle                BCM Handle to retrieve response for
    @param[in]   aReplyID               Reply ID (group, comp, cmd)
    @param[in]   aInLen                 Available Length of the reply data payload in bytes
    @param[out]  aReplyData             Pointer to the reply data payload
    @param[out]  aReplyDataLen          Actual Length of the reply data payload in bytes

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK     Command status retrieved successfully

    @post None

    @trace #BRCM_SWARCH_ETSM_MODULE_GLOBAL
    @trace #BRCM_SWREQ_ETSM
*/
static int32_t ETSM_GetResp(BCM_HandleType aHandle, BCM_CmdType aReplyID, uint32_t aInLen,
                            uint8_t *aReplyData, uint32_t *aReplyDataLen)
{
    int32_t  retVal = BCM_ERR_OK;
    ETS_RpcMsgType respEntry;

    if ((0ULL == aHandle) || (aReplyData == NULL) || (aReplyDataLen == NULL)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        respEntry.ret = BCM_ERR_UNKNOWN;
        retVal = MSGQ_RecvMsgv2(&ETSM_Module.cmdQ, aHandle, (uint8_t*)&respEntry);

        if ((BCM_ERR_OK != retVal) && (BCM_ERR_BUSY != retVal)) {
            retVal = respEntry.ret;
            ETS_ErrorReport(0U, retVal, __LINE__, (uint32_t) aHandle, 0UL, 0UL);
        } else if (BCM_ERR_OK == retVal) {
            if(ETS_MAX_PAYLOAD_SIZE >= respEntry.payloadLen){
                /* Copy the response payload */
                BCM_MemCpy(aReplyData, respEntry.payload, respEntry.payloadLen);
                *aReplyDataLen = respEntry.payloadLen;
            } else {
                /* Case when the response payload is incorrect */
                respEntry.ret = BCM_ERR_INVAL_PARAMS;
            }

            /* Copy the response status */
            if (BCM_ERR_BUSY != respEntry.ret) {
                retVal = respEntry.ret;
            } else {
                retVal = BCM_ERR_UNKNOWN;
            }
        }
    }

    return retVal;
}

/**
    @code{.unparsed}
    check input arguments and return BCM_ERR_INVAL_PARAMS on error
    if command is ETS_CMD_RESETSTATS
        convert input port to local port
        if not a stacking port invoke ETS_ResetStats()
    if command is ETS_CMD_SETGLOBALENABLE
        copy the input admin mode to the parameter in the cached config
        restart the library
    if command is ETS_CMD_SETPORTENABLE
        find the interface which has the same hwPortNum as input port
            copy the portEnable to the asCapable field
        restart the library
    if command is ETS_CMD_GETGLOBALSTATUS
        set the magic to ETS_GLBL_STATUS_MAGIC_ID
        invoke ETS_GetGlobalStatus()
        if BCM_ERR_OK was returned by the library
            convert the slave port to unified port
    if command is ETS_CMD_GETPORTSTATUS
        convert the input port to local
        if it is not a stacking port
            set the magic to ETS_PORT_STATUS_MAGIC_ID
            invoke ETS_GetIntfStatus()
            set the magic to ETS_STATS_MAGIC_ID
            invoke ETS_GetStats()
    if command is ETS_CMD_SETGLOBALTIME
        invoke ETS_SetGlobalTime()
    if command is ETS_CMD_NOTIFY_RECORD
        invoke ETS_EnableRecordNotification()
        if record notification is disabled
            reset the records circular queue
#endif
    @endcode
    @trace #BRCM_SWARCH_ETSM_MODULE_GLOBAL
    @trace #BRCM_SWREQ_ETSM
*/
static int32_t ETSM_ProcessCmd (BCM_CmdType             aCmd,
                                BCM_SubStateType *const aCmdStatus,
                                uint8_t *const          aCmdData,
                                uint32_t                aLen,
                                uint32_t *const         aReplyLen)
{
    int32_t          retVal = BCM_ERR_OK;
    ETS_MsgUnionType cmdResp;

    if((NULL == aCmdData) ||
       (NULL == aCmdStatus) ||
        (BCM_GROUPID_ETHSRV != BCM_GET_GROUPID(aCmd)) ||
        (BCM_ETS_ID != BCM_GET_COMP(aCmd))) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        BCM_MemCpy(cmdResp.data, aCmdData, aLen);

        switch (BCM_GET_CMDID(aCmd)) {
            case ETS_CMD_RESETSTATS:
                {
                    uint32_t port = cmdResp.domainPortStatus.portNum;
                    uint32_t isStackingPort = FALSE;

                    port = ETHUTILS_ConvertToLocalPort(port, &isStackingPort);
                    if (FALSE == isStackingPort) {
                        retVal = ETS_ResetStats(port, cmdResp.domainPortStatus.domain);
                        *aReplyLen = 0UL;
                    }
                }
                break;
            case ETS_CMD_SETGLOBALENABLE:
                *aReplyLen = 0UL;
                ETS_Handle.config.globalEnable = cmdResp.globalEnable;
                retVal = ETSM_Restart();
                break;
            case ETS_CMD_SETPORTENABLE:
                {
                    uint32_t port   = cmdResp.portEnable.num;
                    uint32_t domain = 0UL;
                    uint32_t intf   = 0UL;
                    uint32_t isStackingPort = FALSE;

                    retVal = BCM_ERR_NOT_FOUND;
                    *aReplyLen = 0UL;

                    port = ETHUTILS_ConvertToLocalPort(port, &isStackingPort);
                    for (; domain < ETS_MAX_DOMAINS; ++domain) {
                        ETS_DomainConfigType *domainCfg = &ETS_Handle.config.domainCfg[domain];
                        if (domainCfg->domainNumber == cmdResp.portEnable.domain) {
                            for (; intf < ETS_MAX_INTERFACES; ++intf) {
                                if (ETS_Handle.config.intfCfg[intf].hwPortNum == port) {
                                    domainCfg->intfCfg[intf].portEnable = cmdResp.portEnable.portEnable;
                                    retVal = ETSM_Restart();
                                    break;
                                }
                            }
                            break;
                        }
                    }
                }
                break;
            case ETS_CMD_GETGLOBALSTATUS:
                cmdResp.globalStatus.magicId = ETS_GLBL_STATUS_MAGIC_ID;
                retVal = ETS_GetGlobalStatus(&cmdResp.globalStatus);
                *aReplyLen = sizeof(ETS_GlobalStatusType);
                break;
            case ETS_CMD_GETDOMAINSTATUS:
                cmdResp.domainStatus.status.magicId = ETS_DOMAIN_STATUS_MAGIC_ID;
                retVal = ETS_GetDomainStatus(cmdResp.domainStatus.num, &cmdResp.domainStatus.status);
                if (BCM_ERR_OK == retVal) {
                    uint32_t isStackingPort = FALSE;
                    ETS_ConvertToUnifiedPort(&cmdResp.domainStatus.status.slavePort, &isStackingPort);
                    if (TRUE == isStackingPort) {
                        cmdResp.domainStatus.status.slavePort = ETHUTILS_INVALID_PORT;
                    }
                    *aReplyLen = sizeof(ETS_DomainNumAndStatusType);
                }
                break;
            case ETS_CMD_GETPORTSTATUS:
                {
                    uint32_t port = cmdResp.portStatus.num;
                    uint32_t isStackingPort = FALSE;

                    port = ETHUTILS_ConvertToLocalPort(port, &isStackingPort);
                    if (FALSE == isStackingPort) {
                        cmdResp.portStatus.status.magicId = ETS_PORT_STATUS_MAGIC_ID;
                        retVal = ETS_GetPortStatus(port, &cmdResp.portStatus.status);
                        *aReplyLen = sizeof(ETS_PortNumAndStatusType);
                    }
                }
                break;
            case ETS_CMD_GETDOMAINPORTSTATUS:
                {
                    uint32_t port = cmdResp.domainPortStatus.portNum;
                    ETS_DomainType domain = cmdResp.domainPortStatus.domain;
                    uint32_t isStackingPort = FALSE;

                    port = ETHUTILS_ConvertToLocalPort(port, &isStackingPort);
                    if (FALSE == isStackingPort) {
                        cmdResp.domainPortStatus.status.magicId = ETS_DOMAIN_PORT_STATUS_MAGIC_ID;
                        retVal = ETS_GetDomainPortStatus(domain, port, &cmdResp.domainPortStatus.status);
                        if (BCM_ERR_OK == retVal) {
                            cmdResp.domainPortStatus.stats.magicId = ETS_STATS_MAGIC_ID;
                            retVal = ETS_GetStats(port, domain, &cmdResp.domainPortStatus.stats);
                            *aReplyLen = sizeof(ETS_PerDomainPortStatusType);
                        }
                    }
                }
                break;
            case ETS_CMD_SETGLOBALTIME:
                retVal = ETS_SetGlobalTime(&cmdResp.time);
                *aReplyLen = 0UL;
                break;
#ifdef ENABLE_RECORD_NOTIFICATION
            case ETS_CMD_NOTIFY_RECORD:
                retVal = ETS_EnableRecordNotification(cmdResp.isNotifyingRecord);
                if ((BCM_ERR_OK == retVal) &&
                    (FALSE == cmdResp.isNotifyingRecord)) {
                    retVal = CIRCQ_Reset(ETS_GetRecordQ());
                }
                *aReplyLen = 0UL;
                break;
#endif
            default:
                retVal = BCM_ERR_NOSUPPORT;
                break;
        }
    }
    if (BCM_ERR_OK == retVal) {
        BCM_MemCpy(aCmdData, cmdResp.data, *aReplyLen);
    }
    return retVal;
}

/**
    @code{.unparsed}
    check input arguments and return BCM_ERR_INVAL_PARAMS on error
    if command is ETS_CMD_GETGLOBALSTATUS
        pick the config which has a valid slave port
        if neither one has a valid slave port (GM case)
            pick the config with the better clock state
    @endcode
    @trace #BRCM_SWARCH_ETSM_MODULE_GLOBAL
    @trace #BRCM_SWREQ_ETSM
*/
static int32_t ETSM_MergeResult (BCM_CmdType aCmd,
                                 uint32_t aLen,
                                 uint8_t *aOutResponse,
                                 int32_t *aOutResult,
                                 const uint8_t *aInResponse1,
                                 int32_t aInResult1,
                                 const uint8_t *aInResponse2,
                                 int32_t aInResult2)
{
    int32_t                retVal = BCM_ERR_OK;
    ETS_MsgUnionType output;
    ETS_MsgUnionType input1;
    ETS_MsgUnionType input2;

    if ((NULL == aOutResponse) ||
        (NULL == aOutResult) ||
        (NULL == aInResponse1) ||
        (NULL == aInResponse2)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        BCM_MemCpy(input1.data, aInResponse1, aLen);
        BCM_MemCpy(input2.data, aInResponse2, aLen);
        BCM_MemCpy(output.data, aOutResponse, aLen);

        switch (BCM_GET_CMDID(aCmd)) {
            case ETS_CMD_GETDOMAINSTATUS:
                if ((sizeof(ETS_DomainNumAndStatusType) != aLen) ||
                    (BCM_ERR_OK != aInResult1) ||
                    (BCM_ERR_OK != aInResult2)) {
                    retVal = BCM_ERR_INVAL_PARAMS;
                } else {
                    if (input1.domainStatus.status.slavePort != ETHUTILS_INVALID_PORT) {
                        BCM_MemCpy(&output.domainStatus,
                                   &input1.domainStatus,
                                   sizeof(ETS_DomainNumAndStatusType));
                    } else if (input2.domainStatus.status.slavePort != ETHUTILS_INVALID_PORT) {
                        BCM_MemCpy(&output.domainStatus,
                                   &input2.domainStatus,
                                   sizeof(ETS_DomainNumAndStatusType));
                    } else {
                        /* Must be in GM mode. Pick the response with a better clockState */
                        if (input1.domainStatus.status.clockState > input2.domainStatus.status.clockState) {
                            BCM_MemCpy(&output.domainStatus,
                                       &input1.domainStatus,
                                       sizeof(ETS_DomainNumAndStatusType));
                        } else {
                            BCM_MemCpy(&output.domainStatus,
                                       &input2.domainStatus,
                                       sizeof(ETS_DomainNumAndStatusType));
                        }
                    }
                    *aOutResult = BCM_ERR_OK;
                }
                break;
            case ETS_CMD_GETGLOBALSTATUS:
                if ((sizeof(ETS_GlobalStatusType) != aLen) ||
                    (BCM_ERR_OK != aInResult1) ||
                    (BCM_ERR_OK != aInResult2)) {
                    retVal = BCM_ERR_INVAL_PARAMS;
                } else {
                    *aOutResult = BCM_ERR_OK;
                }
                break;
            case ETS_CMD_SETGLOBALENABLE:
                if ((0UL != aLen) ||
                    (BCM_ERR_OK != aInResult1) ||
                    (BCM_ERR_OK != aInResult2)) {
                    retVal = BCM_ERR_INVAL_PARAMS;
                } else {
                    *aOutResult = BCM_ERR_OK;
                }
                break;
            default:
                retVal = BCM_ERR_NOSUPPORT;
                break;
        }
    }
    if (BCM_ERR_OK == retVal) {
        BCM_MemCpy(aOutResponse, output.data, aLen);
    }
    return retVal;
}

/**
    @code{.unparsed}
    return (ETS_TIMER_EVENT | ETHER_PKT_EVENT | ETHER_TIMESTAMP_EVENT)
    @endcode
    @trace #BRCM_SWARCH_ETSM_MODULE_GLOBAL
    @trace #BRCM_SWREQ_ETSM
*/
static uint32_t ETSM_GetEventMask(void)
{
    uint32_t eventMask = 0UL;
    ETSM_GetServer(NULL, &eventMask);
    eventMask |= (ETSM_EventInfo.timerEvent  |
                  ETSM_EventInfo.packetEvent |
                  ETSM_EventInfo.timestampEvent);
    return eventMask;
}

/**
    @code{.unparsed}
    if Timer event occurs
        invoke ETS_ProcessTimerEvent()
        if Record notification feature is enabled
            invoke ETS_PeriodicSendRecords
     if either packet or timestamp event occurs
         invoke ETS_ProcessNetworkEvents()
    @endcode
    @trace #BRCM_SWARCH_ETSM_MODULE_GLOBAL
    @trace #BRCM_SWREQ_ETSM
*/
static void ETSM_HandleEvents(uint32_t aMask)
{
    uint32_t msgQIdx = 0UL;
    int32_t retVal = BCM_ERR_OK;
    ETS_RpcMsgType *cmdResPtr;
    uint32_t replyLen = 0UL;
    BCM_CmdType cmd;

    if (0UL != (ETSM_EventInfo.timerEvent & aMask)) {
        /* Finally process timer event */
        ETS_ProcessTimerEvent();
#ifdef ENABLE_RECORD_NOTIFICATION
        ETS_PeriodicSendRecords();
#endif
    }

    if (0UL != ((ETSM_EventInfo.packetEvent | ETSM_EventInfo.timestampEvent) & aMask)) {
        ETS_ProcessNetworkEvents();
    }

    /* Try to fetch messages from the command message queue */
    do {
        retVal = MSGQ_GetMsgIdx(&ETSM_Module.cmdQ, &msgQIdx);
        if(BCM_ERR_OK == retVal) {
            cmdResPtr = &ETS_Handle.rpcCmds[msgQIdx];
            cmd = BCM_CMDID(BCM_GROUPID_ETHSRV,cmdResPtr->compID,cmdResPtr->cmdID);
            retVal = ETSM_ProcessCmd(cmd, &ETS_Handle.cmdState,
                                     cmdResPtr->payload, cmdResPtr->payloadLen,
                                     &replyLen);
            if (BCM_ERR_EAGAIN != retVal) {
                cmdResPtr->payloadLen = replyLen;
                cmdResPtr->ret = retVal;
                ETS_Handle.cmdState = BCM_STATE_SUB_STATE_RESET;
            }
            if((BCM_ERR_OK != retVal) && (BCM_ERR_EAGAIN != retVal)) {
                ETS_ErrorReport(BRCM_SWDSGN_ETSM_HANDLEEVENTS_PART_PROC, cmdResPtr->ret,
                                (uint32_t)__LINE__, cmd, retVal, 0UL);
            }
            if (BCM_ERR_EAGAIN != retVal) {
                /* Update the command processing as complete */
                retVal = MSGQ_CompleteMsgIdx(&ETSM_Module.cmdQ, msgQIdx);
            }
        }
    } while(BCM_ERR_OK == retVal);
}

/**
    @code{.unparsed}
    return BCM_ERR_OK
    @endcode
    @trace #BRCM_SWARCH_ETSM_MODULE_GLOBAL
    @trace #BRCM_SWREQ_ETSM
*/
static int32_t ETSM_ResetStateChangeHandler(BCM_StateType aRequestedState)
{
    return BCM_ERR_OK;
}

/**
    @code{.unparsed}
    if magic in config is valid
    invoke ETS_UpdateConfig()
    @endcode
    @trace #BRCM_SWARCH_ETSM_MODULE_GLOBAL
    @trace #BRCM_SWREQ_ETSM
*/
static int32_t ETSM_InitStateChangeHandler(BCM_StateType aRequestedState)
{
    if (ETS_CONFIG_MAGIC_ID == ETS_Handle.config.magicId) {
        ETS_UpdateConfig(&ETS_Handle.config, TRUE);
    } else {
        ETS_ErrorReport(BRCM_SWDSGN_ETSM_INITSTATECHNGHNDLR_PART_PROC,
                        BCM_ERR_INVAL_MAGIC, __LINE__, ETS_Handle.config.magicId, 0UL, 0UL);
    }

    return BCM_ERR_OK;
}

/**
    @code{.unparsed}
    if requested state is RUN
       initialize the network queues
       initialize the library
       start the timer alarm
    else
       stop the ETS
    @endcode
    @trace #BRCM_SWARCH_ETSM_MODULE_GLOBAL
    @trace #BRCM_SWREQ_ETSM
*/
static int32_t ETSM_ReadyStateChangeHandler(BCM_StateType aRequestedState)
{
    int32_t retVal;

    if (BCM_STATE_RUN == aRequestedState) {
        ETSM_InitNetworkQueues();
        retVal = ETS_Init(&ETS_Handle.config);
        if (BCM_ERR_OK == retVal) {
            ETSM_StartTimer();
        }
    } else {
        retVal = ETSM_Stop(aRequestedState);
    }

    return retVal;
}

/**
    @code{.unparsed}
    stop the ETS
    @endcode
    @trace #BRCM_SWARCH_ETSM_MODULE_GLOBAL
    @trace #BRCM_SWREQ_ETSM
*/
static int32_t ETSM_RunStateChangeHandler(BCM_StateType aRequestedState)
{
    return  ETSM_Stop(aRequestedState);
}


/**

    @trace #BRCM_SWARCH_ETSM_MODULE_GLOBAL
    @trace #BRCM_SWREQ_ETSM
*/
static int32_t ETSM_AsyncMsgHandler(BCM_CmdType aNotfn,
                                    const uint8_t *aMsg,
                                    uint32_t aLen,
                                    uint32_t *aForwardToHost)
{
    *aForwardToHost = TRUE;
    return BCM_ERR_OK;
}

/**
    @brief Fetch the command message based on index

    @trace #BRCM_SWARCH_ETSM_MODULE_GLOBAL
    @trace #BRCM_SWREQ_ETSM
*/
static void* ETSM_MsgQGetCmd(uint32_t idx)
{
    void* pRet = NULL;
    if (idx < ETS_RPC_MSGQ_COUNT) {
        pRet = (void *)(&ETS_Handle.rpcCmds[idx]);
    }
    return pRet;
}

/**
    @brief EthSrv Module function table for ETS

    This table provides the EthSrv module interface
    exposed by ETS

    @trace #BRCM_SWREQ_ETSM
    @trace #BRCM_SWARCH_ETSM_MODULE_GLOBAL
*/
const MODULE_Type ETSM_Module =
{
    .groupID           = BCM_GROUPID_ETHSRV,
    .compID            = BCM_ETS_ID,
    .configImgID       = SYS_CONFIG_ID_ETS,
    .configImgData     = (uint8_t*)&ETS_Handle.config,
    .configImgSize     = sizeof(ETS_ConfigType),
    .context           = &ETS_Handle.moduleContext,
    .resetStateHandler = ETSM_ResetStateChangeHandler,
    .initStateHandler  = ETSM_InitStateChangeHandler,
    .readyStateHandler = ETSM_ReadyStateChangeHandler,
    .runStateHandler   = ETSM_RunStateChangeHandler,
    .eventHandler      = ETSM_HandleEvents,
    .cmdQ = MSGQ_INIT_V2(ETSM_GetServer, MSGQ_CLIENT_SIGNAL_ENABLE,
                         ETS_RpcMsgType, ETS_RPC_MSGQ_COUNT,
                         &ETS_Handle.rpcMsgQCtx, ETSM_MsgQGetCmd),
    .sendCmd           = ETSM_SendCmd,
    .getResp           = ETSM_GetResp,
    .processCmd        = ETSM_ProcessCmd,
    .mergeResult       = ETSM_MergeResult,
    .getEventMask      = ETSM_GetEventMask,
    .asyncMsg          = ETSM_AsyncMsgHandler,
    .subModules        = NULL,
};

/** @} */
