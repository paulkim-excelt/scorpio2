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
####################################################################################

##  @defgroup grp_eth_cntlrdrv Ethernet Controller Driver
#   @ingroup grp_ethernet
#
#   @addtogroup grp_eth_cntlrdrv
#   @{
#   @note Receive buffers shall be read-write accessible
#
#   @file ethernet/drivers/controller/comp.mk
#   @brief Makefile for Ethernet Controller Driver
#   @version 0.1 Initial version
#   @}

# Ethernet controller & time build configuration items
BRCM_COMP_REQ_SRC += doc/ethernet_req.c
BRCM_COMP_EXPORT_HDR += inc/ethernet.h
BRCM_COMP_EXPORT_HDR += inc/osil/eth_osil.h
BRCM_COMP_EXPORT_HDR += inc/eth_cntlr.h

ifeq ($(ENABLE_ETH_SWITCH), TRUE)
ifeq ($(call isappopt,ENABLE_ETH_SWT_ADAPT),yes)
BRCM_COMP_REQ_SRC += doc/ether_switch_req.c
BRCM_COMP_UAPP_SRC += switch/eth_cntlr_switch.c
else
BRCM_COMP_UAPP_SRC += endpt/eth_cntlr_endpt.c
BRCM_COMP_REQ_SRC += doc/ether_endpt_req.c
endif #ENABLE_ETH_SWT_ADAPT
else
BRCM_COMP_UAPP_SRC += endpt/eth_cntlr_endpt.c
BRCM_COMP_REQ_SRC += doc/ether_endpt_req.c
endif #ENABLE_ETH_SWITCH

BRCM_COMP_LIB_INC += lib/eth_cntlr_buf.h
BRCM_COMP_LIB_INC += inc/eth_cntlr_switch.h

BRCM_COMP_ULIB_SRC += lib/ethernet.c
BRCM_COMP_ULIB_SRC += lib/eth_cntlr_buf.c

ifeq ($(ENABLE_ETH_AMAC),TRUE)
BRCM_COMP_REQ_SRC += doc/amac_req.c
BRCM_COMP_ULIB_SRC += lib/amac.c
BRCM_COMP_LIB_CFLAGS += -DENABLE_ETH_AMAC
endif

ifeq ($(ENABLE_ETH_GMAC), TRUE)
BRCM_COMP_REQ_SRC += doc/gmac_req.c
BRCM_COMP_ULIB_SRC += lib/gmac.c
BRCM_COMP_LIB_CFLAGS += -DENABLE_ETH_GMAC
endif

BRCM_COMP_LIB_CFLAGS += -DETHER_ENABLE_SPURIOUS_INTR_CHECK
BRCM_COMP_LIB_CFLAGS += -DETHER_MTU=1500UL

ifeq ($(CHIP_FAMILY),bcm8910x)
BRCM_COMP_LIB_CFLAGS += -DETHER_TIMEHWIDMAX=1UL -DETHER_HW_ID_MAX=1UL
BRCM_COMP_LIB_CFLAGS += -DETHER_RXPKTSTARTALIGN=32UL
BRCM_COMP_LIB_CFLAGS += -DETHER_RXBUFFCOUNT=8UL
BRCM_COMP_LIB_CFLAGS += -DETHER_TXCH0BUFFCOUNT=5UL
BRCM_COMP_LIB_CFLAGS += -DETHER_TXCH1BUFFCOUNT=5UL
BRCM_COMP_LIB_CFLAGS += -DETHER_TXCH2BUFFCOUNT=5UL
BRCM_COMP_LIB_CFLAGS += -DETHER_TXCH3BUFFCOUNT=12UL
BRCM_COMP_LIB_CFLAGS += -DAMAC_DMA_MEM_VIEW_BASE=0x0
BRCM_COMP_ULIB_SRC += endpt/ether_mdio_endpt_cfg.c
ifeq ($(ENABLE_ETH_TIME), TRUE)
BRCM_COMP_ULIB_SRC += lib/eth_time_v1.c
endif
endif

ifeq ($(CHIP_FAMILY),bcm8953x)
BRCM_COMP_LIB_CFLAGS += -DETHER_TIMEHWIDMAX=1UL -DETHER_HW_ID_MAX=1UL
BRCM_COMP_LIB_CFLAGS += -DETHER_RXPKTSTARTALIGN=64UL
BRCM_COMP_LIB_CFLAGS += -DETHER_RXBUFFCOUNT=10UL
BRCM_COMP_LIB_CFLAGS += -DETHER_TXCH0BUFFCOUNT=16UL
BRCM_COMP_ULIB_SRC += switch/ether_mdio_switch_cfg_v1.c
ifeq ($(ENABLE_ETH_TIME), TRUE)
BRCM_COMP_ULIB_SRC += lib/eth_time_v2.c
endif
endif

ifneq (,$(filter $(CHIP_FAMILY),bcm8956x bcm8957x))
BRCM_COMP_LIB_CFLAGS += -DETHER_TIMEHWIDMAX=1UL -DETHER_HW_ID_MAX=1UL
BRCM_COMP_LIB_CFLAGS += -DETHER_RXPKTSTARTALIGN=4UL
BRCM_COMP_LIB_CFLAGS += -DETHER_RXBUFFCOUNT=12UL
BRCM_COMP_LIB_CFLAGS += -DETHER_TXCH0BUFFCOUNT=12UL
BRCM_COMP_LIB_CFLAGS += -DETHER_COPY_RX_DESC
BRCM_COMP_LIB_CFLAGS += -DAMAC_DMA_MEM_VIEW_BASE=0x10000UL
BRCM_COMP_ULIB_SRC += switch/ether_mdio_switch_cfg_v2.c
ifeq ($(ENABLE_ETH_TIME), TRUE)
BRCM_COMP_ULIB_SRC += lib/eth_time_v2.c
endif
endif

ifeq ($(CHIP_FAMILY),bcm8908x)
BRCM_COMP_LIB_CFLAGS += -DETHER_TIMEHWIDMAX=1UL -DETHER_HW_ID_MAX=1UL
BRCM_COMP_LIB_CFLAGS += -DETHER_RXPKTSTARTALIGN=32UL
BRCM_COMP_LIB_CFLAGS += -DETHER_RXBUFFCOUNT=8UL
BRCM_COMP_LIB_CFLAGS += -DETHER_TXCH0BUFFCOUNT=5UL
BRCM_COMP_LIB_CFLAGS += -DETHER_TXCH1BUFFCOUNT=5UL
BRCM_COMP_LIB_CFLAGS += -DETHER_TXCH2BUFFCOUNT=5UL
BRCM_COMP_LIB_CFLAGS += -DETHER_TXCH3BUFFCOUNT=12UL
BRCM_COMP_LIB_CFLAGS += -DAMAC_DMA_MEM_VIEW_BASE=0x0
BRCM_COMP_ULIB_SRC += endpt/ether_mdio_endpt_cfg.c
ifeq ($(ENABLE_ETH_TIME), TRUE)
BRCM_COMP_ULIB_SRC += lib/eth_time_v1.c
endif
endif

ifeq ($(CHIP_FAMILY),bcm8958x)
BRCM_COMP_LIB_CFLAGS += -DETHER_TIMEHWIDMAX=1UL -DETHER_HW_ID_MAX=1UL
BRCM_COMP_LIB_CFLAGS += -DETHER_RXPKTSTARTALIGN=4UL
BRCM_COMP_LIB_CFLAGS += -DETHER_RXBUFFCOUNT=12UL
BRCM_COMP_LIB_CFLAGS += -DETHER_TXCH0BUFFCOUNT=12UL
BRCM_COMP_LIB_CFLAGS += -DETHER_COPY_RX_DESC
BRCM_COMP_LIB_CFLAGS += -DAMAC_DMA_MEM_VIEW_BASE=0x10000UL
BRCM_COMP_ULIB_SRC += switch/ether_mdio_switch_cfg_v2.c
ifeq ($(ENABLE_ETH_TIME), TRUE)
BRCM_COMP_ULIB_SRC += lib/eth_time_v2.c
endif
endif

BRCM_COMP_LIB_CFLAGS += -DENABLE_ETH
BRCM_COMP_UAPP_SRC += os/erika/eth_osil.c

ifeq ($(ENABLE_ETH_TIME),TRUE)
BRCM_COMP_LIB_CFLAGS += -DENABLE_ETH_TIME
BRCM_COMP_APP_INTR += ETHTIME
ETHTIME.function = ETHER_1588_IRQHandler
ETHTIME.declaration = eth_osil.h
ifneq (,$(filter $(CHIP_FAMILY),bcm8908x bcm8910x))
ETHTIME.irqnum = 18
else ifeq ($(CHIP_FAMILY), bcm8953x)
ETHTIME.irqnum = 10
else ifneq (,$(filter $(CHIP_FAMILY),bcm8956x bcm8957x))
ETHTIME.irqnum = 7
else ifeq ($(CHIP_FAMILY), bcm8957x)
ETHTIME.irqnum = 7
endif
endif

BRCM_COMP_APP_INTR += ETH
ETH.function = ETHER_IRQHandler
ETH.declaration = eth_osil.h
ifneq (,$(filter $(CHIP_FAMILY),bcm8908x bcm8910x))
ETH.irqnum = 32
else ifeq ($(CHIP_FAMILY), bcm8953x)
ETH.irqnum = 12
else ifneq (,$(filter $(CHIP_FAMILY),bcm8956x bcm8957x))
ETH.irqnum = 23
else ifeq ($(CHIP_FAMILY), bcm8958x)
ETH.irqnum = 112
endif

BRCM_COMP_NAME := ethcntlr
BRCM_COMP_DEPENDS := mdiodrv ethernet
BRCM_COMP_TYPE := lib

