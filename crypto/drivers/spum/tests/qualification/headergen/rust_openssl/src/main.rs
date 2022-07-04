/*****************************************************************************
 Copyright 2019-2021 Broadcom Limited.  All rights reserved.

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
const FILE_HEADER: &str = "/*****************************************************************************
 Copyright 2019-2021 Broadcom Limited.  All rights reserved.

 This program is the proprietary software of Broadcom Limited and/or its
 licensors, and may only be used, duplicated, modified or distributed pursuant
 to the terms and conditions of a separate, written license agreement executed
 between you and Broadcom (an \"Authorized License\").

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

 2. TO THE MAXIMUM EXTENT PERMITTED BY LAW, THE SOFTWARE IS PROVIDED \"AS IS\"
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
";

use std::fs::File;
use std::io::Write;

use openssl::sha;
use openssl::symm;
use openssl::pkey::PKey;
use openssl::sign::Signer;
use openssl::rand::rand_bytes;
use openssl::hash::MessageDigest;

fn write_array(name: &str, data: &[u8], fhdl: &mut File) {
    fhdl.write_all(format!("static const uint8_t SPUM_{}[] = {{\n", name).as_bytes()).unwrap();

    let mut write_newline_end = false;
    for (idx, byte) in data.iter().enumerate() {

        fhdl.write_all(format!(" 0x{:02x},", byte).as_bytes()).unwrap();

        if ((idx + 1) % 16) == 0 {
            fhdl.write_all(b"\n").unwrap();
            write_newline_end = false;
        } else {
            write_newline_end = true;
        }

    }

    if write_newline_end {
        fhdl.write_all(b"\n").unwrap();
    }

    fhdl.write_all(b"};\n").unwrap();
    fhdl.write_all(format!("static const uint32_t SPUM_{}_NUM_BYTES = {}UL;\n\n",
        name, data.len()).as_bytes()).unwrap();

    return;
}

fn main() {
    let some_rand_size = 3436;
    let mut iv : Vec<u8> = vec![0; 16];
    let mut msg: Vec<u8> = vec![0; 4096];
    let mut key128: Vec<u8> = vec![0; 16];
    let mut key192: Vec<u8> = vec![0; 24];
    let mut key256: Vec<u8> = vec![0; 32];
    let mut key_hmac_bits: Vec<u8> = vec![0; 32];

    rand_bytes(&mut iv).unwrap();
    rand_bytes(&mut msg).unwrap();
    rand_bytes(&mut key128).unwrap();
    rand_bytes(&mut key192).unwrap();
    rand_bytes(&mut key256).unwrap();
    rand_bytes(&mut key_hmac_bits).unwrap();

    let cipher = symm::Cipher::aes_128_cbc();
    let ciphertext_128_cbc = symm::encrypt(
        cipher, &key128, Some(&iv), &msg).unwrap();

    let cipher = symm::Cipher::aes_128_ctr();
    let ciphertext_128_ctr = symm::encrypt(
        cipher, &key128, Some(&iv), &msg).unwrap();

    let cipher = symm::Cipher::aes_192_cbc();
    let ciphertext_192_cbc = symm::encrypt(
        cipher, &key192, Some(&iv), &msg).unwrap();

    let cipher = symm::Cipher::aes_192_ctr();
    let ciphertext_192_ctr = symm::encrypt(
        cipher, &key192, Some(&iv), &msg).unwrap();

    let cipher = symm::Cipher::aes_256_cbc();
    let ciphertext_256_cbc = symm::encrypt(
        cipher, &key256, Some(&iv), &msg).unwrap();

    let cipher = symm::Cipher::aes_256_ctr();
    let ciphertext_256_ctr = symm::encrypt(
        cipher, &key256, Some(&iv), &msg).unwrap();

    let mut fhdl = File::create("../../g_spum_qt_test_data_openssl.h").unwrap();
    fhdl.write_all(FILE_HEADER.as_bytes()).unwrap();
    fhdl.write_all(b"#ifndef G_SPUM_QT_TEST_DATA_H\n").unwrap();
    fhdl.write_all(b"#define G_SPUM_QT_TEST_DATA_H\n").unwrap();
    fhdl.write_all(b"\n").unwrap();

    fhdl.write_all(&(format!("const uint32_t SPUM_SOME_RANDOM_SIZE = {}UL;\n\n", &some_rand_size).into_bytes())).unwrap();

    write_array("AES_IV", &iv, &mut fhdl);
    write_array("AES_KEY_128", &key128, &mut fhdl);
    write_array("AES_KEY_192", &key192, &mut fhdl);
    write_array("AES_KEY_256", &key256, &mut fhdl);
    write_array("HMAC_KEY_256", &key_hmac_bits, &mut fhdl);
    write_array("PLAIN_TEXT", &msg, &mut fhdl);
    write_array("CIPHER_TEXT_AES_128_CBC", &ciphertext_128_cbc, &mut fhdl);
    write_array("CIPHER_TEXT_AES_128_CTR", &ciphertext_128_ctr, &mut fhdl);
    write_array("CIPHER_TEXT_AES_192_CBC", &ciphertext_192_cbc, &mut fhdl);
    write_array("CIPHER_TEXT_AES_192_CTR", &ciphertext_192_ctr, &mut fhdl);
    write_array("CIPHER_TEXT_AES_256_CBC", &ciphertext_256_cbc, &mut fhdl);
    write_array("CIPHER_TEXT_AES_256_CTR", &ciphertext_256_ctr, &mut fhdl);

    let hash256_pt_512 = sha::sha256(&msg[0..512]);
    let hash256_pt_3436 = sha::sha256(&msg[0..3436]);
    let hash256_pt_4096 = sha::sha256(&msg[0..4096]);

    let key_hmac = PKey::hmac(&key_hmac_bits).unwrap();

    let hmac_pt_512 = Signer::new(MessageDigest::sha256(), &key_hmac).unwrap()
        .sign_oneshot_to_vec(&msg[0..512]).unwrap();

    let hmac_pt_3436 =  Signer::new(MessageDigest::sha256(), &key_hmac).unwrap()
        .sign_oneshot_to_vec(&msg[0..3436]).unwrap();

    let hmac_pt_4096 =  Signer::new(MessageDigest::sha256(), &key_hmac).unwrap()
        .sign_oneshot_to_vec(&msg[0..4096]).unwrap();

    write_array("HASH_SHA256_PLAIN_TEXT_512_BYTES", &hash256_pt_512, &mut fhdl);
    write_array("HASH_SHA256_PLAIN_TEXT_3436_BYTES", &hash256_pt_3436, &mut fhdl);
    write_array("HASH_SHA256_PLAIN_TEXT_4096_BYTES", &hash256_pt_4096, &mut fhdl);

    write_array("HMAC_SHA256_PLAIN_TEXT_512_BYTES", &hmac_pt_512, &mut fhdl);
    write_array("HMAC_SHA256_PLAIN_TEXT_3436_BYTES", &hmac_pt_3436, &mut fhdl);
    write_array("HMAC_SHA256_PLAIN_TEXT_4096_BYTES", &hmac_pt_4096, &mut fhdl);

    fhdl.write_all(b"#endif\n").unwrap();

    return;
}

