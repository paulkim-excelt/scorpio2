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

##  @defgroup grp_one_ui_layout One UI Layout
#   @ingroup grp_one_ui
#
#   @addtogroup grp_one_ui_layout
#   @{
#
#   @file one_ui.py
#   @brief Python script for One UI
#   @version 1.0 Changelist1

import os
import sys
sys.dont_write_bytecode = True
from PyQt5 import QtCore, QtGui, QtWidgets
from PyQt5.QtCore import pyqtSignal, pyqtSlot

import cfg_tab
import target_tab


##  @name One UI Architecture IDs
#   @{
#   @brief Architecture IDs for One UI Flasher
#
    ## @brief #one_ui.ONEUI_MainWindow
BRCM_SWARCH_ONEUI_MAIN_WINDOW_CLASS         = 0
    ## @brief #one_ui.ONEUI_Main()
BRCM_SWARCH_ONEUI_MAIN_PROC                 = 1
##  @}


##  @brief Main Class
#
#   class for the One UI layout.
#
#   @trace #BRCM_SWREQ_ONEUI
class ONEUI_MainWindow(QtWidgets.QMainWindow):
    GUI_WINDOW_TITLE            = "One GUI"
    GUI_TAB_CONFIGURATOR        = "Configurator"
    GUI_TAB_TARGET              = "Target"
    GUI_BRCM_LOGO_ICON          = "brcm.png"
    resized = QtCore.pyqtSignal()
    def __init__(self, parent=None):
        super(ONEUI_MainWindow, self).__init__(parent)
        self.chip           = None
        self.chipMode       = None
        self.debugger       = 0
        self.SN             = None
        self.flashMode      = -1
        self.serialNoList   = []
        self.ifcIndex       = 0
        self.isRunning      = False
        self.imagePath      = os.path.join(os.path.dirname(os.path.realpath(__file__)), "../doc/images/")
        self.style          = list(QtWidgets.QStyleFactory.keys())[-1]
        QtWidgets.QApplication.setStyle(self.style)
        self.resized.connect(self.resizeOneUIWindow)

    def _X(self, aWidth):
        return int((aWidth * target_tab.ONEUI_TargetTab.CURRENT_WIDTH) / target_tab.ONEUI_TargetTab.DEFAULT_WIDTH)

    def _Y(self, aHeight):
        return int((aHeight * target_tab.ONEUI_TargetTab.CURRENT_HEIGHT) / target_tab.ONEUI_TargetTab.DEFAULT_HEIGHT)

    def setupUi(self, aApp):
        self.setWindowModality(QtCore.Qt.ApplicationModal)
        sizeObject = QtWidgets.QDesktopWidget().screenGeometry(-1)
        print("Screen size : "  + str(sizeObject.height()) + " x "  + str(sizeObject.width()))

        fontSize = (16 * sizeObject.height() // 1080)
        aApp.setStyleSheet("""
            QWidget {
                font-size: """ + str(fontSize) + """px;
            }
        """)
        aApp.setFont(QtGui.QFont('Verdana', fontSize))

        self.resize(QtWidgets.QDesktopWidget().width(), QtWidgets.QDesktopWidget().height())
        self.setWindowTitle(self.GUI_WINDOW_TITLE)
        self.setWindowIcon(QtGui.QIcon(os.path.join(self.imagePath, self.GUI_BRCM_LOGO_ICON)))
        self.centralwidget = QtWidgets.QWidget(self)
        self.tabWidget = QtWidgets.QTabWidget(self.centralwidget)
        self.tabWidget.setGeometry(QtCore.QRect(10, 10, QtWidgets.QDesktopWidget().width() -20 ,QtWidgets.QDesktopWidget().height()-30))

        # Console tab
        self.terminalWindow = target_tab.ONEUI_TargetTab(self.imagePath)
        self.tabWidget.addTab(self.terminalWindow, self.GUI_TAB_TARGET)

        # Adding Configurator GUI
        self.cfgWindow = cfg_tab.CFG_Mainwindow()
        self.configGui = cfg_tab.CFG_GUI(aApp)
        self.configGui.setupUi(self.cfgWindow)
        self.tabWidget.addTab(self.cfgWindow, self.GUI_TAB_CONFIGURATOR)

        self.tabWidget.setCurrentIndex(0)

        self.setCentralWidget(self.centralwidget)

        # self.showMaximized()
        self.setMinimumSize(600, 400)

    def resizeEvent(self, event):
        self.resized.emit()
        return super(ONEUI_MainWindow, self).resizeEvent(event)

    def resizeOneUIWindow(self):
        target_tab.ONEUI_TargetTab.CURRENT_WIDTH  = self.width()
        target_tab.ONEUI_TargetTab.CURRENT_HEIGHT = self.height()
        self.terminalWindow.updateWindowSize()
        self.configGui.updateWindowSize(self.width(), self.height())

    def closeEvent(self, aEvent):
        self.terminalWindow.closeGUI(aEvent)



##  @brief Main Function
#
#   This function will create the main GUI and the backend thread.
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
#   @trace #BRCM_SWREQ_ONEUI
def ONEUI_Main():
    app = QtWidgets.QApplication(sys.argv)

    mainWindow = ONEUI_MainWindow()
    mainWindow.setupUi(app)
    mainWindow.show()
    sys.exit(app.exec_())

if __name__ == '__main__':
    ONEUI_Main()

## @}