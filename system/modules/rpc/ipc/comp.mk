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

##  @defgroup grp_rpc_v2_ipc IPC
#   @ingroup grp_rpc_v2
#
#   @addtogroup grp_rpc_v2_ipc
#   @{
#
#   @file system/rpc/comp.mk
#   @brief Makefile for RPC IPC
#   @version 0.1 Initial version
#   @}
#

BRCM_COMP_NAME := rpc_ipc
BRCM_COMP_DEPENDS := system ipcdrv rpc_mem
ifeq ($(call isappopt,ENABLE_HIPC),yes)
BRCM_COMP_DEPENDS += hipc
endif
BRCM_COMP_TYPE := doc

BRCM_COMP_REQ_SRC     += doc/rpc_ipc_slave_req.c
BRCM_COMP_REQ_SRC     += doc/rpc_ipc_master_req.c

BRCM_COMP_EXPORT_HDR  += inc/osil/rpc_ipc_slave_osil.h
BRCM_COMP_EXPORT_HDR  += inc/rpc_ipc_common.h

BRCM_COMP_APP_CFLAGS  += -DRPC_IPCSLAVE_CHANNEL_0_EVENT=SystemEvent7
BRCM_COMP_APP_CFLAGS  += -DRPC_IPCSLAVE_CHANNEL_NUM=0U
BRCM_COMP_APP_CFLAGS  += -DIPC_CHANN0_EVENT=SystemEvent7

BRCM_COMP_APP_SRC     += os/common/rpc_ipc_slave.c
BRCM_COMP_APP_SRC     += os/erika/rpc_ipc_slave_osil.c

BRCM_COMP_HOST_CFLAGS += -DIPC_CHANN0_EVENT=0
BRCM_COMP_HOST_SRC    += os/common/rpc_ipc_master.c

ifneq ($(CHIP_FAMILY),bcm8957x)
BRCM_COMP_UEXPORT_HDR  += inc/osil/rpc_ipc_cfg_osil.h
endif
