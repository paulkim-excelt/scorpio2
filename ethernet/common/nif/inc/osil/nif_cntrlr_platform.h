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
    @defgroup grp_nif_platform_ifc NIF module Platform interface
    @ingroup grp_nif

    @addtogroup grp_nif_platform_ifc
    @{

    @limitations None

    @file nif_cntrlr_platform.h
    @brief Interface for Communication Subsystem Platform layer
    This header file contains the interfaces for Communication Subsystem Platform layer
    @version 0.1 Initial Version
 */

#ifndef NIF_CNTRLR_PLATFORM_H
#define NIF_CNTRLR_PLATFORM_H

#include <stdint.h>
#include <module.h>
#include <eth_osil.h>
#include <module_osil.h>

/**
    @name NIF Module IDs
    @{
    @brief Architecture API IDs for NIF module
*/
#define BRCM_SWARCH_NIF_SUBMODLIST_GLOBAL        (0x9101U)    /**< @brief #NIF_SubModList      */
#define BRCM_SWARCH_NIF_DEFAULTMACADDR_GLOBAL    (0x9102U)    /**< @brief #NIF_DefaultMacAddr  */
#define BRCM_SWARCH_NIF_CONFIG_GLOBAL            (0x9103U)    /**< @brief #NIF_Config          */
#define BRCM_SWARCH_NIF_RX_MAX_FRM_SIZE_MACRO    (0x9104U)    /**< @brief #NIF_RX_MAX_FRM_SIZE */
#define BRCM_SWARCH_NIF_GETSERVER_PROC           (0x9105U)    /**< @brief #NIF_GetServer       */
/** @} */

/**
    @brief Default MAC address for ethernet initialization

    @trace #BRCM_SWREQ_NIF_CNTRLR
 */
#define NIF_RX_MAX_FRM_SIZE    (1522UL)

/**
    @brief Default MAC address for ethernet NIF initialization

    @trace #BRCM_SWREQ_NIF_CNTRLR
 */
extern const uint8_t NIF_DefaultMacAddr[];

/**
    @brief NIF configuration for initialization

    @trace #BRCM_SWREQ_NIF_CNTRLR
 */
extern const ETHER_CfgType NIF_Config;

/** @brief API to return the Task and event for the NIF module

    @behavior Sync, Re-entrant

    @pre None

    @param[out]     aServerTask         Server task ID
    @param[out]     aServerEvent        Event mask

    Return values are documented in reverse-chronological order
    @retval       void

    @limitations None.

    @trace #BRCM_SWREQ_NIF_CNTRLR
*/
extern void NIF_GetServer(int32_t *aServerTask, uint32_t *aServerEvent);

#endif /* NIF_CNTRLR_PLATFORM_H */
/** @} */
