/*****************************************************************************
 Copyright 2022 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_ethernet_ets_ifc Switch ETS abstract Interface
    @ingroup grp_ethernet_abstract

    @addtogroup grp_ethernet_ets_ifc
    @{

    @file ethernet_ets.h

    @brief ETS Abstract Interface
    This file contains the interfaces for the Ethernet abstract for ETS

    @version 1.0 Initial version
*/

#ifndef ETHERNET_ETS_H
#define ETHERNET_ETS_H

#include <module_msg.h>
#include <bcm_time.h>

/**
    @name ETS API IDs
    @{
    @brief API IDs for ETS
*/
#define BRCM_SWARCH_ETS_CMD_TYPE                 (0x8800U) /**< @brief #ETS_CmdType */
#define BRCM_SWARCH_ETS_MAX_PAYLOAD_SIZE_MACRO   (0x8801U) /**< @brief #ETS_MAX_PAYLOAD_SIZE */
#define BRCM_SWARCH_ETS_MSG_TYPE                 (0x8802U) /**< @brief #ETS_MsgType */
#define BRCM_SWARCH_ETS_REDUNDANCYSTATE_TYPE     (0x8803U) /**< @brief #ETS_RedundancyStateType */
#define BRCM_SWARCH_ETS_MACRO                    (0x8804U) /**< @brief #ETS_HOST_MAX_PORTS */
#define BRCM_SWARCH_ETS_TIMESOURCE_TYPE          (0x8805U) /**< @brief #ETS_TimeSourceType */
#define BRCM_SWARCH_ETS_SYSTEMIDENTITY_TYPE      (0x8806U) /**< @brief #ETS_SystemIdentityType */
#define BRCM_SWARCH_ETS_GMSTATUS_TYPE            (0x8807U) /**< @brief #ETS_GMStatusType */
#define BRCM_SWARCH_ETS_CLOCKSTATE_TYPE          (0x8808U) /**< @brief #ETS_ClockStateType */
#define BRCM_SWARCH_ETS_TIMESTATE_TYPE           (0x8809U) /**< @brief #ETS_TimeStateType */
#define BRCM_SWARCH_ETS_LOGINTERVAL_TYPE         (0x880AU) /**< @brief #ETS_LogIntervalType */
#define BRCM_SWARCH_ETS_ROLE_TYPE                (0x880BU) /**< @brief #ETS_RoleType */
#define BRCM_SWARCH_ETS_TIME_TYPE                (0x880CU) /**< @brief #ETS_TimeType */
#define BRCM_SWARCH_ETS_DOMAIN_TYPE              (0x880DU) /**< @brief #ETS_DomainType */
#define BRCM_SWARCH_ETS_CLOCKIDENTITY_TYPE       (0x880EU) /**< @brief #ETS_ClockIdentityType */
#define BRCM_SWARCH_ETS_PORTIDENTITY_TYPE        (0x880FU) /**< @brief #ETS_PortIdentityType */
#define BRCM_SWARCH_ETS_PATHTRACETLV_TYPE        (0x8810U) /**< @brief #ETS_PathTraceTLVType */
#define BRCM_SWARCH_ETS_GMIDENTIFIER_TYPE        (0x8811U) /**< @brief #ETS_GMIdentifierType */
#define BRCM_SWARCH_ETS_DOMAINSTATUS_TYPE        (0x8812U) /**< @brief #ETS_DomainStatusType */
#define BRCM_SWARCH_ETS_PORTSTATUS_TYPE          (0x8813U) /**< @brief #ETS_PortStatusType */
#define BRCM_SWARCH_ETS_DOMAINPORTSTATUS_TYPE    (0x8814U) /**< @brief #ETS_DomainPortStatusType */
#define BRCM_SWARCH_ETS_STATS_TYPE               (0x8815U) /**< @brief #ETS_StatsType */
#define BRCM_SWARCH_ETS_EVENT_TYPE               (0x8816U) /**< @brief #ETS_EventType */
#define BRCM_SWARCH_ETS_RECORDDEFS_TYPE          (0x8817U) /**< @brief #ETS_RecordDefsType */
#define BRCM_SWARCH_ETS_RECORD_TYPE              (0x8818U) /**< @brief #ETS_RecordType */
#define BRCM_SWARCH_ETS_RECORDSLIST_TYPE         (0x8819U) /**< @brief #ETS_RecordsListType */
#define BRCM_SWARCH_ETS_PORTNUMANDSTATUS_TYPE    (0x881AU) /**< @brief #ETS_PortNumAndStatusType */
#define BRCM_SWARCH_ETS_PORTENABLE_TYPE          (0x881BU) /**< @brief #ETS_PortEnableType */
#define BRCM_SWARCH_ETS_PORTPDELAYANDNBRR_TYPE   (0x881CU) /**< @brief #ETS_PortPDelayAndNBRRType */
#define BRCM_SWARCH_ETS_DOMAINENABLE_TYPE        (0x881DU) /**< @brief #ETS_DomainEnableType */
#define BRCM_SWARCH_ETS_DOMAINNUMANDSTATUS_TYPE  (0x881EU) /**< @brief #ETS_DomainNumAndStatusType */
#define BRCM_SWARCH_ETS_PERDOMAINPORTSTATUS_TYPE (0x881FU) /**< @brief #ETS_PerDomainPortStatusType */
#define BRCM_SWARCH_ETS_GLOBALSTATUS_TYPE        (0x8820U) /**< @brief #ETS_GlobalStatusType */
#define BRCM_SWARCH_ETS_MSGUNION_TYPE            (0x8821U) /**< @brief #ETS_MsgUnionType */
#define BRCM_SWARCH_ETS_HOSTCONTEXT_TYPE         (0x8822U) /**< @brief #ETS_HostContextType */
#define BRCM_SWARCH_ETS_HOSTCONTEXTSETUP_PROC    (0x8823U) /**< @brief #ETS_HostContextSetup */
#define BRCM_SWARCH_ETS_HOSTCONTEXTPROCESS_PROC  (0x8824U) /**< @brief #ETS_HostContextProcess */
#define BRCM_SWARCH_ETS_HELPER_GLOBAL            (0x8825U) /**< @brief #ETS_Helper */
#define BRCM_SWARCH_ETS_HELPERCTX_GLOBAL         (0x8826U) /**< @brief #ETS_HelperCtx */
#define BRCM_SWARCH_ETS_HELPERCTX_TYPE           (0x8827U) /**< @brief #ETS_HelperCtxType */
#define BRCM_SWARCH_ETS_RECORDSCACHEHDLR_PROC    (0x8828U) /**< @brief #ETS_RecordsCacheHdlr */
/** @} */

/**
    @name ETS_CmdType
    @{
    @brief Command identifiers for the ETS module

    @trace #BRCM_SWREQ_ETS_COMMON
*/
typedef uint8_t ETS_CmdType;              /**< @brief typedef for ETS Command */
#define ETS_CMD_RESETSTATS          (2U)  /**< @brief #ETS_PerDomainPortStatusType  #ETS_ResetStats               */
#define ETS_CMD_GETGLOBALSTATUS     (5U)  /**< @brief #ETS_GlobalStatusType         #ETS_GetGlobalStatus          */
#define ETS_CMD_GETPORTSTATUS       (6U)  /**< @brief #ETS_PortNumAndStatusType     #ETS_GetPortStatus            */
#define ETS_CMD_SETGLOBALTIME       (7U)  /**< @brief #ETS_TimeType                 #ETS_SetGlobalTime            */
#define ETS_CMD_NOTIFY_RECORD       (8U)  /**< @brief #uint32_t                     #ETS_EnableRecordNotification */
#define ETS_CMD_SETGLOBALENABLE     (9U)  /**< @brief #uint32_t                     #ETS_Restart                 */
#define ETS_CMD_SETPORTENABLE       (10U) /**< @brief #ETS_PortEnableType           #ETS_Restart                 */
#define ETS_CMD_GETDOMAINSTATUS     (11U) /**< @brief #ETS_DomainNumAndStatusType   #ETS_GetDomainStatus          */
#define ETS_CMD_GETDOMAINPORTSTATUS (12U) /**< @brief #ETS_PerDomainPortStatusType  #ETS_GetDomainPortStatus      */
#define ETS_CMD_SETDOMAINENABLE     (13U) /**< @brief #TBD                                                        */
/** @} */

/**
    @brief Maximum size of ETS command payload in bytes

    @trace #BRCM_SWREQ_ETS_COMMON
*/
#define ETS_MAX_PAYLOAD_SIZE        (448UL)

/**
    @name ETS_MsgType
    @{
    @brief gPTP PDU message type
    @trace #BRCM_SWREQ_ETS_COMMON

*/
typedef uint8_t ETS_MsgType;                   /**< @brief typedef for ETS PDU message type   */
#define ETS_MSG_SYNC                     (0U)  /**< @brief Message type of Sync PDU */
#define ETS_MSG_PDELAY_REQ               (2U)  /**< @brief Message type of PDelay Request PDU */
#define ETS_MSG_PDELAY_RESP              (3U)  /**< @brief Message type of PDelay Response PDU */
#define ETS_MSG_FOLLOWUP                 (8U)  /**< @brief Message type of Follow up PDU */
#define ETS_MSG_PDELAY_RESP_FOLLOWUP     (10U) /**< @brief Message type of PDelay Response Follow Up PDU */
#define ETS_MSG_ANNOUNCE                 (11U) /**< @brief Message type of Announce PDU */
#define ETS_MSG_SIGNALING                (12U) /**< @brief Message type of Signaling PDU */
/** @} */

/**
    @name ETS_RedundancyStateType
    @{
    @brief ETS redundancy state
    @trace #BRCM_SWREQ_ETS_COMMON
*/
typedef uint8_t ETS_RedundancyStateType;      /**< @brief typedef for ETS redundancy state */
#define ETS_REDUNDANCYSTATE_ACTIVE       (0U) /**< @brief Active state */
#define ETS_REDUNDANCYSTATE_STANDBY      (1U) /**< @brief Standby state */
/** @} */

/**
    @brief Macros of ETS
    @{
    @trace #BRCM_SWREQ_ETS_COMMON
*/
#define ETS_HOST_MAX_PORTS               (16UL)                   /**< @brief Number of ETS Ports */
#define ETS_CMDRESP_PAYLOAD_SIZE         (448UL)                  /**< @brief Size of the payload in the message queue command response */
#define ETS_NUM_RECORDS_PER_PORT         (5UL)                    /**< @brief Number of records per Port */
#define ETS_GLBL_STATUS_MAGIC_ID         (0x47535445UL)           /**< @brief Magic number for the status structure containing 'ETSG' */
#define ETS_PORT_STATUS_MAGIC_ID         (0x49535445UL)           /**< @brief Magic number for the status structure containing 'ETSI' */
#define ETS_DOMAIN_STATUS_MAGIC_ID       (0x44535445UL)           /**< @brief Magic number for the status structure containing 'ETSD' */
#define ETS_DOMAIN_PORT_STATUS_MAGIC_ID  (0x45535445UL)           /**< @brief Magic number for the status structure containing 'ETSE' */
#define ETS_CLOCK_ID_LEN                 (8U)                     /**< @brief Length of clock identity - 8 octets */
#define ETS_MAX_HOPS_PER_DOMAIN          (8U)                     /**< @brief Maximum hops expected in an AVB network */
#define ETS_STATS_MAGIC_ID               (0x53535445UL)           /**< @brief Statistics structure magic */
#define ETS_MAX_RECORDS_PER_IPC_MSG      (((ETS_CMDRESP_PAYLOAD_SIZE) - sizeof(uint32_t)) / sizeof(ETS_RecordType))
/** @} */


/**
    @name ETS_TimeSourceType
    @{
    @brief Allowed values of time source
    @trace #BRCM_SWREQ_ETS_COMMON
*/
typedef uint8_t ETS_TimeSourceType;          /**< @brief typedef for time source */
#define ETS_TIMESOURCE_ATOMIC_CLK    (0x10U) /**< @brief Atomic clock */
#define ETS_TIMESOURCE_GPS           (0x20U) /**< @brief GPS */
#define ETS_TIMESOURCE_RADIO         (0x30U) /**< @brief Terrestrial Radio */
#define ETS_TIMESOURCE_PTP           (0x40U) /**< @brief PTP */
#define ETS_TIMESOURCE_NTP           (0x50U) /**< @brief NTP */
#define ETS_TIMESOURCE_HAND_SET      (0x60U) /**< @brief Hand Set */
#define ETS_TIMESOURCE_OTHER         (0x90U) /**< @brief Other */
#define ETS_TIMESOURCE_INT_OSC       (0xA0U) /**< @brief Internal Oscillator */
/** @} */

/**
    @brief System Identity
    @trace #BRCM_SWREQ_ETS_COMMON
*/
typedef struct sETS_SystemIdentityType {
    uint8_t  priority1;               /**< @brief Priority1 */

    uint8_t  clockClass;              /**< @brief Clock class */

    uint8_t  clockAccuracy;           /**< @brief Clock accuracy */

    uint16_t offsetScaledLogVariance; /**< @brief Clock precision */

    uint8_t  priority2;               /**< @brief Priority2 */
} COMP_PACKED ETS_SystemIdentityType;

/**
    @name ETS_GMStatusType
    @{
    @brief Grandmaster status
    @trace #BRCM_SWREQ_ETS_COMMON

*/
typedef uint32_t ETS_GMStatusType;        /**< @brief typedef for grandmaster status */
#define ETS_GMSTATUS_STARTUP_ABSENT (0UL) /**< @brief GM absent since startup and
                                               the Sync absence timer has
                                               expired */
#define ETS_GMSTATUS_OPER_ABSENT    (1UL) /**< @brief GM has been absent after
                                               startup */
#define ETS_GMSTATUS_UNDETERMINED   (2UL) /**< @brief GM status cannot be
                                               determined because Sync absence
                                               timeout has not yet occured */
#define ETS_GMSTATUS_DISABLED       (3UL) /**< @brief Slave port not asCapable */
#define ETS_GMSTATUS_NO_SLAVEPORT   (4UL) /**< @brief No slave port */
#define ETS_GMSTATUS_PRESENT        (5UL) /**< @brief GM is currently present */
/** @} */

/**
    @name ETS_ClockStateType
    @{
    @brief Network clock status
    @trace #BRCM_SWREQ_ETS_COMMON

*/
typedef uint32_t ETS_ClockStateType;      /**< @brief typedef for clock status */
#define ETS_CLOCKSTATE_INIT_GM      (0UL) /**< @brief Clock is yet to be
                                               initialized as GM */
#define ETS_CLOCKSTATE_UPDATE_GM    (1UL) /**< @brief Clock is initialized as
                                               GM */
#define ETS_CLOCKSTATE_INIT_SLAVE   (2UL) /**< @brief Clock is yet to be
                                               initialized as slave */
#define ETS_CLOCKSTATE_UPDATE_SLAVE (3UL) /**< @brief Clock is initialized as
                                               slave */
/** @} */

/**
    @name ETS_TimeStateType
    @{
    @brief State representing accuracy of the network time
    @trace #BRCM_SWREQ_ETS_COMMON

*/
typedef uint32_t ETS_TimeStateType;    /**< @brief typedef for time state */
#define ETS_TIMESTATE_SYNC       (0UL) /**< @brief Local gPTP clock is
                                            synced to Grandmaster */
#define ETS_TIMESTATE_UNSYNC     (1UL) /**< @brief Local gPTP clock is
                                            not synced to Grandmaster */
#define ETS_TIMESTATE_UNCERTAIN  (2UL) /**< @brief Local gPTP clock is in
                                            holdover */
/** @} */

/**
    @name ETS_LogIntervalType
    @{
    @brief Allowed values of intervals in logarithmic (base-2) scale
    @trace #BRCM_SWREQ_ETS_COMMON
*/
typedef int32_t ETS_LogIntervalType;     /**< @brief typedef for intervals */
#define ETS_LOGINTERVAL_31_25MS   (-5L)  /**< @brief 31.25ms period*/
#define ETS_LOGINTERVAL_62_5MS    (-4L)  /**< @brief 62.5ms period */
#define ETS_LOGINTERVAL_125MS     (-3L)  /**< @brief 125ms period */
#define ETS_LOGINTERVAL_250MS     (-2L)  /**< @brief 250ms period */
#define ETS_LOGINTERVAL_500MS     (-1L)  /**< @brief 500ms period */
#define ETS_LOGINTERVAL_1S        (0L)   /**< @brief 1s period*/
#define ETS_LOGINTERVAL_2S        (1L)   /**< @brief 2s period*/
#define ETS_LOGINTERVAL_4S        (2L)   /**< @brief 4s period*/
#define ETS_LOGINTERVAL_8S        (3L)   /**< @brief 8s period*/
#define ETS_LOGINTERVAL_16S       (4L)   /**< @brief 16s period*/
#define ETS_LOGINTERVAL_32S       (5L)   /**< @brief 32s period*/
#define ETS_LOGINTERVAL_INF       (127L) /**< @brief Infinite period (disabled) */
#define ETS_LOGINTERVAL_REQ_INIT  (126L) /**< @brief Initial interval */
#define ETS_LOGINTERVAL_REQ_NONE  (-128L)/**< @brief No change to existing interval */
/** @} */

/**
    @name ETS_RoleType
    @{
    @brief ETS Port Role
    @trace #BRCM_SWREQ_ETS_COMMON
*/
typedef uint8_t ETS_RoleType;         /**< @brief typedef for ETS port role */
#define ETS_ROLE_MASTER          (0U) /**< @brief Master role */
#define ETS_ROLE_SLAVE           (1U) /**< @brief Slave role */
#define ETS_ROLE_DISABLED        (2U) /**< @brief Disabled role */
#define ETS_ROLE_PASSIVE         (3U) /**< @brief Passive role */
/** @} */

/**
    @brief gPTP Time
    @trace #BRCM_SWREQ_ETS_COMMON

    Structure to carry time information represented with respect to the epoch

*/
typedef struct sETS_TimeType {
    uint64_t seconds;     /**< @brief Seconds component of time */

    uint32_t nanoseconds; /**< @brief Nanoseconds component of time */
} ETS_TimeType;
_Static_assert(sizeof(ETS_TimeType) <= ETS_MAX_PAYLOAD_SIZE,
               "ETS_TimeType does not fit in IPC payload");

/**
    @name ETS_DomainType
    @{
    @brief ETS Domain number
    @trace #BRCM_SWREQ_ETS_COMMON
*/
typedef uint8_t ETS_DomainType;  /**< @brief typedef for domain number */
/** @} */

/**
    @brief gPTP clock identity
    @trace #BRCM_SWREQ_ETS_COMMON

    Clock identity identifies a time aware system. It is an 8-octet array formed
    by mapping an IEEE EUI-48 (System MAC address) assigned to the time-aware
    system to IEEE EUI-64 format (i.e., to an array of 8 octets).

*/
typedef struct sETS_ClockIdentityType {
    uint8_t   id[ETS_CLOCK_ID_LEN]; /**< @brief clock identity bytes */
} ETS_ClockIdentityType;


/**
    @brief Structure for gPTP Port Identity
    @trace #BRCM_SWREQ_ETS_COMMON

    10 byte structure with the 8 byte clock identity and 2 byte port number
*/
typedef struct sETS_PortIdentityType {
    ETS_ClockIdentityType clockID;      /**< @brief 8 byte gPTP clock identity */
    uint16_t              port;         /**< @brief 2 byte gPTP port number    */
} ETS_PortIdentityType;

/**
    @brief Structure for Path Trace TLV
    @trace #BRCM_SWREQ_ETS_COMMON
*/
typedef struct sETS_PathTraceTLVType {
    uint16_t              type;                           /**< @brief TLV type */
    uint16_t              length;                         /**< @brief Length of
                                                               TLV data */
    ETS_ClockIdentityType clkID[ETS_MAX_HOPS_PER_DOMAIN]; /**< @brief Clock
                                                               identity of hops */
} ETS_PathTraceTLVType;

/**
    @brief GM identity
    @trace #BRCM_SWREQ_ETS_COMMON

    Structure to carry GM identifiers

*/
typedef struct sETS_GMIdentifierType {
    uint16_t               stepsRemoved; /**< @brief stepsRemoved field
                                              in selected Announce */

    ETS_ClockIdentityType  clockId;      /**< @brief Clock identity */

    ETS_SystemIdentityType systemId;     /**< @brief System identity */

    ETS_TimeSourceType     timeSource;   /**< @brief Time source */

    ETS_PathTraceTLVType   pathTrace;    /**< @brief Path Trace in selected
                                              Announce */
    uint16_t               utcOffset;    /**< @brief UTC offset */

    uint16_t               flags;        /**< @brief Flags */

} ETS_GMIdentifierType;

/**
    @brief Domain status
    @trace #BRCM_SWREQ_ETS_COMMON

    Status maintained by the ETS. Can be retrieved using the
    ETS_GetDomainStatus() API

*/
typedef struct sETS_DomainStatusType {
    uint32_t                magicId;                 /**< @brief Magic word
                                                          'ETSD' (checked for
                                                          validity) */

    ETS_ClockStateType      clockState;              /**< @brief Clock state */

    ETS_GMStatusType        gmStatus;                /**< @brief Grandmaster
                                                          status */

    int32_t                 rateRatioIn;             /**< @brief Incoming rate
                                                          ratio */

    int32_t                 gmRateRatio;             /**< @brief Grandmaster
                                                          rate ratio */

    uint32_t                slavePort;               /**< @brief Port acting as
                                                          slave */

    uint16_t                signalingTxSeqId;        /**< @brief Signaling
                                                          transmit sequence
                                                          number */

    int32_t                 reqSyncLogInterval;      /**< @brief Requested Sync
                                                          interval (logarithmic
                                                          scale) on the slave
                                                          interface */

    uint32_t                isSignalingTimerStarted; /**< @brief Flag indicating
                                                          whether the signaling
                                                          timer has started */

    uint32_t                isSyncReceived;          /**< @brief Flag indicating
                                                          whether atleast one sync
                                                          has been received */

    int64_t                 rxFollowupCorrection;    /**< @brief Last received
                                                          correction */

    ETS_TimeType            rxPOT;                   /**< @brief Last received
                                                          Precise Origin
                                                          Timestamp */

    ETS_GMIdentifierType    gmIdentifier;            /**< @brief GM identifer
                                                          Applicable only in IEEE
                                                          mode */

    uint32_t                gmChangeCount;           /**< @brief Count of how
                                                          many times the GM has
                                                          changed. Applicable only
                                                          in IEEE mode */

    ETS_PortIdentityType    parentId;                /**< @brief Port identity
                                                          of parent in timing
                                                          tree. Applicable only
                                                          in IEEE mode and for
                                                          non-GM device */

    ETS_RedundancyStateType domainState;             /**< @brief Redundancy state
                                                          of the domain */
} ETS_DomainStatusType;

/**
    @brief Interface status
    @trace #BRCM_SWREQ_ETS_COMMON

    Interface status maintained by the ETS. Can be retrieved using the
    ETS_GetPortStatus() API

*/
typedef struct sETS_PortStatusType {
    uint32_t          magicId;                    /**< @brief Magic word 'ETSI'
                                                       (checked for validity) */

    uint32_t          nbrPropDelay;               /**< @brief Peer delay */

    int32_t           nbrRateRatio;               /**< @brief Neighbour rate
                                                       ratio */

    uint32_t          isMeasuringPdelay;          /**< @brief Is Pdelay
                                                       requestor running */

    uint32_t          isAVnuPdelayConfigSaved;    /**< @brief Is the AVnu Pdelay
                                                       configuration saved to
                                                       NVM */

    ETS_LogIntervalType  currentLogPdelayIntvl;   /**< @brief Current Pdelay
                                                       transmit interval in
                                                       logarithmic scale */


    ETS_PortIdentityType partnerId;               /**< @brief Partner port
                                                       identifier */

    uint16_t          pDelayTxSeqId;              /**< @brief Pdelay requestor
                                                       sequence number */

    uint32_t          numPdelayRespLost;          /**< @brief Number of
                                                       consecutive pdelay
                                                       timeouts */

    uint32_t          pDelayReqState;             /**< @brief PDelay requestor
                                                       state */

    uint32_t          pDelayRespState;            /**< @brief PDelay responder
                                                       state */

    ETS_TimeType      pDelayT1;                   /**< @brief PDelay request
                                                       egress timestamp */

    ETS_TimeType      pDelayT2;                   /**< @brief PDelay request
                                                       ingress timestamp */

    ETS_TimeType      pDelayT3;                   /**< @brief PDelay response
                                                       egress timestamp */

    ETS_TimeType      pDelayT4;                   /**< @brief PDelay response
                                                       ingress timestamp */

    uint32_t          asCapableAcrossDomains;     /**< @brief asCapable across
                                                       domains */
} ETS_PortStatusType;

/**
    @brief Per Domain-Interface status
    @trace #BRCM_SWREQ_ETS_COMMON

    Per Domain Interface status maintained by the ETS. Can be retrieved using the
    ETS_GetDomainPortStatus() API

*/
typedef struct sETS_DomainPortStatusType {
    uint32_t            magicId;                    /**< @brief Magic word 'ETSE'
                                                         (checked for validity) */

    ETS_RoleType        role;                       /**< @brief Port role */

    ETS_LogIntervalType currentLogSyncIntvl;        /**< @brief Current Sync
                                                         transmit interval in
                                                         logarithmic scale */

    uint32_t            syncReceiptTimeoutIntvl;    /**< @brief Sync receipt
                                                         timeout interval */

    uint32_t            syncInfoAvailable;          /**< @brief New Sync
                                                         information received on
                                                         slave port */

    uint16_t            syncSeqNum;                 /**< @brief Sync
                                                         received/transmitted
                                                         sequence number */

    uint64_t            txFollowupCorrection;       /**< @brief Outgoing
                                                         correction */

    uint32_t            syncState;                  /**< @brief Sync Tx/Rx
                                                         state (as per role) */

    ETS_TimeType        syncTimestamp;              /**< @brief Sync egress
                                                         timestamp */

    uint16_t            announceSeqNum;             /**< @brief Announce
                                                         transmit
                                                         sequence number */

    ETS_LogIntervalType currentLogAnnIntvl;         /**< @brief Current Announce
                                                         transmit interval in
                                                         logarithmic scale */

    uint32_t            annReceiptTimeoutIntvl;     /**< @brief Announce receipt
                                                         timeout interval */

    ETS_LogIntervalType currentLogGptpCapIntvl;     /**< @brief Current gPTP
                                                         capable transmit interval
                                                         in logarithmic scale */

    uint32_t            gPTPCapReceiptTimeoutIntvl; /**< @brief gPTP capable
                                                         receipt timeout
                                                         interval */

} ETS_DomainPortStatusType;

/** @struct  ETS_StatsType
    @brief Statistics maintained by ETS
    @trace #BRCM_SWREQ_ETS_COMMON
*/
typedef struct sETS_StatsType {
    uint32_t magicId;                     /**< @brief Magic word 'ETSS'
                                               (checked for validity) */

    uint32_t syncTxCount;                 /**< @brief Number of Sync packets
                                               transmitted */

    uint32_t syncRxCount;                 /**< @brief Number of Sync packets
                                               received */

    uint32_t syncTransmitTimeouts;        /**< @brief Number of Sync packets
                                               transmitted as proxy */

    uint32_t syncRxDiscards;              /**< @brief Number of received Sync
                                               packets discarded */

    uint32_t followUpTxCount;             /**< @brief Number of Follow Up
                                               packets transmitted */

    uint32_t followUpRxCount;             /**< @brief Number of Follow Up
                                               packets received */

    uint32_t followUpRxDiscards;          /**< @brief Number of received Follow
                                               Up packets discarded */

    uint32_t signalingTxCount;            /**< @brief Number of Signaling
                                               packets transmitted */

    uint32_t signalingRxCount;            /**< @brief Number of Signaling
                                               packets received */

    uint32_t signalingRxDiscards;         /**< @brief Number of received
                                               Signaling packets discarded */

    uint32_t pDelayReqTxCount;            /**< @brief Number of PDelay Request
                                               packets transmitted */

    uint32_t pDelayReqRxCount;            /**< @brief Number of PDelay Request
                                               packets received */

    uint32_t pDelayReqRxDiscards;         /**< @brief Number of received PDelay
                                               Request packets discarded */

    uint32_t pDelayRespTxCount;           /**< @brief Number of PDelay Response
                                               packets transmitted */

    uint32_t pDelayRespRxCount;           /**< @brief Number of PDelay Response
                                               packets received */

    uint32_t pDelayRespRxDiscards;        /**< @brief Number of received PDelay
                                               Response packets discarded */

    uint32_t pDelayRespFollowUpTxCount;   /**< @brief Number of PDelay Follow Up
                                               Response packets transmitted */

    uint32_t pDelayRespFollowUpRxCount;   /**< @brief Number of PDelay Follow Up
                                               Response packets received */

    uint32_t syncReceiptTimeouts;         /**< @brief Number of instances where
                                               Sync packets were not received
                                               for N (syncReceiptTimeout)
                                               consecutive intervals */

    uint32_t followupReceiptTimeouts;     /**< @brief Number of Follow Up
                                               packets not received within 1
                                               Sync interval */

    uint32_t pDelayReceiptTimeouts;       /**< @brief Time-outs in Reception of
                                               PDelay Response or Pdelay
                                               Response Follow Up packets */

    uint32_t badPdelayValues;             /**< @brief Invalid PDelay values,
                                               say negative */

    uint32_t txErrors;                    /**< @brief Number of packets not
                                               transmitted due to errors */

    uint32_t tsErrors;                    /**< @brief Number of errors in
                                               retrieving hardware timestamps */

    uint32_t ptpDiscardCount;             /**< @brief Sum of
                                               pDelayReceiptTimeouts &
                                               followupReceiptTimeouts */

    uint32_t parseFailed;                 /**< @brief Number of invalid packets
                                               received */

    uint32_t txConf;                      /**< @brief Number of transmit
                                               confirmations received */

    uint32_t pDelayLostResponsesExceeded; /**< @brief Number of Pdelay Responses
                                               lost */

    uint32_t setTimeCount;                /**< @brief number of times NIF_SetTime
                                               was invoked */

    uint32_t deltaTime0NsTo10Ns;          /**< @brief Number of times NIF_SetCorrectionTime
                                               was invoked with value between 0ns-10ns */

    uint32_t deltaTime11NsTo40Ns;        /**< @brief Number of times NIF_SetCorrectionTime
                                               was invoked with value between 11ns-40ns */

    uint32_t deltaTime41NsTo80Ns;        /**< @brief Number of times NIF_SetCorrectionTime
                                               was invoked with value between 41ns-80ns */

    uint32_t deltaTime81NsTo100Ns;        /**< @brief Number of times NIF_SetCorrectionTime
                                               was invoked with value between 81ns-100ns */

    uint32_t deltaTime101NsTo1000Ns;      /**< @brief Number of times NIF_SetCorrectionTime
                                               was invoked with value between 101ns-1000ns */

    uint32_t deltaTime1001NsTo10000Ns;    /**< @brief Number of times NIF_SetCorrectionTime
                                               was invoked with value between 1001ns-10000ns */

    uint32_t deltaTime10001NsToMax;       /**< @brief Number of times NIF_SetCorrectionTime
                                               was invoked with value greater than 10000ns */

    uint32_t announceTxCount;             /**< @brief Number of Announce packets transmitted */

    uint32_t announceRxCount;             /**< @brief Number of Announce packets received */

    uint32_t announceRxDiscards;          /**< @brief Number of received Announce packets
                                               discarded */

    uint32_t announceReceiptTimeouts;     /**< @brief Number of Announce receipt timeouts */
} ETS_StatsType;

/**
    @name ETS_Event
    @{
    @brief Event reported by ETS
    @trace #BRCM_SWREQ_ETS_COMMON

*/
typedef uint8_t ETS_EventType;                  /**< @brief typedef for Events
                                                     reported by ETS */
#define ETS_EVENT_IF_UP                    (0U) /**< @brief gPTP up on the interface */
#define ETS_EVENT_IF_DOWN                  (1U) /**< @brief gPTP down on the interface */
#define ETS_EVENT_SYNC                     (2U) /**< @brief Synced to network time */
#define ETS_EVENT_SYNC_LOST                (3U) /**< @brief Network time Sync lost */
#define ETS_EVENT_IF_LOST_RESP_EXCEEDED    (4U) /**< @brief PDelay lost
                                                     responses exceeded */
#define ETS_EVENT_IF_LOST_RESP_RECOVERED   (5U) /**< @brief Interface has
                                                     resumed receiving PDelay
                                                     response */
#define ETS_EVENT_IF_PDELAY_CHANGED        (6U) /**< @brief PDelay changed by more than
                                                     100u on the interface */
#define ETS_EVENT_IF_RECORD                (7U) /**< @brief  Record notification */
#define ETS_EVENT_ANNOUNCE_LOST            (8U) /**< @brief Announce receipt timeout */
/** @} */

/**
    @name ETS_RecordDefsType
    @{
    @brief Definitions for Record
    @trace #BRCM_SWREQ_ETS_COMMON

*/
typedef uint32_t ETS_RecordDefsType;                         /**< @brief typedef for Record definitions */
#define ETS_RECORDDEFS_NUM_MASK          (0xFFFFFF00UL)      /**< @brief Mask for the recordNum field in the portAndRecNum parameter */
#define ETS_RECORDDEFS_NUM_SHIFT         (8UL)               /**< @brief Bit shift for the recordNum field in the portAndRecNum parameter */
#define ETS_RECORDDEFS_PORT_NUM_MASK     (0x000000FFUL)      /**< @brief Mask for the portIdx field in the portAndRecNum parameter */
#define ETS_RECORDDEFS_PORT_NUM_SHIFT    (0UL)               /**< @brief Bit shift for the portIdx field in the portAndRecNum parameter */
#define ETS_RECORDDEFS_IS_VALID_MASK     (0x80000000UL)      /**< @brief Mask for the valid field in the flag parameter */
#define ETS_RECORDDEFS_IS_VALID_SHIFT    (31UL)              /**< @brief Bit shift for the valid field in the flag parameter */
#define ETS_RECORDDEFS_ROLE_MASK         (0x60000000UL)      /**< @brief Mask for the role field in the flag parameter */
#define ETS_RECORDDEFS_ROLE_SHIFT        (29UL)              /**< @brief Bit shift for the role field in the flag parameter */
#define ETS_RECORDDEFS_GM_STATUS_MASK    (0x1C000000UL)      /**< @brief Mask for the gmStatus field in the flag parameter */
#define ETS_RECORDDEFS_GM_STATUS_SHIFT   (26UL)              /**< @brief Bit shift for the gmStatus field in the flag parameter */
#define ETS_RECORDDEFS_IS_LINK_UP_MASK   (0x02000000UL)      /**< @brief Mask for the isLinkUp field in the flag parameter */
#define ETS_RECORDDEFS_IS_LINK_UP_SHIFT  (25UL)              /**< @brief Bit shift for the isLinkUp field in the flag parameter */
#define ETS_RECORDDEFS_IS_TX_MASK        (0x01000000UL)      /**< @brief Mask for the isTx field in the flag parameter */
#define ETS_RECORDDEFS_IS_TX_SHIFT       (24UL)              /**< @brief Bit shift for the isTx field in the flag parameter */
#define ETS_RECORDDEFS_PACKET_TYPE_MASK  (0x00F00000UL)      /**< @brief Mask for the packetType field in the flag parameter */
#define ETS_RECORDDEFS_PACKET_TYPE_SHIFT (20UL)              /**< @brief Bit shift for the packetType field in the flag parameter */
#define ETS_RECORDDEFS_RESERVED_MASK     (0x000F0000UL)      /**< @brief Mask for the reserved field in the flag parameter */
#define ETS_RECORDDEFS_RESERVED_SHIFT    (16UL)              /**< @brief Bit shift for the reserved field in the flag parameter */
#define ETS_RECORDDEFS_SEQ_NUM_MASK      (0x0000FFFFUL)      /**< @brief Mask for the seqNum field in the flag parameter */
#define ETS_RECORDDEFS_SEQ_NUM_SHIFT     (0UL)               /**< @brief Bit shift for the seqNum field in the flag parameter */
/** @} */

/**
    @brief Record
    @trace #BRCM_SWREQ_ETS_COMMON
*/
typedef struct sETS_RecordType {
    BCM_TimeType           gmTime;              /**< @brief Calculated or received gPTP-Time (reference GM) */
    BCM_TimeType           localTime;           /**< @brief Local clock timestamp */
    BCM_TimeType           followupTimestamp;   /**< @brief Followup timestamp */
    ETS_PortIdentityType   srcPortIdentity;     /**< @brief Source port identity */
    uint64_t               deltaCorrectionTime; /**< @brief Delta Correction Time */
    uint32_t               pDelay;              /**< @brief pDelay value for a given port */
    uint32_t               portAndRecNum;       /**< @brief combined value of switch port number and record sequence number
                                                    encoded in a bitfield as follows:
                                                    record sequence number (24) | switch port number (8)*/
    uint32_t               flag;                /**< @brief combined value of all flags
                                                    encoded in a bitfield as follows:
                                                    valid(1) | role (2) | gmStatus (3) | isLinkUp (1) |
                                                    isTx (1) | packetType (4) | reserved (4) | seqNum (16)*/
} ETS_RecordType;
_Static_assert(sizeof(ETS_RecordType) <= ETS_MAX_PAYLOAD_SIZE,
               "ETS_RecordType does not fit in IPC payload");

/**
    @brief Collection of records per IPC message
    @trace #BRCM_SWREQ_ETS_COMMON
*/
typedef struct sETS_RecordsListType {
    uint32_t                 numRecords;
    ETS_RecordType records[ETS_MAX_RECORDS_PER_IPC_MSG];
} ETS_RecordsListType;
_Static_assert(sizeof(ETS_RecordsListType) <= ETS_MAX_PAYLOAD_SIZE,
               "ETS_RecordsListType does not fit in IPC payload");

/**
    @brief Port status
    @trace #BRCM_SWREQ_ETS_COMMON
*/
typedef struct sETS_PortNumAndStatusType {
    uint32_t           num;    /**< @brief Port number */
    ETS_PortStatusType status; /**< @brief Port status */
} ETS_PortNumAndStatusType;
_Static_assert(sizeof(ETS_PortNumAndStatusType) <= ETS_MAX_PAYLOAD_SIZE,
               "ETS_PortNumAndStatusType does not fit in IPC payload");

/**
    @brief Port enable
    @trace #BRCM_SWREQ_ETS_COMMON
*/
typedef struct sETS_PortEnableType {
    uint32_t           num;         /**< @brief Port number */
    ETS_DomainType     domain;      /**< @brief Domain number */
    uint32_t           portEnable;  /**< @brief Port enable */
} ETS_PortEnableType;
_Static_assert(sizeof(ETS_PortEnableType) <= ETS_MAX_PAYLOAD_SIZE,
               "ETS_PortEnableType does not fit in IPC payload");

/**
    @brief Port PDelay and Neighbour Rate Ratio
    @trace #BRCM_SWREQ_ETS_COMMON
*/
typedef struct sETS_PortPDelayAndNBRRType {
    uint32_t port;     /**< @brief Port number */
    uint32_t pDelay;  /**< @brief Peer Delay */
    int32_t  nbrr;    /**< @brief Neighbour Rate Ratio */
} ETS_PortPDelayAndNBRRType;
_Static_assert(sizeof(ETS_PortPDelayAndNBRRType) <= ETS_MAX_PAYLOAD_SIZE,
               "ETS_PortPDelayAndNBRRType does not fit in IPC payload");

/**
    @brief Domain enable
    @trace #BRCM_SWREQ_ETS_COMMON
*/
typedef struct sETS_DomainEnableType {
    ETS_DomainType num;          /**< @brief Domain number */
    uint32_t       domainEnable; /**< @brief Domain enable */
} ETS_DomainEnableType;
_Static_assert(sizeof(ETS_DomainEnableType) <= ETS_MAX_PAYLOAD_SIZE,
               "ETS_DomainEnableType does not fit in IPC payload");

/**
    @brief Domain status
    @trace #BRCM_SWREQ_ETS_COMMON
*/
typedef struct sETS_DomainNumAndStatusType {
    ETS_DomainType       num;    /**< @brief Domain number */
    ETS_DomainStatusType status; /**< @brief Domain status */
} ETS_DomainNumAndStatusType;
_Static_assert(sizeof(ETS_DomainNumAndStatusType) <= ETS_MAX_PAYLOAD_SIZE,
               "ETS_DomainNumAndStatusType does not fit in IPC payload");

/**
    @brief Per-domain port status
    @trace #BRCM_SWREQ_ETS_COMMON
*/
typedef struct sETS_PerDomainPortStatusType {
    ETS_DomainType           domain;    /**< @brief Domain number */
    uint32_t                 portNum;   /**< @brief Port number */
    ETS_DomainPortStatusType status;    /**< @brief Domain-dependent port status */
    ETS_StatsType            stats;     /**< @brief Port statistics */
} ETS_PerDomainPortStatusType;
_Static_assert(sizeof(ETS_PerDomainPortStatusType) <= ETS_MAX_PAYLOAD_SIZE,
               "ETS_PerDomainPortStatusType does not fit in IPC payload");

/**
    @brief Global status
    @trace #BRCM_SWREQ_ETS_COMMON

    Status maintained by the ETS. Can be retrieved using the
    ETS_GetGlobalStatus() API

*/
typedef struct sETS_GlobalStatusType {
    uint32_t              magicId;          /**< @brief Magic word 'ETSG'
                                                  (checked for validity) */

    ETS_ClockIdentityType clockId;          /**< @brief Local clock identity */

    ETS_TimeType          networkTime;      /**< @brief Network time */

    ETS_TimeStateType     networkTimeState; /**< @brief Network time state */
    ETS_DomainType        activeDomainNum;  /**< @brief Active domain number */
} ETS_GlobalStatusType;
_Static_assert(sizeof(ETS_GlobalStatusType) <= ETS_MAX_PAYLOAD_SIZE,
               "ETS_GlobalStatusType does not fit in IPC payload");

/**
    @brief ETS Union encapsulating all messages

    @trace #BRCM_SWREQ_ETS_COMMON
*/
typedef union uETS_MsgUnionType {
    uint32_t                      data[ETS_MAX_PAYLOAD_SIZE/4UL];  /**< @brief Max Payload size */
    ETS_PortNumAndStatusType      portStatus;                      /**< @brief port status */
    ETS_GlobalStatusType          globalStatus;                    /**< @brief global status */
    ETS_TimeType                  time;                            /**< @brief time */
    uint32_t                      portNum;                         /**< @brief port number */
    ETS_PortPDelayAndNBRRType     pDelayNBRR;                      /**< @brief PDelay and Neighbour Rate Ratio */
    ETS_RecordsListType           records;                         /**< @brief records */
    uint32_t                      isNotifyingRecord;               /**< @brief notification record state */
    uint32_t                      globalEnable;                    /**< @brief global enable */
    ETS_PortEnableType            portEnable;                      /**< @brief port enable */
    ETS_DomainEnableType          domainEnable;                    /**< @brief domain enable */
    ETS_DomainNumAndStatusType    domainStatus;                    /**< @brief domain status */
    ETS_PerDomainPortStatusType   domainPortStatus;                /**< @brief per-domain portstatus */
} ETS_MsgUnionType;
_Static_assert(sizeof(ETS_MsgUnionType) <= ETS_MAX_PAYLOAD_SIZE,
               "ETS_MsgUnionType does not fit in IPC payload");

/**
    @brief ETS Host Context Type

    @trace #BRCM_SWREQ_ETS_COMMON
*/
typedef struct sETS_HostContextType {
    BCM_StateType        state;      /**< @brief Context State           */
    BCM_SubStateType     subState;   /**< @brief Context Sub State       */
    BCM_CmdType          id;         /**< @brief Command/Response ID     */
    int32_t              status;     /**< @brief final status of command */
    ETS_MsgUnionType     msg;        /**< @brief Message input/output    */
} ETS_HostContextType;

/**
    @brief Setup ETS Host context

    @behavior Sync, Non-Rentrant

    @pre None

    @param[inout]   aContext        Context to be setup
    @param[in]      aSecYID         Command/Message Type
    @param[in]      aMsgPayload     Command/Message payload

    Return values are documented in reverse-chronological order
    @retval     BCM_ERR_OK              Setup for initialization complete
    @retval     BCM_ERR_INVAL_PARAMS    aContext is NULL or aInitMsg is NULL

    @post aContext.state is changes to RUNNING.

    @trace #BRCM_SWREQ_ETS_COMMON

    @limitations None
*/
int32_t ETS_HostContextSetup(ETS_HostContextType *aContext, ETS_CmdType aCmdID,
                             const ETS_MsgUnionType *aMsgPayload);

/**
    @brief Process ETS Host context

    @behavior Sync, Non-Rentrant

    @pre None

    @param[inout]   aContext        Context to be setup
    @param[in]      aResponse       Response code received from RPC Message
    @param[in]      aInitMsg        Received message ID
    @param[in]      aInMsgPayload   Received message payload
    @param[out]     aOutMsgId       Next message ID
    @param[out]     aInitMsg        Next message payload

    Return values are documented in reverse-chronological order
    @retval     BCM_ERR_OK              Process complete
    @retval     BCM_ERR_BUSY            Process is on going
    @retval     BCM_ERR_UNKNOWN         Integration fault
    @retval     BCM_ERR_INVAL_PARAMS    aContext is NULL or aInMsgPayload is NULL
                                        or aOutMsgId is NULL or aOutMsgPayload is NULL

    @post aContext.state is changes to RUNNING.

    @note aContext.u.status will reflect the error reported by the function referenced
    at @ref ETS_CmdType, and any output will be reflected in the structure represented
    at @ref ETS_CmdType.

    @trace #BRCM_SWREQ_ETS_COMMON

    @limitations None
*/
int32_t ETS_HostContextProcess(ETS_HostContextType *aContext, int32_t aResponse,
                               BCM_CmdType aInMsgID, const uint8_t *aInMsgPayload,
                               BCM_CmdType *aOutMsgId, uint8_t *aOutMsgPayload);

/**
    @brief ETS Helper Module Context Type

    @Note This structure will be moved out in future

    @trace #BRCM_SWREQ_ETS_COMMON
*/
typedef struct sETS_HelperCtxType {
    MODULE_MsgContextType       modCtx;         /**< @brief Helper interface Context   */
    ETS_HostContextType         ctx;            /**< @brief Abstract interface Context */
    uint32_t                    isPortStats;    /**< @brief Is query for statistics.
                                                     TRUE:  Query for statistics
                                                     FALSE: Query for status           */
    ETS_RecordType              record[ETS_HOST_MAX_PORTS][ETS_NUM_RECORDS_PER_PORT]; /**< @brief Records */
    uint32_t                    isRecordStart;  /**< @brief Start or Stop Records      */
} ETS_HelperCtxType;

/**
    @brief ETS Helper Module Context

    @trace #BRCM_SWREQ_ETS_COMMON
*/
extern ETS_HelperCtxType ETS_HelperCtx;

/**
    @brief ETS Records cache Handler

    @Note that this interface is subject to change in future

    @trace #BRCM_SWREQ_ETS_COMMON

    @code{.unparsed}
    @endcode
*/
extern int32_t ETS_RecordsCacheHdlr(BCM_CmdType   *aMsg,
                                    uint8_t       *aBuff,
                                    uint32_t       aInputLen,
                                    uint32_t      *aOutLen,
                                    uint32_t       aMaxLength,
                                    int32_t        aResponse,
                                    ETS_HelperCtxType *aCtx);

/**
    @brief Host ETS Helper Module

    @trace #BRCM_SWREQ_ETS_COMMON
*/
extern const MODULE_MsgConverterType ETS_Helper;

#endif /* ETHERNET_ETS_H */
/** @} */
