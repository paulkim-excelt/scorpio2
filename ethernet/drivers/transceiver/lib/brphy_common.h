/*****************************************************************************
 Copyright 2020-2022 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_eth_xcvrdrv_brphy_common_imp BRPHY Driver common Interface
    @ingroup grp_eth_xcvrdrv

    @addtogroup grp_eth_xcvrdrv_brphy_common_imp
    @{

    @file brphy_common.h
*/

#ifndef BRPHY_COMMON_H
#define BRPHY_COMMON_H

#include <ethxcvr.h>
#include <ethxcvr_osil.h>
#include <brphy_core_rdb.h>
#include <brphy_mii_rdb.h>

/**
    @name BRPHY API IDs
    @{
    @brief API IDs for BRPHY driver
*/
#define BRCM_SWARCH_BRPHY_RWDATA_TYPE                        (0x8301U)    /**< @brief #BRPHY_RWDataType                 */
#define BRCM_SWARCH_BRPHY_RWDATA_GLOBAL                      (0x8302U)    /**< @brief #BRPHY_RWData                     */
#define BRCM_SWARCH_BRPHY_GETMASTERMODE_PROC                 (0x8303U)    /**< @brief #BRPHY_GetMasterMode              */
#define BRCM_SWARCH_BRPHY_SETMASTERMODE_PROC                 (0x8304U)    /**< @brief #BRPHY_SetMasterMode              */
#define BRCM_SWARCH_BRPHY_COMMONSETMODE_PROC                 (0x8305U)    /**< @brief #BRPHY_CommonSetMode              */
#define BRCM_SWARCH_BRPHY_SETMODE_PROC                       (0x8306U)    /**< @brief #BRPHY_SetMode                    */
#define BRCM_SWARCH_BRPHY_GETLOOPBACKMODE_PROC               (0x8307U)    /**< @brief #BRPHY_GetLoopbackMode            */
#define BRCM_SWARCH_BRPHY_SETLOOPBACKMODE_PROC               (0x8308U)    /**< @brief #BRPHY_SetLoopbackMode            */
#define BRCM_SWARCH_BRPHY_COMMONSETWAKEUPMODE_PROC           (0x8309U)    /**< @brief #BRPHY_CommonSetWakeUpMode        */
#define BRCM_SWARCH_BRPHY_COMMONGETWAKEUPREASON_PROC         (0x830AU)    /**< @brief #BRPHY_CommonGetWakeUpReason      */
#define BRCM_SWARCH_BRPHY_COMMONSETAUTONEGMODE_PROC          (0x830BU)    /**< @brief #BRPHY_CommonSetAutoNegMode       */
#define BRCM_SWARCH_BRPHY_COMMONRESTARTAUTONEG_PROC          (0x830CU)    /**< @brief #BRPHY_CommonRestartAutoNeg       */
#define BRCM_SWARCH_BRPHY_COMMONGETAUTONEGSTATUS_PROC        (0x830DU)    /**< @brief #BRPHY_CommonGetAutoNegStatus     */
#define BRCM_SWARCH_BRPHY_COMMONGETSTATS_PROC                (0x830EU)    /**< @brief #BRPHY_CommonGetStats             */
#define BRCM_SWARCH_BRPHY_COMMONSTATEHANDLER_PROC            (0x830FU)    /**< @brief #BRPHY_CommonStateHandler         */
#define BRCM_SWARCH_BRPHY_COMMONUPDATEHWSTATUS_PROC          (0x8310U)    /**< @brief #BRPHY_CommonUpdateHWStatus       */
#define BRCM_SWARCH_BRPHY_COMMONLINKIRQHANDLER_PROC          (0x8311U)    /**< @brief #BRPHY_CommonLinkIRQHandler       */
#define BRCM_SWARCH_BRPHY_COMMONLINKCHANGEINDHANDLER_PROC    (0x8312U)    /**< @brief #BRPHY_CommonLinkChangeIndHandler */
#define BRCM_SWARCH_BRPHY_COMMONGETWAKEUPMODE_PROC           (0x8313U)    /**< @brief #BRPHY_CommonGetWakeUpMode        */
#define BRCM_SWARCH_BRPHY_COMMONGETJUMBOMODE_PROC            (0x8314U)    /**< @brief #BRPHY_CommonGetJumboMode         */
#define BRCM_SWARCH_BRPHY_COMMONGETLINKSTATE_PROC            (0x8315U)    /**< @brief #BRPHY_CommonGetLinkState         */
#define BRCM_SWARCH_BRPHY_COMMONGETSQIVALUE_PROC             (0x8316U)    /**< @brief #BRPHY_CommonGetSQIValue          */
#define BRCM_SWARCH_BRPHY_COMMONSETJUMBOMODE_PROC            (0x8317U)    /**< @brief #BRPHY_CommonSetJumboMode         */
#define BRCM_SWARCH_BRPHY_COMMONDEINIT_PROC                  (0x8318U)    /**< @brief #BRPHY_CommonDeInit               */
#define BRCM_SWARCH_BRPHY_COMMONINIT_PROC                    (0x8319U)    /**< @brief #BRPHY_CommonInit                 */
#define BRCM_SWARCH_BRPHY_COMMONRESET_PROC                   (0x831AU)    /**< @brief #BRPHY_CommonReset                */
#define BRCM_SWARCH_BRPHY_COMMONSETFLOWCONTROL_PROC          (0x831BU)    /**< @brief #BRPHY_CommonSetFlowControl       */
#define BRCM_SWARCH_BRPHY_COMMONGETFLOWCONTROL_PROC          (0x831CU)    /**< @brief #BRPHY_CommonGetFlowControl       */
#define BRCM_SWARCH_BRPHY_COMMONSETDUPLEXMODE_PROC           (0x831DU)    /**< @brief #BRPHY_CommonSetDuplexMode        */
#define BRCM_SWARCH_BRPHY_COMMONGETDUPLEXMODE_PROC           (0x831EU)    /**< @brief #BRPHY_CommonGetDuplexMode        */
#define BRCM_SWARCH_BRPHY_COMMONGETSPEED_PROC                (0x831FU)    /**< @brief #BRPHY_CommonGetSpeed             */
#define BRCM_SWARCH_BRPHY_COMMONSETSPEED_PROC                (0x8320U)    /**< @brief #BRPHY_CommonSetSpeed             */
#define BRCM_SWARCH_BRPHY_COMMONGETMODE_PROC                 (0x8321U)    /**< @brief #BRPHY_CommonGetMode              */
#define BRCM_SWARCH_BRPHY_RESTARTAUTONEG_PROC                (0x8322U)    /**< @brief #BRPHY_RestartAutoNeg             */
#define BRCM_SWARCH_BRPHY_GETAUTONEGSTATUS_PROC              (0x8323U)    /**< @brief #BRPHY_GetAutoNegStatus           */
#define BRCM_SWARCH_BRPHY_CL22_IEEE_REGS_GLOBAL              (0x8324U)    /**< @brief #BRPHY_CL22_IEEE_REGS             */
#define BRCM_SWARCH_BRPHY_GETSQIVALUE_PROC                   (0x8325U)    /**< @brief #BRPHY_GetSQIValue                */

/** @} */


/**
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
*/
typedef struct sBRPHY_RWDataType {
    ETHXCVR_StateType       state;
    ETHXCVR_LinkStateType   linkState;
    uint32_t                isLinkStateChanged;
    uint32_t                linkStateChangeCount;
    uint32_t                isAutoNegStarted;
    uint16_t                intStatus;
    ETHXCVR_BooleanType     isConfigDone;
} BRPHY_RWDataType;

/**
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL

*/
extern BRPHY_RWDataType
    BRPHY_RWData[BRPHY_CORE_MAX_HW_ID] COMP_SECTION(".bss.drivers");

/**
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
*/
extern BRPHY_MII_RDBType * const BRPHY_CL22_IEEE_REGS[BRPHY_MII_MAX_HW_ID];

/**
     Architecture details at @ref ETHXCVR_SetModeType
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
*/
extern int32_t BRPHY_CommonSetMode(uint8_t aPhyIdx,
                                   ETHXCVR_CntxtType *const aPhyCntxt,
                                   const ETHXCVR_PortConfigType *const aConfig,
                                   ETHXCVR_ModeType aMode);

/**
     Architecture details at @ref ETHXCVR_SetModeType
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
*/
int32_t BRPHY_SetMode(uint8_t aPhyIdx,
                      ETHXCVR_CntxtType *const aPhyCntxt,
                      const ETHXCVR_PortConfigType *const aConfig,
                      ETHXCVR_ModeType aMode);

/**
     Architecture details at @ref ETHXCVR_SetMasterModeType
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
*/
int32_t BRPHY_SetMasterMode(uint8_t aPhyIdx,
                            ETHXCVR_CntxtType *const aPhyCntxt,
                            const ETHXCVR_PortConfigType *const aConfig,
                            ETHXCVR_BooleanType aMasterMode);

/**
     Architecture details at @ref ETHXCVR_GetMasterModeType
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
*/
int32_t BRPHY_GetMasterMode(uint8_t aPhyIdx,
                            ETHXCVR_CntxtType *const aPhyCntxt,
                            const ETHXCVR_PortConfigType *const aConfig,
                            ETHXCVR_BooleanType *const aMasterMode);

/**
     Architecture details at @ref ETHXCVR_SetLoopbackModeType
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
*/
int32_t BRPHY_SetLoopbackMode(uint8_t aPhyIdx,
                              ETHXCVR_CntxtType *const aPhyCntxt,
                              const ETHXCVR_PortConfigType *const aConfig,
                              ETHXCVR_BooleanType aMode);

/**
     Architecture details at @ref ETHXCVR_GetLoopbackModeType
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
*/
int32_t BRPHY_GetLoopbackMode(uint8_t aPhyIdx,
                              ETHXCVR_CntxtType *const aPhyCntxt,
                              const ETHXCVR_PortConfigType *const aConfig,
                              ETHXCVR_BooleanType *const aMode);

/**
     Architecture details at @ref ETHXCVR_GetSQIValueType
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
*/
int32_t BRPHY_GetSQIValue(uint8_t aPhyIdx,
                          ETHXCVR_CntxtType *const aPhyCntxt,
                          const ETHXCVR_PortConfigType *const aConfig,
                          uint32_t *const aSQIValue);

/**
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
*/
int32_t BRPHY_CommonSetWakeUpMode(uint8_t aPhyIdx,
                                  ETHXCVR_CntxtType *const aCntxt,
                                  const ETHXCVR_PortConfigType *const aConfig,
                                  ETHXCVR_BooleanType aMode);

/**
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
*/
int32_t BRPHY_CommonGetWakeUpReason(uint8_t aPhyIdx,
                                  ETHXCVR_CntxtType *const aCntxt,
                                  const ETHXCVR_PortConfigType *const aConfig,
                                  ETHXCVR_WakeupReasonType *const aReason);

/**
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
*/
int32_t BRPHY_CommonSetAutoNegMode(uint8_t aPhyIdx,
                                    ETHXCVR_CntxtType *const aPhyCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig,
                                    ETHXCVR_BooleanType aAutonegMode);

/**
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
*/
int32_t BRPHY_CommonRestartAutoNeg(uint8_t aPhyIdx,
                                    ETHXCVR_CntxtType *const aPhyCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig);

/**
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
*/
int32_t BRPHY_CommonGetAutoNegStatus(uint8_t aPhyIdx,
                                      ETHXCVR_CntxtType *const aPhyCntxt,
                                      const ETHXCVR_PortConfigType *const aConfig,
                                      ETHXCVR_AutoNegStatusType *const aStatus);

/**
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
*/
int32_t BRPHY_CommonGetStats(uint8_t aPhyIdx,
                              ETHXCVR_CntxtType *const aPhyCntxt,
                              const ETHXCVR_PortConfigType *const aConfig,
                              ETHXCVR_StatsType *const aStats);

/**
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
*/
int32_t BRPHY_CommonStateHandler(uint8_t aPhyIdx,
                                  ETHXCVR_CntxtType *const aPhyCntxt,
                                  const ETHXCVR_PortConfigType *const aConfig,
                                  uint32_t *const aIsModeChanged,
                                  ETHXCVR_ModeType *const aMode);

/**
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
*/
int32_t BRPHY_CommonUpdateHWStatus(uint8_t aPhyIdx,
                                    ETHXCVR_CntxtType *const aPhyCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig);

/**
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
*/
int32_t BRPHY_CommonLinkIRQHandler(uint8_t aPhyIdx,
                                    ETHXCVR_CntxtType *const aPhyCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig);

/**
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
*/
int32_t BRPHY_CommonLinkChangeIndHandler(uint8_t aPhyIdx,
                                   ETHXCVR_CntxtType *const aPhyCntxt,
                                   const ETHXCVR_PortConfigType *const aConfig,
                                   ETHXCVR_LinkStateType *const aLinkState,
                                   uint32_t *const aIsLinkStateChanged);

/**
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
*/
int32_t BRPHY_CommonGetWakeUpMode(uint8_t aPhyIdx,
                                  ETHXCVR_CntxtType *const aCntxt,
                                  const ETHXCVR_PortConfigType *const aConfig,
                                  ETHXCVR_BooleanType *const aMode);

/**
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
*/
int32_t BRPHY_CommonGetJumboMode(uint8_t aPhyIdx,
                                  ETHXCVR_CntxtType *const aPhyCntxt,
                                  const ETHXCVR_PortConfigType *const aConfig,
                                  ETHXCVR_BooleanType *const aMode);

/**
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
*/
int32_t BRPHY_CommonGetLinkState(uint8_t aPhyIdx,
                                  ETHXCVR_CntxtType *const aPhyCntxt,
                                  const ETHXCVR_PortConfigType *const aConfig,
                                  ETHXCVR_LinkStateType *const aLinkState);

/**
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
*/
int32_t BRPHY_CommonGetSQIValue(uint8_t aPhyIdx,
                                 ETHXCVR_CntxtType *const aPhyCntxt,
                                 const ETHXCVR_PortConfigType *const aConfig,
                                 uint32_t *const aSQIValue);

/**
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
*/
int32_t BRPHY_CommonSetJumboMode(uint8_t aPhyIdx,
                                  ETHXCVR_CntxtType *const aPhyCntxt,
                                  const ETHXCVR_PortConfigType *const aConfig,
                                  ETHXCVR_BooleanType aMode);

/**
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
*/
int32_t BRPHY_CommonDeInit(uint8_t aPhyIdx,
                            ETHXCVR_CntxtType *const aPhyCntxt,
                            const ETHXCVR_PortConfigType *const aConfig);

/**
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
*/
int32_t BRPHY_CommonInit(uint8_t aPhyIdx,
                          ETHXCVR_CntxtType *const aPhyCntxt,
                          const ETHXCVR_PortConfigType *const aConfig);

/**
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
*/
int32_t BRPHY_CommonReset(uint8_t aPhyIdx,
                           ETHXCVR_CntxtType *const aPhyCntxt,
                           const ETHXCVR_PortConfigType *const aConfig);

/**
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
*/
int32_t BRPHY_CommonSetFlowControl(uint8_t aPhyIdx,
                                    ETHXCVR_CntxtType *const aPhyCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig,
                                    ETHXCVR_FlowControlType aFlowControl);
/**
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
*/
int32_t BRPHY_CommonGetFlowControl(uint8_t aPhyIdx,
                                    ETHXCVR_CntxtType *const aPhyCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig,
                                    ETHXCVR_FlowControlType *const aFlowControl);

/**
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
*/
int32_t BRPHY_CommonSetDuplexMode(uint8_t aPhyIdx,
                                   ETHXCVR_CntxtType *const aPhyCntxt,
                                   const ETHXCVR_PortConfigType *const aConfig,
                                   ETHXCVR_DuplexModeType aDuplexMode);

/**
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
*/
int32_t BRPHY_CommonGetDuplexMode(uint8_t aPhyIdx,
                                   ETHXCVR_CntxtType *const aPhyCntxt,
                                   const ETHXCVR_PortConfigType *const aConfig,
                                   ETHXCVR_DuplexModeType *const aDuplexMode);

/**
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
*/
int32_t BRPHY_CommonGetSpeed(uint8_t aPhyIdx,
                              ETHXCVR_CntxtType *const aPhyCntxt,
                              const ETHXCVR_PortConfigType *const aConfig,
                              ETHXCVR_SpeedType *const aSpeed);

/**
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
*/
int32_t BRPHY_CommonSetSpeed(uint8_t aPhyIdx,
                              ETHXCVR_CntxtType *const aPhyCntxt,
                              const ETHXCVR_PortConfigType *const aConfig,
                              ETHXCVR_SpeedType aSpeed);

/**
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
*/
int32_t BRPHY_CommonGetMode(uint8_t aPhyIdx,
                             ETHXCVR_CntxtType *const aPhyCntxt,
                             const ETHXCVR_PortConfigType *const aConfig,
                             ETHXCVR_ModeType *const aMode);

/**
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
*/
int32_t BRPHY_RestartAutoNeg(uint8_t aPhyIdx,
                              ETHXCVR_CntxtType *const aPhyCntxt,
                              const ETHXCVR_PortConfigType *const aConfig);

/**
    @trace #BRCM_SWREQ_BRPHY_FUNCTBL
*/
int32_t BRPHY_GetAutoNegStatus(uint8_t aPhyIdx,
                                ETHXCVR_CntxtType *const aPhyCntxt,
                                const ETHXCVR_PortConfigType *const aConfig,
                                ETHXCVR_AutoNegStatusType *const aStatus);
#endif /* BRPHY_COMMON_H */
/** @} */
