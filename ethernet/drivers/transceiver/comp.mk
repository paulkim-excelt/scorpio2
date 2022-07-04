#
# Copyright 2017-2022 Broadcom Limited.  All rights reserved.
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

##  @defgroup grp_eth_xcvrdrv Ethernet Transceiver Driver
#   @ingroup grp_ethernet
#
#   @addtogroup grp_eth_xcvrdrv
#   @{
#   @file ethernet/drivers/transceiver/comp.mk
#   @brief Makefile for Ethernet Transceiver Driver
#   @version 0.1 Initial version
#   @}

BRCM_COMP_NAME := ethxcvr
BRCM_COMP_DEPENDS := mdiodrv ethernet
BRCM_COMP_TYPE := lib

BRCM_COMP_REQ_SRC += doc/ethxcvr_req.c
BRCM_COMP_REQ_SRC += doc/rgmii_req.c
BRCM_COMP_EXPORT_HDR += inc/ethxcvr.h
BRCM_COMP_EXPORT_HDR += inc/osil/ethxcvr_osil.h
BRCM_COMP_EXPORT_HDR += inc/osil/rgmii_osil.h
BRCM_COMP_EXPORT_HDR += inc/osil/ethxcvr_board.h
BRCM_COMP_LIB_INC += lib/ethxcvr_drv.h
BRCM_COMP_LIB_SRC += lib/ethxcvr.c
BRCM_COMP_LIB_SRC += lib/ethxcvr_drv.c
BRCM_COMP_LIB_INC += lib/ethxcvr_platform.h
BRCM_COMP_APP_SRC += os/erika/ethxcvr_osil.c

ifeq ($(ENABLE_ETH_BRPHY), TRUE)
BRCM_COMP_LIB_CFLAGS += -DENABLE_ETH_BRPHY
BRCM_COMP_LIB_INC += lib/brphy_common.h
BRCM_COMP_REQ_SRC += doc/brphy_req.c
BRCM_COMP_EXPORT_HDR += inc/osil/brphy_osil.h
BRCM_COMP_LIB_SRC += lib/brphy_common.c

ifeq ($(CHIP_FAMILY),bcm8956x)
ifeq ($(strip $(version)),a0)
BRCM_COMP_LIB_SRC += lib/brphy_v3.c
BRCM_COMP_REQ_SRC += doc/brphy_v3_req.c
else
BRCM_COMP_LIB_SRC += lib/brphy_v2.c
BRCM_COMP_REQ_SRC += doc/brphy_v2_req.c
endif
endif

ifeq ($(CHIP_FAMILY),bcm8908x)
BRCM_COMP_LIB_SRC += lib/brphy_v2.c
BRCM_COMP_REQ_SRC += doc/brphy_v2_req.c
endif

ifeq ($(CHIP_FAMILY),bcm8953x)
BRCM_COMP_LIB_SRC += lib/brphy_v1.c
BRCM_COMP_REQ_SRC += doc/brphy_v1_req.c
endif

ifeq ($(CHIP_FAMILY),bcm8910x)
BRCM_COMP_LIB_SRC += lib/brphy_v1.c
BRCM_COMP_REQ_SRC += doc/brphy_v1_req.c
endif

ifeq ($(CHIP_FAMILY),bcm8957x)
BRCM_COMP_LIB_SRC += lib/brphy_v2.c
BRCM_COMP_REQ_SRC += doc/brphy_v2_req.c
endif
endif


ifeq ($(ENABLE_PCIE), TRUE)
BRCM_COMP_REQ_SRC += doc/pcie_req.c
BRCM_COMP_EXPORT_HDR += inc/osil/pcie_osil.h
BRCM_COMP_LIB_SRC += lib/pcie.c
BRCM_COMP_LIB_CFLAGS += -DENABLE_PCIE
endif

ifeq ($(ENABLE_ETH_SGMII), TRUE)
BRCM_COMP_LIB_INC += lib/sgmii_common.h
BRCM_COMP_EXPORT_HDR += inc/osil/sgmii_osil.h
BRCM_COMP_LIB_SRC += lib/sgmii_common.c
BRCM_COMP_REQ_SRC += doc/sgmii_req.c
BRCM_COMP_LIB_CFLAGS += -DENABLE_ETH_SGMII

ifneq (,$(filter $(CHIP_FAMILY),bcm8956x bcm8957x))
BRCM_COMP_LIB_SRC += lib/sgmii_v2.c
BRCM_COMP_REQ_SRC += doc/sgmii_v2_req.c
endif#bcm8956x/bcm8957x

ifeq ($(CHIP_FAMILY),bcm8953x)
BRCM_COMP_LIB_SRC += lib/sgmii_v1.c
BRCM_COMP_REQ_SRC += doc/sgmii_v1_req.c
endif#bcm8953x

endif #ENABLE_ETH_SGMII

ifeq ($(ENABLE_ETH_DENALIPHY), TRUE)
BRCM_COMP_LIB_SRC += lib/denaliphy.c
BRCM_COMP_REQ_SRC += doc/denaliphy_req.c
BRCM_COMP_EXPORT_HDR += inc/osil/denaliphy_osil.h
BRCM_COMP_LIB_CFLAGS += -DENABLE_ETH_DENALIPHY
endif

ifeq ($(ENABLE_ETH_BRPHY1G_V2), TRUE)
BRCM_COMP_REQ_SRC += doc/brphy1g_v2_req.c
BRCM_COMP_EXPORT_HDR += inc/osil/brphy1g_v2_osil.h
BRCM_COMP_LIB_SRC += lib/brphy1g_v2.c
BRCM_COMP_LIB_CFLAGS += -DENABLE_ETH_BRPHY1G_V2
endif

ifeq ($(ENABLE_ETH_SGMIIPLUSR), TRUE)
BRCM_COMP_REQ_SRC += doc/sgmiiplusr_req.c
BRCM_COMP_EXPORT_HDR += inc/osil/sgmiiplusr_osil.h
BRCM_COMP_LIB_SRC += lib/sgmiiplusr.c
BRCM_COMP_LIB_CFLAGS += -DENABLE_ETH_SGMIIPLUSR
endif

ifeq ($(ENABLE_ETHXCVR_RGMII_ISOLATE), TRUE)
BRCM_CFLAGS += -DENABLE_ETHXCVR_RGMII_ISOLATE
endif

ifeq ($(CHIP_FAMILY),bcm8908x)
BRCM_COMP_REQ_SRC += doc/ethxcvr_bcm8908x_req.c
BRCM_COMP_LIB_SRC += lib/bcm8908x/ethxcvr_platform.c
BRCM_CFLAGS += -DETHXCVR_MAX_CONTROLLERS=0UL
endif

ifeq ($(CHIP_FAMILY),bcm8956x)
BRCM_COMP_REQ_SRC += doc/ethxcvr_bcm8956x_req.c
BRCM_COMP_REQ_SRC += doc/rgmii_req.c
BRCM_COMP_EXPORT_HDR += inc/osil/dummyphy_osil.h
BRCM_COMP_LIB_SRC += lib/bcm8956x/ethxcvr_platform.c
BRCM_COMP_LIB_SRC += lib/rgmii.c
BRCM_COMP_LIB_SRC += lib/dummyphy.c
BRCM_COMP_LIB_CFLAGS += -DETHXCVR_MAX_CONTROLLERS=18UL
BRCM_COMP_LIB_CFLAGS += -DETHXCVR_SHARED_CONTROLLERS
ifeq ($(call isappopt,__BCM89564G_EVK__),yes)
BRCM_COMP_APP_SRC += os/platform/bcm8956x/89564g_evk/ethxcvr_board.c
endif
ifeq ($(call isappopt,__BCM89561_EVK__),yes)
BRCM_COMP_APP_SRC += os/platform/bcm8956x/89561_evk/ethxcvr_board.c
endif
BRCM_COMP_QT_SRC += tests/qualification/ethxcvr_configvalidator_qt/bcm8956x/ethxcvr_configvalidator_qt.h
endif

ifeq ($(CHIP_FAMILY),bcm8957x)
BRCM_COMP_REQ_SRC += doc/ethxcvr_bcm8957x_req.c
BRCM_COMP_REQ_SRC += doc/rgmii_req.c
BRCM_COMP_EXPORT_HDR += inc/osil/dummyphy_osil.h
BRCM_COMP_LIB_SRC += lib/bcm8957x/ethxcvr_platform.c
BRCM_COMP_LIB_SRC += lib/rgmii.c
BRCM_COMP_LIB_SRC += lib/dummyphy.c
BRCM_COMP_LIB_CFLAGS += -DETHXCVR_MAX_CONTROLLERS=18UL
BRCM_COMP_LIB_CFLAGS += -DETHXCVR_SHARED_CONTROLLERS
ifeq ($(call isappopt,__BCM89571_EVK__),yes)
BRCM_COMP_APP_SRC += os/platform/bcm8957x/89571_evk/ethxcvr_board.c
endif
ifeq ($(call isappopt,__BCM89572_EVK__),yes)
BRCM_COMP_APP_SRC += os/platform/bcm8957x/89571_evk/ethxcvr_board.c
endif
endif

ifeq ($(CHIP_FAMILY),bcm8910x)
BRCM_COMP_REQ_SRC += doc/ethxcvr_bcm8910x_req.c
BRCM_COMP_REQ_SRC += doc/rgmii_req.c
BRCM_COMP_LIB_SRC += lib/bcm8910x/ethxcvr_platform.c
BRCM_COMP_LIB_SRC += lib/rgmii.c
BRCM_COMP_APP_SRC += os/platform/bcm8910x/ethxcvr_board.c
BRCM_CFLAGS += -DETHXCVR_MAX_CONTROLLERS=0UL
endif

ifeq ($(CHIP_FAMILY),bcm8953x)
BRCM_COMP_REQ_SRC += doc/ethxcvr_bcm8953x_req.c
BRCM_COMP_REQ_SRC += doc/rgmii_req.c
BRCM_COMP_LIB_SRC += lib/bcm8953x/ethxcvr_platform.c
BRCM_COMP_LIB_SRC += lib/rgmii.c
BRCM_COMP_APP_SRC += os/platform/bcm8953x/ethxcvr_board.c
BRCM_CFLAGS += -DETHXCVR_MAX_CONTROLLERS=0UL
endif

ifneq ($(ENABLE_ETH_SWITCH), TRUE)
ifneq (,$(filter $(CHIP_FAMILY),bcm8908x bcm8910x))
BRCM_COMP_APP_INTR += ETHXCVR
ETHXCVR.function = ETHXCVR_LinkIRQHandler0
ETHXCVR.declaration = ethxcvr_osil.h
ETHXCVR.irqnum = 17
endif
endif
