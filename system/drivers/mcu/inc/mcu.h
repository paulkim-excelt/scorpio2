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
    @defgroup grp_mcudrv_ifc MCU Interface
    @ingroup grp_mcudrv

    @addtogroup grp_mcudrv_ifc
    @{

    @section sec_mcu_fsm State Machine
    @image html mcu_state_machine.jpg "MCU state diagram"
    - #MCU_STATE_UNINIT: MCU uninitialized state (This is the reset state when #MCU_Init is not called).
    Only #MCU_Init shall be called in this state to initialize the MCU. All other APIs has no effect and does not do
    anything in this state.
    - #MCU_STATE_INIT: This is initialized state. MCU enters into this state after #MCU_Init is called and
    MCU is initialized successfully.

    @section sec_mcu_seq Sequence Diagrams

    @subsection subsec1_mcu_seq MCU Initialization
    @image html mcu_seq_diagram_init.jpg "MCU initialization"

    @subsection subsec2_mcu_seq MCU Reset
    @image html mcu_seq_diagram_reset.jpg "MCU Reset"

    @section sec_mcu_perf Performance & Memory

    | Performance       | Description                                       |
    |:-----------------:|:-------------------------------------------------:|
    | CPU Load          |   NA                                              |
    | Memory Bandwidth  |   NA                                              |
    | HW Utilization    |   NA                                              |

    @includedoc drivers_mcu.dep

    @limitations None

    @file mcu.h
    @brief MCU interface
    This header file contains the interface functions for MCU

    @version 0.86 Imported from docx
*/

#ifndef MCU_H
#define MCU_H

#include <stddef.h>
#include <inttypes.h>
#include <pt_utils.h>

/**
    @name MCU API IDs
    @{
    @brief API IDs for MCU
*/
#define BRCM_SWARCH_MCU_INSTANCE_ID_MACRO             (0x8701U)    /**< @brief #MCU_INSTANCE_ID             */
#define BRCM_SWARCH_MCU_STATE_TYPE                    (0x8702U)    /**< @brief #MCU_StateType               */
#define BRCM_SWARCH_MCU_RESETREASON_TYPE              (0x8703U)    /**< @brief #MCU_ResetReasonType         */
#define BRCM_SWARCH_MCU_RESETMODE_TYPE                (0x8704U)    /**< @brief #MCU_ResetModeType           */
#define BRCM_SWARCH_MCU_RESETREQ_TYPE                 (0x8705U)    /**< @brief #MCU_ResetReqType            */
#define BRCM_SWARCH_MCU_LPMMODE_TYPE                  (0x8706U)    /**< @brief #MCU_LpmModeType             */
#define BRCM_SWARCH_MCU_PLLSTATUS_TYPE                (0x8707U)    /**< @brief #MCU_PllStatusType           */
#define BRCM_SWARCH_MCU_RAMSECTIONID_TYPE             (0x8708U)    /**< @brief #MCU_RamSectionIDType        */
#define BRCM_SWARCH_MCU_CLKID_TYPE                    (0x8709U)    /**< @brief #MCU_ClkIDType               */
#define BRCM_SWARCH_MCU_CLKCFGID_TYPE                 (0x870AU)    /**< @brief #MCU_ClkCfgIDType            */
#define BRCM_SWARCH_MCU_VERSION_TYPE                  (0x870BU)    /**< @brief #MCU_VersionType             */
#define BRCM_SWARCH_MCU_CLKREF_TYPE                   (0x870CU)    /**< @brief #MCU_ClkRefType              */
#define BRCM_SWARCH_MCU_CLKCFG_TYPE                   (0x870DU)    /**< @brief #MCU_ClkCfgType              */
#define BRCM_SWARCH_MCU_RAMSECCFG_TYPE                (0x870EU)    /**< @brief #MCU_RamSecCfgType           */
#define BRCM_SWARCH_MCU_CONFIG_TYPE                   (0x870FU)    /**< @brief #MCU_ConfigType              */
#define BRCM_SWARCH_MCU_INIT_PROC                     (0x8710U)    /**< @brief #MCU_Init                    */
#define BRCM_SWARCH_MCU_CLKINIT_PROC                  (0x8711U)    /**< @brief #MCU_ClkInit                 */
#define BRCM_SWARCH_MCU_RAMSECTIONINIT_PROC           (0x8712U)    /**< @brief #MCU_RamSectionInit          */
#define BRCM_SWARCH_MCU_RESETREQ_PROC                 (0x8713U)    /**< @brief #MCU_ResetReq                */
#define BRCM_SWARCH_MCU_GETRESETREASON_PROC           (0x8714U)    /**< @brief #MCU_GetResetReason          */
#define BRCM_SWARCH_MCU_GETRESETRAWVALUE_PROC         (0x8715U)    /**< @brief #MCU_GetResetRawValue        */
#define BRCM_SWARCH_MCU_GETPLLSTATUS_PROC             (0x8716U)    /**< @brief #MCU_GetPllStatus            */
#define BRCM_SWARCH_MCU_ACTIVATEPLLCLOCKS_PROC        (0x8717U)    /**< @brief #MCU_ActivatePllClocks       */
#define BRCM_SWARCH_MCU_SETLPMMODE_PROC               (0x8718U)    /**< @brief #MCU_SetLpmMode              */
#define BRCM_SWARCH_MCU_GETVERSION_PROC               (0x8719U)    /**< @brief #MCU_GetVersion              */
#define BRCM_SWARCH_MCU_GETRESETMODE_PROC             (0x871AU)    /**< @brief #MCU_GetResetMode            */
#define BRCM_SWARCH_MCU_SETRESETMODE_PROC             (0x871BU)    /**< @brief #MCU_SetResetMode            */
#define BRCM_SWARCH_MCU_GETCLKFREQ_PROC               (0x871CU)    /**< @brief #MCU_GetClkFreq              */
#define BRCM_SWARCH_MCU_ADJUSTCLKFREQ_PROC            (0x871DU)    /**< @brief #MCU_AdjustClkFreq           */
#define BRCM_SWARCH_MCU_CLOCK_CNTRL_DATA_LEN_MACRO    (0x871EU)    /**< @brief #MCU_CLOCK_CNTRL_DATA_LEN    */
#define BRCM_SWARCH_MCU_CLK_SRC_NOTIFICATION_MACRO    (0x871FU)    /**< @brief #MCU_CLK_SRC_NOTIFICATION_EN */
#define BRCM_SWARCH_MCU_GETDWNLDMODE_PROC             (0x8720U)    /**< @brief #MCU_GetDwnldMode            */
#define BRCM_SWARCH_MCU_GETDEFAULTRESETMODE_PROC      (0x8721U)    /**< @brief #MCU_GetDefaultResetMode     */
#define BRCM_SWARCH_MCU_BOOT_INFO_TYPE                (0x8722U)    /**< @brief #MCU_BootInfoType            */
#define BRCM_SWARCH_MCU_RESET_INFO_TYPE               (0x8723U)    /**< @brief #MCU_ResetInfoType           */
#define BRCM_SWARCH_MCU_GETBLBOOTINFO_PROC            (0x8724U)    /**< @brief #MCU_GetBLBootInfo           */
#define BRCM_SWARCH_MCU_GETBOOTINFO_PROC              (0x8725U)    /**< @brief #MCU_GetBootInfo             */
#define BRCM_SWARCH_MCU_SETBOOTINFO_PROC              (0x8726U)    /**< @brief #MCU_SetBootInfo             */
#define BRCM_SWARCH_MCU_DWNLD_MODE_TYPE               (0x8727U)    /**< @brief #MCU_DwnldModeType           */
#define BRCM_SWARCH_MCU_DEVICE_TYPE                   (0x8728U)    /**< @brief #MCU_DeviceType              */
#define BRCM_SWARCH_MCU_BOOTTIME_INFO_TYPE            (0x8729U)    /**< @brief #MCU_BootTimeInfoType        */
#define BRCM_SWARCH_MCU_GETBOOTTIMEINFO_PROC          (0x872AU)    /**< @brief #MCU_GetBootTimeInfo         */
#define BRCM_SWARCH_MCU_SETBOOTTIMEINFO_PROC          (0x872BU)    /**< @brief #MCU_SetBootTimeInfo         */
#define BRCM_SWARCH_MCU_CHIP_VERSION_MACRO            (0x872CU)    /**< @brief #MCU_CHIP_VERSION_A0         */
#define BRCM_SWARCH_MCU_DRV_GETVERSION_PROC           (0x872DU)    /**< @brief #MCU_DrvGetVersion           */
#define BRCM_SWARCH_MCU_INFO_TYPE                     (0x872EU)    /**< @brief #MCU_InfoType                */
#define BRCM_SWARCH_MCU_GET_INFO_PROC                 (0x872FU)    /**< @brief #MCU_GetInfo                 */
#define BRCM_SWARCH_MCU_SET_INFO_PROC                 (0x8730U)    /**< @brief #MCU_SetInfo                 */
#define BRCM_SWARCH_MCU_SPEED_TYPE                    (0x8731U)    /**< @brief #MCU_SpeedType               */
#define BRCM_SWARCH_MCU_SECURITY_MODE_TYPE            (0x8732U)    /**< @brief #MCU_SecurityModeType        */
#define BRCM_SWARCH_MCU_SET_SECURITY_MODE_PROC        (0x8733U)    /**< @brief #MCU_SetSecurityMode         */
#define BRCM_SWARCH_MCU_ENABLE_ETHTRAFFIC_PROC        (0x8734U)    /**< @brief #MCU_EnableEthTraffic        */
#define BRCM_SWARCH_MCU_DISABLE_ETHTRAFFIC_PROC       (0x8735U)    /**< @brief #MCU_DisableEthTraffic       */
#define BRCM_SWARCH_MCU_FLASH_CLK_TBL_PTR_GLOBAL      (0x8736U)    /**< @brief #MCU_FlashClkTblPtr          */
#define BRCM_SWARCH_MCU_FLASH_CLK_TBL_SZ_GLOBAL       (0x8737U)    /**< @brief #MCU_FlashClkTblSz           */
/** @} */

/**
    @name Bootloader boot information
    @{
    @brief Bootloader boot information

    @trace #BRCM_SWREQ_MCU_QUERY
*/
typedef uint32_t MCU_BootInfoType;
#define MCU_BOOT_INFO_BL_COPY_ID_MASK       (0x3UL)     /**< @brief Bootloader Copy ID mask */
#define MCU_BOOT_INFO_BL_COPY_ID_SHIFT      (0UL)       /**< @brief Bootloader Copy ID shift*/
#define MCU_BOOT_INFO_BL_FLASH_ID_MASK      (0x4UL)     /**< @brief Bootloder Flash ID mask */
#define MCU_BOOT_INFO_BL_FLASH_ID_SHIFT     (2UL)       /**< @brief Bootloder Flash ID shift*/
#define MCU_BOOT_INFO_BL_EXECUTED_MASK      (0x8UL)     /**< @brief Bootloder Executed mask */
#define MCU_BOOT_INFO_BL_EXECUTED_SHIFT     (3UL)       /**< @brief Bootloder Executed shift*/
#define MCU_BOOT_INFO_SYSCFG_COPY_ID_MASK   (0x30UL)    /**< @brief SysCfg Copy ID mask     */
#define MCU_BOOT_INFO_SYSCFG_COPY_ID_SHIFT  (4UL)       /**< @brief SysCfg Copy ID shift    */
#define MCU_BOOT_INFO_SYSCFG_FLASH_ID_MASK  (0x40UL)    /**< @brief SysCfg Flash ID mask    */
#define MCU_BOOT_INFO_SYSCFG_FLASH_ID_SHIFT (6UL)       /**< @brief SysCfg Flash ID shift   */
#define MCU_BOOT_INFO_SYSCFG_EXECUTED_MASK  (0x80UL)    /**< @brief SysCfg Executed mask    */
#define MCU_BOOT_INFO_SYSCFG_EXECUTED_SHIFT (7UL)       /**< @brief SysCfg Executed shift   */
#define MCU_BOOT_INFO_FW_COPY_ID_MASK       (0x300UL)   /**< @brief Firmware Copy ID mask   */
#define MCU_BOOT_INFO_FW_COPY_ID_SHIFT      (8UL)       /**< @brief Firmware Copy ID shift  */
#define MCU_BOOT_INFO_FW_FLASH_ID_MASK      (0x400UL)   /**< @brief Firmware Flash ID mask  */
#define MCU_BOOT_INFO_FW_FLASH_ID_SHIFT     (10UL)      /**< @brief Firmware Flash ID shift */
#define MCU_BOOT_INFO_FW_EXECUTED_MASK      (0x800UL)   /**< @brief Firmware Executed mask  */
#define MCU_BOOT_INFO_FW_EXECUTED_SHIFT     (11UL)      /**< @brief Firmware Executed shift */
/** @} */

/**
    @name Firmware boot information
    @{
    @brief Firmware boot information

    @trace #BRCM_SWREQ_MCU_KERNEL_INTERFACE
*/
typedef uint32_t MCU_ResetInfoType;
#define MCU_RESET_INFO_RESET_REASON_MASK        (0x3UL)    /**< @brief Reset reason mask    */
#define MCU_RESET_INFO_RESET_REASON_SHIFT       (0UL)      /**< @brief Reset reason shift   */
#define MCU_RESET_INFO_SW_RESET_MASK            (0x1UL)    /**< @brief Software reset mask  */
#define MCU_RESET_INFO_WD_RESET_MASK            (0x2UL)    /**< @brief Watchdog reset mask  */
#define MCU_RESET_INFO_DWNLD_MODE_MASK          (0x1CUL)   /**< @brief Download mode mask   */
#define MCU_RESET_INFO_DWNLD_MODE_SHIFT         (2UL)      /**< @brief Donwload mode shift  */
#define MCU_RESET_INFO_DWNLD_MODE_TFTP          (0x1UL)    /**< @brief TFTP Download mode   */
#define MCU_RESET_INFO_DWNLD_MODE_RAM           (0x2UL)    /**< @brief RAM Download mode    */
#define MCU_RESET_INFO_DWNLD_MODE_IPC           (0x3UL)    /**< @brief IPC Download mode    */
#define MCU_RESET_INFO_DWNLD_MODE_PARTIAL_MASK  (0x20UL)   /**< @brief Partial Download mask*/
#define MCU_RESET_INFO_RAMDUMP_MASK             (0x8000UL) /**< @brief Ram dump mask        */
/** @} */

/**
    @brief MCU instance ID for error reporting

    @trace #BRCM_SWREQ_MCU_KERNEL_INTERFACE
*/
#define MCU_INSTANCE_ID                 (0x00U)

/**
    @brief Clock control data len

    @trace #BRCM_SWREQ_MCU_INIT
*/
#define MCU_CLOCK_CNTRL_DATA_LEN        (10UL)

/**
    @brief Enable clock failure notification

    @trace #BRCM_SWREQ_MCU_INIT
*/
#define MCU_CLK_SRC_NOTIFICATION_EN     (0x1UL)
#define MCU_CLK_SRC_NOTIFICATION_DIS    (0x2UL)

/**
    @brief MCU Chip rev number

    @trace #BRCM_SWREQ_MCU_QUERY
*/
#define MCU_CHIP_VERSION_A0             (0x0UL)
#define MCU_CHIP_VERSION_B0             (0x1UL)

/**
    @name MCU state type
    @{
    @brief MCU state

    @trace #BRCM_SWREQ_MCU_INIT
*/
typedef uint32_t MCU_StateType;     /**< @brief typedef for MCU state */
#define MCU_STATE_UNINIT    (0x0UL) /**< @brief MCU uninitialized */
#define MCU_STATE_INIT      (0x1UL) /**< @brief MCU initialized */
/** @} */

/**
   @name Device Master Slave ID
   @{
   @trace #BRCM_SWREQ_MCU_KERNEL_INTERFACE
 */
typedef uint32_t MCU_DeviceType;
#define MCU_DEVICE_MASTER          (0UL)  /**< @brief Device master mode */
#define MCU_DEVICE_SLAVE_1         (1UL)  /**< @brief Device ID slave_1 mode */
#define MCU_DEVICE_SLAVE_2         (2UL)  /**< @brief Device ID slave_2 mode */
/** @} */

/**
   @name Stacking port speed in Mbps
   @{
   @trace #BRCM_SWREQ_MCU_KERNEL_INTERFACE
 */
typedef uint32_t MCU_SpeedType;
#define MCU_SPEED_INVALID     (0UL)     /**< @brief Invalid speed */
#define MCU_SPEED_1000MBPS    (1000UL)  /**< @brief 1Gbps speed */
#define MCU_SPEED_2500MBPS    (2500UL)  /**< @brief 2.5Gbps speed */
#define MCU_SPEED_5000MBPS    (5000UL)  /**< @brief 5Gbps speed */
/** @} */

/**
    @name MCU Reset reason type
    @{
    @brief MCU Reset reason type

    @trace #BRCM_SWREQ_MCU_KERNEL_INTERFACE
*/
typedef uint32_t MCU_ResetReasonType;       /**< @brief typedef for MCU Reset reason */
#define MCU_RESETREASON_POWER_ON   (0x1UL)  /**< @brief POWER ON reset */
#define MCU_RESETREASON_WD         (0x2UL)  /**< @brief Watchdog reset */
#define MCU_RESETREASON_SW         (0x3UL)  /**< @brief Software triggered reset */
#define MCU_RESETREASON_UNDEFINED  (0x4UL)  /**< @brief reset reason undefined */
/** @} */

/**
    @name MCU Reset mode type
    @{
    @brief MCU Reset mode type

    @trace #BRCM_SWREQ_MCU_KERNEL_INTERFACE
*/
typedef uint32_t MCU_ResetModeType;         /**< @brief typedef for MCU Reset mode */
#define MCU_RESETMODE_NONE       (0x0UL)    /**< @brief Reset mode none */
#define MCU_RESETMODE_DWNL       (0x1UL)    /**< @brief reset mode download */
#define MCU_RESETMODE_RAMDUMP    (0x2UL)    /**< @brief reset mode ramdump */
#define MCU_RESETMODE_DWNLD_TFTP (0x3UL)    /**< @brief reset mode TFTP download */
#define MCU_RESETMODE_DWNLD_RAM  (0x4UL)    /**< @brief reset mode RAM download */
#define MCU_RESETMODE_DWNLD_IPC  (0x5UL)    /**< @brief reset mode RAM download */
/** @} */

/**
    @name MCU Reset request type
    @{
    @brief MCU Reset request type

    @trace #BRCM_SWREQ_MCU_KERNEL_INTERFACE
*/
typedef uint32_t MCU_ResetReqType;      /**< @brief typedef for MCU Reset request */
#define MCU_RESETREQ_GLOBAL     (0x1UL) /**< @brief Perform Global reset */
#define MCU_RESETREQ_LOCAL      (0x2UL) /**< @brief Perform local CPU reset (does not reset the peripherals and
                                                    memories)*/
/** @} */

/**
    @name MCU Low power mode type
    @{
    @brief MCU Low power mode type

    @trace #BRCM_SWREQ_MCU_KERNEL_INTERFACE
*/
typedef uint32_t MCU_LpmModeType;   /**< @brief typedef for MCU low power mode */
#define MCU_LPMMODE_WFI     (0x1UL) /**< @brief CPU WFI mode */
/** @} */

/**
    @name PLL status type
    @{
    @brief PLL status type

    @trace #BRCM_SWREQ_MCU_INIT
*/
typedef uint32_t MCU_PllStatusType;         /**< @brief typedef for PLL status */
#define MCU_PLLSTATUS_LOCKED        (0x1UL) /**< @brief PLL status locked */
#define MCU_PLLSTATUS_UNLOCKED      (0x2UL) /**< @brief PLL status unlocked */
#define MCU_PLLSTATUS_UNDEFINED     (0x3UL) /**< @brief PLL status undefined */
/** @} */


/**
    @name MCU download mode type
    @{
    @brief MCU download mode type

    @trace #BRCM_SWREQ_MCU_INIT
*/
typedef uint32_t MCU_DwnldModeType;     /**< @brief typedef for MCU download mode */
#define MCU_DWNLD_MODE_VIRGIN   (0x0UL) /**< @brief Virgin download mode */
#define MCU_DWNLD_MODE_PARTIAL  (0x1UL) /**< @brief Partial download mode */
/** @} */

/**
    @name MCU Security Mode Type
    @{
    @brief MCU security modes

    @trace #BRCM_SWREQ_MCU_KERNEL_INTERFACE
*/
typedef uint32_t MCU_SecurityModeType;     /**< @brief typedef for MCU Security mode */
#define MCU_SECURITY_MODE_UNKNOWN (0x0UL)  /**< @brief Unknown mode */
#define MCU_SECURITY_MODE_NONE    (0x1UL)  /**< @brief Unsecured */
#define MCU_SECURITY_MODE_ECC     (0x2UL)  /**< @brief Secured through ECC */
#define MCU_SECURITY_MODE_RSA     (0x3UL)  /**< @brief Secured through RSA */
#define MCU_SECURITY_MODE_MAX     (MCU_SECURITY_MODE_RSA) /**< @brief Maximum mode value supported */
/** @} */

/**
    @brief RAM section ID type
    Value ranges from 0 to N. N is maximum number of RAM section defined by
    MCU configuration (refer to #MCU_ConfigType)

    @trace #BRCM_SWREQ_MCU_INIT
*/
typedef uint32_t MCU_RamSectionIDType;

/**
    @brief Clock ID type

    @trace #BRCM_SWREQ_MCU_INIT
*/
typedef uint32_t MCU_ClkIDType;

/**
    @brief Clock configuration ID type
    Value ranges from 0 to N. N is the maximum number of the clock settings in
    MCU configuration (refer to #MCU_ConfigType)

    @trace #BRCM_SWREQ_MCU_KERNEL_INTERFACE
*/
typedef uint32_t MCU_ClkCfgIDType;

/**
    @brief Boot time information type

    @trace #BRCM_SWREQ_MCU_KERNEL_INTERFACE
*/
typedef struct sMCU_BootTimeInfoType {
    uint8_t  blBootTime;    /**< @brief Bootloader boot time.
                                        (time taken by ROM to load BL, assumed to be less than 256ms) */
    uint8_t  fwBootTime;    /**< @brief transceiver initialization time.
                                        (time taken by BL to load the FW, assumed to be less than 256ms) */
} MCU_BootTimeInfoType;

/**
    @brief MCU version information structure

    @trace #BRCM_SWREQ_MCU_KERNEL_INTERFACE
 */
typedef struct sMCU_VersionType {
    uint32_t manuf;     /**< @brief manufacturer ID */
    uint32_t model;     /**< @brief model number */
    uint32_t rev;       /**< @brief revision number */
    MCU_SecurityModeType securityMode; /**< @brief Security Mode */
} MCU_VersionType;

/**
    @brief Clock reference structure

    @trace #BRCM_SWREQ_MCU_INIT
 */
typedef struct sMCU_ClkRefType{
    MCU_ClkIDType   clkID;                              /**< @brief clock ID */
    uint32_t        freq;                               /**< @brief clock freq */
    uint32_t        cntrl[MCU_CLOCK_CNTRL_DATA_LEN];    /**< @brief clock control data */
} MCU_ClkRefType;

/**
    @brief MCU clock settings configuration

    @trace #BRCM_SWREQ_MCU_INIT
 */
typedef struct sMCU_ClkCfgType {
    MCU_ClkCfgIDType cfgID; /**< @brief Settings ID (clock configuration ID)
                                        defined by the MCU low level header */
    MCU_ClkRefType clkRef;  /**< @brief Clock reference point (refer #MCU_ClkRefType) */
} MCU_ClkCfgType;

/**
    @brief MCU RAM sector configuration

    @trace #BRCM_SWREQ_MCU_INIT
 */
typedef struct sMCU_RamSecCfgType {
    uint8_t defaultVal;      /**< @brief Default value to filled for this RAM section (Range: 0- 255) */
    uint8_t* const baseAddr; /**< @brief Base address of the RAM section */
    uint32_t size;           /**< @brief Size of this RAM section */
} MCU_RamSecCfgType;

/**
    @brief MCU configuration structure

    @trace #BRCM_SWREQ_MCU_INIT
 */
typedef struct sMCU_ConfigType {
    uint32_t clkSrcFailNotification;            /**< @brief Enable/Disable clock failure notification
                                                        @note When clock source failure notification
                                                            is enabled, MCU reports the failure event
                                                            through #BCM_ReportError.
                                                            This notification is not supported currently */
    const MCU_ClkCfgType *const clkCfgTbl;      /**< @brief clock config table */
    uint32_t clkCfgTblSize;                     /**< @brief Clock config table size */
    const MCU_RamSecCfgType *const ramCfgTbl;   /**< @brief RAM section config table */
    uint32_t ramCfgTblSize;                     /**< @brief RMA section config tbl size */
} MCU_ConfigType;

/**
    @name MCU information
    @{
    @brief MCU information

    @trace #BRCM_SWREQ_MCU_KERNEL_INTERFACE
*/
typedef struct sMCU_InfoType {
    uint8_t            stackingEn; /**< @brief Stacking Enable, 0: Disable, 1: Enable */
    MCU_DeviceType     mstSlvMode; /**< @brief 0: Master, 1: Slave-1                  */
    uint8_t            stackPort0; /**< @brief Stacking Port 0 info                   */
    uint8_t            stackPort1; /**< @brief Stacking Port 1 info                   */
    uint8_t            impPort;    /**< @brief Port number enabled in IMP mode (port8) */
    uint16_t           vlan;       /**< @brief VLAN Id to be used for private communication */
    uint8_t            macAddr[6U];/**< @brief MAC address to be used for private communication */
    uint32_t           ipAddr;     /**< @brief IP address to be used for private communication */
    uint32_t           gwIPAddr;   /**< @brief Gateway IP address to be used for private communication */
    uint32_t           netmask;    /**< @brief Netmask to be used for private communication */
    uint32_t           bootInfo;   /**< @brief 24 bits of boot Information sent along within DHCP/TFTP request*/
    uint32_t           tftpServerAddr;  /**< @brief TFTP server IP address */
    uint8_t            remoteMacAddr[2U][6U];/**< @brief Slave MAC addresses (to be used for private communication) */
    uint8_t            remoteIPAddr[2U][4U]; /**< @brief IP address of slaves (to be used for private communication) */
    MCU_SpeedType      stackPort0Speed; /**< @brief Stacking Port 0 speed in Mbps */
    MCU_SpeedType      stackPort1Speed; /**< @brief Stacking Port 1 speed in Mbps */
    uint8_t            stackPort0CntrlID; /**< @brief Stacking Port 0 controller index */
    uint8_t            stackPort1CntrlID; /**< @brief Stacking Port 1 controller index */
} MCU_InfoType;
/** @} */

/** @brief Initialize MCU

    This API shall initialize MCU module and sets the MCU state to #MCU_STATE_INIT.

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aConfig     Pointer to configuration structure

    @return void

    @post None

    @trace  #BRCM_SWREQ_MCU_INIT

    @note This API shall be called before calling any other MCU APIs.

    @limitations This API shall be called in privileged
        context with interrupt disabled
*/
extern void MCU_Init(const MCU_ConfigType *const aConfig);

/** @brief Get MCU version

    This API retrieves the MCU version.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aVersion    Pointer to version structure

    @return void

    @post None

    @trace  #BRCM_SWREQ_MCU_QUERY

    @limitations None
*/
extern void MCU_GetVersion(MCU_VersionType *const aVersion);

/** @brief Initialize clock

    This API initializes clock provided by aCfgID parameter.

    @behavior Sync, Non-reentrant

    @pre MCU is initialized

    @param[in]      aCfgID      Clock configuration ID

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             clock initialization sequence successful
    @retval     #BCM_ERR_UNINIT         MCU not initialized
    @retval     #BCM_ERR_INVAL_PARAMS   invalid aCfgID

    @post None

    @trace  #BRCM_SWREQ_MCU_INIT

    @limitations This API shall be called in privileged
        context with interrupt disabled.
*/
extern int32_t MCU_ClkInit(MCU_ClkCfgIDType aCfgID);

/** @brief Initialize RAM section

    Initialize the RAM section and reset it to default value
    (as provided in the configuration structure during #MCU_Init)

    @behavior Sync, Re-entrant

    @pre MCU is initialized

    @param[in]      aID     RAM section ID

    @return void

    @post None

    @trace  #BRCM_SWREQ_MCU_INIT

    @limitations This API shall be called in privileged
        context with interrupt disabled.
*/
extern void MCU_RamSectionInit(MCU_RamSectionIDType aID);

/** @brief MCU perform reset

    This API performs the reset of the MCU.
    - For local reset request (#MCU_RESETREQ_LOCAL),
        this API performs the ARM vector reset and returns.
    - For global reset request (#MCU_RESETREQ_GLOBAL),
        this API performs the ARM global reset and never returns.

    @behavior Sync, Non-reentrant

    @pre MCU is initialized

    @param[in]      aResetReq   Reset request type

    @return void

    @post None

    @trace  #BRCM_SWREQ_MCU_DYNAMIC_CONFIG

    @limitations This API may not be supported on all the chipsets
        (chipset may have functionality of self-reset.
        Refer to TRM to see if self-reset is supported by the chipset)
*/
extern void MCU_ResetReq(MCU_ResetReqType aResetReq);

/** @brief Get MCU reset reason

    This API returns the reset reason of the MCU
    (This API does not clear the reset reason of the MCU)

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      void

    @return     #MCU_ResetReasonType    reset reason of the MCU

    @post None

    @trace  #BRCM_SWREQ_MCU_QUERY

    @limitations None
*/
extern MCU_ResetReasonType MCU_GetResetReason(void);

/** @brief Get MCU reset reason raw value

    This API returns the raw value of the reset reason register of the MCU.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      void

    @return     uint32_t   Reset reason register raw value

    @post None

    @trace  #BRCM_SWREQ_MCU_QUERY

    @limitations None
*/
extern uint32_t MCU_GetResetRawValue(void);

/** @brief Get MCU PLLs status

    This API returns the status of the PLLs in the system.
    If the chipset does not support PLL (or by default all the
    PLLs are locked during boot), this API returns #MCU_PLL_STATUS_LOCKED.
    Refer to TRM for details.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      void

    Return values are documented in reverse-chronological order
    @retval     #MCU_PLL_STATUS_LOCKED      All PLLs are locked
    @retval     #MCU_PLL_STATUS_UNLOCKED    one or more PLL in the system is
                                            not locked
    @retval     #MCU_PLL_STATUS_UNDEFINED   Status of the one or more PLL in
                                            the system is unknown

    @post None

    @trace  #BRCM_SWREQ_MCU_QUERY

    @limitations None
*/
extern MCU_PllStatusType MCU_GetPllStatus(void);

/** @brief Activate PLL clocks

    This API enables the PLL clocks. If the chipset does not support PLL
    (or by default all the PLLs are locked during
    boot), this API returns without any effect on the system.
    Refer to TRM for details.

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      void

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Request has been accepted
    @retval     #BCM_ERR_UNINIT         MCU is not initialized
    @retval     #BCM_ERR_INVAL_STATE    PLL is not locked

    @post None

    @trace  #BRCM_SWREQ_MCU_DYNAMIC_CONFIG

    @limitations None
*/
extern int32_t MCU_ActivatePllClocks(void);

/** @brief Set Low power mode of the MCU

    This API puts the MCU in low power mode and does not return until
    the MCU wakes-up from the low power mode.

    @note This API is not supported in the current version

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aLpmMode    LPM mode

    @return void

    @post None

    @trace  #BRCM_SWREQ_MCU_DYNAMIC_CONFIG

    @limitations None
*/
extern void MCU_SetLpmMode(MCU_LpmModeType aLpmMode);

/** @brief Get MCU reset mode

    This API returns the reset mode of the MCU.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      void

    @return     #MCU_ResetModeType      Reset mode

    @post None

    @trace  #BRCM_SWREQ_MCU_QUERY

    @limitations None
*/
extern MCU_ResetModeType MCU_GetResetMode(void);

/** @brief Get download mode

    This API retrieves the download mode.

    @behavior Sync, Re-entrant

    @pre None

    @param[in] None

    @return #MCU_DwnldModeType Download type

    @post None

    @trace  #BRCM_SWREQ_MCU_QUERY

    @limitations None
*/
extern MCU_DwnldModeType MCU_GetDwnldMode(void);

/** @brief Get default reset mode

    This API retrieves the default reset mode.

    @behavior Sync, Re-entrant

    @pre None

    @param[in] None

    @return #MCU_ResetModeType Reset mode type

    @post None

    @trace  #BRCM_SWREQ_MCU_QUERY

    @limitations None
*/
extern MCU_ResetModeType MCU_GetDefaultResetMode(void);

/** @brief Get BL Boot Info

    This API retrieves the Boot Info.

    @behavior Sync, Re-entrant

    @pre None

    @param[in] aBootInfo    Boot Info

    @retval #BCM_ERR_NOSUPPORT

    @post None

    @trace  #BRCM_SWREQ_MCU_QUERY

    @limitations None
*/
extern int32_t MCU_GetBLBootInfo(uint32_t * const aBootInfo);

/** @brief Set MCU Firmware Boot Info

    This API sets boot info of the MCU firmware

    @behavior Sync, Re-entrant

    @pre None

    @param[in]     aPid     Partition ID with CopyID
    @param[in]     aFlsId   Flash ID (0/1)

    @return void

    @post None

    @trace  #BRCM_SWREQ_MCU_QUERY

    @limitations This API can only be called in privileged context
*/
extern void MCU_SetBootInfo(PTBL_IdType aPid, uint8_t aFlsId);

/** @brief Get MCU Firmware Boot Info

    This API retrieves boot info of the MCU firmware

    @behavior Sync, Re-entrant

    @pre None

    @param[inout]   aPid    Partition ID (Copy ID is output)
    @param[out]     aFlsId  Flash ID (0/1)

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             aPid and aFlsId are filled
    @retval     #BCM_ERR_INVAL_PARAMS   aPid is NULL or aFlsId is NULL

    @post None

    @trace  #BRCM_SWREQ_MCU_QUERY

    @limitations None
*/
extern int32_t MCU_GetBootInfo(PTBL_IdType * const aPid, uint8_t * const aFlsId);

/** @brief Get Boot time information

    This API retrieves boot time information which was previously
    set by calling #MCU_SetBootTimeInfo()

    @behavior Sync, Re-entrant

    @pre None

    @param[out]     aBootTime   Boot Time Information

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Boot Info is filled
    @retval     #BCM_ERR_INVAL_PARAMS   aBootTime is NULL

    @post None

    @trace  #BRCM_SWREQ_MCU_QUERY

    @limitations None
*/
extern int32_t MCU_GetBootTimeInfo(MCU_BootTimeInfoType *const aBootTime);

/** @brief Set Boot time information

    This API saves boot time infomation

    @behavior Sync, Re-entrant

    @pre None

    @param[out]     aBootTime   Boot time Information

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Boot Info is filled
    @retval     #BCM_ERR_INVAL_PARAMS   aBootTime is NULL

    @post None

    @trace  #BRCM_SWREQ_MCU_DYNAMIC_CONFIG

    @limitations This is a privileged API and can be called only when processor
                 is running in privileged mode.
*/
extern int32_t MCU_SetBootTimeInfo(const MCU_BootTimeInfoType *const aBootTime);

/** @brief Set the MCU reset mode

    This API sets the reset mode of the MCU.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aResetMode      Reset mode to be set

    @return void

    @post None

    @trace  #BRCM_SWREQ_MCU_DYNAMIC_CONFIG

    @limitations None
*/
extern void MCU_SetResetMode(MCU_ResetModeType aResetMode);

/** @brief Get clock frequency

    This API returns the frequency of the clock referenced by
    the given clock configuration ID.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aCfgID      Clock ID

    @return     #uint32_t       Frequency (in Hertz). If aCfgID is invalid
                                this interface returns 0.

    @post None

    @trace  #BRCM_SWREQ_MCU_QUERY

    @limitations This API shall be called only from privileged software.
*/
extern uint32_t MCU_GetClkFreq(MCU_ClkCfgIDType aCfgID);

/** @brief Adjust clock frequency

    This API tries to adjust the frequency of the clock referenced by
    the given clock configuration ID.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aCfgID      Clock configuration ID
    @param[in]      aCorrection Correction value (in Hertz)

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Frequency adjusted successfully
    @retval     #BCM_ERR_INVAL_PARAMS   Invalid clock configuration ID
    @retval     #BCM_ERR_INVAL_PARAMS   Frequency out of bounds
    @retval     #BCM_ERR_NOSUPPORT      Clock adjust not supported
    @retval     #BCM_ERR_NOSUPPORT      BCM_ERR_NOSUPPORT

    @post None

    @trace  #BRCM_SWREQ_MCU_DYNAMIC_CONFIG

    @limitations This API may not be supported on all the chipsets.
*/
extern int32_t MCU_AdjustClkFreq(MCU_ClkCfgIDType aCfgID,
                                     int32_t aCorrection);

/** @brief Get MCU info

    This API fetches MCU info.

    @behavior Sync, reentrant

    @pre #MCU_Init will be called first

    @param[in]   aInfo           Pointer to structure containing switch
                                 information.

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully fetch MCU Info.
    @retval     #BCM_ERR_UNKNOWN        Unknown issue.
    @retval     #BCM_ERR_NOSUPPORT      API not supported.

    @post None

    @trace  #BRCM_SWREQ_MCU_QUERY
*/
extern int32_t MCU_GetInfo(MCU_InfoType * aInfo);

/** @brief Set MCU info

    This API sets MCU info.

    @behavior Sync, reentrant

    @pre None

    @param[in]   aInfo            MCU information.

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully set MCU information.
    @retval     #BCM_ERR_UNKNOWN        Unknown issue.
    @retval     #BCM_ERR_NOSUPPORT      API not supported.

    @post None

    @trace  #BRCM_SWREQ_MCU_DYNAMIC_CONFIG
*/
extern int32_t MCU_SetInfo(MCU_InfoType *const aInfo);

/** @brief Set Security mode

    This API sets MCU security mode

    @behavior Sync, reentrant

    @pre None

    @param[in]   aMode           Security Mode

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully set MCU information.
    @retval     #BCM_ERR_INVAL_PARAMS   aMode is invalid
    @retval     #BCM_ERR_UNINIT         MCU Driver is not initialised

    @post None

    @trace  #BRCM_SWREQ_MCU_DYNAMIC_CONFIG
*/
extern int32_t MCU_SetSecurityMode(MCU_SecurityModeType aMode);

/** @brief Enable Ethernet Traffic

    This API enables Ethernet Traffic.

    @behavior Sync, reentrant

    @pre None

    @param      void

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Enabled Ethernet Traffic
    @retval     #BCM_ERR_UNINIT         MCU not initialized


    @post None

    @trace  #BRCM_SWREQ_MCU_DYNAMIC_CONFIG
*/
extern int32_t MCU_EnableEthTraffic(void);

/** @brief Disable Ethernet Traffic

    This API disables Ethernet Traffic.

    @behavior Sync, reentrant

    @pre None

    @param      void

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Disabled Ethernet Traffic
    @retval     #BCM_ERR_UNINIT         MCU not initialized


    @post None

    @trace  #BRCM_SWREQ_MCU_DYNAMIC_CONFIG
*/
extern int32_t MCU_DisableEthTraffic(void);

/**
    @brief MCU flash clock IDs table pointer

    @trace #BRCM_SWREQ_MCU_INIT
 */
extern const MCU_ClkCfgIDType * const MCU_FlashClkTblPtr;

/**
    @brief MCU flash clock IDs table size

    @trace #BRCM_SWREQ_MCU_INIT
 */
extern const MCU_ClkCfgIDType MCU_FlashClkTblSz;

#endif /* MCU_H */
/** @} */
