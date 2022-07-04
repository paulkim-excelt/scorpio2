/*****************************************************************************
 Copyright 2020 Broadcom Limited.  All rights reserved.

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

    @file ets_osil_switch.h
    @brief Ethernet TimeSync library switch integration interfaces.
    This header file defines the switch integration interfaces for ETS library.
    @version 0.1 Initial version
*/
#ifndef ETS_OSIL_SWITCH_H
#define ETS_OSIL_SWITCH_H

#include <nif.h>
#include <nif_switch.h>

/**
    @name ETS IL API IDs
    @{
    @brief API IDs for ETS IL
 */
#define BRCM_SWARCH_ETS_RXMGMTINFOINDICATION_PROC    (0x9201U)    /**< @brief #ETS_RxMgmtInfoIndication */
/** @} */

/** @brief Receive packet management information callback

    @pre ETS_RxPktIndication() should have been invoked with the same
    identifiers i.e. aCtrlIdx & aBuf

    Invoked by the network interface with management information of
    each RX packet. This is applicable when operating as a bridge.

    @behavior Sync, Non-reentrant

    @param[in]   aCtrlIdx    Controller index in the context of NIF
    @param[in]   aBuf        Pointer to the packet buffer
    @param[in]   aMgmtInfo   Pointer to management information

    @return      void

    @post None

    @limitations To be invoked by a higher priority task than ETS protocol task
    @trace #BRCM_SWREQ_ETS_NIF_CALLBACK_SWITCH
*/
void ETS_RxMgmtInfoIndication(NIF_CntrlIDType aCtrlIdx,
                              const uint8_t *const aBuf,
                              const ETHSWT_MgmtInfoType *const aMgmtInfo);

#endif /* ETS_OSIL_SWITCH_H*/
/** @} */
