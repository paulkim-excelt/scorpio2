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
#    OF THE AMOUNT ACTUALLY PAID FOR THE SOFTWARE ITSELF OR U.S. $1, WHICHEVER
#    IS GREATER. THESE LIMITATIONS SHALL APPLY NOTWITHSTANDING ANY FAILURE OF
#    ESSENTIAL PURPOSE OF ANY LIMITED REMEDY.
#
####################################################################################

##  @defgroup grp_dmn_mod Device Monitor Module
#   @ingroup grp_sys_service
#
#   @addtogroup grp_dmn_mod
#   @{
#   @file comp.mk
#   @brief Makefile for DMON Module
#   @version 0.1 Initial version
#   @}

BRCM_COMP_NAME := dmon_mod
BRCM_COMP_TYPE := lib
BRCM_COMP_DEPENDS := system time dbgmem
BRCM_COMP_DEPENDS += rpc_v2

ifeq ($(ENABLE_VTMON), TRUE)
BRCM_COMP_DEPENDS += vtmondrv
BRCM_COMP_LIB_CFLAGS += -DENABLE_VTMON
BRCM_COMP_APP_CFLAGS += -DDMON_VtmonTempNotification=VTMON_TempNotification
BRCM_COMP_APP_CFLAGS += -DDMON_VtmonVoltNotification=VTMON_VoltNotification
endif

ifeq ($(ENABLE_RPC_HEART_BEAT), TRUE)
BRCM_COMP_LIB_CFLAGS += -DENABLE_RPC_HEART_BEAT
endif

BRCM_COMP_APP_CFLAGS += -DDMON_HEART_BEAT_INTERVAL_MS=1000UL

ifeq ($(cpu),m7)
BRCM_COMP_LIB_CFLAGS += -DDMON_TICK_CNT=CORTEX_MX_SysTickCount
endif

BRCM_COMP_REQ_SRC += doc/dmon_module_req.c

BRCM_COMP_EXPORT_HDR += inc/osil/dmon_module_osil.h

ifeq ($(ENABLE_DMON_MODULE), TRUE)

BRCM_COMP_LIB_SRC += lib/dmon_module.c
BRCM_COMP_APP_CFLAGS += -DDMON_MONITOR_EVENT=SystemEvent11

BRCM_COMP_APP_SRC    += os/common/dmon_module_osil.c
BRCM_COMP_APP_ALARM            += DeviceMonitorTimer
DeviceMonitorTimer.counter     := SystemTimer
DeviceMonitorTimer.callback    := DMON_AlarmCb
DeviceMonitorTimer.declaration := dmon_module_osil.h
DeviceMonitorTimer.autostart   := true
DeviceMonitorTimer.alarmtime   := 320
DeviceMonitorTimer.cycletime   := 320
endif

