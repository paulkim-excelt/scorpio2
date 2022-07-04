#
# Copyright 2016-2019 Broadcom Limited.  All rights reserved.
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
# File Name: Makefile
# DESCRIPTION: Makefile to be invoked while running "make".
#####################################################################################

OUT_DIR ?= out/
CLIENT = $(OUT_DIR)/bcmutil
EXEC = $(OUT_DIR)/bcmutild
OS = LINUX

CLIENT_OBJS =
CLIENT_OBJS += client.o
CLIENT_OBJS += hlog.o

SERVER_OBJS =
SERVER_OBJS += lib/host_imgl.o
SERVER_OBJS += lib/host_system.o
SERVER_OBJS += hipc/hipc.o
SERVER_OBJS += server.o
SERVER_OBJS += hlog.o
SERVER_OBJS += crc.o
SERVER_OBJS += hipc/bcm8956x/bcm8956x_hipc.o
SERVER_OBJS += hipc/bcm58712/bcm58712_gpio.o
SERVER_OBJS += hipc/bcm58712/bcm58712_pcie_xfer.o

CFLAGS += -DHIPC_ENABLE_PCIE

ifeq ($(OS),LINUX)
CFLAGS += -DLINUX
endif
CFLAGS += -D__GNU__
CFLAGS += -DGNU
CFLAGS += -Iinclude
CFLAGS += -Ihipc
CFLAGS += -I../../ethernet/drivers/controller/inc
CFLAGS += -I../../ethernet/drivers/transceiver/inc
CFLAGS += -I../../ethernet/drivers/switch/inc
CFLAGS += -I../../drivers/include
CFLAGS += -I../../ethernet/drivers/ipc/inc
CFLAGS += -I../../ethernet/drivers/ipc/inc/osil
CFLAGS += -I../../drivers/mcu/inc
CFLAGS += -I../../drivers/mcu/inc/osil
CFLAGS += -I../../drivers/dbgmem/inc
CFLAGS += -I../../drivers/dbgmem/inc/osil
CFLAGS += -I../../bootloader/include/
CFLAGS += -I../../system/common/inc
CFLAGS += -I../../system/imgl/inc
CFLAGS += -I../../system/utils/inc
CFLAGS += -I../../system/time/inc
CFLAGS += -I../../ethernet/common/rpc/inc
CFLAGS += -I../../system/queue/inc
CFLAGS += -I../../syscfg/include
CFLAGS += -I../../ethernet/802.1as/inc/
CFLAGS += -I../../ethernet/802.1as/inc/osil/
CFLAGS += -I../../ethernet/common/nif/inc
CFLAGS += -DSPIUTIL_IMAGE_VERSION=\"$(SPIUTIL_IMAGE_VERSION)\"
CFLAGS += -I../../ethernet/common/rpc/inc
CFLAGS += -I../../system/nvm/inc
CFLAGS += -I../../ethernet/drivers/mdio/inc
CFLAGS += -I../../ethernet/common/ethsrv/inc/
CFLAGS += -I../ns2/kernel/drivers/net/ethernet/broadcom/xgbe
CFLAGS += -I../pc/linux-4.18/drivers/net/ethernet/amd/xgbe

CFLAGS += -DETHSRV_MAX_STREAM_POLICER_ENTRIES=256
CFLAGS += -DENABLE_ETH_SWITCH
CFLAGS += -DTRUE=1UL
CFLAGS += -DFALSE=0UL
CFLAGS += -DITBL_MAX_NUM_ENTRIES=20
CFLAGS += -D__BCM89560__
CFLAGS += -D__BCM8956X__
CFLAGS += -D__BCM58712__
CFLAGS += -D__CORTEX_MX__
CFLAGS += -D__CORTEX_M7__
CFLAGS += -DETS_MAX_INTERFACES=8UL
CFLAGS += -DRPC_MSG_PAYLOAD_SZ=496
CFLAGS += -Ihipc/bcm58712
CFLAGS += -I../../drivers/mcu/inc/bcm8956x
CFLAGS += -I../../ethernet/drivers/ipc/inc/bcm8956x
CFLAGS += -I../../bootloader/bcm8956x/chip
CFLAGS += -I../../bootloader/bcm8956x/chip/common
CFLAGS += -I../../init/bcm8956x
CFLAGS += -I../../init/bcm8956x/inc
CFLAGS += -I../../init/bcm8956x/chip
CFLAGS += -I../../system/include/bcm8956x
ifeq ($(strip $(version)),a0)
CFLAGS += -I../../init/bcm8956x/inc/rdb/a0
else
CFLAGS += -I../../init/bcm8956x/inc/rdb/b0
endif
CFLAGS += -I../../bootloader/inc
CFLAGS += -I../../drivers/otp/inc
CFLAGS += -I../../../system/rpc/inc
CFLAGS += -I../../../system/rpc/ipc

all: $(EXEC)

clean:
	rm -rf $(OUT_DIR)

$(EXEC): $(addprefix $(OUT_DIR)/,$(SERVER_OBJS)) $(CLIENT)
	$(HOST_TOOLCHAIN)gcc -o $@ $(addprefix $(OUT_DIR)/,$(SERVER_OBJS)) -lrt
	$(HOST_TOOLCHAIN)strip $@

$(CLIENT): $(addprefix $(OUT_DIR)/,$(CLIENT_OBJS))
	$(HOST_TOOLCHAIN)gcc -o $@ $(addprefix $(OUT_DIR)/,$(CLIENT_OBJS)) -lrt
	$(HOST_TOOLCHAIN)strip $@

$(OUT_DIR)/%.o: %.c
	mkdir -p $(dir $@)
	$(HOST_TOOLCHAIN)gcc -Werror -Wall $(CFLAGS) -c $< -o $@
