#!/usr/bin/python2

# $Id$
# $Copyright: Copyright 2021 Broadcom Limited.
# This program is the proprietary software of Broadcom Limited
# and/or its licensors, and may only be used, duplicated, modified
# or distributed pursuant to the terms and conditions of a separate,
# written license agreement executed between you and Broadcom
# (an "Authorized License").  Except as set forth in an Authorized
# License, Broadcom grants no license (express or implied), right
# to use, or waiver of any kind with respect to the Software, and
# Broadcom expressly reserves all rights in and to the Software
# and all intellectual property rights therein.  IF YOU HAVE
# NO AUTHORIZED LICENSE, THEN YOU HAVE NO RIGHT TO USE THIS SOFTWARE
# IN ANY WAY, AND SHOULD IMMEDIATELY NOTIFY BROADCOM AND DISCONTINUE
# ALL USE OF THE SOFTWARE.
#
# Except as expressly set forth in the Authorized License,
#
# 1.     This program, including its structure, sequence and organization,
# constitutes the valuable trade secrets of Broadcom, and you shall use
# all reasonable efforts to protect the confidentiality thereof,
# and to use this information only in connection with your use of
# Broadcom integrated circuit products.
#
# 2.     TO THE MAXIMUM EXTENT PERMITTED BY LAW, THE SOFTWARE IS
# PROVIDED "AS IS" AND WITH ALL FAULTS AND BROADCOM MAKES NO PROMISES,
# REPRESENTATIONS OR WARRANTIES, EITHER EXPRESS, IMPLIED, STATUTORY,
# OR OTHERWISE, WITH RESPECT TO THE SOFTWARE.  BROADCOM SPECIFICALLY
# DISCLAIMS ANY AND ALL IMPLIED WARRANTIES OF TITLE, MERCHANTABILITY,
# NONINFRINGEMENT, FITNESS FOR A PARTICULAR PURPOSE, LACK OF VIRUSES,
# ACCURACY OR COMPLETENESS, QUIET ENJOYMENT, QUIET POSSESSION OR
# CORRESPONDENCE TO nameRIPTION. YOU ASSUME THE ENTIRE RISK ARISING
# OUT OF USE OR PERFORMANCE OF THE SOFTWARE.
#
# 3.     TO THE MAXIMUM EXTENT PERMITTED BY LAW, IN NO EVENT SHALL
# BROADCOM OR ITS LICENSORS BE LIABLE FOR (i) CONSEQUENTIAL,
# INCIDENTAL, SPECIAL, INDIRECT, OR EXEMPLARY DAMAGES WHATSOEVER
# ARISING OUT OF OR IN ANY WAY RELATING TO YOUR USE OF OR INABILITY
# TO USE THE SOFTWARE EVEN IF BROADCOM HAS BEEN ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGES; OR (ii) ANY AMOUNT IN EXCESS OF
# THE AMOUNT ACTUALLY PAID FOR THE SOFTWARE ITSELF OR USD 1.00,
# WHICHEVER IS GREATER. THESE LIMITATIONS SHALL APPLY NOTWITHSTANDING
# ANY FAILURE OF ESSENTIAL PURPOSE OF ANY LIMITED REMEDY.$
####################################################################################

import os
import sys
import time
from otp_header import *

#======================== RDB ==========================

OTP_CPU_COMMAND_OPCODE_MASK = 0x3f
OTP_CPU_COMMAND_OPCODE_SHIFT = 0

OTP_CPU_WRDATA_WRDATA_MASK = 0xffffffff
OTP_CPU_WRDATA_WRDATA_SHIFT = 0

OTP_CPU_WRDATA_HI_HI_MASK = 0x7f
OTP_CPU_WRDATA_HI_HI_SHIFT = 0

OTP_CONFIG_OTP_DMAC_ENABLE_MASK = 0x10000
OTP_CONFIG_OTP_DMAC_ENABLE_SHIFT = 16
OTP_CONFIG_SOFT_RESET_MASK = 0x4000
OTP_CONFIG_SOFT_RESET_SHIFT = 14
OTP_CONFIG_SRIOV_ENABLE_MASK = 0x1000
OTP_CONFIG_SRIOV_ENABLE_SHIFT = 12
OTP_CONFIG_OTP_M7_DEV_MODE_ENABLE_MASK = 0x800
OTP_CONFIG_OTP_M7_DEV_MODE_ENABLE_SHIFT = 11
OTP_CONFIG_SM_EN_PLL_RESET_MASK = 0x400
OTP_CONFIG_SM_EN_PLL_RESET_SHIFT = 10
OTP_CONFIG_OTP_DEV_MODE_ENABLE_MASK = 0x200
OTP_CONFIG_OTP_DEV_MODE_ENABLE_SHIFT = 9
OTP_CONFIG_OTP_PCIE_ENABLE_MASK = 0x100
OTP_CONFIG_OTP_PCIE_ENABLE_SHIFT = 8
OTP_CONFIG_OTP_CPU_JTAG_ENABLE_MASK = 0x80
OTP_CONFIG_OTP_CPU_JTAG_ENABLE_SHIFT = 7
OTP_CONFIG_OTP_OTP_JTAG_ENABLE_MASK = 0x40
OTP_CONFIG_OTP_OTP_JTAG_ENABLE_SHIFT = 6
OTP_CONFIG_OTP_MDIO_SLV_ENABLE_MASK = 0x20
OTP_CONFIG_OTP_MDIO_SLV_ENABLE_SHIFT = 5
OTP_CONFIG_OTP_SECURITY_MONITOR_ENABLE_MASK = 0x10
OTP_CONFIG_OTP_SECURITY_MONITOR_ENABLE_SHIFT = 4
OTP_CONFIG_OTP_SPI_SLV_ENABLE_MASK = 0x8
OTP_CONFIG_OTP_SPI_SLV_ENABLE_SHIFT = 3
OTP_CONFIG_OTP_CMD_WR_MASK = 0x4
OTP_CONFIG_OTP_CMD_WR_SHIFT = 2
OTP_CONFIG_OTP_CMD_MODE_MASK = 0x2
OTP_CONFIG_OTP_CMD_MODE_SHIFT = 1
OTP_CONFIG_DIS_OTP_ACC_MASK = 0x1
OTP_CONFIG_DIS_OTP_ACC_SHIFT = 0

OTP_ADDRESS_ADDRESS_MASK = 0x3ff
OTP_ADDRESS_ADDRESS_SHIFT = 0

OTP_STATUS_ECC_DED_FLAG_STATUS_MASK = 0x800000
OTP_STATUS_ECC_DED_FLAG_STATUS_SHIFT = 23
OTP_STATUS_ECC_SEC_FLAG_STATUS_MASK = 0x400000
OTP_STATUS_ECC_SEC_FLAG_STATUS_SHIFT = 22
OTP_STATUS_PRESCREEN_FAIL_MASK = 0x100000
OTP_STATUS_PRESCREEN_FAIL_SHIFT = 20
OTP_STATUS_ILLEGAL_ADDR_MASK = 0x80000
OTP_STATUS_ILLEGAL_ADDR_SHIFT = 19
OTP_STATUS_MAX_SW_MASK = 0x40000
OTP_STATUS_MAX_SW_SHIFT = 18
OTP_STATUS_AUTO_RW_MAX_MASK = 0x20000
OTP_STATUS_AUTO_RW_MAX_SHIFT = 17
OTP_STATUS_MAX_RWP_MASK = 0x10000
OTP_STATUS_MAX_RWP_SHIFT = 16
OTP_STATUS_MAX_RW_MASK = 0x8000
OTP_STATUS_MAX_RW_SHIFT = 15
OTP_STATUS_PG_WD_FP_FAIL_MASK = 0x4000
OTP_STATUS_PG_WD_FP_FAIL_SHIFT = 14
OTP_STATUS_PROG_EN_MASK = 0x2000
OTP_STATUS_PROG_EN_SHIFT = 13
OTP_STATUS_PROG_BLK_CMD_MASK = 0x1000
OTP_STATUS_PROG_BLK_CMD_SHIFT = 12
OTP_STATUS_PROG_SCR_FAIL_MASK = 0x800
OTP_STATUS_PROG_SCR_FAIL_SHIFT = 11
OTP_STATUS_PROG_WORD_FAIL_MASK = 0x400
OTP_STATUS_PROG_WORD_FAIL_SHIFT = 10
OTP_STATUS_INVALID_ADDR_MASK = 0x200
OTP_STATUS_INVALID_ADDR_SHIFT = 9
OTP_STATUS_DEBUG_MODE_MASK = 0x100
OTP_STATUS_DEBUG_MODE_SHIFT = 8
OTP_STATUS_MST_FSM_ERROR_MASK = 0x80
OTP_STATUS_MST_FSM_ERROR_SHIFT = 7
OTP_STATUS_DEBUG_MODE_SET_MASK = 0x40
OTP_STATUS_DEBUG_MODE_SET_SHIFT = 6
OTP_STATUS_REF_OK_MASK = 0x20
OTP_STATUS_REF_OK_SHIFT = 5
OTP_STATUS_CMD_FAIL_MASK = 0x10
OTP_STATUS_CMD_FAIL_SHIFT = 4
OTP_STATUS_FDONE_MASK = 0x8
OTP_STATUS_FDONE_SHIFT = 3
OTP_STATUS_PROG_OK_MASK = 0x4
OTP_STATUS_PROG_OK_SHIFT = 2
OTP_STATUS_CMD_DONE_MASK = 0x2
OTP_STATUS_CMD_DONE_SHIFT = 1
OTP_STATUS_DATA_VALID_MASK = 0x1
OTP_STATUS_DATA_VALID_SHIFT = 0


OTP_CPU_RDATA_RDATA_MASK = 0xffffffff
OTP_CPU_RDATA_RDATA_SHIFT = 0

OTP_CPU_RDATA_HI_HI_MASK = 0x7f
OTP_CPU_RDATA_HI_HI_SHIFT = 0


OTP_ECC_INTERRUPT_ECC_DED_FLAG_INT_MASK = 0x8000
OTP_ECC_INTERRUPT_ECC_DED_FLAG_INT_SHIFT = 15
OTP_ECC_INTERRUPT_ECC_SEC_FLAG_INT_MASK = 0x4000
OTP_ECC_INTERRUPT_ECC_SEC_FLAG_INT_SHIFT = 14
OTP_ECC_INTERRUPT_UNUSED_INT_MASK = 0x3fff
OTP_ECC_INTERRUPT_UNUSED_INT_SHIFT = 0

OTP_ECC_INTERRUPT_EN_REG_ECC_DED_FLAG_INT_EN_MASK = 0x8000
OTP_ECC_INTERRUPT_EN_REG_ECC_DED_FLAG_INT_EN_SHIFT = 15
OTP_ECC_INTERRUPT_EN_REG_ECC_SEC_FLAG_INT_EN_MASK = 0x4000
OTP_ECC_INTERRUPT_EN_REG_ECC_SEC_FLAG_INT_EN_SHIFT = 14
OTP_ECC_INTERRUPT_EN_REG_UNUSED_INT_EN_MASK = 0x3fff
OTP_ECC_INTERRUPT_EN_REG_UNUSED_INT_EN_SHIFT = 0

OTP_ECC_INTERRUPT_CLR_REG_ECC_DED_FLAG_INT_CLR_MASK = 0x8000
OTP_ECC_INTERRUPT_CLR_REG_ECC_DED_FLAG_INT_CLR_SHIFT = 15
OTP_ECC_INTERRUPT_CLR_REG_ECC_SEC_FLAG_INT_CLR_MASK = 0x4000
OTP_ECC_INTERRUPT_CLR_REG_ECC_SEC_FLAG_INT_CLR_SHIFT = 14
OTP_ECC_INTERRUPT_CLR_REG_UNUSED_INT_CLR_MASK = 0x3fff
OTP_ECC_INTERRUPT_CLR_REG_UNUSED_INT_CLR_SHIFT = 0

OTP_FOUT_DATA0_DATA0_MASK = 0xffffffff
OTP_FOUT_DATA0_DATA0_SHIFT = 0

OTP_FOUT_DATA1_DATA1_MASK = 0xffffffff
OTP_FOUT_DATA1_DATA1_SHIFT = 0

OTP_FOUT_DATA2_DATA2_MASK = 0xffffffff
OTP_FOUT_DATA2_DATA2_SHIFT = 0

OTP_FOUT_DATA3_DATA3_MASK = 0xffffffff
OTP_FOUT_DATA3_DATA3_SHIFT = 0

OTP_FOUT_DATA4_DATA4_MASK = 0xffffffff
OTP_FOUT_DATA4_DATA4_SHIFT = 0

OTP_FOUT_DATA5_DATA5_MASK = 0xffffffff
OTP_FOUT_DATA5_DATA5_SHIFT = 0

OTP_FOUT_DATA6_DATA6_MASK = 0xffffffff
OTP_FOUT_DATA6_DATA6_SHIFT = 0

OTP_FOUT_DATA7_DATA7_MASK = 0xffffffff
OTP_FOUT_DATA7_DATA7_SHIFT = 0

OTP_FOUT_DATA8_DATA8_MASK = 0xffffffff
OTP_FOUT_DATA8_DATA8_SHIFT = 0

OTP_FOUT_DATA9_DATA9_MASK = 0xffffff
OTP_FOUT_DATA9_DATA9_SHIFT = 0

OTP_SRIOV_CONFIG_CONFIG_MASK = 0xff
OTP_SRIOV_CONFIG_CONFIG_SHIFT = 0

OTP_SPARE_REG1_REG1_MASK = 0x7fff
OTP_SPARE_REG1_REG1_SHIFT = 0

OTP_SPARE_REG2_REG2_MASK = 0xffffffff
OTP_SPARE_REG2_REG2_SHIFT = 0

OTP_SPARE_REG3_REG3_MASK = 0xffffffff
OTP_SPARE_REG3_REG3_SHIFT = 0

class OTP_RDBType:
    cpu_command             = 0x0
    cpu_wrdata              = 0x4
    cpu_wrdata_hi           = 0x8
    config                  = 0xc
    address                 = 0x10
    status                  = 0x14
    status_2                = 0x18
    cpu_rdata               = 0x1c
    cpu_rdata_hi            = 0x20
    bisr_status             = 0x24
    ecc_interrupt           = 0x28
    ecc_interrupt_en_reg    = 0x2c
    ecc_interrupt_clr_reg   = 0x30
    fout_data0              = 0x34
    fout_data1              = 0x38
    fout_data2              = 0x3c
    fout_data3              = 0x40
    fout_data4              = 0x44
    fout_data5              = 0x48
    fout_data6              = 0x4c
    fout_data7              = 0x50
    fout_data8              = 0x54
    fout_data9              = 0x58
    sriov_config            = 0x5c
    spare_reg1              = 0x60
    spare_reg2              = 0x64
    spare_reg3              = 0x68

OTP_BASE                        = 0x4C012000
OTP_MAX_HW_ID                   = 1

#======================= Variables =====================
ENABLE_OTP_WRITE_OPERATION      = True
OTP_ADDR_START                  = 0
OTP_ADDR_END                    = 640
OTP_BYTES_PER_ROW               = 4
OTP_DATA_MASK_WITH_ECC          = 0xFFFFFFFF
OTP_ECC_BITS                    = 7
OTP_ADDR_BRCM_REG_START         = 7
OTP_SEC_BOOT_EN_ROW             = 96
OTP_SEC_BOOT_EN_MASK            = 0x1
OTP_PUBKEY_VALID_COUNT          = 2
OTP_ADDR_RSA_KEY0_INVAL         = 16
OTP_ADDR_RSA_KEY0_START         = 97
OTP_ADDR_RSA_KEY1_INVAL         = 17
OTP_ADDR_RSA_KEY1_START         = 161
OTP_SECURE_KEY_SIZE             = 256
OTP_DECRYPT_EN_ROW              = 225
OTP_DECRYPTKEY_VALID_COUNT      = 8
OTP_ADDR_DECRYPT_KEY0_INVAL     = 18
OTP_ADDR_DECRYPT_KEY0_START     = 226
OTP_ADDR_DECRYPT_KEY1_INVAL     = 19
OTP_ADDR_DECRYPT_KEY1_START     = 234
OTP_ADDR_DECRYPT_KEY2_INVAL     = 20
OTP_ADDR_DECRYPT_KEY2_START     = 242
OTP_ADDR_DECRYPT_KEY3_INVAL     = 21
OTP_ADDR_DECRYPT_KEY3_START     = 250
OTP_ADDR_DECRYPT_KEY4_INVAL     = 22
OTP_ADDR_DECRYPT_KEY4_START     = 258
OTP_ADDR_DECRYPT_KEY5_INVAL     = 23
OTP_ADDR_DECRYPT_KEY5_START     = 266
OTP_ADDR_DECRYPT_KEY6_INVAL     = 24
OTP_ADDR_DECRYPT_KEY6_START     = 274
OTP_ADDR_DECRYPT_KEY7_INVAL     = 25
OTP_ADDR_DECRYPT_KEY7_START     = 282
OTP_DECRYPT_KEY_SIZE            = 32
OTP_STACKINGINFO_ROW_ADDR       = 290
OTP_MAC_VALID_COUNT             = 2
OTP_ADDR_MAC0_INVAL             = 26
OTP_MAC_ADDR_0_OCTET123_ADDR    = 294
OTP_MAC_ADDR_0_OCTET456_ADDR    = 295
OTP_MAC_ADDR_1_OCTET123_ADDR    = 296
OTP_MAC_ADDR_1_OCTET456_ADDR    = 297
OTP_IPCFG_VALID_COUNT           = 2
OTP_ADDR_IP0_INVAL              = 27
OTP_ADDR_IP0_START              = 298
OTP_ADDR_IP1_INVAL              = 28
OTP_ADDR_IP1_START              = 302
OTP_ADDR_TC10_START             = 306
OTP_TC10_CONFIG_SIZE            = 144
OTP_ADDR_XCVR_START             = 342
OTP_XCVR_CONFIG_SIZE            = 1024

OTP_CPUCMDOPCODE_READ             = 0x00      # OTP cpu command opcode - read */
OTP_CPUCMDOPCODE_PROG_ENABLE      = 0x02      # OTP cpu command opcode - Programming enable */
OTP_CPUCMDOPCODE_PROG_DISABLE     = 0x03      # OTP cpu command opcode - programming disable */
OTP_CPUCMDOPCODE_PRESCREEN        = 0x04      # OTP cpu command opcode - prescreen */
OTP_CPUCMDOPCODE_PROGRAM          = 0x0A      # OTP cpu command opcode - program */

OTP_PROG_EN_SEQ1            = 0x0F
OTP_PROG_EN_SEQ2            = 0x04
OTP_PROG_EN_SEQ3            = 0x08
OTP_PROG_EN_SEQ4            = 0x0D
OTP_CMD_DELAY_NS            = 200
OTP_PROG_TIMEOUT_CNT        = 10000
OTP_CMD_TIMEOUT_CNT         = 10000

# OTP driver state type
OTP_DRVSTATE_UNINIT     = 0         # OTP driver state - Uninitialised & value must be zero
OTP_DRVSTATE_INIT       = 1         # OTP driver state - Initialised

DEBUGGER = None

class OTP_DrvRWDevType:
    state = OTP_DRVSTATE_UNINIT

OTP_REGS     = []
OTP_DrvRWDev = []
if OTP_MAX_HW_ID > 0:
    OTP_REGS.append(OTP_BASE)
    OTP_DrvRWDev.append(OTP_DrvRWDevType())
if OTP_MAX_HW_ID > 1:
    print("OTP_MAX_HW_ID > 1 not supported")

#======================= Functions =====================

def OTP_DrvReportError(aFunc, aVal):
    print("Error in function " + aFunc + " - " + str(aVal))

def BCM_CpuNDelay(aValue):
    time.sleep(aValue / (100.0 * 100.0 * 100.0))


def OTP_DrvSendCmd(aID, aCmd, aAddr):
    retVal = BCM_ERR_OK
    timeout = OTP_CMD_TIMEOUT_CNT

    DEBUGGER.regWrite(OTP_REGS[aID] + OTP_RDBType.config, OTP_CONFIG_OTP_CMD_MODE_MASK)
    # write the cmd and address
    DEBUGGER.regWrite(OTP_REGS[aID] + OTP_RDBType.cpu_command, aCmd)
    DEBUGGER.regWrite(OTP_REGS[aID] + OTP_RDBType.address, aAddr)

    # enable cmd write
    reg = DEBUGGER.regRead(OTP_REGS[aID] + OTP_RDBType.config)
    reg |= OTP_CONFIG_OTP_CMD_WR_MASK
    DEBUGGER.regWrite(OTP_REGS[aID] + OTP_RDBType.config, reg)


    # After issuing the command, OTP
    # needs initial delay of 200ns
    # before starting to poll on
    # DONE bit
    BCM_CpuNDelay(OTP_CMD_DELAY_NS)


    # wait for cmd to complete
    while (timeout > 0):
        reg = DEBUGGER.regRead(OTP_REGS[aID] + OTP_RDBType.status)
        if ((reg & OTP_STATUS_CMD_DONE_MASK) == OTP_STATUS_CMD_DONE_MASK):
            break
        BCM_CpuNDelay(OTP_CMD_DELAY_NS)
        timeout -= 1
    # clear the command
    DEBUGGER.regWrite(OTP_REGS[aID] + OTP_RDBType.config, OTP_CONFIG_OTP_CMD_MODE_MASK)

    if timeout == 0:
        retVal = BCM_ERR_TIME_OUT

    return retVal

def OTP_DrvProgEnable(aID):
    timeout = OTP_PROG_TIMEOUT_CNT

    # SEQ 1
    DEBUGGER.regWrite(OTP_REGS[aID] + OTP_RDBType.cpu_wrdata, OTP_PROG_EN_SEQ1)
    retVal = OTP_DrvSendCmd(aID, OTP_CPUCMDOPCODE_PROG_ENABLE , 0)
    if (retVal != BCM_ERR_OK):
        return retVal

    # SEQ 2
    DEBUGGER.regWrite(OTP_REGS[aID] + OTP_RDBType.cpu_wrdata, OTP_PROG_EN_SEQ2)
    retVal = OTP_DrvSendCmd(aID, OTP_CPUCMDOPCODE_PROG_ENABLE , 0)
    if (retVal != BCM_ERR_OK):
        return retVal

    # SEQ 3
    DEBUGGER.regWrite(OTP_REGS[aID] + OTP_RDBType.cpu_wrdata, OTP_PROG_EN_SEQ3)
    retVal = OTP_DrvSendCmd(aID, OTP_CPUCMDOPCODE_PROG_ENABLE , 0)
    if (retVal != BCM_ERR_OK):
        return retVal

    # SEQ 4
    DEBUGGER.regWrite(OTP_REGS[aID] + OTP_RDBType.cpu_wrdata, OTP_PROG_EN_SEQ4)
    retVal = OTP_DrvSendCmd(aID, OTP_CPUCMDOPCODE_PROG_ENABLE , 0)
    if (retVal != BCM_ERR_OK):
        return retVal

    # wait for ProgOK signal
    while (timeout > 0):
        reg = DEBUGGER.regRead(OTP_REGS[aID] + OTP_RDBType.status)
        if ((reg & OTP_STATUS_PROG_OK_MASK) == OTP_STATUS_PROG_OK_MASK):
            break
        BCM_CpuNDelay(OTP_CMD_DELAY_NS)
        timeout -= 1

    if (timeout == 0):
        retVal = BCM_ERR_TIME_OUT
        OTP_DrvReportError("OTP_DrvProgEnable", retVal)

    return retVal;

def OTP_DrvProgDisable(aID):
    timeout = OTP_PROG_TIMEOUT_CNT

    # send prog disable command and wait for the
    # ProgOK signal to become low
    retVal = OTP_DrvSendCmd(aID, OTP_CPUCMDOPCODE_PROG_DISABLE, 0)
    if (BCM_ERR_OK == retVal):
        while (timeout > 0):
            reg = DEBUGGER.regRead(OTP_REGS[aID] + OTP_RDBType.status)
            if ((reg & OTP_STATUS_PROG_OK_MASK) == 0):
                break
            BCM_CpuNDelay(OTP_CMD_DELAY_NS);
            timeout -= 1

        if (timeout == 0):
            OTP_DrvReportError("OTP_DrvProgDisable", BCM_ERR_TIME_OUT)


def OTP_DrvRead(aID, aAddr, aData):
    retVal = BCM_ERR_OK
    if (aID >= OTP_MAX_HW_ID or len(aData) > 0 or aAddr > OTP_ADDR_END):
        retVal = BCM_ERR_INVAL_PARAMS
        return retVal

    if (aAddr <= OTP_ADDR_BRCM_REG_START):
        retVal = BCM_ERR_INVAL_PARAMS
        return retVal

    retVal = OTP_DrvSendCmd(aID, OTP_CPUCMDOPCODE_READ, aAddr)
    if (retVal != BCM_ERR_OK):
        return retVal

    # is there a double-bit error?
    # Data may not be valid in double
    # bit errors
    regVal = DEBUGGER.regRead(OTP_REGS[aID] + OTP_RDBType.status)
    if ((regVal & OTP_STATUS_ECC_DED_FLAG_STATUS_MASK) == OTP_STATUS_ECC_DED_FLAG_STATUS_MASK):
        retVal = BCM_ERR_DATA_INTEG
        return retVal

    aData.append(DEBUGGER.regRead(OTP_REGS[aID] + OTP_RDBType.cpu_rdata) & OTP_CPU_RDATA_RDATA_MASK)
    return retVal

def OTP_DrvWrite(aID, aAddr, aData):
    retVal = BCM_ERR_OK

    if len(aData) == 0 or len(aData) > 1:
        retVal = BCM_ERR_INVAL_PARAMS
        return retVal

    if (aID >= OTP_MAX_HW_ID or aAddr > OTP_ADDR_END):
        retVal = BCM_ERR_INVAL_PARAMS
        return retVal

    if aAddr <= OTP_ADDR_BRCM_REG_START:
        retVal = BCM_ERR_INVAL_PARAMS
        return retVal

    retVal = OTP_DrvProgEnable(aID)
    if retVal != BCM_ERR_OK:
        OTP_DrvProgDisable(aID)
        return retVal

    # write data to OTP register
    DEBUGGER.regWrite(OTP_REGS[aID] + OTP_RDBType.cpu_wrdata, aData[0] & OTP_CPU_WRDATA_WRDATA_MASK)
    DEBUGGER.regWrite(OTP_REGS[aID] + OTP_RDBType.cpu_wrdata_hi, 0)

    retVal = OTP_DrvSendCmd(aID, OTP_CPUCMDOPCODE_PROGRAM, aAddr)
    if (BCM_ERR_OK != retVal):
        OTP_DrvProgDisable(aID)
        return retVal

    reg = DEBUGGER.regRead(OTP_REGS[aID] + OTP_RDBType.status)
    if ((reg & OTP_STATUS_CMD_FAIL_MASK) == OTP_STATUS_CMD_FAIL_MASK):
        retVal = BCM_ERR_UNKNOWN

    OTP_DrvProgDisable(aID)
    return retVal


def OTP_SysCmdHandler(aMagicID, aCmd, aSysIO, aDebugger):
    global DEBUGGER
    DEBUGGER = aDebugger
    retVal = BCM_ERR_INVAL_PARAMS

    if aSysIO != None:
        if aMagicID == SVC_MAGIC_OTP_ID:
            if aCmd == OTP_IO_CMD_READ:
                retVal = OTP_DrvRead(aSysIO.hwID, aSysIO.addr, aSysIO.data)
            elif aCmd == OTP_IO_CMD_WRITE and ENABLE_OTP_WRITE_OPERATION:
                retVal = OTP_DrvWrite(aSysIO.hwID, aSysIO.addr, aSysIO.data)
        else:
            retVal = BCM_ERR_INVAL_MAGIC

    aSysIO.retVal = retVal

    if BCM_ERR_OK != retVal:
        OTP_DrvReportError("OTP_SysCmdHandler", retVal)
