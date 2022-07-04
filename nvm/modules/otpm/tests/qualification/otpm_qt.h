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
    @defgroup grp_otpm_qt OTPM qualification Test
    @ingroup grp_mcudrv

    @addtogroup grp_otpm_qt
    @{

    @file otpm_qt.h

    @board

    @brief OTP Module qualification Test
    This source file contains the qualification test for OTP Module
    @version 0.1 Initial draft
*/

#ifndef OTPM_QT_H
#define OTPM_QT_H


/**
    @brief Get Mac address from Mac Addr row-0

    @pre MCU is in Init state
         OTPM is in running state

    @test Read MAC from MCU_GetInfo()

    @post Return should be BCM_ERR_OK
          Custom MAC0 should match

    @functional Yes

    @type pos

    @trace #
*/
#define BRCM_SWQTST_OTPM_READ_MAC_CASE0                                     (0x0000UL)

/**
    @brief Get Mac address from Mac Addr row-1

    @pre MCU is in Init state
         OTPM is in running state
         MAC0 Invalid Bit is set

    @test Read MAC from MCU_GetInfo()

    @post Return should be BCM_ERR_OK
          Custom MAC1 should match

    @functional Yes

    @type pos

    @trace #
*/
#define BRCM_SWQTST_OTPM_READ_MAC_CASE1                                     (0x0001UL)

/**
    @brief Get Mac address from Mac Addr row-0 or row-1

    @pre MCU is in Init state
         OTPM is in running state
         MAC0 data is set to 0UL
         MAC1 data is set to 0UL

    @test Try to read MAC from 1st and 2nd valid MAC ROW

    @post Return should be BCM_ERR_NOT_FOUND

    @functional Yes

    @type Neg

    @trace #
*/
#define BRCM_SWQTST_OTPM_READ_MAC_CASE2                             (0x0002UL)

/**
    @brief Get IP address from IP OTP row_0

    @pre MCU is in Init state
         OTPM is in running state

    @test Read IP from MCU_GetInfo()

    @post Return should be BCM_ERR_OK
          Custom IP0 data should match

    @functional Yes

    @type pos

    @trace #
*/
#define BRCM_SWQTST_OTPM_READ_IP_CASE0                                      (0x0003UL)

/**
    @brief Get IP address from IP OTP row_1

    @pre MCU is in Init state
         OTPM is in running state
         IP ROW0 Invalid bit is set

    @test Read IP from MCU_GetInfo()

    @post Return should be BCM_ERR_OK
          Custom IP1 data should match

    @functional Yes

    @type pos

    @trace #
*/
#define BRCM_SWQTST_OTPM_READ_IP_CASE1                                      (0x0004UL)

/**
    @brief Get IP address from IP OTP row_0 or row_1

    @pre MCU is in Init state
         OTPM is in running state
         IP ROW0 Invalid bit is set
         IP ROW1 Invalid bit is set

    @test Read IP from row0 or row1

    @post Return should be BCM_ERR_UNKNOWN

    @functional Yes

    @type Neg

    @trace #
*/
#define BRCM_SWQTST_OTPM_READ_IP_CASE2                                  (0x0005UL)

/**
    @brief Get Stacking and Switch related Info

    @pre MCU is in Init state
         OTPM is in running state

    @test Read Stacking and Switch Info from MCU_GetInfo()

    @post Return should be BCM_ERR_OK
          Custom stacking and switch data should match

    @functional Yes

    @type Pos

    @trace #
*/
#define BRCM_SWQTST_OTPM_READ_SWITCH_INFO                               (0x0006UL)

/**
    @brief Get TC10 related Info

    @pre OTPM is in running state

    @test Read TC10 data from otp/alt memory

    @post Return should be BCM_ERR_OK
          Custom data should match

    @functional Yes

    @type Pos

    @trace #
*/
#define BRCM_SWQTST_OTPM_READ_TC10                               (0x0007UL)

/**
    @brief Get PubKey

    @pre OTPM is in running state
         OTP secure bit row is not set

    @test Read PubKey from otp/alt memory

    @post Return should be BCM_ERR_NOT_FOUND

    @functional Yes

    @type Pos

    @trace #
*/
#define BRCM_SWQTST_OTPM_READ_PUBKEY_NONSEC                                    (0x0008UL)

/**
    @brief Get PubKey

    @pre OTPM is in running state
         OTP secure bit row is set

    @test Read PubKey from otp/alt memory

    @post Return should be BCM_ERR_OK
          Custom data should match

    @functional Yes

    @type Pos

    @trace #
*/
#define BRCM_SWQTST_OTPM_READ_PUBKEY_SEC                                    (0x0009UL)

/**
    @brief Get OTPM_GetEnabledBootModes

    @pre OTPM is in running state

    @test Read Boot Mode

    @post Return should be BCM_ERR_OK

    @functional Yes

    @type Pos

    @trace #
*/
#define BRCM_SWQTST_OTPM_GET_EN_BOOTMODE                                     (0x000AUL)

/**
    @brief Get OTPM_GetEnabledBootModes

    @pre OTPM is in UNINIT state

    @test Read Boot Mode with NULL as argument

    @post Return should be BCM_ERR_INVAL_PARAMS

    @functional Yes

    @type Neg

    @trace #
*/
#define BRCM_SWQTST_OTPM_GET_EN_BOOTMODE_NEG_CASE0                                     (0x000BUL)

/**
    @brief Get OTPM_GetEnabledBootModes

    @pre OTPM is in UNINIT state

    @test Read Boot Mode

    @post Return should be BCM_ERR_INVAL_STATE

    @functional Yes

    @type Neg

    @trace #
*/
#define BRCM_SWQTST_OTPM_GET_EN_BOOTMODE_NEG_CASE1                                     (0x000CUL)

/**
    @brief Get OTPM_ReadTC10Config with aMemAddr = NULL

    @post Return should be BCM_ERR_INVAL_PARAMS
 */
#define BRCM_SWQTST_OTPM_READ_TC10_NEG_CASE0                                           (0x000DUL)

/**
    @brief Get OTPM_ReadTC10Config with aFilledSize = NULL

    @post Return should be BCM_ERR_INVAL_PARAMS
 */
#define BRCM_SWQTST_OTPM_READ_TC10_NEG_CASE1                                           (0x000EUL)

/**
    @brief Get OTPM_ReadTC10Config with sizeof buffer less than TC10 size

    @post Return should be BCM_ERR_NOMEM
 */
#define BRCM_SWQTST_OTPM_READ_TC10_NEG_CASE2                                           (0x000FUL)

/**
    @brief Get OTPM_ReadTC10Config with ECC error backdoor load data

    @post Return should be BCM_ERR_DATA_INTEG
 */
#define BRCM_SWQTST_OTPM_READ_TC10_NEG_CASE3                                           (0x0010UL)

/**
    @brief Get OTPM_ReadTC10Config

    @pre OTP Module is in UNINIT State

    @post Return should be BCM_ERR_DATA_INTEG
 */
#define BRCM_SWQTST_OTPM_READ_TC10_NEG_CASE4                                           (0x0010UL)

/**
    @brief Call OTPM_ReadPubKey() with pubKey = NULL

    @post Return should be BCM_ERR_INVAL_PARAMS
 */
#define BRCM_SWQTST_OTPM_READ_PUBKEY_NEG_CASE0                                         (0x0010UL)

/**
    @brief Call OTPM_ReadPubKey() with pubKeyType = NULL

    @post Return should be BCM_ERR_INVAL_PARAMS
 */
#define BRCM_SWQTST_OTPM_READ_PUBKEY_NEG_CASE1                                         (0x0011UL)

/**
    @brief Call OTPM_ReadPubKey() with pubKeyLen = NULL

    @post Return should be BCM_ERR_INVAL_PARAMS
 */
#define BRCM_SWQTST_OTPM_READ_PUBKEY_NEG_CASE2                                         (0x0012UL)

/**
    @brief Call OTPM_ReadPubKey() with invalid pubKey buffer size

    @post Return should be BCM_NO_MEM
 */
#define BRCM_SWQTST_OTPM_READ_PUBKEY_NEG_CASE3                                         (0x0013UL)

/**
    @brief Read OTPM_ReadPubKey() with ECC error backdoor load data

    @post Return should be BCM_ERR_DATA_INTEG
 */
#define BRCM_SWQTST_OTPM_READ_PUBKEY_NEG_CASE4                                         (0x0014UL)

/**
  @brief Qualification test sequence for OTP Module with OTPM_test_seq_data0

  @code{.c}

  Update Magic & CRC for OTP Alt memory
  Copy the data to alt memory location
  Call MODULE_ResetStateHandler(OTPM_Module)
  Call MODULE_InitStateHandler(OTPM_Module)
  Call MODULE_ReadyStateHandler(OTPM_Module, RUN)

  Call  MCU_GetInfo() and fetch MAC Address
  Check Expected Result for #BRCM_SWQTST_OTPM_READ_MAC_CASE0

  Call  MCU_GetInfo() and fetch IP Address
  Check Expected Result for #BRCM_SWQTST_OTPM_READ_IP_CASE0

  Call  MCU_GetInfo() and fetch stacking and switch related information
  Check Expected Result for #BRCM_SWQTST_OTPM_READ_SWITCH_INFO

  Call  OTPM_ReadTC10Config()
  Check Expected Result for #BRCM_SWQTST_OTPM_READ_TC10

  Call  OTPM_GetEnabledBootModes()
  Check Expected Result for #BRCM_SWQTST_OTPM_GET_EN_BOOTMODE

  Call MODULE_RunStateHandler(OTPM_Module, UNINIT)

  @endcode

  @auto           Yes

  @type           Sanity

  @executetime    1s

  @analyzetime    1h


*/
#define BRCM_SWQTSEQ_OTPM_0                                     (0x0001UL)

/**
  @brief Qualification test sequence for OTP Module with OTPM_test_seq_data1

  @code{.c}

  Disable alt memory in OTP
  Call MODULE_ResetStateHandler(OTPM_Module)
  Call MODULE_InitStateHandler(OTPM_Module)
  Call MODULE_ReadyStateHandler(OTPM_Module, RUN)

  Call  MCU_GetInfo() and fetch MAC Address
  Check Expected Result for #BRCM_SWQTST_OTPM_READ_MAC_CASE1

  Call  MCU_GetInfo() and fetch IP Address
  Check Expected Result for #BRCM_SWQTST_OTPM_READ_IP_CASE1

  Call MODULE_RunStateHandler(OTPM_Module, UNINIT)

  @endcode

  @auto           Yes

  @type           Sanity

  @executetime    1s

  @analyzetime    1h


*/
#define BRCM_SWQTSEQ_OTPM_1                                     (0x0002UL)

/**
  @brief Qualification test sequence for OTP Module with OTPM_test_seq_data2

  @code{.c}

  Update Magic & CRC for OTP Alt memory
  Copy the data to alt memory location

  Call MODULE_ResetStateHandler(OTPM_Module)
  Call MODULE_InitStateHandler(OTPM_Module)
  Call MODULE_ReadyStateHandler(OTPM_Module, RUN)

  Call  MCU_GetInfo() and fetch MAC Address
  Check Expected Result for #BRCM_SWQTST_OTPM_READ_MAC_CASE2

  Call  MCU_GetInfo() and fetch IP Address
  Check Expected Result for #BRCM_SWQTST_OTPM_READ_IP_CASE2

  Call MODULE_RunStateHandler(OTPM_Module, UNINIT)

  @endcode

  @auto           Yes

  @type           Sanity

  @executetime    1s

  @analyzetime    1h


*/
#define BRCM_SWQTSEQ_OTPM_2                                     (0x0003UL)

/**
  @brief Negative test sequence for OTP Module

  @code{.c}

  Call OTPM_GetEnabledBootModes(NULL)

  @endcode

  @auto           Yes

  @type           Sanity

  @executetime    1s

  @analyzetime    1h

*/
#define BRCM_SWQTSEQ_OTPM_NEG_0                                 (0x0004UL)
#define BRCM_SWQTSEQ_OTPM_NEG_1                                 (0x0005UL)

/**
  @brief Qualification test sequence for OTP Module with OTPM_test_seq_secure_data0

  @code{.c}

  Call MODULE_ResetStateHandler(OTPM_Module)
  Call MODULE_InitStateHandler(OTPM_Module)
  Call MODULE_ReadyStateHandler(OTPM_Module, RUN)

  Call  OTPM_ReadPubKey()
  Check Expected Result for #BRCM_SWQTST_OTPM_READ_PUBKEY_NONSEC


  Call MODULE_RunStateHandler(OTPM_Module, UNINIT)

  @endcode

  @auto           Yes

  @type           Sanity

  @executetime    1s

  @analyzetime    1h


*/
#define BRCM_SWQTSEQ_OTPM_SECURE_0                                  (0x0010UL)

/**
  @brief Qualification test sequence for OTP Module with OTPM_test_seq_secure_data1

  @code{.c}

  Call MODULE_ResetStateHandler(OTPM_Module)
  Call MODULE_InitStateHandler(OTPM_Module)
  Call MODULE_ReadyStateHandler(OTPM_Module, RUN)

  Call  OTPM_ReadPubKey()
  Check Expected Result for #BRCM_SWQTST_OTPM_READ_PUBKEY_SEC


  Call MODULE_RunStateHandler(OTPM_Module, UNINIT)

  @endcode

  @auto           Yes

  @type           Sanity

  @executetime    1s

  @analyzetime    1h

*/
#define BRCM_SWQTSEQ_OTPM_SECURE_1                                  (0x0011UL)


#endif /* OTPM_QT_H */
/** @} */

