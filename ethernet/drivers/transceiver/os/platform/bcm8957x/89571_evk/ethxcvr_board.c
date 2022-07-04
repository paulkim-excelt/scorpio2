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
    @defgroup grp_eth_xcvrdrv_bcm89571_evk BCM89571 EVK
    @ingroup grp_eth_xcvrdrv_plat_impl

    @addtogroup grp_eth_xcvrdrv_bcm89571_evk
    @{

    @file ethxcvr_board.c
    @brief This file implements the board layer for Ethernet Transceiver driver.

    @version 0.1 Initial draft
*/

#include <compiler.h>
#include <bcm_err.h>
#include <ethxcvr_osil.h>
#if defined(ENABLE_ETH_DENALIPHY)
#include <denaliphy_osil.h>
#endif

/**
    @name Transceiver driver board Design IDs
    @{
    @brief Design IDs for Transceiver driver board layer
*/
#define BRCM_SWDSGN_ETHXCVR_PLATFORM_CNTXT_GLOBAL        (0xC801U) /**< @brief #ETHXCVR_PlatformCntxt */
#define BRCM_SWDSGN_ETHXCVR_BOARDGETPHYFNTBL_PROC        (0xC802U) /**< @brief #ETHXCVR_BoardGetPhyFnTbl */
#define BRCM_SWDSGN_ETHXCVR_BOARDVALIDATEPHYCONFIG_PROC  (0xC803U) /**< @brief #ETHXCVR_BoardValidatePhyConfig */
/** @} */

/**
    @trace #BRCM_SWARCH_ETHXCVR_BOARDGETPHYFNTBL_PROC
    @trace #BRCM_SWREQ_ETHXCVR_KERNEL_HANDLER_BCM8957X
*/
static ETHXCVR_CntxtType ETHXCVR_PlatformCntxt[3] COMP_SECTION(".bss.drivers");

/**
    @trace #BRCM_SWARCH_ETHXCVR_BOARDGETPHYFNTBL_PROC
    @trace #BRCM_SWREQ_ETHXCVR_KERNEL_HANDLER_BCM8957X

    | Port |  Bus Mode  |    PHY Table    | PHY Context # |
    |-----:|:----------:|:---------------:|:-------------:|
    |  1   |     -      |      DENALI     |       0       |
    |  3   |    RGMII   |      DENALI     |       1       |
    |  5   |    RGMII   |      DENALI     |       1       |
    |  6   |    RGMII   |      DENALI     |       2       |
*/
int32_t ETHXCVR_BoardGetPhyFnTbl(const ETHXCVR_PortConfigType *const aConfig,
                                 const ETHXCVR_FuncTblType **const aPhyFnTbl,
                                 ETHXCVR_CntxtType **const aPhyCntxt)
{
    const ETHXCVR_FuncTblType *const denaliPhyTbl = NULL;

    *aPhyFnTbl = NULL;
    *aPhyCntxt = NULL;

    switch (aConfig->id) {
    case 1U:
        if (ETHXCVR_ACCESSMODE_MDIO == aConfig->phy.accessMode) {
            *aPhyFnTbl = denaliPhyTbl;
            *aPhyCntxt = &ETHXCVR_PlatformCntxt[0];
        }
        break;
    case 3U:
        if (ETHXCVR_ACCESSMODE_MDIO == aConfig->phy.accessMode) {
            *aPhyFnTbl = denaliPhyTbl;
            *aPhyCntxt = &ETHXCVR_PlatformCntxt[1];
        }
        break;
    case 5U:
        if ((aConfig->busMode == ETHXCVR_BUSMODE_RGMII)
            && (ETHXCVR_ACCESSMODE_MDIO == aConfig->phy.accessMode)) {
            *aPhyFnTbl = denaliPhyTbl;
            *aPhyCntxt = &ETHXCVR_PlatformCntxt[1];
        }
        break;
    case 6U:
        if ((aConfig->busMode == ETHXCVR_BUSMODE_RGMII)
            && (ETHXCVR_ACCESSMODE_MDIO == aConfig->phy.accessMode)) {
            *aPhyFnTbl = denaliPhyTbl;
            *aPhyCntxt = &ETHXCVR_PlatformCntxt[2];
        }
        break;
#if 1 /* --2022.05-17-paul RGMII interface for P8*/
      case 8U:
	   if ((aConfig->busMode == ETHXCVR_BUSMODE_RGMII)
            && (ETHXCVR_ACCESSMODE_MDIO == aConfig->phy.accessMode)) {
            *aPhyFnTbl = denaliPhyTbl;
            *aPhyCntxt = &ETHXCVR_PlatformCntxt[1];
        }
#endif
    default:
        break;
    }

    return BCM_ERR_OK;
}

/**
    @trace #BRCM_SWARCH_ETHXCVR_BOARDVALIDATEPHYCONFIG_PROC
    @trace #BRCM_SWREQ_ETHXCVR_KERNEL_HANDLER_BCM8957X

    |port|phyAccess| phySlvID |phyHwID|autoneg|busMode| phyMedia |  speed  |
    |:--:|:-------:|:--------:|:-----:|:-----:|:-----:|:--------:|:-------:|
    |  1  |  MDIO  |    2     |   1   | true  |   -   |     -    |     -   |
    |  3  |  MDIO  |    1     |   1   | false | RGMII |1000BaseT1|   1000  |
    |  3  |  MDIO  |    1     |   1   | false | RGMII | 100BaseT1|   100   |
    |  5  |  MDIO  |    1     |   1   | false | RGMII |1000BaseT1|   1000  |
    |  5  |  MDIO  |    1     |   1   | false | RGMII | 100BaseT1|   100   |
    |  5  |    -   |    -     |   -   | false | SGMII |    -     |1000/2500|
    |  6  |  MDIO  |    0     |   1   | false | RGMII |1000BaseT1|   1000  |
    |  6  |  MDIO  |    0     |   1   | false | RGMII | 100BaseT1|   100   |
    |  6  |    -   |    -     |   -   | false | SGMII |    -     |2500/5000|
    |  6  |    -   |    -     |   -   | true  | SGMII |    -     |   1000  |
    |  8  |    -   |    -     |   -   | false | SGMII |    -     |2500/5000|
    |  8  |    -   |    -     |   -   | true  | SGMII |    -     |   1000  |
    |  8  |  MDIO  |    0x18  |   1   | false | RGMII |    -     |   1000  |
*/
int32_t ETHXCVR_BoardValidatePhyConfig(const ETHXCVR_PortConfigType *const aConfig)
{
    int32_t retVal;

    switch (aConfig->id) {
    case 1U:
#ifdef ENABLE_ETH_DENALIPHY
        if ((ETHXCVR_ACCESSMODE_MDIO == aConfig->phy.accessMode) &&
            (1U == aConfig->phy.hwID) &&
            (2U == aConfig->phy.slaveID) &&
            (ETHXCVR_BOOLEAN_TRUE == aConfig->autoNeg)) {
            retVal = BCM_ERR_OK;
        } else {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
#else
        retVal = BCM_ERR_OK;
#endif
        break;
    case 3U:
#ifdef ENABLE_ETH_DENALIPHY
        if ((ETHXCVR_ACCESSMODE_MDIO == aConfig->phy.accessMode) &&
            (1U == aConfig->phy.hwID) &&
            (1U == aConfig->phy.slaveID) &&
            (ETHXCVR_BOOLEAN_FALSE == aConfig->autoNeg) &&
            (((ETHXCVR_PHYMEDIA_1000BASET1 == aConfig->phy.phyMedia) && (ETHXCVR_SPEED_1000MBPS == aConfig->speed)) ||
             ((ETHXCVR_PHYMEDIA_100BASET1 == aConfig->phy.phyMedia) && (ETHXCVR_SPEED_100MBPS == aConfig->speed)))) {
            retVal = BCM_ERR_OK;
        } else {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
#else
        retVal = BCM_ERR_OK;
#endif
        break;
    case 5U:
        if ((ETHXCVR_BUSMODE_SGMII == aConfig->busMode) &&
                   ((ETHXCVR_SPEED_1000MBPS == aConfig->speed) ||
                    (ETHXCVR_SPEED_2500MBPS == aConfig->speed)) &&
                   (ETHXCVR_BOOLEAN_FALSE == aConfig->autoNeg)) {
            retVal = BCM_ERR_OK;
        } else
#ifdef ENABLE_ETH_DENALIPHY
        if ((ETHXCVR_BUSMODE_RGMII == aConfig->busMode) &&
            (ETHXCVR_ACCESSMODE_MDIO == aConfig->phy.accessMode) &&
            (1U == aConfig->phy.hwID) &&
            (1U == aConfig->phy.slaveID) &&
            (ETHXCVR_BOOLEAN_FALSE == aConfig->autoNeg) &&
            (((ETHXCVR_PHYMEDIA_1000BASET1 == aConfig->phy.phyMedia) && (ETHXCVR_SPEED_1000MBPS == aConfig->speed)) ||
             ((ETHXCVR_PHYMEDIA_100BASET1 == aConfig->phy.phyMedia) && (ETHXCVR_SPEED_100MBPS == aConfig->speed)))) {
            retVal = BCM_ERR_OK;
        } else {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
#else
        retVal = BCM_ERR_OK;
#endif
        break;
    case 6U:
        if (ETHXCVR_BUSMODE_SGMII == aConfig->busMode) {
            if (((ETHXCVR_SPEED_2500MBPS == aConfig->speed) ||
                  (ETHXCVR_SPEED_5000MBPS == aConfig->speed)) &&
                   (ETHXCVR_BOOLEAN_FALSE == aConfig->autoNeg)) {
            retVal = BCM_ERR_OK;
        	}
            else if (ETHXCVR_SPEED_1000MBPS == aConfig->speed) {
                retVal = BCM_ERR_OK;
            } 
			else 
			{
                retVal = BCM_ERR_INVAL_PARAMS;
            }
        } else
#ifdef ENABLE_ETH_DENALIPHY 
        if ((ETHXCVR_BUSMODE_RGMII == aConfig->busMode) &&
            (ETHXCVR_ACCESSMODE_MDIO == aConfig->phy.accessMode) &&
            (1U == aConfig->phy.hwID) &&
            (24U == aConfig->phy.slaveID) &&
            (ETHXCVR_BOOLEAN_FALSE == aConfig->autoNeg) &&
            (((ETHXCVR_PHYMEDIA_1000BASET1 == aConfig->phy.phyMedia) && (ETHXCVR_SPEED_1000MBPS == aConfig->speed)) ||
             ((ETHXCVR_PHYMEDIA_100BASET1 == aConfig->phy.phyMedia) && (ETHXCVR_SPEED_100MBPS == aConfig->speed)))) {
            retVal = BCM_ERR_OK;
        } else {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
#else
        retVal = BCM_ERR_OK;
#endif
        break;
    case 8U:
        if (ETHXCVR_BUSMODE_SGMII == aConfig->busMode) {
            if (((ETHXCVR_SPEED_2500MBPS == aConfig->speed) ||
                  (ETHXCVR_SPEED_5000MBPS == aConfig->speed)) &&
                  (ETHXCVR_BOOLEAN_FALSE == aConfig->autoNeg)) {
                retVal = BCM_ERR_OK;
            }
            else if (ETHXCVR_SPEED_1000MBPS == aConfig->speed) {
                retVal = BCM_ERR_OK;
            } 
			else 
			{
                retVal = BCM_ERR_INVAL_PARAMS;
            }
        } else
#ifdef ENABLE_ETH_DENALIPHY        /* --2022.05-17-paul RGMII interface for P8*/
        if ((ETHXCVR_BUSMODE_RGMII == aConfig->busMode) &&
            (ETHXCVR_ACCESSMODE_MDIO == aConfig->phy.accessMode) &&
            (1U == aConfig->phy.hwID) &&
            (0U == aConfig->phy.slaveID) &&
            (ETHXCVR_BOOLEAN_FALSE == aConfig->autoNeg) &&
            (((ETHXCVR_PHYMEDIA_1000BASET1 == aConfig->phy.phyMedia) && (ETHXCVR_SPEED_1000MBPS == aConfig->speed)) ||
             ((ETHXCVR_PHYMEDIA_100BASET1 == aConfig->phy.phyMedia) && (ETHXCVR_SPEED_100MBPS == aConfig->speed)))) {
            retVal = BCM_ERR_OK;
        } else {
            retVal = BCM_ERR_INVAL_PARAMS;
        }

#else
		retVal = BCM_ERR_OK;
#endif
        break;

		
    default:
        retVal = BCM_ERR_INVAL_PARAMS;
        break;
    }
    return retVal;
}

/** @} */
