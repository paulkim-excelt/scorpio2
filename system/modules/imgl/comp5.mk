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

##  @defgroup grp_imgl_legacy Image Loader
#   @ingroup grp_imgl
#
#   @addtogroup grp_imgl_legacy
#   @{
#   @image html imgl_overview.png "Image Loader Overview"
#   This component abstracts loading executable/configuration images/comp_flowchart
#   over various interfaces like NVM (Flash/OTP), Network (TFTP), IPC etc..
#
#   @limitations Image Loader chooses one load path (NVM/TFTP/IPC etc) and attempts to load the image.
#   Failure to load in one path, will not attempt to load in a different path.
#
#   @file system/imgl/comp5.mk
#   @brief Makefile for Config Loader
#   @version 0.1 Initial version
#   @}
#

BRCM_COMP_NAME := imgl_legacy
BRCM_COMP_DEPENDS := imgl_interface crypto time

BRCM_COMP_TYPE := lib

BRCM_COMP_IT_SRC += tests/integration/imgl_it.h
BRCM_COMP_REQ_SRC += doc/imgl_req.c
BRCM_COMP_EXPORT_HDR += inc/imgl.h
BRCM_COMP_EXPORT_HDR += inc/imgl_interface.h
BRCM_COMP_EXPORT_HDR += inc/osil/imgl_osil.h
BRCM_COMP_EXPORT_HDR += inc/osil/imgl_memory.h
BRCM_COMP_EXPORT_HDR += inc/imgl_version.h
BRCM_COMP_EXPORT_HDR += inc/imgl_mmap.h

BRCM_COMP_DOC_SRC += doc/images/imgl_overview.png

BRCM_COMP_APP_EVENT += IMGL_EVENT

BRCM_COMP_APP_SRC += os/common/imgl.c

ifeq ($(ENABLE_RPC_V2),TRUE)
BRCM_COMP_APP_SRC += os/common/imgl_rpc.c
endif

BRCM_COMP_QT_SRC += tests/qualification/imgl_core_qt.h

