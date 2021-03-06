/*****************************************************************************
 Copyright 2018-2019 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_circq_qt Circular Queue Qualification Tests
    @ingroup grp_circq

    @addtogroup grp_circq_qt
    @{

    @file circ_queue_qt.h
    @brief This header file contains internal interfaces for circular
    queue qualification tests.
    @version 0.1 Initial Version
*/

#ifndef CIRC_QUEUE_QT_H
#define CIRC_QUEUE_QT_H

/**
    @brief Initialization of CIRCQ

    @pre None

    @test Check if CIRCQ is empty

    @post isEmpty should be set to One

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_CIRCQ_INITIALIZATION
*/
#define BRCM_SWQTST_CIRCQ_INIT_ISEMPTY                        (0x101UL)

/**
    @brief Initialization of CIRCQ

    @pre None

    @test Check if CIRCQ is full

    @post isFull should be set to Zero

    @functional     Yes

    @type           Neg

    @trace #BRCM_SWREQ_CIRCQ_INITIALIZATION
*/
#define BRCM_SWQTST_CIRCQ_INIT_ISFULL                         (0x102UL)

/**
    @brief Initialization of CIRCQ

    @pre None

    @test Check CIRCQ filled size

    @post getFilledSize should return Zero

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_CIRCQ_INITIALIZATION
*/
#define BRCM_SWQTST_CIRCQ_INIT_GETFILLEDSIZE                  (0x103UL)

/**
    @brief Initialization of CIRCQ

    @pre None

    @test Initialize CIRCQ

    @post Peek should return CIRCQ is empty

    @functional     Yes

    @type           Neg

    @trace #BRCM_SWREQ_CIRCQ_INITIALIZATION
*/
#define BRCM_SWQTST_CIRCQ_INIT_PEEK                           (0x104UL)

/**
    @brief Initialization of CIRCQ

    @pre None

    @test Pop one item from the CIRCQ

    @post Pop should return CIRCQ is empty

    @functional     Yes

    @type           Neg

    @trace #BRCM_SWREQ_CIRCQ_INITIALIZATION
*/
#define BRCM_SWQTST_CIRCQ_INIT_POP                            (0x105UL)

/**
    @brief push one item into the empty CIRCQ

    @pre CIRCQ is empty

    @test Push one item into the CIRCQ

    @post CIRCQ should contain one item

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_CIRCQ_CONFIGURATION
*/
#define BRCM_SWQTST_CIRCQ_PUSH                                (0x106UL)

/**
    @brief push one item into the empty CIRCQ

    @pre CIRCQ should contain one item

    @test Check if CIRCQ is empty

    @post isEmpty should be set to Zero

    @functional     Yes

    @type           Neg

    @trace #BRCM_SWREQ_CIRCQ_CONFIGURATION
*/
#define BRCM_SWQTST_CIRCQ_PUSH_ISEMPTY                        (0x107UL)

/**
    @brief push one item into the empty CIRCQ

    @pre CIRCQ should contain one item

    @test Check if CIRCQ is full

    @post isFull should be set to Zero

    @functional     Yes

    @type           Neg

    @trace #BRCM_SWREQ_CIRCQ_CONFIGURATION
*/
#define BRCM_SWQTST_CIRCQ_PUSH_ISFULL                         (0x108UL)

/**
    @brief push one item into the empty CIRCQ

    @pre CIRCQ should contain one item

    @test Check CIRCQ filled size

    @post getFilledSize should be set to One

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_CIRCQ_CONFIGURATION
*/
#define BRCM_SWQTST_CIRCQ_PUSH_GETFILLEDSIZE                  (0x109UL)

/**
    @brief push one item into the empty CIRCQ

    @pre CIRCQ should contain one item

    @test push one item into the CIRCQ

    @post Peek should return the pushed item

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_CIRCQ_CONFIGURATION
*/
#define BRCM_SWQTST_CIRCQ_PUSH_PEEK                           (0x10AUL)

/**
    @brief Pop the item from the CIRCQ

    @pre CIRCQ should contain one item

    @test Pop one item from the CIRCQ

    @post CIRCQ should become empty

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_CIRCQ_CONFIGURATION
*/
#define BRCM_SWQTST_CIRCQ_PUSH_POP                            (0x10BUL)

/**
    @brief Pop the item from the CIRCQ

    @pre CIRCQ has no item

    @test Check if CIRCQ is empty

    @post isEmpty should be set to One

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_CIRCQ_CONFIGURATION
*/
#define BRCM_SWQTST_CIRCQ_PUSH_POP_ISEMPTY                    (0x10CUL)

/**
    @brief Pop the item from the CIRCQ

    @pre CIRCQ has no item

    @test Check if CIRCQ is full

    @post isFull should be set to Zero

    @functional     Yes

    @type           Neg

    @trace #BRCM_SWREQ_CIRCQ_CONFIGURATION
*/
#define BRCM_SWQTST_CIRCQ_PUSH_POP_ISFULL                     (0x10DUL)

/**
    @brief Pop the item from the CIRCQ

    @pre CIRCQ has no item

    @test Check CIRCQ filled size

    @post getFilledSize should return Zero

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_CIRCQ_CONFIGURATION
*/
#define BRCM_SWQTST_CIRCQ_PUSH_POP_GETFILLEDSIZE              (0x10EUL)

/**
    @brief Pop the item from the CIRCQ

    @pre CIRCQ has no item

    @test Pop one item from the CIRCQ

    @post Peek should return CIRCQ is Empty

    @functional     Yes

    @type           Neg

    @trace #BRCM_SWREQ_CIRCQ_CONFIGURATION
*/
#define BRCM_SWQTST_CIRCQ_PUSH_POP_PEEK                       (0x10FUL)

/**
    @brief Pop one item from the CIRCQ

    @pre CIRCQ is empty

    @test Pop one item from the CIRCQ

    @post Pop should return CIRCQ is empty

    @functional     Yes

    @type           Neg

    @trace #BRCM_SWREQ_CIRCQ_CONFIGURATION
*/
#define BRCM_SWQTST_CIRCQ_PUSH_POP_POP                        (0x110UL)

/**
    @brief Push one item into the CIRCQ

    @pre CIRCQ is empty

    @test Push one item into the CIRCQ

    @post CIRCQ should contain one item

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_CIRCQ_CONFIGURATION
*/
#define BRCM_SWQTST_CIRCQ_PUSH_POP_PUSH                       (0x111UL)

/**
    @brief Push one item into the CIRCQ

    @pre CIRCQ has one item

    @test Check if CIRCQ is empty

    @post isEmpty should be set to Zero

    @functional     Yes

    @type           Neg

    @trace #BRCM_SWREQ_CIRCQ_CONFIGURATION
*/
#define BRCM_SWQTST_CIRCQ_PUSH_POP_PUSH_ISEMPTY               (0x112UL)

/**
    @brief Push one item into the CIRCQ

    @pre CIRCQ has one item

    @test Check if CIRCQ is full

    @post isFull should be set to Zero

    @functional     Yes

    @type           Neg

    @trace #BRCM_SWREQ_CIRCQ_CONFIGURATION
*/
#define BRCM_SWQTST_CIRCQ_PUSH_POP_PUSH_ISFULL                (0x113UL)

/**
    @brief Push one item into the CIRCQ

    @pre CIRCQ has one item

    @test Check CIRCQ filled size

    @post getFilledSize should return One

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_CIRCQ_CONFIGURATION
*/
#define BRCM_SWQTST_CIRCQ_PUSH_POP_PUSH_GETFILLEDSIZE         (0x114UL)

/**
    @brief Push one item into the CIRCQ

    @pre CIRCQ has one item

    @test Push one item into the CIRCQ

    @post Peek should return the second item pushed

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_CIRCQ_CONFIGURATION
*/
#define BRCM_SWQTST_CIRCQ_PUSH_POP_PUSH_PEEK                  (0x115UL)

/**
    @brief Push one more item into the CIRCQ

    @pre CIRCQ has one item

    @test Push another item into the CIRCQ

    @post CIRCQ should contain two items

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_CIRCQ_CONFIGURATION
*/
#define BRCM_SWQTST_CIRCQ_PUSH_POP_PUSH_PUSH                  (0x116UL)

/**
    @brief Push one more item into the CIRCQ

    @pre CIRCQ has two item

    @test Check if CIRCQ is empty

    @post isEmpty should be set to Zero

    @functional     Yes

    @type           Neg

    @trace #BRCM_SWREQ_CIRCQ_CONFIGURATION
*/
#define BRCM_SWQTST_CIRCQ_PUSH_POP_PUSH_PUSH_ISEMPTY          (0x117UL)

/**
    @brief Push one more item into the CIRCQ

    @pre CIRCQ has two item

    @test Check if CIRCQ is full

    @post isFull should be set to Zero

    @functional     Yes

    @type           Neg

    @trace #BRCM_SWREQ_CIRCQ_CONFIGURATION
*/
#define BRCM_SWQTST_CIRCQ_PUSH_POP_PUSH_PUSH_ISFULL           (0x118UL)

/**
    @brief Push one more item into the CIRCQ

    @pre CIRCQ has two item

    @test Check CIRCQ filled size

    @post getFilledSize should return Two

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_CIRCQ_CONFIGURATION
*/
#define BRCM_SWQTST_CIRCQ_PUSH_POP_PUSH_PUSH_GETFILLEDSIZE    (0x119UL)

/**
    @brief Push one more item into the CIRCQ

    @pre CIRCQ has two item

    @test Push another item into the CIRCQ

    @post Peek should return the two items from the CIRCQ

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_CIRCQ_CONFIGURATION
*/
#define BRCM_SWQTST_CIRCQ_PUSH_POP_PUSH_PUSH_PEEK             (0x11AUL)

/**
    @brief Pop one item from the CIRCQ

    @pre CIRCQ has two item

    @test Pop one item from the CIRCQ

    @post CIRCQ should contain one item

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_CIRCQ_CONFIGURATION
*/
#define BRCM_SWQTST_CIRCQ_PUSH_POP_PUSH_PUSH_POP              (0x11BUL)

/**
    @brief Pop one item from the CIRCQ

    @pre CIRCQ has one item

    @test Pop one item from the CIRCQ

    @post CIRCQ should be empty

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_CIRCQ_CONFIGURATION
*/
#define BRCM_SWQTST_CIRCQ_PUSH_POP_PUSH_POP                   (0x11CUL)

/**
    @brief Pop one item from the CIRCQ

    @pre CIRCQ is empty

    @test Check if CIRCQ is empty

    @post isEmpty should be set to One

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_CIRCQ_CONFIGURATION
*/
#define BRCM_SWQTST_CIRCQ_PUSH_POP_PUSH_POP_ISEMPTY           (0x11DUL)

/**
    @brief Pop one item from the CIRCQ

    @pre CIRCQ is empty

    @test Check if CIRCQ is full

    @post isFull should be set to Zero

    @functional     Yes

    @type           Neg

    @trace #BRCM_SWREQ_CIRCQ_CONFIGURATION
*/
#define BRCM_SWQTST_CIRCQ_PUSH_POP_PUSH_POP_ISFULL            (0x11EUL)

/**
    @brief Pop one item from the CIRCQ

    @pre CIRCQ is empty

    @test Check CIRCQ filled size

    @post getFilledSize should return Zero

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_CIRCQ_CONFIGURATION
*/
#define BRCM_SWQTST_CIRCQ_PUSH_POP_PUSH_POP_GETFILLEDSIZE     (0x11FUL)

/**
    @brief Pop one item from the CIRCQ

    @pre CIRCQ is empty

    @test Pop one item from the CIRCQ

    @post Peek should return CIRCQ is empty

    @functional     Yes

    @type           Neg

    @trace #BRCM_SWREQ_CIRCQ_CONFIGURATION
*/
#define BRCM_SWQTST_CIRCQ_PUSH_POP_PUSH_POP_PEEK              (0x120UL)

/**
    @brief Push all the items into the CIRCQ to the maximum Size of CIRCQ

    @pre CIRCQ is Empty

    @test Push all the items into the CIRCQ

    @post CIRCQ should become full

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_CIRCQ_CONFIGURATION
*/
#define BRCM_SWQTST_CIRCQ_FULL                                (0x121UL)

/**
    @brief Push all the items into the CIRCQ to the maximum Size of CIRCQ

    @pre CIRCQ is Empty

    @test Check if CIRCQ is empty

    @post isEmpty should be set to Zero

    @functional     Yes

    @type           Neg

    @trace #BRCM_SWREQ_CIRCQ_CONFIGURATION
*/
#define BRCM_SWQTST_CIRCQ_FULL_ISEMPTY                        (0x122UL)

/**
    @brief Push all the items into the CIRCQ to the maximum Size of CIRCQ

    @pre CIRCQ is Empty

    @test Check if CIRCQ is full

    @post isFull should be set to One

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_CIRCQ_CONFIGURATION
*/
#define BRCM_SWQTST_CIRCQ_FULL_ISFULL                         (0x123UL)

/**
    @brief Push all the items into the CIRCQ to the maximum Size of CIRCQ

    @pre CIRCQ is Empty

    @test Check CIRCQ filled size

    @post getFilledSize should return maximum size of CIRCQ

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_CIRCQ_CONFIGURATION
*/
#define BRCM_SWQTST_CIRCQ_FULL_GETFILLEDSIZE                  (0x124UL)

/**
    @brief Push all the items into the CIRCQ to the maximum size of CIRCQ

    @pre CIRCQ is Empty

    @test Push all the items into the CIRCQ

    @post Peek should return all the items from the CIRCQ

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_CIRCQ_CONFIGURATION
*/
#define BRCM_SWQTST_CIRCQ_FULL_PEEK                           (0x125UL)

/**
    @brief Push all the items into the CIRCQ to the maximum size of CIRCQ

    @pre CIRCQ is Empty

    @test Push all the items into the CIRCQ

    @post Push should return BCM_ERR_NOMEM

    @functional     Yes

    @type           Neg

    @trace #BRCM_SWREQ_CIRCQ_CONFIGURATION
*/
#define BRCM_SWQTST_CIRCQ_FULL_PUSH                           (0x126UL)

/**
    @brief Pop one item from the full CIRCQ

    @pre CIRCQ is Full

    @test Pop one item from the CIRCQ

    @post One item should get reduced from CIRCQ

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_CIRCQ_CONFIGURATION
*/
#define BRCM_SWQTST_CIRCQ_FULL_POP                            (0x127UL)

/**
    @brief Pop one item from the full CIRCQ

    @pre CIRCQ is Full

    @test Check if CIRCQ is empty

    @post isEmpty should be set to Zero

    @functional     Yes

    @type           Neg

    @trace #BRCM_SWREQ_CIRCQ_CONFIGURATION
*/
#define BRCM_SWQTST_CIRCQ_FULL_POP_ISEMPTY                    (0x128UL)

/**
    @brief Pop one item from the full CIRCQ

    @pre CIRCQ is Full

    @test Check if CIRCQ is full

    @post isFull should be set to Zero

    @functional     Yes

    @type           Neg

    @trace #BRCM_SWREQ_CIRCQ_CONFIGURATION
*/
#define BRCM_SWQTST_CIRCQ_FULL_POP_ISFULL                     (0x129UL)

/**
    @brief Pop one item from the full CIRCQ

    @pre CIRCQ is Full

    @test Check CIRCQ filled size

    @post getFilledSize should return maximum size of CIRCQ-1

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_CIRCQ_CONFIGURATION
*/
#define BRCM_SWQTST_CIRCQ_FULL_POP_GETFILLEDSIZE              (0x12AUL)

/**
    @brief Pop one item from the full CIRCQ

    @pre CIRCQ is Full

    @test Pop one item from the CIRCQ

    @post Peek should return all the remaining items from the CIRCQ

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_CIRCQ_CONFIGURATION
*/
#define BRCM_SWQTST_CIRCQ_FULL_POP_PEEK                       (0x12BUL)

/**
    @brief Push one item into the CIRCQ

    @pre CIRCQ is having (maximum_size-1) number of items

    @test Push one item into the CIRCQ

    @post CIRCQ should become full

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_CIRCQ_CONFIGURATION
*/
#define BRCM_SWQTST_CIRCQ_FULL_POP_PUSH                       (0x12CUL)

/**
    @brief Pop all the items from the CIRCQ

    @pre CIRCQ is Full

    @test Pop all the items from the CIRCQ

    @post CIRCQ should become empty

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_CIRCQ_CONFIGURATION
*/
#define BRCM_SWQTST_CIRCQ_FULL_POP_ALL_ITEMS                  (0x12DUL)

/**
    @brief Pop all the items from the CIRCQ

    @pre CIRCQ is Full

    @test Check if CIRCQ is empty

    @post isEmpty should be set to One

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_CIRCQ_CONFIGURATION
*/
#define BRCM_SWQTST_CIRCQ_FULL_POP_ALL_ITEMS_ISEMPTY          (0x12EUL)

/**
    @brief Pop all the items from the CIRCQ

    @pre CIRCQ is Full

    @test Check if CIRCQ is full

    @post isFull should be set to Zero

    @functional     Yes

    @type           Neg

    @trace #BRCM_SWREQ_CIRCQ_CONFIGURATION
*/
#define BRCM_SWQTST_CIRCQ_FULL_POP_ALL_ITEMS_ISFULL           (0x12FUL)

/**
    @brief Pop all the items from the CIRCQ

    @pre CIRCQ is Full

    @test Check CIRCQ filled size

    @post getFilledSize should return Zero

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_CIRCQ_CONFIGURATION
*/
#define BRCM_SWQTST_CIRCQ_FULL_POP_ALL_ITEMS_GETFILLEDSIZE    (0x130UL)

/**
    @brief Pop all the items from the CIRCQ

    @pre CIRCQ is Full

    @test Pop all the items from the CIRCQ

    @post Peek should return CIRCQ is empty

    @functional     Yes

    @type           Neg

    @trace #BRCM_SWREQ_CIRCQ_CONFIGURATION
*/
#define BRCM_SWQTST_CIRCQ_FULL_POP_ALL_ITEMS_PEEK             (0x131UL)

/**
    @brief Pop all the items from the CIRCQ

    @pre CIRCQ is Full

    @test Pop all the items from the CIRCQ

    @post Pop should return CIRCQ is empty

    @functional     Yes

    @type           Neg

    @trace #BRCM_SWREQ_CIRCQ_CONFIGURATION
*/
#define BRCM_SWQTST_CIRCQ_FULL_POP_ALL_ITEMS_POP              (0x132UL)

/**
    @brief Push one item into the CIRCQ for checking reset

    @pre CIRCQ is Empty

    @test Push one item into the CIRCQ

    @post CIRCQ has one item

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_CIRCQ_CONFIGURATION
*/
#define BRCM_SWQTST_CIRCQ_PUSH_RESET                          (0x133UL)

/**
    @brief Reset the CIRCQ

    @pre CIRCQ has one item

    @test Reset the CIRCQ

    @post CIRCQ should become empty

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_CIRCQ_CONFIGURATION
*/
#define BRCM_SWQTST_CIRCQ_RESET                               (0x134UL)

/**
    @brief Push one item into the CIRCQ and Reset the CIRCQ

    @pre CIRCQ is Empty

    @test Check if CIRCQ is empty

    @post isEmpty should be set to One

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_CIRCQ_CONFIGURATION
*/
#define BRCM_SWQTST_CIRCQ_RESET_ISEMPTY                       (0x135UL)

/**
    @brief Push one item into the CIRCQ and Reset the CIRCQ

    @pre CIRCQ is Empty

    @test Check if CIRCQ is full

    @post isFull should be set to Zero

    @functional     Yes

    @type           Neg

    @trace #BRCM_SWREQ_CIRCQ_CONFIGURATION
*/
#define BRCM_SWQTST_CIRCQ_RESET_ISFULL                        (0x136UL)

/**
    @brief Push one item into the CIRCQ and Reset the CIRCQ

    @pre CIRCQ is Empty

    @test Check CIRCQ filled size

    @post getFilledSize should return Zero

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_CIRCQ_CONFIGURATION
*/
#define BRCM_SWQTST_CIRCQ_RESET_GETFILLEDSIZE                 (0x137UL)

/**
    @brief Push one item into the CIRCQ and Reset the CIRCQ

    @pre CIRCQ is Empty

    @test Push one item and reset the CIRCQ

    @post Peek should return CIRCQ is Empty

    @functional     Yes

    @type           Neg

    @trace #BRCM_SWREQ_CIRCQ_CONFIGURATION
*/
#define BRCM_SWQTST_CIRCQ_RESET_PEEK                          (0x138UL)

/**
    @brief Push one item into the CIRCQ and Reset the CIRCQ

    @pre CIRCQ is Empty

    @test Push one item and reset the CIRCQ

    @post Pop should return CIRCQ is empty

    @functional     Yes

    @type           Neg

    @trace #BRCM_SWREQ_CIRCQ_CONFIGURATION
*/
#define BRCM_SWQTST_CIRCQ_RESET_POP                           (0x139UL)

/** @brief CIRCQ Test sequence

    Detailed description of BRCM_SWQTSEQ_CIRCQ_SEQ0

    @code{.c}

    CIRCQ_V2_DEFINE()

        CIRCQ_IsEmpty() should be Set to One       #BRCM_SWQTST_CIRCQ_INIT_ISEMPTY

        CIRCQ_IsFull() should be set to 0U          #BRCM_SWQTST_CIRCQ_INIT_ISFULL

        CIRCQ_GetFilledSize() should return 0U
                                             #BRCM_SWQTST_CIRCQ_INIT_GETFILLEDSIZE

        CIRCQ_Peek() should return CIRCQ is empty     #BRCM_SWQTST_CIRCQ_INIT_PEEK

        CIRCQ_Pop() should return CIRCQ is empty       #BRCM_SWQTST_CIRCQ_INIT_POP

    CIRCQ_Push() CIRCQ should contain one item             #BRCM_SWQTST_CIRCQ_PUSH

        CIRCQ_IsEmpty() should be set to One       #BRCM_SWQTST_CIRCQ_PUSH_ISEMPTY

        CIRCQ_IsFull() should be set to 0U          #BRCM_SWQTST_CIRCQ_PUSH_ISFULL

        CIRCQ_GetFilledSize() should return 1U
                                             #BRCM_SWQTST_CIRCQ_PUSH_GETFILLEDSIZE

        CIRCQ_Peek() should return the item.          #BRCM_SWQTST_CIRCQ_PUSH_PEEK

    CIRCQ_Pop() CIRCQ should become empty              #BRCM_SWQTST_CIRCQ_PUSH_POP

        CIRCQ_IsEmpty() should be set to One
                                               #BRCM_SWQTST_CIRCQ_PUSH_POP_ISEMPTY

        CIRCQ_IsFull() should be set to Zero    #BRCM_SWQTST_CIRCQ_PUSH_POP_ISFULL

        CIRCQ_GetFilledSize() should be return Zero
                                         #BRCM_SWQTST_CIRCQ_PUSH_POP_GETFILLEDSIZE

        CIRCQ_Peek() should return CIRCQ is Empty
                                                  #BRCM_SWQTST_CIRCQ_PUSH_POP_PEEK

        CIRCQ_Pop() should return CIRCQ is empty
                                                   #BRCM_SWQTST_CIRCQ_PUSH_POP_POP

    CIRCQ_Push() CIRCQ should contain one item    #BRCM_SWQTST_CIRCQ_PUSH_POP_PUSH

        CIRCQ_IsEmpty() should be set to Zero
                                          #BRCM_SWQTST_CIRCQ_PUSH_POP_PUSH_ISEMPTY

        CIRCQ_IsFull() should be set to Zero
                                           #BRCM_SWQTST_CIRCQ_PUSH_POP_PUSH_ISFULL

        CIRCQ_GetFilledSize() should return One
                                    #BRCM_SWQTST_CIRCQ_PUSH_POP_PUSH_GETFILLEDSIZE

        CIRCQ_Peek() should return the item
                                             #BRCM_SWQTST_CIRCQ_PUSH_POP_PUSH_PEEK

    CIRCQ_Push() CIRCQ should contain two items
                                             #BRCM_SWQTST_CIRCQ_PUSH_POP_PUSH_PUSH

        CIRCQ_IsEmpty() should be set to Zero
                                     #BRCM_SWQTST_CIRCQ_PUSH_POP_PUSH_PUSH_ISEMPTY

        CIRCQ_IsFull() should be set to Zero
                                      #BRCM_SWQTST_CIRCQ_PUSH_POP_PUSH_PUSH_ISFULL

        CIRCQ_GetFilledSize() should return Two
                               #BRCM_SWQTST_CIRCQ_PUSH_POP_PUSH_PUSH_GETFILLEDSIZE

        CIRCQ_Peek() should return the two items
                                        #BRCM_SWQTST_CIRCQ_PUSH_POP_PUSH_PUSH_PEEK

        CIRCQ_Pop() should return true.
                                         #BRCM_SWQTST_CIRCQ_PUSH_POP_PUSH_PUSH_POP

    CIRCQ_Pop() CIRCQ should become empty     #BRCM_SWQTST_CIRCQ_PUSH_POP_PUSH_POP

        CIRCQ_IsEmpty() should be set to One
                                      #BRCM_SWQTST_CIRCQ_PUSH_POP_PUSH_POP_ISEMPTY

        CIRCQ_IsFull() should be Zero
                                       #BRCM_SWQTST_CIRCQ_PUSH_POP_PUSH_POP_ISFULL

        CIRCQ_GetFilledSize() should return Zero
                                #BRCM_SWQTST_CIRCQ_PUSH_POP_PUSH_POP_GETFILLEDSIZE

        CIRCQ_Peek() should return false.
                                         #BRCM_SWQTST_CIRCQ_PUSH_POP_PUSH_POP_PEEK

    CIRCQ_Push() CIRCQ should become full                  #BRCM_SWQTST_CIRCQ_FULL

        CIRCQ_IsEmpty() should be set to Zero      #BRCM_SWQTST_CIRCQ_FULL_ISEMPTY

        CIRCQ_IsFull() should be set to One         #BRCM_SWQTST_CIRCQ_FULL_ISFULL

        CIRCQ_GetFilledSize() should return Maximum CIRCQ Size
                                             #BRCM_SWQTST_CIRCQ_FULL_GETFILLEDSIZE

        CIRCQ_Peek() should return all the items      #BRCM_SWQTST_CIRCQ_FULL_PEEK

        CIRCQ_Push() should return BCM_ERR_NOMEM.     #BRCM_SWQTST_CIRCQ_FULL_PUSH

    CIRCQ_Pop() Pop one item from the CIRCQ            #BRCM_SWQTST_CIRCQ_FULL_POP

        CIRCQ_IsEmpty() should be set to Zero
                                               #BRCM_SWQTST_CIRCQ_FULL_POP_ISEMPTY

        CIRCQ_IsFull() should be set to Zero    #BRCM_SWQTST_CIRCQ_FULL_POP_ISFULL

        CIRCQ_GetFilledSize() should return Maximum CIRCQ Size-1
                                         #BRCM_SWQTST_CIRCQ_FULL_POP_GETFILLEDSIZE

        CIRCQ_Peek() should return all the remaining items
                                                  #BRCM_SWQTST_CIRCQ_FULL_POP_PEEK

        CIRCQ_Push() CIRCQ should become full     #BRCM_SWQTST_CIRCQ_FULL_POP_PUSH

    CIRCQ_Pop() pop all the items, CIRCQ should become empty
                                             #BRCM_SWQTST_CIRCQ_FULL_POP_ALL_ITEMS

        CIRCQ_IsEmpty() should be set to One
                                     #BRCM_SWQTST_CIRCQ_FULL_POP_ALL_ITEMS_ISEMPTY

        CIRCQ_IsFull() should be set to Zero
                                      #BRCM_SWQTST_CIRCQ_FULL_POP_ALL_ITEMS_ISFULL

        CIRCQ_GetFilledSize() should return Zero
                               #BRCM_SWQTST_CIRCQ_FULL_POP_ALL_ITEMS_GETFILLEDSIZE

        CIRCQ_Peek() should return CIRCQ is empty
                                        #BRCM_SWQTST_CIRCQ_FULL_POP_ALL_ITEMS_PEEK

        CIRCQ_Pop() should return CIRCQ is empty.
                                         #BRCM_SWQTST_CIRCQ_FULL_POP_ALL_ITEMS_POP

    CIRCQ_Push() CIRCQ should have one item          #BRCM_SWQTST_CIRCQ_PUSH_RESET

    CIRCQ_Reset() CIRCQ should be empty                   #BRCM_SWQTST_CIRCQ_RESET

        CIRCQ_IsEmpty() should be set to One      #BRCM_SWQTST_CIRCQ_RESET_ISEMPTY

        CIRCQ_IsFull() should be set to Zero       #BRCM_SWQTST_CIRCQ_RESET_ISFULL

        CIRCQ_GetFilledSize() should be set to Zero
                                            #BRCM_SWQTST_CIRCQ_RESET_GETFILLEDSIZE

        CIRCQ_Peek() should return CIRCQ is empty    #BRCM_SWQTST_CIRCQ_RESET_PEEK

        CIRCQ_Pop() should return CIRCQ is empty.     #BRCM_SWQTST_CIRCQ_RESET_POP

    @endcode

    @board board1
    @board board2

    @auto           Yes

    @type           Sanity

    @testproc #BRCM_SWQTST_CIRCQ_INIT_ISEMPTY
    @testproc #BRCM_SWQTST_CIRCQ_INIT_ISFULL
    @testproc #BRCM_SWQTST_CIRCQ_INIT_GETFILLEDSIZE
    @testproc #BRCM_SWQTST_CIRCQ_INIT_PEEK
    @testproc #BRCM_SWQTST_CIRCQ_INIT_POP
    @testproc #BRCM_SWQTST_CIRCQ_PUSH
    @testproc #BRCM_SWQTST_CIRCQ_PUSH_ISEMPTY
    @testproc #BRCM_SWQTST_CIRCQ_PUSH_ISFULL
    @testproc #BRCM_SWQTST_CIRCQ_PUSH_GETFILLEDSIZE
    @testproc #BRCM_SWQTST_CIRCQ_PUSH_PEEK
    @testproc #BRCM_SWQTST_CIRCQ_PUSH_POP
    @testproc #BRCM_SWQTST_CIRCQ_PUSH_POP_ISEMPTY
    @testproc #BRCM_SWQTST_CIRCQ_PUSH_POP_ISFULL
    @testproc #BRCM_SWQTST_CIRCQ_PUSH_POP_GETFILLEDSIZE
    @testproc #BRCM_SWQTST_CIRCQ_PUSH_POP_PEEK
    @testproc #BRCM_SWQTST_CIRCQ_PUSH_POP_POP
    @testproc #BRCM_SWQTST_CIRCQ_PUSH_POP_PUSH
    @testproc #BRCM_SWQTST_CIRCQ_PUSH_POP_PUSH_ISEMPTY
    @testproc #BRCM_SWQTST_CIRCQ_PUSH_POP_PUSH_ISFULL
    @testproc #BRCM_SWQTST_CIRCQ_PUSH_POP_PUSH_GETFILLEDSIZE
    @testproc #BRCM_SWQTST_CIRCQ_PUSH_POP_PUSH_PEEK
    @testproc #BRCM_SWQTST_CIRCQ_PUSH_POP_PUSH_PUSH
    @testproc #BRCM_SWQTST_CIRCQ_PUSH_POP_PUSH_PUSH_ISEMPTY
    @testproc #BRCM_SWQTST_CIRCQ_PUSH_POP_PUSH_PUSH_ISFULL
    @testproc #BRCM_SWQTST_CIRCQ_PUSH_POP_PUSH_PUSH_GETFILLEDSIZE
    @testproc #BRCM_SWQTST_CIRCQ_PUSH_POP_PUSH_PUSH_PEEK
    @testproc #BRCM_SWQTST_CIRCQ_PUSH_POP_PUSH_PUSH_POP
    @testproc #BRCM_SWQTST_CIRCQ_PUSH_POP_PUSH_POP
    @testproc #BRCM_SWQTST_CIRCQ_PUSH_POP_PUSH_POP_ISEMPTY
    @testproc #BRCM_SWQTST_CIRCQ_PUSH_POP_PUSH_POP_ISFULL
    @testproc #BRCM_SWQTST_CIRCQ_PUSH_POP_PUSH_POP_GETFILLEDSIZE
    @testproc #BRCM_SWQTST_CIRCQ_PUSH_POP_PUSH_POP_PEEK
    @testproc #BRCM_SWQTST_CIRCQ_FULL
    @testproc #BRCM_SWQTST_CIRCQ_FULL_ISEMPTY
    @testproc #BRCM_SWQTST_CIRCQ_FULL_ISFULL
    @testproc #BRCM_SWQTST_CIRCQ_FULL_GETFILLEDSIZE
    @testproc #BRCM_SWQTST_CIRCQ_FULL_PEEK
    @testproc #BRCM_SWQTST_CIRCQ_FULL_PUSH
    @testproc #BRCM_SWQTST_CIRCQ_FULL_POP
    @testproc #BRCM_SWQTST_CIRCQ_FULL_POP_ISEMPTY
    @testproc #BRCM_SWQTST_CIRCQ_FULL_POP_ISFULL
    @testproc #BRCM_SWQTST_CIRCQ_FULL_POP_GETFILLEDSIZE
    @testproc #BRCM_SWQTST_CIRCQ_FULL_POP_PEEK
    @testproc #BRCM_SWQTST_CIRCQ_FULL_POP_PUSH
    @testproc #BRCM_SWQTST_CIRCQ_FULL_POP_ALL_ITEMS
    @testproc #BRCM_SWQTST_CIRCQ_FULL_POP_ALL_ITEMS_ISEMPTY
    @testproc #BRCM_SWQTST_CIRCQ_FULL_POP_ALL_ITEMS_ISFULL
    @testproc #BRCM_SWQTST_CIRCQ_FULL_POP_ALL_ITEMS_GETFILLEDSIZE
    @testproc #BRCM_SWQTST_CIRCQ_FULL_POP_ALL_ITEMS_PEEK
    @testproc #BRCM_SWQTST_CIRCQ_FULL_POP_ALL_ITEMS_POP
    @testproc #BRCM_SWQTST_CIRCQ_PUSH_RESET
    @testproc #BRCM_SWQTST_CIRCQ_RESET
    @testproc #BRCM_SWQTST_CIRCQ_RESET_ISEMPTY
    @testproc #BRCM_SWQTST_CIRCQ_RESET_ISFULL
    @testproc #BRCM_SWQTST_CIRCQ_RESET_GETFILLEDSIZE
    @testproc #BRCM_SWQTST_CIRCQ_RESET_PEEK
    @testproc #BRCM_SWQTST_CIRCQ_RESET_POP

*/
#define BRCM_SWQTSEQ_CIRCQ_SEQ0                               (0x13AUL)

#endif /* CIRC_QUEUE_QT_H */

/** @} */