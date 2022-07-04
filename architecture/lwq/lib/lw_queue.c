/*****************************************************************************
 Copyright 2018 Broadcom Limited.  All rights reserved.

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
    @addtogroup grp_lwq_ifc
    @{

    @file lw_queue.c
    @brief Light Weight Queue Implementation

    @version 0.1 Initial version
*/

#include <lw_queue.h>
/**
    @name Light Weight Cirucular Queue Design IDs
    @{
    @brief Design IDs for Light Weight Cirucular Queue
*/
#define BRCM_SWDSGN_LWQ_PUSH_PROC    (0xB101U)    /**< @brief #LWQ_Push */
#define BRCM_SWDSGN_LWQ_POP_PROC     (0xB102U)    /**< @brief #LWQ_Pop  */
/** @} */


/**
    @trace #BRCM_SWREQ_LWQ
    @trace #BRCM_SWARCH_LWQ_PUSH_PROC
*/
int32_t LWQ_Push(LWQ_BufferType *aBuffer, uint8_t aObject)
{
    int32_t ret;
    if (NULL == aBuffer) {
        ret =  BCM_ERR_INVAL_PARAMS;
    } else if (LWQ_BUFFER_MAX_LENGTH == LWQ_Length(*aBuffer)) {
        ret = BCM_ERR_NOMEM;
    } else {
        uint64_t len = LWQ_Length(*aBuffer);
        uint64_t mask = LWQ_BUFFER_LENGTH_MASK;
        mask |= (LWQ_BUFFER_OBJECT_MASK << ((len + 1UL) * LWQ_BUFFER_OBJECT_SIZE));
        *aBuffer &= ~mask;
        *aBuffer |=  ((len + 1UL)
                        | (((uint64_t)(aObject & LWQ_BUFFER_OBJECT_MASK))
                            << ((len + 1UL) * LWQ_BUFFER_OBJECT_SIZE)));
        ret = BCM_ERR_OK;
    }
    return ret;
}


/**
    @trace #BRCM_SWREQ_LWQ
    @trace #BRCM_SWARCH_LWQ_POP_PROC
*/
int32_t LWQ_Pop(LWQ_BufferType *aBuffer, uint8_t *aObject)
{
    int32_t ret;
    if ((NULL == aBuffer) || (NULL == aObject)) {
        ret =  BCM_ERR_INVAL_PARAMS;
    } else if (0UL == LWQ_Length(*aBuffer)) {
        ret = BCM_ERR_NOMEM;
    } else {
        uint64_t len = LWQ_Length(*aBuffer);
        *aObject = (uint8_t)(((*aBuffer) & (LWQ_BUFFER_OBJECT_MASK << LWQ_BUFFER_LENGTH_SIZE))
                    >> LWQ_BUFFER_LENGTH_SIZE);
        *aBuffer = (*aBuffer) >> LWQ_BUFFER_LENGTH_SIZE;
        *aBuffer &= ~(LWQ_BUFFER_LENGTH_MASK);
        *aBuffer |= ((len - 1ULL) & LWQ_BUFFER_LENGTH_MASK);
        ret = BCM_ERR_OK;
    }
    return ret;
}

/** @} */
