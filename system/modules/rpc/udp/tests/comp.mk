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
#    OF THE AMOUNT ACTUALLY PAID FOR THE SOFTWARE ITSELF OR U.S. \$1, WHICHEVER
#    IS GREATER. THESE LIMITATIONS SHALL APPLY NOTWITHSTANDING ANY FAILURE OF
#    ESSENTIAL PURPOSE OF ANY LIMITED REMEDY.
#
####################################################################################

BRCM_COMP_APP_SRC  := qualification/rpc_udp_test.c
BRCM_COMP_UAPP_SRC += qualification/nif_test_cfg.c

ENABLE_ETHXCVRM = FALSE

BRCM_COMP_APP_OPT += ENABLE_INET
BRCM_COMP_APP_OPT += ENABLE_TFTP
BRCM_COMP_APP_OPT += INET_TEST
BRCM_COMP_APP_OPT += ENABLE_TIME_MODULE
BRCM_COMP_APP_OPT += ENABLE_CONSOLE
BRCM_COMP_APP_OPT += ENABLE_MSG_QUEUE
BRCM_COMP_APP_OPT += ENABLE_UART0
BRCM_COMP_APP_OPT += ENABLE_DEFAULT_INET_CFG
BRCM_COMP_APP_OPT += BCM_TEST_CONFIG_LOADER
BRCM_COMP_APP_OPT += ENABLE_RPC_UDP
#BRCM_COMP_APP_OPT += ENABLE_RPC_V2
BRCM_COMP_APP_OPT += ENABLE_SYSTEM_SERVICE

BRCM_COMP_APP_CFLAGS += -DETHER_PKT_EVENT=SystemEvent0
BRCM_COMP_APP_CFLAGS += -DMDIO_STATE_HANDLER_EVENT=0
BRCM_COMP_APP_CFLAGS += -DETHER_TIMESTAMP_EVENT=0
BRCM_COMP_APP_CFLAGS += -DETHXCVR_LINK_EVENT=0
BRCM_COMP_APP_CFLAGS += -DMDIO_STATE_HANDLER_TASK=RPC_EventTask
BRCM_COMP_APP_CFLAGS += -DETH_IRQ_PROCESS_TASK=RPC_EventTask
BRCM_COMP_APP_CFLAGS += -DETHXCVR_IRQ_PROCESS_TASK=RPC_EventTask
BRCM_COMP_APP_CFLAGS += -DRPC_TFTP_RETRY_COUNT=10UL
BRCM_COMP_APP_CFLAGS += -DRPC_TFTP_RETRY_INTERVAL_MS=10UL
BRCM_COMP_APP_CFLAGS += -DINET_EVENT_PROCESS_TASK=RPC_EventTask

BRCM_INC += $(BRCM_SDK_ROOT)/system/rpc/inc/osil
BRCM_INC += $(BRCM_SDK_ROOT)/system/rpc/inc
BRCM_INC += $(BRCM_SDK_ROOT)/system/rpc/udp/inc
BRCM_INC += $(BRCM_SDK_ROOT)/system/rpc/udp/inc/osil
BRCM_COMP_APP_INC += ../../../../../crypto/abstract/inc/
BRCM_COMP_APP_INC += ../../local/inc/osil
BRCM_COMP_UEXPORT_HDR += ../../../../service/inc/osil/system_osil.h

BRCM_CFLAGS += -DENABLE_SHELL_AUTO_TEST_FUNC=1
BRCM_CFLAGS += -DRPC_TASK=RPC_TestTask
BRCM_CFLAGS += -DRPC_MEM_MSG_COUNT=8UL
BRCM_CFLAGS += -DRPC_MEM_STREAM_COUNT=2UL
BRCM_CFLAGS += -DRPC_MEM_STREAM_SIZE=2048UL
BRCM_CFLAGS += -DENABLE_RPC_V2

BRCM_COMP_APP_EVENT += SystemEvent0
BRCM_COMP_APP_EVENT += SystemEvent1
BRCM_COMP_APP_EVENT += SystemEvent3

BRCM_COMP_APP_TASK += RPC_TestTask
RPC_TestTask.priority = 10
RPC_TestTask.stack = 4096
RPC_TestTask.event += SystemEvent0
RPC_TestTask.event += SystemEvent1

BRCM_COMP_APP_TASK += RPC_EventTask
RPC_EventTask.priority = 12
RPC_EventTask.stack = 4096
RPC_EventTask.event += SystemEvent0
RPC_EventTask.event += SystemEvent1
RPC_EventTask.event += SystemEvent3
RPC_EventTask.autostart := true

BRCM_COMP_APP_ALARM          += RPC_TEST_Alarm
RPC_TEST_Alarm.counter      := SystemTimer
RPC_TEST_Alarm.callback     := RPC_TEST_AlarmCb
RPC_TEST_Alarm.declaration  := rpc_udp_test.h
RPC_TEST_Alarm.autostart    := true
RPC_TEST_Alarm.alarmtime    := 1
RPC_TEST_Alarm.cycletime    := 1

BRCM_COMP_NAME := rpc_udp_test
BRCM_COMP_DEPENDS := rpc_udp
BRCM_COMP_TYPE := test
