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
    @addtogroup grp_ethswt_il
    @{

    @file ethswt_common_osil.h
    @brief Ethernet switch driver common Integration Interfaces

    @version 0.51 Imported from docx
*/
#ifndef ETHSWT_COMMON_OSIL_H
#define ETHSWT_COMMON_OSIL_H

#include <svc.h>
#include <ethswt_common.h>
/**
    @name Ethernet Switch Driver interface IDs
    @{
    @brief API IDs for thernet Switch Driver
*/
#define BRCM_SWARCH_ETHSWT_IO_CMD_TYPE              (0x9501U)    /**< @brief #ETHSWT_IOCmdType      */
#define BRCM_SWARCH_ETHSWT_MGMT_INFO_IND_PROC       (0x9502U)    /**< @brief #ETHSWT_MgmtInfoInd    */
#define BRCM_SWARCH_ETHSWT_TX_ADAPT_BUF_PROC        (0x9503U)    /**< @brief #ETHSWT_TxAdaptBuffer  */
#define BRCM_SWARCH_ETHSWT_TX_PROCESS_FRAME_PROC    (0x9504U)    /**< @brief #ETHSWT_TxProcessFrame */
#define BRCM_SWARCH_ETHSWT_TX_DONE_IND_PROC         (0x9505U)    /**< @brief #ETHSWT_TxDoneInd      */
#define BRCM_SWARCH_ETHSWT_RX_PROCESS_FRAME_PROC    (0x9506U)    /**< @brief #ETHSWT_RxProcessFrame */
#define BRCM_SWARCH_ETHSWT_RX_DONE_IND_PROC         (0x9507U)    /**< @brief #ETHSWT_RxDoneInd      */
#define BRCM_SWARCH_ETHSWT_IO_TYPE                  (0x9508U)    /**< @brief #ETHSWT_IOType         */
#define BRCM_SWARCH_ETHSWT_SYS_CMD_REQ_PROC         (0x9509U)    /**< @brief #ETHSWT_SysCmdReq      */
#define BRCM_SWARCH_ETHSWT_SYS_CMD_HANDLER_PROC     (0x950AU)    /**< @brief #ETHSWT_SysCmdHandler  */
#define BRCM_SWARCH_ETHSWT_CMD_HANDLER_PROC         (0x950BU)    /**< @brief #ETHSWT_CmdHandler     */
#define BRCM_SWARCH_ETHSWT_TX_TS_IND_PROC           (0x950CU)    /**< @brief #ETHSWT_TxTSInd        */
#define BRCM_SWARCH_ETHSWT_RX_TS_IND_PROC           (0x950DU)    /**< @brief #ETHSWT_RxTSInd        */
#define BRCM_SWARCH_ETHSWT_STATE_TYPE               (0x950EU)    /**< @brief #ETHSWT_StateType      */
#define BRCM_SWARCH_ETHSWT_GET_STATE_PROC           (0x950FU)    /**< @brief #ETHSWT_GetState       */
/** @} */

/**
    @name Ethernet Switch IO Command type
    @{
    @brief Ethernet switch driver system command type

    @trace #BRCM_SWREQ_ETHSWT_KERNEL_INTERFACE
*/
typedef uint32_t ETHSWT_IOCmdType;
#define ETHSWT_IO_CMD_INIT                      (0x00UL)
#define ETHSWT_IO_CMD_SET_MGMT_INFO             (0x01UL)
#define ETHSWT_IO_CMD_TX_ADAPT_BUFFER           (0x02UL)
#define ETHSWT_IO_CMD_TX_PROCESS_FRAME          (0x03UL)
#define ETHSWT_IO_CMD_TX_DONE_IND               (0x04UL)
#define ETHSWT_IO_CMD_TX_DONE_IND_COMPLETE      (0x05UL)
#define ETHSWT_IO_CMD_RX_PROCESS_FRAME          (0x06UL)
#define ETHSWT_IO_CMD_RX_DONE_IND               (0x07UL)
#define ETHSWT_IO_CMD_RX_DONE_IND_COMPLETE      (0x08UL)
#define ETHSWT_IO_CMD_GET_DUMBFWD_MODE          (0x09UL)
#define ETHSWT_IO_CMD_SET_DUMBFWD_MODE          (0x0AUL)
#define ETHSWT_IO_CMD_SET_PORT_ROLE             (0x0BUL)
#define ETHSWT_IO_CMD_SET_SWITCH_TYPE           (0x0CUL)
#define ETHSWT_IO_CMD_READ_REG                  (0x0DUL)
#define ETHSWT_IO_CMD_WRITE_REG                 (0x0EUL)
#define ETHSWT_IO_CMD_ENABLE_TX_TIMESTAMP       (0x0FUL)
#define ETHSWT_IO_CMD_GET_MGMT_MODE             (0x10UL)
#define ETHSWT_IO_CMD_SET_MGMT_MODE             (0x11UL)
#define ETHSWT_IO_CMD_GET_BRCMHDR_MODE          (0x12UL)
#define ETHSWT_IO_CMD_SET_BRCMHDR_MODE          (0x13UL)
#define ETHSWT_IO_CMD_ENABLE_BH_SHIFT           (0x14UL)
#define ETHSWT_IO_CMD_ENABLE_RX                 (0x15UL)
#define ETHSWT_IO_CMD_DISABLE_RX                (0x16UL)

/* ARL commands: add newer commands at the end */
#define ETHSWT_IO_CMD_GET_PORT_MAC_ADDR         (0x20UL)
#define ETHSWT_IO_CMD_SET_MACLEARNING_MODE      (0x21UL)
#define ETHSWT_IO_CMD_GET_MACLEARNING_MODE      (0x22UL)
#define ETHSWT_IO_CMD_GET_ARL_TABLE             (0x23UL)
#define ETHSWT_IO_CMD_SET_AGE                   (0x24UL)
#define ETHSWT_IO_CMD_GET_AGE                   (0x25UL)
#define ETHSWT_IO_CMD_ADD_ARL_ENTRY             (0x26UL)
#define ETHSWT_IO_CMD_DELETE_ARL_ENTRY          (0x27UL)
#define ETHSWT_IO_CMD_ADD_ARL_MYDA_ENTRY        (0x28UL)
#define ETHSWT_IO_CMD_DELETE_ARL_MYDA_ENTRY     (0x29UL)
#define ETHSWT_IO_CMD_GET_ARL_MYDA_SNAPSHOT     (0x2AUL)
#define ETHSWT_IO_CMD_SET_STATION_MOVE_DETECT   (0x2BUL)
#define ETHSWT_IO_CMD_GET_STATION_MOVE_DETECT   (0x2CUL)
#define ETHSWT_IO_CMD_SET_ADDRESS_LIMITING      (0x2DUL)
#define ETHSWT_IO_CMD_GET_ADDRESS_LIMITING      (0x2EUL)
#define ETHSWT_IO_CMD_SET_TOTAL_ADDRESS_LIMIT   (0x2FUL)
#define ETHSWT_IO_CMD_GET_TOTAL_ADDRESS_LIMIT   (0x30UL)
#define ETHSWT_IO_CMD_SET_STICKY_MAC_ADDRESS    (0x31UL)
#define ETHSWT_IO_CMD_GET_STICKY_MAC_ADDRESS    (0x32UL)

/* VLAN commands: add newer commands at the end */
#define ETHSWT_IO_CMD_ENABLE_VLAN               (0x40UL)
#define ETHSWT_IO_CMD_GET_VLAN_PORTS            (0x41UL)
#define ETHSWT_IO_CMD_ADD_VLAN_PORT             (0x42UL)
#define ETHSWT_IO_CMD_REMOVE_VLAN_PORT          (0x43UL)
#define ETHSWT_IO_CMD_GET_PORT_DEFAULT_VLAN     (0x44UL)
#define ETHSWT_IO_CMD_SET_PORT_DEFAULT_VLAN     (0x45UL)
#define ETHSWT_IO_CMD_SET_VLAN_IFILTER_MODE     (0x46UL)
#define ETHSWT_IO_CMD_GET_VLAN_IFILTER_MODE     (0x47UL)
#define ETHSWT_IO_CMD_SET_VLAN_HOPPING_DETECT   (0x48UL)
#define ETHSWT_IO_CMD_GET_VLAN_HOPPING_DETECT   (0x49UL)

/* Mirror commands: add newer commands at the end */
#define ETHSWT_IO_CMD_SET_PORT_MIRROR_CFG       (0x50UL)
#define ETHSWT_IO_CMD_GET_PORT_MIRROR_CFG       (0x51UL)
#define ETHSWT_IO_CMD_SET_PORT_MIRROR_MODE      (0x52UL)
#define ETHSWT_IO_CMD_GET_PORT_MIRROR_MODE      (0x53UL)
#define ETHSWT_IO_CMD_GET_MIRROR_CAPTURE_PORT   (0x54UL)
#define ETHSWT_IO_CMD_GET_RX_STAT               (0x55UL)
#define ETHSWT_IO_CMD_GET_TX_STAT               (0x56UL)
#define ETHSWT_IO_CMD_CLEAR_RX_STAT             (0x57UL)
#define ETHSWT_IO_CMD_CLEAR_TX_STAT             (0x58UL)
#define ETHSWT_IO_CMD_SET_LED_STATE             (0x59UL)
#define ETHSWT_IO_CMD_GET_LED_STATE             (0x5AUL)

#define ETHSWT_IO_CMD_SET_JUMBO_MODE            (0x60UL)
#define ETHSWT_IO_CMD_GET_JUMBO_MODE            (0x61UL)
#define ETHSWT_IO_CMD_GET_XCVR_STATS            (0x62UL)
#define ETHSWT_IO_CMD_GET_LINKSTATE             (0x63UL)
#define ETHSWT_IO_CMD_LINK_STATE_CHANGE_HDLR    (0x64UL)

/* CFP commands: add newer commands at the end */
#define ETHSWT_IO_CMD_CFP_INIT                  (0x70UL)
#define ETHSWT_IO_CMD_CFP_ADDRULE               (0x71UL)
#define ETHSWT_IO_CMD_CFP_REMOVERULE            (0x72UL)
#define ETHSWT_IO_CMD_CFP_UPDATERULE            (0x73UL)
#define ETHSWT_IO_CMD_CFP_GETSTATS              (0x74UL)
#define ETHSWT_IO_CMD_CFP_GETSNAPSHOT           (0x75UL)
#define ETHSWT_IO_CMD_CFP_GETROWCONFIG          (0x76UL)
#define ETHSWT_IO_CMD_CFP_ENABLEPORT            (0x77UL)
#define ETHSWT_IO_CMD_CFP_DISABLEPORT           (0x78UL)
#define ETHSWT_IO_CMD_CFP_DEINIT                (0x7AUL)

/* Flow Accelerator */
#define ETHSWT_IO_CMD_FA_INIT                    (0x90UL)
#define ETHSWT_IO_CMD_FA_DEINIT                  (0x91UL)
#define ETHSWT_IO_CMD_FA_FLOWADD                 (0x92UL)
#define ETHSWT_IO_CMD_FA_FLOWDELETE              (0x93UL)
#define ETHSWT_IO_CMD_FA_FLOWGET                 (0x94UL)
#define ETHSWT_IO_CMD_FA_STATS                   (0x95UL)
#define ETHSWT_IO_CMD_FA_TIMER                   (0x96UL)
#define ETHSWT_IO_CMD_FA_MAC_ADD                 (0x97UL)
#define ETHSWT_IO_CMD_FA_MAC_DELETE              (0x98UL)
#define ETHSWT_IO_CMD_FA_MAC_POOL_GET            (0x99UL)
#define ETHSWT_IO_CMD_FA_ENABLE_INTERRUPT        (0x9AUL)
#define ETHSWT_IO_CMD_FA_START                   (ETHSWT_IO_CMD_FA_INIT)
#define ETHSWT_IO_CMD_FA_END                     (ETHSWT_IO_CMD_FA_ENABLE_INTERRUPT)

/* Misc commands */
#define ETHSWT_IO_CMD_EXT_CONFIG                  (0x100UL)
#define ETHSWT_IO_CMD_PORT_SHAPER_CONFIG          (0x101UL)

/** @} */

/**
    @brief Ethernet switch IO structure

    @trace #BRCM_SWREQ_ETHSWT_KERNEL_INTERFACE
 */
typedef struct sETHSWT_IOType {
    int32_t                     retVal;             /**< @brief Return value */
    ETHSWT_HwIDType             swtHwID;            /**< @brief Switch hardware
                                                         index */
    ETHSWT_PortIDType           portHwID;           /**< @brief Port hardware
                                                         index */
    struct sETHSWT_ARLIOType    *arlIO;             /**< @brief ARL IO Type */
    struct sETHSWT_VLANIOType   *vlanIO;            /**< @brief VLAN IO Type*/
    struct sETHSWT_CFPIOType    *cfpIO;             /**< @brief CFP IO Type */
    struct sETHSWT_DbgIOType    *dbgIO;             /**< @brief DBG IO Type */
    struct sETHSWT_XcvrIOType   *xcvrIO;            /**< @brief XCVR IO Type*/
    struct sETHSWT_ExtIOType   *extIO;            /**< @brief MISC IO Type*/
    struct sETHSWT_FAIOType     *faIO;              /**< @brief FA IO Type */

    uint32_t                    mode;               /**< @brief Switch mode */
    uint64_t                    *regVal;            /**< @brief Pointer to
                                                         register value */
    uint32_t                    regAddr;            /**< @brief Register
                                                         Address */
    uint32_t                    enable;             /**< @brief Enable flag */
    ETHER_HwIDType              ctrlHwID;           /**< @brief Controller
                                                         hardware index */
    uint32_t                    bufIdx;             /**< @brief Buffer index */
    ETHSWT_MgmtInfoType         *mgmtInfo;          /**< @brief Pointer to
                                                         management information
                                                         */
    const ETHSWT_MgmtInfoType   *mgmtInfoIn;        /**< @brief Pointer to
                                                         management information
                                                         */
    uint32_t                    *port2TimeFifoMap;  /**< @brief Pointer to Switch port - time FIFO map */
    uint8_t                     **data;             /**< @brief Pointer to a pointer to data*/
    uint32_t                    *len;               /**< @brief Pointer to length */
    uint32_t                    *isMgmtFrameOnly;   /**< @brief Pointer to MgmtFrameOnly value */
    ETHER_TimestampType         *ts;                /**< @brief Pointer to timestamp */
    ETHER_TimestampQualType     *tsQual;            /**< @brief Pointer to timestamp Qual*/
    uint32_t                    tsAvailable;        /**< @brief Timestamp available */
    const uint8_t               *buf;               /**< @brief Pointer to buffer */
    ETHSWT_SwitchType           swtType;            /**< @brief Switch type */
    ETHSWT_PortType             portRole;           /**< @brief Port role */
    uint32_t                    portCnt;            /**< @brief Port count */
    uint32_t                    portMap[ETHSWT_PORT_ID_MAX]; /**< @brief Port map */
} ETHSWT_IOType;

/** @brief Raise a command request

    This interface raises a command request to the Ethernet switch driver.

    @behavior Sync, Re-entrant

    @pre TBD

    @param[in]]     aCmd        Command requested by user
    @param[inout]   aIO         Pointer to in-Out structure containing request
                                parameters

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Command raised successfully
    @retval     #BCM_ERR_INVAL_MAGIC    Invalid SVC magic
    @return     Others                  As returned by #ETHSWT_CmdHandler
    @retval     #BCM_ERR_UNKNOWN        Integration error

    @post TBD

    @note This interface shall be implemented by the integrator.

    @trace  #BRCM_SWREQ_ETHSWT_KERNEL_INTERFACE

    @limitations None
*/
extern int32_t ETHSWT_SysCmdReq(ETHSWT_IOCmdType aCmd, ETHSWT_IOType *const aIO);

/** @brief Handle all the Ethernet switch driver commands requested

    This interface handles all the Ethernet switch driver commands requested
    from System command request.

    @behavior Sync, Non-reentrant

    @pre TBD

    @param[in]      aMagicID    Ethernet switch driver SVC magic ID
    @param[in]      aCmd        Command requested from system command handler
    @param[inout]   aSysIO      uint8_t * to be interpreted as ETHSWT_IOType

    @return     void

    @post TBD

    @note This interface shall be implemented by the integrator and shall
    install it to SVC layer.

    @trace  #BRCM_SWREQ_ETHSWT_KERNEL_HANDLER

    @limitations None
*/
extern void ETHSWT_SysCmdHandler(uint32_t aMagicID, uint32_t aCmd,
        uint8_t * aSysIO);

/** @brief Internal command handler

    This interface handles all the commands requested from system command
    handler.

    @behavior Sync, Re-entrant

    @pre TBD

    @param[in]      aCmd        Command requested by user
    @param[inout]   aIO         Pointer to in-Out structure containing request
                                parameters

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Command processed successfully
    @retval     #BCM_ERR_UNKNOWN        aIO is NULL
    @retval     #BCM_ERR_INVAL_PARAMS   Invalid command
    @return     Others                  Error value specific to the requested
                                        command

    @post TBD

    @note This interface shall be called from #ETHSWT_SysCmdHandler.

    @trace  #BRCM_SWREQ_ETHSWT_KERNEL_HANDLER

    @limitations any limitations for this api

    @snippet switch_osil.c Usage of ETHSWT_CmdHandler
*/
extern int32_t ETHSWT_CmdHandler(ETHSWT_IOCmdType aCmd, ETHSWT_IOType * const aIO);

/**
    @trace #BRCM_SWREQ_ETHSWT_KERNEL_INTERFACE
*/
extern volatile struct COMP_PACKED sSWITCH_RDBType *const ETHSWT_Regs;

/**
    @name Switch state IDs
    @{
    @brief Switch state types

    @trace #BRCM_SWREQ_ETHSWT_KERNEL_INTERFACE
*/
typedef uint32_t ETHSWT_StateType;
#define ETHSWT_STATE_UNINIT       (0UL) /**< @brief value must be zero*/
#define ETHSWT_STATE_INIT         (1UL)
/** @} */

/**
    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION
*/
ETHSWT_StateType ETHSWT_GetState(ETHSWT_HwIDType aSwtID);

/** @brief  Switch Management information call back

    Switch Management information call back from switch driver for Rx buffer
    received.

    @behavior Sync, Re-entrant

    @pre TBD

    @param[in]      aCntrlID    Index of Ethernet controller
    @param[in]      aData       Pointer to data buffer
    @param[inout]   aMgmtInfo   Pointer to management information

    @return     void

    @post TBD

    @note This interface shall be implemented by the integrator.

    @trace  #BRCM_SWREQ_ETHSWT_INDICATIONS

    @limitations any limitations for this api
*/
extern void ETHSWT_MgmtInfoInd(ETHER_HwIDType aCntrlID,
        const uint8_t *const aData,
        const ETHSWT_MgmtInfoType *const aMgmtInfo);

/** @brief Adapt the transmit buffer

    This API adapts the transmit buffer and prepare for addition of management
    information.

    @behavior Sync, Re-entrant

    @pre TBD

    @param[in]      aArg1       Brief description of aArg1
    @param[in]      aCntrlID    Index of the Ethernet controller
    @param[in]      aBufIdx     Ethernet buffer index
    @param[inout]   aDataInOut  - In: Pointer to the position of the EthType in
                                  common Ethernet frame
                                - Out: Pointer to the position of the EthType in
                                  management frame
    @param[inout]   aLenInOut   - In: Size of the Ethernet frame without
                                  management information
                                - Out: Size of the Ethernet frame with
                                  management information

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK                 Successfully adapted transmit buffer
    @retval     #BCM_ERR_INVAL_BUF_STATE    Ethernet buffer is in invalid state
    @retval     #BCM_ERR_INVAL_PARAMS       (aLenInOut is NULL) or
                                            (aDataInOut points to a NULL pointer) or
                                            (aDataInOut is NULL) or
                                            (Invalid buffer index) or
                                            (aLenInOut is NULL)
    @retval     #BCM_ERR_UNINIT             Ethernet switch driver is not
                                            initialized

    @post TBD

    @note TBD
    @todo Explain how to use this interface (or where to be called from)

    @trace  #BRCM_SWREQ_ETHSWT_MANAGEMENT

    @limitations None
*/
extern int32_t ETHSWT_TxAdaptBuffer(ETHER_HwIDType aCntrlID,
        uint32_t aBufIdx,
        uint8_t **const aDataInOut,
        uint32_t * const aLenInOut);

/** @brief Process transmit frame

    This API processes transmit frame to add management information.

    @behavior Sync, Re-entrant

    @pre TBD

    @param[in]      aArg1       Brief description of aArg1
    @param[in]      aCntrlID    Index of the Ethernet controller
    @param[in]      aBufIdx     Ethernet buffer index
    @param[inout]   aDataInOut  - In: Pointer to the position of the EthType in
                                  common Ethernet frame
                                - Out: Pointer to the position of the EthType in
                                  management frame
    @param[inout]   aLenInOut   - In: Size of the Ethernet frame without
                                  management information
                                - Out: Size of the Ethernet frame with
                                  management information

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK                 Successfully processed transmit
                                            frame
    @retval     #BCM_ERR_INVAL_BUF_STATE    Ethernet buffer is in invalid state
    @retval     #BCM_ERR_INVAL_PARAMS       Invalid aBufIdx
    @retval     #BCM_ERR_INVAL_PARAMS       aDataInOut is NULL
    @retval     #BCM_ERR_INVAL_PARAMS       Data buffer pointer pointed by
                                            aDataInOut is  NULL
    @retval     #BCM_ERR_INVAL_PARAMS       aLenInOut is NULL
    @retval     #BCM_ERR_INVAL_PARAMS       Value pointed by aLenInOut is zero
    @retval     #BCM_ERR_UNINIT             Ethernet switch driver is not
                                            initialized

    @post TBD

    @note TBD
    @todo Explain how to use this interface (or where to be called from)

    @trace  #BRCM_SWREQ_ETHSWT_MANAGEMENT

    @limitations None
*/
extern int32_t ETHSWT_TxProcessFrame(ETHER_HwIDType aCntrlID,
        uint32_t aBufIdx,
        uint8_t ** const aDataInOut,
        uint32_t * const aLenInOut);

/** @brief Callback indication from the Ethernet driver when a management
    enabled packet transmission is completed

    This callback indication is called from the Ethernet driver when a
    management enabled packet transmission is completed and there is nothing
    more to be done on that packet. (This indication comes from the Ethernet
    driver when all the required processing for the frame is completed including
    the TX confirmation callback to the client.)

    @behavior Sync, Re-entrant

    @pre TBD

    @param[in]      aCntrlID    Index of the Ethernet controller
    @param[in]      aBufIdx      Adapted Ethernet buffer index


    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK                 Success
    @retval     #BCM_ERR_INVAL_BUF_STATE    Ethernet buffer is in invalid state
    @retval     #BCM_ERR_INVAL_PARAMS       Invalid buffer index
    @retval     #BCM_ERR_UNINIT             Ethernet switch driver is not
                                            initialized

    @post TBD

    @note TBD
    @todo Explain how to use this interface (or where to be called from)

    @trace  #BRCM_SWREQ_ETHSWT_INDICATIONS

    @limitations None
*/
extern int32_t ETHSWT_TxDoneInd(ETHER_HwIDType aCntrlID,
        uint32_t aBufIdx);

/** @brief RX process frame callback

    This RX process frame callback is called from the Ethernet driver when a
    packet arrives to extract management information.

    @behavior Sync, Re-entrant

    @pre TBD

    @param[in]      aCntrlID          Index of the Ethernet controller
    @param[in]      aBufIdx           Ethernet buffer index
    @param[inout]   aDataInOut        - In: Pointer to the EtherType in common
                                      Ethernet frame
                                      - Out: Pointer to EtherType in management frame
    @param[inout]   aLenInOut         - In: Length of the frame received
                                      - Out: Length of the frame deceased by the
                                      management information
    @param[out]     aIsMgmtFrameOnly  Set to #TRUE if its management frame only
                                      (consumed by Ethernet switch driver)

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK                 Successfully processed
    @retval     #BCM_ERR_INVAL_BUF_STATE    Ethernet buffer is in invalid state
    @retval     #BCM_ERR_INVAL_PARAMS       (Invalid buffer index) or
                                            (aDataInOut is NULL) or
                                            (aDataInOut points to a NULL pointer) or
                                            (aLenInOut in NULL) or
                                            (aLenInOut points to zero)
    @retval     #BCM_ERR_UNINIT             Ethernet switch driver is not
                                            initialized
    @post TBD

    @note TBD
    @todo Explain how to use this interface (or where to be called from)

    @trace  #BRCM_SWREQ_ETHSWT_MANAGEMENT

    @limitations None
*/
extern int32_t ETHSWT_RxProcessFrame(ETHER_HwIDType aCntrlID,
        uint32_t aBufIdx,
        uint8_t ** const aDataInOut,
        uint32_t * const aLenInOut,
        uint32_t * const aIsMgmtFrameOnly);

/** @brief RX finished callback indication

    Rx finished callback indication from the Ethernet driver. This interface
    shall raise the Rx timestamp callback to the client.

    @behavior Sync, Re-entrant

    @pre TBD

    @param[in]      aCntrlID    Index of the Ethernet controller
    @param[in]      aBufIdx     Adapted Ethernet buffer index

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK                 Success
    @retval     #BCM_ERR_INVAL_BUF_STATE    Ethernet buffer is in invalid state
    @retval     #BCM_ERR_INVAL_PARAMS       Invalid buffer index
    @retval     #BCM_ERR_UNINIT             Ethernet switch driver is not
                                            initialized

    @post TBD

    @note TBD
    @todo Explain how to use this interface (or where to be called from)

    @trace  #BRCM_SWREQ_ETHSWT_INDICATIONS

    @limitations any None
*/
extern int32_t ETHSWT_RxDoneInd(ETHER_HwIDType aCntrlID,
        uint32_t aBufIdx);

/** @brief Callback from switch driver to provide timestamp of TX packet

    This callback is raised by the switch driver to provide timestamp of
    transmitted packet.

    @behavior Sync, Re-entrant

    @pre TBD

    @param[in]      aCntrlID    Index of the Ethernet controller
    @param[in]      aBufIdx     Pointer to data buffer
    @param[in]      aMgmtInfo   Pointer to management information
    @param[in]      aTS         Pointer to packet timestamp
    @param[in]      aTSQual     Pointer to packet timestamp quality

    @return     void

    @post TBD

    @note This interface shall be implemented by the integrator.

    @trace  #BRCM_SWREQ_ETHSWT_INDICATIONS

    @limitations None
*/
extern void ETHSWT_TxTSInd(ETHER_HwIDType aCntrlID,
        uint32_t aBufIdx,
        const ETHSWT_MgmtInfoType *const aMgmtInfo,
        const ETHER_TimestampType *const aTS,
        const ETHER_TimestampQualType* const aTSQual);

/** @brief allback from switch driver to provide timestamp of RX packet

    This callback is raised by the switch driver to provide timestamp of
    received packet.

    @behavior Sync/Async, Re-entrant/Non-reentrant

    @pre TBD

    @param[in]      aArg1       Brief description of aArg1
    @param[in]      aCntrlID    Index of the Ethernet controller
    @param[in]      aData       Pointer to data buffer
    @param[in]      aMgmtInfo   Pointer to management information
    @param[in]      aTS         Pointer to packet timestamp
    @param[in]      aTSQual     Pointer to packet timestamp quality

    @return     void

    @post TBD

    @note This interface shall be implemented by the integrator.

    @trace  #BRCM_SWREQ_ETHSWT_MANAGEMENT

    @limitations None
*/
extern void ETHSWT_RxTSInd(ETHER_HwIDType aCntrlID,
        const uint8_t *const aData,
        const ETHSWT_MgmtInfoType *const aMgmtInfo,
        const ETHER_TimestampType *const aTS,
        const ETHER_TimestampQualType* const aTSQual);


#endif /* ETHSWT_COMMON_OSIL_H */
/** @} */
