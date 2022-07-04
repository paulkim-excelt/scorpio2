/*****************************************************************************
 Copyright 2018-2021 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_abstract_stdlib Standard Library Wrappers
    @ingroup grp_abstract

    @addtogroup grp_abstract_stdlib
    @{
    @section sec_stdlib_overview Overview
    This file specifies common utility wrappers for C Standard library APIs

    @file utils.h
    @brief C Standard library wrapper functiions

    @version 1.3 Export comments from docx
*/

#ifndef BCM_UTILS_H
#define BCM_UTILS_H

#if defined(__CORTEX_MX__) || defined(__CORTEX_RX__)
#include <cpu_utils.h>
#include <cortex_mx.h>
#endif
#include <stdint.h>
#include <compiler.h>
#include <limits.h>
#include <string.h>
#include <stdlib.h>
#include <cpu.h>
#if defined (__ARMCC__)
#include <stddef.h>
#endif

/**
    @name C Standard library Architecture IDs
    @{
    @brief Architecture IDs for C Standard library

*/
#define BRCM_SWARCH_BCM_MEMCPY_PROC                 (0x8201U)   /**< @brief #BCM_MemCpy             */
#define BRCM_SWARCH_BCM_MEMSET_PROC                 (0x8202U)   /**< @brief #BCM_MemSet             */
#define BRCM_SWARCH_BCM_MEMMOVE_PROC                (0x8203U)   /**< @brief #BCM_MemMove            */
#define BRCM_SWARCH_BCM_STRNCPY_PROC                (0x8204U)   /**< @brief #BCM_StrnCpy            */
#define BRCM_SWARCH_BCM_STRTOLONG_PROC              (0x8205U)   /**< @brief #BCM_StrToLong          */
#define BRCM_SWARCH_BCM_INCMOD_PROC                 (0x8206U)   /**< @brief #BCM_IncMod             */
#define BRCM_SWARCH_BCM_DECMOD_PROC                 (0x8207U)   /**< @brief #BCM_DecMod             */
#define BRCM_SWARCH_BCM_GCD_PROC                    (0x8208U)   /**< @brief #BCM_GCD                */
#define BRCM_SWARCH_BCM_ROUNDUPPOWERTWO_PROC        (0x8209U)   /**< @brief #BCM_RoundUpPowerTwo    */
#define BRCM_SWARCH_BCM_STRNLEN_PROC                (0x820AU)   /**< @brief #BCM_StrnLen            */
#define BRCM_SWARCH_BCM_MIN_MACRO                   (0x820BU)   /**< @brief #BCM_MIN                */
#define BRCM_SWARCH_BCM_MAX_MACRO                   (0x820CU)   /**< @brief #BCM_MAX                */
#define BRCM_SWARCH_BCM_FREQ_MHZ_MACRO              (0x820DU)   /**< @brief #BCM_FREQ_MHZ           */
#define BRCM_SWARCH_BCM_ITOA_PROC                   (0x820EU)   /**< @brief #BCM_ItoA               */
#define BRCM_SWARCH_BCM_ATOI_PROC                   (0x820FU)   /**< @brief #BCM_AtoI               */
#define BRCM_SWARCH_BCM_UINT8_MAX_MACRO             (0x8210U)   /**< @brief #BCM_UINT8_MAX          */
#define BRCM_SWARCH_BCM_UINT16_MAX_MACRO            (0x8211U)   /**< @brief #BCM_UINT16_MAX         */
#define BRCM_SWARCH_BCM_UINT32_MAX_MACRO            (0x8212U)   /**< @brief #BCM_UINT32_MAX         */
#define BRCM_SWARCH_BCM_UINT64_MAX_MACRO            (0x8213U)   /**< @brief #BCM_UINT64_MAX         */
#define BRCM_SWARCH_BCM_GET_CPU_CYCLES_FROM_NS_PROC (0x8214U)   /**< @brief #BCM_GetCpuCyclesFromNs */
#define BRCM_SWARCH_BCM_GET_NS_FROM_CPU_CYCLES_PROC (0x8215U)   /**< @brief #BCM_GetNsFromCpuCycles */
#define BRCM_SWARCH_BCM_CPUNDELAY_PROC              (0x8216U)   /**< @brief #BCM_CpuNDelay          */
#define BRCM_SWARCH_BCM_DIV_CEIL_MACRO              (0x8217U)   /**< @brief #BCM_DIV_CEIL           */
#define BRCM_SWARCH_BCM_DIV_ROUND_MACRO             (0x8218U)   /**< @brief #BCM_DIV_ROUND          */
#define BRCM_SWARCH_BCM_ALIGN_NEXT_MACRO            (0x8219U)   /**< @brief #BCM_ALIGN_NEXT         */
#define BRCM_SWARCH_BCM_BIT_MASK_MACRO              (0x821AU)   /**< @brief #BCM_BIT_MASK32         */
#define BRCM_SWARCH_BCM_BITFLD_MACRO                (0x821BU)   /**< @brief #BCM_BITFLD_GET         */
#define BRCM_SWARCH_BCM_ARRAY_LEN_MACRO             (0x821CU)   /**< @brief #BCM_ARRAY_LEN          */
#define BRCM_SWARCH_BCM_BUG_MACRO                   (0x821DU)   /**< @brief #BCM_BUG                */
#define BRCM_SWARCH_BCM_ASSERT_MACRO                (0x821EU)   /**< @brief #BCM_ASSERT             */
/** @} */

/** @brief Copies aSize number bytes from aSrc to aDest.

    @behavior Sync, Re-entrant

    @pre None

    @param[inout]    aDest   Pointer to the destination array where the content is to be copied.
    @param[in]       aSrc    Pointer to the source of data to be copied
    @param[in]       aSize   Number of bytes to copy

    @retval     void

    @post None

    @trace  #BRCM_SWREQ_BCM_STDLIB_WRAPPER
*/
static inline void BCM_MemCpy(void *aDest, const void *aSrc, uint32_t aSize)
{
    ((void)memcpy(aDest, aSrc, aSize));
}

/** @brief Fill memory with a constant byte.

    Fills aSize number of elements in memory pointed by aStr with a value aVal.

    @behavior Sync, Re-entrant

    @pre None

    @param[inout]    aStr    Pointer to the block of memory to fill
    @param[in]       aVal    The value to be set
    @param[in]       aSize   Number of bytes to be set to the value

    @retval     void

    @post None

    @trace  #BRCM_SWREQ_BCM_STDLIB_WRAPPER
*/
static inline void BCM_MemSet(void *aStr, uint8_t aVal, uint32_t aSize)
{
    ((void)memset(aStr, (int32_t)aVal, aSize));
}

/** @brief Moves given number bytes from src to dest.

    Moves aSize number of elements from memory pointed by aSrc to memory pointed by aDest
    The memory areas can be overlapping.

    @behavior Sync, Re-entrant

    @pre None

    @param[inout]    aDest   Pointer to the destination memory block where the content is to be copied
    @param[in]       aSrc    Pointer to the source of data to be copied
    @param[in]       aSize   Number of bytes to copy

    @retval     void

    @post None

    @trace  #BRCM_SWREQ_BCM_STDLIB_WRAPPER
*/
static inline void BCM_MemMove(void *aDest, const void *aSrc, uint32_t aSize)
{
    ((void)memmove(aDest, aSrc, aSize));
}

/** @brief Copies a given number (aSize) of characters from aSrc to aDest.

    @behavior Sync, Re-entrant

    @pre None

    @param[inout]    aDest   Pointer to the destination array where the content    is to be copied.
    @param[in]       aSrc    Pointer to the source of data to be copied
    @param[in]       aSize   Number of characters to copy

    @retval     void

    @post None

    @trace  #BRCM_SWREQ_BCM_STDLIB_WRAPPER
*/
static inline void BCM_StrnCpy(void *aDest, const void *aSrc, uint32_t aSize)
{
    ((void)strncpy(aDest, aSrc, aSize));
}

/** @brief Convert a string to a long integer

    @behavior Sync, Re-entrant

    @pre None

    @param[in]       aBuf        Pointer to the string which needs to be converted
    @param[inout]    aEndPtr     Location to store the address of first invalid
                                 character in aBuf (not optional)
    @param[in]       aBase       Integer base of the number given in aBuf. Shall
                                 be a value between 2 and 36 or 0

    Return values are documented in reverse-chronological order
    @retval       long_integer   if aBuf contains a valid integer
    @retval       LONG_MAX       if the integer in aBuf is a large positive    causing overflow
    @retval       LONG_MIN       if the integer in aBuf is a large negative causing underflow

    @post None

    @trace  #BRCM_SWREQ_BCM_STDLIB_WRAPPER
*/
static inline int32_t BCM_StrToLong(char *aBuf, char **aEndPtr, int32_t aBase)
{
    int32_t value;

    value = strtol(aBuf, aEndPtr, aBase);
    if ((**aEndPtr != '\0')) {
        value = 0x7FFFFFFFL;
    }
    return value;
}

/** @brief Convert ASCII string to integer

    @behavior Sync, Re-entrant

    @pre None

    @param[in]       aStr        String that needs to be converted

    Return values are documented in reverse-chronological order
    @retval          uint32_t    Converted integer value

    @post None

    @trace  #BRCM_SWREQ_BCM_STDLIB_WRAPPER
*/
static inline int32_t BCM_AtoI(uint8_t *aStr)
{
    uint32_t idx = 0UL;
    int32_t value = 0L;
    int32_t sign = 1L;

    /* Check for negative value */
    if ((uint8_t)'-' == aStr[0U]) {
        sign = -1L;
        idx++;
    }

    /* Convert each char into integer */
    while (aStr[idx] != (uint8_t)'\0') {
        value = (value * 10L) + (int32_t)aStr[idx] - (int32_t)'0';
        idx++;
    }

    return sign * value;
}

/** @brief Convert integer to ASCII string

    @behavior Sync, Re-entrant

    @pre None

    @param[in]       aValue      Value to be converted to a string
    @param[out]      aStr        Array in memory where to store the resulting null-terminated string
    @param[in]       aBase       Integer base of the number given in aBuf. Shall
                                 be a value between 2 and 36 or 0

    Return values are documented in reverse-chronological order
    @retval       string         A pointer to the resulting null-terminated string, same as parameter aStr

    @post None

    @trace  #BRCM_SWREQ_BCM_STDLIB_WRAPPER
*/
static inline uint8_t* BCM_ItoA(int32_t aValue, uint8_t *aStr, uint32_t aBase)
{
    uint32_t i = 0UL;
    uint32_t j = 0UL;
    int32_t  n = aValue;

    if ((aBase < 2UL) || (aBase > 32UL)) {
        goto err;
    }

    if (aValue < 0L){
            n = -1L * aValue;
    }
    while (n > 0L) {
        uint8_t r = (uint8_t)((uint32_t)n % aBase);
        if (r >= 10U) {
            aStr[i++] = 65U + (r - 10U);
        } else {
            aStr[i++] = 48U + r;
        }
        n = n / (int32_t)aBase;
    }

    if (i == 0UL) {
        aStr[i++] = (uint8_t)'0';
    }

    /* If base is 10 and value is negative, the resulting string */
    /* is preceded with a minus sign (-)                         */
    /* With any other base, value is always considered unsigned  */
    if ((aValue < 0L) && (aBase == 10UL)) {
        aStr[i++] = (uint8_t)'-';
    }
    aStr[i] = (uint8_t)'\0';

    /* Reversing the string */
    j = i - 1UL;
    i = 0UL;
    while (i < j) {
        uint8_t t = aStr[i];
        aStr[i] = aStr[j];
        aStr[j] = t;
        i++;
        j--;
    }

err:
    return aStr;
}

/** @brief Modulo increment

    This API does modulo increment of the value. Range of Modulo incremented value will be
    from 0 to (aMax - 1UL).    If aValue = (aMax - 1UL), incremented value will be 0.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]   aValue      Value to be modulo incremented
    @param[in]   aMax        Max value for modulo increment

    @retval     Modulo incremented value

    @post None

    @trace  #BRCM_SWREQ_BCM_UTILS
*/
static inline uint32_t BCM_IncMod(uint32_t aValue, uint32_t aMax)
{
    uint32_t tmpVal = aValue + 1UL;

    if (aMax == tmpVal) {
        tmpVal = 0UL;
    }

    return tmpVal;
}

/** @brief Modulo decrement

    This API does modulo decrement of the value. Range of Modulo decremented value will
    be from 0 to (aMax - 1UL). If aValue = 0, decremented value will be (aMax - 1UL).

    @behavior Sync, Re-entrant

    @pre None

    @param[in]   aValue      Value to be modulo decremented
    @param[in]   aMax        Max value for modulo decrement

    @retval     Modulo decremented value

    @post None

    @trace  #BRCM_SWREQ_BCM_UTILS
*/
static inline uint32_t BCM_DecMod(uint32_t aValue, uint32_t aMax)
{
    uint32_t tmpVal;

    if (0UL == aValue) {
        tmpVal = aMax - 1UL;
    } else {
        tmpVal = aValue - 1UL;
    }

    return tmpVal;
}

/** @brief Greatest Common Divisor

    This API gets the Greatest Common Divisor (GCD) of 2 numbers

    @behavior Sync, Re-entrant

    @pre None

    @param[in]   aValue1      First input number
    @param[in]   aValue2      Second input number

    @retval     GCD of the 2 input numbers

    @post None

    @trace  #BRCM_SWREQ_BCM_UTILS
*/
static inline uint32_t BCM_GCD(uint32_t aValue1, uint32_t aValue2)
{
    while(aValue1 != aValue2)
    {
        if(aValue1 > aValue2){
            aValue1 -= aValue2;
        }
        else{
            aValue2 -= aValue1;
        }
    }

    return aValue1;
}

/** @brief Round the number up to the nearest power of two

    This API will round the input number up to the nearest
    power of two

    @behavior Sync, Re-entrant

    @pre None

    @param[in]   aValue      Value to be rounded off

    @retval     Rounded power of two

    @post None

    @trace  #BRCM_SWREQ_BCM_UTILS
*/
static inline uint32_t BCM_RoundUpPowerTwo(uint32_t aValue)
{
    uint32_t x = aValue;

    x--;
    x |= x >> 1;
    x |= x >> 2;
    x |= x >> 4;
    x |= x >> 8;
    x |= x >> 16;
    ++x;

    return x;
}

/** @brief Determine the length of a fixed-size string

    This API will determine the length of a fixed-size string

    @behavior Sync, Re-entrant

    @pre None

    @param[in]   s        Input String
    @param[in]   maxLen   maxLen to be searched

    @retval               number of characters in the string pointed
                          to by s, excluding the terminating
                          null byte ('\0'), but at most maxLen.

    @post None

    @trace  #BRCM_SWREQ_BCM_STDLIB_WRAPPER
*/
static inline uint32_t BCM_StrnLen(const char *s, uint32_t maxLen)
{
    char *end = NULL;
    uint32_t len = maxLen;
    end = memchr(s, (int32_t)'\0', maxLen);
    if (NULL != end) {
        len = (uint32_t) (end - s);
    }
    return len;
}

/** @brief Get the number of CPU cycles given the time in nano seconds

    @behavior Sync, Reentrant

    @pre None

    @param[in]      aNs                     Time in ns

    @returns        uint64_t                CPU_CLOCK_IN_Hz * (aNs * 10^(-9))

    @post None

    @trace  #BRCM_SWREQ_BCM_STDLIB_WRAPPER
*/
extern uint64_t BCM_GetCpuCyclesFromNs(const uint64_t aNs);

/** @brief Get the time elapsed in nano seconds given the CPU cycle count

    @behavior Sync, Reentrant

    @pre None

    @param[in]      aCycleCnt               CPU cycle count

    @returns        uint64_t                aCycleCnt / (CPU_CLOCK_IN_Hz * 10^(-9))

    @post None

    @trace  #BRCM_SWREQ_BCM_STDLIB_WRAPPER
*/
extern uint64_t BCM_GetNsFromCpuCycles(const uint64_t aCycleCnt);

/** @brief Do busy waiting

    This API does cpu busy waiting (upto Nanoseconds granularity).
    This can be used in cases where timer block has not yet be initialized.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]   aTime_ns      Time in nanoseconds (0 to 1000000000)

    @retval void

    @post None

    @trace  #BRCM_SWREQ_BCM_STDLIB_WRAPPER

    @limitations    Delay may not be accurate upto nanosecond granularity. The
                    delay will be equal to or more than the requested value.
                    This API is expensive in terms of system performance and
                    hence must be used carefully.
*/
extern void BCM_CpuNDelay(uint32_t aTime_ns);

/** @brief Minimum of 2 numbers

    This macro returns the minimum of 2 numbers.

    @trace  #BRCM_SWREQ_BCM_UTILS
*/
#define BCM_MIN(a, b)                   (((a) > (b)) ? (b) : (a))

/** @brief Maximum of 2 numbers

    This macro returns the maximum of 2 numbers.

    @trace  #BRCM_SWREQ_BCM_UTILS
*/
#define BCM_MAX(a, b)                   (((a) > (b)) ? (a) : (b))

/** @brief Integer divide with ceil

    Divide the given two integers and ceil the results

    @trace  #BRCM_SWREQ_BCM_UTILS
*/
#define BCM_DIV_CEIL(aNum, aDen)                      ((aDen)?(((aNum)+(aDen)-1UL)/(aDen)):0U)

/** @brief Integer divide with rounding

    Divide the given two integers and round the result to the
    nearest integer

    @trace  #BRCM_SWREQ_BCM_UTILS
*/
#define BCM_DIV_ROUND(aNum, aDen)                     ((aDen)?(((aNum)+(aDen)/2UL)/(aDen)):0U)

/** @brief Align to the next alignment boundary

    Align the given number to the next alignment boundary.

    @note The aAlign should be a 2s power number

    @trace  #BRCM_SWREQ_BCM_UTILS
*/
#define BCM_ALIGN_NEXT(aNum, aAlign)                  (((aNum)+(aAlign)-1U)&(~((aAlign)-1U)))

/** @brief Generate bit mask

    Generate bit mask for the given start and count bits

    @trace  #BRCM_SWREQ_BCM_UTILS
*/
#define BCM_BIT_MASK32(aStartBit, aEndBit)            ((0xFFFFFFFFUL>>(31UL-(aEndBit)+(aStartBit)))<<(aStartBit))

/**
    @name Bitfield Macros
    @{
    @brief Macros for defining, extracting and setting bitfields

    Macros for defining, extracting & setting bit field in a 32 bit data

    @note These macros will be updated based on SWAUTO-12501

    @trace  #BRCM_SWREQ_BCM_UTILS
*/
#define BCM_BITFLD_GET(aValue, aStartBit, aEndBit)             (((aValue)&BCM_BIT_MASK32(aStartBit, aEndBit)) >> aStartBit)
#define BCM_BITFLD_SET(aRhs, aValue, aStartBit, aEndBit)       aRhs |= (((aValue)<<(aStartBit))&BCM_BIT_MASK32(aStartBit, aEndBit))
#define BCM_BITFLD_CLR_SET(aRhs, aValue, aStartBit, aEndBit)   aRhs  = ((aRhs)&(~BCM_BIT_MASK32(aStartBit, aEndBit))) |   \
                                                               (((aValue)<<(aStartBit))&BCM_BIT_MASK32(aStartBit, aEndBit))
/** @} */

/** @brief Array length

    Get the number of elements in the given array

    @note aArray should be an array, if pointer is passed, then the
    result is always 1

    @trace  #BRCM_SWREQ_BCM_UTILS
*/
#define BCM_ARRAY_LEN(aArray)                         (sizeof(aArray)/sizeof((aArray)[0]))

/**
    @trace #BRCM_SWREQ_BCM_UTILS
*/
#define BCM_FREQ_MHZ(x)         (1000000UL * (x))

/**
    @trace #BRCM_SWREQ_BCM_UTILS
*/
#define BCM_UINT8_MAX          (0xffU)

/**
    @trace #BRCM_SWREQ_BCM_UTILS
*/
#define BCM_UINT16_MAX         (0xffffU)

/**
    @trace #BRCM_SWREQ_BCM_UTILS
*/
#define BCM_UINT32_MAX         (0xffffffffUL)

/**
    @trace #BRCM_SWREQ_BCM_UTILS
*/
#define BCM_UINT64_MAX         (0xffffffffffffffffULL)

/** @brief Helper macro to unconditionally trigger a CPU breakpoint

    @trace #BRCM_SWREQ_BCM_UTILS
*/
#define BCM_BUG()               \
    do {                        \
        CPU_Breakpoint();       \
    } while (0UL)


/** @brief Helper macro to trigger a CPU breakpoint on assert fail

    @trace #BRCM_SWREQ_BCM_UTILS
*/
#define BCM_ASSERT(cond)        \
    if (!(cond)) {              \
        CPU_Breakpoint();       \
    }

#endif /* BCM_UTILS_H */

/** @} */
