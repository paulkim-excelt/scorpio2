#!/usr/bin/python2

#
# $Id$
# $Copyright: Copyright 2018 Broadcom Limited.
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
#

import binascii
from Crypto import Random
from Crypto.Cipher import AES
from Crypto.Hash import SHA256
from Crypto.Util import Counter
from Crypto.Util.number import bytes_to_long

c_copyright_header = \
"""/*****************************************************************************
 Copyright 2019 Broadcom Limited.  All rights reserved.

 This program is the proprietary software of Broadcom Limited and/or its
 licensors, and may only be used, duplicated, modified or distributed pursuant
 to the terms and conditions of a separate, written license agreement executed
 between you and Broadcom (an "Authorized License").

 Except as set forth in an Authorized License, Broadcom grants no license
 (express or implied), right to use, or waiver of any kind with respect to the
 Software, and Broadcom expressly reserves all rights in and to the Software
 and all intellectual property rights therein.  IF YOU HAVE NO AUTHORIZED
 LICENSE, THEN YOU HAVE NO RIGHT TO USE THIS SOFTWARE IN ANY WAY, AND SHOULD
 IMMEDIATELY NOTIFY BROADCOM AND DISCONTINUE ALL USE OF THE SOFTWARE.

  Except as expressly set forth in the Authorized License,
 1. This program, including its structure, sequence and organization,
    constitutes the valuable trade secrets of Broadcom, and you shall use all
    reasonable efforts to protect the confidentiality thereof, and to use this
    information only in connection with your use of Broadcom integrated
    circuit products.

 2. TO THE MAXIMUM EXTENT PERMITTED BY LAW, THE SOFTWARE IS PROVIDED "AS IS"
    AND WITH ALL FAULTS AND BROADCOM MAKES NO PROMISES, REPRESENTATIONS OR
    WARRANTIES, EITHER EXPRESS, IMPLIED, STATUTORY, OR OTHERWISE, WITH RESPECT
    TO THE SOFTWARE.  BROADCOM SPECIFICALLY DISCLAIMS ANY AND ALL IMPLIED
    WARRANTIES OF TITLE, MERCHANTABILITY, NONINFRINGEMENT, FITNESS FOR A
    PARTICULAR PURPOSE, LACK OF VIRUSES, ACCURACY OR COMPLETENESS,
    QUIET ENJOYMENT, QUIET POSSESSION OR CORRESPONDENCE TO DESCRIPTION.
    YOU ASSUME THE ENTIRE RISK ARISING OUT OF USE OR PERFORMANCE OF THE
    SOFTWARE.

 3. TO THE MAXIMUM EXTENT PERMITTED BY LAW, IN NO EVENT SHALL BROADCOM OR ITS
    LICENSORS BE LIABLE FOR (i) CONSEQUENTIAL, INCIDENTAL, SPECIAL, INDIRECT,
    OR EXEMPLARY DAMAGES WHATSOEVER ARISING OUT OF OR IN ANY WAY RELATING TO
    YOUR USE OF OR INABILITY TO USE THE SOFTWARE EVEN IF BROADCOM HAS BEEN
    ADVISED OF THE POSSIBILITY OF SUCH DAMAGES; OR (ii) ANY AMOUNT IN EXCESS
    OF THE AMOUNT ACTUALLY PAID FOR THE SOFTWARE ITSELF OR U.S. $1, WHICHEVER
    IS GREATER. THESE LIMITATIONS SHALL APPLY NOTWITHSTANDING ANY FAILURE OF
    ESSENTIAL PURPOSE OF ANY LIMITED REMEDY.

*****************************************************************************/
"""

def write_array(name, array, fhdl):
    write_newline_end = False
    fhdl.write("static const uint8_t SPUM_" + name + "[] = {\n")

    for idx, elt in enumerate(array):
        fhdl.write(" " + '0x{:02X}'.format(int(binascii.hexlify(elt), 16)) + ",")
        if (idx + 1) % 16 == 0:
            fhdl.write("\n")
            write_newline_end = False
        else:
            write_newline_end = True

    if write_newline_end:
        fhdl.write("\n")

    fhdl.write("};\n")
    fhdl.write('static const uint32_t SPUM_{}_NUM_BYTES = {}UL;\n\n'.format(name, len(array)))


def main():

    some_random_size = 3436

    # Initial random data
    iv = Random.new().read(AES.block_size)
    msg = Random.new().read(4096)
    key128 = Random.new().read(16)
    key192 = Random.new().read(24)
    key256 = Random.new().read(32)

    # Create ciphers
    cipher_128cbc = AES.new(key128, AES.MODE_CBC, iv)
    cipher_192cbc = AES.new(key192, AES.MODE_CBC, iv)
    cipher_256cbc = AES.new(key256, AES.MODE_CBC, iv)

    cipher_128ctr = AES.new(key128, AES.MODE_CTR, counter=Counter.new(128, initial_value=bytes_to_long(iv)))
    cipher_192ctr = AES.new(key192, AES.MODE_CTR, counter=Counter.new(128, initial_value=bytes_to_long(iv)))
    cipher_256ctr = AES.new(key256, AES.MODE_CTR, counter=Counter.new(128, initial_value=bytes_to_long(iv)))

    # Encrypt
    cipher_text_128cbc = cipher_128cbc.encrypt(msg)
    cipher_text_192cbc = cipher_192cbc.encrypt(msg)
    cipher_text_256cbc = cipher_256cbc.encrypt(msg)

    cipher_text_128ctr = cipher_128ctr.encrypt(msg)
    cipher_text_192ctr = cipher_192ctr.encrypt(msg)
    cipher_text_256ctr = cipher_256ctr.encrypt(msg)

    # Compute hashes
    sha256_pt_512bytes = SHA256.new(data=msg[:512]).digest()
    sha256_pt_3436bytes = SHA256.new(data=msg[:some_random_size]).digest()
    sha256_pt_4096bytes = SHA256.new(data=msg[:4096]).digest()

    # Serialize
    with open("../../g_spum_qt_test_data_pycrypto.h", "w") as header_hdl:
        header_hdl.write(c_copyright_header)
        header_hdl.write("#ifndef G_SPUM_QT_TEST_DATA_H\n")
        header_hdl.write("#define G_SPUM_QT_TEST_DATA_H\n")
        header_hdl.write("\n")

        header_hdl.write("const uint32_t SPUM_SOME_RANDOM_SIZE = {}UL;\n\n".format(some_random_size))

        call_write_array = lambda a, b : write_array(a, b, header_hdl)

        call_write_array("AES_IV", iv)
        call_write_array("AES_KEY_128", key128)
        call_write_array("AES_KEY_192", key192)
        call_write_array("AES_KEY_256", key256)
        call_write_array("PLAIN_TEXT", msg)
        call_write_array("CIPHER_TEXT_AES_128_CBC", cipher_text_128cbc)
        call_write_array("CIPHER_TEXT_AES_128_CTR", cipher_text_128ctr)
        call_write_array("CIPHER_TEXT_AES_192_CBC", cipher_text_192cbc)
        call_write_array("CIPHER_TEXT_AES_192_CTR", cipher_text_192ctr)
        call_write_array("CIPHER_TEXT_AES_256_CBC", cipher_text_256cbc)
        call_write_array("CIPHER_TEXT_AES_256_CTR", cipher_text_256ctr)

        call_write_array("HASH_SHA256_PLAIN_TEXT_512_BYTES", sha256_pt_512bytes)
        call_write_array("HASH_SHA256_PLAIN_TEXT_3436_BYTES", sha256_pt_3436bytes)
        call_write_array("HASH_SHA256_PLAIN_TEXT_4096_BYTES", sha256_pt_4096bytes)

        header_hdl.write("#endif\n")

if __name__ == "__main__":
    main()
