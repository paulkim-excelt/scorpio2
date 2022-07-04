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


##  @defgroup grp_bcm8957x_init BCM8957X Initialization
#   @ingroup grp_initialization
#
#   @addtogroup grp_bcm8957x_init
#   @{
#
#   Device/Peripheral memory is configured with below map
#   @image html bcm8957x_peripheral_map.png "Peripheral Map" width="200%"
#
#   TCM usage and access permissions in different stages of execution is as
#   described below.
#   @image html bcm8957x_memory_map.png "Memory Map" width="200%"
#
#   @file init/bcm8957x/comp.mk
#   @brief  BCM8957X Initialization makefile
#   @}

BRCM_COMP_NAME := bcm8957x
BRCM_COMP_DEPENDS :=
BRCM_COMP_TYPE := doc


BRCM_COMP_DOC_SRC += doc/board_page.c
BRCM_COMP_DOC_SRC += doc/images/bcm89571_evk_frontview.jpg
BRCM_COMP_DOC_SRC += doc/images/bcm89571_evk_port_configs.jpg

BRCM_COMP_REQ_SRC += doc/bcm8957x_req.c
BRCM_COMP_REQ_SRC += doc/a0/bcm8957x_rdb_req.c

BRCM_COMP_APP_SRC += chip/common/startup.S
BRCM_COMP_APP_SRC += chip/common/exceptions.S

BRCM_COMP_EXPORT_HDR += inc/init.h
BRCM_COMP_APP_OPT += __BCM8957X__
BRCM_COMP_APP_OPT += ENABLE_NIF

BRCM_COMP_APP_CFLAGS += -D__ENABLE_BCM_SVC__ -D__ENABLE_BCM_CORTEX_MX_PSP__
BRCM_COMP_APP_CFLAGS += -D__GCC__

BRCM_COMP_APP_SRC += chip/common/svc_handlers.c
BRCM_COMP_APP_SRC += chip/common/early_init.c

#BRCM_COMP_UAPP_SRC += board/common/board.c

# Set MDIO timer channel ID and clock expiry time
BRCM_COMP_APP_CFLAGS += -DMDIO_TIMER_CHANID=1UL -DMDIO_TIMER_EXPIRY_TICKS=62UL

BRCM_COMP_APP_EVENT += SystemEvent0
BRCM_COMP_APP_EVENT += SystemEvent1
BRCM_COMP_APP_EVENT += SystemEvent2
BRCM_COMP_APP_EVENT += SystemEvent3
BRCM_COMP_APP_EVENT += SystemEvent4
BRCM_COMP_APP_EVENT += SystemEvent5
BRCM_COMP_APP_EVENT += SystemEvent6
BRCM_COMP_APP_EVENT += SystemEvent7
BRCM_COMP_APP_EVENT += SystemEvent8
BRCM_COMP_APP_EVENT += SystemEvent9
BRCM_COMP_APP_EVENT += SystemEvent10
BRCM_COMP_APP_EVENT += SystemEvent11
BRCM_COMP_APP_EVENT += SystemEvent12
BRCM_COMP_APP_EVENT += SystemEvent13
BRCM_COMP_APP_EVENT += SystemEvent14
BRCM_COMP_APP_EVENT += SystemEvent15
BRCM_COMP_APP_EVENT += SystemEvent16
BRCM_COMP_APP_EVENT += ShutdownEvent

BRCM_COMP_APP_EVENT += UDP_TxEvent
BRCM_COMP_APP_EVENT += UDP_RxEvent

ifeq ($(call isappopt, ENABLE_SYSTEM_SERVICE), yes)
BRCM_COMP_DEPENDS += sys_service
endif
ifeq ($(call isappopt, ENABLE_CONSOLE), yes)
BRCM_COMP_DEPENDS += console
endif
ifeq ($(call isappopt, ENABLE_VTMON), yes)
BRCM_COMP_DEPENDS += vtmondrv
endif
ifeq ($(call isappopt, ENABLE_DBGMEM), yes)
BRCM_COMP_DEPENDS += dbgmem
endif

BRCM_COMP_DEPENDS += mcudrv utils arm abstract queue
