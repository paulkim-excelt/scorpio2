/*****************************************************************************
 Copyright 2022 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_wdg_osil_impl WatchDog OSIL Design
    @ingroup grp_wdg

    @addtogroup grp_wdg_osil_impl
    @{

    @file wdg_osil.c
    @brief Watchdog interface Design

    @version 0.1 Initial Version
*/
#include <wdg.h>
#include <base_app_cfg.h>

/**
    @name Component Design IDs
    @{
    @brief Design IDs for Component
*/
#define BRCM_SWDSGN_WDG_SE_ENTITYCOUNT_GLOBAL             (0xD201U)    /**< @brief #WDG_SeEntityCnt         */
#define BRCM_SWDSGN_WDG_SUPERVISIONENTITIES_GLOBAL        (0xD202U)    /**< @brief #WDG_SupervisionEntities */
/** @} */


#ifdef WDG_SUPERVISION_ENTITY_CNT
/**
    @brief WDG SE Count

    @trace #BRCM_SWARCH_WDG_SE_ENTITYCOUNT_GLOBAL
    @trace #BRCM_SWREQ_WDG
*/
const uint32_t WDG_SeEntityCnt = WDG_SUPERVISION_ENTITY_CNT;
#else
const uint32_t WDG_SeEntityCnt = 0UL;
#endif /* WDG_SUPERVISION_ENTITY_CNT */

#ifndef WDG_SUPERVISION_ENTITY_CNT
/**
    @brief WDG SE List

    @Note This is a Dummy Variable.
          This is to help the compilation on some platforms

    @trace #BRCM_SWARCH_WDG_SUPERVISIONENTITIES_GLOBAL
    @trace #BRCM_SWREQ_WDG
*/
const WDG_SEType WDG_SupervisionEntities[1UL];
#endif /* WDG_SUPERVISION_ENTITY_CNT */
/** @} */
