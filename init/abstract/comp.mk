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


##  @defchapter grp_initialization Initialization
#
#   @addtogroup grp_initialization
#   @{
#   This chapter describes early initialization sequence for Broadcom Automotive
#   Chipsets and EVKs including
#   -# Processor initialization (stack pointers, exception/interrupt vector setup)
#   -# MPU configuration
#   -# BSS initialization
#   -# Data Segment movement(if applicable)
#   -# MCU initialization
#   -# Clock and PLL configuration and initialization
#   -# Enable Interrupts and Exceptions
#   -# Start Operating System
#
#   This stage executes with interrupts disabled with CPU running in thread mode
#   with privileged permissions.
#
#   MPU configuration for Peripherals remains the same all through different
#   execution stages. However, Normal memory map varies between different execution
#   stages. MPU is typically configured with
#   -# All Device memories mapped with access restricted to Privileged mode only
#   -# "Text + RO Data" - Restricted to Read Only and Execute permission
#   -# "Privileged Data" - Read access to all, Write access to Privileged mode and
#       parts of this segment is are accessible to respective services
#   -# "Data" - Read/Write access to all
#   -# "BSS" - Read/Write access to all
#   -# "IPC Memory" - Read access to all, Write access to Privileged mode only
#
#   MCU driver is initialized for access to all the services and modules (precisely
#   APIs like #MCU_GetVersion, #MCU_GetInfo etc). System wide Clocks and PLLs are
#   initialized at this stage. PLLs for specific entities are brought up by explicit
#   calls to MCU driver by respective driver. For example, SGMII PLL is powered up
#   upon request from SGMII driver to MCU driver.
#
#   At this point, Interrupts and exceptions are enabled as per application/bootloader
#   configuration and Operating System is started. Rest of initialization is
#   performed by respective services in a task context
#
#   @file init/abstract/comp.mk
#   @brief Makefile for Initialization
#   @version 0.1 Initial version
#   @}
#

BRCM_COMP_NAME := init
BRCM_COMP_DEPENDS :=
BRCM_COMP_TYPE := doc
