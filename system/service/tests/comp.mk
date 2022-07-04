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
#    OF THE AMOUNT ACTUALLY PAID FOR THE SOFTWARE ITSELF OR U.S. $1, WHICHEVER
#    IS GREATER. THESE LIMITATIONS SHALL APPLY NOTWITHSTANDING ANY FAILURE OF
#    ESSENTIAL PURPOSE OF ANY LIMITED REMEDY.
#
####################################################################################

BRCM_COMP_APP_SRC += qualification/sys_test.c

BRCM_COMP_NAME := sys_test
BRCM_COMP_DEPENDS := system utils mcudrv pchdrv
BRCM_COMP_TYPE := test

BRCM_COMP_EXPORT_HDR += ../../

BRCM_COMP_APP_TASK        += SYS_MODTestTask
SYS_MODTestTask.priority   = 4
SYS_MODTestTask.autostart  = false
SYS_MODTestTask.stack      = 2048
SYS_MODTestTask.event += SYS_NOTIF_EVENT

BRCM_COMP_APP_CFLAGS += -DENABLE_PATCH
BRCM_COMP_APP_CFLAGS += -DRPC_CURRENT_BOOT_MODE=BCM_BOOT_MODE_BROM
BRCM_COMP_APP_CFLAGS += -DENABLE_OTP
BRCM_COMP_APP_CFLAGS += -DENABLE_TIMER_SP804
BRCM_COMP_APP_CFLAGS += -DENABLE_MSG_QUEUE
BRCM_COMP_APP_CFLAGS += -DENABLE_SYSTEM_MODULES
BRCM_COMP_APP_CFLAGS += -DDBG_LOG_ADDR=0x20000000UL
BRCM_COMP_APP_CFLAGS += -DBCM_TEST_CONFIG_LOADER

BRCM_DEFAULT_TEST_OPT += ENABLE_ROM_MODE
BRCM_DEFAULT_TEST_OPT += ENABLE_SYSTEM_TASK
BRCM_DEFAULT_TEST_OPT += ENABLE_OTP_MODULE
BRCM_DEFAULT_TEST_OPT += ENABLE_TIME_MODULE
BRCM_DEFAULT_TEST_OPT += ENABLE_RPC_V2

ifeq ($(CHIP_FAMILY),bcm8958x)
BRCM_COMP_APP_SRC += ../../bcm8958x/os/erika/m7_bcm8958x_platform.c
endif
BRCM_COMP_DEPENDS += sys_service
BRCM_COMP_APP_CFLAGS += -DCRYPTO_TASK_NAME=SYSTEM_Task
BRCM_COMP_APP_CFLAGS += -DSYS_TASK_NAME=SYSTEM_Task
BRCM_COMP_APP_CFLAGS += -DIPC_SYS_MSGQ_EVENT=SystemEvent4
BRCM_COMP_APP_CFLAGS += -DIPC_CHANN1_EVENT=SystemEvent9
ifeq ($(call isappopt, ENABLE_OTP_MODULE), yes)
BRCM_COMP_DEPENDS += otpm
BRCM_COMP_EXPORT_HDR += ../../../../nvm/modules/otpm/inc/
BRCM_COMP_EXPORT_HDR += ../../../../nvm/drivers/otp/inc/
endif
ifeq ($(call isappopt, ENABLE_TIME_MODULE), yes)
BRCM_COMP_EXPORT_HDR += ../../../../init/drivers/timer/inc/
BRCM_COMP_DEPENDS += time
endif
ifeq ($(call isappopt, ENABLE_RPC_V2), yes)
BRCM_COMP_DEPENDS += rpc_v2
BRCM_DEFAULT_TEST_OPT += ENABLE_IPC
BRCM_COMP_APP_OPT += RPC_MODULE_TEST_EN
endif

BRCM_COMP_APP_TASK += SYSTEM_Task
SYSTEM_Task.priority := 16
SYSTEM_Task.autostart := true
SYSTEM_Task.stack := 2048
SYSTEM_Task.event += SystemEvent0
SYSTEM_Task.event += SystemEvent1
SYSTEM_Task.event += SystemEvent6  # Subsystem Notifications to Sytem Task(MsgQ)
SYSTEM_Task.event += SystemEvent7  # RPC V2 Task
SYSTEM_Task.event += SystemEvent12 # Reboot

BRCM_COMP_APP_ALARM += SYSTEM_ServiceAlarm
SYSTEM_ServiceAlarm.counter := SystemTimer
SYSTEM_ServiceAlarm.callback := SYSTEM_ServiceAlarmCb
SYSTEM_ServiceAlarm.declaration := osil/system_osil.h
SYSTEM_ServiceAlarm.autostart := true
SYSTEM_ServiceAlarm.alarmtime := 1
SYSTEM_ServiceAlarm.cycletime := 1

