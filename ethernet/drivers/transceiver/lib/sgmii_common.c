/*****************************************************************************
 Copyright 2017-2021 Broadcom Limited.  All rights reserved.

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
    @addtogroup grp_eth_xcvrdrv_sgmii_common_imp
    @{

    @file sgmii_common.c
    @brief This file implements the common SGMII Driver for all chip families.

    @version 0.1 Initial draft
*/

#include <string.h>
#include <compiler.h>
#include <bcm_utils.h>
#include <bcm_err.h>
#include <ethxcvr.h>
#include <ethxcvr_osil.h>
#include <sgmiipcie_usercl22_rdb.h>
#include <sgmiipcie_digital_rdb.h>
#if defined(__BCM8957X__)
#include <sgmiipcie_cl22_rdb.h>
#endif
#include <sgmii_digital_rdb.h>
#include <sgmii_common.h>

/**
    @name SGMII driver Design IDs
    @{
    @brief Design IDs for SGMII driver
*/
#define BRCM_SWDSGN_SGMII_COMMONINIT_PROC                    (0xBA01U)    /**< @brief #SGMII_CommonInit                 */
#define BRCM_SWDSGN_SGMII_COMMONRESET_PROC                   (0xBA02U)    /**< @brief #SGMII_CommonReset                */
#define BRCM_SWDSGN_SGMII_COMMONGETSQIVALUE_PROC             (0xBA03U)    /**< @brief #SGMII_CommonGetSQIValue          */
#define BRCM_SWDSGN_SGMII_COMMONGETDUPLEXMODE_PROC           (0xBA04U)    /**< @brief #SGMII_CommonGetDuplexMode        */
#define BRCM_SWDSGN_SGMII_COMMONGETSPEED_PROC                (0xBA05U)    /**< @brief #SGMII_CommonGetSpeed             */
#define BRCM_SWDSGN_SGMII_COMMONGETLINKSTATE_PROC            (0xBA06U)    /**< @brief #SGMII_CommonGetLinkState         */
#define BRCM_SWDSGN_SGMII_COMMONGETMASTERMODE_PROC           (0xBA07U)    /**< @brief #SGMII_CommonGetMasterMode        */
#define BRCM_SWDSGN_SGMII_COMMONSETMASTERMODE_PROC           (0xBA08U)    /**< @brief #SGMII_CommonSetMasterMode        */
#define BRCM_SWDSGN_SGMII_COMMONGETMODE_PROC                 (0xBA09U)    /**< @brief #SGMII_CommonGetMode              */
#define BRCM_SWDSGN_SGMII_COMMONSETMODE_PROC                 (0xBA0AU)    /**< @brief #SGMII_CommonSetMode              */
#define BRCM_SWDSGN_SGMII_COMMONLINKIRQHANDLER_PROC          (0xBA0BU)    /**< @brief #SGMII_CommonLinkIRQHandler       */
#define BRCM_SWDSGN_SGMII_COMMONLINKCHANGEINDHANDLER_PROC    (0xBA0CU)    /**< @brief #SGMII_CommonLinkChangeIndHandler */
#define BRCM_SWDSGN_SGMII_COMMONDEINIT_PROC                  (0xBA0DU)    /**< @brief #SGMII_CommonDeInit               */
#define BRCM_SWDSGN_SGMII_COMMONGETLOOPBACKMODE_PROC         (0xBA0EU)    /**< @brief #SGMII_CommonGetLoopbackMode      */
#define BRCM_SWDSGN_SGMII_COMMONSETLOOPBACKMODE_PROC         (0xBA0FU)    /**< @brief #SGMII_CommonSetLoopbackMode      */
#define BRCM_SWDSGN_SGMII_COMMONGETJUMBOMODE_PROC            (0xBA10U)    /**< @brief #SGMII_CommonGetJumboMode         */
#define BRCM_SWDSGN_SGMII_COMMONSETJUMBOMODE_PROC            (0xBA11U)    /**< @brief #SGMII_CommonSetJumboMode         */
#define BRCM_SWDSGN_SGMII_COMMONSETAUTONEGMODE_PROC          (0xBA12U)    /**< @brief #SGMII_CommonSetAutoNegMode       */
#define BRCM_SWDSGN_SGMII_COMMONGETAUTONEGSTATUS_PROC        (0xBA13U)    /**< @brief #SGMII_CommonGetAutoNegStatus     */
#define BRCM_SWDSGN_SGMII_COMMONGETSTATS_PROC                (0xBA14U)    /**< @brief #SGMII_CommonGetStats             */
#define BRCM_SWDSGN_SGMII_COMMONSETDUPLEXMODE_PROC           (0xBA15U)    /**< @brief #SGMII_CommonSetDuplexMode        */
#define BRCM_SWDSGN_SGMII_COMMONSETFLOWCONTROL_PROC          (0xBA16U)    /**< @brief #SGMII_CommonSetFlowControl       */
#define BRCM_SWDSGN_SGMII_COMMONGETFLOWCONTROL_PROC          (0xBA17U)    /**< @brief #SGMII_CommonGetFlowControl       */
#define BRCM_SWDSGN_SGMII_COMMONRESTARTAUTONEG_PROC          (0xBA18U)    /**< @brief #SGMII_CommonRestartAutoNeg       */
#define BRCM_SWDSGN_SGMII_COMMONSTATEHANDLER_PROC            (0xBA19U)    /**< @brief #SGMII_CommonStateHandler         */
#define BRCM_SWDSGN_SGMII_COMMONUPDATEHWSTATUS_PROC          (0xBA1AU)    /**< @brief #SGMII_CommonUpdateHWStatus       */
#define BRCM_SWDSGN_SGMII_CL22_IEEE_REG_GLOBAL               (0xBA1BU)    /**< @brief #SGMII_CL22_IEEE_REG              */
#define BRCM_SWDSGN_SGMII_DIGITAL_REGS_GLOBAL                (0xBA1CU)    /**< @brief #SGMII_DIGITAL_REGS               */
#define BRCM_SWDSGN_SGMII_FUNCTBL_GLOBAL                     (0xBA1DU)    /**< @brief #SGMII_FuncTbl                    */
/** @} */

/**
    @brief SGMII IEEE CL22 block base addresses

    @trace #BRCM_SWARCH_SGMII_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMII_FUNCTBL
*/
SGMII_COMBO_RDBType * const SGMII_CL22_IEEE_REG[SGMII_MAX_HW_ID] =
{
#if (SGMII_MAX_HW_ID == 0UL)
#error "SGMII_MAX_HW_ID == 0UL"
#endif
    (SGMII_COMBO_RDBType *const)SGMII0_CL22_IEEE_BASE,
#if (SGMII_MAX_HW_ID > 1UL)
    (SGMII_COMBO_RDBType *const)SGMII1_CL22_IEEE_BASE,
#endif
#if (SGMII_MAX_HW_ID > 2UL)
    (SGMII_COMBO_RDBType *const)SGMII2_CL22_IEEE_BASE,
#endif
#if (SGMII_MAX_HW_ID > 3UL)
    (SGMII_COMBO_RDBType *const)SGMII3_CL22_IEEE_BASE,
#endif
#if (SGMII_MAX_HW_ID > 4UL)
    (SGMII_COMBO_RDBType *const)SGMII4_CL22_IEEE_BASE,
#endif
#if (SGMII_MAX_HW_ID > 5UL)
#error "SGMII_MAX_HW_ID > 5UL is not supported"
#endif
};

/**
    @brief SGMII digital block base addresses

    @trace #BRCM_SWARCH_SGMII_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMII_FUNCTBL
*/
static SGMII_DIGITAL_RDBType * const SGMII_DIGITAL_REGS[SGMII_MAX_HW_ID] =
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
    @trace #BRCM_SWARCH_SGMII_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMII_FUNCTBL
*/
int32_t SGMII_CommonGetLinkState(uint8_t aBusIdx,
                                  ETHXCVR_CntxtType *const aCntxt,
                                  const ETHXCVR_PortConfigType *const aConfig,
                                  ETHXCVR_LinkStateType *const aLinkState)
{
    uint16_t miiStat;
    int32_t retVal = BCM_ERR_OK;

    if ((SGMII_MAX_HW_ID <= aBusIdx)
            || (NULL == aLinkState)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (ETHXCVR_STATE_INIT != SGMII_RWData[aBusIdx].state) {
        retVal = BCM_ERR_UNINIT;
    } else {
        *aLinkState = ETHXCVR_LINKSTATE_DOWN;
        miiStat = SGMII_CL22_IEEE_REG[aBusIdx]->miistat;
        miiStat = SGMII_CL22_IEEE_REG[aBusIdx]->miistat;

        if ((miiStat & SGMII_COMBO_MIISTAT_LINK_STATUS_MASK) == SGMII_COMBO_MIISTAT_LINK_STATUS_MASK) {
            *aLinkState = ETHXCVR_LINKSTATE_ACTIVE;
        }
    }
    return retVal;
}

/**
    @trace #BRCM_SWARCH_SGMII_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMII_FUNCTBL
*/
int32_t SGMII_CommonReset(uint8_t aBusIdx,
                           ETHXCVR_CntxtType *const aCntxt,
                           const ETHXCVR_PortConfigType *const aConfig)
{
    int32_t retVal = BCM_ERR_OK;
    uint32_t loopCnt;

    if (SGMII_MAX_HW_ID <= aBusIdx) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (ETHXCVR_STATE_INIT != SGMII_RWData[aBusIdx].state) {
        retVal = BCM_ERR_UNINIT;
    } else {
        SGMII_CL22_IEEE_REG[aBusIdx]->miicntl |= SGMII_COMBO_MIICNTL_RST_HW_MASK;
        /* Wait for Reset bit to auto clear */
        loopCnt = SGMII_RESET_TIMEOUT_LOOPCNT;
        while (((SGMII_CL22_IEEE_REG[aBusIdx]->miicntl
                        & SGMII_COMBO_MIICNTL_RST_HW_MASK) == SGMII_COMBO_MIICNTL_RST_HW_MASK)
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
    @trace #BRCM_SWARCH_SGMII_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMII_FUNCTBL
*/
int32_t SGMII_CommonSetMode(uint8_t aBusIdx,
                             ETHXCVR_CntxtType *const aCntxt,
                             const ETHXCVR_PortConfigType *const aConfig,
                             ETHXCVR_ModeType aMode)
{
    int32_t retVal = BCM_ERR_OK;
    uint32_t loopCnt = 0UL;
    uint16_t regVal;

    if (SGMII_MAX_HW_ID <= aBusIdx) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (ETHXCVR_STATE_INIT != SGMII_RWData[aBusIdx].state) {
        retVal = BCM_ERR_UNINIT;
    } else {
        if (ETHXCVR_MODE_ACTIVE == aMode) {
            regVal = (uint16_t)SGMII_CL22_IEEE_REG[aBusIdx]->miicntl;
            regVal &= (~SGMII_COMBO_MIICNTL_PWRDWN_SW_MASK);
            SGMII_CL22_IEEE_REG[aBusIdx]->miicntl = regVal;
            do {
                regVal = SGMII_CL22_IEEE_REG[aBusIdx]->miicntl;
                loopCnt++;
            } while (((regVal & SGMII_COMBO_MIICNTL_PWRDWN_SW_MASK) != 0U)
                    && (SGMII_POWER_DOWN_BIT_TIMEOUT_CNT > loopCnt));
        }

        if (ETHXCVR_MODE_DOWN == aMode) {
            regVal = SGMII_CL22_IEEE_REG[aBusIdx]->miicntl;
            regVal |= (SGMII_COMBO_MIICNTL_PWRDWN_SW_MASK);
            SGMII_CL22_IEEE_REG[aBusIdx]->miicntl = regVal;
            do {
                regVal = SGMII_CL22_IEEE_REG[aBusIdx]->miicntl;
                loopCnt++;
            } while (((regVal & SGMII_COMBO_MIICNTL_PWRDWN_SW_MASK) == 0U)
                    && (SGMII_POWER_DOWN_BIT_TIMEOUT_CNT > loopCnt));
        }

        if (SGMII_POWER_DOWN_BIT_TIMEOUT_CNT == loopCnt) {
            retVal = BCM_ERR_TIME_OUT;
        }
    }
    if(BCM_ERR_OK == retVal) {
        SGMII_RWData[aBusIdx].isConfigDone = (ETHXCVR_BooleanType)ETHXCVR_BOOLEAN_TRUE;
    }
    return retVal;
}

/**
    @trace #BRCM_SWARCH_SGMII_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMII_FUNCTBL
*/
int32_t SGMII_CommonGetMode(uint8_t aBusIdx,
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
        if ((SGMII_CL22_IEEE_REG[aBusIdx]->miicntl & mask) == 0U) {
            *aMode = ETHXCVR_MODE_ACTIVE;
        } else {
            *aMode = ETHXCVR_MODE_DOWN;
        }
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_SGMII_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMII_FUNCTBL
*/
int32_t SGMII_CommonSetMasterMode(uint8_t aBusIdx,
                             ETHXCVR_CntxtType *const aCntxt,
                                   const ETHXCVR_PortConfigType *const aConfig,
                                   ETHXCVR_BooleanType aMasterMode)
{
    int32_t retVal = BCM_ERR_OK;

    if (SGMII_MAX_HW_ID <= aBusIdx) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        if (ETHXCVR_STATE_INIT != SGMII_RWData[aBusIdx].state) {
            retVal = BCM_ERR_UNINIT;
        } else {
            retVal = BCM_ERR_NOSUPPORT;
        }
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_SGMII_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMII_FUNCTBL
*/
int32_t SGMII_CommonGetMasterMode(uint8_t aBusIdx,
                                   ETHXCVR_CntxtType *const aCntxt,
                                   const ETHXCVR_PortConfigType *const aConfig,
                                   ETHXCVR_BooleanType *const aMasterMode)
{
    int32_t retVal = BCM_ERR_OK;

    if (SGMII_MAX_HW_ID <= aBusIdx) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        if (ETHXCVR_STATE_INIT != SGMII_RWData[aBusIdx].state) {
            retVal = BCM_ERR_UNINIT;
        } else {
            retVal = BCM_ERR_NOSUPPORT;
        }
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_SGMII_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMII_FUNCTBL
*/
int32_t SGMII_CommonGetSpeed(uint8_t aBusIdx,
                              ETHXCVR_CntxtType *const aCntxt,
                              const ETHXCVR_PortConfigType *const aConfig,
                              ETHXCVR_SpeedType *const aSpeed)
{
    int32_t retVal = BCM_ERR_OK;
    uint16_t speedBits = 0U;
    uint16_t regVal;

    if ((SGMII_MAX_HW_ID <= aBusIdx) || (NULL == aSpeed)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (ETHXCVR_STATE_INIT != SGMII_RWData[aBusIdx].state) {
        retVal = BCM_ERR_UNINIT;
    } else {
        regVal = SGMII_CL22_IEEE_REG[aBusIdx]->miicntl;
        if ((regVal & SGMII_COMBO_MIICNTL_AUTONEG_ENABLE_MASK) != 0U) {
            *aSpeed = ETHXCVR_SPEED_1000MBPS;
        } else {
            speedBits |= ((regVal & SGMII_COMBO_MIICNTL_MANUAL_SPEED1_MASK)
                    >> (SGMII_COMBO_MIICNTL_MANUAL_SPEED1_SHIFT - 1U));
            speedBits |= ((regVal & SGMII_COMBO_MIICNTL_MANUAL_SPEED0_MASK)
                    >> SGMII_COMBO_MIICNTL_MANUAL_SPEED0_SHIFT);
            switch (speedBits) {
            case 0U:
                *aSpeed = ETHXCVR_SPEED_10MBPS;
                break;
            case 1U:
                *aSpeed = ETHXCVR_SPEED_100MBPS;
                break;
            case 2U:
                *aSpeed = ETHXCVR_SPEED_1000MBPS;
                break;
            default:
                retVal = BCM_ERR_UNKNOWN;
                break;
            }
            if ((BCM_ERR_OK == retVal) && (ETHXCVR_SPEED_1000MBPS == *aSpeed)) {
                regVal = SGMII_DIGITAL_REGS[aBusIdx]->misc1;
                switch ((regVal & SGMII_DIGITAL_MISC1_FORCE_SPEED_MASK)
                        >> SGMII_DIGITAL_MISC1_FORCE_SPEED_SHIFT) {
                    case SGMII_DIGITAL_MISC1_FORCE_SPEED_5000M:
                        *aSpeed = ETHXCVR_SPEED_5000MBPS;
                        break;
                    case SGMII_DIGITAL_MISC1_FORCE_SPEED_2500M:
                        *aSpeed = ETHXCVR_SPEED_2500MBPS;
                        break;
                    default:
                        break;
                }
            }
        }
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_SGMII_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMII_FUNCTBL
*/
int32_t SGMII_CommonGetDuplexMode(uint8_t aBusIdx,
                                   ETHXCVR_CntxtType *const aCntxt,
                                   const ETHXCVR_PortConfigType *const aConfig,
                                   ETHXCVR_DuplexModeType *const aDuplexMode)
{
    int32_t retVal = BCM_ERR_OK;
    uint16_t miiCtrl;

    if ((SGMII_MAX_HW_ID <= aBusIdx) || (NULL == aDuplexMode)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (ETHXCVR_STATE_INIT != SGMII_RWData[aBusIdx].state) {
        retVal = BCM_ERR_UNINIT;
    } else {
        *aDuplexMode = ETHXCVR_DUPLEXMODE_HALF;
        miiCtrl = SGMII_CL22_IEEE_REG[aBusIdx]->miicntl;
        if ((miiCtrl & SGMII_COMBO_MIICNTL_FULL_DUPLEX_MASK) != 0U) {
            *aDuplexMode = ETHXCVR_DUPLEXMODE_FULL;
        }
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_SGMII_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMII_FUNCTBL
*/
int32_t SGMII_CommonSetDuplexMode(uint8_t aBusIdx,
                                   ETHXCVR_CntxtType *const aCntxt,
                                   const ETHXCVR_PortConfigType *const aConfig,
                                   ETHXCVR_DuplexModeType aDuplexMode)
{
    int32_t retVal = BCM_ERR_OK;

    if (SGMII_MAX_HW_ID <= aBusIdx) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (ETHXCVR_STATE_INIT != SGMII_RWData[aBusIdx].state) {
        retVal = BCM_ERR_UNINIT;
    } else {
        switch (aDuplexMode) {
            case ETHXCVR_DUPLEXMODE_HALF:
                SGMII_CL22_IEEE_REG[aBusIdx]->miicntl &= ~SGMII_COMBO_MIICNTL_FULL_DUPLEX_MASK;
                break;
            case ETHXCVR_DUPLEXMODE_FULL:
                SGMII_CL22_IEEE_REG[aBusIdx]->miicntl |= SGMII_COMBO_MIICNTL_FULL_DUPLEX_MASK;
                break;
            default:
                retVal = BCM_ERR_NOSUPPORT;
                break;
        }
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_SGMII_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMII_FUNCTBL
*/
int32_t SGMII_CommonGetFlowControl(uint8_t aBusIdx,
                                    ETHXCVR_CntxtType *const aCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig,
                                    ETHXCVR_FlowControlType *const aFlowControl)
{
    int32_t retVal = BCM_ERR_OK;

    if ((SGMII_MAX_HW_ID <= aBusIdx) || (NULL == aFlowControl)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (ETHXCVR_STATE_INIT != SGMII_RWData[aBusIdx].state) {
        retVal = BCM_ERR_UNINIT;
    } else {
        *aFlowControl = ETHXCVR_FLOWCONTROL_NONE;
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_SGMII_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMII_FUNCTBL
*/
int32_t SGMII_CommonSetFlowControl(uint8_t aBusIdx,
                                    ETHXCVR_CntxtType *const aCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig,
                                    ETHXCVR_FlowControlType aFlowControl)
{
    int32_t retVal = BCM_ERR_OK;

    if (SGMII_MAX_HW_ID <= aBusIdx) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (ETHXCVR_STATE_INIT != SGMII_RWData[aBusIdx].state) {
        retVal = BCM_ERR_UNINIT;
    } else {
        retVal = BCM_ERR_NOSUPPORT;
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_SGMII_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMII_FUNCTBL
*/
int32_t SGMII_CommonGetSQIValue(uint8_t aBusIdx,
                                 ETHXCVR_CntxtType *const aCntxt,
                                 const ETHXCVR_PortConfigType *const aConfig,
                                 uint32_t *const aSQIValue)
{
    int32_t retVal = BCM_ERR_OK;

    if ((SGMII_MAX_HW_ID <= aBusIdx) || (NULL == aSQIValue)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        if (ETHXCVR_STATE_INIT != SGMII_RWData[aBusIdx].state) {
            retVal = BCM_ERR_UNINIT;
        }
        *aSQIValue = 0;
    }
    return retVal;
}

/**
    @trace #BRCM_SWARCH_SGMII_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMII_FUNCTBL
*/
int32_t SGMII_CommonInit(uint8_t aBusIdx,
                          ETHXCVR_CntxtType *const aCntxt,
                          const ETHXCVR_PortConfigType *const aConfig)
{
    int32_t retVal = BCM_ERR_OK;


    if ((SGMII_MAX_HW_ID <= aBusIdx) || (NULL == aConfig)) {
        retVal = BCM_ERR_INVAL_PARAMS;
        goto err;
    }

    if (ETHXCVR_STATE_UNINIT != SGMII_RWData[aBusIdx].state) {
        retVal = BCM_ERR_INVAL_STATE;
        goto err;
    }

    SGMII_RWData[aBusIdx].state = ETHXCVR_STATE_INIT;
    SGMII_RWData[aBusIdx].jumboMode = aConfig->jumbo;
    SGMII_RWData[aBusIdx].isConfigDone = (ETHXCVR_BooleanType)ETHXCVR_BOOLEAN_FALSE;
err:
    return retVal;
}

/**
    @trace #BRCM_SWARCH_SGMII_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMII_FUNCTBL
*/
int32_t SGMII_CommonDeInit(uint8_t aBusIdx,
                            ETHXCVR_CntxtType *const aCntxt,
                            const ETHXCVR_PortConfigType *const aConfig)
{
    int32_t retVal = BCM_ERR_OK;


    if (SGMII_MAX_HW_ID <= aBusIdx) {
        retVal = BCM_ERR_INVAL_PARAMS;
        goto err;
    }

    if (ETHXCVR_STATE_INIT != SGMII_RWData[aBusIdx].state) {
        retVal = BCM_ERR_INVAL_STATE;
        goto err;
    }

    SGMII_RWData[aBusIdx].state = ETHXCVR_STATE_UNINIT;
    SGMII_RWData[aBusIdx].isConfigDone = (ETHXCVR_BooleanType)ETHXCVR_BOOLEAN_FALSE;
err:
    return retVal;
}

/**
    @trace #BRCM_SWARCH_SGMII_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMII_FUNCTBL
*/
int32_t SGMII_CommonSetLoopbackMode(uint8_t aBusIdx,
                                     ETHXCVR_CntxtType *const aCntxt,
                                     const ETHXCVR_PortConfigType *const aConfig,
                                     ETHXCVR_BooleanType aMode)
{
    int32_t retVal = BCM_ERR_OK;

    if (SGMII_MAX_HW_ID <= aBusIdx) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (ETHXCVR_STATE_INIT != SGMII_RWData[aBusIdx].state) {
        retVal = BCM_ERR_UNINIT;
    } else {
        if ((ETHXCVR_BooleanType)ETHXCVR_BOOLEAN_TRUE == aMode) {
            SGMII_CL22_IEEE_REG[aBusIdx]->miicntl |=
                SGMII_COMBO_MIICNTL_GLOOPBACK_MASK;
        } else {
            SGMII_CL22_IEEE_REG[aBusIdx]->miicntl &= ~SGMII_COMBO_MIICNTL_GLOOPBACK_MASK;
        }
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_SGMII_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMII_FUNCTBL
*/
int32_t SGMII_CommonGetLoopbackMode(uint8_t aBusIdx,
                                     ETHXCVR_CntxtType *const aCntxt,
                                     const ETHXCVR_PortConfigType *const aConfig,
                                     ETHXCVR_BooleanType *const aMode)
{
    int32_t retVal = BCM_ERR_OK;

    if ((SGMII_MAX_HW_ID <= aBusIdx) || (NULL == aMode)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (ETHXCVR_STATE_INIT != SGMII_RWData[aBusIdx].state) {
        retVal = BCM_ERR_UNINIT;
    } else {
        if ((SGMII_CL22_IEEE_REG[aBusIdx]->miicntl
                    & SGMII_COMBO_MIICNTL_GLOOPBACK_MASK) == SGMII_COMBO_MIICNTL_GLOOPBACK_MASK) {
            *aMode = (ETHXCVR_BooleanType)ETHXCVR_BOOLEAN_TRUE;
        } else {
            *aMode = (ETHXCVR_BooleanType)ETHXCVR_BOOLEAN_FALSE;
        }
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_SGMII_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMII_FUNCTBL
*/
int32_t SGMII_CommonSetJumboMode(uint8_t aBusIdx,
                                  ETHXCVR_CntxtType *const aCntxt,
                                  const ETHXCVR_PortConfigType *const aConfig,
                                  ETHXCVR_BooleanType aMode)
{
    int32_t retVal;

    if (SGMII_MAX_HW_ID <= aBusIdx) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (ETHXCVR_STATE_INIT != SGMII_RWData[aBusIdx].state) {
        retVal = BCM_ERR_UNINIT;
    } else {
        SGMII_RWData[aBusIdx].jumboMode = aMode;
        retVal = BCM_ERR_OK;
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_SGMII_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMII_FUNCTBL
*/
int32_t SGMII_CommonGetJumboMode(uint8_t aBusIdx,
                                  ETHXCVR_CntxtType *const aCntxt,
                                  const ETHXCVR_PortConfigType *const aConfig,
                                  ETHXCVR_BooleanType *const aMode)
{
    int32_t retVal;

    if ((SGMII_MAX_HW_ID <= aBusIdx) || (NULL == aMode)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (ETHXCVR_STATE_INIT != SGMII_RWData[aBusIdx].state) {
        retVal = BCM_ERR_UNINIT;
    } else {
        *aMode = SGMII_RWData[aBusIdx].jumboMode;
        retVal = BCM_ERR_OK;
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_SGMII_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMII_FUNCTBL
*/
int32_t SGMII_CommonSetAutoNegMode(uint8_t aBusIdx,
                                    ETHXCVR_CntxtType *const aCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig,
                                    ETHXCVR_BooleanType aMode)
{
    int32_t retVal;

    if (SGMII_MAX_HW_ID <= aBusIdx) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (ETHXCVR_STATE_INIT != SGMII_RWData[aBusIdx].state) {
        retVal = BCM_ERR_UNINIT;
    } else {
        retVal = BCM_ERR_NOSUPPORT;
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_SGMII_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMII_FUNCTBL
*/
int32_t SGMII_CommonRestartAutoNeg(uint8_t aBusIdx,
                                    ETHXCVR_CntxtType *const aCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig)
{
    int32_t retVal;

    if (SGMII_MAX_HW_ID <= aBusIdx) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (ETHXCVR_STATE_INIT != SGMII_RWData[aBusIdx].state) {
        retVal = BCM_ERR_UNINIT;
    } else {
        retVal = BCM_ERR_NOSUPPORT;
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_SGMII_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMII_FUNCTBL
*/
int32_t SGMII_CommonGetAutoNegStatus(uint8_t aBusIdx,
                                    ETHXCVR_CntxtType *const aCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig,
                                    ETHXCVR_AutoNegStatusType *const aStatus)
{
    int32_t retVal = BCM_ERR_OK;
    uint16_t miiStat;

    if ((SGMII_MAX_HW_ID <= aBusIdx) || (NULL == aStatus)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (ETHXCVR_STATE_INIT != SGMII_RWData[aBusIdx].state) {
        retVal = BCM_ERR_UNINIT;
    } else {
        miiStat = SGMII_CL22_IEEE_REG[aBusIdx]->miistat;
        miiStat = SGMII_CL22_IEEE_REG[aBusIdx]->miistat;

        if (SGMII_COMBO_MIISTAT_AUTONEG_ABILITY_MASK
                    == (miiStat & SGMII_COMBO_MIISTAT_AUTONEG_ABILITY_MASK)) {
            *aStatus = ETHXCVR_AUTONEGSTATUS_INCOMPLETE;
            /* BCM8956X A0 had a problem with AutoNeg Enable. Writing autoneg Enable
              to any one controller enables AutoNeg in all the other controllers.
              So as a workaround Read the Autoneg status if AutoNeg is Enabled in the Config.
              If AutoNeg is Not Enabled then Status to be updated as Incomplete */
            if(((ETHXCVR_BooleanType)ETHXCVR_BOOLEAN_TRUE == aConfig->autoNeg)
                && (SGMII_COMBO_MIISTAT_AUTONEG_COMPLETE_MASK == (miiStat & SGMII_COMBO_MIISTAT_AUTONEG_COMPLETE_MASK))) {
                *aStatus = ETHXCVR_AUTONEGSTATUS_COMPLETE;
            }
        } else {
            *aStatus = ETHXCVR_AUTONEGSTATUS_NO_ABILITY;
        }
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_SGMII_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMII_FUNCTBL
*/
int32_t SGMII_CommonGetStats(uint8_t aBusIdx,
                              ETHXCVR_CntxtType *const aCntxt,
                              const ETHXCVR_PortConfigType *const aConfig,
                              ETHXCVR_StatsType *const aStats)
{
    int32_t retVal = BCM_ERR_OK;

    if ((SGMII_MAX_HW_ID <= aBusIdx) || (NULL == aStats)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (ETHXCVR_STATE_INIT != SGMII_RWData[aBusIdx].state) {
        retVal = BCM_ERR_UNINIT;
    } else {
        aStats->linkStateChangeCount =
            SGMII_RWData[aBusIdx].linkStateChangeCount;
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_SGMII_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMII_FUNCTBL
*/
int32_t SGMII_CommonStateHandler(uint8_t aBusIdx,
                                  ETHXCVR_CntxtType *const aCntxt,
                                  const ETHXCVR_PortConfigType *const aConfig,
                                  uint32_t *const aIsModeChanged,
                                  ETHXCVR_ModeType *const aMode)
{
    int32_t retVal;

    if (SGMII_MAX_HW_ID <= aBusIdx) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (ETHXCVR_STATE_INIT != SGMII_RWData[aBusIdx].state) {
        retVal = BCM_ERR_UNINIT;
    } else {
        retVal = BCM_ERR_OK;
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_SGMII_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMII_FUNCTBL
*/
int32_t SGMII_CommonUpdateHWStatus(uint8_t aBusIdx,
                                    ETHXCVR_CntxtType *const aCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig)
{
    int32_t retVal = BCM_ERR_OK;

    if (SGMII_MAX_HW_ID <= aBusIdx) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (ETHXCVR_STATE_INIT != SGMII_RWData[aBusIdx].state) {
        retVal = BCM_ERR_UNINIT;
    } else {
        retVal = BCM_ERR_NOSUPPORT;
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_SGMII_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMII_FUNCTBL
*/
int32_t SGMII_CommonLinkIRQHandler(uint8_t aBusIdx,
                             ETHXCVR_CntxtType *const aCntxt,
                             const ETHXCVR_PortConfigType *const aConfig)
{
    int32_t retVal = BCM_ERR_OK;

    if (ETHXCVR_STATE_INIT != SGMII_RWData[aBusIdx].state) {
        retVal = BCM_ERR_UNINIT;
    }
    return retVal;
}

/**
    @trace #BRCM_SWARCH_SGMII_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMII_FUNCTBL
*/
int32_t SGMII_CommonLinkChangeIndHandler(uint8_t aBusIdx,
                                   ETHXCVR_CntxtType *const aCntxt,
                                   const ETHXCVR_PortConfigType *const aConfig,
                                   ETHXCVR_LinkStateType *const aLinkState,
                                   uint32_t *const aIsLinkStateChanged)
{
    int32_t retVal = BCM_ERR_OK;

    if (ETHXCVR_STATE_INIT != SGMII_RWData[aBusIdx].state) {
        retVal = BCM_ERR_UNINIT;
    } else {
        *aIsLinkStateChanged = FALSE;
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_SGMII_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMII_FUNCTBL
*/
const ETHXCVR_FuncTblType SGMII_FuncTbl = {
    .init = SGMII_CommonInit,
    .deinit = SGMII_CommonDeInit,
    .reset = SGMII_CommonReset,
    .setMode = SGMII_SetMode,
    .getMode = SGMII_GetMode,
    .setMasterMode = SGMII_CommonSetMasterMode,
    .getMasterMode = SGMII_CommonGetMasterMode,
    .getSpeed = SGMII_CommonGetSpeed,
    .setSpeed = SGMII_SetSpeed,
    .getDuplexMode = SGMII_CommonGetDuplexMode,
    .setDuplexMode = SGMII_CommonSetDuplexMode,
    .setFlowControl = SGMII_CommonSetFlowControl,
    .getFlowControl = SGMII_CommonGetFlowControl,
    .getLinkState = SGMII_CommonGetLinkState,
    .getSQIValue = SGMII_CommonGetSQIValue,
    .setLoopbackMode = SGMII_CommonSetLoopbackMode,
    .getLoopbackMode = SGMII_CommonGetLoopbackMode,
    .setJumboMode = SGMII_CommonSetJumboMode,
    .getJumboMode = SGMII_CommonGetJumboMode,
    .setAutoNegMode = SGMII_CommonSetAutoNegMode,
    .getAutoNegStatus = SGMII_CommonGetAutoNegStatus,
    .restartAutoNeg = SGMII_CommonRestartAutoNeg,
    .getStats = SGMII_CommonGetStats,
    .stateHandler = SGMII_CommonStateHandler,
    .updateHWStatus = SGMII_CommonUpdateHWStatus,
    .linkChangeIndHandler = SGMII_CommonLinkChangeIndHandler,
    .linkIRQHandler  = SGMII_CommonLinkIRQHandler,
};

/** @} */
