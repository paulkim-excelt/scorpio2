#
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
#    OF THE AMOUNT ACTUALLY PAID FOR THE SOFTWARE ITSELF OR U.S. $1, WHICHEVER
#    IS GREATER. THESE LIMITATIONS SHALL APPLY NOTWITHSTANDING ANY FAILURE OF
#    ESSENTIAL PURPOSE OF ANY LIMITED REMEDY.
#
####################################################################################

BRCM_COMP_NAME := otpm_test
BRCM_COMP_DEPENDS := otpm
BRCM_COMP_TYPE := test

BRCM_COMP_APP_OPT += BCM_TEST_CONFIG_LOADER
BRCM_COMP_APP_CFLAGS += -DENABLE_OTP_MODULE_TEST
BRCM_COMP_UAPP_SRC += otpm_test.c

# Qualification Test
ifeq ($(cpu),em22fs)
BRCM_COMP_UAPP_SRC += qualification/otpm_hsm_qt.c
BRCM_COMP_APP_TASK += OTPMQT_Task
OTPMQT_Task.priority = 2
OTPMQT_Task.stack = 2048
BRCM_COMP_APP_CFLAGS += -DENABLE_TEST_SVC=1
else
BRCM_COMP_APP_CFLAGS += -DOTPM_M7_TEST_SVC_HANDLER
BRCM_COMP_APP_CFLAGS += -DOTPM_M7_COVERAGE_TEST
BRCM_COMP_UAPP_SRC += qualification/otpm_qt.c
BRCM_COMP_UAPP_SRC += qualification/otpm_neg_qt.c
BRCM_COMP_APP_TASK += OTPMQT_Task
OTPMQT_Task.priority = 2
OTPMQT_Task.stack = 2048

# Coverage Test
#ifeq ($(ENABLE_COVERAGE_TEST), TRUE)
BRCM_COMP_UAPP_SRC += coverage/otpm_ct.c

BRCM_COMP_APP_TASK += OTPMCT_Task
OTPMCT_Task.priority = 2
OTPMCT_Task.stack = 2048
#endif

ifeq ($(CHIP_FAMILY),bcm8957x)
BRCM_COMP_UAPP_SRC += qualification/otpm_sec_qt.c
BRCM_COMP_APP_TASK += OTPMSECQT_Task
OTPMSECQT_Task.priority = 2
OTPMSECQT_Task.stack = 2048
endif

BRCM_COMP_APP_CFLAGS += -DENABLE_TEST_SVC=1
BRCM_COMP_DEPENDS += mcudrv
endif


