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


##  @defgroup grp_timdrv Timer Driver
#   @ingroup grp_system
#
#   @addtogroup grp_timdrv
#   @{
#   @file drivers/timer/comp.mk
#   @brief Makefile for Timer Driver
#   @version 0.1 Initial version
#   @}

BRCM_COMP_NAME := timdrv
BRCM_COMP_DEPENDS :=
BRCM_COMP_TYPE := lib

BRCM_COMP_REQ_SRC += doc/tim_req.c
BRCM_COMP_EXPORT_HDR += inc/tim.h
BRCM_COMP_EXPORT_HDR += inc/osil/tim_osil.h
BRCM_COMP_LIB_SRC += lib/tim.c

ifeq ($(cpu),em22fs)
BRCM_COMP_REQ_SRC += doc/tim_arc_req.c
BRCM_COMP_LIB_SRC += lib/arc_tim.c
BRCM_COMP_APP_OPT += ENABLE_TIMER_ARC
else
BRCM_COMP_LIB_SRC += lib/sp804.c
BRCM_COMP_APP_OPT += ENABLE_TIMER_SP804
endif

BRCM_COMP_APP_INTR += TIMER0 TIMER1
TIMER0.function = TIM_IRQHandler0
TIMER0.declaration = tim_osil.h
TIMER1.function = TIM_IRQHandler1
TIMER1.declaration = tim_osil.h

BRCM_COMP_APP_SRC += os/erika/tim_osil.c

BRCM_COMP_IT_SRC += tests/qualification/timer_qt.h
BRCM_COMP_IT_SRC += tests/qualification/timer_mt.h
ifeq ($(ENABLE_INTEGRATION_TEST), TRUE)
BRCM_COMP_IT_SRC += tests/integration/timer_it.h
endif
ifeq ($(ENABLE_COVERAGE_TEST), TRUE)
BRCM_COMP_IT_SRC += tests/coverage/timer_pt.h
endif

ifneq (,$(filter $(CHIP_FAMILY),bcm8908x bcm8910x))
TIMER0.irqnum = 52
TIMER1.irqnum = 53
else ifeq ($(CHIP_FAMILY), bcm8953x)
TIMER0.irqnum = 3
TIMER1.irqnum = 4
else ifneq (,$(filter $(CHIP_FAMILY),bcm8956x bcm8957x))
TIMER0.irqnum = 12
TIMER1.irqnum = 13
else ifeq ($(CHIP_FAMILY), bcm8958x)
ifeq ($(cpu),em22fs)
TIMER0.irqnum = 16
TIMER1.irqnum = 17
else
TIMER0.irqnum = 9
TIMER1.irqnum = 10
endif
endif

