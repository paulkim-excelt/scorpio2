#
# Copyright 2018-2022 Broadcom Limited.  All rights reserved.
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

##  @defgroup grp_sys_service Service
#   @ingroup grp_system
#
#   @addtogroup grp_sys_service
#   @{
#   @file system/service/comp.mk
#   @brief Makefile for System Task and service
#   @version 0.1 Initial version
#   @}
#

BRCM_COMP_NAME := sys_service
BRCM_COMP_DEPENDS := system dbgmem
BRCM_COMP_TYPE := lib

BRCM_COMP_APP_SRC :=
BRCM_INC :=

BRCM_COMP_REQ_SRC += doc/erika_req.c
BRCM_COMP_REQ_SRC += doc/base_os_req.c

#WDG Module
ifeq ($(ENABLE_WDG_MODULE), TRUE)
BRCM_COMP_DEPENDS += wdg
ifeq ($(call isappopt,ENABLE_WDG_MODULE),yes)
BRCM_COMP_APP_CFLAGS += -DSYSTEM_WDG_MODULE=WDG_Module
endif
endif

#TIME Module
ifeq ($(call isappopt,ENABLE_TIME_MODULE),yes)
BRCM_COMP_DEPENDS += time
BRCM_COMP_APP_CFLAGS += -DSYSTEM_TIME_MODULE=TIME_Module
endif

#IO Service
ifeq ($(call isappopt,ENABLE_IO),yes)
BRCM_COMP_APP_CFLAGS += -DSYSTEM_IO_SERVICE=IOS_SERVICE
BRCM_COMP_APP_CFLAGS += -DIOM_SERVER_TASK=IOS_SERVICE_Task
BRCM_COMP_DEPENDS += iosrv
endif

#NVM Service
ifeq ($(ENABLE_NVM), TRUE)
ifeq ($(call isappopt,ENABLE_NVM),yes)
BRCM_COMP_DEPENDS += nvmsrv_v2
BRCM_COMP_APP_CFLAGS += -DRPC_MSGQ_MASTER_IFC_NVM=NVM_Service
BRCM_COMP_APP_CFLAGS += -DSYSTEM_NVM_SERVICE=NVM_Service
BRCM_COMP_APP_CFLAGS += -DFLASHM_SERVER_TASK=NVM_Service_Task
endif
endif

#CRYPTO Service
ifeq ($(call isappopt, ENABLE_CRYPTO_SERVICE), yes)
BRCM_COMP_APP_CFLAGS += -DSYSTEM_CRYPTO_SERVICE=CRYPTO_Service
BRCM_COMP_APP_CFLAGS += -DRPC_MSGQ_MASTER_IFC_CRYPTO=CRYPTO_Service
BRCM_COMP_DEPENDS += crypto_service
endif

#ETHERNET Service
ifeq ($(call isappopt, ENABLE_ETH_SERVICE), yes)
BRCM_COMP_DEPENDS += ethsrv
BRCM_COMP_APP_CFLAGS += -DSYSTEM_ETHERNET_SERVICE=ETHERNET_Service
endif

#RPC Module
ifeq ($(ENABLE_RPC_V2),TRUE)
ifeq ($(call isappopt,ENABLE_RPC_V2),yes)
BRCM_COMP_DEPENDS += rpc_v2

BRCM_COMP_LIB_CFLAGS += -DENABLE_RPC_V2

BRCM_COMP_APP_CFLAGS += -DSYSTEM_RPC_MODULE=RPC_Module
BRCM_COMP_APP_CFLAGS += -DRPC_ASYNC_EVENT_TO_HOST=RPC_AsyncEventToHost
BRCM_COMP_APP_CFLAGS += -DRPC_SLAVE_SEND_MSG=RPC_SlaveSendLocalCmd
BRCM_COMP_APP_CFLAGS += -DRPC_SLAVE_GET_RESP=RPC_SlaveGetLocalResp
BRCM_COMP_APP_CFLAGS += -DIPC_SERVER_TASK=SYSTEM_Task
BRCM_COMP_APP_CFLAGS += -DRPC_TASK=SYSTEM_Task
BRCM_COMP_APP_CFLAGS += -DIPC_CHANN0_EVENT=SystemEvent7

ifeq ($(ENABLE_RPC_MASTER_STREAM_SUPPORT),TRUE)
BRCM_COMP_APP_CFLAGS += -DIMGL_MODE_FUNC_TABLE_PRIO1=RPC_MasterImgHandler
endif #ENABLE_RPC_MASTER_STREAM_SUPPORT
ifneq ($(call isappopt,ENABLE_ROM_MODE ENABLE_BOOTLOADER_MODE),yes)
BRCM_COMP_APP_CFLAGS += -DRPC_MSGQ_MASTER_IFC_SYS=SYSTEM_Service
ifeq ($(ENABLE_ETHSRV_RPC), TRUE)
BRCM_COMP_APP_CFLAGS += -DRPC_MSGQ_MASTER_IFC_ETHSRV=ETHERNET_Service
endif #ENABLE_ETHSRV_RPC
endif #!ENABLE_ROM_MODE !ENABLE_BOOTLOADER_MODE
endif
else
BRCM_COMP_APP_CFLAGS += -DRPC_SLAVE_SEND_MSG=RPC_CmdQSendCmd
BRCM_COMP_APP_CFLAGS += -DRPC_SLAVE_GET_RESP=RPC_CmdQGetCmdStatus
endif

#DMON Module
ifeq ($(ENABLE_DMON_MODULE),TRUE)
ifeq ($(call isappopt, ENABLE_DMON_MODULE), yes)
BRCM_COMP_DEPENDS       += dmon_mod
BRCM_COMP_APP_CFLAGS    += -DDMON_SERVER_TASK=SYSTEM_Task
BRCM_COMP_APP_CFLAGS    += -DSYSTEM_DMON_MODULE=DMON_Module
endif
endif

#TC10 Module
ifeq ($(CHIP_FAMILY),bcm8958x)
ifeq ($(call isappopt,ENABLE_TC10_MODULE),yes)
BRCM_COMP_DEPENDS 		+= tc10_module
SYSTEM_Task.event       += SystemEvent13
BRCM_COMP_APP_CFLAGS    += -DTC10_INTR_EVENT=SystemEvent13
BRCM_COMP_APP_CFLAGS    += -DTC10_SERVER_TASK=SYSTEM_Task
BRCM_COMP_APP_CFLAGS    += -DSYSTEM_TC10_MODULE=TC10_Module
endif
endif

#IMGL Module
ifeq ($(call isappopt,ENABLE_IMGL_V2),yes)
BRCM_COMP_DEPENDS += imgl
ifeq ($(ENABLE_FW_LOAD),TRUE)
BRCM_COMP_APP_CFLAGS    += -DSYSTEM_IMGL_FETCH_MODULE=IMGL_FetchModule
else
BRCM_COMP_APP_CFLAGS    += -DSYSTEM_IMGL_UPDATE_MODULE=IMGL_UpdateModule
endif
endif

#Include Path
BRCM_INC += $(BRCM_SDK_ROOT)/system/service/inc
BRCM_INC += $(BRCM_SDK_ROOT)/ethernet/common/rpc/inc
BRCM_INC += $(BRCM_SDK_ROOT)/nvm/service/inc/osil
BRCM_COMP_UEXPORT_HDR += ../modules/rpc/inc/osil/.
BRCM_COMP_UEXPORT_HDR += ../modules/rpc/inc/.
BRCM_COMP_UEXPORT_HDR += ../modules/rpc/local/.
BRCM_COMP_UEXPORT_HDR += ../modules/rpc/ipc/inc/.
BRCM_COMP_UEXPORT_HDR += ../modules/rpc/mem/inc/.
BRCM_COMP_UEXPORT_HDR += ../modules/rpc/module/inc/.
BRCM_COMP_UEXPORT_HDR += ../modules/rpc/local/inc/.

#Miscellaneous CFLAGS
BRCM_COMP_APP_CFLAGS += -DSYSTEM_RPC_MSG_PAYLOAD_SZ=RPC_MEM_MSG_PAYLOAD_SZ
BRCM_COMP_APP_CFLAGS += -DSYSTEM_PING_QUERY_TIME_NS=20000000ULL

ifeq ($(ENABLE_SLAVE_BOOT_SUPPORT),TRUE)
BRCM_COMP_APP_CFLAGS += -DENABLE_SLAVE_BOOT_SUPPORT
endif

ifeq ($(ENABLE_MSG_QUEUE), TRUE)
BRCM_COMP_REQ_SRC += doc/system_req.c
BRCM_COMP_EXPORT_HDR += inc/system_state.h
BRCM_COMP_EXPORT_HDR += inc/system.h
BRCM_COMP_EXPORT_HDR += inc/system_module.h
BRCM_COMP_APP_SRC += os/common/system.c
BRCM_COMP_EXPORT_HDR += inc/osil/system_osil.h
endif

#SYSTEM Service
ifneq (,$(filter $(CHIP_FAMILY),bcm8953x bcm8956x bcm8957x bcm8958x))
BRCM_COMP_APP_SRC += os/base/system_base.c
BRCM_COMP_APP_SRC += os/common/system_service.c
endif

ifeq ($(call isappopt, ENABLE_SYSTEM_SERVICE), yes)
BRCM_COMP_APP_TASK += SYSTEM_Task
SYSTEM_Task.priority := 16
SYSTEM_Task.autostart := true
SYSTEM_Task.stack := 2048
SYSTEM_Task.event += SystemEvent0
SYSTEM_Task.event += SystemEvent1
SYSTEM_Task.event += SystemEvent4  # IPC MsgQ
SYSTEM_Task.event += SystemEvent6  # Subsystem Notifications to Sytem Task(MsgQ)
SYSTEM_Task.event += SystemEvent7  # RPC V2 Task
SYSTEM_Task.event += SystemEvent10 # IMGL Notification
SYSTEM_Task.event += SystemEvent11 # VTMON sys monitor
SYSTEM_Task.event += SystemEvent12 # Reboot
SYSTEM_Task.event += SPUMEvent
SYSTEM_Task.event += IMGL_EVENT

BRCM_COMP_APP_ALARM += SYSTEM_ServiceAlarm
SYSTEM_ServiceAlarm.counter := SystemTimer
SYSTEM_ServiceAlarm.callback := SYSTEM_ServiceAlarmCb
SYSTEM_ServiceAlarm.declaration := osil/system_osil.h
SYSTEM_ServiceAlarm.autostart := true
SYSTEM_ServiceAlarm.alarmtime := 1
SYSTEM_ServiceAlarm.cycletime := 1

BRCM_COMP_APP_CFLAGS += -DIMGL_TASK_NAME=SYSTEM_Task
BRCM_COMP_APP_CFLAGS += -DIMGL_STATE_EVENT_ID=SystemEvent10
BRCM_COMP_APP_CFLAGS += -DSYS_REBOOT_EVENT=SystemEvent12 # this is for system task

endif

