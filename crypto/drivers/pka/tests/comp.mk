#
# Copyright 2021-2022 Broadcom Limited.  All rights reserved.
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

BRCM_COMP_APP_SRC += qualification/code.c

BRCM_CFLAGS += -DENABLE_SHELL_AUTO_TEST_FUNC=1
BRCM_COMP_APP_CFLAGS += -DBCM_TEST_CONFIG_LOADER

BRCM_COMP_APP_TASK += PkaQT
PkaQT.priority := 13
PkaQT.stack = 2048
PkaQT.group := BCM_GROUPID_SYS
PkaQT.event += PKAEvent

ifneq (,$(filter $(CHIP_FAMILY),bcm8956x bcm8957x))
BRCM_CFLAGS += -DSECHEAP_ALLOW_MEMCMP_CMD
BRCM_CFLAGS += -DPKA_FEATURE_FLAG_RSA_OPS
BRCM_CFLAGS += -DPKA_FEATURE_FLAG_RSA_MOD_2K
BRCM_CFLAGS += -DPKA_FEATURE_FLAG_EC_SECP_256R1
BRCM_CFLAGS += -DPKA_FEATURE_FLAG_ECDSA_SIGN
BRCM_CFLAGS += -DPKA_FEATURE_FLAG_ECDSA_VERIFY
BRCM_CFLAGS += -DPKA_FEATURE_FLAG_ECDHE
endif

ifeq ($(CHIP_FAMILY), bcm8958x)
BRCM_CFLAGS += -DPKA_FEATURE_FLAG_RSA_OPS
BRCM_CFLAGS += -DPKA_FEATURE_FLAG_RSA_MOD_2K
BRCM_CFLAGS += -DPKA_FEATURE_FLAG_EC_SECP_256R1
BRCM_CFLAGS += -DPKA_FEATURE_FLAG_EC_SECP_384R1
BRCM_CFLAGS += -DPKA_FEATURE_FLAG_ECDSA_VERIFY
BRCM_CFLAGS += -DPKAQT_RUN_TARGETED_TESTS
ifeq ($(version),fpga)
PkaQT.autostart = true
endif
endif

BRCM_COMP_APP_OPT += ENABLE_TIME_MODULE

BRCM_COMP_NAME := pka_test
BRCM_COMP_DEPENDS := pka module time
BRCM_COMP_TYPE := test
