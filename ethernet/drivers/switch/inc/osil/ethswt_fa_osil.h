/*****************************************************************************
 Copyright 2020-2021 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_fa_osil Flow Accelerator Intergration
    @ingroup grp_ethswt

    @addtogroup grp_fa_osil
    @{

    @file ethswt_fa_osil.h
    @brief Flow Accelerator integration
    This header file contains the integration APIs for Flow accelerator

    @version 0.1 Initial version
*/

#ifndef ETHSWT_FA_OSIL_H
#define ETHSWT_FA_OSIL_H

#include <eth_switch_osil.h>
#include <ethswt_fa.h>

/**
    @name Flow accelerator Driver interface IDs
    @{
    @brief API IDs for Flow accelerator Driver
*/
#define BRCM_SWARCH_ETHSWT_FACMDHANDLER_PROC       (0x9401U)    /**< @brief #ETHSWT_FACmdHandler    */
#define BRCM_SWARCH_ETHSWT_FAIRQHANDLER_PROC       (0x9402U)    /**< @brief #ETHSWT_FAIRQHandler    */
#define BRCM_SWARCH_ETHSWT_FAIO_TYPE               (0x9403U)    /**< @brief #ETHSWT_FAIOType        */
#define BRCM_SWARCH_ETHSWT_FACTFIRQHANDLER_PROC    (0x9404U)    /**< @brief #ETHSWT_FACtfIRQHandler */
/** @} */

/**
    @brief Ethernet switch: Flow Acclerator IO structure

    @trace #BRCM_SWREQ_ETHSWT_FA_INITIALISATION
 */
typedef struct sETHSWT_FAIOType {
    ETHSWT_FAIDType id;     /**< @brief Instance identifier */
    uint16_t flowID;        /**< @brief Flow ID */
    uint32_t external;      /**< @brief boolean to indicate external/internal MAC */
    ETHSWT_FAIntrFlagsType  intrFlags;  /**< @brief Interrupt Flags */
    const uint8_t *const mac;   /**< @brief Pointer to MAC address */
    const ETHSWT_FACfgType  *cfg;       /**< @brief Pointer to FA configuration */
    const ETHSWT_FAFlowType *flowIn;    /**< @brief Pointer to input flow parameters */
    ETHSWT_FAFlowType       *flowOut;   /**< @brief Pointer to ouput flow parameters */
    ETHSWT_FAFlowStatsType  *flowStats; /**< @brief Pointer to flow statistics */
    ETHSWT_FAStatsType      *faStats;   /**< @brief Pointer to FA statistics */
    ETHSWT_FAFlowStatusType *flowStatus;/**< @brief Pointer to flow status */
    ETHSWT_FAPoolTableInfoType *poolTableInfo; /**< @brief Pointer to Pool table infomration */
} ETHSWT_FAIOType;

/** @brief Flow accelerator command handler

    This interface handles all the commands requested from system command
    handler.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aSwtID      Switch Hardware Instance Identifier
    @param[in]      aCmd        Command requested by user
    @param[inout]   aIO         Pointer to in-Out structure containing request
                                parameters

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Command processed successfully
    @retval     #BCM_ERR_UNKNOWN        aIO is NULL
    @retval     #BCM_ERR_INVAL_PARAMS   Invalid command
    @return     Others                  Error value specific to the requested
                                        command

    @post None

    @note This interface shall be called from #ETHSWT_CmdHandler

    @trace  #BRCM_SWREQ_ETHSWT_FA_HANDLER
*/
extern int32_t ETHSWT_FACmdHandler(ETHSWT_HwIDType aSwtID,
                                   ETHSWT_IOCmdType aCmd,
                                   ETHSWT_FAIOType * const aIO);

/** @brief Flow accelerator IRQ handler

    This interface handles the interrupt from Fa's CTF block

    @behavior Sync, Re-entrant

    @pre None

    @param      void

    @return     void

    @post None

    @trace #BRCM_SWREQ_ETHSWT_FA_HANDLER
*/
extern void ETHSWT_FAIRQHandler(void);

/** @brief Flow accelerator Interrupt Handler

    Flow accelerator(CTF) interrupt

    @behavior Sync, Re-entrant

    @pre TBD

    @param[in]      None

    @retval         None

    @post TBD

    @trace #BRCM_SWREQ_ETHSWT_FA_HANDLER

    @limitations None
*/
extern void ETHSWT_FACtfIRQHandler(void);

#endif /* ETHSWT_FA_OSIL_H */

/** @} */
