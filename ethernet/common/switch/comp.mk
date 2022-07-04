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


##  @defgroup grp_ethsrv_swt Ethsrv Switch
#   @ingroup grp_ethernet
#
#   @addtogroup grp_ethsrv_swt
#   @{
#
#   @file ethernet/common/switch/comp.mk
#   @brief Makefile for Ethsrv Switch
#   @version 0.1 Initial version
#   @}
#
#

BRCM_INC += $(BRCM_SDK_ROOT)/system/service/inc
BRCM_INC += $(BRCM_SDK_ROOT)/system/service/inc/osil
BRCM_INC += $(BRCM_SDK_ROOT)/ethernet/drivers/controller/inc

BRCM_COMP_REQ_SRC    += doc/ethswtm_core_req.c
BRCM_COMP_REQ_SRC    += doc/ethswtm_config_req.c

BRCM_COMP_EXPORT_HDR += inc/ethswtm_core.h
BRCM_COMP_EXPORT_HDR += inc/ethswtm_config.h
BRCM_COMP_EXPORT_HDR += inc/osil/ethswtm_core_osil.h
BRCM_COMP_APP_SRC    += os/ethswtm_core_osil.c
BRCM_COMP_LIB_SRC    += lib/ethswtm_core.c

BRCM_COMP_LIB_CFLAGS += -DETHSWTM_CONFIG=ETHSWTM_Config

#SUB MODULES - Library configuration
ifeq ($(ENABLE_ETHSWTM_VLAN_LIB), TRUE)
BRCM_COMP_LIB_CFLAGS += -DENABLE_ETHSWTM_VLAN_LIB
BRCM_COMP_LIB_CFLAGS += -DETHSWTM_VLAN_CFG=ETHSWTM_Config.vlanCfg
BRCM_COMP_REQ_SRC    += doc/ethswtm_vlan_req.c
BRCM_COMP_EXPORT_HDR += inc/ethswtm_vlan.h
BRCM_COMP_LIB_SRC    += lib/ethswtm_vlan.c
BRCM_COMP_EXPORT_HDR += inc/osil/ethswtm_vlan_osil.h
BRCM_COMP_APP_SRC    += os/ethswtm_vlan_osil.c
endif

ifeq ($(ENABLE_ETHSWTM_EXT_LIB), TRUE)
BRCM_COMP_LIB_CFLAGS += -DENABLE_ETHSWTM_EXT_LIB
BRCM_COMP_LIB_CFLAGS += -DETHSWTM_EXT_CFG=ETHSWTM_Config.extCfg
BRCM_COMP_REQ_SRC    += doc/ethswtm_ext_req.c
BRCM_COMP_EXPORT_HDR += inc/ethswtm_ext.h
BRCM_COMP_LIB_SRC    += lib/ethswtm_ext.c
BRCM_COMP_EXPORT_HDR += inc/osil/ethswtm_ext_osil.h
ifeq ($(ENABLE_RPC_V2), TRUE)
BRCM_COMP_APP_SRC    += os/ethswtm_ext_rpc_osil.c
else
BRCM_COMP_APP_SRC    += os/ethswtm_ext_osil.c
endif #ENABLE_RPC_V2
endif

ifeq ($(ENABLE_ETHSWTM_ARL_LIB), TRUE)
BRCM_COMP_LIB_CFLAGS += -DENABLE_ETHSWTM_ARL_LIB
BRCM_COMP_LIB_CFLAGS += -DETHSWTM_ARL_CFG=ETHSWTM_Config.arlCfg
BRCM_COMP_REQ_SRC    += doc/ethswtm_arl_req.c
BRCM_COMP_EXPORT_HDR += inc/ethswtm_arl.h
BRCM_COMP_EXPORT_HDR += inc/osil/ethswtm_arl_osil.h
BRCM_COMP_LIB_SRC    += lib/ethswtm_arl.c

ifeq ($(call isappopt,ENABLE_ETHSWTM_ARL_APP),yes)
BRCM_COMP_APP_CFLAGS += -DETHSWTM_ARLMODULE=ETHSWTM_ARLModule
BRCM_COMP_APP_SRC    += os/ethswtm_arl_osil.c
endif #ARL_APP

#CFP depends on ARL
ifeq ($(ENABLE_ETHSWTM_CFP_LIB), TRUE)
BRCM_COMP_LIB_CFLAGS += -DENABLE_ETHSWTM_CFP_LIB
BRCM_COMP_LIB_CFLAGS += -DETHSWTM_CFPSTREAMPOLICER_CFG=ETHSWTM_Config.streamPolicerCfg
BRCM_COMP_REQ_SRC    += doc/ethswtm_cfp_req.c
BRCM_COMP_EXPORT_HDR += inc/ethswtm_cfp.h
BRCM_COMP_EXPORT_HDR += inc/osil/ethswtm_cfp_osil.h
BRCM_COMP_LIB_SRC    += lib/ethswtm_cfp.c

ifeq ($(call isappopt,ENABLE_ETHSWTM_CFP_APP),yes)
BRCM_COMP_APP_ALARM += ETHSWTM_CFPStreamMonitorAlarm
ETHSWTM_CFPStreamMonitorAlarm.counter = SystemTimer
ETHSWTM_CFPStreamMonitorAlarm.callback = ETHSWTM_CFPStreamMonitorAlarmCb
ETHSWTM_CFPStreamMonitorAlarm.declaration = ethswtm_cfp_osil.h
ETHSWTM_CFPStreamMonitorAlarm.autostart = false
ETHSWTM_CFPStreamMonitorAlarm.alarmtime = 0
ETHSWTM_CFPStreamMonitorAlarm.cycletime = 0
BRCM_COMP_APP_CFLAGS += -DETHSWTM_CFPMODULE=ETHSWTM_CFPModule
BRCM_COMP_APP_SRC    += os/ethswtm_cfp_osil.c
ifeq ($(ENABLE_RPC_V2), TRUE)
BRCM_COMP_APP_SRC    += os/ethswtm_cfp_rpcv2_osil.c
else
BRCM_COMP_APP_SRC    += os/ethswtm_cfp_rpc_osil.c
endif #ENABLE_RPC_V2
endif # CFP_APP
endif # CFP
endif # ARL

ifeq ($(ENABLE_ETHSWTM_FA_LIB), TRUE)
BRCM_COMP_LIB_CFLAGS += -DENABLE_ETHSWTM_FA_LIB
BRCM_COMP_REQ_SRC    += doc/ethswtm_fa_req.c
BRCM_COMP_EXPORT_HDR += inc/ethswtm_fa.h
BRCM_COMP_EXPORT_HDR += inc/osil/ethswtm_fa_osil.h
BRCM_COMP_LIB_SRC    += lib/ethswtm_fa.c

ifeq ($(call isappopt,ENABLE_ETHSWTM_FA_APP),yes)
BRCM_COMP_APP_ALARM += ETHSWTM_FAOneSecAlarm
ETHSWTM_FAOneSecAlarm.counter = SystemTimer
ETHSWTM_FAOneSecAlarm.callback = ETHSWTM_FAOneSecAlarmCb
ETHSWTM_FAOneSecAlarm.declaration = ethswtm_fa_osil.h
ETHSWTM_FAOneSecAlarm.autostart = false
ETHSWTM_FAOneSecAlarm.alarmtime = 320
ETHSWTM_FAOneSecAlarm.cycletime = 320
BRCM_COMP_APP_CFLAGS += -DETHSWTM_FAONESECALARM_CYCLE=320UL
BRCM_COMP_APP_CFLAGS += -DETHSWTM_FAMODULE=ETHSWTM_FAModule
BRCM_COMP_APP_SRC    += os/ethswtm_fa_osil.c
endif#FA_APP
endif

ifeq ($(ENABLE_ETHSWTM_DEBUG_LIB), TRUE)
BRCM_COMP_LIB_CFLAGS += -DENABLE_ETHSWTM_DEBUG_LIB
BRCM_COMP_REQ_SRC    += doc/ethswtm_debug_req.c
BRCM_COMP_EXPORT_HDR += inc/ethswtm_debug.h
BRCM_COMP_LIB_SRC    += lib/ethswtm_debug.c
BRCM_COMP_EXPORT_HDR += inc/osil/ethswtm_debug_osil.h
BRCM_COMP_APP_SRC    += os/ethswtm_debug_osil.c
endif
#End SUB MODULES - Library configuration


#SUB MODULES - APP configuration
BRCM_COMP_APP_CFLAGS += -DETHSWTM_COREMODULE=ETHSWTM_CoreModule
ifeq ($(call isappopt,ENABLE_ETHSWTM_VLAN_APP),yes)
BRCM_COMP_APP_CFLAGS += -DETHSWTM_VLANMODULE=ETHSWTM_VLANModule
endif
ifeq ($(call isappopt,ENABLE_ETHSWTM_EXT_APP),yes)
BRCM_COMP_APP_CFLAGS += -DETHSWTM_EXTMODULE=ETHSWTM_ExtModule
BRCM_COMP_DEPENDS += ethxcvrm
endif
ifeq ($(call isappopt,ENABLE_ETHSWTM_DEBUG_APP),yes)
BRCM_COMP_APP_CFLAGS += -DETHSWTM_DEBUGMODULE=ETHSWTM_DebugModule
endif
#END SUB MODULES - APP configuration

ifeq ($(CHIP_FAMILY),bcm8953x)
BRCM_COMP_HOST_CFLAGS += -DHOST_MAX_NUM_PORTS=8
else ifeq ($(CHIP_FAMILY),bcm8956x)
BRCM_COMP_HOST_CFLAGS += -DHOST_MAX_NUM_PORTS=14
else ifeq ($(CHIP_FAMILY),bcm8957x)
BRCM_COMP_HOST_CFLAGS += -DHOST_MAX_NUM_PORTS=14
else ifeq ($(CHIP_FAMILY),x86)
BRCM_COMP_HOST_CFLAGS += -DHOST_MAX_NUM_PORTS=14
endif

BRCM_COMP_NAME := ethswtm
BRCM_COMP_DEPENDS := ethcntlr ethutils ethernet
ifneq (,$(findstring $(CHIP_FAMILY),bcm8953x bcm8956x bcm8957x))
BRCM_COMP_DEPENDS += ethswitch
endif
BRCM_COMP_TYPE := lib
