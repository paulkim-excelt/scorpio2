/*****************************************************************************
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
******************************************************************************/
/**
    @defgroup grp_pka_qt Qualification Tests
    @ingroup grp_pka

    @addtogroup grp_pka_qt
    @{

    @file pka_qt.h
    @brief PKA qualification test
    This file contains the test cases for the routines implemented in the PKA library

    @version 0.1
*/

#ifndef PKA_QT_H
#define PKA_QT_H

/**
    @brief RSA PKCS1 v1.5 signature verification positive tests

    @pre Generate a number of RSA public/private keys offline. The modulus
        sizes should be a mix of 128 and 256 bytes. Also, generate a few random
        message streams. Sign these message streams with the generated RSA keys
        using all the digest algorithms we support. Serialize these signatures and
        the corresponding public keys and the digest algorithms used to generate them.

    @test Invoke @ref PKA_RsaPkcs1v15Verify API on each signature generated offline
        with the corresponding public key and the digest algorithm. After each invocation,
        repeatedly call the @ref PKA_GetAlgExecResult until the aAlgExecResult is set to
        something other than #BCM_ERR_BUSY

    @post Every @ref PKA_GetAlgExecResult should resolve with #BCM_ERR_OK indicating that
        the signature verification passed

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_PKA_LIBRARY
*/
#define BRCM_SWQTST_PKA_CONFIG_CASE0      (0x101UL)

/**
    @brief RSA PKCS1 v1.5 signature verification negative tests

    @pre Generate data as was done in #BRCM_SWQTST_PKA_CONFIG_CASE0.
        Systematically corrupt a few words in RSA public key, signature and hash
        and serialize these results

    @test Invoke @ref PKA_RsaPkcs1v15Verify API on the dataset generated as detailed
        above. After each invocation, repeatedly call the @ref PKA_GetAlgExecResult
        until the aAlgExecResult is set to something other than #BCM_ERR_BUSY

    @post Every @ref PKA_GetAlgExecResult should resolve with #BCM_ERR_AUTH_FAILED
        indicating that the signature verification failed as expected

    @functional     Yes

    @type           Neg

    @trace #BRCM_SWREQ_PKA_LIBRARY
*/
#define BRCM_SWQTST_PKA_CONFIG_CASE1      (0x102UL)

/**
    @brief PKA job queue test

    @pre Generate some data offline as was done in #BRCM_SWQTST_PKA_CONFIG_CASE0
        and #BRCM_SWQTST_PKA_CONFIG_CASE1. Mix these datasets and randomly shuffle them

    @test Invoke @ref PKA_RsaPkcs1v15Verify repeatedly with a different data point on each
        invocation. Save off the returned job ID's into an array. The job queue is
        #LWQ_BUFFER_MAX_LENGTH long, so we should be able to successfully submit those many jobs.
        Any additional submissions should fail.

    @post Verify if indeed #LWQ_BUFFER_MAX_LENGTH submissions were successful, and the next
        ones failed. Now, invoke @ref PKA_GetAlgExecResult to query the result of the first
        submitted job. Once that resolves (as expected), invoke @ref PKA_RsaPkcs1v15Verify
        again on a new data point. This submission should pass. Finally, call
        @ref PKA_GetAlgExecResult on all the saved jobID's and verify that all the resolutions
        are what one would expect (a mix of pass and failed signature verification results)

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_PKA_LIBRARY
*/
#define BRCM_SWQTST_PKA_CONFIG_CASE2      (0x103UL)

/**
    @brief PKA event test

    @pre Generate some data offline as was done in #BRCM_SWQTST_PKA_CONFIG_CASE0.
        Pick up a couple of data points at random

    @test Invoke @ref PKA_RsaPkcs1v15Verify one data point save the jonID, and issue
        an OS call to block on the PKAEvent.

    @post Task should eventually wake back up (when PKAEvent signals). At this point
        call to @ref PKA_GetAlgExecResult should instantly resolve to #BCM_ERR_OK.
        Repeat the whole test with a few more data points (including the negative ones).

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_PKA_LIBRARY
*/
#define BRCM_SWQTST_PKA_CONFIG_CASE3      (0x104UL)

/** @brief Secutils full test sequence

    @code{.c}
    - Generate two different datasets one as described in
        #BRCM_SWQTST_PKA_CONFIG_CASE0 and the other as described in
        #BRCM_SWQTST_PKA_CONFIG_CASE1
    - Run #BRCM_SWQTST_PKA_CONFIG_CASE0 on the first dataset and check
        if we get the expected results
    - Run #BRCM_SWQTST_PKA_CONFIG_CASE1 with the second dataset and check
        if we get the expected results
    - Merge the two datasets to create a third one. Run #BRCM_SWQTST_PKA_CONFIG_CASE2
        on this dataset and check if we get the expected results
    - Run #BRCM_SWQTST_PKA_CONFIG_CASE3 on the third dataset and validate the
        results
    @endcode

    @auto           Yes

    @type           Sanity

    @testproc #BRCM_SWQTST_PKA_CONFIG_CASE0
    @testproc #BRCM_SWQTST_PKA_CONFIG_CASE1
*/
#define BRCM_SWQTSEQ_PKA_FULL_SEQUENCE    (0x105UL)

#endif /* PKA_QT_H */

/** @} */