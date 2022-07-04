/*****************************************************************************
 Copyright 2017-2021 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_ethswt_cfg_ifc Ethernet switch cfg Interface
    @ingroup grp_ethswt

    @addtogroup grp_ethswt_cfg_ifc
    @{

    @file switch_cfg.h

    @brief Ethernet switch cfg

    @version 0.1 Initial version

*/

#ifndef SWITCH_CFG_H
#define SWITCH_CFG_H

#include <string.h>
#include <bcm_utils.h>
#include <bcm_err.h>
#include <eth_switch.h>

/**
    @name Ethernet Switch cfg Architecture IDs
    @{
    @brief Architecture IDs for  Ethernet Switch cfg
*/
#define BRCM_SWARCH_ETHSWT_ETHSWT_HWMAC2NMAC_MACRO    (0x8501U)    /**< @brief #ETHSWT_HWMAC2NMAC  */
#define BRCM_SWARCH_ETHSWT_CFG_USR_DATA_GLOBAL        (0x8502U)    /**< @brief #ETHSWT_CfgUsrData  */
#define BRCM_SWARCH_ETHSWT_GET_PORT_CFG_PROC          (0x8503U)    /**< @brief #ETHSWT_GetPortCfg  */
#define BRCM_SWARCH_ETHSWT_GET_VLAN_PROC              (0x8504U)    /**< @brief #ETHSWT_GetVLAN     */
#define BRCM_SWARCH_ETHSWT_GET_VLAN_PORT_PROC         (0x8505U)    /**< @brief #ETHSWT_GetVLANPort */
#define BRCM_SWARCH_ETHSWT_JUMBO_FRM_GET_PROC         (0x8506U)    /**< @brief #ETHSWT_JumboFrmGet */
/** @} */

/**
    @brief HW MAC to N MAC

    @trace #BRCM_SWREQ_ETHSWT_QUERY
*/
#define ETHSWT_HWMAC2NMAC(hwMac, nMac)              \
    nMac[0U] = ((uint8_t)((hwMac) >> 40UL & 0xFFU));  \
    nMac[1U] = ((uint8_t)((hwMac) >> 32UL & 0xFFU));  \
    nMac[2U] = ((uint8_t)((hwMac) >> 24UL & 0xFFU));  \
    nMac[3U] = ((uint8_t)((hwMac) >> 16UL & 0xFFU));  \
    nMac[4U] = ((uint8_t)((hwMac) >> 8UL & 0xFFU));   \
    nMac[5U] = ((uint8_t)((hwMac) >> 0UL & 0xFFU));

/**
    @brief Switch configuration user data

    @trace #BRCM_SWREQ_ETHSWT_EXT
*/
extern ETHSWT_CfgType ETHSWT_CfgUsrData;

/** @brief Get the Port configuration

    This API copies the port configuration of the given portID to the location
    pointed by aPortCfg.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aPortID        Port ID
    @param[inout]   aPortCfg       Pointer to port configuration structure

    Return values are documented in reverse-chronological order
    @retval         #BCM_ERR_OK            Port configuration successfully
                                           found and copied to the location
                                           pointed by aPortCfg
    @retval         #BCM_ERR_INVAL_PARAMS  aPortCfg is NULL
    @retval         #BCM_ERR_NOT_FOUND     The given Port ID is not found in
                                           the switch configuration

    @post None

    @trace #BRCM_SWREQ_ETHSWT_EXT
 */
extern int32_t ETHSWT_GetPortCfg(uint32_t aPortID,
                                    ETHSWT_PortCfgType * const aPortCfg);

/** @brief Get VLAN information

    This API queries for VLAN information

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  aVLANID        VLAN ID
    @param[out] aPortBitMap    Bit mask of ports where given VLAN is enabled
    @param[out] aTagBitMap     Bit mask of ports where VLAN forward type is
                               set as tagged

    Return values are documented in reverse-chronological order
    @retval    #BCM_ERR_OK                 Successfully retrieved VLAN info
    @retval    #BCM_ERR_INVAL_PARAMS       (aPortBitMap in NULL) or
                                           (aTagBitMap is NULL)

    @post None

    @trace #BRCM_SWREQ_ETHSWT_EXT
 */
extern int32_t ETHSWT_GetVLAN(ETHER_VLANIDType aVLANID,
                                 uint32_t * const aPortBitMap,
                                 uint32_t * const aTagBitMap);

/** @brief Get Port specific VLAN info

    This API retrieves port specific VLAN info.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  aPortID         Port ID
    @param[out] aIngressFilter  Ingress Filter value
    @param[out] aDefaultVLAN    Default VLAN ID
    @param[out] aDefaultPrio    Default priority

    Return values are documented in reverse-chronological order
    @retval    #BCM_ERR_OK              VLAN info successfully retrieved
    @retval    #BCM_ERR_INVAL_PARAMS    (aIngressFilter in NULL) or
                                        (aDefaultVLAN in NULL) or
                                        (aDefaultPrio is NULL)
    @retval    #BCM_ERR_NOT_FOUND       Port ID not found

    @post None

    @trace #BRCM_SWREQ_ETHSWT_EXT
 */
extern int32_t ETHSWT_GetVLANPort(uint32_t aPortID,
                                     uint32_t * const aIngressFilter,
                                     ETHER_VLANIDType * const aDefaultVLAN,
                                     ETHSWT_PCPType * const aDefaultPrio);

/** @brief Get Jumbo frame

    This API retrieves Jumbo frame.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aPortID         Port ID
    @param[inout]   aJumboFrm       Jumbo frame

    Return values are documented in reverse-chronological order
    @retval    #BCM_ERR_OK              On success
    @retval    #BCM_ERR_INVAL_PARAMS    (aPortID is invalid) or
                                        (aJumboFrm in NULL) or
                                        (aDefaultPrio is NULL)
    @retval    #BCM_ERR_NOT_FOUND       Port ID not found

    @post None

    @trace #BRCM_SWREQ_ETHSWT_EXT
 */
extern int32_t ETHSWT_JumboFrmGet(uint32_t aPortID, uint32_t *const aJumboFrm);

#endif /* SWITCH_CFG_H */
/** @} */
