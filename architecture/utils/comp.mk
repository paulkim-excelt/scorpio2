#
# Copyright 2016-2021 Broadcom Limited.  All rights reserved.
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
################################################################################


##  @defgroup grp_utils Utilities
#   @ingroup grp_introduction
#
#   @addtogroup grp_utils
#   @{
#   Broadcom SDK provides utilities like
#       -# Pre-defined error codes for all component use
#       -# Wrappers for Memory Copy/Compare operations
#       -# Wrappers for Time APIs
#       -# Error Reporting ability
#       -# Logging
#
#   @limitations None
#   @file architecture/utils/comp.mk
#   @brief Makefile for BCM Utils/Logging/Error Reporting
#   @features Memory Test
#   @version 0.1 Initial version
#   @}
#
#

BRCM_COMP_NAME := utils
BRCM_COMP_DEPENDS := abstract module lwq msgq ptu
BRCM_COMP_TYPE := lib

BRCM_COMP_REQ_SRC += doc/utils_req.c

ifneq ($(cpu),em22fs)
BRCM_COMP_REQ_SRC += doc/utils_test_req.c
BRCM_COMP_REQ_SRC += doc/utils_idle_req.c
BRCM_COMP_EXPORT_HDR += inc/bcm_memtest.h
BRCM_COMP_LIB_SRC  += lib/bcm_memtest.c
BRCM_COMP_QT_SRC   += tests/qualification/memtest_qt.h
BRCM_COMP_IT_SRC += tests/integration/memtest_it.h
BRCM_COMP_DEPENDS  += circq
BRCM_COMP_EXPORT_HDR += inc/idle.h
BRCM_COMP_APP_SRC += os/erika/idle.c
else
BRCM_COMP_UAPP_SRC += os/erika/idle.c
endif

BRCM_COMP_EXPORT_HDR += inc/crc.h
BRCM_COMP_EXPORT_HDR += inc/dbg_log.h
BRCM_COMP_EXPORT_HDR += inc/cpu_utils.h

ifeq ($(call isappopt,BRCM_TEST_BUILD),yes)
BRCM_COMP_APP_CFLAGS += -DBCM_DBG_MSG_TASK=IDLE_Task
BRCM_COMP_UAPP_SRC   += tests/bcm_test.c
else
ifeq ($(call isappopt,ENABLE_RPC_DBG_MSG),yes)
BRCM_COMP_APP_CFLAGS += -DBCM_DBG_MSG_TASK=SYSTEM_Task
else
BRCM_COMP_APP_CFLAGS += -DBCM_DBG_MSG_TASK=TaskShell
endif
endif

BRCM_COMP_UAPP_SRC += os/erika/error.c

BRCM_COMP_LIB_SRC += lib/crc.c
BRCM_COMP_HOST_SRC += lib/crc.c
BRCM_COMP_LIB_SRC += lib/dbg_log.c
BRCM_COMP_LIB_SRC += lib/svc_test_request.c

BRCM_COMP_IT_SRC += tests/integration/svc_it.h
BRCM_COMP_IT_SRC += tests/integration/crc_it.h

BRCM_COMP_COVERAGE_EXCLUDE += $(BRCM_SDK_ROOT)/architecture/utils/os/erika/build_info.c

BRCM_COMP_APP_EVENT += BCM_TEST_LOAD_EVENT

BRCM_COMP_APP_SRC += os/base/bcm_os_base.c

ifeq ($(cpu),m7)
BRCM_COMP_LIB_CFLAGS += -DSVC_PROFILER_GET_CNT=CORTEX_MX_SysTickGetCnt
endif

BRCM_COMP_APP_TASK += IDLE_Task
IDLE_Task.priority = 1
ifeq ($(call isappopt,ENABLE_WFI),yes)
IDLE_Task.stack = 512
else
IDLE_Task.stack = 1024
endif
IDLE_Task.autostart := true

BRCM_COMP_LIB_CFLAGS += -DDBG_LOG_START_CODE=1
BRCM_COMP_LIB_CFLAGS += -DDBG_LOG_ROM_BYPASS=2
BRCM_COMP_LIB_CFLAGS += -DDBG_LOG_CHECK_PLL_STATUS=3
BRCM_COMP_LIB_CFLAGS += -DDBG_LOG_PLL_NOT_LOCKED_LOOP=4
BRCM_COMP_LIB_CFLAGS += -DDBG_LOG_SWITCH_CPU_CLK=5
