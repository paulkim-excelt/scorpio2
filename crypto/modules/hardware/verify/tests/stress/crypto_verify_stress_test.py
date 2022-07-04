# Copyright: Copyright 2021 Broadcom Limited.
#
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

import os
import time
import argparse
import logging
import random
from datetime import datetime
from Crypto.Hash import SHA256
from Crypto.Hash import SHA384
from Crypto.PublicKey import RSA
from Crypto.PublicKey import ECC
from Crypto.Signature import DSS
from Crypto.Signature import PKCS1_PSS

import arcdbg

class CRYPTOTEST_TestCase:
    def __init__(self, msg, pubkey, signature, test_name, corrupt_key, corrupt_msg, corrupt_sig):
        self.name = test_name
        self.pubkey = pubkey
        self.signature = signature
        self.isneg = corrupt_key or corrupt_msg or corrupt_sig

        # Corrupt message if needed
        if corrupt_msg:
            msg_len = len(msg)
            msg_corr_len = random.randint(1, 32)
            msg_corr_offset = random.randint(0, msg_len - msg_corr_len)
            msg_corr = bytearray(msg_len)
            msg_corr[:] = msg
            while msg_corr == msg:
                corr = bytearray((random.getrandbits(8) for i in range(0, msg_corr_len)))
                msg_corr[msg_corr_offset:(msg_corr_offset + msg_corr_len)] = corr

            self.msg = msg_corr
        else:
            self.msg = msg

        # Corrupt message if needed
        if corrupt_sig:
            sig_len = len(signature)
            sig_corr_len = random.randint(1, 16)
            sig_corr_offset = random.randint(0, 96 - sig_corr_len)

            signature_corr = bytearray(sig_len)
            signature_corr[:] = signature
            while signature_corr == signature:
                corr = bytearray((random.getrandbits(8) for i in range(0, sig_corr_len)))
                signature_corr[sig_corr_offset:(sig_corr_offset + sig_corr_len)] = corr

            self.signature = signature_corr
        else:
            self.signature = signature

        self.pubkeyimg = self.gen_pubkey_img(corrupt_key)
        self.testparamsimg = self.gen_testparams_img()

    def gen_pubkey_img(self, corrupt_key):
        # The corresponding C struct is defined as follows:
        #
        # typedef struct sCRYPTO_PublicKeyContainerType {
        #     uint32_t keyLenWords;               /**< @brief Public key length in words  */
        #     CRYPTO_AlgoType keyAlgo;            /**< @brief Key algorithm               */
        #     CRYPTO_AlgoType keyPaddingAlgo;     /**< @brief Padding algorithm           */
        #     uint32_t pubKey[256UL / 4UL];       /**< @brief Public key                  */
        # } CRYPTO_PublicKeyContainerType;
        #
        key_len_bytes = int(self.key_len_words).to_bytes(4, byteorder='little')
        key_algo_bytes = int(self.key_algo).to_bytes(4, byteorder='little')
        key_padding_algo_bytes = int(self.key_padding_algo).to_bytes(4, byteorder='little')

        byte_array = key_len_bytes +    \
            key_algo_bytes +            \
            key_padding_algo_bytes +    \
            self.get_pubkey_bytes(256, corrupt_key)

        return byte_array

    def gen_testparams_img(self):
        # The corresponding C struct is defined as follows:
        #
        # typedef struct sCRYPTOTEST_ParamsType {
        #     CRYPTO_AlgoType keyAlgo;
        #     uint32_t msgSize;
        #     uint32_t msg[512UL / 4UL];
        #     uint32_t sig[256UL / 4UL];
        #     int32_t expectedResult;
        # } CRYPTOTEST_ParamsType;
        #
        byte_array = int(self.key_algo).to_bytes(4, byteorder='little')
        byte_array += int(len(self.msg)).to_bytes(4, byteorder='little')

        byte_array += self.msg
        byte_array += int(0).to_bytes(512 - len(self.msg), byteorder='little')

        byte_array += self.signature
        byte_array += int(0).to_bytes(256 - len(self.signature), byteorder='little')

        if self.isneg:
            # Expect AUTH_FAILED (0xF)
            byte_array += int(0xF).to_bytes(4, byteorder='little')
        else:
            # Expect BCM_ERR_OK (0)
            byte_array += int(0).to_bytes(4, byteorder='little')

        return byte_array

    def dump(self, test_id, source_fail_line):

        outdirparent = 'debug_dir'
        outdir = os.path.join(outdirparent, str(test_id))

        for path in [outdirparent, outdir]:
            if not os.path.isdir(path):
                os.makedirs(path, 0o775)

        with open(os.path.join(outdir, 'test_info.txt'), 'w') as fhdl:
            fhdl.write('Test name: ' + self.name + '\n')
            fhdl.write('Source fail line number: ' + str(source_fail_line) + '\n')

        with open(os.path.join(outdir, 'pubkey.img'), 'wb') as fhdl:
            fhdl.write(self.pubkeyimg)

        with open(os.path.join(outdir, 'testparams.img'), 'wb') as fhdl:
            fhdl.write(self.testparamsimg)

        with open(os.path.join(outdir, 'msg.dat'), 'wb') as fhdl:
            fhdl.write(self.msg)

        with open(os.path.join(outdir, 'signature.dat'), 'wb') as fhdl:
            fhdl.write(self.signature)

        with open(os.path.join(outdir, 'signingkey.dat'), 'wb') as fhdl:
            fhdl.write(self.pubkey.export_key(format='DER'))

class CRYPTOTEST_RsaTestCase(CRYPTOTEST_TestCase):
    def __init__(self, msg, pubkey, signature, name, corrupt_key = False, corrupt_msg = False, corrupt_sig = False):
        self.key_len_words = int(64)
        self.key_algo = int(0x52531010)
        self.key_padding_algo = int(0x504B2100)
        super().__init__(msg, pubkey, signature, name, corrupt_key, corrupt_msg, corrupt_sig)

    def get_pubkey_bytes(self, len_with_pad, corrupt_key):
        if len_with_pad < 256:
            raise ValueError(f'The bytearray to hold an RSA pubkey should atleast be 256 bytes long')

        pubkey_bytes = self.pubkey.n.to_bytes(256, byteorder='little')
        if corrupt_key:
            rand_shift = random.randint(0, 128)
            corrupt_xor_mask = 0xffffffff << rand_shift
            corrupt_n = self.pubkey.n ^ corrupt_xor_mask
            pubkey_bytes = corrupt_n.to_bytes(256, byteorder='little')

        zeropad = bytearray(len_with_pad - 256)
        return pubkey_bytes + zeropad


class CRYPTOTEST_EcdsaTestCase(CRYPTOTEST_TestCase):
    def __init__(self, msg, pubkey, signature, name, corrupt_key = False, corrupt_msg = False, corrupt_sig = False):
        self.key_len_words = int(24)
        self.key_algo = int(0x45431003)
        self.key_padding_algo = int(0)
        super().__init__(msg, pubkey, signature, name, corrupt_key, corrupt_msg, corrupt_sig)

    def get_pubkey_bytes(self, len_with_pad, corrupt_key):
        if len_with_pad < 96:
            raise ValueError(f'The bytearray to hold an ECC secp384R1 pubkey should atleast be 96 bytes long')

        pointX = (int(self.pubkey.pointQ.x)).to_bytes(48, byteorder='little')
        pointY = (int(self.pubkey.pointQ.y)).to_bytes(48, byteorder='little')

        if corrupt_key:
            exec_corr_loop = True

            while exec_corr_loop:
                rand_shift = random.randint(0, 128)
                corrupt_mask = 0xffffffff << rand_shift

                if (rand_shift % 2) == 0:
                    corrupt_x = self.pubkey.pointQ.x | corrupt_mask
                    exec_corr_loop = (corrupt_x == self.pubkey.pointQ.x)
                    pointX = (int(corrupt_x)).to_bytes(48, byteorder='little')
                else:
                    corrupt_y = self.pubkey.pointQ.y | corrupt_mask
                    exec_corr_loop = (corrupt_y == self.pubkey.pointQ.y)
                    pointY = (int(corrupt_y)).to_bytes(48, byteorder='little')

        zeropad = bytearray(len_with_pad - 96)
        return pointY + pointX + zeropad

class CRYPTOTEST_TestCaseGenerator:
    def __init__(self, niter):
        self.count = niter
        self.count_orig = niter

    def update_keys(self):
        self.rsa_key = RSA.generate(2048)
        self.ecc_key = ECC.generate(curve='secp384r1')

        self.rsa_signer = PKCS1_PSS.new(self.rsa_key)
        self.ecdsa_signer = DSS.new(self.ecc_key, 'fips-186-3')

    def test_case_generator(self):
        while self.count > 0:
            # Update the keys after every 32 iterations
            niter_done = self.count_orig - self.count

            if (niter_done % 32) == 0:
                self.update_keys()

            if (0 != niter_done) and ((niter_done % 32) == 0):
                logging.info(f'Completed iterations: {niter_done}')

            # Generate a random message buffer
            msg_len = 128 * random.randint(1, 4)
            msg = bytearray((random.getrandbits(8) for i in range(0, msg_len)))

            # Sign the message with RSA and ECDSA keys
            msg_sha256 = SHA256.new()
            msg_sha384 = SHA384.new()

            msg_sha256.update(msg)
            msg_sha384.update(msg)

            rsa_signature = self.rsa_signer.sign(msg_sha256)
            ecdsa_signature = self.ecdsa_signer.sign(msg_sha384)

            # RSA positive test case
            yield CRYPTOTEST_RsaTestCase(msg, self.rsa_key, rsa_signature, 'rsa2k_pos_test')

            # ECDSA positive test case
            yield CRYPTOTEST_EcdsaTestCase(msg, self.ecc_key, ecdsa_signature, 'ecdsa_pos_test')

            # RSA corrupted message negative test case
            yield CRYPTOTEST_RsaTestCase(msg, self.rsa_key, rsa_signature, 'rsa2k_bad_message_test', corrupt_msg = True)

            # ECDSA corrupted message negative test case
            yield CRYPTOTEST_EcdsaTestCase(msg, self.ecc_key, ecdsa_signature, 'ecdsa_bad_message_test', corrupt_msg = True)

            # RSA corrupted signature negative test case
            yield CRYPTOTEST_RsaTestCase(msg, self.rsa_key, rsa_signature, 'rsa2k_bad_signature', corrupt_sig = True)

            # ECDSA corrupted signature negative test case
            yield CRYPTOTEST_EcdsaTestCase(msg, self.ecc_key, ecdsa_signature, 'ecdsa_bad_signature', corrupt_sig = True)

            # Try verification using a bad RSA key
            yield CRYPTOTEST_RsaTestCase(msg, self.rsa_key, rsa_signature, 'rsa2k_bad_key', corrupt_key = True)

            # Try verification using a bad ECDSA key
            yield CRYPTOTEST_EcdsaTestCase(msg, self.ecc_key, ecdsa_signature, 'ecdsa_bad_key', corrupt_key = True)

            self.count -= 1

    def __iter__(self):
        return self.test_case_generator()

def CRYPTOTEST_ArgparseValidateReadableFilePath(fs_path):
    if os.access(fs_path, os.F_OK | os.R_OK):
        return fs_path
    raise FileNotFoundError(fs_path)

def CRYPTOTEST_ProcessCmdLineArgs():
    # Construct the parser object
    parser = argparse.ArgumentParser(
        allow_abbrev=False,
        formatter_class=argparse.RawTextHelpFormatter,
    )

    parser.add_argument('elf',
        type=CRYPTOTEST_ArgparseValidateReadableFilePath,
        help='Path to the elf file to work with'
    )

    parser.add_argument('niter',
        type=int,
        help="Number of iterations to run the test for"
    )

    # Parse the cmdline args and return
    return parser.parse_args()

def CRYPTOTEST_Main():
    # Setup logger
    logging.basicConfig(format='%(asctime)s %(levelname)s: %(message)s', level=logging.INFO)

    # Parse command line arguments
    parsed_args = CRYPTOTEST_ProcessCmdLineArgs()

    # Open a debug session
    dbg_session = arcdbg.new(parsed_args.elf)

    # Get addresses from the ELF
    pubkey_addr = dbg_session.get_address_of('CRYPTO_VerifyHWModMVK')
    params_addr = dbg_session.get_address_of('CRYPTOTEST_Params')
    ready_addr  = dbg_session.get_address_of('CRYPTOTEST_ParamsAvailable')
    failline_addr = dbg_session.get_address_of('CRYPTOTEST_FailLine')
    result_addr = dbg_session.get_address_of('CRYPTOTEST_Result')
    execstatus_addr = dbg_session.get_address_of('CRYPTOTEST_ExecStatus')

    # Start the program execution
    dbg_session.run()
    time.sleep(2)

    logging.info(f'Starting the test loop...')

    # Run the test for the given number of iterations
    num_failed_test_cases = 0
    for test_case in CRYPTOTEST_TestCaseGenerator(parsed_args.niter):
        # logging.info(f'Msglen: {len(test_case.msg)}, Offsets: {test_case.offsets}, Sizes: {test_case.sizes}')

        # Upload public key and test params
        dbg_session.write_mem(pubkey_addr, test_case.pubkeyimg)
        dbg_session.write_mem(params_addr, test_case.testparamsimg)

        # Signal the target that the data has been uploaded
        dbg_session.write_mem(ready_addr, int(1).to_bytes(4, byteorder='little'))

        # Poll until the completion is signalled
        time.sleep(0.1)
        status = dbg_session.read_int(execstatus_addr)
        while status != 0xfffffffe:
            time.sleep(0.1)
            status = dbg_session.read_int(execstatus_addr)

        result = dbg_session.read_int(result_addr)
        if result != 0x0:
            num_failed_test_cases += 1
            fail_line = dbg_session.read_int(failline_addr)
            test_case.dump(num_failed_test_cases, fail_line)
            logging.warning(f'Test case failure detected. Dumped with ID {num_failed_test_cases}')

    logging.info(f'Test finished running for {parsed_args.niter} iterations. Tearing down.')

if __name__ == "__main__":
    CRYPTOTEST_Main()

