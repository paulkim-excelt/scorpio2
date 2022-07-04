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

    @file switch_arl.c

    @brief Ethernet switch ARL functionality

    @version 0.1 Initial version
*/
#include <switch_rdb.h>
#include <bcm_utils.h>
#include <bcm_err.h>
#include <eth_switch.h>
#include <ethswt_arl_osil.h>
#include <ethswt_vlan_osil.h>
#include <eth_switch_osil.h>
#include "switch_drv.h"
#include "switch_cfg.h"

/**
    @name Ethernet switch Design ID's
    @{
    @brief Ethernet switch Design ID's
*/
#define BRCM_SWDSGN_ETHSWT_DRV_ARL_TBL_SEARCH_BY_ADDR_PROC          (0xB901U)    /**< @brief #ETHSWT_DrvARLTblSearchByAddr          */
#define BRCM_SWDSGN_ETHSWT_DRV_ARL_TBL_ADD_ENTRY_PROC               (0xB902U)    /**< @brief #ETHSWT_DrvARLTblAddEntry              */
#define BRCM_SWDSGN_ETHSWT_DRV_GET_PORT_MAC_ADDR_PROC               (0xB903U)    /**< @brief #ETHSWT_DrvGetPortMacAddr              */
#define BRCM_SWDSGN_ETHSWT_DRV_SET_MAC_LEARNING_MODE_PROC           (0xB904U)    /**< @brief #ETHSWT_DrvSetMACLearningMode          */
#define BRCM_SWDSGN_ETHSWT_DRV_GET_MAC_LEARNING_MODE_PROC           (0xB905U)    /**< @brief #ETHSWT_DrvGetMACLearningMode          */
#define BRCM_SWDSGN_ETHSWT_DRV_ARL_TBL_DELETE_ENTRY_PROC            (0xB906U)    /**< @brief #ETHSWT_DrvARLTblDeleteEntry           */
#define BRCM_SWDSGN_ETHSWT_DRV_IS_ARL_ENTRY_INIT_CONFIG_PROC        (0xB907U)    /**< @brief #ETHSWT_DrvIsARLEntryInitConfig        */
#define BRCM_SWDSGN_ETHSWT_DRV_GET_ARL_TABLE_PROC                   (0xB908U)    /**< @brief #ETHSWT_DrvGetARLTable                 */
#define BRCM_SWDSGN_ETHSWT_DRV_ADD_ARL_ENTRY_PROC                   (0xB909U)    /**< @brief #ETHSWT_DrvAddARLEntry                 */
#define BRCM_SWDSGN_ETHSWT_DRV_DELETE_ARL_ENTRY_PROC                (0xB90AU)    /**< @brief #ETHSWT_DrvDeleteARLEntry              */
#define BRCM_SWDSGN_ETHSWT_DRV_ADD_ARL_MYDA_ENTRY_PROC              (0xB90BU)    /**< @brief #ETHSWT_DrvAddARLMyDAEntry             */
#define BRCM_SWDSGN_ETHSWT_DRV_DELETE_ARL_MYDA_ENTRY_PROC           (0xB90CU)    /**< @brief #ETHSWT_DrvDeleteARLMyDAEntry          */
#define BRCM_SWDSGN_ETHSWT_DRV_GET_ARL_MYDA_SNAPSHOT_PROC           (0xB90DU)    /**< @brief #ETHSWT_DrvGetARLMyDASnapshot          */
#define BRCM_SWDSGN_ETHSWT_DRV_SET_AGE_PROC                         (0xB90EU)    /**< @brief #ETHSWT_DrvSetAge                      */
#define BRCM_SWDSGN_ETHSWT_DRV_GET_AGE_PROC                         (0xB90FU)    /**< @brief #ETHSWT_DrvGetAge                      */
#define BRCM_SWDSGN_ETHSWT_ARL_CMD_HANDLER_PROC                     (0xB910U)    /**< @brief #ETHSWT_ARLCmdHandler                  */
#define BRCM_SWDSGN_ETHSWT_ARL_REGS_GLOBAL                          (0xB911U)    /**< @brief #ETHSWT_ARLRegs                        */
#define BRCM_SWDSGN_ETHSWT_ARL_TBL_MACRO                            (0xB912U)    /**< @brief #ETHSWT_ARL_TBL_CMD_READ               */
#define BRCM_SWDSGN_ETHSWT_SET_AGE_PROC                             (0xB913U)    /**< @brief #ETHSWT_SetAge                         */
#define BRCM_SWDSGN_ETHSWT_GET_AGE_PROC                             (0xB914U)    /**< @brief #ETHSWT_GetAge                         */
#define BRCM_SWDSGN_ETHSWT_ADD_ARL_ENTRY_PROC                       (0xB915U)    /**< @brief #ETHSWT_AddARLEntry                    */
#define BRCM_SWDSGN_ETHSWT_DELETE_ARL_ENTRY_PROC                    (0xB916U)    /**< @brief #ETHSWT_DeleteARLEntry                 */
#define BRCM_SWDSGN_ETHSWT_GET_ARL_TABLE_PROC                       (0xB917U)    /**< @brief #ETHSWT_GetARLTable                    */
#define BRCM_SWDSGN_ETHSWT_GET_PORT_MAC_ADDR_PROC                   (0xB918U)    /**< @brief #ETHSWT_GetPortMacAddr                 */
#define BRCM_SWDSGN_ETHSWT_SET_MAC_LEARNING_MODE_PROC               (0xB919U)    /**< @brief #ETHSWT_SetMACLearningMode             */
#define BRCM_SWDSGN_ETHSWT_GET_MAC_LEARNING_MODE_PROC               (0xB91AU)    /**< @brief #ETHSWT_GetMACLearningMode             */
#define BRCM_SWDSGN_ETHSWT_ADD_ARL_MYDA_ENTRY_PROC                  (0xB91BU)    /**< @brief #ETHSWT_AddARLMyDAEntry                */
#define BRCM_SWDSGN_ETHSWT_DELETE_ARL_MYDA_ENTRY_PROC               (0xB91CU)    /**< @brief #ETHSWT_DeleteARLMyDAEntry             */
#define BRCM_SWDSGN_ETHSWT_GET_ARL_MYDA_SNAPSHOT_PROC               (0xB91DU)    /**< @brief #ETHSWT_GetARLMyDASnapshot             */
#define BRCM_SWDSGN_ETHSWT_DRV_SET_STATIONMOVEMENTDETECTION_PROC    (0xB91EU)    /**< @brief #ETHSWT_DrvSetStationMovementDetection */
#define BRCM_SWDSGN_ETHSWT_DRV_GET_STATIONMOVEMENTDETECTION_PROC    (0xB91FU)    /**< @brief #ETHSWT_DrvGetStationMovementDetection */
#define BRCM_SWDSGN_ETHSWT_DRV_SET_PORT_ADDRESS_LIMITING_PROC       (0xB920U)    /**< @brief #ETHSWT_DrvSetPortAddressLimiting      */
#define BRCM_SWDSGN_ETHSWT_DRV_GET_ADDR_LIMIT_AND_COUNTER_PROC      (0xB921U)    /**< @brief #ETHSWT_DrvGetPortAddrLimitAndCounter  */
#define BRCM_SWDSGN_ETHSWT_DRV_SET_MACADDRESSSTICKYTOPORT_PROC      (0xB922U)    /**< @brief #ETHSWT_DrvSetMACAddressStickyToPort   */
#define BRCM_SWDSGN_ETHSWT_DRV_GET_MACADDRESSSTICKYTOPORT_PROC      (0xB923U)    /**< @brief #ETHSWT_DrvGetMACAddressStickyToPort   */
#define BRCM_SWDSGN_ETHSWT_DRV_SET_TOTALADDRESSLIMIT_PROC           (0xB924U)    /**< @brief #ETHSWT_DrvSetTotalAddressLimit        */
#define BRCM_SWDSGN_ETHSWT_DRV_GET_TOTALADDRLIMITANDCOUNTER_PROC    (0xB925U)    /**< @brief #ETHSWT_DrvGetTotalAddrLimitAndCounter */
#define BRCM_SWDSGN_ETHSWT_SET_STATIONMOVEMENTDETECTION_PROC        (0xB926U)    /**< @brief #ETHSWT_SetStationMovementDetection    */
#define BRCM_SWDSGN_ETHSWT_GET_STATIONMOVEMENTDETECTION_PROC        (0xB927U)    /**< @brief #ETHSWT_GetStationMovementDetection    */
#define BRCM_SWDSGN_ETHSWT_SET_PORT_ADDRLIMITING_PROC               (0xB928U)    /**< @brief #ETHSWT_SetPortAddrLimiting            */
#define BRCM_SWDSGN_ETHSWT_GET_PORTADDRLIMITANDCOUNTER_PROC         (0xB929U)    /**< @brief #ETHSWT_GetPortAddrLimitAndCounter     */
#define BRCM_SWDSGN_ETHSWT_SET_MACADDRESSSTICKYTOPORT_PROC          (0xB92AU)    /**< @brief #ETHSWT_SetMACAddressStickyToPort      */
#define BRCM_SWDSGN_ETHSWT_GET_MACADDRESSSTICKYTOPORT_PROC          (0xB92BU)    /**< @brief #ETHSWT_GetMACAddressStickyToPort      */
#define BRCM_SWDSGN_ETHSWT_SET_TOTALADDRLIMIT_PROC                  (0xB92CU)    /**< @brief #ETHSWT_SetTotalAddrLimit              */
#define BRCM_SWDSGN_ETHSWT_GET_TOTALADDRLIMITANDCOUNTER_PROC        (0xB92DU)    /**< @brief #ETHSWT_GetTotalAddrLimitAndCounter    */
#define BRCM_SWDSGN_ETHSWT_DRV_ARL_TCAM_UPDATE_PROC                 (0xB92EU)    /**< @brief #ETHSWT_DrvArlTcamUpdate               */
#define BRCM_SWDSGN_ETHSWT_DRV_ARL_TCAM_SEARCH_BY_ADDR_PROC         (0xB92FU)    /**< @brief #ETHSWT_DrvArlTcamSearchByAddr         */
#define BRCM_SWDSGN_ETHSWT_DRV_ARL_TCAM_RW_PROC                     (0xB930U)    /**< @brief #ETHSWT_DrvArlTcamRW                   */
#define BRCM_SWDSGN_ETHSWT_DRV_ARL_TCAM_ACCESS_TYPE                 (0xB931U)    /**< @brief #ETHSWT_DrvArlTcamAccessType           */
/** @} */

/**
    @name Switch ARL table macros
    @{
    @brief Switch ARL table macros

    @trace #BRCM_SWARCH_ETHSWT_ARL_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_KERNEL_INTERFACE
*/
#define ETHSWT_ARL_TBL_CMD_READ                (0x0UL)
#define ETHSWT_ARL_TBL_CMD_WRITE               (0x1UL)
#define ETHSWT_ARL_TBL_INVAL_BIN_IDX           (0xFFUL)
/** @} */

/**
    @name Access type for ARL-TCAM
    @{
    @brief Access type for ARL-TCAM

    @trace #BRCM_SWARCH_ETHSWT_DRV_ARL_TBL_ADD_ENTRY_PROC
    @trace #BRCM_SWARCH_ETHSWT_ARL_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_KERNEL_INTERFACE
*/
#ifdef ENABLE_ETHSWT_TCAM
typedef uint32_t ETHSWT_DrvArlTcamAccessType;
#define ETHSWT_DRV_ARL_TCAM_ACCESS_READ   (1UL)
#define ETHSWT_DRV_ARL_TCAM_ACCESS_WRITE  (2UL)
#define ETHSWT_DRV_ARL_TCAM_ACCESS_DELETE (3UL)
#endif
/** @} */

/**
    @brief Switch registers

    @trace #BRCM_SWARCH_ETHSWT_ARL_CMD_HANDLER_PROC
    @trace #BRCM_SWARCH_ETHSWT_LINK_IRQ_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_KERNEL_INTERFACE
*/
static SWITCH_RDBType *const ETHSWT_ARLRegs = (SWITCH_RDBType *)SWITCH_BASE;

/**
    @trace #BRCM_SWARCH_ETHSWT_DRV_ARL_TBL_SEARCH_BY_ADDR_PROC
    @trace #BRCM_SWREQ_ETHSWT_KERNEL_INTERFACE
 */
int32_t ETHSWT_DrvARLTblSearchByAddr(ETHSWT_HwIDType aSwtID,
        uint64_t aMACAddr,
        uint32_t aVlanID,
        uint32_t *const aPortMask,
        uint32_t *const aBinIdx)
{
    uint32_t line = __LINE__;
    uint64_t mac;
    uint32_t vid;
    uint8_t reg;
    uint64_t reg64;
    uint32_t i;
    uint32_t macVidAddr;
    uint32_t fwdAddr;
    uint64_t fwdReg;
    uint32_t timeout = 0UL;
    uint32_t matchedEntry = FALSE;

    int ret = BCM_ERR_OK;

    if ((aPortMask == NULL) || (aBinIdx == NULL)) {
        line = __LINE__;
        ret = BCM_ERR_INVAL_PARAMS;
        goto err_exit;
    }

    *aBinIdx = ETHSWT_ARL_TBL_INVAL_BIN_IDX;
    *aPortMask = 0UL;

    /* write the MAC Address index register */
    ret = ETHSWT_DrvWriteReg(aSwtID, SWITCH_PAGE_05_ARLA_MAC,
                aMACAddr & SWITCH_PAGE_05_ARLA_MAC_MAC_ADDR_INDX_MASK);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)

    /* write the VID index register */
    ret = ETHSWT_DrvWriteReg(aSwtID, (uint32_t)&ETHSWT_ARLRegs->arla_regs_union_instance.arla_regs_struct_instance.PAGE_05_ARLA_VID,
                (aVlanID & ETHER_VLANID_MASK));
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    reg = SWITCH_ARLA_RWCTL_ARL_READ;
    reg |= SWITCH_P05AR_PAGE_05_ARLA_RWCTL_ARL_STRTDN_MASK;
    ret = ETHSWT_DrvWriteReg8(aSwtID, (uint32_t)&ETHSWT_ARLRegs->m05_arla_rwctl, reg);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)

    /* wait for STRDN to clear */
    while (timeout < ETHSWT_RDWR_TIMEOUT) {
        ret = ETHSWT_DrvReadReg8(aSwtID, (uint32_t)&ETHSWT_ARLRegs->m05_arla_rwctl, &reg);
        if (BCM_ERR_OK != ret) {
            break;
        }
        if ((reg & SWITCH_P05AR_PAGE_05_ARLA_RWCTL_ARL_STRTDN_MASK) == 0U) {
            break;
        }
        timeout++;
    }

    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    if (timeout == ETHSWT_RDWR_TIMEOUT) {
        ret = BCM_ERR_TIME_OUT;
        line = __LINE__;
        goto err_exit;
    }

    for (i = 0UL; i < SWITCH_ARL_TBL_BIN_SIZE; i++) {
        /* check if MAC is valid */
        macVidAddr = (uint32_t)&ETHSWT_ARLRegs->m05_arla_macvid_entry0 + i * 0x10UL;
        fwdAddr = macVidAddr + 0x8UL;
        ret = ETHSWT_DrvReadReg(aSwtID, fwdAddr,
                    &fwdReg);
        if (BCM_ERR_OK != ret) {
            break;
        }
        ret = ETHSWT_DrvReadReg(aSwtID, macVidAddr, &reg64);
        if (BCM_ERR_OK != ret) {
            break;
        }
        if ((fwdReg & SWITCH_P05AFE0_PAGE_05_ARLA_FWD_ENTRY0_ARL_VALID_MASK) != 0UL) {
            mac = reg64 & SWITCH_P05AME0_PAGE_05_ARLA_MACVID_ENTRY0_ARL_MACADDR_MASK;
            vid = (uint32_t)((reg64 & SWITCH_P05AME0_PAGE_05_ARLA_MACVID_ENTRY0_VID_MASK)
                    >> SWITCH_P05AME0_PAGE_05_ARLA_MACVID_ENTRY0_VID_SHIFT);
            if ((mac == aMACAddr) && (vid == aVlanID)) {
                *aPortMask = (fwdReg
                            & SWITCH_P05AFE0_PAGE_05_ARLA_FWD_ENTRY0_PORTID_MASK)
                            >> SWITCH_P05AFE0_PAGE_05_ARLA_FWD_ENTRY0_PORTID_SHIFT;
                *aBinIdx = i;
                matchedEntry = TRUE;
                break;
            }
        } else {
            if (*aBinIdx == ETHSWT_ARL_TBL_INVAL_BIN_IDX) {
                *aBinIdx = i;
            }
        }
    }

    /* The above search operation results in 3 conditions:
     * (a) FULL = all bins are valid
     * (b) FOUND = mac+vid matched and valid entry is found
     * (c) NOT_FOUND = free bin found
     */
    if (*aBinIdx == ETHSWT_ARL_TBL_INVAL_BIN_IDX) {
        ret = BCM_ERR_NOMEM;
    }
    else if(TRUE == matchedEntry) {
        ret = BCM_ERR_OK;
    }
    else {
        ret = BCM_ERR_NOT_FOUND;
    }

err_exit:
    if((ret != BCM_ERR_NOMEM) && (ret != BCM_ERR_OK) && (ret != BCM_ERR_NOT_FOUND)) {
        ETHSWT_REPORT_ERR( ret, aSwtID, line,
        BRCM_SWDSGN_ETHSWT_DRV_ARL_TBL_SEARCH_BY_ADDR_PROC, 0UL, 0UL, 0UL)
    }
    return ret;
}

#ifdef ENABLE_ETHSWT_TCAM
/**
    @brief This function program the TCAM access control register
    which is reguired as prerequisite to access (Read/Write) the
    particular index of TCAM.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aSwtID      Switch Index
    @param[in]      aIndex      Index of read/write TCAM address
    @param[in]      operation   Read/Write TCAM operation

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @retval     #BCM_ERR_TIME_OUT       TCAM read/write timeout
    @retval     #BCM_ERR_UNKNOWN        TCAM read is invalid
    @retval     #BCM_ERR_INVAL_PARAMS   Invalid parameter
    @post None
    @code{.c}
    ret = BCM_ERR_OK
    timeout = 0UL

    if ((aSwtID >= SWITCH_MAX_HW_ID) ||
         (aOperation < SWITCH_ARL_TCAM_READ) ||
         (aOperation > SWITCH_ARL_TCAM_WRITE) ||
         (aIndex >= SWITCH_ARL_TCAM_SIZE)) {
        ret = BCM_ERR_INVAL_PARAMS;
        Log the arguments to report error
        goto err_exit;
    }

    PAGE_B0_ARL_TCAM_ACC_XCESS_ADDR[23:16] = aIndex
    PAGE_B0_ARL_TCAM_ACC_OP_SEL[2:1] = aOperation
    PAGE_B0_ARL_TCAM_ACC_OP_STR_DONE[0:0] = 0x1UL
    Program the SWITCH_PAGE_B0_ARL_TCAM_ACC register with the above values

    Wait for PAGE_B0_ARL_TCAM_ACC_OP_STR_DONE[0:0] to clear when the operation
    is done.

    while (timeout < ETHSWT_RDWR_TIMEOUT) {
        Read SWITCH_PAGE_B0_ARL_TCAM_ACC register
        if (PAGE_B0_ARL_TCAM_ACC_OP_STR_DONE[0:0] == 0ULL) {
            break;
        }
        timeout++;
    }
    if (ETHSWT_RDWR_TIMEOUT == timeout) {
        Log the arguments and register value to report error
        ret = BCM_ERR_TIME_OUT;
        goto err_exit;
    }
    Check PAGE_B0_ARL_TCAM_ACC_SMEM_RD_STS[30:30] to confirm if the READ from TCAM is valid
    if((SWITCH_ARL_TCAM_READ == aOperation) &&
       (PAGE_B0_ARL_TCAM_ACC_SMEM_RD_STS[30:30] == 0x0ULL))) {
        Read the SWITCH_PAGE_04_ARL_TCAM_STS register to report cause of error
        Log the arguments and SWITCH_PAGE_04_ARL_TCAM_STS register value to report error
        ret = BCM_ERR_UNKNOWN;
        goto err_exit;
    }

    err_exit:
    if(ret != BCM_ERR_OK) {
        Report error
    }
    return ret;
    @endcode

    @trace #BRCM_SWARCH_ETHSWT_DRV_ARL_TBL_ADD_ENTRY_PROC
    @trace #BRCM_SWARCH_ETHSWT_ARL_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_KERNEL_INTERFACE
 */
static int32_t ETHSWT_DrvArlTcamRW(ETHSWT_HwIDType aSwtID, uint32_t aIndex, uint32_t aOperation)
{
    int32_t  ret = BCM_ERR_OK;
    uint32_t accessReg = 0x0UL;
    uint32_t errorReg = 0x0UL;
    uint32_t timeout = 0UL;
    uint32_t line = __LINE__;
    uint32_t errorValues[4] = {0};

    if ((aSwtID >= SWITCH_MAX_HW_ID) ||
         (aOperation < SWITCH_ARL_TCAM_READ) ||
         (aOperation > SWITCH_ARL_TCAM_WRITE) ||
         (aIndex >= SWITCH_ARL_TCAM_SIZE)) {
        ret = BCM_ERR_INVAL_PARAMS;
        errorValues[0] = aSwtID;
        errorValues[1] = aIndex;
        errorValues[2] = aOperation;
        errorValues[3] = __LINE__;
        goto err_exit;
    }
    accessReg = (aIndex << SWITCH_PB0ATA_PAGE_B0_ARL_TCAM_ACC_XCESS_ADDR_SHIFT)
                 & SWITCH_PB0ATA_PAGE_B0_ARL_TCAM_ACC_XCESS_ADDR_MASK;
    accessReg |= (aOperation << SWITCH_PB0ATA_PAGE_B0_ARL_TCAM_ACC_OP_SEL_SHIFT)
                  & SWITCH_PB0ATA_PAGE_B0_ARL_TCAM_ACC_OP_SEL_MASK;
    accessReg |= (SWITCH_PB0ATA_PAGE_B0_ARL_TCAM_ACC_OP_STR_DONE_MASK);
    ret = ETHSWT_DrvWriteReg32(aSwtID, (uint32_t)&ETHSWT_ARLRegs->b0_arl_tcam_acc, accessReg);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)

    /* Wait for OP_STR_DONE to clear */
    while (timeout < ETHSWT_RDWR_TIMEOUT) {
        ret = ETHSWT_DrvReadReg32(aSwtID, (uint32_t)&ETHSWT_ARLRegs->b0_arl_tcam_acc, &accessReg);
        if(BCM_ERR_OK != ret) {
            break;
        }
        if ((accessReg & SWITCH_PB0ATA_PAGE_B0_ARL_TCAM_ACC_OP_STR_DONE_MASK) == 0UL) {
            break;
        }
        timeout++;
    }
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    if (ETHSWT_RDWR_TIMEOUT == timeout) {
        errorValues[0] = ETHSWT_ARLRegs->b0_arl_tcam_acc;
        errorValues[1] = aIndex;
        errorValues[2] = accessReg;
        errorValues[3] = __LINE__;
        ret = BCM_ERR_TIME_OUT;
        goto err_exit;
    }

    /* Check TCAM_RD_STS to confirm if the READ from TCAM is valid */
    if(((SWITCH_ARL_TCAM_READ == aOperation)) &&
       (SWITCH_PB0ATA_PAGE_B0_ARL_TCAM_ACC_TCAM_RD_STS_MASK !=
       (accessReg & SWITCH_PB0ATA_PAGE_B0_ARL_TCAM_ACC_TCAM_RD_STS_MASK))) {
        /* Read the ARL_TCAM_STS to report cause of error */
        ret = ETHSWT_DrvReadReg32(aSwtID, (uint32_t)&ETHSWT_ARLRegs->m04_arl_tcam_sts, &errorReg);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
        errorValues[0] = accessReg;
        errorValues[1] = aIndex;
        errorValues[2] = errorReg;
        errorValues[3] = __LINE__;
        ret = BCM_ERR_UNKNOWN;
        goto err_exit;
    }
err_exit:
    if(ret != BCM_ERR_OK) {
     ETHSWT_DrvReportError((BCM_SWT_ID & BCM_LOGMASK_USER), (uint8_t)aSwtID, BRCM_SWDSGN_ETHSWT_DRV_ARL_TCAM_RW_PROC, ret,
                           errorValues[0], errorValues[1], errorValues[2], errorValues[3]);
    }
    return ret;
}

/**
    @brief TCAM table search by address
    This function linearly search the TCAM with provided MAC address
    and VlanID combination as a key and return the index of the TCAM
    where the entry was found, otherwise it returns the first free
    index of TCAM. If the entry is not present in the TCAM and there
    is no free space in the TCAM as well then it will return invalid
    index.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aSwtID      Switch Index
    @param[in]      aEntry      Pointer of entry to search
    @param[out]     aEntryIdx   Pointer of index to free/found entry

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK           On Success
    @retval     #BCM_ERR_TIME_OUT     Clearing STRDN times out
    @retval     #BCM_ERR_NOT_FOUND    Entry not found
    @retval     #BCM_ERR_UNKNOWN      Read from TCAM is invalid
    @retval     #BCM_ERR_NOMEM        TCAM is full
    @retval     #BCM_ERR_INVAL_PARAMS aEntryIdx is NULL

    @post None
    @code{.c}
    ret = BCM_ERR_OK
    matchedEntry = FALSE

    if (aEntryIdx == NULL) {
        ret = BCM_ERR_INVAL_PARAMS;
        Log the arguments to report error
        goto err_exit;
    }
    *aEntryIdx = SWITCH_ARL_TCAM_SIZE;

    for(index = 0; index < SWITCH_ARL_TCAM_SIZE; index ++) {
        ETHSWT_ERR_BREAK(ETHSWT_DrvArlTcamRW(aSwtID, index, SWITCH_ARL_TCAM_READ));
        Read SWITCH_PAGE_B0_ARL_TCAM_DATA0 register
        Read SWITCH_PAGE_B0_ARL_TCAM_DATA1 register
        Read SWITCH_PAGE_B0_ARL_SMEM_DATA register

        if(0UL != (PAGE_B0_ARL_SMEM_DATA_SMEM_DATA[16:16])) {
                macAddr = ((PAGE_B0_ARL_TCAM_DATA1_TCAM_DATA[15:0] << 32) |
                              PAGE_B0_ARL_TCAM_DATA0_TCAM_DATA[31:0]) & SWITCH_ARL_TCAM_MACADDR_MASK);
                vlanID = PAGE_B0_ARL_TCAM_DATA1_TCAM_DATA[27:16]
                if((aEntry->mac == macAddr) && (aEntry->vlanID == vlanID)) {
                    *aEntryIdx = index;
                     matchedEntry = TRUE;
                     break;
                }
        } else {
            if(SWITCH_ARL_TCAM_SIZE == *aEntryIdx) {
                *aEntryIdx = index;
            }
        }
    }
    if (ret != BCM_ERR_OK) {
        Log the arguments to report error
        goto err_exit;
    }
    if (*aEntryIdx == SWITCH_ARL_TCAM_SIZE) {
        ret = BCM_ERR_NOMEM;
    }
    else if(TRUE == matchedEntry) {
        ret = BCM_ERR_OK;
    }
    else {
        ret = BCM_ERR_NOT_FOUND;
    }

    err_exit:
    if(ret != BCM_ERR_OK) {
        Report error
    }
    return ret;
    @endcode

    @trace #BRCM_SWARCH_ETHSWT_DRV_ARL_TBL_ADD_ENTRY_PROC
    @trace #BRCM_SWARCH_ETHSWT_ARL_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_KERNEL_INTERFACE
 */
static int32_t ETHSWT_DrvArlTcamSearchByAddr(ETHSWT_HwIDType aSwtID,
                                                ETHSWT_ARLTBLHWEntryType *const aEntry,
                                                uint32_t *aEntryIdx)
{
    int32_t  ret = BCM_ERR_OK;
    uint32_t index = 0UL;
    uint32_t arltcam_data0 = 0x0UL;
    uint32_t arltcam_data1 = 0x0UL;
    uint32_t arltcam_smemdata = 0x0UL;
    uint64_t macAddr = 0x0ULL;
    uint32_t vlanID = 0x0UL;
    uint32_t matchedEntry = FALSE;
    uint32_t line = 0xFFFFFFFFUL;

    if (aEntryIdx == NULL) {
        ret = BCM_ERR_INVAL_PARAMS;
        line = __LINE__;
        goto err_exit;
    }
    *aEntryIdx = SWITCH_ARL_TCAM_SIZE;

    /* Start from the last index which has a static entry
     * Read the entry at the index if it is valid.
     * If not found, continue the search till the entry found.
     */
    for(index = 0; index < SWITCH_ARL_TCAM_SIZE; index ++) {
        ret = ETHSWT_DrvArlTcamRW(aSwtID, index, SWITCH_ARL_TCAM_READ);
        if(BCM_ERR_OK != ret) {
            break;
        }
        /* Now read ARL_TCAM_DATA0, ARL_TCAM_DATA1 and ARL_TCAM_SMEM_DATA */
#if defined(__BCM8956X__) || defined(__BCM8957X__)
        ret = ETHSWT_DrvReadReg32(aSwtID, (uint32_t)&ETHSWT_ARLRegs->b0_arl_tcam_data0, &arltcam_data0);
        if(BCM_ERR_OK != ret) {
            break;
        }
        ret = ETHSWT_DrvReadReg32(aSwtID, (uint32_t)&ETHSWT_ARLRegs->b0_arl_tcam_data1, &arltcam_data1);
        if(BCM_ERR_OK != ret) {
            break;
        }
#else
        ret = ETHSWT_DrvReadReg32(aSwtID, (uint32_t)&ETHSWT_ARLRegs->b0_arl_tcam_data_0, &arltcam_data0);
        if(BCM_ERR_OK != ret) {
            break;
        }
        ret = ETHSWT_DrvReadReg32(aSwtID, (uint32_t)&ETHSWT_ARLRegs->b0_arl_tcam_data_1, &arltcam_data1);
        if(BCM_ERR_OK != ret) {
            break;
        }
#endif
        ret = ETHSWT_DrvReadReg32(aSwtID, (uint32_t)&ETHSWT_ARLRegs->b0_arl_smem_data, &arltcam_smemdata);
        if(BCM_ERR_OK != ret) {
            break;
        }


        /* Check whether the entry is VALID. If so,
         * check whether the MAC and VLAN matches the argument.
         * If yes, return index
         * else check for next index
         * Note: valid bit from data1 is not validated as per the H/w team
         */
        if(0UL != (arltcam_smemdata & SWITCH_ARL_TCAM_SMEM_DATA_VALID_MASK)) {
                macAddr = ((((uint64_t)((arltcam_data1 & 0xFFFFUL) << 32UL)) |
                              arltcam_data0) & SWITCH_ARL_TCAM_MACADDR_MASK);
                vlanID = (uint32_t)((arltcam_data1 & SWITCH_ARL_TCAM_VLAN_MASK) >> SWITCH_ARL_TCAM_VLAN_SHIFT);
                if((aEntry->mac == macAddr) && (aEntry->vlanID == vlanID)) {
                    *aEntryIdx = index;
                     matchedEntry = TRUE;
                     break;
                }
        } else {
            /* If not a valid entry, assign first free index as aEntryIdx index*/
            if(SWITCH_ARL_TCAM_SIZE == *aEntryIdx) {
                *aEntryIdx = index;
            }
        }
    }
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    /* The above search operation results in 3 conditions:
     * (a) FULL = all entries are valid
     * (b) FOUND = mac+vid matched and valid entry is found
     * (c) NOT_FOUND = free entry found
     */
    if (*aEntryIdx == SWITCH_ARL_TCAM_SIZE) {
        ret = BCM_ERR_NOMEM;
    }
    else if(TRUE == matchedEntry) {
        ret = BCM_ERR_OK;
    }
    else {
        ret = BCM_ERR_NOT_FOUND;
    }

err_exit:
    if((ret != BCM_ERR_NOMEM) && (ret != BCM_ERR_OK) && (ret != BCM_ERR_NOT_FOUND)) {
     ETHSWT_DrvReportError((BCM_SWT_ID & BCM_LOGMASK_USER), (uint8_t)aSwtID,
      BRCM_SWDSGN_ETHSWT_DRV_ARL_TCAM_SEARCH_BY_ADDR_PROC, ret, 0x0UL, 0x0UL, 0x0UL, line);
    }
    return ret;
}

/**
    @brief ARL-TCAM write/delete
    This function write the ARL entry at provided index of the TCAM,
    If the entry is free otherwise, it will return error.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aSwtID      Switch Index
    @param[in]      aEntry      Pointer to TCAM entry
    @param[in]      aOperation  write/delete operation
    @param[in]      aIndex      TCAM entry Index

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK            On Success
    @retval     #BCM_ERR_TIME_OUT      Reset timeout
    @retval     #BCM_ERR_INVAL_PARAMS  aIndex is greater than TCAM Size
    @retval     #BCM_ERR_NOMEM         TCAM is full

    @post None
    @code{.c}
    ret = BCM_ERR_OK

    if(aIndex >= SWITCH_ARL_TCAM_SIZE) {
        ret = (ETHSWT_DRV_ARL_TCAM_ACCESS_DELETE == aOperation) ? BCM_ERR_INVAL_PARAMS : BCM_ERR_NOMEM;
        Log the arguments to report error
        goto err_exit;
    }

    Program the tcam access register for read operation with aIndex
    ETHSWT_ERR_EXIT(ETHSWT_DrvArlTcamRW(aSwtID, aIndex, SWITCH_ARL_TCAM_READ));
    arltcam_data0 = Read SWITCH_PAGE_B0_ARL_TCAM_DATA0 register
    arltcam_data1 = Read SWITCH_PAGE_B0_ARL_TCAM_DATA1 register
    arltcam_smemdata = Read SWITCH_PAGE_B0_ARL_SMEM_DATA register

    if(ETHSWT_DRV_ARL_TCAM_ACCESS_DELETE == aOperation) {
        Check whether the entry is VALID
        if(0UL != (arltcam_smemdata & SWITCH_ARL_TCAM_SMEM_DATA_VALID_MASK)) {
            macAddr = ((((uint64_t)((arltcam_data1 & 0xFFFF) << 32)) |
                          arltcam_data0) & SWITCH_ARL_TCAM_MACADDR_MASK);
            vlanID = (arltcam_data1 & SWITCH_ARL_TCAM_VLAN_MASK) >> SWITCH_ARL_TCAM_VLAN_SHIFT;
            check whether the MAC and VLAN matches the argument.
            if((aEntry->mac == macAddr) && (aEntry->vlanID == vlanID)) {
                make the entry invalid
                arltcam_smemdata &= ~(SWITCH_ARL_TCAM_SMEM_DATA_VALID_MASK);
                Write SWITCH_PAGE_B0_ARL_SMEM_DATA register with value arltcam_smemdata
            }
        } else {
            ret = BCM_ERR_UNKNOWN;
            Log the arguments to report error
            goto err_exit;
        }
    } else {

        arltcam_data0 = (aEntry->mac);
        arltcam_data1 = (uint32_t)((aEntry->mac >> 32) & 0xFFFFUL) bitwise OR
                        (uint32_t)(((aEntry->vlanID) & 0xFFFUL) << SWITCH_ARL_TCAM_VLAN_SHIFT) bitwise OR
                        (SWITCH_ARL_TCAM_ENTRY_VALID_MASK);

        arltcam_smemdata = SWITCH_ARL_TCAM_SMEM_DATA_VALID_MASK bitwise OR
                           SWITCH_ARL_TCAM_SMEM_DATA_STATIC_MASK bitwise OR
                           (uint16_t)(aEntry->portMask);

        Write SWITCH_PAGE_B0_ARL_TCAM_DATA0 register with value arltcam_data0
        Write SWITCH_PAGE_B0_ARL_TCAM_DATA1 register with value arltcam_data1
        Write SWITCH_PAGE_B0_ARL_SMEM_DATA register with value arltcam_smemdata
    }
    Program the tcam access register for write operation with aIndex
    ETHSWT_ERR_EXIT(ETHSWT_DrvArlTcamRW(aSwtID, aIndex, SWITCH_ARL_TCAM_WRITE));

    err_exit:
    if(ret != BCM_ERR_OK) {
        Report error
    }
    return ret;
    @endcode

    @trace #BRCM_SWARCH_ETHSWT_DRV_ARL_TBL_ADD_ENTRY_PROC
    @trace #BRCM_SWARCH_ETHSWT_ARL_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_KERNEL_INTERFACE
*/
static int32_t ETHSWT_DrvArlTcamUpdate(ETHSWT_HwIDType aSwtID,
                                                ETHSWT_ARLTBLHWEntryType *const aEntry,
                                                ETHSWT_DrvArlTcamAccessType aOperation,
                                                uint32_t aIndex)
{
    int32_t  ret = BCM_ERR_OK;
    uint32_t arltcam_data0 = 0x0UL;
    uint32_t arltcam_data1 = 0x0UL;
    uint32_t arltcam_smemdata = 0x0UL;
    uint64_t macAddr = 0x0UL;
    uint32_t vlanID = 0x0UL;
    uint32_t line = __LINE__;
    uint32_t errorValues[4] = {0};

    /* Check invalid parameter */
    if(aIndex >= SWITCH_ARL_TCAM_SIZE) {
        ret = (ETHSWT_DRV_ARL_TCAM_ACCESS_DELETE == aOperation) ? BCM_ERR_INVAL_PARAMS : BCM_ERR_NOMEM;
        errorValues[0] = aEntry->portMask;
        errorValues[1] = (uint32_t)(aEntry->mac & 0xFFFFFFFFUL);
        errorValues[2] = aEntry->vlanID;
        errorValues[3] = __LINE__;
        goto err_exit;
    }
    /* Program the tcam access register for read operation with aIndex */
    ret = ETHSWT_DrvArlTcamRW(aSwtID, aIndex, SWITCH_ARL_TCAM_READ);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)

    /* Now read ARL_TCAM_DATA0, ARL_TCAM_DATA1 and ARL_TCAM_SMEM_DATA */
#if defined(__BCM8956X__) || defined(__BCM8957X__)
    ret = ETHSWT_DrvReadReg32(aSwtID, (uint32_t)&ETHSWT_ARLRegs->b0_arl_tcam_data0, &arltcam_data0);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    ret = ETHSWT_DrvReadReg32(aSwtID, (uint32_t)&ETHSWT_ARLRegs->b0_arl_tcam_data1, &arltcam_data1);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
#else
    ret = ETHSWT_DrvReadReg32(aSwtID, (uint32_t)&ETHSWT_ARLRegs->b0_arl_tcam_data_0, &arltcam_data0);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    ret = ETHSWT_DrvReadReg32(aSwtID, (uint32_t)&ETHSWT_ARLRegs->b0_arl_tcam_data_1, &arltcam_data1);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
#endif
    ret = ETHSWT_DrvReadReg32(aSwtID, (uint32_t)&ETHSWT_ARLRegs->b0_arl_smem_data, &arltcam_smemdata);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)

    if(ETHSWT_DRV_ARL_TCAM_ACCESS_DELETE == aOperation) {
        /* Check whether the entry is VALID. If so,
         * check whether the MAC and VLAN matches the argument.
         * If yes, make the entry invalid
         */
        if(0UL != (arltcam_smemdata & SWITCH_ARL_TCAM_SMEM_DATA_VALID_MASK)) {
            macAddr = ((((uint64_t)((arltcam_data1 & 0xFFFFUL) << 32UL)) |
                          arltcam_data0) & SWITCH_ARL_TCAM_MACADDR_MASK);
            vlanID = (uint32_t)((arltcam_data1 & SWITCH_ARL_TCAM_VLAN_MASK) >> SWITCH_ARL_TCAM_VLAN_SHIFT);
            if((aEntry->mac == macAddr) && (aEntry->vlanID == vlanID)) {
                arltcam_smemdata &= ~(SWITCH_ARL_TCAM_SMEM_DATA_VALID_MASK);
                ret = ETHSWT_DrvWriteReg32(aSwtID, (uint32_t)&ETHSWT_ARLRegs->b0_arl_smem_data, arltcam_smemdata);
                ETHSWT_CHECK_ERR(ret, &line, err_exit)
            }
        } else {
            ret = BCM_ERR_UNKNOWN;
            errorValues[0] = aEntry->portMask;
            errorValues[1] = (uint32_t)(aEntry->mac & 0xFFFFFFFFUL);
            errorValues[2] = aEntry->vlanID;
            errorValues[3] = __LINE__;
            goto err_exit;
        }
    }

    /* For a write operation, if the entry is valid, write at the free index.
     */
    else {
        /* The layout of this data0 and data1 is
         * macAddr  = data1[15:0] << 16 | data[0]
         * vlan     = data1[27-16]
         * valid    = data1[28]
         *
         * The layout of SMEM data is
         * VALID    = bit[16]
         * STATIC   = bit[15]
         * Aging    = bit[14]
         For UNICAST:
         * Reserved = bit[13-4]
         * PortNum  = bit[3-0]
         For MULTICAST:
         * Reserved = bit[13-9]
         * bitmap   = bit[8-0]
         */
        arltcam_data0 = (uint32_t)(aEntry->mac);
        arltcam_data1 = (uint32_t)((aEntry->mac >> 32) & 0xFFFFUL);
        arltcam_data1 |= (uint32_t)(((aEntry->vlanID) & 0xFFFUL) << SWITCH_ARL_TCAM_VLAN_SHIFT);
        arltcam_data1 |= (SWITCH_ARL_TCAM_ENTRY_VALID_MASK);

        arltcam_smemdata = SWITCH_ARL_TCAM_SMEM_DATA_VALID_MASK | SWITCH_ARL_TCAM_SMEM_DATA_STATIC_MASK;
        arltcam_smemdata |= (uint16_t)(aEntry->portMask);

#if defined(__BCM8956X__) || defined(__BCM8957X__)
        ret = ETHSWT_DrvWriteReg32(aSwtID, (uint32_t)&ETHSWT_ARLRegs->b0_arl_tcam_data0,
                arltcam_data0);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
        ret = ETHSWT_DrvWriteReg32(aSwtID, (uint32_t)&ETHSWT_ARLRegs->b0_arl_tcam_data1,
                arltcam_data1);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
#else
        ret = ETHSWT_DrvWriteReg32(aSwtID, (uint32_t)&ETHSWT_ARLRegs->b0_arl_tcam_data_0,
                arltcam_data0);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
        ret = ETHSWT_DrvWriteReg32(aSwtID, (uint32_t)&ETHSWT_ARLRegs->b0_arl_tcam_data_1,
                arltcam_data1);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
#endif /*__BCM8956X__*/
        ret = ETHSWT_DrvWriteReg32(aSwtID, (uint32_t)&ETHSWT_ARLRegs->b0_arl_smem_data,
                arltcam_smemdata);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
    }

    /* Program the tcam access register for write operation with aIndex */
    ret = ETHSWT_DrvArlTcamRW(aSwtID, aIndex, SWITCH_ARL_TCAM_WRITE);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)

err_exit:
    if(ret != BCM_ERR_OK) {
     ETHSWT_DrvReportError((BCM_SWT_ID & BCM_LOGMASK_USER), (uint8_t)aSwtID, BRCM_SWDSGN_ETHSWT_DRV_ARL_TCAM_UPDATE_PROC, ret,
                           errorValues[0], errorValues[1], errorValues[2], errorValues[3]);
    }
    return ret;
}
#endif /*ENABLE_ETHSWT_TCAM*/
/**
    @brief Add ARL entry to ARL/TCAM
    This function add static ARL entry to ARL/TCAM. If TCAM is enabled
    and all four ARL bins are full the entry will be added to TCAM, otherwise
    it will be added to ARL table.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aSwtID      Switch Index
    @param[in]      aEntry      Pointer to ARL entry

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK            On Success
    @retval     #BCM_ERR_TIME_OUT      Timeout occurred while reading/writing
                                       switch register
    @retval     #BCM_ERR_INVAL_PARAMS  Invalid TCAM address
    @retval     #BCM_ERR_NOMEM         Both ARL and TCAM is full
    @retval     #BCM_ERR_UNKNOWN       Unable to read data from TCAM

    @post None
    @code{.c}
    ret = BCM_ERR_OK

    Check the entry in ARL table before adding it
    ret = ETHSWT_DrvARLTblSearchByAddr(aSwtID, aEntry->mac, aEntry->vlanID,
            &portMask, &binIdx);
    if(BCM_ERR_TIME_OUT == ret) {
        goto err_exit;
    } else if (BCM_ERR_NOMEM == ret) {
        if(TCAM is enabled) {
            Search if the entry already exsits in the ARL-TCAM
            ret = ETHSWT_DrvArlTcamSearchByAddr(aSwtID, aEntry, &tcamEntryIdx)
            if (BCM_ERR_NOT_FOUND == ret) {
                If the entry not found in the ARL-TCAM then add the new entry
                at the free index in TCAM
                ETHSWT_DrvArlTcamAccessType aOperation = ETHSWT_DRV_ARL_TCAM_ACCESS_WRITE;
                ret = ETHSWT_DrvArlTcamUpdate(aSwtID, aEntry, aOperation, tcamEntryIdx);
                goto err_exit;
            } else if(BCM_ERR_OK == ret) {
                If the entry found in the ARL-TCAM then update the entry
                ETHSWT_DrvArlTcamAccessType aOperation = ETHSWT_DRV_ARL_TCAM_ACCESS_WRITE;
                ret = ETHSWT_DrvArlTcamUpdate(aSwtID, aEntry, aOperation, tcamEntryIdx);
                goto err_exit;
            } else if(BCM_ERR_NOMEM == ret) {
                If both ARL table and ARL-TCAM are full then
                return error
                goto err_exit;
            } else {
                BCM_ERR_TIME_OUT or BCM_ERR_INVAL_PARAMS or BCM_ERR_UNKNOWN
                goto err_exit;
            }
        } else {
            All four bins are full, return error BCM_ERR_NOMEM
            goto err_exit;
        }
    } else if (BCM_ERR_NOT_FOUND == ret) {
        if(TCAM is enabled) {
            Search if the entry already exsits in the ARL-TCAM
            ret = ETHSWT_DrvArlTcamSearchByAddr(aSwtID, aEntry, &tcamEntryIdx)
            if ((BCM_ERR_NOT_FOUND == ret) || (BCM_ERR_NOMEM == ret)) {
                   If the entry not found in both ARL table and ARL-TCAM, or ARL-TCAM is full
                   and have space in ARL table, write the entry at free binIdx in ARL table.
            } else if (BCM_ERR_OK == ret) {
                If the entry found in the ARL-TCAM then update the entry
                ETHSWT_DrvArlTcamAccessType aOperation = ETHSWT_DRV_ARL_TCAM_ACCESS_WRITE;
                ret = ETHSWT_DrvArlTcamUpdate(aSwtID, aEntry, aOperation, tcamEntryIdx);
                goto err_exit;
            } else {
                BCM_ERR_TIME_OUT or BCM_ERR_INVAL_PARAMS or BCM_ERR_UNKNOWN
                goto err_exit;
            }
        } else {
            Add the entry at the free binIdx returned by
            ETHSWT_DrvARLTblSearchByAddr
        }
    }

    Add the entry to ARL table at binIdx
    macVidAddr = (uint32_t)&ETHSWT_ARLRegs->m05_arla_macvid_entry0 + binIdx * 0x10UL;
    fwdAddr = macVidAddr + 0x8UL;

    macVidReg = (aEntry->mac)
                & SWITCH_P05AME0_PAGE_05_ARLA_MACVID_ENTRY0_ARL_MACADDR_MASK;
    macVidReg |= (uint64_t)aEntry->vlanID
                << SWITCH_P05AME0_PAGE_05_ARLA_MACVID_ENTRY0_VID_SHIFT;

    fwdReg = aEntry->portMask
                & SWITCH_P05AFE0_PAGE_05_ARLA_FWD_ENTRY0_PORTID_MASK bitwise OR
             SWITCH_P05AFE0_PAGE_05_ARLA_FWD_ENTRY0_ARL_VALID_MASK bitwise OR
             SWITCH_P05AFE0_PAGE_05_ARLA_FWD_ENTRY0_ARL_STATIC_MASK bitwise OR
             SWITCH_ARLA_FWD_ENTRY_ARL_MODE_FWD_MAP
                << SWITCH_P05AFE0_PAGE_05_ARLA_FWD_ENTRY0_PORTID_SHIFT;

    Write the SWITCH_PAGE_05_ARLA_MACVID_ENTRY register with value macVidReg
    Write the SWITCH_PAGE_05_ARLA_FWD_ENTRY register with value fwdReg

    start the write operation and wait for completion
    cntrlReg = SWITCH_ARLA_RWCTL_ARL_WRITE;
    cntrlReg |= SWITCH_P05AR_PAGE_05_ARLA_RWCTL_ARL_STRTDN_MASK;
    Write the SWITCH_PAGE_05_ARLA_RWCTL register with value cntrlReg

    wait for PAGE_05_ARLA_SRCH_CTL_ARLA_SRCH_STDN[7:7] to clear
    while (timeout < ETHSWT_RDWR_TIMEOUT) {
        cntrlReg = Read SWITCH_PAGE_05_ARLA_RWCTL register
        if ((cntrlReg
                & SWITCH_P05AR_PAGE_05_ARLA_RWCTL_ARL_STRTDN_MASK) == 0ULL) {
            break;
        }
        timeout++;
    }

    if (timeout == ETHSWT_RDWR_TIMEOUT) {
        ret = BCM_ERR_TIME_OUT;
    }

    err_exit:
    if(ret != BCM_ERR_OK) {
        Report error
    }
    return ret;
    @endcode
    @trace #BRCM_SWARCH_ETHSWT_DRV_ARL_TBL_ADD_ENTRY_PROC
    @trace #BRCM_SWREQ_ETHSWT_KERNEL_INTERFACE
 */
int32_t ETHSWT_DrvARLTblAddEntry(ETHSWT_HwIDType aSwtID,
        ETHSWT_ARLTBLHWEntryType *const aEntry)
{
    uint64_t macVidReg;
    uint64_t fwdReg;
    uint8_t cntrlReg;
    uint32_t macVidAddr;
    uint32_t fwdAddr;
    uint32_t portMask = 0UL;
    uint32_t binIdx = 0UL;
    uint32_t timeout = 0UL;
    uint32_t line = 0xFFFFFFFFUL;
    int ret = BCM_ERR_OK;
#ifdef ENABLE_ETHSWT_TCAM
    /* initialize indexes with invalid index */
    uint32_t tcamEntryIdx = SWITCH_ARL_TCAM_SIZE;
#endif

    /* Find if the entry already exsits in the ARL table.
     *    If yes, replace that entry.
     *    elseIf no memory in ARL, Search in TCAM
     *       If not found in TCAM, write in TCAM
     *       elseIf found in TCAM, overwrite the entry in TCAM
     *       elseIf no memory in TCAM, return error
     *    elseIf not found in ARL, Search in TCAM
     *       If not found in TCAM, write in ARL at free index
     *       elseIf no memory in TCAM, write in ARL at free index
     *       elseIf found in TCAM, overwrite the entry in TCAM
     */

    /*  Check the entry in ARL table before adding it */
    ret = ETHSWT_DrvARLTblSearchByAddr(aSwtID, aEntry->mac, aEntry->vlanID,
            &portMask, &binIdx);
    if(BCM_ERR_TIME_OUT == ret) {
        line = __LINE__;
        goto err_exit;
    }
    else if (BCM_ERR_NOMEM == ret) {
#ifdef ENABLE_ETHSWT_TCAM
        /* Search if the entry already exsits in the ARL-TCAM */
        ret = ETHSWT_DrvArlTcamSearchByAddr(aSwtID, aEntry, &tcamEntryIdx);
        if (BCM_ERR_NOT_FOUND == ret) {
            /* If the entry not found in the ARL-TCAM then add the new entry at the free index */
            ETHSWT_DrvArlTcamAccessType aOperation = ETHSWT_DRV_ARL_TCAM_ACCESS_WRITE;
            ret = ETHSWT_DrvArlTcamUpdate(aSwtID, aEntry, aOperation, tcamEntryIdx);
            line = __LINE__;
            goto err_exit;
        } else if(BCM_ERR_OK == ret) {
            /* If the entry found in the ARL-TCAM then update the entry*/
            ETHSWT_DrvArlTcamAccessType aOperation = ETHSWT_DRV_ARL_TCAM_ACCESS_WRITE;
            ret = ETHSWT_DrvArlTcamUpdate(aSwtID, aEntry, aOperation, tcamEntryIdx);
            line = __LINE__;
            goto err_exit;
        } else if(BCM_ERR_NOMEM == ret) {
            /* If both ARL table and ARL-TCAM are full then
               return error */
            line = __LINE__;
            goto err_exit;
        } else {
            /* BCM_ERR_TIME_OUT or BCM_ERR_INVAL_PARAMS or BCM_ERR_UNKNOWN*/
            line = __LINE__;
            goto err_exit;
        }
    }
    else if (BCM_ERR_NOT_FOUND == ret) {
        /* Check the entry in ARL-TCAM before adding to ARL table.
           If found in  ARL-TCAM update the entry, otherwise write
           the new entry in ARL-table*/
        ret = ETHSWT_DrvArlTcamSearchByAddr(aSwtID, aEntry, &tcamEntryIdx);
        if ((BCM_ERR_NOT_FOUND == ret) || (BCM_ERR_NOMEM == ret)) {
            /* If the entry not found in both ARL table and ARL-TCAM, or ARL-TCAM is full
               and have space in ARL table, write the entry at free binIdx in ARL table.
               The below logic will do this */
        } else if (BCM_ERR_OK == ret) {
            /* If the entry found in the ARL-TCAM then update the entry*/
            ETHSWT_DrvArlTcamAccessType aOperation = ETHSWT_DRV_ARL_TCAM_ACCESS_WRITE;
            ret = ETHSWT_DrvArlTcamUpdate(aSwtID, aEntry, aOperation, tcamEntryIdx);
            line = __LINE__;
            goto err_exit;
        } else {
            /* BCM_ERR_TIME_OUT or BCM_ERR_INVAL_PARAMS or BCM_ERR_UNKNOWN*/
            line = __LINE__;
            goto err_exit;
        }
#else
            /* All four bins are full, return error BCM_ERR_NOMEM */
            line = __LINE__;
            goto err_exit;
#endif
    } else {
        /* Do nothing */
    }
    macVidAddr = (uint32_t)&ETHSWT_ARLRegs->m05_arla_macvid_entry0 + binIdx * 0x10UL;
    fwdAddr = macVidAddr + 0x8UL;

    macVidReg = (aEntry->mac)
                & SWITCH_P05AME0_PAGE_05_ARLA_MACVID_ENTRY0_ARL_MACADDR_MASK;
    macVidReg |= (uint64_t)aEntry->vlanID
                << SWITCH_P05AME0_PAGE_05_ARLA_MACVID_ENTRY0_VID_SHIFT;

    fwdReg = (uint64_t)aEntry->portMask
                & SWITCH_P05AFE0_PAGE_05_ARLA_FWD_ENTRY0_PORTID_MASK;
    fwdReg |= SWITCH_P05AFE0_PAGE_05_ARLA_FWD_ENTRY0_ARL_VALID_MASK;
    fwdReg |= SWITCH_P05AFE0_PAGE_05_ARLA_FWD_ENTRY0_ARL_STATIC_MASK;
    fwdReg |= SWITCH_ARLA_FWD_ENTRY_ARL_MODE_FWD_MAP
                << SWITCH_P05AFE0_PAGE_05_ARLA_FWD_ENTRY0_PORTID_SHIFT;

    /* Write the MACVID entry register */
    ret = ETHSWT_DrvWriteReg(aSwtID, macVidAddr,
                macVidReg);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    /* write the FWD register */
    ret = ETHSWT_DrvWriteReg(aSwtID, fwdAddr,
                fwdReg);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)

    /* start the write operation and wait for completion */
    cntrlReg = SWITCH_ARLA_RWCTL_ARL_WRITE;
    cntrlReg |= SWITCH_P05AR_PAGE_05_ARLA_RWCTL_ARL_STRTDN_MASK;
    ret = ETHSWT_DrvWriteReg8(aSwtID, (uint32_t)&ETHSWT_ARLRegs->m05_arla_rwctl,
                cntrlReg);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)

    /* wait for STRDN to clear */
    while (timeout < ETHSWT_RDWR_TIMEOUT) {
        ret = ETHSWT_DrvReadReg8(aSwtID, (uint32_t)&ETHSWT_ARLRegs->m05_arla_rwctl,
                    &cntrlReg);
        if (BCM_ERR_OK != ret) {
            break;
        }
        if ((cntrlReg
                & SWITCH_P05AR_PAGE_05_ARLA_RWCTL_ARL_STRTDN_MASK) == 0ULL) {
            break;
        }
        timeout++;
    }

    if (timeout == ETHSWT_RDWR_TIMEOUT) {
        line = __LINE__;
        ret = BCM_ERR_TIME_OUT;
        }

err_exit:
    if (BCM_ERR_OK != ret) {
        ETHSWT_REPORT_ERR( ret, aSwtID, line,
        BRCM_SWDSGN_ETHSWT_DRV_ARL_TBL_ADD_ENTRY_PROC, (uint32_t)(aEntry->mac >> 32), (uint32_t)(aEntry->mac & 0xFFFFFFFFUL), aEntry->vlanID)
    }
    return ret;
}

/**
    @brief ARL table delete entry

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aSwtID      Switch Index
    @param[in]      aEntry      Pointer to entry

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK         On Success
    @retval     #BCM_ERR_TIME_OUT   If clearing STRDN times out
    @return     Others             As returned by #ETHSWT_DrvARLTblSearchByAddr

    @post None

    @trace #BRCM_SWARCH_ETHSWT_ARL_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_DYNAMIC_CONFIGURATION
 */
static int32_t ETHSWT_DrvARLTblDeleteEntry(ETHSWT_HwIDType aSwtID,
        ETHSWT_ARLTBLHWEntryType *const aEntry)
{
    uint32_t line = __LINE__;
    uint64_t fwdReg;
    uint8_t cntrlReg;
    uint32_t macVidAddr;
    uint32_t fwdAddr;
    uint32_t portMask = 0UL;
    uint32_t binIdx = 0UL;
    uint32_t timeout = 0UL;
    int ret = BCM_ERR_OK;


    /* Find if the entry already exists in the ARL table
     * If yes, delete that entry.
     * If not, look for the entry in ARL-TCAM (valid only on BCM8956X)
     */
    ret = ETHSWT_DrvARLTblSearchByAddr(aSwtID, aEntry->mac, aEntry->vlanID,
            &portMask, &binIdx);
    if ((BCM_ERR_NOT_FOUND == ret) || (BCM_ERR_NOMEM == ret)) {
#ifdef ENABLE_ETHSWT_TCAM
        /* initialize indexes with invalid index */
        uint32_t tcamEntryIdx = SWITCH_ARL_TCAM_SIZE;
        /* Look for in ARL-TCAM and delete if found */
        /* search if the entry already exsits in the ARL-TCAM */

        ret = ETHSWT_DrvArlTcamSearchByAddr(aSwtID, aEntry, &tcamEntryIdx);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
        ETHSWT_DrvArlTcamAccessType aOperation = ETHSWT_DRV_ARL_TCAM_ACCESS_DELETE;
        ret = ETHSWT_DrvArlTcamUpdate(aSwtID, aEntry, aOperation, tcamEntryIdx);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
#else
        goto err_exit;
#endif
    }
    else if(BCM_ERR_OK == ret) {
        macVidAddr = (uint32_t)&ETHSWT_ARLRegs->m05_arla_macvid_entry0 + binIdx * 0x10UL;
        fwdAddr = macVidAddr + 0x8UL;

        /* read the FWD register */
        ret = ETHSWT_DrvReadReg(aSwtID, fwdAddr,
                    &fwdReg);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
        fwdReg &= ~SWITCH_P05AFE0_PAGE_05_ARLA_FWD_ENTRY0_ARL_VALID_MASK;
        /* write the FWD register */
        ret = ETHSWT_DrvWriteReg(aSwtID, fwdAddr,
                    fwdReg);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)

        /* start the write operation and wait for completion */
        cntrlReg = SWITCH_ARLA_RWCTL_ARL_WRITE;
        cntrlReg |= SWITCH_P05AR_PAGE_05_ARLA_RWCTL_ARL_STRTDN_MASK;
        ret = ETHSWT_DrvWriteReg8(aSwtID, (uint32_t)&ETHSWT_ARLRegs->m05_arla_rwctl,
                    cntrlReg);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)

        /* wait for STRDN to clear */
        while (timeout < ETHSWT_RDWR_TIMEOUT) {
            ret = ETHSWT_DrvReadReg8(aSwtID, (uint32_t)&ETHSWT_ARLRegs->m05_arla_rwctl,
                        &cntrlReg);
            if (BCM_ERR_OK != ret) {
                break;
            }
            if ((cntrlReg
                    & SWITCH_P05AR_PAGE_05_ARLA_RWCTL_ARL_STRTDN_MASK) == 0ULL) {
                break;
            }
            timeout++;
        }
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
        if (timeout == ETHSWT_RDWR_TIMEOUT) {
            ret = BCM_ERR_TIME_OUT;
            line = __LINE__;
        }
    } else {
        /* Return error */
    }
err_exit:
    ETHSWT_REPORT_ERR( ret, aSwtID, line,
        BRCM_SWDSGN_ETHSWT_DRV_ARL_TBL_DELETE_ENTRY_PROC, (uint32_t)(aEntry->mac & 0xFFFFFFFFUL),
                                                               aEntry->vlanID, aEntry->portMask)
    return ret;
}

/**
    @brief Is ARL entry init configuration

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aSwtID          Switch Index
    @param[in]      aHwEntry        Pointer to HW entry
    @param[inout]   aIsInitARLEntry Pointer to set if its init ARL entry

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK         On Success
    @return     Others             As returned by #ETHSWT_DrvARLTblSearchByAddr or
                                    by #ETHSWT_DrvARLTblAddEntry

    @post None

    @trace #BRCM_SWARCH_ETHSWT_ARL_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_QUERY
 */
static int32_t ETHSWT_DrvIsARLEntryInitConfig(ETHSWT_HwIDType aSwtID,
                                        ETHSWT_ARLTBLHWEntryType *const aHwEntry,
                                        uint32_t *const aIsInitARLEntry)
{
#if 1
    int32_t ret = BCM_ERR_OK;
    *aIsInitARLEntry = FALSE;
#else
    uint32_t i, j, k;
    uint64_t mac;
    uint8_t *temp;
    int32_t ret = BCM_ERR_OK;
    ETHSWT_ARLTBLHWEntryType hwEntry;
    /*const ETHSWT_PortCfgType *portCfg;*/
    const ETHSWT_VLANMemberCfgType * vlanMemCfg;
    /*uint8_t isMacAddrFound[ETHSWT_PORT_MAC_ENTRY_MAX];*/
    /*const ETHSWT_CfgType *swtConfig = ETHSWT_DrvData.config;*/

    *aIsInitARLEntry = FALSE;

    if (NULL != swtConfig) {
        for (i = 0UL; i < swtConfig->portCfgListSz; i++) {
            memset(isMacAddrFound, 0x0, sizeof(isMacAddrFound));
            portCfg = &swtConfig->portCfgList[i];
            for (j = 0UL; j < portCfg->vlanMemListSz; j++) {
                vlanMemCfg = &portCfg->vlanMemList[j];
                hwEntry.vlanID = vlanMemCfg->vlanID;
                hwEntry.portMask = portCfg->portID;
                hwEntry.priority = vlanMemCfg->defaultPri;
                /*for (k = 0UL; k < ETHSWT_VLAN_MEM_CFG_MAC_ADDR_LIST_SZ; k++) {*/
                    if ((vlanMemCfg->macAddrList & (0x1U << k)) != 0U) {
                        isMacAddrFound[k] = (uint8_t)1;
                        temp = (uint8_t *)(&portCfg->fixedMacAddrList[k][0]);
                        mac = ETHSWT_NMAC2HWMAC(temp);
                        hwEntry.mac = mac;

                        /* Compare ARL hwEntry in config */
                        if ((aHwEntry->vlanID == hwEntry.vlanID)
                                && (aHwEntry->mac == hwEntry.mac)) {
                            *aIsInitARLEntry = TRUE;
                            break;
                        }
                    }
                }
                if (TRUE == *aIsInitARLEntry) {
                    break;
                }
            }
            if (TRUE == *aIsInitARLEntry) {
                break;
            }

            /* Search for ARL entry configuration of a MAC address, which are
             * not participating in any VLAN */
            for (j = 0UL; j < portCfg->macAddrListSz; j++) {
                if (((uint8_t)0) == isMacAddrFound[j]) {
                    temp = (uint8_t *)(&portCfg->fixedMacAddrList[j][0]);
                    mac = ETHSWT_NMAC2HWMAC(temp);
                    hwEntry.mac = mac;
                    hwEntry.vlanID = 0UL;
                    hwEntry.portMask = portCfg->portID;
                    hwEntry.priority = 0UL;
                    /* Compare ARL hwEntry in config */
                    if (aHwEntry->mac == hwEntry.mac) {
                        *aIsInitARLEntry = TRUE;
                        break;
                    }
                }
            }
            if (TRUE == *aIsInitARLEntry) {
                break;
            }
        }
    }
#endif
    return ret;
}

/** @brief Get ARL table

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aSwtID      Switch Index
    @param[inout]   aARLTble    Pointer to ARL table
    @param[in]      aTbleSize   ARL table size

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @retval     #BCM_ERR_INVAL_PARAMS   (Switch Index in invalid) or
                                        (aARLTble is NULL)

    @post None

    @trace #BRCM_SWREQ_ETHSWT_QUERY
    @trace #BRCM_SWARCH_ETHSWT_ARL_CMD_HANDLER_PROC
*/
static int32_t ETHSWT_DrvGetARLTable(ETHSWT_HwIDType aSwtID,
                                     ETHSWT_ARLEntryType *const aARLTbl,
                                     uint16_t *const aTblSize)
{
    uint32_t line = __LINE__;
    int32_t ret = BCM_ERR_OK;
    uint8_t reg;
    uint64_t ent0;
    uint64_t ent1;
    uint32_t result0;
    uint32_t result1;
    uint64_t macAddr;
    ETHSWT_ARLEntryType *temp;
    uint32_t inSize;
    uint32_t outSz = 0UL;
#ifdef ENABLE_ETHSWT_TCAM
    uint32_t index = 0UL;
    uint32_t arltcam_data0 = 0x0UL;
    uint32_t arltcam_data1 = 0x0UL;
    uint32_t arltcam_smemdata = 0x0UL;
#endif

    if ((aSwtID >= SWITCH_MAX_HW_ID) || (NULL == aARLTbl) ||
            (NULL == aTblSize)) {
        ret = BCM_ERR_INVAL_PARAMS;
        line = __LINE__;
        goto err_exit;
    }

    temp = aARLTbl;
    inSize = *aTblSize;

    /* start the search operation by setting STDN bit */
    ret = ETHSWT_DrvWriteReg8(aSwtID, (uint32_t)&ETHSWT_ARLRegs->m05_arla_srch_ctl,
            SWITCH_P05ASC_PAGE_05_ARLA_SRCH_CTL_ARLA_SRCH_STDN_MASK);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)

    ret = ETHSWT_DrvReadReg8(aSwtID, (uint32_t)&ETHSWT_ARLRegs->m05_arla_srch_ctl, &reg);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)

    /* read the search result until valid */
    while (((reg & SWITCH_P05ASC_PAGE_05_ARLA_SRCH_CTL_ARLA_SRCH_STDN_MASK) != 0UL) &&
            (outSz < inSize)) {
        if ((reg & SWITCH_P05ASC_PAGE_05_ARLA_SRCH_CTL_ARLA_SRCH_VLID_MASK) != 0UL) {
            /* read MACVID0/1 entry registers */
            ret = ETHSWT_DrvReadReg(aSwtID, (uint32_t)&ETHSWT_ARLRegs->m05_arla_srch_rslt_0_macvid,
                        &ent0);
            if (BCM_ERR_OK != ret) {
                break;
            }
            ret = ETHSWT_DrvReadReg(aSwtID, (uint32_t)&ETHSWT_ARLRegs->m05_arla_srch_rslt_1_macvid,
                        &ent1);
            if (BCM_ERR_OK != ret) {
                break;
            }
            ret = ETHSWT_DrvReadReg32(aSwtID, (uint32_t)&ETHSWT_ARLRegs->m05_arla_srch_rslt_0,
                        &result0);
            if (BCM_ERR_OK != ret) {
                break;
            }

            if ((result0 & SWITCH_P05ASR0_P05ASR0ASRV0_MASK) != 0UL) {
                macAddr = ent0 & SWITCH_P05ASR0M_P05ASR0MASM0_MASK;
                ETHSWT_HWMAC2NMAC(macAddr, temp[outSz].macAddr);
                temp[outSz].vlanID = (ETHER_VLANIDType)((ent0 & SWITCH_P05ASR0M_P05ASR0MASRV0_MASK) >>
                    SWITCH_P05ASR0M_P05ASR0MASRV0_SHIFT);
                temp[outSz].portMask = (ETHSWT_PortIDType)((result0
                                        & SWITCH_P05ASR0_PAGE_05_ARLA_SRCH_RSLT_0_PORTID_0_MASK)
                                        >> SWITCH_P05ASR0_PAGE_05_ARLA_SRCH_RSLT_0_PORTID_0_SHIFT);

                /* The interface expects a portmask. The register value will be      */
                /* the port index for a unicast entry and a portmask for a multicast */
                /* entry. So in case the entry is unicast, convert it into a portmask*/
                if (0x1U != (temp[outSz].macAddr[0U] & 0x1U)) {
                    temp[outSz].portMask = 0x1UL << temp[outSz].portMask;
                }

                temp[outSz].reserved = 0U;
                outSz++;
            }

            /* reading the result1 register will make hardware continue with
             * search */
            ret = ETHSWT_DrvReadReg32(aSwtID, (uint32_t)&ETHSWT_ARLRegs->m05_arla_srch_rslt_1,
                        &result1);
            if (BCM_ERR_OK != ret) {
                break;
            }
            if ((result1 & SWITCH_P05ASR0_P05ASR0ASRV0_MASK) != 0UL) {
                if (outSz < inSize) {
                    macAddr = ent1 & SWITCH_P05ASR0M_P05ASR0MASM0_MASK;
                    ETHSWT_HWMAC2NMAC(macAddr, temp[outSz].macAddr);
                    temp[outSz].vlanID = (ETHER_VLANIDType)((ent1 & SWITCH_P05ASR0M_P05ASR0MASRV0_MASK) >>
                        SWITCH_P05ASR0M_P05ASR0MASRV0_SHIFT);
                    temp[outSz].portMask = (ETHSWT_PortIDType)((result1 & SWITCH_P05ASR0_PAGE_05_ARLA_SRCH_RSLT_0_PORTID_0_MASK) >>
                        SWITCH_P05ASR0_PAGE_05_ARLA_SRCH_RSLT_0_PORTID_0_SHIFT);

                    /* The interface expects a portmask. The register value will be      */
                    /* the port index for a unicast entry and a portmask for a multicast */
                    /* entry. So in case the entry is unicast, convert it into a portmask*/
                    if (0x1U != (temp[outSz].macAddr[0U] & 0x1U)) {
                        temp[outSz].portMask = 0x1UL << temp[outSz].portMask;
                    }

                    temp[outSz].reserved = 0U;
                    outSz++;
                }
            }
        }
        ret = ETHSWT_DrvReadReg8(aSwtID, (uint32_t)&ETHSWT_ARLRegs->m05_arla_srch_ctl, &reg);
        if (BCM_ERR_OK != ret) {
            break;
        }
    }
#ifdef ENABLE_ETHSWT_TCAM
    /* Now read the entries from ARL-TCAM */
    while((outSz < inSize) && (index < SWITCH_ARL_TCAM_SIZE)) {
        /* Program the TCAM address
         * Program the operation (Read in this case)
         * Start the operation
         */
        /* Program the tcam access register for read operation with aIndex */
        ret = ETHSWT_DrvArlTcamRW(aSwtID, index, SWITCH_ARL_TCAM_READ);
        if(BCM_ERR_OK != ret) {
            break;
        }
        /* Now read ARL_TCAM_DATA0 and ARL_TCAM_DATA1 */
#if defined(__BCM8956X__) || defined(__BCM8957X__)
        ret = ETHSWT_DrvReadReg32(aSwtID, (uint32_t)&ETHSWT_ARLRegs->b0_arl_tcam_data0,
                    &arltcam_data0);
        if(BCM_ERR_OK != ret) {
            break;
        }
        ret = ETHSWT_DrvReadReg32(aSwtID, (uint32_t)&ETHSWT_ARLRegs->b0_arl_tcam_data1,
                    &arltcam_data1);
        if(BCM_ERR_OK != ret) {
            break;
        }
#else
        ret = ETHSWT_DrvReadReg32(aSwtID, (uint32_t)&ETHSWT_ARLRegs->b0_arl_tcam_data_0,
                    &arltcam_data0);
        if(BCM_ERR_OK != ret) {
            break;
        }
        ret = ETHSWT_DrvReadReg32(aSwtID, (uint32_t)&ETHSWT_ARLRegs->b0_arl_tcam_data_1,
                    &arltcam_data1);
        if(BCM_ERR_OK != ret) {
            break;
        }
#endif
        ret = ETHSWT_DrvReadReg32(aSwtID, (uint32_t)&ETHSWT_ARLRegs->b0_arl_smem_data,
                    &arltcam_smemdata);
        if(BCM_ERR_OK != ret) {
            break;
        }

        /* check if the entry is VALID. If yes, copy if there is space left in output buffer */
        if(0UL == (arltcam_smemdata & SWITCH_ARL_TCAM_SMEM_DATA_VALID_MASK)) {
            index++;
            continue;
        }
        macAddr = ((((uint64_t)((arltcam_data1 & 0xFFFFUL) << 32)) |
                          (arltcam_data0)) & SWITCH_ARL_TCAM_MACADDR_MASK);
        ETHSWT_HWMAC2NMAC(macAddr, temp[outSz].macAddr);
        temp[outSz].vlanID = (uint16_t)((arltcam_data1 & SWITCH_ARL_TCAM_VLAN_MASK) >> SWITCH_ARL_TCAM_VLAN_SHIFT);

        /* If it is UNICAST entry, get the port number and convert to port mask.
         * If it is MULTICAST entry, fetch the port mask.
         */
        if (0x1U != (temp[outSz].macAddr[0U] & 0x1U)) {
            temp[outSz].portMask = arltcam_smemdata & SWITCH_ARL_TCAM_SMEM_DATA_UNICAST_MASK;
            /* Convert to port mask as required by the interface. */
            temp[outSz].portMask = 0x1UL << temp[outSz].portMask;
        }
        else {
            temp[outSz].portMask = arltcam_smemdata & SWITCH_ARL_TCAM_SMEM_DATA_MULTICAST_MASK;
        }
        temp[outSz].reserved = 0U;
        outSz++;
        index++;
    }
#endif
    *aTblSize = (uint16_t)outSz;

err_exit:
    ETHSWT_REPORT_ERR( ret, aSwtID, line,
        BRCM_SWDSGN_ETHSWT_DRV_GET_ARL_TABLE_PROC, 0UL, 0UL, 0UL)
    return ret;
}

/** @brief Get port MAC address

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aSwtID      Switch Index
    @param[inout]   aPortID     Pointer to port ID
    @param[in]      aMacAddr    MAC Address
    @param[in]      aVlanID     VLAN ID

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @retval     #BCM_ERR_INVAL_PARAMS   aMacAddr is multicast MAC address
    @return     Others                  As returned bu #ETHSWT_DrvARLTblSearchByAddr

    @post None

    @trace #BRCM_SWARCH_ETHSWT_ARL_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_QUERY
*/
static int32_t ETHSWT_DrvGetPortMacAddr(ETHSWT_HwIDType aSwtID,
                                        ETHSWT_PortIDType *const aPortID,
                                        const uint8_t *const aMacAddr,
                                        ETHER_VLANIDType aVlanID)
{
    uint32_t binIdx;
    uint64_t mac;
    int ret = BCM_ERR_OK;

    if ((aMacAddr[0] & 0x1U) != 0U) {
        /* This is multicast MAC address */
        ret = BCM_ERR_INVAL_PARAMS;
        goto err_exit;
    }

    mac = ETHSWT_NMAC2HWMAC(aMacAddr);

    /* Hw hash based searching needs both the VLAN ID
     * and MAC Address to perfom the hash
     * indexing into the ARL table
     * Since this API does not provide the VLAN ID,
     * use the hardware linear search method
     */
    ret = ETHSWT_DrvARLTblSearchByAddr(aSwtID, mac, aVlanID, aPortID, &binIdx);

err_exit:
    return ret;
}

/** @brief Set MAC learning mode

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  aSwtID      Switch Index
    @param[in]  aPortID     Port ID
    @param[in]  aMode       MAC learning mode

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @retval     #BCM_ERR_INVAL_PARAMS   (MAC learning mode is invalid) or
                                        (Switch Index is invalid) or
                                        (Port ID is invalid)

    @post None

    @trace #BRCM_SWARCH_ETHSWT_ARL_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_DYNAMIC_CONFIGURATION
*/
static int32_t ETHSWT_DrvSetMACLearningMode(ETHSWT_HwIDType aSwtID,
                                            ETHSWT_PortIDType aPortID,
                                            ETHSWT_MacLearningModeType aMode)
{
    uint32_t line;
    uint16_t disReg;
    uint16_t swLearnCtrlReg;
    int ret = BCM_ERR_OK;


    if ((aSwtID < SWITCH_MAX_HW_ID) && (aPortID < ETHSWT_PORT_ID_MAX)) {
        ret = ETHSWT_DrvReadReg16(aSwtID, (uint32_t)&ETHSWT_ARLRegs->m00_sft_lrn_ctl,
                    &swLearnCtrlReg);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
        ret = ETHSWT_DrvReadReg16(aSwtID, (uint32_t)&ETHSWT_ARLRegs->m00_dis_learn,
                    &disReg);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)

        switch (aMode) {
            case ETHSWT_MACLEARNING_DISABLED:
                disReg |= ETHSWT_PORTID2HWMASK(aPortID);
                break;
            case ETHSWT_MACLEARNING_HW_ENABLED:
                disReg &= ~(ETHSWT_PORTID2HWMASK(aPortID));
                swLearnCtrlReg &= ~(ETHSWT_PORTID2HWMASK(aPortID));
                break;
            case ETHSWT_MACLEARNING_SW_ENABLED:
                disReg &= ~(ETHSWT_PORTID2HWMASK(aPortID));
                swLearnCtrlReg |= ETHSWT_PORTID2HWMASK(aPortID);
                break;
            default:
                ret = BCM_ERR_INVAL_PARAMS;
                break;
        }
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
        ret = ETHSWT_DrvWriteReg16(aSwtID, (uint32_t)&ETHSWT_ARLRegs->m00_sft_lrn_ctl,
                    swLearnCtrlReg);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
        ret = ETHSWT_DrvWriteReg16(aSwtID, (uint32_t)&ETHSWT_ARLRegs->m00_dis_learn,
                    disReg);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
        line = __LINE__;
    }

err_exit:
    ETHSWT_REPORT_ERR( ret, aSwtID, line,
        BRCM_SWDSGN_ETHSWT_DRV_SET_MAC_LEARNING_MODE_PROC, 0UL, 0UL, 0UL)
    return ret;
}

/** @brief Get MAC learning mode

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  aSwtID      Switch Index
    @param[in]  aPortID     Port ID
    @param[in]  aMode       Pointer to mode

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @retval     #BCM_ERR_INVAL_PARAMS   (Switch Index is invalid) or
                                        (Port ID is invalid)

    @post None

    @trace #BRCM_SWARCH_ETHSWT_ARL_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_QUERY
*/
static int32_t ETHSWT_DrvGetMACLearningMode(ETHSWT_HwIDType aSwtID,
                                            ETHSWT_PortIDType aPortID,
                                            ETHSWT_MacLearningModeType *const aMode)
{
    uint32_t line;
    uint16_t disReg;
    uint16_t swLearnCtrlReg;
    int ret = BCM_ERR_OK;

    if ((aSwtID < SWITCH_MAX_HW_ID) && (aPortID < ETHSWT_PORT_ID_MAX) &&
            (aMode != NULL)) {
        ret = ETHSWT_DrvReadReg16(aSwtID, (uint32_t)&ETHSWT_ARLRegs->m00_sft_lrn_ctl,
                    &swLearnCtrlReg);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
        ret = ETHSWT_DrvReadReg16(aSwtID, (uint32_t)&ETHSWT_ARLRegs->m00_dis_learn,
                    &disReg);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
        if ((disReg & ETHSWT_PORTID2HWMASK(aPortID)) !=  0UL) {
            *aMode = ETHSWT_MACLEARNING_DISABLED;
        } else {
            if ((swLearnCtrlReg & ETHSWT_PORTID2HWMASK(aPortID)) != 0U) {
                *aMode = ETHSWT_MACLEARNING_SW_ENABLED;
            } else {
                *aMode = ETHSWT_MACLEARNING_HW_ENABLED;
            }
        }

    } else {
        ret = BCM_ERR_INVAL_PARAMS;
        line = __LINE__;
    }

err_exit:
    ETHSWT_REPORT_ERR( ret, aSwtID, line,
        BRCM_SWDSGN_ETHSWT_DRV_GET_MAC_LEARNING_MODE_PROC, 0UL, 0UL, 0UL)
    return ret;
}

/** @brief Add ARL entry

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  aSwtID      Switch Index
    @param[in]  aARLEntry   Pointer to ARL entry

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @retval     #BCM_ERR_INVAL_PARAMS   (aARLEntry->portMask is not a part of given VLAN) or
                                        (If the entry is unicast but multiple ports are given
                                        in destination map)
    @return     Others                  As returned by #ETHSWT_DrvVLANTblRdWr or
                                        by #ETHSWT_DrvARLTblAddEntry

    @post None

    @trace #BRCM_SWARCH_ETHSWT_ARL_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_KERNEL_INTERFACE
*/
static int32_t ETHSWT_DrvAddARLEntry(ETHSWT_HwIDType aSwtID,
                                     ETHSWT_ARLEntryType *const aARLEntry)
{
    uint32_t line = __LINE__;
    uint64_t mac;
    uint8_t *temp;
    int32_t ret = BCM_ERR_OK;
    uint32_t i;
    ETHSWT_ARLTBLHWEntryType hwEntry;
    uint32_t portMask;
    uint32_t untagMap = 0UL;
    uint32_t fwdMap = 0UL;

    if ((aSwtID < SWITCH_MAX_HW_ID)
            && (aARLEntry != NULL)
            && ((aARLEntry->portMask & ((0x1UL << ETHSWT_PORT_ID_MAX) - 1UL)) != 0UL)
            && (((aARLEntry->vlanID) & (~ETHER_VLANID_MASK)) == 0U)) {
        portMask = (aARLEntry->portMask
                & ((0x1UL << ETHSWT_PORT_ID_MAX) - 1UL));

        /* If the entry is unicast, ensure that only a single port */
        /* is provided in the destination map                      */
        if (0x1U != (aARLEntry->macAddr[0U] & 0x1U)) {
            if (0UL != (aARLEntry->portMask & (aARLEntry->portMask - 1UL))) {
                ret = BCM_ERR_INVAL_PARAMS;
                line = __LINE__;
                goto err_exit;
            } else {
                /* Convert portmask to port number for unicast entry */
                for (i = 0UL; i < ETHSWT_PORT_ID_MAX; ++i) {
                    if (0UL != ((1UL << i) & aARLEntry->portMask)) {
                        portMask = i;
                        break;
                    }
                }
            }
        }
        /* read the current port map configured in the HW */
        ret = ETHSWT_DrvVLANTblRdWr(aSwtID, aARLEntry->vlanID, &untagMap, &fwdMap,
                ETHSWT_VLAN_TBL_CMD_READ);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)

        /* check the aARLEntry->portMask is a part of given vlan or not  */
        if (0UL != ((~fwdMap) & aARLEntry->portMask)){
            ret = BCM_ERR_INVAL_PARAMS;
            line = __LINE__;
            goto err_exit;
        }

        hwEntry.vlanID = aARLEntry->vlanID;
        hwEntry.portMask = (uint16_t)portMask;
        temp = aARLEntry->macAddr;
        mac = ETHSWT_NMAC2HWMAC(temp);
        hwEntry.mac = mac;
        ret = ETHSWT_DrvARLTblAddEntry(aSwtID, &hwEntry);
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
        line = __LINE__;
    }

err_exit:
    ETHSWT_REPORT_ERR( ret, aSwtID, line,
        BRCM_SWDSGN_ETHSWT_DRV_ADD_ARL_ENTRY_PROC, 0UL, 0UL, 0UL)
    return ret;
}

/** @brief Delete ARL entry

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  aSwtID      Switch Index
    @param[in]  aARLEntry   Pointer to ARL entry

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @retval     #BCM_ERR_INVAL_PARAMS   (aSwtID is invalid) or
                                        (aARLEntry is NULL)
    @retval     #BCM_ERR_NOPERM         If this ARL entry is present in switch configuration
    @return     Others                  As returned by #ETHSWT_DrvIsARLEntryInitConfig or
                                        by #ETHSWT_DrvARLTblDeleteEntry

    @post None

    @trace #BRCM_SWARCH_ETHSWT_ARL_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_DYNAMIC_CONFIGURATION
*/
static int32_t ETHSWT_DrvDeleteARLEntry(ETHSWT_HwIDType aSwtID,
                                        ETHSWT_ARLEntryType *const aARLEntry)
{
    uint64_t mac;
    uint8_t *temp;
    int32_t ret = BCM_ERR_OK;
    ETHSWT_ARLTBLHWEntryType hwEntry;
    uint32_t isInitARLEntry = FALSE;

    if ((aSwtID < SWITCH_MAX_HW_ID)
            && (aARLEntry != NULL)
            && (((aARLEntry->vlanID) & (~ETHER_VLANID_MASK)) == 0U)) {

        /* find if the entry already exits in the ARL table
         * if yes, delete the entry
         */
        hwEntry.vlanID = aARLEntry->vlanID;
        hwEntry.portMask = 0U;
        temp = aARLEntry->macAddr;
        mac = ETHSWT_NMAC2HWMAC(temp);
        hwEntry.mac = mac;
        /* Search if this ARL entry is present in switch
         * config, if so then this ARL entry should not be
         * deleted */
        ret = ETHSWT_DrvIsARLEntryInitConfig(aSwtID, &hwEntry, &isInitARLEntry);
        if (BCM_ERR_OK == ret) {
            if (TRUE == isInitARLEntry) {
                ret = BCM_ERR_NOPERM;
            } else {
                ret = ETHSWT_DrvARLTblDeleteEntry(aSwtID, &hwEntry);
            }
        }
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }

    return ret;
}

/** @brief Set Age

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  aSwtID  Switch Index
    @param[in]  aAge    Age

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @retval     #BCM_ERR_INVAL_PARAMS   (aSwtID is invalid) or
                                        (aAge is invalid)

    @post None

    @trace #BRCM_SWARCH_ETHSWT_ARL_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_DYNAMIC_CONFIGURATION
*/
static int32_t ETHSWT_DrvSetAge(ETHSWT_HwIDType aSwtID,
                                uint32_t aAge)
{
    uint32_t line;
    uint32_t reg;
    int ret = BCM_ERR_OK;

    if ((aSwtID < SWITCH_MAX_HW_ID)
            && (aAge < SWITCH_BCM895XX_AGE_TIMER_MAX)) {

        /* Update the aging timer control register */
        ret = ETHSWT_DrvReadReg32(aSwtID, (uint32_t)&ETHSWT_ARLRegs->m02_sptagt, &reg);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
        reg &= ~SWITCH_PAGE_02_SPTAGT_AGE_TIME_MASK;
        reg |= SWITCH_PAGE_02_SPTAGT_AGE_CHANGE_EN_MASK;
        reg |= aAge & SWITCH_PAGE_02_SPTAGT_AGE_TIME_MASK;

        ret = ETHSWT_DrvWriteReg32(aSwtID, (uint32_t)&ETHSWT_ARLRegs->m02_sptagt, reg);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)

    } else {
        ret = BCM_ERR_INVAL_PARAMS;
        line = __LINE__;
    }

err_exit:
    ETHSWT_REPORT_ERR( ret, aSwtID, line,
        BRCM_SWDSGN_ETHSWT_DRV_SET_AGE_PROC, 0UL, 0UL, 0UL)
    return ret;
}

/** @brief Get Age

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aSwtID  Switch Index
    @param[inout]   aAge    Pointer to age

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @retval     #BCM_ERR_INVAL_PARAMS   (aSwtID is invalid) or
                                        (aAge is NULL)

    @post None

    @trace #BRCM_SWREQ_ETHSWT_QUERY
    @trace #BRCM_SWARCH_ETHSWT_ARL_CMD_HANDLER_PROC
*/
static int32_t ETHSWT_DrvGetAge(ETHSWT_HwIDType aSwtID,
                                uint32_t *const aAge)
{
    uint32_t line = 0UL;
    uint32_t reg;
    int ret = BCM_ERR_OK;

    if ((aSwtID < SWITCH_MAX_HW_ID) && (NULL != aAge)) {
        ret = ETHSWT_DrvReadReg32(aSwtID, (uint32_t)&ETHSWT_ARLRegs->m02_sptagt, &reg);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
        *aAge = reg & SWITCH_PAGE_02_SPTAGT_AGE_TIME_MASK;

    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }

err_exit:
    ETHSWT_REPORT_ERR( ret, aSwtID, line,
        BRCM_SWDSGN_ETHSWT_DRV_GET_AGE_PROC, 0UL, 0UL, 0UL)
    return ret;
}

/** @brief Add ARL entry

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  aSwtID      Switch Index
    @param[in]  aMacAddr    Pointer to Mac Address

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             ARL Addeed Successfully
    @retval     #BCM_ERR_NOMEM          No memory available to add a entry
    @retval     #BCM_ERR_INVAL_PARAMS   (aSwtID is invalid) or
                                        (aMacAddr is NULL) or
                                        (aMacAddr is 0) or
                                        (aMacAddr is Multicast) or
                                        (Invalid port mask)

    @post None

    @trace #BRCM_SWARCH_ETHSWT_ARL_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_KERNEL_INTERFACE

    @limitations None

    @code{.c}
    mac = ETHSWT_NMAC2HWMAC(aMacAddr)
    for(i=0UL; i< ETHSWT_MAX_MYDA_ENTRIES; ++i)
        regAdd = (uint32_t)&ETHSWT_ARLRegs->m06_arl_myda_ctl0 + i * 0x8
        ret = ETHSWT_DrvReadReg(aSwtID, regAdd, &regVal)
        if(BCM_ERR_OK != ret)
            line = __LINE__
            break
        if((regVal & SWITCH_PAGE_06_ARL_MYDA_CTL_MYDA_MAC_MASK) == mac)
            ret=BCM_ERR_OK
            break
        if(0UL == regVal)
            freeSlot = i;
    if (i < ETHSWT_MAX_MYDA_ENTRIES)
        goto err_exit
    else
        if (freeSlot == ETHSWT_MAX_MYDA_ENTRIES)
            ret=BCM_ERR_NOMEM
        else
            regAdd = (uint32_t)&ETHSWT_ARLRegs->m06_arl_myda_ctl0 + (freeSlot * 0x8)
            regVal = (((uint64_t)aPortMask << SWITCH_PAGE_06_ARL_MYDA_CTL_MYDA_SRC_PORT_MASK_SHIFT) | mac)
            ret = ETHSWT_DrvWriteReg(aSwtID, regAdd, regVal)
            ETHSWT_CHECK_ERR(ret, &line, err_exit)
    err_exit:
    Check and Report Error if any
    ETHSWT_REPORT_ERR( ret, aSwtID, line,
        BRCM_SWDSGN_ETHSWT_DRV_ADD_ARL_MYDA_ENTRY_PROC, 0UL, 0UL, 0UL)
    return ret
    @endcode
*/
static int32_t ETHSWT_DrvAddARLMyDAEntry(ETHSWT_HwIDType aSwtID,
                                   uint16_t aPortMask,
                                   const uint8_t *const aMacAddr)
{
    int32_t ret = BCM_ERR_OK;
#ifdef ENABLE_ETHSWT_MYDA
    uint32_t line = __LINE__;
    uint32_t freeSlot = ETHSWT_MAX_MYDA_ENTRIES;
    uint32_t regAdd;
    uint64_t mac;
    uint64_t regVal;
    uint32_t i;

    /* Find if the entry already exsits in the ARL table.
     *    If yes then return BCM_ERR_OK.
     *    If Not Found check for the available Memory
     *    If enough Memory then add the entry
     *    If no Memory then return Error
     */
    mac = ETHSWT_NMAC2HWMAC(aMacAddr);
    for(i=0UL; i< ETHSWT_MAX_MYDA_ENTRIES; ++i) {
        regAdd = (uint32_t)&ETHSWT_ARLRegs->m06_arl_myda_ctl0 + i * 0x8UL;
        ret = ETHSWT_DrvReadReg(aSwtID, regAdd, &regVal);
        if(BCM_ERR_OK != ret) {
            line = __LINE__;
            break;
        }
        if((regVal & SWITCH_PAGE_06_ARL_MYDA_CTL_MYDA_MAC_MASK) == mac) {
            ret=BCM_ERR_OK;
            break;
        }
        if ((0UL == regVal) && (ETHSWT_MAX_MYDA_ENTRIES == freeSlot)) {
            freeSlot = i;
        }
    }

    if (i < ETHSWT_MAX_MYDA_ENTRIES) {
        goto err_exit;
    } else {
        if (freeSlot == ETHSWT_MAX_MYDA_ENTRIES) {
            ret=BCM_ERR_NOMEM;
        } else {
            regAdd = (uint32_t)&ETHSWT_ARLRegs->m06_arl_myda_ctl0 + (freeSlot * 0x8UL);
            regVal = (((uint64_t)aPortMask << SWITCH_PAGE_06_ARL_MYDA_CTL_MYDA_SRC_PORT_MASK_SHIFT) | mac);
            ret = ETHSWT_DrvWriteReg(aSwtID, regAdd, regVal);
            ETHSWT_CHECK_ERR(ret, &line, err_exit)
        }
    }
err_exit:
    ETHSWT_REPORT_ERR( ret, aSwtID, line,
        BRCM_SWDSGN_ETHSWT_DRV_ADD_ARL_MYDA_ENTRY_PROC, 0UL, 0UL, 0UL)
#else
        ret = BCM_ERR_NOSUPPORT;
#endif
    return ret;
}

/** @brief Delete ARL MyDA entry

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  aSwtID      Switch Index
    @param[in]  aMacAddr    Pointer to Mac Address

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @retval     #BCM_ERR_NOT_FOUND      Entry not found in ARL tabl
    @retval     #BCM_ERR_INVAL_PARAMS   (aSwtID is invalid) or
                                        (aMacAddr is NULL)

    @post None

    @trace #BRCM_SWARCH_ETHSWT_ARL_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_DYNAMIC_CONFIGURATION

    @limitations None

    @code{.c}
    mac = ETHSWT_NMAC2HWMAC(aMacAddr)
    for(i=0; i< ETHSWT_MAX_MYDA_ENTRIES; i++)
        regAdd = (uint32_t)&ETHSWT_ARLRegs->m06_arl_myda_ctl0 + i * 0x8
        ret = ETHSWT_DrvReadReg(aSwtID, regAdd, &regVal)
        if(BCM_ERR_OK != ret)
            line = __LINE__
            break
        if((regVal & SWITCH_PAGE_06_ARL_MYDA_CTL_MYDA_MAC_MASK) == mac)
            regVal = 0UL
            ret = ETHSWT_DrvWriteReg(aSwtID, regAdd, regVal)
            line = __LINE__;
            break
    if(ETHSWT_MAX_MYDA_ENTRIES == i)
        ret=BCM_ERR_NOT_FOUND
    ETHSWT_REPORT_ERR( ret, aSwtID, line,
        BRCM_SWDSGN_ETHSWT_DRV_DELETE_ARL_MYDA_ENTRY_PROC, 0UL, 0UL, 0UL)
    return ret
    @endcode
*/
static int32_t ETHSWT_DrvDeleteARLMyDAEntry(ETHSWT_HwIDType aSwtID,
                                   const uint8_t *const aMacAddr)
{
    int32_t ret = BCM_ERR_OK;
#ifdef ENABLE_ETHSWT_MYDA
    uint32_t line = __LINE__;
    uint32_t regAdd;
    uint64_t mac;
    uint64_t regVal;
    uint8_t i;

    /* Find if the entry exsits in the ARL table.
        If yes, Delete that entry.
        If Not Found then return Error
    */
    mac = ETHSWT_NMAC2HWMAC(aMacAddr);
    for(i=0U; i< ETHSWT_MAX_MYDA_ENTRIES; i++) {
        regAdd = (uint32_t)&ETHSWT_ARLRegs->m06_arl_myda_ctl0 + i * 0x8U;
        ret = ETHSWT_DrvReadReg(aSwtID, regAdd, &regVal);
        if(BCM_ERR_OK != ret) {
            line = __LINE__;
            break;
        }
        if((regVal & SWITCH_PAGE_06_ARL_MYDA_CTL_MYDA_MAC_MASK) == mac) {
            regVal = 0UL;
            ret = ETHSWT_DrvWriteReg(aSwtID, regAdd, regVal);
            line = __LINE__;
            break;
        }
    }

    if(ETHSWT_MAX_MYDA_ENTRIES == i) {
        line = __LINE__;
        ret=BCM_ERR_NOT_FOUND;
    }
    ETHSWT_REPORT_ERR( ret, aSwtID, line,
        BRCM_SWDSGN_ETHSWT_DRV_DELETE_ARL_MYDA_ENTRY_PROC, 0UL, 0UL, 0UL)
#else
        ret = BCM_ERR_NOSUPPORT;
#endif
    return ret;
}

/** @brief Get ARL MyDA entry

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aSwtID      Switch Index
    @param[inout]   aARLTble    Pointer to myDA ARL table
    @param[in]      aTbleSize   No of ARL entries

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @retval     #BCM_ERR_INVAL_PARAMS   (Switch Index in invalid) or
                                        (aARLTble is NULL)
                                        (aTblSize is 0)

    @post None

    @trace #BRCM_SWARCH_ETHSWT_ARL_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_QUERY

    @limitations None

    @code{.c}
    inSize = *aTblSize
    for(i=0; i< inSize; i++)
        regAdd = (uint32_t)&ETHSWT_ARLRegs->m06_arl_myda_ctl0 + i * 0x8
        ret = ETHSWT_DrvReadReg(aSwtID, regAdd, &regVal)
        if(BCM_ERR_OK != ret)
            break;
        macAddr = (regVal & SWITCH_PAGE_06_ARL_MYDA_CTL_MYDA_MAC_MASK)
        If macAddr is available then copy
        if(0UL != macAddr)
            ETHSWT_HWMAC2NMAC(macAddr, aARLTbl[macCnt].macAddr)
            keep tracking no of available mac Address
            macCnt++
    aTblSize = macCnt;

    ETHSWT_REPORT_ERR( ret, aSwtID, line,
        BRCM_SWDSGN_ETHSWT_DRV_GET_ARL_MYDA_SNAPSHOT_PROC, 0UL, 0UL, 0UL)
    return ret;
    @endcode
*/
static int32_t ETHSWT_DrvGetARLMyDASnapshot(ETHSWT_HwIDType aSwtID,
                                     ETHSWT_ARLEntryType *const aARLTbl,
                                     uint16_t *const aTblSize)
{
    int32_t ret = BCM_ERR_OK;
#ifdef ENABLE_ETHSWT_MYDA
    uint32_t line = __LINE__;
    uint32_t regAdd;
    uint64_t regVal;
    uint32_t macCnt = 0UL;
    uint64_t macAddr;
    uint8_t i;

    for(i = 0U; i< ETHSWT_MAX_MYDA_ENTRIES; i++) {
        regAdd = (uint32_t)&ETHSWT_ARLRegs->m06_arl_myda_ctl0 + i * 0x8U;
        ret = ETHSWT_DrvReadReg(aSwtID, regAdd, &regVal);
        if(BCM_ERR_OK != ret) {
            line = __LINE__;
            break;
        }
        macAddr = (regVal & SWITCH_PAGE_06_ARL_MYDA_CTL_MYDA_MAC_MASK);
        /* If macAddr is available then copy */
        if(0UL != macAddr) {
            ETHSWT_HWMAC2NMAC(macAddr, aARLTbl[macCnt].macAddr);
            /* keep tracking no of available mac Address */
            macCnt++;
        }
    }
    *aTblSize = (uint16_t)macCnt;

    ETHSWT_REPORT_ERR( ret, aSwtID, line,
        BRCM_SWDSGN_ETHSWT_DRV_GET_ARL_MYDA_SNAPSHOT_PROC, 0UL, 0UL, 0UL)
#else
        ret = BCM_ERR_NOSUPPORT;
#endif
    return ret;
}

#ifdef ENABLE_ETHSWT_SECURITY
/**
    @brief Set station movement detection(enable with action/disable)

    If station movement detection is enabled and a MAC address
    has been learned by hardware on a port, and a packet with
    the same address as MAC-SA enters the switch from a different
    physical port, then it should be discarded or sent to the CPU.

    @behavior Sync, Non re-entrant

    @pre None

    @param[in]      aSwtID                   Switch index
    @param[in]      aPortID                  Port index
    @param[in]      aSMDetectAction          Station movement
                                             detection action

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully set station movement
                                        detection information
    @retval     #BCM_ERR_TIME_OUT       Timeout occurred while reading/writing
                                        switch register

    @post None

    @code{.c}
    ret = ERR_OK

    Read the Station Movement Control Register (PAGE_04_ARL_SA_MOVE_CTL)
    if aSMDetectAction is disable station movement detection
         clear the port enable bit(PAGE_04_ARL_SA_MOVE_CTL_SA_MOVE_DIS[8:0])
    else
         Set the port enable bit(PAGE_04_ARL_SA_MOVE_CTL_SA_MOVE_DIS[8:0])
        smAction = (aSMDetectAction == ETHSWT_SECURITY_ACTION_DROP_PKT) ?
                              SWITCH_PAGE_04_SA_MOVE_ACT_DROP_PKT :
                              SWITCH_PAGE_04_SA_MOVE_ACT_REDIRECT_TO_CPU;
         Write the port smAction bit(PAGE_04_ARL_SA_MOVE_CTL_SA_MOVE_CTL[24:16])
    Write the Station Movement Control Register (PAGE_04_ARL_SA_MOVE_CTL)
    err_exit:
    ETHSWT_REPORT_ERR( ret, aSwtID, line,
        BRCM_SWDSGN_ETHSWT_DRV_SET_STATIONMOVEMENTDETECTION_PROC, 0UL, 0UL, 0UL)
    return ret;
    @endcode
    @trace #BRCM_SWARCH_ETHSWT_ARL_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION
 */
static int32_t ETHSWT_DrvSetStationMovementDetection(ETHSWT_HwIDType aSwtID,
            ETHSWT_PortIDType aPortID,
            ETHSWT_SecurityActionType aSMDetectAction)
{
    uint32_t line;
    uint32_t reg;
    int32_t ret = BCM_ERR_OK;
    uint64_t smAction;

    /* Read the Station Movement Control Register */
    ret = ETHSWT_DrvReadReg32(aSwtID, (uint32_t)&ETHSWT_ARLRegs->m04_arl_sa_move_ctl, &reg);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    if(ETHSWT_SECURITY_ACTION_DISABLED == aSMDetectAction) {
        reg &= (~(1ULL << aPortID));
    } else {
        reg &= (~((1ULL << aPortID) << SWITCH_P04ASMC_PAGE_04_ARL_SA_MOVE_CTL_SA_MOVE_CTL_SHIFT));
        reg |= 1ULL << aPortID;
        smAction = (aSMDetectAction == ETHSWT_SECURITY_ACTION_DROP_PKT) ?
                              SWITCH_PAGE_04_SA_MOVE_ACT_DROP_PKT :
                              SWITCH_PAGE_04_SA_MOVE_ACT_REDIRECT_TO_CPU;
        reg |= ((smAction << aPortID) << SWITCH_P04ASMC_PAGE_04_ARL_SA_MOVE_CTL_SA_MOVE_CTL_SHIFT);
    }
    /* write the Station Movement Control Register */
    ret = ETHSWT_DrvWriteReg32(aSwtID, (uint32_t)&ETHSWT_ARLRegs->m04_arl_sa_move_ctl, reg);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
err_exit:
    ETHSWT_REPORT_ERR( ret, aSwtID, line,
        BRCM_SWDSGN_ETHSWT_DRV_SET_STATIONMOVEMENTDETECTION_PROC, 0UL, 0UL, 0UL)
    return ret;
}

/**
   @brief Get station movement detection(enable/disable) status

    This function retreives switch station movement detection
    informations.

    @behavior Sync, Non re-entrant

    @pre None

    @param[in]      aSwtID                   Switch index
    @param[in]      aPortID                  Port index
    @param[out]     aSMDetectAction          Pointer to station movement
                                             detection action

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully retrieved station movement
                                        detection information
    @retval     #BCM_ERR_TIME_OUT       Timeout occurred while reading/writing
                                        switch register

    @post None

    @code{.c}
    ret = ERR_OK

    Read the Station Movement Control Register (PAGE_04_ARL_SA_MOVE_CTL)
    isEnable = port enable bit
                        (PAGE_04_ARL_SA_MOVE_CTL_SA_MOVE_DIS[8:0])
    if(TRUE == isEnable) {
        smAction =  port action bit
                           (PAGE_04_ARL_SA_MOVE_CTL_SA_MOVE_CTL[24:16])
        if(SWITCH_PAGE_04_SA_MOVE_ACT_DROP_PKT == smAction) {
            action = ETHSWT_SECURITY_ACTION_DROP_PKT;
        } else {
            action = ETHSWT_SECURITY_ACTION_REDIRECT_TO_CPU;
        }
    } else {
        action = ETHSWT_SECURITY_ACTION_DISABLED;
    }
    *aSMDetectAction = action

    err_exit:
    ETHSWT_REPORT_ERR( ret, aSwtID, line,
        BRCM_SWDSGN_ETHSWT_DRV_GET_STATIONMOVEMENTDETECTION_PROC, 0UL, 0UL, 0UL)
    return ret;
    @endcode
    @trace #BRCM_SWARCH_ETHSWT_ARL_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_QUERY
 */
static int32_t ETHSWT_DrvGetStationMovementDetection(ETHSWT_HwIDType aSwtID,
            ETHSWT_PortIDType aPortID,
            ETHSWT_SecurityActionType * const aSMDetectAction)
{
    uint32_t line;
    uint32_t reg;
    int32_t ret = BCM_ERR_OK;
    uint32_t isEnable;
    ETHSWT_SecurityActionType action;
    uint32_t smAction;

    /* Read the Station Movement Control Register */
    ret = ETHSWT_DrvReadReg32(aSwtID, (uint32_t)&ETHSWT_ARLRegs->m04_arl_sa_move_ctl, &reg);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    isEnable = (uint32_t)((reg >> aPortID) & 0x1ULL);
    if(TRUE == isEnable) {
        reg = ((reg & SWITCH_P04ASMC_PAGE_04_ARL_SA_MOVE_CTL_SA_MOVE_CTL_MASK)
                 >> SWITCH_P04ASMC_PAGE_04_ARL_SA_MOVE_CTL_SA_MOVE_CTL_SHIFT);
        smAction = (uint32_t)((reg >> aPortID) & 0x1ULL);
        if(SWITCH_PAGE_04_SA_MOVE_ACT_DROP_PKT == smAction) {
            action = ETHSWT_SECURITY_ACTION_DROP_PKT;
        } else {
            action = ETHSWT_SECURITY_ACTION_REDIRECT_TO_CPU;
        }
    } else {
        action = ETHSWT_SECURITY_ACTION_DISABLED;
    }
    *aSMDetectAction = action;
err_exit:
    ETHSWT_REPORT_ERR( ret, aSwtID, line,
        BRCM_SWDSGN_ETHSWT_DRV_GET_STATIONMOVEMENTDETECTION_PROC, 0UL, 0UL, 0UL)
    return ret;
}

/**
    @brief Set address limiting information of the port

    This function sets the maximum number of MAC addresses that are learned on
    the port. Only limits the number of dynamically learned unicast
    MAC addresses. MAC addresses configured by the CPU are not counted
    against the limit. Function also sets the action, which will be triggered
    if the count of dynamically learned unicast MAC addresses on this
    port exceeds with the programmed value.

    @behavior Sync, Non re-entrant

    @pre None

    @param[in]      aSwtID                   Switch index
    @param[in]      aPortID                  Port index
    @param[in]      aAddressLimitInfo        Pointer to address limiting
                                             information

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully set address limiting information
                                        for the port
    @retval     #BCM_ERR_TIME_OUT       Timeout occurred while reading/writing
                                        switch register

    @post None

    @code{.c}
    ret = ERR_OK

    action   = aAddressLimitInfo->overLimitAction
    limit    = aAddressLimitInfo->macLearningLimit

    Read the SA Limit Enable Register (PAGE_45_SA_LIMIT_ENABLE)
    Read the Port N (N = aPortID) SA Limit Control Register
                             (PAGE_45_PORT_N_SA_LIMIT_CTL)
    (PAGE_45_PORT_N_SA_LIMIT_CTL = PAGE_45_PORT_0_SA_LIMIT_CTL + (2 * N))
    if action is ETHSWT_SECURITY_ACTION_DISABLED
        Clear the port enable bit(PAGE_45_SA_LIMIT_ENABLE_SA_LIMIT_EN[8:0])
    else
        Set the port enable bit(PAGE_45_SA_LIMIT_ENABLE_SA_LIMIT_EN[8:0])
        switch (action) {
            case ETHSWT_SECURITY_ACTION_DROP_PKT:
                alAction = SWITCH_PAGE_45_OVER_LIMIT_ACT_DROP_PKT;
                break;
            case ETHSWT_SECURITY_ACTION_NORMAL:
                alAction = SWITCH_PAGE_45_OVER_LIMIT_ACT_NORMAL;
                break;
            case ETHSWT_SECURITY_ACTION_REDIRECT_TO_CPU:
                alAction = SWITCH_PAGE_45_OVER_LIMIT_ACT_REDIRECT_TO_CPU;
                break;
            default:
                alAction = SWITCH_PAGE_45_OVER_LIMIT_ACT_COPY_TO_CPU;
                break;
        }
        Set the overlimit action bits(PAGE_45_PORT_N_SA_LIMIT_CTL_OVER_LIMIT_ACTIONS[15:14])
        Set the learn limit bits(PAGE_45_PORT_N_SA_LIMIT_CTL_SA_LRN_CNT_LIM[12:0])

    if(ETHSWT_SECURITY_ACTION_DISABLED != action) {
        Reset the Port N SA Learn counter value (SWITCH_PAGE_45_PORT_N_SA_LRN_CNTR[12:0])
        (SWITCH_PAGE_45_PORT_N_SA_LRN_CNTR = SWITCH_PAGE_45_PORT_0_SA_LRN_CNTR + (2 * N))
        Set the Port N SA overlimit counter bit
                   (PAGE_45_SA_OVERLIMIT_CNTR_RST_PORT_SA_OVER_LIMIT_CNTR_RST[8:0])
    }
    Write the Port N SA Limit Control Register (PAGE_45_PORT_N_SA_LIMIT_CTL)
    Write the SA Limit Enable Register (PAGE_45_SA_LIMIT_ENABLE)

    err_exit:
    ETHSWT_REPORT_ERR( ret, aSwtID, line,
        BRCM_SWDSGN_ETHSWT_DRV_SET_PORT_ADDRESS_LIMITING_PROC, 0UL, 0UL, 0UL)
    return ret;
    @endcode
    @trace #BRCM_SWARCH_ETHSWT_ARL_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION
 */
static int32_t ETHSWT_DrvSetPortAddressLimiting(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID,
        const ETHSWT_AddressLimitingType * const aAddressLimitInfo)
{
    uint32_t line;
    uint16_t reg;
    uint16_t regCtrl;
    uint16_t regCntr;
    int32_t ret = BCM_ERR_OK;
    ETHSWT_SecurityActionType action;
    uint64_t alAction;
    uint64_t limit;

    action = aAddressLimitInfo->overLimitAction;
    limit = aAddressLimitInfo->macLearningLimit;
    /* Read the SA Limit Enable Register */
    ret = ETHSWT_DrvReadReg16(aSwtID, (uint32_t)&ETHSWT_ARLRegs->m45_sa_limit_enable, &reg);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    /* Read the Port N SA Limit Control Register */
    ret = ETHSWT_DrvReadReg16(aSwtID, (uint32_t)(&ETHSWT_ARLRegs->m45_port_0_sa_limit_ct[aPortID]), &regCtrl);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)

    if(ETHSWT_SECURITY_ACTION_DISABLED == action) {
        reg &= (~(1U << aPortID));
    } else {
        reg |= (1U << aPortID);
        regCtrl &= (~SWITCH_P45P0SLC_P45P0SLCSLCL_MASK);
        regCtrl &= (~SWITCH_P45P0SLC_P45P0SLCOLA_MASK);
        regCtrl |= (limit & SWITCH_P45P0SLC_P45P0SLCSLCL_MASK);
        switch (action) {
            case ETHSWT_SECURITY_ACTION_DROP_PKT:
                alAction = SWITCH_PAGE_45_OVER_LIMIT_ACT_DROP_PKT;
                break;
            case ETHSWT_SECURITY_ACTION_NORMAL:
                alAction = SWITCH_PAGE_45_OVER_LIMIT_ACT_NORMAL;
                break;
            case ETHSWT_SECURITY_ACTION_REDIRECT_TO_CPU:
                alAction = SWITCH_PAGE_45_OVER_LIMIT_ACT_REDIRECT_TO_CPU;
                break;
            default:
                alAction = SWITCH_PAGE_45_OVER_LIMIT_ACT_COPY_TO_CPU;
                break;
        }
        regCtrl |= ((alAction << SWITCH_P45P0SLC_P45P0SLCOLA_SHIFT) & SWITCH_P45P0SLC_P45P0SLCOLA_MASK);
    }

    if(ETHSWT_SECURITY_ACTION_DISABLED != action) {
        /* Reset the Port N SA Learn counter Register should be performed before
           enabling the feature */
        ret = ETHSWT_DrvReadReg16(aSwtID, (uint32_t)(&ETHSWT_ARLRegs->m45_port_0_sa_lrn_cnt[aPortID]), &regCntr);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
        regCntr &= (~SWITCH_P45P0SLC1_PAGE_45_PORT_0_SA_LRN_CNTR_SA_LRN_CNT_NO_MASK);
        ret = ETHSWT_DrvWriteReg16(aSwtID, (uint32_t)(&ETHSWT_ARLRegs->m45_port_0_sa_lrn_cnt[aPortID]), regCntr);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
        /* Reset the Port N SA overlimit counter Register should be performed before
           enabling the feature */
        ret = ETHSWT_DrvReadReg16(aSwtID, (uint32_t)(&ETHSWT_ARLRegs->m45_sa_overlimit_cntr_rst), &regCntr);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
        regCntr |= (1ULL << aPortID);
        ret = ETHSWT_DrvWriteReg16(aSwtID, (uint32_t)(&ETHSWT_ARLRegs->m45_sa_overlimit_cntr_rst), regCntr);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
    }

    /* write the Port N SA Limit Control Register */
    ret = ETHSWT_DrvWriteReg16(aSwtID, (uint32_t)(&ETHSWT_ARLRegs->m45_port_0_sa_limit_ct[aPortID]), regCtrl);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)

    /* write the SA Limit Enable Register */
    ret = ETHSWT_DrvWriteReg16(aSwtID, (uint32_t)&ETHSWT_ARLRegs->m45_sa_limit_enable, reg);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)

err_exit:
    ETHSWT_REPORT_ERR( ret, aSwtID, line,
        BRCM_SWDSGN_ETHSWT_DRV_SET_PORT_ADDRESS_LIMITING_PROC, 0UL, 0UL, 0UL)
    return ret;
}

/**
    @brief Get address limiting information for the port

    This function retreives switch address limiting information
    of the provided port.

    @behavior Sync, Non re-entrant

    @pre None

    @param[in]      aSwtID                   Switch index
    @param[in]      aPortID                  Port index
    @param[out]     aAddressLimitInfo        Pointer to address limiting
                                             action
    @param[out]     aPortLearnedCounter      pointer to the number
                                             of SA MAC addresses
                                             learned on this ports.
                                             This counter can't exceed
                                             the max programmed learning
                                             value of this port
    @param[out]     aPortOverLimitCounter    pointer to the overlimit
                                             counter value of this ports.
                                             This counter is the number of
                                             packets ingress to this port after
                                             port SA learn counter exceeds to
                                             SA learn limit.

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully retrieved address limiting
                                        information of the provided port
    @retval     #BCM_ERR_TIME_OUT       Timeout occurred while reading/writing
                                        switch register

    @post None

    @code{.c}
    ret = ERR_OK

    Read the SA Limit Enable Register (PAGE_45_SA_LIMIT_ENABLE)
    isEnable = port enable bit
               (PAGE_45_SA_LIMIT_ENABLE_SA_LIMIT_EN[8:0])

    if(TRUE == isEnable) {
        Read the Port N SA Limit Control Register (PAGE_45_PORT_N_SA_LIMIT_CTL)
        (PAGE_45_PORT_N_SA_LIMIT_CTL = PAGE_45_PORT_0_SA_LIMIT_CTL + (N * 2))
        alAction = port action bits
                            (PAGE_45_PORT_N_SA_LIMIT_CTL_OVER_LIMIT_ACTIONS[15:14])
        switch (alAction) {
            case SWITCH_PAGE_45_OVER_LIMIT_ACT_NORMAL:
                action = ETHSWT_SECURITY_ACTION_NORMAL;
                break;
            case SWITCH_PAGE_45_OVER_LIMIT_ACT_DROP_PKT:
                action = ETHSWT_SECURITY_ACTION_DROP_PKT;
                break;
            case SWITCH_PAGE_45_OVER_LIMIT_ACT_COPY_TO_CPU:
                action = ETHSWT_SECURITY_ACTION_COPY_TO_CPU;
                break;
            default:
                action = ETHSWT_SECURITY_ACTION_REDIRECT_TO_CPU;
                break;
        }
        aAddressLimitInfo->macLearningLimit = port control limit bits
                            (PAGE_45_PORT_N_SA_LIMIT_CTL_SA_LRN_CNT_LIM)
        Read the Port N SA Learn counter Register (SWITCH_PAGE_45_PORT_N_SA_LRN_CNTR)
        (SWITCH_PAGE_45_PORT_N_SA_LRN_CNTR = SWITCH_PAGE_45_PORT_0_SA_LRN_CNTR + (2 * N))
        *aPortLearnedCounter = Port N SA Learn counter bits
                              (SWITCH_P45P0SLC1_PAGE_45_PORT_N_SA_LRN_CNTR_SA_LRN_CNT[12:0])

        Read the Port N SA overlimit counter Register (SWITCH_PAGE_45_PORT_N_SA_OVERLIMIT_CNTR)
        (SWITCH_PAGE_45_PORT_N_SA_OVERLIMIT_CNTR = SWITCH_PAGE_45_PORT_0_SA_OVERLIMIT_CNTR + (4 * N))
        *aPortOverLimitCounter = Port N SA overlimit counter bits
                              (PAGE_45_PORT_0_SA_OVERLIMIT_CNTR_SA_OVER_LIMIT_CNTR[31:0])
    } else {
        action = ETHSWT_SECURITY_ACTION_DISABLED;
        aAddressLimitInfo->macLearningLimit = ETHSWT_ARL_SIZE;
        *aPortLearnedCounter = 0x0U;
        *aPortOverLimitCounter = 0x0UL;
    }
    aAddressLimitInfo->overLimitAction = action;

    err_exit:
    ETHSWT_REPORT_ERR( ret, aSwtID, line,
        BRCM_SWDSGN_ETHSWT_DRV_GET_ADDR_LIMIT_AND_COUNTER_PROC, 0UL, 0UL, 0UL)
    return ret;
    @endcode
    @trace #BRCM_SWARCH_ETHSWT_ARL_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_QUERY
 */
static int32_t ETHSWT_DrvGetPortAddrLimitAndCounter(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID,
        ETHSWT_AddressLimitingType * const aAddressLimitInfo,
        uint16_t * const aPortLearnedCounter,
        uint32_t * const aPortOverLimitCounter)
{
    uint32_t line;
    uint16_t reg;
    uint16_t regCtrl;
    int32_t ret = BCM_ERR_OK;
    uint32_t isEnable;
    uint16_t alAction;
    ETHSWT_SecurityActionType action;

    /* Read the SA Limit Enable Register */
    ret = ETHSWT_DrvReadReg16(aSwtID, (uint32_t)&ETHSWT_ARLRegs->m45_sa_limit_enable, &reg);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    isEnable = (uint32_t)((reg >> aPortID) & 0x1U);

    if(TRUE == isEnable) {
        /* Read the Port N SA Limit Control Register */
        ret = ETHSWT_DrvReadReg16(aSwtID, (uint32_t)(&ETHSWT_ARLRegs->m45_port_0_sa_limit_ct[aPortID]), &regCtrl);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
        alAction = (regCtrl & SWITCH_P45P0SLC_P45P0SLCOLA_MASK)
                                              >> SWITCH_P45P0SLC_P45P0SLCOLA_SHIFT;
        switch (alAction) {
            case SWITCH_PAGE_45_OVER_LIMIT_ACT_NORMAL:
                action = ETHSWT_SECURITY_ACTION_NORMAL;
                break;
            case SWITCH_PAGE_45_OVER_LIMIT_ACT_DROP_PKT:
                action = ETHSWT_SECURITY_ACTION_DROP_PKT;
                break;
            case SWITCH_PAGE_45_OVER_LIMIT_ACT_COPY_TO_CPU:
                action = ETHSWT_SECURITY_ACTION_COPY_TO_CPU;
                break;
            default:
                action = ETHSWT_SECURITY_ACTION_REDIRECT_TO_CPU;
                break;
        }
        aAddressLimitInfo->macLearningLimit = (uint16_t)(regCtrl & SWITCH_P45P0SLC_P45P0SLCSLCL_MASK);
        /* Read the Port N SA Learn counter Register */
        ret = ETHSWT_DrvReadReg16(aSwtID, (uint32_t)(&ETHSWT_ARLRegs->m45_port_0_sa_lrn_cnt[aPortID]), &reg);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
        *aPortLearnedCounter = reg & SWITCH_P45P0SLC1_PAGE_45_PORT_0_SA_LRN_CNTR_SA_LRN_CNT_NO_MASK;

        /* Read the Port N SA overlimit counter Register */
        ret = ETHSWT_DrvReadReg16(aSwtID, (uint32_t)(&ETHSWT_ARLRegs->m45_port_0_sa_overlimit_cnt[aPortID]), &reg);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
        *aPortOverLimitCounter = (uint32_t)(reg & SWITCH_P45P0SOC_P45P0SOCSOLC_MASK);
    } else {
        action = ETHSWT_SECURITY_ACTION_DISABLED;
        aAddressLimitInfo->macLearningLimit = ETHSWT_ARL_SIZE;
        *aPortLearnedCounter = 0x0U;
        *aPortOverLimitCounter = 0x0UL;
    }

    aAddressLimitInfo->overLimitAction = action;
err_exit:
    ETHSWT_REPORT_ERR( ret, aSwtID, line,
        BRCM_SWDSGN_ETHSWT_DRV_GET_ADDR_LIMIT_AND_COUNTER_PROC, 0UL, 0UL, 0UL)
    return ret;
}

/**
    @brief Set sticky MAC Address action to the port

    This function sets the sticky MAC Address action to a port.
    If a single MAC address (or a small number of MAC addresses)
    is/are sticky to a port, then any packet arriving with Source
    MAC address which is sticky to that port should only be allowed.
    If the incoming packet is an IEEE 802.1X packet, or special
    frames, the incoming packets are forwarded.

    @behavior Sync, Non re-entrant

    @pre Hardware learning can be disabled.

    @param[in]      aSwtID                   Switch index
    @param[in]      aPortID                  Port index
    @param[in]      aStickyMACAction         Sticky MAC action

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully set sticky MAC Address
                                        information to the port
    @retval     #BCM_ERR_TIME_OUT       Timeout occurred while reading/writing
                                        switch register

    @post None

    @code{.c}
    ret = ERR_OK

    Read the Port N  EAP Configuration Registers (PAGE_42_PORT_EAP_CON_PN)
    (PAGE_42_PORT_EAP_CON_PN = PAGE_42_PORT_EAP_CON_P0 + (8 * N))
    if(ETHSWT_SECURITY_ACTION_DISABLED == aStickyMACAction) {
         clear the EAP Mode bits(PAGE_42_PORT_EAP_CON_PN_EAP_MODE[52:51])
    } else {
        eapMode = (aStickyMACAction == ETHSWT_SECURITY_ACTION_DROP_PKT) ?
                             SWITCH_PAGE_42_EAP_MODE_EXTENDED :
                             SWITCH_PAGE_42_EAP_MODE_SIMPLIFIED;
         Set the EAP Mode(eapMode) bits(PAGE_42_PORT_EAP_CON_PN_EAP_MODE[52:51])
    }

    Write the Port N EAP Configuration Registers (PAGE_42_PORT_EAP_CON_PN)
    (PAGE_42_PORT_EAP_CON_PN = PAGE_42_PORT_EAP_CON_P0 + (8 * N))

    err_exit:
    ETHSWT_REPORT_ERR( ret, aSwtID, line,
        BRCM_SWDSGN_ETHSWT_DRV_SET_MACADDRESSSTICKYTOPORT_PROC, 0UL, 0UL, 0UL)
    return ret;
    @endcode
    @trace #BRCM_SWARCH_ETHSWT_ARL_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION
 */
static int32_t ETHSWT_DrvSetMACAddressStickyToPort(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID,
        ETHSWT_SecurityActionType aStickyMACAction)
{
    uint32_t line;
    uint64_t reg;
    int32_t ret = BCM_ERR_OK;
    uint64_t eapMode;

    /* Read the Port N EAP Configuration Registers */
    ret = ETHSWT_DrvReadReg(aSwtID, (uint32_t)(&ETHSWT_ARLRegs->m42_port_eap_con_p[aPortID]), &reg);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    if(ETHSWT_SECURITY_ACTION_DISABLED == aStickyMACAction) {
        reg &= ~SWITCH_P42PECP0_PAGE_42_PORT_EAP_CON_P0_EAP_MODE_MASK;
    } else {
        reg &= ~SWITCH_P42PECP0_PAGE_42_PORT_EAP_CON_P0_EAP_MODE_MASK;
        eapMode = (aStickyMACAction == ETHSWT_SECURITY_ACTION_DROP_PKT) ?
                             SWITCH_PAGE_42_EAP_MODE_EXTENDED :
                             SWITCH_PAGE_42_EAP_MODE_SIMPLIFIED;
        reg |= (uint64_t)eapMode << SWITCH_P42PECP0_PAGE_42_PORT_EAP_CON_P0_EAP_MODE_SHIFT;
    }
    /* write the Port N EAP Configuration Registers */
    ret = ETHSWT_DrvWriteReg(aSwtID, (uint32_t)(&ETHSWT_ARLRegs->m42_port_eap_con_p[aPortID]), reg);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
err_exit:
    ETHSWT_REPORT_ERR( ret, aSwtID, line,
        BRCM_SWDSGN_ETHSWT_DRV_SET_MACADDRESSSTICKYTOPORT_PROC, 0UL, 0UL, 0UL)
    return ret;
}

/**
    @brief Get sticky MAC Address information to the port

    This API retreives sticky MAC Address information
    of the provided port.

    @behavior Sync, Non re-entrant

    @pre Hardware learning can be disabled.

    @param[in]      aSwtID                   Switch index
    @param[in]      aPortID                  Port index
    @param[out]     aStickyMACAction         Pointer to sticky MAC address
                                             action

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully retrieved sticky MAC
                                        Address information to the port
    @retval     #BCM_ERR_TIME_OUT       Timeout occurred while reading/writing
                                        switch register

    @post None

    @code{.c}
    ret = ERR_OK

    Read the Port N EAP Configuration Registers (PAGE_42_PORT_EAP_CON_PN)
    (PAGE_42_PORT_EAP_CON_PN = PAGE_42_PORT_EAP_CON_P0 + (8 * N))
    eapMode = port EAP mode bits
               (PAGE_42_PORT_EAP_CON_PN_EAP_MODE[52:51])
    if(SWITCH_PAGE_42_EAP_MODE_BASIC == eapMode) {
        *aStickyMACAction = ETHSWT_SECURITY_ACTION_DISABLED;
    } else if (SWITCH_PAGE_42_EAP_MODE_EXTENDED == eapMode) {
        *aStickyMACAction = ETHSWT_SECURITY_ACTION_DROP_PKT;
    } else if (SWITCH_PAGE_42_EAP_MODE_SIMPLIFIED == eapMode) {
        *aStickyMACAction = ETHSWT_SECURITY_ACTION_REDIRECT_TO_CPU;
    } else {
        *aStickyMACAction = ETHSWT_SECURITY_ACTION_INVALID;
    }

    err_exit:
    ETHSWT_REPORT_ERR( ret, aSwtID, line,
        BRCM_SWDSGN_ETHSWT_DRV_GET_MACADDRESSSTICKYTOPORT_PROC, 0UL, 0UL, 0UL)
    return ret;
    @endcode
    @trace #BRCM_SWARCH_ETHSWT_ARL_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_QUERY
 */
static int32_t ETHSWT_DrvGetMACAddressStickyToPort(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID,
        ETHSWT_SecurityActionType * const aStickyMACAction)
{
    uint32_t line;
    uint64_t reg;
    int32_t  ret = BCM_ERR_OK;
    uint64_t  eapMode;

    /* Read the Station Movement Control Register */
    ret = ETHSWT_DrvReadReg(aSwtID, (uint32_t)(&ETHSWT_ARLRegs->m42_port_eap_con_p[aPortID]), &reg);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    eapMode = (reg & SWITCH_P42PECP0_PAGE_42_PORT_EAP_CON_P0_EAP_MODE_MASK) >>    SWITCH_P42PECP0_PAGE_42_PORT_EAP_CON_P0_EAP_MODE_SHIFT;
    if(SWITCH_PAGE_42_EAP_MODE_BASIC == eapMode) {
        *aStickyMACAction = ETHSWT_SECURITY_ACTION_DISABLED;
    } else if (SWITCH_PAGE_42_EAP_MODE_EXTENDED == eapMode) {
        *aStickyMACAction = ETHSWT_SECURITY_ACTION_DROP_PKT;
    } else if (SWITCH_PAGE_42_EAP_MODE_SIMPLIFIED == eapMode) {
        *aStickyMACAction = ETHSWT_SECURITY_ACTION_REDIRECT_TO_CPU;
    } else {
        *aStickyMACAction = ETHSWT_SECURITY_ACTION_INVALID;
    }

err_exit:
    ETHSWT_REPORT_ERR( ret, aSwtID, line,
        BRCM_SWDSGN_ETHSWT_DRV_GET_MACADDRESSSTICKYTOPORT_PROC, 0UL, 0UL, 0UL)
    return ret;
}

/**
    @brief Set total MAC-SA limiting control

    This API sets the maximum number of MAC addresses that are learned
    accross all the port. When Address Limit is reached (i.e.,  either
    port-wise limit is reached or overall limit is reached), the subsequent
    actions are controlled by the over limit action field of the corresponding
    port.

    @behavior Sync, Non re-entrant

    @pre None

    @param[in]      aSwtID                   Switch index
    @param[in]      aTotalMACLearningLimit   maximum number of MAC
                                             addresses allowed to
                                             learn across all ports

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully set address limiting information
                                        for the port
    @retval     #BCM_ERR_TIME_OUT       Timeout occurred while reading/writing
                                        switch register

    @post None

    @code{.c}
    ret = ERR_OK

    Read the Total SA Limit Control Register
    Write aTotalMACLearningLimit bits PAGE_45_TOTAL_SA_LIMIT_CTL_TOTAL_SA_LRN_CNT_LIM[12:0]
    Write the Total SA Limit Control Register
    Reset the Total SA Learn Counter value (PAGE_45_TOTAL_SA_LIMIT_CTL_TOTAL_SA_LRN_CNT_LIM[12:0])

    err_exit:
    ETHSWT_REPORT_ERR( ret, aSwtID, line,
        BRCM_SWDSGN_ETHSWT_DRV_SET_TOTALADDRESSLIMIT_PROC, 0UL, 0UL, 0UL)
    return ret;
    @endcode
    @trace #BRCM_SWARCH_ETHSWT_ARL_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION
 */
static int32_t ETHSWT_DrvSetTotalAddressLimit(ETHSWT_HwIDType aSwtID,
                              uint16_t aTotalMACLearningLimit)
{
    uint32_t line;
    uint16_t regCtrl;
    int32_t ret = BCM_ERR_OK;

    /* Read the Total SA Limit Control Register */
    ret = ETHSWT_DrvReadReg16(aSwtID, (uint32_t)&ETHSWT_ARLRegs->m45_total_sa_limit_ctl, &regCtrl);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    regCtrl &= (~SWITCH_P45TSLC_P45TSLCTSLCL_MASK);
    regCtrl |= (uint16_t)(aTotalMACLearningLimit & SWITCH_P45TSLC_P45TSLCTSLCL_MASK);
    /* write the Total SA Limit Control Register */
    ret = ETHSWT_DrvWriteReg16(aSwtID, (uint32_t)&ETHSWT_ARLRegs->m45_total_sa_limit_ctl, regCtrl);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    /* Reset the Total SA Learn counter Register */

    ret = ETHSWT_DrvReadReg16(aSwtID, (uint32_t)&ETHSWT_ARLRegs->m45_total_sa_lrn_cntr, &regCtrl);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    regCtrl &= (~SWITCH_P45TSLC1_P45TSLCTSLCN_MASK);
    ret = ETHSWT_DrvWriteReg16(aSwtID, (uint32_t)&ETHSWT_ARLRegs->m45_total_sa_lrn_cntr, regCtrl);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
err_exit:
    ETHSWT_REPORT_ERR( ret, aSwtID, line,
        BRCM_SWDSGN_ETHSWT_DRV_SET_TOTALADDRESSLIMIT_PROC, 0UL, 0UL, 0UL)
    return ret;
}

/**
    @brief Get total MAC-SA limiting control

    This API retreives total MAC-SA limit accross
    all the port.

    @behavior Sync, Non re-entrant

    @pre None

    @param[in]      aSwtID                   Switch index
    @param[out]     aTotalMACLearningLimit   pointer to maximum
                                             number of MAC
                                             addresses allowed to
                                             learn on all ports
    @param[out]     aTotalLearnedCounter     pointer to the number
                                             of SA MAC addresses
                                             learned on all ports.
                                             This counter can't exceed
                                             the max programmed learning
                                             value across all the port

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully set address limiting information
                                        for the port
    @retval     #BCM_ERR_TIME_OUT       Timeout occurred while reading/writing
                                        switch register

    @post None

    @code{.c}
    ret = ERR_OK

    Read the Total SA Limit Control Register
    *aTotalMACLearningLimit = Total SA-Limit bits
                              PAGE_45_TOTAL_SA_LIMIT_CTL_TOTAL_SA_LRN_CNT_LIM[12:0]
    Read the Total SA Learn counter Register
    *aTotalLearnedCounter =  Total SA Learn counter bits
                             (PAGE_45_TOTAL_SA_LRN_CNTR_TOTAL_SA_LRN_CNT_NO[12:0])
    err_exit:
    ETHSWT_REPORT_ERR( ret, aSwtID, line,
        BRCM_SWDSGN_ETHSWT_DRV_GET_TOTALADDRLIMITANDCOUNTER_PROC, 0UL, 0UL, 0UL)
    return ret;
    @endcode
    @trace #BRCM_SWARCH_ETHSWT_ARL_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION
 */
static int32_t ETHSWT_DrvGetTotalAddrLimitAndCounter(ETHSWT_HwIDType aSwtID,
                                   uint16_t * const aTotalMACLearningLimit,
                                   uint16_t * const aTotalLearnedCounter)
{
    uint32_t line;
    uint16_t reg;
    int32_t ret = BCM_ERR_OK;

    /* Read the Total SA Limit Control Register */
    ret = ETHSWT_DrvReadReg16(aSwtID, (uint32_t)&ETHSWT_ARLRegs->m45_total_sa_limit_ctl, &reg);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    *aTotalMACLearningLimit = reg & SWITCH_P45TSLC_P45TSLCTSLCL_MASK;

    /* Read the Total SA Learn counter Register */
    ret = ETHSWT_DrvReadReg16(aSwtID, (uint32_t)&ETHSWT_ARLRegs->m45_total_sa_lrn_cntr, &reg);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    *aTotalLearnedCounter = reg & SWITCH_P45TSLC1_P45TSLCTSLCN_MASK;
err_exit:
    ETHSWT_REPORT_ERR( ret, aSwtID, line,
        BRCM_SWDSGN_ETHSWT_DRV_GET_TOTALADDRLIMITANDCOUNTER_PROC, 0UL, 0UL, 0UL)
    return ret;
}
#endif /* ENABLE_ETHSWT_SECURITY */

/**
    @brief Switch ARL command handler

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aCmd            Command Index
    @param[inout]   aIO             Pointer to ARL command I/O
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
        case ETHSWT_IO_CMD_GET_PORT_MAC_ADDR:
            ret = ETHSWT_DrvGetPortMacAddr(aSwtHwID, &(aIO->portHwID),
                    aIO->macAddr, aIO->vlanID);
            break;
        case ETHSWT_IO_CMD_SET_MACLEARNING_MODE:
            ret =ETHSWT_DrvSetMACLearningMode(aSwtHwID, aIO->portHwID,
                    *(aIO->learningMode));
            break;
        case ETHSWT_IO_CMD_GET_MACLEARNING_MODE:
            ret = ETHSWT_DrvGetMACLearningMode(aSwtHwID, aIO->portHwID,
                    aIO->learningMode);
            break;
        case ETHSWT_IO_CMD_SET_AGE:
            ret = ETHSWT_DrvSetAge(aSwtHwID, aIO->age);
            break;
        case ETHSWT_IO_CMD_GET_AGE:
            ret = ETHSWT_DrvGetAge(aSwtHwID, &(aIO->age));
            break;
        case ETHSWT_IO_CMD_GET_ARL_TABLE:
            ret = ETHSWT_DrvGetARLTable(aSwtHwID, aIO->ARLTbl,
                    aIO->ARLTblSz);
            break;
        case ETHSWT_IO_CMD_ADD_ARL_ENTRY:
            ret = ETHSWT_DrvAddARLEntry(aSwtHwID, aIO->arlEntry);
            break;
        case ETHSWT_IO_CMD_DELETE_ARL_ENTRY:
            ret = ETHSWT_DrvDeleteARLEntry(aSwtHwID, aIO->arlEntry);
            break;
        case ETHSWT_IO_CMD_ADD_ARL_MYDA_ENTRY:
            ret = ETHSWT_DrvAddARLMyDAEntry(aSwtHwID, aIO->portMask, aIO->macAddr)
            break;
        case ETHSWT_IO_CMD_DELETE_ARL_MYDA_ENTRY:
            ret = ETHSWT_DrvDeleteARLMyDAEntry(aSwtHwID, aIO->arlEntry)
            break;
        case ETHSWT_IO_CMD_GET_ARL_MYDA_SNAPSHOT:
            ret = ETHSWT_DrvGetARLMyDASnapshot(aSwtHwID, aIO->ARLTbl, aIO->ARLTblSz);
            break;
#ifdef ENABLE_ETHSWT_SECURITY
        case ETHSWT_IO_CMD_SET_STATION_MOVE_DETECT:
            ret = ETHSWT_DrvSetStationMovementDetection(aSwtHwID,
                                                        aIO->portHwID,
                                                        aIO->securityAction);
            break;
        case ETHSWT_IO_CMD_GET_STATION_MOVE_DETECT:
            ret = ETHSWT_DrvGetStationMovementDetection(aSwtHwID,
                                                        aIO->portHwID,
                                                        &aIO->securityAction);
            break;
        case ETHSWT_IO_CMD_SET_ADDRESS_LIMITING:
            ret = ETHSWT_DrvSetPortAddressLimiting(aSwtHwID,
                                                   aIO->portHwID,
                                                   aIO->addrLimitPtr);
            break;
        case ETHSWT_IO_CMD_GET_ADDRESS_LIMITING:
            ret = ETHSWT_DrvGetPortAddrLimitAndCounter(aSwtHwID,
                                                       aIO->portHwID,
                                                       aIO->addrLimitPtr,
                                                     &(aIO->macLearnedCounter),
                                                     &(aIO->overLimitCounter));
            break;
        case ETHSWT_IO_CMD_SET_STICKY_MAC_ADDRESS:
            ret = ETHSWT_DrvSetMACAddressStickyToPort(aSwtHwID,
                                                      aIO->portHwID,
                                                      aIO->securityAction);
            break;
        case ETHSWT_IO_CMD_GET_STICKY_MAC_ADDRESS:
            ret = ETHSWT_DrvGetMACAddressStickyToPort(aSwtHwID,
                                                      aIO->portHwID,
                                                     &(aIO->securityAction));
            break;
        case ETHSWT_IO_CMD_SET_TOTAL_ADDRESS_LIMIT:
            ret = ETHSWT_DrvSetTotalAddressLimit(aSwtHwID,
                                                 aIO->totalMACLearningLimit);
            break;
        case ETHSWT_IO_CMD_GET_TOTAL_ADDRESS_LIMIT:
            ret = ETHSWT_DrvGetTotalAddrLimitAndCounter(aSwtHwID,
                                                      &(aIO->totalMACLearningLimit),
                                                      &(aIO->macLearnedCounter));
            break;
#endif
        default:
            ret = BCM_ERR_NOSUPPORT;
            break;
    }
    return ret
    @endcode

    @trace  #BRCM_SWREQ_ETHSWT_KERNEL_HANDLER
    @trace #BRCM_SWARCH_ETHSWT_ARL_CMD_HANDLER_PROC
*/
int32_t ETHSWT_ARLCmdHandler(ETHSWT_HwIDType aSwtHwID,
                                ETHSWT_IOCmdType aCmd,
                                ETHSWT_ARLIOType *const aIO)
{
    int32_t ret;
    switch(aCmd) {
        case ETHSWT_IO_CMD_GET_PORT_MAC_ADDR:
            ret = ETHSWT_DrvGetPortMacAddr(aSwtHwID, &(aIO->portHwID),
                    aIO->macAddr, aIO->vlanID);
            break;
        case ETHSWT_IO_CMD_SET_MACLEARNING_MODE:
            ret =ETHSWT_DrvSetMACLearningMode(aSwtHwID, aIO->portHwID,
                    *(aIO->learningMode));
            break;
        case ETHSWT_IO_CMD_GET_MACLEARNING_MODE:
            ret = ETHSWT_DrvGetMACLearningMode(aSwtHwID, aIO->portHwID,
                    aIO->learningMode);
            break;
        case ETHSWT_IO_CMD_SET_AGE:
            ret = ETHSWT_DrvSetAge(aSwtHwID, aIO->age);
            break;
        case ETHSWT_IO_CMD_GET_AGE:
            ret = ETHSWT_DrvGetAge(aSwtHwID, &(aIO->age));
            break;
        case ETHSWT_IO_CMD_GET_ARL_TABLE:
            ret = ETHSWT_DrvGetARLTable(aSwtHwID, aIO->ARLTbl,
                    aIO->ARLTblSz);
            break;
        case ETHSWT_IO_CMD_ADD_ARL_ENTRY:
            ret = ETHSWT_DrvAddARLEntry(aSwtHwID, aIO->arlEntry);
            break;
        case ETHSWT_IO_CMD_DELETE_ARL_ENTRY:
            ret = ETHSWT_DrvDeleteARLEntry(aSwtHwID, aIO->arlEntry);
            break;
        case ETHSWT_IO_CMD_ADD_ARL_MYDA_ENTRY:
            ret = ETHSWT_DrvAddARLMyDAEntry(aSwtHwID, aIO->portMask,
                                                     aIO->macAddr);
            break;
        case ETHSWT_IO_CMD_DELETE_ARL_MYDA_ENTRY:
            ret = ETHSWT_DrvDeleteARLMyDAEntry(aSwtHwID, aIO->macAddr);
            break;
        case ETHSWT_IO_CMD_GET_ARL_MYDA_SNAPSHOT:
            ret = ETHSWT_DrvGetARLMyDASnapshot(aSwtHwID, aIO->ARLTbl,
                                                      aIO->ARLTblSz);
            break;
#ifdef ENABLE_ETHSWT_SECURITY
        case ETHSWT_IO_CMD_SET_STATION_MOVE_DETECT:
            ret = ETHSWT_DrvSetStationMovementDetection(aSwtHwID,
                                                        aIO->portHwID,
                                                        aIO->securityAction);
            break;
        case ETHSWT_IO_CMD_GET_STATION_MOVE_DETECT:
            ret = ETHSWT_DrvGetStationMovementDetection(aSwtHwID,
                                                        aIO->portHwID,
                                                       &(aIO->securityAction));
            break;
        case ETHSWT_IO_CMD_SET_ADDRESS_LIMITING:
            ret = ETHSWT_DrvSetPortAddressLimiting(aSwtHwID,
                                                   aIO->portHwID,
                                                   aIO->addrLimitPtr);
            break;
        case ETHSWT_IO_CMD_GET_ADDRESS_LIMITING:
            ret = ETHSWT_DrvGetPortAddrLimitAndCounter(aSwtHwID,
                                                       aIO->portHwID,
                                                       aIO->addrLimitPtr,
                                                     &(aIO->macLearnedCounter),
                                                     &(aIO->overLimitCounter));
            break;
        case ETHSWT_IO_CMD_SET_STICKY_MAC_ADDRESS:
            ret = ETHSWT_DrvSetMACAddressStickyToPort(aSwtHwID,
                                                      aIO->portHwID,
                                                      aIO->securityAction);
            break;
        case ETHSWT_IO_CMD_GET_STICKY_MAC_ADDRESS:
            ret = ETHSWT_DrvGetMACAddressStickyToPort(aSwtHwID,
                                                      aIO->portHwID,
                                                     &(aIO->securityAction));
            break;
        case ETHSWT_IO_CMD_SET_TOTAL_ADDRESS_LIMIT:
            ret = ETHSWT_DrvSetTotalAddressLimit(aSwtHwID,
                                                 aIO->totalMACLearningLimit);
            break;
        case ETHSWT_IO_CMD_GET_TOTAL_ADDRESS_LIMIT:
            ret = ETHSWT_DrvGetTotalAddrLimitAndCounter(aSwtHwID,
                                                      &(aIO->totalMACLearningLimit),
                                                      &(aIO->macLearnedCounter));
            break;
#endif /* ENABLE_ETHSWT_SECURITY */
        default:
            ret = BCM_ERR_NOSUPPORT;
            break;
    }
    return ret;
}


/**
    @brief Set Age

    @trace #BRCM_SWARCH_ETHSWT_SET_AGE_PROC
    @trace #BRCM_SWREQ_ETHSWT_DYNAMIC_CONFIGURATION
*/
int32_t ETHSWT_SetAge(ETHSWT_HwIDType aSwtID,
        uint32_t aAge)
{
    ETHSWT_IOType swtIO;
    ETHSWT_ARLIOType arlIO;
    int32_t ret;

    if (aSwtID < SWITCH_MAX_HW_ID) {
        arlIO.age = aAge;
        swtIO.arlIO = &arlIO;
        swtIO.retVal = BCM_ERR_UNKNOWN;
        swtIO.swtHwID = aSwtID;
        ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_SET_AGE, &swtIO);
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }
    return ret;
}

/**
    @brief Get Age

    @trace #BRCM_SWARCH_ETHSWT_GET_AGE_PROC
    @trace #BRCM_SWREQ_ETHSWT_QUERY
*/
int32_t ETHSWT_GetAge(ETHSWT_HwIDType aSwtID,
        uint32_t *const aAge)
{
    ETHSWT_IOType swtIO;
    ETHSWT_ARLIOType arlIO;
    int32_t ret;

    if ((aSwtID < SWITCH_MAX_HW_ID) && (NULL != aAge)) {
        swtIO.arlIO = &arlIO;
        swtIO.retVal = BCM_ERR_UNKNOWN;
        swtIO.swtHwID = aSwtID;
        ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_GET_AGE, &swtIO);
        if (BCM_ERR_OK == ret) {
            *aAge = arlIO.age;
        }
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }
    return ret;
}

/**
    @brief Add ARL entry

    @trace #BRCM_SWARCH_ETHSWT_ADD_ARL_ENTRY_PROC
    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION
*/
int32_t ETHSWT_AddARLEntry(ETHSWT_HwIDType aSwtID,
        ETHSWT_ARLEntryType *const aARLEntry)
{
    ETHSWT_IOType swtIO;
    ETHSWT_ARLIOType arlIO;
    int32_t ret;

    if (aSwtID < SWITCH_MAX_HW_ID) {
        arlIO.arlEntry = aARLEntry;
        swtIO.arlIO = &arlIO;
        swtIO.retVal = BCM_ERR_UNKNOWN;
        swtIO.swtHwID = aSwtID;
        ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_ADD_ARL_ENTRY, &swtIO);
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }
    return ret;
}

/**
    @brief Delete ARL Entry

    @trace #BRCM_SWARCH_ETHSWT_DELETE_ARL_ENTRY_PROC
    @trace #BRCM_SWREQ_ETHSWT_DYNAMIC_CONFIGURATION
*/
int32_t ETHSWT_DeleteARLEntry(ETHSWT_HwIDType aSwtID,
        ETHSWT_ARLEntryType *const aARLEntry)
{
    ETHSWT_IOType swtIO;
    ETHSWT_ARLIOType arlIO;
    int32_t ret;

    if (aSwtID < SWITCH_MAX_HW_ID) {
        arlIO.arlEntry = aARLEntry;
        swtIO.arlIO = &arlIO;
        swtIO.retVal = BCM_ERR_UNKNOWN;
        swtIO.swtHwID = aSwtID;
        ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_DELETE_ARL_ENTRY, &swtIO);
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }
    return ret;
}

/**
    @brief Get ARL table

    @trace #BRCM_SWARCH_ETHSWT_GET_ARL_TBL_PROC
    @trace #BRCM_SWREQ_ETHSWT_QUERY
*/
int32_t ETHSWT_GetARLTable(ETHSWT_HwIDType aSwtID,
        ETHSWT_ARLEntryType *const aARLTbl,
        uint16_t *const aTblSize)
{
    ETHSWT_IOType swtIO;
    ETHSWT_ARLIOType arlIO;
    int32_t ret;

    if (aSwtID < SWITCH_MAX_HW_ID) {
        arlIO.ARLTbl = aARLTbl;
        arlIO.ARLTblSz = aTblSize;
        swtIO.arlIO = &arlIO;
        swtIO.retVal = BCM_ERR_UNKNOWN;
        swtIO.swtHwID = aSwtID;
        ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_GET_ARL_TABLE, &swtIO);
        if (BCM_ERR_OK != ret) {
            ETHSWT_DrvReportError((BCM_SWT_ID & BCM_LOGMASK_USER), (uint8_t)aSwtID,
                    BRCM_SWDSGN_ETHSWT_GET_ARL_TABLE_PROC, ret, 0UL, 0UL, 0UL, __LINE__);
        }
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }
    return ret;
}

/**
    @brief Get port MAC address

    @trace #BRCM_SWARCH_ETHSWT_GET_PORT_MAC_ADDR_PROC
    @trace #BRCM_SWREQ_ETHSWT_QUERY
*/
int32_t ETHSWT_GetPortMacAddr(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType *const aPortID,
        const uint8_t *const aMacAddr,
        ETHER_VLANIDType aVlanID)
{
    ETHSWT_IOType swtIO;
    ETHSWT_ARLIOType arlIO;
    int32_t ret;

    if ((aSwtID < SWITCH_MAX_HW_ID) && (NULL != aPortID)) {
        arlIO.macAddr = aMacAddr;
        arlIO.vlanID = aVlanID;
        swtIO.arlIO = &arlIO;
        swtIO.retVal = BCM_ERR_UNKNOWN;
        swtIO.swtHwID = aSwtID;
        ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_GET_PORT_MAC_ADDR, &swtIO);
        if (BCM_ERR_OK == ret) {
            *aPortID = swtIO.arlIO->portHwID;
        } else {
            ETHSWT_DrvReportError((BCM_SWT_ID & BCM_LOGMASK_USER),
                    (uint8_t)aSwtID,
                    BRCM_SWDSGN_ETHSWT_GET_PORT_MAC_ADDR_PROC, ret,
                    0UL, 0UL, 0UL, __LINE__);
        }
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }
    return ret;
}

/**
    @brief Set MAC learning mode

    @trace #BRCM_SWARCH_ETHSWT_SET_MAC_LEARN_MODE_PROC
    @trace #BRCM_SWREQ_ETHSWT_DYNAMIC_CONFIGURATION
*/
int32_t ETHSWT_SetMACLearningMode(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID,
        ETHSWT_MacLearningModeType aMode)
{
    ETHSWT_IOType swtIO;
    ETHSWT_ARLIOType arlIO;
    int32_t ret;

    if (aSwtID < SWITCH_MAX_HW_ID) {
        arlIO.portHwID = aPortID;
        arlIO.learningMode = &aMode;
        swtIO.arlIO = &arlIO;
        swtIO.retVal = BCM_ERR_UNKNOWN;
        swtIO.swtHwID = aSwtID;
        ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_SET_MACLEARNING_MODE, &swtIO);
        if (BCM_ERR_OK != ret) {
            ETHSWT_DrvReportError((BCM_SWT_ID & BCM_LOGMASK_USER), (uint8_t)aSwtID,
                    BRCM_SWDSGN_ETHSWT_SET_MAC_LEARNING_MODE_PROC, ret, 0UL, 0UL,
                    0UL, __LINE__);
        }
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }
    return ret;
}

/**
    @brief Get MAC learning mode

    @trace #BRCM_SWARCH_ETHSWT_GET_MAC_LEARN_MODE_PROC
    @trace #BRCM_SWREQ_ETHSWT_QUERY
*/
int32_t ETHSWT_GetMACLearningMode(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID,
        ETHSWT_MacLearningModeType *const aMode)
{
    ETHSWT_IOType swtIO;
    ETHSWT_ARLIOType arlIO;
    int32_t ret;

    if (aSwtID < SWITCH_MAX_HW_ID) {
        arlIO.portHwID = aPortID;
        arlIO.learningMode = aMode;
        swtIO.arlIO = &arlIO;
        swtIO.retVal = BCM_ERR_UNKNOWN;
        swtIO.swtHwID = aSwtID;
        ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_GET_MACLEARNING_MODE, &swtIO);
        if (BCM_ERR_OK != ret) {
            ETHSWT_DrvReportError((BCM_SWT_ID & BCM_LOGMASK_USER), (uint8_t)aSwtID,
                    BRCM_SWDSGN_ETHSWT_GET_MAC_LEARNING_MODE_PROC, ret, 0UL, 0UL,
                    0UL, __LINE__);
        }
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }
    return ret;
}

/**
    @brief Add ARL MyDA entry

    @trace #BRCM_SWARCH_ETHSWT_ADD_ARL_MYDA_ENTRY_PROC
    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION
*/
int32_t ETHSWT_AddARLMyDAEntry(ETHSWT_HwIDType aSwtID,
                                   uint16_t aPortMask,
                                   const uint8_t *const aMacAddr)
{
    int32_t ret;
#ifdef ENABLE_ETHSWT_MYDA
    ETHSWT_IOType swtIO;
    ETHSWT_ARLIOType arlIO;

    if ((aSwtID < SWITCH_MAX_HW_ID)
              && (NULL != aMacAddr)
              && (0UL != ETHSWT_NMAC2HWMAC(aMacAddr))
              && (0x1U != (aMacAddr[0U] & 0x1U))) {
        arlIO.macAddr = aMacAddr;
        arlIO.portMask = aPortMask;
        swtIO.arlIO = &arlIO;
        swtIO.retVal = BCM_ERR_UNKNOWN;
        swtIO.swtHwID = aSwtID;
        ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_ADD_ARL_MYDA_ENTRY, &swtIO);
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }
#else
        ret = BCM_ERR_NOSUPPORT;
#endif
    return ret;
}

/**
    @brief Delete ARL MyDA Entry

    @trace #BRCM_SWARCH_ETHSWT_DELETE_ARL_MYDA_ENTRY_PROC
    @trace #BRCM_SWREQ_ETHSWT_DYNAMIC_CONFIGURATION
*/
int32_t ETHSWT_DeleteARLMyDAEntry(ETHSWT_HwIDType aSwtID,
                                   const uint8_t *const aMacAddr)
{
    int32_t ret;
#ifdef ENABLE_ETHSWT_MYDA
    ETHSWT_IOType swtIO;
    ETHSWT_ARLIOType arlIO;

    if ((aSwtID < SWITCH_MAX_HW_ID)
              && (NULL != aMacAddr)
              && (0UL != ETHSWT_NMAC2HWMAC(aMacAddr))
              && (0x1U != (aMacAddr[0U] & 0x1U))) {
        arlIO.macAddr = aMacAddr;
        swtIO.arlIO = &arlIO;
        swtIO.retVal = BCM_ERR_UNKNOWN;
        swtIO.swtHwID = aSwtID;
        ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_DELETE_ARL_MYDA_ENTRY, &swtIO);
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }
#else
        ret = BCM_ERR_NOSUPPORT;
#endif
    return ret;
}

/**
    @brief Get ARL MyDA Entries

    @trace #BRCM_SWARCH_ETHSWT_GETARLMYDASNAPSHOT_PROC
    @trace #BRCM_SWREQ_ETHSWT_QUERY
*/
int32_t ETHSWT_GetARLMyDASnapshot(ETHSWT_HwIDType aSwtID,
                                     ETHSWT_ARLEntryType *const aARLTbl,
                                     uint16_t *const aTblSize)
{
    int32_t ret;
#ifdef ENABLE_ETHSWT_MYDA
    ETHSWT_IOType swtIO;
    ETHSWT_ARLIOType arlIO;

    if ((aSwtID < SWITCH_MAX_HW_ID)
            && (NULL != aARLTbl)
            && ((NULL != aTblSize)
                 && ((ETHSWT_MAX_MYDA_ENTRIES >= *aTblSize)
                      && (0UL != *aTblSize)))) {
        arlIO.ARLTbl = aARLTbl;
        arlIO.ARLTblSz = aTblSize;
        swtIO.arlIO = &arlIO;
        swtIO.retVal = BCM_ERR_UNKNOWN;
        swtIO.swtHwID = aSwtID;
        ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_GET_ARL_MYDA_SNAPSHOT, &swtIO);
        if (BCM_ERR_OK != ret) {
            ETHSWT_DrvReportError((BCM_SWT_ID & BCM_LOGMASK_USER), (uint8_t)aSwtID,
                    BRCM_SWDSGN_ETHSWT_GET_ARL_MYDA_SNAPSHOT_PROC, ret, 0UL, 0UL, 0UL, __LINE__);
        }
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }
#else
        ret = BCM_ERR_NOSUPPORT;
#endif
    return ret;
}

#ifdef ENABLE_ETHSWT_SECURITY
/** @brief Set station movement detection(enable with action/disable)

    If station movement detection is enabled and a MAC address
    has been learned by hardware on a port, and a packet with
    the same address as MAC-SA enters the switch from a different
    physical port, then it should be discarded or sent to the CPU.

    @behavior Sync, Non re-entrant

    @pre None

    @param[in]      aSwtID                   Switch index
    @param[in]      aPortID                  Port index
    @param[in]      aSMDetectAction          Station movement
                                             detection action

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully set station movement
                                        detection action
    @retval     #BCM_ERR_TIME_OUT       Timeout occurred while reading/writing
                                        switch register
    @retval     #BCM_ERR_INVAL_PARAMS   (Invalid switch index) or
                                        (Invalid aPortID) or
                                        (Invalid station movement detection
                                        action)
    @retval     #BCM_ERR_NOPERM         CPU port is not available
                                        (Valid only for the action,
                                         redirect to CPU)
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post None
    @code{.c}
    ETHSWT_IOType swtIO;
    ETHSWT_ARLIOType arlIO;
    ret = BCM_ERR_INVAL_PARAMS;
    ETHSWT_MgmtModeType mode;

    if ((aSwtID < SWITCH_MAX_HW_ID)  &&
        (aPortID < ETHSWT_PORT_ID_MAX) &&
        (aSMDetectAction <= ETHSWT_SECURITY_ACTION_REDIRECT_TO_CPU)) {
        if (ETHSWT_SECURITY_ACTION_REDIRECT_TO_CPU == aSMDetectAction) {
            ret = ETHSWT_GetMgmtMode(aSwtID, &mode);
            ETHSWT_CHECK_ERR(ret, &line, err_exit)
            if (ETHSWT_MGMTMODE_DISABLE == mode) {
                ret = BCM_ERR_NOPERM;
                line = __LINE__;
                goto err_exit;
            }
        }
        arlIO.portHwID          = aPortID;
        arlIO.securityAction    = aSMDetectAction;
        swtIO.arlIO             = &arlIO;
        swtIO.retVal            = BCM_ERR_UNKNOWN;
        swtIO.swtHwID           = aSwtID;
        ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_SET_STATION_MOVE_DETECT, &swtIO);
        if (BCM_ERR_OK != ret) {
            ETHSWT_DrvReportError
        }
    }
    err_exit:
         ETHSWT_REPORT_ERR( ret, aSwtID, line,
            BRCM_SWDSGN_ETHSWT_DRV_GET_TOTALADDRLIMITANDCOUNTER_PROC, 0UL, 0UL, 0UL)
    return ret;
    @endcode
    @trace #BRCM_SWREQ_ETHSWT_SECURITY
    @trace #BRCM_SWARCH_ETHSWT_SET_STATIONMOVEMENTDETECTION_PROC

    @limitations None
*/
int32_t ETHSWT_SetStationMovementDetection(ETHSWT_HwIDType aSwtID,
            ETHSWT_PortIDType aPortID,
            ETHSWT_SecurityActionType aSMDetectAction)
{
    uint32_t line = __LINE__;
    ETHSWT_IOType swtIO;
    ETHSWT_ARLIOType arlIO;
    int32_t ret = BCM_ERR_INVAL_PARAMS;
    ETHSWT_MgmtModeType mode;

    if((aSwtID < SWITCH_MAX_HW_ID)  &&
        (aPortID < ETHSWT_PORT_ID_MAX) &&
        (aSMDetectAction <= ETHSWT_SECURITY_ACTION_REDIRECT_TO_CPU)) {
        if(ETHSWT_SECURITY_ACTION_REDIRECT_TO_CPU == aSMDetectAction) {
            ret = ETHSWT_GetMgmtMode(aSwtID, &mode);
            ETHSWT_CHECK_ERR(ret, &line, err_exit)
            if(ETHSWT_MGMTMODE_DISABLE == mode) {
                ret = BCM_ERR_NOPERM;
                line = __LINE__;
                goto err_exit;
            }
        }
        arlIO.portHwID          = aPortID;
        arlIO.securityAction    = aSMDetectAction;
        swtIO.arlIO             = &arlIO;
        swtIO.retVal            = BCM_ERR_UNKNOWN;
        swtIO.swtHwID           = aSwtID;
        ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_SET_STATION_MOVE_DETECT, &swtIO);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)

    }
err_exit:
    ETHSWT_REPORT_ERR( ret, aSwtID, line,
        BRCM_SWDSGN_ETHSWT_SET_STATIONMOVEMENTDETECTION_PROC, 0UL, 0UL, 0UL)
    return ret;
}

/** @brief Get station movement detection(enable/disable) status

    This API retreives switch station movement detection
    informations.

    @behavior Sync, Non re-entrant

    @pre None

    @param[in]      aSwtID                   Switch index
    @param[in]      aPortID                  Port index
    @param[out]     aSMDetectAction          Pointer to station movement
                                             detection action

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully retrieved station movement
                                        detection information information
    @retval     #BCM_ERR_TIME_OUT       Timeout occurred while reading/writing
                                        switch register
    @retval     #BCM_ERR_INVAL_PARAMS   (aSMDetectAction is NULL) or
                                        (Invalid aPortID) or
                                        (Invalid switch index)
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post None
    @code{.c}
    ETHSWT_IOType swtIO;
    ETHSWT_ARLIOType arlIO;
    ret = BCM_ERR_INVAL_PARAMS;

    if ((aSwtID < SWITCH_MAX_HW_ID)  &&
        (NULL != aSMDetectAction) &&
        (aPortID < ETHSWT_PORT_ID_MAX)) {
        arlIO.portHwID          = aPortID;
        swtIO.arlIO             = &arlIO;
        swtIO.retVal            = BCM_ERR_UNKNOWN;
        swtIO.swtHwID           = aSwtID;
        ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_GET_STATION_MOVE_DETECT, &swtIO);
        if (BCM_ERR_OK != ret) {
            ETHSWT_DrvReportError
        } else {
            *aSMDetectAction = arlIO.securityAction;
        }
    }
    return ret;
    @endcode
    @trace  #BRCM_SWREQ_ETHSWT_SECURITY
    @trace #BRCM_SWARCH_ETHSWT_GET_STATIONMOVEMENTDETECTION_PROC

    @limitations None
*/
int32_t ETHSWT_GetStationMovementDetection(ETHSWT_HwIDType aSwtID,
            ETHSWT_PortIDType aPortID,
            ETHSWT_SecurityActionType * const aSMDetectAction)
{
    ETHSWT_IOType swtIO;
    ETHSWT_ARLIOType arlIO;
    int32_t ret = BCM_ERR_INVAL_PARAMS;

    if((aSwtID < SWITCH_MAX_HW_ID)  &&
        (NULL != aSMDetectAction) &&
        (aPortID < ETHSWT_PORT_ID_MAX)) {
        arlIO.portHwID          = aPortID;
        swtIO.arlIO             = &arlIO;
        swtIO.retVal            = BCM_ERR_UNKNOWN;
        swtIO.swtHwID           = aSwtID;
        ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_GET_STATION_MOVE_DETECT, &swtIO);
        if(BCM_ERR_OK != ret) {
            ETHSWT_DrvReportError((BCM_SWT_ID & BCM_LOGMASK_USER), (uint8_t)aSwtID,
                    BRCM_SWDSGN_ETHSWT_GET_STATIONMOVEMENTDETECTION_PROC, ret, 0UL, 0UL,
                    0UL, __LINE__);
        } else {
            *aSMDetectAction = arlIO.securityAction;
        }
    }
    return ret;
}


/** @brief Set address limiting information of the port

    This API sets the maximum number of MAC addresses that are learned on
    the port. Only limits the number of dynamically learned unicast
    MAC addresses. MAC addresses configured by the CPU are not counted
    against the limit. API also sets the action, which will be triggered
    if the count of dynamically learned unicast MAC addresses on this
    port exceeds with the programmed value.

    @behavior Sync, Non re-entrant

    @pre None

    @param[in]      aSwtID                   Switch index
    @param[in]      aPortID                  Port index
    @param[in]      aAddressLimitInfo        Pointer to address limiting
                                             information

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully set address limiting information
                                        for the port
    @retval     #BCM_ERR_TIME_OUT       Timeout occurred while reading/writing
                                        switch register
    @retval     #BCM_ERR_INVAL_PARAMS   (Invalid switch index) or
                                        (Invalid aPortID) or
                                        (Invalid address limit
                                        action or value) or (aAddressLimitInfo
                                        is NULL)
    @retval     #BCM_ERR_NOPERM         CPU port is not available
                                        (Valid only for the action,
                                        redirect to CPU and copy to CPU)
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post None
    @code{.c}
    ETHSWT_IOType swtIO;
    ETHSWT_ARLIOType arlIO;
    ret = BCM_ERR_INVAL_PARAMS;
    ETHSWT_MgmtModeType mode;

    if ((aSwtID < SWITCH_MAX_HW_ID)   &&
       (aPortID < ETHSWT_PORT_ID_MAX) &&
       (NULL != aAddressLimitInfo)    &&
       (aAddressLimitInfo->overLimitAction <= ETHSWT_SECURITY_ACTION_COPY_TO_CPU) &&
       (aAddressLimitInfo->macLearningLimit <= ETHSWT_ARL_SIZE)) {
        if((ETHSWT_SECURITY_ACTION_REDIRECT_TO_CPU == aAddressLimitInfo->overLimitAction) ||
           (ETHSWT_SECURITY_ACTION_COPY_TO_CPU == aAddressLimitInfo->overLimitAction)) {
            ret = ETHSWT_GetMgmtMode(aSwtID, &mode);
            ETHSWT_CHECK_ERR(ret, &line, err_exit)
            if(ETHSWT_MGMTMODE_DISABLE == mode) {
                ret = BCM_ERR_NOPERM;
                line = __LINE__;
                goto err_exit;
            }
        }
        arlIO.portHwID     = aPortID;
        arlIO.addrLimitPtr = aAddressLimitInfo;
        swtIO.arlIO        = &arlIO;
        swtIO.retVal       = BCM_ERR_UNKNOWN;
        swtIO.swtHwID           = aSwtID;
        ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_SET_ADDRESS_LIMITING, &swtIO);
        if (BCM_ERR_OK != ret) {
            ETHSWT_DrvReportError
        }
    }
    err_exit:
    ETHSWT_REPORT_ERR( ret, aSwtID, line,
        BRCM_SWDSGN_ETHSWT_DRV_GET_MGMT_MODE_PROC, 0UL, 0UL, 0UL)
    return ret;
    @endcode
    @trace  #BRCM_SWREQ_ETHSWT_SECURITY
    @trace #BRCM_SWARCH_ETHSWT_SET_PORT_ADDRLIMITING_PROC

    @limitations None
*/
int32_t ETHSWT_SetPortAddrLimiting(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID,
        const ETHSWT_AddressLimitingType * const aAddressLimitInfo)
{
    uint32_t line = __LINE__;
    ETHSWT_IOType swtIO;
    ETHSWT_ARLIOType arlIO;
    int32_t ret = BCM_ERR_INVAL_PARAMS;
    ETHSWT_MgmtModeType mode;
    ETHSWT_AddressLimitingType addressLimitInfo;

    if((aSwtID < SWITCH_MAX_HW_ID)   &&
       (aPortID < ETHSWT_PORT_ID_MAX) &&
       (NULL != aAddressLimitInfo)    &&
       (aAddressLimitInfo->overLimitAction <= ETHSWT_SECURITY_ACTION_COPY_TO_CPU) &&
       (aAddressLimitInfo->macLearningLimit <= ETHSWT_ARL_SIZE)) {
        if((ETHSWT_SECURITY_ACTION_REDIRECT_TO_CPU == aAddressLimitInfo->overLimitAction) ||
           (ETHSWT_SECURITY_ACTION_COPY_TO_CPU == aAddressLimitInfo->overLimitAction)) {
            ret = ETHSWT_GetMgmtMode(aSwtID, &mode);
            ETHSWT_CHECK_ERR(ret, &line, err_exit)
            if(ETHSWT_MGMTMODE_DISABLE == mode) {
                ret = BCM_ERR_NOPERM;
                line = __LINE__;
                goto err_exit;
            }
        }
        arlIO.portHwID     = aPortID;
        BCM_MemCpy(&addressLimitInfo, aAddressLimitInfo, sizeof(ETHSWT_AddressLimitingType));
        arlIO.addrLimitPtr = &addressLimitInfo;
        swtIO.arlIO        = &arlIO;
        swtIO.retVal       = BCM_ERR_UNKNOWN;
        swtIO.swtHwID           = aSwtID;
        ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_SET_ADDRESS_LIMITING, &swtIO);
        if(BCM_ERR_OK != ret) {
            ETHSWT_DrvReportError((BCM_SWT_ID & BCM_LOGMASK_USER), (uint8_t)aSwtID,
                    BRCM_SWDSGN_ETHSWT_SET_PORT_ADDRLIMITING_PROC, ret, 0UL, 0UL,
                    0UL, __LINE__);
        }
    }
err_exit:
    ETHSWT_REPORT_ERR( ret, aSwtID, line,
        BRCM_SWDSGN_ETHSWT_SET_PORT_ADDRLIMITING_PROC, 0UL, 0UL, 0UL)
    return ret;
}

/** @brief Get address limiting information for the port

    This API retreives switch address limiting information
    of the provided port.

    @behavior Sync, Non re-entrant

    @pre None

    @param[in]      aSwtID                   Switch index
    @param[in]      aPortID                  Port index
    @param[out]     aAddressLimitInfo        Pointer to address limiting
                                             action
    @param[out]     aPortLearnedCounter      pointer to the number
                                             of SA MAC addresses
                                             learned on this ports.
                                             This counter can't exceed
                                             the max programmed learning
                                             value of this port
    @param[out]     aPortOverLimitCounter    pointer to the overlimit
                                             counter value of this ports.
                                             This counter is the number of
                                             packets ingress to this port after
                                             port SA learn counter exceeds to
                                             SA learn limit.

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully retrieved address limiting
                                        information of the provided port
    @retval     #BCM_ERR_TIME_OUT       Timeout occurred while reading/writing
                                        switch register
    @retval     #BCM_ERR_INVAL_PARAMS   (Invalid switch index) or
                                        (Invalid aPortID) or
                                        (aAddressLimitInfo is NULL) or
                                        (aPortLearnedCounter is NULL) or
                                        (aPortOverLimitCounter is NULL)
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post None
    @code{.c}
    ETHSWT_IOType swtIO;
    ETHSWT_ARLIOType arlIO;
    ret = BCM_ERR_INVAL_PARAMS;

    if ((aSwtID < SWITCH_MAX_HW_ID)   &&
       (aPortID < ETHSWT_PORT_ID_MAX) &&
       (NULL != aAddressLimitInfo)    &&
       (NULL != aPortLearnedCounter)  &&
       (NULL != aPortOverLimitCounter)) {
        arlIO.portHwID     = aPortID;
        arlIO.addrLimitPtr = aAddressLimitInfo;
        swtIO.arlIO        = &arlIO;
        swtIO.retVal       = BCM_ERR_UNKNOWN;
        swtIO.swtHwID           = aSwtID;
        ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_GET_ADDRESS_LIMITING, &swtIO);
        if (BCM_ERR_OK == ret) {
            *aPortLearnedCounter   = arlIO.macLearnedCounter;
            *aPortOverLimitCounter = arlIO.overLimitCounter;
        } else {
            ETHSWT_DrvReportError
        }
    }
    return ret;
    @endcode
    @trace  #BRCM_SWREQ_ETHSWT_SECURITY
    @trace #BRCM_SWARCH_ETHSWT_GET_PORT_ADDRLIMITANDCOUNTER_PROC

    @limitations None
*/
int32_t ETHSWT_GetPortAddrLimitAndCounter(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID,
        ETHSWT_AddressLimitingType * const aAddressLimitInfo,
        uint16_t * const aPortLearnedCounter,
        uint32_t * const aPortOverLimitCounter)
{
    ETHSWT_IOType swtIO;
    ETHSWT_ARLIOType arlIO;
    int32_t ret = BCM_ERR_INVAL_PARAMS;

    if((aSwtID < SWITCH_MAX_HW_ID)   &&
       (aPortID < ETHSWT_PORT_ID_MAX) &&
       (NULL != aAddressLimitInfo)    &&
       (NULL != aPortLearnedCounter)  &&
       (NULL != aPortOverLimitCounter)) {
        arlIO.portHwID     = aPortID;
        arlIO.addrLimitPtr = aAddressLimitInfo;
        swtIO.arlIO        = &arlIO;
        swtIO.retVal       = BCM_ERR_UNKNOWN;
        swtIO.swtHwID           = aSwtID;
        ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_GET_ADDRESS_LIMITING, &swtIO);
        if(BCM_ERR_OK == ret) {
            *aPortLearnedCounter   = arlIO.macLearnedCounter;
            *aPortOverLimitCounter = arlIO.overLimitCounter;
        } else {
            ETHSWT_DrvReportError((BCM_SWT_ID & BCM_LOGMASK_USER), (uint8_t)aSwtID,
                    BRCM_SWDSGN_ETHSWT_GET_PORTADDRLIMITANDCOUNTER_PROC, ret, 0UL, 0UL,
                    0UL, __LINE__);
        }
    }
    return ret;
}

/** @brief Set sticky MAC Address action to the port

    This API sets the sticky MAC Address action to a port.
    If a single MAC address (or a small number of MAC addresses)
    is/are sticky to a port, then any packet arriving with Source
    MAC address which is sticky to that port should only be allowed.
    If the incoming packet is an IEEE 802.1X packet, or special
    frames, the incoming packets are forwarded.

    @behavior Sync, Non re-entrant

    @pre Hardware learning can be disabled.

    @param[in]      aSwtID                   Switch index
    @param[in]      aPortID                  Port index
    @param[in]      aStickyMACAction         Sticky MAC address
                                             action

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully set sticky MAC Address
                                        action to the port
    @retval     #BCM_ERR_TIME_OUT       Timeout occurred while reading/writing
                                        switch register
    @retval     #BCM_ERR_INVAL_PARAMS   (Invalid switch index) or
                                        (Invalid aPortID) or
                                        (Invalid sticky MAC address
                                        action)
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized
    @retval     #BCM_ERR_NOPERM         CPU port is not available
                                        (Valid only for the action,
                                        redirect to CPU)

    @post None
    @code{.c}
    ETHSWT_IOType swtIO;
    ETHSWT_ARLIOType arlIO;
    ret = BCM_ERR_INVAL_PARAMS;
    ETHSWT_MgmtModeType mode;

    if ((aSwtID < SWITCH_MAX_HW_ID)  &&
       (aPortID < ETHSWT_PORT_ID_MAX) &&
       (aStickyMACAction <= ETHSWT_SECURITY_ACTION_REDIRECT_TO_CPU)) {
        if(ETHSWT_SECURITY_ACTION_REDIRECT_TO_CPU == aStickyMACAction) {
            ret = ETHSWT_GetMgmtMode(aSwtID, &mode);
            ETHSWT_CHECK_ERR(ret, &line, err_exit)
            if(ETHSWT_MGMTMODE_DISABLE == mode) {
                ret = BCM_ERR_NOPERM;
                line = __LINE__;
                goto err_exit;
            }
        }
        arlIO.portHwID          = aPortID;
        arlIO.securityAction    = aStickyMACAction;
        swtIO.arlIO             = &arlIO;
        swtIO.retVal            = BCM_ERR_UNKNOWN;
        swtIO.swtHwID           = aSwtID;
        ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_SET_STICKY_MAC_ADDRESS, &swtIO);
        if (BCM_ERR_OK != ret) {
            ETHSWT_DrvReportError
        }
    }
    err_exit:
    ETHSWT_REPORT_ERR( ret, aSwtID, line,
        BRCM_SWDSGN_ETHSWT_SET_MACADDRESSSTICKYTOPORT_PROC, 0UL, 0UL, 0UL)
    return ret;
    @endcode
    @trace #BRCM_SWREQ_ETHSWT_SECURITY
    @trace #BRCM_SWARCH_ETHSWT_SET_MACADDRESSSTICKYTOPORT_PROC

    @limitations None
*/
int32_t ETHSWT_SetMACAddressStickyToPort(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID,
        ETHSWT_SecurityActionType aStickyMACAction)
{
    uint32_t line = __LINE__;
    ETHSWT_IOType swtIO;
    ETHSWT_ARLIOType arlIO;
    int32_t ret = BCM_ERR_INVAL_PARAMS;
    ETHSWT_MgmtModeType mode;

    if((aSwtID < SWITCH_MAX_HW_ID)  &&
       (aPortID < ETHSWT_PORT_ID_MAX) &&
       (aStickyMACAction <= ETHSWT_SECURITY_ACTION_REDIRECT_TO_CPU)) {
        if(ETHSWT_SECURITY_ACTION_REDIRECT_TO_CPU == aStickyMACAction) {
            ret = ETHSWT_GetMgmtMode(aSwtID, &mode);
            ETHSWT_CHECK_ERR(ret, &line, err_exit)
            if(ETHSWT_MGMTMODE_DISABLE == mode) {
                ret = BCM_ERR_NOPERM;
                line = __LINE__;
                goto err_exit;
            }
        }
        arlIO.portHwID          = aPortID;
        arlIO.securityAction    = aStickyMACAction;
        swtIO.arlIO             = &arlIO;
        swtIO.retVal            = BCM_ERR_UNKNOWN;
        swtIO.swtHwID           = aSwtID;
        ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_SET_STICKY_MAC_ADDRESS, &swtIO);
        if (BCM_ERR_OK != ret) {
            ETHSWT_DrvReportError((BCM_SWT_ID & BCM_LOGMASK_USER), (uint8_t)aSwtID,
                    BRCM_SWDSGN_ETHSWT_SET_MACADDRESSSTICKYTOPORT_PROC, ret, 0UL, 0UL,
                    0UL, __LINE__);
        }
    }
err_exit:
    ETHSWT_REPORT_ERR( ret, aSwtID, line,
        BRCM_SWDSGN_ETHSWT_SET_MACADDRESSSTICKYTOPORT_PROC, 0UL, 0UL, 0UL)
    return ret;
}

/** @brief Get sticky MAC Address information to the port

    This API retreives sticky MAC Address information
    of the provided port.

    @behavior Sync, Non re-entrant

    @pre Hardware learning can be disabled.

    @param[in]      aSwtID                   Switch index
    @param[in]      aPortID                  Port index
    @param[out]     aStickyMACAction         Pointer to sticky MAC address
                                             action

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully retrieved sticky MAC
                                        Address information to the port
    @retval     #BCM_ERR_TIME_OUT       Timeout occurred while reading/writing
                                        switch register
    @retval     #BCM_ERR_INVAL_PARAMS   (Invalid switch index) or
                                        (Invalid aPortID) or
                                        (aStickyMACAction is NULL)
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post None
    @code{.c}
    ETHSWT_IOType swtIO;
    ETHSWT_ARLIOType arlIO;
    ret = BCM_ERR_INVAL_PARAMS;

    if ((aSwtID < SWITCH_MAX_HW_ID)  &&
       (NULL != aStickyMACAction) &&
       (aPortID < ETHSWT_PORT_ID_MAX)) {
        arlIO.portHwID          = aPortID;
        swtIO.arlIO             = &arlIO;
        swtIO.retVal            = BCM_ERR_UNKNOWN;
        swtIO.swtHwID           = aSwtID;
        ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_GET_STICKY_MAC_ADDRESS, &swtIO);
        if (BCM_ERR_OK != ret) {
            ETHSWT_DrvReportError
        } else {
            *aStickyMACAction = arlIO.securityAction;
        }
    }
    return ret;
    @endcode
    @trace #BRCM_SWREQ_ETHSWT_SECURITY
    @trace #BRCM_SWARCH_ETHSWT_GET_MACADDRESSSTICKYTOPORT_PROC

    @limitations None
*/
int32_t ETHSWT_GetMACAddressStickyToPort(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID,
        ETHSWT_SecurityActionType * const aStickyMACAction)
{
    ETHSWT_IOType swtIO;
    ETHSWT_ARLIOType arlIO;
    int32_t ret = BCM_ERR_INVAL_PARAMS;

    if((aSwtID < SWITCH_MAX_HW_ID)  &&
       (NULL != aStickyMACAction) &&
       (aPortID < ETHSWT_PORT_ID_MAX)) {
        arlIO.portHwID          = aPortID;
        swtIO.arlIO             = &arlIO;
        swtIO.retVal            = BCM_ERR_UNKNOWN;
        swtIO.swtHwID           = aSwtID;
        ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_GET_STICKY_MAC_ADDRESS, &swtIO);
        if(BCM_ERR_OK != ret) {
            ETHSWT_DrvReportError((BCM_SWT_ID & BCM_LOGMASK_USER), (uint8_t)aSwtID,
                    BRCM_SWDSGN_ETHSWT_GET_MACADDRESSSTICKYTOPORT_PROC, ret, 0UL, 0UL,
                    0UL, __LINE__);
        } else {
            *aStickyMACAction = arlIO.securityAction;
        }
    }
    return ret;
}

/** @brief Set total MAC-SA limiting control

    This API sets the maximum number of MAC addresses that are learned
    accross all the port. When Address Limit is reached (i.e.,  either
    port-wise limit is reached or overall limit is reached), the subsequent
    actions are controlled by the over limit action field of the corresponding
    port.

    @behavior Sync, Non re-entrant

    @pre None

    @param[in]      aSwtID                   Switch index
    @param[in]      aTotalMACLearningLimit   maximum number of MAC
                                             addresses allowed to
                                             learn across all ports

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully set address limiting information
                                        for the port
    @retval     #BCM_ERR_TIME_OUT       Timeout occurred while reading/writing
                                        switch register
    @retval     #BCM_ERR_INVAL_PARAMS   (Invalid switch index) or
                                        (aTotalMACLearningLimit
                                        is greater than the maximum
                                        ARL table size)
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post None
    @code{.c}
    ETHSWT_IOType swtIO;
    ETHSWT_ARLIOType arlIO;
    ret = BCM_ERR_INVAL_PARAMS;

    if ((aSwtID < SWITCH_MAX_HW_ID)   &&
       (aTotalMACLearningLimit <= ETHSWT_ARL_SIZE)) {
        arlIO.totalMACLearningLimit = aTotalMACLearningLimit;
        swtIO.arlIO   = &arlIO;
        swtIO.retVal  = BCM_ERR_UNKNOWN;
        swtIO.swtHwID = aSwtID;
        ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_SET_TOTAL_ADDRESS_LIMIT, &swtIO);
        if (BCM_ERR_OK != ret) {
            ETHSWT_DrvReportError
        }
    }
    return ret;
    @endcode
    @trace  #BRCM_SWREQ_ETHSWT_SECURITY
    @trace #BRCM_SWARCH_ETHSWT_SET_TOTALADDRLIMIT_PROC

    @limitations None
*/
int32_t ETHSWT_SetTotalAddrLimit(ETHSWT_HwIDType aSwtID,
        uint16_t aTotalMACLearningLimit)
{
    ETHSWT_IOType swtIO;
    ETHSWT_ARLIOType arlIO;
    int32_t ret = BCM_ERR_INVAL_PARAMS;

    if((aSwtID < SWITCH_MAX_HW_ID)   &&
       (aTotalMACLearningLimit <= ETHSWT_ARL_SIZE)) {
        arlIO.totalMACLearningLimit = aTotalMACLearningLimit;
        swtIO.arlIO   = &arlIO;
        swtIO.retVal  = BCM_ERR_UNKNOWN;
        swtIO.swtHwID = aSwtID;
        ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_SET_TOTAL_ADDRESS_LIMIT, &swtIO);
        if(BCM_ERR_OK != ret) {
            ETHSWT_DrvReportError((BCM_SWT_ID & BCM_LOGMASK_USER), (uint8_t)aSwtID,
                    BRCM_SWDSGN_ETHSWT_SET_TOTALADDRLIMIT_PROC, ret, 0UL, 0UL,
                    0UL, __LINE__);
        }
    }
    return ret;
}

/** @brief Get total MAC-SA limiting control

    This API retreives total MAC-SA limit accross
    all the port.

    @behavior Sync, Non re-entrant

    @pre None

    @param[in]      aSwtID                   Switch index
    @param[out]     aTotalMACLearningLimit   pointer to maximum
                                             number of MAC
                                             addresses allowed to
                                             learn on all ports
    @param[out]     aTotalLearnedCounter     pointer to the number
                                             of SA MAC addresses
                                             learned on all ports.
                                             This counter can't exceed
                                             the max programmed learning
                                             value across all the port

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully set address limiting information
                                        for the port
    @retval     #BCM_ERR_TIME_OUT       Timeout occurred while reading/writing
                                        switch register
    @retval     #BCM_ERR_INVAL_PARAMS   (Invalid switch index) or
                                        (aTotalMACLearningLimit
                                        is NULL) or (aTotalLearnedCounter
                                        is NULL)
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post None
    @code{.c}
    ETHSWT_IOType swtIO;
    ETHSWT_ARLIOType arlIO;
    ret = BCM_ERR_INVAL_PARAMS;

    if ((aSwtID < SWITCH_MAX_HW_ID)     &&
       (NULL != aTotalMACLearningLimit) &&
       (NULL != aTotalLearnedCounter)) {
        swtIO.arlIO    = &arlIO;
        swtIO.retVal   = BCM_ERR_UNKNOWN;
        swtIO.swtHwID  = aSwtID;
        ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_GET_TOTAL_ADDRESS_LIMIT, &swtIO);
        if (BCM_ERR_OK == ret) {
            *aTotalMACLearningLimit = arlIO.totalMACLearningLimit;
            *aTotalLearnedCounter   = arlIO.macLearnedCounter;
        } else {
            ETHSWT_DrvReportError
        }
    }
    return ret;
    @endcode
    @trace #BRCM_SWREQ_ETHSWT_SECURITY
    @trace #BRCM_SWARCH_ETHSWT_GET_TOTALADDRLIMITANDCOUNTER_PROC

    @limitations None
*/
int32_t ETHSWT_GetTotalAddrLimitAndCounter(ETHSWT_HwIDType aSwtID,
        uint16_t * const aTotalMACLearningLimit,
        uint16_t * const aTotalLearnedCounter)
{
    ETHSWT_IOType swtIO;
    ETHSWT_ARLIOType arlIO;
    int32_t ret = BCM_ERR_INVAL_PARAMS;

    if((aSwtID < SWITCH_MAX_HW_ID)     &&
       (NULL != aTotalMACLearningLimit) &&
       (NULL != aTotalLearnedCounter)) {
        swtIO.arlIO    = &arlIO;
        swtIO.retVal   = BCM_ERR_UNKNOWN;
        swtIO.swtHwID  = aSwtID;
        ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_GET_TOTAL_ADDRESS_LIMIT, &swtIO);
        if(BCM_ERR_OK == ret) {
            *aTotalMACLearningLimit = arlIO.totalMACLearningLimit;
            *aTotalLearnedCounter   = arlIO.macLearnedCounter;
        } else {
            ETHSWT_DrvReportError((BCM_SWT_ID & BCM_LOGMASK_USER), (uint8_t)aSwtID,
                    BRCM_SWDSGN_ETHSWT_GET_TOTALADDRLIMITANDCOUNTER_PROC, ret, 0UL, 0UL,
                    0UL, __LINE__);
        }
    }
    return ret;
}
#endif /* ENABLE_ETHSWT_SECURITY */


/** @} */
