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

BRCM_COMP_APP_SRC := qualification/rpc_test.c

BRCM_INC += $(BRCM_SDK_ROOT)/system/rpc/inc/osil
BRCM_INC += $(BRCM_SDK_ROOT)/system/rpc/inc
BRCM_INC += $(BRCM_SDK_ROOT)/system/imgl/inc/imgl_interface.h
BRCM_INC += $(BRCM_SDK_ROOT)/system/rpc/tests/qualification
BRCM_INC += $(BRCM_SDK_ROOT)/ethernet/common/rpc/inc/

BRCM_COMP_EXPORT_HDR += integration/rpc_mem_it.h

BRCM_COMP_IT_SRC += integration/rpc_mem_it.h

BRCM_CFLAGS += -DENABLE_SHELL_AUTO_TEST_FUNC=1
BRCM_CFLAGS += -DRPC_TEST_IFC=RPC_MsgQTestIfc
BRCM_CFLAGS += -DRPC_TASK=RPC_TestTask
BRCM_CFLAGS += -DRPC_MEM_MSG_COUNT=8UL
BRCM_CFLAGS += -DRPC_MEM_STREAM_COUNT=2UL
BRCM_CFLAGS += -DRPC_MEM_STREAM_SIZE=2048UL
BRCM_CFLAGS += -DRPC_MSGQ_MASTER_EVENT=SystemEvent7
BRCM_CFLAGS += -DRPC_ASYNC_EVENT=RPC_MSGQ_MASTER_EVENT
BRCM_CFLAGS += -DRPC_SLAVE_EVENT=SystemEvent7
BRCM_CFLAGS += -DRPC_IPCSLAVE_CHANNEL_NUM=0U
BRCM_CFLAGS += -DRPC_IPCSLAVE_CHANNEL_0_EVENT=SystemEvent8
BRCM_CFLAGS += -DRPC_SLAVE_ENABLE_LOCALCMD_SUPPORT=1UL
BRCM_CFLAGS += -DRPC_MASTER_ENABLE_IFC_SUPPORT=1UL

BRCM_COMP_APP_CFLAGS += -DENABLE_TEST_SVC=1
BRCM_COMP_APP_CFLAGS += -DIPC_SERVER_TASK=RPC_TestTask
BRCM_COMP_APP_CFLAGS += -DIPC_CHANN0_EVENT=SystemEvent9

BRCM_COMP_APP_EVENT += SystemEvent0
BRCM_COMP_APP_EVENT += SystemEvent7
BRCM_COMP_APP_EVENT += SystemEvent8
BRCM_COMP_APP_EVENT += RPC_MSGQ_MASTER_LOADER_EVENT
BRCM_COMP_APP_EVENT += SystemEvent9

BRCM_COMP_APP_OPT += ENABLE_CONSOLE
BRCM_COMP_APP_OPT += ENABLE_MSG_QUEUE
BRCM_COMP_APP_OPT += ENABLE_UART0
BRCM_COMP_APP_OPT += ENABLE_IPC
BRCM_COMP_APP_OPT += ENABLE_RPC_MSGQ_TEST

BRCM_COMP_APP_TASK += RPC_TestTask
RPC_TestTask.priority = 3
RPC_TestTask.stack = 4096
RPC_TestTask.event += SystemEvent0
RPC_TestTask.event += SystemEvent7
RPC_TestTask.event += SystemEvent9
RPC_TestTask.event += RPC_MSGQ_MASTER_LOADER_EVENT

BRCM_COMP_NAME := rpc_test
BRCM_COMP_DEPENDS := imgl_interface ipcdrv rpc_v2
BRCM_COMP_TYPE := test
