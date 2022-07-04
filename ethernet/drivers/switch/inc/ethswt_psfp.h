/*****************************************************************************
 Copyright 2020 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_ethswt_psfp_ifc PSFP Interface
    @ingroup grp_ethswt

    @addtogroup grp_ethswt_psfp_ifc
    @{

    @file ethswt_psfp.h

    @brief Interface for PSFP
    This file provides the interface/APIs which can be used to initialize,
    configure and add/remove rules to/from the PSFP block.

    @version 0.1 Initial version
*/

#ifndef ETHSWT_PSFP_H
#define ETHSWT_PSFP_H

#include <stdint.h>
#include "eth_switch.h"
#include "ethswt_cfp.h"

/**
    @name PSFP Architecture IDs
    @{
    @brief Architecture IDs for PSFP
*/
#define BRCM_SWARCH_ETHSWT_PSFP_CONFIG_MAGIC_ID_MACRO                      (0x8801U)    /**< @brief #ETHSWT_PSFP_CONFIG_MAGIC_ID                   */
#define BRCM_SWARCH_ETHSWT_PSFP_MAX_GATE_INTERVAL_MACRO                    (0x8802U)    /**< @brief #ETHSWT_PSFP_MAX_GATE_INTERVAL                 */
#define BRCM_SWARCH_ETHSWT_PSFP_ACTION_TYPE                                (0x8803U)    /**< @brief #ETHSWT_PSFPActionDefsType                     */
#define BRCM_SWARCH_ETHSWT_PSFPACTION_TYPE                                 (0x8804U)    /**< @brief #ETHSWT_PSFPActionType                         */
#define BRCM_SWARCH_ETHSWT_PSFP_CONFIG_TYPE                                (0x8805U)    /**< @brief #ETHSWT_PSFPConfigType                         */
#define BRCM_SWARCH_ETHSWT_PSFP_GATECFG_TYPE                               (0x8806U)    /**< @brief #ETHSWT_PSFPGateCfgType                        */
#define BRCM_SWARCH_ETHSWT_PSFP_GATE_TYPE                                  (0x8807U)    /**< @brief #ETHSWT_PSFPGateDefsType                       */
#define BRCM_SWARCH_ETHSWT_PSFP_METERCFG_TYPE                              (0x8808U)    /**< @brief #ETHSWT_PSFPMeterCfgType                       */
#define BRCM_SWARCH_ETHSWT_PSFP_METER_TYPE                                 (0x8809U)    /**< @brief #ETHSWT_PSFPMeterDefsType                      */
#define BRCM_SWARCH_ETHSWT_PSFP_RULE_TYPE                                  (0x880AU)    /**< @brief #ETHSWT_PSFPRuleType                           */
#define BRCM_SWARCH_ETHSWT_PSFP_RULESTATUS_TYPE                            (0x880BU)    /**< @brief #ETHSWT_PSFPRuleStatusType                     */
#define BRCM_SWARCH_ETHSWT_PSFP_CONFIGUREGATE_PROC                         (0x880CU)    /**< @brief #ETHSWT_PSFPConfigureGate                      */
#define BRCM_SWARCH_ETHSWT_PSFP_CONFIGUREMETER_PROC                        (0x880DU)    /**< @brief #ETHSWT_PSFPConfigureMeter                     */
#define BRCM_SWARCH_ETHSWT_PSFP_INIT_PROC                                  (0x880EU)    /**< @brief #ETHSWT_PSFPInit                               */
#define BRCM_SWARCH_ETHSWT_PSFP_DEINIT_PROC                                (0x880FU)    /**< @brief #ETHSWT_PSFPDeInit                             */
#define BRCM_SWARCH_ETHSWT_PSFP_DISABLEPORT_PROC                           (0x8810U)    /**< @brief #ETHSWT_PSFPDisablePort                        */
#define BRCM_SWARCH_ETHSWT_PSFP_ENABLEPORT_PROC                            (0x8811U)    /**< @brief #ETHSWT_PSFPEnablePort                         */
#define BRCM_SWARCH_ETHSWT_PSFP_GETROWCONFIG_PROC                          (0x8812U)    /**< @brief #ETHSWT_PSFPGetRowConfig                       */
#define BRCM_SWARCH_ETHSWT_PSFP_GETSNAPSHOT_PROC                           (0x8813U)    /**< @brief #ETHSWT_PSFPGetSnapshot                        */
#define BRCM_SWARCH_ETHSWT_PSFP_GETROWSTATS_PROC                           (0x8814U)    /**< @brief #ETHSWT_PSFPGetRowStats                        */
#define BRCM_SWARCH_ETHSWT_PSFP_UPDATERULE_PROC                            (0x8815U)    /**< @brief #ETHSWT_PSFPUpdateRule                         */
#define BRCM_SWARCH_ETHSWT_PSFP_REMOVERULE_PROC                            (0x8816U)    /**< @brief #ETHSWT_PSFPRemoveRule                         */
#define BRCM_SWARCH_ETHSWT_PSFP_ADDRULE_PROC                               (0x8817U)    /**< @brief #ETHSWT_PSFPAddRule                            */
#define BRCM_SWARCH_ETHSWT_PSFP_GETGATECONFIG_PROC                         (0x8818U)    /**< @brief #ETHSWT_PSFPGetGateConfig                      */
#define BRCM_SWARCH_ETHSWT_PSFP_GETMETERCONFIG_PROC                        (0x8819U)    /**< @brief #ETHSWT_PSFPGetMeterConfig                     */
#define BRCM_SWARCH_ETHSWT_PSFP_SNAPSHOT_TYPE                              (0x881AU)    /**< @brief #ETHSWT_PSFPSnapshotType                       */
#define BRCM_SWARCH_ETHSWT_PSFP_ENTRY_TYPE                                 (0x881BU)    /**< @brief #ETHSWT_PSFPEntryDefsType                      */
#define BRCM_SWARCH_ETHSWT_PSFP_GATE_INTERVAL_MAX_OCTET_CFG_COUNT_MACRO    (0x881CU)    /**< @brief #ETHSWT_PSFP_GATE_INTERVAL_MAX_OCTET_CFG_COUNT */
#define BRCM_SWARCH_ETHSWT_PSFPGATESTATE_TYPE                              (0x881DU)    /**< @brief #ETHSWT_PSFPGateStateType                      */
#define BRCM_SWARCH_ETHSWT_PSFPGATEGLOBALCFG_TYPE                          (0x881EU)    /**< @brief #ETHSWT_PSFPGateGlobalCfgType                  */
#define BRCM_SWARCH_ETHSWT_PSFP_ROWSTATS_TYPE                              (0x881FU)    /**< @brief #ETHSWT_PSFPRowStatsType                       */
#define BRCM_SWARCH_ETHSWT_PSFP_UNBLOCKROW_PROC                            (0x8820U)    /**< @brief #ETHSWT_PSFPUnblockRow                         */
#define BRCM_SWARCH_ETHSWT_PSFP_ENABLEGATESONNETTIMESYNC_PROC              (0x8821U)    /**< @brief #ETHSWT_PSFPEnableGatesOnNetTimeSync           */
#define BRCM_SWARCH_ETHSWT_PSFPEVENT_TYPE                                  (0x8822U)    /**< @brief #ETHSWT_PSFPEventType                          */
#define BRCM_SWARCH_ETHSWT_PSFP_GETEVENTS_PROC                             (0x8823U)    /**< @brief #ETHSWT_PSFPGetEvents                          */
#define BRCM_SWARCH_ETHSWT_PSFP_EVENT_TYPE                                 (0x8824U)    /**< @brief #ETHSWT_PSFPEventDefsType                      */
/** @} */

/**
    @brief Magic number for the configuration structure, containing 'PSFP'

    @trace #BRCM_SWREQ_ETHSWT_PSFP
*/
#define ETHSWT_PSFP_CONFIG_MAGIC_ID                     (0x50534650UL)

/**
    @brief Maximum number of time intervals in a PSFP gate

    @trace #BRCM_SWREQ_ETHSWT_PSFP
*/
#define ETHSWT_PSFP_MAX_GATE_INTERVAL                   (16UL)

/**
    @brief Total number of gate interval octets configuration registers

    @trace #BRCM_SWREQ_ETHSWT_PSFP
*/
#define ETHSWT_PSFP_GATE_INTERVAL_MAX_OCTET_CFG_COUNT   (6U)

/**
    @name PSFP Action definitions
    @{
    @brief Definitions for PSFP actions

    @trace #BRCM_SWREQ_ETHSWT_PSFP
*/
typedef uint8_t ETHSWT_PSFPActionDefsType;                         /**< @brief typedef for PSFP action definitions */
#define ETHSWT_PSFP_ACTION_STRBLOCK_OVSIZEFRAME_MASK   (0x1UL)     /**< @brief Mask for blocking stream on oversize frame */
#define ETHSWT_PSFP_ACTION_STRBLOCK_OVSIZEFRAME_SHIFT  (0UL)       /**< @brief Bit shift for blocking stream on oversize frame */
#define ETHSWT_PSFP_ACTION_ENABLEGATECHECK_MASK        (0x2UL)     /**< @brief Mask for enabling gate check */
#define ETHSWT_PSFP_ACTION_ENABLEGATECHECK_SHIFT       (1UL)       /**< @brief Bit shift for enabling gate check */
#define ETHSWT_PSFP_ACTION_ENABLEMETERCHECK_MASK       (0x4UL)     /**< @brief Mask for enabling meter check */
#define ETHSWT_PSFP_ACTION_ENABLEMETERCHECK_SHIFT      (2UL)       /**< @brief Bit shift for enabling meter check */
#define ETHSWT_PSFP_ACTION_ENABLEMAXSDUCHECK_MASK      (0x8UL)     /**< @brief Mask for enabling Max SDU check */
#define ETHSWT_PSFP_ACTION_ENABLEMAXSDUCHECK_SHIFT     (3UL)       /**< @brief Bit shift for enabling Max SDU check */
/** @} */

/**
    @brief PSFP Action Configuration

    @trace #BRCM_SWREQ_ETHSWT_PSFP
*/
typedef struct COMP_PACKED sETHSWT_PSFPActionType {
    ETHSWT_PSFPActionDefsType   flags;             /**< @brief PSFP action configuration fields encoded in a bitfield as follows:
                                                        Resv (4), EnableMaxSDUCheck (1)  EnableFlowMeter (1), EnableGateCheck (1), EnableStrBlockIfOversize (1) */
    uint8_t                     meterID;           /**< @brief meter to which the stream row is mapped */
    uint8_t                     gateID;            /**< @brief Gate to which the stream row is mapped */
    uint16_t                    maxSDUSizeBytes;   /**< @brief Max SDU size that is allowed for the stream row
                                                        Value '0' indicates that MAX SDU check is not done for frames */
    uint16_t                    chainID;           /**< @brief Chain ID */
}ETHSWT_PSFPActionType;

/**
    @name PSFP Gate definitions
    @{
    @brief Definitions for PSFP Gates

    @trace #BRCM_SWREQ_ETHSWT_PSFP
*/
typedef uint32_t ETHSWT_PSFPGateDefsType;                                     /**< @brief typedef for PSFP Gate definitions */
#define ETHSWT_PSFP_GATE_FLAGS_GATECLOSEOCTETEXCEEDED_MASK    (0x1UL)         /**< @brief Mask for gate close on octets exceeded */
#define ETHSWT_PSFP_GATE_FLAGS_GATECLOSEOCTETEXCEEDED_SHIFT   (0UL)           /**< @brief Bit shift for gate close on octets exceeded */
#define ETHSWT_PSFP_GATE_FLAGS_GATECLOSEINVALIDRX_MASK        (0x2UL)         /**< @brief Mask for gate close on invalid Rx */
#define ETHSWT_PSFP_GATE_FLAGS_GATECLOSEINVALIDRX_SHIFT       (1UL)           /**< @brief Bit shift for gate close on invalid Rx */
#define ETHSWT_PSFP_GATE_BASETIMESECS_MASK                    (0x3FUL)        /**< @brief Mask for config base time in secs */
#define ETHSWT_PSFP_GATE_BASETIMESECS_SHIFT                   (0UL)           /**< @brief Bit shift for config base time in secs */
#define ETHSWT_PSFP_GATE_BASETIMENS_MASK                      (0x3FFFFFFFUL)  /**< @brief Mask for config base time in nanosecs */
#define ETHSWT_PSFP_GATE_BASETIMENS_SHIFT                     (0UL)           /**< @brief Bit shift for config base time in nanosecs */
#define ETHSWT_PSFP_GATE_CYCLETIME_MASK                       (0x3FFFFFFFUL)  /**< @brief Mask for gate cycle time */
#define ETHSWT_PSFP_GATE_CYCLETIME_SHIFT                      (0UL)           /**< @brief Bit shift for gate cycle time */
#define ETHSWT_PSFP_GATE_CYCLETIMEEXTN_MASK                   (0x3FFFFFFFUL)  /**< @brief Mask for gate cycle time extension */
#define ETHSWT_PSFP_GATE_CYCLETIMEEXTN_SHIFT                  (0UL)           /**< @brief Bit shift for cycle time extension */
#define ETHSWT_PSFP_GATE_INTERVAL_MASK                        (0x1FFF80UL)    /**< @brief Mask for gate interval time */
#define ETHSWT_PSFP_GATE_INTERVAL_SHIFT                       (7UL)           /**< @brief Bit shift for gate interval time */
#define ETHSWT_PSFP_GATE_MAXOCTET_MASK                        (0x70UL)        /**< @brief Mask for number of allowed octets in a gate interval */
#define ETHSWT_PSFP_GATE_MAXOCTET_SHIFT                       (4UL)           /**< @brief Bit shift for number of allowed octets in a gate interval */
#define ETHSWT_PSFP_GATE_IPV_MASK                             (0xEUL)         /**< @brief Mask for IPV for a gate interval */
#define ETHSWT_PSFP_GATE_IPV_SHIFT                            (1UL)           /**< @brief Bit shift for IPV for a gate interval */
#define ETHSWT_PSFP_GATE_STATE_MASK                           (0x1UL)         /**< @brief Mask for gate state */
#define ETHSWT_PSFP_GATE_STATE_SHIFT                          (0UL)           /**< @brief Bit shift for gate state */
/** @} */

/**
    @brief Structure for PSFP Gate configuration

    @trace #BRCM_SWREQ_ETHSWT_PSFP
*/
typedef struct COMP_PACKED sETHSWT_PSFPGateCfgType {
    uint8_t     flags;                /**< @brief Resv (6), GateCloseInvalidRx (1) - Gate is permanently closed because
                                           of the event of packet arriving when the Gate was closed,
                                           GateCloseOctetsExceed (1) - Gate is permanently closed because of the exhaustion
                                           of octets available in one of the Gate Control List entries*/
    uint8_t     baseTimeSecs;         /**< @brief Resv (2), Time in seconds at which the config needs to be applied (6)
                                           baseTime programmed should be at least 1 second away from time of the day*/
    uint32_t    baseTimeNs;           /**< @brief Resv (2), Time in nanoseconds at which the config needs to be applied (30) */
    uint32_t    cycleTime;            /**< @brief Resv (2), Gate cycle time in ns (30) */
    uint32_t    cycleTimeExtension;   /**< @brief Resv (2), Gate cycle time extension in ns (30) */
    uint32_t    controlList[ETHSWT_PSFP_MAX_GATE_INTERVAL];
                                      /**< @brief Resv (11), Interval (14) (each unit is 4ns), MaxOctets for interval (3), IPV (3), state (1) */
    uint8_t     controlListLen;       /**< @brief control list length */
} ETHSWT_PSFPGateCfgType;

/**
    @name PSFP action definitions
    @{
    @brief Definitions for PSFP actions

    @trace #BRCM_SWREQ_ETHSWT_PSFP
*/
typedef uint32_t ETHSWT_PSFPMeterDefsType;                 /**< @brief typedef for meter definitions */
#define ETHSWT_PSFP_METER_TKBKT_SHIFT         (0UL)        /**< @brief Bit shift for token bucket size */
#define ETHSWT_PSFP_METER_TKBKT_MASK          (0xFFFFFFUL) /**< @brief Mask for token bucket size */
#define ETHSWT_PSFP_METER_BKTSZ_SHIFT         (0UL)        /**< @brief Bit shift for burst size */
#define ETHSWT_PSFP_METER_BKTSZ_MASK          (0x1FFFFFUL) /**< @brief Mask for burst size */
#define ETHSWT_PSFP_METER_REFCNT_SHIFT        (0UL)        /**< @brief Bit shift for reference count */
#define ETHSWT_PSFP_METER_REFCNT_MASK         (0xFFFFFUL)  /**< @brief Mask for reference count */
#define ETHSWT_PSFP_METER_COLORMODE_MASK      (0x1UL)      /**< @brief Mask for color mode*/
#define ETHSWT_PSFP_METER_COLORMODE_SHIFT     (0UL)        /**< @brief Bit shift for color mode */
#define ETHSWT_PSFP_METER_CPFLAG_MASK         (0x2UL)      /**< @brief Mask for coupling flag */
#define ETHSWT_PSFP_METER_CPFLAG_SHIFT        (1UL)        /**< @brief Bit shift for coupling flag */
#define ETHSWT_PSFP_METER_ENABLE_MASK         (0x4UL)      /**< @brief Mask for enabling policing */
#define ETHSWT_PSFP_METER_ENABLE_SHIFT        (2UL)        /**< @brief Bit shift for enabling policing */
#define ETHSWT_PSFP_METER_DROP_YELLOW_MASK    (0x8UL)      /**< @brief Mask for drop on yellow packet */
#define ETHSWT_PSFP_METER_DROP_YELLOW_SHIFT   (3UL)        /**< @brief Bit shift for drop on yellow packet */
#define ETHSWT_PSFP_METER_MARK_RED_MASK       (0x10UL)     /**< @brief Mask for drop red packet */
#define ETHSWT_PSFP_METER_MARK_RED_SHIFT      (4UL)        /**< @brief Bit shift for drop red packet */
/** @} */

/**
    @brief Structure for PSFP flow meter configuration

    @trace #BRCM_SWREQ_ETHSWT_PSFP
*/
typedef struct COMP_PACKED sETHSWT_PSFPMeterCfgType {
    uint32_t   cirTkBkt;     /**< @brief Committed token bucket size */
    uint32_t   cirBktSize;   /**< @brief Committed burst size */
    uint32_t   cirRefCnt;    /**< @brief Committed information rate */
    uint32_t   eirTkBkt;     /**< @brief Excess token bucket size */
    uint32_t   eirBktSize;   /**< @brief Excess burst size */
    uint32_t   eirRefCnt;    /**< @brief Excess information rate */
    uint8_t    policerFlags; /**< @brief Policer flags encoded as follows:
                                  resv(3), mark all frames red (1), drop on yellow (1),
                                  enable(1), coupling flag(1), color mode(1) */
} ETHSWT_PSFPMeterCfgType;

/**
    @brief Structure for PSFP Rule

    @trace #BRCM_SWREQ_ETHSWT_PSFP
*/
typedef struct COMP_PACKED sETHSWT_PSFPRuleType {
    ETHSWT_CFPKeyType         key;         /**< @brief key */
    ETHSWT_PSFPActionType     action;      /**< @brief action */
    ETHSWT_CFPRowAndSliceType rowAndSlice; /**< @brief row and slice number encoded as follows:
                                                    resv(2), slice (2), row (12) */
} ETHSWT_PSFPRuleType;

/**
    @name PSFP Gate state type
    @{
    @brief Gate state definitions

    @trace #BRCM_SWREQ_ETHSWT_PSFP
*/
typedef uint32_t ETHSWT_PSFPGateStateType;             /**< @brief Gate states */
#define ETHSWT_PSFPGATESTATE_CLOSE           (0U)      /**< @brief Gate in closed state */
#define ETHSWT_PSFPGATESTATE_OPEN            (1U)      /**< @brief Gate in open state */
/** @} */

/**
    @brief Structure for PSFP Global gate configuration

    @trace #BRCM_SWREQ_ETHSWT_PSFP
*/
typedef struct COMP_PACKED sETHSWT_PSFPGateGlobalCfgType {
    ETHSWT_PSFPGateStateType    initState;              /**< @brief Initial Gate state when gate is disabled or before BEGIN is requested */
    ETHSWT_PSFPGateStateType    ctrlListOverflowState;  /**< @brief Gate state when Control List pointer has overflowed */
    ETHSWT_TCType               initTC;                 /**< @brief Initial Traffic Class when gate is disabled or before BEGIN is requested */
    ETHSWT_TCType               errorTC;                /**< @brief Traffic Class when Gate is in error state */
    uint32_t                    maxOctet[ETHSWT_PSFP_GATE_INTERVAL_MAX_OCTET_CFG_COUNT];
                                                        /**< @brief Max octets selection for gate interval */
} ETHSWT_PSFPGateGlobalCfgType;

/**
    @brief Structure for PSFP config

    @trace #BRCM_SWREQ_ETHSWT_PSFP
*/
typedef struct COMP_PACKED sETHSWT_PSFPConfigType {
    uint32_t                        magicId;                        /**< @brief Magic number 'CFPC'
                                                                         (checked for validity) */
    ETHSWT_PSFPGateGlobalCfgType    gateGlobalCfg;                  /**< @brief Global config of gates */
    uint16_t                        portEnableMask;                 /**< @brief Bitmask of ports
                                                                         where PSFP lookup is enabled */
} ETHSWT_PSFPConfigType;

/**
    @brief Structure for PSFP rule statistics

    @trace #BRCM_SWREQ_ETHSWT_PSFP
*/
typedef struct sETHSWT_PSFPRowStatsType {
    uint32_t numFrmProcessed;           /**< @brief Count of frames matching both the stream_handle and priority specifications */
    uint32_t numFrmMAXSDUFail;          /**< @brief Count of frames that did not pass the Maximum SDU size filter */
    uint32_t numFrmGateFail;            /**< @brief Count of frames that did not pass the stream Gate */
    uint32_t numFrmMeterFail;           /**< @brief Count of frames that were discarded as a result of the operation of the flow meter */
    uint32_t numFrmFailedMaxSDUorGate;  /**< @brief Count of frames that did not pass the Maximum SDU size filter OR Stream Gate */
    uint32_t numFrmFailedMaxSDUorMeter; /**< @brief Count of frames that did not pass the Maximum SDU size filter OR  Flow Meter */
    uint32_t numFrmFailedGateorMeter;   /**< @brief Count of frames that did not pass the stream gate OR Flow Meter */
    uint32_t numFrmFailedAll;           /**< @brief Count of frames that did not pass any of the checks: Max SDU, Stream Gate nor Flow Meter */
} ETHSWT_PSFPRowStatsType;

/**
    @name ETHSWT_PSFPEntryDefsType
    @{
    @brief Definitions for PSFP entry snapshot

    @trace #BRCM_SWREQ_ETHSWT_PSFP
*/
typedef uint8_t ETHSWT_PSFPEntryDefsType;        /**< @brief typedef for entry snapshot field definitions */
#define ETHSWT_PSFP_ENTRY_ENABLE_MASK   (0x80U)  /**< @brief Mask for the enable field in the entry snapshot */
#define ETHSWT_PSFP_ENTRY_ENABLE_SHIFT  (7U)     /**< @brief Bit shift for the enable field in the entry snapshot */
#define ETHSWT_PSFP_ENTRY_STATIC_MASK   (0x40U)  /**< @brief Mask for the static field in the entry snapshot */
#define ETHSWT_PSFP_ENTRY_STATIC_SHIFT  (6U)     /**< @brief Bit shift for the static field in the entry snapshot */
#define ETHSWT_PSFP_ENTRY_SLICE_MASK    (0x30U)  /**< @brief Mask for the slice field in the entry snapshot */
#define ETHSWT_PSFP_ENTRY_SLICE_SHIFT   (4U)     /**< @brief Bit shift for the slice field in the entry snapshot */
#define ETHSWT_PSFP_ENTRY_FORMAT_MASK   (0xCU)   /**< @brief Mask for the format field in the entry snapshot */
#define ETHSWT_PSFP_ENTRY_FORMAT_SHIFT  (2U)     /**< @brief Bit shift for the format field in the entry snapshot */
/** @} */

/**
    @brief Structure for PSFP table snapshot

    @trace #BRCM_SWREQ_ETHSWT_PSFP
*/
typedef struct sETHSWT_PSFPSnapshotType {
    uint32_t                    numValidEntries;                   /**< @brief Number of valid entries */
    ETHSWT_CFPUDFAllocListType  udfList[ETHSWT_CFP_NUM_FORMATS];   /**< @brief List of allocated UDFs per format */
    uint16_t                    portEnableMask;                    /**< @brief Bitmask of ports where PSFP lookup is enabled */
    uint8_t                     timeofdaySecs;                     /**< @brief Time of day - Seconds */
    uint32_t                    timeofdayNs;                       /**< @brief Time of day - Nano Seconds */
    ETHSWT_PSFPEntryDefsType    rule[ETHSWT_PSFP_MAX_RULES];       /**< @brief Rule encoded in a bitfield as follows:
                                                                        Enable (1), Static (1), Slice(2), Format(2), Resv(2) */
    uint8_t                     gate[ETHSWT_PSFP_MAX_NUM_GATES];   /**< @brief Gate encoded in a bitfield as follows:
                                                                        Enable (1), Static (1), Resv(6) */
    uint8_t                     meter[ETHSWT_PSFP_MAX_NUM_METERS]; /**< @brief Meter encoded in a bitfield as follows:
                                                                        Enable (1), Static (1), Resv(6) */
} ETHSWT_PSFPSnapshotType;

/**
    @name PSFP event definitions
    @{
    @brief Definitions for PSFP events

    @trace #BRCM_SWREQ_ETHSWT_PSFP
*/
typedef uint8_t ETHSWT_PSFPEventDefsType;                      /**< @brief typedef for PSFP event definitions */
#define ETHSWT_PSFP_EVENT_MAXSDU_FAILURE_MASK       (0x1U)     /**< @brief Mask for MAX SDU failure event */
#define ETHSWT_PSFP_EVENT_MAXSDU_FAILURE_SHIFT      (0U)       /**< @brief Bit shift for MAX SDU failure event */
#define ETHSWT_PSFP_EVENT_GATE_INVALIDRX_MASK       (0x2U)     /**< @brief Mask for packet drop at gate due to invalid Rx */
#define ETHSWT_PSFP_EVENT_GATE_INVALIDRX_SHIFT      (1U)       /**< @brief Bit shift for packet drop at gate due to invalid Rx */
#define ETHSWT_PSFP_EVENT_GATE_OCTETEXCEEDED_MASK   (0x4U)     /**< @brief Mask for packet drop at gate due to octets exceeded */
#define ETHSWT_PSFP_EVENT_GATE_OCTETEXCEEDED_SHIFT  (2U)       /**< @brief Bit shift for packet drop at gate due to octets exceeded */
#define ETHSWT_PSFP_EVENT_METER_DROP_MASK           (0x8U)     /**< @brief Mask for packet drop at meter */
#define ETHSWT_PSFP_EVENT_METER_DROP_SHIFT          (3U)       /**< @brief Bit shift for packet drop at meter */
#define ETHSWT_PSFP_EVENT_GATE_CONFIG_ABORT_MASK    (0x1U)     /**< @brief Mask for gate config failure due to config abort */
#define ETHSWT_PSFP_EVENT_GATE_CONFIG_ABORT_SHIFT   (0U)       /**< @brief Bit shift for gate config failure due to config abort */
#define ETHSWT_PSFP_EVENT_GATE_BASETIME_ERROR_MASK  (0x2U)     /**< @brief Mask for gate config failure due to admin base time error */
#define ETHSWT_PSFP_EVENT_GATE_BASETIME_ERROR_SHIFT (1U)       /**< @brief Bit shift for gate config failure due to admin base time error */
/** @} */

/**
    @brief Structure for querying the PSFP stream and gate events

    Array of events for each PSFP stream (streamEventMask):
    bit [4-7] : Reserved
    bit [3]   : Packet drop at flow meter
    bit [2]   : Packet drop as gate was closed due to octets exceeded
    bit [1]   : Packet drop as gate is closed due to invalid Rx
    bit [0]   : MAX SDU Failure

    Array of events for each stream gate (gateEventMask):
    bit [2-7] : Reserved
    bit [1]   : Gate event mask for base time error
    bit [0]   : Gate event mask for configuration change abort

    @trace #BRCM_SWREQ_ETHSWT_PSFP
*/
typedef struct sETHSWT_PSFPEventType {
    ETHSWT_PSFPEventDefsType  streamEventMask[ETHSWT_PSFP_MAX_RULES];     /**< @brief Stream event mask */
    ETHSWT_PSFPEventDefsType  gateEventMask[ETHSWT_PSFP_MAX_NUM_GATES];   /**< @brief Gate event mask */
} ETHSWT_PSFPEventType;

/** @brief Initialize PSFP

    @behavior Sync, Re-entrant (for different switch index)

    @pre Switch driver is initialized

    This API initializes the PSFP module with global configuration.

    @param[in]   aID                    Switch index
    @param[in]   aConfig                Pointer to PSFP configuration

    Return values are documented in reverse-chronological order
    @retval  #BCM_ERR_OK                PSFP block initialized successfully
    @retval  #BCM_ERR_INVAL_PARAMS      aConfig is NULL or
                                        #aID is invalid or
                                        Configuration is invalid
    @retval  #BCM_ERR_TIME_OUT          PSFP/Switch Register access timed out
    @retval  #BCM_ERR_NOPERM            CFP block is using TCAM rows reserved for PSFP.
                                        #ETHSWT_PSFP_MAX_RULES number of TCAM rows
                                        not available for PSFP
    @retval  #BCM_ERR_INVAL_MAGIC       Config magic is invalid
    @retval  #BCM_ERR_INVAL_STATE       PSFP is not in reset state

    @post None

    @trace #BRCM_SWREQ_ETHSWT_PSFP

    @limitations None
*/
int32_t ETHSWT_PSFPInit(ETHSWT_HwIDType aID,
                        const ETHSWT_PSFPConfigType* const aConfig);

/** @brief Add a PSFP rule

    @behavior Sync, Re-entrant (for different switch index)

    @pre Switch driver and PSFP is initialized

    This API validates and adds a rule to TCAM. If a valid slice is provided in input,
    the driver tries to accomodate all UDFs of the rule in the slice. If no valid slice is
    provided, the driver tries to allocate the highest slice where all UDFs can be accomodated.
    If required, new UDFs can be allocated in the slice. Similarly, if a valid row number is
    provided as input, the driver checks if it is free and proceeds with programming the rule.
    In the case an entry is already present at the input row, error is returned. If no valid
    row is provided in input, the driver allocates the lowest free row number and
    proceeds with programming the rule.

    @param[in]     aID                 Switch index
    @param[in]     aKey                Key configuration
    @param[in]     aAction             Action configuration
    @param[inout]  aRow                Pointer to the requested row number (set to ETHSWT_PSFP_MAX_RULES
                                       in case the driver needs to allocate) on input. On output
                                       it provides the configured row number
    @param[inout]  aSlice              Pointer to the requested slice number(set to ETHSWT_PSFP_MAX_RULES
                                       in case the driver needs to allocate) on input. On output
                                       it provides the configured slice number

    Return values are documented in reverse-chronological order
    @retval  #BCM_ERR_OK               Rule programmed successfully in PSFP block
    @retval  #BCM_ERR_INVAL_PARAMS     #aID is invalid OR
                                       #aKey/#aAction/#aRow/#aSlice is NULL OR
                                       #aRow or #aSlice is invalid value OR
                                       Configuration provided is invalid
    @retval  #BCM_ERR_TIME_OUT         PSFP/Switch Register access timed out
    @retval  #BCM_ERR_NOMEM            All PSFP rows in TCAM are occupied or unable
                                       to find a slice where the UDFs for this
                                       rule can be accomodated
    @retval  #BCM_ERR_INVAL_STATE      PSFP is not in initialized state
    @retval  #BCM_ERR_NOPERM           Rule already configured at row which is
                                       being requested in aRow

    @post None

    @trace #BRCM_SWREQ_ETHSWT_PSFP

    @limitations None
*/
int32_t ETHSWT_PSFPAddRule(ETHSWT_HwIDType aID,
                           const ETHSWT_CFPKeyType* const aKey,
                           const ETHSWT_PSFPActionType* const aAction,
                           uint32_t* const aRow,
                           uint32_t* const aSlice);

/** @brief Remove a PSFP rule

    @behavior Sync, Re-entrant (for different switch index)

    @pre Switch driver and PSFP is initialized

    This API removes a rule (if it exists) from the PSFP block. It also frees up
    any UDFs which are no longer used after deletion of this rule.

    @param[in]     aID                 Switch index
    @param[in]     aRow                Row number

    Return values are documented in reverse-chronological order
    @retval  #BCM_ERR_OK               Rule removed successfully from PSFP block
    @retval  #BCM_ERR_INVAL_PARAMS     #aRow is not within allowed range for PSFP
                                       #aID is invalid
    @retval  #BCM_ERR_TIME_OUT         PSFP/Switch Register access timed out
    @retval  #BCM_ERR_INVAL_STATE      PSFP is not in initialized state
    @retval  #BCM_ERR_NOT_FOUND        No rule configured at aRow

    @post None

    @trace #BRCM_SWREQ_ETHSWT_PSFP

    @limitations None
*/
int32_t ETHSWT_PSFPRemoveRule(ETHSWT_HwIDType aID,
                              uint32_t aRow);

/** @brief Update a PSFP rule

    @behavior Sync, Re-entrant (for different switch index)

    @pre Switch driver and PSFP is initialized

    This API updates an existing rule in the PSFP block. Note that only the
    action for the specified rule is updated i.e. mapping of the stream row
    to a stream gate or flow meter.

    @param[in]     aID                 Switch index
    @param[in]     aRow                Row number
    @param[in]     aAction             Pointer to action policy configuration

    Return values are documented in reverse-chronological order
    @retval  #BCM_ERR_OK               Action for rule is successfully updated
    @retval  #BCM_ERR_INVAL_PARAMS     #aRow is not within allowed range for PSFP
                                       #aAction is NULL, #aID in invalid
    @retval  #BCM_ERR_TIME_OUT         PSFP/Switch Register access timed out
    @retval  #BCM_ERR_INVAL_STATE      PSFP is not in initialized state
    @retval  #BCM_ERR_NOT_FOUND        No rule configured at aRow

    @post None

    @trace #BRCM_SWREQ_ETHSWT_PSFP

    @limitations None
*/
int32_t ETHSWT_PSFPUpdateRule(ETHSWT_HwIDType aID,
                              uint32_t aRow,
                              const ETHSWT_PSFPActionType* const aAction);

/** @brief Enables all gates after network sync

    @behavior Sync, Re-entrant (for different switch index)

    @pre Switch driver and PSFP is initialized

    User shall invoke this API after network time sync has been achieved.
    This API enables all gates that were added using #ETHSWT_PSFPConfigureGate.
    For all gates added, this API computes a valid AdminBaseTime and enables
    them. This API informs the PSFP module that the device now has network sync.

    @param[in]     aID                 Switch index

    Return values are documented in reverse-chronological order
    @retval  #BCM_ERR_OK               All gates successfully enabled
    @retval  #BCM_ERR_INVAL_PARAMS     #aID is invalid
    @retval  #BCM_ERR_TIME_OUT         PSFP/Switch Register access timed out
    @retval  #BCM_ERR_INVAL_STATE      PSFP is not in initialized state

    @post None

    @trace #BRCM_SWREQ_ETHSWT_PSFP

    @limitations None
*/
int32_t ETHSWT_PSFPEnableGatesOnNetTimeSync(ETHSWT_HwIDType aID);

/** @brief Configure a stream gate

    @behavior Sync, Re-entrant (for different switch index)

    @pre Switch driver and PSFP is initialized

    This API enables/disables a stream gate. When a stream gate is being
    added/enabled, the input configuration is applied to the gate.
    Note that the baseTime programmed should be at least 1 second away from
    time of the day. Once a new gate is enabled, any added
    PSFP rules can be mapped to it.

    @param[in]     aID                 Switch index
    @param[in]     aGateID             ID of Gate to be configured
    @param[in]     aGate               Stream gate configuration
    @param[in]     aIsEnable           Boolean to indicate whether to
                                       enable/disable the specified stream gate

    Return values are documented in reverse-chronological order
    @retval  #BCM_ERR_OK               Stream gate successfully enabled/disabled
    @retval  #BCM_ERR_INVAL_PARAMS     #aID/#aGateID is invalid or
                                       #aGate is NULL and aIsEnable is 1UL
                                       #aGate configuration is invalid
    @retval  #BCM_ERR_TIME_OUT         PSFP/Switch Register access timed out
    @retval  #BCM_ERR_INVAL_STATE      PSFP is not in initialized state
    @retval  #BCM_ERR_INVAL_NOPERM     When a gate is being disabled and there
                                       are active PSFP rule mappings to the
                                       same gate
    @post None

    @trace #BRCM_SWREQ_ETHSWT_PSFP

    @limitations None
*/
int32_t ETHSWT_PSFPConfigureGate(ETHSWT_HwIDType aID,
                                 uint8_t aGateID,
                                 const ETHSWT_PSFPGateCfgType* const aGate,
                                 uint32_t aIsEnable);

/** @brief Configure a flow meter

    @behavior Sync, Re-entrant (for different switch index)

    @pre Switch driver and PSFP is initialized

    This API enables/disables a flowmeter. When a flowmeter is being
    enabled, the input configuration is applied to it. Once a new
    flowmeter is enabled, any added PSFP rules can be mapped
    to it.

    @param[in]     aID                 Switch index
    @param[in]     aMeterID            ID of meter to be configured
    @param[in]     aMeter              Flow meter configuration
    @param[in]     aIsEnable           Boolean to indicate whether to
                                       enable/disable the specified flow meter

    Return values are documented in reverse-chronological order
    @retval  #BCM_ERR_OK               Flow meter successfully enabled/disabled
    @retval  #BCM_ERR_INVAL_PARAMS     #aID/#aMeterID is invalid or
                                       #aMeter is NULL and #aIsEnable is 1UL or
                                       #aMeter configuration is invalid
    @retval  #BCM_ERR_TIME_OUT         PSFP/Switch Register access timed out
    @retval  #BCM_ERR_INVAL_STATE      PSFP is not in initialized state
    @retval  #BCM_ERR_INVAL_NOPERM     When a meter is being disabled and there
                                       are active PSFP rule mappings to the
                                       same meter

    @post None

    @trace #BRCM_SWREQ_ETHSWT_PSFP

    @limitations None
*/
int32_t ETHSWT_PSFPConfigureMeter(ETHSWT_HwIDType aID,
                                  uint8_t aMeterID,
                                  const ETHSWT_PSFPMeterCfgType* const aMeter,
                                  uint32_t aIsEnable);

/** @brief Get statistic counters for a PSFP rule added at a sepcific row

    @behavior Sync, Re-entrant (for different switch index)

    @pre Switch driver and PSFP is initialized

    This API fetches the statistics for the existing PSFP rule.

    @param[in]     aID               Switch index
    @param[in]     aRow              Row number
    @param[out]    aStats            Pointer to output memory

    Return values are documented in reverse-chronological order
    @retval  #BCM_ERR_OK             Status/Events fetched successfully
    @retval  #BCM_ERR_INVAL_PARAMS   #aID is invalid or #aStatus is NULL or
                                     #aRow is not a valid PSFP row
    @retval  #BCM_ERR_TIME_OUT       PSFP/Switch Register access timed out
    @retval  #BCM_ERR_INVAL_STATE    PSFP is not in initialized state
    @retval  #BCM_ERR_NOT_FOUND      No rule configured at aRow

    @post None

    @trace #BRCM_SWREQ_ETHSWT_PSFP

    @limitations None
*/
int32_t ETHSWT_PSFPGetRowStats(ETHSWT_HwIDType aID,
                               uint32_t aRow,
                               ETHSWT_PSFPRowStatsType *const aStats);

/** @brief Query the PSFP stream and gate configuration events

    @behavior Sync, Re-entrant (for different switch index)

    @pre Switch driver and PSFP is initialized

    This API provides the event masks for all the PSFP streams that
    are added and for any gate configuration failure. Whenever an interrupt
    is got from hardware, these masks are updated and stored in driver.
    Once the client reads this event mask by invoking this API, the mask
    is cleared in the driver context.

    @param[in]     aID               Switch index
    @param[out]    aEvent            Event mask for all PSFP streams and
                                     gates

    Return values are documented in reverse-chronological order
    @retval  #BCM_ERR_OK             Interrupt events read successfully
    @retval  #BCM_ERR_INVAL_PARAMS   #aID is invalid or
                                     #aEvent is NULL
    @retval  #BCM_ERR_INVAL_STATE    PSFP is not in initialized state

    @post None

    @trace #BRCM_SWREQ_ETHSWT_PSFP

    @limitations None
*/
int32_t ETHSWT_PSFPGetEvents(ETHSWT_HwIDType aID,
                             ETHSWT_PSFPEventType *aEvent);

/** @brief Unblock any streams which are blocked

    @behavior Sync, Re-entrant (for different switch index)

    @pre Switch driver and PSFP is initialized

    This API unblocks the stream and its mapped gates in case it was
    blocked due to an earlier event.

    @param[in]     aID               Switch index
    @param[in]     aRow              Row number

    Return values are documented in reverse-chronological order
    @retval  #BCM_ERR_OK             Interrupts cleared successfully
    @retval  #BCM_ERR_INVAL_PARAMS   #aID is invalid or
                                     #aRow is not a valid PSFP row
    @retval  #BCM_ERR_TIME_OUT       PSFP/Switch Register access timed out
    @retval  #BCM_ERR_INVAL_STATE    PSFP is not in initialized state
    @retval  #BCM_ERR_NOT_FOUND      No rule configured at aRow

    @post None

    @trace #BRCM_SWREQ_ETHSWT_PSFP

    @limitations None
*/
int32_t ETHSWT_PSFPUnblockRow(ETHSWT_HwIDType aID,
                              uint32_t aRow);

/** @brief Get configuration for a PSFP rule at specified row

    @behavior Sync, Re-entrant (for different switch index)

    @pre Switch driver and PSFP is initialized

    This API fetches the configuration for an existing PSFP row

    @param[in]     aID              Switch index
    @param[in]     aRow             Row number
    @param[out]    aConfig          Pointer to location to store configuration

    Return values are documented in reverse-chronological order
    @retval  #BCM_ERR_OK            Configuration fetched successfully
    @retval  #BCM_ERR_INVAL_PARAMS  #aID is not valid or
                                    #aConfig is NULL or
                                    #aRow is not a valid PSFP row
    @retval  #BCM_ERR_TIME_OUT      PSFP/Switch Register access timed out
    @retval  #BCM_ERR_INVAL_STATE   PSFP is not in initialized state
    @retval  #BCM_ERR_NOT_FOUND     No rule configured at aRow

    @post None

    @trace #BRCM_SWREQ_ETHSWT_PSFP

    @limitations None
*/
int32_t ETHSWT_PSFPGetRowConfig(ETHSWT_HwIDType aID,
                                uint32_t aRow,
                                ETHSWT_PSFPRuleType *const aConfig);

/** @brief Get configuration for a PSFP stream gate

    @behavior Sync, Re-entrant (for different switch index)

    @pre Switch driver and PSFP is initialized

    This API fetches the configuration for initialized PSFP stream gate

    @param[in]     aID              Switch index
    @param[in]     aGateID          Gate ID
    @param[out]    aConfig          Pointer to location to store configuration

    Return values are documented in reverse-chronological order
    @retval  #BCM_ERR_OK            Configuration fetched successfully
    @retval  #BCM_ERR_INVAL_PARAMS  #aID is not valid or
                                    #aConfig is NULL or
                                    #aGateID is not a valid PSFP gate
    @retval  #BCM_ERR_TIME_OUT      PSFP/Switch Register access timed out
    @retval  #BCM_ERR_INVAL_STATE   PSFP is not in initialized state
    @retval  #BCM_ERR_NOT_FOUND     Stream Gate is not in enabled state

    @post None

    @trace #BRCM_SWREQ_ETHSWT_PSFP

    @limitations None
*/
int32_t ETHSWT_PSFPGetGateConfig(ETHSWT_HwIDType aID,
                                 uint8_t aGateID,
                                 ETHSWT_PSFPGateCfgType *const aConfig);

/** @brief Get configuration for a PSFP meter

    @behavior Sync, Re-entrant (for different switch index)

    @pre Switch driver and PSFP is initialized

    This API fetches the configuration for initialized PSFP meter

    @param[in]     aID              Switch index
    @param[in]     aMeterID         Meter ID
    @param[out]    aConfig          Pointer to location to store configuration

    Return values are documented in reverse-chronological order
    @retval  #BCM_ERR_OK            Configuration fetched successfully
    @retval  #BCM_ERR_INVAL_PARAMS  #aID is not valid or
                                    #aConfig is NULL or
                                    #aMeterID is not a valid PSFP flowmeter
    @retval  #BCM_ERR_TIME_OUT      PSFP/Switch Register access timed out
    @retval  #BCM_ERR_INVAL_STATE   PSFP is not in initialized state
    @retval  #BCM_ERR_NOT_FOUND     Stream meter is not in enabled state

    @post None

    @trace #BRCM_SWREQ_ETHSWT_PSFP

    @limitations None
*/
int32_t ETHSWT_PSFPGetMeterConfig(ETHSWT_HwIDType aID,
                                  uint8_t aMeterID,
                                  ETHSWT_PSFPMeterCfgType *const aConfig);

/** @brief Get summarised snapshot of the PSFP table

    @behavior Sync, Re-entrant (for different switch index)

    @pre Switch driver and PSFP is initialized

    This API fetches the summarised snapshot of the PSFP table

    @param[in]     aID               Switch index
    @param[out]    aSnapshot         Pointer to location to store PSFP snapshot

    Return values are documented in reverse-chronological order
    @retval  #BCM_ERR_OK             Snapshot fetched successfully
    @retval  #BCM_ERR_INVAL_PARAMS   aSnapshot is NULL or #aID is invalid
    @retval  #BCM_ERR_INVAL_STATE    PSFP is not in initialized state

    @post None

    @trace #BRCM_SWREQ_ETHSWT_PSFP

    @limitations None
*/
int32_t ETHSWT_PSFPGetSnapshot(ETHSWT_HwIDType aID,
                               ETHSWT_PSFPSnapshotType *const aSnapshot);

/** @brief Enable PSFP lookup on a port

    @behavior Sync, Re-entrant (for different switch index)

    @pre Switch driver and PSFP is initialized

    This API enables PSFP lookup on a port

    @param[in]     aID               Switch index
    @param[in]     aPortNum          Port number

    Return values are documented in reverse-chronological order
    @retval  #BCM_ERR_OK             Port enabled successfully
    @retval  #BCM_ERR_INVAL_PARAMS   #aID is invalid or port number is invalid
    @retval  #BCM_ERR_TIME_OUT       PSFP/Switch Register access timed out
    @retval  #BCM_ERR_INVAL_STATE    PSFP is not in initialized state

    @post None

    @trace #BRCM_SWREQ_ETHSWT_PSFP

    @limitations None
*/
int32_t ETHSWT_PSFPEnablePort(ETHSWT_HwIDType aID,
                              uint32_t aPortNum);

/** @brief Disable PSFP lookup on a port

    @behavior Sync, Re-entrant (for different switch index)

    @pre Switch driver and PSFP is initialized

    This API disables PSFP lookup on a port

    @param[in]     aID               Switch index
    @param[in]     aPortNum          Port number

    Return values are documented in reverse-chronological order
    @retval  #BCM_ERR_OK             Port disabled successfully
    @retval  #BCM_ERR_INVAL_PARAMS   #aID is invalid or port number is invalid
    @retval  #BCM_ERR_TIME_OUT       PSFP/Switch Register access timed out
    @retval  #BCM_ERR_INVAL_STATE    PSFP is not in initialized state

    @post None

    @trace #BRCM_SWREQ_ETHSWT_PSFP

    @limitations None
*/
int32_t ETHSWT_PSFPDisablePort(ETHSWT_HwIDType aID,
                               uint32_t aPortNum);

/** @brief De-Initialize PSFP

    @behavior Sync, Re-entrant (for different switch index)

    @pre PSFP, Switch driver is initialized

    This API de-initializes the PSFP block. It disables the feature on
    all ports and frees up the #ETHSWT_PSFP_MAX_RULES entries from TCAM.

    @param[in]   aID                   Switch index

    Return values are documented in reverse-chronological order
    @retval  #BCM_ERR_OK               PSFP block de-initialized successfully
    @retval  #BCM_ERR_INVAL_PARAMS     #aID is invalid
    @retval  #BCM_ERR_TIME_OUT         PSFP/Switch Register access timed out
    @retval  #BCM_ERR_INVAL_STATE      PSFP is already in reset state

    @post None

    @trace #BRCM_SWREQ_ETHSWT_PSFP

    @limitations None
*/
int32_t ETHSWT_PSFPDeInit(ETHSWT_HwIDType aID);

#endif /* ETHSWT_PSFP_H */
/** @} */
