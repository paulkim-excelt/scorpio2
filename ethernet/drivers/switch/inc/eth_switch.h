/*****************************************************************************
 Copyright 2017-2019 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_ethswt_drv_ifc1 Ethernet Switch Driver Interface
    @ingroup grp_ethswt

    @addtogroup grp_ethswt_drv_ifc1
    @{
    @section sec_eth_switch_overview Overview
    @image html eth_switch_overview.jpg "Ethernet Switch driver architecture"
    An Ethernet switch consists of several ports of different types. Ethernet
    switch driver interface provides a hardware independent interface to the
    user to configure the switch. Switch driver does not configure the
    underlying ports of the switch. It is configured by external entity in the
    system (transceiver driver or Bootloader). Switch driver provides static
    configuration of the switch (per port basis) during the initialization
    (#ETHSWT_Init).

    Picture below depicts the switch configuration structure layout
    (#ETHSWT_CfgType):
    @image html eth_switch_cfg_layout.jpg "Switch Configuration"

    Switch configuration consistis of per port configuration
    (#ETHSWT_PortCfgType), global CFP rules and UDF rules.

    A typical L2 switch consists of fixed number of ports and provides basic
    features like:
    - ARL learning (hardware learning/software learning)
    - MAC based forwarding of the packet
    - VLAN based forwarding of the packet
    - Priority based forwarding mechanism (PCP field based)
    - ARL table control (static Addition/deletion of MAC address)

    Switch configuration structure (#ETHSWT_CfgType) provides the mechanism to
    configure these features of switch on per port basis. Configuration of the
    each port is modelled by #ETHSWT_PortCfgType structure.

    @c ETHSWT_PortCfgType::fixedMacAddrList field of port configuration
    structure provides the mechanism to add MAC addresses into the switch ARL
    table statically (never aged out).

    @c ETHSWT_PortCfgType::vlanMemList field of the port configuration
    structure provides the mechanism for the port to participate in VLANs. This
    membership defines the ingress, egress and forwarding behavior. This
    configuration also defines the Tagging/Un-tagging behavior of the port.
    Table below shows an example of the forwarding behavior within 8-port
    switch:
    <table width>
    <caption id="fwd_behaviour">Forwarding Behaviour witin 8-port switch
    </caption>
    <tr><th rowspan="2"> VLAN ID <th colspan="8"> Port Number
    <tr><th>0<th>1<th>2<th>3<th>4<th>5<th>6<th>7
    <tr><td>1<td>Tagged<td>Tagged<td>-<td>-<td>Untagged<td>-<td>-<td>-
    <tr><td>2<td>Tagged<td>-<td>-<td>-<td>Tagged<td>-<td>-<td>-
    <tr><td colspan="9">...
    <tr><td>4094<td>..<td>..<td>..<td>..<td>..<td>..<td>..<td>..
    </table>

    Behavior of Incoming packets with VLAN ID “1”:
    - Forward it to port 0 and 1 tagged
    - Forward it to port 4 as untagged
    - Don’t forward this packet to port 2, 3, 5, 6 and 7

    Similarly behavior of the incoming packet with VLAN ID “2”:
    - Forward it to port 0 and 4 as tagged
    - Don’t forward this packet to rest of the ports

    VLAN ID is modelled by #ETHSWT_VLANMemberCfgType::vlandID.

    Forwarding behavior as Don’t send/Tagged/Untagged is modelled by
    #ETHSWT_VLANMemberCfgType::forward.

    @anchor eth_switch_port_forward_config
    Apart from above VLAN based forwarding behavior, a port can be configured
    to:
    -# <b>Drop all the untagged packets</b>: This is modelled by @c dropUntagged
       field of the ingress port configuration structure. If set to #TRUE, all
       the untagged packets will be dropped at the ingress side of the port.
    -# <b>Forward untagged (forward the packet as is)</b>:  This is modelled by
       @c dropUntagged field of the ingress port configuration structure. If set
       to #FALSE, all the untagged packets will be forwarded untagged to
       egress port.
    -# <b>Forward tagged</b>: Tag all the untagged packets arriving at this port
       with default VLAN and default priority. This is modelled by
       @c defaultVLAN and @c defaultPrio field of the ingress port configuration
       structure.

    @c #ETHSWT_PortCfgType::ingressCfg field of the port configuration
    structure defines the Port ingress configuration and
    #ETHSWT_PortCfgType::egressCfg field of the port configuration structure
    defines the egress configuration of the port.

    Switch consists of fixed number of ports and it assumed that each port
    contains fixed number of the egress FIFOs (queues) where incoming packets
    are buffered/queued. Configuration of the each FIFO is modelled by
    #ETHSWT_FifoCfgType structure. Incoming packets are processed depending
    on the shaping and scheduling algorithm of the FIFO. Shaper configuration
    provides mechanism to control the burst size; minimum length and byte rate
    of the FIFO. Configuration of shaping algorithm of the FIFO is modelled by
    #ETHSWT_ShaperCfgType structure. Scheduling algorithm of the Port is
    modelled by #ETHSWT_PortSchType configuration structure.

    Apart from the modelling of the egress port configuration, it is also
    important to understand how the priority based routing is configured in the
    switch. As an example, Ethernet priority field (PCP field) of the packet can
    be evaluated and mapped to a so-called Traffic class. Each traffic class can
    then be mapped to egress FIFO. Another example is each port can have fixed
    traffic class (represented by @c tc field of the ingress port configuration
    structure #ETHSWT_PortIngressCfgType), where each incoming packet is
    treated at the same priority.

    So for the routing of the packet, there are two kinds of mapping which are
    possible:
    -# <b>Ingress port to traffic class mapping</b>: In this method, port
       traffic class is fixed. This is modelled by @c tc field of the ingress
       port configuration structure. Table below shows an example:
       |Port    |Traffic Class  |
       |:------:|:-------------:|
       |1,2,3   |7              |
       |4,5     |6              |
       |6       |5              |
       |7,8     |1              |
    -# <b>PCP to traffic class mapping</b>: In this method, PCP field of the
       incoming packet is evaluated a mapped to a traffic class. This mapping is
       modelled by @c pcp2tcMap table in the ingress port configuration
       structure. Table below shows an example:
       |PCP     |Traffic Class  |
       |:------:|:-------------:|
       |0       |7              |
       |1,2     |6              |
       |3       |5              |
       |4,5,6,7 |1              |

    After mapping the incoming packet to a traffic class, they are mapped to
    certain FIFO at the egress side of the switch. This table is modelled by
    @c tc field of port FIFO configuration structure (#ETHSWT_FifoCfgType).
    Table shows an example:
       |Traffic Class   |FIFO   |
       |:--------------:|:-----:|
       |7               |0      |
       |6               |2      |
       |5,4             |1      |
       |3,2,1,0         |3      |

    @section sec_eth_switch_fsm State Machine
    @image html eth_switch_state_machine.jpg "Ethernet Switch state machine"
    API list for ETHSWT_STATE_INIT to ETHSWT_STATE_INIT transition:
    - #ETHSWT_GetPortMode
    - #ETHSWT_SetPortMode
    - #ETHSWT_GetPortLinkState
    - #ETHSWT_GetPortSpeed
    - #ETHSWT_GetPortDuplexMode
    - #ETHSWT_GetPortMacAddr
    - #ETHSWT_GetARLTable
    - #ETHSWT_ReadReg
    - #ETHSWT_WriteReg
    - #ETHSWT_EnableVLAN
    - #ETHSWT_SetMACLearningMode
    - #ETHSWT_GetMACLearningMode
    - #ETHSWT_SetPortMirrorConfig
    - #ETHSWT_GetPortMirrorConfig
    - #ETHSWT_SetPortMirrorState
    - #ETHSWT_GetPortMirrorState
    - #ETHSWT_GetRxStat
    - #ETHSWT_GetTxStat
    - #ETHSWT_GetSQIValue

    @section sec_eth_switch_seq Sequence Diagrams
    @subsection subsec_eth_switch_seq_tx Switch Driver – Ethernet Driver TX
    The figure below depicts Ethernet driver and Switch driver call sequence for
    transmit packet in case of Switch Management mode. In case of
    non-timestamped packet omit #ETHSWT_EnableTxTimestamp and
    #ETHSWT_TxTSInd call sequence.
    @image html eth_switch_seq_tx.jpg "Switch – Ethernet TX timestamp sequence"

    @subsection subsec_eth_swtich_seq_rx Switch Driver – Ethernet Driver RX
    The figure below depicts Ethernet driver and Switch driver call sequence for
    time-stamped receive packet in case of Switch Management mode. In case of
    non-timestamped packet omit #ETHSWT_RxTSInd call sequence.
    @image html eth_switch_seq_rx.jpg "Switch – Ethernet RX timestamp sequence"

    @section sec_eth_switch_perf Performance & Memory

    | Performance       | Description                                       |
    |:-----------------:|:-------------------------------------------------:|
    | CPU Load          | NA                                                |
    | Memory Bandwidth  | NA                                                |
    | HW Utilization    | NA                                                |

    @includedoc drivers_eth_switch.dep

    @limitations None

    @file eth_switch.h
    @brief Application programmer interface for Ethernet Switch Driver
    This header file contains the interfaces for Ethernet Switch Driver
    @version 0.51 Imported from docx
 */

#ifndef ETH_SWITCH_H
#define ETH_SWITCH_H

#include <ethswt_common.h>

#if defined(ENABLE_ETHSWT_VLAN)
#include <ethswt_vlan.h>
#endif
#if defined(ENABLE_ETHSWT_ARL)
#include <ethswt_arl.h>
#endif

#if defined(ENABLE_ETHSWT_XCVR)
#include <ethxcvr.h>
#include <ethswt_xcvr.h>
#endif

#if defined(ENABLE_ETHSWT_DEBUG)
#include <ethswt_debug.h>
#endif

#if defined(ENABLE_ETHSWT_EXT)
#include <ethswt_ext.h>
#endif

#endif /* ETH_SWITCH_H */

/** @} */
