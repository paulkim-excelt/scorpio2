/*****************************************************************************
 Copyright 2021 Broadcom Limited.  All rights reserved.

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
    
    @file ets_pdu.h
    @brief Ethernet TimeSync library integration interfaces.
    This header file defines the integration interfaces for ETS library.
    @version 0.1 draft
*/

#ifndef ETS_PDU_H
#define ETS_PDU_H

/**
    @name ETS IL API IDs
    @{
    @brief API IDs for ETS IL
 */
#define BRCM_SWARCH_ETS_ANNOUNCEPDUBODY_TYPE             (0x9401U)    /**< @brief #ETS_AnnouncePDUBodyType          */
#define BRCM_SWARCH_ETS_PDU_TYPE                         (0x9402U)    /**< @brief #ETS_PDUType                       */
#define BRCM_SWARCH_ETS_PDUHEADER_TYPE                   (0x9403U)    /**< @brief #ETS_PDUHeaderType                 */
#define BRCM_SWARCH_ETS_SYNCPDUBODY_TYPE                 (0x9404U)    /**< @brief #ETS_SyncPDUBodyType               */
#define BRCM_SWARCH_ETS_FOLLOWUPPDUBODY_TYPE             (0x9405U)    /**< @brief #ETS_FollowUpPDUBodyType           */
#define BRCM_SWARCH_ETS_PDELAYREQPDUBODY_TYPE            (0x9406U)    /**< @brief #ETS_PDelayReqPDUBodyType          */
#define BRCM_SWARCH_ETS_PDELAYRESPPDUBODY_TYPE           (0x9407U)    /**< @brief #ETS_PDelayRespPDUBodyType         */
#define BRCM_SWARCH_ETS_PDELAYRESPFOLLOWUPPDUBODY_TYPE   (0x9408U)    /**< @brief #ETS_PDelayRespFollowUpPDUBodyType */
#define BRCM_SWARCH_ETS_SIGNALINGPDUBODY_TYPE            (0x9409U)    /**< @brief #ETS_SignalingPDUBodyType          */
#define BRCM_SWARCH_ETS_FOLLOWUPTLV_TYPE                 (0x940AU)    /**< @brief #ETS_FollowUpTLVType               */
#define BRCM_SWARCH_ETS_MSGINTERVALREQTLV_TYPE           (0x940BU)    /**< @brief #ETS_MsgIntervalReqTLVType         */
#define BRCM_SWARCH_ETS_PDULEN_TYPE                      (0x940CU)    /**< @brief #ETS_PDULenType                    */
#define BRCM_SWARCH_ETS_SCALED_NS_LEN_MACRO              (0x940DU)    /**< @brief #ETS_SCALED_NS_LEN                 */
/** @} */

/**
    @brief Length in bytes of scaled NS field in Followup TLV
    @trace #BRCM_SWREQ_ETS_TYPES

*/
#define ETS_SCALED_NS_LEN                 12UL

/**
    @name ETS_PDULenType
    @{
    @brief Definitions for PDU lengths

    @trace #BRCM_SWREQ_ETS_TYPES
*/
typedef uint16_t ETS_PDULenType;               /**< @brief typedef for ETS PDU lengths */
#define ETS_PDULEN_PDELAY_REQ_RESV_FIELD (10U) /**< @brief Pdelay reserved field length */
#define ETS_PDULEN_PDELAY_REQ            (20U) /**< @brief Length of PDelay request PDU body */
#define ETS_PDULEN_PDELAY_RESP_FOLLOWUP  (20U) /**< @brief Length of PDelay response followup body */
#define ETS_PDULEN_SYNC                  (10U) /**< @brief Length of Sync PDU body */
#define ETS_PDULEN_PDELAY_RESP           (20U) /**< @brief Length of PDelay response PDU body */
#define ETS_PDULEN_FOLLOWUP              (42U) /**< @brief Length of Follow Up PDU body */
#define ETS_PDULEN_SIGNALING             (26U) /**< @brief Length of Signaling PDU body */
#define ETS_PDULEN_SIGNALING_MSG_INT_TLV (12U) /**< @brief Length of Signaling message interval TLV */
#define ETS_PDULEN_FOLLOWUP_TLV          (28U) /**< @brief Length of Follow Up TLV */
#define ETS_PDULEN_ANNOUNCE              (42U) /**< @brief Length of Announce PDU (minimum size) */
#define ETS_PDULEN_ANNOUNCE_RESV1_FIELD  (10U) /**< @brief Length of Announce reserved1 field */
#define ETS_PDULEN_ANNOUNCE_RESV2_FIELD  (1U)  /**< @brief Length of Announce reserved2 field */
/** @} */

/**
    @brief Structure for gPTP packet common header
    @trace #BRCM_SWREQ_ETS_TYPES

*/
typedef struct sETS_PDUHeaderType {
  ETS_MsgType          msgType;           /**< @brief Message Type                   */
  uint8_t              transportSpecific; /**< @brief Transport specific field       */
  uint8_t              version;           /**< @brief 802.1AS version                */
  uint16_t             pduLen;            /**< @brief PDU length (2 bytes)           */
  uint8_t              domain;            /**< @brief 802.1AS domain number (1 byte) */
  uint8_t              reserved1;         /**< @brief Reserved field (1 byte)        */
  uint16_t             flags;             /**< @brief 802.1AS flags (2 bytes)        */
  int64_t              correctionFld;     /**< @brief Correction field (8 byte)      */
  uint32_t             reserved2;         /**< @brief Reserved (4 bytes)             */
  ETS_PortIdentityType portId;            /**< @brief Port identity (10 bytes)       */
  uint16_t             sequenceId;        /**< @brief SequenceId (2 bytes)           */
  uint8_t              control;           /**< @brief Control Field (1 byte)         */
  int8_t               pduInterval;       /**< @brief Log mean PDU interval          */
} ETS_PDUHeaderType;

/**
    @brief Structure for SYNC PDU body format
    @trace #BRCM_SWREQ_ETS_TYPES

*/
typedef struct sETS_SyncPDUBodyType {
  uint8_t   reserved[ETS_PDULEN_SYNC]; /**< @brief Reserved Field. Set to 0 */
} ETS_SyncPDUBodyType;

/**
    @brief Structure for Standard FOLLOWUP TLV
    @trace #BRCM_SWREQ_ETS_TYPES

*/
typedef struct sETS_FollowUpTLVType {
  uint16_t      type;                /**< @brief TLV type */
  uint16_t      length;              /**< @brief Length of TLV data */
  uint8_t       orgId[3];            /**< @brief Organization ID */
  uint8_t       orgSubType[3];       /**< @brief Organization subtype */
  int32_t       cumulativeRateOfst;  /**< @brief Value of (rateRatio . 1.0) * 2^41*/
  uint16_t      gmTimeBaseIndicator; /**< @brief Value indicating change in GM frequency or phase*/
  int8_t        lastGmPhaseChange[ETS_SCALED_NS_LEN]; /**< @brief Change in GM source time */
  int32_t       lastGmFreqChange;    /**< @brief Change in GM frequency */
} ETS_FollowUpTLVType;

/**
    @brief Structure for FOLLOWUP PDU body format
    @trace #BRCM_SWREQ_ETS_TYPES

*/
typedef struct sETS_FollowUpPDUBodyType {
    ETS_FollowUpTLVType tlv;                    /**< @brief Standard follow-up tlv (mandatory) */
    ETS_TimeType   preciseOriginTimestamp; /**< @brief Timestamp of associated SYNC */
} ETS_FollowUpPDUBodyType;

/**
    @brief Structure for PDELAY Request PDU body format
    @trace #BRCM_SWREQ_ETS_TYPES

*/
typedef struct sETS_PDelayReqPDUBodyType {
    uint8_t reserved1[ETS_PDULEN_PDELAY_REQ_RESV_FIELD]; /**< @brief Reserved Field. Set to 0*/
    uint8_t reserved2[ETS_PDULEN_PDELAY_REQ_RESV_FIELD]; /**< @brief Reserved Field. Set to 0*/
} ETS_PDelayReqPDUBodyType;

/**
    @brief Structure for PDELAY Response PDU body format
    @trace #BRCM_SWREQ_ETS_TYPES

*/
typedef struct sETS_PDelayRespPDUBodyType {
    ETS_TimeType    reqReceiptTimestamp;  /**< @brief Timestamp of PDELAYi Request PDU */
    ETS_PortIdentityType reqPortId;            /**< @brief PortIdentity of requesting port */
} ETS_PDelayRespPDUBodyType;

/**
    @brief Structure for PDELAY Response Follow up PDU body format
    @trace #BRCM_SWREQ_ETS_TYPES

*/
typedef struct sETS_PDelayRespFollowUpPDUBodyType {
    ETS_TimeType    respOriginTimestamp;  /**< @brief Timestamp of PDELAY Response PDU */
    ETS_PortIdentityType reqPortId;            /**< @brief PortIdentity of requesting port */
} ETS_PDelayRespFollowUpPDUBodyType;

/**
    @brief Structure for SIGNALING Message interval request TLV
    @trace #BRCM_SWREQ_ETS_TYPES

*/
typedef struct sETS_MsgIntervalReqTLVType {
    uint16_t   type;              /**< @brief TLV type                          */
    uint16_t   length;            /**< @brief Length of TLV data                */
    uint8_t    orgId[3];          /**< @brief Organization ID                   */
    uint8_t    orgSubType[3];     /**< @brief Organization subtype              */
    int8_t     linkDelayInterval; /**< @brief Mean time interval for PDELAY_REQ */
    int8_t     timeSyncInterval;  /**< @brief Mean time interval for SYNC       */
    int8_t     announceInterval;  /**< @brief Mean time interval for ANNOUNCE   */
    uint8_t    flags;             /**< @brief Flag field. Set to 0              */
    uint16_t   reserved;          /**< @brief Reserved field. Set to 0          */
} ETS_MsgIntervalReqTLVType;

/**
    @brief Structure for SIGNALING PDU body format
    @trace #BRCM_SWREQ_ETS_TYPES

*/
typedef struct sETS_SignalingPDUBodyType {
    ETS_PortIdentityType      targetPortIdentity; /**< @brief Identity of port at other end */
    ETS_MsgIntervalReqTLVType msgIntReqTlv;       /**< @brief Message interval request TLV  */
} ETS_SignalingPDUBodyType;

/**
    @brief Structure for Announce PDU body format
    @trace #BRCM_SWREQ_ETS_TYPES

*/
typedef struct sETS_AnnouncePDUBodyType {
    uint8_t                reserved1[ETS_PDULEN_ANNOUNCE_RESV1_FIELD]; /**< @brief Reserved Field. Set to 0*/
    uint16_t               currentUtcOffset;                           /**< @brief Current UTC offset */
    uint8_t                reserved2[ETS_PDULEN_ANNOUNCE_RESV2_FIELD]; /**< @brief Reserved Field. Set to 0*/
    ETS_SystemIdentityType gmSystemID;                                 /**< @brief GM priority1, clockQuality, priority2 */
    ETS_ClockIdentityType  gmIdentity;                                 /**< @brief GM Identity */
    uint16_t               stepsRemoved;                               /**< @brief Steps Removed */
    uint8_t                timeSource;                                 /**< @brief Time Source */
    ETS_PathTraceTLVType   pathTraceTlv;                               /**< @brief Path Trace TLV */
} ETS_AnnouncePDUBodyType;

/**
    @brief Structure for gPTP PDU format
    @trace #BRCM_SWREQ_ETS_TYPES

*/
typedef struct sETS_PDUType {
    ETS_PDUHeaderType hdr;                                       /**< @brief Header */
    union {                                                      /**< @brief Body   */
        ETS_SyncPDUBodyType               syncPdu;               /**< @brief Sync PDU body */
        ETS_FollowUpPDUBodyType           followUpPdu;           /**< @brief Followup PDU body */
        ETS_PDelayReqPDUBodyType          pDelayReqPdu;          /**< @brief PDelay Request PDU body */
        ETS_PDelayRespPDUBodyType         pDelayRespPdu;         /**< @brief PDelay Response PDU body */
        ETS_PDelayRespFollowUpPDUBodyType pDelayRespFollowUpPdu; /**< @brief PDelay Response Followup PDU body */
        ETS_SignalingPDUBodyType          signalingPdu;          /**< @brief Signaling PDU body */
        ETS_AnnouncePDUBodyType           announcePdu;           /**< @brief Announce PDU body */
    } body;
} ETS_PDUType;

#endif /* ETS_PDU_H*/
/** @} */