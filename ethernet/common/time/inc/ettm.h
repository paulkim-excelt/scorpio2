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
    @defgroup grp_ethsrv_time_ifc Ethernet Time Module Interface
    @ingroup grp_ethsrv_time

    @addtogroup grp_ethsrv_time_ifc
    @{

    @file ettm.h

    @brief Ethernet Time Module Interface
    This file contains the interfaces for the Ethernet Time module

    @version 0.1 Initial version
*/

#ifndef ETTM_H
#define ETTM_H

#include <module.h>

/**
    @name Ethernet Time Module IDs
    @{
    @brief Architecture API IDs for Ethernet Time module
*/
#define BRCM_SWARCH_ETTM_GLOBAL               (0x8101U) /**< @brief #ETTM_Module        */
#define BRCM_SWARCH_ETTM_CMDID_TYPE           (0x8102U) /**< @brief #ETTM_CmdIDType     */
#define BRCM_SWARCH_ETTM_HEARTBEAT_TYPE       (0x8103U) /**< @brief #ETTM_HeartBeatType */
#define BRCM_SWARCH_ETTM_PAYLOAD_TYPE         (0x8104U) /**< @brief #ETTM_PayloadType   */
/** @} */

/**
    @name ETTM_CmdIDType
    @{
    @brief Command identifiers
    @trace #BRCM_SWREQ_ETTM
*/
typedef uint8_t ETTM_CmdIDType;                    /**< @brief typedef for ETHTIME command ids */
#define ETTM_CMDID_PREPARE_SYNC            (1U)    /**< @brief Prepare Sync command */
#define ETTM_CMDID_PREPARE_HEARTBEAT_READ  (2U)    /**< @brief Prepare Heartbeat command */
#define ETTM_CMDID_HEARTBEAT_GET           (3U)    /**< @brief Heartbeat Get command */
#define ETTM_CMDID_TIMESYNC_ACK            (4U)    /**< @brief Acknowledge Timesync command */
#define ETTM_CMDID_READY_FOR_TIMESYNC      (1U)    /**< @brief Timesync Ready Notification Command*/
/** @} */

/**
    @brief Structure to maintain the HeartBeat values

    @trace #BRCM_SWREQ_ETTM
*/
typedef struct sETTM_HeartBeatType {
    uint64_t hb0;
    uint64_t hb1;
} ETTM_HeartBeatType;

/**
    @brief Union of all possible structures used for RPC communication.

    @note Stop gap arrangement until RPC V2 is enabled on endpoint SDKs
    @trace #BRCM_SWREQ_ETTM
*/
typedef union uETTM_PayloadType {
    uint8_t            *u8Ptr;      /**< @brief Memory */
    const uint8_t      *u8ConstPtr; /**< @brief Const memory  */
    ETTM_HeartBeatType *heartBeat;  /**< @brief 1588 heartbeat */
} ETTM_PayloadType;

_Static_assert(sizeof(ETTM_HeartBeatType) <= 448UL, "ETHER_HeartBeatType does not fit in payload");

/**
    @brief Function pointer for ETHSRV ethernet time module

    @trace #BRCM_SWREQ_ETTM
 */
extern const MODULE_Type ETTM_Module;

#endif /* ETTM_H */

/** @} */
