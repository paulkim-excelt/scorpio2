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
#    OF THE AMOUNT ACTUALLY PAID FOR THE SOFTWARE ITSELF OR U.S. \$1, WHICHEVER
#    IS GREATER. THESE LIMITATIONS SHALL APPLY NOTWITHSTANDING ANY FAILURE OF
#    ESSENTIAL PURPOSE OF ANY LIMITED REMEDY.
#
####################################################################################

##  @defgroup grp_mcudrv MCU Driver
#   @ingroup grp_system
#
#   @addtogroup grp_mcudrv
#   @{
#
#   @file drivers/mcu/comp.mk
#   @brief Makefile for MCU Driver
#   @version 0.1 Initial version
#   @}

BRCM_COMP_NAME := mcudrv
BRCM_COMP_DEPENDS := system
BRCM_COMP_TYPE := lib

ifeq ($(ENABLE_FLASH0), TRUE)
BRCM_COMP_LIB_CFLAGS += -DENABLE_FLASH0
endif
ifeq ($(ENABLE_FLASH1), TRUE)
BRCM_COMP_LIB_CFLAGS += -DENABLE_FLASH1
endif

BRCM_COMP_REQ_SRC += doc/mcu_req.c

BRCM_COMP_EXPORT_HDR += inc/mcu.h
BRCM_COMP_EXPORT_HDR += inc/osil/mcu_osil.h
BRCM_COMP_EXPORT_HDR += inc/mcu_clk.h
BRCM_COMP_LIB_SRC += lib/mcu.c

BRCM_COMP_APP_SRC += os/erika/mcu_osil.c
BRCM_COMP_EXPORT_HDR += inc/mcu_pad_cntrl.h

ifeq ($(CHIP_FAMILY),bcm8910x)
BRCM_COMP_REQ_SRC += doc/mcu_v1_req.c
BRCM_COMP_EXPORT_HDR += inc/mcu_hs_ext.h
BRCM_COMP_EXPORT_HDR += inc/osil/mcu_v1_osil.h
BRCM_COMP_LIB_SRC += lib/bcm8910x/mcu_pad_cntrl.c
BRCM_COMP_LIB_SRC += lib/bcm8910x/mcu_clk_cfg.c
BRCM_COMP_LIB_SRC += lib/mcu_drv_v1.c
BRCM_COMP_LIB_SRC += lib/mcu_hs_ext.c
BRCM_COMP_LIB_SRC += lib/mcu_endpt_ext.c
BRCM_COMP_DEPENDS += avtdrv
endif

ifeq ($(CHIP_FAMILY),bcm8953x)
BRCM_COMP_REQ_SRC += doc/bcm8953x/mcu_req.c
BRCM_COMP_EXPORT_HDR += inc/mcu_switch_ext.h
BRCM_COMP_EXPORT_HDR += inc/osil/mcu_switch_osil.h
BRCM_COMP_LIB_SRC += lib/mcu_switch_ext.c
BRCM_COMP_LIB_SRC += lib/bcm8953x/mcu_drv.c
BRCM_COMP_EXPORT_HDR += lib/bcm8953x/cfg.h
BRCM_COMP_LIB_SRC += lib/bcm8953x/cfg.c
BRCM_COMP_EXPORT_HDR += lib/bcm8953x/dmu.h
BRCM_COMP_LIB_SRC += lib/bcm8953x/dmu.c
endif

ifeq ($(CHIP_FAMILY),bcm8956x)
BRCM_COMP_REQ_SRC += doc/bcm8956x/mcu_req.c
BRCM_COMP_EXPORT_HDR += inc/mcu_switch_ext.h
BRCM_COMP_EXPORT_HDR += inc/osil/mcu_switch_osil.h
BRCM_COMP_LIB_SRC += lib/mcu_switch_ext.c
BRCM_COMP_LIB_SRC += lib/bcm8956x/mcu_drv.c
endif

ifeq ($(CHIP_FAMILY),bcm8957x)
BRCM_COMP_REQ_SRC += doc/bcm8957x/mcu_req.c
BRCM_COMP_EXPORT_HDR += inc/mcu_switch_ext.h
BRCM_COMP_EXPORT_HDR += inc/osil/mcu_switch_osil.h
BRCM_COMP_LIB_SRC += lib/mcu_switch_ext.c
BRCM_COMP_LIB_SRC += lib/bcm8957x/mcu_drv.c
endif

ifeq ($(CHIP_FAMILY),bcm8908x)
BRCM_COMP_REQ_SRC += doc/mcu_v1_req.c
BRCM_COMP_EXPORT_HDR += inc/mcu_hs_ext.h
BRCM_COMP_EXPORT_HDR += inc/osil/mcu_v1_osil.h
BRCM_COMP_LIB_SRC += lib/bcm8908x/mcu_clk_cfg.c
BRCM_COMP_LIB_SRC += lib/mcu_drv_v1.c
BRCM_COMP_LIB_SRC += lib/mcu_hs_ext.c
BRCM_COMP_LIB_SRC += lib/mcu_endpt_ext.c
BRCM_COMP_DEPENDS += avtdrv
endif

ifeq ($(CHIP_FAMILY),bcm8958x)
BRCM_COMP_REQ_SRC += doc/bcm8958x/mcu_req.c
BRCM_COMP_EXPORT_HDR += inc/mcu_switch_ext.h
BRCM_COMP_EXPORT_HDR += inc/osil/mcu_switch_osil.h
BRCM_COMP_LIB_SRC += lib/mcu_switch_ext.c
ifeq ($(cpu),m7)
BRCM_COMP_LIB_SRC += lib/bcm8958x/mcu_drv.c
else
BRCM_COMP_LIB_SRC += lib/bcm8958x/mcu_arc_drv.c
endif
endif
