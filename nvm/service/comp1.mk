#
# Copyright 2022 Broadcom Limited.  All rights reserved.
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



##  @defgroup grp_nvm_service_v2 NVM service
#   @ingroup grp_nvm
#
#   @addtogroup grp_nvm_service_v2
#   @{
#   NVM Service provides task function and Service objects for integration of
#   NVM modules into the system
#
#   @file nvm/service/comp1.mk
#   @brief Makefile for NVM service prototype
#   @version 0.1 Initial version
#   @}
#

BRCM_COMP_NAME := nvmsrv_v2
BRCM_COMP_DEPENDS :=
BRCM_COMP_TYPE := doc

ifeq ($(call isappopt, ENABLE_FLASH_MODULE), yes)
BRCM_COMP_DEPENDS += flashm
endif
ifeq ($(call isappopt, ENABLE_OTP_MODULE), yes)
BRCM_COMP_DEPENDS += otpm
endif

BRCM_COMP_REQ_SRC     += doc/nvm_service_req.c
BRCM_COMP_EXPORT_HDR  += inc/nvm_service.h
BRCM_COMP_EXPORT_HDR  += inc/osil/nvm_service_osil.h

BRCM_COMP_APP_SRC    += os/base/nvm_service_base.c
BRCM_COMP_APP_SRC    += os/common/nvm_service.c

BRCM_COMP_APP_TASK         += NVM_Service_Task
NVM_Service_Task.priority  := 9
NVM_Service_Task.autostart := true
NVM_Service_Task.stack     := 2048
NVM_Service_Task.event     += MODULE_EVENT
NVM_Service_Task.event     += SystemEvent0
NVM_Service_Task.event     += SystemEvent1

ifeq ($(call isappopt, ENABLE_OTP_MODULE), yes)
BRCM_COMP_APP_CFLAGS += -DNVM_OTP_MODULE=OTPM_Module
endif

ifeq ($(call isappopt, ENABLE_FLASH_MODULE), yes)
BRCM_COMP_APP_CFLAGS += -DFLASH0_EVENT=SystemEvent0
BRCM_COMP_APP_CFLAGS += -DFLASH1_EVENT=SystemEvent1
BRCM_COMP_APP_CFLAGS += -DFLASH_IRQ_PROCESS_TASK=NVM_Service_Task
BRCM_COMP_APP_CFLAGS += -DNVM_FLASH_MODULE=FLASHM_Module
BRCM_COMP_APP_CFLAGS += -DIMGL_MODE_FUNC_TABLE_PRIO0=FLASHM_ImglHandler

ifeq ($(ENABLE_FLASH0), TRUE)
BRCM_COMP_APP_OPT += ENABLE_FLASH0
endif
ifeq ($(ENABLE_FLASH1), TRUE)
BRCM_COMP_APP_OPT += ENABLE_FLASH1
endif
endif
