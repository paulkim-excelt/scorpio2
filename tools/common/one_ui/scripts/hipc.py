#!/usr/bin/python3

#
# $Id$
# Copyright: Copyright 2021-2022 Broadcom Limited.
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
# CORRESPONDENCE TO DESCRIPTION. YOU ASSUME THE ENTIRE RISK ARISING
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


import sys
sys.dont_write_bytecode = True
import re
import shutil
import os
import time
import getopt
import jlink_interface
import lauterbach_interface
import bcm8957x_ipc_hwif
import bcm8958x_ipc_hwif
import bcm8957x_bl_chip_config
import bcm8958x_bl_chip_config
sys.path.insert(1, os.path.join(os.path.dirname(os.path.realpath(__file__)), 'rdb'))
from common_header import *
from bcm_comp import *


#################################
#       bl_ipc_hwif
#################################

BL_IPC_MAX_PTR_MASK                = 0xF
BL_IPC_BUFF_INFO_BASE_ALIGN_SHIFT  = 11
BL_IPC_BUFF_INFO2_BASE_ALIGN_SHIFT = 19
BL_IPC_INTR_NUM                    = 7

BL_IPC_BUFF_INFO_BASE_SHIFT        = 8
BL_IPC_BUFF_INFO_BASE_MASK         = 0xFF00
BL_IPC_BUFF_INFO_SZ_SHIFT          = 4
BL_IPC_BUFF_INFO_SZ_MASK           = 0x00F0
BL_IPC_BUFF_INFO_CNT_SHIFT         = 2
BL_IPC_BUFF_INFO_CNT_MASK          = 0x000C
BL_IPC_BUFF_INFO_RSVD_SHIFT        = 1
BL_IPC_BUFF_INFO_RSVD_MASK         = 0x0002
BL_IPC_BUFF_INFO_PAR_SHIFT         = 0
BL_IPC_BUFF_INFO_PAR_MASK          = 0x0001

#define BL_IPC_TARGET_STAT_REG             ((volatile uint16_t *)MISC_SPARE_SW_REG8)
BL_IPC_TARGET_STAT_RSVD_SHIFT   = 13
BL_IPC_TARGET_STAT_RSVD_MASK    = 0xE000
BL_IPC_TARGET_STAT_ERROR_SHIFT  = 12
BL_IPC_TARGET_STAT_ERROR_MASK   = 0x1000
BL_IPC_TARGET_STAT_READY_SHIFT  = 11
BL_IPC_TARGET_STAT_READY_MASK   = 0x0800
BL_IPC_TARGET_STAT_PRI_SHIFT    = 8
BL_IPC_TARGET_STAT_PRI_MASK     = 0x0700
BL_IPC_TARGET_STAT_PRI_REBOOT   = 7
BL_IPC_TARGET_STAT_PRI_6        = 6
BL_IPC_TARGET_STAT_PRI_5        = 5
BL_IPC_TARGET_STAT_PRI_4        = 4
BL_IPC_TARGET_STAT_PRI_3        = 3
BL_IPC_TARGET_STAT_PRI_2        = 2
BL_IPC_TARGET_STAT_PRI_1        = 1
BL_IPC_TARGET_STAT_PRI_PAUSE    = 0
BL_IPC_TARGET_STAT_WR_SHIFT     = 4
BL_IPC_TARGET_STAT_WR_MASK      = BL_IPC_MAX_PTR_MASK << BL_IPC_TARGET_STAT_WR_SHIFT
BL_IPC_TARGET_STAT_RD_SHIFT     = 0
BL_IPC_TARGET_STAT_RD_MASK      = BL_IPC_MAX_PTR_MASK << BL_IPC_TARGET_STAT_RD_SHIFT

#define BL_IPC_HOST_STAT_REG               ((volatile uint16_t *)MISC_SPARE_SW_REG9)
BL_IPC_HOST_STAT_RSVD_SHIFT     = 8
BL_IPC_HOST_STAT_RSVD_MASK      = 0xFF00
BL_IPC_HOST_STAT_WR_SHIFT       = 4
BL_IPC_HOST_STAT_WR_MASK        = BL_IPC_MAX_PTR_MASK << BL_IPC_HOST_STAT_WR_SHIFT
BL_IPC_HOST_STAT_RD_SHIFT       = 0
BL_IPC_HOST_STAT_RD_MASK        = BL_IPC_MAX_PTR_MASK << BL_IPC_HOST_STAT_RD_SHIFT

BL_IPC_BUFF_INFO2_BASE_SHIFT    = 1
BL_IPC_BUFF_INFO2_BASE_MASK     = 0x3FFE
BL_IPC_BUFF_INFO2_RSVD_SHIFT    = 14
BL_IPC_BUFF_INFO2_RSVD_MASK     = 0xC000
BL_IPC_BUFF_INFO2_PAR_SHIFT     = 0
BL_IPC_BUFF_INFO2_PAR_MASK      = 0x0001

BL_IPC_COMMAND_MAGIC            = 0xa5a5a5a5
BL_IPC_REPLY_MAGIC              = 0x5a5a5a5a

BL_IPC_HDR_MAGIC_INDEX          = 0
BL_IPC_HDR_CHKSUM_INDEX         = 1
BL_IPC_HDR_COMMAND_INDEX        = 2
BL_IPC_HDR_LENGTH_INDEX         = 3
BL_IPC_HDR_LAST_INDEX           = 4

###################################################

SPI_ID_0            = 0
SPI_ID_1            = 1
SPI_ID_2            = 2
SPI_ID_3            = 3
SPI_ID_MIN          = SPI_ID_0
SPI_ID_MAX          = SPI_ID_3
SPI_ID_INVAL        = 0xFFFFFFFF
SPI_ID_DEFAULT      = SPI_ID_2

HIPC_CURRENT_SPI_ID = SPI_ID_DEFAULT

# Target side
BL_IPC_DWNLD_BL_READY_MASK           = 0x0001
BL_IPC_DWNLD_BL_READY_SHIFT          = 0
BL_IPC_DWNLD_FLASHING_PERCENT_MASK   = 0x00FE
BL_IPC_DWNLD_FLASHING_PERCENT_SHIFT  = 1
BL_IPC_DWNLD_STATUS_MASK             = 0x0300
BL_IPC_DWNLD_STATUS_SHIFT            = 8

BL_IPC_DWNLD_STATUS_SUCCESS          = 0
BL_IPC_DWNLD_STATUS_FAILURE          = 1
BL_IPC_DWNLD_STATUS_BUSY             = 2

BCM_UINT8  = 1
BCM_UINT16 = 2
BCM_UINT32 = 4

IPC_MSG_HDR_SIZE = 16

MEM_TYPE_UINT_8  = 1
MEM_TYPE_UINT_16 = 2
MEM_TYPE_UINT_32 = 4
MEM_TYPE_UINT_64 = 8

BCM_ERR_DISCONNECT = -1

class Lib:
    ipc_hwif       = None
    bl_chip_config = None

class DEBUGGER:
    ifc  = None
    mode = None
    chip = None
    mcm  = None
    rpc  = None
    @staticmethod
    def open():
        if DEBUGGER.chip == "bcm8957x":
            Lib.ipc_hwif       = bcm8957x_ipc_hwif
            Lib.bl_chip_config = bcm8957x_bl_chip_config
        elif DEBUGGER.chip == "bcm8958x":
            Lib.ipc_hwif       = bcm8958x_ipc_hwif
            Lib.bl_chip_config = bcm8958x_bl_chip_config
        else:
            print("Invalid Chip {}".format(DEBUGGER.chip)); sys.exit(2)
        if DEBUGGER.mode == 0:
            DEBUGGER.ifc = jlink_interface.JLINK_Interface(DEBUGGER.chip, None, DEBUGGER.mcm, 1)
        else:
            DEBUGGER.ifc = lauterbach_interface.LAUTERBACH_Interface(DEBUGGER.chip, DEBUGGER.mcm, 1)
        if DEBUGGER.rpc != None:
            DEBUGGER.rpc.reset_rpc()
    @staticmethod
    def reconnect():
        print("\nReconnecting...")
        DEBUGGER.close()
        time.sleep(1)
        DEBUGGER.open()
        DEBUGGER.ifc.halt()
        DEBUGGER.ifc.go()
        time.sleep(1)
        # Debugger should be in running state.
        index = 0
        while DEBUGGER.ifc.isHalted() == 1 and index < 10:
            DEBUGGER.ifc.go()
            time.sleep(1)
            index += 1
    @staticmethod
    def close():
        DEBUGGER.ifc.close()

PRINT_LOG = 0

def LOG(*aMsg):
    if PRINT_LOG:
        print(" ".join([str (m)for m in aMsg]))

def hexList(aList):
    return ["0x{:08x}".format(each) for each in aList]

def uswap32(a):
    return a

def hex4(a):
    return "0x{:08X}".format(a) if a else "0x0"

def hex_list(aList):
    return [hex4(each) for each in aList]

def HIPC_BusXferRead(aAddr, aWidth):
    data = DEBUGGER.ifc.readReg(aAddr, 1, aWidth//8)
    if data == None:
        print("HIPC_BusXferRead Failed for addr: 0x{:08x}".format(aAddr))
        DEBUGGER.reconnect()
    return data

def HIPC_BusXferWrite(aAddr, aData, aWidth):
    retVal = DEBUGGER.ifc.writeReg(aAddr, aData, aWidth//8)
    if retVal != BCM_ERR_OK:
        print("HIPC_BusXferWrite Failed. Trying to connect again")
        DEBUGGER.reconnect()
    return retVal

def HIPC_BusXferReadMem(aAddr, aLen, aType):
    data = DEBUGGER.ifc.readMem(aAddr, aLen, aType)
    if data == None:
        print("HIPC_BusXferRead Failed for addr: 0x{:08x}".format(aAddr))
        DEBUGGER.reconnect()
    return data

def HIPC_BusXferWriteMem(aAddr, aLen, aData, aType):
    retVal = DEBUGGER.ifc.writeMem(aAddr, aLen, aData, aType)
    if retVal != BCM_ERR_OK:
        print("HIPC_BusXferWrite Failed. Trying to connect again")
        DEBUGGER.reconnect()
    return retVal

def HIPC_EvenParity(aValue, aSize):
    par = 0
    for i in reversed(range(aSize * 8)):
        par ^= ((aValue >> i) & 0x1)
    return par

def be_to_le(aData):
    a = aData&0xff
    b = (aData>>8)&0xff
    c = (aData>>16)&0xff
    d = (aData>>24)&0xff
    return (a << 24 | b << 16 | c << 8 | d)

def bit32(aData):
    a = aData&0xff
    b = (aData>>8)&0xff
    c = (aData>>16)&0xff
    d = (aData>>24)&0xff
    return (d << 24 | c << 16 | b << 8 | a)

def SPI_Read32Bulk(aBuf, aAddr, aLen):
    retVal = BCM_ERR_OK

    # Check if length is a multiple of 4
    if aLen & 0x3:
        print("{} length is not aligned to 32bits".format(aLen)); sys.exit(1)

    readData = HIPC_BusXferReadMem(aAddr, aLen, MEM_TYPE_UINT_32)
    if readData == None:
        return BCM_ERR_DISCONNECT
    for i, value in enumerate(readData):
        aBuf[i] = value

    return retVal

def SPI_Write32Bulk(aAddr, aBuf, aLen):
    retVal = BCM_ERR_OK

    # Check if length is a multiple of 4
    if aLen & 0x3:
        print("{} length is not aligned to 32bits".format(aLen)); sys.exit(1)

    retVal = HIPC_BusXferWriteMem(aAddr, aLen, aBuf, MEM_TYPE_UINT_32)
    if retVal != BCM_ERR_OK:
        return BCM_ERR_DISCONNECT
    return retVal


def HIPC_PlatGetBuff():
    retVal = BCM_ERR_OK

    reg1Val16 = HIPC_BusXferRead(Lib.ipc_hwif.IPC_BUFF_INFO_REG, 16)
    if reg1Val16 == None:
        return BCM_ERR_DISCONNECT, None, None, None, None
    reg2Val16 = HIPC_BusXferRead(Lib.ipc_hwif.IPC_BUFF_INFO2_REG, 16)
    if reg2Val16 == None:
        return BCM_ERR_DISCONNECT, None, None, None, None

    if (reg1Val16 != 0xFFFF) and (reg1Val16 != 0)            \
        and (HIPC_EvenParity(reg1Val16, BCM_UINT16) == 0)    \
        and (HIPC_EvenParity(reg2Val16, BCM_UINT16) == 0):
        cnt = 1 << ((reg1Val16 & BL_IPC_BUFF_INFO_CNT_MASK) >> BL_IPC_BUFF_INFO_CNT_SHIFT)
        sz = 1 << ((reg1Val16 & BL_IPC_BUFF_INFO_SZ_MASK) >> BL_IPC_BUFF_INFO_SZ_SHIFT)

        buff = (((reg1Val16 & BL_IPC_BUFF_INFO_BASE_MASK) >> BL_IPC_BUFF_INFO_BASE_SHIFT) << BL_IPC_BUFF_INFO_BASE_ALIGN_SHIFT) \
             | (((reg2Val16 & BL_IPC_BUFF_INFO2_BASE_MASK) >> BL_IPC_BUFF_INFO2_BASE_SHIFT) << BL_IPC_BUFF_INFO2_BASE_ALIGN_SHIFT)

        reg1Val16 = HIPC_BusXferRead(Lib.bl_chip_config.BL_DWNLD_TARGET_SPARE_REG, 16)
        if reg2Val16 == None:
            return BCM_ERR_DISCONNECT, None, None, None, None
        if (1 == cnt) and (BL_IPC_DWNLD_BL_READY_MASK != (reg1Val16 & BL_IPC_DWNLD_BL_READY_MASK)):
            # BootROM only
            cntRollOverMask = 0x1 # 0-1
        else:
            cntRollOverMask = 0xF # 0-15
    else:
        cnt = 0
        sz = 0
        buff = 0
        cntRollOverMask = 0
        retVal = BCM_ERR_UNINIT
    return retVal, buff, cnt, cntRollOverMask, sz

def HIPC_GetChksum(aMagic, aCmd, aMsgList, aMsgLen, aLen):
    chksum = 0
    for i in range((aMsgLen >> 2) - BL_IPC_HDR_LAST_INDEX):
        chksum += uswap32(aMsgList[i])
    chksum += aMagic
    chksum += aLen
    chksum += aCmd
    return (((~chksum) + 1) & 0xffffffff)

def HIPC_PlatNotifyTarget():
    # Trigger IPC interrupt to target
    regVal16 = HIPC_BusXferRead(Lib.ipc_hwif.MISC_CPUSYS_MISC, 16)
    if regVal16 == None:
        return BCM_ERR_DISCONNECT
    regVal16 |= 1
    retVal = HIPC_BusXferWrite(Lib.ipc_hwif.MISC_CPUSYS_MISC, regVal16, 16)
    if retVal != BCM_ERR_OK:
        return BCM_ERR_DISCONNECT
    return 0

class PlatBuffer:
    ipcBuffAddr     = None
    ipcMsgCnt       = None
    cntRollOverMask = None
    ipcMsgSz        = None
    retVal          = BCM_ERR_UNKNOWN
    @staticmethod
    def get():
        if PlatBuffer.retVal != BCM_ERR_OK:
            PlatBuffer.retVal, ipcBuffAddr, ipcMsgCnt, cntRollOverMask, ipcMsgSz = HIPC_PlatGetBuff()
            if PlatBuffer.retVal == BCM_ERR_OK:
                PlatBuffer.ipcBuffAddr      = addr
                PlatBuffer.ipcMsgCnt        = msgCnt
                PlatBuffer.cntRollOverMask  = mask
                PlatBuffer.ipcMsgSz         = msgSz
                print("IPC Buffer initialized successfully!")
        return PlatBuffer.retVal, PlatBuffer.ipcBuffAddr, PlatBuffer.ipcMsgCnt, PlatBuffer.cntRollOverMask, PlatBuffer.ipcMsgSz

def HIPC_Recv(pCmd, aMsgList, pLen):
    hdrCmd    = None
    memMsgLen = None
    header    = [None] * BL_IPC_HDR_LAST_INDEX
    hdrSz     = 4 * len(header)

    retVal, ipcBuffAddr, ipcMsgCnt, cntRollOverMask, ipcMsgSz = HIPC_PlatGetBuff()
    if (retVal != BCM_ERR_OK):
        # print("IPC Buffer is not yet initialised({})".format(retVal))
        return retVal

    regVal16 = HIPC_BusXferRead(Lib.ipc_hwif.IPC_TARGET_STAT_REG, 16)
    if regVal16 == None:
        return BCM_ERR_DISCONNECT
    wPtr = (regVal16 & Lib.ipc_hwif.IPC_TARGET_STAT_WR_MASK) >> Lib.ipc_hwif.IPC_TARGET_STAT_WR_SHIFT

    regVal16 = HIPC_BusXferRead(Lib.ipc_hwif.IPC_HOST_STAT_REG, 16)
    if regVal16 == None:
        return BCM_ERR_DISCONNECT
    rPtr = (regVal16 & Lib.ipc_hwif.IPC_HOST_STAT_RD_MASK) >> Lib.ipc_hwif.IPC_HOST_STAT_RD_SHIFT

    # Check if there is a new message
    if rPtr != wPtr:
        LOG("[HIPC_Recv] H_Rd_ptr={}  T_Wr_ptr={}".format(rPtr, wPtr))
        idx = (rPtr & (ipcMsgCnt - 1)) + ipcMsgCnt

        # Memcpy
        retVal = SPI_Read32Bulk(header, ipcBuffAddr + (idx*ipcMsgSz), hdrSz)
        if retVal != BCM_ERR_OK:
            return retVal
        LOG("[HIPC_Recv] HDR: {}".format(hex_list(header)))
        if (retVal != BCM_ERR_OK):
            retVal = BCM_ERR_UNKNOWN
        else:
            hdrMagic  = uswap32(header[BL_IPC_HDR_MAGIC_INDEX])
            hdrChk    = uswap32(header[BL_IPC_HDR_CHKSUM_INDEX])
            hdrCmd    = uswap32(header[BL_IPC_HDR_COMMAND_INDEX])
            memMsgLen = uswap32(header[BL_IPC_HDR_LENGTH_INDEX])
            pCmd.append(hdrCmd)
            pLen.append(memMsgLen)

            for i in range(memMsgLen//4):
                aMsgList.append(None)
            LOG("[HIPC_Recv] MemMsg Length =", memMsgLen)
            if (memMsgLen <= (ipcMsgSz - hdrSz)):
                retVal = SPI_Read32Bulk(aMsgList, ipcBuffAddr + (idx*ipcMsgSz) + hdrSz, memMsgLen)
                if (retVal != BCM_ERR_OK):
                    return retVal
                else:
                    chksum = HIPC_GetChksum(hdrMagic, hdrCmd, aMsgList, memMsgLen + hdrSz, memMsgLen)
                    if (Lib.ipc_hwif.IPC_REPLY_MAGIC != hdrMagic):
                        retVal = BCM_ERR_DATA_INTEG
                        print("IPC: Invalid Magic")
                    elif (chksum != hdrChk):
                        retVal = BCM_ERR_DATA_INTEG
                        print("IPC: Failed to validate chksum")
                    else:
                        LOG("chksum verified!")
                        retVal = BCM_ERR_OK
            else:
                print("IPC Receive: incorrect length {}".format(memMsgLen))
                retVal = BCM_ERR_NOMEM

        # Increment read pointer
        rPtr += 1
        rPtr &= cntRollOverMask

        # Update HOST register
        regVal16 &= ~Lib.ipc_hwif.IPC_HOST_STAT_RD_MASK
        regVal16 |= (rPtr << Lib.ipc_hwif.IPC_HOST_STAT_RD_SHIFT) & Lib.ipc_hwif.IPC_HOST_STAT_RD_MASK
        retVal = HIPC_BusXferWrite(Lib.ipc_hwif.IPC_HOST_STAT_REG, regVal16, 16)
        if retVal != BCM_ERR_OK:
            return BCM_ERR_DISCONNECT
        retVal = HIPC_PlatNotifyTarget()
        if retVal != BCM_ERR_OK:
            return retVal
    else:
        retVal = BCM_ERR_NOT_FOUND
    return retVal

def HIPC_Send(aCmd, aMsg, aLen):
    buffer     = [None] * (128)
    bufferSize = 4 * len(buffer)     # one element of list will be of 4 bytes

    if (((bufferSize) - IPC_MSG_HDR_SIZE) < aLen):
        retVal = BCM_ERR_NOSUPPORT
        return retVal

    retVal, ipcBuffAddr, ipcMsgCnt, cntRollOverMask, ipcMsgSz = HIPC_PlatGetBuff()
    if (retVal != BCM_ERR_OK):
        # print("IPC Buffer is not yet initialised({})".format(retVal))
        return retVal

    if ((ipcMsgSz - IPC_MSG_HDR_SIZE) < aLen):
        print("IPC Buffer is not sufficient")
        retVal = BCM_ERR_NOSUPPORT
        return retVal

    regVal16 = HIPC_BusXferRead(Lib.ipc_hwif.IPC_TARGET_STAT_REG, 16)
    if regVal16 == None:
        return  BCM_ERR_DISCONNECT
    # Get pointers
    rPtr = (regVal16 & Lib.ipc_hwif.IPC_TARGET_STAT_RD_MASK) >> Lib.ipc_hwif.IPC_TARGET_STAT_RD_SHIFT
    if regVal16 == None:
        return BCM_ERR_DISCONNECT
    regVal16 = HIPC_BusXferRead(Lib.ipc_hwif.IPC_HOST_STAT_REG, 16)
    wPtr = (regVal16 & Lib.ipc_hwif.IPC_HOST_STAT_WR_MASK) >> Lib.ipc_hwif.IPC_HOST_STAT_WR_SHIFT
    # Retain regVal16 for further use        # Check if feasible
    LOG("[HIPC_Send] T_Rd_ptr={}  H_Wr_ptr={}".format(rPtr, wPtr))
    if ((rPtr + ipcMsgCnt) & Lib.ipc_hwif.IPC_MAX_PTR_MASK) != wPtr:

        # The SPI_Write32Bulk API expects the transfer length to be aligned to 32 bytes
        transferSize = (aLen + IPC_MSG_HDR_SIZE + 31) & (~(31))
        LOG("[HIPC_Send] transferSize =", transferSize)

        idx = (wPtr & (ipcMsgCnt - 1))
        buffer = [0 for i in range(len(buffer))]
        for i in range(aLen//4):
            buffer[BL_IPC_HDR_LAST_INDEX + i] = aMsg[i]
        buffer[BL_IPC_HDR_MAGIC_INDEX]   = Lib.ipc_hwif.IPC_COMMAND_MAGIC
        buffer[BL_IPC_HDR_CHKSUM_INDEX]  = uswap32(HIPC_GetChksum(Lib.ipc_hwif.IPC_COMMAND_MAGIC, aCmd,
                                                buffer[BL_IPC_HDR_LAST_INDEX: ], aLen + IPC_MSG_HDR_SIZE, aLen))
        buffer[BL_IPC_HDR_COMMAND_INDEX] = uswap32(aCmd)
        buffer[BL_IPC_HDR_LENGTH_INDEX]  = uswap32(aLen)
        # LOG(hex_list(buffer))
        # Memcpy
        retVal = SPI_Write32Bulk(ipcBuffAddr + (idx*ipcMsgSz), buffer, transferSize)
        if retVal != BCM_ERR_OK:
            return retVal

        # Increment write pointer
        wPtr += 1
        wPtr &= cntRollOverMask
        LOG("Increment write pointer")

        # Update HOST register
        regVal16 &= ~Lib.ipc_hwif.IPC_HOST_STAT_WR_MASK
        regVal16 |= ((wPtr << Lib.ipc_hwif.IPC_HOST_STAT_WR_SHIFT) & Lib.ipc_hwif.IPC_HOST_STAT_WR_MASK)
        retVal = HIPC_BusXferWrite(Lib.ipc_hwif.IPC_HOST_STAT_REG, regVal16, 16)
        if retVal != BCM_ERR_OK:
            return retVal
        retVal = HIPC_PlatNotifyTarget()
        if retVal != BCM_ERR_OK:
            return retVal
    else:
        retVal = BCM_ERR_NOMEM

    return retVal

def RPC_CMDID(aGrp, aComp, aId):

    RPC_CMD_GROUP_SHIFT    = 24
    RPC_CMD_GROUP_MASK     = 0x7F << RPC_CMD_GROUP_SHIFT

    RPC_CMD_COMP_SHIFT     = 8
    RPC_CMD_COMP_MASK      = 0xFFFF << RPC_CMD_COMP_SHIFT

    RPC_CMD_ID_SHIFT       = 0
    RPC_CMD_ID_MASK        = 0xFF << RPC_CMD_ID_SHIFT

    return ((aGrp << RPC_CMD_GROUP_SHIFT) & RPC_CMD_GROUP_MASK) | \
           ((aComp << RPC_CMD_COMP_SHIFT) & RPC_CMD_COMP_MASK) | \
           ((aId << RPC_CMD_ID_SHIFT) & RPC_CMD_ID_MASK)



def HIPC_Test():
    send = False
    recv = False
    test = False
    ping = False

    opts  = []
    try:
        opts, args = getopt.getopt(sys.argv[1:], "rstp",
                    ["recv", "send", "test", "ping"])
    except:
        print("Error in parsing arguments")
    for opt, arg in opts:
        if opt in ("-r", "--revc"):
            recv = True
        elif opt in ("-s", "--send"):
            send = True
        elif opt in ("-t", "--test"):
            test = True
        elif opt in ("-p", "--ping"):
            ping = True
        else:
            print("Unknown argument %s" % opt)

    chip = "bcm8957x"

    DEBUGGER.mode = 0
    DEBUGGER.chip = chip
    DEBUGGER.mcm  = False

    DEBUGGER.open()

    BCM_GROUPID_SYS    = 0x01
    BCM_RSV_ID         = 0x0000
    IPCLDR_CMDID_PING  = 0x01
    RPC_CMDIDVAL_PING  = 0x01

    cmdId = RPC_CMDID(BCM_GROUPID_SYS, BCM_RSV_ID, IPCLDR_CMDID_PING)
    if send:
        print("===========================")
        print("         HIPC_Send         ")
        print("===========================")

        data = [0x5250434D, 0x0, TEST_CMD, 0, 0xC, 0,0,0,0,0,0,0, 0x10,0x20, 0x5678]
        dataSize = 4 * len(data)

        retVal = HIPC_Send(cmdId, data, dataSize)
        if retVal != BCM_ERR_OK:
            print("Failed to send command, err:", retVal)
        else:
            print("HIPC_Send Success")

    if recv:
        print("\n===========================")
        print("          HIPC_Recv        ")
        print("===========================")

        cmd = []
        msg = []
        lst = []
        retVal = HIPC_Recv(cmd, msg, lst)
        if retVal != BCM_ERR_OK:
            print("Failed to Recv command, err:", retVal)
        else:
            print("\nHIPC_Recv Success")
            print("CMD: ", hex4(cmd[0]))
            print("MSG: ", hex_list(msg))


    if test == True:
        TEST_CMD = 0x81004321
        print("===========================")
        print("         HIPC_Send         ")
        print("===========================")

        payloadHdr = [0x5250434D, 0x0, TEST_CMD, 0, 0xC, 0,0,0,0,0,0,0]
        payload    = payloadHdr + [0x1234, 0x5678, 0xabcd]
        payloadSz  = 4 * len(payload)
        print("SENDING CMD: 0x{:08X}".format(TEST_CMD))
        print("SENDING MSG: ", [hex(a) for a in payload])
        retVal = HIPC_Send(TEST_CMD, payload, payloadSz)
        if retVal != BCM_ERR_OK:
            print("Failed to Send command, err:", retVal)
        else:
            print("HIPC_Send Success")

        print("\n===========================")
        print("          HIPC_Recv        ")
        print("===========================")
        while True:
            cmd = []
            msg = []
            lst = []
            retVal = HIPC_Recv(cmd, msg, lst)
            if retVal == BCM_ERR_NOT_FOUND:
                print("\nNo New Message found!\n"); time.sleep(.2)
            elif retVal != BCM_ERR_OK:
                print("Failed to Recv command, err:", retVal); break
            else:
                if len(cmd) > 0:
                    print("HIPC_Recv :", retVal)
                    print("RECV CMD: ", hex4(cmd[0]))
                    if cmd[0] == TEST_CMD:
                        print("RECV MSG: ", hex_list(msg))
                        print("\n\nMessage Found!"); break
                    else:
                        print("Not my Message, cmd_rx=0x{:08x} cmd_send=0x{:08x}\n".format(cmd[0], TEST_CMD))
                else:
                    print("\nNo Response found\n"); break

    if ping == True:
        TEST_CMD = RPC_CMDIDVAL_PING
        print("===========================")
        print("         HIPC_Send         ")
        print("===========================")

        data = []
        data_size = 4 * len(data)
        print("SENDING CMD: 0x{:08X}".format(TEST_CMD))
        print("SENDING MSG: ", [hex(a) for a in data])
        retVal = HIPC_Send(TEST_CMD, data, data_size)
        if retVal != BCM_ERR_OK:
            print("Failed to Send command, err:", retVal)
        else:
            print("HIPC_Send Success")
        time.sleep(1)
        print("\n===========================")
        print("          HIPC_Recv        ")
        print("===========================")
        while True:
            cmd = []
            msg = []
            lst = []
            retVal = HIPC_Recv(cmd, msg, lst)
            if retVal == BCM_ERR_NOT_FOUND:
                print("\nNo New Message found!\n"); time.sleep(.2)
            elif retVal != BCM_ERR_OK:
                print("Failed to Recv command, err:", retVal); break
            else:
                if len(cmd) > 0:
                    print("HIPC_Recv :", retVal)
                    print("RECV CMD: ", hex4(cmd[0]))
                    if cmd[0] == TEST_CMD:
                        print("RECV MSG: ", hex_list(msg))
                        print("\n\nMessage Found!"); break
                    else:
                        print("Not my Message, cmd_rx=0x{:08x} cmd_send=0x{:08x}\n".format(cmd[0], TEST_CMD))
                else:
                    print("\nNo Response found\n"); break

    DEBUGGER.close()

if __name__ == '__main__':
    HIPC_Test()
