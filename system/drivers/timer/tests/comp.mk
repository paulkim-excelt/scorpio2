##############################################################################
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
################################################################################

BRCM_COMP_NAME := timer_test
BRCM_COMP_DEPENDS := timdrv
BRCM_COMP_TYPE := test

BRCM_COMP_APP_CFLAGS += -DENABLE_TEST_SVC=1

BRCM_COMP_UAPP_SRC += timer_test.c

BRCM_COMP_APP_CFLAGS += -DENABLE_TIM_CHANN0_CB
BRCM_COMP_APP_CFLAGS += -DENABLE_TIM_CHANN1_CB

ifeq ($(cpu),em22fs)
BRCM_COMP_APP_CFLAGS += -DTIM_CLOCK=CPU_CLOCK
endif

BRCM_COMP_APP_EVENT += TimerTestCh0Event
BRCM_COMP_APP_EVENT += TimerTestCh1Event

# Qualification Test
BRCM_COMP_UAPP_SRC += qualification/timer_qt.c

BRCM_COMP_APP_EVENT += TimerQtCh0Event
BRCM_COMP_APP_EVENT += TimerQtCh1Event
BRCM_COMP_APP_TASK += TIMERQT_Task
TIMERQT_Task.priority = 2
TIMERQT_Task.stack = 2048
TIMERQT_Task.event += TimerQtCh0Event
TIMERQT_Task.event += TimerQtCh1Event

# Integration Test
ifeq ($(ENABLE_INTEGRATION_TEST), TRUE)
BRCM_COMP_APP_CFLAGS += -DENABLE_TIMER_IT
BRCM_COMP_UAPP_SRC += integration/timer_it.c

BRCM_COMP_APP_EVENT += TimerItCh0Event
BRCM_COMP_APP_EVENT += TimerItCh1Event
BRCM_COMP_APP_TASK += TIMERIT_Task
TIMERIT_Task.priority = 2
TIMERIT_Task.stack = 2048
TIMERIT_Task.event += TimerItCh0Event
TIMERIT_Task.event += TimerItCh1Event
endif

# Coverage Test
ifeq ($(ENABLE_COVERAGE_TEST), TRUE)
BRCM_COMP_APP_CFLAGS += -DENABLE_TIMER_COVERAGE
BRCM_COMP_UAPP_SRC += coverage/timer_ct.c

BRCM_COMP_APP_EVENT += TimerCtCh0Event
BRCM_COMP_APP_EVENT += TimerCtCh1Event
BRCM_COMP_APP_TASK += TIMERCT_Task
TIMERCT_Task.priority = 2
TIMERCT_Task.stack = 2048
TIMERCT_Task.event += TimerCtCh0Event
TIMERCT_Task.event += TimerCtCh1Event
endif
