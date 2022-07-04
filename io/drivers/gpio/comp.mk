#
# Copyright 2016-2021 Broadcom Limited.  All rights reserved.
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



##  @defgroup grp_gpiodrv GPIO Driver
#   @ingroup grp_inout
#
#   @addtogroup grp_gpiodrv
#   @{
#   @file drivers/gpio/comp.mk
#   @brief Makefile for GPIO Driver
#   @version 0.1 Initial version
#   @}


BRCM_COMP_NAME := gpiodrv
BRCM_COMP_DEPENDS :=
BRCM_COMP_TYPE := lib

BRCM_SRC :=
BRCM_CFLAGS :=
BRCM_INC += $(BRCM_SDK_ROOT)/io/drivers/pinmux/inc
BRCM_INC += $(BRCM_SDK_ROOT)/io/drivers/pinmux/inc/osil


BRCM_COMP_EXPORT_HDR += inc/gpio.h
BRCM_COMP_EXPORT_HDR += inc/osil/gpio_osil.h

BRCM_COMP_REQ_SRC += doc/gpio_req.c

ifeq ($(ENABLE_GPIO_GIO_V1), TRUE)
BRCM_COMP_ULIB_SRC += lib/gpio.c
BRCM_COMP_ULIB_SRC += lib/gpio_gio_v1.c
BRCM_COMP_UAPP_SRC += os/erika/gpio_osil.c
BRCM_CFLAGS += -DENABLE_GPIO_GIO_V1
endif

ifeq ($(ENABLE_GPIO_GIO_V2), TRUE)
BRCM_COMP_LIB_SRC += lib/gpio.c
BRCM_COMP_LIB_SRC += lib/gpio_drv_v2.c
BRCM_COMP_APP_SRC += os/erika/gpio_osil.c
BRCM_CFLAGS += -DENABLE_GPIO_GIO_V2
endif

ifeq ($(CHIP_FAMILY), bcm8953x)
BRCM_COMP_LIB_CFLAGS += -DGPIO_MAX_CHANNELS=9UL
endif

ifeq ($(CHIP_FAMILY),bcm8910x)
BRCM_COMP_APP_INTR += GPIO0 GPIO1
GPIO0.function     := GPIO_IRQ0Handler
GPIO0.declaration  := gpio_osil.h
GPIO1.function     := GPIO_IRQ1Handler
GPIO1.declaration  := gpio_osil.h
GPIO0.irqnum        = 33
GPIO1.irqnum        = 34
endif

ifeq ($(ENABLE_GPIO_GIO_V1), TRUE)
ifeq ($(CHIP_FAMILY),bcm8956x)
BRCM_COMP_LIB_CFLAGS += -DGPIO_MAX_CHANNELS=9UL
BRCM_COMP_APP_INTR += GPIO1
GPIO1.function := GPIO_IRQ1Handler
GPIO1.declaration := gpio_osil.h
GPIO1.irqnum = 20
endif

ifeq ($(CHIP_FAMILY),bcm8957x)
BRCM_COMP_LIB_CFLAGS += -DGPIO_MAX_CHANNELS=9UL
BRCM_COMP_APP_INTR += GPIO1
GPIO1.function := GPIO_IRQ1Handler
GPIO1.declaration := gpio_osil.h
GPIO1.irqnum = 20
endif
endif

ifeq ($(CHIP_FAMILY),bcm8908x)
BRCM_COMP_APP_INTR += GPIO0 GPIO1
GPIO0.function     := GPIO_IRQ0Handler
GPIO0.declaration  := gpio_osil.h
GPIO1.function     := GPIO_IRQ1Handler
GPIO1.declaration  := gpio_osil.h
GPIO0.irqnum = 33
GPIO1.irqnum = 34
endif
