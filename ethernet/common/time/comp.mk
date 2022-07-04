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


##  @defgroup grp_ethsrv_time Ethernet Time Module
#   @ingroup grp_ethernet
#
#   @addtogroup grp_ethsrv_time
#   @{
#   @file ethernet/common/time/comp.mk
#   @brief Makefile for EthTime module
#   @version 0.1 Initial version
#   @}
#
#

BRCM_INC += $(BRCM_SDK_ROOT)/ethernet/drivers/controller/inc/
BRCM_INC += $(BRCM_SDK_ROOT)/ethernet/common/rpc/inc/
BRCM_INC += $(BRCM_SDK_ROOT)/ethernet/common/ethsrv/inc/
BRCM_INC += $(BRCM_SDK_ROOT)/ethernet/drivers/ipc/inc/
BRCM_INC += $(BRCM_SDK_ROOT)/ethernet/drivers/controller/inc/osil/
BRCM_INC += $(BRCM_SDK_ROOT)/drivers/gpio/inc/
BRCM_INC += $(BRCM_SDK_ROOT)/system/common/inc
BRCM_INC += $(BRCM_SDK_ROOT)/system/common/inc/osil
BRCM_INC += $(BRCM_SDK_ROOT)/system/imgl/inc
BRCM_INC += $(BRCM_SDK_ROOT)/nvm/service/inc
BRCM_INC += $(BRCM_SDK_ROOT)/system/wds/inc

BRCM_COMP_EXPORT_HDR += inc/ettm.h
BRCM_COMP_EXPORT_HDR += inc/osil/ettm_osil.h
BRCM_COMP_REQ_SRC += doc/ettm_req.c
BRCM_COMP_LIB_SRC += lib/ettm_time.c
BRCM_COMP_LIB_CFLAGS += -DETTM_TIMESTAMP_EVENT=SystemEvent2
BRCM_COMP_LIB_CFLAGS += -DETTM_MASTER_FRMSYNC_EVENT=SystemEvent13
BRCM_COMP_LIB_INC += inc/osil/ettm_platform.h
BRCM_COMP_APP_INC += inc/osil/ettm_platform.h
BRCM_COMP_APP_SRC += os/ettm_time_osil.c

ifeq ($(CHIP_FAMILY),bcm8908x)
BRCM_COMP_REQ_SRC += doc/ettm_avt_req.c
BRCM_COMP_APP_SRC += os/platform/avt/ettm_platform.c
endif

ifeq ($(CHIP_FAMILY),bcm8910x)
BRCM_COMP_REQ_SRC += doc/ettm_avt_req.c
BRCM_COMP_APP_SRC += os/platform/avt/ettm_platform.c
endif

ifeq ($(CHIP_FAMILY),bcm8953x)
BRCM_COMP_LIB_CFLAGS += -DETTM_ENABLE_SWT_CODE
BRCM_COMP_REQ_SRC += doc/ettm_bcm8953x_req.c
BRCM_COMP_APP_SRC += os/platform/bcm8953x/ettm_platform.c
ifeq ($(call isappopt,__BCM89531_LS_EVK__),yes)
BRCM_COMP_APP_CFLAGS += -DETTM_TIMESYNC_MODE=ETHER_TIMESYNC_EXTERNAL
else
BRCM_COMP_APP_CFLAGS += -DETTM_TIMESYNC_MODE=ETHER_TIMESYNC_INTERNAL
endif
endif

ifeq ($(CHIP_FAMILY),bcm8956x)
BRCM_COMP_LIB_CFLAGS += -DETTM_ENABLE_SWT_CODE
BRCM_COMP_REQ_SRC += doc/ettm_syncpin_req.c
BRCM_COMP_APP_SRC += os/platform/syncpin/ettm_platform.c
ifeq ($(call isappopt,__BCM89564G_EVK__),yes)
BRCM_COMP_APP_CFLAGS += -DETTM_TIMESYNC_MODE=ETHER_TIMESYNC_EXTERNAL
else
BRCM_COMP_APP_CFLAGS += -DETTM_TIMESYNC_MODE=ETHER_TIMESYNC_INTERNAL
endif
endif

ifeq ($(CHIP_FAMILY),bcm8957x)
BRCM_COMP_LIB_CFLAGS += -DETTM_ENABLE_SWT_CODE
BRCM_COMP_REQ_SRC += doc/ettm_syncpin_req.c
BRCM_COMP_APP_SRC += os/platform/syncpin/ettm_platform.c
BRCM_COMP_APP_CFLAGS += -DETTM_TIMESYNC_MODE=ETHER_TIMESYNC_INTERNAL
endif

BRCM_COMP_APP_ALARM += ETTM_PeriodicAlarm
ETTM_PeriodicAlarm.counter = SystemTimer
ETTM_PeriodicAlarm.callback = ETTM_PeriodicAlarmCb
ETTM_PeriodicAlarm.declaration = ettm_osil.h
ETTM_PeriodicAlarm.autostart = true
ETTM_PeriodicAlarm.alarmtime = 1
ETTM_PeriodicAlarm.cycletime = 1

BRCM_COMP_NAME := ettm
BRCM_COMP_DEPENDS := ethcntlr abstract ethernet
BRCM_COMP_TYPE := lib
