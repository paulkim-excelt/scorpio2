#
# Copyright 2018-2021 Broadcom Limited.  All rights reserved.
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



##  @defgroup grp_nvm_service Service
#   @ingroup grp_nvm
#
#   @addtogroup grp_nvm_service
#   @{
#   This module abstracts/processes requests for read/write from/into
#   Non-Volatile Memories (Flash and OTP)
#
#   @file nvm/service/comp.mk
#   @brief Makefile for Non-Volatile Memory
#   @version 0.1 Initial version
#   @}
#

BRCM_COMP_NAME := nvmsrv
BRCM_COMP_DEPENDS := flashdrv imgl utils abstract
BRCM_COMP_TYPE := lib

BRCM_COMP_REQ_SRC += doc/nvm_sync_loader_req.c
BRCM_COMP_REQ_SRC += doc/nvm_imgl_req.c
BRCM_COMP_EXPORT_HDR += inc/nvm_imgl.h
BRCM_COMP_LIB_SRC += lib/nvm_imgl.c

BRCM_COMP_UEXPORT_HDR += inc/osil/nvm_osil.h
BRCM_INC += $(BRCM_SDK_ROOT)/system/service/inc

BRCM_COMP_APP_OPT += ENABLE_FLASH
BRCM_COMP_APP_OPT += ENABLE_NVM

ifeq ($(ENABLE_PTM),TRUE)
BRCM_COMP_APP_OPT += ENABLE_PTM
endif

ifeq ($(call isappopt,ENABLE_FLASH0),yes)
BRCM_COMP_APP_INTR += QSPI0
QSPI0.function = FLASH_IRQHandler0
QSPI0.declaration = flash_osil.h
endif
ifeq ($(call isappopt,ENABLE_FLASH1),yes)
BRCM_COMP_APP_INTR += QSPI1
QSPI1.function = FLASH_IRQHandler1
QSPI1.declaration = flash_osil.h
endif

BRCM_INC += $(BRCM_SDK_ROOT)/system/common/inc

BRCM_COMP_APP_TASK += NVM_Server
NVM_Server.priority = 8
NVM_Server.stack = 2048
NVM_Server.event += SystemEvent0
NVM_Server.event += SystemEvent1
NVM_Server.event += SystemEvent2
NVM_Server.event += SystemEvent3
NVM_Server.event += SystemEvent4
NVM_Server.event += SystemEvent5
NVM_Server.event += SystemEvent6
NVM_Server.event += SystemEvent7
NVM_Server.event += SystemEvent8
NVM_Server.event += SystemEvent9
NVM_Server.event += ShutdownEvent



BRCM_COMP_APP_CFLAGS += -DNVM_SERVER_TASK_ID=NVM_Server
BRCM_COMP_APP_CFLAGS += -DFLASH_IRQ_PROCESS_TASK=NVM_Server
BRCM_COMP_APP_CFLAGS += -DPTM_MSGQ_EVENT_ID=SystemEvent0
BRCM_COMP_APP_CFLAGS += -DPTM_FLASH_OP_DONE_EVENT_ID=SystemEvent1
BRCM_COMP_APP_CFLAGS += -DNVM_EVENT_ID=SystemEvent2
BRCM_COMP_APP_CFLAGS += -DNVM_MSGQ_EVENT=SystemEvent3
BRCM_COMP_APP_CFLAGS += -DNVM_FLS_0_CB_IND_EVENT=SystemEvent4
BRCM_COMP_APP_CFLAGS += -DNVM_FLS_1_CB_IND_EVENT=SystemEvent6
BRCM_COMP_APP_CFLAGS += -DFLASH0_EVENT=SystemEvent7
BRCM_COMP_APP_CFLAGS += -DFLASH1_EVENT=SystemEvent8
BRCM_COMP_APP_CFLAGS += -DNVM_NOTIF_EVENT=SystemEvent9
BRCM_COMP_APP_CFLAGS += -DSYSTEM_MONITOR_ALARM_EVENT=SystemEvent11

BRCM_COMP_UAPP_SRC += os/erika/nvm_osil.c
BRCM_COMP_UAPP_SRC += os/common/nvm.c

ifeq ($(CHIP_FAMILY),bcm8910x)
BRCM_COMP_UAPP_SRC += os/erika/bcm8910x/bcm8910x_nvm_cfg.c
endif
ifeq ($(CHIP_FAMILY),bcm8953x)
BRCM_COMP_UAPP_SRC += os/erika/bcm8953x/bcm8953x_nvm_cfg.c
endif
ifeq ($(CHIP_FAMILY),bcm8956x)
BRCM_COMP_UAPP_SRC += os/erika/bcm8956x/bcm8956x_nvm_cfg.c
endif
ifeq ($(CHIP_FAMILY),bcm8957x)
BRCM_COMP_UAPP_SRC += os/erika/bcm8957x/bcm8957x_nvm_cfg.c
endif
ifeq ($(CHIP_FAMILY),bcm8908x)
BRCM_COMP_UAPP_SRC += os/erika/bcm8908x/bcm8908x_nvm_cfg.c
endif

ifeq ($(call iseeopt, ENABLE_PTM), yes)
BRCM_COMP_UAPP_SRC += os/erika/ptm_osil.c
BRCM_COMP_UAPP_SRC += os/common/ptm.c
BRCM_COMP_APP_CFLAGS += -DIMGL_MODE_FUNC_TABLE_PRIO0=PTM_ImageHandler
else
BRCM_COMP_APP_CFLAGS += -DIMGL_MODE_FUNC_TABLE_PRIO0=NVM_ImglHandler
endif   # ENABLE_PTM
