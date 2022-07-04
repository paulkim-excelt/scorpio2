/*****************************************************************************
 Copyright 2019 Broadcom Limited.  All rights reserved.

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
  @defgroup grp_dhcp_il DHCP Integration Guide
  @ingroup grp_inet

  @addtogroup grp_dhcp_il
  @{

  @file dhcp_osil.h
  @brief Integration APIs of DHCP
  This file provides the integration interface/APIs for DHCP
  @version 0.1 Initial version
*/

#ifndef DHCP_OSIL_H
#define DHCP_OSIL_H

/**
    @name DHCP IL API IDs
    @{
    @brief API IDs for DHCP IL
*/
#define BRCM_SWARCH_DHCP_HANDLETIMEREVENT_PROC         (0x9101U)    /**< @brief #DHCP_HandleTimerEvent      */
#define BRCM_SWARCH_DHCP_HANDLETXEVENT_PROC            (0x9102U)    /**< @brief #DHCP_HandleTxEvent         */
#define BRCM_SWARCH_DHCP_HANDLERXEVENT_PROC            (0x9103U)    /**< @brief #DHCP_HandleRxEvent         */
#define BRCM_SWARCH_DHCP_BOUNDCALLBACK_PROC            (0x9104U)    /**< @brief #DHCP_BoundCallback         */
#define BRCM_SWARCH_DHCP_UNBOUNDCALLBACK_PROC          (0x9105U)    /**< @brief #DHCP_UnBoundCallback       */
#define BRCM_SWARCH_DHCP_OFFERRECEIVEDCALLBACK_PROC    (0x9106U)    /**< @brief #DHCP_OfferReceivedCallback */
/** @} */

/** @brief Handle timer event

    This API is used to send a timer tick to DHCP for it to maintain
    any timers and passage of time

    @behavior Sync, Non-reentrant

    @retval          void

    @trace #BRCM_SWREQ_DHCP
*/
void DHCP_HandleTimerEvent(void);

/** @brief Handle Rx packet event

    This API is invoked when the INET stack informs that there is a received
    packet for the endpoint. It receives the packet from the stack, parses it
    and feeds it to the state machine

    @behavior Sync, Non-reentrant

    @retval          void

    @trace #BRCM_SWREQ_DHCP
*/
void DHCP_HandleRxEvent(void);

/** @brief Handle Tx packet event

    This API is invoked when the INET stack informs that a transmit buffer is
    available and any pending transmissions can be retried.

    @behavior Sync, Non-reentrant

    @retval          void

    @trace #BRCM_SWREQ_DHCP
*/
void DHCP_HandleTxEvent(void);

/** @brief DHCP client moves to Bound state

    This callback is invoked to inform that the DHCP client has transitioned to
    the bound state. At this stage valid IP and other configuration parameters
    can be fetched (using the #DHCP_GetParameter API) and fed to the INET stack

    @behavior Sync, Non-reentrant

    @retval          void

    @trace #BRCM_SWREQ_DHCP
*/
void DHCP_BoundCallback(void);

/** @brief DHCP client moves back to Init state

    This callback is invoked to inform that the DHCP client has transitioned to
    the Init state due to the following reasons:
     -# DHCP Nak received
     -# DHCP Decline was sent because of IP address conflict
     -# Timeout in selecting state
     -# Lease expired and not renewed by server
    The IP address and other configuration parameters might not be valid anymore
    and the INET stack should appropriately mark them so

    @behavior Sync, Non-reentrant

    @retval          void

    @trace #BRCM_SWREQ_DHCP
*/
void DHCP_UnBoundCallback(void);

/** @brief DHCP offer received

    This callback is invoked to inform that a DHCP offer was
    received in the selecting state. A unique number (#aOfferNum) is
    used to identify the offer which can be used to fetch the offered
    parameters using the #DHCP_GetParameter API

    @behavior Sync, Non-reentrant

    @param[in]       aOfferNum                Number identifying the offer

    @retval          void

    @trace #BRCM_SWREQ_DHCP
*/
void DHCP_OfferReceivedCallback(uint32_t aOfferNum);

#endif /* DHCP_OSIL_H */
/** @} */
