#!/usr/bin/python3

#
# $Id$
# Copyright: Copyright 2021-2022 Broadcom Limited.
# This program is the proprietary software of Broadcom Limited
# and/or its licensors, and may only be used, duplicated, modified
# or distributed pursuant to the terms and conditions of a separate,
# written license agreement executed between you and Broadcom
# (an "Authorized License").  Except as set forth in an Authorized
# License, Broadcom grants no license (express or implied), right
# to use, or waiver of any kind with respect to the Software, and
# Broadcom expressly reserves all rights in and to the Software
# and all intellectual property rights therein.  IF YOU HAVE
# NO AUTHORIZED LICENSE, THEN YOU HAVE NO RIGHT TO USE THIS SOFTWARE
# IN ANY WAY, AND SHOULD IMMEDIATELY NOTIFY BROADCOM AND DISCONTINUE
# ALL USE OF THE SOFTWARE.
#
# Except as expressly set forth in the Authorized License,
#
# 1.     This program, including its structure, sequence and organization,
# constitutes the valuable trade secrets of Broadcom, and you shall use
# all reasonable efforts to protect the confidentiality thereof,
# and to use this information only in connection with your use of
# Broadcom integrated circuit products.
#
# 2.     TO THE MAXIMUM EXTENT PERMITTED BY LAW, THE SOFTWARE IS
# PROVIDED "AS IS" AND WITH ALL FAULTS AND BROADCOM MAKES NO PROMISES,
# REPRESENTATIONS OR WARRANTIES, EITHER EXPRESS, IMPLIED, STATUTORY,
# OR OTHERWISE, WITH RESPECT TO THE SOFTWARE.  BROADCOM SPECIFICALLY
# DISCLAIMS ANY AND ALL IMPLIED WARRANTIES OF TITLE, MERCHANTABILITY,
# NONINFRINGEMENT, FITNESS FOR A PARTICULAR PURPOSE, LACK OF VIRUSES,
# ACCURACY OR COMPLETENESS, QUIET ENJOYMENT, QUIET POSSESSION OR
# CORRESPONDENCE TO DESCRIPTION. YOU ASSUME THE ENTIRE RISK ARISING
# OUT OF USE OR PERFORMANCE OF THE SOFTWARE.
#
# 3.     TO THE MAXIMUM EXTENT PERMITTED BY LAW, IN NO EVENT SHALL
# BROADCOM OR ITS LICENSORS BE LIABLE FOR (i) CONSEQUENTIAL,
# INCIDENTAL, SPECIAL, INDIRECT, OR EXEMPLARY DAMAGES WHATSOEVER
# ARISING OUT OF OR IN ANY WAY RELATING TO YOUR USE OF OR INABILITY
# TO USE THE SOFTWARE EVEN IF BROADCOM HAS BEEN ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGES; OR (ii) ANY AMOUNT IN EXCESS OF
# THE AMOUNT ACTUALLY PAID FOR THE SOFTWARE ITSELF OR USD 1.00,
# WHICHEVER IS GREATER. THESE LIMITATIONS SHALL APPLY NOTWITHSTANDING
# ANY FAILURE OF ESSENTIAL PURPOSE OF ANY LIMITED REMEDY.$
####################################################################################

import sys
sys.dont_write_bytecode = True
import os

# BCM_GroupIDType
BCM_GROUPID_IMGL        = 0x00          # Image Loader group
BCM_GROUPID_SYS         = 0x01          # System group
BCM_GROUPID_NVM         = 0x02          # NVM group
BCM_GROUPID_ETHSRV      = 0x03          # Communications group
BCM_GROUPID_APP         = 0x04          # Application Group
BCM_GROUPID_CONSOLE     = 0x05          # Console Group
BCM_GROUPID_AVCE        = 0x20          # AVCE Group
BCM_GROUPID_AVCD        = 0x21          # AVCD Group
BCM_GROUPID_CAMERA      = 0x22          # Camera Group
BCM_GROUPID_OPENVX      = 0x23          # OPENVX Group
BCM_GROUPID_LDC         = 0x24          # LDC Group
BCM_GROUPID_DISPLAY     = 0x25          # Display Group
BCM_GROUPID_GRAPHICS    = 0x26          # Graphics Group
BCM_GROUPID_STITCH      = 0x27          # Stitch Group
BCM_GROUPID_AUDIO       = 0x28          # Audio Group
BCM_GROUPID_TEST        = 0x3E          # Test Group
BCM_GROUPID_INVALID     = 0x3F          # Invalid group

# BCM_CompIDType
BCM_RSV_ID              = 0x0000        # Reserved
BCM_MOD_ID              = 0x0001        # Module
BCM_MSG_ID              = 0x0002        # MsgQ (IPC)
BCM_UTL_ID              = 0x0003        # UTILS
BCM_OSI_ID              = 0x0004        # OSI
BCM_DCA_ID              = 0x0005        # DCache
BCM_MCU_ID              = 0x0100        # MCU
BCM_WDG_ID              = 0x0101        # Watchdog
BCM_DDR_ID              = 0x0102        # DDR
BCM_VTM_ID              = 0x0103        # VTMON
BCM_SPT_ID              = 0x0104        # SP804
BCM_AVT_ID              = 0x0105        # AVT
BCM_IPC_ID              = 0x0106        # IPC
BCM_TMD_ID              = 0x0120        # Time module
BCM_IMG_ID              = 0x0121        # IMGL
BCM_RPC_ID              = 0x0122        # RPC
BCM_PPR_ID              = 0x0130        # PixelProcessor
BCM_SYS_ID              = 0x0140        # SYS
BCM_CTL_ID              = 0x0141        # BL Control
BCM_ROM_ID              = 0x0142        # ROM
BCM_BCP_ID              = 0x0200        # Board phrpls
BCM_GIO_ID              = 0x0201        # GPIO
BCM_PMX_ID              = 0x0202        # PinMux
BCM_SEI_ID              = 0x0203        # SIO Serial IO
BCM_IIC_ID              = 0x0204        # IIC
BCM_SPI_ID              = 0x0205        # SPI
BCM_SIO_ID              = 0x0206        # SDIO
BCM_PWM_ID              = 0x0207        # PWM
BCM_ADC_ID              = 0x0208        # ADC
BCM_DMA_ID              = 0x0209        # DMA330
BCM_CAN_ID              = 0x020A        # CAN
BCM_LIN_ID              = 0x020B        # LIN
BCM_CCT_ID              = 0x020C        # CCT
BCM_QSP_ID              = 0x0300        # QSPI
BCM_OTP_ID              = 0x0301        # OTP
BCM_PCH_ID              = 0x0302        # PATCH
BCM_OTM_ID              = 0x0320        # OTPM
BCM_FLM_ID              = 0x0321        # Flash Manager
BCM_PTM_ID              = 0x0322        # PTM
BCM_NVM_ID              = 0x0340        # NVM
BCM_SHP_ID              = 0x0400        # Secure heap
BCM_SPM_ID              = 0x0401        # SPUM
BCM_PKA_ID              = 0x0402        # PKA
BCM_RND_ID              = 0x0403        # RAND
BCM_CVM_ID              = 0x0420        # Crypto verify module
BCM_CRS_ID              = 0x0440        # Crypto Service
BCM_XVR_ID              = 0x0500        # XVR
BCM_AMC_ID              = 0x0501        # AMAC
BCM_UNI_ID              = 0x0502        # UNIMAC
BCM_MIO_ID              = 0x0503        # MDIO
BCM_ETH_ID              = 0x0504        # ETH
BCM_SWT_ID              = 0x0505        # SWITCH
BCM_CFP_ID              = 0x0506        # CFP
BCM_FAC_ID              = 0x0507        # Flow Accelerator
BCM_NIF_ID              = 0x0520        # NIF
BCM_NET_ID              = 0x0521        # Internet Stack
BCM_TCT_ID              = 0x0522        # TC10
BCM_ETT_ID              = 0x0523        # ETH Time
BCM_ETS_ID              = 0x0524        # ETS Component
BCM_COM_ID              = 0x0540        # COM
BCM_ETL_ID              = 0x0551        # ETS Library
BCM_TFT_ID              = 0x0552        # TFTP
BCM_RTL_ID              = 0x0553        # RTP Library
BCM_RTS_ID              = 0x0554        # RTP Sender Component
BCM_RTR_ID              = 0x0555        # RTP Receiver Component
BCM_RFS_ID              = 0x0556        # RFS
BCM_MTL_ID              = 0x0557        # MPEG2TS Library
BCM_AVL_ID              = 0x0560        # AVB Library
BCM_AVB_ID              = 0x0561        # AVB Component
BCM_WLC_ID              = 0x0570        # Wireless LAN
BCM_SHL_ID              = 0x0800        # UART Console
BCM_URT_ID              = 0x0801        # UART->CONSOLE
BCM_MSF_ID              = 0x0900        # Media System & Framework
BCM_AVE_ID              = 0x2000        # AVC Encoder Component
BCM_VEN_ID              = 0x2001        # Video Encoder Component
BCM_AVD_ID              = 0x2100        # AVC Decoder Component
BCM_VDE_ID              = 0x2101        # Video Decoder Component
BCM_CAM_ID              = 0x2200        # Camera
BCM_CFW_ID              = 0x2201        # Camera Fmwk
BCM_CTN_ID              = 0x2202        # Camera Tuners
BCM_CSN_ID              = 0x2203        # Camera Sensor
BCM_UCM_ID              = 0x2204        # UNICAM
BCM_ISP_ID              = 0x2205        # ISP
BCM_VXS_ID              = 0x2300        # Openvx Server
BCM_OPF_ID              = 0x2301        # Opticalflow Component
BCM_LDC_ID              = 0x2400        # LDC Component
BCM_PV0_ID              = 0x2500        # PixelValve
BCM_CMP_ID              = 0x2501        # Compositor
BCM_BTV_ID              = 0x2502        # BT656 Controller
BCM_DSI_ID              = 0x2503        # DSI Controller
BCM_AFE_ID              = 0x2504        # AFE Controller
BCM_MWB_ID              = 0x2505        # Memory Writeback
BCM_DMS_ID              = 0x2506        # MISC Controller
BCM_VGC_ID              = 0x2507        # Video & Graphics Composer
BCM_DIS_ID              = 0x2508        # Display Service
BCM_VRC_ID              = 0x2509        # Video Renderer Component
BCM_MFD_ID              = 0x250A        # MPEGFeeder
BCM_GFD_ID              = 0x2600        # GraphicsFeeder
BCM_GRC_ID              = 0x2601        # Graphics Renderer Component
BCM_STC_ID              = 0x2700        # Stitch Component
BCM_APY_ID              = 0x2800        # Audio play component
BCM_ARC_ID              = 0x2801        # Audio record component
BCM_IIS_ID              = 0x2802        # I2S


# BCM_CmdType
BCM_CMD_ID_SHIFT        = 0                                    # Command ID shift value
BCM_CMD_ID_MASK         = 0xFF << BCM_CMD_ID_SHIFT             # Command ID shift mask
BCM_CMD_COMP_SHIFT      = 8                                    # Component ID shift value
BCM_CMD_COMP_MASK       = 0xFFFF << BCM_CMD_COMP_SHIFT         # Component ID shift mask
BCM_CMD_GROUP_SHIFT     = 24                                   # Group ID shift value
BCM_CMD_GROUP_MASK      = 0x3F << BCM_CMD_GROUP_SHIFT          # Group ID shift mask
BCM_CMD_RESPONSE_SHIFT  = 30                                   # Resp bit Shift value
BCM_CMD_RESPONSE_MASK   = 1 << BCM_CMD_RESPONSE_SHIFT          # Async bit Shift mask
BCM_CMD_ASYNC_SHIFT     = 31                                   # Async bit Shift value
BCM_CMD_ASYNC_MASK      = 1 << BCM_CMD_ASYNC_SHIFT             # Async bit Shift mask
BCM_CMD_MAGIC_CMD       = 0xa5a5a5a5                           # Command magic
BCM_CMD_MAGIC_RESP      = 0x5a5a5a5a                           # Response magic

def BCM_ASYNCID(aGrp, aComp, aId):
    return ((BCM_CMD_ASYNC_MASK) | (((aGrp) << BCM_CMD_GROUP_SHIFT) & BCM_CMD_GROUP_MASK) \
                                 | (((aComp) << BCM_CMD_COMP_SHIFT) & BCM_CMD_COMP_MASK)  \
                                 | (((aId) << BCM_CMD_ID_SHIFT) & BCM_CMD_ID_MASK))

def BCM_CMDID(aGrp, aComp, aId):
    return (((aGrp) << BCM_CMD_GROUP_SHIFT) & BCM_CMD_GROUP_MASK)  \
        |  (((aComp) << BCM_CMD_COMP_SHIFT) & BCM_CMD_COMP_MASK)     \
        |  (((aId) << BCM_CMD_ID_SHIFT) & BCM_CMD_ID_MASK)