/*****************************************************************************
 Copyright 2016-2022 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_eth_xcvrdrv_brphy_impl BRPHY Driver
    @ingroup grp_eth_xcvrdrv

    @addtogroup grp_eth_xcvrdrv_brphy_impl
    @{

    @file brphy_v2.c
    @brief This file implements BRPHY driver of Ethernet driver.

    @version 1.26 Imported from docx
*/

#include <brphy_common.h>
#include <brphy_cl45ven_rdb.h>
#include <brphy_cl45dev1_rdb.h>
#include <brphy_cl45dev7_rdb.h>
#include <brphy_eoc_rdb.h>
#include <brphy_afe_rdb.h>
#include <brphy_core_rdb.h>
#include <brphy_dsp_rdb.h>

/**
    @name BRPHY driver Design IDs
    @{
    @brief Design IDs for BRPHY driver
*/
#define BRCM_SWDSGN_BRPHY_GETMASTERMODE_PROC            (0xB901U)  /**< @brief #BRPHY_GetMasterMode         */
#define BRCM_SWDSGN_BRPHY_SETMASTERMODE_PROC            (0xB902U)  /**< @brief #BRPHY_SetMasterMode         */
#define BRCM_SWDSGN_BRPHY_SETMODE_PROC                  (0xB903U)  /**< @brief #BRPHY_SetMode               */
#define BRCM_SWDSGN_BRPHY_INTSETMASTERMODE_PART_PROC    (0xB904U)  /**< @brief #BRPHY_IntSetMasterMode      */
#define BRCM_SWDSGN_BRPHY_GETLOOPBACKMODE_PROC          (0xB905U)  /**< @brief #BRPHY_GetLoopbackMode       */
#define BRCM_SWDSGN_BRPHY_SETLOOPBACKMODE_PROC          (0xB906U)  /**< @brief #BRPHY_SetLoopbackMode       */
#define BRCM_SWDSGN_BRPHY_CL45VEN_CTRL_REGS_GLOBAL      (0xB907U)  /**< @brief #BRPHY_CL45VEN_CTRL_REGS     */
#define BRCM_SWDSGN_BRPHY_CL45DEV1_CTRL_REGS_GLOBAL     (0xB908U)  /**< @brief #BRPHY_CL45DEV1_CTRL_REGS    */
#define BRCM_SWDSGN_BRPHY_CL45DEV7_CTRL_REGS_GLOBAL     (0xB909U)  /**< @brief #BRPHY_CL45DEV7_CTRL_REGS    */
#define BRCM_SWDSGN_BRPHY_BR_CTRL_REGS_GLOBAL           (0xB90AU)  /**< @brief #BRPHY_BR_CTRL_REGS          */
#define BRCM_SWDSGN_BRPHY_AFE_CTRL_REGS_GLOBAL          (0xB90BU)  /**< @brief #BRPHY_AFE_CTRL_REGS         */
#define BRCM_SWDSGN_BRPHY_CORE_BLK_REGS_GLOBAL          (0xB90CU)  /**< @brief #BRPHY_CORE_BLK_REGS         */
#define BRCM_SWDSGN_BRPHY_DSP_TAP_CTRL_BLK_REGS_GLOBAL  (0xB90DU)  /**< @brief #BRPHY_DSP_TAP_CTRL_BLK_REGS */
#define BRCM_SWDSGN_BRPHY_RWDATA_GLOBAL                 (0xB90EU)  /**< @brief #BRPHY_RWData                */
#define BRCM_SWDSGN_BRPHY_RESTARTAUTONEG_PROC           (0xB90FU)  /**< @brief #BRPHY_RestartAutoNeg        */
#define BRCM_SWDSGN_BRPHY_GETAUTONEGSTATUS_PROC         (0xB910U)  /**< @brief #BRPHY_GetAutoNegStatus      */
#define BRCM_SWDSGN_BRPHY_GETSQIVALUE_PROC              (0xB911U)  /**< @brief #BRPHY_GetSQIValue           */
/** @} */


/**
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL_V2
    @trace #BRCM_SWARCH_BRPHY_FUNCTBL_GLOBAL
*/
    BRPHY_RWDataType BRPHY_RWData[BRPHY_CL45DEV7_MAX_HW_ID] COMP_SECTION(".bss.drivers");

/**
    @brief CL45 VEN block base addresses

    @trace #BRCM_SWARCH_BRPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL_V2
*/
static BRPHY_CL45VEN_RDBType * const BRPHY_CL45VEN_CTRL_REGS[BRPHY_CL45VEN_MAX_HW_ID] =
{
#if (BRPHY_CL45VEN_MAX_HW_ID == 0UL)
#error "BRPHY_CL45VEN_MAX_HW_ID == 0UL"
#endif
    (BRPHY_CL45VEN_RDBType *const)BRPHY0_CL45VEN_CTRL_BASE,
#if (BRPHY_CL45VEN_MAX_HW_ID > 1UL)
    (BRPHY_CL45VEN_RDBType *const)BRPHY1_CL45VEN_CTRL_BASE,
#endif
#if (BRPHY_CL45VEN_MAX_HW_ID > 2UL)
    (BRPHY_CL45VEN_RDBType *const)BRPHY2_CL45VEN_CTRL_BASE,
#endif
#if (BRPHY_CL45VEN_MAX_HW_ID > 3UL)
    (BRPHY_CL45VEN_RDBType *const)BRPHY3_CL45VEN_CTRL_BASE,
#endif
#if (BRPHY_CL45VEN_MAX_HW_ID > 4UL)
    (BRPHY_CL45VEN_RDBType *const)BRPHY4_CL45VEN_CTRL_BASE,
#endif
#if (BRPHY_CL45VEN_MAX_HW_ID > 5UL)
#error "BRPHY_CL45VEN_MAX_HW_ID > 5UL is not supported"
#endif
};

/**
    @brief CL45 DEV1 block base addresses

    @trace #BRCM_SWARCH_BRPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL_V2
*/
static BRPHY_CL45DEV1_RDBType * const BRPHY_CL45DEV1_CTRL_REGS[BRPHY_CL45DEV1_MAX_HW_ID] =
{
#if (BRPHY_CL45DEV1_MAX_HW_ID == 0UL)
#error "BRPHY_CL45DEV1_MAX_HW_ID == 0UL"
#endif
    (BRPHY_CL45DEV1_RDBType *const)BRPHY0_CL45DEV1_CTRL_BASE,
#if (BRPHY_CL45DEV1_MAX_HW_ID > 1UL)
    (BRPHY_CL45DEV1_RDBType *const)BRPHY1_CL45DEV1_CTRL_BASE,
#endif
#if (BRPHY_CL45DEV1_MAX_HW_ID > 2UL)
    (BRPHY_CL45DEV1_RDBType *const)BRPHY2_CL45DEV1_CTRL_BASE,
#endif
#if (BRPHY_CL45DEV1_MAX_HW_ID > 3UL)
    (BRPHY_CL45DEV1_RDBType *const)BRPHY3_CL45DEV1_CTRL_BASE,
#endif
#if (BRPHY_CL45DEV1_MAX_HW_ID > 4UL)
    (BRPHY_CL45DEV1_RDBType *const)BRPHY4_CL45DEV1_CTRL_BASE,
#endif
#if (BRPHY_CL45DEV1_MAX_HW_ID > 5UL)
#error "BRPHY_CL45DEV1_MAX_HW_ID > 5UL is not supported"
#endif
};

/**
    @brief CL45 DEV7 block base addresses

    @trace #BRCM_SWARCH_BRPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL_V2
*/
static BRPHY_CL45DEV7_RDBType * const BRPHY_CL45DEV7_CTRL_REGS[BRPHY_CL45DEV7_MAX_HW_ID] =
{
#if (BRPHY_CL45DEV7_MAX_HW_ID == 0UL)
#error "BRPHY_CL45DEV7_MAX_HW_ID == 0UL"
#endif
    (BRPHY_CL45DEV7_RDBType *const)BRPHY0_CL45DEV7_CTRL_BASE,
#if (BRPHY_CL45DEV7_MAX_HW_ID > 1UL)
    (BRPHY_CL45DEV7_RDBType *const)BRPHY1_CL45DEV7_CTRL_BASE,
#endif
#if (BRPHY_CL45DEV7_MAX_HW_ID > 2UL)
    (BRPHY_CL45DEV7_RDBType *const)BRPHY2_CL45DEV7_CTRL_BASE,
#endif
#if (BRPHY_CL45DEV7_MAX_HW_ID > 3UL)
    (BRPHY_CL45DEV7_RDBType *const)BRPHY3_CL45DEV7_CTRL_BASE,
#endif
#if (BRPHY_CL45DEV7_MAX_HW_ID > 4UL)
    (BRPHY_CL45DEV7_RDBType *const)BRPHY4_CL45DEV7_CTRL_BASE,
#endif
#if (BRPHY_CL45DEV7_MAX_HW_ID > 5UL)
#error "BRPHY_CL45DEV7_MAX_HW_ID > 5UL is not supported"
#endif
};

/**
    @brief BroadReach AFE CTRL base addresses

    @trace #BRCM_SWARCH_BRPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL_V2
*/
static BRPHY_AFE_RDBType * const BRPHY_AFE_CTRL_REGS[BRPHY_AFE_MAX_HW_ID] =
{
#if (BRPHY_AFE_MAX_HW_ID == 0UL)
#error "BRPHY_AFE_MAX_HW_ID == 0UL"
#endif
    (BRPHY_AFE_RDBType *const)BRPHY0_AFE_CTRL_BASE,
#if (BRPHY_AFE_MAX_HW_ID > 1UL)
    (BRPHY_AFE_RDBType *const)BRPHY1_AFE_CTRL_BASE,
#endif
#if (BRPHY_AFE_MAX_HW_ID > 2UL)
    (BRPHY_AFE_RDBType *const)BRPHY2_AFE_CTRL_BASE,
#endif
#if (BRPHY_AFE_MAX_HW_ID > 3UL)
    (BRPHY_AFE_RDBType *const)BRPHY3_AFE_CTRL_BASE,
#endif
#if (BRPHY_AFE_MAX_HW_ID > 4UL)
    (BRPHY_AFE_RDBType *const)BRPHY4_AFE_CTRL_BASE,
#endif
#if (BRPHY_AFE_MAX_HW_ID > 5UL)
#error "BRPHY_AFE_MAX_HW_ID > 5UL is not supported"
#endif
};

/**
    @brief GPHY Core block base addresses

    @trace #BRCM_SWARCH_BRPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL_V2
*/
static BRPHY_CORE_RDBType * const BRPHY_CORE_BLK_REGS[BRPHY_CORE_MAX_HW_ID] =
{
#if (BRPHY_CORE_MAX_HW_ID == 0UL)
#error "BRPHY_CORE_MAX_HW_ID == 0UL"
#endif
    (BRPHY_CORE_RDBType *)BRPHYBLK0_CORE_BASE,
#if (BRPHY_CORE_MAX_HW_ID > 1UL)
    (BRPHY_CORE_RDBType *)BRPHYBLK1_CORE_BASE,
#endif
#if (BRPHY_CORE_MAX_HW_ID > 2UL)
    (BRPHY_CORE_RDBType *)BRPHYBLK2_CORE_BASE,
#endif
#if (BRPHY_CORE_MAX_HW_ID > 3UL)
    (BRPHY_CORE_RDBType *)BRPHYBLK3_CORE_BASE,
#endif
#if (BRPHY_CORE_MAX_HW_ID > 4UL)
    (BRPHY_CORE_RDBType *)BRPHYBLK4_CORE_BASE,
#endif
#if (BRPHY_CORE_MAX_HW_ID > 5UL)
#error "BRPHY_CORE_MAX_HW_ID > 5UL is not supported"
#endif
};

/**
    @brief DSP TAP block base addresses

    @trace #BRCM_SWARCH_BRPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL_V2
*/
static BRPHY_DSP_RDBType * const BRPHY_DSP_TAP_CTRL_BLK_REGS[BRPHY_DSP_MAX_HW_ID] =
{
#if (BRPHY_DSP_MAX_HW_ID == 0UL)
#error "BRPHY_DSP_MAX_HW_ID == 0UL"
#endif
    (BRPHY_DSP_RDBType *)BRPHY0_DSP_TAP_CTRL_BASE,
#if (BRPHY_DSP_MAX_HW_ID > 1UL)
    (BRPHY_DSP_RDBType *)BRPHY1_DSP_TAP_CTRL_BASE,
#endif
#if (BRPHY_DSP_MAX_HW_ID > 2UL)
    (BRPHY_DSP_RDBType *)BRPHY2_DSP_TAP_CTRL_BASE,
#endif
#if (BRPHY_DSP_MAX_HW_ID > 3UL)
    (BRPHY_DSP_RDBType *)BRPHY3_DSP_TAP_CTRL_BASE,
#endif
#if (BRPHY_DSP_MAX_HW_ID > 4UL)
    (BRPHY_DSP_RDBType *)BRPHY4_DSP_TAP_CTRL_BASE,
#endif
#if (BRPHY_DSP_MAX_HW_ID > 5UL)
#error "BRPHY_DSP_MAX_HW_ID > 5UL is not supported"
#endif
};

/**
    @brief BroadReach block base addresses

    @trace #BRCM_SWARCH_BRPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL_V2
*/
static BRPHY_EOC_RDBType * const BRPHY_BR_CTRL_REGS[BRPHY_EOC_MAX_HW_ID] =
{
#if (BRPHY_EOC_MAX_HW_ID == 0UL)
#error "BRPHY_EOC_MAX_HW_ID == 0UL"
#endif
    (BRPHY_EOC_RDBType *const)BRPHY0_BR_EOC_CTRL_BASE,
#if (BRPHY_EOC_MAX_HW_ID > 1UL)
    (BRPHY_EOC_RDBType *const)BRPHY1_BR_EOC_CTRL_BASE,
#endif
#if (BRPHY_EOC_MAX_HW_ID > 2UL)
    (BRPHY_EOC_RDBType *const)BRPHY2_BR_EOC_CTRL_BASE,
#endif
#if (BRPHY_EOC_MAX_HW_ID > 3UL)
    (BRPHY_EOC_RDBType *const)BRPHY3_BR_EOC_CTRL_BASE,
#endif
#if (BRPHY_EOC_MAX_HW_ID > 4UL)
    (BRPHY_EOC_RDBType *const)BRPHY4_BR_EOC_CTRL_BASE,
#endif
#if (BRPHY_EOC_MAX_HW_ID > 5UL)
#error "BRPHY_EOC_MAX_HW_ID > 5UL is not supported"
#endif
};

/**
    @trace #BRCM_SWARCH_BRPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL_V2
*/
static void BRPHY_IntSetMasterMode(uint8_t aPhyIdx,
                                   ETHXCVR_BooleanType aMasterMode)
{
    if (ETHXCVR_BOOLEAN_TRUE == aMasterMode) {
        BRPHY_CL45DEV1_CTRL_REGS[aPhyIdx]->ctl_t1 = (BRPHY_CL45DEV1_PMD_IEEE_CTL_T1_PMD_IEEE_CTL_T1_BIT_15_MASK |
                                                      BRPHY_CL45DEV1_PMD_IEEE_CTL_T1_MS_MAN_CFG_VAL_MASK);
    } else {
        BRPHY_CL45DEV1_CTRL_REGS[aPhyIdx]->ctl_t1 = BRPHY_CL45DEV1_PMD_IEEE_CTL_T1_PMD_IEEE_CTL_T1_BIT_15_MASK;
    }
}

/**
    @trace #BRCM_SWARCH_BRPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL_V2
*/
int32_t BRPHY_SetMode(uint8_t aPhyIdx,
                      ETHXCVR_CntxtType *const aPhyCntxt,
                      const ETHXCVR_PortConfigType *const aConfig,
                      ETHXCVR_ModeType aMode)
{
    int32_t retVal = BCM_ERR_OK;

    if (BRPHY_CL45DEV7_MAX_HW_ID <= aPhyIdx) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (ETHXCVR_STATE_INIT != BRPHY_RWData[aPhyIdx].state) {
        retVal = BCM_ERR_UNINIT;
    } else {
        retVal = BRPHY_CommonSetMode(aPhyIdx, aPhyCntxt, aConfig, aMode);
        if (BCM_ERR_OK == retVal) {
            if(ETHXCVR_MODE_ACTIVE == aMode) {
                if (ETHXCVR_PHYMEDIA_100BASET1 == aConfig->phy.phyMedia) {
                    if (ETHXCVR_BOOLEAN_TRUE == aConfig->autoNeg) {
                        BRPHY_CL45DEV7_CTRL_REGS[aPhyIdx]->baset1_an_advertisement_reg1 = (BRPHY_CL45DEV7_B1AAR1_ADVERISE_100BASE_T1_MASK |
                                                                                           (aConfig->phy.masterMode * BRPHY_CL45DEV7_B1AAR1_MASTER_SLAVE_MASK));
                        BRPHY_CL45DEV7_CTRL_REGS[aPhyIdx]->baset1_an_advertisement_reg0 = (BRPHY_CL45DEV7_B1AAR0_SELECTOR_FIELD_VALUE & BRPHY_CL45DEV7_B1AAR0_SELECTOR_FIELD_MASK);
                        BRPHY_CL45DEV7_CTRL_REGS[aPhyIdx]->autoneg_baset1_an_control = (BRPHY_CL45DEV7_AB1AC_AUTONEG_ENABLE_MASK |
                                                                                        BRPHY_CL45DEV7_AB1AC_RESTART_AUTO_NEGOTIATION_MASK);
                    } else {
                        BRPHY_IntSetMasterMode(aPhyIdx, aConfig->phy.masterMode);
                        BRPHY_CL45DEV7_CTRL_REGS[aPhyIdx]->autoneg_baset1_an_control = BRPHY_CL45DEV7_AB1AC_RESTART_AUTO_NEGOTIATION_MASK;
                    }
#if (ENABLE_BRPHY_TX_EDGE_GAMMA == 1UL)
                    /* SPECIAL REGISTER WRITE TO CHANGE TX BW ==== BRPHY AFE
                     * TX bandwidth change to 33MHz
                     */
                    /* (bits 15:11 = TX_BW_TUNE = 01110) */
                    BRPHY_AFE_CTRL_REGS[aPhyIdx]->tx_config_1 = (BRPHY_AFE_CTRL_TX_BW_TUNE << BRPHY_AFE_TX_CONFIG_1_BW_TUNE_SHIFT);

                    /* Edge Rate ==== BRPHY Edge Rate to slowest setting
                     */
                    /* (bits 12:11 = BR EDGE RATE SEL = 11) */
                    BRPHY_BR_CTRL_REGS[aPhyIdx]->exp92 = BRPHY_AFE_CTRL_EXP92_CONST;

                    /* Gamma 1/8 ==== BRPHY DSP Gamma to 1/8 setting
                     */
                    /* (bit 11 = SM DSP CLK EN = 1) */
                    BRPHY_CORE_BLK_REGS[aPhyIdx]->shd18_000 = (BRPHY_CORE_SHD18_000_SM_DSP_CLK_EN_MASK
                                                               | BRPHY_CORE_SHD18_000_TX_6DB_CODING_MASK
                                                               | BRPHY_CORE_SHD18_000_EDGERATE_CTL_100TX_MASK);

                    /* (bits 10:9 = FFE GAMMA OV = 01) */
                    BRPHY_DSP_TAP_CTRL_BLK_REGS[aPhyIdx]->tap10 = BRPHY_DSP_TAP10_CONST;
#endif
                } else {
                    /* ETHXCVR_PHYMEDIA_100BASETX busmode*/
                    /* only port 4 is allowed in BR/100-TX mode */
                    /* Disable BRPHY mode */
                    BRPHY_BR_CTRL_REGS[aPhyIdx]->exp90 = 0x0U;
                    /* Set autoneg parameters for 100-TX */
                    BRPHY_CL45DEV7_CTRL_REGS[aPhyIdx]->an_ad = (BRPHY_CL45DEV7_AN_AD_LD_REMOTE_FAULT_MASK |
                                                               (BRPHY_CL45DEV7_AN_AD_LD_ASYMMETRIC_PAUSE_MASK) |
                                                               (BRPHY_CL45DEV7_AN_AD_LD_PAUSE_CAPABLE_MASK) |
                                                               (BRPHY_CL45DEV7_AN_AD_LD_100BASE_TX_FULL_DUPLEX_CAPABLE_MASK) |
                                                               (BRPHY_CL45DEV7_AN_AD_LD_100BASE_TX_HALF_DUPLEX_CAPABLE_MASK) |
                                                               (BRPHY_CL45DEV7_AN_AD_LD_10BASE_T_FULL_DUPLEX_CAPABLE_MASK) |
                                                               (BRPHY_CL45DEV7_AN_AD_LD_10BASE_T_HALF_DUPLEX_CAPABLE_MASK) |
                                                               (BRPHY_CL45DEV7_AN_AD_LD_PROTOCOL_SELECTOR_VALUE <<            BRPHY_CL45DEV7_AN_AD_LD_PROTOCOL_SELECTOR_SHIFT));
                    /* Restart auto-negotiation */
                    BRPHY_CL45DEV7_CTRL_REGS[aPhyIdx]->an_ctrl = (BRPHY_CL45DEV7_AN_CTRL_AUTO_NEGOTIATION_ENABLE_MASK |
                                                                  BRPHY_CL45DEV7_AN_CTRL_RESTART_AUTO_NEGOTIATION_MASK);
                }
            }
        }
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_BRPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL_V2
*/
int32_t BRPHY_SetMasterMode(uint8_t aPhyIdx,
                            ETHXCVR_CntxtType *const aPhyCntxt,
                            const ETHXCVR_PortConfigType *const aConfig,
                            ETHXCVR_BooleanType aMasterMode)
{
    int32_t retVal = BCM_ERR_OK;

    if (BRPHY_CL45DEV7_MAX_HW_ID <= aPhyIdx) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (ETHXCVR_STATE_INIT != BRPHY_RWData[aPhyIdx].state) {
        retVal = BCM_ERR_UNINIT;
    } else {
        BRPHY_IntSetMasterMode(aPhyIdx, aMasterMode);
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_BRPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL_V2
*/
int32_t BRPHY_GetMasterMode(uint8_t aPhyIdx,
                            ETHXCVR_CntxtType *const aPhyCntxt,
                            const ETHXCVR_PortConfigType *const aConfig,
                            ETHXCVR_BooleanType *const aMasterMode)
{
    int32_t retVal = BCM_ERR_OK;

    if ((BRPHY_CL45DEV7_MAX_HW_ID <= aPhyIdx) || (NULL == aMasterMode)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (ETHXCVR_STATE_INIT != BRPHY_RWData[aPhyIdx].state) {
        retVal = BCM_ERR_UNINIT;
    } else {
        if (ETHXCVR_BOOLEAN_TRUE == aConfig->autoNeg) {
            if ((BRPHY_CL45VEN_CTRL_REGS[aPhyIdx]->autoneg_test_reg2
                    & BRPHY_CL45VEN_ATR2_MASTER_SLAVE_MASK)
                == BRPHY_CL45VEN_ATR2_MASTER_SLAVE_MASK) {
                *aMasterMode = ETHXCVR_BOOLEAN_TRUE;
            } else {
                *aMasterMode = ETHXCVR_BOOLEAN_FALSE;
            }
        } else {
            if ((BRPHY_CL45DEV1_CTRL_REGS[aPhyIdx]->ctl_t1
                    & BRPHY_CL45DEV1_PMD_IEEE_CTL_T1_MS_MAN_CFG_VAL_MASK)
                == BRPHY_CL45DEV1_PMD_IEEE_CTL_T1_MS_MAN_CFG_VAL_MASK) {
                *aMasterMode = ETHXCVR_BOOLEAN_TRUE;
            } else {
                *aMasterMode = ETHXCVR_BOOLEAN_FALSE;
            }
        }
    }
    return retVal;
}


/**
    @trace #BRCM_SWARCH_BRPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL_V2
*/
int32_t BRPHY_SetLoopbackMode(uint8_t aPhyIdx,
                              ETHXCVR_CntxtType *const aPhyCntxt,
                              const ETHXCVR_PortConfigType *const aConfig,
                              ETHXCVR_BooleanType aMode)
{
    int32_t retVal = BCM_ERR_OK;

    if (BRPHY_CL45DEV7_MAX_HW_ID <= aPhyIdx) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (ETHXCVR_STATE_INIT != BRPHY_RWData[aPhyIdx].state) {
        retVal = BCM_ERR_UNINIT;
    } else {
        if (ETHXCVR_BOOLEAN_TRUE == aMode) {
            BRPHY_CL45DEV1_CTRL_REGS[aPhyIdx]->ctl1 |= BRPHY_CL45DEV1_PMD_IEEE_CTL1_LPBK_MASK;
        } else if (ETHXCVR_BOOLEAN_FALSE == aMode) {
            BRPHY_CL45DEV1_CTRL_REGS[aPhyIdx]->ctl1 &= ~BRPHY_CL45DEV1_PMD_IEEE_CTL1_LPBK_MASK;
        } else {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_BRPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL_V2
*/
int32_t BRPHY_GetLoopbackMode(uint8_t aPhyIdx,
                              ETHXCVR_CntxtType *const aPhyCntxt,
                              const ETHXCVR_PortConfigType *const aConfig,
                              ETHXCVR_BooleanType *const aMode)
{
    int32_t retVal = BCM_ERR_OK;

    if ((BRPHY_CL45DEV7_MAX_HW_ID <= aPhyIdx) || (NULL == aMode)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (ETHXCVR_STATE_INIT != BRPHY_RWData[aPhyIdx].state) {
        retVal = BCM_ERR_UNINIT;
    } else {
        if ((BRPHY_CL45DEV1_CTRL_REGS[aPhyIdx]->ctl1
            & BRPHY_CL45DEV1_PMD_IEEE_CTL1_LPBK_MASK)
            == BRPHY_CL45DEV1_PMD_IEEE_CTL1_LPBK_MASK) {
            *aMode = ETHXCVR_BOOLEAN_TRUE;
        } else {
            *aMode = ETHXCVR_BOOLEAN_FALSE;
        }
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_BRPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL_V2
*/
int32_t BRPHY_RestartAutoNeg(uint8_t aPhyIdx,
                             ETHXCVR_CntxtType *const aPhyCntxt,
                             const ETHXCVR_PortConfigType *const aConfig)
{
    int32_t retVal = BCM_ERR_OK;

    if (BRPHY_CL45DEV7_MAX_HW_ID <= aPhyIdx) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (ETHXCVR_STATE_INIT != BRPHY_RWData[aPhyIdx].state) {
        retVal = BCM_ERR_UNINIT;
    } else {
        BRPHY_CL45DEV7_CTRL_REGS[aPhyIdx]->autoneg_baset1_an_control |= BRPHY_CL45DEV7_AB1AC_RESTART_AUTO_NEGOTIATION_MASK;
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_BRPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL_V2
*/
int32_t BRPHY_GetAutoNegStatus(uint8_t aPhyIdx,
                               ETHXCVR_CntxtType *const aPhyCntxt,
                               const ETHXCVR_PortConfigType *const aConfig,
                               ETHXCVR_AutoNegStatusType *const aStatus)
{
    int32_t retVal = BCM_ERR_OK;

    if ((BRPHY_CL45DEV7_MAX_HW_ID <= aPhyIdx) || (NULL == aStatus)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (ETHXCVR_STATE_INIT != BRPHY_RWData[aPhyIdx].state) {
        retVal = BCM_ERR_UNINIT;
    } else {
        if (0U == (BRPHY_CL45DEV7_CTRL_REGS[aPhyIdx]->autoneg_baset1_an_status & BRPHY_CL45DEV7_AUTONEG_BASET1_AN_STATUS_AUTONEG_ABILITY_MASK)) {
            *aStatus = ETHXCVR_AUTONEGSTATUS_NO_ABILITY;
        } else if (0U == (BRPHY_CL45DEV7_CTRL_REGS[aPhyIdx]->autoneg_baset1_an_status & BRPHY_CL45DEV7_AUTONEG_BASET1_AN_STATUS_AUTONEG_COMPLETE_MASK)) {
            *aStatus = ETHXCVR_AUTONEGSTATUS_INCOMPLETE;
        } else {
            *aStatus = ETHXCVR_AUTONEGSTATUS_COMPLETE;
        }
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_BRPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL_V2
*/
int32_t BRPHY_GetSQIValue(uint8_t aPhyIdx,
                          ETHXCVR_CntxtType *const aPhyCntxt,
                          const ETHXCVR_PortConfigType *const aConfig,
                          uint32_t *const aSQIValue)
{
    int32_t retVal = BCM_ERR_OK;

    if (BRPHY_CORE_MAX_HW_ID <= aPhyIdx) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        BRPHY_CORE_BLK_REGS[aPhyIdx]->shd18_000 |= BRPHY_CORE_SHD18_000_SM_DSP_CLK_EN_MASK;
        *aSQIValue = (BRPHY_DSP_TAP_CTRL_BLK_REGS[aPhyIdx]->tc1_dcq_sqi &
                BRPHY_DSP_TC1_DCQ_SQI_SQI_MASK) >> BRPHY_DSP_TC1_DCQ_SQI_SQI_SHIFT;
    }

    return retVal;
}

/** @} */
