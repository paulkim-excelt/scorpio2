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
#
####################################################################################

##  @defgroup grp_avb_switch AVB Switch
#   @ingroup grp_applications
#
#   @addtogroup grp_avb_switch
#   @{
#   AVB Switch application provides ethernet L2 switching functionality
#   with gPTP protocol for low latency streaming
#
#   @file applications/avb_switch/comp.mk
#   @brief Makefile for AVB Switch application
#   @version 0.1 Initial version
#   @}
#

BRCM_COMP_APP_SRC  += avb_switch.c

BRCM_COMP_NAME := avb_switch
BRCM_COMP_DEPENDS := ets
BRCM_COMP_TYPE := app

# Application specific macros

BRCM_COMP_APP_CFLAGS += -DENABLE_SHELL_APP=1
BRCM_COMP_APP_OPT += ENABLE_ETS
BRCM_COMP_APP_OPT += ENABLE_ETS_AVNU
BRCM_COMP_APP_OPT += ENABLE_ETHSWTM_EXT_APP
BRCM_COMP_APP_OPT += ENABLE_ETHSWTM_VLAN_APP
BRCM_COMP_APP_OPT += ENABLE_ETHSWTM_ARL_APP
BRCM_COMP_APP_OPT += ENABLE_ETHSWTM_CFP_APP
BRCM_COMP_APP_OPT += ENABLE_ETHSWTM_DEBUG_APP
BRCM_COMP_APP_OPT += ENABLE_SYSTEM_MONITOR
BRCM_COMP_APP_OPT += ENABLE_RECORD_NOTIFICATION

ifneq (,$(findstring $(CHIP_FAMILY),bcm8956x bcm8957x))
BRCM_COMP_APP_OPT += ENABLE_ETHSWTM_FA_APP
endif

# Task details for the application

BRCM_COMP_APP_TASK += AVBSwitch
AVBSwitch.priority = 11
AVBSwitch.autostart = false
AVBSwitch.stack = 2048

# Switch Config
BRCM_COMP_APP_CFG += avb_switch_ethswtm_config
avb_switch_ethswtm_config.pid = 0x5
avb_switch_ethswtm_config.imgid = 0xBC10
avb_switch_ethswtm_config.maxsz = 0x11000
ifeq ($(chip),bcm89564g)
avb_switch_ethswtm_config.file = ethernet/common/switch/config/robo/ethswtm_config_14port.bin
else
avb_switch_ethswtm_config.file = ethernet/common/switch/config/ethswtm_config1.bin
endif

# ETS Config
BRCM_COMP_APP_CFG += avb_switch_ets_config
avb_switch_ets_config.pid = 0x5
avb_switch_ets_config.imgid = 0xBC20
avb_switch_ets_config.maxsz = 0x1000
ifeq ($(chip),bcm89564g)
avb_switch_ets_config.file = ethernet/802.1as/config/robo/ets_switch_14port.bin
else
avb_switch_ets_config.file =  ethernet/802.1as/config/robo/ets_switch_8port.bin
endif

# CFP Config
BRCM_COMP_APP_CFG += avb_switch_ethswtm_cfp_config
avb_switch_ethswtm_cfp_config.pid = 0x5
avb_switch_ethswtm_cfp_config.imgid = 0xBC30
avb_switch_ethswtm_cfp_config.maxsz = 0x8000
ifeq ($(chip),bcm89564g)
avb_switch_ethswtm_cfp_config.file = ethernet/common/switch/config/robo/ethswtm_14port_cfp.bin
else
avb_switch_ethswtm_cfp_config.file = ethernet/common/switch/config/ethswtm_cfp.bin
endif

# FA Config
BRCM_COMP_APP_CFG += avb_switch_ethswtm_fa_config
avb_switch_ethswtm_fa_config.pid = 0x5
avb_switch_ethswtm_fa_config.imgid = 0xBC50
avb_switch_ethswtm_fa_config.maxsz = 0x4000
ifeq ($(chip),bcm89564g)
avb_switch_ethswtm_fa_config.file = ethernet/common/switch/config/robo/ethswtm_fa_config_14port.bin
else
avb_switch_ethswtm_fa_config.file = ethernet/common/switch/config/robo/ethswtm_fa_config_8port.bin
endif

