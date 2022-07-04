#!/usr/bin/python3

# $Id$
# $Copyright: Copyright 2020-2021 Broadcom Limited.
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
import ctypes
sys.path.insert(1, os.path.join(os.path.dirname(os.path.realpath(__file__)), 'rdb'))
from common_header import *

# Flash configuration
FLASH_HW_ID_0 = 0
FLASH_HW_ID_1 = 1

# SPI mode
FLASH_SPI_MODE_0 = 1   # SPI mode-0 (CPOL = 0, CPHA = 0)
FLASH_SPI_MODE_1 = 2   # SPI mode-1 (CPOL = 0, CPHA = 1)
FLASH_SPI_MODE_2 = 3   # SPI mode-2 (CPOL = 1, CPHA = 0)
FLASH_SPI_MODE_3 = 4   # SPI mode-3 (CPOL = 1, CPHA = 1)

# Flash Speed
FLASH_SPI_SPEED_25M = 0 # SPI speed = 25MHz
FLASH_SPI_SPEED_50M = 1 # SPI speed = 50MHz
FLASH_SPI_SPEED_66M = 2 # SPI speed = 66MHz
FLASH_SPI_SPEED_80M = 3 # SPI speed = 80MHz

FLASH0_SPEED = FLASH_SPI_SPEED_80M
FLASH1_SPEED = FLASH_SPI_SPEED_25M

# Flash readLane
FLASH_READ_LANE_SINGLE = 1 # Flash single lane read mode
FLASH_READ_LANE_DUAL   = 2 # Flash dual lane read mode
FLASH_READ_LANE_QUAD   = 3 # Flash quad lane read mode

MCU_CLK_CFG_ID_QSPI0_SRC400_80MHZ = 0x40
MCU_CLK_CFG_ID_QSPI0_SRC400_66MHZ = 0x41
MCU_CLK_CFG_ID_QSPI0_SRC400_50MHZ = 0x42
MCU_CLK_CFG_ID_QSPI0_SRC200_25MHZ = 0x43
MCU_CLK_CFG_ID_QSPI1_SRC400_80MHZ = 0x50
MCU_CLK_CFG_ID_QSPI1_SRC400_66MHZ = 0x51
MCU_CLK_CFG_ID_QSPI1_SRC400_50MHZ = 0x52
MCU_CLK_CFG_ID_QSPI1_SRC200_25MHZ = 0x53
MCU_CLK_CFG_ID_QSPI0_SRC250_83MHZ = 0x30
MCU_CLK_CFG_ID_QSPI0_SRC250_62MHZ = 0x31
MCU_CLK_CFG_ID_QSPI0_SRC250_50MHZ = 0x32
MCU_CLK_CFG_ID_QSPI0_SRC250_25MHZ = 0x33

if (FLASH0_SPEED == FLASH_SPI_SPEED_80M):
    FLASH0_CLK_CFG_ID = MCU_CLK_CFG_ID_QSPI0_SRC400_80MHZ
elif (FLASH0_SPEED == FLASH_SPI_SPEED_66M):
    FLASH0_CLK_CFG_ID = MCU_CLK_CFG_ID_QSPI0_SRC400_66MHZ
elif (FLASH0_SPEED == FLASH_SPI_SPEED_50M):
    FLASH0_CLK_CFG_ID = MCU_CLK_CFG_ID_QSPI0_SRC400_50MHZ
elif (FLASH0_SPEED == FLASH_SPI_SPEED_25M):
    FLASH0_CLK_CFG_ID = MCU_CLK_CFG_ID_QSPI0_SRC200_25MHZ
else:
    print('Invalid Flash0 speed')

if (FLASH1_SPEED == FLASH_SPI_SPEED_80M):
    FLASH1_CLK_CFG_ID = MCU_CLK_CFG_ID_QSPI1_SRC400_80MHZ
elif (FLASH1_SPEED == FLASH_SPI_SPEED_66M):
    FLASH1_CLK_CFG_ID = MCU_CLK_CFG_ID_QSPI1_SRC400_66MHZ
elif (FLASH1_SPEED == FLASH_SPI_SPEED_50M):
    FLASH1_CLK_CFG_ID = MCU_CLK_CFG_ID_QSPI1_SRC400_50MHZ
elif (FLASH1_SPEED == FLASH_SPI_SPEED_25M):
    FLASH1_CLK_CFG_ID = MCU_CLK_CFG_ID_QSPI1_SRC200_25MHZ
else:
    print('Invalid flash1 speed')

#-----------------------------------------------------------
#                Chip Specific
# Following Variables will get updated by FLASH_UpdateConfig
#-----------------------------------------------------------
Flash_Config = []
FLASH_RWDev = []
QSPI_REGS = []

FLASH_MAX_HW_ID = None
QSPI_MAX_HW_ID  = None
#===========================================================

# Flash driver state
FLASH_STATE_UNINIT = 0 # Uninit state
FLASH_STATE_INIT   = 1 # Init state

QSPI_Config = {
    "SPIMode"   : 0,    # SPI mode
    "speed"     : 0,    # SPI speed
    "readLane"  : 0     # Read lane config
}

# Flash ID
# Bits 23 - 16: Manufacturer ID,
# Bits 15 - 8: Device ID15-8,
# Bits 7 - 0: Device ID7-0
WINBOND_W25Q16      = 0xEF4015      # Winbond, W25Q16 flash ID
WINBOND_W25Q64CV    = 0xEF4017      # Winbond, W25Q64CV flash ID
MICRON_N25Q512A     = 0x20BA20      # Micron, N25Q512A flash ID
MACRONIX_MX25R32    = 0xc22816      # Micronix, MX25R32F35F flash ID
MACRONIX_MX25L32    = 0xc22016      # Micronix, MX25L3233F flash ID
MICRON_M25P16       = 0x202015      # Micron, M25P16 flash ID
S25FL064P           = 0x010216      # Cypress, S25FL064P flash ID

# List of supported flashes
FLASH_FlsIDTbl =[
        WINBOND_W25Q16,
        WINBOND_W25Q64CV,
        MICRON_N25Q512A,
        MACRONIX_MX25R32,
        MACRONIX_MX25L32,
        MICRON_M25P16,
        S25FL064P
    ]

FLASH_CMD_READ          = 0x03 # Read
FLASH_CMD_FAST_READ     = 0x0B # Fast read
FLASH_CMD_RDID          = 0x9F # Read ID
FLASH_CMD_WREN          = 0x06 # Write enable
FLASH_CMD_WRDI          = 0x04 # Write disable
FLASH_CMD_RDSR          = 0x05 # Read status
FLASH_CMD_RCFR          = 0x35 # Read configuration
FLASH_CMD_WRSR          = 0x01 # Write status
FLASH_CMD_PP            = 0x02 # Page program
FLASH_CMD_SSE           = 0x20 # Sub-sector erase
FLASH_CMD_SE            = 0xD8 # Sector erase
FLASH_CMD_BE            = 0xC7 # Bulk erase
FLASH_CMD_RES           = 0xAB # Read electronic signature
FLASH_CMD_DOFR          = 0x3B # Dual output fast read
FLASH_CMD_DIOFR         = 0xBB # Dual input/ouput fast read
FLASH_CMD_QOFR          = 0x6B # Quad output fast read
FLASH_CMD_QIOFR         = 0xEB # Quad input/output fast read
FLASH_CMD_READ_FS_REG   = 0x70 # Read flag status register

# Maximum length of flash command supported
FLASH_CMD_MAX_LEN       = 4

# Flag status register bit mask
FLAG_STATUS_PROG_ERASE_CONTR_MASK   = 0x80
FLAG_STATUS_PROTECTION_ERR_MASK     = 0x01
FLAG_STATUS_ERASE_ERR_MASK          = 0x20
FLAG_STATUS_PROG_ERR_MASK           = 0x10
FLAG_STATUS_ERR_MASK                = (FLAG_STATUS_PROTECTION_ERR_MASK |\
                                            FLAG_STATUS_ERASE_ERR_MASK |\
                                            FLAG_STATUS_PROG_ERR_MASK)

# Flash status register bit fields
FLASH_STATUS_WIP_MASK   = 0x1   # WIP Bit mask
FLASH_STATUS_WEL_MASK   = 0x2   # WEL Bit mask

DUMMY_DATA              = 0x0

# MSPI FIFO length in bytes
MSPI_FIFO_LEN           = 16

RAF_WORD_LEN            = 4

RAF_WATERMARK_64_WORDS  = 0x0
RAF_WATERMARK_32_WORDS  = 0x1
RAF_WATERMARK_16_WORDS  = 0x2
RAF_WATERMARK_8_WORDS   = 0x3

QSPI_BSPI_TIMEOUT_COUNT = 200
QSPI_MSPI_TIMEOUT_COUNT = 10000

# Macros of SPBR value
SPBR_VAL_1     = 1
SPBR_VAL_2     = 2
SPBR_VAL_8     = 8
SPBR_VAL_32    = 32

# Flags for transfer continuation
QSPI_XFER_STOP      = 0 # Transfer stop flag
QSPI_XFER_CONTINUE  = 1 # Transfer continue flag

# QSPI Registers offsets
BSPI_REVISION_ID                    = 0x0000 # Revision ID
BSPI_SCRATCH                        = 0x0004 # Scratch bits
BSPI_MAST_N_BOOT_CTRL               = 0x0008 # Master/Boot SPI ctrl Reg
BSPI_MAST_N_BOOT_CTRL_BIT_MASK      = 0x00000001
BSPI_MAST_N_BOOT_CTRL_BIT_SHIFT     = 0
BSPI_BUSY_STATUS                    = 0x000C # BSPI Busy Status Reg
BSPI_INTR_STATUS                    = 0x0010 # Interrupt Status Reg
BSPI_B0_STATUS                      = 0x0014 # Prefetch Buffer 0 Status Reg
BSPI_B0_CTRL                        = 0x0018 # Prefetch Buffer 0 ctrl Reg
BSPI_B1_STATUS                      = 0x001C # Prefetch Buffer 1 Status Reg
BSPI_B1_CTRL                        = 0x0020 # Prefetch Buffer 1 ctrl Reg
BSPI_STRAP_OVERRIDE_CTRL            = 0x0024 # Dual/Single Recv Mode Ctrl Reg
BSPI_STRAP_OR_CTRL_OR_MASK          = 0x00000001
BSPI_STRAP_OR_CTRL_OR_SHIFT         = 0
BSPI_STRAP_OR_CTRL_DUAL_SGL_MASK    = 0x00000002
BSPI_STRAP_OR_CTRL_DUAL_SGL_SHIFT   = 1
BSPI_STRAP_OR_CTRL_QUAD_MASK        = 0x00000008
BSPI_STRAP_OR_CTRL_QUAD_SHIFT       = 3
BSPI_FLEX_MODE_ENABLE               = 0x0028 # Flexible Ctrl Mode Enable Reg
BSPI_BITS_PER_CYCLE                 = 0x002C # Bits per cycle b-p-c Ctrl Reg
BSPI_BITS_PER_PHASE                 = 0x0030 # Bits per Phase b-p-p Ctrl Reg
BSPI_CMD_N_MODE_BYTE                = 0x0034 # Command and Mode Data Reg
BSPI_FLASH_UPPER_ADDR               = 0x0038 # Flash upper address byte Reg
BSPI_XOR_VALUE                      = 0x003C # Flash XOR Value Reg
BSPI_XOR_EN                         = 0x0040 # Flash XOR Enable Reg
BSPI_PIO_MODE_EN                    = 0x0044 # Programmed IO Mode Enable Reg
BSPI_PIO_IODIR                      = 0x0048 # Programmed IO Mode Direction Reg
BSPI_PIO_DATA                       = 0x004C # Programmed IO Mode Data Reg
RSVD0_BASE                          = 0x0050 # Reserved 1
RAF_START_ADDR                      = 0x0100 # Physical Starting Address in Flash
RAF_NUM_WORDS                       = 0x0104 # Number of Words to be fetched
RAF_CTRL                            = 0x0108 # RAF Session Control Register
RAF_CTRL_CLEAR_MASK                 = 0x00000002
RAF_CTRL_CLEAR_SHIFT                = 1
RAF_CTRL_START_MASK                 = 0x00000001
RAF_CTRL_START_SHIFT                = 0
RAF_FULLNESS                        = 0x010C # Fullness indicator for RAF buffer
RAF_WATERMARK                       = 0x0110 # RAF buffer interrupt trigger watermark level
RAF_WATERMARK_FULLNESS_MASK         = 0x00000003
RAF_WATERMARK_FULLNESS_SHIFT        = 0
RAF_STATUS                          = 0x0114 # Linear Read Status Register
RAF_STATUS_FIFO_FULL_MASK           = 0x00000004
RAF_STATUS_FIFO_FULL_SHIFT          = 2
RAF_STATUS_FIFO_EMPTY_MASK          = 0x00000002
RAF_STATUS_FIFO_EMPTY_SHIFT         = 1
RAF_STATUS_SESSION_BUSY_MASK        = 0x00000001
RAF_STATUS_SESSION_BUSY_SHIFT       = 0
RAF_READ_DATA                       = 0x0118 # Read data from RAF buffer
RAF_WORD_CNT                        = 0x011C # Current number of words fetched from Flash
RAF_CURR_ADDR                       = 0x0120 # Current read address for linear read session
RSVD1_BASE                          = 0x0124 # Reserved 2
MSPI_SPCR0_LSB                      = 0x0200 # SPCR0_LSB REGISTER
MSPI_SPCR0_LSB_SPBR_MASK            = 0x000000ff
MSPI_SPCR0_LSB_SPBR_SHIFT           = 0
MSPI_SPCR0_MSB                      = 0x0204 # SPCR0_MSB Register
MSPI_SPCR0_MSB_MSTR_MASK            = 0x00000080
MSPI_SPCR0_MSB_MSTR_SHIFT           = 7
MSPI_SPCR0_MSB_CPOL_MASK            = 0x00000002
MSPI_SPCR0_MSB_CPOL_SHIFT           = 1
MSPI_SPCR0_MSB_CPHA_MASK            = 0x00000001
MSPI_SPCR0_MSB_CPHA_SHIFT           = 0
MSPI_SPCR1_LSB                      = 0x0208 # SPCR1_LSB REGISTER
MSPI_SPCR1_MSB                      = 0x020C # SPCR1_MSB REGISTER
MSPI_NEWQP                          = 0x0210 # NEWQP REGISTER
MSPI_ENDQP                          = 0x0214 # ENDQP REGISTER
MSPI_SPCR2                          = 0x0218 # SPCR2 REGISTER
MSPI_SPCR2_CONT_AFTER_CMD_MASK      = 0x00000080
MSPI_SPCR2_CONT_AFTER_CMD_ALIGN     = 0
MSPI_SPCR2_CONT_AFTER_CMD_BITS      = 1
MSPI_SPCR2_CONT_AFTER_CMD_SHIFT     = 7
MSPI_SPCR2_SPE_MASK                 = 0x00000040
MSPI_SPCR2_SPE_SHIFT                = 6
MSPI_SPCR2_SPIFIE_MASK              = 0x00000020
MSPI_SPCR2_SPIFIE_SHIFT             = 5
MSPI_SPCR2_WREN_MASK                = 0x00000010
MSPI_SPCR2_WREN_SHIFT               = 4
MSPI_SPCR2_WRT0_MASK                = 0x00000008
MSPI_SPCR2_WRT0_SHIFT               = 3
MSPI_SPCR2_LOOPQ_MASK               = 0x00000004
MSPI_SPCR2_LOOPQ_SHIFT              = 2
MSPI_SPCR2_HIE_MASK                 = 0x00000002
MSPI_SPCR2_HIE_SHIFT                = 1
MSPI_SPCR2_HALT_MASK                = 0x00000001
MSPI_SPCR2_HALT_SHIFT               = 0
RSVD2_BASE                          = 0x021C
MSPI_STATUS                         = 0x0220 # MSPI STATUS REGISTER
MSPI_STATUS_HALTA_MASK              = 0x00000002
MSPI_STATUS_HALTA_SHIFT             = 1
MSPI_STATUS_SPIF_MASK               = 0x00000001
MSPI_STATUS_SPIF_SHIFT              = 0
MSPI_CPTQP                          = 0x0224 # CPTQP REGISTER
RSVD3_BASE                          = 0x0228
MSPI_TXRAM_BASE                     = 0x0240 # Transmit RAM
MSPI_RXRAM_BASE                     = 0x02C0 # Receive RAM
MSPI_CDRAM_BASE                     = 0x0340 # Command RAM
MSPI_CDRAM_CDRAM_MASK               = 0x000000ff
MSPI_CDRAM_CDRAM_SHIFT              = 0
MSPI_CDRAM_CMD_CONTINUE_MASK        = 0x80
MSPI_CDRAM_CMD_BITS_PER_TRANF_MASK  = 0x40
MSPI_CDRAM_CMD_DT_DELAY_MASK        = 0x20
MSPI_CDRAM_CMD_DSCK_DELAY_MASK      = 0x10
MSPI_CDRAM_CMD_PCS_MASK             = 0x03
MSPI_WRITE_LOCK                     = 0x0380 # Ctrl bit to lock group of write commands
MSPI_WRITE_LOCK_WRITELOCK_MASK      = 0x00000001
MSPI_WRITE_LOCK_WRITELOCK_SHIFT     = 0
MSPI_DIS_FLUSH_GEN                  = 0x0384 # Debug bit to mask MSPI flush signals
MSPI_DIS_FLUSH_GEN_MASK             = 0x00000001
MSPI_DIS_FLUSH_GEN_SHIFT            = 0
RSVD4_BASE                          = 0x0388 # Reserved 3
RAF_LR_FULLNESS_REACHED             = 0x03A0 # Interrupt from RAF sub-block
RAF_LR_FULLNESS_REACHED_MASK        = 0x00000001
RAF_LR_FULLNESS_REACHED_SHIFT       = 0
RAF_LR_TRUNCATED                    = 0x03A4 # Interrupt from RAF sub-block
RAF_LR_TRUNCATED_MASK               = 0x00000001
RAF_LR_TRUNCATED_SHIFT              = 0
RAF_LR_IMPATIENT                    = 0x03A8 # Interrupt from RAF sub-block
RAF_LR_IMPATIENT_MASK               = 0x00000001
RAF_LR_IMPATIENT_SHIFT              = 0
RAF_LR_SESSION_DONE                 = 0x03AC # Interrupt from RAF sub-block
RAF_LR_SESSION_DONE_MASK            = 0x00000001
RAF_LR_SESSION_DONE_SHIFT           = 0
RAF_LR_OVERREAD                     = 0x03B0 # Interrupt from RAF sub-block
RAF_LR_OVERREAD_MASK                = 0x00000001
RAF_LR_OVERREAD_SHIFT               = 0
MSPI_DONE                           = 0x03B4 # Interrupt from MSPI sub-block
MSPI_DONE_MASK                      = 0x00000001
MSPI_DONE_SHIFT                     = 0
MSPI_HALT_SET_TRANS_DONE            = 0x03B8 # Interrupt from MSPI sub-block
MSPI_HALT_SET_TRANS_DONE_MASK       = 0x00000001
MSPI_HALT_SET_TRANS_DONE_ALIGN      = 0
MSPI_HALT_SET_TRANS_DONE_BITS       = 1
MSPI_HALT_SET_TRANS_DONE_SHIFT      = 0

FLASH_ERR_OK     =  0
FLASH_ERR_FAILED = -1

def FLASH_ReportError(aMsg, aRetVal):
    print("[Error : {}] {}".format(aRetVal, aMsg))

def FLASH_UpdateConfig(aFlashMaxHwId, aQspiMaxHwId, aQspiBase0, aQspiBase1):
    global FLASH_MAX_HW_ID, QSPI_MAX_HW_ID
    FLASH_MAX_HW_ID = aFlashMaxHwId
    QSPI_MAX_HW_ID  = aQspiMaxHwId
    if aQspiBase0:
        QSPI_REGS.append(aQspiBase0)
    if aQspiBase1:
        QSPI_REGS.append(aQspiBase1)

class FLASH_QSPI:
    def __init__(self, aDebugger):
        self.debugger = aDebugger
        self.status   = FLASH_ERR_OK

    def _regRead(self, aId, aRegOffset):
        ret = self.debugger.readReg((QSPI_REGS[aId] + aRegOffset), 1, 4)
        if ret == None:
            self.status = FLASH_ERR_FAILED
        return ret

    def _regWrite(self, aId, aRegOffset, aValue):
        ret = self.debugger.writeReg((QSPI_REGS[aId] + aRegOffset), aValue, 4)
        if ret != FLASH_ERR_OK:
            self.status = FLASH_ERR_FAILED

    def _regWriteAnd(self, aId, aRegOffset, aBitMask):
        value = self._regRead(aId, aRegOffset)
        if self.status == FLASH_ERR_OK:
            value &= aBitMask
            self._regWrite(aId, aRegOffset, value)

    def _regWriteOr(self, aId, aRegOffset, aBitMask):
        value = self._regRead(aId, aRegOffset)
        if self.status == FLASH_ERR_OK:
            value |= aBitMask
            self._regWrite(aId, aRegOffset, value)

    def _WaitQSPI(self, aId, aReg, aMask, aIsCompEqZero, aTimeOutCnt):
        i = aTimeOutCnt
        retVal = BCM_ERR_OK
        while (i > 0):
            regVal = self._regRead(aId, aReg)
            if self.status == FLASH_ERR_FAILED:
                return self.status
            if (aIsCompEqZero == True):
                if ((regVal & aMask) != 0):
                    break
            else:
                if ((regVal & aMask) == 0):
                    break
            i -= 1

        if (i == 0):
            retVal = BCM_ERR_TIME_OUT

        return retVal

    def _RafStop(self, aId):
        # Stop RAF read session
        self._regWriteAnd(aId, RAF_CTRL, ~RAF_CTRL_START_MASK)
        if self.status != FLASH_ERR_OK:
            return self.status
        self._regWriteOr(aId, RAF_CTRL, RAF_CTRL_CLEAR_MASK)
        if self.status != FLASH_ERR_OK:
            return self.status

        # Wait till clear bit is cleared by Hardware
        retVal = self._WaitQSPI(aId, RAF_CTRL, RAF_CTRL_CLEAR_MASK, False, QSPI_BSPI_TIMEOUT_COUNT)
        if (retVal != BCM_ERR_OK):
            errMsg = 'RafStop failed'
            FLASH_ReportError(errMsg, retVal)

        return retVal


    def _RafRead(self, aId, aAddr, aData, aLen):
        count = 0
        remain = aLen
        retVal = BCM_ERR_OK

        # Check for RAF Busy
        regVal = self._regRead(aId, RAF_STATUS)
        if self.status == FLASH_ERR_FAILED:
            return self.status
        if ((regVal & RAF_STATUS_SESSION_BUSY_MASK) != 0):
            retVal = BCM_ERR_BUSY
            errMsg = '_RafRead failed'
            FLASH_ReportError(errMsg, retVal)
            return retVal

        # Set the RAF start address
        self._regWrite(aId, RAF_START_ADDR, aAddr)
        if self.status == FLASH_ERR_FAILED:
            return self.status

        rafWords = int(aLen / RAF_WORD_LEN)
        if ((aLen & 0x3) != 0):
            rafWords += 1

        self._regWrite(aId, RAF_NUM_WORDS, rafWords)
        if self.status == FLASH_ERR_FAILED:
            return self.status

        # Set WaterMark to FIFO full
        self._regWrite(aId, RAF_WATERMARK, (RAF_WATERMARK_64_WORDS & RAF_WATERMARK_FULLNESS_MASK))
        if self.status == FLASH_ERR_FAILED:
            return self.status

        # Flush RAF buffer
        self._regWrite(aId, RAF_CTRL, RAF_CTRL_CLEAR_MASK)
        if self.status == FLASH_ERR_FAILED:
            return self.status

        # Start RAF session
        self._regWrite(aId, RAF_CTRL, RAF_CTRL_START_MASK)
        if self.status == FLASH_ERR_FAILED:
            return self.status

        # Wait till start bit is cleared by Hardware
        retVal = self._WaitQSPI(aId, RAF_CTRL, RAF_CTRL_START_MASK, False, QSPI_BSPI_TIMEOUT_COUNT)
        if (retVal != BCM_ERR_OK):
            errMsg = '_RafRead failed'
            FLASH_ReportError(errMsg, retVal)
            return retVal

        # Read the data from FIFO
        while True:
            rafStatus = self._regRead(aId, RAF_STATUS)
            if self.status == FLASH_ERR_FAILED:
                break
            fifoEmpty = (rafStatus & RAF_STATUS_FIFO_EMPTY_MASK)
            rafBusy = (rafStatus & RAF_STATUS_SESSION_BUSY_MASK)
            if (fifoEmpty == 0):
                # FIFO is not empty
                fifoData = self._regRead(aId, RAF_READ_DATA)
                if self.status == FLASH_ERR_FAILED:
                    break
                if (remain >= RAF_WORD_LEN):
                    aData.append(hex((fifoData >> 24) & 0xFF))
                    aData.append(hex((fifoData >> 16) & 0xFF))
                    aData.append(hex((fifoData >> 8) & 0xFF))
                    aData.append(hex((fifoData >> 0) & 0xFF))
                    count += RAF_WORD_LEN
                    remain -= RAF_WORD_LEN
                else:
                    for i in range(remain):
                        aData.append(fifoData & 0xFF)
                        fifoData = fifoData >> 8
                    remain = 0
                    count += i
            else:
                if (rafBusy == 0):
                    break
            if (count >= aLen):
                break
        if self.status == FLASH_ERR_FAILED:
            return self.status
        retVal = self._RafStop(aId)
        if (retVal != BCM_ERR_OK):
            errMsg = 'RafRead failed'
            FLASH_ReportError(errMsg, retVal)

        return retVal

    def QSPI_Xfer(self, aId, aTxData, aRxData, aLen, aFlag):
        i = 0
        tmpIdx = 0
        remain = aLen
        retVal = BCM_ERR_OK
        if ((aId > QSPI_MAX_HW_ID) and (aTxData is None)):
            retVal = BCM_ERR_INVAL_PARAMS
            errMsg = 'QSPI_Xfer failed.'
            FLASH_ReportError(errMsg, retVal)
            return retVal

        if (aLen > MSPI_FIFO_LEN*2):
            tmpTxLen = MSPI_FIFO_LEN*2
        else:
            tmpTxLen = aLen

        # Enable MSPI
        self._regWriteOr(aId, BSPI_MAST_N_BOOT_CTRL, BSPI_MAST_N_BOOT_CTRL_BIT_MASK)
        if self.status != FLASH_ERR_OK:
            return self.status

        while True:
            data = aTxData[tmpIdx:(tmpIdx+tmpTxLen)]
            txData = []
            for each in data:
                txData.append(each)
                txData.extend([0]*3)
            self.debugger.writeMem((QSPI_REGS[aId] + MSPI_TXRAM_BASE), len(txData), txData)

            cmdData = []
            odd = tmpTxLen%2
            for i in range(tmpTxLen//2):
                if ((odd == 0) and (remain < MSPI_FIFO_LEN*2) and (i == (tmpTxLen//2 - 1)) and (aFlag == QSPI_XFER_STOP)):
                    cmdData.append(MSPI_CDRAM_CMD_BITS_PER_TRANF_MASK)
                    cmdData.extend([0]*3)
                else:
                    cmdData.append(MSPI_CDRAM_CMD_CONTINUE_MASK | MSPI_CDRAM_CMD_BITS_PER_TRANF_MASK)
                    cmdData.extend([0]*3)
            if (odd != 0):
                cmdData.extend([0]*4)
            self.debugger.writeMem((QSPI_REGS[aId] + MSPI_CDRAM_BASE), len(cmdData), cmdData)

            # Program the Start and end QPs
            self._regWrite(aId, MSPI_NEWQP, 0)
            if self.status == FLASH_ERR_FAILED:
                break

            self._regWrite(aId, MSPI_ENDQP, i)
            if self.status == FLASH_ERR_FAILED:
                break

            # Write lock enable
            self._regWriteOr(aId, MSPI_WRITE_LOCK, MSPI_WRITE_LOCK_WRITELOCK_MASK)
            if self.status != FLASH_ERR_OK:
                return self.status

            # Set chip select assert continue
            self._regWrite(aId, MSPI_SPCR2, MSPI_SPCR2_CONT_AFTER_CMD_MASK | MSPI_SPCR2_SPE_MASK)
            if self.status == FLASH_ERR_FAILED:
                break

            # wait for MSPI completion
            retVal = self._WaitQSPI(aId, MSPI_STATUS, MSPI_STATUS_SPIF_MASK, True, QSPI_MSPI_TIMEOUT_COUNT)
            if (retVal != BCM_ERR_OK):
                errMsg = 'QSPI_Xfer failed.'
                FLASH_ReportError(errMsg, retVal)
                break

            # clear the SPIF bit
            self._regWriteAnd(aId, MSPI_STATUS, ~MSPI_STATUS_SPIF_MASK)
            if self.status != FLASH_ERR_OK:
                return self.status

            # read the RX FIFO
            j = 0
            while ((j < tmpTxLen) and (aRxData is not None)):
                regVal = self._regRead(aId, MSPI_RXRAM_BASE + ((j)*4))
                if self.status == FLASH_ERR_FAILED:
                    return self.status
                aRxData[j + tmpIdx] = regVal
                j += 1

            remain -= tmpTxLen
            tmpIdx += tmpTxLen
            if (remain > MSPI_FIFO_LEN*2):
                tmpTxLen = MSPI_FIFO_LEN*2
            else:
                tmpTxLen = remain

            if (remain <= 0):
                break

        if (aFlag == QSPI_XFER_STOP):
            # Stop the MSPI and disable it
            self._regWriteAnd(aId, MSPI_WRITE_LOCK, ~MSPI_WRITE_LOCK_WRITELOCK_MASK)
            if self.status != FLASH_ERR_OK:
                return self.status
            self._regWriteAnd(aId, MSPI_SPCR2, ~MSPI_SPCR2_SPE_MASK)
            if self.status != FLASH_ERR_OK:
                return self.status
            self._regWriteAnd(aId, BSPI_MAST_N_BOOT_CTRL, ~BSPI_MAST_N_BOOT_CTRL_BIT_MASK)
            if self.status != FLASH_ERR_OK:
                return self.status

        return retVal

    def QSPI_Read(self, aId, aAddr, aData, aLen):
        tmpBufIdx = 0
        tmpBuf = [0]*RAF_WORD_LEN
        retVal = BCM_ERR_OK

        if (aId > FLASH_MAX_HW_ID):
            retVal = BCM_ERR_INVAL_PARAMS
            errMsg = 'QSPI_Read failed'
            FLASH_ReportError(errMsg, retVal)
            return retVal

        # If aAddr is not 4-byte aligned,
        # we need to split the read transaction
        # since _RafRead() only reads the
        # aligned addresses
        alignOff = (aAddr & 0x3)
        if (alignOff == 0):
            retVal = self._RafRead(aId, aAddr, aData, aLen)
        else:
            alignAddr = (aAddr & (~0x3))
            retVal = self._RafRead(aId, alignAddr, tmpBuf, RAF_WORD_LEN)
            if (retVal == BCM_ERR_OK):
                i = alignOff
                while ((i < RAF_WORD_LEN) and (tmpBufIdx < aLen)):
                    aData.append(tmpBuf[i])
                    i += 1
                alignAddr += RAF_WORD_LEN
                if (aLen > tmpBufIdx):
                    retVal = self._RafRead(aId, alignAddr, aData, (aLen - tmpBufIdx))

        return retVal

    # Configure QSPI speed:
    #     Set MSPI clock to 6.25MHz (Input clock is assumed to be 400MHz)
    # Configure QSPI in master mode
    # Configure SPI mode as per aConfig-> SPIMode
    # Enable and configure QSPI read lane asper aConfig->readLane
    def QSPI_Init(self, aId, aCfg):
        retVal = BCM_ERR_OK
        # Configure QSPI speed
        # Input clock is assumed to be 400MHz. So, MSPI clock set to 6.25MHz
        self._regWrite(aId, MSPI_SPCR0_LSB, SPBR_VAL_32 & MSPI_SPCR0_LSB_SPBR_MASK)
        if self.status == FLASH_ERR_FAILED:
            return self.status

        # Configure QSPI in master mode
        regVal = MSPI_SPCR0_MSB_MSTR_MASK

        # Configure SPI mode
        if (aCfg["SPIMode"] == FLASH_SPI_MODE_0):
            regVal &= (~MSPI_SPCR0_MSB_CPOL_MASK)
            regVal &= (~MSPI_SPCR0_MSB_CPHA_MASK)
        elif (aCfg["SPIMode"] == FLASH_SPI_MODE_1):
            regVal &= (~MSPI_SPCR0_MSB_CPOL_MASK)
            regVal |= MSPI_SPCR0_MSB_CPHA_MASK
        elif (aCfg["SPIMode"] == FLASH_SPI_MODE_2):
            regVal |= MSPI_SPCR0_MSB_CPOL_MASK
            regVal &= (~MSPI_SPCR0_MSB_CPHA_MASK)
        elif (aCfg["SPIMode"] == FLASH_SPI_MODE_3):
            regVal |= MSPI_SPCR0_MSB_CPOL_MASK
            regVal |= MSPI_SPCR0_MSB_CPHA_MASK

        self._regWrite(aId, MSPI_SPCR0_MSB, regVal)
        if self.status == FLASH_ERR_FAILED:
            return self.status

        # Enable QSPI read lane
        self._regWrite(aId, BSPI_STRAP_OVERRIDE_CTRL, 0)
        if self.status == FLASH_ERR_FAILED:
            return self.status
        if (aCfg["readLane"] == FLASH_READ_LANE_SINGLE):
            self._regWriteAnd(aId, BSPI_STRAP_OVERRIDE_CTRL, ~BSPI_STRAP_OR_CTRL_DUAL_SGL_MASK)
            if self.status != FLASH_ERR_OK:
                return self.status
            self._regWriteAnd(aId, BSPI_STRAP_OVERRIDE_CTRL, ~BSPI_STRAP_OR_CTRL_QUAD_MASK)
            if self.status != FLASH_ERR_OK:
                return self.status
            self._regWriteOr(aId, BSPI_STRAP_OVERRIDE_CTRL, BSPI_STRAP_OR_CTRL_OR_MASK)
            if self.status != FLASH_ERR_OK:
                return self.status

        elif (aCfg["readLane"] == FLASH_READ_LANE_DUAL):
            self._regWriteAnd(aId, BSPI_STRAP_OVERRIDE_CTRL, ~BSPI_STRAP_OR_CTRL_DUAL_SGL_MASK)
            if self.status != FLASH_ERR_OK:
                return self.status
            self._regWriteOr(aId, BSPI_STRAP_OVERRIDE_CTRL, BSPI_STRAP_OR_CTRL_QUAD_MASK)
            if self.status != FLASH_ERR_OK:
                return self.status
            self._regWriteOr(aId, BSPI_STRAP_OVERRIDE_CTRL, BSPI_STRAP_OR_CTRL_OR_MASK)
            if self.status != FLASH_ERR_OK:
                return self.status

        elif (aCfg["readLane"] == FLASH_READ_LANE_QUAD):
            self._regWriteOr(aId, BSPI_STRAP_OVERRIDE_CTRL, BSPI_STRAP_OR_CTRL_DUAL_SGL_MASK)
            if self.status != FLASH_ERR_OK:
                return self.status
            self._regWriteOr(aId, BSPI_STRAP_OVERRIDE_CTRL, BSPI_STRAP_OR_CTRL_QUAD_MASK)
            if self.status != FLASH_ERR_OK:
                return self.status
            self._regWriteOr(aId, BSPI_STRAP_OVERRIDE_CTRL, BSPI_STRAP_OR_CTRL_OR_MASK)
            if self.status != FLASH_ERR_OK:
                return self.status
        return retVal

class FLASH_Access(FLASH_QSPI):
    def __init__(self, aDebugger):
        super(FLASH_Access, self).__init__(aDebugger)
        # self.debugger = aDebugger

    def _ADDRESS23_16(self, aFlashAddr):
        return ((aFlashAddr >> 16) & 0xFF)

    def _ADDRESS15_8(self, aFlashAddr):
        return ((aFlashAddr >> 8) & 0xFF)

    def _ADDRESS7_0(self, aFlashAddr):
        return (aFlashAddr & 0xFF)

    def _ReadReg(self, aId, aCmd, aCmdLen, aData):
        cmdData = [0]*4
        rxData = [0]*4
        retVal = BCM_ERR_OK
        if (aCmdLen > FLASH_CMD_MAX_LEN):
            retVal = BCM_ERR_NOMEM
        else:
            cmdData[0] = aCmd
            cmdData[1] = DUMMY_DATA
            cmdData[2] = DUMMY_DATA
            cmdData[3] = DUMMY_DATA

            retVal = self.QSPI_Xfer(aId, cmdData, rxData, aCmdLen, QSPI_XFER_STOP)
            if (retVal == BCM_ERR_OK):
                for i in range(aCmdLen - 1):
                    aData.append(rxData[i + 1])

        return retVal

    def _ReadStatus(self, aId, aStatus):
        return self._ReadReg(aId, FLASH_CMD_RDSR, 2, aStatus)

    def _WaitWIP(self, aId):
        status = []
        flagReg = []
        retVal = BCM_ERR_OK

        while True:
            retVal = self._ReadStatus(aId, status)
            if (retVal == BCM_ERR_OK):
                wipStatus = status[0] & FLASH_STATUS_WIP_MASK

                if (MICRON_N25Q512A == FLASH_RWDev[aId]["flsID"]):
                    retVal = self._ReadReg(aId, FLASH_CMD_READ_FS_REG, 2, flagReg)
                    if (retVal == BCM_ERR_OK):
                        if ((flagReg[0] & FLAG_STATUS_ERR_MASK) != 0):
                            retVal = BCM_ERR_UNKNOWN
                            errMsg = '_WaitWIP failed.'
                            FLASH_ReportError(errMsg, retVal)
                            break
                        if (((flagReg[0] & FLAG_STATUS_PROG_ERASE_CONTR_MASK) != 0) and (wipStatus == 0)):
                            break
                else:
                    if (wipStatus == 0):
                        break
            else:
                break
        return retVal

    def _WriteEnable(self, aId):
        status = []
        retVal = BCM_ERR_OK
        cmdData = [0, 0]

        cmdData[0] = FLASH_CMD_WREN
        retVal = self.QSPI_Xfer(aId, cmdData, None, 1, QSPI_XFER_STOP)

        if (retVal == BCM_ERR_OK):
            while True:
                retVal = self._ReadStatus(aId, status)
                if ((retVal == BCM_ERR_OK) and (status[0] & FLASH_STATUS_WEL_MASK) != 0):
                    break

        return retVal

    def _ReadIDInternal(self, aId):
        flashId = 0
        cmdLen = 4
        rxData = []

        retVal = self._ReadReg(aId, FLASH_CMD_RDID, cmdLen, rxData)
        if (retVal == BCM_ERR_OK):
            flashId = (rxData[0] << 16) | (rxData[1] << 8) | (rxData[2])

        return flashId

    def FLASH_Erase(self, aId, aAddr, aLen):
        cmdData = [0, 0, 0, 0, 0]
        retVal = BCM_ERR_OK
        tmpAddr = aAddr

        if (aId > FLASH_MAX_HW_ID):
            retVal = BCM_ERR_INVAL_PARAMS
            errMsg = 'FLASH_Erase failed.'
            FLASH_ReportError(errMsg, retVal)
            return retVal

        if (FLASH_RWDev[aId]["state"] == FLASH_STATE_UNINIT):
            retVal = BCM_ERR_UNINIT
            errMsg = 'FLASH_Erase failed.'
            FLASH_ReportError(errMsg, retVal)
            return retVal

        # Verify aAddr + Len < sectorSize
        if ((aLen == 0) or (FLASH_RWDev[aId]["config"]["size"] < (aAddr + aLen))):
            retVal = BCM_ERR_INVAL_PARAMS
            errMsg = 'FLASH_Erase failed.'
            FLASH_ReportError(errMsg, retVal)
            return retVal

        eraseSecSize = FLASH_RWDev[aId]["config"]["sectorSize"]

        if eraseSecSize == 0:
            retVal = BCM_ERR_INVAL_PARAMS
            errMsg = 'FLASH_Erase failed.'
            FLASH_ReportError(errMsg, retVal)
            return retVal

        # Check aAddr and aLen for flash sector size alignment
        if (((aAddr % eraseSecSize) != 0) or ((aLen % eraseSecSize) != 0)):
            retVal = BCM_ERR_INVAL_PARAMS
            errMsg = 'FLASH_Erase failed. Sector size alignment is invalid.'
            FLASH_ReportError(errMsg, retVal)
            return retVal

        eraseSec = int(aLen / eraseSecSize)
        for i in range(eraseSec):
            # Issue Write enable
            retVal = self._WriteEnable(aId)
            if (retVal != BCM_ERR_OK):
                errMsg = 'FLASH_Erase failed.'
                FLASH_ReportError(errMsg, retVal)
                break

            # Send sector erase command
            cmdData[0] = FLASH_CMD_SE
            cmdData[1] = self._ADDRESS23_16(tmpAddr)
            cmdData[2] = self._ADDRESS15_8(tmpAddr)
            cmdData[3] = self._ADDRESS7_0(tmpAddr)

            retVal = self.QSPI_Xfer(aId, cmdData, None, 4, QSPI_XFER_STOP)
            if (retVal != BCM_ERR_OK):
                errMsg = 'FLASH_Erase failed.'
                FLASH_ReportError(errMsg, retVal)
                break

            time.sleep(1.5)
            # wait for erase to complete
            retVal = self._WaitWIP(aId)
            if (retVal != BCM_ERR_OK):
                errMsg = 'FLASH_Erase failed.'
                FLASH_ReportError(errMsg, retVal)
                break

            tmpAddr += eraseSecSize

        return retVal

    def FLASH_Read(self, aId, aAddr, aBuf, aLen):
        if (aId > FLASH_MAX_HW_ID):
            retVal = BCM_ERR_INVAL_PARAMS
            errMsg = 'FLASH_Read failed'
            FLASH_ReportError(errMsg, retVal)
            return retVal

        # Check the controller status
        if (FLASH_STATE_UNINIT == FLASH_RWDev[aId]["state"]):
            retVal = BCM_ERR_UNINIT
            errMsg = 'FLASH_Read failed.'
            FLASH_ReportError(errMsg, retVal)
            return retVal

        if ((aLen == 0) or (FLASH_RWDev[aId]["config"]["size"] < (aAddr + aLen))):
            retVal = BCM_ERR_INVAL_PARAMS
            errMsg = 'FLASH_Read failed.'
            FLASH_ReportError(errMsg, retVal)
            return retVal

        retVal = self.QSPI_Read(aId, aAddr, aBuf, aLen)
        if (retVal != 0):
            errMsg = 'FLASH_Read failed.'
            FLASH_ReportError(errMsg, retVal)
        return retVal

    def FLASH_Write(self, aId, aAddr, aBuf, aLen, aTrigger):
        retVal = BCM_ERR_UNKNOWN
        tmpAddr = aAddr
        tmpBuf = aBuf
        cmdData = [0]*5

        if (aId > FLASH_MAX_HW_ID):
            retVal = BCM_ERR_INVAL_PARAMS
            errMsg = 'FLASH_Write failed.'
            FLASH_ReportError(errMsg, retVal)
            return retVal

        # Check the controller status
        if (FLASH_STATE_UNINIT == FLASH_RWDev[aId]["state"]):
            retVal = BCM_ERR_UNINIT
            errMsg = 'FLASH_Write failed.'
            FLASH_ReportError(errMsg, retVal)
            return retVal

        if ((aLen == 0) or (aBuf is None) or (FLASH_RWDev[aId]["config"]["size"] < (aAddr + aLen))):
            retVal = BCM_ERR_INVAL_PARAMS
            errMsg = 'FLASH_Write failed.'
            FLASH_ReportError(errMsg, retVal)
            return retVal

        # Check aAddr and aLen for flash page size alignment
        if ((aAddr % FLASH_RWDev[aId]["config"]["pageSize"]) != 0):
            retVal = BCM_ERR_INVAL_PARAMS
            errMsg = 'FLASH_Write failed.'
            FLASH_ReportError(errMsg, retVal)
            return retVal

        pageSize = FLASH_RWDev[aId]["config"]["pageSize"]
        numPages = int(aLen / FLASH_RWDev[aId]["config"]["pageSize"])
        remain = aLen % FLASH_RWDev[aId]["config"]["pageSize"]
        if (remain != 0):
            numPages += 1
        print('Number of pages found: ' + str(numPages))
        lastVal = None

        print("Flash Started...\n")
        for i in range(numPages):
            percent = int(((numPages - i)*100)/numPages)
            if (percent != lastVal):
                sys.stdout.write('\rWrite percent: %s' % (100-percent))
                if aTrigger != None:
                    aTrigger.emit(100-percent, 4)
            lastVal = percent

            # Skip all the pages with 0xff contents
            skipPage = all(elem == 0xff for elem in tmpBuf[:pageSize])
            if not skipPage:
                retVal = self._WriteEnable(aId)
                if (retVal != BCM_ERR_OK):
                    break

                cmdData[0] = FLASH_CMD_PP
                cmdData[1] = self._ADDRESS23_16(tmpAddr)
                cmdData[2] = self._ADDRESS15_8(tmpAddr)
                cmdData[3] = self._ADDRESS7_0(tmpAddr)

                retVal = self.QSPI_Xfer(aId, cmdData, None, 4, QSPI_XFER_CONTINUE)
                if (retVal != BCM_ERR_OK):
                    break

                if ((remain != 0) and (i == (numPages - 1))):
                    retVal = self.QSPI_Xfer(aId, tmpBuf, None, remain, QSPI_XFER_STOP)
                else:
                    retVal = self.QSPI_Xfer(aId, tmpBuf, None, pageSize, QSPI_XFER_STOP)

                if (retVal != BCM_ERR_OK):
                    break

                retVal = self._WaitWIP(aId)
                if (retVal != BCM_ERR_OK):
                    break
            tmpAddr += pageSize
            tmpBuf = tmpBuf[pageSize:]

        if (retVal != BCM_ERR_OK):
            errMsg = 'FLASH_Write failed.'
            FLASH_ReportError(errMsg, retVal)
        else:
            print("\nFlash completed")
        return retVal

    def FLASH_Init(self, aId, aCfg):
        retVal = BCM_ERR_OK
        flsID = 0

        if (aId > FLASH_MAX_HW_ID):
            retVal = BCM_ERR_INVAL_PARAMS
            errMsg = 'FLASH_Init failed. Invalid HW ID.'
            FLASH_ReportError(errMsg, retVal)
            return retVal

        if (FLASH_RWDev[aId]["state"] != FLASH_STATE_UNINIT):
            retVal = BCM_ERR_INVAL_STATE
            errMsg = 'FLASH_Init failed. Invalid state.'
            FLASH_ReportError(errMsg, retVal)
            return retVal

        QSPI_Config["SPIMode"] = aCfg["SPIMode"]
        QSPI_Config["speed"] = aCfg["speed"]
        QSPI_Config["readLane"] = aCfg["readLane"]

        retVal = self.QSPI_Init(aId, QSPI_Config)
        if retVal != BCM_ERR_OK:
            print("QSPI_Init Failed")
            return retVal

        # Read flash id and check if its supported by the driver. If flash is not
        # supported, flash driver initialization fails and flash driver will stay
        # in UNINIT state

        flsID = self._ReadIDInternal(aId)
        print('FLASH ID - ' + str(hex(flsID)))

        if flsID not in FLASH_FlsIDTbl:
            retVal = BCM_ERR_NOSUPPORT
            return retVal

        # Quad lane not supported for Micron N25Q512A flash
        if ((aId != 0)
                and (FLASH_READ_LANE_QUAD == aCfg["readLane"])
                and (WINBOND_W25Q16 == flsID)
                and (WINBOND_W25Q64CV)):
            retVal = BCM_ERR_NOSUPPORT
            errMsg = 'FLASH_Init Failed.'
            FLASH_ReportError(errMsg, retVal)
            return retVal

        FLASH_RWDev[aId]["flsID"] = flsID
        FLASH_RWDev[aId]["config"] = aCfg
        FLASH_RWDev[aId]["state"] = FLASH_STATE_INIT
        return retVal
