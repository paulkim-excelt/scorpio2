/*****************************************************************************
 Copyright 2021 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_rpc_v2_mem_qt Qualification Tests
    @ingroup grp_rpc_v2_mem

    @addtogroup grp_rpc_v2_mem_qt
    @{

    @file rpc_mem_qt.h
    @brief RPC Memory Qualification Test cases
    This source file contains the test cases for RPC Memory
    @version 0.1 Initial version
*/
#ifndef RPC_MEM_QT_H
#define RPC_MEM_QT_H

/**
    @brief RPC Memory Initialization

    @pre RPC Memory shall be in un-initialized state

    @test #BRCM_SWARCH_RPC_MEM_INIT_PROC should be invoked for
          initializing memory

    @post Memory should be initialised

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_RPC_MEM
*/
#define BRCM_SWQTST_RPC_MEM_INIT              (0x101UL)

/**
    @brief Get Scratch Message for temporary use

    @pre #BRCM_SWQTST_RPC_MEM_INIT

    @test #BRCM_SWARCH_RPC_MEM_INIT_PROC to be invoked
            to request for a temporary memory

    @post pointer to the scratch memory to be returned

    @functional     Yes

    @type           pos

    @trace #BRCM_SWREQ_RPC_MEM
*/
#define BRCM_SWQTST_RPC_MSG_SCRCH             (0x102UL)

/**
    @brief Allocate a Message Handle

    @pre #BRCM_SWQTST_RPC_MEM_INIT

    @test Invoke #BRCM_SWARCH_RPC_MSG_ALLOC_PROC
          to Allocate a new message Handle

    @post A New message Handle is allocated

    @functional     Yes

    @type           pos

    @trace #BRCM_SWREQ_RPC_MEM
*/
#define BRCM_SWQTST_RPC_MSG_ALLOC_NEWHDL      (0x103UL)

/**
    @brief Clone a Message Handle

    @pre #BRCM_SWQTST_RPC_MEM_INIT

    @test invoke #BRCM_SWARCH_RPC_MSG_ALLOC_PROC
          provide the message handle which already exists
          to clone a message Handle

    @post same message handle will be returned

    @functional     Yes

    @type           pos

    @trace #BRCM_SWREQ_RPC_MEM
*/
#define BRCM_SWQTST_RPC_MSG_ALLOC_CLONEHDL    (0x104UL)

/**
    @brief Memory Full for allocation

    @pre #BRCM_SWQTST_RPC_MEM_INIT
    @pre invoke #BRCM_SWQTST_RPC_MSG_ALLOC_NEWHDL till RPC_Memory.msgCnt
        And invoke again #BRCM_SWQTST_RPC_MSG_ALLOC_NEWHDL

    @test Memory is not available

    @post RPC_HDL_INVALID will be returned

    @functional     Yes

    @type           neg

    @trace #BRCM_SWREQ_RPC_MEM
*/
#define BRCM_SWQTST_RPC_MSG_ALLOC_NEG         (0x105UL)

/**
    @brief Get Message content for a handle

    @pre #BRCM_SWQTST_RPC_MEM_INIT
    @pre #BRCM_SWQTST_RPC_MSG_ALLOC_NEWHDL

    @test invoke #BRCM_SWARCH_RPC_MSG_GET_PROC
          to get the memory pointer for an Handle

    @post a memory pointer will be returned

    @functional     Yes

    @type           pos

    @trace #BRCM_SWREQ_RPC_MEM
*/
#define BRCM_SWQTST_RPC_MSG_GET_POS           (0x106UL)

/**
    @brief Get Message content for a handle

    @pre #BRCM_SWQTST_RPC_MEM_INIT

    @test invoke #BRCM_SWARCH_RPC_MSG_GET_PROC
          request memory pointer for unknown handle

    @post NULL returned

    @functional     Yes

    @type           neg

    @trace #BRCM_SWREQ_RPC_MEM
*/
#define BRCM_SWQTST_RPC_MSG_GET_NEG           (0x107UL)

/**
    @brief Allocate a Stream Handle

    @pre #BRCM_SWQTST_RPC_MEM_INIT

    @test Invoke #BRCM_SWARCH_RPC_STRM_ALLOC_PROC
          to Allocate a new Stream Handle

    @post A New Stream Handle is allocated

    @functional     Yes

    @type           pos

    @trace #BRCM_SWREQ_RPC_MEM
*/
#define BRCM_SWQTST_RPC_STRM_ALLOC            (0x10AUL)

/**
    @brief Get stream config

    @pre #BRCM_SWQTST_RPC_MEM_INIT

    @test Invoke #BRCM_SWARCH_RPC_STRM_GET_CFG_PROC
          To Get the stream configuration

    @post configuration will be retrieved

    @functional     Yes

    @type           pos

    @trace #BRCM_SWREQ_RPC_MEM
*/
#define BRCM_SWQTST_RPC_STRM_GET_CFG_POS      (0x10CUL)

/**
    @brief Get Free size for stream

    @pre #BRCM_SWQTST_RPC_MEM_INIT

    @test Invoke #BRCM_SWARCH_RPC_STRM_FREE_SZ_PROC
          To Get Free size

    @post remaining available Size and
          total written size are returned

    @functional     Yes

    @type           pos

    @trace #BRCM_SWREQ_RPC_MEM
*/
#define BRCM_SWQTST_RPC_STRM_FREE_SZ_POS      (0x10DUL)

/**
    @brief Get Filled size for stream

    @pre #BRCM_SWQTST_RPC_MEM_INIT

    @test Invoke #BRCM_SWARCH_RPC_STRM_FILLED_SZ_PROC
          To Get Filled size

    @post remaining available Size and
          total size read are returned

    @functional     Yes

    @type           pos

    @trace #BRCM_SWREQ_RPC_MEM
*/
#define BRCM_SWQTST_RPC_STRM_FILLED_SZ_POS    (0x10EUL)

/**
    @brief write Stream

    @pre #BRCM_SWQTST_RPC_MEM_INIT
    @pre #BRCM_SWQTST_RPC_STRM_ALLOC

    @test Invoke #BRCM_SWARCH_RPC_STRM_WRITE_PROC to write stream data

    @post write the data for stream handle

    @functional     Yes

    @type           pos

    @trace #BRCM_SWREQ_RPC_MEM
*/
#define BRCM_SWQTST_RPC_STRM_WRITE_POS        (0x10FUL)

/**
    @brief write Stream on Memory Full

    @pre #BRCM_SWQTST_RPC_MEM_INIT
    @pre #BRCM_SWQTST_RPC_STRM_ALLOC

    @test Invoke #BRCM_SWARCH_RPC_STRM_WRITE_PROC to write stream data
           It should not write anymore data in Memory

    @post write the data for stream handle

    @functional     Yes

    @type           pos

    @trace #BRCM_SWREQ_RPC_MEM
*/
#define BRCM_SWQTST_RPC_STRM_WRITE_NEG        (0x110UL)


/**
    @brief read stream

    @pre #BRCM_SWQTST_RPC_MEM_INIT
    @pre #BRCM_SWQTST_RPC_STRM_ALLOC

    @test Invoke #BRCM_SWARCH_RPC_STRM_READ_PROC To Read stream data

    @post Read the data from stream

    @functional     Yes

    @type           pos

    @trace #BRCM_SWREQ_RPC_MEM
*/
#define BRCM_SWQTST_RPC_STRM_READ             (0x111UL)


/**
    @brief acquire Message Handle

    @pre #BRCM_SWQTST_RPC_MEM_INIT
    @pre #BRCM_SWQTST_RPC_STRM_ALLOC

    @test Invoke #BRCM_SWARCH_RPC_STRM_READ_PROC to Acquire message Handle

    @post Message handle is acquired and reference count incremented

    @functional     Yes

    @type           pos

    @trace #BRCM_SWREQ_RPC_MEM
*/
#define BRCM_SWQTST_RPC_ACQUIRE               (0x112UL)


/**
    @brief release Message Handle

    @pre #BRCM_SWQTST_RPC_MEM_INIT
    @pre #BRCM_SWQTST_RPC_STRM_ALLOC

    @test Invoke #BRCM_SWARCH_RPC_RELEASE_PROC to Release Message Handle

    @post Message handle is released and reference count decremented

    @functional     Yes

    @type           pos

    @trace #BRCM_SWREQ_RPC_MEM
*/
#define BRCM_SWQTST_RPC_RELEASE               (0x113UL)

/**
    @brief RPC Memory Deinitialisation

    @pre #BRCM_SWQTST_RPC_MEM_INIT

    @test Invoke #BRCM_SWARCH_RPC_MEM_DEINIT_PROC to de-initialize the memory

    @post Channel should be deinitialised

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_RPC_MEM
*/
#define BRCM_SWQTST_RPC_MEM_DEINIT            (0x114UL)

/** @brief RPC memory Test sequence 0

    This sequence tests the operation of RPC Message Memory

    @code{.c}
    -# Initialise RPC memory through #BRCM_SWQTST_RPC_MEM_INIT <BR>
    -# Get the message for a Message Handle #BRCM_SWQTST_RPC_MSG_GET_NEG <BR>
    -# Allocate all available Message Handles #BRCM_SWQTST_RPC_MSG_ALLOC_NEWHDL <BR>
    -# Release all available Handles #BRCM_SWQTST_RPC_RELEASE <BR>
    -# Allocate a Message Handle #BRCM_SWQTST_RPC_MSG_ALLOC_NEWHDL <BR>
    -# Get the message for a Message Handle #BRCM_SWQTST_RPC_MSG_GET_POS <BR>
    -# Release Handle #BRCM_SWQTST_RPC_RELEASE <BR>
    -# Find the message #BRCM_SWQTST_RPC_MSG_GET_NEG <BR>
    -# De-initialize the RPC Memory #BRCM_SWQTST_RPC_MEM_DEINIT <BR>
    @endcode

    @board bcm8956x

    @auto           Yes

    @type           Sanity

    @executetime    2m

    @analyzetime    1d
*/
#define BRCM_SWQTSEQ_RPC_MEM_SEQ0             (0x115UL)

/** @brief RPC memory Test sequence 1

    This sequence tests the operation of RPC Stream memory

    @code{.c}
    -# Initialise RPC memory through #BRCM_SWQTST_RPC_MEM_INIT <BR>
    -# Allocate the stream Handle #BRCM_SWQTST_RPC_STRM_ALLOC <BR>
    -# Get Stream Config #BRCM_SWQTST_RPC_STRM_GET_CFG_POS <BR>
    -# Get Free size using valid handle #BRCM_SWQTST_RPC_STRM_FREE_SZ_POS <BR>
    -# Get Filled size using valid handle #BRCM_SWQTST_RPC_STRM_FILLED_SZ_POS <BR>
    -# Write the stream #BRCM_SWQTST_RPC_STRM_WRITE_POS <BR>
    -# Write the stream #BRCM_SWQTST_RPC_STRM_WRITE_POS <BR>
    -# Write the stream #BRCM_SWQTST_RPC_STRM_WRITE_NEG <BR>
    -# Read from stream #BRCM_SWQTST_RPC_STRM_READ <BR>
    -# Write the stream #BRCM_SWQTST_RPC_STRM_WRITE_POS <BR>
    -# Write the stream #BRCM_SWQTST_RPC_STRM_WRITE_NEG <BR>
    -# Read from stream #BRCM_SWQTST_RPC_STRM_READ <BR>
    -# Read from stream #BRCM_SWQTST_RPC_STRM_READ <BR>
    -# Write the stream #BRCM_SWQTST_RPC_STRM_WRITE_POS <BR>
    -# Read from stream #BRCM_SWQTST_RPC_STRM_READ <BR>
    -# Get Free size using valid handle #BRCM_SWQTST_RPC_STRM_FREE_SZ_POS <BR>
    -# Get Filled size using valid handle #BRCM_SWQTST_RPC_STRM_FILLED_SZ_POS <BR>
    -# Release Handle #BRCM_SWQTST_RPC_RELEASE <BR>
    -# De-initialize the RPC Memory #BRCM_SWQTST_RPC_MEM_DEINIT <BR>
    @endcode

    @board bcm8956x

    @auto           Yes

    @type           Sanity

    @executetime    2m

    @analyzetime    1d
*/
#define BRCM_SWQTSEQ_RPC_MEM_SEQ1             (0x1F0UL)

/** @brief RPC Test sequence 1

    This sequence tests the operation of RPC Stream memory

    @code{.c}
    -# Initialise RPC memory through #BRCM_SWQTST_RPC_MEM_INIT <BR>
    -# Allocate the stream Handle #BRCM_SWQTST_RPC_STRM_ALLOC <BR>
    -# Get Stream Config #BRCM_SWQTST_RPC_STRM_GET_CFG_POS <BR>
    -# Get Free size using valid handle #BRCM_SWQTST_RPC_STRM_FREE_SZ_POS <BR>
    -# Get Filled size using valid handle #BRCM_SWQTST_RPC_STRM_FILLED_SZ_POS <BR>
    -# Write the stream #BRCM_SWQTST_RPC_STRM_WRITE_POS <BR>
    -# Write the stream #BRCM_SWQTST_RPC_STRM_WRITE_POS <BR>
    -# Write the stream #BRCM_SWQTST_RPC_STRM_WRITE_NEG <BR>
    -# Read from stream #BRCM_SWQTST_RPC_STRM_READ <BR>
    -# Write the stream #BRCM_SWQTST_RPC_STRM_WRITE_POS <BR>
    -# Write the stream #BRCM_SWQTST_RPC_STRM_WRITE_NEG <BR>
    -# Read from stream #BRCM_SWQTST_RPC_STRM_READ <BR>
    -# Read from stream #BRCM_SWQTST_RPC_STRM_READ <BR>
    -# Write the stream #BRCM_SWQTST_RPC_STRM_WRITE_POS <BR>
    -# Read from stream #BRCM_SWQTST_RPC_STRM_READ <BR>
    -# Get Free size using valid handle #BRCM_SWQTST_RPC_STRM_FREE_SZ_POS <BR>
    -# Get Filled size using valid handle #BRCM_SWQTST_RPC_STRM_FILLED_SZ_POS <BR>
    -# Release Handle #BRCM_SWQTST_RPC_RELEASE <BR>
    -# De-initialize the RPC Memory #BRCM_SWQTST_RPC_MEM_DEINIT <BR>
    @endcode

    @board bcm8956x

    @auto           Yes

    @type           Sanity

    @executetime    1s

    @analyzetime    1d
*/

#define BRCM_SWQTSEQ_RPC_V2_SEQ1             (0x1F1UL)

#endif /* RPC_MEM_QT_H */
/** @} */
