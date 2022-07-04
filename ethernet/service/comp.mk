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

##  @defgroup grp_ethsrv_sw Ethernet Service Stack
#   @ingroup grp_ethernet
#
#   @addtogroup grp_ethsrv_sw
#   @{
#   This chapter describes Ethernet Service stacks and components available for
#   Broadcom Automotive SDK, including
#       -# Network Interface (NIF)
#       -# Stream Shaping (FQTSS)
#       -# UDP/IP Stack (INET)
#       -# TFTP Client
#       -# AVB Stacks (1722 only)
#       -# RTP/RTCP
#       -# MPEG-TS
#       -# Ethernet Time Sync
#       -# Wireless LAN stack
#       -# Remote File Service (RFS)
#
#   @note Availability of above listed components is product specific
#
#   @file ethernet/service/comp.mk
#   @brief Makefile for Ethernet Service Stacks
#   @version 0.1 Initial version
#   @}
#
#

BRCM_COMP_NAME := ethsrv
BRCM_COMP_DEPENDS := arch ethutils nif
BRCM_COMP_TYPE := lib

ifeq ($(call isappopt, ENABLE_ETH_TIME), yes)
BRCM_COMP_DEPENDS += ettm
endif

ifneq (,$(filter $(CHIP_FAMILY),bcm8953x bcm8956x bcm8957x bcm8958x))
BRCM_COMP_EXPORT_HDR += inc/ethernet_service.h
BRCM_COMP_EXPORT_HDR += inc/osil/ethernet_osil.h
BRCM_COMP_APP_SRC += os/common/ethernet_service.c
BRCM_COMP_APP_SRC += os/base/ethernet_base.c
BRCM_COMP_APP_CFLAGS += -DETHERNET_MEM_MSG_PAYLOAD_SZ=RPC_MEM_MSG_PAYLOAD_SZ
ifeq ($(ENABLE_ETHSRV_CMDS), TRUE)
BRCM_COMP_APP_CFLAGS += -DENABLE_ETHSRV_CMDS
endif #ENABLE_ETHSRV_CMDS
else
BRCM_COMP_EXPORT_HDR += inc/osil/ethsrv_module.h
BRCM_COMP_EXPORT_HDR += inc/osil/ethsrv_base.h
BRCM_COMP_EXPORT_HDR += inc/osil/ethsrv_mod_osil.h
BRCM_COMP_ULIB_SRC += lib/ethsrv_module.c
BRCM_COMP_UAPP_SRC += os/base/ethsrv_base.c
endif
BRCM_COMP_UAPP_SRC += os/common/ethsrv_osil.c
BRCM_COMP_REQ_SRC += doc/ethsrv_module_req.c
BRCM_COMP_REQ_SRC += doc/ethernet_req.c

BRCM_COMP_UEXPORT_HDR += host/ethsrv_host.h
BRCM_COMP_UHOST_SRC   += host/ethsrv_host.c

BRCM_COMP_APP_CFLAGS += -DENABLE_ETHSRV
ifneq ($(call isappopt,ENABLE_ETHER_TEST),yes)
ifeq ($(call isappopt,ENABLE_INET),yes)
BRCM_COMP_APP_CFLAGS += -DETHSRV_INET_MODULE=INET_Module
endif
endif

ifeq ($(call isappopt,ENABLE_ETH),yes)
BRCM_COMP_APP_CFLAGS += -DETHSRV_ETHER_MODULE=NIF_CntrlrModule
BRCM_COMP_APP_CFLAGS += -DMDIO_STATE_HANDLER_TASK=ETHERNET_Task
BRCM_COMP_APP_CFLAGS += -DMDIO_STATE_HANDLER_EVENT=SystemEvent8
BRCM_COMP_APP_CFLAGS += -DETHERNET_MSGQ_CMD_EVENT=SystemEvent7
BRCM_COMP_APP_CFLAGS += -DETHER_TIMESTAMP_EVENT=SystemEvent2
BRCM_COMP_APP_CFLAGS += -DETHERNET_NOTIF_EVENT=SystemEvent11

ifeq ($(call isappopt,ENABLE_ETHXCVRM),yes)
ifneq ($(call isappopt,ENABLE_ETHXCVR_TEST),yes)
BRCM_COMP_APP_CFLAGS += -DETHXCVR_IRQ_PROCESS_TASK=ETHERNET_Task
BRCM_COMP_APP_CFLAGS += -DETHXCVR_LINK_EVENT=SystemEvent4
BRCM_COMP_APP_CFLAGS += -DENABLE_ETHXCVRM
BRCM_COMP_APP_CFLAGS += -DETHXCVRM_TASK=ETHERNET_Task
ifneq ($(call isappopt,ENABLE_ETHER_TEST),yes)
BRCM_COMP_DEPENDS += ethxcvrm
BRCM_COMP_APP_CFLAGS += -DETHSRV_ETHXCVR_MODULE=ETHXCVRM_Module
BRCM_COMP_APP_CFLAGS += -DETHXCVRM_TIMER_EVENT=SystemEvent10
else
BRCM_COMP_APP_CFLAGS += -DETHXCVRM_TIMER_EVENT=0UL
endif #ENABLE_ETHER_TEST

ifneq ($(call isappopt,ENABLE_MDIO_TEST),yes)
BRCM_COMP_APP_CFLAGS += -DETHXCVRM_STATE_HANDLER_EVENT=MDIO_STATE_HANDLER_EVENT
else
BRCM_COMP_APP_CFLAGS += -DETHXCVRM_STATE_HANDLER_EVENT=0UL
endif
endif #ENABLE_ETHXCVR_TEST
endif #ENABLE_ETHXCVRM

ifeq ($(call isappopt,ENABLE_ETH_TIME),yes)
BRCM_COMP_APP_CFLAGS += -DETHSRV_ETT_MODULE=ETTM_Module
endif

ifneq ($(call isappopt,ENABLE_ETHER_TEST),yes)
BRCM_COMP_APP_CFLAGS += -DETH_IRQ_PROCESS_TASK=ETHERNET_Task
endif
endif #ENABLE_ETH

ifeq ($(ENABLE_ETHSWTM), TRUE)
BRCM_COMP_DEPENDS += ethswtm
ifeq ($(call isappopt,ENABLE_RPC_V2),yes)
BRCM_COMP_DEPENDS += rpc_v2
BRCM_COMP_APP_CFLAGS += -DETHSRV_RPC_TASK=ETHERNET_Task
endif
BRCM_COMP_APP_CFLAGS += -DETHERNET_RPC_SERVER_TASK=RPC_ServerTask
BRCM_COMP_UEXPORT_HDR += inc/ethsrv_rpc.h
BRCM_COMP_APP_CFLAGS += -DETHSRV_MSGQ_CMD_EVENT=SystemEvent7
BRCM_COMP_APP_CFLAGS += -DETHERSWT_IRQ_PROCESS_TASK=ETHERNET_Task
BRCM_COMP_APP_CFLAGS += -DETHERSWT_PORT_LINK_EVENT=SystemEvent6
BRCM_COMP_APP_CFLAGS += -DETHSWTM_TASK=ETHERNET_Task
ifeq ($(ENABLE_ETHSRV_RPC), TRUE)
BRCM_COMP_APP_CFLAGS += -DENABLE_ETHSRV_RPC
endif #ENABLE_ETHSRV_RPC
ifeq ($(call isappopt,ENABLE_ETHSWTM_ARL_APP),yes)
BRCM_COMP_APP_CFLAGS += -DETHSWTM_ARL_REFRESH_EVENT=SystemEvent9
BRCM_COMP_APP_CFLAGS += -DETHSRV_PROCESS_COMMANDS=ETHSRV_ProcessCommands
ifeq ($(call isappopt,ENABLE_ETHSWTM_CFP_APP),yes)
BRCM_COMP_APP_CFLAGS += -DETHSWTM_CFP_STREAMMONITOR_EVENT=SystemEvent12
endif #ENABLE_ETHSWTM_CFP_APP
endif #ENABLE_ETHSWTM_ARL_APP
ifeq ($(call isappopt,ENABLE_ETHSWTM_FA_APP),yes)
BRCM_COMP_APP_CFLAGS += -DETHSWTM_FA_IRQ_EVENT=SystemEvent14
BRCM_COMP_APP_CFLAGS += -DETHSWT_FA_PROCESS_IRQ_EVENT=SystemEvent14
BRCM_COMP_APP_CFLAGS += -DETHSWT_FA_PROCESS_TASK=ETHERNET_Task
else
BRCM_COMP_APP_CFLAGS += -DETHSWTM_FA_IRQ_EVENT=0UL
BRCM_COMP_APP_CFLAGS += -DETHSWT_FA_PROCESS_IRQ_EVENT=0UL
BRCM_COMP_APP_CFLAGS += -DETHSWT_FA_PROCESS_TASK=0UL
endif #ENABLE_ETHSWTM_FA_APP
endif #ENABLE_ETHSWTM

BRCM_COMP_APP_TASK += ETHERNET_Task
ETHERNET_Task.priority = 14
ETHERNET_Task.stack = 2048 #Ensure that atleast 2KB stack is allocated
ETHERNET_Task.autostart = true
ETHERNET_Task.event += SystemEvent0
ETHERNET_Task.event += SystemEvent1
ETHERNET_Task.event += SystemEvent2
ETHERNET_Task.event += SystemEvent3
ETHERNET_Task.event += SystemEvent4
ETHERNET_Task.event += SystemEvent5
ETHERNET_Task.event += SystemEvent6 #Used by Switch
ETHERNET_Task.event += SystemEvent7 #Used by Switch
ETHERNET_Task.event += SystemEvent8
ETHERNET_Task.event += SystemEvent9 # ARL Refresh
ETHERNET_Task.event += SystemEvent10 # Xcvr Timer Event
ETHERNET_Task.event += SystemEvent11 # Subsystem Notifications to Ethsrv Task(MsgQ)
ETHERNET_Task.event += SystemEvent12 # Stream monitoring timer
ETHERNET_Task.event += SystemEvent13 # Events for sync slave
ifeq ($(ENABLE_ETHSWT_FA), TRUE)
ETHERNET_Task.event += SystemEvent14 # Flow Accelerator IRQ
endif
ETHERNET_Task.event += UDP_RxEvent
ETHERNET_Task.event += UDP_TxEvent
ETHERNET_Task.event += IMGL_EVENT
ETHERNET_Task.event += MODULE_EVENT
ETHERNET_Task.event += ShutdownEvent

ifeq ($(call isappopt,ENABLE_ETS),yes)
ETHERNET_Task.stack = 4096
ETHERNET_Task.event += SystemEvent15
BRCM_COMP_APP_CFLAGS += -DETS_TIMER_EVENT=SystemEvent15
BRCM_COMP_LIB_CFLAGS += -DETHSRV_ETS_MODULE=ETSM_Module
BRCM_COMP_APP_CFLAGS += -DETSM_TASK=ETHERNET_Task
endif

ifeq ($(ENABLE_INET_TCP), TRUE)
ETHERNET_Task.event += SystemEvent16
endif

ifeq ($(call isappopt,ENABLE_CAN_MCAN),yes)
INCLUDE_PATH += $(BRCM_SDK_ROOT)/system/drivers/can/inc
#Bottom-half task for Ethernet
BRCM_COMP_APP_CFLAGS += -DCAN_IRQ_PROCESS_TASK=ETHERNET_Task

#Event for CAN bottomhalf processing
BRCM_COMP_APP_CFLAGS += -DCAN_EVENT=SystemEvent1
BRCM_COMP_APP_CFLAGS += -DETHERNET_CAN_EVENT=CAN_EVENT
BRCM_COMP_APP_CFLAGS += -DETHERNET_CAN_PROCESS=CAN_ProcessPkts
BRCM_COMP_APP_CFLAGS += -DENABLE_ETHERNET_MCAN
endif
