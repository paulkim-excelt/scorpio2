/*****************************************************************************
 Copyright 2020 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_ethswt_psfp_il PSFP Integration Layer
    @ingroup grp_ethswt

    @addtogroup grp_ethswt_psfp_il
    @{

    @file ethswt_psfp_osil.h

    @brief Switch PSFP integration interface

    @version 0.1 Initial version

*/

#ifndef ETHSWT_PSFP_OSIL_H
#define ETHSWT_PSFP_OSIL_H

#include <stdint.h>
#include <eth_switch_osil.h>
#include <ethswt_cfp.h>
#include <ethswt_psfp.h>

/**
    @name PSFP privileged layer API IDs
    @{
    @brief API IDs for PSFP privileged layer
*/
#define BRCM_SWARCH_ETHSWT_PSFP_CMDHANDLER_PROC    (0x9101U)    /**< @brief #ETHSWT_PSFPCmdHandler */
#define BRCM_SWARCH_ETHSWT_PSFP_IO_TYPE            (0x9102U)    /**< @brief #ETHSWT_PSFPIOType     */
#define BRCM_SWARCH_ETHSWT_PSFP_IRQHANDLER_PROC    (0x9103U)    /**< @brief #ETHSWT_PSFPIRQHandler */
/** @} */

/**
    @brief PSFP IO structure

    @trace #BRCM_SWREQ_ETHSWT_PSFP
 */
typedef struct sETHSWT_PSFPIOType {
    ETHSWT_PortIDType               portHwID;      /**< @brief Port hardware index */
    const ETHSWT_PSFPConfigType     *psfpCfg;      /**< @brief Pointer to PSFP configuration */
    const ETHSWT_CFPKeyType         *keyCfg;       /**< @brief Pointer to PSFP Key configuration */
    const ETHSWT_PSFPActionType     *actionCfg;    /**< @brief Pointer to PSFP action configuration */
    const ETHSWT_PSFPGateCfgType    *gateCfg;      /**< @brief Pointer to const gate configuration */
    const ETHSWT_PSFPMeterCfgType   *meterCfg;     /**< @brief Pointer to const meter configuration */
    ETHSWT_PSFPGateCfgType          *getGateCfg;   /**< @brief Pointer to gate configuration */
    ETHSWT_PSFPMeterCfgType         *getMeterCfg;  /**< @brief Pointer to meter configuration */
    ETHSWT_PSFPRowStatsType         *stats;        /**< @brief Pointer to PSFP stats */
    ETHSWT_PSFPSnapshotType         *snapShot;     /**< @brief Pointer to PSFP table snapshot */
    ETHSWT_PSFPRuleType             *ruleCfg;      /**< @brief Pointer to PSFP rule configuration */
    uint32_t                        *row;          /**< @brief Pointer to PSFP row number */
    uint32_t                        *slice;        /**< @brief Pointer to PSFP slice number */
    uint32_t                        *isEnable;     /**< @brief Pointer to PSFP is enable flag */
} ETHSWT_PSFPIOType;

/** @brief Internal command handler

    This interface handles all the PSFP commands requested from system command
    handler.

    @behavior Sync, Re-entrant

    @param[in]      aSwtHwID    Switch ID
    @param[in]      aCmd        Command requested by user
    @param[inout]   aIO         Pointer to in-Out structure containing request
                                parameters

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Command processed successfully
    @retval     #BCM_ERR_UNKNOWN        aIO is NULL
    @retval     #BCM_ERR_INVAL_PARAMS   Invalid command
    @return      Others                 Error value specific to the requested
                                        command

    @trace #BRCM_SWREQ_ETHSWT_PSFP

*/
int32_t ETHSWT_PSFPCmdHandler(ETHSWT_HwIDType aSwtHwID,
                              ETHSWT_IOCmdType aCmd,
                              ETHSWT_PSFPIOType *const aIO);

/** @brief PSFP Interrupt handler

    This API handles PSFP hardware interrupts.

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aSwtHwID    Switch ID

    @return     void

    @post None

    @note To be used.

    @trace  #BRCM_SWREQ_ETHSWT_PSFP

    @limitations None
*/
void ETHSWT_PSFPIRQHandler(uint32_t aSwtHwID);

#endif /* ETHSWT_PSFP_OSIL_H */
/** @} */
