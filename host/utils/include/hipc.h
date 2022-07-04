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

    @file hipc.h
    @brief Host IPC API
    This header file contains the host interface functions for IPC

    @version 1.0 Initial Version
*/

#ifndef HIPC_H
#define HIPC_H

#include <stdint.h>
#include <endian.h>
#include <byteswap.h>
#include <host_system.h>
#include <hipc_plat.h>
#include <system_dmon.h>
#include <mcu.h>

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

typedef struct sHIPC_RdbRegType {
    uint32_t wdtCtrlAddr;
    uint32_t wdtIntClrAddr;
    uint32_t wdtLockAddr;

    uint32_t blDwnldTargetSpareReg;
    uint32_t ipcBufInfoReg;
    uint32_t ipcBufInfo2Reg;
    uint32_t ipcTargetStatReg;
    uint32_t ipcHostStatReg;
    uint32_t cpusysMiscReg;
    uint32_t miscDevIdLo;
    uint32_t miscDevIdHi;
    uint32_t modelRevNum;

    uint16_t miscDevIdLoMask;
    uint16_t miscDevIdHiMask;
    uint16_t miscModelRevNumMask;

    uint32_t addrSerL16;
    uint32_t ctrlSerL16;
    uint32_t dataSerLL16;
    uint32_t dataSerHL16;
} HIPC_RdbRegType;

extern HIPC_RdbRegType HIPC_RdbReg[];

#define HIPC_BL_DWNLD_TARGET_SPARE_REG   (HIPC_RdbReg[HIPC_IfcConfig.chip >> 1].blDwnldTargetSpareReg)
#define HIPC_IPC_BUFF_INFO_REG           (HIPC_RdbReg[HIPC_IfcConfig.chip >> 1].ipcBufInfoReg)
#define HIPC_IPC_BUFF_INFO2_REG          (HIPC_RdbReg[HIPC_IfcConfig.chip >> 1].ipcBufInfo2Reg)
#define HIPC_IPC_TARGET_STAT_REG         (HIPC_RdbReg[HIPC_IfcConfig.chip >> 1].ipcTargetStatReg)
#define HIPC_IPC_HOST_STAT_REG           (HIPC_RdbReg[HIPC_IfcConfig.chip >> 1].ipcHostStatReg)
#define HIPC_CPUSYS_MISC_REG             (HIPC_RdbReg[HIPC_IfcConfig.chip >> 1].cpusysMiscReg)
#define HIPC_MISC_DEVICEID_LO            (HIPC_RdbReg[HIPC_IfcConfig.chip >> 1].miscDevIdLo)
#define HIPC_MISC_DEVICEID_HI            (HIPC_RdbReg[HIPC_IfcConfig.chip >> 1].miscDevIdHi)
#define HIPC_MISC_MODEL_REV_NUM          (HIPC_RdbReg[HIPC_IfcConfig.chip >> 1].modelRevNum)

#define HIPC_DEVICE_ID_LO_MASK           (HIPC_RdbReg[HIPC_IfcConfig.chip >> 1].miscDevIdLoMask)
#define HIPC_DEVICE_ID_HI_MASK           (HIPC_RdbReg[HIPC_IfcConfig.chip >> 1].miscDevIdHiMask)
#define HIPC_MODEL_REV_NUM_MASK          (HIPC_RdbReg[HIPC_IfcConfig.chip >> 1].miscModelRevNumMask)

#define HIPC_CPU_INDIRECT_ADDR_L16_REG   (HIPC_RdbReg[HIPC_IfcConfig.chip >> 1].addrSerL16)
#define HIPC_CPU_INDIRECT_CTRL_L16_REG   (HIPC_RdbReg[HIPC_IfcConfig.chip >> 1].ctrlSerL16)
#define HIPC_CPU_INDIRECT_DATA_L_L16_REG (HIPC_RdbReg[HIPC_IfcConfig.chip >> 1].dataSerLL16)
#define HIPC_CPU_INDIRECT_DATA_H_L16_REG (HIPC_RdbReg[HIPC_IfcConfig.chip >> 1].dataSerHL16)

#define HIPC_WDT_CTRL_ADDR               (HIPC_RdbReg[HIPC_IfcConfig.chip >> 1].wdtCtrlAddr)
#define HIPC_WDT_INTCLR_ADDR             (HIPC_RdbReg[HIPC_IfcConfig.chip >> 1].wdtIntClrAddr)
#define HIPC_WDT_LOCK_ADDR               (HIPC_RdbReg[HIPC_IfcConfig.chip >> 1].wdtLockAddr)

#define BL_CNTRL_MAX_IMG_COUNT              (32UL)
#define BL_IPC_BUFF_INFO_CNT_MASK           (0x000CU)
#define BL_IPC_BUFF_INFO_CNT_SHIFT          (2UL)
#define BL_IPC_BUFF_INFO_SZ_MASK            (0x00F0U)
#define BL_IPC_BUFF_INFO2_BASE_MASK         (0x3FFEU)
#define BL_IPC_BUFF_INFO2_BASE_ALIGN_SHIFT  (19UL)
#define BL_IPC_BUFF_INFO_SZ_SHIFT           (4UL)
#define BL_IPC_BUFF_INFO_BASE_MASK          (0xFF00U)
#define BL_IPC_BUFF_INFO_BASE_ALIGN_SHIFT   (11UL)
#define BL_IPC_BUFF_INFO_BASE_SHIFT         (8UL)
#define BL_IPC_BUFF_INFO2_BASE_SHIFT        (1UL)

/* TODO: replace MISC_CPUSYS_MISC_SOFT_INTR_MASK in c file itself */
#define MISC_CPUSYS_MISC_SOFT_INTR_MASK (1U)

#define IPC_MAX_PTR_MASK                (0xFU)
#define IPC_BUFF_INFO_BASE_ALIGN_SHIFT  (11UL)
#define IPC_BUFF_INFO2_BASE_ALIGN_SHIFT (19UL)
#define IPC_INTR_NUM                    (7UL)

#define IPC_BUFF_INFO_BASE_SHIFT        (8UL)
#define IPC_BUFF_INFO_BASE_MASK         (0xFF00U)
#define IPC_BUFF_INFO_SZ_SHIFT          (4UL)
#define IPC_BUFF_INFO_SZ_MASK           (0x00F0U)
#define IPC_BUFF_INFO_CNT_SHIFT         (2UL)
#define IPC_BUFF_INFO_CNT_MASK          (0x000CU)
#define IPC_BUFF_INFO_RSVD_SHIFT        (1UL)
#define IPC_BUFF_INFO_RSVD_MASK         (0x0002U)
#define IPC_BUFF_INFO_PAR_SHIFT         (0UL)
#define IPC_BUFF_INFO_PAR_MASK          (0x0001U)

#define IPC_TARGET_STAT_RSVD_SHIFT      (11UL)
#define IPC_TARGET_STAT_RSVD_MASK       (0xF100U)
#define IPC_TARGET_STAT_PRI_SHIFT       (8UL)
#define IPC_TARGET_STAT_PRI_MASK        (0x0700U)
#define IPC_TARGET_STAT_PRI_REBOOT      (7U)
#define IPC_TARGET_STAT_PRI_6           (6U)
#define IPC_TARGET_STAT_PRI_5           (5U)
#define IPC_TARGET_STAT_PRI_4           (4U)
#define IPC_TARGET_STAT_PRI_3           (3U)
#define IPC_TARGET_STAT_PRI_2           (2U)
#define IPC_TARGET_STAT_PRI_1           (1U)
#define IPC_TARGET_STAT_PRI_PAUSE       (0U)
#define IPC_TARGET_STAT_WR_SHIFT        (4UL)
#define IPC_TARGET_STAT_WR_MASK         (IPC_MAX_PTR_MASK << IPC_TARGET_STAT_WR_SHIFT)
#define IPC_TARGET_STAT_RD_SHIFT        (0UL)
#define IPC_TARGET_STAT_RD_MASK         (IPC_MAX_PTR_MASK << IPC_TARGET_STAT_RD_SHIFT)

#define IPC_HOST_STAT_RSVD_SHIFT        (8UL)
#define IPC_HOST_STAT_RSVD_MASK         (0xFF00U)
#define IPC_HOST_STAT_WR_SHIFT          (4UL)
#define IPC_HOST_STAT_WR_MASK           (IPC_MAX_PTR_MASK << IPC_HOST_STAT_WR_SHIFT)
#define IPC_HOST_STAT_RD_SHIFT          (0UL)
#define IPC_HOST_STAT_RD_MASK           (IPC_MAX_PTR_MASK << IPC_HOST_STAT_RD_SHIFT)

#define IPC_COMMAND_MAGIC               (0xa5a5a5a5UL)
#define IPC_REPLY_MAGIC                 (0x5a5a5a5aUL)

#define IPC_HDR_MAGIC_INDEX             (0UL)
#define IPC_HDR_CHKSUM_INDEX            (1UL)
#define IPC_HDR_COMMAND_INDEX           (2UL)
#define IPC_HDR_LENGTH_INDEX            (3UL)
#define IPC_HDR_LAST_INDEX              (4UL)

/**
    @name Install
    @{
    @brief Install type
*/
typedef uint32_t HIPC_InstallType;             /**< @brief Install type              */
#define HIPC_INSTALL_FACTORY    (0x00000001UL) /**< @brief Factory installation      */
#define HIPC_INSTALL_OTA        (0x00000002UL) /**< @brief Over-The-Air installation */
/** @} */

typedef uint32_t HIPC_InterfaceModeType;            /**< @brief HIPC interface type     */
#define HIPC_INTERFACE_MODE_JLINK    (1UL)          /**< @brief HIPC over JLINK         */
#define HIPC_INTERFACE_MODE_PCIE     (2UL)          /**< @brief HIPC over PCIE          */
#define HIPC_INTERFACE_MODE_SPI      (3UL)          /**< @brief HIPC over SPI           */

typedef uint32_t HIPC_ChipIdxType;                  /**< @brief HIPC chip index type    */
#define HIPC_CHIP_IDX_BCM89571       (0UL)
#define HIPC_CHIP_IDX_BCM89572       (1UL)
#define HIPC_CHIP_IDX_BCM89561       (2UL)
#define HIPC_CHIP_IDX_BCM89564       (3UL)

typedef struct sHIPC_IfcConfigType {
    HIPC_InterfaceModeType mode;        /**< @brief HIPC interface mode           */
    uint32_t serial;                    /**< @brief Interface (Segger) serial     */
    uint32_t devId;                     /**< @brief dev instance on interface     */
    HIPC_ChipIdxType chip;              /**< @brief Chip index                    */
} HIPC_IfcConfigType;

extern HIPC_IfcConfigType HIPC_IfcConfig;

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
extern int32_t HIPC_Send(uint32_t cmd, uint8_t *msg, uint32_t len);

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
extern int32_t HIPC_Recv(uint32_t *cmd, uint8_t *msg, uint32_t len_max, uint32_t *len);

/** @brief Check if the target is ready

    This API would check the target if its ready to receive IPC messages.

    @behavior Sync, Non Re-entrant

    @pre None

    @param None

    @return     0UL    Target is not ready
    @return     Others Target is ready

    @post None

    @limitations None
*/
extern uint32_t HIPC_IsTargetReady(void);

/** @brief Send a command and receive its response

    This API is used to send a command to target and receive a response to the
    same command

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      id              Command ID of message
    @param[in]      cmd             Pointer to command message payload
    @param[in]      cmd_len         Size of command message payload
    @param[out]     reply           Pointer to copy response payload
    @param[in]      reply_len_max   Maximum size of reponse payload
    @param[out]     reply_len_act   Actual size of reponse payload copied

    @return     #BCM_ERR_OK             IPC message received successfully
    @return     #BCM_ERR_DATA_INTEG     IPC message's data integrity failed
    @return     #BCM_ERR_NOMEM          IPC message's length is incorrect
    @return     #BCM_ERR_NOT_FOUND      No IPC message available
    @return     #BCM_ERR_UNINIT         IPC mechanism is not yet initialised
    @return     #BCM_ERR_UNKNOWN        Memory access failure

    @post None

    @limitations None
*/
extern int32_t HIPC_SendRecv(uint32_t id, uint8_t *cmd, uint32_t cmd_len,
            uint8_t *reply, uint32_t reply_len_max, uint32_t *reply_len_act);

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
extern int32_t HIPC_Init();

/** @brief Deinitialize Host IPC

    This API is used to deinitialise Host IPC

    @behavior Sync, Non Re-entrant

    @pre None

    @param  None

    @return None

    @post None

    @limitations None
*/
extern void HIPC_Deinit(void);

/** @brief Queue an asynchronous message

    This API is used to queue asynchronous message to the server. This is a
    call-back to be implemented by server.

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      currentSlave    Slave ID
    @param[in]      replyId         Reply ID of the message
    @param[in]      reply           Pointer to message payload
    @param[in]      replyLen        Size of the message payload

    @return     #BCM_ERR_OK             Message queued successfully
    @return     #BCM_ERR_INVAL_PARAMS   Invalid replyId
    @return     #BCM_ERR_INVAL_PARAMS   reply is NULL

    @post None

    @limitations None
*/
extern int32_t IPC_QueueAsyncMsg(uint32_t currentSlave, uint32_t replyId, uint8_t *reply, uint32_t replyLen);

/** @brief Get Active Slaves

    This API is used to get all active slave IDs

    @behavior Sync, Non Re-entrant

    @pre None

    @param[out]     id          Pointer to an array of IDs to be filled
    @param[inout]   count       Input: Maximum number of IDs that can be filled
                                Output: Actual number of valid IDs filled in the array

    @return     #BCM_ERR_OK             Active slave IDs fetched successfully
    @return     #BCM_ERR_INVAL_PARAMS   id is NULL
    @return     #BCM_ERR_INVAL_PARAMS   count is NULL

    @post None

    @limitations None
*/
extern int32_t HIPC_GetActiveSlaves(uint32_t *id, uint32_t *count);

/** @brief Is stacked

    This API is used to identify is the board is a stacked board

    @behavior Sync, Non Re-entrant

    @pre None

    @param      None

    @return     #TRUE       Is a stacked board
    @return     #FALSE      Is not a stacked board

    @post None

    @limitations None
*/
extern int32_t HIPC_IsStacked(void);

/** @brief Set Slave ID

    This API is used to set the current active slave ID

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      id          ID of slave

    @return     #BCM_ERR_OK             ID set successfully
    @return     #BCM_ERR_INVAL_PARAMS   Invalid id value

    @post None

    @limitations None
*/
extern int32_t HIPC_SetSlave(uint32_t id);

/** @brief Get Slave ID

    This API is used to get the current active slave ID

    @behavior Sync, Non Re-entrant

    @pre None

    @param[out]     id          ID of slave

    @return     #BCM_ERR_OK             ID fetch successful
    @return     #BCM_ERR_INVAL_PARAMS   Invalid id pointer

    @post None

    @limitations None
*/
extern int32_t HIPC_GetSlave(uint32_t *id);

/** @brief Set the bus connection mode

    This API sets the connection mode of the slave

    @behavior Sync, Non Re-entrant

    @pre None

    @param[out]     mode        Mode of the slave bus

    @return     #BCM_ERR_OK             set was successful
    @return     #BCM_ERR_INVAL_PARAMS   Invalid id pointer

    @post None

    @limitations None
*/
extern int32_t HIPC_SetConnMode(mgmt_connection_t mode);

/** @brief Get the bus connection mode

    This API gets the connection mode of the slave

    @behavior Sync, Non Re-entrant

    @pre None

    @param      None

    @return     mgmt_connection_t   Current connection mode

    @post None

    @limitations None
*/
extern mgmt_connection_t HIPC_GetConnMode(void);

/** @brief Probe Slaves

    This API is used to probe active slave devices connected to the host

    @behavior Sync, Non Re-entrant

    @pre None

    @param None

    @return None

    @post None

    @limitations None
*/
extern void HIPC_ProbeSlaves();

/** @brief Ping target

    This API is used to ping target and get it's mode and features

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      info            Pointer to #MgmtInfoType handle

    @return     #BCM_ERR_INVAL_PARAMS   Invalid info pointer
    @return     #BCM_ERR_INVAL_PARAMS   Invalid mode pointer
    @return     #BCM_ERR_INVAL_PARAMS   Invalid targetFeatures pointer
    @return     #BCM_ERR_INVAL_PARAMS   Invalid config
    @return     #BCM_ERR_UNKNOWN        Error reported by target

    @post None

    @limitations None
*/
extern int32_t HIPC_Ping(MgmtInfoType *info, uint32_t *const mode, uint32_t * const targetFeatures);

/** @brief Reboot target chip

    This API is used to reboot target chip. This would reset the CPU, memories,
    peripherals and spare registers.

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      info            Pointer to #MgmtInfoType handle

    @return     #BCM_ERR_OK         Success
    @return     #BCM_ERR_UNKNOWN    Target Memory access errors
    @return     others              Errors reported by HIPC_SendRecv

    @post None

    @limitations None
*/
extern int32_t HIPC_Reboot(MgmtInfoType *info);

/** @brief Execute on target

    This API is used to execute a specific binary on target

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      info            Pointer to #MgmtInfoType handle
    @param[in]      mode            Mode of installation
    @param[in]      tarImage        Pointer to tar image

    @return     #BCM_ERR_OK             Success
    @return     #BCM_ERR_INVAL_PARAMS   Size is 0
    @return     #BCM_ERR_INVAL_PARAMS   image is NULL
    @return     #BCM_ERR_INVAL_PARAMS   info is NULL
    @return     #BCM_ERR_UNKNOWN        Target Memory access errors
    @return     others                  Errors reported by HIPC_SendRecv

    @post None

    @limitations None
*/
extern int32_t HIPC_ExecuteOnTarget(MgmtInfoType *info, HIPC_InstallType mode, const uint8_t* tarImage);

/** @brief Generate Frame-Sync Pulse

    This API is used to generate a frame sync pulse to target

    @behavior Sync, Non Re-entrant

    @pre None

    @param none

    @return none

    @post None

    @limitations None
*/
extern void HIPC_GenerateFrameSyncPulse(void);

/** @brief Query target mode and features

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      info            Pointer to #MgmtInfoType handle
    @param[out]     targetBootMode  Boot mode of target
    @param[out]     targetFeatures  Features supported by target

    @return     #BCM_ERR_OK             Success
    @return     #BCM_ERR_UNKNOWN        Target Memory access errors
    @return     #BCM_ERR_INVAL_PARAMS   targetBootMode is NULL or targetFeatures is NULL

    @post None

    @limitations None
*/
extern int32_t HIPC_GetTargetSWMode(MgmtInfoType *info,
                                    BCM_BootModeType *const targetBootMode,
                                    HIPC_TargetFeatureType *const targetFeatures);


/** @brief Query target mode and features

    @behavior Sync, Non Re-entrant

    @pre None

    @param[out]      aVersion            Pointer to #MCU_VersionType

    @return     #BCM_ERR_OK             Success
    @return     #BCM_ERR_NOT_FOUND      Target version is not available
    @return     #BCM_ERR_INVAL_PARAMS   aVersion is NULL

    @post None

    @limitations None
*/
extern int32_t HIPC_GetMcuVersion(MCU_VersionType *aVersion);

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
extern int32_t HIPC_SetConfig(HIPC_IfcConfigType cfg);
#endif /* HIPC_H */

/** @} */
