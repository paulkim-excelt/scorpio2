/*****************************************************************************
 Copyright 2020-2021 Broadcom Limited.  All rights reserved.

 This program is the proprietary software of Broadcom Corporation and/or its
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
    @defgroup grp_eth_xcvrdrv_pcie_impl PCIE Driver
    @ingroup grp_eth_xcvrdrv

    @addtogroup grp_eth_xcvrdrv_pcie_impl
    @{

    @file pcie.c
    @brief PCIe Implementation
    This source file contains the implementation of functions for PCIe

    @version 0.1 Initial version
*/

#include <bcm_err.h>
#include <ethxcvr.h>
#include "pcie_osil.h"
#include <mcu_switch_ext.h>
#include <mcu_clk.h>
#include <dwc_xgmac_rdb.h>
/**
    @name PCIE driver Design IDs
    @{
    @brief Design IDs for PCIE driver
*/
#define BRCM_SWDSGN_PCIE_NEG_LINK_MASK_5G_MACRO      (0xC201U)    /**< @brief #PCIE_NEG_LINK_MASK_5G     */
#define BRCM_SWDSGN_PCIE_LINK_STATUS_CONTROL_MACRO   (0xC202U)    /**< @brief #PCIE_LINK_STATUS_CONTROL  */
#define BRCM_SWDSGN_PCIE_LINK_STATUS_MACRO           (0xC203U)    /**< @brief #PCIE_LINK_STATUS          */
#define BRCM_SWDSGN_PCIE_LINK_STATUS_READ_EN_MACRO   (0xC204U)    /**< @brief #PCIE_LINK_STATUS_READ_EN  */
#define BRCM_SWDSGN_PCIE_INIT_PROC                   (0xC205U)    /**< @brief #PCIE_Init                 */
#define BRCM_SWDSGN_PCIE_RESET_PROC                  (0xC206U)    /**< @brief #PCIE_Reset                */
#define BRCM_SWDSGN_PCIE_GETSQIVALUE_PROC            (0xC207U)    /**< @brief #PCIE_GetSQIValue          */
#define BRCM_SWDSGN_PCIE_GETDUPLEXMODE_PROC          (0xC208U)    /**< @brief #PCIE_GetDuplexMode        */
#define BRCM_SWDSGN_PCIE_GETSPEED_PROC               (0xC209U)    /**< @brief #PCIE_GetSpeed             */
#define BRCM_SWDSGN_PCIE_GETLINKSTATE_PROC           (0xC20AU)    /**< @brief #PCIE_GetLinkState         */
#define BRCM_SWDSGN_PCIE_GETMASTERMODE_PROC          (0xC20BU)    /**< @brief #PCIE_GetMasterMode        */
#define BRCM_SWDSGN_PCIE_SETMASTERMODE_PROC          (0xC20CU)    /**< @brief #PCIE_SetMasterMode        */
#define BRCM_SWDSGN_PCIE_GETMODE_PROC                (0xC20DU)    /**< @brief #PCIE_GetMode              */
#define BRCM_SWDSGN_PCIE_SETMODE_PROC                (0xC20EU)    /**< @brief #PCIE_SetMode              */
#define BRCM_SWDSGN_PCIE_LINKIRQHANDLER_PROC         (0xC20FU)    /**< @brief #PCIE_LinkIRQHandler       */
#define BRCM_SWDSGN_PCIE_LINKCHANGEINDHANDLER_PROC   (0xC210U)    /**< @brief #PCIE_LinkChangeIndHandler */
#define BRCM_SWDSGN_PCIE_FUNCTBL_GLOBAL              (0xC211U)    /**< @brief #PCIE_FuncTbl              */
#define BRCM_SWDSGN_PCIE_DEINIT_PROC                 (0xC212U)    /**< @brief #PCIE_DeInit               */
#define BRCM_SWDSGN_PCIE_SETSPEED_PROC               (0xC213U)    /**< @brief #PCIE_SetSpeed             */
#define BRCM_SWDSGN_PCIE_GETLOOPBACKMODE_PROC        (0xC214U)    /**< @brief #PCIE_GetLoopbackMode      */
#define BRCM_SWDSGN_PCIE_SETLOOPBACKMODE_PROC        (0xC215U)    /**< @brief #PCIE_SetLoopbackMode      */
#define BRCM_SWDSGN_PCIE_GETJUMBOMODE_PROC           (0xC216U)    /**< @brief #PCIE_GetJumboMode         */
#define BRCM_SWDSGN_PCIE_SETJUMBOMODE_PROC           (0xC217U)    /**< @brief #PCIE_SetJumboMode         */
#define BRCM_SWDSGN_PCIE_SETAUTONEGMODE_PROC         (0xC218U)    /**< @brief #PCIE_SetAutoNegMode       */
#define BRCM_SWDSGN_PCIE_RESTARTAUTONEG_PROC         (0xC219U)    /**< @brief #PCIE_RestartAutoNeg       */
#define BRCM_SWDSGN_PCIE_GETAUTONEGSTATUS_PROC       (0xC21AU)    /**< @brief #PCIE_GetAutoNegStatus     */
#define BRCM_SWDSGN_PCIE_GETSTATS_PROC               (0xC21BU)    /**< @brief #PCIE_GetStats             */
#define BRCM_SWDSGN_PCIE_STATEHANDLER_PROC           (0xC21CU)    /**< @brief #PCIE_StateHandler         */
#define BRCM_SWDSGN_PCIE_SETDUPLEXMODE_PROC          (0xC21DU)    /**< @brief #PCIE_SetDuplexMode        */
#define BRCM_SWDSGN_PCIE_SETFLOWCONTROL_PROC         (0xC21EU)    /**< @brief #PCIE_SetFlowControl       */
#define BRCM_SWDSGN_PCIE_GETFLOWCONTROL_PROC         (0xC21FU)    /**< @brief #PCIE_GetFlowControl       */
#define BRCM_SWDSGN_PCIE_UPDATEHWSTATUS_PROC         (0xC220U)    /**< @brief #PCIE_UpdateHWStatus       */
#define BRCM_SWDSGN_PCIE_DWC_XGMAC_REGS_GLOBAL       (0xC221U)    /**< @brief #PCIE_DWC_XGMAC_REGS       */
#define BRCM_SWDSGN_PCIE_USELEGACYMODE_PROC          (0xC223U)    /**< @brief #PCIE_UseLegacyMode        */
#define BRCM_SWDSGN_PCIE_ISIPGENABLED_GLOBAL         (0xC224U)    /**< @brief #PCIE_IsIPGEnabled         */
/** @} */

/**
    @name PCIE_IsIPGEnabled
    @brief State Variable for IPG programming on the PCIe block

    This variable is used to check whether IPG programming needs to be done for PCIe block.
    The IPG programming is done only once on power up.

    @trace #BRCM_SWARCH_PCIE_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_PCIE_FUNCTBL
*/
static uint32_t PCIE_IsIPGEnabled COMP_SECTION(".bss.drivers");

/**
    @name PCIE_DWC_XGMAC_REGS
    @brief PCIe MAC Receive Configuration register set

    Structure holding the RDB contents of PCIe sub-system.

    @trace #BRCM_SWARCH_PCIE_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_PCIE_FUNCTBL
*/
static DWC_XGMAC_RDBType* const PCIE_DWC_XGMAC_REGS = (DWC_XGMAC_RDBType *)DWC_XGMAC_BASE;

/**
    @name PCIE_LINK_STATUS_CONTROL
    @brief PCIe Link Status Control Register

    Register to Control the PCIE Link Status Register

    @trace #BRCM_SWARCH_PCIE_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_PCIE_FUNCTBL
*/
#define PCIE_LINK_STATUS_CONTROL        (0x4C102120UL)   /**< @brief PCIE Link Control Register   */

/**
    @name PCIE_LINK_STATUS
    @brief PCIe Link Status Register

    Register to update the PCIE Speed

    @trace #BRCM_SWARCH_PCIE_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_PCIE_FUNCTBL
*/
#define PCIE_LINK_STATUS     (0x4C102124UL)   /**< @brief PCIE Link Speed status   */

/**
    @name PCIE_LINK_STATUS_READ_EN
    @brief PCIe Link Status Enable

    Control bits to Enable the read on Link Status Register

    @trace #BRCM_SWARCH_PCIE_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_PCIE_FUNCTBL
*/
#define PCIE_LINK_STATUS_READ_EN        (0xBCUL)   /**< @brief PCIE Link Status enable   */

/**
    @name PCIE_NEG_LINK_MASK_5G
    @brief PCIe Speed 5G

    Register Masking bits for PCIe 5G Speed

    @trace #BRCM_SWARCH_PCIE_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_PCIE_FUNCTBL
*/
#define PCIE_NEG_LINK_MASK_5G     (0x00020000UL)   /**< @brief PCIE Link Speed 5G Mask   */

/** @brief Determine whether the use the legacy mode

    @behavior Sync, Re-entrant

    @pre None

    Return values are documented in reverse-chronological order
    @retval     uint32_t          TRUE if legacy mode is to be used, FALSE otherwise

    @post None

    @trace #BRCM_SWARCH_PCIE_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_PCIE_FUNCTBL

    @code{.unparsed}
    if BCM8956X and chip is A0
        return true
    else return false
    @endcode

*/
static uint32_t PCIE_UseLegacyMode(void) {
    uint32_t retVal = FALSE;
#ifdef __BCM8956X__
    MCU_VersionType version;

    MCU_GetVersion(&version);
    if (MCU_CHIP_VERSION_A0 == version.rev) {
        retVal = TRUE;
    }
#endif

    return retVal;
}

/** @brief Get PCIE LinkState

    @behavior Sync, Re-entrant

    @pre None

    @param[in]    aBusIdx        Bus Index
    @param[in]    aPhyCntxt      Phy Context
    @param[in]    aConfig        Port Configuration
    @param[out]   aLinkState     Link State

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK          Success

    @post None

    @trace #BRCM_SWARCH_PCIE_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_PCIE_FUNCTBL

    @code{.unparsed}
    *aLinkState = ETHXCVR_LINKSTATE_ACTIVE
    return BCM_ERR_OK
    @endcode

*/
static int32_t PCIE_GetLinkState(uint8_t aBusIdx,
                                    ETHXCVR_CntxtType *const aPhyCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig,
                                    ETHXCVR_LinkStateType *const aLinkState)
{
    *aLinkState = ETHXCVR_LINKSTATE_ACTIVE;
    return BCM_ERR_OK;
}

/** @brief Reset PCIE

    @behavior Sync, Re-entrant

    @pre None

    @param[in]    aBusIdx        Bus Index
    @param[in]    aPhyCntxt      Phy Context
    @param[in]    aConfig        Port Configuration

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_NOSUPPORT    No Support

    @post None

    @trace #BRCM_SWARCH_PCIE_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_PCIE_FUNCTBL

    @code{.unparsed}
    return BCM_ERR_NOSUPPORT
    @endcode

*/
static int32_t PCIE_Reset(uint8_t aBusIdx,
                              ETHXCVR_CntxtType *const aPhyCntxt,
                              const ETHXCVR_PortConfigType *const aConfig)
{
    return BCM_ERR_NOSUPPORT;
}

/** @brief Set PCIE Mode

    @behavior Sync, Re-entrant

    @pre None

    @param[in]    aBusIdx        Bus Index
    @param[in]    aPhyCntxt      Phy Context
    @param[in]    aConfig        Port Configuration
    @param[in]    aMode          Link State

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_NOSUPPORT          No Support

    @post None

    @trace #BRCM_SWARCH_PCIE_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_PCIE_FUNCTBL

    @code{.unparsed}
    if PCIE_UseLegacyMode returns FALSE AND PCIE_IsIPGEnabled is FALSE
        regVal is PCIE_DWC_XGMAC_REGS->tx_configuration
        regVal |= (DWC_XGMAC_MAC_TX_CONFIGURATION_IFP_MASK |
                  (DWC_XGMAC_MAC_TX_CONFIGURATION_IPG_VALUE <<
                  DWC_XGMAC_MAC_TX_CONFIGURATION_IPG_SHIFT))
        PCIE_DWC_XGMAC_REGS->tx_configuration = regVal
        regVal is PCIE_DWC_XGMAC_REGS->extended_configuration
        regVal &= ~(DWC_XGMAC_MAC_EXTENDED_CONFIGURATION_EIPG_MASK)
        regVal |= DWC_XGMAC_EXTENDED_MAC_CONFIGURATION_EIPG_VALUE
        PCIE_DWC_XGMAC_REGS->extended_configuration = regVal
        PCIE_IsIPGEnabled is TRUE
    if PCIE_UseLegacyMode returns FALSE
        if ETHXCVR_MODE_ACTIVE is aMode
            retVal = MCU_SetSerDesClk(MCU_CLK_ID_PCI, aConfig->bus.cntrlID);
            if BCM_ERR_OK is retVal
                regVal is PCIE_DWC_XGMAC_REGS->rx_configuration
                regVal |= DWC_XGMAC_MAC_RX_CONFIGURATION_RE_MASK
                PCIE_DWC_XGMAC_REGS->rx_configuration = regVal
        else if ETHXCVR_MODE_ISOLATE is aMode
            regVal is PCIE_DWC_XGMAC_REGS->rx_configuration
            regVal &= ~(DWC_XGMAC_MAC_RX_CONFIGURATION_RE_MASK)
            PCIE_DWC_XGMAC_REGS->rx_configuration
        else
            retVal = BCM_ERR_NOSUPPORT
    else
        if ETHXCVR_MODE_ACTIVE is aMode
            retVal = MCU_SetSerDesClk(MCU_CLK_ID_PCI, aConfig->bus.cntrlID);
        else
            retVal = BCM_ERR_NOSUPPORT

    @endcode

*/
static int32_t PCIE_SetMode(uint8_t aBusIdx,
                                ETHXCVR_CntxtType *const aPhyCntxt,
                                const ETHXCVR_PortConfigType *const aConfig,
                                ETHXCVR_ModeType aMode)
{
    int32_t retVal = BCM_ERR_OK;
    int32_t regVal = 0UL;

    /* Configure the IPG control on PCIe port */
    /* Valid only for BCM8956X-B0 and BCM8957X-A0, to be done on power-up */
    if((FALSE == PCIE_UseLegacyMode()) && (FALSE == PCIE_IsIPGEnabled)) {
        regVal = PCIE_DWC_XGMAC_REGS->tx_configuration;
        regVal |= (DWC_XGMAC_MAC_TX_CONFIGURATION_IFP_MASK |
                  (DWC_XGMAC_MAC_TX_CONFIGURATION_IPG_VALUE <<
                  DWC_XGMAC_MAC_TX_CONFIGURATION_IPG_SHIFT));
        PCIE_DWC_XGMAC_REGS->tx_configuration = regVal;

        regVal = PCIE_DWC_XGMAC_REGS->extended_configuration;
        regVal &= ~(DWC_XGMAC_MAC_EXTENDED_CONFIGURATION_EIPG_MASK);
        regVal |= DWC_XGMAC_EXTENDED_MAC_CONFIGURATION_EIPG_VALUE;
        PCIE_DWC_XGMAC_REGS->extended_configuration = regVal;

        PCIE_IsIPGEnabled = TRUE;
    }

    if(FALSE == PCIE_UseLegacyMode()) {
        if(ETHXCVR_MODE_ACTIVE == aMode) {
            retVal = MCU_SetSerDesClk(MCU_CLK_ID_PCI, aConfig->bus.cntrlID);
            if (BCM_ERR_OK == retVal) {
                regVal = PCIE_DWC_XGMAC_REGS->rx_configuration;
                regVal |= DWC_XGMAC_MAC_RX_CONFIGURATION_RE_MASK;
                PCIE_DWC_XGMAC_REGS->rx_configuration = regVal;
            }
        } else if(ETHXCVR_MODE_ISOLATE == aMode) {
            regVal = PCIE_DWC_XGMAC_REGS->rx_configuration;
            regVal &= ~(DWC_XGMAC_MAC_RX_CONFIGURATION_RE_MASK);
            PCIE_DWC_XGMAC_REGS->rx_configuration = regVal;
        } else {
            retVal = BCM_ERR_NOSUPPORT;
        }
    } else {
        if (ETHXCVR_MODE_ACTIVE == aMode) {
            retVal = MCU_SetSerDesClk(MCU_CLK_ID_PCI, aConfig->bus.cntrlID);
        } else {
            retVal = BCM_ERR_NOSUPPORT;
        }
    }

    return retVal;
}

/** @brief Get PCIE Mode

    @behavior Sync, Re-entrant

    @pre None

    @param[in]    aBusIdx        Bus Index
    @param[in]    aPhyCntxt      Phy Context
    @param[in]    aConfig        Port Configuration
    @param[out]   aMode          Mode

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK          Success

    @post None

    @trace #BRCM_SWARCH_PCIE_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_PCIE_FUNCTBL

    @code{.unparsed}
    if PCIE_UseLegacyMode returns FALSE
        regVal is PCIE_DWC_XGMAC_REGS->rx_configuration
        if DWC_XGMAC_MAC_RX_CONFIGURATION_RE_MASK is regVal)
            *aMode is ETHXCVR_MODE_ACTIVE;
        else
            *aMode is ETHXCVR_MODE_ISOLATE
    else
           *aMode is ETHXCVR_MODE_ACTIVE;

    return BCM_ERR_OK
    @endcode

*/
static int32_t PCIE_GetMode(uint8_t aBusIdx,
                                ETHXCVR_CntxtType *const aPhyCntxt,
                                const ETHXCVR_PortConfigType *const aConfig,
                                ETHXCVR_ModeType *const aMode)
{
    int32_t regVal = 0UL;

    if (FALSE == PCIE_UseLegacyMode()) {
        regVal = PCIE_DWC_XGMAC_REGS->rx_configuration;
        if(DWC_XGMAC_MAC_RX_CONFIGURATION_RE_MASK ==
          (DWC_XGMAC_MAC_RX_CONFIGURATION_RE_MASK & regVal)) {
            *aMode = ETHXCVR_MODE_ACTIVE;
        } else {
            *aMode = ETHXCVR_MODE_ISOLATE;
        }
    } else {
        *aMode = ETHXCVR_MODE_ACTIVE;
    }

    return BCM_ERR_OK;
}

/** @brief Set PCIE Master Mode

    @behavior Sync, Re-entrant

    @pre None

    @param[in]    aBusIdx        Bus Index
    @param[in]    aPhyCntxt      Phy Context
    @param[in]    aConfig        Port Configuration
    @param[in]    aMasterMode    Master Mode

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_NOSUPPORT          No Support

    @post None

    @trace #BRCM_SWARCH_PCIE_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_PCIE_FUNCTBL

    @code{.unparsed}
    return BCM_ERR_NOSUPPORT
    @endcode

*/
static int32_t PCIE_SetMasterMode(uint8_t aBusIdx,
                                      ETHXCVR_CntxtType *const aPhyCntxt,
                                      const ETHXCVR_PortConfigType *const aConfig,
                                      ETHXCVR_BooleanType aMasterMode)
{
    return BCM_ERR_NOSUPPORT;
}

/** @brief Get PCIE Master Mode

    @behavior Sync, Re-entrant

    @pre None

    @param[in]    aBusIdx        Bus Index
    @param[in]    aPhyCntxt      Phy Context
    @param[in]    aConfig        Port Configuration
    @param[out]   aMasterMode    Master Mode

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_NOSUPPORT      BCM_ERR_NOSUPPORT

    @post None

    @trace #BRCM_SWARCH_PCIE_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_PCIE_FUNCTBL

    @code{.unparsed}
    return BCM_ERR_NOSUPPORT
    @endcode

*/
static int32_t PCIE_GetMasterMode(uint8_t aBusIdx,
                                      ETHXCVR_CntxtType *const aPhyCntxt,
                                      const ETHXCVR_PortConfigType *const aConfig,
                                      ETHXCVR_BooleanType *const aMasterMode)
{
    return BCM_ERR_NOSUPPORT;
}

/** @brief Set PCIE Speed

    @behavior Sync, Re-entrant

    @pre None

    @param[in]    aBusIdx        Bus Index
    @param[in]    aPhyCntxt      Phy Context
    @param[in]    aConfig        Port Configuration
    @param[in]    aSpeed         Speed

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_NOSUPPORT          No Support

    @post None

    @trace #BRCM_SWARCH_PCIE_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_PCIE_FUNCTBL

    @code{.unparsed}
    if (ETHXCVR_SPEED_5000MBPS == aSpeed)
        return BCM_ERR_OK
    else
        return BCM_ERR_NOSUPPORT
    @endcode

*/
static int32_t PCIE_SetSpeed(uint8_t aBusIdx,
                                 ETHXCVR_CntxtType *const aPhyCntxt,
                                 const ETHXCVR_PortConfigType *const aConfig,
                                 ETHXCVR_SpeedType aSpeed)
{
    int32_t retVal;

    if (ETHXCVR_SPEED_5000MBPS == aSpeed) {
        retVal = BCM_ERR_OK;
    } else {
        retVal = BCM_ERR_NOSUPPORT;
    }
    return retVal;
}

/** @brief Get PCIE Speed

    @behavior Sync, Re-entrant

    @pre None

    @param[in]    aBusIdx        Bus Index
    @param[in]    aPhyCntxt      Phy Context
    @param[in]    aConfig        Port Configuration
    @param[out]   aSpeed         Speed

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK          Success

    @post None

    @trace #BRCM_SWARCH_PCIE_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_PCIE_FUNCTBL

    @code{.unparsed}
    if aSpeed is NULL
        retVal = BCM_ERR_INVAL_PARAMS
    else
        *aSpeed = ETHXCVR_SPEED_5000MBPS
        retVal = BCM_ERR_OK
    return retVal
    @endcode

*/
static int32_t PCIE_GetSpeed(uint8_t aBusIdx,
                                 ETHXCVR_CntxtType *const aPhyCntxt,
                                 const ETHXCVR_PortConfigType *const aConfig,
                                 ETHXCVR_SpeedType *const aSpeed)
{
    int32_t retVal;

    if(NULL == aSpeed ) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        *aSpeed = ETHXCVR_SPEED_5000MBPS;
        retVal = BCM_ERR_OK;
    }
    return retVal;
}

/** @brief Get PCIE Duplex Mode

    @behavior Sync, Re-entrant

    @pre None

    @param[in]    aBusIdx        Bus Index
    @param[in]    aPhyCntxt      Phy Context
    @param[in]    aConfig        Port Configuration
    @param[in]    aDuplexMode    Duplex Mode

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK          Success

    @post None

    @trace #BRCM_SWARCH_PCIE_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_PCIE_FUNCTBL

    @code{.unparsed}
    *aDuplexMode = ETHXCVR_DUPLEXMODE_FULL;
    return BCM_ERR_OK
    @endcode

*/
static int32_t PCIE_GetDuplexMode(uint8_t aBusIdx,
                                 ETHXCVR_CntxtType *const aPhyCntxt,
                                 const ETHXCVR_PortConfigType *const aConfig,
                                 ETHXCVR_DuplexModeType *const aDuplexMode)
{
    *aDuplexMode = ETHXCVR_DUPLEXMODE_FULL;
    return BCM_ERR_OK;
}

/** @brief Set PCIE Duplex Mode

    @behavior Sync, Re-entrant

    @pre None

    @param[in]    aBusIdx        Bus Index
    @param[in]    aPhyCntxt      Phy Context
    @param[in]    aConfig        Port Configuration
    @param[in]    aDuplexMode    Duplex Mode

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_NOSUPPORT          No Support

    @post None

    @trace #BRCM_SWARCH_PCIE_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_PCIE_FUNCTBL

    @code{.unparsed}
    if (ETHXCVR_DUPLEXMODE_FULL == aDuplexMode)
        return BCM_ERR_OK
    else
        return BCM_ERR_NOSUPPORT
    @endcode

*/
static int32_t PCIE_SetDuplexMode(uint8_t aBusIdx,
                                 ETHXCVR_CntxtType *const aPhyCntxt,
                                 const ETHXCVR_PortConfigType *const aConfig,
                                 ETHXCVR_DuplexModeType aDuplexMode)
{
    int32_t retVal;

    if (ETHXCVR_DUPLEXMODE_FULL == aDuplexMode) {
        retVal = BCM_ERR_OK;
    } else {
        retVal = BCM_ERR_NOSUPPORT;
    }
    return retVal;
}

/** @brief Set PCIE Flow Control

    @behavior Sync, Re-entrant

    @pre None

    @param[in]    aBusIdx        Bus Index
    @param[in]    aPhyCntxt      Phy Context
    @param[in]    aConfig        Port Configuration
    @param[in]    aFlowControl   aFlowControl

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_NOSUPPORT          No Support

    @post None

    @trace #BRCM_SWARCH_PCIE_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_PCIE_FUNCTBL

    @code{.unparsed}
    if (ETHXCVR_FLOWCONTROL_NONE == aFlowControl)
        return BCM_ERR_OK
    else
        return BCM_ERR_NOSUPPORT
    @endcode

*/
static int32_t PCIE_SetFlowControl(uint8_t aBusIdx,
                                 ETHXCVR_CntxtType *const aPhyCntxt,
                                 const ETHXCVR_PortConfigType *const aConfig,
                                 ETHXCVR_FlowControlType aFlowControl)
{
    int32_t retVal;

    if (ETHXCVR_FLOWCONTROL_NONE == aFlowControl) {
        retVal = BCM_ERR_OK;
    } else {
        retVal = BCM_ERR_NOSUPPORT;
    }
    return retVal;
}

/** @brief Get PCIE Flow Control

    @behavior Sync, Re-entrant

    @pre None

    @param[in]    aBusIdx        Bus Index
    @param[in]    aPhyCntxt      Phy Context
    @param[in]    aConfig        Port Configuration
    @param[out]   aFlowControl   aFlowControl

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK          Success

    @post None

    @trace #BRCM_SWARCH_PCIE_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_PCIE_FUNCTBL

    @code{.unparsed}
    *aFlowControl = ETHXCVR_FLOWCONTROL_NONE;
    return BCM_ERR_OK
    @endcode

*/
static int32_t PCIE_GetFlowControl(uint8_t aBusIdx,
                                 ETHXCVR_CntxtType *const aPhyCntxt,
                                 const ETHXCVR_PortConfigType *const aConfig,
                                 ETHXCVR_FlowControlType *const aFlowControl)
{
    *aFlowControl = ETHXCVR_FLOWCONTROL_NONE;
    return BCM_ERR_OK;
}


/** @brief Get PCIE SQI Value

    @behavior Sync, Re-entrant

    @pre None

    @param[in]    aBusIdx        Bus Index
    @param[in]    aPhyCntxt      Phy Context
    @param[in]    aConfig        Port Configuration
    @param[out]   aSQIValue      aSQIValue

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_NOSUPPORT      No Support

    @post None

    @trace #BRCM_SWARCH_PCIE_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_PCIE_FUNCTBL

    @code{.unparsed}
    return BCM_ERR_NOSUPPORT
    @endcode

*/
static int32_t PCIE_GetSQIValue(uint8_t aBusIdx,
                                 ETHXCVR_CntxtType *const aPhyCntxt,
                                 const ETHXCVR_PortConfigType *const aConfig,
                                 uint32_t *const aSQIValue)
{
    return BCM_ERR_NOSUPPORT;
}

/** @brief PCIE Init

    @behavior Sync, Re-entrant

    @pre None

    @param[in]    aBusIdx            Bus Index
    @param[in]    aPhyCntxt      Phy Context
    @param[in]    aConfig        Port Configuration

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK          Success

    @post None

    @trace #BRCM_SWARCH_PCIE_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_PCIE_FUNCTBL

    @code{.unparsed}
    return BCM_ERR_OK
    @endcode

*/
static int32_t PCIE_Init(uint8_t aBusIdx,
                             ETHXCVR_CntxtType *const aPhyCntxt,
                             const ETHXCVR_PortConfigType *const aConfig)
{
    PCIE_IsIPGEnabled = FALSE;
    return BCM_ERR_OK;
}

/** @brief Get PCIE DeInit

    @behavior Sync, Re-entrant

    @pre None

    @param[in]    aBusIdx        Bus Index
    @param[in]    aPhyCntxt      Phy Context
    @param[in]    aConfig        Port Configuration

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK          Success

    @post None

    @trace #BRCM_SWARCH_PCIE_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_PCIE_FUNCTBL

    @code{.unparsed}
    return BCM_ERR_OK
    @endcode

*/
static int32_t PCIE_DeInit(uint8_t aBusIdx,
                               ETHXCVR_CntxtType *const aPhyCntxt,
                               const ETHXCVR_PortConfigType *const aConfig)
{
    return BCM_ERR_OK;
}

/** @brief Set PCIE LoopBack Mode

    @behavior Sync, Re-entrant

    @pre None

    @param[in]    aBusIdx        Bus Index
    @param[in]    aPhyCntxt      Phy Context
    @param[in]    aConfig        Port Configuration
    @param[in]    aMode          aMode

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_NOSUPPORT      No Support

    @post None

    @trace #BRCM_SWARCH_PCIE_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_PCIE_FUNCTBL

    @code{.unparsed}
    if (ETHXCVR_BOOLEAN_FALSE == aMode)
        return BCM_ERR_OK
    else
        return BCM_ERR_NOSUPPORT
    @endcode

*/
static int32_t PCIE_SetLoopbackMode(uint8_t aBusIdx,
                                 ETHXCVR_CntxtType *const aPhyCntxt,
                                 const ETHXCVR_PortConfigType *const aConfig,
                                 ETHXCVR_BooleanType aMode)
{
    int32_t retVal;

    if (ETHXCVR_BOOLEAN_FALSE == aMode) {
        retVal = BCM_ERR_OK;
    } else {
        retVal = BCM_ERR_NOSUPPORT;
    }
    return retVal;
}

/** @brief Get PCIE LoopBack Mode

    @behavior Sync, Re-entrant

    @pre None

    @param[in]    aBusIdx        Bus Index
    @param[in]    aPhyCntxt      Phy Context
    @param[in]    aConfig        Port Configuration
    @param[out]   aMode          aMode

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK          Success

    @post None

    @trace #BRCM_SWARCH_PCIE_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_PCIE_FUNCTBL

    @code{.unparsed}
    *aMode = ETHXCVR_BOOLEAN_FALSE;
    return BCM_ERR_OK
    @endcode

*/
static int32_t PCIE_GetLoopbackMode(uint8_t aBusIdx,
                                 ETHXCVR_CntxtType *const aPhyCntxt,
                                 const ETHXCVR_PortConfigType *const aConfig,
                                 ETHXCVR_BooleanType *const aMode)
{
    *aMode = ETHXCVR_BOOLEAN_FALSE;
    return BCM_ERR_OK;
}

/** @brief Set PCIE Jumbo Mode

    @behavior Sync, Re-entrant

    @pre None

    @param[in]    aBusIdx        Bus Index
    @param[in]    aPhyCntxt      Phy Context
    @param[in]    aConfig        Port Configuration
    @param[in]    aMode          aMode

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_NOSUPPORT      No Support

    @post None

    @trace #BRCM_SWARCH_PCIE_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_PCIE_FUNCTBL

    @code{.unparsed}
    if (ETHXCVR_BOOLEAN_FALSE == aMode)
        return BCM_ERR_OK
    else
        return BCM_ERR_NOSUPPORT
    @endcode

*/
static int32_t PCIE_SetJumboMode(uint8_t aBusIdx,
                                 ETHXCVR_CntxtType *const aPhyCntxt,
                                 const ETHXCVR_PortConfigType *const aConfig,
                                 ETHXCVR_BooleanType aMode)
{
    int32_t retVal;

    if (ETHXCVR_BOOLEAN_FALSE == aMode) {
        retVal = BCM_ERR_OK;
    } else {
        retVal = BCM_ERR_NOSUPPORT;
    }
    return retVal;
}

/** @brief Get PCIE Jumbo Mode

    @behavior Sync, Re-entrant

    @pre None

    @param[in]    aBusIdx        Bus Index
    @param[in]    aPhyCntxt      Phy Context
    @param[in]    aConfig        Port Configuration
    @param[out]   aMode          aMode

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK          Success

    @post None

    @trace #BRCM_SWARCH_PCIE_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_PCIE_FUNCTBL

    @code{.unparsed}
    *aMode = ETHXCVR_BOOLEAN_FALSE;
    return BCM_ERR_OK
    @endcode

*/
static int32_t PCIE_GetJumboMode(uint8_t aBusIdx,
                                 ETHXCVR_CntxtType *const aPhyCntxt,
                                 const ETHXCVR_PortConfigType *const aConfig,
                                 ETHXCVR_BooleanType *const aMode)
{
    *aMode = ETHXCVR_BOOLEAN_FALSE;
    return BCM_ERR_OK;
}

/** @brief Set PCIE AutoNegMode

    @behavior Sync, Re-entrant

    @pre None

    @param[in]    aBusIdx        Bus Index
    @param[in]    aPhyCntxt      Phy Context
    @param[in]    aConfig        Port Configuration
    @param[in]    aMode          aMode

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_NOSUPPORT      No Support

    @post None

    @trace #BRCM_SWARCH_PCIE_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_PCIE_FUNCTBL

    @code{.unparsed}
    return BCM_ERR_NOSUPPORT
    @endcode

*/
static int32_t PCIE_SetAutoNegMode(uint8_t aBusIdx,
                                 ETHXCVR_CntxtType *const aPhyCntxt,
                                 const ETHXCVR_PortConfigType *const aConfig,
                                 ETHXCVR_BooleanType aMode)
{
    return BCM_ERR_NOSUPPORT;
}

/** @brief Restat PCIE AutoNeg

    @behavior Sync, Re-entrant

    @pre None

    @param[in]    aBusIdx        Bus Index
    @param[in]    aPhyCntxt      Phy Context
    @param[in]    aConfig        Port Configuration

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_NOSUPPORT    No Support

    @post None

    @trace #BRCM_SWARCH_PCIE_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_PCIE_FUNCTBL

    @code{.unparsed}
    return BCM_ERR_NOSUPPORT
    @endcode

*/
static int32_t PCIE_RestartAutoNeg(uint8_t aBusIdx,
                                 ETHXCVR_CntxtType *const aPhyCntxt,
                                 const ETHXCVR_PortConfigType *const aConfig)
{
    return BCM_ERR_NOSUPPORT;
}

/** @brief Get PCIE AutoNeg Status

    @behavior Sync, Re-entrant

    @pre None

    @param[in]    aBusIdx        Bus Index
    @param[in]    aPhyCntxt      Phy Context
    @param[in]    aConfig        Port Configuration
    @param[out]   aStatus        aStatus

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK          Success

    @post None

    @trace #BRCM_SWARCH_PCIE_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_PCIE_FUNCTBL

    @code{.unparsed}
    *aStatus = ETHXCVR_AUTONEGSTATUS_NO_ABILITY;
    return BCM_ERR_OK
    @endcode

*/
static int32_t PCIE_GetAutoNegStatus(uint8_t aBusIdx,
                                 ETHXCVR_CntxtType *const aPhyCntxt,
                                 const ETHXCVR_PortConfigType *const aConfig,
                                 ETHXCVR_AutoNegStatusType *const aStatus)
{
    *aStatus = ETHXCVR_AUTONEGSTATUS_NO_ABILITY;
    return BCM_ERR_OK;
}

/** @brief Get PCIE Stats

    @behavior Sync, Re-entrant

    @pre None

    @param[in]    aBusIdx        Bus Index
    @param[in]    aPhyCntxt      Phy Context
    @param[in]    aConfig        Port Configuration
    @param[out]   aStats         aStats

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK          Success

    @post None

    @trace #BRCM_SWARCH_PCIE_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_PCIE_FUNCTBL

    @code{.unparsed}
    return BCM_ERR_OK
    @endcode

*/
static int32_t PCIE_GetStats(uint8_t aBusIdx,
                                 ETHXCVR_CntxtType *const aPhyCntxt,
                                 const ETHXCVR_PortConfigType *const aConfig,
                                 ETHXCVR_StatsType *const aStats)
{
    return BCM_ERR_OK;
}

/** @brief PCIE State Handler

    @behavior Sync, Re-entrant

    @pre None

    @param[in]    aBusIdx        Bus Index
    @param[in]    aPhyCntxt      Phy Context
    @param[in]    aConfig        Port Configuration
    @param[in]    aIsModeChanged aIsModeChanged
    @param[in]    aMode          aMode

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK          Success

    @post None

    @trace #BRCM_SWARCH_PCIE_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_PCIE_FUNCTBL

    @code{.unparsed}
    return BCM_ERR_OK
    @endcode

*/
static int32_t PCIE_StateHandler(uint8_t aBusIdx,
                                 ETHXCVR_CntxtType *const aPhyCntxt,
                                 const ETHXCVR_PortConfigType *const aConfig,
                                 uint32_t *const aIsModeChanged,
                                 ETHXCVR_ModeType *const aMode)
{
    return BCM_ERR_OK;
}

/** @brief PCIE Update HWStatus

    @behavior Sync, Re-entrant

    @pre None

    @param[in]    aBusIdx        Bus Index
    @param[in]    aPhyCntxt      Phy Context
    @param[in]    aConfig        Port Configuration

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_NOSUPPORT      No Support
    @post None

    @trace #BRCM_SWARCH_PCIE_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_PCIE_FUNCTBL

    @code{.unparsed}
    return BCM_ERR_NOSUPPORT
    @endcode

*/
static int32_t PCIE_UpdateHWStatus(uint8_t aBusIdx,
                                 ETHXCVR_CntxtType *const aPhyCntxt,
                                 const ETHXCVR_PortConfigType *const aConfig)
{
    return BCM_ERR_NOSUPPORT;
}

/** @brief PCIE Link IRQ Handler

    @behavior Sync, Re-entrant

    @pre None

    @param[in]    aBusIdx        Bus Index
    @param[in]    aPhyCntxt      Phy Context
    @param[in]    aConfig        Port Configuration

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_NOSUPPORT   No Support

    @post None

    @trace #BRCM_SWARCH_PCIE_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_PCIE_FUNCTBL

    @code{.unparsed}
    return BCM_ERR_NOSUPPORT
    @endcode

*/
static int32_t PCIE_LinkIRQHandler(uint8_t aBusIdx,
                                 ETHXCVR_CntxtType *const aPhyCntxt,
                                 const ETHXCVR_PortConfigType *const aConfig)
{
    return BCM_ERR_NOSUPPORT;
}

/** @brief PCIE Link Change Handler

    @behavior Sync, Re-entrant

    @pre None

    @param[in]    aBusIdx                 Bus Index
    @param[in]    aPhyCntxt               Phy Context
    @param[in]    aConfig                 Port Configuration
    @param[out]   aIsLinkStateChanged     aIsLinkStateChanged

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK          Success

    @post None

    @trace #BRCM_SWARCH_PCIE_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_PCIE_FUNCTBL

    @code{.unparsed}
    *aIsLinkStateChanged = FALSE;
    return BCM_ERR_OK
    @endcode

*/
static int32_t PCIE_LinkChangeIndHandler(uint8_t aBusIdx,
                                 ETHXCVR_CntxtType *const aPhyCntxt,
                                 const ETHXCVR_PortConfigType *const aConfig,
                                 ETHXCVR_LinkStateType *const aLinkState,
                                 uint32_t *const aIsLinkStateChanged)
{
    *aIsLinkStateChanged = FALSE;
    return BCM_ERR_OK;
}
/** @} */

/**
    @addtogroup grp_eth_xcvrdrv_pcie_il
    @{
*/

/** @brief  PCIE Function Table

    @trace #BRCM_SWARCH_PCIE_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_PCIE_FUNCTBL
*/
const ETHXCVR_FuncTblType PCIE_FuncTbl = {
    .init = PCIE_Init,
    .deinit = PCIE_DeInit,
    .reset = PCIE_Reset,
    .setMode = PCIE_SetMode,
    .getMode = PCIE_GetMode,
    .setMasterMode = PCIE_SetMasterMode,
    .getMasterMode = PCIE_GetMasterMode,
    .getSpeed = PCIE_GetSpeed,
    .setSpeed = PCIE_SetSpeed,
    .getDuplexMode = PCIE_GetDuplexMode,
    .setDuplexMode = PCIE_SetDuplexMode,
    .setFlowControl = PCIE_SetFlowControl,
    .getFlowControl = PCIE_GetFlowControl,
    .getLinkState = PCIE_GetLinkState,
    .getSQIValue = PCIE_GetSQIValue,
    .setLoopbackMode = PCIE_SetLoopbackMode,
    .getLoopbackMode = PCIE_GetLoopbackMode,
    .setJumboMode = PCIE_SetJumboMode,
    .getJumboMode = PCIE_GetJumboMode,
    .setAutoNegMode = PCIE_SetAutoNegMode,
    .getAutoNegStatus = PCIE_GetAutoNegStatus,
    .restartAutoNeg = PCIE_RestartAutoNeg,
    .getStats = PCIE_GetStats,
    .stateHandler = PCIE_StateHandler,
    .updateHWStatus = PCIE_UpdateHWStatus,
    .linkChangeIndHandler = PCIE_LinkChangeIndHandler,
    .linkIRQHandler  = PCIE_LinkIRQHandler,
};
/** @} */

/* Nothing past this line */
