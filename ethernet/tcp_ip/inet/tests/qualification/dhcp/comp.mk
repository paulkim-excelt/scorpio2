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

BRCM_COMP_NAME := dhcp_test
BRCM_COMP_DEPENDS := inet
BRCM_COMP_TYPE := test

ENABLE_ETHXCVRM = FALSE
BRCM_COMP_APP_INC += ../../../../../../system/service/inc/
BRCM_COMP_APP_INC += qualification/dhcp/
BRCM_COMP_APP_INC += ../../../../../drivers/switch/inc/
BRCM_COMP_APP_INC += ../../../../../drivers/switch/inc/osil/
BRCM_COMP_APP_INC += ../../../../../drivers/transceiver/inc/
BRCM_COMP_APP_INC += ../../../../../drivers/transceiver/inc/osil/

BRCM_COMP_UAPP_SRC += dhcp_qt.c
BRCM_COMP_UAPP_SRC += inet_cfg.c
BRCM_COMP_UAPP_SRC += nif_test_cfg.c

BRCM_CFLAGS += -DENABLE_SHELL_AUTO_TEST_FUNC=1
BRCM_COMP_APP_OPT += ENABLE_INET
BRCM_COMP_APP_OPT += BCM_TEST_CONFIG_LOADER
BRCM_COMP_APP_OPT += ENABLE_DHCP
BRCM_COMP_APP_OPT += ENABLE_DHCP_TEST
BRCM_COMP_APP_OPT += ENABLE_TIME_MODULE
BRCM_COMP_APP_OPT += ENABLE_SYSTEM_SERVICE
BRCM_COMP_APP_CFLAGS += -DSYSTEM_TASK_DHCP_TEST
ifeq ($(CHIP_FAMILY),bcm8956x)
BRCM_COMP_APP_OPT += __BCM89561_EVK__
endif
ifeq ($(CHIP_FAMILY),bcm8957x)
BRCM_COMP_APP_OPT += __BCM89571_EVK__
endif

ifneq ($(CHIP_FAMILY),bcm8958x)
BRCM_CFLAGS += -DDHCP_TEST_RENEWAL=1
endif

BRCM_COMP_APP_CFLAGS += -DETHER_PKT_EVENT=SystemEvent0
BRCM_COMP_APP_CFLAGS += -DMDIO_STATE_HANDLER_EVENT=0
BRCM_COMP_APP_CFLAGS += -DETHER_TIMESTAMP_EVENT=0
BRCM_COMP_APP_CFLAGS += -DETHXCVR_LINK_EVENT=0


BRCM_COMP_APP_CFLAGS += -DINET_EVENT_PROCESS_TASK=DHCPTestTask
BRCM_COMP_APP_CFLAGS += -DMDIO_STATE_HANDLER_TASK=DHCPTestTask
BRCM_COMP_APP_CFLAGS += -DETH_IRQ_PROCESS_TASK=DHCPTestTask
BRCM_COMP_APP_CFLAGS += -DETHXCVR_IRQ_PROCESS_TASK=DHCPTestTask


BRCM_COMP_APP_ALARM                 += DHCPTest_Timeout_Alarm
DHCPTest_Timeout_Alarm.counter      := SystemTimer
DHCPTest_Timeout_Alarm.callback     := DHCPTest_Timeout_Callback
DHCPTest_Timeout_Alarm.declaration  := dhcp_test.h
DHCPTest_Timeout_Alarm.autostart    := false
DHCPTest_Timeout_Alarm.alarmtime    := 20
DHCPTest_Timeout_Alarm.cycletime    := 0

BRCM_COMP_APP_TASK += DHCPTestTask
DHCPTestTask.priority = 10
DHCPTestTask.stack = 2048
DHCPTestTask.event += SystemEvent0
DHCPTestTask.event += SystemEvent1
DHCPTestTask.event += SystemEvent3
DHCPTestTask.event += SystemEvent4
DHCPTestTask.event += UDP_TxEvent
DHCPTestTask.event += UDP_RxEvent
