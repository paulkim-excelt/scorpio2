#
# Copyright 2020 Broadcom Limited.  All rights reserved.
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

##  @defchapter grp_base BASE
#   @addtogroup grp_base
#   @{
#   Broadcom Automotive Scheduling Environment (BASE) is  essentially a task scheduler,
#   implementing a subset of OSEK specification[not fully compliant].
#   BASE also uses @ref grp_bcm_thread_safety_ifc to setup and protect Task Stack and
#   other memory resources approprirately [Enforced by MPU in the implementation]
#
#   @file base/comp.mk
#   @brief Makefile for BASE
#   @version 0.1 Initial version
#   @}


BRCM_COMP_NAME := base
BRCM_COMP_DEPENDS :=
BRCM_COMP_TYPE := doc

BRCM_COMP_REQ_SRC += doc/base_req.c
BRCM_COMP_EXPORT_HDR += inc/base.h
BRCM_COMP_EXPORT_HDR += inc/base_kernel_services.h

BRCM_COMP_EXPORT_HDR += lib/kernel.h
BRCM_COMP_APP_SRC += lib/kernel_common.c

ifeq ($(cpu),m7)
BRCM_COMP_REQ_SRC += doc/base_cortex_mx_req.c
BRCM_COMP_EXPORT_HDR += lib/arch/armv7m/armv7m_kernel.h
BRCM_COMP_APP_SRC += lib/arch/armv7m/armv7m.c
BRCM_COMP_APP_SRC += lib/arch/armv7m/armv7m_pendsv.S
endif
ifeq ($(cpu),r4)
BRCM_COMP_REQ_SRC += doc/base_cortex_rx_req.c
BRCM_COMP_EXPORT_HDR += lib/arch/armv7r/armv7r_kernel.h
BRCM_COMP_APP_SRC += lib/arch/armv7r/armv7r.c
BRCM_COMP_APP_SRC += lib/arch/armv7r/armv7r_exceptions.S
endif
ifeq ($(cpu),em22fs)
BRCM_COMP_REQ_SRC += doc/base_av2em_req.c
BRCM_COMP_APP_SRC += lib/arch/av2em/av2em.c
BRCM_COMP_APP_SRC += lib/arch/av2em/av2em_exceptions.S

# Interrupt used for context switching in ARC family
BRCM_COMP_APP_INTR += ContextSwitchISR
BRCM_COMP_EXPORT_HDR += inc/osil/av2em/av2em_ctx_switch.h
ContextSwitchISR.function = BASE_AV2EmContextSwitchISR
ContextSwitchISR.declaration = av2em_ctx_switch.h
ContextSwitchISR.isrtype = kernel
ifeq ($(version),fpga)
ContextSwitchISR.irqnum = 86
else
ContextSwitchISR.irqnum = 143
endif
BRCM_COMP_LIB_CFLAGS += -DBASE_AV2EM_CONTEXT_SWITCH_INTERRUPT_NUM=$(ContextSwitchISR.irqnum)
endif