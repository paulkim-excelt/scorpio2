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


##  @defgroup grp_ethswt Ethernet Switch Driver
#   @ingroup grp_ethernet
#
#   @addtogroup grp_ethswt
#   @{
#   @file ethernet/drivers/switch/comp.mk
#   @brief Make file for Ethernet Switch Driver
#   @version 0.1 Inital version
#   @}
#

BRCM_COMP_NAME := ethswitch
BRCM_COMP_DEPENDS += mcudrv ethcntlr
BRCM_COMP_TYPE := lib

BRCM_COMP_REQ_SRC += doc/ethswt_req.c

ifeq ($(ENABLE_ETHSWT_SECURITY), TRUE)
BRCM_CONFIGURATION_ITEM += tests/qualification/security/security_qt.h
endif

BRCM_COMP_EXPORT_HDR += inc/eth_switch.h
BRCM_COMP_EXPORT_HDR += inc/osil/eth_switch_osil.h
BRCM_COMP_EXPORT_HDR += inc/ethswt_common.h
BRCM_COMP_EXPORT_HDR += inc/osil/ethswt_common_osil.h
BRCM_COMP_LIB_INC += lib/switch_drv.h

ifeq ($(call isappopt,ENABLE_ETH_SWITCH),yes)
BRCM_COMP_APP_INTR += SWITCH_LINK0 SWITCH_LINK1 SWITCH_LINK2 SWITCH_LINK3
BRCM_COMP_APP_INTR += SWITCH_LINK4 SWITCH_LINK5 SWITCH_LINK6 SWITCH_LINK8
SWITCH_LINK0.function = ETHSWT_Port0LinkIRQHandler
SWITCH_LINK0.declaration = ethswt_common.h
SWITCH_LINK1.function = ETHSWT_Port1LinkIRQHandler
SWITCH_LINK1.declaration = ethswt_common_osil.h
SWITCH_LINK2.function = ETHSWT_Port2LinkIRQHandler
SWITCH_LINK2.declaration = ethswt_xcvr_osil.h
SWITCH_LINK3.function = ETHSWT_Port3LinkIRQHandler
SWITCH_LINK3.declaration = ethswt_xcvr_osil.h
SWITCH_LINK4.function = ETHSWT_Port4LinkIRQHandler
SWITCH_LINK4.declaration = ethswt_xcvr_osil.h
SWITCH_LINK5.function = ETHSWT_Port5LinkIRQHandler
SWITCH_LINK5.declaration = ethswt_xcvr_osil.h
SWITCH_LINK6.function = ETHSWT_Port6LinkIRQHandler
SWITCH_LINK6.declaration = ethswt_xcvr_osil.h
SWITCH_LINK8.function = ETHSWT_Port8LinkIRQHandler
SWITCH_LINK8.declaration = ethswt_xcvr_osil.h
ifeq ($(CHIP_FAMILY), bcm8953x)
SWITCH_LINK0.irqnum = 17
SWITCH_LINK1.irqnum = 18
SWITCH_LINK2.irqnum = 19
SWITCH_LINK3.irqnum = 20
SWITCH_LINK4.irqnum = 21
SWITCH_LINK5.irqnum = 22
SWITCH_LINK6.irqnum = 23
SWITCH_LINK8.irqnum = 24
else ifeq ($(CHIP_FAMILY), bcm8956x)
SWITCH_LINK0.irqnum = 27
SWITCH_LINK1.irqnum = 28
SWITCH_LINK2.irqnum = 29
SWITCH_LINK3.irqnum = 30
SWITCH_LINK4.irqnum = 31
SWITCH_LINK5.irqnum = 32
SWITCH_LINK6.irqnum = 33
SWITCH_LINK8.irqnum = 34
else ifeq ($(CHIP_FAMILY), bcm8957x)
SWITCH_LINK0.irqnum = 27
SWITCH_LINK1.irqnum = 28
SWITCH_LINK2.irqnum = 29
SWITCH_LINK3.irqnum = 30
SWITCH_LINK4.irqnum = 31
SWITCH_LINK5.irqnum = 32
SWITCH_LINK6.irqnum = 33
SWITCH_LINK8.irqnum = 34
endif
endif

ifeq ($(ENABLE_ETH_SWITCH), TRUE)
BRCM_COMP_LIB_CFLAGS += -DENABLE_ETH_SWITCH
BRCM_COMP_LIB_SRC += lib/eth_switch.c
BRCM_COMP_UAPP_SRC += os/erika/switch_osil.c

ifeq ($(ENABLE_ETHSWT_TIME), TRUE)
BRCM_COMP_LIB_CFLAGS += -DENABLE_ETHSWT_TIME
endif

ifeq ($(ENABLE_ETHSWT_VLAN), TRUE)
BRCM_COMP_EXPORT_HDR += inc/ethswt_vlan.h
BRCM_COMP_EXPORT_HDR += inc/osil/ethswt_vlan_osil.h
BRCM_COMP_LIB_SRC += lib/switch_vlan.c
BRCM_COMP_LIB_CFLAGS += -DENABLE_ETHSWT_VLAN
BRCM_COMP_LIB_CFLAGS += -DETHSWT_VLAN_CMD_HANDLER=ETHSWT_VLANCmdHandler
BRCM_COMP_LIB_CFLAGS += -DETHSWT_VLAN_MAX_STATIC_ENTRIES=128UL
ifeq ($(ENABLE_ETHSWT_ARL), TRUE)
BRCM_COMP_LIB_CFLAGS += -DETHSWT_ARL_SIZE=4096U
BRCM_COMP_EXPORT_HDR += inc/ethswt_arl.h
BRCM_COMP_EXPORT_HDR += inc/osil/ethswt_arl_osil.h
BRCM_COMP_LIB_SRC += lib/switch_arl.c
BRCM_COMP_LIB_CFLAGS += -DENABLE_ETHSWT_ARL
BRCM_COMP_LIB_CFLAGS += -DETHSWT_ARL_CMD_HANDLER=ETHSWT_ARLCmdHandler
endif
endif

ifeq ($(ENABLE_ETHSWT_DEBUG), TRUE)
BRCM_COMP_EXPORT_HDR += inc/ethswt_debug.h
BRCM_COMP_EXPORT_HDR += inc/osil/ethswt_debug_osil.h
BRCM_COMP_LIB_CFLAGS += -DENABLE_ETHSWT_DEBUG
BRCM_COMP_LIB_CFLAGS += -DETHSWT_DBG_CMD_HANDLER=ETHSWT_DbgCmdHandler
BRCM_COMP_LIB_SRC += lib/switch_mirror.c
endif

ifeq ($(ENABLE_ETHSWT_EXT), TRUE)
BRCM_COMP_REQ_SRC += doc/ethswt_ext_req.c
BRCM_COMP_EXPORT_HDR += inc/ethswt_ext.h
BRCM_COMP_EXPORT_HDR += inc/osil/ethswt_ext_osil.h
BRCM_COMP_LIB_CFLAGS += -DENABLE_ETHSWT_EXT
BRCM_COMP_LIB_CFLAGS += -DETHSWT_EXT_CMD_HANDLER=ETHSWT_ExtCmdHandler
BRCM_COMP_LIB_SRC += lib/switch_ext.c
BRCM_COMP_EXPORT_HDR += inc/switch_cfg.h
ifeq ($(ENABLE_ETHSWT_IPG_SHRINK), TRUE)
BRCM_COMP_LIB_CFLAGS += -DENABLE_ETHSWT_IPG_SHRINK
BRCM_COMP_LIB_CFLAGS += -DETHSWT_IPG_SHRINK_VAL=1ULL
BRCM_COMP_LIB_SRC += lib/ethswt_ipg.c
endif
endif

ifeq ($(ENABLE_ETHSWT_XCVR), TRUE)
BRCM_COMP_REQ_SRC += doc/ethswt_xcvr_req.c
BRCM_COMP_EXPORT_HDR += inc/ethswt_xcvr.h
BRCM_COMP_EXPORT_HDR += inc/osil/ethswt_xcvr_osil.h
BRCM_COMP_LIB_CFLAGS += -DENABLE_ETHSWT_XCVR
BRCM_COMP_LIB_CFLAGS += -DETHSWT_XCVR_CMD_HANDLER=ETHSWT_XcvrCmdHandler
BRCM_COMP_LIB_SRC += lib/switch_xcvr.c
BRCM_COMP_DEPENDS += ethxcvr mdiodrv
endif

ifeq ($(ENABLE_ETHSWT_CFP), TRUE)
BRCM_COMP_REQ_SRC += doc/ethswt_cfp_req.c
BRCM_CONFIGURATION_ITEM += tests/qualification/cfp/cfp_qt.h
BRCM_COMP_EXPORT_HDR += inc/ethswt_cfp.h
BRCM_COMP_EXPORT_HDR += inc/osil/ethswt_cfp_osil.h
BRCM_COMP_LIB_INC += lib/cfp_drv.h
BRCM_COMP_LIB_SRC += lib/cfp_drv.c
BRCM_COMP_LIB_CFLAGS += -DETHSWT_CFP_CMD_HANDLER=ETHSWT_CFPCmdHandler
endif

ifeq ($(ENABLE_ETHSWT_FA), TRUE)
BRCM_COMP_LIB_CFLAGS += -DENABLE_ETHSWT_FA
BRCM_COMP_APP_OPT    += ENABLE_ETHSWT_FA
BRCM_COMP_REQ_SRC += doc/ethswt_fa_req.c
BRCM_COMP_EXPORT_HDR += inc/ethswt_fa.h
BRCM_COMP_EXPORT_HDR += inc/osil/ethswt_fa_osil.h
BRCM_COMP_LIB_SRC += lib/ethswt_fa.c
BRCM_COMP_LIB_SRC += lib/ethswt_fadrv.c
BRCM_COMP_APP_SRC += os/erika/ethswt_fa_osil.c
BRCM_COMP_LIB_CFLAGS += -DETHSWT_FA_CMD_HANDLER=ETHSWT_FACmdHandler
BRCM_COMP_DEPENDS += unimac eth_abstract
BRCM_COMP_APP_INTR += CTF
BRCM_COMP_QT_SRC += tests/qualification/falib_qt/falib_qt.h
CTF.function = ETHSWT_FACtfIRQHandler
CTF.declaration = ethswt_fa_osil.h
ifeq ($(CHIP_FAMILY), bcm8956x)
CTF.irqnum = 48
endif
ifeq ($(CHIP_FAMILY), bcm8957x)
CTF.irqnum = 48
endif
endif

ifeq ($(ENABLE_ETHSWT_PSFP), TRUE)
BRCM_COMP_REQ_SRC    += doc/ethswt_psfp_req.c
BRCM_COMP_EXPORT_HDR += inc/ethswt_psfp.h
BRCM_COMP_EXPORT_HDR += inc/osil/ethswt_psfp_osil.h
endif
endif

BRCM_COMP_APP_SRC += os/common/ethswt_common_osil.c
