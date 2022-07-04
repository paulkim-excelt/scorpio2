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

##  @defgroup grp_rpc_v2_local Local
#   @ingroup grp_rpc_v2
#
#   @addtogroup grp_rpc_v2_local
#   @{
#   @file system/rpc/local/comp.mk
#   @brief Makefile for RPC Local component
#   @version 0.1 Initial version
#   @}
#

BRCM_COMP_NAME := rpc_local
BRCM_COMP_DEPENDS := lwq imgl_interface rpc_mem time system
ifneq (,$(findstring $(CHIP_FAMILY),bcm8953x bcm8956x))
BRCM_COMP_DEPENDS += mcudrv
endif
ifeq ($(call isappopt, ENABLE_IMGL_V2), yes)
BRCM_COMP_DEPENDS += imgl
endif
BRCM_COMP_TYPE := doc

BRCM_COMP_REQ_SRC += doc/rpc_local_req.c

BRCM_COMP_EXPORT_HDR += inc/rpc_local.h
BRCM_COMP_EXPORT_HDR += inc/osil/rpc_local_osil.h
BRCM_COMP_EXPORT_HDR += inc/rpc_master_loader.h
BRCM_COMP_APP_SRC    += os/common/rpc_master.c
BRCM_COMP_APP_SRC    += os/common/rpc_slave.c
BRCM_COMP_APP_SRC    += os/erika/rpc_local_osil.c
BRCM_COMP_APP_CFLAGS += -DRPC_MSGQ_MASTER_EVENT=SystemEvent7
BRCM_COMP_APP_CFLAGS += -DRPC_SLAVE_EVENT=SystemEvent7
BRCM_COMP_APP_CFLAGS += -DRPC_MSGQ_MASTER_LOADER_EVENT=SystemEvent7
BRCM_COMP_APP_CFLAGS += -DRPC_ASYNC_EVENT=RPC_MSGQ_MASTER_EVENT
BRCM_COMP_APP_CFLAGS += -DRPC_SLAVE_ENABLE_LOCALCMD_SUPPORT=1UL
BRCM_COMP_APP_CFLAGS += -DRPC_MASTER_ENABLE_IFC_SUPPORT=1UL


ifeq ($(call isappopt,RPC_TFTP_SLOW_RETRY_INTERVAL),yes)
BRCM_COMP_APP_CFLAGS += -DRPC_TFTP_RETRY_COUNT=10UL
BRCM_COMP_APP_CFLAGS += -DRPC_TFTP_MSG_RETRY_INTERVAL_MS=20UL
BRCM_COMP_APP_CFLAGS += -DRPC_TFTP_STREAM_RETRY_INTERVAL_MS=100UL
BRCM_COMP_APP_CFLAGS += -DRPC_STREAM_TIMEOUT_MS=1000UL
else
BRCM_COMP_APP_CFLAGS += -DRPC_TFTP_RETRY_COUNT=10UL
BRCM_COMP_APP_CFLAGS += -DRPC_TFTP_MSG_RETRY_INTERVAL_MS=20UL
BRCM_COMP_APP_CFLAGS += -DRPC_TFTP_STREAM_RETRY_INTERVAL_MS=100UL
BRCM_COMP_APP_CFLAGS += -DRPC_STREAM_TIMEOUT_MS=1000UL
BRCM_COMP_LIB_CFLAGS += -DRPC_STREAM_TIMEOUT_MS=1000UL
endif

ifeq ($(ENABLE_RPC_MASTER_STREAM_SUPPORT), TRUE)
BRCM_COMP_APP_OPT += ENABLE_RPC_MASTER_STREAM_SUPPORT
endif

ifeq ($(ENABLE_RPC_SLAVE_STREAM_SUPPORT), TRUE)
BRCM_COMP_APP_OPT += ENABLE_RPC_SLAVE_STREAM_SUPPORT
BRCM_COMP_HOST_CFLAGS += -DENABLE_RPC_SLAVE_STREAM_SUPPORT
endif

BRCM_COMP_HOST_SRC += os/common/rpc_master.c
BRCM_COMP_HOST_SRC += os/common/rpc_slave.c
BRCM_COMP_HOST_SRC += os/erika/rpc_local_osil.c


BRCM_COMP_HOST_CFLAGS += -DRPC_MSGQ_MASTER_EVENT=0
BRCM_COMP_HOST_CFLAGS += -DRPC_SLAVE_EVENT=0
BRCM_COMP_HOST_CFLAGS += -DRPC_ASYNC_EVENT=0
BRCM_COMP_HOST_CFLAGS += -DRPC_MSGQ_MASTER_LOADER_EVENT=0
BRCM_COMP_HOST_CFLAGS += -URPC_MASTER_ENABLE_IFC_SUPPORT
BRCM_COMP_HOST_CFLAGS += -DENABLE_HOST_BUILD=1UL
BRCM_COMP_HOST_CFLAGS += -URPC_SLAVE_ENABLE_LOCALCMD_SUPPORT

BRCM_COMP_APP_ALARM += RPC_TimerAlarm
RPC_TimerAlarm.counter = SystemTimer
RPC_TimerAlarm.callback = RPC_TimerAlarmCb
RPC_TimerAlarm.declaration = rpc_local_osil.h
RPC_TimerAlarm.autostart = true
RPC_TimerAlarm.alarmtime = 1
RPC_TimerAlarm.cycletime = 1

