#!/usr/bin/python3

# $Id$
# $Copyright: Copyright 2020-2022 Broadcom Limited.
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

##  @defgroup grp_tools_lauterbach Lauterbach Interface
#   @ingroup grp_one_ui
#
#   @addtogroup grp_tools_lauterbach
#   @{
#
#   Lauterbach Interface for One UI.
#
#   @file lauterbach_interface.py
#   @brief Python script for Lauterbach Interface
#   @version 1.0 Changelist1

import ctypes
import time
import sys
import os
import re
import getopt
import platform
import enum
import psutil
import subprocess

##  @name Lauterbach Architecture IDs
#   @{
#   @brief Architecture IDs for Lauterbach Flasher
#
    ## @brief #lauterbach_interface.LAUTERBACH_LEO_RESET_ADDR()
BRCM_SWARCH_LAUTERBACH_LEO_RESET_ADDR_GLOBAL        = 0
    ## @brief #lauterbach_interface.LAUTERBACH_SCORPIO_RESET_ADDR()
BRCM_SWARCH_LAUTERBACH_SCORPIO_RESET_ADDR_GLOBAL    = 1
    ## @brief #lauterbach_interface.LAUTERBACH_GLOBAL_SRST_EN()
BRCM_SWARCH_LAUTERBACH_GLOBAL_SRST_EN_GLOBAL        = 2
    ## @brief #lauterbach_interface.LAUTERBACH_SRST_CHIP()
BRCM_SWARCH_LAUTERBACH_SRST_CHIP_GLOBAL             = 3
    ## @brief #lauterbach_interface.LAUTERBACH_RESET()
BRCM_SWARCH_LAUTERBACH_RESET_GLOBAL                 = 4
    ## @brief #lauterbach_interface.LAUTERBACH_WDT_BLOCK()
BRCM_SWARCH_LAUTERBACH_WDT_BLOCK_GLOBAL             = 5
    ## @brief #lauterbach_interface.LAUTERBACH_DLL_WINDOWS_32()
BRCM_SWARCH_LAUTERBACH_DLL_GLOBAL                   = 6
    ## @brief #lauterbach_interface.LAUTERBACH_Interface
BRCM_SWARCH_LAUTERBACH_INTERFACE_CLASS              = 7
    ## @brief #lauterbach_interface.LAUTERBACH_PracticeInterpreterState
BRCM_SWARCH_LAUTERBACH_PRACTICE_INTERPRETER_CLASS   = 8
##  @}

##  @brief Leo Reset Address
#
#   Macro for Leo Reset Address
#
#   @trace #BRCM_SWREQ_LAUTERBACH_INTERFACE
LAUTERBACH_LEO_RESET_ADDR       = 0x0a820022

##  @brief Scorpio Reset Address
#
#   Macro for Scorpio Reset Address
#
#   @trace #BRCM_SWREQ_LAUTERBACH_INTERFACE
LAUTERBACH_SCORPIO_RESET_ADDR   = 0x4a820024

##  @brief Global Soft Reset Enable
#
#   Global Soft Reset Enable value
#
#   @trace #BRCM_SWREQ_LAUTERBACH_INTERFACE
LAUTERBACH_GLOBAL_SRST_EN       = 0x1

##  @brief Soft Reset Chip
#
#   Soft Reset Chip value
#
#   @trace #BRCM_SWREQ_LAUTERBACH_INTERFACE
LAUTERBACH_SRST_CHIP            = 0x1

##  @brief Lauterbach Reset
#
#   Lauterbach Reset Value
#
#   @trace #BRCM_SWREQ_LAUTERBACH_INTERFACE
LAUTERBACH_RESET        = ((LAUTERBACH_GLOBAL_SRST_EN << 15) | (LAUTERBACH_SRST_CHIP))  # 0x8001

##  @brief JTag DLL Files
#
#   DLL file for windows 32 and 64.
#
#   @trace #BRCM_SWREQ_LAUTERBACH_INTERFACE
LAUTERBACH_DLL_WINDOWS_32 = 't32api.dll'
LAUTERBACH_DLL_WINDOWS_64 = 't32api64.dll'

##  @brief Lauterbach Control Address
#
#   Dictionary with keys as chip family and values as watchdog control address.
#
#   @trace #BRCM_SWREQ_LAUTERBACH_INTERFACE
LAUTERBACH_WDT_BLOCK = {"bcm8908x": {"wdogControl": 0xE0100008, "wdogIntClr": 0xE010000C},
                        "bcm8910x": {"wdogControl": 0xE0100008, "wdogIntClr": 0xE010000C},
                        "bcm8953x": {"wdogControl": 0x00145008, "wdogIntClr": 0x0014500C},
                        "bcm8955x": {"wdogControl": 0x00145008, "wdogIntClr": 0x0014500C},
                        "bcm8956x": {"wdogControl": 0x40145008, "wdogIntClr": 0x4014500C},
                        "bcm8957x": {"wdogControl": 0x40145008, "wdogIntClr": 0x4014500C},
                        "bcm8958x": {"wdogControl": 0x40145008, "wdogIntClr": 0x4014500C}}

##  @brief Lauterbach cmm practice script state
#
#   Class which provides status of practice script state
#
#   @trace #BRCM_SWREQ_LAUTERBACH_INTERFACE
class LAUTERBACH_PracticeInterpreterState(enum.IntEnum):
    UNKNOWN = -1
    NOT_RUNNING = 0
    RUNNING = 1
    DIALOG_OPEN = 2

##  @brief Lauterbach Interface class
#
#   Class which provides Lauterbach interface.
#
#   @trace #BRCM_SWREQ_LAUTERBACH_INTERFACE
class LAUTERBACH_Interface:
    TARGET_STATUS_DOWN          = 0
    TARGET_STATUS_NO_ACCESS     = 1
    TARGET_STATUS_STOPPED       = 2
    TARGET_STATUS_RUNNING       = 3
    ENVIRONMENT_VARIABLE_T32    = "BRCM_FLASHER_T32_PATH"
    T32MARM_APP                 = "t32marm.exe"
    CPU_STATUS_DICT = {-1: "CPU_STATUS_UNKNOWN", 0: "CPU_STATUS_RUNNING", 1: "CPU_STATUS_STOPPED"}
    def __init__(self, aChip, aMCM=False, aSC=None):
        self.chip = str(aChip)
        self.mcm  = aMCM
        self.sc   = aSC
        self.retry = 0

        self._openLauterbach()

        # Load TRACE32 Remote API DLL
        loader = ctypes.cdll
        if sys.platform.startswith('win'):
            dllFile = LAUTERBACH_DLL_WINDOWS_64 if platform.architecture()[0] == '64bit' else LAUTERBACH_DLL_WINDOWS_32
            T32_PATH    = os.getenv('BRCM_FLASHER_T32_PATH')
            T32_DEFAULT = "C:\\T32"
            if T32_PATH == None and os.path.isdir(T32_DEFAULT) == True:
                T32_PATH = T32_DEFAULT
            elif T32_PATH == None:
                self._error("BRCM_FLASHER_T32_PATH not found in Environment Variable.")
            library = os.path.join(T32_PATH, 'demo', 'api', 'capi', 'dll', dllFile)
        else:
            self._error('%s OS is not supported' % sys.platform)
        self.t32api = loader.LoadLibrary(library)

        self.T32_Config(aMCM, aSC)

        if self.chip != 'bcm8958x':
            self.disableWatchdog()

    def _error(self, aMsg):
        print ("[Error] " + aMsg)

    def _isT32Open(self):
        processList = []
        eProcess = re.compile("(?<=name=').*?(?=',)")
        for strProcess in list(str(process) for process in psutil.process_iter()):
            if eProcess.search(strProcess):
                processList.append(eProcess.search(strProcess).group())
        return self.T32MARM_APP in processList

    def _openLauterbach(self):
        if self._isT32Open() == False:
            print("opening TRACE32 PowerView...")
            if sys.platform.startswith('win'):
                if self.ENVIRONMENT_VARIABLE_T32 in os.environ:
                    # Start TRACE32 instance
                    process = subprocess.Popen([os.environ[self.ENVIRONMENT_VARIABLE_T32] + '/bin/windows64/' + self.T32MARM_APP])
                    # Wait until the TRACE32 instance is started
                    time.sleep(5)
                else:
                    print("Environment variable not found: " + self.ENVIRONMENT_VARIABLE_T32)
        else:
            print("TRACE32 PowerView is running...")

    def _disableWatchdog(self):
        WDOG_ENABLE     = 0x01
        WdogControlAddr = LAUTERBACH_WDT_BLOCK[self.chip]["wdogControl"]
        WdogIntClrAddr  = LAUTERBACH_WDT_BLOCK[self.chip]["wdogIntClr"]
        WdogControlData = self.readReg(WdogControlAddr, 1, 4)
        print ("Watchdog Control Value: " + str(WdogControlData))
        if (WdogControlData != None) and (WdogControlData & WDOG_ENABLE):
            self.writeReg(WdogIntClrAddr, 1, 4)
            self.writeReg(WdogControlAddr, 0, 4)
            if self.readReg(WdogControlAddr, 1, 4) == 0:
                print ("Watchdog Disabled")
            else:
                print ("Error while Disabling Watchdog")

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

    def T32_exec(self, aCmd):
        retVal = self.t32api.T32_Cmd(aCmd)
        if (retVal != 0):
            print("[ERROR] {}".format(aCmd.decode()))
        else:
            print("[Success] {}".format(aCmd.decode()))
        return retVal

    def T32_SetDAP(self, aIrPost, aIrPre, aDrPost, aDrPre):
        self.T32_exec("SYStem.CONFIG DAPIRPOST {}".format(aIrPost).encode('UTF-8'))
        self.T32_exec("SYStem.CONFIG DAPIRPRE {}".format(aIrPre).encode('UTF-8'))
        self.T32_exec("SYStem.CONFIG DAPDRPOST {}".format(aDrPost).encode('UTF-8'))
        self.T32_exec("SYStem.CONFIG DAPDRPRE {}".format(aDrPre).encode('UTF-8'))
        self.T32_exec(b"SYStem.MemAccess DAP")
        self.T32_exec(b"SYStem.Option DUALPORT ON")

    def T32_Config(self, aMCM, aSC):
        # TRACE32 Debugger or TRACE32 Instruction Set Simulator as debug device
        T32_DEV = 1

        # TRACE32 control commands
        retVal = self.t32api.T32_Init()
        if (retVal != 0):
            print("Error in T32_Init")
        retVal = self.t32api.T32_Attach(T32_DEV)
        if (retVal != 0):
            print("Error in T32_Attach. Trying again to attach...")
            self.close()
            if self.retry < 10:
                self.retry += 1
                self.T32_Config(aMCM, aSC)
        else:
            self.retry = 0
            if (self.chip == 'bcm8910x' or self.chip == 'bcm8908x'):
                self.reset()
                time.sleep(0.2)
                self.T32_exec(b"Reset")
                self.T32_exec(b"sys.option ENRESET off")
                self.T32_exec(b"SYS.JTAGCLOCK 20MHz")
                self.T32_exec(b"SYStem.CONFIG  MEMORYACCESSPORT 0")
                self.T32_exec(b"SYStem.CONFIG AXIACCESSPORT 0")
                self.T32_exec(b"SYStem.CONFIG  DEBUGACCESSPORT  1")
                self.T32_exec(b"SYStem.CPU CortexM7")
                self.T32_SetDAP(aIrPost="1F", aDrPost="1", aIrPre="0", aDrPre="0")
                self.T32_exec(b"sys.mode.attach")
                self.T32_exec(b"break")
                time.sleep(1)
                retVal = self.t32api.T32_SetMemoryAccessClass("EAXI")
                if (retVal != 0):
                    print("Error in T32_SetMemoryAccessClass")
            elif ((self.chip == 'bcm8953x') or (self.chip == 'bcm8955x')):
                self.T32_exec(b"Reset")
                self.T32_exec(b"sys.option ENRESET ON")
                self.T32_exec(b"sys.cpu CORTEXR4")
                self.T32_exec(b"SYS.JTAGCLOCK 20MHz")
                self.T32_exec(b"SYSTEM.MULTICORE COREBASE 0xc0000000")
                self.T32_exec(b"SYStem.MultiCore MEMORYACCESSPORT 0")
                self.T32_exec(b"SYStem.MultiCore DEBUGACCESSPORT 0")
                self.T32_exec(b"SYStem.CONFIG DAPIRPRE 27.")
                self.T32_exec(b"SYStem.Option DAPNOIRCHECK ON")
                self.T32_exec(b"SYStem.MemAccess DAP")
                self.T32_exec(b"SYStem.Option DUALPORT ON")
                self.T32_exec(b"sys.option pwrDWN ON")
                self.T32_exec(b"sys.mode.attach")
                time.sleep(1)
                self.T32_exec(b"break")
            elif self.chip == 'bcm8956x':
                self.T32_exec(b"Reset")
                self.T32_exec(b"sys.option ENRESET ON")
                self.T32_exec(b"sys.cpu CORTEXM7")
                self.T32_exec(b"SYS.JTAGCLOCK 20MHz")
                self.T32_exec(b"SYStem.MultiCore MEMORYACCESSPORT 1")
                self.T32_exec(b"SYStem.MultiCore DEBUGACCESSPORT 2")
                if aMCM:
                    if aSC == 1:
                        print("\nConfigure IRPre=4; DRPre=1; IRPost=0; DRPost=0")
                        self.T32_SetDAP(aIrPost="0", aIrPre="4", aDrPost="0", aDrPre="1")
                    elif aSC == 2:
                        print("\nConfigure IRPre=0; DRPre=0; IRPost=4; DRPost=1")
                        self.T32_SetDAP(aIrPost="4", aIrPre="0", aDrPost="1", aDrPre="0")
                    else:
                        print("[Error] Unknown Mode is selected: " + str(aSC))
                else:
                    self.T32_exec(b"SYStem.MemAccess DAP")
                    self.T32_exec(b"SYStem.Option DUALPORT ON")
                self.T32_exec(b"sys.mode.attach")
                time.sleep(1)
                self.T32_exec(b"break")
            elif self.chip == 'bcm8957x':
                # self.T32_exec(b"Reset")
                self.T32_exec(b"sys.option ENRESET ON")
                self.T32_exec(b"sys.cpu CORTEXM7")
                self.T32_exec(b"SYS.JTAGCLOCK 20MHz")
                self.T32_exec(b"SYStem.MultiCore MEMORYACCESSPORT 1")
                self.T32_exec(b"SYStem.MultiCore DEBUGACCESSPORT 2")
                print("\nConfigure IRPre=0; DRPre=0; IRPost=0x16; DRPost=1")
                self.T32_SetDAP(aIrPost="22.", aIrPre="0", aDrPost="1", aDrPre="0")
                self.T32_exec(b"sys.mode.attach")
                time.sleep(1)
                self.T32_exec(b"break")
            elif self.chip == 'bcm8958x':
                self.T32_exec(b"Reset")
                self.T32_exec(b"sys.option ENRESET ON")
                self.T32_exec(b"SYStem.JtagClock 100khz")
                self.T32_exec(b"SYStem.CPU CortexM7")
                self.T32_exec(b"SYStem.CONFIG MEMORYACCESSPORT 1")
                self.T32_exec(b"SYStem.CONFIG DEBUGACCESSPORT 2")
                self.T32_SetDAP(aIrPost="25.", aIrPre="4", aDrPost="1", aDrPre="1")
                self.T32_exec(b"sys.mode.attach")
                time.sleep(1)
                self.T32_exec(b"break")
            else:
                print(self.chip,"platform is not supported.")

    def runCmm(self, aCmmFile):
        print("Executing: {}".format(aCmmFile))
        retVal = self.t32api.T32_Cmd("CD.DO \"{}\" ".format(aCmmFile).encode('UTF-8'))
        if (retVal != 0):
            print("Error in executing cmm !!!")
        state = ctypes.c_int(LAUTERBACH_PracticeInterpreterState.UNKNOWN)
        rc = 0
        while rc==0 and not state.value == LAUTERBACH_PracticeInterpreterState.NOT_RUNNING:
            rc = self.t32api.T32_GetPracticeState(ctypes.byref(state))
        print("Executed cmm !!!")
        time.sleep(2)

    def T32_RESET_WAIT_TIME(self):
        self.T32_exec(b"system.RESETTARGET")
        time.sleep(0.2)

    def reset(self):
        if (self.chip == "bcm8910x" or self.chip == "bcm8908x"):
            retVal = self.T32_exec(b"Reset")
            retVal = self.T32_exec(b"SYStem.RESetTarget")
        elif (self.chip == "bcm8953x" or self.chip == "bcm8955x"):
            retVal = self.writeReg(LAUTERBACH_LEO_RESET_ADDR, LAUTERBACH_RESET, 2)
        elif (self.chip == "bcm8956x" or self.chip == "bcm8957x" or self.chip == "bcm8958x"):
            retVal = self.writeReg(LAUTERBACH_SCORPIO_RESET_ADDR, LAUTERBACH_RESET, 2)
        else:
            print(self.chip, "platform is not supported.")
        return retVal

    def halt(self):
        self.T32_exec(b"break")

    def go(self):
        self.T32_exec(b"go")

    def getStatus(self):
        pStatus = [0]
        value  = (ctypes.c_uint32 * len(pStatus))(*pStatus)
        self.t32api.T32_GetState(value)
        return value[0]

    def isHalted(self):
        ret = self.getStatus()
        if ret == LAUTERBACH_Interface.TARGET_STATUS_STOPPED:
            return 1
        elif ret == LAUTERBACH_Interface.TARGET_STATUS_RUNNING:
            return 0
        else:
            return -1

    def resetAndHalt(self):
        self.T32_RESET_WAIT_TIME()
        self.T32_exec(b"sys.mode.attach")
        self.T32_exec(b"break")

    def downloadFile(self, aFile, aAddr):
        retVal = self.t32api.T32_Cmd("DATA.Load.BINARY \"{}\" 0x{:08X}".format(aFile, aAddr).encode('UTF-8'))
        if retVal != 0:
            print("Download File Failed. File: {}".format(aFile))
        else:
            print("Download File Success at offset: 0x{:08X}  File: {}".format(aAddr, aFile))

    def writeCPUReg(self, aRegIndex, aData):
        retVal = self.t32api.T32_WriteRegisterByName("R{}".format(aRegIndex).encode('UTF-8'), aData, 0x0)
        if retVal == 0:
            print("Register has been written: {}    Value: 0x{:08X}".format(aRegIndex, aData))
        else:
            print("Error in writeCPUReg: {}".format(aRegIndex))

    def readCPUReg(self, aRegIndex):
        list1 = [0]
        list2 = [0]
        value  = (ctypes.c_uint32 * len(list1))(*list1)
        hvalue = (ctypes.c_uint32 * len(list2))(*list2)
        retVal = self.t32api.T32_ReadRegisterByName("R{}".format(aRegIndex).encode('UTF-8'), value, hvalue)
        if retVal == 0:
            print("Register: {}    Value: 0x{:08X}  hValue: 0x{:08X}".format(aRegIndex, value[0], hvalue[0]))
        else:
            print("Error in ReadCPUReg: {}".format(aRegIndex))
        return value[0]

    def getDeviceSerialNoList(self):
        rc = self.t32api.T32_Cmd(b"EVAL VERSION.SERIAL()")
        eval_string = ctypes.create_string_buffer(256)
        rc = self.t32api.T32_EvalGetString(ctypes.byref(eval_string))
        return [(eval_string.value).decode()]

    def switchToSc1(self):
        self.close()
        self.T32_Config(True, 1)
    def switchToSc2(self):
        self.close()
        self.T32_Config(True, 2)

    def writeReg(self, aAddr, aData, aType):
        retVal = -1
        aData = "%x" % aData
        if (aType == 4):
            if self.chip == 'bcm8910x' or self.chip == 'bcm8908x':
                cmd = 'D.S EAXI:' + str(hex(aAddr)) + ' %LONG ' + '0x' + str(aData)
            else:
                cmd = 'PER.Set ' + str(hex(aAddr)) + ' %LONG ' + '0x' + str(aData)
            cmd = cmd.encode('UTF-8')
            retVal = self.t32api.T32_Cmd(cmd)
            if (retVal != 0):
                print("Error in writeReg")
        elif (aType == 2):
            if self.chip == 'bcm8910x' or self.chip == 'bcm8908x':
                cmd = 'D.S EAXI:' + str(hex(aAddr)) + ' %WORD ' + '0x' + str(aData)
            else:
                cmd = 'PER.Set ' + str(hex(aAddr)) + ' %WORD ' + '0x' + str(aData)
            cmd = cmd.encode('UTF-8')
            retVal = self.t32api.T32_Cmd(cmd)
            if (retVal != 0):
                print("Error in writeReg")
        else:
            if self.chip == 'bcm8910x' or self.chip == 'bcm8908x':
                cmd = 'D.S EAXI:' + str(hex(aAddr)) + ' %BYTE ' + '0x' + str(aData)
            else:
                cmd = 'PER.Set ' + str(hex(aAddr)) + ' %BYTE ' + '0x' + str(aData)
            cmd = cmd.encode('UTF-8')
            retVal = self.t32api.T32_Cmd(cmd)
            if (retVal != 0):
                print("Error in writeReg")
        return retVal

    def readReg(self, aAddr, aNumItems, aType):
        byteData = self.readMem(aAddr, aType)
        data = None
        if (byteData is not None):
            if aType == 1:
                data = byteData[0]
            elif aType == 2:
                data = (byteData[1] << 8) | (byteData[0])
            elif aType == 3:
                data = (byteData[2] << 16) | (byteData[1] << 8) | (byteData[0])
            else:
                data = (byteData[3] << 24) | (byteData[2] << 16) | (byteData[1] << 8) | (byteData[0])
        else:
            print("Error in readReg")
        return data

    def writeMem(self, aAddr, aNumBytes, aData, aType=1):
        if aType == 1:
            pData = (ctypes.c_int8  * len(aData))(*aData)
        elif aType == 2:
            pData = (ctypes.c_int16 * len(aData))(*aData)
        elif aType == 4:
            pData = (ctypes.c_int32 * len(aData))(*aData)
        else:
            pData = (ctypes.c_int64 * len(aData))(*aData)

        retVal = self.t32api.T32_WriteMemory(aAddr, 0x0, pData, aNumBytes)
        if (retVal != 0):
            print('Error in T32_WriteMemory', hex(aAddr))
        return retVal

    def readMem(self, aAddr, aNumBytes, aType=1):
        if aNumBytes % aType != 0:
            print("NumBytes {} should be divisible by {}".format(aNumBytes, aType)); sys.exit(1)
        readData = [0]*aNumBytes
        pData = (ctypes.c_int8 * len(readData))(*readData)
        retVal = self.t32api.T32_ReadMemory(aAddr, 0x0, pData, aNumBytes)
        if (retVal != 0):
            print('Error in T32_ReadMemory 0x{:08X}, len {}'.format(aAddr, aNumBytes))
            return None
        else:
            reData = [n if n >= 0 else n + 256 for n in pData[:aNumBytes]]
            ret = []
            if aType == 4:
                for i in range(0, len(reData), 4):
                    ret.append(reData[i+3]<<24 | reData[i+2]<<16 | reData[i+1]<<8| reData[i])
            elif aType == 2:
                for i in range(0, len(reData), 2):
                    ret.append(reData[i+1]<<8| reData[i])
            else:
                ret = reData
            return ret

    def readArray(self, aAddr, aNumItems, aRegType):
        hexList = []
        for i in range(aNumItems):
            addr = aAddr + (i*aRegType)
            regVal = self.readReg(addr, 1, aRegType)
            hexList.append(regVal)
        return hexList

    # Release communication channel
    def close(self):
        retVal = self.t32api.T32_Exit()

if __name__ == '__main__':
    chip  = None
    mcm   = False
    usage = "\n[USAGE] python lauterbach_interface -c <chip> (Add '-m' for mcm board)"
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
            chip        = str(arg)
        else:
            print("Unknown argument %s" % opt)

    if chip == None:
        print(usage)
    else:
        jtag = LAUTERBACH_Interface(chip, aMCM=mcm, aSC=1)
        jtag.readCPUReg(15)
        jtag.go()
        status = jtag.isHalted()
        print("STATE: {}".format(LAUTERBACH_Interface.CPU_STATUS_DICT[status]))

        jtag.close()

## @}
