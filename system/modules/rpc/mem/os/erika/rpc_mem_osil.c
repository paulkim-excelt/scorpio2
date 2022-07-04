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
    @defgroup grp_rpc_v2_mem_osil_impl Integration Reference
    @ingroup grp_rpc_v2_mem

    @addtogroup grp_rpc_v2_mem_osil_impl
    @{

    @file rpc_mem_osil.c
    @brief This file implements RPC Memory OSIL functionality
    for the RPC Memory Lib

    @version 0.1 Initial version
*/

#include <rpc_mem_osil.h>

/**
    @name RPC Memory OSIL Design IDs
    @{
    @brief Design IDs for RPC Memory OSIL
*/
#define BRCM_SWDSGN_RPC_MEMSTREAMPOOL_GLOBAL    (0xE201U)    /**< @brief #RPC_MemStreamPool */
#define BRCM_SWDSGN_RPC_MEMMSGPOOL_GLOBAL       (0xE202U)    /**< @brief #RPC_MemMsgPool    */
#define BRCM_SWDSGN_RPC_MEMMSGSCRATCH_GLOBAL    (0xE203U)    /**< @brief #RPC_MemMsgScratch */
#define BRCM_SWDSGN_RPC_MEMORY_GLOBAL           (0xE204U)    /**< @brief #RPC_Memory        */
/** @} */

/**
    @brief RPC Stream Memory

    Stream Memory Pool for RPC Stream Data

    @trace #BRCM_SWARCH_RPC_MEM_GLOBAL
    @trace #BRCM_SWREQ_RPC_MEM
*/
static uint8_t RPC_MemStreamPool[RPC_MEM_STREAM_COUNT * RPC_MEM_STREAM_SIZE];

/**
    @brief Message Memory pool

	Message Memory Pool for RPC Messages

    @trace #BRCM_SWARCH_RPC_MEM_GLOBAL
    @trace #BRCM_SWREQ_RPC_MEM
*/
static RPC_MemMsgType RPC_MemMsgPool[RPC_MEM_MSG_COUNT];

/**
    @brief Scratch Memory

    @trace #BRCM_SWARCH_RPC_MEM_GLOBAL
    @trace #BRCM_SWREQ_RPC_MEM
*/
static RPC_MemMsgType RPC_MemMsgScratch;

/**
    @trace #BRCM_SWARCH_RPC_MEM_GLOBAL
    @trace #BRCM_SWREQ_RPC_MEM
*/
const RPC_MemoryType RPC_Memory = {
    .scratch = &RPC_MemMsgScratch,
    .msgPool = RPC_MemMsgPool,
    .msgCnt = RPC_MEM_MSG_COUNT,
    .strmPool = RPC_MemStreamPool,
    .strmSize = RPC_MEM_STREAM_SIZE,
    .strmCnt = RPC_MEM_STREAM_COUNT,
};
/** @} */
