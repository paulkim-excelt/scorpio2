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
#
####################################################################################

BRCM_COMP_NAME := cfp_test
BRCM_COMP_DEPENDS := time nif ethswitch ethxcvr
BRCM_COMP_TYPE := test

ENABLE_ETHXCVRM = FALSE
BRCM_COMP_APP_INC += ../../../../system/service/inc/
BRCM_COMP_APP_INC += qualification/cfp/
BRCM_COMP_APP_INC += ../inc/
BRCM_COMP_APP_INC += ../inc/osil/
BRCM_COMP_APP_INC += ../../transceiver/inc/
BRCM_COMP_APP_INC += ../../transceiver/inc/osil/

BRCM_COMP_UAPP_SRC += qualification/cfp/cfp_qt.c
BRCM_COMP_UAPP_SRC += qualification/cfp/nif_test_cfg.c

BRCM_COMP_APP_CFLAGS  += -DENABLE_SHELL_AUTO_TEST_FUNC=1
BRCM_COMP_APP_CFLAGS += -DETHER_PKT_EVENT=SystemEvent0
BRCM_COMP_APP_CFLAGS += -DMDIO_STATE_HANDLER_EVENT=0
BRCM_COMP_APP_CFLAGS += -DETHER_TIMESTAMP_EVENT=0
BRCM_COMP_APP_CFLAGS += -DETHERSWT_PORT_LINK_EVENT=0
BRCM_COMP_APP_CFLAGS += -DETHSWT_FA_PROCESS_IRQ_EVENT=0
BRCM_COMP_APP_CFLAGS += -DETHXCVR_LINK_EVENT=0

BRCM_COMP_APP_CFLAGS += -DMDIO_STATE_HANDLER_TASK=CFPPktEventTask
BRCM_COMP_APP_CFLAGS += -DETH_IRQ_PROCESS_TASK=CFPPktEventTask
BRCM_COMP_APP_CFLAGS += -DETHERSWT_IRQ_PROCESS_TASK=CFPTest
BRCM_COMP_APP_CFLAGS += -DETHSWT_FA_PROCESS_TASK=CFPTest
BRCM_COMP_APP_CFLAGS += -DETHXCVR_IRQ_PROCESS_TASK=CFPTest

BRCM_COMP_APP_OPT += ENABLE_SYSTEM_SERVICE
BRCM_COMP_APP_OPT += ENABLE_TIME_MODULE
BRCM_COMP_APP_OPT += ENABLE_ETH_SWT_ADAPT
BRCM_COMP_APP_OPT += BCM_TEST_CONFIG_LOADER
BRCM_COMP_APP_OPT += ENABLE_ETHXCVR_TEST
BRCM_COMP_APP_OPT += ENABLE_ETHXCVRM

BRCM_COMP_APP_TASK += CFPTest
CFPTest.priority = 10
CFPTest.stack = 2048
CFPTest.event += SystemEvent6

BRCM_COMP_APP_TASK += CFPMaskTest
CFPMaskTest.priority = 10
CFPMaskTest.stack = 2048
CFPMaskTest.event += SystemEvent6

BRCM_COMP_APP_TASK += CFPPktEventTask
CFPPktEventTask.priority = 8
CFPPktEventTask.stack = 2048
CFPPktEventTask.event += SystemEvent0

BRCM_COMP_APP_ALARM        += DelayTimerAlarm
DelayTimerAlarm.counter      := SystemTimer
DelayTimerAlarm.callback     := DelayTimerAlarmCb
DelayTimerAlarm.declaration  := qualification/cfp/cfp_test.h
DelayTimerAlarm.autostart    := false
DelayTimerAlarm.alarmtime    := 20
DelayTimerAlarm.cycletime    := 0
