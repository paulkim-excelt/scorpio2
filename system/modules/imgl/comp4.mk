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

##  @defgroup grp_imgl_fw Image Library for firmware
#   @ingroup grp_imgl
#
#   @addtogroup grp_imgl_fw
#   @{
#   This component abstracts loading configuration from system configuration partition
#
#   @file system/imgl/comp4.mk
#   @brief Makefile for IMGL Firmware
#   @version 0.1 Initial version
#   @}
#

BRCM_COMP_NAME := imgl_fw
BRCM_COMP_DEPENDS := imgl_interface crypto time otpm
ifeq ($(call isappopt, ENABLE_FLASH_MODULE), yes)
BRCM_COMP_DEPENDS += flashm
endif
BRCM_COMP_TYPE := lib

BRCM_COMP_REQ_SRC += doc/imgl_req.c
BRCM_COMP_EXPORT_HDR += inc/imgl.h
BRCM_COMP_EXPORT_HDR += inc/imgl_interface.h
BRCM_COMP_EXPORT_HDR += inc/osil/imgl_osil.h
BRCM_COMP_EXPORT_HDR += inc/osil/imgl_memory.h
BRCM_COMP_EXPORT_HDR += inc/imgl_version.h
BRCM_COMP_EXPORT_HDR += inc/imgl_mmap.h
BRCM_COMP_EXPORT_HDR += inc/imgl_mod.h
BRCM_INC += $(BRCM_SDK_ROOT)/ethernet/common/rpc/inc/
BRCM_INC += $(BRCM_SDK_ROOT)/system/service/inc/
BRCM_INC += $(BRCM_SDK_ROOT)/system/modules/rpc/ipc/inc/
BRCM_INC += $(BRCM_SDK_ROOT)/system/modules/rpc/mem/inc/

BRCM_COMP_DOC_SRC += doc/images/imgl_overview.png

BRCM_COMP_APP_EVENT += IMGL_EVENT

BRCM_COMP_APP_CFLAGS += -DENABLE_IMGL_V2
BRCM_COMP_LIB_CFLAGS += -DENABLE_IMGL_FW
BRCM_COMP_LIB_INC += lib/imgl_loader.h
BRCM_COMP_LIB_INC += lib/imgl_common.h
BRCM_COMP_LIB_INC += lib/imgl_shared_context.h
BRCM_COMP_LIB_INC += lib/imgl_lib.h
BRCM_COMP_LIB_SRC += lib/imgl_loader.c
BRCM_COMP_LIB_SRC += lib/imgl_common.c
BRCM_COMP_LIB_SRC += lib/imgl_cfg.c
BRCM_COMP_LIB_SRC += lib/imgl_update.c
BRCM_COMP_LIB_SRC += lib/imgl_update_mod.c
BRCM_COMP_LIB_SRC += lib/imgl_shared_context.c
BRCM_COMP_APP_SRC += os/common/imgl_memory.c
BRCM_COMP_LIB_CFLAGS += -DENABLE_IMGL_UPDATE

ifeq ($(call isappopt, ENABLE_IMGL_MMAP_ASYNC_MODE), yes)
ifeq ($(call isappopt, ENABLE_IMGL_MMAP_UPDATE), yes)
BRCM_COMP_APP_CFLAGS += -DENABLE_IMGL_MMAP_UPDATE
endif
BRCM_COMP_APP_CFLAGS += -DENABLE_IMGL_MMAP_ASYNC_MODE

BRCM_COMP_APP_SRC += os/common/imgl_mmap.c
BRCM_COMP_APP_TASK += IMGL_MmapServer
IMGL_MmapServer.priority := 8
IMGL_MmapServer.autostart := true
IMGL_MmapServer.stack := 512
IMGL_MmapServer.event += IMGL_EVENT
endif

BRCM_COMP_APP_SRC += os/common/imgl_common_osil.c
BRCM_COMP_APP_SRC += os/common/imgl_version.c
BRCM_COMP_APP_SRC += os/common/imgl_bl_osil.c

ifeq ($(ENABLE_RPC_V2),TRUE)
BRCM_COMP_APP_SRC += os/common/imgl_rpc.c
endif
