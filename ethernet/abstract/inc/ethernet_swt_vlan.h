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
    @defgroup grp_ethernet_swt_vlan_ifc Switch VLAN abstract Interface
    @ingroup grp_ethernet_abstract

    @addtogroup grp_ethernet_swt_vlan_ifc
    @{

    @file ethswtm_abs_vlan.h

    @brief Ethernet Service: VLAN Interface
    This file contains the interfaces for the Ethernet abstract for VLAN

    @version 1.0 Initial version
*/

#ifndef ETHERNET_SWT_VLAN_H
#define ETHERNET_SWT_VLAN_H

#include <module_msg.h>
#include <ethernet_common.h>

/**
    @name VLAN API IDs
    @{
    @brief API IDs for VLAN
*/
#define BRCM_SWARCH_ETHSWT_VLANCMDID_TYPE              (0x8100U)    /**< @brief #ETHSWT_VLANCmdIdType */
#define BRCM_SWARCH_ETHSWT_VLANPORT_TYPE               (0x8101U)    /**< @brief #ETHSWT_VLANPortType */
#define BRCM_SWARCH_ETHSWT_VLANMSGUNION_TYPE           (0x8102U)    /**< @brief #ETHSWT_VLANMsgUnionType */
#define BRCM_SWARCH_ETHSWT_VLANHOSTCONTEXT_TYPE        (0x8103U)    /**< @brief #ETHSWT_VLANHostContextType */
#define BRCM_SWARCH_ETHSWT_VLANHOSTCONTEXTSETUP_PROC   (0x8104U)    /**< @brief #ETHSWT_VLANHostContextSetup */
#define BRCM_SWARCH_ETHSWT_VLANHOSTCONTEXTPROCESS_PROC (0x8105U)    /**< @brief #ETHSWT_VLANHostContextProcess */
#define BRCM_SWARCH_ETHSWT_VLANHELPER_GLOBAL           (0x8106U)    /**< @brief #ETHSWT_VLANHelper */
#define BRCM_SWARCH_ETHSWT_VLAN_MAX_PAYLOAD_SIZE_MACRO (0x8107U)    /**< @brief #ETHSWT_VLAN_MAX_PAYLOAD_SIZE */
/** @} */

/**
    @name Switch VLAN command IDs
    @{
    @brief Switch VLAN command IDs group

    @trace #BRCM_SWREQ_ETHSWT
*/
typedef uint8_t ETHSWT_VLANCmdIdType;                                 /**< @brief VLAN command message Type                          */
#define ETHSWT_VLANCMDID_GET           (0x60U)                        /**< @brief #ETHSWT_VLANPortType       #ETHSWT_GetVLANPorts    */
#define ETHSWT_VLANCMDID_PORT_ADD      (0x61U)                        /**< @brief #ETHSWT_VLANPortType       #ETHSWT_AddVLANPorts    */
#define ETHSWT_VLANCMDID_PORT_REMOVE   (0x62U)                        /**< @brief #ETHSWT_VLANPortType       #ETHSWT_RemoveVLANPorts */
#define ETHSWT_VLANCMDID_START         (ETHSWT_VLANCMDID_GET)         /**< @brief VLAN Command start index                           */
#define ETHSWT_VLANCMDID_END           (ETHSWT_VLANCMDID_PORT_REMOVE) /**< @brief VLAN Command end index                             */
/** @} */

/**
    @brief Maximum size of VLAN command payload in bytes

    @trace #BRCM_SWREQ_ETHSWT
*/
#define ETHSWT_VLAN_MAX_PAYLOAD_SIZE   (32UL)

/**
    @brief Structure to manage VLAN

    @trace #BRCM_SWREQ_ETHSWT
*/
typedef struct sETHSWT_VLANPortType {
    ETHER_VLANIDType      vlan;           /**< @brief VLAN ID */
    uint16_t            rsv0;           /**< @brief Reserved */
    uint32_t            portMask;       /**< @brief Port mask */
    uint32_t            tagMask;        /**< @brief Tagged port mask */
    uint32_t            staticPortMask; /**< @brief Static port mask */
    uint32_t            rsv1[4U];       /**< @brief Reserved */
} ETHSWT_VLANPortType;
_Static_assert(sizeof(ETHSWT_VLANPortType) <= ETHSWT_VLAN_MAX_PAYLOAD_SIZE,
               "ETHSWT_VLANPortType does not fit in IPC payload");

/**
    @brief Vlan Union encapsulating all messages

    @trace #BRCM_SWREQ_ETHSWT
*/
typedef union uETHSWT_VLANMsgUnionType {
    uint32_t                   data[ETHSWT_VLAN_MAX_PAYLOAD_SIZE/4UL]; /**< @brief Max Payload size */
    ETHSWT_VLANPortType        vlanPort;                         /**< @brief VLAN Payload */
} ETHSWT_VLANMsgUnionType;
_Static_assert(sizeof(ETHSWT_VLANMsgUnionType) <= ETHSWT_VLAN_MAX_PAYLOAD_SIZE,
               "ETHSWT_VLANMsgUnionType does not fit in IPC payload");

/**
    @brief Vlan Host Context Type

    @trace #BRCM_SWREQ_ETHSWT
*/
typedef struct sETHSWT_VLANHostContextType {
    BCM_StateType               state;      /**< @brief Context State           */
    BCM_SubStateType            subState;   /**< @brief Context Sub State       */
    BCM_CmdType                 id;         /**< @brief Command/Response ID     */
    int32_t                     status;     /**< @brief final status of command */
    ETHSWT_VLANMsgUnionType     msg;        /**< @brief Message input/output    */
} ETHSWT_VLANHostContextType;

/**
    @brief Setup VLAN Host context

    @behavior Sync, Non-Rentrant

    @pre None

    @param[inout]   aContext        Context to be setup
    @param[in]      aSecYID         Command/Message Type
    @param[in]      aMsgPayload     Command/Message payload

    Return values are documented in reverse-chronological order
    @retval     BCM_ERR_OK              Setup for initialization complete
    @retval     BCM_ERR_INVAL_PARAMS    aContext is NULL or aInitMsg is NULL

    @post aContext.state is changes to RUNNING.

    @trace #BRCM_SWREQ_ETHSWT

    @limitations None
*/
int32_t ETHSWT_VLANHostContextSetup(ETHSWT_VLANHostContextType *aContext, ETHSWT_VLANCmdIdType aCmdID,
                                    const ETHSWT_VLANMsgUnionType *aMsgPayload);

/**
    @brief Process VLAN Host context

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
    at @ref ETHSWT_VLANCmdIdType, and any output will be reflected in the structure represented
    at @ref ETHSWT_VLANCmdIdType.

    @trace #BRCM_SWREQ_ETHSWT

    @limitations None
*/
int32_t ETHSWT_VLANHostContextProcess(ETHSWT_VLANHostContextType *aContext, int32_t aResponse,
                                      BCM_CmdType aInMsgID, const uint8_t *aInMsgPayload,
                                      BCM_CmdType *aOutMsgId, uint8_t *aOutMsgPayload);

/**
    @brief Host VLAN Helper Module

    @trace #BRCM_SWREQ_ETHSWT
*/
extern const MODULE_MsgConverterType ETHSWT_VLANHelper;

#endif /* ETHERNET_SWT_VLAN_H */

/** @} */