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

    @file nif_timestamp.h
    @brief NIF Time Stamp Interface File

    @version 0.1 Initial Version
*/

#include <nif.h>

#ifndef NIF_TIMESTAMP_H
#define NIF_TIMESTAMP_H

/**
    @name NIF Time Stamp Architecture IDs
    @{
    @brief Architecture IDs for NIF Time Stamp
*/
#define BRCM_SWARCH_NIF_ETHSETTIME_TYPE              (0x8401U)    /**< @brief #NIF_EthSetTimeType           */
#define BRCM_SWARCH_NIF_ETHSETCORRECTIONTIME_TYPE    (0x8402U)    /**< @brief #NIF_EthSetCorrectionTimeType */
#define BRCM_SWARCH_NIF_ETHSETGPTIMER_TYPE           (0x8403U)    /**< @brief #NIF_EthSetGPTimerType        */
#define BRCM_SWARCH_NIF_ETHGETTIME_TYPE              (0x8404U)    /**< @brief #NIF_EthGetTimeType           */
#define BRCM_SWARCH_NIF_ETHGETRXTIMESTAMP_TYPE       (0x8405U)    /**< @brief #NIF_EthGetRxTimestampType    */
#define BRCM_SWARCH_NIF_ETHGETTXTIMESTAMP_TYPE       (0x8406U)    /**< @brief #NIF_EthGetTxTimestampType    */
#define BRCM_SWARCH_NIF_ETHENABLETXTIMESTAMP_TYPE    (0x8407U)    /**< @brief #NIF_EthEnableTxTimestampType */
#define BRCM_SWARCH_NIF_TSETHINTF_TYPE               (0x8408U)    /**< @brief #NIF_TSEthIntfType            */
#define BRCM_SWARCH_NIF_RXTSCLIENTCB_TYPE            (0x8409U)    /**< @brief #NIF_RxTSClientCbType         */
#define BRCM_SWARCH_NIF_TXTSCLIENTCB_TYPE            (0x840AU)    /**< @brief #NIF_TxTSClientCbType         */
#define BRCM_SWARCH_NIF_TSCBTBL_TYPE                 (0x840BU)    /**< @brief #NIF_TSCbTblType              */
#define BRCM_SWARCH_NIF_TSCTRLCFG_TYPE               (0x840CU)    /**< @brief #NIF_TSCtrlCfgType            */
#define BRCM_SWARCH_NIF_TSCTRLCFG_GLOBAL             (0x840DU)    /**< @brief #NIF_TSCtrlCfg                */
#define BRCM_SWARCH_NIF_TSCFG_TYPE                   (0x840EU)    /**< @brief #NIF_TSCfgType                */
#define BRCM_SWARCH_NIF_GETTIME_PROC                 (0x840FU)    /**< @brief #NIF_GetTime                  */
#define BRCM_SWARCH_NIF_SETTIME_PROC                 (0x8410U)    /**< @brief #NIF_SetTime                  */
#define BRCM_SWARCH_NIF_SETCORRECTIONTIME_PROC       (0x8411U)    /**< @brief #NIF_SetCorrectionTime        */
/** @} */

/** @brief Ethernet set time

    This function is used by NIF to set the time to ethernet.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aID                 Ethernet controller ID
    @param[in]      aTS                 New Ethernet time to be set

    @return     As returned by the hooked function

    @post None

    @trace #BRCM_SWREQ_NIF_INIT

    @limitations None
*/
typedef int32_t (*NIF_EthSetTimeType)(ETHER_HwIDType aID, const ETHER_TimestampType* const aTS);

/** @brief Ethernet set correction time

    This function is used by NIF to set the correction time to ethernet.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aID                 Ethernet controller ID
    @param[in]      aTD                 Time difference between time-master
                                        time and local Ethernet time
    @param[in]      aRR                 Rate ratio between the time master and
                                        local clock

    @return     As returned by the hooked function

    @post None

    @trace #BRCM_SWREQ_NIF_INIT

    @limitations None
*/
typedef int32_t (*NIF_EthSetCorrectionTimeType)(ETHER_HwIDType aID, const ETHER_TimestampDiffType* const aTD, const ETHER_RateRatioType* const aRR);

/** @brief Ethernet set GPTimer

    This function is used by NIF to set the GPTimer to ethernet.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aID                 Ethernet controller ID
    @param[in]      aPeriod             Timer period in nanoseconds

    @return     As returned by the hooked function

    @post None

    @trace #BRCM_SWREQ_NIF_INIT

    @limitations None
*/
typedef int32_t (*NIF_EthSetGPTimerType)(ETHER_HwIDType aID, uint32_t aPeriod);

/** @brief Get network time

    This function is used by NIF to get the network time managed by
    ethernet.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aID                 Ethernet controller ID
    @param[out]     aTS                 Current Ethernet time
    @param[out]     aTSQual             Quality of the retrieved time

    @return     As returned by the hooked function

    @post None

    @trace #BRCM_SWREQ_NIF_INIT

    @limitations None
*/
typedef int32_t (*NIF_EthGetTimeType)(ETHER_HwIDType aID, ETHER_TimestampType* const aTS, ETHER_TimestampQualType* const aTSQual);

/** @brief Get Rx timestamp

    This function is used by NIF to get the Rx timestamp for a buffer
    recieved on ethernet.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aID                 Ethernet controller ID
    @param[in]      aPktBuf             Pointer to the received packet buffer
    @param[out]     aTS                 Timestamp captured at the instant the
                                        packet was received. This is derived
                                        from the Ethernet time base.
    @param[out]     aTSQual             Quality of the timestamp. Application
                                        may chose to ignore the timestamps which
                                        do not have quality value #ETHER_TIMESTAMPQUAL_VALID.

    @return     As returned by the hooked function

    @post None

    @trace #BRCM_SWREQ_NIF_INIT

    @limitations None
*/
typedef int32_t (*NIF_EthGetRxTimestampType)(ETHER_HwIDType aID, const uint8_t* const aPktBuf, ETHER_TimestampType* const aTS, ETHER_TimestampQualType* const aTSQual);

/** @brief Get Tx timestamp

    This function is used by NIF to get the Tx timestamp for a buffer
    transmitted over ethernet.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aID                 Ethernet controller ID
    @param[in]      aBufIdx             Buffer index (received in the transmit
                                        confirmation)
    @param[out]     aTS                 Timestamp captured at the instant the
                                        packet was transmitted. This is derived
                                        from the Ethernet time base.
    @param[out]     aTSQual             Quality of the timestamp. Application
                                        may chose to ignore the timestamps which
                                        do not have quality value #ETHER_TIMESTAMPQUAL_VALID.

    @return     As returned by the hooked function

    @post None

    @trace #BRCM_SWREQ_NIF_INIT

    @limitations None
*/
typedef int32_t (*NIF_EthGetTxTimestampType)(ETHER_HwIDType aID, uint32_t aBufIdx, ETHER_TimestampType* const aTS, ETHER_TimestampQualType* const aTSQual);

/** @brief Enable Tx timestamp

    This function is used by NIF to enable Tx timestamping.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aID                 Ethernet controller ID
    @param[in]      aBufIdx             Buffer index

    @return     As returned by the hooked function

    @post None

    @trace #BRCM_SWREQ_NIF_INIT

    @limitations None
*/
typedef int32_t (*NIF_EthEnableTxTimestampType)(ETHER_HwIDType aID, uint32_t aBufIdx);

/**
    @brief NIF ethernet controller function table configuration

    This is the callback configuration table for the ethernet controllers
    that are to be registered with NIF.

    @trace #BRCM_SWREQ_NIF_INIT
 */
typedef struct sNIF_TSEthIntfType {
    NIF_EthGetRxTimestampType getRxTS;              /**< @brief Get Rx Timestamp */
    NIF_EthGetTimeType getTime;                     /**< @brief Get time */
    NIF_EthGetTxTimestampType getTxTs;              /**< @brief Get Tx timestamp */
    NIF_EthEnableTxTimestampType enableTs;          /**< @brief Enable timestamp */
    NIF_EthSetTimeType setTime;                     /**< @brief Set time */
    NIF_EthSetCorrectionTimeType setCorrectionTime; /**< @brief Set correction time */
    NIF_EthSetGPTimerType setGPTimer;               /**< @brief Set GP timer */
} NIF_TSEthIntfType;

/** @brief RX timestamp callback

    Each client shall register this timestamp callback. This callback
    shall be invoked each packet received and timestamped by hardware.

    @behavior Sync, Non-reentrant

    @pre describe any pre-condition (expectation before calling this function)

    @param[in]   aCtrlIdx        Controller index
    @param[in]   aBuf            Pointer to the packet buffer
    @param[in]   aXcvrId         Transceiver Port ID
    @param[in]   aTS             Pointer to timestamp
    @param[in]   aTSQual         Pointer to quality of captured timestamp

    @return void

    @post describe post condition (status after execution of the function)

    @trace #BRCM_SWREQ_NIF_INIT
*/
typedef void (*NIF_RxTSClientCbType)(NIF_CntrlIDType aCtrlIdx, const uint8_t *const aBuf, uint8_t aXcvrId, const ETHER_TimestampType *const aTS, const ETHER_TimestampQualType* const aTSQual);

/** @brief TX timestamp callback

    Each client shall register this timestamp callback. This callback
    shall be invoked for each packet transmitted with timestamp enabled.

    @behavior Sync, Non-reentrant

    @pre describe any pre-condition (expectation before calling this function)

    @param[in]   aCtrlIdx        Controller index
    @param[in]   aBuf            Pointer to the packet buffer
    @param[in]   aXcvrId         Transceiver Port ID
    @param[in]   aTS             Pointer to timestamp
    @param[in]   aTSQual         Pointer to quality of captured timestamp

    @return void

    @post describe post condition (status after execution of the function)

    @trace #BRCM_SWREQ_NIF_INIT
*/
typedef void (*NIF_TxTSClientCbType)(NIF_CntrlIDType aCtrlIdx, uint32_t aBufIdx, uint8_t aXcvrId, const ETHER_TimestampType *const aTS, const ETHER_TimestampQualType* const aTSQual);

/**
    @brief NIF client callback table configuration

    This is the callback configuration table for all the NIF client
    that are to be registered with NIF.

    @trace #BRCM_SWREQ_NIF_INIT
 */
typedef struct sNIF_TSCbTblType {
    NIF_RxTSClientCbType         rxTSCb;             /**< @brief Rx timestamp callback function */
    NIF_TxTSClientCbType         txTSCb;             /**< @brief Tx timestamp callback function */
} NIF_TSCbTblType;

/**
    @brief NIF controller configuration table

    NIF controller configuration table.

    @trace #BRCM_SWREQ_NIF_INIT
 */
typedef struct sNIF_TSCtrlCfgType {
    const NIF_TSCbTblType *const tsCbTbl;           /**< @brief Client callback table */
    const uint32_t tsCbTblSize;                     /**< @brief Client callback table size */
    const NIF_TSEthIntfType *const tsEthIntfTbl;    /**< @brief Ethernet interface table */
    const uint32_t tsEthIntfTblSize;                /**< @brief Ethernet interface table size */
    const NIF_TSEthIntfType *const tsWlEthIntfTbl;  /**< @brief WL Ethernet interface table */
    const uint32_t tsWlEthIntfTblSize;              /**< @brief WL Ethernet interface table size */
} NIF_TSCtrlCfgType;

/**
    @brief NIF TS Control Configuration

    @trace #BRCM_SWREQ_NIF_INIT
*/
extern const NIF_TSCtrlCfgType *NIF_TSCtrlCfg;

/**
    @brief NIF configuration

    NIF configuration.

    @trace #BRCM_SWREQ_NIF_INIT
 */
typedef struct sNIF_TSCfgType {
    const NIF_TSCtrlCfgType *const tsCtrlCfg;       /**< @brief Controller config */
} NIF_TSCfgType;

/** @brief Retrieve current Ethernet time

    This API retrieves the Ethernet current time.

    @behavior Sync, Reentrant

    @pre describe any pre-condition (expectation before calling this function)

    @param[in]       aCtrlIdx                Controller index
    @param[out]      aTS                     Current Ethernet time
    @param[out]      aTSQual                 Quality of the retrieved time

    @retval          #BCM_ERR_OK              Successfully retrieved current
                                             Ethernet time
    @retval          #BCM_ERR_INVAL_PARAMS    Invalid controller index
    @retval          #BCM_ERR_INVAL_PARAMS    aTS is NULL
    @retval          #BCM_ERR_INVAL_PARAMS    aTSQual is NULL
    @retval          #BCM_ERR_INVALID_STATE   Controller not initialized
    @retval          #BCM_ERR_UNINIT          NIF is not initialised
    @retval          #BCM_ERR_NOSUPPORT       This feature is not supported

    @post describe post condition (status after execution of the function)

    @trace #BRCM_SWREQ_NIF_TIME
*/
extern int32_t NIF_GetTime(NIF_CntrlIDType aCtrlIdx, ETHER_TimestampType* const aTS, ETHER_TimestampQualType* const aTSQual);

/** @brief Set Ethernet time

    This API sets the Ethernet time.
    This API shall be invoked only on time masters.
    For time slaves the ETHER_SetCorrectionTime API shall be used.

    @behavior Sync, Non-reentrant

    @pre describe any pre-condition (expectation before calling this function)

    @param[in]       aCtrlIdx                Controller index
    @param[in]       aTS                     New Ethernet time to be set

    @retval          #BCM_ERR_OK              Ethernet time successfully set
    @retval          #BCM_ERR_INVAL_PARAMS    Invalid controller index
    @retval          #BCM_ERR_INVAL_PARAMS    aTS is NULL
    @retval          #BCM_ERR_INVALID_STATE   Controller not initialized
    @retval          #BCM_ERR_UNINIT          NIF is not initialised

    @post describe post condition (status after execution of the function)

    @trace #BRCM_SWREQ_NIF_TIME
*/
extern int32_t NIF_SetTime(NIF_CntrlIDType aCtrlIdx, const ETHER_TimestampType* const aTS);

/** @brief Adjust Ethernet time

    This API adjusts local Ethernet clock on the basis of timing
    messages received from the time-master.

    @behavior Sync, Non-reentrant

    @pre describe any pre-condition (expectation before calling this function)

    @param[in]       aCtrlIdx                Controller index
    @param[in]       aTD                     Time difference between time-master
                                             time and local Ethernet time
    @param[in]       aRR                     Rate ratio between the time master

    @retval          #BCM_ERR_OK              Ethernet time corrected successfully
    @retval          #BCM_ERR_INVAL_PARAMS    Invalid controller index
    @retval          #BCM_ERR_INVAL_PARAMS    aTD is NULL
    @retval          #BCM_ERR_INVAL_PARAMS    aRR is NULL
    @retval          #BCM_ERR_INVALID_STATE   Controller not initialized
    @retval          #BCM_ERR_UNINIT          NIF is not initialised

    @post describe post condition (status after execution of the function)

    @trace #BRCM_SWREQ_NIF_TIME
*/
extern int32_t NIF_SetCorrectionTime(NIF_CntrlIDType aCtrlIdx, const ETHER_TimestampDiffType* const aTD, const ETHER_RateRatioType* const aRR);

#endif /* NIF_TIMESTAMP_H */
/** @} */
