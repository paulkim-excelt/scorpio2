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

##  @defgroup grp_one_ui_target_tab Target Tab
#   @ingroup grp_one_ui
#
#   @addtogroup grp_one_ui_target_tab
#   @{
#
#   @file target_tab.py
#   @brief Python script for Target Tab.
#   @version 1.0 Changelist1

import sys
import os
import re
import logging
import queue as Queue
import psutil
import subprocess
from threading import *
from datetime import datetime
from PyQt5 import QtCore, QtGui, QtWidgets
from PyQt5.QtCore import pyqtSignal, pyqtSlot
from PyQt5.QtWidgets import QApplication, QWidget, QPushButton, QPlainTextEdit, QHBoxLayout, QVBoxLayout
from PyQt5.QtCore import *
from PyQt5.QtGui  import *
from PyQt5.QtWidgets import *
from flasher_api import *

##  @name Target Architecture IDs
#   @{
#   @brief Architecture IDs for One UI Flasher
#
    ## @brief #target_tab.ONEUI_TERMINAL_COMMAND_TIME()
BRCM_SWARCH_ONEUI_TERMINAL_COMMAND_GLOBAL   = 0
    ## @brief #target_tab.ONEUI_COMMAND_EXIT()
BRCM_SWARCH_ONEUI_COMMAND_GLOBAL            = 1
    ## @brief #target_tab.ONEUI_CHIP_BCM8908X()
BRCM_SWARCH_ONEUI_CHIP_GLOBAL               = 2
    ## @brief #target_tab.ONEUI_DROPDOWN_ITEMS_CHIPS()
BRCM_SWARCH_ONEUI_DROPDOWN_ITEMS_GLOBAL     = 3
    ## @brief #target_tab.ONEUI_Cmd
BRCM_SWARCH_ONEUI_COMAND_CLASS              = 4
    ## @brief #target_tab.ONEUI_Backend
BRCM_SWARCH_ONEUI_BACKEND_CLASS             = 5
    ## @brief #target_tab.ONEUI_Console
BRCM_SWARCH_ONEUI_CONSOLE_CLASS             = 6
    ## @brief #target_tab.ONEUI_TargetTab
BRCM_SWARCH_ONEUI_TARGET_TAB_CLASS          = 7
    ## @brief #target_tab.ONEUI_Terminal
BRCM_SWARCH_ONEUI_TERMINAL_CLASS            = 8
##  @}

##  @brief Terminal Commands
#
#   Additional Available commands in ONE_UI Terminal.
#
#   @trace #BRCM_SWREQ_ONEUI
ONEUI_TERMINAL_COMMAND_TIME    = "time"
ONEUI_TERMINAL_COMMAND_HELP    = "help"
ONEUI_TERMINAL_COMMAND_CLEAR   = "clear"
ONEUI_TERMINAL_COMMAND_HISTORY = "history"

##  @brief Command Ids
#
#   Commands to perform operations in backend thread
#
#   @trace #BRCM_SWREQ_ONEUI
ONEUI_COMMAND_EXIT = -1
ONEUI_COMMAND_SN    = 0
ONEUI_COMMAND_RESET = 1
ONEUI_COMMAND_ERASE = 2
ONEUI_COMMAND_READ  = 3
ONEUI_COMMAND_WRITE = 4

##  @brief Chip Family Macros
#
#   Global macros for each chip family.
#
#   @trace #BRCM_SWREQ_ONEUI
ONEUI_CHIP_BCM8908X = "bcm8908x"
ONEUI_CHIP_BCM8910X = "bcm8910x"
ONEUI_CHIP_BCM8953X = "bcm8953x"
ONEUI_CHIP_BCM8955X = "bcm8955x"
ONEUI_CHIP_BCM8956X = "bcm8956x"
ONEUI_CHIP_BCM8957X = "bcm8957x"

##  @brief Dropdown items
#
#   Macro group of lists containing comboBox items.
#
#   @trace #BRCM_SWREQ_ONEUI
ONEUI_DROPDOWN_ITEMS_CHIPS        = [ONEUI_CHIP_BCM8908X, ONEUI_CHIP_BCM8910X, ONEUI_CHIP_BCM8953X, ONEUI_CHIP_BCM8955X, ONEUI_CHIP_BCM8956X, ONEUI_CHIP_BCM8957X]
ONEUI_DROPDOWN_ITEMS_MODES        = ["Standalone", "Stacked"]
ONEUI_DROPDOWN_ITEMS_FLASH_MODE   = ["Internal Flash", "External Flash"]
ONEUI_DROPDOWN_ITEMS_DEBUGGER     = ["Segger", "Lauterbach"]

##  @brief Commands Class
#
#   Commands to backend class.
#
#   @trace #BRCM_SWREQ_ONEUI
class ONEUI_Cmd:
    def __init__(self, aCmd):
        self.request   = aCmd
    def update(self, **args):
        if self.request >= ONEUI_COMMAND_SN:
            self.chip      = args["chip"]
            self.mode      = args["mode"]
            self.debugger  = args["debugger"]
            self.trigger   = args["trigger"]
        if self.request >= ONEUI_COMMAND_RESET:
            self.sn        = args["sn"]
        if self.request >= ONEUI_COMMAND_ERASE:
            self.hwId      = args["hwId"]
        if self.request == ONEUI_COMMAND_READ:
            self.saveFile  = args["saveFile"]
            self.startAddr = args["startAddr"]
            self.endAddr   = args["endAddr"]
        elif self.request == ONEUI_COMMAND_WRITE:
            self.file      = args["file"]
            self.secure    = args["secure"]

##  @brief Backend Class
#
#   This class will interact with the target and handle all the backend process.
#
#   @trace #BRCM_SWREQ_ONEUI
class ONEUI_Backend(QtCore.QThread):
    def __init__(self):
        super(ONEUI_Backend, self).__init__()
        self.backendThread = Thread(None, self)
        self.cmdQueue = Queue.Queue()
    def start(self):
        self.backendThread.start()
    def processSN(self, aObj):
        retVal = FLASHER_GetTargetSN(aObj.chip, aObj.mode, aObj.debugger, aObj.trigger)
    def processReset(self, aObj):
        retVal = FLASHER_ResetTarget(aObj.chip, aObj.mode, aObj.debugger, aObj.sn, aObj.trigger)
    def processErase(self, aObj):
        retVal = FLASHER_EraseTarget(aObj.chip, aObj.mode, aObj.debugger, aObj.sn, aObj.hwId, aObj.trigger)
        if (retVal != 0):
            print('FLASH Erase failed')
    def processRead(self, aObj):
        retVal = FLASHER_ReadTarget(aObj.chip, aObj.mode, aObj.debugger, aObj.sn, aObj.hwId, aObj.trigger, aObj.saveFile, aObj.startAddr, aObj.endAddr)
        if (retVal != 0):
            print('FLASH Read failed')
    def processFlash(self, aObj):
        retVal = FLASHER_WriteTarget(aObj.chip, aObj.mode, aObj.debugger, aObj.sn, aObj.hwId, aObj.trigger, aObj.file, aObj.secure)
        if (retVal != 0):
            print('FLASH Write failed')

    def __call__(self):
        while 1:
            obj = self.cmdQueue.get()
            if obj.request == ONEUI_COMMAND_EXIT:
                break
            elif obj.request == ONEUI_COMMAND_SN:
                self.processSN(obj)
            elif obj.request == ONEUI_COMMAND_RESET:
                self.processReset(obj)
            elif obj.request == ONEUI_COMMAND_ERASE:
                self.processErase(obj)
            elif obj.request == ONEUI_COMMAND_READ:
                self.processRead(obj)
            elif obj.request == ONEUI_COMMAND_WRITE:
                self.processFlash(obj)

##  @brief Console Class
#
#   class for console log.
#
#   @trace #BRCM_SWREQ_ONEUI
class ONEUI_Console(logging.Handler):
    def __init__(self, parent):
        super(ONEUI_Console, self).__init__()
        self.widget = QtWidgets.QPlainTextEdit(parent)
        self.widget.setReadOnly(True)
        self.widget.setGeometry(10, 35, 610, 285)
        self.widget.setStyleSheet("background-color:white; color: black")
    def emit(self, record):
        msg = self.format(record)
        self.widget.appendPlainText(msg)

##  @brief Target Tab
#
#   class for Target Tab.
#
#   @trace #BRCM_SWREQ_ONEUI
class ONEUI_TargetTab(QWidget):
    ONEUI_LOG_INFO              = 1
    ONEUI_LOG_DBUG              = 2
    ONEUI_LOG_WRNG              = 3
    ONEUI_LOG_EROR              = 4
    GUI_TAB_TARGET_WIDTH        = 1580
    GUI_TAB_TARGET_HEIGHT       = 750
    ERROR_INVALID_FILE          = 1
    ERROR_NO_DEVICE_FOUND       = 2
    progressBarTrigger          = pyqtSignal(int, int)
    serialNoTrigger             = pyqtSignal(list)
    CURRENT_WIDTH               = 1600
    CURRENT_HEIGHT              = 780
    DEFAULT_WIDTH               = 1600
    DEFAULT_HEIGHT              = 780
    def __init__(self, aImagePath):
        super(ONEUI_TargetTab, self).__init__(None)
        # self.setMinimumSize(self.GUI_TAB_TARGET_WIDTH, self.GUI_TAB_TARGET_HEIGHT)
        self.setWindowTitle('Command Line App')
        self.centralwidget = QtWidgets.QWidget(self)
        self.imagePath     = aImagePath
        self.chip            = None
        self.chipMode        = None
        self.debugger        = 0
        self.SN              = None
        self.flashMode       = 0
        self.serialNoList    = []
        self.ifcIndex        = 0
        self.flasherCollapse = False
        self.style           = list(QtWidgets.QStyleFactory.keys())[-1]
        self.backend         = ONEUI_Backend()
        self.backend.start()
        self.progressBarTrigger.connect(self.progressBarUpdate)
        self.serialNoTrigger.connect(self.serialNoUpdate)
        self.consoleHost = QtWidgets.QPlainTextEdit(self.centralwidget)
        self.consoleHost.setGeometry(QtCore.QRect(10, 10, 920, 690))
        QtWidgets.QApplication.setStyle(self.style)
        ONEUI_Terminal(self.consoleHost)
        self.setupUi()

    def log(self, aLogType, aMsg, aConsole=False):
        with open("oneui_log.txt", 'a') as file_object:
            file_object.write(datetime.now().strftime("[%d/%m/%Y %H:%M:%S]") + " " + aMsg + "\n")
        if aConsole:
            if aLogType == self.ONEUI_LOG_INFO:
                logging.info(aMsg)
            elif aLogType == self.ONEUI_LOG_DBUG:
                logging.debug(aMsg)
            elif aLogType == self.ONEUI_LOG_WRNG:
                logging.warning(aMsg)
            else:
                logging.error(aMsg)

    def closeGUI(self, aEvent):
        quitMsg = "Are you sure you want to quit?"
        reply = QtWidgets.QMessageBox.question(self, 'Message',
                         quitMsg, QtWidgets.QMessageBox.Yes, QtWidgets.QMessageBox.No)

        if reply == QtWidgets.QMessageBox.Yes:
            cmd = ONEUI_Cmd(ONEUI_COMMAND_EXIT)
            self.backend.cmdQueue.put(cmd)
            print ("\nGood Bye!!")
            aEvent.accept()
        else:
            aEvent.ignore()

    @pyqtSlot()
    def getSerialNumber(self):
        cmd = ONEUI_Cmd(ONEUI_COMMAND_SN)
        cmd.update(chip=self.chip,
                   mode=self.chipMode,
                   debugger=self.debugger,
                   trigger=self.serialNoTrigger)
        self.backend.cmdQueue.put(cmd)

    ###########################
    ##   Trigger Functions   ##
    ###########################

    def progressBarUpdate(self, aValue, aFlag):
        action = "Reset"
        if aFlag == ONEUI_COMMAND_ERASE:
            action = "Erase"
        elif aFlag == ONEUI_COMMAND_READ:
            action = "Read"
        elif aFlag == ONEUI_COMMAND_WRITE:
            action = "Flash"
        if aValue == -1:
            self.log(self.ONEUI_LOG_INFO, action + " Failed ")
            self.progressBar.setValue(0)
            self.flasherButtonsVisibility(True)
        else:
            self.progressBar.setValue(aValue)
            if aValue == 100:
                self.log(self.ONEUI_LOG_INFO, action + " Done " + str(aValue) + "%")
                self.flasherButtonsVisibility(True)
            elif aFlag == ONEUI_COMMAND_RESET:
                if (aValue == 0):
                    self.log(self.ONEUI_LOG_INFO, action + " Done")
                    self.flasherButtonsVisibility(True)
                else:
                    self.log(self.ONEUI_LOG_INFO, action + " Failed")
            else:
                self.log(self.ONEUI_LOG_INFO, action + " In Progress... " + str(aValue) + "%")

    def serialNoUpdate(self, serialNoList):
        self.interfaceComboBox.clear()
        self.interfaceComboBox.addItem('Select Interface')
        self.serialNoList = [str(sn) for sn in serialNoList]
        for sn in self.serialNoList:
            self.interfaceComboBox.addItem(sn)
        if len(self.serialNoList) == 0:
            self.showErrorWindow(self.ERROR_NO_DEVICE_FOUND)
        elif len(self.serialNoList) == 1:
            self.interfaceComboBox.setCurrentIndex(1)
            self.ifcIndex = 1
            self.SN = serialNoList[0]
        self.updateFlashButtonVisibility()


    ###########################
    ##    Additional APIs    ##
    ###########################

    def showErrorWindow(self, aError):
        msg = QtWidgets.QMessageBox()
        if aError == self.ERROR_INVALID_FILE:
            msg.setIcon(QtWidgets.QMessageBox.Information)
            msg.setText("Please select file for flashing")
            msg.setStandardButtons(QtWidgets.QMessageBox.Ok | QtWidgets.QMessageBox.Cancel)
        elif aError == self.ERROR_NO_DEVICE_FOUND:
            msg.setIcon(QtWidgets.QMessageBox.Warning)
            msg.setText("No Device Found under the selected Debugger!")
            msg.setWindowTitle("No Device Found")
        msg.exec_()

    def setFlashInfo(self, aFlashModeIndex, aMCM=False):
        self.flashModeComboBox.setCurrentIndex(aFlashModeIndex)
        if not aMCM:
            self.chipMode = 0
            self.masterSlaveComboBox.setCurrentIndex(1)
            self.masterSlaveComboBox.setEnabled(False)
        else:
            self.masterSlaveComboBox.setCurrentIndex(0)
            self.masterSlaveComboBox.setEnabled(True)
        self.appComboBox.setEnabled(False)
        if self.repo != None and self.chip != None:
            self.appComboBox.setEnabled(True)

    def updateTargetVisibility(self):
        if self.chipComboBox.currentIndex() > 0 and self.masterSlaveComboBox.currentIndex() > 0 and (self.repo == None or self.appComboBox.currentIndex() > 0):
            self.debuggerComboBox.setEnabled(True)
            self.interfaceComboBox.setEnabled(True)
            self.flashModeComboBox.setEnabled(True if self.chip == ONEUI_CHIP_BCM8910X else False)
        else:
            self.resetTargetBox()

    def updateFlashButtonVisibility(self):
        if self.debuggerComboBox.currentIndex() > 0 and self.interfaceComboBox.currentIndex() > 0:
            if self.chip == ONEUI_CHIP_BCM8910X and self.flashModeComboBox.currentIndex() == 0:
                self.flasherButtonsVisibility(False)
            else:
                self.flasherButtonsVisibility(True)
        else:
            self.flasherButtonsVisibility(False)

    def flasherButtonsVisibility(self, aStatus):
        self.resetButton.setEnabled(aStatus)
        self.eraseButton.setEnabled(aStatus)
        self.flashButton.setEnabled(aStatus)


    ###########################
    ##  Application Buttons  ##
    ###########################
    def onBrowseFileClick(self):
        self.log(self.ONEUI_LOG_INFO, "File Button Clicked")
        self.completeResetGUI()
        file = QtWidgets.QFileDialog.getOpenFileName(self, 'Open File', '', '*_flash.bin *_flash_signed.bin', None, QtWidgets.QFileDialog.DontUseNativeDialog)[0]
        fileName = file.split("/")[-1]
        if (file != ''):
            if file.endswith('.bin'):
                self.fileLabel.setText(fileName)
                self.fileLabel.setToolTip(file)
                self.file = str(file)
                self.log(self.ONEUI_LOG_INFO, "File Selected: " + str(file))
                chipIndex = 1
                for chipFamily in ONEUI_DROPDOWN_ITEMS_CHIPS:
                    if chipFamily[:-1] in fileName:
                        self.chipComboBox.setCurrentIndex(chipIndex); break
                    chipIndex += 1
            else:
                self.showErrorWindow(self.ERROR_INVALID_FILE)

    def onBrowseZipClick(self):
        self.log(self.ONEUI_LOG_INFO, "Zip Button Clicked")
        self.completeResetGUI()
        file = QtWidgets.QFileDialog.getOpenFileName(self, 'Open File', '', '*.zip *.tar.gz', None, QtWidgets.QFileDialog.DontUseNativeDialog)[0]
        fileName = file.split("/")[-1]
        if (file != ''):
            if file.endswith('.tar.gz') or file.endswith('.zip'):
                self.fileLabel.setText(fileName)
                self.fileLabel.setToolTip(file)
                self.file = str(file)
                self.log(self.ONEUI_LOG_INFO, "File Selected: " + str(file))
                chipIndex = 1
                for chipFamily in ONEUI_DROPDOWN_ITEMS_CHIPS:
                    if chipFamily[:-1] in fileName:
                        self.chipComboBox.setCurrentIndex(chipIndex); break
                    chipIndex += 1
            else:
                self.showErrorWindow(self.ERROR_INVALID_FILE)

    def onBrowseRepoClick(self):
        self.log(self.ONEUI_LOG_INFO, "Repo Button Clicked")
        self.completeResetGUI()
        repo = str(QtWidgets.QFileDialog.getExistingDirectory(self, "Select Directory"))
        if (repo != ''):
            self.chipComboBox.setCurrentIndex(0)
            self.repo = str(repo)
            self.fileLabel.setText(self.repo)
            self.fileLabel.setToolTip(self.repo)

    def onRefreshClick(self):
        self.log(self.ONEUI_LOG_INFO, "Refresh Button Clicked")
        self.completeResetGUI()
        self.log(self.ONEUI_LOG_INFO, "Refresh Devices completed")

    ###########################
    ## Application Drop down ##
    ###########################
    def onChipIndexChange(self):
        self.chip = self.chipComboBox.currentText()
        if self.repo:
            self.appComboBox.clear()
            self.appComboBox.addItem('Application')
            if self.repo != None:
                board = self.chipComboBox.currentText()
                appDir = os.path.join(str(self.repo), 'out', 'app')
                if os.path.isdir(appDir):
                    allboards = os.listdir(appDir)
                    selBoards = []
                    for each in allboards:
                        if each.startswith(board[:-1]):
                            selBoards.append(each)
                    allApps = []
                    self.appPathDict = {}
                    for each in selBoards:
                        apps = os.listdir(os.path.join(appDir, each))
                        allApps.extend(apps)
                        for app in apps:
                            self.appPathDict[app] = os.path.join(appDir, each, app)
                    i = 0
                    for each in allApps:
                        appRegex = re.compile('(?P<appName>[A-Za-z0-9_]+).*')
                        appName = appRegex.search(each).group('appName')
                        self.appComboBox.addItem(appName)
                        self.appComboBox.setItemData(i+1, self.appPathDict[each], QtCore.Qt.ToolTipRole)
                        i += 1
        if self.chip == ONEUI_CHIP_BCM8908X:
            self.setFlashInfo(aFlashModeIndex = 2)
        elif self.chip == ONEUI_CHIP_BCM8910X:
            self.setFlashInfo(aFlashModeIndex = 0)
        elif self.chip == ONEUI_CHIP_BCM8953X or self.chip == ONEUI_CHIP_BCM8955X:
            self.setFlashInfo(aFlashModeIndex = 0)
        elif self.chip == ONEUI_CHIP_BCM8956X or self.chip == ONEUI_CHIP_BCM8957X:
            self.setFlashInfo(aFlashModeIndex = 0, aMCM = True)
        else:
            self.chip = None
            self.setFlashInfo(aFlashModeIndex = 0)
        self.updateTargetVisibility()

    def onMasterSlaveIndexChange(self):
        chip_mode = self.masterSlaveComboBox.currentText()
        if chip_mode == ONEUI_DROPDOWN_ITEMS_MODES[0]:
            self.chipMode = 0
        elif chip_mode == ONEUI_DROPDOWN_ITEMS_MODES[1]:
            self.chipMode = 1
        else:
            self.chipMode = None
        self.updateTargetVisibility()

    def onAppComboBoxActivated(self):
        application = self.appComboBox.itemData(self.appComboBox.currentIndex(), QtCore.Qt.ToolTipRole)
        if application != None:
            application = str(application)
            self.file = application
            self.fileLabel.setText(os.path.basename(application))
            self.fileLabel.setToolTip(application)
            self.log(self.ONEUI_LOG_INFO, "File Selected: " + str(self.file))
        else:
            self.file = None
            self.fileLabel.setText("No File Selected")
            self.fileLabel.setToolTip("")
        self.updateTargetVisibility()

    ###########################
    ##   Target Drop down    ##
    ###########################
    def onDebuggerIndexChange(self):
        if self.debuggerComboBox.currentIndex() > 0:
            self.debugger = ONEUI_DROPDOWN_ITEMS_DEBUGGER.index(self.debuggerComboBox.currentText())
            self.interfaceComboBox.setEnabled(True)
            self.getSerialNumber()
        else:
            self.interfaceComboBox.clear()
            self.interfaceComboBox.addItem('Interface')
            self.interfaceComboBox.setEnabled(False)
            self.resetButton.setEnabled(False)

    def onInterfaceIndexChange(self):
        self.updateFlashButtonVisibility()

    def onFlashModeIndexChange(self):
        if self.flashModeComboBox.currentText() == ONEUI_DROPDOWN_ITEMS_FLASH_MODE[1] and self.chip == ONEUI_CHIP_BCM8910X:
            self.flashMode = 1
        else:
            self.flashMode = 0
        self.updateFlashButtonVisibility()


    ###########################
    ##     Flash Buttons     ##
    ###########################
    @pyqtSlot()
    def onResetButtonClick(self):
        self.log(self.ONEUI_LOG_INFO, 'Reset Button Clicked')
        cmd = ONEUI_Cmd(ONEUI_COMMAND_RESET)
        cmd.update(chip=self.chip,
                   mode=self.chipMode,
                   debugger=self.debugger,
                   trigger=self.progressBarTrigger,
                   sn=self.SN)
        self.backend.cmdQueue.put(cmd)

    @pyqtSlot()
    def onEraseButtonClick(self):
        self.log(self.ONEUI_LOG_INFO, 'Erase Button Clicked')
        cmd = ONEUI_Cmd(ONEUI_COMMAND_ERASE)
        cmd.update(chip=self.chip,
                   mode=self.chipMode,
                   debugger=self.debugger,
                   sn=self.SN,
                   hwId=self.flashMode,
                   trigger=self.progressBarTrigger)
        self.backend.cmdQueue.put(cmd)
        self.flasherButtonsVisibility(False);

    @pyqtSlot()
    def onFlashButtonClick(self):
        self.log(self.ONEUI_LOG_INFO, 'Flash Button Clicked')
        flashEnable = True
        if self.chip == ONEUI_CHIP_BCM8910X and self.flashMode == 1:
            isEmpty = FLASHER_ReadPTBL(self.chip, self.chipMode, self.debugger, self.SN, 0)
            if isEmpty == False:
                flashMsg = "Internal flash is not empty. Do you still want to continue?"
                reply = QtWidgets.QMessageBox.question(self, 'Message', flashMsg, QtWidgets.QMessageBox.Yes, QtWidgets.QMessageBox.No)
                flashEnable = True if reply == QtWidgets.QMessageBox.Yes else False

        if self.file == None:
            self.log(self.ONEUI_LOG_INFO, 'Please select file for flashing')
        elif flashEnable == True:
            if (not self.file.endswith(".bin")) and (self.chip in ONEUI_DROPDOWN_ITEMS_CHIPS[3:]):
                secureMsg = "Is board secure enable?"
                reply = QtWidgets.QMessageBox.question(self, 'Message', secureMsg, QtWidgets.QMessageBox.Yes, QtWidgets.QMessageBox.No)
                isSecure = True if reply == QtWidgets.QMessageBox.Yes else False
            else:
                isSecure = None
            cmd = ONEUI_Cmd(ONEUI_COMMAND_WRITE)
            cmd.update(chip=self.chip,
                       mode=self.chipMode,
                       debugger=self.debugger,
                       sn=self.SN,
                       hwId=self.flashMode,
                       trigger=self.progressBarTrigger,
                       file=self.file,
                       secure=isSecure)
            self.backend.cmdQueue.put(cmd)
            self.flasherButtonsVisibility(False)

    ###########################
    ##       GUI Setup       ##
    ###########################
    def _X(self, aWidth):
        return int((aWidth * ONEUI_TargetTab.CURRENT_WIDTH) / ONEUI_TargetTab.DEFAULT_WIDTH)

    def _Y(self, aHeight):
        return int((aHeight * ONEUI_TargetTab.CURRENT_HEIGHT) / ONEUI_TargetTab.DEFAULT_HEIGHT)

    def updateWindowSize(self):
        padding        = 8
        widgetWidth    = 150
        widgetHeight   = 36
        rowA           = 2*padding
        rowB           = rowA + widgetWidth + 2*padding
        rowC           = rowB + widgetWidth + 2*padding
        extraWidth     = 120
        self.top   = 10
        self.right = 940
        self.flasherGroupBox.setGeometry(QtCore.QRect(self._X(self.right), self._Y(self.top), self._X(630), self._Y(340)))
        self.top += 30
        self.browseFileButton.setGeometry(QtCore.QRect(self._X(20), self._Y(self.top), self._X(125), self._Y(widgetHeight)))
        self.browseZipButton.setGeometry(QtCore.QRect(self._X(155), self._Y(self.top), self._X(125), self._Y(widgetHeight)))
        self.browseRepoButton.setGeometry(QtCore.QRect(self._X(290), self._Y(self.top), self._X(125), self._Y(widgetHeight)))
        self.refreshButton.setGeometry(QtCore.QRect(self._X(428), self._Y(self.top), self._X(190), self._Y(widgetHeight)))
        self.top += 50
        self.fileLabel.setGeometry(QtCore.QRect(self._X(20), self._Y(self.top), self._X(381), self._Y(21)))
        self.top += 40
        self.chipComboBox.setGeometry(QtCore.QRect(self._X(rowA), self._Y(self.top), self._X(widgetWidth), self._Y(widgetHeight)))
        self.masterSlaveComboBox.setGeometry(QtCore.QRect(self._X(rowB), self._Y(self.top), self._X(widgetWidth), self._Y(widgetHeight)))
        self.appComboBox.setGeometry(QtCore.QRect(self._X(rowC), self._Y(self.top), self._X(widgetWidth + extraWidth), self._Y(widgetHeight)))
        self.top += 50
        self.debuggerComboBox.setGeometry(QtCore.QRect(self._X(rowA), self._Y(self.top), self._X(widgetWidth), self._Y(widgetHeight)))
        self.interfaceComboBox.setGeometry(QtCore.QRect(self._X(rowB), self._Y(self.top), self._X(widgetWidth), self._Y(widgetHeight)))
        self.flashModeComboBox.setGeometry(QtCore.QRect(self._X(rowC), self._Y(self.top), self._X(widgetWidth + extraWidth), self._Y(widgetHeight)))
        self.flashModeComboBox.setGeometry(QtCore.QRect(self._X(rowC), self._Y(self.top), self._X(widgetWidth + extraWidth), self._Y(widgetHeight)))
        self.top += 50
        self.resetButton.setGeometry(QtCore.QRect(self._X(rowA), self._Y(self.top), self._X(widgetWidth), self._Y(widgetHeight)))
        self.eraseButton.setGeometry(QtCore.QRect(self._X(rowB), self._Y(self.top), self._X(widgetWidth), self._Y(widgetHeight)))
        self.flashButton.setGeometry(QtCore.QRect(self._X(rowC), self._Y(self.top), self._X(widgetWidth + extraWidth), self._Y(widgetHeight)))
        self.top += 55
        # Progress Bar
        progressBarWidth = 3*widgetWidth + 4*padding + extraWidth
        self.progressBar.setGeometry(QtCore.QRect(self._X(20), self._Y(self.top), self._X(progressBarWidth), self._Y(41)))

        self.HideShowButton.setGeometry(QtCore.QRect(self._X(1547), self._Y(349), self._X(22), self._Y(22)))

        self.consoleHost.setGeometry(QtCore.QRect(self._X(10), self._Y(10), self._X(920), self._Y(690)))
        self.logTextBox.widget.setGeometry(self._X(10), self._Y(35), self._X(610), self._Y(285))
        self.consoleGroupBox.setGeometry(QtCore.QRect(self._X(self.right), self._Y(370), self._X(630), self._Y(330)))

    def setupUi(self):
        padding        = 8
        widgetWidth    = 150
        widgetHeight   = 36
        rowA           = 2*padding
        rowB           = rowA + widgetWidth + 2*padding
        rowC           = rowB + widgetWidth + 2*padding
        extraWidth     = 120
        self.top   = 10
        self.right = 940
        # Application GroupBox
        self.flasherGroupBox = QtWidgets.QGroupBox(self.centralwidget)
        self.flasherGroupBox.setGeometry(QtCore.QRect(self.right, self.top, 630, 340))
        self.flasherGroupBox.setTitle("Flasher")
        self.top += 30
        # Button "Browse File"
        self.browseFileButton = QtWidgets.QPushButton(self.flasherGroupBox)
        self.browseFileButton.setGeometry(QtCore.QRect(20, self.top, 125, widgetHeight))
        self.browseFileButton.setText(" Bin File")
        self.browseFileButton.setToolTip("Browse Binary file")
        self.browseFileButton.clicked.connect(self.onBrowseFileClick)
        self.browseFileButton.setIcon(QtGui.QIcon(self.imagePath + "browse_30px.png"))
        # Button "Browse Zip"
        self.browseZipButton = QtWidgets.QPushButton(self.flasherGroupBox)
        self.browseZipButton.setGeometry(QtCore.QRect(155, self.top, 125, widgetHeight))
        self.browseZipButton.setText(" Zip")
        self.browseZipButton.setToolTip("Browse Zip file")
        self.browseZipButton.clicked.connect(self.onBrowseZipClick)
        self.browseZipButton.setIcon(QtGui.QIcon(self.imagePath + "browse_30px.png"))
        # Button "Browse Repo"
        self.browseRepoButton = QtWidgets.QPushButton(self.flasherGroupBox)
        self.browseRepoButton.setGeometry(QtCore.QRect(290, self.top, 125, widgetHeight))
        self.browseRepoButton.setText(" Repo")
        self.browseRepoButton.setToolTip("Browse Repo Directory")
        self.browseRepoButton.clicked.connect(self.onBrowseRepoClick)
        self.browseRepoButton.setIcon(QtGui.QIcon(self.imagePath + "browse_30px.png"))
        # Button "Refresh"
        self.refreshButton = QtWidgets.QPushButton(self.flasherGroupBox)
        self.refreshButton.setGeometry(QtCore.QRect(428, self.top, 190, widgetHeight))
        self.refreshButton.setText("  Refresh")
        self.refreshButton.setToolTip("Click here to Refresh the GUI")
        self.refreshButton.clicked.connect(self.onRefreshClick)
        self.refreshButton.setIcon(QtGui.QIcon(self.imagePath + "refresh_30px.png"))
        self.top += 50
        # Label "File Selected"
        self.fileLabel = QtWidgets.QLabel(self.flasherGroupBox)
        self.fileLabel.setGeometry(QtCore.QRect(20, self.top, 381, 21))
        self.fileLabel.setText("No File Selected")
        self.top += 40
        # ComboBox "Select Chip"
        self.chipComboBox = QtWidgets.QComboBox(self.flasherGroupBox)
        self.chipComboBox.setGeometry(QtCore.QRect(rowA, self.top, widgetWidth, widgetHeight))
        self.chipComboBox.addItem('Chip Family')
        for item in ONEUI_DROPDOWN_ITEMS_CHIPS:
            self.chipComboBox.addItem(item)
        self.chipComboBox.currentIndexChanged.connect(self.onChipIndexChange)
        # ComboBox "Select Mode"
        self.masterSlaveComboBox = QtWidgets.QComboBox(self.flasherGroupBox)
        self.masterSlaveComboBox.setGeometry(QtCore.QRect(rowB, self.top, widgetWidth, widgetHeight))
        self.masterSlaveComboBox.addItem('Board Type')
        for item in ONEUI_DROPDOWN_ITEMS_MODES:
            self.masterSlaveComboBox.addItem(item)
        self.masterSlaveComboBox.currentIndexChanged.connect(self.onMasterSlaveIndexChange)
        # ComboBox "Select Application"
        self.appComboBox = QtWidgets.QComboBox(self.flasherGroupBox)
        self.appComboBox.setGeometry(QtCore.QRect(rowC, self.top, widgetWidth + extraWidth, widgetHeight))
        self.appComboBox.addItem("Application")
        self.appComboBox.activated.connect(self.onAppComboBoxActivated)
        self.top += 50
        # ComboBox "Select Debugger"
        self.debuggerComboBox = QtWidgets.QComboBox(self.flasherGroupBox)
        self.debuggerComboBox.setGeometry(QtCore.QRect(rowA, self.top, widgetWidth, widgetHeight))
        self.debuggerComboBox.addItem("Debugger")
        for item in ONEUI_DROPDOWN_ITEMS_DEBUGGER:
            self.debuggerComboBox.addItem(item)
        self.debuggerComboBox.currentIndexChanged.connect(self.onDebuggerIndexChange)
        # ComboBox "Select Interface"
        self.interfaceComboBox = QtWidgets.QComboBox(self.flasherGroupBox)
        self.interfaceComboBox.setGeometry(QtCore.QRect(rowB, self.top, widgetWidth, widgetHeight))
        self.interfaceComboBox.addItem("Interface")
        self.interfaceComboBox.currentIndexChanged.connect(self.onInterfaceIndexChange)
        # ComboBox "Select Flash Mode"
        self.flashModeComboBox = QtWidgets.QComboBox(self.flasherGroupBox)
        self.flashModeComboBox.setGeometry(QtCore.QRect(rowC, self.top, widgetWidth + extraWidth, widgetHeight))
        self.flashModeComboBox.addItem("Flash Select")
        for item in ONEUI_DROPDOWN_ITEMS_FLASH_MODE:
            self.flashModeComboBox.addItem(item)
        self.flashModeComboBox.currentIndexChanged.connect(self.onFlashModeIndexChange)
        self.flashModeComboBox.activated[str].connect(self.onFlashModeIndexChange)
        self.top += 50
        # Button "Reset"
        self.resetButton = QtWidgets.QPushButton(self.flasherGroupBox)
        self.resetButton.setGeometry(QtCore.QRect(rowA, self.top, widgetWidth, widgetHeight))
        self.resetButton.setText("  Reset")
        self.resetButton.setToolTip("Click here to Reset the target")
        self.resetButton.clicked.connect(self.onResetButtonClick)
        self.resetButton.setIcon(QtGui.QIcon(self.imagePath + "reset_30px.png"))
        # Button "Erase"
        self.eraseButton = QtWidgets.QPushButton(self.flasherGroupBox)
        self.eraseButton.setGeometry(QtCore.QRect(rowB, self.top, widgetWidth, widgetHeight))
        self.eraseButton.setToolTip("Click here to Erase the target")
        self.eraseButton.setText("  Erase")
        self.eraseButton.clicked.connect(self.onEraseButtonClick)
        self.eraseButton.setIcon(QtGui.QIcon(self.imagePath + "erase_30px.png"))
        # Button "Flash"
        self.flashButton = QtWidgets.QPushButton(self.flasherGroupBox)
        self.flashButton.setGeometry(QtCore.QRect(rowC, self.top, widgetWidth + extraWidth, widgetHeight))
        self.flashButton.setToolTip("Click here to Flash App")
        self.flashButton.setText("  Flash")
        self.flashButton.clicked.connect(self.onFlashButtonClick)
        self.flashButton.setIcon(QtGui.QIcon(self.imagePath + "flash_30px.png"))
        self.top += 55
        # Progress Bar
        progressBarWidth = 3*widgetWidth + 4*padding + extraWidth
        self.progressBar = QtWidgets.QProgressBar(self.flasherGroupBox)
        self.progressBar.setGeometry(QtCore.QRect(20, self.top, progressBarWidth, 41))
        self.progressBar.setToolTip("Progress")
        self.progressBar.setProperty("value", 0)
        # Button "Hide/Show"
        self.HideShowButton = QtWidgets.QPushButton(self.centralwidget)
        self.HideShowButton.setGeometry(QtCore.QRect(1547, 349, 22, 22))
        self.HideShowButton.setToolTip("Click here to Hide Flasher Window")
        self.HideShowButton.clicked.connect(self.onExpandCollapseClick)
        self.HideShowButton.setIcon(QtGui.QIcon(self.imagePath + "collapse_16px.png"))
        # Console GroupBox
        self.top += 50
        self.consoleGroupBox = QtWidgets.QGroupBox(self.centralwidget)
        self.consoleGroupBox.setGeometry(QtCore.QRect(self.right, 370, 630, 330))
        self.consoleGroupBox.setTitle("Log Window")
        self.logTextBox = ONEUI_Console(self.consoleGroupBox)
        self.logTextBox.setFormatter(logging.Formatter('%(asctime)s [%(levelname)s] %(message)s'))
        logging.getLogger().addHandler(self.logTextBox)
        logging.getLogger().setLevel(logging.DEBUG)

        self.completeResetGUI()

    def onExpandCollapseClick(self):
        if self.flasherCollapse:
            self.flasherCollapse = False
            self.flasherGroupBox.setGeometry(QtCore.QRect(self._X(940), self._Y(10), self._X(630), self._Y(340)))
            self.HideShowButton.setIcon(QtGui.QIcon(self.imagePath + "collapse_16px.png"))
            self.HideShowButton.setGeometry(QtCore.QRect(self._X(1547), self._Y(349), self._X(22), self._Y(22)))
            self.HideShowButton.setToolTip("Click Here to Collapse Flasher Window")
            self.consoleGroupBox.setGeometry(QtCore.QRect(self._X(940), self._Y(370), self._X(630), self._Y(330)))
            self.logTextBox.widget.setGeometry(self._X(10), self._Y(35), self._X(610), self._Y(285))
        else:
            self.flasherCollapse = True
            self.flasherGroupBox.setGeometry(QtCore.QRect(self._X(940), self._Y(10), self._X(630), self._Y(30)))
            self.HideShowButton.setIcon(QtGui.QIcon(self.imagePath + "expand_16px.png"))
            self.HideShowButton.setGeometry(QtCore.QRect(self._X(1547), self._Y(40), self._X(22), self._Y(22)))
            self.HideShowButton.setToolTip("Click Here to Expand Flasher Window")
            self.consoleGroupBox.setGeometry(QtCore.QRect(self._X(940), self._Y(60), self._X(630), self._Y(645)))
            self.logTextBox.widget.setGeometry(self._X(10), self._Y(35), self._X(610), self._Y(600))

    def completeResetGUI(self):
        self.repo = None
        self.chip = None
        self.debugger = None
        self.file = None
        self.flashMode = 0
        ## Reset Application GroupBox
        self.fileLabel.setText('No File Selected')
        # Row 1 - Widget 1
        self.chipComboBox.setCurrentIndex(0)
        # Row 1 - Widget 2
        self.masterSlaveComboBox.setCurrentIndex(0)
        # Row 1 - Widget 3
        self.appComboBox.clear()
        self.appComboBox.addItem('Application')
        self.appComboBox.setEnabled(False)
        ## Reset Target GroupBox
        self.resetTargetBox()

    def resetTargetBox(self):
        # Row 2
        self.debuggerComboBox.setCurrentIndex(0)
        self.debuggerComboBox.setEnabled(False)
        self.interfaceComboBox.clear()
        self.interfaceComboBox.addItem('Interface')
        self.interfaceComboBox.setCurrentIndex(0)
        self.interfaceComboBox.setEnabled(False)
        self.flashModeComboBox.setCurrentIndex(0)
        self.flashModeComboBox.setEnabled(False)
        # Row 3
        self.resetButton.setEnabled(False)
        self.eraseButton.setEnabled(False)
        self.flashButton.setEnabled(False)
        self.progressBar.setValue(0)

##  @brief Terminal Class
#
#   class for Terminal Window.
#
#   @trace #BRCM_SWREQ_ONEUI
class ONEUI_Terminal:
    COMMAND_LINE_START = ">> "
    def __init__(self, aEditor):
        self.history = []
        self.refresh()
        self.editorOutput = aEditor
        self.editorOutput.keyPressEvent = self.keyPressEvent
        self.editorOutput.setStyleSheet("background-color:black; color: white")
        self.editorOutput.insertPlainText(self.COMMAND_LINE_START)
        self.eConsole = re.compile("(?P<past>(.*\n)?(" + self.COMMAND_LINE_START + "))(?P<cmd>.*)", flags=re.DOTALL)

    def _dir(self, aDir):
        if os.path.isdir(aDir) and (not aDir.endswith(("\\", "/"))):
            aDir += "\\"
        return aDir

    def refresh(self):
        self.last = None
        self.editableLen = 0
        self.historyPointer = -1

    def keyPressEvent(self, e):
        consoleText = self.editorOutput.toPlainText()
        consoleObj = self.eConsole.search(consoleText)
        past = consoleObj.group("past")
        cmd  = consoleObj.group("cmd")

        if (e.key()  == Qt.Key_Return) or (e.key() == Qt.Key_Enter):
            self.Key_Enter_Handler(cmd)
        elif e.key() == Qt.Key_Backspace:
            self.Key_Backspace_Handler(past, cmd)
        elif e.key() == Qt.Key_Tab:
            self.Key_Tab_Handler(past, cmd)
        elif (e.key() == Qt.Key_Up) or (e.key() == Qt.Key_Down):
            self.Key_Up_Down_Handler(past, cmd, e.key())
        else:
            self.editableLen += 1
            self.editorOutput.insertPlainText(e.text())
        self.editorOutput.moveCursor(QtGui.QTextCursor.End)

    def update_current_line(self, aPast, aLine):
        self.editableLen = len(aLine)
        self.editorOutput.clear()
        self.editorOutput.insertPlainText(aPast + aLine)

    def Key_Backspace_Handler(self, aPast, aCmd):
        if self.editableLen > 0:
            self.update_current_line(aPast, aCmd[:-1])

    def Key_Tab_Handler(self, aPast, aCmd):
        preCmd   = " ".join(aCmd.split(" ")[:-1])
        preCmd = preCmd + " " if len(preCmd) > 0 else preCmd
        currPath = self._dir(aCmd.split(" ")[-1])
        currPath = self._dir(os.path.abspath(currPath))
        currPath = currPath + "." if aCmd.endswith(".") else currPath

        dirname = self._dir(os.path.dirname(currPath))
        basename = os.path.basename(currPath)

        suggestion = [f for f in os.listdir(dirname) if (bool(re.match(basename, f, re.I)))]
        if len(suggestion) == 1:
            newPath = os.path.join(dirname, suggestion[0])
            if os.path.isdir(newPath):
                newPath += "\\"
            self.update_current_line(aPast, preCmd + newPath)
        else:
            longbase = os.path.commonprefix(suggestion)
            basename = longbase if len(longbase) > len(basename) else basename
            self.editorOutput.insertPlainText("\n" + str(suggestion) + "\n")
            self.editorOutput.insertPlainText(self.COMMAND_LINE_START + preCmd + dirname + basename)

    def Key_Up_Down_Handler(self, aPast, aCmd, aKey):
        if self.historyPointer == -1:
            self.last = aCmd

        if aKey == Qt.Key_Up:
            if self.historyPointer < len(self.history) - 1:
                self.historyPointer += 1
        else:
            if self.historyPointer >= 0:
                self.historyPointer -= 1
        if self.historyPointer > -1:
            self.update_current_line(aPast, self.history[self.historyPointer])
        else:
            self.update_current_line(aPast, self.last)

    def Key_Enter_Handler(self, aCmd):
        cmd = str(aCmd.strip())

        self.refresh()
        self.history.insert(0, cmd)
        self.history = list(filter(None, self.history))

        if cmd == ONEUI_TERMINAL_COMMAND_CLEAR:
            self.editorOutput.clear()
            self.editorOutput.insertPlainText(self.COMMAND_LINE_START)
        elif cmd:
            try:
                p = os.popen(cmd)
                if p:
                    output = p.read()
                else:
                    output = "Invalid command: " + cmd
            except:
                output = "'{}' is not recognized as command".format(cmd)
                print(output)

            self.editorOutput.insertPlainText("\n" + output + self.COMMAND_LINE_START)
            self.editorOutput.moveCursor(QtGui.QTextCursor.End)
        else:
            self.editorOutput.insertPlainText("\n" + self.COMMAND_LINE_START)

## @}
