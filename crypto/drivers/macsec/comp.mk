#
# Copyright 2017-2021 Broadcom Limited.  All rights reserved.
#
# This program is the proprietary software of Broadcom Limited and/or its
# licensors, and may only be used, duplicated, modified or distributed pursuant
# to the terms and conditions of a separate, written license agreement executed
# between you and Broadcom (an "Authorized License").
#
# Except as set forth in an Authorized License, Broadcom grants no license
# (express or implied), right to use, or waiver of any kind with respect to the
# Software, and Broadcom expressly reserves all rights in and to the Software
# and all intellectual property rights therein.  IF YOU HAVE NO AUTHORIZED
# LICENSE, THEN YOU HAVE NO RIGHT TO USE THIS SOFTWARE IN ANY WAY, AND SHOULD
# IMMEDIATELY NOTIFY BROADCOM AND DISCONTINUE ALL USE OF THE SOFTWARE.
#
#  Except as expressly set forth in the Authorized License,
# 1. This program, including its structure, sequence and organization,
#    constitutes the valuable trade secrets of Broadcom, and you shall use all
#    reasonable efforts to protect the confidentiality thereof, and to use this
#    information only in connection with your use of Broadcom integrated
#    circuit products.
#
# 2. TO THE MAXIMUM EXTENT PERMITTED BY LAW, THE SOFTWARE IS PROVIDED "AS IS"
#    AND WITH ALL FAULTS AND BROADCOM MAKES NO PROMISES, REPRESENTATIONS OR
#    WARRANTIES, EITHER EXPRESS, IMPLIED, STATUTORY, OR OTHERWISE, WITH RESPECT
#    TO THE SOFTWARE.  BROADCOM SPECIFICALLY DISCLAIMS ANY AND ALL IMPLIED
#    WARRANTIES OF TITLE, MERCHANTABILITY, NONINFRINGEMENT, FITNESS FOR A
#    PARTICULAR PURPOSE, LACK OF VIRUSES, ACCURACY OR COMPLETENESS,
#    QUIET ENJOYMENT, QUIET POSSESSION OR CORRESPONDENCE TO DESCRIPTION.
#    YOU ASSUME THE ENTIRE RISK ARISING OUT OF USE OR PERFORMANCE OF THE
#    SOFTWARE.
#
# 3. TO THE MAXIMUM EXTENT PERMITTED BY LAW, IN NO EVENT SHALL BROADCOM OR ITS
#    LICENSORS BE LIABLE FOR (i) CONSEQUENTIAL, INCIDENTAL, SPECIAL, INDIRECT,
#    OR EXEMPLARY DAMAGES WHATSOEVER ARISING OUT OF OR IN ANY WAY RELATING TO
#    YOUR USE OF OR INABILITY TO USE THE SOFTWARE EVEN IF BROADCOM HAS BEEN
#    ADVISED OF THE POSSIBILITY OF SUCH DAMAGES; OR (ii) ANY AMOUNT IN EXCESS
#    OF THE AMOUNT ACTUALLY PAID FOR THE SOFTWARE ITSELF OR U.S. $1, WHICHEVER
#    IS GREATER. THESE LIMITATIONS SHALL APPLY NOTWITHSTANDING ANY FAILURE OF
#    ESSENTIAL PURPOSE OF ANY LIMITED REMEDY.
####################################################################################

##  @defgroup grp_macsecdrv MACSec driver
#   @ingroup grp_crypto
#
#   @addtogroup grp_macsecdrv
#   @{
#    @section sec_macsec_overview Overview
#    MACSec protocol is defined in IEEE 802.1AE specification, which provides secure communication
#    between trusted components in the network. When MACSec is enabled, a bi-directional secure
#    link is established after the exchange and verification of the security keys between the
#    connected devices. Once the trust is established, integrity and data encryption is used to
#    safe-guard the transmitted data over the wire. We must note that MACsec cannot protect against
#    attacks facilitated by the trusted components themselves.
#
#    MACSec driver provides the basic functionality of the SecY operations. From interface
#    perspective, driver APIs can be clubbed into these groups:
#        -# Initialization of the MACSec driver and hardware (#MACSEC_Init).
#        -# SecY Management:
#            -# Creating a SecY entity(#MACSEC_CreateSecY).
#            -# Creating a rule on the hardware to map specific traffic to specific
#               SecY entity (#MACSEC_AddSecYLookupRule).
#            -# Getting the underlying supported cipher suites and its capabilities and choosing
#				one of the them to use it for the given SecY.
#            -# Creating transmit/receive secure channel for a SecY (#MACSEC_CreateTxSC,
#               #MACSEC_CreateRxSC)
#            -# Creating transmit/receive secure associations (#MACSEC_CreateTxSA,
#                #MACSEC_CreateRxSA).
#            -# Enabling of the Transmit and receive SAs (#MACSEC_SAEnable).
#            -# Disabling the transmit and receive SAs (#MACSEC_SADisable).
#            -# Get next packet number information for transmit and receive SA
#				(#MACSEC_SAGetNextPN).
#            -# Set nextPN value for the receive SA (#MACSEC_SASetNextPN).
#            -# Get transmit and receive secure channel and secure associations statistics.
#            -# Get SecY statistics counters.
#            -# Delete SAs (#MACSEC_DeleteSA).
#            -# Delete Secure channels (#MACSEC_DeleteTxSC, #MACSEC_DeleteRxSC).
#            -# Delete SecY Lookup rule (#MACSEC_RemoveSecYLookupRule).
#            -# Delete SecY entity(#MACSEC_DeleteSecY).
#        -# APIs to add rules for the packets which need to bypass the encryption/decryption.
#           These packets are classified as control packet in the driver
#           (refer #MACSEC_AddCPRuleOpt0, #MACSEC_AddCPRuleOpt1).
#        -# De-Initialization of the MACSec driver and hardware (#MACSEC_DeInit)
#
#    @section sec_macsec_init MACSEC block initialization
#    Each hardware port has a MACSec engine which is intialized by calling #MACSEC_Init API.
#    After the successfull initialization of the MACSec, all the frames, except KaY tagged frame
#    (frame with E-bit set to 1 and C-bit set to 0 and @c MACSEC_CfgType::checkKaY set to TRUE) are
#    dropped until:
#        -# A secure association is established (Creation of SecY, followed by creation of transmit
#           and receive channel and then creation of secure association).
#        -# A control packet rule is added by calling #MACSEC_AddCPRuleOpt0 or
#			#MACSEC_AddCPRuleOpt1.
#
#    @section sec_macsec_cp Control packets
#    Control packets are defined as packets which will bypass encryption/decryption (not mapped to
#    any secure channel). There are two types of control packet rules:
#        -# Rule based on MAC DA and ethtype (#MACSEC_RuleOpt0Type): These rules matches MAC DA or
#           EthType in the frame and mark them as control frame. MAC DA could be a exact match,
#           range or const value. These rules are added by calling #MACSEC_AddCPRuleOpt0 API.
#			Rules can be added seperately for ingress and egress direction.
#        -# Rule based on MAC DA, MAC SA and frame data (#MACSEC_RuleOpt1Type): These rules matches
#           MAC DA, MAC SA and next 56-bits of frame data after SA. Match is based on the mask
#           values which means any bits of the MAC DA, MAC SA or frame data can be selected for
#           matching.These rules are added by calling #MACSEC_AddCPRuleOpt1 API. Rules can be
#           added seperately for ingress and egress direction.
#
#    Multiple control packet rules can be added on a given port (limited by underlying
#    hardware resource. Refer to TRM for the details about how many rules are allowed).
#
#    A Rule can be deleted at time by calling #MACSEC_RemoveCPRule API.
#
#    @section sec_macsec_secy_mgmt SecY Management
#    As defined by 802.1AE specification, a SecY entity provides one instance of secure service to
#    its users.There may be zero, one or more SecY instances on one physical port (a physical port
#    is defined by #MACSEC_HwIDType in this interface specification).
#    A SecY contains single transmit secure channel and may contain zero, one or more receive secure
#    channels (maximum number of secure receive channels that can be created for a SecY is
#    statically configured in system using MACSEC_MAX_RXSC_PER_SECY compiler macro).
#
#    In case where more than one SecY instances are required on the same physical port, each SecY
#    will represent a virtual port (maximum number of SecY instances which can be created on a
#    physical port is statically configured in system using MACSEC_MAX_SECY_PER_PORT
#    compiler macro).
#
#    <b>SecY</b>
#
#    A SecY instance is created by calling #MACSEC_CreateSecY API which returns a unique handle to
#    be used later for creation of secure channels and secure associations for the SecY.
#
#    User need to add a rule to map a specific traffic to a SecY instance by calling
#    #MACSEC_AddSecYLookupRule API. Rule can be added seperately for transmit traffic
#    and receive traffic.
#
#    When SecY is created:
#        -# replay protection is enabled bydefault with window size 0 (strict ordering).
#        -# frame protection is enabled bydefault.
#        -# frame validation is set to Strict mode.
#
#    SecY can be deleted by calling #MACSEC_DeleteSecY API (user must ensure that transmit and
#    receive channels and correspoding Secure associations are deleted by deleting SecY).
#
#    <b>Secure channels</b>
#
#    An SC represents a security relationship between members of a Secure Connectivity
#    Association(CA).
#    Each SC is supported by the sequence of secure associations (SAs), which allows refreshing the
#    keys without terminating the SC. Each SC has maximum four active SAs (0, 1, 2,3).
#
#    After the secy instance is created, a tranmit secure channel can be created by calling
#    #MACSEC_CreateTxSC API. <i>Only single transmit secure channel can be created for a SecY</i>.
#    Transmit secure channel can be deleted by calling #MACSEC_DeleteTxSC (user must ensure that
#    all the transmit SAs are deleted before deleting transmit secure channel).
#
#    A receive secure channel for each peer in CA can be created by calling #MACSEC_CreateRxSC API.
#    Multiple receive secure channels can be created for a SecY.
#    A receive SC can be deleted by calling #MACSEC_DeleteRxSC API (user must ensure that all the
#    receive SAs associated with this secure channels are deleted).
#
#    <b> Secure associations (SAs)</b>
#
#    SA is a security relationship that provides security guarantees for frames transmitted
#    from one member of a Connectivity Association (CA) to the others. Each SA is has a secret
#    key for frame protection and validation.
#
#    Transmit SA is created by calling #MACSEC_CreateTxSA API and Receive SA is created by calling
#    #MACSEC_CreateRxSA API. SA creation takes association number (AN) and key information as input
#    and creates a cryprographic record in the hardware and returns handle.
#    When SA is created, by default its not enabled (inUse flag is set to FALSE and SA can not be
#    used for frame protection or validation).  SA can be activated by calling
#    #MACSEC_SAEnable API.
#
#    When a transmit SA is activated, it switches the transmission from previous transmit SA to the
#    current SA (if this SA is first SA, it just becomes active for transmission) without
#    interrupting the traffic and inUse flag is set to TRUE.
#    when #MACSEC_SAEnable is called for receive SA, it becomes active (inUse flag set to TRUE) and
#    frames received with this AN, can be decrypted and validated by this SA.
#
#    An SA can be disabled at point of time by calling #MACSEC_SADisable API, which de-activates
#	 the SA and set inUse flag to FALSE.
#    Status of the SA can be checked by calling #MACSEC_SAGetStatus API.
#    SA can be deleted by calling #MACSEC_DeleteSA API.
#
#    @section sec_macsec_vlan_in_clr VLAN in clear in MACSec frame
#    Driver can be configured to allow 802.1Q tagged packet (ethType = 0x8100) to be clear text
#    (After SA and before SecTAG) in MACSec frame. To configure VLAN in clear:
#        -# Enable detection of VLAN tagged packet in frame (set @c MACSEC_CfgType::enableQtagParse
#           to TRUE during initialization of MACSec block).
#        -# SecY Configuration:
#            -# Set @c MACSEC_SecYCfgType::preSecTagAuthStart to 0.
#            -# Set @c MACSEC_SecYCfgType::preSecTagAuthLen to 12 (VLAN tag in not authenticated).
#            -# Set @c MACSEC_SecYCfgType::secTagOffset to 16 (6 bytes MAC DA + 6 bytes MAC SA +
#               4 bytes for 802.1Q tag).
#
#
#   @file
#   @brief Makefile for MACSec Driver
#   @version 0.1 Initial version
#   @}

BRCM_COMP_NAME := macsecdrv
BRCM_COMP_DEPENDS := aes
BRCM_COMP_TYPE := lib

BRCM_COMP_APP_CFLAGS += -DENABLE_MACSEC
BRCM_COMP_REQ_SRC += doc/macsec_req.c
BRCM_COMP_EXPORT_HDR += inc/macsec.h
BRCM_COMP_EXPORT_HDR += inc/osil/macsec_osil.h
BRCM_COMP_ULIB_SRC += lib/macsec.c
BRCM_COMP_UAPP_SRC += os/base/macsec_osil.c
BRCM_COMP_ULIB_SRC += lib/macsec_drv.c

BRCM_COMP_LIB_CFLAGS += -DMACSEC_MAX_SECY_PER_PORT=2
BRCM_COMP_LIB_CFLAGS += -DMACSEC_MAX_RXSC_PER_SECY=2

#BRCM_COMP_APP_INTR += MACSEC
#MACSEC.function = MACSEC_IRQHandler
#MACSEC.declaration = macsec_osil.h
#ifeq ($(CHIP_FAMILY), bcm8957x)
#MACSEC.irqnum = 81
#endif
