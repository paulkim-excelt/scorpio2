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
################################################################################


##  @defgroup grp_ets Ethernet TimeSync (ETS)
#   @ingroup grp_ethernet
#
#   @addtogroup grp_ets
#   @{
#   @file ethernet/802.1as/comp.mk
#   @section sec_ets_overview Overview
#   @image html etslib_overview.png "Component Overview"
#
#   This Module contains requirements, Interface, Design and implementation
#   details of ETS
#   <BR>
#   The Ethernet TimeSync (ETS) library provides time-of-day synchronization
#   over Ethernet. It supports operation in both end point (single port) and
#   bridge (multi-port) modes with the following features:
#       - PDELAY operation
#           -# Computation of peer delay and neighbor rate ratio.
#           -# Response to requests from the peer
#           -# Transition from initial to operational PDELAY intervals
#       - SYNC operation:
#           -# Distribution of time in grandmaster mode
#           -# Synchronization to received time in end point slave mode
#           -# Propagation of time in switch slave mode
#           -# Computation of grandmaster rate ratio in slave mode
#           -# Transition from initial to operational SYNC intervals in end
#              point slave mode
#       - SIGNALING operation:
#           -# Transmission of signaling message in slave mode, to request for
#              change in interval
#           -# Honoring received signaling messages in master mode and changing
#              transmission interval accordingly
#           -# Propagation of signaling requests from master to slave ports in
#              switch slave mode
#       - NETWORK CLOCK operation:
#           -# Provision of network time to clients in both master and slave
#              modes
#           -# Setting of global time in master mode
#
#   @brief Makefile for ETS
#   @version 0.1 Initial version
#   @}
#

BRCM_COMP_REQ_SRC += doc/ets_req.c
BRCM_COMP_EXPORT_HDR += inc/ets.h
BRCM_COMP_EXPORT_HDR += inc/ets_config.h
BRCM_COMP_EXPORT_HDR += inc/osil/etsm.h
BRCM_COMP_EXPORT_HDR += inc/osil/ets_osil.h
BRCM_COMP_EXPORT_HDR += inc/osil/ets_sm.h
BRCM_COMP_EXPORT_HDR += inc/osil/ets_pdu.h
BRCM_COMP_LIB_SRC += lib/ets_api.c
BRCM_COMP_LIB_SRC += lib/ets_utils.c
BRCM_COMP_LIB_SRC += lib/ets_pdelay_core.c
BRCM_COMP_LIB_SRC += lib/ets_sync_core.c
BRCM_COMP_LIB_SRC += lib/ets_signaling_core.c
BRCM_COMP_LIB_INC += lib/include/ets_utils.h
BRCM_COMP_LIB_INC += lib/include/ets_sync.h
BRCM_COMP_LIB_INC += lib/include/ets_sync_core.h
BRCM_COMP_LIB_INC += lib/include/ets_pdelay.h
BRCM_COMP_LIB_INC += lib/include/ets_pdelay_core.h
BRCM_COMP_LIB_INC += lib/include/ets_signaling.h
BRCM_COMP_LIB_INC += lib/include/ets_signaling_core.h

ifeq ($(ENABLE_ETS_AVNU_LIB), TRUE)
BRCM_COMP_REQ_SRC += doc/ets_avnu_req.c
BRCM_COMP_LIB_INC += lib/include/ets_signaling_avnu.h
BRCM_COMP_LIB_SRC += lib/ets_smgroup_avnu.c
BRCM_COMP_LIB_SRC += lib/ets_pdelay_avnu.c
BRCM_COMP_LIB_SRC += lib/ets_sync_avnu.c
BRCM_COMP_LIB_SRC += lib/ets_signaling_avnu.c
ifeq ($(call isappopt,ENABLE_ETS_AVNU),yes)
BRCM_COMP_APP_CFLAGS += -DETS_MODULE_AVNU=ETS_SMGroupAvnu
endif
endif

ifeq ($(ENABLE_ETS_IEEE2011_LIB), TRUE)
BRCM_COMP_REQ_SRC += doc/ets_ieee2011_req.c
BRCM_COMP_LIB_INC += lib/include/ets_bmca.h
BRCM_COMP_LIB_INC += lib/include/ets_signaling_ieee2011.h
BRCM_COMP_LIB_SRC += lib/ets_smgroup_ieee2011.c
BRCM_COMP_LIB_SRC += lib/ets_pdelay_ieee2011.c
BRCM_COMP_LIB_SRC += lib/ets_sync_ieee2011.c
BRCM_COMP_LIB_SRC += lib/ets_signaling_ieee2011.c
BRCM_COMP_LIB_SRC += lib/ets_bmca.c
ifeq ($(call isappopt,ENABLE_ETS_IEEE2011),yes)
BRCM_COMP_APP_CFLAGS += -DETS_MODULE_IEEE2011=ETS_SMGroupIeee2011
endif
endif

BRCM_INC += $(BRCM_SDK_ROOT)/ethernet/common/nif/inc
BRCM_INC += $(BRCM_SDK_ROOT)/ethernet/drivers/transceiver/inc
BRCM_INC += $(BRCM_SDK_ROOT)/ethernet/drivers/controller/inc
BRCM_INC += $(BRCM_SDK_ROOT)/ethernet/drivers/mdio/inc
BRCM_INC += $(BRCM_SDK_ROOT)/ethernet/common/rpc/inc
BRCM_INC += $(BRCM_SDK_ROOT)/system/rpc/mem

ifeq ($(ENABLE_ETH_SWITCH), TRUE)
BRCM_COMP_REQ_SRC += doc/ets_switch_req.c
endif

ifeq ($(ENABLE_ETS_RECORDS), TRUE)
BRCM_COMP_LIB_CFLAGS += -DETS_RECORDS
endif

ifeq ($(call isappopt,ENABLE_ETS),yes)
BRCM_COMP_APP_SRC += os/erika/etsm_osil.c
BRCM_COMP_APP_INC += inc/osil/ets_osil_defs.h
BRCM_COMP_APP_SRC += os/common/etsm.c
BRCM_COMP_UAPP_SRC += os/common/ets_shell.c
BRCM_COMP_APP_SRC += os/common/ets_il.c
ifeq ($(ENABLE_ETH_SWITCH), TRUE)
BRCM_COMP_APP_INC += inc/osil/ets_osil_switch.h
BRCM_COMP_APP_SRC += os/common/ets_switch.c
else
BRCM_COMP_APP_SRC += os/common/ets_endpt.c
endif
BRCM_COMP_APP_ALARM += ETSM_TimerAlarm
ETSM_TimerAlarm.counter = SystemTimer
ETSM_TimerAlarm.callback    = ETSM_TimerAlarmCb
ETSM_TimerAlarm.declaration = etsm.h
ETSM_TimerAlarm.autostart = false
ETSM_TimerAlarm.alarmtime = 1
ETSM_TimerAlarm.cycletime = 5
ifeq ($(call isappopt,ENABLE_ETS_AVNU),yes)
BRCM_COMP_APP_CFLAGS += -DETS_MOD_FUNC_TABLE_AVNU=ETS_ModAvnuTbl
endif
endif

BRCM_COMP_NAME := ets
BRCM_COMP_DEPENDS := time nif ethutils ethernet
ifeq ($(ENABLE_ETH_SWITCH), TRUE)
BRCM_COMP_DEPENDS += ethswitch
endif
BRCM_COMP_TYPE := lib

