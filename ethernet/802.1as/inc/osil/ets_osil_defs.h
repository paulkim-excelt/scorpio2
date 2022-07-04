/*****************************************************************************
 Copyright 2020-2021 Broadcom Limited.  All rights reserved.

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
    @section sec_ets_integration Switch Integration Guide
    This page describes functions needed by an integrator. These need to be
    implemented by the integrator.


    @file ets_osil_defs.h
    @brief Ethernet TimeSync library switch integration interfaces.
    This header file defines the switch integration interfaces for ETS library.
    @version 0.1 Initial version
*/
#ifndef ETS_OSIL_DEFS_H
#define ETS_OSIL_DEFS_H

#include <module.h>
#include <circ_queue.h>
#include <module_osil.h>
#include "ets_osil.h"

/**
    @name ETS IL API IDs
    @{
    @brief API IDs for ETS IL
 */
#define BRCM_SWARCH_ETS_PKTEVENT_TYPE                 (0x9501U)    /**< @brief #ETS_PktEventType        */
#define BRCM_SWARCH_ETS_NETWORKEVENT_TYPE             (0x9502U)    /**< @brief #ETS_NetworkEventType    */
#define BRCM_SWARCH_ETS_NUM_TX_WAITQ_PKTS_MACRO       (0x9503U)    /**< @brief #ETS_NUM_TX_WAITQ_PKTS   */
#define BRCM_SWARCH_ETS_TXWAITPKT_TYPE                (0x9504U)    /**< @brief #ETS_TxWaitPktType       */
#define BRCM_SWARCH_ETS_CONTEXT_TYPE                  (0x9505U)    /**< @brief #ETS_ContextType         */
#define BRCM_SWARCH_ETS_ERRORREPORT_PROC              (0x9506U)    /**< @brief #ETS_ErrorReport         */
#define BRCM_SWARCH_ETS_GETNETWORKQ_PROC              (0x9507U)    /**< @brief #ETS_GetNetworkQ         */
#define BRCM_SWARCH_ETS_GETHANDLE_PROC                (0x9508U)    /**< @brief #ETS_GetHandle           */
#define BRCM_SWARCH_ETS_TRANSMIT_SWITCH_PROC          (0x9509U)    /**< @brief #ETS_TransmitSwitch      */
#define BRCM_SWARCH_ETS_PERIODIC_SEND_RECORDS_PROC    (0x950AU)    /**< @brief #ETS_PeriodicSendRecords */
#define BRCM_SWARCH_ETS_GETRECORDQ_PROC               (0x950BU)    /**< @brief #ETS_GetRecordQ          */
#define BRCM_SWARCH_ETS_UPDATE_CONFIG_PROC            (0x950CU)    /**< @brief #ETS_UpdateConfig        */
#define BRCM_SWARCH_ETSM_STARTTIMER_PROC              (0x950DU)    /**< @brief #ETSM_StartTimer         */
#define BRCM_SWARCH_ETSM_STOPTIMER_PROC               (0x950EU)    /**< @brief #ETSM_StopTimer          */
#define BRCM_SWARCH_ETS_RPCMSG_TYPE                   (0x9510U)    /**< @brief #ETS_RpcMsgType         */
#define BRCM_SWARCH_ETS_RPC_MSGQ_COUNT_MACRO          (0x9511U)    /**< @brief #ETS_RPC_MSGQ_COUNT     */
#define BRCM_SWARCH_ETSM_GETSERVER_PROC               (0x9512U)    /**< @brief #ETSM_GetServer          */
/** @} */

/**
    @brief Macro for size of transmit confirmation wait queue

    Queue to keep track of sent packets for which Tx Confirmation
    is not yet received. We need only 3 slots per interface

    @trace #BRCM_SWREQ_ETS_TYPES
*/
#define ETS_NUM_TX_WAITQ_PKTS      (24UL)

/**
    @name ETS_PktEvent
    @{
    @brief Ethernet L2 packet event type

    @trace #BRCM_SWREQ_ETS_TYPES
*/
typedef uint32_t ETS_PktEventType; /**< @brief typedef for ETS packet event */
#define ETS_PKTEVENT_RX (0UL)   /**< @brief L2 packet received */
#define ETS_PKTEVENT_TX (1UL)   /**< @brief L2 packet transmitted */
/** @} */

/**
    @brief Structure for transmit confirmation wait queue

    @trace #BRCM_SWREQ_ETS_TYPES
*/
typedef struct sETS_TxWaitPktType {
    uint32_t intfIdx;    /**< @brief Internal interface identifier */
    uint32_t bufIdx;     /**< @brief L2 packet buffer identifier */
    uint32_t pktType;    /**< @brief Transmitted packet's type */
    uint32_t isEventMsg; /**< @brief Does transmitted packet contain an
                              event PDU ? */
} ETS_TxWaitPktType;

/**
    @brief Structure for network event queue. This is overloaded to handle
    both transmit and receive packet events

    @trace #BRCM_SWREQ_ETS_TYPES
*/
typedef struct sETS_NetworkEventType {
    ETS_PktEventType eventId;            /**< @brief Event identifier */
    uint32_t  intfIdx;                   /**< @brief Internal interface
                                              identifier */
    uint32_t  bufIdx;                    /**< @brief L2 packet buffer
                                              identifier */
    uint16_t pktLen;                     /**< @brief L2 packet length. Valid
                                              only for ETS_PKTEVENT_RX */
    ETS_TimeType timestamp;              /**< @brief HW Timestamp for event
                                              messages */
    uint32_t timestampValid;             /**< @brief Indicates whether the
                                              timestamp field is valid or not */
    uint8_t  rxBuffer[ETS_MAX_PDU_SIZE]; /**< @brief Received packet buffer */
    uint8_t  dstMacAddr[6UL];            /**< @brief Received packet's
                                              destination MAC address */
    uint32_t pktType;                    /**< @brief Transmitted packet's type*/
} ETS_NetworkEventType;

/**
    @brief Max count of entries in RPC MsgQ

    @trace #BRCM_SWREQ_ETS_TYPES
*/
#define ETS_RPC_MSGQ_COUNT       (4UL)

/**
    @brief Command-Response structure for command queue

    @trace #BRCM_SWREQ_ETS_TYPES
*/
typedef struct sETS_RpcMsgType {
    uint8_t        cmdID;                       /**< @brief Switch/Ethernet command identifier */
    BCM_CompIDType compID;                      /**< @brief Component identifier */
    int32_t        ret;                         /**< @brief Return status */
    uint32_t       payloadLen;                  /**< @brief Length of command payload in bytes */
    uint8_t        payload[ETS_MAX_PAYLOAD_SIZE];  /**< @brief Space for command response payload */
} ETS_RpcMsgType;

/**
    @brief Structure for ETS context

    @trace #BRCM_SWREQ_ETS_TYPES
*/
typedef struct sETS_ContextType {
    ETS_ConfigType       config;                           /**< @brief Cached
                                                                configuration */
    ETS_NetworkEventType events[ETS_NUM_NETWORK_EVENTS];   /**< @brief Array of
                                                                network event
                                                                structures for the
                                                                events queue */
    uint32_t             networkQAllocFlags;               /**< @brief Flag to track
                                                                allocation of slots
                                                                in the network
                                                                queue */
    uint32_t             currRxIdx;                        /**< @brief Index of the
                                                                slot in the network
                                                                queue allocated for
                                                                the last received
                                                                packet */
    uint32_t             currTxIdx;                        /**< @brief Index of the
                                                                slot in the network
                                                                queue allocated for
                                                                the last transmitted
                                                                packet */
    ETS_TxWaitPktType     txWaitPkts[ETS_NUM_TX_WAITQ_PKTS];/**< @brief Array of
                                                                 structures for the
                                                                 transmit
                                                                 confirmation wait
                                                                 queue */
    uint32_t              txWaitQAllocFlags;                /**< @brief Flag to track
                                                                 allocation of slots
                                                                 in the transmit
                                                                 confirmation wait
                                                                 queue */

    MODULE_ContextType    moduleContext;                    /**< @brief Module context */

#ifdef ENABLE_RECORD_NOTIFICATION
    uint8_t               numTimerTicks;                    /**< @brief Count of timer ticks
                                                                 after */
#endif
    BCM_SubStateType      cmdState;                         /**< @brief Command
                                                                 processing state */
    ETS_RpcMsgType        rpcCmds[ETS_RPC_MSGQ_COUNT];      /**< @brief Memory
                                                                 for RPC commands  */
    MSGQ_CtxType          rpcMsgQCtx;                       /**< @brief Memory for
                                                                  MsgQ context  */
} ETS_ContextType;

/** @brief Report error information to DET/DEM

    Report error information to DET/DEM

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  aApiID                 API identifier
    @param[in]  aErr                   Error number
    @param[in]  aVal0                  Additional error information
    @param[in]  aVal1                  Additional error information
    @param[in]  aVal2                  Additional error information
    @param[in]  aVal3                  Additional error information

    @return     void

    @post None

    @trace #BRCM_SWREQ_ETS_TYPES

    @limitations None
*/
void ETS_ErrorReport(uint16_t aApiID, int32_t aErr, uint32_t aVal0,
                     uint32_t aVal1, uint32_t aVal2, uint32_t aVal3);

/** @brief Perform Transmit 802.1as PDU

    @pre None

    Transmits the provided L2 buffer. Enables timestamping for event messages
    and adds an entry to the transmit confirmation wait queue.
    For bridge mode also sets the management information.

    @behavior Sync, Non-reentrant

    @param[in]  aIntfNum                Interface number
    @param[in]  aCtrlIdx                NIF controller index
    @param[in]  aBufIdx                 Identifier of the L2 buffer to be sent
    @param[in]  aLen                    Length of PDU in the buffer
    @param[in]  aPktType                gPTP packet type
    @param[in]  aIsEventMsg             Is PDU an event messageg
    @param[in]  aDstMacAddr             Destination MAC address for the PDU

    @return  #BCM_ERR_OK                Transmit succeeded
    @return  #BCM_ERR_NOMEM             The waitTxQ is full
    @return  #BCM_ERR_INVAL_PARAMS      Buffer index is invalid
    @return  #BCM_ERR_BUSY              Network interface queue full
    @return  #BCM_ERR_INVAL_STATE       Network interface is in invalid state
    @return  #BCM_ERR_INVAL_BUF_STATE   Buffer is in invalid state

    @post None

    @limitations This is invoked in the context of the ETS protocol task and
    care should be taken to not perform any time consuming operations which
    could affect protocol performance
    @trace #BRCM_SWREQ_ETS_CORE
*/
int32_t ETS_TransmitSwitch(const uint32_t        aIntfNum,
                           const NIF_CntrlIDType aCtrlIdx,
                           const uint32_t        aBufIdx);

/** @brief Get network queue

    @pre None

    Return handle to network queue

    @behavior Sync, Non-reentrant

    @return  Handle to network queue

    @post None

    @trace #BRCM_SWREQ_ETS
*/
CIRCQ_Type * ETS_GetNetworkQ(void);

#ifdef ENABLE_RECORD_NOTIFICATION
/** @brief Get records queue

    @pre None

    Return handle to records queue

    @behavior Sync, Non-reentrant

    @return  Handle to records queue

    @post None

    @trace #BRCM_SWREQ_ETS
*/
CIRCQ_Type * ETS_GetRecordQ(void);

/** @brief Send records to host

    @pre None

    Periodicially flush the records queue and send the
    records to the host

    @behavior Sync, Non-reentrant

    @return  void

    @post None

    @trace #BRCM_SWREQ_ETS
*/
void ETS_PeriodicSendRecords(void);
#endif

/** @brief Get ETS context handle

    @pre None

    Return handle to ETS context

    @behavior Sync, Non-reentrant

    @return  Handle to ETS context

    @post None

    @trace #BRCM_SWREQ_ETS_TYPES
*/
ETS_ContextType* ETS_GetHandle(void);

/** @brief Update ETS configuration

    @pre None

    Update the ETS configuration with any internal ports. Also
    convert any unified port numbers to local port numbers

    @behavior Sync, Non-reentrant

    @param[inout]  aConfig           Pointer to config to be updated
    @param[in]     aUnifiedToLocal   Flag indicating whether the hwPort
                                     number field is to be converted
                                     to unified number or local number

    @return  void

    @post None

    @trace #BRCM_SWREQ_ETS
*/
void ETS_UpdateConfig(ETS_ConfigType *const aConfig,
                      uint32_t aUnifiedToLocal);

/** @brief Start periodic timer

    @pre None

    Request OS to start the period timer

    @behavior Sync, Non-reentrant

    @return  void

    @post None

    @trace #BRCM_SWREQ_ETSM
*/
void ETSM_StartTimer(void);

/** @brief Stop periodic timer

    @pre None

    Request OS to stop the period timer

    @behavior Sync, Non-reentrant

    @return  void

    @post None

    @trace #BRCM_SWREQ_ETSM
*/
void ETSM_StopTimer(void);

/** @brief API to return the Task and event for the ETS module

    @behavior Sync, Re-entrant

    @pre None

    @param[out]     aServerTask         Server task ID
    @param[out]     aServerEvent        Event mask

    Return values are documented in reverse-chronological order
    @retval       void

    @limitations None.

    @trace #BRCM_SWREQ_ETSM
*/
extern void ETSM_GetServer(int32_t *aServerTask, uint32_t *aServerEvent);

#endif /* ETS_OSIL_DEFS_H*/
/** @} */
