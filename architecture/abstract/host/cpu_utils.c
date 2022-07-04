/*****************************************************************************
 Copyright 2017-2018 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_cpu_utils_host_impl Utilities implementation
    @ingroup grp_utils

    @addtogroup grp_cpu_utils_host_impl
    @{

    @file cpu_utils.c
    @brief specific endianness functions

    This header file contains the Endianness conversion design

    @version 0.1 Import from Document
*/
#include <compiler.h>
#include <stdint.h>
#include <byteswap.h>

/**
    @name CPU Endianness Design IDs
    @{
    @brief API Design IDs for CPU Endianness
*/
#define BRCM_SWDSGN_CPU_UTIL_NATIVETOBE16_PROC        (0xBC01U)    /**< @brief #CPU_NativeToBE16 */
#define BRCM_SWDSGN_CPU_UTIL_NATIVETOLE16_PROC        (0xBC02U)    /**< @brief #CPU_NativeToLE16 */
#define BRCM_SWDSGN_CPU_UTIL_BETONATIVE16_PROC        (0xBC03U)    /**< @brief #CPU_BEToNative16 */
#define BRCM_SWDSGN_CPU_UTIL_LETONATIVE16_PROC        (0xBC04U)    /**< @brief #CPU_LEToNative16 */
#define BRCM_SWDSGN_CPU_UTIL_NATIVETOBE32_PROC        (0xBC05U)    /**< @brief #CPU_NativeToBE32 */
#define BRCM_SWDSGN_CPU_UTIL_NATIVETOLE32_PROC        (0xBC06U)    /**< @brief #CPU_NativeToLE32 */
#define BRCM_SWDSGN_CPU_UTIL_BETONATIVE32_PROC        (0xBC07U)    /**< @brief #CPU_BEToNative32 */
#define BRCM_SWDSGN_CPU_UTIL_LETONATIVE32_PROC        (0xBC08U)    /**< @brief #CPU_LEToNative32 */
#define BRCM_SWDSGN_CPU_UTIL_BETONATIVE64_PROC        (0xBC09U)    /**< @brief #CPU_BEToNative64 */
#define BRCM_SWDSGN_CPU_UTIL_NATIVETOBE64_PROC        (0xBC0AU)    /**< @brief #CPU_NativeToBE64 */
#define BRCM_SWDSGN_CPU_UTIL_NATIVETOLE64_PROC        (0xBC0BU)    /**< @brief #CPU_NativeToLE64 */
#define BRCM_SWDSGN_CPU_UTIL_LETONATIVE64_PROC        (0xBC0CU)    /**< @brief #CPU_LEToNative64 */
/** @} */

/** @brief converts 16-bit data from Native's endian format to big endian format.

    @limitations None
    @trace #BRCM_SWARCH_CPU_NATIVETOBE16_PROC
    @trace #BRCM_SWREQ_CPU_ABSTRACTION
    @code{.c}
    val = aData
    return bswap_16(aData)
    @endcode
*/
uint16_t CPU_NativeToBE16(uint16_t aData)
{
#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
    return aData;
#else
    return bswap_16(aData);
#endif
}

/** @brief converts 16-bit data from Native's endian format to little endian format.

    @limitations None
    @trace #BRCM_SWARCH_CPU_NATIVETOLE16_PROC
    @trace #BRCM_SWREQ_CPU_ABSTRACTION
    @code{.c}
    return aData
    @endcode
*/
uint16_t CPU_NativeToLE16(uint16_t aData)
{
#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
    return bswap_16(aData);
#else
    return aData;
#endif
}

/** @brief converts 16-bit data from big endian format to Native's endian format.

    @limitations None
    @trace #BRCM_SWARCH_CPU_BETONATIVE16_PROC
    @trace #BRCM_SWREQ_CPU_ABSTRACTION
    @code{.c}
    return CPU_NativeToBE16(aData)
    @endcode
*/
uint16_t CPU_BEToNative16(uint16_t aData)
{
#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
    return aData;
#else
    return __bswap_16(aData);
#endif
}

/** @brief converts 16-bit data from little endian format to Native's endian format.

    @limitations None
    @trace #BRCM_SWARCH_CPU_LETONATIVE16_PROC
    @trace #BRCM_SWREQ_CPU_ABSTRACTION
    @code{.c}
    return aData
    @endcode
*/
uint16_t CPU_LEToNative16(uint16_t aData)
{
#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
    return bswap_16(aData);
#else
    return aData;
#endif
}

/** @brief converts 32-bit data from Native's endian format to big endian format.

    @limitations None
    @trace #BRCM_SWARCH_CPU_NATIVETOBE32_PROC
    @trace #BRCM_SWREQ_CPU_ABSTRACTION
    @code{.c}
    return bswap_32(aData)
    @endcode
*/
uint32_t CPU_NativeToBE32(uint32_t aData)
{
#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
    return aData;
#else
    return bswap_32(aData);
#endif
}

/** @brief converts 32-bit data from Native's endian format to little endian format.

    @limitations None
    @trace #BRCM_SWARCH_CPU_NATIVETOLE32_PROC
    @trace #BRCM_SWREQ_CPU_ABSTRACTION
    @code{.c}
    return aData
    @endcode
*/
uint32_t CPU_NativeToLE32(uint32_t aData)
{
#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
    return bswap_32(aData);
#else
    return aData;
#endif
}

/** @brief converts 32-bit data from big endian format to Native's endian format.

    @limitations None
    @trace #BRCM_SWARCH_CPU_BETONATIVE32_PROC
    @trace #BRCM_SWREQ_CPU_ABSTRACTION
    @code{.c}
    return CPU_NativeToBE32(aData)
    @endcode
*/
uint32_t CPU_BEToNative32(uint32_t aData)
{
#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
    return aData;
#else
    return bswap_32(aData);
#endif
}

/** @brief converts 32-bit data from little endian format to Native's endian format.

    @limitations None
    @trace #BRCM_SWARCH_CPU_LETONATIVE32_PROC
    @trace #BRCM_SWREQ_CPU_ABSTRACTION
    @code{.c}
    return aData
    @endcode
*/
uint32_t CPU_LEToNative32(uint32_t aData)
{
#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
    return bswap_32(aData);
#else
    return aData;
#endif
}

/** @brief converts 64-bit data from big endian format to Native's endian format.

    @limitations None
    @trace #BRCM_SWARCH_CPU_BETONATIVE64_PROC
    @trace #BRCM_SWREQ_CPU_ABSTRACTION
    @code{.c}
    return (((uint64_t)(CPU_NativeToBE32(
                 (uint32_t)((aData << 32UL) >> 32UL))) << 32UL) |
                 (uint32_t)CPU_NativeToBE32(((uint32_t)(aData >> 32UL))))
    @endcode
*/
uint64_t CPU_BEToNative64(uint64_t aData)
{
#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
    return aData;
#else
    return (((uint64_t)(CPU_BEToNative32(
                 (uint32_t)(aData))) << 32UL) |
                 CPU_BEToNative32(((uint32_t)(aData >> 32UL))));
#endif
}

/** @brief converts 64-bit data from Native's endian format to big endian format.

    @trace #BRCM_SWARCH_CPU_NATIVETOBE64_PROC
    @trace #BRCM_SWREQ_CPU_ABSTRACTION
    @code{.c}
    return CPU_BEToNative64(aData)
    @endcode
*/
uint64_t CPU_NativeToBE64(uint64_t aData)
{
#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
    return aData;
#else
    return (((uint64_t)(CPU_NativeToBE32(
                 (uint32_t)(aData))) << 32UL) |
                 CPU_NativeToBE32(((uint32_t)(aData >> 32UL))));
#endif
}

/** @brief converts 64-bit data from Native's endian format to little endian format.

    @trace #BRCM_SWARCH_CPU_NATIVETOLE64_PROC
    @trace #BRCM_SWREQ_CPU_ABSTRACTION
    @code{.c}
    return aData
    @endcode
*/
uint64_t CPU_NativeToLE64(uint64_t aData)
{
#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
    return (((uint64_t)(CPU_NativeToLE32(
                 (uint32_t)(aData))) << 32UL) |
                 CPU_NativeToLE32(((uint32_t)(aData >> 32UL))));
#else
    return aData;
#endif
}

/** @brief converts 64-bit data from little endian To Native's endian format

    @trace #BRCM_SWARCH_CPU_LETONATIVE64_PROC
    @trace #BRCM_SWREQ_CPU_ABSTRACTION
    @code{.c}
    @endcode
*/
uint64_t CPU_LEToNative64(uint64_t aData)
{
#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
    return (((uint64_t)(CPU_LEToNative32(
                 (uint32_t)(aData))) << 32UL) |
                 CPU_LEToNative32(((uint32_t)(aData >> 32UL))));
#else
    return aData;
#endif
}
/** @} */
