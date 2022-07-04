#!/usr/bin/python2
#
#
# $Id$
# Copyright: Copyright 2017-2019 Broadcom Limited.
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

import os
import sys
import shutil
import glob


class RomImgCreator:

    def __init__(self, repoDir):
        self.repoDir = os.path.abspath(repoDir)
        self.makeCmd = 'make family=bcm8957x rom'
        self.romOutDir = os.path.join(repoDir, 'out/rom/bcm8957x')
        self.relDir = os.path.join(repoDir, 'out/release')
        self.testApps = ['tbl', 'tbl_full', 'tbl_ov']
        self.itApps = ['ptu_it', 'circqu_it', 'eth_it', 'mdio_it', 'inet_it', 'xcvr_it', 'ipc_it', 'nif_it',
                       'dhcp_it', 'switch_it', 'tftp_it', 'rpc_it', 'tc10_it', 'loader_it', 'flash_loader_it',
                       'tftp_loader_it', 'ipc_loader_it', 'mcu_it', 'timer_it', 'pinmux_it', 'gpio_it', 'wdt_it',
                       'otp_it', 'spum_it', 'secheap_it', 'secutils_it']

    @staticmethod
    def packInt(value, size):
        buffer = []
        for _ in range(size):
            buffer.append(value & 0xFF)
            value >>= 8
        return bytearray(buffer)

    @staticmethod
    def updateImageFile(inFileName, outFileName, offset, size, value):
        print('Creating File : {}'.format(outFileName))
        if inFileName.endswith('.hex'):
            inFile = open(inFileName, "r")
            outFile = open(outFileName, "w")
            count = 0
            for line in inFile:
                if count == offset:
                    if size == 4:
                        outFile.write('{:08X}\n'.format(value))
                    else:
                        outFile.write('{:02X}\n'.format(value))
                else:
                    outFile.write(line)
                count += 1
        else:
            inFile = open(inFileName, "rb")
            outFile = open(outFileName, "wb")
            buffer = inFile.read(offset)
            outFile.write(bytearray(buffer))
            buffer = inFile.read(size)
            buffer = RomImgCreator.packInt(value, size)
            outFile.write(buffer) 
            buffer = inFile.read()
            outFile.write(buffer)
        inFile.close()
        outFile.close()

    def copyRomFiles(self, coverage=False):

        if os.path.exists(self.relDir):
            shutil.rmtree(romImg.relDir)
        os.makedirs(self.relDir)
        
        inFileList = []
        inFileList.append('{}/bcm8957x_rom_a0.rom_0.hex'.format(self.romOutDir))
        inFileList.append('{}/bcm8957x_rom_a0.rom_1.hex'.format(self.romOutDir))

        inFileList.append('{}/a0/{}/bcm8957x_rom_{}_a0.img'.format(self.romOutDir, 'tbl', 'tbl'))
        inFileList.append('{}/a0/{}/bcm8957x_rom_{}_a0_encrypt.img'.format(self.romOutDir, 'tbl', 'tbl'))
        inFileList.append('{}/a0/{}/bcm8957x_rom_{}_a0_encrypt_flash.bin_0.hex'.format(self.romOutDir, 'tbl', 'tbl'))
        inFileList.append('{}/a0/{}/bcm8957x_rom_{}_a0_signed.raw'.format(self.romOutDir, 'tbl', 'tbl'))
        inFileList.append('{}/a0/{}/bcm8957x_rom_{}_a0_encrypt.raw'.format(self.romOutDir, 'tbl', 'tbl'))

        for inFile in inFileList:
            print('Copying : {}'.format(inFile))
            shutil.copy(inFile, self.relDir)

    def checkFiles(self):
        fullSizeBin = '{}/a0/{}/bcm8957x_rom_{}_a0_signed.raw'.format(self.romOutDir, 'tbl_full', 'tbl_full')
        actSize = os.path.getsize(fullSizeBin)
        if actSize != 128 * 1024:
            print("------------------------------------------------------------")
            print("Incorrect file size for full size binary {}/{}".format(actSize, 128*1024))
            print("------------------------------------------------------------")
        fullSizeBin = '{}/a0/{}/bcm8957x_rom_{}_a0_signed.raw'.format(self.romOutDir, 'tbl_ov', 'tbl_ov')
        actSize = os.path.getsize(fullSizeBin)
        if actSize <= 128 * 1024:
            print("------------------------------------------------------------")
            print("Incorrect file size for over size binary {}/{}".format(actSize, 128*1024))
            print("------------------------------------------------------------")

    def copyOutFiles(self):
        defFlashImage = '{}/a0/{}/bcm8957x_rom_{}_a0_flash.bin_0.hex'.format(self.romOutDir, 'tbl', 'tbl')
        fullSizeImage = '{}/a0/{}/bcm8957x_rom_{}_a0_flash.bin_0.hex'.format(self.romOutDir, 'tbl_full', 'tbl_full')
        ovSizeImage   = '{}/a0/{}/bcm8957x_rom_{}_a0_flash.bin_0.hex'.format(self.romOutDir, 'tbl_ov', 'tbl_ov')

        flashTblImg   = '{}/bcm8957x_rom_{}_a0_flash.bin_0.hex'.format(self.relDir, 'tbl')
        ipcTblImg     = '{}/bcm8957x_rom_{}_a0_flash.bin_0.hex'.format(self.relDir, 'tbl_ipc')
        tftpTblImg    = '{}/bcm8957x_rom_{}_a0_flash.bin_0.hex'.format(self.relDir, 'tbl_tftp')
        rdumpTblImg   = '{}/bcm8957x_rom_{}_a0_flash.bin_0.hex'.format(self.relDir, 'tbl_rdump')
        fullTblImg    = '{}/bcm8957x_rom_{}_a0_flash.bin_0.hex'.format(self.relDir, 'tbl_full')
        ovTblImg      = '{}/bcm8957x_rom_{}_a0_flash.bin_0.hex'.format(self.relDir, 'tbl_ov')

        self.updateImageFile(defFlashImage, flashTblImg, 0x200B, 1, 0x00)
        self.updateImageFile(defFlashImage, ipcTblImg,   0x200B, 1, 0x10)
        self.updateImageFile(defFlashImage, tftpTblImg,  0x200B, 1, 0x20)
        self.updateImageFile(defFlashImage, rdumpTblImg, 0x200B, 1, 0x30)
        self.updateImageFile(fullSizeImage, fullTblImg,  0x200B, 1, 0x50)
        self.updateImageFile(ovSizeImage,   ovTblImg,    0x200B, 1, 0xF0)

        defFlashImage = '{}/a0/{}/bcm8957x_rom_{}_a0.img'.format(self.romOutDir, 'tbl', 'tbl')
        fullSizeImage = '{}/a0/{}/bcm8957x_rom_{}_a0.img'.format(self.romOutDir, 'tbl_full', 'tbl_full')
        ovSizeImage   = '{}/a0/{}/bcm8957x_rom_{}_a0.img'.format(self.romOutDir, 'tbl_ov', 'tbl_ov')

        flashTblImg   = '{}/bcm8957x_rom_{}_a0.img'.format(self.relDir, 'tbl')
        ipcTblImg     = '{}/bcm8957x_rom_{}_a0.img'.format(self.relDir, 'tbl_ipc')
        tftpTblImg    = '{}/bcm8957x_rom_{}_a0.img'.format(self.relDir, 'tbl_tftp')
        rdumpTblImg   = '{}/bcm8957x_rom_{}_a0.img'.format(self.relDir, 'tbl_rdump')
        fullTblImg    = '{}/bcm8957x_rom_{}_a0.img'.format(self.relDir, 'tbl_full')
        ovTblImg      = '{}/bcm8957x_rom_{}_a0.img'.format(self.relDir, 'tbl_ov')

        self.updateImageFile(defFlashImage, flashTblImg, 0x101F,1, 0x00)
        self.updateImageFile(defFlashImage, ipcTblImg,   0x101F,1, 0x10)
        self.updateImageFile(defFlashImage, tftpTblImg,  0x101F,1, 0x20)
        self.updateImageFile(defFlashImage, rdumpTblImg, 0x101F,1, 0x30)
        self.updateImageFile(fullSizeImage, fullTblImg,  0x101F,1, 0x50)
        self.updateImageFile(ovSizeImage,   ovTblImg,    0x101F,1, 0xF0)

        defFlashImage = '{}/a0/{}/bcm8957x_rom_{}_a0_signed.raw'.format(self.romOutDir, 'tbl', 'tbl')
        fullSizeImage = '{}/a0/{}/bcm8957x_rom_{}_a0_signed.raw'.format(self.romOutDir, 'tbl_full', 'tbl_full')
        ovSizeImage   = '{}/a0/{}/bcm8957x_rom_{}_a0_signed.raw'.format(self.romOutDir, 'tbl_ov', 'tbl_ov')

        flashTblImg   = '{}/bcm8957x_rom_{}_a0_signed.raw'.format(self.relDir, 'tbl')
        ipcTblImg     = '{}/bcm8957x_rom_{}_a0_signed.raw'.format(self.relDir, 'tbl_ipc')
        tftpTblImg    = '{}/bcm8957x_rom_{}_a0_signed.raw'.format(self.relDir, 'tbl_tftp')
        rdumpTblImg   = '{}/bcm8957x_rom_{}_a0_signed.raw'.format(self.relDir, 'tbl_rdump')
        fullTblImg    = '{}/bcm8957x_rom_{}_a0_signed.raw'.format(self.relDir, 'tbl_full')
        ovTblImg      = '{}/bcm8957x_rom_{}_a0_signed.raw'.format(self.relDir, 'tbl_ov')

        self.updateImageFile(defFlashImage, flashTblImg, 11, 1, 0x00)
        self.updateImageFile(defFlashImage, ipcTblImg,   11, 1, 0x10)
        self.updateImageFile(defFlashImage, tftpTblImg,  11, 1, 0x20)
        self.updateImageFile(defFlashImage, rdumpTblImg, 11, 1, 0x30)
        self.updateImageFile(fullSizeImage, fullTblImg,  11, 1, 0x50)
        self.updateImageFile(ovSizeImage,   ovTblImg,    11, 1, 0xF0)


    def genExceptionTest(self):
        inFileName = os.path.join(self.romOutDir, 'bcm8957x_rom_a0.rom_0.hex')
        outFileName =  os.path.join(self.relDir, 'bcm8957x_rom_a0_exception.rom_0.hex')
        self.updateImageFile(inFileName, outFileName, 9, 4, 0xFFFFFFFF)

    def genCrcTest(self):
        inFileName = '{}/a0/{}/bcm8957x_rom_{}_a0_flash.bin_0.hex'.format(self.romOutDir, 'tbl', 'tbl')
        outFileName = os.path.join(self.relDir, 'bcm8957x_rom_tbl_a0_flash_crc.bin_0.hex')
        self.updateImageFile(inFileName, outFileName, 0x2210, 1, 0xAA)
    
    def genEncryptionTest(self):
        inFileName = '{}/a0/{}/bcm8957x_rom_{}_a0_encrypt_flash.bin_0.hex'.format(self.romOutDir, 'tbl', 'tbl')
        outFileName = os.path.join(self.relDir, 'bcm8957x_rom_tbl_a0_encrypt_flash_err.bin_0.hex')
        self.updateImageFile(inFileName, outFileName, 0x2210, 1, 0x55)

    def genEntryTest(self):
        inFileName = '{}/a0/{}/bcm8957x_rom_{}_a0_flash.bin_0.hex'.format(self.romOutDir, 'tbl', 'tbl')
        outFileName = os.path.join(self.relDir, 'bcm8957x_rom_tbl_a0_flash_ent.bin_0.hex')
        self.updateImageFile(inFileName, outFileName, 0x1022, 1, 0x07)

    def genImghTest(self):
        inFileName = '{}/a0/{}/bcm8957x_rom_{}_a0_flash.bin_0.hex'.format(self.romOutDir, 'tbl', 'tbl')
        outFileName = os.path.join(self.relDir, 'bcm8957x_rom_tbl_a0_flash_imgh.bin_0.hex')
        self.updateImageFile(inFileName, outFileName, 0x1004, 1, 0xAA)

    def genPtTest(self):
        inFileName = '{}/a0/{}/bcm8957x_rom_{}_a0_flash.bin_0.hex'.format(self.romOutDir, 'tbl', 'tbl')
        outFileName = os.path.join(self.relDir, 'bcm8957x_rom_tbl_a0_flash_ptc.bin_0.hex')
        inFile = open(inFileName, "r")
        outFile = open(outFileName, "w")
        count = 0
        for line in inFile:
            if count == 0 or count == 0x108:
                outFile.write('AA\n')
            else:
                outFile.write(line)
            count += 1
        outFile.close() 
        inFile.close()

        inFileName = '{}/a0/{}/bcm8957x_rom_{}_a0_flash.bin_0.hex'.format(self.romOutDir, 'tbl', 'tbl')
        outFileName = os.path.join(self.relDir, 'bcm8957x_rom_tbl_a0_flash_pterr.bin_0.hex')
        inFile = open(inFileName, "r")
        outFile = open(outFileName, "w")
        count = 0
        for line in inFile:
            if count < 0x100 * 16 and (count % 0x100) < 12:
                outFile.write('55\n')
            else:
                outFile.write(line)
            count += 1
        outFile.close() 
        inFile.close()

    def build(self, version='a0', coverage=None):
        print('make clean')
        os.chdir(os.path.join(self.repoDir, 'build'))
        self.run_system_cmd('make clean')
        print_str = 'Building ROM for BCM8957x {}'.format(version)
        make_cmd = '{} version={}'.format(self.makeCmd,version)
        if coverage:
            print_str += ' coverage={}'.format(coverage)
            make_cmd += ' coverage={}'.format(coverage)
        print(print_str)
        self.run_system_cmd(make_cmd)

        for testApp in self.testApps:
            print('Building {} for BCM8957x {}'.format(testApp, version))
            self.run_system_cmd('{} version={} comp={}'.format(self.makeCmd, version, testApp))

        os.chdir(self.repoDir)

    def buildITs(self, version='a0', coverage=1):
        make_cmd = '{} version={}'.format(self.makeCmd, version)
        os.chdir(os.path.join(self.repoDir, 'build'))
        print('make clean')
        self.run_system_cmd('make clean')
        if coverage:
            make_cmd += ' coverage={}'.format(coverage)
        for itApp in self.itApps:
            print('Building {} for BCM8957x {}'.format(itApp, version))
            it_make_cmd = make_cmd + ' comp={}'.format(itApp)
            print(it_make_cmd)
            self.run_system_cmd(it_make_cmd)
        os.chdir(self.repoDir)

    def copy_coverage_group_out(self, group_name):
        groupOutDir = os.path.join(self.repoDir, 'out_{}'.format(group_name))
        if os.path.exists(groupOutDir):
            shutil.rmtree(groupOutDir)
        shutil.copytree(self.romOutDir, groupOutDir)

    def copy_bin_elf_map_files(self):
       for inFile in ['{}/bcm8957x_rom_a0.bin'.format(self.romOutDir),
                      '{}/bcm8957x_rom_a0.elf'.format(self.romOutDir),
                      '{}/bcm8957x_rom_a0.map'.format(self.romOutDir)]:
            print('Copying : {}'.format(inFile))
            shutil.copy(inFile, self.relDir)

    def run_system_cmd(self, cmd):
        return_code = os.system(cmd)
        if return_code != 0:
            raise RuntimeError('{} failed'.format(cmd))


if __name__ == '__main__':
    if len(sys.argv) > 1:
        romImg = RomImgCreator(sys.argv[1])
        if len(sys.argv) == 4 and sys.argv[3] == '-cov':
            romImg.testApps = []
            for group in ['grp1', 'grp2', 'grp3']:
                romImg.build(coverage=group)
                romImg.copy_coverage_group_out(group)
            romImg.buildITs()
            romImg.copy_coverage_group_out('ITs')
        else:
            if len(sys.argv) <= 2 or sys.argv[2] != '-nb':
                romImg.build()
            romImg.checkFiles()
            romImg.copyRomFiles()
            romImg.copyOutFiles()
            romImg.genExceptionTest()
            romImg.genEncryptionTest()
            romImg.genCrcTest()
            romImg.genEntryTest()
            romImg.genImghTest()
            romImg.genPtTest()
            romImg.copy_bin_elf_map_files()
    else:
        print('Please specify the repo root path')


