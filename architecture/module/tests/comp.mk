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
#    OF THE AMOUNT ACTUALLY PAID FOR THE SOFTWARE ITSELF OR U.S. $1, WHICHEVER
#    IS GREATER. THESE LIMITATIONS SHALL APPLY NOTWITHSTANDING ANY FAILURE OF
#    ESSENTIAL PURPOSE OF ANY LIMITED REMEDY.
#
####################################################################################

BRCM_COMP_NAME := module_test
BRCM_COMP_DEPENDS :=
BRCM_COMP_TYPE := test

BRCM_COMP_APP_OPT += BCM_TEST_CONFIG_LOADER

BRCM_COMP_APP_SRC += qualification/module_test.c

BRCM_COMP_APP_CFLAGS += -DENABLE_SHELL_AUTO_TEST_FUNC=1

BRCM_COMP_APP_TASK        += SERVICE1_Task
SERVICE1_Task.priority   = 2
SERVICE1_Task.autostart  = true
SERVICE1_Task.stack      = 2048
SERVICE1_Task.event     += BCM_TEST_LOAD_EVENT
SERVICE1_Task.event     += MODULE_EVENT

BRCM_COMP_APP_TASK        += BCM_MODTestTask
BCM_MODTestTask.priority   = 4
BCM_MODTestTask.autostart  = false
BCM_MODTestTask.stack      = 2048
BCM_MODTestTask.event     += BCM_TEST_LOAD_EVENT
BCM_MODTestTask.event     += MODULE_EVENT

BRCM_COMP_APP_CFG   += bcm_test_data1
bcm_test_data1.pid   = 0x5
bcm_test_data1.imgid = 0xFF00
bcm_test_data1.maxsz = 0x3E8
bcm_test_data1.file  = architecture/module/tests/qualification/bcm_test.bin

BRCM_COMP_APP_CFG   += bcm_test_data2
bcm_test_data2.pid   = 0x5
bcm_test_data2.imgid = 0xFF01
bcm_test_data2.maxsz = 0x3E8
bcm_test_data2.file  = architecture/module/tests/qualification/bcm_test.bin

BRCM_COMP_APP_CFG   += bcm_test_data3
bcm_test_data3.pid   = 0x5
bcm_test_data3.imgid = 0xFF02
bcm_test_data3.maxsz = 0x3E8
bcm_test_data3.file  = architecture/module/tests/qualification/bcm_test.bin

ifeq ($(cpu),m7)
BRCM_COMP_APP_CFLAGS += -DMODULE_EN_LOAD_CFG_TEST
endif

# Integration Test
ifeq ($(ENABLE_INTEGRATION_TEST), TRUE)
BRCM_COMP_APP_CFLAGS += -DENABLE_MODULE_IT
BRCM_COMP_APP_SRC += integration/module_it.c
endif