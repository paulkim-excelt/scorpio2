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

    @file nif_avb.h
    @brief NIF AVB Interface File

    @version 0.1 Initial Version
*/

#ifndef NIF_AVB_H
#define NIF_AVB_H

#include <nif.h>

/**
    @name NIF AVB Architecture IDs
    @{
    @brief Architecture IDs for NIF AVB
*/
#define BRCM_SWARCH_NIF_AVBCLASS_TYPE                       (0x8801U)    /**< @brief #NIF_AVBClassType                */
#define BRCM_SWARCH_NIF_BUFFERAVAILABLECB_TYPE              (0x8802U)    /**< @brief #NIF_BufferAvailableCbType       */
#define BRCM_SWARCH_NIF_AVBCBTBL_TYPE                       (0x8803U)    /**< @brief #NIF_AVBCbTblType                */
#define BRCM_SWARCH_NIF_AVBCTRLCFG_TYPE                     (0x8804U)    /**< @brief #NIF_AVBCtrlCfgType              */
#define BRCM_SWARCH_NIF_AVBCFG_TYPE                         (0x8805U)    /**< @brief #NIF_AVBCfgType                  */
#define BRCM_SWARCH_NIF_ENABLEAVBSHAPING_PROC               (0x8806U)    /**< @brief #NIF_EnableAVBShaping            */
#define BRCM_SWARCH_NIF_DISABLEAVBSHAPING_PROC              (0x8807U)    /**< @brief #NIF_DisableAVBShaping           */
#define BRCM_SWARCH_NIF_PROCESSETHERNETTIMER_PROC           (0x8808U)    /**< @brief #NIF_ProcessEthernetTimer        */
#define BRCM_SWARCH_NIF_ARECLIENTSWAITINGFORBUFFERS_PROC    (0x8809U)    /**< @brief #NIF_AreClientsWaitingForBuffers */
/** @} */

/**
    @name AVB Traffic Class Type
    @{
    @brief AVB Traffic Class type of NIF

    This is the listing of the AVB traffic class types that are
    supported by NIF.

    @trace #BRCM_SWREQ_NIF_CONFIG
*/
typedef uint32_t NIF_AVBClassType;         /**< @brief AVB class */
#define NIF_AVBCLASS_A            (125UL)  /**< @brief AVB class type A */
#define NIF_AVBCLASS_B            (250UL)  /**< @brief AVB class type B */
/** @} */

/** @brief NIF buffer available client callback

    Each client which registers for this callback will be informed of
    buffer availability in case it was waiting for a buffer.

    @behavior Sync, Non-reentrant

    @pre describe any pre-condition (expectation before calling this function)

    @param[in]   aCtrlIdx        Controller index

    @return void

    @post describe post condition (status after execution of the function)

    @trace #BRCM_SWREQ_NIF_INIT
*/
typedef void (*NIF_BufferAvailableCbType) (NIF_CntrlIDType aCtrlIdx);

/**
    @brief NIF client callback table configuration

    This is the callback configuration table for all the NIF client
    that are to be registered with NIF.

    @trace #BRCM_SWREQ_NIF_INIT
 */
typedef struct sNIF_AVBCbTblType {
    NIF_BufferAvailableCbType    bufAvailCb;    /**< @brief Buffer available callback function */
} NIF_AVBCbTblType;

/**
    @brief NIF controller configuration table

    @trace #BRCM_SWREQ_NIF_INIT
 */
typedef struct sNIF_AVBCtrlCfgType {
    const NIF_AVBCbTblType *const avbCbTbl;     /**< @brief Client callback table */
    const uint32_t avbCbTblSize;                /**< @brief Client callback table size */
} NIF_AVBCtrlCfgType;

/**
    @brief NIF AVB configuration

    @trace #BRCM_SWREQ_NIF_INIT
 */
typedef struct sNIF_AVBCfgType {
    const NIF_AVBCtrlCfgType *const avbCtrlCfg;       /**< @brief Controller config */
} NIF_AVBCfgType;

/** @brief Enables AVB shaping for a stream

    This API verifies that the client has a stream allocated in the shaper and
    then enables shaping on it. If required, it will update the Ethernet GPTimer
    according to the minimum shaping class interval

    @behavior Sync, Reentrant

    @pre describe any pre-condition (expectation before calling this function)

    @param[in]       aCtrlIdx            NIF controller index
    @param[in]       aClass              AVB shaping class
    @param[in]       aReservation        Percentage of link bandwidth reserved
                                         for the stream

    @retval         #BCM_ERR_OK              Successful
    @retval         #BCM_ERR_INVAL_PARAMS    Invalid aCtrlIdx
    @retval         #BCM_ERR_INVAL_PARAMS    Stream already enabled
    @retval         #BCM_ERR_INVAL_PARAMS    aReservation exceeds bounds
    @retval         #BCM_ERR_UNINIT          NIF is not initialized

    @post describe post condition (status after execution of the function)

    @trace #BRCM_SWREQ_NIF_STREAM_SHAPING
*/
int32_t NIF_EnableAVBShaping(NIF_CntrlIDType aCtrlIdx, NIF_AVBClassType aClass, uint32_t aReservation);

/** @brief Disables AVB shaping for a stream

    This API verifies that the client has a stream allocated in the shaper and
    then disables shaping on it. If required, it will update the Ethernet GPTimer
    according to the minimum shaping class interval

    @behavior Sync, Reentrant

    @pre describe any pre-condition (expectation before calling this function)

    @param[in]       aCtrlIdx               NIF controller index
                                            for the stream

    @retval         #BCM_ERR_OK              Successful
    @retval         #BCM_ERR_INVAL_PARAMS    Invalid aCtrlIdx
    @retval         #BCM_ERR_INVAL_PARAMS    Stream already disabled
    @retval         #BCM_ERR_UNINIT          NIF is not initialized

    @post describe post condition (status after execution of the function)

    @trace #BRCM_SWREQ_NIF_STREAM_SHAPING
*/
int32_t NIF_DisableAVBShaping(NIF_CntrlIDType aCtrlIdx);

/** @brief Process ethernet timer

    This API is invoked periodically at the class interval expiry to wake
    up any stream clients for which credits have been replenished and which
    are waiting for a buffer to become free

    @behavior Sync, Non-reentrant

    @pre describe any pre-condition (expectation before calling this function)

    @param[in]       aID                Index of H/W controller

    @return          void

    @post describe post condition (status after execution of the function)

    @trace #BRCM_SWREQ_NIF_STREAM_SHAPING
*/
void NIF_ProcessEthernetTimer(ETHER_HwIDType aID);

/** @brief Check if clients are waiting for buffer

    This API is invoked by the interrupt handler on class interval expiry to
    deduce if any stream clients are waiting for buffers

    @behavior Sync, Non-reentrant

    @pre describe any pre-condition (expectation before calling this function)

    @param void

    @retval          #TRUE                Clients are waiting for buffers
    @retval          #FALSE               No clients waiting for buffers

    @post describe post condition (status after execution of the function)

    @trace #BRCM_SWREQ_NIF_STREAM_SHAPING
*/
uint32_t NIF_AreClientsWaitingForBuffers(void);

#endif /* NIF_AVB_H */
/** @} */