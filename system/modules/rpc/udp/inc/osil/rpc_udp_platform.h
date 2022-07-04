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
    @addtogroup grp_rpc_v2_udp_intf_il
    @{

    @file rpc_udp_platform.h
    @brief RPC platform specific routines

    @version 0.1 Initial Version
*/

#ifndef RPC_UDP_PLATFORM_H
#define RPC_UDP_PLATFORM_H

#include <stdint.h>

/**
    @name RPC Platform Architecture IDs
    @{
    @brief Architecture IDs for RPC Platform
*/
#define BRCM_SWARCH_RPC_PLATPARSEETHBOOTFILENAME_PROC    (0x9901U)    /**< @brief #RPC_PlatParseEthBootFileName */
/** @} */

/** @brief RPC platform specific parse filename received in TFTP request

    @behavior Sync, Re-entrant

    @param[in]      aFileName           Buffer containing the filename
    @param[in]      aFileNameLen        Length of the filename string
    @param[out]     aImgID              Image identifier
    @param[out]     aPID                Partition identifier
    @param[out]     aOffset             Offset in the image
    @param[out]     aTotalSize          Size of the image
    @param[out]     aIsImgTbl           Indicates whether the transfer
                                        is for an image or the image table

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             File name  parsed successfully
    @retval     #BCM_ERR_INVAL_PARAMS   Invalid file name string

    @trace #BRCM_SWREQ_RPC_INTERFACE_UDP

    @code{unparsed}
    @endcode
*/
int32_t RPC_PlatParseEthBootFileName(char*     aFileName,
                                     uint32_t  aFileNameLen,
                                     uint16_t* const aImgID,
                                     uint8_t*  const aPID,
                                     uint32_t* const aOffset,
                                     uint32_t* const aTotalSize,
                                     uint8_t*  const aIsImgTbl);

#endif /* RPC_UDP_PLATFORM_H */

/** @} */
