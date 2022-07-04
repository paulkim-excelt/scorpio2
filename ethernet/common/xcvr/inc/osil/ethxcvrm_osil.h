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
    @defgroup grp_ethsrv_xcvr_osil_ifc Ethernet Transceiver Module OSIL Interface
    @ingroup grp_ethsrv_xcvr

    @addtogroup grp_ethsrv_xcvr_osil_ifc
    @{

    @file ethxcvrm_osil.h

    @brief Ethernet transceiver module OSIL Interface

    @version 0.1 Initial version
*/

#ifndef ETHXCVRM_OSIL_H
#define ETHXCVRM_OSIL_H

#include <ethxcvr.h>

/**
    @name Ethernet Transceiver Module IDs for OSIL
    @{
    @brief Architecture API IDs for Ethernet Transceiver module OSIL
*/
#define BRCM_SWARCH_ETHXCVRM_CFG_GLOBAL          (0x9101U)    /**< @brief #ETHXCVRM_Cfg        */
#define BRCM_SWARCH_ETHXCVRM_EVENT_TYPE          (0x9102U)    /**< @brief #ETHXCVRM_EventType  */
#define BRCM_SWARCH_ETHXCVRM_EVENTINFO_GLOBAL    (0x9103U)    /**< @brief #ETHXCVRM_EventInfo  */
#define BRCM_SWARCH_ETHXCVRM_STARTTIMER_PROC     (0x9104U)    /**< @brief #ETHXCVRM_StartTimer */
#define BRCM_SWARCH_ETHXCVRM_STOPTIMER_PROC      (0x9105U)    /**< @brief #ETHXCVRM_StopTimer  */
#define BRCM_SWARCH_ETHXCVRM_TIMERCB_PROC        (0x9106U)    /**< @brief #ETHXCVRM_TimerCb    */
/** @} */

/**
    @brief Global handle for EthXcvr

    @trace #BRCM_SWREQ_ETHXCVRM
*/
extern const ETHXCVR_ConfigType ETHXCVRM_Cfg;

/**
    @name Ethernet Transceiver module event structure

    @trace #BRCM_SWREQ_ETHXCVRM
*/
typedef struct sETHXCVRM_EventType {
    uint32_t linkEvent;          /**< @brief Event for link change */
    uint32_t timerEvent;         /**< @brief Event for periodic timer processing */
    uint32_t stateHandlerEvent;  /**< @brief Event for MDIO state handling */
} ETHXCVRM_EventType;

/**
    @brief Event structure object of Ethernet Transceiver module

    @trace #BRCM_SWREQ_ETHXCVRM
*/
extern const ETHXCVRM_EventType ETHXCVRM_EventInfo;

/** @brief Start periodic timer

    @pre None

    Request OS to start the period timer

    @behavior Sync, Non-reentrant

    @retval  void

    @post None

    @trace #BRCM_SWREQ_ETHXCVRM
*/
void ETHXCVRM_StartTimer(void);

/** @brief Stop periodic timer

    @pre None

    Request OS to stop the period timer

    @behavior Sync, Non-reentrant

    @retval  void

    @post None

    @trace #BRCM_SWREQ_ETHXCVRM
*/
void ETHXCVRM_StopTimer(void);

/** @brief Timer alarm callback function

    Callback function for timer alarm

    @retval None

    @trace #BRCM_SWREQ_ETHXCVRM
*/
void ETHXCVRM_TimerCb(void);

#endif /* ETHXCVRM_OSIL_H */
/** @} */
