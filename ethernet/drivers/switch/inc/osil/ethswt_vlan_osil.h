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

    @file ethswt_vlan_osil.h

    @brief Switch driver VLAN internal interface

    @version 0.1 Initial version

*/
#ifndef ETHSWT_VLAN_OSIL_H
#define ETHSWT_VLAN_OSIL_H

#include <stdint.h>
#include <ethswt_vlan.h>

/**
    @name Switch driver Architecture IDs
    @{
    @brief Architecture IDs for Switch driver
*/
#define BRCM_SWARCH_ETHSWT_VLAN_IO_TYPE                      (0x9701U)    /**< @brief #ETHSWT_VLANIOType            */
#define BRCM_SWARCH_ETHSWT_VLAN_CMD_HANDLER_PROC             (0x9702U)    /**< @brief #ETHSWT_VLANCmdHandler        */
#define BRCM_SWARCH_ETHSWT_DRV_VLAN_TBL_RDWR_PROC            (0x9703U)    /**< @brief #ETHSWT_DrvVLANTblRdWr        */
#define BRCM_SWARCH_ETHSWT_VLAN_TBL_CMD_TYPE                 (0x9704U)    /**< @brief #ETHSWT_VLANTblCmdType        */
#define BRCM_SWARCH_ETHSWT_DRV_UPDATE_VLAN_TBL_ENTRY_PROC    (0x9705U)    /**< @brief #ETHSWT_DrvUpdateVLANTblEntry */
/** @} */

/**
    @brief Ethernet switch IO structure

    @trace #BRCM_SWREQ_ETHSWT_KERNEL_INTERFACE
 */
typedef struct sETHSWT_VLANIOType {
    ETHSWT_PortIDType           portHwID;           /**< @brief Port hardware
                                                         index */
    uint32_t                    mode;               /**< @brief Switch mode */
    ETHER_VLANIDType           vlanID;             /**< @brief VLAN ID */
    uint32_t                    enable;             /**< @brief Enable flag */
    uint32_t                    portMask;           /**< @brief Port mask */
    uint32_t                    tagMask;            /**< @brief Tag mask */
    uint32_t                    staticPortMask;     /**< @brief Static port mask */
    ETHER_PrioType              prio;               /**< @brief Packet priority */
    ETHSWT_SecurityActionType   securityAction;
                                                    /**< @brief Security action */
} ETHSWT_VLANIOType;

/**
    @name Switch VLAN table command
    @{
    @brief Switch VLAN table command

    @trace #BRCM_SWREQ_ETHSWT_KERNEL_INTERFACE
*/
typedef uint16_t ETHSWT_VLANTblCmdType;     /**< @brief VLAN table command */
#define ETHSWT_VLAN_TBL_CMD_READ  (0x0U)    /**< @brief Read command */
#define ETHSWT_VLAN_TBL_CMD_WRITE (0x1U)    /**< @brief Write command */
/** @} */

/**
    @brief VLAN table Read/Write

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aSwtID      Switch Index
    @param[in]      aVLAN       VLAN
    @param[in]      aUntagMap   Pointer to untag map
    @param[in]      aFwdMap     Forward map
    @param[in]      aCmd        Read/Write command

    Return values are documented in reverse-chronological order
    @retval         #BCM_ERR_OK             On Success
    @retval         #BCM_ERR_INVAL_PARAMS   (aUntagMap is NULL) or
                                            (aFwdMap is NULL) or
                                            (aCmd is invalid)
    @retval         #BCM_ERR_TIME_OUT       Read/Write operation times out

    @post None

    @trace #BRCM_SWREQ_ETHSWT_KERNEL_INTERFACE
 */
int32_t ETHSWT_DrvVLANTblRdWr(ETHSWT_HwIDType aSwtID, uint16_t aVLAN,
                              uint32_t *const aUntagMap, uint32_t *const aFwdMap,
                              ETHSWT_VLANTblCmdType aCmd);


/**
    @brief Update VLAN table entry

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aSwtID          Switch Index
    @param[in]      aPortID         Port ID
    @param[in]      aVlanID         VLAN ID
    @param[in]      aForward        forward
    @param[in]      aIsDynamic      0: Static, Others:Dynamic

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @retval     #BCM_ERR_INVAL_PARAMS   (aVlanID is invalid) or
                                      (aForward is invalid)
    @return     Others                 As returned by #ETHSWT_DrvVLANTblRdWr

    @post None

    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION
*/
int32_t ETHSWT_DrvUpdateVLANTblEntry(ETHSWT_HwIDType aSwtID,
                                      ETHSWT_PortIDType aPortID,
                                      ETHER_VLANIDType aVlanID,
                                      ETHSWT_VLANFwrdType aForward,
                                      uint32_t aIsDynamic);

/** @brief Internal VLAN command handler

    This interface handles all the VLAN commands requested from system command
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
    @return     Others                  Error value specific to the requested
                                        command

    @trace  #BRCM_SWREQ_ETHSWT_KERNEL_HANDLER
*/
int32_t ETHSWT_VLANCmdHandler(ETHSWT_HwIDType aSwtHwID,
                                ETHSWT_IOCmdType aCmd,
                                ETHSWT_VLANIOType *const aIO);

#endif /* ETHSWT_VLAN_OSIL_H */
/** @} */
