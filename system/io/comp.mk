#
# Copyright 2018-2021 Broadcom Limited.  All rights reserved.
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

##  @defgroup grp_serial_io Serial IO
#   @ingroup grp_system
#
#   @addtogroup grp_serial_io
#   @{
#
#   @file system/io/comp.mk
#   @brief Makefile for BCM8953X Initialization
#   @version 0.1 Initial version
#   @}
#
#

BRCM_COMP_NAME := io
BRCM_COMP_DEPENDS +=
BRCM_COMP_TYPE := doc

BRCM_COMP_UAPP_SRC += os/erika/serial_io_osil.c
BRCM_COMP_UEXPORT_HDR += os/erika/serial_io_osil.h

BRCM_COMP_APP_CFLAGS += -DSPI0_IRQ_EVENT=SystemEvent6
BRCM_COMP_APP_CFLAGS += -DSPI1_IRQ_EVENT=SystemEvent7
BRCM_COMP_APP_CFLAGS += -DSPI2_IRQ_EVENT=SystemEvent8
BRCM_COMP_APP_CFLAGS += -DSPI_IRQ_PROCESS_TASK=TaskSerialIO

BRCM_COMP_APP_TASK += TaskSerialIO
TaskSerialIO.priority := 13
TaskSerialIO.stack := 2048
TaskSerialIO.event += SystemEvent0
TaskSerialIO.event += SystemEvent1
TaskSerialIO.event += SystemEvent2
TaskSerialIO.event += SystemEvent3
TaskSerialIO.event += SystemEvent4
TaskSerialIO.event += SystemEvent5
TaskSerialIO.event += SystemEvent6
TaskSerialIO.event += SystemEvent7
TaskSerialIO.event += SystemEvent8
TaskSerialIO.event += SystemEvent9
TaskSerialIO.event += SystemEvent10
TaskSerialIO.event += SystemEvent11
TaskSerialIO.event += SystemEvent12
