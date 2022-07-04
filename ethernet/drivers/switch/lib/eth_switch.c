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
    @defgroup grp_ethswt_impl Ethernet switch implementation
    @ingroup grp_ethswt

    @addtogroup grp_ethswt_impl
    @{

    @file eth_switch.c

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
#if defined(__BCM8956X__) || defined(__BCM8957X__)
#include "p1588_rdb.h"
#endif
#include <mcu_switch_ext.h>
#include <cpu_indirect_rdb.h>

/**
    @name Ethernet switch Design ID's
    @{
    @brief Ethernet switch Design ID's
*/
#define BRCM_SWDSGN_ETHSWT_DRV_RDWR_TIMEOUT_MACRO                     (0xB101U)    /**< @brief #ETHSWT_DRV_RDWR_TIMEOUT                  */
#define BRCM_SWDSGN_ETHSWT_CPU_INDIRECT_REGS_GLOBAL                   (0xB102U)    /**< @brief #ETHSWT_CPUIndirectRegs                   */
#define BRCM_SWDSGN_ETHSWT_DRV_READ_REG_PROC                          (0xB103U)    /**< @brief #ETHSWT_DrvReadReg                        */
#define BRCM_SWDSGN_ETHSWT_DRV_WRITE_REG_PROC                         (0xB104U)    /**< @brief #ETHSWT_DrvWriteReg                       */
#define BRCM_SWDSGN_ETHSWT_DRV_REPORT_ERROR_PROC                      (0xB105U)    /**< @brief #ETHSWT_DrvReportError                    */
#define BRCM_SWDSGN_ETHSWT_DRV_BUF_STATE_TYPE                         (0xB106U)    /**< @brief #ETHSWT_DrvBufStateType                   */
#define BRCM_SWDSGN_ETHSWT_DRV_BUF_INFO_TYPE                          (0xB107U)    /**< @brief #ETHSWT_DrvBufInfoType                    */
#define BRCM_SWDSGN_ETHSWT_DRV_TX_BUF_INFO_Q_SIZE_MACRO               (0xB108U)    /**< @brief #ETHSWT_DRV_TX_BUF_INFO_Q_SIZE            */
#define BRCM_SWDSGN_ETHSWT_DRV_RX_BUF_INFO_Q_SIZE_MACRO               (0xB109U)    /**< @brief #ETHSWT_DRV_RX_BUF_INFO_Q_SIZE            */
#define BRCM_SWDSGN_ETHSWT_IS_PORT_LINK_STATUS_CHANGED_MASK_MACRO     (0xB10AU)    /**< @brief #ETHSWT_IS_PORT_LINK_STATUS_CHANGED_MASK  */
#define BRCM_SWDSGN_ETHSWT_IS_PORT_LINK_STATUS_CHANGED_SHIFT_MACRO    (0xB10BU)    /**< @brief #ETHSWT_IS_PORT_LINK_STATUS_CHANGED_SHIFT */
#define BRCM_SWDSGN_ETHSWT_REGS_GLOBAL                                (0xB10CU)    /**< @brief #ETHSWT_Regs                              */
#define BRCM_SWDSGN_ETHSWT_DRV_TX_BUF_INFO_Q_GLOBAL                   (0xB10DU)    /**< @brief #ETHSWT_DrvTxBufInfoQ                     */
#define BRCM_SWDSGN_ETHSWT_DRV_RX_BUF_INFO_Q_GLOBAL                   (0xB10EU)    /**< @brief #ETHSWT_DrvRxBufInfoQ                     */
#define BRCM_SWDSGN_ETHSWT_DRV_DATA_GLOBAL                            (0xB10FU)    /**< @brief #ETHSWT_DrvData                           */
#define BRCM_SWDSGN_ETHSWT_DRV_SET_PORT_ROLE_PROC                     (0xB110U)    /**< @brief #ETHSWT_DrvSetPortRole                    */
#define BRCM_SWDSGN_ETHSWT_DRV_CPU_PORT_CONFIG_PROC                   (0xB111U)    /**< @brief #ETHSWT_DrvCPUPortConfig                  */
#define BRCM_SWDSGN_ETHSWT_DRV_INIT_PROC                              (0xB112U)    /**< @brief #ETHSWT_DrvInit                           */
#define BRCM_SWDSGN_ETHSWT_DRV_TX_ADAPT_BUFFER_PROC                   (0xB113U)    /**< @brief #ETHSWT_DrvTxAdaptBuffer                  */
#define BRCM_SWDSGN_ETHSWT_DRV_SET_MGMT_INFO_PROC                     (0xB114U)    /**< @brief #ETHSWT_DrvSetMgmtInfo                    */
#define BRCM_SWDSGN_ETHSWT_DRV_TX_PROCESS_FRAME_PROC                  (0xB115U)    /**< @brief #ETHSWT_DrvTxProcessFrame                 */
#define BRCM_SWDSGN_ETHSWT_DRV_TX_DONE_IND_PROC                       (0xB116U)    /**< @brief #ETHSWT_DrvTxDoneInd                      */
#define BRCM_SWDSGN_ETHSWT_DRV_TX_DONE_IND_COMPLETE_PROC              (0xB117U)    /**< @brief #ETHSWT_DrvTxDoneIndComplete              */
#define BRCM_SWDSGN_ETHSWT_DRV_RX_PROCESS_FRAME_PROC                  (0xB118U)    /**< @brief #ETHSWT_DrvRxProcessFrame                 */
#define BRCM_SWDSGN_ETHSWT_DRV_RX_DONE_IND_PROC                       (0xB119U)    /**< @brief #ETHSWT_DrvRxDoneInd                      */
#define BRCM_SWDSGN_ETHSWT_DRV_RX_DONE_IND_COMPLETE_PROC              (0xB11AU)    /**< @brief #ETHSWT_DrvRxDoneIndComplete              */
#define BRCM_SWDSGN_ETHSWT_DRV_SET_DUMB_FWD_MODE_PROC                 (0xB11BU)    /**< @brief #ETHSWT_DrvSetDumbFwdMode                 */
#define BRCM_SWDSGN_ETHSWT_DRV_GET_DUMB_FWD_MODE_PROC                 (0xB11CU)    /**< @brief #ETHSWT_DrvGetDumbFwdMode                 */
#define BRCM_SWDSGN_ETHSWT_GET_DUMB_FWD_MODE_PROC                     (0xB11DU)    /**< @brief #ETHSWT_GetDumbFwdMode                    */
#define BRCM_SWDSGN_ETHSWT_SET_DUMB_FWD_MODE_PROC                     (0xB11EU)    /**< @brief #ETHSWT_SetDumbFwdMode                    */
#define BRCM_SWDSGN_ETHSWT_READ_REG_PROC                              (0xB11FU)    /**< @brief #ETHSWT_ReadReg                           */
#define BRCM_SWDSGN_ETHSWT_WRITE_REG_PROC                             (0xB120U)    /**< @brief #ETHSWT_WriteReg                          */
#define BRCM_SWDSGN_ETHSWT_INIT_PROC                                  (0xB121U)    /**< @brief #ETHSWT_Init                              */
#define BRCM_SWDSGN_ETHSWT_SET_MGMT_INFO_PROC                         (0xB124U)    /**< @brief #ETHSWT_SetMgmtInfo                       */
#define BRCM_SWDSGN_ETHSWT_TX_ADAPT_BUFFER_PROC                       (0xB125U)    /**< @brief #ETHSWT_TxAdaptBuffer                     */
#define BRCM_SWDSGN_ETHSWT_TX_PROCESS_FRAME_PROC                      (0xB126U)    /**< @brief #ETHSWT_TxProcessFrame                    */
#define BRCM_SWDSGN_ETHSWT_TX_DONE_IND_PROC                           (0xB127U)    /**< @brief #ETHSWT_TxDoneInd                         */
#define BRCM_SWDSGN_ETHSWT_RX_PROCESS_FRAME_PROC                      (0xB128U)    /**< @brief #ETHSWT_RxProcessFrame                    */
#define BRCM_SWDSGN_ETHSWT_RX_DONE_IND_PROC                           (0xB129U)    /**< @brief #ETHSWT_RxDoneInd                         */
#define BRCM_SWDSGN_ETHSWT_DRV_PORT_CONFIG_PROC                       (0xB12AU)    /**< @brief #ETHSWT_DrvPortConfig                     */
#define BRCM_SWDSGN_ETHSWT_DRV_SET_SWITCH_TYPE_PROC                   (0xB12BU)    /**< @brief #ETHSWT_DrvSetSwitchType                  */
#define BRCM_SWDSGN_ETHSWT_DRV_VLAN_CONFIG_PROC                       (0xB12CU)    /**< @brief #ETHSWT_DrvVLANConfig                     */
#define BRCM_SWDSGN_ETHSWT_SET_PORT_ROLE_PROC                         (0xB12DU)    /**< @brief #ETHSWT_SetPortRole                       */
#define BRCM_SWDSGN_ETHSWT_SET_SWITCH_TYPE_PROC                       (0xB12EU)    /**< @brief #ETHSWT_SetSwitchType                     */
#define BRCM_SWDSGN_ETHSWT_CMD_HANDLER_PROC                           (0xB12FU)    /**< @brief #ETHSWT_CmdHandler                        */
#define BRCM_SWDSGN_ETHSWT_GET_STATE_PROC                             (0xB130U)    /**< @brief #ETHSWT_GetState                          */
#define BRCM_SWDSGN_ETHSWT_DRV_GET_TIME_HW_PORT_PROC                  (0xB131U)    /**< @brief #ETHSWT_DrvGetTimeHwPort                  */
#define BRCM_SWDSGN_ETHSWT_DRV_ENABLE_TX_TS_PROC                      (0xB132U)    /**< @brief #ETHSWT_DrvEnableTxTS                     */
#define BRCM_SWDSGN_ETHSWT_DRV_GET_TX_TIME_STAMP_PROC                 (0xB133U)    /**< @brief #ETHSWT_DrvGetTxTimestamp                 */
#define BRCM_SWDSGN_ETHSWT_DRV_GET_RX_TIME_STAMP_PROC                 (0xB134U)    /**< @brief #ETHSWT_DrvGetRxTimestamp                 */
#define BRCM_SWDSGN_ETHSWT_DRV_ENABLE_TX_TIMESTAMP_PROC               (0xB135U)    /**< @brief #ETHSWT_DrvEnableTxTimestamp              */
#define BRCM_SWDSGN_ETHSWT_DRV_SET_TS_ENABLED_PROC                    (0xB136U)    /**< @brief #ETHSWT_DrvSetTSEnabled                   */
#define BRCM_SWDSGN_ETHSWT_ENABLE_TX_TIMESTAMP_PROC                   (0xB137U)    /**< @brief #ETHSWT_EnableTxTimestamp                 */
#define BRCM_SWDSGN_ETHSWT_DRV_SET_MGMT_MODE_PROC                     (0xB138U)    /**< @brief #ETHSWT_DrvSetMgmtMode                    */
#define BRCM_SWDSGN_ETHSWT_DRV_GET_MGMT_MODE_PROC                     (0xB139U)    /**< @brief #ETHSWT_DrvGetMgmtMode                    */
#define BRCM_SWDSGN_ETHSWT_GET_MGMT_MODE_PROC                         (0xB13AU)    /**< @brief #ETHSWT_GetMgmtMode                       */
#define BRCM_SWDSGN_ETHSWT_SET_MGMT_MODE_PROC                         (0xB13BU)    /**< @brief #ETHSWT_SetMgmtMode                       */
#define BRCM_SWDSGN_ETHSWT_DRV_SET_BRCM_HDR_MODE_PROC                 (0xB13CU)    /**< @brief #ETHSWT_DrvSetBrcmHdrMode                 */
#define BRCM_SWDSGN_ETHSWT_DRV_GET_BRCM_HDR_MODE_PROC                 (0xB13DU)    /**< @brief #ETHSWT_DrvGetBrcmHdrMode                 */
#define BRCM_SWDSGN_ETHSWT_GET_BRCM_HDR_MODE_PROC                     (0xB13EU)    /**< @brief #ETHSWT_GetBrcmHdrMode                    */
#define BRCM_SWDSGN_ETHSWT_SET_BRCM_HDR_MODE_PROC                     (0xB13FU)    /**< @brief #ETHSWT_SetBrcmHdrMode                    */
#define BRCM_SWDSGN_ETHSWT_ENABLEBHSHIFT_PROC                         (0xB140U)    /**< @brief #ETHSWT_EnableBHShift                     */
#define BRCM_SWDSGN_ETHSWT_DRVENABLEBHSHIFT_PROC                      (0xB141U)    /**< @brief #ETHSWT_DrvEnableBHShift                  */
#define BRCM_SWDSGN_ETHSWT_ENABLERX_PROC                              (0xB142U)    /**< @brief #ETHSWT_EnableRx                          */
#define BRCM_SWDSGN_ETHSWT_DISABLERX_PROC                             (0xB143U)    /**< @brief #ETHSWT_DisableRx                         */
#define BRCM_SWDSGN_ETHSWT_DRVENABLERX_PROC                           (0xB144U)    /**< @brief #ETHSWT_DrvEnableRx                       */
#define BRCM_SWDSGN_ETHSWT_DRVDISABLERX_PROC                          (0xB145U)    /**< @brief #ETHSWT_DrvDisableRx                      */
#define BRCM_SWDSGN_ETHSWT_DRV_READ_REG_32_PROC                       (0xB146U)    /**< @brief #ETHSWT_DrvReadReg32                      */
#define BRCM_SWDSGN_ETHSWT_DRV_WRITE_REG_32_PROC                      (0xB147U)    /**< @brief #ETHSWT_DrvWriteReg32                     */
#define BRCM_SWDSGN_ETHSWT_DRV_READ_REG_16_PROC                       (0xB148U)    /**< @brief #ETHSWT_DrvReadReg16                      */
#define BRCM_SWDSGN_ETHSWT_DRV_WRITE_REG_16_PROC                      (0xB149U)    /**< @brief #ETHSWT_DrvWriteReg16                     */
#define BRCM_SWDSGN_ETHSWT_DRV_READ_REG_8_PROC                        (0xB14AU)    /**< @brief #ETHSWT_DrvReadReg8                       */
#define BRCM_SWDSGN_ETHSWT_DRV_WRITE_REG_8_PROC                       (0xB14BU)    /**< @brief #ETHSWT_DrvWriteReg8                      */
/** @} */

/**
    @name Switch management IDs
    @{
    @brief Switch management states

    @trace #BRCM_SWARCH_ETHSWT_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_MANAGEMENT
*/
typedef uint32_t ETHSWT_DrvBufStateType;
#define ETHSWT_DRV_BUF_STATE_FREE            (0UL)
#define ETHSWT_DRV_BUF_STATE_ADAPTED         (1UL)
#define ETHSWT_DRV_BUF_STATE_MGMT_INFO_SET   (2UL)
#define ETHSWT_DRV_BUF_STATE_PROCESSED       (3UL)
/** @} */

/**
    @brief Buffer information type

    @trace #BRCM_SWARCH_ETHSWT_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_MANAGEMENT
*/
typedef struct sETHSWT_DrvBufInfoType {
    ETHSWT_DrvBufStateType bufState;
    ETHSWT_MgmtInfoType mgmtInfo;
    const uint8_t * buf;
    uint32_t isTSEnabled;
} ETHSWT_DrvBufInfoType;


/**
    @brief Switch Tx buffer info queue size

    @trace #BRCM_SWARCH_ETHSWT_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION
*/
#define ETHSWT_DRV_TX_BUF_INFO_Q_SIZE        (128UL)

/**
    @brief Switch Rx buffer info queue size

    @trace #BRCM_SWARCH_ETHSWT_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION
*/
#define ETHSWT_DRV_RX_BUF_INFO_Q_SIZE        (32UL)


/**
    @brief Switch registers

    @trace #BRCM_SWARCH_ETHSWT_CMD_HANDLER_PROC

    @trace #BRCM_SWREQ_ETHSWT_KERNEL_INTERFACE
*/
SWITCH_RDBType *const ETHSWT_Regs = (SWITCH_RDBType *)SWITCH_BASE;

/**
    @brief Tx buffer information queue

    @trace #BRCM_SWARCH_ETHSWT_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_MANAGEMENT
*/
static ETHSWT_DrvBufInfoType ETHSWT_DrvTxBufInfoQ[ETHSWT_DRV_TX_BUF_INFO_Q_SIZE] COMP_SECTION(".bss.drivers");

/**
    @brief Rx buffer information queue

    @trace #BRCM_SWARCH_ETHSWT_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_MANAGEMENT
*/
static ETHSWT_DrvBufInfoType ETHSWT_DrvRxBufInfoQ[ETHSWT_DRV_RX_BUF_INFO_Q_SIZE] COMP_SECTION(".bss.drivers");

/**
    @brief Switch driver data

    @trace #BRCM_SWARCH_ETHSWT_CMD_HANDLER_PROC

    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION
*/
ETHSWT_DrvRWDataType ETHSWT_DrvData COMP_SECTION(".bss.drivers");

/**
    @brief Read/Write time out

    @trace #BRCM_SWARCH_ETHSWT_DRV_READ_REG_PROC
    @trace #BRCM_SWARCH_ETHSWT_DRV_WRITE_REG_PROC
    @trace #BRCM_SWREQ_ETHSWT_KERNEL_INTERFACE
*/
#define ETHSWT_DRV_RDWR_TIMEOUT             (4UL * 8000UL)

/**
    @brief CPU indirect registers

    @trace #BRCM_SWARCH_ETHSWT_DRV_READ_REG_PROC
    @trace #BRCM_SWARCH_ETHSWT_DRV_WRITE_REG_PROC
    @trace #BRCM_SWREQ_ETHSWT_KERNEL_INTERFACE
*/
static CPU_INDIRECT_RDBType *const ETHSWT_CPUIndirectRegs =
                                        (CPU_INDIRECT_RDBType *)CPU_INDIRECT_BASE;

/** @brief Switch report error

    @trace #BRCM_SWARCH_ETHSWT_READ_REG_PROC
    @trace #BRCM_SWARCH_ETHSWT_WRITE_REG_PROC
    @trace #BRCM_SWARCH_ETHSWT_INIT_PROC
    @trace #BRCM_SWARCH_ETHSWT_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_KERNEL_INTERFACE
*/
void ETHSWT_DrvReportError(uint16_t aCompID, uint32_t aInstanceID, uint16_t aApiID,
        int32_t aErr, uint32_t aVal0, uint32_t aVal1,
        uint32_t aVal2, uint32_t aVal3)
{
    const uint32_t values[4] = {aVal0, aVal1, aVal2, aVal3};
    BCM_ReportError(aCompID, (uint8_t)aInstanceID, aApiID,
            aErr, 4UL, values);
}

/**
    @brief Switch driver Read register

    @trace #BRCM_SWARCH_ETHSWT_DRV_READ_REG_PROC
    @trace #BRCM_SWREQ_ETHSWT_KERNEL_INTERFACE
*/
int32_t ETHSWT_DrvReadReg(ETHSWT_HwIDType aSwtID,
        uint32_t aAddr,
        uint64_t *const aVal)
{
    uint16_t reg;
    uint32_t count = 0UL;
    int32_t ret = BCM_ERR_OK;

    if (0UL != aAddr) {

        /* write address to ADDR_L16 and ADDR_H16 registers */
        ETHSWT_CPUIndirectRegs->addr_cpu_l16 =
            (uint16_t)(aAddr & CPU_INDIRECT_RDB_IND_REGS_ADDR_L16_ADDRESS_L16_MASK);
        ETHSWT_CPUIndirectRegs->addr_cpu_h16 =
            (uint16_t)((aAddr >> 16UL) & CPU_INDIRECT_RDB_IND_REGS_ADDR_H16_ADDRESS_H16_MASK);

        /* set acesss width to 64-bit and commit a read */
        ETHSWT_CPUIndirectRegs->ctrl_cpu_l16 = CPU_INDIRECT_TRANS_SZ_QWORD
                            | CPU_INDIRECT_RDB_IND_REGS_CTRL_L16_COMMIT_MASK;

        /* wait for read to complete */
        do {
            reg = ETHSWT_CPUIndirectRegs->ctrl_cpu_l16;
            /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_SET_MGMT_MODE, ETHSWT_IT_CASE_FROCE_RD_REG_TMOUT_ERR, reg = 0U) */
            if ((reg & CPU_INDIRECT_RDB_IND_REGS_CTRL_L16_DONE_MASK) != 0U) {
                break;
            }
        } while ((count++ < ETHSWT_DRV_RDWR_TIMEOUT));

        if (count < ETHSWT_DRV_RDWR_TIMEOUT) {
            *aVal = ((uint64_t)ETHSWT_CPUIndirectRegs->data_cpu_l_l16 |
                    (uint64_t)ETHSWT_CPUIndirectRegs->data_cpu_l_h16 << 16U |
                    (uint64_t)ETHSWT_CPUIndirectRegs->data_cpu_h_l16 << 32U |
                    (uint64_t)ETHSWT_CPUIndirectRegs->data_cpu_h_h16 << 48U);
        } else {
            ret = BCM_ERR_TIME_OUT;
        }
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }

    if (BCM_ERR_OK != ret) {
        ETHSWT_DrvReportError(BCM_SWT_ID, aSwtID, BRCM_SWDSGN_ETHSWT_DRV_READ_REG_PROC, ret, aAddr, 0UL, 0UL, __LINE__);
    }

    return ret;
}

/**
    @brief Switch driver Read register

    @trace #BRCM_SWARCH_ETHSWT_DRV_WRITE_REG_PROC
    @trace #BRCM_SWREQ_ETHSWT_KERNEL_INTERFACE
*/
int32_t ETHSWT_DrvWriteReg(ETHSWT_HwIDType aSwtID,
        uint32_t aAddr,
        uint64_t aVal)
{
    uint16_t reg;
    uint32_t count = 0UL;
    int32_t ret = BCM_ERR_OK;

    if (0UL != aAddr) {

        /* write the value to data registers */
        ETHSWT_CPUIndirectRegs->data_cpu_l_l16 =
            (uint16_t)(aVal & CPU_INDIRECT_RDB_IND_REGS_DATA_L_L16_L16_MASK);
        ETHSWT_CPUIndirectRegs->data_cpu_l_h16 =
            (uint16_t)((aVal >> 16U) & CPU_INDIRECT_RDB_IND_REGS_DATA_L_H16_H16_MASK);
        ETHSWT_CPUIndirectRegs->data_cpu_h_l16 =
            (uint16_t)((aVal >> 32U) & CPU_INDIRECT_RDB_IND_REGS_DATA_H_L16_L16_MASK);
        ETHSWT_CPUIndirectRegs->data_cpu_h_h16 =
            (uint16_t)((aVal >> 48U) & CPU_INDIRECT_RDB_IND_REGS_DATA_H_H16_H16_MASK);

        /* write address to ADDR_L16 and ADDR_H16 registers */
        ETHSWT_CPUIndirectRegs->addr_cpu_l16 =
            (uint16_t)(aAddr & CPU_INDIRECT_RDB_IND_REGS_ADDR_L16_ADDRESS_L16_MASK);
        ETHSWT_CPUIndirectRegs->addr_cpu_h16 =
            (uint16_t)(aAddr >> 16UL) & CPU_INDIRECT_RDB_IND_REGS_ADDR_H16_ADDRESS_H16_MASK;

        /* set acesss width to 64-bit and commit a write */
        ETHSWT_CPUIndirectRegs->ctrl_cpu_l16 = (CPU_INDIRECT_TRANS_SZ_QWORD
                | (CPU_INDIRECT_CPU_WRITE << CPU_INDIRECT_CTRL_CPU_L16_RDB_WR_SHIFT)
                | CPU_INDIRECT_RDB_IND_REGS_CTRL_L16_COMMIT_MASK);

        /* wait for write to complete */
        do {
            reg = ETHSWT_CPUIndirectRegs->ctrl_cpu_l16;
            /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_SET_MGMT_MODE, ETHSWT_IT_CASE_FROCE_WR_REG_TMOUT_ERR, reg = 0U) */
            if ((reg & CPU_INDIRECT_RDB_IND_REGS_CTRL_L16_DONE_MASK) != 0U) {
                break;
            }
        } while ((count++ < ETHSWT_DRV_RDWR_TIMEOUT));

        if (count >= ETHSWT_DRV_RDWR_TIMEOUT) {
            ret = BCM_ERR_TIME_OUT;
        }
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }

    if (BCM_ERR_OK != ret) {
        ETHSWT_DrvReportError(BCM_SWT_ID, 0UL, BRCM_SWDSGN_ETHSWT_DRV_WRITE_REG_PROC, ret, aAddr,
            (uint32_t)((aVal >> 32U) & 0xFFFFFFFFUL), (uint32_t)(aVal & 0xFFFFFFFFUL), __LINE__);
    }

    return ret;
}

/**
    @brief Switch driver Read 32 bit register

    @trace #BRCM_SWARCH_ETHSWT_DRV_READ_REG_32_PROC
    @trace #BRCM_SWREQ_ETHSWT_KERNEL_INTERFACE
*/
int32_t ETHSWT_DrvReadReg32(ETHSWT_HwIDType aSwtID,
        uint32_t aAddr,
        uint32_t *const aVal)
{
    uint64_t reg = 0UL;
    int32_t ret;
    ret = ETHSWT_DrvReadReg(aSwtID, aAddr, &reg);
    *aVal = (uint32_t)reg;
    return ret;
}

/**
    @brief Switch driver Write 32 bit register

    @trace #BRCM_SWARCH_ETHSWT_DRV_WRITE_REG_32_PROC
    @trace #BRCM_SWREQ_ETHSWT_KERNEL_INTERFACE
*/
int32_t ETHSWT_DrvWriteReg32(ETHSWT_HwIDType aSwtID,
        uint32_t aAddr,
        uint32_t aVal)
{
    return ETHSWT_DrvWriteReg(aSwtID, aAddr, (uint64_t)aVal);
}


/**
    @brief Switch driver Read  16 bit register

    @trace #BRCM_SWARCH_ETHSWT_DRV_READ_REG_16_PROC
    @trace #BRCM_SWREQ_ETHSWT_KERNEL_INTERFACE
*/
int32_t ETHSWT_DrvReadReg16(ETHSWT_HwIDType aSwtID,
        uint32_t aAddr,
        uint16_t *const aVal)
{
    uint64_t reg = 0U;
    int32_t ret;
    ret = ETHSWT_DrvReadReg(aSwtID, aAddr, &reg);
    *aVal = (uint16_t)reg;
    return ret;
}

/**
    @brief Switch driver Write 16 bit register

    @trace #BRCM_SWARCH_ETHSWT_DRV_WRITE_REG_16_PROC
    @trace #BRCM_SWREQ_ETHSWT_KERNEL_INTERFACE
*/
int32_t ETHSWT_DrvWriteReg16(ETHSWT_HwIDType aSwtID,
        uint32_t aAddr,
        uint16_t aVal)
{
    return ETHSWT_DrvWriteReg(aSwtID, aAddr, (uint64_t)aVal);
}

/**
    @brief Switch driver Read 8 bit register

    @trace #BRCM_SWARCH_ETHSWT_DRV_READ_REG_8_PROC
    @trace #BRCM_SWREQ_ETHSWT_KERNEL_INTERFACE
*/
int32_t ETHSWT_DrvReadReg8(ETHSWT_HwIDType aSwtID,
        uint32_t aAddr,
        uint8_t *const aVal)
{
    uint64_t reg = 0U;
    int32_t ret;
    ret = ETHSWT_DrvReadReg(aSwtID, aAddr, &reg);
    *aVal = (uint8_t)reg;
    return ret;
}

/**
    @brief Switch driver Write 8 bit register

    @trace #BRCM_SWARCH_ETHSWT_DRV_WRITE_REG_8_PROC
    @trace #BRCM_SWREQ_ETHSWT_KERNEL_INTERFACE
*/
int32_t ETHSWT_DrvWriteReg8(ETHSWT_HwIDType aSwtID,
        uint32_t aAddr,
        uint8_t aVal)
{
    return ETHSWT_DrvWriteReg(aSwtID, aAddr, (uint64_t)aVal);
}


/**
    @brief Function to do switch port to timer hardware port mapping

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aPort               Port ID
    @param[inout]   aTimeHwPort         Pointer to time HW port

    @retval     #BCM_ERR_OK             On Success
    @retval     #BCM_ERR_INVAL_PARAMS   If aPort is invalid

    @post None

    @note   TimeHW0: ports - 0x00, 0x01, ..., 0x07
            TimeHW1: ports - 0x10, 0x11, ..., 0x17
            Switch port 0, 1, ..., 8 (excluding port 7)

    @trace #BRCM_SWARCH_ETHSWT_ENABLE_TX_TIMESTAMP_PROC
    @trace #BRCM_SWARCH_ETHSWT_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_MANAGEMENT
 */
#ifdef ENABLE_ETHSWT_TIME
static int32_t ETHSWT_DrvGetTimeHwPort(ETHSWT_PortIDType aPort,
                            uint32_t *const aTimeHwPort)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    if ((aPort <= 8UL) && (aPort != 7UL)) {
        *aTimeHwPort = ETHSWT_DrvData.port2TimeFifoMap[aPort];
        retVal = BCM_ERR_OK;
    }

    return retVal;
}
#endif

/**
    @brief Enable Tx timestamp

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aID             ID
    @param[in]      aBufIdx         Buffer Index
    @param[in]      aMgmtInfo       Pointer to management info

    Return values are documented in reverse-chronological order
    @return     Others          As returned by #ETHSWT_DrvGetTimeHwPort or
                                    by #ETHER_TimeSysCmdReq

    @post None

    @trace #BRCM_SWARCH_ETHSWT_ENABLE_TX_TIMESTAMP_PROC
    @trace #BRCM_SWREQ_ETHSWT_MANAGEMENT
 */
#ifdef ENABLE_ETHSWT_TIME
static int32_t ETHSWT_DrvEnableTxTS(ETHER_HwIDType aID,
                                uint32_t aBufIdx,
                                const ETHSWT_MgmtInfoType *const aMgmtInfo)
{
    int32_t retVal;
    uint32_t timeHwPort;
    ETHER_TimeIOType ethTimeIO;

    retVal = ETHSWT_DrvGetTimeHwPort(aMgmtInfo->portIdx, &timeHwPort);

    if (BCM_ERR_OK == retVal) {
        ethTimeIO.retVal = BCM_ERR_UNKNOWN;
        ethTimeIO.hwID = aID;
        ethTimeIO.buffIdxInOut = &aBufIdx;
        ethTimeIO.portIdx = timeHwPort;

        retVal = ETHER_TimeSysCmdReq(ETHER_TIMEIOCMD_ENABLE_EGRESS_TIMESTAMP,
                &ethTimeIO);
    }
    return retVal;
}

/**
    @brief Get Tx timestamp

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aID         Index
    @param[in]      aBufIdx     Buffer Index
    @param[inout]   aTS         Pointer to timestamp
    @param[inout]   aTSQual     Pointer to check if timestamp is valid
    @param[inout]   aMgmtInfo   Pointer to management info

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @return     Others                  As returned by #ETHSWT_DrvGetTimeHwPort or
                                        by #ETHER_TimeGetEgressTS

    @post None

    @trace #BRCM_SWARCH_ETHSWT_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_MANAGEMENT
*/
static int32_t ETHSWT_DrvGetTxTimestamp(ETHER_HwIDType aID,
                                uint32_t aBufIdx,
                                ETHER_TimestampType *const aTS,
                                ETHER_TimestampQualType *const aTSQual,
                                ETHSWT_MgmtInfoType *const aMgmtInfo)
{
    int32_t retVal;
    uint32_t timeHwPort;

    retVal = ETHSWT_DrvGetTimeHwPort(aMgmtInfo->portIdx, &timeHwPort);
    if (BCM_ERR_OK == retVal) {
        retVal = ETHER_TimeGetEgressTS(aID, timeHwPort, aBufIdx, aTS, aTSQual);
    }
    return retVal;
}

/**
    @brief Get Rx timestamp

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aID         Index
    @param[in]      aPktBuf     Pointer to packet buffer
    @param[inout]   aTS         Pointer to timestamp
    @param[inout]   aTSQual     Pointer to check if timestamp is valid
    @param[inout]   aMgmtInfo   Pointer to management info

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK     On Success
    @return     Others          As returned by #ETHSWT_DrvGetTimeHwPort or
                                by #ETHER_TimeGetIngressTS

    @post None

    @trace #BRCM_SWARCH_ETHSWT_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_MANAGEMENT
*/
static int32_t ETHSWT_DrvGetRxTimestamp(ETHER_HwIDType aID,
                                const uint8_t* const aPktBuf,
                                ETHER_TimestampType *const aTS,
                                ETHER_TimestampQualType *const aTSQual,
                                ETHSWT_MgmtInfoType *const aMgmtInfo)
{
    int32_t retVal;
    uint32_t timeHwPort;

    retVal = ETHSWT_DrvGetTimeHwPort(aMgmtInfo->portIdx, &timeHwPort);
    if (BCM_ERR_OK == retVal) {
        retVal = ETHER_TimeGetIngressTS(aID, timeHwPort, aPktBuf, aTS, aTSQual);
    }

    return retVal;
}

/** @brief Enable Tx timestamp

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  aSwtID      Switch Index
    @param[in]  aBufIdx     Buffer Index
    @param[in]  aMgmtInfo   Pointer to management information

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK                 On Success
    @retval     #BCM_ERR_INVAL_PARAMS       (Switch Index is invalid) or
                                            (Buffer index is invalid) or
                                            (aMgmtInfo is NULL)
    @retval     #BCM_ERR_INVAL_BUF_STATE    Buffer is in not in mgmt info set state
    @return     Others                      As retuned by ETHER_SysCmdReq

    @post None

    @trace #BRCM_SWARCH_ETHSWT_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_MANAGEMENT
*/
static int32_t ETHSWT_DrvEnableTxTimestamp(ETHER_HwIDType aSwtID,
                            uint32_t aBufIdx,
                            const ETHSWT_MgmtInfoType * const aMgmtInfo)
{
    int32_t ret = BCM_ERR_INVAL_PARAMS;
    ETHSWT_DrvBufInfoType *bufInfo;
    ETHER_IOType ethIO;

    if ((aSwtID < SWITCH_MAX_HW_ID)
        && (ETHSWT_DRV_TX_BUF_INFO_Q_SIZE > aBufIdx)
        && (NULL != aMgmtInfo)
        && (TRUE == ETHSWT_DrvData.enableTimeStamp[aMgmtInfo->portIdx])) {
        bufInfo = &ETHSWT_DrvTxBufInfoQ[aBufIdx];
        if (ETHSWT_DRV_BUF_STATE_MGMT_INFO_SET == bufInfo->bufState) {
            ethIO.retVal = BCM_ERR_UNKNOWN;
            ethIO.hwID = 0x0UL;
            ethIO.buffIdxInOut = &aBufIdx;

            ret = ETHER_SysCmdReq(ETHER_CNTLRIOCMD_TX_MARK_TS_PKT, &ethIO);
            if (BCM_ERR_OK == ret) {
                ret = ETHSWT_DrvEnableTxTS(ETHER_HW_ID_0, aBufIdx, aMgmtInfo);
            }
        } else {
            ret = BCM_ERR_INVAL_BUF_STATE;
        }
    }
    return ret;
}

/** @brief Set timestamp enabled

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  aSwtID      Switch Index
    @param[in]  aBufIdx     Buffer Index

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @retval     #BCM_ERR_INVAL_PARAMS   (Switch Index is invalid) or
                                        (Buffer Index is invalid)

    @post None

    @trace #BRCM_SWARCH_ETHSWT_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_MANAGEMENT
*/
static int32_t ETHSWT_DrvSetTSEnabled(ETHER_HwIDType aSwtID,
                            uint32_t aBufIdx)
{
    int32_t ret;
    if ((aSwtID < SWITCH_MAX_HW_ID)
            && (ETHSWT_DRV_TX_BUF_INFO_Q_SIZE > aBufIdx)) {
        ETHSWT_DrvTxBufInfoQ[aBufIdx].isTSEnabled = TRUE;
        ret = BCM_ERR_OK;
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }
    return ret;
}

/**
    @brief Enable Tx timestamp

    @trace #BRCM_SWARCH_ETHSWT_ENABLE_TX_TIMESTAMP_PROC
    @trace #BRCM_SWREQ_ETHSWT_MANAGEMENT
*/
int32_t ETHSWT_EnableTxTimestamp(ETHER_HwIDType aCntrlID,
                            uint32_t aBufIdx,
                            ETHSWT_MgmtInfoType * const aMgmtInfo)
{
    ETHSWT_IOType swtIO;
    int32_t ret;

    if (ETHSWT_DrvData.state == ETHSWT_STATE_UNINIT) {
        ret = BCM_ERR_UNINIT;
    } else {
        ret = ETHSWT_DrvEnableTxTimestamp(aCntrlID, aBufIdx, aMgmtInfo);
        if (BCM_ERR_OK == ret) {
            swtIO.retVal = BCM_ERR_UNKNOWN;
            swtIO.ctrlHwID = aCntrlID;
            swtIO.bufIdx = aBufIdx;

            ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_ENABLE_TX_TIMESTAMP, &swtIO);
        }
    }

    return ret;
}
#endif

/** @brief Get switch management mode

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aSwtID  Switch Index
    @param[inout]   aMode   Pointer to read mode into it

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @retval     #BCM_ERR_INVAL_PARAMS   aSwtID is invalid or aMode is NULL

    @post None

    @trace #BRCM_SWARCH_ETHSWT_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION
*/
static int32_t ETHSWT_DrvGetMgmtMode(ETHSWT_HwIDType aSwtID,
                                     ETHSWT_MgmtModeType *const aMode)
{
    uint32_t line = 0UL;
    int32_t ret = BCM_ERR_INVAL_PARAMS;
    uint8_t reg;

    /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_DUMB_FWD_MODE, ETHSWT_IT_CASE_FROCE_HWID_ERR, aSwtID = SWITCH_MAX_HW_ID) */
    if (aSwtID < SWITCH_MAX_HW_ID) {
        ret = ETHSWT_DrvReadReg8(aSwtID, (uint32_t)&ETHSWT_Regs->m00_swmode, &reg);
        /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_DUMB_FWD_MODE, ETHSWT_IT_CASE_FROCE_RD_ERR_1, ret = BCM_ERR_UNKNOWN) */
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
        /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_DUMB_FWD_MODE, ETHSWT_IT_CASE_FROCE_MGMTMODE_EN, reg |= SWITCH_PAGE_00_SWMODE_SW_FWDG_MODE_MASK) */
        if (SWITCH_PAGE_00_SWMODE_SW_FWDG_MODE_MASK == (reg & SWITCH_PAGE_00_SWMODE_SW_FWDG_MODE_MASK)) {
            *aMode = ETHSWT_MGMTMODE_ENABLE;
        } else {
            *aMode = ETHSWT_MGMTMODE_DISABLE;
        }
    }
err_exit:
    ETHSWT_REPORT_ERR(ret, aSwtID, line,
        BRCM_SWDSGN_ETHSWT_DRV_GET_MGMT_MODE_PROC, 0UL, 0UL, 0UL)
    return ret;
}

/**
    @trace #BRCM_SWARCH_ETHSWT_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION
*/
int32_t ETHSWT_DrvSetBrcmHdrMode(ETHSWT_HwIDType aSwtID,
        ETHSWT_BrcmHdrModeType aMode)
{
    uint32_t line = __LINE__;
    int32_t ret = BCM_ERR_INVAL_PARAMS;
    uint8_t reg;

    if ((aSwtID < SWITCH_MAX_HW_ID)
            && ((ETHSWT_BRCMHDR_ENABLE == aMode)
                || (ETHSWT_BRCMHDR_DISABLE == aMode))) {

        ret = ETHSWT_DrvReadReg8(aSwtID, (uint32_t)&ETHSWT_Regs->m02_brcm_hdr_ctrl, &reg);
        /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_BRCM_HDR_MODE, ETHSWT_IT_CASE_FROCE_RD_ERR_1, ret = BCM_ERR_UNKNOWN) */
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
        if (ETHSWT_BRCMHDR_ENABLE == aMode) {
            reg |= SWITCH_BRCM_HDR_CTRL_P8_EN_MASK;
        } else {
            reg &= (uint8_t)~SWITCH_BRCM_HDR_CTRL_P8_EN_MASK;
        }
        ret = ETHSWT_DrvWriteReg8(aSwtID, (uint32_t)&ETHSWT_Regs->m02_brcm_hdr_ctrl, reg);
        /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_BRCM_HDR_MODE, ETHSWT_IT_CASE_FROCE_WR_ERR_1, ret = BCM_ERR_UNKNOWN) */
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
    }
err_exit:
    ETHSWT_REPORT_ERR(ret, aSwtID, line,
        BRCM_SWDSGN_ETHSWT_DRV_SET_BRCM_HDR_MODE_PROC, 0UL, 0UL, 0UL)
    return ret;
}

/** @brief Set dumb forward mode

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  aSwtID  Switch Index
    @param[in]  aMode   Mode

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success

    @post None

    @trace #BRCM_SWARCH_ETHSWT_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION
*/
static int32_t ETHSWT_DrvSetDumbFwdMode(ETHSWT_HwIDType aSwtID,
        ETHSWT_DumbFwdModeType aMode)
{
    uint32_t line = __LINE__;
    int32_t ret = BCM_ERR_INVAL_PARAMS;
    uint16_t reg;

    if ((aSwtID < SWITCH_MAX_HW_ID)
            && ((ETHSWT_DUMBFWD_ENABLE == aMode)
                || (ETHSWT_DUMBFWD_DISABLE == aMode))) {

        ret = ETHSWT_DrvReadReg16(aSwtID, (uint32_t)&ETHSWT_Regs->m00_switch_ctrl, &reg);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
        if (ETHSWT_DUMBFWD_ENABLE == aMode) {
            /* Standard Port: Enable dumb forward mode */
            reg |= SWITCH_P00SC_PAGE_00_CTRL_MII_DUMB_FWDG_EN_MASK;
        } else {
            /* Host Port: Disable dumb forward mode */
            reg &= (uint16_t)~SWITCH_P00SC_PAGE_00_CTRL_MII_DUMB_FWDG_EN_MASK;
        }
        ret = ETHSWT_DrvWriteReg16(aSwtID, (uint32_t)&ETHSWT_Regs->m00_switch_ctrl, reg);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
    }
err_exit:
    ETHSWT_REPORT_ERR(ret, aSwtID, line,
        BRCM_SWDSGN_ETHSWT_DRV_SET_DUMB_FWD_MODE_PROC, 0UL, 0UL, 0UL)
    return ret;
}

/** @brief Set management mode

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  aSwtID  Switch Index
    @param[in]  aMode   Mode

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @retval     #BCM_ERR_INVAL_PARAMS   aSwtID or aMode is invalid

    @post None

    @trace #BRCM_SWARCH_ETHSWT_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION
*/
static int32_t ETHSWT_DrvSetMgmtMode(ETHSWT_HwIDType aSwtID,
        ETHSWT_MgmtModeType aMode)
{
    uint32_t line = __LINE__;
    int32_t ret = BCM_ERR_INVAL_PARAMS;
    uint8_t reg;

    /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_SET_MGMT_MODE, ETHSWT_IT_CASE_INVAL_HW_ID, aSwtID = SWITCH_MAX_HW_ID) */
    if ((aSwtID < SWITCH_MAX_HW_ID)
            && ((ETHSWT_MGMTMODE_ENABLE == aMode)
                || (ETHSWT_MGMTMODE_DISABLE == aMode))) {

        if (aMode == ETHSWT_MGMTMODE_ENABLE) {
            /* Host Port: Disable dumb forward mode */
            ret = ETHSWT_DrvSetDumbFwdMode(aSwtID, ETHSWT_DUMBFWD_DISABLE);
            ETHSWT_CHECK_ERR(ret, &line, err_exit);

            ret = ETHSWT_DrvReadReg8(aSwtID, (uint32_t)&ETHSWT_Regs->m00_swmode, &reg);
            /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_SET_MGMT_MODE, ETHSWT_IT_CASE_FROCE_RD_ERR_1, ret = BCM_ERR_UNKNOWN) */
            ETHSWT_CHECK_ERR(ret, &line, err_exit)
            reg |= SWITCH_PAGE_00_SWMODE_SW_FWDG_MODE_MASK;
            ret = ETHSWT_DrvWriteReg8(aSwtID, (uint32_t)&ETHSWT_Regs->m00_swmode, reg);
            /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_SET_MGMT_MODE, ETHSWT_IT_CASE_FROCE_WR_ERR_1, ret = BCM_ERR_UNKNOWN) */
            ETHSWT_CHECK_ERR(ret, &line, err_exit)

            /* Enable IMP0 functionality */
            ret = ETHSWT_DrvReadReg8(aSwtID, (uint32_t)&ETHSWT_Regs->m02_gmngcfg, &reg);
            /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_SET_MGMT_MODE, ETHSWT_IT_CASE_FROCE_RD_ERR_2, ret = BCM_ERR_UNKNOWN) */
            ETHSWT_CHECK_ERR(ret, &line, err_exit)
            reg |= (SWITCH_ENABLE_IMP0 << SWITCH_PAGE_02_GMNGCFG_FRM_MNGP_SHIFT);
            ret = ETHSWT_DrvWriteReg8(aSwtID, (uint32_t)&ETHSWT_Regs->m02_gmngcfg, reg);
            /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_SET_MGMT_MODE, ETHSWT_IT_CASE_FROCE_WR_ERR_2, ret = BCM_ERR_UNKNOWN) */
            ETHSWT_CHECK_ERR(ret, &line, err_exit)

            /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_SET_MGMT_MODE, ETHSWT_IT_CASE_FROCE_SET_HDR_MODE_ERR, aSwtID = SWITCH_MAX_HW_ID) */
            ret = ETHSWT_DrvSetBrcmHdrMode(aSwtID, ETHSWT_BRCMHDR_ENABLE);
            ETHSWT_CHECK_ERR(ret, &line, err_exit)

        } else {
            /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_SET_MGMT_MODE, ETHSWT_IT_CASE_FROCE_SWT_TYP_ERR, ITSwitchTyp = ETHSWT_DrvData.switchType; ETHSWT_DrvData.switchType = ETHSWT_SWITCH_LIGHTSTACK_SLAVE) */
            if (ETHSWT_DrvData.switchType == ETHSWT_SWITCH_STANDARD) {
                /* Clear IMP functionality */
                ret = ETHSWT_DrvReadReg8(aSwtID, (uint32_t)&ETHSWT_Regs->m02_gmngcfg, &reg);
                /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_SET_MGMT_MODE, ETHSWT_IT_CASE_FROCE_RD_ERR_1, ret = BCM_ERR_UNKNOWN) */
                ETHSWT_CHECK_ERR(ret, &line, err_exit)
                reg &= (uint8_t)~SWITCH_PAGE_02_GMNGCFG_FRM_MNGP_MASK;
                ret = ETHSWT_DrvWriteReg8(aSwtID, (uint32_t)&ETHSWT_Regs->m02_gmngcfg, reg);
                /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_SET_MGMT_MODE, ETHSWT_IT_CASE_FROCE_WR_ERR_1, ret = BCM_ERR_UNKNOWN) */
                ETHSWT_CHECK_ERR(ret, &line, err_exit)

                ret = ETHSWT_DrvReadReg8(aSwtID, (uint32_t)&ETHSWT_Regs->m00_swmode, &reg);
                /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_SET_MGMT_MODE, ETHSWT_IT_CASE_FROCE_RD_ERR_2, ret = BCM_ERR_UNKNOWN) */
                ETHSWT_CHECK_ERR(ret, &line, err_exit)
                reg &= (uint8_t)~SWITCH_PAGE_00_SWMODE_SW_FWDG_MODE_MASK;
                ret = ETHSWT_DrvWriteReg8(aSwtID, (uint32_t)&ETHSWT_Regs->m00_swmode, reg);
                /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_SET_MGMT_MODE, ETHSWT_IT_CASE_FROCE_WR_ERR_2, ret = BCM_ERR_UNKNOWN) */
                ETHSWT_CHECK_ERR(ret, &line, err_exit)

                /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_SET_MGMT_MODE, ETHSWT_IT_CASE_FROCE_SET_HDR_MODE_ERR, aSwtID = SWITCH_MAX_HW_ID) */
                ret = ETHSWT_DrvSetBrcmHdrMode(aSwtID, ETHSWT_BRCMHDR_DISABLE);
                ETHSWT_CHECK_ERR(ret, &line, err_exit)

                /* Standard Port: Enable dumb forward mode */
                ret = ETHSWT_DrvSetDumbFwdMode(aSwtID, ETHSWT_DUMBFWD_ENABLE);
                ETHSWT_CHECK_ERR(ret, &line, err_exit);
            } else {
                /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_SET_MGMT_MODE, ETHSWT_IT_CASE_FROCE_SWT_TYP_ERR, ETHSWT_DrvData.switchType = ITSwitchTyp) */
                ret = BCM_ERR_NOPERM;
            }
        }
    }
err_exit:
    ETHSWT_REPORT_ERR(ret, aSwtID, line,
        BRCM_SWDSGN_ETHSWT_DRV_SET_MGMT_MODE_PROC, 0UL, 0UL, 0UL)
    return ret;
}


/**
    @trace #BRCM_SWARCH_ETHSWT_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION
 */
int32_t ETHSWT_DrvSetPortRole(ETHSWT_HwIDType aSwtID,
                                    ETHSWT_SwitchType aSwtType,
                                    ETHSWT_PortIDType aPortID,
                                    ETHSWT_PortType aRole)
{
    uint32_t line = __LINE__;
    int ret = BCM_ERR_OK;
    uint8_t reg;


    if (ETHSWT_SWITCH_STANDARD == aSwtType) {
        if (SWITCH_LIGHTSTACK_HOST_PORT == aPortID) {

            switch (aRole) {
                case ETHSWT_PORT_STANDARD:
                    /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_SET_PORT_ROLE, ETHSWT_IT_CASE_FROCE_SET_MGMT_ERR, aSwtID = SWITCH_MAX_HW_ID) */
                    ret = ETHSWT_DrvSetMgmtMode(aSwtID, ETHSWT_MGMTMODE_DISABLE);
                    ETHSWT_CHECK_ERR(ret, &line, err_exit)
                    break;
                case ETHSWT_PORT_HOST:
                    /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_SET_PORT_ROLE, ETHSWT_IT_CASE_FROCE_SET_MGMT_ERR, aSwtID = SWITCH_MAX_HW_ID) */
                    ret = ETHSWT_DrvSetMgmtMode(aSwtID, ETHSWT_MGMTMODE_ENABLE);
                    ETHSWT_CHECK_ERR(ret, &line, err_exit)

                    /* Enable forwarding of broadcast packets to IMP */
                    ret = ETHSWT_DrvReadReg8(aSwtID, (uint32_t)&ETHSWT_Regs->m00_imp_ctl, &reg);
                    /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_SET_PORT_ROLE, ETHSWT_IT_CASE_FROCE_RD_ERR_1, ret = BCM_ERR_UNKNOWN) */
                    ETHSWT_CHECK_ERR(ret, &line, err_exit)
                    reg |= SWITCH_PAGE_00_IMP_CTL_RX_BCST_EN_MASK;
                    ret = ETHSWT_DrvWriteReg8(aSwtID, (uint32_t)&ETHSWT_Regs->m00_imp_ctl, reg);
                    /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_SET_PORT_ROLE, ETHSWT_IT_CASE_FROCE_WR_ERR_1, ret = BCM_ERR_UNKNOWN) */
                    ETHSWT_CHECK_ERR(ret, &line, err_exit)
                    break;
                default:
                    ret = BCM_ERR_INVAL_PARAMS;
                    break;
            }
        } else {
            if (ETHSWT_PORT_STANDARD != aRole) {
                ret = BCM_ERR_INVAL_PARAMS;
            }
        }
    } else if (ETHSWT_SWITCH_LIGHTSTACK_MASTER == aSwtType) {
        if (SWITCH_LIGHTSTACK_HOST_PORT == aPortID) {
            switch (aRole) {
                case ETHSWT_PORT_HOST:
                    /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_SET_PORT_ROLE, ETHSWT_IT_CASE_FROCE_SET_MGMT_ERR, aSwtID = SWITCH_MAX_HW_ID) */
                    ret = ETHSWT_DrvSetMgmtMode(aSwtID, ETHSWT_MGMTMODE_ENABLE);
                    ETHSWT_CHECK_ERR(ret, &line, err_exit)

                    /* Enable forwarding of broadcast packets to IMP */
                    ret = ETHSWT_DrvReadReg8(aSwtID, (uint32_t)&ETHSWT_Regs->m00_imp_ctl, &reg);
                    /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_SET_PORT_ROLE, ETHSWT_IT_CASE_FROCE_RD_ERR_1, ret = BCM_ERR_UNKNOWN) */
                    ETHSWT_CHECK_ERR(ret, &line, err_exit)
                    reg |= SWITCH_PAGE_00_IMP_CTL_RX_BCST_EN_MASK;
                    ret = ETHSWT_DrvWriteReg8(aSwtID, (uint32_t)&ETHSWT_Regs->m00_imp_ctl, reg);
                    /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_SET_PORT_ROLE, ETHSWT_IT_CASE_FROCE_WR_ERR_1, ret = BCM_ERR_UNKNOWN) */
                    ETHSWT_CHECK_ERR(ret, &line, err_exit)
                    break;
                default:
                    ret = BCM_ERR_INVAL_PARAMS;
                    break;
            }
        } else if (6UL == aPortID) {
            if (ETHSWT_PORT_HOST == aRole) {
                ret = BCM_ERR_INVAL_PARAMS;
            }
        } else if (5UL == aPortID) {
            if (ETHSWT_PORT_HOST == aRole) {
                ret = BCM_ERR_INVAL_PARAMS;
            }
        } else {
            if (ETHSWT_PORT_STANDARD != aRole) {
                ret = BCM_ERR_INVAL_PARAMS;
            }
        }
    } else if (ETHSWT_SWITCH_LIGHTSTACK_SLAVE == aSwtType) {
        if (SWITCH_LIGHTSTACK_HOST_PORT == aPortID) {
            if (ETHSWT_PORT_UP_LINK == aRole) {
                /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_SET_PORT_ROLE, ETHSWT_IT_CASE_FROCE_SET_MGMT_ERR, aSwtID = SWITCH_MAX_HW_ID) */
                ret = ETHSWT_DrvSetMgmtMode(aSwtID, ETHSWT_MGMTMODE_ENABLE);
                ETHSWT_CHECK_ERR(ret, &line, err_exit)
                /* Enable forwarding of DLF traffic on the stacking link*/
                ret = ETHSWT_DrvReadReg8(aSwtID, (uint32_t)&ETHSWT_Regs->m00_imp_ctl, &reg);
                /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_SET_PORT_ROLE, ETHSWT_IT_CASE_FROCE_RD_ERR_1, ret = BCM_ERR_UNKNOWN) */
                ETHSWT_CHECK_ERR(ret, &line, err_exit)
                reg |= (SWITCH_PAGE_00_IMP_CTL_RX_UCST_EN_MASK |
                        SWITCH_PAGE_00_IMP_CTL_RX_MCST_EN_MASK |
                        SWITCH_PAGE_00_IMP_CTL_RX_BCST_EN_MASK);
                ret = ETHSWT_DrvWriteReg8(aSwtID, (uint32_t)&ETHSWT_Regs->m00_imp_ctl, reg);
                /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_SET_PORT_ROLE, ETHSWT_IT_CASE_FROCE_WR_ERR_1, ret = BCM_ERR_UNKNOWN) */
                ETHSWT_CHECK_ERR(ret, &line, err_exit)
            } else {
                ret = BCM_ERR_INVAL_PARAMS;
            }
        } else if (6UL == aPortID) {
            if (ETHSWT_PORT_HOST == aRole) {
                ret = BCM_ERR_INVAL_PARAMS;
            }
        } else if (5UL == aPortID) {
            if (ETHSWT_PORT_HOST == aRole) {
                ret = BCM_ERR_INVAL_PARAMS;
            }
        } else {
            if (ETHSWT_PORT_STANDARD != aRole) {
                ret = BCM_ERR_INVAL_PARAMS;
            }
        }
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }

err_exit:
    ETHSWT_REPORT_ERR(ret, aSwtID, line,
        BRCM_SWDSGN_ETHSWT_DRV_SET_PORT_ROLE_PROC, 0UL, 0UL, 0UL)
    return ret;
}

/**
    @trace #BRCM_SWARCH_ETHSWT_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION
 */
int32_t ETHSWT_DrvSetSwitchType(ETHSWT_HwIDType aSwtID,
                                       ETHSWT_SwitchType aSwitchType,
                                       uint32_t aUplinkPortCnt,
                                       uint32_t *const aUplinkPortMap)
{
    uint32_t line = __LINE__;
    int32_t ret = BCM_ERR_OK;
    uint32_t reg;

    if ((ETHSWT_SWITCH_LIGHTSTACK_MASTER == aSwitchType)
            || (ETHSWT_SWITCH_LIGHTSTACK_SLAVE == aSwitchType)) {
        /* Enable light stacking support */
        ret = ETHSWT_DrvReadReg32(aSwtID, (uint32_t)&ETHSWT_Regs->m00_lightstack_ctrl, &reg);
        /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_SET_SWT_TYPE, ETHSWT_IT_CASE_FROCE_RD_ERR_1, ret = BCM_ERR_UNKNOWN) */
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
        if (ETHSWT_SWITCH_LIGHTSTACK_MASTER == aSwitchType) {
            /* Enable light stack master */
            reg |= SWITCH_P00LC_PAGE_00_LIGHTSTACK_CTRL_LIGHTSTACK_MASTER_MASK;
            /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_SET_SWT_TYPE, ETHSWT_IT_CASE_FROCE_PORT_CNT_0, aUplinkPortCnt = 0UL) */
                /* Configure light stack port 0 */
                reg &= ~SWITCH_P00LC_PAGE_00_LIGHTSTACK_CTRL_LIGHTSTACK_PORT0_MASK;
                reg |= ((aUplinkPortMap[0UL]
                            << SWITCH_P00LC_PAGE_00_LIGHTSTACK_CTRL_LIGHTSTACK_PORT0_SHIFT)
                        & SWITCH_P00LC_PAGE_00_LIGHTSTACK_CTRL_LIGHTSTACK_PORT0_MASK);
                /* clear Port 1 */
                reg &= ~SWITCH_P00LC_PAGE_00_LIGHTSTACK_CTRL_LIGHTSTACK_PORT1_EN_MASK;
                if (aUplinkPortCnt == 2UL) {
                    /* Configure light stack port 1 */
                    reg &= ~SWITCH_P00LC_PAGE_00_LIGHTSTACK_CTRL_LIGHTSTACK_PORT1_MASK;
                    reg |= ((aUplinkPortMap[1UL]
                                << SWITCH_P00LC_PAGE_00_LIGHTSTACK_CTRL_LIGHTSTACK_PORT1_SHIFT)
                            & SWITCH_P00LC_PAGE_00_LIGHTSTACK_CTRL_LIGHTSTACK_PORT1_MASK);
                    reg |= SWITCH_P00LC_PAGE_00_LIGHTSTACK_CTRL_LIGHTSTACK_PORT1_EN_MASK;
                }
        } else {
            /* Configure light stack slave */
            reg &= ~SWITCH_P00LC_PAGE_00_LIGHTSTACK_CTRL_LIGHTSTACK_MASTER_MASK;
                /* Configure light stack port 1 */
                reg &= ~SWITCH_P00LC_PAGE_00_LIGHTSTACK_CTRL_LIGHTSTACK_PORT1_MASK;
                reg |= ((aUplinkPortMap[0UL]
                            << SWITCH_P00LC_PAGE_00_LIGHTSTACK_CTRL_LIGHTSTACK_PORT1_SHIFT)
                        & SWITCH_P00LC_PAGE_00_LIGHTSTACK_CTRL_LIGHTSTACK_PORT1_MASK);
        }

        reg |= SWITCH_P00LC_PAGE_00_LIGHTSTACK_CTRL_LIGHTSTACK_EN_MASK;
        ret = ETHSWT_DrvWriteReg32(aSwtID, (uint32_t)&ETHSWT_Regs->m00_lightstack_ctrl, reg);
        /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_SET_SWT_TYPE, ETHSWT_IT_CASE_FROCE_WR_ERR_1, ret = BCM_ERR_UNKNOWN) */
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
#if defined(__BCM8956X__) || defined(__BCM8957X__)
        {
            /* To enable timestamping on stacking link (presence of egress Broadcom header) */
            P1588_RDBType * const ETHER_P1588REGS = (P1588_RDBType *const)P1588_0_BASE;
            ETHER_P1588REGS->mpls_label9_lsb_value = 0xC0C0U;
        }
#endif

    } else if (ETHSWT_SWITCH_STANDARD != aSwitchType) {
            ret = BCM_ERR_INVAL_PARAMS;
    } else {
        /* Handling default else case and keeping ret as BCM_ERR_OK*/
    }

    if (BCM_ERR_OK == ret) {
        ETHSWT_DrvData.switchType = aSwitchType;
    }
err_exit:
    ETHSWT_REPORT_ERR(ret, aSwtID, line,
        BRCM_SWDSGN_ETHSWT_DRV_SET_SWITCH_TYPE_PROC, 0UL, 0UL, 0UL)
    return ret;
}


/**
    @brief VLAN configuration

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aID             Index

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @return     Others                  As returned by #ETHSWT_DrvReadReg and #ETHSWT_DrvWriteReg

    @post None

    @trace #BRCM_SWARCH_ETHSWT_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION
 */
static int32_t ETHSWT_DrvVLANConfig(ETHSWT_HwIDType aID)
{
    uint32_t line;
    int32_t ret;
    uint8_t reg;

    /* Drop packets with VLAN voilation for all the ports. */
    ret = ETHSWT_DrvReadReg8(aID, (uint32_t)&ETHSWT_Regs->m34_vlan_ctrl4, &reg);
    /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_INIT, ETHSWT_IT_CASE_FROCE_RD_ERR_3, ret = BCM_ERR_UNKNOWN) */
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    reg &= (uint8_t)~SWITCH_P34VC4_PAGE_34_VLAN_CTRL4_INGR_VID_CHK_MASK ;
    reg |= (uint8_t)(SWITCH_VLAN_CTRL4_INGR_VID_CHK_VID_VIO
            << SWITCH_P34VC4_PAGE_34_VLAN_CTRL4_INGR_VID_CHK_SHIFT);
    ret = ETHSWT_DrvWriteReg8(aID, (uint32_t)&ETHSWT_Regs->m34_vlan_ctrl4, reg);
    /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_INIT, ETHSWT_IT_CASE_FROCE_WR_ERR_6, ret = BCM_ERR_UNKNOWN) */
    ETHSWT_CHECK_ERR(ret, &line, err_exit)

    /* enable SVL mode and 802.1Q VLAN */
    ret = ETHSWT_DrvReadReg8(aID, (uint32_t)&ETHSWT_Regs->m34_vlan_ctrl0, &reg);
    /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_INIT, ETHSWT_IT_CASE_FROCE_RD_ERR_4, ret = BCM_ERR_UNKNOWN) */
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    reg |= SWITCH_P34VC0_PAGE_34_VLAN_CTRL0_VLAN_EN_MASK;
    reg &= (uint8_t)~(SWITCH_P34VC0_PAGE_34_VLAN_CTRL0_VLAN_LEARN_MODE_MASK);
    reg |= (uint8_t)SWITCH_VLAN_LEARN_MODE_IVL
            << SWITCH_P34VC0_PAGE_34_VLAN_CTRL0_VLAN_LEARN_MODE_SHIFT;
    /* TODO: Check if it is required to change inner VID and outer VID in case
     * of double tagged packets
     */
    ret = ETHSWT_DrvWriteReg8(aID, (uint32_t)&ETHSWT_Regs->m34_vlan_ctrl0, reg);
    /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_INIT, ETHSWT_IT_CASE_FROCE_WR_ERR_7, ret = BCM_ERR_UNKNOWN) */
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
err_exit:
    ETHSWT_REPORT_ERR(ret, aID, line,
        BRCM_SWDSGN_ETHSWT_DRV_VLAN_CONFIG_PROC, 0UL, 0UL, 0UL)
    return ret;
}


/**
    @brief CPU port configuration

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aID             ID

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success

    @post None

    @trace #BRCM_SWARCH_ETHSWT_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION
 */
static int32_t ETHSWT_DrvCPUPortConfig(ETHSWT_HwIDType aID)
{
    uint32_t line;
    uint8_t reg;
    int32_t  ret = BCM_ERR_OK;

    /* enable BRCM TAG on Port 7 (CPU port) */
    ret = ETHSWT_DrvReadReg8(aID, (uint32_t)&ETHSWT_Regs->m02_brcm_hdr_ctrl, &reg);
    /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_INIT, ETHSWT_IT_CASE_FROCE_RD_ERR_2, ret = BCM_ERR_UNKNOWN) */
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    reg |= SWITCH_BRCM_HDR_CTRL_P7_EN_MASK;
    ret = ETHSWT_DrvWriteReg8(aID, (uint32_t)&ETHSWT_Regs->m02_brcm_hdr_ctrl, reg);
    /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_INIT, ETHSWT_IT_CASE_FROCE_WR_ERR_3, ret = BCM_ERR_UNKNOWN) */
    ETHSWT_CHECK_ERR(ret, &line, err_exit)

    /* Configure the TC2COS mapping */
    /* TC 0 - COS 0 */
    /* TC 1 - COS 1 */
    /* TC 2 - COS 2 */
    /* TC 3 - COS 3 */
    /* TC 4 - COS 4 */
    /* TC 5 - COS 5 */
    /* TC 6 - COS 6 */
    /* TC 7 - COS 7 */
    ret = ETHSWT_DrvWriteReg32(aID, (uint32_t)&ETHSWT_Regs->m30_p7_tc2cos_map, SWITCH_TC2COS_MAP_PORT7_VAL);
    /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_INIT, ETHSWT_IT_CASE_FROCE_WR_ERR_4, ret = BCM_ERR_UNKNOWN) */
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    /* Enable the port */
    ret = ETHSWT_DrvWriteReg8(aID, (uint32_t)&ETHSWT_Regs->m00_p7_ctl, 0U);
    /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_INIT, ETHSWT_IT_CASE_FROCE_WR_ERR_5, ret = BCM_ERR_UNKNOWN) */
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
err_exit:
    ETHSWT_REPORT_ERR(ret, aID, line,
        BRCM_SWDSGN_ETHSWT_DRV_CPU_PORT_CONFIG_PROC, 0UL, 0UL, 0UL)
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
    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION
*/
static int ETHSWT_DrvInit(ETHSWT_HwIDType aID,
        uint32_t *const aPort2TimeFifoMap)
{
    uint32_t line;
    uint8_t reg8;
    uint16_t reg16;
    int32_t ret = BCM_ERR_OK;

    /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_INIT, ETHSWT_IT_CASE_FROCE_HWID_ERR, aID = SWITCH_MAX_HW_ID) */
    if ((aID >= SWITCH_MAX_HW_ID)
#ifdef ENABLE_ETHSWT_TIME
            || (NULL == aPort2TimeFifoMap)
#endif
            ) {
        ret = BCM_ERR_INVAL_PARAMS;
        line = __LINE__;
        goto err_exit;
    }

    /* Disable Link status interrupt for all the ports */
    ret = ETHSWT_DrvWriteReg16(aID, (uint32_t)&ETHSWT_Regs->m03_link_sts_int_en, 0x0U);
    /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_INIT, ETHSWT_IT_CASE_FROCE_WR_ERR_1, ret = BCM_ERR_UNKNOWN) */
    ETHSWT_CHECK_ERR(ret, &line, err_exit)

    ret = ETHSWT_DrvCPUPortConfig(aID);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)

    ret = ETHSWT_DrvVLANConfig(aID);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)

    ret = ETHSWT_DrvReadReg8(aID, (uint32_t)&ETHSWT_Regs->m00_swmode, &reg8);
    /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_INIT, ETHSWT_IT_CASE_FROCE_RD_ERR_1, ret = BCM_ERR_UNKNOWN) */
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    /* Enable forwarding */
    reg8 |= SWITCH_PAGE_00_SWMODE_SW_FWDG_EN_MASK;
    ret = ETHSWT_DrvWriteReg8(aID, (uint32_t)&ETHSWT_Regs->m00_swmode, reg8);
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    ETHSWT_DrvData.mirrorPortID = ETHSWT_PORT_ID_MAX;
    ETHSWT_DrvData.port2TimeFifoMap[0UL] = 0x00UL;
    ETHSWT_DrvData.port2TimeFifoMap[1UL] = 0x01UL;
    ETHSWT_DrvData.port2TimeFifoMap[2UL] = 0x02UL;
    ETHSWT_DrvData.port2TimeFifoMap[3UL] = 0x03UL;
    ETHSWT_DrvData.port2TimeFifoMap[4UL] = 0x04UL;
    ETHSWT_DrvData.port2TimeFifoMap[5UL] = 0x14UL;
    ETHSWT_DrvData.port2TimeFifoMap[6UL] = 0x13UL;
    ETHSWT_DrvData.port2TimeFifoMap[7UL] = 0xFFUL;
    ETHSWT_DrvData.port2TimeFifoMap[8UL] = 0x12UL;
#ifdef ENABLE_ETHSWT_TIME
    BCM_MemCpy(ETHSWT_DrvData.port2TimeFifoMap, aPort2TimeFifoMap,
            sizeof(uint32_t) * ETHSWT_PORT_ID_MAX);
#endif

    /* Configure standard max frame size equal to 1518 */
    reg16 = SWITCH_JUMBO_MIB_GD_FM_MAX_SIZE;
    ret = ETHSWT_DrvWriteReg16(aID, (uint32_t)&ETHSWT_Regs->m40_mib_gd_fm_max_size, reg16);
    /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_INIT, ETHSWT_IT_CASE_FROCE_WR_ERR_2, ret = BCM_ERR_UNKNOWN) */
    ETHSWT_CHECK_ERR(ret, &line, err_exit)
    ETHSWT_DrvData.state = ETHSWT_STATE_INIT;

err_exit:
    ETHSWT_REPORT_ERR(ret, aID, line,
        BRCM_SWDSGN_ETHSWT_DRV_INIT_PROC, 0UL, 0UL, 0UL)
    return ret;
}

/** @brief Tx adapt buffer

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aCntrlID    Controller Index
    @param[in]      aBufIdx     Buffer Index
    @param[inout]   aDataInOut  Pointer to data
    @param[inout]   aLenInOut   Pointer to length

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK                 On Success
    @retval     #BCM_ERR_INVAL_PARAMS       (aBufIdx is invalid) or
                                            (aDataInOut is NULL) or
                                            (*aDataInOut is NULL) or
                                            (aLenInOut is NULL or invalid)
    @retval     #BCM_ERR_INVAL_BUF_STATE    Buffer is not in free state

    @post None

    @trace #BRCM_SWARCH_ETHSWT_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_MANAGEMENT
*/
static int32_t ETHSWT_DrvTxAdaptBuffer(ETHER_HwIDType aCntrlID,
        uint32_t aBufIdx,
        uint8_t ** const aDataInOut,
        uint32_t * const aLenInOut)
{
    int32_t ret = BCM_ERR_INVAL_PARAMS;
    ETHSWT_DrvBufInfoType *bufInfo;

    if ((ETHSWT_DRV_TX_BUF_INFO_Q_SIZE > aBufIdx)
            && (NULL != aDataInOut)
            && (NULL != (*aDataInOut))
            && (NULL != aLenInOut)
            && (SWITCH_INGRESS_MGMT_INFO_SIZE < (*aLenInOut))) {
        bufInfo = &ETHSWT_DrvTxBufInfoQ[aBufIdx];
        if (ETHSWT_DRV_BUF_STATE_FREE == bufInfo->bufState) {
            *aLenInOut -= SWITCH_INGRESS_MGMT_INFO_SIZE;
            *aDataInOut = &((*aDataInOut)[2UL * ETHER_MAC_ADDR_SIZE + SWITCH_INGRESS_MGMT_INFO_SIZE]);
            bufInfo->bufState = ETHSWT_DRV_BUF_STATE_ADAPTED;
            ret = BCM_ERR_OK;
        } else {
            ret = BCM_ERR_INVAL_BUF_STATE;
        }
    }

    return ret;
}

/** @brief Set management information

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  aCntrlID    Controller Index
    @param[in]  aBufIdx     Buffer Index
    @param[in]  aMgmtInfo   Management information to be set

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK                 On Success
    @retval     #BCM_ERR_INVAL_PARAMS       (aBufIdx is invalid) or
                                            (aMgmtInfo is NULL)
    @retval     #BCM_ERR_INVAL_BUF_STATE    Buffer is not in adapted state

    @post None

    @trace #BRCM_SWARCH_ETHSWT_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_MANAGEMENT
*/
static int32_t ETHSWT_DrvSetMgmtInfo(ETHER_HwIDType aCntrlID,
                            uint32_t aBufIdx,
                            const ETHSWT_MgmtInfoType * const aMgmtInfo)
{
    int32_t ret = BCM_ERR_INVAL_PARAMS;
    ETHSWT_DrvBufInfoType *bufInfo;

    if ((ETHSWT_DRV_TX_BUF_INFO_Q_SIZE > aBufIdx) && (NULL != aMgmtInfo)) {
        bufInfo = &ETHSWT_DrvTxBufInfoQ[aBufIdx];
        if (ETHSWT_DRV_BUF_STATE_ADAPTED == bufInfo->bufState) {
            bufInfo->mgmtInfo = *aMgmtInfo;
            bufInfo->bufState = ETHSWT_DRV_BUF_STATE_MGMT_INFO_SET;
            ret = BCM_ERR_OK;
        } else {
            ret = BCM_ERR_INVAL_BUF_STATE;
        }
    }

    return ret;
}

/** @brief Tx process frame

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  aCntrlID    Controller Index
    @param[in]  aBufIdx     Buffer Index
    @param[in]  aDataInOut  Pointer to data
    @param[in]  aLenInOut   Pointer to length

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK                 On Success
    @retval     #BCM_ERR_INVAL_PARAMS       (aBufIdx is invalid) or
                                            (aDataInOut is NULL) or
                                            (*aDataInOut is NULL) or
                                            (Length is zero)
    @retval     #BCM_ERR_INVAL_BUF_STATE    Buffer is in invalid state

    @post None

    @trace #BRCM_SWARCH_ETHSWT_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_MANAGEMENT
*/
static int32_t ETHSWT_DrvTxProcessFrame(ETHER_HwIDType aCntrlID,
                                uint32_t aBufIdx,
                                uint8_t ** const aDataInOut,
                                uint32_t * const aLenInOut)
{
    int32_t ret = BCM_ERR_INVAL_PARAMS;
    ETHSWT_DrvBufInfoType *bufInfo;
    uint32_t * mgmtInfo;
    uint32_t mask = 0UL;

    if (ETHSWT_DRV_TX_BUF_INFO_Q_SIZE > aBufIdx) {
        if ((NULL != aDataInOut)
                && (NULL != (*aDataInOut))
                && (NULL != aLenInOut)
                && (0UL != (*aLenInOut))) {
            bufInfo = &ETHSWT_DrvTxBufInfoQ[aBufIdx];
            if ((ETHSWT_DRV_BUF_STATE_MGMT_INFO_SET == bufInfo->bufState)
                || (ETHSWT_DRV_BUF_STATE_ADAPTED == bufInfo->bufState)) {

                /* If user has not invoked the ETHSWT_SetMgmtInfo call, */
                /* assume that he/she leaves it to the switch to handle */
                /* the frame i.e. default to opcode 000                 */
                if (ETHSWT_DRV_BUF_STATE_ADAPTED == bufInfo->bufState) {
                    bufInfo->mgmtInfo.portIdx = ETHSWT_PORT_ID_INVALID;
                    bufInfo->mgmtInfo.tc  = ETHSWT_TC_0;
                }
                *aLenInOut += SWITCH_INGRESS_MGMT_INFO_SIZE;

                if (TRUE == ETHSWT_DrvData.bhShiftEnable) {
                    mgmtInfo = (uint32_t *)(*aDataInOut);
                    /* Move macHdr inside the frame */
                    BCM_MemMove(&(*aDataInOut)[SWITCH_INGRESS_MGMT_INFO_SIZE],
                                *aDataInOut, 2UL * ETHER_MAC_ADDR_SIZE);
                } else {
                    mgmtInfo = (uint32_t *)(&(*aDataInOut)[2UL * ETHER_MAC_ADDR_SIZE]);
                }
                /* Insert management information */
                /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_TXRX_2, ETHSWT_IT_CASE_FROCE_INVAL_PORT_ID, ITPortID = bufInfo->mgmtInfo.portIdx; bufInfo->mgmtInfo.portIdx = ETHSWT_PORT_ID_INVALID) */
                if (bufInfo->mgmtInfo.portIdx == ETHSWT_PORT_ID_INVALID) {
                    /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_TXRX_2, ETHSWT_IT_CASE_FROCE_INVAL_PORT_ID, bufInfo->mgmtInfo.portIdx = ITPortID) */
                    mask |= SWITCH_INGRESS_MGMT_INFO_OPCODE0;
                } else {
#if defined(__BCM8956X__) || defined(__BCM8957X__)
                    if (ETHSWT_DrvData.switchType == ETHSWT_SWITCH_LIGHTSTACK_SLAVE) {
                        mask |= SWITCH_INGRESS_MGMT_INFO_OPCODE3;
                    } else {
                        mask |= SWITCH_INGRESS_MGMT_INFO_OPCODE1;
                    }
#else
                    mask |= SWITCH_INGRESS_MGMT_INFO_OPCODE1;
#endif
                    mask |= (0x1UL << bufInfo->mgmtInfo.portIdx);
                }
                mask |= (uint32_t)(bufInfo->mgmtInfo.tc << SWITCH_INGRESS_MGMT_INFO_TC_SHIFT);
                *mgmtInfo = CPU_NativeToBE32(mask);
                bufInfo->bufState = ETHSWT_DRV_BUF_STATE_PROCESSED;
                ret = BCM_ERR_OK;
            } else {
                ret = BCM_ERR_INVAL_BUF_STATE;
            }
        } else if ((NULL == aDataInOut)
                && (NULL != aLenInOut)
                && (0UL == (*aLenInOut))) {
            /* Change switch buffer info state to Free */
            ETHSWT_DrvTxBufInfoQ[aBufIdx].bufState = ETHSWT_DRV_BUF_STATE_FREE;
            ret = BCM_ERR_OK;
        } else {
            /* Handling default else case */
        }
    }

    return ret;
}

/** @brief Tx done indication

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aCtrlID     Controller index
    @param[in]      aBufIdx     Buffer Index
    @param[inout]   aMgmtInfo   Pointer to management information
    @param[inout]   aTs         Pointer to timestamp
    @param[inout]   aTsQual     Pointer to timestamp result

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK                 On Success
    @retval     #BCM_ERR_INVAL_PARAMS       aBufIdx is invalid
    @retval     #BCM_ERR_INVAL_BUF_STATE    Buffer is in not in processed state
    @return     Others                      As returned by #ETHSWT_DrvGetTxTimestamp

    @post None

    @trace #BRCM_SWARCH_ETHSWT_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_INDICATIONS
*/
static int32_t ETHSWT_DrvTxDoneInd(ETHER_HwIDType aCntrlID,
        uint32_t aBufIdx, ETHSWT_MgmtInfoType **aMgmtInfo,
        ETHER_TimestampType *aTs, ETHER_TimestampQualType *aTsQual)
{
    int32_t ret = BCM_ERR_INVAL_PARAMS;
    ETHSWT_DrvBufInfoType *bufInfo;

    *aMgmtInfo = NULL;

    if (ETHSWT_DRV_TX_BUF_INFO_Q_SIZE > aBufIdx) {
        bufInfo = &ETHSWT_DrvTxBufInfoQ[aBufIdx];
        if (ETHSWT_DRV_BUF_STATE_PROCESSED == bufInfo->bufState) {
#ifdef ENABLE_ETHSWT_TIME
            if (TRUE == bufInfo->isTSEnabled) {
                ret = ETHSWT_DrvGetTxTimestamp(aCntrlID, aBufIdx, aTs, aTsQual,
                        &(bufInfo->mgmtInfo));
                if (BCM_ERR_OK == ret) {
                    *aMgmtInfo = &(bufInfo->mgmtInfo);
                }
            } else {
#endif
                ret = BCM_ERR_OK;
                bufInfo->bufState = ETHSWT_DRV_BUF_STATE_FREE;
#ifdef ENABLE_ETHSWT_TIME
            }
#endif
        } else {
            ret = BCM_ERR_INVAL_BUF_STATE;
        }
    }

    return ret;
}

#ifdef ENABLE_ETHSWT_TIME
/** @brief Tx done indication complete

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  aBufIdx Buffer Index

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK                 On Success
    @retval     #BCM_ERR_INVAL_PARAMS       aBufIdx is invalid
    @retval     #BCM_ERR_INVAL_BUF_STATE    Buffer is in not in processed state

    @post None

    @trace #BRCM_SWARCH_ETHSWT_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_INDICATIONS
*/
static int32_t ETHSWT_DrvTxDoneIndComplete(uint32_t aBufIdx)
{
    int32_t ret = BCM_ERR_INVAL_PARAMS;
    ETHSWT_DrvBufInfoType *bufInfo;

    if (ETHSWT_DRV_TX_BUF_INFO_Q_SIZE > aBufIdx) {
        bufInfo = &ETHSWT_DrvTxBufInfoQ[aBufIdx];
        if (ETHSWT_DRV_BUF_STATE_PROCESSED == bufInfo->bufState) {
            if (TRUE == bufInfo->isTSEnabled) {
                bufInfo->isTSEnabled = FALSE;
                bufInfo->bufState = ETHSWT_DRV_BUF_STATE_FREE;
            }
            ret = BCM_ERR_OK;
        } else {
            ret = BCM_ERR_INVAL_BUF_STATE;
        }
    }

    return ret;
}
#endif

/** @brief Rx Rrocess frame

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aCntrlID    Contoller Index
    @param[in]      aBufIdx     Buffer Index
    @param[inout]   aDataInOut  Pointer to data
    @param[inout]   aLenInOut   Pointer to length
    @param[inout]   aIsMgmtFrameOnly    Management frame only

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK                 On Success
    @retval     #BCM_ERR_INVAL_PARAMS       (aBufIdx is invalid) or
                                            (aDataInOut is NULL) or
                                            (*aDataInOut is NULL) or
                                            (Length is zero)
    @retval     #BCM_ERR_INVAL_BUF_STATE    Buffer is not in free state

    @post None

    @trace #BRCM_SWARCH_ETHSWT_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_MANAGEMENT
*/
static int32_t ETHSWT_DrvRxProcessFrame(ETHER_HwIDType aCntrlID,
                                uint32_t aBufIdx,
                                uint8_t **const aDataInOut,
                                uint32_t * const aLenInOut,
                                uint32_t *const aIsMgmtFrameOnly)
{
    int32_t ret = BCM_ERR_INVAL_PARAMS;
    ETHSWT_DrvBufInfoType *bufInfo;
    uint8_t *mgmtInfoPtr;

    /* TODO: Check what to do with aIsMgmtFrameOnly */

    if ((ETHSWT_DRV_RX_BUF_INFO_Q_SIZE > aBufIdx)
            && (NULL != aDataInOut)
            && (NULL != (*aDataInOut))
            && (NULL != aLenInOut)
            && (0UL != (*aLenInOut))) {
        bufInfo = &ETHSWT_DrvRxBufInfoQ[aBufIdx];
        if (ETHSWT_DRV_BUF_STATE_FREE == bufInfo->bufState) {
            if (TRUE == ETHSWT_DrvData.bhShiftEnable) {
                mgmtInfoPtr = *aDataInOut;
            } else {
                mgmtInfoPtr = &((*aDataInOut)[2UL * ETHER_MAC_ADDR_SIZE]);
            }
            /* Assuming Broadcom header is present */
            bufInfo->mgmtInfo.portIdx = (uint32_t)mgmtInfoPtr[3]
                                        & SWITCH_EGRESS_MGMT_INFO_SRC_PID_MASK;
            bufInfo->mgmtInfo.tc      = mgmtInfoPtr[3]
                                        & SWITCH_EGRESS_MGMT_INFO_TC_MASK;
            if (TRUE == ETHSWT_DrvData.bhShiftEnable) {
                BCM_MemMove(*aDataInOut,
                            &(*aDataInOut)[SWITCH_INGRESS_MGMT_INFO_SIZE],
                            2UL * ETHER_MAC_ADDR_SIZE);
            }
            *aLenInOut -= SWITCH_EGRESS_MGMT_INFO_SIZE;
            *aDataInOut = &((*aDataInOut)[2UL * ETHER_MAC_ADDR_SIZE + SWITCH_EGRESS_MGMT_INFO_SIZE]);
            bufInfo->buf = *aDataInOut;
            bufInfo->bufState = ETHSWT_DRV_BUF_STATE_PROCESSED;
            ret = BCM_ERR_OK;
        } else {
            ret = BCM_ERR_INVAL_BUF_STATE;
        }
    }

    return ret;
}

/** @brief Rx done indication

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aCntrlID        Controller Index
    @param[in]      aBufIdx         Buffer Index
    @param[inout]   aBuf            Pointer to buffer
    @param[inout]   aMgmtInfo       Pointer to management information
    @param[inout]   aTs             Pointer to timestamp
    @param[inout]   aTsQual         Pointer to timestamp result
    @param[inout]   aTSAvailable    Flag to check if timestamp available

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK                 On Success
    @retval     #BCM_ERR_INVAL_PARAMS       aBufIdx is invalid
    @retval     #BCM_ERR_INVAL_BUF_STATE    Buffer is not in processed state

    @post None

    @trace #BRCM_SWARCH_ETHSWT_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_INDICATIONS
*/
static int32_t ETHSWT_DrvRxDoneInd(ETHER_HwIDType aCntrlID, uint32_t aBufIdx,
        const uint8_t **aBuf, ETHSWT_MgmtInfoType **aMgmtInfo,
        ETHER_TimestampType *aTs, ETHER_TimestampQualType *aTsQual,
        uint32_t *aTSAvailable)
{
    int32_t ret = BCM_ERR_INVAL_PARAMS;
    ETHSWT_DrvBufInfoType *bufInfo;

    *aBuf = NULL;
    *aMgmtInfo = NULL;
    *aTSAvailable = FALSE;

    if (ETHSWT_DRV_RX_BUF_INFO_Q_SIZE > aBufIdx) {
        bufInfo = &ETHSWT_DrvRxBufInfoQ[aBufIdx];
        if (ETHSWT_DRV_BUF_STATE_PROCESSED == bufInfo->bufState) {
            *aBuf = bufInfo->buf;
            *aMgmtInfo = &(bufInfo->mgmtInfo);
#ifdef ENABLE_ETHSWT_TIME
            if (TRUE == ETHSWT_DrvData.enableTimeStamp[bufInfo->mgmtInfo.portIdx]) {
                ret = ETHSWT_DrvGetRxTimestamp(aCntrlID, bufInfo->buf,
                        aTs, aTsQual, &(bufInfo->mgmtInfo));
                if (BCM_ERR_OK == ret) {
                    *aTSAvailable = TRUE;
                }
            }
#endif
            ret = BCM_ERR_OK;
        } else {
            ret = BCM_ERR_INVAL_BUF_STATE;
        }
    }

    return ret;
}

/** @brief Rx done indication complete

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  aBufIdx     Buffer Index

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @retval     #BCM_ERR_INVAL_PARAMS   aBufIdx is invalid
    @retval     #BCM_ERR_INVAL_BUF_STATE    Buffer is not in processed state

    @post None

    @trace #BRCM_SWARCH_ETHSWT_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_INDICATIONS
*/
static int32_t ETHSWT_DrvRxDoneIndComplete(uint32_t aBufIdx)
{
    int32_t ret = BCM_ERR_INVAL_PARAMS;
    ETHSWT_DrvBufInfoType *bufInfo;

    /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_TXRX, ETHSWT_IT_CASE_FROCE_BUF_IDX_ERR, aBufIdx = ETHSWT_DRV_RX_BUF_INFO_Q_SIZE) */
    if (ETHSWT_DRV_RX_BUF_INFO_Q_SIZE > aBufIdx) {
        bufInfo = &ETHSWT_DrvRxBufInfoQ[aBufIdx];
        /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_TXRX, ETHSWT_IT_CASE_FROCE_BUF_STATE_ERR, ITDrvBufState = bufInfo->bufState; bufInfo->bufState = ETHSWT_DRV_BUF_STATE_FREE) */
        if (ETHSWT_DRV_BUF_STATE_PROCESSED == bufInfo->bufState) {
            bufInfo->bufState = ETHSWT_DRV_BUF_STATE_FREE;
            ret = BCM_ERR_OK;
        } else {
            /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_TXRX, ETHSWT_IT_CASE_FROCE_BUF_STATE_ERR, bufInfo->bufState = ITDrvBufState) */
            ret = BCM_ERR_INVAL_BUF_STATE;
        }
    }

    return ret;
}


/** @brief Get IMP Broadcom header mode

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aSwtID  Switch Index
    @param[inout]   aMode   Pointer to read mode into it

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success

    @post None

    @trace #BRCM_SWARCH_ETHSWT_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_QUERY
*/
static int32_t ETHSWT_DrvGetBrcmHdrMode(ETHSWT_HwIDType aSwtID,
        ETHSWT_BrcmHdrModeType *const aMode)
{
    uint32_t line = 0UL;
    int32_t ret = BCM_ERR_INVAL_PARAMS;
    uint8_t reg;

    /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_BRCM_HDR_MODE, ETHSWT_IT_CASE_FROCE_HWID_ERR, aSwtID = SWITCH_MAX_HW_ID) */
    if (aSwtID < SWITCH_MAX_HW_ID) {
        ret = ETHSWT_DrvReadReg8(aSwtID, (uint32_t)&ETHSWT_Regs->m02_brcm_hdr_ctrl, &reg);
        /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_BRCM_HDR_MODE, ETHSWT_IT_CASE_FROCE_RD_ERR_1, ret = BCM_ERR_UNKNOWN) */
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
        if ((reg & SWITCH_BRCM_HDR_CTRL_P8_EN_MASK) == SWITCH_BRCM_HDR_CTRL_P8_EN_MASK) {
            *aMode = ETHSWT_BRCMHDR_ENABLE;
        } else {
            *aMode = ETHSWT_BRCMHDR_DISABLE;
        }
    }
err_exit:
    ETHSWT_REPORT_ERR(ret, aSwtID, line,
        BRCM_SWDSGN_ETHSWT_DRV_GET_BRCM_HDR_MODE_PROC, 0UL, 0UL, 0UL)
    return ret;
}

/**
    @brief Get IMP Broadcom header mode

    @trace #BRCM_SWARCH_ETHSWT_GET_BRCMHDRMODE_PROC
    @trace #BRCM_SWREQ_ETHSWT_QUERY
*/
int32_t ETHSWT_GetBrcmHdrMode(ETHSWT_HwIDType aSwtID,
        ETHSWT_BrcmHdrModeType *const aMode)
{
    int32_t ret;
    ETHSWT_IOType swtIO;

    if ((aSwtID < SWITCH_MAX_HW_ID) && (aMode != NULL)) {
        if (ETHSWT_DrvData.state == ETHSWT_STATE_UNINIT) {
            ret = BCM_ERR_UNINIT;
        } else {
            swtIO.retVal = BCM_ERR_UNKNOWN;
            swtIO.swtHwID = aSwtID;
            ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_GET_BRCMHDR_MODE, &swtIO);
            if (BCM_ERR_OK == ret) {
                *aMode = swtIO.mode;
            }
        }
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }

    return ret;
}

/**
    @brief Set IMP Broadcom header mode

    @trace #BRCM_SWARCH_ETHSWT_SET_BRCMHDRMODE_PROC
    @trace #BRCM_SWREQ_ETHSWT_DYNAMIC_CONFIGURATION
*/
int32_t ETHSWT_SetBrcmHdrMode(ETHSWT_HwIDType aSwtID,
        ETHSWT_BrcmHdrModeType aMode)
{
    int32_t ret;
    ETHSWT_IOType swtIO;
    ETHSWT_MgmtModeType mgmtMode;

    if (aSwtID < SWITCH_MAX_HW_ID) {
        if (ETHSWT_DrvData.state == ETHSWT_STATE_UNINIT) {
            ret = BCM_ERR_UNINIT;
        } else {
            /* Only allow this in managed mode */
            /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_BRCM_HDR_MODE, ETHSWT_IT_CASE_FROCE_SWTID_ERR, aSwtID = SWITCH_MAX_HW_ID) */
            ret = ETHSWT_GetMgmtMode(aSwtID, &mgmtMode);
            if (BCM_ERR_OK == ret) {
                if (ETHSWT_MGMTMODE_ENABLE == mgmtMode) {
                    swtIO.retVal = BCM_ERR_UNKNOWN;
                    swtIO.swtHwID = aSwtID;
                    swtIO.mode = aMode;
                    ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_SET_BRCMHDR_MODE, &swtIO);
                } else {
                    ret = BCM_ERR_NOPERM;
                }
            }
        }
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }

    return ret;
}


/** @brief Get dumb forward mode

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aSwtID  Switch Index
    @param[inout]   aMode   Pointer to read mode into it

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success

    @post None

    @trace #BRCM_SWARCH_ETHSWT_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_QUERY
*/
static int32_t ETHSWT_DrvGetDumbFwdMode(ETHSWT_HwIDType aSwtID,
        ETHSWT_DumbFwdModeType *const aMode)
{
    uint32_t line = 0UL;
    int32_t ret = BCM_ERR_INVAL_PARAMS;
    uint16_t reg;
    uint64_t mask = 0ULL;

    /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_DUMB_FWD_MODE, ETHSWT_IT_CASE_HWID_ERR_GETFWDMODE, aSwtID = SWITCH_MAX_HW_ID) */
    if (aSwtID < SWITCH_MAX_HW_ID) {
        ret = ETHSWT_DrvReadReg16(aSwtID, (uint32_t)&ETHSWT_Regs->m00_switch_ctrl, &reg);
        /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_DUMB_FWD_MODE, ETHSWT_IT_CASE_FROCE_RD_ERR_2, ret = BCM_ERR_UNKNOWN) */
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
        mask |= SWITCH_P00SC_PAGE_00_CTRL_MII_DUMB_FWDG_EN_MASK;
        if ((reg & mask) == mask) {
            *aMode = ETHSWT_DUMBFWD_ENABLE;
        } else {
            *aMode = ETHSWT_DUMBFWD_DISABLE;
        }
    }
err_exit:
    ETHSWT_REPORT_ERR(ret, aSwtID, line,
        BRCM_SWDSGN_ETHSWT_DRV_GET_DUMB_FWD_MODE_PROC, 0UL, 0UL, 0UL)
    return ret;
}

/**
    @brief Get management mode

    @trace #BRCM_SWARCH_ETHSWT_GET_MGMTMODE_PROC
    @trace #BRCM_SWREQ_ETHSWT_QUERY
*/
int32_t ETHSWT_GetMgmtMode(ETHSWT_HwIDType aSwtID,
        ETHSWT_MgmtModeType *const aMode)
{
    int32_t ret;
    ETHSWT_IOType swtIO;

    /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_DUMB_FWD_MODE, ETHSWT_IT_CASE_FROCE_HWID_ERR, aSwtID = SWITCH_MAX_HW_ID) */
    if ((aSwtID < SWITCH_MAX_HW_ID) && (aMode != NULL)) {
        /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_DUMB_FWD_MODE, ETHSWT_IT_CASE_FROCE_STATE_ERR, ITDrvState = ETHSWT_DrvData.state; ETHSWT_DrvData.state = ETHSWT_STATE_UNINIT) */
        if (ETHSWT_DrvData.state == ETHSWT_STATE_UNINIT) {
            ret = BCM_ERR_UNINIT;
            /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_DUMB_FWD_MODE, ETHSWT_IT_CASE_FROCE_STATE_ERR, ETHSWT_DrvData.state = ITDrvState) */
        } else {
            swtIO.retVal = BCM_ERR_UNKNOWN;
            swtIO.swtHwID = aSwtID;
            /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_DUMB_FWD_MODE, ETHSWT_IT_CASE_FROCE_CMD_REQ_ERR, swtIO.swtHwID = SWITCH_MAX_HW_ID) */
            ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_GET_MGMT_MODE, &swtIO);
            if (BCM_ERR_OK == ret) {
                *aMode = swtIO.mode;
            }
        }
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }

    return ret;
}


/**
    @brief Get dumb forward mode

    @trace #BRCM_SWARCH_ETHSWT_GET_DUMBFWDMODE_PROC
    @trace #BRCM_SWREQ_ETHSWT_QUERY
*/
int32_t ETHSWT_GetDumbFwdMode(ETHSWT_HwIDType aSwtID,
        ETHSWT_DumbFwdModeType *const aMode)
{
    int32_t ret;
    ETHSWT_IOType swtIO;

    if ((aSwtID < SWITCH_MAX_HW_ID) && (aMode != NULL)) {
        if (ETHSWT_DrvData.state == ETHSWT_STATE_UNINIT) {
            ret = BCM_ERR_UNINIT;
        } else {
            swtIO.retVal = BCM_ERR_UNKNOWN;
            swtIO.swtHwID = aSwtID;
            ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_GET_DUMBFWD_MODE, &swtIO);
            if (BCM_ERR_OK == ret) {
                *aMode = swtIO.mode;
            }
        }
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }

    return ret;
}

/**
    @brief Set dumb forward mode

    @trace #BRCM_SWARCH_ETHSWT_SET_DUMBFWDMODE_PROC
    @trace #BRCM_SWREQ_ETHSWT_DYNAMIC_CONFIGURATION
*/
int32_t ETHSWT_SetDumbFwdMode(ETHSWT_HwIDType aSwtID,
        ETHSWT_DumbFwdModeType aMode)
{
    int32_t ret;
    ETHSWT_IOType swtIO;
    ETHSWT_MgmtModeType mgmtMode;

    if (aSwtID < SWITCH_MAX_HW_ID) {
        if (ETHSWT_DrvData.state == ETHSWT_STATE_UNINIT) {
            ret = BCM_ERR_UNINIT;
        } else {
            ret = ETHSWT_GetMgmtMode(aSwtID, &mgmtMode);
            if (BCM_ERR_OK == ret) {
                /* Only allow in unmanaged mode */
                if (ETHSWT_MGMTMODE_DISABLE == mgmtMode) {
                    swtIO.retVal = BCM_ERR_UNKNOWN;
                    swtIO.swtHwID = aSwtID;
                    swtIO.mode = aMode;
                    ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_SET_DUMBFWD_MODE, &swtIO);
                } else {
                    ret = BCM_ERR_NOPERM;
                }
            }
        }
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }

    return ret;
}

/**
    @brief Set management mode

    @trace #BRCM_SWARCH_ETHSWT_SET_MGMTMODE_PROC
    @trace #BRCM_SWREQ_ETHSWT_DYNAMIC_CONFIGURATION
*/
int32_t ETHSWT_SetMgmtMode(ETHSWT_HwIDType aSwtID,
        ETHSWT_MgmtModeType aMode)
{
    int32_t ret;
    ETHSWT_IOType swtIO;

    if (aSwtID < SWITCH_MAX_HW_ID) {
        if (ETHSWT_DrvData.state == ETHSWT_STATE_UNINIT) {
            ret = BCM_ERR_UNINIT;
        } else {
            swtIO.retVal = BCM_ERR_UNKNOWN;
            swtIO.swtHwID = aSwtID;
            swtIO.mode = aMode;
            ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_SET_MGMT_MODE, &swtIO);
        }
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }

    return ret;
}

/**
    @code{.unparsed}
    if (aSwtID < SWITCH_MAX_HW_ID)
        swtIO.retVal = BCM_ERR_UNKNOWN
        swtIO.swtHwID = aSwtID
        swtIO.ctrlHwID = aCntrlID
        swtIO.enable = aEnable
        ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_ENABLE_BH_SHIFT, &swtIO)
    else
        ret = BCM_ERR_INVAL_PARAMS
    return ret
    @endcode

    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION
    @trace #BRCM_SWARCH_ETHSWT_ENABLEBHSHIFT_PROC
*/
int32_t ETHSWT_EnableBHShift(ETHSWT_HwIDType aSwtID,
                          ETHER_HwIDType aCntrlID, uint32_t aEnable)
{
    int32_t ret;
    ETHSWT_IOType swtIO;

    if (aSwtID < SWITCH_MAX_HW_ID) {
        swtIO.retVal = BCM_ERR_UNKNOWN;
        swtIO.swtHwID = aSwtID;
        swtIO.ctrlHwID = aCntrlID;
        swtIO.enable = aEnable;
        ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_ENABLE_BH_SHIFT, &swtIO);
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }
    return ret;
}

/**
    @brief Read register

    @trace #BRCM_SWARCH_ETHSWT_READ_REG_PROC
    @trace #BRCM_SWREQ_ETHSWT_QUERY
*/
int32_t ETHSWT_ReadReg(ETHSWT_HwIDType aSwtID, uint32_t aAddr,
        uint64_t *const aVal)
{
    ETHSWT_IOType swtIO;
    int32_t ret;

    if ((aSwtID < SWITCH_MAX_HW_ID) && (aVal != NULL)) {
        if (ETHSWT_DrvData.state == ETHSWT_STATE_UNINIT) {
            ret = BCM_ERR_UNINIT;
        } else {
            swtIO.retVal = BCM_ERR_UNKNOWN;
            swtIO.swtHwID = aSwtID;
            swtIO.regAddr = aAddr;
            swtIO.regVal = aVal;
            ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_READ_REG, &swtIO);
            if (BCM_ERR_OK != ret) {
                ETHSWT_DrvReportError((BCM_SWT_ID & BCM_LOGMASK_USER), (uint8_t)aSwtID,
                        BRCM_SWDSGN_ETHSWT_READ_REG_PROC, ret, 0UL, 0UL, 0UL, __LINE__);
            }
        }
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }
    return ret;
}

/**
    @brief Write register

    @trace #BRCM_SWARCH_ETHSWT_READ_REG_PROC
    @trace #BRCM_SWREQ_ETHSWT_DYNAMIC_CONFIGURATION
*/
int32_t ETHSWT_WriteReg(ETHSWT_HwIDType aSwtID, uint32_t aAddr,
        uint64_t aVal)
{
    ETHSWT_IOType swtIO;
    int32_t ret;

    if (aSwtID < SWITCH_MAX_HW_ID) {
        if (ETHSWT_DrvData.state == ETHSWT_STATE_UNINIT) {
            ret = BCM_ERR_UNINIT;
        } else {
            swtIO.swtHwID = aSwtID;
            swtIO.retVal = BCM_ERR_UNKNOWN;
            swtIO.regAddr = aAddr;
            swtIO.regVal = &aVal;
            ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_WRITE_REG, &swtIO);
            if (BCM_ERR_OK != ret) {
                ETHSWT_DrvReportError((BCM_SWT_ID & BCM_LOGMASK_USER), (uint8_t)aSwtID,
                        BRCM_SWDSGN_ETHSWT_WRITE_REG_PROC, ret, 0UL, 0UL, 0UL, __LINE__);
            }
        }
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }

    return ret;
}


/**
    @brief Switch Initialization

    @trace #BRCM_SWARCH_ETHSWT_INIT_PROC
    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION
*/
void ETHSWT_Init(ETHSWT_HwIDType aSwtID)
{
    ETHSWT_IOType swtIO;
    int32_t ret = BCM_ERR_OK;
    uint32_t port2TimeFifoMap[ETHSWT_PORT_ID_MAX];

    if (aSwtID < SWITCH_MAX_HW_ID) {
        if (ETHSWT_DrvData.state == ETHSWT_STATE_UNINIT) {
            ret = MCU_GetSwitchPort2TimeFifoMap(port2TimeFifoMap);
            /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_INIT, ETHSWT_IT_CASE_INIT_NEG, ret = BCM_ERR_UNKNOWN) */
            if (BCM_ERR_OK == ret) {
                swtIO.retVal = BCM_ERR_UNKNOWN;
                swtIO.swtHwID = aSwtID;
                swtIO.port2TimeFifoMap = &port2TimeFifoMap[0UL];
                ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_INIT, &swtIO);
            }
        } else {
            ret = BCM_ERR_INVAL_STATE;
        }
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }

    if (ret != BCM_ERR_OK) {
        ETHSWT_DrvReportError((BCM_SWT_ID & BCM_LOGMASK_USER), (uint8_t)aSwtID,
                BRCM_SWDSGN_ETHSWT_INIT_PROC, ret, 0UL, 0UL, 0UL, __LINE__);
    }
}

/**
    @brief Set management information

    @trace #BRCM_SWARCH_ETHSWT_SET_MGMT_INFO_PROC
    @trace #BRCM_SWREQ_ETHSWT_MANAGEMENT
*/
int32_t ETHSWT_SetMgmtInfo(ETHER_HwIDType aCntrlID,
                            uint32_t aBufIdx,
                            ETHSWT_MgmtInfoType * const aMgmtInfo)
{
    ETHSWT_IOType swtIO;
    int32_t ret;

    if (ETHSWT_DrvData.state == ETHSWT_STATE_UNINIT) {
        ret = BCM_ERR_UNINIT;
    } else {
        swtIO.retVal = BCM_ERR_UNKNOWN;
        swtIO.ctrlHwID = aCntrlID;
        swtIO.bufIdx = aBufIdx;
        swtIO.mgmtInfo = aMgmtInfo;

        ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_SET_MGMT_INFO, &swtIO);
    }

    return ret;
}

/**
    @brief Tx adapt buffer

    @trace #BRCM_SWARCH_ETHSWT_TX_ADAPT_BUF_PROC
    @trace #BRCM_SWREQ_ETHSWT_MANAGEMENT
*/
int32_t ETHSWT_TxAdaptBuffer(ETHER_HwIDType aCntrlID,
        uint32_t aBufIdx,
        uint8_t ** const aDataInOut,
        uint32_t * const aLenInOut)
{
    ETHSWT_IOType swtIO;
    int32_t ret;

    if (ETHSWT_DrvData.state == ETHSWT_STATE_UNINIT) {
        ret = BCM_ERR_UNINIT;
    } else {
        swtIO.retVal = BCM_ERR_UNKNOWN;
        swtIO.ctrlHwID = aCntrlID;
        swtIO.bufIdx = aBufIdx;
        swtIO.data = aDataInOut;
        swtIO.len = aLenInOut;
        ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_TX_ADAPT_BUFFER, &swtIO);
    }

    return ret;
}

/**
    @brief Tx process frame

    @trace #BRCM_SWARCH_ETHSWT_TX_PROCESS_FRAME_PROC
    @trace #BRCM_SWREQ_ETHSWT_MANAGEMENT
*/
int32_t ETHSWT_TxProcessFrame(ETHER_HwIDType aCntrlID,
        uint32_t aBufIdx,
        uint8_t ** const aDataInOut,
        uint32_t * const aLenInOut)
{
    ETHSWT_IOType swtIO;
    int32_t ret;

    if (ETHSWT_DrvData.state == ETHSWT_STATE_UNINIT) {
        ret = BCM_ERR_UNINIT;
    } else {
        swtIO.retVal = BCM_ERR_UNKNOWN;
        swtIO.ctrlHwID = aCntrlID;
        swtIO.bufIdx = aBufIdx;
        swtIO.data = aDataInOut;
        swtIO.len = aLenInOut;
        ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_TX_PROCESS_FRAME, &swtIO);
    }

    return ret;
}

/**
    @brief Tranciever done indication

    @trace #BRCM_SWARCH_ETHSWT_TX_DONE_IND_PROC
    @trace #BRCM_SWREQ_ETHSWT_INDICATIONS
*/
int32_t ETHSWT_TxDoneInd(ETHER_HwIDType aCntrlID,
        uint32_t aBufIdx)
{
    ETHSWT_IOType swtIO;
    int32_t ret;
    ETHER_TimestampType ts;
    ETHER_TimestampQualType tsQual;

    if (ETHSWT_DrvData.state == ETHSWT_STATE_UNINIT) {
        ret = BCM_ERR_UNINIT;
    } else {
        swtIO.retVal = BCM_ERR_UNKNOWN;
        swtIO.ctrlHwID = aCntrlID;
        swtIO.bufIdx = aBufIdx;
        swtIO.mgmtInfo = NULL;
        swtIO.ts = &ts;
        swtIO.tsQual = &tsQual;

        ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_TX_DONE_IND, &swtIO);
        /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_TXRX, ETHSWT_IT_CASE_FROCE_MGMT_INFO, ret = BCM_ERR_OK; swtIO.mgmtInfo = (ETHSWT_MgmtInfoType *)0xabcd) */
        if ((BCM_ERR_OK == ret) && (NULL != swtIO.mgmtInfo)) {
#ifdef ENABLE_ETHSWT_TIME
            ETHSWT_TxTSInd(aCntrlID, aBufIdx, swtIO.mgmtInfo, &ts, &tsQual);
            ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_TX_DONE_IND_COMPLETE, &swtIO);
#endif
        }
    }

    return ret;
}

/**
    @brief Receiver process frame

    @trace #BRCM_SWARCH_ETHSWT_RX_PROCESS_FRAME_PROC
    @trace #BRCM_SWREQ_ETHSWT_MANAGEMENT
*/
int32_t ETHSWT_RxProcessFrame(ETHER_HwIDType aCntrlID,
        uint32_t aBufIdx,
        uint8_t ** const aDataInOut,
        uint32_t * const aLenInOut,
        uint32_t *const aIsMgmtFrameOnly)
{
    ETHSWT_IOType swtIO;
    int32_t ret;

    if (ETHSWT_DrvData.state == ETHSWT_STATE_UNINIT) {
        ret = BCM_ERR_UNINIT;
    } else {
        swtIO.retVal = BCM_ERR_UNKNOWN;
        swtIO.ctrlHwID = aCntrlID;
        swtIO.bufIdx = aBufIdx;
        swtIO.data = aDataInOut;
        swtIO.len = aLenInOut;
        swtIO.isMgmtFrameOnly = aIsMgmtFrameOnly;
        ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_RX_PROCESS_FRAME, &swtIO);
    }

    return ret;
}

/**
    @brief Receiver done indication

    @trace #BRCM_SWARCH_ETHSWT_RX_DONE_IND_PROC
    @trace #BRCM_SWREQ_ETHSWT_INDICATIONS
*/
int32_t ETHSWT_RxDoneInd(ETHER_HwIDType aCntrlID,
        uint32_t aBufIdx)
{
    ETHSWT_IOType swtIO;
    int32_t ret;
    ETHER_TimestampType ts;
    ETHER_TimestampQualType tsQual;

    if (ETHSWT_DrvData.state == ETHSWT_STATE_UNINIT) {
        ret = BCM_ERR_UNINIT;
    } else {
        swtIO.retVal = BCM_ERR_UNKNOWN;
        swtIO.ctrlHwID = aCntrlID;
        swtIO.bufIdx = aBufIdx;
        swtIO.ts = &ts;
        swtIO.tsQual = &tsQual;

        ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_RX_DONE_IND, &swtIO);
        if (BCM_ERR_OK == ret) {
            ETHSWT_MgmtInfoInd(aCntrlID, swtIO.buf, swtIO.mgmtInfo);
#ifdef ENABLE_ETHSWT_TIME
            if (TRUE == swtIO.tsAvailable) {
                ETHSWT_RxTSInd(aCntrlID, swtIO.buf, swtIO.mgmtInfo,
                        swtIO.ts, swtIO.tsQual);
            }
#endif
            ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_RX_DONE_IND_COMPLETE, &swtIO);
        }
    }

    return ret;
}

/**
    @brief Set port role

    @trace #BRCM_SWARCH_ETHSWT_SET_PORT_ROLE_PROC
    @trace  #BRCM_SWREQ_ETHSWT_DYNAMIC_CONFIGURATION
*/
int32_t ETHSWT_SetPortRole(ETHSWT_HwIDType aSwtID,
                           ETHSWT_SwitchType aSwtType,
                           ETHSWT_PortIDType aPortID,
                           ETHSWT_PortType aRole)
{
    ETHSWT_IOType swtIO;
    int32_t ret = BCM_ERR_INVAL_PARAMS;

    if (aSwtID < SWITCH_MAX_HW_ID) {

        if (ETHSWT_DrvData.state == ETHSWT_STATE_UNINIT) {
            ret = BCM_ERR_UNINIT;
        } else {
            swtIO.retVal   = BCM_ERR_UNKNOWN;
            swtIO.swtType  = aSwtType;
            swtIO.swtHwID  = aSwtID;
            swtIO.portHwID = aPortID;
            swtIO.portRole = aRole;

            ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_SET_PORT_ROLE, &swtIO);
        }
    }

    return ret;
}

/**
    @brief Set switch type

    @trace #BRCM_SWARCH_ETHSWT_SET_SWITCH_TYPE_PROC
    @trace  #BRCM_SWREQ_ETHSWT_DYNAMIC_CONFIGURATION
*/
int32_t ETHSWT_SetSwitchType(ETHSWT_HwIDType aSwtID,
                             ETHSWT_SwitchType aSwitchType,
                             uint32_t aUplinkPortCnt,
                             uint32_t *const aUplinkPortMap)
{
    ETHSWT_IOType swtIO;
    int32_t ret = BCM_ERR_INVAL_PARAMS;

    if (aSwtID < SWITCH_MAX_HW_ID) {
        if (ETHSWT_DrvData.state == ETHSWT_STATE_UNINIT) {
            ret = BCM_ERR_UNINIT;
        } else {
            swtIO.retVal   = BCM_ERR_UNKNOWN;
            swtIO.swtType  = aSwitchType;
            swtIO.swtHwID  = aSwtID;
            swtIO.portCnt  = aUplinkPortCnt;
            if (aUplinkPortCnt > 0UL) {
                if (aUplinkPortMap != NULL) {
                    BCM_MemCpy(swtIO.portMap, aUplinkPortMap, sizeof(swtIO.portMap));

                    ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_SET_SWITCH_TYPE, &swtIO);
                }
            }
        }
    }

    return ret;
}

/**
    @code{.unparsed}
#ifdef __BCM8953X__
    ret = BCM_ERR_NOSUPPORT;
#else
    if ((SWITCH_MAX_HW_ID <= aSwtID)
        || (ETHER_HW_ID_0 < aCntrlID)
        || ((TRUE != aEnable) && (FALSE != aEnable)))
        ret = BCM_ERR_INVAL_PARAMS
    else if (ETHSWT_STATE_UNINIT == ETHSWT_DrvData.state)
        ret = BCM_ERR_UNINIT
    else
        ETHSWT_DrvData.bhShiftEnable = aEnable
        ret = BCM_ERR_OK
#endif
    return ret
    @endcode
    @trace #BRCM_SWARCH_ETHSWT_ENABLEBHSHIFT_PROC
    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION
*/
static int32_t ETHSWT_DrvEnableBHShift(ETHSWT_HwIDType aSwtID,
                                    ETHER_HwIDType aCntrlID, uint32_t aEnable)
{
    int32_t ret;

#ifdef __BCM8953X__
    ret = BCM_ERR_NOSUPPORT;
#else
    /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_EN_BH_SHIFT, ETHSWT_IT_CASE_FROCE_SWTID_ERR, aSwtID = SWITCH_MAX_HW_ID) */
    /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_EN_BH_SHIFT, ETHSWT_IT_CASE_FROCE_STATE_ERR, ITDrvState = ETHSWT_DrvData.state; ETHSWT_DrvData.state = ETHSWT_STATE_UNINIT) */
    if ((SWITCH_MAX_HW_ID <= aSwtID)
        || (ETHER_HW_ID_0 < aCntrlID)
        || ((TRUE != aEnable) && (FALSE != aEnable))) {

        ret = BCM_ERR_INVAL_PARAMS;
    } else if (ETHSWT_STATE_UNINIT == ETHSWT_DrvData.state) {
        /* BCM_PROBE_STATEMENT(ETHSWT_IT_SEQ_EN_BH_SHIFT, ETHSWT_IT_CASE_FROCE_STATE_ERR, ETHSWT_DrvData.state = ITDrvState) */
        ret = BCM_ERR_UNINIT;
    } else {
        ETHSWT_DrvData.bhShiftEnable = aEnable;
        ret = BCM_ERR_OK;
    }
#endif
    return ret;
}

/**
    @brief Enable the Receiving Traffic

    @trace #BRCM_SWARCH_ETHSWT_ENABLERX_PROC
    @trace #BRCM_SWREQ_ETHSWT_MANAGEMENT
*/
int32_t ETHSWT_EnableRx (ETHSWT_HwIDType aSwtID,
                               ETHSWT_PortIDType aPortID)
{
    int32_t ret;
    ETHSWT_IOType swtIO;

    if (aSwtID < SWITCH_MAX_HW_ID) {
        if (ETHSWT_DrvData.state == ETHSWT_STATE_UNINIT) {
            ret = BCM_ERR_UNINIT;
        } else {
            swtIO.retVal = BCM_ERR_UNKNOWN;
            swtIO.swtHwID = aSwtID;
            swtIO.portHwID = aPortID;
            ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_ENABLE_RX, &swtIO);
        }
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }

    return ret;
}

/**
    @brief Disable the Receiving Traffic

    @trace #BRCM_SWARCH_ETHSWT_DISABLERX_PROC
    @trace #BRCM_SWREQ_ETHSWT_MANAGEMENT
*/
int32_t ETHSWT_DisableRx (ETHSWT_HwIDType aSwtID,
                            ETHSWT_PortIDType aPortID)
{
    int32_t ret;
    ETHSWT_IOType swtIO;

    if (aSwtID < SWITCH_MAX_HW_ID) {
        if (ETHSWT_DrvData.state == ETHSWT_STATE_UNINIT) {
            ret = BCM_ERR_UNINIT;
        } else {
            swtIO.retVal = BCM_ERR_UNKNOWN;
            swtIO.swtHwID = aSwtID;
            swtIO.portHwID = aPortID;
            ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_DISABLE_RX, &swtIO);
        }
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }

    return ret;
}

/**
    @brief Enable Rx Traffic

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aSwtID      Switch Index
    @param[in]      aPortID     Port ID

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK              Successfully enabled Rx
    @retval     #BCM_ERR_INVAL_PARAMS    aPortID is Invalid

    @post None

    @trace #BRCM_SWARCH_ETHSWT_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_MANAGEMENT

    @limitations None

    @code{.unparsed}
    if aPortID is 8
        ret = ETHSWT_DrvReadReg8(aSwtID, (uint32_t)&ETHSWT_Regs->m00_imp_ctl, &reg)
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
        reg &= ~(SWITCH_PAGE_00_IMP_CTL_RX_DIS_MASK)
        ret = ETHSWT_DrvWriteReg8(aSwtID,
                 (uint32_t)&ETHSWT_Regs->m00_imp_ctl, reg)
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
    else if aPortID  is between 0 to 6
        if BCM8956X
            ret = ETHSWT_DrvReadReg8(aSwtID, (uint32_t)&ETHSWT_Regs->page_00_g_pctl[aPortID].m00_g_pctl_p0, &reg)
            ETHSWT_CHECK_ERR(ret, &line, err_exit)
            reg &= ~(SWITCH_PAGE_00_G_PCTL_RX_DIS_MASK)
            ret = ETHSWT_DrvWriteReg8(aSwtID,
                     (uint32_t)&ETHSWT_Regs->page_00_g_pctl[aPortID].m00_g_pctl_p0, reg)
            ETHSWT_CHECK_ERR(ret, &line, err_exit)
        if BCM8953x
            ret = ETHSWT_DrvReadReg8(aSwtID, (uint32_t)&ETHSWT_Regs->page_00_g_pctl[aPortID].m00_g_pctl0, &reg)
            ETHSWT_CHECK_ERR(ret, &line, err_exit)
            reg &= ~(SWITCH_PAGE_00_G_PCTL_RX_DIS_MASK)
            ret = ETHSWT_DrvWriteReg8(aSwtID,
                     (uint32_t)&ETHSWT_Regs->page_00_g_pctl[aPortID].m00_g_pctl0, reg)
            ETHSWT_CHECK_ERR(ret, &line, err_exit)
    else
        ret is BCM_ERR_INVAL_PARAMS
    err_exit:
        Report Error
    return ret
    @endcode

 */
static int32_t ETHSWT_DrvEnableRx(ETHSWT_HwIDType aSwtID,
                                     ETHSWT_PortIDType aPortID)
{
    uint32_t line = __LINE__;
    int ret = BCM_ERR_OK;
    uint8_t reg = 0U;

    if (8UL == aPortID) {
        ret = ETHSWT_DrvReadReg8(aSwtID, (uint32_t)&ETHSWT_Regs->m00_imp_ctl, &reg);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
        reg &= (uint8_t)~(SWITCH_PAGE_00_IMP_CTL_RX_DIS_MASK);
        ret = ETHSWT_DrvWriteReg8(aSwtID,
                 (uint32_t)&ETHSWT_Regs->m00_imp_ctl, reg);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
    } else if (6UL >= aPortID) {
#if defined(__BCM8956X__) || defined(__BCM8957X__)
        ret = ETHSWT_DrvReadReg8(aSwtID, (uint32_t)&ETHSWT_Regs->page_00_g_pctl[aPortID].m00_g_pctl_p0, &reg);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
        reg &= (uint8_t)~(SWITCH_PAGE_00_G_PCTL_RX_DIS_MASK);
        ret = ETHSWT_DrvWriteReg8(aSwtID,
                 (uint32_t)&ETHSWT_Regs->page_00_g_pctl[aPortID].m00_g_pctl_p0, reg);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
#else
        ret = ETHSWT_DrvReadReg8(aSwtID, (uint32_t)&ETHSWT_Regs->page_00_g_pctl[aPortID].m00_g_pctl0, &reg);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
        reg &= ~(SWITCH_PAGE_00_G_PCTL_RX_DIS_MASK);
        ret = ETHSWT_DrvWriteReg8(aSwtID,
                 (uint32_t)&ETHSWT_Regs->page_00_g_pctl[aPortID].m00_g_pctl0, reg);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
#endif
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }
err_exit:
    ETHSWT_REPORT_ERR( ret, aSwtID, line,
        BRCM_SWDSGN_ETHSWT_DRVENABLERX_PROC, aPortID, 0UL, 0UL)
    return ret;
}

/**
    @brief Disable Rx Traffic

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aSwtID      Switch Index
    @param[in]      aPortID     Port ID

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK              Successfully Disabled Rx
    @retval     #BCM_ERR_INVAL_PARAMS    aPortID is Invalid

    @post None

    @trace #BRCM_SWARCH_ETHSWT_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_MANAGEMENT

    @limitations None

    @code{.unparsed}
    if aPortID is 8
        ret = ETHSWT_DrvReadReg8(aSwtID, (uint32_t)&ETHSWT_Regs->m00_imp_ctl, &reg)
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
        reg |= SWITCH_PAGE_00_IMP_CTL_RX_DIS_MASK
        ret = ETHSWT_DrvWriteReg8(aSwtID,
                 (uint32_t)&ETHSWT_Regs->m00_imp_ctl, reg)
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
    else if aPortID  is between 0 to 6
        if BCM8956X
            ret = ETHSWT_DrvReadReg8(aSwtID, (uint32_t)&ETHSWT_Regs->page_00_g_pctl[aPortID].m00_g_pctl_p0, &reg)
            ETHSWT_CHECK_ERR(ret, &line, err_exit)
            reg |= SWITCH_PAGE_00_G_PCTL_RX_DIS_MASK
            ret = ETHSWT_DrvWriteReg8(aSwtID,
                     (uint32_t)&ETHSWT_Regs->page_00_g_pctl[aPortID].m00_g_pctl_p0, reg)
            ETHSWT_CHECK_ERR(ret, &line, err_exit)
        if BCM8953x
            ret = ETHSWT_DrvReadReg8(aSwtID, (uint32_t)&ETHSWT_Regs->page_00_g_pctl[aPortID].m00_g_pctl0, &reg)
            ETHSWT_CHECK_ERR(ret, &line, err_exit)
            reg |= SWITCH_PAGE_00_G_PCTL_RX_DIS_MASK
            ret = ETHSWT_DrvWriteReg8(aSwtID,
                     (uint32_t)&ETHSWT_Regs->page_00_g_pctl[aPortID].m00_g_pctl0, reg)
            ETHSWT_CHECK_ERR(ret, &line, err_exit)
    else
       ret is BCM_ERR_INVAL_PARAMS
    err_exit:
        Report Error
    return ret
    @endcode

 */
static int32_t ETHSWT_DrvDisableRx(ETHSWT_HwIDType aSwtID,
                                     ETHSWT_PortIDType aPortID)
{
    uint32_t line = __LINE__;
    int ret = BCM_ERR_OK;
    uint8_t reg = 0U;

    if (8UL == aPortID) {
        ret = ETHSWT_DrvReadReg8(aSwtID, (uint32_t)&ETHSWT_Regs->m00_imp_ctl, &reg);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
        reg |= SWITCH_PAGE_00_IMP_CTL_RX_DIS_MASK;
        ret = ETHSWT_DrvWriteReg8(aSwtID,
                 (uint32_t)&ETHSWT_Regs->m00_imp_ctl, reg);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
    } else if (6UL >= aPortID) {
#if defined(__BCM8956X__) || defined(__BCM8957X__)
        ret = ETHSWT_DrvReadReg8(aSwtID, (uint32_t)&ETHSWT_Regs->page_00_g_pctl[aPortID].m00_g_pctl_p0, &reg);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
        reg |= SWITCH_PAGE_00_G_PCTL_RX_DIS_MASK;
        ret = ETHSWT_DrvWriteReg8(aSwtID,
                 (uint32_t)&ETHSWT_Regs->page_00_g_pctl[aPortID].m00_g_pctl_p0, reg);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
#else
        ret = ETHSWT_DrvReadReg8(aSwtID, (uint32_t)&ETHSWT_Regs->page_00_g_pctl[aPortID].m00_g_pctl0, &reg);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
        reg |= SWITCH_PAGE_00_G_PCTL_RX_DIS_MASK;
        ret = ETHSWT_DrvWriteReg8(aSwtID,
                 (uint32_t)&ETHSWT_Regs->page_00_g_pctl[aPortID].m00_g_pctl0, reg);
        ETHSWT_CHECK_ERR(ret, &line, err_exit)
#endif
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }

err_exit:
    ETHSWT_REPORT_ERR( ret, aSwtID, line,
        BRCM_SWDSGN_ETHSWT_DRVDISABLERX_PROC, 0UL, 0UL, 0UL)
    return ret;
}

/**
    @trace #BRCM_SWARCH_ETHSWT_GET_STATE_PROC
    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION
*/
ETHSWT_StateType ETHSWT_GetState(ETHSWT_HwIDType aSwtID)
{
    ETHSWT_StateType state = ETHSWT_STATE_UNINIT;
    if (aSwtID < SWITCH_MAX_HW_ID) {
        state = ETHSWT_DrvData.state;
    }
    return state;
}

/**
    @brief Switch command handler

    @trace #BRCM_SWARCH_ETHSWT_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_KERNEL_HANDLER
*/
int32_t ETHSWT_CmdHandler(ETHSWT_IOCmdType aCmd, ETHSWT_IOType *const aIO)
{
    int32_t ret = BCM_ERR_NOSUPPORT;
    ETHSWT_HwIDType swtHwID = 0xFFU;
    if (NULL != aIO) {
        swtHwID = aIO->swtHwID;
        if ((ETHSWT_STATE_UNINIT == ETHSWT_DrvData.state)
            && (ETHSWT_IO_CMD_INIT == aCmd)) {
            ret = ETHSWT_DrvInit(aIO->swtHwID, aIO->port2TimeFifoMap);
        } else {
            switch (aCmd) {
                case ETHSWT_IO_CMD_READ_REG:
                    ret = ETHSWT_DrvReadReg(aIO->swtHwID, aIO->regAddr,
                            aIO->regVal);
                    break;
                case ETHSWT_IO_CMD_WRITE_REG:
                    ret = ETHSWT_DrvWriteReg(aIO->swtHwID, aIO->regAddr,
                            *(aIO->regVal));
                    break;
#ifdef ENABLE_ETHSWT_TIME
                case ETHSWT_IO_CMD_ENABLE_TX_TIMESTAMP:
                    ret = ETHSWT_DrvSetTSEnabled(aIO->ctrlHwID, aIO->bufIdx);
                    break;
#endif
                case ETHSWT_IO_CMD_SET_DUMBFWD_MODE:
                    ret = ETHSWT_DrvSetDumbFwdMode(aIO->swtHwID, aIO->mode);
                    break;
                case ETHSWT_IO_CMD_GET_DUMBFWD_MODE:
                    ret = ETHSWT_DrvGetDumbFwdMode(aIO->swtHwID, &(aIO->mode));
                    break;
                case ETHSWT_IO_CMD_SET_BRCMHDR_MODE:
                    ret = ETHSWT_DrvSetBrcmHdrMode(aIO->swtHwID, aIO->mode);
                    break;
                case ETHSWT_IO_CMD_GET_BRCMHDR_MODE:
                    ret = ETHSWT_DrvGetBrcmHdrMode(aIO->swtHwID, &(aIO->mode));
                    break;
                case ETHSWT_IO_CMD_SET_MGMT_MODE:
                    ret = ETHSWT_DrvSetMgmtMode(aIO->swtHwID, aIO->mode);
                    break;
                case ETHSWT_IO_CMD_GET_MGMT_MODE:
                    ret = ETHSWT_DrvGetMgmtMode(aIO->swtHwID, &(aIO->mode));
                    break;
                case ETHSWT_IO_CMD_TX_ADAPT_BUFFER:
                    ret = ETHSWT_DrvTxAdaptBuffer(aIO->ctrlHwID, aIO->bufIdx, aIO->data, aIO->len);
                    break;
                case ETHSWT_IO_CMD_TX_PROCESS_FRAME:
                    ret = ETHSWT_DrvTxProcessFrame(aIO->ctrlHwID, aIO->bufIdx, aIO->data, aIO->len);
                    break;
                case ETHSWT_IO_CMD_TX_DONE_IND:
                    ret = ETHSWT_DrvTxDoneInd(aIO->ctrlHwID, aIO->bufIdx, &aIO->mgmtInfo,
                            aIO->ts, aIO->tsQual);
                    break;
#ifdef ENABLE_ETHSWT_TIME
                case ETHSWT_IO_CMD_TX_DONE_IND_COMPLETE:
                    ret = ETHSWT_DrvTxDoneIndComplete(aIO->bufIdx);
                    break;
#endif
                case ETHSWT_IO_CMD_RX_PROCESS_FRAME:
                    ret = ETHSWT_DrvRxProcessFrame(aIO->ctrlHwID, aIO->bufIdx, aIO->data,
                            aIO->len, aIO->isMgmtFrameOnly);
                    break;
                case ETHSWT_IO_CMD_RX_DONE_IND:
                    ret = ETHSWT_DrvRxDoneInd(aIO->ctrlHwID, aIO->bufIdx, &aIO->buf,
                            &aIO->mgmtInfo, aIO->ts, aIO->tsQual, &aIO->tsAvailable);
                    break;
                case ETHSWT_IO_CMD_RX_DONE_IND_COMPLETE:
                    ret = ETHSWT_DrvRxDoneIndComplete(aIO->bufIdx);
                    break;
                case ETHSWT_IO_CMD_SET_MGMT_INFO:
                    ret = ETHSWT_DrvSetMgmtInfo(aIO->ctrlHwID, aIO->bufIdx, aIO->mgmtInfo);
                    break;
                case ETHSWT_IO_CMD_SET_PORT_ROLE:
                    ret = ETHSWT_DrvSetPortRole(aIO->swtHwID, aIO->swtType, aIO->portHwID, aIO->portRole);
                    break;
                case ETHSWT_IO_CMD_SET_SWITCH_TYPE:
                    ret = ETHSWT_DrvSetSwitchType(aIO->swtHwID, aIO->swtType, aIO->portCnt, aIO->portMap);
                    break;
                case ETHSWT_IO_CMD_ENABLE_BH_SHIFT:
                    ret = ETHSWT_DrvEnableBHShift(aIO->swtHwID, aIO->ctrlHwID, aIO->enable);
                    break;
                case ETHSWT_IO_CMD_ENABLE_RX:
                    ret = ETHSWT_DrvEnableRx(aIO->swtHwID, aIO->portHwID);
                    break;
                case ETHSWT_IO_CMD_DISABLE_RX:
                    ret = ETHSWT_DrvDisableRx(aIO->swtHwID, aIO->portHwID);
                    break;
                default:
                    ret = BCM_ERR_UNKNOWN;
                    break;
            }
        }
    } else {
        ret = BCM_ERR_UNKNOWN;
    }
    if (BCM_ERR_OK != ret) {
        ETHSWT_DrvReportError(BCM_SWT_ID, (uint8_t)swtHwID,
                BRCM_SWDSGN_ETHSWT_CMD_HANDLER_PROC, ret, aCmd, 0UL, 0UL, __LINE__);
    }
    return ret;
}
/** @} */
