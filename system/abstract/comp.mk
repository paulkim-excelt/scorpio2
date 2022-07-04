#
# Copyright 2022 Broadcom Limited.  All rights reserved.
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



##  @defchapter grp_system System Software
#
#   @addtogroup grp_system
#   @{
#
#   @}
#
#   @defgroup grp_system_abstract Architecture
#   @ingroup grp_system
#
#   @addtogroup grp_system_abstract
#   @{
#   System abstractions provide module definitions and abstract interfaces for
#   System related functionality
#
#   @file system/abstract/comp.mk
#   @brief Makefile for System Abstractions
#   @version 0.1 Initial version
#   @}
#

BRCM_COMP_NAME := system
BRCM_COMP_DEPENDS := module
BRCM_COMP_TYPE := lib

BRCM_COMP_HOST_CFLAGS += -DDMON_RPC_MEM_MSG_PAYLOAD_SZ=RPC_MEM_MSG_PAYLOAD_SZ
BRCM_COMP_LIB_CFLAGS += -DDMON_RPC_MEM_MSG_PAYLOAD_SZ=RPC_MEM_MSG_PAYLOAD_SZ

BRCM_COMP_HOST_CFLAGS += -DIMGL_RPC_MEM_MSG_PAYLOAD_SZ=RPC_MEM_MSG_PAYLOAD_SZ
BRCM_COMP_LIB_CFLAGS += -DIMGL_RPC_MEM_MSG_PAYLOAD_SZ=RPC_MEM_MSG_PAYLOAD_SZ

BRCM_COMP_REQ_SRC    += doc/system_req.c
BRCM_COMP_EXPORT_HDR += inc/system_module_v2.h
BRCM_COMP_EXPORT_HDR += inc/osil/system_service_osil.h

BRCM_COMP_REQ_SRC    += doc/system_dmon_req.c
BRCM_COMP_EXPORT_HDR += inc/system_dmon.h
BRCM_COMP_HOST_SRC   += host/system_dmon_host.c

BRCM_COMP_REQ_SRC    += doc/system_imgl_req.c
BRCM_COMP_EXPORT_HDR += inc/system_imgl.h
ifeq ($(ENABLE_IMGL_V2), TRUE)
BRCM_COMP_UHOST_SRC   += host/system_imgl_host.c
endif

BRCM_COMP_UHOST_SRC += host/system_rpc_host.c

