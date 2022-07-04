/*****************************************************************************
 Copyright 2018-2020 Broadcom Limited.  All rights reserved.

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
    @addtogroup grp_ethswt_il
    @{

    @file ethswt_cfp_osil.h

    @brief Switch CFP interface

    @version 0.1 Initial version

*/

#ifndef ETHSWT_CFP_OSIL_H
#define ETHSWT_CFP_OSIL_H

#include <stdint.h>
#include <eth_switch_osil.h>

/**
    @name CFP priveleged layer API IDs
    @{
    @brief API IDs for CFP priveleged layer
*/
#define BRCM_SWARCH_ETHSWT_CFP_CMDHANDLER_PROC    (0x9801U)    /**< @brief #ETHSWT_CFPCmdHandler */
#define BRCM_SWARCH_ETHSWT_CFP_IO_TYPE            (0x9802U)    /**< @brief #ETHSWT_CFPIOType     */
/** @} */

/**
    @brief Ethernet switch IO structure

    @trace #BRCM_SWREQ_ETHSWT_KERNEL_INTERFACE
 */
typedef struct sETHSWT_CFPIOType {
    ETHSWT_PortIDType           portHwID;           /**< @brief Port hardware
                                                         index */
    const ETHSWT_CFPConfigType  *cfpCfg;            /**< @brief Pointer to CFP
                                                         configuration */
    const ETHSWT_CFPKeyType     *keyCfg;            /**< @brief Pointer to CFP Key
                                                         configuration */
    const ETHSWT_CFPActionType  *actionCfg;         /**< @brief Pointer to CFP
                                                         Action configuration */
    ETHSWT_CFPSnapshotType      *snapShot;          /**< @brief Pointer to CFP
                                                         table snapshot */
    ETHSWT_CFPRuleType          *ruleCfg;           /**< @brief Pointer to CFP
                                                         Rule configuration */
    uint32_t                    *row;               /**< @brief Pointer to CFP
                                                         row number */
    uint32_t                    *slice;             /**< @brief Pointer to CFP
                                                         slice number */
    ETHSWT_CFPStatsType         *cfpStats;          /**< @brief Pointer to CFP
                                                         statistics */
} ETHSWT_CFPIOType;

/** @brief Internal command handler

    This interface handles all the commands requested from system command
    handler.

    @behavior Sync, Re-entrant

    @pre TBD

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

    @post TBD

    @trace #BRCM_SWREQ_ETHSWT_KERNEL_HANDLER

*/
int32_t ETHSWT_CFPCmdHandler(ETHSWT_HwIDType aSwtHwID,
                                ETHSWT_IOCmdType aCmd,
                                ETHSWT_CFPIOType *const aIO);

#endif /* ETHSWT_CFP_OSIL_H */
/** @} */
