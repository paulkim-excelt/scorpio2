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
    WARRANTIES, EITHER EXPRESS, IPPLIED, STATUTORY, OR OTHERWISE, WITH RESPECT
    TO THE SOFTWARE.  BROADCOM SPECIFICALLY DISCLAIMS ANY AND ALL IPPLIED
    WARRANTIES OF TITLE, MERCHANTABILITY, NONINFRINGEMENT, FITNESS FOR A
    PARTICULAR PURPOSE, LACK OF VIRUSES, ACCURACY OR COPPLETENESS,
    QUIET ENJOYMENT, QUIET POSSESSION OR CORRESPONDENCE TO DESCRIPTION.
    YOU ASSUME THE ENTIRE RISK ARISING OUT OF USE OR PERFORMANCE OF THE
    SOFTWARE.

 3. TO THE MAXIMUM EXTENT PERMITTED BY LAW, IN NO EVENT SHALL BROADCOM OR ITS
    LICENSORS BE LIABLE FOR (i) CONSEQUENTIAL, INCIDENTAL, SPECIAL, INDIRECT,
    OR EXEPPLARY DAMAGES WHATSOEVER ARISING OUT OF OR IN ANY WAY RELATING TO
    YOUR USE OF OR INABILITY TO USE THE SOFTWARE EVEN IF BROADCOM HAS BEEN
    ADVISED OF THE POSSIBILITY OF SUCH DAMAGES; OR (ii) ANY AMOUNT IN EXCESS
    OF THE AMOUNT ACTUALLY PAID FOR THE SOFTWARE ITSELF OR U.S. $1, WHICHEVER
    IS GREATER. THESE LIMITATIONS SHALL APPLY NOTWITHSTANDING ANY FAILURE OF
    ESSENTIAL PURPOSE OF ANY LIMITED REMEDY.
******************************************************************************/

/**
    @defgroup grp_bcm_utils_qt Qualification Test for BCM Utilities
    @ingroup grp_utils

    @addtogroup grp_bcm_utils_qt
    @{

    @file bcm_utils_qt.h
    @brief BCM Utils Qualification Test
    This source file contains the Qualification test for BCM Utilities
    @version 0.1 Initial Version
*/

#ifndef BCM_UTILS_QT_H
#define BCM_UTILS_QT_H

/**
    @brief BCM_MemCpy() test case 0

    @pre None

    @test Call BCM_MemCpy() with valid source and destination addresses
    and number of bytes to be copied

    @post contents of source and destination should be same

    @functional Yes

    @type Pos

    @trace #BRCM_SWARCH_BCM_MEMCPY_PROC
*/
#define BRCM_SWITST_BCM_MEMCPY_CASE0                  (0UL)

/**
    @brief BCM_MemSet() test case 0

    @pre None

    @test Call BCM_MemSet() with valid source and destination addresses
    and number of bytes to be set as zero

    @post Contents of destination should not be changed

    @functional Yes

    @type Neg

    @trace #BRCM_SWARCH_BCM_MEMSET_PROC
*/
#define BRCM_SWITST_BCM_MEMSET_CASE0                  (1UL)

/**
    @brief BCM_MemSet() test case 1

    @pre None

    @test Call BCM_MemSet() with valid source and destination addresses
    and number of bytes to be set

    @post Contents in the destination should be set as many as the number
    of bytes given with the given value to be set

    @functional Yes

    @type Pos

    @trace #BRCM_SWARCH_BCM_MEMSET_PROC
*/
#define BRCM_SWITST_BCM_MEMSET_CASE1                  (2UL)

/**
    @brief BCM_MemMove() test case 0

    @pre None

    @test Call BCM_MemMove() with valid source and destination addresses
    and number of bytes to be moved

    @post Contents from the source should be moved to destnation address

    @functional Yes

    @type Pos

    @trace #BRCM_SWARCH_BCM_MEMMOVE_PROC
*/
#define BRCM_SWITST_BCM_MEMMOVE_CASE0                  (3UL)

/**
    @brief BCM_MemMove() test case 1

    @pre None

    @test Call BCM_MemMove() with address overlap

    @post Since the input addresses are overlaping BCM_MemMove() should overwrite
    input string and there should not be any data loss

    @functional Yes

    @type Pos

    @trace #BRCM_SWARCH_BCM_MEMMOVE_PROC
*/
#define BRCM_SWITST_BCM_MEMMOVE_CASE1                  (4UL)

/**
    @brief BCM_StrnCpy() test case 1

    @pre None

    @test Call BCM_StrnCpy() valid source and destination address and number
    of bytes to be copied

    @post Contents of from source should be copied to destination

    @functional Yes

    @type Pos

    @trace #BRCM_SWARCH_BCM_STRNCPY_PROC
*/
#define BRCM_SWITST_BCM_STRNCPY_CASE0                  (5UL)

/**
    @brief BCM_StrToLong() test case 0

    @pre None

    @test Call BCM_StrToLong() with large positive integer

    @post LONG_MAX should be returned

    @functional Yes

    @type Pos

    @trace #BRCM_SWARCH_BCM_STRTOLONG_PROC
*/
#define BRCM_SWITST_BCM_STRTOLONG_CASE0                  (6UL)

/**
    @brief BCM_StrToLong() test case 1

    @pre None

    @test Call BCM_StrToLong() with large negative integer

    @post LONG_MIN should be returned

    @functional Yes

    @type Pos

    @trace #BRCM_SWARCH_BCM_STRTOLONG_PROC
*/
#define BRCM_SWITST_BCM_STRTOLONG_CASE1                  (7UL)

/**
    @brief BCM_StrToLong() test case 2

    @pre None

    @test Call BCM_StrToLong() with valid arguments and base=10

    @post Integer in the string should be returned

    @functional Yes

    @type Pos

    @trace #BRCM_SWARCH_BCM_STRTOLONG_PROC
*/
#define BRCM_SWITST_BCM_STRTOLONG_CASE2                  (8UL)

/**
    @brief BCM_StrToLong() test case 3

    @pre None

    @test Call BCM_StrToLong() with valid arguments and base=16

    @post Hexadecimal number in the string should be returned

    @functional Yes

    @type Pos

    @trace #BRCM_SWARCH_BCM_STRTOLONG_PROC
*/
#define BRCM_SWITST_BCM_STRTOLONG_CASE3                  (9UL)

/**
    @brief BCM_IncMod() test case 0

    @pre None

    @test Call BCM_IncMod() with various input values

    @post When value=maxValue-1, 0 should be returned else value+1 should be returned

    @functional Yes

    @type Pos

    @trace #BRCM_SWARCH_BCM_INCMOD_PROC
*/
#define BRCM_SWITST_BCM_INCMOD_CASE0                    (10UL)

/**
    @brief BCM_DecMod() test case 0

    @pre None

    @test Call BCM_DecMod() with various input values

    @post When value=0, maxValue-1 should be returned else value-1 should be returned

    @functional Yes

    @type Pos

    @trace #BRCM_SWARCH_BCM_DECMOD_PROC
*/
#define BRCM_SWITST_BCM_DECMOD_CASE0                    (11UL)

/**
    @brief BCM_GCD() test case 0

    @pre None

    @test Call BCM_GCD() with value1 an value2

    @post Return value should GCD of value1 and value2

    @functional Yes

    @type Pos

    @trace #BRCM_SWARCH_BCM_GCD_PROC
*/
#define BRCM_SWITST_BCM_GCD_CASE0                       (12UL)

/**
    @brief BCM_RoundUpPowerTwo() test case 0

    @pre None

    @test Call BCM_RoundUpPowerTwo() with value which is not in power of 2
    and which is already in power of 2

    @post Return value should be rounded up value of input to nearest power of 2

    @functional Yes

    @type Pos

    @trace #BRCM_SWARCH_BCM_ROUNDUPPOWERTWO_PROC
*/
#define BRCM_SWITST_BCM_ROUNDUPPOWERTWO_CASE0           (13UL)

/**
    @brief BCM_StrnLen() test case 0

    @pre None

    @test Call BCM_StrnLen() with maxLen < input string length

    @post Return value should be maxLen

    @functional Yes

    @type Neg

    @trace #BRCM_SWARCH_BCM_STRNLEN_PROC
*/
#define BRCM_SWITST_BCM_STRNLEN_CASE0                   (14UL)

/**
    @brief BCM_StrnLen() test case 1

    @pre None

    @test Call BCM_StrnLen() with maxLen > input string length

    @post Return value should be input string length

    @functional Yes

    @type Pos

    @trace #BRCM_SWARCH_BCM_STRNLEN_PROC
*/
#define BRCM_SWITST_BCM_STRNLEN_CASE1                   (15UL)

/** @brief BCM Utils Qualification test sequence 0

    BCM Utils Qualification test sequence 0

    @code{.c}

    Call BCM_MemCpy() with valid source and destination
    address and number of bytes to be copied
    Check expected result for #BRCM_SWITST_BCM_MEMCPY_CASE0

    Call BCM_MemSet() with zero number of bytes to be set
    Check expected result for #BRCM_SWITST_BCM_MEMSET_CASE0

    Call BCM_MemSet() with valid pointer to memory and valid
    number of bytes to be set
    Check expected result for #BRCM_SWITST_BCM_MEMSET_CASE1

    Call BCM_MemMove() with valid source and destination addresses
    and number of bytes to be moved
    Check expected result for #BRCM_SWITST_BCM_MEMMOVE_CASE0

    Call BCM_MemMove() with address overlap
    Check expected result for #BRCM_SWITST_BCM_MEMMOVE_CASE1

    Call BCM_StrnCpy() with valid arguments
    Check expected result for #BRCM_SWITST_BCM_STRNCPY_CASE0

    Call BCM_StrToLong() with valid addresses and large
    positive integer in the input string
    Check expected result for #BRCM_SWITST_BCM_STRTOLONG_CASE0

    Call BCM_StrToLong() with valid addresses and large
    negative integer in the input string
    Check expected result for #BRCM_SWITST_BCM_STRTOLONG_CASE1

    Call BCM_StrToLong() with valid pointers and base as 10
    Check expected result for #BRCM_SWITST_BCM_STRTOLONG_CASE2

    Call BCM_StrToLong() with valid pointers and base as 16
    Check expected result for #BRCM_SWITST_BCM_STRTOLONG_CASE3

    Call BCM_IncMod() with various input values
    Check expected result for #BRCM_SWITST_BCM_INCMOD_CASE0

    Call BCM_DecMod() with various input values
    Check expected result for #BRCM_SWITST_BCM_DECMOD_CASE0

    Call BCM_GCD() with value1 > 0 and value2 > 0
    Check expected result for #BRCM_SWITST_BCM_GCD_CASE0

    Call BCM_RoundUpPowerTwo() with value which are not a power of 2
    and which are already in power of 2. Values should be greater than 1
    Check expected result for #BRCM_SWITST_BCM_ROUNDUPPOWERTWO_CASE0

    Call BCM_StrnLen() with maxLen < input string length
    Check expected result for #BRCM_SWITST_BCM_STRNLEN_CASE0

    Call BCM_StrnLen() with maxLen > input string length
    Check expected result for #BRCM_SWITST_BCM_STRNLEN_CASE1

    @endcode

    @board bcm89107_evk

    @auto  Yes

    @type  Sanity

*/
#define BRCM_SWITSEQ_BCM_UTILS_SEQ0           (1UL)
#endif /* BCM_UTILS_QT_H */

/** @} */
