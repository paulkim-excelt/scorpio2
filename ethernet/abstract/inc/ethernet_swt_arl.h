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
    @defgroup grp_ethernet_swt_arl_ifc Switch ARL abstract Interface
    @ingroup grp_ethernet_abstract

    @addtogroup grp_ethernet_swt_arl_ifc
    @{

    @file ethernet_swt_arl.h

    @brief Abstract ARL Interface
    This file contains the abstract interfaces for ARL

    @version 1.0 Initial version
*/

#ifndef ETHSWT_ABSTRACT_ARL_H
#define ETHSWT_ABSTRACT_ARL_H

#include <ethernet_common.h>
#include <ethernet_swt_common.h>
#include <module_msg.h>

/**
    @name ARL API IDs
    @{
    @brief API IDs for ARL
*/
#define BRCM_SWARCH_ETHSWT_ARL_HOST_MAX_ENTRIES_MACRO  (0x8501U) /**< @brief #ETHSWT_ARL_HOST_MAX_ENTRIES */
#define BRCM_SWARCH_ETHSWT_ARL_MAX_ENTRIES_MACRO       (0x8502U) /**< @brief #ETHSWT_ARL_MAX_ENTRIES */
#define BRCM_SWARCH_ETHSWT_ARL_RPC_MAX_ENTRIES_MACRO   (0x8503U) /**< @brief #ETHSWT_ARL_RPC_MAX_ENTRIES */
#define BRCM_SWARCH_ETHSWT_ARLCMDID_TYPE               (0x8504U) /**< @brief #ETHSWT_ARLCmdIdType */
#define BRCM_SWARCH_ETHSWT_ARLENTRY_TYPE               (0x8505U) /**< @brief #ETHSWT_ARLEntryType */
#define BRCM_SWARCH_ETHSWT_ARLLIST_TYPE                (0x8506U) /**< @brief #ETHSWT_ARLListType */
#define BRCM_SWARCH_ETHSWT_ARLMSGUNIONTYPE_            (0x8507U) /**< @brief #ETHSWT_ARLMsgUnionType */
#define BRCM_SWARCH_ETHSWT_ARLHOSTCONTEXT_TYPE         (0x8508U) /**< @brief #ETHSWT_ARLHostContextType */
#define BRCM_SWARCH_ETHSWT_ARLHELPER_GLOBAL            (0x8509U) /**< @brief #ETHSWT_ARLHelper  */
#define BRCM_SWARCH_ETHSWT_ARL_MAX_PAYLOAD_SIZE_MACRO  (0x850AU) /**< @brief #ETHSWT_ARL_MAX_PAYLOAD_SIZE */
/** @} */

/** @brief Maximum ARL Entries that host can capture

    @trace #BRCM_SWREQ_ETHSWT
*/
#define ETHSWT_ARL_HOST_MAX_ENTRIES       (1000UL)

/**
    @brief Maximum number of ARL entries supported
    @trace #BRCM_SWREQ_ETHSWT
*/
#define ETHSWT_ARL_MAX_ENTRIES            (512UL)

/**
    @brief Maximum size of ARL payload
    @trace #BRCM_SWREQ_ETHSWT
*/
#define ETHSWT_ARL_MAX_PAYLOAD_SIZE       (RPC_MEM_MSG_PAYLOAD_SZ)

/**
    @brief Maximum number of ARL entries in a RPC message
    @trace #BRCM_SWREQ_ETHSWT
*/
#define ETHSWT_ARL_RPC_MAX_ENTRIES        ((ETHSWT_ARL_MAX_PAYLOAD_SIZE-4UL)/sizeof(ETHSWT_ARLEntryType))

/**
    @name Switch ARL command IDs
    @{
    @brief Switch ARL command IDs group

    @trace #BRCM_SWREQ_ETHSWT
*/
typedef uint8_t ETHSWT_ARLCmdIdType;         /**< @brief ARL command message Type                         */
#define ETHSWT_ARLCMDID_ADD         (0x80U)  /**< @brief #ETHSWT_ARLEntryType       #ETHSWT_AddARLEntry   */
#define ETHSWT_ARLCMDID_DELETE      (0x81U)  /**< @brief #ETHSWT_ARLEntryType       #ETHSWTM_ARLDelEntry  */
#define ETHSWT_ARLCMDID_SNAPSHOT    (0x82U)  /**< @brief #ETHSWT_ARLListType        #ETHSWT_GetARLTable   */
#define ETHSWT_ARLCMDID_GET         (0x83U)  /**< @brief #ETHSWT_ARLListType        #ETHSWT_GetARLTable   */
#define ETHSWT_ARLCMDID_START       (ETHSWT_ARLCMDID_ADD) /**< @brief ARL Command start index             */
#define ETHSWT_ARLCMDID_END         (ETHSWT_ARLCMDID_GET) /**< @brief ARL Command end index               */
/** @} */

/**
    @brief ARL table entry

    @trace #BRCM_SWREQ_ETHSWT
*/
typedef struct sETHSWT_ARLEntryType {
    uint8_t             macAddr[6];     /**< @brief MAC address */
    ETHER_VLANIDType      vlanID;         /**< @brief VLAN ID */
    ETHSWT_PortIDType   portMask;       /**< @brief Switch port mask */
    uint16_t            reserved;       /**< @brief Reserved */
} ETHSWT_ARLEntryType;
_Static_assert(sizeof(ETHSWT_ARLEntryType) <= ETHSWT_ARL_MAX_PAYLOAD_SIZE,
               "ETHSWT_ARLEntryType does not fit in IPC payload");

/**
    @brief Structure to manage the ARL commands.

    @trace #BRCM_SWREQ_ETHSWT
*/
typedef struct sETHSWT_ARLListType {
    uint32_t            num;                                  /**< @brief NUmber of entries */
    ETHSWT_ARLEntryType entries[ETHSWT_ARL_RPC_MAX_ENTRIES];  /**< @brief ARL entries */
} ETHSWT_ARLListType;
_Static_assert(sizeof(ETHSWT_ARLListType) <= ETHSWT_ARL_MAX_PAYLOAD_SIZE,
               "ETHSWT_ARLListType does not fit in IPC payload");

/**
    @brief ARL Union encapsulating all messages

    @trace #BRCM_SWREQ_ETHSWT
*/
typedef union uETHSWT_ARLMsgUnionType {
    uint32_t               data[sizeof(ETHSWT_ARLListType)/4UL]; /**< @brief byte array */
    ETHSWT_ARLEntryType    arlEntry;   /**< @brief ARL entry */
    ETHSWT_ARLListType     arlList;    /**< @brief ARL list */
} ETHSWT_ARLMsgUnionType;

/**
    @brief ARL Host Context Type

    @trace #BRCM_SWREQ_ETHSWT
*/
typedef struct sETHSWT_ARLHostContextType {
    BCM_StateType               state;      /**< @brief Context State           */
    BCM_SubStateType            subState;   /**< @brief Context Sub State       */
    BCM_CmdType                 id;         /**< @brief Command/Response ID     */
    int32_t                     status;     /**< @brief final status of command */
    ETHSWT_ARLMsgUnionType      msg;        /**< @brief Message input/output    */
} ETHSWT_ARLHostContextType;

/**
    @brief Function pointer table for ARL helper

    @trace #BRCM_SWREQ_ETHSWT
 */
extern const MODULE_MsgConverterType ETHSWT_ARLHelper;

#endif /* ETHSWT_ABSTRACT_ARL_H */
/** @} */
