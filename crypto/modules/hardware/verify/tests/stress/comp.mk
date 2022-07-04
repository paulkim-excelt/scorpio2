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

BRCM_COMP_NAME := crypto_verify_stress_test
BRCM_COMP_DEPENDS := crypto_verify_hw
BRCM_COMP_TYPE := test

BRCM_COMP_APP_SRC += crypto_verify_stress_test.c

BRCM_COMP_APP_CFLAGS += -DBCM_TEST_CONFIG_LOADER
BRCM_COMP_APP_CFLAGS += -DENABLE_SHELL_AUTO_TEST_FUNC=1

ifeq ($(CHIP_FAMILY), bcm8958x)
BRCM_COMP_APP_OPT += ENABLE_TIMER_ARC
endif
BRCM_COMP_APP_OPT += ENABLE_TIME_MODULE

BRCM_COMP_APP_EVENT += SystemEvent0 #Test alarm

BRCM_COMP_APP_TASK += CRYPTOTEST_Task
CRYPTOTEST_Task.priority = 2
CRYPTOTEST_Task.stack = 2048
CRYPTOTEST_Task.event += SystemEvent0
CRYPTOTEST_Task.autostart = true

BRCM_COMP_APP_TASK += CRYPTOTEST_ServerTask
CRYPTOTEST_ServerTask.priority = 3
CRYPTOTEST_ServerTask.stack = 2048
CRYPTOTEST_ServerTask.event += MODULE_EVENT

BRCM_COMP_APP_CFLAGS += -DCRYPTO_TASK_NAME=CRYPTOTEST_ServerTask
