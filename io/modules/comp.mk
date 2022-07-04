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

##  @defgroup grp_iom IO Module
#   @ingroup grp_inout
#
#   @addtogroup grp_iom
#   @{
#   @file io/modules/io/comp.mk
#   @brief Makefile for IO Module
#   @version 0.1 Initial version
#   @}

BRCM_COMP_NAME := iom
BRCM_COMP_TYPE := lib
BRCM_COMP_DEPENDS := pinmuxdrv

BRCM_COMP_REQ_SRC += doc/io_module_req.c

BRCM_COMP_EXPORT_HDR += inc/osil/io_module_osil.h

BRCM_COMP_LIB_SRC += lib/io_module.c
BRCM_COMP_APP_SRC += os/io_module_osil.c

BRCM_COMP_UAPP_SRC += platform/$(CHIP_FAMILY)/iom_cfg.c

ifeq ($(ENABLE_GPIO_GIO_V1), TRUE)
BRCM_COMP_LIB_CFLAGS += -DENABLE_GPIO_GIO_V1
BRCM_COMP_LIB_CFLAGS += -DENABLE_IOM_GPIO_MONITOR
BRCM_COMP_LIB_CFLAGS += -DIOM_MONITOR_GPIO=GPIO_CHANNEL_5
endif
ifeq ($(ENABLE_GPIO_GIO_V2), TRUE)
BRCM_COMP_LIB_CFLAGS += -DENABLE_GPIO_GIO_V2
endif

ifeq ($(call isappopt, ENABLE_IOM_GPIO_MONITOR), yes)
BRCM_COMP_DEPENDS += time
BRCM_COMP_APP_CFLAGS += -DIOM_GPIO_EVENT=SystemEvent0

BRCM_COMP_APP_ALARM += IOM_GpioTimer
IOM_GpioTimer.counter := SystemTimer
IOM_GpioTimer.callback := IOM_AlarmCb
IOM_GpioTimer.declaration := io_module_osil.h
IOM_GpioTimer.autostart := true
IOM_GpioTimer.alarmtime := 320
IOM_GpioTimer.cycletime := 320
endif

