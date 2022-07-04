#
# Copyright 2019-2021 Broadcom Limited.  All rights reserved.
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
#
####################################################################################

BRCM_COMP_NAME := mdio_test
BRCM_COMP_DEPENDS := mdiodrv
BRCM_COMP_TYPE := test

BRCM_COMP_APP_SRC :=
BRCM_COMP_APP_SRC += qualification/mdio_test.c

ifeq ($(CHIP_FAMILY),bcm8953x)
BRCM_COMP_APP_SRC += qualification/mdio_switch_cfg_v1_test.c
endif

ifneq (,$(filter $(CHIP_FAMILY),bcm8956x bcm8957x bcm8958x))
BRCM_COMP_APP_SRC += qualification/mdio_switch_cfg_v2_test.c
endif

ifeq ($(CHIP_FAMILY),bcm8910x)
BRCM_COMP_APP_SRC += qualification/mdio_endpt_cfg.c
endif

ifeq ($(CHIP_FAMILY),bcm8908x)
BRCM_COMP_APP_SRC += qualification/mdio_endpt_cfg.c
endif

BRCM_COMP_APP_CFLAGS += -DENABLE_TEST_SVC=1
BRCM_COMP_APP_CFLAGS += -DETHER_PKT_EVENT=0
BRCM_COMP_APP_CFLAGS += -DETH_IRQ_PROCESS_TASK=TaskMdioTest

BRCM_COMP_APP_CFLAGS += -DMdioTestEvent=SystemEvent8
BRCM_COMP_APP_CFLAGS += -DMDIO_STATE_HANDLER_TASK=TaskMdioTest
BRCM_COMP_APP_CFLAGS += -DMDIO_STATE_HANDLER_EVENT=0

BRCM_COMP_APP_TASK += TaskMdioTest
TaskMdioTest.priority = 2
TaskMdioTest.stack = 2048

