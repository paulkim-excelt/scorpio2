/*****************************************************************************
 Copyright 2019-2020 Broadcom Limited.  All rights reserved.

 This program is the proprietary software of Broadcom Corporation and/or its
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
    @defgroup grp_eth_xcvrdrv_dummyphy_impl Dummy PHY Driver
    @ingroup grp_eth_xcvrdrv

    @addtogroup grp_eth_xcvrdrv_dummyphy_impl
    @{

    @file dummyphy.c
    @brief This file implements Dummy PHY driver

    @version 0.1 Initial version
*/

#include <bcm_err.h>
#include <ethxcvr.h>
#include "dummyphy_osil.h"

/**
    @name DUMMYPHY driver Design IDs
    @{
    @brief Design IDs for DUMMYPHY driver
*/
#define BRCM_SWDSGN_DUMMYPHY_INIT_PROC                    (0xB601U)    /**< @brief #DUMMYPHY_Init                 */
#define BRCM_SWDSGN_DUMMYPHY_RESET_PROC                   (0xB602U)    /**< @brief #DUMMYPHY_Reset                */
#define BRCM_SWDSGN_DUMMYPHY_GETSQIVALUE_PROC             (0xB603U)    /**< @brief #DUMMYPHY_GetSQIValue          */
#define BRCM_SWDSGN_DUMMYPHY_GETDUPLEXMODE_PROC           (0xB604U)    /**< @brief #DUMMYPHY_GetDuplexMode        */
#define BRCM_SWDSGN_DUMMYPHY_GETSPEED_PROC                (0xB605U)    /**< @brief #DUMMYPHY_GetSpeed             */
#define BRCM_SWDSGN_DUMMYPHY_GETLINKSTATE_PROC            (0xB606U)    /**< @brief #DUMMYPHY_GetLinkState         */
#define BRCM_SWDSGN_DUMMYPHY_GETMASTERMODE_PROC           (0xB607U)    /**< @brief #DUMMYPHY_GetMasterMode        */
#define BRCM_SWDSGN_DUMMYPHY_SETMASTERMODE_PROC           (0xB608U)    /**< @brief #DUMMYPHY_SetMasterMode        */
#define BRCM_SWDSGN_DUMMYPHY_GETMODE_PROC                 (0xB609U)    /**< @brief #DUMMYPHY_GetMode              */
#define BRCM_SWDSGN_DUMMYPHY_SETMODE_PROC                 (0xB60AU)    /**< @brief #DUMMYPHY_SetMode              */
#define BRCM_SWDSGN_DUMMYPHY_LINKIRQHANDLER_PROC          (0xB60BU)    /**< @brief #DUMMYPHY_LinkIRQHandler       */
#define BRCM_SWDSGN_DUMMYPHY_LINKCHANGEINDHANDLER_PROC    (0xB60CU)    /**< @brief #DUMMYPHY_LinkChangeIndHandler */
#define BRCM_SWDSGN_DUMMYPHY_FUNCTBL_GLOBAL               (0xB60DU)    /**< @brief #DUMMYPHY_FuncTbl              */
#define BRCM_SWDSGN_DUMMYPHY_RWDATA_TYPE                  (0xB60EU)    /**< @brief #DUMMYPHY_RWDataType           */
#define BRCM_SWDSGN_DUMMYPHY_DEINIT_PROC                  (0xB60FU)    /**< @brief #DUMMYPHY_DeInit               */
#define BRCM_SWDSGN_DUMMYPHY_SETSPEED_PROC                (0xB610U)    /**< @brief #DUMMYPHY_SetSpeed             */
#define BRCM_SWDSGN_DUMMYPHY_GETLOOPBACKMODE_PROC         (0xB611U)    /**< @brief #DUMMYPHY_GetLoopbackMode      */
#define BRCM_SWDSGN_DUMMYPHY_SETLOOPBACKMODE_PROC         (0xB612U)    /**< @brief #DUMMYPHY_SetLoopbackMode      */
#define BRCM_SWDSGN_DUMMYPHY_GETJUMBOMODE_PROC            (0xB613U)    /**< @brief #DUMMYPHY_GetJumboMode         */
#define BRCM_SWDSGN_DUMMYPHY_SETJUMBOMODE_PROC            (0xB614U)    /**< @brief #DUMMYPHY_SetJumboMode         */
#define BRCM_SWDSGN_DUMMYPHY_SETAUTONEGMODE_PROC          (0xB615U)    /**< @brief #DUMMYPHY_SetAutoNegMode       */
#define BRCM_SWDSGN_DUMMYPHY_RESTARTAUTONEG_PROC          (0xB616U)    /**< @brief #DUMMYPHY_RestartAutoNeg       */
#define BRCM_SWDSGN_DUMMYPHY_GETAUTONEGSTATUS_PROC        (0xB617U)    /**< @brief #DUMMYPHY_GetAutoNegStatus     */
#define BRCM_SWDSGN_DUMMYPHY_GETSTATS_PROC                (0xB618U)    /**< @brief #DUMMYPHY_GetStats             */
#define BRCM_SWDSGN_DUMMYPHY_SETDUPLEXMODE_PROC           (0xB619U)    /**< @brief #DUMMYPHY_SetDuplexMode        */
#define BRCM_SWDSGN_DUMMYPHY_SETFLOWCONTROL_PROC          (0xB61AU)    /**< @brief #DUMMYPHY_SetFlowControl       */
#define BRCM_SWDSGN_DUMMYPHY_GETFLOWCONTROL_PROC          (0xB61BU)    /**< @brief #DUMMYPHY_GetFlowControl       */
#define BRCM_SWDSGN_DUMMYPHY_STATEHANDLER_PROC            (0xB61CU)    /**< @brief #DUMMYPHY_StateHandler         */
#define BRCM_SWDSGN_DUMMYPHY_UPDATEHWSTATUS_PROC          (0xB61DU)    /**< @brief #DUMMYPHY_UpdateHWStatus       */
/** @} */

/**
    @trace #BRCM_SWARCH_DUMMYPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DUMMYPHY_FUNCTBL
*/
static int32_t DUMMYPHY_GetLinkState(uint8_t aID,
                                    ETHXCVR_CntxtType *const aPhyCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig,
                                    ETHXCVR_LinkStateType *const aLinkState)
{
    return BCM_ERR_NOSUPPORT;
}

/**
    @trace #BRCM_SWARCH_DUMMYPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DUMMYPHY_FUNCTBL
*/
static int32_t DUMMYPHY_Reset(uint8_t aID,
                              ETHXCVR_CntxtType *const aPhyCntxt,
                              const ETHXCVR_PortConfigType *const aConfig)
{
    return BCM_ERR_NOSUPPORT;
}

/**
    @trace #BRCM_SWARCH_DUMMYPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DUMMYPHY_FUNCTBL
*/
static int32_t DUMMYPHY_SetMode(uint8_t aID,
                                ETHXCVR_CntxtType *const aPhyCntxt,
                                const ETHXCVR_PortConfigType *const aConfig,
                                ETHXCVR_ModeType aMode)
{
    return BCM_ERR_NOSUPPORT;
}

/**
    @trace #BRCM_SWARCH_DUMMYPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DUMMYPHY_FUNCTBL
*/
static int32_t DUMMYPHY_GetMode(uint8_t aID,
                                ETHXCVR_CntxtType *const aPhyCntxt,
                                const ETHXCVR_PortConfigType *const aConfig,
                                ETHXCVR_ModeType *const aMode)
{
    return BCM_ERR_NOSUPPORT;
}

/**
    @trace #BRCM_SWARCH_DUMMYPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DUMMYPHY_FUNCTBL
*/
static int32_t DUMMYPHY_SetMasterMode(uint8_t aID,
                                      ETHXCVR_CntxtType *const aPhyCntxt,
                                      const ETHXCVR_PortConfigType *const aConfig,
                                      ETHXCVR_BooleanType aMasterMode)
{
    return BCM_ERR_NOSUPPORT;
}

/**
    @trace #BRCM_SWARCH_DUMMYPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DUMMYPHY_FUNCTBL
*/
static int32_t DUMMYPHY_GetMasterMode(uint8_t aID,
                                      ETHXCVR_CntxtType *const aPhyCntxt,
                                      const ETHXCVR_PortConfigType *const aConfig,
                                      ETHXCVR_BooleanType *const aConnMode)
{
    return BCM_ERR_NOSUPPORT;
}

/**
    @trace #BRCM_SWARCH_DUMMYPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DUMMYPHY_FUNCTBL
*/
static int32_t DUMMYPHY_SetSpeed(uint8_t aID,
                                 ETHXCVR_CntxtType *const aPhyCntxt,
                                 const ETHXCVR_PortConfigType *const aConfig,
                                 ETHXCVR_SpeedType aSpeed)
{
    return BCM_ERR_NOSUPPORT;
}

/**
    @trace #BRCM_SWARCH_DUMMYPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DUMMYPHY_FUNCTBL
*/
static int32_t DUMMYPHY_GetSpeed(uint8_t aID,
                                 ETHXCVR_CntxtType *const aPhyCntxt,
                                 const ETHXCVR_PortConfigType *const aConfig,
                                 ETHXCVR_SpeedType *const aSpeed)
{
    return BCM_ERR_NOSUPPORT;
}

/**
    @trace #BRCM_SWARCH_DUMMYPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DUMMYPHY_FUNCTBL
*/
static int32_t DUMMYPHY_GetDuplexMode(uint8_t aID,
                                 ETHXCVR_CntxtType *const aPhyCntxt,
                                 const ETHXCVR_PortConfigType *const aConfig,
                                 ETHXCVR_DuplexModeType *const aDuplexMode)
{
    return BCM_ERR_NOSUPPORT;
}

/**
    @trace #BRCM_SWARCH_DUMMYPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DUMMYPHY_FUNCTBL
*/
static int32_t DUMMYPHY_SetDuplexMode(uint8_t aPhyIdx,
                                 ETHXCVR_CntxtType *const aPhyCntxt,
                                 const ETHXCVR_PortConfigType *const aConfig,
                                 ETHXCVR_DuplexModeType aDuplexMode)
{
    return BCM_ERR_NOSUPPORT;
}

/**
    @trace #BRCM_SWARCH_DUMMYPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DUMMYPHY_FUNCTBL
*/
static int32_t DUMMYPHY_SetFlowControl(uint8_t aPhyIdx,
                                 ETHXCVR_CntxtType *const aPhyCntxt,
                                 const ETHXCVR_PortConfigType *const aConfig,
                                 ETHXCVR_FlowControlType aFlowControl)
{
    return BCM_ERR_NOSUPPORT;
}

/**
    @trace #BRCM_SWARCH_DUMMYPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DUMMYPHY_FUNCTBL
*/
static int32_t DUMMYPHY_GetFlowControl(uint8_t aPhyIdx,
                                 ETHXCVR_CntxtType *const aPhyCntxt,
                                 const ETHXCVR_PortConfigType *const aConfig,
                                 ETHXCVR_FlowControlType *const aFlowControl)
{
    return BCM_ERR_NOSUPPORT;
}


/**
    @trace #BRCM_SWARCH_DUMMYPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DUMMYPHY_FUNCTBL
*/
static int32_t DUMMYPHY_GetSQIValue(uint8_t aID,
                                 ETHXCVR_CntxtType *const aPhyCntxt,
                                 const ETHXCVR_PortConfigType *const aConfig,
                                 uint32_t *const aSQIValue)
{
    return BCM_ERR_NOSUPPORT;
}

/**
    @trace #BRCM_SWARCH_DUMMYPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DUMMYPHY_FUNCTBL
*/
static int32_t DUMMYPHY_Init(uint8_t aID,
                             ETHXCVR_CntxtType *const aPhyCntxt,
                             const ETHXCVR_PortConfigType *const aConfig)
{
    return BCM_ERR_OK;
}

/**
    @trace #BRCM_SWARCH_DUMMYPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DUMMYPHY_FUNCTBL
*/
static int32_t DUMMYPHY_DeInit(uint8_t aID,
                               ETHXCVR_CntxtType *const aPhyCntxt,
                               const ETHXCVR_PortConfigType *const aConfig)
{
    return BCM_ERR_NOSUPPORT;
}

/**
    @trace #BRCM_SWARCH_DUMMYPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DUMMYPHY_FUNCTBL
*/
static int32_t DUMMYPHY_SetLoopbackMode(uint8_t aID,
                                 ETHXCVR_CntxtType *const aPhyCntxt,
                                 const ETHXCVR_PortConfigType *const aConfig,
                                 ETHXCVR_BooleanType aMode)
{
    return BCM_ERR_NOSUPPORT;
}

/**
    @trace #BRCM_SWARCH_DUMMYPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DUMMYPHY_FUNCTBL
*/
static int32_t DUMMYPHY_GetLoopbackMode(uint8_t aID,
                                 ETHXCVR_CntxtType *const aPhyCntxt,
                                 const ETHXCVR_PortConfigType *const aConfig,
                                 ETHXCVR_BooleanType *const aMode)
{
    return BCM_ERR_NOSUPPORT;
}

/**
    @trace #BRCM_SWARCH_DUMMYPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DUMMYPHY_FUNCTBL
*/
static int32_t DUMMYPHY_SetJumboMode(uint8_t aID,
                                 ETHXCVR_CntxtType *const aPhyCntxt,
                                 const ETHXCVR_PortConfigType *const aConfig,
                                 ETHXCVR_BooleanType aMode)
{
    return BCM_ERR_NOSUPPORT;
}

/**
    @trace #BRCM_SWARCH_DUMMYPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DUMMYPHY_FUNCTBL
*/
static int32_t DUMMYPHY_GetJumboMode(uint8_t aID,
                                 ETHXCVR_CntxtType *const aPhyCntxt,
                                 const ETHXCVR_PortConfigType *const aConfig,
                                 ETHXCVR_BooleanType *const aMode)
{
    return BCM_ERR_NOSUPPORT;
}

/**
    @trace #BRCM_SWARCH_DUMMYPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DUMMYPHY_FUNCTBL
*/
static int32_t DUMMYPHY_SetAutoNegMode(uint8_t aID,
                                 ETHXCVR_CntxtType *const aPhyCntxt,
                                 const ETHXCVR_PortConfigType *const aConfig,
                                 ETHXCVR_BooleanType aMode)
{
    return BCM_ERR_NOSUPPORT;
}

/**
    @trace #BRCM_SWARCH_DUMMYPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DUMMYPHY_FUNCTBL
*/
static int32_t DUMMYPHY_RestartAutoNeg(uint8_t aID,
                                 ETHXCVR_CntxtType *const aPhyCntxt,
                                 const ETHXCVR_PortConfigType *const aConfig)
{
    return BCM_ERR_NOSUPPORT;
}

/**
    @trace #BRCM_SWARCH_DUMMYPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DUMMYPHY_FUNCTBL
*/
static int32_t DUMMYPHY_GetAutoNegStatus(uint8_t aID,
                                 ETHXCVR_CntxtType *const aPhyCntxt,
                                 const ETHXCVR_PortConfigType *const aConfig,
                                 ETHXCVR_AutoNegStatusType *const aStatus)
{
    return BCM_ERR_NOSUPPORT;
}

/**
    @trace #BRCM_SWARCH_DUMMYPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DUMMYPHY_FUNCTBL
*/
static int32_t DUMMYPHY_GetStats(uint8_t aID,
                                 ETHXCVR_CntxtType *const aPhyCntxt,
                                 const ETHXCVR_PortConfigType *const aConfig,
                                 ETHXCVR_StatsType *const aStats)
{
    return BCM_ERR_NOSUPPORT;
}

/**
    @trace #BRCM_SWARCH_DUMMYPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DUMMYPHY_FUNCTBL
*/
static int32_t DUMMYPHY_StateHandler(uint8_t aPhyIdx,
                                 ETHXCVR_CntxtType *const aPhyCntxt,
                                 const ETHXCVR_PortConfigType *const aConfig,
                                 uint32_t *const aIsModeChanged,
                                 ETHXCVR_ModeType *const aMode)
{
    return BCM_ERR_OK;
}

/**
    @trace #BRCM_SWARCH_DUMMYPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DUMMYPHY_FUNCTBL
*/
static int32_t DUMMYPHY_UpdateHWStatus(uint8_t aPhyIdx,
                                 ETHXCVR_CntxtType *const aPhyCntxt,
                                 const ETHXCVR_PortConfigType *const aConfig)
{
    return BCM_ERR_NOSUPPORT;
}

/**
    @trace #BRCM_SWARCH_DUMMYPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DUMMYPHY_FUNCTBL
*/
static int32_t DUMMYPHY_LinkIRQHandler(uint8_t aID,
                                 ETHXCVR_CntxtType *const aPhyCntxt,
                                 const ETHXCVR_PortConfigType *const aConfig)
{
    return BCM_ERR_NOSUPPORT;
}

/**
    @trace #BRCM_SWARCH_DUMMYPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DUMMYPHY_FUNCTBL
*/
static int32_t DUMMYPHY_LinkChangeIndHandler(uint8_t aID,
                                 ETHXCVR_CntxtType *const aPhyCntxt,
                                 const ETHXCVR_PortConfigType *const aConfig,
                                 ETHXCVR_LinkStateType *const aLinkState,
                                 uint32_t *const aIsLinkStateChanged)
{
    return BCM_ERR_NOSUPPORT;
}

/**
    @trace #BRCM_SWARCH_DUMMYPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DUMMYPHY_FUNCTBL
*/
const ETHXCVR_FuncTblType DUMMYPHY_FuncTbl = {
    .init = DUMMYPHY_Init,
    .deinit = DUMMYPHY_DeInit,
    .reset = DUMMYPHY_Reset,
    .setMode = DUMMYPHY_SetMode,
    .getMode = DUMMYPHY_GetMode,
    .setMasterMode = DUMMYPHY_SetMasterMode,
    .getMasterMode = DUMMYPHY_GetMasterMode,
    .getSpeed = DUMMYPHY_GetSpeed,
    .setSpeed = DUMMYPHY_SetSpeed,
    .getDuplexMode = DUMMYPHY_GetDuplexMode,
    .setDuplexMode = DUMMYPHY_SetDuplexMode,
    .setFlowControl = DUMMYPHY_SetFlowControl,
    .getFlowControl = DUMMYPHY_GetFlowControl,
    .getLinkState = DUMMYPHY_GetLinkState,
    .getSQIValue = DUMMYPHY_GetSQIValue,
    .setLoopbackMode = DUMMYPHY_SetLoopbackMode,
    .getLoopbackMode = DUMMYPHY_GetLoopbackMode,
    .setJumboMode = DUMMYPHY_SetJumboMode,
    .getJumboMode = DUMMYPHY_GetJumboMode,
    .setAutoNegMode = DUMMYPHY_SetAutoNegMode,
    .getAutoNegStatus = DUMMYPHY_GetAutoNegStatus,
    .restartAutoNeg = DUMMYPHY_RestartAutoNeg,
    .getStats = DUMMYPHY_GetStats,
    .stateHandler = DUMMYPHY_StateHandler,
    .updateHWStatus = DUMMYPHY_UpdateHWStatus,
    .linkChangeIndHandler = DUMMYPHY_LinkChangeIndHandler,
    .linkIRQHandler  = DUMMYPHY_LinkIRQHandler,
};

/** @} */
