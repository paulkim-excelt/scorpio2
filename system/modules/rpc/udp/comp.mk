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

##  @defgroup grp_rpc_v2_udp UDP
#   @ingroup grp_rpc_v2
#
#   @addtogroup grp_rpc_v2_udp
#   @{
#   @file system/rpc/udp/comp.mk
#   @brief Makefile for RPC UDP Component
#   @version 0.1 Initial version
#   @}
#

BRCM_COMP_NAME    := rpc_udp
BRCM_COMP_DEPENDS := tftp inet
BRCM_COMP_DEPENDS += rpc_mem rpc_local ethutils
BRCM_COMP_TYPE    := doc

# TFTP library does not use newer comp.mk format
BRCM_COMP_UEXPORT_HDR += ../../../../ethernet/tcp_ip/tftp/inc/tftp.h

BRCM_COMP_REQ_SRC     += doc/rpc_udp_req.c

BRCM_COMP_EXPORT_HDR  += inc/osil/rpc_udp_osil.h
BRCM_COMP_EXPORT_HDR  += inc/osil/rpc_udp_platform.h
BRCM_COMP_EXPORT_HDR  += inc/rpc_udp_common.h

BRCM_COMP_APP_CFLAGS  += -DRPC_UDPINTF_DATA_EVENT=SystemEvent7
BRCM_COMP_APP_CFLAGS  += -DINET_RPC_UDP_SLAVE_SERVER=RPC_UDPSlaveServer
BRCM_COMP_APP_CFLAGS  += -DINET_RPC_UDP_SLAVE_TX=RPC_UDPSlaveTx
BRCM_COMP_APP_CFLAGS  += -DINET_RPC_UDP_SLAVE_RX=RPC_UDPSlaveRx
BRCM_COMP_APP_CFLAGS  += -DINET_RPC_UDP_SLAVE_STRM0=RPC_UDPSlaveStrm0
BRCM_COMP_APP_CFLAGS  += -DINET_RPC_UDP_SLAVE_STRM1=RPC_UDPSlaveStrm1
BRCM_COMP_APP_CFLAGS  += -DINET_RPC_UDP_MASTER_SERVER=RPC_UDPMasterServer
BRCM_COMP_APP_CFLAGS  += -DINET_RPC_UDP_MASTER_TX=RPC_UDPMasterTx
BRCM_COMP_APP_CFLAGS  += -DINET_RPC_UDP_MASTER_RX=RPC_UDPMasterRx
BRCM_COMP_APP_CFLAGS  += -DINET_RPC_UDP_MASTER_STRM0=RPC_UDPMasterStrm0
BRCM_COMP_APP_CFLAGS  += -DINET_RPC_UDP_MASTER_STRM1=RPC_UDPMasterStrm1

BRCM_COMP_APP_SRC     += os/common/rpc_udp_common.c
BRCM_COMP_APP_SRC     += os/common/rpc_udp_slave.c
BRCM_COMP_APP_SRC     += os/common/rpc_udp_master.c
BRCM_COMP_APP_SRC     += os/common/rpc_udp_platform.c
BRCM_COMP_APP_SRC     += os/erika/rpc_udp_osil.c
