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
#    OF THE AMOUNT ACTUALLY PAID FOR THE SOFTWARE ITSELF OR U.S. \$1, WHICHEVER
#    IS GREATER. THESE LIMITATIONS SHALL APPLY NOTWITHSTANDING ANY FAILURE OF
#    ESSENTIAL PURPOSE OF ANY LIMITED REMEDY.
#
####################################################################################

##  @defgroup grp_host_server Server
#   @ingroup grp_host
#
#   @addtogroup grp_host_server
#   @{
#   @file host/utils/comp.mk
#   @brief Makefile for Server
#   @version 0.1 Initial version
#   @}

BRCM_COMP_NAME := bcmutil
BRCM_COMP_DEPENDS += utils
BRCM_COMP_DEPENDS += sys_service imgl_module time
BRCM_COMP_DEPENDS += nvmsrv
BRCM_COMP_DEPENDS += dbgmem mcudrv flashdrv otpdrv ipcdrv
BRCM_COMP_DEPENDS += ethswtm ettm ets ethernet
BRCM_COMP_TYPE := hostapp

BRCM_COMP_HOST_CFLAGS += -DENABLE_HOST_ETS_CMD_HANDLER
BRCM_COMP_HOST_CFLAGS += -DENABLE_HOST_ETHSWTM_CMD_HANDLER
BRCM_COMP_HOST_CFLAGS += -DENABLE_HOST_ETHSWTM_CFP_CMD_HANDLER
BRCM_COMP_HOST_CFLAGS += -DSPIUTIL_IMAGE_VERSION=\"$(SPIUTIL_IMAGE_VERSION)\"

BRCM_COMP_HOST_OPT += ENABLE_CPU_GENERIC

BRCM_COMP_UHOST_SRC += client.c
BRCM_COMP_UHOST_SRC += hlog.c

BRCM_INC += $(BRCM_SDK_ROOT)/host/utils/include
BRCM_INC += $(BRCM_SDK_ROOT)/host/utils/hipc
BRCM_INC += $(BRCM_SDK_ROOT)/ethernet/common/ethsrv/inc/
BRCM_INC += $(BRCM_SDK_ROOT)/ethernet/common/rpc/inc/
BRCM_INC += $(BRCM_SDK_ROOT)/bootloader/inc/
BRCM_INC += $(BRCM_SDK_ROOT)/bootloader/include/
BRCM_INC += $(BRCM_SDK_ROOT)/ethernet/common/nif/inc
BRCM_INC += $(BRCM_SDK_ROOT)/system/modules/rpc/local/inc/osil

BRCM_COMP_HOST_CFLAGS += -DENABLE_RECORD_NOTIFICATION

#Conditional compilation based on host/target chipset
ifeq ($(CHIP_FAMILY),bcm8953x)
BRCM_COMP_HOST_OPT += ENABLE_HIPC
BRCM_COMP_DEPENDS += hipc rpc_v2
BRCM_COMP_HOST_CFLAGS += -D__BCM5300X__
BRCM_COMP_HOST_CFLAGS += -DMAX_NUM_PORTS=8

BRCM_INC += $(BRCM_SDK_ROOT)/host/utils/hipc/bcm5300x
BRCM_INC += $(BRCM_SDK_ROOT)/ethernet/drivers/ipc/inc/bcm8953x
BRCM_INC += $(BRCM_SDK_ROOT)/bootloader/bcm8953x/chip
BRCM_INC += $(BRCM_SDK_ROOT)/bootloader/bcm8953x/chip/common

else ifeq ($(CHIP_FAMILY),bcm8956x)
BRCM_COMP_HOST_CFLAGS += -DMAX_NUM_PORTS=14
BRCM_COMP_HOST_CFLAGS += -DENABLE_HOST_ETHSWTM_FA_CMD_HANDLER

BRCM_INC += $(BRCM_SDK_ROOT)/host/utils/hipc/bcm58712
BRCM_INC += $(BRCM_SDK_ROOT)/ethernet/drivers/ipc/inc/bcm8956x
BRCM_INC += $(BRCM_SDK_ROOT)/bootloader/bcm8956x/chip
BRCM_INC += $(BRCM_SDK_ROOT)/bootloader/bcm8956x/chip/common

else ifeq ($(CHIP_FAMILY),bcm8957x)
BRCM_COMP_HOST_OPT += ENABLE_HIPC
BRCM_COMP_DEPENDS += hipc rpc_v2
BRCM_COMP_HOST_CFLAGS += -DMAX_NUM_PORTS=14
BRCM_COMP_HOST_CFLAGS += -DENABLE_HOST_ETHSWTM_FA_CMD_HANDLER

BRCM_INC += $(BRCM_SDK_ROOT)/host/utils/hipc/bcm58712
BRCM_INC += $(BRCM_SDK_ROOT)/ethernet/drivers/ipc/inc/bcm8957x
BRCM_INC += $(BRCM_SDK_ROOT)/bootloader/bcm8957x/chip
BRCM_INC += $(BRCM_SDK_ROOT)/bootloader/bcm8957x/chip/common

ifeq ($(BRCM_HOST_COMPILER), gcc)
BRCM_INC += $(BRCM_SDK_ROOT)/vendor/segger/inc
endif

else ifeq ($(CHIP_FAMILY),x86)
BRCM_COMP_HOST_OPT += ENABLE_HIPC
BRCM_COMP_DEPENDS += hipc
BRCM_COMP_HOST_CFLAGS += -DMAX_NUM_PORTS=14
BRCM_COMP_HOST_CFLAGS += -DENABLE_HOST_ETHSWTM_FA_CMD_HANDLER

BRCM_INC += $(BRCM_SDK_ROOT)/host/utils/hipc/bcm58712
endif # CHIP_FAMILY
