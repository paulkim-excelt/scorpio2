#!/usr/bin/python3

#
# $Id$
# Copyright: Copyright 2021 Broadcom Limited.
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
import tempfile, tarfile
import binascii
from zipfile import ZipFile
from hipc import *

# RPC_CmdIdValType
RPC_CMDIDVAL_PING                 = 0x01        # brief PING
RPC_CMDIDVAL_DWNLD_IMG_HDR_V1     = 0x02        # brief Image Header
RPC_CMDIDVAL_DWNLD_IMG_V1         = 0x03        # brief Image
RPC_CMDIDVAL_IMAGE_FETCH_V1       = 0x10        # brief Fetch
RPC_CMDIDVAL_IMAGE_PART_FETCH_V1  = 0x11        # brief Part Fetch
RPC_CMDIDVAL_TABLE_FETCH_V1       = 0x20        # brief Fetch Image/Partition Table
RPC_CMDIDVAL_DWNLD_IMG_HDR_V2     = 0x04        # brief Image Header - V2
RPC_CMDIDVAL_IMAGE_FETCH_V2       = 0x12        # brief Fetch - V2
RPC_CMDIDVAL_IMAGE_PART_FETCH_V2  = 0x13        # brief Part Fetch - V2
RPC_CMDIDVAL_DWNLD_IMG_V2         = 0x05        # brief Image - V2

SYSTEM_ASYNCID_DEBUG              = 0x40

RPC_STREAMDATA_PAYLOAD_SIZE = 384

IMGL_IMGH_MAGIC             = 0x494D4748         # Loader Image header magic [IMGH]
IMGL_IMGH_IV_SIZE           = 0x10               # Decryption Initial vector size
IMGL_IMGH_SIGN_SIZE         = 0x100              # Signature size
IMGL_IMGH_DWNLD_HDR_SIZE    = 20                 # Download Img Hdr Size

# RPC Status
RPC_STATUS_IMAGE_REQ_LISTENER       = 0
RPC_STATUS_IMAGE_HDR_SEND           = 2
RPC_STATUS_IMAGE_DATA_SEND          = 4
RPC_STATUS_IMAGE_DATA_XFER_DONE     = 6

# LOADER_ImgFlagsType
LOADER_IMG_FLAGS_EDC_MASK      = 0x3
LOADER_IMG_FLAGS_EDC_SHIFT     = 0x0
LOADER_IMG_FLAGS_EDC_CRC       = 0x1
LOADER_IMG_FLAGS_FLASH_MASK    = 0x4
LOADER_IMG_FLAGS_FLASH_SHIFT   = 0x2
LOADER_IMG_FLAGS_PID_MASK      = 0xFF0
LOADER_IMG_FLAGS_PID_SHIFT     = 0x4
LOADER_IMG_FLAGS_IMGID_MASK    = 0xFFFF000
LOADER_IMG_FLAGS_IMGID_SHIFT   = 0xC

def uint8_t(aValue, aIndex):
    if aIndex > 3:
        print("Error in uint8_t conversion. Invalid index: {}".format(aIndex))
    aValue = aValue >> (24 - (8 * aIndex))
    return aValue & 0xff
def uint16_t(aValue, aIndex):
    if aIndex > 1:
        print("Error in uint16_t conversion. Invalid index: {}".format(aIndex))
    aValue = aValue >> (16 - (16 * aIndex))
    return aValue & 0xffff

class RPC_Global:
    VERBOSE = False
    LOGGING = None
    TEST_MODE = False
    def _error(self, aMsg):
        DEBUGGER.ifc.close()
        self.logging("[Error] {}".format(aMsg))
        sys.exit(1)
    def _add_to_log_file(self, aMsg):
        if RPC_Global.LOGGING:
            with open(RPC_Global.LOGGING, "a") as fp:
                fp.write("\n" + aMsg)
    def _log(self, aLog):
        if RPC_Global.VERBOSE:
            print(aLog)
            self._add_to_log_file(aLog)
    def logging(self, aLog):
        print(aLog)
        self._add_to_log_file(aLog)




class RPC_ImgReqType(RPC_Global):
    def __init__(self):
        self.isImgHdr        = None  # uint8_t
        self.pid             = None  # uint8_t
        self.imgID           = None  # uint16_t
        self.imgMaxSize      = None  # uint32_t
    def update(self, aList):
        if len(aList) < 2:
            self._error("Invalid list size in RPC_ImgReqType")
        self.isImgHdr       = uint8_t(aList[0], 3)
        self.pid            = uint8_t(aList[0], 2)
        self.imgID          = uint16_t(aList[0], 0)
        self.imgMaxSize     = aList[1]
    def print(self, aFlag):
        if aFlag == False:
            self._log("\nFetch request(v1) from target:\nisTbl:0x{:02X}\npid:0x{:02X}\nimgID:0x{:04X}\nimgMaxSize: 0x{:08X}\n".format(\
                    self.isImgHdr, self.pid, self.imgID, self.imgMaxSize))
        else:
            self._log("\nFetch request(v1) from target: pid:0x{:02X} imgID:0x{:04X}".format(self.pid, self.imgID))

class RPC_DwnldHdrType(RPC_Global):
    def __init__(self):
        self.magicNum        = None         # uint32_t - LOADER_IMGH_MAGIC
        self.imgSize         = None         # uint32_t - Size of the image
        self.flags           = None         # uint32_t - LOADER_ImgFlagsType
        self.errDetCode      = None         # uint64_t - Error detection code
    def update(self, aList):
        if len(aList) < 5:
            self._error("Invalid list size in RPC_ImgReqV2Type")
        self.magicNum        = aList[1]
        self.imgSize         = aList[2]
        self.flags           = aList[3]
        self.errDetCode      = ((aList[4] & 0xffffffff) << 32) | (aList[5] & 0xffffffff)
    def getList(self):
        ret = []
        ret.append(self.magicNum)
        ret.append(self.imgSize)
        ret.append(self.flags)
        ret.append((self.errDetCode >> 32) & 0xffffffff)
        ret.append(self.errDetCode & 0xffffffff)
        return ret
    def print(self, aTitle):
        self.logging("\n{}:\nmagicNum:0x{:08X}\nimgSize:0x{:08X}\nflags:0x{:08X}\nerrDetCode: 0x{:016X}\n"\
            .format(aTitle, self.magicNum, self.imgSize, self.flags, self.errDetCode))

class RPC_ImgReqV2Type(RPC_Global):
    def __init__(self):
        self.isTbl          = None     #  uint8_t
        self.pid            = None     #  uint8_t
        self.imgID          = None     #  uint16_t
        self.imgMaxSize     = None     #  uint32_t
        self.targetStrmHdl  = None     #  uint32_t
        self.offset         = None     #  uint32_t
    def update(self, aList):
        if len(aList) < 4:
            self._error("Invalid list size in RPC_ImgReqV2Type")
        self.isTbl          = uint8_t(aList[0], 3)
        self.pid            = uint8_t(aList[0], 2)
        self.imgID          = uint16_t(aList[0], 0)
        self.imgMaxSize     = aList[1]
        self.targetStrmHdl  = aList[2]
        self.offset         = aList[3]
    def getList(self):
        ret = []
        ret.append(self.magicNum)
        ret.append((self.pid & 0xffff) << 24 | ((self.rsv & 0xff) << 16) | (self.imgID & 0xffff))
        ret.append(self.imgSize)
        ret.append(self.targetStrmHdl)
        ret.append(self.hostStrmHdl)
        ret.append(self.response)
        return ret
    def print(self, aFlag):
        if aFlag == False:
            self._log("\nFetch request (v2) from target:\nisTbl=0x{:02X}\npid=0x{:02X}\nimgID=0x{:04X}\nimgMaxSize=0x{:08X}\ntargetStrmHdl=0x{:08X}\noffset=0x{:08X}" \
                .format(self.isTbl, self.pid, self.imgID, self.imgMaxSize, self.targetStrmHdl, self.offset))
        else:
            self._log("\nFetch request (v2) from target: pid=0x{:02X} imgID=0x{:04X}".format(self.pid, self.imgID))

class RPC_DwnldHdrV2Type(RPC_Global):
    def __init__(self):
        self.magicNum      = None       # Size: 32-bit
        self.pid           = None       # Size:  8-bit
        self.rsv           = None       # Size:  8-bit
        self.imgID         = None       # Size: 16-bit
        self.imgSize       = None       # Size: 32-bit
        self.targetStrmHdl = None       # Size: 32-bit
        self.hostStrmHdl   = None       # Size: 32-bit
        self.response      = None       # Size: 32-bit
    def update(self, aList):
        if len(aList) < 6:
            self._error("Invalid list size in RPC_DwnldHdrV2Type")
        self.magicNum      = aList[0]
        self.pid           = uint8_t(aList[1], 3)
        self.rsv           = uint8_t(aList[1], 2)
        self.imgID         = uint16_t(aList[1], 0)
        self.imgSize       = aList[2]
        self.targetStrmHdl = aList[3]
        self.hostStrmHdl   = aList[4]
        self.response      = aList[5]
    def getList(self):
        ret = []
        ret.append(self.magicNum)
        ret.append((self.pid & 0xffff) << 24 | ((self.rsv & 0xff) << 16) | (self.imgID & 0xffff))
        ret.append(self.imgSize)
        ret.append(self.targetStrmHdl)
        ret.append(self.hostStrmHdl)
        ret.append(self.response)
        return ret
    def print(self, aTitle):
        self.logging("\n{}:\nmagicNum:0x{:08X}\npid:0x{:02X}\nimgID:{:04X}\nimgSize:0x{:08X}\ntargetStrmHdl:0x{:08X}\nhostStrmHdl: 0x{:016X}\nresponse: 0x{:016X}\n"\
            .format(aTitle, self.magicNum, self.pid, self.imgID, self.imgSize, self.targetStrmHdl, self.hostStrmHdl, self.response))

class RPC_DwnldImageType(RPC_Global):
    def __init__(self):
        self.magicNum      = None                                       # uint32_t
        self.pid           = None                                       # uint8_t
        self.rsv1          = None                                       # uint8_t
        self.imgID         = None                                       # uint16_t
        self.offset        = None                                       # uint32_t
        self.targetStrmHdl = None                                       # uint32_t
        self.hostStrmHdl   = None                                       # uint32_t
        self.len           = None                                       # uint32_t
        self.response      = None                                       # int32_t
        self.rsv2          = None                                       # uint32_t
        self.imgData       = []                                         # 384-bytes
    def update(self, aList):
        if len(aList) < 8:
            self._error("Invalid list size in RPC_DwnldImageType")
        self.magicNum      = aList[0]
        self.pid           = uint8_t(aList[1], 3)
        self.rsv1          = uint8_t(aList[1], 2)
        self.imgID         = uint16_t(aList[1], 0)
        self.offset        = aList[2]
        self.targetStrmHdl = aList[3]
        self.hostStrmHdl   = aList[4]
        self.len           = aList[5]
        self.response      = aList[6]
        self.rsv2          = aList[7]
        for i in range(8, len(aList)):
            self.imgData.append(aList[i])

    def getList(self):
        ret = []
        ret.append(self.magicNum)
        ret.append((self.pid & 0xffff) << 24 | ((self.rsv1 & 0xff) << 16) | (self.imgID & 0xffff))
        ret.append(self.offset)
        ret.append(self.targetStrmHdl)
        ret.append(self.hostStrmHdl)
        ret.append(self.len)
        ret.append(self.response)
        ret.append(self.rsv2)
        ret.extend(self.imgData)
        return ret
    def print(self, aTitle):
        self.logging("""{}:
            magicNum      = 0x{:08X}
            pid           = 0x{:02X}
            imgID         = 0x{:04X}
            offset        = 0x{:08X}
            targetStrmHdl = 0x{:08X}
            hostStrmHdl   = 0x{:08X}
            len           = 0x{:08X}
            response      = 0x{:08X}
            imgData       = {}
            """.format(aTitle, self.magicNum, self.pid, self.imgID, self.offset, self.targetStrmHdl, self.hostStrmHdl, \
                       self. len, self.response, self.imgData))

class RPC_Interface(RPC_Global):
    RPC_RETRY_VALUE = 0x10
    def __init__(self, aChip, aZipFile, aExecTime, aTimeOut):
        self.chip    = aChip
        self.zipFile = aZipFile
        self.status  = RPC_STATUS_IMAGE_REQ_LISTENER
        self.folder  = None
        self.reqImg  = None
        self.fileOffset = 0
        self.lastPacket = False
        self.imageSize  = 0
        self.loop_count = 0
        self.exec_time  = aExecTime
        self.time_out   = aTimeOut
        self.file_xferd = False
        self.rcvCount = 0
        if self.zipFile != None:
            self._extract_files()
    def _error(self, aMsg):
        self.exit()
        super()._error(aMsg)
    def _get_file_name(self, aPID, aImgID):
        if self.chip == "bcm8957x":
            image  = "{:02X}_{:04X}.bin".format(aPID, aImgID)
        elif self.chip == "bcm8958x":
            image  = "bcm-00A03590-00089582-00000000-00{:02X}{:04X}-00000000-00030000.bin".format(aPID, aImgID)
        else:
            self._error("Invalid Chip: {}".format(self.chip))
        return image
    def _extract_files(self):
        self.files = []
        self.folder = tempfile.mkdtemp()
        if self.zipFile.endswith(".tar.gz"):
            tar = tarfile.open(self.zipFile)
            tar.format = tarfile.GNU_FORMAT
            tar.extractall(self.folder)
            tar.close()
        elif self.zipFile.endswith(".zip"):
            with ZipFile(str(self.zipFile), 'r') as zip:
                zip.extractall(os.path.join(self.folder, "tar"))
            self.files = [os.path.join(self.folder, "tar", b) for b in os.listdir(os.path.join(self.folder, "tar"))]
        else:
            self.logging('Unknown file format');
        for each in os.listdir(self.folder):
            if each.endswith(".tar"):
                tarFile = os.path.join(self.folder, each)
                # Extract bin files in tarball
                tar = tarfile.open(os.path.join(tarFile))
                tar.format = tarfile.GNU_FORMAT
                tar.extractall(os.path.join(self.folder, "tar"))
                tar.close()
                self.files = [os.path.join(self.folder, "tar", b) for b in os.listdir(os.path.join(self.folder, "tar"))]
                break
    def _print_download_time(self):
        if self.lastPacket:
            self.dwnldETime = time.perf_counter_ns()
            self.logging("Download Time:{:.3f}".format((self.dwnldETime - self.dwnldSTime) / (10**9)))
    def reset_time(self):
        self.start_time = time.time()
    def curr_time(self):
        return time.time() - self.start_time
    def update_status(self, aStatus):
        self.status = aStatus
        self.reset_time()
    def restart_state_machine(self):
        self._log("\nRestarting the state machine")
        self.status     = RPC_STATUS_IMAGE_REQ_LISTENER
        self.fileOffset = 0
        self.lastPacket = False
        self.loop_count += 1
        self.reset_time()
    def reset_rpc(self, aFileFlag=False):
        self._log("\nRestarting RPC")
        self.status     = RPC_STATUS_IMAGE_REQ_LISTENER
        self.fileOffset = 0
        self.lastPacket = False
        self.loop_count = 0
        self.file_xferd = aFileFlag
        self.reset_time()
    def read_bin(self, aOffset, aSize):
        data = None
        if self.reqImg != None:
            with open(self.reqImg, "rb") as fp:
                fp.seek(aOffset)
                data = fp.read(aSize)
        return data
    def get_file_CRC(self, aFile):
        with open(aFile, "rb") as fp:
            content = fp.read()
        return binascii.crc32(content, 0xffffffff)
    def update_list_8bit_to_32bit(self, aList):
        ret = []
        for i in range(0, len(aList), 4):
            ret.append(aList[i+3] << 24 | aList[i+2] << 16 | aList[i+1] << 8 | aList[i])
        return ret

    def send_image_header_v1(self, aImgReq):
        retVal = BCM_ERR_OK
        image  = self._get_file_name(aImgReq.pid, aImgReq.imgID)
        for file in self.files:
            if os.path.basename(file) == image:
                self.reqImg = file
        if self.reqImg == None:
            self._error("Request Image not fonud in the zip file: {}".format(image))
        else:
            self._log("Sending image: {}".format(image))
        self.imageSize = os.path.getsize(self.reqImg)
        dlHdr = RPC_DwnldHdrType()
        dlHdr.magicNum        = IMGL_IMGH_MAGIC
        dlHdr.imgSize         = self.imageSize
        dlHdr.flags           = 1
        dlHdr.errDetCode      = self.get_file_CRC(self.reqImg)

        dlHdr.print("Sending Image Header to target")
        data = dlHdr.getList()
        dataSize = 4 * len(data)
        hdrCmdId = RPC_CMDID(BCM_GROUPID_IMGL, BCM_RSV_ID, RPC_CMDIDVAL_DWNLD_IMG_HDR_V1)
        retVal   = HIPC_Send(hdrCmdId, data, dataSize)
        if retVal != BCM_ERR_OK:
            self.logging("IMGH Send Failed with error: {}".format(retVal))
        return retVal

    def send_image_header_v2(self, aImgReq):
        retVal = BCM_ERR_OK
        image  = self._get_file_name(aImgReq.pid, aImgReq.imgID)
        for file in self.files:
            if os.path.basename(file) == image:
                self.reqImg = file
        if self.reqImg == None:
            self._error("Request Image not fonud in the zip file: {}".format(image))
        else:
            self._log("Sending image: {}".format(image))
        self.imageSize = os.path.getsize(self.reqImg)
        dlHdr = RPC_DwnldHdrV2Type()
        dlHdr.magicNum      = IMGL_IMGH_MAGIC
        dlHdr.pid           = aImgReq.pid
        dlHdr.rsv           = 0
        dlHdr.imgID         = aImgReq.imgID
        dlHdr.imgSize       = self.imageSize
        dlHdr.targetStrmHdl = aImgReq.targetStrmHdl
        dlHdr.hostStrmHdl   = 0
        dlHdr.response      = BCM_ERR_OK
        dlHdr.print("Sending Image Header to target")
        data = dlHdr.getList()
        dataSize = 4 * len(data)
        hdrCmdId = RPC_CMDID(BCM_GROUPID_IMGL, BCM_RSV_ID, RPC_CMDIDVAL_DWNLD_IMG_HDR_V2)
        retVal   = HIPC_Send(hdrCmdId, data, dataSize)
        if retVal != BCM_ERR_OK:
            self.logging("IMGH Send Failed with error: {}".format(retVal))
        return retVal

    def send_image_data_v1(self, aImgReq):
        if self.fileOffset + RPC_STREAMDATA_PAYLOAD_SIZE >= self.imageSize:
            length = self.imageSize - self.fileOffset
            self.lastPacket = True
        else:
            length = RPC_STREAMDATA_PAYLOAD_SIZE
        data_to_send = [data for data in self.read_bin(self.fileOffset, length)]
        data_to_send = self.update_list_8bit_to_32bit(data_to_send)
        dataSize = 4 * len(data_to_send)

        if self.fileOffset == 0:
            self.dwnldSTime = time.perf_counter_ns()
            self.logging("Sending Image Data...")

        retVal = HIPC_Send(RPC_CMDIDVAL_DWNLD_IMG_V1, data_to_send, dataSize)
        if retVal == BCM_ERR_OK:
            self.fileOffset  = self.fileOffset + RPC_STREAMDATA_PAYLOAD_SIZE
            percent = (self.fileOffset * 100 // self.imageSize)
            print("Data Send: {}%".format(percent))
        else:
            self.logging("Failed to send IMG Data, err: {}".format(retVal))

        self._print_download_time()
        return retVal

    def send_image_data_v2(self, aImgInfo):
        if self.fileOffset + RPC_STREAMDATA_PAYLOAD_SIZE >= self.imageSize:
            length = self.imageSize - self.fileOffset
            self.lastPacket = True
        else:
            length = RPC_STREAMDATA_PAYLOAD_SIZE
        payload_to_send = [data for data in self.read_bin(self.fileOffset, length)]
        payload_to_send = self.update_list_8bit_to_32bit(payload_to_send)
        payload_size    = 4 * len(payload_to_send)
        dlImg = RPC_DwnldImageType()
        dlImg.magicNum      = aImgInfo.magicNum
        dlImg.pid           = aImgInfo.pid
        dlImg.rsv1          = 0
        dlImg.imgID         = aImgInfo.imgID
        dlImg.offset        = self.fileOffset
        dlImg.targetStrmHdl = aImgInfo.targetStrmHdl
        dlImg.hostStrmHdl   = aImgInfo.hostStrmHdl
        dlImg.len           = payload_size
        dlImg.response      = BCM_ERR_OK
        dlImg.rsv2          = 0
        dlImg.imgData       = payload_to_send
        # dlImg.print("Sending Data to the target")

        if self.fileOffset == 0:
            self.dwnldSTime = time.perf_counter_ns()

        data = dlImg.getList()
        dataSize = 4 * len(data)
        retVal = HIPC_Send(RPC_CMDIDVAL_DWNLD_IMG_V2, data, dataSize)
        if retVal == BCM_ERR_OK:
            self.fileOffset += payload_size
            percent = (self.fileOffset * 100 // self.imageSize)
            self.logging("Data Send: {}%".format(percent))
        else:
            self.logging("Failed to send IMG Data, err: {}".format(retVal))

        self._print_download_time()
        return retVal

    def RPC_HIPC_Recv(self):
        cmd = []
        msg = []
        lst = []
        retCmd = None
        retVal = HIPC_Recv(cmd, msg, lst)
        if retVal == BCM_ERR_NOT_FOUND or len(cmd) < 1 or retVal == BCM_ERR_DISCONNECT:
            pass
        elif retVal != BCM_ERR_OK:
            self._error("Error in RPC_HIPC_Recv: {}".format(retVal))
        else:
            retCmd = cmd[0]
            if BCM_ASYNCID(BCM_GROUPID_IMGL, BCM_RSV_ID, SYSTEM_ASYNCID_DEBUG) == retCmd and msg[0] == 0x5250434d:
                self.print_execution_time(msg)
        return retCmd, msg

    def print_execution_time(self, aBuffer):
        errIndex = 0
        payload = aBuffer[12:]
        targetBootStates = ["NONE", "ROM", "BL", "FW"]
        while (errIndex*16 < len(payload)):
            dbgMsg = payload[errIndex*16:(errIndex+1)*16]
            comp     =  dbgMsg[1] & 0x0000ffff
            bootMode = (dbgMsg[1] & 0x00ff0000) >> 16
            instance = (dbgMsg[1] & 0xff000000) >> 24
            timeMS   =  dbgMsg[3] << 32 | dbgMsg[2]
            apiId    =  dbgMsg[4] & 0xffff
            line     = (dbgMsg[4] & 0xffff0000) >> 16
            state    =  dbgMsg[5]
            error    =  dbgMsg[6]
            custom   =  dbgMsg[7:11]
            devInfo  =  dbgMsg[11]
            errIndex += 1;
            if bootMode in [1, 2, 3]:
                self.logging("[{:.3f}] [{}] [dev:0x{:03x}] [comp:0x{:04x}] [inst:0x{:02x}] [id:0x{:04x}] [line:{:04x}] [state:0x{:02x}] [error:0x{:02x}] [custom:0x{:08x},0x{:08x},0x{:08x},0x{:08x}]".format( \
                        timeMS/1000, targetBootStates[bootMode], devInfo, comp, instance, apiId, line, state, error, custom[0], custom[1], custom[2], custom[3]))

    def sendInvalCmd(self):
        invalCmd = [
            0x01000005,
            0x02000020,
            0x03000040,
            0x04000050,
            0x05000060
        ]
        if ((self.rcvCount % 5) == 0 and (self.rcvCount < 50)):
            data = [ ]
            for i in range(self.rcvCount + 1):
                data.append(i ^ 0xFF)
            dataSize = 4 * len(data)
            cmdIndex = (self.rcvCount//5)%len(invalCmd)
            retVal = HIPC_Send(invalCmd[cmdIndex], data, dataSize)
            if retVal == BCM_ERR_OK:
                while True:
                    cmd = []
                    msg = []
                    lst = []
                    retVal = HIPC_Recv(cmd, msg, lst)
                    if (retVal == 0) and ((cmd[0]&BCM_CMD_ASYNC_MASK) == 0):
                        self.logging("Invalid Command Sent 0x{:08X}".format(cmd[0]))
                        break
            else:
                self._error("Invalid command 0x{:08X} send failed : {}".format(invalCmd[cmdIndex], retVal))
        self.rcvCount += 1

    def xfer_bl(self):
        self.reset_time()
        exec_start = time.time()
        while self.zipFile != None or self.exec_time != None:

            cmdVal, msg = self.RPC_HIPC_Recv()

            if self.TEST_MODE and not (cmdVal is None):
                if ((BCM_CMD_ASYNC_MASK&cmdVal) == 0):
                    self.sendInvalCmd()

            if self.zipFile != None:

                # Read Image fetch request from the taregt
                if self.status == RPC_STATUS_IMAGE_REQ_LISTENER:

                    if (BCM_ASYNCID(BCM_GROUPID_IMGL, BCM_RSV_ID,RPC_CMDIDVAL_IMAGE_FETCH_V1) == cmdVal):
                        # Image fetch request V1
                        imgReq = RPC_ImgReqType()
                        imgReq.update(msg)
                        imgReq.print(self.file_xferd)
                        # Send Image Header V1
                        retVal = self.send_image_header_v1(imgReq)
                        if retVal == BCM_ERR_OK:
                            self.update_status(RPC_STATUS_IMAGE_HDR_SEND)
                        else:
                            self.restart_state_machine()

                    elif ((BCM_ASYNCID(BCM_GROUPID_IMGL, BCM_RSV_ID, RPC_CMDIDVAL_IMAGE_FETCH_V2) == cmdVal)     \
                        or (BCM_ASYNCID(BCM_GROUPID_IMGL, BCM_RSV_ID, RPC_CMDIDVAL_IMAGE_PART_FETCH_V2) == cmdVal)):
                        # Image fetch request V2
                        imgReq = RPC_ImgReqV2Type()
                        imgReq.update(msg)
                        imgReq.print(self.file_xferd)
                        # Send Image Header V2
                        retVal = self.send_image_header_v2(imgReq)
                        if retVal == BCM_ERR_OK:
                            self.update_status(RPC_STATUS_IMAGE_HDR_SEND)
                        else:
                            self.restart_state_machine()

                # Read Image Header Ack from the target
                elif self.status == RPC_STATUS_IMAGE_HDR_SEND:

                    if (BCM_CMDID(BCM_GROUPID_IMGL, BCM_RSV_ID, RPC_CMDIDVAL_DWNLD_IMG_HDR_V1) == cmdVal):
                        # Img Hdr Ack V1
                        hdrAck = RPC_DwnldHdrType()
                        self.logging("IMGH Ack Received")
                        # Send Image Data V1
                        retVal = self.send_image_data_v1(imgReq)
                        if retVal == BCM_ERR_OK:
                            self.update_status(RPC_STATUS_IMAGE_DATA_SEND)
                        else:
                            self.restart_state_machine()

                    elif (BCM_CMDID(BCM_GROUPID_IMGL, BCM_RSV_ID, RPC_CMDIDVAL_DWNLD_IMG_HDR_V2) == cmdVal):
                        # Img Hdr Ack V2
                        hdrAck = RPC_DwnldHdrV2Type()
                        hdrAck.update(msg)
                        hdrAck.print("Received Message from the target")
                        if hdrAck.response != BCM_ERR_OK:
                            self.logging("Invalid Header Response from the target: {}".format(hdrAck.response))
                        else:
                            # Send Image Data V2
                            retVal = self.send_image_data_v2(hdrAck)
                            if retVal == BCM_ERR_OK:
                                self.update_status(RPC_STATUS_IMAGE_DATA_SEND)
                            else:
                                self.restart_state_machine()

                # Read Image Data Ack
                elif self.status == RPC_STATUS_IMAGE_DATA_SEND:

                    if (BCM_CMDID(BCM_GROUPID_IMGL, BCM_RSV_ID, RPC_CMDIDVAL_DWNLD_IMG_V1) == cmdVal):
                        if len(msg) > 0 or msg[0] == 0:
                            if self.lastPacket == True:
                                self.update_status(RPC_STATUS_IMAGE_DATA_XFER_DONE)
                                self.logging("File transfer done.")
                            else:
                                # Send Image Data V1
                                retVal = self.send_image_data_v1(imgReq)
                                if retVal == BCM_ERR_OK:
                                    self.update_status(RPC_STATUS_IMAGE_DATA_SEND)
                                else:
                                    self.restart_state_machine()

                    elif (BCM_CMDID(BCM_GROUPID_IMGL, BCM_RSV_ID, RPC_CMDIDVAL_DWNLD_IMG_V2) == cmdVal):
                        # Img Data Ack
                        imgAck = RPC_DwnldImageType()
                        imgAck.update(msg)
                        # imgAck.print("Received Data Ack from the target")
                        if imgAck.response == BCM_ERR_OK:
                            if self.lastPacket == True:
                                self.update_status(RPC_STATUS_IMAGE_DATA_XFER_DONE)
                                self.logging("File transfer done.")
                            else:
                                # Send Image Data V2
                                retVal = self.send_image_data_v2(hdrAck)
                                if retVal == BCM_ERR_OK:
                                    self.update_status(RPC_STATUS_IMAGE_DATA_SEND)
                                else:
                                    self.restart_state_machine()

                if self.status == RPC_STATUS_IMAGE_DATA_XFER_DONE:
                    if self.exec_time != None and (time.time() - exec_start) < self.exec_time:
                        self.reset_rpc(True)
                    else:
                        break

                if self.curr_time() > self.time_out and self.loop_count < self.RPC_RETRY_VALUE:
                    self.restart_state_machine()

                if self.loop_count == self.RPC_RETRY_VALUE:
                    if self.exec_time != None and (time.time() - exec_start) < self.exec_time:
                        self.reset_rpc(self.file_xferd)
                    else:
                        if self.status == RPC_STATUS_IMAGE_REQ_LISTENER:
                            self._log("Retry limit exhausted.")
                            break
            else:
                if self.exec_time < (time.time() - exec_start):
                    break

    def exit(self):
        if self.folder != None:
            shutil.rmtree(self.folder)


def XFER_Usage():
    print("""
    USAGE: load_n_execute.py
        [-h, --help]        Display this help message
         -c, --chip         Chip family
         -d, --debugger     0 = Segger | 1 = Lauterbach
         -f, --file         zip File
         -o, --out          Give a text file name for logging                   [OPTIONAL]
         -m, --mcm          Add "-m" only for MCM board                         [OPTIONAL]
         -p, --print        Add "-p" to show additional logs on the Console     [OPTIONAL]
         -t, --exec_time    Session alive (in s) For ROM execution time log     [OPTIONAL]
         -r, --resp_time    Response Time out (in s)                            [OPTIONAL]
         -b, --rom          ROM binary to be loaded on target                   [OPTIONAL]
         -a, --addr         ROM binary Load address                             [OPTIONAL]""")
    sys.exit(2)

def XFER_Main():
    isMCM   = False
    chip    = None
    ifc     = 0
    zipFile = None
    romBin  = None
    romLoadAddr = 0
    execTime    = None
    respTime    = 3
    logFile     = None
    try:
        opts, args = getopt.getopt(sys.argv[1:], "hmpt:r:c:b:a:c:d:f:o:T",
                                    ["help", "mcm", "print", "exec_time=", "resp_time=", "chip=", "rom", "addr", "debugger=", "file=", "out=", "testmode"])
    except:
        print("Error in parsing arguments")
        XFER_Usage()
    for opt, arg in opts:
        if opt in ("-h", "--help"):
            XFER_Usage()
        elif opt in ("-m", "--mcm"):
            isMCM    = True
        elif opt in ("-p", "--print"):
            RPC_Global.VERBOSE  = True
        elif opt in ("-t", "--exec_time"):
            execTime = int(arg)
        elif opt in ("-r", "--resp_time"):
            respTime = int(arg)
        elif opt in ("-c", "--chip"):
            chip     = arg
        elif opt in ("-d", "--debugger"):
            ifc      = int(arg)
        elif opt in ("-o", "--out"):
            logFile  = os.path.abspath(arg)
        elif opt in ("-f", "--file"):
            zipFile  = os.path.abspath(arg)
        elif opt in ("-b", "--rom"):
            romBin  = os.path.abspath(arg)
        elif opt in ("-a", "--addr"):
            romLoadAddr = int(arg, 16)
        elif opt in ("-T", "--testmode"):
            RPC_Global.TEST_MODE = True
        else:
            print("Unknown argument %s" % opt)
            XFER_Usage()

    if chip == None:
        XFER_Usage()
    if not zipFile:
        print("zip File Not Found! Skipping BL downloading")
    elif not zipFile.endswith((".tar.gz", ".zip")):
        print("Input file should be .tar.gz or .zip")
        XFER_Usage()

    if logFile != None:
        RPC_Global.LOGGING = logFile
        with open(logFile, "w") as fp:
            fp.write("")


    rpc = RPC_Interface(chip, zipFile, execTime, respTime)

    DEBUGGER.mode = ifc
    DEBUGGER.chip = chip
    DEBUGGER.mcm  = isMCM
    DEBUGGER.rpc  = rpc
    DEBUGGER.open()

    DEBUGGER.ifc.halt()
    if (romBin != None):
        print("Loading rom binary: {}, to addr 0x{:08x}".format(romBin, romLoadAddr))
        DEBUGGER.ifc.downloadFile(romBin, romLoadAddr)
        DEBUGGER.ifc.writeCPUReg(15, romLoadAddr)
        if (chip == "bcm8957x"):
            print("reset the IPC target status register")
            DEBUGGER.ifc.writeReg(0x4A800330, 0x0, 2)

    DEBUGGER.ifc.go()

    rpc.xfer_bl()
    rpc.exit()

    DEBUGGER.close()

if __name__ == '__main__':
    XFER_Main()
