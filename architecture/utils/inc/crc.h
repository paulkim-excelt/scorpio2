/*****************************************************************************
 Copyright 2017-2021 Broadcom Limited.  All rights reserved.

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

 3. TO THE MAXIMUM EXTENT PERMITTED BY LAW, IN NO EVENT CRCLL BROADCOM OR ITS
    LICENSORS BE LIABLE FOR (i) CONSEQUENTIAL, INCIDENTAL, SPECIAL, INDIRECT,
    OR EXEMPLARY DAMAGES WHATSOEVER ARISING OUT OF OR IN ANY WAY RELATING TO
    YOUR USE OF OR INABILITY TO USE THE SOFTWARE EVEN IF BROADCOM HAS BEEN
    ADVISED OF THE POSSIBILITY OF SUCH DAMAGES; OR (ii) ANY AMOUNT IN EXCESS
    OF THE AMOUNT ACTUALLY PAID FOR THE SOFTWARE ITSELF OR U.S. $1, WHICHEVER
    IS GREATER. THESE LIMITATIONS CRCLL APPLY NOTWITHSTANDING ANY FAILURE OF
    ESSENTIAL PURPOSE OF ANY LIMITED REMEDY.
******************************************************************************/

/**
    @defgroup grp_utils_crc CRC Interface
    @ingroup grp_utils

    @addtogroup grp_utils_crc
    @{

    @file crc.h
    @brief CRC functions
    This file provides CRC definitions

    @version 0.1 Initial Version
*/

#ifndef CRC_H
#define CRC_H

#include <stddef.h>
#include <inttypes.h>
#include <compiler.h>
#include <bcm_err.h>

/**
    @name CRC Architecture IDs
    @{
    @brief Architecture IDs for CRC

*/
#define BRCM_SWARCH_BCM_CRC32_PROC           (0x8801U)    /**< @brief #BCM_CRC32       */
#define BRCM_SWARCH_BCM_CRC32_CUSTOM_PROC    (0x8802U)    /**< @brief #BCM_CRC32Custom */
#define BRCM_SWARCH_BCM_CHKSUM_PROC          (0x8803U)    /**< @brief #BCM_Chksum      */
#define BRCM_SWARCH_BCM_CRC16_PROC           (0x8804U)    /**< @brief #BCM_CRC16       */
/** @} */

/** @brief CRC 32 calculation

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aAddr       Starting address from which CRC has to be
                                computed
    @param[in]      aLen        Size in Bytes for which CRC has to be
                                computed
    @param[in]      aPoly       Polynomial to be used in calculation

    @retval     CRC value for provided data

    @post None

    @trace #BRCM_SWREQ_BCM_UTILS
*/
uint32_t BCM_CRC32(const uint8_t *const aAddr,
                   uint32_t aLen,
                   uint32_t aPoly);

/** @brief CRC 32 calculation (Custom)

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aAddr       Starting address from which CRC has to be
                                computed
    @param[in]      aLen        Size in Bytes for which CRC has to be
                                computed
    @param[in]      aPoly       Polynomial to be used in calculation

    @param[in]      aInitVal    Initial value for CRC

    @retval     CRC value for provided data

    @post None

    @trace #BRCM_SWREQ_BCM_UTILS
*/
uint32_t BCM_CRC32Custom(const uint8_t *const aAddr,
                         uint32_t aLen,
                         uint32_t aPoly,
                         uint32_t aInitVal);

/** @brief Checksum calculation

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aAddr       Starting address from which check sum
                                has to be computed
    @param[in]      aLen        Size in Bytes for which check sum has
                                to be computed
    @retval     Check sum value for provided data

    @post None

    @trace #BRCM_SWREQ_BCM_UTILS
*/
uint16_t BCM_Chksum(const uint8_t *const aAddr,
                    uint32_t aLen);

/** @brief CRC 16 calculation

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aAddr       Starting address from which CRC has to be
                                computed
    @param[in]      aLen        Size in Bytes for which CRC has to be
                                computed
    @param[in]      aPoly       Polynomial to be used in calculation

    @param[in]      aInitVal    Initial value for CRC

    @retval     CRC value for provided data

    @post None

    @trace #BRCM_SWREQ_BCM_UTILS
*/
extern uint16_t BCM_CRC16(const uint8_t *const aAddr,
                          uint32_t aLen,
                          uint16_t aPoly,
                          uint16_t aInitVal);
#endif /* CRC_H */

/** @} */
