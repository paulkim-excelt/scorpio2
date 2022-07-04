/*****************************************************************************
 Copyright 2017-2021 Broadcom Limited.  All rights reserved.

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
    @addtogroup grp_ethswt_impl
    @{

    @file eth_switch.c

    @brief Ethernet switch

    @version 0.1 Initial version
*/

#include <bcm_utils.h>
#include <bcm_err.h>
#include <eth_switch_osil.h>
#include <eth_osil.h>
#include <eth_cntlr.h>
#include <switch_rdb.h>
#include "switch_drv.h"
#include "switch_cfg.h"
#include <ethswt_xcvr_osil.h>
#include "mcu_switch_ext.h"

/**
    @name Ethernet switch Design ID's
    @{
    @brief Ethernet switch Design ID's
*/
#define BRCM_SWDSGN_ETHSWT_PORT_LINK_STATUS_MACRO                (0xB501U)    /**< @brief #ETHSWT_PORT_LINK_STATUS_CHANGED_MASK */
#define BRCM_SWDSGN_ETHSWT_INTR_CLR_ALL_PORT_LINK_MACRO          (0xB502U)    /**< @brief #ETHSWT_INTR_CLR_ALL_PORT_LINK        */
#define BRCM_SWDSGN_ETHSWT_GET_XCVR_ID_PROC                      (0xB503U)    /**< @brief #ETHSWT_GetXcvrID                     */
#define BRCM_SWDSGN_ETHSWT_DRV_SET_PORT_JUMBO_MODE_PROC          (0xB504U)    /**< @brief #ETHSWT_DrvSetPortJumboMode           */
#define BRCM_SWDSGN_ETHSWT_DRV_GET_PORT_JUMBO_MODE_PROC          (0xB505U)    /**< @brief #ETHSWT_DrvGetPortJumboMode           */
#define BRCM_SWDSGN_ETHSWT_DRV_LINK_IRQ_HANDLER_PROC             (0xB506U)    /**< @brief #ETHSWT_DrvLinkIRQHandler             */
#define BRCM_SWDSGN_ETHSWT_DRV_LINK_STAT_CHG_IND_HANDLER_PROC    (0xB507U)    /**< @brief #ETHSWT_DrvLinkStatChgIndHandler      */
#define BRCM_SWDSGN_ETHSWT_DRV_GET_XCVR_STATS_PROC               (0xB508U)    /**< @brief #ETHSWT_DrvGetXcvrStats               */
#define BRCM_SWDSGN_ETHSWT_DRV_GET_PORT_LINK_STATE_PROC          (0xB509U)    /**< @brief #ETHSWT_DrvGetPortLinkState           */
#define BRCM_SWDSGN_ETHSWT_GET_PORT_MODE_PROC                    (0xB50AU)    /**< @brief #ETHSWT_GetPortMode                   */
#define BRCM_SWDSGN_ETHSWT_SET_PORT_MODE_PROC                    (0xB50BU)    /**< @brief #ETHSWT_SetPortMode                   */
#define BRCM_SWDSGN_ETHSWT_GET_PORT_MASTER_MODE_PROC             (0xB50CU)    /**< @brief #ETHSWT_GetPortMasterMode             */
#define BRCM_SWDSGN_ETHSWT_SET_PORT_MASTER_MODE_PROC             (0xB50DU)    /**< @brief #ETHSWT_SetPortMasterMode             */
#define BRCM_SWDSGN_ETHSWT_PORT_LOOP_BACK_MODE_PROC              (0xB50EU)    /**< @brief #ETHSWT_GetPortLoopbackMode           */
#define BRCM_SWDSGN_ETHSWT_SET_PORT_LOOP_BACK_MODE_PROC          (0xB50FU)    /**< @brief #ETHSWT_SetPortLoopbackMode           */
#define BRCM_SWDSGN_ETHSWT_GET_PORT_JUMBO_MODE_PROC              (0xB510U)    /**< @brief #ETHSWT_GetPortJumboMode              */
#define BRCM_SWDSGN_ETHSWT_SET_PORT_JUMBO_MODE_PROC              (0xB511U)    /**< @brief #ETHSWT_SetPortJumboMode              */
#define BRCM_SWDSGN_ETHSWT_GET_PORT_LINK_STATE_PROC              (0xB512U)    /**< @brief #ETHSWT_GetPortLinkState              */
#define BRCM_SWDSGN_ETHSWT_SET_PORT_SPEED_PROC                   (0xB513U)    /**< @brief #ETHSWT_SetPortSpeed                  */
#define BRCM_SWDSGN_ETHSWT_GET_PORT_SPEED_PROC                   (0xB514U)    /**< @brief #ETHSWT_GetPortSpeed                  */
#define BRCM_SWDSGN_ETHSWT_ENABLE_PORT_AUTO_NEG_PROC             (0xB515U)    /**< @brief #ETHSWT_EnablePortAutoNeg             */
#define BRCM_SWDSGN_ETHSWT_GET_PORT_AUTO_NEG_STATUS_PROC         (0xB516U)    /**< @brief #ETHSWT_GetPortAutoNegStatus          */
#define BRCM_SWDSGN_ETHSWT_GET_PORT_DUPLEX_MODE_PROC             (0xB517U)    /**< @brief #ETHSWT_GetPortDuplexMode             */
#define BRCM_SWDSGN_ETHSWT_GET_XCVR_STATS_PROC                   (0xB518U)    /**< @brief #ETHSWT_GetXcvrStats                  */
#define BRCM_SWDSGN_ETHSWT_GET_SQI_VALUE_PROC                    (0xB519U)    /**< @brief #ETHSWT_GetSQIValue                   */
#define BRCM_SWDSGN_ETHSWT_GET_PORT_TYPE                         (0xB51AU)    /**< @brief #ETHSWT_GetPortType                   */
#define BRCM_SWDSGN_ETHSWT_LINK_IRQ_HANDLER_PROC                 (0xB51BU)    /**< @brief #ETHSWT_LinkIRQHandler                */
#define BRCM_SWDSGN_ETHSWT_LINK_STAT_CHG_IND_HANDLER_PROC        (0xB51CU)    /**< @brief #ETHSWT_LinkStatChgIndHandler         */
#define BRCM_SWDSGN_ETHSWT_PORT_LINK_STATUS_MASK_MACRO           (0xB51DU)    /**< @brief #ETHSWT_PORT_LINK_STATUS_MASK         */
#define BRCM_SWDSGN_ETHSWT_XCVRSTATEHANDLER_PROC                 (0xB51EU)    /**< @brief #ETHSWT_XcvrStateHandler              */
#define BRCM_SWDSGN_ETHSWT_XCVR_CMD_HANDLER_PROC                 (0xB51FU)    /**< @brief #ETHSWT_XcvrCmdHandler                */
#define BRCM_SWDSGN_ETHSWT_DRV_SET_XCVR_ID_PROC                  (0xB520U)    /**< @brief #ETHSWT_DrvSetXcvrID                  */
#define BRCM_SWDSGN_ETHSWT_XCVR_PORT_MAP_TYPE                    (0xB521U)    /**< @brief #ETHSWT_XcvrPortMapType               */
#define BRCM_SWDSGN_ETHSWT_XCVR_PORT_MAP_GLOBAL                  (0xB522U)    /**< @brief #ETHSWT_XcvrPortMap                   */
#define BRCM_SWDSGN_ETHSWT_SET_PORTWAKEUPMODE_PROC               (0xB523U)    /**< @brief #ETHSWT_SetPortWakeUpMode             */
#define BRCM_SWDSGN_ETHSWT_GET_PORTWAKEUPMODE_PROC               (0xB524U)    /**< @brief #ETHSWT_GetPortWakeUpMode             */
#define BRCM_SWDSGN_ETHSWT_GET_PORTWAKEUPREASON_PROC             (0xB525U)    /**< @brief #ETHSWT_GetPortWakeUpReason           */
/** @} */

/**
    @brief Switch is port link status changed mask

    @{

    @trace #BRCM_SWARCH_ETHSWT_CMD_HANDLER_PROC
    @trace #BRCM_SWARCH_ETHSWT_LINK_IRQ_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_XCVR
*/
#define ETHSWT_PORT_LINK_STATUS_CHANGED_MASK    (0x0000FFFFUL)
#define ETHSWT_PORT_LINK_STATUS_CHANGED_SHIFT   (0UL)
#define ETHSWT_PORT_LINK_STATUS_MASK            (0xFFFF0000UL)
#define ETHSWT_PORT_LINK_STATUS_SHIFT           (16UL)
/** @} */

/**
    @brief Interrupt clear port link

    @trace #BRCM_SWARCH_ETHSWT_LINK_IRQ_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_XCVR
*/
#define ETHSWT_INTR_CLR_ALL_PORT_LINK       (0x40FFUL)

/**
    @trace #BRCM_SWARCH_ETHSWT_DRV_SET_XCVR_ID_PROC
    @trace #BRCM_SWREQ_ETHSWT_XCVR
*/
typedef struct sETHSWT_XcvrPortMapType {
    uint32_t        valid;
    uint32_t        portID;
    ETHXCVR_IDType  xcvrID;
} ETHSWT_XcvrPortMapType;

/**
    @trace #BRCM_SWARCH_ETHSWT_DRV_SET_XCVR_ID_PROC
    @trace #BRCM_SWREQ_ETHSWT_XCVR
*/
static ETHSWT_XcvrPortMapType ETHSWT_XcvrPortMap[ETHSWT_PORT_ID_MAX] COMP_SECTION(".bss.drivers");

/**
    @brief Switch Set tranciever ID

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aSwtID      Switch Index
    @param[in]      aPortID     Port ID
    @param[in]      aXcvrID     Tranceiver ID

    Return values are documented in reverse-chronological order
    @retval         #BCM_ERR_OK         On Success
    @retval         #BCM_ERR_NOMEM      if Portmap is full

    @post None

    @trace #BRCM_SWARCH_ETHSWT_DRV_SET_XCVR_ID_PROC
    @trace #BRCM_SWREQ_ETHSWT_XCVR

*/
int32_t ETHSWT_DrvSetXcvrID(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID, uint32_t aXcvrID)
{
    uint32_t i;
    int ret = BCM_ERR_OK;

    for (i = 0UL; i < ETHSWT_PORT_ID_MAX; i++) {
        if (0UL == ETHSWT_XcvrPortMap[i].valid) {
            ETHSWT_XcvrPortMap[i].valid = 1UL;
            ETHSWT_XcvrPortMap[i].xcvrID = (ETHXCVR_IDType)aXcvrID;
            ETHSWT_XcvrPortMap[i].portID = aPortID;
            break;
        }
    }
    if (i == ETHSWT_PORT_ID_MAX) {
        ret = BCM_ERR_NOMEM;
    }
    return ret;
}


/**
    @brief Switch Get tranciever ID

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aSwtID      Switch Index
    @param[in]      aPortID     Port ID
    @param[inout]   aXcvrID     Tranceiver ID

    Return values are documented in reverse-chronological order
    @retval         #BCM_ERR_OK         On Success
    @retval         #BCM_ERR_NOT_FOUND  If port ID is invalid

    @post None

    @trace #BRCM_SWARCH_ETHSWT_GET_PORT_MODE_PROC
    @trace #BRCM_SWARCH_ETHSWT_SET_PORT_MODE_PROC
    @trace #BRCM_SWARCH_ETHSWT_GET_PORT_MASTERMODE_PROC
    @trace #BRCM_SWARCH_ETHSWT_SET_PORT_MASTERMODE_PROC
    @trace #BRCM_SWARCH_ETHSWT_GET_PORT_LOOPBACKMODE_PROC
    @trace #BRCM_SWARCH_ETHSWT_SET_PORT_LOOPBACKMODE_PROC
    @trace #BRCM_SWARCH_ETHSWT_GET_PORT_JUMBOMODE_PROC
    @trace #BRCM_SWARCH_ETHSWT_SET_PORT_JUMBOMODE_PROC
    @trace #BRCM_SWARCH_ETHSWT_SET_PORT_SPEED_PROC
    @trace #BRCM_SWARCH_ETHSWT_GET_PORT_SPEED_PROC
    @trace #BRCM_SWARCH_ETHSWT_ENABLE_PORT_AUTONEG_PROC
    @trace #BRCM_SWARCH_ETHSWT_GET_XCVR_STATS_PROC
    @trace #BRCM_SWARCH_ETHSWT_GET_SQI_VAL_PROC
    @trace #BRCM_SWARCH_ETHSWT_GET_PORT_TYPE_PROC
    @trace #BRCM_SWREQ_ETHSWT_XCVR
*/
static int32_t ETHSWT_GetXcvrID(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID, uint32_t *const aXcvrID)
{
    uint32_t i;
    int ret = BCM_ERR_OK;

    for (i = 0UL; i < ETHSWT_PORT_ID_MAX; i++) {
        if ((1UL == ETHSWT_XcvrPortMap[i].valid)
            && (ETHSWT_XcvrPortMap[i].portID == aPortID)) {
            *aXcvrID = ETHSWT_XcvrPortMap[i].xcvrID;
            break;
        }
    }
    if (i == ETHSWT_PORT_ID_MAX) {
        ret = BCM_ERR_NOT_FOUND;
    }
    return ret;
}

/** @brief Set port jumbo mode

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  aSwtID      Switch Index
    @param[in]  aPortID     Port ID
    @param[in]  aMode       Mode

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success

    @post None

    @trace #BRCM_SWARCH_ETHSWT_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_XCVR
*/
int32_t ETHSWT_DrvSetPortJumboMode(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID,
        ETHXCVR_BooleanType aMode)
{
    uint32_t line;
    int ret = BCM_ERR_OK;
    uint32_t portMaskVal;

    ret = ETHSWT_DrvReadReg32(aSwtID,
                (uint32_t)&ETHSWT_Regs->m40_jumbo_port_mask,
                &portMaskVal);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    if (ETHXCVR_BOOLEAN_TRUE == aMode) {
        portMaskVal |= (ETHSWT_PORTID2HWMASK(aPortID)
                        & SWITCH_P40JPM_PAGE_40_JUMBO_PORT_MASK_JUMBO_FM_PORT_MASK_MASK);
        portMaskVal |= SWITCH_P40JPM_PAGE_40_JUMBO_PORT_MASK_EN_10_100_JUMBO_MASK;
    } else {
        portMaskVal &= ~(ETHSWT_PORTID2HWMASK(aPortID));
    }
    ret = ETHSWT_DrvWriteReg32(aSwtID, (uint32_t)&ETHSWT_Regs->m40_jumbo_port_mask, portMaskVal);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
err_exit:
    ETHSWT_REPORT_ERR( ret, aSwtID, line,
        BRCM_SWDSGN_ETHSWT_DRV_SET_PORT_JUMBO_MODE_PROC, 0UL, 0UL, 0UL)
    return ret;
}

/** @brief Get port jumbo mode

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aSwtID      Switch Index
    @param[in]      aPortID     Port Index
    @param[inout]   aMode       Pointer to read mode into it

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success

    @post None

    @trace #BRCM_SWARCH_ETHSWT_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_XCVR
*/
static int32_t ETHSWT_DrvGetPortJumboMode(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID,
        ETHXCVR_BooleanType *const aMode)
{
    uint32_t line;
    int ret = BCM_ERR_OK;
    uint32_t reg;
    uint64_t portMaskVal = 0ULL;

    ret = ETHSWT_DrvReadReg32(aSwtID,
                (uint32_t)&ETHSWT_Regs->m40_jumbo_port_mask,
                &reg);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    portMaskVal |= (uint64_t)(ETHSWT_PORTID2HWMASK(aPortID)
                    & SWITCH_P40JPM_PAGE_40_JUMBO_PORT_MASK_JUMBO_FM_PORT_MASK_MASK);
    portMaskVal |= SWITCH_P40JPM_PAGE_40_JUMBO_PORT_MASK_EN_10_100_JUMBO_MASK;
    if ((reg & portMaskVal) == portMaskVal) {
        *aMode = ETHXCVR_BOOLEAN_TRUE;
    } else {
        *aMode = ETHXCVR_BOOLEAN_FALSE;
    }
err_exit:
    ETHSWT_REPORT_ERR( ret, aSwtID, line,
        BRCM_SWDSGN_ETHSWT_DRV_GET_PORT_JUMBO_MODE_PROC, 0UL, 0UL, 0UL)
    return ret;
}

/** @brief Link IRQ handler

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  aSwtID      Switch Index
    @param[in]  aPortID     Port Index

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @retval     #BCM_ERR_INVAL_PARAMS   (aSwtID is invalid) or
                                        (aPortID is invalid)

    @post None

    @trace #BRCM_SWARCH_ETHSWT_LINK_IRQ_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_XCVR
*/
static int32_t ETHSWT_DrvLinkIRQHandler(ETHSWT_HwIDType aSwtID,
                                        ETHSWT_PortIDType aPortID)
{
    uint32_t line = __LINE__;
    uint16_t reg;
    int32_t ret = BCM_ERR_OK;
    uint16_t i = 0U;
    uint16_t linkStatus;

    if ((aSwtID >= SWITCH_MAX_HW_ID) || (aPortID >= ETHSWT_PORT_ID_MAX)) {
        ret = BCM_ERR_INVAL_PARAMS;
        line = __LINE__;
        goto err_exit;
    }

    ret = MCU_SwitchInterruptClear(MCU_SWITCHINTRFLAGS_LINKSTATUS0
                                    | MCU_SWITCHINTRFLAGS_LINKSTATUS1
                                    | MCU_SWITCHINTRFLAGS_LINKSTATUS2
                                    | MCU_SWITCHINTRFLAGS_LINKSTATUS3
                                    | MCU_SWITCHINTRFLAGS_LINKSTATUS4
                                    | MCU_SWITCHINTRFLAGS_LINKSTATUS5
                                    | MCU_SWITCHINTRFLAGS_LINKSTATUS6
                                    | MCU_SWITCHINTRFLAGS_LINKSTATUS7
                                    | MCU_SWITCHINTRFLAGS_LINKSTATUS8);

    if (BCM_ERR_OK == ret) {
        /* Read link status change register */
        ret = ETHSWT_DrvReadReg16(aSwtID, (uint32_t)&ETHSWT_Regs->m01_lnkstschg, &reg);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
        reg &= SWITCH_LNK_STS_CHG_PORT_XLD7_MASK;
        ETHSWT_DrvData.portLinkStatus |=
            (((uint32_t)reg << ETHSWT_PORT_LINK_STATUS_CHANGED_SHIFT)
            & ETHSWT_PORT_LINK_STATUS_CHANGED_MASK);
        if (0U != reg) {
            /* Read link status register */
            ret = ETHSWT_DrvReadReg16(aSwtID, (uint32_t)&ETHSWT_Regs->m01_lnksts, &reg);
            ETHSWT_CHECK_ERR(ret, &line, err_exit)
            reg &= SWITCH_LNK_STS_PORT_XLD7_MASK;
            ETHSWT_DrvData.portLinkStatus &= ~ETHSWT_PORT_LINK_STATUS_MASK;
            ETHSWT_DrvData.portLinkStatus |=
                ((reg << ETHSWT_PORT_LINK_STATUS_SHIFT)
                 & ETHSWT_PORT_LINK_STATUS_MASK);
            linkStatus = (uint16_t)ETHSWT_DrvData.portLinkStatus;
            for (i = 0UL; i < ETHSWT_PORT_ID_MAX; i++) {
                if ((linkStatus & (0x1UL << i)) != 0UL) {
                    (ETHSWT_DrvData.portLinkStateChngCnt[i])++;
                }
            }
        }
    }
err_exit:
    ETHSWT_REPORT_ERR( ret, aSwtID, line,
        BRCM_SWDSGN_ETHSWT_DRV_LINK_IRQ_HANDLER_PROC, 0UL, 0UL, 0UL)
    return ret;
}

/** @brief Link state changed indication handler

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aSwtID              Switch Index
    @param[in]      aPortID             Port ID
    @param[inout]   aLinkState          Pointer to link state
    @param[inout]   aIsLinkStateChanged Pointer to set if link state changed

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success

    @post None

    @trace #BRCM_SWARCH_ETHSWT_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_XCVR
*/
static int32_t ETHSWT_DrvLinkStatChgIndHandler(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID,
        ETHXCVR_LinkStateType *const aLinkState,
        uint32_t *const aIsLinkStateChanged)
{
    int32_t retVal = BCM_ERR_OK;
    uint32_t portLinkStatus = ETHSWT_DrvData.portLinkStatus;
    uint32_t isPortLinkStatChg =
        (portLinkStatus & ETHSWT_PORT_LINK_STATUS_CHANGED_MASK);
    ETHSWT_DrvData.portLinkStatus &= ~(isPortLinkStatChg & (0x1UL << aPortID));
    isPortLinkStatChg >>= ETHSWT_PORT_LINK_STATUS_CHANGED_SHIFT;
    isPortLinkStatChg &= (0x1UL << aPortID);
    isPortLinkStatChg >>= aPortID;

    uint32_t portLinkStat = (portLinkStatus & ETHSWT_PORT_LINK_STATUS_MASK);
    ETHSWT_DrvData.portLinkStatus &= ~(portLinkStat & (0x1UL << aPortID));
    portLinkStat >>= ETHSWT_PORT_LINK_STATUS_SHIFT;
    portLinkStat &= (0x1UL << aPortID);
    portLinkStat >>= aPortID;

    if (0UL != isPortLinkStatChg) {
        if (1UL == portLinkStat) {
            *aLinkState = ETHXCVR_LINKSTATE_ACTIVE;
        } else {
            *aLinkState = ETHXCVR_LINKSTATE_DOWN;
        }
        *aIsLinkStateChanged = TRUE;
    } else {
        *aIsLinkStateChanged = FALSE;
    }

    return retVal;
}

/** @brief Get Xcvr statistics

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  aSwtID      Switch Index
    @param[in]  aPortID     Port Index
    @param[in]  aStats      Pointer to statistics

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @retval     #BCM_ERR_INVAL_PARAMS   (Switch Index is invalid) or
                                        (Port ID is invalid) or
                                        (aStats is NULL)

    @post None

    @trace #BRCM_SWARCH_ETHSWT_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_XCVR
*/
static int32_t ETHSWT_DrvGetXcvrStats(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID,
        ETHSWT_PortStatsType *const aStats)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;
    if ((aSwtID < SWITCH_MAX_HW_ID)
            && (aPortID < ETHSWT_PORT_ID_MAX)
            && (NULL != aStats)) {
        aStats->linkStateChangeCount =
            ETHSWT_DrvData.portLinkStateChngCnt[aPortID];
        retVal = BCM_ERR_OK;
    }

    return retVal;
}

/** @brief Get port link state

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aSwtID      Switch Index
    @param[in]      aPortID     Port Index
    @param[inout]   aLinkState  Pointer to link state

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @retval     #BCM_ERR_INVAL_PARAMS   (aSwtID i invalid) or
                                        (aPortID is invalid) or
                                        (aLinkState is NULL)

    @post None

    @trace #BRCM_SWARCH_ETHSWT_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_XCVR
*/
static int32_t ETHSWT_DrvGetPortLinkState(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID,
        ETHXCVR_LinkStateType *const aLinkState)
{
    uint32_t line = 0UL;
    uint16_t reg;
    int32_t ret = BCM_ERR_INVAL_PARAMS;
    uint32_t portLinkStatus;

    if ((aSwtID < SWITCH_MAX_HW_ID)
            && (aPortID < ETHSWT_PORT_ID_MAX)
            && (NULL != aLinkState)) {

        /* Read link status register */
        ret = ETHSWT_DrvReadReg16(aSwtID, (uint32_t)&ETHSWT_Regs->m01_lnksts, &reg);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
        reg &= SWITCH_LNK_STS_PORT_XLD7_MASK;
        portLinkStatus = (uint32_t)reg;
        portLinkStatus &= ~ETHSWT_PORT_LINK_STATUS_MASK;
        portLinkStatus |= (((uint32_t)reg << ETHSWT_PORT_LINK_STATUS_SHIFT)
                            & ETHSWT_PORT_LINK_STATUS_MASK);
        if ((portLinkStatus & (0x1UL << aPortID)) != 0UL) {
            *aLinkState = ETHXCVR_LINKSTATE_ACTIVE;
        } else {
            *aLinkState = ETHXCVR_LINKSTATE_DOWN;
        }
        ret = BCM_ERR_OK;
    }

err_exit:
    ETHSWT_REPORT_ERR( ret, aSwtID, line,
        BRCM_SWDSGN_ETHSWT_DRV_GET_PORT_LINK_STATE_PROC, 0UL, 0UL, 0UL)
    return ret;
}

/**
    @brief Get port mode

    @trace #BRCM_SWARCH_ETHSWT_GET_PORT_MODE_PROC
    @trace #BRCM_SWREQ_ETHSWT_XCVR
*/
int32_t ETHSWT_GetPortMode(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID,
        ETHXCVR_ModeType *const aMode)
{
    int32_t ret;
    uint32_t xcvrID;

    if ((aSwtID < SWITCH_MAX_HW_ID) && (aMode != NULL)) {
        if (ETHSWT_STATE_UNINIT == ETHSWT_GetState(aSwtID)) {
            ret = BCM_ERR_UNINIT;
        } else {
            ret = ETHSWT_GetXcvrID(aSwtID, aPortID, &xcvrID);
            if (ret == BCM_ERR_OK) {
                ret = ETHXCVR_GetMode((ETHXCVR_IDType)xcvrID, aMode);
            }
        }
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }

    return ret;
}

/**
    @brief Set port mode

    @trace #BRCM_SWARCH_ETHSWT_SET_PORT_MODE_PROC
    @trace #BRCM_SWREQ_ETHSWT_XCVR
*/
int32_t ETHSWT_SetPortMode(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID,
        ETHXCVR_ModeType aMode)
{
    int32_t ret;
    uint32_t xcvrID;

    if (aSwtID < SWITCH_MAX_HW_ID) {
        if (ETHSWT_STATE_UNINIT == ETHSWT_GetState(aSwtID)) {
            ret = BCM_ERR_UNINIT;
        } else {
            ret = ETHSWT_GetXcvrID(aSwtID, aPortID, &xcvrID);
            if (ret == BCM_ERR_OK) {
                ret = ETHXCVR_SetMode((ETHXCVR_IDType)xcvrID, aMode);
            }
        }
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }

    return ret;
}

/**
    @brief Get port master mode

    @trace #BRCM_SWARCH_ETHSWT_GET_PORT_MASTERMODE_PROC
    @trace #BRCM_SWREQ_ETHSWT_XCVR
*/
int32_t ETHSWT_GetPortMasterMode(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID,
        ETHXCVR_BooleanType *const aMode)
{
    int32_t ret;
    uint32_t xcvrID;

    if ((aSwtID < SWITCH_MAX_HW_ID) && (aMode != NULL)) {
        if (ETHSWT_STATE_UNINIT == ETHSWT_GetState(aSwtID)) {
            ret = BCM_ERR_UNINIT;
        } else {
            ret = ETHSWT_GetXcvrID(aSwtID, aPortID, &xcvrID);
            if (ret == BCM_ERR_OK) {
                ret = ETHXCVR_GetMasterMode((ETHXCVR_IDType)xcvrID, aMode);
            }
        }
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }

    return ret;
}

/**
    @brief Set port master mode

    @trace #BRCM_SWARCH_ETHSWT_SET_PORT_MASTERMODE_PROC
    @trace #BRCM_SWREQ_ETHSWT_XCVR
*/
int32_t ETHSWT_SetPortMasterMode(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID,
        ETHXCVR_BooleanType aMode)
{
    int32_t ret;
    uint32_t xcvrID;

    if (aSwtID < SWITCH_MAX_HW_ID) {
        if (ETHSWT_STATE_UNINIT == ETHSWT_GetState(aSwtID)) {
            ret = BCM_ERR_UNINIT;
        } else {
            ret = ETHSWT_GetXcvrID(aSwtID, aPortID, &xcvrID);
            if (ret == BCM_ERR_OK) {
                ret = ETHXCVR_SetMasterMode((ETHXCVR_IDType)xcvrID, aMode);
            }
        }
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }

    return ret;
}

/**
    @brief Get port loop back mode

    @trace #BRCM_SWARCH_ETHSWT_GET_PORT_LOOPBACKMODE_PROC
    @trace #BRCM_SWREQ_ETHSWT_XCVR
*/
int32_t ETHSWT_GetPortLoopbackMode(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID,
        ETHXCVR_BooleanType *const aMode)
{
    int32_t ret;
    uint32_t xcvrID;

    if ((aSwtID < SWITCH_MAX_HW_ID) && (aMode != NULL)) {
        if (ETHSWT_STATE_UNINIT == ETHSWT_GetState(aSwtID)) {
            ret = BCM_ERR_UNINIT;
        } else {
            ret = ETHSWT_GetXcvrID(aSwtID, aPortID, &xcvrID);
            if (ret == BCM_ERR_OK) {
                ret = ETHXCVR_GetLoopbackMode((ETHXCVR_IDType)xcvrID, aMode);
            }
        }
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }

    return ret;
}

/**
    @brief Set port loop back mode

    @trace #BRCM_SWARCH_ETHSWT_SET_PORT_LOOPBACKMODE_PROC
    @trace #BRCM_SWREQ_ETHSWT_XCVR
*/
int32_t ETHSWT_SetPortLoopbackMode(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID,
        ETHXCVR_BooleanType aMode)
{
    int32_t ret;
    uint32_t xcvrID;

    if (aSwtID < SWITCH_MAX_HW_ID) {
        if (ETHSWT_STATE_UNINIT == ETHSWT_GetState(aSwtID)) {
            ret = BCM_ERR_UNINIT;
        } else {
            ret = ETHSWT_GetXcvrID(aSwtID, aPortID, &xcvrID);
            if (ret == BCM_ERR_OK) {
                ret = ETHXCVR_SetLoopbackMode((ETHXCVR_IDType)xcvrID, aMode);
            }
        }
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }

    return ret;
}

/**
    @brief Get port jumbo mode

    @trace #BRCM_SWARCH_ETHSWT_GET_PORT_JUMBOMODE_PROC
    @trace #BRCM_SWREQ_ETHSWT_XCVR
*/
int32_t ETHSWT_GetPortJumboMode(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID,
        ETHXCVR_BooleanType *const aMode)
{
    int32_t ret;
    ETHSWT_IOType swtIO;
    ETHSWT_XcvrIOType xcvrIO;
    uint32_t xcvrID;

    if ((aSwtID < SWITCH_MAX_HW_ID) && (aMode != NULL)) {
        swtIO.xcvrIO = &xcvrIO;
        xcvrIO.portHwID = aPortID;
        swtIO.retVal = BCM_ERR_UNKNOWN;
        swtIO.swtHwID = aSwtID;
        ret = ETHSWT_GetXcvrID(aSwtID, aPortID, &xcvrID);
        if (BCM_ERR_OK == ret) {
            ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_GET_JUMBO_MODE, &swtIO);
            if (ret == BCM_ERR_OK) {
                ret = ETHXCVR_GetJumboMode((ETHXCVR_IDType)xcvrID, aMode);
                if (ret == BCM_ERR_OK ) {
                    if (!(xcvrIO.jumbo == *aMode)) {
                        ETHSWT_DrvReportError((BCM_SWT_ID & BCM_LOGMASK_USER), (uint8_t)aSwtID,
                                BRCM_SWDSGN_ETHSWT_GET_PORT_JUMBO_MODE_PROC, ret, aPortID, xcvrIO.jumbo, (uint32_t)*aMode,
                                __LINE__);
                        ret = BCM_ERR_UNKNOWN;
                    }
                }
            }
        }
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }

    return ret;
}

/**
    @brief Set port jumbo mode

    @trace #BRCM_SWARCH_ETHSWT_SET_PORT_JUMBOMODE_PROC
    @trace #BRCM_SWREQ_ETHSWT_XCVR
*/
int32_t ETHSWT_SetPortJumboMode(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID,
        ETHXCVR_BooleanType aMode)
{
    int32_t ret;
    ETHSWT_IOType swtIO;
    ETHSWT_XcvrIOType xcvrIO;
    uint32_t xcvrID;

    if (aSwtID < SWITCH_MAX_HW_ID) {
        swtIO.xcvrIO = &xcvrIO;
        xcvrIO.portHwID = aPortID;
        xcvrIO.jumbo = aMode;
        swtIO.retVal = BCM_ERR_UNKNOWN;
        swtIO.swtHwID = aSwtID;
        ret = ETHSWT_GetXcvrID(aSwtID, aPortID, &xcvrID);
        if (BCM_ERR_OK == ret) {
            ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_SET_JUMBO_MODE, &swtIO);
            if (ret == BCM_ERR_OK) {
                ret = ETHXCVR_SetJumboMode((ETHXCVR_IDType)xcvrID, aMode);
            }
        }
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }

    return ret;
}

/**
    @brief Get port link state

    @trace #BRCM_SWARCH_ETHSWT_GET_PORT_LINK_STATE_PROC
    @trace #BRCM_SWREQ_ETHSWT_XCVR
*/
int32_t ETHSWT_GetPortLinkState(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID,
        ETHXCVR_LinkStateType *const aLinkState)
{
    int32_t ret;
    ETHSWT_IOType swtIO;
    ETHSWT_XcvrIOType xcvrIO;

    if ((aSwtID < SWITCH_MAX_HW_ID) && (aLinkState != NULL)) {
        swtIO.xcvrIO = &xcvrIO;
        xcvrIO.portHwID = aPortID;
        swtIO.retVal = BCM_ERR_UNKNOWN;
        swtIO.swtHwID = aSwtID;
        ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_GET_LINKSTATE, &swtIO);
        if (ret == BCM_ERR_OK) {
            *aLinkState = xcvrIO.linkState;
        }
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }
    return ret;
}

/**
    @brief Set port speed

    @trace #BRCM_SWARCH_ETHSWT_SET_PORT_SPEED_PROC
    @trace #BRCM_SWREQ_ETHSWT_XCVR
*/
int32_t ETHSWT_SetPortSpeed(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID,
        ETHXCVR_SpeedType aSpeed)
{
    int32_t ret;
    uint32_t xcvrID;

    if (aSwtID < SWITCH_MAX_HW_ID) {
        if (ETHSWT_STATE_UNINIT == ETHSWT_GetState(aSwtID)) {
            ret = BCM_ERR_UNINIT;
        } else {
            ret = ETHSWT_GetXcvrID(aSwtID, aPortID, &xcvrID);
            if (ret == BCM_ERR_OK) {
                ret = ETHXCVR_SetSpeed((ETHXCVR_IDType)xcvrID, aSpeed);
            }
        }
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }

    return ret;
}

/**
    @brief Get port speed

    @trace #BRCM_SWARCH_ETHSWT_GET_PORT_SPEED_PROC
    @trace #BRCM_SWREQ_ETHSWT_XCVR
*/
int32_t ETHSWT_GetPortSpeed(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID,
        ETHXCVR_SpeedType *const aSpeed)
{
    int32_t ret;
    uint32_t xcvrID;

    if ((aSwtID < SWITCH_MAX_HW_ID) && (aSpeed != NULL)) {
        if (ETHSWT_STATE_UNINIT == ETHSWT_GetState(aSwtID)) {
            ret = BCM_ERR_UNINIT;
        } else {
            ret = ETHSWT_GetXcvrID(aSwtID, aPortID, &xcvrID);
            if (ret == BCM_ERR_OK) {
                ret = ETHXCVR_GetSpeed((ETHXCVR_IDType)xcvrID, aSpeed);
            }
        }
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }

    return ret;
}

/**
    @brief Enable port AutoNeg

    @trace #BRCM_SWARCH_ETHSWT_ENABLE_PORT_AUTONEG_PROC
    @trace #BRCM_SWREQ_ETHSWT_XCVR
*/
int32_t ETHSWT_EnablePortAutoNeg(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID)
{
    int32_t ret;
    uint32_t xcvrID;

    if (aSwtID < SWITCH_MAX_HW_ID) {
        if (ETHSWT_STATE_UNINIT == ETHSWT_GetState(aSwtID)) {
            ret = BCM_ERR_UNINIT;
        } else {
            ret = ETHSWT_GetXcvrID(aSwtID, aPortID, &xcvrID);
            if (ret == BCM_ERR_OK) {
                ret = ETHXCVR_SetAutoNegMode((ETHXCVR_IDType)xcvrID, (ETHXCVR_BooleanType)ETHXCVR_BOOLEAN_TRUE);
            }
        }
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }

    return ret;
}

/**
    @brief Get AutoNeg status

    @trace #BRCM_SWARCH_ETHSWT_GET_PORT_AUTONEG_STATUS_PROC
    @trace #BRCM_SWREQ_ETHSWT_XCVR
*/
int32_t ETHSWT_GetPortAutoNegStatus(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID,
        ETHXCVR_AutoNegStatusType *const aAutoNegStatus)
{
    int32_t ret;
    uint32_t xcvrID;

    if ((aSwtID < SWITCH_MAX_HW_ID) && (aAutoNegStatus != NULL)) {
        if (ETHSWT_STATE_UNINIT == ETHSWT_GetState(aSwtID)) {
            ret = BCM_ERR_UNINIT;
        } else {
            ret = ETHSWT_GetXcvrID(aSwtID, aPortID, &xcvrID);
            if (ret == BCM_ERR_OK) {
                ret = ETHXCVR_GetAutoNegStatus((ETHXCVR_IDType)xcvrID, aAutoNegStatus);
            }
        }
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }

    return ret;
}

/**
    @brief Get port duplex mode

    @trace #BRCM_SWARCH_ETHSWT_GET_PORT_DUPLEX_MODE_PROC
    @trace #BRCM_SWREQ_ETHSWT_XCVR
*/
int32_t ETHSWT_GetPortDuplexMode(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID,
        ETHXCVR_DuplexModeType *const aDuplexMode)
{
    int32_t ret;
    uint32_t xcvrID;

    if ((aSwtID < SWITCH_MAX_HW_ID) && (aDuplexMode != NULL)){
        if (ETHSWT_STATE_UNINIT == ETHSWT_GetState(aSwtID)) {
            ret = BCM_ERR_UNINIT;
        } else {
            ret = ETHSWT_GetXcvrID(aSwtID, aPortID, &xcvrID);
            if (ret == BCM_ERR_OK) {
                ret = ETHXCVR_GetDuplexMode((ETHXCVR_IDType)xcvrID, aDuplexMode);
            }
        }
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }
    return ret;
}

/**
    @brief Get tranceiver statistics

    @trace #BRCM_SWARCH_ETHSWT_GET_XCVR_STATS_PROC
    @trace #BRCM_SWREQ_ETHSWT_XCVR
*/
int32_t ETHSWT_GetXcvrStats(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID,
        ETHSWT_PortStatsType *const aStats)
{
    int32_t ret;
    ETHSWT_IOType swtIO;
    ETHSWT_XcvrIOType xcvrIO;
    uint32_t xcvrID;

    if (aSwtID < SWITCH_MAX_HW_ID) {
        swtIO.xcvrIO = &xcvrIO;
        xcvrIO.portHwID = aPortID;
        xcvrIO.portStats = aStats;
        swtIO.retVal = BCM_ERR_UNKNOWN;
        swtIO.swtHwID = aSwtID;
        ret = ETHSWT_GetXcvrID(aSwtID, aPortID, &xcvrID);
        if (ret == BCM_ERR_OK) {
            ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_GET_XCVR_STATS,
                    &swtIO);
        }
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }
    return ret;
}

/**
    @brief Get SQI value

    @trace #BRCM_SWARCH_ETHSWT_GET_SQI_VAL_PROC
    @trace #BRCM_SWREQ_ETHSWT_XCVR
*/
int32_t ETHSWT_GetSQIValue(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID,
        uint32_t *const aSQIValue)
{
    int32_t ret;
    uint32_t xcvrID;

    if (aSwtID < SWITCH_MAX_HW_ID){
        if (ETHSWT_STATE_UNINIT == ETHSWT_GetState(aSwtID)) {
            ret = BCM_ERR_UNINIT;
        } else {
            ret = ETHSWT_GetXcvrID(aSwtID, aPortID, &xcvrID);
            if (ret == BCM_ERR_OK) {
                ret = ETHXCVR_GetSQIValue((ETHXCVR_IDType)aPortID, aSQIValue);
            }
        }
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }
    return ret;
}

/**
    @brief Get port type

    @trace #BRCM_SWARCH_ETHSWT_GET_PORT_TYPE_PROC
    @trace #BRCM_SWREQ_ETHSWT_XCVR
*/
int32_t ETHSWT_GetPortType(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID,
        ETHXCVR_BusModeType *const aBusMode,
        ETHXCVR_PhyMediaType *const aPhyMedia)
{
    int32_t ret = BCM_ERR_INVAL_PARAMS;

    if ((aSwtID < SWITCH_MAX_HW_ID)
            && (aPortID < ETHSWT_PORT_ID_MAX)
            && (NULL != aBusMode) && (NULL != aPhyMedia)) {
        if (ETHSWT_STATE_UNINIT == ETHSWT_GetState(aSwtID)) {
            ret = BCM_ERR_UNINIT;
        } else {
            uint32_t xcvrID;
            ETHXCVR_PortConfigType portConfig;

            ret = ETHSWT_GetXcvrID(aSwtID, aPortID, &xcvrID);
            if (ret == BCM_ERR_OK) {
                ret  = ETHXCVR_GetPortConfig((ETHXCVR_IDType)xcvrID, &portConfig);
                if (BCM_ERR_OK == ret) {
                    *aBusMode = portConfig.busMode;
                    *aPhyMedia = portConfig.phy.phyMedia;
                }
            }
        }
    }
    return ret;
}


/**
    @brief Set Wakeup Mode

    @trace #BRCM_SWARCH_ETHSWT_SET_PORTWAKEUP_MODE_PROC
    @trace #BRCM_SWREQ_ETHSWT_XCVR

    @code{.c}
    if aSwtID < SWITCH_MAX_HW_ID
       if ETHSWT_GetState is ETHSWT_STATE_UNINIT
           ret is BCM_ERR_UNINIT
       else
           ret = ETHSWT_GetXcvrID(aSwtID, aPortID, &xcvrID)
           if ret is BCM_ERR_OK
               ETHXCVR_SetWakeUpMode(xcvrID, aMode)
    else
        ret is BCM_ERR_INVAL_PARAMS
    return ret

*/
int32_t ETHSWT_SetPortWakeUpMode(ETHSWT_HwIDType aSwtID,
                                 ETHSWT_PortIDType aPortID,
                                 ETHXCVR_BooleanType aMode)
{
    int32_t ret;
    uint32_t xcvrID;

    if (aSwtID < SWITCH_MAX_HW_ID) {
        if (ETHSWT_GetState(aSwtID) == ETHSWT_STATE_UNINIT) {
            ret = BCM_ERR_UNINIT;
        } else {
            ret = ETHSWT_GetXcvrID(aSwtID, aPortID, &xcvrID);
            if (ret == BCM_ERR_OK) {
                ret = ETHXCVR_SetWakeUpMode((ETHXCVR_IDType)xcvrID, aMode);
            }
        }
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }

    return ret;
}

/**
    @brief  Get Port WakeUp Mode Function

    @trace #BRCM_SWARCH_ETHSWT_GET_PORTWAKEUP_MODE_PROC
    @trace #BRCM_SWREQ_ETHSWT_XCVR

    @code{.c}
    if aSwtID < SWITCH_MAX_HW_ID ANS aMode is Not NULL
       if ETHSWT_GetState is ETHSWT_STATE_UNINIT
           ret is BCM_ERR_UNINIT
       else
           ret = ETHSWT_GetXcvrID(aSwtID, aPortID, &xcvrID)
           if ret is BCM_ERR_OK
               ETHXCVR_GetWakeUpMode(xcvrID, aMode)
    else
        ret is BCM_ERR_INVAL_PARAMS
    return ret

*/
int32_t ETHSWT_GetPortWakeUpMode(ETHSWT_HwIDType aSwtID,
                                 ETHSWT_PortIDType aPortID,
                                 ETHXCVR_BooleanType *const aMode)
{
    int32_t ret;
    uint32_t xcvrID;

    if ((aSwtID < SWITCH_MAX_HW_ID) && (NULL != aMode)) {
        if (ETHSWT_STATE_UNINIT == ETHSWT_GetState(aSwtID)) {
            ret = BCM_ERR_UNINIT;
        } else {
            ret = ETHSWT_GetXcvrID(aSwtID, aPortID, &xcvrID);
            if (ret == BCM_ERR_OK) {
                ret = ETHXCVR_GetWakeUpMode((ETHXCVR_IDType)xcvrID, aMode);
            }
        }
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }

    return ret;
}

/**
    @brief  Get Port WakeUp Reason Function

    @trace #BRCM_SWARCH_ETHSWT_GET_PORTWAKEUPREASON_PROC
    @trace #BRCM_SWREQ_ETHSWT_XCVR

    @code{.c}
    if aSwtID < SWITCH_MAX_HW_ID AND aReason is Not NULL
       if ETHSWT_GetState is ETHSWT_STATE_UNINIT
           ret is BCM_ERR_UNINIT
       else
           ret = ETHSWT_GetXcvrID(aSwtID, aPortID, &xcvrID)
           if ret is BCM_ERR_OK
               ETHXCVR_GetWakeUpReason(xcvrID, aMode)
    else
        ret is BCM_ERR_INVAL_PARAMS
    return ret

*/
int32_t ETHSWT_GetPortWakeUpReason(ETHSWT_HwIDType aSwtID,
                         ETHSWT_PortIDType aPortID,
                         ETHXCVR_WakeupReasonType *const aReason)
{
    int32_t ret;
    uint32_t xcvrID;

    if ((aSwtID < SWITCH_MAX_HW_ID) && (aReason != NULL)) {
        if (ETHSWT_STATE_UNINIT == ETHSWT_GetState(aSwtID)) {
            ret = BCM_ERR_UNINIT;
        } else {
            ret = ETHSWT_GetXcvrID(aSwtID, aPortID, &xcvrID);
            if (ret == BCM_ERR_OK) {
                ret = ETHXCVR_GetWakeUpReason((ETHXCVR_IDType)xcvrID, aReason);
            }
        }
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }

    return ret;
}

/**
    @brief Tranceiver state handler

    @trace #BRCM_SWARCH_ETHSWT_XCVR_STATE_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_XCVR
*/
int32_t ETHSWT_XcvrStateHandler(ETHSWT_HwIDType aSwtID,
                              ETHSWT_PortIDType aPortID)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    if (aSwtID < SWITCH_MAX_HW_ID) {
        retVal = ETHXCVR_StateHandler((ETHXCVR_IDType)aPortID);

        if ((BCM_ERR_OK != retVal) && (BCM_ERR_EAGAIN != retVal) &&
            (BCM_ERR_INVAL_PARAMS != retVal)) {
            retVal = BCM_ERR_UNKNOWN;
        }
    }

    return retVal;
}

/**
    @brief Link IRQ handler

    @trace #BRCM_SWARCH_ETHSWT_LINK_IRQ_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_XCVR
*/
void ETHSWT_LinkIRQHandler(ETHSWT_HwIDType aSwtID,
                                    ETHSWT_PortIDType aPortID)
{
    int32_t ret;
    ret = ETHSWT_DrvLinkIRQHandler(aSwtID, aPortID);

    if (BCM_ERR_OK != ret) {
        ETHSWT_DrvReportError(BCM_SWT_ID, (uint8_t)aSwtID,
                BRCM_SWDSGN_ETHSWT_LINK_IRQ_HANDLER_PROC, ret,
                aPortID, 0UL, 0UL, __LINE__);
    }
}

/**
    @brief Link state change indication handler

    @trace #BRCM_SWARCH_ETHSWT_LINK_STAT_CHG_IND_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_XCVR
*/
void ETHSWT_LinkStatChgIndHandler(ETHSWT_HwIDType aSwtID,
                                    ETHSWT_PortIDType aPortID)
{
    ETHXCVR_LinkStateType linkState;
    uint32_t isLinkStateChanged;
    int32_t retVal;
    ETHSWT_IOType swtIO;
    ETHSWT_XcvrIOType xcvrIO;

    if ((aSwtID < SWITCH_MAX_HW_ID)
        && (aPortID < ETHSWT_PORT_ID_MAX)) {
        swtIO.xcvrIO = &xcvrIO;
        xcvrIO.portHwID = aPortID;
        xcvrIO.linkStatePtr = &linkState;
        xcvrIO.isLinkStateChangedPtr = &isLinkStateChanged;
        swtIO.retVal = BCM_ERR_UNKNOWN;
        swtIO.swtHwID = aSwtID;
        retVal = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_LINK_STATE_CHANGE_HDLR, &swtIO);

        if ((BCM_ERR_OK == retVal) && (TRUE == isLinkStateChanged)) {
            ETHSWT_IntgLinkStateChangeInd(aSwtID, aPortID, linkState);
        }
    }
}


/**
    @brief Switch command handler

    @trace #BRCM_SWARCH_ETHSWT_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_XCVR
*/
int32_t ETHSWT_XcvrCmdHandler(ETHSWT_HwIDType aSwtHwID, ETHSWT_IOCmdType aCmd, ETHSWT_XcvrIOType *const aIO)
{
    int32_t ret = BCM_ERR_NOSUPPORT;
    switch (aCmd) {
    case ETHSWT_IO_CMD_SET_JUMBO_MODE:
        ret = ETHSWT_DrvSetPortJumboMode(aSwtHwID, aIO->portHwID, (ETHXCVR_BooleanType)aIO->jumbo);
        break;
    case ETHSWT_IO_CMD_GET_JUMBO_MODE:
        ret = ETHSWT_DrvGetPortJumboMode(aSwtHwID, aIO->portHwID, &(aIO->jumbo));
        break;
    case ETHSWT_IO_CMD_GET_XCVR_STATS:
        ret = ETHSWT_DrvGetXcvrStats(aSwtHwID, aIO->portHwID, aIO->portStats);
        break;
    case ETHSWT_IO_CMD_GET_LINKSTATE:
        ret = ETHSWT_DrvGetPortLinkState(aSwtHwID, aIO->portHwID, &(aIO->linkState));
        break;
    case ETHSWT_IO_CMD_LINK_STATE_CHANGE_HDLR:
        ret = ETHSWT_DrvLinkStatChgIndHandler(aSwtHwID, aIO->portHwID,
                aIO->linkStatePtr, aIO->isLinkStateChangedPtr);
        break;
    default:
        ret = BCM_ERR_NOSUPPORT;
        break;
    }
    return ret;
}
/** @} */
