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

    @file switch_ext.c

    @brief Ethernet switch

    @version 0.1 Initial version
*/

#include <switch_rdb.h>
#include <bcm_utils.h>
#include <bcm_err.h>
#include <eth_switch.h>
#include <eth_switch_osil.h>
#include <eth_osil.h>
#include <eth_cntlr.h>
#include "switch_drv.h"
#include "switch_cfg.h"
#ifdef ENABLE_ETHSWT_VLAN
#include <ethswt_vlan_osil.h>
#endif
#ifdef ENABLE_ETHSWT_ARL
#include <ethswt_arl_osil.h>
#endif
#ifdef ENABLE_ETHSWT_XCVR
#include <ethswt_xcvr_osil.h>
#endif
#include <ethswt_ext_osil.h>
#if defined(__BCM8956X__) || defined(__BCM8957X__)
#include "p1588_rdb.h"
#endif
#include <mcu_switch_ext.h>

/**
    @name Ethernet switch Design ID's
    @{
    @brief Ethernet switch Design ID's
*/
#define BRCM_SWDSGN_ETHSWT_DRV_VLAN_TBL_CONFIG_PROC               (0xBA01U)    /**< @brief #ETHSWT_DrvVLANTblConfig              */
#define BRCM_SWDSGN_ETHSWT_DRV_QOS_CONFIG_PROC                    (0xBA02U)    /**< @brief #ETHSWT_DrvQoSConfig                  */
#define BRCM_SWDSGN_ETHSWT_DRV_QUEUE_SHAPER_CONFIG_PROC           (0xBA03U)    /**< @brief #ETHSWT_DrvQueueShaperConfig          */
#define BRCM_SWDSGN_ETHSWT_DRV_PORT_FLOW_CNTRL_CONFIG_PROC        (0xBA04U)    /**< @brief #ETHSWT_DrvPortFlowCntrlConfig        */
#define BRCM_SWDSGN_ETHSWT_DRV_PORT_SCH_CONFIG_PROC               (0xBA05U)    /**< @brief #ETHSWT_DrvPortSchConfig              */
#define BRCM_SWDSGN_ETHSWT_DRV_EGRESS_CONFIG_PROC                 (0xBA06U)    /**< @brief #ETHSWT_DrvEgressConfig               */
#define BRCM_SWDSGN_ETHSWT_DRV_INGRESS_CONFIG_PROC                (0xBA07U)    /**< @brief #ETHSWT_DrvIngressConfig              */
#define BRCM_SWDSGN_ETHSWT_DRV_VERIFY_EGRESS_CONFIG_PROC          (0xBA08U)    /**< @brief #ETHSWT_DrvVerifyEgressConfig         */
#define BRCM_SWDSGN_ETHSWT_DRV_VERIFY_INGRESS_CONFIG_PROC         (0xBA09U)    /**< @brief #ETHSWT_DrvVerifyIngressConfig        */
#define BRCM_SWDSGN_ETHSWT_DRV_EXT_CONFIG_PROC                    (0xBA0AU)    /**< @brief #ETHSWT_DrvExtConfigure               */
#define BRCM_SWDSGN_ETHSWT_EXT_CONFIG_PROC                        (0xBA0BU)    /**< @brief #ETHSWT_ExtConfigure                  */
#define BRCM_SWDSGN_ETHSWT_DRV_PORT_CONFIG_PROC                   (0xBA0CU)    /**< @brief #ETHSWT_DrvPortConfig                 */
#define BRCM_SWDSGN_ETHSWT_EXT_CMD_HANDLER_PROC                   (0xBA0DU)    /**< @brief #ETHSWT_ExtCmdHandler                 */
#define BRCM_SWDSGN_ETHSWT_DRV_ENABLE_PORT_PROC                   (0xBA0EU)    /**< @brief #ETHSWT_DrvEnablePort                 */
#define BRCM_SWDSGN_ETHSWT_DRV_ARL_TBL_CONFIG_PROC                (0xBA0FU)    /**< @brief #ETHSWT_DrvARLTblConfig               */
#define BRCM_SWDSGN_ETHSWT_VLAN_MEM_CFG_MAC_ADDR_LIST_SZ_MACRO    (0xBA10U)    /**< @brief #ETHSWT_VLAN_MEM_CFG_MAC_ADDR_LIST_SZ */
#define BRCM_SWDSGN_ETHSWT_SECURITY_CONFIG_PROC                   (0xBA11U)    /**< @brief #ETHSWT_SecurityConfig                */
#define BRCM_SWDSGN_ETHSWT_DRV_ARL_TCAM_INIT_PROC                 (0xBA12U)    /**< @brief #ETHSWT_DrvArlTcamInit                */
#define BRCM_SWDSGN_ETHSWT_DRV_PORT_SHAPER_CONFIG_PROC            (0xBA13U)    /**< @brief #ETHSWT_DrvPortShaperConfig           */
#define BRCM_SWDSGN_ETHSWT_PORT_SHAPER_CONFIG_PROC                (0xBA14U)    /**< @brief #ETHSWT_PortShaperConfig              */
/** @} */

/**
    @brief VLAN member configuration MAC address list size

    @trace #BRCM_SWARCH_ETHSWT_ARL_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_EXT
*/
#define ETHSWT_VLAN_MEM_CFG_MAC_ADDR_LIST_SZ \
    (8UL * (sizeof((ETHSWT_VLANMemberCfgType *)0)->macAddrList))

/**
    @brief Enable port

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aSwtID      Switch Index
    @param[in]      aPortID     Port ID

    Return values are documented in reverse-chronological order
    @retval         #BCM_ERR_OK             On Success
    @retval         #BCM_ERR_INVAL_PARAMS   aSwtType is invalid

    @post None

    @trace #BRCM_SWARCH_ETHSWT_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_EXT
 */
static int32_t ETHSWT_DrvEnablePort(ETHSWT_HwIDType aSwtID,
                                    ETHSWT_PortIDType aPortID)
{
    uint32_t line;
    int ret = BCM_ERR_OK;

    if (aPortID != 8UL) {
        ret = ETHSWT_DrvWriteReg(aSwtID,
#ifdef __BCM8953X__
                    (uint32_t)&ETHSWT_Regs->page_00_g_pctl[aPortID].m00_g_pctl0,
#else
                    (uint32_t)&ETHSWT_Regs->page_00_g_pctl[aPortID].m00_g_pctl_p0,
#endif
                    0ULL);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
    }

err_exit:
    ETHSWT_REPORT_ERR( ret, aSwtID, line,
        BRCM_SWDSGN_ETHSWT_DRV_ENABLE_PORT_PROC, 0UL, 0UL, 0UL)
    return ret;
}


/**
    @brief Update VLAN table entry

    @trace #BRCM_SWARCH_ETHSWT_VLAN_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_EXT
 */
static int32_t ETHSWT_DrvVLANTblConfig(ETHSWT_HwIDType aID,
        const ETHSWT_CfgType * const aConfig)
{
    uint32_t i;
    uint32_t j;
    uint16_t vlanID;
    ETHSWT_VLANFwrdType forward;
    const ETHSWT_PortCfgType *portCfg;
    int32_t ret = BCM_ERR_OK;

    for (i = 0UL; i < aConfig->portCfgListSz; i++) {
        portCfg = &aConfig->portCfgList[i];
        for (j = 0UL; j < portCfg->vlanMemListSz; j++) {
            vlanID = portCfg->vlanMemList[j].vlanID;
            forward = portCfg->vlanMemList[j].forward;
            if (vlanID > ETHER_VLANID_MAX) {
                ret = BCM_ERR_INVAL_PARAMS;
                break;
            }
            ret = ETHSWT_DrvUpdateVLANTblEntry(aID, portCfg->portID,
                    vlanID, forward, 0UL);
            if (ret != BCM_ERR_OK) {
                break;
            }
        }
        if (ret != BCM_ERR_OK) {
            break;
        }
    }

    return ret;
}
#ifdef ENABLE_ETHSWT_TCAM
/**
    @brief ARL-TCAM Init

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aSwtID      Switch Index

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK            On Success
    @retval     #BCM_ERR_TIME_OUT      Reset timeout
    @retval     #BCM_ERR_INVAL_PARAMS  aSwtID is invalid

    @post None
    @code{.c}
    ret = BCM_ERR_OK
    timeout = 0UL
    if (aSwtID < SWITCH_MAX_HW_ID) {
        reg = Read SWITCH_PAGE_B0_ARL_TCAM_ACC register
        Set PAGE_B0_ARL_TCAM_ACC_TCAM_RST[3:3] bit
        reg |= SWITCH_PB0ATA_PAGE_B0_ARL_TCAM_ACC_TCAM_RST_MASK;
        Write SWITCH_PAGE_B0_ARL_TCAM_ACC register with value reg

        Wait for the reset operation, PAGE_B0_ARL_TCAM_ACC_TCAM_RST[3:3] to clear
        while (timeout < ETHSWT_RDWR_TIMEOUT) {
            reg = Read SWITCH_PAGE_B0_ARL_TCAM_ACC register
            Check PAGE_B0_ARL_TCAM_ACC_TCAM_RST[3:3] bit is clear or not
            if (0ULL == (reg & SWITCH_PB0ATA_PAGE_B0_ARL_TCAM_ACC_TCAM_RST_MASK)) {
                break;
            }
            timeout++;
        }
        if (ETHSWT_RDWR_TIMEOUT == timeout) {
            ret = BCM_ERR_TIME_OUT;
            Report error
            goto err_exit;
        }
        Enable ARL-TCAM with the below configurations
        Set PAGE_04_ARL_TCAM_CTRL_TCAM_EN[0:0]
        Set PAGE_04_ARL_TCAM_CTRL_TCAM_MCAST_EN[4:4]

        reg = SWITCH_P04ATC_PAGE_04_ARL_TCAM_CTRL_TCAM_EN_MASK |
              SWITCH_P04ATC_PAGE_04_ARL_TCAM_CTRL_TCAM_MCAST_EN_MASK;
        Write SWITCH_PAGE_04_ARL_TCAM_CTRL register with value reg
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }

    err_exit:
    return ret;
    @endcode
    @trace #BRCM_SWARCH_ETHSWT_ARL_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_EXT
 */
static int32_t ETHSWT_DrvArlTcamInit(ETHSWT_HwIDType aSwtID)
{
    uint32_t reg;
    int32_t ret = BCM_ERR_OK;
    uint32_t timeout = 0UL;
    uint32_t line = __LINE__;
    if (aSwtID < SWITCH_MAX_HW_ID) {
        /* Reset ARL-TCAM before doing any operations.
         * To be done with ARL-TCAM disabled ONLY
         */
        ret = ETHSWT_DrvReadReg32(aSwtID, (uint32_t)&ETHSWT_Regs->b0_arl_tcam_acc, &reg);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
        reg |= SWITCH_PB0ATA_PAGE_B0_ARL_TCAM_ACC_TCAM_RST_MASK;
        ret = ETHSWT_DrvWriteReg32(aSwtID, (uint32_t)&ETHSWT_Regs->b0_arl_tcam_acc, reg);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
        /* Wait for the reset operation, ACC_TCAM_RST to clear */
        while (timeout < ETHSWT_RDWR_TIMEOUT) {
            ETHSWT_DrvReadReg32(aSwtID, (uint32_t)&ETHSWT_Regs->b0_arl_tcam_acc, &reg);
            ETHSWT_CHECK_ERR(ret, &line, err_exit)
            if (0ULL == (reg & SWITCH_PB0ATA_PAGE_B0_ARL_TCAM_ACC_TCAM_RST_MASK)) {
                break;
            }
            timeout++;
        }
        if (ETHSWT_RDWR_TIMEOUT == timeout) {
            ret = BCM_ERR_TIME_OUT;
            ETHSWT_DrvReportError((BCM_SWT_ID & BCM_LOGMASK_USER), (uint8_t)aSwtID,
            BRCM_SWDSGN_ETHSWT_DRV_ARL_TCAM_INIT_PROC, ret, 0x0UL, aSwtID, reg, __LINE__);
            goto err_exit;
        }
        /* Enable ARL-TCAM with the below configurations
         * TCAM_MCAST_EN
         * TCAM_AGE_EN (Currently not enabled)
         * TCAM_EN
         * TCAM_CHK_EN (Currently not enabled)
         */
        reg = SWITCH_P04ATC_PAGE_04_ARL_TCAM_CTRL_TCAM_EN_MASK |
              SWITCH_P04ATC_PAGE_04_ARL_TCAM_CTRL_TCAM_MCAST_EN_MASK;
        ETHSWT_DrvWriteReg32(aSwtID, (uint32_t)&ETHSWT_Regs->m04_arl_tcam_ctrl, reg);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }
err_exit:
    ETHSWT_REPORT_ERR(ret, aSwtID, line,
        BRCM_SWDSGN_ETHSWT_DRV_ARL_TCAM_INIT_PROC, 0UL, 0UL, 0UL)
    return ret;
}
#endif

/**
    @brief ARL table configuration

    @trace #BRCM_SWARCH_ETHSWT_ARL_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_EXT
 */
static int32_t ETHSWT_DrvARLTblConfig(ETHSWT_HwIDType aID,
        const ETHSWT_CfgType * const aConfig)
{
    uint32_t i, j, k;
    uint64_t mac;
    uint8_t *temp;
    int32_t ret = BCM_ERR_OK;
    ETHSWT_ARLTBLHWEntryType hwEntry;
    const ETHSWT_PortCfgType *portCfg;
    const ETHSWT_VLANMemberCfgType * vlanMemCfg;
    uint32_t isMacAddrFound[ETHSWT_PORT_MAC_ENTRY_MAX];

    for (i = 0UL; i < aConfig->portCfgListSz; i++) {
        BCM_MemSet(isMacAddrFound, 0x0U, sizeof(isMacAddrFound));
        portCfg = &aConfig->portCfgList[i];
        /* Add ARL table entry for each VLAN member and MAC addresss */
        for (j = 0UL; j < portCfg->vlanMemListSz; j++) {
            vlanMemCfg = &portCfg->vlanMemList[j];
            hwEntry.vlanID = vlanMemCfg->vlanID;
            hwEntry.priority = vlanMemCfg->defaultPri;
            for (k = 0UL; k < ETHSWT_VLAN_MEM_CFG_MAC_ADDR_LIST_SZ; k++) {
                if (((uint8_t)vlanMemCfg->macAddrList & (0x1U << k)) != 0U) {
                    isMacAddrFound[k] = 1UL;
                    temp = (uint8_t *)(&portCfg->fixedMacAddrList[k][0]);
                    mac = ETHSWT_NMAC2HWMAC(temp);
                    hwEntry.mac = mac;
                    /* H/W field expects port number for unicast entry and a portmask */
                    /* for multicast entry                                            */
                    hwEntry.portMask = (uint16_t)portCfg->portID;
                    if (0x1U == (temp[0U] & 0x1U)) {
                        /* Mcast entry. Read from the ARL table first  */
                        uint32_t portMask = 0UL;
                        uint32_t binIdx = 0UL;

                        ret = ETHSWT_DrvARLTblSearchByAddr(aID,
                                mac, vlanMemCfg->vlanID, &portMask, &binIdx);
                        if ((ret != BCM_ERR_OK) && (ret != BCM_ERR_NOT_FOUND)) {
                            break;
                        }

                        hwEntry.portMask = (uint16_t)(portMask | ( 1UL << portCfg->portID));
                    }
                    ret = ETHSWT_DrvARLTblAddEntry(aID, &hwEntry);
                    if (ret != BCM_ERR_OK) {
                        break;
                    }
                }
            }
            if (ret != BCM_ERR_OK) {
                break;
            }
        }
        if (ret != BCM_ERR_OK) {
            break;
        }
        /* Add ARL entry for MAC address which are not part of any VLAN */
        for (j = 0UL; j < portCfg->macAddrListSz; j++) {
            if (0UL == isMacAddrFound[j]) {
                temp = (uint8_t *)(&portCfg->fixedMacAddrList[j][0]);
                mac = ETHSWT_NMAC2HWMAC(temp);
                hwEntry.mac = mac;
                hwEntry.vlanID = 0U;
                hwEntry.priority = 0U;
                /* H/W field expects port number for unicast entry and a portmask */
                /* for multicast entry                                            */
                hwEntry.portMask = (uint16_t)portCfg->portID;
                if (0x1U == (temp[0U] & 0x1U)) {
                    /* Mcast entry. Read from the ARL table first  */
                    uint32_t portMask = 0UL;
                    uint32_t binIdx = 0UL;

                    ret = ETHSWT_DrvARLTblSearchByAddr(aID, mac, 0, &portMask, &binIdx);
                    if ((ret != BCM_ERR_OK) && (ret != BCM_ERR_NOT_FOUND)) {
                        break;
                    }

                    hwEntry.portMask = (uint16_t)(portMask | ( 1UL << portCfg->portID));
                }
                ret = ETHSWT_DrvARLTblAddEntry(aID, &hwEntry);
                if (ret != BCM_ERR_OK) {
                    break;
                }
            }
        }
        if (ret != BCM_ERR_OK) {
            break;
        }
    }

    return ret;
}

/**
    @brief QoS configuration

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aID             Index
    @param[in]      aPortCfg        Pointer to port configuration

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success

    @post None

    @trace #BRCM_SWARCH_ETHSWT_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_EXT
 */
static int32_t ETHSWT_DrvQoSConfig(ETHSWT_HwIDType aID,
        const ETHSWT_PortCfgType *const aPortCfg)
{
    uint32_t line;
    uint32_t i;
    uint32_t reg;
    uint32_t tcSel;
    uint32_t tcSelRegAddr;
    uint32_t pcp2tcMapRegAddr;
    uint32_t tc2cosMapRegAddr;
    int32_t ret = BCM_ERR_OK;
    const ETHSWT_PortIngressCfgType *ingress = &aPortCfg->ingressCfg;
    const ETHSWT_PortEgressCfgType  *egress = &aPortCfg->egressCfg;

    /* enable 802.1P for this port */
    ret = ETHSWT_DrvReadReg32(aID, (uint32_t)&ETHSWT_Regs->m30_qos_1p_en, &reg);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    reg |= (uint32_t)ETHSWT_PORTID2HWMASK(aPortCfg->portID);
    ret = ETHSWT_DrvWriteReg32(aID, (uint32_t)&ETHSWT_Regs->m30_qos_1p_en, reg);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)

    /* QoS configuration Steps:
     * 1. Select the Port TC selection (PID2TC, PCP2TC, DSC2TC etc)
     * 2. Configure PCP to TC in PCP To TC DEI 0 selection register
     * 3. Configure TC to COS Queue in Port TC to COS mapping register
     */

    /* port based traffic class selection
     * if "tc" is valid range, select PID2TC
     * select table for this port in hardware
     * otherwise QoS is based on PCP2TC map
     */
    if (ingress->tc <= ETHSWT_TC_7) {
        ret = ETHSWT_DrvReadReg32(aID, (uint32_t)&ETHSWT_Regs->m30_pid2tc, &reg);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
        reg &= ~(SWITCH_PID2TC_PORT_MASK << (aPortCfg->portID * SWITCH_PID2TC_PORT_SHIFT));
        reg |= (ingress->tc & SWITCH_PID2TC_PORT_MASK) <<
                (aPortCfg->portID * SWITCH_PID2TC_PORT_SHIFT);
        ret = ETHSWT_DrvWriteReg32(aID, (uint32_t)&ETHSWT_Regs->m30_pid2tc, reg);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
        /* select PID2TC bits in TC select table register */
        tcSel = ((SWITCH_TC_SEL_PID2TC_VAL
                    << SWITCH_TC_SEL_TABLE_TC_SEL_0_0_SHIFT) |
                (SWITCH_TC_SEL_PID2TC_VAL
                    << SWITCH_TC_SEL_TABLE_TC_SEL_1_0_SHIFT) |
                (SWITCH_TC_SEL_PID2TC_VAL
                    << SWITCH_TC_SEL_TABLE_TC_SEL_2_0_SHIFT) |
                (SWITCH_TC_SEL_PID2TC_VAL
                    << SWITCH_TC_SEL_TABLE_TC_SEL_3_0_SHIFT) |
                (SWITCH_TC_SEL_PID2TC_VAL
                    << SWITCH_TC_SEL_TABLE_TC_SEL_4_0_SHIFT) |
                (SWITCH_TC_SEL_PID2TC_VAL
                    << SWITCH_TC_SEL_TABLE_TC_SEL_5_0_SHIFT) |
                (SWITCH_TC_SEL_PID2TC_VAL
                    << SWITCH_TC_SEL_TABLE_TC_SEL_6_0_SHIFT) |
                (SWITCH_TC_SEL_PID2TC_VAL
                    << SWITCH_TC_SEL_TABLE_TC_SEL_7_0_SHIFT));
    } else {
        /* configure P2P2TC port map registers and choose PCP2TC map
         * for QoS
         */
        pcp2tcMapRegAddr = SWITCH_M30_PN_PCP2TC_DEI0_PORT0
                            + aPortCfg->portID * 4UL;
        reg = 0UL;
        for (i = 0UL; i < 8UL; i++) {
            reg |= ((ingress->pcp2tcMap[i] & SWITCH_PN_PCP2TC_DEI0_TAG_PRI_MAP_MASK) <<
                    i * SWITCH_PN_PCP2TC_DEI0_TAG_PRI_MAP_SHIFT);
        }
        ret = ETHSWT_DrvWriteReg32(aID, pcp2tcMapRegAddr, reg);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
        /* select PCP2TC bits in TC select table register */
        tcSel = ((SWITCH_TC_SEL_PCP2TC_VAL
                    << SWITCH_TC_SEL_TABLE_TC_SEL_0_0_SHIFT) |
                (SWITCH_TC_SEL_PCP2TC_VAL
                    << SWITCH_TC_SEL_TABLE_TC_SEL_1_0_SHIFT) |
                (SWITCH_TC_SEL_PCP2TC_VAL
                    << SWITCH_TC_SEL_TABLE_TC_SEL_2_0_SHIFT) |
                (SWITCH_TC_SEL_PCP2TC_VAL
                    << SWITCH_TC_SEL_TABLE_TC_SEL_3_0_SHIFT) |
                (SWITCH_TC_SEL_PCP2TC_VAL
                    << SWITCH_TC_SEL_TABLE_TC_SEL_4_0_SHIFT) |
                (SWITCH_TC_SEL_PCP2TC_VAL
                    << SWITCH_TC_SEL_TABLE_TC_SEL_5_0_SHIFT) |
                (SWITCH_TC_SEL_PCP2TC_VAL
                    << SWITCH_TC_SEL_TABLE_TC_SEL_6_0_SHIFT) |
                (SWITCH_TC_SEL_PCP2TC_VAL
                    << SWITCH_TC_SEL_TABLE_TC_SEL_7_0_SHIFT));
    }

    tcSelRegAddr = SWITCH_M30_TC_SEL_TABLE_PORT0 + aPortCfg->portID * 2UL;
    /* set the TC selection bits in TC select table register */
    ret = ETHSWT_DrvWriteReg32(aID, tcSelRegAddr, tcSel);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)

    /* configure the TC2QOS mapping */
    tc2cosMapRegAddr = SWITCH_M30_PN_TC2COS_MAP_PORT0 + aPortCfg->portID * 4UL;
    ret = ETHSWT_DrvReadReg32(aID, tc2cosMapRegAddr, &reg);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    for (i = 0UL; i < egress->fifoListSz; i++) {
        reg &= ~((SWITCH_TC2COS_MAP_PRT_TO_QID_MASK <<
                    (egress->fifoList[i].tc * SWITCH_TC2COS_MAP_PRT_TO_QID_SHIFT)));
        reg |= egress->fifoList[i].id <<
                (egress->fifoList[i].tc * SWITCH_TC2COS_MAP_PRT_TO_QID_SHIFT);
    }
    ret = ETHSWT_DrvWriteReg32(aID, tc2cosMapRegAddr, reg);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)

    /* Configure the PCP remarking */
    if (TRUE == egress->pcpRemarkEn) {
        /* Enable egress PCP remarking on the port */
        ret = ETHSWT_DrvReadReg32(aID, (uint32_t)&ETHSWT_Regs->m91_trreg_ctrl0, &reg);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
        reg |= 1UL << (SWITCH_PAGE_91_TRREG_CTRL0_PCP_RMK_EN_SHIFT
                        + aPortCfg->portID);
        ret = ETHSWT_DrvWriteReg32(aID, (uint32_t)&ETHSWT_Regs->m91_trreg_ctrl0, reg);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)

        reg = 0UL;
        /* Configure the TC2PCP mapping */
        for (i = 0UL; i < 8UL; i++) {
            reg |= ((egress->tc2pcpMap[i] & SWITCH_TC2PCP_MAP_MASK) <<
                             (i * SWITCH_TC2PCP_MAP_SHIFT));
            /* Configuring the same mapping for both packets with and without */
            /* rate violations                                                */
            reg |= ((egress->tc2pcpMap[i] & SWITCH_TC2PCP_MAP_MASK) <<
                             (32UL + (i * SWITCH_TC2PCP_MAP_SHIFT)));
        }
        ret = ETHSWT_DrvWriteReg32(aID,
                    SWITCH_M91_PN_EGRESS_PKT_TC2PCP_MAP_PORT0 + (aPortCfg->portID * 8UL),
                    reg);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
    }

err_exit:
    ETHSWT_REPORT_ERR(ret, aID, line,
        BRCM_SWDSGN_ETHSWT_DRV_QOS_CONFIG_PROC, 0UL, 0UL, 0UL)
    return ret;
}

/**
    @brief Port shaper configuration

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aID             Index
    @param[in]      aPortCfg        Pointer to port configuration

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success

    @post None

    @trace #BRCM_SWARCH_ETHSWT_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_EXT
 */
static int32_t ETHSWT_DrvPortShaperConfig(ETHSWT_HwIDType aID,
        ETHSWT_PortIDType aPortID,
        const ETHSWT_ShaperCfgType *const aShaperCfg)
{
    uint32_t line;
    uint32_t regAddr;
    int32_t  ret = BCM_ERR_OK;
    uint32_t regVal;

    if (aShaperCfg->rateBps != 0UL) {
        /* configure MAX_REFRESH value in shaping rate control register */
        regAddr = SWITCH_PORT0_BYTE_SHAPER_MAX_REFRESH + aPortID * 4UL;
        regVal = (aShaperCfg->rateBps / SWITCH_SHAPER_BIT_RATE_PER_TOKEN);
        ret = ETHSWT_DrvWriteReg32(aID, regAddr, regVal);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)

        /* configure MAX_THD_SEL value in burst size control register */
        regAddr = SWITCH_PORT0_BYTE_SHAPER_MAX_THD_SEL + aPortID * 4UL;
        regVal = (aShaperCfg->burstBytes / SWITCH_SHAPER_BUCKET_UNIT);
        ret = ETHSWT_DrvWriteReg32(aID, regAddr, regVal);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)

        /* select Bit based shaping */
        ret = ETHSWT_DrvReadReg32(aID, SWITCH_PORT_SHAPER_BUCKET_COUNT_SELECT, &regVal);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
        regVal &= (uint32_t)~ETHSWT_PORTID2HWMASK(aPortID);
        ret = ETHSWT_DrvWriteReg32(aID, SWITCH_PORT_SHAPER_BUCKET_COUNT_SELECT, regVal);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)

        /* enable the port shaper and if avbShaping mode is enabled */
        if (aShaperCfg->avbShapingModeEn == TRUE) {
            ret = ETHSWT_DrvReadReg32(aID, SWITCH_PORT_SHAPER_AVB_SHAPING_MODE, &regVal);
            ETHSWT_CHECK_ERR(ret, &line, err_exit)
            regVal |= (uint32_t)ETHSWT_PORTID2HWMASK(aPortID);
            ret = ETHSWT_DrvWriteReg32(aID, SWITCH_PORT_SHAPER_AVB_SHAPING_MODE, regVal);
            ETHSWT_CHECK_ERR(ret, &line, err_exit)
        }

        ret = ETHSWT_DrvReadReg32(aID, SWITCH_PORT_SHAPER_ENABLE, &regVal);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
        regVal |= (uint32_t)ETHSWT_PORTID2HWMASK(aPortID);
        ret = ETHSWT_DrvWriteReg32(aID, SWITCH_PORT_SHAPER_ENABLE, regVal);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
    } else {
        /* disable the port shaper for this Queue */
        ret = ETHSWT_DrvReadReg32(aID, SWITCH_PORT_SHAPER_ENABLE, &regVal);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
        regVal &= (uint32_t)~ETHSWT_PORTID2HWMASK(aPortID);
        ret = ETHSWT_DrvWriteReg32(aID, SWITCH_PORT_SHAPER_ENABLE, regVal);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
    }

err_exit:
    return ret;
}

/**
    @brief Queue shaper configuration

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aID             Index
    @param[in]      aPortCfg        Pointer to port configuration

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success

    @post None

    @trace #BRCM_SWARCH_ETHSWT_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_EXT
 */
static int32_t ETHSWT_DrvQueueShaperConfig(ETHSWT_HwIDType aID,
        const ETHSWT_PortCfgType *const aPortCfg)
{
    uint32_t i;
    uint32_t reg;
    uint32_t regAddr;
    const ETHSWT_FifoCfgType *fifo;
    const ETHSWT_PortEgressCfgType *egress = &aPortCfg->egressCfg;
    int32_t ret = BCM_ERR_OK;

    for (i = 0UL; i < egress->fifoListSz; i++) {
        fifo = &egress->fifoList[i];

        if (fifo->shaper.rateBps != 0UL) {
            /* configure MAX_REFRESH value in shaping rate control register */
            regAddr = SWITCH_SHAPER_PN_QUEUE0_MAX_REFRESH_PORT0 + fifo->id * 256UL
                        + aPortCfg->portID * 4UL;
            reg = (fifo->shaper.rateBps / SWITCH_SHAPER_BIT_RATE_PER_TOKEN);
            ret = ETHSWT_DrvWriteReg32(aID, regAddr, reg);
            if (BCM_ERR_OK != ret) {
                break;
            }

            /* configure MAX_THD_SEL value in burst size control register */
            regAddr = SWITCH_SHAPER_PN_QUEUE0_MAX_THD_SEL_PORT0 + fifo->id * 256UL
                        + aPortCfg->portID * 4UL;
            reg = (fifo->shaper.burstBytes / SWITCH_SHAPER_BUCKET_UNIT);
            ret = ETHSWT_DrvWriteReg32(aID, regAddr, reg);
            if (BCM_ERR_OK != ret) {
                break;
            }

            /* select Bit based shaping */
            ret = ETHSWT_DrvReadReg32(aID,
                        SWITCH_SHAPER_QUEUE_SHAPER_BUCKET_COUNT_SELECT + fifo->id * 256UL,
                        &reg);
            if (BCM_ERR_OK != ret) {
                break;
            }
            reg &= (uint32_t)~ETHSWT_PORTID2HWMASK(aPortCfg->portID);
            ret = ETHSWT_DrvWriteReg32(aID,
                        SWITCH_SHAPER_QUEUE_SHAPER_BUCKET_COUNT_SELECT + fifo->id * 256UL,
                        reg);
            if (BCM_ERR_OK != ret) {
                break;
            }
            /* enable the port shaper and if avbShaping mode is enabled
             * enable AVB shaper */
            if (fifo->shaper.avbShapingModeEn == TRUE) {
                ret = ETHSWT_DrvReadReg32(aID,
                            SWITCH_SHAPER_QUEUE_AVB_SHAPING_MODE + fifo->id * 256UL,
                            &reg);
                if (BCM_ERR_OK != ret) {
                    break;
                }
                reg |= (uint32_t)ETHSWT_PORTID2HWMASK(aPortCfg->portID);
                ret = ETHSWT_DrvWriteReg32(aID,
                            SWITCH_SHAPER_QUEUE_AVB_SHAPING_MODE + fifo->id * 256UL,
                            reg);
                if (BCM_ERR_OK != ret) {
                    break;
                }
            }
            ret = ETHSWT_DrvReadReg32(aID,
                        SWITCH_SHAPER_QUEUE_SHAPER_ENABLE + fifo->id * 256UL,
                        &reg);
            if (BCM_ERR_OK != ret) {
                break;
            }
            reg |= (uint32_t)ETHSWT_PORTID2HWMASK(aPortCfg->portID);
            ret = ETHSWT_DrvWriteReg32(aID,
                        SWITCH_SHAPER_QUEUE_SHAPER_ENABLE + fifo->id * 256UL,
                        reg);
            if (BCM_ERR_OK != ret) {
                break;
            }
        } else {
            /* disable the Queue shaper for this Queue */
            ret = ETHSWT_DrvReadReg32(aID,
                        SWITCH_SHAPER_QUEUE_SHAPER_ENABLE + fifo->id * 256UL,
                        &reg);
            if (BCM_ERR_OK != ret) {
                break;
            }
            reg &= (uint32_t)~ETHSWT_PORTID2HWMASK(aPortCfg->portID);
            ret = ETHSWT_DrvWriteReg32(aID,
                        SWITCH_SHAPER_QUEUE_SHAPER_ENABLE + fifo->id * 256UL,
                        reg);
            if (BCM_ERR_OK != ret) {
                break;
            }
        }
    }

    return ret;
}

/**
    @brief Port flow control configuration

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aID             Index
    @param[in]      aPortCfg        Pointer to port configuration

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success

    @post None

    @trace #BRCM_SWARCH_ETHSWT_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_EXT
 */
static int32_t ETHSWT_DrvPortFlowCntrlConfig(ETHSWT_HwIDType aID,
        const ETHSWT_PortCfgType * const aPortCfg)
{
    uint32_t line = __LINE__;
    uint32_t i;
    uint32_t portFCMode = FALSE;
    uint32_t fifoThdRegAddr;
    int32_t ret = BCM_ERR_OK;
    const ETHSWT_PortEgressCfgType *egress = &aPortCfg->egressCfg;
    const ETHSWT_FifoCfgType *fifo;

      /* configure the reserved threshold for each COS Queue */
    for (i = 0UL; i < egress->fifoListSz; i++) {
        fifo = &egress->fifoList[i];
        fifoThdRegAddr = (uint32_t)&ETHSWT_Regs->m0b_fc_lan_txq_thd_rsv_q0 + fifo->id * 2UL;
        if (fifo->minLen != 0UL) {
            if (portFCMode == FALSE) {
                /* select the flow control mode as per port basis */
                ret = ETHSWT_DrvWriteReg32(aID, (uint32_t)&ETHSWT_Regs->m0a_fc_ctrl_mode,
                            SWITCH_FC_MODE_PORT);
                ETHSWT_CHECK_ERR(ret, &line, err_exit)
                /* select this port flow control port selection register */
                ret = ETHSWT_DrvWriteReg32(aID, (uint32_t)&ETHSWT_Regs->m0a_fc_ctrl_port,
                            aPortCfg->portID);
                ETHSWT_CHECK_ERR(ret, &line, err_exit)
                portFCMode = TRUE;
            }
            ret = ETHSWT_DrvWriteReg32(aID, fifoThdRegAddr,
                        (fifo->minLen / SWITCH_QUEUE_FLOW_CTRL_THRSLD_UNIT));
            if (BCM_ERR_OK != ret) {
                break;
            }
        }
    }
err_exit:
    ETHSWT_REPORT_ERR(ret, aID, line,
        BRCM_SWDSGN_ETHSWT_DRV_PORT_FLOW_CNTRL_CONFIG_PROC, 0UL, 0UL, 0UL)
    return ret;
}

/**
    @brief Port config

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aID             Index
    @param[in]      aConfig         Pointer to configuration

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @return     Others                 As returned by #ETHSWT_DrvSetPortJumboMode or
                                        by #ETHSWT_DrvSetPortRole or #ETHSWT_DrvEnablePort
    @retval     #BCM_ERR_INVAL_PARAMS   Port count is invalid

    @post None

    @trace #BRCM_SWARCH_ETHSWT_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_EXT
 */
static int32_t ETHSWT_DrvPortConfig(ETHSWT_HwIDType aID,
        const ETHSWT_CfgType * const aConfig)
{
    uint32_t line = __LINE__;
    uint32_t i;
    const ETHSWT_PortCfgType *portCfg;
    int32_t ret = BCM_ERR_OK;
    uint32_t hostPortCnt = 0UL;
    uint32_t uplinkPortCnt = 0UL;
    uint32_t uplinkPortMap[ETHSWT_PORT_ID_MAX] = {0};

    for (i = 0UL; i < aConfig->portCfgListSz; i++) {
        portCfg = &aConfig->portCfgList[i];
#ifdef ENABLE_ETHSWT_XCVR
        ret = ETHSWT_DrvSetPortJumboMode(aID, portCfg->portID,
                (ETHXCVR_BooleanType)((portCfg->enableJumboFrm == TRUE) ?
                ETHXCVR_BOOLEAN_TRUE: ETHXCVR_BOOLEAN_FALSE));
        if (ret != BCM_ERR_OK) {
            break;
        }
#endif
        if (ETHSWT_PORT_HOST == portCfg->role) {
            hostPortCnt++;
        } else {
            if (ETHSWT_PORT_UP_LINK == portCfg->role) {
                if (SWITCH_LIGHTSTACK_SLAVES_PORT_TO_MASTER
                        != portCfg->portID) {
                    uplinkPortMap[uplinkPortCnt] = portCfg->portID;
                    uplinkPortCnt++;
                }
            }
        }

        ret = ETHSWT_DrvSetPortRole(aID, aConfig->switchType,
                                    portCfg->portID, portCfg->role);
        if (ret != BCM_ERR_OK) {
            break;
        }

        ret = ETHSWT_DrvEnablePort(aID, portCfg->portID);
        if (ret != BCM_ERR_OK) {
            break;
        }
        ETHSWT_DrvData.enableTimeStamp[portCfg->portID] = portCfg->enableTimeStamp;
    }

    ETHSWT_CHECK_ERR(ret, &line, err_exit)

    /* Verify Port Role */
    if (ETHSWT_SWITCH_LIGHTSTACK_MASTER == aConfig->switchType) {
        if ((hostPortCnt > 1UL)
                || (0UL == uplinkPortCnt)
                || (uplinkPortCnt > SWITCH_LIGHTSTACK_UPLINK_PORT_CNT)) {
            ret = BCM_ERR_INVAL_PARAMS;
            line = __LINE__;
            goto err_exit;
        }
    } else if (ETHSWT_SWITCH_LIGHTSTACK_SLAVE == aConfig->switchType) {
        if (uplinkPortCnt >= (SWITCH_LIGHTSTACK_UPLINK_PORT_CNT)
                    || (0UL != hostPortCnt)) {
            ret = BCM_ERR_INVAL_PARAMS;
            line = __LINE__;
            goto err_exit;
        }
    } else {
        if ((hostPortCnt > 1UL) || (0UL != uplinkPortCnt)) {
            ret = BCM_ERR_INVAL_PARAMS;
            line = __LINE__;
            goto err_exit;
        }
    }

    ret = ETHSWT_DrvSetSwitchType(aID, aConfig->switchType, uplinkPortCnt, uplinkPortMap);

err_exit:
    ETHSWT_REPORT_ERR(ret, aID, line,
        BRCM_SWDSGN_ETHSWT_DRV_PORT_CONFIG_PROC, 0UL, 0UL, 0UL)
    return ret;
}

/**
    @brief Port scheduler configuration

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aID             Index
    @param[in]      aPortCfg        Pointer to port configuration

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success

    @post None

    @trace #BRCM_SWARCH_ETHSWT_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_EXT
 */
static int32_t ETHSWT_DrvPortSchConfig(ETHSWT_HwIDType aID,
        const ETHSWT_PortCfgType *const aPortCfg)
{
    uint32_t line;
    uint32_t i;
    uint32_t schSel;
    uint32_t reg;
    uint32_t portRegAddr;
    int32_t ret = BCM_ERR_OK;

    /* fetch the last SP index */
    for (i = 0; i < SWITCH_COS_QUEUE_MAX + 1UL; i++) {
        if (aPortCfg->egressCfg.scheduler.algo[i] == ETHSWT_SCHED_ALGO_SP) {
            break;
        }
    }

    if (i == 0UL) {
        schSel = 0x0UL;
    } else if ((i > 3UL) && (i <= SWITCH_COS_QUEUE_MAX)) {
        schSel = (SWITCH_COS_QUEUE_MAX - i + 1UL);
    } else {
        schSel = 0x5UL;
    }
    portRegAddr = SWITCH_M46_PN_QOS_PRI_CTL_PORT0 + aPortCfg->portID * 1UL;

    ret = ETHSWT_DrvReadReg32(aID, portRegAddr, &reg);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    reg &= ~SWITCH_SCHED_PN_QOS_PRI_CTL_SCHEDULER_SELECT_MASK;
    reg |= schSel;
    if (i > 0UL) {
        if (aPortCfg->egressCfg.scheduler.algo[i - 1UL] == ETHSWT_SCHED_ALGO_WRR) {
            reg |= SWITCH_SCHED_PN_QOS_PRI_CTL_WDRR_GRANULARITY_MASK;
        } else {
            reg &= ~SWITCH_SCHED_PN_QOS_PRI_CTL_WDRR_GRANULARITY_MASK;
        }
    }
    ret = ETHSWT_DrvWriteReg32(aID, portRegAddr, reg);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)

err_exit:
    ETHSWT_REPORT_ERR(ret, aID, line,
        BRCM_SWDSGN_ETHSWT_DRV_PORT_SCH_CONFIG_PROC, 0UL, 0UL, 0UL)
    return ret;
}

/**
    @brief Egress configuration

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aID             Index
    @param[in]      aConfig         Pointer to configuration

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success

    @post None

    @trace #BRCM_SWARCH_ETHSWT_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_EXT
 */
static int32_t ETHSWT_DrvEgressConfig(ETHSWT_HwIDType aID,
        const ETHSWT_CfgType * const aConfig)
{
    uint32_t i;
    const ETHSWT_PortCfgType *portCfg;
    int32_t ret = BCM_ERR_OK;

    for (i = 0UL; i < aConfig->portCfgListSz; i++) {
        portCfg = &aConfig->portCfgList[i];
        /* configure the scheduler */
        ret = ETHSWT_DrvPortSchConfig(aID, portCfg);
        if (BCM_ERR_OK != ret) {
            break;
        }
        /* configure the queue shapers */
        ret = ETHSWT_DrvQueueShaperConfig(aID, portCfg);
        if (BCM_ERR_OK != ret) {
            break;
        }
        /* configure the reserve threshold register */
        ret = ETHSWT_DrvPortFlowCntrlConfig(aID, portCfg);
        if (BCM_ERR_OK != ret) {
            break;
        }
        /* configure the port shaper */
        ret = ETHSWT_DrvPortShaperConfig(aID, portCfg->portID, &portCfg->egressCfg.portShaper);
        if (BCM_ERR_OK != ret) {
            break;
        }
    }
    return ret;
}

/**
    @brief Ingress configuration

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aID             Index
    @param[in]      aConfig         Pointer to configuration

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @return     Others                  As returned by #ETHSWT_DrvQoSConfig

    @post None

    @trace #BRCM_SWARCH_ETHSWT_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_EXT
 */
static int32_t ETHSWT_DrvIngressConfig(ETHSWT_HwIDType aID,
        const ETHSWT_CfgType * const aConfig)
{
    uint32_t i;
    const ETHSWT_PortCfgType *portCfg;
    const ETHSWT_PortIngressCfgType *ingress;
    uint32_t reg;
    uint32_t portRegAddr;
    int32_t ret = BCM_ERR_OK;

    for (i = 0UL; i < aConfig->portCfgListSz; i++) {
        portCfg = &aConfig->portCfgList[i];
        ingress = &portCfg->ingressCfg;

        /* if configured drop all untagged packet on this port */
        if (ingress->dropUntagged == TRUE) {
            ret = ETHSWT_DrvReadReg32(aID, (uint32_t)&ETHSWT_Regs->m34_vlan_ctrl3,
                        &reg);
            if (BCM_ERR_OK != ret) {
                break;
            }
            reg |= (uint32_t)ETHSWT_PORTID2HWMASK(portCfg->portID);
            ret = ETHSWT_DrvWriteReg32(aID, (uint32_t)&ETHSWT_Regs->m34_vlan_ctrl3,
                        reg);
            if (BCM_ERR_OK != ret) {
                break;
            }
        } else {
            portRegAddr = SWITCH_M34_DEFAULT_1Q_TAG_PORT0 +
                portCfg->portID * 2UL;
            reg = (uint32_t)(ingress->defaultVLAN << SWITCH_DEFAULT_1Q_TAG_VID_0_SHIFT) &
                SWITCH_DEFAULT_1Q_TAG_VID_0_MASK;
            reg |= (uint32_t)(ingress->defaultPrio << SWITCH_DEFAULT_1Q_TAG_PRI_0_SHIFT) &
                SWITCH_DEFAULT_1Q_TAG_PRI_0_MASK;
            ret = ETHSWT_DrvWriteReg32(aID, portRegAddr, reg);
            if (BCM_ERR_OK != ret) {
                break;
            }
        }

        /* configure the per port QoS paramters */
        ret = ETHSWT_DrvQoSConfig(aID, portCfg);
        if (ret != BCM_ERR_OK) {
            break;
        }
    }
    return ret;
}

/**
    @brief Verify egress configuration

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aID             ID
    @param[in]      aPortCfg        Pointer to port configuration

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @retval     #BCM_ERR_INVAL_PARAMS   If egress has invalid params

    @post None

    @trace #BRCM_SWARCH_ETHSWT_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_EXT
 */
static int32_t ETHSWT_DrvVerifyEgressConfig(ETHSWT_HwIDType aID,
        const ETHSWT_PortCfgType * const aPortCfg)
{
    uint32_t line;
    uint32_t i;
    const ETHSWT_FifoCfgType *fifo;
    int32_t ret = BCM_ERR_OK;
    const ETHSWT_PortEgressCfgType *const egress = &aPortCfg->egressCfg;

    for (i = 0UL; i < ETHSWT_PORT_FIFO_MAX; i++) {
        if (egress->scheduler.algo[i] > ETHSWT_SCHED_ALGO_DRR) {
            ret = BCM_ERR_INVAL_PARAMS;
            break;
        }
    }

    ETHSWT_CHECK_ERR(ret, &line, err_exit)

    for (i = 0UL; i < egress->fifoListSz; i++) {
        fifo = &egress->fifoList[i];
        if (fifo->id > SWITCH_COS_QUEUE_MAX) {
            break;
        }
        if ((fifo->minLen % SWITCH_QUEUE_FLOW_CTRL_THRSLD_UNIT) != 0UL) {
            break;
        }
        if (fifo->tc > ETHSWT_TC_7) {
            break;
        }
        if ((fifo->shaper.rateBps % SWITCH_SHAPER_BIT_RATE_PER_TOKEN) != 0UL) {
            break;
        }
        if ((fifo->shaper.rateBps != 0UL) && (fifo->shaper.burstBytes == 0UL)) {
            break;
        }
    }
    if ((i > 0UL) && (i < egress->fifoListSz)) {
        line = __LINE__;
        ret = BCM_ERR_INVAL_PARAMS;
    } else {
        if (egress->portShaper.rateBps != 0UL) {
            if (((egress->portShaper.rateBps % SWITCH_SHAPER_BIT_RATE_PER_TOKEN) != 0UL) ||
                    (egress->portShaper.burstBytes == 0UL)) {
                ret = BCM_ERR_INVAL_PARAMS;
                line = __LINE__;
            }
        }
    }

err_exit:
    ETHSWT_REPORT_ERR(ret, aID, line,
        BRCM_SWDSGN_ETHSWT_DRV_VERIFY_EGRESS_CONFIG_PROC, 0UL, 0UL, 0UL)
    return ret;
}

/**
    @brief Verify Ingress configuration

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aID             ID
    @param[in]      aPortCfg        Pointer to port configuration

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @retval     #BCM_ERR_INVAL_PARAMS   If ingress has invalid params

    @post None

    @trace #BRCM_SWARCH_ETHSWT_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_EXT
 */
static int32_t ETHSWT_DrvVerifyIngressConfig(ETHSWT_HwIDType aID,
        const ETHSWT_PortCfgType * const aPortCfg)
{
    uint32_t defaultVlanEn = FALSE;
    int32_t ret = BCM_ERR_OK;
    uint32_t i;

    const ETHSWT_PortIngressCfgType *ingress = &aPortCfg->ingressCfg;

    if ((ingress->defaultVLAN >= ETHER_VLANID_MIN) &&
            (ingress->defaultVLAN <= ETHER_VLANID_MAX)) {
        defaultVlanEn = TRUE;
    }

    /* The truth table looks as follows:            */
    /*  ------------------------------------------- */
    /*  | DropUntagged | defaultVlanEn  |  Valid? | */
    /*  ------------------------------------------- */
    /*  |     1        |     1          |    0    | */
    /*  |     1        |     0          |    1    | */
    /*  |     0        |     1          |    1    | */
    /*  |     0        |     0          |    0    | */
    /*  ------------------------------------------- */
    if (ingress->dropUntagged == defaultVlanEn) {
        ret = BCM_ERR_INVAL_PARAMS;
        goto err_exit;
    }

    if (ingress->tc > ETHSWT_TC_7) {
        for (i = 0UL; i < 8UL; i++) {
            if (ingress->pcp2tcMap[i] > ETHSWT_TC_7) {
                break;
            }
        }
        if (i < 8UL) {
            ret = BCM_ERR_INVAL_PARAMS;
            goto err_exit;
        }
    }
err_exit:
    return ret;
}

/** @brief Switch driver Initialization

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aID                 Switch Index
    @param[in]      aConfig             Pointer to configuration structure
    @param[inout]   aPort2TimeFifoMap   Port to time fifo map

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @retval     #BCM_ERR_INVAL_PARAMS   (aID is invalid) or
                                        (aConfig is NULL) or
                                        (switch type is invalid) or
                                        (port ID is invalid) or
                                        (role is invalid) or
                                        (MAC address list size is invalid) or
                                        (VLAN mem list size is invalid) or
                                        (VLAN ID is invalid) or
                                        (default priority is invalid) or
                                        (forward is invalid)

    @post None

    @trace #BRCM_SWARCH_ETHSWT_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_EXT
*/
static int ETHSWT_DrvExtConfigure(ETHSWT_HwIDType aID,
        const ETHSWT_CfgType *const aConfig, uint32_t *const aPort2TimeFifoMap)
{
    uint32_t line = __LINE__;
    uint32_t i;
    uint32_t j;
    int32_t ret = BCM_ERR_OK;
    const ETHSWT_PortCfgType *portCfg;
    uint32_t portLedEnMask = 0UL;
    uint32_t reg = 0UL;

    if ((aID >= SWITCH_MAX_HW_ID)
#ifdef ENABLE_ETHSWT_TIME
        || (NULL == aPort2TimeFifoMap)
#endif
        || (NULL == aConfig)) {
        ret = BCM_ERR_INVAL_PARAMS;
        line = __LINE__;
        goto err_exit;
    }

    /* Disable Link status interrupt for all the ports */
    ret = ETHSWT_DrvWriteReg16(aID, (uint32_t)&ETHSWT_Regs->m03_link_sts_int_en, 0x0U);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)

    if ((ETHSWT_SWITCH_STANDARD != aConfig->switchType)
            && (ETHSWT_SWITCH_LIGHTSTACK_MASTER != aConfig->switchType)
            && (ETHSWT_SWITCH_LIGHTSTACK_SLAVE != aConfig->switchType)) {
        ret = BCM_ERR_INVAL_PARAMS;
        line = __LINE__;
        goto err_exit;
    }

    /* verify the configuration first */
    for (i = 0UL; i < aConfig->portCfgListSz; i++) {
        ret = BCM_ERR_INVAL_PARAMS;
        portCfg = &aConfig->portCfgList[i];
        if (portCfg->portID >= ETHSWT_PORT_ID_MAX) {
            break;
        }
        if ((portCfg->role != ETHSWT_PORT_STANDARD)
                && (portCfg->role != ETHSWT_PORT_HOST)
                && (portCfg->role != ETHSWT_PORT_UP_LINK)) {
            break;
        }
        if (portCfg->macAddrListSz > ETHSWT_PORT_MAC_ENTRY_MAX) {
            break;
        }
        if (portCfg->vlanMemListSz > ETHSWT_PORT_VLAN_ENTRY_MAX) {
            break;
        }
        for (j = 0UL; j < portCfg->vlanMemListSz; j++) {
            if ((portCfg->vlanMemList[j].vlanID < ETHER_VLANID_MIN) ||
                    (portCfg->vlanMemList[j].vlanID > ETHER_VLANID_MAX)) {
                break;
            }
            if (portCfg->vlanMemList[j].defaultPri > ETHSWT_PCP_7) {
                break;
            }
            if (portCfg->vlanMemList[j].forward > ETHSWT_VLAN_FRWRD_UNTAGGED) {
                break;
            }
        }
        if ((portCfg->vlanMemListSz > 0UL) && (j < portCfg->vlanMemListSz)) {
            break;
        }
        ret = ETHSWT_DrvVerifyIngressConfig(aID, portCfg);
        if (BCM_ERR_OK != ret) {
            break;
        }
        ret = ETHSWT_DrvVerifyEgressConfig(aID, portCfg);
        if (BCM_ERR_OK != ret) {
            break;
        }
        portLedEnMask |= (0x1UL << portCfg->portID);
#ifdef ENABLE_ETHSWT_XCVR
        ret = ETHSWT_DrvSetXcvrID(aID, portCfg->portID, portCfg->xcvrID);
        if (BCM_ERR_OK != ret) {
            break;
        }
#endif

        /* configure ARL table and VLAN tables */
#ifdef ENABLE_ETHSWT_TCAM
        ret = ETHSWT_DrvArlTcamInit(aID);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
#endif
#ifdef ENABLE_ETHSWT_ARL
        ret = ETHSWT_DrvARLTblConfig(aID, aConfig);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
#endif
#ifdef ENABLE_ETHSWT_VLAN
        ret = ETHSWT_DrvVLANTblConfig(aID, aConfig);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
#endif
        ret = ETHSWT_DrvIngressConfig(aID, aConfig);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
        ret = ETHSWT_DrvEgressConfig(aID, aConfig);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
        ret = ETHSWT_DrvPortConfig(aID, aConfig);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
        ret = ETHSWT_DrvSetBrcmHdrMode(aID, aConfig->brcmHdrMode);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)

        /* Now that all configurations are applied, enable LED's */
        reg = (SWITCH_CTRL_LED_FUNC1_AVB_LINK_MASK
            | SWITCH_CTRL_LED_FUNC1_SPD1G_MASK
            | SWITCH_CTRL_LED_FUNC1_SPD10M_MASK
            | SWITCH_CTRL_LED_FUNC1_LNK_ACT_MASK);
        ret = ETHSWT_DrvWriteReg32(aID, (uint32_t)&ETHSWT_Regs->m00_led_func1_ctl, reg);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)

        ret = ETHSWT_DrvReadReg32(aID, (uint32_t)&ETHSWT_Regs->m00_led_en_map, &reg);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
        reg &= ~SWITCH_CTRL_LED_EN_MAP_MASK;
        reg |= (portLedEnMask & SWITCH_CTRL_LED_EN_MAP_MASK);
        ret = ETHSWT_DrvWriteReg32(aID, (uint32_t)&ETHSWT_Regs->m00_led_en_map, reg);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)

        /* Enable Link status interrupt for all the ports except port7 */
        ret = ETHSWT_DrvWriteReg32(aID, (uint32_t)&ETHSWT_Regs->m03_link_sts_int_en,
                                    SWITCH_LNK_STS_INT_EN_PORT_XLD7_MASK);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
    }
#ifdef ENABLE_ETHSWT_TIME
    BCM_MemCpy(ETHSWT_DrvData.port2TimeFifoMap, aPort2TimeFifoMap,
            sizeof(uint32_t) * ETHSWT_PORT_ID_MAX);
#endif

err_exit:
    ETHSWT_REPORT_ERR(ret, aID, line,
        BRCM_SWDSGN_ETHSWT_DRV_EXT_CONFIG_PROC, 0UL, 0UL, 0UL)
    return ret;
}

#ifdef ENABLE_ETHSWT_SECURITY
/**
    @brief Set the security configurations

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aSwtID          Index
    @param[in]      aConfig         Pointer to configuration

    Return values are documented in reverse-chronological order
    @retval   #BCM_ERR_INVAL_PARAMS   Invalid parameter
    @retval   #BCM_ERR_TIME_OUT       Timeout occurred while reading/writing
                                      switch register
    @retval   #BCM_ERR_OK             On Success

    @post None
    @code{.c}
    ret = ERR_OK
    ret = ETHSWT_SetTotalAddrLimit(aSwtID,
                      aConfig->globalSecurityCfg.totalMACLearningLimit);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    ret = ETHSWT_SetVlanHoppingDetection(aSwtID,
             aConfig->globalSecurityCfg.vlanHoppingAction);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)

    for (i = 0; i < aConfig->portCfgListSz; i++) {
        portCfg = &aConfig->portCfgList[i];
        security = &portCfg->securityCfg;
        ret = ETHSWT_SetStationMovementDetection(aSwtID,
                                                   portCfg->portID,
                                       security->stationMoveAction);
        if (BCM_ERR_OK != ret) {
            break;
        }
        ret = ETHSWT_SetPortAddrLimiting(aSwtID,
                                                   portCfg->portID,
                                      &security->addressLimit);
        if (BCM_ERR_OK != ret) {
            break;
        }

        ret = ETHSWT_SetMACAddressStickyToPort(aSwtID,
                                                   portCfg->portID,
                                       security->stickyMACAction);
        if (BCM_ERR_OK != ret) {
            break;
        }
    }
err_exit:
    ETHSWT_REPORT_ERR( ret, aSwtID, line,
        BRCM_SWDSGN_ETHSWT_SECURITY_CONFIG_PROC, 0UL, 0UL, 0UL)
    return ret;
    @endcode

    @trace #BRCM_SWARCH_ETHSWT_INIT_PROC
    @trace #BRCM_SWREQ_ETHSWT_EXT
*/
static int32_t ETHSWT_SecurityConfig(ETHSWT_HwIDType aSwtID,
        const ETHSWT_CfgType *const aConfig)
{
    uint32_t line = __LINE__;
    uint32_t i;
    const ETHSWT_PortCfgType *portCfg;
    const ETHSWT_PortSecurityCfgType *security;
    int32_t ret = BCM_ERR_OK;

        /* configure the total mac learning limit */
    ret = ETHSWT_SetTotalAddrLimit(aSwtID,
                      aConfig->globalSecurityCfg.totalMACLearningLimit);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
        /* configure the vlan hopping detection */
    ret = ETHSWT_SetVlanHoppingDetection(aSwtID,
            aConfig->globalSecurityCfg.vlanHoppingAction);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)

    for (i = 0UL; i < aConfig->portCfgListSz; i++) {
        portCfg = &aConfig->portCfgList[i];
        security = &portCfg->securityCfg;
        /* configure the station movement */
        ret = ETHSWT_SetStationMovementDetection(aSwtID,
                                                   portCfg->portID,
                                      security->stationMoveAction);
        if (BCM_ERR_OK != ret) {
            break;
        }
        /* configure the address limiting */
        ret = ETHSWT_SetPortAddrLimiting(aSwtID,
                                                   portCfg->portID,
                                      &security->addressLimit);
        if (BCM_ERR_OK != ret) {
            break;
        }
        /* configure the sticky mac address */
        ret = ETHSWT_SetMACAddressStickyToPort(aSwtID,
                                                   portCfg->portID,
                                       security->stickyMACAction);
        if (BCM_ERR_OK != ret) {
            break;
        }
    }

err_exit:
    ETHSWT_REPORT_ERR( ret, aSwtID, line,
        BRCM_SWDSGN_ETHSWT_SECURITY_CONFIG_PROC, 0UL, 0UL, 0UL)
    return ret;
}
#endif /* ENABLE_ETHSWT_SECURITY */

/**
    @brief Port Shaper configuration

    @trace #BRCM_SWARCH_ETHSWT_PORT_SHAPER_CONFIG_PROC
    @trace #BRCM_SWREQ_ETHSWT_EXT
*/
void ETHSWT_PortShaperConfig(ETHSWT_HwIDType aSwtID,
                             ETHSWT_PortIDType aPortID,
                             const ETHSWT_ShaperCfgType *const aShaperCfg)
{
    ETHSWT_IOType swtIO;
    ETHSWT_ExtIOType extIO;
    int32_t ret = BCM_ERR_OK;

    if (aSwtID < SWITCH_MAX_HW_ID) {
        swtIO.extIO = &extIO;
        extIO.shaperCfg = aShaperCfg;
        extIO.portID = aPortID;
        swtIO.retVal = BCM_ERR_UNKNOWN;
        swtIO.swtHwID = aSwtID;
        ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_PORT_SHAPER_CONFIG, &swtIO);
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }

    if (ret != BCM_ERR_OK) {
        ETHSWT_DrvReportError((BCM_SWT_ID & BCM_LOGMASK_USER), (uint8_t)aSwtID,
                BRCM_SWARCH_ETHSWT_PORT_SHAPER_CONFIG_PROC, ret, aPortID, 0UL, 0UL, __LINE__);
    }
}

/**
    @brief Switch Initialization

    @trace #BRCM_SWARCH_ETHSWT_INIT_PROC
    @trace #BRCM_SWREQ_ETHSWT_EXT
*/
void ETHSWT_ExtConfigure(ETHSWT_HwIDType aSwtID,
        const ETHSWT_CfgType *const aConfig)
{
    ETHSWT_IOType swtIO;
    ETHSWT_ExtIOType extIO;
    int32_t ret = BCM_ERR_OK;
    uint32_t port2TimeFifoMap[ETHSWT_PORT_ID_MAX];

    if (aSwtID < SWITCH_MAX_HW_ID) {
        ret = MCU_GetSwitchPort2TimeFifoMap(port2TimeFifoMap);
        if (BCM_ERR_OK == ret) {
            swtIO.extIO = &extIO;
            extIO.cfg = aConfig;
            extIO.port2TimeFifoMap = &port2TimeFifoMap[0UL];
            swtIO.retVal = BCM_ERR_UNKNOWN;
            swtIO.swtHwID = aSwtID;
            ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_EXT_CONFIG, &swtIO);
#ifdef ENABLE_ETHSWT_SECURITY
            if (ret == BCM_ERR_OK) {
                ret = ETHSWT_SecurityConfig(aSwtID, aConfig);
            }
#endif /* ENABLE_ETHSWT_SECURITY */
#ifdef ENABLE_ETHSWT_IPG_SHRINK
            if (ret == BCM_ERR_OK) {
                ret = ETHSWT_IPGConfig(aSwtID);
            }
#endif /* ENABLE_ETHSWT_IPG_SHRINK */
        }
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }

    if (ret != BCM_ERR_OK) {
        ETHSWT_DrvReportError((BCM_SWT_ID & BCM_LOGMASK_USER), (uint8_t)aSwtID,
                BRCM_SWARCH_ETHSWT_EXT_CONFIG_PROC, ret, 0UL, 0UL, 0UL, __LINE__);
    }
}

/**
    @brief Switch command handler

    @trace #BRCM_SWARCH_ETHSWT_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_EXT
*/
int32_t ETHSWT_ExtCmdHandler(ETHSWT_HwIDType aSwtHwID,
                                ETHSWT_IOCmdType aCmd,
                                ETHSWT_ExtIOType *const aIO)
{
    int32_t ret = BCM_ERR_NOSUPPORT;
    switch (aCmd) {
    case ETHSWT_IO_CMD_EXT_CONFIG:
        ret = ETHSWT_DrvExtConfigure(aSwtHwID, aIO->cfg, aIO->port2TimeFifoMap);
        break;
    case ETHSWT_IO_CMD_PORT_SHAPER_CONFIG:
        ret = ETHSWT_DrvPortShaperConfig(aSwtHwID, aIO->portID, aIO->shaperCfg);
        break;
    default:
        ret = BCM_ERR_NOSUPPORT;
        ETHSWT_DrvReportError(BCM_SWT_ID, (uint8_t)aSwtHwID,
                BRCM_SWDSGN_ETHSWT_EXT_CMD_HANDLER_PROC, ret, aCmd, 0UL, 0UL, __LINE__);
        break;
    }
    return ret;
}
/** @} */
