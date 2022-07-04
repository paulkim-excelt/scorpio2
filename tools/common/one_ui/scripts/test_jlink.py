#!/usr/bin/python2

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

##  @defgroup grp_tools_jlink_test Test file for JLink Flasher
#   @ingroup grp_one_ui
#
#   @addtogroup grp_tools_jlink_test
#   @{
#
#   This script contains test code for jlink flashing.
#
#   @file test_jlink.py
#   @brief Python script to test JLink Flasher
#   @version 1.0 Changelist1

import sys
from jlink_interface import *


##  @name JLink Architecture IDs
#   @{
#   @brief Architecture IDs for JLink Flasher Test
#
    ## @brief #test_jlink.JLINK_ARM_REG_R15()
BRCM_SWARCH_JLINK_ARM_REG_R15_GLOBAL        = 0
    ## @brief #test_jlink.JLINK_Test()
BRCM_SWARCH_JLINK_TEST_PROC                 = 1
##  @}

##  @brief ARM Register
#
#   This marco contains value of arm register 15
#
#   @trace #BRCM_SWREQ_JLINK_TEST
JLINK_ARM_REG_R15 = 15

def JLINK_TestUsage():
    print("python test_jlink.py -i <file name> -a <addr> -c <chip name> -s <serial Number>")
    sys.exit(2)

##  @brief Test function for JLink Flasher
#
#   Detailed description of function
#
#   @behavior Sync/Async, Re-entrant/Non-reentrant
#
#   @pre describe any pre-condition
#
#   @param[in]      void
#
#   @return void
#
#   @post describe post condition
#
#   @trace #BRCM_SWREQ_JLINK_TEST
def JLINK_Test():
    isMCM     = False
    sc        = None
    inputFile = None
    outputFile = "out.bin"
    isDwnldEnable = False
    addr = 0x20000000
    SerialNo = None
    chip = None
    try:
        opts, args = getopt.getopt(sys.argv[1:], "hmdi:a:o:c:s:",
            ["help", "mcm", "dwnl", "input=", "addr=", "out=", "chip=", "sn="])
    except:
        print("Error in parsing arguments")
        JLINK_TestUsage()
    for opt, arg in opts:
        if opt in ("-h", "--help"):
            JLINK_TestUsage()
        if opt in ("-m", "--mcm"):
            isMCM   = True
            sc      = 1
        elif opt in ("-d", "--dwnl"):
            isDwnldEnable = True
        elif opt in ("-i", "--input"):
            inputFile = os.path.abspath(arg)
        elif opt in ("-o", "--out"):
            outputFile = arg
        elif opt in ("-a", "--addr"):
            addr = int(arg, 16)
        elif opt in ("-c", "--chip"):
            chip = arg
        elif opt in ("-s", "--sn"):
            SerialNo = arg
        else:
            print("Unknown argument %s" % opt)
            JLINK_TestUsage()

    jlink = JLINK_Interface(chip, SerialNo, isMCM, sc)

    print("\n=========================")
    print("##        Setup        ##")
    print("=========================")
    serialNumber = jlink.getDeviceSerialNo()
    print ("serialNumber found: " + str(serialNumber))
    jlink.isConnected()
    jlink.isOpen()

    print("\n====================================")
    print("## TEST 1: Read and Write CPU Reg ##")
    print("====================================")
    global JLINK_ARM_REG_R15

    data = jlink.readCPUReg(JLINK_ARM_REG_R15)               # Read data from CPU Register
    print("Reading JLINK_ARM_REG_R15 Reg Value:     " + str(data))


    print("\n========================================")
    print("## TEST 2: Read and Write python List ##")
    print("========================================")
    baseAddr = 0x20001500
    wrData = [0x00000000 + (i*0x10 + i + i**2) for i in range(10)]  # random data
    offset = jlink.writeArray(baseAddr, wrData, JLINK_REG_U8_TYPE)  # Write data to target
    rdData = jlink.readArray(baseAddr, offset, JLINK_REG_U8_TYPE)   # Read data from target
    print("Writing data using writeArray: " + str(wrData))          # Print Write data
    print("Read Data using readArray:     " + str(rdData))          # Print Read data

    print("\n=======================================================")
    print("## TEST 3: Read and Write using readMem and writeMem ##")
    print("=======================================================")
    baseAddr = 0x20001000
    wrData = [1,12,78,45,15,26,37,108,190,250]
    jlink.writeMem(baseAddr, len(wrData), wrData)
    rdData = jlink.readMem(baseAddr, len(wrData))
    print("Writing data using writeMem: " + str(wrData))
    print("Reading data using readMem:  " + str(rdData))

    print("\n========================================================")
    print("## TEST 4: Write using writeMem and read using readReg ##")
    print("========================================================")
    baseAddr = 0x20005000
    wrData = [26,24,22,20,18,16,14,12,10,5]
    jlink.writeMem(baseAddr, len(wrData), wrData)
    rdData = jlink.readArray(baseAddr, len(wrData), JLINK_REG_U8_TYPE)
    print("Writing data using writeMem: " + str(wrData))
    print("Read Data using readArray:    " + str(rdData))

    print("\n=========================================================")
    print("## TEST 5: Write using writeReg and read using readMem ##")
    print("=========================================================")
    baseAddr = 0x20008000
    wrData = [14,30,48,58,70,94,120,148,178]
    jlink.writeArray(baseAddr, wrData, JLINK_REG_U8_TYPE)
    rdData = jlink.readMem(baseAddr, len(wrData))
    print("Writing data using writeArray: " + str(wrData))
    print("Reading data using readMem:   " + str(rdData))

    if inputFile is not None:
        print("\n=====================================")
        print("## TEST 6: Write and Read bin file ##")
        print("=====================================")
        if isDwnldEnable:
            jlink.downloadFile(inputFile, addr)
            jlink.readFile(addr, len(open(inputFile).readlines() * 41) - 2, outputFile)
        else:
            count = jlink.writeFile(inputFile, addr)
            readOffset = jlink.readFile(addr, count, outputFile)
        print (outputFile + " file is created successfully in out directory.")

if __name__ == '__main__':
    JLINK_Test()
## @}