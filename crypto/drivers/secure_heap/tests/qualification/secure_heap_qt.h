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
    @defgroup grp_secureheap_qt Qualification Tests
    @ingroup grp_secureheap

    @addtogroup grp_secureheap_qt
    @{

    @file secure_heap_qt.h
    @brief Secure heap qualification test
    This file contains the secure heap test cases
    @version 1.0 Changelist1
    @version 0.1 Changelist0
*/

#ifndef SECURE_HEAP_QT_H
#define SECURE_HEAP_QT_H

/**
    @brief Test secure heap allocations and frees

    @pre None

    @test Allocate and free one block of memory from the secure heap

    @post Must return a valid handle on allocation. And the free should
            invalidate the handle.

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_SECHEAP
*/
#define BRCM_SWQTST_SECHEAP_CONFIG_CASE0    (0x101UL)

/**
    @brief Test allocation with unsupported size

    @pre None

    @test Request an allocation with a size that is too big.

    @post Allocation must fail.

    @functional     Yes

    @type           Neg

    @trace #BRCM_SWREQ_SECHEAP
*/
#define BRCM_SWQTST_SECHEAP_CONFIG_CASE1    (0x102UL)

/**
    @brief Test free with invalid handle

    @pre None

    @test Call secure heap free with an invalid handle

    @post Free must fail.

    @functional     Yes

    @type           Neg

    @trace #BRCM_SWREQ_SECHEAP
*/
#define BRCM_SWQTST_SECHEAP_CONFIG_CASE2    (0x103UL)

/**
    @brief Exhaustive allocation test 1

    @pre Exhaust a memory pool by repeatedly allocating from it.

    @test Try to allocate from the exhausted pool

    @post Allocation must fail.

    @functional     Yes

    @type           Neg

    @trace #BRCM_SWREQ_SECHEAP
*/
#define BRCM_SWQTST_SECHEAP_CONFIG_CASE3    (0x104UL)

/**
    @brief Exhaustive allocation test 2

    @pre Exhaust a memory pool by repeatedly allocating from it.

    @test Free one memory block from the exhausted pool. Then request
            two allocations from that pool.

    @post The first allocation must succeeded, while the second should fail.

    @functional     Yes

    @type           Neg

    @trace #BRCM_SWREQ_SECHEAP
*/
#define BRCM_SWQTST_SECHEAP_CONFIG_CASE4    (0x105UL)

/**
    @brief Pin and unpin tests

    @pre None

    @test Perform a pin operation on a valid allocation handle. Then unpin
            the allocation.

    @post Pinning should succeed, valid CPU and DMA addresses have to
            be returned. Subsequent unpin also should succeed.

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_SECHEAP
*/
#define BRCM_SWQTST_SECHEAP_CONFIG_CASE5    (0x106UL)

/**
    @brief Pin test 2

    @pre None

    @test Request a pin operation on an invalid allocation handle

    @post Pin operation should fail

    @functional     Yes

    @type           Neg

    @trace #BRCM_SWREQ_SECHEAP
*/
#define BRCM_SWQTST_SECHEAP_CONFIG_CASE6    (0x107UL)

#endif
/*  * @} */
