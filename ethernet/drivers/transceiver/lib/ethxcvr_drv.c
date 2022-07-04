/****************************************************************************
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

/**
    @addtogroup grp_eth_xcvrdrv_drv_impl
    @{

    @file ethxcvr_drv.c
*/

#include <bcm_utils.h>
#include <ethxcvr_osil.h>
#include "ethxcvr_drv.h"
#include "ethxcvr_platform.h"

/**
    @name Transceiver driver Design IDs
    @{
    @brief Design IDs for Transceiver driver
*/
#define BRCM_SWDSGN_ETHXCVR_DRVINIT_PROC                     (0xBC01U)    /**< @brief #ETHXCVR_DrvInit                  */
#define BRCM_SWDSGN_ETHXCVR_DRVGETSPEED_PROC                 (0xBC02U)    /**< @brief #ETHXCVR_DrvGetSpeed              */
#define BRCM_SWDSGN_ETHXCVR_DRVSETMODE_PROC                  (0xBC03U)    /**< @brief #ETHXCVR_DrvSetMode               */
#define BRCM_SWDSGN_ETHXCVR_DRVGETMODE_PROC                  (0xBC04U)    /**< @brief #ETHXCVR_DrvGetMode               */
#define BRCM_SWDSGN_ETHXCVR_DRVGETLINKSTATE_PROC             (0xBC05U)    /**< @brief #ETHXCVR_DrvGetLinkState          */
#define BRCM_SWDSGN_ETHXCVR_DRVGETDUPLEXMODE_PROC            (0xBC06U)    /**< @brief #ETHXCVR_DrvGetDuplexMode         */
#define BRCM_SWDSGN_ETHXCVR_DRVGETSQIVALUE_PROC              (0xBC07U)    /**< @brief #ETHXCVR_DrvGetSQIValue           */
#define BRCM_SWDSGN_ETHXCVR_DRVLINKIRQHANDLER_PROC           (0xBC08U)    /**< @brief #ETHXCVR_DrvLinkIRQHandler        */
#define BRCM_SWDSGN_ETHXCVR_DRVLINKCHGINDHANDLER_PROC        (0xBC09U)    /**< @brief #ETHXCVR_DrvLinkChgIndHandler     */
#define BRCM_SWDSGN_ETHXCVR_DRVRWDATA_TYPE                   (0xBC0AU)    /**< @brief #ETHXCVR_DrvRWDataType            */
#define BRCM_SWDSGN_ETHXCVR_DRVRWDATA_GLOBAL                 (0xBC0BU)    /**< @brief #ETHXCVR_DrvRWData                */
#define BRCM_SWDSGN_ETHXCVR_DRVISPHYFUNCTBLVALID_PROC        (0xBC0CU)    /**< @brief #ETHXCVR_DrvIsPhyFuncTblValid     */
#define BRCM_SWDSGN_ETHXCVR_DRVDEINIT_PROC                   (0xBC0DU)    /**< @brief #ETHXCVR_DrvDeInit                */
#define BRCM_SWDSGN_ETHXCVR_DRVSETSPEED_PROC                 (0xBC0EU)    /**< @brief #ETHXCVR_DrvSetSpeed              */
#define BRCM_SWDSGN_ETHXCVR_DRVSETMASTERMODE_PROC            (0xBC0FU)    /**< @brief #ETHXCVR_DrvSetMasterMode         */
#define BRCM_SWDSGN_ETHXCVR_DRVGETMASTERMODE_PROC            (0xBC10U)    /**< @brief #ETHXCVR_DrvGetMasterMode         */
#define BRCM_SWDSGN_ETHXCVR_DRVSETLOOPBACKMODE_PROC          (0xBC11U)    /**< @brief #ETHXCVR_DrvSetLoopbackMode       */
#define BRCM_SWDSGN_ETHXCVR_DRVGETLOOPBACKMODE_PROC          (0xBC12U)    /**< @brief #ETHXCVR_DrvGetLoopbackMode       */
#define BRCM_SWDSGN_ETHXCVR_DRVSETJUMBOMODE_PROC             (0xBC13U)    /**< @brief #ETHXCVR_DrvSetJumboMode          */
#define BRCM_SWDSGN_ETHXCVR_DRVRESTARTAUTONEG_PROC           (0xBC14U)    /**< @brief #ETHXCVR_DrvRestartAutoNeg        */
#define BRCM_SWDSGN_ETHXCVR_DRVGETAUTONEGSTATUS_PROC         (0xBC15U)    /**< @brief #ETHXCVR_DrvGetAutoNegStatus      */
#define BRCM_SWDSGN_ETHXCVR_DRVGETSTATS_PROC                 (0xBC16U)    /**< @brief #ETHXCVR_DrvGetStats              */
#define BRCM_SWDSGN_ETHXCVR_DRVGETJUMBOMODE_PROC             (0xBC17U)    /**< @brief #ETHXCVR_DrvGetJumboMode          */
#define BRCM_SWDSGN_ETHXCVR_DRVSETDUPLEXMODE_PROC            (0xBC18U)    /**< @brief #ETHXCVR_DrvSetDuplexMode         */
#define BRCM_SWDSGN_ETHXCVR_DRVSETFLOWCONTROL_PROC           (0xBC19U)    /**< @brief #ETHXCVR_DrvSetFlowControl        */
#define BRCM_SWDSGN_ETHXCVR_DRVGETFLOWCONTROL_PROC           (0xBC1AU)    /**< @brief #ETHXCVR_DrvGetFlowControl        */
#define BRCM_SWDSGN_ETHXCVR_DRVSTATEHANDLER_PROC             (0xBC1BU)    /**< @brief #ETHXCVR_DrvStateHandler          */
#define BRCM_SWDSGN_ETHXCVR_DRVUPDATEHWSTATUS_PROC           (0xBC1CU)    /**< @brief #ETHXCVR_DrvUpdateHWStatus        */
#define BRCM_SWDSGN_ETHXCVR_DRVGETPORTCONFIG_PROC            (0xBC1DU)    /**< @brief #ETHXCVR_DrvGetPortConfig         */
#define BRCM_SWDSGN_ETHXCVR_DRVSETAUTONEGMODE_PROC           (0xBC1EU)    /**< @brief #ETHXCVR_DrvSetAutoNegMode        */
#define BRCM_SWDSGN_ETHXCVR_DRVSETWAKEUPMODE_PROC            (0xBC1FU)    /**< @brief #ETHXCVR_DrvSetWakeUpMode         */
#define BRCM_SWDSGN_ETHXCVR_DRVGETWAKEUPMODE_PROC            (0xBC20U)    /**< @brief #ETHXCVR_DrvGetWakeUpMode         */
#define BRCM_SWDSGN_ETHXCVR_DRVGETWAKEUPREASON_PROC          (0xBC21U)    /**< @brief #ETHXCVR_DrvGetWakeUpReason       */
#define BRCM_SWDSGN_ETHXCVR_DRVREPORTERROR_PROC              (0xBC22U)    /**< @brief #ETHXCVR_DrvReportError           */
#define BRCM_SWDSGN_ETHXCVR_ACQUIRERELEASECONTROLLER_PROC    (0xBC23U)    /**< @brief #ETHXCVR_AcquireReleaseController */
#define BRCM_SWDSGN_ETHXCVR_SWCONTROLLERSTATE_GLOBAL         (0xBC24U)    /**< @brief #ETHXCVR_SWControllerState        */
/** @} */

/**
    @trace #BRCM_SWARCH_ETHXCVR_INIT_PROC
    @trace #BRCM_SWARCH_ETHXCVR_DEINIT_PROC
    @trace #BRCM_SWARCH_ETHXCVR_SETMODE_PROC
    @trace #BRCM_SWARCH_ETHXCVR_GETMODE_PROC
    @trace #BRCM_SWARCH_ETHXCVR_GETLINKSTATE_PROC
    @trace #BRCM_SWARCH_ETHXCVR_GETSPEED_PROC
    @trace #BRCM_SWARCH_ETHXCVR_GETDUPLEXMODE_PROC
    @trace #BRCM_SWARCH_ETHXCVR_GETSQIVALUE_PROC
    @trace #BRCM_SWARCH_ETHXCVR_LINKIRQHANDLER_PROC
    @trace #BRCM_SWARCH_ETHXCVR_LINKCHGINDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHXCVR_KERNEL_HANDLER
*/
void ETHXCVR_DrvReportError(uint16_t aCompID, uint8_t aInstanceID,
        uint16_t aApiID, int32_t aErr, uint32_t aVal0, uint32_t aVal1,
        uint32_t aVal2, uint32_t aVal3)
{
    const uint32_t values[4] = {aVal0, aVal1, aVal2, aVal3};
    BCM_ReportError(aCompID, aInstanceID, aApiID, aErr, 4UL, values);
}


/**
    @trace #BRCM_SWARCH_ETHXCVR_INIT_PROC
    @trace #BRCM_SWARCH_ETHXCVR_DEINIT_PROC
    @trace #BRCM_SWARCH_ETHXCVR_SETMODE_PROC
    @trace #BRCM_SWARCH_ETHXCVR_GETMODE_PROC
    @trace #BRCM_SWARCH_ETHXCVR_GETLINKSTATE_PROC
    @trace #BRCM_SWARCH_ETHXCVR_GETSPEED_PROC
    @trace #BRCM_SWARCH_ETHXCVR_GETDUPLEXMODE_PROC
    @trace #BRCM_SWARCH_ETHXCVR_GETSQIVALUE_PROC
    @trace #BRCM_SWARCH_ETHXCVR_LINKIRQHANDLER_PROC
    @trace #BRCM_SWARCH_ETHXCVR_LINKCHGINDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHXCVR_KERNEL_HANDLER
*/
typedef struct sETHXCVR_DrvRWDataType {
    ETHXCVR_StateType      xcvrState;
    ETHXCVR_PortConfigType xcvrCfg;
} ETHXCVR_DrvRWDataType;

/**
    @trace #BRCM_SWARCH_ETHXCVR_DRVINIT_PROC
    @trace #BRCM_SWARCH_ETHXCVR_DRVDEINIT_PROC
    @trace #BRCM_SWARCH_ETHXCVR_DRVSETMODE_PROC
    @trace #BRCM_SWARCH_ETHXCVR_DRVGETMODE_PROC
    @trace #BRCM_SWARCH_ETHXCVR_DRVGETLINKSTATE_PROC
    @trace #BRCM_SWARCH_ETHXCVR_DRVGETSPEED_PROC
    @trace #BRCM_SWARCH_ETHXCVR_DRVGETDUPLEXMODE_PROC
    @trace #BRCM_SWARCH_ETHXCVR_DRVGETSQIVALUE_PROC
    @trace #BRCM_SWARCH_ETHXCVR_LINKIRQHANDLER_PROC
    @trace #BRCM_SWARCH_ETHXCVR_LINKCHGINDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHXCVR_KERNEL_HANDLER
*/
static ETHXCVR_DrvRWDataType ETHXCVR_DrvRWData[ETHXCVR_HW_ID_MAX] COMP_SECTION(".bss.drivers");

#ifdef ETHXCVR_SHARED_CONTROLLERS
/**
    @brief Software controller state for ETHXCVR library

    The bitmap representing software controllers acquisition state.
    If the bit is set then the corresponding software controller index
    has been acquired otherwise controller is free to acquire.

    @trace #BRCM_SWARCH_ETHXCVR_DRVDEINIT_PROC
    @trace #BRCM_SWARCH_ETHXCVR_DRVINIT_PROC
    @trace #BRCM_SWREQ_ETHXCVR_KERNEL_HANDLER
*/
static uint32_t ETHXCVR_SWControllerState COMP_SECTION(".bss.drivers");
#endif

/**
    @brief This function checks whether the shared controller is already allocated to any
           port or not. If the shared controller is not allocated to any other port
           then it will allocate the shared controller to the provided port. Otherwise
           error will be returned. This function also checks if the controller is allocated
           to the input port and releases it.

    @behavior Sync, Non-Reeentrant

    @param[in]  aConfig      Pointer to port configuration
    @param[in]  aIsAcquire   Acquire the controller if aIsAcquire is
                             TRUE, otherwise release the controller

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @retval     #BCM_ERR_UNKNOWN        Shared controller not found
    @retval     #BCM_ERR_NOPERM         Shared controller is already used by another port

    @post None

    @code{.c}
    retVal = BCM_ERR_UNKNOWN;
    for(i = 0UL; i < ETHXCVR_MAX_CONTROLLERS; i++) {
        if((ETHXCVR_ControllerMap[i].port == aConfig->id) &&
           (ETHXCVR_ControllerMap[i].busMode == aConfig->busMode) &&
           (ETHXCVR_ControllerMap[i].hwControllerID == aConfig->bus.cntrlID)
          ) {
            swControllerID = ETHXCVR_ControllerMap[i].swControllerID;
            if(ETHXCVR_BOOLEAN_TRUE == aIsAcquire) {
                if (0UL == (ETHXCVR_SWControllerState & (1UL << swControllerID))) {
                   ETHXCVR_SWControllerState |= (1UL << swControllerID);
                   retVal = BCM_ERR_OK;
                }  else {
                   retVal = BCM_ERR_NOPERM;
                }
            } else {
                ETHXCVR_SWControllerState &= ~(1UL << swControllerID);
                retVal = BCM_ERR_OK;
            }
            break;
        }
    }
    return retVal;

    @endcode

    @trace #BRCM_SWARCH_ETHXCVR_DRVDEINIT_PROC
    @trace #BRCM_SWARCH_ETHXCVR_DRVINIT_PROC
    @trace #BRCM_SWREQ_ETHXCVR_KERNEL_HANDLER
*/
static int32_t ETHXCVR_AcquireReleaseController(const ETHXCVR_PortConfigType *const aConfig, ETHXCVR_BooleanType aIsAcquire)
{
#ifdef ETHXCVR_SHARED_CONTROLLERS
    int32_t retVal = BCM_ERR_UNKNOWN;
    uint32_t i;
    uint8_t  swControllerID;

    for(i = 0UL; i < ETHXCVR_MAX_CONTROLLERS; i++) {
        if((ETHXCVR_ControllerMap[i].port == aConfig->id) &&
           (ETHXCVR_ControllerMap[i].busMode == aConfig->busMode) &&
           (ETHXCVR_ControllerMap[i].hwControllerID == aConfig->bus.cntrlID)
          ) {
            swControllerID = ETHXCVR_ControllerMap[i].swControllerID;
            if(ETHXCVR_BOOLEAN_TRUE == aIsAcquire) {
                if (0UL == (ETHXCVR_SWControllerState & (1UL << swControllerID))) {
                   ETHXCVR_SWControllerState |= (1UL << swControllerID);
                   retVal = BCM_ERR_OK;
                }  else {
                   retVal = BCM_ERR_NOPERM;
                }
            } else {
                ETHXCVR_SWControllerState &= ~(1UL << swControllerID);
                retVal = BCM_ERR_OK;
            }
            break;
        }
    }
    return retVal;
#else
    return BCM_ERR_OK;
#endif /* ETHXCVR_SHARED_CONTROLLERS */
}

/**
    @trace #BRCM_SWARCH_ETHXCVR_DRVINIT_PROC
    @trace #BRCM_SWREQ_ETHXCVR_KERNEL_HANDLER
*/
int32_t ETHXCVR_DrvInit(ETHXCVR_IDType aID,
                        const ETHXCVR_PortConfigType *const aConfig)
{
    int32_t retVal;
    const ETHXCVR_FuncTblType    *phyFunc = NULL;
    const ETHXCVR_FuncTblType    *busFunc = NULL;
    ETHXCVR_CntxtType            *phyCntxt = NULL;
    uint32_t line = __LINE__;
    retVal = ETHXCVR_PlatformValidateConfig(aConfig);
    if (BCM_ERR_OK != retVal) {
        line = __LINE__;
        goto err;
    }
    retVal = ETHXCVR_AcquireReleaseController(aConfig, ETHXCVR_BOOLEAN_TRUE);
    if (BCM_ERR_OK != retVal) {
        line = __LINE__;
        goto err;
    }
    retVal = ETHXCVR_PlatformGetFnTblsCntxt(aConfig, &busFunc, &phyFunc, &phyCntxt);

    if (BCM_ERR_OK == retVal) {
        if (ETHXCVR_STATE_UNINIT == ETHXCVR_DrvRWData[aID].xcvrState) {
            if ((NULL == busFunc) && (NULL == phyFunc)) {
                retVal = BCM_ERR_INVAL_PARAMS;
                line = __LINE__;
            } else {
                if (NULL != busFunc) {
                    retVal = busFunc->init(aConfig->bus.cntrlID, NULL, aConfig);
                    line = __LINE__;
                }

                if ((BCM_ERR_OK == retVal) && (NULL != phyFunc)) {
                    retVal = phyFunc->init(aConfig->phy.hwID, phyCntxt, aConfig);
                    line = __LINE__;
                }

                if (BCM_ERR_OK == retVal) {
                    ETHXCVR_DrvRWData[aID].xcvrState = ETHXCVR_STATE_INIT;
                    /* Cache the config */
                    BCM_MemCpy(&ETHXCVR_DrvRWData[aID].xcvrCfg, aConfig, sizeof(ETHXCVR_PortConfigType));
                    line = __LINE__;
                }
            }
        } else {
            retVal = BCM_ERR_INVAL_STATE;
            line = __LINE__;
        }
    }

err:
    if(retVal != BCM_ERR_OK) {
        ETHXCVR_DrvReportError(BCM_XVR_ID, aID, BRCM_SWDSGN_ETHXCVR_DRVINIT_PROC, retVal, (uint32_t)(aConfig->id),
                               (uint32_t)(aConfig->busMode), (uint32_t)(aConfig->bus.cntrlID), line);
    }
    return retVal;
}

/**
    @trace #BRCM_SWARCH_ETHXCVR_DRVDEINIT_PROC
    @trace #BRCM_SWREQ_ETHXCVR_KERNEL_HANDLER
*/
int32_t ETHXCVR_DrvDeInit(ETHXCVR_IDType aID)
{
    int32_t                      retVal;
    const ETHXCVR_FuncTblType    *phyFunc = NULL;
    const ETHXCVR_FuncTblType    *busFunc = NULL;
    const ETHXCVR_PortConfigType *config  = &ETHXCVR_DrvRWData[aID].xcvrCfg;
    ETHXCVR_CntxtType            *phyCntxt = NULL;

    retVal = ETHXCVR_PlatformGetFnTblsCntxt(config, &busFunc, &phyFunc, &phyCntxt);

    if (BCM_ERR_OK == retVal) {
        if (ETHXCVR_STATE_INIT == ETHXCVR_DrvRWData[aID].xcvrState) {
            if (NULL != phyFunc) {
                retVal = phyFunc->deinit(config->phy.hwID, phyCntxt, config);
            }

            if ((BCM_ERR_OK == retVal) && (NULL != busFunc)) {
                retVal = busFunc->deinit(config->bus.cntrlID, NULL, config);
            }

            if (BCM_ERR_OK == retVal) {
                retVal = ETHXCVR_AcquireReleaseController(config, ETHXCVR_BOOLEAN_FALSE);
            }
            if (BCM_ERR_OK == retVal) {
                ETHXCVR_DrvRWData[aID].xcvrState = ETHXCVR_STATE_UNINIT;
                BCM_MemSet(&ETHXCVR_DrvRWData[aID].xcvrCfg, 0U, sizeof(ETHXCVR_PortConfigType));
            }
        } else {
            retVal = BCM_ERR_INVAL_STATE;
        }
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_ETHXCVR_DRVSETMODE_PROC
    @trace #BRCM_SWREQ_ETHXCVR_KERNEL_HANDLER
*/
int32_t ETHXCVR_DrvSetMode(ETHXCVR_IDType aID,
                           ETHXCVR_ModeType aMode,
                           uint32_t *const aIsModeChanged)
{
    int32_t                      retVal;
    const ETHXCVR_FuncTblType    *phyFunc = NULL;
    const ETHXCVR_FuncTblType    *busFunc = NULL;
    const ETHXCVR_PortConfigType *config  = &ETHXCVR_DrvRWData[aID].xcvrCfg;
    ETHXCVR_CntxtType            *phyCntxt = NULL;
    ETHXCVR_BooleanType          wakeupModeEn = ETHXCVR_BOOLEAN_FALSE;

    retVal = ETHXCVR_PlatformGetFnTblsCntxt(config, &busFunc, &phyFunc, &phyCntxt);

    if (BCM_ERR_OK == retVal) {
        if (ETHXCVR_STATE_UNINIT == ETHXCVR_DrvRWData[aID].xcvrState) {
            retVal = BCM_ERR_INVAL_STATE;
        } else {
            retVal = ETHXCVR_PlatformMuxConfigure(config, aMode);
            if (BCM_ERR_OK == retVal) {
                if (NULL != busFunc){
                    if (NULL != phyFunc){
                        retVal = phyFunc->getWakeUpMode(config->phy.hwID, phyCntxt, config, &wakeupModeEn);
                    }
                    if(BCM_ERR_OK == retVal) {
                        if ((ETHXCVR_BOOLEAN_TRUE == wakeupModeEn) &&(ETHXCVR_BUSMODE_RGMII == config->busMode)) {
                            /* Do Nothing */
                        } else {
                            retVal = busFunc->setMode(config->bus.cntrlID, NULL, config, aMode);
                            if (BCM_ERR_OK == retVal) {
                                *aIsModeChanged = TRUE;
                            }
                        }
                    }
                }
                if ((BCM_ERR_OK == retVal) && (NULL != phyFunc)) {
                    retVal = phyFunc->setMode(config->phy.hwID, phyCntxt, config, aMode);
                    if (BCM_ERR_OK == retVal) {
                        *aIsModeChanged = (ETHXCVR_DrvRWData[aID].xcvrCfg.phy.accessMode == ETHXCVR_ACCESSMODE_MMAP) ?
                            TRUE: FALSE;
                    }
                }
                if (BCM_ERR_OK == retVal) {
                    /* Update the configuration */
                    ETHXCVR_DrvRWData[aID].xcvrCfg.portEnable = (aMode == ETHXCVR_MODE_ACTIVE) ?
                        ETHXCVR_BOOLEAN_TRUE:ETHXCVR_BOOLEAN_FALSE;
                }
            }
        }
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_ETHXCVR_DRVGETMODE_PROC
    @trace #BRCM_SWREQ_ETHXCVR_KERNEL_HANDLER
*/
int32_t ETHXCVR_DrvGetMode(ETHXCVR_IDType aID,
                           ETHXCVR_ModeType *const aMode)
{
    int32_t                      retVal;
    const ETHXCVR_FuncTblType    *phyFunc = NULL;
    const ETHXCVR_FuncTblType    *busFunc = NULL;
    const ETHXCVR_PortConfigType *config  = &ETHXCVR_DrvRWData[aID].xcvrCfg;
    ETHXCVR_ModeType             phyMode = ETHXCVR_MODE_DOWN;
    ETHXCVR_CntxtType            *phyCntxt = NULL;

    retVal = ETHXCVR_PlatformGetFnTblsCntxt(config, &busFunc, &phyFunc, &phyCntxt);

    if (BCM_ERR_OK == retVal) {
        if (ETHXCVR_STATE_UNINIT == ETHXCVR_DrvRWData[aID].xcvrState) {
            retVal = BCM_ERR_INVAL_STATE;
        } else {
            if (NULL != busFunc) {
                retVal = busFunc->getMode(config->bus.cntrlID, NULL, config, aMode);
            }
            if ((BCM_ERR_OK == retVal) && (NULL != phyFunc)) {
                retVal = phyFunc->getMode(config->phy.hwID, phyCntxt, config, &phyMode);
                /* Check for mismatch between bus and phy */
                if (BCM_ERR_OK == retVal)  {
                    if (NULL != busFunc) {
                        if ((*aMode != phyMode) && (ETHXCVR_MODE_ISOLATE != *aMode)) {
                            *aMode = ETHXCVR_MODE_DOWN;
                        }
                    } else {
                        *aMode = phyMode;
                    }
                }
            }
        }
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_ETHXCVR_DRVGETLINKSTATE_PROC
    @trace #BRCM_SWREQ_ETHXCVR_KERNEL_HANDLER
*/
int32_t ETHXCVR_DrvGetLinkState(ETHXCVR_IDType aID,
                                ETHXCVR_LinkStateType *const aLinkState)
{
    int32_t                      retVal;
    const ETHXCVR_FuncTblType    *phyFunc = NULL;
    const ETHXCVR_FuncTblType    *busFunc = NULL;
    ETHXCVR_LinkStateType        phyLinkState = ETHXCVR_LINKSTATE_ACTIVE;
    ETHXCVR_LinkStateType        busLinkState = ETHXCVR_LINKSTATE_ACTIVE;
    const ETHXCVR_PortConfigType *config = &ETHXCVR_DrvRWData[aID].xcvrCfg;
    ETHXCVR_CntxtType            *phyCntxt = NULL;

    retVal = ETHXCVR_PlatformGetFnTblsCntxt(config, &busFunc, &phyFunc, &phyCntxt);

    if (BCM_ERR_OK == retVal) {
        if (ETHXCVR_STATE_UNINIT == ETHXCVR_DrvRWData[aID].xcvrState) {
            retVal = BCM_ERR_INVAL_STATE;
        } else {
            if (NULL != busFunc) {
                retVal = busFunc->getLinkState(config->bus.cntrlID, NULL, config, &busLinkState);
            }
            if (((BCM_ERR_OK == retVal) || (BCM_ERR_NOSUPPORT == retVal)) && (NULL != phyFunc)) {
                retVal = phyFunc->getLinkState(config->phy.hwID, phyCntxt, config, &phyLinkState);
            }
            /* Report down if any one of the status is down. Do not report error */
            if ((BCM_ERR_OK == retVal) || (BCM_ERR_NOSUPPORT == retVal)) {
                if ((ETHXCVR_LINKSTATE_DOWN == phyLinkState) || (ETHXCVR_LINKSTATE_DOWN == busLinkState)) {
                    *aLinkState = ETHXCVR_LINKSTATE_DOWN;
                } else {
                    *aLinkState = ETHXCVR_LINKSTATE_ACTIVE;
                }
            }
        }
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_ETHXCVR_DRVSETSPEED_PROC
    @trace #BRCM_SWREQ_ETHXCVR_KERNEL_HANDLER
*/
int32_t ETHXCVR_DrvSetSpeed(ETHXCVR_IDType aID,
                            ETHXCVR_SpeedType aSpeed)
{
    int32_t                      retVal;
    const ETHXCVR_FuncTblType    *phyFunc = NULL;
    const ETHXCVR_FuncTblType    *busFunc = NULL;
    const ETHXCVR_PortConfigType *config  = &ETHXCVR_DrvRWData[aID].xcvrCfg;
    ETHXCVR_CntxtType            *phyCntxt = NULL;

    if (ETHXCVR_BOOLEAN_TRUE == config->autoNeg) {
        retVal = BCM_ERR_NOPERM;
        goto done;
    }

    retVal = ETHXCVR_PlatformGetFnTblsCntxt(config, &busFunc, &phyFunc, &phyCntxt);

    if (BCM_ERR_OK == retVal) {
        if (ETHXCVR_STATE_UNINIT == ETHXCVR_DrvRWData[aID].xcvrState) {
            retVal = BCM_ERR_INVAL_STATE;
        } else {
            if (NULL != busFunc) {
                retVal = busFunc->setSpeed(config->bus.cntrlID, NULL, config, aSpeed);
            }
            if (((BCM_ERR_OK == retVal) || (BCM_ERR_NOSUPPORT == retVal)) && (NULL != phyFunc)) {
                retVal = phyFunc->setSpeed(config->phy.hwID, phyCntxt, config, aSpeed);
            }
            /* Update the configuration */
            if ((BCM_ERR_OK == retVal) || (BCM_ERR_NOSUPPORT == retVal)) {
                ETHXCVR_DrvRWData[aID].xcvrCfg.speed = aSpeed;
            }
        }
    }

done:
    return retVal;
}

/**
    @trace #BRCM_SWARCH_ETHXCVR_DRVGETSPEED_PROC
    @trace #BRCM_SWREQ_ETHXCVR_KERNEL_HANDLER
*/
int32_t ETHXCVR_DrvGetSpeed(ETHXCVR_IDType aID,
                            ETHXCVR_SpeedType *const aSpeed)
{
    int32_t                      retVal;
    const ETHXCVR_FuncTblType    *phyFunc = NULL;
    const ETHXCVR_FuncTblType    *busFunc = NULL;
    const ETHXCVR_PortConfigType *config  = &ETHXCVR_DrvRWData[aID].xcvrCfg;
    ETHXCVR_SpeedType            phySpeed = ETHXCVR_SPEED_10MBPS;
    ETHXCVR_CntxtType            *phyCntxt = NULL;

    retVal = ETHXCVR_PlatformGetFnTblsCntxt(config, &busFunc, &phyFunc, &phyCntxt);

    if (BCM_ERR_OK == retVal) {
        if (ETHXCVR_STATE_UNINIT == ETHXCVR_DrvRWData[aID].xcvrState) {
            retVal = BCM_ERR_INVAL_STATE;
        } else {
            if (NULL != busFunc) {
                retVal = busFunc->getSpeed(config->bus.cntrlID, NULL, config, aSpeed);
            }
            if (((BCM_ERR_OK == retVal) || (BCM_ERR_NOSUPPORT == retVal)) && (NULL != phyFunc)) {

                if (BCM_ERR_NOSUPPORT == retVal) {
                    retVal = phyFunc->getSpeed(config->phy.hwID, phyCntxt, config, aSpeed);
                } else {
                    retVal = phyFunc->getSpeed(config->phy.hwID, phyCntxt, config, &phySpeed);
                    /* Check for mismatch between phy and bus */
                    if (BCM_ERR_OK == retVal) {
                        if ((NULL != busFunc) && (ETHXCVR_PHYMEDIA_100BASET1 != config->phy.phyMedia)){
                           /*If there is an BUS Function available and the PHY is Not configured for 100BaseT1
                             Validate the speed read from BUS and PHY */
                            if (*aSpeed != phySpeed) {
                                retVal = BCM_ERR_UNKNOWN;
                            }
                        } else {
                            /* Other conditions respond the PhySpeed as Speed */
                            *aSpeed = phySpeed;
                        }
                    }
                }
            }
        }
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_ETHXCVR_DRVGETDUPLEXMODE_PROC
    @trace #BRCM_SWREQ_ETHXCVR_KERNEL_HANDLER
*/
int32_t ETHXCVR_DrvGetDuplexMode(ETHXCVR_IDType aID,
                                 ETHXCVR_DuplexModeType *const aDuplexMode)
{
    int32_t                      retVal;
    const ETHXCVR_FuncTblType    *phyFunc = NULL;
    const ETHXCVR_FuncTblType    *busFunc = NULL;
    const ETHXCVR_PortConfigType *config  = &ETHXCVR_DrvRWData[aID].xcvrCfg;
    ETHXCVR_DuplexModeType       phyDuplex = ETHXCVR_DUPLEXMODE_HALF;
    ETHXCVR_CntxtType            *phyCntxt = NULL;

    retVal = ETHXCVR_PlatformGetFnTblsCntxt(config, &busFunc, &phyFunc, &phyCntxt);

    if (BCM_ERR_OK == retVal) {
        if (ETHXCVR_STATE_UNINIT == ETHXCVR_DrvRWData[aID].xcvrState) {
            retVal = BCM_ERR_INVAL_STATE;
        } else {
            if (NULL != busFunc) {
                retVal = busFunc->getDuplexMode(config->bus.cntrlID, NULL, config, aDuplexMode);
            }
            if (((BCM_ERR_OK == retVal) || (BCM_ERR_NOSUPPORT == retVal)) && (NULL != phyFunc)) {
                if (BCM_ERR_NOSUPPORT == retVal) {
                    retVal = phyFunc->getDuplexMode(config->phy.hwID, phyCntxt, config, aDuplexMode);
                } else {
                    retVal = phyFunc->getDuplexMode(config->phy.hwID, phyCntxt, config, &phyDuplex);
                    /* Check for mismatch between phy and bus */
                    if (BCM_ERR_OK == retVal) {
                        if (NULL != busFunc) {
                            if (*aDuplexMode != phyDuplex) {
                                retVal = BCM_ERR_UNKNOWN;
                                ETHXCVR_DrvReportError(BCM_XVR_ID, aID,
                                BRCM_SWDSGN_ETHXCVR_DRVGETDUPLEXMODE_PROC,
                                retVal, *aDuplexMode, phyDuplex, 0UL, __LINE__);
                            }
                        } else {
                            *aDuplexMode = phyDuplex;
                        }
                    }
                }
            }
        }
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_ETHXCVR_DRVSETDUPLEXMODE_PROC
    @trace #BRCM_SWREQ_ETHXCVR_KERNEL_HANDLER
*/
int32_t ETHXCVR_DrvSetDuplexMode(ETHXCVR_IDType aID,
                                 ETHXCVR_DuplexModeType aDuplexMode)
{
    int32_t                      retVal;
    const ETHXCVR_FuncTblType    *phyFunc = NULL;
    const ETHXCVR_FuncTblType    *busFunc = NULL;
    const ETHXCVR_PortConfigType *config  = &ETHXCVR_DrvRWData[aID].xcvrCfg;
    ETHXCVR_CntxtType            *phyCntxt = NULL;

    if (ETHXCVR_BOOLEAN_TRUE == config->autoNeg) {
        retVal = BCM_ERR_NOPERM;
        goto done;
    }

    retVal = ETHXCVR_PlatformGetFnTblsCntxt(config, &busFunc, &phyFunc, &phyCntxt);

    if (BCM_ERR_OK == retVal) {
        if (ETHXCVR_STATE_UNINIT == ETHXCVR_DrvRWData[aID].xcvrState) {
            retVal = BCM_ERR_INVAL_STATE;
        } else {
            if (NULL != busFunc) {
                retVal = busFunc->setDuplexMode(config->bus.cntrlID, NULL, config, aDuplexMode);
            }
            if (((BCM_ERR_OK == retVal) || (BCM_ERR_NOSUPPORT == retVal)) && (NULL != phyFunc)) {
                retVal = phyFunc->setDuplexMode(config->phy.hwID, phyCntxt, config, aDuplexMode);
            }
            /* Update the configuration */
            if ((BCM_ERR_OK == retVal) || (BCM_ERR_NOSUPPORT == retVal)) {
                ETHXCVR_DrvRWData[aID].xcvrCfg.duplex = aDuplexMode;
            }
        }
    }

done:
    return retVal;
}

/**
    @trace #BRCM_SWARCH_ETHXCVR_DRVGETFLOWCONTROL_PROC
    @trace #BRCM_SWREQ_ETHXCVR_KERNEL_HANDLER
*/
int32_t ETHXCVR_DrvGetFlowControl(ETHXCVR_IDType aID,
                                 ETHXCVR_FlowControlType *const aFlowControl)
{
    int32_t                      retVal;
    const ETHXCVR_FuncTblType    *phyFunc = NULL;
    const ETHXCVR_FuncTblType    *busFunc = NULL;
    const ETHXCVR_PortConfigType *config  = &ETHXCVR_DrvRWData[aID].xcvrCfg;
    ETHXCVR_FlowControlType      phyFlowControl = ETHXCVR_FLOWCONTROL_NONE;
    ETHXCVR_CntxtType            *phyCntxt = NULL;

    retVal = ETHXCVR_PlatformGetFnTblsCntxt(config, &busFunc, &phyFunc, &phyCntxt);

    if (BCM_ERR_OK == retVal) {
        if (ETHXCVR_STATE_UNINIT == ETHXCVR_DrvRWData[aID].xcvrState) {
            retVal = BCM_ERR_INVAL_STATE;
        } else {
            if (NULL != busFunc) {
                retVal = busFunc->getFlowControl(config->bus.cntrlID, NULL, config, aFlowControl);
            }
            if (((BCM_ERR_OK == retVal) || (BCM_ERR_NOSUPPORT == retVal)) && (NULL != phyFunc)) {
                if (BCM_ERR_NOSUPPORT == retVal) {
                    retVal = phyFunc->getFlowControl(config->phy.hwID, phyCntxt, config, aFlowControl);
                } else {
                    retVal = phyFunc->getFlowControl(config->phy.hwID, phyCntxt, config, &phyFlowControl);
                    /* Check for mismatch between phy and bus */
                    if (BCM_ERR_OK == retVal) {
                        if (NULL != busFunc) {
                            if (*aFlowControl != phyFlowControl) {
                                retVal = BCM_ERR_UNKNOWN;
                                ETHXCVR_DrvReportError(BCM_XVR_ID, aID,
                                BRCM_SWDSGN_ETHXCVR_DRVGETFLOWCONTROL_PROC,
                                retVal, *aFlowControl, phyFlowControl, 0UL, __LINE__);
                            }
                        } else {
                            *aFlowControl = phyFlowControl;
                        }
                    }
                }
            }
        }
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_ETHXCVR_DRVSETFLOWCONTROL_PROC
    @trace #BRCM_SWREQ_ETHXCVR_KERNEL_HANDLER
*/
int32_t ETHXCVR_DrvSetFlowControl(ETHXCVR_IDType aID,
                                  ETHXCVR_FlowControlType aFlowControl)
{
    int32_t                      retVal;
    const ETHXCVR_FuncTblType    *phyFunc = NULL;
    const ETHXCVR_FuncTblType    *busFunc = NULL;
    const ETHXCVR_PortConfigType *config  = &ETHXCVR_DrvRWData[aID].xcvrCfg;
    ETHXCVR_CntxtType            *phyCntxt = NULL;

    if (ETHXCVR_BOOLEAN_TRUE == config->autoNeg) {
        retVal = BCM_ERR_NOPERM;
        goto done;
    }

    retVal = ETHXCVR_PlatformGetFnTblsCntxt(config, &busFunc, &phyFunc, &phyCntxt);

    if (BCM_ERR_OK == retVal) {
        if (ETHXCVR_STATE_UNINIT == ETHXCVR_DrvRWData[aID].xcvrState) {
            retVal = BCM_ERR_INVAL_STATE;
        } else {
            if (NULL != busFunc) {
                retVal = busFunc->setFlowControl(config->bus.cntrlID, NULL, config, aFlowControl);
            }
            if (((BCM_ERR_OK == retVal) || (BCM_ERR_NOSUPPORT == retVal)) && (NULL != phyFunc)) {
                retVal = phyFunc->setFlowControl(config->phy.hwID, phyCntxt, config, aFlowControl);
            }
            /* Update the configuration */
            if ((BCM_ERR_OK == retVal) || (BCM_ERR_NOSUPPORT == retVal)) {
                ETHXCVR_DrvRWData[aID].xcvrCfg.flowControl = aFlowControl;
            }
        }
    }

done:
    return retVal;
}

/**
    @trace #BRCM_SWARCH_ETHXCVR_DRVGETSQIVALUE_PROC
    @trace #BRCM_SWREQ_ETHXCVR_KERNEL_HANDLER
*/
int32_t ETHXCVR_DrvGetSQIValue(ETHXCVR_IDType aID,
                               uint32_t *const aSQIValue)
{
    int32_t                      retVal;
    const ETHXCVR_FuncTblType    *phyFunc = NULL;
    const ETHXCVR_FuncTblType    *busFunc = NULL;
    const ETHXCVR_PortConfigType *config  = &ETHXCVR_DrvRWData[aID].xcvrCfg;
    ETHXCVR_CntxtType            *phyCntxt = NULL;

    retVal = ETHXCVR_PlatformGetFnTblsCntxt(config, &busFunc, &phyFunc, &phyCntxt);

    if (BCM_ERR_OK == retVal) {
        if (ETHXCVR_STATE_UNINIT == ETHXCVR_DrvRWData[aID].xcvrState) {
            retVal = BCM_ERR_INVAL_STATE;
        } else {
            if (NULL != phyFunc) {
                retVal = phyFunc->getSQIValue(config->phy.hwID, phyCntxt, config, aSQIValue);
            } else {
                retVal = BCM_ERR_NOSUPPORT;
            }
        }
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_ETHXCVR_DRVSETMASTERMODE_PROC
    @trace #BRCM_SWREQ_ETHXCVR_KERNEL_HANDLER
*/
int32_t ETHXCVR_DrvSetMasterMode(ETHXCVR_IDType aID,
                                 ETHXCVR_BooleanType aMasterMode)
{
    int32_t                      retVal;
    const ETHXCVR_FuncTblType    *phyFunc = NULL;
    const ETHXCVR_FuncTblType    *busFunc = NULL;
    const ETHXCVR_PortConfigType *config  = &ETHXCVR_DrvRWData[aID].xcvrCfg;
    ETHXCVR_CntxtType            *phyCntxt = NULL;

    if (ETHXCVR_BOOLEAN_TRUE == config->autoNeg) {
        retVal = BCM_ERR_NOPERM;
        goto done;
    }

    retVal = ETHXCVR_PlatformGetFnTblsCntxt(config, &busFunc, &phyFunc, &phyCntxt);

    if (BCM_ERR_OK == retVal) {
        if (ETHXCVR_STATE_UNINIT == ETHXCVR_DrvRWData[aID].xcvrState) {
            retVal = BCM_ERR_INVAL_STATE;
        } else {
            if (NULL != phyFunc) {
                retVal = phyFunc->setMasterMode(config->phy.hwID, phyCntxt, config, aMasterMode);
                /* Update the configuration */
                if (BCM_ERR_OK == retVal) {
                    ETHXCVR_DrvRWData[aID].xcvrCfg.phy.masterMode = aMasterMode;
                }
            } else {
                retVal = BCM_ERR_NOSUPPORT;
            }
        }
    }

done:
    return retVal;
}

/**
    @trace #BRCM_SWARCH_ETHXCVR_DRVGETMASTERMODE_PROC
    @trace #BRCM_SWREQ_ETHXCVR_KERNEL_HANDLER
*/
int32_t ETHXCVR_DrvGetMasterMode(ETHXCVR_IDType aID,
                                 ETHXCVR_BooleanType *const aMasterMode)
{
    int32_t                      retVal;
    const ETHXCVR_FuncTblType    *phyFunc = NULL;
    const ETHXCVR_FuncTblType    *busFunc = NULL;
    const ETHXCVR_PortConfigType *config  = &ETHXCVR_DrvRWData[aID].xcvrCfg;
    ETHXCVR_CntxtType            *phyCntxt = NULL;

    retVal = ETHXCVR_PlatformGetFnTblsCntxt(config, &busFunc, &phyFunc, &phyCntxt);

    if (BCM_ERR_OK == retVal) {
        if (ETHXCVR_STATE_UNINIT == ETHXCVR_DrvRWData[aID].xcvrState) {
            retVal = BCM_ERR_INVAL_STATE;
        } else {
            if (NULL != phyFunc) {
                retVal = phyFunc->getMasterMode(config->phy.hwID, phyCntxt, config, aMasterMode);
            } else {
                retVal = BCM_ERR_NOSUPPORT;
            }
        }
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_ETHXCVR_DRVSETLOOPBACKMODE_PROC
    @trace #BRCM_SWREQ_ETHXCVR_KERNEL_HANDLER
*/
int32_t ETHXCVR_DrvSetLoopbackMode(ETHXCVR_IDType aID,
                                   ETHXCVR_BooleanType aMode)
{
    int32_t                      retVal;
    const ETHXCVR_FuncTblType    *phyFunc = NULL;
    const ETHXCVR_FuncTblType    *busFunc = NULL;
    const ETHXCVR_PortConfigType *config  = &ETHXCVR_DrvRWData[aID].xcvrCfg;
    ETHXCVR_CntxtType            *phyCntxt = NULL;

    retVal = ETHXCVR_PlatformGetFnTblsCntxt(config, &busFunc, &phyFunc, &phyCntxt);

    if (BCM_ERR_OK == retVal) {
        if (ETHXCVR_STATE_UNINIT == ETHXCVR_DrvRWData[aID].xcvrState) {
            retVal = BCM_ERR_INVAL_STATE;
        } else {
            if (NULL != phyFunc) {
                retVal = phyFunc->setLoopbackMode(config->phy.hwID, phyCntxt, config, aMode);
            } else if (NULL != busFunc) {
                retVal = busFunc->setLoopbackMode(config->bus.cntrlID, NULL, config, aMode);
            } else {
                retVal = BCM_ERR_NOSUPPORT;
            }
        }
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_ETHXCVR_DRVGETLOOPBACKMODE_PROC
    @trace #BRCM_SWREQ_ETHXCVR_KERNEL_HANDLER
*/
int32_t ETHXCVR_DrvGetLoopbackMode(ETHXCVR_IDType aID,
                                   ETHXCVR_BooleanType *const aMode)
{
    int32_t                      retVal;
    const ETHXCVR_FuncTblType    *phyFunc = NULL;
    const ETHXCVR_FuncTblType    *busFunc = NULL;
    const ETHXCVR_PortConfigType *config  = &ETHXCVR_DrvRWData[aID].xcvrCfg;
    ETHXCVR_CntxtType            *phyCntxt = NULL;

    retVal = ETHXCVR_PlatformGetFnTblsCntxt(config, &busFunc, &phyFunc, &phyCntxt);

    if (BCM_ERR_OK == retVal) {
        if (ETHXCVR_STATE_UNINIT == ETHXCVR_DrvRWData[aID].xcvrState) {
            retVal = BCM_ERR_INVAL_STATE;
        } else {
            if (NULL != phyFunc) {
                retVal = phyFunc->getLoopbackMode(config->phy.hwID, phyCntxt, config, aMode);
            } else if (NULL != busFunc) {
                retVal = busFunc->getLoopbackMode(config->bus.cntrlID, NULL, config, aMode);
            } else {
                retVal = BCM_ERR_NOSUPPORT;
            }
        }
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_ETHXCVR_DRVSETJUMBOMODE_PROC
    @trace #BRCM_SWREQ_ETHXCVR_KERNEL_HANDLER
*/
int32_t ETHXCVR_DrvSetJumboMode(ETHXCVR_IDType aID,
                                ETHXCVR_BooleanType aMode)
{
    int32_t                      retVal;
    const ETHXCVR_FuncTblType    *phyFunc = NULL;
    const ETHXCVR_FuncTblType    *busFunc = NULL;
    const ETHXCVR_PortConfigType *config  = &ETHXCVR_DrvRWData[aID].xcvrCfg;
    ETHXCVR_CntxtType            *phyCntxt = NULL;

    retVal = ETHXCVR_PlatformGetFnTblsCntxt(config, &busFunc, &phyFunc, &phyCntxt);

    if (BCM_ERR_OK == retVal) {
        if (ETHXCVR_STATE_UNINIT == ETHXCVR_DrvRWData[aID].xcvrState) {
            retVal = BCM_ERR_INVAL_STATE;
        } else {
            if (NULL != busFunc) {
                retVal = busFunc->setJumboMode(config->bus.cntrlID, NULL, config, aMode);
            }
            if (((BCM_ERR_OK == retVal) || (BCM_ERR_NOSUPPORT == retVal)) && (NULL != phyFunc)) {
                retVal = phyFunc->setJumboMode(config->phy.hwID, phyCntxt, config, aMode);
            }
            /* Update the configuration */
            if ((BCM_ERR_OK == retVal) || (BCM_ERR_NOSUPPORT == retVal)) {
                ETHXCVR_DrvRWData[aID].xcvrCfg.jumbo = aMode;
            }
        }
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_ETHXCVR_DRVGETJUMBOMODE_PROC
    @trace #BRCM_SWREQ_ETHXCVR_KERNEL_HANDLER
*/
int32_t ETHXCVR_DrvGetJumboMode(ETHXCVR_IDType aID,
                                ETHXCVR_BooleanType *const aMode)
{
    int32_t                      retVal;
    const ETHXCVR_FuncTblType    *phyFunc = NULL;
    const ETHXCVR_FuncTblType    *busFunc = NULL;
    const ETHXCVR_PortConfigType *config  = &ETHXCVR_DrvRWData[aID].xcvrCfg;
    ETHXCVR_BooleanType          phyJumbo = ETHXCVR_BOOLEAN_FALSE;
    ETHXCVR_CntxtType            *phyCntxt = NULL;

    retVal = ETHXCVR_PlatformGetFnTblsCntxt(config, &busFunc, &phyFunc, &phyCntxt);

    if (BCM_ERR_OK == retVal) {
        if (ETHXCVR_STATE_UNINIT == ETHXCVR_DrvRWData[aID].xcvrState) {
            retVal = BCM_ERR_INVAL_STATE;
        } else {
            if (NULL != busFunc) {
                retVal = busFunc->getJumboMode(config->bus.cntrlID, NULL, config, aMode);
            }
            if (((BCM_ERR_OK == retVal) || (BCM_ERR_NOSUPPORT == retVal)) && (NULL != phyFunc)) {
                if (BCM_ERR_NOSUPPORT == retVal) {
                    retVal = phyFunc->getJumboMode(config->phy.hwID, phyCntxt, config, aMode);
                } else {
                    retVal = phyFunc->getJumboMode(config->phy.hwID, phyCntxt, config, &phyJumbo);
                    /* Check for mismatch between phy and bus */
                    if (BCM_ERR_OK == retVal) {
                        if (NULL != busFunc) {
                            if (*aMode != phyJumbo) {
                                retVal = BCM_ERR_UNKNOWN;
                                ETHXCVR_DrvReportError(BCM_XVR_ID, aID,
                                BRCM_SWDSGN_ETHXCVR_DRVGETJUMBOMODE_PROC,
                                retVal, *aMode, phyJumbo, 0UL, __LINE__);
                            }
                        } else {
                            *aMode = phyJumbo;
                        }
                    }
                }
            }
        }
    }

    return retVal;
}

/**
    @brief Set Wakeup Mode on the PHY of port

    @trace #BRCM_SWARCH_ETHXCVR_DRVSETWAKEUPMODE_PROC
    @trace #BRCM_SWREQ_ETHXCVR_KERNEL_HANDLER

    @code{.c}
    Get the Function Pointer of PHY Function
    retVal is ETHXCVR_PlatformGetFnTblsCntxt(config, &busFunc, &phyFunc, &phyCntxt)
    if BCM_ERR_OK is retVal
        if ETHXCVR_STATE_UNINIT is xcvrState
            retVal is BCM_ERR_INVAL_STATE
        else
            if NULL is not phyFunc
                retVal is setWakeUpMode(config->phy.hwID, phyCntxt, config, aMode)
            else
                retVal is BCM_ERR_NOSUPPORT
    return retVal
    @endcode
*/
int32_t ETHXCVR_DrvSetWakeUpMode(ETHXCVR_IDType aID,
                                   ETHXCVR_BooleanType aMode)
{
    int32_t                      retVal;
    const ETHXCVR_FuncTblType    *phyFunc = NULL;
    const ETHXCVR_FuncTblType    *busFunc = NULL;
    const ETHXCVR_PortConfigType *config  = &ETHXCVR_DrvRWData[aID].xcvrCfg;
    ETHXCVR_CntxtType            *phyCntxt = NULL;

    retVal = ETHXCVR_PlatformGetFnTblsCntxt(config, &busFunc, &phyFunc, &phyCntxt);

    if (BCM_ERR_OK == retVal) {
        if (ETHXCVR_STATE_UNINIT == ETHXCVR_DrvRWData[aID].xcvrState) {
            retVal = BCM_ERR_INVAL_STATE;
        } else {
            if (NULL != phyFunc) {
                retVal = phyFunc->setWakeUpMode(config->phy.hwID, phyCntxt, config, aMode);
            } else {
                retVal = BCM_ERR_NOSUPPORT;
            }
        }
    }

    return retVal;
}

 /**
    @brief Get Wakeup Mode on the PHY of port

    @trace #BRCM_SWARCH_ETHXCVR_DRVGETWAKEUPMODE_PROC
    @trace #BRCM_SWREQ_ETHXCVR_KERNEL_HANDLER

    @code{.c}
    Get the Function Pointer of PHY Function
    retVal is ETHXCVR_PlatformGetFnTblsCntxt(config, &busFunc, &phyFunc, &phyCntxt)
    if BCM_ERR_OK is retVal
        if ETHXCVR_STATE_UNINIT is xcvrState
            retVal is BCM_ERR_INVAL_STATE
        else
            if NULL is not phyFunc
                retVal is getWakeUpMode(config->phy.hwID, phyCntxt, config, aMode)
            else
                retVal is BCM_ERR_NOSUPPORT
    return retVal
    @endcode
*/
int32_t ETHXCVR_DrvGetWakeUpMode(ETHXCVR_IDType aID,
                                   ETHXCVR_BooleanType *const aMode)
{
    int32_t                      retVal;
    const ETHXCVR_FuncTblType    *phyFunc = NULL;
    const ETHXCVR_FuncTblType    *busFunc = NULL;
    const ETHXCVR_PortConfigType *config  = &ETHXCVR_DrvRWData[aID].xcvrCfg;
    ETHXCVR_CntxtType            *phyCntxt = NULL;

    retVal = ETHXCVR_PlatformGetFnTblsCntxt(config, &busFunc, &phyFunc, &phyCntxt);

    if (BCM_ERR_OK == retVal) {
        if (ETHXCVR_STATE_UNINIT == ETHXCVR_DrvRWData[aID].xcvrState) {
            retVal = BCM_ERR_INVAL_STATE;
        } else {
            if (NULL != phyFunc) {
                retVal = phyFunc->getWakeUpMode(config->phy.hwID, phyCntxt, config, aMode);
            } else {
                retVal = BCM_ERR_NOSUPPORT;
            }
        }
    }

    return retVal;
}

/**
    @brief Get Wakeup Reason on the PHY of port

    @trace #BRCM_SWARCH_ETHXCVR_DRVGETWAKEUPREASON_PROC
    @trace #BRCM_SWREQ_ETHXCVR_KERNEL_HANDLER

    @code{.c}
    Get the Function Pointer of PHY Function
    retVal is ETHXCVR_PlatformGetFnTblsCntxt(config, &busFunc, &phyFunc, &phyCntxt)
    if BCM_ERR_OK is retVal
        if ETHXCVR_STATE_UNINIT is xcvrState
            retVal is BCM_ERR_INVAL_STATE
        else
            if NULL is not phyFunc
                retVal is getWakeUpReason(config->phy.hwID, phyCntxt, config, aReason)
            else
                retVal is BCM_ERR_NOSUPPORT
    return retVal
    @endcode
*/
int32_t ETHXCVR_DrvGetWakeUpReason (ETHXCVR_IDType aID,
                                     ETHXCVR_WakeupReasonType *const aReason)
{
    int32_t                      retVal;
    const ETHXCVR_FuncTblType    *phyFunc = NULL;
    const ETHXCVR_FuncTblType    *busFunc = NULL;
    const ETHXCVR_PortConfigType *config  = &ETHXCVR_DrvRWData[aID].xcvrCfg;
    ETHXCVR_CntxtType            *phyCntxt = NULL;

    retVal = ETHXCVR_PlatformGetFnTblsCntxt(config, &busFunc, &phyFunc, &phyCntxt);

    if (BCM_ERR_OK == retVal) {
        if (ETHXCVR_STATE_UNINIT == ETHXCVR_DrvRWData[aID].xcvrState) {
            retVal = BCM_ERR_INVAL_STATE;
        } else {
            if (NULL != phyFunc) {
                retVal = phyFunc->getWakeUpReason(config->phy.hwID, phyCntxt, config, aReason);
            } else {
                retVal = BCM_ERR_NOSUPPORT;
            }
        }
    }

    return retVal;
}


/**
    @trace #BRCM_SWARCH_ETHXCVR_DRVSETAUTONEGMODE_PROC
    @trace #BRCM_SWREQ_ETHXCVR_KERNEL_HANDLER
*/
int32_t ETHXCVR_DrvSetAutoNegMode(ETHXCVR_IDType aID, ETHXCVR_BooleanType aMode)
{
    int32_t                      retVal;
    const ETHXCVR_FuncTblType    *phyFunc = NULL;
    const ETHXCVR_FuncTblType    *busFunc = NULL;
    const ETHXCVR_PortConfigType *config  = &ETHXCVR_DrvRWData[aID].xcvrCfg;
    ETHXCVR_CntxtType            *phyCntxt = NULL;

    retVal = ETHXCVR_PlatformGetFnTblsCntxt(config, &busFunc, &phyFunc, &phyCntxt);

    if (BCM_ERR_OK == retVal) {
        if (ETHXCVR_STATE_UNINIT == ETHXCVR_DrvRWData[aID].xcvrState) {
            retVal = BCM_ERR_INVAL_STATE;
        } else {
            if (NULL != phyFunc) {
                retVal = phyFunc->setAutoNegMode(config->phy.hwID, phyCntxt, config, aMode);
            }
            if (((BCM_ERR_OK == retVal) || (BCM_ERR_NOSUPPORT == retVal)) && (NULL != busFunc)) {
                retVal = busFunc->setAutoNegMode(config->bus.cntrlID, NULL, config, aMode);
            }
            /* Update the configuration */
            if ((BCM_ERR_OK == retVal) || (BCM_ERR_NOSUPPORT == retVal)) {
                ETHXCVR_DrvRWData[aID].xcvrCfg.autoNeg = aMode;
            }
        }
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_ETHXCVR_DRVGETAUTONEGSTATUS_PROC
    @trace #BRCM_SWREQ_ETHXCVR_KERNEL_HANDLER
*/
int32_t ETHXCVR_DrvGetAutoNegStatus(ETHXCVR_IDType aID,
                                    ETHXCVR_AutoNegStatusType *const aStatus)
{
    int32_t                      retVal;
    const ETHXCVR_FuncTblType    *phyFunc = NULL;
    const ETHXCVR_FuncTblType    *busFunc = NULL;
    const ETHXCVR_PortConfigType *config  = &ETHXCVR_DrvRWData[aID].xcvrCfg;
    ETHXCVR_CntxtType            *phyCntxt = NULL;

    retVal = ETHXCVR_PlatformGetFnTblsCntxt(config, &busFunc, &phyFunc, &phyCntxt);

    if (BCM_ERR_OK == retVal) {
        if (ETHXCVR_STATE_UNINIT == ETHXCVR_DrvRWData[aID].xcvrState) {
            retVal = BCM_ERR_INVAL_STATE;
        } else {
            ETHXCVR_AutoNegStatusType autoNegStatus = ETHXCVR_AUTONEGSTATUS_COMPLETE;
            *aStatus = ETHXCVR_AUTONEGSTATUS_INCOMPLETE;
            if (NULL != phyFunc) {
                retVal = phyFunc->getAutoNegStatus(config->phy.hwID, phyCntxt, config, &autoNegStatus);
            }
            if ((BCM_ERR_OK == retVal) && (NULL != busFunc)) {
                retVal = busFunc->getAutoNegStatus(config->bus.cntrlID, NULL, config, aStatus);
            }
            /* Report down if any one of the status is down. Do not report error */
            if (BCM_ERR_OK == retVal) {
                /* If Bus And PHY COMPLETE OR PHY Complete and Bus Not Present */
                if (((ETHXCVR_AUTONEGSTATUS_COMPLETE == autoNegStatus)
                        && (ETHXCVR_AUTONEGSTATUS_COMPLETE == *aStatus))
                     || ((ETHXCVR_AUTONEGSTATUS_COMPLETE == autoNegStatus)
                        && (NULL == busFunc))) {
                    *aStatus = ETHXCVR_AUTONEGSTATUS_COMPLETE;
                } else if ((ETHXCVR_AUTONEGSTATUS_NO_ABILITY == autoNegStatus)
                            || (ETHXCVR_AUTONEGSTATUS_NO_ABILITY == *aStatus)){
                    *aStatus = ETHXCVR_AUTONEGSTATUS_NO_ABILITY;
                } else { /* If all cases fails */
                    *aStatus = ETHXCVR_AUTONEGSTATUS_INCOMPLETE;
                }
            }
        }
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_ETHXCVR_DRVRESTARTAUTONEG_PROC
    @trace #BRCM_SWREQ_ETHXCVR_KERNEL_HANDLER
*/
int32_t ETHXCVR_DrvRestartAutoNeg(ETHXCVR_IDType aID)
{
    int32_t                      retVal;
    const ETHXCVR_FuncTblType    *phyFunc = NULL;
    const ETHXCVR_FuncTblType    *busFunc = NULL;
    const ETHXCVR_PortConfigType *config  = &ETHXCVR_DrvRWData[aID].xcvrCfg;
    ETHXCVR_CntxtType            *phyCntxt = NULL;

    retVal = ETHXCVR_PlatformGetFnTblsCntxt(config, &busFunc, &phyFunc, &phyCntxt);

    if (BCM_ERR_OK == retVal) {
        if (ETHXCVR_STATE_UNINIT == ETHXCVR_DrvRWData[aID].xcvrState) {
            retVal = BCM_ERR_INVAL_STATE;
        } else {
            if (config->autoNeg == ETHXCVR_BOOLEAN_TRUE) {
                if (NULL != phyFunc) {
                    retVal = phyFunc->restartAutoNeg(config->phy.hwID, phyCntxt, config);
                } else if (NULL != busFunc) {
                    retVal = busFunc->restartAutoNeg(config->bus.cntrlID, NULL, config);
                } else {
                    retVal = BCM_ERR_NOSUPPORT;
                }
            } else {
                retVal = BCM_ERR_NOSUPPORT;
            }
        }
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_ETHXCVR_DRVGETSTATS_PROC
    @trace #BRCM_SWREQ_ETHXCVR_KERNEL_HANDLER
*/
int32_t ETHXCVR_DrvGetStats(ETHXCVR_IDType aID,
                            ETHXCVR_StatsType *const aStats)
{
    int32_t                      retVal;
    const ETHXCVR_FuncTblType    *phyFunc = NULL;
    const ETHXCVR_FuncTblType    *busFunc = NULL;
    const ETHXCVR_PortConfigType *config  = &ETHXCVR_DrvRWData[aID].xcvrCfg;
    ETHXCVR_CntxtType            *phyCntxt = NULL;

    retVal = ETHXCVR_PlatformGetFnTblsCntxt(config, &busFunc, &phyFunc, &phyCntxt);

    if (BCM_ERR_OK == retVal) {
        if (ETHXCVR_STATE_UNINIT == ETHXCVR_DrvRWData[aID].xcvrState) {
            retVal = BCM_ERR_INVAL_STATE;
        } else {
            if (NULL != phyFunc) {
                retVal = phyFunc->getStats(config->phy.hwID, phyCntxt, config, aStats);
            } else if (NULL != busFunc) {
                retVal = busFunc->getStats(config->bus.cntrlID, NULL, config, aStats);
            } else {
                retVal = BCM_ERR_NOSUPPORT;
            }
        }
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_ETHXCVR_DRVSTATEHANDLER_PROC
    @trace #BRCM_SWREQ_ETHXCVR_KERNEL_HANDLER
*/
int32_t ETHXCVR_DrvStateHandler(ETHXCVR_IDType aID,
                                uint32_t *const aIsModeChanged,
                                ETHXCVR_ModeType *const aMode)
{
    int32_t                      retVal   = BCM_ERR_OK;
    const ETHXCVR_FuncTblType    *phyFunc = NULL;
    const ETHXCVR_FuncTblType    *busFunc = NULL;
    const ETHXCVR_PortConfigType *config  = &ETHXCVR_DrvRWData[aID].xcvrCfg;
    ETHXCVR_CntxtType            *phyCntxt = NULL;

    retVal = ETHXCVR_PlatformGetFnTblsCntxt(config, &busFunc, &phyFunc, &phyCntxt);

    if (BCM_ERR_OK == retVal) {
        if (ETHXCVR_STATE_UNINIT == ETHXCVR_DrvRWData[aID].xcvrState) {
            retVal = BCM_ERR_INVAL_STATE;
        } else {
            if ((NULL != phyFunc) && (config->phy.accessMode != ETHXCVR_ACCESSMODE_MMAP)) {
                retVal = phyFunc->stateHandler(config->phy.hwID, phyCntxt, config, aIsModeChanged, aMode);
            }
        }
    }
    return retVal;
}

/**
    @trace #BRCM_SWARCH_ETHXCVR_DRVUPDATEHWSTATUS_PROC
    @trace #BRCM_SWREQ_ETHXCVR_KERNEL_HANDLER
*/
int32_t ETHXCVR_DrvUpdateHWStatus(ETHXCVR_IDType aID)
{
    int32_t                      retVal   = BCM_ERR_OK;
    const ETHXCVR_FuncTblType    *phyFunc = NULL;
    const ETHXCVR_FuncTblType    *busFunc = NULL;
    const ETHXCVR_PortConfigType *config  = &ETHXCVR_DrvRWData[aID].xcvrCfg;
    ETHXCVR_CntxtType            *phyCntxt = NULL;

    retVal = ETHXCVR_PlatformGetFnTblsCntxt(config, &busFunc, &phyFunc, &phyCntxt);

    if (BCM_ERR_OK == retVal) {
        if (ETHXCVR_STATE_UNINIT == ETHXCVR_DrvRWData[aID].xcvrState) {
            retVal = BCM_ERR_INVAL_STATE;
        } else {
            if (NULL != phyFunc) {
                retVal = phyFunc->updateHWStatus(config->phy.hwID, phyCntxt, config);
            } else {
                retVal = BCM_ERR_NOSUPPORT;
            }
        }
    }
    return retVal;
}

/**
    @trace #BRCM_SWARCH_ETHXCVR_DRVLINKIRQHANDLER_PROC
    @trace #BRCM_SWREQ_ETHXCVR_KERNEL_HANDLER
*/
int32_t ETHXCVR_DrvLinkIRQHandler(ETHXCVR_IDType aID)
{
    int32_t                      retVal;
    const ETHXCVR_FuncTblType    *phyFunc = NULL;
    const ETHXCVR_FuncTblType    *busFunc = NULL;
    const ETHXCVR_PortConfigType *config  = &ETHXCVR_DrvRWData[aID].xcvrCfg;
    ETHXCVR_CntxtType            *phyCntxt = NULL;

    retVal = ETHXCVR_PlatformGetFnTblsCntxt(config, &busFunc, &phyFunc, &phyCntxt);

    if (BCM_ERR_OK == retVal) {
        if (ETHXCVR_STATE_UNINIT == ETHXCVR_DrvRWData[aID].xcvrState) {
            retVal = BCM_ERR_INVAL_STATE;
        } else {
            if (NULL != phyFunc) {
                retVal = phyFunc->linkIRQHandler(config->phy.hwID, phyCntxt, config);
            } else {
                retVal = BCM_ERR_NOSUPPORT;
            }
        }
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_ETHXCVR_DRVLINKCHGINDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHXCVR_KERNEL_HANDLER
*/
int32_t ETHXCVR_DrvLinkChgIndHandler(ETHXCVR_IDType aID,
                                     ETHXCVR_LinkStateType *const aLinkState,
                                     uint32_t *const aIsLinkStateChanged)
{
    int32_t                      retVal;
    const ETHXCVR_FuncTblType    *phyFunc = NULL;
    const ETHXCVR_FuncTblType    *busFunc = NULL;
    const ETHXCVR_PortConfigType *config  = &ETHXCVR_DrvRWData[aID].xcvrCfg;
    ETHXCVR_CntxtType            *phyCntxt = NULL;

    retVal = ETHXCVR_PlatformGetFnTblsCntxt(config, &busFunc, &phyFunc, &phyCntxt);

    if (BCM_ERR_OK == retVal) {
        if (ETHXCVR_STATE_UNINIT == ETHXCVR_DrvRWData[aID].xcvrState) {
            retVal = BCM_ERR_INVAL_STATE;
        } else {
            if (NULL != phyFunc) {
                retVal = phyFunc->linkChangeIndHandler(config->phy.hwID, phyCntxt, config, aLinkState, aIsLinkStateChanged);
            } else {
                retVal = BCM_ERR_NOSUPPORT;
            }
        }
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_ETHXCVR_DRVGETPORTCONFIG_PROC
    @trace #BRCM_SWREQ_ETHXCVR_KERNEL_HANDLER
*/
int32_t ETHXCVR_DrvGetPortConfig(ETHXCVR_IDType aID,
                              ETHXCVR_PortConfigType *const aConfig)
{
    BCM_MemCpy(aConfig, &ETHXCVR_DrvRWData[aID].xcvrCfg, sizeof(ETHXCVR_PortConfigType));
    return BCM_ERR_OK;
}

/** @} */
