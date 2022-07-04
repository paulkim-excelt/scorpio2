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

##  @defgroup grp_rpc_v2 Remote Procedure Call
#   @ingroup grp_system
#
#   @addtogroup grp_rpc_v2
#   @{
#   Remote Procedure Call Architecture supports interaction between a Controller (Host)
#   and a tree of service providers with one master and multiple slaves. It can be
#   extended to support multiple trees with little enhancements.
#
#   Commands always originate from Host/Master. They are serviced by Master and
#   Slaves when originating from Host. They are serviced by Slaves, when originating
#   from Master. A command is assumed to be complete when there is a response in
#   the reverse direction from Slaves/Master. Master is responsible for consolidating
#   responses from multiple slaves before responding back to Host.
#
#   Notifications travel in the reverse direction. They originate from Master or
#   Slave and get consumed by Host or Master respectively. These messages carry
#   critical error notifications, safety indications and log messages.
#
#   Streams are originating in Slave or Master Service Providers and are serviced
#   by Master or Host respectively. For example, Master requests for the
#   Bootloader/Firmware/Configuration as a stream request to Host and Host is
#   expected to service the same. Similarly, Slave requests for the
#   Bootloader/Firmware/Configuration as a stream request to Master and Master
#   is expected to service the same. In certain cases, when Slave requests a stream,
#   Master may go back to Host for fetching them via another stream request.
#
#   RPC Architecture consists of
#   -# Proxy Module for integration into System/Application, interacts with underlying
#      interfaces for commands, responses, notifications and streams.
#       -# With relevant interfaces, this may represent Proxy on Host, and on
#          Master/Slave with different responsiblities.
#       .
#   -# Interfaces for interaction with proxy module and remote service providers
#      [a special case is communication between Local Master and Local Slave Interfaces]
#       -# Local Interfaces are special interfaces to interact with local
#          subsystems (Ethernet Switch, IMGL etc), get the commands processed
#          and get the streams serviced. Also, Local interfaces are responsible
#          for forwarding commands to Slave Service Provicers and merging the responses.
#       .
#   -# RPC Memory (not depicted above) for abstraction of Command/Response/Notification/Stream
#       -# Supports holding 32-bit Application Info that may be used in the
#          return path for command/responses
#       -# Supports holding stream configurations for detection of stream transfer completion
#       .
#
#   All of this RPC Architecture is terminated by a utility on Host, named "BCM Utility"
#   with the help of message helpers architecture defined at @ref grp_architecture_msg.
#   Utility on Host may use standard Unix Socket interface to communicate with
#   RPC Proxy on Host. This interface may be replaced with an equivalent by customers/integrators.
#
#   RPC Architecture with a Host, a Master and one Slave may be visualized as below.
#   @image html rpc_architecture_master_salve.png "RPC with Multiple Service Providers" width="200%"
#
#   A typical flow of a command would be as follows. Utility will send
#   a command to Socket Slave Interface. RPC Proxy Module (On Host) receives the
#   message from Socket Slave Interface and forwards it to Local Master Interface (on Host).
#   Local Master Interface (on Host) will perform any authentication/decryption
#   related activities and forwards the message to Local Slave Interface (On Host).
#   Local Slave Interface (on Host) may perform encryption/signing for the message.
#   RPC Proxy Module receives the encrypted/signed message from Local Slave Interface (On Host)
#   and forwards it to IPC Master Interface. IPC Master Interface serializes the
#   message on the channel and sends to the Master Service Provider. Master Service
#   Provider receives the message on IPC Slave Interface. RPC Proxy (on Master)
#   will receive the message from IPC Slave Interface, forwards it to Local Master
#   Interface (On Master). Local Master Interface (on Master) will perform any
#   authentication/decryption related activities and forwards the message to Services
#   on Master Service Provier and optionally to Local Slave Interface (On Master) for
#   further forwarding.
#
#   Responses/Notifications traverse the reverse path in the exact same way with
#   encryption/signing replaced by decryption/authentication.
#
#   Streams are only authenticated and are never encrypted/decrypted/signed by
#   any Service Provider.
#
#   RPC Architecture with Host and Master (no Slaves) can be interpreted as below.
#   @image html rpc_architecture_master_only.png "RPC with single Service Provider" width="200%"
#
#   @note Notifications are not sent by default to Host. Host (or each client on Host)
#   may register for required notifications. And, only registered notifications
#   will be sent to the Host.
#
#   @limitations Reference implementation with Unix sockets demonstrates capability
#   of limited  clients sending commands via the proxy to Master and getting the
#   responses back to Utility. This includes, execution of commands like "vlan add"
#   etc while update is in progress ("install custom" command in progress).
#   However, it is integrators resposibility to make sure that these different
#   clients are synchronized with each other and are not giving conflicting commands.
#
#   @limitations All APIs in this component must be called in a single thread context
#   except as decribed in Module Architecture at @ref grp_module
#
#   @file system/rpc/comp.mk
#   @brief Makefile for RPC
#   @version 0.1 Initial version
#   @}
#

BRCM_COMP_NAME := rpc_v2
BRCM_COMP_DEPENDS := lwq imgl_interface
BRCM_COMP_DEPENDS += rpc_mem rpc_ipc rpc_local rpc_socket
BRCM_COMP_DEPENDS += rpc_module
ifeq ($(call isappopt,ENABLE_RPC_UDP),yes)
BRCM_COMP_DEPENDS += rpc_udp
endif
BRCM_COMP_TYPE := doc

BRCM_COMP_DOC_SRC += doc/images/rpc_architecture_master_salve.png
BRCM_COMP_DOC_SRC += doc/images/rpc_architecture_master_only.png

BRCM_COMP_QT_SRC += tests/qualification/rpc_qt.h
