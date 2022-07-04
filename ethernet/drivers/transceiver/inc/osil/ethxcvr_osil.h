/*****************************************************************************
 Copyright 2018-2021 Broadcom Limited.  All rights reserved.

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

/** @defgroup grp_eth_xcvrdrv_il Integration Guide
    @ingroup grp_eth_xcvrdrv

    @addtogroup grp_eth_xcvrdrv_il
    @{
    @section sec_ethxcvr_integration Integration Guide
    Ethernet transceiver driver requires a task for deferred processing.
    This task shall be called as Client Task further in this document.
    Client Task shall be signaled from the Ethernet transceiver IRQ handler and
    shall have a higher priority than the client tasks.  This section gives the
    different integration interfaces that shall be used to implement the
    Ethernet IRQ handler and the Client Task.

    Ethernet transceiver driver is implemented as a SysCmdReq (system command
    request) and SysCmdHandler (system command handler) model. This section also
    gives the necessary information on how to install command handler for
    Ethernet Transceiver Driver onto SysCmdHandler

    @section sec_ethxcvr_il_seq Sequence Diagram

    @subsection subsec1_ethxcvr_il_seq SVC Layer Interaction
    @image html eth_seq_diagram_svc_layer.jpg "SVC layer interaction"
    Above sequence diagram depicts execution sequence for Ethernet channel
    initialization (#ETHXCVR_Init, #ETHXCVR_SetMode, #ETHXCVR_GetMode,
    #ETHXCVR_GetLinkState and #ETHXCVR_GetSQIValue APIs follow a similar
    sequence).

    @subsection subsec2_ethxcvr_il_seq Transceiver Link Status Change Indication sequence
    @image html eth_seq_diagram_link_status_ind.jpg "Transceiver link status change indication"
    This figure depicts interaction sequence for transceiver link status change indication.

    @file ethxcvr_osil.h
    @brief Ethernet Transceiver Driver Integration Interfaces
    This header file contains the integration interface for Ethernet Transceiver Driver

    @version 1.26 Imported from docx
*/

#ifndef ETHXCVR_OSIL_H
#define ETHXCVR_OSIL_H

#include <svc.h>
#include <ethxcvr.h>

/**
    @name Ethernet Transceiver Driver Integration Interface IDs
    @{
    @brief Integration Interface IDs for Ethernet Transceiver Driver
*/
#define BRCM_SWARCH_ETHXCVR_CMD_TYPE                     (0x9201U)    /**< @brief #ETHXCVR_CmdType                  */
#define BRCM_SWARCH_ETHXCVR_IO_TYPE                      (0x9202U)    /**< @brief #ETHXCVR_IOType                   */
#define BRCM_SWARCH_ETHXCVR_SYSCMDREQ_PROC               (0x9203U)    /**< @brief #ETHXCVR_SysCmdReq                */
#define BRCM_SWARCH_ETHXCVR_CMDHANDLER_PROC              (0x9204U)    /**< @brief #ETHXCVR_CmdHandler               */
#define BRCM_SWARCH_ETHXCVR_SYSCMDHANDLER_PROC           (0x9205U)    /**< @brief #ETHXCVR_SysCmdHandler            */
#define BRCM_SWARCH_ETHXCVR_LINKIRQHANDLER_PROC          (0x9206U)    /**< @brief #ETHXCVR_LinkIRQHandler           */
#define BRCM_SWARCH_ETHXCVR_LINKCHGINDHANDLER_PROC       (0x9207U)    /**< @brief #ETHXCVR_LinkChgIndHandler        */
#define BRCM_SWARCH_ETHXCVR_LINKSTATECHANGEIND_PROC      (0x9208U)    /**< @brief #ETHXCVR_LinkStateChangeInd       */
#define BRCM_SWARCH_ETHXCVR_LINKIRQHANDLER0_PROC         (0x9209U)    /**< @brief #ETHXCVR_LinkIRQHandler0          */
#define BRCM_SWARCH_ETHXCVR_PHYCACHEDINFO_TYPE           (0x920AU)    /**< @brief #ETHXCVR_PhyCachedInfoType        */
#define BRCM_SWARCH_ETHXCVR_PHYCNTXT_TYPE                (0x920BU)    /**< @brief #ETHXCVR_CntxtType                */
#define BRCM_SWARCH_ETHXCVR_MODEINDICATION_PROC          (0x920CU)    /**< @brief #ETHXCVR_ModeIndication           */
#define BRCM_SWARCH_ETHXCVR_PHYFUNCTBL_TYPE              (0x920DU)    /**< @brief #ETHXCVR_FuncTblType              */
#define BRCM_SWARCH_ETHXCVR_INIT_TYPE                    (0x920EU)    /**< @brief #ETHXCVR_InitType                 */
#define BRCM_SWARCH_ETHXCVR_RESET_TYPE                   (0x920FU)    /**< @brief #ETHXCVR_ResetType                */
#define BRCM_SWARCH_ETHXCVR_SETMODE_TYPE                 (0x9210U)    /**< @brief #ETHXCVR_SetModeType              */
#define BRCM_SWARCH_ETHXCVR_GETMODE_TYPE                 (0x9211U)    /**< @brief #ETHXCVR_GetModeType              */
#define BRCM_SWARCH_ETHXCVR_SETMASTERMODE_TYPE           (0x9212U)    /**< @brief #ETHXCVR_SetMasterModeType        */
#define BRCM_SWARCH_ETHXCVR_GETMASTERMODE_TYPE           (0x9213U)    /**< @brief #ETHXCVR_GetMasterModeType        */
#define BRCM_SWARCH_ETHXCVR_GETSPEED_TYPE                (0x9214U)    /**< @brief #ETHXCVR_GetSpeedType             */
#define BRCM_SWARCH_ETHXCVR_SETSPEED_TYPE                (0x9215U)    /**< @brief #ETHXCVR_SetSpeedType             */
#define BRCM_SWARCH_ETHXCVR_GETDUPLEXMODE_TYPE           (0x9216U)    /**< @brief #ETHXCVR_GetDuplexModeType        */
#define BRCM_SWARCH_ETHXCVR_SETDUPLEXMODE_TYPE           (0x9217U)    /**< @brief #ETHXCVR_SetDuplexModeType        */
#define BRCM_SWARCH_ETHXCVR_GETFLOWCONTROL_TYPE          (0x9218U)    /**< @brief #ETHXCVR_GetFlowControlType       */
#define BRCM_SWARCH_ETHXCVR_SETFLOWCONTROL_TYPE          (0x9219U)    /**< @brief #ETHXCVR_SetFlowControlType       */
#define BRCM_SWARCH_ETHXCVR_GETLINKSTATE_TYPE            (0x921AU)    /**< @brief #ETHXCVR_GetLinkStateType         */
#define BRCM_SWARCH_ETHXCVR_GETSQIVALUE_TYPE             (0x921BU)    /**< @brief #ETHXCVR_GetSQIValueType          */
#define BRCM_SWARCH_ETHXCVR_LINKIRQHANDLER_TYPE          (0x921CU)    /**< @brief #ETHXCVR_LinkIRQHandlerType       */
#define BRCM_SWARCH_ETHXCVR_LINKCHANGEINDHANDLER_TYPE    (0x921DU)    /**< @brief #ETHXCVR_LinkChangeIndHandlerType */
#define BRCM_SWARCH_ETHXCVR_SETLOOPBACKMODE_TYPE         (0x921EU)    /**< @brief #ETHXCVR_SetLoopbackModeType      */
#define BRCM_SWARCH_ETHXCVR_GETLOOPBACKMODE_TYPE         (0x921FU)    /**< @brief #ETHXCVR_GetLoopbackModeType      */
#define BRCM_SWARCH_ETHXCVR_SETJUMBOMODE_TYPE            (0x9220U)    /**< @brief #ETHXCVR_SetJumboModeType         */
#define BRCM_SWARCH_ETHXCVR_GETJUMBOMODE_TYPE            (0x9221U)    /**< @brief #ETHXCVR_GetJumboModeType         */
#define BRCM_SWARCH_ETHXCVR_SETWAKEUPMODE_TYPE           (0x9222U)    /**< @brief #ETHXCVR_SetWakeUpModeType        */
#define BRCM_SWARCH_ETHXCVR_GETWAKEUPMODE_TYPE           (0x9223U)    /**< @brief #ETHXCVR_GetWakeUpModeType        */
#define BRCM_SWARCH_ETHXCVR_GETWAKEUPREASON_TYPE         (0x9224U)    /**< @brief #ETHXCVR_GetWakeUpReasonType      */
#define BRCM_SWARCH_ETHXCVR_SETAUTONEGMODE_TYPE          (0x9225U)    /**< @brief #ETHXCVR_SetAutoNegModeType       */
#define BRCM_SWARCH_ETHXCVR_GETAUTONEGSTATUS_TYPE        (0x9226U)    /**< @brief #ETHXCVR_GetAutoNegStatusType     */
#define BRCM_SWARCH_ETHXCVR_RESTARTAUTONEG_TYPE          (0x9227U)    /**< @brief #ETHXCVR_RestartAutoNegType       */
#define BRCM_SWARCH_ETHXCVR_GETSTATS_TYPE                (0x9228U)    /**< @brief #ETHXCVR_GetStatsType             */
#define BRCM_SWARCH_ETHXCVR_STATEHANDLER_TYPE            (0x9229U)    /**< @brief #ETHXCVR_StateHandlerType         */
#define BRCM_SWARCH_ETHXCVR_UPDATEHWSTATUS_TYPE          (0x922AU)    /**< @brief #ETHXCVR_UpdateHWStatusType       */
#define BRCM_SWARCH_ETHXCVR_DEINIT_TYPE                  (0x922BU)    /**< @brief #ETHXCVR_DeInitType               */

/** @} */

/** @name ETHXCVR_CmdType
    @{
    @brief Ethernet transceiver driver system command request type

    @trace #BRCM_SWREQ_ETHXCVR_KERNEL_INTERFACE
*/
typedef uint32_t ETHXCVR_CmdType;
#define ETHXCVR_CMD_INIT                 (0UL)
#define ETHXCVR_CMD_SET_MODE             (1UL)
#define ETHXCVR_CMD_GET_MODE             (2UL)
#define ETHXCVR_CMD_GET_LINK_STATE       (3UL)
#define ETHXCVR_CMD_GET_SQI_VALUE        (4UL)
#define ETHXCVR_CMD_DEINIT               (5UL)
#define ETHXCVR_CMD_SET_MASTERMODE       (6UL)
#define ETHXCVR_CMD_GET_MASTERMODE       (7UL)
#define ETHXCVR_CMD_SET_SPEED            (8UL)
#define ETHXCVR_CMD_SET_LOOPBACK         (9UL)
#define ETHXCVR_CMD_GET_LOOPBACK         (10UL)
#define ETHXCVR_CMD_SET_JUMBO_MODE       (11UL)
#define ETHXCVR_CMD_GET_JUMBO_MODE       (12UL)
#define ETHXCVR_CMD_SET_WAKEUP_MODE      (13UL)
#define ETHXCVR_CMD_GET_WAKEUP_MODE      (14UL)
#define ETHXCVR_CMD_GET_WAKE_REASON      (15UL)
#define ETHXCVR_CMD_SET_AUTONEG_MODE     (16UL)
#define ETHXCVR_CMD_GET_AUTONEG_STATUS   (17UL)
#define ETHXCVR_CMD_GET_STATS            (18UL)
#define ETHXCVR_CMD_GET_SPEED            (19UL)
#define ETHXCVR_CMD_GET_DUPLEXMODE       (20UL)
#define ETHXCVR_CMD_SET_DUPLEXMODE       (21UL)
#define ETHXCVR_CMD_GET_FLOWCONTROL      (22UL)
#define ETHXCVR_CMD_SET_FLOWCONTROL      (23UL)
#define ETHXCVR_CMD_RESTART_AUTONEG      (24UL)
#define ETHXCVR_CMD_STATEHANDLER         (25UL)
#define ETHXCVR_CMD_UPDATE_HW_STATUS     (26UL)
#define ETHXCVR_CMD_LINK_CHGIND_HANDLER  (27UL)
/** @} */


/**
    @brief IO structure for Ethernet driver

    @trace #BRCM_SWREQ_ETHXCVR_KERNEL_INTERFACE
 */
typedef struct sETHXCVR_IOType {
    int32_t                      retVal;        /**< @brief Error value as set by #ETHXCVR_SysCmdHandler */
    ETHXCVR_IDType               hwID;          /**< @brief Ethernet transceiver Index */
    ETHXCVR_ModeType             mode;          /**< @brief Transceiver mode */
    ETHXCVR_BooleanType          paramEnable;   /**< @brief Overloaded field; Jumbo/Autoneg/Master/Loopback enable */
    ETHXCVR_SpeedType            speed;         /**< @brief Transceiver speed */
    ETHXCVR_AutoNegStatusType    autoNegStatus; /**< @brief Transceiver auto-neg status */
    ETHXCVR_LinkStateType        linkState;     /**< @brief Transceiver link state */
    uint32_t                     isLinkStateChanged; /**< @brief link state changed flag */
    const ETHXCVR_PortConfigType *xcvrCfg;      /**< @brief Pointer to transceiver config */
    ETHXCVR_StatsType            *stats;        /**< @brief Pointer to transceiver statistics */
    uint32_t                     sqiValue;      /**< @brief Signal Quality Indicator */
    ETHXCVR_DuplexModeType       duplex;        /**< @brief Duplex */
    ETHXCVR_FlowControlType      flowControl;   /**< @brief Flow control */
    ETHXCVR_WakeupReasonType     wakeUpReason;  /**< @brief Wakeup Reason */
    uint32_t                     isModeChanged; /**< @brief Flag indicating if mode was changed */
} ETHXCVR_IOType;

/**
    @brief PHY cached info structure type

    @trace #BRCM_SWREQ_ETHXCVR_KERNEL_INTERFACE
 */
typedef struct sETHXCVR_PhyCachedInfoType {
    ETHXCVR_LinkStateType       linkState;      /**< @brief PHY Link state */
    ETHXCVR_ModeType            mode;           /**< @brief PHY Mode */
    ETHXCVR_BooleanType         connMode;       /**< @brief PHY connection mode */
    ETHXCVR_BooleanType         loopbackMode;   /**< @brief PHY loopback mode */
    ETHXCVR_BooleanType         jumboMode;      /**< @brief PHY jumbo mode */
    ETHXCVR_BooleanType         autonegMode;    /**< @brief PHY AutoNeg mode */
    ETHXCVR_SpeedType           speed;          /**< @brief PHY speed */
    ETHXCVR_DuplexModeType      duplexMode;     /**< @brief PHY duplex mode */
    ETHXCVR_FlowControlType     flowControl;    /**< @brief PHY flow control */
    ETHXCVR_BooleanType         wakeupMode;     /**< @brief PHY WakeUp mode */
    ETHXCVR_ModeType            localModeState; /**< @brief PHY Local Mode State */
    uint16_t                    tc10Status;     /**< @brief PHY Captured TC10 Status*/
    uint32_t                    sqiValue;       /**< @brief PHY SQI value */
    ETHXCVR_StatsType           stats;          /**< @brief PHY stats */
} ETHXCVR_PhyCachedInfoType;

/**
    @brief PHY context structure type

    @trace #BRCM_SWREQ_ETHXCVR_KERNEL_INTERFACE
 */
typedef struct sETHXCVR_CntxtType {
    ETHXCVR_IDType              id;         /**< @brief PHY identifier */
    uint32_t                    drvState;   /**< @brief PHY driver state */
    uint32_t                    data[16UL]; /**< @brief PHY context data */
    ETHXCVR_PhyCachedInfoType   cacheInfo;  /**< @brief PHY cached information */
} ETHXCVR_CntxtType;

/**
    @brief Function type to initialize

    @trace #BRCM_SWREQ_ETHXCVR_FUNCTBL
*/
typedef int32_t (*ETHXCVR_InitType)(uint8_t aId,
                                    ETHXCVR_CntxtType *const aPhyCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig);

/**
    @brief function type to de-initialize

    @trace #BRCM_SWREQ_ETHXCVR_FUNCTBL
*/
typedef int32_t (*ETHXCVR_DeInitType)(uint8_t aId,
                                    ETHXCVR_CntxtType *const aPhyCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig);

/**
    @brief Function type to reset

    @trace #BRCM_SWREQ_ETHXCVR_FUNCTBL
*/
typedef int32_t (*ETHXCVR_ResetType)(uint8_t aId,
                                 ETHXCVR_CntxtType *const aPhyCntxt,
                                 const ETHXCVR_PortConfigType *const aConfig);

/**
    @brief Function type to set mode

    @trace #BRCM_SWREQ_ETHXCVR_FUNCTBL
*/
typedef int32_t (*ETHXCVR_SetModeType)(uint8_t aId,
                                   ETHXCVR_CntxtType *const aPhyCntxt,
                                   const ETHXCVR_PortConfigType *const aConfig,
                                   ETHXCVR_ModeType aMode);

/**
    @brief Function type to get mode

    @trace #BRCM_SWREQ_ETHXCVR_FUNCTBL
*/
typedef int32_t (*ETHXCVR_GetModeType)(uint8_t aId,
                                   ETHXCVR_CntxtType *const aPhyCntxt,
                                   const ETHXCVR_PortConfigType *const aConfig,
                                   ETHXCVR_ModeType *const aMode);

/**
    @brief Function type to set master/slave mode

    @trace #BRCM_SWREQ_ETHXCVR_FUNCTBL
*/
typedef int32_t (*ETHXCVR_SetMasterModeType)(uint8_t aId,
                                     ETHXCVR_CntxtType *const aPhyCntxt,
                                     const ETHXCVR_PortConfigType *const aConfig,
                                     ETHXCVR_BooleanType aMode);

/**
    @brief Function type to get master/slave mode

    @trace #BRCM_SWREQ_ETHXCVR_FUNCTBL
*/
typedef int32_t (*ETHXCVR_GetMasterModeType)(uint8_t aId,
                                    ETHXCVR_CntxtType *const aPhyCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig,
                                    ETHXCVR_BooleanType *const aMode);

/**
    @brief Function type to get speed

    @trace #BRCM_SWREQ_ETHXCVR_FUNCTBL
*/
typedef int32_t (*ETHXCVR_GetSpeedType)(uint8_t aId,
                                    ETHXCVR_CntxtType *const aPhyCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig,
                                    ETHXCVR_SpeedType *const aSpeed);

/**
    @brief Function type to set speed

    @trace #BRCM_SWREQ_ETHXCVR_FUNCTBL
*/
typedef int32_t (*ETHXCVR_SetSpeedType)(uint8_t aId,
                                    ETHXCVR_CntxtType *const aPhyCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig,
                                    ETHXCVR_SpeedType aSpeed);

/**
    @brief Function type to get duplex mode

    @trace #BRCM_SWREQ_ETHXCVR_FUNCTBL
*/
typedef int32_t (*ETHXCVR_GetDuplexModeType)(uint8_t aId,
                                    ETHXCVR_CntxtType *const aPhyCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig,
                                    ETHXCVR_DuplexModeType *const aDuplexMode);

/**
    @brief Function type to set duplex mode

    @trace #BRCM_SWREQ_ETHXCVR_FUNCTBL
*/
typedef int32_t (*ETHXCVR_SetDuplexModeType)(uint8_t aId,
                                    ETHXCVR_CntxtType *const aPhyCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig,
                                    ETHXCVR_DuplexModeType aDuplexMode);

/**
    @brief Function type to get flow control

    @trace #BRCM_SWREQ_ETHXCVR_FUNCTBL
*/
typedef int32_t (*ETHXCVR_GetFlowControlType)(uint8_t aId,
                                    ETHXCVR_CntxtType *const aPhyCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig,
                                    ETHXCVR_FlowControlType *const aFlowControl);

/**
    @brief Function type to set flow control

    @trace #BRCM_SWREQ_ETHXCVR_FUNCTBL
*/
typedef int32_t (*ETHXCVR_SetFlowControlType)(uint8_t aId,
                                    ETHXCVR_CntxtType *const aPhyCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig,
                                    ETHXCVR_FlowControlType aFlowControl);

/**
    @brief Function type to get link state

    @trace #BRCM_SWREQ_ETHXCVR_FUNCTBL
*/
typedef int32_t (*ETHXCVR_GetLinkStateType)(uint8_t aId,
                                    ETHXCVR_CntxtType *const aPhyCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig,
                                    ETHXCVR_LinkStateType *const aLinkState);

/**
    @brief Function type to get SQI value

    @trace #BRCM_SWREQ_ETHXCVR_FUNCTBL
*/
typedef int32_t (*ETHXCVR_GetSQIValueType)(uint8_t aId,
                                    ETHXCVR_CntxtType *const aPhyCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig,
                                    uint32_t *const aSQIValue);

/**
    @brief Function type to handle link IRQ

    @trace #BRCM_SWREQ_ETHXCVR_FUNCTBL
*/
typedef int32_t (*ETHXCVR_LinkIRQHandlerType)(uint8_t aId,
                                    ETHXCVR_CntxtType *const aPhyCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig);

/**
    @brief Function type to handle link change indication

    @trace #BRCM_SWREQ_ETHXCVR_FUNCTBL
*/
typedef int32_t (*ETHXCVR_LinkChangeIndHandlerType)(uint8_t aId,
                                    ETHXCVR_CntxtType *const aPhyCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig,
                                    ETHXCVR_LinkStateType *const aLinkState,
                                    uint32_t *const aIsLinkStateChanged);

/**
    @brief Function type to set loopback mode

    @trace #BRCM_SWREQ_ETHXCVR_FUNCTBL
*/
typedef int32_t (*ETHXCVR_SetLoopbackModeType)(ETHXCVR_IDType aID,
                                    ETHXCVR_CntxtType *const aPhyCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig,
                                    ETHXCVR_BooleanType aMode);

/**
    @brief Function type to get loopback mode

    @trace #BRCM_SWREQ_ETHXCVR_FUNCTBL
*/
typedef int32_t (*ETHXCVR_GetLoopbackModeType)(ETHXCVR_IDType aID,
                                    ETHXCVR_CntxtType *const aPhyCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig,
                                    ETHXCVR_BooleanType *const aMode);

/**
    @brief Function type to set jumbo mode

    @trace #BRCM_SWREQ_ETHXCVR_FUNCTBL
*/
typedef int32_t (*ETHXCVR_SetJumboModeType)(ETHXCVR_IDType aID,
                                    ETHXCVR_CntxtType *const aPhyCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig,
                                    ETHXCVR_BooleanType aJumboMode);

/**
    @brief Function type to set Wakeup Mode Enable

    @trace #BRCM_SWREQ_ETHXCVR_FUNCTBL
*/
typedef int32_t (*ETHXCVR_SetWakeUpModeType)(ETHXCVR_IDType aID,
                                    ETHXCVR_CntxtType *const aPhyCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig,
                                    ETHXCVR_BooleanType aMode);
/**
    @brief Function type to Get Wakeup Mode Enable Settings

    @trace #BRCM_SWREQ_ETHXCVR_FUNCTBL
*/
typedef int32_t (*ETHXCVR_GetWakeUpModeType)(ETHXCVR_IDType aID,
                                    ETHXCVR_CntxtType *const aPhyCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig,
                                    ETHXCVR_BooleanType *const aMode);


/**
    @brief Function type to get wakeUp reason

    @trace #BRCM_SWREQ_ETHXCVR_FUNCTBL
*/
typedef int32_t (*ETHXCVR_GetWakeUpReasonType)(ETHXCVR_IDType aID,
                                    ETHXCVR_CntxtType *const aPhyCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig,
                                    ETHXCVR_WakeupReasonType *const aReason);


/**
    @brief Function type to get jumbo mode

    @trace #BRCM_SWREQ_ETHXCVR_FUNCTBL
*/
typedef int32_t (*ETHXCVR_GetJumboModeType)(ETHXCVR_IDType aID,
                                    ETHXCVR_CntxtType *const aPhyCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig,
                                    ETHXCVR_BooleanType *const aJumboMode);

/**
    @brief Function type to set auto-negotiation mode

    @trace #BRCM_SWREQ_ETHXCVR_FUNCTBL
*/
typedef int32_t (*ETHXCVR_SetAutoNegModeType)(ETHXCVR_IDType aID,
                                    ETHXCVR_CntxtType *const aPhyCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig,
                                    ETHXCVR_BooleanType aAutoNegMode);

/**
    @brief Function type to get auto-negotiation status

    @trace #BRCM_SWREQ_ETHXCVR_FUNCTBL
*/
typedef int32_t (*ETHXCVR_GetAutoNegStatusType)(ETHXCVR_IDType aID,
                                ETHXCVR_CntxtType *const aPhyCntxt,
                                const ETHXCVR_PortConfigType *const aConfig,
                                ETHXCVR_AutoNegStatusType *const aAutoNegStatus);

/**
    @brief Function type to restart auto-negotiation

    @trace #BRCM_SWREQ_ETHXCVR_FUNCTBL
*/
typedef int32_t (*ETHXCVR_RestartAutoNegType)(ETHXCVR_IDType aID,
                                    ETHXCVR_CntxtType *const aPhyCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig);

/**
    @brief Function type to retrieve statistics

    @trace #BRCM_SWREQ_ETHXCVR_FUNCTBL
*/
typedef int32_t (*ETHXCVR_GetStatsType)(ETHXCVR_IDType aID,
                                    ETHXCVR_CntxtType *const aPhyCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig,
                                    ETHXCVR_StatsType *const aStats);

/**
    @brief Function type for state handler

    @trace #BRCM_SWREQ_ETHXCVR_FUNCTBL
*/
typedef int32_t (*ETHXCVR_StateHandlerType)(ETHXCVR_IDType aID,
                                    ETHXCVR_CntxtType *const aPhyCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig,
                                    uint32_t *const aIsModeChanged,
                                    ETHXCVR_ModeType *const aMode);

/**
    @brief Function type to update HW status parameters

    @trace #BRCM_SWREQ_ETHXCVR_FUNCTBL
*/
typedef int32_t (*ETHXCVR_UpdateHWStatusType)(ETHXCVR_IDType aID,
                                    ETHXCVR_CntxtType *const aPhyCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig);

/**
    @brief Ethernet PHY function table type

    @trace #BRCM_SWREQ_ETHXCVR_FUNCTBL
 */
typedef struct sETHXCVR_FuncTblType {
    ETHXCVR_InitType                 init;                 /**< @brief Function type to initialize */
    ETHXCVR_DeInitType               deinit;               /**< @brief Function type to de-initialize */
    ETHXCVR_ResetType                reset;                /**< @brief Function type to reset */
    ETHXCVR_SetModeType              setMode;              /**< @brief Function type to set mode */
    ETHXCVR_GetModeType              getMode;              /**< @brief Function type to get mode */
    ETHXCVR_SetMasterModeType        setMasterMode;        /**< @brief Function type to set master/slave mode */
    ETHXCVR_GetMasterModeType        getMasterMode;        /**< @brief Function type to get master/slave mode */
    ETHXCVR_GetSpeedType             getSpeed;             /**< @brief Function type to get speed */
    ETHXCVR_SetSpeedType             setSpeed;             /**< @brief Function type to set speed */
    ETHXCVR_SetDuplexModeType        setDuplexMode;        /**< @brief Function type to set duplex mode */
    ETHXCVR_GetDuplexModeType        getDuplexMode;        /**< @brief Function type to get duplex mode */
    ETHXCVR_SetFlowControlType       setFlowControl;       /**< @brief Function type to set flow control */
    ETHXCVR_GetFlowControlType       getFlowControl;       /**< @brief Function type to get flow control */
    ETHXCVR_GetLinkStateType         getLinkState;         /**< @brief Function type to get link state */
    ETHXCVR_GetSQIValueType          getSQIValue;          /**< @brief Function type to get SQI value */
    ETHXCVR_SetLoopbackModeType      setLoopbackMode;      /**< @brief Function type to set loopback mode */
    ETHXCVR_GetLoopbackModeType      getLoopbackMode;      /**< @brief Function type to get loopback mode */
    ETHXCVR_SetJumboModeType         setJumboMode;         /**< @brief Function type to set jumbo mode */
    ETHXCVR_SetWakeUpModeType        setWakeUpMode;        /**< @brief Function type to set wakeup mode */
    ETHXCVR_GetWakeUpModeType        getWakeUpMode;        /**< @brief Function type to get wakeup mode Setting*/
    ETHXCVR_GetWakeUpReasonType      getWakeUpReason;      /**< @brief Function type to get Wake Reason */
    ETHXCVR_GetJumboModeType         getJumboMode;         /**< @brief Function type to get jumbo mode */
    ETHXCVR_SetAutoNegModeType       setAutoNegMode;       /**< @brief Function type to set Auto-negotiation mode */
    ETHXCVR_GetAutoNegStatusType     getAutoNegStatus;     /**< @brief Function type to get Auto-negotiation status */
    ETHXCVR_RestartAutoNegType       restartAutoNeg;       /**< @brief Function type to restart Auto-negotiation */
    ETHXCVR_GetStatsType             getStats;             /**< @brief Function type to get statistics */
    ETHXCVR_StateHandlerType         stateHandler;         /**< @brief Function type for state handler */
    ETHXCVR_UpdateHWStatusType       updateHWStatus;       /**< @brief Function type to update HW status parameters */
    ETHXCVR_LinkIRQHandlerType       linkIRQHandler;       /**< @brief Function type to handle link IRQ */
    ETHXCVR_LinkChangeIndHandlerType linkChangeIndHandler; /**< @brief Function type to handle link change indication */
} ETHXCVR_FuncTblType;


/** @brief Interface to raise a request to Ethernet driver

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aCmd        Command requested by user
    @param[inout]   aIO         In-Out structure containing request parameters

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Command raised successfully
    @retval     #ETHXCVR_CMDHANDLER     Return value
    @retval     #BCM_ERR_INVAL_MAGIC    Invalid SVC magic
    @retval     #BCM_ERR_UNKNOWN        Integration error

    @post None

    @note To be implemented.

    @limitations None

    @trace #BRCM_SWREQ_ETHXCVR_KERNEL_INTERFACE
*/
extern int32_t ETHXCVR_SysCmdReq(ETHXCVR_CmdType aCmd,
                                 ETHXCVR_IOType *const aIO);

/** @brief Internal command handler

    This interface handles commands requested from system command handler.
    This interface shall be called from #ETHXCVR_SysCmdHandler

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aCmd        Command requested by user
    @param[inout]   aIO         In-Out structure containing request parameters

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Command request completed successfully
    @return     Others                  API dependent error values
    @retval     #BCM_ERR_INVAL_PARAMS   Invalid command
    @retval     #BCM_ERR_UNKNOWN        aIO is NULL

    @post None

    @note To be used.

    @limitations None

    @snippet ethxcvr_osil.c Usage of ETHXCVR_CmdHandler

    @trace #BRCM_SWREQ_ETHXCVR_KERNEL_HANDLER
*/
extern int32_t ETHXCVR_CmdHandler(ETHXCVR_CmdType aCmd, ETHXCVR_IOType * const aIO);

/** @brief Command handler interface

    This command handler interface shall handle all the commands requested from
    the system command handler. This interface shall be implemented by the
    integrator and shall be installed to SVC Layer

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aMagicID    Ethernet SVC Magic ID
    @param[in]      aCmd        Command requested from SysCmdHandler
    @param[inout]   aSysIO      uint8_t * to be interpreted as ETHER_IOType

    @return     void

    @post None

    @note To be implemented.

    @limitations None

    @trace #BRCM_SWREQ_ETHXCVR_KERNEL_HANDLER
*/
extern void ETHXCVR_SysCmdHandler(uint32_t aMagicID,
                                uint32_t aCmd,
                                uint8_t * aSysIO);

/** @brief Ethernet Xcvr Link IRQ handler

    This API handles Ethernet xcvr link IRQ processing.

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aID             Xcvr ID

    @return     void

    @post None

    @note To be used.

    @limitations None

    @snippet eth_osil.c Usage of ETHXCVR_LinkIRQHandler

    @trace #BRCM_SWREQ_ETHXCVR_KERNEL_HANDLER
*/
extern void ETHXCVR_LinkIRQHandler(ETHXCVR_IDType aID);

/** @brief Ethernet Xcvr change indication handler

    This API handles Ethernet xcvr link change indication processing.

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aID             Xcvr ID

    @return     void

    @post None

    @note To be used.

    @limitations None

    @snippet ethsrv_osil.c Usage of ETHXCVR_LinkChgIndHandler

    @trace #BRCM_SWREQ_ETHXCVR_STATUS
*/
extern void ETHXCVR_LinkChgIndHandler(ETHXCVR_IDType aID);


/** @brief Ethernet transceiver link state indication

    Link state change indication callback from Transceiver during link state transition (from down to active or from
    active to down).

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aID         Index of the Transceiver
    @param[in]      aLinkState  Transceiver current link state

    @return     void

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHXCVR_STATUS
*/
extern void ETHXCVR_LinkStateChangeInd(ETHXCVR_IDType aID,
                                       ETHXCVR_LinkStateType aLinkState);

/** @brief Mode change indication

    Callback from transceiver to indicate change in mode. Triggered by a
    #ETHXCVR_SetMode invocation

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aID         Index of the transceiver
    @param[in]      aMode       Mode of the transceiver

    @return     void

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHXCVR_RUNTIME_CONFIG
*/
extern void ETHXCVR_ModeIndication(ETHXCVR_IDType aID, ETHXCVR_ModeType aMode);

/** @brief ETHXCVR_Link Interrupt Handler

    ETHXCVR_Link Interrupt Handler0.

    @behavior Sync, Re-entrant

    @pre TBD

    @param[in]      None

    @retval         None

    @post TBD

    @limitations None

    @trace #BRCM_SWREQ_ETHXCVR_KERNEL_HANDLER
*/
extern void ETHXCVR_LinkIRQHandler0(void);
#endif /* ETHXCVR_OSIL_H */

/** @} */
