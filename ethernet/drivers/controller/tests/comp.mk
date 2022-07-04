#
# Copyright 2016-2021 Broadcom Limited.  All rights reserved.
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

BRCM_COMP_NAME := ethcntlr_test
BRCM_COMP_DEPENDS := ethcntlr
BRCM_COMP_TYPE := test

BRCM_COMP_APP_SRC :=
BRCM_COMP_APP_SRC += qualification/ethernet/ethernet_qt.c

# Integration Test
ifeq ($(ENABLE_INTEGRATION_TEST), TRUE)
BRCM_COMP_APP_SRC += integration/ethernet/ethernet_it.c
BRCM_COMP_APP_CFLAGS += -DENABLE_TEST_SVC=1
BRCM_COMP_APP_CFLAGS += -DENABLE_ETHERNET_IT
endif

BRCM_COMP_APP_OPT += ENABLE_ETHER_TEST
BRCM_COMP_APP_INC += qualification/ethernet/
BRCM_COMP_APP_INC += ../../../common/nif/inc/
BRCM_COMP_APP_INC +=../../switch/inc/
BRCM_COMP_APP_INC +=../inc

ifeq ($(CHIP_FAMILY),bcm8908x)
BRCM_COMP_APP_INC += ../../../../init/bcm8908x/inc/
endif

BRCM_COMP_APP_EVENT += SystemEvent0
BRCM_COMP_APP_CFLAGS += -DETHER_PKT_EVENT=SystemEvent0
BRCM_COMP_APP_CFLAGS += -DMDIO_STATE_HANDLER_EVENT=0
BRCM_COMP_APP_CFLAGS += -DETHER_TIMESTAMP_EVENT=0
BRCM_COMP_APP_CFLAGS += -DETHERNET_NOTIF_EVENT=SystemEvent11
BRCM_COMP_APP_CFLAGS += -DETHERNET_MSGQ_CMD_EVENT=SystemEvent7
BRCM_COMP_APP_CFLAGS += -DMDIO_STATE_HANDLER_TASK=EthIT1_Client
BRCM_COMP_APP_CFLAGS += -DETH_IRQ_PROCESS_TASK=EthIT1_Client

BRCM_COMP_APP_TASK += EthIT1_Client
EthIT1_Client.priority = 2
EthIT1_Client.stack = 2048
EthIT1_Client.event += SystemEvent0
