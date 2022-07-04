#!/usr/bin/python3

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

##  @defgroup grp_tools_mdio MDIO Interface
#   @ingroup grp_one_ui
#
#   @addtogroup grp_tools_mdio
#   @{
#
#   @file mdio.py
#   @brief Python script for MDIO.
#   @version 1.0 Changelist1

import os
import re
import sys
import time
sys.dont_write_bytecode = True
import getopt
import jlink_interface
import lauterbach_interface
sys.path.insert(1, os.path.join(os.path.dirname(os.path.realpath(__file__)), 'rdb'))
from bcm8910x_mdio_rdb import *

##  @name MDIO Architecture IDs
#   @{
#   @brief Architecture IDs for MDIO Interface
#
    ## @brief #mdio.MDIO_REGS()
BRCM_SWARCH_MDIO_REGS_GLOBAL            = 0
    ## @brief #mdio.MDIO_DEBUGGER()
BRCM_SWARCH_MDIO_DEBUGGER_GLOBAL        = 1
    ## @brief #mdio.MDIO_Debugger
BRCM_SWARCH_MDIO_DEBUGGER_CLASS         = 2
    ## @brief #mdio.MDIO_Interface
BRCM_SWARCH_MDIO_INTERFACE_CLASS        = 3
    ## @brief #mdio.MDIO_Error()
BRCM_SWARCH_MDIO_ERROR_PROC             = 4
    ## @brief #mdio.MDIO_Usage()
BRCM_SWARCH_MDIO_USAGE_PROC             = 5
    ## @brief #mdio.MDIO_Main()
BRCM_SWARCH_MDIO_MAIN_PROC              = 6
##  @}

##  @brief MDIO Registes
#
#   MDIO register structure global variable.
#
#   @trace #BRCM_SWREQ_MDIO_INTERFACE
MDIO_REGS = [
    MDIO_RDBType(MDIO_BASE0),
    MDIO_RDBType(MDIO_BASE1),
    MDIO_RDBType(MDIO_BASE2)
]

##  @brief MDIO Debugger
#
#   Global variables for mdio debugger.
#
#   @trace #BRCM_SWREQ_MDIO_INTERFACE
MDIO_DEBUGGER            = None
MDIO_DEBUGGER_SEGGER     = 0
MDIO_DEBUGGER_LAUTERBACH = 1

##  @brief MDIO Debugger Class
#
#   Class provides active debugger interface.
#
#   @trace #BRCM_SWREQ_MDIO_INTERFACE
class MDIO_Debugger:
    def __init__(self, aChip, aIfc, aMCM, aSC):
        serialNo = None
        self.ifc = aIfc
        if self.ifc == MDIO_DEBUGGER_SEGGER:
            if aMCM == True:
                self.debugger = jlink_interface.JLINK_Interface(aChip, serialNo, aMCM, aSC)
            else:
                self.debugger = jlink_interface.JLINK_Interface(aChip, serialNo)
        elif self.ifc == MDIO_DEBUGGER_LAUTERBACH:
            self.debugger = lauterbach_interface.MDIO_DEBUGGER_LAUTERBACH_Interface(aChip, aMCM, aSC)
        else:
            print("[ERROR] Invalid Interface: " + str(self.ifc))
            sys.exit(1)
    def regRead(self, aRegOffset):
        return self.debugger.readReg(aRegOffset, 1, 4)
    def regWrite(self, aRegOffset, aValue):
        return self.debugger.writeReg(aRegOffset, aValue, 4)
    def reset(self):
        self.debugger.reset()
    def close(self):
        self.debugger.close()


##  @brief MDIO Interface Class
#
#   Main class which provides read/write API.
#
#   @trace #BRCM_SWREQ_MDIO_INTERFACE
class MDIO_Interface:
    def __init__(self, aInstance):
        self.instance = aInstance

    def _CL22Xfer(self, aOpCode, slaveAddr, regAddr, regData=None):
        regVal = ((1 << MDIO_CMD_SB_SHIFT) & MDIO_CMD_SB_MASK)                      \
               | ((aOpCode << MDIO_CMD_OP_SHIFT) & MDIO_CMD_OP_MASK)                \
               | ((slaveAddr << MDIO_CMD_PA_SHIFT) & MDIO_CMD_PA_MASK)              \
               | ((regAddr << MDIO_CMD_RA_SHIFT) & MDIO_CMD_RA_MASK)                \
               | ((0x2 << MDIO_CMD_TA_SHIFT) & MDIO_CMD_TA_MASK)
        if (MDIO_CMD_OPCODE_CL22_WRITE == aOpCode):
            regVal |= (regData & MDIO_CMD_MDATA_MASK)
        MDIO_DEBUGGER.regWrite(MDIO_REGS[self.instance].cmd, regVal)

    def _CL45Xfer(self, aOpCode, slaveAddr, regAddr, deviceType, regData=None):
        regVal = ((0 << MDIO_CMD_SB_SHIFT) & MDIO_CMD_SB_MASK)                      \
               | ((aOpCode << MDIO_CMD_OP_SHIFT) & MDIO_CMD_OP_MASK)                \
               | ((slaveAddr << MDIO_CMD_PA_SHIFT) & MDIO_CMD_PA_MASK)              \
               | ((deviceType << MDIO_CMD_RA_SHIFT) & MDIO_CMD_RA_MASK)             \
               | ((0x2 << MDIO_CMD_TA_SHIFT) & MDIO_CMD_TA_MASK)
        if (MDIO_CMD_OPCODE_CL45_WRITE_ADDR == aOpCode):
            regVal |= (regAddr & MDIO_CMD_MDATA_MASK)
        elif (MDIO_CMD_OPCODE_CL45_WRITE_DATA == aOpCode):
            regVal |= (regData & MDIO_CMD_MDATA_MASK)
        else:
            pass
        MDIO_DEBUGGER.regWrite(MDIO_REGS[self.instance].cmd, regVal)

    def _pollingCtrl(self, aMASK, aOpcode):
        timer = 10
        regVal = aMASK & MDIO_DEBUGGER.regRead(MDIO_REGS[self.instance].ctrl)
        while regVal != 0 and timer > 0:
            timer -= 1;
            time.sleep(0.01)
            regVal = aMASK & MDIO_DEBUGGER.regRead(MDIO_REGS[self.instance].ctrl)
        if timer == 0 and regVal != 0:
            print("[Error] Time out error occurred: " + str(aOpcode));  sys.exit(1)
        return regVal

    def MDIO_ReadCL22(self, pAddress, rAddress):
        ret = -1
        self._CL22Xfer(MDIO_CMD_OPCODE_CL22_READ, pAddress, rAddress)
        regVal = self._pollingCtrl(MDIO_CTRL_BSY_MASK, MDIO_CMD_OPCODE_CL22_READ)
        if regVal == 0:
            ret = MDIO_DEBUGGER.regRead(MDIO_REGS[self.instance].cmd) & MDIO_CMD_MDATA_MASK
        return ret

    def MDIO_ReadCL45(self, pAddress, rAddress, deviceType):
        ret = -1
        self._CL45Xfer(MDIO_CMD_OPCODE_CL45_WRITE_ADDR, pAddress, rAddress, deviceType)
        regVal = self._pollingCtrl(MDIO_CTRL_BSY_MASK, MDIO_CMD_OPCODE_CL45_WRITE_ADDR)
        if regVal == 0:
            self._CL45Xfer(MDIO_CMD_OPCODE_CL45_READ, pAddress, rAddress, deviceType)
            regVal = self._pollingCtrl(MDIO_CTRL_BSY_MASK, MDIO_CMD_OPCODE_CL45_READ)
            if (regVal == 0):
                ret = MDIO_DEBUGGER.regRead(MDIO_REGS[self.instance].cmd) & MDIO_CMD_MDATA_MASK
        return ret

    def MDIO_WriteCL22(self, pAddress, rAddress, aValue):
        self._CL22Xfer(MDIO_CMD_OPCODE_CL22_WRITE, pAddress, rAddress, aValue)
        regVal = self._pollingCtrl(MDIO_CTRL_BSY_MASK, MDIO_CMD_OPCODE_CL22_WRITE)
        if regVal == 0:
            print("Write done successfully!")

    def MDIO_WriteCL45(self, pAddress, rAddress, deviceType, aValue):
        self._CL45Xfer(MDIO_CMD_OPCODE_CL45_WRITE_ADDR, pAddress, rAddress, deviceType)
        regVal = self._pollingCtrl(MDIO_CTRL_BSY_MASK, MDIO_CMD_OPCODE_CL45_WRITE_ADDR)
        if regVal == 0:
            self._CL45Xfer(MDIO_CMD_OPCODE_CL45_WRITE_DATA, pAddress, rAddress, deviceType, aValue);
            regVal = self._pollingCtrl(MDIO_CTRL_BSY_MASK, MDIO_CMD_OPCODE_CL45_WRITE_DATA)
            if regVal == 0:
                print("Write done successfully!")

##  @brief MDIO Error Function
#
#   This function is called during the error condition.
#
#   @behavior Sync, Non-reentrant
#
#   @pre None
#
#   @param[in]      aMsg
#
#   @return void
#
#   @post None
#
#   @trace #BRCM_SWREQ_MDIO_INTERFACE
def MDIO_Error(aMsg):
    print("[Error] " + str(aMsg) + "\n")
    MDIO_Usage()

##  @brief MDIO Usage Function
#
#   Print usage for mdio script.
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
#   @trace #BRCM_SWREQ_MDIO_INTERFACE
def MDIO_Usage():
    print("\n$ python mdio.py -c <chip> -d <debugger (0/1)> -m <mode (22/45)> -o <operation (r/w)> -p <raddr> -r <paddr> -i <mdio instance> -v <value> -t <device type>")
    print("\nE.g. Reading opertion in hydra using segger debugger in CL22 mode:")
    print("$ python mdio.py -c bcm8910x -d 0 -m 22 -o r -p <raddr> -r <paddr> -i 0")
    print("\nNOTE: -t <device type> is needed only for CL45 mode")
    sys.exit(2)

##  @brief MDIO Main Function
#
#   Main function of mdio script.
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
#   @trace #BRCM_SWREQ_MDIO_INTERFACE
def MDIO_Main():
    chip      = None
    debugger  = 0
    mode      = 22
    operation = "r"
    instance  = 0
    paddr     = None
    raddr     = None
    value     = None
    device    = None
    global MDIO_DEBUGGER

    try:
        opts, args = getopt.getopt(sys.argv[1:], "hc:d:m:o:p:r:i:v:t:",
                    ["help", "chip", "debugger", "mode", "oper", "paddr", "raddr", "instance", "value", "device"])
    except:
        print("Error in parsing arguments")
        MDIO_Usage()
    for opt, arg in opts:
        if opt in ("-h", "--help"):
            MDIO_Usage()
        elif opt in ("-c", "--chip"):
            chip        = str(arg)
        elif opt in ("-d", "--debugger"):
            debugger    = int(arg)
        elif opt in ("-m", "--mode"):
            mode        = int(arg)
        elif opt in ("-o", "--oper"):
            operation   = str(arg)
        elif opt in ("-p", "--paddr"):
            paddr       = int(arg, 16)
        elif opt in ("-r", "--raddr"):
            raddr       = int(arg, 16)
        elif opt in ("-i", "--instance"):
            instance    = int(arg)
        elif opt in ("-v", "--value"):
            value       = int(arg, 16)
        elif opt in ("-t", "--device"):
            device      = int(arg, 16)
        else:
            print("Unknown argument %s" % opt)
            MDIO_Usage()

    if (chip == None) or (raddr == None) or (paddr == None):
        MDIO_Usage()

    mcm = True if chip == "bcm8956x" else False
    MDIO_DEBUGGER = MDIO_Debugger(chip, debugger, mcm, 1)

    mdioObj = MDIO_Interface(instance)

    if mode == 22:
        if operation == "r":
            retVal = mdioObj.MDIO_ReadCL22(paddr, raddr)
            print("Read Value: " + str(hex(retVal)))
        else:
            if value == None:
                MDIO_Error("Invalid value: " + str(value))
            mdioObj.MDIO_WriteCL22(paddr, raddr, value)
    elif mode == 45:
        if device == None:
            MDIO_Error("Device type not found.")
        if operation == "r":
            retVal = mdioObj.MDIO_ReadCL45(paddr, raddr, device)
            print("Read Value: " + str(hex(retVal)))
        else:
            if value == None:
                MDIO_Error("Invalid value: " + str(value))
            mdioObj.MDIO_WriteCL45(paddr, raddr, device, value)
    else:
        MDIO_Error("Invalid mode: " + str(mode))


if __name__ == '__main__':
    MDIO_Main()

## @}
