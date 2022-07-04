/*****************************************************************************
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
#ifndef PKAQT_TARGETED_TEST_DATA_H
#define PKAQT_TARGETED_TEST_DATA_H

const PkaTestCaseType PKA_TARGETED_TESTCASES[] = {
#if defined(PKA_FEATURE_FLAG_RSA_OPS) && defined(PKA_FEATURE_FLAG_RSA_MOD_2K)
    {
        .tag = PKA_TEST_CASE_RSA_VERIFY,
        .testName = "PKA_TARGETED_TEST_RSAVERIFY_WD_TRIGGER_2048_SHA256_PSS",
        .expectedRet = BCM_ERR_AUTH_FAILED,
        .rsaVerify.sigScheme = PKA_RSA_SIGNATURE_SCHEME_PSS,
        .rsaVerify.msgDigestAlg = PKA_MSGDIGESTALG_SHA256,
        .rsaVerify.msgHash = {
            .numLimbs = 8UL,
            .limbs = (const uint32_t[]) {
                0x4395DA0AUL, 0xA6066C02UL, 0x512A3686UL, 0xCE93C081UL,
                0x025295D9UL, 0xACD2871BUL, 0xD79848ABUL, 0x2AB6E443UL,
            }
        },
        .rsaVerify.rsaModulus = {
            .numLimbs = 64UL,
            .limbs = (const uint32_t[]) {
                0xE3D35DB7UL, 0xA32CC9ECUL, 0xB3D805ADUL, 0xCFCF379EUL,
                0xBBEBCB03UL, 0x6018C552UL, 0xE31148CDUL, 0x99E7D8ECUL,
                0x2311C8FDUL, 0x53AC5E28UL, 0xF2F9B5CEUL, 0xC2A63F49UL,
                0xDA38E605UL, 0x5B06020DUL, 0xA28157B2UL, 0xFE8D6022UL,
                0x37DB26ADUL, 0x7DDC7BA8UL, 0x4ADF0332UL, 0xC8FBF7C5UL,
                0xA5519909UL, 0xD688900FUL, 0xC5D8F8A3UL, 0x1078DEF7UL,
                0xF59127B2UL, 0xFE9BCCF8UL, 0xCC682F9AUL, 0x12A23B79UL,
                0x391D05D0UL, 0x1B2F1A60UL, 0x9A08FF62UL, 0x31BDBC10UL,
                0x5D0584FCUL, 0xE3197809UL, 0x807D6319UL, 0xD7898C3EUL,
                0xE2C293E9UL, 0x71637963UL, 0x9774757BUL, 0xDF3F0CC0UL,
                0x39355738UL, 0x11E0EB67UL, 0x2EA72E55UL, 0xD2D48A5CUL,
                0x35216115UL, 0x523B6DA2UL, 0xBCD8E1B6UL, 0x4E43D864UL,
                0x13BA7926UL, 0x5E0E017BUL, 0x6553FDEDUL, 0xCB831C67UL,
                0xCDFA5796UL, 0x96BC9D8FUL, 0x0E4C76C9UL, 0x0D46BFEFUL,
                0xD41A95A0UL, 0x3AE34EA5UL, 0xD8DC1DE6UL, 0x30DBB364UL,
                0x5A6B7FDDUL, 0x21ABEC04UL, 0x75C7815DUL, 0x7EFCAADEUL,
            }
        },
        .rsaVerify.rsaExponent = {
            .numLimbs = 1UL,
            .limbs = (const uint32_t[]) {
                65537UL,
            }
        },
        .rsaVerify.signature = {
            .numLimbs = 64UL,
            .limbs = (const uint32_t[]) {
                0xE0A53543UL, 0x349D4B5AUL, 0xBAF10A3DUL, 0x2646167AUL,
                0x0701B2DBUL, 0x7D5302AEUL, 0x47DA03E0UL, 0x518A1701UL,
                0xC605D20AUL, 0x6D50D07CUL, 0xAF3B8ACCUL, 0xF240EE99UL,
                0x8E6C8F55UL, 0x533DEFBBUL, 0x9B8BF314UL, 0x5363CF37UL,
                0x245133FFUL, 0x71445818UL, 0x7A6E1892UL, 0xCA8C9E20UL,
                0x057FE8A5UL, 0x4FDAE2FAUL, 0x5B773ACEUL, 0x990E9D1EUL,
                0xBD409483UL, 0xCBF5123CUL, 0x0FBBDB91UL, 0xE17C693AUL,
                0xC6DCE872UL, 0x6F34889AUL, 0xB42C1878UL, 0xD4539A0DUL,
                0x0D981F48UL, 0xE452D2D8UL, 0xAB7ADC7FUL, 0xD549A98EUL,
                0x148422FFUL, 0x237DE7EDUL, 0xCF5C3549UL, 0x3B10D9E3UL,
                0xBEEB87BEUL, 0xC80A087FUL, 0x7E97AFFFUL, 0x05B4F50DUL,
                0xFF7B6C4EUL, 0x5D8F39D5UL, 0x67B1084EUL, 0x8F691EACUL,
                0xBE9902EFUL, 0x53229E97UL, 0x47F086A0UL, 0x71F73EC4UL,
                0x09D255E9UL, 0xD9C79882UL, 0xDB7475D2UL, 0x2E154559UL,
                0x919D0163UL, 0xE972D921UL, 0x42723C7EUL, 0xB61C59EEUL,
                0x6DA8D19DUL, 0xBF9D12CAUL, 0xFE24C7B2UL, 0x9F1ADD88UL,
            }
        },
    },
#endif
#if defined(PKA_FEATURE_FLAG_ECDSA_VERIFY) && defined(PKA_FEATURE_FLAG_EC_SECP_384R1)
    {
        .tag = PKA_TEST_CASE_ECDSA_VERIFY,
        .testName = "PKA_PROF_TEST_ECDSAVERIFY_BAD_PUBKEY_SECP384R1_SHA384",
        .expectedRet = BCM_ERR_AUTH_FAILED,
        .ecdsaVerify.ecGroup = PKA_ECGROUP_SECP_384R1,
        .ecdsaVerify.pubKeyX = {
            .numLimbs = 12UL,
            .limbs = (const uint32_t[]) {
                0x72760AB7UL, 0x3A545E38UL, 0xBF55296CUL, 0x5502F25DUL,
                0x82542A38UL, 0x59F741E0UL, 0x8BA79B98UL, 0x6E1D3B62UL,
                0xF320AD74UL, 0x8EB1C71EUL, 0xBE8B0537UL, 0xAA87CA22UL,
            }
        },
        .ecdsaVerify.pubKeyY = {
            .numLimbs = 12UL,
            .limbs = (const uint32_t[]) {
                0x90EA0E5FUL, 0x7A431D7CUL, 0x1D7E819DUL, 0x0A60B1CEUL,
                0xB5F0B8C0UL, 0xE9DA3113UL, 0x289A147CUL, 0xF8F41DBDUL,
                0x9292DC29UL, 0x5D9E98BFUL, 0x96262C6FUL, 0x3617DE4AUL,
            }
        },
        .ecdsaVerify.msgHash = {
            .numLimbs = 12UL,
            .limbs = (const uint32_t[]) {
                0xE2B2DB3EUL, 0xF3BBC03AUL, 0x3A8CFBA4UL, 0xA9933EA8UL,
                0xBA46F833UL, 0x99C35A4EUL, 0xC74EAD3CUL, 0x84EBFD06UL,
                0x6B00A590UL, 0x677FDD08UL, 0x1F17D3CAUL, 0xB05F1FC1UL,
            }
        },
        .ecdsaVerify.signatureR = {
            .numLimbs = 12UL,
            .limbs = (const uint32_t[]) {
                0x2DEF0E83UL, 0x23B23F29UL, 0x7377CF96UL, 0x7955CBBCUL,
                0xD2B3878BUL, 0x4087CBDBUL, 0x8543F254UL, 0xFAD7D59CUL,
                0xE75E7D4AUL, 0x57AF4490UL, 0x9E6A653CUL, 0xC034C024UL,
            }
        },
        .ecdsaVerify.signatureS = {
            .numLimbs = 12UL,
            .limbs = (const uint32_t[]) {
                0xDD117F3BUL, 0x8104726DUL, 0xF13C8108UL, 0xCF8E877CUL,
                0xF6A56D40UL, 0xC242AD0DUL, 0x255D0E34UL, 0x5D525647UL,
                0x20FD4FDFUL, 0x9DC3D05EUL, 0xA856074DUL, 0x7573BFB2UL,
            }
        },
    },
#endif
};

#define PKA_TARGETED_TESTCASES_NUM_ELTS (sizeof(PKA_TARGETED_TESTCASES) / sizeof(PkaTestCaseType))

#endif
