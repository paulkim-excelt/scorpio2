#
# Copyright 2018-2022 Broadcom Limited.  All rights reserved.
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
#    OF THE AMOUNT ACTUALLY PAID FOR THE SOFTWARE ITSELF OR U.S. $1, WHICHEVER
#    IS GREATER. THESE LIMITATIONS SHALL APPLY NOTWITHSTANDING ANY FAILURE OF
#    ESSENTIAL PURPOSE OF ANY LIMITED REMEDY.
####################################################################################
#
####################################################################################
# File Name:  comp.mk
# Description: This file defines the component name, dependencies and type
####################################################################################


BRCM_COMP_NAME := etscomp_test
BRCM_COMP_DEPENDS := ets
BRCM_COMP_TYPE := test


BRCM_COMP_APP_OPT += ENABLE_ETHER_TEST
BRCM_COMP_APP_OPT += ENABLE_ETS_AVNU
BRCM_COMP_APP_OPT += BCM_TEST_CONFIG_LOADER
ifneq (,$(filter $(CHIP_FAMILY),bcm8956x bcm8957x))
BRCM_COMP_APP_OPT += ENABLE_RPC_V2
endif

BRCM_COMP_APP_INC += ../../../inc
BRCM_COMP_APP_INC += ../../../inc/osil
BRCM_COMP_APP_INC += ../../../../../crypto/abstract/inc/
BRCM_COMP_APP_INC += ../../../../../system/rpc/local/inc/osil/

BRCM_COMP_APP_CFLAGS += -DENABLE_SHELL_AUTO_TEST_FUNC=1
BRCM_COMP_APP_CFLAGS += -DENABLE_MAC1=1

BRCM_COMP_APP_CFLAGS += -DETH_IRQ_PROCESS_TASK=ETSCOMPTestTask
BRCM_COMP_APP_CFLAGS += -DETSM_TASK=ETSCOMPTestTask
BRCM_COMP_APP_CFLAGS += -DETHXCVR_IRQ_PROCESS_TASK=ETSCOMPTestTask
BRCM_COMP_APP_CFLAGS += -DMDIO_STATE_HANDLER_TASK=ETSCOMPTestTask
BRCM_COMP_APP_CFLAGS += -DETHERSWT_IRQ_PROCESS_TASK=ETSCOMPTestTask
BRCM_COMP_APP_CFLAGS += -DETHSWT_FA_PROCESS_TASK=ETSCOMPTestTask

BRCM_COMP_APP_CFLAGS += -DETHER_PKT_EVENT=SystemEvent0
BRCM_COMP_APP_CFLAGS += -DETS_TIMER_EVENT=SystemEvent1
BRCM_COMP_APP_CFLAGS += -DETHER_TIMESTAMP_EVENT=0
BRCM_COMP_APP_CFLAGS += -DETHXCVR_LINK_EVENT=0
BRCM_COMP_APP_CFLAGS += -DMDIO_STATE_HANDLER_EVENT=0
BRCM_COMP_APP_CFLAGS += -DETHERSWT_PORT_LINK_EVENT=0
BRCM_COMP_APP_CFLAGS += -DETHSWT_FA_PROCESS_IRQ_EVENT=0

BRCM_COMP_UAPP_SRC += code.c
BRCM_COMP_UAPP_SRC += nif.c
BRCM_COMP_UAPP_SRC += ../../../os/common/etsm.c
BRCM_COMP_UAPP_SRC += ../../../os/common/ets_il.c
BRCM_COMP_UAPP_SRC += ../../../os/common/ets_endpt.c

BRCM_COMP_APP_TASK += ETSCOMPTestTask
ETSCOMPTestTask.priority = 11
ETSCOMPTestTask.stack = 4096
ETSCOMPTestTask.event += SystemEvent0
ETSCOMPTestTask.event += SystemEvent1
