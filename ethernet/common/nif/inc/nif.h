/*****************************************************************************
 Copyright 2017-2020 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_nif_ifc NIF Interface
    @ingroup grp_nif

    @addtogroup grp_nif_ifc
    @{

    @file nif.h
    @brief NIF Common Interface File

    @version 0.1 Initial Version
*/

#ifndef NIF_H
#define NIF_H

#include <stddef.h>
#include <inttypes.h>
#include <bcm_err.h>
#include <ethernet.h>

/**
    @name NIF Architecture IDs
    @{
    @brief Architecture IDs for NIF
*/
#define BRCM_SWARCH_NIF_CLIENTIDVAL_TYPE              (0x8501U)    /**< @brief #NIF_ClientIDValType      */
#define BRCM_SWARCH_NIF_CLIENT_ID_MACRO               (0x8502U)    /**< @brief #NIF_CLIENT_ID            */
#define BRCM_SWARCH_NIF_CONTROLLERVAL_TYPE            (0x8503U)    /**< @brief #NIF_ControllerValType    */
#define BRCM_SWARCH_NIF_GET_CONTROLLER_INDEX_MACRO    (0x8504U)    /**< @brief #NIF_GET_CONTROLLER_INDEX */
#define BRCM_SWARCH_NIF_CNTRLRBIT_TYPE                (0x8505U)    /**< @brief #NIF_CntrlrBitType        */
#define BRCM_SWARCH_NIF_CNTRLR_ID_MACRO               (0x8506U)    /**< @brief #NIF_CNTRLR_ID            */
#define BRCM_SWARCH_NIF_CLIENTIDTYPE_TYPE             (0x8507U)    /**< @brief #NIF_ClientIDType         */
#define BRCM_SWARCH_NIF_CNTRLRVAL_TYPE                (0x8508U)    /**< @brief #NIF_CntrlrValType        */
#define BRCM_SWARCH_NIF_CNTRLIDTYPE_TYPE              (0x8509U)    /**< @brief #NIF_CntrlIDType          */
#define BRCM_SWARCH_NIF_RXCLIENTCB_TYPE               (0x850AU)    /**< @brief #NIF_RxClientCbType       */
#define BRCM_SWARCH_NIF_TXDONECLIENTCB_TYPE           (0x850BU)    /**< @brief #NIF_TxDoneClientCbType   */
#define BRCM_SWARCH_NIF_ETHCNTRLR_TYPE                (0x850CU)    /**< @brief #NIF_EthCntrlrType        */
#define BRCM_SWARCH_NIF_ETHCNTRLRIDX_TYPE             (0x850DU)    /**< @brief #NIF_EthCntrlrIdxType     */
#define BRCM_SWARCH_NIF_CMNCBTBLTYPE_TYPE             (0x850EU)    /**< @brief #NIF_CmnCbTblType         */
#define BRCM_SWARCH_NIF_ETHGETTXBUFFER_TYPE           (0x850FU)    /**< @brief #NIF_EthGetTxBufferType   */
#define BRCM_SWARCH_NIF_ETHSEND_TYPE                  (0x8510U)    /**< @brief #NIF_EthSendType          */
#define BRCM_SWARCH_NIF_ETHGETMACADDR_TYPE            (0x8511U)    /**< @brief #NIF_EthGetMacAddrType    */
#define BRCM_SWARCH_NIF_ETHSETMODE_TYPE               (0x8512U)    /**< @brief #NIF_EthSetModeType       */
#define BRCM_SWARCH_NIF_ETHGETMODE_TYPE               (0x8513U)    /**< @brief #NIF_EthGetModeType       */
#define BRCM_SWARCH_NIF_CMNETHINTF_TYPE               (0x8514U)    /**< @brief #NIF_CmnEthIntfType       */
#define BRCM_SWARCH_NIF_CMNCTRLCFGTYPE_TYPE           (0x8515U)    /**< @brief #NIF_CmnCtrlCfgType       */
#define BRCM_SWARCH_NIF_CMNCFGTYPE_TYPE               (0x8516U)    /**< @brief #NIF_CmnCfgType           */
#define BRCM_SWARCH_NIF_INIT_PROC                     (0x8517U)    /**< @brief #NIF_Init                 */
#define BRCM_SWARCH_NIF_GETCTRLIDX_PROC               (0x8518U)    /**< @brief #NIF_GetCtrlIdx           */
#define BRCM_SWARCH_NIF_SETCTRLMODE_PROC              (0x8519U)    /**< @brief #NIF_SetCtrlMode          */
#define BRCM_SWARCH_NIF_GETCTRLMODE_PROC              (0x851AU)    /**< @brief #NIF_GetCtrlMode          */
#define BRCM_SWARCH_NIF_GETMACADDR_PROC               (0x851BU)    /**< @brief #NIF_GetMacAddr           */
#define BRCM_SWARCH_NIF_GETVLANID_PROC                (0x851CU)    /**< @brief #NIF_GetVlanID            */
#define BRCM_SWARCH_NIF_GETTXBUFFER_PROC              (0x851DU)    /**< @brief #NIF_GetTxBuffer          */
#define BRCM_SWARCH_NIF_SEND_PROC                     (0x851EU)    /**< @brief #NIF_Send                 */
#define BRCM_SWARCH_NIF_ENABLETXTIMESTAMP_PROC        (0x851FU)    /**< @brief #NIF_EnableTxTimestamp    */
#define BRCM_SWARCH_NIF_FINDSTREAMIDX_PROC            (0x8520U)    /**< @brief #NIF_FindStreamIdx        */
#define BRCM_SWARCH_NIF_STATE_TYPE                    (0x8521U)    /**< @brief #NIF_StateType            */
#define BRCM_SWARCH_NIF_RXBUFINFO_TYPE                (0x8522U)    /**< @brief #NIF_RxBufInfoType        */
/** @} */

/**
    @name NIF state values
    @{
    @brief NIF state values

    NIF state values

    @trace #BRCM_SWREQ_NIF_INIT
*/
typedef uint32_t NIF_StateType;        /**< @brief NIF state type */
#define NIF_STATE_UNINIT         (0UL) /**< @brief Uninit state */
#define NIF_STATE_INIT           (1UL) /**< @brief Init state */
/** @} */

/**
    @brief Struct type to store Rx Buffer information

    Struct type to store Rx Buffer information

    @trace #BRCM_SWREQ_NIF_INIT
 */
typedef struct sNIF_RxBufInfoType {
    const uint8_t *drvBuf;           /**< @brief Driver buffer */
    const uint8_t *clientBuf;        /**< @brief Client buffer */
    ETHER_VLANIDType vlanID;         /**< @brief VLAN ID */
    ETHER_EtherType etherType;       /**< @brief Ether type */
} NIF_RxBufInfoType;

/**
    @name NIF client ID composition macros
    @{

    @trace #BRCM_SWREQ_NIF_CONFIG
*/
typedef uint32_t NIF_ClientIDValType;                  /**< @brief Values for ClientID composition  */
#define NIF_CLIENTIDVAL_COMPID_SHIFT      (0UL)        /**< @brief Shift for COMPID */
#define NIF_CLIENTIDVAL_COMPID_MASK       (0xFFFFUL)   /**< @brief Mask for COMPID */
#define NIF_CLIENTIDVAL_INSTID_SHIFT      (16UL)       /**< @brief Shift for INSTID */
#define NIF_CLIENTIDVAL_INSTID_MASK       (0xFF0000UL) /**< @brief Mask for INSTID */
/** @} */

/**
    @brief NIF client ID

    macro used to compose the client ID value.

    @trace #BRCM_SWREQ_NIF_CONFIG
*/
#define NIF_CLIENT_ID(aCompID, aInstID) ((((uint32_t)(aCompID) <<                          \
                            NIF_CLIENTIDVAL_COMPID_SHIFT) & NIF_CLIENTIDVAL_COMPID_MASK) | \
                            (((uint32_t)(aInstID) <<                                       \
                            NIF_CLIENTIDVAL_INSTID_SHIFT) & NIF_CLIENTIDVAL_INSTID_MASK))

/**
    @name NIF controller ID composition macros
    @{

    @trace #BRCM_SWREQ_NIF_CONFIG
*/
typedef uint32_t NIF_ControllerValType;                   /**< @brief Values for Controller index composition  */
#define NIF_CONTROLLERVAL_CNTRLRID_MASK           (0xFUL) /**< @brief Eth controller ID mask */
#define NIF_CONTROLLERVAL_CNTRLRID_SHIFT          (0UL)   /**< @brief Eth controller ID shift */
/** @} */

/**
    @brief NIF get controller ID

    macro used to fetch the controller ID value.

    @trace #BRCM_SWREQ_NIF_CONFIG
*/
#define NIF_GET_CONTROLLER_INDEX(aCtrlIdx) ((uint32_t)(((aCtrlIdx) & NIF_CONTROLLERVAL_CNTRLRID_MASK) \
                                                >> NIF_CONTROLLERVAL_CNTRLRID_SHIFT))

/**
    @name NIF controller ID type
    @{

    @trace #BRCM_SWREQ_NIF_CONFIG
*/
typedef uint32_t NIF_CntrlrBitType;                 /**< @brief Values for controller ID composition  */
#define NIF_CNTRLRBIT_TYPE_SHIFT          (4UL)     /**< @brief Shift for controller type */
#define NIF_CNTRLRBIT_TYPE_MASK           (0xF0UL)  /**< @brief Mask for controller type */
#define NIF_CNTRLRBIT_ID_SHIFT            (0UL)     /**< @brief Shift for controller ID */
#define NIF_CNTRLRBIT_ID_MASK             (0xFUL)   /**< @brief Mask for controller ID */
/** @} */

/**
    @brief NIF controller ID

    macro used to compose the controller ID value.

    @trace #BRCM_SWREQ_NIF_CONFIG
*/
#define NIF_CNTRLR_ID(aCtrlType, aCtrlIdx) ((((uint32_t)(aCtrlType) <<                         \
                                        NIF_CNTRLRBIT_TYPE_SHIFT) & NIF_CNTRLRBIT_TYPE_MASK) | \
                                        (((uint32_t)(aCtrlIdx) <<                              \
                                        NIF_CNTRLRBIT_ID_SHIFT) & NIF_CNTRLRBIT_ID_MASK))

/**
    @name NIF client identifier
    @brief NIF client identifier

    NIF client identifier registered with the NIF.

    @trace #BRCM_SWREQ_NIF_CONFIG
*/
typedef uint32_t NIF_ClientIDType; /**< @brief Client ID type value */

/**
    @name NIF controller index value
    @{
    Index of the ethernet controller (type,index) to be used for the NIF client.

    @trace #BRCM_SWREQ_NIF_CONFIG
*/
typedef uint8_t NIF_CntrlrValType;      /**< @brief Ethernet controller index value */
#define NIF_CNTRLRVAL_INVALID (0xFFU)   /**< @brief Invalid value */
/** @} */

/**
    @name NIF controller identifier
    @{
    @brief NIF controller identifier

    NIF client identifier that is used by NIF to identify the ethernet
    controller index using its instance ID, VLAN and hardware
    controller index information.

    @trace #BRCM_SWREQ_NIF_INIT
*/
typedef uint64_t NIF_CntrlIDType; /**< @brief Control ID type value */
#define NIF_CNTRLIDTYPE_INVALID (0xFFFFFFFFFFFFFFFFULL) /**< @brief Invalid value */
/** @} */

/** @brief RX client callback type

    Each client shall register callback function for each EtherType.
    This callback shall be invoked when an Ethernet packet is received
    with corressponding EtherType.

    @behavior Sync, Non-reentrant

    @pre describe any pre-condition (expectation before calling this function)

    @param[in]   aCtrlIdx        Controller index in the context of NIF
    @param[in]   aBuf            Pointer to the packet buffer without L2
                                 packet encapsulation
    @param[in]   aLen            Length of the packet received
    @param[in]   aSrcMacAddr     Pointer to source MAC address
    @param[in]   aDestMacAddr    Pointer to destination MAC address
    @param[in]   aPriority       PCP priority of the packet

    @return void

    @post describe post condition (status after execution of the function)

    @trace #BRCM_SWREQ_NIF_INIT
*/
typedef void (*NIF_RxClientCbType)(NIF_CntrlIDType aCtrlIdx,
                                   const uint8_t *const aBuf,
                                   uint16_t aLen,
                                   const uint8_t *const aSrcMacAddr,
                                   const uint8_t *const aDestMacAddr,
                                   uint32_t aPriority);

/** @brief TX done indication callback type

    Each client shall register this Transmit done indication callback.
    This callback shall be invoked on transmission completion of
    corresponding aBufIdx.

    @behavior Sync, Non-reentrant

    @pre describe any pre-condition (expectation before calling this function)

    @param[in]   aCtrlIdx    Controller index in the context of NIF
    @param[in]   aBufIdx     Packet buffer index

    @return void

    @post describe post condition (status after execution of the function)

    @trace #BRCM_SWREQ_NIF_INIT
*/
typedef void (*NIF_TxDoneClientCbType)(NIF_CntrlIDType aCtrlIdx,
                                       uint32_t aBufIdx);

/**
    @name NIF controller type
    @{

    @trace #BRCM_SWREQ_NIF_INIT
*/
typedef uint32_t NIF_EthCntrlrType;          /**< @brief Controller type */
#define NIF_ETHCNTRLR_WIRED           (0UL)  /**< @brief Wired ethernet */
#define NIF_ETHCNTRLR_WIRELESS        (1UL)  /**< @brief Wireless ethernet */
/** @} */

/**
    @brief NIF controller index

    @trace #BRCM_SWREQ_NIF_INIT
 */
typedef uint32_t NIF_EthCntrlrIdxType;

/**
    @brief NIF common client callback table configuration

    This is the common callback configuration table for all the NIF client
    that are to be registered with NIF.

    @trace #BRCM_SWREQ_NIF_INIT
 */
typedef struct sNIF_CmnCbTblType {
    NIF_ClientIDType             clientID;           /**< @brief Client ID */
    ETHER_EtherType              etherType;          /**< @brief Ether type */
    NIF_CntrlrValType            cntrlIndex;         /**< @brief Controller type and index */
    NIF_RxClientCbType           rxCb;               /**< @brief Rx callback function */
    NIF_TxDoneClientCbType       txCb;               /**< @brief Tx callback function */
} NIF_CmnCbTblType;

/** @brief Get transmit buffer

    This function is used by NIF to get a free TX buffer.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aID         Ethernet controller ID
    @param[in]      aPriority   Priority of TX packet
    @param[out]     aBufIdx     Buffer index
    @param[out]     aBuf        Pointer to TX buffer
    @param[inout]   aLenInout   Length of the requested buffer (in),
                                Length of the allocated buffer (out)

    @return     As returned by the hooked function

    @post None

    @trace #BRCM_SWREQ_NIF_INIT

    @limitations None
*/
typedef int32_t (*NIF_EthGetTxBufferType)(ETHER_HwIDType aID, ETHER_PrioType aPriority,
                                          uint32_t *const aBufIdx, uint8_t **const aBuf,
                                          uint32_t *const aLenInOut);

/** @brief Send transmit buffer

    This function is used by NIF to send TX buffer over ethernet.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aID                 Ethernet controller ID
    @param[in]      aTxConfirmation     TX confirmation flag
                                        - 1UL: Ethernet driver gives the callback
                                        notification with the registered callback
                                        when the packet is sent. (The packet
                                        buffer is not released until the
                                        callback returns)
                                        - 0UL: No callback provided by driver
                                        when packet is sent
    @param[in]      aBufIdx             Buffer index (received by calling
                                    #ETHER_GetTxBuffer)
    @param[in]      aLen                Length of the data in bytes. If this API
                                        is called with aLen as zero, the packet
                                        is not transmitted, instead the buffer
                                        (as given by aBufIdx) is returned back
                                        to the Ethernet driver.
    @param[in]      aDestMacAddr        Pointer to destination MAC address

    @return   As returned by the hooked function

    @post None

    @trace #BRCM_SWREQ_NIF_INIT

    @limitations None
*/
typedef int32_t (*NIF_EthSendType)(ETHER_HwIDType aID, uint32_t aTxConfirmation,
                                   uint32_t aBufIdx, uint32_t aLen,
                                   const uint8_t *const aDestMacAddr);

/** @brief Get MAC address

    This function is used by NIF to get the ethernet MAC address.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aID         Ethernet controller ID
    @param[out]     aMacAddr    Pointer to MAC address

    @return     As returned by the hooked function

    @post None

    @trace #BRCM_SWREQ_NIF_INIT

    @limitations None
*/
typedef int32_t (*NIF_EthGetMacAddrType)(ETHER_HwIDType aID, uint8_t *const aMacAddr);

/** @brief Ethernet set mode

    This function is used by NIF to set the ethernet mode.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aID         Ethernet controller ID
    @param[in]      aMode       Mode to be set

    @return     As returned by the hooked function

    @post None

    @trace #BRCM_SWREQ_NIF_INIT

    @limitations None
*/
typedef int32_t (*NIF_EthSetModeType)(ETHER_HwIDType aID, ETHER_ModeType aMode);

/** @brief Ethernet get mode

    This function is used by NIF to get the ethernet mode.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aID         Ethernet controller ID
    @param[out]     aMode       Pointer to retrieve mode

    @return     As returned by the hooked function

    @post None

    @trace #BRCM_SWREQ_NIF_INIT

    @limitations None
*/
typedef int32_t (*NIF_EthGetModeType)(ETHER_HwIDType aID, ETHER_ModeType *const aMode);

/**
    @brief NIF common ethernet controller function table configuration

    This is the common callback configuration table for the ethernet controllers
    that are to be registered with NIF.

    @trace #BRCM_SWREQ_NIF_INIT
 */
typedef struct sNIF_CmnEthIntfType {
    NIF_EthGetTxBufferType getTxBuf;                /**< @brief Get Tx buffer */
    NIF_EthSendType sendTxBuf;                      /**< @brief Send Tx buffer */
    NIF_EthGetMacAddrType getMacAddr;               /**< @brief Get MAC address */
    NIF_EthSetModeType setMode;                     /**< @brief Set mode */
    NIF_EthGetModeType getMode;                     /**< @brief Get mode */
} NIF_CmnEthIntfType;

/**
    @brief NIF common controller configuration table

    NIF common controller configuration table.

    @trace #BRCM_SWREQ_NIF_INIT
 */
typedef struct sNIF_CmnCtrlCfgType {
    ETHER_HwIDType hwIdx;                           /**< @brief Physical controller index */
    const NIF_CmnCbTblType *const cmnCbTbl;         /**< @brief Client callback table */
    const uint32_t cmnCbTblSize;                    /**< @brief Client callback table size */
    const NIF_ClientIDType *const streamTbl;        /**< @brief Client streams table */
    const uint32_t streamTblSize;                   /**< @brief Client streams table size */
    const NIF_CmnEthIntfType *const cmnEthIntfTbl;  /**< @brief Ethernet interface table */
    const uint32_t cmnEthIntfTblSize;               /**< @brief Ethernet interface table size */
    const NIF_CmnEthIntfType *const cmnWlEthIntfTbl;/**< @brief WL Ethernet interface table */
    const uint32_t cmnWlEthIntfTblSize;             /**< @brief WL Ethernet interface table size */
} NIF_CmnCtrlCfgType;

/**
    @brief NIF common configuration

    NIF common configuration.

    @trace #BRCM_SWREQ_NIF_INIT
 */
typedef struct sNIF_CmnCfgType {
    const NIF_CmnCtrlCfgType *const cmnCtrlCfg;       /**< @brief Controller config */
} NIF_CmnCfgType;

/** @brief NIF Initializiation

    This API initializes Ethernet system layer which is interfaced by NIF.

    @behavior Sync, Non-reentrant

    @pre describe any pre-condition (expectation before calling this function)

    @param[in]       void

    @retval          #BCM_ERR_INVAL_PARAMS    aConfig is NULL
    @retval          #BCM_ERR_INVAL_PARAMS    Invalid configuration
    @retval          #BCM_ERR_INVAL_STATE     NIF is already initialised

    @post describe post condition (status after execution of the function)

    @trace #BRCM_SWREQ_NIF_INIT

    @limitations Ethernet driver, switch driver and transceiver drivers shall
    be initialised by system outside the scope of Ethernet system
    layer
*/
extern int32_t NIF_Init(void);

/** @brief Get NIF controller index

    This API retrieves controller index in the context of NIF.
    Controller index is based on the physical controller and VLANs in
    which that physical controller is participating.

    @behavior Sync, Reentrant

    @pre describe any pre-condition (expectation before calling this function)

    @param[in]       aVlanID                 VLAN ID in which physical controller
                                             is participating
    @param[in]       aCompID                 Component identifier
    @param[in]       aInstID                 Instance identifier
    @param[out]      aCtrlIdx                Pointer to retrieve controller index

    @retval          #BCM_ERR_OK              Controller indexes retrieved
                                              successfully
    @retval          #BCM_ERR_INVAL_PARAMS    aCtrlIdx is NULL
    @retval          #BCM_ERR_INVAL_PARAMS    aCtrlIdxNum is NULL
    @retval          #BCM_ERR_UNINIT          EthSys is not initialised
    @retval          #BCM_ERR_NOT_FOUND       No controller index found for the

    @post describe post condition (status after execution of the function)

    @trace #BRCM_SWREQ_NIF_TRANSMIT
*/
extern int32_t NIF_GetCtrlIdx(ETHER_VLANIDType aVlanID,
                              uint16_t aCompID,
                              uint8_t aInstID,
                              NIF_CntrlIDType *const aCtrlIdx);

/** @brief Set NIF controller mode

    This API sets the NIF controller mode.

    @behavior Sync, Non-reentrant

    @pre describe any pre-condition (expectation before calling this function)

    @param[in]       aCtrlIdx                Controller index in the context
                                             of NIF.
    @param[in]       aMode                   Mode to be set

    @retval          #BCM_ERR_OK              Mode set successfully
    @retval          #BCM_ERR_INVAL_PARAMS    Invalid controller index
    @retval          #BCM_ERR_INVAL_PARAMS    Invalid controller mode
    @retval          #BCM_ERR_UNINIT          NIF is not initialised

    @post describe post condition (status after execution of the function)

    @trace #BRCM_SWREQ_NIF_INIT
*/
extern int32_t NIF_SetCtrlMode(NIF_CntrlIDType aCtrlIdx,
                               ETHER_ModeType aMode);

/** @brief Get NIF controller mode

    This API retrieves the NIF controller mode configured.

    @behavior Sync, Reentrant

    @pre describe any pre-condition (expectation before calling this function)

    @param[in]       aCtrlIdx                Controller index in the context
                                             of NIF
    @param[out]      aMode                   Pointer to retrieve mode

    @retval          #BCM_ERR_OK              Mode retrieved successfully
    @retval          #BCM_ERR_INVAL_PARAMS    Invalid controller index
    @retval          #BCM_ERR_INVAL_PARAMS    aMode is NULL
    @retval          #BCM_ERR_UNINIT          NIF is not initialised

    @post describe post condition (status after execution of the function)

    @trace #BRCM_SWREQ_NIF_QUERY
*/
extern int32_t NIF_GetCtrlMode(NIF_CntrlIDType aCtrlIdx,
                               ETHER_ModeType *const aMode);

/** @brief Get MAC address

    This API retrieves MAC address of the controller.

    @behavior Sync, Reentrant

    @pre describe any pre-condition (expectation before calling this function)

    @param[in]       aCtrlIdx                Controller index in the context
                                             of NIF
    @param[out]      aMacAddr                Pointer to retrieve MAC address

    @retval          #BCM_ERR_OK              MAC address is retrieved successfully
    @retval          #BCM_ERR_INVAL_PARAMS    Invalid controller index
    @retval          #BCM_ERR_INVAL_PARAMS    aMacAddr is NULL
    @retval          #BCM_ERR_UNINIT          NIF is not initialised

    @post describe post condition (status after execution of the function)

    @trace #BRCM_SWREQ_NIF_QUERY
*/
extern int32_t NIF_GetMacAddr(NIF_CntrlIDType aCtrlIdx,
                              uint8_t *const aMacAddr);

/** @brief Get VLAN ID

    This API retrieves VLAN ID of the controller.

    @behavior Sync, Reentrant

    @pre describe any pre-condition (expectation before calling this function)

    @param[in]       aCtrlIdx                Controller index in the context
                                             of NIF
    @param[out]      aVlanID                 Pointer to retrieve VLAN ID

    @retval          #BCM_ERR_OK              VLAN ID retrieved successfully
    @retval          #BCM_ERR_INVAL_PARAMS    Invalid controller index
    @retval          #BCM_ERR_INVAL_PARAMS    aVlanID is NULL
    @retval          #BCM_ERR_UNINIT          NIF is not initialised
    @retval          #BCM_ERR_NOT_FOUND       No VLAN ID configured for this
                                             controller index
    @post describe post condition (status after execution of the function)

    @trace #BRCM_SWREQ_NIF_QUERY
*/
extern int32_t NIF_GetVlanID(NIF_CntrlIDType aCtrlIdx,
                             ETHER_VLANIDType *const aVlanID);

/** @brief Get empty transmit buffer

    This API provides an empty transmit buffer.

    @behavior Sync, Reentrant

    @pre describe any pre-condition (expectation before calling this function)

    @param[in]       aCtrlIdx                Controller index in the context
                                             of NIF
    @param[in]       aEtherType              Ether type
    @param[in]       aPriority               Priority value which shall be used
                                             for the 3-bit PCP field of the VLAN
                                             tag
    @param[out]      aBufIdx                 Pointer to retrieve buffer index
    @param[out]      aBuf                    Pointer to retrieve buffer pointer
    @param[inout]    aLenInout               Length of the requested buffer (in),
                                             Length of the allocated buffer (out)

    @retval          #BCM_ERR_OK              TX buffer successfully obtained
    @retval          #BCM_ERR_INVAL_PARAMS    Invalid controller index
    @retval          #BCM_ERR_INVAL_PARAMS    Invalid Ether type
    @retval          #BCM_ERR_INVAL_PARAMS    Invalid priority
    @retval          #BCM_ERR_INVAL_PARAMS    aBufIdx is NULL
    @retval          #BCM_ERR_INVAL_PARAMS    aBuf is NULL
    @retval          #BCM_ERR_INVAL_PARAMS    aLenInOut is NULL
    @retval          #BCM_ERR_NOMEM           No TX buffers are available
    @retval          #BCM_ERR_INVAL_STATE     Invalid controller state
    @retval          #BCM_ERR_UNINIT          NIF is not initialised

    @post describe post condition (status after execution of the function)

    @trace #BRCM_SWREQ_NIF_TRANSMIT
*/
extern int32_t NIF_GetTxBuffer(NIF_CntrlIDType aCtrlIdx,
                               ETHER_EtherType aEtherType,
                               ETHER_PrioType aPriority,
                               uint32_t *const aBufIdx,
                               uint8_t **const aBuf,
                               uint32_t *const aLenInOut);

/** @brief Send Ethernet packet

    This API enqueues an Ethernet packet to be sent.

    @behavior Sync, Reentrant

    @pre describe any pre-condition (expectation before calling this function)

    @param[in]       aCtrlIdx                Ethernet controller index in the
                                             context of NIF
    @param[in]       aEtherType              Ether type
    @param[in]       aIsTxConfEnable         TX confirmation enable flag
    @param[in]       aBufIdx                 Buffer index (received by calling
                                             ETHER_GetTxBuffer())
    @param[in]       aLen                    Length of the data to be sent in bytes
    @param[in]       aDestMacAddr            Pointer to destination MAC address

    @retval          #BCM_ERR_OK              TX buffer successfully obtained
    @retval          #BCM_ERR_INVAL_PARAMS    Invalid controller index
    @retval          #BCM_ERR_INVAL_PARAMS    Invalid Ether type
    @retval          #BCM_ERR_INVAL_PARAMS    Invalid priority
    @retval          #BCM_ERR_INVAL_PARAMS    aBufIdx is NULL
    @retval          #BCM_ERR_INVAL_PARAMS    aBuf is NULL
    @retval          #BCM_ERR_INVAL_PARAMS    aLenInOut is NULL
    @retval          #BCM_ERR_NOMEM           No TX buffers are available
    @retval          #BCM_ERR_INVAL_STATE     Invalid controller state
    @retval          #BCM_ERR_UNINIT          NIF is not initialised

    @post describe post condition (status after execution of the function)

    @trace #BRCM_SWREQ_NIF_TRANSMIT
*/
extern int32_t NIF_Send(NIF_CntrlIDType aCtrlIdx,
                        ETHER_EtherType aEtherType,
                        uint32_t aIsTxConfEnable,
                        uint32_t aBufIdx,
                        uint32_t aLen,
                        const uint8_t *const aDestMacAddr);

/** @brief Enable Timestamping for transmit packet

    This API enables timestamping for a particular transmit buffer.

    @behavior Sync, Reentrant

    @pre describe any pre-condition (expectation before calling this function)

    @param[in]       aCtrlIdx                Controller index in the context
                                             of NIF
    @param[in]       aBufIdx                 Buffer index

    @retval          #BCM_ERR_OK              Successfully enabled timestamp for
                                              the given buffer index
    @retval          #BCM_ERR_INVAL_PARAMS    Invalid controller index
    @retval          #BCM_ERR_INVAL_PARAMS    Invalid channel
    @retval          #BCM_ERR_INVAL_PARAMS    Invalid buffer index
    @retval          #BCM_ERR_INVAL_STATE     Invalid controller state
    @retval          #BCM_ERR_INVAL_BUF_STATE Invalid packet buffer state
    @retval          #BCM_ERR_UNINIT          NIF is not initialised

    @post describe post condition (status after execution of the function)

    @trace #BRCM_SWREQ_NIF_TIME
*/
extern int32_t NIF_EnableTxTimestamp(NIF_CntrlIDType aCtrlIdx,
                                     uint32_t aBufIdx);

/** @brief Find stream index

    @behavior Sync, Reentrant

    @pre describe any pre-condition (expectation before calling this function)

    @param[in]       aClientID               Client ID
    @param[in]       aStreamIdx              Pointer to stream index

    @retval          #BCM_ERR_OK                On success
    @retval          #BCM_ERR_NOT_FOUND         aClientID is invalid

    @post describe post condition (status after execution of the function)

    @trace #BRCM_SWREQ_NIF_STREAM_SHAPING
*/
extern int32_t  NIF_FindStreamIdx(NIF_ClientIDType aClientID,
                                  uint32_t *const aStreamIdx);

#endif /* NIF_H */
/** @} */
