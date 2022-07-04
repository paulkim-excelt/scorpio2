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
    @defgroup grp_nif_impl Implementation
    @ingroup grp_nif

    @addtogroup grp_nif_impl
    @{

    @file nif_internal.h
    @brief NIF Internal Header File
    This header file contains the internal data structures of NIF
    @version 0.1 Initial Version
*/

#ifndef NIF_INTERNAL_H
#define NIF_INTERNAL_H

#include <stddef.h>
#include <inttypes.h>
#include <bcm_err.h>
#include <ethernet.h>
#include <ethxcvr.h>
#include <nif.h>
#include <nif_xcvr.h>
#include <nif_avb.h>
#include <nif_timestamp.h>

/**
    @name NIF Architecture IDs
    @{
    @brief Architecture IDs for NIF
*/
#define BRCM_SWARCH_NIF_BUF_COUNT_MACRO               (0x8101U)    /**< @brief #NIF_BUF_COUNT             */
#define BRCM_SWARCH_NIF_CTRLVAL_TYPE                  (0x8102U)    /**< @brief #NIF_CtrlValType           */
#define BRCM_SWARCH_NIF_BUFSTATE_TYPE                 (0x8103U)    /**< @brief #NIF_BufStateType          */
#define BRCM_SWARCH_NIF_TXBUFINFO_TYPE                (0x8104U)    /**< @brief #NIF_TxBufInfoType         */
#define BRCM_SWARCH_NIF_COMP_TYPE                     (0x8105U)    /**< @brief #NIF_CompType              */
#define BRCM_SWARCH_NIF_CTRL_MACRO                    (0x8106U)    /**< @brief #NIF_CTRL                  */
#define BRCM_SWARCH_NIF_REPORTERROR_PROC              (0x8107U)    /**< @brief #NIF_ReportError           */
#define BRCM_SWARCH_NIF_GETCLIENTID_PROC              (0x8108U)    /**< @brief #NIF_GetClientID           */
#define BRCM_SWARCH_NIF_GETCMNETHCONTROLLERID_PROC    (0x8109U)    /**< @brief #NIF_GetCmnEthControllerID */
#define BRCM_SWARCH_NIF_GETTSETHCONTROLLERID_PROC     (0x810AU)    /**< @brief #NIF_GetTSEthControllerID  */
#define BRCM_SWARCH_NIF_COMP_GLOBAL                   (0x810BU)    /**< @brief #NIF_Comp                  */
#define BRCM_SWARCH_NIF_TXBUFINFO_GLOBAL              (0x810CU)    /**< @brief #NIF_TxBufInfo             */
#define BRCM_SWARCH_NIF_CMNCTRLCONFIG_GLOBAL          (0x810DU)    /**< @brief #NIF_CmnCtrlConfig         */
#define BRCM_SWARCH_NIF_TSCTRLCONFIG_GLOBAL           (0x810EU)    /**< @brief #NIF_TSCtrlConfig          */
#define BRCM_SWARCH_NIF_AVBCTRLCONFIG_GLOBAL          (0x810FU)    /**< @brief #NIF_AVBCtrlConfig         */
/** @} */

/**
    @brief NIF buffer count

    @trace #BRCM_SWREQ_NIF_CONFIG
*/
#define NIF_BUF_COUNT                   (128UL)

/**
    @name NIF CTRL Mask and Shift Values
    @{

    @brief NIF ethernet mask/shift

     NIF Controller Index encoding

     ---------------------------------------------------------------------
    |Comp Id(16b) | Inst Id(8b) | Resv(20b) | VLAN Id(12b) | Eth Ctrl(8b) |
     ---------------------------------------------------------------------

    @trace #BRCM_SWREQ_NIF_CONFIG
*/
typedef uint64_t NIF_CtrlValType;                                   /**< @brief Control values */
#define NIF_CTRLVAL_COMP_ID_MASK            (0xFFFF000000000000ULL) /**< @brief Comp ID mask */
#define NIF_CTRLVAL_COMP_ID_SHIFT           (48ULL)                 /**< @brief Comp ID shift */
#define NIF_CTRLVAL_VLAN_ID_MASK            (0xFFF00ULL)            /**< @brief VLAN ID mask */
#define NIF_CTRLVAL_VLAN_ID_SHIFT           (8ULL)                  /**< @brief VLAN ID shift */
#define NIF_CTRLVAL_INST_ID_MASK            (0xFF0000000000ULL)     /**< @brief Instance ID mask */
#define NIF_CTRLVAL_INST_ID_SHIFT           (40ULL)                 /**< @brief Instance ID shift */
#define NIF_CTRLVAL_CNTRLRTYPE_MASK         (0xF0ULL)               /**< @brief Eth controller type mask */
#define NIF_CTRLVAL_CNTRLRTYPE_SHIFT        (4ULL)                  /**< @brief Eth controller type shift */
#define NIF_CTRLVAL_CNTRLRID_MASK           (0xFULL)                /**< @brief Eth controller ID mask */
#define NIF_CTRLVAL_CNTRLRID_SHIFT          (0ULL)                  /**< @brief Eth controller ID shift */
/** @} */

/**
    @name NIF buffer state values
    @{
    @brief NIF buffer state values

    NIF buffer state values

    @trace #BRCM_SWREQ_NIF_INIT
*/
typedef uint32_t NIF_BufStateType;          /**< @brief Buffer state type */
#define NIF_BUFSTATE_FREE         (0UL)     /**< @brief Buffer state free */
#define NIF_BUFSTATE_ALLOC        (1UL)     /**< @brief Buffer state allocated */
#define NIF_BUFSTATE_TX           (2UL)     /**< @brief Buffer state Tx */
/** @} */

/**
    @brief Struct type to store Tx Buffer information

    @trace #BRCM_SWREQ_NIF_INIT
 */
typedef struct sNIF_TxBufInfoType {
    NIF_CntrlIDType ctrlIdx;            /**< @brief Control index */
    NIF_BufStateType bufState;          /**< @brief Buffer state */
    ETHER_EtherType etherType;          /**< @brief Ether type value */
    uint32_t isTSed;                    /**< @brief Is timestamped */
    uint32_t size;                      /**< @brief Size in bytes */
} NIF_TxBufInfoType;

/**
    @brief NIF context structure

    NIF context structure

    @trace #BRCM_SWREQ_NIF_INIT
 */
typedef struct sNIF_CompType {
    NIF_StateType state;                /**< @brief NIF state */
    NIF_RxBufInfoType rxBufInfo;        /**< @brief Rx buffer info */
    uint32_t isWaitingForBuffer;        /**< @brief isWaitingForBuffer */
    uint32_t currentTimerPeriod;        /**< @brief currentTimerPeriod */
    uint32_t totalAVBReserved;          /**< @brief totalAVBReserved */
} NIF_CompType;

/**
    @brief NIF Comp

    @trace #BRCM_SWREQ_NIF_INIT
*/
extern NIF_CompType NIF_Comp;

/**
    @trace #BRCM_SWREQ_NIF_INIT
*/
extern NIF_TxBufInfoType NIF_TxBufInfo[NIF_BUF_COUNT];

/**
    @brief NIF Common configuration memory

    @trace #BRCM_SWREQ_NIF_INIT
*/
extern const NIF_CmnCtrlCfgType NIF_CmnCtrlConfig;

/**
    @brief NIF TS configuration memory

    @trace #BRCM_SWREQ_NIF_INIT
*/
extern const NIF_TSCtrlCfgType NIF_TSCtrlConfig;

/**
    @brief NIF AVB configuration memory

    @trace #BRCM_SWREQ_NIF_INIT
*/
extern const NIF_AVBCtrlCfgType NIF_AVBCtrlConfig;

/**
    @brief NIF control value

    @trace #BRCM_SWREQ_NIF_CONFIG
*/
#define NIF_CTRL(aVlanID, aClientID, aCtrlIdx)                                    \
        ( ((((((uint64_t)(aClientID) & NIF_CLIENTIDVAL_COMPID_MASK) >> NIF_CLIENTIDVAL_COMPID_SHIFT))     \
               << NIF_CTRLVAL_COMP_ID_SHIFT) & NIF_CTRLVAL_COMP_ID_MASK)          \
        | ((((((uint64_t)(aClientID) & NIF_CLIENTIDVAL_INSTID_MASK) >> NIF_CLIENTIDVAL_INSTID_SHIFT))     \
               << NIF_CTRLVAL_INST_ID_SHIFT) & NIF_CTRLVAL_INST_ID_MASK)          \
        | ((((uint64_t)(aVlanID)) << NIF_CTRLVAL_VLAN_ID_SHIFT)                   \
                & NIF_CTRLVAL_VLAN_ID_MASK)                                       \
        | ((((((uint64_t)(aCtrlIdx) & NIF_CNTRLRBIT_TYPE_MASK) >> NIF_CNTRLRBIT_TYPE_SHIFT))\
               << NIF_CTRLVAL_CNTRLRTYPE_SHIFT) & NIF_CTRLVAL_CNTRLRTYPE_MASK)    \
        | ((((((uint64_t)(aCtrlIdx) & NIF_CNTRLRBIT_ID_MASK) >> NIF_CNTRLRBIT_ID_SHIFT))    \
               << NIF_CTRLVAL_CNTRLRID_SHIFT) & NIF_CTRLVAL_CNTRLRID_MASK))

/** @brief NIF error reporting function

    Error reporting function used by all NIF functions.

    @behavior Sync, Reentrant

    @pre describe any pre-condition (expectation before calling this function)

    @param[in]       aCtrlIdx            NIF controller index
    @param[in]       aApiID              NIF API ID
    @param[in]       aVal0               Error value 1
    @param[in]       aVal1               Error value 2

    @return void

    @post describe post condition (status after execution of the function)

    @trace #BRCM_SWREQ_NIF_INIT
*/
void NIF_ReportError(NIF_CntrlIDType aCtrlIdx,
                      uint16_t aApiID, int32_t aError,
                      uint32_t aVal0, uint32_t aVal1);

/** @brief Retrieve NIF Client ID

    Function used by NIF to retrieve the client ID.

    @behavior Sync, Reentrant

    @pre describe any pre-condition (expectation before calling this function)

    @param[in]       aCtrlIdx            NIF controller index
    @param[out]      aClientID           Client ID extracted from
                                         controller index
    @return void

    @post describe post condition (status after execution of the function)

    @trace #BRCM_SWREQ_NIF_INIT
*/
void  NIF_GetClientID(NIF_CntrlIDType aCtrlIdx,
                      NIF_ClientIDType *const aClientID);

/** @brief Retrieve ethernet driver function table and index

    Function used by NIF to retrieve the ethernet driver function
    table for usage of ethernet controller.

    @behavior Sync, Reentrant

    @pre describe any pre-condition (expectation before calling this function)

    @param[in]       aCtrlIdx            NIF controller index

    @return         NULL               In case of an invalid control index
                    Valid pointer       Pointer to ethernet/xcvr/switch
                                        driver function table.

    @post describe post condition (status after execution of the function)

    @trace #BRCM_SWREQ_NIF_INIT
*/
const NIF_CmnEthIntfType* NIF_GetCmnEthControllerID(NIF_CntrlIDType aCtrlIdx);

/** @brief Retrieve ethernet driver function table and index

    Function used by NIF to retrieve the ethernet driver function
    table for usage of ethernet controller.

    @behavior Sync, Reentrant

    @pre describe any pre-condition (expectation before calling this function)

    @param[in]       aCtrlIdx            NIF controller index

    @return         NULL               In case of an invalid control index
                    Valid pointer       Pointer to ethernet/xcvr/switch
                                        driver function table.

    @post describe post condition (status after execution of the function)

    @trace #BRCM_SWREQ_NIF_INIT
*/
const NIF_TSEthIntfType* NIF_GetTSEthControllerID(NIF_CntrlIDType aCtrlIdx);

#endif /* NIF_INTERNAL_H */
/** @} */
