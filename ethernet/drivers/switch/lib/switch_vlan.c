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

    @file switch_vlan.c

    @brief Ethernet switch VLAN functionality

    @version 0.1 Initial version
*/

#include <switch_rdb.h>
#include <bcm_utils.h>
#include <bcm_err.h>
#include <eth_switch.h>
#include <eth_switch_osil.h>
#include <ethswt_vlan_osil.h>
#include "switch_drv.h"

/**
    @name Ethernet switch Design ID's
    @{
    @brief Ethernet switch Design ID's
*/
#define BRCM_SWDSGN_ETHSWT_DRV_VLAN_TBL_RDWR_PROC                   (0xB601U)    /**< @brief #ETHSWT_DrvVLANTblRdWr              */
#define BRCM_SWDSGN_ETHSWT_DRV_UPDATE_VLAN_TBL_ENTRY_PROC           (0xB602U)    /**< @brief #ETHSWT_DrvUpdateVLANTblEntry       */
#define BRCM_SWDSGN_ETHSWT_DRV_GET_VLAN_INIT_PORT_PROC              (0xB603U)    /**< @brief #ETHSWT_DrvGetVLANInitPort          */
#define BRCM_SWDSGN_ETHSWT_DRV_ENABLE_VLAN_PROC                     (0xB604U)    /**< @brief #ETHSWT_DrvEnableVLAN               */
#define BRCM_SWDSGN_ETHSWT_DRV_VLAN_TBL_DUMP_PROC                   (0xB605U)    /**< @brief #ETHSWT_DrvVLANTblDump              */
#define BRCM_SWDSGN_ETHSWT_DRV_GET_VLAN_PORTS_PROC                  (0xB606U)    /**< @brief #ETHSWT_DrvGetVLANPorts             */
#define BRCM_SWDSGN_ETHSWT_DRV_ADD_VLAN_PORTS_PROC                  (0xB607U)    /**< @brief #ETHSWT_DrvAddVLANPorts             */
#define BRCM_SWDSGN_ETHSWT_DRV_REMOVE_VLAN_PORTS_PROC               (0xB608U)    /**< @brief #ETHSWT_DrvRemoveVLANPorts          */
#define BRCM_SWDSGN_ETHSWT_DRV_SET_PORT_DEFAULT_VLAN_PROC           (0xB609U)    /**< @brief #ETHSWT_DrvSetPortDefaultVlan       */
#define BRCM_SWDSGN_ETHSWT_DRV_GET_PORT_DEFAULT_VLAN_PROC           (0xB60AU)    /**< @brief #ETHSWT_DrvGetPortDefaultVlan       */
#define BRCM_SWDSGN_ETHSWT_DRV_SET_VLAN_INGRESS_FILTER_MODE_PROC    (0xB60BU)    /**< @brief #ETHSWT_DrvSetVLANIngressFilterMode */
#define BRCM_SWDSGN_ETHSWT_DRV_GET_VLAN_INGRESS_FILTER_MODE_PROC    (0xB60CU)    /**< @brief #ETHSWT_DrvGetVLANIngressFilterMode */
#define BRCM_SWDSGN_ETHSWT_VLAN_CMD_HANDLER_PROC                    (0xB60DU)    /**< @brief #ETHSWT_VLANCmdHandler              */
#define BRCM_SWDSGN_ETHSWT_GET_VLAN_PORTS_PROC                      (0xB60EU)    /**< @brief #ETHSWT_GetVLANPorts                */
#define BRCM_SWDSGN_ETHSWT_ADD_VLAN_PORTS_PROC                      (0xB60FU)    /**< @brief #ETHSWT_AddVLANPorts                */
#define BRCM_SWDSGN_ETHSWT_REMOVE_VLAN_PORTS_PROC                   (0xB610U)    /**< @brief #ETHSWT_RemoveVLANPorts             */
#define BRCM_SWDSGN_ETHSWT_SET_PORT_DEFAULT_VLAN_PROC               (0xB611U)    /**< @brief #ETHSWT_SetPortDefaultVlan          */
#define BRCM_SWDSGN_ETHSWT_GET_PORT_DEFAULT_VLAN_PROC               (0xB612U)    /**< @brief #ETHSWT_GetPortDefaultVlan          */
#define BRCM_SWDSGN_ETHSWT_SET_VLAN_INGRESS_FILTER_MODE_PROC        (0xB613U)    /**< @brief #ETHSWT_SetVLANIngressFilterMode    */
#define BRCM_SWDSGN_ETHSWT_GET_VLAN_INGRESS_FILTER_MODE_PROC        (0xB614U)    /**< @brief #ETHSWT_GetVLANIngressFilterMode    */
#define BRCM_SWDSGN_ETHSWT_ENABLE_VLAN_PROC                         (0xB615U)    /**< @brief #ETHSWT_EnableVLAN                  */
#define BRCM_SWDSGN_ETHSWT_VLAN_STATIC_ENTRY_TYPE                   (0xB616U)    /**< @brief #ETHSWT_VLANStaticEntryType         */
#define BRCM_SWDSGN_ETHSWT_VLAN_STATIC_ENTRIES_GLOBAL               (0xB617U)    /**< @brief #ETHSWT_VLANStaticEntries           */
#define BRCM_SWDSGN_ETHSWT_DRV_SET_VLAN_HOPPING_DETECTION_PROC      (0xB618U)    /**< @brief #ETHSWT_DrvSetVlanHoppingDetection  */
#define BRCM_SWDSGN_ETHSWT_DRV_GET_VLAN_HOPPING_DETECTION_PROC      (0xB619U)    /**< @brief #ETHSWT_DrvGetVlanHoppingDetection  */
#define BRCM_SWDSGN_ETHSWT_SET_VLAN_HOPPING_DETECTION_PROC          (0xB61AU)    /**< @brief #ETHSWT_SetVlanHoppingDetection     */
#define BRCM_SWDSGN_ETHSWT_GET_VLAN_HOPPING_DETECTION_PROC          (0xB61BU)    /**< @brief #ETHSWT_GetVlanHoppingDetection     */
/** @} */

/**
    @trace #BRCM_SWARCH_ETHSWT_DRV_UPDATE_VLAN_TBL_ENTRY_PROC
    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION
*/
typedef struct sETHSWT_VLANStaticEntryType {
    ETHER_VLANIDType   vlanID;
    uint16_t            portMask;
} ETHSWT_VLANStaticEntryType;

/**
    @trace #BRCM_SWARCH_ETHSWT_DRV_UPDATE_VLAN_TBL_ENTRY_PROC
    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION
*/
static ETHSWT_VLANStaticEntryType ETHSWT_VLANStaticEntries[ETHSWT_VLAN_MAX_STATIC_ENTRIES] COMP_SECTION(".bss.drivers");


/**
    @brief VLAN table Read/Write

    @trace #BRCM_SWARCH_ETHSWT_VLAN_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_KERNEL_INTERFACE
 */
int32_t ETHSWT_DrvVLANTblRdWr(ETHSWT_HwIDType aSwtID, uint16_t aVLAN,
                              uint32_t *const aUntagMap, uint32_t *const aFwdMap,
                              ETHSWT_VLANTblCmdType aCmd)
{
    uint32_t line;
    uint16_t reg16;
    uint32_t reg32;
    uint8_t cntrl = 0U;
    uint32_t timeout = 0UL;
    int ret = BCM_ERR_OK;

    /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_EN_VLAN, ETHSWT_IT_CASE_FROCE_CMD_REQ_ERR, aCmd = 0xFF) */
    if (((aUntagMap == NULL) || (aFwdMap == NULL)) ||
            ((aCmd != ETHSWT_VLAN_TBL_CMD_READ) && (aCmd != ETHSWT_VLAN_TBL_CMD_WRITE))) {
        ret = BCM_ERR_INVAL_PARAMS;
        line = __LINE__;
        goto err_exit;
    }

    /* write the VLAN_INDX register */
    reg16 = (aVLAN & ETHER_VLANID_MASK);
    ret = ETHSWT_DrvWriteReg16(aSwtID, (uint32_t)&ETHSWT_Regs->m05_arla_vtbl_addr, reg16);
    /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_EN_VLAN, ETHSWT_IT_CASE_FROCE_WR_ERR_1, ret = BCM_ERR_UNKNOWN) */
    /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_VLAN_PORT, ETHSWT_IT_CASE_FROCE_WR_ERR_1, ret = BCM_ERR_UNKNOWN) */
    ETHSWT_CHECK_ERR(ret, &line, err_exit)

    /* if its write operation, update the VTBL entry register first */
    if (aCmd == ETHSWT_VLAN_TBL_CMD_WRITE) {
        /* write the forward map and untag map
         * set the forward mode based on ARL flow
         * and MSTP index to 0
         */
        reg32 = ((*aFwdMap << SWITCH_P05AVE_PAGE_05_ARLA_VTBL_ENTRY_FWD_MAP_SHIFT)
                & SWITCH_P05AVE_PAGE_05_ARLA_VTBL_ENTRY_FWD_MAP_MASK);
        reg32 |= ((*aUntagMap << SWITCH_P05AVE_PAGE_05_ARLA_VTBL_ENTRY_UNTAG_MAP_SHIFT)
                & SWITCH_P05AVE_PAGE_05_ARLA_VTBL_ENTRY_UNTAG_MAP_MASK);
        ret = ETHSWT_DrvWriteReg32(aSwtID, (uint32_t)&ETHSWT_Regs->m05_arla_vtbl_entry, reg32);
        /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_VLAN_PORT, ETHSWT_IT_CASE_FROCE_WR_ERR_2, ret = BCM_ERR_UNKNOWN) */
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
        cntrl = (SWITCH_ARLA_VTBL_WRITE_CMD
                << SWITCH_P05AVR_PAGE_05_ARLA_VTBL_RWCTRL_ARLA_VTBL_RW_CLR_SHIFT);
        cntrl |= (SWITCH_P05AVR_PAGE_05_ARLA_VTBL_RWCTRL_ARLA_VTBL_STDN_MASK);
    } else {
        cntrl |= (SWITCH_ARLA_VTBL_READ_CMD
                << SWITCH_P05AVR_PAGE_05_ARLA_VTBL_RWCTRL_ARLA_VTBL_RW_CLR_SHIFT);
        cntrl |= SWITCH_P05AVR_PAGE_05_ARLA_VTBL_RWCTRL_ARLA_VTBL_STDN_MASK;
    }

    /* start the table operation */
    ret = ETHSWT_DrvWriteReg8(aSwtID, (uint32_t)&ETHSWT_Regs->m05_arla_vtbl_rwctrl, cntrl);
    /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_EN_VLAN, ETHSWT_IT_CASE_FROCE_WR_ERR_3, ret = BCM_ERR_UNKNOWN) */
    ETHSWT_CHECK_ERR(ret, &line, err_exit)

    while (timeout < ETHSWT_RDWR_TIMEOUT) {
        ret = ETHSWT_DrvReadReg8(aSwtID, (uint32_t)&ETHSWT_Regs->m05_arla_vtbl_rwctrl, &cntrl);
        /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_EN_VLAN, ETHSWT_IT_CASE_FROCE_RD_ERR_1, ret = BCM_ERR_UNKNOWN) */
        ETHSWT_CHECK_ERR(ret, &line, err_exit)

        /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_EN_VLAN, ETHSWT_IT_CASE_FROCE_RD_REG_TMOUT_ERR, cntrl |= SWITCH_P05AVR_PAGE_05_ARLA_VTBL_RWCTRL_ARLA_VTBL_STDN_MASK) */
        if (0ULL ==
            (cntrl & SWITCH_P05AVR_PAGE_05_ARLA_VTBL_RWCTRL_ARLA_VTBL_STDN_MASK)) {
            break;
        }
        timeout++;
    }

    if (timeout == ETHSWT_RDWR_TIMEOUT) {
        ret = BCM_ERR_TIME_OUT;
        line = __LINE__;
        goto err_exit;
    }

    if (aCmd == ETHSWT_VLAN_TBL_CMD_READ) {
        ret = ETHSWT_DrvReadReg32(aSwtID, (uint32_t)&ETHSWT_Regs->m05_arla_vtbl_entry, &reg32);
        /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_EN_VLAN, ETHSWT_IT_CASE_FROCE_WR_ERR_2, ret = BCM_ERR_UNKNOWN) */
        ETHSWT_CHECK_ERR(ret, &line, err_exit)

        /* in hardware bits[7:0] = ports 0-7 and bit[8] = IMP port (port 8) */
        *aFwdMap = ((reg32 & SWITCH_P05AVE_PAGE_05_ARLA_VTBL_ENTRY_FWD_MAP_MASK)
                >> SWITCH_P05AVE_PAGE_05_ARLA_VTBL_ENTRY_FWD_MAP_SHIFT);
        *aUntagMap = ((reg32 & SWITCH_P05AVE_PAGE_05_ARLA_VTBL_ENTRY_UNTAG_MAP_MASK)
                >> SWITCH_P05AVE_PAGE_05_ARLA_VTBL_ENTRY_UNTAG_MAP_SHIFT);
    }

err_exit:
    ETHSWT_REPORT_ERR(ret, aSwtID, line,
        BRCM_SWDSGN_ETHSWT_DRV_VLAN_TBL_RDWR_PROC, 0UL, 0UL, 0UL)
    return ret;
}

/**
    @trace #BRCM_SWARCH_ETHSWT_DRV_UPDATE_VLAN_TBL_ENTRY_PROC
    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION
 */
int32_t ETHSWT_DrvUpdateVLANTblEntry(ETHSWT_HwIDType aSwtID,
                                        ETHSWT_PortIDType aPortID,
                                        ETHER_VLANIDType aVlanID,
                                        ETHSWT_VLANFwrdType aForward,
                                        uint32_t aIsDynamic)
{
    uint32_t line = __LINE__;
    uint32_t untagMap = 0UL;
    uint32_t fwdMap = 0UL;
    int32_t ret = BCM_ERR_OK;
    uint32_t i;

    if (aVlanID > ETHER_VLANID_MAX) {
        ret = BCM_ERR_INVAL_PARAMS;
        line = __LINE__;
        goto err_exit;
    }
    if (0UL == aIsDynamic) {
        for (i = 0UL; i < ETHSWT_VLAN_MAX_STATIC_ENTRIES; i++) {
            if (ETHSWT_VLANStaticEntries[i].vlanID == aVlanID) {
                ETHSWT_VLANStaticEntries[i].portMask |= (uint16_t)(1UL << aPortID);
                break;
            } else if (0UL == ETHSWT_VLANStaticEntries[i].vlanID) {
                ETHSWT_VLANStaticEntries[i].vlanID = aVlanID;
                ETHSWT_VLANStaticEntries[i].portMask |= (uint16_t)(1UL << aPortID);
                break;
            } else {
                /* Nothing to do */
            }
        }
    }
    /* read the current port map configured in the HW */
    ret = ETHSWT_DrvVLANTblRdWr(aSwtID, aVlanID, &untagMap, &fwdMap,
            ETHSWT_VLAN_TBL_CMD_READ);
    /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_VLAN_PORT, ETHSWT_IT_CASE_FROCE_TBl_RDWR_ERR, ret = BCM_ERR_UNKNOWN) */
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    switch (aForward) {
        case ETHSWT_VLAN_FRWRD_DONT_SEND:
            /* clear this port from forward mask */
            fwdMap &= ~ETHSWT_PORTID2HWMASK(aPortID);
            untagMap &= ~ETHSWT_PORTID2HWMASK(aPortID);
            break;
        case ETHSWT_VLAN_FRWRD_TAGGED:
            fwdMap |= ETHSWT_PORTID2HWMASK(aPortID);
            untagMap &= ~ETHSWT_PORTID2HWMASK(aPortID);
            break;
        case ETHSWT_VLAN_FRWRD_UNTAGGED:
            fwdMap |= ETHSWT_PORTID2HWMASK(aPortID);
            untagMap |= ETHSWT_PORTID2HWMASK(aPortID);
            break;
        default:
            ret = BCM_ERR_INVAL_PARAMS;
            break;
    }
    ETHSWT_CHECK_ERR(ret, &line, err_exit)

    /* write the configuration to VLAN table */
    ret = ETHSWT_DrvVLANTblRdWr(aSwtID, aVlanID, &untagMap, &fwdMap,
            ETHSWT_VLAN_TBL_CMD_WRITE);

err_exit:
    ETHSWT_REPORT_ERR(ret, aSwtID, line,
        BRCM_SWDSGN_ETHSWT_DRV_UPDATE_VLAN_TBL_ENTRY_PROC, aVlanID, 0UL, 0UL)
    return ret;
}

/**
    @brief Get VLAN init port

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aSwtID          Switch Index
    @param[in]      aVlanID         VLAN ID
    @param[inout]   aPortMask       Pointer to port mask

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @retval     #BCM_ERR_NOT_FOUND      vlanID is not found

    @post None

    @trace #BRCM_SWARCH_ETHSWT_VLAN_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_QUERY
 */
static int32_t ETHSWT_DrvGetVLANInitPort(ETHSWT_HwIDType aSwtID,
        uint16_t aVlanID, uint32_t *const aPortMask)
{
    uint32_t i;
    int32_t ret = BCM_ERR_NOT_FOUND;

    *aPortMask = 0UL;

    for (i = 0UL; i < ETHSWT_VLAN_MAX_STATIC_ENTRIES; i++) {
        if (ETHSWT_VLANStaticEntries[i].vlanID == aVlanID) {
            *aPortMask = ETHSWT_VLANStaticEntries[i].portMask;
            ret = BCM_ERR_OK;
            break;
        }
    }

    return ret;
}

/**
    @brief VLAN table dump

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aSwtID      Switch Index

    @return         None

    @post None

    @trace #BRCM_SWARCH_ETHSWT_VLAN_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION
 */
static void ETHSWT_DrvVLANTblDump(ETHSWT_HwIDType aSwtID)
{
#ifdef ENABLE_SWITCH_DRV_DEBUG
    int32_t ret;
    uint32_t i;
    uint32_t untagMap;
    uint32_t fwdMap;

    for (i = 0; i <= 10; i++) {
        ret = ETHSWT_DrvVLANTblRdWr(aSwtID, i, &untagMap, &fwdMap,
                ETHSWT_VLAN_TBL_CMD_READ);
        if (ret != BCM_ERR_OK) {
            break;
        }
        ETHSWT_DrvReportError(BCM_SWT_ID, uint8_t(aSwtID), BRCM_SWDSGN_ETHSWT_DRV_VLAN_TBL_DUMP_PROC,
            ret, i, untagMap, fwdMap, 0UL);
    }
#endif
}

/** @brief Enable VLAN

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  aSwtID      Switch Index
    @param[in]  aPortID     Port ID
    @param[in]  aVlanID     VLAN ID
    @param[in]  aEnable     Enable flag

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @retval     #BCM_ERR_INVAL_PARAMS   (Switch Index is invalid) or
                                        (Port ID is invalid)
    @retval     #BCM_ERR_UNKNOWN        Config is NULL
    @retval     #BCM_ERR_NOT_FOUND      If VLAN ID is not found

    @post None

    @trace #BRCM_SWARCH_ETHSWT_VLAN_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_DYNAMIC_CONFIGURATION
*/
static int32_t ETHSWT_DrvEnableVLAN(ETHSWT_HwIDType aSwtID,
                                    ETHSWT_PortIDType aPortID,
                                    ETHER_VLANIDType aVlanID,
                                    uint32_t aEnable)
{
    uint32_t line = __LINE__;
    uint32_t i;
    uint32_t untagMap = 0UL;
    uint32_t fwdMap = 0UL;
    int32_t ret = BCM_ERR_OK;
    uint32_t found = FALSE;

    /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_EN_VLAN, ETHSWT_IT_CASE_FROCE_HWID_ERR, aSwtID = SWITCH_MAX_HW_ID; aPortID = ETHSWT_PORT_ID_MAX) */
    /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_EN_VLAN, ETHSWT_IT_CASE_FROCE_INVAL_PORT_ID, aSwtID = SWITCH_MAX_HW_ID; aPortID = ETHSWT_PORT_ID_MAX - 1) */
    if ((aSwtID >= SWITCH_MAX_HW_ID) || (aPortID >= ETHSWT_PORT_ID_MAX)) {
        ret = BCM_ERR_INVAL_PARAMS;
        line = __LINE__;
        goto err_exit;
    }

    for (i = 0UL; i < ETHSWT_VLAN_MAX_STATIC_ENTRIES; i++) {
        if (ETHSWT_VLANStaticEntries[i].vlanID == aVlanID) {
            found = TRUE;
            break;
        }
    }

    if (FALSE == found) {
        ret = BCM_ERR_NOT_FOUND;
        line = __LINE__;
        goto err_exit;
    }

    /* read the current port map configured in the HW */
    ret = ETHSWT_DrvVLANTblRdWr(aSwtID, aVlanID, &untagMap, &fwdMap, ETHSWT_VLAN_TBL_CMD_READ);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)

    if (aEnable == FALSE) {
        /* clear the forward port map */
        fwdMap &= ~ETHSWT_PORTID2HWMASK(aPortID);
    } else {
        fwdMap |= ETHSWT_PORTID2HWMASK(aPortID);
    }

    /* write the configuration to VLAN table */
    ret = ETHSWT_DrvVLANTblRdWr(aSwtID, aVlanID, &untagMap, &fwdMap,
            ETHSWT_VLAN_TBL_CMD_WRITE);

    ETHSWT_DrvVLANTblDump(aSwtID);

err_exit:
    ETHSWT_REPORT_ERR(ret, aSwtID, line,
        BRCM_SWDSGN_ETHSWT_DRV_ENABLE_VLAN_PROC, aVlanID, aPortID, aEnable)
    return ret;
}

/** @brief Get VLAN ports

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aSwrID          Switch Index
    @param[in]      aVlanID         VLAN ID
    @param[inout]   aPortMask       Pointer to port mask
    @param[inout]   aTagMask        Pointer to tag mask
    @param[inout]   aStaticPortMask Pointer to static port mask

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @retval     #BCM_ERR_INVAL_PARAMS   (aSwtId is invalid) or
                                        (aVlanID is invalid) or
                                        (aPortMask is NULL) or
                                        (aTagMask is NULL) or
                                        (aStaticPortMask is NULL)

    @post None

    @trace #BRCM_SWARCH_ETHSWT_VLAN_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_QUERY
*/
static int32_t ETHSWT_DrvGetVLANPorts(ETHSWT_HwIDType aSwtID,
                                      ETHER_VLANIDType aVlanID,
                                      uint32_t *const aPortMask,
                                      uint32_t *const aTagMask,
                                      uint32_t *const aStaticPortMask)
{
    uint32_t line = 0UL;
    int ret = BCM_ERR_OK;
    uint32_t untagMap = 0UL;
    uint32_t fwdMap = 0UL;

    /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_VLAN_PORT, ETHSWT_IT_CASE_FROCE_SWTID_ERR, aSwtID = SWITCH_MAX_HW_ID) */
    if ((aSwtID < SWITCH_MAX_HW_ID) && ((aVlanID & (~ETHER_VLANID_MASK)) == 0U)) {
        /* Search through the VLAN table and find which all ports
         * are participating this particular VLAN */

        /* read the current port map configured in the HW */
        ret = ETHSWT_DrvVLANTblRdWr(aSwtID, aVlanID, &untagMap, &fwdMap, ETHSWT_VLAN_TBL_CMD_READ);
        /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_VLAN_PORT, ETHSWT_IT_CASE_FROCE_WR_ERR_1, ret = BCM_ERR_UNKNOWN) */
        ETHSWT_CHECK_ERR(ret, &line, err_exit)

        *aPortMask = fwdMap;
        *aTagMask = (~untagMap) & fwdMap;
        *aStaticPortMask = 0UL;
        /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_VLAN_PORT, ETHSWT_IT_CASE_FROCE_FWDMAP_0, fwdMap = 0UL) */
        if (fwdMap != 0UL) {
            /* Search static ports for this VLAN */
            ret = ETHSWT_DrvGetVLANInitPort(aSwtID, aVlanID, aStaticPortMask);
            if (BCM_ERR_NOT_FOUND == ret) {
                *aStaticPortMask = 0UL;
                ret = BCM_ERR_OK;
            }
        }
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }

err_exit:
    ETHSWT_REPORT_ERR(ret, aSwtID, line,
        BRCM_SWDSGN_ETHSWT_DRV_GET_VLAN_PORTS_PROC, aVlanID, 0UL, 0UL)
    return ret;

}

/** @brief Add VLAN ports

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  aSwtID      Switch Index
    @param[in]  aPortMask   Port mask
    @param[in]  aVlanID     VLAN ID
    @param[in]  aTaggedMask Tagged mask

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @retval     #BCM_ERR_INVAL_PARAMS   (aSwtID is invalid) or
                                        (aPortMask is 0) or
                                        (aVlanID is invalid) or
    @return     Others                  As returned by #ETHSWT_DrvUpdateVLANTblEntry

    @post None

    @trace #BRCM_SWARCH_ETHSWT_VLAN_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_DYNAMIC_CONFIGURATION
*/
static int32_t ETHSWT_DrvAddVLANPorts(ETHSWT_HwIDType aSwtID,
                                      uint32_t aPortMask,
                                      ETHER_VLANIDType aVlanID,
                                      uint32_t aTaggedMask)
{
    int ret = BCM_ERR_OK;
    uint32_t i;
    uint32_t portMask = (aPortMask & ((0x1UL << ETHSWT_PORT_ID_MAX) - 1UL));
    ETHSWT_VLANFwrdType forward;

    /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_VLAN_PORT, ETHSWT_IT_CASE_FROCE_SWTID_ERR, aSwtID = SWITCH_MAX_HW_ID) */
    if ((aSwtID < SWITCH_MAX_HW_ID)
            && (portMask != 0UL)
            && ((aVlanID & (~ETHER_VLANID_MASK)) == 0U)
            && (aVlanID <= ETHER_VLANID_MAX)) {
        for (i = 0UL; i < ETHSWT_PORT_ID_MAX; i++) {
            if ((portMask & (0x1UL << i)) != 0UL) {
                if ((aTaggedMask & (0x1UL << i)) != 0UL) {
                    forward =  ETHSWT_VLAN_FRWRD_TAGGED;
                } else {
                    forward =  ETHSWT_VLAN_FRWRD_UNTAGGED;
                }

                /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_VLAN_PORT, ETHSWT_IT_CASE_FROCE_VLANID_ERR, aVlanID = ETHER_VLANID_MAX + 1) */
                ret = ETHSWT_DrvUpdateVLANTblEntry(aSwtID, i, aVlanID, forward, 1UL);
                if (BCM_ERR_OK != ret) {
                    break;
                }
            }
        }
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }

    return ret;
}

/** @brief Remove VLAN ports

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  aSwtID      Switch Index
    @param[in]  aPortMask   Port mask
    @param[in]  aVlanID     VLAN ID

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @retval     #BCM_ERR_INVAL_PARAMS   (aSwtID is invalid) or
                                        (aPortMask is invalid) or
                                        (aVlanID is invalid) or
                                        (Port mask is not part of given VLAN)
    @rertval    #BCM_ERR_NOPERM         Static port in static VLAN
    @return     Others                  As returned by #ETHSWT_DrvVLANTblRdWr or
                                        by #ETHSWT_DrvVLANTblRdWr

    @post None

    @trace #BRCM_SWARCH_ETHSWT_VLAN_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_DYNAMIC_CONFIGURATION
*/
static int32_t ETHSWT_DrvRemoveVLANPorts(ETHSWT_HwIDType aSwtID,
                                         uint32_t aPortMask,
                                         ETHER_VLANIDType aVlanID)
{
    uint32_t line = __LINE__;
    int ret = BCM_ERR_OK;
    uint32_t portMask = (aPortMask & ((0x1UL << ETHSWT_PORT_ID_MAX) - 1UL));
    uint32_t initPortMask = 0x0UL;
    uint32_t untagMap = 0UL;
    uint32_t fwdMap = 0UL;

    /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_VLAN_PORT, ETHSWT_IT_CASE_FROCE_SWTID_ERR, aSwtID = SWITCH_MAX_HW_ID) */
    if ((aSwtID < SWITCH_MAX_HW_ID)
            && (portMask != 0UL)
            && ((aVlanID & (~ETHER_VLANID_MASK)) == 0U)
            && (aVlanID <= ETHER_VLANID_MAX)) {
        /* Get VLAN ID's init config Port mask.
         */
        ret = ETHSWT_DrvGetVLANInitPort(aSwtID, aVlanID, &initPortMask);
        /* Static ports in a static VLAN are not allowed to be deleted */
        /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_VLAN_PORT, ETHSWT_IT_CASE_FROCE_PORT_MASK, initPortMask = 0x80) */
        if (((portMask & initPortMask) != 0UL) && (BCM_ERR_OK == ret)) {
            ret = BCM_ERR_NOPERM;
            line = __LINE__;
            goto err_exit;
        }
        /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_VLAN_PORT, ETHSWT_IT_CASE_FROCE_ERR_UNKNOWN_1, ret = BCM_ERR_UNKNOWN) */
        if ((BCM_ERR_NOT_FOUND == ret) || (BCM_ERR_OK == ret)) {
            /* read the current port map configured in the HW */
            ret = ETHSWT_DrvVLANTblRdWr(aSwtID, aVlanID, &untagMap, &fwdMap,
                ETHSWT_VLAN_TBL_CMD_READ);
            /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_VLAN_PORT, ETHSWT_IT_CASE_FROCE_ERR_UNKNOWN_2, ret = BCM_ERR_UNKNOWN) */
            ETHSWT_CHECK_ERR(ret, &line, err_exit)

            /* check the portMask is a part of given vlan or not */
            if (0UL != ((~fwdMap) & portMask)){
                ret = BCM_ERR_INVAL_PARAMS;
                line = __LINE__;
                goto err_exit;
            }
            untagMap &= (~portMask);
            fwdMap   &= (~portMask);
            /* Update the VLAN table entry with updated map */
            ret = ETHSWT_DrvVLANTblRdWr(aSwtID, aVlanID, &untagMap, &fwdMap,
                ETHSWT_VLAN_TBL_CMD_WRITE);
            /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_VLAN_PORT, ETHSWT_IT_CASE_FROCE_ERR_UNKNOWN_3, ret = BCM_ERR_UNKNOWN) */
            ETHSWT_CHECK_ERR(ret, &line, err_exit)
        }
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
        line = __LINE__;
    }

err_exit:
    ETHSWT_REPORT_ERR(ret, aSwtID, line,
        BRCM_SWDSGN_ETHSWT_DRV_REMOVE_VLAN_PORTS_PROC, aVlanID, 0UL, 0UL)
    return ret;
}

/** @brief Set port default VLAN

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  aSwtID      Switch Index
    @param[in]  aPortID      Port Index
    @param[in]  aVlanID     VLAN ID
    @param[in]  aPrio       Priority

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @retval     #BCM_ERR_INVAL_PARAMS   (aSwtID is invalid) or
                                        (aPortID is invalid) or
                                        (aVlanID is invalid) or
                                        (aPrio is invalid)

    @post None

    @trace #BRCM_SWARCH_ETHSWT_VLAN_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_DYNAMIC_CONFIGURATION
*/
static int32_t ETHSWT_DrvSetPortDefaultVlan(ETHSWT_HwIDType aSwtID,
                                            ETHSWT_PortIDType aPortID,
                                            ETHER_VLANIDType aVlanID,
                                            ETHER_PrioType aPrio)
{
    uint32_t line = __LINE__;
    int ret = BCM_ERR_OK;
    uint16_t reg;
    uint32_t portRegAddr;

    /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_PORT_DFLT, ETHSWT_IT_CASE_FROCE_SWTID_ERR, aSwtID = SWITCH_MAX_HW_ID) */
    if ((aSwtID < SWITCH_MAX_HW_ID) && (aPortID < ETHSWT_PORT_ID_MAX)
            && ((aVlanID & (~ETHER_VLANID_MASK)) == 0U)
            && (aPrio <= ETHER_PRIO_MAX)) {

        portRegAddr = SWITCH_M34_DEFAULT_1Q_TAG_PORT0 + aPortID * 2UL;
        reg = (uint64_t)((aVlanID << SWITCH_DEFAULT_1Q_TAG_VID_0_SHIFT)
            & SWITCH_DEFAULT_1Q_TAG_VID_0_MASK);
        reg |= (uint64_t)((aPrio << SWITCH_DEFAULT_1Q_TAG_PRI_0_SHIFT)
            & SWITCH_DEFAULT_1Q_TAG_PRI_0_MASK);
        ret = ETHSWT_DrvWriteReg16(aSwtID, portRegAddr, reg);
        /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_PORT_DFLT, ETHSWT_IT_CASE_FROCE_WR_ERR_1, ret = BCM_ERR_UNKNOWN) */
        ETHSWT_CHECK_ERR(ret, &line, err_exit)

        /* Disable dropping of all untagged packet on this port */
        ret = ETHSWT_DrvReadReg16(aSwtID, (uint32_t)&ETHSWT_Regs->m34_vlan_ctrl3, &reg);
        /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_PORT_DFLT, ETHSWT_IT_CASE_FROCE_RD_ERR_1, ret = BCM_ERR_UNKNOWN) */
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
        reg &= (uint64_t)~ETHSWT_PORTID2HWMASK(aPortID);
        ret = ETHSWT_DrvWriteReg16(aSwtID, (uint32_t)&ETHSWT_Regs->m34_vlan_ctrl3, reg);
        /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_PORT_DFLT, ETHSWT_IT_CASE_FROCE_WR_ERR_2, ret = BCM_ERR_UNKNOWN) */
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
        line = __LINE__;
    }

err_exit:
    ETHSWT_REPORT_ERR(ret, aSwtID, line,
        BRCM_SWDSGN_ETHSWT_DRV_SET_PORT_DEFAULT_VLAN_PROC, 0UL, 0UL, 0UL)
    return ret;
}

/** @brief Get port default VLAN

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aSwtID      Switch Index
    @param[in]      aPortID     Port ID
    @param[inout]   aVlanID     Pointer to VLAN ID
    @param[inout]   aPrio       Pointer to priority

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @retval     #BCM_ERR_INVAL_PARAMS   (aSwtID is invalid) or
                                        (aPortID is invalid) or
                                        (aVlanID is NULL) or
                                        (aPrio is NULL)

    @post None

    @trace #BRCM_SWARCH_ETHSWT_VLAN_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_QUERY
*/
static int32_t ETHSWT_DrvGetPortDefaultVlan(ETHSWT_HwIDType aSwtID,
                                            ETHSWT_PortIDType aPortID,
                                            ETHER_VLANIDType *const aVlanID,
                                            ETHER_PrioType *const aPrio)
{
    uint32_t line;
    uint32_t reg;
    uint32_t portRegAddr;
    int ret = BCM_ERR_OK;

    /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_PORT_DFLT, ETHSWT_IT_CASE_FROCE_SWTID_ERR, aSwtID = SWITCH_MAX_HW_ID) */
    if ((aSwtID < SWITCH_MAX_HW_ID) && (aPortID < ETHSWT_PORT_ID_MAX)) {

        portRegAddr = SWITCH_M34_DEFAULT_1Q_TAG_PORT0 + aPortID * 2UL;
        ret = ETHSWT_DrvReadReg32(aSwtID, portRegAddr, &reg);
        /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_PORT_DFLT, ETHSWT_IT_CASE_FROCE_RD_ERR_2, ret = BCM_ERR_UNKNOWN) */
        ETHSWT_CHECK_ERR(ret, &line, err_exit)

        *aVlanID = (ETHER_VLANIDType)((reg & SWITCH_DEFAULT_1Q_TAG_VID_0_MASK)
                        >> SWITCH_DEFAULT_1Q_TAG_VID_0_SHIFT);
        *aPrio = (ETHER_PrioType)((reg & SWITCH_DEFAULT_1Q_TAG_PRI_0_MASK)
                        >> SWITCH_DEFAULT_1Q_TAG_PRI_0_SHIFT);

    } else {
        ret = BCM_ERR_INVAL_PARAMS;
        line = __LINE__;
    }

err_exit:
    ETHSWT_REPORT_ERR(ret, aSwtID, line,
        BRCM_SWDSGN_ETHSWT_DRV_GET_PORT_DEFAULT_VLAN_PROC, 0UL, 0UL, 0UL)
    return ret;
}

/** @brief Set VLAN ingress filter mode

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  aSwtID  Switch Index
    @param[in]  aMode   Mode

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @retval     #BCM_ERR_INVAL_PARAMS   (aSwtID is invalid) or
                                        (aMode is invalid)
    @post None

    @trace #BRCM_SWARCH_ETHSWT_VLAN_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_DYNAMIC_CONFIGURATION
*/
static int32_t ETHSWT_DrvSetVLANIngressFilterMode(ETHSWT_HwIDType aSwtID,
                                                  ETHSWT_VLANIngressFilterModeType aMode)
{
    uint32_t line;
    uint8_t reg;
    int ret = BCM_ERR_OK;

    /* Untagged packets would not be dropped */

    /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_INGRS_FLTR, ETHSWT_IT_CASE_FROCE_HWID_ERR, aSwtID = SWITCH_MAX_HW_ID) */
    if ((aSwtID < SWITCH_MAX_HW_ID)
            && ((ETHSWT_VLAN_INGRESS_FILTER_MODE_DISABLED == aMode)
                || (ETHSWT_VLAN_INGRESS_FILTER_MODE_ENABLED == aMode))) {
        ret = ETHSWT_DrvReadReg8(aSwtID, (uint32_t)&ETHSWT_Regs->m34_vlan_ctrl4, &reg);
        /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_INGRS_FLTR, ETHSWT_IT_CASE_FROCE_RD_ERR_1, ret = BCM_ERR_UNKNOWN) */
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
        reg &= ~(SWITCH_P34VC4_PAGE_34_VLAN_CTRL4_INGR_VID_CHK_MASK); /* Clear the bits */
        if (ETHSWT_VLAN_INGRESS_FILTER_MODE_ENABLED == aMode) {
            /* Enable filtering - drop frame if VID violation */
            reg |= (SWITCH_VLAN_CTRL4_INGR_VID_CHK_VID_VIO
                    << SWITCH_P34VC4_PAGE_34_VLAN_CTRL4_INGR_VID_CHK_SHIFT);
        }

        ret = ETHSWT_DrvWriteReg8(aSwtID, (uint32_t)&ETHSWT_Regs->m34_vlan_ctrl4, reg);
        /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_INGRS_FLTR, ETHSWT_IT_CASE_FROCE_WR_ERR_1, ret = BCM_ERR_UNKNOWN) */
        ETHSWT_CHECK_ERR(ret, &line, err_exit)

    } else {
        ret = BCM_ERR_INVAL_PARAMS;
        line = __LINE__;
    }

err_exit:
    ETHSWT_REPORT_ERR(ret, aSwtID, line,
        BRCM_SWDSGN_ETHSWT_DRV_SET_VLAN_INGRESS_FILTER_MODE_PROC, 0UL, 0UL, 0UL)
    return ret;
}

/** @brief Get VLAN ingress filter mode

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aSwtID  Switch Index
    @param[inout]   aMode   Pointer to mode

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @retval     #BCM_ERR_INVAL_PARAMS   (aSwtID is invalid) or
                                        (aMode is NULL)

    @post None

    @trace #BRCM_SWARCH_ETHSWT_VLAN_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_QUERY
*/
static int32_t ETHSWT_DrvGetVLANIngressFilterMode(ETHSWT_HwIDType aSwtID,
                                                  ETHSWT_VLANIngressFilterModeType *const aMode)
{
    uint32_t line = 0UL;
    uint8_t reg;
    int ret = BCM_ERR_OK;

    /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_INGRS_FLTR, ETHSWT_IT_CASE_FROCE_HWID_ERR, aSwtID = SWITCH_MAX_HW_ID) */
    if (aSwtID < SWITCH_MAX_HW_ID) {
        ret = ETHSWT_DrvReadReg8(aSwtID, (uint32_t)&ETHSWT_Regs->m34_vlan_ctrl4, &reg);
        /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_INGRS_FLTR, ETHSWT_IT_CASE_FROCE_RD_ERR_2, ret = BCM_ERR_UNKNOWN) */
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
        reg &= (SWITCH_P34VC4_PAGE_34_VLAN_CTRL4_INGR_VID_CHK_MASK);
        reg >>= SWITCH_P34VC4_PAGE_34_VLAN_CTRL4_INGR_VID_CHK_SHIFT;
        if (SWITCH_VLAN_CTRL4_INGR_VID_CHK_VID_VIO == reg) {
            *aMode = ETHSWT_VLAN_INGRESS_FILTER_MODE_ENABLED;
        } else {
            *aMode = ETHSWT_VLAN_INGRESS_FILTER_MODE_DISABLED;
        }
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }

err_exit:
    ETHSWT_REPORT_ERR(ret, aSwtID, line,
        BRCM_SWDSGN_ETHSWT_DRV_GET_VLAN_INGRESS_FILTER_MODE_PROC, 0UL, 0UL, 0UL)
    return ret;
}

#ifdef ENABLE_ETHSWT_SECURITY
/** @brief Set Vlan-Hopping detection(enable/disable)

    This function sets Vlan-Hopping detection. If Vlan-Hopping
    detection is enabled, then any packet arriving with two tags
    with TPID 0x8100 should be discarded or sent to the CPU.

    @behavior Sync, Non re-entrant

    @pre None

    @param[in]      aSwtID                   Switch index
    @param[in]      aVlanHoppingAction       Vlan-Hopping action.

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully set Vlan-Hopping
                                        detection
    @retval     #BCM_ERR_TIME_OUT       Timeout occurred while reading/writing
                                        switch register

    @post None

    @code{.c}

    Read the VLAN Hop Control Register(PAGE_37_VLANHOP_CTRL)
    if aVlanHoppingAction ETHSWT_SECURITY_ACTION_DISABLED
         clear the enable bit(PAGE_37_VLANHOP_CTRL_VLAN_HOP_DET_EN[0:0])
    else
         Set the enable bit(PAGE_37_VLANHOP_CTRL_VLAN_HOP_DET_EN[0:0])
        vlanAction = (aVlanHoppingAction == ETHSWT_SECURITY_ACTION_DROP_PKT) ?
                                SWITCH_PAGE_37_VLAN_HOP_ACT_DROP_PKT :
                                SWITCH_PAGE_37_VLAN_HOP_ACT_REDIRECT_TO_CPU;
         Write the vlanAction bit(PAGE_37_VLANHOP_CTRL_VLAN_HOP_ACT[1:1])

    Write the VLAN Hop Control Register(PAGE_37_VLANHOP_CTRL)
    err_exit:
        ETHSWT_REPORT_ERR(ret, aSwtID, line,
            BRCM_SWDSGN_ETHSWT_DRV_SET_VLAN_HOPPING_DETECTION_PROC, 0UL, 0UL, 0UL)
        return ret;
    @endcode
    @trace #BRCM_SWARCH_ETHSWT_VLAN_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION
 */
static int32_t ETHSWT_DrvSetVlanHoppingDetection(ETHSWT_HwIDType aSwtID,
                    ETHSWT_SecurityActionType aVlanHoppingAction)
{
    uint32_t line;
    uint8_t reg;
    int32_t ret = BCM_ERR_OK;
    uint8_t vlanAction;

    /* Read the VLAN Hop Control Register */
    ret = ETHSWT_DrvReadReg8(aSwtID, (uint32_t)&ETHSWT_Regs->m37_vlanhop_ctrl, &reg);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)

    if(ETHSWT_SECURITY_ACTION_DISABLED == aVlanHoppingAction) {
        reg &= (~SWITCH_P37VC_PAGE_37_VLANHOP_CTRL_VLAN_HOP_DET_EN_MASK);
    } else {
        reg &= (~SWITCH_P37VC_PAGE_37_VLANHOP_CTRL_VLAN_HOP_ACT_MASK);
        reg |= SWITCH_P37VC_PAGE_37_VLANHOP_CTRL_VLAN_HOP_DET_EN_MASK;
        vlanAction = (aVlanHoppingAction == ETHSWT_SECURITY_ACTION_DROP_PKT) ?
                                SWITCH_PAGE_37_VLAN_HOP_ACT_DROP_PKT :
                                SWITCH_PAGE_37_VLAN_HOP_ACT_REDIRECT_TO_CPU;
        reg |= (vlanAction << SWITCH_P37VC_PAGE_37_VLANHOP_CTRL_VLAN_HOP_ACT_SHIFT);
    }
    /* write the VLAN Hop Control Register */
    ret = ETHSWT_DrvWriteReg8(aSwtID, (uint32_t)&ETHSWT_Regs->m37_vlanhop_ctrl, reg);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
err_exit:
    ETHSWT_REPORT_ERR(ret, aSwtID, line,
        BRCM_SWDSGN_ETHSWT_DRV_SET_VLAN_HOPPING_DETECTION_PROC, 0UL, 0UL, 0UL)
    return ret;
}

/**
    @brief Get Vlan-Hopping detection(enable/disable) status

    This function retreives switch Vlan-Hopping detection
    (enable/disable) status.

    @behavior Sync, Non re-entrant

    @pre None

    @param[in]      aSwtID                   Switch index
    @param[out]     aVlanHoppingAction       Pointer to Vlan-Hopping
                                             action.

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully retrieved Vlan-Hopping status
    @retval     #BCM_ERR_TIME_OUT       Timeout occurred while reading/writing
                                        switch register

    @post None

    @code{.c}
    ret = ERR_OK

    Read the VLAN Hop Control Register(PAGE_37_VLANHOP_CTRL)
    isEnable = enable bit (PAGE_37_VLANHOP_CTRL_VLAN_HOP_DET_EN[0:0])
    if(TRUE == isEnable) {
        vlanAction = action bit
                         (PAGE_37_VLANHOP_CTRL_VLAN_HOP_ACT[1:1])
        if(SWITCH_PAGE_37_VLAN_HOP_ACT_DROP_PKT == vlanAction) {
            action = ETHSWT_SECURITY_ACTION_DROP_PKT;
        } else {
            action = ETHSWT_SECURITY_ACTION_REDIRECT_TO_CPU;
        }
    } else {
        action = ETHSWT_SECURITY_ACTION_DISABLED;
    }
    *aVlanHoppingAction = action

    err_exit:
        ETHSWT_REPORT_ERR(ret, aSwtID, line,
            BRCM_SWDSGN_ETHSWT_DRV_GET_VLAN_HOPPING_DETECTION_PROC, 0UL, 0UL, 0UL)
        return ret;
    @endcode
    @trace #BRCM_SWARCH_ETHSWT_VLAN_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_QUERY
 */
static int32_t ETHSWT_DrvGetVlanHoppingDetection(ETHSWT_HwIDType aSwtID,
                   ETHSWT_SecurityActionType * const aVlanHoppingAction)
{
    uint32_t line;
    uint8_t reg;
    int32_t ret = BCM_ERR_OK;
    uint32_t isEnable;
    uint8_t vlanAction;
    ETHSWT_SecurityActionType action;

    /* Read the VLAN Hop Control Register */
    ret = ETHSWT_DrvReadReg8(aSwtID, (uint32_t)&ETHSWT_Regs->m37_vlanhop_ctrl, &reg);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    isEnable = (uint32_t)((reg & SWITCH_P37VC_PAGE_37_VLANHOP_CTRL_VLAN_HOP_DET_EN_MASK)
                                           >> SWITCH_P37VC_PAGE_37_VLANHOP_CTRL_VLAN_HOP_DET_EN_SHIFT);
    if(TRUE == isEnable) {
        vlanAction = ((reg & SWITCH_P37VC_PAGE_37_VLANHOP_CTRL_VLAN_HOP_ACT_MASK)
                                           >> SWITCH_P37VC_PAGE_37_VLANHOP_CTRL_VLAN_HOP_ACT_SHIFT);
        if(SWITCH_PAGE_37_VLAN_HOP_ACT_DROP_PKT == vlanAction) {
            action = ETHSWT_SECURITY_ACTION_DROP_PKT;
        } else {
            action = ETHSWT_SECURITY_ACTION_REDIRECT_TO_CPU;
        }
    } else {
        action = ETHSWT_SECURITY_ACTION_DISABLED;
    }
    *aVlanHoppingAction = action;
err_exit:
    ETHSWT_REPORT_ERR(ret, aSwtID, line,
        BRCM_SWDSGN_ETHSWT_DRV_GET_VLAN_HOPPING_DETECTION_PROC, 0UL, 0UL, 0UL)
    return ret;
}
#endif /* ENABLE_ETHSWT_SECURITY */
/**
    @brief Switch VLAN command handler

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aCmd            Command Index
    @param[inout]   aIO             Pointer to VLAN command I/O
                                    parameter

    Return values are documented in reverse-chronological order
    @retval   #BCM_ERR_NOSUPPORT      Invalid Command Index
    @retval   #BCM_ERR_TIME_OUT       Timeout occurred while reading/writing
                                      switch register
    @retval   #BCM_ERR_OK             On Success

    @post None
    @code{.c}
    ret = ERR_OK
    switch(aCmd) {
        case ETHSWT_IO_CMD_ENABLE_VLAN:
            ret = ETHSWT_DrvEnableVLAN(aSwtHwID, aIO->portHwID,
                    aIO->vlanID, aIO->enable);
            break;
        case ETHSWT_IO_CMD_GET_VLAN_PORTS:
            ret = ETHSWT_DrvGetVLANPorts(aSwtHwID, aIO->vlanID,
                    &(aIO->portMask), &(aIO->tagMask), &(aIO->staticPortMask));
            break;
        case ETHSWT_IO_CMD_ADD_VLAN_PORT:
            ret = ETHSWT_DrvAddVLANPorts(aSwtHwID, aIO->portMask,
                    aIO->vlanID, aIO->tagMask);
            break;
        case ETHSWT_IO_CMD_REMOVE_VLAN_PORT:
            ret = ETHSWT_DrvRemoveVLANPorts(aSwtHwID, aIO->portMask,
                    aIO->vlanID);
            break;
        case ETHSWT_IO_CMD_SET_PORT_DEFAULT_VLAN:
            ret = ETHSWT_DrvSetPortDefaultVlan(aSwtHwID, aIO->portHwID,
                    aIO->vlanID, aIO->prio);
            break;
        case ETHSWT_IO_CMD_GET_PORT_DEFAULT_VLAN:
            ret = ETHSWT_DrvGetPortDefaultVlan(aSwtHwID, aIO->portHwID,
                    &(aIO->vlanID), &(aIO->prio));
            break;
        case ETHSWT_IO_CMD_SET_VLAN_IFILTER_MODE:
            ret = ETHSWT_DrvSetVLANIngressFilterMode(aSwtHwID, aIO->mode);
            break;
        case ETHSWT_IO_CMD_GET_VLAN_IFILTER_MODE:
            ret = ETHSWT_DrvGetVLANIngressFilterMode(aSwtHwID, &(aIO->mode));
            break;
#ifdef ENABLE_ETHSWT_SECURITY
        case ETHSWT_IO_CMD_SET_VLAN_HOPPING_DETECT:
            ret = ETHSWT_DrvSetVlanHoppingDetection(aSwtHwID, aIO->securityAction);
            break;
        case ETHSWT_IO_CMD_GET_VLAN_HOPPING_DETECT:
            ret = ETHSWT_DrvGetVlanHoppingDetection(aSwtHwID, &(aIO->securityAction));
            break;
#endif
        default:
            ret = BCM_ERR_NOSUPPORT;
            break;
    }
    return ret
    @endcode

    @trace  #BRCM_SWREQ_ETHSWT_KERNEL_HANDLER
    @trace #BRCM_SWARCH_ETHSWT_VLAN_CMD_HANDLER_PROC
 */
int32_t ETHSWT_VLANCmdHandler(ETHSWT_HwIDType aSwtHwID,
                                ETHSWT_IOCmdType aCmd,
                                ETHSWT_VLANIOType *const aIO)
{
    int32_t ret;
    switch(aCmd) {
        case ETHSWT_IO_CMD_ENABLE_VLAN:
            ret = ETHSWT_DrvEnableVLAN(aSwtHwID, aIO->portHwID,
                    aIO->vlanID, aIO->enable);
            break;
        case ETHSWT_IO_CMD_GET_VLAN_PORTS:
            ret = ETHSWT_DrvGetVLANPorts(aSwtHwID, aIO->vlanID,
                    &(aIO->portMask), &(aIO->tagMask), &(aIO->staticPortMask));
            break;
        case ETHSWT_IO_CMD_ADD_VLAN_PORT:
            ret = ETHSWT_DrvAddVLANPorts(aSwtHwID, aIO->portMask,
                    aIO->vlanID, aIO->tagMask);
            break;
        case ETHSWT_IO_CMD_REMOVE_VLAN_PORT:
            ret = ETHSWT_DrvRemoveVLANPorts(aSwtHwID, aIO->portMask,
                    aIO->vlanID);
            break;
        case ETHSWT_IO_CMD_SET_PORT_DEFAULT_VLAN:
            ret = ETHSWT_DrvSetPortDefaultVlan(aSwtHwID, aIO->portHwID,
                    aIO->vlanID, aIO->prio);
            break;
        case ETHSWT_IO_CMD_GET_PORT_DEFAULT_VLAN:
            ret = ETHSWT_DrvGetPortDefaultVlan(aSwtHwID, aIO->portHwID,
                    &(aIO->vlanID), &(aIO->prio));
            break;
        case ETHSWT_IO_CMD_SET_VLAN_IFILTER_MODE:
            ret = ETHSWT_DrvSetVLANIngressFilterMode(aSwtHwID, aIO->mode);
            break;
        case ETHSWT_IO_CMD_GET_VLAN_IFILTER_MODE:
            ret = ETHSWT_DrvGetVLANIngressFilterMode(aSwtHwID, &(aIO->mode));
            break;
#ifdef ENABLE_ETHSWT_SECURITY
        case ETHSWT_IO_CMD_SET_VLAN_HOPPING_DETECT:
            ret = ETHSWT_DrvSetVlanHoppingDetection(aSwtHwID, aIO->securityAction);
            break;
        case ETHSWT_IO_CMD_GET_VLAN_HOPPING_DETECT:
            ret = ETHSWT_DrvGetVlanHoppingDetection(aSwtHwID, &(aIO->securityAction));
            break;
#endif /* ENABLE_ETHSWT_SECURITY */
        default:
            ret = BCM_ERR_NOSUPPORT;
            break;
    }
    return ret;
}

/**
    @brief Get VLAN ports

    @trace #BRCM_SWARCH_ETHSWT_GET_VLAN_PORTS_PROC
    @trace #BRCM_SWREQ_ETHSWT_QUERY
*/
int32_t ETHSWT_GetVLANPorts(ETHSWT_HwIDType aSwtID,
        ETHER_VLANIDType aVlanID,
        uint32_t *const aPortMask,
        uint32_t *const aTagMask,
        uint32_t *const aStaticPortMask)
{
    ETHSWT_IOType swtIO;
    ETHSWT_VLANIOType vlanIO;
    int32_t ret;

    if ((aSwtID < SWITCH_MAX_HW_ID) && (NULL != aPortMask)
        && (NULL != aTagMask) && (NULL != aStaticPortMask)) {
        swtIO.vlanIO = &vlanIO;
        vlanIO.vlanID = aVlanID;
        swtIO.retVal = BCM_ERR_UNKNOWN;
        swtIO.swtHwID = aSwtID;
        ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_GET_VLAN_PORTS, &swtIO);
        if (BCM_ERR_OK == ret) {
            *aPortMask = vlanIO.portMask;
            *aTagMask = vlanIO.tagMask;
            *aStaticPortMask = vlanIO.staticPortMask;
        }
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }
    return ret;
}

/**
    @brief Add VLAN ports

    @trace #BRCM_SWARCH_ETHSWT_ADD_VLAN_PORTS_PROC
    @trace #BRCM_SWREQ_ETHSWT_DYNAMIC_CONFIGURATION
*/
int32_t ETHSWT_AddVLANPorts(ETHSWT_HwIDType aSwtID,
        uint32_t aPortMask,
        ETHER_VLANIDType aVlanID,
        uint32_t aTaggedMask)
{
    ETHSWT_IOType swtIO;
    ETHSWT_VLANIOType vlanIO;
    int32_t ret;

    if (aSwtID < SWITCH_MAX_HW_ID) {
        swtIO.vlanIO = &vlanIO;
        vlanIO.portMask = aPortMask;
        vlanIO.vlanID = aVlanID;
        vlanIO.tagMask = aTaggedMask;
        swtIO.retVal = BCM_ERR_UNKNOWN;
        swtIO.swtHwID = aSwtID;
        ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_ADD_VLAN_PORT, &swtIO);
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }
    return ret;
}

/**
    @brief Remove VLAN ports

    @trace #BRCM_SWARCH_ETHSWT_REMOVE_VLAN_PORTS_PROC
    @trace #BRCM_SWREQ_ETHSWT_DYNAMIC_CONFIGURATION
*/
int32_t ETHSWT_RemoveVLANPorts(ETHSWT_HwIDType aSwtID,
        uint32_t aPortMask,
        ETHER_VLANIDType aVlanID)
{
    ETHSWT_IOType swtIO;
    ETHSWT_VLANIOType vlanIO;
    int32_t ret;

    if (aSwtID < SWITCH_MAX_HW_ID) {
        swtIO.vlanIO = &vlanIO;
        vlanIO.vlanID = aVlanID;
        vlanIO.portMask = aPortMask;
        swtIO.retVal = BCM_ERR_UNKNOWN;
        swtIO.swtHwID = aSwtID;
        ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_REMOVE_VLAN_PORT, &swtIO);
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }
    return ret;
}

/**
    @brief Set port default VLAN

    @trace #BRCM_SWARCH_ETHSWT_SET_PORT_DEFAULT_VLAN_PROC
    @trace #BRCM_SWREQ_ETHSWT_DYNAMIC_CONFIGURATION
*/
int32_t ETHSWT_SetPortDefaultVlan(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID,
        ETHER_VLANIDType aVlanID,
        ETHER_PrioType aPrio)
{
    ETHSWT_IOType swtIO;
    ETHSWT_VLANIOType vlanIO;
    int32_t ret;

    if (aSwtID < SWITCH_MAX_HW_ID) {
        swtIO.vlanIO = &vlanIO;
        vlanIO.portHwID = aPortID;
        vlanIO.vlanID = aVlanID;
        vlanIO.prio = aPrio;
        swtIO.retVal = BCM_ERR_UNKNOWN;
        swtIO.swtHwID = aSwtID;
        ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_SET_PORT_DEFAULT_VLAN, &swtIO);
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }
    return ret;
}

/**
    @brief Get port default VLAN

    @trace #BRCM_SWARCH_ETHSWT_GET_PORT_DEFAULT_VLAN_PROC
    @trace #BRCM_SWREQ_ETHSWT_QUERY
*/
int32_t ETHSWT_GetPortDefaultVlan(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID,
        ETHER_VLANIDType *const aVlanID,
        ETHER_PrioType *const aPrio)
{
    ETHSWT_IOType swtIO;
    ETHSWT_VLANIOType vlanIO;
    int32_t ret;

    if ((aSwtID < SWITCH_MAX_HW_ID) && (NULL != aVlanID) && (NULL != aPrio)) {
        swtIO.vlanIO = &vlanIO;
        vlanIO.portHwID = aPortID;
        swtIO.retVal = BCM_ERR_UNKNOWN;
        swtIO.swtHwID = aSwtID;
        ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_GET_PORT_DEFAULT_VLAN, &swtIO);
        if (BCM_ERR_OK == ret) {
            *aVlanID = vlanIO.vlanID;
            *aPrio = vlanIO.prio;
        }
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }
    return ret;
}

/**
    @brief Set VLAN ingress filter mode

    @trace #BRCM_SWARCH_ETHSWT_SET_VLANINGRESS_FILTER_MODE_PROC
    @trace #BRCM_SWREQ_ETHSWT_DYNAMIC_CONFIGURATION
*/
int32_t ETHSWT_SetVLANIngressFilterMode(ETHSWT_HwIDType aSwtID,
        ETHSWT_VLANIngressFilterModeType aMode)
{
    ETHSWT_IOType swtIO;
    ETHSWT_VLANIOType vlanIO;
    int32_t ret;

    if (aSwtID < SWITCH_MAX_HW_ID) {
        swtIO.vlanIO = &vlanIO;
        vlanIO.mode = aMode;
        swtIO.retVal = BCM_ERR_UNKNOWN;
        swtIO.swtHwID = aSwtID;
        ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_SET_VLAN_IFILTER_MODE, &swtIO);
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }
    return ret;
}

/**
    @brief Get VLAN ingress VLAN mode

    @trace #BRCM_SWARCH_ETHSWT_GET_VLANINGRESS_FILTER_MODE_PROC
    @trace #BRCM_SWREQ_ETHSWT_QUERY
*/
int32_t ETHSWT_GetVLANIngressFilterMode(ETHSWT_HwIDType aSwtID,
         ETHSWT_VLANIngressFilterModeType *const aMode)
{
    ETHSWT_IOType swtIO;
    ETHSWT_VLANIOType vlanIO;
    int32_t ret;

    if ((aSwtID < SWITCH_MAX_HW_ID) && (NULL != aMode)) {
        swtIO.vlanIO = &vlanIO;
        swtIO.retVal = BCM_ERR_UNKNOWN;
        swtIO.swtHwID = aSwtID;
        ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_GET_VLAN_IFILTER_MODE, &swtIO);
        if (BCM_ERR_OK == ret) {
            *aMode = vlanIO.mode;
        }
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }
    return ret;
}

/**
    @brief Enable VLAN

    @trace #BRCM_SWARCH_ETHSWT_ENABLE_VLAN_PROC
    @trace #BRCM_SWREQ_ETHSWT_DYNAMIC_CONFIGURATION
*/
int32_t ETHSWT_EnableVLAN(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID,
        ETHER_VLANIDType aVlanID,
        uint32_t aEnable)
{
    ETHSWT_IOType swtIO;
    ETHSWT_VLANIOType vlanIO;
    int32_t ret;

    if (aSwtID < SWITCH_MAX_HW_ID) {
        swtIO.vlanIO = &vlanIO;
        vlanIO.portHwID = aPortID;
        vlanIO.vlanID = aVlanID;
        vlanIO.enable = aEnable;
        swtIO.retVal = BCM_ERR_UNKNOWN;
        swtIO.swtHwID = aSwtID;
        ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_ENABLE_VLAN, &swtIO);
        if (BCM_ERR_OK != ret) {
            ETHSWT_DrvReportError((BCM_SWT_ID & BCM_LOGMASK_USER), (uint8_t)aSwtID,
                    BRCM_SWDSGN_ETHSWT_ENABLE_VLAN_PROC, ret, 0UL, 0UL, 0UL, __LINE__);
        }
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }
    return ret;
}

#ifdef ENABLE_ETHSWT_SECURITY
/** @brief Set Vlan-Hopping detection(enable/disable)

    This API sets Vlan-Hopping detection. If Vlan-Hopping
    detection is enabled, then any packet arriving with two tags
    with TPID 0x8100 should be discarded or sent to the CPU.

    @behavior Sync, Non re-entrant

    @pre None

    @param[in]      aSwtID                   Switch index
    @param[in]      aVlanHoppingAction       Vlan-Hopping action.

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully set Vlan-Hopping
                                        detection
    @retval     #BCM_ERR_TIME_OUT       Timeout occurred while reading/writing
                                        switch register
    @retval     #BCM_ERR_INVAL_PARAMS   (invalid Vlan-Hopping action) or
                                        (Invalid switch index)
    @retval     #BCM_ERR_NOPERM         CPU port is not available
                                        (Valid only for the action,
                                         redirect to CPU)
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post None
    @code{.c}
    ETHSWT_IOType swtIO;
    ETHSWT_VLANIOType vlanIO;
    ret = BCM_ERR_INVAL_PARAMS;
    ETHSWT_MgmtModeType mode;

    if ((aSwtID < SWITCH_MAX_HW_ID)  &&
       (aVlanHoppingAction <= ETHSWT_SECURITY_ACTION_REDIRECT_TO_CPU)) {
        if(ETHSWT_SECURITY_ACTION_REDIRECT_TO_CPU == aVlanHoppingAction) {
            ret = ETHSWT_GetMgmtMode(aSwtID, &mode);
            ETHSWT_CHECK_ERR(ret, &line, err_exit)
            if(ETHSWT_MGMTMODE_DISABLE == mode) {
                ret = BCM_ERR_NOPERM;
                line = __LINE__;
                goto err_exit;
            }
        }
        swtIO.vlanIO = &vlanIO;
        vlanIO.securityAction    = aVlanHoppingAction;
        swtIO.retVal             = BCM_ERR_UNKNOWN;
        ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_SET_VLAN_HOPPING_DETECT, &swtIO);
        if (BCM_ERR_OK != ret) {
            ETHSWT_DrvReportError
        }
    }
    ETHSWT_REPORT_ERR(ret, aSwtID, line,
        BRCM_SWDSGN_ETHSWT_SET_VLAN_HOPPING_DETECTION_PROC, 0UL, 0UL, 0UL)
    return ret;
    @endcode
    @trace  #BRCM_SWREQ_ETHSWT_SECURITY
    @trace  #BRCM_SWARCH_ETHSWT_SET_VLANHOPPINGDETECTION_PROC

    @limitations None
*/
int32_t ETHSWT_SetVlanHoppingDetection(ETHSWT_HwIDType aSwtID,
                 ETHSWT_SecurityActionType aVlanHoppingAction)
{
    uint32_t line = __LINE__;
    ETHSWT_IOType swtIO;
    ETHSWT_VLANIOType vlanIO;
    int32_t ret = BCM_ERR_INVAL_PARAMS;
    ETHSWT_MgmtModeType mode;

    if ((aSwtID < SWITCH_MAX_HW_ID)  &&
       (aVlanHoppingAction <= ETHSWT_SECURITY_ACTION_REDIRECT_TO_CPU)) {
        if(ETHSWT_SECURITY_ACTION_REDIRECT_TO_CPU == aVlanHoppingAction) {
            ret = ETHSWT_GetMgmtMode(aSwtID, &mode);
            ETHSWT_CHECK_ERR(ret, &line, err_exit)
            if(ETHSWT_MGMTMODE_DISABLE == mode) {
                ret = BCM_ERR_NOPERM;
                line = __LINE__;
                goto err_exit;
            }
        }
        swtIO.vlanIO = &vlanIO;
        vlanIO.securityAction    = aVlanHoppingAction;
        swtIO.retVal             = BCM_ERR_UNKNOWN;
        ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_SET_VLAN_HOPPING_DETECT, &swtIO);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
    }
err_exit:
    ETHSWT_REPORT_ERR(ret, aSwtID, line,
        BRCM_SWDSGN_ETHSWT_SET_VLAN_HOPPING_DETECTION_PROC, 0UL, 0UL, 0UL)
    return ret;
}

/** @brief Get Vlan-Hopping detection(enable/disable) status

    This function retreives switch Vlan-Hopping detection
    (enable/disable) status.

    @behavior Sync, Non re-entrant

    @pre None

    @param[in]      aSwtID                   Switch index
    @param[out]     aVlanHoppingAction       Pointer to Vlan-Hopping
                                             action.

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully retrieved Vlan-Hopping
                                        status
    @retval     #BCM_ERR_TIME_OUT       Timeout occurred while reading/writing
                                        switch register
    @retval     #BCM_ERR_INVAL_PARAMS   (aVlanHoppingAction is NULL) or
                                        (Invalid switch index)
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post None
    @code{.c}
    ETHSWT_IOType swtIO;
    ETHSWT_VLANIOType vlanIO;
    ret = BCM_ERR_INVAL_PARAMS;

    if ((aSwtID < SWITCH_MAX_HW_ID) &&
        (NULL != aVlanHoppingAction)) {
        swtIO.vlanIO = &vlanIO;
        vlanIO.securityActionPtr = aVlanHoppingAction;
        swtIO.retVal             = BCM_ERR_UNKNOWN;
        ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_GET_VLAN_HOPPING_DETECT, &swtIO);
        if (BCM_ERR_OK != ret) {
            ETHSWT_DrvReportError
        } else {
            *aVlanHoppingAction = vlanIO.securityAction;
        }
    }
    return ret;
    @endcode
    @trace  #BRCM_SWREQ_ETHSWT_SECURITY
    @trace  #BRCM_SWARCH_ETHSWT_GET_VLANHOPPINGDETECTION_PROC

    @limitations None
*/
int32_t ETHSWT_GetVlanHoppingDetection(ETHSWT_HwIDType aSwtID,
        ETHSWT_SecurityActionType * const aVlanHoppingAction)
{
    ETHSWT_IOType swtIO;
    ETHSWT_VLANIOType vlanIO;
    int32_t ret = BCM_ERR_INVAL_PARAMS;

    if ((aSwtID < SWITCH_MAX_HW_ID) &&
        (NULL != aVlanHoppingAction)) {
        swtIO.vlanIO = &vlanIO;
        swtIO.retVal            = BCM_ERR_UNKNOWN;
        ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_GET_VLAN_HOPPING_DETECT, &swtIO);
        if (BCM_ERR_OK != ret) {
            ETHSWT_DrvReportError((BCM_SWT_ID & BCM_LOGMASK_USER), (uint8_t)aSwtID,
                    BRCM_SWDSGN_ETHSWT_GET_VLAN_HOPPING_DETECTION_PROC, ret, 0UL, 0UL, 0UL, __LINE__);
        } else {
            *aVlanHoppingAction = vlanIO.securityAction;
        }
    }
    return ret;
}
#endif /* ENABLE_ETHSWT_SECURITY */

/** @} */
