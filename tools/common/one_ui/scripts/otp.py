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

##  @defgroup grp_tools_otp OTP Interface
#   @ingroup grp_one_ui
#
#   @addtogroup grp_tools_otp
#   @{
#
#   @file otp.py
#   @brief Python script for OTP.
#   @version 1.0 Changelist1

import os
import sys
sys.dont_write_bytecode = True
import getopt
import jlink_interface
import lauterbach_interface
sys.path.insert(1, os.path.join(os.path.dirname(os.path.realpath(__file__)), 'rdb'))
import bcm8956x_b0_rdb_v4
import bcm8957x_a0_rdb_v4
import bcm8953x_b1_rdb_v1
import bcm8953x_c0_rdb_v1
from otp_header import *

##  @name OTP Architecture IDs
#   @{
#   @brief Architecture IDs for OTP Interface
#
    ## @brief #otp.OTP_DEBUGGER_SEGGER()
BRCM_SWARCH_OTP_DEBUGGER_GLOBAL         = 0
    ## @brief #otp.OTP_Args
BRCM_SWARCH_OTP_ARGS_CLASS              = 1
    ## @brief #otp.OTP_Debugger
BRCM_SWARCH_OTP_DEBUGGER_CLASS          = 2
    ## @brief #otp.OTP_SysCmdRequest()
BRCM_SWARCH_OTP_SYSCMDREQUEST_PROC      = 3
    ## @brief #otp.OTP_WriteTarget()
BRCM_SWARCH_OTP_WRITETARGET_PROC        = 4
    ## @brief #otp.OTP_ReadTarget()
BRCM_SWARCH_OTP_READTARGET_PROC         = 5
    ## @brief #otp.OTP_ONEUI_Usage()
BRCM_SWARCH_OTP_ONEUI_USAGE_PROC        = 6
    ## @brief #otp.OTP_ONEUI_Main()
BRCM_SWARCH_OTP_ONEUI_MAIN_PROC         = 7
    ## @brief #otp.OTP_BCM8956X_B0_Test()
BRCM_SWARCH_OTP_BCM8956X_B0_TEST_PROC   = 8
##  @}

##  @brief OTP Debugger
#
#   Global variables for otp debugger.
#
#   @trace #BRCM_SWREQ_OTP_INTERFACE
OTP_DEBUGGER_SEGGER     = 0
OTP_DEBUGGER_LAUTERBACH = 1

##  @brief OTP Arguments
#
#   Structure for Global variables.
#
#   @trace #BRCM_SWREQ_OTP_INTERFACE
class OTP_Args:
    CHIP = None
    VERSION = None

##  @brief OTP Debugger
#
#   Class provides active debugger interface.
#
#   @trace #BRCM_SWREQ_OTP_INTERFACE
class OTP_Debugger:
    def __init__(self, aChip, aIfc, aMCM, aSC):
        serialNo = None
        self.ifc = aIfc
        if self.ifc == OTP_DEBUGGER_SEGGER:
            if aMCM == True:
                self.debugger = jlink_interface.JLINK_Interface(aChip, serialNo, aMCM, aSC)
            else:
                self.debugger = jlink_interface.JLINK_Interface(aChip, serialNo)
        elif self.ifc == OTP_DEBUGGER_LAUTERBACH:
            self.debugger = lauterbach_interface.LAUTERBACH_Interface(aChip, aMCM, aSC)
        else:
            print("[ERROR] Invalid Interface: " + str(self.ifc))
            sys.exit(1)
    def regRead(self, aRegOffset, aRegSize=REG_U32_TYPE):
        return self.debugger.readReg(aRegOffset, 1, aRegSize)
    def regWrite(self, aRegOffset, aValue, aRegSize=REG_U32_TYPE):
        return self.debugger.writeReg(aRegOffset, aValue, aRegSize)
    def master(self):
        self.debugger.switchToSc1()
    def slave(self):
        self.debugger.switchToSc2()
    def reset(self):
        self.debugger.reset()
    def close(self):
        self.debugger.close()

##  @brief OTP System commands Request.
#
#   @behavior Sync, Non-reentrant
#
#   @pre None
#
#   @param[in]      aCmd         command type
#   @param[in]      aIO          object of OTP_IOType class
#   @param[in]      aList        deebugger class object
#
#   @return errStatus
#
#   @post None
#
#   @trace #BRCM_SWREQ_OTP_INTERFACE
def OTP_SysCmdRequest(aCmd, aIO, aDebugger=None):
    ret     = BCM_ERR_INVAL_PARAMS
    chip    = OTP_Args.CHIP
    version = OTP_Args.VERSION
    if aIO != None:
        if chip == "bcm8908x":
            bcm8908x_a0_rdb_v2.OTP_SysCmdHandler(SVC_MAGIC_OTP_ID, aCmd, aIO, aDebugger)
        elif chip == "bcm8910x":
            bcm8910x_rdb_v2.OTP_SysCmdHandler(SVC_MAGIC_OTP_ID, aCmd, aIO, aDebugger)
        elif chip == "bcm8953x" or chip == "bcm8955x":
            if version == "b1":
                bcm8953x_b1_rdb_v1.OTP_SysCmdHandler(SVC_MAGIC_OTP_ID, aCmd, aIO, aDebugger)
            elif version == "c0":
                bcm8953x_c0_rdb_v1.OTP_SysCmdHandler(SVC_MAGIC_OTP_ID, aCmd, aIO, aDebugger)
            else:
                print("Incorrect Version " + version)
        elif chip == "bcm8956x":
            if version == "a0":
                bcm8956x_a0_rdb_v3.OTP_SysCmdHandler(SVC_MAGIC_OTP_ID, aCmd, aIO, aDebugger)
            elif version == "b0":
                bcm8956x_b0_rdb_v4.OTP_SysCmdHandler(SVC_MAGIC_OTP_ID, aCmd, aIO, aDebugger)
            else:
                print("Incorrect Version " + version)
        elif chip == "bcm8957x":
                bcm8957x_a0_rdb_v4.OTP_SysCmdHandler(SVC_MAGIC_OTP_ID, aCmd, aIO, aDebugger)
        else:
            print ("Incorrect Chip " + chip)
        ret = aIO.retVal
    return ret

##  @brief OTP Write
#
#   @behavior Sync, Non-reentrant
#
#   @pre None
#
#   @param[in]      aAddr            address
#   @param[in]      aData            data
#   @param[in]      aDebugger        deebugger class object
#
#   @return errStatus
#
#   @post None
#
#   @trace #BRCM_SWREQ_OTP_INTERFACE
def OTP_WriteTarget(aID, aAddr, aData, aDebugger):
    otpIO = OTP_IOType()
    otpIO.retVal = BCM_ERR_UNKNOWN
    otpIO.hwID = aID
    otpIO.addr = aAddr
    otpIO.data = aData
    return OTP_SysCmdRequest(OTP_IO_CMD_WRITE, otpIO, aDebugger)

##  @brief OTP Read
#
#   @behavior Sync, Non-reentrant
#
#   @pre None
#
#   @param[in]      aAddr            address
#   @param[in]      aData            data
#   @param[in]      aDebugger        deebugger class object
#
#   @return errStatus
#
#   @post None
#
#   @trace #BRCM_SWREQ_OTP_INTERFACE
def OTP_ReadTarget(aID, aAddr, aData, aDebugger):
    otpIO = OTP_IOType()
    retVal = BCM_ERR_INVAL_PARAMS
    if aData != None:
        otpIO.retVal = BCM_ERR_UNKNOWN
        otpIO.hwID = aID
        otpIO.addr = aAddr
        otpIO.data = aData
        retVal = OTP_SysCmdRequest(OTP_IO_CMD_READ, otpIO, aDebugger)
        if retVal != BCM_ERR_OK:
            print ("OTP_Read failed: " + str(retVal))
    return retVal

##  @brief OTP Usage Function
#
#   @behavior Sync, Non-reentrant
#
#   @pre None
#
#   @param[in]      void
#
#   @return void
#
#   @post None
#
#   @trace #BRCM_SWREQ_OTP_INTERFACE
def OTP_ONEUI_Usage():
    print("python otp.py -c <chip> -v <version> -d <debugger (0/1)> -r <row (in hex)>")
    print("python otp.py -c <chip> -v <version> -d <debugger (0/1)> -r <row (in hex)> -n <no of rows>")
    print("python otp.py -c <chip> -v <version> -d <debugger (0/1)> -r <row (in hex)> -n <no of rows> -s <mcm board (1/2)>")
    print("python otp.py -c <chip> -v <version> -d <debugger (0/1)> -w <row (in hex)> -m <data (in hex)>")
    print("python otp.py -c <chip> -v <version> -d <debugger (0/1)> -s <sc1/sc2 (1/2)> -w <row (in hex)> -m <data (in hex)>")
    sys.exit(2)

##  @brief OTP Main Function
#
#   @behavior Sync, Non-reentrant
#
#   @pre None
#
#   @param[in]      void
#
#   @return void
#
#   @post None
#
#   @trace #BRCM_SWREQ_OTP_INTERFACE
def OTP_ONEUI_Main():
    chip = None
    version = None
    debugger = 0
    size = 1
    rdRow = None
    wdRow = None
    writeValidate = False
    sc = None
    wrData = [None]
    OTP_Test1 = BCM_ERR_OK
    try:
        opts, args = getopt.getopt(sys.argv[1:], "htc:v:d:r:w:n:m:s:",
                                    ["help", "test", "chip=", "version=", "debugger=", "read=", "write=", "len=", "data=", "sc="])
    except:
        print("Error in parsing arguments")
        OTP_ONEUI_Usage()
    for opt, arg in opts:
        if opt in ("-h", "--help"):
            OTP_ONEUI_Usage()
        if opt in ("-t", "--test"):
            OTP_BCM8956X_B0_Test()
            return
        elif opt in ("-c", "--chip"):
            chip = arg
        elif opt in ("-v", "--version"):
            version = arg
        elif opt in ("-d", "--debugger"):
            debugger = int(arg)
        elif opt in ("-s", "--sc"):
            sc = int(arg)
        elif opt in ("-n", "--len"):
            size = int(arg)
        elif opt in ("-r", "--read"):
            rdRow = int(arg, 16)
        elif opt in ("-w", "--write"):
            wdRow = int(arg, 16)
        elif opt in ("-m", "--data"):
            wrData[0] = int(arg, 16)
        else:
            print("Unknown argument %s" % opt)
            OTP_ONEUI_Usage()
    if chip == None:
        print("chip not found")
        OTP_ONEUI_Usage()
    elif (chip == "bcm8956x" or chip == "bcm8953x") and version == None:
        print("version not found")
        OTP_ONEUI_Usage()
    else:
        OTP_Args.CHIP = chip
        OTP_Args.VERSION = version

    mcm = False
    if chip == "bcm8956x" and (sc == 1 or sc == 2):
        mcm = True
    elif sc != None and (sc > 2 or sc < 1):
        print("Invalid value of -s <arg>")
        OTP_ONEUI_Usage()

    if debugger != 0 and debugger != 1:
        print("Invalid debugger: " + str(debugger))
        OTP_ONEUI_Usage()

    if wdRow != None:
        if wrData[0] == None:
            print("Write Data not found")
            return
        print("Are you sure you want to write in row " +  str(wdRow) + " (" + hex(wdRow) + ") " + ": (yes = 1 | No = 0)")
        verify = input()
        if int(verify) == 1:
            writeValidate = True
        else:
            return

    # Get Debugger object
    debugger = OTP_Debugger(chip, debugger, mcm, sc)

    if writeValidate:
        print("\nOTP_Write Started...")
        readData = []
        ret = OTP_ReadTarget(OTP_HW_ID_0, wdRow, readData, debugger)
        if len(readData) > 0 and readData[0] == 0:
            print("Row is currently empty")
            ret = OTP_WriteTarget(OTP_HW_ID_0, wdRow, wrData, debugger)
            if ret == 0:
                print ("Data write successfully at row: " + str(wdRow))
            else:
                print("otp write failed: " + str(ret))
        else:
            print("Write Failed! Data is already present: " + hex(readData[0]))
    else:
        print("\nOTP_Read Started...")
        if rdRow != None:
            total = []
            currRow = rdRow
            for i in range(size):
                rdData = []
                ret = OTP_ReadTarget(OTP_HW_ID_0, currRow, rdData, debugger)
                rd = [str(hex(d).rstrip("L")) for d in rdData]
                print("Data at row " + str(currRow) + " (" + str(hex(currRow)) + ") is " + str(rd))
                currRow += 1
                total.extend(rd)
            print("\nTotal data Read: " + str(total))

    debugger.close()

    if (OTP_Test1 == BCM_ERR_OK):
        print("\n\nTest at1 result: Pass")
    else:
        print("\n\nTest at1 result: Fail")

##  @brief OTP Test Function
#
#   @behavior Sync, Non-reentrant
#
#   @pre None
#
#   @param[in]      void
#
#   @return void
#
#   @post None
#
#   @trace #BRCM_SWREQ_OTP_INTERFACE
def OTP_BCM8956X_B0_Test():
    chip = "bcm8956x"
    version = "b0"

    OTP_Args.CHIP = chip
    OTP_Args.VERSION = version

    d = raw_input("Select Debugger (SEGGER = 0  | Lauterbach = 1) : ")
    # Get Debugger object
    sc1 = 1             # Select sc1
    mcm = True
    debugger = OTP_Debugger(chip, int(d), mcm, sc1)

    total = []
    size = 5
    rdRow = 0x258
    currRow = rdRow
    for i in range(size):
        rdData = []
        ret = OTP_ReadTarget(OTP_HW_ID_0, currRow, rdData, debugger)
        rd = [str(hex(d).rstrip("L")) for d in rdData]
        print("Data at row " + str(currRow) + " (" + str(hex(currRow)) + ") is " + str(rd))
        currRow += 1
        total.extend(rd)

    debugger.slave()        # Switch to sc2

    total = []
    currRow = rdRow
    for i in range(size):
        rdData = []
        ret = OTP_ReadTarget(OTP_HW_ID_0, currRow, rdData, debugger)
        rd = [str(hex(d).rstrip("L")) for d in rdData]
        print("Data at row " + str(currRow) + " (" + str(hex(currRow)) + ") is " + str(rd))
        currRow += 1
        total.extend(rd)

    debugger.master()       # Switch to sc1

    total = []
    currRow = 0x25d
    for i in range(size):
        rdData = []
        ret = OTP_ReadTarget(OTP_HW_ID_0, currRow, rdData, debugger)
        rd = [str(hex(d).rstrip("L")) for d in rdData]
        print("Data at row " + str(currRow) + " (" + str(hex(currRow)) + ") is " + str(rd))
        currRow += 1
        total.extend(rd)

    debugger.slave()         # Switch to sc2

    total = []
    currRow = 0x25d
    for i in range(size):
        rdData = []
        ret = OTP_ReadTarget(OTP_HW_ID_0, currRow, rdData, debugger)
        rd = [str(hex(d).rstrip("L")) for d in rdData]
        print("Data at row " + str(currRow) + " (" + str(hex(currRow)) + ") is " + str(rd))
        currRow += 1
        total.extend(rd)

    debugger.close()

if __name__ == '__main__':
    OTP_ONEUI_Main()

## @}
