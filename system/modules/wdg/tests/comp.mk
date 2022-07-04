#
# Copyright 2021-2022 Broadcom Limited.  All rights reserved.
#
# This program is the proprietary software of Broadcom Limited and/or its
# licensors, and may only be used, duplicated, modified or distributed pursuant
# to the terms and conditions of a separate, written license agreement executed
# between you and Broadcom (an "Authorized License").
#
# Except as set forth in an Authorized License, Broadcom grants no license
# (express or implied), right to use, or waiver of any kind with respect to the
# Software, and Broadcom expressly reserves all rights in and to the Software
# and all intellectual property rights therein.  IF YOU HAVE NO AUTHORIZED
# LICENSE, THEN YOU HAVE NO RIGHT TO USE THIS SOFTWARE IN ANY WAY, AND SHOULD
# IMMEDIATELY NOTIFY BROADCOM AND DISCONTINUE ALL USE OF THE SOFTWARE.
#
#  Except as expressly set forth in the Authorized License,
# 1. This program, including its structure, sequence and organization,
#    constitutes the valuable trade secrets of Broadcom, and you shall use all
#    reasonable efforts to protect the confidentiality thereof, and to use this
#    information only in connection with your use of Broadcom integrated
#    circuit products.
#
# 2. TO THE MAXIMUM EXTENT PERMITTED BY LAW, THE SOFTWARE IS PROVIDED "AS IS"
#    AND WITH ALL FAULTS AND BROADCOM MAKES NO PROMISES, REPRESENTATIONS OR
#    WARRANTIES, EITHER EXPRESS, IMPLIED, STATUTORY, OR OTHERWISE, WITH RESPECT
#    TO THE SOFTWARE.  BROADCOM SPECIFICALLY DISCLAIMS ANY AND ALL IMPLIED
#    WARRANTIES OF TITLE, MERCHANTABILITY, NONINFRINGEMENT, FITNESS FOR A
#    PARTICULAR PURPOSE, LACK OF VIRUSES, ACCURACY OR COMPLETENESS,
#    QUIET ENJOYMENT, QUIET POSSESSION OR CORRESPONDENCE TO DESCRIPTION.
#    YOU ASSUME THE ENTIRE RISK ARISING OUT OF USE OR PERFORMANCE OF THE
#    SOFTWARE.
#
# 3. TO THE MAXIMUM EXTENT PERMITTED BY LAW, IN NO EVENT SHALL BROADCOM OR ITS
#    LICENSORS BE LIABLE FOR (i) CONSEQUENTIAL, INCIDENTAL, SPECIAL, INDIRECT,
#    OR EXEMPLARY DAMAGES WHATSOEVER ARISING OUT OF OR IN ANY WAY RELATING TO
#    YOUR USE OF OR INABILITY TO USE THE SOFTWARE EVEN IF BROADCOM HAS BEEN
#    ADVISED OF THE POSSIBILITY OF SUCH DAMAGES; OR (ii) ANY AMOUNT IN EXCESS
#    OF THE AMOUNT ACTUALLY PAID FOR THE SOFTWARE ITSELF OR U.S. \$1, WHICHEVER
#    IS GREATER. THESE LIMITATIONS SHALL APPLY NOTWITHSTANDING ANY FAILURE OF
#    ESSENTIAL PURPOSE OF ANY LIMITED REMEDY.
#
####################################################################################

BRCM_COMP_APP_CFLAGS += -DENABLE_SHELL_AUTO_TEST_FUNC=1
BRCM_COMP_APP_CFLAGS += -DENABLE_MAC1=1

BRCM_COMP_APP_SRC += qualification/wdg_qt/wdg_test.c
BRCM_COMP_EXPORT_HDR += qualification/wdg_qt/.

ifeq ($(ENABLE_INTEGRATION_TEST_LEGACY), TRUE)
BRCM_COMP_APP_SRC += integration/wdg_test.c

BRCM_COMP_APP_TASK += WDGTestMonitor_IT
WDGTestMonitor_IT.priority = 12
WDGTestMonitor_IT.autostart = false
WDGTestMonitor_IT.stack = 2048
WDGTestMonitor_IT.event += SystemEvent0

BRCM_COMP_APP_CFLAGS += -DENABLE_INTEGRATION_TEST
endif

BRCM_COMP_APP_TASK += WDGTest1
WDGTest1.priority = 10
WDGTest1.autostart = false
WDGTest1.stack = 2048
WDGTest1.event += SystemEvent0
WDGTest1.wds += SE1
SE1.maxAllowedErrors = 10
SE1.maxState = 3
SE1.maxTransitionsPerState = 1
SE1.errorCallback = WDG_QT_ErrCallback

BRCM_COMP_APP_TASK += WDGTest2
WDGTest2.priority = 9
WDGTest2.autostart = false
WDGTest2.stack = 2048
WDGTest2.event += SystemEvent0
WDGTest2.wds += SE2
SE2.maxAllowedErrors = 10
SE2.maxState = 4
SE2.maxTransitionsPerState = 2
SE2.errorCallback = WDG_QT_ErrCallback

BRCM_COMP_APP_TASK += WDGTest3
WDGTest3.priority = 8
WDGTest3.autostart = false
WDGTest3.stack = 2048
WDGTest3.event += SystemEvent0
WDGTest3.wds += SE3
SE3.maxAllowedErrors = 10
SE3.maxState = 1
SE3.maxTransitionsPerState = 1
SE3.errorCallback = WDG_QT_ErrCallback

BRCM_COMP_APP_TASK += WDGTestMonitor
WDGTestMonitor.priority = 11
WDGTestMonitor.autostart = false
WDGTestMonitor.stack = 2048
WDGTestMonitor.event += SystemEvent0

BRCM_COMP_APP_ALARM += WDGTestAlarm
WDGTestAlarm.counter = SystemTimer
WDGTestAlarm.callback = WDGTestAlarm_cb
WDGTestAlarm.declaration = wdg_test.h
WDGTestAlarm.autostart = true
WDGTestAlarm.alarmtime = 4
WDGTestAlarm.cycletime = 4

BRCM_COMP_NAME := wdg_qt
BRCM_COMP_DEPENDS := wdg
BRCM_COMP_TYPE := app
