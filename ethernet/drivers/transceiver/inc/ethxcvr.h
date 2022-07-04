/*****************************************************************************
 Copyright 2016-2022 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_eth_xcvrdrv_ifc Ethernet Transceiver Interface
    @ingroup grp_eth_xcvrdrv

    @addtogroup grp_eth_xcvrdrv_ifc
    @{

    @file ethxcvr.h
    @brief Ethernet Transceiver interface
    This header file contains the interface functions for Ethernet Transceiver

    @version 1.26 Imported from docx
*/

#ifndef ETH_XCVR_H
#define ETH_XCVR_H

#include <stddef.h>
#include <inttypes.h>
#include <bcm_err.h>
#include <ethernet_xcvr_common.h>

/**
    @name Ethernet Transceiver API IDs
    @{
    @brief API IDs for Ethernet Transceiver
*/
#define BRCM_SWARCH_ETHXCVR_MAX_PORTS_MACRO            (0x8501U)    /**< @brief #ETHXCVR_MAX_PORTS         */
#define BRCM_SWARCH_ETHXCVR_MAX_DRIVER_PARAMS_MACRO    (0x8502U)    /**< @brief #ETHXCVR_MAX_DRIVER_PARAMS */
#define BRCM_SWARCH_ETHXCVR_CONFIG_MAGIC_MACRO         (0x8503U)    /**< @brief #ETHXCVR_CONFIG_MAGIC      */
#define BRCM_SWARCH_ETHXCVR_ID_TYPE                    (0x8504U)    /**< @brief #ETHXCVR_IDType            */
#define BRCM_SWARCH_ETHXCVR_STATS_TYPE                 (0x850FU)    /**< @brief #ETHXCVR_StatsType         */
#define BRCM_SWARCH_ETHXCVR_KEYVALUEPAIR_TYPE          (0x8510U)    /**< @brief #ETHXCVR_KeyValuePairType  */
#define BRCM_SWARCH_ETHXCVR_BUSCONFIG_TYPE             (0x8511U)    /**< @brief #ETHXCVR_PhyConfigType     */
#define BRCM_SWARCH_ETHXCVR_PHYCONFIG_TYPE             (0x8512U)    /**< @brief #ETHXCVR_BusConfigType     */
#define BRCM_SWARCH_ETHXCVR_PORTCONFIG_TYPE            (0x8513U)    /**< @brief #ETHXCVR_PortConfigType    */
#define BRCM_SWARCH_ETHXCVR_CONFIG_TYPE                (0x8514U)    /**< @brief #ETHXCVR_ConfigType        */
#define BRCM_SWARCH_ETHXCVR_INIT_PROC                  (0x8516U)    /**< @brief #ETHXCVR_Init              */
#define BRCM_SWARCH_ETHXCVR_DEINIT_PROC                (0x8517U)    /**< @brief #ETHXCVR_DeInit            */
#define BRCM_SWARCH_ETHXCVR_SETMODE_PROC               (0x8518U)    /**< @brief #ETHXCVR_SetMode           */
#define BRCM_SWARCH_ETHXCVR_GETMODE_PROC               (0x8519U)    /**< @brief #ETHXCVR_GetMode           */
#define BRCM_SWARCH_ETHXCVR_SETMASTERMODE_PROC         (0x851AU)    /**< @brief #ETHXCVR_SetMasterMode     */
#define BRCM_SWARCH_ETHXCVR_GETMASTERMODE_PROC         (0x851BU)    /**< @brief #ETHXCVR_GetMasterMode     */
#define BRCM_SWARCH_ETHXCVR_GETLINKSTATE_PROC          (0x851CU)    /**< @brief #ETHXCVR_GetLinkState      */
#define BRCM_SWARCH_ETHXCVR_GETSPEED_PROC              (0x851DU)    /**< @brief #ETHXCVR_GetSpeed          */
#define BRCM_SWARCH_ETHXCVR_SETSPEED_PROC              (0x851EU)    /**< @brief #ETHXCVR_SetSpeed          */
#define BRCM_SWARCH_ETHXCVR_GETDUPLEXMODE_PROC         (0x851FU)    /**< @brief #ETHXCVR_GetDuplexMode     */
#define BRCM_SWARCH_ETHXCVR_SETDUPLEXMODE_PROC         (0x8520U)    /**< @brief #ETHXCVR_SetDuplexMode     */
#define BRCM_SWARCH_ETHXCVR_GETFLOWCONTROL_PROC        (0x8521U)    /**< @brief #ETHXCVR_GetFlowControl    */
#define BRCM_SWARCH_ETHXCVR_SETFLOWCONTROL_PROC        (0x8522U)    /**< @brief #ETHXCVR_SetFlowControl    */
#define BRCM_SWARCH_ETHXCVR_GETSQIVALUE_PROC           (0x8523U)    /**< @brief #ETHXCVR_GetSQIValue       */
#define BRCM_SWARCH_ETHXCVR_SETLOOPBACKMODE_PROC       (0x8524U)    /**< @brief #ETHXCVR_SetLoopbackMode   */
#define BRCM_SWARCH_ETHXCVR_GETLOOPBACKMODE_PROC       (0x8525U)    /**< @brief #ETHXCVR_GetLoopbackMode   */
#define BRCM_SWARCH_ETHXCVR_SETJUMBOMODE_PROC          (0x8526U)    /**< @brief #ETHXCVR_SetJumboMode      */
#define BRCM_SWARCH_ETHXCVR_GETJUMBOMODE_PROC          (0x8527U)    /**< @brief #ETHXCVR_GetJumboMode      */
#define BRCM_SWARCH_ETHXCVR_SETAUTONEGMODE_PROC        (0x8528U)    /**< @brief #ETHXCVR_SetAutoNegMode    */
#define BRCM_SWARCH_ETHXCVR_GETAUTONEGSTATUS_PROC      (0x8529U)    /**< @brief #ETHXCVR_GetAutoNegStatus  */
#define BRCM_SWARCH_ETHXCVR_RESTARTAUTONEG_PROC        (0x852AU)    /**< @brief #ETHXCVR_RestartAutoNeg    */
#define BRCM_SWARCH_ETHXCVR_GETSTATS_PROC              (0x852BU)    /**< @brief #ETHXCVR_GetStats          */
#define BRCM_SWARCH_ETHXCVR_STATEHANDLER_PROC          (0x852CU)    /**< @brief #ETHXCVR_StateHandler      */
#define BRCM_SWARCH_ETHXCVR_UPDATEHWSTATUS_PROC        (0x852DU)    /**< @brief #ETHXCVR_UpdateHWStatus    */
#define BRCM_SWARCH_ETHXCVR_STATE_TYPE                 (0x852EU)    /**< @brief #ETHXCVR_StateType         */
#define BRCM_SWARCH_ETHXCVR_GETPORTCONFIG_PROC         (0x852FU)    /**< @brief #ETHXCVR_GetPortConfig     */
#define BRCM_SWARCH_ETHXCVR_SETWAKEUPMODE_PROC         (0x8530U)    /**< @brief #ETHXCVR_SetWakeUpMode     */
#define BRCM_SWARCH_ETHXCVR_GETWAKEUPMODE_PROC         (0x8531U)    /**< @brief #ETHXCVR_GetWakeUpMode     */
#define BRCM_SWARCH_ETHXCVR_GETWAKEUPREASON_PROC       (0x8532U)    /**< @brief #ETHXCVR_GetWakeUpReason   */
/** @} */

/**
    @brief Number of ports supported

    @trace #BRCM_SWREQ_ETHXCVR_INIT
*/
#define ETHXCVR_MAX_PORTS          (16U)

/**
    @brief Number of driver parameters

    @trace #BRCM_SWREQ_ETHXCVR_KERNEL_INTERFACE
*/
#define ETHXCVR_MAX_DRIVER_PARAMS  (4U)

/**
    @brief Magic number for XCVR configuration

    @trace #BRCM_SWREQ_ETHXCVR_INIT
*/
#define ETHXCVR_CONFIG_MAGIC   (0x52564358UL)

/**
    @brief Ethernet transceiver ID

    @trace #BRCM_SWREQ_ETHXCVR_KERNEL_INTERFACE
*/
typedef uint8_t ETHXCVR_IDType;

/**
    @name ETHXCVR_StateType
    @{
    @brief Ethernet transceiver driver state

    @trace #BRCM_SWREQ_ETHXCVR_KERNEL_INTERFACE
*/
typedef uint8_t ETHXCVR_StateType;  /**< @brief ETHXCVR_State typedef */
#define ETHXCVR_STATE_UNINIT (0U)   /**< @brief Transceiver driver uninitialised & value must be zero*/
#define ETHXCVR_STATE_INIT   (1U)   /**< @brief Transceiver driver initialialised */
/** @} */

/**
    @name ETHXCVR_StatsType
    @{
    @brief Transceiver statistics type

    @trace #BRCM_SWREQ_ETHXCVR_KERNEL_INTERFACE
*/
typedef struct sETHXCVR_StatsType {
    uint32_t linkStateChangeCount;  /**< @brief Link state change count */
} ETHXCVR_StatsType;
/** @} */

/**
    @name ETHXCVR_KeyValuePairType
    @{
    @brief Key value pair structure

    @trace #BRCM_SWREQ_ETHXCVR_KERNEL_INTERFACE
 */
typedef struct sETHXCVR_KeyValuePairType {
    uint16_t    key;    /**< @brief Key */
    uint16_t    value;  /**< @brief Value */
} ETHXCVR_KeyValuePairType;
/** @} */

/**
    @name ETHXCVR_BusConfigType
    @{
    @brief Bus configuration structure

    @trace #BRCM_SWREQ_ETHXCVR_KERNEL_INTERFACE
 */
typedef struct sETHXCVR_BusConfigType {
    uint8_t                  cntrlID;           /**< @brief Controller index */
    uint8_t                  instID;            /**< @brief Instance index */
    uint8_t                  reserved[2U];      /**< @brief Reserved field */
    ETHXCVR_KeyValuePairType driverParams[ETHXCVR_MAX_DRIVER_PARAMS]; /**< @brief Driver parameters */
} ETHXCVR_BusConfigType;
/** @} */

/**
    @name ETHXCVR_PhyConfigType
    @{
    @brief Phy configuration structure

    @trace #BRCM_SWREQ_ETHXCVR_KERNEL_INTERFACE
 */
typedef struct sETHXCVR_PhyConfigType {
    uint8_t                  hwID;              /**< @brief Hardware index of the controller */
    uint8_t                  slaveID;           /**< @brief Slave address for PHY controled via MDIO */
    ETHXCVR_AccessModeType   accessMode;        /**< @brief Access Mode */
    ETHXCVR_PhyMediaType     phyMedia;          /**< @brief Physical media */
    ETHXCVR_BooleanType   masterMode;        /**< @brief Master/Slave Mode */
    uint8_t                  reserved[3U];      /**< @brief Reserved field */
    ETHXCVR_KeyValuePairType driverParams[ETHXCVR_MAX_DRIVER_PARAMS]; /**< @brief Driver parameters */
} ETHXCVR_PhyConfigType;
/** @} */

/**
    @brief Port configuration structure

    @trace #BRCM_SWREQ_ETHXCVR_KERNEL_INTERFACE
 */
typedef struct sETHXCVR_PortConfigType {
    ETHXCVR_IDType          id;          /**< @brief Port index. This is the chip port number */
    ETHXCVR_BooleanType     portEnable;  /**< @brief Flag indicating whether the port is enabled or not */
    ETHXCVR_SpeedType       speed;       /**< @brief Speed */
    ETHXCVR_BooleanType     autoNeg;     /**< @brief Autoneg enable/disable */
    ETHXCVR_DuplexModeType  duplex;      /**< @brief Duplex */
    ETHXCVR_FlowControlType flowControl; /**< @brief Flow Control */
    ETHXCVR_BooleanType     jumbo;       /**< @brief Jumbo enable/disable */
    ETHXCVR_BusModeType     busMode;     /**< @brief Bus mode */
    ETHXCVR_BusConfigType   bus;         /**< @brief Bus device */
    ETHXCVR_PhyConfigType   phy;         /**< @brief PHY device */
} ETHXCVR_PortConfigType;

/**
    @brief XCVR configuration structure

    @trace #BRCM_SWREQ_ETHXCVR_INIT
 */
typedef struct sETHXCVR_ConfigType {
    uint32_t magic;               /**< @brief Magic number */
    uint32_t version;             /**< @brief BCM transceiver configuration structuire version */
    uint32_t numPorts;            /**< @brief Number of valid ports in the configuration. Should not be more
                                              than #ETHXCVR_MAX_PORTS */
    ETHXCVR_PortConfigType port[ETHXCVR_MAX_PORTS]; /**< @brief Port configuration */
    uint8_t name[16UL];           /**< @brief Configuration name */
    uint8_t file[128UL];          /**< @brief File name from which this configuration is generated */
} ETHXCVR_ConfigType;

/** @brief Initialize transceiver

    This API initializes the transceiver with the given configuration.

    @behavior Sync, Re-entrant across transceivers

    @pre None

    @param[in]      aID         Index of the Transceiver
    @param[in]      aConfig     Pointer to transceiver configuration

    @return     void

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHXCVR_INIT
*/
extern void ETHXCVR_Init(ETHXCVR_IDType aID,
                         const ETHXCVR_PortConfigType *const aConfig);

/** @brief De-initialize transceiver

    This API de-initializes the transceiver driver.

    @behavior Sync, Re-entrant across transceivers

    @pre None

    @param[in]      aID         Index of the Transceiver

    @return     void

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHXCVR_INIT
*/
extern void ETHXCVR_DeInit(ETHXCVR_IDType aID);

/** @brief Set transceiver mode

    This API sets mode of the transceiver. If aMode is #ETHXCVR_MODE_DOWN, transceiver is disabled by driver
    (both RX/TX disabled). If aMode is #ETHXCVR_MODE_ACTIVE, transceiver is enabled by the driver (both RX/TX active)
    When #ETHXCVR_MODE_ACTIVE is used, it will decide whether to perform full power up (MII Ctrl Power bit) or perform
    local and remote wake up depending on whether the wakeup feature is disabled or not


    @behavior ASync, Non Re-entrant

    @pre None

    @param[in]      aID         Index of the transceiver
    @param[in]      aMode       Mode to be set

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Transceiver mode set successfully
    @retval     #BCM_ERR_INVAL_PARAMS   Invalid transceiver ID
    @retval     #BCM_ERR_INVAL_PARAMS   Invalid transceiver mode
    @retval     #BCM_ERR_UNINIT         Transceiver driver is not initialized
    @retval     #BCM_ERR_EAGAIN         Transceiver mode can not be set at this
                                        moment. Try again.
    @retval     #BCM_ERR_NOSUPPORT      No Support for the Transceiver mode

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHXCVR_RUNTIME_CONFIG
*/
extern int32_t ETHXCVR_SetMode(ETHXCVR_IDType aID,
                               ETHXCVR_ModeType aMode);

/** @brief Get transceiver mode

    This API retrieves the current mode of the Ethernet transceiver.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aID         Index of the transceiver
    @param[out]     aMode       Pointer to Mode

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Transceiver mode retrieved successfully
    @retval     #BCM_ERR_INVAL_PARAMS   Invalid transceiver ID
    @retval     #BCM_ERR_INVAL_PARAMS   aMode is NULL
    @retval     #BCM_ERR_UNINIT         Transceiver driver is not initialized

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHXCVR_STATUS
*/
extern int32_t ETHXCVR_GetMode(ETHXCVR_IDType aID,
                               ETHXCVR_ModeType *const aMode);

/** @brief Set transceiver master/slave mode

    This API sets master/slave mode of the transceiver. If aMode is
    #ETHXCVR_MASTER_MODE_EN, transceiver is configured in master
    mode. If aMode is #ETHXCVR_MASTER_MODE_DIS, transceiver is
    configured by driver in slave mode.

    @note Transceiver master/slave mode might not be applicable to all
    type of transceiver. If the mode is not applicable, this
    API shall return #BCM_ERR_NOSUPPORT


    @behavior Sync, Re-entrant across transceivers

    @pre None

    @param[in]      aID         Index of the transceiver
    @param[in]      aMasterMode Master/slave mode to be set

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Master/slave mode set successfully
    @retval     #BCM_ERR_INVAL_PARAMS   Invalid transceiver ID
    @retval     #BCM_ERR_INVAL_PARAMS   Invalid mode
    @retval     #BCM_ERR_UNINIT         Transceiver driver is not initialized
    @retval     #BCM_ERR_NOSUPPORT      Setting master/slave mode is not supported
    @retval     #BCM_ERR_EAGAIN         Master mode can not be set at this
                                        moment. Try again.

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHXCVR_RUNTIME_CONFIG
*/
extern int32_t ETHXCVR_SetMasterMode(ETHXCVR_IDType aID,
                                     ETHXCVR_BooleanType aMasterMode);

/** @brief Get transceiver master/slave mode

    This API retrieves the current master/slave mode of the Ethernet transceiver.

    @note Transceiver master/slave mode might not be applicable to all
    types of transceivers. If the mode is not applicable, this
    API shall return #BCM_ERR_NOSUPPORT

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aID         Index of the transceiver
    @param[out]     aMasterMode Pointer to retrieve master/slave mode

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Master/slave mode retrieved successfully
    @retval     #BCM_ERR_INVAL_PARAMS   Invalid transceiver ID
    @retval     #BCM_ERR_INVAL_PARAMS   aMode is NULL
    @retval     #BCM_ERR_UNINIT         Transceiver driver is not initialized
    @retval     #BCM_ERR_NOSUPPORT      Master/slave mode is not supported

    @post None

    @limitations Set operation could result in hit in traffic on the device

    @trace #BRCM_SWREQ_ETHXCVR_STATUS
*/
extern int32_t ETHXCVR_GetMasterMode(ETHXCVR_IDType aID,
                                     ETHXCVR_BooleanType *const aMasterMode);

/** @brief Get transceiver link state

    This API retrieves the state of the Ethernet transceiver link.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aID         Index of the transceiver
    @param[out]     aLinkState  Pointer to link state

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully retrieved transceiver link state
    @retval     #BCM_ERR_INVAL_PARAMS   Invalid transceiver ID
    @retval     #BCM_ERR_INVAL_PARAMS   aLinkState is NULL
    @retval     #BCM_ERR_UNINIT         Transceiver driver is not initialized

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHXCVR_STATUS
*/
extern int32_t ETHXCVR_GetLinkState(ETHXCVR_IDType aID,
                                    ETHXCVR_LinkStateType *const aLinkState);

/** @brief Get transceiver speed

    This API retrieves the current speed of the Ethernet transceiver

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aID         Index of the transceiver
    @param[out]     aSpeed      Speed of the transceiver

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully retrieved transceiver speed
    @retval     #BCM_ERR_INVAL_PARAMS   Invalid transceiver ID
    @retval     #BCM_ERR_INVAL_PARAMS   aSpeed is NULL
    @retval     #BCM_ERR_UNINIT         Transceiver driver is not initialized

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHXCVR_STATUS
*/
extern int32_t ETHXCVR_GetSpeed(ETHXCVR_IDType aID,
                                ETHXCVR_SpeedType *const aSpeed);

/** @brief Set transceiver speed

    This API set speed of the Ethernet transceiver

    @behavior Sync, Re-entrant across transceivers

    @pre None

    @param[in]      aID         Index of the transceiver
    @param[in]      aSpeed      Speed of the transceiver

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully set transceiver speed
    @retval     #BCM_ERR_INVAL_PARAMS   Invalid transceiver ID
    @retval     #BCM_ERR_INVAL_PARAMS   aSpeed is invalid
    @retval     #BCM_ERR_UNINIT         Transceiver driver is not initialized
    @retval     #BCM_ERR_NOSUPPORT      Setting speed is not supported
    @retval     #BCM_ERR_EAGAIN         Speed can not be changed at this
                                        moment. Try again.

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHXCVR_RUNTIME_CONFIG
*/
extern int32_t ETHXCVR_SetSpeed(ETHXCVR_IDType aID,
                                ETHXCVR_SpeedType aSpeed);

/** @brief Get duplex mode

    This API retrieves the current duplex mode of the Ethernet transceiver.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aID         Index of the transceiver
    @param[out]     aDuplexMode Duplex Mode of the transceiver

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully retrieved current duplex mode of the transceiver
    @retval     #BCM_ERR_INVAL_PARAMS   Invalid transceiver ID
    @retval     #BCM_ERR_INVAL_PARAMS   aDuplexMode is NULL
    @retval     #BCM_ERR_UNINIT         Transceiver driver is not initialized

    @post None

    @limitations Set operation could result in hit in traffic on the device

    @trace #BRCM_SWREQ_ETHXCVR_STATUS
*/
extern int32_t ETHXCVR_GetDuplexMode(ETHXCVR_IDType aID,
                                     ETHXCVR_DuplexModeType *const aDuplexMode);

/** @brief Set transceiver duplex mode

    This API set duplex mode of the Ethernet transceiver

    @behavior Sync, Re-entrant across transceivers

    @pre None

    @param[in]      aID         Index of the transceiver
    @param[in]      aDuplexMode Duplex mode of the transceiver

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully set transceiver duplex mode
    @retval     #BCM_ERR_INVAL_PARAMS   Invalid transceiver ID
    @retval     #BCM_ERR_INVAL_PARAMS   aDuplexMode is invalid
    @retval     #BCM_ERR_UNINIT         Transceiver driver is not initialized
    @retval     #BCM_ERR_NOSUPPORT      Setting duplex mode is not supported
    @retval     #BCM_ERR_EAGAIN         Duplex mode can not be set at this
                                        moment. Try again.

    @post None

    @limitations Set operation could result in hit in traffic on the device

    @trace #BRCM_SWREQ_ETHXCVR_RUNTIME_CONFIG
*/
extern int32_t ETHXCVR_SetDuplexMode(ETHXCVR_IDType aID,
                                     ETHXCVR_DuplexModeType aDuplexMode);

/** @brief Get flow control

    This API retrieves the current flow control of the Ethernet transceiver.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aID          Index of the transceiver
    @param[out]     aFlowControl Flow control of the transceiver

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully retrieved current flow control of the transceiver
    @retval     #BCM_ERR_INVAL_PARAMS   Invalid transceiver ID
    @retval     #BCM_ERR_INVAL_PARAMS   aFlowControl is NULL
    @retval     #BCM_ERR_UNINIT         Transceiver driver is not initialized

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHXCVR_STATUS
*/
extern int32_t ETHXCVR_GetFlowControl(ETHXCVR_IDType aID,
                                     ETHXCVR_FlowControlType *const aFlowControl);

/** @brief Set transceiver flow control

    This API sets flow control of the Ethernet transceiver

    @behavior Sync, Re-entrant across transceivers

    @pre None

    @param[in]      aID          Index of the transceiver
    @param[in]      aFlowControl Flow control of the transceiver

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully set transceiver flow control
    @retval     #BCM_ERR_INVAL_PARAMS   Invalid transceiver ID
    @retval     #BCM_ERR_INVAL_PARAMS   aFlowControl  is invalid
    @retval     #BCM_ERR_UNINIT         Transceiver driver is not initialized
    @retval     #BCM_ERR_NOSUPPORT      Setting flow control is not supported
    @retval     #BCM_ERR_EAGAIN         Flow control mode can not be set at this
                                        moment. Try again.

    @post None

    @limitations Set operation could result in hit in traffic on the device

    @trace #BRCM_SWREQ_ETHXCVR_RUNTIME_CONFIG
*/
extern int32_t ETHXCVR_SetFlowControl(ETHXCVR_IDType aID,
                                      ETHXCVR_FlowControlType aFlowControl);

/** @brief Get SQI mode

    This API retrieves the SQI value of the established link

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aID         Index of the transceiver
    @param[out]     aSQIValue   SQI value of the link

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully returned the SQI value of the link.
    @retval     #BCM_ERR_INVAL_PARAMS   Invalid transceiver ID
    @retval     #BCM_ERR_INVAL_PARAMS   aSQIValue is NULL
    @retval     #BCM_ERR_UNINIT         Transceiver driver is not initialized

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHXCVR_STATUS
*/
extern int32_t ETHXCVR_GetSQIValue(ETHXCVR_IDType aID,
                                   uint32_t *const aSQIValue);

/** @brief Set transceiver loopback mode

    This API sets loopback mode of the transceiver.

    @behavior Sync, Re-entrant across transceivers

    @pre None

    @param[in]      aID         Index of the transceiver
    @param[in]      aMode       Loopback mode to be configured.

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Loopback mode set successfully
    @retval     #BCM_ERR_INVAL_PARAMS   Invalid transceiver ID
    @retval     #BCM_ERR_INVAL_PARAMS   Invalid loopback mode
    @retval     #BCM_ERR_UNINIT         Transceiver driver is not initialized
    @retval     #BCM_ERR_NOSUPPORT      Setting loopback mode is not supported
    @retval     #BCM_ERR_EAGAIN         Loopback mode can not be set at this
                                        moment. Try again.

    @post None

    @limitations Set operation could result in hit in traffic on the device

    @trace #BRCM_SWREQ_ETHXCVR_RUNTIME_CONFIG
*/
extern int32_t ETHXCVR_SetLoopbackMode(ETHXCVR_IDType aID,
                                       ETHXCVR_BooleanType aMode);

/** @brief Get transceiver loopback mode

    This API retrieves the current loopback mode of the Ethernet transceiver.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aID         Index of the transceiver
    @param[out]     aMode       Pointer to retrieve loopback mode

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Loopback mode retrieved successfully
    @retval     #BCM_ERR_INVAL_PARAMS   Invalid transceiver ID
    @retval     #BCM_ERR_INVAL_PARAMS   aMode is NULL
    @retval     #BCM_ERR_UNINIT         Transceiver driver is not initialized
    @retval     #BCM_ERR_NOSUPPORT      Loopback mode is not supported

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHXCVR_STATUS
*/
extern int32_t ETHXCVR_GetLoopbackMode(ETHXCVR_IDType aID,
                                       ETHXCVR_BooleanType *const aMode);

/** @brief Set transceiver jumbo mode

    This API sets jumbo mode of the transceiver.

    @behavior Sync, Re-entrant across transceivers

    @pre None

    @param[in]      aID         Index of the transceiver
    @param[in]      aMode       Jumbo mode to be configured.

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Jumbo mode set successfully
    @retval     #BCM_ERR_INVAL_PARAMS   Invalid transceiver ID
    @retval     #BCM_ERR_INVAL_PARAMS   Invalid jumbo mode
    @retval     #BCM_ERR_UNINIT         Transceiver driver is not initialized
    @retval     #BCM_ERR_NOSUPPORT      Setting jumbo mode is not supported
    @retval     #BCM_ERR_EAGAIN         Jumbo mode can not be set at this
                                        moment. Try again.

    @post None

    @limitations Set operation could result in hit in traffic on the device

    @trace #BRCM_SWREQ_ETHXCVR_RUNTIME_CONFIG
*/
extern int32_t ETHXCVR_SetJumboMode(ETHXCVR_IDType aID,
                                    ETHXCVR_BooleanType aMode);

/** @brief Get transceiver jumbo mode

    This API retrieves the current jumbo packet mode enabled/disabled for
    the Ethernet transceiver.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aID         Index of the transceiver
    @param[out]     aJumboMode  Pointer to retrieve jumbo mode

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Jumbo mode retrieved successfully
    @retval     #BCM_ERR_INVAL_PARAMS   Invalid transceiver ID
    @retval     #BCM_ERR_INVAL_PARAMS   aJumboMode is NULL
    @retval     #BCM_ERR_UNINIT         Transceiver driver is not initialized
    @retval     #BCM_ERR_NOSUPPORT      Jumbo packet mode is not supported

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHXCVR_STATUS
*/
extern int32_t ETHXCVR_GetJumboMode(ETHXCVR_IDType aID,
                                    ETHXCVR_BooleanType *const aJumboMode);

/** @brief Enable/Disable wake-up mode

    This API Enables / disables the wake-up mode

    @behavior Sync, Re-entrant across transceivers

    @pre None

    @param[in]      aID       Index of the transceiver
    @param[in]      aMode     WakeUp Mode Settings

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully set WakeupMode
    @retval     #BCM_ERR_INVAL_PARAMS   Invalid transceiver ID
    @retval     #BCM_ERR_EAGAIN         Wakeup Mode mode can not be set at this
                                        moment. Try again.
    @retval     #BCM_ERR_UNINIT         Transceiver driver is not initialized
    @retval     #BCM_ERR_NOSUPPORT      There is no WakeUp Mode Support
    @retval     #BCM_ERR_NOPERM         Wake up mode is hardwired and cannot be modified

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHXCVR_RUNTIME_CONFIG
*/
extern int32_t ETHXCVR_SetWakeUpMode(ETHXCVR_IDType aID,
                                     ETHXCVR_BooleanType aMode);

/** @brief Get wake-up mode

    This API Queries the wake-up mode Setting Enabled /Disabled

    @behavior Sync, Re-entrant across transceivers

    @pre None

    @param[in]      aID         Index of the transceiver
    @param[out]     aMOde       Pointer to read WakeUp Mode Setting

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully Get WakeUp Mode
    @retval     #BCM_ERR_INVAL_PARAMS   Invalid transceiver ID
    @retval     #BCM_ERR_UNINIT         Transceiver driver is not initialized
    @retval     #BCM_ERR_NOSUPPORT      No WakeUp Mode Support

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHXCVR_STATUS
*/
extern int32_t ETHXCVR_GetWakeUpMode(ETHXCVR_IDType aID,
                                     ETHXCVR_BooleanType *const aMode);

/** @brief Get wakeup Reason

    This API reads and provide the wakeup Reason

    @behavior Sync, Re-entrant across transceivers

    @pre None

    @param[in]      aID         Index of the transceiver
    @param[out]     aReason     Pointer to read WakeUp Reason

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully Get WakeUp Reason
    @retval     #BCM_ERR_INVAL_PARAMS   Invalid transceiver ID
    @retval     #BCM_ERR_UNINIT         Transceiver driver is not initialized
    @retval     #BCM_ERR_NOSUPPORT      If there is No WakeUp Mode Support
    @retval     #BCM_ERR_INVAL_STATE    Wakeup Mode Disabled
    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHXCVR_STATUS
*/
extern int32_t ETHXCVR_GetWakeUpReason (ETHXCVR_IDType aID,
                                         ETHXCVR_WakeupReasonType *const aReason);

/** @brief Set auto-negotiation mode

    This API sets the auto-negotiation mode for the transceiver. In case
    aMode is #ETHXCVR_AUTONEGMODE_EN then it also performs auto-negotiation.

    @behavior Sync, Re-entrant across transceivers

    @pre None

    @param[in]      aID         Index of the transceiver
    @param[in]      aMode       Auto-negotiation enable/disable mode

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Auto-negotiation mode set successfully
    @retval     #BCM_ERR_INVAL_PARAMS   Invalid transceiver ID
    @retval     #BCM_ERR_INVAL_PARAMS   Invalid auto-negotiation mode
    @retval     #BCM_ERR_UNINIT         Transceiver driver is not initialized
    @retval     #BCM_ERR_NOSUPPORT      Setting auto-negotiation mode is not supported
    @retval     #BCM_ERR_EAGAIN         Auto-negotiation mode can not be set
                                        at this moment. Try again.

    @post None

    @limitations Set operation could result in hit in traffic on the device

    @trace #BRCM_SWREQ_ETHXCVR_RUNTIME_CONFIG
*/
extern int32_t ETHXCVR_SetAutoNegMode(ETHXCVR_IDType aID,
                                      ETHXCVR_BooleanType aMode);

/** @brief Get transceiver auto-negotiation status

    This API retrieves auto-negotiation status of the Ethernet transceiver.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aID             Index of the transceiver
    @param[out]     aStatus         Pointer to retrieve status of auto-negotiation

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Transceiver auto-negotiation status
                                        retrieved successfully
    @retval     #BCM_ERR_INVAL_PARAMS   Invalid transceiver ID
    @retval     #BCM_ERR_INVAL_PARAMS   aStatus is NULL
    @retval     #BCM_ERR_UNINIT         Transceiver driver is not initialized
    @retval     #BCM_ERR_NOSUPPORT      Auto-negotiation status is not supported

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHXCVR_STATUS
*/
extern int32_t ETHXCVR_GetAutoNegStatus(ETHXCVR_IDType aID,
                                        ETHXCVR_AutoNegStatusType *const aStatus);

/** @brief Restart auto-negotiation

    This API restarts auto-negotiation for the transceiver

    @behavior Sync, Re-entrant across transceivers

    @pre None

    @param[in]      aID         Index of the transceiver

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Auto-negotiation restarted successfully
    @retval     #BCM_ERR_INVAL_PARAMS   Invalid transceiver ID
    @retval     #BCM_ERR_INVAL_STATE    Auto-negotiation is not enabled
    @retval     #BCM_ERR_UNINIT         Transceiver driver is not initialized
    @retval     #BCM_ERR_NOSUPPORT      Restarting auto-negotiation is not supported

    @post None

    @limitations Set operation could result in hit in traffic on the device

    @trace #BRCM_SWREQ_ETHXCVR_RUNTIME_CONFIG
*/
extern int32_t ETHXCVR_RestartAutoNeg(ETHXCVR_IDType aID);

/** @brief Get transceiver statistics

    This API retrieves the statistics of Ethernet transceiver.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aID         Index of the transceiver
    @param[out]     aStats      Pointer to retrieve statistics

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Transceiver statistics retrieved successfully
    @retval     #BCM_ERR_INVAL_PARAMS   Invalid transceiver ID
    @retval     #BCM_ERR_INVAL_PARAMS   aStats is NULL
    @retval     #BCM_ERR_UNINIT         Transceiver driver is not initialized

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHXCVR_STATUS
*/
extern int32_t ETHXCVR_GetStats(ETHXCVR_IDType aID,
                                ETHXCVR_StatsType *const aStats);

/** @brief Transceiver state handler

    This API triggers the transceiver state machine

    @behavior Sync, Non re-entrant

    @pre None

    @param[in]      aID         Index of the transceiver

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Transceiver state machine triggered
                                        successfully and is in IDLE state
    @retval     #BCM_ERR_INVAL_PARAMS   Invalid transceiver ID
    @retval     #BCM_ERR_UNINIT         Transceiver driver is not initialized
    @retval     #BCM_ERR_EAGAIN         Transceiver driver state handler is
                                        busy processing previous state. Call
                                        state handler again.
    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHXCVR_RUNTIME_CONFIG
*/
extern int32_t ETHXCVR_StateHandler(ETHXCVR_IDType aID);

/** @brief Update HW status parameters

    This API triggers the driver to read and cache the HW status parameters

    @behavior Async, Non re-entrant

    @pre None

    @param[in]      aID         Index of the transceiver

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Transceiver driver triggered successfully
    @retval     #BCM_ERR_INVAL_PARAMS   Invalid transceiver ID
    @retval     #BCM_ERR_UNINIT         Transceiver driver is not initialized
    @retval     #BCM_ERR_EAGAIN         Transceiver driver can't be triggered at
                                        this moment. Try again.

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHXCVR_STATUS
*/
extern int32_t ETHXCVR_UpdateHWStatus(ETHXCVR_IDType aID);

/** @brief Get port config

    This API getches the port config

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aID         Index of the transceiver
    @param[out]     aConfig     Pointer to copy the port config

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Config retrived successfully
    @retval     #BCM_ERR_INVAL_PARAMS   Invalid transceiver ID
    @retval     #BCM_ERR_INVAL_PARAMS   aConfig is NULL
    @retval     #BCM_ERR_UNINIT         Transceiver driver is not initialized

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHXCVR_STATUS
*/
extern int32_t ETHXCVR_GetPortConfig(ETHXCVR_IDType aID, ETHXCVR_PortConfigType *const aConfig);

#endif /* ETH_XCVR_H */

/** @} */
