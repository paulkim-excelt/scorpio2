/*****************************************************************************
 Copyright 2017-2022 Broadcom Limited.  All rights reserved.

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
  @section sec_inet_integration Integration Guide
  This page describes functions needed by an integrator.

  @section sec_inet_il_seq Sequence Diagram
  <BR>
  @image html inetlib_il_udptx_seq.png
  Above figure depicts the typical flow of UDP transmission
  @image html inetlib_il_udprx_seq.png
  Above figure depicts the typical flow of UDP reception
  @image html inetlib_il_arprx_seq.png
  Above figure depicts the typical flow of ARP reception

  @file inet_osil.h
  @brief Integration APIs of Internet Stack subsystem
  This file provides the integration interface/APIs for the Internet stack
  @version 0.86 Imported from MS Word document
*/

#ifndef INET_OSIL_H
#define INET_OSIL_H

#include <nif.h>
#include <inet_cfg.h>
#include <dhcp.h>

/**
    @name INET IL API IDs
    @{
    @brief API IDs for INET IL
*/
#define BRCM_SWARCH_INET_INIT_PROC                    (0x9201U)    /**< @brief #INET_Init                      */
#define BRCM_SWARCH_INET_PROCESSTIMERS_PROC           (0x9202U)    /**< @brief #INET_ProcessTimers             */
#define BRCM_SWARCH_INET_RXIPV4PKT_PROC               (0x9203U)    /**< @brief #INET_RxIPv4Pkt                 */
#define BRCM_SWARCH_INET_RXARPPKT_PROC                (0x9204U)    /**< @brief #INET_RxARPPkt                  */
#define BRCM_SWARCH_INET_TXPKTCONF_PROC               (0x9205U)    /**< @brief #INET_TxPktConfirmation         */
#define BRCM_SWARCH_INET_BUFAVAIL_PROC                (0x9206U)    /**< @brief #INET_BufferAvailableIndication */
#define BRCM_SWARCH_INET_INFORMCLIENTRXTASK_PROC      (0x9207U)    /**< @brief #INET_InformClientRxTask        */
#define BRCM_SWARCH_INET_INFORMCLIENTTXTASK_PROC      (0x9208U)    /**< @brief #INET_InformClientTxTask        */
#define BRCM_SWARCH_INET_CONFIG_MACRO                 (0x9209U)    /**< @brief #INET_Config                    */
#define BRCM_SWARCH_INET_UPDATEINTERFACE_PROC         (0x920AU)    /**< @brief #INET_UpdateInterface           */
#define BRCM_SWARCH_INET_SETENDPOINTINTERFACE_PROC    (0x920BU)    /**< @brief #INET_SetEndPointInterface      */
#define BRCM_SWARCH_INET_TIMER_ALARMCB_PROC           (0x920CU)    /**< @brief #INET_Timer_AlarmCb             */
#define BRCM_SWARCH_INET_EVENT_TYPE                   (0x920DU)    /**< @brief #INET_EventType                 */
#define BRCM_SWARCH_INET_EVENTINFO_GLOBAL             (0x920EU)    /**< @brief #INET_EventInfo                 */
#define BRCM_SWARCH_INET_DHCPCONFIG_GLOBAL            (0x920FU)    /**< @brief #INET_DHCPConfig                */
/** @} */

/**
    @name INET module event structure

    @trace #BRCM_SWREQ_INET_MODULE
*/
typedef struct sINET_EventType {
    uint32_t inetTimer;  /**< @brief Events for internet stack */
    uint32_t tcpCtrl;    /**< @brief TCP control event */
    uint32_t dhcpRx;     /**< @brief Events for internet stack - Rx */
    uint32_t dhcpTx;     /**< @brief Events for internet stack - Tx */
} INET_EventType;

/**
    @brief Event structure object of INET module

    @trace #BRCM_SWREQ_INET_MODULE
*/
extern const INET_EventType INET_EventInfo;

/**
    @brief DHCP Configuration

    @trace #BRCM_SWREQ_INET_MODULE
*/
extern const DHCP_ConfigType INET_DHCPConfig;

/**
    @trace #BRCM_SWREQ_INET
*/
extern const INET_CfgType INET_Config;

/**
    @brief Initialize the internet stack

    @pre None

    Performs initialization of the internet stack

    @behavior Sync, Non re-entrant

    @return      void

    @post None

    @trace #BRCM_SWREQ_INET

    @limitations None
*/
void INET_Init(void);

/**
    @brief Update parameters of INET interface

    @pre None

    Updates the parameters of the INET stack

    @behavior Sync, Non re-entrant

    @param[in]   aIntfID                    Interface ID
    @param[in]   aAddrType                  Whether IP address is Static/DHCP
    @param[in]   aIntfIPAddr                Interface IP address
    @param[in]   aIntfNetmask               Interface netmask
    @param[in]   aIntfGatewayIP             Interface gateway IP address
    @param[in]   aIntfParams                Pointer to VLAN & PCP value

    @return      #BCM_ERR_OK                On success
    @return      #BCM_ERR_NOPERM            aIntfIPAddr already used by another
                                            interface
    @return      #BCM_ERR_INVAL_PARAMS      if aIntfID is greater than the maximum
                                            number of created interfaces
    @return      #BCM_ERR_INVAL_PARAMS      if aIntfParams is NULL
    @return      #BCM_ERR_INVAL_PARAMS      if aIntfIPAddr OR aIntfNetmask OR
                                            aIntfGatewayIP OR aAddrType is zero
    @post None

    @trace #BRCM_SWREQ_INET

    @limitations None
*/
int32_t INET_UpdateInterface(INET_InterfaceIdType aIntfID,
                             INET_IPAddressAssignmentType aAddrType,
                             INET_IPAddressType aIntfIPAddr,
                             INET_NetmaskType aIntfNetmask,
                             INET_IPAddressType aIntfGatewayIP,
                             const INET_InterfaceVlanTagConfigType *const aIntfParams);

/**
    @brief Update interface index of INET end point

    @pre None

    This API is used to update the interface on which the end point
    needs to transmit packets.

    @behavior Sync, Non re-entrant

    @param[in]   aCompId               Component identifier
    @param[in]   aPayloadId            Payload identifier
    @param[in]   aIntfID               Interface ID

    @return      #BCM_ERR_OK                On success
    @return      #BCM_ERR_NOPERM            if an end point already mapped to the #aIntfID
                                            already uses same UDP local port number that is
                                            being mapped using <aCompId, aPayloadId>
                                            Note: We do not allow two endpoints on a single interface
                                            to share the same local port number
    @return      #BCM_ERR_INVAL_PARAMS      if aCompId is zero
    @return      #BCM_ERR_INVAL_PARAMS      if aIntfID is greater than the maximum
                                            number of created interfaces
    @post None

    @trace #BRCM_SWREQ_INET

    @limitations None
*/
int32_t INET_SetEndPointInterface(const BCM_CompIDType aCompId,
                                  const INET_PayloadType aPayloadId,
                                  INET_InterfaceIdType aIntfID);


/**
    @brief Process internet stack timers

    @pre 3.125ms alarm expires

    Invoked every 3.125ms to provide the notion of elapsed time to the internet
    stack and used to implement various timeouts.

    @behavior Sync, Non re-entrant

    @return      void

    @post None

    @trace #BRCM_SWREQ_INET

    @limitations None
*/
void INET_ProcessTimers(void);

/**
    @brief Receive IPv4 Packet

    @pre None

    Invoked by the network interface to handover a received packet containing
    IPv4 payload to the internet stack for processing

    @param[in]   aCtrlIdx        NIF controller index
    @param[in]   aBuf            Pointer to the packet buffer
    @param[in]   aLen            Length of the received packet
    @param[in]   aSrcMacAddr     Pointer to source MAC address
    @param[in]   aDestMacAddr    Pointer to destination MAC address
    @param[in]   aPriority       PCP priority of the packet

    @return      void

    @post None

    @trace #BRCM_SWREQ_INET_NIF_CB

    @limitations None
*/
void INET_RxIPv4Pkt(NIF_CntrlIDType aCtrlIdx,
                    const uint8_t *const aBuf,
                    uint16_t aLen,
                    const uint8_t *const aSrcMacAddr,
                    const uint8_t *const aDestMacAddr,
                    uint32_t aPriority);

/**
    @brief Receive ARP Packet

    @pre None

    Invoked by the network interface to handover a received packet containing
    ARP payload to the internet stack for processing

    @behavior Sync, Non-reentrant

    @param[in]   aCtrlIdx        NIF controller index
    @param[in]   aBuf            Pointer to the packet buffer
    @param[in]   aLen            Length of the received packet
    @param[in]   aSrcMacAddr     Pointer to source MAC address
    @param[in]   aDestMacAddr    Pointer to destination MAC address
    @param[in]   aPriority       PCP priority of the packet

    @return      void

    @post None

    @trace #BRCM_SWREQ_INET_NIF_CB

    @limitations None
*/
void INET_RxARPPkt(NIF_CntrlIDType aCtrlIdx,
                   const uint8_t *const aBuf,
                   uint16_t aLen,
                   const uint8_t *const aSrcMacAddr,
                   const uint8_t *const aDestMacAddr,
                   uint32_t aPriority);

/**
    @brief IP/ARP packet transmit confirmation

    @pre None

    Invoked by network interface to inform that an IP/ARP packet was
    successfully transmitted

    @behavior Sync, Non-reentrant

    @param[in]   aCtrlIdx        NIF controller index
    @param[in]   aBufIdx         Buffer identifier for the packet

    @return      void

    @post None

    @trace #BRCM_SWREQ_INET_NIF_CB

    @limitations None
*/
void INET_TxPktConfirmation (NIF_CntrlIDType aCtrlIdx,
                             uint32_t aBufIdx);

/**
    @brief L2 buffer available indication

    @pre None

    Invoked by the network interface to inform that free L2 buffer is
    available

    @behavior Sync, Non-reentrant

    @param[in]   aCtrlIdx           NIF controller index

    @return      void

    @post None

    @trace #BRCM_SWREQ_INET_NIF_CB

    @limitations Even though callback is received, any free buffers might have
    been already acquired by higher priority clients. INET stack clients might
    not find a free buffer on waking up. It can retry on a subsequent
    invocations of the same callback
*/
void INET_BufferAvailableIndication (NIF_CntrlIDType aCtrlIdx);

/**
    @brief Inform client receive task

    @pre None

    Invoked by INET stack to inform the client of a receive event

    @behavior Sync, Non-reentrant

    @param[in]   aTaskId               Task identifier
    @param[in]   aEventId              Event identifier

    @return      BCM_ERR_OK            If client was notified successfully
    @return      BCM_ERR_UNKNOWN       If any error occurred

    @post None

    @trace #BRCM_SWREQ_INET
*/
int32_t INET_InformClientRxTask(int32_t aTaskId, uint32_t aEventId);

/**
    @brief Inform client transmit task

    @pre None

    Invoked by INET stack to inform the client of a transmit event

    @behavior Sync, Non-reentrant

    @param[in]   aTaskId               Task identifier
    @param[in]   aEventId              Event identifier

    @return      BCM_ERR_OK            If client was notified successfully
    @return      BCM_ERR_UNKNOWN       If any error occurred

    @post None

    @trace #BRCM_SWREQ_INET
*/
int32_t INET_InformClientTxTask(int32_t aTaskId, uint32_t aEventId);

/**
    @brief INET Timer alarm callback

    @retval      void

    @post None

    @trace #BRCM_SWREQ_INET

*/
void INET_Timer_AlarmCb(void);

#endif /* INET_OSIL_H */
/** @} */
