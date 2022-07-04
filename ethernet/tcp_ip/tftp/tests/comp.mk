#
# Copyright 2017-2021 Broadcom Limited.  All rights reserved.
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

BRCM_COMP_NAME := tftp_test
BRCM_COMP_DEPENDS := tftp
BRCM_COMP_TYPE := test

ENABLE_ETHXCVRM = FALSE

BRCM_COMP_APP_OPT += ENABLE_INET
BRCM_COMP_APP_OPT += TFTP_TEST
BRCM_COMP_APP_OPT += INET_TEST
BRCM_COMP_APP_OPT += ENABLE_DHCP
BRCM_COMP_APP_OPT += ENABLE_TFTP
BRCM_COMP_APP_OPT += ENABLE_TIME_MODULE
BRCM_COMP_APP_OPT += ENABLE_SYSTEM_SERVICE
BRCM_COMP_APP_OPT += BCM_TEST_CONFIG_LOADER

BRCM_COMP_APP_INC += ../../../../system/service/inc/
BRCM_COMP_APP_INC += ../inc/

BRCM_COMP_APP_INC += ../../../../system/service/inc/
BRCM_COMP_APP_INC += ../../../drivers/switch/inc/
BRCM_COMP_APP_INC += ../../../drivers/switch/inc/osil/

BRCM_COMP_UAPP_SRC += qualification/tftp_qt.c
BRCM_COMP_UAPP_SRC += qualification/inet_cfg.c
BRCM_COMP_UAPP_SRC += qualification/nif_test_cfg.c

# Integration Test
ifeq ($(ENABLE_INTEGRATION_TEST), TRUE)
BRCM_COMP_UAPP_SRC += integration/tftp_it.c
BRCM_COMP_APP_INC += ../../inet/lib
BRCM_COMP_APP_CFLAGS += -DENABLE_TFTP_IT
BRCM_COMP_APP_TASK += TFTPITTask
TFTPITTask.priority = 10
TFTPITTask.stack = 2048
TFTPITTask.event += SystemEvent0
endif

BRCM_COMP_APP_CFLAGS += -DENABLE_SHELL_AUTO_TEST_FUNC=1
BRCM_COMP_APP_CFLAGS += -DENABLE_MAC1=1

BRCM_COMP_APP_CFLAGS += -DETHER_PKT_EVENT=SystemEvent0
BRCM_COMP_APP_CFLAGS += -DMDIO_STATE_HANDLER_EVENT=0
BRCM_COMP_APP_CFLAGS += -DETHER_TIMESTAMP_EVENT=0
BRCM_COMP_APP_CFLAGS += -DETHXCVR_LINK_EVENT=0

BRCM_COMP_APP_CFLAGS += -DINET_EVENT_PROCESS_TASK=EthernetTask
BRCM_COMP_APP_CFLAGS += -DMDIO_STATE_HANDLER_TASK=EthernetTask
BRCM_COMP_APP_CFLAGS += -DETH_IRQ_PROCESS_TASK=EthernetTask
BRCM_COMP_APP_CFLAGS += -DETHXCVR_IRQ_PROCESS_TASK=EthernetTask

BRCM_COMP_APP_ALARM          += TFTP_TEST_Alarm
TFTP_TEST_Alarm.counter      := SystemTimer
TFTP_TEST_Alarm.callback     := TFTP_TEST_AlarmCb
TFTP_TEST_Alarm.declaration  := tftp_test.h
TFTP_TEST_Alarm.autostart    := true
TFTP_TEST_Alarm.alarmtime    := 1
TFTP_TEST_Alarm.cycletime    := 1

BRCM_COMP_APP_TASK += EthernetTask
EthernetTask.priority = 12
EthernetTask.stack = 4096
EthernetTask.event += SystemEvent0
EthernetTask.event += SystemEvent1
EthernetTask.event += SystemEvent2
EthernetTask.event += SystemEvent3
EthernetTask.event += SystemEvent5
EthernetTask.event += SystemEvent6
EthernetTask.event += UDP_TxEvent
EthernetTask.event += UDP_RxEvent

BRCM_COMP_APP_TASK += TFTPClientTask
TFTPClientTask.priority = 10
TFTPClientTask.stack = 2048
TFTPClientTask.event += SystemEvent0
TFTPClientTask.event += SystemEvent1
TFTPClientTask.event += SystemEvent2
TFTPClientTask.event += SystemEvent3
TFTPClientTask.event += SystemEvent5
TFTPClientTask.event += SystemEvent6
TFTPClientTask.event += UDP_TxEvent
TFTPClientTask.event += UDP_RxEvent

BRCM_COMP_APP_TASK += TFTPServerTask
TFTPServerTask.priority = 11
TFTPServerTask.stack = 2048
TFTPServerTask.event += SystemEvent0
TFTPServerTask.event += SystemEvent1
TFTPServerTask.event += SystemEvent2
TFTPServerTask.event += SystemEvent3
TFTPServerTask.event += SystemEvent5
TFTPServerTask.event += SystemEvent6
TFTPServerTask.event += UDP_TxEvent
TFTPServerTask.event += UDP_RxEvent

