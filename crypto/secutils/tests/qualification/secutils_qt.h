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
    @defgroup grp_secutils_qt Qualification Tests
    @ingroup grp_secutils

    @addtogroup grp_secutils_qt
    @{

    @file secutils_qt.h
    @brief secutils qualification test
    This file contains the test cases for the routines implemented in the secutils library
    @version 1.0 Changelist1
    @version 0.1 Changelist0
*/

#ifndef SECUTILS_QT_H
#define SECUTILS_QT_H

/**
    @brief Multi precision integer import positive test

    @pre None

    @test Invoke @ref SECUTILS_ImportBigUint API on different multi precision
            representations, and validate the results

    @post All validations should go through.

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_SECUTILS_MPINT
*/
#define BRCM_SWQTST_SECUTILS_CONFIG_CASE0      (0x101UL)

/**
    @brief Multi precision integer import negative test

    @pre None

    @test Invoke @ref SECUTILS_ImportBigUint API with NULL input parametres
            and test if the function call fails as expected

    @post Function calls have to fail as expected

    @functional     Yes

    @type           Neg

    @trace #BRCM_SWREQ_SECUTILS_MPINT
*/
#define BRCM_SWQTST_SECUTILS_CONFIG_CASE1      (0x102UL)

/** @brief Secutils full test sequence

    @code{.c}
    Check expected result for #BRCM_SWQTST_SECUTILS_CONFIG_CASE0
    Check expected result for #BRCM_SWQTST_SECUTILS_CONFIG_CASE1
    @endcode

    @auto           Yes

    @type           Sanity

    @testproc #BRCM_SWQTST_SECUTILS_CONFIG_CASE0
    @testproc #BRCM_SWQTST_SECUTILS_CONFIG_CASE1
*/
#define BRCM_SWQTSEQ_SECUTILS_FULL_SEQUENCE    (0x103UL)

#endif /* SECUTILS_QT_H */
/*  * @} */
