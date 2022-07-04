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

import os
import sys
sys.dont_write_bytecode = True
import getopt
sys.path.insert(1, os.path.join(os.path.dirname(os.path.realpath(__file__)), 'rdb'))
from otp import OTP_Args
from otp import OTP_Debugger
from otp import OTP_ReadTarget, OTP_WriteTarget
from otp_header import *
import struct
import array


def BCM89571_OTP_Write(row, val, debugger):
    rdData = []
    OTP_ReadTarget(OTP_HW_ID_0, row, rdData, debugger)
    if (val != 0) and len(rdData) > 0 and (rdData[0] == 0):
        ret = OTP_WriteTarget(OTP_HW_ID_0, row, [val], debugger)
    rdData = []
    OTP_ReadTarget(OTP_HW_ID_0, row, rdData, debugger)
    if (rdData[0] != val):
        print("Failed to program " + hex(val)+ " at " + str(row))
    else:
        print("Programmed "+ hex(val)+ " at " + str(row))

def BCM89571_OTP_Usage():
    print("python bcm89571_otp.py --pkey1=<public key bin file>")
    print("python bcm89571_otp.py --mac=<0201234567AB>")
    sys.exit(2)


def BCM89571_OTP_Main():
    chip    = "bcm8957x"
    version = None
    mcm     = False
    sc      = None
    pkey1   = array.array('L')   # array of long integers
    mac     = array.array('L')   # array of long integers
    try:
        opts, args = getopt.getopt(sys.argv[1:], "h",
                                    ["help", "pkey1=", "mac="])
    except:
        print("Error in parsing arguments")
        BCM89571_OTP_Usage()
    for opt, arg in opts:
        if opt in ("-h", "--help"):
            BCM89571_OTP_Usage()
        elif opt in ("--pkey1"):
            with open(arg, "rb") as keyfile:
                pkey1 = array.array('L', keyfile.read())
            keyfile.close()
            if len(pkey1) != 64:
                print("Invalid public key for pkey1")
                sys.exit(1)
        elif opt in ("--mac"):
            if (len(arg) != 12):
                print("Invalid mac address given for mac")
                sys.exit(1)
            mac.append(int('0x'+ arg[0:6:1],0))
            mac.append(int('0x'+ arg[6:12:1],0))
        else:
            print("Unknown argument %s" % opt)
            OTP_Usage()
    OTP_Args.CHIP = chip
    OTP_Args.VERSION = version

    # Get Debugger object
    debugger = OTP_Debugger(chip, 0, mcm, sc)

    if (len(mac) == 2):
        rdData = []
        rmac = array.array('L')
        OTP_ReadTarget(OTP_HW_ID_0, 294, rdData, debugger)
        rmac.append(rdData[0])
        rdData = []
        OTP_ReadTarget(OTP_HW_ID_0, 295, rdData, debugger)
        rmac.append(rdData[0])
        if ((len(rmac) == len(mac)) and (rmac[0] == 0) and (rmac[1] == 0)):
            BCM89571_OTP_Write(294, mac[0], debugger)              # MAC address
            BCM89571_OTP_Write(295, mac[1], debugger)              # MAC Address
        elif ((len(rmac) == len(mac)) and (rmac[0] == mac[0]) and (rmac[1] == mac[1])):
            print("Given MAC already present")
        else:
            print("MAC already present: " + hex((mac[0] << 24) + mac[1]))
            sys.exit(1)

    if (len(pkey1) == 64):
        rdData = []
        OTP_ReadTarget(OTP_HW_ID_0, 96, rdData, debugger)
        if rdData[0] == 0:
            BCM89571_OTP_Write(96, 0x1, debugger)              # Secure Boot Enable

        # Read current public key region
        currKey = []
        for index in range(97, 161):
            rdData = []
            OTP_ReadTarget(OTP_HW_ID_0, index, rdData, debugger)
            currKey.append(rdData[0])
        # Write only if public key region is empty
        i = 1
        if len(list(set(currKey))) == 1 and list(set(currKey))[0] == 0:
            for each in pkey1:
                BCM89571_OTP_Write(96 + i, each, debugger)     # RSA Public key 0
                i = i + 1
        else:
            print("\nPublic Key is already present: \n{}".format(currKey))

    BCM89571_OTP_Write(12, 0xA0, debugger)                     # WatchDog Disable

    debugger.close()



if __name__ == '__main__':
    BCM89571_OTP_Main()
