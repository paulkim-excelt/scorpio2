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

import sys
sys.dont_write_bytecode = True
import os
import shutil
import getopt
import ctypes
import re
import queue as Queue
import time
import psutil
import subprocess
from threading import *
from PyQt5.QtWidgets import *
from PyQt5.QtGui import *
from PyQt5.QtCore import *
from PyQt5 import QtCore, QtGui, QtWidgets
import flasher_api
import logging
from otp import *

FLASHER_LOG_INFO = 1
FLASHER_LOG_DBUG = 2
FLASHER_LOG_WRNG = 3
FLASHER_LOG_EROR = 4

FLASHER_COMMAND_EXIT = -1
FLASHER_COMMAND_SN    = 0 # Input: chip, debugger;                                          # Output: SerialNoList
FLASHER_COMMAND_RESET = 1 # Input: chip, debugger, SN;                                      # Output: Progress
FLASHER_COMMAND_ERASE = 2 # Input: chip, debugger, SN, hwId;                                # Output: Progress
FLASHER_COMMAND_READ  = 3 # Input: chip, debugger, SN, hwId, saveFile, startAddr, endAddr;  # Output: Progress
FLASHER_COMMAND_WRITE = 4 # Input: chip, debugger, SN, hwId, binFile;                       # Output: Progress

# Boards
LYNX    = "bcm8908x"
HYDRA   = "bcm8910x"
LEO     = "bcm8953x"
LEO_SEC = "bcm8955x"
SCORPIO = "bcm8956x"

CHIPS = [LYNX, HYDRA, LEO, LEO_SEC, SCORPIO]

CHIPS_DICT = {}
CHIPS_DICT[LYNX]    = ["Select Version", "a0"]
CHIPS_DICT[HYDRA]   = ["Select Version"]
CHIPS_DICT[LEO]     = ["Select Version", "b1", "c0"]
CHIPS_DICT[LEO_SEC] = ["Select Version", "b1", "c0"]
CHIPS_DICT[SCORPIO] = ["Select Version", "a0", "b0"]

DEBUGGER   = ["Segger", "Lauterbach"]
STYLE      = ["motif", "Windows", "cde", "Plastique", "Cleanlooks", "windowsvista"]


ENVIRONMENT_VARIABLE_T32 = "BRCM_FLASHER_T32_PATH"

T32MARM_APP = "t32marm.exe"

def IsT32Open():
    processList = []
    eProcess = re.compile("(?<=name=').*?(?=',)")
    for strProcess in list(str(process) for process in psutil.process_iter()):
        if eProcess.search(strProcess):
            processList.append(eProcess.search(strProcess).group())
    return T32MARM_APP in processList

def openLauterbach():
    if IsT32Open() == False:
        print("opening TRACE32 PowerView...")
        if sys.platform.startswith('win'):
            if ENVIRONMENT_VARIABLE_T32 in os.environ:
                # Start TRACE32 instance
                process = subprocess.Popen([os.environ[ENVIRONMENT_VARIABLE_T32] + '/bin/windows64/' + T32MARM_APP])
                # Wait until the TRACE32 instance is started
                time.sleep(5)
            else:
                print("Environment variable not found: " + ENVIRONMENT_VARIABLE_T32)
    else:
        print("TRACE32 PowerView is running...")

class FLASH_Cmd:
    def __init__(self, aCmd):
        self.request   = aCmd
    def update(self, **args):
        if self.request >= FLASHER_COMMAND_SN:
            self.chip      = args["chip"]
            self.debugger  = args["debugger"]
            self.trigger   = args["trigger"]
        if self.request >= FLASHER_COMMAND_RESET:
            self.sn        = args["sn"]
        if self.request >= FLASHER_COMMAND_ERASE:
            self.hwId      = args["hwId"]
        if self.request == FLASHER_COMMAND_READ:
            self.saveFile  = args["saveFile"]
            self.startAddr = args["startAddr"]
            self.endAddr   = args["endAddr"]
        elif self.request == FLASHER_COMMAND_WRITE:
            self.binFile = args["binFile"]

class FLASH_Backend(QtCore.QThread):
    def __init__(self):
        super(FLASH_Backend, self).__init__()
        self.backendThread = Thread(None, self)
        self.cmdQueue = Queue.Queue()
    def start(self):
        self.backendThread.start()
    def processRead(self, aObj):
        pass

    def __call__(self):
        while 1:
            obj = self.cmdQueue.get()
            if obj.request == FLASHER_COMMAND_EXIT:
                break


class OTP_Window(QMainWindow):
    def __init__(self, aBackend):
        super(OTP_Window, self).__init__()
        self.imagesPath = "../doc/images/"
        self.backend = aBackend
        QApplication.setStyle(QStyleFactory.create("Cleanlooks"))
        self.setGeometry(500, 100, 600, 700)
        self.setWindowTitle("JLINK FLASHER")
        self.setWindowIcon(QtGui.QIcon(self.imagesPath + "brcm.png"))
        self.debugger = 0
        self.menu()
        self.view()


    def menu(self):
        self.statusBar()
        mainMenu = self.menuBar()
        fileMenu = mainMenu.addMenu("&File")

        fileNewAction = QAction("&New File", self)
        fileNewAction.setShortcut("Ctrl+N")
        fileNewAction.setStatusTip("Open new file")

        fileOpenAction = QAction("&Open File", self)
        fileOpenAction.setShortcut("Ctrl+O")
        fileOpenAction.setStatusTip("Open file")

        fileQuitAction = QAction("&Quit", self)
        fileQuitAction.setShortcut("Ctrl+Q")
        fileQuitAction.setStatusTip("Leave the App")

        fileMenu.addAction(fileNewAction)
        fileMenu.addAction(fileOpenAction)
        fileMenu.addAction(fileQuitAction)

        editMenu = mainMenu.addMenu("&Edit")
        viewMenu = mainMenu.addMenu("&View")
        helpMenu = mainMenu.addMenu("&Help")



    def view(self):

        xValue = 40
        yValue = 0

        #========== Selected Debugger ===============
        titleLabel = QtWidgets.QLabel("Debugger: ",self)
        yValue += 80
        titleLabel.move(xValue, yValue)
        titleLabel.resize(140, 20)

        self.rb1 = QtWidgets.QRadioButton(DEBUGGER[0], self)
        self.rb1.move(xValue + 100, yValue)
        self.rb1.resize(self.rb1.minimumSizeHint())
        self.rb1.setChecked(True)
        self.rb1.toggled.connect(lambda:self.radioButtonClick(self.rb1))

        self.rb2 = QtWidgets.QRadioButton(DEBUGGER[1], self)
        self.rb2.move(xValue + 200, yValue)
        self.rb2.resize(self.rb2.minimumSizeHint())
        self.rb2.toggled.connect(lambda:self.radioButtonClick(self.rb2))


        #========== Drop down ===============

        # Chip
        self.chipCB = QtWidgets.QComboBox(self)
        self.chipCB.addItem('Select Board')
        for item in CHIPS:
            self.chipCB.addItem(item)
        yValue += 80
        self.chipCB.move(xValue, yValue)
        self.chipCB.resize(200, 40)
        self.chipCB.activated[str].connect(self.updateChip)

        # Version
        self.versionCB = QtWidgets.QComboBox(self)
        self.versionCB.addItem('Select Version')
        self.versionCB.move(xValue + 250, yValue)
        self.versionCB.resize(200, 40)
        self.versionCB.activated[str].connect(self.updateVersion)

        #========== OTP Row ===============
        titleLabel = QtWidgets.QLabel("OTP Row: ",self)
        yValue += 100
        titleLabel.move(xValue, yValue)
        titleLabel.resize(140, 20)

        self.spinBox = QtWidgets.QSpinBox(self)
        self.spinBox.setMaximum(800)
        self.spinBox.move(xValue + 100, yValue - 10)
        self.spinBox.resize(100, 42)
        self.spinBox.setValue(0)


        #========== Buttons ===============
        # Erase Button
        self.readButton = QtWidgets.QPushButton(" Read", self)
        self.readButton.clicked.connect(self.readButtonClick)
        self.readButton.resize(200, 50)
        yValue += 70
        self.readButton.move(xValue, yValue)

        font = QtGui.QFont()
        font.setFamily('Courier New')
        font.setFixedPitch(True)
        font.setPointSize(12)
        font.setBold(True)
        self.readdata = QtWidgets.QLineEdit(self)
        self.readdata.move(xValue + 250, yValue)
        self.readdata.resize(200, 50)
        self.readdata.setFont(font)
        self.readdata.setEnabled(False)

        # Flash Button
        self.writeButton = QtWidgets.QPushButton(" Write", self)
        self.writeButton.clicked.connect(self.writeButtonClick)
        self.writeButton.resize(200, 50)
        yValue += 80
        self.writeButton.move(xValue, yValue)

        self.endAddr = QtWidgets.QLineEdit(self)
        self.endAddr.move(xValue + 250, yValue)
        self.endAddr.resize(200, 50)
        self.readdata.setFont(font)

        #========== Event Viewer ===============
        evLabel = QtWidgets.QLabel("Console",self)
        yValue += 100
        evLabel.move(xValue, yValue)
        evLabel.resize(evLabel.minimumSizeHint())
        self.fileListWindow = QtWidgets.QListWidget(self)
        yValue += 30
        self.fileListWindow.move(xValue,yValue)
        self.fileListWindow.resize(500, 100)
        self.fileListWindow.setFont(QtGui.QFont("Courier", 9))

    def radioButtonClick(self, aRadioButton):
        if aRadioButton.isChecked() == True:
            self.debugger = DEBUGGER.index(aRadioButton.text())
            if self.debugger == LAUTERBACH:
                openLauterbach()


    def updateChip(self, aChip):
        chip = str(aChip)
        OTP_Args.CHIP = chip
        self.versionCB.clear()
        self.versionCB.setEnabled(False)
        for each in CHIPS_DICT[chip]:
            self.versionCB.addItem(each)
        if len(CHIPS_DICT[chip]) > 1:
            self.versionCB.setEnabled(True)

    def updateVersion(self, aVersion):
        version = str(aVersion)
        OTP_Args.VERSION = version

    def readButtonClick(self):
        action = []
        rdData = []
        action.append("Read Button clicked")

        otp_row = self.spinBox.value()

        debugger = OTP_Debugger(OTP_Args.CHIP, self.debugger, False, None)

        ret = OTP_ReadTarget(OTP_HW_ID_0, otp_row, rdData, debugger)
        if ret == 0 and len(rdData) > 0:
            result = str(hex(int(rdData[0])))
            self.readdata.setText(result)
            action.append("OTP_Read: " + str(result))
        else:
            action.append("OTP_Init failed")

        self.fileListWindow.clear()
        self.fileListWindow.addItems(action)
        debugger.close()

    def writeButtonClick(self):
        print("Write clicked")

    def closeEvent(self, aEvent):
        choice = QtWidgets.QMessageBox.question(self, "Exit",
        "Are you sure you want to leave?", QtWidgets.QMessageBox.Yes | QtWidgets.QMessageBox.No)
        if choice == QtWidgets.QMessageBox.Yes:
            cmd = FLASH_Cmd(FLASHER_COMMAND_EXIT)
            self.backend.cmdQueue.put(cmd)
            print ("Good Bye!!")
            aEvent.accept()
        else:
            aEvent.ignore()

def GUI_Main():
    app = QApplication(sys.argv)
    backend = FLASH_Backend()
    GUI = OTP_Window(backend)
    GUI.show()
    backend.start()
    sys.exit(app.exec_())



if __name__ == '__main__':
    GUI_Main()