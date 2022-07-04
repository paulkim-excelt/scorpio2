/*****************************************************************************
 Copyright 2020-2022 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_eth_xcvrdrv_sgmii_impl SGMII Driver
    @ingroup grp_eth_xcvrdrv

    @addtogroup grp_eth_xcvrdrv_sgmii_impl
    @{

    @file sgmii_v2.c
    @brief This file implements SGMII driver of Ethernet driver.

    @version 0.1 Initial version
*/

#include <sgmiipcie_usercl22_rdb.h>
#include <sgmiipcie_ctrl_rdb.h>
#include <sgmiipcie_digital_rdb.h>
#include <sgmiipcie_digital5_rdb.h>
#if defined(__BCM8957X__)
#include <sgmiipcie_cl22_rdb.h>
#endif
#include <sgmii_common.h>
#include <sgmii_ctrl_rdb.h>
#include <sgmii_digital_rdb.h>
#include <sgmii_digital5_rdb.h>
#include <xgxsblk0_rdb.h>
#include <sgmii_usercl22_rdb.h>
/**
    @name SGMII driver Design IDs
    @{
    @brief Design IDs for SGMII driver
*/

#define BRCM_SWDSGN_SGMII_SETSPEED_PROC             (0xB801U)    /**< @brief #SGMII_SetSpeed        */
#define BRCM_SWDSGN_SGMII_GETMODE_PROC              (0xB802U)    /**< @brief #SGMII_GetMode         */
#define BRCM_SWDSGN_SGMII_SETMODE_PROC              (0xB803U)    /**< @brief #SGMII_SetMode         */
#define BRCM_SWDSGN_SGMII_RWDATA_GLOBAL             (0xB804U)    /**< @brief #SGMII_RWData          */
#define BRCM_SWDSGN_SGMII_CTRL_REGS_GLOBAL          (0xB805U)    /**< @brief #SGMII_CTRL_REGS       */
#define BRCM_SWDSGN_SGMII_DIGITAL5_REG_GLOBAL       (0xB806U)    /**< @brief #SGMII_DIGITAL5_REG    */
#define BRCM_SWDSGN_SGMII_DIGITAL_REG_GLOBAL        (0xB807U)    /**< @brief #SGMII_DIGITAL_REG     */
#define BRCM_SWDSGN_SGMII_XGXS_BLOCK0_REG_GLOBAL    (0xB808U)    /**< @brief #SGMII_XGXS_BLOCK0_REG */
#define BRCM_SWDSGN_SGMII_USER_CL22_REG_GLOBAL      (0xB809U)    /**< @brief #SGMII_USER_CL22_REG   */
/** @} */

/**
    @trace #BRCM_SWARCH_SGMII_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMII_FUNCTBL_V2
*/
SGMII_RWDataType SGMII_RWData[SGMII_MAX_HW_ID] COMP_SECTION(".bss.drivers");

/**
    @brief SG0_CTRL control & status base addresses

    @trace #BRCM_SWARCH_SGMII_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMII_FUNCTBL_V2
*/
static SGMII_CTRL_RDBType * const SGMII_CTRL_REGS[SGMII_MAX_HW_ID] =
{
#if (SGMII_MAX_HW_ID == 0UL)
#error "SGMII_MAX_HW_ID == 0UL"
#endif
    (SGMII_CTRL_RDBType *const)SGMII0_CTRL_BASE,
#if (SGMII_MAX_HW_ID > 1UL)
    (SGMII_CTRL_RDBType *const)SGMII1_CTRL_BASE,
#endif
#if (SGMII_MAX_HW_ID > 2UL)
    (SGMII_CTRL_RDBType *const)SGMII2_CTRL_BASE,
#endif
#if (SGMII_MAX_HW_ID > 3UL)
    (SGMII_CTRL_RDBType *const)SGMII3_CTRL_BASE,
#endif
#if (SGMII_MAX_HW_ID > 4UL)
    (SGMII_CTRL_RDBType *const)SGMII4_CTRL_BASE,
#endif
#if (SGMII_MAX_HW_ID > 5UL)
#error "SGMII_MAX_HW_ID > 5UL is not supported"
#endif
};

/**
    @brief SGMII digital block base addresses

    @trace #BRCM_SWARCH_SGMII_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMII_FUNCTBL_V2
*/
static SGMII_DIGITAL_RDBType * const SGMII_DIGITAL_REG[SGMII_MAX_HW_ID] =
{
#if (SGMII_MAX_HW_ID == 0UL)
#error "SGMII_MAX_HW_ID == 0UL"
#endif
    (SGMII_DIGITAL_RDBType *const)SGMII0_DIGITAL_BASE,
#if (SGMII_MAX_HW_ID > 1UL)
    (SGMII_DIGITAL_RDBType *const)SGMII1_DIGITAL_BASE,
#endif
#if (SGMII_MAX_HW_ID > 2UL)
    (SGMII_DIGITAL_RDBType *const)SGMII2_DIGITAL_BASE,
#endif
#if (SGMII_MAX_HW_ID > 3UL)
    (SGMII_DIGITAL_RDBType *const)SGMII3_DIGITAL_BASE,
#endif
#if (SGMII_MAX_HW_ID > 4UL)
    (SGMII_DIGITAL_RDBType *const)SGMII4_DIGITAL_BASE,
#endif
#if (SGMII_MAX_HW_ID > 5UL)
#error "SGMII_MAX_HW_ID > 5UL is not supported"
#endif
};

/**
    @brief SGMII digital5 block base addresses

    @trace #BRCM_SWARCH_SGMII_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMII_FUNCTBL_V2
*/
static SGMII_DIGITAL5_RDBType * const SGMII_DIGITAL5_REG[SGMII_MAX_HW_ID] =
{
#if (SGMII_MAX_HW_ID == 0UL)
#error "SGMII_MAX_HW_ID == 0UL"
#endif
    (SGMII_DIGITAL5_RDBType *const)SGMII0_DIGITAL5_BASE,
#if (SGMII_MAX_HW_ID > 1UL)
    (SGMII_DIGITAL5_RDBType *const)SGMII1_DIGITAL5_BASE,
#endif
#if (SGMII_MAX_HW_ID > 2UL)
    (SGMII_DIGITAL5_RDBType *const)SGMII2_DIGITAL5_BASE,
#endif
#if (SGMII_MAX_HW_ID > 3UL)
    (SGMII_DIGITAL5_RDBType *const)SGMII3_DIGITAL5_BASE,
#endif
#if (SGMII_MAX_HW_ID > 4UL)
    (SGMII_DIGITAL5_RDBType *const)SGMII4_DIGITAL5_BASE,
#endif
#if (SGMII_MAX_HW_ID > 5UL)
#error "SGMII_MAX_HW_ID > 5UL is not supported"
#endif
};

/**
    @brief SGMII user cl22 block base addresses

    @trace #BRCM_SWARCH_SGMII_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMII_FUNCTBL_V2
*/
static SGMII_USERCL22_RDBType * const SGMII_USER_CL22_REG[SGMII_MAX_HW_ID] =
{
#if (SGMII_MAX_HW_ID == 0UL)
#error "SGMII_MAX_HW_ID == 0UL"
#endif
    (SGMII_USERCL22_RDBType *const)SGMII0_USERCL22_BASE,
#if (SGMII_MAX_HW_ID > 1UL)
    (SGMII_USERCL22_RDBType *const)SGMII1_USERCL22_BASE,
#endif
#if (SGMII_MAX_HW_ID > 2UL)
    (SGMII_USERCL22_RDBType *const)SGMII2_USERCL22_BASE,
#endif
#if (SGMII_MAX_HW_ID > 3UL)
    (SGMII_USERCL22_RDBType *const)SGMII3_USERCL22_BASE,
#endif
#if (SGMII_MAX_HW_ID > 4UL)
    (SGMII_USERCL22_RDBType *const)SGMII4_USERCL22_BASE,
#endif
#if (SGMII_MAX_HW_ID > 5UL)
#error "SGMII_MAX_HW_ID > 5UL is not supported"
#endif
};

/**
    @brief SGMII XGXS block0 base addresses

    @trace #BRCM_SWARCH_SGMII_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMII_FUNCTBL_V2
*/
static XGXSBLK0_RDBType * const SGMII_XGXS_BLOCK0_REG = (XGXSBLK0_RDBType *)BLK0_BASE;

/**
    @trace #BRCM_SWARCH_SGMII_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMII_FUNCTBL_V2
*/
int32_t SGMII_SetSpeed(uint8_t aBusIdx,
                        ETHXCVR_CntxtType *const aCntxt,
                        const ETHXCVR_PortConfigType *const aConfig,
                        ETHXCVR_SpeedType aSpeed)
{
    int32_t retVal = BCM_ERR_OK;

    if (SGMII_MAX_HW_ID <= aBusIdx) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (ETHXCVR_STATE_INIT != SGMII_RWData[aBusIdx].state) {
        retVal = BCM_ERR_UNINIT;
    } else {
            switch (aConfig->speed) {
            case ETHXCVR_SPEED_100MBPS:
                SGMII_DIGITAL5_REG[aBusIdx]->misc8         = SGMII_DIGITAL5_FORCE_OSCDR_MODE_OSX5;
                SGMII_DIGITAL_REG[aBusIdx]->control1000x1  = 0U;
                if(ETHXCVR_PHYMEDIA_NONE == aConfig->phy.phyMedia) {
                    /* SGx_CL22_B0_MIICntl: full-duplex, autoneg Disabled, 100M */
                    SGMII_CL22_IEEE_REG[aBusIdx]->miicntl      = (SGMII_COMBO_MIICNTL_FULL_DUPLEX_MASK | SGMII_COMBO_MIICNTL_MANUAL_SPEED0_MASK);
                    SGMII_USER_CL22_REG[aBusIdx]->miicntl      = (SGMII_USERCL22_MIICNTL_DUPLEX_MASK | SGMII_USERCL22_MIICNTL_MANUAL_SPEED0_MASK);
                } else {
                    /* SGx_CL22_B0_MIICntl: full-duplex, autoneg enabled, 100M */
                    SGMII_CL22_IEEE_REG[aBusIdx]->miicntl      = (SGMII_COMBO_MIICNTL_FULL_DUPLEX_MASK | SGMII_COMBO_MIICNTL_AUTONEG_ENABLE_MASK);
                    SGMII_USER_CL22_REG[aBusIdx]->miicntl      = (SGMII_USERCL22_MIICNTL_DUPLEX_MASK | SGMII_USERCL22_MIICNTL_AUTONEG_ENABLE_MASK);
                }
                break;
            case ETHXCVR_SPEED_1000MBPS:
                SGMII_DIGITAL5_REG[aBusIdx]->misc8          = SGMII_DIGITAL5_FORCE_OSCDR_MODE_OSX5;
                SGMII_DIGITAL_REG[aBusIdx]->control1000x1   = 0U;
                if (ETHXCVR_BOOLEAN_TRUE == aConfig->autoNeg) {
                    SGMII_CL22_IEEE_REG[aBusIdx]->miicntl   = (SGMII_COMBO_MIICNTL_FULL_DUPLEX_MASK |
                                                               SGMII_COMBO_MIICNTL_MANUAL_SPEED1_MASK |
                                                               SGMII_COMBO_MIICNTL_AUTONEG_ENABLE_MASK);
                } else {
                    SGMII_CL22_IEEE_REG[aBusIdx]->miicntl   = (SGMII_COMBO_MIICNTL_FULL_DUPLEX_MASK | SGMII_COMBO_MIICNTL_MANUAL_SPEED1_MASK);
                }
                break;
            case ETHXCVR_SPEED_2500MBPS:
            case ETHXCVR_SPEED_5000MBPS:
                SGMII_DIGITAL_REG[aBusIdx]->blockaddress   = SGMII_DIGITAL_BLOCK_ADDRESS_VALUE;
                SGMII_DIGITAL_REG[aBusIdx]->control1000x1  = (SGMII_DIGITAL_CONTROL1000X1_COMMA_DET_EN_MASK |
                                                              SGMII_DIGITAL_CONTROL1000X1_CRC_CHECKER_DISABLE_MASK);
                if (ETHXCVR_SPEED_2500MBPS == aConfig->speed) {
                    SGMII_DIGITAL_REG[aBusIdx]->misc1      = SGMII_DIGITAL_MISC1_FORCE_SPEED_2500M;
                } else {
                    SGMII_DIGITAL_REG[aBusIdx]->misc1      = SGMII_DIGITAL_MISC1_FORCE_SPEED_5000M;
                }
                SGMII_DIGITAL5_REG[aBusIdx]->blockaddress  = SGMII_DIGITAL5_BLOCK_ADDRESS_VALUE;
                if (ETHXCVR_SPEED_2500MBPS == aConfig->speed) {
                    SGMII_DIGITAL5_REG[aBusIdx]->misc8     = SGMII_DIGITAL5_FORCE_OSCDR_MODE_OSX2;
                } else {
                    SGMII_DIGITAL5_REG[aBusIdx]->misc8     = SGMII_DIGITAL5_FORCE_OSCDR_MODE_OSX0;
                }
                SGMII_CL22_IEEE_REG[aBusIdx]->miicntl      = (SGMII_COMBO_MIICNTL_FULL_DUPLEX_MASK | SGMII_COMBO_MIICNTL_MANUAL_SPEED1_MASK);
                SGMII_USER_CL22_REG[aBusIdx]->miicntl      = (SGMII_USERCL22_MIICNTL_DUPLEX_MASK | SGMII_USERCL22_MIICNTL_MANUAL_SPEED1_MASK);
                break;
            default:
               retVal = BCM_ERR_INVAL_PARAMS;
                break;
            }
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_SGMII_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMII_FUNCTBL_V2
*/
int32_t SGMII_SetMode(uint8_t aBusIdx,
                       ETHXCVR_CntxtType *const aCntxt,
                       const ETHXCVR_PortConfigType *const aConfig,
                       ETHXCVR_ModeType aMode)
{
    int32_t retVal = BCM_ERR_OK;

    if (SGMII_MAX_HW_ID <= aBusIdx) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (ETHXCVR_STATE_INIT != SGMII_RWData[aBusIdx].state) {
        retVal = BCM_ERR_UNINIT;
    /* @event            Constant expression result
       @issue            The expression (0x1U == ENABLE_HWSCORPIO569_WORKAROUND) is always FALSE
       @risk             No risk
       @justification    The expression (0x1U == ENABLE_HWSCORPIO569_WORKAROUND) result FALSE
                         for bcm8957x and bcm8956x b0 but result TRUE in case of bcm8956x a0 */

    /* coverity[dead_error_line] */
    /* coverity[result_independent_of_operands] */
    } else if ((aBusIdx == 3U) &&
                (SGMII_RWData[aBusIdx].isConfigDone == ETHXCVR_BOOLEAN_TRUE) &&
                (0x1U == ENABLE_HWSCORPIO569_WORKAROUND)) {
        retVal = BCM_ERR_NOSUPPORT;
    } else if (0x1U == ENABLE_HWSCORPIO569_WORKAROUND) {
        switch(aMode) {
            case ETHXCVR_MODE_ACTIVE:
                retVal = SGMII_CommonSetMode(aBusIdx, aCntxt, aConfig, aMode);
                if (BCM_ERR_OK == retVal) {
                    retVal = SGMII_SetSpeed(aBusIdx, aCntxt, aConfig, aConfig->speed);
                }
                break;
            default:
                retVal = BCM_ERR_NOSUPPORT;
                break;
        }
    } else {
        switch(aMode) {
            case ETHXCVR_MODE_ACTIVE:
                SGMII_CTRL_REGS[aBusIdx]->lanectrl &= ~(SGMII_CTRL_LANECTRLA_PMD_TXDISABLE_MASK);
                retVal = SGMII_SetSpeed(aBusIdx, aCntxt, aConfig, aConfig->speed);
                break;
            case ETHXCVR_MODE_DOWN:
                SGMII_CTRL_REGS[aBusIdx]->lanectrl &= ~(SGMII_CTRL_LANECTRLA_PMD_TXDISABLE_MASK);
                retVal = BCM_ERR_NOSUPPORT;
                break;
            case ETHXCVR_MODE_ISOLATE:
                SGMII_CTRL_REGS[aBusIdx]->lanectrl |= SGMII_CTRL_LANECTRLA_PMD_TXDISABLE_MASK;
                break;
            default:
                retVal = BCM_ERR_NOSUPPORT;
                break;
        }
    }
    if(BCM_ERR_OK == retVal) {
        SGMII_RWData[aBusIdx].isConfigDone = ETHXCVR_BOOLEAN_TRUE;
    }
    return retVal;
}

/**
    @trace #BRCM_SWARCH_SGMII_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMII_FUNCTBL_V2
*/
int32_t SGMII_GetMode(uint8_t aBusIdx,
                       ETHXCVR_CntxtType *const aCntxt,
                       const ETHXCVR_PortConfigType *const aConfig,
                       ETHXCVR_ModeType *const aMode)
{
    int32_t retVal = BCM_ERR_OK;
    uint16_t mask = (SGMII_COMBO_MIICNTL_PWRDWN_SW_MASK | SGMII_COMBO_MIICNTL_RST_HW_MASK);

    if ((SGMII_MAX_HW_ID <= aBusIdx) || (NULL == aMode)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (ETHXCVR_STATE_INIT != SGMII_RWData[aBusIdx].state) {
        retVal = BCM_ERR_UNINIT;
    } else {
        if(0x1U == ENABLE_HWSCORPIO569_WORKAROUND) {
            retVal = SGMII_CommonGetMode(aBusIdx, aCntxt, aConfig, aMode);
        } else {
            if ((SGMII_CL22_IEEE_REG[aBusIdx]->miicntl & mask) != 0U) {
                *aMode = ETHXCVR_MODE_DOWN;
            } else if (SGMII_CTRL_LANECTRLA_PMD_TXDISABLE_MASK ==
                   (SGMII_CTRL_LANECTRLA_PMD_TXDISABLE_MASK & SGMII_CTRL_REGS[aBusIdx]->lanectrl)) {
                *aMode = ETHXCVR_MODE_ISOLATE;
            } else {
                *aMode = ETHXCVR_MODE_ACTIVE;
            }
        }
    }
    return retVal;
}

/** @} */
