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


##  @defgroup grp_crypto_service Service
#   @ingroup grp_crypto
#
#   @addtogroup grp_crypto_service
#   @{
#   Crypto Service provides task function and Service objects for integration of
#   Crypto modules into the system
#
#   @file crypto/service/comp.mk
#   @brief Makefile for Crypto Service
#   @version 0.1 Initial version
#   @}
#

BRCM_COMP_NAME        := crypto_service
BRCM_COMP_TYPE        := lib
BRCM_COMP_DEPENDS     := module crypto
ifeq ($(CHIP_FAMILY),bcm8956x)
BRCM_COMP_DEPENDS     += crypto_verify_hw
endif
ifeq ($(CHIP_FAMILY),bcm8957x)
BRCM_COMP_DEPENDS     += crypto_verify_hw
ifeq ($(call isappopt, ENABLE_CRYPTO_SECY_MODULE), yes)
BRCM_COMP_DEPENDS     += crypto_secy_hw
BRCM_COMP_APP_CFLAGS += -DCRYPTO_SECY_MODULE=SECY_Module
endif
endif
ifeq ($(CHIP_FAMILY),bcm8958x)
BRCM_COMP_APP_CFLAGS  += -DIPC_CHANN1_EVENT=SystemEvent9
BRCM_COMP_APP_OPT     += ENABLE_IPC
ifeq ($(cpu),m7)
BRCM_COMP_DEPENDS     += crypto_verify_proxy
else
BRCM_COMP_DEPENDS     += crypto_verify_hw
endif
endif

BRCM_COMP_APP_INC     += ../../ethernet/common/rpc/inc/

BRCM_COMP_APP_TASK    += CRYPTO_Task
CRYPTO_Task.priority  := 9
CRYPTO_Task.autostart := true
CRYPTO_Task.stack     := 2048
CRYPTO_Task.event     += MODULE_EVENT

BRCM_COMP_REQ_SRC     += doc/crypto_service_req.c
BRCM_COMP_EXPORT_HDR  += inc/crypto_service.h
BRCM_COMP_APP_SRC     += os/common/crypto_service.c
BRCM_COMP_APP_SRC     += os/base/crypto_service_base.c
BRCM_COMP_REQ_SRC     += doc/crypto_service_req.c


