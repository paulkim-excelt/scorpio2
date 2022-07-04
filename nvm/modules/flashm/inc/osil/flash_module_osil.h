/*****************************************************************************
 Copyright 2021-2022 Broadcom Limited.  All rights reserved.

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

/** @defgroup grp_flashm_il Flash Module Integration Guide
    @ingroup grp_flashm

    @addtogroup grp_flashm_il
    @{

    @file flash_module_osil.h
    @brief Integration for flash module

    @version 0.1 Initial version
*/

#ifndef FLASH_MOD_OSIL_H
#define FLASH_MOD_OSIL_H

#include <module.h>
#include <osil/flash_osil.h>
#include <imgl_interface.h>

/**
    @name System Integration Interface IDs
    @{
    @brief Integration Interface IDs for System

*/
#define BRCM_SWARCH_FLASHM_IMGL_HANDLER_GLOBAL  (0x9201U) /**< @brief #FLASHM_ImglHandler      */
#define BRCM_SWARCH_FLASHM_MODULE_GLOBAL        (0x9202U) /**< @brief #FLASHM_Module           */
#define BRCM_SWARCH_FLASHM_GET_SERVERINFO_PROC  (0x9203U) /**< @brief #FLASHM_GetServerInfo    */
#define BRCM_SWARCH_FLASHM_FLASH0_EVENT_GLOBAL  (0x9204U) /**< @brief #FLASHM_Flash0Event      */
#define BRCM_SWARCH_FLASHM_FLASH1_EVENT_GLOBAL  (0x9205U) /**< @brief #FLASHM_Flash1Event      */

/** @} */

/**
    @brief Structure for Flash module

    @trace #BRCM_SWREQ_FLASHM
 */
extern const IMGL_InterfaceType FLASHM_ImglHandler;

/**
    @brief Structure for Flash module

    @trace #BRCM_SWREQ_FLASHM
 */
extern const MODULE_Type FLASHM_Module;

/**
    @brief Structure for Flash module

    @trace #BRCM_SWREQ_FLASHM
 */
extern void FLASHM_GetServerInfo(int32_t *aServerTask, uint32_t *aServerEvent);

/**
    @brief Structure for Flash-0 module

    @trace #BRCM_SWREQ_FLASHM
 */
extern const uint32_t FLASHM_Flash0Event;

/**
    @brief Structure for Flash-1 module

    @trace #BRCM_SWREQ_FLASHM
 */
extern const uint32_t FLASHM_Flash1Event;
#endif /* FLASH_MOD_OSIL_H */
/** @} */
