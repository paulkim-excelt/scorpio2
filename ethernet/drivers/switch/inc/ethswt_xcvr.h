/*****************************************************************************
 Copyright 2017-2021 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_ethswt_xcvr_ifc XCVR Interface
    @ingroup grp_ethswt

    @addtogroup grp_ethswt_xcvr_ifc
    @{

    @limitations None

    @file ethswt_xcvr.h
    @brief Application programmer interface for Ethernet Switch Driver (XCVR)

    @version 0.51 Imported from docx
 */

#ifndef ETHSWT_XCVR_H
#define ETHSWT_XCVR_H

#include <compiler.h>
#include <ethxcvr.h>
#include <ethernet_xcvr_common.h>
#include <ethernet_swt_common.h>

/**
    @name Ethernet Switch driver (XCVR) API IDs
    @{
    @brief API IDs for  Ethernet Switch driver (XCVR)
*/
#define BRCM_SWARCH_ETHSWT_GET_PORT_TYPE_PROC              (0x8401U)    /**< @brief #ETHSWT_GetPortType          */
#define BRCM_SWARCH_ETHSWT_GET_PORT_MODE_PROC              (0x8402U)    /**< @brief #ETHSWT_GetPortMode          */
#define BRCM_SWARCH_ETHSWT_SET_PORT_MODE_PROC              (0x8403U)    /**< @brief #ETHSWT_SetPortMode          */
#define BRCM_SWARCH_ETHSWT_GET_PORT_LINK_STATE_PROC        (0x8404U)    /**< @brief #ETHSWT_GetPortLinkState     */
#define BRCM_SWARCH_ETHSWT_GET_PORT_SPEED_PROC             (0x8405U)    /**< @brief #ETHSWT_GetPortSpeed         */
#define BRCM_SWARCH_ETHSWT_GET_PORT_DUPLEX_MODE_PROC       (0x8406U)    /**< @brief #ETHSWT_GetPortDuplexMode    */
#define BRCM_SWARCH_ETHSWT_GET_SQI_VAL_PROC                (0x8407U)    /**< @brief #ETHSWT_GetSQIValue          */
#define BRCM_SWARCH_ETHSWT_SET_PORT_SPEED_PROC             (0x8408U)    /**< @brief #ETHSWT_SetPortSpeed         */
#define BRCM_SWARCH_ETHSWT_GET_PORT_MASTERMODE_PROC        (0x8409U)    /**< @brief #ETHSWT_GetPortMasterMode    */
#define BRCM_SWARCH_ETHSWT_SET_PORT_MASTERMODE_PROC        (0x840AU)    /**< @brief #ETHSWT_SetPortMasterMode    */
#define BRCM_SWARCH_ETHSWT_GET_PORT_LOOPBACKMODE_PROC      (0x840BU)    /**< @brief #ETHSWT_GetPortLoopbackMode  */
#define BRCM_SWARCH_ETHSWT_SET_PORT_LOOPBACKMODE_PROC      (0x840CU)    /**< @brief #ETHSWT_SetPortLoopbackMode  */
#define BRCM_SWARCH_ETHSWT_GET_PORT_JUMBOMODE_PROC         (0x840DU)    /**< @brief #ETHSWT_GetPortJumboMode     */
#define BRCM_SWARCH_ETHSWT_SET_PORT_JUMBOMODE_PROC         (0x840EU)    /**< @brief #ETHSWT_SetPortJumboMode     */
#define BRCM_SWARCH_ETHSWT_ENABLE_PORT_AUTONEG_PROC        (0x840FU)    /**< @brief #ETHSWT_EnablePortAutoNeg    */
#define BRCM_SWARCH_ETHSWT_GET_PORT_AUTONEG_STATUS_PROC    (0x8410U)    /**< @brief #ETHSWT_GetPortAutoNegStatus */
#define BRCM_SWARCH_ETHSWT_GET_XCVR_STATS_PROC             (0x8411U)    /**< @brief #ETHSWT_GetXcvrStats         */
#define BRCM_SWARCH_ETHSWT_XCVR_STATE_HANDLER_PROC         (0x8412U)    /**< @brief #ETHSWT_XcvrStateHandler     */
#define BRCM_SWARCH_ETHSWT_SET_PORTWAKEUP_MODE_PROC        (0x8414U)    /**< @brief #ETHSWT_SetPortWakeUpMode    */
#define BRCM_SWARCH_ETHSWT_GET_PORTWAKEUP_MODE_PROC        (0x8415U)    /**< @brief #ETHSWT_GetPortWakeUpMode    */
#define BRCM_SWARCH_ETHSWT_GET_PORTWAKEUPREASON_PROC       (0x8416U)    /**< @brief #ETHSWT_GetPortWakeUpReason  */
/** @} */

/** @brief Retrieve port type

    This API retrieves type of a particular port. This API retrieves type of the
    indexed switch port from system xcvr configuration.

    @behavior Sync, Re-entrant

    @pre TBD

    @param[in]      aSwtID      Switch index
    @param[in]      aPortID     Port index
    @param[out]     aBusMode    Pointer to retrieve Bus Mode
    @param[out]     aPhyMedia   Pointer to retrieve Phy Media

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully retrieved Port type
    @retval     #BCM_ERR_INVAL_PARAMS   (aType is NULL) or
                                        (Invalid switch index)
    @return     Others                  As returned by #SysCfg_GetXcvrConfig
    @retval     #BCM_ERR_NOT_FOUND      Port index not found in the given
                                        switch's port configuration list
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post TBD

    @trace  #BRCM_SWREQ_ETHSWT_XCVR

    @limitations None
*/
int32_t ETHSWT_GetPortType(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID,
        ETHXCVR_BusModeType *const aBusMode,
        ETHXCVR_PhyMediaType *const aPhyMedia);

/** @brief Retrieve port mode

    This API retrieves mode of a particular port. This API retrieves mode of the
    indexed switch port by calling #ETHXCVR_GetMode.

    @behavior Sync, Re-entrant

    @pre TBD

    @param[in]      aSwtID      Switch index
    @param[in]      aPortID     Port index
    @param[out]     aMode       Pointer to retrieve Port mode

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully retrieved Port mode
    @retval     #BCM_ERR_INVAL_PARAMS   (aMode is NULL) or
                                        (Invalid switch index)
    @return     Others                  As returned by #ETHXCVR_GetMode
    @retval     #BCM_ERR_NOT_FOUND      Port index not found in the given
                                        switch's port configuration list
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post TBD

    @trace  #BRCM_SWREQ_ETHSWT_XCVR

    @limitations None
*/
int32_t ETHSWT_GetPortMode(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID,
        ETHXCVR_ModeType *const aMode);

/** @brief Set port mode

    This API sets mode of a particular port. This API set mode of the indexed
    switch port by calling #ETHXCVR_SetMode.

    @behavior Sync, Re-entrant

    @pre TBD

    @param[in]      aSwtID      Switch index
    @param[in]      aPortID     Port index
    @param[in]      aMode       Port mode

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully set port mode
    @retval     #BCM_ERR_INVAL_PARAMS   Invalid switch index
    @return     Others                  As returned by #ETHXCVR_SetMode
    @retval     #BCM_ERR_NOT_FOUND      Port index not found in the given
                                        switch's port configuration list
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post TBD

    @trace  #BRCM_SWREQ_ETHSWT_XCVR

    @limitations None
*/
int32_t ETHSWT_SetPortMode(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID,
        ETHXCVR_ModeType aMode);

/** @brief Retrieve link state of a port

    This API retrieves link state of a particular port. This API retrieves link
    state of the indexed switch port by calling #ETHXCVR_GetLinkState.

    @behavior Sync, Re-entrant

    @pre TBD

    @param[in]      aSwtID      Switch index
    @param[in]      aPortID     Port index
    @param[out]     aLinkState  Pointer to retrieve port link state

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully retrieved Port link state
    @retval     #BCM_ERR_INVAL_PARAMS   (aLinkState is NULL) or
                                        (Invalid switch index)
    @return     Others                  As returned by #ETHXCVR_GetLinkState
    @retval     #BCM_ERR_NOT_FOUND      Port index not found in the given
                                        switch's port configuration list
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post TBD

    @trace  #BRCM_SWREQ_ETHSWT_XCVR

    @limitations None
*/
int32_t ETHSWT_GetPortLinkState(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID,
        ETHXCVR_LinkStateType *const aLinkState);

/** @brief Retrieve port speed

    This API retrieves speed of a particular port. This API retrieves speed of
    the indexed switch port by calling #ETHXCVR_GetSpeed.

    @behavior Sync, Re-entrant

    @pre TBD

    @param[in]      aSwtID      Switch index
    @param[in]      aPortID     Port index
    @param[out]     aSpeed      Pointer to retrieve port speed

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully retrieved port speed
    @retval     #BCM_ERR_INVAL_PARAMS   (aSpeed is NULL) or
                                        (Invalid switch index)
    @return     Others                  As returned by #ETHXCVR_GetSpeed
    @retval     #BCM_ERR_NOT_FOUND      Port index not found in the given
                                        switch's port configuration list
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post TBD

    @trace  #BRCM_SWREQ_ETHSWT_XCVR

    @limitations None
*/
int32_t ETHSWT_GetPortSpeed(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID,
        ETHXCVR_SpeedType *const aSpeed);

/** @brief Set port speed

    This API set speed of a particular port.

    @behavior Sync, Re-entrant

    @pre TBD

    @param[in]      aSwtID      Switch index
    @param[in]      aPortID     Port index
    @param[in]      aSpeed      Port speed

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully retrieved port speed
    @retval     #BCM_ERR_INVAL_PARAMS   (aSpeed is invalid) or
                                        (Invalid switch index)
    @return     Others                  As returned by #ETHXCVR_SetSpeed
    @retval     #BCM_ERR_NOT_FOUND      Port index not found in the given
                                        switch's port configuration list
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post TBD

    @trace  #BRCM_SWREQ_ETHSWT_XCVR

    @limitations None
*/
int32_t ETHSWT_SetPortSpeed(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID,
        ETHXCVR_SpeedType aSpeed);

/** @brief Retrieve port master/slave mode

    This API retrieves master/slave mode of a particular port.
    This API retrieves master/slave mode of the indexed switch port by
    calling #ETHXCVR_GetMasterMode.

    @behavior Sync, Re-entrant

    @pre TBD

    @param[in]      aSwtID      Switch index
    @param[in]      aPortID     Port index
    @param[out]     aMode       Pointer to retrieve port master/slave mode

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully retrieved port master mode
    @retval     #BCM_ERR_INVAL_PARAMS   If aMode is NULL or
                                        Invalid switch index
    @return     Others                  As returned by #ETHXCVR_GetMasterMode
    @retval     #BCM_ERR_NOT_FOUND      Port index not found in the given
                                        switch's port configuration list
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post TBD

    @trace  #BRCM_SWREQ_ETHSWT_XCVR

    @limitations None
*/
int32_t ETHSWT_GetPortMasterMode(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID,
        ETHXCVR_BooleanType *const aMode);

/** @brief Set port master/slave mode

    This API set master/slave mode of a particular port. This API sets
    master/slave mode of the indexed switch port by calling #ETHXCVR_SetMasterMode.

    @behavior Sync, Re-entrant

    @pre TBD

    @param[in]      aSwtID      Switch index
    @param[in]      aPortID     Port index
    @param[in]      aMode       Port master/slave mode

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully sets port master mode
    @retval     #BCM_ERR_INVAL_PARAMS   (aMode is invalid) or
                                        (Invalid switch index)
    @return     Others                  As returned by #ETHXCVR_SetMasterMode
    @retval     #BCM_ERR_NOT_FOUND      Port index not found in the given
                                        switch's port configuration list
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post TBD

    @trace  #BRCM_SWREQ_ETHSWT_XCVR

    @limitations None
*/
int32_t ETHSWT_SetPortMasterMode(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID,
        ETHXCVR_BooleanType aMode);

/** @brief Retrieve port loopback mode

    This API retrieves loopback mode of the indexed switch
    port by calling #ETHXCVR_GetLoopbackModeType.

    @behavior Sync, Re-entrant

    @pre TBD

    @param[in]      aSwtID      Switch index
    @param[in]      aPortID     Port index
    @param[out]     aMode       Pointer to retrieve port loopback mode

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully retrieved port loopback mode
    @retval     #BCM_ERR_INVAL_PARAMS   (aMode is NULL) or
                                        (Invalid switch index)
    @return     Others                  As returned by #ETHXCVR_GetLoopbackMode
    @retval     #BCM_ERR_NOT_FOUND      Port index not found in the given
                                        switch's port configuration list
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post TBD

    @trace  #BRCM_SWREQ_ETHSWT_XCVR

    @limitations None
*/
int32_t ETHSWT_GetPortLoopbackMode(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID,
        ETHXCVR_BooleanType *const aMode);

/** @brief Set port loopback mode

    This API set loopback mode of the indexed switch port by calling
    #ETHXCVR_SetLoopbackMode. This API sets PHY loopback.

    @behavior Sync, Re-entrant

    @pre TBD

    @param[in]      aSwtID      Switch index
    @param[in]      aPortID     Port index
    @param[in]      aMode       Port loopback mode

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully set port loopback mode
    @retval     #BCM_ERR_INVAL_PARAMS   (aMode is invalid) or
                                        (Invalid switch index)
    @return     Others                  As returned by #ETHXCVR_SetLoopbackMode
    @retval     #BCM_ERR_NOT_FOUND      Port index not found in the given
                                        switch's port configuration list
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post TBD

    @trace  #BRCM_SWREQ_ETHSWT_XCVR

    @limitations None
*/
int32_t ETHSWT_SetPortLoopbackMode(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID,
        ETHXCVR_BooleanType aMode);

/** @brief Retrieve port jumbo mode

    This API retrieves jumbo mode of a particular port.
    This API retrieves jumbo mode of the indexed switch
    port by calling #ETHXCVR_GetJumboModeType.

    @behavior Sync, Re-entrant

    @pre TBD

    @param[in]      aSwtID      Switch index
    @param[in]      aPortID     Port index
    @param[out]     aMode       Pointer to retrieve port jumbo mode

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully retrieved port jumbo mode
    @retval     #BCM_ERR_INVAL_PARAMS   (aMode is NULL) or
                                        (Invalid switch index)
    @return     Others                  As returned by #ETHXCVR_GetJumboMode
    @retval     #BCM_ERR_NOT_FOUND      Port index not found in the given
                                        switch's port configuration list
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post TBD

    @trace  #BRCM_SWREQ_ETHSWT_XCVR

    @limitations None
*/
int32_t ETHSWT_GetPortJumboMode(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID,
        ETHXCVR_BooleanType *const aMode);

/** @brief Set port jumbo mode

    This API set jumbo mode of a particular port. This API
    set jumbo mode of the indexed switch port by calling
    #ETHXCVR_SetJumboMode.

    @behavior Sync, Re-entrant

    @pre TBD

    @param[in]      aSwtID      Switch index
    @param[in]      aPortID     Port index
    @param[in]      aMode       Port jumbo mode

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully set port jumbo mode
    @retval     #BCM_ERR_INVAL_PARAMS   (aMode is invalid) or
                                        (Invalid switch index)
    @return     Others                  As returned by #ETHXCVR_SetJumboMode
    @retval     #BCM_ERR_NOT_FOUND      Port index not found in the given
                                        switch's port configuration list
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post TBD

    @trace  #BRCM_SWREQ_ETHSWT_XCVR

    @limitations None
*/
int32_t ETHSWT_SetPortJumboMode(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID,
        ETHXCVR_BooleanType aMode);

/** @brief Enable port start/re-start auto-negotiation

    This API is to start/re-start auto-negotiation of a particular port.
    This API start/restarts auto-negotiation of the indexed switch port
    by calling #ETHXCVR_EnableAutoNeg.

    @behavior Sync, Re-entrant

    @pre TBD

    @param[in]      aSwtID      Switch index
    @param[in]      aPortID     Port index

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully start/restart port auto-neg
    @retval     #BCM_ERR_INVAL_PARAMS   (aPort is invalid) or
                                        (Invalid switch index)
    @return     Others                  As returned by #ETHXCVR_EnableAutoNeg
    @retval     #BCM_ERR_NOT_FOUND      Port index not found in the given
                                        switch's port configuration list
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized
    @retval     #BCM_ERR_NOSUPPORT      Auto-neg not supported

    @post TBD

    @note Currently, this API is not supported.

    @trace  #BRCM_SWREQ_ETHSWT_XCVR

    @limitations None
*/
int32_t ETHSWT_EnablePortAutoNeg(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID);

/** @brief Get port auto-negotiation status

    This API get auto-negotiation of a particular port. This API
    retrieves auto-negotiation status of the indexed switch port
    by calling #ETHXCVR_GetAutoNegStatus.

    @behavior Sync, Re-entrant

    @pre TBD

    @param[in]      aSwtID          Switch index
    @param[in]      aPortID         Port index
    @param[out]     aAutoNegStatus  Pointer to retrieve Port auto-negotiation status

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully retrieved port auto-neg status
    @retval     #BCM_ERR_INVAL_PARAMS   (aAutoNegStatus is NULL) or
                                        (Invalid switch index)
    @return     Others                  As returned by #ETHXCVR_GetAutoNegStatus
    @retval     #BCM_ERR_NOT_FOUND      Port index not found in the given
                                        switch's port configuration list
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post TBD

    @trace  #BRCM_SWREQ_ETHSWT_XCVR

    @limitations None
*/
int32_t ETHSWT_GetPortAutoNegStatus(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID,
        ETHXCVR_AutoNegStatusType *const aAutoNegStatus);

/** @brief Retrieve duplex mode of a port

    This API retrieves duplex mode of a particular port. This API retrieves
    duplex mode of the indexed switch port by calling #ETHXCVR_GetDuplexMode.

    @behavior Sync, Re-entrant

    @pre TBD

    @param[in]      aSwtID      Switch index
    @param[in]      aPortID     Port index
    @param[out]     aDuplexMode Pointer to retrieve duplex mode

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully retrieved port duplex mode
    @retval     #BCM_ERR_INVAL_PARAMS   (aDuplexMode is NULL) or
                                        (Invalid switch index)
    @return     Others                  As returned by #ETHXCVR_GetDuplexMode
    @retval     #BCM_ERR_NOT_FOUND      Port index not found in the given
                                        switch's port configuration list
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post TBD

    @trace  #BRCM_SWREQ_ETHSWT_XCVR

    @limitations None
*/
int32_t ETHSWT_GetPortDuplexMode(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID,
        ETHXCVR_DuplexModeType *const aDuplexMode);

/** @brief Get port transceiver statistics

    This API retrieves statistics for indexed switch port - transceiver.

    @behavior Sync, Re-entrant for different aPortID or aSwtID

    @pre TBD

    @param[in]      aSwtID      Switch index
    @param[in]      aPortID     Port index
    @param[out]     aStats      Pointer to retrieve port statistics

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully retrieved port statistics
    @retval     #BCM_ERR_INVAL_PARAMS   (Invalid port index) or
                                        (aStats is NULL) or
                                        (Invalid switch index)
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post TBD

    @trace  #BRCM_SWREQ_ETHSWT_XCVR

    @limitations None
*/
int32_t ETHSWT_GetXcvrStats(ETHSWT_HwIDType aSwtID,
         ETHSWT_PortIDType aPortID,
         ETHSWT_PortStatsType *const aStats);

/** @brief Retrieve SQI value

    This API retrieves SQI value for indexed switch port. SQI value is retrieved
    by calling #ETHXCVR_GetSQIValue API.

    @behavior Sync, Re-entrant for different aPortID or aSwtID

    @pre TBD

    @param[in]      aSwtID      Switch index
    @param[in]      aPortID     Port index
    @param[out]     aSQIValue   Pointer to retrieve SQI value

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully retrieved port SQI value
    @retval     #BCM_ERR_INVAL_PARAMS   Invalid switch index
    @return     Others                  As returned by #ETHXCVR_GetSQIValue
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post TBD

    @trace  #BRCM_SWREQ_ETHSWT_XCVR

    @limitations None
*/
int32_t ETHSWT_GetSQIValue(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID,
        uint32_t *const aSQIValue);

/** @brief Ethernet Switch state handler

    This API triggers the state machine of Ethernet Switch driver

    @behavior Sync, Non re-entrant

    @pre None

    @param[in]      aSwtID      Switch index
    @param[in]      aPortID     Port index

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             State machine triggered successfully and
                                        is in IDLE state
    @retval     #BCM_ERR_INVAL_PARAMS   (Invalid switch index) or
                                        (Invalid port index)
    @retval     #BCM_ERR_EAGAIN         Transceiver driver state handler is
                                        busy processing previous state. Call
                                        state handler again.
    @retval     #BCM_ERR_UNKNOWN        Error from transceiver driver

    @post None

    @trace  #BRCM_SWREQ_ETHSWT_XCVR

    @limitations None
*/
int32_t ETHSWT_XcvrStateHandler(ETHSWT_HwIDType aSwtID,
                              ETHSWT_PortIDType aPortID);

/** @brief Ethernet Switch Port Wakeup Mode Enable

    This API Enables the Sleep Mode on the Capable PHY
    the indexed switch port by calling #ETHXCVR_SetWakeUpMode.

    @behavior Sync, Non re-entrant

    @pre None

    @param[in]      aSwtID      Switch index
    @param[in]      aPortID     Port index
    @param[in]      aMode       Wakeup Or Sleep Mode

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             State machine triggered successfully and
                                        is in IDLE state
    @retval     #BCM_ERR_INVAL_PARAMS   (Invalid switch index) or
                                        (Invalid port index) or
                                        (Invalid Mode)
    @retval     #BCM_ERR_EAGAIN         Transceiver driver state handler is
                                        busy processing previous state. Call
                                        state handler again.
    @retval     #BCM_ERR_UNKNOWN        Error from transceiver driver
    @retval     #BCM_ERR_NOSUPPORT      No Support

    @post None

    @trace  #BRCM_SWREQ_ETHSWT_XCVR

    @limitations None
*/
int32_t ETHSWT_SetPortWakeUpMode(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID,
        ETHXCVR_BooleanType aMode);

/** @brief Ethernet Switch Port Wakeup Mode Enable

    This API Query the Sleep Mode Enable Setting on the Capable PHY
    the indexed switch port by calling #ETHXCVR_GetWakeUpMode.

    @behavior Sync, Non re-entrant

    @pre None

    @param[in]      aSwtID      Switch index
    @param[in]      aPortID     Port index
    @param[Out]     aMode       WakeUpMode Enable Status

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             State machine triggered successfully and
                                        is in IDLE state
    @retval     #BCM_ERR_INVAL_PARAMS   (Invalid switch index) or
                                        (Invalid port index) or
                                        (Invalid Mode)
    @retval     #BCM_ERR_EAGAIN         Transceiver driver state handler is
                                        busy processing previous state. Call
                                        state handler again.
    @retval     #BCM_ERR_UNKNOWN        Error from transceiver driver
    @retval     #BCM_ERR_NOSUPPORT      No Support

    @post None

    @trace  #BRCM_SWREQ_ETHSWT_XCVR

    @limitations None
*/
int32_t ETHSWT_GetPortWakeUpMode(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID,
        ETHXCVR_BooleanType *const aMode);

/** @brief Ethernet Switch Port Wakeup Reason Report

    This API Reads the wakeup Reason on the Capable PHY
    the indexed switch port by calling #ETHXCVR_GetWakeUpReason.

    @behavior Sync, Non re-entrant

    @pre None

    @param[in]      aSwtID      Switch index
    @param[in]      aPortID     Port index
    @param[out]     aReason     WakeUp Reason Type

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             State machine triggered successfully and
                                        is in IDLE state
    @retval     #BCM_ERR_INVAL_PARAMS   (Invalid switch index) or
                                        (Invalid port index) or
                                        (aReason is NULL)
    @retval     #BCM_ERR_EAGAIN         Transceiver driver state handler is
                                        busy processing previous state. Call
                                        state handler again.
    @retval     #BCM_ERR_UNKNOWN        Error from transceiver driver
    @retval     #BCM_ERR_NOSUPPORT      No Support

    @post None

    @trace  #BRCM_SWREQ_ETHSWT_XCVR

    @limitations None
*/
int32_t ETHSWT_GetPortWakeUpReason(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID,
        ETHXCVR_WakeupReasonType *const aReason);

#endif /* ETHSWT_XCVR_H */

/** @} */
