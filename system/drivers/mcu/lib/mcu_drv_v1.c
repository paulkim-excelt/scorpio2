/*****************************************************************************
 Copyright 2019-2021 Broadcom Limited.  All rights reserved.

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
    @addtogroup grp_mcudrv_impl
    @{

    @limitations None

    @file mcu_drv_v1.c
    @brief MCU driver low level implementation for end point
    This header file contains the MCU driver implementation for end point

    @version 0.86 Imported from docx
*/

#include <inttypes.h>
#include <string.h>
#include <compiler.h>
#include <cortex_mx.h>
#include <bcm_utils.h>
#include <bcm_err.h>
#include <mcu_clk.h>
#include <svc.h>
#include <mcu.h>
#include <mcu_osil.h>

#include <avt.h>
#include "cfg_rdb.h"
#include "mcu_rdb.h"
#include "mcu_cpu_rdb.h"
#include "brphy_mii_rdb.h"

/**
    @name MCU Implementation Design IDs
    @{
    @brief Implementation Design IDs for MCU Driver
*/
#define BRCM_SWDSGN_MCU_CLK_CFG_MAX_MACRO                       (0xB401U)    /**< @brief #MCU_CLK_CFG_MAX                    */
#define BRCM_SWDSGN_MCU_RAM_CFG_MAX_MACRO                       (0xB402U)    /**< @brief #MCU_RAM_CFG_MAX                    */
#define BRCM_SWDSGN_MCU_PIOCFG_QSPICLKCTRL_TIMEOUT_CNT_MACRO    (0xB403U)    /**< @brief #MCU_PIOCFG_QSPICLKCTRL_TIMEOUT_CNT */
#define BRCM_SWDSGN_MCU_PIOCFG_PERIPHID_TYPE                    (0xB404U)    /**< @brief #MCU_PiocfgPeriphIDType             */
#define BRCM_SWDSGN_MCU_PIOCFG_QSPICLK_SRC_TYPE                 (0xB405U)    /**< @brief #MCU_PiocfgQSPIClkSrcType           */
#define BRCM_SWDSGN_MCU_PIOCFG_QSPICLK_DIV_TYPE                 (0xB406U)    /**< @brief #MCU_PiocfgQSPIClkDivType           */
#define BRCM_SWDSGN_MCU_DRV_CONFIG_TYPE                         (0xB407U)    /**< @brief #MCU_DrvConfigType                  */
#define BRCM_SWDSGN_MCU_DEV_TYPE                                (0xB408U)    /**< @brief #MCU_DevType                        */
#define BRCM_SWDSGN_MCU_SVCIO_TYPE                              (0xB409U)    /**< @brief #MCU_SVCIOType                      */
#define BRCM_SWDSGN_MCU_CHIPMISCREGS_GLOBAL                     (0xB40AU)    /**< @brief #MCU_ChipMiscRegs                   */
#define BRCM_SWDSGN_MCU_CPU_REGS_GLOBAL                         (0xB40BU)    /**< @brief #MCU_CPURegs                        */
#define BRCM_SWDSGN_MCU_BRPHY_REGS_GLOBAL                       (0xB40CU)    /**< @brief #MCU_BRPHYRegs                      */
#define BRCM_SWDSGN_MCU_PIOCFG_REGS_GLOBAL                      (0xB40DU)    /**< @brief #MCU_PIOCfgRegs                     */
#define BRCM_SWDSGN_MCU_DEV_GLOBAL                              (0xB40EU)    /**< @brief #MCU_Dev                            */
#define BRCM_SWDSGN_MCU_DRV_CFG_GLOBAL                          (0xB40FU)    /**< @brief #MCU_DrvCfg                         */
#define BRCM_SWDSGN_MCU_PIOCFG_PERIPHRESET_PROC                 (0xB410U)    /**< @brief #MCU_PiocfgPeriphReset              */
#define BRCM_SWDSGN_MCU_PIOCFG_PERIPHPOWERUPALL_PROC            (0xB411U)    /**< @brief #MCU_PiocfgPeriphPowerUpAll         */
#define BRCM_SWDSGN_MCU_PIOCFG_ENABLEQSPIINTERRUPT_PROC         (0xB412U)    /**< @brief #MCU_PiocfgEnableQSPIInterrupt      */
#define BRCM_SWDSGN_MCU_PIOCFG_DISABLEQSPIINTERRUPT_PROC        (0xB413U)    /**< @brief #MCU_PiocfgDisableQSPIInterrupt     */
#define BRCM_SWDSGN_MCU_PIOCFG_ENABLEALLQSPIINTERRUPT_PROC      (0xB414U)    /**< @brief #MCU_PiocfgEnableAllQSPIInterrupt   */
#define BRCM_SWDSGN_MCU_PIOCFG_DISABLEQSPIERRINTERRUPT_PROC     (0xB415U)    /**< @brief #MCU_PiocfgDisableQSPIErrInterrupt  */
#define BRCM_SWDSGN_MCU_PIOCFG_SETQSPICLK_PROC                  (0xB416U)    /**< @brief #MCU_PiocfgSetQSPIClk               */
#define BRCM_SWDSGN_MCU_ISINITIALIZED_PROC                      (0xB417U)    /**< @brief #MCU_IsInitialized                  */
#define BRCM_SWDSGN_MCU_DRV_QSPICLKINIT_PROC                    (0xB418U)    /**< @brief #MCU_DrvQspiClkInit                 */
#define BRCM_SWDSGN_MCU_DRV_CLKINITINT_PROC                     (0xB419U)    /**< @brief #MCU_DrvClkInitInt                  */
#define BRCM_SWDSGN_MCU_DRV_PERIPHINIT_PROC                     (0xB41AU)    /**< @brief #MCU_DrvPeriphInit                  */
#define BRCM_SWDSGN_MCU_DRV_GETRESETMODE_PROC                   (0xB41BU)    /**< @brief #MCU_DrvGetResetMode                */
#define BRCM_SWDSGN_MCU_GETBLBOOTINFO_PROC                      (0xB41CU)    /**< @brief #MCU_GetBLBootInfo                  */
#define BRCM_SWDSGN_MCU_GETDEFAULTRESET_PROC                    (0xB41DU)    /**< @brief #MCU_GetDefaultResetMode            */
#define BRCM_SWDSGN_MCU_GETDWNLDMODE_PROC                       (0xB41EU)    /**< @brief #MCU_GetDwnldMode                   */
#define BRCM_SWDSGN_MCU_DRV_SETFWBOOTINFO_PROC                  (0xB41FU)    /**< @brief #MCU_SetBootInfo                    */
#define BRCM_SWDSGN_MCU_DRV_SETRESETMODE_PROC                   (0xB420U)    /**< @brief #MCU_DrvSetResetMode                */
#define BRCM_SWDSGN_MCU_DRV_GETFWBOOTINFO_PROC                  (0xB421U)    /**< @brief #MCU_DrvGetBootInfo                 */
#define BRCM_SWDSGN_MCU_DRV_SETDISPHSSRC_PROC                   (0xB422U)    /**< @brief #MCU_DrvSetDispHsSrc                */
#define BRCM_SWDSGN_MCU_DRV_DISPHSTRIGGER_PROC                  (0xB423U)    /**< @brief #MCU_DrvDispHsTrigger               */
#define BRCM_SWDSGN_MCU_DRV_GETRESETREASON_PROC                 (0xB424U)    /**< @brief #MCU_DrvGetResetReason              */
#define BRCM_SWDSGN_MCU_DRV_GETRESETRAWVALUE_PROC               (0xB425U)    /**< @brief #MCU_DrvGetResetRawValue            */
#define BRCM_SWDSGN_MCU_DRV_RESETREQ_PROC                       (0xB426U)    /**< @brief #MCU_DrvResetReq                    */
#define BRCM_SWDSGN_MCU_GETPLLSTATUS_PROC                       (0xB427U)    /**< @brief #MCU_GetPllStatus                   */
#define BRCM_SWDSGN_MCU_ACTIVATEPLLCLOCKS_PROC                  (0xB428U)    /**< @brief #MCU_ActivatePllClocks              */
#define BRCM_SWDSGN_MCU_CLKINIT_PROC                            (0xB429U)    /**< @brief #MCU_ClkInit                        */
#define BRCM_SWDSGN_MCU_RAMSECTIONINIT_PROC                     (0xB42AU)    /**< @brief #MCU_RamSectionInit                 */
#define BRCM_SWDSGN_MCU_DRV_GETVERSION_PROC                     (0xB42BU)    /**< @brief #MCU_GetVersion                     */
#define BRCM_SWDSGN_MCU_INIT_PROC                               (0xB42CU)    /**< @brief #MCU_Init                           */
#define BRCM_SWDSGN_MCU_GETCLKFREQ_PROC                         (0xB42DU)    /**< @brief #MCU_GetClkFreq                     */
#define BRCM_SWDSGN_MCU_DRV_ADJUSTCLKFREQ_PROC                  (0xB42EU)    /**< @brief #MCU_DrvAdjustClkFreq               */
#define BRCM_SWDSGN_MCU_SYSCMDHANDLER_PROC                      (0xB42FU)    /**< @brief #MCU_SysCmdHandler                  */
#define BRCM_SWDSGN_MCU_INTGETPLLSTATUS_PROC                    (0xB430U)    /**< @brief #MCU_IntGetPllStatus                */
#define BRCM_SWDSGN_MCU_DRV_GETBOOTTIMEINFO_PROC                (0xB431U)    /**< @brief #MCU_DrvGetBootTimeInfo             */
#define BRCM_SWDSGN_MCU_SETBOOTTIMEINFO_PROC                    (0xB432U)    /**< @brief #MCU_SetBootTimeInfo                */
#define BRCM_SWDSGN_MCU_DRV_CANCLKINIT_PROC                     (0xB433U)    /**< @brief #MCU_DrvCANClkInit                  */
#define BRCM_SWDSGN_MCU_DRV_GET_INFO_PROC                       (0xB434U)    /**< @brief #MCU_GetInfo                        */
/** @} */

/** @brief MCU Clock configuration mask

    @trace  #BRCM_SWARCH_MCU_CLKINIT_PROC
    @trace  #BRCM_SWARCH_MCU_RAMSECTIONINIT_PROC
    @trace  #BRCM_SWARCH_MCU_INIT_PROC
    @trace  #BRCM_SWARCH_MCU_GETCLKFREQ_PROC
    @trace  #BRCM_SWARCH_MCU_SYSCMDHANDLER_PROC
    @trace  #BRCM_SWREQ_MCU_INIT_V1
*/
#define MCU_CLK_CFG_MAX             (30UL)

/** @brief MCU RAM configuration mask

    @trace  #BRCM_SWARCH_MCU_SYSCMDHANDLER_PROC
    @trace  #BRCM_SWARCH_MCU_GETCLKFREQ_PROC
    @trace  #BRCM_SWARCH_MCU_INIT_PROC
    @trace  #BRCM_SWARCH_MCU_CLKINIT_PROC
    @trace  #BRCM_SWARCH_MCU_RAMSECTIONINIT_PROC
    @trace  #BRCM_SWREQ_MCU_INIT_V1
*/
#define MCU_RAM_CFG_MAX             (10UL)

/** @brief MCU PIOCFG QSPI Clock control time out

    @trace  #BRCM_SWARCH_MCU_CLKINIT_PROC
    @trace  #BRCM_SWREQ_MCU_INIT_V1
*/
#define MCU_PIOCFG_QSPICLKCTRL_TIMEOUT_CNT         (64UL)

/**
    @name Peripheral ID type
    @{
    @brief Peripheral ID type
    The IDs are mapped to IRQ line numbers

    @trace  #BRCM_SWARCH_MCU_INIT_PROC
    @trace  #BRCM_SWREQ_MCU_INIT_V1
*/
typedef uint32_t MCU_PiocfgPeriphIDType;
#define MCU_PIOCFG_PERIPHID_TMR0          (36UL)  /**< @brief TMR0(CCT) ID */
#define MCU_PIOCFG_PERIPHID_QSPI0         (42UL)  /**< @brief QSPI 0 ID */
#define MCU_PIOCFG_PERIPHID_QSPI1         (43UL)  /**< @brief QSPI 1 ID */
#define MCU_PIOCFG_PERIPHID_AVT           (46UL)  /**< @brief AVT ID*/
#define MCU_PIOCFG_PERIPHID_CAN           (55UL)  /**< @brief CAN ID */
#define MCU_PIOCFG_PERIPHID_ADC           (57UL)  /**< @brief ADC ID */
#define MCU_PIOCFG_PERIPHID_I2C0          (58UL)  /**< @brief I2C Channel 0 ID */
#define MCU_PIOCFG_PERIPHID_I2C1          (59UL)  /**< @brief I2C Channel 1 ID */
#define MCU_PIOCFG_PERIPHID_I2C2          (60UL)  /**< @brief I2C Channel 2 ID */
#define MCU_PIOCFG_PERIPHID_I2C3          (61UL)  /**< @brief I2C Channel 3 ID */
#define MCU_PIOCFG_PERIPHID_SPI0          (62UL)  /**< @brief SPI 0 */
#define MCU_PIOCFG_PERIPHID_SPI1          (63UL)  /**< @brief SPI 1 */
#define MCU_PIOCFG_PERIPHID_SPI2          (64UL)  /**< @brief SPI 2 */
#define MCU_PIOCFG_PERIPHID_URT0          (65UL)  /**< @brief UART Channel 0 ID */
#define MCU_PIOCFG_PERIPHID_URT1          (66UL)  /**< @brief UART Channel 1 ID */
#define MCU_PIOCFG_PERIPHID_URT2          (67UL)  /**< @brief UART Channel 2 ID */
#define MCU_PIOCFG_PERIPHID_I2S           (68UL)  /**< @brief I2S ID */
#define MCU_PIOCFG_PERIPHID_TIM0_PCLK     (76UL)  /**< @brief Timer Channel 0 PCLK ID */
#define MCU_PIOCFG_PERIPHID_WDT_PCLK      (77UL)  /**< @brief WatchDog Timer PCLK ID */
#define MCU_PIOCFG_PERIPHID_PWM           (78UL)  /**< @brief PWM ID */
#define MCU_PIOCFG_PERIPHID_MMI           (90UL)  /**< @brief MMI ID */
/** @} */

/**
    @name QSPI clock source selection type
    @{
    @brief QSPI clock source selection type

    @trace  #BRCM_SWARCH_MCU_CLKINIT_PROC
    @trace  #BRCM_SWREQ_MCU_INIT_V1
*/
typedef uint32_t MCU_PiocfgQSPIClkSrcType;
#define MCU_PIOCFG_QSPICLK_SRC_25M     (0UL)   /**< @brief 25MHz reference clock */
#define MCU_PIOCFG_QSPICLK_SRC_100M    (1UL)   /**< @brief 100MHz ACLK clock */
#define MCU_PIOCFG_QSPICLK_SRC_200M    (2UL)   /**< @brief 200MHz clock */
#define MCU_PIOCFG_QSPICLK_SRC_400M    (3UL)   /**< @brief 400MHz clock */
/** @} */

/**
    @name QSPI Clock Div's
    @{
    @brief QSPI Clock Div's

    @trace  #BRCM_SWARCH_MCU_CLKINIT_PROC
    @trace  #BRCM_SWREQ_MCU_INIT_V1
*/
typedef uint32_t MCU_PiocfgQSPIClkDivType;     /**< QSPI clock divider selection */
#define MCU_PIOCFG_QSPICLK_DIV_1       (0UL)   /**< @brief QSPI clock divider 1 */
#define MCU_PIOCFG_QSPICLK_DIV_2       (1UL)   /**< @brief QSPI clock divider 2 */
#define MCU_PIOCFG_QSPICLK_DIV_3       (2UL)   /**< @brief QSPI clock divider 3 */
#define MCU_PIOCFG_QSPICLK_DIV_4       (3UL)   /**< @brief QSPI clock divider 4 */
#define MCU_PIOCFG_QSPICLK_DIV_5       (4UL)   /**< @brief QSPI clock divider 5 */
#define MCU_PIOCFG_QSPICLK_DIV_6       (5UL)   /**< @brief QSPI clock divider 6 */
#define MCU_PIOCFG_QSPICLK_DIV_7       (6UL)   /**< @brief QSPI clock divider 7 */
#define MCU_PIOCFG_QSPICLK_DIV_8       (7UL)   /**< @brief QSPI clock divider 8 */
/** @} */

/** @brief Configuration type

    @trace  #BRCM_SWARCH_MCU_SYSCMDHANDLER_PROC
    @trace  #BRCM_SWARCH_MCU_GETCLKFREQ_PROC
    @trace  #BRCM_SWARCH_MCU_INIT_PROC
    @trace  #BRCM_SWARCH_MCU_CLKINIT_PROC
    @trace  #BRCM_SWARCH_MCU_RAMSECTIONINIT_PROC
    @trace  #BRCM_SWREQ_MCU_INIT_V1
*/
typedef struct sMCU_DrvConfigType {
    uint32_t            clkFailNotify;               /**< @brief clkFailNotify */
    MCU_ClkCfgType      clkCfgTbl[MCU_CLK_CFG_MAX];  /**< @brief clkCfgTbl */
    uint32_t            clkCfgTblSize;               /**< @brief clkCfgTblSize */
    MCU_RamSecCfgType   ramCfgTbl[MCU_RAM_CFG_MAX];  /**< @brief ramCfgTbl */
    uint32_t            ramCfgTblSize;               /**< @brief ramCfgTblSize */
} MCU_DrvConfigType;

/** @brief MCU Dev Type

    @trace  #BRCM_SWARCH_MCU_GETCLKFREQ_PROC
    @trace  #BRCM_SWARCH_MCU_INIT_PROC
    @trace  #BRCM_SWARCH_MCU_RAMSECTIONINIT_PROC
    @trace  #BRCM_SWARCH_MCU_CLKINIT_PROC
    @trace  #BRCM_SWARCH_MCU_ACTIVATEPLLCLOCKS_PROC
    @trace  #BRCM_SWARCH_MCU_GETPLLSTATUS_PROC
    @trace  #BRCM_SWARCH_MCU_SYSCMDHANDLER_PROC
    @trace  #BRCM_SWREQ_MCU_INIT_V1
*/
typedef struct sMCU_DevType {
    uint32_t init;  /**< @brief driver Initialized */
    MCU_VersionType version;
    MCU_InfoType info;
} MCU_DevType;

/** @brief MCU SVC IO Type

    @note Union to avoid MISRA Required error for Type conversion

    @trace  #BRCM_SWARCH_MCU_IO_TYPE
    @trace  #BRCM_SWREQ_MCU_KERNEL_INTERFACE
*/
typedef union uMCU_SVCIOType {
    uint8_t *data;
    MCU_IOType *io;
} MCU_SVCIOType;

/**
    @brief Chip Misc Register base address

    @trace  #BRCM_SWARCH_MCU_CLKINIT_PROC
    @trace  #BRCM_SWARCH_MCU_GETPLLSTATUS_PROC
    @trace  #BRCM_SWARCH_MCU_ACTIVATEPLLCLOCKS_PROC
    @trace  #BRCM_SWARCH_MCU_SYSCMDHANDLER_PROC
    @trace #BRCM_SWARCH_MCU_SETBOOTTIMEINFO_PROC
    @trace  #BRCM_SWREQ_MCU_INIT_V1
*/
static MCU_RDBType* const MCU_ChipMiscRegs = (MCU_RDBType *)MCU_BASE;

/**
    @brief CPU Register base address

    @trace  #BRCM_SWARCH_MCU_SYSCMDHANDLER_PROC
    @trace  #BRCM_SWARCH_MCU_GETDWNLDMODE_PROC
    @trace  #BRCM_SWARCH_MCU_SETBOOTINFO_PROC
    @trace  #BRCM_SWARCH_MCU_SYSCMDHANDLER_PROC
    @trace  #BRCM_SWREQ_MCU_INIT_V1
*/
static MCU_CPU_RDBType* const MCU_CPURegs = (MCU_CPU_RDBType *)MCU_CPU_BASE;

/**
    @brief BRPHY Register base address

    @trace  #BRCM_SWARCH_MCU_SYSCMDHANDLER_PROC
    @trace  #BRCM_SWREQ_MCU_INIT_V1
*/
static BRPHY_MII_RDBType* const MCU_BRPHYRegs = (BRPHY_MII_RDBType *)BRPHY0_BR_CL22_IEEE_BASE;

/**
    @brief Config Register base address

    @trace  #BRCM_SWARCH_MCU_INIT_PROC
    @trace  #BRCM_SWREQ_MCU_INIT_V1
*/
static CFG_RDBType *const MCU_PIOCfgRegs = (CFG_RDBType *)CFG_BASE;

/**
    @brief MCU Device

    @trace  #BRCM_SWARCH_MCU_SYSCMDHANDLER_PROC
    @trace  #BRCM_SWARCH_MCU_GETPLLSTATUS_PROC
    @trace  #BRCM_SWARCH_MCU_ACTIVATEPLLCLOCKS_PROC
    @trace  #BRCM_SWARCH_MCU_ACTIVATEPLLCLOCKS_PROC
    @trace  #BRCM_SWARCH_MCU_CLKINIT_PROC
    @trace  #BRCM_SWARCH_MCU_RAMSECTIONINIT_PROC
    @trace  #BRCM_SWARCH_MCU_INIT_PROC
    @trace  #BRCM_SWARCH_MCU_GETCLKFREQ_PROC
    @trace  #BRCM_SWREQ_MCU_INIT_V1
*/
static MCU_DevType MCU_Dev COMP_SECTION(".bss.drivers");

/**
    @brief MCU Driver Configuration

    @trace  #BRCM_SWARCH_MCU_CLKINIT_PROC
    @trace  #BRCM_SWARCH_MCU_RAMSECTIONINIT_PROC
    @trace  #BRCM_SWARCH_MCU_INIT_PROC
    @trace  #BRCM_SWARCH_MCU_GETCLKFREQ_PROC
    @trace  #BRCM_SWARCH_MCU_SYSCMDHANDLER_PROC
    @trace  #BRCM_SWREQ_MCU_INIT_V1
*/
static MCU_DrvConfigType MCU_DrvCfg COMP_SECTION(".bss.drivers");

/** @brief Peripheral Reset

    API to reset the peripherals

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aID     Perpheral ID

    @return     void

    @post None

    @trace  #BRCM_SWARCH_MCU_INIT_PROC
    @trace  #BRCM_SWREQ_MCU_INIT_V1

    @limitations None
*/
static void MCU_PiocfgPeriphReset(MCU_PiocfgPeriphIDType aId)
{
    uint32_t mask = 0UL;

    switch (aId) {
    case MCU_PIOCFG_PERIPHID_URT0:
        mask = CFG_PERIPH_RESET_URT_0_MASK;
        break;
    case MCU_PIOCFG_PERIPHID_URT1:
        mask = CFG_PERIPH_RESET_URT_1_MASK;
        break;
    case MCU_PIOCFG_PERIPHID_URT2:
        mask = CFG_PERIPH_RESET_URT_2_MASK;
        break;
    case MCU_PIOCFG_PERIPHID_AVT:
        mask = CFG_PERIPH_RESET_AVT_MASK;
        break;
    case MCU_PIOCFG_PERIPHID_I2C0:
        mask = CFG_PERIPH_RESET_I2C_0_MASK;
        break;
    case MCU_PIOCFG_PERIPHID_I2C1:
        mask = CFG_PERIPH_RESET_I2C_1_MASK;
        break;
    case MCU_PIOCFG_PERIPHID_I2C2:
        mask = CFG_PERIPH_RESET_I2C_2_MASK;
        break;
    case MCU_PIOCFG_PERIPHID_I2C3:
        mask = CFG_PERIPH_RESET_I2C_3_MASK;
        break;
    case MCU_PIOCFG_PERIPHID_CAN:
        mask = CFG_PERIPH_RESET_CAN_MASK;
        break;
    case MCU_PIOCFG_PERIPHID_QSPI0:
        mask = CFG_PERIPH_RESET_QSPI_0_MASK;
        break;
    case MCU_PIOCFG_PERIPHID_QSPI1:
        mask = CFG_PERIPH_RESET_QSPI_1_MASK;
        break;
    case MCU_PIOCFG_PERIPHID_I2S:
        mask = CFG_PERIPH_RESET_I2S_0_MASK;
        break;
    case MCU_PIOCFG_PERIPHID_TMR0:
        mask = CFG_PERIPH_RESET_TMR0_MASK;
        break;
    case MCU_PIOCFG_PERIPHID_ADC:
        mask = CFG_PERIPH_RESET_ADC_MASK;
        break;
    case MCU_PIOCFG_PERIPHID_SPI0:
        mask = CFG_PERIPH_RESET_SPI_0_MASK;
        break;
    case MCU_PIOCFG_PERIPHID_SPI1:
        mask = CFG_PERIPH_RESET_SPI_1_MASK;
        break;
    case MCU_PIOCFG_PERIPHID_SPI2:
        mask = CFG_PERIPH_RESET_SPI_2_MASK;
        break;
    case MCU_PIOCFG_PERIPHID_MMI:
        mask = CFG_PERIPH_RESET_MMI_MASK;
        break;
    default:
        break;
    }
    if (mask != 0UL) {
        MCU_PIOCfgRegs->periph_reset |= mask;
        MCU_PIOCfgRegs->periph_reset &= ~(mask);
    }
}

/** @brief Power up all peripherals

    API to power up all peripherals

    @behavior Sync, Re-entrant

    @pre None

    @param      None

    @return     void

    @post None

    @trace  #BRCM_SWARCH_MCU_INIT_PROC
    @trace  #BRCM_SWREQ_MCU_INIT_V1

    @limitations None
*/
static void MCU_PiocfgPeriphPowerUpAll(void)
{
    /* All peripherals are Power Up when bit is '0' but
       TIM0_REFDIV4_PCLKEN & WDT_REFDIV4_PCLKEN bit are '1' */
    MCU_PIOCfgRegs->periph_pwrdn = (CFG_PERIPH_PWRDN_WDT_REFDIV4_PCLKEN_MASK
                                | CFG_PERIPH_PWRDN_TIM0_REFDIV4_PCLKEN_MASK);
}

/** @brief Enable QSPI Interrupt

    API to enable QSPI Interrupt

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aId         Peripheral ID
    @param[in]      aIntrMask   Interrupt mask

    @return     void

    @post None

    @trace  #BRCM_SWARCH_MCU_INIT_PROC
    @trace  #BRCM_SWREQ_MCU_INIT_V1

    @limitations None
*/
static void MCU_PiocfgEnableQSPIInterrupt(MCU_PiocfgPeriphIDType aId, uint32_t aIntrMask)
{
    if (MCU_PIOCFG_PERIPHID_QSPI0 == aId) {
        MCU_PIOCfgRegs->qspi_io_control_0 &= (~aIntrMask);
        MCU_PIOCfgRegs->qspi_io_control_0 |= aIntrMask;
    }

    if (MCU_PIOCFG_PERIPHID_QSPI1 == aId) {
        MCU_PIOCfgRegs->qspi_io_control_1 &= (~aIntrMask);
        MCU_PIOCfgRegs->qspi_io_control_1 |= aIntrMask;
    }
}

/** @brief Disable QSPI Interrupt

    API to disable QSPI Interrupt

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aId         Peripheral ID
    @param[in]      aIntrMask   Interrupt mask

    @return     void

    @post None

    @trace  #BRCM_SWARCH_MCU_INIT_PROC
    @trace  #BRCM_SWREQ_MCU_INIT_V1

    @limitations None
*/
static void MCU_PiocfgDisableQSPIInterrupt(MCU_PiocfgPeriphIDType aId, uint32_t aIntrMask)
{
    if (MCU_PIOCFG_PERIPHID_QSPI0 == aId) {
        MCU_PIOCfgRegs->qspi_io_control_0 &= (~aIntrMask);
    }

    if (MCU_PIOCFG_PERIPHID_QSPI1 == aId) {
        MCU_PIOCfgRegs->qspi_io_control_1 &= (~aIntrMask);
    }
}

/** @brief Enable all QSPI Interrupts

    API to enable all QSPI Interrupts

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aId         Peripheral ID

    @return     void

    @post None

    @trace  #BRCM_SWARCH_MCU_INIT_PROC
    @trace  #BRCM_SWREQ_MCU_INIT_V1

    @limitations None
*/
static void MCU_PiocfgEnableAllQSPIInterrupt(MCU_PiocfgPeriphIDType aId)
{
    uint32_t intrMask = CFG_QSPI_IO_CONTROL_ENABLE_MSPI_HALT_SET_TRANSACTION_DONE_MASK
                        | CFG_QSPI_IO_CONTROL_ENABLE_MSPI_DONE_MASK
                        | CFG_QSPI_IO_CONTROL_ENABLE_SPI_OVERREAD_MASK
                        | CFG_QSPI_IO_CONTROL_ENABLE_SPI_LR_SESSION_DONE_MASK
                        | CFG_QSPI_IO_CONTROL_ENABLE_SPI_LR_IMPATIENT_MASK
                        | CFG_QSPI_IO_CONTROL_ENABLE_SPI_LR_TRUNCATED_MASK
                        | CFG_QSPI_IO_CONTROL_ENABLE_SPI_LR_FULLNESS_REACHED_MASK;

    MCU_PiocfgEnableQSPIInterrupt(aId, intrMask);
}

/** @brief Disable QSPI Error Interrupt

    API to disable QSPI Error Interrupt

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aId         Peripheral ID

    @return     void

    @post None

    @trace  #BRCM_SWARCH_MCU_INIT_PROC
    @trace  #BRCM_SWREQ_MCU_INIT_V1

    @limitations None
*/
static void MCU_PiocfgDisableQSPIErrInterrupt(MCU_PiocfgPeriphIDType aId)
{
    uint32_t intrMask = CFG_QSPI_IO_CONTROL_ENABLE_MSPI_HALT_SET_TRANSACTION_DONE_MASK
                        | CFG_QSPI_IO_CONTROL_ENABLE_SPI_OVERREAD_MASK
                        | CFG_QSPI_IO_CONTROL_ENABLE_SPI_LR_IMPATIENT_MASK
                        | CFG_QSPI_IO_CONTROL_ENABLE_SPI_LR_TRUNCATED_MASK;

    MCU_PiocfgDisableQSPIInterrupt(aId, intrMask);
}

/** @brief Set QSPI Clock

    API to set QSPI Clock

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aId             Peripheral ID
    @param[in]      aClkSrc         Clock source
    @param[in]      aClkDiv         Clock Div

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On success
    @retval     #BCM_ERR_INVAL_PARAMS   (aId is invalid) or
                                        (aClkSrc is invalid) or
                                        (aClkDiv is invalid)
    @retval     #BCM_ERR_TIME_OUT       QSPI Clock control time count
                                        expires

    @post None

    @trace  #BRCM_SWARCH_MCU_INIT_PROC
    @trace  #BRCM_SWREQ_MCU_INIT_V1

    @limitations None
*/
static int32_t MCU_PiocfgSetQSPIClk(MCU_PiocfgPeriphIDType aId,
                    MCU_PiocfgQSPIClkSrcType aClkSrc,
                    MCU_PiocfgQSPIClkDivType aClkDiv)
{
    int32_t retVal = BCM_ERR_OK;
    uint32_t i = 0UL;

    if ((aClkSrc > MCU_PIOCFG_QSPICLK_SRC_400M)
        || (aClkDiv > MCU_PIOCFG_QSPICLK_DIV_8)) {
        retVal = BCM_ERR_INVAL_PARAMS;
        goto err;
    }

    switch (aId) {
    case MCU_PIOCFG_PERIPHID_QSPI0:
        MCU_PIOCfgRegs->qspi_clk_ctrl &= (~(CFG_QSPI_CLK_CTRL_DIV_SEL_0_MASK
                                        | CFG_QSPI_CLK_CTRL_CLK_SEL_0_MASK));
        MCU_PIOCfgRegs->qspi_clk_ctrl |=
                                ((aClkSrc << CFG_QSPI_CLK_CTRL_CLK_SEL_0_SHIFT)
                                 & CFG_QSPI_CLK_CTRL_CLK_SEL_0_MASK);
        MCU_PIOCfgRegs->qspi_clk_ctrl |=
                                ((aClkDiv << CFG_QSPI_CLK_CTRL_DIV_SEL_0_SHIFT)
                                 & CFG_QSPI_CLK_CTRL_DIV_SEL_0_MASK);
        while(((MCU_PIOCfgRegs->qspi_clk_ctrl & CFG_QSPI_CLK_CTRL_SELDIV_DONE_0_MASK)
                != CFG_QSPI_CLK_CTRL_SELDIV_DONE_0_MASK)
            && (i < MCU_PIOCFG_QSPICLKCTRL_TIMEOUT_CNT)) {
            i++;
        }
        break;
    case MCU_PIOCFG_PERIPHID_QSPI1:
        MCU_PIOCfgRegs->qspi_clk_ctrl &= (~(CFG_QSPI_CLK_CTRL_DIV_SEL_1_MASK
                                        | CFG_QSPI_CLK_CTRL_CLK_SEL_1_MASK));
        MCU_PIOCfgRegs->qspi_clk_ctrl |=
                                ((aClkSrc << CFG_QSPI_CLK_CTRL_CLK_SEL_1_SHIFT)
                                 & CFG_QSPI_CLK_CTRL_CLK_SEL_1_MASK);
        MCU_PIOCfgRegs->qspi_clk_ctrl |=
                                ((aClkDiv << CFG_QSPI_CLK_CTRL_DIV_SEL_1_SHIFT)
                                 & CFG_QSPI_CLK_CTRL_DIV_SEL_1_MASK);
        while(((MCU_PIOCfgRegs->qspi_clk_ctrl & CFG_QSPI_CLK_CTRL_SELDIV_DONE_1_MASK)
                != CFG_QSPI_CLK_CTRL_SELDIV_DONE_1_MASK)
                && (i < MCU_PIOCFG_QSPICLKCTRL_TIMEOUT_CNT)) {
            i++;
        }
        break;
    default:
        /* TODO: Add abort */
        retVal = BCM_ERR_INVAL_PARAMS;
        break;
    }

    if ((BCM_ERR_OK == retVal) && (i == MCU_PIOCFG_QSPICLKCTRL_TIMEOUT_CNT)) {
        retVal = BCM_ERR_TIME_OUT;
    }
err:
    return retVal;
}

/** @brief MCU Is Initialized

    API to check if MCU is initialized

    @behavior Sync, Non-reentrant

    @pre None

    @param       none

    @return      MCU init state

    @post None

    @trace  #BRCM_SWARCH_MCU_SYSCMDHANDLER_PROC
    @trace  #BRCM_SWARCH_MCU_GETPLLSTATUS_PROC
    @trace  #BRCM_SWARCH_MCU_ACTIVATEPLLCLOCKS_PROC
    @trace  #BRCM_SWARCH_MCU_ACTIVATEPLLCLOCKS_PROC
    @trace  #BRCM_SWARCH_MCU_CLKINIT_PROC
    @trace  #BRCM_SWARCH_MCU_RAMSECTIONINIT_PROC
    @trace  #BRCM_SWARCH_MCU_INIT_PROC
    @trace  #BRCM_SWARCH_MCU_GETCLKFREQ_PROC
    @trace  #BRCM_SWREQ_MCU_INIT_V1
*/
static uint32_t MCU_IsInitialized(void)
{
    return MCU_Dev.init;
}

#if defined(__BCM8910X__)
/** @brief CAN Clock Initialization

    API to initialize CAN clock

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aCfg    Pointer to clock configuration

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On success
    @retval     #BCM_ERR_INVAL_PARAMS   Config ID is invalid

    @post None

    @trace  #BRCM_SWARCH_MCU_CLKINIT_PROC
    @trace  #BRCM_SWREQ_MCU_INIT_V1
*/
static int32_t MCU_DrvCANClkInit(const MCU_ClkCfgType *const aCfg)
{
    int32_t retVal = BCM_ERR_OK;

    /* Check parameters */
    if ((MCU_CAN_CLK_CFG_MIN > aCfg->clkRef.freq)
        || (MCU_CAN_CLK_CFG_MAX < aCfg->clkRef.freq)) {
        retVal = BCM_ERR_INVAL_PARAMS;
        goto err;
    }

    switch(aCfg->cfgID) {
        case MCU_CLK_CFG_ID_CAN:
            MCU_ChipMiscRegs->pllsys_mdiv_2 &= (uint16_t)~(MCU_PLLSYS_MDIV_2_CH3_MDIV_MASK);
            MCU_ChipMiscRegs->pllsys_mdiv_2 |= (uint16_t)(MCU_VCO_CLOCK / aCfg->clkRef.freq) << MCU_PLLSYS_MDIV_2_CH3_MDIV_SHIFT;
            MCU_ChipMiscRegs->pllsys_cfg_3 = (uint16_t)0x0000U;
            break;
        default:
            retVal = BCM_ERR_INVAL_PARAMS;
            break;
    }

err:
    return retVal;
}
#endif

/** @brief QSPI Clock Initialization

    API to initialize QSPI clock

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aCfg    Pointer to clock configuration

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On success
    @retval     #BCM_ERR_INVAL_PARAMS   Config ID is invalid

    @post None

    @trace  #BRCM_SWARCH_MCU_CLKINIT_PROC
    @trace  #BRCM_SWREQ_MCU_INIT_V1
*/
static int32_t MCU_DrvQspiClkInit(const MCU_ClkCfgType *const aCfg)
{
    MCU_PiocfgPeriphIDType periphID;
    MCU_PiocfgQSPIClkSrcType src;
    MCU_PiocfgQSPIClkDivType div;
    int32_t err = BCM_ERR_OK;

    switch(aCfg->cfgID) {
        case MCU_CLK_CFG_ID_QSPI0_SRC400_80MHZ:
            periphID = MCU_PIOCFG_PERIPHID_QSPI0;
            src = MCU_PIOCFG_QSPICLK_SRC_400M;
            div = MCU_PIOCFG_QSPICLK_DIV_5;
            break;
        case MCU_CLK_CFG_ID_QSPI0_SRC400_66MHZ:
            periphID = MCU_PIOCFG_PERIPHID_QSPI0;
            src = MCU_PIOCFG_QSPICLK_SRC_400M;
            div = MCU_PIOCFG_QSPICLK_DIV_6;
            break;
        case MCU_CLK_CFG_ID_QSPI0_SRC400_50MHZ:
            periphID = MCU_PIOCFG_PERIPHID_QSPI0;
            src = MCU_PIOCFG_QSPICLK_SRC_400M;
            div = MCU_PIOCFG_QSPICLK_DIV_8;
            break;
        case MCU_CLK_CFG_ID_QSPI0_SRC200_25MHZ:
            periphID = MCU_PIOCFG_PERIPHID_QSPI0;
            src = MCU_PIOCFG_QSPICLK_SRC_200M;
            div = MCU_PIOCFG_QSPICLK_DIV_8;
            break;
        case MCU_CLK_CFG_ID_QSPI1_SRC400_80MHZ:
            periphID = MCU_PIOCFG_PERIPHID_QSPI1;
            src = MCU_PIOCFG_QSPICLK_SRC_400M;
            div = MCU_PIOCFG_QSPICLK_DIV_5;
            break;
        case MCU_CLK_CFG_ID_QSPI1_SRC400_66MHZ:
            periphID = MCU_PIOCFG_PERIPHID_QSPI1;
            src = MCU_PIOCFG_QSPICLK_SRC_400M;
            div = MCU_PIOCFG_QSPICLK_DIV_6;
            break;
        case MCU_CLK_CFG_ID_QSPI1_SRC400_50MHZ:
            periphID = MCU_PIOCFG_PERIPHID_QSPI1;
            src = MCU_PIOCFG_QSPICLK_SRC_400M;
            div = MCU_PIOCFG_QSPICLK_DIV_8;
            break;
        case MCU_CLK_CFG_ID_QSPI1_SRC200_25MHZ:
            periphID = MCU_PIOCFG_PERIPHID_QSPI1;
            src = MCU_PIOCFG_QSPICLK_SRC_200M;
            div = MCU_PIOCFG_QSPICLK_DIV_8;
            break;
        default:
            err = BCM_ERR_INVAL_PARAMS;
            break;
    }

    if (err == BCM_ERR_OK) {
        MCU_PiocfgSetQSPIClk(periphID, src, div);
    }
    return err;
}

/** @brief Get version

    API to get version

    @behavior Sync, Re-entrant

    @pre None

    @param[inout]           aVersion      Pointer to version

    @return     void

    @post None

    @trace  #BRCM_SWARCH_MCU_SYSCMDHANDLER_PROC
    @trace  #BRCM_SWREQ_MCU_QUERY_V1

    @limitations None
*/
void MCU_GetVersion(MCU_VersionType *const aVersion)
{
    if (NULL != aVersion) {
        BCM_MemCpy((void*)aVersion, (void*)&MCU_Dev.version, sizeof(MCU_VersionType));
    }
}


/** @brief Clock Initialization

    API to initialize clock

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aCfg    Pointer to clock configuration

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On success
    @retval     #BCM_ERR_INVAL_PARAMS   Clock ID is invalid
    @return     Others                  As returned by #MCU_DrvQspiClkInit or
                                        by #AVT_SetNCOFreq

    @post None

    @trace  #BRCM_SWARCH_MCU_CLKINIT_PROC
    @trace  #BRCM_SWREQ_MCU_INIT_V1
*/
static int32_t MCU_DrvClkInitInt(const MCU_ClkCfgType *const aCfg)
{
    int32_t err = BCM_ERR_OK;
    MCU_VersionType version;

    MCU_GetVersion(&version);
    switch (aCfg->clkRef.clkID) {
    case MCU_CLK_ID_PLL_SYS:
#if defined(__BCM8910X__)
        if (CHIP_VERSION_C0 <= version.rev) {
            err = MCU_DrvCANClkInit(aCfg);
        }
#endif
        break;
    case MCU_CLK_ID_PLL_DISPLAY:
        /*
         * Write to the configuration register
         */
        MCU_ChipMiscRegs->clk_pinstrap = (uint16_t)aCfg->clkRef.cntrl[0];
        MCU_ChipMiscRegs->plldisp_ctrl_1 = (uint16_t)aCfg->clkRef.cntrl[1];
        MCU_ChipMiscRegs->plldisp_ctrl_2 = (uint16_t)aCfg->clkRef.cntrl[2];
        MCU_ChipMiscRegs->plldisp_ctrl_3 = (uint16_t)aCfg->clkRef.cntrl[3];
        MCU_ChipMiscRegs->plldisp_ndiv_frac = (uint16_t)aCfg->clkRef.cntrl[4];
        MCU_ChipMiscRegs->plldisp_ndiv = (uint16_t)aCfg->clkRef.cntrl[5];
        MCU_ChipMiscRegs->plldisp_cfg_1 = (uint16_t)aCfg->clkRef.cntrl[6];
        MCU_ChipMiscRegs->plldisp_cfg_2 = (uint16_t)aCfg->clkRef.cntrl[7];
        MCU_ChipMiscRegs->plldisp_cfg_3 = (uint16_t)aCfg->clkRef.cntrl[8];
        break;
    case MCU_CLK_ID_PLL_VID:
        break;
    case MCU_CLK_ID_PLL_DDR:
        break;
    case MCU_CLK_ID_QSPI:
        err = MCU_DrvQspiClkInit(aCfg);
        break;
    case MCU_CLK_ID_NCO0:
        /* Set frequency for NCO channel 0 */
        err = AVT_SetNCOFreq(AVT_NCO_CHANID_0, aCfg->clkRef.freq);
        break;
    case MCU_CLK_ID_NCO1:
        /* Set frequency for NCO channel 1 */
        err = AVT_SetNCOFreq(AVT_NCO_CHANID_1, aCfg->clkRef.freq);
        break;
    case MCU_CLK_ID_NCO2:
        /* Set frequency for NCO channel 2 */
        err = AVT_SetNCOFreq(AVT_NCO_CHANID_2, aCfg->clkRef.freq);
        break;
    default:
        err = BCM_ERR_INVAL_PARAMS;
        break;
    }
    return err;
}

/** @brief Peripheral initialization

    API to initialize peripherals

    @behavior Sync, Re-entrant

    @pre None

    @param      None

    @return     void

    @post None

    @trace  #BRCM_SWARCH_MCU_INIT_PROC
    @trace  #BRCM_SWREQ_MCU_INIT_V1

    @limitations None
*/
static void MCU_DrvPeriphInit(void)
{
    /* Power up all peripherals */
    MCU_PiocfgPeriphPowerUpAll();

    /* Reset all peripherals */
    MCU_PiocfgPeriphReset(MCU_PIOCFG_PERIPHID_URT0);
    MCU_PiocfgPeriphReset(MCU_PIOCFG_PERIPHID_URT1);
    MCU_PiocfgPeriphReset(MCU_PIOCFG_PERIPHID_URT2);
    MCU_PiocfgPeriphReset(MCU_PIOCFG_PERIPHID_AVT);
    MCU_PiocfgPeriphReset(MCU_PIOCFG_PERIPHID_I2C0);
    MCU_PiocfgPeriphReset(MCU_PIOCFG_PERIPHID_I2C1);
    MCU_PiocfgPeriphReset(MCU_PIOCFG_PERIPHID_I2C2);
    MCU_PiocfgPeriphReset(MCU_PIOCFG_PERIPHID_I2C3);
    MCU_PiocfgPeriphReset(MCU_PIOCFG_PERIPHID_CAN);
    MCU_PiocfgPeriphReset(MCU_PIOCFG_PERIPHID_QSPI0);
    MCU_PiocfgPeriphReset(MCU_PIOCFG_PERIPHID_QSPI1);
    MCU_PiocfgPeriphReset(MCU_PIOCFG_PERIPHID_I2S);
    MCU_PiocfgPeriphReset(MCU_PIOCFG_PERIPHID_TMR0);
    MCU_PiocfgPeriphReset(MCU_PIOCFG_PERIPHID_ADC);
    MCU_PiocfgPeriphReset(MCU_PIOCFG_PERIPHID_SPI0);
    MCU_PiocfgPeriphReset(MCU_PIOCFG_PERIPHID_SPI1);
    MCU_PiocfgPeriphReset(MCU_PIOCFG_PERIPHID_SPI2);
    MCU_PiocfgPeriphReset(MCU_PIOCFG_PERIPHID_MMI);
    MCU_PiocfgEnableAllQSPIInterrupt(MCU_PIOCFG_PERIPHID_QSPI0);
    MCU_PiocfgEnableAllQSPIInterrupt(MCU_PIOCFG_PERIPHID_QSPI1);
    MCU_PiocfgDisableQSPIErrInterrupt(MCU_PIOCFG_PERIPHID_QSPI0);
    MCU_PiocfgDisableQSPIErrInterrupt(MCU_PIOCFG_PERIPHID_QSPI1);

    /* Enbale MDIO */
    MCU_PIOCfgRegs->misc_ctrl = CFG_MISC_CTRL_VREG_MDIO_EN_MASK;
}

/** @brief Get reset mode

    API to get MCU reset mode

    @behavior Sync, Re-entrant

    @pre None

    @param      None

    @return     returns MCU reset mode

    @post None

    @trace  #BRCM_SWARCH_MCU_SYSCMDHANDLER_PROC
    @trace  #BRCM_SWREQ_MCU_QUERY_V1

    @limitations None
*/
static MCU_ResetModeType MCU_DrvGetResetMode(void)
{
    uint32_t dwnldMode;
    MCU_ResetModeType resetMode;

    uint32_t reg =  MCU_CPURegs->dbg_scratch;
    reg = reg >> 16UL;
    dwnldMode = ((reg & MCU_RESET_INFO_DWNLD_MODE_MASK) >> MCU_RESET_INFO_DWNLD_MODE_SHIFT);
    if ((reg & MCU_RESET_INFO_RAMDUMP_MASK) != 0UL) {
        resetMode = MCU_RESETMODE_RAMDUMP;
    } else if (dwnldMode != 0UL) {
        switch (dwnldMode) {
        case MCU_RESET_INFO_DWNLD_MODE_TFTP:
            resetMode = MCU_RESETMODE_DWNLD_TFTP;
            break;
        case MCU_RESET_INFO_DWNLD_MODE_RAM:
            resetMode = MCU_RESETMODE_DWNLD_RAM;
            break;
        default:
            resetMode = MCU_RESETMODE_NONE;
            break;
        }
    } else {
        resetMode = MCU_RESETMODE_NONE;
    }

    return resetMode;
}

/** @brief Get default reset mode

    @trace  #BRCM_SWARCH_MCU_GETDEFAULTRESETMODE_PROC
    @trace  #BRCM_SWREQ_MCU_QUERY_V1
*/
MCU_ResetModeType MCU_GetDefaultResetMode(void)
{
    return MCU_RESETMODE_DWNLD_TFTP;
}

/** Get download mode

    @trace  #BRCM_SWARCH_MCU_GETDWNLDMODE_PROC
    @trace  #BRCM_SWREQ_MCU_QUERY_V1
*/
MCU_DwnldModeType MCU_GetDwnldMode(void)
{
    MCU_DwnldModeType mode;
    uint32_t reg =  MCU_CPURegs->dbg_scratch;
    reg = reg >> 16UL;
    if ((reg & MCU_RESET_INFO_DWNLD_MODE_PARTIAL_MASK) != 0UL) {
        mode = MCU_DWNLD_MODE_PARTIAL;
    } else {
        mode = MCU_DWNLD_MODE_VIRGIN;
    }

    return mode;
}

/**
    @trace  #BRCM_SWARCH_MCU_SETBOOTINFO_PROC
    @trace  #BRCM_SWREQ_MCU_QUERY_V1
*/
void MCU_SetBootInfo(PTBL_IdType aPid, uint8_t aFlsId)
{
    uint32_t value = 0UL;
    uint32_t mask = 0UL;
    uint32_t pid = ((aPid & PTBL_ID_TYPE_MASK) >> PTBL_ID_TYPE_SHIFT);
    uint32_t copy = ((aPid & PTBL_ID_COPY_MASK) >> PTBL_ID_COPY_SHIFT);
    uint32_t fls = (aFlsId & 0x1UL);
    switch (pid) {
    case PTBL_ID_BL:
        mask |= MCU_BOOT_INFO_BL_COPY_ID_MASK;
        mask |= MCU_BOOT_INFO_BL_FLASH_ID_MASK;
        mask |= MCU_BOOT_INFO_BL_EXECUTED_MASK;
        value |= ((copy << MCU_BOOT_INFO_BL_COPY_ID_SHIFT) & MCU_BOOT_INFO_BL_COPY_ID_MASK);
        value |= ((fls << MCU_BOOT_INFO_BL_FLASH_ID_SHIFT) & MCU_BOOT_INFO_BL_FLASH_ID_MASK);
        value |= MCU_BOOT_INFO_BL_EXECUTED_MASK;
    break;
    case PTBL_ID_SYSCFG:
        mask |= MCU_BOOT_INFO_SYSCFG_COPY_ID_MASK;
        mask |= MCU_BOOT_INFO_SYSCFG_FLASH_ID_MASK;
        mask |= MCU_BOOT_INFO_SYSCFG_EXECUTED_MASK;
        value |= ((copy << MCU_BOOT_INFO_SYSCFG_COPY_ID_SHIFT) & MCU_BOOT_INFO_SYSCFG_COPY_ID_MASK);
        value |= ((fls << MCU_BOOT_INFO_SYSCFG_FLASH_ID_SHIFT) & MCU_BOOT_INFO_SYSCFG_FLASH_ID_MASK);
        value |= MCU_BOOT_INFO_SYSCFG_EXECUTED_MASK;
    break;
    case PTBL_ID_FW:
        mask |= MCU_BOOT_INFO_FW_COPY_ID_MASK;
        mask |= MCU_BOOT_INFO_FW_FLASH_ID_MASK;
        mask |= MCU_BOOT_INFO_FW_EXECUTED_MASK;
        value |= ((copy << MCU_BOOT_INFO_FW_COPY_ID_SHIFT) & MCU_BOOT_INFO_FW_COPY_ID_MASK);
        value |= ((fls << MCU_BOOT_INFO_FW_FLASH_ID_SHIFT) & MCU_BOOT_INFO_FW_FLASH_ID_MASK);
        value |= MCU_BOOT_INFO_FW_EXECUTED_MASK;
    break;
    default:
    break;
    }
    MCU_CPURegs->dbg_scratch &= ~(mask);
    MCU_CPURegs->dbg_scratch |= (value & mask);
}

/** @brief Set reset mode

    API to set MCU reset mode

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aResetMode      Reset mode

    @return     void

    @post None

    @trace  #BRCM_SWARCH_MCU_SYSCMDHANDLER_PROC
    @trace  #BRCM_SWREQ_MCU_DYNAMIC_CONFIG_V1

    @limitations None
*/
static void MCU_DrvSetResetMode(MCU_ResetModeType aResetMode)
{
    uint32_t value = 0UL;
    switch (aResetMode) {
    case MCU_RESETMODE_DWNL:
        value = (MCU_RESET_INFO_SW_RESET_MASK
                | (MCU_RESET_INFO_DWNLD_MODE_TFTP << MCU_RESET_INFO_DWNLD_MODE_SHIFT));
        MCU_CPURegs->dbg_scratch |= (value << 16UL);
        break;
    case MCU_RESETMODE_RAMDUMP:
        value = MCU_RESET_INFO_RAMDUMP_MASK;
        MCU_CPURegs->dbg_scratch |= (value << 16UL);
        break;
    default:
        break;
    }
}

/** @brief Get BL Boot information

    @trace  #BRCM_SWARCH_MCU_GETBLBOOTINFO_PROC
    @trace  #BRCM_SWREQ_MCU_QUERY_V1
*/
int32_t MCU_GetBLBootInfo(uint32_t * const aBootInfo)
{
    return BCM_ERR_NOSUPPORT;
}


/** @brief Get FW Boot information

    API to get FW Boot information

    @behavior Sync, Re-entrant

    @pre None

    @param[inout]      aBootInfo      Pointer to boot info

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @retval     #BCM_ERR_INVAL_PARAMS   aBootInfo is NULL

    @post None

    @trace  #BRCM_SWARCH_MCU_SYSCMDHANDLER_PROC
    @trace  #BRCM_SWREQ_MCU_QUERY_V1

    @limitations None
*/
static int32_t MCU_DrvGetBootInfo(PTBL_IdType * const aPid, uint8_t * const aFlsId)
{
    int32_t err = BCM_ERR_INVAL_PARAMS;
    if ((NULL != aPid) && (NULL != aFlsId)) {
        uint32_t value = MCU_CPURegs->dbg_scratch;
        uint32_t copy = 0UL;
        uint32_t fls = 0UL;
        switch (*aPid) {
        case PTBL_ID_BL:
            copy = (value & MCU_BOOT_INFO_BL_COPY_ID_MASK) >> MCU_BOOT_INFO_BL_COPY_ID_SHIFT;
            fls = (value & MCU_BOOT_INFO_BL_FLASH_ID_MASK) >> MCU_BOOT_INFO_BL_FLASH_ID_SHIFT;
            err = BCM_ERR_OK;
        break;
        case PTBL_ID_SYSCFG:
            copy = (value & MCU_BOOT_INFO_SYSCFG_COPY_ID_MASK) >> MCU_BOOT_INFO_SYSCFG_COPY_ID_SHIFT;
            fls = (value & MCU_BOOT_INFO_SYSCFG_FLASH_ID_MASK) >> MCU_BOOT_INFO_SYSCFG_FLASH_ID_SHIFT;
            err = BCM_ERR_OK;
        break;
        case PTBL_ID_FW:
            copy = (value & MCU_BOOT_INFO_FW_COPY_ID_MASK) >> MCU_BOOT_INFO_FW_COPY_ID_SHIFT;
            fls = (value & MCU_BOOT_INFO_FW_FLASH_ID_MASK) >> MCU_BOOT_INFO_FW_FLASH_ID_SHIFT;
            err = BCM_ERR_OK;
        break;
        default:
        break;
        }
        if (BCM_ERR_OK == err) {
            *aPid = PTBL_ID_CONSTRUCT(*aPid, copy);
            *aFlsId = fls;
        }
    }
    return err;
}

/** @brief Set display handshake source

    API to set display handshake source

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aChannel        Channel
    @param[in]      aSrcId          Source ID

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @retval     #BCM_ERR_INVAL_PARAMS   (aChannel is invalid) or
                                        (aSrcId is invalid)

    @post None

    @trace  #BRCM_SWARCH_MCU_SYSCMDHANDLER_PROC
    @trace  #BRCM_SWREQ_MCU_EXTENSION_V1

    @limitations None
*/
static void MCU_DrvSetDispHsSrc(MCU_CpuDHSChType aChannel,
                          MCU_CpuDHSIDType aSrcId)
{
    int32_t ret = BCM_ERR_OK;
    uint32_t mask = 0UL;

    if ((aChannel == MCU_CPUDHSCH_0) || (aChannel == MCU_CPUDHSCH_1)) {
        switch (aSrcId) {
        case MCU_CPUDHSID_CPU:
            if (aChannel == MCU_CPUDHSCH_0) {
                mask = MCU_CPU_DHSCTL_DHS0SELCPU_MASK;
            } else {
                mask = MCU_CPU_DHSCTL_DHS1SELCPU_MASK;
            }

            break;
        case MCU_CPUDHSID_DISPLAY:
            if (aChannel == MCU_CPUDHSCH_0) {
                mask = MCU_CPU_DHSCTL_DHS0SELDISPLAY_MASK;
            } else {
                mask = MCU_CPU_DHSCTL_DHS1SELDISPLAY_MASK;
            }
            break;
        case MCU_CPUDHSID_ISP:
            if (aChannel == MCU_CPUDHSCH_0) {
                mask = MCU_CPU_DHSCTL_DHS0SELIMG_MASK;
            } else {
                mask = MCU_CPU_DHSCTL_DHS1SELIMG_MASK;
            }
            break;
        default:
            ret = BCM_ERR_INVAL_PARAMS;
            break;
        }
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }

    if (BCM_ERR_OK != ret) {
        goto err;
    }

    /* Before setting the bits, clear it first */
    if (MCU_CPUDHSCH_0 == aChannel) {
        MCU_CPURegs->dhs_ctl &= ~MCU_CPU_DHS_CTL_0_SEL_MASK;
        MCU_CPURegs->dhs_ctl |= mask;
    } else {
        MCU_CPURegs->dhs_ctl &= ~MCU_CPU_DHS_CTL_1_SEL_MASK;
        MCU_CPURegs->dhs_ctl |= mask;
    }
err:
    return;
}

/** @brief Display handshake trigger

    API to trigger display handshake

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aChannel        Channel
    @param[in]      aBufAttr        Buffer attribute

    @return     void

    @post None

    @trace  #BRCM_SWARCH_MCU_SYSCMDHANDLER_PROC
    @trace  #BRCM_SWREQ_MCU_EXTENSION_V1

    @limitations None
*/
static void MCU_DrvDispHsTrigger(MCU_CpuDHSChType aChannel, uint32_t aBufAttr)
{
    switch (aChannel) {
    case MCU_CPUDHSCH_0:
        MCU_CPURegs->dhs_ctl &= ~(MCU_CPU_DHS_CTL_0_BA_MASK
                                    | MCU_CPU_DHS_CTL_0_ACK_MASK
                                    | MCU_CPU_DHS_CTL_0_READY_MASK);
        MCU_CPURegs->dhs_ctl |= (((aBufAttr << MCU_CPU_DHS_CTL_0_BA_SHIFT)
                    & MCU_CPU_DHS_CTL_0_BA_MASK) | MCU_CPU_DHS_CTL_0_READY_MASK);
        break;
    case MCU_CPUDHSCH_1:
        MCU_CPURegs->dhs_ctl &= ~(MCU_CPU_DHS_CTL_1_BA_MASK
                                    | MCU_CPU_DHS_CTL_1_ACK_MASK
                                    | MCU_CPU_DHS_CTL_1_READY_MASK);
        MCU_CPURegs->dhs_ctl |= (((aBufAttr << MCU_CPU_DHS_CTL_1_BA_SHIFT)
                    & MCU_CPU_DHS_CTL_1_BA_MASK) | MCU_CPU_DHS_CTL_1_READY_MASK);
        break;
    default:
        break;
    }
}

/** @brief Get reset reason

    API to get MCU reset reason

    @behavior Sync, Re-entrant

    @pre None

    @param      None

    @return     Returns MCU reset reason

    @post None

    @trace  #BRCM_SWARCH_MCU_SYSCMDHANDLER_PROC
    @trace  #BRCM_SWREQ_MCU_QUERY_V1

    @limitations None
*/
static MCU_ResetReasonType MCU_DrvGetResetReason(void)
{
    MCU_ResetReasonType reason;

    if (MCU_IsInitialized() == TRUE) {
        uint32_t nmiStatusReg = MCU_CPURegs->nmi_sts_shd;
        if ((nmiStatusReg & MCU_CPU_NMI_STS_SHD_WDOG_SHD_MASK)
                == MCU_CPU_NMI_STS_SHD_WDOG_SHD_MASK) {
            reason = MCU_RESETREASON_WD;
        } else {
            uint32_t dbgScratchReg = MCU_CPURegs->dbg_scratch;
            dbgScratchReg = dbgScratchReg >> 16UL;
            dbgScratchReg = (dbgScratchReg & MCU_RESET_INFO_RESET_REASON_MASK)
                                >> MCU_RESET_INFO_RESET_REASON_SHIFT;
            if ((dbgScratchReg & MCU_RESET_INFO_SW_RESET_MASK) != 0UL) {
                reason = MCU_RESETREASON_SW;
            } else {
                reason = MCU_RESETREASON_POWER_ON;
            }
        }
    } else {
        reason = MCU_RESETREASON_UNDEFINED;
    }

    return reason;
}

/** @brief Get reset raw value

    API to get reset raw value

    @behavior Sync, Re-entrant

    @pre None

    @param      None

    @return     Returns MCU reset raw value

    @post None

    @trace  #BRCM_SWARCH_MCU_SYSCMDHANDLER_PROC
    @trace  #BRCM_SWREQ_MCU_QUERY_V1

    @limitations None
*/
static uint32_t MCU_DrvGetResetRawValue(void)
{
    return MCU_CPURegs->dbg_scratch >> 16UL;
}

/** @brief Reset request

    API to reset request

    @behavior Sync, Re-entrant

    @pre None

    @param[in]          aResetReq      Reset request

    @return     void

    @post None

    @trace  #BRCM_SWARCH_MCU_SYSCMDHANDLER_PROC
    @trace  #BRCM_SWREQ_MCU_DYNAMIC_CONFIG_V1

    @limitations None
*/
static void MCU_DrvResetReq(MCU_ResetReqType aResetReq)
{
    if (MCU_IsInitialized() == TRUE) {
        switch (aResetReq) {
        case MCU_RESETREQ_GLOBAL:
            MCU_CPURegs->dbg_scratch |= (MCU_RESET_INFO_SW_RESET_MASK << 16UL);
            CORTEX_MX_SystemReset();
            break;
        case MCU_RESETREQ_LOCAL:
            MCU_CPURegs->dbg_scratch |= (MCU_RESET_INFO_SW_RESET_MASK << 16UL);
            CORTEX_MX_VectorReset();
            break;
        default:
            break;
        }
    }
}

/** @brief Get PLL status

    API to get PLL status

    @behavior Sync, Re-entrant

    @pre None

    @param      None

    @return     Returns PLL status

    @post None

    @trace  #BRCM_SWARCH_MCU_GETPLLSTATUS_PROC
    @trace  #BRCM_SWARCH_MCU_ACTIVATEPLLCLOCKS_PROC
    @trace  #BRCM_SWREQ_MCU_QUERY_V1

    @limitations None
*/
static MCU_PllStatusType MCU_IntGetPllStatus(void)
{
    MCU_PllStatusType status = MCU_PLLSTATUS_UNDEFINED;
    uint32_t sysPllLock = FALSE;
    uint32_t dispPllLock = FALSE;
    uint32_t vidPllLock = FALSE;
    uint16_t reg;

    if (MCU_IsInitialized() == TRUE) {
        reg = MCU_ChipMiscRegs->pllsys_status;
        if ((reg & MCU_PLLSYS_STATUS_LOCK_MASK) != 0U) {
            sysPllLock = TRUE;
        }

        reg = MCU_ChipMiscRegs->plldisp_status;
        if ((reg & MCU_PLLDISP_STATUS_LOCK_MASK) != 0U) {
            dispPllLock = TRUE;
        }

        reg = MCU_ChipMiscRegs->pllvid_status;
        if ((reg & MCU_PLLVID_STATUS_LOCK_MASK) != 0U) {
            vidPllLock = TRUE;
        }
        if ((sysPllLock == TRUE) && (dispPllLock == TRUE) &&
                (vidPllLock == TRUE)) {
            status = MCU_PLLSTATUS_LOCKED;
        } else {
            status = MCU_PLLSTATUS_UNLOCKED;
        }
    }
    return status;
}

/** @brief Get PLL status

    @trace  #BRCM_SWARCH_MCU_GETPLLSTATUS_PROC
    @trace  #BRCM_SWREQ_MCU_QUERY_V1
*/
MCU_PllStatusType MCU_GetPllStatus(void)
{
    return MCU_IntGetPllStatus();
}

/** @brief Activate PLL Clocks

    @trace  #BRCM_SWARCH_MCU_ACTIVATEPLLCLOCKS_PROC
    @trace  #BRCM_SWREQ_MCU_DYNAMIC_CONFIG_V1
*/
int32_t MCU_ActivatePllClocks(void)
{
    int32_t err = BCM_ERR_OK;

    if (MCU_IsInitialized() == TRUE) {
        if (MCU_IntGetPllStatus() != MCU_PLLSTATUS_LOCKED) {
            err = BCM_ERR_INVAL_STATE;
        }
    } else {
        err = BCM_ERR_UNINIT;
    }
    return err;
}

/** @brief MCU Clock initialization

    @trace  #BRCM_SWARCH_MCU_CLKINIT_PROC
    @trace  #BRCM_SWREQ_MCU_INIT_V1
*/
int32_t MCU_ClkInit(MCU_ClkCfgIDType aCfgID)
{
    int err = BCM_ERR_OK;
    uint32_t i;

    if (MCU_IsInitialized() == TRUE) {
        /* lookup if aCfgID is present
         * in MCU configuration data
         */
        for (i = 0UL; i < MCU_DrvCfg.clkCfgTblSize; i++) {
            if (MCU_DrvCfg.clkCfgTbl[i].cfgID == aCfgID) {
                err = MCU_DrvClkInitInt(&MCU_DrvCfg.clkCfgTbl[i]);
                break;
            }
        }
    } else {
        err = BCM_ERR_UNINIT;
    }
    return err;
}

/** @brief RAM section initialization

    @trace  #BRCM_SWARCH_MCU_RAMSECTIONINIT_PROC
    @trace  #BRCM_SWREQ_MCU_INIT_V1
*/
void MCU_RamSectionInit(MCU_RamSectionIDType aID)
{
    if (MCU_IsInitialized() == TRUE) {
        if (aID < MCU_DrvCfg.ramCfgTblSize) {
            BCM_MemSet(MCU_DrvCfg.ramCfgTbl[aID].baseAddr,
                        (int32_t)MCU_DrvCfg.ramCfgTbl[aID].defaultVal,
                       MCU_DrvCfg.ramCfgTbl[aID].size);
        }
    }
}

/** @brief Get Boot time Information

    API to get Boot time Information

    @behavior Sync, Re-entrant

    @pre None

    @param[inout]      aBootTime    Pointer to stacking info

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @retval     #BCM_ERR_INVAL_PARAMS   aBootTime is NULL

    @post None

    @trace  #BRCM_SWARCH_MCU_SYSCMDHANDLER_PROC
    @trace  #BRCM_SWARCH_MCU_GETBOOTTIMEINFO_PROC
    @trace  #BRCM_SWREQ_MCU_QUERY_V1

    @limitations None
*/
static int32_t MCU_DrvGetBootTimeInfo(MCU_BootTimeInfoType *const aBootTime)
{
    int32_t retVal = BCM_ERR_OK;

    if (NULL != aBootTime) {
        aBootTime->blBootTime = MCU_ChipMiscRegs->spare_reg_0 & 0xFFU;
        aBootTime->fwBootTime = (MCU_ChipMiscRegs->spare_reg_0 & 0xFF00U) >> 8U;
    } else {
        retVal = BCM_ERR_INVAL_PARAMS;
    }
    return retVal;
}

/** @brief Set Boot time information

    @trace #BRCM_SWARCH_MCU_SETBOOTTIMEINFO_PROC
    @trace #BRCM_SWREQ_MCU_DYNAMIC_CONFIG_V1
*/
int32_t MCU_SetBootTimeInfo(const MCU_BootTimeInfoType *const aBootTime)
{
    int32_t retVal = BCM_ERR_OK;

    if (NULL != aBootTime) {
        MCU_ChipMiscRegs->spare_reg_0 = ((aBootTime->blBootTime & 0xFFU) |
                                        ((aBootTime->fwBootTime & 0xFFU) << 8U));
    } else {
        retVal = BCM_ERR_INVAL_PARAMS;
    }
    return retVal;
}

/** @brief MCU Initialization

    @trace  #BRCM_SWARCH_MCU_INIT_PROC
    @trace  #BRCM_SWREQ_MCU_INIT_V1
*/
void MCU_Init(const MCU_ConfigType *const aConfig)
{
    uint16_t lsb;
    uint16_t msb;

    if (MCU_IsInitialized() == FALSE) {
        if (aConfig != NULL) {
            BCM_MemSet(&MCU_DrvCfg, 0x0, sizeof(MCU_DrvCfg));
            if ((aConfig->clkCfgTbl != NULL) && (aConfig->clkCfgTblSize > 0UL) &&
                    (aConfig->clkCfgTblSize < MCU_CLK_CFG_MAX)) {
                /* copy the clock configuration table */
                BCM_MemCpy(&MCU_DrvCfg.clkCfgTbl[0], aConfig->clkCfgTbl,
                        aConfig->clkCfgTblSize * sizeof(MCU_ClkCfgType));
                MCU_DrvCfg.clkCfgTblSize = aConfig->clkCfgTblSize;
                MCU_DrvCfg.clkFailNotify = aConfig->clkSrcFailNotification;
            }
            if ((aConfig->ramCfgTbl != NULL) && (aConfig->ramCfgTblSize > 0UL) &&
                    (aConfig->ramCfgTblSize < MCU_RAM_CFG_MAX)) {
                BCM_MemCpy(&MCU_DrvCfg.ramCfgTbl[0], aConfig->ramCfgTbl,
                        aConfig->ramCfgTblSize * sizeof(MCU_RamSecCfgType));
                MCU_DrvCfg.ramCfgTblSize = aConfig->ramCfgTblSize;
            }
        }

        MCU_DrvPeriphInit();
        MCU_Dev.init = TRUE;

        lsb = MCU_BRPHYRegs->phy_id_lsb;
        msb = MCU_BRPHYRegs->phy_id_msb;

        MCU_Dev.version.rev = (uint32_t)((lsb & BRPHY_MII_PHY_ID_LSB_REVISION_MASK) >>
                BRPHY_MII_PHY_ID_LSB_REVISION_SHIFT);
        MCU_Dev.version.model = ((lsb & BRPHY_MII_PHY_ID_LSB_MODEL_MASK) >>
                BRPHY_MII_PHY_ID_LSB_MODEL_SHIFT);
        MCU_Dev.version.manuf = (msb & BRPHY_MII_PHY_ID_MSB_OUI_MSB_MASK);
        MCU_Dev.version.manuf |= ((lsb & BRPHY_MII_PHY_ID_LSB_OUI_LSB_MASK) >>
                BRPHY_MII_PHY_ID_LSB_OUI_LSB_SHIFT) << 19U;
        MCU_Dev.version.securityMode = MCU_SECURITY_MODE_UNKNOWN;
    }
}

/** @brief Get clock frequency

    @trace  #BRCM_SWARCH_MCU_GETCLKFREQ_PROC
    @trace  #BRCM_SWREQ_MCU_QUERY_V1
*/
uint32_t MCU_GetClkFreq(MCU_ClkCfgIDType aCfgID)
{
    uint32_t i;
    uint32_t clkFreq = 0UL;

    if (MCU_IsInitialized() != TRUE) {
        goto err;
    }

    for (i = 0UL; i < MCU_DrvCfg.clkCfgTblSize; ++i) {
        if (MCU_DrvCfg.clkCfgTbl[i].cfgID == aCfgID) {
            clkFreq = MCU_DrvCfg.clkCfgTbl[i].clkRef.freq;
            break;
        }
    }

err:
    return clkFreq;
}

/** @brief Adjust clock frequency

    API to adjust clock frequency

    @behavior Sync, Re-entrant

    @pre None

    @param[in]          aCfgID          Clock config ID
    @param[in]          aCorrection     Correction required

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @retval     #BCM_ERR_INVAL_PARAMS   aCfgID is invalid
    @retval     #BCM_ERR_UNINIT         MCU is not in intialized state
    @retval     #BCM_ERR_NOSUPPORT      If Clock ID is invalid
    @return     Others                  As returned by #AVT_TuneNCOFreq

    @post None

    @trace  #BRCM_SWARCH_MCU_SYSCMDHANDLER_PROC
    @trace  #BRCM_SWREQ_MCU_DYNAMIC_CONFIG_V1

    @limitations None
*/
static int32_t MCU_DrvAdjustClkFreq(MCU_ClkCfgIDType aCfgID, int32_t aCorrection)
{
    int32_t ret;
    uint32_t i;

    ret = BCM_ERR_INVAL_PARAMS;

    if (MCU_IsInitialized() != TRUE) {
        ret = BCM_ERR_UNINIT;
        goto err;
    }

    for (i = 0UL; i < MCU_DrvCfg.clkCfgTblSize; ++i) {
        if (MCU_DrvCfg.clkCfgTbl[i].cfgID == aCfgID) {
            ret = BCM_ERR_OK;
            break;
        }
    }

    if (BCM_ERR_OK == ret) {
        switch(MCU_DrvCfg.clkCfgTbl[i].clkRef.clkID) {
        case MCU_CLK_ID_NCO0:
            ret = AVT_TuneNCOFreq(AVT_NCO_CHANID_0, aCorrection);
            break;

        case MCU_CLK_ID_NCO1:
            ret = AVT_TuneNCOFreq(AVT_NCO_CHANID_1, aCorrection);
            break;

        case MCU_CLK_ID_NCO2:
            ret = AVT_TuneNCOFreq(AVT_NCO_CHANID_2, aCorrection);
            break;

        default:
            ret = BCM_ERR_NOSUPPORT;
            break;
        }
    }

err:
    return ret;
}

/** @brief MCU Sys command handler

    @code{.c}
    if aSysIO.mcuIO is not NULL
        if aMagicID is MCU_SVC_MAGIC_ID
            aSysIO.mcuIO.retVal = MCU_CmdHandler(aCmd, aSysIO.mcuIO)
        else
            aSysIO.mcuIO.retVal = BCM_ERR_INVAL_MAGIC
    @endcode

    @trace  #BRCM_SWARCH_MCU_SYSCMDHANDLER_PROC
    @trace  #BRCM_SWREQ_MCU_KERNEL_HANDLER_V1
*/
void MCU_SysCmdHandler(uint32_t aMagicID, uint32_t aCmd, uint8_t * aSysIO)
{
    MCU_SVCIOType mcu;
    mcu.data = aSysIO;
    int32_t ret = BCM_ERR_OK;

    if (aSysIO != NULL) {
        if (aMagicID == SVC_MAGIC_MCU_ID) {
            switch (aCmd) {
            case MCU_CMD_RESET_REQ:
                MCU_DrvResetReq(mcu.io->resetReq);
                break;
            case MCU_CMD_GET_RESET_REASON:
                mcu.io->resetReason = MCU_DrvGetResetReason();
                break;
            case MCU_CMD_GET_RAW_VAL:
                mcu.io->resetRaw = MCU_DrvGetResetRawValue();
                break;
            case MCU_CMD_SET_LPM_MODE:
                break;
            case MCU_CMD_SET_DHS_SRC:
                MCU_DrvSetDispHsSrc(mcu.io->channel, mcu.io->srcID);
                break;
            case MCU_CMD_DHS_TRIGGER:
                MCU_DrvDispHsTrigger(mcu.io->channel, mcu.io->bufAttr);
                break;
            case MCU_CMD_GET_RESET_MODE:
                mcu.io->resetMode = MCU_DrvGetResetMode();
                break;
            case MCU_CMD_SET_RESET_MODE:
                MCU_DrvSetResetMode(mcu.io->resetMode);
                break;
            case MCU_CMD_GET_FW_BOOT_INFO:
                ret = MCU_DrvGetBootInfo(&mcu.io->pid, &mcu.io->flsId);
                break;
            case MCU_CMD_ADJUST_CLK:
                ret = MCU_DrvAdjustClkFreq(mcu.io->clkCfgID, mcu.io->correction);
                break;
            case MCU_CMD_GET_BOOT_TIME:
                ret = MCU_DrvGetBootTimeInfo(mcu.io->bootTime);
                break;
            case MCU_CMD_SET_INFO:
                ret = BCM_ERR_NOSUPPORT;
                break;
            case MCU_CMD_SET_SECURITY_MODE:
                if (MCU_IsInitialized() != TRUE) {
                    ret = BCM_ERR_UNINIT;
                } else if (mcu.io->securityMode > MCU_SECURITY_MODE_MAX) {
                    ret = BCM_ERR_INVAL_PARAMS;
                } else {
                    MCU_Dev.version.securityMode = mcu.io->securityMode;
                    /* ret is initialised as BCM_ERR_OK, hence nothing more to do */
                }
                break;
            default:
                ret = BCM_ERR_INVAL_PARAMS;
                break;
            }
            mcu.io->retVal = ret;
        } else {
            ret = BCM_ERR_INVAL_MAGIC;
        }
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }

    if (BCM_ERR_OK != ret) {
        const uint32_t values[4UL] = {aMagicID, aCmd, (uint32_t)aSysIO, 0UL};
        BCM_ReportError(BCM_MCU_ID, 0U, BRCM_SWARCH_MCU_SYSCMDHANDLER_PROC, ret, 4UL, values);
    }
}

/** @brief Get MCU Info

    API to get mcu Info

    @behavior Sync, Re-entrant

    @pre None

    @param[inout]      aInfo    Pointer to mcu info

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @retval     #BCM_ERR_INVAL_PARAMS   aInfo is NULL

    @post None

    @trace  #BRCM_SWARCH_MCU_SYSCMDHANDLER_PROC
    @trace  #BRCM_SWREQ_MCU_QUERY_V1

    @limitations None
*/
int32_t MCU_GetInfo(MCU_InfoType * const aInfo)
{
    int32_t retVal = BCM_ERR_OK;

    if (NULL != aInfo) {
        BCM_MemCpy((void*)aInfo, (void*)&MCU_Dev.info, sizeof(MCU_InfoType));
    } else {
        retVal = BCM_ERR_INVAL_PARAMS;
    }

    return retVal;
}
/** @} */
