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


##  @defgroup grp_module Module and Service
#   @ingroup grp_introduction
#
#   @addtogroup grp_module
#   @{
#
#   Each module is designed with a state based model to execute in a single thread.
#
#   Each Service is designed to run in a Task. Each service consists
#   of a client and server module, with same Group/Comp ID (must be same).
#
#   Client module consists of
#   -# State handlers to send state transition to server (@ref SERVICE_ClientStateHandler)
#   -# Client MSGQ is owned by Server module as well and used to hold the state transition requests
#   -# Event handler to process responses from Client MSGQ (call MSGQ_Recv)
#   -# processCmd set to NULL
#   -# sendCmd/getResp/mergeResult/asyncMsg are directly routed to server related
#      equivalent functions
#   -# There should not be any sub modules to this module
#
#   Server module consists of
#   -# State handlers to handle state transition of all sub modules within server
#       task (maybe implemented using helper functions in @ref grp_module_helpers_ifc)
#   -# MSGQ within service maybe used to preserve commands (if any)
#   -# Event handler to process events from submodules and service module itself
#   -# processCmd must be NULL
#   -# sendCmd/getResp/mergeResult/asyncMsg must be routed to submodules and are
#       to be implemented like a regular module function
#
#   @file architecture/module/comp.mk
#   @brief Makefile for Automotive Software Architecture
#   @version 0.1 Initial version
#   @}
#

BRCM_COMP_NAME := module
BRCM_COMP_DEPENDS += abstract
BRCM_COMP_TYPE := lib

BRCM_COMP_REQ_SRC += doc/module_req.c

BRCM_COMP_EXPORT_HDR += inc/module.h
BRCM_COMP_EXPORT_HDR += inc/module_msg.h
BRCM_COMP_EXPORT_HDR += inc/module_helper.h
BRCM_COMP_EXPORT_HDR += inc/osil/module_osil.h

BRCM_COMP_LIB_SRC += lib/module_helper.c

BRCM_COMP_HOST_SRC += host/module_msg_helper.c

BRCM_COMP_APP_EVENT += MODULE_EVENT
BRCM_COMP_APP_SRC += os/base/module_osil.c

ifeq ($(ENABLE_MODULE_EXECUTE_PATCH), TRUE)
BRCM_COMP_LIB_CFLAGS += -DMODULE_EXECUTE_PATCH=PATCH_ExecPatchSeq
BRCM_COMP_DEPENDS += pchdrv
endif

ifeq ($(call isappopt, ENABLE_BCM_MOD_CONFIG_LOAD), yes)
BRCM_COMP_APP_CFLAGS += -DENABLE_BCM_MOD_CONFIG_LOAD
endif
