###############################################################################
# Copyright 2017-2021 Broadcom Limited.  All rights reserved.
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

BRCM_COMP_NAME := msgq_test
BRCM_COMP_DEPENDS :=
BRCM_COMP_TYPE := test

BRCM_COMP_APP_CFLAGS += -DENABLE_SHELL_AUTO_TEST_FUNC=1
BRCM_COMP_APP_CFLAGS += -DENABLE_TEST_SVC=1

BRCM_COMP_APP_SRC += msg_queue_test.c

# Qualification Test
BRCM_COMP_APP_SRC += qualification/msg_queue_qt.c
BRCM_COMP_APP_SRC += qualification/msg_queue_qt1.c
BRCM_COMP_APP_SRC += qualification/msg_queue_qt2.c
BRCM_COMP_APP_SRC += qualification/msg_queue_qt3.c
BRCM_COMP_APP_SRC += qualification/msg_queue_qt4.c

BRCM_COMP_APP_CFLAGS += -DMsgQQT1_TriggerServer=SystemEvent0
BRCM_COMP_APP_CFLAGS += -DMsgQQT1_TriggerClient1=SystemEvent1
BRCM_COMP_APP_CFLAGS += -DMsgQQT1_TriggerClient2=SystemEvent2
BRCM_COMP_APP_CFLAGS += -DMsgQQT2_TriggerServer=SystemEvent3
BRCM_COMP_APP_CFLAGS += -DMsgQQT3_TriggerServer=SystemEvent4
BRCM_COMP_APP_CFLAGS += -DMsgQQT4_TriggerServer=SystemEvent5
BRCM_COMP_APP_CFLAGS += -DMsgQQT4_TriggerClient1=SystemEvent6
BRCM_COMP_APP_CFLAGS += -DMsgQQT4_TriggerClient2=SystemEvent7

BRCM_COMP_APP_TASK += MsgQQT1_ServerTask
MsgQQT1_ServerTask.priority =4
MsgQQT1_ServerTask.stack = 1024
MsgQQT1_ServerTask.event += MsgQQT1_TriggerServer

BRCM_COMP_APP_TASK += MsgQQT1_TaskClient1
MsgQQT1_TaskClient1.priority = 5
MsgQQT1_TaskClient1.stack = 1024
MsgQQT1_TaskClient1.event += MsgQQT1_TriggerClient1

BRCM_COMP_APP_TASK += MsgQQT1_TaskClient2
MsgQQT1_TaskClient2.priority = 3
MsgQQT1_TaskClient2.stack = 1024
MsgQQT1_TaskClient2.event += MsgQQT1_TriggerClient2

BRCM_COMP_APP_TASK += MsgQQT2_ServerTask
MsgQQT2_ServerTask.priority = 4
MsgQQT2_ServerTask.stack = 1024
MsgQQT2_ServerTask.event += MsgQQT2_TriggerServer

BRCM_COMP_APP_TASK += MsgQQT2_TaskClient1
MsgQQT2_TaskClient1.priority = 5
MsgQQT2_TaskClient1.stack = 1024

BRCM_COMP_APP_TASK += MsgQQT2_TaskClient2
MsgQQT2_TaskClient2.priority = 3
MsgQQT2_TaskClient2.stack = 1024

BRCM_COMP_APP_TASK += MsgQQT3_ServerTask
MsgQQT3_ServerTask.priority = 4
MsgQQT3_ServerTask.stack = 1024
MsgQQT3_ServerTask.event += MsgQQT3_TriggerServer

BRCM_COMP_APP_TASK += MsgQQT3_TaskClient1
MsgQQT3_TaskClient1.priority = 5
MsgQQT3_TaskClient1.stack = 1024

BRCM_COMP_APP_TASK += MsgQQT3_TaskClient2
MsgQQT3_TaskClient2.priority = 3
MsgQQT3_TaskClient2.stack = 1024

BRCM_COMP_APP_TASK += MsgQQT4_ServerTask
MsgQQT4_ServerTask.priority =4
MsgQQT4_ServerTask.stack = 1024
MsgQQT4_ServerTask.event += MsgQQT4_TriggerServer

BRCM_COMP_APP_TASK += MsgQQT4_TaskClient1
MsgQQT4_TaskClient1.priority = 5
MsgQQT4_TaskClient1.stack = 1024
MsgQQT4_TaskClient1.event += MsgQQT4_TriggerClient1

BRCM_COMP_APP_TASK += MsgQQT4_TaskClient2
MsgQQT4_TaskClient2.priority = 3
MsgQQT4_TaskClient2.stack = 1024
MsgQQT4_TaskClient2.event += MsgQQT4_TriggerClient2

# Integration Test
ifeq ($(ENABLE_INTEGRATION_TEST), TRUE)
BRCM_COMP_APP_CFLAGS += -DENABLE_MSGQ_IT
BRCM_COMP_UAPP_SRC += integration/msg_queue_it.c

BRCM_COMP_APP_EVENT += MsgQIT_TriggerServer
BRCM_COMP_APP_EVENT += MsgQIT_TriggerClient1
BRCM_COMP_APP_EVENT += MsgQIT_TriggerClient2

BRCM_COMP_APP_TASK += MsgQIT_MiscTestTask
MsgQIT_MiscTestTask.priority = 3
MsgQIT_MiscTestTask.stack = 1024

BRCM_COMP_APP_TASK += MsgQIT_ServerTask
MsgQIT_ServerTask.priority =4
MsgQIT_ServerTask.stack = 1024
MsgQIT_ServerTask.event += MsgQIT_TriggerServer

BRCM_COMP_APP_TASK += MsgQIT_TaskClient1
MsgQIT_TaskClient1.priority = 5
MsgQIT_TaskClient1.stack = 1024
MsgQIT_TaskClient1.event += MsgQIT_TriggerClient1

BRCM_COMP_APP_TASK += MsgQIT_TaskClient2
MsgQIT_TaskClient2.priority = 3
MsgQIT_TaskClient2.stack = 1024
MsgQIT_TaskClient2.event += MsgQIT_TriggerClient2
endif

# Coverage Test
ifeq ($(ENABLE_COVERAGE_TEST), TRUE)
# BRCM_COMP_APP_CFLAGS += -DENABLE_MSGQ_COVERAGE
# BRCM_COMP_UAPP_SRC += coverage/msg_queue_ct.c
endif
