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

/** @defgroup grp_ets_il Integration Guide
    @ingroup grp_ets

    @addtogroup grp_ets_il
    @{
    @section sec_ets_integration Integration Guide
    This page describes functions needed by an integrator. These need to be
    implemented by the integrator.

    ETS operates as an asynchronous event driven system. The ETS library
    implements the core logic for PDU parsing, creation and the various state
    machines for gPTP operation. The ETS OSIL provides a wrapper around the
    library and abstracts the interaction with the rest of the system. A single
    instance of the ETS module is required for operation in either endpoint or
    bridge mode.

    @section sec_comp_il_fsm State Machine
    The ETS OSIL does not have a state machine. It relies on the state machine
    in the library.

    @section sec_comp_il_seq Sequence Diagram
    <BR>
    The figure below depicts the typical flow for initialization and
    deinitialization
    @image html etscomp_init_deinit_seq.png
    The figure below depicts the typical flow of PDU transmission
    @image html etscomp_tx_seq.png
    The figure below depicts the typical flow of PDU transmit confirmation
    @image html etscomp_tx_conf_seq.png
    The figure below depicts the typical flow of PDU reception
    @image html etscomp_rx_seq.png
    The figure below depicts the flow for timer invocation
    @image html etscomp_timer.png
    The figure below depicts the typical flow of callback events
    @image html etscomp_event_seq.png

    @file ets_osil.h
    @brief Ethernet TimeSync library integration interfaces.
    This header file defines the integration interfaces for ETS library.
    @version 1.25 Imported from MS Word document
*/
#ifndef ETS_OSIL_H
#define ETS_OSIL_H

#include <nif.h>
#include <ethxcvr.h>
#include <bcm_time.h>
#include "ets.h"
#include <ets_pdu.h>
#include <ethernet_ets.h>

/**
    @name ETS IL API IDs
    @{
    @brief API IDs for ETS IL
 */
#define BRCM_SWARCH_ETS_CMDRESP_TYPE                     (0x9302U)    /**< @brief #ETS_CmdRespType             */
#define BRCM_SWARCH_ETSM_EVENT_TYPE                      (0x9303U)    /**< @brief #ETSM_EventType              */
#define BRCM_SWARCH_ETSM_EVENTINFO_GLOBAL                (0x9304U)    /**< @brief #ETSM_EventInfo              */
#define BRCM_SWARCH_ETS_RXPKTINDICATION_PROC             (0x9305U)    /**< @brief #ETS_RxPktIndication         */
#define BRCM_SWARCH_ETS_TXPKTCONFIRMATION_PROC           (0x9306U)    /**< @brief #ETS_TxPktConfirmation       */
#define BRCM_SWARCH_ETS_RXPKTTSINDICATION_PROC           (0x9307U)    /**< @brief #ETS_RxPktTSIndication       */
#define BRCM_SWARCH_ETS_TXPKTTSINDICATION_PROC           (0x9308U)    /**< @brief #ETS_TxPktTSIndication       */
#define BRCM_SWARCH_ETS_TRANSMIT_PROC                    (0x9309U)    /**< @brief #ETS_Transmit                */
#define BRCM_SWARCH_ETS_CONFIGSAVECALLBACK_PROC          (0x930AU)    /**< @brief #ETS_ConfigSaveCallback      */
#define BRCM_SWARCH_ETS_EVENTCALLBACK_PROC               (0x930BU)    /**< @brief #ETS_EventCallback           */
#define BRCM_SWARCH_ETS_SHELL_PROC                       (0x930CU)    /**< @brief #ETS_Shell                   */
#define BRCM_SWARCH_ETS_RECORDCALLBACK_PROC              (0x930DU)    /**< @brief #ETS_RecordCallback          */
#define BRCM_SWARCH_ETS_CONVERT_TO_UNIFIED_PORT_PROC     (0x930EU)    /**< @brief #ETS_ConvertToUnifiedPort    */
#define BRCM_SWARCH_ETS_GETCONFIG_PROC                   (0x930FU)    /**< @brief #ETS_GetConfig               */
/** @} */

/**
    @brief Command-Response structure for command queue

    @trace #BRCM_SWREQ_ETS_TYPES
*/
typedef struct sETS_CmdRespType {
    ETS_CmdType      cmdId;                             /**< @brief Command identifier */
    int32_t          ret;                               /**< @brief Return status */
    uint8_t          payload[ETS_CMDRESP_PAYLOAD_SIZE]; /**< @brief Space for command response payload */
    ETS_MsgUnionType payloadPtr;                        /**< @brief Pointer to payload */
} ETS_CmdRespType;

/**
    @brief ETS module event structure

    @trace #BRCM_SWREQ_ETSM
*/
typedef struct sETSM_EventType {
    uint32_t packetEvent;      /**< @brief Packet transmit/receive completion event */
    uint32_t timestampEvent;   /**< @brief Timestamp capture event */
    uint32_t timerEvent;       /**< @brief Periodic timer expiry event */
} ETSM_EventType;

/**
    @brief ETS module event structure object

    @trace #BRCM_SWREQ_ETSM
*/
extern const ETSM_EventType ETSM_EventInfo;

/** @brief Receive gPTP PDU

    @pre None

    Invoked by the network interface to handover gPTP PDU to the module
    which has registered for the gPTP ethertype

    @behavior Sync, Non-reentrant

    @param[in]   aCtrlIdx           NIF controller identifier
    @param[in]   aPktBuf            Pointer to packet buffer
    @param[in]   aPktLen            Length of packet
    @param[in]   aSrcMacAddr        Source MAC addrss of packet
    @param[in]   aDestMacAddr       Destination MAC address of packet
    @param[in]   aPriority          Priority of L2 packet

    @return      void

    @post None

    @limitations To be invoked by a higher priority task than ETS protocol task
    @trace #BRCM_SWREQ_ETS_NIF_CALLBACK
*/
void ETS_RxPktIndication (NIF_CntrlIDType aCtrlIdx,
                          const uint8_t *const aPktBuf,
                          uint16_t aPktLen,
                          const uint8_t *const aSrcMacAddr,
                          const uint8_t *const aDestMacAddr,
                          uint32_t aPriority);

/** @brief gPTP PDU transmit confirmation

    @pre None

    Invoked by the network interface to inform that a gPTP PDU was
    successfully transmitted

    @behavior Sync, Non-reentrant

    @param[in]   aCtrlIdx           NIF controller identifier
    @param[in]   aBufIdx            Buffer identifier for the packet

    @return      void

    @post None

    @limitations To be invoked by a higher priority task than ETS protocol task
    @trace #BRCM_SWREQ_ETS_NIF_CALLBACK
*/
void ETS_TxPktConfirmation (NIF_CntrlIDType aCtrlIdx,
                            uint32_t aBufIdx);

/** @brief Persist the Pdelay and Rate Ratio in NVM

    @pre None

    Peer delay and neighbor rate ratio for a port to be stored in
    NVM. This is expected to be implemented by the integration layer

    @behavior Sync, Non-reentrant

    @param[in]   aPortIdx           Port number
    @param[in]   aPdelay            Peer delay on the port
    @param[in]   aRateRatio         Neighbor rate ratio on the port

    @return      void

    @post None

    @limitations This is invoked in the context of the ETS protocol task and
    care should be taken to not perform any time consuming operations which
    could affect protocol performance
    @trace #BRCM_SWREQ_ETS_CORE
*/
void ETS_ConfigSaveCallback (const uint32_t aPortIdx,
                             const uint32_t aPdelay,
                             const int32_t  aRateRatio);

/** @brief Receive packet timestamp callback

    @pre ETS_RxPktIndication() should have been invoked with the same
    identifiers i.e. aCtrlIdx & aBuf. When operating in bridge mode,
    ETS_RxMgmtInfoIndication() should also have been invoked with the same
    identifiers i.e. aCtrlIdx, aBuf and aMgmtInfo

    Invoked by the network interface with the ingress hardware timestamp
    corresponding to a received packet

    @behavior Sync, Non-reentrant

    @param[in]   aCtrlIdx        Controller index
    @param[in]   aBuf            Pointer to the packet buffer
    @param[in]   aMgmtInfo       Pointer to management information
    @param[in]   aTS             Pointer to timestamp
    @param[in]   aTSQual         Pointer to quality of captured timestamp

    @return      void

    @post None

    @limitations To be invoked by a higher priority task than ETS protocol task
    @trace #BRCM_SWREQ_ETS_NIF_CALLBACK
*/
void ETS_RxPktTSIndication(NIF_CntrlIDType aCtrlIdx,
                     const uint8_t *const aBuf,
                     ETHXCVR_IDType aXcvrID,
                     const ETHER_TimestampType *const aTS,
                     const ETHER_TimestampQualType* const aTSQual);

/** @brief Transmit packet timestamp callback

    @pre ETS_TxPktConfirmation() should have been invoked with the same
    identifiers i.e. aCtrlIdx & aBufIdx

    Invoked by the network interface with the egress hardware timestamp
    corresponding to a transmitted packet

    @behavior Sync, Non-reentrant

    @param[in]   aCtrlIdx        Controller index
    @param[in]   aBuf            Pointer to the packet buffer
    @param[in]   aMgmtInfo       Pointer to management information
    @param[in]   aTS             Pointer to timestamp
    @param[in]   aTSQual         Pointer to quality of captured timestamp

    @return      void

    @post None

    @limitations To be invoked by a higher priority task than ETS protocol task
    @trace #BRCM_SWREQ_ETS_NIF_CALLBACK
*/
void ETS_TxPktTSIndication(NIF_CntrlIDType aCtrlIdx,
                     uint32_t aBufIdx,
                     ETHXCVR_IDType aXcvrID,
                     const ETHER_TimestampType *const aTS,
                     const ETHER_TimestampQualType* const aTSQual);

/** @brief Event notification from the module

    @pre None

    Notifies the higher layers of gPTP events. This is expected to be
    implemented by the integration layer

    @behavior Sync, Non-reentrant

    @param[in]   aPortIdx           Port number
    @param[in]   aEvent             Event to be notified

    @return      void

    @post None

    @limitations This is invoked in the context of the ETS protocol task and
    care should be taken to not perform any time consuming operations which
    could affect protocol performance
    @trace #BRCM_SWREQ_ETS_CORE
*/
void ETS_EventCallback (const uint32_t aPortIdx,
                        const ETS_EventType aEvent);

/** @brief Transmit 802.1as PDU

    @pre None

    Transmits the provided L2 buffer. Enables timestamping for event messages
    and adds an entry to the transmit confirmation wait queue.
    For bridge mode also sets the management information.

    @behavior Sync, Non-reentrant

    @param[in]  aPortNum                Port number
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
int32_t ETS_Transmit(const uint32_t        aPortNum,
                     const NIF_CntrlIDType aCtrlIdx,
                     const uint32_t        aBufIdx,
                     const uint32_t        aLen,
                     const uint32_t        aPktType,
                     const uint32_t        aIsEventMsg,
                     const uint8_t* const  aDstMacAddr);

/** @brief Callback reporting the records for an interface

    @pre None

    Report containing records for all packet types for an interface
    Invoked once every 31.25ms

    @behavior Sync, Non-reentrant

    @param[in]  aRecord          Pointer to record

    @return  void

    @post None

    @note This routine needs to be implemented by the integrator
    @trace #BRCM_SWREQ_ETS_CORE
*/
void ETS_RecordCallback(ETS_RecordType* const aRecord);

/** @brief Get the port number for an interface

    @pre None

    Convert the HW port number to port number which can be used for
    portIdentity

    @behavior Sync, Reentrant

    @param[inout]  aPortNum             Port number
    @param[out]    aIsStackingPort      Pointer to location to store whether
                                        the port is a stacking link

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETS_TYPES
*/
void ETS_ConvertToUnifiedPort(uint32_t *const aPortNum,
                              uint32_t *const aIsStackingPort);

/** @brief Handle shell command

    @pre None

    This interface is invoked by the Console command handler to handle input
    gPTP commands

    @behavior Sync, Non-reentrant

    @param[in]   aConsoleID           Console identifier
    @param[in]   aArgString           String containing input shell command
    @param[in]   aArgStringLen        Length of aArgString

    @retval      void

    @post None

    @limitations User log buffer is used for responding to the input command
    @trace #BRCM_SWREQ_ETS
*/
void ETS_Shell(uint32_t aConsoleID,
               char* aArgString,
               uint32_t aArgStringLen);

/** @brief Get the configuration

    @pre None

    Return pointer to cached configuration

    @behavior Sync, Reentrant

    @retval      Pointer to cached configuration

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETS_TYPES
*/
const ETS_ConfigType* ETS_GetConfig(void);

#endif /* ETS_OSIL_H*/
/** @} */
