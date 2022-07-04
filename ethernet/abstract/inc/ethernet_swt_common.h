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
    @defgroup grp_ethernet_swt_common_ifc Switch Common Interface
    @ingroup grp_ethernet_abstract

    @addtogroup grp_ethernet_swt_common_ifc
    @{

    @file ethernet_swt_common.h

    @brief Ethernet Switch Common Interface
    This file contains the interfaces for the Ethernet Switch common

    @version 1.0 Initial version
*/

#ifndef ETHERNET_SWT_COMMON_H
#define ETHERNET_SWT_COMMON_H

#include <compiler.h>

#include <compiler.h>

/**
    @name Ethernet Common API IDs
    @{
    @brief API IDs for Ethernet Common
*/
#define BRCM_SWARCH_ETHSWT_VLAN_INGRESS_FILTER_MODE_TYPE    (0x8700U) /**< @brief #ETHSWT_VLANIngressFilterModeType */
#define BRCM_SWARCH_ETHSWT_MGMTMODE_TYPE                    (0x8701U) /**< @brief #ETHSWT_MgmtModeType */
#define BRCM_SWARCH_ETHSWT_PCP_TYPE                         (0x8702U) /**< @brief #ETHSWT_PCPType */
#define BRCM_SWARCH_ETHSWT_TE_TYPE                          (0x8703U) /**< @brief #ETHSWT_TEType */
#define BRCM_SWARCH_ETHSWT_TC_TYPE                          (0x8704U) /**< @brief #ETHSWT_TCType */
#define BRCM_SWARCH_ETHSWT_BRCMHDR_TYPE                     (0x8705U) /**< @brief #ETHSWT_BrcmHdrModeType */
#define BRCM_SWARCH_ETHSWT_DUMBFWD_TYPE                     (0x8706U) /**< @brief #ETHSWT_DumbFwdModeType */
#define BRCM_SWARCH_ETHSWT_MAX_MYDA_ENTRIES_MACRO           (0x8707U) /**< @brief #ETHSWT_MAX_MYDA_ENTRIES */
#define BRCM_SWARCH_ETHSWT_ADDRESSLIMITING_TYPE             (0x8708U) /**< @brief #ETHSWT_AddressLimitingType */
#define BRCM_SWARCH_ETHSWT_SECURITY_ACTION_TYPE             (0x8709U) /**< @brief #ETHSWT_SecurityActionType */
#define BRCM_SWARCH_ETHSWT_PORT_ID_TYPE                     (0x870AU) /**< @brief #ETHSWT_PortIDType */
#define BRCM_SWARCH_ETHSWT_HW_ID_TYPE                       (0x870BU) /**< @brief #ETHSWT_HwIDType */
#define BRCM_SWARCH_ETHSWT_PORTSTATS_TYPE                   (0x870CU) /**< @brief #ETHSWT_PortStatsType */
/** @} */

/**
    @name Hardware ID type
    @{
    @brief Switch hardware index type

    @trace #BRCM_SWREQ_ETHSWT
*/
typedef uint32_t ETHSWT_HwIDType;       /**< @brief Switch hardware ID type */
#define ETHSWT_HW_ID_0      (0UL)       /**< @brief Switch hardware ID 0    */
/** @} */

/**
    @name Port ID type
    @{
    @brief Switch port index type

    @trace #BRCM_SWREQ_ETHSWT
*/
typedef uint32_t ETHSWT_PortIDType;           /**< @brief Switch port index type */
#define ETHSWT_PORT_ID_MAX     (9UL)          /**< @brief Max number of ports */
#define ETHSWT_PORT_ID_INVALID (0xFFFFFFFFUL) /**< @brief Invalid port index */
/** @} */

/**
    @name Security action
    @{
    @brief If packets try to breach the security,
    then appropriate action should be triggered.

    @trace #BRCM_SWREQ_ETHSWT
*/
typedef uint8_t ETHSWT_SecurityActionType;                  /**< @brief Security action */
#define ETHSWT_SECURITY_ACTION_DISABLED              (0U)   /**< @brief None of the action
                                                                 would be triggered, If the
                                                                 security feature is disabled */
#define ETHSWT_SECURITY_ACTION_DROP_PKT              (1U)   /**< @brief Drop-packet */
#define ETHSWT_SECURITY_ACTION_REDIRECT_TO_CPU       (2U)   /**< @brief Redirect to CPU */
#define ETHSWT_SECURITY_ACTION_NORMAL                (3U)   /**< @brief Normal ACL based forwarding */
#define ETHSWT_SECURITY_ACTION_COPY_TO_CPU           (4U)   /**< @brief Copy to CPU */
#define ETHSWT_SECURITY_ACTION_INVALID             (255U)   /**< @brief Invalid action */
/** @} */

/**
    @brief Address limiting configuration for port

    @trace #BRCM_SWREQ_ETHSWT
*/
typedef struct COMP_PACKED sETHSWT_AddressLimitingType {
    ETHSWT_SecurityActionType overLimitAction;      /**< @brief Indicates the actions
                                                          when the MAC Address limit counter
                                                          of the port is crossed the max
                                                          programmed value, If this field is
                                                          non-zero otherwise address limiting
                                                          is disabled for this port. */
    uint16_t macLearningLimit;                      /**< @brief Port SA Learned Limit
                                                          It defines the maximum number
                                                          of MAC addresses allowed to
                                                          learn on the ingress port.
                                                          The configured value of 0
                                                          will mean no dynamic address
                                                          will be learned on the chip.
                                                          When the maximum limit is set,
                                                          it can't over the #ETHSWT_ARL_SIZE.
                                                          If it is written above the
                                                          #ETHSWT_ARL_SIZE, it will be to
                                                          set to #ETHSWT_ARL_SIZE. */

} ETHSWT_AddressLimitingType;

/**
    @name Switch myDA No Of Entries
    @{
    @brief No of Switch myDA Entries

    @trace #BRCM_SWREQ_ETHSWT
*/
#define ETHSWT_MAX_MYDA_ENTRIES        (0x8U)
/** @} */

/**
    @name Dumb forward mode
    @{
    @brief Dumb forward mode

    @trace #BRCM_SWREQ_ETHSWT
*/
typedef uint32_t ETHSWT_DumbFwdModeType;    /**< @brief Dumb forward mode */
#define ETHSWT_DUMBFWD_ENABLE     (0UL)     /**< @brief Dumb forward enable */
#define ETHSWT_DUMBFWD_DISABLE    (1UL)     /**< @brief Dumb forward disable */
/** @} */

/**
    @name Broadcom header mode
    @{
    @brief Broadcom header mode

    @trace #BRCM_SWREQ_ETHSWT
*/
typedef uint32_t ETHSWT_BrcmHdrModeType;    /**< @brief Broadcom header mode */
#define ETHSWT_BRCMHDR_DISABLE    (0UL)     /**< @brief Broadcom header disable */
#define ETHSWT_BRCMHDR_ENABLE     (1UL)     /**< @brief Broadcom header enable */
/** @} */

/**
    @name Traffic class type
    @{
    @brief Traffic class type

    @trace #BRCM_SWREQ_ETHSWT
*/
typedef uint8_t ETHSWT_TCType;             /**< @brief Traffic class type */
#define ETHSWT_TC_0       (0U)             /**< @brief Traffic class 0 */
#define ETHSWT_TC_1       (1U)             /**< @brief Traffic class 1 */
#define ETHSWT_TC_2       (2U)             /**< @brief Traffic class 2 */
#define ETHSWT_TC_3       (3U)             /**< @brief Traffic class 3 */
#define ETHSWT_TC_4       (4U)             /**< @brief Traffic class 4 */
#define ETHSWT_TC_5       (5U)             /**< @brief Traffic class 5 */
#define ETHSWT_TC_6       (6U)             /**< @brief Traffic class 6 */
#define ETHSWT_TC_7       (7U)             /**< @brief Traffic class 7 */
#define ETHSWT_TC_INVALID (ETHSWT_TC_7 + 1U) /**< @brief Invalid traffic
                                                        class */
/** @} */

/**
    @name ETHSWT_TEType
    @{
    @brief Tag Enforcement type in Ingress Broadcom Header/tag

    @note: This should be as per Broadcom Ingress header/tag

    @trace #BRCM_SWREQ_ETHSWT
*/
typedef uint8_t ETHSWT_TEType;       /**< @brief Tag enforcement type */
#define ETHSWT_TE_NONE       (0U)   /**< @brief No enforcement */
#define ETHSWT_TE_UNTAG      (1U)   /**< @brief Untag enforcement */
#define ETHSWT_TE_HEADER     (2U)   /**< @brief Header enforcement */
#define ETHSWT_TE_RESERVED   (3U)   /**< @brief Reserved */
/** @} */

/**
    @name Priority type
    @{
    @brief 802.1Q Priority type

    @trace #BRCM_SWREQ_ETHSWT
*/
typedef uint8_t ETHSWT_PCPType;       /**< @brief 802.1Q Priority type */
#define ETHSWT_PCP_0          (0U)   /**< @brief PCP 0 */
#define ETHSWT_PCP_1          (1U)   /**< @brief PCP 1 */
#define ETHSWT_PCP_2          (2U)   /**< @brief PCP 2 */
#define ETHSWT_PCP_3          (3U)   /**< @brief PCP 3 */
#define ETHSWT_PCP_4          (4U)   /**< @brief PCP 4 */
#define ETHSWT_PCP_5          (5U)   /**< @brief PCP 5 */
#define ETHSWT_PCP_6          (6U)   /**< @brief PCP 6 */
#define ETHSWT_PCP_7          (7U)   /**< @brief PCP 7 */
/** @} */

/**
    @name Switch management mode
    @{
    @brief Switch management mode

    @trace #BRCM_SWREQ_ETHSWT
*/
typedef uint32_t ETHSWT_MgmtModeType;  /**< @brief Management mode */
#define ETHSWT_MGMTMODE_DISABLE (0UL)  /**< @brief Unmanaged mode */
#define ETHSWT_MGMTMODE_ENABLE  (1UL)  /**< @brief Managed mode */
/** @} */

/**
    @name VLAN ingress filter mode
    @{
    @brief VLAN ingress filter mode

    @trace #BRCM_SWREQ_ETHSWT
*/
typedef uint32_t ETHSWT_VLANIngressFilterModeType;       /**< @brief VLAN ingress
                                                                   filter mode type */
#define ETHSWT_VLAN_INGRESS_FILTER_MODE_DISABLED   (0U)  /**< @brief Vlan
                                                                   ingress filter mode disabled */
#define ETHSWT_VLAN_INGRESS_FILTER_MODE_ENABLED    (1U)  /**< @brief Vlan
                                                                   ingress filter mode enabled */
/** @} */

/**
    @brief Switch statistics type

    @trace #BRCM_SWREQ_ETHSWT
*/
typedef struct sETHSWT_PortStatsType {
    uint32_t linkStateChangeCount;      /**< @brief Link state change count */
} ETHSWT_PortStatsType;

#endif /* ETHERNET_SWT_COMMON_H */
/** @} */