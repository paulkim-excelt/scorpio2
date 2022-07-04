#
# Copyright 2021 Broadcom Limited.  All rights reserved.
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
#    OF THE AMOUNT ACTUALLY PAID FOR THE SOFTWARE ITSELF OR U.S. $1, WHICHEVER
#    IS GREATER. THESE LIMITATIONS SHALL APPLY NOTWITHSTANDING ANY FAILURE OF
#    ESSENTIAL PURPOSE OF ANY LIMITED REMEDY.
####################################################################################
#
####################################################################################
# File Name:  comp.mk
# Descritpion: This file defines the component name, dependencies and type
####################################################################################

BRCM_COMP_NAME := inet_test
BRCM_COMP_DEPENDS := inet
BRCM_COMP_TYPE := test

ENABLE_ETHXCVRM = FALSE
BRCM_COMP_APP_INC += ../../../../system/service/inc/
BRCM_COMP_APP_INC += qualification/udp/
BRCM_COMP_APP_INC += ../../../drivers/switch/inc/
BRCM_COMP_APP_INC += ../../../drivers/switch/inc/osil/
BRCM_COMP_APP_INC += ../../../drivers/transceiver/inc/
BRCM_COMP_APP_INC += ../../../drivers/transceiver/inc/osil/
BRCM_COMP_APP_INC += ../os/platform/switch/
BRCM_COMP_APP_INC += ../lib/

BRCM_COMP_UAPP_SRC += inet_test.c
BRCM_COMP_UAPP_SRC += qualification/udp/udp_test.c
BRCM_COMP_UAPP_SRC += qualification/udp/inet_cfg.c
BRCM_COMP_UAPP_SRC += qualification/udp/nif_test_cfg.c

# Integration Test
ifeq ($(ENABLE_INTEGRATION_TEST), TRUE)
BRCM_COMP_UAPP_SRC += integration/inet_it.c
BRCM_COMP_UAPP_SRC += integration/dhcp_it.c
BRCM_COMP_APP_CFLAGS += -DENABLE_INET_IT
BRCM_COMP_APP_CFLAGS += -DENABLE_TEST_SVC=1
endif

BRCM_COMP_APP_CFLAGS  += -DENABLE_SHELL_AUTO_TEST_FUNC=1
BRCM_COMP_APP_CFLAGS  += -DINET_TEST=1
BRCM_COMP_APP_OPT     += INET_TEST

ifneq (,$(filter $(CHIP_FAMILY),bcm8956x bcm8957x))
BRCM_COMP_APP_OPT += ENABLE_SYSTEM_SERVICE
BRCM_COMP_APP_CFLAGS += -DSYSTEM_TASK_INET_TEST
endif
BRCM_COMP_APP_OPT += ENABLE_TIME_MODULE

BRCM_COMP_APP_OPT += ENABLE_DHCP_TEST
BRCM_COMP_APP_OPT += BCM_TEST_CONFIG_LOADER
#endpoint
BRCM_COMP_APP_OPT += ENABLE_AVT
#switch
BRCM_COMP_APP_OPT += ENABLE_TIMER_SP804

BRCM_COMP_APP_CFLAGS += -DETHER_PKT_EVENT=SystemEvent0
BRCM_COMP_APP_CFLAGS += -DETHXCVR_LINK_EVENT=SystemEvent0
BRCM_COMP_APP_CFLAGS += -DMDIO_STATE_HANDLER_EVENT=0
BRCM_COMP_APP_CFLAGS += -DETHER_TIMESTAMP_EVENT=0

BRCM_COMP_APP_CFLAGS += -DMDIO_STATE_HANDLER_TASK=Test1Task
BRCM_COMP_APP_CFLAGS += -DETH_IRQ_PROCESS_TASK=Test1Task
BRCM_COMP_APP_CFLAGS += -DINET_EVENT_PROCESS_TASK=Test1Task
BRCM_COMP_APP_CFLAGS += -DETHXCVR_IRQ_PROCESS_TASK=Test1Task

BRCM_COMP_APP_ALARM        += Systick_Alarm
Systick_Alarm.counter      := SystemTimer
Systick_Alarm.callback     := Systick_Callback
Systick_Alarm.declaration  := udp_test.h
Systick_Alarm.autostart    := true
Systick_Alarm.alarmtime    := 1
Systick_Alarm.cycletime    := 1

BRCM_COMP_APP_TASK += Test1Task
Test1Task.priority = 10
Test1Task.stack = 2048
Test1Task.event += SystemEvent0
Test1Task.event += SystemEvent1
Test1Task.event += SystemEvent3
Test1Task.event += SystemEvent4
Test1Task.event += UDP_TxEvent
Test1Task.event += UDP_RxEvent

BRCM_COMP_APP_TASK += Test2Task
Test2Task.priority = 11
Test2Task.stack = 2048
Test2Task.event += SystemEvent0
Test2Task.event += UDP_RxEvent
Test2Task.event += SystemEvent4
Test2Task.event += SystemEvent5
