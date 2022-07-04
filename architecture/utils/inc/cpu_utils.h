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
    @defgroup grp_cpu_utils_ifc Host CPU Utilities Interface
    @ingroup grp_utils

    @addtogroup grp_cpu_utils_ifc
    @{

    @file cpu_utils.h
    @brief CPU specific utility functions

    This header file contains the interface functions for Endianness conversion

    @version 1.4 split interface and implementation
    @version 1.3 Import from Document
*/

#ifndef CPU_UTILS_H
#define CPU_UTILS_H

#include <compiler.h>
#include <stdint.h>

/**
    @name CPU Endianness API Interface IDs
    @{
    @brief API Interface IDs for CPU Endianness
*/
#define BRCM_SWARCH_CPU_NATIVETOBE16_PROC        (0x8B01U)    /**< @brief #CPU_NativeToBE16 */
#define BRCM_SWARCH_CPU_NATIVETOLE16_PROC        (0x8B02U)    /**< @brief #CPU_NativeToLE16 */
#define BRCM_SWARCH_CPU_BETONATIVE16_PROC        (0x8B03U)    /**< @brief #CPU_BEToNative16 */
#define BRCM_SWARCH_CPU_LETONATIVE16_PROC        (0x8B04U)    /**< @brief #CPU_LEToNative16 */
#define BRCM_SWARCH_CPU_NATIVETOBE32_PROC        (0x8B05U)    /**< @brief #CPU_NativeToBE32 */
#define BRCM_SWARCH_CPU_NATIVETOLE32_PROC        (0x8B06U)    /**< @brief #CPU_NativeToLE32 */
#define BRCM_SWARCH_CPU_BETONATIVE32_PROC        (0x8B07U)    /**< @brief #CPU_BEToNative32 */
#define BRCM_SWARCH_CPU_LETONATIVE32_PROC        (0x8B08U)    /**< @brief #CPU_LEToNative32 */
#define BRCM_SWARCH_CPU_BETONATIVE64_PROC        (0x8B09U)    /**< @brief #CPU_BEToNative64 */
#define BRCM_SWARCH_CPU_NATIVETOBE64_PROC        (0x8B0AU)    /**< @brief #CPU_NativeToBE64 */
#define BRCM_SWARCH_CPU_NATIVETOLE64_PROC        (0x8B0BU)    /**< @brief #CPU_NativeToLE64 */
#define BRCM_SWARCH_CPU_LETONATIVE64_PROC        (0x8B0CU)    /**< @brief #CPU_LEToNative64 */
/** @} */

/** @brief Converts 16-bit data from host's endian format to big endian format.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aData       Host data to be converted

    @return Data in CPU big endian format

    @post None

    @trace  #BRCM_SWREQ_CPU_ABSTRACTION

    @limitations None
*/
extern uint16_t CPU_NativeToBE16(uint16_t aData);

/** @brief Converts 16-bit data from host's endian format to little endian format.

    @behavior Sync, Re-entrant

    @pre describe any pre-condition (expectation before calling this function)

    @param[in]      aData       Host data to be converted

    @return Data in little endian format

    @post None

    @trace  #BRCM_SWREQ_CPU_ABSTRACTION

    @limitations None
*/
extern uint16_t CPU_NativeToLE16(uint16_t aData);

/** @brief Converts 16-bit data from big endian format to host's endian format.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aData       Data in big endian format

    @return Data in host's endian format

    @post None

    @trace  #BRCM_SWREQ_CPU_ABSTRACTION

    @limitations None
*/
extern uint16_t CPU_BEToNative16(uint16_t aData);

/** @brief Converts 16-bit data from little endian format to host's endian format.

    @behavior Sync, Re-entrant

    @pre describe any pre-condition (expectation before calling this function)

    @param[in]      aData       Data in litte endian format

    @return Data in host's endian format

    @post None

    @trace  #BRCM_SWREQ_CPU_ABSTRACTION

    @limitations None
*/
extern uint16_t CPU_LEToNative16(uint16_t aData);

/** @brief Converts 32-bit data from host's endian format to big endian format.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aData       Host data to be converted

    Return values are documented in reverse-chronological order
    @return Data in big endian format

    @post None

    @trace  #BRCM_SWREQ_CPU_ABSTRACTION

    @limitations None
*/
extern uint32_t CPU_NativeToBE32(uint32_t aData);

/** @brief Converts 32-bit data from host's endian format to little endian format.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aData       Host data to be converted

    @return Data in little endian format

    @post None

    @trace  #BRCM_SWREQ_CPU_ABSTRACTION

    @limitations None
*/
extern uint32_t CPU_NativeToLE32(uint32_t aData);

/** @brief Converts 32-bit data from big endian format to host's endian format.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aData       Data in big endian format

    @return Data in host's endian format

    @post None

    @trace  #BRCM_SWREQ_CPU_ABSTRACTION

    @limitations None
*/
extern uint32_t CPU_BEToNative32(uint32_t aData);

/** @brief Converts 32-bit data from little endian format to host's endian format.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aData       Data in litte endian format

    @return Data in host's endian format

    @post None

    @trace  #BRCM_SWREQ_CPU_ABSTRACTION

    @limitations None
*/
extern uint32_t CPU_LEToNative32(uint32_t aData);

/** @brief Converts 64-bit data from big endian format to host's endian format.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aData       Data in big endian format

    @return Data in host's endian format

    @post None

    @trace  #BRCM_SWREQ_CPU_ABSTRACTION

    @limitations None
*/
extern uint64_t CPU_BEToNative64(uint64_t aData);

/** @brief Converts 64-bit data from host's endian format to big endian format.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aData       Host data to be converted

    @return Data in big endian format

    @post None

    @trace  #BRCM_SWREQ_CPU_ABSTRACTION

    @limitations None
*/
extern uint64_t CPU_NativeToBE64(uint64_t aData);

/** @brief Converts 64-bit data from host's endian format to little endian format.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aData       Host data to be converted

    @return Data in little endian format

    @post None

    @trace  #BRCM_SWREQ_CPU_ABSTRACTION

    @limitations None
*/
extern uint64_t CPU_NativeToLE64(uint64_t aData);

/** @brief converts 64-bit data from little endian To Native's endian format

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aData       Data to be converted

    @return Data in little endian format

    @post None

    @trace  #BRCM_SWREQ_CPU_ABSTRACTION

    @limitations None
*/
extern uint64_t CPU_LEToNative64(uint64_t aData);
#endif /* CPU_UTILS_H */
/** @} */
