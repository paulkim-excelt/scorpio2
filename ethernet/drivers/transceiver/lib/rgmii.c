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
    @defgroup grp_eth_xcvrdrv_rgmii_impl IO block based RGMII/RVMII/RMII/MII driver for bcm8953x
    @ingroup grp_eth_xcvrdrv

    @addtogroup grp_eth_xcvrdrv_rgmii_impl
    @{

    @file rgmii.c
    @brief This file implements RGMII driver of Ethernet driver.

    @version 0.1 Initial version
*/
#include <string.h>
#include <compiler.h>
#include <bcm_utils.h>
#include <bcm_err.h>
#include <ethxcvr.h>
#include <ethxcvr_osil.h>

/**
    @name RGMII driver Design IDs
    @{
    @brief Design IDs for RGMII driver
*/
#define BRCM_SWDSGN_RGMII_INIT_PROC                    (0xB701U)    /**< @brief #RGMII_Init                 */
#define BRCM_SWDSGN_RGMII_RESET_PROC                   (0xB702U)    /**< @brief #RGMII_Command              */
#define BRCM_SWDSGN_RGMII_GETSQIVALUE_PROC             (0xB703U)    /**< @brief #RGMII_GetSQIValue          */
#define BRCM_SWDSGN_RGMII_GETDUPLEXMODE_PROC           (0xB704U)    /**< @brief #RGMII_GetDuplexMode        */
#define BRCM_SWDSGN_RGMII_GETSPEED_PROC                (0xB705U)    /**< @brief #RGMII_GetSpeed             */
#define BRCM_SWDSGN_RGMII_GETLINKSTATE_PROC            (0xB706U)    /**< @brief #RGMII_GetLinkState         */
#define BRCM_SWDSGN_RGMII_GETMODE_PROC                 (0xB707U)    /**< @brief #RGMII_GetMode              */
#define BRCM_SWDSGN_RGMII_SETMODE_PROC                 (0xB708U)    /**< @brief #RGMII_SetMode              */
#define BRCM_SWDSGN_RGMII_SETSPEED_PROC                (0xB709U)    /**< @brief #RGMII_SetSpeed             */
#define BRCM_SWDSGN_RGMII_GETAUTONEGSTATUS_PROC        (0xB70AU)    /**< @brief #RGMII_GetAutoNegStatus     */
#define BRCM_SWDSGN_RGMII_SETDUPLEXMODE_PROC           (0xB70BU)    /**< @brief #RGMII_SetDuplexMode        */
#define BRCM_SWDSGN_RGMII_SETFLOWCONTROL_PROC          (0xB70CU)    /**< @brief #RGMII_SetFlowControl       */
#define BRCM_SWDSGN_RGMII_GETFLOWCONTROL_PROC          (0xB70DU)    /**< @brief #RGMII_GetFlowControl       */
#define BRCM_SWDSGN_RGMII_LINKCHANGEINDHANDLER_PROC    (0xB70EU)    /**< @brief #RGMII_LinkChangeIndHandler */
#define BRCM_SWDSGN_RGMII_DEINIT_PROC                  (0xB70FU)    /**< @brief #RGMII_DeInit               */
#define BRCM_SWDSGN_RGMII_GETSTATS_PROC                (0xB710U)    /**< @brief #RGMII_GetStats             */
#define BRCM_SWDSGN_RGMII_SETPARAMMODE_PROC            (0xB711U)    /**< @brief #RGMII_SetParamMode         */
#define BRCM_SWDSGN_RGMII_GETPARAMMODE_PROC            (0xB712U)    /**< @brief #RGMII_GetParamMode         */
#define BRCM_SWDSGN_RGMII_STATEHANDLER_PROC            (0xB713U)    /**< @brief #RGMII_StateHandler         */
#define BRCM_SWDSGN_RGMII_RWDATA_TYPE                  (0xB714U)    /**< @brief #RGMII_RWDataType           */
#define BRCM_SWDSGN_RGMII_RWDATA_GLOBAL                (0xB715U)    /**< @brief #RGMII_RWData               */
#define BRCM_SWDSGN_RGMII_FUNCTBL_GLOBAL               (0xB716U)    /**< @brief #RGMII_FuncTbl              */
/** @} */

/**
    @trace #BRCM_SWREQ_RGMII_FUNCTBL
    @trace #BRCM_SWARCH_RGMII_FUNCTBL_GLOBAL
*/
typedef struct sRGMII_RWDataType {
    ETHXCVR_ModeType  mode;
} RGMII_RWDataType;

/**
    @trace #BRCM_SWREQ_RGMII_FUNCTBL
    @trace #BRCM_SWARCH_RGMII_FUNCTBL_GLOBAL
*/
static RGMII_RWDataType RGMII_RWData[ETHXCVR_HW_ID_MAX]
COMP_SECTION(".bss.drivers");

/**
    @trace #BRCM_SWARCH_RGMII_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_RGMII_FUNCTBL
*/
static int32_t RGMII_Init(uint8_t aBusIdx,
                          ETHXCVR_CntxtType *const aCntxt,
                          const ETHXCVR_PortConfigType *const aConfig)
{
    return BCM_ERR_OK;
}

/**
    @trace #BRCM_SWARCH_RGMII_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_RGMII_FUNCTBL
*/
static int32_t RGMII_DeInit(uint8_t aBusIdx,
                            ETHXCVR_CntxtType *const aCntxt,
                            const ETHXCVR_PortConfigType *const aConfig)
{
    return BCM_ERR_OK;
}

/**
    @trace #BRCM_SWARCH_RGMII_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_RGMII_FUNCTBL
*/
static int32_t RGMII_SetMode(uint8_t aBusIdx,
                             ETHXCVR_CntxtType *const aCntxt,
                             const ETHXCVR_PortConfigType *const aConfig,
                             ETHXCVR_ModeType aMode)
{
    int32_t retVal = BCM_ERR_OK;

    if (NULL == aConfig) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (ETHXCVR_MODE_ISOLATE == aMode) {
#ifndef ENABLE_ETHXCVR_RGMII_ISOLATE
        retVal = BCM_ERR_NOSUPPORT;
#endif
    } else {
        retVal = BCM_ERR_OK;
    }
    if (BCM_ERR_OK == retVal) {
        RGMII_RWData[aConfig->id].mode = aMode;
    }
    return retVal;
}

/**
    @trace #BRCM_SWARCH_RGMII_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_RGMII_FUNCTBL
*/
static int32_t RGMII_GetMode(uint8_t aBusIdx,
                             ETHXCVR_CntxtType *const aCntxt,
                             const ETHXCVR_PortConfigType *const aConfig,
                             ETHXCVR_ModeType *const aMode)
{
    int32_t retVal = BCM_ERR_OK;

    if ((NULL == aMode)
        || (NULL == aConfig)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        *aMode = RGMII_RWData[aConfig->id].mode;
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_RGMII_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_RGMII_FUNCTBL
*/
static int32_t RGMII_GetLinkState(uint8_t aBusIdx,
                                  ETHXCVR_CntxtType *const aCntxt,
                                  const ETHXCVR_PortConfigType *const aConfig,
                                  ETHXCVR_LinkStateType *const aLinkState)
{
    int32_t retVal = BCM_ERR_OK;

    if ((NULL == aConfig)
        || (NULL == aLinkState)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        if ((ETHXCVR_MODE_ISOLATE == RGMII_RWData[aConfig->id].mode) ||
            (ETHXCVR_MODE_ACTIVE == RGMII_RWData[aConfig->id].mode)) {
            *aLinkState = ETHXCVR_LINKSTATE_ACTIVE;
        } else {
            *aLinkState = ETHXCVR_LINKSTATE_DOWN;
        }
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_RGMII_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_RGMII_FUNCTBL
*/
static int32_t RGMII_Command(uint8_t aBusIdx,
                             ETHXCVR_CntxtType *const aCntxt,
                             const ETHXCVR_PortConfigType *const aConfig)
{
    return BCM_ERR_NOSUPPORT;
}

/**
    @trace #BRCM_SWARCH_RGMII_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_RGMII_FUNCTBL
*/
static int32_t RGMII_GetSpeed(uint8_t aBusIdx,
                              ETHXCVR_CntxtType *const aCntxt,
                              const ETHXCVR_PortConfigType *const aConfig,
                              ETHXCVR_SpeedType *const aSpeed)
{
    int32_t retVal = BCM_ERR_OK;

    if ((NULL == aSpeed)
        || (NULL == aConfig)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        *aSpeed = aConfig->speed;
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_RGMII_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_RGMII_FUNCTBL
*/
static int32_t RGMII_SetSpeed(uint8_t aBusIdx,
                              ETHXCVR_CntxtType *const aCntxt,
                              const ETHXCVR_PortConfigType *const aConfig,
                              ETHXCVR_SpeedType aSpeed)
{
    int32_t retVal;

    if ((NULL == aConfig)
         || (ETHXCVR_SPEED_1000MBPS < aSpeed)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (aConfig->speed != aSpeed){
        retVal = BCM_ERR_NOSUPPORT;
    } else {
        retVal = BCM_ERR_OK;
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_RGMII_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_RGMII_FUNCTBL
*/
static int32_t RGMII_GetDuplexMode(uint8_t aBusIdx,
                                   ETHXCVR_CntxtType *const aCntxt,
                                   const ETHXCVR_PortConfigType *const aConfig,
                                   ETHXCVR_DuplexModeType *const aDuplexMode)
{
    int32_t retVal = BCM_ERR_OK;

    if ((NULL == aDuplexMode)
        || (NULL == aConfig)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        *aDuplexMode = aConfig->duplex;
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_RGMII_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_RGMII_FUNCTBL
*/
static int32_t RGMII_SetDuplexMode(uint8_t aBusIdx,
                                   ETHXCVR_CntxtType *const aCntxt,
                                   const ETHXCVR_PortConfigType *const aConfig,
                                   ETHXCVR_DuplexModeType aDuplexMode)
{
    int32_t retVal = BCM_ERR_OK;

    if (aDuplexMode == ETHXCVR_DUPLEXMODE_HALF) {
        retVal = BCM_ERR_NOSUPPORT;
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_RGMII_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_RGMII_FUNCTBL
*/
static int32_t RGMII_GetFlowControl(uint8_t aBusIdx,
                                    ETHXCVR_CntxtType *const aCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig,
                                    ETHXCVR_FlowControlType *const aFlowControl)
{
    int32_t  retVal  = BCM_ERR_OK;

    if ((NULL == aConfig)
        || (NULL == aFlowControl)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        *aFlowControl = aConfig->flowControl;
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_RGMII_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_RGMII_FUNCTBL
*/
static int32_t RGMII_SetFlowControl(uint8_t aBusIdx,
                                    ETHXCVR_CntxtType *const aCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig,
                                    ETHXCVR_FlowControlType aFlowControl)
{
    return BCM_ERR_NOSUPPORT;
}

/**
    @trace #BRCM_SWARCH_RGMII_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_RGMII_FUNCTBL
*/
static int32_t RGMII_GetSQIValue(uint8_t aBusIdx,
                                 ETHXCVR_CntxtType *const aCntxt,
                                 const ETHXCVR_PortConfigType *const aConfig,
                                 uint32_t *const aSQIValue)
{
    return BCM_ERR_NOSUPPORT;
}

/**
    @trace #BRCM_SWARCH_RGMII_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_RGMII_FUNCTBL
*/
static int32_t RGMII_SetParamMode(uint8_t aBusIdx,
                                  ETHXCVR_CntxtType *const aCntxt,
                                  const ETHXCVR_PortConfigType *const aConfig,
                                  ETHXCVR_BooleanType aMode)
{
    return BCM_ERR_NOSUPPORT;
}

/**
    @trace #BRCM_SWARCH_RGMII_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_RGMII_FUNCTBL
*/
static int32_t RGMII_GetParamMode(uint8_t aBusIdx,
                                  ETHXCVR_CntxtType *const aCntxt,
                                  const ETHXCVR_PortConfigType *const aConfig,
                                  ETHXCVR_BooleanType *const aMode)
{
    return BCM_ERR_NOSUPPORT;
}

/**
    @trace #BRCM_SWARCH_RGMII_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_RGMII_FUNCTBL
*/
static int32_t RGMII_GetAutoNegStatus(uint8_t aBusIdx,
                                      ETHXCVR_CntxtType *const aCntxt,
                                      const ETHXCVR_PortConfigType *const aConfig,
                                      ETHXCVR_AutoNegStatusType *const aStatus)
{
    int32_t retVal = BCM_ERR_OK;

    if (NULL == aStatus) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        *aStatus = ETHXCVR_AUTONEGSTATUS_NO_ABILITY;
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_RGMII_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_RGMII_FUNCTBL
*/
static int32_t RGMII_GetStats(uint8_t aBusIdx,
                              ETHXCVR_CntxtType *const aCntxt,
                              const ETHXCVR_PortConfigType *const aConfig,
                              ETHXCVR_StatsType *const aStats)
{
    return BCM_ERR_NOSUPPORT;
}

/**
    @trace #BRCM_SWARCH_RGMII_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_RGMII_FUNCTBL
*/
static int32_t RGMII_StateHandler(uint8_t aBusIdx,
                                  ETHXCVR_CntxtType *const aCntxt,
                                  const ETHXCVR_PortConfigType *const aConfig,
                                  uint32_t *const aIsModeChanged,
                                  ETHXCVR_ModeType *const aMode)
{
    return BCM_ERR_OK;
}

/**
    @trace #BRCM_SWARCH_RGMII_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_RGMII_FUNCTBL
*/
int32_t RGMII_LinkChangeIndHandler(uint8_t aBusIdx,
                                   ETHXCVR_CntxtType *const aCntxt,
                                   const ETHXCVR_PortConfigType *const aConfig,
                                   ETHXCVR_LinkStateType *const aLinkState,
                                   uint32_t *const aIsLinkStateChanged)
{
    return BCM_ERR_NOSUPPORT;
}

/**
    @trace #BRCM_SWARCH_RGMII_FUNCTBL_GLOBAL
    @trace  #BRCM_SWREQ_RGMII_FUNCTBL
*/
const ETHXCVR_FuncTblType RGMII_FuncTbl = {
    .init = RGMII_Init,
    .deinit = RGMII_DeInit,
    .reset = RGMII_Command,
    .setMode = RGMII_SetMode,
    .getMode = RGMII_GetMode,
    .setMasterMode = RGMII_SetParamMode,
    .getMasterMode = RGMII_GetParamMode,
    .getSpeed = RGMII_GetSpeed,
    .setSpeed = RGMII_SetSpeed,
    .getDuplexMode = RGMII_GetDuplexMode,
    .setDuplexMode = RGMII_SetDuplexMode,
    .setFlowControl = RGMII_SetFlowControl,
    .getFlowControl = RGMII_GetFlowControl,
    .getLinkState = RGMII_GetLinkState,
    .getSQIValue = RGMII_GetSQIValue,
    .setLoopbackMode = RGMII_SetParamMode,
    .getLoopbackMode = RGMII_GetParamMode,
    .setJumboMode = RGMII_SetParamMode,
    .getJumboMode = RGMII_GetParamMode,
    .setAutoNegMode = RGMII_SetParamMode,
    .getAutoNegStatus = RGMII_GetAutoNegStatus,
    .restartAutoNeg = RGMII_Command,
    .getStats = RGMII_GetStats,
    .stateHandler = RGMII_StateHandler,
    .updateHWStatus = RGMII_Command,
    .linkChangeIndHandler = RGMII_LinkChangeIndHandler,
    .linkIRQHandler  = RGMII_Command,
};

/** @} */
