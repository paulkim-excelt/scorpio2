#
# Copyright 2016-2022 Broadcom Limited.  All rights reserved.
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



##  @defgroup grp_flashdrv Flash Driver
#   @ingroup grp_nvm
#
#   @addtogroup grp_flashdrv
#   @{
#   @file nvm/drivers/flash/comp.mk
#   @brief Makefile for Flash Driver
#   @features Flash Driver features are:
#             1. Flash driver configuration parameters
#             2. Flash driver operations
#             3. Flash driver state handler
#             4. Flash result indication
#             5. Flash driver kernel interface
#             6. Flash driver kernel handler
#   @version 0.1 Initial version
#   @}

BRCM_COMP_NAME := flashdrv
BRCM_COMP_DEPENDS :=
BRCM_COMP_TYPE := lib

BRCM_COMP_APP_OPT += ENABLE_FLASH
BRCM_COMP_REQ_SRC += doc/flash_req.c
BRCM_COMP_EXPORT_HDR += inc/flash.h
BRCM_COMP_EXPORT_HDR += inc/osil/flash_osil.h
BRCM_COMP_LIB_SRC += lib/flash.c
BRCM_COMP_LIB_SRC += lib/qspi.c

BRCM_COMP_APP_SRC += os/erika/flash_osil.c

ifeq ($(call isappopt,ENABLE_FLASH0),yes)
BRCM_COMP_APP_INTR += QSPI0
QSPI0.function = FLASH_IRQHandler0
QSPI0.declaration = flash_osil.h
ifeq ($(CHIP_FAMILY), bcm8910x)
QSPI0.irqnum = 42
else ifeq ($(CHIP_FAMILY), bcm8953x)
QSPI0.irqnum = 1
else ifeq ($(CHIP_FAMILY), bcm8956x)
QSPI0.irqnum = 9
else ifeq ($(CHIP_FAMILY), bcm8957x)
QSPI0.irqnum = 9
else ifeq ($(CHIP_FAMILY), bcm8908x)
QSPI0.irqnum = 43
endif
endif

BRCM_COMP_UEXPORT_HDR += platform/$(CHIP_FAMILY)/flash_cfg.h
BRCM_COMP_UAPP_SRC += platform/$(CHIP_FAMILY)/flash_cfg.c

ifeq ($(call isappopt,ENABLE_FLASH1),yes)
BRCM_COMP_APP_INTR += QSPI1
ifeq ($(CHIP_FAMILY), bcm8910x)
QSPI1.function = FLASH_IRQHandler1
QSPI1.irqnum = 43
QSPI1.declaration = flash_osil.h
endif
endif
