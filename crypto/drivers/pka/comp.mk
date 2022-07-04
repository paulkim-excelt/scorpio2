#
# Copyright 2019-2022 Broadcom Limited.  All rights reserved.
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

##  @defgroup grp_pka Public key accelerator
#   @ingroup grp_crypto
#
#   @addtogroup grp_pka
#   @{
#   @file security/drivers/pka/comp.mk
#   @brief Makefile for the pka library
#   @version 0.1 Initial version
#   @}
#

BRCM_COMP_REQ_SRC += doc/pka_req.c
BRCM_COMP_EXPORT_HDR += inc/pka_lib.h
BRCM_COMP_EXPORT_HDR += inc/osil/pka_osil.h
BRCM_COMP_QT_SRC += tests/qualification/pka_qt.h

BRCM_COMP_LIB_SRC += lib/pka_lib_entrypts.c
BRCM_COMP_LIB_SRC += lib/pka_ec.c
BRCM_COMP_LIB_SRC += lib/pka_rsa_verify.c
BRCM_COMP_LIB_SRC += lib/pka_ecdsa.c
BRCM_COMP_LIB_SRC += lib/pka_ecdhe.c
BRCM_COMP_LIB_SRC += lib/pka_job_queue.c

BRCM_COMP_LIB_INC += lib/libinc/pka_drv_assert.h
BRCM_COMP_LIB_INC += lib/libinc/pka_hw_ctrl_ifc.h
BRCM_COMP_LIB_INC += lib/libinc/pka_ec.h
BRCM_COMP_LIB_INC += lib/libinc/pka_rsa_verify.h
BRCM_COMP_LIB_INC += lib/libinc/pka_rsa_postops.h
BRCM_COMP_LIB_INC += lib/libinc/pka_ecdsa.h
BRCM_COMP_LIB_INC += lib/libinc/pka_ecdhe.h

BRCM_COMP_APP_SRC += os/erika/pka_osil_erika.c

ifneq (,$(filter $(CHIP_FAMILY),bcm8956x bcm8957x))
BRCM_COMP_LIB_INC += lib/brcm_pka/hwinc/pka_hw_supported_features.h
BRCM_COMP_LIB_INC += lib/brcm_pka/hwinc/pka_hw.h
BRCM_COMP_LIB_INC += lib/brcm_pka/hwinc/pka_ec_hw.h
BRCM_COMP_LIB_INC += lib/brcm_pka/hwinc/pka_mont_hw.h
BRCM_COMP_LIB_INC += lib/brcm_pka/hwinc/pka_rsa_hw.h
BRCM_COMP_LIB_INC += lib/brcm_pka/hwinc/pka_ecdsa_hw.h
BRCM_COMP_LIB_INC += lib/brcm_pka/hwinc/pka_ecdhe_hw.h

BRCM_COMP_LIB_SRC += lib/brcm_pka/pka_hw.c
BRCM_COMP_LIB_SRC += lib/brcm_pka/pka_ec_hw.c
BRCM_COMP_LIB_SRC += lib/brcm_pka/pka_rsa_hw.c
BRCM_COMP_LIB_SRC += lib/brcm_pka/pka_mont_hw.c
BRCM_COMP_LIB_SRC += lib/brcm_pka/pka_ecdsa_hw.c
BRCM_COMP_LIB_SRC += lib/brcm_pka/pka_ecdhe_hw.c
else ifeq ($(CHIP_FAMILY),bcm8958x)
BRCM_COMP_LIB_INC += lib/synopsys_pka/hwinc/pka_hw_supported_features.h
BRCM_COMP_LIB_INC += lib/synopsys_pka/hwinc/pka_hw.h
BRCM_COMP_LIB_INC += lib/synopsys_pka/hwinc/pka_fw.h
BRCM_COMP_LIB_INC += lib/synopsys_pka/hwinc/pka_rsa_hw.h
BRCM_COMP_LIB_INC += lib/synopsys_pka/hwinc/pka_ecdsa_hw.h
BRCM_COMP_LIB_INC += lib/synopsys_pka/hwinc/pka_ecdhe_hw.h

BRCM_COMP_LIB_SRC += lib/synopsys_pka/pka_hw.c
BRCM_COMP_LIB_SRC += lib/synopsys_pka/pka_fw.c
BRCM_COMP_LIB_SRC += lib/synopsys_pka/pka_rsa_hw.c
BRCM_COMP_LIB_SRC += lib/synopsys_pka/pka_ecdsa_hw.c
endif

# PKA WD alarm
BRCM_COMP_APP_ALARM += PKAWDAlarm
PKAWDAlarm.counter = SystemTimer
PKAWDAlarm.callback = PKA_RunJobScheduler
PKAWDAlarm.declaration = osil/pka_osil.h
PKAWDAlarm.autostart = true
PKAWDAlarm.alarmtime = 8
PKAWDAlarm.cycletime = 8

BRCM_COMP_APP_INTR += PKA
BRCM_COMP_APP_EVENT += PKAEvent
PKA.function = PKA_IRQHandler
PKA.declaration = pka_osil.h
ifneq (,$(filter $(CHIP_FAMILY),bcm8956x bcm8957x))
PKA.irqnum = 56
BRCM_COMP_DEPENDS := time secutils hsm_drv_sched secureheap sha
else ifeq ($(CHIP_FAMILY),bcm8958x)
ifeq ($(version),fpga)
PKA.irqnum = 73
BRCM_COMP_LIB_CFLAGS += -DPKA_HW_BASE=0xe7ff8000UL
BRCM_COMP_LIB_CFLAGS += -DPKA_CRU_HW_BASE=0xefff0000UL
else
PKA.irqnum = 28
BRCM_COMP_LIB_CFLAGS += -DPKA_HW_BASE=0xb7ff8000UL
BRCM_COMP_LIB_CFLAGS += -DPKA_CRU_HW_BASE=0xbfff0000UL
endif
BRCM_COMP_DEPENDS := time synopsys_csl secutils hsm_drv_sched
endif

BRCM_COMP_APP_OPT += ENABLE_PKA

BRCM_COMP_NAME := pka
BRCM_COMP_TYPE := lib

