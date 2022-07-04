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
sys.dont_write_bytecode = True
import time
import getopt
import tempfile, tarfile
from zipfile import ZipFile
from flash_access import *
from jlink_interface import *
from lauterbach_interface import *

SEGGER     = 0
LAUTERBACH = 1

FLASHER_RESET_ID = 1
FLASHER_ERASE_ID = 2
FLASHER_READ_ID  = 3
FLASHER_WRITE_ID = 4

LYNX_QSPI_REG    = 0x4000E800
HYDRA_QSPI_REG1  = 0x4000E000
HYDRA_QSPI_REG2  = 0x4000E800
LEO_QSPI_REG     = 0x0010A000
SCORPIO_QSPI_REG = 0x40144000

def FLASHER_UpdateCfg(aChip):
    del Flash_Config[:]
    del FLASH_RWDev[:]
    if aChip == "bcm8908x":
        FLASH_UpdateConfig(1, 1, LYNX_QSPI_REG, None)
        Flash_Config.extend([
            {
                "hwID" : FLASH_HW_ID_0,
                "size" : (64 * 1024 * 1024),
                "pageSize" : 256,
                "sectorSize" : (64 * 1024), # 64KB
                "subSectorSupported" : True,
                "subSectorSize" : (4 * 1024), # 4KB
                "SPIMode" : FLASH_SPI_MODE_3,
                "speed" : FLASH1_SPEED,
                "readLane" : FLASH_READ_LANE_SINGLE,
                "clkCfgID" : FLASH1_CLK_CFG_ID
            }])
        FLASH_RWDev.extend([
            {
                "state" : FLASH_STATE_UNINIT
            }])
    elif aChip == "bcm8910x":
        FLASH_UpdateConfig(2, 2, HYDRA_QSPI_REG1, HYDRA_QSPI_REG2)
        Flash_Config.extend([
            {   "hwID" : FLASH_HW_ID_0,
                "size" : (2 * 1024 * 1024), # 2MB
                "pageSize" : 256,
                "sectorSize" : (64 * 1024), # 64KB
                "subSectorSupported" : True,
                "subSectorSize" : (4 * 1024), # 4KB
                "SPIMode" : FLASH_SPI_MODE_3,
                "speed" : FLASH0_SPEED,
                "readLane" : FLASH_READ_LANE_SINGLE,
                "clkCfgID" : FLASH0_CLK_CFG_ID
            },
            {
                "hwID" : FLASH_HW_ID_1,
                "size" : (64 * 1024 * 1024),
                "pageSize" : 256,
                "sectorSize" : (64 * 1024), # 64KB
                "subSectorSupported" : True,
                "subSectorSize" : (4 * 1024), # 4KB
                "SPIMode" : FLASH_SPI_MODE_3,
                "speed" : FLASH1_SPEED,
                "readLane" : FLASH_READ_LANE_SINGLE,
                "clkCfgID" : FLASH1_CLK_CFG_ID
            }])
        FLASH_RWDev.extend([
            {
                "state" : FLASH_STATE_UNINIT
            },
            {
                "state" : FLASH_STATE_UNINIT
            }])
    elif aChip == "bcm8953x":
        FLASH_UpdateConfig(1, 1, LEO_QSPI_REG, None)
        Flash_Config.extend([
            {
                "hwID" : FLASH_HW_ID_0,
                "size" : (4 * 1024 * 1024),
                "pageSize" : 256,
                "sectorSize" : (64 * 1024), # 64KB
                "subSectorSupported" : True,
                "subSectorSize" : (4 * 1024), # 4KB
                "SPIMode" : FLASH_SPI_MODE_3,
                "speed" : FLASH0_SPEED,
                "readLane" : FLASH_READ_LANE_SINGLE,
                "clkCfgID" : FLASH0_CLK_CFG_ID
            }])
        FLASH_RWDev.extend([
            {
                "state" : FLASH_STATE_UNINIT
            }])
    elif aChip == "bcm8955x":
        FLASH_UpdateConfig(1, 1, LEO_QSPI_REG, None)
        Flash_Config.extend([
            {
                "hwID" : FLASH_HW_ID_0,
                "size" : (4 * 1024 * 1024),
                "pageSize" : 256,
                "sectorSize" : (64 * 1024), # 64KB
                "subSectorSupported" : True,
                "subSectorSize" : (4 * 1024), # 4KB
                "SPIMode" : FLASH_SPI_MODE_3,
                "speed" : FLASH0_SPEED,
                "readLane" : FLASH_READ_LANE_SINGLE,
                "clkCfgID" : FLASH0_CLK_CFG_ID
            }])
        FLASH_RWDev.extend([
            {
                "state" : FLASH_STATE_UNINIT
            }])
    elif aChip == "bcm8956x" or aChip == "bcm8957x":
        FLASH_UpdateConfig(1, 1, SCORPIO_QSPI_REG, None)
        Flash_Config.extend([
            {
                "hwID" : FLASH_HW_ID_0,
                "size" : (4 * 1024 * 1024),
                "pageSize" : 256,
                "sectorSize" : (64 * 1024), # 64KB
                "subSectorSupported" : True,
                "subSectorSize" : (4 * 1024), # 4KB
                "SPIMode" : FLASH_SPI_MODE_3,
                "speed" : FLASH0_SPEED,
                "readLane" : FLASH_READ_LANE_SINGLE,
                "clkCfgID" : FLASH0_CLK_CFG_ID
            }])
        FLASH_RWDev.extend([
            {
                "state" : FLASH_STATE_UNINIT
            }])

def FLASHER_Debugger(aChip, aMode, aIfc, aSN):
    debugger = None
    mcm = False
    if aMode > 0:
        mcm = True
    FLASHER_UpdateCfg(aChip)
    if aIfc == SEGGER:
        debugger = JLINK_Interface(aChip, aSN, aMCM=mcm, aSC=1)
    elif aIfc == LAUTERBACH:
        debugger = LAUTERBACH_Interface(aChip, aMCM=mcm, aSC=1)
    else:
        print("[ERROR] Invalid Interface: " + str(aIfc))
        sys.exit(1)
    return debugger

def FLASHER_LE2BE(aList):
    retList = []
    for i in range((len(aList)+3)//4):
        retList.extend(aList[i*4:(i+1)*4][::-1])
    return retList

def FLASHER_ExtractBin(aFile, aSecure, aSectorSize):
    sectors = None
    binFile = None
    if os.path.isfile(aFile) == True:
        if str(aFile).endswith(".bin"):
            binFile = aFile
            sectors = int((os.stat(binFile).st_size + aSectorSize - 1) / aSectorSize)
            with open(binFile, 'rb') as f:
                data = f.read()
                print('Binary File: ' + str(binFile))
        else:
            folder = tempfile.mkdtemp()
            if (str(aFile).endswith(".tar.gz")):
                tar = tarfile.open(aFile)
                tar.format = tarfile.GNU_FORMAT
                tar.extractall(folder)
                tar.close()
            elif (str(aFile).endswith(".zip")):
                with ZipFile(str(aFile), 'r') as zip:
                    zip.extractall(folder)
            else:
                print('Unknown file format')
            for each in os.listdir(folder):
                suffix = "_flash_signed.bin" if aSecure else "_flash.bin"
                if each.endswith(suffix) and (not each.endswith(("_bl" + suffix, "_decrypt" + suffix, "_encrypt" + suffix))):
                    binFile = os.path.join(folder, each)
                    sectors = int((os.stat(binFile).st_size + aSectorSize - 1) / aSectorSize)
                    print('Binary File: ' + str(binFile)); break
            with open(binFile, 'rb') as f:
                data = f.read()
            shutil.rmtree(folder)
    else:
        print("File not found: " + str(aFile))
    if binFile is not None:
        data = list(bytearray(data))
    else:
        print("[Error] Flash binary file not found."); sys.exit(1)
    return data, sectors

def FLASHER_ReadPTBL(aChip, aMode, aIfc, aSN, aId):
    isPTBLEmpty = False
    debugger = FLASHER_Debugger(aChip, aMode, aIfc, aSN)
    flash = FLASH_Access(debugger)
    for cfg in Flash_Config:
        flash.FLASH_Init(cfg["hwID"], cfg)

    pageSize = Flash_Config[aId]["pageSize"]

    rxData = []
    retVal = flash.FLASH_Read(Flash_Config[aId]["hwID"], 0, rxData, pageSize)
    if (retVal == BCM_ERR_OK):
        byteList = FLASHER_LE2BE([int(n.rstrip("L"), 16) for n in rxData])
        byteList = list(set(byteList))
        if len(byteList) == 1 and byteList[0] == 255:
            isPTBLEmpty = True
    else:
        print("FLASH_Read failed. Error: " + str(retVal))
    debugger.close()

    return isPTBLEmpty

def FLASHER_GetTargetSN(aChip, aMode, aIfc, aTrigger):
    debugger = FLASHER_Debugger(aChip, aMode, aIfc, None)
    serialNoList = debugger.getDeviceSerialNoList()
    debugger.close()
    aTrigger.emit(serialNoList)

def FLASHER_ResetTarget(aChip, aMode, aIfc, aSN, aTrigger):
    debugger = FLASHER_Debugger(aChip, aMode, aIfc, aSN)
    ret = debugger.reset()
    debugger.close()
    if aTrigger != None:
        aTrigger.emit(ret, FLASHER_RESET_ID)

def FLASHER_EraseTarget(aChip, aMode, aIfc, aSN, aId, aTrigger, aSectors=None):
    debugger = FLASHER_Debugger(aChip, aMode, aIfc, aSN)
    flash = FLASH_Access(debugger)
    for cfg in Flash_Config:
        flash.FLASH_Init(cfg["hwID"], cfg)
    print('FLASH_Init completed')

    print('Erasing Flash ...')
    sectorSize = Flash_Config[aId]["sectorSize"]
    fullSector = int(Flash_Config[aId]["size"] / sectorSize)
    sectors    = aSectors if (aSectors != None) and (aSectors < fullSector) else fullSector

    lastPercent = -1
    for i in range(sectors):
        addr = i * sectorSize
        retVal = flash.FLASH_Erase(aId, addr, sectorSize)
        if (retVal != BCM_ERR_OK):
            break
        progress = int((i*100)/len(range(sectors)))
        if progress != lastPercent:
            lastPercent = progress
            if aTrigger is None:
                print("Erase progress: " + str(lastPercent))
            else:
                aTrigger.emit(lastPercent, FLASHER_ERASE_ID)
    debugger.close()
    if aTrigger != None:
        if retVal == 0:
            aTrigger.emit(100, FLASHER_ERASE_ID)
        else:
            aTrigger.emit(-1, FLASHER_ERASE_ID)
    if retVal == 0:
        print("Erase completed")

    return retVal


def FLASHER_ReadTarget(aChip, aMode, aIfc, aSN, aId, aTrigger, aFile, aStart, aEnd):
    debugger = FLASHER_Debugger(aChip, aMode, aIfc, aSN)
    flash = FLASH_Access(debugger)
    for cfg in Flash_Config:
        flash.FLASH_Init(cfg["hwID"], cfg)
    print('FLASH_Init completed')

    pageSize = Flash_Config[aId]["pageSize"]

    pageStart = int(aStart / pageSize)
    pageEnd   = int((aEnd + pageSize - 1) / pageSize)

    byteData = bytearray()
    totalPages = pageEnd - pageStart
    lastValue = 0
    retVal = None
    print('Reading...')
    pageIndex = 0
    for i in range(pageStart, pageEnd):
        rxData = []
        retVal = flash.FLASH_Read(Flash_Config[aId]["hwID"], i*pageSize, rxData, pageSize)
        if (retVal == BCM_ERR_OK):
            byteList = FLASHER_LE2BE([int(n.rstrip("L"), 16) for n in rxData])
            byteData.extend(byteList)
            currValue = int((pageIndex*100)/totalPages)
            if currValue > lastValue:
                aTrigger.emit(currValue, FLASHER_READ_ID)
                lastValue = currValue
        else:
            print("FLASH_Read for page - " + str(pageIndex) + " failed. Error: " + str(retVal))
        pageIndex += 1
    debugger.reset()
    debugger.close()
    if retVal is None:
        print("[Error] Invalid range given for reading data")
    elif retVal == 0:
        if lastValue < 100:
            aTrigger.emit(100, FLASHER_READ_ID)
        with open(aFile, "wb") as fp:
            fp.write(byteData)
    else:
        aTrigger.emit(-1, FLASHER_READ_ID)
        print("[Error] Read Error occured: " + retVal)
    return retVal


def FLASHER_WriteTarget(aChip, aMode, aIfc, aSN, aId, aTrigger, aFile, aSecure=False):
    FLASHER_UpdateCfg(aChip)
    sectorSize    = Flash_Config[aId]["sectorSize"]
    data, sectors = FLASHER_ExtractBin(aFile, aSecure, sectorSize)

    # Erase
    retVal   = FLASHER_EraseTarget(aChip, aMode, aIfc, aSN, aId, aTrigger, sectors)

    # Flash
    if retVal == BCM_ERR_OK:
        debugger = FLASHER_Debugger(aChip, aMode, aIfc, aSN)
        flash    = FLASH_Access(debugger)
        for cfg in Flash_Config:
            flash.FLASH_Init(cfg["hwID"], cfg)
        print('FLASH_Init completed')

        retVal = flash.FLASH_Write(aId, 0, data, len(data), aTrigger)
        if retVal != 0:
            if aTrigger != None:
                aTrigger.emit(-1, FLASHER_WRITE_ID)
            print("Flash failed: {}".format(retVal))

        debugger.reset()
        debugger.close()

    return retVal


def FLASHER_Usage():
    print("""
    USAGE: flasher_api.py
        [-h, --help]        Display this help message
         -c, --chip         Chip family
         -i, --hwid         hwId [0 = Internal flash | 1 = External flash]
         -m, --mcm          Add "-m" only for MCM board
         -d, --debugger     0 = Segger | 1 = Lauterbach
         -s, --sn           Serial number                       (optional)
         -e, --erase        erase target        (ERASE)
         -r, --reset        reset target        (RESET)
         -f, --file         binary or zip file  (FLASH)

    For Non-MCM board:
        RESET                 : flasher_api.py -c <chip> -d <debugger> -i <flash id> -s <serial number> --reset
        ERASE (FULL)          : flasher_api.py -c <chip> -d <debugger> -i <flash id> -s <serial number> --erase
        ERASE (FEW SECTORS)   : flasher_api.py -c <chip> -d <debugger> -i <flash id> -s <serial number> --erase --sectors <number>
        FLASH BIN             : flasher_api.py -c <chip> -d <debugger> -i <flash id> -s <serial number> -f <bin file>
        FLASH ZIP (NON-SECURE): flasher_api.py -c <chip> -d <debugger> -i <flash id> -s <serial number> -f <zip file>
        FLASH ZIP (SECURE)    : flasher_api.py -c <chip> -d <debugger> -i <flash id> -s <serial number> -f <zip file> --secure

    For MCM board:
        RESET                 : flasher_api.py -c <chip> -d <debugger> -i <flash id> -s <serial number> --mcm --reset
        ERASE (FULL)          : flasher_api.py -c <chip> -d <debugger> -i <flash id> -s <serial number> --mcm --erase
        ERASE (FEW SECTORS)   : flasher_api.py -c <chip> -d <debugger> -i <flash id> -s <serial number> --mcm --erase --sectors <number>
        FLASH BIN             : flasher_api.py -c <chip> -d <debugger> -i <flash id> -s <serial number> --mcm -f <bin file>
        FLASH ZIP (NON-SECURE): flasher_api.py -c <chip> -d <debugger> -i <flash id> -s <serial number> --mcm -f <zip file>
        FLASH ZIP (SECURE)    : flasher_api.py -c <chip> -d <debugger> -i <flash id> -s <serial number> --mcm -f <zip file> --secure

    [NOTE: 1 Sector = 64KB and 32 Sector = 2MB]
         """)
    sys.exit(2)

def FLASHER_Main():
    chip        = None
    mcm         = 0
    debugger    = 0
    sn          = None
    flashId     = 0
    trigger     = None
    inputFile   = None
    operation   = None
    secure      = False
    sectors     = None
    try:
        opts, args = getopt.getopt(sys.argv[1:], "hmeri:c:d:s:f:",
                                    ["help", "mcm", "secure", "reset", "erase", "hwid=", "chip=", "debugger=", "sn=", "file=", "sectors="])
    except:
        print("Error in parsing arguments")
        FLASHER_Usage()
    for opt, arg in opts:
        if opt in ("-h", "--help"):
            FLASHER_Usage()
        elif opt in ("-c", "--chip"):
            chip     = arg
        elif opt in ("-m", "--mcm"):
            mcm      = 1
        elif opt in ("-i", "--hwid"):
            flashId  = int(arg)
        elif opt in ("-d", "--debugger"):
            debugger = int(arg)
        elif opt in ("-s", "--sn"):
            sn       = int(arg)
        elif opt in ("-f", "--file"):
            inputFile  = os.path.abspath(arg)
            operation = "flash"
        elif opt in ("-r", "--reset"):
            operation =  "reset" if operation == None else operation
        elif opt in ("-e", "--erase"):
            operation =  "erase" if operation == None else operation
        elif opt in ("--secure"):
            secure    = True
        elif opt in ("--sectors"):
            sectors   = int(arg)
        else:
            print("Unknown argument %s" % opt)
            FLASHER_Usage()
    if chip == None or operation == None:
        FLASHER_Usage()

    if operation == "flash":
        if os.path.isfile(inputFile):
            FLASHER_WriteTarget(chip, mcm, debugger, sn, flashId, trigger, inputFile, secure)
        else:
            print("File not found: " + str(inputFile)); sys.exit(1)
    elif operation == "erase":
        FLASHER_EraseTarget(chip, mcm, debugger, sn, flashId, trigger, sectors)
    elif operation == "reset":
        FLASHER_ResetTarget(chip, mcm, debugger, sn, trigger)
    else:
        FLASHER_Usage()




if __name__ == '__main__':
    FLASHER_Main()