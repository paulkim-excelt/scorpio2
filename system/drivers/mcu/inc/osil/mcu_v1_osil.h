/*****************************************************************************
 Copyright 2019-2020 Broadcom Limited.  All rights reserved.

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
    @addtogroup grp_mcudrv_il
    @{

    @file mcu_v1_osil.h
    @brief MCU Driver End point Integration Interface
    This header file contains MCU Driver End point Integration Interface

    @version 0.86 Imported from docx
*/
#ifndef MCU_V1_OSIL_H
#define MCU_V1_OSIL_H

#include <inttypes.h>
#include <mcu.h>
#include <mcu_hs_ext.h>

/**
    @name MCU end point Integration Interface IDs
    @{
    @brief End point Integration Interface IDs for MCU Driver
*/
#define BRCM_SWARCH_MCU_CMD_TYPE    (0x9101U)    /**< @brief #MCU_CmdType */
#define BRCM_SWARCH_MCU_IO_TYPE     (0x9102U)    /**< @brief #MCU_IOType  */
/** @} */

/**
    @name MCU command type
    @{
    @brief MCU Driver SVC commands. This command types are used by integration
    layer to post system command request to MCU driver (for details refer to #MCU_SysCmdReq)

    @trace #BRCM_SWREQ_MCU_KERNEL_INTERFACE
*/
typedef uint32_t MCU_CmdType;               /**< @brief typedef for MCU command */
#define MCU_CMD_RESET_REQ           (0x1UL) /**< @brief Reset request command */
#define MCU_CMD_GET_RESET_REASON    (0x2UL) /**< @brief Get reset reason command */
#define MCU_CMD_GET_RAW_VAL         (0x3UL) /**< @brief Get reset reason raw value command */
#define MCU_CMD_SET_LPM_MODE        (0x4UL) /**< @brief Set MCU LPM mode command */
#define MCU_CMD_SET_DHS_SRC         (0x5UL) /**< @brief Set Display handshake source mode command */
#define MCU_CMD_DHS_TRIGGER         (0x6UL) /**< @brief Trigger display handshake command */
#define MCU_CMD_GET_VERSION         (0x7UL) /**< @brief Get MCU version command */
#define MCU_CMD_GET_RESET_MODE      (0x8UL) /**< @brief Get Reset Mode command */
#define MCU_CMD_SET_RESET_MODE      (0x9UL) /**< @brief Set Reset Mode command */
#define MCU_CMD_GET_FW_BOOT_INFO    (0xAUL) /**< @brief Get MCU Firmware Boot Information */
#define MCU_CMD_ADJUST_CLK          (0xBUL) /**< @brief Adjust clock frequency */
#define MCU_CMD_GET_BOOT_TIME       (0xCUL) /**< @brief Get boot time info */
#define MCU_CMD_SET_INFO            (0xDUL) /**< @brief Set MCU Info */
#define MCU_CMD_SET_SECURITY_MODE   (0xEUL) /**< @brief Set Security Mode */
/** @} */

/**
    @brief MCU IO structure

    @trace #BRCM_SWREQ_MCU_KERNEL_INTERFACE
*/
typedef struct sMCU_IOType {
    int32_t retVal;                  /**< @brief Error return from MCU command handler */
    MCU_ResetReqType resetReq;       /**< @brief Reset request */
    MCU_ResetModeType resetMode;     /**< @brief Reset mode */
    MCU_ResetReasonType resetReason; /**< @brief Reset reason */
    uint32_t resetRaw;               /**< @brief Reset raw value */
    MCU_LpmModeType lpmMode;         /**< @brief Low power mode */
    MCU_CpuDHSChType channel;        /**< @brief DHS channel ID */
    MCU_CpuDHSIDType srcID;          /**< @brief DHS source channel ID */
    uint32_t bufAttr;                /**< @brief DHS buffer attribute */
    PTBL_IdType     pid;             /**< @brief Partition ID           */
    uint8_t         flsId;           /**< @brief Flash ID               */
    MCU_VersionType *version;        /**< @brief MCU version */
    MCU_ClkCfgIDType clkCfgID;       /**< @brief Clock configuration ID */
    int32_t correction;              /**< @brief Frequency correction */
    MCU_BootTimeInfoType *bootTime;  /**< @brief Boot time information */
    MCU_InfoType *info;  /**< @brief Holds switch/stacking Information*/
    MCU_SecurityModeType securityMode; /**< @brief Security Mode */
} MCU_IOType;

#endif /* MCU_V1_OSIL_H */
/** @} */
