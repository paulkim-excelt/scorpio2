/*****************************************************************************
 Copyright 2020-2022 Broadcom Limited.  All rights reserved.

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

    @file mcu_drv.c
    @brief MCU driver low level implementation for bcm8957x
    This header file contains the MCU driver implementation for bcm8957x

    @version 0.86 Imported from docx
*/

#include <inttypes.h>
#include <string.h>
#include <compiler.h>
#include <bcm_utils.h>
#include <bcm_err.h>
#include <mcu.h>
#include <mcu_osil.h>
#include <mcu_clk.h>
#include <svc.h>
#include <crg_rdb.h>
#include <chipmisc_rdb.h>
#include <brphy_mii_rdb.h>
#include <cfg_rdb.h>
#include <dmu_rdb.h>
#include <io_rdb.h>
#include <cortex_mx.h>
#include <switch_rdb.h>

/**
    @name MCU Design IDs
    @{
    @brief Design IDs for MCU
*/
#define BRCM_SWDSGN_MCU_MHZ_MACRO                                 (0xB701U)    /**< @brief #MCU_MHZ                          */
#define BRCM_SWDSGN_MCU_DMUQCLKDIV_TYPE                           (0xB702U)    /**< @brief #MCU_DMUQCLKDivType               */
#define BRCM_SWDSGN_MCU_DEV_TYPE                                  (0xB703U)    /**< @brief #MCU_DevType                      */
#define BRCM_SWDSGN_MCU_SVC_IO_TYPE                               (0xB704U)    /**< @brief #MCU_SVCIOType                    */
#define BRCM_SWDSGN_MCU_CHIP_MISC_REGS_GLOBAL                     (0xB705U)    /**< @brief #MCU_ChipMiscRegs                 */
#define BRCM_SWDSGN_MCU_CRG_REGS_GLOBAL                           (0xB706U)    /**< @brief #MCU_CRGRegs                      */
#define BRCM_SWDSGN_MCU_BRPHY_MII_REGS_GLOBAL                     (0xB707U)    /**< @brief #MCU_BRPHYMIIRegs                 */
#define BRCM_SWDSGN_MCU_DMU_REGS_GLOBAL                           (0xB708U)    /**< @brief #MCU_DMURegs                      */
#define BRCM_SWDSGN_MCU_CFG_REGS_GLOBAL                           (0xB709U)    /**< @brief #MCU_CFGRegs                      */
#define BRCM_SWDSGN_MCU_IO_REGS_GLOBAL                            (0xB70AU)    /**< @brief #MCU_IORegs                       */
#define BRCM_SWDSGN_MCU_DEV_GLOBAL                                (0xB70BU)    /**< @brief #MCU_Dev                          */
#define BRCM_SWDSGN_MCU_FLASH_CLK_TBL_GLOBAL                      (0xB70CU)    /**< @brief #MCU_FlashClkTbl                  */
#define BRCM_SWDSGN_MCU_FLASH_CLK_TBL_PTR_GLOBAL                  (0xB70DU)    /**< @brief #MCU_FlashClkTblPtr               */
#define BRCM_SWDSGN_MCU_FLASH_CLK_TBL_SZ_GLOBAL                   (0xB70EU)    /**< @brief #MCU_FlashClkTblSz                */
#define BRCM_SWDSGN_MCU_CFG_ENABLE_ALL_QSPI_INTERRUPT_PROC        (0xB70FU)    /**< @brief #MCU_CFGEnableAllQSPIInterrupt    */
#define BRCM_SWDSGN_MCU_CFG_DISABLE_QSPI_ERR_INTERRUPT_PROC       (0xB710U)    /**< @brief #MCU_CFGDisableQSPIErrInterrupt   */
#define BRCM_SWDSGN_MCU_SWITCHINTERRUPTCLEAR_PROC                 (0xB711U)    /**< @brief #MCU_SwitchInterruptClear         */
#define BRCM_SWDSGN_MCU_DMU_PERIPH_POWER_UP_ALL_PROC              (0xB712U)    /**< @brief #MCU_DMUPeriphPowerUpAll          */
#define BRCM_SWDSGN_MCU_DMU_SET_QCLK_PROC                         (0xB713U)    /**< @brief #MCU_DMUSetQClk                   */
#define BRCM_SWDSGN_MCU_IS_INITIALIZED_PROC                       (0xB714U)    /**< @brief #MCU_IsInitialized                */
#define BRCM_SWDSGN_MCU_QSPI_CLK_INIT_PROC                        (0xB715U)    /**< @brief #MCU_QspiClkInit                  */
#define BRCM_SWDSGN_MCU_INT_CLK_INIT_PROC                         (0xB716U)    /**< @brief #MCU_IntClkInit                   */
#define BRCM_SWDSGN_MCU_DRV_PERIPH_INIT_PROC                      (0xB717U)    /**< @brief #MCU_DrvPeriphInit                */
#define BRCM_SWDSGN_MCU_DRV_GET_RESET_REASON_PROC                 (0xB718U)    /**< @brief #MCU_DrvGetResetReason            */
#define BRCM_SWDSGN_MCU_DRV_GET_RESET_RAW_VALUE_PROC              (0xB719U)    /**< @brief #MCU_DrvGetResetRawValue          */
#define BRCM_SWDSGN_MCU_DRV_GET_RESET_MODE_PROC                   (0xB71AU)    /**< @brief #MCU_DrvGetResetMode              */
#define BRCM_SWDSGN_MCU_DRV_SET_RESET_MODE_PROC                   (0xB71BU)    /**< @brief #MCU_DrvSetResetMode              */
#define BRCM_SWDSGN_MCU_GET_BL_BOOT_INFO_PROC                     (0xB71CU)    /**< @brief #MCU_GetBLBootInfo                */
#define BRCM_SWDSGN_MCU_GET_DEFAULT_RESET_PROC                    (0xB71DU)    /**< @brief #MCU_GetDefaultResetMode          */
#define BRCM_SWDSGN_MCU_GET_DWNLD_MODE_PROC                       (0xB71EU)    /**< @brief #MCU_GetDwnldMode                 */
#define BRCM_SWDSGN_MCU_DRV_SET_FW_BOOT_INFO_PROC                 (0xB71FU)    /**< @brief #MCU_SetBootInfo                  */
#define BRCM_SWDSGN_MCU_DRV_GET_FW_BOOT_INFO_PROC                 (0xB720U)    /**< @brief #MCU_DrvGetBootInfo               */
#define BRCM_SWDSGN_MCU_DRV_RESET_REQ_PROC                        (0xB721U)    /**< @brief #MCU_DrvResetReq                  */
#define BRCM_SWDSGN_MCU_DRV_INT_GET_PLL_STATUS_PROC               (0xB722U)    /**< @brief #MCU_DrvGetPllStatus              */
#define BRCM_SWDSGN_MCU_DRV_GET_VERSION_PROC                      (0xB723U)    /**< @brief #MCU_GetVersion                   */
#define BRCM_SWDSGN_MCU_DRV_GET_SWITCH_PORT2TIME_FIFO_MAP_PROC    (0xB724U)    /**< @brief #MCU_DrvGetSwitchPort2TimeFifoMap */
#define BRCM_SWDSGN_MCU_DRV_ENABLE_SWITCH_CPU_PORT_PROC           (0xB725U)    /**< @brief #MCU_DrvEnableSwitchCPUPort       */
#define BRCM_SWDSGN_MCU_DRV_DISABLE_SWITCH_CPU_PORT_PROC          (0xB726U)    /**< @brief #MCU_DrvDisableSwitchCPUPort      */
#define BRCM_SWDSGN_MCU_DRV_GET_INFO_PROC                         (0xB727U)    /**< @brief #MCU_GetInfo                      */
#define BRCM_SWDSGN_MCU_DRV_GET_BOOT_TIME_INFO_PROC               (0xB728U)    /**< @brief #MCU_DrvGetBootTimeInfo           */
#define BRCM_SWDSGN_MCU_SET_BOOT_TIME_INFO_PROC                   (0xB729U)    /**< @brief #MCU_SetBootTimeInfo              */
#define BRCM_SWDSGN_MCU_SYSCMDHANDLER_PROC                        (0xB72AU)    /**< @brief #MCU_SysCmdHandler                */
#define BRCM_SWDSGN_MCU_INIT_PROC                                 (0xB72BU)    /**< @brief #MCU_Init                         */
#define BRCM_SWDSGN_MCU_RAM_SECTION_INIT_PROC                     (0xB72CU)    /**< @brief #MCU_RamSectionInit               */
#define BRCM_SWDSGN_MCU_ACTIVATE_PLL_CLOCKS_PROC                  (0xB72DU)    /**< @brief #MCU_ActivatePllClocks            */
#define BRCM_SWDSGN_MCU_GET_PLL_STATUS_PROC                       (0xB72EU)    /**< @brief #MCU_GetPllStatus                 */
#define BRCM_SWDSGN_MCU_CLK_INIT_PROC                             (0xB630U)    /**< @brief #MCU_ClkInit                      */
#define BRCM_SWDSGN_MCU_GET_CLK_FREQ_PROC                         (0xB632U)    /**< @brief #MCU_GetClkFreq                   */
#define BRCM_SWDSGN_MCU_DRV_SET_INFO_PROC                         (0xB634U)    /**< @brief #MCU_DrvSetInfo                   */
#define BRCM_SWDSGN_MCU_SET_SERDES_CLK_PROC                       (0xB72FU)    /**< @brief #MCU_SetSerDesClk                 */
#define BRCM_SWDSGN_MCU_ENABLE_SGMIIPLUS2_PROC                    (0xB730U)    /**< @brief #MCU_Enable_SGMIIPLUS2            */
#define BRCM_SWDSGN_MCU_ENABLE_PCIE_PROC                          (0xB731U)    /**< @brief #MCU_Enable_PCIe                  */
#define BRCM_SWDSGN_MCU_SGMIIPLUS2_CTRL_COUNT_MACRO               (0xB732U)    /**< @brief #MCU_SGMIIPLUS2_CTRL_COUNT        */
#define BRCM_SWDSGN_MCU_MCU_SGMIIPCIE_MODE_PCIE_MACRO             (0xB733U)    /**< @brief #MCU_SGMIIPCIE_MODE_PCIE          */
#define BRCM_SWDSGN_MCU_SGMII_CTRL_POWERUP_MASK_MACRO             (0xB734U)    /**< @brief #MCU_SGMII_CTRL_POWERUP_MASK      */
#define BRCM_SWDSGN_MCU_IS_SGMIIPLUS2_CTRL_POWERUP_MACRO          (0xB735U)    /**< @brief #MCU_IS_SGMIIPLUS2_CTRL_POWERUP   */
#define BRCM_SWDSGN_MCU_SET_SGMIIPLUS2_CTRL_STATE_MACRO           (0xB736U)    /**< @brief #MCU_SET_SGMIIPLUS2_CTRL_STATE    */
#define BRCM_SWDSGN_MCU_REG_WRITE32_MACRO                         (0xB737U)    /**< @brief #MCU_REG_WRITE32                  */
#define BRCM_SWDSGN_MCU_SWRCONFIGURE_PROC                         (0xB738U)    /**< @brief #MCU_SwrConfigure                 */
#define BRCM_SWDSGN_MCU_SWRVERFIFYBITRESET_PROC                   (0xB739U)    /**< @brief #MCU_SwrVerifyBitReset            */
#define BRCM_SWDSGN_MCU_SWRCHECK_PMUSTABLE_PROC                   (0xB73AU)    /**< @brief #MCU_SwrCheckPmuStable            */
#define BRCM_SWDSGN_MCU_SWITCH_REGS_GLOBAL                        (0xB73BU)    /**< @brief #MCU_SWITCHRegs                   */
#define BRCM_SWDSGN_MCU_ENABLE_SGMII_PCIE_PROC                    (0xB73CU)    /**< @brief #MCU_Enable_SGMII_PCIe            */
#define BRCM_SWDSGN_MCU_POWERUPSGMIIPCIE_X1_PROC                  (0xB73DU)    /**< @brief #MCU_PowerUpSGMIIPCIE_X1          */
#define BRCM_SWDSGN_MCU_SGMIIPCIE_MODE_SGMII_MACRO                (0xB73EU)    /**< @brief #MCU_SGMIIPCIE_MODE_SGMII         */
#define BRCM_SWDSGN_MCU_ENABLE_SGMIIPLUSR_PROC                    (0xB73FU)    /**< @brief #MCU_Enable_SGMIIPLUSR            */
/** @} */

/** @brief QCLK (QSPI clk) divisor type

    @trace #BRCM_SWARCH_MCU_INIT_PROC
    @trace #BRCM_SWREQ_MCU_QUERY_BCM8957X
 */
#define MCU_MHZ(x)          (x * 1000000UL)

/**
    @name QCLK (QSPI clk) divisor type
    @{

    @brief QCLK (QSPI clk) divisor type

    @trace #BRCM_SWARCH_MCU_INIT_PROC
    @trace #BRCM_SWREQ_MCU_INIT_BCM8957X
 */
typedef uint32_t MCU_DMUQCLKDivType;
#define MCU_DMUQCLKDIV3                  (DMU_QCLK_DIV_3_VAL)   /**< @brief SPI_ROOT_CLK / 3 */
#define MCU_DMUQCLKDIV4                  (DMU_QCLK_DIV_4_VAL)   /**< @brief SPI_ROOT_CLK / 4 */
#define MCU_DMUQCLKDIV5                  (DMU_QCLK_DIV_5_VAL)   /**< @brief SPI_ROOT_CLK / 5 */
#define MCU_DMUQCLKDIV10                 (DMU_QCLK_DIV_10_VAL)  /**< @brief SPI_ROOT_CLK / 10 */
/** @} */

/**
    @trace #BRCM_SWARCH_MCU_SETSERDESCLK_PROC
    @trace #BRCM_SWARCH_MCU_RESETSERDESCLK_PROC
    @trace #BRCM_SWREQ_MCU_INIT_BCM8957X
*/
#define MCU_SGMIIPLUS2_CTRL_COUNT    2UL

/**
    @trace #BRCM_SWARCH_MCU_SETSERDESCLK_PROC
    @trace #BRCM_SWREQ_MCU_INIT_BCM8957X
*/
#define MCU_SGMIIPCIE_MODE_SGMII    1UL

/**
    @trace #BRCM_SWARCH_MCU_SETSERDESCLK_PROC
    @trace #BRCM_SWREQ_MCU_INIT_BCM8957X
*/
#define MCU_SGMIIPCIE_MODE_PCIE     2UL

/**
    @trace #BRCM_SWARCH_MCU_SETSERDESCLK_PROC
    @trace #BRCM_SWARCH_MCU_RESETSERDESCLK_PROC
    @trace #BRCM_SWREQ_MCU_INIT_BCM8957X
*/
#define MCU_SGMII_CTRL_POWERUP_MASK    0x01


/**
    @trace #BRCM_SWARCH_MCU_SETSERDESCLK_PROC
    @trace #BRCM_SWARCH_MCU_RESETSERDESCLK_PROC
    @trace #BRCM_SWREQ_MCU_INIT_BCM8957X
*/
#define MCU_IS_SGMIIPLUS2_CTRL_POWERUP(cntrlID) \
                ((MCU_Dev.aSGMIIPLUS2PowerUpState >> cntrlID) & MCU_SGMII_CTRL_POWERUP_MASK)

/**
    @trace #BRCM_SWARCH_MCU_SETSERDESCLK_PROC
    @trace #BRCM_SWARCH_MCU_RESETSERDESCLK_PROC
    @trace #BRCM_SWREQ_MCU_INIT_BCM8957X
*/
#define MCU_SET_SGMIIPLUS2_CTRL_STATE(cntrlID) \
               (MCU_Dev.aSGMIIPLUS2PowerUpState | (MCU_SGMII_CTRL_POWERUP_MASK << cntrlID))
/**
    @trace #BRCM_SWARCH_MCU_SETSERDESCLK_PROC
    @trace #BRCM_SWARCH_MCU_RESETSERDESCLK_PROC
    @trace #BRCM_SWREQ_MCU_INIT_BCM8957X
*/
#define MCU_REG_WRITE32(addr, val)   \
    (*((volatile uint32_t *) (addr)) = (uint32_t)(val))
/** @brief MCU Dev type

    @trace #BRCM_SWARCH_MCU_INIT_PROC
    @trace #BRCM_SWARCH_MCU_CLKINIT_PROC
    @trace #BRCM_SWARCH_MCU_GETCLKFREQ_PROC
    @trace #BRCM_SWARCH_MCU_RAMSECTIONINIT_PROC
    @trace #BRCM_SWARCH_MCU_ACTIVATEPLLCLOCKS_PROC
    @trace #BRCM_SWARCH_MCU_SYSCMDHANDLER_PROC
    @trace #BRCM_SWREQ_MCU_INIT_BCM8957X
 */
typedef struct sMCU_DevType {
    uint32_t init;  /**< @brief driver Initialized */
    const MCU_ConfigType *config;
    MCU_InfoType info;
    MCU_VersionType version;
    uint32_t aSGMIIPLUS2PowerUpState;
    uint32_t aSGMIIPCIEPowerUpState;
    uint32_t aSGMIIPLUSRPowerUpState;
} MCU_DevType;

/** @brief SVC IO Type

    @note Union to avoid MISRA Required error for Type conversion

    @trace  #BRCM_SWARCH_MCU_SYSCMDHANDLER_PROC
    @trace  #BRCM_SWREQ_MCU_KERNEL_INTERFACE
*/
typedef union uMCU_SVCIOType {
    uint8_t *data;
    MCU_IOType *io;
} MCU_SVCIOType;

/** @brief Chip Misc register base address

    @trace #BRCM_SWARCH_MCU_SYSCMDHANDLER_PROC
    @trace #BRCM_SWREQ_MCU_INIT_BCM8957X
 */
static CHIPMISC_RDBType* const MCU_ChipMiscRegs = (CHIPMISC_RDBType *)CHIPMISC_BASE;

/** @brief CRG Register base address

    @trace #BRCM_SWARCH_MCU_SYSCMDHANDLER_PROC
    @trace #BRCM_SWREQ_MCU_INIT_BCM8957X
 */
static CRG_RDBType * const MCU_CRGRegs = (CRG_RDBType *)CRG_BASE;

/** @brief BRPHY MII Register base address

    @trace #BRCM_SWARCH_MCU_SYSCMDHANDLER_PROC
    @trace #BRCM_SWREQ_MCU_INIT_BCM8957X
 */
static BRPHY_MII_RDBType * const MCU_BRPHYMIIRegs = (BRPHY_MII_RDBType *)BRPHY1_BR_CL22_IEEE_BASE;

/** @brief DMU Register base address

    @trace #BRCM_SWARCH_MCU_INIT_PROC
    @trace #BRCM_SWARCH_MCU_CLKINIT_PROC
    @trace #BRCM_SWREQ_MCU_INIT_BCM8957X
 */
static DMU_RDBType * const MCU_DMURegs = (DMU_RDBType *)DMU_BASE;

/** @brief CFG Register base address

    @trace #BRCM_SWARCH_MCU_INIT_PROC
    @trace #BRCM_SWREQ_MCU_INIT_BCM8957X
 */
static CFG_RDBType *const MCU_CFGRegs = (CFG_RDBType *)CFG_BASE;

/** @brief CFG Register base address

   @trace #BRCM_SWARCH_MCU_INIT_PROC
   @trace #BRCM_SWREQ_MCU_INIT_BCM8957X
 */
static IO_RDBType *const MCU_IORegs = (IO_RDBType *)IO_BASE;

/** @brief SWITCH Register base address

     @trace #BRCM_SWARCH_MCU_INIT_PROC
     @trace #BRCM_SWREQ_MCU_INIT_BCM8957X
  */
static SWITCH_RDBType *const MCU_SWITCHRegs = (SWITCH_RDBType *)SWITCH_BASE;

/** @brief MCU Dev

    @trace #BRCM_SWARCH_MCU_INIT_PROC
    @trace #BRCM_SWARCH_MCU_CLKINIT_PROC
    @trace #BRCM_SWARCH_MCU_GETCLKFREQ_PROC
    @trace #BRCM_SWARCH_MCU_RAMSECTIONINIT_PROC
    @trace #BRCM_SWARCH_MCU_ACTIVATEPLLCLOCKS_PROC
    @trace #BRCM_SWARCH_MCU_SYSCMDHANDLER_PROC
    @trace #BRCM_SWREQ_MCU_INIT_BCM8957X
 */
static MCU_DevType MCU_Dev COMP_SECTION(".bss.drivers");

/** @brief MCU flash Clock IDs table

    @trace #BRCM_SWARCH_MCU_CLKINIT_PROC
    @trace #BRCM_SWREQ_MCU_INIT_BCM8957X
*/
static const MCU_ClkCfgIDType MCU_FlashClkTbl[] = {
#ifdef ENABLE_FLASH0
    MCU_CLK_CFG_ID_QSPI0_SRC250_83MHZ,
#endif /* ENABLE_FLASH0 */
};

/** @brief MCU flash Clock IDs table pointer

    @trace #BRCM_SWARCH_MCU_CLKINIT_PROC
    @trace #BRCM_SWARCH_MCU_FLASH_CLK_TBL_PTR_GLOBAL
    @trace #BRCM_SWREQ_MCU_INIT_BCM8957X
*/
const MCU_ClkCfgIDType * const MCU_FlashClkTblPtr = MCU_FlashClkTbl;

/** @brief MCU flash Clock IDs table size

    @trace #BRCM_SWARCH_MCU_CLKINIT_PROC
    @trace #BRCM_SWARCH_MCU_FLASH_CLK_TBL_SZ_GLOBAL
    @trace #BRCM_SWREQ_MCU_INIT_BCM8957X
*/
const uint32_t MCU_FlashClkTblSz = (sizeof(MCU_FlashClkTbl) /
                                    sizeof(MCU_ClkCfgIDType));

/** @brief CFG Enable all QSPI Interrupts

    API to enable all QSPI interrupts

    @behavior Sync, Re-entrant

    @pre None

    @param      None

    @return     void

    @post None

    @trace #BRCM_SWARCH_MCU_INIT_PROC
    @trace #BRCM_SWREQ_MCU_INIT_BCM8957X

    @limitations None
*/
static void MCU_CFGEnableAllQSPIInterrupt(void)
{
    uint32_t mask = CFG_QSPI_IO_CONTROL_ENABLE_MSPI_HALT_SET_TRANSACTION_DONE_MASK
                        | CFG_QSPI_IO_CONTROL_ENABLE_MSPI_DONE_MASK
                        | CFG_QSPI_IO_CONTROL_ENABLE_SPI_OVERREAD_MASK
                        | CFG_QSPI_IO_CONTROL_ENABLE_SPI_LR_SESSION_DONE_MASK
                        | CFG_QSPI_IO_CONTROL_ENABLE_SPI_LR_IMPATIENT_MASK
                        | CFG_QSPI_IO_CONTROL_ENABLE_SPI_LR_TRUNCATED_MASK
                        | CFG_QSPI_IO_CONTROL_ENABLE_SPI_LR_FULLNESS_REACHED_MASK;

    MCU_CFGRegs->qspi_io_control |= mask;
}

/** @brief CFG Disable QSPI Error Interrupt

    API to disable QSPI error interrupt

    @behavior Sync, Re-entrant

    @pre None

    @param      None

    @return     void

    @post None

    @trace #BRCM_SWARCH_MCU_INIT_PROC
    @trace #BRCM_SWREQ_MCU_INIT_BCM8957X

    @limitations None
*/
static void MCU_CFGDisableQSPIErrInterrupt(void)
{
    uint32_t mask = CFG_QSPI_IO_CONTROL_ENABLE_MSPI_HALT_SET_TRANSACTION_DONE_MASK
                        | CFG_QSPI_IO_CONTROL_ENABLE_SPI_OVERREAD_MASK
                        | CFG_QSPI_IO_CONTROL_ENABLE_SPI_LR_IMPATIENT_MASK
                        | CFG_QSPI_IO_CONTROL_ENABLE_SPI_LR_TRUNCATED_MASK;

    MCU_CFGRegs->qspi_io_control &= ~mask;
}

/** @brief DMU Peripheral Power Up All

    API to power up all DMU peripherals

    @behavior Sync, Re-entrant

    @pre None

    @param      None

    @return     void

    @post None

    @trace #BRCM_SWARCH_MCU_INIT_PROC
    @trace #BRCM_SWREQ_MCU_INIT_BCM8957X

    @limitations None
*/
static void MCU_DMUPeriphPowerUpAll(void)
{
    MCU_DMURegs->pwd_blk1 = 0x0UL;
    MCU_DMURegs->pwd_blk2 = 0x0UL;
}

/** @brief DMU Set QCLk

    API to set QCLk

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aDiv    QClk devive ID

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On success
    @retval     #BCM_ERR_INVAL_PARAMS   aDiv is invalid

    @post None

    @trace #BRCM_SWARCH_MCU_CLKINIT_PROC
    @trace #BRCM_SWREQ_MCU_INIT_BCM8957X

    @limitations None
*/
static int32_t MCU_DMUSetQClk(MCU_DMUQCLKDivType aDiv)
{
    int32_t ret = BCM_ERR_OK;
    uint32_t clkSel = MCU_DMURegs->clk_sel;
    clkSel &= ~(DMU_CLK_SEL_QCLK_SEL_MASK);

    switch (aDiv) {
    case MCU_DMUQCLKDIV3:
        clkSel |= (MCU_DMUQCLKDIV3 << DMU_CLK_SEL_QCLK_SEL_SHIFT);
        break;
    case MCU_DMUQCLKDIV4:
        clkSel |= (MCU_DMUQCLKDIV4 << DMU_CLK_SEL_QCLK_SEL_SHIFT);
        break;
    case MCU_DMUQCLKDIV5:
        clkSel |= (MCU_DMUQCLKDIV5 << DMU_CLK_SEL_QCLK_SEL_SHIFT);
        break;
    case MCU_DMUQCLKDIV10:
        clkSel |= (MCU_DMUQCLKDIV10 << DMU_CLK_SEL_QCLK_SEL_SHIFT);
        break;
    default:
        ret = BCM_ERR_INVAL_PARAMS;
        break;
    }

    if (ret == BCM_ERR_OK) {
        MCU_DMURegs->clk_sel = clkSel;
    }
    return ret;
}

/** @brief MCU Is Initialized

    This API is to check if MCU is initialized

    @behavior Sync, Non-reentrant

    @pre None

    @param       none

    @return      MCU init state

    @post None

    @trace #BRCM_SWARCH_MCU_INIT_PROC
    @trace #BRCM_SWARCH_MCU_CLKINIT_PROC
    @trace #BRCM_SWARCH_MCU_GETCLKFREQ_PROC
    @trace #BRCM_SWARCH_MCU_RAMSECTIONINIT_PROC
    @trace #BRCM_SWARCH_MCU_ACTIVATEPLLCLOCKS_PROC
    @trace #BRCM_SWARCH_MCU_SYSCMDHANDLER_PROC
    @trace #BRCM_SWREQ_MCU_INIT_BCM8957X
*/
static uint32_t MCU_IsInitialized(void)
{
    return MCU_Dev.init;
}

/** @brief QSPI clock intialization

    API to initialize QSPI clock

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aCfg        Pointer to MCU clock configuration

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @return     Others                  As returned by #MCU_DMUSetQClk
    @retval     #BCM_ERR_INVAL_PARAMS   If configuration ID is invalid

    @post None

    @trace #BRCM_SWARCH_MCU_CLKINIT_PROC
    @trace #BRCM_SWREQ_MCU_INIT_BCM8957X

    @limitations None
*/
static int32_t MCU_QspiClkInit(const MCU_ClkCfgType *const aCfg)
{
    MCU_DMUQCLKDivType div;
    int32_t err = BCM_ERR_OK;

    switch(aCfg->cfgID) {
        case MCU_CLK_CFG_ID_QSPI0_SRC250_83MHZ:
            div = MCU_DMUQCLKDIV3;
            break;
        case MCU_CLK_CFG_ID_QSPI0_SRC250_62MHZ:
            div = MCU_DMUQCLKDIV4;
            break;
        case MCU_CLK_CFG_ID_QSPI0_SRC250_50MHZ:
            div = MCU_DMUQCLKDIV5;
            break;
        case MCU_CLK_CFG_ID_QSPI0_SRC250_25MHZ:
            div = MCU_DMUQCLKDIV10;
            break;
        default:
            err = BCM_ERR_INVAL_PARAMS;
            break;
    }

    if (err == BCM_ERR_OK) {
        err = MCU_DMUSetQClk(div);
    }
    return err;
}

/** @brief Clock intialization

    API to initialize clock

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aCfg        Pointer to MCU clock configuration

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @return     Others                  As returned by #MCU_QspiClkInit
    @retval     #BCM_ERR_INVAL_PARAMS   If clock ID is invalid

    @post None

    @trace #BRCM_SWARCH_MCU_CLKINIT_PROC
    @trace #BRCM_SWREQ_MCU_INIT_BCM8957X

    @limitations None
*/
static int32_t MCU_IntClkInit(const MCU_ClkCfgType *const aCfg)
{
    int32_t err = BCM_ERR_OK;

    switch (aCfg->clkRef.clkID) {
        case MCU_CLK_ID_QSPI:
        err = MCU_QspiClkInit(aCfg);
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

    @trace #BRCM_SWARCH_MCU_CLKINIT_PROC
    @trace #BRCM_SWREQ_MCU_INIT_BCM8957X

    @limitations None
*/
static void MCU_DrvPeriphInit(void)
{
    /* Power up all peripherals */
    MCU_DMUPeriphPowerUpAll();

    MCU_CFGEnableAllQSPIInterrupt();
    MCU_CFGDisableQSPIErrInterrupt();
    MCU_SwitchInterruptClear(MCU_SWITCHINTRFLAGS_ALL);

    /* Enable SPIM (SPI1) and MDIO PAD */
    MCU_IORegs->io_ctl &= (~IO_CTL_SPIM_DISABLE_MASK & ~IO_CTL_MDIO_DISABLE_MASK);

    /* Enable reset through watchdog */
    MCU_CRGRegs->reset_config |= CRG_RESET_CONFIG_WDG_EN_MASK;
}

/** @brief Get reset reason

    API to get reset reason

    @behavior Sync, Re-entrant

    @pre None

    @param      None

    @return     void

    @post None

    @trace #BRCM_SWARCH_MCU_SYSCMDHANDLER_PROC
    @trace #BRCM_SWREQ_MCU_QUERY_BCM8957X

    @limitations None
*/
static MCU_ResetReasonType MCU_DrvGetResetReason(void)
{
    MCU_ResetReasonType reason = MCU_RESETREASON_UNDEFINED;

    if (MCU_IsInitialized() == TRUE) {
        uint32_t resetConfigVal = MCU_CRGRegs->reset_config;
        if ((resetConfigVal & CRG_RESET_CONFIG_WDG_STATUS_MASK) != 0UL) {
            reason = MCU_RESETREASON_WD;
        } else {
            uint32_t reg = MCU_ChipMiscRegs->spare_sw_reg0;
            reg = (reg & MCU_RESET_INFO_RESET_REASON_MASK)
                    >> MCU_RESET_INFO_RESET_REASON_SHIFT;
            if ((reg & MCU_RESET_INFO_SW_RESET_MASK) != 0UL) {
                reason = MCU_RESETREASON_SW;
            } else {
                reason = MCU_RESETREASON_POWER_ON;
            }
        }
    }
    return reason;
}

/** @brief Get reset raw value

    API to get reset raw value

    @behavior Sync, Re-entrant

    @pre None

    @param      None

    @return     returns MCU reset raw value

    @post None

    @trace #BRCM_SWARCH_MCU_SYSCMDHANDLER_PROC
    @trace #BRCM_SWREQ_MCU_QUERY_BCM8957X

    @limitations None
*/
static uint32_t MCU_DrvGetResetRawValue(void)
{
    return MCU_ChipMiscRegs->spare_sw_reg0;
}

/** @brief Get reset mode

    API to get MCU reset mode

    @behavior Sync, Re-entrant

    @pre None

    @param      None

    @return     returns MCU reset mode

    @post None

    @trace #BRCM_SWARCH_MCU_SYSCMDHANDLER_PROC
    @trace #BRCM_SWREQ_MCU_QUERY_BCM8957X

    @limitations None
*/
static MCU_ResetModeType MCU_DrvGetResetMode(void)
{
    MCU_ResetModeType resetMode;
    uint32_t dwnldMode;
    uint32_t reg = MCU_IORegs->straps_raw;

    if (0UL != ((reg & IO_STRAPS_RAW_SFT_FORCE_DWNLD_MASK)
                    >> IO_STRAPS_RAW_SFT_FORCE_DWNLD_SHIFT)) {
        resetMode = MCU_RESETMODE_DWNLD_IPC;
    } else {
        reg =  MCU_ChipMiscRegs->spare_sw_reg0;
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
                case MCU_RESET_INFO_DWNLD_MODE_IPC:
                    resetMode = MCU_RESETMODE_DWNLD_IPC;
                    break;
                default:
                    resetMode = MCU_RESETMODE_NONE;
                    break;
            }
        } else {
            resetMode = MCU_RESETMODE_NONE;
        }
    }

    return resetMode;
}

/** @brief Set reset mode

    API to set reset mode

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aResetMode      Reset mode

    @return     void

    @post None

    @trace #BRCM_SWARCH_MCU_SYSCMDHANDLER_PROC
    @trace #BRCM_SWREQ_MCU_DYNAMIC_CONFIG_BCM8957X

    @limitations None
*/
static void MCU_DrvSetResetMode(MCU_ResetModeType aResetMode)
{
    switch (aResetMode) {
    case MCU_RESETMODE_DWNL:
        MCU_ChipMiscRegs->spare_sw_reg0 |= MCU_RESET_INFO_SW_RESET_MASK
                | (MCU_RESET_INFO_DWNLD_MODE_IPC << MCU_RESET_INFO_DWNLD_MODE_SHIFT);
        break;
    case MCU_RESETMODE_RAMDUMP:
        MCU_ChipMiscRegs->spare_sw_reg0 |= MCU_RESET_INFO_RAMDUMP_MASK;
        break;
    default:
        break;
    }
}

/** @brief Get BL Boot Info

    @trace #BRCM_SWARCH_MCU_GETBLBOOTINFO_PROC
    @trace #BRCM_SWREQ_MCU_QUERY_BCM8957X
*/
int32_t MCU_GetBLBootInfo(uint32_t * const aBootInfo)
{
    int32_t retVal = BCM_ERR_OK;
    uint16_t reg;

    if (NULL == aBootInfo) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        reg = MCU_ChipMiscRegs->f1_image_status;
        *aBootInfo = (((uint32_t)reg) & 0xF);
    }
    return retVal;
}

/** @brief Get default reset mode

    @trace #BRCM_SWARCH_MCU_GETDEFAULTRESETMODE_PROC
    @trace #BRCM_SWREQ_MCU_QUERY_BCM8957X
*/
MCU_ResetModeType MCU_GetDefaultResetMode(void)
{
    return MCU_RESETMODE_DWNLD_IPC;
}

/** @brief Get download mode

    @trace #BRCM_SWARCH_MCU_GETDWNLDMODE_PROC
    @trace #BRCM_SWREQ_MCU_QUERY_BCM8957X
*/
MCU_DwnldModeType MCU_GetDwnldMode(void)
{
    MCU_DwnldModeType mode;
    uint32_t reg = MCU_ChipMiscRegs->spare_sw_reg0;
    if ((reg & MCU_RESET_INFO_DWNLD_MODE_PARTIAL_MASK) != 0UL) {
        mode = MCU_DWNLD_MODE_PARTIAL;
    } else {
        mode = MCU_DWNLD_MODE_VIRGIN;
    }

    return mode;
}

/** @brief Set FW Boot Info

    @trace #BRCM_SWARCH_MCU_SETBOOTINFO_PROC
    @trace #BRCM_SWREQ_MCU_QUERY_BCM8957X
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
    MCU_ChipMiscRegs->spare_hw_reg8 &= ~(mask);
    MCU_ChipMiscRegs->spare_hw_reg8 |= (value & mask);
    MCU_ChipMiscRegs->spare_sw_reg3 &= ~(mask);
    MCU_ChipMiscRegs->spare_sw_reg3 |= (value & mask);
}

/** @brief Get FW Boot Info

    API to get FW Boot Info

    @behavior Sync, Re-entrant

    @pre None

    @param[inout]      aBootInfo      Pointer to Boot Info

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On success
    @retval     #BCM_ERR_INVAL_PARAMS   aBootInfo is NULL

    @post None

    @trace #BRCM_SWARCH_MCU_SYSCMDHANDLER_PROC
    @trace #BRCM_SWREQ_MCU_QUERY_BCM8957X

    @limitations None
*/
static int32_t MCU_DrvGetBootInfo(PTBL_IdType * const aPid, uint8_t * const aFlsId)
{
    int32_t err = BCM_ERR_INVAL_PARAMS;
    if ((NULL != aPid) && (NULL != aFlsId)) {
        uint32_t value = MCU_ChipMiscRegs->spare_hw_reg8;
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

/** @brief Reset request

    API to reset request

    @behavior Sync, Re-entrant

    @pre None

    @param[in]          aResetReq      Reset request

    @return     void

    @post None

    @trace #BRCM_SWARCH_MCU_SYSCMDHANDLER_PROC
    @trace #BRCM_SWREQ_MCU_DYNAMIC_CONFIG_BCM8957X

    @limitations None
*/
static void MCU_DrvResetReq(MCU_ResetReqType aResetReq)
{
    if (MCU_IsInitialized() == TRUE) {
        switch (aResetReq) {
        case MCU_RESETREQ_GLOBAL:
            MCU_CRGRegs->reset_config |= (CRG_RESET_CONFIG_GLOBAL_SRST_EN_MASK
                                        | CRG_RESET_CONFIG_SRST_CHIP_MASK);
            break;
        case MCU_RESETREQ_LOCAL:
            MCU_CFGRegs->cfg_cpusys_misc |= CFG_CPUSYS_MISC_CPU_SYSRSTREQ_RST_EN_MASK;
            MCU_ChipMiscRegs->spare_sw_reg0 |= MCU_RESET_INFO_SW_RESET_MASK;
            CORTEX_MX_SystemReset();
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

    @return     PLL status

    @post None

    @trace #BRCM_SWARCH_MCU_GETPLLSTATUS_PROC
    @trace #BRCM_SWARCH_MCU_ACTIVATEPLLCLOCKS_PROC
    @trace #BRCM_SWREQ_MCU_QUERY_BCM8957X

    @limitations None
*/
static MCU_PllStatusType MCU_DrvGetPllStatus(void)
{
    return MCU_PLLSTATUS_LOCKED;
}

/** @brief Get version

    API to get version

    @behavior Sync, Re-entrant

    @pre None

    @param[inout]           aVersion      Pointer to version

    @return     void

    @post None

    @trace #BRCM_SWARCH_MCU_SYSCMDHANDLER_PROC
    @trace #BRCM_SWREQ_MCU_QUERY_BCM8957X

    @limitations None
*/
void MCU_GetVersion(MCU_VersionType *const aVersion)
{
    if (NULL != aVersion) {
        BCM_MemCpy((void*)aVersion, (void*)&MCU_Dev.version, sizeof(MCU_VersionType));
    }
}

/** @brief Get switch Port2Time fifo map

    API to get switch Port2Time fifo map

    @behavior Sync, Re-entrant

    @pre None

    @param[inout]           aPort2TimeFifoMap      Pointer to Port2Time fifo map

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @retval     #BCM_ERR_INVAL_PARAMS   aPort2TimeFifoMap is NULL

    @post None

    @trace  #BRCM_SWARCH_MCU_SYSCMDHANDLER_PROC
    @trace  #BRCM_SWREQ_MCU_EXTENSION_BCM8957X

    @limitations None
*/
static int32_t MCU_DrvGetSwitchPort2TimeFifoMap(uint32_t *const aPort2TimeFifoMap)
{
    int32_t retVal = BCM_ERR_OK;

    if (NULL == aPort2TimeFifoMap) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
         aPort2TimeFifoMap[0UL] = 0x00UL;
         aPort2TimeFifoMap[1UL] = 0x01UL;
         aPort2TimeFifoMap[2UL] = 0x02UL;
         aPort2TimeFifoMap[3UL] = 0x03UL;
         aPort2TimeFifoMap[4UL] = 0x04UL;
         aPort2TimeFifoMap[5UL] = 0x05UL;
         aPort2TimeFifoMap[6UL] = 0x06UL;
         aPort2TimeFifoMap[7UL] = 0x10UL;
         aPort2TimeFifoMap[8UL] = 0x07UL;
         aPort2TimeFifoMap[9UL] = 0x08UL;
    }

    return retVal;
}

/** @brief Enable switch CPU port

    API to enable switch CPU port

    @behavior Sync, Re-entrant

    @pre None

    @param      None

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success

    @post None

    @trace  #BRCM_SWARCH_MCU_SYSCMDHANDLER_PROC
    @trace  #BRCM_SWREQ_MCU_EXTENSION_BCM8957X

    @limitations None
*/
static int32_t MCU_DrvEnableSwitchCPUPort(void)
{
    /* Enable P7(CPU) port - Enable Tx & Rx pause frames, link status,
     * 1G speed */
    MCU_IORegs->cpu_gmii_ctl = (IO_CPU_RX_PAUSE_MASK
            | IO_CPU_TX_PAUSE_MASK
            | IO_CPU_LINK_MASK
            | (IO_CPU_SPD_2G & IO_CPU_SPD_MASK));
    return BCM_ERR_OK;
}

/** @brief Disable switch CPU port

    API to disable switch CPU port

    @behavior Sync, Re-entrant

    @pre None

    @param      None

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success

    @post None

    @trace  #BRCM_SWARCH_MCU_SYSCMDHANDLER_PROC
    @trace  #BRCM_SWREQ_MCU_EXTENSION_BCM8957X

    @limitations None
*/
static int32_t MCU_DrvDisableSwitchCPUPort(void)
{
    /* Disable P7(CPU) port - Clear link status bit */
    MCU_IORegs->cpu_gmii_ctl &= ~IO_CPU_LINK_MASK;
    return BCM_ERR_OK;
}

/** @brief Get MCU Info

    API to get mcu Info

    @behavior Sync, Re-entrant

    @pre None

    @param[inout]      aInfo    Pointer to switch info

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @retval     #BCM_ERR_INVAL_PARAMS   aInfo is NULL

    @post None

    @trace  #BRCM_SWARCH_MCU_SYSCMDHANDLER_PROC
    @trace  #BRCM_SWREQ_MCU_QUERY_BCM8957X

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

/** @brief Set MCU Info

    API to set mcu Info

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aInfo    switch info

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success

    @post None

    @trace  #BRCM_SWARCH_MCU_SYSCMDHANDLER_PROC
    @trace  #BRCM_SWREQ_MCU_EXTENSION_BCM8957X

    @limitations None
*/
static int32_t MCU_DrvSetInfo(const MCU_InfoType* aInfo)
{
    uint32_t retVal = BCM_ERR_OK;

    if (NULL == aInfo) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        BCM_MemCpy(&MCU_Dev.info, aInfo, sizeof(MCU_InfoType));
    }

    return retVal;
}

/** @brief Get Boot time Information

    API to get Boot time information

    @behavior Sync, Re-entrant

    @pre None

    @param[inout]      aBootTime    Pointer to stacking info

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @retval     #BCM_ERR_INVAL_PARAMS   aBootTime is NULL

    @post None

    @trace  #BRCM_SWARCH_MCU_SYSCMDHANDLER_PROC
    @trace  #BRCM_SWARCH_MCU_GETBOOTTIMEINFO_PROC
    @trace  #BRCM_SWREQ_MCU_QUERY_BCM8957X

    @limitations None
*/
static int32_t MCU_DrvGetBootTimeInfo(MCU_BootTimeInfoType *const aBootTime)
{
    int32_t retVal = BCM_ERR_OK;

    if (NULL != aBootTime) {
        aBootTime->blBootTime = MCU_ChipMiscRegs->spare_hw_reg9 & 0xFFU;
        aBootTime->fwBootTime = (MCU_ChipMiscRegs->spare_hw_reg9 & 0xFF00U) >> 8U;

     } else {
        retVal = BCM_ERR_INVAL_PARAMS;
    }
    return retVal;
}

/** @brief Set Boot Time Info

    @trace #BRCM_SWARCH_MCU_SETBOOTTIMEINFO_PROC
    @trace #BRCM_SWREQ_MCU_DYNAMIC_CONFIG_BCM8957X
*/
int32_t MCU_SetBootTimeInfo(const MCU_BootTimeInfoType *const aBootTime)
{
    int32_t retVal = BCM_ERR_OK;

    if (NULL != aBootTime) {
        MCU_ChipMiscRegs->spare_hw_reg9 = ((aBootTime->blBootTime & 0xFFU) |
                                          ((aBootTime->fwBootTime & 0xFFU) << 8U));

    } else {
        retVal = BCM_ERR_INVAL_PARAMS;
    }
    return retVal;
}

/**
    @code{.unparsed}
    clearMask = 0x0UL;

    if (FALSE == MCU_Dev.init)
        retVal = BCM_ERR_UNINIT
    else
        if (0UL != (aIntrFlags & MCU_SWITCHINTRFLAGS_CTF))
            clearMask = clearMask OR CFG_SW_INTR_CLR_CTF_MASK

        if (0UL != (aIntrFlags & MCU_SWITCHINTRFLAGS_PSFP))
            clearMask = clearMask OR CFG_SW_INTR_CLR_PSFP_MASK

        if (0UL != (aIntrFlags & MCU_SWITCHINTRFLAGS_DOS))
            clearMask = clearMask OR CFG_SW_INTR_CLR_DOS_MASK

        if (0UL != (aIntrFlags & MCU_SWITCHINTRFLAGS_CFP_OUTOFPROF))
            clearMask = clearMask OR CFG_SW_INTR_CLR_CFP_OUTOFPROF_MASK

        if (0UL != (aIntrFlags & MCU_SWITCHINTRFLAGS_LINKSTATUS6))
            clearMask = clearMask OR CFG_SW_INTR_CLR_LINKSTATUS6_MASK

        if (0UL != (aIntrFlags & MCU_SWITCHINTRFLAGS_MEM_DED))
            clearMask = clearMask OR CFG_SW_INTR_CLR_MEM_DED_MASK

        if (0UL != (aIntrFlags & MCU_SWITCHINTRFLAGS_EEE_LPI))
            clearMask = clearMask OR CFG_SW_INTR_CLR_EEE_LPI_MASK

        if (0UL != (aIntrFlags & MCU_SWITCHINTRFLAGS_WAKEUP5))
            clearMask = clearMask OR CFG_SW_INTR_CLR_WAKEUP5_MASK

        if (0UL != (aIntrFlags & MCU_SWITCHINTRFLAGS_WAKEUP8))
            clearMask = clearMask OR CFG_SW_INTR_CLR_WAKEUP8_MASK

        if (0UL != (aIntrFlags & MCU_SWITCHINTRFLAGS_WAKEUP7))
            clearMask = clearMask OR CFG_SW_INTR_CLR_WAKEUP7_MASK

        if (0UL != (aIntrFlags & MCU_SWITCHINTRFLAGS_CFP_TCAM))
            clearMask = clearMask OR CFG_SW_INTR_CLR_CFP_TCAM_MASK

        if (0UL != (aIntrFlags & MCU_SWITCHINTRFLAGS_LINKSTATUS8))
            clearMask = clearMask OR CFG_SW_INTR_CLR_LINKSTATUS8_MASK

        if (0UL != (aIntrFlags & MCU_SWITCHINTRFLAGS_LINKSTATUS7))
            clearMask = clearMask OR CFG_SW_INTR_CLR_LINKSTATUS7_MASK

        if (0UL != (aIntrFlags & MCU_SWITCHINTRFLAGS_LINKSTATUS5))
            clearMask = clearMask OR CFG_SW_INTR_CLR_LINKSTATUS5_MASK

        if (0UL != (aIntrFlags & MCU_SWITCHINTRFLAGS_LINKSTATUS4))
            clearMask = clearMask OR CFG_SW_INTR_CLR_LINKSTATUS4_MASK

        if (0UL != (aIntrFlags & MCU_SWITCHINTRFLAGS_LINKSTATUS3))
            clearMask = clearMask OR CFG_SW_INTR_CLR_LINKSTATUS3_MASK

        if (0UL != (aIntrFlags & MCU_SWITCHINTRFLAGS_LINKSTATUS2))
            clearMask = clearMask OR CFG_SW_INTR_CLR_LINKSTATUS2_MASK

        if (0UL != (aIntrFlags & MCU_SWITCHINTRFLAGS_LINKSTATUS1))
            clearMask = clearMask OR CFG_SW_INTR_CLR_LINKSTATUS1_MASK

        if (0UL != (aIntrFlags & MCU_SWITCHINTRFLAGS_LINKSTATUS0))
            clearMask = clearMask OR CFG_SW_INTR_CLR_LINKSTATUS0_MASK;

        MCU_CFGRegs->sw_intr_clr = clearMask
        retVal = BCM_ERR_OK
    return retVal;
    @endcode

    @trace  #BRCM_SWARCH_MCU_SWITCHINTERRUPTCLEAR_PROC
    @trace  #BRCM_SWREQ_MCU_INIT_BCM8957X
*/
int32_t MCU_SwitchInterruptClear(MCU_SwitchIntrFlagsType aIntrFlags)
{
    int32_t retVal;
    uint32_t clearMask = 0x0UL;

    if (FALSE == MCU_Dev.init) {
        retVal = BCM_ERR_UNINIT;
    } else {
        if (0UL != (aIntrFlags & MCU_SWITCHINTRFLAGS_CTF)) {
            clearMask |= CFG_SW_INTR_CLR_CTF_MASK;
        }
        if (0UL != (aIntrFlags & MCU_SWITCHINTRFLAGS_PSFP)) {
            clearMask |= CFG_SW_INTR_CLR_PSFP_MASK;
        }
        if (0UL != (aIntrFlags & MCU_SWITCHINTRFLAGS_DOS)) {
            clearMask |= CFG_SW_INTR_CLR_DOS_MASK;
        }
        if (0UL != (aIntrFlags & MCU_SWITCHINTRFLAGS_CFP_OUTOFPROF)) {
            clearMask |= CFG_SW_INTR_CLR_CFP_OUTOFPROF_MASK;
        }
        if (0UL != (aIntrFlags & MCU_SWITCHINTRFLAGS_LINKSTATUS6)) {
            clearMask |= CFG_SW_INTR_CLR_LINKSTATUS6_MASK;
        }
        if (0UL != (aIntrFlags & MCU_SWITCHINTRFLAGS_MEM_DED)) {
            clearMask |= CFG_SW_INTR_CLR_MEM_DED_MASK;
        }
        if (0UL != (aIntrFlags & MCU_SWITCHINTRFLAGS_EEE_LPI)) {
            clearMask |= CFG_SW_INTR_CLR_EEE_LPI_MASK;
        }
        if (0UL != (aIntrFlags & MCU_SWITCHINTRFLAGS_WAKEUP5)) {
            clearMask |= CFG_SW_INTR_CLR_WAKEUP5_MASK;
        }
        if (0UL != (aIntrFlags & MCU_SWITCHINTRFLAGS_WAKEUP8)) {
            clearMask |= CFG_SW_INTR_CLR_WAKEUP8_MASK;
        }
        if (0UL != (aIntrFlags & MCU_SWITCHINTRFLAGS_WAKEUP7)) {
            clearMask |= CFG_SW_INTR_CLR_WAKEUP7_MASK;
        }
        if (0UL != (aIntrFlags & MCU_SWITCHINTRFLAGS_CFP_TCAM)) {
            clearMask |= CFG_SW_INTR_CLR_CFP_TCAM_MASK;
        }
        if (0UL != (aIntrFlags & MCU_SWITCHINTRFLAGS_LINKSTATUS8)) {
            clearMask |= CFG_SW_INTR_CLR_LINKSTATUS8_MASK;
        }
        if (0UL != (aIntrFlags & MCU_SWITCHINTRFLAGS_LINKSTATUS7)) {
            clearMask |= CFG_SW_INTR_CLR_LINKSTATUS7_MASK;
        }
        if (0UL != (aIntrFlags & MCU_SWITCHINTRFLAGS_LINKSTATUS5)) {
            clearMask |= CFG_SW_INTR_CLR_LINKSTATUS5_MASK;
        }
        if (0UL != (aIntrFlags & MCU_SWITCHINTRFLAGS_LINKSTATUS4)) {
            clearMask |= CFG_SW_INTR_CLR_LINKSTATUS4_MASK;
        }
        if (0UL != (aIntrFlags & MCU_SWITCHINTRFLAGS_LINKSTATUS3)) {
            clearMask |= CFG_SW_INTR_CLR_LINKSTATUS3_MASK;
        }
        if (0UL != (aIntrFlags & MCU_SWITCHINTRFLAGS_LINKSTATUS2)) {
            clearMask |= CFG_SW_INTR_CLR_LINKSTATUS2_MASK;
        }
        if (0UL != (aIntrFlags & MCU_SWITCHINTRFLAGS_LINKSTATUS1)) {
            clearMask |= CFG_SW_INTR_CLR_LINKSTATUS1_MASK;
        }
        if (0UL != (aIntrFlags & MCU_SWITCHINTRFLAGS_LINKSTATUS0)) {
            clearMask |= CFG_SW_INTR_CLR_LINKSTATUS0_MASK;
        }

        MCU_CFGRegs->sw_intr_clr = clearMask;
        retVal = BCM_ERR_OK;
    }

    return retVal;
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
    @trace  #BRCM_SWREQ_MCU_KERNEL_HANDLER_BCM8957X
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
            case MCU_CMD_GET_VERSION:
                MCU_GetVersion(mcu.io->version);
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
            case MCU_CMD_GET_SWT_PORT_2_TIME_FIFO_MAP:
                ret = MCU_DrvGetSwitchPort2TimeFifoMap(mcu.io->swtPort2TimeFifoMap);
                break;
            case MCU_CMD_ENABLE_SWT_CPU_PORT:
                ret = MCU_DrvEnableSwitchCPUPort();
                break;
            case MCU_CMD_DISABLE_SWT_CPU_PORT:
                ret = MCU_DrvDisableSwitchCPUPort();
                break;
            case MCU_CMD_SET_INFO:
                ret = MCU_DrvSetInfo(mcu.io->info);
                break;
            case MCU_CMD_GET_BOOT_TIME:
                ret = MCU_DrvGetBootTimeInfo(mcu.io->bootTime);
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
            mcu.io->retVal = BCM_ERR_INVAL_MAGIC;
        }
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }

    if (BCM_ERR_OK != ret) {
        const uint32_t values[4UL] = {aMagicID, aCmd, (uint32_t)aSysIO, 0UL};
        BCM_ReportError(BCM_MCU_ID, 0U, BRCM_SWARCH_MCU_SYSCMDHANDLER_PROC, ret, 4UL, values);
    }
}

/** @brief MCU SWR Configuration check
    This function performs the check whether the register write for
    Switching regulator programming has got successful OR not.

    @limitations
    None

    @trace  #BRCM_SWARCH_MCU_INIT_PROC
    @trace  #BRCM_SWREQ_MCU_INIT_BCM8957X
*/
static int32_t MCU_SwrVerifyBitReset(uint32_t aBitPosition)
{
    int32_t retVal = BCM_ERR_OK;
    uint16_t regVal = 0x0U;
    uint32_t count = 0x0UL;
    do {
        regVal = MCU_ChipMiscRegs->swreg_access_ctrl_1;
        if ((regVal & (0x1U << aBitPosition)) == 0x0U) {
            break;
        }
    } while (count++ < CHIPMISC_SWREG_TIMEOUT_COUNT);

    if (count >= CHIPMISC_SWREG_TIMEOUT_COUNT) {
        retVal = BCM_ERR_TIME_OUT;
        const uint32_t values[4UL] = {aBitPosition, count, regVal, 0UL};
        BCM_ReportError(BCM_MCU_ID, 0U, BRCM_SWDSGN_MCU_SWRVERFIFYBITRESET_PROC, retVal, 4UL, values);
    }

    return retVal;
}

/** @brief MCU SWR PMU Status check
    This function performs the check for PMU stable bit.

    @limitations
    None

    @trace #BRCM_SWARCH_MCU_INIT_PROC
    @trace #BRCM_SWREQ_MCU_INIT_BCM8957X
*/
static int32_t MCU_SwrCheckPmuStable()
{
    int32_t retVal = BCM_ERR_OK;
    uint16_t regVal = 0x0U;
    uint32_t count = 0x0UL;

    do {
        regVal = MCU_ChipMiscRegs->swreg_control_status;
        if ((regVal & CHIPMISC_SWREG_CONTROL_STATUS_PMU_STABLE_STATUS_MASK) == 0x1U) {
            break;
        }
    } while (count++ < CHIPMISC_SWREG_TIMEOUT_COUNT);

    if (count >= CHIPMISC_SWREG_TIMEOUT_COUNT) {
        retVal = BCM_ERR_TIME_OUT;
    }
    return retVal;
}

/** @brief MCU SWR Configuration
    This function performs the Switching regulator programming to move to 2Mhz.

    @limitations
    It is assumed that this API is called from priviledged context with
    interrupt disabled

    @trace  #BRCM_SWARCH_MCU_INIT_PROC
    @trace  #BRCM_SWREQ_MCU_INIT_BCM8957X
*/
static void MCU_SwrConfigure(void)
{
    int32_t retVal = BCM_ERR_OK;
    uint32_t values[4UL] = {0UL, 0UL, 0UL, 0UL};

    /* Enable external 250MHz PLL clock */
    MCU_ChipMiscRegs->swreg_control_status = CHIPMISC_SWREG_CONTROL_STATUS_EXT_PLLCLK_EN_MASK;

    /* poll swreg_pmu_stable bit */
    retVal = MCU_SwrCheckPmuStable();
    if(BCM_ERR_OK != retVal) {
        values[0] = __LINE__;
        goto err_exit;
    }

    /* Values being programmed
     * reg9_reg8_reg7_reg6_reg5_reg4_reg3_reg2_reg1_reg0
     * 0A0C_0000_1FFF_B000_0580_CCD0_0601_EE8A_1804_0832
     */

    /* select 2MHz switching frequency (reg1) */
    MCU_ChipMiscRegs->swreg_ctrl_reg1 = CHIPMISC_SWREG_CTRL_REG1_VALUE;
    MCU_ChipMiscRegs->swreg_access_ctrl_1 = CHIPMISC_SWREG_ACCESS_CTRL_1_WRITE_1_MASK;
    retVal = MCU_SwrVerifyBitReset(1);
    if(BCM_ERR_OK != retVal) {
        values[0] = __LINE__;
        goto err_exit;
    }

    /* set BCM8957X-B0 default (reg2) */
    MCU_ChipMiscRegs->swreg_ctrl_reg2 = CHIPMISC_SWREG_CTRL_REG2_VALUE;
    MCU_ChipMiscRegs->swreg_access_ctrl_1 = CHIPMISC_SWREG_ACCESS_CTRL_1_WRITE_2_MASK;
    retVal = MCU_SwrVerifyBitReset(2);
    if(BCM_ERR_OK != retVal) {
        values[0] = __LINE__;
        goto err_exit;
    }

    /* select 2MHz sd_dutymax (reg3) */
    MCU_ChipMiscRegs->swreg_ctrl_reg3 = CHIPMISC_SWREG_CTRL_REG3_VALUE;
    MCU_ChipMiscRegs->swreg_access_ctrl_1 = CHIPMISC_SWREG_ACCESS_CTRL_1_WRITE_3_MASK;
    retVal = MCU_SwrVerifyBitReset(3);
    if(BCM_ERR_OK != retVal) {
        values[0] = __LINE__;
        goto err_exit;
    }

    /* set BCM8957X-B0 default (reg4) */
    MCU_ChipMiscRegs->swreg_ctrl_reg4 = CHIPMISC_SWREG_CTRL_REG4_VALUE;
    MCU_ChipMiscRegs->swreg_access_ctrl_1 = CHIPMISC_SWREG_ACCESS_CTRL_1_WRITE_4_MASK;
    retVal = MCU_SwrVerifyBitReset(4);
    if(BCM_ERR_OK != retVal) {
        values[0] = __LINE__;
        goto err_exit;
    }

    /* set BCM8957X-B0 default (reg5) */
    MCU_ChipMiscRegs->swreg_ctrl_reg5 = CHIPMISC_SWREG_CTRL_REG5_VALUE;
    MCU_ChipMiscRegs->swreg_access_ctrl_1 = CHIPMISC_SWREG_ACCESS_CTRL_1_WRITE_5_MASK;
    retVal = MCU_SwrVerifyBitReset(5);
    if(BCM_ERR_OK != retVal) {
        values[0] = __LINE__;
        goto err_exit;
    }

    /* set BCM8957X-B0 default (reg6) */
    MCU_ChipMiscRegs->swreg_ctrl_reg6 = CHIPMISC_SWREG_CTRL_REG6_VALUE;
    MCU_ChipMiscRegs->swreg_access_ctrl_1 = CHIPMISC_SWREG_ACCESS_CTRL_1_WRITE_6_MASK;
    retVal = MCU_SwrVerifyBitReset(6);
    if(BCM_ERR_OK != retVal) {
        values[0] = __LINE__;
        goto err_exit;
    }

    /* set drive strength (reg7) */
    MCU_ChipMiscRegs->swreg_ctrl_reg7 = CHIPMISC_SWREG_CTRL_REG7_VALUE;
    MCU_ChipMiscRegs->swreg_access_ctrl_1 = CHIPMISC_SWREG_ACCESS_CTRL_1_WRITE_7_MASK;
    retVal = MCU_SwrVerifyBitReset(7);
    if(BCM_ERR_OK != retVal) {
        values[0] = __LINE__;
        goto err_exit;
    }

    /* set BCM8957X-B0 default (reg8) */
    MCU_ChipMiscRegs->swreg_ctrl_reg8 = CHIPMISC_SWREG_CTRL_REG8_VALUE;
    MCU_ChipMiscRegs->swreg_access_ctrl_1 = CHIPMISC_SWREG_ACCESS_CTRL_1_WRITE_8_MASK;
    retVal = MCU_SwrVerifyBitReset(8);
    if(BCM_ERR_OK != retVal) {
        values[0] = __LINE__;
        goto err_exit;
    }

    /* set BCM8957X-B0 default (reg9) */
    MCU_ChipMiscRegs->swreg_ctrl_reg9 = CHIPMISC_SWREG_CTRL_REG9_VALUE;
    MCU_ChipMiscRegs->swreg_access_ctrl_1 = CHIPMISC_SWREG_ACCESS_CTRL_1_WRITE_9_MASK;
    retVal = MCU_SwrVerifyBitReset(9);
    if(BCM_ERR_OK != retVal) {
        values[0] = __LINE__;
        goto err_exit;
    }

    /* create update rising edge (reg0) */
    MCU_ChipMiscRegs->swreg_ctrl_reg0 = CHIPMISC_SWREG_CTRL_REG0_VALUE0;
    MCU_ChipMiscRegs->swreg_access_ctrl_1 = CHIPMISC_SWREG_ACCESS_CTRL_1_WRITE_0_MASK;
    retVal = MCU_SwrVerifyBitReset(0);
    if(BCM_ERR_OK != retVal) {
        values[0] = __LINE__;
        goto err_exit;
    }
    MCU_ChipMiscRegs->swreg_ctrl_reg0 = CHIPMISC_SWREG_CTRL_REG0_VALUE1;
    MCU_ChipMiscRegs->swreg_access_ctrl_1 = CHIPMISC_SWREG_ACCESS_CTRL_1_WRITE_0_MASK;
    retVal = MCU_SwrVerifyBitReset(0);
    if(BCM_ERR_OK != retVal) {
        values[0] = __LINE__;
        goto err_exit;
    }

    /* After switching, verify that swreg_pmu_stable bit is 1 */
    retVal = MCU_SwrCheckPmuStable();
    if(BCM_ERR_OK != retVal) {
        values[0] = __LINE__;
    }

err_exit:
    if(BCM_ERR_OK != retVal) {
        BCM_ReportError(BCM_MCU_ID, 0U, BRCM_SWDSGN_MCU_SWRCONFIGURE_PROC, retVal, 4UL, values);
    }
}

/** @brief MCU Initialization

    @limitations
    It is assumed that this API is called from priviledged context with
    interrupt disabled

    @trace  #BRCM_SWARCH_MCU_INIT_PROC
    @trace  #BRCM_SWREQ_MCU_INIT_BCM8957X
*/
void MCU_Init(const MCU_ConfigType *const aConfig)
{
    uint16_t model_rev =  MCU_ChipMiscRegs->model_rev_num;
    uint16_t devid_lo =  MCU_ChipMiscRegs->deviceid_lo;
    uint16_t devid_hi =  MCU_ChipMiscRegs->deviceid_hi;
    uint32_t lsb = MCU_BRPHYMIIRegs->phy_id_lsb;
    uint32_t msb = MCU_BRPHYMIIRegs->phy_id_msb;

    if (MCU_IsInitialized() == FALSE) {
        if (aConfig != NULL) {
            MCU_Dev.config = aConfig;
            MCU_Dev.init = TRUE;
            MCU_DrvPeriphInit();
        }

        /* Configure the Switching Regulator before anything else */
        MCU_SwrConfigure();
        MCU_SWITCHRegs->m02_brcm_hdr_ctrl &= ~SWITCH_BRCM_HDR_CTRL_P7_EN_MASK;
        MCU_Dev.version.rev =
            (uint32_t)((model_rev & CHIPMISC_MODEL_REV_NUM_REV_NUM_MASK) >>
                    CHIPMISC_MODEL_REV_NUM_REV_NUM_SHIFT);
        MCU_Dev.version.manuf = (msb & BRPHY_MII_PHY_ID_MSB_OUI_MSB_MASK);
        MCU_Dev.version.manuf |= ((lsb & BRPHY_MII_PHY_ID_LSB_OUI_LSB_MASK) >>
                BRPHY_MII_PHY_ID_LSB_OUI_LSB_SHIFT) << 19U;

        MCU_Dev.version.model = (devid_hi << 12UL) | devid_lo;
        MCU_Dev.version.securityMode = MCU_SECURITY_MODE_UNKNOWN;
    }
}

/** @brief RAM section Initilization

    @trace #BRCM_SWARCH_MCU_RAMSECTIONINIT_PROC
    @trace #BRCM_SWREQ_MCU_INIT_BCM8957X
 */
void MCU_RamSectionInit(MCU_RamSectionIDType aID)
{
    if (MCU_IsInitialized() == TRUE) {
        if (aID < MCU_Dev.config->ramCfgTblSize) {
            BCM_MemSet(MCU_Dev.config->ramCfgTbl[aID].baseAddr,
                        (int32_t)MCU_Dev.config->ramCfgTbl[aID].defaultVal,
                        MCU_Dev.config->ramCfgTbl[aID].size);
        }
    }
}

/** @brief ACtivate PLL Clocks

    @note PLLs are already activate by hardware during initialization
    This is just a dummy implementation which returns success

    @trace #BRCM_SWARCH_MCU_ACTIVATEPLLCLOCKS_PROC
    @trace #BRCM_SWREQ_MCU_DYNAMIC_CONFIG_BCM8957X
 */
int32_t MCU_ActivatePllClocks(void)
{
    int32_t err = BCM_ERR_OK;

    if (MCU_IsInitialized() == TRUE) {
        if (MCU_DrvGetPllStatus() != MCU_PLLSTATUS_LOCKED) {
            err = BCM_ERR_INVAL_STATE;
        }
    } else {
        err = BCM_ERR_UNINIT;
    }
    return err;
}

/** @brief Get PLL ststus

    @trace #BRCM_SWARCH_MCU_GETPLLSTATUS_PROC
    @trace #BRCM_SWREQ_MCU_QUERY_BCM8957X
 */
MCU_PllStatusType MCU_GetPllStatus(void)
{
    return MCU_DrvGetPllStatus();
}

/** @brief MCU clock Initialization

    @trace #BRCM_SWARCH_MCU_CLKINIT_PROC
    @trace #BRCM_SWREQ_MCU_INIT_BCM8957X
 */
int32_t MCU_ClkInit(MCU_ClkCfgIDType aCfgID)
{
    int err = BCM_ERR_OK;
    uint32_t i;

    if (MCU_IsInitialized() == TRUE) {
        /* lookup if aCfgID is present
         * in MCU configuration data
         */
        for (i = 0UL; i < MCU_Dev.config->clkCfgTblSize; i++) {
            if (MCU_Dev.config->clkCfgTbl[i].cfgID == aCfgID) {
                err = MCU_IntClkInit(&MCU_Dev.config->clkCfgTbl[i]);
                break;
            }
        }
    } else {
        err = BCM_ERR_UNINIT;
    }
    return err;
}

/** @brief Get clock frequency

    @trace #BRCM_SWARCH_MCU_GETCLKFREQ_PROC
    @trace #BRCM_SWREQ_MCU_QUERY_BCM8957X
 */
uint32_t MCU_GetClkFreq(MCU_ClkCfgIDType aCfgID)
{
    uint32_t i;
    uint32_t clkFreq;

    clkFreq = 0UL;

    if (MCU_IsInitialized() != TRUE) {
        goto err;
    }

    for (i = 0UL; i < MCU_Dev.config->clkCfgTblSize; ++i) {
        if (MCU_Dev.config->clkCfgTbl[i].cfgID == aCfgID) {
            clkFreq = MCU_Dev.config->clkCfgTbl[i].clkRef.freq;
            break;
        }
    }

err:
    return clkFreq;
}

/** @brief Set SGMIIPLUS2 PLL Clock

    @trace #BRCM_SWARCH_MCU_SETSERDESCLK_PROC
    @trace #BRCM_SWREQ_MCU_DYNAMIC_CONFIG_BCM8957X
 */
static int32_t MCU_Enable_SGMIIPLUS2(uint32_t cntrlID)
{
    int32_t retVal = BCM_ERR_OK;

    if (cntrlID >= MCU_SGMIIPLUS2_CTRL_COUNT) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        if (0UL == MCU_Dev.aSGMIIPLUS2PowerUpState) {
            /* Power up the SGMII PLUS2 serdes */
            MCU_ChipMiscRegs->sgmii_plus2_pwrdwn = 0U;
            BCM_CpuNDelay(1000UL * 1000UL);
        }
    }

    if ((BCM_ERR_OK == retVal)
            && (MCU_IS_SGMIIPLUS2_CTRL_POWERUP(cntrlID) == FALSE)) {
        MCU_Dev.aSGMIIPLUS2PowerUpState = MCU_SET_SGMIIPLUS2_CTRL_STATE(cntrlID);
    }

    return retVal;
}

/** @brief Enable SGMIIPCIE_X1

    @trace #BRCM_SWARCH_MCU_SETSERDESCLK_PROC
    @trace #BRCM_SWREQ_MCU_DYNAMIC_CONFIG_BCM8957X
*/
static void MCU_PowerUpSGMIIPCIE_X1()
{
    uint16_t regVal;

    /* Power UP the block */
    regVal = MCU_ChipMiscRegs->sgmii_pcie_pwrdwn;
    if (0U != (regVal & CHIPMISC_SGMII_PCIE_PWRDWN_PWRDWN_MASK)) {
        MCU_ChipMiscRegs->sgmii_pcie_pwrdwn = 0U;
        BCM_CpuNDelay(4 * 1000UL * 1000UL);

    }
}

/** @brief Set SerDes PLL Clock for SGMIIPCIE_X1 in SGMII mode

    @trace #BRCM_SWARCH_MCU_SETSERDESCLK_PROC
    @trace #BRCM_SWREQ_MCU_DYNAMIC_CONFIG_BCM8957X
*/
static void MCU_Enable_SGMII_PCIe(uint32_t cntrlID)
{
    if (0UL == MCU_Dev.aSGMIIPCIEPowerUpState) {
        MCU_PowerUpSGMIIPCIE_X1();

        MCU_Dev.aSGMIIPCIEPowerUpState = MCU_SGMIIPCIE_MODE_SGMII;
    }
}

/** @brief Set SerDes PLL Clock for SGMIIPCIE_X1 in PCIe mode

    @trace #BRCM_SWARCH_MCU_SETSERDESCLK_PROC
    @trace #BRCM_SWREQ_MCU_DYNAMIC_CONFIG_BCM8957X
    */
static void MCU_Enable_PCIe(uint32_t cntrlID)
{
    if (0UL == MCU_Dev.aSGMIIPCIEPowerUpState) {
        /*Configure PCIe*/
        MCU_CRGRegs->reset_config2 = CRG_RESET_CONFIG2_SRST_PCIE_PERST_MASK;
        MCU_REG_WRITE32(0x4C10000C, 0x80000001);

        MCU_PowerUpSGMIIPCIE_X1();

        MCU_Dev.aSGMIIPCIEPowerUpState = MCU_SGMIIPCIE_MODE_PCIE;
    }
}

/** @brief Set SerDes SGMIIPLUSR Clock

    @code{.unparsed}
    if cntrlID is invalid return BCM_ERR_INVAL_PARAMS
    Else
        If Not powered UP
            Read sgmii_plusr_pwrdwn
            If bit'0 is set:
                clear it indicating power up
                Add a delay of 1 ms to ensure power up
            Make the state as Power Up
    return OK
    @endcode

     @trace #BRCM_SWARCH_MCU_SETSERDESCLK_PROC
     @trace #BRCM_SWREQ_MCU_DYNAMIC_CONFIG_BCM8957X
*/
static int32_t MCU_Enable_SGMIIPLUSR(uint32_t cntrlID)
{
    uint16_t regVal;
    int32_t retVal = BCM_ERR_OK;

    if (cntrlID != 0UL) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        if (FALSE == MCU_Dev.aSGMIIPLUSRPowerUpState) {
            /* PowerUp SGMIIPLUSR */
            regVal = MCU_ChipMiscRegs->sgmii_plusr_pwrdwn;
            if (0U != (regVal & CHIPMISC_SGMII_PLUSR_PWRDWN_PWRDWN_MASK)) {
                MCU_ChipMiscRegs->sgmii_plusr_pwrdwn = 0U;
                BCM_CpuNDelay(1000UL * 1000UL) ;
            }

            MCU_Dev.aSGMIIPLUSRPowerUpState = TRUE;
        }
    }

    return retVal;
}

/** @brief Set SerDes PLL Clock

    @trace #BRCM_SWARCH_MCU_SETSERDESCLK_PROC
    @trace #BRCM_SWREQ_MCU_DYNAMIC_CONFIG_BCM8957X
 */
int32_t MCU_SetSerDesClk(MCU_ClkIDType clkID, uint32_t cntrlID)
{
    int32_t retVal;

    if (MCU_IsInitialized() == TRUE) {
        switch(clkID) {
            case MCU_CLK_ID_SGMII_PLUS2:
                retVal = MCU_Enable_SGMIIPLUS2(cntrlID);
                break;
            case MCU_CLK_ID_PCI:
                if (0UL == cntrlID) {
                    MCU_Enable_PCIe(cntrlID);
                    retVal = BCM_ERR_OK;
                } else if (2UL == cntrlID) {
                    MCU_Enable_SGMII_PCIe(cntrlID);
                    retVal = BCM_ERR_OK;
                } else {
                    retVal = BCM_ERR_INVAL_PARAMS;
                }
                break;
            case MCU_CLK_ID_SGMII_PLUSR:
                retVal = MCU_Enable_SGMIIPLUSR(cntrlID);
                break;
            default:
                retVal = BCM_ERR_INVAL_PARAMS;
        }
    } else {
        retVal = BCM_ERR_INVAL_STATE;
    }

    return retVal;
}
/** @} */
