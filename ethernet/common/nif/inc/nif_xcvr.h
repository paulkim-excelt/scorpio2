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

    @file nif_xcvr.h
    @brief NIF Xcvr Interface File

    @version 0.1 Initial Version
*/

#ifndef NIF_XCVR_H
#define NIF_XCVR_H

#include <nif.h>
#include <ethxcvr.h>

/**
    @name NIF XCVR Architecture IDs
    @{
    @brief Architecture IDs for NIF XCVR
*/
#define BRCM_SWARCH_NIF_ETHXCVR_GETLINKSTATE_TYPE        (0x8603U)    /**< @brief #NIF_ETHXCVR_GetLinkStateType     */
#define BRCM_SWARCH_NIF_ETHXCVR_GETSQIVALUE_TYPE         (0x8604U)    /**< @brief #NIF_ETHXCVR_GetSQIValueType      */
#define BRCM_SWARCH_NIF_XCVRINTF_TYPE                    (0x8605U)    /**< @brief #NIF_XcvrIntfType                 */
#define BRCM_SWARCH_NIF_XCVRCTRLCFG_TYPE                 (0x8606U)    /**< @brief #NIF_XcvrCtrlCfgType              */
#define BRCM_SWARCH_NIF_XCVRCFG_TYPE                     (0x8607U)    /**< @brief #NIF_XcvrCfgType                  */
#define BRCM_SWARCH_NIF_GETLINKSTATE_PROC                (0x8608U)    /**< @brief #NIF_GetLinkState                 */
#define BRCM_SWARCH_NIF_XCVRGETSQIVALUE_PROC             (0x8609U)    /**< @brief #NIF_XcvrGetSQIValue              */
#define BRCM_SWARCH_NIF_XCVRCTRLCFG_GLOBAL               (0x860AU)    /**< @brief #NIF_XcvrCtrlCfg                  */
#define BRCM_SWARCH_NIF_XCVRCTRLCONFIG_GLOBAL            (0x860BU)    /**< @brief #NIF_XcvrCtrlConfig               */
/** @} */

/** @brief XCVR get link state

    This function is used by NIF to get the link state from ethernet XCVR.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aID         Index of the transceiver
    @param[out]     aLinkState  Pointer to link state

    @return     As returned by the hooked function

    @post None

    @trace #BRCM_SWREQ_NIF_XCVR

    @limitations None
*/
typedef int32_t (*NIF_ETHXCVR_GetLinkStateType)(ETHXCVR_IDType aID, ETHXCVR_LinkStateType *const aLinkState);

/** @brief XCVR get SQI value

    This function is used by NIF to get the SQI value from ethernet XCVR.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aID         Index of the transceiver
    @param[out]     aSQIValue   SQI value of the link

    @return     As returned by the hooked function

    @post None

    @trace #BRCM_SWREQ_NIF_XCVR

    @limitations None
*/
typedef int32_t (*NIF_ETHXCVR_GetSQIValueType)(ETHXCVR_IDType aID, uint32_t *const aSQIValue);

/**
    @brief NIF ethernet XCVR controller function table configuration

    This is the callback configuration table for the transciever controllers
    that are to be registered with NIF.

    @trace #BRCM_SWREQ_NIF_XCVR
 */
typedef struct sNIF_XcvrIntfType {
    NIF_ETHXCVR_GetLinkStateType getLinkState;  /**< @brief Get link state */
    NIF_ETHXCVR_GetSQIValueType getSQIValue;    /**< @brief Get SQI value */
} NIF_XcvrIntfType;

/**
    @brief NIF controller configuration table

    NIF controller configuration table.

    @trace #BRCM_SWREQ_NIF_XCVR
 */
typedef struct sNIF_XcvrCtrlCfgType {
    const NIF_XcvrIntfType *const xcvrIntfTbl;  /**< @brief XCVR interface table */
    const uint32_t xcvrIntfTblSize;             /**< @brief XCVR interface table size */
    const NIF_XcvrIntfType *const wlXcvrIntfTbl;/**< @brief WL XCVR interface table */
    const uint32_t wlXcvrIntfTblSize;           /**< @brief WL XCVR interface table size */
} NIF_XcvrCtrlCfgType;

/**
    @brief NIF XCVR Configuration

    @trace #BRCM_SWREQ_NIF_XCVR
*/
extern const NIF_XcvrCtrlCfgType *NIF_XcvrCtrlCfg;

/**
    @brief NIF configuration

    NIF configuration.

    @trace #BRCM_SWREQ_NIF_XCVR
 */
typedef struct sNIF_XcvrCfgType {
    const NIF_XcvrCtrlCfgType *const xcvrCtrlCfg;       /**< @brief Controller config */
} NIF_XcvrCfgType;

/**
    @brief NIF Xcvr configuration memory

    @trace #BRCM_SWREQ_NIF_XCVR
*/
extern const NIF_XcvrCtrlCfgType NIF_XcvrCtrlConfig;

/** @brief Get Ethernet transceiver/port link state

    This API retrieves the transceiver/port link state.

    @behavior Sync, Reentrant

    @param[in]       aID                     Index of the transceiver/port
    @param[out]      aLinkState              Pointer to retrieve link state

    @return          #BCM_ERR_OK              Successfully retrieved transceiver/
                                              port link state
    @retval          #BCM_ERR_INVAL_PARAMS    Invalid transceiver/port index
    @retval          #BCM_ERR_INVAL_PARAMS    aLinkState is NULL
    @retval          #BCM_ERR_UNINIT          NIF is not initialised
    @retval          #BCM_ERR_NOSUPPORT       Feature is not supported

    @post describe post condition (status after execution of the function)

    @trace #BRCM_SWREQ_NIF_XCVR
*/
extern int32_t NIF_GetLinkState(uint32_t aIdx, ETHXCVR_LinkStateType *const aLinkState);

/** @brief Get SQI Value

    This API returns the SQI value of the established link.

    @behavior Sync, Reentrant

    @pre describe any pre-condition (expectation before calling this function)

    @param[in]       aXcvrIdx                Index of the transceiver
    @param[out]      aSQIValue               SQI value of the link

    @retval          #BCM_ERR_OK              Successfully retrieved the
                                             SQI value of the link.
    @retval          #BCM_ERR_INVAL_PARAMS    Invalid transceiver index
    @retval          #BCM_ERR_INVAL_PARAMS    aSQIValue is NULL
    @retval          #BCM_ERR_UNINIT          Transceiver not initialized.
    @retval          #BCM_ERR_INVALID_STATE   Controller not initialized
    @retval          #BCM_ERR_UNINIT          NIF is not initialised
    @retval          #BCM_ERR_NOSUPPORT       Feature is not supported

    @post describe post condition (status after execution of the function)

    @trace #BRCM_SWREQ_NIF_XCVR
*/
extern int32_t NIF_XcvrGetSQIValue(uint32_t aXcvrIdx, uint32_t *const aSQIValue);

#endif /* NIF_XCVR_H */
/** @} */
