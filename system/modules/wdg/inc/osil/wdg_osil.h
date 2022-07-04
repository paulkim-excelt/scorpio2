/*****************************************************************************
 Copyright 2019-2022 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_wdg_il Integration Interfaces
    @ingroup grp_wdg

    @addtogroup grp_wdg_il
    @{

    @file wdg_osil.h
    @brief Integration Interface File
    This header file contains integration interface functions for watchdog
    @version 0.1 Initial Version
*/

#ifndef WDG_OSIL_H
#define WDG_OSIL_H

#include <stddef.h>
#include <module.h>
#include <wdg.h>

/**
    @name Watchdog Architecture IDs
    @{
    @brief Architecture IDs for Watchdog
*/
#define BRCM_SWARCH_WDG_SE_ENTITYCOUNT_GLOBAL       (0x9101U)  /**< @brief #WDG_SeEntityCnt          */
#define BRCM_SWARCH_WDG_SUPERVISIONENTITIES_GLOBAL  (0x9102U)  /**< @brief #WDG_SupervisionEntities  */
#define BRCM_SWARCH_WDG_MODULE_GLOBAL               (0x9103U)  /**< @brief #WDG_Module               */
/** @} */

/**
    @brief WDG SE Count

    @trace #BRCM_SWREQ_WDG
*/
extern const uint32_t WDG_SeEntityCnt;

/**
    @brief WDG SE List

    @trace #BRCM_SWREQ_WDG
*/
extern const WDG_SEType WDG_SupervisionEntities[];

/**
    @brief Stucture to the watchdog module

    This Module should be listed in Platform module

    @trace #BRCM_SWREQ_WDG_MODULE
*/
extern const MODULE_Type WDG_Module;
#endif /* WDG_OSIL_H */
/** @} */
