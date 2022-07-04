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
#    OF THE AMOUNT ACTUALLY PAID FOR THE SOFTWARE ITSELF OR U.S. $1, WHICHEVER
#    IS GREATER. THESE LIMITATIONS SHALL APPLY NOTWITHSTANDING ANY FAILURE OF
#    ESSENTIAL PURPOSE OF ANY LIMITED REMEDY.
#
####################################################################################

BRCM_COMP_NAME := ethxcvr_test
BRCM_COMP_DEPENDS := system mcudrv ethxcvr mdiodrv ethutils console uart ethcntlr
BRCM_COMP_TYPE := test

BRCM_COMP_APP_SRC += ethxcvr_test.c

ifeq ($(CHIP_FAMILY),bcm8910x)
BRCM_COMP_UAPP_SRC += endpt_rgmii.c
BRCM_COMP_UAPP_INC += ../../../../crypto/abstract/inc/
endif

BRCM_COMP_APP_OPT += ENABLE_CONSOLE
BRCM_COMP_APP_OPT += ENABLE_UART0

BRCM_COMP_APP_CFLAGS += -DENABLE_SHELL_AUTO_TEST_FUNC=1

BRCM_COMP_APP_TASK          += ETHXCVR_TestTask
ETHXCVR_TestTask.priority   = 4
ETHXCVR_TestTask.autostart  = false
ETHXCVR_TestTask.stack      = 4096
ETHXCVR_TestTask.event      = SystemEvent1

BRCM_COMP_APP_CFG  += ETHXCVR_loadrawtest
ETHXCVR_loadrawtest.pid  = 0x5
ETHXCVR_loadrawtest.imgid  = 0xFF00
ETHXCVR_loadrawtest.maxsz  = 0x2000
ifeq ($(call isappopt,__BCM89564G_EVK__),yes)
ETHXCVR_loadrawtest.file  = ethernet/drivers/transceiver/config/bcm8956x/bcm8956x_config4.bin
else ifeq ($(call isappopt,__BCM89561_EVK__),yes)
ETHXCVR_loadrawtest.file  = ethernet/drivers/transceiver/config/bcm8956x/bcm8956x_config1.bin
else ifeq ($(call isappopt,__BCM89571_EVK__),yes)
ETHXCVR_loadrawtest.file  = ethernet/drivers/transceiver/config/bcm8957x/bcm8957x_config1.bin
else ifeq ($(call isappopt,__BCM89572_EVK__),yes)
ETHXCVR_loadrawtest.file  = ethernet/drivers/transceiver/config/bcm8957x/bcm8957x_config1.bin
else ifeq ($(CHIP_FAMILY),bcm8910x)
ETHXCVR_loadrawtest.file  = ethernet/drivers/transceiver/config/bcm8910x/bcm8910x_master.bin
else ifeq ($(CHIP_FAMILY),bcm8908x)
ETHXCVR_loadrawtest.file  = ethernet/drivers/transceiver/config/bcm8908x/bcm8908x_master.bin
endif

BRCM_COMP_APP_CFLAGS += -DETHXCVR_IRQ_PROCESS_TASK=ETHXCVR_TestTask
BRCM_COMP_APP_CFLAGS += -DETHXCVR_TASK=ETHXCVR_TestTask
BRCM_COMP_APP_CFLAGS += -DETHXCVR_LINK_EVENT=0
BRCM_COMP_APP_CFLAGS += -DMDIO_STATE_HANDLER_TASK=ETHXCVR_TestTask
BRCM_COMP_APP_CFLAGS += -DMDIO_STATE_HANDLER_EVENT=0
BRCM_COMP_APP_CFLAGS += -DETH_IRQ_PROCESS_TASK=ETHXCVR_TestTask
BRCM_COMP_APP_CFLAGS += -DETHER_PKT_EVENT=0
BRCM_COMP_APP_CFLAGS += -DETHER_TIMESTAMP_EVENT=0
BRCM_COMP_APP_CFLAGS += -DETHERSWT_IRQ_PROCESS_TASK=ETHXCVR_TestTask
BRCM_COMP_APP_CFLAGS += -DETHERSWT_PORT_LINK_EVENT=0
BRCM_COMP_APP_CFLAGS += -DETHSWT_FA_PROCESS_TASK=ETHXCVR_TestTask
BRCM_COMP_APP_CFLAGS += -DETHSWT_FA_PROCESS_IRQ_EVENT=0
ifeq ($(ENABLE_ETH_DENALIPHY), TRUE)
BRCM_COMP_APP_CFLAGS += -DENABLE_ETH_DENALIPHY
endif
BRCM_COMP_APP_CFLAGS += -DENABLE_ETH -DENABLE_ETHXCVRM -DENABLE_ETH_AMAC
BRCM_COMP_APP_CFLAGS += -DENABLE_TIM_CHANN1_CB
