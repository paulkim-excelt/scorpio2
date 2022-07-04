#
# Copyright 2017-2022 Broadcom Limited.  All rights reserved.
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

##  @defgroup grp_inet Internet stack
#   @ingroup grp_ethernet
#
#   @addtogroup grp_inet
#   @{
#   @file ethernet/tcp_ip/inet/comp.mk
#   @brief Makefile for INET files
#   @version 0.1 Initial version
#   @}
#

BRCM_SRC :=
BRCM_COMP_LIB_CFLAGS :=
BRCM_INC :=

# Macro used to define the maximum number of offers which will be cached waiting for user to select one before the select timeout occurs
BRCM_COMP_LIB_CFLAGS += -DDHCP_MAX_OFFERS_CACHED=\(2U\)

# Macro used as the amount of time (in seconds) to wait for a response to an ARP request sent by the client to probe the assigned address
BRCM_COMP_LIB_CFLAGS += -DDHCP_ADDRESS_PROBE_TIMEOUT=\(0UL\)

# Max number of fragments we expect an incoming datagram to consist 2^6 = 64
BRCM_COMP_LIB_CFLAGS += -DINET_LOG2_MAX_REASS_FRAGS=6U
# Maximum duration in micro seconds to wait before freeing a reassembly buffer
# in case all fragments of a IP packet are not received. Currently a value
# of 50 milli seconds is configured i.e. 3125 microsecs * 16 = 50 ms
BRCM_COMP_LIB_CFLAGS += -DINET_MAX_REASS_BUF_TIMEOUT=\(SYS_TICK_US*16UL\)
# Maximum duration in micro seconds to wait before freeing a reassembly buffer
# in case the notified client does not read the buffer. Currently a value
# of 6.125ms is configured i.e. 3125 microsecs * 2 = 6.125ms
BRCM_COMP_LIB_CFLAGS += -DINET_MAX_CLIENT_READ_TIMEOUT=\(SYS_TICK_US*2UL\)
# Size of the ARP cache
BRCM_COMP_LIB_CFLAGS += -DINET_MAX_ENTRIES_ARPCACHE=20U
# Lifetime of a resolved ARP address in the cache in seconds
BRCM_COMP_LIB_CFLAGS += -DINET_ARP_COMPLETE_ENTRY_LIFETIME=7200UL
# Interval in seconds after which an ARP request needs to be resent
# in case of an un-resolved ARP address in the cache
BRCM_COMP_LIB_CFLAGS += -DINET_ARP_RETRY_PERIOD=1UL
BRCM_COMP_LIB_CFLAGS += -DINET_MASTER_DEFAULT_IP_ADDR=\(0xC0A80A00UL\)

BRCM_COMP_LIB_CFLAGS += -DINET_TCP_WNDSZ_DEFAULT=2000U
BRCM_COMP_LIB_CFLAGS += -DINET_TCP_MSS=1400U
BRCM_COMP_LIB_CFLAGS += -DINET_TCP_MAX_CONNS_PER_ENDPT=1U
BRCM_COMP_LIB_CFLAGS += -DINET_TCP_RETRY_INTERVAL_NS=3000000ULL
BRCM_COMP_LIB_CFLAGS += -DINET_TCP_MAX_RETRIES=3U
BRCM_COMP_LIB_CFLAGS += -DINET_TCP_2MSL_TIME=3000000ULL

ifeq ($(call isappopt,ENABLE_CAMERA_TUNING),yes)
BRCM_COMP_APP_CFLAGS += -DINET_CAMERA_TUNING
endif

ifeq ($(call isappopt,ENABLE_TUNER_LOGGING),yes)
BRCM_COMP_APP_CFLAGS += -DINET_CAMERA_TUNER_LOGGING
endif

BRCM_COMP_APP_SRC += os/common/inet_system.c
BRCM_COMP_APP_SRC += os/common/ethif.c

BRCM_COMP_LIB_SRC += lib/api.c
BRCM_COMP_LIB_SRC += lib/udp.c
ifeq ($(ENABLE_INET_TCP),TRUE)
BRCM_COMP_LIB_SRC += lib/tcp.c
BRCM_COMP_LIB_SRC += lib/tcp_sm.c
BRCM_COMP_LIB_CFLAGS += -DENABLE_INET_TCP
BRCM_COMP_APP_CFLAGS += -DENABLE_INET_TCP
endif
BRCM_COMP_LIB_SRC += lib/ip.c
BRCM_COMP_LIB_SRC += lib/arp.c
BRCM_COMP_LIB_SRC += lib/icmp.c
BRCM_COMP_LIB_SRC += lib/netif.c
BRCM_COMP_LIB_SRC += lib/dhcp.c
BRCM_COMP_LIB_SRC += lib/inet_module.c

BRCM_COMP_DOC_SRC += doc/dhcp_server_page.c
BRCM_COMP_REQ_SRC += doc/inet_req.c
BRCM_COMP_QT_SRC += tests/qualification/dhcp/dhcp_qt.h

BRCM_COMP_EXPORT_HDR += inc/dhcp.h
BRCM_COMP_EXPORT_HDR += inc/osil/dhcp_osil.h
BRCM_COMP_EXPORT_HDR += inc/inet.h
BRCM_COMP_EXPORT_HDR += inc/udp.h
BRCM_COMP_EXPORT_HDR += inc/tcp.h
BRCM_COMP_EXPORT_HDR += inc/osil/inet_cfg.h
BRCM_COMP_EXPORT_HDR += inc/osil/inet_osil.h
BRCM_COMP_EXPORT_HDR += inc/osil/netif.h
BRCM_COMP_LIB_INC += lib/inet_common.h
ifeq ($(CHIP_FAMILY),bcm8910x)
BRCM_COMP_LIB_CFLAGS += -DDHCP_RENEW_REBIND_SUPPORT
# Maximum size of reassembled datagram that we expect
BRCM_COMP_LIB_CFLAGS += -DINET_MAX_REASS_BUF_SIZE=1600U
ifeq ($(call isappopt, ENABLE_DEFAULT_INET_CFG), yes)
BRCM_COMP_APP_SRC += os/platform/bcm8910x/inet_cfg.c
endif # ENABLE_DEFAULT_INET_CFG
BRCM_COMP_APP_SRC += os/platform/bcm8910x/inet_switch.c
BRCM_COMP_REQ_SRC += doc/inet_bcm8910x_req.c
BRCM_COMP_APP_SRC += os/erika/inet_osil.c
endif
ifeq ($(CHIP_FAMILY),bcm8956x)
ifeq ($(call isappopt, ENABLE_BCM8956X_ROM), yes)
BRCM_COMP_LIB_CFLAGS += -DINET_MAX_REASS_BUF_SIZE=768U
BRCM_COMP_APP_SRC += os/platform/switch/inet_cfg_rom.c
BRCM_COMP_EXPORT_HDR += os/platform/switch/inet_cfg_rom.h
BRCM_COMP_REQ_SRC += doc/inet_bcm8956x_rom_req.c
BRCM_COMP_APP_SRC += os/platform/switch/inet_switch_rom.c
else
BRCM_COMP_LIB_CFLAGS += -DDHCP_RENEW_REBIND_SUPPORT
BRCM_COMP_LIB_CFLAGS += -DINET_MAX_REASS_BUF_SIZE=1500U
BRCM_COMP_LIB_CFLAGS += -DINET_RPC_SERVER_TASK=RPC_ServerTask
ifeq ($(call isappopt, ENABLE_DEFAULT_INET_CFG), yes)
BRCM_COMP_APP_SRC += os/platform/switch/inet_cfg.c
endif # ENABLE_DEFAULT_INET_CFG
BRCM_COMP_REQ_SRC += doc/inet_switch_req.c
BRCM_COMP_APP_SRC += os/platform/switch/inet_switch.c
BRCM_COMP_APP_SRC += os/erika/inet_osil.c
endif
endif

ifeq ($(CHIP_FAMILY),bcm8957x)
BRCM_COMP_LIB_CFLAGS += -DINET_MAX_REASS_BUF_SIZE=1500U
ifeq ($(call isappopt, ENABLE_BCM8957X_ROM), yes)
BRCM_COMP_APP_SRC += os/platform/bcm8957x/inet_cfg_rom.c
BRCM_COMP_EXPORT_HDR += os/platform/bcm8957x/inet_cfg_rom.h
BRCM_COMP_REQ_SRC += doc/inet_bcm8957x_rom_req.c
BRCM_COMP_APP_SRC += os/platform/bcm8957x/inet_switch_rom.c
else
BRCM_COMP_LIB_CFLAGS += -DDHCP_RENEW_REBIND_SUPPORT
BRCM_COMP_LIB_CFLAGS += -DINET_RPC_SERVER_TASK=RPC_ServerTask
ifeq ($(call isappopt, ENABLE_DEFAULT_INET_CFG), yes)
BRCM_COMP_APP_SRC += os/platform/switch/inet_cfg.c
endif # ENABLE_DEFAULT_INET_CFG
BRCM_COMP_REQ_SRC += doc/inet_switch_req.c
BRCM_COMP_APP_SRC += os/platform/switch/inet_switch.c
BRCM_COMP_APP_SRC += os/erika/inet_osil.c
endif
endif

ifeq ($(CHIP_FAMILY),bcm8908x)
BRCM_COMP_LIB_CFLAGS += -DDHCP_RENEW_REBIND_SUPPORT
BRCM_COMP_LIB_CFLAGS += -DINET_MAX_REASS_BUF_SIZE=1600U
ifeq ($(call isappopt, ENABLE_DEFAULT_INET_CFG), yes)
BRCM_COMP_APP_SRC += os/platform/bcm8908x/inet_cfg.c
endif # ENABLE_DEFAULT_INET_CFG
BRCM_COMP_APP_SRC += os/platform/bcm8908x/inet_switch.c
BRCM_COMP_REQ_SRC += doc/inet_bcm8908x_req.c
BRCM_COMP_APP_SRC += os/erika/inet_osil.c
endif


ifeq ($(CHIP_FAMILY),bcm8958x)
BRCM_COMP_LIB_CFLAGS += -DINET_MAX_REASS_BUF_SIZE=1500U
ifeq ($(ENABLE_ETH_SWITCH), TRUE)
BRCM_COMP_APP_SRC += os/platform/switch/inet_switch.c
endif
BRCM_COMP_APP_SRC += os/erika/inet_osil.c
ifeq ($(call isappopt, ENABLE_DEFAULT_INET_CFG), yes)
BRCM_COMP_APP_SRC += os/platform/switch/inet_cfg.c
endif # ENABLE_DEFAULT_INET_CFG
endif


ifneq ($(call isappopt,ENABLE_ETHER_TEST),yes)
BRCM_COMP_APP_SRC    += os/inet_module_osil.c
BRCM_COMP_APP_CFLAGS += -DINET_TIMER_EVENT=SystemEvent3
BRCM_COMP_APP_CFLAGS += -DINET_UDP_RX_EVENT=UDP_RxEvent
BRCM_COMP_APP_CFLAGS += -DINET_UDP_TX_EVENT=UDP_TxEvent
BRCM_COMP_APP_CFLAGS += -DINET_TCP_CTRL_EVENT=SystemEvent16

ifeq ($(call isappopt,ENABLE_DHCP),yes)
BRCM_COMP_APP_CFLAGS += -DENABLE_DHCP
ifeq ($(call isappopt,ENABLE_DHCP_TEST),yes)
BRCM_COMP_APP_CFLAGS += -DENABLE_DHCP_TEST
endif#ENABLE_DHCP_TEST
endif#ENABLE_DHCP
endif#ENABLE_ETHER_TEST

ifneq ($(call isappopt,ENABLE_DHCP_TEST),yes)
ifneq ($(call isappopt,INET_TEST),yes)
BRCM_COMP_APP_CFLAGS += -DINET_EVENT_PROCESS_TASK=ETHERNET_Task
endif#INET_TEST
endif#ENABLE_DHCP_TEST

BRCM_COMP_APP_ALARM           += INET_Timer_Alarm
INET_Timer_Alarm.counter      := SystemTimer
INET_Timer_Alarm.callback     := INET_Timer_AlarmCb
INET_Timer_Alarm.declaration  := inet_osil.h
INET_Timer_Alarm.autostart    := true
INET_Timer_Alarm.alarmtime    := 1
INET_Timer_Alarm.cycletime    := 1

BRCM_COMP_NAME := inet
BRCM_COMP_DEPENDS := time nif ethutils
BRCM_COMP_TYPE := lib
