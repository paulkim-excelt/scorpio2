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
    @defgroup grp_abstract_generic_impl CPU Generic Implementation
    @ingroup grp_abstract

    @addtogroup grp_abstract_generic_impl
    @{

    @file cpu_generic.c
    @brief Implementation of generic CPU APIs

    @version 0.1 Initial version
*/

#include <stdint.h>
#include <stddef.h>
#include <cpu.h>

/**
    @name CPU Generic Design IDs
    @{
    @brief Design IDs for CPU Generic
*/
#define BRCM_SWDSGN_CPU_LEADZERO_PROC       (0xB100U)    /**< @brief #CPU_Clz */
#define BRCM_SWDSGN_CPU_BITSREVERSE_PROC    (0xB101U)    /**< @brief #CPU_BitReverse */
/** @} */


/** @brief Count of leading zeroes

    returns the count of leading zeroes

    @trace  #BRCM_SWARCH_CPU_CLZ_PROC
    @trace  #BRCM_SWREQ_CPU_ABSTRACTION

    @code{.unparsed}
    uint32_t idx
    for (idx = 0UL; idx < 32UL; idx++)
        if (aValue & (1U << (31UL - idx)))
            break
    return idx
    @endcode
*/
uint32_t CPU_Clz(uint32_t aValue)
{
    uint32_t idx;
    for (idx = 0UL; idx < 32UL; idx++) {
        if (aValue & (1U << (31UL - idx))) {
            break;
        }
    }
    return idx;
}

/** @brief Reverse the bits

    Reverses the order of bits in the passed vale

    @trace  #BRCM_SWARCH_CPU_BITREVERSE_PROC
    @trace  #BRCM_SWREQ_CPU_ABSTRACTION

    @code{.unparsed}
    uint32_t x = aValue
    x = (((x & 0xAAAAAAAAUL) >> 1UL) | ((x & 0x55555555UL) << 1UL))
    x = (((x & 0xCCCCCCCCUL) >> 2UL) | ((x & 0x33333333UL) << 2UL))
    x = (((x & 0xF0F0F0F0UL) >> 4UL) | ((x & 0x0F0F0F0FUL) << 4UL))
    x = (((x & 0xFF00FF00UL) >> 8UL) | ((x & 0x00FF00FFUL) << 8UL))
    return ((x >> 16UL) | (x << 16UL))
    @endcode
*/
uint32_t CPU_BitReverse(uint32_t aValue)
{
    uint32_t x = aValue;

    x = (((x & 0xAAAAAAAAUL) >> 1UL) | ((x & 0x55555555UL) << 1UL));
    x = (((x & 0xCCCCCCCCUL) >> 2UL) | ((x & 0x33333333UL) << 2UL));
    x = (((x & 0xF0F0F0F0UL) >> 4UL) | ((x & 0x0F0F0F0FUL) << 4UL));
    x = (((x & 0xFF00FF00UL) >> 8UL) | ((x & 0x00FF00FFUL) << 8UL));

    return ((x >> 16UL) | (x << 16UL));
}

/** @} */
