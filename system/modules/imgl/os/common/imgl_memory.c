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
    @defgroup grp_imgl_memory_impl Memory Implementation
    @ingroup grp_imgl

    @addtogroup grp_imgl_memory_impl
    @{

    @file imgl_memory.c
    @brief IMGL Memory Implementation
    This source file contains the implementation of functions for IMGL Memory

    @version 1.0 Initial version
*/

#include <stdlib.h>
#include <compiler.h>
#include <imgl_osil.h>

/**
    @name IMGL Memory Design IDs
    @{
    @brief Design IDs for IMGL Memory
*/
#define BRCM_SWDSGN_IMGL_MEMORY_0_GLOBAL       (0xA201U)    /**< @brief #IMGL_Memory0       */
#define BRCM_SWDSGN_IMGL_MEMORY_1_GLOBAL       (0xA202U)    /**< @brief #IMGL_Memory1       */
#define BRCM_SWDSGN_IMGL_MEMORY_2_GLOBAL       (0xA203U)    /**< @brief #IMGL_Memory2       */
#define BRCM_SWDSGN_IMGL_MEMORY_GLOBAL         (0xA204U)    /**< @brief #IMGL_MemoryArea    */
#define BRCM_SWDSGN_IMGL_MEMORY_SIZE_GLOBAL    (0xA205U)    /**< @brief #IMGL_MemorySize    */
#define BRCM_SWDSGN_IMGL_MEM_GET_INFO_PROC     (0xA206U)    /**< @brief #IMGL_MemoryInfoGet */
/** @} */

/**
    @brief Memory area zero

    @trace #BRCM_SWARCH_IMGL_MEM_GET_INFO_PROC
    @trace #BRCM_SWREQ_IMGL_CORE
*/
#if (IMGL_MEMORY_SIZE_0 >= IMGL_MEM_AREA_MIN_SIZE)
static uint8_t IMGL_Memory0[IMGL_MEMORY_SIZE_0] COMP_SECTION(".imgl.memory.area0");
#endif

/**
    @brief Memory area two

    @trace #BRCM_SWARCH_IMGL_MEM_GET_INFO_PROC
    @trace #BRCM_SWREQ_IMGL_CORE
*/
#if (IMGL_MEMORY_SIZE_1 >= IMGL_MEM_AREA_MIN_SIZE)
static uint8_t IMGL_Memory1[IMGL_MEMORY_SIZE_1] COMP_SECTION(".imgl.memory.area1");
#endif

/**
    @brief Memory area three

    @trace #BRCM_SWARCH_IMGL_MEM_GET_INFO_PROC
    @trace #BRCM_SWREQ_IMGL_CORE
*/
#if (IMGL_MEMORY_SIZE_2 >= IMGL_MEM_AREA_MIN_SIZE)
static uint8_t IMGL_Memory2[IMGL_MEMORY_SIZE_2] COMP_SECTION(".imgl.memory.area2");
#endif

/**
    @brief Memory address array

    @trace #BRCM_SWARCH_IMGL_MEM_GET_INFO_PROC
    @trace #BRCM_SWREQ_IMGL_CORE
*/
static uint8_t * const IMGL_MemoryArea[] = {
#if (IMGL_MEMORY_SIZE_0 >= IMGL_MEM_AREA_MIN_SIZE)
    IMGL_Memory0,
#endif
#if (IMGL_MEMORY_SIZE_1 >= IMGL_MEM_AREA_MIN_SIZE)
    IMGL_Memory1,
#endif
#if (IMGL_MEMORY_SIZE_2 >= IMGL_MEM_AREA_MIN_SIZE)
    IMGL_Memory2,
#endif
};

/**
    @brief Download size array

    @trace #BRCM_SWARCH_IMGL_MEM_GET_INFO_PROC
    @trace #BRCM_SWREQ_IMGL_CORE
*/
static const uint32_t IMGL_MemorySize[] = {
#if (IMGL_MEMORY_SIZE_0 >= IMGL_MEM_AREA_MIN_SIZE)
    IMGL_MEMORY_SIZE_0,
#endif
#if (IMGL_MEMORY_SIZE_1 >= IMGL_MEM_AREA_MIN_SIZE)
    IMGL_MEMORY_SIZE_1,
#endif
#if (IMGL_MEMORY_SIZE_2 >= IMGL_MEM_AREA_MIN_SIZE)
    IMGL_MEMORY_SIZE_2,
#endif
};

/** @} */

/**
    @addtogroup grp_imgl_memory_ifc
    @{
*/

/**
    @trace #BRCM_SWARCH_IMGL_MEM_GET_INFO_PROC
    @trace #BRCM_SWREQ_IMGL_CORE

    @code{.unparsed}
    if aAddress is NULL or aSize is NULL
        ret = INVAL PARAMS
    else if aIndex >= size(IMGL_MemoryArea)/size(uint8_t*)
        ret =  NO MEM
    else
        aAddress = IMGL_MemoryArea[aIndex]
        aSize = IMGL_MemorySize[aIndex]
        ret = OK
    return ret
    @endcode

*/
int32_t IMGL_MemoryInfoGet(uint32_t aIndex,
                            uint8_t **aAddress,
                            uint32_t *aSize)
{
    int32_t ret = BCM_ERR_NOMEM;

    if ((NULL == aAddress) || (NULL == aSize)) {
        ret = BCM_ERR_INVAL_PARAMS;
    } else if (aIndex >= (sizeof(IMGL_MemoryArea) / sizeof(uint8_t*))) {
        ret = BCM_ERR_NOMEM;
    } else {
        *aAddress = IMGL_MemoryArea[aIndex];
        *aSize = IMGL_MemorySize[aIndex];
        ret = BCM_ERR_OK;
    }

    return ret;
}

/** @} */
