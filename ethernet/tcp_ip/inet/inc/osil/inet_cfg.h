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
  @defgroup grp_inet_il INET Integration Guide
  @ingroup grp_inet

  @addtogroup grp_inet_il
  @{
  @file inet_cfg.h
  @brief INET connection configuration

  This file provides the connection configuration and IL interfaces to
  access them.

  @version 0.86 Imported from MS Word document
*/

#ifndef INET_CFG_H
#define INET_CFG_H

#include "inet.h"
#include "tcp.h"
#include <circ_queue.h>
#include <msg_queue.h>
#include <nif.h>

/**
    @name INET Architecture IDs
    @{
    @brief Architecture IDs for INET IL
 */
#define BRCM_SWARCH_INET_CONVERT_IP_ADDRESS_MACRO        (0x9401U)    /**< @brief #INET_CONVERT_IP_ADDRESS         */
#define BRCM_SWARCH_INET_ENDPOINTID_TYPE                 (0x9402U)    /**< @brief #INET_EndPointIdType             */
#define BRCM_SWARCH_INET_L4PROTO_TYPE                    (0x9403U)    /**< @brief #INET_L4ProtoType                */
#define BRCM_SWARCH_INET_ARPENTRYSTATE_TYPE              (0x9404U)    /**< @brief #INET_ARPEntryStateType          */
#define BRCM_SWARCH_INET_INTERFACEID_TYPE                (0x9405U)    /**< @brief #INET_InterfaceIdType            */
#define BRCM_SWARCH_INET_DSCP_TYPE                       (0x9406U)    /**< @brief #INET_DSCPType                   */
#define BRCM_SWARCH_INET_NETMASK_TYPE                    (0x9407U)    /**< @brief #INET_NetmaskType                */
#define BRCM_SWARCH_INET_IPADDRESSASSIGNMENT_TYPE        (0x9408U)    /**< @brief #INET_IPAddressAssignmentType    */
#define BRCM_SWARCH_INET_REASSBUFSTATE_TYPE              (0x9409U)    /**< @brief #INET_ReassBufStateType          */
#define BRCM_SWARCH_INET_ARPENTRY_TYPE                   (0x940AU)    /**< @brief #INET_ARPEntryType               */
#define BRCM_SWARCH_INET_INTERFACEVLANTAGCONFIG_TYPE     (0x940BU)    /**< @brief #INET_InterfaceVlanTagConfigType */
#define BRCM_SWARCH_INET_INTERFACESTATS_TYPE             (0x940CU)    /**< @brief #INET_InterfaceStatsType         */
#define BRCM_SWARCH_INET_INTERFACECONFIG_TYPE            (0x940DU)    /**< @brief #INET_InterfaceConfigType        */
#define BRCM_SWARCH_INET_SYSTEMINTERFACE_TYPE            (0x940EU)    /**< @brief #INET_SystemInterfaceType        */
#define BRCM_SWARCH_INET_ENDPOINTSTATE_TYPE              (0x940FU)    /**< @brief #INET_EndPointStateType          */
#define BRCM_SWARCH_INET_ENDPOINTOBJECT_TYPE             (0x9410U)    /**< @brief #INET_EndPointObjectType         */
#define BRCM_SWARCH_INET_SYSTEMENDPOINT_TYPE             (0x9411U)    /**< @brief #INET_SystemEndPointType         */
#define BRCM_SWARCH_INET_REASSEMBLYBUFFER_TYPE           (0x9412U)    /**< @brief #INET_ReassemblyBufferType       */
#define BRCM_SWARCH_INET_RXPKT_TYPE                      (0x9413U)    /**< @brief #INET_RxPktType                  */
#define BRCM_SWARCH_INET_INTERFACESTATETYPE_TYPE         (0x9414U)    /**< @brief #INET_InterfaceStateType         */
#define BRCM_SWARCH_INET_DEFINE_REASS_BUF_MACRO          (0x9416U)    /**< @brief #INET_DEFINE_REASS_BUF           */
#define BRCM_SWARCH_INET_DEFINE_INTERFACE_MACRO          (0x9417U)    /**< @brief #INET_DEFINE_INTERFACE           */
#define BRCM_SWARCH_INET_DEFINE_UDP_ENDPOINT_MACRO       (0x9418U)    /**< @brief #INET_DEFINE_UDP_ENDPOINT        */
#define BRCM_SWARCH_INET_CFG_TYPE                        (0x9419U)    /**< @brief #INET_CfgType                    */
#define BRCM_SWARCH_INET_REASSRWPARAMS_TYPE              (0x941AU)    /**< @brief #INET_ReassRWParamsType          */
#define BRCM_SWARCH_INET_DEFINE_NULL_INTERFACE_MACRO     (0x941BU)    /**< @brief #INET_DEFINE_NULL_INTERFACE      */
#define BRCM_SWARCH_INET_DEFINE_NULL_UDP_ENDPOINT_MACRO  (0x941CU)    /**< @brief #INET_DEFINE_NULL_UDP_ENDPOINT   */
#define BRCM_SWARCH_INET_GETINTERFACEFORENDPOINT_PROC    (0x941DU)    /**< @brief #INET_GetInterfaceForEndPoint    */
#define BRCM_SWARCH_INET_GETINTERFACE_PROC               (0x941EU)    /**< @brief #INET_GetInterface               */
#define BRCM_SWARCH_INET_GETINTERFACECOUNT_PROC          (0x941FU)    /**< @brief #INET_GetInterfaceCount          */
#define BRCM_SWARCH_INET_GETENDPOINT_PROC                (0x9420U)    /**< @brief #INET_GetEndPoint                */
#define BRCM_SWARCH_INET_ARPRESOLVEADDRESS_PROC          (0x9421U)    /**< @brief #INET_ARPResolveAddress          */
#define BRCM_SWARCH_INET_ARPSENDREQUEST_PROC             (0x9422U)    /**< @brief #INET_ARPSendRequest             */
#define BRCM_SWARCH_INET_ADDARPENTRY_PROC                (0x9423U)    /**< @brief #INET_AddARPEntry                */
#define BRCM_SWARCH_INET_FINDARPENTRY_PROC               (0x9424U)    /**< @brief #INET_FindARPEntry               */
#define BRCM_SWARCH_INET_REMOVEARPENTRY_PROC             (0x9425U)    /**< @brief #INET_RemoveARPEntry             */
#define BRCM_SWARCH_INET_SEARCHINTERFACE_PROC            (0x9426U)    /**< @brief #INET_SearchInterface            */
#define BRCM_SWARCH_INET_GETREASSEMBLYBUFFER_PROC        (0x9427U)    /**< @brief #INET_GetReassemblyBuffer        */
#define BRCM_SWARCH_INET_UPDATEREASSEMBLYBUFFER_PROC     (0x9428U)    /**< @brief #INET_UpdateReassemblyBuffer     */
#define BRCM_SWARCH_INET_FREEREASSEMBLYBUFFER_PROC       (0x9429U)    /**< @brief #INET_FreeReassemblyBuffer       */
#define BRCM_SWARCH_INET_CLIENTACKREASSBUF_PROC          (0x942AU)    /**< @brief #INET_ClientAckReassBuf          */
#define BRCM_SWARCH_INET_UDPRECEIVEINDICATION_PROC       (0x942BU)    /**< @brief #INET_UDPReceiveIndication       */
#define BRCM_SWARCH_INET_ALLOCATEEPHEMERALPORT_PROC      (0x942CU)    /**< @brief #INET_AllocateEphemeralPort      */
#define BRCM_SWARCH_INET_SETENDPOINTLOCALPORT_PROC       (0x942DU)    /**< @brief #INET_SetEndPointLocalPort       */
#define BRCM_SWARCH_INET_TCPFLAGS_TYPE                   (0x942EU)    /**< @brief #INET_TCPFlagsType               */
#define BRCM_SWARCH_INET_TCPHDR_TYPE                     (0x942FU)    /**< @brief #INET_TCPHdrType                 */
#define BRCM_SWARCH_INET_ENDPOINTSTATS_TYPE              (0x9430U)    /**< @brief #INET_EndPointStatsType          */
#define BRCM_SWARCH_INET_DEFINE_TCP_ENDPOINT_MACRO       (0x9431U)    /**< @brief #INET_DEFINE_TCP_ENDPOINT        */
#define BRCM_SWARCH_INET_DEFINE_NULL_TCP_ENDPOINT_MACRO  (0x9432U)    /**< @brief #INET_DEFINE_NULL_TCP_ENDPOINT   */
#define BRCM_SWARCH_INET_TCPENDPOINTSTATE_TYPE           (0x9433U)    /**< @brief #INET_TCPEndPointStateType       */
#define BRCM_SWARCH_INET_TCPEVENT_TYPE                   (0x9434U)    /**< @brief #INET_TCPEventType               */
#define BRCM_SWARCH_INET_TCPRECEIVEINDICATION_PROC       (0x9435U)    /**< @brief #INET_TCPReceiveIndication       */
#define BRCM_SWARCH_INET_TCPTRIGGERSTATEMACHINE_PROC     (0x9436U)    /**< @brief #INET_TCPTriggerStateMachine     */
#define BRCM_SWARCH_INET_TCPGETEVENTFROMPKT_PROC         (0x9437U)    /**< @brief #INET_TCPGetEventFromPkt         */
#define BRCM_SWARCH_INET_TCPRESETENDPOINT_PROC           (0x9438U)    /**< @brief #INET_TCPResetEndPoint           */
#define BRCM_SWARCH_INET_TCPCTRLMSG_TYPE                 (0x9439U)    /**< @brief #INET_TCPCtrlMsgType             */
#define BRCM_SWARCH_INET_TCPPROCESSCTRLMSGS_PROC         (0x943AU)    /**< @brief #INET_TCPProcessCtrlMsgs         */
/** @} */


/**
  @name INET_EndPointIdType
  @{
  @brief End point identifier

  @trace #BRCM_SWREQ_INET
*/
typedef uint16_t INET_EndPointIdType;         /**< @brief typedef for endpoint
                                                   identifier */
#define INET_ENDPOINTID_INVALID (0xFFFFU)     /**< @brief Invalid value of end
                                                   point identifier */
/** @} */

/**
  @name INET_L4ProtoType
  @{
  @brief OSI Layer 4 (Transport) protocol as defined by IANA (RFC790)

  @trace #BRCM_SWREQ_INET
*/
typedef uint8_t INET_L4ProtoType;             /**< @brief typedef for L4 protocol */
#define INET_L4PROTO_ICMP           (1U)       /**< @brief Internet Control Message
                                                    Protocol */
#define INET_L4PROTO_TCP            (6U)       /**< @brief Transmission Control Protocol */
#define INET_L4PROTO_UDP            (17U)      /**< @brief User Datagram Protocol */
#define INET_L4PROTO_UDPLITE        (136U)     /**< @brief Lightweight User Datagram
                                                    Protocol */
/** @} */

/**
  @name INET_ARPEntryStateType
  @{
  @brief Flag denoting ARP entry properties

  @trace #BRCM_SWREQ_INET
*/
typedef uint32_t INET_ARPEntryStateType;      /**< @brief typedef for ARP flag */
#define INET_ARPENTRYSTATE_WAIT     (1UL)     /**< @brief ARP request has been sent
                                                   and a response is awaited */
#define INET_ARPENTRYSTATE_RESOLVED (2UL)     /**< @brief Valid response was
                                                   received for an ARP request */
#define INET_ARPENTRYSTATE_LEARNT   (3UL)     /**< @brief ARP entry learnt from a
                                                   gratuitous ARP or an incoming
                                                   request */
#define INET_ARPENTRYSTATE_STATIC   (4UL)     /**< @brief Statically configured ARP
                                                   entry */
/** @} */

/**
  @name INET_InterfaceIdType
  @{
  @brief Interface identifier

  @trace #BRCM_SWREQ_INET
*/
typedef uint32_t INET_InterfaceIdType;      /**< @brief typedef for
                                                 interface identifier */
#define INET_INTERFACEID_0        (0UL)     /**< @brief Interface array index 0 */
#define INET_INTERFACEID_1        (1UL)     /**< @brief Interface array index 1 */
#define INET_INTERFACEID_2        (2UL)     /**< @brief Interface array index 2 */
#define INET_INTERFACEID_3        (3UL)     /**< @brief Interface array index 3 */
#define INET_INTERFACEID_4        (4UL)     /**< @brief Interface array index 4 */
#define INET_INTERFACEID_5        (5UL)     /**< @brief Interface array index 5 */
#define INET_INTERFACEID_6        (6UL)     /**< @brief Interface array index 6 */
#define INET_INTERFACEID_7        (7UL)     /**< @brief Interface array index 7 */
#define INET_INTERFACEID_INVALID  (0xFFFFFFFFUL)  /**< @brief Invalid interface */
/** @} */

/**
  @name INET_DSCPType
  @{
  @brief IPv4 6 bit Differentiated Services (DS) field

  @trace #BRCM_SWREQ_INET
*/
typedef uint8_t INET_DSCPType;      /**< @brief typedef for IPv4 DSCP */
#define INET_DSCP_CS0   (0x00U)     /**< @brief Class 0 Selector */
#define INET_DSCP_CS1   (0x08U)     /**< @brief Class 1 Selector */
#define INET_DSCP_CS2   (0x10U)     /**< @brief Class 2 Selector */
#define INET_DSCP_CS3   (0x18U)     /**< @brief Class 3 Selector */
#define INET_DSCP_CS4   (0x20U)     /**< @brief Class 4 Selector */
#define INET_DSCP_CS5   (0x28U)     /**< @brief Class 5 Selector */
#define INET_DSCP_CS6   (0x30U)     /**< @brief Class 6 Selector */
#define INET_DSCP_CS7   (0x38U)     /**< @brief Class 7 Selector */
#define INET_DSCP_AF11  (0x0AU)     /**< @brief Assured Forwarding Class 1, Low
                                         Drop Probability */
#define INET_DSCP_AF12  (0x0CU)     /**< @brief Assured Forwarding Class 1, Medium
                                         Drop Probability */
#define INET_DSCP_AF13  (0x0EU)     /**< @brief Assured Forwarding Class 1, High
                                         Drop Probability */
#define INET_DSCP_AF21  (0x12U)     /**< @brief Assured Forwarding Class 2, Low
                                         Drop Probability */
#define INET_DSCP_AF22  (0x14U)     /**< @brief Assured Forwarding Class 2, Medium
                                         Drop Probability */
#define INET_DSCP_AF23  (0x16U)     /**< @brief Assured Forwarding Class 2, High
                                         Drop Probability */
#define INET_DSCP_AF31  (0x1AU)     /**< @brief Assured Forwarding Class 3, Low
                                         Drop Probability */
#define INET_DSCP_AF32  (0x1CU)     /**< @brief Assured Forwarding Class 3, Medium
                                         Drop Probability */
#define INET_DSCP_AF33  (0x1EU)     /**< @brief Assured Forwarding Class 3, High
                                         Drop Probability */
#define INET_DSCP_AF41  (0x22U)     /**< @brief Assured Forwarding Class 4, Low
                                         Drop Probability */
#define INET_DSCP_AF42  (0x24U)     /**< @brief Assured Forwarding Class 4, Medium
                                         Drop Probability */
#define INET_DSCP_AF43  (0x26U)     /**< @brief Assured Forwarding Class 4, High
                                         Drop Probability */
#define INET_DSCP_EF    (0x2EU)     /**< @brief Expedited Forwarding */
#define INET_DSCP_VA    (0x2CU)     /**< @brief Voice Admit */
/** @} */

/**
  @name INET_NetmaskType
  @{
  @brief Netmask expressed in CIDR notation

  @trace #BRCM_SWREQ_INET
*/
typedef uint8_t INET_NetmaskType; /**< @brief typedef for netmask */
/** @} */

/**
  @name INET_IPAddressAssignmentType
  @{
  @brief IP address assignment policy

  @trace #BRCM_SWREQ_INET
*/
typedef uint32_t INET_IPAddressAssignmentType;   /**< @brief typedef for IP
                                                      address assignment policy */
#define INET_IPADDRESSASSIGNMENT_INVALID   (0UL) /**< @brief Invalid IP
                                                      address assignment policy */
#define INET_IPADDRESSASSIGNMENT_STATIC    (1UL) /**< @brief Statically
                                                      configured IP address */
#define INET_IPADDRESSASSIGNMENT_DYNAMIC   (2UL) /**< @brief IP address
                                                      configured using DHCP */
#define INET_IPADDRESSASSIGNMENT_LINKLOCAL (3UL) /**< @brief Link-local
                                                      assignment of IP address*/
/** @} */

/**
  @name INET_ReassBufStateType
  @{
  @brief Reassembly buffer state machine values

  @trace #BRCM_SWREQ_INET
*/
typedef uint32_t INET_ReassBufStateType;   /**< @brief typedef for reassembly
                                                buffer state */
#define INET_REASSBUFSTATE_FREE      (1UL) /**< @brief Reassembly buffer is
                                                unused/free */
#define INET_REASSBUFSTATE_ALLOCATED (2UL) /**< @brief Reassembly buffer is
                                                allocated */
#define INET_REASSBUFSTATE_QUEUED    (3UL) /**< @brief Reassembly buffer is
                                                queued to a client */
#define INET_REASSBUFSTATE_RCVD      (4UL) /**< @brief Reassembly buffer is
                                                being read by the client */
/** @} */

/**
    @name INET_TCPEventType
    @{
    @brief TCP Event used as a trigger for the state machine

    @trace #BRCM_SWREQ_INET
*/
typedef uint32_t INET_TCPEventType;       /**< @brief typedef for TCP event      */
#define INET_TCPEVENT_LISTEN_API   (0UL)  /**< @brief Listen API was invoked     */
#define INET_TCPEVENT_CONNECT_API  (1UL)  /**< @brief Connect API was invoked    */
#define INET_TCPEVENT_ACCEPT_API   (2UL)  /**< @brief Accept API was invoked     */
#define INET_TCPEVENT_SYN_RCVD     (3UL)  /**< @brief Syn received from peer     */
#define INET_TCPEVENT_SYNACK_RCVD  (4UL)  /**< @brief Syn+Ack received from peer */
#define INET_TCPEVENT_ACK_RCVD     (5UL)  /**< @brief Ack received from peer     */
#define INET_TCPEVENT_CLOSE_API    (6UL)  /**< @brief Close API was invoked      */
#define INET_TCPEVENT_FIN_RCVD     (7UL)  /**< @brief Fin received from peer     */
#define INET_TCPEVENT_TIMER        (8UL)  /**< @brief Connection request timeout */
#define INET_TCPEVENT_FINACK_RCVD  (9UL)  /**< @brief Fin+Ack received from peer */
/** @} */

/**
  @name INET_TCPFlagsType
  @{
  @brief TCP header flags

  @trace #BRCM_SWREQ_INET
*/
typedef uint8_t INET_TCPFlagsType; /**< @brief typedef for TCP flags */
#define INET_TCPFLAGS_FIN  (1U << 0U)  /**< @brief No more data from sender */
#define INET_TCPFLAGS_SYN  (1U << 1U)  /**< @brief Synchronize sequence numbers */
#define INET_TCPFLAGS_RST  (1U << 2U)  /**< @brief Reset the connection */
#define INET_TCPFLAGS_PSH  (1U << 3U)  /**< @brief Push function */
#define INET_TCPFLAGS_ACK  (1U << 4U)  /**< @brief Acknowledgement field
                                               significant */
#define INET_TCPFLAGS_URG  (1U << 5U)  /**< @brief Urgent pointer field
                                               significant */
/** @} */

/**
    @brief Converts an IP address from the a.b.c.d notation to INET_IPAddressType

    @trace #BRCM_SWREQ_INET
*/
#define INET_CONVERT_IP_ADDRESS(A, B, C, D) (A & 0xFFUL) << 24U|(B & 0xFFUL) << 16U\
                                            |(C & 0xFFUL) << 8U | (D & 0xFFUL)

/** @struct INET_TCPHdrType
    @brief TCP header fields

    @trace #BRCM_SWREQ_INET
*/
typedef struct sINET_TCPHdrType {
    INET_PortType     srcPort; /**< @brief Source port */
    INET_PortType     dstPort; /**< @brief Destination port */
    uint32_t          seqNum;  /**< @brief Sequence number */
    uint32_t          ackNum;  /**< @brief Acknowledgement number */
    uint16_t          hdrLen;  /**< @brief Header length */
    uint32_t          wndSz;   /**< @brief Window size (accounting for scale option) */
    uint16_t          urgPtr;  /**< @brief Urgent pointer */
    INET_TCPFlagsType flags;   /**< @brief Flags */
    uint16_t          rxMSS;   /**< @brief Maximum seqment size supported in receive */
} INET_TCPHdrType;

/** @struct INET_TCPCtrlMsgType
    @brief TCP control message

    @trace #BRCM_SWREQ_INET
*/
typedef struct sINET_TCPCtrlMsgType {
    INET_TCPEventType event;   /**< @brief TCP event */
    INET_TCPHdrType   tcpHdr;  /**< @brief TCP header */
} INET_TCPCtrlMsgType;

/**
    @brief ARP table entry

    @trace #BRCM_SWREQ_INET
*/
typedef struct sINET_ARPEntryType {
    uint32_t             valid;       /**< @brief Indicates whether the entry is
                                           populated or not */
    INET_IPAddressType   ipAddr;      /**< @brief IP Address - used as the key for
                                           the lookup */
    uint8_t              macAddr[6U]; /**< @brief MAC Address - used as the result
                                           for the lookup */
    INET_ARPEntryStateType  flags;    /**< @brief Flags to indicate the type of
                                           entry */
    uint32_t             timer;       /**< @brief Time in seconds for the entry to
                                           timeout */
    uint32_t             exclVal;     /**< @brief Exclusive - For critical section
                                           protection using Ldrex/Strex */
    INET_InterfaceIdType ifID;        /**< @brief Interface on which the ARP request
                                           was initiated. This is used to refresh the
                                           entry on timeout. */
} INET_ARPEntryType;

/** @struct INET_InterfaceVlanTagConfigType
    @brief VLAN tag configuration for a L2 interface

    @trace #BRCM_SWREQ_INET
*/
typedef struct sINET_InterfaceVlanTagConfigType {
    uint16_t   pcp; /**< @brief Priority code point value. Valid values are
                         0-7 */
    uint16_t  vlan; /**< @brief VLAN number. Valid values are 1-4094.
                         0 indicates untagged interface */
} INET_InterfaceVlanTagConfigType;

/** @struct INET_InterfaceStatsType
    @brief Structure representing statistics for an interface

    @trace #BRCM_SWREQ_INET
*/
typedef struct sINET_InterfaceStatsType {
    uint32_t txPkts;       /**< @brief Number of packets transmitted */
    uint32_t txBytes;      /**< @brief Number of bytes transmitted */
    uint32_t txARP;        /**< @brief Number of ARP messages transmitted */
    uint32_t txICMP;       /**< @brief Number of ICMP messages transmitted */
    uint32_t txDropPkts;   /**< @brief Number of transmit packets dropped */
    uint32_t txARPFailure; /**< @brief Number of ARP resolution failures */
    uint32_t txCancelPkts; /**< @brief Number of transmit packets cancelled */
    uint32_t txL2PktCount; /**< @brief Number of L2 packets transmitted */
    uint32_t txL2BufNA;    /**< @brief Number of L2 buffer unavailable */
    uint64_t rxPkts;       /**< @brief Number of packets received */
    uint64_t rxBytes;      /**< @brief Number of bytes received */
    uint64_t rxL2PktCount; /**< @brief Number of all incoming packets received*/
    uint32_t rxDropPkts;   /**< @brief Number of received packets dropped */
    uint32_t rxICMP;       /**< @brief Number of ICMP messages received */
    uint32_t rxICMPErr;    /**< @brief Number of ICMP messages not supported */
    uint32_t rxARP;        /**< @brief Number of ARP messages received */
} INET_InterfaceStatsType;

/** @struct INET_InterfaceConfigType
    @brief Configuration for an interface

    @trace #BRCM_SWREQ_INET
*/
typedef struct sINET_InterfaceConfigType {
    INET_InterfaceIdType             hwIndex;       /**< @brief Identifier for the
                                                         L2 controller */
    INET_InterfaceVlanTagConfigType  vlanConfig;    /**< @brief VLAN configuration
                                                         for the interface */
    INET_IPAddressAssignmentType     addressType;   /**< @brief Type of IP address
                                                         assigned to the
                                                         interface */
    INET_IPAddressType               ipAddress;     /**< @brief IP address assigned
                                                         to the interface */
    INET_NetmaskType                 netmask;       /**< @brief Netmask */
    INET_IPAddressType               defaultRoute;  /**< @brief Default
                                                         route/gateway */
} INET_InterfaceConfigType;

/** @struct INET_InterfaceStateType
    @brief State variables for an interface

    @trace #BRCM_SWREQ_INET
*/
typedef struct sINET_InterfaceStateType {
    INET_InterfaceIdType       ifID;       /**< @brief Unique interface identifier */
    NIF_CntrlIDType            nifCtrlIdx; /**< @brief Network Interface Controller Index */
    INET_InterfaceStatsType    stats;      /**< @brief Interface statistics */
    INET_InterfaceConfigType   cfg;        /**< @brief Interface configuration */
    uint64_t                   lastARPProcTime; /**< @brief Last ARP Processed Time */
} INET_InterfaceStateType;

/** @struct INET_SystemInterfaceType
    @brief Structure representing an interface

    @trace #BRCM_SWREQ_INET
*/
typedef struct sINET_SystemInterfaceType {
    INET_InterfaceStateType  *ifCtxt;   /**< @brief Context/State for an interface
                                             along with configuration*/
    INET_ARPEntryType        *arpCache; /**< @brief Pointer to the ARP cache for
                                             the interface */
    uint64_t                arpProcessInterval; /**< @brief ARP Processing Interval */
} INET_SystemInterfaceType;

/** @struct INET_EndPointStatsType
    @brief Statistics for an endpoint

    @trace #BRCM_SWREQ_INET
*/
typedef struct sINET_EndPointStatsType {
    uint64_t                txPkts;        /**< @brief Number of packets
                                                transmitted */
    uint64_t                txBytes;       /**< @brief Number of bytes transmitted */
    uint64_t                rxGoodPkts;    /**< @brief Number of packets received */
    uint64_t                rxTruncPkts;   /**< @brief Number of packets truncated
                                                due to insufficient reassembly buffer
                                                size*/
    uint64_t                rxDropPkts;    /**< @brief Number of packets dropped due
                                                to no waiting client task */
    uint64_t                rxBytes;       /**< @brief Number of bytes received */
} INET_EndPointStatsType;

/** @struct INET_EndPointStateType
    @brief Context/Scratch-memory for an endpoint

    @trace #BRCM_SWREQ_INET
*/
typedef struct sINET_EndPointStateType {
    uint16_t                ident;         /**< @brief Identification field for IP
                                                header */
    uint16_t                sentBytes;     /**< @brief Bytes sent for an ongoing
                                                transmission */
    const uint8_t*          txBuf;         /**< @brief Client buffer containing the
                                                payload for transmission */
    uint16_t                txLength;      /**< @brief Length of the client buffer
                                                containing payload for
                                                transmission */
    INET_EndPointStatsType  stats;         /**< @brief Statistics */
    uint32_t                arpCacheIndex; /**< @brief Index of ARP cache where the
                                                remote entry was last resolved */
    INET_InterfaceIdType    intfId;        /**< @brief Interface identifier */
    INET_EndPointIPPortType endPtCfg;      /**< @brief End point IP/Port Config */
} INET_EndPointStateType;

/** @struct INET_TCPEndPointStateType
    @brief Context/Scratch-memory for a TCP endpoint

    @trace #BRCM_SWREQ_INET
*/
typedef struct sINET_TCPEndPointStateType {
    uint64_t                timer;         /**< @brief Timer */
    uint16_t                numRetries;    /**< @brief Number of retries done so far */
    INET_TCPStateType       tcpState;      /**< @brief TCP state */
    uint32_t                tcpTxSeqNum;   /**< @brief TCP transmit sequence number */
    uint32_t                tcpTxAckNum;   /**< @brief TCP transmit Ack number */
    uint32_t                maxConns;      /**< @brief Maximum number of connections
                                                allowed on this endpoint (applicable
                                                only for server use case) */
} INET_TCPEndPointStateType;

/** @struct INET_EndPointObjectType
    @brief Endpoint object details

    @trace #BRCM_SWREQ_INET
*/
typedef struct sINET_EndPointObjectType {
    INET_L4ProtoType               l4Proto;    /**< @brief OSI L4 protocol */
    INET_DSCPType                  dscp;       /**< @brief Value of the differentiated services
                                                    (DS) field in the IP header */
    const CIRCQ_Type* const        rxPktQ;     /**< @brief List of received packets
                                                    waiting for client to read */
    INET_EndPointStateType*        ctxt;       /**< @brief Context/Scratch memory
                                                    for the end point and end point
                                                    configuration */
    INET_TCPEndPointStateType*     tcpCtxt;    /**< @brief TCP state variables/context */
    const MSGQ_Type*               tcpCtrlQ;   /**< @brief Queue for TCP control messages */
    INET_TCPCtrlMsgType*           tcpCtrlMsgs;/**< @brief TCP control messages buffer */
} INET_EndPointObjectType;

/** @struct INET_SystemEndPointType
    @brief Structure representing an end point

    @trace #BRCM_SWREQ_INET
*/
typedef struct sINET_SystemEndPointType {
    BCM_CompIDType          compId;        /**< @brief Component identifier used to
                                                identify the client */
    INET_PayloadType        payloadId;     /**< @brief Instance identifier used to
                                                identify the client */
    INET_EndPointObjectType endPtObj;      /**< @brief End point details */
    int32_t                 txTaskId;      /**< @brief Task to notify on packet
                                                transmission confirmation */
    uint32_t                txTaskEventId; /**< @brief Event of the Task to notify
                                                on free buffer being available or
                                                when the ARP gets resolved */
    int32_t                 rxTaskId;      /**< @brief Task to notify on packet
                                                reception */
    uint32_t                rxTaskEventId; /**< @brief Event of the Task to notify
                                                on packet reception */
} INET_SystemEndPointType;

/** @struct INET_ReassemblyBufferType
    @brief State structure for reassembling a buffer

    @trace #BRCM_SWREQ_INET
*/
typedef struct sINET_ReassRWParamsType {
    uint64_t                    expiryTime;         /**< @brief Reassembly and client read timeout */
    INET_ReassBufStateType      bufState;      /**< @brief State of the reassembly buffer */
    INET_IPAddressType          ipAddr;        /**< @brief Source IP address of incoming datagram */
    uint16_t                    ident;         /**< @brief Identification field of incoming datagram */
    uint16_t                    curLen;        /**< @brief Total length of fragments currently reassembled */
    uint16_t                    totalLen;      /**< @brief Total length of the IP datagram */
    uint16_t                    clientEndPtID; /**< @brief End point ID for this reassembly buffer */
} INET_ReassRWParamsType;

/** @struct INET_ReassemblyBufferType
    @brief State structure for reassembling a buffer

    @trace #BRCM_SWREQ_INET
*/
typedef struct sINET_ReassemblyBufferType {
    const CIRCQ_Type* const        fragmentQ;     /**< @brief Circular queue to hold
                                                       the fragment offsets. Used to
                                                       detect duplicates */
    uint8_t* const                 buffer;        /**< @brief Buffer to reassemble
                                                       the fragments into */
    INET_ReassRWParamsType*        params;        /**< @brief Pointer to RW params */
} INET_ReassemblyBufferType;

/**
    @brief Cache of received packets till client reads them

    @trace #BRCM_SWREQ_INET
*/
typedef struct sINET_RxPktType {
    const uint8_t*     buffer;    /**< @brief Reassembly buffer containing received
                                       payload */
    uint16_t           length;    /**< @brief Length of received payload in
                                       reassembly buffer */
    INET_IPAddressType srcIPAddr; /**< @brief Remote host from which the payload
                                       was received */
    INET_PortType      srcPort;   /**< @brief Remote port from which the payload
                                       was received */
    uint32_t           seqNum;    /**< @brief Received initial sequence number */
} INET_RxPktType;

/**
    @brief Define the reassembly buffer instance

    @param[in]     aName       Name of the buffer instance
    @param[in]     aBuffer     Name of the payload buffer
    @param[in]     aQ          Name of the circular queue
    @param[in]     aQBuf       Name of the queue buffer
    @param[in]     aQIdx       Name of the circular queue index

    @trace #BRCM_SWREQ_INET
*/
#define INET_DEFINE_REASS_BUF(aName, aBuffer, aQ, aQBuf, aQIdx, aRW)       \
static CIRCQ_IndexType (aQIdx) COMP_SECTION(".bss.inet");                  \
static uint16_t (aQBuf)[1UL<<(INET_LOG2_MAX_REASS_FRAGS)]                  \
                  COMP_SECTION(".bss.inet");                               \
static CIRCQ_DEFINE(aQ, (&aQIdx), (1UL<<(INET_LOG2_MAX_REASS_FRAGS)),      \
                       sizeof(uint16_t), aQBuf, (CIRCQ_OVERWRITE_DISABLE));\
static uint8_t (aBuffer)[INET_MAX_REASS_BUF_SIZE];                         \
static INET_ReassRWParamsType aRW;                                         \
static INET_ReassemblyBufferType const aName =                             \
{                                                                          \
    .fragmentQ = &aQ,                                                      \
    .buffer    = aBuffer,                                                  \
    .params    = &aRW,                                                     \
};

/**
    @brief Define an interface instance

    @param[in]     aName        Name of the interface
    @param[in]     aCache       Name of the ARP cache instance for the interface
    @param[in]     aStats       Name of the statistics instance for the interface
    @param[in]     aHwIndex     H/W controller index
    @param[in]     aPcp         Value of the PCP field in the priority tag
    @param[in]     aVid         VLAN Id
    @param[in]     aIPAddr      Static IP address
    @param[in]     aNetmask     Netmask
    @param[in]     aDfltRoute   IP address of gateway/default route

    @trace #BRCM_SWREQ_INET
*/
#define INET_DEFINE_INTERFACE(aName, aCache, aState, aHwIndex, aPcp,        \
                              aVid, aType, aIPAddr, aNetmask, aDfltRoute)   \
static INET_InterfaceStateType aState =                                     \
{                                                                           \
    .ifID       = INET_INTERFACEID_INVALID,                                 \
    .nifCtrlIdx = NIF_CNTRLIDTYPE_INVALID,                                  \
    .stats      = {0UL},                                                    \
    .cfg        =                                                           \
        {                                                                   \
        .hwIndex       = aHwIndex,                                          \
        .vlanConfig    = {                                                  \
                             .pcp = aPcp,                                   \
                             .vlan = aVid,                                  \
                         },                                                 \
        .addressType   = aType,                                             \
        .ipAddress     = aIPAddr,                                           \
        .netmask       = aNetmask,                                          \
        .defaultRoute  = aDfltRoute,                                        \
        },                                                                  \
    .lastARPProcTime = 0ULL,                                                \
};                                                                          \
static INET_SystemInterfaceType const aName =                               \
{                                                                           \
    .arpCache = aCache,                                                     \
    .ifCtxt   = &aState,                                                    \
    .arpProcessInterval = 1000000000ULL,                                    \
};

/**
    @brief Define an interface instance with NULL initialization.
    Aapplication shall update the interface parameters directly to the
    data members before usage of INET.

    @param[in]     aName        Name of the interface
    @param[in]     aCache       Name of the ARP cache instance for the interface
    @param[in]     aState       Name of the State instance for the interface
    @param[in]     aARPProcInterval     ARP Proessing interval

    @trace #BRCM_SWREQ_INET
*/
#define INET_DEFINE_NULL_INTERFACE(aName, aCache, aState, aARPProcInterval) \
static INET_InterfaceStateType aState COMP_SECTION(".bss.inet");            \
static INET_SystemInterfaceType const (aName) =                             \
{                                                                           \
    .arpCache = (aCache),                                                   \
    .ifCtxt   = &(aState),                                                  \
    .arpProcessInterval = (aARPProcInterval),                               \
};

/**
    @brief Define a UDP endpoint

    @param[in]     aName         Name of end point
    @param[in]     aCtxt         Name of context for the end point
    @param[in]     aCtxtQ        Name of circular queue for the received packets
    @param[in]     aCtxtQBuf     Name of circular queue buffer
    @param[in]     aCtxtQIdx     Name of circular queue index
    @param[in]     aCompId       Component identifier used to identify the client
    @param[in]     aPayloadId    Payload identifier used to identify the client
    @param[in]     aIfId         Interface identifier
    @param[in]     aRxTask       Task to notify on packet reception
    @param[in]     aTxTask       Task to notify on packet transmission confirmation
    @param[in]     aLogNumRxPkts Log2 of maximum number of recv packets to queue
    @param[in]     aLclPort      Local port number
    @param[in]     aRmtAddr      IP address of the remote host
    @param[in]     aRmtPort      Port number of the remote host
    @param[in]     aL4Proto      L4 protocol type
    @param[in]     aDscp         DSCP field in outgoing IP datagrams

    @trace #BRCM_SWREQ_INET
*/
#define INET_DEFINE_UDP_ENDPOINT(aName, aCtxt, aCtxtQ, aCtxtQBuf,           \
                                 aCtxtQIdx, aCompId, aPayloadId, aIfId,     \
                                 aRxTask, aRxEvent, aTxTask, aTxEvent,      \
                                 aLogNumRxPkts, aLclPort, aRmtAddr,         \
                                 aRmtPort, aL4Proto, aDscp)                 \
static CIRCQ_IndexType (aCtxtQIdx) COMP_SECTION(".bss.inet");               \
static INET_RxPktType (aCtxtQBuf)[1UL<<(aLogNumRxPkts)]                     \
           COMP_SECTION(".bss.inet");                                       \
static CIRCQ_DEFINE(aCtxtQ, (&aCtxtQIdx), (1UL<<(aLogNumRxPkts)),           \
              sizeof(INET_RxPktType), aCtxtQBuf, (CIRCQ_OVERWRITE_DISABLE));\
static INET_EndPointStateType (aCtxt) =                                     \
{                                                                           \
    .ident       = 0U,                                                      \
    .sentBytes   = 0U,                                                      \
    .txBuf       = NULL,                                                    \
    .txLength    = 0U,                                                      \
    .intfId      = aIfId,                                                   \
    .stats       = {                                                        \
        .rxGoodPkts  = 0ULL,                                                \
        .rxBytes     = 0ULL,                                                \
        .rxTruncPkts = 0ULL,                                                \
        .rxDropPkts  = 0ULL,                                                \
        .txPkts      = 0ULL,                                                \
        .txBytes     = 0ULL,                                                \
    },                                                                      \
    .endPtCfg    = {                                                        \
        .localPort     = aLclPort,                                          \
        .remoteAddr    = aRmtAddr,                                          \
        .remotePort    = aRmtPort,                                          \
    },                                                                      \
};                                                                          \
INET_SystemEndPointType const aName =                                       \
{                                                                           \
        .compId        = aCompId,                                           \
        .payloadId     = aPayloadId,                                        \
        .rxTaskId      = aRxTask,                                           \
        .rxTaskEventId = aRxEvent,                                          \
        .txTaskId      = aTxTask,                                           \
        .txTaskEventId = aTxEvent,                                          \
        .endPtObj      = {                                                  \
            .l4Proto     = aL4Proto,                                        \
            .dscp        = aDscp,                                           \
            .ctxt        = &aCtxt,                                          \
            .rxPktQ      = &aCtxtQ,                                         \
            .tcpCtxt     = NULL,                                            \
            .tcpCtrlQ    = NULL,                                            \
            .tcpCtrlMsgs = NULL,                                            \
        },                                                                  \
};

/**
    @brief Define a UDP endpoint with NULL initialization

    @param[in]     aName         Name of end point
    @param[in]     aCtxt         Name of context for the end point
    @param[in]     aCtxtQ        Name of circular queue for the received packets
    @param[in]     aCtxtQBuf     Name of circular queue buffer
    @param[in]     aCtxtQIdx     Name of circular queue index
    @param[in]     aCompId       Component identifier used to identify the client
    @param[in]     aPayloadId    Payload identifier used to identify the client
    @param[in]     aRxTask       Task to notify on packet reception
    @param[in]     aTxTask       Task to notify on packet transmission confirmation
    @param[in]     aLogNumRxPkts Log2 of maximum number of recv packets to queue
    @param[in]     aL4Proto      L4 protocol type
    @param[in]     aDscp         DSCP field in outgoing IP datagrams

    @trace #BRCM_SWREQ_INET
*/
#define INET_DEFINE_NULL_UDP_ENDPOINT(aName, aCtxt, aCtxtQ, aCtxtQBuf,      \
                                      aCtxtQIdx, aCompId, aPayloadId,       \
                                      aRxTask, aRxEvent, aTxTask, aTxEvent, \
                                      aLogNumRxPkts, aL4Proto, aDscp)       \
static CIRCQ_IndexType (aCtxtQIdx) COMP_SECTION(".bss.inet");               \
static INET_RxPktType (aCtxtQBuf)[1UL<<(aLogNumRxPkts)]                     \
           COMP_SECTION(".bss.inet");                                       \
static CIRCQ_DEFINE(aCtxtQ, (&aCtxtQIdx), (1UL<<(aLogNumRxPkts)),           \
              sizeof(INET_RxPktType), aCtxtQBuf, (CIRCQ_OVERWRITE_DISABLE));\
INET_EndPointStateType (aCtxt) COMP_SECTION(".bss.inet");                   \
INET_SystemEndPointType const aName =                                       \
{                                                                           \
        .compId        = aCompId,                                           \
        .payloadId     = aPayloadId,                                        \
        .rxTaskId      = aRxTask,                                           \
        .rxTaskEventId = aRxEvent,                                          \
        .txTaskId      = aTxTask,                                           \
        .txTaskEventId = aTxEvent,                                          \
        .endPtObj      = {                                                  \
            .l4Proto     = aL4Proto,                                        \
            .dscp        = aDscp,                                           \
            .ctxt        = &aCtxt,                                          \
            .rxPktQ      = &aCtxtQ,                                         \
            .tcpCtxt     = NULL,                                            \
            .tcpCtrlQ    = NULL,                                            \
            .tcpCtrlMsgs = NULL,                                            \
        },                                                                  \
};

/**
    @brief Define a TCP endpoint

    @param[in]     aName         Name of end point
    @param[in]     aCtxt         Name of context for the end point
    @param[in]     aCompId       Component identifier used to identify the client
    @param[in]     aPayloadId    Payload identifier used to identify the client
    @param[in]     aIfId         Interface identifier
    @param[in]     aRxTask       Task to notify on packet reception
    @param[in]     aTxTask       Task to notify on packet transmission confirmation
    @param[in]     aLclPort      Local port number
    @param[in]     aRmtAddr      IP address of the remote host
    @param[in]     aRmtPort      Port number of the remote host
    @param[in]     aDscp         DSCP field in outgoing IP datagrams

    @trace #BRCM_SWREQ_INET
*/
#define INET_DEFINE_TCP_ENDPOINT(aName, aCtxt, aCtxtQ, aCtxtQBuf, aCtxtQIdx,\
                                 aTcpCtrlQ, aTcpCtrlHdrQ,                   \
                                 aTcpCtrlMsgs, aTcpCtrlGetMsg,              \
                                 aCompId, aPayloadId, aIfId,                \
                                 aRxTask, aRxEvent, aTxTask, aTxEvent,      \
                                 aLclPort, aRmtAddr, aRmtPort, aDscp,       \
                                 aTcpCtxt)                                  \
static CIRCQ_IndexType (aCtxtQIdx) COMP_SECTION(".bss.inet");               \
static INET_RxPktType (aCtxtQBuf)[16UL] COMP_SECTION(".bss.inet");          \
static CIRCQ_DEFINE(aCtxtQ, (&aCtxtQIdx), (16UL), sizeof(INET_RxPktType),   \
                    aCtxtQBuf, (CIRCQ_OVERWRITE_DISABLE));                  \
static INET_TCPCtrlMsgType aTcpCtrlMsgs[MSGQ_SIZE] COMP_SECTION(".bss.inet"); \
static MSGQ_CtxType (aTcpCtrlHdrQ) COMP_SECTION(".bss.inet");               \
void* aTcpCtrlGetMsg(uint32_t idx) {                                        \
    void* pRet = NULL;                                                      \
    if (idx < MSGQ_SIZE) {                                                  \
        pRet = (void *)(&aTcpCtrlMsgs[idx]);                                \
    }                                                                       \
    return pRet;                                                            \
}                                                                           \
static const MSGQ_Type (aTcpCtrlQ) = MSGQ_INIT(INET_EVENT_PROCESS_TASK,     \
                                        SystemEvent16, FALSE,               \
                                        INET_TCPCtrlMsgType, MSGQ_SIZE,     \
                                        &aTcpCtrlHdrQ, aTcpCtrlGetMsg);     \
static INET_EndPointStateType (aCtxt) =                                     \
{                                                                           \
    .ident       = 0U,                                                      \
    .sentBytes   = 0U,                                                      \
    .txBuf       = NULL,                                                    \
    .txLength    = 0U,                                                      \
    .intfId      = aIfId,                                                   \
    .stats       = {                                                        \
        .rxGoodPkts  = 0ULL,                                                \
        .rxBytes     = 0ULL,                                                \
        .rxTruncPkts = 0ULL,                                                \
        .rxDropPkts  = 0ULL,                                                \
        .txPkts      = 0ULL,                                                \
        .txBytes     = 0ULL,                                                \
    },                                                                      \
    .endPtCfg    = {                                                        \
        .localPort     = aLclPort,                                          \
        .remoteAddr    = aRmtAddr,                                          \
        .remotePort    = aRmtPort,                                          \
    },                                                                      \
};                                                                          \
static INET_TCPEndPointStateType (aTcpCtxt) =                               \
{                                                                           \
    .tcpState = INET_TCPSTATE_CLOSED,                                       \
    .tcpTxSeqNum = 0UL,                                                     \
    .tcpTxAckNum = 0UL,                                                     \
};                                                                          \
INET_SystemEndPointType const aName =                                       \
{                                                                           \
    .compId        = aCompId,                                               \
    .payloadId     = aPayloadId,                                            \
    .rxTaskId      = aRxTask,                                               \
    .rxTaskEventId = aRxEvent,                                              \
    .txTaskId      = aTxTask,                                               \
    .txTaskEventId = aTxEvent,                                              \
    .endPtObj      = {                                                      \
        .l4Proto     = INET_L4PROTO_TCP,                                    \
        .dscp        = aDscp,                                               \
        .ctxt        = &aCtxt,                                              \
        .rxPktQ      = &aCtxtQ,                                             \
        .tcpCtxt     = &aTcpCtxt,                                           \
        .tcpCtrlQ    = &aTcpCtrlQ,                                          \
        .tcpCtrlMsgs = aTcpCtrlMsgs,                                        \
    },                                                                      \
};

/**
    @brief Define a TCP endpoint with NULL initialization

    @param[in]     aName         Name of end point
    @param[in]     aCtxt         Name of context for the end point
    @param[in]     aCompId       Component identifier used to identify the client
    @param[in]     aPayloadId    Payload identifier used to identify the client
    @param[in]     aRxTask       Task to notify on packet reception
    @param[in]     aTxTask       Task to notify on packet transmission confirmation
    @param[in]     aDscp         DSCP field in outgoing IP datagrams
    @param[in]     aTcpCtxt      TCP state variables

    @trace #BRCM_SWREQ_INET
*/
#define INET_DEFINE_NULL_TCP_ENDPOINT(aName, aCtxt, aCompId, aPayloadId,    \
                                      aRxTask, aRxEvent, aTxTask, aTxEvent, \
                                      aDscp, aTcpCtxt)                      \
INET_TCPEndPointStateType (aTcpCtxt) COMP_SECTION(".bss.inet");             \
INET_EndPointStateType (aCtxt) COMP_SECTION(".bss.inet");                   \
INET_SystemEndPointType const aName =                                       \
{                                                                           \
    .compId        = aCompId,                                               \
    .payloadId     = aPayloadId,                                            \
    .rxTaskId      = aRxTask,                                               \
    .rxTaskEventId = aRxEvent,                                              \
    .txTaskId      = aTxTask,                                               \
    .txTaskEventId = aTxEvent,                                              \
    .endPtObj      = {                                                      \
        .l4Proto = INET_L4PROTO_TCP,                                        \
        .dscp    = aDscp,                                                   \
        .ctxt    = &aCtxt,                                                  \
        .rxPktQ  = &aCtxtQ,                                                 \
        .tcpCtxt = &aTcpCtxt,                                               \
    },                                                                      \
};

/**
    @brief INET connection configuration table

    @trace #BRCM_SWREQ_INET
 */
typedef struct sINET_CfgType {
    const INET_SystemInterfaceType *const  *interfaces;       /**< @brief Pointer to list of interfaces */
    const uint32_t                          intfCount;        /**< @brief Count of interfaces */
    const INET_SystemEndPointType *const   *endPoints;        /**< @brief Pointer to list of end points */
    const uint32_t                          endPtCount;       /**< @brief Count of end points */
    const INET_ReassemblyBufferType *const *reassBufferPool;  /**< @brief Pointer to list of reassembly buffers */
    const uint32_t                          reassBufCount;    /**< @brief Count of reassembly buffers */
} INET_CfgType;

/**
    @brief  Get L2 interface for an end point

    @pre None

    Used to retrieve the L2 interface object for an end point

    @behavior Sync, Re-entrant

    @param[in]   aEndPointId           End point identifier
    @param[out]  aIntfObj              L2 Interface Object

    Return values are documented in reverse-chronological order
    @retval   #BCM_ERR_OK              L2 interface successfully
                                       retrieved
    @retval   #BCM_ERR_INVAL_PARAMS    aIntfId is NULL or end point not found

    @post None

    @trace #BRCM_SWREQ_INET

    @limitations None
*/
int32_t INET_GetInterfaceForEndPoint(const INET_EndPointIdType aEndPointId,
                                     INET_InterfaceStateType** const aIntfObj);

/**
    @brief  Get L2 interface

    @pre None

    Used to retrieve the L2 interface object from the identifier

    @behavior Sync, Re-entrant

    @param[in]   aIntfId               L2 interface identifier
    @param[out]  aIntfObj              L2 Interface Object

    Return values are documented in reverse-chronological order
    @retval   #BCM_ERR_OK              L2 interface successfully
                                       retrieved
    @retval   #BCM_ERR_INVAL_PARAMS    Interface not found

    @post None

    @trace #BRCM_SWREQ_INET

    @limitations None
*/
int32_t INET_GetInterface(const INET_InterfaceIdType aIntfId,
                          INET_InterfaceStateType** const aIntfObj);

/**
    @brief  Get L2 interface count

    @pre None

    Used to retrieve the count of L2 INET_Interfaces created

    @behavior Sync, Re-entrant

    @param[out]  aIntfCount            L2 interface count

    @retval      void

    @post None

    @trace #BRCM_SWREQ_INET

    @limitations None
*/
void INET_GetInterfaceCount(uint32_t* const aIntfCount);

/**
    @brief  Get end point information

    @pre None

    Used to retrieve the end point for a client along with its configuration and
    context

    @behavior Sync, Re-entrant

    @param[in]  aCompId                Component identifier used to identify the
                                       client of the end point
    @param[in]  aPayloadId             Payload identifier used to identify the
                                       client of the end point
    @param[out] aEndPtIndex            Index of the end point in the array
    @param[out] aEndPointObj           Configuration for the end point and
                                       context/scratch memory for the end point

    Return values are documented in reverse-chronological order
    @retval  #BCM_ERR_OK               End point successfully retrieved
    @retval  #BCM_ERR_INVAL_PARAMS     aEndPointId is NULL
    @retval  #BCM_ERR_NOT_FOUND        End point not found

    @post None

    @trace #BRCM_SWREQ_INET

    @limitations None
*/
int32_t INET_GetEndPoint(const BCM_CompIDType aCompId,
                         const INET_PayloadType aPayloadId,
                         INET_EndPointIdType* const aEndPtIndex,
                         const INET_EndPointObjectType** const aEndPointObj);

/**
    @brief Finds the H/W address for an IP address

    @pre None

    Retrieves the H/W address from the cache (if it exists) for unicast entry.
    On ARP cache lookup failure, sends an ARP request. For broadcast and
    multicast IP address returns the mapped H/W address.

    @behavior Sync, Non Re-entrant

    @param[in]  aIntfObj               Interface configuration and stats
    @param[in]  aIPAddr                IP address that needs to be resolved
    @param[out] aMACAddr               MAC address resolved by ARP
    @param[inout] arpIndex             Index of ARP cache where it was last found

    Return values are documented in reverse-chronological order
    @retval  #BCM_ERR_OK               HW address resolved successfully
    @retval  #BCM_ERR_INVAL_PARAMS     aIPAddr is invalid
    @retval  #BCM_ERR_NOT_FOUND        HW address not resolved

    @post None

    @trace #BRCM_SWREQ_INET

    @limitations None
*/
int32_t INET_ARPResolveAddress(INET_InterfaceStateType* aIntfObj,
                               const INET_IPAddressType aIPAddr,
                               uint8_t* const aMACAddr,
                               uint32_t* const arpIndex);

/**
    @brief Sends an ARP request

    @pre None

    Constructs an ARP request message and sends it on the network interface

    @param[in]  aIntfId                Interface identifier
    @param[in]  aIPAddr                IP Address to be resolved
    @param[in]  aFlags                 Current flags of the ARP entry
    @param[in]  aIsProbe               Probe or announcement

    @retval     void

    @post None

    @trace #BRCM_SWREQ_INET

    @limitations None
*/
void INET_ARPSendRequest(const INET_InterfaceIdType aIntfId,
                         const INET_IPAddressType aIPAddr,
                         const uint32_t aFlags,
                         const uint32_t aIsProbe);

/**
    @brief Adds/updates an entry in the ARP cache

    @pre None

    Adds/updates an entry in the ARP cache for the provided interface

    @param[in]  aIntfId                Interface identifier
    @param[in]  aIPAddr                IP Address
    @param[in]  aMACAddr               MAC Address
    @param[in]  aFlags                 Flags
    @param[in]  aUpdateAddr            Flag to indicate if MAC address
                                       needs to be updated

    Return values are documented in reverse-chronological order
    @retval     BCM_ERR_OK             Entry added/update successfully
    @retval     BCM_ERR_NOMEM          No free space in ARP cache
    @retval     BCM_ERR_INVAL_PARAMS   aIntfId is invalid or aMACAddr is NULL
    @retval     BCM_ERR_NOPERM         Entry conflicts with a static entry
                                       already present in the cache

    @trace #BRCM_SWREQ_INET
*/
int32_t INET_AddARPEntry(const INET_InterfaceIdType aIntfId,
                         const INET_IPAddressType  aIPAddress,
                         const uint8_t* const aMACAddr,
                         const uint32_t aFlags,
                         const uint8_t aUpdateAddr);
/**
    @brief Finds an entry in the ARP cache

    @pre None

     Finds an entry in the ARP cache for the provided interface

    @param[in]  aIntfId                Interface identifier
    @param[in]  aIPAddr                IP Address
    @param[out] aMACAddr               MAC Address to be retrieved
    @param[out] aFlags                 Flags for the entry retrieved
    @param[inout]arpIndex              ARP cache index

    Return values are documented in reverse-chronological order
    @retval     BCM_ERR_OK             Entry found
    @retval     BCM_ERR_INVAL_PARAMS   aIntfId is invalid or aMACAddr/aFlags is
                                       NULL
    @retval     BCM_ERR_NOT_FOUND      Entry does not exist in cache

    @trace #BRCM_SWREQ_INET
*/
int32_t INET_FindARPEntry(const INET_InterfaceIdType aIntfId,
                          const INET_IPAddressType  aIPAddress,
                          uint8_t* const aMACAddr,
                          uint32_t* const aFlags,
                          uint32_t* const arpIndex);

/**
    @brief Removes an entry from the ARP cache

    @pre None

     Removes an entry in the ARP cache for the provided interface

    @param[in]  aIntfId                Interface identifier
    @param[in]  aIPAddr                IP Address - key for the entry

    Return values are documented in reverse-chronological order
    @retval     BCM_ERR_OK             Entry removed successfully
    @retval     BCM_ERR_INVAL_PARAMS   aIntfId is invalid
    @retval     BCM_ERR_NOT_FOUND      Entry does not exist in cache
    @retval     BCM_ERR_NOSUPPORT      Entry is static

    @trace #BRCM_SWREQ_INET
*/
int32_t INET_RemoveARPEntry(const INET_InterfaceIdType aIntfId,
                            const INET_IPAddressType  aIPAddress);

/**
    @brief Searches for an interface using IP Address as key

    @pre None

    Used to search for the L2 interface identifier from the system configuration
    The key is <aHwId , aIPAddr>

    @param[in]  aHwId                  HW index of the interface
    @param[in]  aIPAddress             IP Address
    @param[in]  aVlan                  Vlan tag value
    @param[out] aIntfId                L2 interface identifier

    Return values are documented in reverse-chronological order
    @retval     BCM_ERR_OK             L2 interface identifier retrieved
    @retval     BCM_ERR_INVAL_PARAMS   aIntfId is NULL
    @retval     BCM_ERR_NOT_FOUND      No such valid interface exists

    @trace #BRCM_SWREQ_INET
*/
int32_t INET_SearchInterface(const uint32_t aHwId,
                             const INET_IPAddressType aIPAddress,
                             const uint16_t aVlan,
                             INET_InterfaceIdType* const aIntfId);

/**
    @brief Get a reassembly buffer

    @pre None

    Used by the stack to allocate/fetch a reassembly buffer for received IP
    datagrams. The key for the search is <aSrcAddr, aIdent> which can be used to
    fetch a previously allocated buffer

    @param[in]  aSrcAddr               Source address in IP datagram being
                                       reassembled
    @param[in]  aIdent                 Identification field from the IP datagram
    @param[out] aBuf                   Reassembly buffer
    @param[out] aLen                   Length of the reassembly buffer
    @param[out] aCurLen                Length of data in reassembly buffer
    @param[out] aTotalLen              Total length of reassembled datagram
    @param[out] aFragQ                 Pointer to the fragment queue

    Return values are documented in reverse-chronological order
    @retval     BCM_ERR_OK             Reassembly buffer allocated successfully
    @retval     BCM_ERR_INVAL_PARAMS   aBuf or aCurLen is NULL
    @retval     BCM_ERR_NOMEM          Out of reassembly buffers

    @trace #BRCM_SWREQ_INET
*/
int32_t INET_GetReassemblyBuffer(const INET_IPAddressType aSrcAddr,
                                 const uint16_t aIdent,
                                 uint8_t** aBuf,
                                 uint16_t* aLen,
                                 uint16_t* const aCurLen,
                                 uint16_t* const aTotalLen,
                                 const CIRCQ_Type** aFragQ);

/**
    @brief Update a reassembly buffer

    @pre None

    Used by the stack to update a reassembly buffer for received IP
    datagrams. The key for the search is <aSrcAddr, aIdent>

    @param[in] aSrcAddr               Source address in IP datagram being
                                      reassembled
    @param[in] aIdent                 Identification field from the IP datagram
    @param[in] aCurLen                Length of data in reassembly buffer. Value
                                      0U frees the buffer
    @param[in] aTotalLen              Total length of reassembled datagram

    Return values are documented in reverse-chronological order
    @retval    BCM_ERR_OK             Reassembly buffer updated
    @retval    BCM_ERR_NOT_FOUND      Unable to find reassembly buffer for
                                      provided parameters

    @trace #BRCM_SWREQ_INET
*/
int32_t INET_UpdateReassemblyBuffer(const INET_IPAddressType aSrcAddr,
                                    const uint16_t aIdent,
                                    const uint16_t aCurLen,
                                    const uint16_t aTotalLen);

/**
    @brief Free reassembly buffer

    @pre None

    Used by the stack to free a reassembly buffer. The key for the search is
    <aBuf>

    @param[in] aBuf                   Reassembly buffer

    Return values are documented in reverse-chronological order
    @retval    BCM_ERR_OK             Reassembly buffer freed
    @retval    BCM_ERR_NOT_FOUND      Buffer could not be found or was
                                      unallocated

    @trace #BRCM_SWREQ_INET
*/
int32_t INET_FreeReassemblyBuffer(const uint8_t* const aBuf);

/**
    @brief Check end point ID and update reassembly buffer state

    @pre None

    Atomically sets the state of the reassembly buffer to INET_REASSBUFSTATE_RCVD
    after validation of the aEndPtID

    @param[in] aBuf                   Reassembly data buffer pointer
    @param[in] aEndPtID               End point ID of the client

    Return values are documented in reverse-chronological order
    @retval    BCM_ERR_OK             Reassembly buffer State successfully set
    @retval    BCM_ERR_INVAL_STATE    Reassembly buffer State set failure as
                                      buffer state was not INET_REASSBUFSTATE_QUEUED
    @retval    BCM_ERR_NOT_FOUND      The reassembly buffer pointer is invalid
                                      or the buffer has timed out and
                                      not intended for current client

    @trace #BRCM_SWREQ_INET
*/
int32_t INET_ClientAckReassBuf(const uint8_t* const aBuf,
                               INET_EndPointIdType const aEndPtID);

/**
    @brief Inform client of received UDP data

    @pre None

    Invoked by the stack to indicate that UDP payload is available. System can
    identify the exact client from the provided information and notify it.

    @param[in] aSrcAddr               Source IP Address in a received IP datagram
    @param[in] aSrcPort               Source L4 port
    @param[in] aDestPort              Destination L4 port
    @param[in] aL4Protocol            L4 protocol of received data
    @param[in] aBuf                   Buffer containing payload
    @param[in] aLen                   Length of payload in buffer
    @param[in] aIntfId                Interface on which the Rx packet was got

    Return values are documented in reverse-chronological order
    @retval    BCM_ERR_OK             Client notified successfully
    @retval    BCM_ERR_NOT_FOUND      No client found for the received packet
    @retval    BCM_ERR_NOMEM          No space in the receive packet queue
    @retval    BCM_ERR_UNKNOWN        Client task coud not be notified

    @trace #BRCM_SWREQ_INET
*/
int32_t INET_UDPReceiveIndication(const INET_IPAddressType aSrcAddr,
                                  const INET_PortType aSrcPort,
                                  const INET_PortType aDestPort,
                                  const INET_L4ProtoType aL4Protocol,
                                  const uint8_t* const aBuf,
                                  const uint16_t aLen,
                                  INET_InterfaceIdType aIntfId);

/**
    @brief Allocate ephemeral port

    @pre None

    Allocates a unique port number in the ephemeral range

    Return values are documented in reverse-chronological order
    @retval    #INET_PortType        Port number

    @trace #BRCM_SWREQ_INET
*/
INET_PortType INET_AllocateEphemeralPort(void);

/**
    @brief Update local port of INET end point

    @pre None

    This API is used to update the local port on which the end point
    needs to transmit packets.

    @behavior Sync, Non re-entrant

    @param[in]   aCompId               Component identifier
    @param[in]   aPayloadId            Payload identifier
    @param[in]   aPort                 Port number
    @param[in]   aIsUnBind             Boolean flag to indicate if this
                                       call is for clearing the binding of
                                       end point to the local UDP port

    @retval  #BCM_ERR_OK               Local port number successfully set
    @retval  #BCM_ERR_INVAL_PARAMS     No UDP end point allocated for this client
    @retval  #BCM_ERR_NOPERM           aPort is already bound to another end point
    @retval  #BCM_ERR_INVAL_STATE      when #aIsUnBind is TRUE, End point has an
                                       active Tx buffer due to which UnBinding
                                       cannot happen. Client shall UDP_Cancel the
                                       buffer before UnBinding end point.

    @post None

    @trace #BRCM_SWREQ_INET

    @limitations None
*/
int32_t INET_SetEndPointLocalPort(const BCM_CompIDType aCompId,
                                  const INET_PayloadType aPayloadId,
                                  INET_PortType  aPort,
                                  uint32_t aIsUnBind);

/**
    @brief Inform client of received TCP data

    @pre None

    Invoked by the stack to indicate that TCP payload is available. System can
    identify the exact client from the provided information, copy the data to
    its buffer and notify it.

    @param[in] aSrcAddr               Source IP Address in received IP datagram
    @param[in] aTcpHdr                Parsed TCP header
    @param[in] aBuf                   Buffer containing payload
    @param[in] aLen                   Length of payload in buffer
    @param[in] aIntfId                Interface on which the Rx packet was got

    Return values are documented in reverse-chronological order
    @retval    BCM_ERR_OK             TCP data copied to endpoint buffer successfully
    @retval    BCM_ERR_NOT_FOUND      No endpoint found for the received packet
    @retval    BCM_ERR_NOMEM          No space in the receive packet queue
    @retval    BCM_ERR_UNKNOWN        Client task coud not be notified

    @trace #BRCM_SWREQ_INET
*/
int32_t INET_TCPReceiveIndication(const INET_IPAddressType aSrcAddr,
                                  const INET_TCPHdrType *const aTcpHdr,
                                  const uint8_t* const aBuf,
                                  const uint16_t aLen,
                                  INET_InterfaceIdType aIntfId);

/**
    @brief Trigger the TCP state machine

    @pre None

    Once the endpoint has been identified, its state machine needs to be
    triggered to change the state and take action.

    @param[in] aEndPt                 Endpoint object
    @param[in] aEvent                 Event trigger for the TCP state machine
    @param[in] aTcpHdr                TCP header (in case this event is being
                                      triggered on receiving a TCP segment from
                                      the peer)
    @param[in] aPayloadLen            Length of the payload (in case this event
                                      is being triggered on receiving a TCP
                                      segment from the peer)
    @param[in] aSrcIPAddr             Source IP address (in case this event is
                                      being triggered on receiving a TCP segment
                                      from the peer)

    Return values are documented in reverse-chronological order
    @retval    BCM_ERR_OK             TCP state machine triggered successfully
    @retval    BCM_ERR_NOT_FOUND      No valid state transition found for the
                                      input event in the current state
    @retval    BCM_ERR_UNKNOWN        State machine error

    @trace #BRCM_SWREQ_INET
*/
int32_t INET_TCPTriggerStateMachine(INET_EndPointObjectType *const aEndPt,
                                    const INET_TCPEventType aEvent,
                                    const INET_TCPHdrType *const aTcpHdr,
                                    const uint32_t aPayloadLen,
                                    const INET_IPAddressType aSrcIPAddr);

/**
    @brief Get TCP event from packet

    @pre None

    Converts a received TCP header to event which can be used to trigger the
    TCP state machine

    @param[in] aEndPt                 Endpoint object
    @param[in] aTcpHdr                TCP header

    Return values are documented in reverse-chronological order
    @return    event

    @trace #BRCM_SWREQ_INET
*/
INET_TCPEventType INET_TCPGetEventFromPkt(INET_EndPointObjectType *const aEndPt, const INET_TCPHdrType* const aTcpHdr);

/**
    @brief Reset TCP endpoint

    @pre None

    Used to cleanup the TCP endpoint data when a connection is closed so that the
    same endpoint can be reused for another connection

    @param[in] aEndPt                 Endpoint object

    Return values are documented in reverse-chronological order
    @retval    BCM_ERR_OK             TCP endpoint reset successfully
    @retval    Other errors returned by #CIRCQ_Reset

    @trace #BRCM_SWREQ_INET
*/
int32_t INET_TCPResetEndPoint(const INET_EndPointObjectType *const aEndPtObj);

/**
    @brief Process control messages on TCP endpoints

    @retval      void

    @post None

    @trace #BRCM_SWREQ_INET

*/
void INET_TCPProcessCtrlMsgs(void);

#endif /* INET_CFG_H */
/** @} */
