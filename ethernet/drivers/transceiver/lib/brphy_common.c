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
    @addtogroup grp_eth_xcvrdrv_brphy_common_imp
    @{

    @file brphy_common.c
    @brief This file implements the common BRPHY Driver for all chip families.

    @version 0.1 Initial draft
*/

#include <string.h>
#include <compiler.h>
#include <bcm_utils.h>
#include <bcm_err.h>
#include <ethxcvr.h>
#include <ethxcvr_osil.h>
#include <brphy_osil.h>
#include <brphy_core_rdb.h>
#include <brphy_dsp_rdb.h>
#include <brphy_common.h>

/**
    @name BRPHY driver Design IDs
    @{
    @brief Design IDs for BRPHY driver
*/
#define BRCM_SWDSGN_BRPHY_COMMONINIT_PROC                    (0xBB01U)    /**< @brief #BRPHY_CommonInit                 */
#define BRCM_SWDSGN_BRPHY_COMMONRESET_PROC                   (0xBB02U)    /**< @brief #BRPHY_CommonReset                */
#define BRCM_SWDSGN_BRPHY_COMMONGETSQIVALUE_PROC             (0xBB03U)    /**< @brief #BRPHY_CommonGetSQIValue          */
#define BRCM_SWDSGN_BRPHY_COMMONGETDUPLEXMODE_PROC           (0xBB04U)    /**< @brief #BRPHY_CommonGetDuplexMode        */
#define BRCM_SWDSGN_BRPHY_COMMONGETSPEED_PROC                (0xBB05U)    /**< @brief #BRPHY_CommonGetSpeed             */
#define BRCM_SWDSGN_BRPHY_COMMONGETLINKSTATE_PROC            (0xBB06U)    /**< @brief #BRPHY_CommonGetLinkState         */
#define BRCM_SWDSGN_BRPHY_COMMONGETMODE_PROC                 (0xBB07U)    /**< @brief #BRPHY_CommonGetMode              */
#define BRCM_SWDSGN_BRPHY_RESET_TIMEOUT_LOOPCNT              (0xBB08U)    /**< @brief #BRPHY_RESET_TIMEOUT_LOOPCNT      */
#define BRCM_SWDSGN_BRPHY_POWER_DOWN_BIT_TIMEOUT_CNT         (0xBB09U)    /**< @brief #BRPHY_POWER_DOWN_BIT_TIMEOUT_CNT */
#define BRCM_SWDSGN_BRPHY_SQI_CFG_VALUE                      (0xBB0AU)    /**< @brief #BRPHY_SQI_CFG_VALUE              */
#define BRCM_SWDSGN_BRPHY_SQI_LOOP_CNT                       (0xBB0BU)    /**< @brief #BRPHY_SQI_LOOP_CNT               */
#define BRCM_SWDSGN_BRPHY_SQI_0D                             (0xBB0CU)    /**< @brief #BRPHY_SQI_0D                     */
#define BRCM_SWDSGN_BRPHY_SQI_0C                             (0xBB0DU)    /**< @brief #BRPHY_SQI_0C                     */
#define BRCM_SWDSGN_BRPHY_SQI_0B                             (0xBB0EU)    /**< @brief #BRPHY_SQI_0B                     */
#define BRCM_SWDSGN_BRPHY_SQI_0A                             (0xBB0FU)    /**< @brief #BRPHY_SQI_0A                     */
#define BRCM_SWDSGN_BRPHY_SQI_1                              (0xBB10U)    /**< @brief #BRPHY_SQI_1                      */
#define BRCM_SWDSGN_BRPHY_SQI_2                              (0xBB11U)    /**< @brief #BRPHY_SQI_2                      */
#define BRCM_SWDSGN_BRPHY_SQI_3                              (0xBB12U)    /**< @brief #BRPHY_SQI_3                      */
#define BRCM_SWDSGN_BRPHY_SQI_4                              (0xBB13U)    /**< @brief #BRPHY_SQI_4                      */
#define BRCM_SWDSGN_BRPHY_SQI_5                              (0xBB14U)    /**< @brief #BRPHY_SQI_5                      */
#define BRCM_SWDSGN_BRPHY_SQI_0D_RANGE                       (0xBB15U)    /**< @brief #BRPHY_SQI_0D_RANGE               */
#define BRCM_SWDSGN_BRPHY_SQI_0C_RANGE                       (0xBB16U)    /**< @brief #BRPHY_SQI_0C_RANGE               */
#define BRCM_SWDSGN_BRPHY_SQI_0B_RANGE                       (0xBB17U)    /**< @brief #BRPHY_SQI_0B_RANGE               */
#define BRCM_SWDSGN_BRPHY_SQI_0A_RANGE                       (0xBB18U)    /**< @brief #BRPHY_SQI_0A_RANGE               */
#define BRCM_SWDSGN_BRPHY_SQI_1_RANGE                        (0xBB19U)    /**< @brief #BRPHY_SQI_1_RANGE                */
#define BRCM_SWDSGN_BRPHY_SQI_2_RANGE                        (0xBB1AU)    /**< @brief #BRPHY_SQI_2_RANGE                */
#define BRCM_SWDSGN_BRPHY_SQI_3_RANGE                        (0xBB1BU)    /**< @brief #BRPHY_SQI_3_RANGE                */
#define BRCM_SWDSGN_BRPHY_SQI_4_RANGE                        (0xBB1CU)    /**< @brief #BRPHY_SQI_4_RANGE                */
#define BRCM_SWDSGN_BRPHY_SQI_5_RANGE                        (0xBB1DU)    /**< @brief #BRPHY_SQI_5_RANGE                */
#define BRCM_SWDSGN_BRPHY_CORE_REGS_GLOBAL                   (0xBB1EU)    /**< @brief #BRPHY_CORE_REGS                  */
#define BRCM_SWDSGN_BRPHY_CL22_IEEE_REGS_GLOBAL              (0xBB1FU)    /**< @brief #BRPHY_CL22_IEEE_REGS             */
#define BRCM_SWDSGN_BRPHY_DSP_TAP_CTRL_REGS_GLOBAL           (0xBB20U)    /**< @brief #BRPHY_DSP_TAP_CTRL_REGS          */
#define BRCM_SWDSGN_BRPHY_COMMONLINKIRQHANDLER_PROC          (0xBB21U)    /**< @brief #BRPHY_CommonLinkIRQHandler       */
#define BRCM_SWDSGN_BRPHY_COMMONLINKCHANGEINDHANDLER_PROC    (0xBB22U)    /**< @brief #BRPHY_CommonLinkChangeIndHandler */
#define BRCM_SWDSGN_BRPHY_COMMONDEINIT_PROC                  (0xBB23U)    /**< @brief #BRPHY_CommonDeInit               */
#define BRCM_SWDSGN_BRPHY_COMMONSETSPEED_PROC                (0xBB24U)    /**< @brief #BRPHY_CommonSetSpeed             */
#define BRCM_SWDSGN_BRPHY_COMMONGETJUMBOMODE_PROC            (0xBB25U)    /**< @brief #BRPHY_CommonGetJumboMode         */
#define BRCM_SWDSGN_BRPHY_COMMONSETWAKEUPMODE_PROC           (0xBB26U)    /**< @brief #BRPHY_CommonSetWakeUpMode        */
#define BRCM_SWDSGN_BRPHY_COMMONGETWAKEUPMODE_PROC           (0xBB27U)    /**< @brief #BRPHY_CommonGetWakeUpMode        */
#define BRCM_SWDSGN_BRPHY_COMMONGETWAKEUPREASON_PROC         (0xBB28U)    /**< @brief #BRPHY_CommonGetWakeUpReason      */
#define BRCM_SWDSGN_BRPHY_COMMONSETJUMBOMODE_PROC            (0xBB29U)    /**< @brief #BRPHY_CommonSetJumboMode         */
#define BRCM_SWDSGN_BRPHY_COMMONSETAUTONEGMODE_PROC          (0xBB2AU)    /**< @brief #BRPHY_CommonSetAutoNegMode       */
#define BRCM_SWDSGN_BRPHY_COMMONGETAUTONEGSTATUS_PROC        (0xBB2BU)    /**< @brief #BRPHY_CommonGetAutoNegStatus     */
#define BRCM_SWDSGN_BRPHY_COMMONGETSTATS_PROC                (0xBB2CU)    /**< @brief #BRPHY_CommonGetStats             */
#define BRCM_SWDSGN_BRPHY_COMMONSETDUPLEXMODE_PROC           (0xBB2DU)    /**< @brief #BRPHY_CommonSetDuplexMode        */
#define BRCM_SWDSGN_BRPHY_COMMONSETFLOWCONTROL_PROC          (0xBB2EU)    /**< @brief #BRPHY_CommonSetFlowControl       */
#define BRCM_SWDSGN_BRPHY_COMMONGETFLOWCONTROL_PROC          (0xBB2FU)    /**< @brief #BRPHY_CommonGetFlowControl       */
#define BRCM_SWDSGN_BRPHY_COMMONRESTARTAUTONEG_PROC          (0xBB30U)    /**< @brief #BRPHY_CommonRestartAutoNeg       */
#define BRCM_SWDSGN_BRPHY_COMMONSTATEHANDLER_PROC            (0xBB31U)    /**< @brief #BRPHY_CommonStateHandler         */
#define BRCM_SWDSGN_BRPHY_COMMONUPDATEHWSTATUS_PROC          (0xBB32U)    /**< @brief #BRPHY_CommonUpdateHWStatus       */
#define BRCM_SWDSGN_BRPHY_COMMONSETMODE_PROC                 (0xBB33U)    /**< @brief #BRPHY_CommonSetMode              */
#define BRCM_SWDSGN_BRPHY_FUNCTBL_GLOBAL                     (0xBB34U)    /**< @brief #BRPHY_FuncTbl                    */
/** @} */

/**
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
    @trace #BRCM_SWARCH_BRPHY_FUNCTBL_GLOBAL
*/
#define BRPHY_RESET_TIMEOUT_LOOPCNT         (2000UL)

/**
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
    @trace #BRCM_SWARCH_BRPHY_FUNCTBL_GLOBAL
*/
#define BRPHY_POWER_DOWN_BIT_TIMEOUT_CNT    (1000UL)

/**
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
    @trace #BRCM_SWARCH_BRPHY_FUNCTBL_GLOBAL
*/
#define BRPHY_SQI_CFG_VALUE         0xC30U

/**
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
    @trace #BRCM_SWARCH_BRPHY_FUNCTBL_GLOBAL
*/
#define BRPHY_SQI_LOOP_CNT          (100UL)

/* M = -AvgdB - 20 */
/**
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
    @trace #BRCM_SWARCH_BRPHY_FUNCTBL_GLOBAL
*/
#define BRPHY_SQI_0D                0xDU /* 11% M is between -8.0 and -6.0 */

/**
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
    @trace #BRCM_SWARCH_BRPHY_FUNCTBL_GLOBAL
*/
#define BRPHY_SQI_0C                0xCU /* 22% M is between -6.0 and -4.0 */

/**
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
    @trace #BRCM_SWARCH_BRPHY_FUNCTBL_GLOBAL
*/
#define BRPHY_SQI_0B                0xBU /* 33% M is between -4.0 and -2.0 */

/**
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
    @trace #BRCM_SWARCH_BRPHY_FUNCTBL_GLOBAL
*/
#define BRPHY_SQI_0A                0xAU /* 44% M is between -2.0 and 0.0 */

/**
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
    @trace #BRCM_SWARCH_BRPHY_FUNCTBL_GLOBAL
*/
#define BRPHY_SQI_1                 0x1U /* 55% M is between 0.0 and 2.0 */

/**
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
    @trace #BRCM_SWARCH_BRPHY_FUNCTBL_GLOBAL
*/
#define BRPHY_SQI_2                 0x2U /* 66% M is between 2.0 and 4.0 */

/**
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
    @trace #BRCM_SWARCH_BRPHY_FUNCTBL_GLOBAL
*/
#define BRPHY_SQI_3                 0x3U /* 77% M is between 4.0 and 6.0 */

/**
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
    @trace #BRCM_SWARCH_BRPHY_FUNCTBL_GLOBAL
*/
#define BRPHY_SQI_4                 0x4U /* 88% M is between 6.0 and 8.0 */

/**
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
    @trace #BRCM_SWARCH_BRPHY_FUNCTBL_GLOBAL
*/
#define BRPHY_SQI_5                 0x5U /* 99% M is greater than 8.0 */


/**
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
    @trace #BRCM_SWARCH_BRPHY_FUNCTBL_GLOBAL
*/
#define BRPHY_SQI_0D_RANGE(val)     (((val) > 1305U) && ((val) <= 2068U))

/**
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
    @trace #BRCM_SWARCH_BRPHY_FUNCTBL_GLOBAL
*/
#define BRPHY_SQI_0C_RANGE(val)     (((val) > 823U)  && ((val) <= 1305U))

/**
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
    @trace #BRCM_SWARCH_BRPHY_FUNCTBL_GLOBAL
*/
#define BRPHY_SQI_0B_RANGE(val)     (((val) > 519U)  && ((val) <= 823U))

/**
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
    @trace #BRCM_SWARCH_BRPHY_FUNCTBL_GLOBAL
*/
#define BRPHY_SQI_0A_RANGE(val)     (((val) > 328U)  && ((val) <= 519U))

/**
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
    @trace #BRCM_SWARCH_BRPHY_FUNCTBL_GLOBAL
*/
#define BRPHY_SQI_1_RANGE(val)      (((val) > 206U)  && ((val) <= 328U))

/**
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
    @trace #BRCM_SWARCH_BRPHY_FUNCTBL_GLOBAL
*/
#define BRPHY_SQI_2_RANGE(val)      (((val) > 130U)  && ((val) <= 206U))

/**
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
    @trace #BRCM_SWARCH_BRPHY_FUNCTBL_GLOBAL
*/
#define BRPHY_SQI_3_RANGE(val)      (((val) > 82U)   && ((val) <= 130U))

/**
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
    @trace #BRCM_SWARCH_BRPHY_FUNCTBL_GLOBAL
*/
#define BRPHY_SQI_4_RANGE(val)      (((val) > 52U)   && ((val) <= 82U))

/**
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
    @trace #BRCM_SWARCH_BRPHY_FUNCTBL_GLOBAL
*/
#define BRPHY_SQI_5_RANGE(val)      ((val) <= 52U)

/**
    @brief BR_MII block base addresses

    @trace #BRCM_SWARCH_BRPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
*/
BRPHY_MII_RDBType * const BRPHY_CL22_IEEE_REGS[BRPHY_MII_MAX_HW_ID] =
{
#if (BRPHY_MII_MAX_HW_ID == 0UL)
#error "BRPHY_MII_MAX_HW_ID == 0UL"
#endif
    (BRPHY_MII_RDBType *)BRPHY0_CL22_IEEE_BASE,
#if (BRPHY_MII_MAX_HW_ID > 1UL)
    (BRPHY_MII_RDBType *)BRPHY1_CL22_IEEE_BASE,
#endif
#if (BRPHY_MII_MAX_HW_ID > 2UL)
    (BRPHY_MII_RDBType *)BRPHY2_CL22_IEEE_BASE,
#endif
#if (BRPHY_MII_MAX_HW_ID > 3UL)
    (BRPHY_MII_RDBType *)BRPHY3_CL22_IEEE_BASE,
#endif
#if (BRPHY_MII_MAX_HW_ID > 4UL)
    (BRPHY_MII_RDBType *)BRPHY4_CL22_IEEE_BASE,
#endif
#if (BRPHY_MII_MAX_HW_ID > 5UL)
#error "BRPHY_MII_MAX_HW_ID > 5UL is not supported"
#endif
};

/**
    @brief GPHY Core block base addresses

    @trace #BRCM_SWARCH_BRPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
*/
static BRPHY_CORE_RDBType * const BRPHY_CORE_REGS[BRPHY_CORE_MAX_HW_ID] =
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
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
*/
static BRPHY_DSP_RDBType * const
    BRPHY_DSP_TAP_CTRL_REGS[BRPHY_DSP_MAX_HW_ID] =
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
    @trace #BRCM_SWARCH_BRPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
*/
int32_t BRPHY_CommonSetMode(uint8_t aPhyIdx,
                             ETHXCVR_CntxtType *const aPhyCntxt,
                             const ETHXCVR_PortConfigType *const aConfig,
                             ETHXCVR_ModeType aMode)
{
    int32_t retVal = BCM_ERR_OK;
    uint32_t loopCnt = 0UL;
    uint16_t regVal;

    if (ETHXCVR_MODE_ACTIVE == aMode) {
        regVal = BRPHY_CL22_IEEE_REGS[aPhyIdx]->mii_ctrl;
        regVal &= (uint16_t)(~BRPHY_MII_MII_CTRL_POWER_DOWN_MASK);
        regVal &= (uint16_t)(~BRPHY_MII_MII_CTRL_ISOLATE_MASK);
        BRPHY_CL22_IEEE_REGS[aPhyIdx]->mii_ctrl = regVal;
        do {
            regVal = BRPHY_CL22_IEEE_REGS[aPhyIdx]->mii_ctrl;
            loopCnt++;
        } while (((regVal & BRPHY_MII_MII_CTRL_POWER_DOWN_MASK) != 0U)
                && (BRPHY_POWER_DOWN_BIT_TIMEOUT_CNT > loopCnt));
    } else if (ETHXCVR_MODE_DOWN == aMode) {
        regVal = BRPHY_CL22_IEEE_REGS[aPhyIdx]->mii_ctrl;
        regVal |= (BRPHY_MII_MII_CTRL_POWER_DOWN_MASK);
        BRPHY_CL22_IEEE_REGS[aPhyIdx]->mii_ctrl = regVal;
        do {
            regVal = BRPHY_CL22_IEEE_REGS[aPhyIdx]->mii_ctrl;
            loopCnt++;
        } while (((regVal & BRPHY_MII_MII_CTRL_POWER_DOWN_MASK) == 0U)
                && (BRPHY_POWER_DOWN_BIT_TIMEOUT_CNT > loopCnt));
    } else if (ETHXCVR_MODE_ISOLATE == aMode) {
        BRPHY_CL22_IEEE_REGS[aPhyIdx]->mii_ctrl |= BRPHY_MII_MII_CTRL_ISOLATE_MASK;
    } else {
        retVal = BCM_ERR_INVAL_PARAMS;
    }
    if (BRPHY_POWER_DOWN_BIT_TIMEOUT_CNT == loopCnt) {
        retVal = BCM_ERR_TIME_OUT;
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_BRPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
*/
int32_t BRPHY_CommonGetLinkState(uint8_t aPhyIdx,
                                  ETHXCVR_CntxtType *const aPhyCntxt,
                                  const ETHXCVR_PortConfigType *const aConfig,
                                  ETHXCVR_LinkStateType *const aLinkState)
{
    uint16_t reg;
    int32_t retVal = BCM_ERR_OK;

    if ((BRPHY_CORE_MAX_HW_ID <= aPhyIdx)
            || (NULL == aLinkState)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (ETHXCVR_STATE_INIT != BRPHY_RWData[aPhyIdx].state) {
        retVal = BCM_ERR_UNINIT;
    } else {
        reg = BRPHY_CL22_IEEE_REGS[aPhyIdx]->mii_stat;
        reg = BRPHY_CL22_IEEE_REGS[aPhyIdx]->mii_stat;

        if ((reg & BRPHY_MII_MII_STAT_LNK_STAT_MASK) == BRPHY_MII_MII_STAT_LNK_STAT_MASK) {
            *aLinkState = ETHXCVR_LINKSTATE_ACTIVE;
        } else {
            *aLinkState = ETHXCVR_LINKSTATE_DOWN;
        }
    }
    return retVal;
}

/**
    @trace #BRCM_SWARCH_BRPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
*/
int32_t BRPHY_CommonReset(uint8_t aPhyIdx,
                           ETHXCVR_CntxtType *const aPhyCntxt,
                           const ETHXCVR_PortConfigType *const aConfig)
{
    int32_t retVal = BCM_ERR_OK;
    uint32_t loopCnt;

    if (BRPHY_CORE_MAX_HW_ID <= aPhyIdx) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (ETHXCVR_STATE_INIT != BRPHY_RWData[aPhyIdx].state) {
        retVal = BCM_ERR_UNINIT;
    } else {
        BRPHY_CL22_IEEE_REGS[aPhyIdx]->mii_ctrl |= BRPHY_MII_MII_CTRL_RESET_MASK;
        /* Wait for Reset bit to auto clear */
        loopCnt = BRPHY_RESET_TIMEOUT_LOOPCNT;
        while (((BRPHY_CL22_IEEE_REGS[aPhyIdx]->mii_ctrl
                        & BRPHY_MII_MII_CTRL_RESET_MASK) == BRPHY_MII_MII_CTRL_RESET_MASK)
                && (loopCnt > 0UL)) {
            loopCnt--;
        }
        if (0UL == loopCnt) {
            retVal = BCM_ERR_TIME_OUT;
        }
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_BRPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
*/
int32_t BRPHY_CommonGetMode(uint8_t aPhyIdx,
                             ETHXCVR_CntxtType *const aPhyCntxt,
                             const ETHXCVR_PortConfigType *const aConfig,
                             ETHXCVR_ModeType *const aMode)
{
    int32_t retVal = BCM_ERR_OK;
    uint16_t mask = (BRPHY_MII_MII_CTRL_POWER_DOWN_MASK | BRPHY_MII_MII_CTRL_RESET_MASK);

    if ((BRPHY_CORE_MAX_HW_ID <= aPhyIdx) || (NULL == aMode)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (ETHXCVR_STATE_INIT != BRPHY_RWData[aPhyIdx].state) {
        retVal = BCM_ERR_UNINIT;
    } else {
        if ((BRPHY_CL22_IEEE_REGS[aPhyIdx]->mii_ctrl & mask) != 0U) {
            *aMode = ETHXCVR_MODE_DOWN;
        } else if (BRPHY_MII_MII_CTRL_ISOLATE_MASK ==
                 (BRPHY_MII_MII_CTRL_ISOLATE_MASK & BRPHY_CL22_IEEE_REGS[aPhyIdx]->mii_ctrl)) {
            *aMode = ETHXCVR_MODE_ISOLATE;
        } else {
            *aMode = ETHXCVR_MODE_ACTIVE;
        }
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_BRPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
*/
int32_t BRPHY_CommonSetSpeed(uint8_t aPhyIdx,
                              ETHXCVR_CntxtType *const aPhyCntxt,
                              const ETHXCVR_PortConfigType *const aConfig,
                              ETHXCVR_SpeedType aSpeed)
{
    int32_t retVal;

    if (BRPHY_CORE_MAX_HW_ID <= aPhyIdx) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (ETHXCVR_STATE_INIT != BRPHY_RWData[aPhyIdx].state) {
        retVal = BCM_ERR_UNINIT;
    } else {
        if (ETHXCVR_SPEED_100MBPS != aSpeed) {
            retVal = BCM_ERR_NOSUPPORT;
        } else {
            retVal = BCM_ERR_OK;
        }
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_BRPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
*/
int32_t BRPHY_CommonGetSpeed(uint8_t aPhyIdx,
                              ETHXCVR_CntxtType *const aPhyCntxt,
                              const ETHXCVR_PortConfigType *const aConfig,
                              ETHXCVR_SpeedType *const aSpeed)
{
    int32_t retVal = BCM_ERR_OK;

    if ((BRPHY_CORE_MAX_HW_ID <= aPhyIdx) || (NULL == aSpeed)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (ETHXCVR_STATE_INIT != BRPHY_RWData[aPhyIdx].state) {
        retVal = BCM_ERR_UNINIT;
    } else if ((BRPHY_CL22_IEEE_REGS[aPhyIdx]->mii_ctrl
                & BRPHY_MII_MII_CTRL_SPEED_SELECTION_MASK) != 0U) {
        /* For Port 4 in 100Tx mode  */
        *aSpeed = ETHXCVR_SPEED_100MBPS;
    } else {
        *aSpeed = ETHXCVR_SPEED_100MBPS;
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_BRPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
*/
int32_t BRPHY_CommonGetDuplexMode(uint8_t aPhyIdx,
                                   ETHXCVR_CntxtType *const aPhyCntxt,
                                   const ETHXCVR_PortConfigType *const aConfig,
                                   ETHXCVR_DuplexModeType *const aDuplexMode)
{
    int32_t retVal = BCM_ERR_OK;

    if ((BRPHY_CORE_MAX_HW_ID <= aPhyIdx) || (NULL == aDuplexMode)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (ETHXCVR_STATE_INIT != BRPHY_RWData[aPhyIdx].state) {
        retVal = BCM_ERR_UNINIT;
    } else {
        *aDuplexMode = ETHXCVR_DUPLEXMODE_FULL;
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_BRPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
*/
int32_t BRPHY_CommonSetDuplexMode(uint8_t aPhyIdx,
                                   ETHXCVR_CntxtType *const aPhyCntxt,
                                   const ETHXCVR_PortConfigType *const aConfig,
                                   ETHXCVR_DuplexModeType aDuplexMode)
{
    int32_t retVal = BCM_ERR_OK;

    if (BRPHY_CORE_MAX_HW_ID <= aPhyIdx) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (ETHXCVR_STATE_INIT != BRPHY_RWData[aPhyIdx].state) {
        retVal = BCM_ERR_UNINIT;
    } else {
        retVal = BCM_ERR_NOSUPPORT;
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_BRPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
*/
int32_t BRPHY_CommonGetFlowControl(uint8_t aPhyIdx,
                                    ETHXCVR_CntxtType *const aPhyCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig,
                                    ETHXCVR_FlowControlType *const aFlowControl)
{
    int32_t retVal = BCM_ERR_OK;

    if ((BRPHY_CORE_MAX_HW_ID <= aPhyIdx) || (NULL == aFlowControl)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (ETHXCVR_STATE_INIT != BRPHY_RWData[aPhyIdx].state) {
        retVal = BCM_ERR_UNINIT;
    } else {
        *aFlowControl = ETHXCVR_FLOWCONTROL_NONE;
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_BRPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
*/
int32_t BRPHY_CommonSetFlowControl(uint8_t aPhyIdx,
                                    ETHXCVR_CntxtType *const aPhyCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig,
                                    ETHXCVR_FlowControlType aFlowControl)
{
    int32_t retVal = BCM_ERR_OK;

    if (BRPHY_CORE_MAX_HW_ID <= aPhyIdx) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (ETHXCVR_STATE_INIT != BRPHY_RWData[aPhyIdx].state) {
        retVal = BCM_ERR_UNINIT;
    } else {
        retVal = BCM_ERR_NOSUPPORT;
    }

    return retVal;
}
/**
    @trace #BRCM_SWARCH_BRPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
*/
int32_t BRPHY_CommonGetSQIValue(uint8_t aPhyIdx,
                                 ETHXCVR_CntxtType *const aPhyCntxt,
                                 const ETHXCVR_PortConfigType *const aConfig,
                                 uint32_t *const aSQIValue)
{
    uint16_t regval_base;
    uint16_t regval;
    uint32_t sum = 0UL;
    uint32_t avg;
    uint32_t i;
    int32_t retVal = BCM_ERR_OK;

    if ((BRPHY_CORE_MAX_HW_ID <= aPhyIdx) || (NULL == aSQIValue)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (ETHXCVR_STATE_INIT != BRPHY_RWData[aPhyIdx].state) {
        retVal = BCM_ERR_UNINIT;
    } else {
        /* Read the original value */
        regval_base = BRPHY_CORE_REGS[aPhyIdx]->shd18_000;

        /* Write the config value */
        BRPHY_CORE_REGS[aPhyIdx]->shd18_000 = BRPHY_SQI_CFG_VALUE;

        for(i = 0UL; i < BRPHY_SQI_LOOP_CNT; i++) {
            regval = BRPHY_DSP_TAP_CTRL_REGS[aPhyIdx]->tap2_c0;
            sum += regval;
        }
        avg = sum / BRPHY_SQI_LOOP_CNT;

        /* Restore the value */
        BRPHY_CORE_REGS[aPhyIdx]->shd18_000 = regval_base;

        /* Now the average SQI value is found, */
        /* the quality indicator needs to be determined */
        if (BRPHY_SQI_0D_RANGE(avg)) {
            *aSQIValue = BRPHY_SQI_0D;
        } else if (BRPHY_SQI_0C_RANGE(avg)) {
            *aSQIValue = BRPHY_SQI_0C;
        } else if (BRPHY_SQI_0B_RANGE(avg)) {
            *aSQIValue = BRPHY_SQI_0B;
        } else if (BRPHY_SQI_0A_RANGE(avg)) {
            *aSQIValue = BRPHY_SQI_0A;
        } else if (BRPHY_SQI_1_RANGE(avg)) {
            *aSQIValue = BRPHY_SQI_1;
        } else if (BRPHY_SQI_2_RANGE(avg)) {
            *aSQIValue = BRPHY_SQI_2;
        } else if (BRPHY_SQI_3_RANGE(avg)) {
            *aSQIValue = BRPHY_SQI_3;
        } else if (BRPHY_SQI_4_RANGE(avg)) {
            *aSQIValue = BRPHY_SQI_4;
        } else if (BRPHY_SQI_5_RANGE(avg)) {
            *aSQIValue = BRPHY_SQI_5;
        } else {
            *aSQIValue = 0UL;
        }
    }
    return retVal;
}

/**
    @trace #BRCM_SWARCH_BRPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
*/
int32_t BRPHY_CommonInit(uint8_t aPhyIdx,
                          ETHXCVR_CntxtType *const aPhyCntxt,
                          const ETHXCVR_PortConfigType *const aConfig)
{
    int32_t retVal = BCM_ERR_OK;


    if ((BRPHY_CORE_MAX_HW_ID <= aPhyIdx) || (NULL == aConfig)) {
        retVal = BCM_ERR_INVAL_PARAMS;
        goto err;
    }

    if (ETHXCVR_STATE_UNINIT != BRPHY_RWData[aPhyIdx].state) {
        retVal = BCM_ERR_INVAL_STATE;
        goto err;
    }

    BRPHY_RWData[aPhyIdx].state = ETHXCVR_STATE_INIT;
    BRPHY_RWData[aPhyIdx].isConfigDone = (ETHXCVR_BooleanType)ETHXCVR_BOOLEAN_FALSE;
    /* Enable the link status change interrupt. The following is not a typo      */
    /* RDB does not define any bitfields for the mask register, they are assumed */
    /* to be the same as status (BASE1A) register                                */
    BRPHY_CORE_REGS[aPhyIdx]->base1b &= (uint16_t)~BRPHY_CORE_BASE1A_LINK_STATUS_CHANGE_MASK;
err:
    return retVal;
}

/**
    @trace #BRCM_SWARCH_BRPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
*/
int32_t BRPHY_CommonDeInit(uint8_t aPhyIdx,
                            ETHXCVR_CntxtType *const aPhyCntxt,
                            const ETHXCVR_PortConfigType *const aConfig)
{
    int32_t retVal = BCM_ERR_OK;

    if (BRPHY_CORE_MAX_HW_ID <= aPhyIdx) {
        retVal = BCM_ERR_INVAL_PARAMS;
        goto err;
    }

    if (ETHXCVR_STATE_INIT != BRPHY_RWData[aPhyIdx].state) {
        retVal = BCM_ERR_INVAL_STATE;
        goto err;
    }

    BRPHY_RWData[aPhyIdx].state = ETHXCVR_STATE_UNINIT;
    BRPHY_RWData[aPhyIdx].isConfigDone = (ETHXCVR_BooleanType)ETHXCVR_BOOLEAN_FALSE;
    /* Disable the link status change interrupt. The following is not a typo      */
    /* RDB does not define any bitfields for the mask register, they are assumed */
    /* to be the same as status (BASE1A) register                                */
    BRPHY_CORE_REGS[aPhyIdx]->base1b |= BRPHY_CORE_BASE1A_LINK_STATUS_CHANGE_MASK;
err:
    return retVal;
}




/**
    @trace #BRCM_SWARCH_BRPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
*/
int32_t BRPHY_CommonSetJumboMode(uint8_t aPhyIdx,
                                  ETHXCVR_CntxtType *const aPhyCntxt,
                                  const ETHXCVR_PortConfigType *const aConfig,
                                  ETHXCVR_BooleanType aMode)
{
    int32_t retVal = BCM_ERR_OK;

    if (BRPHY_CORE_MAX_HW_ID <= aPhyIdx) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (ETHXCVR_STATE_INIT != BRPHY_RWData[aPhyIdx].state) {
        retVal = BCM_ERR_UNINIT;
    } else {
        if ((ETHXCVR_BooleanType)ETHXCVR_BOOLEAN_TRUE == aMode) {
            /* Enable extended frame length */
            BRPHY_CORE_REGS[aPhyIdx]->shd18_000 |=
                BRPHY_CORE_SHD18_000_EXT_PKT_LEN_MASK;
            /* Enable DSP clock */
            BRPHY_CORE_REGS[aPhyIdx]->shd18_000 |=
                BRPHY_CORE_SHD18_000_SM_DSP_CLK_EN_MASK;
        } else if ((ETHXCVR_BooleanType)ETHXCVR_BOOLEAN_FALSE == aMode) {
            /* Disable extended frame length */
            BRPHY_CORE_REGS[aPhyIdx]->shd18_000 &=
                (uint16_t)~BRPHY_CORE_SHD18_000_EXT_PKT_LEN_MASK;
            /* Disable DSP clock */
            BRPHY_CORE_REGS[aPhyIdx]->shd18_000 &=
                (uint16_t)~BRPHY_CORE_SHD18_000_SM_DSP_CLK_EN_MASK;
        } else {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_BRPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
*/
int32_t BRPHY_CommonGetJumboMode(uint8_t aPhyIdx,
                                  ETHXCVR_CntxtType *const aPhyCntxt,
                                  const ETHXCVR_PortConfigType *const aConfig,
                                  ETHXCVR_BooleanType *const aMode)
{
    int32_t retVal = BCM_ERR_OK;
    uint16_t regValMask;

    if ((BRPHY_CORE_MAX_HW_ID <= aPhyIdx) || (NULL == aMode)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (ETHXCVR_STATE_INIT != BRPHY_RWData[aPhyIdx].state) {
        retVal = BCM_ERR_UNINIT;
    } else {
        regValMask = (BRPHY_CORE_SHD18_000_EXT_PKT_LEN_MASK
                    | BRPHY_CORE_SHD18_000_SM_DSP_CLK_EN_MASK);
        if ((BRPHY_CORE_REGS[aPhyIdx]->shd18_000 & regValMask) == regValMask) {
            *aMode = (ETHXCVR_BooleanType)ETHXCVR_BOOLEAN_TRUE;
        } else {
            *aMode = (ETHXCVR_BooleanType)ETHXCVR_BOOLEAN_FALSE;
        }
    }

    return retVal;
}

/**
    @brief Set Wakeup Enable Mode

    @anchor BCM_ERR_NOSUPPORT

    @behavior Sync, Non re-entrant

    @pre None

    @param[in]      aPhyIdx        Port index
    @param[in]      aPhyCntxt      Pointer to PHY context structure
    @param[in]      aConfig        Pointer to Configuration
    @param[in]      aMode          Enabled or Disabled

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_NOSUPPORT    No Wakeup Support

    @post None

    @trace #BRCM_SWARCH_BRPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL

    @limitations None

    @code{.c}
    return BCM_ERR_NOSUPPORT
    @endcode
*/
int32_t BRPHY_CommonSetWakeUpMode(uint8_t aPhyIdx,
                                  ETHXCVR_CntxtType *const aCntxt,
                                  const ETHXCVR_PortConfigType *const aConfig,
                                  ETHXCVR_BooleanType aMode)
{
    return BCM_ERR_NOSUPPORT;
}

/**
    @brief Get Wakeup Mode

    This API Responds with Wakeup Mode Enabled or Not

    @anchor BCM_ERR_NOSUPPORT

    @behavior Sync, Non re-entrant

    @pre None

    @param[in]      aPhyIdx        Port index
    @param[in]      aPhyCntxt      Pointer to PHY context structure
    @param[in]      aConfig        Pointer to Configuration
    @param[in]      aMode          Pointer to read Wakeup Mode feature enable

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_NOSUPPORT        NoSupport

    @post None

    @trace #BRCM_SWARCH_BRPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL

    @limitations None

    @code{.c}
    return BCM_ERR_NOSUPPORT
    @endcode

*/
int32_t BRPHY_CommonGetWakeUpMode(uint8_t aPhyIdx,
                                  ETHXCVR_CntxtType *const aCntxt,
                                  const ETHXCVR_PortConfigType *const aConfig,
                                  ETHXCVR_BooleanType *const aMode)
{
    return BCM_ERR_NOSUPPORT;
}

/**
    @brief Get Wakeup Reason

    This API Provides wakeup reason if wakeupMode is enabled and wakeup detected

    @anchor BCM_ERR_NOSUPPORT

    @behavior Sync, Non re-entrant

    @pre None

    @param[in]      aPhyIdx        Port index
    @param[in]      aPhyCntxt      Pointer to PHY context structure
    @param[in]      aConfig        Pointer to Configuration
    @param[in]      aReason        Report Wakeup Reason

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_NOSUPPORT        NoSupport

    @post None

    @trace #BRCM_SWARCH_BRPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL

    @limitations None

    @code{.c}
    return BCM_ERR_NOSUPPORT
    @endcode

*/
int32_t BRPHY_CommonGetWakeUpReason(uint8_t aPhyIdx,
                                  ETHXCVR_CntxtType *const aCntxt,
                                  const ETHXCVR_PortConfigType *const aConfig,
                                  ETHXCVR_WakeupReasonType *const aReason)
{
    return BCM_ERR_NOSUPPORT;
}

/**
    @trace #BRCM_SWARCH_BRPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
*/
int32_t BRPHY_CommonSetAutoNegMode(uint8_t aPhyIdx,
                                    ETHXCVR_CntxtType *const aPhyCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig,
                                    ETHXCVR_BooleanType aAutonegMode)
{
    int32_t retVal;

    if (BRPHY_CORE_MAX_HW_ID <= aPhyIdx) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (ETHXCVR_STATE_INIT != BRPHY_RWData[aPhyIdx].state) {
        retVal = BCM_ERR_UNINIT;
    } else {
        retVal = BCM_ERR_NOSUPPORT;
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_BRPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
*/
int32_t BRPHY_CommonRestartAutoNeg(uint8_t aPhyIdx,
                                    ETHXCVR_CntxtType *const aPhyCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig)
{
    int32_t retVal;

    if (BRPHY_CORE_MAX_HW_ID <= aPhyIdx) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (ETHXCVR_STATE_INIT != BRPHY_RWData[aPhyIdx].state) {
        retVal = BCM_ERR_UNINIT;
    } else {
        retVal = BCM_ERR_NOSUPPORT;
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_BRPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
*/
int32_t BRPHY_CommonGetAutoNegStatus(uint8_t aPhyIdx,
                                      ETHXCVR_CntxtType *const aPhyCntxt,
                                      const ETHXCVR_PortConfigType *const aConfig,
                                      ETHXCVR_AutoNegStatusType *const aStatus)
{
    int32_t retVal = BCM_ERR_OK;

    if ((BRPHY_CORE_MAX_HW_ID <= aPhyIdx) || (NULL == aStatus)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (ETHXCVR_STATE_INIT != BRPHY_RWData[aPhyIdx].state) {
        retVal = BCM_ERR_UNINIT;
    } else {
        *aStatus = ETHXCVR_AUTONEGSTATUS_NO_ABILITY;
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_BRPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
*/
int32_t BRPHY_CommonGetStats(uint8_t aPhyIdx,
                              ETHXCVR_CntxtType *const aPhyCntxt,
                              const ETHXCVR_PortConfigType *const aConfig,
                              ETHXCVR_StatsType *const aStats)
{
    int32_t retVal = BCM_ERR_OK;

    if ((BRPHY_CORE_MAX_HW_ID <= aPhyIdx) || (NULL == aStats)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (ETHXCVR_STATE_INIT != BRPHY_RWData[aPhyIdx].state) {
        retVal = BCM_ERR_UNINIT;
    } else {
        aStats->linkStateChangeCount =
            BRPHY_RWData[aPhyIdx].linkStateChangeCount;
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_BRPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
*/
int32_t BRPHY_CommonStateHandler(uint8_t aPhyIdx,
                                  ETHXCVR_CntxtType *const aPhyCntxt,
                                  const ETHXCVR_PortConfigType *const aConfig,
                                  uint32_t *const aIsModeChanged,
                                  ETHXCVR_ModeType *const aMode)
{
    int32_t retVal;

    if ((BRPHY_CORE_MAX_HW_ID <= aPhyIdx)
            || (NULL == aConfig)
            || (NULL == aIsModeChanged)
            || (NULL == aMode)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (ETHXCVR_STATE_INIT != BRPHY_RWData[aPhyIdx].state) {
        retVal = BCM_ERR_UNINIT;
    } else {
        retVal = BCM_ERR_OK;
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_BRPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
*/
int32_t BRPHY_CommonUpdateHWStatus(uint8_t aPhyIdx,
                                    ETHXCVR_CntxtType *const aPhyCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig)
{
    int32_t retVal = BCM_ERR_OK;

    if (BRPHY_CORE_MAX_HW_ID <= aPhyIdx) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (ETHXCVR_STATE_INIT != BRPHY_RWData[aPhyIdx].state) {
        retVal = BCM_ERR_UNINIT;
    } else {
        retVal = BCM_ERR_NOSUPPORT;
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_BRPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
*/
int32_t BRPHY_CommonLinkIRQHandler(uint8_t aPhyIdx,
                                    ETHXCVR_CntxtType *const aPhyCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig)
{
    int32_t retVal = BCM_ERR_OK;

    if (ETHXCVR_STATE_INIT != BRPHY_RWData[aPhyIdx].state) {
        retVal = BCM_ERR_UNINIT;
    } else {
        BRPHY_RWData[aPhyIdx].intStatus |= BRPHY_CORE_REGS[aPhyIdx]->base1a;
        if ((BRPHY_RWData[aPhyIdx].intStatus & BRPHY_CORE_BASE1A_LINK_STATUS_CHANGE_MASK)
                == BRPHY_CORE_BASE1A_LINK_STATUS_CHANGE_MASK) {
            BRPHY_RWData[aPhyIdx].intStatus = 0U;
            retVal = BRPHY_CommonGetLinkState(aPhyIdx, aPhyCntxt, aConfig,
                    &(BRPHY_RWData[aPhyIdx].linkState));
            if (BCM_ERR_OK == retVal) {
                BRPHY_RWData[aPhyIdx].isLinkStateChanged = TRUE;
                (BRPHY_RWData[aPhyIdx].linkStateChangeCount)++;
            }
        }
    }
    return retVal;
}

/**
    @trace #BRCM_SWARCH_BRPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
*/
int32_t BRPHY_CommonLinkChangeIndHandler(uint8_t aPhyIdx,
                                   ETHXCVR_CntxtType *const aPhyCntxt,
                                   const ETHXCVR_PortConfigType *const aConfig,
                                   ETHXCVR_LinkStateType *const aLinkState,
                                   uint32_t *const aIsLinkStateChanged)
{
    int32_t retVal = BCM_ERR_OK;

    if (ETHXCVR_STATE_INIT != BRPHY_RWData[aPhyIdx].state) {
        retVal = BCM_ERR_UNINIT;
    } else {
        if (TRUE == BRPHY_RWData[aPhyIdx].isLinkStateChanged) {
            BRPHY_RWData[aPhyIdx].isLinkStateChanged = FALSE;
            *aLinkState = BRPHY_RWData[aPhyIdx].linkState;
            *aIsLinkStateChanged = TRUE;
        } else {
            *aIsLinkStateChanged = FALSE;
        }
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_BRPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
*/
const ETHXCVR_FuncTblType BRPHY_FuncTbl = {
    .init = BRPHY_CommonInit,
    .deinit = BRPHY_CommonDeInit,
    .reset = BRPHY_CommonReset,
    .setMode = BRPHY_SetMode,
    .getMode = BRPHY_CommonGetMode,
    .setMasterMode = BRPHY_SetMasterMode,
    .getMasterMode = BRPHY_GetMasterMode,
    .getSpeed = BRPHY_CommonGetSpeed,
    .setSpeed = BRPHY_CommonSetSpeed,
    .getDuplexMode = BRPHY_CommonGetDuplexMode,
    .setDuplexMode = BRPHY_CommonSetDuplexMode,
    .setFlowControl = BRPHY_CommonSetFlowControl,
    .getFlowControl = BRPHY_CommonGetFlowControl,
    .getLinkState = BRPHY_CommonGetLinkState,
    .getSQIValue = BRPHY_GetSQIValue,
    .setLoopbackMode = BRPHY_SetLoopbackMode,
    .getLoopbackMode = BRPHY_GetLoopbackMode,
    .setJumboMode = BRPHY_CommonSetJumboMode,
    .getJumboMode = BRPHY_CommonGetJumboMode,
    .setWakeUpMode = BRPHY_CommonSetWakeUpMode,
    .getWakeUpMode = BRPHY_CommonGetWakeUpMode,
    .getWakeUpReason = BRPHY_CommonGetWakeUpReason,
    .setAutoNegMode = BRPHY_CommonSetAutoNegMode,
    .getAutoNegStatus = BRPHY_GetAutoNegStatus,
    .restartAutoNeg = BRPHY_RestartAutoNeg,
    .getStats = BRPHY_CommonGetStats,
    .stateHandler = BRPHY_CommonStateHandler,
    .updateHWStatus = BRPHY_CommonUpdateHWStatus,
    .linkChangeIndHandler = BRPHY_CommonLinkChangeIndHandler,
    .linkIRQHandler  = BRPHY_CommonLinkIRQHandler,
};

/** @} */
