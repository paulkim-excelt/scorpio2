/*****************************************************************************
 Copyright 2018-2019 Broadcom Limited.  All rights reserved.

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
    @addtogroup grp_mcudrv_ifc
    @{

    @file mcu_hs_ext.h
    @brief MCU Handshake Extension Interface
    This header file contains MCU Handshake Extension Interface

    @version 0.86 Imported from docx
*/

#ifndef MCU_HS_EXT_H
#define MCU_HS_EXT_H

#include <stdint.h>

/**
    @name MCU Handshake API IDs
    @{
    @brief MCU Handshake API IDs
*/
#define BRCM_SWARCH_MCU_CPUDHSID_TYPE         (0x8301U)    /**< @brief #MCU_CpuDHSIDType  */
#define BRCM_SWARCH_MCU_CPUDHSCH_TYPE         (0x8302U)    /**< @brief #MCU_CpuDHSChType  */
#define BRCM_SWARCH_MCU_SETDISPHSSRC_PROC     (0x8303U)    /**< @brief #MCU_SetDispHsSrc  */
#define BRCM_SWARCH_MCU_DISPHSTRIGGER_PROC    (0x8304U)    /**< @brief #MCU_DispHsTrigger */
/** @} */

/**
    @name MCU CPU display handshake ID type
    @{
    @brief Display hand-shake ID type

    @trace  #BRCM_SWREQ_MCU_KERNEL_INTERFACE
*/
typedef uint32_t MCU_CpuDHSIDType;
#define MCU_CPUDHSID_CPU        (0UL)   /**< @brief CPU DHS src ID */
#define MCU_CPUDHSID_DISPLAY    (1UL)   /**< @brief DISPLAY DHS src ID */
#define MCU_CPUDHSID_ISP        (2UL)   /**< @brief ISP DHS src ID */
/** @} */

/**
    @name MCU CPU display handshake channel type
    @{
    @brief Display handshake channel type

    @trace  #BRCM_SWREQ_MCU_KERNEL_INTERFACE
*/
typedef uint32_t MCU_CpuDHSChType;      /**< @brief DHS channels */
#define MCU_CPUDHSCH_0          (0UL)   /**< @brief DHS Channel 0 */
#define MCU_CPUDHSCH_1          (1UL)   /**< @brief DHS Channel 1 */
/** @} */

/** @brief Set the Handshake source for the input channel

    This API sets the Handshake source for the input channel

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]   aChannel            DHS channel ID
    @param[in]   aSrcId              Handshake source ID

    @return void

    @post None

    @trace  #BRCM_SWREQ_MCU_HANDSHAKE_EXTENSION
*/
extern void MCU_SetDispHsSrc(MCU_CpuDHSChType aChannel, MCU_CpuDHSIDType aSrcId);

/** @brief Trigger the Handshake for the input channel

    This API begins the Handshake for the input channel.

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]   aChannel            DHS channel ID
    @param[in]   aBufAttr            DHS buffer attribute

    @return      void

    @post None

    @trace  #BRCM_SWREQ_MCU_HANDSHAKE_EXTENSION
*/
extern void MCU_DispHsTrigger(MCU_CpuDHSChType aChannel, uint32_t aBufAttr);

#endif /* MCU_HS_EXT_H */

/** @} */
