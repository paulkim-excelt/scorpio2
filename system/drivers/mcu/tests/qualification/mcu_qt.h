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
    @defgroup grp_mcu_qt MCU qualification Test
    @ingroup grp_mcudrv

    @addtogroup grp_mcu_qt
    @{

    @file mcu_qt.h

    @board

    @brief MCU qualification Test
    This source file contains the qualification test for MCU
    @version 0.1 Initial draft
*/

#ifndef MCU_QT_H
#define MCU_QT_H

/**
    @brief Initialize MCU

    @pre MCU is in Init state

    @test Call MCU_Init

    @post MCU Should be in initialized state

    @functional Yes

    @type pos

    @trace #BRCM_SWREQ_MCU_INIT_BCM8958X
*/
#define BRCM_SWQTST_MCU_INIT                                          (0x0001UL)

/**
    @brief Get Version

    @pre MCU is in Init state

    @test Call MCU_GetVersion

    @post Version manuf, model should have non-zero value

    @functional Yes

    @type pos

    @trace #BRCM_SWREQ_MCU_QUERY_BCM8958X
*/
#define BRCM_SWQTST_MCU_GET_VERSION                                   (0x0002UL)

/**
    @brief Set MCU info

    @pre MCU is in Init state

    @test Call MCU_SetInfo with custom data

    @post Return should be BCM_ERR_OK

    @functional Yes

    @type pos

    @trace #BRCM_SWREQ_MCU_DYNAMIC_CONFIG
*/
#define BRCM_SWQTST_MCU_SET_INFO                                      (0x0003UL)

/**
    @brief Get MCU info

    @pre MCU is in Init state

    @test Call MCU_GetInfo and verify the custom data

    @post Return should be BCM_ERR_OK
          Custom data should match

    @functional Yes

    @type pos

    @trace #BRCM_SWREQ_MCU_QUERY_BCM8958X
*/
#define BRCM_SWQTST_MCU_GET_INFO                                      (0x0004UL)

/**
    @brief Enable Network Port

    @pre MCU is in Init state

    @test Call MCU_EnableSwitchCPUPort

    @post Return should be BCM_ERR_OK

    @functional Yes

    @type pos

    @trace #BRCM_SWREQ_MCU_EXTENSION_BCM8958X
*/
#define BRCM_SWQTST_MCU_ENABLE_NETWORK_PORT                           (0x0005UL)

/**
    @brief Disable Network Port

    @pre MCU is in Init state

    @test Call MCU_DisableSwitchCPUPort

    @post Return should be BCM_ERR_OK

    @functional Yes

    @type pos

    @trace #BRCM_SWREQ_MCU_EXTENSION_BCM8958X
*/
#define BRCM_SWQTST_MCU_DISABLE_NETWORK_PORT                          (0x0006UL)

/** @brief Qualification test sequence for MCU Init

    @code{.c}

    Call MCU_Init()
    Check Expected Result for #BRCM_SWQTST_MCU_INIT

    Call MCU_GetVersion().
    Check Expected Result for #BRCM_SWQTST_MCU_GET_VERSION

    @endcode

    @auto           Yes

    @type           Sanity

    @executetime    1s

    @analyzetime    1h
*/
#define BRCM_SWQTSEQ_MCU_INIT                                         (0x0001UL)

/** @brief Qualification test related to MCU informations

    @code{.c}

    Call MCU_SetInfo()
    Check Expected Result for #BRCM_SWQTST_MCU_SET_INFO
    Call MCU_GetInfo()
    Check Expected Result for #BRCM_SWQTST_MCU_GET_INFO

    @endcode

    @auto           Yes

    @type           Sanity

    @executetime    1s

    @analyzetime    1h
*/
#define BRCM_SWQTSEQ_MCU_SET_GET_INFO                                 (0x0002UL)

/** @brief Qualification test related to MCU informations

    @code{.c}

    Call MCU_EnableSwitchCPUPort()
    Check Expected Result for #BRCM_SWQTST_MCU_ENABLE_NETWORK_PORT
    Call MCU_DisableSwitchCPUPort()
    Check Expected Result for #BRCM_SWQTST_MCU_DISABLE_NETWORK_PORT

    @endcode

    @auto           Yes

    @type           Sanity

    @executetime    1s

    @analyzetime    1h
*/
#define BRCM_SWQTSEQ_MCU_SET_NETWORK                                  (0x0003UL)

/** @brief Dummy test sequence

    @code{.c}
    Dummy API.
    TODO: Update this after adding qt for all platforms.
    @endcode

    @auto           Yes

    @type           Sanity

    @executetime    1s

    @analyzetime    1h
*/
#define BRCM_SWQTSEQ_MCU_MISC                                         (0x0004UL)

#endif /* MCU_QT_H */
/** @} */