#
# Copyright 2016-2021 Broadcom Limited.  All rights reserved.
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

BRCM_COMP_NAME := time_test
BRCM_COMP_DEPENDS := time
BRCM_COMP_TYPE := test

BRCM_COMP_APP_SRC += qualification/time_test.c
BRCM_COMP_EXPORT_HDR += qualification/time_test.h
BRCM_COMP_APP_OPT += BCM_TEST_CONFIG_LOADER
BRCM_COMP_APP_CFLAGS += -DENABLE_SHELL_AUTO_TEST_FUNC=1
BRCM_COMP_APP_OPT += ENABLE_TIME_MODULE
#endpoint
BRCM_COMP_APP_OPT += ENABLE_AVT
#switch
BRCM_COMP_APP_OPT += ENABLE_TIMER_SP804

ifeq ($(ENABLE_INTEGRATION_TEST), TRUE)
BRCM_COMP_APP_OPT += ENABLE_TIME_IT
BRCM_COMP_APP_SRC += integration/time_it.c
BRCM_COMP_EXPORT_HDR += integration/time_it.h
endif

BRCM_COMP_APP_EVENT += TriggerEvent0
BRCM_COMP_APP_EVENT += TriggerEvent1

BRCM_COMP_APP_TASK += Task0
Task0.priority = 2
Task0.stack = 2048
Task0.event = TriggerEvent0

BRCM_COMP_APP_TASK += Task1
Task1.priority = 3
Task1.stack = 2048
Task1.event = TriggerEvent1

BRCM_COMP_APP_TASK += Task2
Task2.priority = 3
Task2.stack = 2048
Task2.event = TriggerEvent1

BRCM_COMP_APP_ALARM += TaskSwitch
TaskSwitch.counter := SystemTimer
TaskSwitch.callback := TaskSwitchCb
TaskSwitch.declaration := time_test.h
TaskSwitch.autostart := true
TaskSwitch.alarmtime :=32
TaskSwitch.cycletime := 32

