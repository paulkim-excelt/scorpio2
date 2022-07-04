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
    @defgroup grp_nif_platform Ether NIF module common platform common layer
    @ingroup grp_nif

    @addtogroup grp_nif_platform
    @{

    @file nif_cntrlr_platform.c
    @brief This file implements common platform layer for the ether module

    @version 0.1 Initial draft
*/

#include <stddef.h>
#include <inttypes.h>
#include <module.h>
#include <nif_cntrlr_platform.h>
#include "nif_cntrlr.h"
#include "ee_internal.h"

/**
    @name Ether module OSIL Design IDs
    @{
    @brief Design IDs for Ether module OSIL
*/
#define BRCM_SWDSGN_NIF_DEFAULTMACADDR_GLOBAL    (0xB602U)    /**< @brief #NIF_DefaultMacAddr */
#define BRCM_SWDSGN_NIF_GETSERVER_PROC           (0xB603U)    /**< @brief #NIF_GetServer */
/** @} */

/**
    @trace #BRCM_SWARCH_NIF_DEFAULTMACADDR_GLOBAL
    @trace #BRCM_SWREQ_NIF_CNTRLR
*/
const uint8_t NIF_DefaultMacAddr[] = {
#if defined(ENABLE_MAC0)
    0x02, 0x01, 0x02, 0x03, 0x04, 0x05
#elif defined(ENABLE_MAC1)
    0x02, 0xAA, 0xBB, 0xCC, 0xDD, 0xEE
#else
    0x02, 0xAA, 0xBB, 0xCC, 0xDD, 0x00
#endif
    };

/**
    @code{.unparsed}
    @endcode

    @trace #BRCM_SWARCH_NIF_DEFAULTMACADDR_GLOBAL
    @trace #BRCM_SWREQ_NIF_CNTRLR
*/
void NIF_GetServer(int32_t *aServerTask, uint32_t *aServerEvent)
{
    if (NULL != aServerTask) {
        *aServerTask = ETH_IRQ_PROCESS_TASK;
    }
    if (NULL != aServerEvent) {
        *aServerEvent = MODULE_Event;
    }
}

/** @} */
