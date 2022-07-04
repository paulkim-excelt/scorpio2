#
# Copyright 2022 Broadcom Limited.  All rights reserved.
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

BRCM_COMP_APP_SRC += qualification/code.c
BRCM_COMP_EXPORT_HDR += qualification/base_test.h

BRCM_COMP_APP_CFLAGS += -DBCM_TEST_CONFIG_LOADER

BRCM_COMP_APP_EVENT += TriggerEvent0
BRCM_COMP_APP_EVENT += TriggerEvent1
BRCM_COMP_APP_EVENT += TriggerEvent2
BRCM_COMP_APP_EVENT += TriggerEvent3
BRCM_COMP_APP_EVENT += TriggerEvent4
BRCM_COMP_APP_EVENT += TriggerEvent5

BRCM_COMP_APP_TASK += Task0
Task0.priority = 2
Task0.stack = 1024
Task0.event = TriggerEvent0
ifeq ($(version),fpga)
Task0.autostart = true
endif

BRCM_COMP_APP_TASK += Task1
Task1.priority = 3
Task1.stack = 1024
Task1.event = TriggerEvent1

BRCM_COMP_APP_TASK += Task2
Task2.priority = 4
Task2.stack = 1024
Task2.event = TriggerEvent1
Task2.autostart = true

BRCM_COMP_APP_COUNTER += BaseTestCounter
BaseTestCounter.mincycle := 2
BaseTestCounter.maxallowedvalue := 4
BaseTestCounter.ticksperbase := 1
BaseTestCounter.secondspertick := 1

BRCM_COMP_APP_ALARM += BaseTaskSwitch
BaseTaskSwitch.counter = SystemTimer
BaseTaskSwitch.callback = BaseTaskSwitchCb
BaseTaskSwitch.declaration = base_test.h
BaseTaskSwitch.autostart = true
BaseTaskSwitch.alarmtime = 3
BaseTaskSwitch.cycletime = 3

BRCM_COMP_APP_ALARM += BaseTestCounterDriver
BaseTestCounterDriver.counter = SystemTimer
BaseTestCounterDriver.callback = BaseTestCounterDriverCb
BaseTestCounterDriver.declaration = base_test.h
BaseTestCounterDriver.autostart = true
BaseTestCounterDriver.alarmtime = 2
BaseTestCounterDriver.cycletime = 2

BRCM_COMP_APP_ALARM += BaseTestAlarm
BaseTestAlarm.counter = BaseTestCounter
BaseTestAlarm.callback = BaseTestAlarmCb
BaseTestAlarm.declaration = base_test.h
BaseTestAlarm.autostart = false
BaseTestAlarm.alarmtime = 1
BaseTestAlarm.cycletime = 1

BRCM_COMP_APP_OPT += ENABLE_TIME_MODULE
ifeq ($(CHIP_FAMILY), bcm8958x)
ifeq ($(cpu), m7)
BRCM_COMP_APP_OPT += ENABLE_TIMER_SP804
endif
ifeq ($(cpu), em22fs)
BRCM_COMP_APP_OPT += ENABLE_TIMER_ARC
endif
endif

BRCM_COMP_NAME := base_test
BRCM_COMP_DEPENDS := base module time
BRCM_COMP_TYPE := test

