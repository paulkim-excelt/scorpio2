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
    @defgroup grp_ipc_ifc Interface
    @ingroup grp_ipc_v2

    @addtogroup grp_ipc_ifc
    @{
    @section sec_ipc_overview Overview
    Example of IPC channels in a system is depicted in the block diagram below

    @image html ipc_block_diagram_dio.png "IPC Block Diagram"

    @limitations This driver works only with memory mapped interface
    for accessing the shared memory.

    @file ipc.h

    @brief Application Programmer Interface for IPC driver
    This header file contains the APIs for IPC driver.

    @version 0.1 Initial revision
*/

#ifndef IPC_H
#define IPC_H

#include <bcm_err.h>
#include <svc.h>

/**
    @name IPC  API IDs
    @{
    @brief API IDs for IPC driver
*/
#define BRCM_SWARCH_IPC_MSG_HDR_SIZE_MACRO    (0x8100U) /**< @brief #IPC_MSG_HDR_SIZE */
#define BRCM_SWARCH_IPC_MSG_LOG2_CNT_MACRO    (0x8102U) /**< @brief #IPC_BUF_LOG2_MAX_CNT */
#define BRCM_SWARCH_IPC_MAGIC_TYPE            (0x8103U) /**< @brief #IPC_MagicType */
#define BRCM_SWARCH_IPC_MSG_HDR_TYPE          (0x8104U) /**< @brief #IPC_MsgHdrType */
#define BRCM_SWARCH_IPC_CHANNID_TYPE          (0x8105U) /**< @brief #IPC_ChannIDType */
#define BRCM_SWARCH_IPC_CHANN_MODE_TYPE       (0x8106U) /**< @brief #IPC_ChannModeType */
#define BRCM_SWARCH_IPC_INIT_PROC             (0x8109U) /**< @brief #IPC_Init */
#define BRCM_SWARCH_IPC_DEINIT_PROC           (0x810AU) /**< @brief #IPC_DeInit */
#define BRCM_SWARCH_IPC_SEND_PROC             (0x810BU) /**< @brief #IPC_Send */
#define BRCM_SWARCH_IPC_RECV_PROC             (0x810CU) /**< @brief #IPC_Receive */
/** @} */

/**
    @brief Size of internal messages header

    16 bytes of header

    @trace #BRCM_SWREQ_IPC_DRIVER
*/
#define IPC_MSG_HDR_SIZE            (16UL)

/**
    @name IPC Magic numbers

    @{
    @brief IPC Magic numbers

    IPC Magic numbers used for command packet and response packet

    @trace #BRCM_SWREQ_IPC_DRIVER
 */
typedef uint32_t IPC_MagicType;
#define IPC_MAGIC_CMD        (0xA5A5A5A5UL)
#define IPC_MAGIC_RESP       (0x5A5A5A5AUL)
/** @} */

/**
    @name IPC channel ID type
    @{
    @brief IPC channel ID type

    @trace #BRCM_SWREQ_IPC_KERNEL_INTERFACE
 */
typedef uint8_t IPC_ChannIDType;
#define IPC_CHANNID_0         (0x00UL)
#define IPC_CHANNID_1         (0x01UL)
#define IPC_CHANNID_2         (0x02UL)
#define IPC_CHANNID_INVALID   (0xFFUL)
/** @} */

/**
    @brief IPC channel mode type

    Each IPC channel either works in master or slave mode.

    @trace #BRCM_SWREQ_IPC_DRIVER
 */
typedef uint8_t IPC_ChannModeType;
#define IPC_CHANN_MODE_SLAVE    (1U)   /**< @brief IPC channel is in slave mode */
#define IPC_CHANN_MODE_MASTER   (2U)   /**< @brief IPC channel is in master mode */

/**
    @brief IPC Message header

    Format of the IPC message header

    @trace #BRCM_SWREQ_IPC_DRIVER
 */
typedef struct sIPC_MsgHdrType {
    IPC_MagicType   magic;
    uint32_t        checksum;
    uint32_t        cmd;
    uint32_t        len;
} IPC_MsgHdrType;

/** @brief Initialize IPC driver

    This API initializes and configures IPC driver.

    @behavior Sync, Non-reentrant

    @param[in]  aID    IPC Channel ID

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Success
    @retval     #BCM_ERR_INVAL_STATE    IPC driver is already initialized
    @retval     #BCM_ERR_INVAL_PARAMS   Channel number out of range

    @post If successfully initialized, the IPC driver shall move to INIT state

    @trace #BRCM_SWREQ_IPC_DRIVER

    @limitations None
*/
void IPC_Init(IPC_ChannIDType aID);

/** @brief Send IPC message

    This API sends a message through IPC.

    @behavior Sync, Non-reentrant

    @param[in]      aID         IPC Channel ID
    @param[in]      aCmd        Command to be sent
    @param[in]      aMsg        Pointer to message
    @param[in]      aLen        Length of the message

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Success
    @retval     #BCM_ERR_NOMEM          No slots available to send the message
    @retval     #BCM_ERR_UNINIT         IPC is not yet initialized
    @retval     #BCM_ERR_INVAL_PARAMS   Channel number or length out of range
    @retval     #BCM_ERR_INVAL_PARAMS   aMsg is NULL

    @trace #BRCM_SWREQ_IPC_DRIVER

    @limitations None
*/
int32_t IPC_Send(IPC_ChannIDType aID, uint32_t aCmd, uint8_t *aMsg, uint32_t aLen);

/** @brief Receive message

    This API retrieves a message obtained through IPC

    @behavior Sync, Non-reentrant

    @param[in]      aID         IPC Channel ID
    @param[out]     aCmd        Received command number
    @param[out]     aMsg        Pointer to message buffer
    @param[in]      aInLen      Length of the message buffer
    @param[out]     aOutLen     Pointer to length of the received message

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Success
    @retval     #BCM_ERR_NOMEM          No new message available
    @retval     #BCM_ERR_DATA_INTEG     Data integrity failed
    @retval     #BCM_ERR_UNINIT         IPC is not yet initialized
    @retval     #BCM_ERR_INVAL_MAGIC    Invalid Magic Header
    @retval     #BCM_ERR_INVAL_PARAMS   Invalid Parameter

    @trace #BRCM_SWREQ_IPC_DRIVER

    @limitations None
*/
int32_t IPC_Receive(IPC_ChannIDType aID, uint32_t* aCmd, uint8_t *aMsg, uint32_t aInLen, uint32_t *aOutLen);

/** @brief De-initialize IPC driver

    This API deinitializes IPC driver.

    @behavior Sync, Non-reentrant

    @param[in]  aID     IPC Channel ID

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Success
    @retval     #BCM_ERR_UNINIT         IPC driver is not yet initialized
    @retval     #BCM_ERR_INVAL_PARAMS   Channel number out of range

    @post If successfully de-initialized, the IPC driver shall move to UNINIT state

    @trace #BRCM_SWREQ_IPC_DRIVER

    @limitations None
*/
int32_t IPC_DeInit(IPC_ChannIDType aID);

#endif /* IPC_H */
/** @} */
