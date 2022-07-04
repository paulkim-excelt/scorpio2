/*****************************************************************************
 Copyright 2017-2020 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_ethswt_il Common Integration Layer
    @ingroup grp_ethswt

    @addtogroup grp_ethswt_il
    @{
    @section sec_eth_switch_integration Integration Guide
    Ethernet switch driver is implemented as a #SysCmdReq (system command
    request) and #SysCmdHandler (system command handler) model. This section
    also gives the necessary information on how to install command handler for
    Ethernet Switch Driver onto #SysCmdHandler.

    @section sec_eth_switch_il_seq Sequence Diagram
    Sequence diagrams in this section have SVC layer and SVC command handler
    lifelines.
    @subsection subsec_eth_switch_il_seq_svc SVC Layer interaction
    Below sequence diagram depicts execution sequence for Ethernet switch driver
    interfaces (APIs follow a similar sequence, #ETHSWT_Init sequence is shown
    as an example).
    @image html eth_switch_il_diagram_svc.jpg "SVC Layer interaction"

    @subsection subsec_eth_switch_il_seq_tx_ts Switch Driver – Ethernet Driver TX TS sequence
    Below figure depicts interaction between Ethernet driver and Switch driver
    for time stamped transmit packet in case of Switch Management mode.
    @image html eth_switch_il_diagram_tx_ts.jpg

    @subsection subsec_eth_switch_il_seq_rx_ts Switch Driver – Ethernet Driver RX TS sequence
    Below figure depicts interaction between Ethernet driver and switch driver
    for time stamped receive packet in case of Switch Management mode.
    @image html eth_switch_il_diagram_rx_ts.jpg

    @subsection  subsec_eth_switch_il_seq_link_ind Switch Port Link State Change indication
    Below figure depicts sequence diagram for Switch port link change
    indication.
    @image html eth_switch_il_diagram_link_ind.jpg

    @file eth_switch_osil.h
    @brief Ethernet switch driver Integration Interfaces
    This header file contains the integration interfaces for Ethernet Switch
    driver
    @version 0.51 Imported from docx
*/
#ifndef ETH_SWITCH_OSIL_H
#define ETH_SWITCH_OSIL_H

#include <svc.h>
#include <ethswt_common_osil.h>

#ifdef ENABLE_ETHSWT_CFP

#include <ethswt_cfp.h>
#endif

#ifdef ENABLE_ETHSWT_VLAN
#include <ethswt_vlan_osil.h>
#endif

#ifdef ENABLE_ETHSWT_ARL
#include <ethswt_arl_osil.h>
#endif

#ifdef ENABLE_ETHSWT_XCVR
#include <ethswt_xcvr_osil.h>
#endif

#ifdef ENABLE_ETHSWT_DEBUG
#include <ethswt_debug_osil.h>
#endif

#ifdef ENABLE_ETHSWT_EXT
#include <ethswt_ext_osil.h>
#endif

#endif /* ETH_SWITCH_OSIL_H */
/** @} */
