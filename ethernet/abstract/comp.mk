#
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
#    OF THE AMOUNT ACTUALLY PAID FOR THE SOFTWARE ITSELF OR U.S. \$1, WHICHEVER
#    IS GREATER. THESE LIMITATIONS SHALL APPLY NOTWITHSTANDING ANY FAILURE OF
#    ESSENTIAL PURPOSE OF ANY LIMITED REMEDY.
#
####################################################################################


##  @defchapter grp_ethernet Ethernet
#
#   @addtogroup grp_ethernet
#   @{
#
#
#   @}
#
#   @defgroup grp_ethernet_abstract Architecture
#   @ingroup grp_ethernet
#
#   @addtogroup grp_ethernet_abstract
#   @{
#   Ethernet abstractions provide module definitions and abstract interfaces for
#   ethernet related functionalities.
#
#   @file ethernet/abstract/comp.mk
#   @brief Makefile for Ethernet Abstractions
#   @version 0.1 Initial version
#   @}
#

BRCM_COMP_EXPORT_HDR += inc/ethernet_common.h
ifeq ($(ENABLE_ETHSWTM_ARL_LIB), TRUE)
BRCM_COMP_EXPORT_HDR += inc/ethernet_swt_arl.h
endif
ifeq ($(ENABLE_ETHSWTM_CFP_LIB), TRUE)
BRCM_COMP_EXPORT_HDR += inc/ethernet_swt_cfp.h
endif
ifeq ($(ENABLE_ETH_SWITCH), TRUE)
BRCM_COMP_EXPORT_HDR += inc/ethernet_swt_common.h
BRCM_COMP_EXPORT_HDR += inc/ethernet_swt_core.h
BRCM_COMP_EXPORT_HDR += inc/ethernet_swt_debug.h
BRCM_COMP_EXPORT_HDR += inc/ethernet_swt_ext.h
BRCM_COMP_EXPORT_HDR += inc/ethernet_swt_fa.h
BRCM_COMP_EXPORT_HDR += inc/ethernet_swt_vlan.h
endif
BRCM_COMP_EXPORT_HDR += inc/ethernet_xcvr_common.h
BRCM_COMP_EXPORT_HDR += inc/ethernet_ets.h
BRCM_COMP_EXPORT_HDR += inc/ethernet_nif.h

BRCM_COMP_REQ_SRC += doc/ether_req.c
ifeq ($(ENABLE_ETH_SWITCH), TRUE)
BRCM_COMP_REQ_SRC += doc/ethswt_req.c
endif
BRCM_COMP_REQ_SRC += doc/ethxcvr_req.c
BRCM_COMP_REQ_SRC += doc/ets_req.c

ifeq ($(ENABLE_ETHSWTM_ARL_LIB), TRUE)
BRCM_COMP_HOST_SRC += host/ethswt_arl_host.c
endif
ifeq ($(ENABLE_ETHSWTM_CFP_LIB), TRUE)
BRCM_COMP_HOST_SRC += host/ethswt_cfp_host.c
endif
ifeq ($(ENABLE_ETH_SWITCH), TRUE)
BRCM_COMP_EXPORT_HDR += host/ethswt_host_common.h
BRCM_COMP_HOST_SRC += host/ethswt_vlan_host.c
BRCM_COMP_HOST_SRC += host/ethswt_ext_host.c
BRCM_COMP_HOST_SRC += host/ethswt_host.c
BRCM_COMP_HOST_SRC += host/ethswt_mirror_host.c
BRCM_COMP_HOST_SRC += host/ethswt_misc_host.c
BRCM_COMP_HOST_SRC += host/ethswt_xcvr_host.c
endif
BRCM_COMP_HOST_SRC += host/ethernet_ets.c
BRCM_COMP_HOST_SRC += host/ethernet_nif.c

BRCM_COMP_NAME := ethernet
BRCM_COMP_DEPENDS := module
BRCM_COMP_TYPE := lib
