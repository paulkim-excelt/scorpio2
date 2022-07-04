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
    @defgroup grp_otpm_ct OTPM coverage Test
    @ingroup grp_otpm

    @addtogroup grp_otpm_ct
    @{

    @file otpm_ct.h

    @board

    @brief OTP Module coverage Test
    This source file contains the coverage test for OTP Module
    @version 0.1 Initial draft
*/

#ifndef OTPM_PT_H
#define OTPM_PT_H

/**
    @brief Call OTPM_ReadValidConfig() with probe lInvalAddr = 0UL, lStartAddr = 0UL

    @pre NA

    @test Call OTPM_ResetHandler

    @post #BCM_ERR_UNKNOWN should be returned

    @functional No

    @type Neg

    @trace #
*/
#define BRCM_SWPTST_OTPM_READ_VALIDCFG_PROBE_CASE0            (0x3000UL)

/**
    @brief Call OTPM_ReadValidConfig() with probe lInvalAddr = 0UL

    @pre Load the OTP Alt memory with valid IP in ROW0

    @test Call OTPM_ResetHandler

    @post #BCM_ERR_OK should be returned and MCU_GetInfo() should return IP addr from row0

    @functional No

    @type Neg

    @trace #
*/
#define BRCM_SWPTST_OTPM_READ_VALIDCFG_PROBE_CASE1            (0x3001UL)

/**
    @brief Call OTPM_ReadValidConfig() with probe startAddr = OTPM_ADDR_END + 1UL

    @test Call OTPM_ResetHandler

    @post MCU_GetInfo() should return Invalid IP addr
 */
#define BRCM_SWPTST_OTPM_READ_VALIDCFG_PROBE_CASE2            (0x3002UL)

/**
    @brief Call OTPM_ReadRow with probe otpAddr = OTP_END_ADDR + 1UL
           Call RunStateHandler with requested state READY

    @pre Load the OTP Alt memory with valid data

    @test Call OTPM_ResetHandler

    @post #BCM_ERR_OK should be returned and MCU_GetInfo() should return Invalid MAC and IP addr

    @functional No

    @type Neg

    @trace #
*/
#define BRCM_SWPTST_OTPM_READ_ROW_PROBE_CASE0            (0x3003UL)

/**
    @brief Call OTPM_ReadRow with aData=NULL

    @pre Load the OTP Alt memory with valid data

    @test Call OTPM_ReadTC10Config

    @post #BCM_ERR_INVAL_PARAMS should be returned
 */
#define BRCM_SWPTST_OTPM_READ_ROW_PROBE_CASE1            (0x3004UL)
/**
    @brief Call OTPM_ReadRowsByte with probe NumBytes=6UL

    @pre Load the OTP Alt memory with valid data

    @test Call OTPM_ResetHandler

    @post MCU_GetInfo() should return with valid IP and  Invalid GW addr
 */
#define BRCM_SWPTST_OTPM_READ_ROW_PROBE_CASE2            (0x3005UL)

/**
    @brief Call OTPM_ReadRowsWord with probe NumRows=0UL

    @pre Load the OTP Alt memory with valid data

    @test Call OTPM_ResetHandler

    @post MCU_GetInfo() should return with Invalid IP and  Invalid GW addr and Invalid MAC addr
 */
#define BRCM_SWPTST_OTPM_READ_ROW_PROBE_CASE3            (0x3006UL)

/**
    @brief Call OTPM_ReadMacAddr with invalAddr = 0UL, startAddr = 0UL
    @test Call OTPM_ResetHandler

    @post MCU_GetInfo() should return with valid IP and  Invalid MacAddr
 */
#define BRCM_SWPTST_OTPM_READ_MACADDR_PROBE_CASE0        (0x3007UL)

/**
    @brief Call OTPM_ReadMacAddr with invalAddr = 0UL
    @test Call OTPM_ResetHandler

    @post MCU_GetInfo() should return with valid IP and  Invalid MacAddr
 */
#define BRCM_SWPTST_OTPM_READ_MACADDR_PROBE_CASE1        (0x3008UL)

/**
    @brief Call OTPM_GetEnabledBootModes for OTPM_SW_STRAP_WD_DISABLE Probe
 */
#define BRCM_SWQTST_OTPM_GET_EN_BOOT_MODE_PROBE_CASE0    (0x3009UL)
#define BRCM_SWQTST_OTPM_GET_EN_BOOT_MODE_PROBE_CASE1    (0x300AUL)
#define BRCM_SWQTST_OTPM_RESET_HANDLER_PROBE_CASE0       (0x300BUL)


/**
  @brief Qualification test sequence for OTP Module with OTPM_test_seq_data0

  @code{.c}
  @endcode

  @auto           Yes

  @type           Sanity

  @executetime    1s

  @analyzetime    1h


*/
#define BRCM_SWPTSEQ_OTPM_0                                     (0x3000UL)

/**
  @brief Qualification test sequence for OTP Module with OTPM_test_seq_data1

  @code{.c}

  @endcode

  @auto           Yes

  @type           Sanity

  @executetime    1s

  @analyzetime    1h


*/
#define BRCM_SWPTSEQ_OTPM_1                                     (0x3001UL)

/**
  @brief Qualification test sequence for OTP Module with OTPM_test_seq_data2

  @code{.c}

  @endcode

  @auto           Yes

  @type           Sanity

  @executetime    1s

  @analyzetime    1h


*/
#define BRCM_SWPTSEQ_OTPM_2                                     (0x3002UL)
#define BRCM_SWPTSEQ_OTPM_3                                     (0x3003UL)

#endif /* OTPM_PT_H */
/** @} */
