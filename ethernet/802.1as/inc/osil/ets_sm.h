/*****************************************************************************
 Copyright 2021 Broadcom Limited.  All rights reserved.

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
    @addtogroup grp_ets_il
    @{

    @file ets_sm.h

    @brief ETS library module interface
    This file contains the ETS library state machine interface

    @version 0.1 Initial version
*/

#ifndef ETS_SM_H
#define ETS_SM_H

#include <bcm_err.h>
#include "ets_osil.h"

/**
    @name ETS Library Module IDs
    @{
    @brief API IDs for ETS module
*/
#define BRCM_SWARCH_ETS_SMINITHNDLR_TYPE           (0x9D01U) /**< @brief #ETS_SMInitHndlrType          */
#define BRCM_SWARCH_ETS_SMDEINITHNDLR_TYPE         (0x9D02U) /**< @brief #ETS_SMDeInitHndlrType        */
#define BRCM_SWARCH_ETS_SMCHECKTIMERHNDLR_TYPE     (0x9D03U) /**< @brief #ETS_SMCheckTimerHndlrType    */
#define BRCM_SWARCH_ETS_SMRXPDUHNDLR_TYPE          (0x9D04U) /**< @brief #ETS_SMRxPDUHndlrType         */
#define BRCM_SWARCH_ETS_SMTXPDUHNDLR_TYPE          (0x9D05U) /**< @brief #ETS_SMTxPDUHndlrType         */
#define BRCM_SWARCH_ETS_SMCHANGETXINTVLHNDLR_TYPE  (0x9D06U) /**< @brief #ETS_SMChangeTxIntvlHndlrType */
#define BRCM_SWARCH_ETS_SMEVENTHNDLR_TYPE          (0x9D07U) /**< @brief #ETS_SMEventHndlrType         */
#define BRCM_SWARCH_ETS_STATEMACHINE_TYPE          (0x9D08U) /**< @brief #ETS_StateMachineType         */
#define BRCM_SWARCH_ETS_SMGROUP_TYPE               (0x9D0AU) /**< @brief #ETS_SMGroupType              */
#define BRCM_SWARCH_ETS_SMGROUPAVNU_GLOBAL         (0x9D0BU) /**< @brief #ETS_SMGroupAvnu              */
#define BRCM_SWARCH_ETS_SMGROUPIEEE2011_GLOBAL     (0x9D0CU) /**< @brief #ETS_SMGroupIeee2011          */
#define BRCM_SWARCH_ETS_SMGROUPS_GLOBAL            (0x9D0DU) /**< @brief #ETS_SMGroups                 */
#define BRCM_SWARCH_ETS_MODEINDEX_GLOBAL           (0x9D0EU) /**< @brief #ETS_ModeIndex                */
#define BRCM_SWARCH_ETS_SMGETSTATUS_TYPE           (0x9D0FU) /**< @brief #ETS_SMGetStatusType        */
#define BRCM_SWARCH_ETS_COMBINEDSTATUS_TYPE        (0x9D10U) /**< @brief #ETS_CombinedStatusType     */
/** @} */

/**
    @brief Combined Status Type

    All status variables clubbed into one for retrieval

    @trace #BRCM_SWREQ_ETS_SM
*/
typedef struct sETS_CombinedStatusType {
    ETS_DomainStatusType     domain;       /**< @brief Domain status      */
    ETS_PortStatusType       port;         /**< @brief Port status        */
    ETS_DomainPortStatusType domainPort;   /**< @brief Domain port status */
} ETS_CombinedStatusType;

/** @brief State machine initialization

    @behavior Sync, Non-reentrant

    @pre None

    @param  none

    @return void

    @post None

    @trace  #BRCM_SWREQ_ETS_SM

    @limitations None
*/
typedef void (*ETS_SMInitHndlrType)(void);

/** @brief State machine de-initialization

    @behavior Sync, Non-reentrant

    @pre None

    @param  none

    @return void

    @post None

    @trace  #BRCM_SWREQ_ETS_SM

    @limitations None
*/
typedef void (*ETS_SMDeInitHndlrType)(void);

/** @brief Provide timer tick to state machine

    @behavior Sync, Non-reentrant

    @pre None

    @param  none

    @return void

    @post None

    @trace  #BRCM_SWREQ_ETS_SM

    @limitations None
*/
typedef void (*ETS_SMCheckTimerHndlrType)(void);

/** @brief Received PDU handler

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]  aIntfIndex              Interface index
    @param[in]  aPktData                Pointer to gPTP body/payload (header skipped)
    @param[in]  aPktLen                 Length of the packet (excluding header)
    @param[in]  aPdu                    Parsed PDU
    @param[in]  aTs                     Ingress timestamp
    @param[in]  aTsValid                Flag indicating whether the ingress
                                        timestamp is valid or not

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             PDU parsed and consumed successfully by
                                        the state machine
    @retval     #BCM_ERR_NO_SUPPORT     The PDU is not supported by this state
                                        machine

    @post None

    @trace  #BRCM_SWREQ_ETS_SM

    @limitations None
*/
typedef int32_t (*ETS_SMRxPDUHndlrType)(const uint32_t aIntfIndex,
                                        const uint8_t* const aPktData,
                                        const uint16_t aPktLen,
                                        ETS_PDUType* const aPdu,
                                        const ETS_TimeType* const aTs,
                                        const uint32_t aTsValid);

/** @brief Transmitted PDU handler

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]  aIntfIndex              Interface index
    @param[in]  aMsgType                Message type
    @param[in]  aTs                     Egress timestamp
    @param[in]  aTsValid                Flag indicating whether the egress
                                        timestamp is valid or not

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             PDU transmission handled successfully by
                                        the state machine
    @retval     #BCM_ERR_BUSY           The state machine is not able to handle
                                        the PDU transmission at this point

    @post None

    @trace  #BRCM_SWREQ_ETS_SM

    @limitations None
*/
typedef int32_t (*ETS_SMTxPDUHndlrType)(const uint32_t aIntfIndex,
                                        ETS_MsgType aMsgType,
                                        const ETS_TimeType* const aTs,
                                        const uint32_t aTsValid);


/** @brief Change transmission interval handler

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]  aIntfIndex              Interface index
    @param[in]  aInterval               New transmission interval in logarithmic
                                        (base-2) scale

    @return void

    @post None

    @trace  #BRCM_SWREQ_ETS_SM

    @limitations None
*/
typedef void (*ETS_SMChangeTxIntvlHndlrType)(const uint32_t aIntfIndex,
                                             const ETS_LogIntervalType aInterval);

/** @brief Event handler

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]  aIntfIndex              Interface index
    @param[in]  aEvent                  Event type

    @return void

    @post None

    @trace  #BRCM_SWREQ_ETS_SM

    @limitations None
*/
typedef void (*ETS_SMEventHndlrType)(const uint32_t aIntfIndex,
                                     const ETS_EventType aEvent);

/** @brief Get Status Handler

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]  aDomain                 Domain number being ETS_DEFAULT_DOMAIN_NUM
    @param[in]  aIntfIndex              Interface index- ETS_MAX_INTERFACES when not applicable
    @param[out] aStatus                 Pointer to Status

    Return values are documented in reverse-chronological order
    @retval   #BCM_ERR_OK               Retrieved successfully
    @retval   #BCM_ERR_INVAL_PARAMS     aDomain is invalid
                                        OR aIntfIndex is invalid
                                        OR aStatus is NULL

    @post None

    @trace  #BRCM_SWREQ_ETS_SM

    @limitations None
*/
typedef int32_t (*ETS_SMGetStatusType)(const ETS_DomainType aDomain,
                                       const uint32_t aIntfIndex,
                                       ETS_CombinedStatusType* const aStatus);

/**
    @brief Function pointer table for ETS state machines

    Base class for the state machine

    @trace #BRCM_SWREQ_ETS_SM
*/
typedef struct sETS_StateMachineType {
    ETS_SMInitHndlrType          init;          /**< @brief Initialization Handler    */

    ETS_SMDeInitHndlrType        deInit;        /**< @brief De-Initialization Handler */

    ETS_SMCheckTimerHndlrType    timer;         /**< @brief Timer Handler             */

    ETS_SMRxPDUHndlrType         rxPDU;         /**< @brief Received PDU Handler      */

    ETS_SMTxPDUHndlrType         txPDU;         /**< @brief Transmitted PDU Handler   */

    ETS_SMChangeTxIntvlHndlrType changeTxIntvl; /**< @brief Change Interval Handler   */

    ETS_SMEventHndlrType         event;         /**< @brief Event Handler             */
    ETS_SMGetStatusType          getStatus;     /**< @brief Get Status Handler        */
} ETS_StateMachineType;

/**
    @brief ETS State Machine Group type

    A table of supported state machines in a particular mode

    @trace #BRCM_SWREQ_ETS_SM
*/
typedef struct sETS_SMGroupType {
    const ETS_OperModeType mode;          /**< @brief Mode of operation       */
    const ETS_StateMachineType *pdelay;   /**< @brief Pdelay state machine    */
    const ETS_StateMachineType *timesync; /**< @brief Timesync state machine  */
    const ETS_StateMachineType *signal;   /**< @brief Signaling state machine */
    const ETS_StateMachineType *bmca;     /**< @brief BMCA state machine      */
} ETS_SMGroupType;

/**
    @brief AVNU State Machine Group

    A table of supported state machines in AVNU mode

    @trace #BRCM_SWREQ_ETS_SM
*/
extern const ETS_SMGroupType ETS_SMGroupAvnu;

/**
    @brief IEEE 2011 State Machine Group

    A table of supported state machines in IEEE 2011 mode

    @trace #BRCM_SWREQ_ETS_SM
*/
extern const ETS_SMGroupType ETS_SMGroupIeee2011;

/**
    @brief List of ETS State Machine Groups

    List of ETS State Machine Groups

    @trace #BRCM_SWREQ_ETS_SM
*/
extern const ETS_SMGroupType *ETS_SMGroups[ETS_OPERMODE_MAX];

/**
    @brief Mode Index

    Index of Operational Mode in #ETS_SMGroupType

    @limitations Valid only after a suitable mode is detected during
    initialisation. Otherwise set to #ETS_OPERMODE_MAX

    @trace #BRCM_SWREQ_ETS_SM
*/
extern uint32_t ETS_ModeIndex;

#endif /* ETS_SM_H */

/** @} */
