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

    @file ethswt_xcvr_osil.h

    @brief Switch driver Mirror internal interface

    @version 0.1 Initial version

*/
#ifndef ETHSWT_XCVR_OSIL_H
#define ETHSWT_XCVR_OSIL_H

#include <stdint.h>
#include <ethswt_xcvr.h>

/**
    @name Switch driver Architecture IDs
    @{
    @brief Architecture IDs for Switch driver
*/
#define BRCM_SWARCH_ETHSWT_XCVR_CMD_HANDLER_PROC              (0x9901U)    /**< @brief #ETHSWT_XcvrCmdHandler         */
#define BRCM_SWARCH_ETHSWT_XCVR_IO_TYPE                       (0x9902U)    /**< @brief #ETHSWT_XcvrIOType             */
#define BRCM_SWARCH_ETHSWT_LINK_IRQ_HANDLER_PROC              (0x9903U)    /**< @brief #ETHSWT_LinkIRQHandler         */
#define BRCM_SWARCH_ETHSWT_LINK_STAT_CHG_IND_HANDLER_PROC     (0x9904U)    /**< @brief #ETHSWT_LinkStatChgIndHandler  */
#define BRCM_SWARCH_ETHSWT_LINK_STATE_CHANGE_IND_PROC         (0x9905U)    /**< @brief #ETHSWT_LinkStateChangeInd     */
#define BRCM_SWARCH_ETHSWT_INTG_LINK_STATE_CHANGE_IND_PROC    (0x9906U)    /**< @brief #ETHSWT_IntgLinkStateChangeInd */
#define BRCM_SWARCH_ETHSWT_PORT0_LINK_IRQ_HANDLER_PROC        (0x9907U)    /**< @brief #ETHSWT_Port0LinkIRQHandler    */
#define BRCM_SWARCH_ETHSWT_PORT1_LINK_IRQ_HANDLER_PROC        (0x9908U)    /**< @brief #ETHSWT_Port1LinkIRQHandler    */
#define BRCM_SWARCH_ETHSWT_PORT2_LINK_IRQ_HANDLER_PROC        (0x9909U)    /**< @brief #ETHSWT_Port2LinkIRQHandler    */
#define BRCM_SWARCH_ETHSWT_PORT3_LINK_IRQ_HANDLER_PROC        (0x990AU)    /**< @brief #ETHSWT_Port3LinkIRQHandler    */
#define BRCM_SWARCH_ETHSWT_PORT4_LINK_IRQ_HANDLER_PROC        (0x990BU)    /**< @brief #ETHSWT_Port4LinkIRQHandler    */
#define BRCM_SWARCH_ETHSWT_PORT5_LINK_IRQ_HANDLER_PROC        (0x990CU)    /**< @brief #ETHSWT_Port5LinkIRQHandler    */
#define BRCM_SWARCH_ETHSWT_PORT6_LINK_IRQ_HANDLER_PROC        (0x990DU)    /**< @brief #ETHSWT_Port6LinkIRQHandler    */
#define BRCM_SWARCH_ETHSWT_PORT8_LINK_IRQ_HANDLER_PROC        (0x990EU)    /**< @brief #ETHSWT_Port8LinkIRQHandler    */
#define BRCM_SWARCH_ETHSWT_DRV_SET_PORT_JUMBO_MODE_PROC       (0x990FU)    /**< @brief #ETHSWT_DrvSetPortJumboMode    */
#define BRCM_SWARCH_ETHSWT_DRV_SET_XCVR_ID_PROC               (0x9910U)    /**< @brief #ETHSWT_DrvSetXcvrID           */
/** @} */

/**
    @brief Ethernet switch IO structure

    @trace #BRCM_SWREQ_ETHSWT_XCVR
 */
typedef struct sETHSWT_XcvrIOType {
    ETHSWT_PortIDType           portHwID;           /**< @brief Port hardware
                                                         index */
    ETHSWT_PortStatsType        *portStats;         /**< @brief Port Statistics */
    uint8_t                     linkState;          /**< @brief Link state */
    uint8_t                     jumbo;              /**< @brief Jumbo enable */
    ETHXCVR_LinkStateType       *linkStatePtr;      /**< @brief Pointer to Link State*/
    uint32_t                    *isLinkStateChangedPtr;  /**< @brief Pointer to Link state changed */
} ETHSWT_XcvrIOType;

/** @brief Internal Xcvr command handler

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

    @trace  #BRCM_SWREQ_ETHSWT_XCVR
*/
int32_t ETHSWT_XcvrCmdHandler(ETHSWT_HwIDType aSwtHwID,
                                ETHSWT_IOCmdType aCmd,
                                ETHSWT_XcvrIOType *const aIO);

/**
    @trace #BRCM_SWREQ_ETHSWT_XCVR
*/
int32_t ETHSWT_DrvSetPortJumboMode(ETHSWT_HwIDType aSwtID,
                                    ETHSWT_PortIDType aPortID,
                                    ETHXCVR_BooleanType aMode);

/**
    @brief Switch Set tranciever ID

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aSwtID      Switch Index
    @param[in]      aPortID     Port ID
    @param[in]      aXcvrID     Tranceiver ID

    Return values are documented in reverse-chronological order
    @retval         #BCM_ERR_OK         On Success
    @retval         #BCM_ERR_NOMEM      if Portmap is full

    @post None

    @trace #BRCM_SWREQ_ETHSWT_XCVR
*/
int32_t ETHSWT_DrvSetXcvrID(ETHSWT_HwIDType aSwtID,
                            ETHSWT_PortIDType aPortID,
                            uint32_t aXcvrID);

/** @brief Port link IRQ handler

    Port link IRQ handler to handle link state change.

    @behavior Sync, Re-entrant

    @pre TBD

    @param[in]      aSwtID      Switch index
    @param[in]      aPortID     Port index

    @return     void

    @post TBD

    @note This interface shall be called from the corressponding port's
    interrupt handler. Integrator shall install the port link interrupt handler
    for each switch port in the vector table. Refer to @ref sec_ref_trm for
    interrupt number mapping.

    @trace #BRCM_SWREQ_ETHSWT_XCVR

    @limitations None

    @snippet switch_osil.c Usage of ETHSWT_LinkIRQHandler
*/
extern void ETHSWT_LinkIRQHandler(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID);

/** @brief Port link state change indication handler

    Port link state change indication handler.

    @behavior Sync, Re-entrant

    @pre TBD

    @param[in]      aSwtID      Switch index
    @param[in]      aPortID     Port index

    @return     void

    @post TBD

    @note This interface shall be called from the ethsrv task whenever there it
    is notified of a link status change.

    @trace  #BRCM_SWREQ_ETHSWT_XCVR

    @limitations None

    @snippet ethsrv_osil.c Usage of ETHSWT_LinkStatChgIndHandler
*/
extern void ETHSWT_LinkStatChgIndHandler(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID);

/** @brief Port link state change indication callback for integration layer .

    Integration layer Port link state change indication callback.

    @behavior Sync, Re-entrant

    @pre TBD

    @param[in]      aSwtID      Switch index
    @param[in]      aPortID     Port index
    @param[in]      aLinkState  Link current state

    @return     void

    @post TBD

    @note TBD
    @todo Explain how to use this interface (or where to be called from)

    @trace  #BRCM_SWREQ_ETHSWT_XCVR

    @limitations None
*/
extern void ETHSWT_IntgLinkStateChangeInd(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID,
        ETHXCVR_LinkStateType aLinkState);

/** @brief Port link state change indication callback.

    Port link state change indication callback.

    @behavior Sync, Re-entrant

    @pre TBD

    @param[in]      aSwtID      Switch index
    @param[in]      aPortID     Port index
    @param[in]      aLinkState  Link current state

    @return     void

    @post TBD

    @note TBD

    @todo Explain how to use this interface (or where to be called from)

    @trace  #BRCM_SWREQ_ETHSWT_XCVR

    @limitations None
*/
extern void ETHSWT_LinkStateChangeInd(ETHSWT_HwIDType aSwtID,
        ETHSWT_PortIDType aPortID,
        ETHXCVR_LinkStateType aLinkState);

/** @brief Switch Port 0 IRQ handler

    @trace #BRCM_SWREQ_ETHSWT_XCVR
*/
extern void ETHSWT_Port0LinkIRQHandler(void);

/** @brief Switch Port 1 IRQ handler

    @trace #BRCM_SWREQ_ETHSWT_XCVR
*/
extern void ETHSWT_Port1LinkIRQHandler(void);

/** @brief Switch Port 2 IRQ handler

    @trace #BRCM_SWREQ_ETHSWT_XCVR
*/
extern void ETHSWT_Port2LinkIRQHandler(void);

/** @brief Switch Port 3 IRQ handler

    @trace #BRCM_SWREQ_ETHSWT_XCVR
*/
extern void ETHSWT_Port3LinkIRQHandler(void);

/** @brief Switch Port 4 IRQ handler

    @trace #BRCM_SWREQ_ETHSWT_XCVR
*/
extern void ETHSWT_Port4LinkIRQHandler(void);

/** @brief Switch Port 5 IRQ handler

    @trace #BRCM_SWREQ_ETHSWT_XCVR
*/
extern void ETHSWT_Port5LinkIRQHandler(void);

/** @brief Switch Port 6 IRQ handler

    @trace #BRCM_SWREQ_ETHSWT_XCVR
*/
extern void ETHSWT_Port6LinkIRQHandler(void);

/** @brief Switch Port 8 IRQ handler

    @trace #BRCM_SWREQ_ETHSWT_XCVR
*/
extern void ETHSWT_Port8LinkIRQHandler(void);

#endif /* ETHSWT_XCVR_OSIL_H */
/** @} */
