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

##  @defgroup grp_uartdrv UART Driver
#   @ingroup grp_system
#
#   @addtogroup grp_uartdrv
#   @{
#   @file drivers/uart/comp.mk
#   @brief Makefile for UART Driver
#   @version 0.1 Initial version
#   @}

BRCM_COMP_NAME := uartdrv
BRCM_COMP_DEPENDS :=
BRCM_COMP_TYPE := lib

BRCM_COMP_APP_CFLAGS += -DENABLE_UART_PL011

ifeq ($(call isappopt,ENABLE_UART0),yes)
BRCM_COMP_APP_INTR += UART0
UART0.function = UART_IRQHandler0
UART0.declaration = uart_osil.h
ifneq (,$(filter $(CHIP_FAMILY),bcm8908x bcm8910x))
UART0.irqnum = 65
else ifeq ($(CHIP_FAMILY), bcm8953x)
UART0.irqnum = 2
else ifeq ($(CHIP_FAMILY), bcm8956x)
UART0.irqnum = 10
else ifeq ($(CHIP_FAMILY), bcm8957x)
UART0.irqnum = 10
endif
endif

ifeq ($(call isappopt,ENABLE_UART1),yes)
BRCM_COMP_APP_INTR += UART1
UART1.function = UART_IRQHandler1
UART1.declaration = uart_osil.h
ifneq (,$(filter $(CHIP_FAMILY),bcm8908x bcm8910x))
UART1.irqnum = 66
endif
endif

ifeq ($(call isappopt,ENABLE_UART2),yes)
BRCM_COMP_APP_INTR += UART2
UART2.function = UART_IRQHandler2
ifneq (,$(filter $(CHIP_FAMILY),bcm8908x bcm8910x))
UART2.irqnum = 67
endif
endif

BRCM_COMP_REQ_SRC += doc/uart_req.c
BRCM_COMP_EXPORT_HDR += inc/uart.h
BRCM_COMP_EXPORT_HDR += inc/osil/uart_osil.h
BRCM_COMP_LIB_SRC += lib/uart.c
BRCM_COMP_LIB_SRC += lib/uart_drv.c
BRCM_COMP_IT_SRC += tests/integration/uart_it.h

BRCM_COMP_APP_SRC += os/erika/uart_osil.c
