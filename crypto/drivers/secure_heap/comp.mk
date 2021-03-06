#
# Copyright 2019-2022 Broadcom Limited.  All rights reserved.
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

##  @defgroup grp_secureheap Secure Heap
#   @ingroup grp_crypto
#
#   @addtogroup grp_secureheap
#   @{
#     Secure heap manages a piece of RAM memory that is suitable to
#     store the sensitive cryptographic content (say key material). Software
#     access to the secure heap is heavily restricted (using MPU or something else)
#     so that the unrelated components in the system cannot read from or write
#     to this memory.
#
#   @file security/drivers/secure_heap/comp.mk
#   @brief Makefile for the Secure heap library
#   @version 0.1 Initial version
#   @}
#

BRCM_COMP_REQ_SRC += doc/secureheap_req.c
BRCM_COMP_EXPORT_HDR += inc/secure_heap.h
BRCM_COMP_EXPORT_HDR += inc/osil/secure_heap_osil.h
BRCM_COMP_LIB_INC += lib/common/secure_heap_internal.h
BRCM_COMP_LIB_SRC += lib/common/secure_heap.c
BRCM_COMP_LIB_SRC += lib/common/alloc_handle_utils.c

BRCM_COMP_APP_SRC += os/erika/secure_heap_osil_erika.c

BRCM_COMP_QT_SRC += tests/qualification/secure_heap_qt.h

ifeq ($(CHIP_FAMILY),bcm8956x)
ifeq ($(version), b0)
BRCM_COMP_LIB_CFLAGS += -DHSMUTILS_M7_ITCM_ADDR_BEGIN=0x00020000UL
BRCM_COMP_LIB_CFLAGS += -DHSMUTILS_M7_ITCM_ADDR_END=0x0007FFFFUL
BRCM_COMP_LIB_CFLAGS += -DHSMUTILS_M7_DTCM_ADDR_BEGIN=0x20000000UL
BRCM_COMP_LIB_CFLAGS += -DHSMUTILS_M7_DTCM_ADDR_END=0x2007BFFFUL
else
BRCM_COMP_LIB_CFLAGS += -DHSMUTILS_M7_ITCM_ADDR_BEGIN=0x00008000UL
BRCM_COMP_LIB_CFLAGS += -DHSMUTILS_M7_ITCM_ADDR_END=0x0007FFFFUL
BRCM_COMP_LIB_CFLAGS += -DHSMUTILS_M7_DTCM_ADDR_BEGIN=0x20000000UL
BRCM_COMP_LIB_CFLAGS += -DHSMUTILS_M7_DTCM_ADDR_END=0x2003BFFFUL
endif
else ifeq ($(CHIP_FAMILY),bcm8957x)
BRCM_COMP_LIB_CFLAGS += -DHSMUTILS_M7_ITCM_ADDR_BEGIN=0x00020000UL
BRCM_COMP_LIB_CFLAGS += -DHSMUTILS_M7_ITCM_ADDR_END=0x0007FFFFUL
BRCM_COMP_LIB_CFLAGS += -DHSMUTILS_M7_DTCM_ADDR_BEGIN=0x20000000UL
BRCM_COMP_LIB_CFLAGS += -DHSMUTILS_M7_DTCM_ADDR_END=0x2007BFFFUL
endif

BRCM_COMP_LIB_CFLAGS += -DSECHEAP_MEMPOOL_CNT_32=64
BRCM_COMP_LIB_CFLAGS += -DSECHEAP_MEMPOOL_CNT_64=16
BRCM_COMP_LIB_CFLAGS += -DSECHEAP_MEMPOOL_CNT_128=8
BRCM_COMP_LIB_CFLAGS += -DSECHEAP_MEMPOOL_CNT_256=4
BRCM_COMP_LIB_CFLAGS += -DSECHEAP_MEMPOOL_CNT_512=4

BRCM_COMP_APP_OPT += ENABLE_SECHEAP

BRCM_COMP_NAME      := secureheap
BRCM_COMP_DEPENDS   := secutils
BRCM_COMP_TYPE      := lib
