/*****************************************************************************
 Copyright 2021 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_eth_xcvrdrv_brphy1gv2_impl BRPHY-1G V2 (MMAP based access) driver
    @ingroup grp_eth_xcvrdrv

    @addtogroup grp_eth_xcvrdrv_brphy1gv2_impl
    @{

    @file brphy1g.c
    @brief This file implements the BRPHY-1G Driver

    @version 0.1 Initial draft
*/

#include <string.h>
#include <compiler.h>
#include <bcm_utils.h>
#include <bcm_err.h>
#include <ethxcvr.h>
#include <ethxcvr_osil.h>
#include <brphy1g_v2_osil.h>
#include "brphy1gv2_autonegieee_rdb.h"
#include "brphy1gv2_pmapmdieee_rdb.h"
#include "brphy1gv2_ec_rdb.h"
#include "brphy1gv2_t1core_rdb.h"
#include "brphy1gv2_phycontrol_rdb.h"
#include "brphy1gv2_core_misc_rdb.h"
#include "brphy1gv2_pcs_ieee_rdb.h"

/**
    @name BRPHY1G driver Design IDs
    @{
    @brief Design IDs for BRPHY driver
*/
#define BRCM_SWDSGN_BRPHY1GV2_AUTONEG_IEEE_REGS_GLOBAL    (0xC701U) /**< @brief #BRPHY1GV2_AUTONEG_IEEE_REGS */
#define BRCM_SWDSGN_BRPHY1GV2_PMA_PMD_IEEE_REGS_GLOBAL    (0xC702U) /**< @brief #BRPHY1GV2_PMAPMD_IEEE_REGS */
#define BRCM_SWDSGN_BRPHY1GV2_FUNCTBL_GLOBAL              (0xC703U) /**< @brief #BRPHY1GV2_FuncTbl */
#define BRCM_SWDSGN_BRPHY1GV2_RWDATA_GLOBAL               (0xC704U) /**< @brief #BRPHY1GV2_RWData */
#define BRCM_SWDSGN_BRPHY1GV2_RWDATA_TYPE                 (0xC705U) /**< @brief #BRPHY1GV2_RWDataType */
#define BRCM_SWDSGN_BRPHY1GV2_INIT_PROC                   (0xC706U) /**< @brief #BRPHY1GV2_Init */
#define BRCM_SWDSGN_BRPHY1GV2_RESET_PROC                  (0xC707U) /**< @brief #BRPHY1GV2_Reset */
#define BRCM_SWDSGN_BRPHY1GV2_GETSQIVALUE_PROC            (0xC708U) /**< @brief #BRPHY1GV2_GetSQIValue */
#define BRCM_SWDSGN_BRPHY1GV2_GETDUPLEXMODE_PROC          (0xC709U) /**< @brief #BRPHY1GV2_GetDuplexMode */
#define BRCM_SWDSGN_BRPHY1GV2_GETSPEED_PROC               (0xC70AU) /**< @brief #BRPHY1GV2_GetSpeed */
#define BRCM_SWDSGN_BRPHY1GV2_GETLINKSTATE_PROC           (0xC70BU) /**< @brief #BRPHY1GV2_GetLinkState */
#define BRCM_SWDSGN_BRPHY1GV2_GETMODE_PROC                (0xC70CU) /**< @brief #BRPHY1GV2_GetMode */
#define BRCM_SWDSGN_BRPHY1GV2_LINKIRQHANDLER_PROC         (0xC70DU) /**< @brief #BRPHY1GV2_LinkIRQHandler */
#define BRCM_SWDSGN_BRPHY1GV2_LINKCHANGEINDHANDLER_PROC   (0xC70EU) /**< @brief #BRPHY1GV2_LinkChangeIndHandler */
#define BRCM_SWDSGN_BRPHY1GV2_DEINIT_PROC                 (0xC70FU) /**< @brief #BRPHY1GV2_DeInit */
#define BRCM_SWDSGN_BRPHY1GV2_SETSPEED_PROC               (0xC710U) /**< @brief #BRPHY1GV2_SetSpeed */
#define BRCM_SWDSGN_BRPHY1GV2_GETJUMBOMODE_PROC           (0xC711U) /**< @brief #BRPHY1GV2_GetJumboMode */
#define BRCM_SWDSGN_BRPHY1GV2_SETWAKEUPMODE_PROC          (0xC712U) /**< @brief #BRPHY1GV2_SetWakeUpMode */
#define BRCM_SWDSGN_BRPHY1GV2_GETWAKEUPMODE_PROC          (0xC713U) /**< @brief #BRPHY1GV2_GetWakeUpMode */
#define BRCM_SWDSGN_BRPHY1GV2_GETWAKEUPREASON_PROC        (0xC714U) /**< @brief #BRPHY1GV2_GetWakeUpReason */
#define BRCM_SWDSGN_BRPHY1GV2_SETJUMBOMODE_PROC           (0xC715U) /**< @brief #BRPHY1GV2_SetJumboMode */
#define BRCM_SWDSGN_BRPHY1GV2_SETAUTONEGMODE_PROC         (0xC716U) /**< @brief #BRPHY1GV2_SetAutoNegMode */
#define BRCM_SWDSGN_BRPHY1GV2_GETAUTONEGSTATUS_PROC       (0xC717U) /**< @brief #BRPHY1GV2_GetAutoNegStatus */
#define BRCM_SWDSGN_BRPHY1GV2_GETSTATS_PROC               (0xC718U) /**< @brief #BRPHY1GV2_GetStats */
#define BRCM_SWDSGN_BRPHY1GV2_SETDUPLEXMODE_PROC          (0xC719U) /**< @brief #BRPHY1GV2_SetDuplexMode */
#define BRCM_SWDSGN_BRPHY1GV2_SETFLOWCONTROL_PROC         (0xC71AU) /**< @brief #BRPHY1GV2_SetFlowControl */
#define BRCM_SWDSGN_BRPHY1GV2_GETFLOWCONTROL_PROC         (0xC71BU) /**< @brief #BRPHY1GV2_GetFlowControl */
#define BRCM_SWDSGN_BRPHY1GV2_RESTARTAUTONEG_PROC         (0xC71CU) /**< @brief #BRPHY1GV2_RestartAutoNeg */
#define BRCM_SWDSGN_BRPHY1GV2_STATEHANDLER_PROC           (0xC71DU) /**< @brief #BRPHY1GV2_StateHandler */
#define BRCM_SWDSGN_BRPHY1GV2_UPDATEHWSTATUS_PROC         (0xC71EU) /**< @brief #BRPHY1GV2_UpdateHWStatus */
#define BRCM_SWDSGN_BRPHY1GV2_SETMODE_PROC                (0xC71FU) /**< @brief #BRPHY1GV2_SetMode */
#define BRCM_SWDSGN_BRPHY1GV2_GETMASTERMODE_PROC          (0xC720U) /**< @brief #BRPHY1GV2_GetMasterMode */
#define BRCM_SWDSGN_BRPHY1GV2_SETMASTERMODE_PROC          (0xC721U) /**< @brief #BRPHY1GV2_SetMasterMode */
#define BRCM_SWDSGN_BRPHY1GV2_GETLOOPBACKMODE_PROC        (0xC722U) /**< @brief #BRPHY1GV2_GetLoopbackMode */
#define BRCM_SWDSGN_BRPHY1GV2_SETLOOPBACKMODE_PROC        (0xC723U) /**< @brief #BRPHY1GV2_SetLoopbackMode */
#define BRCM_SWDSGN_BRPHY1GV2_EC_REGS_GLOBAL              (0xC724U) /**< @brief #BRPHY1GV2_EC_REGS */
#define BRCM_SWDSGN_BRPHY1GV2_T1CORE_REGS_GLOBAL          (0xC725U) /**< @brief #BRPHY1GV2_T1CORE_REGS */
#define BRCM_SWDSGN_BRPHY1GV2_PHYCONTROL_REGS_GLOBAL      (0xC726U) /**< @brief #BRPHY1GV2_PHYCONTROL_REGS */
#define BRCM_SWDSGN_BRPHY1GV2_CORE_MISC_REGS_GLOBAL       (0xC727U) /**< @brief #BRPHY1GV2_CORE_MISC_REGS */
#define BRCM_SWDSGN_BRPHY1GV2_PCS_IEEE_REGS_GLOBAL        (0xC728U) /**< @brief #BRPHY1GV2_PCS_IEEE_REGS */

/** @} */

/**
    @brief BRPHY1G driver private data type

    @trace #BRCM_SWARCH_BRPHY1GV2_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY1GV2_FUNCTBL
*/
typedef struct sBRPHY1GV2_RWDataType {
    ETHXCVR_ModeType  mode; /**< @brief Cached mode */
} BRPHY1GV2_RWDataType;

/**
    @brief BRPHY1G driver private data

    @trace #BRCM_SWARCH_BRPHY1GV2_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY1GV2_FUNCTBL
*/
BRPHY1GV2_RWDataType BRPHY1GV2_RWData COMP_SECTION(".bss.drivers");

/**
    @brief BRPHY1G AUTONEG IEEE block base address

    @trace #BRCM_SWARCH_BRPHY1GV2_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY1GV2_FUNCTBL
*/
BRPHY1GV2_AUTONEGIEEE_RDBType * const BRPHY1GV2_AUTONEG_IEEE_REGS = (BRPHY1GV2_AUTONEGIEEE_RDBType *const)BRPHY1GV2_AUTONEGIEEE_BASE;

/**
    @brief BRPHY1G PMA PMD IEEE block base address

    @trace #BRCM_SWARCH_BRPHY1GV2_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY1GV2_FUNCTBL
*/
BRPHY1GV2_PMAPMDIEEE_RDBType * const BRPHY1GV2_PMAPMD_IEEE_REGS = (BRPHY1GV2_PMAPMDIEEE_RDBType *const)BRPHY1GV2_PMAPMDIEEE_BASE;

/**
    @brief BRPHY1G PMA PMD IEEE block base address

    @trace #BRCM_SWARCH_BRPHY1GV2_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY1GV2_FUNCTBL
*/
BRPHY1GV2_PCS_IEEE_RDBType * const BRPHY1GV2_PCS_IEEE_REGS = (BRPHY1GV2_PCS_IEEE_RDBType *const)BRPHY1GV2_PCS_IEEE_BASE;

/**
    @brief BRPHY1G EC block base address

    @trace #BRCM_SWARCH_BRPHY1GV2_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY1GV2_FUNCTBL
*/
BRPHY1GV2_EC_RDBType * const BRPHY1GV2_EC_REGS = (BRPHY1GV2_EC_RDBType *const)BRPHY1GV2_EC_BASE;

/**
    @brief BRPHY1G T1 CORE block base address

    @trace #BRCM_SWARCH_BRPHY1GV2_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY1GV2_FUNCTBL
*/
BRPHY1GV2_T1CORE_RDBType * const BRPHY1GV2_T1CORE_REGS = (BRPHY1GV2_T1CORE_RDBType *const)BRPHY1GV2_T1CORE_BASE;

/**
    @brief BRPHY1G CORE MISC block base address

    @trace #BRCM_SWARCH_BRPHY1GV2_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY1GV2_FUNCTBL
*/
BRPHY1GV2_CORE_MISC_RDBType * const BRPHY1GV2_CORE_MISC_REGS = (BRPHY1GV2_CORE_MISC_RDBType *const)BRPHY1GV2_CORE_MISC_BASE;

/**
    @brief BRPHY1G PHYCONTROL block base address

    @trace #BRCM_SWARCH_BRPHY1GV2_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY1GV2_FUNCTBL
*/
BRPHY1GV2_PHYCONTROL_RDBType * const BRPHY1GV2_PHYCONTROL_REGS = (BRPHY1GV2_PHYCONTROL_RDBType *const)BRPHY1GV2_PHYCONTROL_BASE;

/**
    @code{.unparsed}
    if aPhyIdx is invalid return BCM_ERR_INVAL_PARAMS
    if aMode is ETHXCVR_MODE_ACTIVE
        Disable low power mode (PMA_PMD_IEEE_CONTROL_REG1)
        if autonegotiation is enabled
            Advertize 1000Base-T1 and 100Base-T1 (AUTONEG_IEEE_BASET1_AN_ADVERTISEMENT_REG1)
            Set selector field (AUTONEG_IEEE_BASET1_AN_ADVERTISEMENT_REG0)
            Enable and restart autoneg (AUTONEG_IEEE_AN_CONTROL)
        if autonegotiation is disabled
            Reset advertizement (AUTONEG_IEEE_BASET1_AN_ADVERTISEMENT_REG1)
            Set forced master/slave and speed (PMA_PMD_IEEE_BASET1_PMA_PMD_CONTROL)
            Disable and restart autoneg (AUTONEG_IEEE_AN_CONTROL)
    if aMode is ETHXCVR_MODE_DOWN
        Enable low power mode (PMA_PMD_IEEE_CONTROL_REG1)
    if aMode is ETHXCVR_MODE_ISOLATE
        return BCM_ERR_NOSUPPORT
    if retVal is BCM_ERR_OK
        cache aMode
    return retVal
    @endcode

    @trace #BRCM_SWARCH_BRPHY1GV2_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY1GV2_FUNCTBL
*/
int32_t BRPHY1GV2_SetMode(uint8_t aPhyIdx,
                          ETHXCVR_CntxtType *const aPhyCntxt,
                          const ETHXCVR_PortConfigType *const aConfig,
                          ETHXCVR_ModeType aMode)
{
    int32_t retVal = BCM_ERR_OK;
    uint16_t regVal;

    if (BRPHY1GV2_AUTONEGIEEE_MAX_HW_ID <= aPhyIdx) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        if (ETHXCVR_MODE_ACTIVE == aMode) {
            /* Disable low power mode */
            BRPHY1GV2_CORE_MISC_REGS->m010 &= ~BRPHY1GV2_CORE_MISC_SHD18_010_SUPER_ISOLATE_MASK;

            if (ETHXCVR_BOOLEAN_TRUE == aConfig->autoNeg) {

                /* adv 1000T1 and 100T1 */
                BRPHY1GV2_AUTONEG_IEEE_REGS->baset1_an_advertisement_reg1 =
                    (BRPHY1GV2_AUTONEGIEEE_B1AAR1_ADVERISE_100BASE_T1_MASK |
                     BRPHY1GV2_AUTONEGIEEE_B1AAR1_ADVERISE_1000BASE_T1_MASK |
                     BRPHY1GV2_AUTONEGIEEE_B1AAR1_MASTER_SLAVE_MASK);

                /* push changes to REG1 (per std) */
                BRPHY1GV2_AUTONEG_IEEE_REGS->baset1_an_advertisement_reg0 =
                    (BRPHY1GV2_AUTONEGIEEE_ADVREG0_SELECTOR_VAL &
                     BRPHY1GV2_AUTONEGIEEE_B1AAR0_SELECTOR_FIELD_MASK);

                /* enable autoneg & restart */
                BRPHY1GV2_AUTONEG_IEEE_REGS->autoneg_baset1_an_control =
                    (BRPHY1GV2_AUTONEGIEEE_AB1AC_AUTONEG_ENABLE_MASK |
                     BRPHY1GV2_AUTONEGIEEE_AB1AC_RESTART_AUTO_NEGOTIATION_MASK);
            } else {
                BRPHY1GV2_AUTONEG_IEEE_REGS->baset1_an_advertisement_reg1 = 0U;

                regVal = ((BRPHY1GV2_PMAPMDIEEE_B1PPC_BASET1_PMA_PMD_CONTROL_BIT_15_MASK) |
                        (aConfig->phy.masterMode * BRPHY1GV2_PMAPMDIEEE_B1PPC_MASTER_SLAVE_MASK));
                if (aConfig->speed == ETHXCVR_SPEED_1000MBPS) {
                    regVal |= ((BRPHY1GV2_PMAPMD_BASET1_CTRL_T1_BASE_SEL_1000 << BRPHY1GV2_PMAPMDIEEE_B1PPC_T1_BASE_SEL_SHIFT)
                               & BRPHY1GV2_PMAPMDIEEE_B1PPC_T1_BASE_SEL_MASK);
                }

                BRPHY1GV2_PMAPMD_IEEE_REGS->baset1_pma_pmd_control = regVal;

                /* disable autoneg: restart autoneg is still required to restart link_sync statemachine */
                BRPHY1GV2_AUTONEG_IEEE_REGS->autoneg_baset1_an_control = BRPHY1GV2_AUTONEGIEEE_AB1AC_RESTART_AUTO_NEGOTIATION_MASK;
            }
        } else if (ETHXCVR_MODE_DOWN == aMode) {
            BRPHY1GV2_CORE_MISC_REGS->m010 |= BRPHY1GV2_CORE_MISC_SHD18_010_SUPER_ISOLATE_MASK;
        } else if (ETHXCVR_MODE_ISOLATE == aMode) {
            return BCM_ERR_NOSUPPORT;
        } else {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
    }

    /* Cache the mode */
    if (BCM_ERR_OK == retVal) {
        BRPHY1GV2_RWData.mode = aMode;
    }

    return retVal;
}

/**
    @code{.unparsed}
    if aPhyIdx is invalid return BCM_ERR_INVAL_PARAMS
        set *aLinkState to ETHXCVR_LINKSTATE_DOWN
        if autonegotiation is enabled
            Read status register twice (AUTONEG_IEEE_BASET1_AN_STATUS)
            if link_status field is set
                set *aLinkState to ETHXCVR_LINKSTATE_ACTIVE
        if autonegotiation is disabled
            Read status register twice (PMA_PMD_IEEE_STATUS_REG1)
            if link_status field is set
                set *aLinkState to ETHXCVR_LINKSTATE_ACTIVE
    return BCM_ERR_OK
    @endcode

    @trace #BRCM_SWARCH_BRPHY1GV2_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY1GV2_FUNCTBL
*/
int32_t BRPHY1GV2_GetLinkState(uint8_t aPhyIdx,
                               ETHXCVR_CntxtType *const aPhyCntxt,
                               const ETHXCVR_PortConfigType *const aConfig,
                               ETHXCVR_LinkStateType *const aLinkState)
{
    uint16_t reg;
    int32_t  retVal = BCM_ERR_OK;

    if (BRPHY1GV2_AUTONEGIEEE_MAX_HW_ID <= aPhyIdx) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        *aLinkState = ETHXCVR_LINKSTATE_DOWN;
        if (ETHXCVR_BOOLEAN_TRUE == aConfig->autoNeg) {
            reg = BRPHY1GV2_AUTONEG_IEEE_REGS->autoneg_baset1_an_status;
            reg = BRPHY1GV2_AUTONEG_IEEE_REGS->autoneg_baset1_an_status;

            if ((reg & BRPHY1GV2_AUTONEGIEEE_AB1AS_LINK_STATUS_MASK) ==
                       BRPHY1GV2_AUTONEGIEEE_AB1AS_LINK_STATUS_MASK) {
                *aLinkState = ETHXCVR_LINKSTATE_ACTIVE;
            }
        } else {
            reg = BRPHY1GV2_PMAPMD_IEEE_REGS->status_reg1;
            reg = BRPHY1GV2_PMAPMD_IEEE_REGS->status_reg1;

            if ((reg & BRPHY1GV2_PMAPMDIEEE_STATUS_REG1_RECEIVE_LINK_STATUS_MASK) ==
                       BRPHY1GV2_PMAPMDIEEE_STATUS_REG1_RECEIVE_LINK_STATUS_MASK) {
                *aLinkState = ETHXCVR_LINKSTATE_ACTIVE;
            }
        }
    }
    return retVal;
}

/**
    @code{.unparsed}
    return BCM_ERR_NOSUPPORT
    @endcode

    @trace #BRCM_SWARCH_BRPHY1GV2_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY1GV2_FUNCTBL
*/
int32_t BRPHY1GV2_Reset(uint8_t aPhyIdx,
                        ETHXCVR_CntxtType *const aPhyCntxt,
                        const ETHXCVR_PortConfigType *const aConfig)
{
    return BCM_ERR_NOSUPPORT;
}

/**
    @code{.unparsed}
    if aPhyIdx is invalid return BCM_ERR_INVAL_PARAMS
    set *aMode to cached mode
    return BCM_ERR_OK
    @endcode

    @trace #BRCM_SWARCH_BRPHY1GV2_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY1GV2_FUNCTBL
*/
int32_t BRPHY1GV2_GetMode(uint8_t aPhyIdx,
                          ETHXCVR_CntxtType *const aPhyCntxt,
                          const ETHXCVR_PortConfigType *const aConfig,
                          ETHXCVR_ModeType *const aMode)
{
    int32_t retVal = BCM_ERR_OK;

    if (BRPHY1GV2_AUTONEGIEEE_MAX_HW_ID <= aPhyIdx) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        *aMode = BRPHY1GV2_RWData.mode;
    }

    return retVal;
}

/**
    @code{.unparsed}
    if aPhyIdx is invalid return BCM_ERR_INVAL_PARAMS
    if autoneg is enabled return BCM_ERR_NOSUPPORT
    if master
        set master_slave (PMA_PMD_IEEE_BASET1_PMA_PMD_CONTROL)
    else
        clear master_slave (PMA_PMD_IEEE_BASET1_PMA_PMD_CONTROL)
    return BCM_ERR_OK
    @endcode

    @trace #BRCM_SWARCH_BRPHY1GV2_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY1GV2_FUNCTBL
*/
int32_t BRPHY1GV2_SetMasterMode(uint8_t aPhyIdx,
                                ETHXCVR_CntxtType *const aPhyCntxt,
                                const ETHXCVR_PortConfigType *const aConfig,
                                ETHXCVR_BooleanType aMasterMode)
{
    int32_t retVal = BCM_ERR_OK;

    if (BRPHY1GV2_PMAPMDIEEE_MAX_HW_ID <= aPhyIdx) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (ETHXCVR_BOOLEAN_TRUE == aConfig->autoNeg) {
        retVal = BCM_ERR_NOSUPPORT;
    } else {
        if (ETHXCVR_BOOLEAN_TRUE == aMasterMode) {
            BRPHY1GV2_PMAPMD_IEEE_REGS->baset1_pma_pmd_control |=
                (aMasterMode * BRPHY1GV2_PMAPMDIEEE_B1PPC_MASTER_SLAVE_MASK);
        } else {
            BRPHY1GV2_PMAPMD_IEEE_REGS->baset1_pma_pmd_control &= ~BRPHY1GV2_PMAPMDIEEE_B1PPC_MASTER_SLAVE_MASK;
        }
    }

    return retVal;
}

/**
    @code{.unparsed}
    if aPhyIdx is invalid return BCM_ERR_INVAL_PARAMS
    if autoneg is enabled
        if master_slave is set (AUTONEG_IEEE_TEST_REG2)
            set *aMasterMode to ETHXCVR_BOOLEAN_TRUE
        else
            set *aMasterMode to ETHXCVR_BOOLEAN_FALSE
    if autoneg is disabled
        if master_slave is set (PMA_PMD_IEEE_BASET1_PMA_PMD_CONTROL)
            set *aMasterMode to ETHXCVR_BOOLEAN_TRUE
        else
            set *aMasterMode to ETHXCVR_BOOLEAN_FALSE
    return BCM_ERR_OK
    @endcode

    @trace #BRCM_SWARCH_BRPHY1GV2_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY1GV2_FUNCTBL
*/
int32_t BRPHY1GV2_GetMasterMode(uint8_t aPhyIdx,
                                ETHXCVR_CntxtType *const aPhyCntxt,
                                const ETHXCVR_PortConfigType *const aConfig,
                                ETHXCVR_BooleanType *const aMasterMode)
{
    int32_t retVal = BCM_ERR_OK;

    if (BRPHY1GV2_PMAPMDIEEE_MAX_HW_ID<= aPhyIdx) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        if (ETHXCVR_BOOLEAN_TRUE == aConfig->autoNeg) {
            if (BRPHY1GV2_AUTONEGIEEE_ATR2_MASTER_SLAVE_MASK ==
                (BRPHY1GV2_AUTONEG_IEEE_REGS->autoneg_test_reg2 & BRPHY1GV2_AUTONEGIEEE_ATR2_MASTER_SLAVE_MASK)) {
                *aMasterMode = ETHXCVR_BOOLEAN_TRUE;
            } else {
                *aMasterMode = ETHXCVR_BOOLEAN_FALSE;
            }
        } else {
            if (BRPHY1GV2_PMAPMDIEEE_B1PPC_MASTER_SLAVE_MASK ==
                    (BRPHY1GV2_PMAPMD_IEEE_REGS->baset1_pma_pmd_control & BRPHY1GV2_PMAPMDIEEE_B1PPC_MASTER_SLAVE_MASK)) {
                *aMasterMode = ETHXCVR_BOOLEAN_TRUE;
            } else {
                *aMasterMode = ETHXCVR_BOOLEAN_FALSE;
            }
        }
    }

    return retVal;
}

/**
    @code{.unparsed}
    return BCM_ERR_NOSUPPORT
    @endcode

    @trace #BRCM_SWARCH_BRPHY1GV2_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY1GV2_FUNCTBL
*/
int32_t BRPHY1GV2_SetSpeed(uint8_t aPhyIdx,
                           ETHXCVR_CntxtType *const aPhyCntxt,
                           const ETHXCVR_PortConfigType *const aConfig,
                           ETHXCVR_SpeedType aSpeed)
{
    return BCM_ERR_OK;
}

/**
    @code{.unparsed}
    if aPhyIdx is invalid return BCM_ERR_INVAL_PARAMS
    if autoneg is enabled
        if highest_common_denominator field (AUTONEG_IEEE_TEST_REG2) is 100T1 or 100T1-legacy
            set *aSpeed to ETHXCVR_SPEED_100MBPS
        else
            set *aSpeed to ETHXCVR_SPEED_1000MBPS
    if autoneg is disabled
        if speed_sel_1 is set (PMA_PMD_IEEE_CONTROL_REG1)
            set *aSpeed to ETHXCVR_SPEED_1000MBPS
        else if speed_sel_1 is set (PMA_PMD_IEEE_CONTROL_REG1)
            set *aSpeed to ETHXCVR_SPEED_100MBPS
        else return BCM_ERR_UNKNOWN
    return BCM_ERR_OK
    @endcode

    @trace #BRCM_SWARCH_BRPHY1GV2_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY1GV2_FUNCTBL
*/
int32_t BRPHY1GV2_GetSpeed(uint8_t aPhyIdx,
                           ETHXCVR_CntxtType *const aPhyCntxt,
                           const ETHXCVR_PortConfigType *const aConfig,
                           ETHXCVR_SpeedType *const aSpeed)
{
    int32_t retVal = BCM_ERR_OK;

    if (BRPHY1GV2_AUTONEGIEEE_MAX_HW_ID <= aPhyIdx) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        if (ETHXCVR_BOOLEAN_TRUE == aConfig->autoNeg) {
            switch (BRPHY1GV2_AUTONEG_IEEE_REGS->autoneg_test_reg2 &
                    BRPHY1GV2_AUTONEGIEEE_ATR2_HIGHEST_COMMON_DENOMINATOR_MASK) {
                case BRPHY1GV2_AUTONEGIEEE_TESTREG2_HCD_LEGACY_100BASET1:
                case BRPHY1GV2_AUTONEGIEEE_TESTREG2_HCD_100BASET1:
                    /* Fall through intentional */
                    *aSpeed = ETHXCVR_SPEED_100MBPS;
                    break;
                default:
                    *aSpeed = ETHXCVR_SPEED_1000MBPS;
                    break;
            }
        } else {
            uint16_t regVal = BRPHY1GV2_PMAPMD_IEEE_REGS->control_reg1;
            if (BRPHY1GV2_PMAPMDIEEE_CONTROL_REG1_SPEED_SEL_1_MASK ==
                (BRPHY1GV2_PMAPMDIEEE_CONTROL_REG1_SPEED_SEL_1_MASK & regVal)) {
                *aSpeed = ETHXCVR_SPEED_1000MBPS;
            } else if (BRPHY1GV2_PMAPMDIEEE_CONTROL_REG1_SPEED_SEL_0_MASK ==
                      (BRPHY1GV2_PMAPMDIEEE_CONTROL_REG1_SPEED_SEL_0_MASK & regVal)) {
                *aSpeed = ETHXCVR_SPEED_100MBPS;
            } else {
                retVal = BCM_ERR_UNKNOWN;
            }
        }
    }

    return retVal;
}

/**
    @code{.unparsed}
    if aPhyIdx is invalid return BCM_ERR_INVAL_PARAMS
    set *aDuplexMode to duplex mode in configuration
    return BCM_ERR_OK
    @endcode

    @trace #BRCM_SWARCH_BRPHY1GV2_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY1GV2_FUNCTBL
*/
int32_t BRPHY1GV2_GetDuplexMode(uint8_t aPhyIdx,
                                ETHXCVR_CntxtType *const aPhyCntxt,
                                const ETHXCVR_PortConfigType *const aConfig,
                                ETHXCVR_DuplexModeType *const aDuplexMode)
{
    int32_t retVal = BCM_ERR_OK;

    if (BRPHY1GV2_AUTONEGIEEE_MAX_HW_ID <= aPhyIdx) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        *aDuplexMode = aConfig->duplex;
    }

    return retVal;
}

/**
    @code{.unparsed}
    if aPhyIdx is invalid return BCM_ERR_INVAL_PARAMS
    if aDuplexMode is not ETHXCVR_DUPLEXMODE_FULL return BCM_ERR_NOSUPPORT
    return BCM_ERR_OK
    @endcode

    @trace #BRCM_SWARCH_BRPHY1GV2_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY1GV2_FUNCTBL
*/
int32_t BRPHY1GV2_SetDuplexMode(uint8_t aPhyIdx,
                                ETHXCVR_CntxtType *const aPhyCntxt,
                                const ETHXCVR_PortConfigType *const aConfig,
                                ETHXCVR_DuplexModeType aDuplexMode)
{
    int32_t retVal = BCM_ERR_OK;

    if (BRPHY1GV2_AUTONEGIEEE_MAX_HW_ID <= aPhyIdx) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        if (aDuplexMode != ETHXCVR_DUPLEXMODE_FULL) {
            retVal = BCM_ERR_NOSUPPORT;
        }
    }

    return retVal;
}

/**
    @code{.unparsed}
    if aPhyIdx is invalid return BCM_ERR_INVAL_PARAMS
    set *aFlowControl to flow control mode in configuration
    return BCM_ERR_OK
    @endcode

    @trace #BRCM_SWARCH_BRPHY1GV2_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY1GV2_FUNCTBL
*/
int32_t BRPHY1GV2_GetFlowControl(uint8_t aPhyIdx,
                                 ETHXCVR_CntxtType *const aPhyCntxt,
                                 const ETHXCVR_PortConfigType *const aConfig,
                                 ETHXCVR_FlowControlType *const aFlowControl)
{
    int32_t retVal = BCM_ERR_OK;

    if (BRPHY1GV2_AUTONEGIEEE_MAX_HW_ID <= aPhyIdx) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        *aFlowControl = aConfig->flowControl;
    }

    return retVal;
}

/**
    @code{.unparsed}
    if aPhyIdx is invalid return BCM_ERR_INVAL_PARAMS
    if aFlowControl is not ETHXCVR_FLOWCONTROL_NONE return BCM_ERR_NOSUPPORT
    return BCM_ERR_OK
    @endcode

    @trace #BRCM_SWARCH_BRPHY1GV2_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY1GV2_FUNCTBL
*/
int32_t BRPHY1GV2_SetFlowControl(uint8_t aPhyIdx,
                                 ETHXCVR_CntxtType *const aPhyCntxt,
                                 const ETHXCVR_PortConfigType *const aConfig,
                                 ETHXCVR_FlowControlType aFlowControl)
{
    int32_t retVal = BCM_ERR_OK;

    if (BRPHY1GV2_AUTONEGIEEE_MAX_HW_ID <= aPhyIdx) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        if (aFlowControl != ETHXCVR_FLOWCONTROL_NONE) {
            retVal = BCM_ERR_NOSUPPORT;
        }
    }

    return retVal;
}

/**
    @code{.unparsed}
    if aPhyIdx is invalid return BCM_ERR_INVAL_PARAMS
        Disable DSP RDB clock (T1_CORE_TX_CLOCK_OVERRIDE_VALUE)
        set *aSQIValue to sqi field (PHYCONTROL_TC1_DCQ_SQI)
        Enable DSP RDB clock (T1_CORE_TX_CLOCK_OVERRIDE_VALUE)
    return BCM_ERR_OK
    @endcode

    @trace #BRCM_SWARCH_BRPHY1GV2_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY1GV2_FUNCTBL
*/
int32_t BRPHY1GV2_GetSQIValue(uint8_t aPhyIdx,
                              ETHXCVR_CntxtType *const aPhyCntxt,
                              const ETHXCVR_PortConfigType *const aConfig,
                              uint32_t *const aSQIValue)
{
    int32_t retVal = BCM_ERR_OK;

    if (BRPHY1GV2_AUTONEGIEEE_MAX_HW_ID <= aPhyIdx) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        BRPHY1GV2_T1CORE_REGS->tx_clock_override_value &= ~BRPHY1GV2_T1CORE_TCOV_DISABLE_DSP_RDB_CLOCK_MASK;
        *aSQIValue = (BRPHY1GV2_PHYCONTROL_REGS->sqi & BRPHY1GV2_PHYCONTROL_TC1_DCQ_SQI_SQI_MASK) >>
            BRPHY1GV2_PHYCONTROL_TC1_DCQ_SQI_SQI_SHIFT;
    }

    return retVal;
}

/**
    @code{.unparsed}
    return BCM_ERR_OK
    @endcode

    @trace #BRCM_SWARCH_BRPHY1GV2_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY1GV2_FUNCTBL
*/
int32_t BRPHY1GV2_Init(uint8_t aPhyIdx,
                       ETHXCVR_CntxtType *const aPhyCntxt,
                       const ETHXCVR_PortConfigType *const aConfig)
{
    return BCM_ERR_OK;
}

/**
    @code{.unparsed}
    return BCM_ERR_OK
    @endcode

    @trace #BRCM_SWARCH_BRPHY1GV2_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY1GV2_FUNCTBL
*/
int32_t BRPHY1GV2_DeInit(uint8_t aPhyIdx,
                         ETHXCVR_CntxtType *const aPhyCntxt,
                         const ETHXCVR_PortConfigType *const aConfig)
{
    return BCM_ERR_OK;
}

/**
    @code{.unparsed}
    if aPhyIdx is invalid return BCM_ERR_INVAL_PARAMS
    if aMode is ETHXCVR_BOOLEAN_TRUE return BCM_ERR_NOSUPPORT
    return BCM_ERR_OK
    @endcode

    @trace #BRCM_SWARCH_BRPHY1GV2_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY1GV2_FUNCTBL
*/
int32_t BRPHY1GV2_SetJumboMode(uint8_t aPhyIdx,
                               ETHXCVR_CntxtType *const aPhyCntxt,
                               const ETHXCVR_PortConfigType *const aConfig,
                               ETHXCVR_BooleanType aMode)
{
    int32_t retVal = BCM_ERR_OK;

    if (BRPHY1GV2_AUTONEGIEEE_MAX_HW_ID <= aPhyIdx) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        if (ETHXCVR_BOOLEAN_TRUE == aMode) {
            retVal = BCM_ERR_NOSUPPORT;
        }
    }

    return retVal;
}

/**
    @code{.unparsed}
    if aPhyIdx is invalid return BCM_ERR_INVAL_PARAMS
    if aMode is ETHXCVR_BOOLEAN_TRUE
        set local_loopback (PMA_PMD_IEEE_CONTROL_REG1)
        set freeze_force_assert (EC_CONTROL_0) - refer HWORION-331
    else
        clear local_loopback (PMA_PMD_IEEE_CONTROL_REG1)
        clear freeze_force_assert (EC_CONTROL_0)
    return BCM_ERR_OK
    @endcode

    @trace #BRCM_SWARCH_BRPHY1GV2_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY1GV2_FUNCTBL
*/
int32_t BRPHY1GV2_SetLoopbackMode(uint8_t aPhyIdx,
                                  ETHXCVR_CntxtType *const aPhyCntxt,
                                  const ETHXCVR_PortConfigType *const aConfig,
                                  ETHXCVR_BooleanType aMode)
{
    int32_t retVal = BCM_ERR_OK;

    if (BRPHY1GV2_PMAPMDIEEE_MAX_HW_ID <= aPhyIdx) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        if (ETHXCVR_BOOLEAN_TRUE == aMode) {
            if(aConfig->speed == ETHXCVR_SPEED_1000MBPS) {
                BRPHY1GV2_T1CORE_REGS->testability_reg_c |= BRPHY1GV2_T1CORE_TRC_INTERNAL_LOOPBACK_MASK;
            } else {
                BRPHY1GV2_PCS_IEEE_REGS->reg1 |= (BRPHY1GV2_PCS_IEEE_PCS_CONTROL_REG1_LOOPBACK_MASK);
            }
        } else {
            if(aConfig->speed == ETHXCVR_SPEED_1000MBPS) {
               BRPHY1GV2_T1CORE_REGS->testability_reg_c &= ~(BRPHY1GV2_T1CORE_TRC_INTERNAL_LOOPBACK_MASK);
            } else {
                BRPHY1GV2_PCS_IEEE_REGS->reg1 &= ~(BRPHY1GV2_PCS_IEEE_PCS_CONTROL_REG1_LOOPBACK_MASK);
            }
        }
    }

    return retVal;
}

/**
    @code{.unparsed}
    if aPhyIdx is invalid return BCM_ERR_INVAL_PARAMS
    if local_loopback is set (PMA_PMD_IEEE_CONTROL_REG1)
        set *aMode to ETHXCVR_BOOLEAN_TRUE
    else
        set *aMode to ETHXCVR_BOOLEAN_FALSE
    return BCM_ERR_OK
    @endcode

    @trace #BRCM_SWARCH_BRPHY1GV2_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY1GV2_FUNCTBL
*/
int32_t BRPHY1GV2_GetLoopbackMode(uint8_t aPhyIdx,
                                  ETHXCVR_CntxtType *const aPhyCntxt,
                                  const ETHXCVR_PortConfigType *const aConfig,
                                  ETHXCVR_BooleanType *const aMode)
{
    int32_t retVal = BCM_ERR_OK;

    if (BRPHY1GV2_AUTONEGIEEE_MAX_HW_ID <= aPhyIdx) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        if(aConfig->speed == ETHXCVR_SPEED_1000MBPS) {
            if (0U != (BRPHY1GV2_T1CORE_REGS->testability_reg_c &
                       BRPHY1GV2_T1CORE_TRC_INTERNAL_LOOPBACK_MASK)) {
                *aMode = ETHXCVR_BOOLEAN_TRUE;
            } else {
                *aMode = ETHXCVR_BOOLEAN_FALSE;
            }
        } else {
            if (0U != (BRPHY1GV2_PCS_IEEE_REGS->reg1 &
                       BRPHY1GV2_PCS_IEEE_PCS_CONTROL_REG1_LOOPBACK_MASK)) {
                *aMode = ETHXCVR_BOOLEAN_TRUE;
            } else {
                *aMode = ETHXCVR_BOOLEAN_FALSE;
            }
        }
    }

    return retVal;
}

/**
    @code{.unparsed}
    if aPhyIdx is invalid return BCM_ERR_INVAL_PARAMS
    set *aMode to ETHXCVR_BOOLEAN_FALSE
    return BCM_ERR_OK
    @endcode

    @trace #BRCM_SWARCH_BRPHY1GV2_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY1GV2_FUNCTBL
*/
int32_t BRPHY1GV2_GetJumboMode(uint8_t aPhyIdx,
                               ETHXCVR_CntxtType *const aPhyCntxt,
                               const ETHXCVR_PortConfigType *const aConfig,
                               ETHXCVR_BooleanType *const aMode)
{
    int32_t retVal = BCM_ERR_OK;

    if (BRPHY1GV2_AUTONEGIEEE_MAX_HW_ID <= aPhyIdx) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        *aMode = ETHXCVR_BOOLEAN_FALSE;
    }

    return retVal;
}

/**
    @code{.unparsed}
    return BCM_ERR_NOSUPPORT
    @endcode

    @trace #BRCM_SWARCH_BRPHY1GV2_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY1GV2_FUNCTBL
*/
int32_t BRPHY1GV2_SetWakeUpMode(uint8_t aPhyIdx,
                                ETHXCVR_CntxtType *const aCntxt,
                                const ETHXCVR_PortConfigType *const aConfig,
                                ETHXCVR_BooleanType aMode)
{
    return BCM_ERR_NOSUPPORT;
}

/**
    @code{.unparsed}
    return BCM_ERR_NOSUPPORT
    @endcode

    @trace #BRCM_SWARCH_BRPHY1GV2_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY1GV2_FUNCTBL
*/
int32_t BRPHY1GV2_GetWakeUpMode(uint8_t aPhyIdx,
                                ETHXCVR_CntxtType *const aCntxt,
                                const ETHXCVR_PortConfigType *const aConfig,
                                ETHXCVR_BooleanType *const aMode)
{
    return BCM_ERR_NOSUPPORT;
}

/**
    @code{.unparsed}
    return BCM_ERR_NOSUPPORT
    @endcode

    @trace #BRCM_SWARCH_BRPHY1GV2_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY1GV2_FUNCTBL
*/
int32_t BRPHY1GV2_GetWakeUpReason(uint8_t aPhyIdx,
                                  ETHXCVR_CntxtType *const aCntxt,
                                  const ETHXCVR_PortConfigType *const aConfig,
                                  ETHXCVR_WakeupReasonType *const aReason)
{
    return BCM_ERR_NOSUPPORT;
}

/**
    @code{.unparsed}
    return BCM_ERR_NOSUPPORT
    @endcode

    @trace #BRCM_SWARCH_BRPHY1GV2_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY1GV2_FUNCTBL
*/
int32_t BRPHY1GV2_SetAutoNegMode(uint8_t aPhyIdx,
                                 ETHXCVR_CntxtType *const aPhyCntxt,
                                 const ETHXCVR_PortConfigType *const aConfig,
                                 ETHXCVR_BooleanType aAutonegMode)
{
    return BCM_ERR_NOSUPPORT;
}

/**
    @code{.unparsed}
    if aPhyIdx is invalid return BCM_ERR_INVAL_PARAMS
    if autoneg is disabled return BCM_ERR_INVAL_STATE
    set restart_auto_negotiation (AUTONEG_IEEE_AN_CONTROL)
    return BCM_ERR_OK
    @endcode

    @trace #BRCM_SWARCH_BRPHY1GV2_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY1GV2_FUNCTBL
*/
int32_t BRPHY1GV2_RestartAutoNeg(uint8_t aPhyIdx,
                               ETHXCVR_CntxtType *const aPhyCntxt,
                               const ETHXCVR_PortConfigType *const aConfig)
{
    int32_t retVal = BCM_ERR_OK;

    if (BRPHY1GV2_AUTONEGIEEE_MAX_HW_ID <= aPhyIdx) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (ETHXCVR_BOOLEAN_FALSE == aConfig->autoNeg) {
        retVal = BCM_ERR_INVAL_STATE;
    } else {
        BRPHY1GV2_AUTONEG_IEEE_REGS->autoneg_baset1_an_control |=
            BRPHY1GV2_AUTONEGIEEE_AB1AC_RESTART_AUTO_NEGOTIATION_MASK;
    }

    return retVal;
}

/**
    @code{.unparsed}
    if aPhyIdx is invalid return BCM_ERR_INVAL_PARAMS
    read status register twice (AUTONEG_IEEE_BASET1_AN_STATUS)
    if autoneg_ability is not set
        set *aStatus to ETHXCVR_AUTONEGSTATUS_NO_ABILITY
    else if autoneg_complete is not set
        set *aStatus to ETHXCVR_AUTONEGSTATUS_INCOMPLETE
    else
        set *aStatus to ETHXCVR_AUTONEGSTATUS_COMPLETE

    set restart_auto_negotiation (AUTONEG_IEEE_AN_CONTROL)
    return BCM_ERR_OK
    @endcode

    @trace #BRCM_SWARCH_BRPHY1GV2_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY1GV2_FUNCTBL
*/
int32_t BRPHY1GV2_GetAutoNegStatus(uint8_t aPhyIdx,
                                   ETHXCVR_CntxtType *const aPhyCntxt,
                                   const ETHXCVR_PortConfigType *const aConfig,
                                   ETHXCVR_AutoNegStatusType *const aStatus)
{
    int32_t retVal = BCM_ERR_OK;
    uint16_t reg;

    if (BRPHY1GV2_AUTONEGIEEE_MAX_HW_ID <= aPhyIdx) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        reg = BRPHY1GV2_AUTONEG_IEEE_REGS->autoneg_baset1_an_status;
        reg = BRPHY1GV2_AUTONEG_IEEE_REGS->autoneg_baset1_an_status;
        if (0U == (reg & BRPHY1GV2_AUTONEGIEEE_AB1AS_AUTONEG_ABILITY_MASK)) {
            *aStatus = ETHXCVR_AUTONEGSTATUS_NO_ABILITY;
        } else if (0U == (reg & BRPHY1GV2_AUTONEGIEEE_AB1AS_AUTONEG_COMPLETE_MASK)) {
            *aStatus = ETHXCVR_AUTONEGSTATUS_INCOMPLETE;
        } else {
            *aStatus = ETHXCVR_AUTONEGSTATUS_COMPLETE;
        }
    }

    return retVal;
}

/**
    @code{.unparsed}
    if aPhyIdx is invalid return BCM_ERR_INVAL_PARAMS
    clear aStats
    return BCM_ERR_OK
    @endcode

    @trace #BRCM_SWARCH_BRPHY1GV2_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY1GV2_FUNCTBL
*/
int32_t BRPHY1GV2_GetStats(uint8_t aPhyIdx,
                           ETHXCVR_CntxtType *const aPhyCntxt,
                           const ETHXCVR_PortConfigType *const aConfig,
                           ETHXCVR_StatsType *const aStats)
{
    int32_t retVal = BCM_ERR_OK;

    if (BRPHY1GV2_AUTONEGIEEE_MAX_HW_ID <= aPhyIdx) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        BCM_MemSet(aStats, 0U, sizeof(ETHXCVR_StatsType));
    }

    return retVal;
}

/**
    @code{.unparsed}
    return BCM_ERR_NOSUPPORT
    @endcode

    @trace #BRCM_SWARCH_BRPHY1GV2_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY1GV2_FUNCTBL
*/
int32_t BRPHY1GV2_StateHandler(uint8_t aPhyIdx,
                               ETHXCVR_CntxtType *const aPhyCntxt,
                               const ETHXCVR_PortConfigType *const aConfig,
                               uint32_t *const aIsModeChanged,
                               ETHXCVR_ModeType *const aMode)
{
    return BCM_ERR_NOSUPPORT;
}

/**
    @code{.unparsed}
    return BCM_ERR_NOSUPPORT
    @endcode

    @trace #BRCM_SWARCH_BRPHY1GV2_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY1GV2_FUNCTBL
*/
int32_t BRPHY1GV2_UpdateHWStatus(uint8_t aPhyIdx,
                                 ETHXCVR_CntxtType *const aPhyCntxt,
                                 const ETHXCVR_PortConfigType *const aConfig)
{
    return BCM_ERR_NOSUPPORT;
}

/**
    @code{.unparsed}
    return BCM_ERR_NOSUPPORT
    @endcode

    @trace #BRCM_SWARCH_BRPHY1GV2_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY1GV2_FUNCTBL
*/
int32_t BRPHY1GV2_LinkIRQHandler(uint8_t aPhyIdx,
                                 ETHXCVR_CntxtType *const aPhyCntxt,
                                 const ETHXCVR_PortConfigType *const aConfig)
{
    return BCM_ERR_NOSUPPORT;
}

/**
    @code{.unparsed}
    return BCM_ERR_NOSUPPORT
    @endcode

    @trace #BRCM_SWARCH_BRPHY1GV2_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY1GV2_FUNCTBL
*/
int32_t BRPHY1GV2_LinkChangeIndHandler(uint8_t aPhyIdx,
                                       ETHXCVR_CntxtType *const aPhyCntxt,
                                       const ETHXCVR_PortConfigType *const aConfig,
                                       ETHXCVR_LinkStateType *const aLinkState,
                                       uint32_t *const aIsLinkStateChanged)
{
    return BCM_ERR_NOSUPPORT;
}

/**
    @trace #BRCM_SWARCH_BRPHY1GV2_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_BRPHY1GV2_FUNCTBL
*/
const ETHXCVR_FuncTblType BRPHY1GV2_FuncTbl = {
    .init = BRPHY1GV2_Init,
    .deinit = BRPHY1GV2_DeInit,
    .reset = BRPHY1GV2_Reset,
    .setMode = BRPHY1GV2_SetMode,
    .getMode = BRPHY1GV2_GetMode,
    .setMasterMode = BRPHY1GV2_SetMasterMode,
    .getMasterMode = BRPHY1GV2_GetMasterMode,
    .getSpeed = BRPHY1GV2_GetSpeed,
    .setSpeed = BRPHY1GV2_SetSpeed,
    .getDuplexMode = BRPHY1GV2_GetDuplexMode,
    .setDuplexMode = BRPHY1GV2_SetDuplexMode,
    .setFlowControl = BRPHY1GV2_SetFlowControl,
    .getFlowControl = BRPHY1GV2_GetFlowControl,
    .getLinkState = BRPHY1GV2_GetLinkState,
    .getSQIValue = BRPHY1GV2_GetSQIValue,
    .setLoopbackMode = BRPHY1GV2_SetLoopbackMode,
    .getLoopbackMode = BRPHY1GV2_GetLoopbackMode,
    .setJumboMode = BRPHY1GV2_SetJumboMode,
    .getJumboMode = BRPHY1GV2_GetJumboMode,
    .setWakeUpMode = BRPHY1GV2_SetWakeUpMode,
    .getWakeUpMode = BRPHY1GV2_GetWakeUpMode,
    .getWakeUpReason = BRPHY1GV2_GetWakeUpReason,
    .setAutoNegMode = BRPHY1GV2_SetAutoNegMode,
    .getAutoNegStatus = BRPHY1GV2_GetAutoNegStatus,
    .restartAutoNeg = BRPHY1GV2_RestartAutoNeg,
    .getStats = BRPHY1GV2_GetStats,
    .stateHandler = BRPHY1GV2_StateHandler,
    .updateHWStatus = BRPHY1GV2_UpdateHWStatus,
    .linkChangeIndHandler = BRPHY1GV2_LinkChangeIndHandler,
    .linkIRQHandler  = BRPHY1GV2_LinkIRQHandler,
};

/** @} */
