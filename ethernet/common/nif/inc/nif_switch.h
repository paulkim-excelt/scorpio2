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
    @addtogroup grp_nif_ifc
    @{

    @file nif_switch.h
    @brief NIF Switch Interface File

    @version 0.1 Initial Version
*/

#ifndef NIF_SWITCH_H
#define NIF_SWITCH_H

#include <stddef.h>
#include <inttypes.h>
#include <bcm_err.h>
#include <eth_switch.h>
#include <nif.h>
/**
    @name NIF Switch Architecture IDs
    @{
    @brief Architecture IDs for NIF Switch
*/
#define BRCM_SWARCH_NIF_RXMGMTINFOCLIENTCB_TYPE            (0x8701U)    /**< @brief #NIF_RxMgmtInfoClientCbType         */
#define BRCM_SWARCH_NIF_SWITCH_CBTBL_TYPE                  (0x8702U)    /**< @brief #NIF_SwitchCbTblType                */
#define BRCM_SWARCH_NIF_ETHERSWT_ENABLETXTIMESTAMP_TYPE    (0x8703U)    /**< @brief #NIF_ETHERSWT_EnableTxTimestampType */
#define BRCM_SWARCH_NIF_SWTINTF_TYPE                       (0x8704U)    /**< @brief #NIF_SwtIntfType                    */
#define BRCM_SWARCH_NIF_SWITCHCTRLCFG_TYPE                 (0x8705U)    /**< @brief #NIF_SwitchCtrlCfgType              */
#define BRCM_SWARCH_NIF_SWITCHCFG_TYPE                     (0x8706U)    /**< @brief #NIF_SwitchCfgType                  */
#define BRCM_SWARCH_NIF_SWTMGMTINIT_PROC                   (0x8707U)    /**< @brief #NIF_SwtMgmtInit                    */
#define BRCM_SWARCH_NIF_SWTSETMGMTINFO_PROC                (0x8708U)    /**< @brief #NIF_SwtSetMgmtInfo                 */
#define BRCM_SWARCH_NIF_SWITCHCTRLCFG_GLOBAL               (0x8709U)    /**< @brief #NIF_SwitchCtrlCfg                  */
#define BRCM_SWARCH_NIF_SWITCHTXBUFINFO_TYPE               (0x870AU)    /**< @brief #NIF_SwitchTxBufInfoType            */
/** @} */

/**
    @brief Struct type to store Tx Buffer information

    Struct type to store Tx Buffer information

    @trace #BRCM_SWREQ_NIF_SWITCH_MANAGEMENT_INFO
 */
typedef struct sNIF_SwitchTxBufInfoType {
    ETHSWT_MgmtInfoType mgmtInfo;       /**< @brief Management information */
} NIF_SwitchTxBufInfoType;

/** @brief RX Management information callback

    Each client shall register this management information callback.
    This callback function shall be invoked with management
    information of each RX packet with management information.

    @behavior Sync, Non-reentrant

    @pre describe any pre-condition (expectation before calling this function)

    @param[in]   aCtrlIdx    Controller index in the context of NIF
    @param[in]   aBuf        Pointer to the packet buffer
    @param[in]   aMgmtInfo   Pointer to Management Info

    @return void

    @post describe post condition (status after execution of the function)

    @trace #BRCM_SWREQ_NIF_SWITCH_MANAGEMENT_INFO
*/
typedef void (*NIF_RxMgmtInfoClientCbType)(NIF_CntrlIDType aCtrlIdx,
                                           const uint8_t *const aBuf,
                                           const ETHSWT_MgmtInfoType *const aMgmtInfo);

/**
    @brief NIF client callback table configuration

    This is the callback configuration table for all the NIF client
    that are to be registered with NIF.

    @trace #BRCM_SWREQ_NIF_SWITCH_MANAGEMENT_INFO
 */
typedef struct sNIF_SwitchCbTblType {
    NIF_RxMgmtInfoClientCbType   rxMgmtInfoCb;       /**< @brief Rx management information callback function */
} NIF_SwitchCbTblType;

/** @brief Enable Tx Timestamp for switch driver

    This function is used by NIF to enable the Tx timestamp for the
    switch driver.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aSwtID      Switch index
    @param[in]      aBufIdx     Ethernet buffer index
    @param[inout]   aMgmtInfo   Pointer to management information
                                - In: Pointer to the position of the EthType in
                                  common Ethernet frame
                                - Out: Pointer to the position of the EthType in
                                  management frame

    @return     As returned by the hooked function

    @post None

    @trace #BRCM_SWREQ_NIF_SWITCH_MANAGEMENT_INFO

    @limitations None
*/
typedef int32_t (*NIF_ETHERSWT_EnableTxTimestampType)(ETHER_HwIDType aSwtID,
                                                      uint32_t aBufIdx,
                                                      ETHSWT_MgmtInfoType * const aMgmtInfo);

/**
    @brief NIF switch driver function table configuration

    This is the callback configuration table for the switch driver
    functions that are to be registered with NIF.

    @trace #BRCM_SWREQ_NIF_SWITCH_MANAGEMENT_INFO
 */
typedef struct sNIF_SwtIntfType {
    NIF_ETHERSWT_EnableTxTimestampType enableTxTs; /**< @brief Enable Tx timestamp */
} NIF_SwtIntfType;

/**
    @brief NIF controller configuration table

    NIF controller configuration table.

    @trace #BRCM_SWREQ_NIF_SWITCH_MANAGEMENT_INFO
 */
typedef struct sNIF_SwitchCtrlCfgType {
    const NIF_SwitchCbTblType *const switchCbTbl;   /**< @brief Client callback table */
    const uint32_t switchCbTblSize;                 /**< @brief Client callback table size */
    const NIF_SwtIntfType *const swtIntfTbl;        /**< @brief Switch interface table */
    const uint32_t swtIntfTblSize;                  /**< @brief Switch interface table size */
} NIF_SwitchCtrlCfgType;

/**
    @brief NIF Switch Control Configuration

    @trace #BRCM_SWREQ_NIF_SWITCH_MANAGEMENT_INFO
*/
extern const NIF_SwitchCtrlCfgType *NIF_SwitchCtrlCfg;

/**
    @brief NIF configuration

    NIF configuration.

    @trace #BRCM_SWREQ_NIF_SWITCH_MANAGEMENT_INFO
 */
typedef struct sNIF_SwitchCfgType {
    const NIF_SwitchCtrlCfgType *const switchCtrlCfg;       /**< @brief Controller config */
} NIF_SwitchCfgType;

/** @brief Initialize switch management

    This API initializes the switch management functionality. Switch management
    functionality control the ethernet frame regarding port ingress/egress
    funtionality and timestamp feature of the port

    @behavior Sync, Non-reentrant

    @pre describe any pre-condition (expectation before calling this function)

    @param[in]       aSwtIdx                 Switch index

    @retval          #BCM_ERR_OK              Successful
    @return          #BCM_ERR_INVAL_PARAMS    Invalid switch index
    @return          #BCM_ERR_UNINIT          NIF is not initialized

    @post describe post condition (status after execution of the function)

    @trace #BRCM_SWREQ_NIF_SWITCH_MANAGEMENT_INFO
*/
int32_t NIF_SwtMgmtInit(ETHSWT_HwIDType aSwtIdx);

/** @brief Set the management information

    This API inserts the management information into the indexed
    ethernet buffer which was previously adapted for the transmission
    by calling ETHERSWT_TxAdaptBuffer() to achieve the tramission
    on specific ports of the switch

    @behavior Sync, Non-reentrant

    @pre describe any pre-condition (expectation before calling this function)

    @param[in]       aCtrlIdx            NIF controller index
    @param[in]       aBufIdx             Adapted Ethernet buffer index
    @param[in]       aMgmtinfo           Pointer to the management information

    @retval          #BCM_ERR_OK              Successful
    @return          #BCM_ERR_INVAL_PARAMS    Invalid buffer index (this buffer
                                             was not adapted)
    @return          #BCM_ERR_INVAL_PARAMS    aMgmtInfo is NULL
    @return          #BCM_ERR_UNINIT          Switch management functionality is

    @post describe post condition (status after execution of the function)

    @trace #BRCM_SWREQ_NIF_SWITCH_MANAGEMENT_INFO
*/
int32_t NIF_SwtSetMgmtInfo(NIF_CntrlIDType aCtrlIdx,
                           uint32_t aBufIdx,
                           const ETHSWT_MgmtInfoType *const aMgmtInfo);

#endif /* NIF_SWITCH_H */
/** @} */
