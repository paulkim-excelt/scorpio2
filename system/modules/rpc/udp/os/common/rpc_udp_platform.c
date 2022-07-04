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
    @addtogroup grp_rpc_udp_master_ifc_impl
    @{
    @file rpc_udp_platform.c
    @brief RPC platform specific routines
    This source file contains the platform specific RPC routines
    @version 0.1 Initial version
*/

#include <string.h>
#include <bcm_err.h>
#include <bcm_utils.h>
#include <bcm_comp.h>
#include <rpc_udp_common.h>

/**
    @name RPC platform Design IDs
    @{
    @brief Design IDs for RPC platform
*/
#define BRCM_SWDSGN_RPC_PLATPARSEETHBOOTFILENAME_PROC   (0xA801U)    /**< @brief #RPC_PlatParseEthBootFileName */
/** @} */

/**
    @trace #BRCM_SWARCH_RPC_PLATPARSEETHBOOTFILENAME_PROC
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
                                     uint8_t*  const aIsImgTbl)
{
    int32_t  ret = BCM_ERR_INVAL_PARAMS;
#ifdef ENABLE_RPCV2_ETHERNET_BOOT_ROM_SUPPORT
    /* Expect a string like "bcm-<manuf(8)>-<model(8)>-<rev(8)>-<otpData(8)>.bin" from bcm8956x B0 - ROM*/
    if (0L == strncmp(aFileName, "bcm-", 4L) && (aFileNameLen == 43UL)) {
        /* Compare only the first 7 characters of the model to account for different chip flavours in the family */
        if (0L == strncmp(&aFileName[13U], CHIP_MODEL_NAME, 7L)) {
            /* ROM does not perform partial fetch */
            *aPID = 1U;
            *aImgID = 0U;
            *aOffset = 0UL;
            /* ROM does not ask for image table */
            *aIsImgTbl = 0U;
            /* Max size of bootloader expected by ROM */
            *aTotalSize = 0x20000UL;
            ret = BCM_ERR_OK;
        }
    }
#endif
    return ret;
}

/** @} */
