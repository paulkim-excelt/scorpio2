/*****************************************************************************
 Copyright 2019-2021 Broadcom Limited.  All rights reserved.

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

    @file switch_mirror.c

    @brief Ethernet switch Mirror functionality

    @version 0.1 Initial version
*/

#include <switch_rdb.h>
#include <bcm_utils.h>
#include <bcm_err.h>
#include <eth_switch.h>
#include <eth_switch_osil.h>
#include <ethswt_debug_osil.h>
#include "switch_drv.h"
#include "switch_cfg.h"
#include <switch_rdb.h>

/**
    @name Ethernet switch Design ID's
    @{
    @brief Ethernet switch Design ID's
*/
#define BRCM_SWDSGN_ETHSWT_DRV_GET_MIRROR_CAPTURE_PORT_PROC    (0xB201U)    /**< @brief #ETHSWT_DrvGetMirrorCapturePort */
#define BRCM_SWDSGN_ETHSWT_DRV_SET_PORT_MIRROR_CONFIG_PROC     (0xB202U)    /**< @brief #ETHSWT_DrvSetPortMirrorConfig  */
#define BRCM_SWDSGN_ETHSWT_DRV_GET_PORT_MIRROR_CONFIG_PROC     (0xB203U)    /**< @brief #ETHSWT_DrvGetPortMirrorConfig  */
#define BRCM_SWDSGN_ETHSWT_DRV_SET_PORT_MIRROR_STATE_PROC      (0xB204U)    /**< @brief #ETHSWT_DrvSetPortMirrorState   */
#define BRCM_SWDSGN_ETHSWT_DRV_GET_PORT_MIRROR_STATE_PROC      (0xB205U)    /**< @brief #ETHSWT_DrvGetPortMirrorState   */
#define BRCM_SWDSGN_ETHSWT_DRV_SET_LED_STATE_PROC              (0xB206U)    /**< @brief #ETHSWT_DrvSetLedState          */
#define BRCM_SWDSGN_ETHSWT_DRV_GET_LED_STATE_PROC              (0xB207U)    /**< @brief #ETHSWT_DrvGetLedState          */
#define BRCM_SWDSGN_ETHSWT_DRV_GET_RX_STAT_PROC                (0xB208U)    /**< @brief #ETHSWT_DrvGetRxStat            */
#define BRCM_SWDSGN_ETHSWT_DRV_GET_TX_STAT_PROC                (0xB209U)    /**< @brief #ETHSWT_DrvGetTxStat            */
#define BRCM_SWDSGN_ETHSWT_DRV_CLEAR_RX_STAT_PROC              (0xB20AU)    /**< @brief #ETHSWT_DrvClearRxStat          */
#define BRCM_SWDSGN_ETHSWT_DRV_CLEAR_TX_PROC                   (0xB20BU)    /**< @brief #ETHSWT_DrvClearTxStat          */
#define BRCM_SWDSGN_ETHSWT_DBG_CMD_HANDLER_PROC                (0xB20CU)    /**< @brief #ETHSWT_DbgCmdHandler           */
#define BRCM_SWDSGN_ETHSWT_MIRR_REGS_GLOBAL                    (0xB20DU)    /**< @brief #ETHSWT_Mirr_Regs               */
#define BRCM_SWDSGN_ETHSWT_SET_PORT_MIRROR_CONFIG_PROC         (0xB20EU)    /**< @brief #ETHSWT_SetPortMirrorConfig     */
#define BRCM_SWDSGN_ETHSWT_GET_PORT_MIRROR_CONFIG_PROC         (0xB20FU)    /**< @brief #ETHSWT_GetPortMirrorConfig     */
#define BRCM_SWDSGN_ETHSWT_SET_PORT_MIRROR_STATE_PROC          (0xB210U)    /**< @brief #ETHSWT_SetPortMirrorState      */
#define BRCM_SWDSGN_ETHSWT_GET_PORT_MIRROR_STATE_PROC          (0xB211U)    /**< @brief #ETHSWT_GetPortMirrorState      */
#define BRCM_SWDSGN_ETHSWT_GET_MIRROR_CAPTURE_PORT_PROC        (0xB212U)    /**< @brief #ETHSWT_GetMirrorCapturePort    */
#define BRCM_SWDSGN_ETHSWT_SET_LED_STATE_PROC                  (0xB213U)    /**< @brief #ETHSWT_SetLedState             */
#define BRCM_SWDSGN_ETHSWT_GET_LED_STATE_PROC                  (0xB214U)    /**< @brief #ETHSWT_GetLedState             */
#define BRCM_SWDSGN_ETHSWT_GET_RX_STAT_PROC                    (0xB215U)    /**< @brief #ETHSWT_GetRxStat               */
#define BRCM_SWDSGN_ETHSWT_CLEAR_RX_STAT_PROC                  (0xB216U)    /**< @brief #ETHSWT_ClearRxStat             */
#define BRCM_SWDSGN_ETHSWT_GET_TX_STAT_PROC                    (0xB217U)    /**< @brief #ETHSWT_GetTxStat               */
#define BRCM_SWDSGN_ETHSWT_CLEAR_TX_STAT_PROC                  (0xB218U)    /**< @brief #ETHSWT_ClearTxStat             */
/** @} */

/**
    @brief Switch registers

    @trace #BRCM_SWARCH_ETHSWT_DBG_CMD_HANDLER_PROC
    @trace #BRCM_SWARCH_ETHSWT_LINK_IRQ_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_KERNEL_INTERFACE
*/
static SWITCH_RDBType *const ETHSWT_Mirr_Regs = (SWITCH_RDBType *)SWITCH_BASE;

/** @brief Get mirror capture port

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  aSwtID      Switch Index
    @param[in]  aPortID     Pointer to port index

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @retval     #BCM_ERR_INVAL_PARAMS   (aSwtID is invalid) or
                                        (aPortID is invalid)
    @retval     #BCM_ERR_NOT_FOUND      Port is not found

    @post None

    @trace #BRCM_SWARCH_ETHSWT_DBG_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_QUERY
*/
static int32_t ETHSWT_DrvGetMirrorCapturePort(ETHSWT_HwIDType aSwtID,
                                              ETHSWT_PortIDType *const aPortID)
{
    uint32_t line;
    uint16_t reg;
    int32_t ret = BCM_ERR_OK;

    if ((aSwtID >= SWITCH_MAX_HW_ID) || (NULL == aPortID)) {
        ret = BCM_ERR_INVAL_PARAMS;
        line = __LINE__;
        goto err_exit;
    }

    ret = ETHSWT_DrvReadReg16(aSwtID, (uint32_t)&ETHSWT_Mirr_Regs->m02_mircapctl, &reg);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)

    if ((reg & SWITCH_PAGE_02_MIRCAPCTL_MIR_EN_MASK) == 0U) {
        ret = BCM_ERR_NOT_FOUND;
        line = __LINE__;
    } else {
        *aPortID = (ETHSWT_PortIDType)(reg & SWITCH_PAGE_02_MIRCAPCTL_SMIR_CAP_PORT_MASK);
    }

err_exit:
    ETHSWT_REPORT_ERR(ret, aSwtID, line,
        BRCM_SWDSGN_ETHSWT_DRV_GET_MIRROR_CAPTURE_PORT_PROC, 0UL, 0UL, 0UL)
    return ret;
}

/** @brief Set port mirror configuration

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  aSwtID      Switch Index
    @param[in]  aPortID     Port ID
    @param[in]  aDirection  Traffic direction
    @param[in]  aConfig     Pointer to configuation

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @retval     #BCM_ERR_INVAL_PARAMS   (aConfig is NULL) or
                                        (Traffic direction is invalid) or
                                        (Port mask or switch type is invalid) or
                                        (Switch Index is invalid) or
                                        (Port ID is invalid) or
                                        (Packet divide is invalid)

    @post None

    @trace #BRCM_SWARCH_ETHSWT_DBG_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_DYNAMIC_CONFIGURATION
*/
static int32_t ETHSWT_DrvSetPortMirrorConfig(ETHSWT_HwIDType aSwtID,
                                             ETHSWT_PortIDType aPortID,
                                             ETHSWT_TrafficDirType aDirection,
                                             const ETHSWT_PortMirrorCfgType *const aConfig)
{
    uint32_t line;
    int32_t ret = BCM_ERR_OK;
    uint64_t srcMacAddr;
    uint64_t destMacAddr;
    uint64_t macAddr;
    uint16_t mirrorCntrReg;
    uint16_t reg;
    uint16_t packetDivider = 0U;

    if (aConfig == NULL) {
        ret = BCM_ERR_INVAL_PARAMS;
        line = __LINE__;
        goto err_exit;
    }
    if ((aDirection != ETHSWT_TRAFFICDIR_INGRESS)
            && (aDirection != ETHSWT_TRAFFICDIR_EGRESS)) {
        ret = BCM_ERR_INVAL_PARAMS;
        line = __LINE__;
        goto err_exit;
    }

    if ((aConfig->portMask == 0UL)
            && (ETHSWT_DrvData.switchType == ETHSWT_SWITCH_STANDARD)) {
        ret = BCM_ERR_INVAL_PARAMS;
        line = __LINE__;
        goto err_exit;
    }

    if ((aSwtID >= SWITCH_MAX_HW_ID) || (aPortID >= ETHSWT_PORT_ID_MAX)) {
        ret = BCM_ERR_INVAL_PARAMS;
        line = __LINE__;
        goto err_exit;
    }

    srcMacAddr = ETHSWT_NMAC2HWMAC(aConfig->srcMacAddrFilter);
    destMacAddr = ETHSWT_NMAC2HWMAC(aConfig->destMacAddrFilter);

    if (aConfig->packetDivider > SWITCH_PAGE_02_IGMIRDIV_IN_MIR_DIV_MASK) {
        ret = BCM_ERR_INVAL_PARAMS;
        line = __LINE__;
        goto err_exit;
    }

    if (srcMacAddr != 0ULL) {
        macAddr = srcMacAddr;
        mirrorCntrReg = SWITCH_MIR_FLTR_SA_MATCH
                        << SWITCH_PAGE_02_IGMIRCTL_IN_MIR_FLTR_SHIFT;
    } else if (destMacAddr != 0ULL) {
        macAddr = destMacAddr;
        mirrorCntrReg = SWITCH_MIR_FLTR_DA_MATCH
                        << SWITCH_PAGE_02_IGMIRCTL_IN_MIR_FLTR_SHIFT;
    } else {
        macAddr = 0ULL;
        mirrorCntrReg = SWITCH_MIR_FLTR_ALL_PACKETS
                        << SWITCH_PAGE_02_IGMIRCTL_IN_MIR_FLTR_SHIFT;
    }

    if (aConfig->packetDivider != 0UL) {
        mirrorCntrReg |= SWITCH_PAGE_02_IGMIRCTL_IN_DIV_EN_MASK;
        packetDivider = (aConfig->packetDivider - 1U);
    }

    mirrorCntrReg |= (aConfig->portMask
                            & SWITCH_PAGE_02_IGMIRCTL_IN_MIR_MSK_MASK);

    /* first ensure that port mirroring is disabled */
    ret = ETHSWT_DrvReadReg16(aSwtID, (uint32_t)&ETHSWT_Mirr_Regs->m02_mircapctl, &reg);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    reg &= ~SWITCH_PAGE_02_MIRCAPCTL_MIR_EN_MASK;
    reg &= ~SWITCH_PAGE_02_MIRCAPCTL_SMIR_CAP_PORT_MASK;
    reg |= (uint64_t)(aPortID & SWITCH_PAGE_02_MIRCAPCTL_SMIR_CAP_PORT_MASK);
    ret = ETHSWT_DrvWriteReg16(aSwtID, (uint32_t)&ETHSWT_Mirr_Regs->m02_mircapctl, reg);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)

    if (aDirection == ETHSWT_TRAFFICDIR_INGRESS) {
        ret = ETHSWT_DrvWriteReg(aSwtID, SWITCH_PAGE_02_IGMIRMAC,
                    macAddr & SWITCH_PAGE_02_IGMIRMAC_IN_MIR_MAC_MASK);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
        ret = ETHSWT_DrvWriteReg16(aSwtID, (uint32_t)&ETHSWT_Mirr_Regs->m02_igmirdiv, packetDivider);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
        ret = ETHSWT_DrvWriteReg16(aSwtID, (uint32_t)&ETHSWT_Mirr_Regs->m02_igmirctl, mirrorCntrReg);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
    }

    if (aDirection == ETHSWT_TRAFFICDIR_EGRESS) {
        ret = ETHSWT_DrvWriteReg(aSwtID, SWITCH_PAGE_02_EGMIRMAC,
                    macAddr & SWITCH_PAGE_02_EGMIRMAC_OUT_MIR_MAC_MASK);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
        ret = ETHSWT_DrvWriteReg16(aSwtID, (uint32_t)&ETHSWT_Mirr_Regs->m02_egmirdiv, packetDivider);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
        ret = ETHSWT_DrvWriteReg16(aSwtID, (uint32_t)&ETHSWT_Mirr_Regs->mirregs_union_instance.mirregs_struct_instance.PAGE_02_EGMIRCTL, mirrorCntrReg);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
    }

    ETHSWT_DrvData.mirrorPortID = aPortID;

err_exit:
    ETHSWT_REPORT_ERR(ret, aSwtID, line,
        BRCM_SWDSGN_ETHSWT_DRV_SET_PORT_MIRROR_CONFIG_PROC, 0UL, 0UL, 0UL)
    return ret;
}

/** @brief Get port mirror configuration

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aSwtID      Switch Index
    @param[in]      aPortID     Port ID
    @param[in]      aDirection  Traffic direction
    @param[inout]   aConfig     Pointer to configuration structure

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @retval     #BCM_ERR_INVAL_PARAMS   (aConfig is NULL) or
                                        (Switch Index in invalid) or
                                        (Port ID is invalid) or
                                        (Mirror capture port ID doesn't match with aPortID)
    @retval     #BCM_ERR_INVAL_STATE    Port ID doesn't match with mirror port ID

    @post None

    @trace #BRCM_SWARCH_ETHSWT_DBG_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_QUERY
*/
static int32_t ETHSWT_DrvGetPortMirrorConfig(ETHSWT_HwIDType aSwtID,
                                             ETHSWT_PortIDType aPortID,
                                             ETHSWT_TrafficDirType aDirection,
                                             ETHSWT_PortMirrorCfgType *const aConfig)
{
    uint32_t line;
    uint16_t reg;
    uint64_t macAddr;
    uint16_t packetDivider;
    uint16_t mirrorCntrReg;

    int32_t ret = BCM_ERR_OK;

    if (aConfig == NULL) {
        ret = BCM_ERR_INVAL_PARAMS;
        line = __LINE__;
        goto err_exit;
    }

    if ((aSwtID >= SWITCH_MAX_HW_ID) || (aPortID >= ETHSWT_PORT_ID_MAX)) {
        ret = BCM_ERR_INVAL_PARAMS;
        line = __LINE__;
        goto err_exit;
    }

    if (ETHSWT_DrvData.mirrorPortID != aPortID) {
        ret = BCM_ERR_INVAL_STATE;
        line = __LINE__;
        goto err_exit;
    }

    BCM_MemSet(aConfig, 0x0, sizeof(ETHSWT_PortMirrorCfgType));

    ret = ETHSWT_DrvReadReg16(aSwtID, (uint32_t)&ETHSWT_Mirr_Regs->m02_mircapctl, &reg);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)

    if ((reg & SWITCH_PAGE_02_MIRCAPCTL_SMIR_CAP_PORT_MASK) != aPortID) {
        ret = BCM_ERR_INVAL_PARAMS;
        line = __LINE__;
        goto err_exit;
    }

    if (aDirection == ETHSWT_TRAFFICDIR_INGRESS) {
        ret = ETHSWT_DrvReadReg16(aSwtID, (uint32_t)&ETHSWT_Mirr_Regs->m02_igmirctl, &mirrorCntrReg);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
        ret = ETHSWT_DrvReadReg(aSwtID, SWITCH_PAGE_02_IGMIRMAC,
                    &macAddr);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
        ret = ETHSWT_DrvReadReg16(aSwtID, (uint32_t)&ETHSWT_Mirr_Regs->m02_igmirdiv, &packetDivider);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)

    }

    if (aDirection == ETHSWT_TRAFFICDIR_EGRESS) {
        ret = ETHSWT_DrvReadReg16(aSwtID, (uint32_t)&ETHSWT_Mirr_Regs->mirregs_union_instance.mirregs_struct_instance.PAGE_02_EGMIRCTL, &mirrorCntrReg);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
        ret = ETHSWT_DrvReadReg(aSwtID, SWITCH_PAGE_02_EGMIRMAC,
                    &macAddr);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
        ret = ETHSWT_DrvReadReg16(aSwtID, (uint32_t)&ETHSWT_Mirr_Regs->m02_egmirdiv, &packetDivider);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
    }

    aConfig->portMask = mirrorCntrReg & SWITCH_PAGE_02_IGMIRCTL_IN_MIR_MSK_MASK;

    if ((mirrorCntrReg & (SWITCH_MIR_FLTR_SA_MATCH
            << SWITCH_PAGE_02_IGMIRCTL_IN_MIR_FLTR_SHIFT)) != 0UL) {
        ETHSWT_HWMAC2NMAC(macAddr, aConfig->srcMacAddrFilter);
    } else if ((mirrorCntrReg & (SWITCH_MIR_FLTR_DA_MATCH << SWITCH_PAGE_02_EGMIRCTL_OUT_MIR_FLTR_SHIFT)) != 0UL) {
        ETHSWT_HWMAC2NMAC(macAddr, aConfig->destMacAddrFilter);
    } else {
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
    }

    aConfig->packetDivider = packetDivider;

err_exit:
    ETHSWT_REPORT_ERR(ret, aSwtID, line,
        BRCM_SWDSGN_ETHSWT_DRV_GET_PORT_MIRROR_CONFIG_PROC, 0UL, 0UL, 0UL)
    return ret;
}

/** @brief Set port mirror state

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  aSwtID      Switch Index
    @param[in]  aPortID     Port ID
    @param[in]  aState      Port mirror state

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @retval     #BCM_ERR_INVAL_PARAMS   (Switch Index in invalid) or
                                        (Port ID is invalid) or
                                        (aState is invalid)
    @retval     #BCM_ERR_INVAL_STATE    Mirror capture port ID doesn't match with aPortID

    @post None

    @trace #BRCM_SWARCH_ETHSWT_DBG_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_DYNAMIC_CONFIGURATION
*/
static int32_t ETHSWT_DrvSetPortMirrorState(ETHSWT_HwIDType aSwtID,
                                            ETHSWT_PortIDType aPortID,
                                            ETHSWT_PortMirrorStateType aState)
{
    uint32_t line;
    uint16_t reg;
    int32_t ret = BCM_ERR_OK;

    if ((aSwtID >= SWITCH_MAX_HW_ID) || (aPortID >= ETHSWT_PORT_ID_MAX)) {
        ret = BCM_ERR_INVAL_PARAMS;
        line = __LINE__;
        goto err_exit;
    }

    ret = ETHSWT_DrvReadReg16(aSwtID, (uint32_t)&ETHSWT_Mirr_Regs->m02_mircapctl, &reg);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)

    if ((reg & SWITCH_PAGE_02_MIRCAPCTL_SMIR_CAP_PORT_MASK) != aPortID) {
        ret = BCM_ERR_INVAL_STATE;
        line = __LINE__;
        goto err_exit;
    }

    if (aState == ETHSWT_PORTMIRRORSTATE_DISABLED) {
        reg &= ~SWITCH_PAGE_02_MIRCAPCTL_MIR_EN_MASK;

        ret = ETHSWT_DrvWriteReg(aSwtID, SWITCH_PAGE_02_IGMIRMAC, 0ULL);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
        ret = ETHSWT_DrvWriteReg16(aSwtID, (uint32_t)&ETHSWT_Mirr_Regs->m02_igmirdiv, 0U);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
        ret = ETHSWT_DrvWriteReg16(aSwtID, (uint32_t)&ETHSWT_Mirr_Regs->m02_igmirctl, 0U);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
        ret = ETHSWT_DrvWriteReg(aSwtID, SWITCH_PAGE_02_EGMIRMAC, 0ULL);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
        ret = ETHSWT_DrvWriteReg16(aSwtID, (uint32_t)&ETHSWT_Mirr_Regs->m02_egmirdiv, 0U);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
        ret = ETHSWT_DrvWriteReg16(aSwtID, (uint32_t)&ETHSWT_Mirr_Regs->mirregs_union_instance.mirregs_struct_instance.PAGE_02_EGMIRCTL, 0U);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)

    } else if (aState == ETHSWT_PORTMIRRORSTATE_ENABLED) {
        reg |= SWITCH_PAGE_02_MIRCAPCTL_MIR_EN_MASK;
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
        line = __LINE__;
        goto err_exit;
    }

    ret = ETHSWT_DrvWriteReg16(aSwtID, (uint32_t)&ETHSWT_Mirr_Regs->m02_mircapctl, reg);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
err_exit:
    ETHSWT_REPORT_ERR(ret, aSwtID, line,
        BRCM_SWDSGN_ETHSWT_DRV_SET_PORT_MIRROR_STATE_PROC, 0UL, 0UL, 0UL)
    return ret;
}

/** @brief Get port mirror state

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aSwtID      Switch Index
    @param[in]      aPortID     Port ID
    @param[inout]   aState      Pointer to port mirror state

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @retval     #BCM_ERR_INVAL_PARAMS   (Switch Index in invalid) or
                                        (Port ID is invalid) or
    @retval     #BCM_ERR_INVAL_STATE    Mirror capture port ID doesn't match with aPortID

    @post None

    @trace #BRCM_SWARCH_ETHSWT_DBG_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_QUERY
*/
static int32_t ETHSWT_DrvGetPortMirrorState(ETHSWT_HwIDType aSwtID,
                                            ETHSWT_PortIDType aPortID,
                                            ETHSWT_PortMirrorStateType *const aState)
{
    uint32_t line;
    uint16_t reg;
    int32_t ret = BCM_ERR_OK;

    if ((aSwtID >= SWITCH_MAX_HW_ID) || (aPortID >= ETHSWT_PORT_ID_MAX) ||
            (aState == NULL)) {
        ret = BCM_ERR_INVAL_PARAMS;
        line = __LINE__;
        goto err_exit;
    }

    ret = ETHSWT_DrvReadReg16(aSwtID, (uint32_t)&ETHSWT_Mirr_Regs->m02_mircapctl, &reg);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)

    if ((reg & SWITCH_PAGE_02_MIRCAPCTL_SMIR_CAP_PORT_MASK) != aPortID) {
        ret = BCM_ERR_INVAL_STATE;
        line = __LINE__;
        goto err_exit;
    }

    if ((reg & SWITCH_PAGE_02_MIRCAPCTL_MIR_EN_MASK) == 0UL) {
        *aState = ETHSWT_PORTMIRRORSTATE_DISABLED;
    } else {
        *aState = ETHSWT_PORTMIRRORSTATE_ENABLED;
    }

err_exit:
    ETHSWT_REPORT_ERR(ret, aSwtID, line,
        BRCM_SWDSGN_ETHSWT_DRV_GET_PORT_MIRROR_STATE_PROC, 0UL, 0UL, 0UL)
    return ret;
}

/** @brief Set LED state

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  aID         Index
    @param[in]  aPortID     Port ID
    @param[in]  aLedType    LED type
    @param[in]  aTurnOn     Flag to turn on the LED

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @retval     #BCM_ERR_INVAL_PARAMS   (aID is invalid) or
                                        (aPortID is invalid) or
                                        (aLedType is invalid) or
                                        (aTurnOn is nether TRUE nor FALSE)

    @post None

    @trace #BRCM_SWARCH_ETHSWT_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_DYNAMIC_CONFIGURATION
*/
static int32_t ETHSWT_DrvSetLedState(ETHSWT_HwIDType aID,
                            ETHSWT_PortIDType aPortID,
                            ETHSWT_LedType aLedType,
                            uint32_t aTurnOn)
{
    uint32_t line = __LINE__;;
    int32_t ret = BCM_ERR_INVAL_PARAMS;
    uint16_t mask, reg;

    if ((aID < SWITCH_MAX_HW_ID)
            && (aPortID < ETHSWT_PORT_ID_MAX)
            && ((TRUE == aTurnOn) || (FALSE == aTurnOn))
            && (ETHSWT_LED_AVB == aLedType)) {
        mask = ((0x1ULL << aPortID) & SWITCH_P90ELS_PAGE_90_EAV_LNK_STATUS_PT_EAV_LNK_STATUS_MASK);
        if (0UL != mask) {
            ret = ETHSWT_DrvReadReg16(aID, (uint32_t)&ETHSWT_Regs->m90_eav_lnk_status, &reg);
            ETHSWT_CHECK_ERR(ret, &line, err_exit)
            if (TRUE == aTurnOn) {
                reg |= mask;
            } else {
                reg &= ~mask;
            }
            ret = ETHSWT_DrvWriteReg16(aID, (uint32_t)&ETHSWT_Regs->m90_eav_lnk_status, reg);
            ETHSWT_CHECK_ERR(ret, &line, err_exit)
        } else {
            /* Ignore this function call, HW doesn't support these
             * LED ports */
            ret = BCM_ERR_OK;
        }
    }
err_exit:
    ETHSWT_REPORT_ERR(ret, aID, line,
        BRCM_SWDSGN_ETHSWT_DRV_SET_LED_STATE_PROC, 0UL, 0UL, 0UL)
    return ret;
}

/** @brief Get LED state

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aID         Index
    @param[in]      aPortID     Port ID
    @param[in]      aLedType    LED type
    @param[inout]   aIsStateOn  Pointer to check if LED is in on state

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @retval     #BCM_ERR_INVAL_PARAMS   (aID is invalid) or
                                        (aPortID is invalid) or
                                        (aLedType is invalid) or
                                        (aIsStateOn is NULL)

    @post None

    @trace #BRCM_SWARCH_ETHSWT_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_QUERY
*/
static int32_t ETHSWT_DrvGetLedState(ETHSWT_HwIDType aID,
                            ETHSWT_PortIDType aPortID,
                            ETHSWT_LedType aLedType,
                            uint32_t *const aIsStateOn)
{
    uint32_t line = 0UL;
    int32_t ret = BCM_ERR_INVAL_PARAMS;
    uint16_t mask, reg;

    if ((aID < SWITCH_MAX_HW_ID)
            && (aPortID < ETHSWT_PORT_ID_MAX)
            && (NULL != aIsStateOn)
            && (ETHSWT_LED_AVB == aLedType)) {
        mask = ((0x1ULL << aPortID) & SWITCH_P90ELS_PAGE_90_EAV_LNK_STATUS_PT_EAV_LNK_STATUS_MASK);
        if (0UL != mask) {
            ret = ETHSWT_DrvReadReg16(aID, (uint32_t)&ETHSWT_Regs->m90_eav_lnk_status, &reg);
            ETHSWT_CHECK_ERR(ret, &line, err_exit)
            if ((reg & mask) == mask) {
                *aIsStateOn = TRUE;
            } else {
                *aIsStateOn = FALSE;
            }

        } else {
            *aIsStateOn = FALSE;
            ret = BCM_ERR_OK;
        }
    }
err_exit:
    ETHSWT_REPORT_ERR(ret, aID, line,
        BRCM_SWDSGN_ETHSWT_DRV_GET_LED_STATE_PROC, 0UL, 0UL, 0UL)
    return ret;
}

/** @brief Get Rx statistics

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aSwtID      Switch Index
    @param[in]      aPortID     Port ID
    @param[inout]   aRxStat     Pointer to receiver statistics

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @retval     #BCM_ERR_INVAL_PARAMS   (Switch Index is invalid) or
                                        (Port ID in invalid) or
                                        (aRxStat is NULL)

    @post None

    @trace #BRCM_SWARCH_ETHSWT_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_QUERY
*/
static int32_t ETHSWT_DrvGetRxStat(ETHSWT_HwIDType aSwtID,
         ETHSWT_PortIDType aPortID,
         ETHER_RxStatsType *const aRxStat)
{
    uint32_t line;
    uint64_t val64;
    uint32_t val32;
    int32_t ret = BCM_ERR_OK;

    if ((aSwtID >= SWITCH_MAX_HW_ID) || (aPortID >= ETHSWT_PORT_ID_MAX) ||
            (NULL == aRxStat)) {
        ret = BCM_ERR_INVAL_PARAMS;
        line = __LINE__;
        goto err_exit;
    }

    BCM_MemSet(aRxStat, 0xFF, sizeof(ETHER_RxStatsType));

    ret = ETHSWT_DrvReadReg(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_rxgoodoctets + aPortID*256UL,
                    &val64);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    aRxStat->gdPkts = (uint32_t)val64;
    ret = ETHSWT_DrvReadReg(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_rxoctets + aPortID*256UL,
                    &val64);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    aRxStat->octetsLow = (uint32_t)val64;
    aRxStat->octetsHigh = (uint32_t)(val64 >> 32UL);
    ret = ETHSWT_DrvReadReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_rxbroadcastpkts + aPortID*256UL,
                    &val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    aRxStat->brdCast = val32;
    ret = ETHSWT_DrvReadReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_rxmulticastpkts + aPortID*256UL,
                    &val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    aRxStat->mutCast = val32;

    ret = ETHSWT_DrvReadReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_rxunicastpkts + aPortID*256UL,
                    &val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    aRxStat->uniCast = val32;

    ret = ETHSWT_DrvReadReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_rxpkts64octets + aPortID*256UL,
                    &val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    aRxStat->pkts64 = val32;

    ret = ETHSWT_DrvReadReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_rxpkts65to127octets + aPortID*256UL,
                    &val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    aRxStat->pkts65_127 = val32;

    ret = ETHSWT_DrvReadReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_rxpkts128to255octets + aPortID*256UL,
                    &val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    aRxStat->pkts128_255 = val32;

    ret = ETHSWT_DrvReadReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_rxpkts256to511octets + aPortID*256UL,
                    &val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    aRxStat->pkts256_511 = val32;

    ret = ETHSWT_DrvReadReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_rxpkts512to1023octets + aPortID*256UL,
                    &val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    aRxStat->pkts512_1023 = val32;

    ret = ETHSWT_DrvReadReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_rxpkts1024tomaxpktoctets + aPortID*256UL,
                    &val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    aRxStat->pkts1024_MAX = val32;

    ret = ETHSWT_DrvReadReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_rxjumbopkt + aPortID*256UL,
                    &val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    aRxStat->pkts8192_MAX = val32;

    ret = ETHSWT_DrvReadReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_rxjabbers + aPortID*256UL,
                    &val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    aRxStat->pktsJabber = val32;

    ret = ETHSWT_DrvReadReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_rxoversizepkts + aPortID*256UL,
                    &val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    aRxStat->pktsOvrSz = val32;

    ret = ETHSWT_DrvReadReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_rxfragments + aPortID*256UL,
                    &val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    aRxStat->pktsFrag = val32;

    ret = ETHSWT_DrvReadReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_rxdroppkts + aPortID*256UL,
                    &val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    aRxStat->pktsRxDrop = val32;

    ret = ETHSWT_DrvReadReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_rxalignmenterrors + aPortID*256UL,
                    &val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    aRxStat->pktsCrcAlignErr = val32;

    ret = ETHSWT_DrvReadReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_rxundersizepkts + aPortID*256UL,
                    &val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    aRxStat->pktsUndSz = val32;

    ret = ETHSWT_DrvReadReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_rxfcserrors + aPortID*256UL,
                    &val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    aRxStat->pktsCrcErr = val32;

    ret = ETHSWT_DrvReadReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_rxdiscard + aPortID*256UL,
                    &val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    aRxStat->pktsRxDiscard = val32;

    ret = ETHSWT_DrvReadReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_rxpausepkts + aPortID*256UL,
                    &val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    aRxStat->rxPause = val32;
err_exit:
    ETHSWT_REPORT_ERR(ret, aSwtID, line,
        BRCM_SWDSGN_ETHSWT_DRV_GET_RX_STAT_PROC, 0UL, 0UL, 0UL)
    return ret;
}

/** @brief Get Tx statistics

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aSwtID      Switch Index
    @param[in]      aPortID     Port ID
    @param[inout]   aTxStat     Pointer to receiver statistics

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @retval     #BCM_ERR_INVAL_PARAMS   (Switch Index is invalid) or
                                        (Port ID in invalid) or
                                        (aTxStat is NULL)

    @post None

    @trace #BRCM_SWARCH_ETHSWT_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_QUERY
*/
static int32_t ETHSWT_DrvGetTxStat(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID,
        ETHER_TxStatsType *const aTxStat)
{
    uint32_t line;
    uint64_t val64;
    uint32_t val32;
    int32_t ret = BCM_ERR_OK;

    if ((aSwtID >= SWITCH_MAX_HW_ID) || (aPortID >= ETHSWT_PORT_ID_MAX) ||
            (NULL == aTxStat)) {
        ret = BCM_ERR_INVAL_PARAMS;
        line = __LINE__;
        goto err_exit;
    }

    /* first set all the counters to invalid */
    BCM_MemSet(aTxStat, 0xFF, sizeof(ETHER_TxStatsType));
    /* read the counters and update */

    ret = ETHSWT_DrvReadReg(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_txoctets + aPortID*256UL,
                    &val64);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    aTxStat->octets = (uint32_t)val64;
    ret = ETHSWT_DrvReadReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_txbroadcastpkts + aPortID*256UL,
                    &val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    aTxStat->brdCast = val32;
    ret = ETHSWT_DrvReadReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_txmulticastpkts + aPortID*256UL,
                    &val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    aTxStat->mutCast = val32;
    ret = ETHSWT_DrvReadReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_txunicastpkts + aPortID*256UL,
                    &val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    aTxStat->uniCast = val32;
    ret = ETHSWT_DrvReadReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_txdroppkts + aPortID*256UL,
                    &val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    aTxStat->txDropped = val32;
    ret = ETHSWT_DrvReadReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_txcollisions + aPortID*256UL,
                    &val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    aTxStat->txCollision = val32;
    ret = ETHSWT_DrvReadReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_txsinglecollision + aPortID*256UL,
                    &val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    aTxStat->txCollisionSingle = val32;
    ret = ETHSWT_DrvReadReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_txmultiplecollision + aPortID*256UL,
                    &val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    aTxStat->txCollisionMulti = val32;
    ret = ETHSWT_DrvReadReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_txmultiplecollision + aPortID*256UL,
                    &val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    aTxStat->txCollisionMulti = val32;
    ret = ETHSWT_DrvReadReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_txlatecollision + aPortID*256UL,
                    &val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    aTxStat->txLateCollision = val32;
    ret = ETHSWT_DrvReadReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_txexcessivecollision + aPortID*256UL,
                    &val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    aTxStat->txExcessiveCollision = val32;
    ret = ETHSWT_DrvReadReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_txdeferredtransmit + aPortID*256UL,
                    &val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    aTxStat->txDeferredTransmit = val32;

    ret = ETHSWT_DrvReadReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_txframeindisc + aPortID*256UL,
                    &val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    aTxStat->txFrameInDiscard = val32;

    ret = ETHSWT_DrvReadReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_txpausepkts + aPortID*256UL,
                    &val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    aTxStat->txPause = val32;

    ret = ETHSWT_DrvReadReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_txqpktq0 + aPortID*256UL,
                    &val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    aTxStat->txQ0 = val32;

    ret = ETHSWT_DrvReadReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_txqpktq1 + aPortID*256UL,
                    &val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    aTxStat->txQ1 = val32;

    ret = ETHSWT_DrvReadReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_txqpktq2 + aPortID*256UL,
                    &val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    aTxStat->txQ2 = val32;

    ret = ETHSWT_DrvReadReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_txqpktq3 + aPortID*256UL,
                    &val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    aTxStat->txQ3 = val32;

    ret = ETHSWT_DrvReadReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_txqpktq4 + aPortID*256UL,
                    &val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    aTxStat->txQ4 = val32;

    ret = ETHSWT_DrvReadReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_txqpktq5 + aPortID*256UL,
                    &val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    aTxStat->txQ5 = val32;

    ret = ETHSWT_DrvReadReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_txqpktq6 + aPortID*256UL,
                    &val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    aTxStat->txQ6 = val32;

    ret = ETHSWT_DrvReadReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_txqpktq7 + aPortID*256UL,
                    &val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    aTxStat->txQ7 = val32;

    ret = ETHSWT_DrvReadReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_txpkts64octets + aPortID*256UL,
                    &val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    aTxStat->pkts64 = val32;

    ret = ETHSWT_DrvReadReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_txpkts65to127octets + aPortID*256UL,
                    &val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    aTxStat->pkts65_127 = val32;

    ret = ETHSWT_DrvReadReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_txpkts128to255octets + aPortID*256UL,
                    &val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    aTxStat->pkts128_255 = val32;

    ret = ETHSWT_DrvReadReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_txpkts256to511octets + aPortID*256UL,
                    &val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    aTxStat->pkts256_511 = val32;

    ret = ETHSWT_DrvReadReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_txpkts512to1023octets + aPortID*256UL,
                    &val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    aTxStat->pkts512_1023 = val32;

    ret = ETHSWT_DrvReadReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_txpkts1024tomaxpktoctets + aPortID*256UL,
                    &val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    aTxStat->pkts1024_MAX = val32;
err_exit:
    ETHSWT_REPORT_ERR(ret, aSwtID, line,
        BRCM_SWDSGN_ETHSWT_DRV_GET_TX_STAT_PROC, 0UL, 0UL, 0UL)
    return ret;
}

/** @brief Clear Rx statistics

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  aSwtID      Switch Index
    @param[in]  aPortID     Port ID

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @retval     #BCM_ERR_INVAL_PARAMS   (Switch Index is invalid) or
                                        (Port ID in invalid)

    @post None

    @trace #BRCM_SWARCH_ETHSWT_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_DYNAMIC_CONFIGURATION
*/
static int32_t ETHSWT_DrvClearRxStat(ETHSWT_HwIDType aSwtID,
         ETHSWT_PortIDType aPortID)
{
    uint32_t line;
    uint64_t val64;
    uint32_t val32;
    int32_t ret = BCM_ERR_OK;

    if ((aSwtID >= SWITCH_MAX_HW_ID) || (aPortID >= ETHSWT_PORT_ID_MAX)) {
        ret = BCM_ERR_INVAL_PARAMS;
        line = __LINE__;
        goto err_exit;
    }


    val64 = 0ULL;
    val32 = 0UL;

    ret = ETHSWT_DrvWriteReg(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_rxgoodoctets + aPortID*256UL,
                    val64);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    ret = ETHSWT_DrvWriteReg(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_rxoctets + aPortID*256UL,
                    val64);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    ret = ETHSWT_DrvWriteReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_rxbroadcastpkts + aPortID*256UL,
                    val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    ret = ETHSWT_DrvWriteReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_rxmulticastpkts + aPortID*256UL,
                    val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    ret = ETHSWT_DrvWriteReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_rxunicastpkts + aPortID*256UL,
                    val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    ret = ETHSWT_DrvWriteReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_rxpkts64octets + aPortID*256UL,
                    val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    ret = ETHSWT_DrvWriteReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_rxpkts65to127octets + aPortID*256UL,
                    val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    ret = ETHSWT_DrvWriteReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_rxpkts128to255octets + aPortID*256UL,
                    val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    ret = ETHSWT_DrvWriteReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_rxpkts256to511octets + aPortID*256UL,
                    val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    ret = ETHSWT_DrvWriteReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_rxpkts512to1023octets + aPortID*256UL,
                    val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    ret = ETHSWT_DrvWriteReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_rxpkts1024tomaxpktoctets + aPortID*256UL,
                    val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    ret = ETHSWT_DrvWriteReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_rxjumbopkt + aPortID*256UL,
                    val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    ret = ETHSWT_DrvWriteReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_rxjabbers + aPortID*256UL,
                    val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    ret = ETHSWT_DrvWriteReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_rxoversizepkts + aPortID*256UL,
                    val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    ret = ETHSWT_DrvWriteReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_rxfragments + aPortID*256UL,
                    val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    ret = ETHSWT_DrvWriteReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_rxdroppkts + aPortID*256UL,
                    val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    ret = ETHSWT_DrvWriteReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_rxalignmenterrors + aPortID*256UL,
                    val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    ret = ETHSWT_DrvWriteReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_rxundersizepkts + aPortID*256UL,
                    val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    ret = ETHSWT_DrvWriteReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_rxfcserrors + aPortID*256UL,
                    val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    ret = ETHSWT_DrvWriteReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_rxdiscard + aPortID*256UL,
                    val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    ret = ETHSWT_DrvWriteReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_rxpausepkts + aPortID*256UL,
                    val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
err_exit:
    ETHSWT_REPORT_ERR(ret, aSwtID, line,
        BRCM_SWDSGN_ETHSWT_DRV_CLEAR_RX_STAT_PROC, 0UL, 0UL, 0UL)
    return ret;
}

/** @brief Clear Tx statistics

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  aSwtID      Switch Index
    @param[in]  aPortID     Port ID

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @rertval    #BCM_ERR_INVAL_PARAMS   (Switch Index is invalid) or
                                        (Port ID in invalid)

    @post None

    @trace #BRCM_SWARCH_ETHSWT_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_DYNAMIC_CONFIGURATION
*/
static int32_t ETHSWT_DrvClearTxStat(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID)
{
    uint32_t line;
    uint64_t val64;
    uint32_t val32;
    int32_t ret = BCM_ERR_OK;

    if ((aSwtID >= SWITCH_MAX_HW_ID) || (aPortID >= ETHSWT_PORT_ID_MAX)) {
        ret = BCM_ERR_INVAL_PARAMS;
        line = __LINE__;
        goto err_exit;
    }

    /* clear the counter */
    val64 = 0ULL;
    val32 = 0UL;

    ret = ETHSWT_DrvWriteReg(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_txoctets + aPortID*256UL,
                    val64);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    ret = ETHSWT_DrvWriteReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_txbroadcastpkts + aPortID*256UL,
                    val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    ret = ETHSWT_DrvWriteReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_txmulticastpkts + aPortID*256UL,
                    val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    ret = ETHSWT_DrvWriteReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_txunicastpkts + aPortID*256UL,
                    val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    ret = ETHSWT_DrvWriteReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_txdroppkts + aPortID*256UL,
                    val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    ret = ETHSWT_DrvWriteReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_txcollisions + aPortID*256UL,
                    val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    ret = ETHSWT_DrvWriteReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_txsinglecollision + aPortID*256UL,
                    val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    ret = ETHSWT_DrvWriteReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_txmultiplecollision + aPortID*256UL,
                    val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    ret = ETHSWT_DrvWriteReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_txmultiplecollision + aPortID*256UL,
                    val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    ret = ETHSWT_DrvWriteReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_txlatecollision + aPortID*256UL,
                    val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    ret = ETHSWT_DrvWriteReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_txexcessivecollision + aPortID*256UL,
                    val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    ret = ETHSWT_DrvWriteReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_txdeferredtransmit + aPortID*256UL,
                    val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    ret = ETHSWT_DrvWriteReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_txframeindisc + aPortID*256UL,
                    val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    ret = ETHSWT_DrvWriteReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_txpausepkts + aPortID*256UL,
                    val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    ret = ETHSWT_DrvWriteReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_txqpktq0 + aPortID*256UL,
                    val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    ret = ETHSWT_DrvWriteReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_txqpktq1 + aPortID*256UL,
                    val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    ret = ETHSWT_DrvWriteReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_txqpktq2 + aPortID*256UL,
                    val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    ret = ETHSWT_DrvWriteReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_txqpktq3 + aPortID*256UL,
                    val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    ret = ETHSWT_DrvWriteReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_txqpktq4 + aPortID*256UL,
                    val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    ret = ETHSWT_DrvWriteReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_txqpktq5 + aPortID*256UL,
                    val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    ret = ETHSWT_DrvWriteReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_txqpktq6 + aPortID*256UL,
                    val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    ret = ETHSWT_DrvWriteReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_txqpktq7 + aPortID*256UL,
                    val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    ret = ETHSWT_DrvWriteReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_txpkts64octets + aPortID*256UL,
                    val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    ret = ETHSWT_DrvWriteReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_txpkts65to127octets + aPortID*256UL,
                    val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    ret = ETHSWT_DrvWriteReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_txpkts128to255octets + aPortID*256UL,
                    val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    ret = ETHSWT_DrvWriteReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_txpkts256to511octets + aPortID*256UL,
                    val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    ret = ETHSWT_DrvWriteReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_txpkts512to1023octets + aPortID*256UL,
                    val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    ret = ETHSWT_DrvWriteReg32(aSwtID,
                    (uint32_t)&ETHSWT_Regs->m20_txpkts1024tomaxpktoctets + aPortID*256UL,
                    val32);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
err_exit:
    ETHSWT_REPORT_ERR(ret, aSwtID, line,
        BRCM_SWDSGN_ETHSWT_DRV_CLEAR_TX_PROC, 0UL, 0UL, 0UL)
    return ret;
}

/**
    @brief Switch Mirror command handler

    @trace  #BRCM_SWREQ_ETHSWT_KERNEL_HANDLER
    @trace #BRCM_SWARCH_ETHSWT_DBG_CMD_HANDLER_PROC
 */
int32_t ETHSWT_DbgCmdHandler(ETHSWT_HwIDType aSwtHwID,
                                ETHSWT_IOCmdType aCmd,
                                ETHSWT_DbgIOType *const aIO)
{
    int32_t ret;
    switch(aCmd) {
        case ETHSWT_IO_CMD_SET_PORT_MIRROR_CFG:
            ret = ETHSWT_DrvSetPortMirrorConfig(aSwtHwID, aIO->portHwID,
                    aIO->direction, aIO->portMirrorCfg);
        break;
        case ETHSWT_IO_CMD_GET_PORT_MIRROR_CFG:
            ret = ETHSWT_DrvGetPortMirrorConfig(aSwtHwID, aIO->portHwID,
                    aIO->direction, aIO->portMirrorCfg);
        break;
        case ETHSWT_IO_CMD_SET_PORT_MIRROR_MODE:
            ret = ETHSWT_DrvSetPortMirrorState(aSwtHwID, aIO->portHwID,
                    *aIO->portMirrorState);
        break;
        case ETHSWT_IO_CMD_GET_PORT_MIRROR_MODE:
            ret = ETHSWT_DrvGetPortMirrorState(aSwtHwID, aIO->portHwID,
                    aIO->portMirrorState);
        break;
        case ETHSWT_IO_CMD_GET_MIRROR_CAPTURE_PORT:
            ret = ETHSWT_DrvGetMirrorCapturePort(aSwtHwID, &(aIO->portHwID));
        break;
        case ETHSWT_IO_CMD_SET_LED_STATE:
            ret = ETHSWT_DrvSetLedState(aSwtHwID, aIO->portHwID, aIO->ledType,
                                        aIO->enable);
        break;
        case ETHSWT_IO_CMD_GET_LED_STATE:
            ret = ETHSWT_DrvGetLedState(aSwtHwID, aIO->portHwID, aIO->ledType,
                                        &(aIO->enable));
        break;
        case ETHSWT_IO_CMD_GET_RX_STAT:
            ret = ETHSWT_DrvGetRxStat(aSwtHwID, aIO->portHwID, aIO->rxStat);
        break;
        case ETHSWT_IO_CMD_GET_TX_STAT:
            ret = ETHSWT_DrvGetTxStat(aSwtHwID, aIO->portHwID, aIO->txStat);
        break;
        case ETHSWT_IO_CMD_CLEAR_RX_STAT:
            ret = ETHSWT_DrvClearRxStat(aSwtHwID, aIO->portHwID);
        break;
        case ETHSWT_IO_CMD_CLEAR_TX_STAT:
            ret = ETHSWT_DrvClearTxStat(aSwtHwID, aIO->portHwID);
        break;
        default:
            ret = BCM_ERR_NOSUPPORT;
        break;
    }
    return ret;
}

/**
    @brief Set port mirror configuration

    @trace #BRCM_SWARCH_ETHSWT_SET_PORT_MIRROR_CFG_PROC
    @trace #BRCM_SWREQ_ETHSWT_DYNAMIC_CONFIGURATION
*/
int32_t ETHSWT_SetPortMirrorConfig(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID,
        ETHSWT_TrafficDirType aDirection,
        ETHSWT_PortMirrorCfgType *const aConfig)
{
    ETHSWT_IOType swtIO;
    ETHSWT_DbgIOType dbgIO;
    int32_t ret;

    if (aSwtID < SWITCH_MAX_HW_ID) {
        swtIO.dbgIO = &dbgIO;
        dbgIO.portHwID = aPortID;
        dbgIO.direction = aDirection;
        dbgIO.portMirrorCfg = aConfig;
        swtIO.retVal = BCM_ERR_UNKNOWN;
        swtIO.swtHwID = aSwtID;
        ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_SET_PORT_MIRROR_CFG, &swtIO);
        if (BCM_ERR_OK != ret) {
            ETHSWT_DrvReportError((BCM_SWT_ID & BCM_LOGMASK_USER), (uint8_t)aSwtID,
                    BRCM_SWDSGN_ETHSWT_SET_PORT_MIRROR_CONFIG_PROC, ret, 0UL, 0UL,
                    0UL, __LINE__);
        }
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }
    return ret;
}

/**
    @brief Get port mirror configuration

    @trace #BRCM_SWARCH_ETHSWT_GET_PORT_MIRROR_CFG_PROC
    @trace #BRCM_SWREQ_ETHSWT_QUERY
*/
int32_t ETHSWT_GetPortMirrorConfig(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID,
        ETHSWT_TrafficDirType aDirection,
        ETHSWT_PortMirrorCfgType *const aConfig)
{
    ETHSWT_IOType swtIO;
    ETHSWT_DbgIOType dbgIO;
    int32_t ret;

    if (aSwtID < SWITCH_MAX_HW_ID) {
        swtIO.dbgIO = &dbgIO;
        dbgIO.portHwID = aPortID;
        dbgIO.direction = aDirection;
        dbgIO.portMirrorCfg = aConfig;
        swtIO.retVal = BCM_ERR_UNKNOWN;
        swtIO.swtHwID = aSwtID;
        ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_GET_PORT_MIRROR_CFG, &swtIO);
        if (BCM_ERR_OK != ret) {
            ETHSWT_DrvReportError((BCM_SWT_ID & BCM_LOGMASK_USER), (uint8_t)aSwtID,
                    BRCM_SWDSGN_ETHSWT_GET_PORT_MIRROR_CONFIG_PROC, ret, 0UL, 0UL,
                    0UL, __LINE__);
        }
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }
    return ret;
}

/**
    @brief Set port mirror state

    @trace #BRCM_SWARCH_ETHSWT_SET_PORT_MIRROR_STATE_PROC
    @trace #BRCM_SWREQ_ETHSWT_DYNAMIC_CONFIGURATION
*/
int32_t ETHSWT_SetPortMirrorState(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID,
        ETHSWT_PortMirrorStateType aState)
{
    ETHSWT_IOType swtIO;
    ETHSWT_DbgIOType dbgIO;
    int32_t ret;

    if (aSwtID < SWITCH_MAX_HW_ID) {
        swtIO.dbgIO = &dbgIO;
        dbgIO.portHwID = aPortID;
        dbgIO.portMirrorState = &aState;
        swtIO.retVal = BCM_ERR_UNKNOWN;
        swtIO.swtHwID = aSwtID;
        ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_SET_PORT_MIRROR_MODE, &swtIO);
        if (BCM_ERR_OK != ret) {
            ETHSWT_DrvReportError((BCM_SWT_ID & BCM_LOGMASK_USER), (uint8_t)aSwtID,
                    BRCM_SWDSGN_ETHSWT_SET_PORT_MIRROR_STATE_PROC, ret, 0UL, 0UL,
                    0UL, __LINE__);
        }
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }
    return ret;
}

/**
    @brief Get port mirror state

    @trace #BRCM_SWARCH_ETHSWT_GET_PORT_MIRROR_STATE_PROC
    @trace #BRCM_SWREQ_ETHSWT_QUERY
*/
int32_t ETHSWT_GetPortMirrorState(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID,
        ETHSWT_PortMirrorStateType *const aState)
{
    ETHSWT_IOType swtIO;
    ETHSWT_DbgIOType dbgIO;
    int32_t ret;

    if (aSwtID < SWITCH_MAX_HW_ID) {
        swtIO.dbgIO = &dbgIO;
        dbgIO.portHwID = aPortID;
        dbgIO.portMirrorState = aState;
        swtIO.retVal = BCM_ERR_UNKNOWN;
        swtIO.swtHwID = aSwtID;
        ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_GET_PORT_MIRROR_MODE, &swtIO);
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }
    return ret;
}

/**
    @brief Get mirror capture port

    @trace #BRCM_SWARCH_ETHSWT_GET_MIRROR_CAPTURE_PORT_PROC
    @trace #BRCM_SWREQ_ETHSWT_QUERY
*/
int32_t ETHSWT_GetMirrorCapturePort(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType *const aPortID)
{
    ETHSWT_IOType swtIO;
    ETHSWT_DbgIOType dbgIO;
    int32_t ret;

    if (aSwtID < SWITCH_MAX_HW_ID) {
        swtIO.dbgIO = &dbgIO;
        swtIO.retVal = BCM_ERR_UNKNOWN;
        swtIO.swtHwID = aSwtID;
        ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_GET_MIRROR_CAPTURE_PORT, &swtIO);
        if (BCM_ERR_OK == ret) {
            *aPortID = dbgIO.portHwID;
        }
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }
    return ret;
}

/**
    @brief Set LED state

    @trace #BRCM_SWARCH_ETHSWT_SET_LED_STATE_PROC
    @trace #BRCM_SWREQ_ETHSWT_DYNAMIC_CONFIGURATION
*/
int32_t ETHSWT_SetLedState(ETHSWT_HwIDType aSwtID,
                                ETHSWT_PortIDType aPortID,
                                ETHSWT_LedType aLedType,
                                uint32_t aTurnOn)
{
    ETHSWT_IOType swtIO;
    ETHSWT_DbgIOType dbgIO;
    int32_t ret;

    if (aSwtID < SWITCH_MAX_HW_ID) {
        swtIO.dbgIO = &dbgIO;
        dbgIO.portHwID = aPortID;
        dbgIO.ledType = aLedType;
        dbgIO.enable = aTurnOn;
        swtIO.retVal = BCM_ERR_UNKNOWN;
        swtIO.swtHwID = aSwtID;
        ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_SET_LED_STATE, &swtIO);
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }
    return ret;
}

/**
    @brief Get LED state

    @trace #BRCM_SWARCH_ETHSWT_GET_LEDSTATE_PROC
    @trace #BRCM_SWREQ_ETHSWT_QUERY
*/
int32_t ETHSWT_GetLedState(ETHSWT_HwIDType aSwtID,
                                ETHSWT_PortIDType aPortID,
                                ETHSWT_LedType aLedType,
                                uint32_t *const aIsStateOn)
{
    ETHSWT_IOType swtIO;
    ETHSWT_DbgIOType dbgIO;
    int32_t ret;

    if ((aSwtID < SWITCH_MAX_HW_ID) && (NULL != aIsStateOn)) {
        swtIO.dbgIO = &dbgIO;
        dbgIO.portHwID = aPortID;
        dbgIO.ledType = aLedType;
        swtIO.retVal = BCM_ERR_UNKNOWN;
        swtIO.swtHwID = aSwtID;
        ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_GET_LED_STATE, &swtIO);
        if (BCM_ERR_OK == ret) {
            *aIsStateOn = dbgIO.enable;
        }
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }
    return ret;
}

/**
    @brief Get Rx statistics

    @trace #BRCM_SWARCH_ETHSWT_GET_RX_STAT_PROC
    @trace #BRCM_SWREQ_ETHSWT_QUERY
*/
int32_t ETHSWT_GetRxStat(ETHSWT_HwIDType aSwtID,
         ETHSWT_PortIDType aPortID,
         ETHER_RxStatsType *const aRxStat)
{
    ETHSWT_IOType swtIO;
    ETHSWT_DbgIOType dbgIO;
    int32_t ret;

    if ((aSwtID < SWITCH_MAX_HW_ID) && (aRxStat != NULL)) {
        swtIO.dbgIO = &dbgIO;
        dbgIO.rxStat = aRxStat;
        dbgIO.portHwID = aPortID;
        swtIO.retVal = BCM_ERR_UNKNOWN;
        swtIO.swtHwID = aSwtID;
        ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_GET_RX_STAT, &swtIO);
        if (BCM_ERR_OK != ret) {
            ETHSWT_DrvReportError((BCM_SWT_ID & BCM_LOGMASK_USER), (uint8_t)aSwtID,
                    BRCM_SWDSGN_ETHSWT_GET_RX_STAT_PROC, ret, 0UL, 0UL, 0UL,
                    __LINE__);
        }
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }
    return ret;
}

/**
    @brief Clear Rx statistics

    @trace #BRCM_SWARCH_ETHSWT_CLEAR_RX_STAT_PROC
    @trace #BRCM_SWREQ_ETHSWT_DYNAMIC_CONFIGURATION
*/
int32_t ETHSWT_ClearRxStat(ETHSWT_HwIDType aSwtID,
         ETHSWT_PortIDType aPortID)
{
    ETHSWT_IOType swtIO;
    ETHSWT_DbgIOType dbgIO;
    int32_t ret;

    if (aSwtID < SWITCH_MAX_HW_ID) {
        swtIO.dbgIO = &dbgIO;
        dbgIO.portHwID = aPortID;
        swtIO.retVal = BCM_ERR_UNKNOWN;
        swtIO.swtHwID = aSwtID;
        ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_CLEAR_RX_STAT, &swtIO);
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }
    return ret;
}

/**
    @brief Get Tx statistics

    @trace #BRCM_SWARCH_ETHSWT_GET_TX_STAT_PROC
    @trace #BRCM_SWREQ_ETHSWT_QUERY
*/
int32_t ETHSWT_GetTxStat(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID,
        ETHER_TxStatsType *const aTxStat)
{
    ETHSWT_IOType swtIO;
    ETHSWT_DbgIOType dbgIO;
    int32_t ret;

    if ((aSwtID < SWITCH_MAX_HW_ID) && (aTxStat != NULL)) {
        swtIO.dbgIO = &dbgIO;
        dbgIO.portHwID = aPortID;
        dbgIO.txStat = aTxStat;
        swtIO.retVal = BCM_ERR_UNKNOWN;
        swtIO.swtHwID = aSwtID;
        ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_GET_TX_STAT, &swtIO);
        if (BCM_ERR_OK != ret) {
            ETHSWT_DrvReportError((BCM_SWT_ID & BCM_LOGMASK_USER), (uint8_t)aSwtID,
                    BRCM_SWDSGN_ETHSWT_GET_TX_STAT_PROC, ret, 0UL, 0UL, 0UL,
                    __LINE__);
        }
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }

    return ret;
}

/**
    @brief Clear Tx statistics

    @trace #BRCM_SWARCH_ETHSWT_CLEAR_TX_STAT_PROC
    @trace #BRCM_SWREQ_ETHSWT_DYNAMIC_CONFIGURATION
*/
int32_t ETHSWT_ClearTxStat(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID)
{
    ETHSWT_IOType swtIO;
    ETHSWT_DbgIOType dbgIO;
    int32_t ret;

    if (aSwtID < SWITCH_MAX_HW_ID) {
        swtIO.dbgIO = &dbgIO;
        dbgIO.portHwID = aPortID;
        swtIO.retVal = BCM_ERR_UNKNOWN;
        swtIO.swtHwID = aSwtID;
        ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_CLEAR_TX_STAT, &swtIO);
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }

    return ret;
}


/** @} */
