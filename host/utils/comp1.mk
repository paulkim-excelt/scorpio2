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

#   @defchapter grp_host Host
#
#   @addtogroup grp_host
#   @{
#   @file host/utils/comp1.mk
#   @brief Make file for Host Server
#   @version 0.1 Inital version
#   @}
#
#   @defgroup grp_host_fa Host Flow accelerator
#   @ingroup grp_host


BRCM_COMP_NAME := bcmutild
BRCM_COMP_DEPENDS += utils
BRCM_COMP_DEPENDS += sys_service imgl_module time
BRCM_COMP_DEPENDS += ethsrv imgl nvm
BRCM_COMP_DEPENDS += dbgmem mcudrv flashdrv otpdrv ipcdrv
BRCM_COMP_DEPENDS += ethswtm ettm ets ethernet
BRCM_COMP_TYPE := hostapp

BRCM_COMP_HOST_OPT += ENABLE_CPU_GENERIC

BRCM_COMP_UHOST_SRC += server.c
BRCM_COMP_UHOST_SRC += hipc/hipc.c
BRCM_COMP_UHOST_SRC += hlog.c
BRCM_COMP_UHOST_SRC += lib/host_cfp.c
BRCM_COMP_UHOST_SRC += lib/host_ether.c
BRCM_COMP_UHOST_SRC += lib/host_etherswt.c
BRCM_COMP_UHOST_SRC += lib/host_ets.c
BRCM_COMP_UHOST_SRC += lib/host_imgl.c
BRCM_COMP_UHOST_SRC += lib/host_system.c

BRCM_COMP_HOST_CFLAGS += -DENABLE_HOST_ETS_CMD_HANDLER
BRCM_COMP_HOST_CFLAGS += -DENABLE_HOST_ETHSWTM_CMD_HANDLER
BRCM_COMP_HOST_CFLAGS += -DENABLE_HOST_ETHSWTM_CFP_CMD_HANDLER
BRCM_COMP_HOST_CFLAGS += -DSPIUTIL_IMAGE_VERSION=\"$(SPIUTIL_IMAGE_VERSION)\"

ifneq ($(BRCM_HOST_COMPILER), gcc)
BRCM_COMP_UHOST_SRC += hipc/spi_xfer.c
BRCM_COMP_HOST_CFLAGS += -DHIPC_ENABLE_SPI
endif

BRCM_COMP_HOST_CFLAGS += -DENABLE_RECORD_NOTIFICATION

BRCM_COMP_EXPORT_HDR += include/.
BRCM_COMP_EXPORT_HDR += hipc/.

BRCM_INC += $(BRCM_SDK_ROOT)/ethernet/common/rpc/inc/
BRCM_INC += $(BRCM_SDK_ROOT)/bootloader/inc/
BRCM_INC += $(BRCM_SDK_ROOT)/bootloader/include/
BRCM_INC += $(BRCM_SDK_ROOT)/ethernet/common/nif/inc
BRCM_INC += $(BRCM_SDK_ROOT)/system/service/inc
BRCM_INC += $(BRCM_SDK_ROOT)/system/modules/rpc/local/inc/osil

#Conditional compilation based on host/target chipset
ifeq ($(CHIP_FAMILY),bcm8953x)
BRCM_COMP_UHOST_SRC += hipc/bcm5300x/bcm5300x_gpio.c
BRCM_COMP_UHOST_SRC += hipc/bcm5300x/bcm5300x_spi.c
BRCM_COMP_UHOST_SRC += hipc/bcm8953x/bcm8953x_hipc.c

BRCM_COMP_HOST_CFLAGS += -D__BCM5300X__
BRCM_INC += $(BRCM_SDK_ROOT)/host/utils/hipc/bcm5300x
BRCM_INC += $(BRCM_SDK_ROOT)/ethernet/drivers/ipc/inc/bcm8953x
BRCM_INC += $(BRCM_SDK_ROOT)/bootloader/bcm8953x/chip

else ifeq ($(CHIP_FAMILY),bcm8956x)
BRCM_COMP_HOST_CFLAGS += -D__BCM89560__
BRCM_COMP_HOST_CFLAGS += -DHIPC_ENABLE_PCIE
BRCM_COMP_HOST_CFLAGS += -DENABLE_HOST_ETHSWTM_FA_CMD_HANDLER

ifeq ($(strip $(version)),b0)
BRCM_COMP_HOST_CFLAGS += -DBCM_PCIE_V2
endif

BRCM_COMP_UHOST_SRC += hipc/hipc_v3.c
BRCM_COMP_UHOST_SRC += hipc/bcm58712/bcm58712_spi.c
BRCM_COMP_UHOST_SRC += hipc/bcm58712/bcm58712_gpio.c

BRCM_INC += $(BRCM_SDK_ROOT)/host/utils/hipc/bcm58712
BRCM_INC += $(BRCM_SDK_ROOT)/ethernet/drivers/ipc/inc/bcm8956x
BRCM_INC += $(BRCM_SDK_ROOT)/bootloader/bcm8956x/chip
BRCM_INC += $(BRCM_SDK_ROOT)/bootloader/bcm8956x/chip/common
BRCM_INC += $(BRCM_SDK_ROOT)/host/ns2/kernel/drivers/net/ethernet/broadcom/xgbe

BRCM_COMP_EXPORT_HDR += include/host_fa.h
BRCM_COMP_REQ_SRC += doc/host_fa_req.c
BRCM_COMP_UHOST_SRC += lib/host_fa.c
BRCM_COMP_QT_SRC += tests/qualification/fa_qt/host_fa_qt.h

else ifeq ($(CHIP_FAMILY),bcm8957x)
BRCM_COMP_HOST_CFLAGS += -D__BCM89570__
BRCM_COMP_HOST_CFLAGS += -DHIPC_ENABLE_PCIE
BRCM_COMP_HOST_CFLAGS += -DENABLE_HOST_ETHSWTM_FA_CMD_HANDLER

BRCM_COMP_UHOST_SRC += hipc/hipc_v3.c
BRCM_COMP_UHOST_SRC += hipc/bcm58712/bcm58712_spi.c
BRCM_COMP_UHOST_SRC += hipc/bcm58712/bcm58712_gpio.c

ifeq ($(BRCM_HOST_COMPILER), gcc)
BRCM_COMP_UHOST_SRC += hipc/jlink_xfer.c
BRCM_INC += $(BRCM_SDK_ROOT)/vendor/segger/inc
endif

BRCM_INC += $(BRCM_SDK_ROOT)/host/utils/hipc/bcm58712
BRCM_INC += $(BRCM_SDK_ROOT)/ethernet/drivers/ipc/inc/bcm8957x
BRCM_INC += $(BRCM_SDK_ROOT)/bootloader/bcm8957x/chip
BRCM_INC += $(BRCM_SDK_ROOT)/bootloader/bcm8957x/chip/common
BRCM_INC += $(BRCM_SDK_ROOT)/host/ns2/kernel/drivers/net/ethernet/broadcom/xgbe

BRCM_COMP_EXPORT_HDR += include/host_fa.h
BRCM_COMP_REQ_SRC += doc/host_fa_req.c
BRCM_COMP_UHOST_SRC += lib/host_fa.c

else ifeq ($(CHIP_FAMILY),x86)
BRCM_INC += $(BRCM_SDK_ROOT)/host/drivers/xgbe
BRCM_INC += $(BRCM_SDK_ROOT)/vendor/segger/inc

BRCM_COMP_UHOST_SRC += hipc/hipc_v3.c
BRCM_COMP_UHOST_SRC += hipc/jlink_xfer.c
endif

ifeq ($(pcie), 1)
BRCM_COMP_HOST_CFLAGS += -DBCM_PCIE_V2
BRCM_COMP_UHOST_SRC += hipc/bcm58712/bcm58712_pcie_xfer.c
endif