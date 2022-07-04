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
    @addtogroup grp_flashm_ifc
    @{

    @file flash_module_osil.c
    @brief This file implements interface layer for flash module.

    @version 0.1 Initial draft
    */

#include <bcm_err.h>
#include <bcm_utils.h>
#include <module.h>
#include <osil/module_osil.h>
#include <module_helper.h>
#include <bcm_comp.h>
#include <bcm_utils.h>
#include <flash_module_osil.h>
#include <ee.h>

/**
  @name FLASH Module Design IDs
  @{
  @brief Design IDs for Flash Module
  */

/** @} */

const uint32_t FLASHM_Flash0Event = FLASH0_EVENT;
const uint32_t FLASHM_Flash1Event = FLASH1_EVENT;

#ifdef FLASHM_SERVER_TASK
void FLASHM_GetServerInfo(int32_t *aServerTask, uint32_t *aServerEvent)
{
    if (NULL != aServerTask)
    {
        *aServerTask = FLASHM_SERVER_TASK;
    }
    if (NULL != aServerEvent)
    {
        *aServerEvent = MODULE_Event;
    }
}
#endif

#if !defined(ENABLE_FLASH_TEST)
/**
  @brief Flash operation done notification

  @trace #BRCM_SWARCH_FLASH_MODULE_GLOBAL
  @trace #BRCM_SWREQ_FLASHM
  */
void FLASHM_DoneInd(FLASH_HwIDType aID)
{
    int32_t status;
    int32_t serverTask = 0x0;
    uint32_t serverEvent = 0UL;

    FLASHM_Module.cmdQ.getServer(&serverTask, &serverEvent);
    if (FLASH_HW_ID_0 == aID) {
        status = BCM_SetEvent(serverTask, serverEvent);
        if (status != BCM_ERR_OK) {
            /*Report Error*/
        }
    } else if (FLASH_HW_ID_1 == aID) {
        status = BCM_SetEvent(serverTask, serverEvent);
        if (status != BCM_ERR_OK) {
            /*Report Error*/
        }
    } else {
        /*Report Error*/
    }
}

/**
  @brief Flash operation Error notification

  @trace #BRCM_SWARCH_FLASH_MODULE_GLOBAL
  @trace #BRCM_SWREQ_FLASHM
  */
void FLASHM_ErrInd(FLASH_HwIDType aID)
{
    int32_t status;
    int32_t serverTask = 0x0;
    uint32_t serverEvent = 0UL;

    FLASHM_Module.cmdQ.getServer(&serverTask, &serverEvent);
    if (FLASH_HW_ID_0 == aID) {
        status = BCM_SetEvent(serverTask, serverEvent);
        if (status != BCM_ERR_OK) {
            /*Report Error*/
        }
    } else if (FLASH_HW_ID_1 == aID) {
        status = BCM_SetEvent(serverTask, serverEvent);
        if (status != BCM_ERR_OK) {
            /*Report Error*/
        }
    } else {
        /*Report Error*/
    }
}
#endif
/** @} */
