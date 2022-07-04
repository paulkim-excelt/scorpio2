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

#   @file init/bcm8957x/comp3.mk
#   @brief  BCM8957X ROM testing variant for BCM8958X ROM
#   @}

BRCM_COMP_NAME := bcm8957x_m7_rom
BRCM_COMP_DEPENDS :=
BRCM_COMP_TYPE := rom

BRCM_COMP_EXPORT_HDR += inc/init.h
BRCM_COMP_APP_SRC += chip/common/startup.S
BRCM_COMP_APP_SRC += chip/common/exceptions.S
BRCM_COMP_APP_SRC += chip/common/early_init.c
BRCM_COMP_APP_SRC += chip/common/svc_handlers.c
BRCM_COMP_UAPP_SRC += os/erika/bcm8957x_platform.c

BRCM_ROM_LINKER_SCRIPT =  $(BRCM_SDK_ROOT)/init/bcm8957x/chip/common/rom_dummy.ld

BRCM_COMP_APP_CFLAGS += -DENABLE_FW_LOAD
BRCM_COMP_APP_CFLAGS += -DENABLE_SYSTEM_MODULES

BRCM_COMP_APP_CFLAGS += -DIMGL_MODE_FUNC_TABLE_PRIO0=IMGL_MemoryMapModule
BRCM_COMP_APP_OPT += ENABLE_IMGL_MMAP_ASYNC_MODE
BRCM_COMP_APP_CFLAGS += -DIMGL_MMAP_SIZE_0=0x200000UL
BRCM_COMP_APP_CFLAGS += -DIMGL_MMAP_ADDR_0=0x60000000UL
BRCM_COMP_APP_CFLAGS += -DIMGL_MEMORY_SIZE_0=0x20000UL
BRCM_COMP_APP_CFLAGS += -DDBG_LOG_ADDR=0x20000000UL

BRCM_COMP_APP_CFLAGS += -DETHERNET_RPC_SERVER_TASK=RPC_ServerTask

BRCM_COMP_APP_CFLAGS += -DSYS_TASK_NAME=SYSTEM_Task
BRCM_COMP_APP_CFLAGS += -DIPC_SYS_MSGQ_EVENT=SystemEvent4

BRCM_COMP_APP_EVENT += UDP_TxEvent
BRCM_COMP_APP_EVENT += UDP_RxEvent

BRCM_COMP_APP_EVENT += SystemEvent0
BRCM_COMP_APP_EVENT += SystemEvent1
BRCM_COMP_APP_EVENT += SystemEvent2
BRCM_COMP_APP_EVENT += SystemEvent3
BRCM_COMP_APP_EVENT += SystemEvent4
BRCM_COMP_APP_EVENT += SystemEvent5
BRCM_COMP_APP_EVENT += SystemEvent6
BRCM_COMP_APP_EVENT += SystemEvent7
BRCM_COMP_APP_EVENT += SystemEvent8
BRCM_COMP_APP_EVENT += SystemEvent9
BRCM_COMP_APP_EVENT += SystemEvent10
BRCM_COMP_APP_EVENT += SystemEvent11
BRCM_COMP_APP_EVENT += SystemEvent12
BRCM_COMP_APP_EVENT += SystemEvent13
BRCM_COMP_APP_EVENT += SystemEvent14
BRCM_COMP_APP_EVENT += SystemEvent15
BRCM_COMP_APP_EVENT += ShutdownEvent

