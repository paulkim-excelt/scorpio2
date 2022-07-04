/*****************************************************************************
 Copyright 2022 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_ethernet_swt_core_ifc Switch CORE abstract Interface
    @ingroup grp_ethernet_abstract

    @addtogroup grp_ethernet_swt_core_ifc
    @{

    @file ethernet_swt_core.h

    @brief CORE Interface
    This file contains the interfaces for the Ethernet abstract for CORE

    @version 1.0 Initial version
*/

#ifndef ETHERNET_SWT_CORE_H
#define ETHERNET_SWT_CORE_H

#include <ethernet_common.h>
#include <mcu.h>

/**
    @name Switch CORE API IDs
    @{
    @brief API IDs for CORE in Switch
*/
#define BRCM_SWARCH_ETHSWT_CORECMDID_TYPE              (0x8801U)    /**< @brief #ETHSWT_CoreCmdIdType         */
#define BRCM_SWARCH_ETHSWT_COREREGACCESS_TYPE          (0x8802U)    /**< @brief #ETHSWT_CoreRegAccessType     */
#define BRCM_SWARCH_ETHSWT_CORE_MAX_PAYLOAD_SIZE_MACRO (0x8803U)    /**< @brief #ETHSWT_CORE_MAX_PAYLOAD_SIZE */

/** @} */

/**
    @brief Maximum size of Core command payload in bytes

    @trace #BRCM_SWREQ_ETHSWT
*/
#define ETHSWT_CORE_MAX_PAYLOAD_SIZE     (140UL)

/**
    @name Switch Core command IDs
    @{
    @brief Switch Core command IDs group

    @trace #BRCM_SWREQ_ETHSWT
*/
typedef uint8_t ETHSWT_CoreCmdIdType;               /**< @brief Core command message Type                        */
#define ETHSWT_CORECMDID_WRITE            (0x50U)   /**< @brief #ETHSWT_CoreRegAccessType       #ETHSWT_WriteReg */
#define ETHSWT_CORECMDID_READ             (0x51U)   /**< @brief #ETHSWT_CoreRegAccessType       #ETHSWT_ReadReg  */
#define ETHSWT_CORECMDID_START            (ETHSWT_CORECMDID_WRITE)  /**< @brief Start range                      */
#define ETHSWT_CORECMDID_END              (ETHSWT_CORECMDID_READ)   /**< @brief End range                        */
/** @} */

/**
    @brief Structure to manage the switch register R/W access.

    @trace #BRCM_SWREQ_ETHSWT
*/
typedef struct sETHSWT_CoreRegAccessType{
    uint8_t        data[128UL]; /**< @brief Memory */
    uint32_t       addr;        /**< @brief Address */
    uint32_t       len;         /**< @brief Length of access */
    MCU_DeviceType deviceID;    /**< @brief Device ID */
} ETHSWT_CoreRegAccessType;
_Static_assert(sizeof(ETHSWT_CoreRegAccessType) <= ETHSWT_CORE_MAX_PAYLOAD_SIZE,
               "ETHSWT_CoreRegAccessType does not fit in IPC payload");

#endif /* ETHERNET_SWT_CORE_H */
/** @} */
