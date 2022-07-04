/*****************************************************************************
 Copyright 2020 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_imgl_memory_ifc Memory Interface
    @ingroup grp_imgl

    @addtogroup grp_imgl_memory_ifc
    @{

    @limitations IMGL Memory interface functions are to be used only for Fetch
        Executable Path. This functions are not to be used in other paths.

    @file imgl_memory.h
    @brief IMGL Memory interface
    This header file contains the memory interface functions for IMGL

    @version 0.1 Initial Version
*/

#ifndef IMGL_MEMORY_H
#define IMGL_MEMORY_H

#include <stdint.h>
#include <pt_utils.h>

/**
    @name IMGL Memory Architecture IDs
    @{
    @brief Architecture IDs for IMGL Memory
*/
#define BRCM_SWARCH_IMGL_MEM_AREA_MACRO       (0x9101U)    /**< @brief #IMGL_MEM_AREA_MIN_SIZE */
#define BRCM_SWARCH_IMGL_MEM_GET_INFO_PROC    (0x9102U)    /**< @brief #IMGL_MemoryInfoGet     */
/** @} */

/** @brief Download area minimum size

    @trace #BRCM_SWREQ_IMGL_CORE
*/
#define IMGL_MEM_AREA_MIN_SIZE          (4096UL)
#define IMGL_MEM_AREA_MAX_CNT           (4UL)
_Static_assert(IMGL_MEM_AREA_MIN_SIZE > sizeof(ITBL_Type), "ITBL Size should be less than IMGL_MEM_AREA_MIN_SIZE");
/** @} */

/** @brief Get Memory Info

    @behavior Sync, Non-reentrant

    @pre IMGL is initialized

    @param[in]      aIndex      Index in IMGL_MemoryArea
    @param[out]     aAddress    Address of Memory
    @param[out]     aSize       Size of Memory

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Found a valid memory area,
                                        aAddress and aSize are populated
    @retval     #BCM_ERR_NOMEM          Index out of bounds
    @retval     #BCM_ERR_INVAL_PARAMS   (aAddress is NULL) or (aSize is NULL)

    @post None

    @trace #BRCM_SWREQ_IMGL_CORE
*/
int32_t IMGL_MemoryInfoGet(uint32_t aIndex,
                            uint8_t **aAddress,
                            uint32_t *aSize);

#endif /* IMGL_MEMORY_H */

/** @} */
