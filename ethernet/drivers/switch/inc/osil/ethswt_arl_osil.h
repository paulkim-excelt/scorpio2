/*****************************************************************************
 Copyright 2019-2021 Broadcom Limited.  All rights reserved.

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

    @file ethswt_arl_osil.h

    @brief Switch driver ARL internal interface

    @version 0.1 Initial version

*/
#ifndef ETHSWT_ARL_OSIL_H
#define ETHSWT_ARL_OSIL_H

#include <stdint.h>
#include <ethswt_arl.h>
#include <ethswt_common_osil.h>

/**
    @name Switch driver Architecture IDs
    @{
    @brief Architecture IDs for Switch driver
*/
#define BRCM_SWARCH_ETHSWT_DRV_ARL_TBL_SEARCH_BY_ADDR_PROC    (0x9301U)    /**< @brief #ETHSWT_DrvARLTblSearchByAddr */
#define BRCM_SWARCH_ETHSWT_DRV_ARL_TBL_ADD_ENTRY_PROC         (0x9302U)    /**< @brief #ETHSWT_DrvARLTblAddEntry     */
#define BRCM_SWARCH_ETHSWT_ARL_CMD_HANDLER_PROC               (0x9303U)    /**< @brief #ETHSWT_ARLCmdHandler         */

#define BRCM_SWARCH_ETHSWT_ARL_TBL_HW_ENTRY_TYPE              (0x9304U)    /**< @brief #ETHSWT_ARLTBLHWEntryType     */
#define BRCM_SWARCH_ETHSWT_ARL_IO_TYPE                        (0x9305U)    /**< @brief #ETHSWT_ARLIOType             */
/** @} */

/**
    @brief Ethernet switch IO structure

    @trace #BRCM_SWREQ_ETHSWT_KERNEL_INTERFACE
 */
typedef struct sETHSWT_ARLIOType {
    ETHSWT_PortIDType           portHwID;            /**< @brief Port hardware
                                                          index */
    ETHER_VLANIDType           vlanID;              /**< @brief VLAN ID */
    ETHSWT_ARLEntryType         *ARLTbl;             /**< @brief Pointer to ARL
                                                          table */
    uint16_t                    *ARLTblSz;           /**< @brief Pointer to ARL
                                                          table size */
    uint8_t const               *macAddr;            /**< @brief Pointer to MAC
                                                          address */
    ETHSWT_MacLearningModeType  *learningMode;       /**< @brief Pointer to MAC
                                                          learning mode */
    ETHSWT_ARLEntryType         *arlEntry;           /**< @brief Pointer to
                                                          ARL entry */
    uint32_t                    age;                 /**< @brief FDB age */

    ETHSWT_SecurityActionType   securityAction;
                                                     /**< @brief Security action */
    ETHSWT_AddressLimitingType  *addrLimitPtr;       /**< @brief Pointer to address limiting
                                                           configuration */
    uint16_t                    totalMACLearningLimit;
                                                     /**< @brief maximum number of MAC
                                                           addresses allowed to
                                                           learn on all ports */
    uint16_t                    macLearnedCounter;
                                                     /**< @brief Total SA MAC addresses
                                                          learned on all ports or on
                                                          indivisual port */
    uint32_t                    overLimitCounter;
                                                     /**< @brief The number of
                                                          packets ingress to the port after
                                                          port SA learn counter exceeds to
                                                          SA learn limit */
    uint16_t                    portMask;            /**< @brief portMask */
} ETHSWT_ARLIOType;

/**
    @brief ARL table hardware entry type

    @trace #BRCM_SWREQ_ETHSWT_KERNEL_INTERFACE
*/
typedef struct sETHSWT_ARLTBLHWEntryType{
    uint64_t mac;
    uint16_t vlanID;
    uint16_t portMask;
    uint8_t  priority;
} ETHSWT_ARLTBLHWEntryType;

/** @brief Internal ARL command handler

    This interface handles all the ARL commands requested from system command
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
int32_t ETHSWT_ARLCmdHandler(ETHSWT_HwIDType aSwtHwID,
                                ETHSWT_IOCmdType aCmd,
                                ETHSWT_ARLIOType *const aIO);


/**
    @brief ARL table search by address

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aSwtID      Switch Index
    @param[in]      aMACAddr    MAC address
    @param[in]      aVlanID     VLAN ID
    @param[inout]   aPortMask   Pointer to port Mask
    @param[inout]   aBinIdx     Bin Index

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK         On Success
    @retval     #BCM_ERR_TIME_OUT   Clearing STRDN times out
    @retval     #BCM_ERR_NOT_FOUND  aBinIdx is invalid

    @post None

    @trace #BRCM_SWREQ_ETHSWT_KERNEL_INTERFACE
 */
int32_t ETHSWT_DrvARLTblSearchByAddr(ETHSWT_HwIDType aSwtID,
        uint64_t aMACAddr,
        uint32_t aVlanID,
        uint32_t *const aPortMask,
        uint32_t *const aBinIdx);

/**
    @brief ARL table add entry

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aSwtID      Switch Index
    @param[in]      aEntry      Pointer to entry

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK         On Success
    @retval     #BCM_ERR_TIME_OUT   If clearing STRDN times out
    @return     Others             As returned by #ETHSWT_DrvARLTblSearchByAddr

    @post None

    @trace #BRCM_SWREQ_ETHSWT_KERNEL_INTERFACE
 */
int32_t ETHSWT_DrvARLTblAddEntry(ETHSWT_HwIDType aSwtID,
        ETHSWT_ARLTBLHWEntryType *const aEntry);

#endif /* ETHSWT_ARL_OSIL_H */
/** @} */
