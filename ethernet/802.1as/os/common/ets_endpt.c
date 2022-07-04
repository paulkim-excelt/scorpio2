/*****************************************************************************
 Copyright 2020-2021 Broadcom Limited.  All rights reserved.

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
    @addtogroup grp_ets_il
    @{
    @file ets_endpt.c
    @brief ETS Library OS Integration Layer for End point
    This source file contains the integration of ETS to system
    @version 0.1 Initial version
*/

/* Includes */
#include <bcm_err.h>
#include "ets.h"
#include "ets_osil_defs.h"
/**
    @name ETS Component Design IDs
    @{
    @brief Design IDs for ETS component

*/
#define BRCM_SWDSGN_ETS_CONFIGSAVECALLBACK_PROC    (0xA101U)    /**< @brief #ETS_ConfigSaveCallback */
#define BRCM_SWDSGN_ETS_EVENTCALLBACK_PROC         (0xA102U)    /**< @brief #ETS_EventCallback      */
#define BRCM_SWDSGN_ETS_RECORDCALLBACK_PROC        (0xA103U)    /**< @brief #ETS_RecordCallback     */
#define BRCM_SWDSGN_ETS_UPDATE_CONFIG_PROC         (0xA104U)    /**< @brief #ETS_UpdateConfig       */
/** @} */


/**
    @code{.unparsed}
    @endcode
    @trace #BRCM_SWARCH_ETS_CONFIGSAVECALLBACK_PROC
    @trace #BRCM_SWREQ_ETS_CORE
*/
void ETS_ConfigSaveCallback (const uint32_t aPortIdx,
                             const uint32_t aPdelay,
                             const int32_t  aRateRatio)
{
    ETS_ContextType *ETS_Handle = ETS_GetHandle();

    /* Cache these in the configuration */
    ETS_Handle->config.intfCfg[0].avnuNbrPropDelay = aPdelay;
    ETS_Handle->config.intfCfg[0].avnuNbrRateRatio = aRateRatio;
}

/**
    @code{.unparsed}
    @endcode
    @trace #BRCM_SWARCH_ETS_EVENTCALLBACK_PROC
    @trace #BRCM_SWREQ_ETS_CORE
*/
void ETS_EventCallback (const uint32_t      aPortIdx,
                        const ETS_EventType aEvent)
{
}

/**
    @code{.unparsed}
    @endcode
    @trace #BRCM_SWREQ_ETS_CORE
    @trace #BRCM_SWARCH_ETS_RECORDCALLBACK_PROC
*/
void ETS_RecordCallback(ETS_RecordType* const aRecord)
{
}

/**
    @code{.unparsed}
    @endcode
    @trace #BRCM_SWREQ_ETS
    @trace #BRCM_SWARCH_ETS_UPDATE_CONFIG_PROC
*/
void ETS_UpdateConfig(ETS_ConfigType *const aConfig,
                      uint32_t aUnifiedToLocal)
{
}

/** @} */
