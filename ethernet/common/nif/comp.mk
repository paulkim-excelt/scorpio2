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
####################################################################################

##  @defgroup grp_nif Network Interface
#   @ingroup grp_ethernet
#
#   @addtogroup grp_nif
#   @{
#   @file ethernet/common/nif/comp.mk
#   @brief Makefile for NIF files
#   @version 0.1 Initial version
#   @}
#

BRCM_COMP_EXPORT_HDR += inc/nif.h
BRCM_COMP_EXPORT_HDR += inc/nif_avb.h
BRCM_COMP_EXPORT_HDR += inc/nif_timestamp.h
ifeq ($(call isappopt,ENABLE_NIF_XCVR),yes)
BRCM_COMP_EXPORT_HDR += inc/nif_xcvr.h
endif#ENABLE_NIF_XCVR
BRCM_COMP_EXPORT_HDR += inc/nif_cntrlr.h
BRCM_COMP_EXPORT_HDR += inc/nif_fqtss.h
BRCM_COMP_EXPORT_HDR += inc/osil/nif_cntrlr_osil.h
BRCM_COMP_EXPORT_HDR += inc/osil/nif_cntrlr_platform.h

BRCM_COMP_REQ_SRC += doc/nif_req.c
BRCM_COMP_REQ_SRC += doc/nif_fqtss_req.c

BRCM_COMP_APP_INC += os/common/nif_internal.h

BRCM_INC += $(BRCM_SDK_ROOT)/nvm/drivers/otp/inc/

BRCM_COMP_LIB_SRC    += lib/nif_cntrlr.c
BRCM_COMP_LIB_SRC    += lib/nif_fqtss.c

BRCM_COMP_APP_CFLAGS += -DETHER_UPDATE_CREDIT_SHAPER=NIF_FqtssUpdateCredits
BRCM_COMP_APP_CFLAGS += -DETHER_CLIENTS_WAITING_FOR_BUFFERS=NIF_AreClientsWaitingForBuffers

BRCM_COMP_APP_SRC    += os/platform/nif_cntrlr_platform.c
ifeq ($(CHIP_FAMILY),bcm8910x)
BRCM_COMP_APP_SRC += os/platform/nif_cntrlr_config_v1.c
endif
ifeq ($(CHIP_FAMILY),bcm8908x)
BRCM_COMP_APP_SRC += os/platform/nif_cntrlr_config_v1.c
endif
ifeq ($(CHIP_FAMILY),bcm8953x)
BRCM_COMP_APP_SRC += os/platform/nif_cntrlr_config_v2.c
endif
ifeq ($(CHIP_FAMILY),bcm8956x)
ifeq ($(version), a0)
BRCM_COMP_LIB_CFLAGS += -DNIF_USES_OTP
endif
BRCM_COMP_APP_SRC += os/platform/nif_cntrlr_config_v3.c
endif
ifneq (, $(filter bcm8957x bcm8958x, $(CHIP_FAMILY)))
BRCM_COMP_APP_SRC += os/platform/nif_cntrlr_config_v3.c
endif

ifeq ($(ENABLE_ETH_SWITCH), TRUE)
BRCM_COMP_LIB_CFLAGS += -DETHER_ENABLE_SWT_CODE
BRCM_COMP_EXPORT_HDR += inc/nif_switch.h
BRCM_COMP_REQ_SRC += doc/nif_switch_req.c
ifeq ($(ENABLE_ETHSWT_XCVR), TRUE)
BRCM_COMP_REQ_SRC += doc/nif_switch_xcvr_req.c
BRCM_COMP_REQ_SRC += doc/nif_xcvr_req.c
endif
else
ifeq ($(call isappopt,ENABLE_NIF_XCVR),yes)
BRCM_COMP_REQ_SRC += doc/nif_endpt_req.c
BRCM_COMP_REQ_SRC += doc/nif_xcvr_req.c
endif #ENABLE_NIF_XCVR
endif

BRCM_COMP_REQ_SRC    += doc/nif_cntrlr_req.c
ifneq ($(call isappopt,ENABLE_ETHER_TEST),yes)
BRCM_COMP_APP_SRC    += os/common/nif_cntrlr_osil.c
BRCM_COMP_APP_CFLAGS += -DETHER_PKT_EVENT=SystemEvent0
BRCM_COMP_APP_CFLAGS += -DETHER_TIMER_EVENT=SystemEvent5
endif

ifneq ($(call isappopt, ENABLE_ETHER_TEST), yes)
BRCM_COMP_APP_SRC += os/common/nif.c
BRCM_COMP_APP_SRC += os/common/nif_avb.c
BRCM_COMP_APP_SRC += os/common/nif_timestamp.c
ifeq ($(call isappopt,ENABLE_NIF_XCVR),yes)
BRCM_COMP_APP_SRC += os/common/nif_xcvr.c
endif#ENABLE_NIF_XCVR

ifeq ($(call isappopt, ENABLE_DEFAULT_NIF_CFG), yes)
ifeq ($(CHIP_FAMILY), bcm8908x)
BRCM_COMP_UAPP_SRC += os/common/nif_v1_cfg.c
endif
ifeq ($(CHIP_FAMILY), bcm8910x)
BRCM_COMP_UAPP_SRC += os/common/nif_v1_cfg.c
endif
ifeq ($(CHIP_FAMILY), bcm8953x)
BRCM_COMP_UAPP_SRC += os/common/nif_v2_cfg.c
endif
ifeq ($(CHIP_FAMILY), bcm8956x)
BRCM_COMP_UAPP_SRC += os/common/nif_v2_cfg.c
endif
ifneq (,$(filter bcm8957x bcm8958x, $(CHIP_FAMILY)))
BRCM_COMP_UAPP_SRC += os/common/nif_v2_cfg.c
endif # bcm8957x
endif # ENABLE_DEFAULT_NIF_CFG
endif # !ENABLE_ETHER_TEST

ifeq ($(call iseeopt, ENABLE_WLAN), yes)
BRCM_COMP_APP_SRC += os/common/nif_wireless.c
endif # ENABLE_WLAN

ifneq ($(call isappopt,ENABLE_ETHER_TEST),yes)
ifneq ($(ENABLE_ETHXCVR_TEST), TRUE)
ifeq ($(ENABLE_ETH_SWITCH), TRUE)

ifeq ($(call isappopt,ENABLE_ETH_SWT_ADAPT),yes)
BRCM_COMP_APP_SRC += os/common/nif_switch.c
ifeq ($(ENABLE_ETHXCVRM), TRUE)
BRCM_COMP_APP_SRC += os/common/nif_switch_xcvr.c
endif # ENABLE_ETHXCVRM
else
BRCM_COMP_APP_SRC += os/common/nif_endpt.c
endif # ENABLE_ETH_SWT_ADAPT

else
ifeq ($(call isappopt,ENABLE_NIF_XCVR),yes)
BRCM_COMP_APP_SRC += os/common/nif_endpt.c
endif # ENABLE_NIF_XCVR
endif # ENABLE_ETH_SWITCH

endif # !ENABLE_ETHXCVR_TEST
endif # !ENABLE_ETHER_TEST

BRCM_SRC :=
BRCM_CFLAGS :=
BRCM_INC :=

BRCM_COMP_NAME := nif
BRCM_COMP_DEPENDS := ethcntlr otpdrv ethernet
ifeq ($(ENABLE_ETHXCVRM), TRUE)
BRCM_COMP_DEPENDS += ethxcvr
endif
BRCM_COMP_TYPE := lib
