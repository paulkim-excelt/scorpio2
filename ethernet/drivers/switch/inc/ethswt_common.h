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
    @defgroup grp_ethswt_common_ifc Common Interface
    @ingroup grp_ethswt

    @addtogroup grp_ethswt_common_ifc
    @{

    @file ethswt_common.h
    @brief Application programmer interface for Ethernet Switch Driver (Common)

    @version 0.51 Imported from docx
 */

#ifndef ETHSWT_COMMON_H
#define ETHSWT_COMMON_H

#include <compiler.h>
#include <ethernet.h>
#include <ethernet_swt_common.h>

/**
    @name Ethernet Switch driver API IDs
    @{
    @brief API IDs for  Ethernet Switch driver
*/
#define BRCM_SWARCH_ETHSWT_VLANID_TYPE                 (0x8C03U)    /**< @brief #ETHSWT_VLANIDType         */
#define BRCM_SWARCH_ETHSWT_PORT_TYPE                   (0x8C04U)    /**< @brief #ETHSWT_PortType           */
#define BRCM_SWARCH_ETHSWT_SWITCH_TYPE                 (0x8C07U)    /**< @brief #ETHSWT_SwitchType         */
#define BRCM_SWARCH_ETHSWT_MGMT_INFO_TYPE              (0x8C08U)    /**< @brief #ETHSWT_MgmtInfoType       */
#define BRCM_SWARCH_ETHSWT_SET_MGMT_INFO_PROC          (0x8C0BU)    /**< @brief #ETHSWT_SetMgmtInfo        */
#define BRCM_SWARCH_ETHSWT_GET_DUMBFWDMODE_PROC        (0x8C0DU)    /**< @brief #ETHSWT_GetDumbFwdMode     */
#define BRCM_SWARCH_ETHSWT_SET_DUMBFWDMODE_PROC        (0x8C0EU)    /**< @brief #ETHSWT_SetDumbFwdMode     */
#define BRCM_SWARCH_ETHSWT_SET_PORT_ROLE_PROC          (0x8C0FU)    /**< @brief #ETHSWT_SetPortRole        */
#define BRCM_SWARCH_ETHSWT_SET_SWITCH_TYPE_PROC        (0x8C10U)    /**< @brief #ETHSWT_SetSwitchType      */
#define BRCM_SWARCH_ETHSWT_READ_REG_PROC               (0x8C11U)    /**< @brief #ETHSWT_ReadReg            */
#define BRCM_SWARCH_ETHSWT_WRITE_REG_PROC              (0x8C12U)    /**< @brief #ETHSWT_WriteReg           */
#define BRCM_SWARCH_ETHSWT_INIT_PROC                   (0x8C13U)    /**< @brief #ETHSWT_Init               */
#define BRCM_SWARCH_ETHSWT_ENABLE_TX_TIMESTAMP_PROC    (0x8C14U)    /**< @brief #ETHSWT_EnableTxTimestamp  */
#define BRCM_SWARCH_ETHSWT_INGRESSBH_TYPE              (0x8C15U)    /**< @brief #ETHSWT_IngressBHType      */
#define BRCM_SWARCH_ETHSWT_GET_MGMTMODE_PROC           (0x8C18U)    /**< @brief #ETHSWT_GetMgmtMode        */
#define BRCM_SWARCH_ETHSWT_SET_MGMTMODE_PROC           (0x8C1AU)    /**< @brief #ETHSWT_SetMgmtMode        */
#define BRCM_SWARCH_ETHSWT_GET_BRCMHDRMODE_PROC        (0x8C1CU)    /**< @brief #ETHSWT_GetBrcmHdrMode     */
#define BRCM_SWARCH_ETHSWT_SET_BRCMHDRMODE_PROC        (0x8C1DU)    /**< @brief #ETHSWT_SetBrcmHdrMode     */
#define BRCM_SWARCH_ETHSWT_ENABLEBHSHIFT_PROC          (0x8C1EU)    /**< @brief #ETHSWT_EnableBHShift      */
#define BRCM_SWARCH_ETHSWT_ENABLERX_PROC               (0x8C1FU)    /**< @brief #ETHSWT_EnableRx           */
#define BRCM_SWARCH_ETHSWT_DISABLERX_PROC              (0x8C20U)    /**< @brief #ETHSWT_DisableRx          */
/** @} */

/**
    @brief Maximum number of ports supported by Ethernet switch driver.

    @trace #BRCM_SWREQ_ETHSWT_KERNEL_INTERFACE
*/

/**
    @name VLAN ID type
    @{
    @brief 802.1Q VLAN ID type

    VLAN range 0x0 to 4095 where 0x000 and 0xFFF are reserved.

    @trace #BRCM_SWREQ_ETHSWT_KERNEL_INTERFACE
*/
typedef uint16_t ETHSWT_VLANIDType;       /**< @brief 802.1Q VLAN ID type */
#define ETHSWT_VLANID_MIN     (1UL)       /**< @brief Minimum VLAN ID */
#define ETHSWT_VLANID_MAX     (4094UL)    /**< @brief Maximum VLAN ID */
#define ETHSWT_VLANID_MASK    (0xFFFU)
/** @} */

/**
    @name Port type
    @{
    @brief Type of the switch port

    @trace #BRCM_SWREQ_ETHSWT_KERNEL_INTERFACE
*/
typedef uint8_t ETHSWT_PortType;      /**< @brief Switch port type */
#define ETHSWT_PORT_STANDARD  (0U)   /**< @brief A standard Port is a
                                             normal switch port connected to
                                             a transceiver. */
#define ETHSWT_PORT_HOST      (1U)   /**< @brief Port is connected to Host
                                             ECU controlling the switch */
#define ETHSWT_PORT_UP_LINK   (2U)   /**< @brief Port is coupling port which
                                             is connected to another coupling
                                             element in the same ECU (to model a
                                             cascade switch). An uplink port
                                             have special behaviour w.r.t
                                             software and hardware. */
/** @} */

/**
    @name ETHSWT_IngressBHType
    @{
    @brief Ingress Broadcom Header/Tag Type

    @note: This should be as per Broadcom Ingress header/tag

    @trace #BRCM_SWREQ_ETHSWT_KERNEL_INTERFACE
 */
typedef uint32_t ETHSWT_IngressBHType;                     /**< @brief Broadcom Header/Tag type */
#define ETHSWT_INGRESSBH_OPCODE_MASK       (0xE0000000UL)  /**< @brief 3bits of #ETHSWT_OpcodeType */
#define ETHSWT_INGRESSBH_OPCODE_SHIFT      (29UL)          /**< @brief [31:29]*/
#define ETHSWT_INGRESSBH_OPCODE_0          (0UL)           /**< @brief Opcode 0 */
#define ETHSWT_INGRESSBH_OPCODE_1          (1UL)           /**< @brief Opcode 1 */
#define ETHSWT_INGRESSBH_OPCODE_2          (2UL)           /**< @brief Opcode 2 */
#define ETHSWT_INGRESSBH_TC_MASK           (0x1C000000UL)  /**< @brief 3bits of #ETHSWT_TCType */
#define ETHSWT_INGRESSBH_TC_SHIFT          (26UL)          /**< @brief [28:26] */
#define ETHSWT_INGRESSBH_TE_MASK           (0x03000000UL)  /**< @brief 2bits of #ETHSWT_TEType */
#define ETHSWT_INGRESSBH_TE_SHIFT          (24UL)          /**< @brief [25:24] */
#define ETHSWT_INGRESSBH_RSVD_MASK         (0x00FFFC00UL)  /**< @brief Reserved */
#define ETHSWT_INGRESSBH_RSVD_SHIFT        (10UL)          /**< @brief [23:10] */
#define ETHSWT_INGRESSBH_PORTMASK_MASK     (0x000003FFUL)  /**< @brief Port mask */
#define ETHSWT_INGRESSBH_PORTMASK_SHIFT    (0UL)           /**< @brief [9:0] */
/** @} */

/**
    @name Type of the swtich
    @{
    @brief Type of the swtich

    @trace #BRCM_SWREQ_ETHSWT_KERNEL_INTERFACE
*/
typedef uint32_t ETHSWT_SwitchType;                 /**< @brief Type of the
                                                         switch */
#define ETHSWT_SWITCH_STANDARD            (0UL)     /**< @brief Standard
                                                         switch is an Ethernet
                                                         switch which operates
                                                         as standalone switch
                                                        */
#define ETHSWT_SWITCH_LIGHTSTACK_MASTER   (1UL)     /**< @brief Light stack
                                                         master switch is an
                                                         Ethernet switch which
                                                         operates as master
                                                         switch in Light stack
                                                         configuration. Refer to
                                                         @ref sec_ref_trm for
                                                         Light stack switch
                                                         operation
                                                        */
#define ETHSWT_SWITCH_LIGHTSTACK_SLAVE    (2UL)     /**< @brief Light stack
                                                         slave switch is an
                                                         Ethernet switch which
                                                         operates as slave
                                                         switch in Light stack
                                                         configuration. Refer to
                                                         @ref sec_ref_trm for
                                                         Light stack switch
                                                         operation
                                                        */
/** @} */

/**
    @brief Switch management information

    @trace #BRCM_SWREQ_ETHSWT_KERNEL_INTERFACE
*/
typedef struct sETHSWT_MgmtInfoType {
    ETHSWT_HwIDType   switchIdx;    /**< @brief Switch index */
    ETHSWT_PortIDType portIdx;      /**< @brief Port index */
    ETHSWT_TCType     tc;           /**< @brief Traffic class */
} ETHSWT_MgmtInfoType;

/** @brief Retrieve dumb forward mode for switch

    This API retrieves dumb forward mode of switch.

    @behavior Sync, Re-entrant

    @pre TBD

    @param[in]      aSwtID      Switch index
    @param[out]     aMode       Pointer to retrieve switch dumb forward mode

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully retrieved port dumb forward mode
    @retval     #BCM_ERR_INVAL_PARAMS   (aMode is NULL) or
                                        (Invalid switch index)
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post TBD

    @trace  #BRCM_SWREQ_ETHSWT_QUERY

    @limitations None
*/
int32_t ETHSWT_GetDumbFwdMode(ETHSWT_HwIDType aSwtID,
        ETHSWT_DumbFwdModeType *const aMode);

/** @brief Set switch dumb forward mode

    This API set dumb forward mode for switch.

    @behavior Sync, Re-entrant

    @pre TBD

    @param[in]      aSwtID      Switch index
    @param[in]      aMode       Port dumb forward mode

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully retrieved port dumb forward mode
    @retval     #BCM_ERR_INVAL_PARAMS   (aMode is NULL) or
                                        (Invalid switch index)
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post TBD

    @trace  #BRCM_SWREQ_ETHSWT_DYNAMIC_CONFIGURATION

    @limitations None
*/
int32_t ETHSWT_SetDumbFwdMode(ETHSWT_HwIDType aSwtID,
        ETHSWT_DumbFwdModeType aMode);

/** @brief Retrieve Broadcom header mode for IMP

    This API retrieves Broadcom header mode of IMP

    @behavior Sync, Re-entrant

    @pre TBD

    @param[in]      aSwtID      Switch index
    @param[out]     aMode       Pointer to retrieve IMP Broadcom header mode

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully retrieved IMP Broadcom header mode
    @retval     #BCM_ERR_INVAL_PARAMS   (aMode is NULL) or
                                        (Invalid switch index)
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post TBD

    @trace  #BRCM_SWREQ_ETHSWT_QUERY

    @limitations None
*/
int32_t ETHSWT_GetBrcmHdrMode(ETHSWT_HwIDType aSwtID,
        ETHSWT_BrcmHdrModeType *const aMode);

/** @brief Set IMP Broadcom header mode

    This API set Broadcom header mode for IMP

    @behavior Sync, Re-entrant

    @pre TBD

    @param[in]      aSwtID      Switch index
    @param[in]      aMode       IMP Broadcom header mode

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully retrieved Broadcom header mode
    @retval     #BCM_ERR_INVAL_PARAMS   aMode is not within allowed range or
                                        (Invalid switch index)
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post TBD

    @trace  #BRCM_SWREQ_ETHSWT_DYNAMIC_CONFIGURATION

    @limitations None
*/
int32_t ETHSWT_SetBrcmHdrMode(ETHSWT_HwIDType aSwtID,
        ETHSWT_BrcmHdrModeType aMode);

/** @brief Retrieve management mode for switch

    This API retrieves management mode of switch.

    @behavior Sync, Re-entrant

    @pre TBD

    @param[in]      aSwtID      Switch index
    @param[out]     aMode       Pointer to retrieve switch management mode

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully retrieved management mode
    @retval     #BCM_ERR_INVAL_PARAMS   (aMode is NULL) or
                                        (Invalid switch index)
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post TBD

    @trace  #BRCM_SWREQ_ETHSWT_QUERY

    @limitations None
*/
int32_t ETHSWT_GetMgmtMode(ETHSWT_HwIDType aSwtID, ETHSWT_MgmtModeType *const aMode);

/** @brief Set switch management mode

    This API set management mode for switch.

    @behavior Sync, Re-entrant

    @pre TBD

    @param[in]      aSwtID      Switch index
    @param[in]      aMode       Management mode

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully retrieved management mode
    @retval     #BCM_ERR_INVAL_PARAMS   aMode is not within allowed range or
                                        (Invalid switch index)
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post TBD

    @trace  #BRCM_SWREQ_ETHSWT_DYNAMIC_CONFIGURATION

    @limitations None
*/
int32_t ETHSWT_SetMgmtMode(ETHSWT_HwIDType aSwtID, ETHSWT_MgmtModeType aMode);

/** @brief Set management information

    This API inserts the management information into the indexed Ethernet buffer
    which was previously adapted for the transmission by calling
    #ETHSWT_TxAdaptBuffer() to achieve the transmission on specific ports of
    the switch.

    @behavior Sync, Re-entrant

    @pre TBD

    @param[in]      aCntrlID    Index of Ethernet controller
    @param[in]      aBufIdx     Ethernet buffer index
    @param[in]      aMgmtInfo   Pointer to management information to be set

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK                 Successfully set Management
                                            information
    @retval     #BCM_ERR_INVAL_BUF_STATE    Invalid packet buffer state
    @retval     #BCM_ERR_INVAL_PARAMS       (aMgmtInfo is NULL) or
                                            (Invalid ethernet buffer index)
    @retval     #BCM_ERR_UNINIT             Switch driver not initialized

    @post TBD

    @trace  #BRCM_SWREQ_ETHSWT_MANAGEMENT

    @limitations None
*/
int32_t ETHSWT_SetMgmtInfo(ETHER_HwIDType aCntrlID,
                            uint32_t aBufIdx,
                            ETHSWT_MgmtInfoType * const aMgmtInfo);

/** @brief Set RxDIS for the Port

    Enables the receive function of the port at the MAC level.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aSwtID      Switch index
    @param[in]      aPortID     Port ID

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully enabled RxDIS
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized
    @retval     #BCM_ERR_INVAL_PARAMS   (aSwtID is invalid) or
                                        (aPortID is invalid)

    @post None

    @trace  #BRCM_SWREQ_ETHSWT_MANAGEMENT

    @limitations None
*/
int32_t ETHSWT_EnableRx(ETHSWT_HwIDType aSwtID,
                          ETHSWT_PortIDType aPortID);

/** @brief Clear RxDIS for the Port

    Disables the receive function of the port at the MAC level.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aSwtID      Switch index
    @param[in]      aPortID     Port ID

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully enabled RxDIS
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized
    @retval     #BCM_ERR_INVAL_PARAMS   (aSwtID is invalid) or
                                        (aPortID is invalid)

    @post None

    @trace  #BRCM_SWREQ_ETHSWT_MANAGEMENT

    @limitations None
*/
int32_t ETHSWT_DisableRx(ETHSWT_HwIDType aSwtID,
                           ETHSWT_PortIDType aPortID);

/**
    @brief Set port role

    This API sets the port role

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aSwtID      Switch Index
    @param[in]      aSwiType    Switch type
    @param[in]      aPortID     Port ID
    @param[in]      aRole       Role

    Return values are documented in reverse-chronological order
    @retval         #BCM_ERR_OK             On Success
    @retval         #BCM_ERR_TIME_OUT       Timeout occurred while reading/writing
                                            switch register
    @retval         #BCM_ERR_INVAL_PARAMS   (aSwtType is invalid) or
                                            (aPortID is invalid) or
                                            (aRole is invalid)

    @post None

    @trace  #BRCM_SWREQ_ETHSWT_DYNAMIC_CONFIGURATION

    @limitations None
 */
int32_t ETHSWT_SetPortRole(ETHSWT_HwIDType aSwtID,
                           ETHSWT_SwitchType aSwtType,
                           ETHSWT_PortIDType aPortID,
                           ETHSWT_PortType aRole);

/**
    @brief Set switch type

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aSwtID          Switch Index
    @param[in]      aSwitchType     Switch type
    @param[in]      aUplinkPortCnt  Number of uplink ports
    @param[in]      aUplinkPortMap  Array containing the uplink port numbers

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK            On Success
    @retval     #BCM_ERR_TIME_OUT      Timeout occurred while reading/writing
                                       switch register
    @retval     #BCM_ERR_INVAL_PARAMS  aSwitch is invalid or
                                       aUplinkPortMap is NULL when aUplinkPortCnt is non-zero

    @post None

    @trace  #BRCM_SWREQ_ETHSWT_DYNAMIC_CONFIGURATION

    @limitations None
 */
int32_t ETHSWT_SetSwitchType(ETHSWT_HwIDType aSwtID,
                             ETHSWT_SwitchType aSwitchType,
                             uint32_t aUplinkPortCnt,
                             uint32_t *const aUplinkPortMap);

/** @brief Read switch register

    This API read the switch register and returns eth value in aVal.

    @behavior Sync, Re-entrant

    @pre TBD

    @param[in]      aSwtID      Switch index
    @param[in]      aAddr       Register Address
    @param[out]     aVal        Value read from the switch register

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully read register value
    @retval     #BCM_ERR_TIME_OUT       Timeout occurred while reading the
                                        switch register
    @retval     #BCM_ERR_INVAL_PARAMS   (aPage is out of range) or
                                        (aOffset is out of range) or
                                        (Invalid switch index) or
                                        (aVal is NULL)
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post TBD

    @trace  #BRCM_SWREQ_ETHSWT_QUERY

    @limitations None
*/
int32_t ETHSWT_ReadReg(ETHSWT_HwIDType aSwtID,
    uint32_t aAddr,
    uint64_t *const aVal);

/** @brief Write to Switch register

    This API writes the switch register.

    @behavior Sync, Re-entrant

    @pre TBD

    @param[in]      aSwtID      Switch index
    @param[in]      aAddr       Register Address
    @param[in]      aVal        Value to write to the switch register

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully written register value
    @retval     #BCM_ERR_TIME_OUT       Timeout occurred while writing the
                                        switch register
    @retval     #BCM_ERR_INVAL_PARAMS   (aPage is out of range) or
                                        (aOffset is out of range) or
                                        (Invalid switch index)
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized

    @post TBD

    @trace  #BRCM_SWREQ_ETHSWT_DYNAMIC_CONFIGURATION

    @limitations None
*/
int32_t ETHSWT_WriteReg(ETHSWT_HwIDType aSwtID,
                        uint32_t aAddr,
                        uint64_t aVal);

/** @brief Initliaze Ethernet switch driver

    This API initializes Ethernet switch driver

    @behavior Sync, Re-entrant (for different switch index)

    @pre TBD

    @param[in]      aSwtID      Switch index

    @return     void

    @post TBD

    @trace  #BRCM_SWREQ_ETHSWT_INITIALISATION

    @limitations This API doesn’t perform reset of switch. Switch port are
    enabled by system before initialization of switch driver.
*/
void ETHSWT_Init(ETHSWT_HwIDType aSwtID);

/** @brief Enable TX timestamp

    This API adapts a transmit buffer to add the management information and
    prepare for transmission.

    @behavior Sync, Re-entrant

    @pre TBD

    @param[in]      aCntrlID    Controller index
    @param[in]      aBufIdx     Ethernet buffer index
    @param[inout]   aMgmtInfo   Pointer to management information
                                - In: Pointer to the position of the EthType in
                                  common Ethernet frame
                                - Out: Pointer to the position of the EthType in
                                  management frame

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK                 Successfully enabled timestamp for
                                            the given buffer index
    @retval     #BCM_ERR_INVAL_BUF_STATE    Invalid packet buffer state
    @retval     #BCM_ERR_INVAL_PARAMS       (Given TX channel is not allocated for gPTP) or
                                            (aMgmtInfo is NULL) or
                                            (Invalid ethernet buffer index) or
                                            (Invalid switch index)
    @retval     #BCM_ERR_UNINIT             Switch driver not initialized
    @retval     #BCM_ERR_NOSUPPORT          Switch driver does not have timestamp related
                                            functionality (#ENABLE_ETHSWT_TIME) enabled
    @post TBD

    @trace  #BRCM_SWREQ_ETHSWT_MANAGEMENT

    @limitations None
*/
int32_t ETHSWT_EnableTxTimestamp(ETHER_HwIDType aCntrlID,
                                   uint32_t aBufIdx,
                                   ETHSWT_MgmtInfoType *const aMgmtInfo);


/** @brief Enable Broadcom Header Shift

    This API enables/disables broadcom header shift in software

    @behavior Sync, Re-entrant

    @pre    None

    @param[in]      aSwtID      Switch index
    @param[in]      aCntrlID    Controller index
    @param[in]      aEnable     TRUE: Enable, FALSE: Disable

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Enabled/disabled successfully
    @retval     #BCM_ERR_UNINIT         Switch driver not initialized
    @retval     #BCM_ERR_INVAL_PARAMS   aSwtID is invalid OR
                                        aCntrlID is invalid OR
                                        aEnable is invalid
    @retval     #BCM_ERR_NOSUPPORT      Unsupported

    @post   None

    @trace  #BRCM_SWREQ_ETHSWT_INITIALISATION

    @limitations None
*/
extern int32_t ETHSWT_EnableBHShift(ETHSWT_HwIDType aSwtID,
                                 ETHER_HwIDType aCntrlID, uint32_t aEnable);

#endif /* ETHSWT_COMMON_H */

/** @} */
