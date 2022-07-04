# /*****************************************************************************
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
#    OF THE AMOUNT ACTUALLY PAID FOR THE SOFTWARE ITSELF OR U.S. $1, WHICHEVER
#    IS GREATER. THESE LIMITATIONS SHALL APPLY NOTWITHSTANDING ANY FAILURE OF
#    ESSENTIAL PURPOSE OF ANY LIMITED REMEDY.
#******************************************************************************/
ifeq ($(call iseeopt, __BCM8957X__), yes)

EEOPT += __BCM8957X__
OPT_CC += -D__BCM8957X__
OPT_ASM += -D__BCM8957X__

OPT_ASM += -D__ENABLE_BCM_SVC__ -D__ENABLE_BCM_CORTEX_MX_PSP__
OPT_CC += -D__ENABLE_BCM_SVC__ -D__ENABLE_BCM_CORTEX_MX_PSP__
OPT_CC += -D__GCC__

OPT_LINK += -e EE_cortex_mx_default_reset_ISR

OPT_LINK += -L$(BRCM_SDK_ROOT)/init/bcm8957x
TARGET_NAME = c_rX

OPT_ASM += -D__ENABLE_MPU__
OPT_CC += -D__ENABLE_MPU__
EEOPT += __ENABLE_MPU__


#Enable ETH_MAC0 by default
#CFLAGS += -DENABLE_MAC0

# Macro to enable clearing EE_th_terminate_nextask[current] data
# incase of error in ChainTask()
CFLAGS += -D__BCM_CHAINTASK_CLR_NEXTTASK_ON_ERR__

include $(BRCM_SDK_ROOT)/system/os/erika/cfg.mk

INCLUDE_PATH += $(BRCM_SDK_ROOT)/system/include
INCLUDE_PATH += $(BRCM_SDK_ROOT)/system/include/arm
INCLUDE_PATH += $(BRCM_SDK_ROOT)/init/bcm8957x/inc/rdb/a0


CFLAGS += -DSYS_TASK_NAME=SYSTEM_Task
CFLAGS += -DIPC_SYS_MSGQ_EVENT=SystemEvent4

ifeq ($(call iseeopt, __BCM89570__), yes)
CORTEX_MCU_MODEL = BCM89570
endif   # __BCM89570__


CORTEX_MCU_LINKERSCRIPT = $(BRCM_SDK_ROOT)/init/bcm8957x/board/common/gnu.ld



# Set MDIO timer channel ID and clock expiry time
#CFLAGS += -DMDIO_TIMER_CHANID=1UL -DMDIO_TIMER_EXPIRY_TICKS=62UL

endif	# __BCM8957x__
