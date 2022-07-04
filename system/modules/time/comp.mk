#
# Copyright 2016-2020 Broadcom Limited.  All rights reserved.
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


##  @defgroup grp_time_utils Time Utilities
#   @ingroup grp_system
#
#   @addtogroup grp_time_utils
#   @{
#   Broadcom SDK provides wrappers for Time APIs
#
#   @limitations None
#   @file system/time/comp.mk
#   @brief Makefile for BCM Time Wrappers
#   @version 0.1 Initial version
#   @}
#

BRCM_COMP_NAME := time
BRCM_COMP_DEPENDS :=
BRCM_COMP_TYPE := lib

BRCM_SRC :=
BRCM_INC :=

BRCM_COMP_REQ_SRC += doc/bcm_time_req.c
BRCM_COMP_EXPORT_HDR := inc/bcm_time.h


BRCM_INC += $(BRCM_SDK_ROOT)/system/include

ifeq ($(ENABLE_AVT), TRUE)
BRCM_COMP_REQ_SRC += doc/time_endpt_req.c
BRCM_COMP_LIB_SRC += lib/time_endpt_module.c
ifeq ($(call isappopt, ENABLE_TIME_MODULE), yes)
BRCM_COMP_APP_SRC += endpt/time_config.c
endif
BRCM_CFLAGS += -DBCM_TIME_USES_AVT
BRCM_COMP_DEPENDS += avtdrv timdrv
BRCM_COMP_LIB_CFLAGS += -DBCM_HRTIMER_CHANID=0UL
BRCM_COMP_LIB_CFLAGS += -DBCM_HRTIMER_EXPIRY_TICKS=500UL
endif

ifeq ($(ENABLE_TIMER_SP804), TRUE)
ifeq ($(BCM_TIME_USES_SP804), TRUE)
BRCM_COMP_REQ_SRC += doc/time_switch_req.c
BRCM_COMP_LIB_SRC += lib/time_switch_module.c
ifeq ($(call isappopt, ENABLE_TIME_MODULE), yes)
BRCM_COMP_APP_SRC += switch/time_config.c
endif
BRCM_CFLAGS += -DBCM_TIME_USES_SP804
BRCM_COMP_DEPENDS += timdrv
BRCM_COMP_LIB_CFLAGS += -DTIME_SYSTIMER_CHANID=0UL
ifneq ($(CHIP_FAMILY), bcm8953x)
BRCM_COMP_LIB_CFLAGS += -DTIME_TIMER_CLOCK=TIMER_CLOCK
BRCM_COMP_LIB_CFLAGS += -DTIME_CLK_FROM_DMU=1
else
BRCM_COMP_LIB_CFLAGS += -DTIME_TIMER_CLOCK=6250000UL
endif
BRCM_COMP_LIB_CFLAGS += -DBCM_HRTIMER_CHANID=1UL
BRCM_COMP_LIB_CFLAGS += -DBCM_HRTIMER_EXPIRY_TICKS=62UL
endif
endif

ifeq ($(ENABLE_TIMER_ARC), TRUE)
BRCM_COMP_REQ_SRC += doc/time_switch_req.c
BRCM_COMP_LIB_SRC += lib/time_switch_module.c
ifeq ($(call isappopt, ENABLE_TIME_MODULE), yes)
BRCM_COMP_APP_SRC += switch/time_config.c
endif
BRCM_CFLAGS += -DBCM_TIME_USES_ARC
BRCM_COMP_DEPENDS += timdrv
BRCM_COMP_LIB_CFLAGS += -DTIME_SYSTIMER_CHANID=0UL
BRCM_COMP_LIB_CFLAGS += -DTIME_TIMER_CLOCK=$(BRCM_CPU_FREQUENCY)
endif


BRCM_COMP_LIB_CFLAGS += -DTIME_SYS_TICK_US=3125UL

BRCM_COMP_APP_COUNTER += SystemTimer
SystemTimer.mincycle := 1
SystemTimer.maxallowedvalue := 2147483647
SystemTimer.ticksperbase := 1
SystemTimer.secondspertick := 1

BRCM_COMP_APP_COUNTER += HRTimer
HRTimer.mincycle := 1
HRTimer.maxallowedvalue := 2147483647
HRTimer.ticksperbase := 1
HRTimer.secondspertick := 1

BRCM_COMP_EXPORT_HDR += inc/osil/time_module_osil.h

ifeq ($(call isappopt, ENABLE_TIME_MODULE), yes)
BRCM_COMP_APP_CFLAGS += -DENABLE_TIM_CHANN0_CB
BRCM_COMP_APP_CFLAGS += -DENABLE_TIM_CHANN1_CB
endif

BRCM_COMP_ULIB_SRC += lib/bcm_time.c
BRCM_COMP_IT_SRC += tests/integration/time_it.h
