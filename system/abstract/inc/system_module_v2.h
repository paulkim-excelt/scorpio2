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

/** @defgroup grp_system_abstract_dmon_module_ifc DMON Module Guide
    @ingroup grp_system_abstract

    @addtogroup grp_system_abstract_dmon_module_ifc
    @{

    @file system_dmon_module.h
    @brief Device monitor module

    @version 1.0 Initial version
*/

#ifndef SYSTEM_DMON_MODULE_H
#define SYSTEM_DMON_MODULE_H

#include <module.h>

/**
    @name DMON Module Interface IDs
    @{
    @brief Integration Interface IDs for Device monitor Modules
*/
#define BRCM_SWARCH_SYSTEM_MODULE_GLOBAL      (0x8F00U) /**< @brief #SYSTEM_Service          */
#define BRCM_SWARCH_DMON_MODULE_GLOBAL        (0x8F01U) /**< @brief #DMON_Module             */
/** @} */

/**
    @brief Global stucture to store SYSTEM module parameter.

    This Module should be called from system task and this SYSTEM_Module
    is responsible to call platform specific modules.

    @trace #BRCM_SWREQ_SYSTEM
*/
extern const SERVICE_Type SYSTEM_Service;

/**
    @brief Structure for IO module

    @trace #BRCM_SWREQ_DMON
 */
extern const MODULE_Type DMON_Module;


#endif /* SYSTEM_DMON_MODULE_H */
/** @} */
