/*****************************************************************************
 Copyright 2019-2020 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_otpdrv_ifc Interface
    @ingroup grp_otpdrv

    @addtogroup grp_otpdrv_ifc
    @{
    @section sec_otp_overview Overview
    @todo image html otp_overview.jpg "OTP driver overview"
    OTP driver manages OTP controller in the system.

    OTP driver supports following operations on the OTP controller:
    - OTP read
    - OTP write

    @section sec_otp_fsm State Machine
    This section describes driver state machines for status transition during
    otp driver operation.
    @todo image html otp_state_machine.jpg "OTP driver state machine"
    - #OTP_DRVSTATE_UNINIT: OTP driver uninitialized or de-initialized after
      initialization.
    - #OTP_DRVSTATE_INIT: OTP driver is initialized

    @section sec_otp_seq Sequence Diagrams
    This section describes sequence diagrams for APIs to better understand OTP
    driver interface. Sequence diagrams are based on synchronous behavior of
    the interface.

    @subsection subsec_otp_use_case_seq OTP Driver Use Case sequence
    The following sequence diagram depicts the typical use case sequence for
    OTP APIs.

    @todo image html otp_seq_use_case.jpg "OTP use case sequence"
    @section sec_otp_perf Performance & Memory

    | Performance       | Description                                       |
    |:-----------------:|:-------------------------------------------------:|
    | CPU Load          |   NA                                              |
    | Memory Bandwidth  |   TBD                                             |
    | HW Utilization    |   NA                                              |

    @includedoc drivers_otp.dep

    @limitations None

    @file otp.h
    @brief Interfaces for OTP driver
    This header file  defines interface for OTP driver.

    @version 1.31 Imported from docx
*/

#ifndef OTP_H
#define OTP_H

#include <bcm_err.h>

/**
    @name OTP driver API IDs
    @{
    @brief API IDs for OTP drier
 */
#define BRCM_SWARCH_OTP_SWT_CFG_TYPE             (0x8101U)    /**< @brief #OTP_SwtCfgType       */
#define BRCM_SWARCH_OTP_IP_CFG_TYPE              (0x8102U)    /**< @brief #OTP_IPCfgType        */
#define BRCM_SWARCH_OTP_HW_ID_TYPE               (0x8103U)    /**< @brief #OTP_HwIDType         */
#define BRCM_SWARCH_OTP_INIT_PROC                (0x8104U)    /**< @brief #OTP_Init             */
#define BRCM_SWARCH_OTP_READ_PROC                (0x8105U)    /**< @brief #OTP_Read             */
#define BRCM_SWARCH_OTP_WRITE_PROC               (0x8106U)    /**< @brief #OTP_Write            */
#define BRCM_SWARCH_OTP_DEINIT_PROC              (0x8107U)    /**< @brief #OTP_DeInit           */
#define BRCM_SWARCH_OTP_READ_PUBKEY_PROC         (0x8108U)    /**< @brief #OTP_ReadPubKey       */
#define BRCM_SWARCH_OTP_READ_DECYPTKEY_PROC      (0x8109U)    /**< @brief #OTP_ReadDecryptKey   */
#define BRCM_SWARCH_OTP_READ_SWT_CONFIG_PROC     (0x810AU)    /**< @brief #OTP_ReadSwitchConfig */
#define BRCM_SWARCH_OTP_READ_MAC_ADDR_PROC       (0x810BU)    /**< @brief #OTP_ReadMacAddr      */
#define BRCM_SWARCH_OTP_READ_IP_ADDR_PROC        (0x810CU)    /**< @brief #OTP_ReadIPConfig     */
#define BRCM_SWARCH_OTP_READ_XCVR_CONFIG_PROC    (0x810DU)    /**< @brief #OTP_ReadXCVRConfig   */
#define BRCM_SWARCH_OTP_READ_TC10_CONFIG_PROC    (0x810EU)    /**< @brief #OTP_ReadTC10Config   */
/** @} */

/**
    @brief OTP switch config data

    @trace #BRCM_SWREQ_OTP_SPECIAL_OPERATIONS
 */
typedef struct sOTP_SwtCfgType {
    uint8_t            stackingEn; /**< @brief Stacking Enable, 0: Disable, 1: Enable */
    uint32_t           mstSlvMode; /**< @brief 0: Master, 1: Slave-1, 2: Slave-2      */
    uint8_t            stackPort0; /**< @brief Stacking Port 0 info                   */
    uint8_t            stackPort1; /**< @brief Stacking Port 1 info                   */
    uint8_t            impPort;    /**< @brief Port number enabled in IMP mode (port-5/port8) */
    uint16_t           vlan;       /**< @brief VLAN Id to be used for private communication */
    uint8_t            xcvrCount;  /**< @brief Number of XCVR config Row*/
} OTP_SwtCfgType;

/**
    @brief OTP IP config data

    @trace #BRCM_SWREQ_OTP_SPECIAL_OPERATIONS
 */
typedef struct sOTP_IPCfgType {
    uint32_t            ipAddr;      /**< @brief IP address to be used for private communication */
    uint32_t            gwIPAddr;    /**< @brief Gateway IP address to be used for private communication */
    uint32_t            appInfo;     /**< @brief 24 bits of application specific information*/
    uint8_t             netmask;     /**< @brief Netmask to be used for private communication */
    uint32_t            tftpIPAddr;  /**< @brief TFTP server IP address */
} OTP_IPCfgType;

/**
    @brief OTP controller ID type

    @trace #BRCM_SWREQ_OTP_KERNEL_INTERFACE
 */
typedef uint32_t OTP_HwIDType;  /**< @brief OTP controller index type */
#define OTP_HW_ID_0         (0UL)  /**<@brief OTP controller ID 0 */

/** @brief Initialise OTP
 *
 * Intialise OTP driver
 *
 * @behavior Sync, Non re-entrant
 *
 * @pre TBD
 *
 * @param[in]   aID         Index of the OTP controller
 *
 * Return values are documented in reverse-chronological order
 *
 * @retval      #BCM_ERR_OK              OTP read was successful
 * @retval      #BCM_ERR_INVAL_PARAMS    aID is not valid
 * @retval      #BCM_ERR_INVAL_STATE     Invalid driver state
 *
 * @post API to initialize OTP driver. Up on successful initialization,
 * OTP driver state changes to #OTP_DRVSTATE_UNINIT
 *
 * @trace #BRCM_SWREQ_OTP_INIT
 *
 * @limitations None
 *
 */
int32_t OTP_Init(OTP_HwIDType aID);

/** @brief Read an OTP row
 *
 * Interface to read an OTP row
 *
 * @behavior Sync, Non re-entrant
 *
 * @pre TBD
 *
 * @param[in]       aID         Index of the OTP controller
 * @param[in]       aAddr       OTP address (row number) to read
 * @param[inout]    aData       Pointer to the memory where data will be copied
 *
 * Return values are documented in reverse-chronological order
 *
 * @retval      #BCM_ERR_OK              OTP read was successful
 * @retval      #BCM_ERR_INVAL_PARAMS    aID is not valid
 * @retval      #BCM_ERR_INVAL_PARAMS    aAddr is not within the range
 * @retval      #BCM_ERR_INVAL_PARAMS    aData is NULL
 * @retval      #BCM_ERR_UNINIT          OTP driver in uninitialised state
 * @retval      #BCM_ERR_TIME_OUT        timeout occurred while sending OTP command to controller
 * @retval      #BCM_ERR_DATA_INTEG      ECC error detected while reading the OTP row
 *
 * @post TBD
 *
 * @trace #BRCM_SWREQ_OTP_OPERATIONS
 *
 * @limitations None
 *
 */
int32_t OTP_Read(OTP_HwIDType aID,
                    uint32_t aAddr,
                    uint32_t *const aData);

/** @brief Write an OTP row
 *
 * Interface to write an OTP row
 *
 * @behavior Sync, None re-entrant
 *
 * @pre TBD
 *
 * @param[in]   aID         Index of the OTP controller
 * @param[in]   aAddr       OTP address (row number) to write
 * @param[in]   aData       Data to be written to the OTP address
 *
 * Return values are documented in reverse-chronological order
 *
 * @retval      #BCM_ERR_OK              OTP written successfully
 * @retval      #BCM_ERR_INVAL_PARAMS    aID is not valid
 * @retval      #BCM_ERR_INVAL_PARAMS    aAddr is not within the range
 * @retval      #BCM_ERR_INVAL_PARAMS    aData value bit-width greater than
 *                                       OTP row bit-width. Refer @sec_ref_trm
 *                                       for exact OTP row bit-width.
 * @retval      #BCM_ERR_UNINIT          OTP driver in uninitialised state
 * @retval      #BCM_ERR_TIME_OUT        Timeout occurred while sending OTP command to controller
 * @retval      #BCM_ERR_UNKNOWN         Unknown error occurred while sending OTP command to controller
 * @retval      #BCM_ERR_NOSUPPORT       Write is not supported
 *
 * @post TBD
 *
 * @trace #BRCM_SWREQ_OTP_OPERATIONS
 *
 * @limitations Currently OTP_Write is not supported by driver.
 *
 */
int32_t OTP_Write(OTP_HwIDType aID,
                     uint32_t aAddr,
                     uint32_t aData);

/** @brief Read Public Key

  Interface to read public key from OTP rows

  @behavior Sync, None re-entrant

  @pre TBD

  @param[in]    aID        Index of the OTP controller
  @param[out]   aKey       Pointer to the memory where public key will be copied
  @param[inout] aLen       Pointer to the length(byte) of input key buffer
                           & returns length(byte) of output data.

  Return values are documented in reverse-chronological order

  @retval      #BCM_ERR_OK              OTP public key read was successful
  @retval      #BCM_ERR_DATA_INTEG      Public key is Invalid
  @retval      #BCM_ERR_UNKNOWN         Unknown error occurred while sending OTP command to controller
  @retval      #BCM_ERR_UNKNOWN         OTP driver in uninitialised state
  @retval      #BCM_ERR_UNKNOWN         Timeout occurred while sending OTP command to controller
  @retval      #BCM_ERR_UNKNOWN         aID is not valid
  @retval      #BCM_ERR_NOT_FOUND       Not a secure variant
  @retval      #BCM_ERR_NOMEM           aKey buffer size is less than Public key size
  @retval      #BCM_ERR_NOSUPPORT       Requested operation not supported.
  @retval      #BCM_ERR_INVAL_PARAMS    aKey is not valid
  @retval      #BCM_ERR_INVAL_PARAMS    aLen is not valid

  @post TBD

  @trace #BRCM_SWREQ_OTP_SPECIAL_OPERATIONS

  @limitations

*/
int32_t OTP_ReadPubKey(OTP_HwIDType aID,
                        uint8_t *const aKey,
                        uint32_t *aLen);

/** @brief Read Symmetric Key

  Interface to read Symmetric key from OTP rows

  @behavior Sync, None re-entrant

  @pre TBD

  @param[in]    aID        Index of the OTP controller
  @param[out]   aKey       Pointer to the memory where Symmetric key will be copied
  @param[inout] aLen       Pointer to the length(byte) of input key buffer
                           & returns length(byte) of output data.

  Return values are documented in reverse-chronological order

  @retval      #BCM_ERR_OK              OTP Symmetric key read was successful
  @retval      #BCM_ERR_DATA_INTEG      Symmetric key is Invalid
  @retval      #BCM_ERR_UNKNOWN         Unknown error occurred while sending OTP command to controller
  @retval      #BCM_ERR_UNKNOWN         OTP driver in uninitialised state
  @retval      #BCM_ERR_UNKNOWN         Timeout occurred while sending OTP command to controller
  @retval      #BCM_ERR_UNKNOWN         aID is not valid
  @retval      #BCM_ERR_NOT_FOUND       Decryption is not enabled
  @retval      #BCM_ERR_NOMEM           aKey buffer size is less than Decrypt key size
  @retval      #BCM_ERR_NOSUPPORT       Requested operation not supported.
  @retval      #BCM_ERR_INVAL_PARAMS    aKey is not valid
  @retval      #BCM_ERR_INVAL_PARAMS    aLen is not valid

  @post TBD

  @trace #BRCM_SWREQ_OTP_SPECIAL_OPERATIONS

  @limitations

*/
int32_t OTP_ReadDecryptKey(OTP_HwIDType aID,
                        uint8_t *const aKey,
                        uint32_t *aLen);

/** @brief Read switch config data

  Interface to read switch configuration from OTP rows

  @behavior Sync, None re-entrant

  @pre TBD

  @param[in]    aID        Index of the OTP controller
  @param[out]   aConfig    Pointer to the structure where data will be copied

  Return values are documented in reverse-chronological order

  @retval      #BCM_ERR_OK              OTP switch config data read was successful
  @retval      #BCM_ERR_DATA_INTEG      switch configuration is Invalid
  @retval      #BCM_ERR_UNKNOWN         Unknown error occurred while sending OTP command to controller
  @retval      #BCM_ERR_UNKNOWN         OTP driver in uninitialised state
  @retval      #BCM_ERR_UNKNOWN         Timeout occurred while sending OTP command to controller
  @retval      #BCM_ERR_UNKNOWN         aID is not valid
  @retval      #BCM_ERR_NOSUPPORT       Requested operation not supported
  @retval      #BCM_ERR_INVAL_PARAMS    aConfig is not valid


  @post TBD

  @trace #BRCM_SWREQ_OTP_SPECIAL_OPERATIONS

  @limitations

*/
int32_t OTP_ReadSwitchConfig(OTP_HwIDType aID,
                               OTP_SwtCfgType *const aConfig);

/** @brief Read MAC address

  Interface to read MAC address from OTP rows

  @behavior Sync, None re-entrant

  @pre TBD

  @param[in]    aID        Index of the OTP controller
  @param[out]   aMacAddr   Pointer to the buffer where MAC address will be copied

  Return values are documented in reverse-chronological order

  @retval      #BCM_ERR_OK              OTP switch config data read was successful
  @retval      #BCM_ERR_DATA_INTEG      MAC address is Invalid
  @retval      #BCM_ERR_UNKNOWN         Unknown error occurred while sending OTP command to controller
  @retval      #BCM_ERR_UNKNOWN         OTP driver in uninitialised state
  @retval      #BCM_ERR_UNKNOWN         Timeout occurred while sending OTP command to controller
  @retval      #BCM_ERR_UNKNOWN         aID is not valid
  @retval      #BCM_ERR_NOT_FOUND       MAC address is not programmed
  @retval      #BCM_ERR_INVAL_PARAMS    aMacAddr is not valid

  @post TBD

  @trace #BRCM_SWREQ_OTP_SPECIAL_OPERATIONS

  @limitations

*/
int32_t OTP_ReadMacAddr(OTP_HwIDType aID,
                               uint8_t *const aMacAddr);

/** @brief Read IP address configuration data

  Interface to read IP address configuration from OTP rows

  @behavior Sync, None re-entrant

  @pre TBD

  @param[in]    aID        Index of the OTP controller
  @param[out]   aConfig    Pointer to the structure where data will be copied

  Return values are documented in reverse-chronological order

  @retval      #BCM_ERR_OK              OTP switch config data read was successful
  @retval      #BCM_ERR_DATA_INTEG      IP address is Invalid
  @retval      #BCM_ERR_UNKNOWN         Unknown error occurred while sending OTP command to controller
  @retval      #BCM_ERR_UNKNOWN         Timeout occurred while sending OTP command to controller
  @retval      #BCM_ERR_UNKNOWN         OTP driver in uninitialised state
  @retval      #BCM_ERR_UNKNOWN         aID is not valid
  @retval      #BCM_ERR_NOSUPPORT       Requested operation not supported
  @retval      #BCM_ERR_INVAL_PARAMS    aConfig is not valid

  @post TBD

  @trace #BRCM_SWREQ_OTP_SPECIAL_OPERATIONS

  @limitations

*/
int32_t OTP_ReadIPConfig(OTP_HwIDType aID,
                    OTP_IPCfgType *const aConfig);

/** @brief Read Transceiver Configuration data

  Interface to read Transceiver Configuration from OTP rows

  @behavior Sync, None re-entrant

  @pre TBD

  @param[in]    aID        Index of the OTP controller
  @param[out]   aMemAddr   Pointer to the buffer where data will be copied
  @param[inout] aLen       Pointer to the length(byte) of input buffer
                           & returns length(byte) of output data filled in buffer.

  Return values are documented in reverse-chronological order

  @retval      #BCM_ERR_OK              OTP switch config data read was successful
  @retval      #BCM_ERR_DATA_INTEG      Transceiver configuration is Invalid
  @retval      #BCM_ERR_UNKNOWN         Unknown error occurred while sending OTP command to controller
  @retval      #BCM_ERR_UNKNOWN         Timeout occurred while sending OTP command to controller
  @retval      #BCM_ERR_UNKNOWN         OTP driver in uninitialised state
  @retval      #BCM_ERR_UNKNOWN         aID is not valid
  @retval      #BCM_ERR_NOMEM           aMemAddr buffer size is less than Public key size
  @retval      #BCM_ERR_INVAL_PARAMS    aMemAddr is not valid
  @retval      #BCM_ERR_INVAL_PARAMS    aLen is not valid
  @post TBD

  @trace #BRCM_SWREQ_OTP_SPECIAL_OPERATIONS

  @limitations

*/
int32_t OTP_ReadXCVRConfig(OTP_HwIDType aID,
                                uint32_t *const aMemAddr,
                                uint32_t *const aLen);

/** @brief Read TC10 Configuration data

  Interface to read TC10 Configuration from OTP rows

  @behavior Sync, None re-entrant

  @pre TBD

  @param[in]    aID        Index of the OTP controller
  @param[out]   aMemAddr   Pointer to the buffer where data will be copied
  @param[inout] aLen       Pointer to the length(byte) of input buffer
                           & returns length(byte) of output data filled in buffer.

  Return values are documented in reverse-chronological order

  @retval      #BCM_ERR_OK              OTP switch config data read was successful
  @retval      #BCM_ERR_DATA_INTEG      TC10 configuration is Invalid
  @retval      #BCM_ERR_UNKNOWN         Unknown error occurred while sending OTP command to controller
  @retval      #BCM_ERR_UNKNOWN         Timeout occurred while sending OTP command to controller
  @retval      #BCM_ERR_UNKNOWN         OTP driver in uninitialised state
  @retval      #BCM_ERR_UNKNOWN         aID is not valid
  @retval      #BCM_ERR_NOMEM           aMemAddr buffer size is less than Public key size.
  @retval      #BCM_ERR_INVAL_PARAMS    aMemAddr is not valid
  @retval      #BCM_ERR_INVAL_PARAMS    aLen is not valid
  @post TBD

  @trace #BRCM_SWREQ_OTP_SPECIAL_OPERATIONS

  @limitations

*/
int32_t OTP_ReadTC10Config(OTP_HwIDType aID,
                                uint32_t *const aMemAddr,
                                uint32_t *const aLen);

/** @brief DeInitialise OTP
 *
 * DeIntialise OTP driver
 *
 * @behavior Sync, Non re-entrant
 *
 * @pre TBD
 *
 * @param[in]   aID         Index of the OTP controller
 *
 * Return values are documented in reverse-chronological order
 *
 * @retval      #BCM_ERR_OK              OTP DeInit was successful
 * @retval      #BCM_ERR_INVAL_PARAMS    aID is not valid
 * @retval      #BCM_ERR_INVAL_STATE     Invalid driver state
 *
 * @post API to Deinitialize OTP driver. Up on successful Deinitialization,
 * OTP driver state changes to #OTP_DRVSTATE_UNINIT
 *
 * @trace #BRCM_SWREQ_OTP_INIT
 *
 * @limitations None
 *
 */
int32_t OTP_DeInit(OTP_HwIDType aID);
#endif /* OTP_H */

/** @} */
