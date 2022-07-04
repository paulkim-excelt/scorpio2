#
# Copyright 2020-2022 Broadcom Limited.  All rights reserved.
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

##  @defgroup grp_rand Random bits and number generator
#   @ingroup grp_crypto
#
#   @addtogroup grp_rand
#   @{
#   @file security/drivers/rand/comp.mk
#   @brief Makefile for the rand library
#   @version 0.1 Initial version
#   @}
#

BRCM_COMP_REQ_SRC += doc/rand_req.c
BRCM_COMP_EXPORT_HDR += inc/rand_lib.h
BRCM_COMP_EXPORT_HDR += inc/osil/rand_osil.h

BRCM_COMP_LIB_SRC += lib/rand_lib_entrypts.c
BRCM_COMP_LIB_SRC += lib/rand_cmd_handler.c
BRCM_COMP_LIB_SRC += lib/rand_rbg200.c
BRCM_COMP_LIB_SRC += lib/rand_internal.c

BRCM_COMP_LIB_INC += lib/rand_rbg200.h
BRCM_COMP_LIB_INC += lib/rand_internal.h
BRCM_COMP_LIB_INC += lib/rand_drv_assert.h

BRCM_COMP_APP_SRC += os/erika/rand_osil_erika.c

BRCM_COMP_APP_INTR += RAND
BRCM_COMP_APP_EVENT += RandEvent
RAND.function = RAND_IRQHandler
RAND.declaration = rand_osil.h
ifeq ($(CHIP_FAMILY), bcm8956x)
RAND.irqnum = 57
endif
ifeq ($(CHIP_FAMILY), bcm8957x)
RAND.irqnum = 57
endif

BRCM_COMP_APP_OPT += ENABLE_RAND

BRCM_COMP_NAME := rand
BRCM_COMP_DEPENDS := secureheap hsm_drv_sched
BRCM_COMP_TYPE := lib

