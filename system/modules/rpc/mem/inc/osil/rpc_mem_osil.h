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

/** @defgroup grp_rpc_v2_mem_il Integration Guide
    @ingroup grp_rpc_v2_mem

    @addtogroup grp_rpc_v2_mem_il
    @{

    @file rpc_mem_osil.h
    @brief RPC Memory Integration Interfaces
    This header file contains the integration interface for RPC Memory
    @version 1.0 Initial Version
*/

#ifndef RPC_MEM_OSIL_H
#define RPC_MEM_OSIL_H

#include <rpc_mem.h>

/**
    @name RPC Memory Integration Interface IDs
    @{
    @brief Integration Interface IDs for RPC Memory

*/
#define BRCM_SWARCH_RPC_MEM_TYPE      (0x9401U)    /**< @brief #RPC_MemoryType */
#define BRCM_SWARCH_RPC_MEM_GLOBAL    (0x9402U)    /**< @brief #RPC_Memory     */
/** @} */

/**
    @brief RPC Memory Type

    @trace #BRCM_SWREQ_RPC_MEM
*/
typedef struct sRPC_MemoryType {
    RPC_MemMsgType  *scratch;
    RPC_MemMsgType  *msgPool;
    uint32_t        msgCnt;
    uint8_t         *strmPool;
    uint32_t        strmSize;
    uint32_t        strmCnt;
} RPC_MemoryType;

/**
    @brief RPC Message

    @trace #BRCM_SWREQ_RPC_MEM
*/
extern const RPC_MemoryType RPC_Memory;

#endif /* RPC_MEM_OSIL_H */
/** @} */
