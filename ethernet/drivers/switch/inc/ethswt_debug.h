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
    @defgroup grp_ethswt_debug_ifc Debug Interface
    @ingroup grp_ethswt

    @addtogroup grp_ethswt_debug_ifc
    @{

    @file ethswt_debug.h
    @brief Application programmer interface for Ethernet Switch Driver (Debug)

    @version 0.51 Imported from docx
 */

#ifndef ETHSWT_DEBUG_H
#define ETHSWT_DEBUG_H

#include <compiler.h>
#include <ethswt_common.h>
#include <ethernet_swt_debug.h>

/**
    @name Ethernet Switch driver API IDs
    @{
    @brief API IDs for  Ethernet Switch driver
*/
#define BRCM_SWARCH_ETHSWT_SET_PORT_MIRROR_CFG_PROC        (0x8904U)    /**< @brief #ETHSWT_SetPortMirrorConfig  */
#define BRCM_SWARCH_ETHSWT_GET_PORT_MIRROR_CFG_PROC        (0x8905U)    /**< @brief #ETHSWT_GetPortMirrorConfig  */
#define BRCM_SWARCH_ETHSWT_SET_PORT_MIRROR_STATE_PROC      (0x8906U)    /**< @brief #ETHSWT_SetPortMirrorState   */
#define BRCM_SWARCH_ETHSWT_GET_PORT_MIRROR_STATE_PROC      (0x8907U)    /**< @brief #ETHSWT_GetPortMirrorState   */
#define BRCM_SWARCH_ETHSWT_GET_MIRROR_CAPTURE_PORT_PROC    (0x8908U)    /**< @brief #ETHSWT_GetMirrorCapturePort */
#define BRCM_SWARCH_ETHSWT_GET_RX_STAT_PROC                (0x8909U)    /**< @brief #ETHSWT_GetRxStat            */
#define BRCM_SWARCH_ETHSWT_CLEAR_RX_STAT_PROC              (0x890AU)    /**< @brief #ETHSWT_ClearRxStat          */
#define BRCM_SWARCH_ETHSWT_GET_TX_STAT_PROC                (0x890BU)    /**< @brief #ETHSWT_GetTxStat            */
#define BRCM_SWARCH_ETHSWT_CLEAR_TX_STAT_PROC              (0x890CU)    /**< @brief #ETHSWT_ClearTxStat          */
#define BRCM_SWARCH_ETHSWT_LED_TYPE                        (0x890DU)    /**< @brief #ETHSWT_LedType              */
#define BRCM_SWARCH_ETHSWT_SET_LED_STATE_PROC              (0x890EU)    /**< @brief #ETHSWT_SetLedState          */
#define BRCM_SWARCH_ETHSWT_GET_LEDSTATE_PROC               (0x890FU)    /**< @brief #ETHSWT_GetLedState          */
/** @} */

/** @} */

/** @brief Set port mirror configuration

    This API sets port mirror configurations for indexed switch port. After
    mirror configuration, user shall call #ETHSWT_SetPortMirrorState API to
    enable or disable the port mirroring.

    @behavior Sync, Re-entrant for different aPortID or aSwtID

    @pre TBD

    @param[in]      aSwtID        Switch index
    @param[in]      aPortID       Port index
    @param[in]      aDirection    Traffic direction
    @param[in]      aConfig       Pointer to port mirror configurations

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully set port mirror
                                        configuration
    @retval     #BCM_ERR_TIME_OUT       Timeout occurred while reading/writing
                                        switch register
    @retval     #BCM_ERR_INVAL_PARAMS   (Invalid traffic direction) or
                                        (Invalid configuration) or
                                        (Invalid port index) or
                                        (aConfig is NULL) or
                                        (Invalid switch index)
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post TBD

    @trace  #BRCM_SWREQ_ETHSWT_DYNAMIC_CONFIGURATION

    @limitations None
*/
int32_t ETHSWT_SetPortMirrorConfig(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID,
        ETHSWT_TrafficDirType aDirection,
        ETHSWT_PortMirrorCfgType *const aConfig);

/** @brief Get port mirror configuration

    This API retrieves port mirror configurations for indexed switch port.

    @behavior Sync, Re-entrant for different aPortID or aSwtID

    @pre TBD

    @param[in]      aSwtID        Switch index
    @param[in]      aPortID       Port index
    @param[in]      aDirection    Traffic direction
    @param[out]     aConfig       Pointer to retrieve port mirror configurations

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully retrieved port mirror
                                        configurations
    @retval     #BCM_ERR_TIME_OUT       Timeout occurred while reading/writing
                                        switch registers
    @retval     #BCM_ERR_INVAL_STATE    aPortID not previously configured as
                                        mirror capture port
    @retval     #BCM_ERR_INVAL_PARAMS   (Invalid traffic direction) or
                                        (Invalid Port ID) or
                                        (aConfig is NULL) or
                                        (Invalid switch index)
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post TBD

    @trace  #BRCM_SWREQ_ETHSWT_QUERY

    @limitations None
*/
int32_t ETHSWT_GetPortMirrorConfig(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID,
        ETHSWT_TrafficDirType aDirection,
        ETHSWT_PortMirrorCfgType *const aConfig);

/** @brief Set port mirror state

    This API sets port mirror state for indexed switch port. Port mirroring only
    works if the user has configured the capture port previously by calling
    #ETHSWT_SetPortMirrorConfig API.

    @behavior Sync, Re-entrant for different aPortID or aSwtID

    @pre TBD

    @param[in]      aSwtID      Switch index
    @param[in]      aPortID     Port index
    @param[in]      aState      Port mirror state

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully set port mirror state
    @retval     #BCM_ERR_TIME_OUT       Timeout occurred while reading/writing
                                        switch registers
    @retval     #BCM_ERR_INVAL_STATE    aPortID not previously configured as
                                        mirror capture port
    @retval     #BCM_ERR_INVAL_PARAMS   (Invalid port mirror state) or
                                        (Invalid port index) or
                                        (Invalid switch index)
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post TBD

    @trace  #BRCM_SWREQ_ETHSWT_DYNAMIC_CONFIGURATION

    @limitations None
*/
int32_t ETHSWT_SetPortMirrorState(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID,
        ETHSWT_PortMirrorStateType aState);

/** @brief Get port mirror state

    This API retrieves port mirror state for the given switch

    @behavior Sync, Re-entrant for different aPortID or aSwtID

    @pre TBD

    @param[in]      aSwtID      Switch index
    @param[in]      aPortID     Port index
    @param[out]     aState      Pointer to retrieve port mirror state

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully retrieve port mirror state
    @retval     #BCM_ERR_INVAL_STATE    aPortID not previously configured as
                                        mirror capture port
    @retval     #BCM_ERR_TIME_OUT       Timeout occurred while reading/writing
                                        switch registers
    @retval     #BCM_ERR_INVAL_PARAMS   (Invalid port index) or
                                        (Invalid switch index)
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post TBD

    @trace  #BRCM_SWREQ_ETHSWT_QUERY

    @limitations None
*/
int32_t ETHSWT_GetPortMirrorState(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID,
        ETHSWT_PortMirrorStateType *const aState);

/** @brief Get mirror capture port

    This API retrieves mirroring capture port for the given switch

    @behavior Sync, Re-entrant for different aSwtID

    @pre TBD

    @param[in]      aSwtID      Switch index
    @param[out]     aPortID     Pointer to retrieve capture port index

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully retrieve capture port
    @retval     #BCM_ERR_NOT_FOUND      No capture port is configured.
    @retval     #BCM_ERR_TIME_OUT       Timeout occurred while reading/writing
                                        switch registers
    @retval     #BCM_ERR_INVAL_PARAMS   (aPortID is NULL) or
                                        (Invalid switch index)
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post TBD

    @trace  #BRCM_SWREQ_ETHSWT_QUERY

    @limitations None
*/
int32_t ETHSWT_GetMirrorCapturePort(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType *const aPortID);

/** @brief Get RX statistics

    This API retrieves Rx statistics for indexed switch port.

    @behavior Sync, Re-entrant for different aPortID or aSwtID

    @pre TBD

    @param[in]      aSwtID      Switch index
    @param[in]      aPortID     Port index
    @param[out]     aRxStat     Pointer to retrieve RX statistics

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully retrieved port RX
                                        statistics
    @retval     #BCM_ERR_TIME_OUT       Timeout occurred while reading/writing
                                        switch registers
    @retval     #BCM_ERR_INVAL_PARAMS   (Invalid port index) or
                                        (aRxStat is NULL) or
                                        (Invalid switch index)
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post TBD

    @trace  #BRCM_SWREQ_ETHSWT_QUERY

    @limitations None
*/
int32_t ETHSWT_GetRxStat(ETHSWT_HwIDType aSwtID,
         ETHSWT_PortIDType aPortID,
         ETHER_RxStatsType *const aRxStat);

/** @brief Clear RX statistics

    This API Clear Rx statistics for indexed switch port.

    @behavior Sync, Re-entrant for different aPortID or aSwtID

    @pre TBD

    @param[in]      aSwtID      Switch index
    @param[in]      aPortID     Port index

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully cleared port RX
                                        statistics
    @retval     #BCM_ERR_TIME_OUT       Timeout occurred while reading/writing
                                        switch registers
    @retval     #BCM_ERR_INVAL_PARAMS   (Invalid port index) or
                                        (Invalid switch index)
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post TBD

    @trace  #BRCM_SWREQ_ETHSWT_DYNAMIC_CONFIGURATION

    @limitations None
*/
int32_t ETHSWT_ClearRxStat(ETHSWT_HwIDType aSwtID,
         ETHSWT_PortIDType aPortID);

/** @brief Get TX statistics

    This API retrieves TX statistics for indexed switch port.

    @behavior Sync, Re-entrant for different aPortID or aSwtID

    @pre TBD

    @param[in]      aSwtID      Switch index
    @param[in]      aPortID     Port index
    @param[out]     aTxStat     Pointer to retrieve TX statistics

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully retrieved port TX
                                        statistics
    @retval     #BCM_ERR_TIME_OUT       Timeout occurred while reading/writing
                                        switch registers
    @retval     #BCM_ERR_INVAL_PARAMS   (Invalid port index) or
                                        (aTxStat is NULL) or
                                        (Invalid switch index)
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post TBD

    @trace  #BRCM_SWREQ_ETHSWT_QUERY

    @limitations None
*/
int32_t ETHSWT_GetTxStat(ETHSWT_HwIDType aSwtID,
         ETHSWT_PortIDType aPortID,
         ETHER_TxStatsType *const aTxStat);

/** @brief Clear TX statistics

    This API clears TX statistics for indexed switch port.

    @behavior Sync, Re-entrant for different aPortID or aSwtID

    @pre TBD

    @param[in]      aSwtID      Switch index
    @param[in]      aPortID     Port index

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully cleared port TX
                                        statistics
    @retval     #BCM_ERR_TIME_OUT       Timeout occurred while reading/writing
                                        switch registers
    @retval     #BCM_ERR_INVAL_PARAMS   (Invalid port index) or
                                        (Invalid switch index)
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post TBD

    @trace  #BRCM_SWREQ_ETHSWT_DYNAMIC_CONFIGURATION

    @limitations None
*/
int32_t ETHSWT_ClearTxStat(ETHSWT_HwIDType aSwtID,
         ETHSWT_PortIDType aPortID);

/**
    @name Switch LED type
    @{
    @brief Switch LED type

    @trace #BRCM_SWREQ_ETHSWT_KERNEL_INTERFACE
*/
typedef uint32_t ETHSWT_LedType;            /**< @brief Switch LED type */
#define ETHSWT_LED_AVB            (1UL)     /**< @brief AVB LED */
/** @} */

/** @brief Set LED state

    This API sets the LED state as per aTurnOn parameter for the given LED type.

    @behavior Sync, Re-entrant

    @pre TBD

    @param[in]      aArg1       Brief description of aArg1
    @param[in]      aSwtID      Switch index
    @param[in]      aPortID     Port index
    @param[in]      aLedType    LED Type
    @param[in]      aTurnOn     Flag to indicate the state of LED
                             - #TRUE: LED turn-on
                             - #FALSE: LED turn-off

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successful
    @todo       #BCM_ERR_NOSUPPORT
    @retval     #BCM_ERR_TIME_OUT       Timeout occurred while reading/writing
                                     switch registers
    @retval     #BCM_ERR_INVAL_PARAMS   (Invalid switch index) or
                                     (LED type is not supported) or
                                     (aTurnOn in invalid) or
                                     (Invalid port ID)
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post TBD

    @trace  #BRCM_SWREQ_ETHSWT_DYNAMIC_CONFIGURATION

    @limitations None
*/
extern int32_t ETHSWT_SetLedState(ETHSWT_HwIDType aSwtID,
                             ETHSWT_PortIDType aPortID,
                             ETHSWT_LedType aLedType,
                             uint32_t aTurnOn);

/** @brief Get LED state

    This API retrieves LED state for the given port index

    @behavior Sync, Re-entrant

    @pre TBD

    @param[in]      aSwtID          Switch index
    @param[in]      aPortID         Port index
    @param[in]      aLedType        LED Type
    @param[in]      aIsLedStateOn   Pointer to retrieve LED state
                                 - #TRUE: LED turn-on
                                 - #FALSE: LED turn-off

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successful
    @todo       #BCM_ERR_NOSUPPORT
    @retval     #BCM_ERR_TIME_OUT       Timeout occurred while reading/writing
                                     switch registers
    @retval     #BCM_ERR_INVAL_PARAMS   (Invalid switch index) or
                                     (LED type is not supported) or
                                     (aIsLedStateOn in NULL) or
                                     (Invalid port ID)
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post TBD

    @trace  #BRCM_SWREQ_ETHSWT_QUERY

    @limitations None
*/
extern int32_t ETHSWT_GetLedState(ETHSWT_HwIDType aSwtID,
                             ETHSWT_PortIDType aPortID,
                             ETHSWT_LedType aLedType,
                             uint32_t *const aIsStateOn);

#endif /* ETHSWT_DEBUG_H */

/** @} */
