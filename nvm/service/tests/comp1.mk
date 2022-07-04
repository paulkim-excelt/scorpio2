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

##  @defgroup grp_nvm_service_test NVMSRV
#   @ingroup grp_nvm
#
#   @addtogroup grp_nvm_service_test
#   @{
#
#   @file nvm/service/tests/comp1.mk
#   @brief Makefile for NVMSRV
#   @version 0.1 Initial version
#   @}
#

BRCM_COMP_NAME := nvmsrv_test
BRCM_COMP_DEPENDS := nvmsrv_v2
BRCM_COMP_TYPE := test

BRCM_COMP_APP_OPT      += BCM_TEST_CONFIG_LOADER
BRCM_COMP_APP_CFLAGS   += -DENABLE_SHELL_AUTO_TEST_FUNC=1

BRCM_COMP_UAPP_SRC     += nvm_service_test.c
# Qualification Test
BRCM_COMP_UAPP_SRC     += qualification/service/nvm_service_qt.c

BRCM_COMP_APP_TASK     += NVMSRVQT_Task
NVMSRVQT_Task.priority  = 9
NVMSRVQT_Task.stack     = 2048
NVMSRVQT_Task.event    += SystemEvent0
NVMSRVQT_Task.event    += SystemEvent1
NVMSRVQT_Task.event    += SystemEvent2
NVMSRVQT_Task.event    += SystemEvent3
NVMSRVQT_Task.event    += MODULE_EVENT

BRCM_COMP_APP_CFLAGS += -DFLASH0_EVENT=SystemEvent0
BRCM_COMP_APP_CFLAGS += -DFLASH1_EVENT=SystemEvent1
BRCM_COMP_APP_CFLAGS += -DFLASH_IRQ_PROCESS_TASK=NVM_Service_Task

BRCM_COMP_APP_CFLAGS += -DFLASHM_SERVER_TASK=NVM_Service_Task
BRCM_COMP_APP_OPT += ENABLE_FLASH_MODULE
BRCM_COMP_APP_OPT += ENABLE_OTP_MODULE
ifeq ($(ENABLE_FLASH0), TRUE)
BRCM_COMP_APP_OPT += ENABLE_FLASH0
endif
ifeq ($(ENABLE_FLASH1), TRUE)
BRCM_COMP_APP_OPT += ENABLE_FLASH1
endif
