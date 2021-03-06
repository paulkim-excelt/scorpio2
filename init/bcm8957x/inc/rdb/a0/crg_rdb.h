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
    @file crg_rdb.h
    @brief RDB File for CRG

    @version Orion_A0_20201104_SWDEV
*/

#ifndef CRG_RDB_H
#define CRG_RDB_H

#include <stdint.h>

#include <compiler.h>


typedef uint16_t CRG_XTAL_CONFIG_TYPE;
#define CRG_XTAL_CONFIG_CMOS_EN_ALL_MASK (0x8000U)
#define CRG_XTAL_CONFIG_CMOS_EN_ALL_SHIFT (15U)
#define CRG_XTAL_CONFIG_CMOS_EN_CH_MASK (0x7c00U)
#define CRG_XTAL_CONFIG_CMOS_EN_CH_SHIFT (10U)
#define CRG_XTAL_CONFIG_CML_PD_CH2_MASK (0x200U)
#define CRG_XTAL_CONFIG_CML_PD_CH2_SHIFT (9U)
#define CRG_XTAL_CONFIG_CML_PD_CH0_MASK (0x100U)
#define CRG_XTAL_CONFIG_CML_PD_CH0_SHIFT (8U)
#define CRG_XTAL_CONFIG_XCORE_CM_SEL_MASK (0x80U)
#define CRG_XTAL_CONFIG_XCORE_CM_SEL_SHIFT (7U)
#define CRG_XTAL_CONFIG_XTAL_BIAS_MASK (0x70U)
#define CRG_XTAL_CONFIG_XTAL_BIAS_SHIFT (4U)
#define CRG_XTAL_CONFIG_CML_CUR_MASK (0x8U)
#define CRG_XTAL_CONFIG_CML_CUR_SHIFT (3U)
#define CRG_XTAL_CONFIG_D2C_BIAS_MASK (0x7U)
#define CRG_XTAL_CONFIG_D2C_BIAS_SHIFT (0U)




typedef uint16_t CRG_PLL_CONFIG1_TYPE;
#define CRG_PLL_CONFIG1_PDIV_MASK (0xf000U)
#define CRG_PLL_CONFIG1_PDIV_SHIFT (12U)
#define CRG_PLL_CONFIG1_KA_MASK (0x380U)
#define CRG_PLL_CONFIG1_KA_SHIFT (7U)
#define CRG_PLL_CONFIG1_KI_MASK (0x70U)
#define CRG_PLL_CONFIG1_KI_SHIFT (4U)
#define CRG_PLL_CONFIG1_KP_MASK (0xfU)
#define CRG_PLL_CONFIG1_KP_SHIFT (0U)




typedef uint16_t CRG_PLL_CONFIG2_TYPE;
#define CRG_PLL_CONFIG2_BYPASS_EN_MASK (0xf000U)
#define CRG_PLL_CONFIG2_BYPASS_EN_SHIFT (12U)
#define CRG_PLL_CONFIG2_PLL_CH_DELAY_MASK (0xf00U)
#define CRG_PLL_CONFIG2_PLL_CH_DELAY_SHIFT (8U)
#define CRG_PLL_CONFIG2_PLL_CH_HOLD_MASK (0xf0U)
#define CRG_PLL_CONFIG2_PLL_CH_HOLD_SHIFT (4U)
#define CRG_PLL_CONFIG2_PLL_CH_EN_N_MASK (0xfU)
#define CRG_PLL_CONFIG2_PLL_CH_EN_N_SHIFT (0U)




typedef uint16_t CRG_PLL_NDIV_TYPE;
#define CRG_PLL_NDIV_INT_MASK (0x3ffU)
#define CRG_PLL_NDIV_INT_SHIFT (0U)




typedef uint16_t CRG_PLL_CTRL0_TYPE;
#define CRG_PLL_CTRL0_CTRL0_MASK (0xffffU)
#define CRG_PLL_CTRL0_CTRL0_SHIFT (0U)




typedef uint16_t CRG_PLL_CTRL1_TYPE;
#define CRG_PLL_CTRL1_CTRL1_MASK (0xffffU)
#define CRG_PLL_CTRL1_CTRL1_SHIFT (0U)




typedef uint16_t CRG_PLL_CTRL2_TYPE;
#define CRG_PLL_CTRL2_CTRL2_MASK (0xffffU)
#define CRG_PLL_CTRL2_CTRL2_SHIFT (0U)




typedef uint16_t CRG_PLL_CTRL3_TYPE;
#define CRG_PLL_CTRL3_CTRL3_MASK (0xffffU)
#define CRG_PLL_CTRL3_CTRL3_SHIFT (0U)




typedef uint16_t CRG_PLL_MDIV_CH01_TYPE;
#define CRG_PLL_MDIV_CH01_CH1_MASK (0xff00U)
#define CRG_PLL_MDIV_CH01_CH1_SHIFT (8U)
#define CRG_PLL_MDIV_CH01_CH0_MASK (0xffU)
#define CRG_PLL_MDIV_CH01_CH0_SHIFT (0U)




typedef uint16_t CRG_PLL_MDIV_CH23_TYPE;
#define CRG_PLL_MDIV_CH23_CH3_MASK (0xff00U)
#define CRG_PLL_MDIV_CH23_CH3_SHIFT (8U)
#define CRG_PLL_MDIV_CH23_CH2_MASK (0xffU)
#define CRG_PLL_MDIV_CH23_CH2_SHIFT (0U)




typedef uint16_t CRG_PLL_SSC_CONFIG1_TYPE;
#define CRG_PLL_SSC_CONFIG1_SCC_LIMIT_HI_MASK (0x3f00U)
#define CRG_PLL_SSC_CONFIG1_SCC_LIMIT_HI_SHIFT (8U)
#define CRG_PLL_SSC_CONFIG1_SSC_MODE_MASK (0x1U)
#define CRG_PLL_SSC_CONFIG1_SSC_MODE_SHIFT (0U)




typedef uint16_t CRG_PLL_SSC_CONFIG2_TYPE;
#define CRG_PLL_SSC_CONFIG2_SCC_LIMIT_LOW_MASK (0xffffU)
#define CRG_PLL_SSC_CONFIG2_SCC_LIMIT_LOW_SHIFT (0U)




typedef uint16_t CRG_PLL_SSC_STEP_TYPE;
#define CRG_PLL_SSC_STEP_SCC_STEP_MASK (0xffffU)
#define CRG_PLL_SSC_STEP_SCC_STEP_SHIFT (0U)




typedef uint16_t CRG_PLL_STATUS_TYPE;
#define CRG_PLL_STATUS_LOCK_MASK (0x2000U)
#define CRG_PLL_STATUS_LOCK_SHIFT (13U)
#define CRG_PLL_STATUS_LOCK_LOST_MASK (0x1000U)
#define CRG_PLL_STATUS_LOCK_LOST_SHIFT (12U)
#define CRG_PLL_STATUS_STATUS_MASK (0xfffU)
#define CRG_PLL_STATUS_STATUS_SHIFT (0U)




typedef uint16_t CRG_CLOCK_CONFIG1_TYPE;
#define CRG_CLOCK_CONFIG1_CLK625_DIS_MASK (0x80U)
#define CRG_CLOCK_CONFIG1_CLK625_DIS_SHIFT (7U)
#define CRG_CLOCK_CONFIG1_MII3_GMIICLK_DIS_MASK (0x40U)
#define CRG_CLOCK_CONFIG1_MII3_GMIICLK_DIS_SHIFT (6U)
#define CRG_CLOCK_CONFIG1_PCIE_AXI_CLK_DIS_MASK (0x20U)
#define CRG_CLOCK_CONFIG1_PCIE_AXI_CLK_DIS_SHIFT (5U)
#define CRG_CLOCK_CONFIG1_MACPCIECLK_DIS_MASK (0x10U)
#define CRG_CLOCK_CONFIG1_MACPCIECLK_DIS_SHIFT (4U)
#define CRG_CLOCK_CONFIG1_SYSCLK_DIS_MASK (0x8U)
#define CRG_CLOCK_CONFIG1_SYSCLK_DIS_SHIFT (3U)
#define CRG_CLOCK_CONFIG1_MII2_GMIICLK_DIS_MASK (0x4U)
#define CRG_CLOCK_CONFIG1_MII2_GMIICLK_DIS_SHIFT (2U)
#define CRG_CLOCK_CONFIG1_MII1_GMIICLK_DIS_MASK (0x2U)
#define CRG_CLOCK_CONFIG1_MII1_GMIICLK_DIS_SHIFT (1U)
#define CRG_CLOCK_CONFIG1_P7_GMIICLK_DIS_MASK (0x1U)
#define CRG_CLOCK_CONFIG1_P7_GMIICLK_DIS_SHIFT (0U)




typedef uint16_t CRG_CLOCK_CONFIG2_TYPE;
#define CRG_CLOCK_CONFIG2_DIS_PLL1_CH2_DIV2_BYP_MASK (0x10U)
#define CRG_CLOCK_CONFIG2_DIS_PLL1_CH2_DIV2_BYP_SHIFT (4U)
#define CRG_CLOCK_CONFIG2_PCIE_GEN1_SEL_OVR_MASK (0xcU)
#define CRG_CLOCK_CONFIG2_PCIE_GEN1_SEL_OVR_SHIFT (2U)
#define CRG_CLOCK_CONFIG2_PCIEMAC_PTP_SEL_MASK (0x2U)
#define CRG_CLOCK_CONFIG2_PCIEMAC_PTP_SEL_SHIFT (1U)
#define CRG_CLOCK_CONFIG2_QSPICLK_SEL_MASK (0x1U)
#define CRG_CLOCK_CONFIG2_QSPICLK_SEL_SHIFT (0U)




typedef uint16_t CRG_IDDQ_CHIP_TYPE;
#define CRG_IDDQ_CHIP_CHIP_MASK (0xffffU)
#define CRG_IDDQ_CHIP_CHIP_SHIFT (0U)




typedef uint16_t CRG_IDDQ_CONFIG_TYPE;
#define CRG_IDDQ_CONFIG_BRPHY0_MASK (0x800U)
#define CRG_IDDQ_CONFIG_BRPHY0_SHIFT (11U)
#define CRG_IDDQ_CONFIG_BRPHY_1G_1PORT_MASK (0x400U)
#define CRG_IDDQ_CONFIG_BRPHY_1G_1PORT_SHIFT (10U)
#define CRG_IDDQ_CONFIG_SGMII_PLUS2_MASK (0x200U)
#define CRG_IDDQ_CONFIG_SGMII_PLUS2_SHIFT (9U)
#define CRG_IDDQ_CONFIG_RGMII3_MASK (0x100U)
#define CRG_IDDQ_CONFIG_RGMII3_SHIFT (8U)
#define CRG_IDDQ_CONFIG_RGMII2_MASK (0x80U)
#define CRG_IDDQ_CONFIG_RGMII2_SHIFT (7U)
#define CRG_IDDQ_CONFIG_RGMII1_MASK (0x40U)
#define CRG_IDDQ_CONFIG_RGMII1_SHIFT (6U)
#define CRG_IDDQ_CONFIG_SGMII_PLUSR_MASK (0x20U)
#define CRG_IDDQ_CONFIG_SGMII_PLUSR_SHIFT (5U)
#define CRG_IDDQ_CONFIG_BRPHY4_MASK (0x10U)
#define CRG_IDDQ_CONFIG_BRPHY4_SHIFT (4U)
#define CRG_IDDQ_CONFIG_BRPHY3_MASK (0x8U)
#define CRG_IDDQ_CONFIG_BRPHY3_SHIFT (3U)
#define CRG_IDDQ_CONFIG_BRPHY2_MASK (0x4U)
#define CRG_IDDQ_CONFIG_BRPHY2_SHIFT (2U)
#define CRG_IDDQ_CONFIG_BRPHY1_MASK (0x2U)
#define CRG_IDDQ_CONFIG_BRPHY1_SHIFT (1U)
#define CRG_IDDQ_CONFIG_SGMII_PCIE_MASK (0x1U)
#define CRG_IDDQ_CONFIG_SGMII_PCIE_SHIFT (0U)




typedef uint16_t CRG_RESET_CONFIG_TYPE;
#define CRG_RESET_CONFIG_GLOBAL_SRST_EN_MASK (0x8000U)
#define CRG_RESET_CONFIG_GLOBAL_SRST_EN_SHIFT (15U)
#define CRG_RESET_CONFIG_SRST_PCIESS_MASK (0x2000U)
#define CRG_RESET_CONFIG_SRST_PCIESS_SHIFT (13U)
#define CRG_RESET_CONFIG_SRST_SGMIIPCIE_MASK (0x1000U)
#define CRG_RESET_CONFIG_SRST_SGMIIPCIE_SHIFT (12U)
#define CRG_RESET_CONFIG_WDG_CLR_MASK (0x800U)
#define CRG_RESET_CONFIG_WDG_CLR_SHIFT (11U)
#define CRG_RESET_CONFIG_WDG_STATUS_MASK (0x400U)
#define CRG_RESET_CONFIG_WDG_STATUS_SHIFT (10U)
#define CRG_RESET_CONFIG_WDG_EN_MASK (0x200U)
#define CRG_RESET_CONFIG_WDG_EN_SHIFT (9U)
#define CRG_RESET_CONFIG_PVTMON_RST_EN_MASK (0x100U)
#define CRG_RESET_CONFIG_PVTMON_RST_EN_SHIFT (8U)
#define CRG_RESET_CONFIG_SRST_MACSEC_MASK (0x80U)
#define CRG_RESET_CONFIG_SRST_MACSEC_SHIFT (7U)
#define CRG_RESET_CONFIG_SRST_GMII2_MASK (0x40U)
#define CRG_RESET_CONFIG_SRST_GMII2_SHIFT (6U)
#define CRG_RESET_CONFIG_SRST_GMII1_MASK (0x20U)
#define CRG_RESET_CONFIG_SRST_GMII1_SHIFT (5U)
#define CRG_RESET_CONFIG_SRST_SGMII_PLUS2_MASK (0x10U)
#define CRG_RESET_CONFIG_SRST_SGMII_PLUS2_SHIFT (4U)
#define CRG_RESET_CONFIG_SRST_SOC_MASK (0x8U)
#define CRG_RESET_CONFIG_SRST_SOC_SHIFT (3U)
#define CRG_RESET_CONFIG_SRST_SWITCH_MASK (0x4U)
#define CRG_RESET_CONFIG_SRST_SWITCH_SHIFT (2U)
#define CRG_RESET_CONFIG_SRST_BRPHYS_MASK (0x2U)
#define CRG_RESET_CONFIG_SRST_BRPHYS_SHIFT (1U)
#define CRG_RESET_CONFIG_SRST_CHIP_MASK (0x1U)
#define CRG_RESET_CONFIG_SRST_CHIP_SHIFT (0U)




typedef uint16_t CRG_RESET_CONFIG2_TYPE;
#define CRG_RESET_CONFIG2_OTP_FDONE_TIMEOUT_MASK (0x8000U)
#define CRG_RESET_CONFIG2_OTP_FDONE_TIMEOUT_SHIFT (15U)
#define CRG_RESET_CONFIG2_SRST_SGMII_PLUSR_MASK (0x80U)
#define CRG_RESET_CONFIG2_SRST_SGMII_PLUSR_SHIFT (7U)
#define CRG_RESET_CONFIG2_SRST_GMII3_MASK (0x40U)
#define CRG_RESET_CONFIG2_SRST_GMII3_SHIFT (6U)
#define CRG_RESET_CONFIG2_SRST_BRPHY_1G_1PORT_MASK (0x20U)
#define CRG_RESET_CONFIG2_SRST_BRPHY_1G_1PORT_SHIFT (5U)
#define CRG_RESET_CONFIG2_SRST_PCIE_PERST_MASK (0x10U)
#define CRG_RESET_CONFIG2_SRST_PCIE_PERST_SHIFT (4U)
#define CRG_RESET_CONFIG2_SRST_P1588_MII_MASK (0x2U)
#define CRG_RESET_CONFIG2_SRST_P1588_MII_SHIFT (1U)
#define CRG_RESET_CONFIG2_SRST_P1588_MASK (0x1U)
#define CRG_RESET_CONFIG2_SRST_P1588_SHIFT (0U)




typedef uint16_t CRG_XTAL_CONFIG_CML50_TYPE;
#define CRG_XTAL_CONFIG_CML50_PD_DRV_2_MASK (0x80U)
#define CRG_XTAL_CONFIG_CML50_PD_DRV_2_SHIFT (7U)
#define CRG_XTAL_CONFIG_CML50_PD_DRV_1_MASK (0x40U)
#define CRG_XTAL_CONFIG_CML50_PD_DRV_1_SHIFT (6U)
#define CRG_XTAL_CONFIG_CML50_DIV2_SEL_DRV_2_MASK (0x20U)
#define CRG_XTAL_CONFIG_CML50_DIV2_SEL_DRV_2_SHIFT (5U)
#define CRG_XTAL_CONFIG_CML50_DIV2_SEL_DRV_1_MASK (0x10U)
#define CRG_XTAL_CONFIG_CML50_DIV2_SEL_DRV_1_SHIFT (4U)
#define CRG_XTAL_CONFIG_CML50_CUR_DRV_2_MASK (0xcU)
#define CRG_XTAL_CONFIG_CML50_CUR_DRV_2_SHIFT (2U)
#define CRG_XTAL_CONFIG_CML50_CUR_DRV_1_MASK (0x3U)
#define CRG_XTAL_CONFIG_CML50_CUR_DRV_1_SHIFT (0U)




typedef uint8_t CRG_RESERVED_TYPE;




typedef uint16_t CRG_SM_CTRL_TYPE;
#define CRG_SM_CTRL_SPARE_MASK (0xfcU)
#define CRG_SM_CTRL_SPARE_SHIFT (2U)
#define CRG_SM_CTRL_EN_PLL_RST_MASK (0x2U)
#define CRG_SM_CTRL_EN_PLL_RST_SHIFT (1U)
#define CRG_SM_CTRL_SM_EN_MASK (0x1U)
#define CRG_SM_CTRL_SM_EN_SHIFT (0U)




typedef uint16_t CRG_SM_FAULT_CTRL_TYPE;
#define CRG_SM_FAULT_CTRL_EN_MASK (0x1ffU)
#define CRG_SM_FAULT_CTRL_EN_SHIFT (0U)




typedef uint16_t CRG_SM_CLR_LOG_TYPE;
#define CRG_SM_CLR_LOG_LOG_MASK (0x1U)
#define CRG_SM_CLR_LOG_LOG_SHIFT (0U)




typedef uint16_t CRG_SM_TIM_CTRL_TYPE;
#define CRG_SM_TIM_CTRL_SPARE_MASK (0xfcU)
#define CRG_SM_TIM_CTRL_SPARE_SHIFT (2U)
#define CRG_SM_TIM_CTRL_SM_TIM_LOAD_MASK (0x2U)
#define CRG_SM_TIM_CTRL_SM_TIM_LOAD_SHIFT (1U)
#define CRG_SM_TIM_CTRL_SM_TIM_EN_MASK (0x1U)
#define CRG_SM_TIM_CTRL_SM_TIM_EN_SHIFT (0U)




typedef uint16_t CRG_SM_TIM_VAL_TYPE;
#define CRG_SM_TIM_VAL_VAL_MASK (0xffffU)
#define CRG_SM_TIM_VAL_VAL_SHIFT (0U)




typedef uint16_t CRG_SM_TIM_EVT_CLR_TYPE;
#define CRG_SM_TIM_EVT_CLR_CLR_MASK (0x1U)
#define CRG_SM_TIM_EVT_CLR_CLR_SHIFT (0U)




typedef uint16_t CRG_SM_SW_TRIGGER_TYPE;
#define CRG_SM_SW_TRIGGER_TRIG_MASK (0xffffU)
#define CRG_SM_SW_TRIGGER_TRIG_SHIFT (0U)




typedef uint16_t CRG_SM_SW_REASON_TYPE;
#define CRG_SM_SW_REASON_REASON_MASK (0xffU)
#define CRG_SM_SW_REASON_REASON_SHIFT (0U)




typedef uint16_t CRG_SM_CNT_64US_LO_TYPE;
#define CRG_SM_CNT_64US_LO_LO_MASK (0xffffU)
#define CRG_SM_CNT_64US_LO_LO_SHIFT (0U)




typedef uint16_t CRG_SM_CNT_64US_HI_TYPE;
#define CRG_SM_CNT_64US_HI_HI_MASK (0xfU)
#define CRG_SM_CNT_64US_HI_HI_SHIFT (0U)




typedef uint16_t CRG_SM_STATUS_TYPE;
#define CRG_SM_STATUS_STATE_MASK (0x3fU)
#define CRG_SM_STATUS_STATE_SHIFT (0U)




typedef uint16_t CRG_SM_RAW_LOG_LO_TYPE;
#define CRG_SM_RAW_LOG_LO_LO_MASK (0xffffU)
#define CRG_SM_RAW_LOG_LO_LO_SHIFT (0U)




typedef uint16_t CRG_SM_RAW_LOG_HI_TYPE;
#define CRG_SM_RAW_LOG_HI_HI_MASK (0xffffU)
#define CRG_SM_RAW_LOG_HI_HI_SHIFT (0U)




typedef uint16_t CRG_SM_FAULT_LOG_TYPE;
#define CRG_SM_FAULT_LOG_LOG_MASK (0x1ffU)
#define CRG_SM_FAULT_LOG_LOG_SHIFT (0U)




typedef uint16_t CRG_RCOSC_LFO_CTRL_TYPE;
#define CRG_RCOSC_LFO_CTRL_CTRL_MASK (0xffffU)
#define CRG_RCOSC_LFO_CTRL_CTRL_SHIFT (0U)




typedef uint16_t CRG_RCOSC_LFO_CAL_TYPE;
#define CRG_RCOSC_LFO_CAL_CAL_MASK (0xffU)
#define CRG_RCOSC_LFO_CAL_CAL_SHIFT (0U)




typedef uint16_t CRG_RCOSC_LFO_CTRL2_TYPE;
#define CRG_RCOSC_LFO_CTRL2_CTRL2_MASK (0xffU)
#define CRG_RCOSC_LFO_CTRL2_CTRL2_SHIFT (0U)




typedef uint16_t CRG_RCOSC_STATUS_TYPE;
#define CRG_RCOSC_STATUS_LFO_STAT_MASK (0xffU)
#define CRG_RCOSC_STATUS_LFO_STAT_SHIFT (0U)




typedef uint16_t CRG_PLL2_CONFIG1_TYPE;
#define CRG_PLL2_CONFIG1_PDIV_MASK (0xf000U)
#define CRG_PLL2_CONFIG1_PDIV_SHIFT (12U)
#define CRG_PLL2_CONFIG1_KA_MASK (0x380U)
#define CRG_PLL2_CONFIG1_KA_SHIFT (7U)
#define CRG_PLL2_CONFIG1_KI_MASK (0x70U)
#define CRG_PLL2_CONFIG1_KI_SHIFT (4U)
#define CRG_PLL2_CONFIG1_KP_MASK (0xfU)
#define CRG_PLL2_CONFIG1_KP_SHIFT (0U)




typedef uint16_t CRG_PLL2_CONFIG2_TYPE;
#define CRG_PLL2_CONFIG2_BYPASS_EN_MASK (0xf000U)
#define CRG_PLL2_CONFIG2_BYPASS_EN_SHIFT (12U)
#define CRG_PLL2_CONFIG2_CH_DELAY_MASK (0xf00U)
#define CRG_PLL2_CONFIG2_CH_DELAY_SHIFT (8U)
#define CRG_PLL2_CONFIG2_CH_HOLD_MASK (0xf0U)
#define CRG_PLL2_CONFIG2_CH_HOLD_SHIFT (4U)
#define CRG_PLL2_CONFIG2_CH_EN_N_MASK (0xfU)
#define CRG_PLL2_CONFIG2_CH_EN_N_SHIFT (0U)




typedef uint16_t CRG_PLL2_NDIV_TYPE;
#define CRG_PLL2_NDIV_INT_MASK (0x3ffU)
#define CRG_PLL2_NDIV_INT_SHIFT (0U)




typedef uint16_t CRG_PLL2_CTRL0_TYPE;
#define CRG_PLL2_CTRL0_CTRL0_MASK (0xffffU)
#define CRG_PLL2_CTRL0_CTRL0_SHIFT (0U)




typedef uint16_t CRG_PLL2_CTRL1_TYPE;
#define CRG_PLL2_CTRL1_CTRL1_MASK (0xffffU)
#define CRG_PLL2_CTRL1_CTRL1_SHIFT (0U)




typedef uint16_t CRG_PLL2_CTRL2_TYPE;
#define CRG_PLL2_CTRL2_CTRL2_MASK (0xffffU)
#define CRG_PLL2_CTRL2_CTRL2_SHIFT (0U)




typedef uint16_t CRG_PLL2_CTRL3_TYPE;
#define CRG_PLL2_CTRL3_CTRL3_MASK (0xffffU)
#define CRG_PLL2_CTRL3_CTRL3_SHIFT (0U)




typedef uint16_t CRG_PLL2_MDIV_CH01_TYPE;
#define CRG_PLL2_MDIV_CH01_CH1_MASK (0xff00U)
#define CRG_PLL2_MDIV_CH01_CH1_SHIFT (8U)
#define CRG_PLL2_MDIV_CH01_CH0_MASK (0xffU)
#define CRG_PLL2_MDIV_CH01_CH0_SHIFT (0U)




typedef uint16_t CRG_PLL2_MDIV_CH23_TYPE;
#define CRG_PLL2_MDIV_CH23_CH3_MASK (0xff00U)
#define CRG_PLL2_MDIV_CH23_CH3_SHIFT (8U)
#define CRG_PLL2_MDIV_CH23_CH2_MASK (0xffU)
#define CRG_PLL2_MDIV_CH23_CH2_SHIFT (0U)




typedef uint16_t CRG_PLL2_SSC_CONFIG1_TYPE;
#define CRG_PLL2_SSC_CONFIG1_SCC_LIMIT_HI_MASK (0x3f00U)
#define CRG_PLL2_SSC_CONFIG1_SCC_LIMIT_HI_SHIFT (8U)
#define CRG_PLL2_SSC_CONFIG1_SSC_MODE_MASK (0x1U)
#define CRG_PLL2_SSC_CONFIG1_SSC_MODE_SHIFT (0U)




typedef uint16_t CRG_PLL2_SSC_CONFIG2_TYPE;
#define CRG_PLL2_SSC_CONFIG2_SCC_LIMIT_LOW_MASK (0xffffU)
#define CRG_PLL2_SSC_CONFIG2_SCC_LIMIT_LOW_SHIFT (0U)




typedef uint16_t CRG_PLL2_SSC_STEP_TYPE;
#define CRG_PLL2_SSC_STEP_SCC_STEP_MASK (0xffffU)
#define CRG_PLL2_SSC_STEP_SCC_STEP_SHIFT (0U)




typedef uint16_t CRG_PLL2_STATUS_TYPE;
#define CRG_PLL2_STATUS_LOCK_MASK (0x2000U)
#define CRG_PLL2_STATUS_LOCK_SHIFT (13U)
#define CRG_PLL2_STATUS_LOCK_LOST_MASK (0x1000U)
#define CRG_PLL2_STATUS_LOCK_LOST_SHIFT (12U)
#define CRG_PLL2_STATUS_STATUS_MASK (0xfffU)
#define CRG_PLL2_STATUS_STATUS_SHIFT (0U)




typedef uint16_t CRG_SCRATCH_REG_TYPE;
#define CRG_SCRATCH_REG_SCRATCH_MASK (0xffffU)
#define CRG_SCRATCH_REG_SCRATCH_SHIFT (0U)




typedef volatile struct COMP_PACKED sCRG_RDBType {
    CRG_XTAL_CONFIG_TYPE xtal_config; /* OFFSET: 0x0 */
    CRG_PLL_CONFIG1_TYPE pll_config1; /* OFFSET: 0x2 */
    CRG_PLL_CONFIG2_TYPE pll_config2; /* OFFSET: 0x4 */
    CRG_PLL_NDIV_TYPE pll_ndiv; /* OFFSET: 0x6 */
    CRG_PLL_CTRL0_TYPE pll_ctrl0; /* OFFSET: 0x8 */
    CRG_PLL_CTRL1_TYPE pll_ctrl1; /* OFFSET: 0xa */
    CRG_PLL_CTRL2_TYPE pll_ctrl2; /* OFFSET: 0xc */
    CRG_PLL_CTRL3_TYPE pll_ctrl3; /* OFFSET: 0xe */
    CRG_PLL_MDIV_CH01_TYPE pll_mdiv_ch01; /* OFFSET: 0x10 */
    CRG_PLL_MDIV_CH23_TYPE pll_mdiv_ch23; /* OFFSET: 0x12 */
    CRG_PLL_SSC_CONFIG1_TYPE pll_ssc_config1; /* OFFSET: 0x14 */
    CRG_PLL_SSC_CONFIG2_TYPE pll_ssc_config2; /* OFFSET: 0x16 */
    CRG_PLL_SSC_STEP_TYPE pll_ssc_step; /* OFFSET: 0x18 */
    CRG_PLL_STATUS_TYPE pll_status; /* OFFSET: 0x1a */
    CRG_CLOCK_CONFIG1_TYPE clock_config1; /* OFFSET: 0x1c */
    CRG_CLOCK_CONFIG2_TYPE clock_config2; /* OFFSET: 0x1e */
    CRG_IDDQ_CHIP_TYPE iddq_chip; /* OFFSET: 0x20 */
    CRG_IDDQ_CONFIG_TYPE iddq_config; /* OFFSET: 0x22 */
    CRG_RESET_CONFIG_TYPE reset_config; /* OFFSET: 0x24 */
    CRG_RESET_CONFIG2_TYPE reset_config2; /* OFFSET: 0x26 */
    CRG_XTAL_CONFIG_CML50_TYPE xtal_config_cml50; /* OFFSET: 0x28 */
    CRG_RESERVED_TYPE rsvd0[22]; /* OFFSET: 0x2a */
    CRG_SM_CTRL_TYPE sm_ctrl; /* OFFSET: 0x40 */
    CRG_SM_FAULT_CTRL_TYPE sm_fault_ctrl; /* OFFSET: 0x42 */
    CRG_SM_CLR_LOG_TYPE sm_clr_log; /* OFFSET: 0x44 */
    CRG_SM_TIM_CTRL_TYPE sm_tim_ctrl; /* OFFSET: 0x46 */
    CRG_SM_TIM_VAL_TYPE sm_tim_val; /* OFFSET: 0x48 */
    CRG_SM_TIM_EVT_CLR_TYPE sm_tim_evt_clr; /* OFFSET: 0x4a */
    CRG_SM_SW_TRIGGER_TYPE sm_sw_trigger; /* OFFSET: 0x4c */
    CRG_SM_SW_REASON_TYPE sm_sw_reason; /* OFFSET: 0x4e */
    CRG_SM_CNT_64US_LO_TYPE sm_cnt_64us_lo; /* OFFSET: 0x50 */
    CRG_SM_CNT_64US_HI_TYPE sm_cnt_64us_hi; /* OFFSET: 0x52 */
    CRG_SM_STATUS_TYPE sm_status; /* OFFSET: 0x54 */
    CRG_SM_RAW_LOG_LO_TYPE sm_raw_log_lo; /* OFFSET: 0x56 */
    CRG_SM_RAW_LOG_HI_TYPE sm_raw_log_hi; /* OFFSET: 0x58 */
    CRG_SM_FAULT_LOG_TYPE sm_fault_log; /* OFFSET: 0x5a */
    CRG_RESERVED_TYPE rsvd1[36]; /* OFFSET: 0x5c */
    CRG_RCOSC_LFO_CTRL_TYPE rcosc_lfo_ctrl; /* OFFSET: 0x80 */
    CRG_RCOSC_LFO_CAL_TYPE rcosc_lfo_cal; /* OFFSET: 0x82 */
    CRG_RCOSC_LFO_CTRL2_TYPE rcosc_lfo_ctrl2; /* OFFSET: 0x84 */
    CRG_RCOSC_STATUS_TYPE rcosc_status; /* OFFSET: 0x86 */
    CRG_RESERVED_TYPE rsvd2[8]; /* OFFSET: 0x88 */
    CRG_PLL2_CONFIG1_TYPE pll2_config1; /* OFFSET: 0x90 */
    CRG_PLL2_CONFIG2_TYPE pll2_config2; /* OFFSET: 0x92 */
    CRG_PLL2_NDIV_TYPE pll2_ndiv; /* OFFSET: 0x94 */
    CRG_PLL2_CTRL0_TYPE pll2_ctrl0; /* OFFSET: 0x96 */
    CRG_PLL2_CTRL1_TYPE pll2_ctrl1; /* OFFSET: 0x98 */
    CRG_PLL2_CTRL2_TYPE pll2_ctrl2; /* OFFSET: 0x9a */
    CRG_PLL2_CTRL3_TYPE pll2_ctrl3; /* OFFSET: 0x9c */
    CRG_PLL2_MDIV_CH01_TYPE pll2_mdiv_ch01; /* OFFSET: 0x9e */
    CRG_PLL2_MDIV_CH23_TYPE pll2_mdiv_ch23; /* OFFSET: 0xa0 */
    CRG_PLL2_SSC_CONFIG1_TYPE pll2_ssc_config1; /* OFFSET: 0xa2 */
    CRG_PLL2_SSC_CONFIG2_TYPE pll2_ssc_config2; /* OFFSET: 0xa4 */
    CRG_PLL2_SSC_STEP_TYPE pll2_ssc_step; /* OFFSET: 0xa6 */
    CRG_PLL2_STATUS_TYPE pll2_status; /* OFFSET: 0xa8 */
    CRG_RESERVED_TYPE rsvd3[3924]; /* OFFSET: 0xaa */
    CRG_SCRATCH_REG_TYPE scratch_reg; /* OFFSET: 0xffe */
} CRG_RDBType;


#define CRG_BASE                        (0x4A820000UL)



#define CRG_MAX_HW_ID                   (1UL)

#endif /* CRG_RDB_H */
