#!/usr/bin/python3

# $Id$
# $Copyright: Copyright 2020 Broadcom Limited.
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

import random
from Crypto.Hash import SHA256
from Crypto.Hash import SHA384
from Crypto.PublicKey import RSA
from Crypto.PublicKey import ECC
from Crypto.Signature import DSS
from Crypto.Signature import PKCS1_PSS

copyrightHeader = '''/*****************************************************************************
 Copyright 2021 Broadcom Limited.  All rights reserved.

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
******************************************************************************/

'''

outputFile = '../qualification/g_test_data.h'
rsaPrivKeyFile = '../../../../build/keys/private_key.dat'
eccPrivKeyFile = '../../../../build/keys/ecc_secp384r1_private_key.dat'

class HeaderWriter:
    def __init__(self, outputFile):
        self.fhdl = open(outputFile, 'wt')
        self.fhdl.write(copyrightHeader)

    def writeByteArray(self, arrayName, byteArray):
        self.fhdl.write('uint8_t {}[{}UL] = {{\n'.format(arrayName, len(byteArray)))
        for iterInner in zip(*[iter(byteArray)]*16):
            self.fhdl.write('    ')
            for elt in iterInner:
                self.fhdl.write('0x{:02x},'.format(elt))
            self.fhdl.write('\n')
        self.fhdl.write('};\n\n')


    def close(self):
        self.fhdl.close()

class MsgSignHelper:
    def __init__(self, privkey, hashType, keyType, signerType, *args):
        self.hash = hashType.new()
        self.hashType = hashType
        self.signature = None
        self.key = keyType.import_key(privkey)
        self.signer = signerType.new(self.key, *args)

    def reset(self):
        self.hash = self.hashType.new()

    def hashUpdate(self, string):
        self.hash.update(string)

    def getSignature(self):
        self.signature = self.signer.sign(self.hash)
        return self.signature

    def verify(self):
        self.signer.verify(self.hash, self.signature)

msgLen = 512
msg1 = bytearray((random.getrandbits(8) for i in range(0, msgLen)))
msg2 = bytearray((random.getrandbits(8) for i in range(0, msgLen)))

rsaMsgSignHelper = MsgSignHelper(open(rsaPrivKeyFile,'rb').read(), SHA256, RSA, PKCS1_PSS)
ecdsaMsgSignHelper = MsgSignHelper(open(eccPrivKeyFile, 'rb').read(), SHA384, ECC, DSS, 'fips-186-3')

# RSA signatures
rsaMsgSignHelper.reset()
rsaMsgSignHelper.hashUpdate(msg1)
rsaSignature1 = rsaMsgSignHelper.getSignature()
rsaMsgSignHelper.verify()

rsaMsgSignHelper.reset()
rsaMsgSignHelper.hashUpdate(msg2)
rsaSignature2 = rsaMsgSignHelper.getSignature()
rsaMsgSignHelper.verify()

# ECDSA signatures
ecdsaMsgSignHelper.reset()
ecdsaMsgSignHelper.hashUpdate(msg1)
ecdsaSignature1 = ecdsaMsgSignHelper.getSignature()
ecdsaMsgSignHelper.verify()

ecdsaMsgSignHelper.reset()
ecdsaMsgSignHelper.hashUpdate(msg2)
ecdsaSignature2 = ecdsaMsgSignHelper.getSignature()
ecdsaMsgSignHelper.verify()

# Write outputs
outputFileWriter = HeaderWriter(outputFile)

outputFileWriter.writeByteArray('CRYPTOTEST_Msg1', msg1)
outputFileWriter.writeByteArray('CRYPTOTEST_Msg2', msg2)
outputFileWriter.writeByteArray('CRYPTOTEST_RSA2KSignature1', rsaSignature1)
outputFileWriter.writeByteArray('CRYPTOTEST_RSA2KSignature2', rsaSignature2)
outputFileWriter.writeByteArray('CRYPTOTEST_ECDSA384Signature1', ecdsaSignature1)
outputFileWriter.writeByteArray('CRYPTOTEST_ECDSA384Signature2', ecdsaSignature2)

outputFileWriter.close()

