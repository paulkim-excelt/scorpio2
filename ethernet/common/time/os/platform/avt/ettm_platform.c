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
    @defgroup grp_ethsrv_time_platform_avt Ethtime module platform for AVT based platforms
    @ingroup grp_ethsrv_time

    @addtogroup grp_ethsrv_time_platform_avt
    @{

    @file ettm_platform.c
    @brief This file implements platform layer for AVT based platforms

    @version 0.1 Initial draft
*/

#include <bcm_err.h>
#include <ettm_platform.h>
#include <avt.h>
#include <ethernet.h>

/**
    @name Ethernet Time module OSIL Design IDs
    @{
    @brief Design IDs for Ethernet Time module OSIL
*/
#define BRCM_SWDSGN_ETTM_CONFIG_GLOBAL             (0xB201U)    /**< @brief #ETTM_Config            */
#define BRCM_SWDSGN_ETTM_PLATFORMINITNONE_PROC     (0xB202U)    /**< @brief #ETTM_PlatformInitNone  */
#define BRCM_SWDSGN_ETTM_PLATFORMSYNCSLAVE_PROC    (0xB204U)    /**< @brief #ETTM_PlatformSyncSlave */
#define BRCM_SWDSGN_ETTM_PLATFORMMERGEHB_PROC      (0xB205U)    /**< @brief #ETTM_PlatformMergeHB   */
/** @} */

/**
    @trace #BRCM_SWREQ_ETTM_AVT
    @trace #BRCM_SWARCH_ETTM_GLOBAL
*/
const ETHER_TimeCfgType ETTM_Config = {
    .hwIdx = 0UL,
    .portEnableMask = 0x1UL,
    .sync = ETHER_TIMESYNC_NONE,
};

/**
    @trace #BRCM_SWARCH_ETTM_PLATFORMINITNONE_PROC
    @trace #BRCM_SWREQ_ETTM_AVT
*/
void ETTM_PlatformInitNone(uint64_t *const aTimeDiff)
{
    (void)AVT_Reset1588(aTimeDiff);
    /* Set ETHSRV_sys1588TimeDiff_ns to Zero, when Ethernet Time block uses heart beat
     * timer for Ethernet time calculation & as Heart beat timeer is already
     * synchronised with 1588 block. As System timer is currently used for Ethernet
     * time calculation, it will not be set to Zero.
     */
}

/**
    @trace #BRCM_SWARCH_ETTM_PLATFORMSYNCSLAVE_PROC
    @trace #BRCM_SWREQ_ETTM_AVT
*/

void ETTM_PlatformSyncSlave(ETTM_ContextType *const aContext)
{
}

/**
    @trace #BRCM_SWARCH_ETTM_PLATFORMMERGEHB_PROC
    @trace #BRCM_SWREQ_ETTM_AVT
*/
int32_t ETTM_PlatformMergeHB(void const *aInResponse1,
                                     void const *aInResponse2,
                                     void *aOutResponse)
{
    return BCM_ERR_NOSUPPORT;
}

/** @} */
