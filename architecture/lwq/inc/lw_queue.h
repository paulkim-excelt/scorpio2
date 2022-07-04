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

 2. TO THE COMP_MAXIMUM EXTENT PERMITTED BY LAW, THE SOFTWARE IS PROVIDED "AS IS"
    AND WITH ALL FAULTS AND BROADCOM MAKES NO PROMISES, REPRESENTATIONS OR
    WARRANTIES, EITHER EXPRESS, IMPLIED, STATUTORY, OR OTHERWISE, WITH RESPECT
    TO THE SOFTWARE.  BROADCOM SPECIFICALLY DISCLAIMS ANY AND ALL IMPLIED
    WARRANTIES OF TITLE, MERCHANTABILITY, NONINFRINGEMENT, FITNESS FOR A
    PARTICULAR PURPOSE, LACK OF VIRUSES, ACCURACY OR COMPLETENESS,
    QUIET ENJOYMENT, QUIET POSSESSION OR CORRESPONDENCE TO DESCRIPTION.
    YOU ASSUME THE ENTIRE RISK ARISING OUT OF USE OR PERFORMANCE OF THE
    SOFTWARE.

 3. TO THE COMP_MAXIMUM EXTENT PERMITTED BY LAW, IN NO EVENT SHALL BROADCOM OR ITS
    LICENSORS BE LIABLE FOR (i) CONSEQUENTIAL, INCIDENTAL, SPECIAL, INDIRECT,
    OR EXEMPLARY DAMAGES WHATSOEVER ARISING OUT OF OR IN ANY WAY RELATING TO
    YOUR USE OF OR INABILITY TO USE THE SOFTWARE EVEN IF BROADCOM HAS BEEN
    ADVISED OF THE POSSIBILITY OF SUCH DAMAGES; OR (ii) ANY AMOUNT IN EXCESS
    OF THE AMOUNT ACTUALLY PAID FOR THE SOFTWARE ITSELF OR U.S. $1, WHICHEVER
    IS GREATER. THESE LIMITATIONS SHALL APPLY NOTWITHSTANDING ANY FAILURE OF
    ESSENTIAL PURPOSE OF ANY LIMITED REMEDY.
******************************************************************************/

/**
    @defgroup grp_lwq_ifc Interface
    @ingroup grp_lwq

    @addtogroup grp_lwq_ifc
    @{
    Below table describes layout of 64-bit data for light weight queue.

   |63-60  |59-56  |55-52  |51-48  |47-44  |43-40  |39-36  |35-32  |31-28  |27-24  |23-20  |19-16  |15-12  |11-08  |07-04  |03-00  |
   |:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|
   |Idx 14 |Idx 13 |Idx 12 |Idx 11 |Idx 10 |Idx 09 |Idx 08 |Idx 07 |Idx 06 |Idx 05 |Idx 04 |Idx 03 |Idx 02 |Idx 01 |Idx 00 | Length|

    @file lw_queue.h
    @brief Light Weight Queue interface

    @version 0.1 Initial Version
*/

#ifndef LW_QUEUE_H
#define LW_QUEUE_H

#include <bcm_err.h>
#include <stddef.h>

/**
    @name Light Weight Queue Architecture IDs
    @{
    @brief Architecture IDs for Light Weight Queue
*/
#define BRCM_SWARCH_LWQ_BUFFER_TYPE        (0x8201U)    /**< @brief #LWQ_BufferType */
#define BRCM_SWARCH_LWQ_INIT_PROC          (0x8202U)    /**< @brief #LWQ_Init       */
#define BRCM_SWARCH_LWQ_LENGTH_PROC        (0x8203U)    /**< @brief #LWQ_Length     */
#define BRCM_SWARCH_LWQ_PUSH_PROC          (0x8204U)    /**< @brief #LWQ_Push       */
#define BRCM_SWARCH_LWQ_POP_PROC           (0x8205U)    /**< @brief #LWQ_Pop        */
#define BRCM_SWARCH_LWQ_PEEK_FIRST_PROC    (0x8206U)    /**< @brief #LWQ_PeekFirst  */
#define BRCM_SWARCH_LWQ_PEEK_LAST_PROC     (0x8207U)    /**< @brief #LWQ_PeekLast   */
/** @} */

/**
    @name LWQ_Buffer IDs
    @{
    @brief Light Weight Cicular Queue Buffer

    @trace #BRCM_SWREQ_LWQ
*/
typedef uint64_t LWQ_BufferType; /**< @brief COMP_State typedef */
#define LWQ_BUFFER_INIT_VALUE   (0x0ULL) /**< @brief Empty Queue Initializer & value must be zero*/
#define LWQ_BUFFER_MAX_LENGTH   (0xFUL)  /**< @brief description of COMP_STATE1 */
#define LWQ_BUFFER_LENGTH_SIZE  (0x4UL)  /**< @brief description of COMP_STATE1 */
#define LWQ_BUFFER_LENGTH_MASK  (0xFULL) /**< @brief description of COMP_STATE1 */
#define LWQ_BUFFER_OBJECT_SIZE  (0x4ULL) /**< @brief description of COMP_STATE1 */
#define LWQ_BUFFER_OBJECT_MASK  (0xFULL) /**< @brief description of COMP_STATE1 */
/** @} */

/** @brief Initialize LWQ

    @behavior Sync, Non-reentrant

    @pre None

    @param[inout]   aBuffer     LWQ_BufferType Pointer to initialize

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Success
    @retval     #BCM_ERR_INVAL_PARAMS   aBuffer is NULL

    @post LWQ is cleared

    @trace #BRCM_SWREQ_LWQ

    @limitations None
*/
static inline void LWQ_Init(LWQ_BufferType *aBuffer)
{
    if (NULL != aBuffer) {
        *aBuffer = 0ULL;
    }
}


/** @brief Get LWQ Length

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aBuffer     LWQ_BufferType Pointer

    @return     Filled Length of Queue

    @post None

    @trace #BRCM_SWREQ_LWQ

    @limitations None
*/
static inline uint32_t LWQ_Length(LWQ_BufferType aBuffer)
{
    return (uint32_t)(aBuffer & LWQ_BUFFER_LENGTH_MASK);
}

/** @brief Peek first index in LWQ

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]   aBuffer     LWQ_BufferType Pointer to push into

    @retval 0U if lenth is zero
    @retval First pushed index if lenth is zero

    @post aObject is pushed into LWQ

    @trace #BRCM_SWREQ_LWQ

    @limitations None
*/
static inline uint8_t LWQ_PeekFirst(LWQ_BufferType aBuffer)
{
    uint8_t ret = 0U;
    if (0UL != LWQ_Length(aBuffer)) {
        ret = (uint8_t)((aBuffer >> LWQ_BUFFER_LENGTH_SIZE) & LWQ_BUFFER_OBJECT_MASK);
    }
    return ret;
}

/** @brief Peek last object in LWQ

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aBuffer     LWQ_BufferType object

    @retval 0U if lenth is zero
    @retval Last pushed index if lenth is zero

    @post aObject is pushed into LWQ

    @trace #BRCM_SWREQ_LWQ

    @limitations None
*/
static inline uint8_t LWQ_PeekLast(LWQ_BufferType aBuffer)
{
    uint8_t ret = 0U;
    uint32_t len = LWQ_Length(aBuffer);
    if (0UL != len) {
        ret = (uint8_t)((aBuffer >> (len * LWQ_BUFFER_OBJECT_SIZE))
                   & LWQ_BUFFER_OBJECT_MASK);
    }
    return ret;
}

/** @brief Push an object into LWQ

    @behavior Sync, Non-reentrant

    @pre None

    @param[inout]   aBuffer     LWQ_BufferType Pointer to push into
    @param[in]      aObject     lower 4-bit object index to be pushed

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Success
    @retval     #BCM_ERR_NOMEM          Queue is full
    @retval     #BCM_ERR_INVAL_PARAMS   aBuffer is NULL

    @post aObject is pushed into LWQ

    @trace #BRCM_SWREQ_LWQ

    @limitations None
*/
int32_t LWQ_Push(LWQ_BufferType *aBuffer, uint8_t aObject);

/** @brief Pop an object from LWQ

    @behavior Sync, Non-reentrant

    @pre None

    @param[inout]   aBuffer     LWQ_BufferType Pointer to push into
    @param[in]      aObject     pointer to fill 4-bit index of first object

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Success
    @retval     #BCM_ERR_NOMEM          Queue is full
    @retval     #BCM_ERR_INVAL_PARAMS   aBuffer is NULL

    @post aObject is popped from LWQ

    @trace #BRCM_SWREQ_LWQ

    @limitations None
*/
int32_t LWQ_Pop(LWQ_BufferType *aBuffer, uint8_t *aObject);

#endif /* LW_QUEUE_H */

/** @} */
