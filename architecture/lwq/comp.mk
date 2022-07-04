#
# Copyright 2017-2021 Broadcom Limited.  All rights reserved.
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

##  @defgroup grp_lwq Light Weight Queues
#   @ingroup grp_introduction
#
#   @addtogroup grp_lwq
#   @{
#   Light Weight Queue is intented to handle index queuing mechanism limited to
#   15 entries. For example, component 'X' allocated an array of 10 buffers and
#   wants to manage buffers and their state transitions in a quick and light
#   manner (say for example filled queue vs empty queue etc). Light Weight Queue
#   can be used in such cases without much performance and memory overheads.
#
#   Light Weight Queue provides:
#       -# Macros to define and initialize a LWQ
#       -# APIs to get number of indices in LWQ
#       -# APIs to push/pop to/from the LWQ
#       -# API to peek into the LWQ
#       .
#
#   Light Weight Queue does not provide atomicity of operations and client must
#   take care of any atomicity requirements.
#
#   <BR>Light Weight Queues are intented to be used by media framework and
#   media components extensively.
#
#   @limitations Each index can only be 4-bit, maximum of 15 indices can be
#                preserved, and no guarantee on atomicity
#
#   @trace #BRCM_SWREQ_LWQ
#
#   @file architecture/lwq/comp.mk
#   @brief Makefile for Light Weight Queues
#   @version 0.1 Initial version
#   @}

BRCM_COMP_NAME := lwq
BRCM_COMP_DEPENDS :=
BRCM_COMP_TYPE := lib

BRCM_COMP_REQ_SRC += doc/lw_queue_req.c

BRCM_COMP_EXPORT_HDR += inc/lw_queue.h

BRCM_COMP_LIB_SRC += lib/lw_queue.c
BRCM_COMP_HOST_SRC += lib/lw_queue.c
