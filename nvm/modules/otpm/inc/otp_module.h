/*****************************************************************************
 Copyright 2021 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_otpm_ifc OTP Module Interface
    @ingroup grp_otpm

    @addtogroup grp_otpm_ifc
    @{

    @file opt_module.h

    @brief OTP Module Interface
    This file contains the interfaces for the OTP module

    @version 0.1 Initial version
*/

#ifndef OTP_MODULE_H
#define OTP_MODULE_H

#include <module.h>

/**
    @name OTP Module IDs
    @{
    @brief Architecture API IDs for OTP module
*/
#define BRCM_SWARCH_OTPM_IP_CFG_TYPE              (0x8100U)    /**< @brief #OTPM_IPCfgType        */
#define BRCM_SWARCH_OTPM_HW_ID_TYPE               (0x8101U)    /**< @brief #OTPM_HwIDType         */
#define BRCM_SWARCH_OTPM_BOOTMODE_TYPE            (0x8102U)    /**< @brief #OTPM_BootModeType        */
#define BRCM_SWARCH_OTPM_READ_PUBKEY_PROC         (0x8103U)    /**< @brief #OTPM_ReadPubKey          */
#define BRCM_SWARCH_OTPM_READ_TC10_CONFIG_PROC    (0x8105U)    /**< @brief #OTPM_ReadTC10Config      */
#define BRCM_SWARCH_OTPM_GET_BOOTMODE_PROC        (0x8106U)    /**< @brief #OTPM_GetEnabledBootModes */
#define BRCM_SWARCH_OTPM_ALT_MEM_HDR_TYPE         (0x8107U)    /**< @brief #OTPM_AltMemHdrType */
#define BRCM_SWARCH_OTPM_ALTMEM_GLOBAL            (0x8108U)    /**< @brief #OTPM_AltMem */
/** @} */

/**
    @name Boot Mode flags
    @{
    @brief Boot Mode flags

    @trace #BRCM_SWREQ_OTPM
 */
typedef uint32_t OTPM_BootModeType;        /**< @brief Bootmode bit flags */
#define OTPM_BOOTMODE_FLASH         (1UL)  /**< @brief Flash Boot */
#define OTPM_BOOTMODE_TFTP          (2UL)  /**< @brief TFTP Boot */
#define OTPM_BOOTMODE_IPC           (4UL)  /**< @brief IPC Boot */
/** @} */

/**
    @brief OTP Alternet Memory

    @trace #BRCM_SWREQ_OTPM
 */
#ifdef OTPM_ALT_MEM_ROWS_COUNT
extern uint32_t OTPM_AltMem[OTPM_ALT_MEM_ROWS_COUNT];
#endif

/**
    @brief OTP Alternate memory header

    Alternate config memory header format

    @trace #BRCM_SWREQ_OTPM
*/
typedef struct sOTPM_AltMemHdrType {
    uint32_t magic;         /**< @brief Alternate memory magic #OTPM_ALT_MEM_MAGIC (OTPA) */
    uint32_t crc;           /**< @brief CRC of the config region */
    uint32_t reserved[2];   /**< @brief Reserved */
} OTPM_AltMemHdrType;

/**
    @brief OTP IP config data

    @trace #BRCM_SWREQ_OTPM
 */
typedef struct sOTPM_IPCfgType {
    uint32_t            ipAddr;      /**< @brief IP address to be used for private communication */
    uint32_t            gwIPAddr;    /**< @brief Gateway IP address to be used for private communication */
    uint32_t            appInfo;     /**< @brief 24 bits of application specific information*/
    uint8_t             netmask;     /**< @brief Netmask to be used for private communication */
    uint32_t            tftpIPAddr;  /**< @brief TFTP server IP address */
} OTPM_IPCfgType;

/** @brief Read Public Key

  Interface to read public key from OTP rows

  @behavior Sync, None re-entrant

  @pre TBD

  @param[out]   aKey       Pointer to the memory where public key will be copied
  @param[in]    aBufSize   Size of the input key buffer
  @param[out]   aKeyType   Actual key type read.
  @param[out]   aKeySize   Actual key size read.

  Return values are documented in reverse-chronological order

  @retval      #BCM_ERR_OK              OTP public key read was successful
  @retval      #BCM_ERR_DATA_INTEG      Public key is Invalid
  @retval      #BCM_ERR_UNKNOWN         Unknown error occurred while sending OTP command to controller
  @retval      #BCM_ERR_UNINIT          OTP driver in uninitialised state
  @retval      #BCM_ERR_UNKNOWN         Timeout occurred while sending OTP command to controller
  @retval      #BCM_ERR_NOT_FOUND       Not a secure variant
  @retval      #BCM_ERR_NOMEM           aBufSize is less than Public key size
  @retval      #BCM_ERR_NOSUPPORT       Requested operation not supported.
  @retval      #BCM_ERR_INVAL_PARAMS    aKey is not valid
                                        aKeyType is NULL
                                        aKeySize is NULL

  @post TBD

  @trace #BRCM_SWREQ_OTPM

  @limitations

*/
int32_t OTPM_ReadPubKey(uint8_t *const aKey, uint32_t aBufSize, uint32_t * const aKeyType, uint32_t * const aKeySize);

/** @brief Read TC10 Configuration data

  Interface to read TC10 Configuration from OTP rows

  @behavior Sync, None re-entrant

  @pre TBD

  @param[out]   aMemAddr    Buffer where the data will be copied
  @param[in]    aBufSize    Size of the input buffer
  @param[out]   aFilledSize Actual TC10 config size read

  Return values are documented in reverse-chronological order

  @retval      #BCM_ERR_OK              OTP switch config data read was successful
  @retval      #BCM_ERR_DATA_INTEG      TC10 configuration is Invalid
  @retval      #BCM_ERR_UNKNOWN         Unknown error occurred while sending OTP command to controller
  @retval      #BCM_ERR_UNKNOWN         Timeout occurred while sending OTP command to controller
  @retval      #BCM_ERR_UNINIT          OTP driver in uninitialised state
  @retval      #BCM_ERR_NOMEM           aBufSize is less than the TC10 Config size
  @retval      #BCM_ERR_NOSUPPORT       Not supported
  @retval      #BCM_ERR_INVAL_PARAMS    aMemAddr is NULL
  @post TBD

  @trace #BRCM_SWREQ_OTPM

  @limitations

*/
int32_t OTPM_ReadTC10Config(uint32_t *const aMemAddr,
                            uint32_t aBufSize,
                            uint32_t *const aFilledSize);

/** @brief Get Enabled boot-modes

  Interface to get all the enabled boot modes

  @behavior Sync, None re-entrant

  @pre None

  @param[out]   aBootModes    Bit flags for each enabled boot modes

  Return values are documented in reverse-chronological order

  @retval      #BCM_ERR_OK           Boot modes read successfully
  @retval      #BCM_ERR_UNINIT       OTP driver in uninitialised state
  @retval      #BCM_ERR_INVAL_PARAMS aBootModes is NULL
  @post None

  @trace #BRCM_SWREQ_OTPM

  @limitations

*/
int32_t OTPM_GetEnabledBootModes(OTPM_BootModeType *const aBootModes);

#endif /* OTP_MODULE_H */

/** @} */
