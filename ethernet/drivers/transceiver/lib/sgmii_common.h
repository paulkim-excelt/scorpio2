/*****************************************************************************
 Copyright 2020-2021 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_eth_xcvrdrv_sgmii_common_imp SGMII Driver common Interface
    @ingroup grp_eth_xcvrdrv

    @addtogroup grp_eth_xcvrdrv_sgmii_common_imp
    @{

    @file sgmii_common.h
*/

#ifndef SGMII_COMMON_H
#define SGMII_COMMON_H

#include <ethxcvr.h>
#include <ethxcvr_osil.h>
#include <sgmii_combo_rdb.h>

/**
    @name SGMII API IDs
    @{
    @brief API IDs for SGMII driver
*/

#define BRCM_SWARCH_SGMII_GETMODE_PROC                       (0x8401U)    /**< @brief #SGMII_GetMode                    */
#define BRCM_SWARCH_SGMII_SETMODE_PROC                       (0x8402U)    /**< @brief #SGMII_SetMode                    */
#define BRCM_SWARCH_SGMII_SETSPEED_PROC                      (0x8403U)    /**< @brief #SGMII_SetSpeed                   */
#define BRCM_SWARCH_SGMII_COMMONGETMODE_PROC                 (0x8404U)    /**< @brief #SGMII_CommonGetMode              */
#define BRCM_SWARCH_SGMII_COMMONSETMODE_PROC                 (0x8405U)    /**< @brief #SGMII_CommonSetMode              */
#define BRCM_SWARCH_SGMII_COMMONGETSPEED_PROC                (0x8406U)    /**< @brief #SGMII_CommonGetSpeed             */
#define BRCM_SWARCH_SGMII_COMMONGETJUMBOMODE_PROC            (0x8407U)    /**< @brief #SGMII_CommonGetJumboMode         */
#define BRCM_SWARCH_SGMII_COMMONSETAUTONEGMODE_PROC          (0x8408U)    /**< @brief #SGMII_CommonSetAutoNegMode       */
#define BRCM_SWARCH_SGMII_COMMONRESTARTAUTONEG_PROC          (0x8409U)    /**< @brief #SGMII_CommonRestartAutoNeg       */
#define BRCM_SWARCH_SGMII_COMMONGETAUTONEGSTATUS_PROC        (0x840AU)    /**< @brief #SGMII_CommonGetAutoNegStatus     */
#define BRCM_SWARCH_SGMII_COMMONGETSTATS_PROC                (0x840BU)    /**< @brief #SGMII_CommonGetStats             */
#define BRCM_SWARCH_SGMII_COMMONSTATEHANDLER_PROC            (0x840CU)    /**< @brief #SGMII_CommonStateHandler         */
#define BRCM_SWARCH_SGMII_COMMONUPDATEHWSTATUS_PROC          (0x840DU)    /**< @brief #SGMII_CommonUpdateHWStatus       */
#define BRCM_SWARCH_SGMII_COMMONLINKIRQHANDLER_PROC          (0x840EU)    /**< @brief #SGMII_CommonLinkIRQHandler       */
#define BRCM_SWARCH_SGMII_COMMONLINKCHANGEINDHANDLER_PROC    (0x840FU)    /**< @brief #SGMII_CommonLinkChangeIndHandler */
#define BRCM_SWARCH_SGMII_COMMONSETJUMBOMODE_PROC            (0x8410U)    /**< @brief #SGMII_CommonSetJumboMode         */
#define BRCM_SWARCH_SGMII_COMMONGETLINKSTATE_PROC            (0x8411U)    /**< @brief #SGMII_CommonGetLinkState         */
#define BRCM_SWARCH_SGMII_COMMONRESET_PROC                   (0x8412U)    /**< @brief #SGMII_CommonReset                */
#define BRCM_SWARCH_SGMII_COMMONSETMASTERMODE_PROC           (0x8413U)    /**< @brief #SGMII_CommonSetMasterMode        */
#define BRCM_SWARCH_SGMII_COMMONGETMASTERMODE_PROC           (0x8414U)    /**< @brief #SGMII_CommonGetMasterMode        */
#define BRCM_SWARCH_SGMII_COMMONGETDUPLEXMODE_PROC           (0x8415U)    /**< @brief #SGMII_CommonGetDuplexMode        */
#define BRCM_SWARCH_SGMII_COMMONSETDUPLEXMODE_PROC           (0x8416U)    /**< @brief #SGMII_CommonSetDuplexMode        */
#define BRCM_SWARCH_SGMII_COMMONGETFLOWCONTROL_PROC          (0x8417U)    /**< @brief #SGMII_CommonGetFlowControl       */
#define BRCM_SWARCH_SGMII_COMMONSETFLOWCONTROL_PROC          (0x8418U)    /**< @brief #SGMII_CommonSetFlowControl       */
#define BRCM_SWARCH_SGMII_COMMONGETSQIVALUE_PROC             (0x8419U)    /**< @brief #SGMII_CommonGetSQIValue          */
#define BRCM_SWARCH_SGMII_COMMONINIT_PROC                    (0x841AU)    /**< @brief #SGMII_CommonInit                 */
#define BRCM_SWARCH_SGMII_COMMONDEINIT_PROC                  (0x841BU)    /**< @brief #SGMII_CommonDeInit               */
#define BRCM_SWARCH_SGMII_COMMONSETLOOPBACKMODE_PROC         (0x841CU)    /**< @brief #SGMII_CommonSetLoopbackMode      */
#define BRCM_SWARCH_SGMII_COMMONGETLOOPBACKMODE_PROC         (0x841DU)    /**< @brief #SGMII_CommonGetLoopbackMode      */
#define BRCM_SWARCH_SGMII_RWDATA_TYPE                        (0x841EU)    /**< @brief #SGMII_RWDataType                 */
#define BRCM_SWARCH_SGMII_RWDATA_GLOBAL                      (0x841FU)    /**< @brief #SGMII_RWData                     */
#define BRCM_SWARCH_SGMII_CL22_IEEE_REG_GLOBAL               (0x8420U)    /**< @brief #SGMII_CL22_IEEE_REG              */

/** @} */

/**

    @trace #BRCM_SWREQ_SGMII_FUNCTBL
*/
typedef struct sSGMII_RWDataType {
    ETHXCVR_StateType       state;
    uint32_t                isAutoNegStarted;
    uint32_t                linkStateChangeCount;
    ETHXCVR_BooleanType     jumboMode;
    ETHXCVR_BooleanType     isConfigDone;
} SGMII_RWDataType;

/**

    @trace #BRCM_SWREQ_SGMII_FUNCTBL
*/
extern SGMII_RWDataType SGMII_RWData[SGMII_MAX_HW_ID] COMP_SECTION(".bss.drivers");

/**

    @trace #BRCM_SWREQ_SGMII_FUNCTBL
*/
extern SGMII_COMBO_RDBType * const SGMII_CL22_IEEE_REG[SGMII_MAX_HW_ID];

/**
     Architecture details at @ref ETHXCVR_SetModeType
    @trace #BRCM_SWREQ_SGMII_FUNCTBL
*/
int32_t SGMII_SetMode(uint8_t aBusIdx,
                       ETHXCVR_CntxtType *const aCntxt,
                       const ETHXCVR_PortConfigType *const aConfig,
                       ETHXCVR_ModeType aMode);

/**
     Architecture details at @ref ETHXCVR_GetModeType
    @trace #BRCM_SWREQ_SGMII_FUNCTBL
*/
int32_t SGMII_GetMode(uint8_t aBusIdx,
                       ETHXCVR_CntxtType *const aCntxt,
                       const ETHXCVR_PortConfigType *const aConfig,
                       ETHXCVR_ModeType *const aMode);
/**
     Architecture details at @ref ETHXCVR_SetSpeedType
    @trace #BRCM_SWREQ_SGMII_FUNCTBL
*/
int32_t SGMII_SetSpeed(uint8_t aBusIdx,
                        ETHXCVR_CntxtType *const aCntxt,
                        const ETHXCVR_PortConfigType *const aConfig,
                        ETHXCVR_SpeedType aSpeed);

/**
     Architecture details at @ref ETHXCVR_SetModeType
    @trace #BRCM_SWREQ_SGMII_FUNCTBL
*/
extern int32_t SGMII_CommonSetMode(uint8_t aBusIdx,
                                    ETHXCVR_CntxtType *const aCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig,
                                    ETHXCVR_ModeType aMode);

/**
     Architecture details at @ref ETHXCVR_GetModeType
    @trace #BRCM_SWREQ_SGMII_FUNCTBL
*/
extern int32_t SGMII_CommonGetMode(uint8_t aBusIdx,
                                    ETHXCVR_CntxtType *const aCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig,
                                    ETHXCVR_ModeType *const aMode);

/**
     Architecture details at @ref ETHXCVR_GetSpeedType
    @trace #BRCM_SWREQ_SGMII_FUNCTBL
*/
extern int32_t SGMII_CommonGetSpeed(uint8_t aBusIdx,
                                     ETHXCVR_CntxtType *const aCntxt,
                                     const ETHXCVR_PortConfigType *const aConfig,
                                     ETHXCVR_SpeedType *const aSpeed);

/**
    @trace #BRCM_SWREQ_SGMII_FUNCTBL
*/
int32_t SGMII_CommonGetJumboMode(uint8_t aBusIdx,
                                  ETHXCVR_CntxtType *const aCntxt,
                                  const ETHXCVR_PortConfigType *const aConfig,
                                  ETHXCVR_BooleanType *const aMode);

/**
    @trace #BRCM_SWREQ_SGMII_FUNCTBL
*/
int32_t SGMII_CommonSetAutoNegMode(uint8_t aBusIdx,
                                    ETHXCVR_CntxtType *const aCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig,
                                    ETHXCVR_BooleanType aMode);

/**
    @trace #BRCM_SWREQ_SGMII_FUNCTBL
*/
int32_t SGMII_CommonRestartAutoNeg(uint8_t aBusIdx,
                                    ETHXCVR_CntxtType *const aCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig);

/**
    @trace #BRCM_SWREQ_SGMII_FUNCTBL
*/
int32_t SGMII_CommonGetAutoNegStatus(uint8_t aBusIdx,
                                    ETHXCVR_CntxtType *const aCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig,
                                    ETHXCVR_AutoNegStatusType *const aStatus);

/**
    @trace #BRCM_SWREQ_SGMII_FUNCTBL
*/
int32_t SGMII_CommonGetStats(uint8_t aBusIdx,
                              ETHXCVR_CntxtType *const aCntxt,
                              const ETHXCVR_PortConfigType *const aConfig,
                              ETHXCVR_StatsType *const aStats);

/**
    @trace #BRCM_SWREQ_SGMII_FUNCTBL
*/
int32_t SGMII_CommonStateHandler(uint8_t aBusIdx,
                                  ETHXCVR_CntxtType *const aCntxt,
                                  const ETHXCVR_PortConfigType *const aConfig,
                                  uint32_t *const aIsModeChanged,
                                  ETHXCVR_ModeType *const aMode);

/**
    @trace #BRCM_SWREQ_SGMII_FUNCTBL
*/
int32_t SGMII_CommonUpdateHWStatus(uint8_t aBusIdx,
                                    ETHXCVR_CntxtType *const aCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig);

/**
    @trace #BRCM_SWREQ_SGMII_FUNCTBL
*/
int32_t SGMII_CommonLinkIRQHandler(uint8_t aBusIdx,
                             ETHXCVR_CntxtType *const aCntxt,
                             const ETHXCVR_PortConfigType *const aConfig);

/**
    @trace #BRCM_SWREQ_SGMII_FUNCTBL
*/
int32_t SGMII_CommonLinkChangeIndHandler(uint8_t aBusIdx,
                                   ETHXCVR_CntxtType *const aCntxt,
                                   const ETHXCVR_PortConfigType *const aConfig,
                                   ETHXCVR_LinkStateType *const aLinkState,
                                   uint32_t *const aIsLinkStateChanged);

/**
    @trace #BRCM_SWREQ_SGMII_FUNCTBL
*/
int32_t SGMII_CommonSetJumboMode(uint8_t aBusIdx,
                                  ETHXCVR_CntxtType *const aCntxt,
                                  const ETHXCVR_PortConfigType *const aConfig,
                                  ETHXCVR_BooleanType aMode);

/**
    @trace #BRCM_SWREQ_SGMII_FUNCTBL
*/
int32_t SGMII_CommonGetLinkState(uint8_t aBusIdx,
                                  ETHXCVR_CntxtType *const aCntxt,
                                  const ETHXCVR_PortConfigType *const aConfig,
                                  ETHXCVR_LinkStateType *const aLinkState);

/**
    @trace #BRCM_SWREQ_SGMII_FUNCTBL
*/
int32_t SGMII_CommonReset(uint8_t aBusIdx,
                           ETHXCVR_CntxtType *const aCntxt,
                           const ETHXCVR_PortConfigType *const aConfig);

/**
    @trace #BRCM_SWREQ_SGMII_FUNCTBL
*/
int32_t SGMII_CommonSetMasterMode(uint8_t aBusIdx,
                             ETHXCVR_CntxtType *const aCntxt,
                                   const ETHXCVR_PortConfigType *const aConfig,
                                   ETHXCVR_BooleanType aMasterMode);

/**
    @trace #BRCM_SWREQ_SGMII_FUNCTBL
*/
int32_t SGMII_CommonGetMasterMode(uint8_t aBusIdx,
                                   ETHXCVR_CntxtType *const aCntxt,
                                   const ETHXCVR_PortConfigType *const aConfig,
                                   ETHXCVR_BooleanType *const aMasterMode);

/**
    @trace #BRCM_SWREQ_SGMII_FUNCTBL
*/
int32_t SGMII_CommonGetDuplexMode(uint8_t aBusIdx,
                                   ETHXCVR_CntxtType *const aCntxt,
                                   const ETHXCVR_PortConfigType *const aConfig,
                                   ETHXCVR_DuplexModeType *const aDuplexMode);

/**
    @trace #BRCM_SWREQ_SGMII_FUNCTBL
*/
int32_t SGMII_CommonSetDuplexMode(uint8_t aBusIdx,
                                   ETHXCVR_CntxtType *const aCntxt,
                                   const ETHXCVR_PortConfigType *const aConfig,
                                   ETHXCVR_DuplexModeType aDuplexMode);

/**
    @trace #BRCM_SWREQ_SGMII_FUNCTBL
*/
int32_t SGMII_CommonGetFlowControl(uint8_t aBusIdx,
                                    ETHXCVR_CntxtType *const aCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig,
                                    ETHXCVR_FlowControlType *const aFlowControl);

/**
    @trace #BRCM_SWREQ_SGMII_FUNCTBL
*/
int32_t SGMII_CommonSetFlowControl(uint8_t aBusIdx,
                                    ETHXCVR_CntxtType *const aCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig,
                                    ETHXCVR_FlowControlType aFlowControl);

/**
    @trace #BRCM_SWREQ_SGMII_FUNCTBL
*/
int32_t SGMII_CommonGetSQIValue(uint8_t aBusIdx,
                                 ETHXCVR_CntxtType *const aCntxt,
                                 const ETHXCVR_PortConfigType *const aConfig,
                                 uint32_t *const aSQIValue);

/**
    @trace #BRCM_SWREQ_SGMII_FUNCTBL
*/
int32_t SGMII_CommonInit(uint8_t aBusIdx,
                          ETHXCVR_CntxtType *const aCntxt,
                          const ETHXCVR_PortConfigType *const aConfig);

/**
    @trace #BRCM_SWREQ_SGMII_FUNCTBL
*/
int32_t SGMII_CommonDeInit(uint8_t aBusIdx,
                            ETHXCVR_CntxtType *const aCntxt,
                            const ETHXCVR_PortConfigType *const aConfig);

/**
    @trace #BRCM_SWREQ_SGMII_FUNCTBL
*/
int32_t SGMII_CommonSetLoopbackMode(uint8_t aBusIdx,
                                     ETHXCVR_CntxtType *const aCntxt,
                                     const ETHXCVR_PortConfigType *const aConfig,
                                     ETHXCVR_BooleanType aMode);

/**
    @trace #BRCM_SWREQ_SGMII_FUNCTBL
*/
int32_t SGMII_CommonGetLoopbackMode(uint8_t aBusIdx,
                                     ETHXCVR_CntxtType *const aCntxt,
                                     const ETHXCVR_PortConfigType *const aConfig,
                                     ETHXCVR_BooleanType *const aMode);
#endif /* SGMII_COMMON_H */

/** @} */
