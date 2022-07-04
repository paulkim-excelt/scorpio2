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

 2. TO THE COMP_MAXIMUM EXTENT PERMITTED BY LAW, THE SOFTWARE IS PROVIDED "AS IS"
    AND WITH ALL FAULTS AND BROADCOM MAKES NO PROMISES, REPRESENTATIONS OR
    WARRANTIES, EITHER EXPRESS, IMPLIED, STATUTORY, OR OTHERWISE, WITH RESPECT
    TO THE SOFTWARE.  BROADCOM SPECIFICALLY DISCLAIMS ANY AND ALL IMPLIED
    WARRANTIES OF TITLE, MERCHANTABILITY, NONINFRINGEMENT, FITNESS FOR A
    PARTICULAR PURPOSE, LACK OF VIRUSES, ACCURACY OR COMPLETENESS,
    QUIET ENJOYMENT, QUIET POSSESSION OR CORRESPONDENCE TO DESCRIPTION.
    YOU ASSUME THE ENTIRE RISK ARISING OUT OF USE OR PERFORMANCE OF THE
    SOFTWARE.

 3. TO THE COMP_MAXIMUM EXTENT PERMITTED BY LAW, IN NO EVENT SHALL BROADCOM OR ITS
    LICENSORS BE LIABLE FOR (i) CONSEQUENTIAL, INCIDENTAL, SPECIAL, INDIRECT,
    OR EXEMPLARY DAMAGES WHATSOEVER ARISING OUT OF OR IN ANY WAY RELATING TO
    YOUR USE OF OR INABILITY TO USE THE SOFTWARE EVEN IF BROADCOM HAS BEEN
    ADVISED OF THE POSSIBILITY OF SUCH DAMAGES; OR (ii) ANY AMOUNT IN EXCESS
    OF THE AMOUNT ACTUALLY PAID FOR THE SOFTWARE ITSELF OR U.S. $1, WHICHEVER
    IS GREATER. THESE LIMITATIONS SHALL APPLY NOTWITHSTANDING ANY FAILURE OF
    ESSENTIAL PURPOSE OF ANY LIMITED REMEDY.
******************************************************************************/

/**
    @defgroup grp_crypto_secy_ifc SecY Interface
    @ingroup grp_crypto_abstract

    @addtogroup grp_crypto_secy_ifc
    @{

    @limitations None

    @file crypto_secy.h
    @brief Crypto MAC Security Entity (MACSEC) Interface
    This header file contains the interface functions for Crypto MAC Security Entity (MACSEC)

    @version 1.0 Initial Version
*/

#ifndef CRYPTO_SECY_H
#define CRYPTO_SECY_H

#include <crypto_common.h>
#include <bcm_comp.h>
#include <module_msg.h>

/**
    @name Crypto SecY Architecture IDs
    @{
    @brief Architecture IDs for Crypto SecY
*/
#define BRCM_SWARCH_SECY_TYPE                        (0x8300U) /**< @brief #SECY_IdType              */
#define BRCM_SWARCH_SECY_MACRO                       (0x8301U) /**< @brief #SECY_XPN_SALT_LEN     */
#define BRCM_SWARCH_SECY_HW_CFG_TYPE                 (0x8302U) /**< @brief #SECY_HwCfgType         */
#define BRCM_SWARCH_SECY_VALIDATE_FRAME_TYPE         (0x8303U) /**< @brief #SECY_ValidateFrameType */
#define BRCM_SWARCH_SECY_RULE_OPT0_TYPE              (0x8304U) /**< @brief #SECY_RuleOpt0Type      */
#define BRCM_SWARCH_SECY_RULE_OPT1_TYPE              (0x8305U) /**< @brief #SECY_RuleOpt1Type      */
#define BRCM_SWARCH_SECY_CFG_TYPE                    (0x8306U) /**< @brief #SECY_CfgType           */
#define BRCM_SWARCH_SECY_CIPHER_TYPE                 (0x8307U) /**< @brief #SECY_CipherType        */
#define BRCM_SWARCH_SECY_CIPHER_CAP_TYPE             (0x8308U) /**< @brief #SECY_CipherCapType     */
#define BRCM_SWARCH_SECY_CONF_OFFSET_TYPE            (0x8309U) /**< @brief #SECY_ConfOffsetType    */
#define BRCM_SWARCH_SECY_RULE_MATCH_TYPE             (0x830AU) /**< @brief #SECY_RuleMatchType     */
#define BRCM_SWARCH_SECY_RULE_DIR_TYPE               (0x830BU) /**< @brief #SECY_RuleDirType       */
#define BRCM_SWARCH_SECY_SCI_TYPE                    (0x830CU) /**< @brief #SECY_SCIType           */
#define BRCM_SWARCH_SECY_KEY_TYPE                    (0x830DU) /**< @brief #SECY_KeyType           */
#define BRCM_SWARCH_SECY_SA_STATUS_TYPE              (0x830EU) /**< @brief #SECY_SAStatusType      */
#define BRCM_SWARCH_SECY_STATS_TYPE                  (0x830FU) /**< @brief #SECY_StatsType         */
#define BRCM_SWARCH_SECY_TXSCSTATS_TYPE              (0x8310U) /**< @brief #SECY_TxSCStatsType     */
#define BRCM_SWARCH_SECY_RXSCSTATS_TYPE              (0x8311U) /**< @brief #SECY_RxSCStatsType     */
#define BRCM_SWARCH_SECY_TXSASTATS_TYPE              (0x8312U) /**< @brief #SECY_TxSAStatsType     */
#define BRCM_SWARCH_SECY_ID_OF_MACRO                 (0x8313U) /**< @brief #SECY_ID_OF             */

#define BRCM_SWARCH_SECY_HW_INIT_MSG_TYPE            (0x8320U) /**< @brief #SECY_HwInitMsgType     */
#define BRCM_SWARCH_SECY_RULE_OPT0_MSG_TYPE          (0x8321U) /**< @brief #SECY_RuleOpt0MsgType   */
#define BRCM_SWARCH_SECY_RULE_OPT1_MSG_TYPE          (0x8322U) /**< @brief #SECY_RuleOpt1MsgType   */
#define BRCM_SWARCH_SECY_HDL_MSG_TYPE                (0x8323U) /**< @brief #SECY_HdlMsgType        */
#define BRCM_SWARCH_SECY_CREATE_MSG_TYPE             (0x8324U) /**< @brief #SECY_CreateMsgType     */
#define BRCM_SWARCH_SECY_GET_CIPHER_MSG_TYPE         (0x8325U) /**< @brief #SECY_GetCipherMsgType  */
#define BRCM_SWARCH_SECY_SET_CIPHER_MSG_TYPE         (0x8326U) /**< @brief #SECY_SetCipherMsgType  */
#define BRCM_SWARCH_SECY_DEBUG_MSG_TYPE              (0x8327U) /**< @brief #SECY_DebugMsgType      */
#define BRCM_SWARCH_SECY_STATS_MSG_TYPE              (0x8328U) /**< @brief #SECY_StatsMsgType      */
#define BRCM_SWARCH_SECY_SC_MSG_TYPE                 (0x8329U) /**< @brief #SECY_SCMsgType         */
#define BRCM_SWARCH_SECY_LOOKUP_RULE_MSG_TYPE        (0x832AU) /**< @brief #SECY_LookupRuleMsgType */
#define BRCM_SWARCH_SECY_TXSC_STATS_MSG_TYPE         (0x832BU) /**< @brief #SECY_TxSCStatsMsgType  */
#define BRCM_SWARCH_SECY_RX_SC_STATS_MSG_TYPE        (0x832CU) /**< @brief #SECY_RxSCStatsMsgType  */
#define BRCM_SWARCH_SECY_SA_MSG_TYPE                 (0x832DU) /**< @brief #SECY_SAMsgType         */
#define BRCM_SWARCH_SECY_PN_MSG_TYPE                 (0x832EU) /**< @brief #SECY_PNMsgType         */
#define BRCM_SWARCH_SECY_SA_STATUS_MSG_TYPE          (0x832FU) /**< @brief #SECY_SAStatusMsgType   */
#define BRCM_SWARCH_SECY_TX_SA_STATS_MSG_TYPE        (0x8330U) /**< @brief #SECY_TxSAStatsMsgType  */
#define BRCM_SWARCH_SECY_HW_DEINIT_MSG_TYPE          (0x8331U) /**< @brief #SECY_HwDeinitMsgType   */

#define BRCM_SWARCH_SECY_MSG_UNION_TYPE              (0x8380U) /**< @brief #SECY_MsgUnionType      */
#define BRCM_SWARCH_SECY_MSG_TYPE                    (0x8381U) /**< @brief #SECY_MsgType           */
#define BRCM_SWARCH_SECY_SEND_CMD_PROC               (0x8382U) /**< @brief #SECY_SendCmd           */
#define BRCM_SWARCH_SECY_GET_RESP_PROC               (0x8383U) /**< @brief #SECY_GetResp           */

#define BRCM_SWARCH_SECY_HOST_CONTEXT_TYPE           (0x83C0U) /**< @brief #SECY_HostContextType   */
#define BRCM_SWARCH_SECY_HOST_CONTEXT_SETUP_PROC     (0x83C1U) /**< @brief #SECY_HostContextSetup  */
#define BRCM_SWARCH_SECY_HOST_CONTEXT_PROCESS_PROC   (0x83C2U) /**< @brief #SECY_HostContextProcess*/
#define BRCM_SWARCH_SECY_HOST_HELPER_GLOBAL          (0x83C3U) /**< @brief #SECY_HostHelper        */

/** @} */

/**
    @brief Macro to Construct SECY CmdID

    @trace #BRCM_SWREQ_SECY
*/
#define SECY_ID_OF(aId)     \
    BCM_CMDID(BCM_GROUPID_CRYPTO, BCM_CSY_ID, aId)
/**
    @name CRYPTO SecY Message IDs
    @{
    @brief Message IDs for exchange on message queues

    @trace #BRCM_SWREQ_SECY
*/
typedef uint32_t SECY_IdType;     /**< @brief Pa message Type */
#define SECY_HW_INIT             SECY_ID_OF(0xC0U) /**< @brief #SECY_HwInitMsgType       #MACSEC_Init                */
#define SECY_ADD_CP_RULE_OPT0    SECY_ID_OF(0xC1U) /**< @brief #SECY_RuleOpt0MsgType     #MACSEC_AddCPRuleOpt0       */
#define SECY_ADD_CP_RULE_OPT1    SECY_ID_OF(0xC2U) /**< @brief #SECY_RuleOpt1MsgType     #MACSEC_AddCPRuleOpt1       */
#define SECY_REM_CP_RULE         SECY_ID_OF(0xC3U) /**< @brief #SECY_HdlMsgType          #MACSEC_RemoveCPRule        */
#define SECY_HW_DEINIT           SECY_ID_OF(0xCFU) /**< @brief #SECY_HwDeinitMsgType     #MACSEC_DeInit              */
#define SECY_CREATE              SECY_ID_OF(0xD0U) /**< @brief #SECY_CreateMsgType       #MACSEC_CreateSecY          */
#define SECY_GET_CIPHER_CAP      SECY_ID_OF(0xD1U) /**< @brief #SECY_GetCipherMsgType    #MACSEC_GetCipherCap        */
#define SECY_SET_CIPHER_SUITE    SECY_ID_OF(0xD2U) /**< @brief #SECY_SetCipherMsgType    #MACSEC_SetCipherSuite      */
#define SECY_ADD_LOOKUP_RULE     SECY_ID_OF(0xD3U) /**< @brief #SECY_LookupRuleMsgType   #MACSEC_AddSecYLookupRule   */
#define SECY_REM_LOOKUP_RULE     SECY_ID_OF(0xD4U) /**< @brief #SECY_HdlMsgType          #MACSEC_RemoveSecYLookupRule*/
#define SECY_GET_STATS           SECY_ID_OF(0xD5U) /**< @brief #SECY_StatsMsgType        #MACSEC_GetSecYStats        */
#define SECY_SET_PROTECT         SECY_ID_OF(0xD6U) /**< @brief #SECY_DebugMsgType        #MACSEC_SetProtectFrame     */
#define SECY_SET_REPLAY_PROTECT  SECY_ID_OF(0xD7U) /**< @brief #SECY_DebugMsgType        #MACSEC_SetReplayProtect    */
#define SECY_SET_VALIDATE_FRAME  SECY_ID_OF(0xD8U) /**< @brief #SECY_DebugMsgType        #MACSEC_SetFrameValidate    */
#define SECY_DELETE              SECY_ID_OF(0xDFU) /**< @brief #SECY_HdlMsgType          #MACSEC_DeleteSecY          */
#define SECY_TXSC_CREATE         SECY_ID_OF(0xE0U) /**< @brief #SECY_SCMsgType           #MACSEC_CreateTxSC          */
#define SECY_RXSC_CREATE         SECY_ID_OF(0xE1U) /**< @brief #SECY_SCMsgType           #MACSEC_CreateRxSC          */
#define SECY_TXSC_GET_STATS      SECY_ID_OF(0xE2U) /**< @brief #SECY_TxSCStatsMsgType    #MACSEC_GetTxSCStats        */
#define SECY_RXSC_GET_STATS      SECY_ID_OF(0xE3U) /**< @brief #SECY_RxSCStatsMsgType    #MACSEC_GetRxSCStats        */
#define SECY_TXSC_DEL            SECY_ID_OF(0xEEU) /**< @brief #SECY_SCMsgType           #MACSEC_DeleteTxSC          */
#define SECY_RXSC_DEL            SECY_ID_OF(0xEFU) /**< @brief #SECY_SCMsgType           #MACSEC_DeleteRxSC          */
#define SECY_TXSA_CREATE         SECY_ID_OF(0xF0U) /**< @brief #SECY_SAMsgType           #MACSEC_CreateTxSA          */
#define SECY_RXSA_CREATE         SECY_ID_OF(0xF1U) /**< @brief #SECY_SAMsgType           #MACSEC_CreateRxSA          */
#define SECY_SA_ENABLE           SECY_ID_OF(0xF2U) /**< @brief #SECY_HdlMsgType          #MACSEC_SAEnable            */
#define SECY_SA_DISABLE          SECY_ID_OF(0xF3U) /**< @brief #SECY_HdlMsgType          #MACSEC_SADisable           */
#define SECY_SA_GET_STATUS       SECY_ID_OF(0xF4U) /**< @brief #SECY_SAStatusMsgType     #MACSEC_SAGetStatus         */
#define SECY_SA_SET_PN_THRLD     SECY_ID_OF(0xF5U) /**< @brief #SECY_PNMsgType           #MACSEC_SetPNThreshold      */
#define SECY_SA_GET_NEXT_PN      SECY_ID_OF(0xF6U) /**< @brief #SECY_PNMsgType           #MACSEC_SAGetNextPN         */
#define SECY_SA_SET_NEXT_PN      SECY_ID_OF(0xF7U) /**< @brief #SECY_PNMsgType           #MACSEC_SASetNextPN         */
#define SECY_SA_GET_TX_STATS     SECY_ID_OF(0xF8U) /**< @brief #SECY_TxSAStatsMsgType    #MACSEC_GetTxSAStats        */
#define SECY_SA_DELETE           SECY_ID_OF(0xFFU) /**< @brief #SECY_HdlMsgType          #MACSEC_DeleteSA            */
/** @} */


/**
    @name CRYPTO SECY Macros
    @{
    @brief Crypto SECY Macros

    @trace #BRCM_SWREQ_SECY
**/
#define SECY_XPN_SALT_LEN    (12UL)
#define SECY_KEY_LEN         (32UL)
#define SECY_KEYID_LEN       (16UL)
#define SECY_MSG_MAX_SIZE    (128UL)
/** @} */

/**
    @brief CRYPTO configuration type

    @trace #BRCM_SWREQ_SECY
*/
typedef struct sSECY_HwCfgType {
    uint32_t    checkKaY;   /**< @brief Enable detection of KaY frame
                                (E bit = 1 and C bit = 0 in SecTAG).
                                If set to TRUE, these frames are marked as control
                                frame and shall be handled by KaY.
                                If set to FALSE, these frames will be marked as
                                invalid CRYPTO Tagged frame and will be dropped */
    uint32_t    enableQtagParse; /**< @brief Enable detection of 802.1Q tag
                                (802.1Q tag in clear) */
} SECY_HwCfgType;


/**
    @name SECY_ValidateFrameType
    @{
    @brief Ingress frame validation options.

    Frame validation options as defined in IEEE std 802.1AE-2018 section 10.6.

    Validate frame option helps in staged deployement of macsec in the network system
    Setting frame validation option to NULL also disables frame protection of the SecY.

    @trace #BRCM_SWREQ_SECY
*/
typedef uint32_t SECY_ValidateFrameType;
#define SECY_VALIDATE_FRAME_DISABLED   (0UL) /**< @brief no validation (remove SecTAG and ICV if
                                                            present in the received frame and don't
                                                            discard the frame) */
#define SECY_VALIDATE_FRAME_CHECK      (1UL) /**< @brief check (enable check but don't discard
                                                            the invalid frames) */
#define SECY_VALIDATE_FRAME_STRICT     (2UL) /**< @brief strict check (enable validation
                                                      and discard invalid frames) */
#define SECY_VALIDATE_FRAME_NULL       (3UL) /**< @brief no processing, do not remove SecTAG or
                                                            ICV from frame */
/** @} */

/**
    @name SECY_CipherType
    @{
    @brief Crypto EUI-64 cipher id
    64-bit EUI Cipher IDs as defined by the 802.1AE specification

    @trace #BRCM_SWREQ_SECY
*/
typedef uint64_t SECY_CipherType;
#define SECY_CIPHER_GCM_AES_128         (0x0080C20001000001ULL) /**< @brief GCM AES 128 bit */
#define SECY_CIPHER_GCM_AES_256         (0x0080C20001000002ULL) /**< @brief GCM AES 256 bit */
#define SECY_CIPHER_GCM_AES_XPN_128     (0x0080C20001000003ULL) /**< @brief GCM AES XPN 128 */
#define SECY_CIPHER_GCM_AES_XPN_256     (0x0080C20001000004ULL) /**< @brief GCM AES XPN 256 */
/** @} */

/**
    @name SECY_ConfOffsetType
    @{
    @brief Confidentiality offset
    Confidentiality offsets supported by the cipher suite (bit mask values)

    @trace #BRCM_SWREQ_SECY
*/
typedef uint32_t SECY_ConfOffsetType;
#define SECY_CONF_OFFSET_0             (0U)   /**< @brief confidentiality offset 0 */
#define SECY_CONF_OFFSET_30            (1U)   /**< @brief confidentiality offset 30 */
#define SECY_CONF_OFFSET_50            (2U)   /**< @brief confidentiality offset 50 */
/** @} */

/**
    @name SECY_CipherCapType
    @{
    @brief Cipher capabilites types

    @trace #BRCM_SWREQ_SECY
*/
typedef uint32_t SECY_CipherCapType;
#define SECY_CIPHER_CAP_INTEGRITY          (1UL) /**< @brief integrity protection without confidentiality */
#define SECY_CIPHER_CAP_CONFIDENTIALITY    (2UL) /**< @brief integrity with confidentiality */
#define SECY_CIPHER_CAP_CONF_OFFSET        (3UL) /**< @brief integrity with confidentiality offset */
/** @} */

/**
    @brief Control packet rule direction
    Control packet rule direction (egress/ingress)

    @trace #BRCM_SWREQ_SECY
*/
typedef uint32_t SECY_RuleDirType;
#define SECY_RULE_DIR_EGRESS       (1U)
#define SECY_RULE_DIR_INGRESS      (2U)
/** @} */

/**
    @brief SECY_CPRuleMatchType
    Control packet matching rule

    @trace #BRCM_SWREQ_SECY
*/
typedef uint32_t SECY_RuleMatchType;
#define SECY_RULE_MATCH_DA_ONLY             (1UL)   /**< @brief Match only DA value
                                                            (#CRYPTO_CPRule::macDAStart) */
#define SECY_RULE_MATCH_ETHTYPE_ONLY        (2UL)   /**< @brief match only ethtype in
                                                            (#CRYPTO_CPRule::ethType) */
#define SECY_RULE_MATCH_DA_ETHTYPE          (3UL)   /**< @brief match DA and ethtype both
                                                            (#CRYPTO_CPRule::macDAStart & ethType) */
#define SECY_RULE_MATCH_DA_RANGE_ONLY       (4UL)   /**< @brief match DA range value
                                                             (match is when macDAStart <= MAC_DA <=
                                                              macDAEnd) */
#define SECY_RULE_MATCH_DA_RANGE_ETHTYPE    (5UL)   /**< @brief match DA range and ethType
                                                            (match is when macDAStart <= MAC_DA <=
                                                            macDAEnd & ethertype) */
#define SECY_RULE_MATCH_DA_CONST            (6UL)  /**< @brief match DA const value in
                                                                MACSEC_RuleOpt0Type::macDAStart.
                                                                Match happens either on 44-bits or
                                                                48-bits of the DA.
                                                                For 44-bits match: macDAStart[47:8] and
                                                                macDAStart[7:4] are matched
                                                                For 48-bits: macDAStart[47:0] are matched */
/** @} */

/**
    @brief SCI type
    CRYPTO Secure channel identifier consist of 6-bytes of the
    source mac address and 16-bit of port identifier.

    @trace #BRCM_SWREQ_SECY
*/
typedef struct sSECY_SCIType {
    uint8_t macAddr[6UL];
    uint16_t portNum;
} SECY_SCIType;


/**
    @brief CRYPTO key type

    @trace #BRCM_SWREQ_SECY
*/
typedef struct sSECY_KeyType {
    uint8_t         sak[SECY_KEY_LEN];        /**< @brief CRYPTO key buffer */
    uint8_t         salt[SECY_XPN_SALT_LEN];  /**< @brief Salt for XPN key */
    uint8_t         keyId[SECY_KEYID_LEN];    /**< @brief key identified as defined by 802.1X */
} SECY_KeyType;

/**
    @brief CRYPTO control packet rule type
    This structure defines the control packet rule.
    Based on the ruleMask (#CRYPTO_CPRuleMatchType), respective fields
    of this structures are matched to classify a packet as control packet.
    When a packet is classified as control packet, it will bypass the encryption/decryption
    engine.

    @trace #BRCM_SWREQ_SECY
*/
typedef struct sSECY_RuleOpt0Type {
    SECY_RuleMatchType    ruleMask;       /**< @brief rule match mask */
    uint8_t                     macDAStart[6U]; /**< @brief MAC DA to start to match */
    uint8_t                     macDAEnd[6U];   /**< @brief MAC DA end to match */
    SECY_RuleDirType      dir;            /**< @brief direction in which rule shall be applied */
    uint16_t                    ethType;        /**< @brief Ethertype to match */
    uint8_t                     rsvd[2U];
} SECY_RuleOpt0Type;

/**
    @brief MACSec rule option 1 type

    This structure defines the rule for the packet classification.
    Lookup rule consist of key, data and corresponding key mask and data masks.
    Mask fields can be used to mask out the bits which doesn't need to be compared in the
    key/data fields. For example, if matchMacDAMask is set to {0xFF, 0xFF, 0, 0, 0, 0}, then
    macDA[0] and macDA[1] fields are usedfor comparison.

    frameData field shall be in little-endian byte order; consider the below frame:
    data = {
    0x84, 0xC5, 0xD5, 0x13, 0xD2, 0xAA,
    0xF6, 0xE5, 0xBB, 0xD2, 0x72, 0x77,
    0x08, 0x00, 0x0F, 0x10, 0x11, 0x12 ... }

    To match only first 32-bit of data:
    frameData[0] = data[12] | data[13] << 8 | data[14] << 16 | data[15] << 24
    matchFrameDataMask[0] = 0xFFFFFFFF

    To match next 24-bit of data also:
    frameData[1] = data[16] | data[17] << 8 | data[18) << 16
    matchFrameDataMask[1] = 0xFFFFFF

    if macSecTagged is set to TRUE, engine will check if the packet has SecTag (along with other
    rule parameters). Note that setting this to TRUE during the control frame rule addition
    will cause MACSec tagged frame to bypass the encryption/decryption (and its not recommended!!).
    This flag can be set to TRUE during SecY lookup rule addition.

    if vlanTagged is set to TRUE, packets will be checked if they are vlan tagged (for this
    feature to work, Vlan tag parsing must be enabled in the hardware:
    MACSEC_CfgType::enableQTagParse shall be set to TRUE).

    @trace #BRCM_SWREQ_SECY
*/
typedef struct sSECY_RuleOpt1Type {
    uint8_t                 macDA[6U];          /**< @brief MAC DA to match (Only bits which are set
                                                    in matchDAMask are matched) */
    uint8_t                 macSA[6U];          /**< @brief MAC SA to match (only bits which are set
                                                    in matchSAMask are matched) */
    uint32_t                frameData[2U];      /**< @brief frame data after SA to match (only 56
                                                    bits out of 64-bit are compared:
                                                    frameData[31:0], followed by frameData[23:0].
                                                    Only bits which are set in the
                                                    matchFrameDataMask are matched) */
    uint32_t                macSecTagged;       /**< @brief TRUE: check SecTAG detection */
    uint32_t                vlanTagged;         /**< @brief TRUE: detect 802.1Q tagged packet  */
    uint8_t                 matchMacDAMask[6U]; /**< @brief MAC DA mask bits */
    uint8_t                 matchMacSAMask[6U]; /**< @brief MAC SA mask bits */
    uint32_t                matchFrameDataMask[2U]; /**< @brief Frame data mask bits */
    SECY_RuleDirType  dir;                    /**< @brief Rule direction */
} SECY_RuleOpt1Type;


/**
    @brief SecY configuration
    This structure defines the SecY configuration.

    @trace #BRCM_SWREQ_SECY
*/
typedef struct sSECY_CfgType {
    uint32_t        xpnEnable;          /**< @brief TRUE: Enable XPN support for this SecY */
    uint32_t        includeSCI;         /**< @brief TRUE: include explicit SCI in transmit frames */
    uint8_t         preSecTagAuthStart; /**< @brief Pre-SecTAG Authentication Start.
                                                    Specifies number of bytes from the start of
                                                    the frame to be bypassed without
                                                    CRYPTO protection. */
    uint8_t         preSecTagAuthLen; /**< @brief Pre-SecTAG Authentication Length.
                                                  Specifies number of bytes to be authenticated in
                                                  the pre-SecTAG area. For 802.1AE compliance,
                                                  this value must be set to 12 Bytes, representing
                                                  the length of the MAC SA/DA fields. */
    uint8_t         secTagOffset;     /**< @brief Offset of the SecTAG (location relative to start
                                                  of the frame). For normal operations, this shall be
                                                  set to 12. In case of VLAN in clear (802.1Q tag
                                                  in clear text, this field shall be programmed with
                                                  16 (6 bytes MAC DA + 6 bytes MAC SA + 4 bytes for
                                                  802.1Q tag)) */
    uint8_t         rsvd;
} SECY_CfgType;


/**
    @brief  SA status type

    SA status type

    @trace #BRCM_SWREQ_SECY
*/
typedef struct sSECY_SAStatusType {
    uint32_t        inUse;              /**< @brief true: SA is use, false: SA not in use */
    uint32_t        ssci;               /**< @brief SSCI value for this SA */
    uint32_t        createdTime;        /**< @brief Time when this SA was created */
    uint32_t        startedTime;        /**< @brief Time when this SA became active */
    uint32_t        stoppedTime;        /**< @brief Time when this SA was stopped */
    uint8_t         keyID[16UL];        /**< @brief SA Key identifier */
} SECY_SAStatusType;

/**
    @brief SECY_TxSCStatsType

    Transmit Secure channel statistics type

    @trace #BRCM_SWREQ_SECY
*/
typedef struct sSECY_TxSCStatsType {
    uint64_t outPktsProtected;      /**< @brief number of packets protected */
    uint64_t outPktsEncrypted;      /**< @brief number of packets encrypted */
    uint64_t outOctectsProtected;   /**< @brief octets protected */
    uint64_t outOctectsEncrypted;   /**< @brief octets encrypted */
} SECY_TxSCStatsType;

/**
    @brief SECY_TxSAStatsType

    Transmit SA statistics type

    @trace #BRCM_SWREQ_SECY
*/
typedef struct sSECY_TxSAStatsType {
    uint64_t outPktsProtected;      /**< @brief number of packets protected */
    uint64_t outPktsEncrypted;      /**< @brief number of packets encrypted */
} SECY_TxSAStatsType;

/**
    @brief SECY_RxSCStatsType

    Receive secure channel statistics

    @trace #BRCM_SWREQ_SECY
*/
typedef struct sSECY_RxSCStatsType {
    uint64_t inPktsLate;           /**< @brief replayProtect is enabled and recv_frame(pn) <
                                               sa->nextPN */
    uint64_t inPktsNotValid;       /**< @brief recv frame is not valid and validateFrames is Strict
                                               or C-bit is set in SecTAG */
    uint64_t inPktsInvalid;        /**< @brief recv frame is not valid and validaFrame is Check */
    uint64_t inPktsDelayed;        /**< @brief recv_frame(pn) < sa->nextPn */
    uint64_t inPktsUnchecked;      /**< @brief recv frame is not valid and
                                               validateFrame == Disabled */
    uint64_t inPktsOK;             /**< @brief packet is valid and recv_frame(pn) > sa->nextPN */
} SECY_RxSCStatsType;

/**
    @brief SecY statistics

    Statistics counters for SecY entity

    @trace #BRCM_SWREQ_SECY
*/
typedef struct sSECY_StatsType {
    uint64_t OutPktsUntagged;      /**< @brief number of packet which are not protected
                                               (protectFrames == False) */
    uint64_t OutPktsTooLong;       /**< @brief number of protected frames (protectFrame == True) whose
                                               length if more than maximum allowed frame length on
                                               interface */
    uint64_t InPktsUntagged;       /**< @brief received frame has no SecTAG and
                                               (validateFrame != Strict) */
    uint64_t InPktsNoTag;          /**< @brief received frame has no SecTAG and
                                               (validateFrame == Strict) */
    uint64_t InPktsBadTag;         /**< @brief received frame has invalid tag or invalid ICV */
    uint64_t InPktsOverrun;        /**< @brief received frame queued for validation but exceeds
                                               selected cipher suite capabilities */
    uint64_t InPktsNoSA;           /**< @brief no active SA is found for this frame and
                                               (validateFrame != Strict) */
    uint64_t InPktsNoSAError;      /**< @brief no active SA is found for this frame and
                                               (validateFrame == Strict) or C-bit == 1 in SecTAG */
    uint64_t OutOctetsProtected;   /**< @brief number of octets of user data in tx frame which were
                                               integrity protected but not encrypted */
    uint64_t OutsOctetsEncrypted;   /**< @brief number of octets of user data in tx frame which were
                                               integrity protected and encrypted */
    uint64_t InOctetsValidated;     /**< @brief Number of octets of User Data recovered from
                                                received frames that were integrity protected but
                                                not encrypted */
    uint64_t InOctetsEncrypted;     /**< @brief Number of octets of User Data recovered from
                                                received frames that were both integrity protected
                                                and encrypted both */
} SECY_StatsType;


/**
    @brief SecY HW Init Message

    @trace #BRCM_SWREQ_SECY
*/
typedef struct sSECY_HwInitMsgType {
    uint32_t                   port;           /**< @brief Input: Port Number      */
    SECY_HwCfgType             cfg;            /**< #brief Input: Configuration    */
} SECY_HwInitMsgType;
_Static_assert(SECY_MSG_MAX_SIZE >= sizeof(SECY_HwInitMsgType),
    "Ease of debug will be broken if the size is not properly aligned");

/**
    @brief SecY HW Deinit Message

    @trace #BRCM_SWREQ_SECY
*/
typedef struct sSECY_HwDeinitMsgType {
    uint32_t        port;                   /**< @brief Input: Port Number      */
} SECY_HwDeinitMsgType;
_Static_assert(SECY_MSG_MAX_SIZE >= sizeof(SECY_HwDeinitMsgType),
    "Ease of debug will be broken if the size is not properly aligned");

/**
    @brief SecY Rule Option 0 Message

    @trace #BRCM_SWREQ_SECY
*/
typedef struct sSECY_RuleOpt0MsgType {
    uint32_t                    port;               /**< @brief Input: Port Number      */
    SECY_RuleOpt0Type           rule;               /**< @brief Input: Filtering Rule   */
    uint32_t                    rsvd1;
    BCM_HandleType              ruleHdl;            /**< @brief Output: Rule Handle     */
} SECY_RuleOpt0MsgType;
_Static_assert(SECY_MSG_MAX_SIZE >= sizeof(SECY_RuleOpt0MsgType),
    "Ease of debug will be broken if the size is not properly aligned");

/**
    @brief SecY Rule Option 1 Message

    @trace #BRCM_SWREQ_SECY
*/
typedef struct sSECY_RuleOpt1MsgType {
    uint32_t                    port;       /**< @brief Input: Port Number      */
    SECY_RuleOpt1Type           rule;       /**< @brief Input: Filtering Rule      */
    BCM_HandleType              ruleHdl;    /**< @brief Output: Rule Handle      */
} SECY_RuleOpt1MsgType;
_Static_assert(SECY_MSG_MAX_SIZE >= sizeof(SECY_RuleOpt1MsgType),
    "Ease of debug will be broken if the size is not properly aligned");

/**
    @brief SecY Create Message

    @trace #BRCM_SWREQ_SECY
*/
typedef struct sSECY_CreateMsgType {
    uint32_t            port;           /**< @brief Input: Port Number      */
    SECY_CfgType        cfg;            /**< @brief Input: SecY Config      */
    BCM_HandleType      secYHdl;        /**< @brief Output: SecY Handle      */
} SECY_CreateMsgType;
_Static_assert(SECY_MSG_MAX_SIZE >= sizeof(SECY_CreateMsgType),
    "Ease of debug will be broken if the size is not properly aligned");

/**
    @brief SecY Get Cipher Message

    @trace #BRCM_SWREQ_SECY
*/
typedef struct sSECY_GetCipherMsgType {
    uint32_t                    port;       /**< @brief Input: Port Number      */
    SECY_CipherCapType          cap;        /**< @brief Output: Cipher Cap      */
    SECY_CipherType             cipher;     /**< @brief Input: Cipher Type      */
} SECY_GetCipherMsgType;
_Static_assert(SECY_MSG_MAX_SIZE >= sizeof(SECY_GetCipherMsgType),
    "Ease of debug will be broken if the size is not properly aligned");

/**
    @brief SecY Set Cipher Message

    @trace #BRCM_SWREQ_SECY
*/
typedef struct sSECY_SetCipherMsgType {
    BCM_HandleType              secYHdl;    /**< @brief Input: SecY Handle      */
    SECY_CipherType             cipher;     /**< @brief Input: Cipher Type      */
    SECY_ConfOffsetType         offset;     /**< @brief Input: Confidentiality Offset   */

} SECY_SetCipherMsgType;
_Static_assert(SECY_MSG_MAX_SIZE >= sizeof(SECY_SetCipherMsgType),
    "Ease of debug will be broken if the size is not properly aligned");


/**
    @brief SecY Create/Delete SC Message

    @trace #BRCM_SWREQ_SECY
*/
typedef struct sSECY_SCMsgType {
    BCM_HandleType          secYHdl;        /**< @brief Input: SecY Handle      */
    SECY_SCIType            sci;            /**< @brief Input: SCI              */
} SECY_SCMsgType;
_Static_assert(SECY_MSG_MAX_SIZE >= sizeof(SECY_SCMsgType),
    "Ease of debug will be broken if the size is not properly aligned");

/**
    @brief SecY Lookup Rule Message

    @trace #BRCM_SWREQ_SECY
*/
typedef struct sSECY_LookupRuleMsgType {
    BCM_HandleType              secYHdl;    /**< @brief Input: SecY Handle      */
    SECY_RuleOpt1Type           rule;       /**< @brief Input: Filtering Rule   */
    BCM_HandleType              ruleHdl;    /**< @brief Output: Rule Handle      */
} SECY_LookupRuleMsgType;
_Static_assert(SECY_MSG_MAX_SIZE >= sizeof(SECY_LookupRuleMsgType),
    "Ease of debug will be broken if the size is not properly aligned");

/**
    @brief SecY Create SA Message

    @trace #BRCM_SWREQ_SECY
*/
typedef struct sSECY_SAMsgType {
    BCM_HandleType          secYHdl;        /**< @brief Input: SecY Handle      */
    uint64_t                pn;             /**< @brief Input: next PN for TxSA and lowest PN for RxSA */
    uint32_t                association;    /**< @brief Input: Association Number*/
    uint32_t                ssci;           /**< @brief Input: SSCI             */
    uint32_t                confidentiality;/**< @brief  Not used in Rx SA creation         */
    SECY_SCIType            sci;            /**< @brief Input: SCI              */
    SECY_KeyType            sak;            /**< @brief Input: SA Key           */
    BCM_HandleType          saHdl;          /**< @brief Output: SA Handle       */
} SECY_SAMsgType;
_Static_assert(SECY_MSG_MAX_SIZE >= sizeof(SECY_SAMsgType),
    "Ease of debug will be broken if the size is not properly aligned");


/**
    @brief SecY PN Set/Get/Threshold Message

    @trace #BRCM_SWREQ_SECY
*/
typedef struct sSECY_PNMsgType {
    BCM_HandleType  saHdl;  /**< @brief Input: SA Handle      */
    uint64_t        pn;     /**< @brief Input: PN Threshold for #SECY_SA_SET_PN_THRLD
                                    <br>Input: Next PN for #SECY_SA_SET_NEXT_PN
                                    <br>Output: Next PN for #SECY_SA_GET_NEXT_PN  */
} SECY_PNMsgType;
_Static_assert(SECY_MSG_MAX_SIZE >= sizeof(SECY_PNMsgType),
    "Ease of debug will be broken if the size is not properly aligned");

/**
    @brief SecY Message for
        -# Enable/Disabe SA
        -# Delete SA
        -# Delete CP Rule
        -# Delete Lookup Rule

    @trace #BRCM_SWREQ_SECY
*/
typedef struct sSECY_HdlMsgType {
    uint32_t            port;       /**< @brief Input: port number needed only for CP Rule removal  */
    uint32_t            rsvd1;
    BCM_HandleType      hdl;        /**< @brief Input: SA/Rule Handle      */
} SECY_HdlMsgType;
_Static_assert(SECY_MSG_MAX_SIZE >= sizeof(SECY_HdlMsgType),
    "Ease of debug will be broken if the size is not properly aligned");

/**
    @brief SecY Debug Message (for protect/replay protect/validate)

    @trace #BRCM_SWREQ_SECY
*/
typedef struct sSECY_DebugMsgType {
    BCM_HandleType                  secYHdl;            /**< @brief Input: SecY Handle      */
    uint32_t                        protectEnable;      /**< @brief Input: used only for #SECY_SET_PROTECT    */
    uint32_t                        replayProtectEnable;/**< @brief Input: used only for #SECY_SET_REPLAY_PROTECT    */
    uint32_t                        replayProtectWindow;/**< @brief Input: used only for #SECY_SET_REPLAY_PROTECT    */
    SECY_ValidateFrameType          validate;           /**< @brief Input: used only for #SECY_SET_VALIDATE_FRAME    */
} SECY_DebugMsgType;
_Static_assert(SECY_MSG_MAX_SIZE >= sizeof(SECY_DebugMsgType),
    "Ease of debug will be broken if the size is not properly aligned");

/**
    @brief SecY SA status query message

    @trace #BRCM_SWREQ_SECY
*/
typedef struct sSECY_SAStatusMsgType {
    BCM_HandleType          saHdl;  /**< @brief Input: SA Handle        */
    SECY_SAStatusType       status; /**< @brief Output: SA Status       */
} SECY_SAStatusMsgType;
_Static_assert(SECY_MSG_MAX_SIZE >= sizeof(SECY_SAStatusMsgType),
    "Ease of debug will be broken if the size is not properly aligned");


/**
    @brief SecY Stats query message

    @trace #BRCM_SWREQ_SECY
*/
typedef struct sSECY_StatsMsgType {
    BCM_HandleType          secYHdl;    /**< @brief Input: SecY Handle      */
    SECY_StatsType          stats;      /**< @brief Output: SecY Stats      */
} SECY_StatsMsgType;
_Static_assert(SECY_MSG_MAX_SIZE >= sizeof(SECY_StatsMsgType),
    "Ease of debug will be broken if the size is not properly aligned");

/**
    @brief SecY Tx SC Stats query message

    @trace #BRCM_SWREQ_SECY
*/
typedef struct sSECY_TxSCStatsMsgType {
    BCM_HandleType              secYHdl;    /**< @brief Input: SecY Handle      */
    SECY_SCIType                sci;        /**< @brief Input: SCI              */
    SECY_TxSCStatsType          stats;      /**< @brief Output: SCI Stats       */
} SECY_TxSCStatsMsgType;
_Static_assert(SECY_MSG_MAX_SIZE >= sizeof(SECY_TxSCStatsMsgType),
    "Ease of debug will be broken if the size is not properly aligned");

/**
    @brief SecY Rx SC Stats query message

    @trace #BRCM_SWREQ_SECY
*/
typedef struct sSECY_RxSCStatsMsgType {
    BCM_HandleType              secYHdl;    /**< @brief Input: SecY Handle      */
    SECY_SCIType                sci;        /**< @brief Input: SCI              */
    SECY_RxSCStatsType          stats;      /**< @brief Output: SCI Stats       */
} SECY_RxSCStatsMsgType;
_Static_assert(SECY_MSG_MAX_SIZE >= sizeof(SECY_RxSCStatsMsgType),
    "Ease of debug will be broken if the size is not properly aligned");

/**
    @brief SecY Tx SA Stats query message

    @trace #BRCM_SWREQ_SECY
*/
typedef struct sSECY_TxSAStatsMsgType {
    BCM_HandleType              saHdl;  /**< @brief Input: SA Handle        */
    SECY_TxSAStatsType          stats;  /**< @brief Output: SA Stats        */
} SECY_TxSAStatsMsgType;
_Static_assert(SECY_MSG_MAX_SIZE >= sizeof(SECY_TxSAStatsMsgType),
    "Ease of debug will be broken if the size is not properly aligned");



/**
    @brief SecY Union encapsulating all messages

    @trace #BRCM_SWREQ_SECY
*/
typedef union uSECY_MsgUnionType {
    uint32_t                        data[SECY_MSG_MAX_SIZE/4UL];
    SECY_HwInitMsgType        hwInit;
    SECY_RuleOpt0MsgType      ruleOpt0;
    SECY_RuleOpt1MsgType      ruleOpt1;
    SECY_GetCipherMsgType     getCipher;
    SECY_HwDeinitMsgType      hwDeinit;
    SECY_CreateMsgType        secYCreate;
    SECY_SetCipherMsgType     setCipher;
    SECY_StatsMsgType         stats;
    SECY_HdlMsgType           hdl;
    SECY_SCMsgType            sc;
    SECY_LookupRuleMsgType    scLookup;
    SECY_TxSCStatsMsgType     txScStats;
    SECY_RxSCStatsMsgType     rxScStats;
    SECY_SAMsgType            sa;
    SECY_PNMsgType            pn;
    SECY_DebugMsgType         debug;
    SECY_SAStatusMsgType      saStatus;
    SECY_TxSAStatsMsgType     saStats;
} SECY_MsgUnionType;

/**
    @brief Verity Union encapsulating all messages

    @trace #BRCM_SWREQ_SECY
*/
typedef struct sSECY_MsgType {
    uint32_t                    magic;
    BCM_CmdType                 id;
    int32_t                     status;
    uint32_t                    len;
    SECY_MsgUnionType           u;
} SECY_MsgType;

/**
    @brief SECY Helper for Host Communication

    @trace #BRCM_SWREQ_SECY
 */
extern const MODULE_MsgConverterType SECY_HostHelper;

/** @brief Send commands to Crypto SecY module

    This API queues the SecY commands to crypto SecY module

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aCmd                Command ID
    @param[in]      aLen                Length of the management command message
    @param[in]      aCmdData            Management command information
    @param[in]      aHandle             Pointer to BCM_HandleType for later query
                                        using #BCM_ModGetStatusType
    @param[out]     aForwardToSlaves    Is this message needed to be forwarded
                                        to slaves

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK     Command posted successfully

    @post None

    @trace #BRCM_SWREQ_SECY
*/
int32_t SECY_SendCmd(BCM_CmdType aCmd, uint32_t aLen, const uint8_t *aCmdData,
                                        BCM_HandleType *aHandle, uint32_t *aForwardToSlaves);

/** @brief Retreive status of crypto SecY commands

    This API queries the status of completed crypto SecY commands which were
    previously issued

    @behavior Sync, Re-entrant

    @pre None

    @param[in]   aHandle                BCM Handle to retrieve response
    @param[in]   aReplyID               Reply ID (group, comp, cmd)
    @param[in]   aInLen                 Available Length of the reply data payload in bytes
    @param[out]  aReplyData             Pointer to the reply data payload
    @param[out]  aReplyDataLen          Actual Length of the reply data payload in bytes

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK     Command status retrieved successfully

    @post None

    @trace #BRCM_SWREQ_SECY
*/
int32_t SECY_GetResp(BCM_HandleType aHandle, BCM_CmdType aReplyID, uint32_t aInLen,
                                     uint8_t *aReplyData, uint32_t *aReplyDataLen);


/**
    @brief Crypto SecY Host Context Type

    -# state is expected to be set to UNINT by caller before initiating any
        Setup first time. Later setup calls will expect state to be either UNINIT
        or READY (which happens after processing is complete
    -# subState is used for internal consumption and must not be altered by caller
    -# status contains the result of operation after completion of processing
    -# msg contains any output that is returned for future referencing

    @trace #BRCM_SWREQ_SECY
*/
typedef struct sSECY_HostContextType {
    BCM_StateType               state;      /**< @brief Context State           */
    BCM_SubStateType            subState;   /**< @brief Context Sub State       */
    BCM_CmdType                 id;         /**< !brief Command/Response ID     */
    int32_t                     status;     /**< @brief final status of command */
    SECY_MsgUnionType           msg;        /**< @brief Message input/output    */
} SECY_HostContextType;

/**
    @brief Setup SecY Host context

    @behavior Sync, Non-Rentrant

    @pre None

    @param[inout]   aContext        Context to be setup
    @param[in]      aSecYID         Command/Message Type
    @param[in]      aMsgPayload     Command/Message payload

    Return values are documented in reverse-chronological order
    @retval     BCM_ERR_OK              Setup for initialization complete
    @retval     BCM_ERR_INVAL_PARAMS    aContext is NULL or aInitMsg is NULL

    @post aContext.state is changes to RUNNING.

    @trace #BRCM_SWREQ_SECY

    @limitations None
*/
int32_t SECY_HostContextSetup(SECY_HostContextType *aContext, SECY_IdType aSecYID,
                                    const SECY_MsgUnionType *aMsgPayload);

/**
    @brief Process SecY Host context

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
    at @ref SECY_IdType, and any output will be reflected in the structure represented
    at @ref SECY_IdType.

    @trace #BRCM_SWREQ_SECY

    @limitations None
*/
int32_t SECY_HostContextProcess(SECY_HostContextType *aContext, int32_t aResponse,
                                        BCM_CmdType aInMsgID, const uint8_t *aInMsgPayload,
                                        BCM_CmdType *aOutMsgId, uint8_t *aOutMsgPayload);

#endif /* SECY_H */

/** @} */

