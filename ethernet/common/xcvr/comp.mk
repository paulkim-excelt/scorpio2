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


##  @defgroup grp_ethsrv_xcvr Ethernet Transceiver Module
#   @ingroup grp_ethernet
#
#   @addtogroup grp_ethsrv_xcvr
#   @{
#   @file ethernet/common/xcvr/comp.mk
#   @brief Makefile for EthXcvr module
#   @version 0.1 Initial version
#   @}
#
#

BRCM_INC += $(BRCM_SDK_ROOT)/system/common/inc
BRCM_INC += $(BRCM_SDK_ROOT)/system/imgl/inc
BRCM_INC += $(BRCM_SDK_ROOT)/nvm/service/inc
BRCM_INC += $(BRCM_SDK_ROOT)/system/wds/inc

INCLUDE_PATH += $(BRCM_SDK_ROOT)/ethernet/common/xcvr/inc
INCLUDE_PATH += $(BRCM_SDK_ROOT)/ethernet/common/xcvr/inc/osil
INCLUDE_PATH += $(BRCM_SDK_ROOT)/ethernet/common/ethsrv/inc

BRCM_COMP_EXPORT_HDR += inc/ethxcvrm.h
BRCM_COMP_EXPORT_HDR += inc/osil/ethxcvrm_osil.h
BRCM_COMP_REQ_SRC += doc/ethxcvrm_req.c
BRCM_COMP_LIB_SRC += lib/ethxcvrm.c
BRCM_COMP_APP_CFLAGS += -DENABLE_ETHXCVRM

ifneq ($(call isappopt,ENABLE_ETHER_TEST),yes)
ifneq ($(call isappopt,ENABLE_ETHXCVR_TEST),yes)
BRCM_COMP_APP_ALARM += ETHXCVRM_Timer
ETHXCVRM_Timer.counter = SystemTimer
ETHXCVRM_Timer.callback = ETHXCVRM_TimerCb
ETHXCVRM_Timer.autostart = false
ETHXCVRM_Timer.alarmtime = 1
ETHXCVRM_Timer.cycletime = 1000
ETHXCVRM_Timer.declaration = ethxcvrm_osil.h
BRCM_COMP_APP_SRC += os/erika/ethxcvrm_osil.c
endif
endif

BRCM_COMP_NAME := ethxcvrm
BRCM_COMP_DEPENDS := ethxcvr ethutils ethernet
BRCM_COMP_TYPE := lib
