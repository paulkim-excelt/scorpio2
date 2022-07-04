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

    @defgroup grp_host_ipc_plat Platform specific Host IPC
    @ingroup grp_host_ipc

    @addtogroup grp_host_ipc_plat
    @{

    @file rpc_ipc_host_plat.h
    @brief Platform specific Host IPC API
    This header file contains the host interface functions for IPC specific to
    target platform

    @version 1.0 Initial Version
*/

#ifndef RPC_IPC_HOST_PLAT_H
#define RPC_IPC_HOST_PLAT_H

#include <rpc_ipc_host.h>

/**
    @name Target Features
    @{
    @brief Target feature bit masks
*/
typedef uint32_t RPC_IpcHostTargetFeatureType;                     /**< @brief Target Feature type */
#define RPC_IPCHOSTTARGETFEATURE_SELFREBOOT         (0x00000001UL) /**< @brief Support Self-Reboot */
#define RPC_IPCHOSTTARGETFEATURE_RESTRICTEDACCESS   (0x00000002UL) /**< @brief Restricts register accesses to limited set */
#define RPC_IPCHOSTTARGETFEATURE_IMGHDRSIGNATURE    (0x00000004UL) /**< @brief ROM supports signature along with Image Header */
#define RPC_IPCHOSTTARGETFEATURE_FETCHIMG           (0x00000008UL) /**< @brief ROM fetches required images on its own */
/** @} */

/**
    @brief Platform specific RDB exposed registers
*/
typedef struct RPC_IpcHostRdbRegType {
    uint32_t wdtCtrlAddr;
    uint32_t wdtIntClrAddr;
    uint32_t wdtLockAddr;
    uint32_t blDwnldTargetSpareReg;
    uint32_t ipcBufInfoReg;
    uint32_t ipcBufInfo2Reg;
    uint32_t ipcTargetStatReg;
    uint32_t ipcHostStatReg;
    uint32_t cpusysMiscReg;
} RPC_IpcHostRdbRegType;

extern const RPC_IpcHostRdbRegType RPC_IpcHostRdbReg[];
extern RPC_IpcHostIfcConfigType RPC_IpcHostIfcConfig;

/**
    @brief Macros to access the platform specific RDB registers
*/
#define RPC_IPCHOST_BL_DWNLD_TARGET_SPARE_REG   (RPC_IpcHostRdbReg[RPC_IpcHostIfcConfig.chip >> 1].blDwnldTargetSpareReg)
#define RPC_IPCHOST_IPC_BUFF_INFO_REG           (RPC_IpcHostRdbReg[RPC_IpcHostIfcConfig.chip >> 1].ipcBufInfoReg)
#define RPC_IPCHOST_IPC_BUFF_INFO2_REG          (RPC_IpcHostRdbReg[RPC_IpcHostIfcConfig.chip >> 1].ipcBufInfo2Reg)
#define RPC_IPCHOST_TARGET_STAT_REG             (RPC_IpcHostRdbReg[RPC_IpcHostIfcConfig.chip >> 1].ipcTargetStatReg)
#define RPC_IPCHOST_HOST_STAT_REG               (RPC_IpcHostRdbReg[RPC_IpcHostIfcConfig.chip >> 1].ipcHostStatReg)
#define RPC_IPCHOST_CPUSYS_MISC_REG             (RPC_IpcHostRdbReg[RPC_IpcHostIfcConfig.chip >> 1].cpusysMiscReg)
#define RPC_IPCHOST_WDT_CTRL_ADDR               (RPC_IpcHostRdbReg[RPC_IpcHostIfcConfig.chip >> 1].wdtCtrlAddr)
#define RPC_IPCHOST_WDT_INTCLR_ADDR             (RPC_IpcHostRdbReg[RPC_IpcHostIfcConfig.chip >> 1].wdtIntClrAddr)
#define RPC_IPCHOST_WDT_LOCK_ADDR               (RPC_IpcHostRdbReg[RPC_IpcHostIfcConfig.chip >> 1].wdtLockAddr)

/**
    @brief Other Macros for register access
*/
#define RPC_IPCHOST_RPC_IPCHOST_BUFF_INFO_CNT_MASK           (0x000CU)
#define RPC_IPCHOST_RPC_IPCHOST_BUFF_INFO_CNT_SHIFT          (2UL)
#define RPC_IPCHOST_RPC_IPCHOST_BUFF_INFO_SZ_MASK            (0x00F0U)
#define RPC_IPCHOST_IPC_BUFF_INFO2_BASE_MASK                 (0x3FFEU)
#define RPC_IPCHOST_RPC_IPCHOST_BUFF_INFO2_BASE_ALIGN_SHIFT  (19UL)
#define RPC_IPCHOST_RPC_IPCHOST_BUFF_INFO_SZ_SHIFT           (4UL)
#define RPC_IPCHOST_RPC_IPCHOST_BUFF_INFO_BASE_MASK          (0xFF00U)
#define RPC_IPCHOST_RPC_IPCHOST_BUFF_INFO_BASE_ALIGN_SHIFT   (11UL)
#define RPC_IPCHOST_RPC_IPCHOST_BUFF_INFO_BASE_SHIFT         (8UL)
#define RPC_IPCHOST_IPC_BUFF_INFO2_BASE_SHIFT                (1UL)

#define RPC_IPCHOST_MAX_PTR_MASK                    (0xFU)
#define RPC_IPCHOST_BUFF_INFO_BASE_ALIGN_SHIFT      (11UL)
#define RPC_IPCHOST_BUFF_INFO2_BASE_ALIGN_SHIFT     (19UL)
#define RPC_IPCHOST_INTR_NUM                        (7UL)
#define RPC_IPCHOST_BL_IPC_DWNLD_BL_READY_MASK      (0x0001U)
#define RPC_IPCHOST_BUFF_INFO_BASE_SHIFT            (8UL)
#define RPC_IPCHOST_BUFF_INFO_BASE_MASK             (0xFF00U)
#define RPC_IPCHOST_BUFF_INFO_SZ_SHIFT              (4UL)
#define RPC_IPCHOST_BUFF_INFO_SZ_MASK               (0x00F0U)
#define RPC_IPCHOST_BUFF_INFO_CNT_SHIFT             (2UL)
#define RPC_IPCHOST_BUFF_INFO_CNT_MASK              (0x000CU)
#define RPC_IPCHOST_BUFF_INFO_RSVD_SHIFT            (1UL)
#define RPC_IPCHOST_BUFF_INFO_RSVD_MASK             (0x0002U)
#define RPC_IPCHOST_BUFF_INFO_PAR_SHIFT             (0UL)
#define RPC_IPCHOST_BUFF_INFO_PAR_MASK              (0x0001U)

#define RPC_IPCHOST_TARGET_STAT_RSVD_SHIFT          (11UL)
#define RPC_IPCHOST_TARGET_STAT_RSVD_MASK           (0xF100U)
#define RPC_IPCHOST_TARGET_STAT_PRI_SHIFT           (8UL)
#define RPC_IPCHOST_TARGET_STAT_PRI_MASK            (0x0700U)
#define RPC_IPCHOST_TARGET_STAT_PRI_REBOOT          (7U)
#define RPC_IPCHOST_TARGET_STAT_PRI_6               (6U)
#define RPC_IPCHOST_TARGET_STAT_PRI_5               (5U)
#define RPC_IPCHOST_TARGET_STAT_PRI_4               (4U)
#define RPC_IPCHOST_TARGET_STAT_PRI_3               (3U)
#define RPC_IPCHOST_TARGET_STAT_PRI_2               (2U)
#define RPC_IPCHOST_TARGET_STAT_PRI_1               (1U)
#define RPC_IPCHOST_TARGET_STAT_PRI_PAUSE           (0U)
#define RPC_IPCHOST_TARGET_STAT_WR_SHIFT            (4UL)
#define RPC_IPCHOST_TARGET_STAT_WR_MASK             (RPC_IPCHOST_MAX_PTR_MASK << RPC_IPCHOST_TARGET_STAT_WR_SHIFT)
#define RPC_IPCHOST_TARGET_STAT_RD_SHIFT            (0UL)
#define RPC_IPCHOST_TARGET_STAT_RD_MASK             (RPC_IPCHOST_MAX_PTR_MASK << RPC_IPCHOST_TARGET_STAT_RD_SHIFT)

#define RPC_IPCHOST_HOST_STAT_RSVD_SHIFT            (8UL)
#define RPC_IPCHOST_HOST_STAT_RSVD_MASK             (0xFF00U)
#define RPC_IPCHOST_HOST_STAT_WR_SHIFT              (4UL)
#define RPC_IPCHOST_HOST_STAT_WR_MASK               (RPC_IPCHOST_MAX_PTR_MASK << RPC_IPCHOST_HOST_STAT_WR_SHIFT)
#define RPC_IPCHOST_HOST_STAT_RD_SHIFT              (0UL)
#define RPC_IPCHOST_HOST_STAT_RD_MASK               (RPC_IPCHOST_MAX_PTR_MASK << RPC_IPCHOST_HOST_STAT_RD_SHIFT)

#define RPC_IPCHOST_COMMAND_MAGIC                   (0xa5a5a5a5UL)
#define RPC_IPCHOST_REPLY_MAGIC                     (0x5a5a5a5aUL)

#define RPC_IPCHOST_HDR_MAGIC_INDEX                 (0UL)
#define RPC_IPCHOST_HDR_CHKSUM_INDEX                (1UL)
#define RPC_IPCHOST_HDR_COMMAND_INDEX               (2UL)
#define RPC_IPCHOST_HDR_LENGTH_INDEX                (3UL)
#define RPC_IPCHOST_HDR_LAST_INDEX                  (4UL)

/** @brief Notify Target

    This API is used to notify the target of a new IPC/event to be processed

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      slaveId         Slave ID

    @return     none

    @post None

    @limitations None
*/
extern void RPC_IpcHostPlatNotifyTarget(uint32_t slaveId);

/** @brief Get Buffer information

    This API is used to obtain IPC buffer information from target

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      slaveId         Slave ID
    @param[in]      buff            Pointer to buffer
    @param[in]      cnt             Number of buffers
    @param[in]      cntRollOverMask Mask of virtual index
    @param[in]      sz              Size of buffers

    @return     #BCM_ERR_OK             Success
    @return     #BCM_ERR_UNINIT         IPC is uninitialised

    @post None

    @limitations None
*/
extern int32_t RPC_IpcHostPlatGetBuff(uint32_t slaveId, uint8_t **buff, uint16_t *cnt,
                                      uint8_t *cntRollOverMask, uint16_t *sz);

#endif /* RPC_IPC_HOST_PLAT_H */

/** @} */

