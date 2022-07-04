#!/usr/bin/python3

# $Id$
# $Copyright: Copyright 2021 Broadcom Limited.
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
# CORRESPONDENCE TO nameRIPTION. YOU ASSUME THE ENTIRE RISK ARISING
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

# BCM Error Codes
BCM_ERR_OK              = 0x0           # No Error
BCM_ERR_BUSY            = 0x1           # Device or resource busy
BCM_ERR_NODEV           = 0x2           # No device found
BCM_ERR_NOT_FOUND       = 0x3           # Not Found
BCM_ERR_NOMEM           = 0x4           # Out of memory
BCM_ERR_NOSUPPORT       = 0x5           # Not supported
BCM_ERR_INVAL_PARAMS    = 0x6           # Invalid argument
BCM_ERR_INVAL_MAGIC     = 0x7           # Invalid magic number
BCM_ERR_INVAL_STATE     = 0x8           # Invalid state
BCM_ERR_INVAL_BUF_STATE = 0x9           # Invalid buffer state
BCM_ERR_EAGAIN          = 0xA           # Try again
BCM_ERR_TIME_OUT        = 0xB           # Timeout
BCM_ERR_UNINIT          = 0xC           # Device or resource not initialized
BCM_ERR_CANCELLED       = 0xD           # Cancel request success
BCM_ERR_DATA_INTEG      = 0xE           # Data integrity error
BCM_ERR_AUTH_FAILED     = 0xF           # Authentication error
BCM_ERR_VERSION         = 0x10          # Wrong version of hw/sw
BCM_ERR_BUS_FAILURE     = 0x11          # Bus Failure
BCM_ERR_NACK            = 0x12          # NACK error
BCM_ERR_MAX_ATTEMPS     = 0x13          # Maximum num of attempts
BCM_ERR_UNKNOWN         = 0x14          # Unknown error
BCM_ERR_CUSTOM          = 0x15          # Module specific error
BCM_ERR_NOPERM          = 0x16          # Permission denied