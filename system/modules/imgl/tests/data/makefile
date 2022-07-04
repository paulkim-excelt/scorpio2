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

BRCM_SDK_ROOT := $(shell readlink -f $(shell pwd)/../../../../../)

BRCM_COMMON_LD_SCRIPT := $(BRCM_SDK_ROOT)/build/common/bl_align.ld
BRCM_COMMON_LD_ALIGN_VALUE = $(shell grep BL_ALIGN_SIZE $(BRCM_COMMON_LD_SCRIPT) | sed 's|.*[A-Za-z ]||g' | sed 's|[;]||g')

BRCM_BL_NUM_COPIES := 2

BRCM_FW_NUM_COPIES := 3
BRCM_SYSCFG_NUM_COPIES := 3
BRCM_SECURE_KEY_COPIES := 1
ITBL_MAX_NUM_ENTRIES := 3

BRCM_FW_NUM_COPIES_ROM := 0
BRCM_SYSCFG_NUM_COPIES_ROM := 0
BRCM_SECURE_KEY_COPIES_ROM := 0
ITBL_MAX_NUM_ENTRIES_ROM := 1

BRCM_ITBL_VERSION := 2

BRCM_APP_OBJ_DIR := $(shell pwd)
BRCM_APP_OUT_DIR := $(shell pwd)/temp

BRCM_FLAT_BIN := test_flat
BRCM_FLAT_FILE := $(BRCM_FLAT_BIN)_flash.bin

BRCM_FLAT_BIN_UPDATE := test_flat_update
BRCM_FLAT_FILE_UPDATE := $(BRCM_FLAT_BIN_UPDATE)_flash.bin

BRCM_PT_CREATOR_OPTS  = --sector_sz=0x1000 --pt_base=0x0 --edc 1
BRCM_PT_CREATOR_OPTS += --pla 0x22222222
BRCM_PT_CREATOR_OPTS += --repo $(BRCM_SDK_ROOT) --outdir $(BRCM_APP_OUT_DIR)
BRCM_PT_CREATOR_OPTS += --bl_cnt $(BRCM_BL_NUM_COPIES) --bl_cfg $(BRCM_APP_OBJ_DIR)/bl_cfg.txt --bl_entry_pt 0x01234567
BRCM_PT_CREATOR_OPTS += --fw_cfg $(BRCM_APP_OBJ_DIR)/fw_cfg.txt --fw_entry_pt 0x89abcdef
BRCM_PT_CREATOR_OPTS += --userdata $(BRCM_APP_OBJ_DIR)/userdata.txt

BRCM_PT_CREATOR_OPTS += --bl_sign 1 --pub_key $(BRCM_SDK_ROOT)/build/keys/public_key.bin --pub_key_la 0xeeeeeeee
BRCM_PT_CREATOR_OPTS += --priv_key $(BRCM_SDK_ROOT)/build/keys/private_key.dat
BRCM_PT_CREATOR_OPTS +=
BRCM_PT_CREATOR_OPTS += --itbl_version $(BRCM_ITBL_VERSION)
BRCM_PT_CREATOR_OPTS += --chip imgl
BRCM_PT_CREATOR_OPTS += --flashBin 1 --userdata_start_addr_min 0x0 --align=$(BRCM_COMMON_LD_ALIGN_VALUE)

sym_addr = $(addprefix 0x, $(word 1,$(shell objdump --syms $2 | grep --line-buffered -w $1)))

.PHONY: all
all:
	mkdir -p $(BRCM_APP_OUT_DIR)
	rm -rf $(BRCM_APP_OUT_DIR)
	mkdir -p $(BRCM_APP_OUT_DIR)
	$(BRCM_SDK_ROOT)/build/common/pt_creator.py $(BRCM_PT_CREATOR_OPTS) --out=$(BRCM_FLAT_BIN) --version_info $(BRCM_APP_OBJ_DIR)/version.txt --syscfg_cnt $(BRCM_SYSCFG_NUM_COPIES_ROM) --sys_cfg $(BRCM_APP_OBJ_DIR)/sys_cfg.txt --fw_cnt $(BRCM_FW_NUM_COPIES_ROM) --key_cnt $(BRCM_SECURE_KEY_COPIES_ROM) --max_num_img_entries $(ITBL_MAX_NUM_ENTRIES_ROM)
	cp $(BRCM_APP_OUT_DIR)/$(BRCM_FLAT_FILE) $(BRCM_FLAT_FILE)
	xxd -i $(BRCM_FLAT_FILE) ../qualification/$(BRCM_FLAT_BIN)_flash.h
	rm $(BRCM_FLAT_FILE)
	cp $(BRCM_APP_OUT_DIR)/01_0000.bin test_bl_signed.bin
	xxd -i test_bl_signed.bin ../qualification/test_bl_signed.h
	rm test_bl_signed.bin
	xxd -i test_bl.img ../qualification/test_bl.h
	$(BRCM_SDK_ROOT)/build/common/pt_creator.py $(BRCM_PT_CREATOR_OPTS) --out=$(BRCM_FLAT_BIN) --version_info $(BRCM_APP_OBJ_DIR)/version.txt --syscfg_cnt $(BRCM_SYSCFG_NUM_COPIES) --sys_cfg $(BRCM_APP_OBJ_DIR)/sys_cfg.txt --fw_cnt $(BRCM_FW_NUM_COPIES) --key_cnt $(BRCM_SECURE_KEY_COPIES) --max_num_img_entries $(ITBL_MAX_NUM_ENTRIES)
	cp $(BRCM_APP_OUT_DIR)/$(BRCM_FLAT_FILE) ../qualification/$(BRCM_FLAT_FILE)
	$(BRCM_SDK_ROOT)/build/common/pt_creator.py $(BRCM_PT_CREATOR_OPTS) --out=$(BRCM_FLAT_BIN_UPDATE) --version_info $(BRCM_APP_OBJ_DIR)/version_new.txt --syscfg_cnt $(BRCM_SYSCFG_NUM_COPIES) --sys_cfg $(BRCM_APP_OBJ_DIR)/sys_cfg_update.txt --fw_cnt $(BRCM_FW_NUM_COPIES) --key_cnt $(BRCM_SECURE_KEY_COPIES) --max_num_img_entries $(ITBL_MAX_NUM_ENTRIES)
	cp $(BRCM_APP_OUT_DIR)/$(BRCM_FLAT_FILE_UPDATE) ../qualification/$(BRCM_FLAT_FILE_UPDATE)
	cp $(BRCM_APP_OUT_DIR)/01_0000.bin ../qualification/test_bl_signed.bin
	cp test_img_update.bin ../qualification/update_img.bin
	cp test_bl.img ../qualification/test_bl.bin
	cp test_data.bin ../qualification/test_data.bin
	cp test_text.bin ../qualification/test_text.bin
	cp test_img.bin ../qualification/test_img.bin
	cp test_img_update.bin ../qualification/update_img.bin
	rm -rf $(BRCM_APP_OUT_DIR)


