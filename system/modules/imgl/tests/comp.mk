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
#    OF THE AMOUNT ACTUALLY PAID FOR THE SOFTWARE ITSELF OR U.S. $1, WHICHEVER
#    IS GREATER. THESE LIMITATIONS SHALL APPLY NOTWITHSTANDING ANY FAILURE OF
#    ESSENTIAL PURPOSE OF ANY LIMITED REMEDY.
#
####################################################################################

BRCM_COMP_NAME := imgl_fw_test
BRCM_COMP_DEPENDS := imgl_fw crypto_service otpm time otpdrv
BRCM_COMP_TYPE := test

BRCM_COMP_APP_SRC += qualification/imgl_fw_test.c
BRCM_COMP_APP_SRC += qualification/imgl_test_rpc.c

BRCM_COMP_APP_CFLAGS += -DENABLE_SHELL_AUTO_TEST_FUNC=1

BRCM_COMP_APP_EVENT += SystemEvent2 #Test alarm

BRCM_COMP_APP_TASK += IMGLTEST_Task
IMGLTEST_Task.priority = 2
IMGLTEST_Task.stack = 2048
IMGLTEST_Task.event += SystemEvent2
IMGLTEST_Task.event += IMGL_EVENT

BRCM_COMP_APP_TASK += IMGLTEST_ServerTask
IMGLTEST_ServerTask.priority = 9
IMGLTEST_ServerTask.stack = 2048
IMGLTEST_ServerTask.event += IMGL_EVENT

BRCM_COMP_APP_CFG        += imgl_test_bin
imgl_test_bin.pid        = 0x5
imgl_test_bin.imgid      = 0xFF00
imgl_test_bin.maxsz      = 0x20000
imgl_test_bin.file       = system/modules/imgl/tests/qualification/test_flat_flash.bin

BRCM_COMP_APP_CFG        += imgl_update_file
imgl_update_file.pid        = 0x5
imgl_update_file.imgid      = 0xFF02
imgl_update_file.maxsz      = 0x1000
imgl_update_file.file       = system/modules/imgl/tests/qualification/update_img.bin

BRCM_COMP_APP_INC += ./qualification/
BRCM_COMP_APP_INC += ../../service/inc/
BRCM_COMP_APP_INC += ../../rpc/mem/inc/
BRCM_COMP_APP_INC += ../../rpc/ipc/inc/
BRCM_COMP_APP_INC += ../../rpc/local/inc/

BRCM_COMP_APP_OPT += ENABLE_IMGL_MMAP_ASYNC_MODE
BRCM_COMP_APP_OPT += ENABLE_IMGL_MMAP_UPDATE

BRCM_COMP_APP_CFLAGS += -DIMGL_MMAP_SIZE_0=0x18000UL
BRCM_COMP_APP_CFLAGS += -DIMGL_MEMORY_SIZE_0=0x1200UL
BRCM_COMP_APP_CFLAGS += -DIMGL_MEMORY_SIZE_1=0x1200UL
BRCM_COMP_APP_CFLAGS += -DIMGL_TASK_NAME=IMGLTEST_ServerTask

BRCM_COMP_APP_CFLAGS += -DIMGL_MODE_FUNC_TABLE_TEST=IMGL_TestRpcModule
BRCM_COMP_APP_CFLAGS += -DIMGL_MODE_FUNC_TABLE_PRIO0=IMGL_MemoryMapModule

BRCM_COMP_APP_CFG        += imgl_bl_file
imgl_bl_file.pid        = 0x5
imgl_bl_file.imgid      = 0xFFF0
imgl_bl_file.maxsz      = 0x1000
imgl_bl_file.file       = system/modules/imgl/tests/qualification/test_bl.bin

BRCM_COMP_APP_CFG        += imgl_text_file
imgl_text_file.pid        = 0x5
imgl_text_file.imgid      = 0xFFF1
imgl_text_file.maxsz      = 0x1000
imgl_text_file.file       = system/modules/imgl/tests/qualification/test_text.bin

BRCM_COMP_APP_CFG        += imgl_data_file
imgl_data_file.pid        = 0x5
imgl_data_file.imgid      = 0xFFF2
imgl_data_file.maxsz      = 0x1000
imgl_data_file.file       = system/modules/imgl/tests/qualification/test_data.bin

BRCM_COMP_APP_CFG        += imgl_test_file
imgl_test_file.pid        = 0x5
imgl_test_file.imgid      = 0xFFF3
imgl_test_file.maxsz      = 0x1000
imgl_test_file.file       = system/modules/imgl/tests/qualification/test_img.bin

BRCM_COMP_APP_CFG        += imgl_context_file
imgl_context_file.pid        = 0x5
imgl_context_file.imgid      = 0xFFF4
imgl_context_file.maxsz      = 0x1000
imgl_context_file.file       = system/modules/imgl/tests/qualification/test_ctx.bin
