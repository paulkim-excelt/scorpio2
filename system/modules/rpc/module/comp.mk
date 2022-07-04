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

##  @defgroup grp_rpc_v2_mod Module
#   @ingroup grp_rpc_v2
#
#   @addtogroup grp_rpc_v2_mod
#   @{
#   @file system/rpc/module/comp.mk
#   @brief Makefile for RPC
#   @version 0.1 Initial version
#   @}
#

BRCM_COMP_NAME := rpc_module
BRCM_COMP_DEPENDS := rpc_mem
BRCM_COMP_TYPE := doc

BRCM_COMP_REQ_SRC    += doc/rpc_mod_req.c

BRCM_COMP_EXPORT_HDR += inc/rpc_module_v2.h

BRCM_COMP_APP_SRC    += os/common/rpc_module.c

BRCM_COMP_HOST_SRC   += os/common/rpc_module.c
BRCM_COMP_UHOST_SRC   += os/common/rpc_hostcmds.c

BRCM_COMP_UEXPORT_HDR += inc/rpc_hosthelper.h
BRCM_COMP_UEXPORT_HDR += inc/rpc_hostcmd.h

ifneq ($(call isappopt,RPC_MODULE_TEST_EN),yes)
ifeq ($(CHIP_FAMILY),bcm8908x)
BRCM_COMP_APP_SRC    += os/platform/rpc_bcm8908x.c
endif

ifeq ($(CHIP_FAMILY),bcm8910x)
BRCM_COMP_APP_SRC    += os/platform/rpc_bcm8910x.c
endif

ifeq ($(CHIP_FAMILY),bcm8953x)
BRCM_COMP_APP_SRC    += os/platform/rpc_bcm8953x.c
BRCM_COMP_UHOST_SRC  += os/platform/rpc_interfaces_host.c
endif

ifeq ($(CHIP_FAMILY),bcm8956x)
BRCM_COMP_APP_SRC    += os/platform/rpc_bcm8956x.c
BRCM_COMP_UHOST_SRC  += os/platform/rpc_interfaces_host.c
endif

ifeq ($(CHIP_FAMILY),bcm8957x)
BRCM_COMP_APP_SRC    += os/platform/rpc_bcm8957x.c
BRCM_COMP_UHOST_SRC  += os/platform/rpc_interfaces_host.c
endif

ifeq ($(CHIP_FAMILY),x86)
BRCM_COMP_APP_SRC    += os/platform/rpc_x86.c
BRCM_COMP_UHOST_SRC  += os/platform/rpc_interfaces_host.c
endif

ifeq ($(CHIP_FAMILY),bcm8958x)
ifeq ($(cpu),em22fs)
BRCM_COMP_APP_SRC += os/platform/rpc_bcm8958x_arc.c
else
BRCM_COMP_APP_SRC += os/platform/rpc_bcm8958x_m7.c
endif #em22fs
endif #bcm8958x

BRCM_COMP_HOST_CFLAGS += -DRPC_MSGQ_MASTER_IFC_HOST=RPC_HostCmdService

endif #RPC_MODULE_TEST_EN
