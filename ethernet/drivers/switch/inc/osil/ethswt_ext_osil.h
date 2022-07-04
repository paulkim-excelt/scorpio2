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
    @addtogroup grp_ethswt_il
    @{

    @file ethswt_ext_osil.h

    @brief Switch driver Extensions internal interface

    @version 0.1 Initial version

*/
#ifndef ETHSWT_EXT_OSIL_H
#define ETHSWT_EXT_OSIL_H

#include <stdint.h>
#include <ethswt_ext.h>

/**
    @name Switch driver Architecture IDs
    @{
    @brief Architecture IDs for Switch driver
*/
#define BRCM_SWARCH_ETHSWT_MISC_CMD_HANDLER_PROC    (0x9201U)    /**< @brief #ETHSWT_ExtCmdHandler */
#define BRCM_SWARCH_ETHSWT_MISC_IO_TYPE             (0x9202U)    /**< @brief #ETHSWT_ExtIOType     */
#define BRCM_SWARCH_ETHSWT_IPG_CONFIG_PROC          (0x9203U)    /**< @brief #ETHSWT_IPGConfig     */
/** @} */

/**
    @brief Ethernet switch IO structure

    @trace #BRCM_SWREQ_ETHSWT_EXT
 */
typedef struct sETHSWT_ExtIOType {
    const ETHSWT_CfgType        *cfg;               /**< @brief Pointer to
                                                         switch configurations
                                                         */
    uint32_t                    *port2TimeFifoMap;  /**< @brief Pointer to Switch port - time FIFO map */
    const ETHSWT_ShaperCfgType  *shaperCfg;         /**< @brief Pointer to shaper configuration */
    ETHSWT_PortIDType           portID;             /**< @brief Port number */
} ETHSWT_ExtIOType;

/** @brief Internal Mirror command handler

    This interface handles all the Mirror commands requested from system command
    handler.

    @behavior Sync, Re-entrant

    @param[in]      aCmd        Command requested by user
    @param[inout]   aIO         Pointer to in-Out structure containing request
                                parameters

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Command processed successfully
    @retval     #BCM_ERR_UNKNOWN        aIO is NULL
    @retval     #BCM_ERR_INVAL_PARAMS   Invalid command
    @return     Others                  Error value specific to the requested
                                        command

    @trace  #BRCM_SWREQ_ETHSWT_EXT
*/
int32_t ETHSWT_ExtCmdHandler(ETHSWT_HwIDType aSwtHwID,
                                ETHSWT_IOCmdType aCmd,
                                ETHSWT_ExtIOType *const aIO);

/** @brief IPG shrink control configuration

    Program the IPG value for robust transmission.

    @behavior Sync, Re-entrant

    @param[in]      aSwtID        Switch Index

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Command processed successfully
    @return     Others                  Error value specific to the requested
                                        command

    @trace  #BRCM_SWREQ_ETHSWT_EXT
*/
int32_t ETHSWT_IPGConfig(ETHSWT_HwIDType aSwtID);

#endif /* ETHSWT_EXT_OSIL_H */
/** @} */
