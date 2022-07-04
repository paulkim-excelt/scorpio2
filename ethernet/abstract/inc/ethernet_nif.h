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
    @defgroup grp_ethernet_nif_ifc  Ethernet abstract Interface
    @ingroup grp_ethernet_abstract

    @addtogroup grp_ethernet_nif_ifc
    @{

    @file ethernet_nif.h

    @brief Ethernet Interface
    This file contains the interfaces for the abstract for Ethernet

    @version 1.0 Initial version
*/

#ifndef ETHER_NIF_H
#define ETHER_NIF_H

#include <module_msg.h>
#include <ethernet_common.h>

/**
    @name Ethernet API IDs
    @{
    @brief API IDs for Ethernet
*/
#define BRCM_SWARCH_ETHER_CMDID_TYPE              (0x8E00U)  /**< @brief #ETHER_CmdIdType */
#define BRCM_SWARCH_ETHER_MAX_PAYLOAD_SIZE_MACRO  (0x8E01U)  /**< @brief #ETHER_MAX_PAYLOAD_SIZE */
#define BRCM_SWARCH_ETHER_MDIOACCESS_TYPE         (0x8E02U)  /**< @brief #ETHER_MDIOAccessType */
#define BRCM_SWARCH_ETHER_MSGUNION_TYPE           (0x8E03U)  /**< @brief #ETHER_MsgUnionType */
#define BRCM_SWARCH_ETHER_HOSTCONTEXT_TYPE        (0x8E04U)  /**< @brief #ETHER_HostContextType */
#define BRCM_SWARCH_ETHER_HOSTCONTEXTSETUP_PROC   (0x8E05U)  /**< @brief #ETHER_HostContextSetup */
#define BRCM_SWARCH_ETHER_HOSTCONTEXTPROCESS_PROC (0x8E06U)  /**< @brief #ETHER_HostContextProcess */
#define BRCM_SWARCH_ETHER_MDIOHELPER_GLOBAL       (0x8E07U)  /**< @brief #ETHER_MDIOHelper */
/** @} */

/**
    @name Ethernet command IDs
    @{
    @brief Ethernet command IDs group

    @trace #BRCM_SWREQ_ETHER
*/
typedef uint8_t ETHER_CmdIdType;                            /**< @brief Ethernet command message Type     */
#define ETHER_CMDID_MDIO_READ     (0x05U)                   /**< @brief MDIO read command            */
#define ETHER_CMDID_MDIO_WRITE    (0x06U)                   /**< @brief MDIO write command           */
#define ETHER_CMDID_START         (ETHER_CMDID_MDIO_READ)   /**< @brief Ethernet Command start index */
#define ETHER_CMDID_END           (ETHER_CMDID_MDIO_WRITE)  /**< @brief Ethernet Command end index   */
/** @} */

/**
    @brief Maximum size of Ethernet command payload in bytes

    @trace #BRCM_SWREQ_ETHER
*/
#define ETHER_MAX_PAYLOAD_SIZE   (32UL)

/**
    @brief Structure to perform MDIO read/write accesses

    @trace #BRCM_SWREQ_ETHER
*/
typedef struct sETHER_MDIOAccessType {
    uint32_t deviceID;            /**< @brief MDIO device ID   */
    ETHER_MDIOHwIDType mdioHwID;  /**< @brief MDIO hardware ID */
    ETHER_MDIOPktType pkt;        /**< @brief Packet type      */
} ETHER_MDIOAccessType;
_Static_assert(sizeof(ETHER_MDIOAccessType) <= ETHER_MAX_PAYLOAD_SIZE,
               "ETHER_MDIOAccessType does not fit in IPC payload");

/**
    @brief Union encapsulating all ethernet messages

    @trace #BRCM_SWREQ_ETHER
*/
typedef union uETHER_MsgUnionType {
    uint32_t             data[ETHER_MAX_PAYLOAD_SIZE/4UL]; /**< @brief Max Payload size    */
    ETHER_MDIOAccessType mdioAccess;                       /**< @brief MDIO access Payload */
} ETHER_MsgUnionType;
_Static_assert(sizeof(ETHER_MsgUnionType) <= ETHER_MAX_PAYLOAD_SIZE,
               "ETHER_MsgUnionType does not fit in IPC payload");

/**
    @brief Ethernet Host Context Type

    @trace #BRCM_SWREQ_ETHER
*/
typedef struct sETHER_HostContextType {
    BCM_StateType          state;      /**< @brief Context State           */
    BCM_SubStateType       subState;   /**< @brief Context Sub State       */
    BCM_CmdType            id;         /**< @brief Command/Response ID     */
    int32_t                status;     /**< @brief final status of command */
    ETHER_MsgUnionType     msg;        /**< @brief Message input/output    */
} ETHER_HostContextType;

/**
    @brief Setup Ethernet Host context

    @behavior Sync, Non-Rentrant

    @pre None

    @param[inout]   aContext        Context to be setup
    @param[in]      aSecYID         Command/Message Type
    @param[in]      aMsgPayload     Command/Message payload

    Return values are documented in reverse-chronological order
    @retval     BCM_ERR_OK              Setup for initialization complete
    @retval     BCM_ERR_INVAL_PARAMS    aContext is NULL or aInitMsg is NULL

    @post aContext.state is changes to RUNNING.

    @trace #BRCM_SWREQ_ETHER

    @limitations None
*/
int32_t ETHER_HostContextSetup(ETHER_HostContextType *aContext, ETHER_CmdIdType aCmdID,
                               const ETHER_MsgUnionType *aMsgPayload);

/**
    @brief Process Ethernet Host context

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
    at @ref ETHER_CmdIdType, and any output will be reflected in the structure represented
    at @ref ETHER_CmdIdType.

    @trace #BRCM_SWREQ_ETHER

    @limitations None
*/
int32_t ETHER_HostContextProcess(ETHER_HostContextType *aContext, int32_t aResponse,
                                 BCM_CmdType aInMsgID, const uint8_t *aInMsgPayload,
                                 BCM_CmdType *aOutMsgId, uint8_t *aOutMsgPayload);

/**
    @brief Host Ethernet MDIO Helper Module

    @trace #BRCM_SWREQ_ETHER
*/
extern const MODULE_MsgConverterType ETHER_MDIOHelper;

#endif /* ETHER_NIF_H */
/** @} */