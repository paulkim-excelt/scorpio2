/*****************************************************************************
 Copyright 2022 Broadcom Limited.  All rights reserved.

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
    @file otp_rdb.h
    @brief RDB File for OTP

    @version Orion_A0_20201104_SWDEV
*/

#ifndef OTP_RDB_H
#define OTP_RDB_H

#include <stdint.h>

#include <compiler.h>


typedef uint32_t OTP_CPU_COMMAND_TYPE;
#define OTP_CPU_COMMAND_OPCODE_MASK (0x3fUL)
#define OTP_CPU_COMMAND_OPCODE_SHIFT (0UL)




typedef uint32_t OTP_CPU_WRDATA_TYPE;
#define OTP_CPU_WRDATA_WRDATA_MASK (0xffffffffUL)
#define OTP_CPU_WRDATA_WRDATA_SHIFT (0UL)




typedef uint32_t OTP_CPU_WRDATA_HI_TYPE;
#define OTP_CPU_WRDATA_HI_HI_MASK (0x7fUL)
#define OTP_CPU_WRDATA_HI_HI_SHIFT (0UL)




typedef uint32_t OTP_CONFIG_TYPE;
#define OTP_CONFIG_OTP_DMAC_ENABLE_MASK (0x10000UL)
#define OTP_CONFIG_OTP_DMAC_ENABLE_SHIFT (16UL)
#define OTP_CONFIG_SOFT_RESET_MASK (0x4000UL)
#define OTP_CONFIG_SOFT_RESET_SHIFT (14UL)
#define OTP_CONFIG_SRIOV_ENABLE_MASK (0x1000UL)
#define OTP_CONFIG_SRIOV_ENABLE_SHIFT (12UL)
#define OTP_CONFIG_OTP_M7_DEV_MODE_ENABLE_MASK (0x800UL)
#define OTP_CONFIG_OTP_M7_DEV_MODE_ENABLE_SHIFT (11UL)
#define OTP_CONFIG_SM_EN_PLL_RESET_MASK (0x400UL)
#define OTP_CONFIG_SM_EN_PLL_RESET_SHIFT (10UL)
#define OTP_CONFIG_OTP_DEV_MODE_ENABLE_MASK (0x200UL)
#define OTP_CONFIG_OTP_DEV_MODE_ENABLE_SHIFT (9UL)
#define OTP_CONFIG_OTP_PCIE_ENABLE_MASK (0x100UL)
#define OTP_CONFIG_OTP_PCIE_ENABLE_SHIFT (8UL)
#define OTP_CONFIG_OTP_CPU_JTAG_ENABLE_MASK (0x80UL)
#define OTP_CONFIG_OTP_CPU_JTAG_ENABLE_SHIFT (7UL)
#define OTP_CONFIG_OTP_OTP_JTAG_ENABLE_MASK (0x40UL)
#define OTP_CONFIG_OTP_OTP_JTAG_ENABLE_SHIFT (6UL)
#define OTP_CONFIG_OTP_MDIO_SLV_ENABLE_MASK (0x20UL)
#define OTP_CONFIG_OTP_MDIO_SLV_ENABLE_SHIFT (5UL)
#define OTP_CONFIG_OTP_SECURITY_MONITOR_ENABLE_MASK (0x10UL)
#define OTP_CONFIG_OTP_SECURITY_MONITOR_ENABLE_SHIFT (4UL)
#define OTP_CONFIG_OTP_SPI_SLV_ENABLE_MASK (0x8UL)
#define OTP_CONFIG_OTP_SPI_SLV_ENABLE_SHIFT (3UL)
#define OTP_CONFIG_OTP_CMD_WR_MASK (0x4UL)
#define OTP_CONFIG_OTP_CMD_WR_SHIFT (2UL)
#define OTP_CONFIG_OTP_CMD_MODE_MASK (0x2UL)
#define OTP_CONFIG_OTP_CMD_MODE_SHIFT (1UL)
#define OTP_CONFIG_DIS_OTP_ACC_MASK (0x1UL)
#define OTP_CONFIG_DIS_OTP_ACC_SHIFT (0UL)




typedef uint32_t OTP_ADDRESS_TYPE;
#define OTP_ADDRESS_ADDRESS_MASK (0x3ffUL)
#define OTP_ADDRESS_ADDRESS_SHIFT (0UL)




typedef uint32_t OTP_STATUS_TYPE;
#define OTP_STATUS_ECC_DED_FLAG_STATUS_MASK (0x800000UL)
#define OTP_STATUS_ECC_DED_FLAG_STATUS_SHIFT (23UL)
#define OTP_STATUS_ECC_SEC_FLAG_STATUS_MASK (0x400000UL)
#define OTP_STATUS_ECC_SEC_FLAG_STATUS_SHIFT (22UL)
#define OTP_STATUS_PRESCREEN_FAIL_MASK (0x100000UL)
#define OTP_STATUS_PRESCREEN_FAIL_SHIFT (20UL)
#define OTP_STATUS_ILLEGAL_ADDR_MASK (0x80000UL)
#define OTP_STATUS_ILLEGAL_ADDR_SHIFT (19UL)
#define OTP_STATUS_MAX_SW_MASK (0x40000UL)
#define OTP_STATUS_MAX_SW_SHIFT (18UL)
#define OTP_STATUS_AUTO_RW_MAX_MASK (0x20000UL)
#define OTP_STATUS_AUTO_RW_MAX_SHIFT (17UL)
#define OTP_STATUS_MAX_RWP_MASK (0x10000UL)
#define OTP_STATUS_MAX_RWP_SHIFT (16UL)
#define OTP_STATUS_MAX_RW_MASK (0x8000UL)
#define OTP_STATUS_MAX_RW_SHIFT (15UL)
#define OTP_STATUS_PG_WD_FP_FAIL_MASK (0x4000UL)
#define OTP_STATUS_PG_WD_FP_FAIL_SHIFT (14UL)
#define OTP_STATUS_PROG_EN_MASK (0x2000UL)
#define OTP_STATUS_PROG_EN_SHIFT (13UL)
#define OTP_STATUS_PROG_BLK_CMD_MASK (0x1000UL)
#define OTP_STATUS_PROG_BLK_CMD_SHIFT (12UL)
#define OTP_STATUS_PROG_SCR_FAIL_MASK (0x800UL)
#define OTP_STATUS_PROG_SCR_FAIL_SHIFT (11UL)
#define OTP_STATUS_PROG_WORD_FAIL_MASK (0x400UL)
#define OTP_STATUS_PROG_WORD_FAIL_SHIFT (10UL)
#define OTP_STATUS_INVALID_ADDR_MASK (0x200UL)
#define OTP_STATUS_INVALID_ADDR_SHIFT (9UL)
#define OTP_STATUS_DEBUG_MODE_MASK (0x100UL)
#define OTP_STATUS_DEBUG_MODE_SHIFT (8UL)
#define OTP_STATUS_MST_FSM_ERROR_MASK (0x80UL)
#define OTP_STATUS_MST_FSM_ERROR_SHIFT (7UL)
#define OTP_STATUS_DEBUG_MODE_SET_MASK (0x40UL)
#define OTP_STATUS_DEBUG_MODE_SET_SHIFT (6UL)
#define OTP_STATUS_REF_OK_MASK (0x20UL)
#define OTP_STATUS_REF_OK_SHIFT (5UL)
#define OTP_STATUS_CMD_FAIL_MASK (0x10UL)
#define OTP_STATUS_CMD_FAIL_SHIFT (4UL)
#define OTP_STATUS_FDONE_MASK (0x8UL)
#define OTP_STATUS_FDONE_SHIFT (3UL)
#define OTP_STATUS_PROG_OK_MASK (0x4UL)
#define OTP_STATUS_PROG_OK_SHIFT (2UL)
#define OTP_STATUS_CMD_DONE_MASK (0x2UL)
#define OTP_STATUS_CMD_DONE_SHIFT (1UL)
#define OTP_STATUS_DATA_VALID_MASK (0x1UL)
#define OTP_STATUS_DATA_VALID_SHIFT (0UL)




typedef uint32_t OTP_STATUS_2_TYPE;




typedef uint32_t OTP_CPU_RDATA_TYPE;
#define OTP_CPU_RDATA_RDATA_MASK (0xffffffffUL)
#define OTP_CPU_RDATA_RDATA_SHIFT (0UL)




typedef uint32_t OTP_CPU_RDATA_HI_TYPE;
#define OTP_CPU_RDATA_HI_HI_MASK (0x7fUL)
#define OTP_CPU_RDATA_HI_HI_SHIFT (0UL)




typedef uint32_t OTP_BISR_STATUS_TYPE;




typedef uint32_t OTP_ECC_INTERRUPT_TYPE;
#define OTP_ECC_INTERRUPT_ECC_DED_FLAG_INT_MASK (0x8000UL)
#define OTP_ECC_INTERRUPT_ECC_DED_FLAG_INT_SHIFT (15UL)
#define OTP_ECC_INTERRUPT_ECC_SEC_FLAG_INT_MASK (0x4000UL)
#define OTP_ECC_INTERRUPT_ECC_SEC_FLAG_INT_SHIFT (14UL)
#define OTP_ECC_INTERRUPT_UNUSED_INT_MASK (0x3fffUL)
#define OTP_ECC_INTERRUPT_UNUSED_INT_SHIFT (0UL)




typedef uint32_t OTP_ECC_INTERRUPT_EN_REG_TYPE;
#define OTP_ECC_INTERRUPT_EN_REG_ECC_DED_FLAG_INT_EN_MASK (0x8000UL)
#define OTP_ECC_INTERRUPT_EN_REG_ECC_DED_FLAG_INT_EN_SHIFT (15UL)
#define OTP_ECC_INTERRUPT_EN_REG_ECC_SEC_FLAG_INT_EN_MASK (0x4000UL)
#define OTP_ECC_INTERRUPT_EN_REG_ECC_SEC_FLAG_INT_EN_SHIFT (14UL)
#define OTP_ECC_INTERRUPT_EN_REG_UNUSED_INT_EN_MASK (0x3fffUL)
#define OTP_ECC_INTERRUPT_EN_REG_UNUSED_INT_EN_SHIFT (0UL)




typedef uint32_t OTP_ECC_INTERRUPT_CLR_REG_TYPE;
#define OTP_ECC_INTERRUPT_CLR_REG_ECC_DED_FLAG_INT_CLR_MASK (0x8000UL)
#define OTP_ECC_INTERRUPT_CLR_REG_ECC_DED_FLAG_INT_CLR_SHIFT (15UL)
#define OTP_ECC_INTERRUPT_CLR_REG_ECC_SEC_FLAG_INT_CLR_MASK (0x4000UL)
#define OTP_ECC_INTERRUPT_CLR_REG_ECC_SEC_FLAG_INT_CLR_SHIFT (14UL)
#define OTP_ECC_INTERRUPT_CLR_REG_UNUSED_INT_CLR_MASK (0x3fffUL)
#define OTP_ECC_INTERRUPT_CLR_REG_UNUSED_INT_CLR_SHIFT (0UL)




typedef uint32_t OTP_FOUT_DATA0_TYPE;
#define OTP_FOUT_DATA0_DATA0_MASK (0xffffffffUL)
#define OTP_FOUT_DATA0_DATA0_SHIFT (0UL)




typedef uint32_t OTP_FOUT_DATA1_TYPE;
#define OTP_FOUT_DATA1_DATA1_MASK (0xffffffffUL)
#define OTP_FOUT_DATA1_DATA1_SHIFT (0UL)




typedef uint32_t OTP_FOUT_DATA2_TYPE;
#define OTP_FOUT_DATA2_DATA2_MASK (0xffffffffUL)
#define OTP_FOUT_DATA2_DATA2_SHIFT (0UL)




typedef uint32_t OTP_FOUT_DATA3_TYPE;
#define OTP_FOUT_DATA3_DATA3_MASK (0xffffffffUL)
#define OTP_FOUT_DATA3_DATA3_SHIFT (0UL)




typedef uint32_t OTP_FOUT_DATA4_TYPE;
#define OTP_FOUT_DATA4_DATA4_MASK (0xffffffffUL)
#define OTP_FOUT_DATA4_DATA4_SHIFT (0UL)




typedef uint32_t OTP_FOUT_DATA5_TYPE;
#define OTP_FOUT_DATA5_DATA5_MASK (0xffffffffUL)
#define OTP_FOUT_DATA5_DATA5_SHIFT (0UL)




typedef uint32_t OTP_FOUT_DATA6_TYPE;
#define OTP_FOUT_DATA6_DATA6_MASK (0xffffffffUL)
#define OTP_FOUT_DATA6_DATA6_SHIFT (0UL)




typedef uint32_t OTP_FOUT_DATA7_TYPE;
#define OTP_FOUT_DATA7_DATA7_MASK (0xffffffffUL)
#define OTP_FOUT_DATA7_DATA7_SHIFT (0UL)




typedef uint32_t OTP_FOUT_DATA8_TYPE;
#define OTP_FOUT_DATA8_DATA8_MASK (0xffffffffUL)
#define OTP_FOUT_DATA8_DATA8_SHIFT (0UL)




typedef uint32_t OTP_FOUT_DATA9_TYPE;
#define OTP_FOUT_DATA9_DATA9_MASK (0xffffffUL)
#define OTP_FOUT_DATA9_DATA9_SHIFT (0UL)




typedef uint32_t OTP_SRIOV_CONFIG_TYPE;
#define OTP_SRIOV_CONFIG_CONFIG_MASK (0xffUL)
#define OTP_SRIOV_CONFIG_CONFIG_SHIFT (0UL)




typedef uint32_t OTP_SPARE_REG1_TYPE;
#define OTP_SPARE_REG1_REG1_MASK (0x7fffUL)
#define OTP_SPARE_REG1_REG1_SHIFT (0UL)




typedef uint32_t OTP_SPARE_REG2_TYPE;
#define OTP_SPARE_REG2_REG2_MASK (0xffffffffUL)
#define OTP_SPARE_REG2_REG2_SHIFT (0UL)




typedef uint32_t OTP_SPARE_REG3_TYPE;
#define OTP_SPARE_REG3_REG3_MASK (0xffffffffUL)
#define OTP_SPARE_REG3_REG3_SHIFT (0UL)




typedef volatile struct COMP_PACKED sOTP_RDBType {
    OTP_CPU_COMMAND_TYPE cpu_command; /* OFFSET: 0x0 */
    OTP_CPU_WRDATA_TYPE cpu_wrdata; /* OFFSET: 0x4 */
    OTP_CPU_WRDATA_HI_TYPE cpu_wrdata_hi; /* OFFSET: 0x8 */
    OTP_CONFIG_TYPE config; /* OFFSET: 0xc */
    OTP_ADDRESS_TYPE address; /* OFFSET: 0x10 */
    OTP_STATUS_TYPE status; /* OFFSET: 0x14 */
    OTP_STATUS_2_TYPE status_2; /* OFFSET: 0x18 */
    OTP_CPU_RDATA_TYPE cpu_rdata; /* OFFSET: 0x1c */
    OTP_CPU_RDATA_HI_TYPE cpu_rdata_hi; /* OFFSET: 0x20 */
    OTP_BISR_STATUS_TYPE bisr_status; /* OFFSET: 0x24 */
    OTP_ECC_INTERRUPT_TYPE ecc_interrupt; /* OFFSET: 0x28 */
    OTP_ECC_INTERRUPT_EN_REG_TYPE ecc_interrupt_en_reg; /* OFFSET: 0x2c */
    OTP_ECC_INTERRUPT_CLR_REG_TYPE ecc_interrupt_clr_reg; /* OFFSET: 0x30 */
    OTP_FOUT_DATA0_TYPE fout_data0; /* OFFSET: 0x34 */
    OTP_FOUT_DATA1_TYPE fout_data1; /* OFFSET: 0x38 */
    OTP_FOUT_DATA2_TYPE fout_data2; /* OFFSET: 0x3c */
    OTP_FOUT_DATA3_TYPE fout_data3; /* OFFSET: 0x40 */
    OTP_FOUT_DATA4_TYPE fout_data4; /* OFFSET: 0x44 */
    OTP_FOUT_DATA5_TYPE fout_data5; /* OFFSET: 0x48 */
    OTP_FOUT_DATA6_TYPE fout_data6; /* OFFSET: 0x4c */
    OTP_FOUT_DATA7_TYPE fout_data7; /* OFFSET: 0x50 */
    OTP_FOUT_DATA8_TYPE fout_data8; /* OFFSET: 0x54 */
    OTP_FOUT_DATA9_TYPE fout_data9; /* OFFSET: 0x58 */
    OTP_SRIOV_CONFIG_TYPE sriov_config; /* OFFSET: 0x5c */
    OTP_SPARE_REG1_TYPE spare_reg1; /* OFFSET: 0x60 */
    OTP_SPARE_REG2_TYPE spare_reg2; /* OFFSET: 0x64 */
    OTP_SPARE_REG3_TYPE spare_reg3; /* OFFSET: 0x68 */
} OTP_RDBType;


#define OTP_BASE                        (0x4C012000UL)



#define OTP_MAX_HW_ID                   (1UL)

#endif /* OTP_RDB_H */