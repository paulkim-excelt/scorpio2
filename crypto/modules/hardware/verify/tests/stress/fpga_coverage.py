# Copyright: Copyright 2021 Broadcom Limited.
#
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
#

import os
import time
import argparse
import logging
import random
from datetime import datetime

import arcdbg

BCM_UINT8                        = 1
BCM_UINT32                       = 4

class TEST_Debugger:
    def __init__(self, dbg_session):
        self.dbg_session = dbg_session

    def readReg(self, addr, mem_type):
        if (mem_type == BCM_UINT8):
            return self.dbg_session.read_uint8(addr)
        else:
            return self.dbg_session.read_int(addr)

    def readMem(self, addr, size, mem_type):
        mult = 1 if (mem_type == BCM_UINT8) else 4
        return [self.readReg(addr + (i * mult), mem_type) for i in range(0, size)]

class TEST_MemInfo(TEST_Debugger):
    def __init__(self, dbg_session, aType):
        self._addr   = None
        self._value  = None
        self._size   = None
        self._type   = aType
        super().__init__(dbg_session)

    @property
    def addr(self):
        return self._addr

    @addr.setter
    def addr(self, aAddr):
        self._addr = aAddr

    @property
    def size(self):
        return self._size

    @size.setter
    def size(self, aCount):
        self._size = aCount

    @property
    def value(self):
        if self._size == None:
            return self.readReg(self._addr, self._type)
        else:
            mem = self.readMem(self._addr, self._size, self._type)
            return [str(reg) for reg in mem]

class TEST_Vcast:
    def __init__(self, dbg_session, aVcastUnitBaseAddr):
        self.vcastBaseAddr = aVcastUnitBaseAddr
        # Raw Data
        self.fileID         = TEST_MemInfo(dbg_session, BCM_UINT32)
        self.statementAddr  = TEST_MemInfo(dbg_session, BCM_UINT32)
        self.statementSz    = TEST_MemInfo(dbg_session, BCM_UINT32)
        self.stmtArray      = TEST_MemInfo(dbg_session, BCM_UINT8)
        self.mcdcAddr       = TEST_MemInfo(dbg_session, BCM_UINT32)
        self.mcdcSz         = TEST_MemInfo(dbg_session, BCM_UINT32)
        self.mcdcArray      = TEST_MemInfo(dbg_session, BCM_UINT8)
        # String Data
        self.bufferSize     = TEST_MemInfo(dbg_session, BCM_UINT32)
        self.vcastBuffer    = TEST_MemInfo(dbg_session, BCM_UINT8)

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

def COV_ArgparseValidateReadableFilePath(fs_path):
    if os.access(fs_path, os.F_OK | os.R_OK):
        return fs_path
    raise FileNotFoundError(fs_path)

def COV_ProcessCmdLineArgs():
    # Construct the parser object
    parser = argparse.ArgumentParser(
        allow_abbrev=False,
        formatter_class=argparse.RawTextHelpFormatter,
    )

    parser.add_argument('elf',
        type=COV_ArgparseValidateReadableFilePath,
        help='Path to the elf file to work with'
    )

    parser.add_argument('poll_global',
        type=str,
        help='Global that the script should poll on to monitor the test execution progress'
    )

    parser.add_argument('--fail_line_global',
        type=str,
        help='Fail line global'
    )

    # Parse the cmdline args and return
    return parser.parse_args()

def COV_Main():
    # Setup logger
    logging.basicConfig(format='%(asctime)s %(levelname)s: %(message)s', level=logging.INFO)

    # Parse command line arguments
    parsed_args = COV_ProcessCmdLineArgs()

    # Compute the result file name
    out_file = str(os.path.basename(parsed_args.elf)).replace('elf', 'dat')

    # Open a debug session
    dbg_session = arcdbg.new(parsed_args.elf)

    # Print out test exec results
    vcast_unit_list_addr = dbg_session.get_address_of('vcast_unit_list_values')
    poll_addr = dbg_session.get_address_of(parsed_args.poll_global)

    if parsed_args.fail_line_global != None:
        fail_line_addr = dbg_session.get_address_of(parsed_args.fail_line_global)
    else:
        fail_line_addr = 0

    # Start the program execution and wait for completion
    BCM_AT_NOT_AVAILABLE = 0xFFFFFFFF
    BCM_AT_NOT_STARTED   = 0xFFFFFFFE
    BCM_AT_EXECUTING     = 0xFFFFFFFD

    dbg_session.run()

    time.sleep(5)
    poll_val = dbg_session.read_int(poll_addr)
    while (poll_val == BCM_AT_NOT_AVAILABLE) or \
          (poll_val == BCM_AT_NOT_STARTED) or   \
          (poll_val == BCM_AT_EXECUTING):
        time.sleep(5)
        poll_val = dbg_session.read_int(poll_addr)

    if fail_line_addr != 0:
        print(f'Fail line: {hex(dbg_session.read_int(fail_line_addr))}')

    print(f'Result: {hex(poll_val)}')

    # Generate the coverage report
    vcast = TEST_Vcast(dbg_session, vcast_unit_list_addr)
    vcast.captureDataRaw(out_file)

if __name__ == "__main__":
    COV_Main()

