/*****************************************************************************
 Copyright 2017-2019 Broadcom Limited.  All rights reserved.

 This program is the proprietary software of Broadcom Corporation and/or its
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
    @defgroup grp_host_etherswt Host Ethernet Switch
    @ingroup grp_host_comms

    @addtogroup grp_host_etherswt
    @{

    @file host_etherswt.h
    @brief Host Ethernet Switch Sub-Group API
    This header file contains the host interface functions for Ethernet Switch Sub-Group

    @version 1.0 Initial Version
*/

#ifndef HOST_ETHERSWT_H
#define HOST_ETHERSWT_H

#include <host_system.h>
#include <ethernet_swt_arl.h>
#include <ethernet_swt_core.h>
#include <ethernet_swt_vlan.h>
#include <ethernet_swt_debug.h>
#include <ethernet_swt_ext.h>
#ifdef ENABLE_HOST_ETHSWTM_CFP_CMD_HANDLER
#include <ethernet_swt_cfp.h>
#endif
#ifdef ENABLE_HOST_ETHSWTM_FA_CMD_HANDLER
#include <ethswtm_fa.h>
#endif

/** @brief Get Port Information

    This API is used to retrieve port specific information

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      info            Pointer to #MgmtInfoType handle
    @param[in]      port            Port number
    @param[out]     portInfo        Pointer to #ETHSWT_ExtPortInfoType

    @return     #BCM_ERR_OK             Port information obtained successfully
    @return     #BCM_ERR_INVAL_PARAMS   Invalid info pointer
    @return     #BCM_ERR_INVAL_PARAMS   Invalid portInfo pointer
    @return     #BCM_ERR_UNKNOWN        Error reported by target

    @post None

    @limitations None
*/
extern int32_t HOST_EtherSwtPortInfoGet(MgmtInfoType *info, uint32_t port,
        ETHSWT_ExtPortInfoType *portInfo);

/** @brief Set Port information

    This API is used to set port specific information

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      info            Pointer to #MgmtInfoType handle
    @param[in]      portInfo        Pointer to #ETHSWT_ExtPortInfoType

    @return     #BCM_ERR_OK             Port info set successfully
    @return     #BCM_ERR_INVAL_PARAMS   Invalid info pointer
    @return     #BCM_ERR_INVAL_PARAMS   Invalid portInfo pointer
    @return     #BCM_ERR_UNKNOWN        Error reported by target

    @post None

    @limitations None
*/
extern int32_t HOST_EtherSwtPortInfoSet(MgmtInfoType *info,
        ETHSWT_ExtPortInfoType *portInfo);

/** @brief Get port MIB counters

    This API is used to retrieve port specific MIB counters

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      info            Pointer to #MgmtInfoType handle
    @param[in]      port            Port number
    @param[out]     mib             Pointer to #ETHSWT_DebugMibType

    @return     #BCM_ERR_OK             MIB counters obtained successfully
    @return     #BCM_ERR_INVAL_PARAMS   Invalid info pointer
    @return     #BCM_ERR_INVAL_PARAMS   Invalid mib pointer
    @return     #BCM_ERR_UNKNOWN        Error reported by target

    @post None

    @limitations None
*/
extern int32_t HOST_EtherSwtMib(MgmtInfoType *info, int32_t port,
        ETHSWT_DebugMibType *mib);

/** @brief Clear port mib counters

    This API is used to clear port specific mib counters

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      info            Pointer to #MgmtInfoType handle
    @param[in]      port            Port number

    @return     #BCM_ERR_OK             MIB counters cleared successfully
    @return     #BCM_ERR_INVAL_PARAMS   Invalid info pointer
    @return     #BCM_ERR_UNKNOWN        Error reported by target

    @post None

    @limitations None
*/
extern int32_t HOST_EtherSwtMibClear(MgmtInfoType *info, int32_t port);

/** @brief Read Switch register

    This API is used to read switch register

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      info            Pointer to #MgmtInfoType handle
    @param[in]      destn           Reg read from master or slave
    @param[in]      addr            Address of register
    @param[in]      len             Number of registers from addr to read
    @param[out]     data            Pointer to buffer to read contents of registers

    @return     #BCM_ERR_OK             Register(s) read successfully
    @return     #BCM_ERR_INVAL_PARAMS   Invalid info pointer
    @return     #BCM_ERR_INVAL_PARAMS   Invalid data pointer
    @return     #BCM_ERR_UNKNOWN        Error reported by target

    @post None

    @limitations
    - len should be less than or equal to 16
    - Accesses are 64bit wide
*/
extern int32_t HOST_EtherSwtRegRead(MgmtInfoType *info,  MCU_DeviceType destn,
                                    uint32_t addr, uint32_t len, uint64_t *data);

/** @brief Write to switch register

    This API is used to write to switch register

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      info            Pointer to #MgmtInfoType handle
    @param[in]      destn           Reg read from master or slave
    @param[in]      addr            Address of register
    @param[in]      len             Number of registers from addr to write to
    @param[out]     data            Pointer to data to be written to registers

    @return     #BCM_ERR_OK             Register(s) written successfully
    @return     #BCM_ERR_INVAL_PARAMS   Invalid info pointer
    @return     #BCM_ERR_INVAL_PARAMS   Invalid data pointer
    @return     #BCM_ERR_UNKNOWN        Error reported by target

    @post None

    @limitations
    - len should be less than or equal to 16
    - Accesses are 64bit wide
*/
extern int32_t HOST_EtherSwtRegWrite(MgmtInfoType *info, MCU_DeviceType destn, uint32_t addr,
                                     uint32_t len, uint64_t *data);

/** @brief Get switch age time

    This API is used to retrieve switch age time

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      info            Pointer to #MgmtInfoType handle
    @param[out]     ageTime         Pointer to get ageTime value

    @return     #BCM_ERR_OK             Agetime obtained successfully
    @return     #BCM_ERR_INVAL_PARAMS   Invalid info pointer
    @return     #BCM_ERR_INVAL_PARAMS   Invalid ageTime pointer
    @return     #BCM_ERR_UNKNOWN        Error reported by target

    @post None

    @limitations None
*/
extern int32_t HOST_EtherSwtAgeTimeGet(MgmtInfoType *info, uint32_t *ageTime);

/** @brief Get Dumb forwarding mode

    This API is used to retrieve dumb forwarding mode

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      info            Pointer to #MgmtInfoType handle
    @param[out]     dumbFwdMode     Pointer to #ETHSWT_DumbFwdModeType

    @return     #BCM_ERR_OK             Dumb forwarding mode obtained successfully
    @return     #BCM_ERR_INVAL_PARAMS   Invalid info pointer
    @return     #BCM_ERR_INVAL_PARAMS   Invalid dumbFwdMode pointer
    @return     #BCM_ERR_UNKNOWN        Error reported by target

    @post None

    @limitations None
*/
extern int32_t HOST_EtherSwtDumbFwdModeGet(MgmtInfoType *info,
        ETHSWT_DumbFwdModeType *dumbFwdMode);

/** @brief Get management mode

    This API is used to retrieve management mode

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      info            Pointer to #MgmtInfoType handle
    @param[out]     mgmtMode        Pointer to #ETHSWT_MgmtModeType

    @return     #BCM_ERR_OK             Management mode obtained successfully
    @return     #BCM_ERR_INVAL_PARAMS   Invalid info pointer
    @return     #BCM_ERR_INVAL_PARAMS   Invalid mgmtMode pointer
    @return     #BCM_ERR_UNKNOWN        Error reported by target

    @post None

    @limitations None
*/
extern int32_t HOST_EtherSwtMgmtModeGet(MgmtInfoType *info,
        ETHSWT_MgmtModeType *mgmtMode);

/** @brief Get Broadcom header mode on IMP

    This API is used to retrieve Broadcom header mode on IMP

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      info            Pointer to #MgmtInfoType handle
    @param[out]     brcmHdrMode     Pointer to #ETHSWT_BrcmHdrModeType

    @return     #BCM_ERR_OK             Broadcom header mode obtained successfully
    @return     #BCM_ERR_INVAL_PARAMS   Invalid info pointer
    @return     #BCM_ERR_INVAL_PARAMS   Invalid brcmHdrMode pointer
    @return     #BCM_ERR_UNKNOWN        Error reported by target

    @post None

    @limitations None
*/
extern int32_t HOST_EtherSwtBrcmHdrModeGet(MgmtInfoType *info,
        ETHSWT_BrcmHdrModeType *brcmHdrMode);

/** @brief Enable mirroring

    This API is used to enable mirroring

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      info            Pointer to #MgmtInfoType handle
    @param[in]      portMask        Port bitmask
    @param[in]      probePort       Probe port
    @param[in]      direction       Direction of traffic to mirror
    @param[in]      packetDivider   Packet divider (only a subset of
                                    the received frame shall be mirrored).
                                    For example if packetDivider is set to
                                    10, then out of 10 packets passing the
                                    filtering, only 1 shall be mirrored

    @return     #BCM_ERR_OK             Mirroring enabled successfully
    @return     #BCM_ERR_INVAL_PARAMS   Invalid info pointer
    @return     #BCM_ERR_INVAL_PARAMS   Invalid direction
    @return     #BCM_ERR_INVAL_PARAMS   probePort is part of portMask
    @return     #BCM_ERR_INVAL_PARAMS   portMask is 0 and is not a stacked
                                        configuration
    @return     #BCM_ERR_INVAL_PARAMS   packetDivider is > 0x3FF
    @return     #BCM_ERR_UNKNOWN        Error reported by target

    @post None

    @limitations None
*/
extern int32_t HOST_EtherSwtMirrorEnable(MgmtInfoType *info, uint16_t portMask,
        uint32_t probePort, ETHSWT_TrafficDirType direction, uint16_t packetDivider);

/** @brief Disable mirroring

    This API is used to disable mirroring

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      info            Pointer to #MgmtInfoType handle

    @return     #BCM_ERR_OK             Mirroring disabled successfully
    @return     #BCM_ERR_INVAL_PARAMS   Invalid info pointer
    @return     #BCM_ERR_UNKNOWN        Error reported by target

    @post None

    @limitations None
*/
extern int32_t HOST_EtherSwtMirrorDisable(MgmtInfoType *info);

/** @brief Get mirror status

    This API is used to retrieve mirroring status

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      info            Pointer to #MgmtInfoType handle
    @param[out]     state           Pointer to get mirroring state
    @param[out]     ingressPortMask Pointer to get ingress port bitmask
    @param[out]     egressPortMask  Pointer to get egress port bitmask
    @param[out]     probePort       Pointer to get probe port number

    @return     #BCM_ERR_OK             Mirroring status obtained successfully
    @return     #BCM_ERR_INVAL_PARAMS   Invalid info pointer
    @return     #BCM_ERR_UNKNOWN        Error reported by target

    @post None

    @limitations None
*/
extern int32_t HOST_EtherSwtMirrorStatus(MgmtInfoType *info, uint32_t *state,
        uint16_t *ingressPortMask, uint16_t *egressPortMask, uint32_t *probePort);

/** @brief Set switch age time

    This API is used to set switch age time

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      info            Pointer to #MgmtInfoType handle
    @param[in]      ageTime         Value of age time

    @return     #BCM_ERR_OK             Age time set successfully
    @return     #BCM_ERR_INVAL_PARAMS   Invalid info pointer
    @return     #BCM_ERR_UNKNOWN        Error reported by target

    @post None

    @limitations None
*/
extern int32_t HOST_EtherSwtAgeTimeSet(MgmtInfoType *info, uint32_t ageTime);

/** @brief Get switch information

    This API is used to get global switch information

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      info            Pointer to #MgmtInfoType handle
    @param[out]     switchInfo      Pointer to get switch information

    @return     #BCM_ERR_OK             Switch information obtained successfully
    @return     #BCM_ERR_INVAL_PARAMS   Invalid info pointer
    @return     #BCM_ERR_INVAL_PARAMS   Invalid switchInfo pointer
    @return     #BCM_ERR_UNKNOWN        Error reported by target

    @post None

    @limitations None
*/
extern int32_t HOST_EtherSwtSwitchInfoGet(MgmtInfoType *info,
        ETHSWT_ExtSwitchInfoType *switchInfo);

/** @brief Set switch information

    This API is used to set global switch information

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      info            Pointer to #MgmtInfoType handle
    @param[in]      switchInfo      Pointer to set switch information

    @return     #BCM_ERR_OK             Switch information set successfully
    @return     #BCM_ERR_INVAL_PARAMS   Invalid info pointer
    @return     #BCM_ERR_INVAL_PARAMS   Invalid switchInfo pointer
    @return     #BCM_ERR_UNKNOWN        Error reported by target

    @post None

    @limitations None
*/
extern int32_t HOST_EtherSwtSwitchInfoSet(MgmtInfoType *info,
        ETHSWT_ExtSwitchInfoType *switchInfo);

/** @brief Get port administrative mode

    This API is used to get port administrative mode

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      info            Pointer to #MgmtInfoType handle
    @param[in]      port            Port number
    @param[out]     adminMode       Pointer to get administrative mode

    @return     #BCM_ERR_OK             Administrative mode obtained successfully
    @return     #BCM_ERR_INVAL_PARAMS   Invalid info pointer
    @return     #BCM_ERR_INVAL_PARAMS   Invalid adminMode pointer
    @return     #BCM_ERR_UNKNOWN        Error reported by target

    @post None

    @limitations None
*/
extern int32_t HOST_EtherSwtXcvrAdminModeGet(MgmtInfoType *info, uint32_t port,
                                             ETHXCVR_ModeType *adminMode);

/** @brief Get port speed

    This API is used to get port speed

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      info            Pointer to #MgmtInfoType handle
    @param[in]      port            Port number
    @param[out]     speed           Pointer to get speed

    @return     #BCM_ERR_OK             Port speed obtained successfully
    @return     #BCM_ERR_INVAL_PARAMS   Invalid info pointer
    @return     #BCM_ERR_INVAL_PARAMS   Invalid speed pointer
    @return     #BCM_ERR_UNKNOWN        Error reported by target

    @post None

    @limitations None
*/
extern int32_t HOST_EtherSwtXcvrSpeedGet(MgmtInfoType *info, uint32_t port,
        ETHXCVR_SpeedType *speed);

/** @brief Get port master/slave mode

    This API is used to get port master/slave mode

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      info            Pointer to #MgmtInfoType handle
    @param[in]      port            Port number
    @param[out]     masterSlave     Pointer to get master/slave mode

    @return     #BCM_ERR_OK             Port master/slave mode obtained successfully
    @return     #BCM_ERR_INVAL_PARAMS   Invalid info pointer
    @return     #BCM_ERR_INVAL_PARAMS   Invalid masterSlave pointer
    @return     #BCM_ERR_UNKNOWN        Error reported by target

    @post None

    @limitations None
*/
extern int32_t HOST_EtherSwtXcvrMasterSlaveGet(MgmtInfoType *info,
        uint32_t port, ETHXCVR_BooleanType *masterSlave);

/** @brief Get port phy loop-back mode

    This API is used to get port phy loop-back mode

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      info            Pointer to #MgmtInfoType handle
    @param[in]      port            Port number
    @param[out]     loopBackMode    Pointer to get loop-back mode

    @return     #BCM_ERR_OK             Loop-back mode obtained successfully
    @return     #BCM_ERR_INVAL_PARAMS   Invalid info pointer
    @return     #BCM_ERR_INVAL_PARAMS   Invalid loopBackMode pointer
    @return     #BCM_ERR_UNKNOWN        Error reported by target

    @post None

    @limitations None
*/
extern int32_t HOST_EtherSwtXcvrPhyLbGet(MgmtInfoType *info, uint32_t port,
        ETHXCVR_BooleanType *loopBackMode);

/** @brief Get Singal Quality Indicator

    This API is used to get link Signal Quality Indicator

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      info            Pointer to #MgmtInfoType handle
    @param[in]      port            Port number
    @param[out]     sqi             Pointer to obtain SQI value

    @return     #BCM_ERR_OK             Link SQI obtained successfully
    @return     #BCM_ERR_INVAL_PARAMS   Invalid info pointer
    @return     #BCM_ERR_INVAL_PARAMS   Invalid sqi pointer
    @return     #BCM_ERR_UNKNOWN        Error reported by target

    @post None

    @limitations None
*/
extern int32_t HOST_EtherSwtXcvrLinkSQIGet(MgmtInfoType *info, uint32_t port,
        uint32_t *sqi);

/** @brief Get Jumbo frame mode

    This API is used to get port specific jumbo frame mode

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      info            Pointer to #MgmtInfoType handle
    @param[in]      port            Port number
    @param[out]     jumboFrameMode  Pointer to obtain jumbo frame mode

    @return     #BCM_ERR_OK             Jumbo frame mode obtained successfully
    @return     #BCM_ERR_INVAL_PARAMS   Invalid info pointer
    @return     #BCM_ERR_INVAL_PARAMS   Invalid jumboFrameMode pointer
    @return     #BCM_ERR_UNKNOWN        Error reported by target

    @post None

    @limitations None
*/
extern int32_t HOST_EtherSwtXcvrJumboFrameModeGet(MgmtInfoType *info,
        uint32_t port, ETHXCVR_BooleanType *jumboFrameMode);

/** @brief Get port type

    This API is used to get port type

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      info            Pointer to #MgmtInfoType handle
    @param[in]      port            Port number
    @param[out]     busMode         Pointer to obtain bus mode
    @param[out]     phyMedia        Pointer to obtain phy media

    @return     #BCM_ERR_OK             Port type obtained successfully
    @return     #BCM_ERR_INVAL_PARAMS   Invalid info pointer
    @return     #BCM_ERR_INVAL_PARAMS   Invalid type pointer
    @return     #BCM_ERR_UNKNOWN        Error reported by target

    @post None

    @limitations None
*/
extern int32_t HOST_EtherSwtXcvrTypeGet(MgmtInfoType *info,
                                        uint32_t port,
                                        ETHXCVR_BusModeType *busMode,
                                        ETHXCVR_PhyMediaType *phyMedia);

/** @brief Set dumb forwarding mode

    This API is used to set dumb forwarding mode

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      info            Pointer to #MgmtInfoType handle
    @param[in]      dumbFwdMode     Dumb forwarding mode value

    @return     #BCM_ERR_OK             Dumb forwarding mode set successfully
    @return     #BCM_ERR_INVAL_PARAMS   Invalid info pointer
    @return     #BCM_ERR_INVAL_PARAMS   Invalid dumbFwdMode
    @return     #BCM_ERR_UNKNOWN        Error reported by target

    @post None

    @limitations None
*/
extern int32_t HOST_EtherSwtDumbFwdModeSet(MgmtInfoType *info,
        ETHSWT_DumbFwdModeType dumbFwdMode);

/** @brief Set management mode

    This API is used to set management mode

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      info            Pointer to #MgmtInfoType handle
    @param[in]      mgmtMode        Management mode value

    @return     #BCM_ERR_OK             Management mode set successfully
    @return     #BCM_ERR_INVAL_PARAMS   Invalid info pointer
    @return     #BCM_ERR_INVAL_PARAMS   Invalid mgmtMode
    @return     #BCM_ERR_UNKNOWN        Error reported by target

    @post None

    @limitations None
*/
extern int32_t HOST_EtherSwtMgmtModeSet(MgmtInfoType *info,
        ETHSWT_MgmtModeType mgmtMode);

/** @brief Set Broadcom header mode on IMP

    This API is used to set Broadcom header mode on IMP

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      info            Pointer to #MgmtInfoType handle
    @param[in]      brcmHdrMode     Broadcom header mode value

    @return     #BCM_ERR_OK             Broadcom header mode set successfully
    @return     #BCM_ERR_INVAL_PARAMS   Invalid info pointer
    @return     #BCM_ERR_INVAL_PARAMS   Invalid brcmHdrMode
    @return     #BCM_ERR_UNKNOWN        Error reported by target

    @post None

    @limitations None
*/
extern int32_t HOST_EtherSwtBrcmHdrModeSet(MgmtInfoType *info,
        ETHSWT_BrcmHdrModeType brcmHdrMode);

/** @brief Set port administrative mode

    This API is used to set port administrative mode

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      info            Pointer to #MgmtInfoType handle
    @param[in]      port            Port number
    @param[in]      admin_mode      Administrative mode

    @return     #BCM_ERR_OK             Port administrative mode set successfully
    @return     #BCM_ERR_INVAL_PARAMS   Invalid info pointer
    @return     #BCM_ERR_INVAL_PARAMS   Invalid admin_mode
    @return     #BCM_ERR_UNKNOWN        Error reported by target

    @post None

    @limitations None
*/
extern int32_t HOST_EtherSwtXcvrAdminModeSet(MgmtInfoType *info, uint32_t port,
                                             ETHXCVR_ModeType admin_mode);

/** @brief Set port master/slave mode

    This API is used to set port master/slave mode

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      info            Pointer to #MgmtInfoType handle
    @param[in]      port            Port numberr
    @param[in]      brMode          Master/slave mode

    @return     #BCM_ERR_OK             Master/slave mode set successfully
    @return     #BCM_ERR_INVAL_PARAMS   Invalid info pointer
    @return     #BCM_ERR_INVAL_PARAMS   Invalid brMode
    @return     #BCM_ERR_UNKNOWN        Error reported by target

    @post None

    @limitations None
*/
extern int32_t HOST_EtherSwtXcvrMasterSlaveSet(MgmtInfoType *info,
        uint32_t port, ETHXCVR_BooleanType brMode);

/** @brief Set Phy loop-back mode

    This API is used to set phy loop-back mode

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      info            Pointer to #MgmtInfoType handle
    @param[in]      port            Port number
    @param[out]     loopBackMode    Loop-back mode

    @return     #BCM_ERR_OK             Loop-back mode set successfully
    @return     #BCM_ERR_INVAL_PARAMS   Invalid info pointer
    @return     #BCM_ERR_INVAL_PARAMS   Invalid loopBackMode
    @return     #BCM_ERR_UNKNOWN        Error reported by target

    @post None

    @limitations None
*/
extern int32_t HOST_EtherSwtXcvrPhyLbSet(MgmtInfoType *info, uint32_t port,
                                         ETHXCVR_BooleanType loopBackMode);

/** @brief Set Jumbo frame mode

    This API is used to set port specific jumbo frame mode

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      info            Pointer to #MgmtInfoType handle
    @param[in]      port            Port number
    @param[out]     jumboFrameMode  Jumbo frame mode

    @return     #BCM_ERR_OK             Jumbo frame mode set successfully
    @return     #BCM_ERR_INVAL_PARAMS   Invalid info pointer
    @return     #BCM_ERR_INVAL_PARAMS   Invalid jumboFrameMode
    @return     #BCM_ERR_UNKNOWN        Error reported by target

    @post None

    @limitations None
*/
extern int32_t HOST_EtherSwtXcvrJumboFrameModeSet(MgmtInfoType *info,
        uint32_t port, ETHXCVR_BooleanType jumboFrameMode);

/** @brief Set Pvid and priority

    This API is used to set Pvid and priority

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      info            Pointer to #MgmtInfoType handle
    @param[in]      port            Port number
    @param[in]      pvid            PVID value
    @param[in]      prio            Priority

    @return     #BCM_ERR_OK             Pvid and priority set successfully
    @return     #BCM_ERR_INVAL_PARAMS   Invalid info pointer
    @return     #BCM_ERR_UNKNOWN        Error reported by target

    @post None

    @limitations None
*/
extern int32_t HOST_EtherSwtVlanPvidSet(MgmtInfoType *info, uint32_t port,
        uint32_t pvid, uint32_t prio);

/** @brief Get VLAN information

    This API is used to get VLAN information

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      info            Pointer to #MgmtInfoType handle
    @param[in]      vlan            VLAN ID
    @param[out]     portMask        Pointer to obtain port bitmask
    @param[out]     tagMask         Pointer to obtain tagged port bitmask
    @param[out]     staticPortMask      Pointer to obtain static port bitmask

    @return     #BCM_ERR_OK             VLAN information obtained successfully
    @return     #BCM_ERR_INVAL_PARAMS   Invalid info pointer
    @return     #BCM_ERR_INVAL_PARAMS   Invalid portMask pointer
    @return     #BCM_ERR_INVAL_PARAMS   Invalid tagMask pointer
    @return     #BCM_ERR_UNKNOWN        Error reported by target

    @post None

    @limitations None
*/
int32_t HOST_EtherSwtVlanGet(MgmtInfoType *info, uint16_t vlan, uint32_t *portMask,
        uint32_t *tagMask, uint32_t *staticPortMask);

/** @brief VLAN addition

    This API is used to add a VLAN

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      info            Pointer to #MgmtInfoType handle
    @param[in]      vlan            VLAN ID
    @param[in]      portMask        Port bitmask
    @param[in]      tagMask         Tagged port bitmask

    @return     #BCM_ERR_OK             VLAN added successfully
    @return     #BCM_ERR_INVAL_PARAMS   Invalid info pointer
    @return     #BCM_ERR_UNKNOWN        Error reported by target

    @post None

    @limitations None
*/
extern int32_t HOST_EtherSwtVlanPortAdd(MgmtInfoType *info, uint16_t vlan,
        uint32_t portMask, uint32_t tagMask);

/** @brief VLAN deletion

    This API is used to delete a VLAN

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      info            Pointer to #MgmtInfoType handle
    @param[in]      vlan            VLAN ID
    @param[in]      portMask        Port bitmask

    @return     #BCM_ERR_OK             VLAN deleted successfully
    @return     #BCM_ERR_INVAL_PARAMS   Invalid info pointer
    @return     #BCM_ERR_UNKNOWN        Error reported by target

    @post None

    @limitations None
*/
extern int32_t HOST_EtherSwtVlanPortDel(MgmtInfoType *info, uint16_t vlan, uint32_t portMask);

/** @brief ARL addition

    This API is used to add an ARL entry

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      info            Pointer to #MgmtInfoType handle
    @param[in]      mac_addr        Pointer to an character buffer MAC address
    @param[in]      vlan            VLAN ID
    @param[in]      partMask        Port bitmask

    @return     #BCM_ERR_OK             ARL added successfully
    @return     #BCM_ERR_INVAL_PARAMS   Invalid info pointer
    @return     #BCM_ERR_UNKNOWN        Error reported by target

    @post None

    @limitations None
*/
extern int32_t HOST_EtherSwtARLAdd(MgmtInfoType *info, uint8_t *mac_addr,
        uint16_t vlan, uint32_t portMask);

/** @brief ARL Deletion

    This API is used to delete an ARL entry

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      info            Pointer to #MgmtInfoType handle
    @param[in]      mac_addr        Pointer to an character buffer MAC address
    @param[in]      vlan            VLAN ID

    @return     #BCM_ERR_OK             ARL deleted successfully
    @return     #BCM_ERR_INVAL_PARAMS   Invalid info pointer
    @return     #BCM_ERR_UNKNOWN        Error reported by target

    @post None

    @limitations None
*/
extern int32_t HOST_EtherSwtARLDelete(MgmtInfoType *info, uint8_t *mac_addr,
        uint16_t vlan);

/** @brief ARL Snapshot

    This API is used to trigger copying the ARL buffer from hardware to target's
    local buffer

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      info            Pointer to #MgmtInfoType handle
    @param[out]     count           Pointer to get the number of entries cached

    @return     #BCM_ERR_OK             ARL snapshot completed successfully
    @return     #BCM_ERR_INVAL_PARAMS   Invalid info pointer
    @return     #BCM_ERR_UNKNOWN        Error reported by target

    @post None

    @limitations None
*/
extern int32_t HOST_EtherSwtARLSnapshot(MgmtInfoType *info, uint32_t *count);

/** @brief Get ARL entries

    This API is used to retrieve ARL entries from target's local buffer

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      info            Pointer to #MgmtInfoType handle
    @param[out]     entry           Pointer to an array of
                                    #ETHSWT_ARLEntryType entries
    @param[inout]   count           Maximum number of entries that the caller
                                    can accomodate and the actual number of
                                    entries that the callee has filled

    @return     #BCM_ERR_OK             ARL entries obtained successfully
    @return     #BCM_ERR_INVAL_PARAMS   Invalid info pointer
    @return     #BCM_ERR_INVAL_PARAMS   Invalid entry pointer
    @return     #BCM_ERR_INVAL_PARAMS   Invalid count pointer
    @return     #BCM_ERR_INVAL_PARAMS   Count is 0
    @return     #BCM_ERR_UNKNOWN        Error reported by target

    @post None

    @limitations None
*/
extern int32_t HOST_EtherSwtARLGet(MgmtInfoType *info,
        ETHSWT_ARLEntryType *entry, uint32_t *count);

/** @brief Set Ingress Filter mode

    This API is used to set ingress filter mode

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      info            Pointer to #MgmtInfoType handle
    @param[in]      iFilter         Ingress Filter mode

    @return     #BCM_ERR_OK             Ingress filter mode set successfully
    @return     #BCM_ERR_INVAL_PARAMS   Invalid info pointer
    @return     #BCM_ERR_INVAL_PARAMS   Invalid iFilter
    @return     #BCM_ERR_UNKNOWN        Error reported by target

    @post None

    @limitations None
*/
extern int32_t HOST_EtherSwtVlanIfilterSet(MgmtInfoType *info,
        ETHSWT_VLANIngressFilterModeType iFilter);

/** @brief Get Ingress filter mode

    This API is used to get ingress filter mode

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      info            Pointer to #MgmtInfoType handle
    @param[out]      iFilter         Pointer to obtain ingress filter mode

    @return     #BCM_ERR_OK             Ingress filter mode obtained successfully
    @return     #BCM_ERR_INVAL_PARAMS   Invalid info pointer
    @return     #BCM_ERR_INVAL_PARAMS   Invalid iFilter pointer
    @return     #BCM_ERR_UNKNOWN        Error reported by target

    @post None

    @limitations None
*/
extern int32_t HOST_EtherSwtVlanIfilterGet(MgmtInfoType *info,
        ETHSWT_VLANIngressFilterModeType *iFilter);

/** @brief Convert MAC address

    This API is used to convert MAC address from a string of the format
    xx:xx:xx:xx:xx:xx to a character array of hexadecimal numbers

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      info            Pointer to #MgmtInfoType handle
    @param[in]      mac_addr        Pointer to input string
    @param[out]     mac_hex         Character buffer pointer to store output
                                    hexadecimal numbers
    @param[out]     status          Pointer to retrieve the status of operation
                                    BCM_ERR_OK : MAC Address conversion
                                    successful
                                    BCM_ERR_INVAL_PARAMS : Invalid input MAC
                                    address string

    @return void

    @post None

    @limitations None
*/
extern void HOST_EtherSwtConvertMac(char *mac_addr, unsigned char *mac_hex, int32_t *status);

/** @brief Ethernet Switch Sub-group Notification Handler

    This API is meant to handle asynchronous notifications sent by the Ethernet
    Switch Sub-group on target

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      currentSlave    Slave ID
    @param[in]      notificationId  Notification ID
    @param[in]      msg             Message buffer pointer
    @param[in]      size            Size of the message buffer "msg" in bytes

    @return     #BCM_ERR_OK             Notification handled successfully
    @return     #BCM_ERR_INVAL_PARAMS   Invalid notificationId
    @return     #BCM_ERR_INVAL_PARAMS   Invalid msg pointer
    @return     #BCM_ERR_INVAL_PARAMS   Invalid size

    @post None

    @limitations None
*/
extern int32_t HOST_EtherSwtNotificationHandler(uint32_t currentSlave,
        uint8_t notificationId, uint8_t *msg, uint32_t size);

/** @brief Set Vlan-Hopping detection(enable/disable)

    This API sets Vlan-Hopping detection. If Vlan-Hopping
    detection is enabled, then any packet arriving with two tags
    with TPID 0x8100 should be discarded or sent to the CPU.

    @behavior Sync, Non re-entrant

    @pre None

    @param[in]      info                     Pointer to #MgmtInfoType handle
    @param[in]      aVlanHoppingAction       Vlan-Hopping action.

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully set Vlan-Hopping
                                        detection
    @retval     #BCM_ERR_TIME_OUT       Timeout occurred while reading/writing
                                        switch register
    @retval     #BCM_ERR_INVAL_PARAMS   (invalid Vlan-Hopping action) or
                                        (info is NULL)
    @retval     #BCM_ERR_NOPERM         CPU port is not available
                                        (Valid only for the action,
                                         redirect to CPU)
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post None

    @limitations None
*/

int32_t HOST_EtherSwtSetVlanHoppingDetection(MgmtInfoType *info,
                   ETHSWT_SecurityActionType aVlanHoppingAction);

/** @brief Get Vlan-Hopping detection(enable/disable) status

    This function retreives switch Vlan-Hopping detection
    (enable/disable) status.

    @behavior Sync, Non re-entrant

    @pre None

    @param[in]      info                     Pointer to #MgmtInfoType handle
    @param[out]     aVlanHoppingActionPtr    Pointer to Vlan-Hopping
                                             action.

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully retrieved Vlan-Hopping
                                        status
    @retval     #BCM_ERR_TIME_OUT       Timeout occurred while reading/writing
                                        switch register
    @retval     #BCM_ERR_INVAL_PARAMS   (aVlanHoppingAction is NULL) or
                                        (info is NULL)
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post None

    @limitations None
*/
int32_t HOST_EtherSwtGetVlanHoppingDetection(MgmtInfoType *info,
        ETHSWT_SecurityActionType * const aVlanHoppingActionPtr);

/** @brief Set station movement detection(enable with action/disable)

    If station movement detection is enabled and a MAC address
    has been learned by hardware on a port, and a packet with
    the same address as MAC-SA enters the switch from a different
    physical port, then it should be discarded or sent to the CPU.

    @behavior Sync, Non re-entrant

    @pre None

    @param[in]      info                     Pointer to #MgmtInfoType handle
    @param[in]      aPortID                  Port index
    @param[in]      aStationMoveAction       Station movement
                                             detection action

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully set station movement
                                        detection action
    @retval     #BCM_ERR_TIME_OUT       Timeout occurred while reading/writing
                                        switch register
    @retval     #BCM_ERR_INVAL_PARAMS   (info is NULL) or
                                        (Invalid aPortID) or
                                        (Invalid station movement detection
                                        action)
    @retval     #BCM_ERR_NOPERM         CPU port is not available
                                        (Valid only for the action,
                                         redirect to CPU)
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post None

    @limitations None
*/
int32_t HOST_EtherSwtSetStationMovementDetection(MgmtInfoType *info,
            ETHSWT_PortIDType aPortID, ETHSWT_SecurityActionType aStationMoveAction);

/** @brief Get station movement detection(enable/disable) status

    This API retreives switch station movement detection
    informations.

    @behavior Sync, Non re-entrant

    @pre None

    @param[in]      info                     Pointer to #MgmtInfoType handle
    @param[in]      aPortID                  Port index
    @param[out]     aStationMoveAction       Pointer to station movement
                                             detection action

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully retrieved station movement
                                        detection information information
    @retval     #BCM_ERR_TIME_OUT       Timeout occurred while reading/writing
                                        switch register
    @retval     #BCM_ERR_INVAL_PARAMS   (aStationMoveAction is NULL) or
                                        (Invalid aPortID) or
                                        (info is NULL)
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post None


    @limitations None
*/
int32_t HOST_EtherSwtGetStationMovementDetection(MgmtInfoType *info,
            ETHSWT_PortIDType aPortID, ETHSWT_SecurityActionType * const aStationMoveAction);

/** @brief Set sticky MAC Address action to the port

    This API sets the sticky MAC Address action to a port.
    If a single MAC address (or a small number of MAC addresses)
    is/are sticky to a port, then any packet arriving with Source
    MAC address which is sticky to that port should only be allowed.
    If the incoming packet is an IEEE 802.1X packet, or special
    frames, the incoming packets are forwarded.

    @behavior Sync, Non re-entrant

    @pre Hardware learning can be disabled.

    @param[in]      info                     Pointer to #MgmtInfoType handle
    @param[in]      aPortID                  Port index
    @param[in]      aStickyMACAction         Sticky MAC address
                                             action

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully set sticky MAC Address
                                        action to the port
    @retval     #BCM_ERR_TIME_OUT       Timeout occurred while reading/writing
                                        switch register
    @retval     #BCM_ERR_INVAL_PARAMS   (info is NULL) or
                                        (Invalid aPortID) or
                                        (Invalid sticky MAC address
                                        action)
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized
    @retval     #BCM_ERR_NOPERM         CPU port is not available
                                        (Valid only for the action,
                                        redirect to CPU)

    @post None


    @limitations None
*/
int32_t HOST_EtherSwtSetMACAddressStickyToPort(MgmtInfoType *info,
            ETHSWT_PortIDType aPortID, ETHSWT_SecurityActionType aStickyMACAction);

/** @brief Get sticky MAC Address information to the port

    This API retreives sticky MAC Address information
    of the provided port.

    @behavior Sync, Non re-entrant

    @pre Hardware learning can be disabled.

    @param[in]      info                     Pointer to #MgmtInfoType handle
    @param[in]      aPortID                  Port index
    @param[out]     aStickyMACAction         Pointer to sticky MAC address
                                             action

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully retrieved sticky MAC
                                        Address information to the port
    @retval     #BCM_ERR_TIME_OUT       Timeout occurred while reading/writing
                                        switch register
    @retval     #BCM_ERR_INVAL_PARAMS   (info is NULL) or
                                        (Invalid aPortID) or
                                        (aStickyMACAction is NULL)
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post None


    @limitations None
*/
int32_t HOST_EtherSwtGetMACAddressStickyToPort(MgmtInfoType *info,
        ETHSWT_PortIDType aPortID, ETHSWT_SecurityActionType * const aStickyMACAction);

/** @brief Set address limiting information of the port

    This API sets the maximum number of MAC addresses that are learned on
    the port. Only limits the number of dynamically learned unicast
    MAC addresses. MAC addresses configured by the CPU are not counted
    against the limit. API also sets the action, which will be triggered
    if the count of dynamically learned unicast MAC addresses on this
    port exceeds with the programmed value.

    @behavior Sync, Non re-entrant

    @pre None

    @param[in]      info                     Pointer to #MgmtInfoType handle
    @param[in]      aPortID                  Port index
    @param[in]      aOverLimitAction         Address limiting action
    @param[in]      aMacLearningLimit        Address limit value

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully set address limiting information
                                        for the port
    @retval     #BCM_ERR_TIME_OUT       Timeout occurred while reading/writing
                                        switch register
    @retval     #BCM_ERR_INVAL_PARAMS   (info is NULL) or
                                        (Invalid aPortID) or
                                        (Invalid address limit
                                        action or value)
    @retval     #BCM_ERR_NOPERM         CPU port is not available
                                        (Valid only for the action,
                                        redirect to CPU and copy to CPU)
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post None


    @limitations None
*/
int32_t HOST_EtherSwtSetPortAddrLimiting(MgmtInfoType *info,
                   ETHSWT_PortIDType aPortID,
                   ETHSWT_SecurityActionType aOverLimitAction,
                   uint16_t aMacLearningLimit);

/** @brief Get address limiting information for the port

    This API retreives switch address limiting information
    of the provided port.

    @behavior Sync, Non re-entrant

    @pre None

    @param[in]      info                     Pointer to #MgmtInfoType handle
    @param[in]      aPortID                  Port index
    @param[out]     aOverLimitAction         Pointer address limiting action
    @param[out]     aMacLearningLimit        Pointer address limit value
    @param[out]     aPortLearnedCounter      pointer to the number
                                             of SA MAC addresses
                                             learned on this ports.
                                             This counter can't exceed
                                             the max programmed learning
                                             value of this port
    @param[out]     aPortOverLimitCounter    pointer to the overlimit
                                             counter value of this ports.
                                             This counter is the number of
                                             packets ingress to this port after
                                             port SA learn counter exceeds to
                                             SA learn limit.

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully retrieved address limiting
                                        information of the provided port
    @retval     #BCM_ERR_TIME_OUT       Timeout occurred while reading/writing
                                        switch register
    @retval     #BCM_ERR_INVAL_PARAMS   (info is NULL) or
                                        (Invalid aPortID) or
                                        (aOverLimitAction is NULL) or
                                        (aAddressLimitInfo is NULL) or
                                        (aMacLearningLimit is NULL) or
                                        (aPortLearnedCounter is NULL) or
                                        (aPortOverLimitCounter is NULL)
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post None


    @limitations None
*/
int32_t HOST_EtherSwtGetPortAddrLimitAndCounter(MgmtInfoType *info,
                   ETHSWT_PortIDType aPortID,
                   ETHSWT_SecurityActionType * const aOverLimitAction,
                   uint16_t * const aMacLearningLimit,
                   uint16_t * const aPortLearnedCounter,
                   uint32_t * const aPortOverLimitCounter);

/** @brief Set total MAC-SA limiting control

    This API sets the maximum number of MAC addresses that are learned
    accross all the port. When Address Limit is reached (i.e.,  either
    port-wise limit is reached or overall limit is reached), the subsequent
    actions are controlled by the over limit action field of the corresponding
    port.

    @behavior Sync, Non re-entrant

    @pre None

    @param[in]      info                     Pointer to #MgmtInfoType handle
    @param[in]      aTotalMACLearningLimit   maximum number of MAC
                                             addresses allowed to
                                             learn across all ports

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully set address limiting information
                                        for the port
    @retval     #BCM_ERR_TIME_OUT       Timeout occurred while reading/writing
                                        switch register
    @retval     #BCM_ERR_INVAL_PARAMS   (info is NULL) or
                                        (aTotalMACLearningLimit
                                        is greater than the maximum
                                        ARL table size)
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post None


    @limitations None
*/
int32_t HOST_EtherSwtSetTotalAddrLimit(MgmtInfoType *info,
                     uint16_t aTotalMACLearningLimit);

/** @brief Get total MAC-SA limiting control

    This API retreives total MAC-SA limit accross
    all the port.

    @behavior Sync, Non re-entrant

    @pre None

    @param[in]      info                     Pointer to #MgmtInfoType handle
    @param[out]     aTotalMACLearningLimit   pointer to maximum
                                             number of MAC
                                             addresses allowed to
                                             learn on all ports
    @param[out]     aTotalLearnedCounter     pointer to the number
                                             of SA MAC addresses
                                             learned on all ports.
                                             This counter can't exceed
                                             the max programmed learning
                                             value across all the port

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully set address limiting information
                                        for the port
    @retval     #BCM_ERR_TIME_OUT       Timeout occurred while reading/writing
                                        switch register
    @retval     #BCM_ERR_INVAL_PARAMS   (info is NULL) or
                                        (aTotalMACLearningLimit
                                        is NULL) or (aTotalLearnedCounter
                                        is NULL)
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post None


    @limitations None
*/
int32_t HOST_EtherSwtGetTotalAddrLimitAndCounter(MgmtInfoType *info,
                                uint16_t * const aTotalMACLearningLimit,
                                uint16_t * const aTotalLearnedCounter);

/** @brief Get WakeUp Mode

    This API is used to Query the wakeup Mode Enable Setting

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      info        Pointer to #MgmtInfoType handle
    @param[in]      port        Port number
    @param[out]     aMode       Pointer to WakeUp Mode

    @return     #BCM_ERR_OK             WakeUpMode retrieved successfully
    @return     #BCM_ERR_INVAL_PARAMS   Invalid info pointer
    @return     #BCM_ERR_UNKNOWN        Error reported by target

    @post None

    @limitations None
*/
int32_t HOST_EtherSwtGetWakeupMode(MgmtInfoType *info, uint32_t aPort, uint8_t *const aMode);

/** @brief Get WakeUp Reason

    This API is used to Query the wakeup Reason

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      info        Pointer to #MgmtInfoType handle
    @param[in]      port        Port number
    @param[out]     aMode       Pointer to read WakeUp Reason

    @return     #BCM_ERR_OK             WakeUp Reason Read successfully
    @return     #BCM_ERR_INVAL_PARAMS   Invalid info pointer
    @return     #BCM_ERR_UNKNOWN        Error reported by target

    @post None

    @limitations None
*/
int32_t HOST_EtherSwtGetWakeupReason(MgmtInfoType *info, uint32_t aPort, uint8_t *const aReason);

#endif /* HOST_ETHERSWT_H */

/** @} */
