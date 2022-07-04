/*****************************************************************************
 Copyright 2017-2022 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_host_ipc Host IPC
    @ingroup grp_host

    @addtogroup grp_host_ipc
    @{

    @file rpc_ipc_host.h
    @brief Host IPC API
    This header file contains the host interface functions for IPC

    @version 1.0 Initial Version
*/

#ifndef RPC_IPC_HOST
#define RPC_IPC_HOST

#include <stdint.h>
#include <endian.h>
#include <byteswap.h>

#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
#define uswap16(x)              bswap_16(x)
#define uswap32(x)              bswap_32(x)
#define uswap64(x)              bswap_64(x)
#elif __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
#define uswap16(x)              (x)
#define uswap32(x)              (x)
#define uswap64(x)              (x)
#else
#error "__BYTE_ORDER__ has to be either __ORDER_BIG_ENDIAN__ or __ORDER_LITTLE_ENDIAN__"
#endif

/**
    @name Install
    @{
    @brief Install type
*/
typedef uint32_t RPC_IpcHostInstallType;              /**< @brief Install type              */
#define RPC_IPCHOST_INSTALL_FACTORY    (0x00000001UL) /**< @brief Factory installation      */
#define RPC_IPCHOST_INSTALL_OTA        (0x00000002UL) /**< @brief Over-The-Air installation */
/** @} */

typedef uint32_t RPC_IpcHostInterfaceType;            /**< @brief HIPC interface type      */
#define RPC_IPCHOST_INTERFACE_JLINK    (0UL)          /**< @brief HIPC over JLINK          */
#define RPC_IPCHOST_INTERFACE_PCIE     (1UL)          /**< @brief HIPC over PCIE           */

typedef uint32_t RPC_IPCHOSTChipIdxType;              /**< @brief HIPC chip index type    */
#define RPC_IPCHOST_CHIP_IDX_BCM89571  (0UL)
#define RPC_IPCHOST_CHIP_IDX_BCM89572  (1UL)
#define RPC_IPCHOST_CHIP_IDX_BCM89561  (2UL)
#define RPC_IPCHOST_CHIP_IDX_BCM89564  (3UL)
#define RPC_IPCHOST_CHIP_IDX_MAX       (4UL)

typedef struct sRPC_IpcHostIfcConfigType {
    RPC_IpcHostInterfaceType mode;      /**< @brief HIPC interface mode           */
    uint32_t serial;                    /**< @brief Interface (Segger) serial     */
    uint32_t devId;                     /**< @brief dev instance on interface     */
    RPC_IPCHOSTChipIdxType chip;        /**< @brief Chip index                    */
} RPC_IpcHostIfcConfigType;

/** @brief Send IPC message

    This API is used to send a message through IPC

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      cmd             Command ID of message
    @param[in]      msg             Pointer to message payload
    @param[in]      len             Actual size of msg copied by the API

    @return     #BCM_ERR_OK             IPC message sent successfully
    @return     #BCM_ERR_NOSUPPORT      IPC message's length is not supported
    @return     #BCM_ERR_UNINIT         IPC mechanism is not yet initialised
    @return     #BCM_ERR_NODEV          Target is undergoing a reboot
    @return     #BCM_ERR_BUSY           Target is not ready to accept anymore messages
    @return     #BCM_ERR_NOMEM          All available IPC buffers are used-up

    @post None

    @limitations None
*/
extern int32_t RPC_IpcHostSend(uint32_t cmd, uint8_t *msg, uint32_t len);

/** @brief Receive IPC message

    This API is used to receive an incoming message through IPC

    @behavior Sync, Non Re-entrant

    @pre None

    @param[out]     cmd             Pointer to store the command ID of message
    @param[out]     msg             Pointer to copy the message payload
    @param[in]      len_max         Maximum size of the msg
    @param[out]     len             Actual size of msg copied

    @return     #BCM_ERR_OK             IPC message received successfully
    @return     #BCM_ERR_DATA_INTEG     IPC message's data integrity failed
    @return     #BCM_ERR_NOMEM          IPC message's length is incorrect
    @return     #BCM_ERR_NOT_FOUND      No IPC message available
    @return     #BCM_ERR_UNINIT         IPC mechanism is not yet initialised
    @return     #BCM_ERR_UNKNOWN        Memory access failure

    @post None

    @limitations None
*/
extern int32_t RPC_IpcHostRecv(uint32_t *cmd, uint8_t *msg, uint32_t len_max, uint32_t *len);

/** @brief Initialize Host IPC

    This API is used to initialise Host IPC

    @behavior Sync, Non Re-entrant

    @pre None

    @param  None

    @return     #BCM_ERR_OK         Success
    @return     others              As reported by Peripheral drivers such as
                                    SPI, GPIO, PCIe etc.

    @post None

    @limitations None
*/
extern int32_t RPC_IpcHostInit();

/** @brief Deinitialize Host IPC

    This API is used to deinitialise Host IPC

    @behavior Sync, Non Re-entrant

    @pre None

    @param  None

    @return None

    @post None

    @limitations None
*/
extern void RPC_IpcHostDeinit(void);

/** @brief Query target mode and features

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]  cfg                     HIPC bus configuration

    @return     #BCM_ERR_OK             Success
    @return     #BCM_ERR_NOT_FOUND      Target version is not available
    @return     #BCM_ERR_INVAL_PARAMS   aVersion is NULL

    @post None

    @limitations None
*/
extern int32_t RPC_IpcHostSetConfig(RPC_IpcHostIfcConfigType *aCfg);

#endif /* RPC_IPC_HOST */

/** @} */
