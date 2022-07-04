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
import tempfile, tarfile
import struct
from datetime import datetime
from zipfile import ZipFile
from collections import OrderedDict

from lxml import etree
from lxml import objectify

sys.path.insert(1, os.path.join(os.path.dirname(os.path.realpath(__file__)), 'rdb'))
from common_header import *


# GLOBAL MACROS
#--------------

TEST_PROGRAM_COUNTER_CORTEX_R4   = 9
TEST_PROGRAM_COUNTER_CORTEX_M7   = 15

TEST_DEBUGGER_SEGGER             = 0
TEST_DEBUGGER_LAUTERBACH         = 1

TEST_COVERAGE_DATA_RAW           = 0
TEST_COVERAGE_DATA_STRING        = 1

BCM_TEST_SYS_CFG_IMG_PID         = 0x5
BCM_IMG_HDR_SIZE                 = 512
BCM_IMG_DWLD_HDR_SIZE            = 20

BCM_UINT8                        = 1
BCM_UINT16                       = 2
BCM_UINT32                       = 4

BCM_TEST_MAGIC                   = 0x42545354       # 'B' 'T' 'S' 'T'
BCM_TEST_MSG_MAGIC_CMD           = 0x544D5347       # 'T' 'M' 'S' 'G'

BCM_CMD_RESPONSE_SHIFT           = 30
BCM_CMD_RESPONSE_MASK            = 1 << BCM_CMD_RESPONSE_SHIFT
BCM_CMD_GROUP_SHIFT              = 24
BCM_CMD_GROUP_MASK               = 0x3F << BCM_CMD_GROUP_SHIFT
BCM_GROUPID_TEST                 = 0x3F

# BCM_MsgType
BCM_MSG_RESPONSE_MASK            = BCM_CMD_RESPONSE_MASK
BCM_MSG_GROUP_ID_MASK            = BCM_GROUPID_TEST << BCM_CMD_GROUP_SHIFT
BCM_MSG_START_TEST               = 0x1

# Arch type
M7                               = 0
EM22FS                           = 1

TEST_ERROR_MSG = {-1: "BCM_AT_NOT_AVAILABLE",
                  -2: "BCM_AT_NOT_STARTED",
                  -3: "BCM_AT_EXECUTING"}

# OFFSETS
#--------

# BCM_TestMsgType
BCM_MSG_POINTER             = 0
BCM_TEST_MSG_MAGIC_OFFSET   = BCM_MSG_POINTER;      BCM_MSG_POINTER += BCM_UINT32
BCM_TEST_MSG_RESV_OFFSET    = BCM_MSG_POINTER;      BCM_MSG_POINTER += BCM_UINT32
BCM_TEST_MSG_MSGID_OFFSET   = BCM_MSG_POINTER;      BCM_MSG_POINTER += BCM_UINT32
BCM_TEST_MSG_LEN_OFFSET     = BCM_MSG_POINTER;      BCM_MSG_POINTER += BCM_UINT32
BCM_TEST_MSG_DATA_OFFSET    = BCM_MSG_POINTER;

# BCM_TestRespDataType
BCM_RES_POINTER                 = BCM_TEST_MSG_DATA_OFFSET
BCM_TEST_REQ_RESULT_OFFSET      = BCM_RES_POINTER;      BCM_RES_POINTER += BCM_UINT32
BCM_TEST_REQ_SEQ_OFFSET         = BCM_RES_POINTER;      BCM_RES_POINTER += BCM_UINT32
BCM_TEST_REQ_FAILED_CNT_OFFSET  = BCM_RES_POINTER;      BCM_RES_POINTER += BCM_UINT32
BCM_TEST_REQ_PASSED_CNT_OFFSET  = BCM_RES_POINTER;      BCM_RES_POINTER += BCM_UINT32
BCM_TEST_REQ_COMPID_OFFSET      = BCM_RES_POINTER;      BCM_RES_POINTER += BCM_UINT32

# BCM_TestImglReqDataType (msgData)
BCM_REQ_POINTER                     = BCM_TEST_MSG_DATA_OFFSET
BCM_TEST_MSG_IMGL_FLAGS_OFFSET      = BCM_REQ_POINTER;      BCM_REQ_POINTER += BCM_UINT8
BCM_TEST_MSG_IMGL_PID_OFFSET        = BCM_REQ_POINTER;      BCM_REQ_POINTER += BCM_UINT8
BCM_TEST_MSG_IMGL_IMGID_OFFSET      = BCM_REQ_POINTER;      BCM_REQ_POINTER += BCM_UINT16
BCM_TEST_MSG_IMGL_RAWOFF_OFFSET     = BCM_REQ_POINTER;      BCM_REQ_POINTER += BCM_UINT32
BCM_TEST_MSG_IMGL_LOADADDR_OFFSET   = BCM_REQ_POINTER;      BCM_REQ_POINTER += BCM_UINT32
BCM_TEST_MSG_IMGL_MAXSZ_OFFSET      = BCM_REQ_POINTER;      BCM_REQ_POINTER += BCM_UINT32

# BCM_TestImglResDataType (msgData)
BCM_RES_POINTER                     = BCM_TEST_MSG_DATA_OFFSET
BCM_TEST_MSG_IMGL_RESULT_OFFSET     = BCM_RES_POINTER;      BCM_RES_POINTER += BCM_UINT32
BCM_TEST_MSG_IMGL_IMGSZ_OFFSET      = BCM_RES_POINTER;      BCM_RES_POINTER += BCM_UINT32
BCM_TEST_MSG_IMGL_SZ_OFFSET         = BCM_RES_POINTER;      BCM_RES_POINTER += BCM_UINT32

# BCM_TestResultDataType (msgData)
BCM_RES_POINTER                     = BCM_TEST_MSG_DATA_OFFSET
BCM_TEST_RES_CASEID_OFFSET          = BCM_RES_POINTER;      BCM_RES_POINTER += BCM_UINT32
BCM_TEST_RES_RESULT_OFFSET          = BCM_RES_POINTER;      BCM_RES_POINTER += BCM_UINT32

# BCM_TestInfoType
BCM_POINTER                         = 0
BCM_TEST_MAGIC_OFFSET               = BCM_POINTER;      BCM_POINTER += BCM_UINT32
BCM_TEST_VERSION_MAJOR_OFFSET       = BCM_POINTER;      BCM_POINTER += BCM_UINT8
BCM_TEST_VERSION_MINOR_OFFSET       = BCM_POINTER;      BCM_POINTER += BCM_UINT8
BCM_TEST_MSGSIZE_OFFSET             = BCM_POINTER;      BCM_POINTER += BCM_UINT8
BCM_TEST_FIFOSIZE_OFFSET            = BCM_POINTER;      BCM_POINTER += BCM_UINT8
BCM_TEST_ROLLOVER_OFFSET            = BCM_POINTER;      BCM_POINTER += (BCM_UINT16 + BCM_UINT16)

BCM_TEST_TGET_RD_IDX_OFFSET         = BCM_POINTER;      BCM_POINTER += BCM_UINT32
BCM_TEST_TGET_WR_IDX_OFFSET         = BCM_POINTER;      BCM_POINTER += BCM_UINT32
BCM_TEST_HOST_RD_IDX_OFFSET         = BCM_POINTER;      BCM_POINTER += BCM_UINT32
BCM_TEST_HOST_WR_IDX_OFFSET         = BCM_POINTER;      BCM_POINTER += BCM_UINT32
BCM_TEST_H2TQ_DROP_CNT              = BCM_POINTER;      BCM_POINTER += BCM_UINT32
BCM_TEST_T2HQ_DROP_CNT              = BCM_POINTER;      BCM_POINTER += BCM_UINT32
BCM_TEST_H2T_BUFF_OFFSET            = BCM_POINTER;      BCM_POINTER += BCM_UINT32
BCM_TEST_T2H_BUFF_OFFSET            = BCM_POINTER;      BCM_POINTER += BCM_UINT32

TEST_Schema = '''<?xml version="1.0"?>
<xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema">

<xs:complexType name="loadImgType">
    <xs:sequence>
        <xs:element name="file" type="xs:string"/>
        <xs:element name="address" type="xs:string"/>
    </xs:sequence>
</xs:complexType>

<xs:element name="test_cfg">
    <xs:complexType>
        <xs:sequence>
            <xs:element name="ep" type="xs:string" minOccurs="0" maxOccurs="1"/>
            <xs:element name="load" type="loadImgType" minOccurs="1" maxOccurs="unbounded"/>
        </xs:sequence>
    </xs:complexType>
</xs:element>

</xs:schema>'''

class TEST_Global:
    verbose = 0
    def _log(self, *aMsg):
        if self.verbose:
            print(" ".join(aMsg))
    def _error(self, aMsg):
        print("[Error] " + str(aMsg))
        TEST_MemInfo.debugger.close()
        sys.exit(1)
    def _int(self, aValue):
        value = str(aValue)
        if value.startswith("0x"):
            return int(value, 16)
        else:
            return int(value)

class TEST_MapParser:
    # regex patterns
    nameList = [
        ('bufferAddress',       r'\s*(?P<addr>[0-9a-fA-F]+)\s+vcast_output_buffer\s*$'),
        ('bufferSizeAddress',   r'\s*(?P<addr>[0-9a-fA-F]+)\s+vcast_output_buffer_end\s*$'),
        ('exitFlagAddress',     r'\s*(?P<addr>[0-9a-fA-F]+)\s*vcast_exit_flag\s*$'),
        ('textAddress',         r'\s*(?P<addr>[0-9a-fA-F]+)\s+__text_start__\b'),
        ('dataAddress',         r'\s*(?P<addr>[0-9a-fA-F]+)\s+__data_start__\b'),
        ('privAddress',         r'\s*(?P<addr>[0-9a-fA-F]+)\s+privileged_region_start\b'),
        ('ethroAddress',        r'\s*(?P<addr>[0-9a-fA-F]+)\s+__eth_ro_start__\b'),
        ('jumpAddress',         r'\s*(?P<addr>[0-9a-fA-F]+)\s+CORTEX_MX_RESET_HANDLER\s*$'),
        ('jumpAddress',         r'\s*(?P<addr>[0-9a-fA-F]+)\s+EE_cortex_mx_default_reset_ISR\s*$'),
        ('breakAddress',        r'\s*(?P<addr>[0-9a-fA-F]+)\s+VCAST_DUMP_COVERAGE_DATA\s*$'),
        ('chipFamily',          r'.*\s+(?P<addr>[0-9a-fA-F]+)\s+bcm([0-9a-fA-F]+)x_system\.o\s*$'),
        ('mcdcByteArray',       r'\s*(?P<addr>[0-9a-fA-F]+)\s+McdcBytes\b'),
        ('mcdcByteSize',        r'(^McdcBytes) .* (?P<addr>[0-9a-fA-F]+)'),
        ('BCM_TestCmdQ',        r'\s*(?P<addr>[0-9a-fA-F]+)\s+BCM_TestCmdQ\b'),
        ('BCM_TestStreamQ',     r'\s*(?P<addr>[0-9a-fA-F]+)\s+BCM_TestStreamQ\b'),
        ('BCM_TestResultQ',     r'\s*(?P<addr>[0-9a-fA-F]+)\s+BCM_TestResultQ\b'),
        ('vcastUnitList',       r'\s*(?P<addr>[0-9a-fA-F]+)\s+vcast_unit_list_values\b'),
        ('em22fsTextStart',     r'.text\s+xdata\s+(?P<addr>[0-9a-fA-F]+)\s+\b'),
        ('em22fsTextEnd',       r'.text\s+xdata\s+[0-9a-fA-F]+\s+(?P<addr>[0-9a-fA-F]+)\s+\b'),
    ]

    @staticmethod
    def extractInfo(line, regex):
        match = re.search(regex, line)
        if match:
            return True, match.group("addr")
        return False, '0'

    def __init__(self, aMapFile):
        self.bufferAddress = 0
        self.bufferSizeAddress = 0
        self.exitFlagAddress = 0
        self.textAddress = 0
        self.dataAddress = 0
        self.privAddress = 0
        self.ethroAddress = 0
        self.jumpAddress = 0
        self.breakAddress = 0
        self.blJump = 0
        self.vcastUnitList = 0
        self.chipFamily = 8956
        self.vcastMcdcPtr = 0
        self.em22fsTextStart = 0
        self.em22fsTextStart = 0

        lastLine = ''
        with open(aMapFile, 'r') as inputFile:
            for line in inputFile:
                for name in self.nameList:
                    found, value = self.extractInfo(line, name[1])
                    if found:
                        exec('self.{} = {}'.format(name[0], '0x' + value))
                lastLine = line

class TEST_Cfg(TEST_Global):
    def __init__(self, aPid, aId, aMaxSz, aName, aVersion):
        self.imgPid   = self._int(aPid)
        self.imgId    = self._int(aId)
        self.imgMaxSz = self._int(aMaxSz)
        self.imgName  = aName
        self.imgItbl  = aVersion
        self.imgFull  = None
        self.offset   = None
        self.loadAddr = None
        self.reqSize  = None
    def update(self, aReqFlag, aOffset, aLoadAddr, aSize):
        self.imgFull  = True if self._int(aReqFlag) == 0 else False
        self.offset   = self._int(aOffset)
        self.loadAddr = self._int(aLoadAddr)
        self.reqSize  = self._int(aSize)

class TEST_CfgParser(TEST_Global):
    def __init__(self, aCfgFile, aBinFiles):
        self.cfgFile  = aCfgFile
        self.binFiles = aBinFiles
        self.imgDict  = self._extract()
    def _getFile(self, aFile):
        for each in self.binFiles:
            if each.endswith(aFile):
                return each
        self._error("Image not found: {} in list: {}".format(aFile, self.binFiles))
    def _extract(self):
        imgDict = {}
        version = None
        eImg    = re.compile("(?P<imgId>0x[A-Fa-f0-9]+) +(?P<maxsz>0x[A-Fa-f0-9]+) +(?P<file>.*)")
        with open(self._getFile("{:02d}.bin".format(BCM_TEST_SYS_CFG_IMG_PID)), "rb") as f:
            f.seek(BCM_UINT32)
            version = f.read(BCM_UINT32)
            version = [int(b, 2) for b in [format(x, 'b') for x in version]][0]
        with open(self.cfgFile, 'r') as fp:
            data = fp.read()
            for img in eImg.finditer(data):
                imgId = self._int(img.group("imgId"))
                file  = "{:02d}_{:04X}.bin".format(BCM_TEST_SYS_CFG_IMG_PID, imgId)
                file  = self._getFile(file)
                imgDict[imgId] = TEST_Cfg(BCM_TEST_SYS_CFG_IMG_PID, imgId, img.group("maxsz"), file, version)
        return imgDict
    def getImg(self, aPid, aImgId):
        if self._int(aPid) == BCM_TEST_SYS_CFG_IMG_PID:
            if self._int(aImgId) in self.imgDict.keys():
                return self.imgDict[self._int(aImgId)]
        self._error("Image not found: 0x{:08X}".format(aImgId))

class XML_Generator:
    TAB             = "    "
    START_REPORT    = "<LOAD_N_EXECUTE_REPORT>\n"
    END_REPORT      = "</LOAD_N_EXECUTE_REPORT>"
    START_QT        = TAB*1 + "<QTST>\n"
    END_QT          = TAB*1 + "</QTST>\n"
    START_IT        = TAB*1 + "<ITST>\n"
    END_IT          = TAB*1 + "</ITST>\n"
    START_FILE      = TAB*2 + "<FILE index=\"{}\">\n"
    END_FILE        = TAB*2 + "</FILE>\n"
    TEST_SEQ        = TAB*3 + "<SEQ id=\"{}\">\n" + TAB*4 + "<exec_time>{}</exec_time>\n" + \
                      TAB*4 + "<value>{}</value>\n" + TAB*3 + "</SEQ>\n"
    COPYRIGHT = """<?xml version="1.0" ?>
<!--
 Copyright {} Broadcom Limited.  All rights reserved.

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
-->
"""
    def __init__(self, aOutFile):
        self.outFile  = aOutFile
        self.xmlDict  = OrderedDict()
    def updateXML(self, aSeq, aResponse, aTime):
        seq = "0x{:04X}".format(aSeq)
        test = seq[2]
        file = seq[3]
        if test not in self.xmlDict.keys():
            self.xmlDict[test] = OrderedDict()
        testFileDict = self.xmlDict[test]
        if file not in testFileDict.keys():
            self.xmlDict[test][file] = [(seq, aTime, aResponse)]
        else:
            self.xmlDict[test][file].append((seq, aTime, aResponse))
    def createXML(self):
        if self.outFile == None:
            self.outFile = datetime.now().strftime("report__%d_%m_%Y__%H_%M_%S.xml")
        with open(self.outFile, "w") as log:
            log.write(self.COPYRIGHT.format(datetime.now().strftime("%Y")))
            log.write(self.START_REPORT)
            for test, testFileDict in self.xmlDict.items():
                if test == "0":
                    log.write(self.START_QT)
                    for fileIndex, seqList in testFileDict.items():
                        log.write(self.START_FILE.format(fileIndex))
                        for seqTuple in seqList:
                            log.write(self.TEST_SEQ.format(seqTuple[0], seqTuple[1], seqTuple[2]))
                        log.write(self.END_FILE)
                    log.write(self.END_QT)
                else:
                    log.write(self.START_IT)
                    for fileIndex, seqList in testFileDict.items():
                        log.write(self.START_FILE.format(fileIndex))
                        for seqTuple in seqList:
                            log.write(self.TEST_SEQ.format(seqTuple[0], seqTuple[1], seqTuple[2]))
                        log.write(self.END_FILE)
                    log.write(self.END_IT)
            log.write(self.END_REPORT)
            print("\nxml report created: " + self.outFile + "\n")

class TEST_Debugger:
    def __init__(self, aChip, aIfc, aSerialNo, aMCM):
        sc           = 1
        self._ifc    = aIfc
        self._pcAddr = TEST_PROGRAM_COUNTER_CORTEX_R4 if aChip in ['bcm8953x', 'bcm8955x'] else TEST_PROGRAM_COUNTER_CORTEX_M7
        if self._ifc == TEST_DEBUGGER_SEGGER:
            if aMCM == True:
                self._debugger = jlink_interface.JLINK_Interface(aChip, aSerialNo, aMCM, sc)
            else:
                self._debugger = jlink_interface.JLINK_Interface(aChip, aSerialNo)
        elif self._ifc == TEST_DEBUGGER_LAUTERBACH:
            self._debugger = lauterbach_interface.LAUTERBACH_Interface(aChip, aMCM, sc)
        else:
            print("[ERROR] Invalid Interface: " + str(self._ifc))
            sys.exit(1)
    def runCmm(self, aCmmFile):
        self._debugger.runCmm(aCmmFile)
    def pcAddr(self):
        return self._pcAddr
    def regRead(self, aRegOffset, aType):
        return self._debugger.readReg(aRegOffset, 1, aType)
    def regWrite(self, aRegOffset, aValue, aType):
        return self._debugger.writeReg(aRegOffset, aValue, aType)
    def writeMem(self, aAddr, aData):
        self._debugger.writeMem(aAddr, len(aData), aData)
    def readMem(self, aAddr, aNumItems, aType):
        return self._debugger.readArray(aAddr, aNumItems, aType)
    def downloadFile(self, aFile, aAddr):
        self._debugger.downloadFile(aFile, aAddr)
    def writeCPUReg(self, aRegIndex, aData):
        self._debugger.writeCPUReg(aRegIndex, aData)
    def resetAndHalt(self):
        self._debugger.resetAndHalt()
    def halt(self):
        self._debugger.halt()
    def disableWatchdog(self):
        self._debugger.disableWatchdog()
    def go(self):
        self._debugger.go()
    def close(self):
        self._debugger.close()

class TEST_MemInfo(TEST_Debugger):
    debugger = None
    chip = None
    arch = None
    em22fsTextStart = 0
    em22fsTextEnd = 0
    textBinFile = None
    def __init__(self, aType):
        self._addr   = None
        self._value  = None
        self._size   = None
        self._type   = aType
    @property
    def addr(self):
        return self._addr
    @addr.setter
    def addr(self, aAddr):
        if "bcm8958x" == self.chip and EM22FS == self.arch:
            if 0x90000000 != aAddr & 0xF0000000:
                if aAddr >= self.em22fsTextStart and aAddr <= self.em22fsTextEnd:
                    # print ("Addr from Bin : Addr 0x{:08X}".format(aAddr))
                    aAddr = aAddr # Dummy code to keep the print for debugging
                elif 0 != aAddr:
                    print ("ERROR !! Invalid Address 0x{:08X} mask 0x{:08X} :".format(aAddr, aAddr & 0xF0000000))
            else:
                aAddr = 0x20000000 | (aAddr & 0x0FFFFFFF)
        self._addr = aAddr
    @property
    def size(self):
        return self._size
    @size.setter
    def size(self, aCount):
        self._size = aCount
    @property
    def value(self):
        if "bcm8958x" == self.chip and EM22FS == self.arch and self._addr >= self.em22fsTextStart and  self._addr <= self.em22fsTextEnd:
            addrInBinFile = self._addr - 0x50080200
            with open(self.textBinFile, "rb") as f:
                f.seek(addrInBinFile)
                data = int(f.read(BCM_UINT32).hex(), 16)
                data = int.from_bytes(data.to_bytes(4, byteorder='little'), byteorder='big', signed=False)
                # print ("Value from Bin for Addr 0x{:08X}, Bin File Offset 0x{:08X} , data: 0x{:08X}".format(self._addr, addrInBinFile, data))
            return data
        else:
            if self._size == None:
                return self.debugger.regRead(self._addr, self._type)
            else:
                mem = self.debugger.readMem(self._addr, self._size, self._type)
                return [str(reg) for reg in mem]
    @value.setter
    def value(self, aValue):
        if type(aValue) == int:
            self.debugger.regWrite(self._addr, aValue, self._type)
        else:
            self.debugger.writeMem(self._addr, aValue)


class TEST_Queue(TEST_Global):
    # BCM_TestQType
    testMagic          = TEST_MemInfo(BCM_UINT32)
    testmajorVer       = TEST_MemInfo(BCM_UINT8)
    testminorVer       = TEST_MemInfo(BCM_UINT8)
    testSizeLog2       = TEST_MemInfo(BCM_UINT8)
    fifoLenLog2        = TEST_MemInfo(BCM_UINT8)
    rollovermask       = TEST_MemInfo(BCM_UINT16)
    targetRdIdx        = TEST_MemInfo(BCM_UINT32)
    targetWrIdx        = TEST_MemInfo(BCM_UINT32)
    hostRdIdx          = TEST_MemInfo(BCM_UINT32)
    hostWrIdx          = TEST_MemInfo(BCM_UINT32)
    hostMsgBuf         = TEST_MemInfo(BCM_UINT32)
    targetMsgBuff      = TEST_MemInfo(BCM_UINT32)
    # BCM_TestMsgHdrType
    msgMagic           = TEST_MemInfo(BCM_UINT32)
    msgId              = TEST_MemInfo(BCM_UINT32)
    msgLen             = TEST_MemInfo(BCM_UINT32)
    def __init__(self, aQBaseAddr, aQueue):
        self.QBaseAddr = aQBaseAddr
        self.Qchild    = aQueue
        self._updateAddr()
        self._verifyMagic()
    def _updateAddr(self):
        self.testMagic.addr     = self.QBaseAddr + BCM_TEST_MAGIC_OFFSET
        self.testmajorVer.addr  = self.QBaseAddr + BCM_TEST_VERSION_MAJOR_OFFSET
        self.testminorVer.addr  = self.QBaseAddr + BCM_TEST_VERSION_MINOR_OFFSET
        self.testSizeLog2.addr  = self.QBaseAddr + BCM_TEST_MSGSIZE_OFFSET
        self.fifoLenLog2.addr   = self.QBaseAddr + BCM_TEST_FIFOSIZE_OFFSET
        self.rollovermask.addr  = self.QBaseAddr + BCM_TEST_ROLLOVER_OFFSET
        self.targetRdIdx.addr   = self.QBaseAddr + BCM_TEST_TGET_RD_IDX_OFFSET
        self.targetWrIdx.addr   = self.QBaseAddr + BCM_TEST_TGET_WR_IDX_OFFSET
        self.hostRdIdx.addr     = self.QBaseAddr + BCM_TEST_HOST_RD_IDX_OFFSET
        self.hostWrIdx.addr     = self.QBaseAddr + BCM_TEST_HOST_WR_IDX_OFFSET
        self.hostMsgBuf.addr    = self.QBaseAddr + BCM_TEST_H2T_BUFF_OFFSET
        self.targetMsgBuff.addr = self.QBaseAddr + BCM_TEST_T2H_BUFF_OFFSET
        self.hostMsgBufAddr     = self.hostMsgBuf.value
        self.targetMsgBuffAddr  = self.targetMsgBuff.value
    def _updateHeaderAddr(self, aMsgBaseAddr):
        self.msgMagic.addr = aMsgBaseAddr + BCM_TEST_MSG_MAGIC_OFFSET
        self.msgId.addr    = aMsgBaseAddr + BCM_TEST_MSG_MSGID_OFFSET
        self.msgLen.addr   = aMsgBaseAddr + BCM_TEST_MSG_LEN_OFFSET
    def _verifyMagic(self):
        magic_timer = 0
        while BCM_TEST_MAGIC != self.testMagic.value:
            magic_timer += 1; time.sleep(1)
            if magic_timer > 120:
                self._error("Invalid Magic: 0x{:08X} at address: 0x{:08X} in queue: {}".format(self.testMagic.value, self.testMagic.addr, self.Qchild))
            else:
                print("Waiting for magic : {}".format(magic_timer))
        self._log("Magic Verified for Queue: " + self.Qchild)
    def _verifyMsgMagic(self):
        if BCM_TEST_MSG_MAGIC_CMD != self.msgMagic.value:
            self._error("Incorrect Target Msg Magic: 0x{:08X} in queue: {}".format(self.testMagic.value, self.Qchild))
        self._log("Target Msg Magic Verified of Queue: " + self.Qchild)
    def _increment(self, aReg):
        aReg.value = (aReg.value + 1) & self.rollovermask.value
    def _getBaseAddr(self, aValue, aBuffAddr):
        Idx = aValue & ((1 << self.fifoLenLog2.value) - 1)
        return aBuffAddr + (Idx * (1 << self.testSizeLog2.value))
    def isMsgAvailable(self):
        self._updateAddr()
        return True if (self.targetWrIdx.value != self.hostRdIdx.value) else False


class TEST_CmdQueue(TEST_Queue):
    # Write
    msgSeqId   = TEST_MemInfo(BCM_UINT32)
    # Read
    result     = TEST_MemInfo(BCM_UINT32)
    seq        = TEST_MemInfo(BCM_UINT32)
    failedCnt  = TEST_MemInfo(BCM_UINT32)
    passedCnt  = TEST_MemInfo(BCM_UINT32)
    compId     = TEST_MemInfo(BCM_UINT32)
    def __init__(self, aQBaseAddr):
        super().__init__(aQBaseAddr, self.__class__.__name__)
    def isReady(self):
        self._updateAddr()
        status = False
        fifoLen = (1 << self.fifoLenLog2.value)
        if ((self.targetRdIdx.value + fifoLen) & self.rollovermask.value) != self.hostWrIdx.value:
            status = True
        return status

    def sendMsg(self, aSeqId):
        self._updateAddr()
        QMsgBufferAddr = self._getBaseAddr(self.hostWrIdx.value, self.hostMsgBufAddr)
        # Update address
        self._updateHeaderAddr(QMsgBufferAddr)
        self.msgSeqId.addr    = QMsgBufferAddr + BCM_TEST_MSG_DATA_OFFSET
        # Send Data
        self.msgMagic.value  = BCM_TEST_MSG_MAGIC_CMD
        self.msgId.value     = BCM_MSG_START_TEST
        self.msgLen.value    = BCM_UINT32
        self.msgSeqId.value  = aSeqId
        self._increment(self.hostWrIdx)

    def readMsg(self):
        self._updateAddr()
        QMsgBufferAddr = self._getBaseAddr(self.hostRdIdx.value, self.targetMsgBuffAddr)
        # Update Address
        self._updateHeaderAddr(QMsgBufferAddr)
        self.result.addr      = QMsgBufferAddr + BCM_TEST_REQ_RESULT_OFFSET
        self.seq.addr         = QMsgBufferAddr + BCM_TEST_REQ_SEQ_OFFSET
        self.failedCnt.addr   = QMsgBufferAddr + BCM_TEST_REQ_FAILED_CNT_OFFSET
        self.passedCnt.addr   = QMsgBufferAddr + BCM_TEST_REQ_PASSED_CNT_OFFSET
        self.compId.addr      = QMsgBufferAddr + BCM_TEST_REQ_COMPID_OFFSET
        self._verifyMsgMagic()
        # Read Result
        result      = self.result.value
        seq         = self.seq.value
        failedCnt   = self.failedCnt.value
        passedCnt   = self.passedCnt.value
        compId      = self.compId.value
        self._increment(self.hostRdIdx)
        return self._int(result), seq


class TEST_ResultQueue(TEST_Queue):
    caseId = TEST_MemInfo(BCM_UINT32)
    result = TEST_MemInfo(BCM_UINT32)
    def __init__(self, aQBaseAddr):
        super().__init__(aQBaseAddr, self.__class__.__name__)
    def readMsg(self):
        self._updateAddr()
        QMsgBufferAddr = self._getBaseAddr(self.hostRdIdx.value, self.targetMsgBuffAddr)
        # Update Address
        self._updateHeaderAddr(QMsgBufferAddr)
        self.caseId.addr      = QMsgBufferAddr + BCM_TEST_RES_CASEID_OFFSET
        self.result.addr      = QMsgBufferAddr + BCM_TEST_RES_RESULT_OFFSET
        self._verifyMsgMagic()
        # Read Result
        caseId = self.caseId.value
        result = self.result.value
        self._increment(self.hostRdIdx)
        return result


class TEST_StreamQueue(TEST_Queue):
    # BCM_TestImglReqType
    flags              = TEST_MemInfo(BCM_UINT8)
    imgPid             = TEST_MemInfo(BCM_UINT8)
    imgID              = TEST_MemInfo(BCM_UINT16)
    imgOffset          = TEST_MemInfo(BCM_UINT32)
    imgLoadAddr        = TEST_MemInfo(BCM_UINT32)
    imgMaxSize         = TEST_MemInfo(BCM_UINT32)
    # BCM_TestImglResDataType
    imgResult          = TEST_MemInfo(BCM_UINT32)
    imgSz              = TEST_MemInfo(BCM_UINT32)
    size               = TEST_MemInfo(BCM_UINT32)
    loadAddr           = TEST_MemInfo(BCM_UINT32)
    def __init__(self, aQBaseAddr, aSysCfg):
        super().__init__(aQBaseAddr, self.__class__.__name__)
        self.sysCfg = aSysCfg
    def sendMsg(self, aMsgValue, aImage):
        self._updateAddr()
        QMsgBufferAddr = self._getBaseAddr(self.hostWrIdx.value, self.hostMsgBufAddr)
        # Update address
        self._updateHeaderAddr(QMsgBufferAddr)
        self.imgResult.addr        = QMsgBufferAddr + BCM_TEST_MSG_IMGL_RESULT_OFFSET
        self.imgSz.addr            = QMsgBufferAddr + BCM_TEST_MSG_IMGL_IMGSZ_OFFSET
        self.size.addr             = QMsgBufferAddr + BCM_TEST_MSG_IMGL_SZ_OFFSET
        # Send Response
        imageSize              = os.path.getsize(aImage.imgName)
        self.msgMagic.value    = BCM_TEST_MSG_MAGIC_CMD
        self.msgId.value       = aMsgValue
        self.msgLen.value      = 3 * BCM_UINT32
        self.imgSz.value       = imageSize
        # Load Image
        result = BCM_ERR_OK
        self.loadAddr.addr  = aImage.loadAddr
        self._log("Writing File: {}".format(aImage.imgName))
        if aImage.imgFull == True or aImage.reqSize >= imageSize:
            with open(aImage.imgName, "rb") as fp:
                if aImage.imgItbl == 2:
                    hdr = fp.read(BCM_IMG_HDR_SIZE)
                    imageSize = int.from_bytes(hdr[4:8], "little") + BCM_IMG_DWLD_HDR_SIZE - BCM_IMG_HDR_SIZE;
                data = fp.read(imageSize)
                self.loadAddr.value = data
                self.size.value     = imageSize
            self._log("Write Completed. Total bytes written: {:08X}".format(imageSize))
        else:
            # Raw image request
            with open(aImage.imgName, "rb") as fp:
                if aImage.offset + aImage.reqSize > imageSize:
                    aImage.reqSize = imageSize - aImage.offset
                fp.seek(aImage.offset)
                data = fp.read(aImage.reqSize)
                rdSize = len(data)
                self.loadAddr.value = data
                self.size.value = rdSize
                self._log("Write Completed. Total bytes written: {:08X}".format(rdSize))
        # Send Result
        self.imgResult.value   = result
        self._log("SendMsg in TEST_StreamQueue ")
        self._log("imgResult   addr : 0x{:08X}  value : 0x{:08X}".format(self.imgResult.addr, self.imgResult.value))
        self._log("imgSz       addr : 0x{:08X}  value : 0x{:08X}".format(self.imgSz.addr, self.imgSz.value))
        self._log("size        addr : 0x{:08X}  value : 0x{:08X}".format(self.size.addr, self.size.value))
        self._increment(self.hostWrIdx)

    def readMsg(self):
        self._updateAddr()
        QMsgBufferAddr = self._getBaseAddr(self.hostRdIdx.value, self.targetMsgBuffAddr)
        # Update address
        self._updateHeaderAddr(QMsgBufferAddr)
        self.flags.addr            = QMsgBufferAddr + BCM_TEST_MSG_IMGL_FLAGS_OFFSET
        self.imgPid.addr           = QMsgBufferAddr + BCM_TEST_MSG_IMGL_PID_OFFSET
        self.imgID.addr            = QMsgBufferAddr + BCM_TEST_MSG_IMGL_IMGID_OFFSET
        self.imgOffset.addr        = QMsgBufferAddr + BCM_TEST_MSG_IMGL_RAWOFF_OFFSET
        self.imgLoadAddr.addr      = QMsgBufferAddr + BCM_TEST_MSG_IMGL_LOADADDR_OFFSET
        self.imgMaxSize.addr       = QMsgBufferAddr + BCM_TEST_MSG_IMGL_MAXSZ_OFFSET
        self._verifyMsgMagic()
        # Read
        flag     = self.flags.value
        pid      = self.imgPid.value
        imgId    = self.imgID.value
        offset   = self.imgOffset.value
        loadAddr = self.imgLoadAddr.value
        maxSz    = self.imgMaxSize.value
        wrImgId  = self.msgId.value | BCM_CMD_RESPONSE_MASK
        self._log("\nReadMsg in TEST_StreamQueue ")
        self._log("flags        addr : 0x{:08X}  value : 0x{:08X}".format(self.flags.addr, flag))
        self._log("imgPid       addr : 0x{:08X}  value : 0x{:08X}".format(self.imgPid.addr, pid))
        self._log("imgID        addr : 0x{:08X}  value : 0x{:08X}".format(self.imgID.addr, imgId))
        self._log("imgOffset    addr : 0x{:08X}  value : 0x{:08X}".format(self.imgOffset.addr, offset))
        self._log("imgLoadAddr  addr : 0x{:08X}  value : 0x{:08X}".format(self.imgLoadAddr.addr, loadAddr))
        self._log("imgMaxSize   addr : 0x{:08X}  value : 0x{:08X}".format(self.imgMaxSize.addr, maxSz))
        # Search for Image in Database
        img = self.sysCfg.getImg(pid, imgId)
        img.update(flag, offset, loadAddr, maxSz)
        self._increment(self.hostRdIdx)
        return wrImgId, img

class TEST_Vcast(TEST_Global):
    # Raw Data
    fileID         = TEST_MemInfo(BCM_UINT32)
    statementAddr  = TEST_MemInfo(BCM_UINT32)
    statementSz    = TEST_MemInfo(BCM_UINT32)
    stmtArray      = TEST_MemInfo(BCM_UINT8)
    mcdcAddr       = TEST_MemInfo(BCM_UINT32)
    mcdcSz         = TEST_MemInfo(BCM_UINT32)
    mcdcArray      = TEST_MemInfo(BCM_UINT8)
    # String Data
    bufferSize     = TEST_MemInfo(BCM_UINT32)
    vcastBuffer    = TEST_MemInfo(BCM_UINT8)
    def __init__(self, aVcastUnitBaseAddr):
        self.vcastBaseAddr = aVcastUnitBaseAddr
    def _updateFileOffset(self, aOffset):
        self.fileID.addr        = self.vcastBaseAddr + aOffset + (0 * BCM_UINT32)
        self.statementAddr.addr = self.vcastBaseAddr + aOffset + (1 * BCM_UINT32)
        self.statementSz.addr   = self.vcastBaseAddr + aOffset + (2 * BCM_UINT32)
    def _updateMcdcOffset(self, aOffset):
        self.mcdcAddr.addr = self.vcastBaseAddr + aOffset + (0 * BCM_UINT32)
        self.mcdcSz.addr   = self.vcastBaseAddr + aOffset + (1 * BCM_UINT32)

    def captureDataRaw(self, aResultFile):
        fileIdx = 0
        dbg_statementAddrList = []
        dbg_statementSizeList = []
        statementDataList = []
        dbg_mcdcBitModeSizeList = []
        mcdcActualSizeList = []
        dbg_mcdcAddrList = []
        dbg_fileIdList = []
        mcdcList = []

        while (self.fileID.addr == None) or (self.fileID.value != 0):
            fileOffset = fileIdx * 84
            self._updateFileOffset(fileOffset)
            # Capture statement coverage data
            self.stmtArray.addr = self.statementAddr.value
            self.stmtArray.size = self.statementSz.value
            tempList            = self.stmtArray.value
            statementDataList.append(''.join(map(str, tempList)))
            dbg_statementSizeList.append(self.statementSz.value)
            dbg_statementAddrList.append(self.statementAddr.value)
            dbg_fileIdList.append(self.fileID.value)
            # Capture MCDC coverage data
            mcdcOffset = fileOffset + 12
            tempListBitWise = []
            tempListActual = []
            tempMcdcAddrList = []
            bitModeSz = 0
            mcdcFileList = []
            for i in range(9):
                self._updateMcdcOffset(mcdcOffset)
                mcdcOffset += 8
                mcdcSize = self.mcdcSz.value
                tempMcdcAddrList.append(self.mcdcAddr.value)
                tempListActual.append(mcdcSize)
                if (i == 0):
                    bitModeSz = (mcdcSize/4) + (1 if (mcdcSize%4) else 0)
                elif (i == 1):
                    bitModeSz = (mcdcSize/2) + (mcdcSize%2)
                elif (i == 2):
                    bitModeSz = (mcdcSize*3/2) + ((mcdcSize*3)%2)
                elif (i == 3):
                    bitModeSz = mcdcSize*4
                elif (i == 4):
                    bitModeSz = mcdcSize*10
                elif (i == 5):
                    bitModeSz = mcdcSize*24
                elif (i == 6):
                    bitModeSz = mcdcSize*56
                elif (i == 7):
                    bitModeSz = mcdcSize*128
                elif (i == 8):
                    bitModeSz = mcdcSize*288
                tempListBitWise.append(bitModeSz)
                bitModeSz = int(bitModeSz)
                self.mcdcArray.addr = self.mcdcAddr.value
                self.mcdcArray.size = bitModeSz * 8
                tempList            = self.mcdcArray.value
                mcdcFileList.append(tempList)
            dbg_mcdcAddrList.append(tempMcdcAddrList)
            mcdcActualSizeList.append(tempListActual)
            dbg_mcdcBitModeSizeList.append(tempListBitWise)
            mcdcList.append(mcdcFileList)
            fileIdx += 1
        # Generate Result DAT File
        if os.path.exists(aResultFile):
            os.remove(aResultFile)
        resultFilePtr = open(aResultFile, "w")
        fileIdx = 1
        mcdcUnitCondIndex = 0
        statementDataList.pop() # Remove last row which is always zero
        for fileStmtList in statementDataList:
            # Write Statement Result
            # Please refer to actual c-code in generated c_cover_io.c in vcast project folder.
            # Line number: 1294, VCAST_DUMP_STATEMENT_COVERAGE_DATA_ID
            for stmtId, data in enumerate(fileStmtList):
                if (1 == int(data)):
                    resultFilePtr.write('{} {}\n'.format(str(fileIdx), str(stmtId)))
                elif (0 != int(data)):
                    self._error("Error in captured statement coverage data")
                    resultFilePtr.close()
                    sys.exit(-1)
            # Write MCDC Result
            # Please refer to actual c-code in generated c_cover_io.c in vcast project folder.
            # Line number: 1425, VCAST_DUMP_OPTIMIZED_MCDC_COVERAGE_DATA_ID
            numCond = 0
            actualSize = 0
            for numCond in range(9):
                actualSize = mcdcActualSizeList[fileIdx-1][numCond]
                bit_offset = 0
                bits_needed = (1 << numCond) * (numCond + 1)
                if (bits_needed == 1):
                    bits_needed = 2
                for Id in range(actualSize):
                    cond_result_start = bit_offset + (1 << numCond)
                    used_start = bit_offset + (1 << (numCond + 1))
                    for cond_val in range(1 << numCond):
                        value = (mcdcList[fileIdx-1][numCond])[bit_offset + cond_val]
                        if (1 == int(value)):
                            actual_result = int((mcdcList[fileIdx-1][numCond])[cond_result_start + cond_val])
                            used_val = (1 << (1 if (numCond > 0) else 0)) | 1
                            mcdc_bits = (cond_val << 1) | actual_result
                            for i in range(numCond - 1):
                                used_val |= (int((mcdcList[fileIdx-1][numCond])[used_start + cond_val + i * (1 << numCond)])) << (2 + i)
                            resultFilePtr.write('{}{}{} {} {}\n'.format(str(fileIdx), str(chr(numCond + 97)), str(Id), str(mcdc_bits), str(used_val)))
                    bit_offset += bits_needed
            fileIdx += 1
        resultFilePtr.close()
        print("\ncoverage result file : " + aResultFile + "\n")

    def captureDataString(self, aResultFile):
        # Generate Result DAT File
        if os.path.exists(aResultFile):
            os.remove(aResultFile)
        self.bufferSize.addr = self.mapInfo.bufferSizeAddress
        self.vcastBuffer.adddr = self.mapInfo.bufferAddress
        self.vcastBuffer.size  = self.bufferSize.value
        resultFilePtr = open(aResultFile, "w")
        for each in self.vcastBuffer.value:
            resultFilePtr.write(str(each))
        resultFilePtr.close()

class LOAD_N_EXECUTE(TEST_Global):
    def __init__(self, aAppName, aOutDir, aMapInfo, aCfgObj, aSeqIds, aOutFile, aDebug):
        self.appName  = aAppName
        self.out      = aOutDir
        self.mapInfo  = aMapInfo
        self.sysCfg   = aCfgObj
        self.seqIds   = aSeqIds
        self.schema = etree.XMLSchema(objectify.fromstring(TEST_Schema))
        ## @brief Validating parser for the schema
        self.parser = objectify.makeparser(schema = self.schema)
        xmlFile = os.path.join(self.out,  self.appName + ".xml")
        if not os.path.isfile(xmlFile):
            self._error('xmlFile file not found: ' + str(xmlFile))
        fp = open(xmlFile, 'r')
        testXml = fp.read()
        fp.close()
        print(testXml)
        ## @brief Objectify tree for the SWR configuration
        self.testCfg = objectify.fromstring(testXml, self.parser)
        print(self.testCfg)
        self.xml      = XML_Generator(aOutFile + '.xml')
        self.debug    = aDebug

    def _timeDiff(self, aStartTime):
        return time.time() - aStartTime

    def download(self, aDebugger, aChip, aCmmFile, aArch):
        self._log("\nDownload and Reset Program\n")
        for each in self.testCfg.load:
            loadFile = os.path.join(self.out, str(each.file))
            if not os.path.isfile(loadFile):
                self._error('loadFile file not found: ' + str(loadFile))

        if aChip == 'bcm8958x':
            time.sleep(1)
            aDebugger.runCmm(aCmmFile)  # run cmm file to download image and to set PC
        else:
            aDebugger.resetAndHalt()                                            # reset and Halts the ARM core
            aDebugger.disableWatchdog()                                         # Disable Watchdog
            for each in self.testCfg.load:
                loadFile = os.path.join(self.out, str(each.file))
                aDebugger.downloadFile(loadFile, int(str(each.address), 16))          		# Load binary file
            if self.testCfg.ep is not None:
                aDebugger.writeCPUReg(aDebugger.pcAddr(), int(str(self.testCfg.ep), 16)) # Set program counter

        if EM22FS != aArch:
            aDebugger.go() # Restarts the CPU after it has been halted and allows instruction set simulation

    def executeTest(self, aPollingTime, aTimeOut):
        self._log("\nStart Test Execution\n")

        self._log('BCM_TestCmdQ       address : 0x{:08X}'.format(self.mapInfo.BCM_TestCmdQ))
        self._log('BCM_TestResultQ    address : 0x{:08X}'.format(self.mapInfo.BCM_TestResultQ))
        self._log('BCM_TestStreamQ    address : 0x{:08X}'.format(self.mapInfo.BCM_TestStreamQ))

        cmdQueue    = TEST_CmdQueue(self.mapInfo.BCM_TestCmdQ)
        resQueue    = TEST_ResultQueue(self.mapInfo.BCM_TestResultQ)
        asyncQueue  = TEST_StreamQueue(self.mapInfo.BCM_TestStreamQ, self.sysCfg)

        lastResponse = time.time()
        for seqId in self.seqIds:
            startTime = time.time()
            print("\nRunning Test Sequences: " + str(hex(seqId)))
            if cmdQueue.isReady() == True:
                cmdQueue.sendMsg(seqId)
                # wait for target response
                waitForResp = True
                while waitForResp:
                    # check for async queue first
                    if asyncQueue.isMsgAvailable():
                        wrImgId, rdImg = asyncQueue.readMsg()
                        asyncQueue.sendMsg(wrImgId, rdImg)
                    # check if message available from Cmd Queue
                    if cmdQueue.isMsgAvailable():
                        respValue, respSeqId = cmdQueue.readMsg()
                        respMsg = TEST_ERROR_MSG[respValue] if respValue in TEST_ERROR_MSG.keys() else '0x{:08X}'.format(respValue)
                        endTime = self._timeDiff(lastResponse); lastResponse = time.time()
                        print("[Time taken: {}] Response Read of Seq({}) : {}".format("{:.4f}".format(endTime), hex(respSeqId), str(respMsg)))
                        self.xml.updateXML(respSeqId, respMsg, "{:.4f}".format(endTime))
                        if cmdQueue.isMsgAvailable() == False:
                            waitForResp = False
                    else:
                        if self._timeDiff(startTime) > aTimeOut and False == self.debug:
                            print("Error Time out. Proceeding to next test sequence"); break
                        time.sleep(aPollingTime)
            else:
                self._error("Send Message Queue is Full. No Response from the target")
        self.xml.createXML()

    def dumpCoverageData(self, aResultFile, aDebugger, aType):
        aDebugger.halt()
        vcast = TEST_Vcast(self.mapInfo.vcastUnitList)
        print("Capturing coverage data from target..")
        if aType == TEST_COVERAGE_DATA_RAW:
            vcast.captureDataRaw(aResultFile)
        else:
            vcast.captureDataString(aResultFile)
        aDebugger.go()

def extractZip(aFile):
    outDir  = ""
    appName = ""
    folder = tempfile.mkdtemp()
    if aFile.endswith(".tar.gz"):
        tar = tarfile.open(aFile)
        tar.format = tarfile.GNU_FORMAT
        tar.extractall(folder)
        tar.close()
    elif aFile.endswith(".zip"):
        with ZipFile(str(aFile), 'r') as zip:
            zip.extractall(folder)
    else:
        print('Unknown file format');
    for each in os.listdir(folder):
        if each.endswith(".map"):
            mapFile = os.path.join(folder, each)
            print(mapFile)
            outDir = os.path.dirname(mapFile)
            appName = os.path.splitext(os.path.basename(mapFile))[0]
    # Extract bin files in tarball
    tar = tarfile.open(os.path.join(outDir, appName + ".tar"))
    tar.format = tarfile.GNU_FORMAT
    tar.extractall(os.path.join(folder + "tar"))
    tar.close()
    binFiles = [os.path.join(folder + "tar", b) for b in os.listdir(os.path.join(folder + "tar"))]
    return outDir, appName, binFiles, folder

def TEST_Usage():
    print("""
    USAGE: load_n_execute.py
        [-h, --help]        Display this help message
         -m, --mcm          Add "-m" only for MCM board
         -c, --chip         Chip family
         -d, --debugger     0 = Segger | 1 = Lauterbach
         -l, --debug        Add "--debug" to halt excution after load
         -f, --file         zip File
         -o, --out          result output dir
         -n  --name         suffix name for result files
         -a  --arch         Add "-a" only for bcm8958x 0 = m7 | 1 = em22fs
         -t, --test         seq test Ids [e.g. 0x0001 / 0x0001--0x0080 / 0x0001--0x0080,0x1001--0x1020]
         -s, --sn           Serial number          [optional]
         -p, --ptime        Polling time (in ms)   [optional]
         -r, --timeout      Time out (in s)        [optional]""")
    sys.exit(2)

def TEST_Main():
    isMCM     = False
    debug     = False
    chip      = None
    ifc       = 0
    zipFile   = None
    testSeq   = None
    sn        = None
    ptime     = 0.01
    resultDir = os.getcwd()
    name      = ''
    arch      = M7
    timeout   = 10
    sys_cfg  = "sys_cfg.txt"
    try:
        opts, args = getopt.getopt(sys.argv[1:], "hmlc:d:s:t:f:o:n:a:p:r:", \
        ["help", "mcm", "debug", "chip=", "debugger=", "sn=", "file=", "ptime=", "timeout=", "test=", "out=", "name=", "arch="])
    except:
        print("Error in parsing arguments")
        TEST_Usage()
    for opt, arg in opts:
        if opt in ("-h", "--help"):
            TEST_Usage()
        elif opt in ("-m", "--mcm"):
            isMCM    = True
        elif opt in ("-l", "--debug"):
            debug    = True
            TEST_Global.verbose = 1
        elif opt in ("-c", "--chip"):
            chip     = arg
        elif opt in ("-d", "--debugger"):
            ifc      = int(arg)
        elif opt in ("-s", "--sn"):
            sn       = int(arg)
        elif opt in ("-p", "--ptime"):
            ptime    = int(arg) * 0.001
        elif opt in ("-r", "--timeout"):
            timeout  = int(arg)
        elif opt in ("-f", "--file"):
            zipFile  = os.path.abspath(arg)
        elif opt in ("-o", "--out"):
            resultDir  = os.path.abspath(arg)
        elif opt in ("-n", "--name"):
            name  = '_' + arg
        elif opt in ("-a", "--arch"):
            arch   = int(arg)
        elif opt in ("-t", "--test"):
            testSeq  = str(arg)
        else:
            print("Unknown argument %s" % opt)
            TEST_Usage()
    if not zipFile:
        print("zip File Not Found!")
        TEST_Usage()
    elif not zipFile.endswith((".tar.gz", ".zip")):
        print("Input file should be .tar.gz or .zip")
        TEST_Usage()
    elif chip == None:
        TEST_Usage()

    outDir, appName, binFiles, folder = extractZip(zipFile)

    outFile = os.path.join(resultDir, appName + name)
    if not os.path.exists(os.path.dirname(outFile)):
        os.makedirs(os.path.dirname(outFile))

    mapFile = os.path.join(outDir, appName + ".map")
    cmmFile = os.path.join(outDir, appName + ".cmm")
    if os.path.isfile(os.path.join(outDir, sys_cfg)):
        sys_cfg = os.path.join(outDir, sys_cfg)
    else:
        print("[Error] {} file not found.".format(sys_cfg)); sys.exit(2)

    if 'bcm8958x' == chip and EM22FS == arch:
        textBinFile = os.path.join(outDir, appName + ".text.bin")
        if os.path.isfile(textBinFile):
            print("VAST RO data from bin: " + textBinFile)
        else:
            print("[Error] {} file not found.".format(textBinFile)); sys.exit(2)

    seqTestList = []
    if testSeq != None:
        seqList = testSeq.split(",")
        for seq in seqList:
            if "--" in seq:
                seqStart = seq.split("--")[0]
                seqEnd   = seq.split("--")[1]
                for seqId in range(int(seqStart, 16), int(seqEnd, 16) + 1):
                    seqTestList.append(seqId)
            else:
                seqTestList.append(int(seq, 16))

    mapObj   = TEST_MapParser(mapFile)
    cfgObj   = TEST_CfgParser(sys_cfg, binFiles)
    debugger = TEST_Debugger(chip, ifc, sn, isMCM)
    TEST_MemInfo.debugger = debugger
    TEST_MemInfo.chip = chip
    TEST_MemInfo.arch = arch

    if 'bcm8958x' == chip and EM22FS == arch:
        TEST_MemInfo.em22fsTextStart = mapObj.em22fsTextStart
        TEST_MemInfo.em22fsTextEnd = mapObj.em22fsTextEnd
        TEST_MemInfo.textBinFile = textBinFile
        print ("Text Section 0x{:08X} -- 0x{:08X}".format(mapObj.em22fsTextStart, mapObj.em22fsTextEnd))

    leObj = LOAD_N_EXECUTE(appName, outDir, mapObj, cfgObj, seqTestList, outFile, debug)
    leObj.download(debugger, chip, cmmFile, arch)
    if chip == 'bcm8958x':
        time.sleep(3)

    if debug:
        input("\nDownload completed!\nPress enter to continue...")
    if len(seqTestList) > 0:
        leObj.executeTest(ptime, timeout)

    if int(mapObj.vcastUnitList) > 0:
        resultFileName = outFile + '.dat'
        leObj.dumpCoverageData(resultFileName, debugger, TEST_COVERAGE_DATA_RAW)

    debugger.close()

    if chip != 'bcm8958x':
        shutil.rmtree(folder)

if __name__ == '__main__':
    TEST_Main()
