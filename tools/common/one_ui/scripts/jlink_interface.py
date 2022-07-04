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

##  @defgroup grp_tools_jlink JLink Flasher
#   @ingroup grp_one_ui
#
#   @addtogroup grp_tools_jlink
#   @{
#
#   Jlink Interface for flashing.
#
#   @file jlink_interface.py
#   @brief Python script for JLink Flasher
#   @version 1.0 Changelist1

import sys
import os
import shutil
import getopt
import ctypes
import re
import time
import platform

##  @name JLink Architecture IDs
#   @{
#   @brief Architecture IDs for JLink Flasher
#
    ## @brief #jlink_interface.JLINK_SUB_SECTOR_SIZE()
BRCM_SWARCH_JLINK_SUB_SECTOR_SIZE_GLOBAL    = 0
    ## @brief #jlink_interface.JLINK_REG_U8_TYPE()
BRCM_SWARCH_JLINK_REG_U_GLOBAL              = 1
    ## @brief #jlink_interface.JLINK_RESET_ADDR_LEO()
BRCM_SWARCH_JLINK_RESET_ADDR_GLOBAL         = 2
    ## @brief #jlink_interface.JLINK_DLL_WINDOWS_32()
BRCM_SWARCH_JLINK_DLL_GLOBAL                = 3
    ## @brief #jlink_interface.JLINK_GLOBAL_SRST_EN()
BRCM_SWARCH_JLINK_GLOBAL_SRST_EN_GLOBAL     = 4
    ## @brief #jlink_interface.JLINK_SRST_CHIP()
BRCM_SWARCH_JLINK_SRST_CHIP_GLOBAL          = 5
    ## @brief #jlink_interface.JLINK_RESET()
BRCM_SWARCH_JLINK_WDT_BLOCK_GLOBAL          = 6
    ## @brief #jlink_interface.JLINK_WDT_BLOCK()
BRCM_SWARCH_JLINK_RESET_GLOBAL              = 7
    ## @brief #jlink_interface.JLINK_ReadLargeFile()
BRCM_SWARCH_JLINK_READLARGEFILE_PROC        = 8
    ## @brief #jlink_interface.JLINK_Interface
BRCM_SWARCH_JLINK_INTERFACE_CLASS           = 9
##  @}

##  @brief Sub-Sector Size
#
#   This marco value is equal to number of character in one subsector
#
#   @trace #BRCM_SWREQ_JLINK_INTERFACE
JLINK_SUB_SECTOR_SIZE = 16*256

##  @brief Reg n-type bit register
#
#   Macro for 8, 16, 32 and 64 bit register
#
#   @trace #BRCM_SWREQ_JLINK_INTERFACE
JLINK_REG_U8_TYPE  = 1
JLINK_REG_U16_TYPE = 2
JLINK_REG_U32_TYPE = 4
JLINK_REG_U64_TYPE = 8

##  @brief Leo and Scorpio Reset Address
#
#   Macro for Leo and Scorpio Reset Address
#
#   @trace #BRCM_SWREQ_JLINK_INTERFACE
JLINK_RESET_ADDR_LEO     = 0x0a820022
JLINK_RESET_ADDR_SCORPIO = 0x4a820024

##  @brief JLink DLL Files
#
#   DLL file for windows 32 and 64.
#
#   @trace #BRCM_SWREQ_JLINK_INTERFACE
JLINK_DLL_WINDOWS_32 = 'JLinkARM.dll'
JLINK_DLL_WINDOWS_64 = 'JLink_x64.dll'
JLINK_DLL_LINUX_SO6  = 'libjlinkarm.so.6'
JLINK_DLL_LINUX_SO7  = 'libjlinkarm.so.7'

##  @brief Global Soft Reset Enable
#
#   Global Soft Reset Enable value
#
#   @trace #BRCM_SWREQ_JLINK_INTERFACE
JLINK_GLOBAL_SRST_EN = 0x1

##  @brief Soft Reset Chip
#
#   Soft Reset Chip value
#
#   @trace #BRCM_SWREQ_JLINK_INTERFACE
JLINK_SRST_CHIP      = 0x1

##  @brief JLink Reset
#
#   JLink Reset Value
#
#   @trace #BRCM_SWREQ_JLINK_INTERFACE
JLINK_RESET = ((JLINK_GLOBAL_SRST_EN << 15) | (JLINK_SRST_CHIP))  # 0x8001

##  @brief JLink Control Address
#
#   Dictionary with keys as chip family and values as watchdog control address.
#
#   @trace #BRCM_SWREQ_JLINK_INTERFACE
JLINK_WDT_BLOCK = {"bcm8908x": {"wdogControl": 0xE0100008, "wdogIntClr": 0xE010000C},
                   "bcm8910x": {"wdogControl": 0xE0100008, "wdogIntClr": 0xE010000C},
                   "bcm8953x": {"wdogControl": 0x00145008, "wdogIntClr": 0x0014500C},
                   "bcm8955x": {"wdogControl": 0x00145008, "wdogIntClr": 0x0014500C},
                   "bcm8956x": {"wdogControl": 0x40145008, "wdogIntClr": 0x4014500C},
                   "bcm8957x": {"wdogControl": 0x40145008, "wdogIntClr": 0x4014500C},
                   "bcm8958x": {"wdogControl": 0x40145008, "wdogIntClr": 0x4014500C}}

##  @brief Function to read large file
#
#   This function will return a iterable object where each
#   item will be a chunk of file.
#
#   @behavior Sync, Non-reentrant
#
#   @pre None
#
#   @param[in]      file object
#   @param[in]      size of each chunk
#
#   @return data (iterable object)
#
#   @post None
#
#   @trace #BRCM_SWREQ_JLINK_INTERFACE
def JLINK_ReadLargeFile(aFileObject, aSize=JLINK_SUB_SECTOR_SIZE):
    while True:
        data = aFileObject.read(aSize)
        if not data:
            break
        yield data

##  @brief JLink Interface class
#
#   Class which provides jlink interface.
#
#   @trace #BRCM_SWREQ_JLINK_INTERFACE
class JLINK_Interface:
    JLINKARM_TIF_JTAG    = 0
    JLINK_CORE_CORTEX_M7 = 0x0E0100FF
    JLINK_CORE_CORTEX_R4 = 0x0C0000FF
    CPU_STATUS_DICT = {-1: "CPU_STATUS_UNKNOWN", 0: "CPU_STATUS_RUNNING", 1: "CPU_STATUS_STOPPED"}
    def __init__(self, aChip, aSerialNumber, aMCM=False, aSC=None):
        global JLINKARM_TIF_JTAG
        self.verbose = True
        self.chip = str(aChip)
        self.serialNumber = aSerialNumber
        self.mcm = aMCM
        self.sc = aSC
        if self.mcm and self.sc == None:
            self._error("[Error] Master/Slave mode is not selected")
        self.JLink, self.iStdCalliJLink = self._loadLibrary()

        if ((self.chip == 'bcm8910x') or (self.chip == 'bcm8908x') or (self.chip == 'bcm8956x') or (self.chip == 'bcm8957x')):
            self._findDeviceSerialNo()
            self._configure(5000, self.JLINK_CORE_CORTEX_M7, self.JLINKARM_TIF_JTAG)
        elif ((self.chip == 'bcm8953x') or (self.chip == 'bcm8955x')):
            self._findDeviceSerialNo()
            self._configure(5000, self.JLINK_CORE_CORTEX_R4, self.JLINKARM_TIF_JTAG)
        else:
            self._error('Unsupported Chip: ' + str(self.chip))

        self.disableWatchdog()

    def _log(self, aMsg):
        if self.verbose:
            print(aMsg)
    def _error(self, aMsg):
        print ("[Error] " + aMsg)
    def _open(self):
        self.JLink.JLINKARM_Open()
    def disableWatchdog(self):
        self._disableWatchdog()
        if self.mcm and self.sc == 1:
            self.switchToSc2()        # Switch to sc2
            self._disableWatchdog()
            self.switchToSc1()        # Switch to sc1
        elif self.mcm and self.sc == 2:
            self.switchToSc1()        # Switch to sc1
            self._disableWatchdog()
            self.switchToSc2()        # Switch to sc2
    def _loadLibrary(self):
        loader = ctypes.cdll
        if sys.platform.startswith('win'):
            dllFile = JLINK_DLL_WINDOWS_64 if platform.architecture()[0] == '64bit' else JLINK_DLL_WINDOWS_32
            library = os.path.join(os.environ['BRCM_FLASHER_SEGGER_PATH'], dllFile)
            stdcallLoader =  ctypes.windll
        elif sys.platform.startswith('linux'):
            path = os.environ['BRCM_FLASHER_SEGGER_PATH']
            soFile = JLINK_DLL_LINUX_SO6 if os.path.isfile(os.path.join(path, JLINK_DLL_LINUX_SO6)) else JLINK_DLL_LINUX_SO7
            library = os.path.join(os.environ['BRCM_FLASHER_SEGGER_PATH'], soFile)
            stdcallLoader = ctypes.cdll
        else:
            self._error('%s OS is not supported' % sys.platform)
        return loader.LoadLibrary(library), stdcallLoader.LoadLibrary(library)
    def _configure(self, aSpeed, aCore, aTargetInterface):
        self.JLink.JLINKARM_EMU_SelectByUSBSN(self.serialNumber)
        self.JLink.JLINKARM_CORE_Select(aCore)
        self.JLink.JLINKARM_TIF_Select(aTargetInterface)    # JLINKARM_TIF_JTAG
        if (self.chip == 'bcm8956x') or (self.chip == 'bcm8957x'):
            self.JLink.JLINKARM_ExecCommand(b"CORESIGHT_SetIndexAHBAPToUse = 1", 0, 0)
            if (self.mcm == True):
                # In order to choose the master inform the debugger about TAP Controller
                # position in JTAG chain
                if self.sc == 1:
                    print("\nConfigure IRPre=4; DRPre=1; IRPost=0; DRPost=0; IRLenDevice=4")
                    retVal = self.JLink.JLINKARM_CORESIGHT_Configure(b"IRPre=4;DRPre=1;IRPost=0;DRPost=0;IRLenDevice=4")
                elif self.sc == 2:
                    print("\nConfigure IRPre=0; DRPre=0; IRPost=4; DRPost=1; IRLenDevice=4")
                    retVal = self.JLink.JLINKARM_CORESIGHT_Configure(b"IRPre=0;DRPre=0;IRPost=4;DRPost=1;IRLenDevice=4")
                else:
                    retVal = -1
                    self._error("Unknown Mode is selected: " + str(self.sc))
                if (retVal < 0):
                   self._error("Error in JLINKARM_CORESIGHT_Configure")
        self.JLink.JLINKARM_SetSpeed(aSpeed)                # 5000 kHz
        self.connect()
    def connect(self):
        if self.JLink.JLINKARM_Connect() >= 0:
            self._log('Connection to target system established successfully!!')
        else:
            self._error('Connection failed')
    def _findDeviceSerialNo(self):
        if self.serialNumber == None:
            numOfDevices = self.JLink.JLINKARM_EMU_GetNumDevices()
            if numOfDevices > 0:
                self._log('Number of devices connected: ' + str(numOfDevices))
                self._open()
                if (self.JLink.JLINKARM_GetSN() >= 0):
                    self.serialNumber = self.JLink.JLINKARM_GetSN()
                else:
                    self._error("communication error")
                self.close()
            else:
                self._error("No Device Found")
    def isConnected(self):
        if self.JLink.JLINKARM_IsConnected() == 1:
            self._log("JTAG connection is open")
        else:
            self._error("Connection Failed.")
    def isOpen(self):
        if self.JLink.JLINKARM_IsOpen() == 1:
            self._log("DLL has been opened successfully.")
        else:
            self._error("DLL has not been successfully opened. No J-Link connection could be established.")
    def close(self):
        self.JLink.JLINKARM_Close()
    def refresh(self):
        self._findDeviceSerialNo()
    def _disableWatchdog(self):
        WDOG_ENABLE     = 0x01
        WdogControlAddr = JLINK_WDT_BLOCK[self.chip]["wdogControl"]
        WdogIntClrAddr  = JLINK_WDT_BLOCK[self.chip]["wdogIntClr"]
        WdogControlData = self.readReg(WdogControlAddr, 1, 4)
        print ("Watchdog Control Value: " +  str(WdogControlData))
        if (WdogControlData != None) and (WdogControlData & WDOG_ENABLE):
            self.writeReg(WdogIntClrAddr, 1, 4)
            self.writeReg(WdogControlAddr, 0, 4)
            if self.readReg(WdogControlAddr, 1, 4) == 0:
                print ("Watchdog Disabled")
            else:
                print ("Error while Disabling Watchdog")
    def getDeviceSerialNo(self):
        return self.serialNumber
    def getDeviceSerialNoList(self):
        serialNoList = []
        serialNoList.append(self.serialNumber)
        return serialNoList
    def getCurrentCore(self):
        return self.JLink.JLINKARM_CORE_GetFound()
    def reset(self):
        retVal = 0
        # Since debugger connection will be lost after resetting using JLINKARM_WriteU16
        # So, if we don't encounter any error, we'll assume that reset is done successfully.
        if self.chip == "bcm8910x" or self.chip == "bcm8908x":
            ret = self.JLink.JLINKARM_Reset()
            retVal = 0 if ret >= 0 else ret
        elif self.chip == "bcm8953x" or self.chip == "bcm8955x":
            self.JLink.JLINKARM_WriteU16(JLINK_RESET_ADDR_LEO, JLINK_RESET)
        elif self.chip == "bcm8956x" or self.chip == "bcm8957x":
            self.JLink.JLINKARM_WriteU16(JLINK_RESET_ADDR_SCORPIO, JLINK_RESET)
        if retVal == 0:
            self._log("Reset Done")
        return retVal
    def halt(self):
        ret = self.JLink.JLINKARM_Halt()
        if ret == 0:
            print("ARM core has been halted")
        else:
            print("[Error] halt failed!")
    def go(self):
        self.JLink.JLINKARM_GoEx()
        print("ARM core has been restarted")
    def isHalted(self):
        ret = self.JLink.JLINKARM_IsHalted()
        if ret < 0:
            ret = -1
        return ret
    def resetAndHalt(self):
        self.reset()
        if self.chip in ("bcm8953x", "bcm8955x"):
            self.connect()
            self.halt()
            self.JLink.JLINKARM_Reset()
        elif self.chip in ("bcm8956x", "bcm8957x"):
            self.connect()
            self.JLink.JLINKARM_Reset()
    def readCPUReg(self, aRegIndex):
        return self.JLink.JLINKARM_ReadReg(aRegIndex)
    def writeCPUReg(self, aRegIndex, aData):
        ret = self.JLink.JLINKARM_WriteReg(aRegIndex, aData)
        if ret == 0:
            self._log("Register has been written: {}    Value: 0x{:08X}".format(aRegIndex, aData))
        else:
            self._error("Error in JLINKARM_WriteReg")
    def switchToSc1(self):
        pIRPre = ctypes.c_int()
        pDRPre = ctypes.c_int()
        self.JLink.JLINKARM_GetConfigData(ctypes.byref(pIRPre), ctypes.byref(pDRPre))
        if pIRPre.value == 0 and pDRPre.value == 0:
            print("\nConfigure IRPre=4; DRPre=1; IRPost=0; DRPost=0; IRLenDevice=4")
            retVal = self.JLink.JLINKARM_CORESIGHT_Configure(b"IRPre=4;DRPre=1;IRPost=0;DRPost=0;IRLenDevice=4")
            if (retVal < 0):
               self._error("Error in JLINKARM_CORESIGHT_Configure")
        else:
            print("Already in Master Mode")
    def switchToSc2(self):
        pIRPre = ctypes.c_int()
        pDRPre = ctypes.c_int()
        self.JLink.JLINKARM_GetConfigData(ctypes.byref(pIRPre), ctypes.byref(pDRPre))
        if pIRPre.value == 4 and pDRPre.value == 1:
            print("\nConfigure IRPre=0; DRPre=0; IRPost=4; DRPost=1; IRLenDevice=4")
            retVal = self.JLink.JLINKARM_CORESIGHT_Configure(b"IRPre=0;DRPre=0;IRPost=4;DRPost=1;IRLenDevice=4")
            if (retVal < 0):
               self._error("Error in JLINKARM_CORESIGHT_Configure")
        else:
            print("Already in Slave Mode")
    def readReg(self, aAddr, aNumItems, aType, aPStatus=None):
        reg = ctypes.c_int32()
        ret = 0
        if aType == 1:
            ret = self.JLink.JLINKARM_ReadMemU8(aAddr, aNumItems, ctypes.byref(reg), aPStatus)
        elif aType == 2:
            ret = self.JLink.JLINKARM_ReadMemU16(aAddr, aNumItems, ctypes.byref(reg), aPStatus)
        elif aType == 4:
            ret = self.JLink.JLINKARM_ReadMemU32(aAddr, aNumItems, ctypes.byref(reg), aPStatus)
        else:
            ret = self.JLink.JLINKARM_ReadMemU64(aAddr, aNumItems, ctypes.byref(reg), aPStatus)
        if ret < 0:
            print("Read Reg failed for Addr: 0x{:08x}".format(aAddr))
            return None
        else:
            return reg.value
    def writeReg(self, aAddr, aData, aType):
        ret = 0
        if aType == 4:
            ret = self.JLink.JLINKARM_WriteU32(aAddr, aData)
        elif aType == 1:
            ret = self.JLink.JLINKARM_WriteU8(aAddr, aData)
        elif aType == 2:
            ret = self.JLink.JLINKARM_WriteU16(aAddr, aData)
        else:
            ret = self.JLink.JLINKARM_WriteU64(aAddr, aData)
        if ret != 0:
            print("Error in JLINKARM_WriteU32")
        return ret
    def readMem(self, aAddr, aNumBytes, aType=1):
        count    = aNumBytes // aType
        readData = [0]*count
        retVal   = 0
        if aType == 4:
            pData = (ctypes.c_int32 * len(readData))(*readData)
            ret = self.JLink.JLINKARM_ReadMemU32(aAddr, count, ctypes.byref(pData), None)
            ret = 1 if ret < 0 else 0
        elif aType == 2:
            pData = (ctypes.c_int16 * len(readData))(*readData)
            ret = self.JLink.JLINKARM_ReadMemU16(aAddr, count, ctypes.byref(pData), None)
            ret = 1 if ret < 0 else 0
        else:
            pData = (ctypes.c_int8 * len(readData))(*readData)
            ret = self.JLink.JLINKARM_ReadMem(aAddr, count, ctypes.byref(pData), None)
        if ret == 1:
            print("Error/Abort. Memory could not be read :" + str(hex(len(pData))))
            return None
        reData = [n if n >= 0 else (n + (0x100 ** aType)) for n in pData[:count]]
        return reData
    def writeMem(self, aAddr, aNumBytes, aData, aType=1):
        if aType == 1:
            pData = (ctypes.c_int8  * len(aData))(*aData)
        elif aType == 2:
            pData = (ctypes.c_int16 * len(aData))(*aData)
        elif aType == 4:
            pData = (ctypes.c_int32 * len(aData))(*aData)
        else:
            pData = (ctypes.c_int64 * len(aData))(*aData)
        ret = self.JLink.JLINKARM_WriteMem(aAddr, aNumBytes, ctypes.byref(pData))
        if ret < 0:
            print("Error in JLINKARM_WriteMem")
            return ret
        else:
            return 0
    def readArray(self, aAddr, aNumItems, aRegType):
        hexList = []
        for i in range(aNumItems):
            addr = aAddr + (i*aRegType)
            regVal = self.readReg(addr, 1, aRegType)
            hexList.append(regVal)
        return hexList
    def writeArray(self, aAddr, aData, aRegType):
        i = -1
        for i, data in enumerate(aData):
            addr = aAddr + (i*aRegType)
            self._log("[Address " + str(addr) + "] Writing data: " + str(data))
            ret = self.writeReg(addr, data, aRegType)
        print('Data Write count: ' + str(i+1))
        return (i+1)
    def readFile(self, aAddr, aTotalCount, aOutFile):
        with open(aOutFile, "ab") as f:
            rdData = self.readMem(aAddr, aTotalCount)
            for byte in rdData:
                f.write(chr(byte))
        print ("\nRead Completed:  " + str(aTotalCount))
    def writeFile(self, aInputFile, aAddr):
        totalCount = 0
        print(aInputFile)
        with open(aInputFile, "rb") as file:
            for subSector in JLINK_ReadLargeFile(file):
                currAddr = aAddr + totalCount
                self.writeMem(currAddr, len(subSector), subSector)
                totalCount += len(subSector)
        print ("\nWrite Completed:  " + str(totalCount))
        return totalCount
    def downloadFile(self, aFile, aAddr):
        if aFile.endswith(".bin"):
            ret = self.iStdCalliJLink.JLINK_DownloadFile(aFile.encode('utf-8'), aAddr)
            if ret >= 0:
                print("Download File Success at offset: 0x{:08X}  File: {}".format(aAddr, aFile))
            else:
                self._error("Download File Failed: " + str(ret))
        else:
            self._error("Only binary files are allowed.")

if __name__ == '__main__':
    chip  = None
    mcm   = False
    usage = "\n[USAGE] python jlink_interface -c <chip> (Add '-m' for mcm board)"
    opts  = []
    try:
        opts, args = getopt.getopt(sys.argv[1:], "mc:",
                    ["chip", "mcm"])
    except:
        print("Error in parsing arguments")
    for opt, arg in opts:
        if opt in ("-m", "--mcm"):
            mcm  = True
        elif opt in ("-c", "--chip"):
            chip = str(arg)
        else:
            print("Unknown argument %s" % opt)

    if chip == None:
        print(usage)
    else:
        jlink = JLINK_Interface(chip, None, aMCM=mcm, aSC=1)
        jlink.halt()
        jlink.readCPUReg(15)
        jlink.go()
        status = jlink.isHalted()
        print("STATE: {}".format(JLINK_Interface.CPU_STATUS_DICT[status]))
        jlink.close()

## @}
