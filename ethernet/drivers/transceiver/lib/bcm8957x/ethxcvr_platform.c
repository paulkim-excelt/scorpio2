/*****************************************************************************
 Copyright 2021-2022 Broadcom Limited.  All rights reserved.

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
    @addtogroup grp_eth_xcvrdrv_plat_impl
    @{

    @file ethxcvr_platform.c
    @brief This file implements the platform layer for Ethernet Transceiver driver.

    @version 0.1 Initial draft
*/

#include "ethxcvr_platform.h"
#include "ethxcvr_board.h"
#include "brphy_osil.h"
#include "sgmii_osil.h"
#include "rgmii_osil.h"
#include "dummyphy_osil.h"
#include "denaliphy_osil.h"
#include "pcie_osil.h"
#include "brphy1g_v2_osil.h"
#include "sgmiiplusr_osil.h"
#include <io_rdb.h>
#include <mdio_osil.h>
#include "ethxcvr_drv.h"
#include <mcu_clk.h>
#include <mcu_switch_ext.h>

/**
    @name Transceiver driver platform Design IDs
    @{
    @brief Design IDs for Transceiver driver platform layer
*/
#define BRCM_SWDSGN_ETHXCVR_CNTXT_GLOBAL                           (0xC401U) /**< @brief #ETHXCVR_Cntxt */
#define BRCM_SWDSGN_ETHXCVR_CONTROLLERMAP_GLOBAL                   (0xC402U) /**< @brief #ETHXCVR_ControllerMap */
#define BRCM_SWDSGN_ETHXCVR_IORDBREG_GLOBAL                        (0xC403U) /**< @brief #ETHXCVR_IO_RDB_REG */
#define BRCM_SWDSGN_ETHXCVR_HWID_TYPE                              (0xC404U) /**< @brief #ETHXCVR_HwIDType */
#define BRCM_SWDSGN_ETHXCVR_PLATFORMGETFNTBLSCNTXT_PROC            (0xC405U) /**< @brief #ETHXCVR_PlatformGetFnTblsCntxt */
#define BRCM_SWDSGN_ETHXCVR_PLATFORMMUXCONFIG_PROC                 (0xC406U) /**< @brief #ETHXCVR_PlatformMuxConfigure */
#define BRCM_SWDSGN_ETHXCVR_PLATFORMVALIDATECONFIG_PROC            (0xC407U) /**< @brief #ETHXCVR_PlatformValidateConfig */
#define BRCM_SWDSGN_ETHXCVR_PLATFORMCONFIGRGMII1_PROC              (0xC408U) /**< @brief #ETHXCVR_PlatformConfigRGMII1 */
#define BRCM_SWDSGN_ETHXCVR_PLATFORMCONFIGRGMII2_PROC              (0xC409U) /**< @brief #ETHXCVR_PlatformConfigRGMII2 */
#define BRCM_SWDSGN_ETHXCVR_PLATFORMCONFIGRGMII3_PROC              (0xC40AU) /**< @brief #ETHXCVR_PlatformConfigRGMII3 */
#define BRCM_SWDSGN_ETHXCVR_PLATFORMWAITMDIOJOBCOMPLETION_PROC     (0xC40BU) /**< @brief #ETHXCVR_PlatformWaitMDIOJobCompletion */
#define BRCM_SWDSGN_ETHXCVR_PLATFORMREMOVEDENALISUPERISOLATE_PROC  (0xC40CU) /**< @brief #ETHXCVR_PlatformRemoveDenaliSuperIsolate */
#define BRCM_SWDSGN_ETHXCVR_DENALI_TYPE                            (0xC40DU) /**< @brief #ETHXCVR_DenaliType */
#define BRCM_SWDSGN_ETHXCVR_PLATFORMCONFIGSGMIIPLUSR_PROC          (0xC40EU) /**< @brief #ETHXCVR_PlatformConfigSGMIIPLUSR */
/** @} */

/**
    @trace #BRCM_SWARCH_ETHXCVR_PLATFORMMUXCONFIG_PROC
    @trace #BRCM_SWREQ_ETHXCVR_KERNEL_HANDLER_BCM8957X
*/
static IO_RDBType *const ETHXCVR_IO_RDB_REG = (IO_RDBType *)IO_BASE;

/**
    @name ETHXCVR_HwIDType
    @{
    @brief H/W Controller IDs

    @trace #BRCM_SWARCH_ETHXCVR_PLATFORMVALIDATECONFIG_PROC
    @trace #BRCM_SWREQ_ETHXCVR_KERNEL_HANDLER_BCM8957X
*/
typedef uint32_t ETHXCVR_HwIDType;
#define ETHXCVR_HWID_BRPHY1GV2          (0U) /**< @brief Controller for port 0 BRPHY-1G */
#define ETHXCVR_HWID_BRPHY1             (1U) /**< @brief Controller for port 1 BRPHY */
#define ETHXCVR_HWID_SGMIIPLUS2_LANE0   (0U) /**< @brief Controller for port 0 SGMII */
#define ETHXCVR_HWID_BRPHY2             (2U) /**< @brief Controller for port 2 BRPHY */
#define ETHXCVR_HWID_BRPHY3             (3U) /**< @brief Controller for port 3 BRPHY */
#define ETHXCVR_HWID_RGMII1             (0U) /**< @brief Controller for port 3/5 RGMII */
#define ETHXCVR_HWID_BRPHY4             (4U) /**< @brief Controller for port 4 BRPHY */
#define ETHXCVR_HWID_BRPHY5             (0U) /**< @brief Controller for port 5 BRPHY */
#define ETHXCVR_HWID_SGMIIPLUS2_LANE1   (1U) /**< @brief Controller for port 5 SGMII */
#define ETHXCVR_HWID_SGMIIPCIE          (2U) /**< @brief Controller for port 6/8 SGMII */
#define ETHXCVR_HWID_SGMIIPLUSR         (0U) /**< @brief Controller for port 6/8 SGMII (5G) */
#define ETHXCVR_HWID_RGMII2             (0U) /**< @brief Controller for port 6 RGMII */
#define ETHXCVR_HWID_RGMII3             (0U) /**< @brief Controller for port 8 RGMII */
#define ETHXCVR_HWID_PCIE               (0U) /**< @brief Controller for port 6/8 PCIe */
/** @} */

/**
    @name ETHXCVR_DenaliType
    @{
    @brief Denali related definitions

    @trace #BRCM_SWARCH_ETHXCVR_PLATFORMMUXCONFIG_PROC
    @trace #BRCM_SWREQ_ETHXCVR_KERNEL_HANDLER_BCM8957X
*/
typedef uint32_t ETHXCVR_DenaliType;
#define ETHXCVR_DENALI_MDIO_MAX_TRIES                   (1000U)   /**< @brief Number of iterations
                                                                       waiting for MDIO job completion */
#define ETHXCVR_DENALI_POWERMII_CTRL_SUPER_ISOLATE_MASK (0x20U)   /**< @brief Super isolate field mask
                                                                       in Power/MII control register */
#define ETHXCVR_DENALI_DEVICEID_1                       (0x1U)    /**< @brief Denali Device 1 */
#define ETHXCVR_DENALI_POWERMII_CTRL_REG                (0x932AU) /**< @brief Denali Power/MII control
                                                                       register address */
/** @} */

/**
    | SW Cntrl ID |  BusMode  | HW Cntrl ID |  Port   | Shared Port |
    |------------:|:---------:|:-----------:|:-------:|:-----------:|
    |      0      | Integrated|      0      |    0    |      -      |
    |      1      | Integrated|      1      |    1    |      -      |
    |      2      |   SGMII   |      0      |    1    |      -      |
    |      3      | Integrated|      2      |    2    |      -      |
    |      4      | Integrated|      3      |    3    |      -      |
    |      5      |   RGMII   |      0      |    3    |      5      |
    |      6      | Integrated|      4      |    4    |      -      |
    |      7      |   SGMII   |      1      |    5    |      -      |
    |      8      | Integrated|      0      |    5    |      -      |
    |      9      |   SGMII   |      2      |    6    |      8      |
    |     10      |   RGMII   |      0      |    6    |      -      |
    |     11      |    PCIe   |      0      |    6    |      8      |
    |     12      |   SGMII   |      3      |    6    |      8      |
    |     13      |   RGMII   |      0      |    8    |      -      |

    @trace #BRCM_SWARCH_ETHXCVR_CONTROLLERMAP_GLOBAL
    @trace #BRCM_SWREQ_ETHXCVR_KERNEL_HANDLER_BCM8957X

*/
/*
ETHXCVR_MAX_CONTROLLERS == 18UL 
BRCM_COMP_LIB_CFLAGS += -DETHXCVR_MAX_CONTROLLERS=18UL
This is the "map" of all possible port combinations/configurations
on the orion switch. 
The port field value is the same multiple elements in this array, 
but the busMode is unique to the board config.
*/
const ETHXCVR_PlatformControllerMapType ETHXCVR_ControllerMap[ETHXCVR_MAX_CONTROLLERS] =
{
    /* P0 - BRPHY 1G */
    {
        .port            = 0U,
        .busMode         = ETHXCVR_BUSMODE_INTG,
        .hwControllerID  = 0U,
        .swControllerID  = 0U
    },
    /* P1 - BRPHY */
    {
        .port            = 1U,
        .busMode         = ETHXCVR_BUSMODE_INTG,
        .hwControllerID  = 0U,
        .swControllerID  = 1U
    },
    /* P1 - SGMII PLUS2 */
    {
        .port            = 1U,
        .busMode         = ETHXCVR_BUSMODE_SGMII,
        .hwControllerID  = ETHXCVR_HWID_SGMIIPLUS2_LANE0,
        .swControllerID  = 2U
    },
    /* P2 - BRPHY */
    {
        .port            = 2U,
        .busMode         = ETHXCVR_BUSMODE_INTG,
        .hwControllerID  = 0U,
        .swControllerID  = 3U
    },
    /* P3 - BRPHY */
    {
        .port            = 3U,
        .busMode         = ETHXCVR_BUSMODE_INTG,
        .hwControllerID  = 0U,
        .swControllerID  = 4U
    },
    /* P3 - RGMII1 - Shared with P5 */
    {
        .port            = 3U,
        .busMode         = ETHXCVR_BUSMODE_RGMII,
        .hwControllerID  = ETHXCVR_HWID_RGMII1,
        .swControllerID  = 5U
    },
    /* P5 - RGMII1 - Shared with P3 */
    {
        .port            = 5U,
        .busMode         = ETHXCVR_BUSMODE_RGMII,
        .hwControllerID  = ETHXCVR_HWID_RGMII1,
        .swControllerID  = 5U
    },
    /* P4 - BRPHY */
    {
        .port            = 4U,
        .busMode         = ETHXCVR_BUSMODE_INTG,
        .hwControllerID  = 0U,
        .swControllerID  = 6U
    },
    /* P5 - SGMII PLUS2 */
    {
        .port            = 5U,
        .busMode         = ETHXCVR_BUSMODE_SGMII,
        .hwControllerID  = ETHXCVR_HWID_SGMIIPLUS2_LANE1,
        .swControllerID  = 7U
    },
    /* P5 - BRPHY */
    {
        .port            = 5U,
        .busMode         = ETHXCVR_BUSMODE_INTG,
        .hwControllerID  = 0U,
        .swControllerID  = 8U
    },
    /* P6 - SGMII PLUSR  - Shared with P8 */
    {
        .port            = 6U,
        .busMode         = ETHXCVR_BUSMODE_SGMII,
        .hwControllerID  = ETHXCVR_HWID_SGMIIPLUSR,
        .swControllerID  = 9U
    },
    /* P8 - SGMII PLUSR  - Shared with P6 */
    {
        .port            = 8U,
        .busMode         = ETHXCVR_BUSMODE_SGMII,
        .hwControllerID  = ETHXCVR_HWID_SGMIIPLUSR,
        .swControllerID  = 9U
    },
    /* P6 - RGMII2 */
    {
        .port            = 6U,
        .busMode         = ETHXCVR_BUSMODE_RGMII,
        .hwControllerID  = ETHXCVR_HWID_RGMII2,
        .swControllerID  = 10U
    },
    /* P6 - PCIe - Shared with P8 */
    {
        .port            = 6U,
        .busMode         = ETHXCVR_BUSMODE_PCIE,
        .hwControllerID  = ETHXCVR_HWID_PCIE,
        .swControllerID  = 11U
    },
    /* P8 - PCIe - Shared with P6 */
    {
        .port            = 8U,
        .busMode         = ETHXCVR_BUSMODE_PCIE,
        .hwControllerID  = ETHXCVR_HWID_PCIE,
        .swControllerID  = 11U
    },
    /* P6 - SGMII PCIe - Shared with P8 */
    {
        .port            = 6U,
        .busMode         = ETHXCVR_BUSMODE_SGMII,
        .hwControllerID  = ETHXCVR_HWID_SGMIIPCIE,
        .swControllerID  = 11U
    },
    /* P8 - SGMII PCIe - Shared with P6 */
    {
        .port            = 8U,
        .busMode         = ETHXCVR_BUSMODE_SGMII,
        .hwControllerID  = ETHXCVR_HWID_SGMIIPCIE,
        .swControllerID  = 11U
    },
    /* P8 - RGMII3 */
    {
        .port            = 8U,
        .busMode         = ETHXCVR_BUSMODE_RGMII,
        .hwControllerID  = ETHXCVR_HWID_RGMII3,
        .swControllerID  = 12U
    },
};

/**
    | Port |  Bus Mode  | Bus Table |     PHY Table   |
    |-----:|:----------:|:---------:|:---------------:|
    |  0   | Integrated |   NULL    |     BRPHY1GV2   |
    |  1   |    SGMII   |   SGMII   | Board dependent |
    |  1   | Integrated |   NULL    |      BRPHY      |
    |  2   | Integrated |   NULL    |      BRPHY      |
    |  3   | Integrated |   NULL    |      BRPHY      |
    |  3   |    RGMII   |   RGMII   | Board dependent |
    |  4   | Integrated |   NULL    |      BRPHY      |
    |  5   |    RGMII   |   RGMII   | Board dependent |
    |  5   |    SGMII   |   SGMII   | Board dependent |
    |  5   | Integrated |   NULL    |      BRPHY      |
    |  6   |    SGMII   |   DUMMY   | Board dependent |
    |  6   |    RGMII   |   RGMII   | Board dependent |
    |  6   |    PCIe    |   PCIE    |      NULL       |
    |  8   |    SGMII   |   DUMMY   | Board dependent |
    |  8   |    RGMII   |   RGMII   | Board dependent |
    |  8   |    PCIe    |   PCIE    |      NULL       |

    @trace #BRCM_SWARCH_ETHXCVR_PLATFORMGETFNTBLSCNTXT_PROC
    @trace #BRCM_SWREQ_ETHXCVR_KERNEL_HANDLER_BCM8957X

*/
int32_t ETHXCVR_PlatformGetFnTblsCntxt(const ETHXCVR_PortConfigType *const aConfig,
                                const ETHXCVR_FuncTblType **const aBusFnTbl,
                                const ETHXCVR_FuncTblType **const aPhyFnTbl,
                                ETHXCVR_CntxtType **const aPhyCntxt)
{
    int32_t retVal = BCM_ERR_NOSUPPORT;

    *aPhyFnTbl = NULL;
    *aPhyCntxt = NULL;
    *aBusFnTbl = NULL;

    switch (aConfig->id) {
        case 0U:
#ifdef ENABLE_ETH_BRPHY1G_V2
            /* P0 - BRPHY 1G */
            *aPhyFnTbl = &BRPHY1GV2_FuncTbl;
            retVal = BCM_ERR_OK;
#endif
            break;
        case 1U:
            if (aConfig->busMode == ETHXCVR_BUSMODE_SGMII) {
#ifdef ENABLE_ETH_SGMII
                /* P1 - SGMII PLUS2 */
                *aBusFnTbl = &SGMII_FuncTbl;
                retVal = ETHXCVR_BoardGetPhyFnTbl(aConfig, aPhyFnTbl, aPhyCntxt);
#endif
            } else {
#ifdef ENABLE_ETH_BRPHY
                /* P1 - BRPHY */
                *aPhyFnTbl = &BRPHY_FuncTbl;
                retVal = BCM_ERR_OK;
#endif
            }
            break;
        case 3U:
            if (aConfig->busMode == ETHXCVR_BUSMODE_RGMII) {
                /* P3 - RGMII1 - Shared with P5 */
                *aBusFnTbl = &RGMII_FuncTbl;
                retVal = ETHXCVR_BoardGetPhyFnTbl(aConfig, aPhyFnTbl, aPhyCntxt);
            } else {
#ifdef ENABLE_ETH_BRPHY
                /* P3 - BRPHY */
                *aPhyFnTbl = &BRPHY_FuncTbl;
                retVal = BCM_ERR_OK;
#endif
            }
            break;
        case 2U:
            /* Fall through intentional */
        case 4U:
#ifdef ENABLE_ETH_BRPHY
            /* P2/4 - BRPHY */
            *aPhyFnTbl = &BRPHY_FuncTbl;
            retVal = BCM_ERR_OK;
#endif
            break;
        case 5U:
            if (aConfig->busMode == ETHXCVR_BUSMODE_SGMII) {
#ifdef ENABLE_ETH_SGMII
                /* P5 - SGMII PLUS2 */
                *aBusFnTbl = &SGMII_FuncTbl;
                retVal = ETHXCVR_BoardGetPhyFnTbl(aConfig, aPhyFnTbl, aPhyCntxt);
#endif
            } else if (aConfig->busMode == ETHXCVR_BUSMODE_RGMII) {
                /* P5 - RGMII1 - Shared with P3 */
                *aBusFnTbl = &RGMII_FuncTbl;
                retVal = ETHXCVR_BoardGetPhyFnTbl(aConfig, aPhyFnTbl, aPhyCntxt);
            } else {
#ifdef ENABLE_ETH_BRPHY
                /* P5 - BRPHY */
                *aPhyFnTbl = &BRPHY_FuncTbl;
                retVal = BCM_ERR_OK;
#endif
            }
            break;
        case 6U:
            if (aConfig->busMode == ETHXCVR_BUSMODE_SGMII) {
                if (aConfig->bus.cntrlID == ETHXCVR_HWID_SGMIIPLUSR) {
                    /* P6 - SGMII PLUSR  - Shared with P8 */
#ifdef ENABLE_ETH_SGMIIPLUSR
                    *aBusFnTbl = &SGMIIPLUSR_FuncTbl;
#else
                    *aBusFnTbl = &DUMMYPHY_FuncTbl;
#endif
                } else {
                    /* P6 - SGMII PCIe - Shared with P8 */
                    *aBusFnTbl = &SGMII_FuncTbl;
                }
                retVal = ETHXCVR_BoardGetPhyFnTbl(aConfig, aPhyFnTbl, aPhyCntxt);
            } else if (aConfig->busMode == ETHXCVR_BUSMODE_PCIE) {
#ifdef ENABLE_PCIE
                /* P6 - PCIe - Shared with P8 */
                *aBusFnTbl = &PCIE_FuncTbl;
                retVal = BCM_ERR_OK;
#endif
            } else {
                /* P6 - RGMII2 */
                *aBusFnTbl = &RGMII_FuncTbl;
                retVal = ETHXCVR_BoardGetPhyFnTbl(aConfig, aPhyFnTbl, aPhyCntxt);
            }
            break;
        case 8U:
            if (aConfig->busMode == ETHXCVR_BUSMODE_SGMII) {
                if (aConfig->bus.cntrlID == ETHXCVR_HWID_SGMIIPLUSR) {
                    /* P8 - SGMII PLUSR  - Shared with P6 */
#ifdef ENABLE_ETH_SGMIIPLUSR
                    *aBusFnTbl = &SGMIIPLUSR_FuncTbl;
#else
                    *aBusFnTbl = &DummyPHY_FuncTbl;
#endif
                } else {
                    /* P8 - SGMII PCIe - Shared with P6 */
                    *aBusFnTbl = &SGMII_FuncTbl;
                }
                retVal = ETHXCVR_BoardGetPhyFnTbl(aConfig, aPhyFnTbl, aPhyCntxt);
            } else if (aConfig->busMode == ETHXCVR_BUSMODE_PCIE) {
#ifdef ENABLE_PCIE
                /* P6 - PCIe - Shared with P8 */
                *aBusFnTbl = &PCIE_FuncTbl;
                retVal = BCM_ERR_OK;
#endif
            } else {
                /* P8 - RGMII3 */
                *aBusFnTbl = &RGMII_FuncTbl;
                retVal = ETHXCVR_BoardGetPhyFnTbl(aConfig, aPhyFnTbl, aPhyCntxt);
            }
            break;
        default:
            retVal = BCM_ERR_INVAL_PARAMS;
            break;
    }

    return retVal;
}

/**
    The following table provides the superset of all  valid configurations. For the actual
    supported configurations, please refer to the Release Notes for the SDK release.

    |port|busMode|busCtlID|phyHwID|phyAccess|autoneg| phyMedia |   speed |jumbo|flowcontrol|
    |:--:|:-----:|:------:|:-----:|:-------:|:-----:|:--------:|:-------:|:---:|:---------:|
    |  0 | INTG  |   -    |   0   |  MMAP   | false | 100BaseT1|   100   |false|    none   |
    |  0 | INTG  |   -    |   0   |  MMAP   | false |1000BaseT1|   1000  |false|    none   |
    |  0 | INTG  |   -    |   0   |  MMAP   |  true |    -     |    -    |false|    none   |
    |  1 | SGMII |   0    |   -   |    -    |   -   |    -     |    -    |false|    none   |
    |  1 | INTG  |   -    |   1   |  MMAP   |   -   | 100BaseT1|   100   |false|    none   |
    |  2 | INTG  |   -    |   2   |  MMAP   |   -   | 100BaseT1|   100   |false|    none   |
    |  3 | INTG  |   -    |   3   |  MMAP   |   -   | 100BaseT1|   100   |false|    none   |
    |  3 | RGMII |   0    |   -   |    -    |   -   |    -     |    -    |false|    none   |
    |  4 | INTG  |   -    |   4   |  MMAP   |   -   | 100BaseT1|   100   |false|    none   |
    |  4 | INTG  |   -    |   4   |  MMAP   |  true | 100BaseTx|   100   |false|    none   |
    |  5 | INTG  |   -    |   0   |  MMAP   |   -   | 100BaseT1|   100   |false|    none   |
    |  5 | SGMII |   1    |   -   |    -    |   -   |    -     |    -    |false|    none   |
    |  5 | RGMII |   0    |   -   |    -    |   -   |    -     |    -    |false|    none   |
    |  6 | SGMII |   2    |   -   |    -    |   -   |    -     |1000-5000|false|    none   |
    |  6 | SGMII |   3    |   -   |    -    |   -   |    -     |1000-2500|false|    none   |
    |  6 | PCIE  |   0    |   -   |    -    | false |    -     |   5000  |false|    none   |
    |  6 | RGMII |   0    |   -   |    -    |   -   |          |    -    |false|    none   |
    |  8 | SGMII |   2    |   -   |    -    |   -   |    -     |1000-5000|false|    none   |
    |  8 | SGMII |   3    |   -   |    -    |   -   |    -     |1000-2500|false|    none   |
    |  8 | PCIE  |   0    |   -   |    -    | false |    -     |   5000  |false|    none   |
    |  8 | RGMII |   0    |   -   |    -    |   -   |          |    -    |false|    none   |

    @trace #BRCM_SWARCH_ETHXCVR_PLATFORMVALIDATECONFIG_PROC
    @trace #BRCM_SWREQ_ETHXCVR_KERNEL_HANDLER_BCM8957X

*/
int32_t ETHXCVR_PlatformValidateConfig(const ETHXCVR_PortConfigType *const aConfig)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    switch (aConfig->id) {
        case 0U:
            /* P0 - BRPHY 1G */
            /* Possible modes: AN enabled/Forced 100/Forced 1000 */
            if ((aConfig->busMode == ETHXCVR_BUSMODE_INTG) &&
                (aConfig->phy.hwID == ETHXCVR_HWID_BRPHY1GV2) &&
                (aConfig->phy.accessMode == ETHXCVR_ACCESSMODE_MMAP) &&
                (((ETHXCVR_BOOLEAN_FALSE == aConfig->autoNeg) &&
                  (((aConfig->phy.phyMedia == ETHXCVR_PHYMEDIA_1000BASET1) && (aConfig->speed == ETHXCVR_SPEED_1000MBPS)) ||
                   ((aConfig->phy.phyMedia == ETHXCVR_PHYMEDIA_100BASET1) && (aConfig->speed == ETHXCVR_SPEED_100MBPS)))) ||
                 (ETHXCVR_BOOLEAN_TRUE == aConfig->autoNeg))) {
                retVal = BCM_ERR_OK;
            }
            break;
        case 1U:
            if ((aConfig->busMode == ETHXCVR_BUSMODE_SGMII) &&
                (aConfig->bus.cntrlID == ETHXCVR_HWID_SGMIIPLUS2_LANE0)) {
                /* P1 - SGMII PLUS2 */
                retVal = ETHXCVR_BoardValidatePhyConfig(aConfig);
            } else if ((aConfig->busMode == ETHXCVR_BUSMODE_INTG) &&
                       (aConfig->phy.hwID == ETHXCVR_HWID_BRPHY1) &&
                       (aConfig->phy.accessMode == ETHXCVR_ACCESSMODE_MMAP) &&
                       (aConfig->phy.phyMedia == ETHXCVR_PHYMEDIA_100BASET1) &&
                       (aConfig->speed == ETHXCVR_SPEED_100MBPS)) {
                /* P1 - BRPHY */
                retVal = BCM_ERR_OK;
            } else {
                retVal = BCM_ERR_INVAL_PARAMS;
            }
            break;
        case 2U:
            if ((aConfig->busMode == ETHXCVR_BUSMODE_INTG) &&
                (aConfig->phy.hwID == ETHXCVR_HWID_BRPHY2) &&
                (aConfig->phy.accessMode == ETHXCVR_ACCESSMODE_MMAP) &&
                (aConfig->phy.phyMedia == ETHXCVR_PHYMEDIA_100BASET1) &&
                (aConfig->speed == ETHXCVR_SPEED_100MBPS)) {
                /* P2 - BRPHY */
                retVal = BCM_ERR_OK;
            }
            break;
        case 3U:
            if ((aConfig->busMode == ETHXCVR_BUSMODE_RGMII) &&
                (aConfig->bus.cntrlID == ETHXCVR_HWID_RGMII1)) {
                /* P3 - RGMII1 - Shared with P5 */
                retVal = ETHXCVR_BoardValidatePhyConfig(aConfig);
            } else if ((aConfig->busMode == ETHXCVR_BUSMODE_INTG) &&
                       (aConfig->phy.hwID == ETHXCVR_HWID_BRPHY3) &&
                       (aConfig->phy.accessMode == ETHXCVR_ACCESSMODE_MMAP) &&
                       (aConfig->phy.phyMedia == ETHXCVR_PHYMEDIA_100BASET1) &&
                       (aConfig->speed == ETHXCVR_SPEED_100MBPS)) {
                /* P3 - BRPHY */
                retVal = BCM_ERR_OK;
            } else {
                retVal = BCM_ERR_INVAL_PARAMS;
            }
            break;
        case 4U:
            if ((aConfig->busMode == ETHXCVR_BUSMODE_INTG) &&
                (aConfig->phy.hwID == ETHXCVR_HWID_BRPHY4) &&
                (aConfig->phy.accessMode == ETHXCVR_ACCESSMODE_MMAP) &&
                ((aConfig->phy.phyMedia == ETHXCVR_PHYMEDIA_100BASET1)  ||
                 ((aConfig->phy.phyMedia == ETHXCVR_PHYMEDIA_100BASETX) && (aConfig->autoNeg == ETHXCVR_BOOLEAN_TRUE))) &&
                (aConfig->speed == ETHXCVR_SPEED_100MBPS)) {
                /* P4 - BRPHY */
                retVal = BCM_ERR_OK;
            }
            break;
        case 5U:
            if ((aConfig->busMode == ETHXCVR_BUSMODE_SGMII) &&
                (aConfig->bus.cntrlID == ETHXCVR_HWID_SGMIIPLUS2_LANE1)) {
                /* P5 - SGMII PLUS2 */
                retVal = ETHXCVR_BoardValidatePhyConfig(aConfig);
            } else if ((aConfig->busMode == ETHXCVR_BUSMODE_RGMII) &&
                       (aConfig->bus.cntrlID == ETHXCVR_HWID_RGMII1)) {
                /* P5 - RGMII1 - Shared with P3 */
                retVal = ETHXCVR_BoardValidatePhyConfig(aConfig);
            } else if ((aConfig->busMode == ETHXCVR_BUSMODE_INTG) &&
                       (aConfig->phy.hwID == ETHXCVR_HWID_BRPHY5) &&
                       (aConfig->phy.accessMode == ETHXCVR_ACCESSMODE_MMAP) &&
                       (aConfig->phy.phyMedia == ETHXCVR_PHYMEDIA_100BASET1) &&
                       (aConfig->speed == ETHXCVR_SPEED_100MBPS)) {
                /* P5 - BRPHY */
                retVal = BCM_ERR_OK;
            } else {
                retVal = BCM_ERR_INVAL_PARAMS;
            }
            break;
        case 6U:
            if ((aConfig->busMode == ETHXCVR_BUSMODE_SGMII) &&
                 (aConfig->speed >= ETHXCVR_SPEED_1000MBPS) &&
                 (((aConfig->bus.cntrlID == ETHXCVR_HWID_SGMIIPLUSR) && (aConfig->speed <= ETHXCVR_SPEED_5000MBPS)) ||
                  ((aConfig->bus.cntrlID == ETHXCVR_HWID_SGMIIPCIE) && (aConfig->speed <= ETHXCVR_SPEED_2500MBPS)))) {
                /* P6 - SGMII PLUSR or SGMII PCIE - Shared with P8 */
                retVal = ETHXCVR_BoardValidatePhyConfig(aConfig);
            } else if ((aConfig->busMode == ETHXCVR_BUSMODE_PCIE) &&
                       (aConfig->bus.cntrlID == ETHXCVR_HWID_PCIE) &&
                       (aConfig->autoNeg == ETHXCVR_BOOLEAN_FALSE) &&
                       (aConfig->speed == ETHXCVR_SPEED_5000MBPS)) {
                /* P6 - PCIe */
                retVal = BCM_ERR_OK;
            } else if ((aConfig->busMode == ETHXCVR_BUSMODE_RGMII) &&
                       (aConfig->bus.cntrlID == ETHXCVR_HWID_RGMII2)) {
                /* P6 - RGMII2 */
                retVal = ETHXCVR_BoardValidatePhyConfig(aConfig);
            } else {
                retVal = BCM_ERR_INVAL_PARAMS;
            }
            break;
        case 8U:
            if ((aConfig->busMode == ETHXCVR_BUSMODE_SGMII) &&
                 (aConfig->speed >= ETHXCVR_SPEED_1000MBPS) &&
                 (((aConfig->bus.cntrlID == ETHXCVR_HWID_SGMIIPLUSR) && (aConfig->speed <= ETHXCVR_SPEED_5000MBPS)) ||
                  ((aConfig->bus.cntrlID == ETHXCVR_HWID_SGMIIPCIE) && (aConfig->speed <= ETHXCVR_SPEED_2500MBPS)))) {
                /* P8 - SGMII PLUSR or SGMII PCIE - Shared with P6 */
                retVal = ETHXCVR_BoardValidatePhyConfig(aConfig);
            } else if ((aConfig->busMode == ETHXCVR_BUSMODE_PCIE) &&
                       (aConfig->bus.cntrlID == ETHXCVR_HWID_PCIE) &&
                       (aConfig->autoNeg == ETHXCVR_BOOLEAN_FALSE) &&
                       (aConfig->speed == ETHXCVR_SPEED_5000MBPS)) {
                /* P8 - PCIe */
                retVal = BCM_ERR_OK;
            } else if ((aConfig->busMode == ETHXCVR_BUSMODE_RGMII) &&
                       (aConfig->bus.cntrlID == ETHXCVR_HWID_RGMII3)) {
                /* P8 - RGMII3 */
                retVal = ETHXCVR_BoardValidatePhyConfig(aConfig);
            } else {
                retVal = BCM_ERR_INVAL_PARAMS;
            }
            break;
        default:
            retVal = BCM_ERR_INVAL_PARAMS;
            break;
    }

    if ((ETHXCVR_BOOLEAN_TRUE == aConfig->jumbo) ||
        (ETHXCVR_FLOWCONTROL_NONE != aConfig->flowControl)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    }
    return retVal;
}

/**
   @code{.unparsed}
    if aMode is ETHXCVR_MODE_ACTIVE
        Enable bit'15 in IO_XGMII_RXFIFO_CTL
        Enable bit'15 in IO_XGMII_TXFIFO_CTL
    @endcode

    @trace #BRCM_SWARCH_ETHXCVR_PLATFORMMUXCONFIG_PROC
    @trace #BRCM_SWREQ_ETHXCVR_KERNEL_HANDLER_BCM8957X
*/
static void ETHXCVR_PlatformConfigSGMIIPLUSR(ETHXCVR_ModeType aMode)
{
    if (ETHXCVR_MODE_ACTIVE == aMode) {
        /* IO_XGMII_RXFIFO_CTL: RXFIFO_ENABLE (bit 15)=1 */
        ETHXCVR_IO_RDB_REG->xgmii_rxfifo_ctl = IO_XGMII_RXFIFO_CTL_XGMII_RXFIFO_ENABLE_MASK;
        /* IO_XGMII_TXFIFO_CTL: TXFIFO_ENABLE (bit 15)=1 */
        ETHXCVR_IO_RDB_REG->xgmii_txfifo_ctl = IO_XGMII_TXFIFO_CTL_XGMII_TXFIFO_ENABLE_MASK;
    }
}

/**
    @code{.unparsed}
    if aMode is ETHXCVR_MODE_ACTIVE
        Enable MII clock and GMII pads (IO_MII1_CONFIG)
        Enable the RGMII interface and set clock direction (IO_RGMII1_CTL)
        Bring link up and set speed (IO_RGMII1_GMII_CTL)
    if aMode is ETHXCVR_MODE_DOWN
        Disable the RGMII interface (IO_RGMII1_CTL)
        Bring link down (IO_RGMII1_GMII_CTL)
    if aMode is ETHXCVR_MODE_ISOLATE
        Disable the RGMII interface (IO_RGMII1_CTL)
    @endcode

    @trace #BRCM_SWARCH_ETHXCVR_PLATFORMMUXCONFIG_PROC
    @trace #BRCM_SWREQ_ETHXCVR_KERNEL_HANDLER_BCM8957X
*/
static void ETHXCVR_PlatformConfigRGMII1(const ETHXCVR_PortConfigType *const aConfig,
                                         ETHXCVR_ModeType aMode)
{
    if (ETHXCVR_MODE_ACTIVE == aMode) {
        ETHXCVR_IO_RDB_REG->mii1_config = IO_MII1_CONFIG_CLOCK_EN_MII1_MASK |
                                  IO_MII1_CONFIG_SEL_MII1_MASK;
        ETHXCVR_IO_RDB_REG->rgmii1_ctl &= ~(IO_RGMII1_CTL_DIS_IMP_MASK |
                                    IO_RGMII1_CTL_RMII_CLOCK_SHORTCUT_MASK |
                                    IO_RGMII1_CTL_RGMII1_CTL_MASK);
        ETHXCVR_IO_RDB_REG->rgmii1_ctl |= (IO_RGMII1_CTL_RMII_CLOCK_DIRECTION_MASK      |
                                           IO_RGMII1_CTL_RGMII1_BYPASS_IMP_2NS_DEL_MASK |
                                           IO_RGMII_ENABLE_2NS_RX_DELAY_MASK);

        ETHXCVR_IO_RDB_REG->rgmii1_gmii_ctl |= IO_RGMII1_GMII_CTL_RGMII_LINK_MASK;
        ETHXCVR_IO_RDB_REG->rgmii1_gmii_ctl &=  ~IO_RGMII1_GMII_CTL_RGMII_SPD_MASK;
        ETHXCVR_IO_RDB_REG->rgmii1_gmii_ctl |=  (aConfig->speed >> 1U) << IO_RGMII1_GMII_CTL_RGMII_SPD_SHIFT;
    } else if (ETHXCVR_MODE_DOWN == aMode) {
        ETHXCVR_IO_RDB_REG->rgmii1_ctl |= IO_RGMII1_CTL_DIS_IMP_MASK;
        ETHXCVR_IO_RDB_REG->rgmii1_gmii_ctl &= ~IO_RGMII1_GMII_CTL_RGMII_LINK_MASK;
    } else if (ETHXCVR_MODE_ISOLATE == aMode) {
        ETHXCVR_IO_RDB_REG->rgmii1_ctl |= IO_RGMII1_CTL_DIS_IMP_MASK;
    }
}

/**
    @code {.unparsed}
    if aMode is ETHXCVR_MODE_ACTIVE
        Enable MII clock and GMII pads (IO_MII2_CONFIG)
        Enable the RGMII interface and set clock direction (IO_RGMII2_CTL)
        Bring link up and set speed (IO_RGMII2_GMII_CTL)
    if aMode is ETHXCVR_MODE_DOWN
        Disable the RGMII interface (IO_RGMII2_CTL)
        Bring link down (IO_RGMII2_GMII_CTL)
    if aMode is ETHXCVR_MODE_ISOLATE
        Disable the RGMII interface (IO_RGMII2_CTL)
    @endcode

    @trace #BRCM_SWARCH_ETHXCVR_PLATFORMMUXCONFIG_PROC
    @trace #BRCM_SWREQ_ETHXCVR_KERNEL_HANDLER_BCM8957X
*/
static void ETHXCVR_PlatformConfigRGMII2(const ETHXCVR_PortConfigType *const aConfig,
                                         ETHXCVR_ModeType aMode)
{
    if (ETHXCVR_MODE_ACTIVE == aMode) {
        ETHXCVR_IO_RDB_REG->mii2_config = IO_MII2_CONFIG_CLOCK_EN_MII2_MASK |
                                  IO_MII2_CONFIG_SEL_MII2_MASK;
		/*disable rgmii interface */
        ETHXCVR_IO_RDB_REG->rgmii2_ctl |= IO_RGMII2_CTL_DIS_IMP_MASK;

        /* set bypass shortcut, clear ctl  */
        ETHXCVR_IO_RDB_REG->rgmii2_ctl &= (IO_RGMII2_CTL_RMII_CLOCK_SHORTCUT_MASK |
                                    IO_RGMII2_CTL_RGMII2_CTL_MASK);
        /* set direction */
        ETHXCVR_IO_RDB_REG->rgmii2_ctl |= IO_RGMII2_CTL_RMII_CLOCK_DIRECTION_MASK;
		
        /* set link status   */
        ETHXCVR_IO_RDB_REG->rgmii2_gmii_ctl |= IO_RGMII2_GMII_CTL_RGMII_LINK_MASK;

		/* set speed to 0 (10M) */
        ETHXCVR_IO_RDB_REG->rgmii2_gmii_ctl &=  ~IO_RGMII2_GMII_CTL_RGMII_SPD_MASK;

		/*set the speed (note: shift constant == 0, so reg gets whatever is in aConfig->speed>>1) */
		ETHXCVR_IO_RDB_REG->rgmii2_gmii_ctl |=	(aConfig->speed >> 1U) << IO_RGMII2_GMII_CTL_RGMII_SPD_SHIFT;

		/* set power to 1.8v*/
        ETHXCVR_IO_RDB_REG->mii2_config |= IO_MII2_CONFIG_AMP_ENABLE_MII2_MASK;
		ETHXCVR_IO_RDB_REG->io_mii2_modehv &= ~(IO_MII2_MODEHV_MII1_MODEHV_MASK);
		
		/* clear mii2 straps */
        ETHXCVR_IO_RDB_REG->straps_ov &= ~(IO_STRAPS_OV_MII2_MODE_0_MASK |
                                                    IO_STRAPS_OV_MII2_MODE_1_MASK |
                                                    IO_STRAPS_OV_MII2_MODE_2_MASK);

        /* over ride the mii2 straps to rgmii 1G */
        ETHXCVR_IO_RDB_REG->straps_ov |= IO_STRAPS_OV_MII2_MODE_2_MASK;

        /*enable interface, set bypass shortcut, clear ctl  */
        ETHXCVR_IO_RDB_REG->rgmii2_ctl &= ~(IO_RGMII2_CTL_DIS_IMP_MASK |
                                    IO_RGMII2_CTL_RMII_CLOCK_SHORTCUT_MASK |
                                    IO_RGMII2_CTL_RGMII2_CTL_MASK);
		
		/* set the rx _or_ tx 2ns delay */
        ETHXCVR_IO_RDB_REG->rgmii2_ctl |= (IO_RGMII2_CTL_RGMII2_BYPASS_IMP_2NS_DEL_MASK |
        (0x06U /* 4 for rx delay, 2 for tx delay, 6 for tx&rx delay, 0 for no delay */ ));

    } else if (ETHXCVR_MODE_DOWN == aMode) {
        ETHXCVR_IO_RDB_REG->rgmii2_ctl |= IO_RGMII2_CTL_DIS_IMP_MASK;
        ETHXCVR_IO_RDB_REG->rgmii2_gmii_ctl &= ~IO_RGMII2_GMII_CTL_RGMII_LINK_MASK;
    } else if (ETHXCVR_MODE_ISOLATE == aMode) {
        ETHXCVR_IO_RDB_REG->rgmii2_ctl |= IO_RGMII2_CTL_DIS_IMP_MASK;
    }
}

/**
    @code {.unparsed}
    if aMode is ETHXCVR_MODE_ACTIVE
        Enable MII clock and GMII pads (IO_MII3_CONFIG)
        Enable the RGMII interface and set clock direction (IO_RGMII3_CTL)
        Bring link up and set speed (IO_RGMII3_GMII_CTL)
    if aMode is ETHXCVR_MODE_DOWN
        Disable the RGMII interface (IO_RGMII3_CTL)
        Bring link down (IO_RGMII3_GMII_CTL)
    if aMode is ETHXCVR_MODE_ISOLATE
        Disable the RGMII interface (IO_RGMII3_CTL)
    @endcode

    @trace #BRCM_SWARCH_ETHXCVR_PLATFORMMUXCONFIG_PROC
    @trace #BRCM_SWREQ_ETHXCVR_KERNEL_HANDLER_BCM8957X
*/
static void ETHXCVR_PlatformConfigRGMII3(const ETHXCVR_PortConfigType *const aConfig,
                                         ETHXCVR_ModeType aMode)
{
    if (ETHXCVR_BOOLEAN_TRUE == aConfig->portEnable) {

        /* 0x800e: Enable MII3 Internal Clock & IO pad datasheet recommends value of 7 to meet RGMII spec */
        ETHXCVR_IO_RDB_REG->mii3_config = IO_MII3_CONFIG_CLOCK_EN_MII3_MASK |
                                  IO_MII3_CONFIG_SEL_MII3_MASK;

        /*disable rgmii interface */
        ETHXCVR_IO_RDB_REG->rgmii3_ctl |= IO_RGMII3_CTL_DIS_IMP_MASK;

        /* set bypass shortcut, clear ctl  */
        ETHXCVR_IO_RDB_REG->rgmii3_ctl &=( IO_RGMII3_CTL_RMII_CLOCK_SHORTCUT_MASK |
                                    IO_RGMII3_CTL_RGMII3_CTL_MASK);
        /* set direction */
        ETHXCVR_IO_RDB_REG->rgmii3_ctl |= IO_RGMII3_CTL_RMII_CLOCK_DIRECTION_MASK;

        /* set link status   */
        ETHXCVR_IO_RDB_REG->rgmii3_gmii_ctl |= IO_RGMII3_GMII_CTL_RGMII_LINK_MASK;
        
        /* set speed to 0 (10M) */
        ETHXCVR_IO_RDB_REG->rgmii3_gmii_ctl &=  ~IO_RGMII3_GMII_CTL_RGMII_SPD_MASK;

        /*set the speed (note: shift constant == 0, so reg gets whatever is in aConfig->speed>>1) */
        ETHXCVR_IO_RDB_REG->rgmii3_gmii_ctl |=  (aConfig->speed >> 1U) << IO_RGMII3_GMII_CTL_RGMII_SPD_SHIFT;

        /* set power to 1.8v*/
        ETHXCVR_IO_RDB_REG->mii3_config |= IO_MII3_CONFIG_AMP_ENABLE_MII3_MASK;
		ETHXCVR_IO_RDB_REG->io_mii3_modehv &= ~(IO_MII3_MODEHV_MODEHV_MASK);
		
        /* clear mii3 straps */
        ETHXCVR_IO_RDB_REG->straps_ov2&= ~(IO_STRAPS_OV2_MII3_MODE_0_MASK |
                                                    IO_STRAPS_OV2_MII3_MODE_1_MASK |
                                                    IO_STRAPS_OV2_MII3_MODE_2_MASK);

        /* over ride the mii3 straps to rgmii 1G */
        ETHXCVR_IO_RDB_REG->straps_ov2 |= IO_STRAPS_OV2_MII3_MODE_2_MASK;

        /*enable interface, set bypass shortcut, clear ctl  */
        ETHXCVR_IO_RDB_REG->rgmii3_ctl &= ~(IO_RGMII3_CTL_DIS_IMP_MASK |
                                    IO_RGMII3_CTL_RMII_CLOCK_SHORTCUT_MASK |
                                    IO_RGMII3_CTL_RGMII3_CTL_MASK);

		 /* set the rx _or_ tx 2ns delay */
        ETHXCVR_IO_RDB_REG->rgmii3_ctl |= (IO_RGMII3_CTL_RGMII3_BYPASS_IMP_2NS_DEL_MASK |
        (0x06U /* 4 for rx delay, 2 for tx delay, 6 for tx&rx delay, 0 for no delay */ ));


    } else if (ETHXCVR_MODE_DOWN == aMode) {
        /* disable the rgmii interface */
        ETHXCVR_IO_RDB_REG->rgmii3_ctl |= IO_RGMII3_CTL_DIS_IMP_MASK;
        /* set link status to 0  */
        ETHXCVR_IO_RDB_REG->rgmii3_gmii_ctl &= ~IO_RGMII3_GMII_CTL_RGMII_LINK_MASK;
    } else if (ETHXCVR_MODE_ISOLATE == aMode) {
        ETHXCVR_IO_RDB_REG->rgmii3_ctl |= IO_RGMII3_CTL_DIS_IMP_MASK;
    }
}

/**
    @code {.unparsed}
    set retVal to BCM_ERR_TIME_OUT
    loop ETHXCVR_DENALI_MDIO_MAX_TRIES times
        Invoke MDIO_StateHandler()
        if MDIO job is complete
            retVal = MDIO_GetJobResult()
            if retVal is BCM_ERR_OK or an error other than BCM_ERR_BUSY
                break out of loop
    return retVal
    @endcode

    @trace #BRCM_SWARCH_ETHXCVR_PLATFORMMUXCONFIG_PROC
    @trace #BRCM_SWREQ_ETHXCVR_KERNEL_HANDLER_BCM8957X
*/
static int32_t ETHXCVR_PlatformWaitMDIOJobCompletion(uint8_t             aHwID,
                                                     MDIO_JobIDType      aJobID,
                                                     ETHER_MDIOPktType *const aPkt)
{
    int32_t  retVal = BCM_ERR_TIME_OUT;
    uint32_t i;

    for (i = 0UL; i < ETHXCVR_DENALI_MDIO_MAX_TRIES; i++) {
        uint32_t isJobcomplete = FALSE;
        MDIO_StateHandler(&isJobcomplete);
        if (TRUE == isJobcomplete) {
            retVal = MDIO_GetJobResult(aHwID, aJobID, aPkt);
            if ((BCM_ERR_OK == retVal) || (BCM_ERR_BUSY != retVal)) {
                break;
            }
        }
    }

    return retVal;
}

/**
    @code {.unparsed}
    if MDIO job queue is full set retVal to BCM_ERR_NOMEM
    Trigger read for dev 0x1, reg 0x932A
    Wait for read to complete by invoking ETHXCVR_PlatformWaitMDIOJobCompletion()
    Clear super_isolate bit
    Trigger write for dev 0x1, reg 0x932A
    Wait for write to complete by invoking ETHXCVR_PlatformWaitMDIOJobCompletion()
    @endcode

    @trace #BRCM_SWARCH_ETHXCVR_PLATFORMMUXCONFIG_PROC
    @trace #BRCM_SWREQ_ETHXCVR_KERNEL_HANDLER_BCM8957X
*/
static void ETHXCVR_PlatformRemoveDenaliSuperIsolate(const ETHXCVR_PortConfigType *const aConfig)
{
    int32_t        retVal;
    ETHER_MDIOPktType   pkt;
    MDIO_JobIDType jobID;
    uint32_t       line = 0UL;

    /* Check space in MDIO job queue */
    uint32_t freeLen = MDIO_GetJobQFreeLen(aConfig->phy.hwID);
    if (freeLen == 1UL) {
        retVal = BCM_ERR_NOMEM;
        line = __LINE__;
        goto exit;
    }

    /* Read the POWER_MII_CONTROL register */
    pkt.slaveAddr = aConfig->phy.slaveID;
    pkt.deviceType = ETHXCVR_DENALI_DEVICEID_1;
    pkt.regAccMode = ETHER_MDIOREGACCESS_CL45;
    pkt.regAddr = ETHXCVR_DENALI_POWERMII_CTRL_REG;

    retVal = MDIO_Read(aConfig->phy.hwID, &pkt, &jobID);
    if (BCM_ERR_OK != retVal) {
        line = __LINE__;
        goto exit;
    }

    retVal = ETHXCVR_PlatformWaitMDIOJobCompletion(aConfig->phy.hwID, jobID, &pkt);
    if (BCM_ERR_OK != retVal) {
        line = __LINE__;
        goto exit;
    }


    /* Clear the super isolate bit and write back to the register  */
    pkt.regData &= ~ETHXCVR_DENALI_POWERMII_CTRL_SUPER_ISOLATE_MASK;
    retVal = MDIO_Write(aConfig->phy.hwID, &pkt, &jobID);
    if (BCM_ERR_OK != retVal) {
        line = __LINE__;
        goto exit;
    }

    retVal = ETHXCVR_PlatformWaitMDIOJobCompletion(aConfig->phy.hwID, jobID, &pkt);
    if (BCM_ERR_OK != retVal) {
        line = __LINE__;
        goto exit;
    }

#if 0
    /* Extra stuff ! */
    pkt.slaveAddr = aConfig->phy.slaveID;
    pkt.deviceType = ETHXCVR_DENALI_DEVICEID_1;
    pkt.regAccMode = ETHER_MDIOREGACCESS_CL45;
    pkt.regAddr = 0x0834U;
    pkt.regData = 0x8001 | (aConfig->phy.masterMode * 0x4000);
    retVal = MDIO_Write(aConfig->phy.hwID, &pkt, &jobID);
    if (BCM_ERR_OK != retVal) {
        line = __LINE__;
        goto exit;
    }

    retVal = ETHXCVR_PlatformWaitMDIOJobCompletion(aConfig->phy.hwID, jobID, &pkt);
    if (BCM_ERR_OK != retVal) {
        line = __LINE__;
        goto exit;
    }

    pkt.slaveAddr = aConfig->phy.slaveID;
    pkt.deviceType = 7U;
    pkt.regAccMode = ETHER_MDIOREGACCESS_CL45;
    pkt.regAddr = 0x0200U;
    pkt.regData = 0x0200U;
    retVal = MDIO_Write(aConfig->phy.hwID, &pkt, &jobID);
    if (BCM_ERR_OK != retVal) {
        line = __LINE__;
        goto exit;
    }

    retVal = ETHXCVR_PlatformWaitMDIOJobCompletion(aConfig->phy.hwID, jobID, &pkt);
    if (BCM_ERR_OK != retVal) {
        line = __LINE__;
        goto exit;
    }

    pkt.slaveAddr = aConfig->phy.slaveID;
    pkt.deviceType = 7U;
    pkt.regAccMode = ETHER_MDIOREGACCESS_CL45;
    pkt.regAddr = 0x8F02U;
    pkt.regData = 0x0003U;
    retVal = MDIO_Write(aConfig->phy.hwID, &pkt, &jobID);
    if (BCM_ERR_OK != retVal) {
        line = __LINE__;
        goto exit;
    }

    retVal = ETHXCVR_PlatformWaitMDIOJobCompletion(aConfig->phy.hwID, jobID, &pkt);
    if (BCM_ERR_OK != retVal) {
        line = __LINE__;
        goto exit;
    }
#endif


exit:
    if (BCM_ERR_OK != retVal) {
        ETHXCVR_DrvReportError(BCM_XVR_ID, aConfig->id,
                BRCM_SWDSGN_ETHXCVR_PLATFORMREMOVEDENALISUPERISOLATE_PROC,
                retVal, line, aConfig->phy.hwID, aConfig->phy.slaveID, 0UL);
    }
}

/**
    @code {.unparsed}
    read io_sgmii_rgmii1_ctl register into reg
    if port 1
        if SGMII
            set sel_p1
        else
            clear sel_p1
    if port 3
        if RGMII
            set sel_p3
            configure RGMII1 by invoking ETHXCVR_PlatformConfigRGMII1()
            remote Denali from super isolate by invoking ETHXCVR_PlatformRemoveDenaliSuperIsolate()
            clear sel_p5 to remove port 5 from RGMII mode
        else
            clear sel_p3
    if port 5
        clear sel_p5
        if SGMII
            set SGMII in sel_p5
        else if RGMII
            set RGMII in sel_p5
            configure RGMII1 by invoking ETHXCVR_PlatformConfigRGMII1()
            remote Denali from super isolate by invoking ETHXCVR_PlatformRemoveDenaliSuperIsolate()
    if port 6
        if RGMII
            clear sel_p6p8_main bit 1
            configure RGMII2 by invoking ETHXCVR_PlatformConfigRGMII2()
            remote Denali from super isolate by invoking ETHXCVR_PlatformRemoveDenaliSuperIsolate()
        if PCIE
            set sel_p6p8_pcie
            set sel_p6p8_main bit 1
            set sel_p6p8_main bit 2
        if SGMII
            set sel_p6p8_main bit 1
            if using SGMII_PLUSR block
                clear sel_p6p8_main bit 2
                if speed is 5000MBPS
                    set sel_p6p8_5gbr
            if using SGMII_PCIE block
                set sel_p6p8_main bit 2
                clear sel_p6p8_pcie
    if port 8
        if RGMII
            clear sel_p6p8_main bit 0
            configure RGMII3 by invoking ETHXCVR_PlatformConfigRGMII3()
        if PCIE
            set sel_p6p8_pcie
            set sel_p6p8_main bit 0
            clear sel_p6p8_main bit 2
        if SGMII
            set sel_p6p8_main bit 0
            if using SGMII_PLUSR block
                set sel_p6p8_main bit 2
                if speed is 5000MBPS
                    set sel_p6p8_5gbr
            if using SGMII_PCIE block
                clear sel_p6p8_main bit 2
                clear sel_p6p8_pcie
    write back reg to io_sgmii_rgmii1_ctl
    @endcode
    @trace #BRCM_SWARCH_ETHXCVR_PLATFORMMUXCONFIG_PROC
    @trace #BRCM_SWREQ_ETHXCVR_KERNEL_HANDLER_BCM8957X
*/
int32_t ETHXCVR_PlatformMuxConfigure(const ETHXCVR_PortConfigType *const aConfig,
                                  ETHXCVR_ModeType aMode)
{
    uint16_t reg;
    int32_t retVal = BCM_ERR_OK;
    uint32_t clk = 0xFFFFFFFFUL;

    reg = ETHXCVR_IO_RDB_REG->sgmii_rgmii_ctl;

    switch (aConfig->id) {
        case 1U:
            if (aConfig->busMode == ETHXCVR_BUSMODE_SGMII) {
                if (ETHXCVR_MODE_ACTIVE == aMode) {
                    clk = MCU_CLK_ID_SGA;
                }
                reg |= IO_SGMII_RGMII_CTL_SEL_P1_MASK;
            } else {
                reg &= ~((uint16_t)IO_SGMII_RGMII_CTL_SEL_P1_MASK);
            }
            break;
        case 3U:
            if (aConfig->busMode == ETHXCVR_BUSMODE_RGMII) {
                reg |= IO_SGMII_RGMII_CTL_SEL_P3_MASK;
                ETHXCVR_PlatformConfigRGMII1(aConfig, aMode);
                /* Remove Denali from super isolate */
                ETHXCVR_PlatformRemoveDenaliSuperIsolate(aConfig);
                /* Ensure that we clear bit 9 which is the reset value */
                /* so that even if P5 is not configured, the mux is in */
                /* correct state                                       */
                reg &= ~(IO_SGMII_RGMII_CTL_SEL_P5_RGMII_MASK);
            } else {
                reg &= ~((uint16_t)IO_SGMII_RGMII_CTL_SEL_P3_MASK);
            }
            break;
        case 5U:
            reg &= ~((uint16_t)IO_SGMII_RGMII_CTL_SEL_P5_MASK);
            if (aConfig->busMode == ETHXCVR_BUSMODE_SGMII) {
                if (ETHXCVR_MODE_ACTIVE == aMode) {
                    clk = MCU_CLK_ID_SGA;
                }
                reg |= IO_SGMII_RGMII_CTL_SEL_P5_SGMII_MASK;
            } else if (aConfig->busMode == ETHXCVR_BUSMODE_RGMII) {
                reg |= IO_SGMII_RGMII_CTL_SEL_P5_RGMII_MASK;
                ETHXCVR_PlatformConfigRGMII1(aConfig, aMode);
                /* Remove Denali from super isolate */
                ETHXCVR_PlatformRemoveDenaliSuperIsolate(aConfig);
            } else {
                /* Nothing to be done for ETHXCVR_BUSMODE_INTG */
            }
            break;
        case 6U:
            if (aConfig->busMode == ETHXCVR_BUSMODE_RGMII) {
                /* P6 is RGMII */
                reg &= ~((uint16_t)IO_SGMII_RGMII_CTL_SEL_P6P8_MAIN_BIT1_MASK);
                ETHXCVR_PlatformConfigRGMII2(aConfig, aMode);
                /* Remove Denali from super isolate */
                ETHXCVR_PlatformRemoveDenaliSuperIsolate(aConfig);
            } else if (aConfig->busMode == ETHXCVR_BUSMODE_PCIE) {
                /* SGMIIPCIE is being used in PCIE_SRIOV mode */
                reg |= IO_SGMII_RGMII_CTL_SEL_P6P8_PCIE_MASK;

                /* P6 is something other than RGMII */
                reg |= IO_SGMII_RGMII_CTL_SEL_P6P8_MAIN_BIT1_MASK;

                /* Data crosses over from SGMIIPCIE to P6 instead of going to P8 */
                reg |= IO_SGMII_RGMII_CTL_SEL_P6P8_MAIN_BIT2_MASK;
            } else {
                /* P6 is something other than RGMII */
                reg |= IO_SGMII_RGMII_CTL_SEL_P6P8_MAIN_BIT1_MASK;

                if (aConfig->bus.cntrlID == ETHXCVR_HWID_SGMIIPLUSR) {
                    /* Data goes straight to P6 from SGMIIPLUSR instead of crossing over to P8 */
                    reg &= ~((uint16_t)IO_SGMII_RGMII_CTL_SEL_P6P8_MAIN_BIT2_MASK);

                    if (aConfig->speed == ETHXCVR_SPEED_5000MBPS) {
                        reg |= IO_SGMII_RGMII_CTL_SEL_P6P8_5GBR_MASK;
                        ETHXCVR_PlatformConfigSGMIIPLUSR(aMode);
                    }
                    else {
                        reg &= ~((uint16_t)IO_SGMII_RGMII_CTL_SEL_P6P8_5GBR_MASK);
                    }
                } else {
                    if (ETHXCVR_MODE_ACTIVE == aMode) {
                        if (ETHXCVR_HWID_SGMIIPCIE == aConfig->bus.cntrlID) {
                            clk = MCU_CLK_ID_PCI;
                        }
                    }
                    /* Data crosses over from SGMIIPCIE to P6 instead of going to P8 */
                    reg |= IO_SGMII_RGMII_CTL_SEL_P6P8_MAIN_BIT2_MASK;

                    /* SGMIIPCIE is being used in SGMII mode */
                    reg &= ~((uint16_t)IO_SGMII_RGMII_CTL_SEL_P6P8_PCIE_MASK);
                }
            }
            break;
        case 8U:
            if (aConfig->busMode == ETHXCVR_BUSMODE_RGMII) {
                /* P8 is RGMII */
                reg &= ~((uint16_t)IO_SGMII_RGMII_CTL_SEL_P6P8_MAIN_BIT0_MASK);
                ETHXCVR_PlatformConfigRGMII3(aConfig, aMode);
            } else if (aConfig->busMode == ETHXCVR_BUSMODE_PCIE) {
                /* SGMIIPCIE is being used in PCIE_SRIOV mode */
                reg |= IO_SGMII_RGMII_CTL_SEL_P6P8_PCIE_MASK;

                /* P8 is something other than RGMII */
                reg |= IO_SGMII_RGMII_CTL_SEL_P6P8_MAIN_BIT0_MASK;

                /* Data goes straight to P8 from SGMIIPCIE instead of crossing over to P6 */
                reg &= ~((uint16_t)IO_SGMII_RGMII_CTL_SEL_P6P8_MAIN_BIT2_MASK);
            } else {
                /* P8 is something other than RGMII */
                reg |= IO_SGMII_RGMII_CTL_SEL_P6P8_MAIN_BIT0_MASK;

                if (aConfig->bus.cntrlID == ETHXCVR_HWID_SGMIIPLUSR) {
                    /* Data crosses over from SGMIIPLUSR to P8 instead of going to P6 */
                    reg |= IO_SGMII_RGMII_CTL_SEL_P6P8_MAIN_BIT2_MASK;

                    if (aConfig->speed == ETHXCVR_SPEED_5000MBPS) {
                        reg |= IO_SGMII_RGMII_CTL_SEL_P6P8_5GBR_MASK;
                        ETHXCVR_PlatformConfigSGMIIPLUSR(aMode);
                    }
                    else {
                        reg &= ~((uint16_t)IO_SGMII_RGMII_CTL_SEL_P6P8_5GBR_MASK);
                    }
                } else {
                    if (ETHXCVR_MODE_ACTIVE == aMode) {
                        if (ETHXCVR_HWID_SGMIIPCIE == aConfig->bus.cntrlID) {
                            clk = MCU_CLK_ID_PCI;
                        }
                    }

                    /* Data goes straight to P8 from SGMIIPCIE instead of crossing over to P6 */
                    reg &= ~((uint16_t)IO_SGMII_RGMII_CTL_SEL_P6P8_MAIN_BIT2_MASK);

                    /* SGMIIPCIE is being used in SGMII mode */
                    reg &= ~((uint16_t)IO_SGMII_RGMII_CTL_SEL_P6P8_PCIE_MASK);
                }
            }
            break;
        default:
            break;
    }
    if (reg != ETHXCVR_IO_RDB_REG->sgmii_rgmii_ctl) {
         ETHXCVR_IO_RDB_REG->sgmii_rgmii_ctl = reg;
    }
    if (0xFFFFFFFFUL != clk) {
        retVal = MCU_SetSerDesClk(clk, aConfig->bus.cntrlID);
        if (BCM_ERR_OK != retVal) {
            retVal = BCM_ERR_UNKNOWN;
        }
    }

    return retVal;
}
/** @} */
